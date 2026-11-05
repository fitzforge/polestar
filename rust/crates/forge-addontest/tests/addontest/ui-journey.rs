//! The journey panel (addon/Polestar/UI/JourneyPanel.lua) in the guide window, against the real Core + Theme + UI
//! manifests, the fake Engine of tests/lua/stub_ui.lua and a fake route: Nav.GetRoute, Nav.travel (Active,
//! Progress), Nav.prompts (the skip menu) and ns.Transit (departures). Ids in test names are the rows of
//! docs/NAV_QA.md.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, is_match, text, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const FILES: [&str; 3] = ["Core/Core.xml", "Theme/Theme.xml", "UI/UI.xml"];

// SPF's own example: 36:48 and 8.0k yd over a walk to the Great Lift, the lift, and the walk to Silithus.
const ROUTE: &str = r#"
local Nav = Polestar.Nav
Polestar.RegisterDefaults("nav", { distanceUnit = "yards", journeySteps = true, journeyOpen = true })
R = { ci = 1, ps = 670, py = 3000, timed = false, wait = 15, ride = 10, active = true }
R.legs = {
	{ kind = "walk", step = "lift", label = "Walk to The Great Lift, Top", seconds = 670, yards = 3000, to = { name = "The Great Lift, Top" } },
	{ kind = "lift", lift = 7, side = "top", label = "Ride the elevator down", seconds = 25, yards = 60, to = { name = "The Great Lift, Bottom" } },
	{ kind = "walk", label = "Walk to Silithus", seconds = 1513, yards = 4940, to = { name = "Silithus", map = 1451 } },
}
Nav.travel = {
	Active = function() return R.active and R.legs ~= nil and #R.legs > 1 end,
	Progress = function() return R.ps, R.py end,
}
function Nav.GetRoute() return R.legs, R.legs and R.ci end
MENU = 0
Nav.prompts = { MenuItems = function() return { { text = "Mark this leg done" } } end, OpenMenu = function() MENU = MENU + 1 end }
Polestar.Transit = {
	Now = function() return 1000 + GetTime() end,
	NextDeparture = function(kind, id, at, side) DEP = { kind, id, side }; return R.wait, R.ride, R.timed end,
}
uistub.target = { label = "Silithus" }
JP = Polestar.UI.JourneyPanel
GF = Polestar.UI.GuideFrame
LAYOUTS = 0
local layout = GF.Layout
GF.Layout = function(...) LAYOUTS = LAYOUTS + 1; return layout(...) end
function shot()
	local rows = {}
	for i, r in ipairs(JP.rows) do
		if r:IsShown() then
			rows[#rows + 1] = { num = r.Num:GetText(), text = r.Text:GetText(), time = r.Time:GetText(), bar = r.Bar:IsShown(),
				sub = r.Sub:IsShown() and r.Sub:GetText() or false, icon = r.Icon:GetTexture(), h = r:GetHeight() }
		end
	end
	local f = JP.frame
	return { has = f.psHas or false, shown = f:IsShown(), time = JP.head.Time:GetText(),
		dist = JP.head.Dist:IsShown() and JP.head.Dist:GetText() or false, dest = JP.dest:GetText(), rows = rows,
		more = JP.more:IsShown() and JP.more:GetText() or false, list = f.List:IsShown(), height = f:GetHeight() }
end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &FILES)],
		script: ["uistub.install()", "stub.login()", ROUTE, "uistub.setGuide(uistub.elwynn, 3)", r#"Polestar.Fire("ROUTE_CHANGED", R.legs)"#, script].join("\n"),
		..Default::default()
	})
}

fn rows(s: &Value) -> &Vec<Value> {
	s["rows"].as_array().unwrap()
}

/// Each row's values of `keys`, as an array per row.
fn pick(s: &Value, keys: &[&str]) -> Value {
	Value::Array(rows(s).iter().map(|r| Value::Array(keys.iter().map(|k| r[*k].clone()).collect())).collect())
}

/// Each row's value of `key`.
fn col(s: &Value, key: &str) -> Value {
	Value::Array(rows(s).iter().map(|r| r[key].clone()).collect())
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap()
}

