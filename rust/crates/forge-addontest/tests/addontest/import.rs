//! Import strings in the addon (addon/Polestar/Core/Import.lua and the registry's `imported` pack in
//! Core/Guides.lua): a guide compiled by the real compiler, written by the real writer (forge_guide's port of
//! tools/lib/pack/importstring.js), read back under Lua 5.1 with the client's decoders faked in plain Lua
//! (tests/lua/stub_encoding.lua). Round trip, refusals that leave SavedVariables untouched, update in place,
//! delete, login, suggestions.

use forge_addontest::dsl::{fixture_data, plain};
use forge_addontest::{emitted, is_match, lua_value, text, Addon, RunAddon};
use forge_guide::diag::Diagnostics;
use forge_guide::emit::{emit_guides, guide_data, list_keys, GOAL_KEYS, GUIDE_KEYS, IMAGE_KEYS, ONLY_KEYS, STEP_KEYS, WHEN_KEYS};
use forge_guide::importstring::{adler32, encode_import, import_string, LIMITS};
use forge_guide::js::{parse_json, V};
use forge_guide::project::{compile_sources, CompileOpts, Source};
use serde_json::{json, Value};

const GUIDE: &str = "guide yendi/northshire
title Northshire Valley
faction Alliance
levels 1-6
zone Elwynn Forest
version 1

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
  accept 7

step Kobold camp
  goto 47.6,35.1 \"Kobold camp\"
  kill 6 x10 quest 7.1

step Back to the abbey
  turnin 7
";

fn compile_guide(src: &str) -> V {
	let mut diag = Diagnostics::new();
	let opts = CompileOpts { pack: Some("yendi".into()), author: Some("Yendi".into()), context: None, pack_dir: None };
	let sources = [Source { source: String::new(), file: "northshire.guide".into(), text: src.into() }];
	let c = compile_sources(&sources, &fixture_data(), &mut diag, &opts);
	let errors: Vec<String> = diag.errors().iter().map(|d| d.message.clone()).collect();
	assert_eq!(errors, Vec::<String>::new());
	c.guides[0].clone()
}

fn guide() -> V {
	compile_guide(GUIDE)
}

fn localised(g: &V) -> V {
	let l = g.hidden("_localised");
	if l.truthy() {
		l
	} else {
		g.clone()
	}
}

