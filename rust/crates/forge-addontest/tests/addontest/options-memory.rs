//! The settings load on demand (addon/Polestar_Options, a LoadOnDemand addon): after login nothing of them
//! is in memory (no window, no UI.Options, no LoadAddOn of it); the first SHOW_OPTIONS loads it, once, and
//! opens the window; later openings load nothing. Their cost is measured as the client counts it (Lua 5.1
//! collectgarbage("count")) and held to budgets: each is the figure measured at the release's code freeze plus
//! 3 %, and they move only then (docs/CI.md, "Memory budgets").
//!
//!   login     the core's resident memory at login (two full collects), the whole of addon/Polestar on a
//!             logged-in stub client
//!   loaded    resident after LoadAddOn("Polestar_Options") and two full collects, over the core's at login
//!   opened    resident after the window first opens (its frames, the first page), over the core's at login
//!   peak      the heap grown while loading it, with the collector stopped
//!
//! Login: the settings overhaul (0.3.8) kept the settings out of it. LOGIN_BASE, the core at login on 0.3.7
//! final, is printed beside the figure: what the core has grown by since. What the overhaul put out of the
//! login, into Polestar_Options: the window, its pages and previews, the settings-only widgets (UI/Controls.lua),
//! every module's rows (<Module>/Options.lua there), Unlock mode (UI/Movers.lua; core keeps its door), the profile
//! strings (Core/ProfileStrings.lua) and the skin picker's cards and presets (Theme/SkinPicker.lua); the Skin
//! API's checks went to their own load-on-demand part, loaded only when another addon brought a skin (back in the
//! core since 0.4.3, #3507: 62 KiB); our own skins and the Atlas layout are one folder of their own,
//! Polestar_Skins, never loaded with it.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

/// The 0.3.7 base's core at login: next at c0c99712a (0.3.7 final), this test's script, 2026-11-11: 11,003 KiB.
const LOGIN_BASE: f64 = 11003.0;
/// KiB (Lua 5.1, 64-bit), measured on next f5bd74406e (2026-11-26, #4143), three runs reading the same:
/// the core at login 14,883 at the post-merge runner's checkout path, 14,858 at a 30-character local one; the
/// settings' addon loaded 2,448, opened 4,193, peak 5,595. Each budget is that figure plus 3 % (docs/CI.md,
/// "Memory budgets"). The login budget is set on the runner's figure: the harness loads every file by its
/// absolute path, and each file's chunk name and the loader's file lists keep that path, about 0.7 KiB a
/// character, so the runner's longer checkout reads 17 to 25 KiB more than a local run of the same tree. A table
/// whose keys pass a power of two doubles its hash part, so the login can jump by tens of KiB at once (Engine.lua's
/// `Own` at 512 keys, the class cards' 1,034 class quests).
const LOGIN: f64 = 15330.0;
const LOADED: f64 = 2522.0;
const OPENED: f64 = 4319.0;
const PEAK: f64 = 5763.0;

