//! The game's Options search and Polestar's key bindings (#1996, #1997, #2207). Every keystroke in the search
//! reads a hidden category of every key binding, which the game builds after login with each binding's
//! Bindings.xml search tags through C_KeyBindings.GetSearchTagsForAction, outside securecallfunction
//! (Blizzard_SettingsDefinitions_Frame/Keybindings.lua, CreateSearchableSettings, 1.60.1). A tag whose global an
//! addon wrote taints that build and so every search, whose Discord sign-in row then calls C_Discord.IsUserOAuthed,
//! a function with restrictions: the game blocks it and names the addon. 0.3.7 tagged every binding with
//! BINDING_TAG_POLESTAR, which Polestar set and the Recorder set again (it loads after Polestar, so the global was
//! its): "18x blocked in Polestar: IsUserOAuthed()" without the Recorder, "9x blocked in Polestar_Recorder:
//! IsUserOAuthed()" with it. Runs the real addons against tests/lua/stub_options_search.lua (that path, from the
//! 1.60.1 interface code).

use forge_addontest::run::{addons_dir, lua_string};
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::json;

const ADDONS: [&str; 2] = ["Polestar", "Polestar_Recorder"];

/// Every binding of both Bindings.xml files as a Lua list for stub.optionsSearch.watch (its action and the tokens
/// of its searchTags), and how many there are.
fn bindings() -> (String, usize) {
	let binding = regex::Regex::new(r#"<Binding\s+name="([^"]+)"([^>]*)>"#).unwrap();
	let tags = regex::Regex::new(r#"searchTags="([^"]*)""#).unwrap();
	let mut list = Vec::new();
	for addon in ADDONS {
		let xml = std::fs::read_to_string(addons_dir().join(addon).join("Bindings.xml")).unwrap();
		for m in binding.captures_iter(&xml) {
			let tokens: Vec<String> = tags.captures(&m[2]).map_or_else(Vec::new, |t| t[1].split(',').map(|s| lua_string(s.trim())).collect());
			list.push(format!("{{ action = {}, tags = {{ {} }} }}", lua_string(&m[1]), tokens.join(", ")));
		}
	}
	(format!("{{ {} }}", list.join(", ")), list.len())
}

/// The Author line of an addon's TOC (the stub's GetAddOnMetadata): Polestar counts a blocked call as its own
/// only for its own addons.
fn author(addon: &str) -> String {
	let toc = std::fs::read_to_string(addons_dir().join(addon).join(format!("{addon}.toc"))).unwrap();
	toc.lines().find_map(|l| l.strip_prefix("## Author:")).map(|a| a.trim().to_string()).unwrap()
}

const SCRIPT: &str = r#"
local S = stub.optionsSearch
local taint = S.build()
local blamed = S.search()
local blocked = {}
for _, b in ipairs(Polestar.Blocked()) do blocked[#blocked + 1] = b.count .. "x " .. b.addon .. ": " .. b.fn end
emit({ taint = taint or false, blamed = blamed or false, blocked = table.concat(blocked, "; ") })
"#;

#[test]
fn a_search_in_the_games_options_blames_neither_polestar_nor_the_recorder_for_the_discord_row() {
	let (list, count) = bindings();
	assert!(count >= 20, "both Bindings.xml files read: {count} bindings");
	let meta: Vec<String> = ADDONS.iter().map(|a| format!("stub.addonMeta[{}] = {{ Author = {} }}", lua_string(a), lua_string(&author(a)))).collect();
	let before = format!("{}\nstub.optionsSearch.watch({list})", meta.join("\n"));
	// As #1996's player (Polestar alone) and #2207's (with the Recorder).
	let runs: Vec<_> = [&ADDONS[..1], &ADDONS[..]]
		.iter()
		.map(|addons| {
			let out = emitted(&RunAddon {
				stubs: vec!["stub_world.lua", "stub_options_search.lua"],
				before: before.clone(),
				addons: addons.iter().map(|a| Addon::name(a)).collect(),
				login: true,
				script: SCRIPT.into(),
				..Default::default()
			})
			.remove(0);
			json!({ "addons": addons, "out": out })
		})
		.collect();
	let clean = json!({ "taint": false, "blamed": false, "blocked": "" });
	assert_eq!(runs, vec![json!({ "addons": ["Polestar"], "out": clean }), json!({ "addons": ADDONS, "out": clean })]);
}
