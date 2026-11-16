//! A mixed install (Core/Data.lua, Data.CheckInstall): Polestar folders from different versions, the usual
//! cause when something works for one player and not another until they reinstall. At login every Polestar_*
//! folder in the AddOns list, loaded or not, is compared with Polestar's own version and one chat line names
//! the odd ones; the report (UI/Report.lua) carries the same fact. Polestar_Experimental ships in the release
//! zip (off until a player switches it on) and is compared like the rest; Polestar_Recorder ships in a zip of
//! its own and community addons are never named Polestar_*, so neither counts; a folder without a version is
//! unknown, not a mismatch. The stub's default TOC version is "0.1.0-test" for every addon, Polestar included.

use forge_addontest::{emitted, is_match, Addon, RunAddon};
use serde_json::Value;

const CORE: &[&str] = &["Core/Init.lua", "Core/Compat.lua", "Core/Data.lua", "Core/LuaChunks.lua", "Core/Names.lua", "Core/GuideTexts.lua", "Core/Guides.lua"];
const UI: &[&str] = &["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// A release's folders, each "name" or "name=version" (version "" for a TOC without one), as the AddOns list.
fn addons_lua(addons: &[&str]) -> String {
	let mut list = Vec::new();
	let mut meta = Vec::new();
	for a in addons {
		let (name, version) = a.split_once('=').map_or((*a, None), |(n, v)| (n, Some(v)));
		list.push(format!("{{ name = \"{name}\" }}"));
		if let Some(v) = version {
			meta.push(format!("stub.addonMeta[\"{name}\"] = {{ Version = \"{v}\" }}"));
		}
	}
	format!("stub.addons = {{ {} }}\n{}", list.join(", "), meta.join("\n"))
}

const RELEASE: &[&str] = &[
	"Polestar",
	"Polestar_Guides",
	"Polestar_Guides_Alliance",
	"Polestar_Guides_Horde",
	"Polestar_Guides_Human",
	"Polestar_Guides_Orc",
	"Polestar_Codex",
	"Polestar_QuestDB",
	"Polestar_ItemDB",
	"Polestar_Nav",
	"Polestar_Experimental",
	"Polestar_Nav_EK",
	"Polestar_Nav_Kalimdor",
	"Polestar_Options",
	"Polestar_Looks",
	"Polestar_deDE",
	"Polestar_zhCN",
];

fn with(changes: &[&str]) -> Vec<String> {
	let mut out: Vec<String> = RELEASE.iter().map(|s| s.to_string()).collect();
	for c in changes {
		let name = c.split('=').next().unwrap();
		match out.iter_mut().find(|a| a.split('=').next() == Some(name)) {
			Some(a) => *a = c.to_string(),
			None => out.push(c.to_string()),
		}
	}
	out
}

fn login(addons: &[String]) -> Value {
	let refs: Vec<&str> = addons.iter().map(String::as_str).collect();
	emitted(&RunAddon {
		before: addons_lua(&refs),
		addons: vec![Addon::files("Polestar", CORE)],
		login: true,
		script: r#"
local missing, stale = Polestar.Data.CheckInstall()
local said = {}
for _, m in ipairs(stub.messages) do if m:find("delete every Polestar folder", 1, true) then said[#said + 1] = m end end
emit({ missing = table.concat(missing, ","), stale = table.concat(stale, ","), said = said })"#
			.into(),
		..Default::default()
	})
	.remove(0)
}

fn said(out: &Value) -> Vec<String> {
	out["said"].as_array().map(|a| a.iter().map(|s| s.as_str().unwrap().to_string()).collect()).unwrap_or_default()
}

#[test]
fn a_mixed_install_names_every_folder_from_another_version_once_loaded_or_not_with_how_to_reinstall() {
	// Folders Polestar loads only for another race, another language or on demand, left from an older zip.
	let out = login(&with(&["Polestar_Guides_Orc=0.3.4", "Polestar_Nav_EK=0.3.4", "Polestar_zhCN=0.3.3", "Polestar_Experimental=0.3.4"]));
	let stale: Vec<&str> = out["stale"].as_str().unwrap().split(',').collect();
	for s in ["Polestar_Guides_Orc 0.3.4", "Polestar_Nav_EK 0.3.4", "Polestar_zhCN 0.3.3", "Polestar_Experimental 0.3.4"] {
		assert!(stale.contains(&s), "{s} in {stale:?}");
	}
	assert_eq!(stale.len(), 4, "{stale:?}");
	let said = said(&out);
	assert_eq!(said.len(), 1, "one line: {said:?}");
	assert!(is_match(&said[0], r"Polestar\|r: Your install is mixed or incomplete \(Polestar 0\.1\.0-test, "), "{}", said[0]);
	assert!(is_match(&said[0], r"Polestar_Guides_Orc 0\.3\.4") && is_match(&said[0], r"Polestar_Nav_EK 0\.3\.4") && is_match(&said[0], r"Polestar_zhCN 0\.3\.3"), "{}", said[0]);
	assert!(is_match(&said[0], r"Polestar_Experimental 0\.3\.4"), "{}", said[0]);
	assert!(is_match(&said[0], r#"delete every Polestar folder in Interface/AddOns.*Polestar Client.*CurseForge app.*not "Source code""#), "{}", said[0]);
}

#[test]
fn an_install_of_one_version_says_nothing_whatever_version_the_recorder_or_a_community_addon_has() {
	let out = login(&with(&["Polestar_Recorder=0.3.1", "PolestarPack_JoesRoutes=1.2.0", "PolestarPack_JoesRoutes_Horde=1.2.0"]));
	assert_eq!(out["stale"], "");
	assert_eq!(out["missing"], "");
	assert!(said(&out).is_empty(), "{:?}", said(&out));
}

#[test]
fn a_folder_without_a_version_is_unknown_not_a_mismatch_and_so_is_polestar_without_one() {
	let out = login(&with(&["Polestar_Nav_Kalimdor=", "Polestar_ItemDB="]));
	assert_eq!(out["stale"], "");
	assert!(said(&out).is_empty(), "{:?}", said(&out));
	// Polestar's own TOC without a version: nothing to compare the others with.
	let out = login(&with(&["Polestar="]));
	assert_eq!(out["stale"], "");
	assert!(said(&out).is_empty(), "{:?}", said(&out));
}

// The game's looks and Hearth (Polestar_Looks) load on demand but ship in every release, as the settings window
// does: a copy without the folder is named at login (picking one of those looks would quietly keep Polestar's).
#[test]
fn a_copy_without_the_game_looks_folder_is_named_at_login_as_a_missing_settings_window_is() {
	let without: Vec<String> = RELEASE.iter().filter(|n| **n != "Polestar_Looks").map(|s| s.to_string()).collect();
	let out = login(&without);
	assert_eq!(out["missing"], "Polestar_Looks");
	assert_eq!(out["stale"], "");
	let said = said(&out);
	assert_eq!(said.len(), 1, "one line: {said:?}");
	assert!(is_match(&said[0], r"Polestar_Looks not installed"), "{}", said[0]);
}

#[test]
fn the_report_and_the_bug_report_text_carry_the_mixed_install() {
	let run = |addons: Vec<String>| {
		let refs: Vec<&str> = addons.iter().map(String::as_str).collect();
		emitted(&RunAddon {
			stubs: vec!["stub_ui.lua"],
			before: addons_lua(&refs),
			addons: vec![Addon::files("Polestar", UI)],
			script: r#"uistub.install()
stub.login()
local R = Polestar.UI.Report
local d = R.Details()
local line
for _, l in ipairs(d.lines) do if l:find("^Install:") then line = l end end
emit({ line = line or "", text = R.Text("The quest log did not sync.", d), issue = R.IssueURL("The quest log did not sync.", d) })"#
				.into(),
			..Default::default()
		})
		.remove(0)
	};
	let out = run(with(&["Polestar_Guides_Orc=0.3.4", "Polestar_Nav_EK=0.3.4"]));
	let line = out["line"].as_str().unwrap();
	assert!(is_match(line, r"^Install: mixed: Polestar 0\.1\.0-test, Polestar_Guides_Orc 0\.3\.4, Polestar_Nav_EK 0\.3\.4$"), "{line}");
	assert!(out["text"].as_str().unwrap().contains(line), "the report to paste has it");
	assert!(out["issue"].as_str().unwrap().contains("Install%3A%20mixed"), "the GitHub issue has it");
	let out = run(with(&[]));
	assert_eq!(out["line"], "", "a sound install adds no line");
}
