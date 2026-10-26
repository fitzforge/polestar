//! Emitted Lua (tools/lib/dsl/emit.js): the pack loads under Lua 5.1 next to Core/Init.lua and round-trips to
//! the compiled structure. The compile and lint commands are forge's (rust/crates/forge/tests/guide_cli.rs).

use forge_addontest::dsl::{compile, fixture_data, guide_text, our_manifest, plain, write_our_test_pack, write_test_pack, TestPack};
use forge_addontest::run::root;
use forge_addontest::{emitted, is_match, Addon, RunAddon};
use forge_guide::diag::Diagnostics;
use forge_guide::emit::pack_spots;
use forge_guide::js::parse_json;
use forge_guide::project::{compile_sources, find_guide_files, read_sources, CompileOpts};
use forge_guide::tokens::fill_tokens;
use serde_json::{json, Value};
use std::path::Path;

const LOAD_HEAD: &str = r#"
			local packs, guides, frames = {}, {}, {}
			Polestar.RegisterPack = function(m) packs[#packs + 1] = m end
			Polestar.RegisterGuide = function(g) guides[#guides + 1] = g; return true end
			Polestar.RegisterMapFrames = function(f, p) frames[#frames + 1] = { frames = f, pack = p } end
			local ns = {}
			for _, f in ipairs({ "#;

const LOAD_TAIL: &str = r#" }) do
				local chunk = assert(loadfile(f))
				chunk("Polestar_Guides", ns)
			end
			emit({ packs = packs, guides = guides, frames = frames, globals = { ADDON = rawget(_G, "ADDON") == nil, ns = rawget(_G, "ns") == nil } })"#;

// Load a pack folder the way the client does (its TOC's files in order) with Core/Init.lua and stand-ins for
// the registration functions; return what got registered.
fn load_pack(pack: &TestPack) -> Value {
	let files: Vec<String> = pack.scripts.iter().map(|f| serde_json::to_string(f).unwrap()).collect();
	emitted(&RunAddon { addons: vec![Addon::files("Polestar", &["Core/Init.lua"])], script: format!("{LOAD_HEAD}{}{LOAD_TAIL}", files.join(", ")), ..Default::default() }).remove(0)
}

fn rel(base: &Path, p: &Path) -> String {
	p.strip_prefix(base).unwrap().to_string_lossy().replace('\\', "/")
}

fn read_tree(base: &Path, dir: &Path, out: &mut Vec<String>) {
	for e in std::fs::read_dir(dir).unwrap() {
		let e = e.unwrap();
		let p = e.path();
		if e.file_type().unwrap().is_dir() {
			read_tree(base, &p, out);
		} else {
			out.push(rel(base, &p));
		}
	}
}

// A compiled guide as Polestar's own pack writes it (format 8): each goal's spawn spots as one string.
fn packed(mut g: Value) -> Value {
	for step in g["steps"].as_array_mut().into_iter().flatten() {
		for goal in step["goals"].as_array_mut().into_iter().flatten() {
			if let Some(spots) = goal.as_object_mut().and_then(|o| o.remove("spots")) {
				goal["spotsPacked"] = Value::String(pack_spots(&parse_json(&spots.to_string()).unwrap()));
			}
		}
	}
	g
}

#[test]
fn the_compiled_pack_loads_under_lua_5_1_with_core_init_lua_and_round_trips_to_the_compiled_structure() {
	let manifest = our_manifest();
	let guides_dir = root().join("tests/fixtures/dsl/guides");
	let data = fixture_data();
	let sources = read_sources(&guides_dir, &find_guide_files(&guides_dir, false));
	let mut diag = Diagnostics::new();
	let opts = CompileOpts { pack: Some(manifest.get("id").to_js_string()), author: None, context: None, pack_dir: Some(guides_dir.clone()) };
	let guides = compile_sources(&sources, &data, &mut diag, &opts).guides;
	assert!(!diag.has_errors());
	let pack = write_test_pack(&guides, &data, &manifest);
	let loaded = load_pack(&pack);
	assert_eq!(
		loaded["packs"],
		json!([{
			"addon": "Polestar_Guides",
			"id": "guides",
			"format": 8,
			"title": "Polestar Guides",
			"author": "Polestar",
			"version": manifest.get("version").to_js_string(),
			"license": "GPL-3.0-only",
			"notes": "Leveling, profession, reputation and collectible guides for Polestar.",
		}])
	);
	// Guides.lua and the faction part hold the guides as compiled, their texts with name tokens (tokens.js),
	// their spawn spots packed.
	assert_eq!(loaded["guides"], Value::Array(guides.iter().map(|g| packed(plain(&g.hidden("_localised")))).collect()));
	let ids: Vec<Value> = loaded["guides"].as_array().unwrap().iter().map(|g| g["id"].clone()).collect();
	assert_eq!(Value::Array(ids), json!(["forever/alliance/human/01-northshire", "forever/alliance/human/02-elwynn"]));
	let packs: Vec<Value> = loaded["guides"].as_array().unwrap().iter().map(|g| g["pack"].clone()).collect();
	assert_eq!(Value::Array(packs), json!(["guides", "guides"]));
	// Era bounds only for maps the guides reference (all fixture goals are in Elwynn Forest).
	assert_eq!(loaded["frames"], json!([{ "frames": { "era": { "1429": { "c": 1415, "left": 1535.4166, "right": -1941.6666, "top": 1300, "bottom": -1060.4166 } } }, "pack": "guides" }]));
	// Files leak no globals beyond Polestar's registration calls.
	assert_eq!(loaded["globals"], json!({ "ADDON": true, "ns": true }));
	// The TOC lists every Lua file in the folder, Pack.lua first (then the faction part's Guides.lua).
	let mut tree = Vec::new();
	read_tree(&pack.dir, &pack.dir, &mut tree);
	let mut lua: Vec<String> = tree.into_iter().filter(|f| f.ends_with(".lua")).collect();
	lua.sort();
	let mut files: Vec<String> = pack.scripts.iter().map(|f| rel(&pack.dir, f)).filter(|f| !f.starts_with("../")).collect();
	files.sort();
	assert_eq!(files, lua);
	assert_eq!(pack.scripts[0].file_name().unwrap().to_str().unwrap(), "Pack.lua");
	let license = std::fs::read_to_string(pack.dir.join("LICENSE-DATA.txt")).unwrap();
	assert!(is_match(&license, r"pfQuest[\s\S]*MIT License[\s\S]*Copyright \(c\) 2017-2021 Eric Mauser \(Shagu\)"));
}

#[test]
fn strings_with_quotes_backslashes_control_characters_and_utf_8_survive_the_trip_through_lua() {
	let tricky = "Say \"hi\" \\ to Ünïcödé ✓\tTab";
	let lines: Vec<String> = vec![
		"guide t/strings".into(),
		format!("title {tricky}"),
		"levels 1-2".into(),
		"zone Elwynn Forest".into(),
		"".into(),
		format!("step {tricky}"),
		"  tip First line.".into(),
		"  tip ]] [[ --[[ not a comment".into(),
		format!("  accept 424243 \"{}\" -- note with \"quotes\" and \\ backslash", tricky.replace('\\', "\\\\").replace('"', "\\\"")),
		"  note \"x\ty\" r 7.25 @12.345,0.005".into(),
	];
	let refs: Vec<&str> = lines.iter().map(String::as_str).collect();
	let src = guide_text(&refs);
	let r = compile(&src);
	assert_eq!(r.errors, Vec::<String>::new());
	let pack = write_our_test_pack(&r.guides);
	let loaded = load_pack(&pack);
	assert_eq!(loaded["guides"], Value::Array(r.guides.iter().map(|x| plain(&x.hidden("_localised"))).collect()));
	let g = &loaded["guides"][0];
	let names = parse_json(&g["names"].to_string()).unwrap();
	// The title names the quest: a token, its English in `names`.
	assert_eq!(fill_tokens(g["title"].as_str().unwrap(), &names), tricky);
	assert_eq!(fill_tokens(g["steps"][0]["title"].as_str().unwrap(), &names), tricky);
	assert_eq!(g["steps"][0]["note"], "First line.\n]] [[ --[[ not a comment");
	assert_eq!(g["steps"][0]["goals"][0]["title"], tricky);
	assert_eq!(g["steps"][0]["goals"][0]["note"], r#"note with "quotes" and \ backslash"#);
	// Coordinates are stored with two decimals.
	let goal = &g["steps"][0]["goals"][1];
	assert_eq!(json!([goal["x"], goal["y"], goal["r"]]), json!([12.35, 0.01, 7.25]));
}

#[test]
fn folder_keywords_and_collects_compile_into_the_guide_table_and_load_in_the_addon() {
	let src = guide_text(&[
		"guide t/folder",
		"title Horse",
		"category Collectibles",
		"folder Mounts · Level 40",
		"keywords Pinto Bridle, Chestnut Mare",
		"collects 2414, 5655",
		"levels 40-40",
		"zone Elwynn Forest",
		"",
		"step S",
		"  level 40",
	]);
	let r = compile(&src);
	assert_eq!(r.errors, Vec::<String>::new());
	let g = plain(&r.guides[0]);
	assert_eq!(g["folder"], "Mounts · Level 40");
	assert_eq!(g["keywords"], json!(["Pinto Bridle", "Chestnut Mare"]));
	assert_eq!(g["collects"], json!([2414, 5655]));
	let pack = write_our_test_pack(&r.guides);
	assert_eq!(load_pack(&pack)["guides"], Value::Array(r.guides.iter().map(plain).collect()));
}
