//! Forever's Gamepad interface style (Options, Gamepad, Enable Gamepad UI). Its navigation opens, closes and
//! focuses the game's windows, popups, menus and chat box from Blizzard's code and makes protected calls in the
//! same execution. Addon code running in that flow gets them blocked, and the "AddOn blocked" popup's own gamepad
//! handling blocks the next one until the client freezes (Blizzard forum threads 2367777 and 2370253). With it
//! on, Polestar keeps to its own windows: Core/Init.lua's ns.GamepadUI() is read once as the addon loads, and
//! every reach into the game's UI asks it first.
//!
//! Two checks:
//!   * loaded with each style, Polestar registers its slash commands, its tracking menu entries and its
//!     Escape-closable windows only with the keyboard and mouse, opens the world map only then, and with the
//!     gamepad shows the minimap button by default (its way in);
//!   * every line of addon code that reaches into the game's UI (REACHES) is in a file listed in ALLOWED with
//!     its count and reason. A new one fails here: guard it with ns.GamepadUI() (or keep it out of the game's
//!     UI), then list it.

use std::collections::BTreeMap;
use std::path::{Path, PathBuf};

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, is_match, Addon, RunAddon};
use serde_json::{json, Value};

const SCRIPT: &str = r#"
Polestar.Set("nav.answerTomTom", true)              -- /way, when nothing else owns it
Polestar.Fire("TOGGLE_FRAME")
Polestar.UI.ShowOptions()
stub.advance(0.5)
local special = {}
for _, name in ipairs(UISpecialFrames) do
	if type(name) == "string" and name:find("^Polestar") then special[#special + 1] = name end
end
emit({
	gamepad = Polestar.GamepadUI(),
	padActive = Polestar.Gamepad.IsActive(),
	slash = SlashCmdList.POLESTAR ~= nil and SLASH_POLESTAR1 ~= nil,
	way = SLASH_POLESTARWAY1 ~= nil,
	recorderSlash = SlashCmdList.POLESTARREC ~= nil,
	recorderCommand = type(PolestarRecorder_Command),
	menus = #__menus,
	special = #special,
	openMap = Polestar.Compat.CanOpenWorldMap(),
	minimapButton = Polestar.Get("maps.minimapButton"),
})
"#;

// cvar: the InputDeviceInterfaceStyle CVar's value (the client's API answers for the style; the CVar can stay
// "1" with the keyboard and mouse).
fn load(gamepad: bool, cvar: Option<&str>) -> Value {
	let cvar_lua = match cvar {
		Some(c) => {
			let s = serde_json::to_string(c).unwrap();
			String::from("C_CVar = C_CVar or {}\ndo\n\tlocal get = C_CVar.GetCVar\n\tC_CVar.GetCVar = function(name) if name == \"InputDeviceInterfaceStyle\" then return ")
				+ &s + " end return get and get(name) end\n\tlocal global = GetCVar\n\tGetCVar = function(name) if name == \"InputDeviceInterfaceStyle\" then return "
				+ &s + " end return global and global(name) end\nend"
		}
		None => String::new(),
	};
	let before = String::from("\nEnum.InputDeviceInterfaceType = { Mkb = 0, Gamepad = 1 }\nC_InputInterfaceStyle = { GetCurrentStyle = function() return ")
		+ if gamepad { "1" } else { "0" }
		+ " end }\n"
		+ &cvar_lua
		+ "\n__menus = {}\nMenu = { ModifyMenu = function(tag) __menus[#__menus + 1] = tag end }\nC_Map.OpenWorldMap = function() end\n";
	emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar"), Addon::name("Polestar_Recorder")], login: true, script: SCRIPT.into(), ..Default::default() })
		.remove(0)
}

#[test]
fn with_the_keyboard_and_mouse_polestar_registers_its_slash_commands_menu_entries_and_escape_closable_windows() {
	let r = load(false, None);
	assert_eq!(r["gamepad"], false);
	assert_eq!(
		json!({ "slash": r["slash"], "way": r["way"], "recorderSlash": r["recorderSlash"], "recorderCommand": r["recorderCommand"], "openMap": r["openMap"], "minimapButton": r["minimapButton"] }),
		json!({ "slash": true, "way": true, "recorderSlash": true, "recorderCommand": "function", "openMap": true, "minimapButton": false })
	);
	assert_eq!(r["menus"], 7, "nearby and service filters on the world map and minimap, two quest menus, and the quest log's pin entry");
	assert!(r["special"].as_f64().unwrap() > 0.0, "its windows close with Escape");
}

// A client playing with the keyboard and mouse whose style CVar still reads "1" (Gamepad): the interface's own
// answer wins, so nothing of the gamepad shows (no hint bar, no button chips) and the slash commands stay.
#[test]
fn the_keyboard_and_mouse_interface_wins_over_a_style_cvar_left_at_gamepad() {
	let r = load(false, Some("1"));
	assert_eq!(
		json!({ "gamepad": r["gamepad"], "padActive": r["padActive"], "slash": r["slash"], "recorderSlash": r["recorderSlash"], "minimapButton": r["minimapButton"] }),
		json!({ "gamepad": false, "padActive": false, "slash": true, "recorderSlash": true, "minimapButton": false })
	);
}

#[test]
fn with_the_gamepad_interface_polestar_keeps_to_its_own_windows_and_its_minimap_button_is_the_way_in() {
	let r = load(true, None);
	assert_eq!(r["gamepad"], true);
	assert_eq!(
		json!({ "slash": r["slash"], "way": r["way"], "recorderSlash": r["recorderSlash"], "menus": r["menus"], "special": r["special"], "openMap": r["openMap"] }),
		json!({ "slash": false, "way": false, "recorderSlash": false, "menus": 0, "special": 0, "openMap": false }),
		"no slash command, menu entry, UISpecialFrames entry or world map opened from addon code"
	);
	assert_eq!(r["recorderCommand"], "function", "the Recorder's page in Polestar's options still runs its commands");
	assert_eq!(r["minimapButton"], true, "the minimap button, on by default");
}

// What reaches into the game's UI: its command, window, popup, menu and error tables and openers, the map's own
// tables, override bindings (they sit over the gamepad interface's own) and its gamepad managers.
const REACHES: &[&str] = &[
	"SlashCmdList",
	r"SLASH_[A-Z]\w*",
	"UISpecialFrames",
	r"Menu\.ModifyMenu",
	r"MenuUtil\.\w+",
	"ShowUIPanel",
	"HideUIPanel",
	"StaticPopup_Show",
	"StaticPopup_Hide",
	"StaticPopupDialogs",
	"OpenWorldMap",
	"ToggleWorldMap",
	"ToggleQuestLog",
	"CloseAllWindows",
	"AddDataProvider",
	"AddCanvasClickHandler",
	"AddGlobalPinMouseActionHandler",
	"AcquirePin",
	"pinPools",
	"SetMessageTypeEnabled",
	"seterrorhandler",
	r"SetOverrideBinding\w*",
	"ClearOverrideBindings",
	"GamepadMode",
	"SmartNavigation",
];

// file -> lines that reach, why it is safe with the gamepad interface
const ALLOWED: &[(&str, usize, &str)] = &[
	("Polestar/Core/Init.lua", 5, "ns.CloseOnEscape and the /polestar registration, neither with the gamepad interface"),
	("Polestar/Core/Compat.lua", 3, "Compat.OpenWorldMap opens nothing with the gamepad interface"),
	("Polestar/Dungeons/Dungeons.lua", 1, "through Compat.OpenWorldMap"),
	("Polestar/Nav/Journey.lua", 6, "the map's canvas click handler and /way, neither with the gamepad interface; wayTaken only reads"),
	("Polestar/Nav/Nearby.lua", 3, "the tracking menus, not with the gamepad interface"),
	("Polestar/Maps/Services.lua", 3, "the service tracking menus, not with the gamepad interface"),
	("Polestar/UI/QuestLinks.lua", 3, "the quest menus, not with the gamepad interface"),
	("Polestar/UI/GuideFrame.lua", 2, "the quest log menu's pin entry, not with the gamepad interface"),
	("Polestar/QoL/QoL.lua", 2, "dialogs closed for the player (QoL.ClosePopup), never with the gamepad interface (its focus owns them)"),
	("Polestar/QoL/Toggles.lua", 3, "the error-message setting, which does nothing with the gamepad interface"),
	("Polestar/UI/Options.lua", 2, "closing the game's Settings panel, never with the gamepad interface or in combat"),
	("Polestar/UI/Gamepad.lua", 3, "a window's override bindings, only with the keyboard and mouse interface; the gamepad interface's focused window only read (a field, never a call)"),
	("Polestar_Recorder/Commands.lua", 3, "/psrec, not with the gamepad interface"),
	("Polestar_Recorder/Panel.lua", 1, "the Recorder window's Escape entry, not with the gamepad interface"),
];

fn lua_files(dir: &Path) -> Vec<PathBuf> {
	let mut out = Vec::new();
	for entry in std::fs::read_dir(dir).unwrap_or_else(|e| panic!("{}: {e}", dir.display())) {
		let entry = entry.unwrap();
		let full = entry.path();
		let name = entry.file_name().to_string_lossy().into_owned();
		if entry.file_type().unwrap().is_dir() {
			if name != "Locales" {
				out.extend(lua_files(&full));
			}
		} else if name.ends_with(".lua") {
			out.push(full);
		}
	}
	out
}

#[test]
fn every_reach_into_the_game_s_ui_is_guarded_for_the_gamepad_interface_and_listed() {
	let reaches = regex::Regex::new(&format!(r"\b({})\b", REACHES.join("|"))).unwrap();
	let comment = regex::Regex::new(r"(^|\s)--.*$").unwrap();
	let skip = regex::Regex::new(r"^Polestar_(Names_|Guides)").unwrap();
	let addons = addons_dir();
	let mut found: BTreeMap<String, usize> = BTreeMap::new();
	for entry in std::fs::read_dir(&addons).unwrap() {
		let name = entry.unwrap().file_name().to_string_lossy().into_owned();
		if !name.starts_with("Polestar") || skip.is_match(&name) {
			continue;
		}
		for file in lua_files(&addons.join(&name)) {
			let rel = file.strip_prefix(&addons).unwrap().components().map(|c| c.as_os_str().to_string_lossy().into_owned()).collect::<Vec<_>>().join("/");
			let src = std::fs::read_to_string(&file).unwrap();
			let n = src.split('\n').filter(|line| reaches.is_match(&comment.replacen(line, 1, ""))).count();
			if n > 0 {
				found.insert(rel, n);
			}
		}
	}
	let counts: BTreeMap<String, usize> = ALLOWED.iter().map(|(f, n, _)| (f.to_string(), *n)).collect();
	assert_eq!(found, counts, "a reach into the game's UI was added or removed: guard it with ns.GamepadUI() and update ALLOWED");
	for (file, _, _) in ALLOWED {
		let src = std::fs::read_to_string(addons.join(file)).unwrap();
		assert!(is_match(&src, r"GamepadUI|gamepadUI\(\)|Compat\.OpenWorldMap"), "{file} asks whether the gamepad interface is on");
	}
}
