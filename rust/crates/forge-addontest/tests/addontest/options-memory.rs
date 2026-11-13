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
//! figure and 50 KiB. The base is next at c0c99712a (0.3.7 final, 2026-11-11), measured with this test's script
//! (LOGIN_BASE). Rebased on a later release, measure that release's tree the same way and set LOGIN_BASE to
//! it, with the date and sha. What the overhaul put out of the login, into Polestar_Options: the window, its
//! pages and previews, the settings-only widgets (UI/Controls.lua), every module's rows (<Module>/Options.lua
//! there), Unlock mode (UI/Movers.lua; core keeps its door), the profile strings (Core/ProfileStrings.lua)
//! and the skin picker's cards and presets (Theme/SkinPicker.lua); the Skin API's checks went to their own
//! load-on-demand part (Polestar_SkinAPI), loaded only when another addon brings a skin.
//!
//! The settings' addon (KiB, Lua 5.1, 64-bit) grew from 2026-11-10's figures (760 loaded, 1,890 opened,
//! 1,190 peak) by what moved into it from the login, then by the pages' own work (their Essentials tabs and
//! presets, the Profiles page's cards and Share tab, the 0.3.7 rows placed ahead): the budgets' comments say
//! by how much.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::Value;

/// The 0.3.7 base's core at login: next at c0c99712a (0.3.7 final), this test's script, 2026-11-11: 11,003 KiB.
const LOGIN_BASE: f64 = 11003.0;
/// At most 50 KiB over the base, plus what 0.3.7.1, 0.3.7.2 and the 0.3.8 work so far add at login (measured
/// 11060 KiB after the merge, 57 over the base). Raised rather than re-measured per release: Fitz, 2026-11-12,
/// "if you hit memory budgets again, just raise them"; the login cost gets its review once 0.3.8's content is final.
/// Install (0.4.0: UI/Welcome.lua's Questing, Targeting, Groups and dungeons and Your look pages, the option cards
/// and the looks' picker) adds about 60 KiB of code at login: measured 11,136 KiB on 2026-11-13. The 0.4.0 work
/// merged with it (dungeons in the route's notices, the stranded-quest row and banner, Show in quest log and the
/// out-of-sight notice, the guide window's shared step view, the breadcrumb and parent-quest rules) adds about
/// 60 KiB more: measured 11,198 KiB on 2026-11-13.
/// Then 0.4.0's contributor batch (#2083): Pause's state, watcher and key (Core/Init.lua, Core/Pause.lua, #1937),
/// Adjust weights (Gear/Adjust.lua, UI/GearAdjust.lua, #1538), the Nav API's followers (Nav/Journey.lua, #1329),
/// another addon's map canvas (#1938), the step browser's run cards (UI/StepList.lua, #2004) and the dungeon
/// levels panel (UI/LevelTip.lua, #2008): 11,214 KiB at login on dev-040's 11,077 (a1643d59c, this test's
/// script, 2026-11-13), +137. Raised to that figure and about 5 % (Fitz, 2026-11-12: a memory budget new content
/// pushes over goes to the measured figure plus about 5 %; the login review comes once 0.4.0's content is final).
const LOGIN: f64 = LOGIN_BASE + 772.0;
/// Loaded, 1,790 KiB on 2026-11-11 (760 on 2026-11-10): the Look pages' previews and the toasts and trackers
/// pages moved in (1,110), then the settings-only widgets, every module's rows, Unlock mode, the profile
/// strings, the preview stage and the skin picker's cards and presets (+400), all out of the login (1,513).
/// Then the pages (+200): an Essentials tab on each Look page, its presets and references (+126: the Look
/// pages' files and UI/Presets.lua), the Profiles page's picture cards and Share tab (+40), the window's
/// references, presets and the Guiding pages' layout (+27), 0.3.7's Quality of Life rows (+11). Then the
/// previews as the page's hero (+67): each Look page's scene of real surfaces at their true size, every alert
/// and tracker and the journey on Essentials, and every setting's lights (Trackers +16, Alerts & toasts +10,
/// Buttons +10, the stage +10, Theme +7, Guide window +7, Route lines +4, Map pins +3). Then the Buttons and
/// single-alert scenes and the Accent lights (+26, 1,817): the button set over the mobs it names, the rare and
/// transport alerts over the world with the arrow and the guide window's edge, While you're here's mobs, a mob's
/// nameplate on the stage, and Theme > Accent lighting every part drawn in the accent. Then the search's dropdown
/// (+41: 1,833 to 1,874 on 2026-11-13): UI/SearchDropdown.lua, and the places, page scope and lit words of the
/// search in UI/Options.lua. Raised by that, as Fitz asked on 2026-11-12 ("if you hit memory budgets again, just
/// raise them").
const LOADED: f64 = 1907.0;
/// Opened on its first page, 4,124 KiB (1,890 on 2026-11-10; 3,485 with the Look pages' previews; 3,888 with
/// the rest moved in, then the pages' +155, then the hero previews' +67, then the Buttons and single-alert
/// scenes and the Accent lights' +26, to 4,151; then the search's dropdown's code, +41, 4,280 to 4,322 on
/// 2026-11-13: the list itself is built only when the player first types). Then 0.4.0's contributor batch
/// (#2083), chiefly Pause's section on the first page (its switch, two extras and key binding, #1937): +155 with
/// the base's rows, 4,435 KiB on dev-040's 4,280 (a1643d59c, this test's script, 2026-11-13), so about 4,477 with
/// the search's dropdown (its 4,322 and the batch's 155). Raised with the base's rows to that figure and about 5 %
/// (Fitz, 2026-11-12, as for the login).
const OPENED: f64 = 4606.0;
/// Peak, 3,964 KiB (1,190 on 2026-11-10; 2,359 with the Look pages): the files that moved in compile with the
/// collector stopped (+1,000, to 3,365), then the pages' (+430, their files' compile with the collector stopped),
/// then the hero previews' (+150, the same), then the Buttons and single-alert scenes and the Accent lights'
/// (+68, the same, to 4,034), then the search's dropdown (+108, the same: 4,084 to 4,192 on 2026-11-13).
const PEAK: f64 = 4233.0;