fn manifest() -> V {
	parse_json(r#"{"id":"yendi","license":"CC-BY-4.0"}"#).unwrap()
}

fn import_of(g: &V) -> String {
	import_string(g, &manifest(), Some(fixture_data().as_ref())).unwrap_or_else(|e| panic!("{e}")).0
}

fn string() -> String {
	import_of(&guide())
}

// The payload the writer puts in the string, for strings made by hand.
fn payload() -> Value {
	json!({ "format": 3, "license": "CC-BY-4.0", "guide": plain(&guide_data(&localised(&guide()))) })
}

fn encode(p: &Value) -> String {
	encode_import(&parse_json(&p.to_string()).unwrap())
}

// A zlib stream (fixed Huffman codes; runs of one byte as length-258 matches at distance 1).
struct Bits {
	out: Vec<u8>,
	acc: u8,
	n: u32,
}

impl Bits {
	fn put(&mut self, v: u32, len: u32) {
		for i in 0..len {
			self.acc |= (((v >> i) & 1) as u8) << self.n;
			self.n += 1;
			if self.n == 8 {
				self.out.push(self.acc);
				self.acc = 0;
				self.n = 0;
			}
		}
	}
	fn huff(&mut self, code: u32, len: u32) {
		for i in (0..len).rev() {
			self.put((code >> i) & 1, 1);
		}
	}
	fn sym(&mut self, s: u32) {
		match s {
			0..=143 => self.huff(0x30 + s, 8),
			144..=255 => self.huff(0x190 + s - 144, 9),
			256..=279 => self.huff(s - 256, 7),
			_ => self.huff(0xC0 + s - 280, 8),
		}
	}
}

fn zlib(raw: &[u8]) -> Vec<u8> {
	let mut b = Bits { out: vec![0x78, 0x9c], acc: 0, n: 0 };
	b.put(1, 1);
	b.put(1, 2);
	let mut i = 0;
	while i < raw.len() {
		let c = raw[i];
		b.sym(c as u32);
		i += 1;
		let mut run = 0;
		while i + run < raw.len() && raw[i + run] == c {
			run += 1;
		}
		let mut left = run;
		while left >= 258 {
			b.sym(285);
			b.huff(0, 5);
			left -= 258;
		}
		for _ in 0..left {
			b.sym(c as u32);
		}
		i += run;
	}
	b.sym(256);
	if b.n > 0 {
		b.out.push(b.acc);
	}
	b.out.extend_from_slice(&adler32(raw).to_be_bytes());
	b.out
}

fn base64(bytes: &[u8]) -> String {
	const A: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
	let mut out = String::new();
	for chunk in bytes.chunks(3) {
		let b = [chunk[0], *chunk.get(1).unwrap_or(&0), *chunk.get(2).unwrap_or(&0)];
		let n = ((b[0] as u32) << 16) | ((b[1] as u32) << 8) | b[2] as u32;
		for k in 0..4 {
			if k <= chunk.len() {
				out.push(A[((n >> (18 - 6 * k)) & 63) as usize] as char);
			} else {
				out.push('=');
			}
		}
	}
	out
}

// Raw bytes in the string's envelope, checksum and all (what a careless or hostile tool could write).
fn envelope(raw: &str) -> String {
	let bytes = raw.as_bytes();
	format!("!PS1!{:08x}!{}", adler32(bytes), base64(&zlib(bytes)))
}

fn js(s: &str) -> String {
	serde_json::to_string(s).unwrap()
}

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
"#;

// Paste and Import, as the page does.
const SAVE: &str = r#"
function save(text)
	local info, why = I.Preview(text)
	assert(info, why)
	assert(I.Save(info.entry))
	return info
end
"#;

fn run_saved(script: &str, saved: Option<String>) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua", "stub_encoding.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		before: WORLD.into(),
		saved: saved.map(|s| ("Polestar".to_string(), s)).into_iter().collect(),
		login: true,
		script: format!("I = Polestar.Import\nG = Polestar.Guides\n{SAVE}\n{script}"),
	})
}

fn run(script: &str) -> Vec<Value> {
	run_saved(script, None)
}

fn sorted(a: &[&str]) -> Value {
	let mut v = a.to_vec();
	v.sort_unstable();
	json!(v)
}

