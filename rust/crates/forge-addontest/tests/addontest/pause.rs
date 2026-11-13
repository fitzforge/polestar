//! Pause (Core/Init.lua, Core/Pause.lua): one switch per character that makes the guide step aside on the way to a
//! dungeon and inside it, and resumes by itself once the player is back out alive. It pauses what Polestar shows and
//! steers with, not the Engine, which keeps following the quest log. The arrow drops the Engine's waypoint (a hold
//! and points the player picks still show), the guide window and what goes with it go, the while-here toast and
//! chime stay quiet; the step's map pins and the quest automation go too only with their settings. It never writes
//! ui.shown, nav.arrow or hidden, and it leaves hiding Polestar as it is (hiding leaves it). The arrow on Nav's
//! harness (tests/lua/stub_nav.lua, as hide-with-guide.rs), the window on the UI harness (tests/lua/stub_ui.lua, as
//! ui.rs's instance tests), the watcher on the QoL harness's instances and ghost (tests/lua/stub_qol.lua),
//! automation on Core in the stub world as automation.rs, while-here on the whole addon.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, is_match, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

fn run_nav(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml"])],
		login: true,
		script: script.into(),
		..Default::default()
	})
}

// The guide's waypoint, the arrow's target, the travel button (wanted, shown) and the arrow.
const NAV_PRE: &str = r#"
local P, N, nav = Polestar.Nav.prompts, Polestar.Nav, stub.nav
nav.items[6948] = 1
N.GetRoute = function() return { { kind = "hearth" }, { kind = "walk" } }, 1 end
local wp = { map = 9000, x = 50, y = 20, label = "Somewhere", stepIndex = 1, goalIndex = 1, kind = "goto", r = 8 }
local function look()
	stub.runTimers()
	local t = N.GetTarget()
	return { t and t.label or false, P.Wanted() ~= nil, P.button ~= nil and P.button:IsShown(), N.arrow.frame:IsShown() }
end
nav.setWaypoint(wp)
N.Refresh()
"#;

#[test]
fn the_arrow_and_travel_button_step_aside_a_hold_and_a_picked_point_still_show_and_resuming_brings_back_the_same_target() {
	let out = run_nav(
		&[
			NAV_PRE,
			r#"
		emit(look())
		Polestar.SetPaused(true, "hand")
		emit({ look(), Polestar.Paused(), Polestar.Get("nav.arrow") == true })
		-- The death helper's way back (Nav.Hold) shows over it, then a point picked by hand.
		N.Hold(9000, 50, 80, "Your corpse")
		emit(look())
		N.Unhold()
		emit(look())
		N.SetTarget(9000, 20, 20, "Picked")
		emit(look())
		N.ReleaseTarget()
		emit(look())
		Polestar.SetPaused(false, "hand")
		local back = N.GetTarget()
		emit({ look(), back == wp, Polestar.CharState().pause == nil })
		-- The Engine moves on while paused: the arrow takes its newest waypoint on resuming.
		Polestar.SetPaused(true, "hand")
		nav.changeStep(2, { map = 9000, x = 50, y = 30, label = "Further", stepIndex = 2, goalIndex = 1, kind = "goto", r = 8 })
		stub.runTimers()
		local during = look()
		Polestar.SetPaused(false, "hand")
		emit({ during, look() })"#,
		]
		.concat(),
	);
	assert_eq!(out[0], json!(["Somewhere", true, true, true]), "the guide's arrow and travel button");
	assert_eq!(out[1], json!([[false, false, false, false], "armed", true]), "paused outside: armed, the arrow and travel button gone, nav.arrow untouched");
	assert_eq!(out[2], json!(["Your corpse", true, true, true]), "the way back to the corpse shows, with its travel button");
	assert_eq!(out[3], json!([false, false, false, false]), "let go of: nothing again");
	assert_eq!(out[4], json!(["Picked", true, true, true]), "a point picked by hand shows, with its travel button");
	assert_eq!(out[5], json!([false, false, false, false]));
	assert_eq!(out[6], json!([["Somewhere", true, true, true], true, true]), "resumed: the same waypoint, the saved state gone");
	assert_eq!(out[7], json!([[false, false, false, false], ["Further", true, true, true]]), "the Engine kept following; resuming shows where it is now");
}