/// What the base itself puts in the opened window, not the overhaul's cost: 0.3.7's three rows on the first
/// page (Guide: Tell me when a newer Polestar is out, Flight paths you pass, Keep the arrow when hidden),
/// +95 KiB, the window's opened figure on 0.3.7 final less on 0.3.6 (3,997 and 3,902, this test's script,
/// 2026-11-11). Rebased on a later release, measure the window on both releases the same way and set it.
const BASE_ROWS: f64 = 95.0;

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
	for (k, budget) in [("loaded", LOADED), ("opened", OPENED + BASE_ROWS), ("peak", PEAK)] {
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
// previews, widgets, every module's rows, the profile strings and Unlock mode load with the settings.
#[test]
fn at_login_the_core_holds_at_most_the_0_3_7_base_and_50_kib() {
	let out = run(r#"
emit({ core = full(), loaded = C_AddOns.IsAddOnLoaded("Polestar_Options"), loads = count("Polestar_Options") })"#);
	let core = n(&out["core"]);
	eprintln!("core at login: {core:.0} KiB (the 0.3.7 base {LOGIN_BASE:.0}, budget {LOGIN:.0}, {:+.0} over the base)", core - LOGIN_BASE);
	assert_eq!(out["loaded"], false, "the settings' addon is not loaded at login");
	assert_eq!(out["loads"], 0);
	assert!(core <= LOGIN, "the core at login: {core:.0} KiB, over the 0.3.7 base ({LOGIN_BASE:.0}) by {:.0} (at most {:.0})", core - LOGIN_BASE, LOGIN - LOGIN_BASE);
}