#[test]
fn the_caps_the_checksum_and_the_key_lists_are_the_writer_s() {
	let out = run(r#"emit({ limits = I.LIMITS, sum = I.Adler32("Wikipedia"), keys = I.KEYS })"#).remove(0);
	assert_eq!(
		out["limits"],
		json!({
			"length": LIMITS.length,
			"steps": LIMITS.steps,
			"payload": LIMITS.payload,
			"text": LIMITS.text,
			"names": LIMITS.names,
			"goals": LIMITS.goals,
			"candidates": LIMITS.candidates,
		})
	);
	assert_eq!(out["sum"], format!("{:08x}", adler32(b"Wikipedia")).as_str());
	let guide_keys: Vec<&str> = GUIDE_KEYS.iter().copied().filter(|k| *k != "pack").collect();
	assert_eq!(out["keys"]["guide"], sorted(&guide_keys));
	assert_eq!(out["keys"]["step"], sorted(&STEP_KEYS));
	assert_eq!(out["keys"]["when"], sorted(&WHEN_KEYS));
	assert_eq!(out["keys"]["goal"], sorted(&GOAL_KEYS));
	assert_eq!(out["keys"]["only"], sorted(&ONLY_KEYS));
	assert_eq!(out["keys"]["image"], sorted(&IMAGE_KEYS));
	for k in ["reagents", "candidates", "fromNpcs", "spots", "items", "reward"] {
		assert_eq!(out["keys"][k], sorted(list_keys(k).unwrap()), "{k}");
	}
}

#[test]
fn a_step_picture_rides_along_in_a_string_but_an_imported_guide_has_no_addon_folder_holding_the_file_so_it_shows_none() {
	let mut p = payload();
	p["guide"]["steps"][0]["image"] = json!({ "file": "media\\cave", "w": 512, "h": 256 });
	let script = r#"
		save(@P@)
		local s = G.Get("yendi/northshire").steps
		emit({ image = s[1].image, second = s[2].image == nil })
	"#
	.replace("@P@", &js(&encode(&p)));
	let out = run(&script).remove(0);
	assert_eq!(out, json!({ "image": { "file": "media\\cave", "w": 512, "h": 256 }, "second": true }));
}

#[test]
fn round_trip_guide_string_preview_import_registers_the_guide_a_community_addon_registers() {
	let mine = run(&r#"
			local info, why = I.Preview(@S@)
			assert(info, why)
			emit({ preview = { title = info.title, author = info.author, steps = info.steps, state = info.state, license = info.license, version = info.version,
				minLevel = info.minLevel, maxLevel = info.maxLevel, faction = info.faction } })
			assert(I.Save(info.entry))
			local g = G.Get("yendi/northshire")
			emit({ pack = g.pack, license = g.license, guide = g, record = G.Pack("imported").guides, listed = #G.Packs() })
		"#
	.replace("@S@", &js(&string())));
	let entry = V::obj();
	entry.set("guide", localised(&guide()));
	let theirs = run(&r#"
			assert(Polestar.RegisterPack({ addon = "PolestarPack_Yendi", id = "yendi", format = 3, title = "Yendi", author = "Yendi", version = "1", license = "CC-BY-4.0" }))
			stub.addonLoaded("PolestarPack_Yendi")
			assert(loadstring(@L@))()
			emit({ guide = G.Get("yendi/northshire") })
		"#
	.replace("@L@", &js(&emit_guides(&[entry], false))));
	let (preview, reg) = (&mine[0], &mine[1]);
	assert_eq!(
		preview["preview"],
		json!({ "title": "Northshire Valley", "author": "Yendi", "steps": 4, "state": "new", "license": "CC-BY-4.0", "version": 1, "minLevel": 1, "maxLevel": 6, "faction": "Alliance" })
	);
	assert_eq!(reg["pack"], "imported");
	assert_eq!(reg["license"], "CC-BY-4.0");
	assert_eq!(reg["record"], json!(["yendi/northshire"]));
	assert_eq!(reg["listed"], 0, "the imported guides are not a row of the Community guides page");
	let strip = |v: &Value| {
		let mut c = v.clone();
		if let Some(o) = c.as_object_mut() {
			o.remove("pack");
			o.remove("license");
		}
		c
	};
	assert_eq!(strip(&reg["guide"]), strip(&theirs[0]["guide"]));
}

#[test]
fn a_guide_with_when_steps_goes_into_a_format_4_string_and_imports_with_its_conditions() {
	let src = GUIDE.replacen("step Back to the abbey\n", "step Back to the abbey\n  when onquest 7\n  when level<6\n", 1);
	let g = compile_guide(&src);
	let r = import_of(&g);
	let out = run(&r#"
		local info, why = I.Preview(@S@)
		assert(info, why)
		assert(I.Save(info.entry))
		emit({ format = info.entry.format, when = G.Get("yendi/northshire").steps[4].when })
	"#
	.replace("@S@", &js(&r)))
	.remove(0);
	assert_eq!(out["format"], 4);
	assert_eq!(out["when"], json!([{ "k": "onquest", "q": [7] }, { "k": "level", "op": "<", "n": 6 }]));
}

#[test]
fn a_damaged_truncated_oversized_foreign_or_code_carrying_string_is_refused_with_a_reason_and_savedvariables_stay_untouched() {
	let good = string();
	let body = &good[14..];
	let flipped = format!("{}{}{}", &good[..40], if good.as_bytes()[40] == b'A' { 'B' } else { 'A' }, &good[41..]);
	let mut p = payload();
	p["guide"]["onLoad"] = json!("print(\"hi\")");
	let mut newer_format = payload();
	newer_format["format"] = json!(99);
	let mut bad_type = payload();
	bad_type["guide"]["steps"] = json!("all of them");
	let cases = json!({
		"tampered": flipped,
		"truncated": &good[..good.len() - 24],
		"checksum": format!("!PS1!00000000!{body}"),
		"oversized": format!("!PS1!00000000!{}", "A".repeat(LIMITS.length)),
		"notOurs": "hello there",
		"newer": format!("!PS2!{}", &good[5..]),
		"luaChunk": envelope(r#"return { format = 3, license = "MIT", guide = { id = "yendi/x" } }"#),
		"unknownField": encode(&p),
		"newerFormat": encode(&newer_format),
		"noGuide": encode(&json!({ "format": 3, "license": "MIT" })),
		"nullValue": envelope(r#"{"format":3,"license":"MIT","guide":null}"#),
		"deep": envelope(&format!(r#"{{"format":3,"license":"MIT","guide":{}{}}}"#, "[".repeat(40), "]".repeat(40))),
		"badType": encode(&bad_type),
	});
	let out = run(&r#"
		-- Nothing may run text from a string.
		loadstring = function() error("loadstring called") end
		load, RunScript, setfenv = loadstring, loadstring, loadstring
		local out = {}
		for name, text in pairs(@CASES@) do
			local info, why = I.Preview(text)
			out[name] = info and "accepted" or why
		end
		emit({ reasons = out, imports = PolestarDB.imports == nil, registered = G.Get("yendi/northshire") == nil and G.Get("yendi/x") == nil })
	"#
	.replace("@CASES@", &lua_value(&cases)))
	.remove(0);
	let r = &out["reasons"];
	for name in ["tampered", "truncated", "checksum"] {
		assert!(is_match(text(&r[name]), r"damaged or incomplete"), "{name}");
	}
	assert!(is_match(text(&r["oversized"]), r"too long: Polestar reads up to 50000 characters"));
	assert!(is_match(text(&r["notOurs"]), r"not a Polestar import string"));
	assert!(is_match(text(&r["newer"]), r"needs a newer Polestar"));
	assert!(is_match(text(&r["newerFormat"]), r"needs a newer Polestar"));
	assert!(is_match(text(&r["luaChunk"]), r"damaged or incomplete"));
	assert!(is_match(text(&r["unknownField"]), r"field Polestar does not read \(guide\.onLoad\)"));
	assert!(is_match(text(&r["noGuide"]), r"holds no guide"));
	assert!(is_match(text(&r["nullValue"]), r"damaged or incomplete"));
	assert!(is_match(text(&r["deep"]), r"damaged or incomplete"));
	assert!(is_match(text(&r["badType"]), r"does not read \(guide\.steps\)"));
	assert_eq!(out["imports"], true, "PolestarDB.imports never made");
	assert_eq!(out["registered"], true);
}

#[test]
fn the_guide_must_fit_the_caps_and_the_id_rules_and_lead_only_to_polestar_s_guides_or_imported_ones() {
	let mut long = payload();
	while long["guide"]["steps"].as_array().unwrap().len() <= LIMITS.steps {
		let first = long["guide"]["steps"][0].clone();
		long["guide"]["steps"].as_array_mut().unwrap().push(first);
	}
	let mut ours = payload();
	ours["guide"]["id"] = json!("forever/alliance/sneaky");
	let mut bare = payload();
	bare["guide"]["id"] = json!("northshire");
	let mut leads = payload();
	leads["guide"]["next"] = json!("bob/goldshire");
	let mut to_ours = payload();
	to_ours["guide"]["next"] = json!("forever/alliance/02-westfall");
	to_ours["guide"]["nextChoices"] = json!(["forever/alliance/02-westfall", "bob/goldshire"]);
	let mut bob = payload();
	bob["guide"]["id"] = json!("bob/goldshire");
	let mut invalid = payload();
	invalid["guide"]["steps"][0]["goals"][0]["t"] = json!("teleport");
	let out = run(&r#"
		local function why(text) local info, reason = I.Preview(text) return info and "accepted" or reason end
		local out = {
			long = why(@LONG@), ours = why(@OURS@), bare = why(@BARE@),
			leads = why(@LEADS@), toOurs = why(@TOOURS@), invalid = why(@INVALID@),
		}
		save(@BOB@)
		out.leadsAfter = why(@LEADS@)
		out.toOursAfter = why(@TOOURS@)
		emit(out)
	"#
	.replace("@LONG@", &js(&encode(&long)))
	.replace("@OURS@", &js(&encode(&ours)))
	.replace("@BARE@", &js(&encode(&bare)))
	.replace("@LEADS@", &js(&encode(&leads)))
	.replace("@TOOURS@", &js(&encode(&to_ours)))
	.replace("@INVALID@", &js(&encode(&invalid)))
	.replace("@BOB@", &js(&encode(&bob))))
	.remove(0);
	assert!(is_match(text(&out["long"]), r"has 61 steps; an import string holds 60 at most"));
	assert!(is_match(text(&out["ours"]), r"must start with its author's own id"));
	assert!(is_match(text(&out["bare"]), r"must start with its author's own id"));
	assert!(is_match(text(&out["leads"]), r"leads on to bob/goldshire.*import that guide first"));
	assert!(is_match(text(&out["toOurs"]), r"leads on to bob/goldshire"));
	assert!(is_match(text(&out["invalid"]), r"^Guide yendi/northshire was refused: step 1 goal 1: unknown verb teleport\.$"));
	assert_eq!(out["leadsAfter"], "accepted");
	assert_eq!(out["toOursAfter"], "accepted");
}

#[test]
fn a_guide_id_under_an_installed_community_addon_s_id_stays_the_addon_s() {
	let out = run(&r#"
		assert(Polestar.RegisterPack({ addon = "PolestarPack_Yendi", id = "yendi", format = 3, title = "Yendi's Guides", author = "Yendi", version = "1", license = "MIT" }))
		local info, why = I.Preview(@S@)
		emit({ info = info ~= nil, why = why })
	"#
	.replace("@S@", &js(&string())))
	.remove(0);
	assert_eq!(out["info"], false);
	assert!(is_match(text(&out["why"]), r"Guides under yendi/ come from the community addon Yendi's Guides, which is installed"));
}

#[test]
fn a_newer_version_updates_the_guide_in_place_the_open_tab_keeps_its_progress_where_the_steps_are_unchanged() {
	let v1 = string();
	let mut p2 = payload();
	p2["guide"]["version"] = json!(2);
	p2["guide"]["title"] = json!("Northshire Valley, revised");
	let v2 = encode(&p2);
	let mut p0 = payload();
	p0["guide"]["version"] = json!(0);
	let out = run(&r#"
		save(@V1@)
		local E = Polestar.Engine
		E.SetGuide("yendi/northshire")
		assert(E.ToggleGoal(1, 1))
		E.Goto(2)
		local before = E.GetGuide()
		local same, older, newer = I.Preview(@V1@), I.Preview(@V0@), I.Preview(@V2@)
		assert(I.Save(newer.entry))
		local s = Polestar.CharState()
		emit({ states = { same.state, older.state, newer.state }, have = newer.have, title = E.GetGuide().title, replaced = E.GetGuide() ~= before,
			step = E.GetStepIndex(), tick = s.manual["yendi/northshire"]["1:1"], version = PolestarDB.imports["yendi/northshire"].guide.version, tabs = #E.GetTabs() })
	"#
	.replace("@V1@", &js(&v1))
	.replace("@V0@", &js(&encode(&p0)))
	.replace("@V2@", &js(&v2)))
	.remove(0);
	assert_eq!(out["states"], json!(["same", "older", "update"]));
	assert_eq!(out["have"], 1);
	assert_eq!(out["title"], "Northshire Valley, revised");
	assert_eq!(out["replaced"], true);
	assert_eq!(out["step"], 2, "still looking at the step the player looked at");
	assert_eq!(out["tick"], "tick", "the tick stays");
	assert_eq!(out["version"], 2);
	assert_eq!(out["tabs"], 1);
}

#[test]
fn delete_takes_the_guide_out_of_the_store_the_registry_and_the_open_tabs() {
	let out = run(&r#"
		save(@S@)
		Polestar.Engine.SetGuide("yendi/northshire")
		local deleted = I.Delete("yendi/northshire")
		emit({ deleted = deleted, stored = PolestarDB.imports["yendi/northshire"] == nil, got = G.Get("yendi/northshire") == nil, list = #I.List(),
			record = #G.Pack("imported").guides, open = Polestar.Engine.GetGuide() == nil, again = I.Delete("yendi/northshire") })
	"#
	.replace("@S@", &js(&string())))
	.remove(0);
	assert_eq!(out, json!({ "deleted": true, "stored": true, "got": true, "list": 0, "record": 0, "open": true, "again": false }));
}

#[test]
fn at_login_the_stored_guides_register_through_the_same_checks_one_that_fails_stays_stored_and_listed_with_why() {
	let good = payload();
	let mut bad = payload();
	bad["guide"]["id"] = json!("yendi/broken");
	bad["guide"]["steps"][0]["goals"][0]["sneaky"] = json!(true);
	let saved = format!("PolestarDB = {{ schema = 1, settings = {{}}, imports = {{ [\"yendi/northshire\"] = {}, [\"yendi/broken\"] = {} }} }}", lua_value(&good), lua_value(&bad));
	let out = run_saved(
		r#"
		emit({ got = G.Get("yendi/northshire") and G.Get("yendi/northshire").pack, broken = G.Get("yendi/broken") == nil, list = I.List(), stored = PolestarDB.imports["yendi/broken"] ~= nil })
	"#,
		Some(saved),
	)
	.remove(0);
	assert_eq!(out["got"], "imported");
	assert_eq!(out["broken"], true);
	assert_eq!(out["stored"], true);
	let list = out["list"].as_array().unwrap();
	let got: Vec<Value> = list.iter().map(|e| Value::Array(vec![e["id"].clone(), e["title"].clone(), e["author"].clone(), e["version"].clone(), e["license"].clone(), e["steps"].clone()])).collect();
	let mut want = vec![json!(["yendi/northshire", "Northshire Valley", "Yendi", 1, "CC-BY-4.0", 4]), json!(["yendi/broken", "Northshire Valley", "Yendi", 1, "CC-BY-4.0", 4])];
	let key = |v: &Value| format!("{}{}", text(&v[1]), text(&v[0]));
	want.sort_by_key(key);
	assert_eq!(got, want);
	let broken = list.iter().find(|e| e["id"] == "yendi/broken").unwrap();
	assert!(is_match(text(&broken["problem"]), r"field Polestar does not read \(guide\.steps\[1\]\.goals\[1\]\.sneaky\)"));
}

#[test]
fn suggestions_never_pick_an_imported_guide_and_the_imported_pack_is_never_a_suggestion_source() {
	let out = run(&r#"
		save(@S@)
		Polestar.Set("behavior.suggestFrom", "imported")
		local has = false
		for _, id in ipairs(G.Suggestions()) do if id == "yendi/northshire" then has = true end end
		emit({ has = has, sources = G.SuggestSources(), from = G.SuggestSource(), fits = G.GuideMatches(G.Get("yendi/northshire"), Polestar.Compat.GetPlayerInfo()) })
	"#
	.replace("@S@", &js(&string())))
	.remove(0);
	assert_eq!(out["fits"], true, "the guide is one the character could follow");
	assert_eq!(out["has"], false);
	assert_eq!(out["sources"], json!(["guides"]));
	assert_eq!(out["from"], "guides");
}

#[test]
fn no_community_addon_can_take_the_imported_pack_s_id() {
	let out = run(r#"
		local ok, err = Polestar.RegisterPack({ addon = "Sneaky", id = "imported", imported = true, format = 3, title = "x", author = "x", version = "1", license = "MIT" })
		emit({ ok = ok, err = err, holder = G.Pack("imported").imported })
	"#)
	.remove(0);
	assert_eq!(out["ok"], false);
	assert!(is_match(text(&out["err"]), r"reserved for Polestar"));
	assert_eq!(out["holder"], true);
}

#[test]
fn a_text_over_the_cap_is_refused_at_once_naming_it_before_any_of_it_is_filled_in() {
	let mut long = payload();
	long["guide"]["title"] = json!("{a:1}".repeat(50000));
	let mut key = payload();
	let mut written = serde_json::Map::new();
	written.insert("x".repeat(5000), json!("y"));
	key["guide"]["written"] = Value::Object(written);
	let mut ns = payload();
	ns["guide"]["steps"][0]["goals"][0]["qlvl"] = json!("q".repeat(5000));
	let out = run(&r#"
		local function why(text)
			local t0 = os.clock()
			local info, reason = I.Preview(text)
			return { reason = info and "accepted" or reason, seconds = os.clock() - t0 }
		end
		emit({ long = why(@LONG@), key = why(@KEY@), ns = why(@NS@), imports = PolestarDB.imports == nil })
	"#
	.replace("@LONG@", &js(&encode(&long)))
	.replace("@KEY@", &js(&encode(&key)))
	.replace("@NS@", &js(&encode(&ns))))
	.remove(0);
	assert!(is_match(text(&out["long"]["reason"]), r"holds a text longer than Polestar reads \(guide\.title\): 4096 characters at most"));
	let seconds = out["long"]["seconds"].as_f64().unwrap();
	assert!(seconds < 0.2, "refused in {seconds} s");
	assert!(is_match(text(&out["key"]["reason"]), r"text longer than Polestar reads \(guide\.written\)"));
	assert!(is_match(text(&out["ns"]["reason"]), r"text longer than Polestar reads \(guide\.steps\[1\]\.goals\[1\]\.qlvl\)"));
	assert_eq!(out["imports"], true);
}

#[test]
fn a_payload_over_the_cap_is_refused_with_its_own_message() {
	let big = envelope(&format!(r#"{{"format":3,"license":"MIT","guide":{{"id":"yendi/x","title":"{}"}}}}"#, " ".repeat(LIMITS.payload)));
	assert!(big.len() < LIMITS.length, "the string itself is short");
	let out = run(&"local info, why = I.Preview(@BIG@) emit({ why = why })".replace("@BIG@", &js(&big))).remove(0);
	assert_eq!(out["why"], "This import string holds too much: Polestar reads up to 256 KB of guide data.");
}

#[test]
fn a_string_adds_era_frames_only_for_the_maps_its_guide_uses_and_never_over_a_frame_someone_registered() {
	// A goal on a map Polestar has no frame for (9998), and a frame for a map no goal uses (9999).
	let mut p = payload();
	let (si, gi) =
		p["guide"]["steps"].as_array().unwrap().iter().enumerate().find_map(|(si, st)| st["goals"].as_array().unwrap().iter().position(|g| g.get("map").is_some()).map(|gi| (si, gi))).unwrap();
	p["guide"]["steps"][si]["goals"][gi]["map"] = json!(9998);
	let mine = json!({ "c": 0, "left": 1, "right": 2, "top": 3, "bottom": 4 });
	p["frames"] = json!({ "9998": mine.clone(), "9999": mine.clone() });
	let text = js(&encode(&p));
	let free = run(&r#"
			local before = Polestar.MapFrames.era[9998]
			save(@T@)
			emit({ before = before == nil, got = Polestar.MapFrames.era[9998], stray = Polestar.MapFrames.era[9999] == nil })
		"#
	.replace("@T@", &text));
	let taken = run(&r#"
			assert(Polestar.RegisterPack({ addon = "PolestarPack_Joe", id = "joe", format = 3, title = "Joe", author = "Joe", version = "1", license = "MIT" }))
			Polestar.RegisterMapFrames({ era = { [9998] = { c = 0, left = 10, right = 20, top = 30, bottom = 40 } } }, "joe")
			save(@T@)
			emit({ left = Polestar.MapFrames.era[9998].left, stray = Polestar.MapFrames.era[9999] == nil })
		"#
	.replace("@T@", &text));
	assert_eq!(free[0]["before"], true);
	assert_eq!(free[0]["got"], mine, "a map no one registered takes the string's frame");
	assert_eq!(free[0]["stray"], true, "a map the guide never uses is left out");
	assert_eq!(taken[0]["left"], 10, "the community addon's frame stays");
	assert_eq!(taken[0]["stray"], true);
}
