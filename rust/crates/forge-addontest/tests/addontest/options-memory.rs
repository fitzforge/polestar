//! The settings load on demand (addon/Polestar_Options, a LoadOnDemand addon): after login nothing of them
//! is in memory (no window, no UI.Options, no LoadAddOn of it); the first SHOW_OPTIONS loads it, once, and
//! opens the window; later openings load nothing. Their cost is measured as the client counts it (Lua 5.1
//! collectgarbage("count")) and held to budgets: lower a budget when a change lowers the figure, never raise
//! one to make a change pass.
//!
//!   login     the core's resident memory at login (two full collects), the whole of addon/Polestar on a
//!             logged-in stub client
//!   loaded    resident after LoadAddOn("Polestar_Options") and two full collects, over the core's at login
//!   opened    resident after the window first opens (its frames, the first page), over the core's at login
//!   peak      the heap grown while loading it, with the collector stopped
//!
//! Login (0.3.8: the settings overhaul costs nothing a player notices at login): at most the 0.3.7 base's
//! figure and 50 KiB. The base is next at 0df6f58ab (2026-11-10), measured with this test's script
//! (LOGIN_BASE). Rebased on a later release, measure that release's tree the same way and set LOGIN_BASE to
//! it, with the date and sha. What the overhaul put out of the login, into Polestar_Options: the window, its
//! pages and previews, the settings-only widgets (UI/Controls.lua), every module's rows (<Module>/Options.lua
//! there), Unlock mode (UI/Movers.lua; core keeps its door) and the profile strings
//! (Core/ProfileStrings.lua).
//!
//! The settings' addon (KiB, Lua 5.1, 64-bit) grew from 2026-11-10's figures (760 loaded, 1,890 opened,
//! 1,190 peak) by what moved into it from the login, not by new work: the budgets' comments say by how much.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

/// The 0.3.7 base's core at login: next at 0df6f58ab, this test's script, 2026-11-11: 10,428.4 KiB.
const LOGIN_BASE: f64 = 10428.4;
/// At most 50 KiB over the base.
const LOGIN: f64 = LOGIN_BASE + 50.0;
const LOADED: f64 = 900.0;
const OPENED: f64 = 2200.0;
const PEAK: f64 = 1400.0;

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

// The core at login holds at most the 0.3.7 base and 50 KiB: the settings overhaul's window, pages,
// previews, profile strings and Unlock mode load with the settings, and the rows core modules register
// are built only when the settings first need them.
#[test]
fn at_login_the_core_holds_at_most_the_0_3_7_base_and_50_kib() {
	let out = run(r#"
emit({ core = full(), loaded = C_AddOns.IsAddOnLoaded("Polestar_Options"), loads = count("Polestar_Options") })"#);
	let core = n(&out["core"]);
	eprintln!("core at login: {core:.0} KiB (the 0.3.7 base {LOGIN_BASE:.0}, budget {LOGIN:.0}, {:+.0} over the base)", core - LOGIN_BASE);
	assert_eq!(out["loaded"], false, "the settings' addon is not loaded at login");
	assert_eq!(out["loads"], 0);
	assert!(core <= LOGIN, "the core at login: {core:.0} KiB, over the 0.3.7 base ({LOGIN_BASE:.0}) by {:.0} (at most 50)", core - LOGIN_BASE);
}