fn n(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![Addon::name("Polestar")],
		login: true,
		script: format!(
			r#"
local loads = {{}}
local load = C_AddOns.LoadAddOn
function C_AddOns.LoadAddOn(name, ...)
	loads[#loads + 1] = name
	return load(name, ...)
end
local function count(name) local k = 0; for _, n in ipairs(loads) do if n == name then k = k + 1 end end; return k end
local function full() collectgarbage("collect"); collectgarbage("collect"); return collectgarbage("count") end
stub.advance(1)
{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn after_login_nothing_of_the_settings_window_is_loaded_and_the_first_show_options_loads_it_once() {
	let out = run(r#"
local UI = Polestar.UI
local login = {
	options = UI.Options ~= nil, frame = _G.PolestarOptions ~= nil, profiles = UI.Profiles ~= nil,
	toastsPreview = UI.Toasts.Preview ~= nil, loaded = C_AddOns.IsAddOnLoaded("Polestar_Options"),
	asked = stub.addonsLoaded.Polestar_Options == true,
	-- The settings-only widgets, Unlock mode and the profile strings are the settings' addon's too.
	swatch = Polestar.Widgets.Swatch ~= nil, cards = Polestar.Widgets.Cards ~= nil, movers = _G.PolestarMovers ~= nil,
	moversWaiting = type(Polestar.Movers.pending) == "table", strings = Polestar.Profiles.pendingPositions == nil,
	-- What core keeps: the opener, the size's default, the Blizzard category, the toasts' and trackers' looks.
	stub = type(UI.ShowOptions) == "function", size = Polestar.GetDefault("ui.optionsSize") == false,
	category = UI.settingsCategory ~= nil, toasts = type(UI.Toasts.Attach) == "function", trackers = type(UI.Trackers.Attach) == "function",
}
local opener = UI.ShowOptions
Polestar.Fire("SHOW_OPTIONS", "map")
local first = { loads = count("Polestar_Options"), shown = _G.PolestarOptions ~= nil and PolestarOptions:IsShown(),
	page = UI.Options and UI.Options.page and UI.Options.page.key, replaced = UI.ShowOptions ~= opener }
Polestar.Fire("TOGGLE_OPTIONS")
local hidden = not PolestarOptions:IsShown()
Polestar.Fire("TOGGLE_OPTIONS")
Polestar.Fire("SHOW_OPTIONS", "about")
emit({ login = login, first = first, hidden = hidden, again = PolestarOptions:IsShown(), loads = count("Polestar_Options"),
	page = UI.Options.page.key, all = #loads })"#);
	assert_eq!(
		out["login"],
		serde_json::json!({ "options": false, "frame": false, "profiles": false, "toastsPreview": false, "loaded": false, "asked": false,
			"swatch": false, "cards": false, "movers": false, "moversWaiting": true, "strings": false,
			"stub": true, "size": true, "category": true, "toasts": true, "trackers": true }),
		"nothing of the settings window before it opens; core keeps its door"
	);
	assert_eq!(out["first"], serde_json::json!({ "loads": 1, "shown": true, "page": "map", "replaced": true }), "the first SHOW_OPTIONS loads it and opens the page");
	assert_eq!(out["hidden"], true, "TOGGLE_OPTIONS closes it");
	assert_eq!(out["again"], true);
	assert_eq!(out["loads"], 1, "loaded exactly once");
	assert_eq!(out["page"], "about");
}

#[test]
fn asked_in_combat_it_says_so_once_and_opens_when_combat_ends() {
	let out = run(r#"
stub.inCombat = true
Polestar.Fire("SHOW_OPTIONS")
Polestar.Fire("SHOW_OPTIONS", "map")
local said = 0
for _, m in ipairs(stub.messages) do if m:find("settings open when combat ends", 1, true) then said = said + 1 end end
local during = { loaded = Polestar.UI.Options ~= nil, frame = _G.PolestarOptions ~= nil, loads = count("Polestar_Options") }
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ said = said, during = during, shown = _G.PolestarOptions ~= nil and PolestarOptions:IsShown(), page = Polestar.UI.Options.page.key,
	loads = count("Polestar_Options") })"#);
	assert_eq!(out["said"], 1, "one chat line, however often it is asked");
	assert_eq!(out["during"], serde_json::json!({ "loaded": false, "frame": false, "loads": 0 }), "no addon loads in combat");
	assert_eq!(out["shown"], true, "it opens when the fight ends");
	assert_eq!(out["page"], "map", "on the page last asked for");
	assert_eq!(out["loads"], 1);
}

// /polestar ask in a fight: the settings open with the question when it ends.
#[test]
fn a_question_asked_in_combat_opens_with_the_settings_when_combat_ends() {
	let out = run(r#"
stub.inCombat = true
Polestar.RunCommand("ask how do I hide the arrow")
local during = Polestar.UI.Options ~= nil
stub.inCombat = false
stub.fire("PLAYER_REGEN_ENABLED")
emit({ during = during, shown = PolestarOptions:IsShown(), text = PolestarOptions.Search:GetText(), open = Polestar.UI.Options.Dropdown.Shown() })"#);
	assert_eq!(out, serde_json::json!({ "during": false, "shown": true, "text": "how do I hide the arrow", "open": true }));
}

#[test]
fn the_settings_windows_memory_is_paid_only_after_it_opens_and_stays_within_its_budget() {
	let out = run(r#"
local base = full()
collectgarbage("stop")
assert(Polestar.UI.LoadOptions())
local peak = collectgarbage("count") - base
collectgarbage("restart")
local loaded = full() - base
Polestar.Fire("SHOW_OPTIONS")
stub.advance(0.5)
local opened = full() - base
emit({ core = base, loaded = loaded, opened = opened, peak = peak, shown = PolestarOptions:IsShown() })"#);
	assert_eq!(out["shown"], true);
	let mut over = vec![];
	for (k, budget) in [("loaded", LOADED), ("opened", OPENED), ("peak", PEAK)] {
		let v = n(&out[k]);
		eprintln!("Polestar_Options {k}: {v:.0} KiB (budget {budget}; core at login {:.0})", n(&out["core"]));
		if v > budget {
			over.push(format!("{k} {v:.0} KiB > {budget}"));
		}
	}
	// A real cost moved out of the login (the window's code is not a few lines).
	assert!(n(&out["loaded"]) > 200.0, "the window's addon holds the window: {}", out["loaded"]);
	assert!(over.is_empty(), "over budget: {}", over.join(", "));
}

// The core at login holds none of the settings window (its pages, previews, widgets, every module's rows, the
// profile strings and Unlock mode load with the settings) and stays within its budget.
#[test]
fn at_login_the_core_holds_none_of_the_settings_window_and_stays_within_its_budget() {
	let out = run(r#"
emit({ core = full(), loaded = C_AddOns.IsAddOnLoaded("Polestar_Options"), loads = count("Polestar_Options") })"#);
	let core = n(&out["core"]);
	eprintln!("core at login: {core:.0} KiB (the 0.3.7 base {LOGIN_BASE:.0}, budget {LOGIN:.0}, {:+.0} over the base)", core - LOGIN_BASE);
	assert_eq!(out["loaded"], false, "the settings' addon is not loaded at login");
	assert_eq!(out["loads"], 0);
	assert!(core <= LOGIN, "the core at login: {core:.0} KiB, over its budget {LOGIN:.0} ({:+.0} over the 0.3.7 base)", core - LOGIN_BASE);
}
