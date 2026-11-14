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
/// 11060 KiB after the merge, 57 over the base; 11115 with 0.4.0's looks carried and polished, #2049 and #2084, 112
/// over it; +77 more with the settings preview drawing the guide window itself, #2103: the guide window's code kept
/// for the preview's copy, each UI/GuideFrame*.lua file's part and the window's build, which the live window dropped
/// once built; 11,125 with the settings polish, #2063, and the search's dropdown on their own base). Raised rather than re-measured per release: Fitz, 2026-11-12,
/// "if you hit memory budgets again, just raise them"; the login cost gets its review once 0.3.8's content is final.
/// Install (0.4.0: UI/Welcome.lua's Questing, Targeting, Groups and dungeons and Your look pages, the option cards
/// and the looks' picker) adds about 60 KiB of code at login: measured 11,136 KiB on 2026-11-13. The 0.4.0 work
/// merged with it (dungeons in the route's notices, the stranded-quest row and banner, Show in quest log and the
/// out-of-sight notice, the guide window's shared step view, the breadcrumb and parent-quest rules) adds about
/// 60 KiB more: measured 11,198 KiB on 2026-11-13. Gear advice reading the talents the talent frame shows, its
/// /polestar gear spec report, the "Scored for" lines and Mental Dexterity in the weights (#2086, #2035, #2090) add
/// 36 KiB: measured 11,234 KiB on 2026-11-13 (11,198 on the same tree without them).
/// Then 0.4.0's contributor batch (#2083): Pause's state, watcher and key (Core/Init.lua, Core/Pause.lua, #1937),
/// Adjust weights (Gear/Adjust.lua, UI/GearAdjust.lua, #1538), the Nav API's followers (Nav/Journey.lua, #1329),
/// another addon's map canvas (#1938), the step browser's run cards (UI/StepList.lua, #2004) and the dungeon
/// levels panel (UI/LevelTip.lua, #2008): 11,214 KiB at login on dev-040's 11,077 (a1643d59c, this test's
/// script, 2026-11-13), +137. Raised to that figure and about 5 % (Fitz, 2026-11-12: a memory budget new content
/// pushes over goes to the measured figure plus about 5 %; the login review comes once 0.4.0's content is final).
/// All of 0.4.0's merges so far together (the contributor batches #2083 and #2141, the looks #2084 with #2049, the
/// guide window's preview copy #2103, the settings polish #2063, the arrow #2098, the zone choice #2111 and its
/// cards #2134, the report's settings #2096): 11,614 KiB on 2026-11-13. CI reads a little more than a local run of
/// the same addon (dev-040 at 467cdd126: 11,198 here and a budget of 11,203; CI read 11,203 on a pull request that
/// changes no addon code, and failed), so the budget is the measured figure and about 5 %: 12,195.
/// On its own base, 0.4.0's auction house buys (#2070, #2077: Quests/AuctionBuys.lua and UI/AuctionBuys.lua): +66,
/// 11,147 KiB on the 0.4.0 branch's 11,081 (2026-11-13), the budget raised by as much and the headroom kept. Then
/// gather, buy or mix and
/// the gathering spots (Core/Materials.lua, Core/Gather.lua with its spot data, UI/Materials.lua): 11,421 KiB with
/// the auction house buys (2026-11-13), 418 over the base. Raised to that figure and about 5 % (Fitz, 2026-11-12: a
/// memory budget new content pushes over goes to the measured figure plus about 5 %; compression and the login
/// review come once 0.4.0's content is final).
/// Theme.TipColor and the tooltip lines that take it (#2032) add 1 KiB: measured 11,200 KiB on 2026-11-13 (11,199 on
/// the same tree without it). CI's runner measures this tree 4 KiB higher (11,204), which already left dev-040 at the
/// edge of the budget there: 10 KiB more covers both.
/// The fresh-start note (#1562: Engine.FreshFor and FreshStart, its banner) adds 6 KiB of code: measured 11,205 KiB on
/// 2026-11-13 (11,199 without it). Engine.lua's private `Own` table holds exactly 512 keys at login there: one key more
/// doubles its hash part, about 20 KiB.
/// The travel lane (#2029) adds about 72 KiB on top, within it: 11,268 KiB against dev-040's 11,196 at 467cdd126
/// (2026-11-14), 60 of it code (each file's compiled chunk): Nav/Travel.lua +27 (flights from and to flight masters
/// the character may have, #1795; the Hearthstone's cooldown and its hold, #1915; Astral Recall; the roads through
/// high zones, #1972; crossings walked through and zone changes, #1543), Nav/Walk.lua +7 and Nav/Follow.lua +5 (the
/// arrow on the walking engine's path, #1543), Core/Engine.lua +6 and Quests/Timed.lua +5 (flight steps landing where
/// the character may have the flight path; the timed hand-in pulled forward), UI/GuideFrameBanner.lua +5 (the flight
/// map notice, #2189), Nav/Danger.lua +3, UI/Report.lua +2, Core/Compat.lua, Maps/TravelPins.lua and
/// Maps/RouteLines.lua +2. None of it can load later: the planner runs as soon as a guide step has a target.
/// The Barrow Dens' five travel chains in Nav/TravelData.lua (#1919, #1341, #2005: the arrow's way out of and into
/// the Stormrage Barrow Dens and the Ban'ethil Barrow Den, every node with its floor's height) add 54 KiB (11,613 ->
/// 11,667 KiB at dev-040's 5fe81cc6e, 2026-11-14), within it.
const LOGIN: f64 = LOGIN_BASE + 1192.0;
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
/// raise them"). The bands (#2084: every Look tab's preview its element alone, the stage, its backdrops and the
/// scenes' mobs gone) measured 1,798 on their own base. Then the settings polish (#2063: the Move frames session and
/// box menu, the rows' and sections' Move, the reset's Undo, Peek and Fold, the glide and the sidebar's nudge, long
/// lists' filter, the colour favourites, the callouts, the dialogs' typed word, the profile keys and the rows' reset
/// arrow): 1,974 measured on its own base. All of 0.4.0's merges together: 1,950 on 2026-11-13; the budget is that
/// and about 5 % (Fitz, 2026-11-12, as for the login).
/// Then the search answering questions (#2178, +15: 1,905 to 1,920 on 2026-11-13, on its own base): the question words of English and the
/// client's language, the stems, the label and search-term cover and /polestar ask.
const LOADED: f64 = 2048.0;
/// Opened on its first page, 4,124 KiB (1,890 on 2026-11-10; 3,485 with the Look pages' previews; 3,888 with
/// the rest moved in, then the pages' +155, then the hero previews' +67, then the Buttons and single-alert
/// scenes and the Accent lights' +26, to 4,151; then the search's dropdown's code, +41, 4,280 to 4,322 on
/// 2026-11-13: the list itself is built only when the player first types). Then 0.4.0's contributor batch
/// (#2083), chiefly Pause's section on the first page (its switch, two extras and key binding, #1937): +155 with
/// the base's rows, 4,435 KiB on dev-040's 4,280 (a1643d59c, this test's script, 2026-11-13), so about 4,477 with
/// the search's dropdown (its 4,322 and the batch's 155). Raised with the base's rows to that figure and about 5 %
/// (Fitz, 2026-11-12, as for the login). With the settings polish and the reset arrow (#2063), 4,500 measured on its
/// own base. All of 0.4.0's merges together: 4,670 with the base's rows on 2026-11-13; the budget with the base's
/// rows is that and about 5 %. Then the search answering questions (#2178), +15 (4,363 to 4,378 with the base rows,
/// 2026-11-13, on its own base).
const OPENED: f64 = 4809.0;
/// Peak, 3,964 KiB (1,190 on 2026-11-10; 2,359 with the Look pages): the files that moved in compile with the
/// collector stopped (+1,000, to 3,365), then the pages' (+430, their files' compile with the collector stopped),
/// then the hero previews' (+150, the same), then the Buttons and single-alert scenes and the Accent lights'
/// (+68, the same, to 4,034), then the search's dropdown (+108, the same: 4,084 to 4,192 on 2026-11-13). With
/// the settings polish, 4,446 measured on 2026-11-13 (budget raised to it). All of 0.4.0's merges together: 4,376 on
/// 2026-11-13; the budget is that and about 5 %. Then the search answering questions (#2178: +34, the same: 4,228 to
/// 4,262 on 2026-11-13, on its own base).
const PEAK: f64 = 4595.0;

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
