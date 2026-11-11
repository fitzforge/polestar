//! The settings window loads on demand (addon/Polestar_Options, a LoadOnDemand addon):
//! after login nothing of it is in memory (no window, no UI.Options, no LoadAddOn of it); the first
//! SHOW_OPTIONS loads it, once, and opens the window; later openings load nothing. Its cost is measured as
//! the client counts it (Lua 5.1 collectgarbage("count")) and held to a budget: lower a budget when a change
//! lowers the figure, never raise one to make a change pass.
//!
//!   loaded    resident after LoadAddOn("Polestar_Options") and two full collects, over the core's at login
//!   opened    resident after the window first opens (its frames, the first page), over the core's at login
//!   peak      the heap grown while loading it, with the collector stopped
//!
//! KiB (Lua 5.1, 64-bit), measured on 2026-11-10 with the whole of addon/Polestar and a logged-in stub
//! client: the core at login was 9,940 resident with the window's code in it (before the move) and 9,180
//! after the move; the window's addon costs 760 resident once loaded (1,190 at the peak) and 1,890 once the
//! window is open on its first page: paid only by a player who opens the settings.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

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