#[test]
fn header_destination_and_numbered_steps_36_48_8_0k_yd_the_lift_with_its_departure_the_current_step_in_the_accent() {
	let out = run("emit(shot())");
	let s = &out[0];
	assert_eq!(s["has"], true);
	assert_eq!(s["shown"], true);
	assert_eq!(s["time"], "36:48");
	assert_eq!(s["dist"], "8.0k yd");
	assert!(is_match(text(&s["dest"]), r"^To \|c[0-9a-f]{8}Silithus\|r$"));
	assert_eq!(pick(s, &["num", "text", "time"]), json!([["1", "Walk to The Great Lift, Top", "11:10"], ["2", "Ride the elevator down", "0:25"], ["3", "Walk to Silithus", "25:13"],]));
	assert_eq!(col(s, "bar"), json!([true, false, false]));
	assert_eq!(s["rows"][1]["sub"], "average wait 0:15 \u{b7} ride 0:10");
	assert_eq!(s["rows"][0]["sub"], false);
	assert!(is_match(text(&s["rows"][0]["icon"]), r"icon-lift$"));
	assert!(is_match(text(&s["rows"][2]["icon"]), r"icon-goto$"));
	assert!(num(&s["rows"][1]["h"]) > num(&s["rows"][0]["h"]), "the departure line has its own room");
}

#[test]
fn times_read_0_15_11_10_1_02_03_nothing_unreadable_reaches_the_screen() {
	let out = run(r#"emit({ JP.FormatTime(15), JP.FormatTime(670), JP.FormatTime(3723), JP.FormatTime(0), JP.FormatTime(0.2),
		JP.FormatTime(0/0), JP.FormatTime(math.huge), JP.FormatTime(-4), JP.FormatTime(nil) })"#);
	assert_eq!(out[0], json!(["0:15", "11:10", "1:02:03", "0:00", "0:01", "0:00", "0:00", "0:00", "0:00"]));
}