#[test]
fn hiding_polestar_and_pausing_it_leave_each_other_as_they_were_either_way_round() {
	let out = run_nav(
		&[
			NAV_PRE,
			r#"
		local fired = {}
		Polestar.On("GUIDE_SHOWN", function(shown) fired[#fired + 1] = shown end)
		local function state()
			local l = look()
			return { Polestar.Hidden(), Polestar.Paused() or false, l[1], l[4] }
		end
		local seen = {}
		-- Hidden first, paused and resumed under it.
		Polestar.SetHidden(true); seen[#seen + 1] = state()
		Polestar.SetPaused(true, "hand"); seen[#seen + 1] = state()
		Polestar.SetHidden(false); seen[#seen + 1] = state()
		Polestar.SetHidden(true); seen[#seen + 1] = state()
		Polestar.SetPaused(false, "hand"); seen[#seen + 1] = state()
		Polestar.SetHidden(false); seen[#seen + 1] = state()
		-- Paused first, hidden and shown under it.
		Polestar.SetPaused(true, "hand"); seen[#seen + 1] = state()
		Polestar.SetHidden(true); Polestar.SetHidden(false); seen[#seen + 1] = state()
		Polestar.SetPaused(false, "hand"); seen[#seen + 1] = state()
		local settings = PolestarDB.settings or {}
		emit({ seen = seen, fired = fired, hidden = Polestar.CharState().hidden or false, mode = Polestar.CharState().pause or false,
			uiShown = (settings.ui or {}).shown == nil, navArrow = (settings.nav or {}).arrow == nil })"#,
		]
		.concat(),
	)
	.remove(0);
	assert_eq!(
		out["seen"],
		json!([
			[true, false, "Somewhere", false],
			[true, "armed", false, false],
			[false, "armed", false, false],
			[true, "armed", false, false],
			[true, false, "Somewhere", false],
			[false, false, "Somewhere", true],
			[false, "armed", false, false],
			[false, "armed", false, false],
			[false, false, "Somewhere", true],
		])
	);
	assert_eq!(out["fired"], json!([false, true, false, true]), "GUIDE_SHOWN only as what goes with the guide changes");
	assert_eq!(out["hidden"], false);
	assert_eq!(out["mode"], false);
	assert_eq!(out["uiShown"], true, "ui.shown is never written");
	assert_eq!(out["navArrow"], true, "nav.arrow is never written");
}

// The step goals' and while-here lines' map pins aim through the Engine (Engine.AimGoal, Engine.AimWhileHere), whose
// waypoint the pause drops: while paused a click sets a point instead, so it still points the arrow.
#[test]
fn a_click_on_a_step_goal_s_map_pin_while_paused_sets_a_point_the_arrow_shows() {
	let out = run_nav(
		&[
			NAV_PRE,
			r#"
		nav.engine.views[1] = { index = 1, goals = { { index = 1, status = "active", text = "Goal pin", map = 9000, x = 60, y = 60 } } }
		-- No travel route here: NAV_PRE's stand-in route is for the travel button (its legs have no `to`, which
		-- Travel.lua's real legs always have), and Layers.Update draws the route's stops from it.
		N.GetRoute = function() return nil end
		local aimed = 0
		function nav.Engine.AimGoal() aimed = aimed + 1; return true end
		local function click()
			N.layers.Update()
			for _, p in ipairs(Polestar.Pins.GetLayer("nav.goals") or {}) do
				if p.label == "Goal pin" then p.onClick("LeftButton") return true end
			end
			return false
		end
		Polestar.SetPaused(true, "hand")
		local clicked = click()
		local t = N.GetTarget()
		local during = { clicked = clicked, aimed = aimed, target = t and t.label or false, override = N.IsOverride(), arrow = look()[4] }
		N.ReleaseTarget()
		Polestar.SetPaused(false, "hand")
		click()
		emit({ during = during, aimedAfter = aimed })"#,
		]
		.concat(),
	)
	.remove(0);
	assert_eq!(out["during"], json!({ "clicked": true, "aimed": 0, "target": "Goal pin", "override": true, "arrow": true }), "a point, not the Engine");
	assert_eq!(out["aimedAfter"], 1, "resumed, the click goes through the Engine again");
}

// "Hide the step's map pins while paused" (pause.map) takes the upcoming steps' pins (Nav/Upcoming.lua) too; paused
// without it they stay, and they come back on resuming. The steps as nav.rs's upcoming test gives them.
#[test]
fn hide_the_step_s_map_pins_while_paused_also_takes_the_upcoming_steps_pins() {
	let out = run_nav(
		&[
			NAV_PRE,
			r#"
		nav.engine.views[3] = { status = "current", goals = { { map = 9000, x = 40, y = 40, status = "active" } } }
		nav.engine.views[4] = { title = "Goldshire", status = "upcoming", goals = { { map = 9000, x = 42, y = 65, status = "pending" } } }
		function nav.Engine.GetLiveStep() return 3 end
		function nav.Engine.GetStepCount() return 4 end
		Polestar.Set("nav.upcomingPins", true)
		local function pins()
			N.upcoming.Refresh()
			return #(Polestar.Pins.GetLayer("nav.upcoming") or {})
		end
		local r = { on = pins() }
		Polestar.SetPaused(true, "hand")
		r.paused = pins()
		Polestar.Set("pause.map", true)
		r.withSetting = pins()
		Polestar.SetPaused(false, "hand")
		r.resumed = pins()
		emit(r)"#,
		]
		.concat(),
	)
	.remove(0);
	assert_eq!(out, json!({ "on": 1, "paused": 1, "withSetting": 0, "resumed": 1 }));
}

#[test]
fn a_command_asking_for_the_arrow_while_paused_says_why_nothing_shows_and_way_still_points_it() {
	let out = run_nav(
		&[
			NAV_PRE,
			r#"
		Polestar.SetPaused(true, "hand")
		local function said(command)
			local before = #stub.messages
			SlashCmdList.POLESTAR(command)
			local n = 0
			for i = before + 1, #stub.messages do
				if stub.messages[i]:find("Polestar is paused: the arrow follows", 1, true) then n = n + 1 end
			end
			return n
		end
		local arrow = said("arrow show")
		local way = said("way 50 20 Here")
		local t = N.GetTarget()
		emit({ arrow = arrow, way = way, target = t and t.label or false, shown = look()[4] })"#,
		]
		.concat(),
	)
	.remove(0);
	assert_eq!(out, json!({ "arrow": 1, "way": 0, "target": "Here", "shown": true }));
}

// ------------------------------------------------------------------------------------------------------------
// The guide window (the UI harness)
// ------------------------------------------------------------------------------------------------------------

const UI_FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// enter(kind): through a loading screen into an instance of `kind`, or out with nil, and the frame after it (the
// watcher looks then). notices: what went up at the top of the screen (Nav/Alerts.lua's ShowNotice).
const UI_PRE: &str = r#"
local GF, UI = Polestar.UI.GuideFrame, Polestar.UI
local F = PolestarGuideFrame
local function enter(kind)
	uistub.instance = kind
	stub.fire("PLAYER_ENTERING_WORLD", false, false)
	stub.runTimers()
end
local notices = {}
Polestar.Nav.alerts = {
	ShowNotice = function(title, line, seconds) notices[#notices + 1] = { title, line, seconds } end,
	HideNotice = function() end,
}
local function said(needle)
	local n = 0
	for _, m in ipairs(stub.messages) do if m:find(needle, 1, true) then n = n + 1 end end
	return n
end
local function lastLine() return ((stub.messages[#stub.messages] or ""):gsub("^.-Polestar|r: ", "")) end
uistub.setGuide(uistub.elwynn, 3)
"#;

fn run_ui(saved: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &UI_FILES)],
		saved: if saved.is_empty() { vec![] } else { vec![("Polestar".into(), saved.into())] },
		script: format!("uistub.install()\nstub.login()\n{UI_PRE}\n{script}"),
		..Default::default()
	})
}

#[test]
fn paused_outside_the_window_goes_until_the_player_is_back_out_alive_and_ui_shown_is_never_written() {
	let out = run_ui(
		"",
		r#"
		local fired = {}
		Polestar.On("GUIDE_SHOWN", function(shown) fired[#fired + 1] = shown end)
		local before = F:IsShown()
		Polestar.SetPaused(true, "hand")
		local armed = { mode = Polestar.Paused(), shown = F:IsShown(), guide = Polestar.GuideShown(), said = said("Polestar is paused: ") }
		enter("party")
		local inside = { mode = Polestar.Paused(), shown = F:IsShown(), hint = said("hides in dungeons and battlegrounds") }
		enter(nil)
		local settings = PolestarDB.settings or {}
		emit({ before = before, armed = armed, inside = inside, notices = notices,
			after = { mode = Polestar.Paused() or false, shown = F:IsShown(), guide = Polestar.GuideShown(), saved = Polestar.CharState().pause or false, line = lastLine() },
			firstFired = fired[1], lastFired = fired[#fired], stored = (settings.ui or {}).shown == nil })"#,
	)
	.remove(0);
	assert_eq!(out["before"], true);
	assert_eq!(out["armed"], json!({ "mode": "armed", "shown": false, "guide": false, "said": 1 }), "armed outside: the window and what goes with it go");
	assert_eq!(out["notices"], json!([["Polestar is paused", "Type /polestar resume, or open the guide window.", 10]]), "one notice says how to resume");
	assert_eq!(out["inside"], json!({ "mode": "inside", "shown": false, "hint": 0 }), "inside: still away, and no instance hint on top");
	assert_eq!(
		out["after"],
		json!({ "mode": false, "shown": true, "guide": true, "saved": false, "line": "Polestar resumed: you are back out of the dungeon." }),
		"out alive: resumed, the window back"
	);
	assert_eq!(out["firstFired"], false, "GUIDE_SHOWN as it paused");
	assert_eq!(out["lastFired"], true, "and as it resumed");
	assert_eq!(out["stored"], true, "ui.shown never written");
}

#[test]
fn asking_for_the_guide_window_resumes_and_shows_it_outside_and_inside() {
	let out = run_ui(
		"",
		r#"
		Polestar.SetPaused(true, "hand")
		Polestar.Fire("TOGGLE_FRAME")
		local outside = { mode = Polestar.Paused() or false, shown = F:IsShown(), line = lastLine() }
		Polestar.SetPaused(true, "hand")
		enter("party")
		local inMode = F:IsShown()
		Polestar.Fire("TOGGLE_FRAME")
		local inside = { mode = Polestar.Paused() or false, shown = F:IsShown(), stored = Polestar.Get("ui.shown") }
		Polestar.SetPaused(true, "hand")
		local again = { mode = Polestar.Paused(), shown = F:IsShown() }
		Polestar.Fire("SHOW_FRAME")
		emit({ outside = outside, inMode = inMode, inside = inside, again = again, show = { mode = Polestar.Paused() or false, shown = F:IsShown() } })"#,
	)
	.remove(0);
	assert_eq!(out["outside"], json!({ "mode": false, "shown": true, "line": "Polestar resumed: the guide window is back." }));
	assert_eq!(out["inMode"], false);
	assert_eq!(out["inside"], json!({ "mode": false, "shown": true, "stored": true }), "inside, the window opens for the visit");
	assert_eq!(out["again"], json!({ "mode": "inside", "shown": false }), "paused inside: inside at once");
	assert_eq!(out["show"], json!({ "mode": false, "shown": true }), "/polestar show does the same");
}

#[test]
fn the_window_menu_and_the_commands_pause_and_resume_and_always_say_what_they_did() {
	let out = run_ui(
		"",
		r#"
		local function menuPick(text)
			GF.menuButton:Click()
			for _, r in ipairs(PolestarMenu.rows) do if r:IsShown() and r.Text:GetText() == text then r:Click() return r end end
		end
		menuPick("Pause")
		local fromMenu, menuLine = Polestar.Paused(), lastLine()
		local lines = {}
		for _, cmd in ipairs({ "pause on", "pause off", "pause off", "pause", "pause", "pause", "resume", "resume" }) do
			Polestar.RunCommand(cmd)
			lines[#lines + 1] = { lastLine(), Polestar.Paused() or false }
		end
		emit({ fromMenu = fromMenu, menuLine = menuLine, lines = lines })"#,
	)
	.remove(0);
	assert_eq!(out["fromMenu"], "armed");
	assert!(
		out["menuLine"].as_str().unwrap().starts_with("Polestar is paused: the arrow and the guide window step aside. It resumes by itself when you leave the dungeon alive."),
		"{}",
		out["menuLine"]
	);
	let lines = out["lines"].as_array().unwrap();
	let resumed = "Polestar resumed: the arrow and the guide window are back.";
	assert_eq!(lines[0], json!(["Polestar is already paused.", "armed"]), "pause on, paused");
	assert_eq!(lines[1], json!([resumed, false]), "pause off");
	assert_eq!(lines[2], json!(["Polestar is not paused.", false]), "pause off, not paused");
	assert!(lines[3][0].as_str().unwrap().starts_with("Polestar is paused: "), "pause toggles on: {}", lines[3]);
	assert_eq!(lines[3][1], "armed");
	assert_eq!(lines[4], json!([resumed, false]), "pause toggles off");
	assert_eq!(lines[5][1], "armed");
	assert_eq!(lines[6], json!([resumed, false]), "resume");
	assert_eq!(lines[7], json!(["Polestar is not paused.", false]), "resume, not paused");
}

// A window the player turned off stays off through the pause, and the line does not claim it is back.
#[test]
fn a_window_turned_off_stays_off_on_resuming_and_the_line_says_only_that_polestar_resumed() {
	let out = run_ui(
		"",
		r#"
		Polestar.Set("ui.shown", false)
		Polestar.SetPaused(true, "hand")
		Polestar.SetPaused(false, "hand")
		emit({ shown = F:IsShown(), stored = Polestar.Get("ui.shown"), line = lastLine() })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "shown": false, "stored": false, "line": "Polestar resumed." }));
}

// Every other way of asking for the window (a guide picked, a toast's button, the gamepad's focus) sets ui.shown:
// that resumes too, with its line, and the window shows. The load never does, so a /reload stays paused.
#[test]
fn turning_ui_shown_on_while_paused_resumes_and_shows_the_window() {
	let out = run_ui(
		"",
		r#"
		Polestar.SetPaused(true, "hand")
		Polestar.Set("ui.shown", true)
		emit({ mode = Polestar.Paused() or false, shown = F:IsShown(), line = lastLine() })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "mode": false, "shown": true, "line": "Polestar resumed: the guide window is back." }));
}

#[test]
fn a_reload_with_the_pause_saved_and_the_window_on_stays_paused_with_the_window_away() {
	let out = run_ui(
		r#"PolestarCharDB = { schema = 1, pause = { state = "armed", at = 1791000000 } }"#,
		r#"emit({ mode = Polestar.Paused() or false, shown = F:IsShown(), uiShown = Polestar.Get("ui.shown") })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "mode": "armed", "shown": false, "uiShown": true }));
}

// The floating button is a way back: the pause is not one of the window's rules it follows (GF.RulesHide).
#[test]
fn the_floating_button_stays_while_paused() {
	let out = run_ui(
		"",
		r#"
		Polestar.Set("ui.launcher", true)
		local b = PolestarLauncher
		local before = b:IsShown()
		Polestar.SetPaused(true, "hand")
		emit({ before = before, during = b:IsShown(), window = F:IsShown() })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "before": true, "during": true, "window": false }));
}

// `/polestar dungeons` (the journal, Dungeons/Dungeons.lua) is a command of its own: it never touches the pause.
#[test]
fn polestar_dungeons_still_opens_the_journal_and_polestar_pause_toggles_the_pause() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Dungeons/Dungeons.xml", "UI/UI.xml"])],
		script: r#"uistub.install()
			stub.login()
			local opened = 0
			Polestar.Dungeons.Open = function() opened = opened + 1 end
			Polestar.RunCommand("dungeons")
			local journal = { opened = opened, mode = Polestar.Paused() or false }
			Polestar.RunCommand("pause")
			emit({ journal = journal, opened = opened, mode = Polestar.Paused() or false })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, json!({ "journal": { "opened": 1, "mode": false }, "opened": 1, "mode": "armed" }));
}

// The key binding: "Pause the guide" in Polestar's own category of the Key Bindings (and on the gamepad's list),
// Polestar.Bindings.Pause pausing and resuming.
#[test]
fn the_pause_the_guide_key_binding_pauses_and_resumes() {
	let out = run_ui(
		"",
		r#"
		local seen = {}
		Polestar.Bindings.Pause(); seen[#seen + 1] = Polestar.Paused() or false
		Polestar.Bindings.Pause(); seen[#seen + 1] = Polestar.Paused() or false
		local pad = false
		for _, a in ipairs(Polestar.Gamepad.ACTIONS) do
			if a.action == "POLESTAR_PAUSE" then pad = { a.label, a.run } end
		end
		emit({ seen = seen, label = BINDING_NAME_POLESTAR_PAUSE, pad = pad })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "seen": ["armed", false], "label": "Pause the guide", "pad": ["Pause the guide", "Pause"] }));
	let xml = std::fs::read_to_string(addons_dir().join("Polestar/Bindings.xml")).unwrap();
	assert!(is_match(&xml, r#"(?s)<Binding name="POLESTAR_PAUSE" category="Polestar" searchTags="BINDING_TAG_POLESTAR">\s*Polestar\.Bindings\.Pause\(\)\s*</Binding>"#), "{xml}");
}

// Options, Guide, Window: the Pause switch pauses and resumes, and repaints when Polestar resumes by itself (or by
// any other way) while the page is open.
#[test]
fn the_options_pause_switch_pauses_and_repaints_when_polestar_resumes_another_way() {
	let out = run_ui(
		"",
		r#"
		UI.ShowOptions("guide")
		-- The settings window is its own addon, loaded on demand by the first ShowOptions.
		local O = Polestar.UI.Options
		local row = O.Controls("guide", "Window")["Pause"]
		local before = row.checked
		row:Click()
		local clicked = { checked = row.checked, paused = Polestar.Paused() or false }
		Polestar.SetPaused(false, "hand")
		emit({ before = before, clicked = clicked, after = row.checked, paused = Polestar.Paused() or false })"#,
	)
	.remove(0);
	assert_eq!(out, json!({ "before": false, "clicked": { "checked": true, "paused": "armed" }, "after": false, "paused": false }));
}

// ------------------------------------------------------------------------------------------------------------
// The watcher: the way in and out, a wipe, a reload (the QoL harness: instances, the ghost)
// ------------------------------------------------------------------------------------------------------------

fn run_qol(before: &str, saved: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_qol.lua"],
		before: before.into(),
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Core/Pause.lua"])],
		saved: if saved.is_empty() { vec![] } else { vec![("Polestar".into(), saved.into())] },
		login: true,
		script: script.into(),
	})
}

const QOL_PRE: &str = r#"
local q = stub.qol
local function mode() return Polestar.Paused() or false end
local function map() local s = Polestar.CharState().pause; return s and s.map or false end
"#;

#[test]
fn a_wipe_stays_paused_as_a_ghost_outside_and_walking_out_alive_or_a_spirit_healer_resumes() {
	let out = run_qol(
		"",
		"",
		&[
			QOL_PRE,
			r#"
		local seen = {}
		local function note(what) seen[#seen + 1] = { what, mode(), map() } end
		Polestar.SetPaused(true, "hand"); note("armed")
		q.enterInstance(36); note("in")
		q.enterInstance(43); note("another")
		-- A wipe: released, the ghost is outside.
		q.ghost = true
		q.leaveInstance(); note("ghost out")
		stub.fire("PLAYER_ALIVE"); stub.runTimers(); note("released")
		-- Back in, resurrected at the entrance inside; then out alive.
		q.ghost = false
		q.enterInstance(43); note("back in")
		q.leaveInstance(); note("out alive")
		-- Again, and this time the Spirit Healer outside.
		Polestar.SetPaused(true, "hand")
		q.enterInstance(36)
		q.ghost = true
		q.leaveInstance(); note("ghost out")
		q.ghost = false
		stub.fire("PLAYER_UNGHOST"); stub.runTimers(); note("spirit healer")
		emit(seen)"#,
		]
		.concat(),
	)
	.remove(0);
	assert_eq!(
		out,
		json!([
			["armed", "armed", false],
			["in", "inside", 36],
			["another", "inside", 43],
			["ghost out", "inside", 43],
			["released", "inside", 43],
			["back in", "inside", 43],
			["out alive", false, false],
			["ghost out", "inside", 36],
			["spirit healer", false, false],
		])
	);
}

#[test]
fn it_survives_a_reload_inside_and_a_reload_outside_after_leaving_resumes() {
	let saved = r#"PolestarCharDB = { schema = 1, pause = { state = "inside", at = 1791000000, map = 36 } }"#;
	// Kept through the reload, and still watched: walking out alive afterwards ends it.
	let inside = run_qol(r#"stub.qol.instance = { map = 36, kind = "party" }"#, saved, &[QOL_PRE, r#"emit({ mode(), map() }); q.leaveInstance(); emit(mode())"#].concat());
	assert_eq!(inside, vec![json!(["inside", 36]), json!(false)], "a /reload inside stays paused, and leaving alive after it resumes");
	let outside = run_qol(
		"",
		saved,
		&[QOL_PRE, r#"local said = 0; for _, m in ipairs(stub.messages) do if m:find("you are back out of the dungeon", 1, true) then said = said + 1 end end; emit({ mode(), said })"#].concat(),
	);
	assert_eq!(outside, vec![json!([false, 1])], "logged back in outside and alive: resumed, and said");
}

#[test]
fn an_armed_pause_lasts_through_a_reload_and_resumes_once_two_hours_have_passed_with_a_chat_line() {
	let check = |at_offset: i64| {
		let saved = format!("PolestarCharDB = {{ schema = 1, pause = {{ state = \"armed\", at = {} }} }}", 1791000000 - at_offset);
		run_qol(
			"",
			&saved,
			&[QOL_PRE, r#"local said = 0; for _, m in ipairs(stub.messages) do if m:find("Paused for two hours without a dungeon", 1, true) then said = said + 1 end end; emit({ mode(), said })"#]
				.concat(),
		)
		.remove(0)
	};
	assert_eq!(check(60), json!(["armed", 0]), "a minute after arming: still armed");
	assert_eq!(check(7300), json!([false, 1]), "over two hours: resumed, and said");
}

// The expiry comes first: armed long ago with no loading screen since, the next dungeon is not taken for it.
#[test]
fn an_armed_pause_over_two_hours_old_resumes_on_the_way_into_a_dungeon_instead_of_going_inside() {
	let saved = format!("PolestarCharDB = {{ schema = 1, pause = {{ state = \"armed\", at = {} }} }}", 1791000000 - 7300);
	let out = run_qol(
		r#"stub.qol.instance = { map = 36, kind = "party" }"#,
		&saved,
		&[QOL_PRE, r#"local said = 0; for _, m in ipairs(stub.messages) do if m:find("Paused for two hours without a dungeon", 1, true) then said = said + 1 end end; emit({ mode(), said })"#]
			.concat(),
	)
	.remove(0);
	assert_eq!(out, json!([false, 1]));
}

// jump(s): the clock `s` seconds on at once, then the timers due by then. expired(): how many times the two-hour line
// was said.
const TIMER_PRE: &str = r#"
local function jump(s) stub.now = stub.now + s; stub.runTimers() end
local function expired()
	local n = 0
	for _, m in ipairs(stub.messages) do if m:find("Paused for two hours without a dungeon: Polestar resumed.", 1, true) then n = n + 1 end end
	return n
end
"#;

// The two hours are a timer: armed by hand and left on one continent, with no loading screen, it resumes then.
#[test]
fn an_armed_pause_resumes_by_its_timer_two_hours_after_arming_without_a_loading_screen() {
	let out = run_qol(
		"",
		"",
		&[
			QOL_PRE,
			TIMER_PRE,
			r#"
		Polestar.SetPaused(true, "hand")
		jump(7199); emit({ mode(), expired() })
		jump(10); emit({ mode(), expired(), Polestar.CharState().pause == nil })"#,
		]
		.concat(),
	);
	assert_eq!(out, vec![json!(["armed", 0]), json!([false, 1, true])], "still armed before the two hours; resumed by the timer after them, and said");
}

// A timer from an earlier arming does nothing to a later one: resumed and armed again, the pause lasts its own two hours.
#[test]
fn the_timer_of_an_earlier_arming_does_not_end_a_pause_armed_again_later() {
	let out = run_qol(
		"",
		"",
		&[
			QOL_PRE,
			TIMER_PRE,
			r#"
		Polestar.SetPaused(true, "hand")
		jump(1000); Polestar.SetPaused(false, "hand")
		jump(1000); Polestar.SetPaused(true, "hand")
		jump(5300); emit({ mode(), expired() })
		jump(1900); emit({ mode(), expired() })
		jump(2); emit({ mode(), expired() })"#,
		]
		.concat(),
	);
	assert_eq!(out, vec![json!(["armed", 0]), json!(["armed", 0]), json!([false, 1])], "the first timer passes; the second arming ends at its own two hours");
}

// Inside, a pause never expires: the timer from the arming finds it inside and leaves it.
#[test]
fn an_armed_pause_that_went_inside_is_left_inside_when_the_timer_fires() {
	let out = run_qol(
		"",
		"",
		&[
			QOL_PRE,
			TIMER_PRE,
			r#"
		Polestar.SetPaused(true, "hand")
		jump(600); q.enterInstance(36)
		jump(7000); emit({ mode(), map(), expired() })"#,
		]
		.concat(),
	);
	assert_eq!(out, vec![json!(["inside", 36, 0])]);
}

// Loaded armed with an hour left (a /reload or a login), it ends when that hour has passed, not before.
#[test]
fn an_armed_pause_loaded_with_time_left_ends_when_that_time_has_passed() {
	let saved = r#"PolestarCharDB = { schema = 1, pause = { state = "armed", at = 1790996400 } }"#;
	let out = run_qol(
		"",
		saved,
		&[
			QOL_PRE,
			TIMER_PRE,
			r#"
		emit({ mode(), expired() })
		jump(3599); emit({ mode(), expired() })
		jump(3); emit({ mode(), expired() })"#,
		]
		.concat(),
	);
	assert_eq!(out, vec![json!(["armed", 0]), json!(["armed", 0]), json!([false, 1])], "armed an hour before the load: still armed a second short of the two hours, resumed after");
}

// ------------------------------------------------------------------------------------------------------------
// The extras and the nudges
// ------------------------------------------------------------------------------------------------------------

// Quest automation (Core/Automation.lua) as automation.rs drives it: Core alone, the stub world's quest frames.
const AUTO_GUIDE: &str = r#"Polestar.RegisterGuide({
	id = "test/dmauto", pack = "test", title = "Automation", minLevel = 1, maxLevel = 10,
	steps = {
		{ goals = { { t = "accept", quest = 783, title = "A Threat Within" } } },
		{ goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within" },
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup" },
		} },
	},
})
"#;

const AUTO_MAP: &str = r#"w = stub.world; w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); w.moveTo(1429, 48, 42)"#;

const AUTO_CALLS: &str = r#"local c = {}; for i, x in ipairs(w.calls) do c[i] = table.concat({ tostring(x[1]), tostring(x[2]), tostring(x[3]) }, " ") end"#;

// The calls Polestar made at `action` (a quest window), paused or not and "No quest automation while paused" on or not.
fn automation(mode: bool, pause: bool, before: &str, action: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{AUTO_MAP}\n{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			AUTO_GUIDE,
			"stub.login()",
			&format!("if {mode} then Polestar.SetPaused(true, \"hand\") end"),
			&format!("Polestar.Set(\"pause.automation\", {pause})"),
			action,
			AUTO_CALLS,
			"emit(c)",
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn no_quest_automation_while_paused_stops_auto_accept_and_turn_in_only_while_paused_and_only_with_the_setting_on() {
	let accept = |mode: bool, pause: bool| automation(mode, pause, "", "w.questDetail(823, 783); stub.advance(0.25)");
	assert_eq!(accept(false, false), json!(["AcceptQuest 783 nil"]), "the guide's quest is accepted as always");
	assert_eq!(accept(true, false), json!(["AcceptQuest 783 nil"]), "paused alone leaves the automation on");
	assert_eq!(accept(false, true), json!(["AcceptQuest 783 nil"]), "the setting alone does nothing");
	assert_eq!(accept(true, true), json!({}), "paused with the setting: the accept is left to the player");
	let turnin = |mode: bool, pause: bool| automation(mode, pause, "w.onQuest(783, {}); w.choices[783] = 1", "w.questProgress(197, 783)");
	let done = json!(["CompleteQuest 783 nil", "GetQuestReward 783 1"]);
	assert_eq!(turnin(false, false), done, "the guide's turn-in as always");
	assert_eq!(turnin(true, false), done, "paused alone leaves it on");
	assert_eq!(turnin(false, true), done, "the setting alone does nothing");
	assert_eq!(turnin(true, true), json!({}), "paused with the setting: the turn-in is left to the player");
}

// A turn-in the player finishes by hand while paused: "Pick a reward for me" (QoL/Rewards.lua) waits too, with
// "No quest automation while paused" on. On the QoL harness, as qol.rs's reward auto-pick tests.
#[test]
fn no_quest_automation_while_paused_also_holds_back_the_reward_auto_pick() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_qol.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Core/Compat.lua", "Theme/Theme.xml", "QoL/QoL.xml"])],
		login: true,
		script: r#"
		local q = stub.qol
		local function taken()
			local out = {}
			for _, c in ipairs(q.calls) do if c[1] == "GetQuestReward" then out[#out + 1] = c[2] or true end end
			return out
		end
		q.items[11] = { name = "Cloak", price = 120 }
		q.items[12] = { name = "Ring", price = 400 }
		q.choices = { { id = 11 }, { id = 12 } }
		Polestar.Gear = { IsEnabled = function() return false end, IsUpgrade = function() return true, 50 end }
		Polestar.Set("qol.rewardAutoPick", true); stub.runTimers()
		Polestar.SetPaused(true, "hand")
		q.questComplete(); stub.runTimers()
		local paused = #taken()
		Polestar.Set("pause.automation", true)
		q.questComplete(); stub.runTimers()
		local held = #taken()
		Polestar.SetPaused(false, "hand")
		q.questComplete(); stub.runTimers()
		emit({ paused = paused, held = held, taken = taken() })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out, json!({ "paused": 1, "held": 1, "taken": [2, 2] }), "paused alone picks; with the setting it waits; resumed it picks again");
}

const HERE_WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.level = 5
w.zone, w.subzone = "Elwynn Forest", ""
w.moveTo(1429, 47.6, 70.0)
w.onQuest(33, { 8 }, "Wolves Across the Border")
w.onQuest(7, { { required = 10, fulfilled = 8 } }, "Kobold Camp Cleanup")
"#;

const HERE_GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/here", pack = "test", title = "Here", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
		{ title = "Vermin", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
	},
})
"#;

#[test]
fn no_while_here_toast_or_chime_while_paused_the_engine_still_finds_the_line_and_the_map_pins_go_only_with_their_setting() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: HERE_WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/here" }"#.into())],
		script: [
			TEST_PACK,
			TEST_SOURCE,
			HERE_GUIDE,
			r#"Polestar.Set("behavior.whileHereRadius", 60)"#,
			"stub.login()",
			r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#,
			r#"
			local w, E = stub.world, Polestar.Engine
			local function toast()
				local t = PolestarWhileHereToast
				return t and t:IsShown() or false
			end
			local function chimes()
				local n = 0
				for _, s in ipairs(stub.sounds) do if type(s) == "string" and s:find("while%-here%.ogg$") then n = n + 1 end end
				return n
			end
			local function mark()
				local f = Polestar.Pins.GetMinimapFrames("nav.here")[1]
				return f ~= nil and f:IsShown()
			end
			Polestar.SetPaused(true, "hand")
			w.moveTo(1429, 47.6, 37.6); stub.advance(1.1)
			local on = { engine = E.GetWhileHere() ~= nil, toast = toast(), chimes = chimes(), window = PolestarGuideFrame:IsShown(), mark = mark() }
			Polestar.Set("pause.map", true); stub.advance(0.1)
			on.markWithSetting = mark()
			Polestar.SetPaused(false, "hand"); stub.advance(0.1)
			emit({ on = on, window = PolestarGuideFrame:IsShown(), mark = mark() })"#,
		]
		.join("\n"),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["on"]["engine"], true, "the Engine keeps following: the line is there");
	assert_eq!(out["on"]["toast"], false, "no toast");
	assert_eq!(out["on"]["chimes"], 0, "no chime");
	assert_eq!(out["on"]["window"], false, "the window is away");
	assert_eq!(out["on"]["mark"], true, "the map pins stay without the setting");
	assert_eq!(out["on"]["markWithSetting"], false, "with it they go");
	assert_eq!(out["window"], true, "resumed: the window is back");
	assert_eq!(out["mark"], true, "and the pins");
}
