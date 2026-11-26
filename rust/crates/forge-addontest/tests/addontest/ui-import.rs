//! Import a guide (addon/Polestar/UI/Import.lua), a section of Settings > Community guides (UI/Packs.lua builds it
//! into that page), over the real Core (Core/Import.lua, the guide registry) and the UI's fake Engine
//! (tests/lua/stub_ui.lua); the guide menu's "Imported" entry and its "+ Import a guide" row under Community guides.

use forge_addontest::dsl::{fixture_data, plain};
use forge_addontest::{emitted, is_match, Addon, RunAddon};
use forge_guide::diag::Diagnostics;
use forge_guide::importstring::{decode_import, encode_import, import_string};
use forge_guide::js::parse_json;
use forge_guide::project::{compile_sources, CompileOpts, Source};
use serde_json::{json, Value};
use std::sync::OnceLock;

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

const GUIDE: &str = r#"guide yendi/cozy-sleeping-bag
title Cozy Sleeping Bag
levels 30-40
zone Elwynn Forest
version 3

step Deputy Willem
  accept 783

step Marshal McBride
  turnin 783
"#;

fn string() -> String {
	static TEXT: OnceLock<String> = OnceLock::new();
	TEXT.get_or_init(|| {
		let data = fixture_data();
		let sources = vec![Source { source: String::new(), file: "cozy.guide".into(), text: GUIDE.into() }];
		let mut diag = Diagnostics::new();
		let opts = CompileOpts { pack: Some("yendi".into()), author: Some("Yendi".into()), context: None, pack_dir: None };
		let c = compile_sources(&sources, &data, &mut diag, &opts);
		let errors: Vec<String> = diag.errors().iter().map(|d| d.message.clone()).collect();
		assert_eq!(errors, Vec::<String>::new());
		let manifest = parse_json(r#"{"id":"yendi","license":"CC-BY-4.0"}"#).unwrap();
		import_string(&c.guides[0], &manifest, Some(&data)).unwrap_or_else(|e| panic!("{e}")).0
	})
	.clone()
}

const SETUP: &str = r#"
uistub.install()
Polestar.Guides = uistub.realGuides
G = uistub.realGuides
assert(Polestar.RegisterPack({ addon = "Polestar_Guides", id = "guides", format = 1, title = "Polestar Guides", author = "Polestar", version = "0.1.0", license = "GPL-3.0" }))
assert(Polestar.RegisterGuide({ id = "forever/westfall", pack = "guides", title = "Westfall", minLevel = 10, maxLevel = 20, steps = { { goals = { { t = "level", level = 20 } } } } }))
stub.login()
Polestar.UI.LoadOptions()
UI, P, IV = Polestar.UI, Polestar.UI.Picker, Polestar.UI.Import
function page() UI.ShowOptions("guidepacks"); return Polestar.UI.Packs.view end
function paste(text)
	local box = IV.parts.Box
	box:SetText(text)
	box:GetScript("OnTextChanged")(box, true)
end
function rail(frame)
	local out = {}
	for _, b in ipairs(frame.railButtons or {}) do
		if b:IsShown() then out[#out + 1] = b.psKey end
	end
	return out
end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_ui.lua", "stub_encoding.lua"], addons: vec![Addon::files("Polestar", &FILES)], script: format!("{SETUP}\n{script}"), ..Default::default() })
}

fn str_(s: &str) -> String {
	serde_json::to_string(s).unwrap()
}

fn size(v: &Value) -> usize {
	match v {
		Value::Array(a) => a.len(),
		Value::Object(o) => o.len(),
		_ => 0,
	}
}

#[test]
fn import_is_no_section_of_the_hub_it_is_in_settings_community_guides_and_polestar_import_opens_it() {
	let out = run(r#"
		SlashCmdList.POLESTAR("import")
		local view = Polestar.UI.Packs.view
		local options, page = PolestarOptions:IsShown(), view and view:IsVisible() or false
		local shown = IV.parts.Box and IV.parts.Box:IsVisible() or false
		UI.ShowPicker()
		local sections = {}
		for _, s in ipairs(P.Sections()) do sections[#sections + 1] = s.key end
		emit({ options = options, page = page, shown = shown, hub = rail(PolestarPicker), sections = sections, foot = P.FootItems() })
	"#);
	let out = &out[0];
	assert_eq!(out["options"], true);
	assert_eq!(out["page"], true, "the Community guides page of Settings is up");
	assert_eq!(out["shown"], true, "with the paste box on it");
	let foot: Vec<Value> = out["foot"].as_array().unwrap().iter().map(|i| i["key"].clone()).collect();
	assert_eq!(foot, vec![json!("Options")], "no Import above Options");
	assert!(!out["sections"].as_array().unwrap().contains(&json!("Import")), "{out}");
	assert!(!out["hub"].as_array().is_none_or(|a| a.contains(&json!("Import"))), "{out}");
}

#[test]
fn the_guide_menu_ends_its_community_guides_with_a_plus_import_a_guide_row_that_opens_the_same_place() {
	let out = run(r##"
		UI.ShowPicker()
		P.ShowSection("Guides")
		local nav, row = {}, nil
		for _, b in ipairs(PolestarPicker.navButtons) do
			if b:IsShown() then
				nav[#nav + 1] = (b.psHeading and "# " or "") .. b.Label:GetText()
				if b.Label:GetText() == "Import a guide" then row = b end
			end
		end
		local cats = P.categories
		row:Click()
		emit({ nav = nav, cats = cats, options = PolestarOptions:IsShown(), page = Polestar.UI.Packs.view:IsVisible(), category = P.Category() })
	"##);
	let out = &out[0];
	let nav: Vec<&str> = out["nav"].as_array().unwrap().iter().map(|v| v.as_str().unwrap()).collect();
	assert_eq!(nav[nav.len() - 1], "Import a guide", "last: {nav:?}");
	let at = nav.iter().position(|n| *n == "# Community guides").expect("the heading shows with no pack too");
	assert!(at < nav.len() - 1);
	assert!(!out["cats"].as_array().unwrap().iter().any(|c| c.as_str().is_some_and(|c| c.starts_with("import"))), "it is no category: {out}");
	assert_eq!((&out["options"], &out["page"]), (&json!(true), &json!(true)));
	assert_ne!(out["category"], "import:");
}

#[test]
fn a_pasted_string_shows_its_preview_before_anything_is_saved_import_saves_it_lists_it_and_adds_it_to_the_guide_menu() {
	let out = run(&r##"
		page()
		paste($S)
		emit(IV.Shown())
		emit({ saved = PolestarDB.imports == nil })
		IV.parts.Apply:Click()
		emit(IV.Shown())
		local g = G.Get("yendi/cozy-sleeping-bag")
		local nav = {}
		UI.ShowPicker()
		P.ShowSection("Guides")
		for _, b in ipairs(PolestarPicker.navButtons) do
			if b:IsShown() then nav[#nav + 1] = (b.psHeading and "# " or "") .. b.Label:GetText() end
		end
		emit({ credits = (P.Credits(g)), nav = nav, entries = #P.Entries("", "pack:imported") })
	"##
	.replace("$S", &str_(&string())));
	let (before, unsaved, after, menu) = (&out[0], &out[1], &out[2], &out[3]);
	assert_eq!(before["preview"], "Cozy Sleeping Bag  ·  by Yendi  ·  2 steps  ·  levels 30–40  ·  Alliance and Horde  ·  CC-BY-4.0");
	assert_eq!(before["button"], "Import");
	assert!(before["refusal"].is_null());
	assert_eq!(size(&before["list"]), 0);
	assert_eq!(unsaved["saved"], true, "nothing saved before Import");
	assert!(is_match(after["done"].as_str().unwrap_or(""), r"Imported Cozy Sleeping Bag\. Find it in the guide menu under Community guides, Imported\."));
	assert!(after["preview"].is_null());
	let list: Vec<Value> = after["list"].as_array().unwrap().iter().map(|r| json!([r["title"], r["credits"]])).collect();
	assert_eq!(list, vec![json!(["Cozy Sleeping Bag", "By Yendi  ·  version 3  ·  CC-BY-4.0"])]);
	assert_eq!(menu["credits"], "By Yendi  ·  Imported  ·  CC-BY-4.0");
	let nav: Vec<&str> = menu["nav"].as_array().unwrap().iter().map(|v| v.as_str().unwrap_or("")).collect();
	let joined = nav.join(",");
	let at = nav.iter().position(|n| *n == "# Community guides");
	assert!(at.is_some(), "the Community guides heading: {joined}");
	assert!(nav[at.unwrap()..].contains(&"Imported"), "Imported under it: {joined}");
	assert!(menu["entries"].as_f64().unwrap() > 0.0);
}

#[test]
fn a_paste_comes_in_one_character_at_a_time_and_is_read_on_the_next_frame_the_box_keeps_only_its_beginning() {
	let s = string();
	let out = run(&r#"
		page()
		local box = IV.parts.Box
		local text = $S
		for i = 1, #text do box:GetScript("OnChar")(box, text:sub(i, i)) end
		box:GetScript("OnTextChanged")(box, true)
		emit({ preview = IV.Shown().preview or false })
		stub.advance(0.02)
		emit({ preview = IV.Shown().preview, box = box:GetText() })
	"#
	.replace("$S", &str_(&s)));
	let (during, after) = (&out[0], &out[1]);
	assert_eq!(during["preview"], false, "nothing read while the paste comes in");
	assert!(is_match(after["preview"].as_str().unwrap_or(""), r"^Cozy Sleeping Bag"));
	assert_eq!(after["box"], format!("{}… ({} KB)", &s[..40], s.len().div_ceil(1024)).as_str());
}

#[test]
fn a_refused_string_shows_why_and_saves_nothing_the_same_string_again_says_it_is_already_imported_a_newer_one_offers_update() {
	let mut p = plain(&decode_import(&string()).unwrap_or_else(|e| panic!("{e}")));
	p["guide"]["version"] = json!(4);
	let newer_string = encode_import(&parse_json(&p.to_string()).unwrap());
	let out = run(&r#"
		page()
		paste("!PS1!garbage")
		emit({ shown = IV.Shown(), saved = PolestarDB.imports == nil })
		paste($S)
		IV.parts.Apply:Click()
		paste($S)
		emit(IV.Shown())
		paste($P)
		emit(IV.Shown())
	"#
	.replace("$S", &str_(&string()))
	.replace("$P", &str_(&newer_string)));
	let (bad, same, newer) = (&out[0], &out[1], &out[2]);
	assert!(is_match(bad["shown"]["refusal"].as_str().unwrap_or(""), r"damaged or incomplete"));
	assert!(bad["shown"]["button"].is_null());
	assert_eq!(bad["saved"], true);
	assert_eq!(same["note"], "This guide is already imported, at this version.");
	assert!(same["button"].is_null());
	assert!(is_match(newer["note"].as_str().unwrap_or(""), r"You have version 3 of this guide\. Update replaces it"));
	assert_eq!(newer["button"], "Update");
}

#[test]
fn delete_asks_for_a_second_click_then_removes_the_guide_from_the_list_and_the_store() {
	let out = run(&r#"
		page()
		paste($S)
		IV.parts.Apply:Click()
		local row = IV.rows[1]
		row.Delete:Click()
		emit({ label = row.Delete.Label:GetText(), list = #IV.Shown().list })
		row.Delete:Click()
		emit({ list = #IV.Shown().list, stored = PolestarDB.imports["yendi/cozy-sleeping-bag"] == nil, got = G.Get("yendi/cozy-sleeping-bag") == nil })
	"#
	.replace("$S", &str_(&string())));
	let (one, two) = (&out[0], &out[1]);
	assert_eq!(one["label"], "Click again to confirm");
	assert_eq!(one["list"], 1);
	assert_eq!(*two, json!({ "list": 0, "stored": true, "got": true }));
}
