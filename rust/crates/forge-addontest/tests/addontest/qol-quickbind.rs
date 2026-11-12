//! Key bindings in the game's windows: Polestar's buttons in Quick Keybind Mode (addon/Polestar/QoL/QuickBind.lua,
//! hooked from QoL/Buttons.lua) and the "Polestar" section of Options > Keybindings (both Bindings.xml files, the
//! names in Core/Commands.lua and Polestar_Recorder/Panel.lua). Runs the real QoL against tests/lua/stub_qol.lua and
//! tests/lua/stub_quickbind.lua (the window, its EventRegistry signals and the saved bindings, shaped on the 1.60.1
//! interface code). An empty Lua table emits as `{}`.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 4] = ["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"];

const PRELUDE: &str = r#"
local q, k = stub.qol, stub.qkb
local T = PolestarTargetButton
local TARGET = "CLICK PolestarTargetButton:LeftButton"
_G["BINDING_NAME_" .. TARGET] = "Target quest mob"
local function set(key, v) Polestar.Set("qol." .. key, v); stub.runTimers() end
local function look(b) return { shown = b:IsShown(), alpha = b:GetAlpha() or 1, label = b.Label and b.Label:GetText() or "" } end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon { stubs: vec!["stub_qol.lua", "stub_quickbind.lua"], addons: vec![Addon::files("Polestar", &FILES)], login: true, script: format!("{PRELUDE}{script}"), ..Default::default() })
}

const FORCED: &str = "normal: Not needed right now: shown so you can bind it.";