#[test]
fn t_16_distances_follow_nav_distanceunit_8_0k_yd_or_7_3_km_in_metres() {
	let out = run(r#"Polestar.Set("nav.distanceUnit", "metres"); emit(shot())"#);
	assert_eq!(out[0]["dist"], "7.3 km");
}

#[test]
fn countdown_the_current_step_and_the_total_tick_down_once_a_second_from_travel_progress() {
	let out = run(r#"
		R.ps = 669; stub.advance(1); emit(shot())
		R.ps = 600; stub.advance(1); emit(shot())"#);
	let (a, b) = (&out[0], &out[1]);
	assert_eq!(a["rows"][0]["time"], "11:09");
	assert_eq!(a["time"], "36:47");
	assert_eq!(b["rows"][0]["time"], "10:00");
	assert_eq!(b["time"], "35:38");
}

#[test]
fn countdown_without_travel_progress_the_planned_time_less_the_time_since_the_step_began() {
	let out = run(r#"Polestar.Nav.travel.Progress = nil; R.legs = { R.legs[1], R.legs[2], R.legs[3] }; Polestar.Fire("ROUTE_CHANGED", R.legs); stub.advance(3); emit(shot())"#);
	assert_eq!(out[0]["rows"][0]["time"], "11:07");
}

#[test]
fn the_current_step_advances_the_finished_step_drops_off_numbers_keep_their_place_in_the_route() {
	let out = run(r#"R.ci = 2; R.ps = 25; Polestar.Fire("ROUTE_ADVANCED", R.legs, 2); emit(shot())"#);
	let s = &out[0];
	assert_eq!(pick(s, &["num", "text", "bar"]), json!([["2", "Ride the elevator down", true], ["3", "Walk to Silithus", false]]));
	assert_eq!(s["time"], "25:38");
}

#[test]
fn t_5_hidden_with_no_route_a_lone_walk_the_setting_off_or_compact_mode_back_when_the_route_returns() {
	let out = run(r#"
		R.legs = { R.legs[3] }; R.ci = 1; Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		R.legs = nil; Polestar.Fire("ROUTE_CHANGED", nil); emit(shot())
		R.legs = { { kind = "walk", label = "a", seconds = 5 }, { kind = "walk", label = "b", seconds = 5 } }; Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		Polestar.Set("nav.journeySteps", false); emit(shot())
		Polestar.Set("nav.journeySteps", true); Polestar.Set("ui.compact", true); emit(shot())
		Polestar.Set("ui.compact", false); emit(shot())"#);
	let got: Vec<Value> = out.iter().map(|s| json!([s["has"], s["shown"]])).collect();
	assert_eq!(json!(got), json!([[false, false], [false, false], [true, true], [false, false], [true, false], [true, true]]));
}

#[test]
fn collapses_with_a_click_on_the_header_the_totals_stay_the_steps_go() {
	let out = run(r#"
		emit(shot()); JP.head:Click(); emit(shot()); JP.head:Click(); emit(shot())"#);
	let (open, shut, again) = (&out[0], &out[1], &out[2]);
	assert_eq!(open["list"], true);
	assert_eq!(shut["list"], false);
	assert_eq!(shut["time"], "36:48");
	assert_eq!(shut["height"], 30);
	assert_eq!(again["list"], true);
	assert_eq!(again["height"], open["height"]);
}

#[test]
fn clicking_the_current_step_opens_the_skip_menu_a_later_step_does_not() {
	let out = run("JP.rows[2]:Click(); JP.rows[1]:Click(); emit(MENU)");
	assert_eq!(out[0], 1);
}

#[test]
fn more_than_eight_steps_eight_rows_and_a_count_of_the_rest() {
	let out = run(r#"
		local legs = {}
		for i = 1, 11 do legs[i] = { kind = "walk", label = "Step " .. i, seconds = 10, yards = 10 } end
		R.legs = legs; R.ps = 10; R.py = 10; Polestar.Fire("ROUTE_CHANGED", legs); emit(shot())"#);
	let s = &out[0];
	assert_eq!(rows(s).len(), 8);
	assert_eq!(s["more"], "3 more steps");
	assert_eq!(s["time"], "1:50");
}

#[test]
fn k1_c9_a_step_without_a_caption_reads_its_kind_and_place_never_unknown() {
	let out = run(r#"
		R.legs = {
			{ kind = "walk", seconds = 10, to = {} },
			{ kind = "tram", seconds = 60, transport = { id = 3 }, to = { map = 1451 } },
			{ kind = "fly", seconds = 90, to = { name = "Ironforge" } },
		}
		Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())"#);
	let s = &out[0];
	let texts: Vec<&Value> = rows(s).iter().map(|r| &r["text"]).collect();
	for t in &texts {
		assert!(truthy(t) && !text(t).trim().is_empty());
		assert!(!is_match(text(t), r"(?i)unknown"));
	}
	assert_eq!(*texts[0], "Walk to the next stop");
	assert_eq!(*texts[2], "Fly to Ironforge");
	assert_eq!(s["rows"][2]["sub"], false, "a flight leaves at once: no wait");
}

#[test]
fn k3_a_lift_gives_its_average_wait_until_timed_then_leaves_in_walks_gates_and_bridges_carry_no_wait() {
	let out = run(r#"
		R.legs[1].step = "gate"; R.legs[3].step = "bridge"; Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		R.timed = true; Polestar.Fire("NAV_TRANSIT"); emit(shot())"#);
	let (about, timed) = (&out[0], &out[1]);
	assert_eq!(about["rows"][1]["sub"], "average wait 0:15 \u{b7} ride 0:10");
	assert_eq!(timed["rows"][1]["sub"], "leaves in 0:15 \u{b7} ride 0:10");
	assert_eq!(about["rows"][0]["sub"], false);
	assert_eq!(about["rows"][2]["sub"], false);
	assert!(is_match(text(&about["rows"][0]["icon"]), r"icon-gate$"));
	assert!(is_match(text(&about["rows"][2]["icon"]), r"icon-bridge$"));
}

#[test]
fn k3_the_lift_is_asked_for_the_side_the_route_boards_at_and_at_the_time_the_route_gets_there() {
	let out = run("emit({ DEP[1], DEP[2], DEP[3] })");
	assert_eq!(out[0], json!(["lift", 7, "top"]));
}

#[test]
fn k2_and_1_9_0_shaking_ten_position_updates_along_a_leg_change_only_the_times_never_the_rows_or_the_layout() {
	let out = run(r#"
		local first = shot(); LAYOUTS = 0
		for i = 1, 10 do R.ps = 670 - i * 7; R.py = 3000 - i * 30; stub.advance(1) end
		emit(first); emit(shot()); emit(LAYOUTS)"#);
	let (before, after, layouts) = (&out[0], &out[1], &out[2]);
	assert_eq!(*layouts, 0);
	assert_eq!(pick(after, &["num", "text", "h", "sub"]), pick(before, &["num", "text", "h", "sub"]));
	assert_eq!(after["rows"][0]["time"], "10:00");
}

#[test]
fn t_1_k7_zero_yard_zero_second_and_nan_legs_keep_every_time_and_distance_finite() {
	let out = run(r#"
		R.legs = {
			{ kind = "walk", label = "a", seconds = 0/0, yards = 0 },
			{ kind = "walk", label = "b", seconds = 0, yards = 0/0 },
			{ kind = "walk", label = "c", seconds = math.huge, yards = -5 },
		}
		R.ps, R.py = 0/0, 0/0
		Polestar.Fire("ROUTE_CHANGED", R.legs); stub.advance(1); emit(shot())"#);
	let s = &out[0];
	assert_eq!(s["time"], "0:00");
	assert_eq!(s["dist"], false);
	for r in rows(s) {
		assert_eq!(r["time"], "0:00");
	}
}

#[test]
fn the_countdown_stops_while_the_guide_window_is_hidden_and_resumes_with_it() {
	let out = run(r#"
		PolestarGuideFrame:Hide(); stub.advance(2); emit(JP.Ticking())
		PolestarGuideFrame:Show(); stub.advance(1); emit(JP.Ticking())"#);
	assert_eq!(out[0], false);
	assert_eq!(out[1], true);
}

#[test]
fn t_6_the_panel_makes_no_protected_calls_no_secure_templates_supertrack_or_gamepad_focus() {
	let src = std::fs::read_to_string(addons_dir().join("Polestar").join("UI").join("JourneyPanel.lua")).unwrap();
	assert!(!is_match(&src, r"Secure|C_SuperTrack|Gamepad|SetBinding|InCombatLockdown"));
}

#[test]
fn review_p2_4_the_current_flight_counts_down_and_the_header_with_it_even_when_travel_progress_gives_the_planned_time() {
	let out = run(r#"
		R.legs = { { kind = "fly", label = "Fly to Ironforge", seconds = 300, yards = 2000, to = { name = "Ironforge" } },
			{ kind = "walk", label = "Walk to the bank", seconds = 100, yards = 300 } }
		R.ci = 1; R.ps, R.py = 300, 2000 -- a Progress that never moves for non-walk legs
		Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		stub.advance(5); emit(shot())
		PolestarGuideFrame:Hide(); stub.advance(10); PolestarGuideFrame:Show(); stub.advance(0.05); emit(shot())"#);
	let (a, b, c) = (&out[0], &out[1], &out[2]);
	assert_eq!(a["rows"][0]["time"], "5:00");
	assert_eq!(a["time"], "6:40");
	assert_eq!(b["rows"][0]["time"], "4:55");
	assert_eq!(b["time"], "6:35");
	assert_eq!(c["rows"][0]["time"], "4:45", "the countdown keeps running while the window is closed");
}

#[test]
fn review_p3_11_no_empty_second_line_when_the_departure_is_unknown() {
	let out = run(r#"R.wait = nil; Polestar.Fire("NAV_TRANSIT"); emit(shot())"#);
	let s = &out[0];
	assert_eq!(s["rows"][1]["sub"], false);
	assert_eq!(s["rows"][1]["h"], s["rows"][0]["h"]);
	assert_eq!(s["rows"][1]["time"], "0:25", "the planned time stands in");
}

#[test]
fn review_p3_11_at_the_dock_a_boat_leaving_within_the_boarding_window_shows_its_own_wait_not_a_full_loop() {
	let out = run(r#"
		R.legs = { { kind = "boat", transport = { id = 4 }, side = "a", label = "Boat to Auberdine", seconds = 180, yards = 1500,
				from = { c = 0, wx = 100, wy = 200 }, to = { name = "Auberdine" } },
			{ kind = "walk", label = "Walk to the inn", seconds = 60, yards = 200 } }
		R.ci = 1; R.timed = true; R.wait = 600; R.ride = 120
		Polestar.Transit.NextArrival = function() return 0, 8, true end
		local here = { 0, 110, 205 }
		Polestar.Compat.GetPlayerWorldPosition = function() return here[1], here[2], here[3] end
		Polestar.Fire("ROUTE_CHANGED", R.legs); emit(shot())
		here = { 0, 400, 205 }; Polestar.Fire("NAV_TRANSIT"); emit(shot())"#);
	let (docked, away) = (&out[0], &out[1]);
	assert_eq!(docked["rows"][0]["sub"], "leaves in 0:08 \u{b7} ride 2:00");
	assert_eq!(docked["rows"][0]["time"], "2:08");
	assert_eq!(away["rows"][0]["sub"], "leaves in 10:00 \u{b7} ride 2:00");
}

#[test]
fn a_walk_that_enters_a_hostile_town_says_so_under_its_step_hostile_town_southshore() {
	let out = run(r#"
		-- Travel.HubText's wording (the panel asks Nav.travel for it).
		Polestar.Nav.travel.HubText = function(leg)
			local names = {}
			for _, h in ipairs(leg.hubs or {}) do names[#names + 1] = h.name end
			return #names > 0 and ("Hostile town: " .. table.concat(names, ", ")) or nil
		end
		R.legs[3].hubs = { { id = 12, name = "Southshore" } }
		R.legs[1].hubs = { { id = 13, name = "Tarren Mill" }, { id = 14, name = "Hammerfall" } }
		Polestar.Fire("ROUTE_CHANGED", R.legs)
		emit(shot())"#);
	let s = &out[0];
	assert_eq!(s["rows"][2]["sub"], "Hostile town: Southshore");
	assert_eq!(s["rows"][0]["sub"], "Hostile town: Tarren Mill, Hammerfall");
	assert_eq!(s["rows"][1]["sub"], "average wait 0:15 \u{b7} ride 0:10", "a ride keeps its departure line");
	assert!(num(&s["rows"][2]["h"]) > 24.0, "the warning has its own line");
}