#[test]
fn quick_keybind_hidden_buttons_show_dimmed_with_their_binding_name_while_the_window_is_open_and_go_when_it_closes() {
	let out = run(r#"
		emit(look(T))
		k.open()
		emit({ target = look(T), item = PolestarQuestItemButton:IsShown(), hearth = PolestarHearthButton:IsShown(),
			rare = PolestarRareButton:IsShown(), bag = PolestarBagButton:IsShown() })
		k.close()
		emit({ target = look(T), item = PolestarQuestItemButton:IsShown(), hearth = PolestarHearthButton:IsShown(),
			rare = PolestarRareButton:IsShown(), bag = PolestarBagButton:IsShown() })
	"#);
	assert_eq!(out[0], json!({ "shown": false, "alpha": 1, "label": "" }), "no target: hidden");
	assert_eq!(out[1]["target"], json!({ "shown": true, "alpha": 0.45, "label": "Target quest mob" }));
	assert_eq!(out[1], json!({ "target": out[1]["target"], "item": true, "hearth": true, "rare": true, "bag": true }), "every button with a binding");
	assert_eq!(out[2], json!({ "target": { "shown": false, "alpha": 1, "label": "" }, "item": false, "hearth": false, "rare": false, "bag": false }));
}

#[test]
fn quick_keybind_a_button_turned_off_in_the_options_stays_hidden_and_one_the_guide_needs_gets_its_own_look_back() {
	let out = run(r#"
		set("rareButton", false)
		k.open()
		emit({ rare = PolestarRareButton:IsShown(), target = look(T) })
		q.step({ { t = "kill", target = "Kobold Vermin" } })
		stub.advance(0.3)
		emit(look(T))
		k.close()
		emit({ target = look(T), macro = T:GetAttribute("macrotext") ~= nil })
	"#);
	assert_eq!(out[0]["rare"], false, "rare button off: not shown for binding");
	assert_eq!(out[0]["target"]["shown"], true);
	assert_eq!(out[1], json!({ "shown": true, "alpha": 1, "label": "Kobold Vermin" }), "a target now: the button's own look and name");
	assert_eq!(out[2], json!({ "target": { "shown": true, "alpha": 1, "label": "Kobold Vermin" }, "macro": true }), "still the guide's after the window");
}

#[test]
fn quick_keybind_hovering_a_button_shows_the_modes_tooltip_and_a_key_binds_it_with_its_modifiers_until_escape_unbinds_it() {
	let out = run(r#"
		k.open()
		local o = k.hover(T)
		emit({ took = o ~= nil, tip = QuickKeybindTooltip.lines, game = GameTooltip:GetOwner() == T })
		stub.keys.shift = true
		local route = k.key("F")
		stub.keys.shift = false
		emit({ route = route, keys = k.keys(TARGET), hotkey = T.Hotkey:GetText(), output = k.output, saves = k.saves, tip = QuickKeybindTooltip.lines })
		emit({ route = k.key("ESCAPE"), keys = k.keys(TARGET), tip = QuickKeybindTooltip.lines, open = QuickKeybindFrame:IsShown() })
		k.leave()
		emit({ tip = QuickKeybindTooltip:GetOwner() == T and QuickKeybindTooltip:IsShown(), route = k.key("G"), keys = k.keys(TARGET) })
	"#);
	assert_eq!(out[0]["took"], true, "the capture frame lies over the button");
	assert_eq!(out[0]["game"], false, "not the button's own tooltip");
	assert_eq!(out[0]["tip"], json!(["highlight: Target quest mob", "error: Not Bound", "normal: Press a key to bind", FORCED]));
	assert_eq!(out[1]["route"], "frame", "the key goes no further");
	assert_eq!(out[1]["keys"], json!(["SHIFT-F"]));
	assert_eq!(out[1]["hotkey"], "sF", "the button shows its new key");
	assert_eq!(out[1]["output"], "Key Bound");
	assert_eq!(out[1]["saves"], 0, "the window's Okay saves, never Polestar");
	assert_eq!(out[1]["tip"], json!(["highlight: Target quest mob", "instruction: SHIFT-F", "normal: Press Escape to unbind", FORCED]));
	assert_eq!(out[2]["route"], "frame");
	assert_eq!(out[2]["keys"], json!({}), "Escape unbinds");
	assert_eq!(out[2]["open"], true, "and leaves the window open");
	assert_eq!(out[3], json!({ "tip": false, "route": "window", "keys": {} }), "off the button: the window's own keys again");
}

#[test]
fn quick_keybind_a_new_key_replaces_the_first_keeps_the_second_and_takes_the_key_from_what_it_ran() {
	let out = run(r#"
		k.bind("F", TARGET)
		k.bind("G", TARGET)
		k.bind("H", "JUMP")
		k.open()
		k.hover(T)
		k.key("H")
		emit({ keys = k.keys(TARGET), jump = k.keys("JUMP"), output = k.output })
	"#);
	assert_eq!(out[0]["keys"], json!(["H", "G"]));
	assert_eq!(out[0]["jump"], json!({}));
	assert_eq!(out[0]["output"], "JUMP Function is Now Unbound!", "the window names the action left unbound");
}

#[test]
fn quick_keybind_mouse_buttons_but_left_and_right_and_the_wheel_bind_a_bare_modifier_waits_and_the_screenshot_key_takes_one() {
	let out = run(r#"
		k.open()
		k.hover(T)
		k.mouseUp("LeftButton")
		k.mouseUp("RightButton")
		k.key("LSHIFT")
		emit(k.keys(TARGET))
		k.mouseUp("MiddleButton")
		emit(k.keys(TARGET))
		k.wheel(1)
		emit(k.keys(TARGET))
		k.bind("PRINTSCREEN", "SCREENSHOT")
		k.key("PRINTSCREEN")
		emit({ keys = k.keys(TARGET), shots = k.screenshots, screenshot = k.keys("SCREENSHOT") })
	"#);
	assert_eq!(out[0], json!({}), "left and right click, a bare Shift: nothing");
	assert_eq!(out[1], json!(["BUTTON3"]));
	assert_eq!(out[2], json!(["MOUSEWHEELUP"]));
	assert_eq!(out[3], json!({ "keys": ["MOUSEWHEELUP"], "shots": 1, "screenshot": ["PRINTSCREEN"] }));
}

#[test]
fn quick_keybind_nothing_binds_shows_or_hides_in_a_fight_and_buttons_shown_for_the_mode_go_once_it_ends() {
	let out = run(r#"
		q.combat(true)
		k.open()
		emit({ shown = T:IsShown(), took = k.hover(T) ~= nil })
		k.leave()
		q.combat(false)
		stub.advance(0.3)
		emit(look(T))
		local o = k.hover(T)
		q.combat(true)
		emit({ capture = o:IsShown(), route = k.key("F"), keys = k.keys(TARGET) })
		k.close()
		emit(look(T))
		q.combat(false)
		emit(look(T))
	"#);
	assert_eq!(out[0], json!({ "shown": false, "took": false }), "opened in a fight: nothing shows, the hover is the button's");
	assert_eq!(out[1], json!({ "shown": true, "alpha": 0.45, "label": "Target quest mob" }), "after the fight");
	assert_eq!(out[2], json!({ "capture": false, "route": "window", "keys": {} }), "a fight: the capture frame steps aside");
	assert_eq!(out[3]["shown"], true, "closed in a fight: held until it ends");
	assert_eq!(out[3]["label"], "", "its label back at once");
	assert_eq!(out[4], json!({ "shown": false, "alpha": 1, "label": "" }));
}

#[test]
fn quick_keybind_outside_the_mode_nothing_changes() {
	let out = run(r#"
		q.step({ { t = "kill", target = "Kobold Vermin" } })
		local o = k.hover(T)
		emit({ took = o ~= nil, owner = GameTooltip:GetOwner() == T, route = k.key("F"), keys = k.keys(TARGET), look = look(T) })
	"#);
	assert_eq!(out[0], json!({ "took": false, "owner": true, "route": "game", "keys": {}, "look": { "shown": true, "alpha": 1, "label": "Kobold Vermin" } }));
}

// Options > Keybindings: every Polestar binding (the Recorder's too) in a "Polestar" section of its own, after AddOns
// as the game lists new categories, found by the settings search through its tag (the search reads names and search
// tags, never the section), with a name that fits the list's ~22-character column. The category is a plain string
// (not a global string's name: `Polestar` is the addon's table, so the game shows the string itself).
#[test]
fn key_bindings_sit_in_a_polestar_section_with_the_search_tag_and_short_names() {
	let re = regex::Regex::new(r#"<Binding name="([^"]+)"([^>]*)>"#).unwrap();
	let mut names = Vec::new();
	for addon in ["Polestar", "Polestar_Recorder"] {
		let xml = std::fs::read_to_string(addons_dir().join(addon).join("Bindings.xml")).unwrap();
		for m in re.captures_iter(&xml) {
			let attrs = &m[2];
			assert!(attrs.contains(r#"category="Polestar""#), "{addon} {}: {attrs}", &m[1]);
			assert!(attrs.contains(r#"searchTags="BINDING_TAG_POLESTAR""#), "{addon} {}: {attrs}", &m[1]);
			assert!(!attrs.contains("header="), "{addon} {}: the section is the header", &m[1]);
			if addon == "Polestar" {
				names.push(m[1].to_string());
			}
		}
	}
	let list = names.iter().map(|n| format!("'{n}'")).collect::<Vec<_>>().join(", ");
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: r#"
			local labels = {}
			for _, n in ipairs({ __NAMES__ }) do labels[n] = _G["BINDING_NAME_" .. n] or false end
			emit({ labels = labels, tag = BINDING_TAG_POLESTAR })
		"#
		.replace("__NAMES__", &list),
		..Default::default()
	});
	assert_eq!(out[0]["tag"], "Polestar");
	for n in &names {
		let label = out[0]["labels"][n.as_str()].as_str().unwrap_or_else(|| panic!("{n} has no name"));
		assert!(label.chars().count() <= 22, "{n}: '{label}' is cut in the list");
		assert!(!label.contains("Polestar:"), "{n}: the section already says Polestar");
	}
	let panel = std::fs::read_to_string(addons_dir().join("Polestar_Recorder").join("Panel.lua")).unwrap();
	let rec = regex::Regex::new(r#"BINDING_NAME_POLESTAR_RECORDER_\w+ = L\["([^"]+)"\]"#).unwrap();
	let recorder: Vec<String> = rec.captures_iter(&panel).map(|m| m[1].to_string()).collect();
	assert_eq!(recorder.len(), 2);
	for label in &recorder {
		assert!(label.chars().count() <= 22, "Recorder: '{label}' is cut in the list");
	}
}

// #1684's sweep: in the client a texture's SetAlpha sets its colour's alpha too. The highlight was coloured at 60 %
// and then SetAlpha'd to 0.5 or 1, so on hover it drew the accent wash at full strength. Its strength is now in its
// colour: 60 % hovered, 30 % at rest.
#[test]
fn quick_keybind_the_highlight_is_a_60_percent_wash_on_hover_and_half_that_at_rest() {
	let out = run(r#"
		k.open()
		local hl
		for _, r in ipairs(T.regions) do if r.blend == "ADD" and r:GetDrawLayer() == "OVERLAY" then hl = r end end
		local rest = select(4, hl:GetVertexColor())
		stub.RunScript(T, "OnEnter")
		emit({ rest = rest, hover = select(4, hl:GetVertexColor()), shown = hl:IsShown() })
		k.close()
	"#);
	assert_eq!(out[0]["shown"], true);
	assert!((out[0]["rest"].as_f64().unwrap() - 0.3).abs() < 1e-9, "{}", out[0]);
	assert!((out[0]["hover"].as_f64().unwrap() - 0.6).abs() < 1e-9, "{}", out[0]);
}
