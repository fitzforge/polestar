//! Route independent field work as a complete open trip, with a soft preference for appropriate-level
//! quests. Real Core manifest and synthetic world; no live client, profile, network or input device.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Testvale", c = 0, left = 0, right = 1000, top = 0, bottom = 1000 })
w.addMap(1411, { name = "Elsewhere", c = 1, left = 0, right = 1000, top = 0, bottom = 1000 })
w.moveTo(1429, 50, 50)
w.level = 20
"#;

fn fields(points: &[(i32, i32)], extra: &str) -> String {
	points
		.iter()
		.enumerate()
		.map(|(i, (x, y))| format!("{{ t = \"kill\", target = \"Target {}\", npc = {}, count = 1, map = 1429, x = {x}, y = {y} {extra} }}", i + 1, i + 1))
		.collect::<Vec<_>>()
		.join(",")
}

fn check(goals: &str, setup: &str, next: &str, script: &str) {
	let guide = format!(
		r#"
assert(Polestar.RegisterGuide({{ id = "test/field-route", pack = "test", title = "Route", zone = 1429,
	steps = {{ {{ goals = {{ {goals} }} }}, {{ goals = {{ {next} }} }} }} }}))
stub.login(); stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
local E, w = Polestar.Engine, stub.world
local function flush() stub.advance(0.6) end
E.SetGuide("test/field-route"); flush()
{script}
emit(true)
"#
	);
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\n{setup}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), "PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false, whileHere = false } } }".into())],
		script: [TEST_PACK, &guide].join("\n"),
		..Default::default()
	});
	assert_eq!(out, vec![serde_json::json!(true)]);
}

const END: &str = r#"{ t = "level", level = 60 }"#;

#[test]
fn the_complete_route_can_start_farther_away_without_reordering_rows() {
	check(
		&fields(&[(51, 50), (48, 50), (60, 50)], ""),
		"",
		END,
		r#"
assert(E.GetWaypoint().goalIndex == 2)
assert(E.GetStepView(1).current == 2)
assert(E.GetStepView(1).goals[1].index == 1)
"#,
	);
}

#[test]
fn completing_work_replans_the_remaining_stops() {
	check(
		&fields(&[(49, 50), (60, 50), (61, 50), (45, 50)], ""),
		"",
		END,
		r#"
assert(E.GetWaypoint().goalIndex == 1)
E.ToggleGoal(1, 1); flush(); assert(E.GetWaypoint().goalIndex == 4)
E.ToggleGoal(1, 4); flush(); assert(E.GetWaypoint().goalIndex == 2)
"#,
	);
}

#[test]
fn ordinary_movement_and_combat_hold_the_open_current_stop() {
	check(
		&fields(&[(51, 50), (48, 50), (60, 50)], ""),
		"",
		END,
		r#"
for _, x in ipairs({50.1, 49.9, 51, 50}) do
	w.moveTo(1429, x, 50); flush(); assert(E.GetWaypoint().goalIndex == 2)
end
function UnitAffectingCombat() return true end
w.moveTo(1429, 61, 50); flush(); assert(E.GetWaypoint().goalIndex == 2)
E.ToggleGoal(1, 2); flush(); assert(E.GetWaypoint().goalIndex ~= 2)
"#,
	);
}

#[test]
fn manual_aim_remains_authoritative() {
	check(
		&fields(&[(51, 50), (48, 50), (60, 50)], ""),
		"",
		END,
		r#"
assert(E.AimGoal(1, 1)); flush(); assert(E.GetWaypoint().goalIndex == 1)
"#,
	);
}

#[test]
fn mandatory_waits_and_npc_groups_are_not_crossed() {
	let goals = format!("{}, {{ t = \"wait\", seconds = 60 }}, {}", fields(&[(51, 50)], ""), fields(&[(48, 50), (60, 50)], ""));
	check(&goals, "", END, "assert(E.GetWaypoint().goalIndex == 1); assert(E.GetStepView(1).current == 1)");
	let goals = format!("{{ t = \"talk\", npc = 90, npcName = \"First\", map = 1429, x = 80, y = 50 }}, {}", fields(&[(51, 50), (48, 50), (60, 50)], ""));
	check(&goals, "", END, "assert(E.GetWaypoint().goalIndex == 1); assert(E.GetLiveStep() == 1)");
}

#[test]
fn a_goto_replaced_by_grind_keeps_the_safe_field_goals_eligible() {
	check(
		r#"
{ t = "goto", map = 1429, x = 80, y = 50, text = "Grind area" },
{ t = "level", level = 30, grind = 80, lvl = 45, map = 1429, x = 80, y = 50,
	spots = { { x = 80, y = 50, r = 20, n = 3 } } },
{ t = "kill", target = "Safe objective", npc = 2, count = 1, lvl = 20, map = 1429, x = 51, y = 50 }
"#,
		"",
		END,
		r#"
assert(E.GetWaypoint().goalIndex == 3)
assert(E.GetWaypoint().x == 51)
assert(E.GetStepView(1).current == 3)
"#,
	);
}

#[test]
fn a_known_required_visit_scores_the_end_of_the_route() {
	let goals = format!("{}, {{ t = \"talk\", npc = 90, npcName = \"Exit\", map = 1429, x = 40, y = 50 }}", fields(&[(49, 50), (55, 50)], ""));
	check(&goals, "", END, "assert(E.GetWaypoint().goalIndex == 2); assert(E.GetStepView(1).focus == 1)");
}

#[test]
fn the_finish_hint_uses_the_actual_camp_and_never_crosses_an_internal_wait() {
	let next = r#"{ t = "kill", target = "Next camp", count = 1, npc = 80, map = 1429, x = 10, y = 50,
		spots = { { x = 10, y = 50, r = 0, n = 1 }, { x = 60, y = 50, r = 0, n = 1 } } }"#;
	check(
		&fields(&[(49, 50), (55, 50)], ""),
		"",
		next,
		r#"
E.GetStepView(2); flush()
assert(E.GetStepView(2).goals[1].x == 60); assert(E.GetWaypoint().goalIndex == 1)
"#,
	);
	let goals = format!("{}, {{ t = \"wait\", seconds = 60 }}, {}", fields(&[(49, 50), (55, 50)], ""), fields(&[(60, 50)], ""));
	check(&goals, "", r#"{ t = "talk", npc = 90, npcName = "Exit", map = 1429, x = 40, y = 50 }"#, "assert(E.GetWaypoint().goalIndex == 1)");
}

#[test]
fn safe_camps_win_and_manual_alternative_selection_still_holds() {
	let camp = r#"{ t = "kill", target = "Camps", count = 1, npc = 80, map = 1429, x = 80, y = 50,
		spots = { { x = 49, y = 50, r = 0, n = 1, alt = true, lvl = 20 },
		{ x = 60, y = 50, r = 0, n = 1, lvl = 45 }, { x = 80, y = 50, r = 0, n = 1, lvl = 20 } } }"#;
	check(
		&format!("{camp},{}", fields(&[(52, 50), (40, 50)], ", lvl = 20")),
		"",
		END,
		r#"
assert(E.GetWaypoint().goalIndex == 3); assert(E.GetStepView(1).goals[1].x == 80)
assert(E.CycleSpot(1, 1, 1)); flush()
assert(E.GetWaypoint().goalIndex == 1); assert(E.GetWaypoint().x == 49)
"#,
	);
}

#[test]
fn missing_position_and_other_continents_keep_the_existing_fallback() {
	check(&fields(&[(51, 50), (48, 50), (60, 50)], ""), "w.moveTo(nil)", END, "assert(E.GetWaypoint().goalIndex == 1)");
	let goals = format!("{}, {{ t = \"kill\", target = \"Remote\", npc = 99, count = 1, map = 1411, x = 50, y = 50 }}", fields(&[(51, 50), (48, 50)], ""));
	check(&goals, "", END, "assert(E.GetWaypoint().goalIndex == 1)");
}

/// Counts the plans the Engine asks for from here on.
const COUNT: &str = r#"
local R = Polestar.FieldRoute
local plans, plan = 0, R.Plan
R.Plan = function(...) plans = plans + 1; return plan(...) end
-- One arrival poll (0.5 s) per stretch walked.
local function walk(x, y, toX, toY, polls)
	for i = 1, polls do
		w.moveTo(1429, x + (toX - x) * i / polls, y + (toY - y) * i / polls); stub.advance(0.5)
	end
end
"#;

/// Three goals with camps along a road: the Boars' on it, the others' beside it further on.
fn camps() -> String {
	let goal = |target: &str, npc: i32, y: i32, xs: &[i32]| {
		let spots = xs.iter().map(|x| format!("{{ x = {x}, y = {y}, r = 30, n = 4 }}")).collect::<Vec<_>>().join(", ");
		format!("{{ t = \"kill\", target = \"{target}\", npc = {npc}, count = 8, map = 1429, x = {}, y = {y}, spots = {{ {spots} }} }}", xs[0])
	};
	[goal("Boars", 1, 50, &[30, 40, 50, 60]), goal("Wolves", 2, 56, &[45, 55, 65]), goal("Bears", 3, 44, &[50, 60, 70])].join(",")
}

#[test]
fn a_minute_across_the_current_goals_camps_plans_nothing() {
	// 7 yd a second for a minute, through all four of the Boars' camps: their chosen camp changes three
	// times and the other goals' nearest camps five times, and none of that is a reason to plan.
	for window in ["", "E.GetStepView(1)"] {
		check(
			&camps(),
			"w.moveTo(1429, 20, 50)",
			END,
			&format!(
				r#"{COUNT}
{window}
assert(E.GetWaypoint().goalIndex == 1)
local camps, camp = 0, E.GetWaypoint().x
for i = 1, 120 do
	walk(20 + (i - 1) * 0.35, 50, 20 + i * 0.35, 50, 1)
	local wp = E.GetWaypoint()
	assert(wp.goalIndex == 1)
	if wp.x ~= camp then camps, camp = camps + 1, wp.x end
end
assert(camps == 3, camps)
assert(plans == 0, plans)
"#
			),
		);
	}
}

#[test]
fn walking_to_the_stop_plans_nothing_and_a_detour_plans_once_per_stretch() {
	// From (50,50): north 200 yd then 50 more, east 250 yd. North first is the shorter trip (604 against 620).
	let goals = fields(&[(50, 30), (50, 25), (75, 50)], "");
	check(
		&goals,
		"",
		END,
		&format!(
			r#"{COUNT}
assert(E.GetWaypoint().goalIndex == 1)
walk(50, 50, 50, 32, 52)
assert(plans == 0, plans); assert(E.GetWaypoint().goalIndex == 1)
"#
		),
	);
	check(
		&goals,
		"",
		END,
		&format!(
			r#"{COUNT}
-- East instead, towards the third: 80 yd on, the whole trip from here is not clearly better (535 against
-- 621), so the stop holds; that asks twice, once free and once with the stop held.
walk(50, 50, 57.9, 50, 23)
assert(plans == 0, plans)
walk(57.9, 50, 58.5, 50, 2)
assert(plans == 2, plans); assert(E.GetWaypoint().goalIndex == 1)
-- Another 80 yd: 451 against 665, clearly better, and the arrow follows the player.
walk(58.5, 50, 66, 50, 21)
assert(plans == 2, plans); assert(E.GetWaypoint().goalIndex == 1)
walk(66, 50, 67, 50, 3)
assert(plans == 4, plans); assert(E.GetWaypoint().goalIndex == 3)
-- On the way to the new stop nothing more is asked.
walk(67, 50, 74, 50, 20)
assert(plans == 4, plans); assert(E.GetWaypoint().goalIndex == 3)
"#
		),
	);
}

#[test]
fn a_camp_chosen_for_a_row_from_afar_does_not_bend_the_tour() {
	// The window picks every row's camp where the player stands when the step is first shown: the Stags'
	// camp back at the road's start. By the time the Gate is done the player is in the field, 50 yd from
	// the Stags' other camp, and the tour is planned over that one: the Den 50 yd west first, not the
	// Cave 90 yd east as if the Stags were still 430 yd behind.
	let goals = r#"
{ t = "kill", target = "Gate", npc = 1, count = 1, map = 1429, x = 11, y = 50 },
{ t = "kill", target = "Stags", npc = 2, count = 4, map = 1429, x = 12, y = 56,
	spots = { { x = 12, y = 56, r = 0, n = 2 }, { x = 60, y = 50, r = 0, n = 2 } } },
{ t = "kill", target = "Cave", npc = 3, count = 1, map = 1429, x = 64, y = 50 },
{ t = "kill", target = "Den", npc = 4, count = 1, map = 1429, x = 50, y = 50 }
"#;
	check(
		goals,
		"w.moveTo(1429, 10, 50)",
		END,
		r#"
assert(E.GetWaypoint().goalIndex == 1)
assert(E.GetStepView(1).goals[2].x == 12)
w.moveTo(1429, 55, 50); E.ToggleGoal(1, 1); flush()
assert(E.GetWaypoint().goalIndex == 4, E.GetWaypoint().goalIndex)
E.ToggleGoal(1, 4); flush()
local wp = E.GetWaypoint()
assert(wp.goalIndex == 2 and wp.x == 60, wp.goalIndex .. " at " .. wp.x)
"#,
	);
}

fn leveled_goals() -> String {
	[fields(&[(70, 50)], ", quest = 900001, oi = 1"), fields(&[(51, 50)], ", quest = 900002, oi = 1"), fields(&[(80, 50)], ", quest = 900003, oi = 1")].join(",")
}

const LEVELS: &str = r#"
w.level = 15
for q = 900001, 900003 do w.onQuest(q, { 1 }) end
function C_QuestLog.GetQuestDifficultyLevel(q) return q == 900002 and 20 or 15 end
"#;

#[test]
fn overlevel_quests_are_delayed_without_being_excluded() {
	check(
		&leveled_goals(),
		LEVELS,
		END,
		r#"
assert(E.GetWaypoint().goalIndex == 1); assert(E.GetStepView(1).goals[2].status == "active")
w.progress(900001, 1, 1); flush(); w.progress(900003, 1, 1); flush()
assert(E.GetWaypoint().goalIndex == 2)
"#,
	);
}

#[test]
fn leveling_recalculates_the_soft_penalty_without_reopening_the_guide() {
	check(
		&leveled_goals(),
		LEVELS,
		END,
		r#"
assert(E.GetWaypoint().goalIndex == 1)
w.setLevel(19); flush(); assert(E.GetWaypoint().goalIndex == 2)
"#,
	);
}

#[test]
fn skipped_quests_are_removed_from_the_remaining_route() {
	check(
		&leveled_goals(),
		LEVELS,
		END,
		r#"
E.SkipQuest(900001); flush()
assert(E.GetWaypoint().goalIndex ~= 1); assert(E.GetStepView(1).goals[1].status == "skipped")
assert(E.GetLiveStep() == 1)
"#,
	);
}

#[test]
fn objective_metadata_is_used_when_live_quest_level_is_unknown() {
	let goals = [fields(&[(70, 50)], ", qlvl = 15"), fields(&[(51, 50)], ", qlvl = 20"), fields(&[(80, 50)], ", qlvl = 15")].join(",");
	check(
		&goals,
		"w.level = 15",
		END,
		r#"
assert(E.GetWaypoint().goalIndex == 1)
w.setLevel(19); flush(); assert(E.GetWaypoint().goalIndex == 2)
"#,
	);
}

fn solver(script: &str) {
	check(r#"{ t = "task", text = "Synthetic work" }"#, "", END, script);
}

const LENGTH: &str = r#"
local R = Polestar.FieldRoute
local function distance(a, b) return ((a.x - b.x)^2 + (a.y - b.y)^2)^0.5 end
local function score(points, order, start, finish)
	local yards, delay, previous = 0, 0, start
	for at, i in ipairs(order) do
		yards = yards + distance(previous, points[i]); previous = points[i]
		delay = delay + (points[i].delay or 0) * (#order - at)
	end
	if finish then yards = yards + distance(previous, finish) end
	return yards + delay, yards
end
"#;

#[test]
fn exact_weighted_and_unweighted_routes_match_exhaustive_permutations() {
	solver(&format!(
		r#"{LENGTH}
for n = 1, 8 do
	for _, weighted in ipairs({{false, true}}) do
		for _, fixed in ipairs({{false, 1}}) do
			local points, start, finish = {{}}, {{x = 9, y = -3}}, {{x = 23, y = 15}}
			for i = 1, n do points[i] = {{x = (i * 71) % 101 - 50, y = (i * 43) % 97 - 48, delay = weighted and (i % 3) * 40 or 0}} end
			local order, yards, actual = R.Plan(points, start, finish, fixed or nil)
			local best, path, used = math.huge, {{}}, {{}}
			local function visit(at)
				if at > n then best = math.min(best, (score(points, path, start, finish))); return end
				for i = 1, n do
					if not used[i] and (at ~= 1 or not fixed or i == fixed) then
						path[at], used[i] = i, true; visit(at + 1); used[i] = nil
					end
				end
			end
			visit(1)
			local expected, geometric = score(points, order, start, finish)
			assert(math.abs(actual - best) < 1e-6); assert(math.abs(actual - expected) < 1e-6)
			assert(math.abs(yards - geometric) < 1e-6)
		end
	end
end
"#
	));
}

#[test]
fn larger_routes_keep_every_stop_and_never_worsen_the_weighted_greedy_baseline() {
	solver(&format!(
		r#"{LENGTH}
for _, n in ipairs({{9, 16, 32}}) do
	for _, fixed in ipairs({{false, 3}}) do
		local points, start, finish = {{}}, {{x = 0, y = 0}}, {{x = 100, y = 50}}
		for i = 1, n do points[i] = {{x = (i * 173) % 1001 - 500, y = (i * 419) % 1001 - 500, delay = (i % 4) * 40}} end
		local order, yards, actual = R.Plan(points, start, finish, fixed or nil)
		local greedy, used, previous = {{}}, {{}}, start
		for at = 1, n do
			local pick, best
			for i = 1, n do
				if not used[i] and (at ~= 1 or not fixed or i == fixed) then
					local d = distance(previous, points[i]); if not best or d < best then pick, best = i, d end
				end
			end
			greedy[at], used[pick], previous = pick, true, points[pick]
		end
		assert(actual <= score(points, greedy, start, finish) + 1e-6)
		local expected, geometric = score(points, order, start, finish)
		assert(math.abs(actual - expected) < 1e-6); assert(math.abs(yards - geometric) < 1e-6)
		local seen = {{}}; for _, i in ipairs(order) do assert(not seen[i]); seen[i] = true end
		assert(#order == n); if fixed then assert(order[1] == fixed) end
	end
end
"#
	));
}

#[test]
fn a_plan_leaves_only_its_order_behind() {
	// Planned from the arrival poll: no table per subset or per pair of stops (eight stops made 158 KiB
	// of garbage a plan, 32 made 26), only the orders tried.
	solver(
		r#"
local R = Polestar.FieldRoute
local start, finish = {x = 9, y = -3}, {x = 23, y = 15}
for n, most in pairs({[8] = 1, [32] = 8}) do
	local points = {}
	for i = 1, n do points[i] = {x = (i * 173) % 1001 - 500, y = (i * 419) % 1001 - 500, delay = (i % 3) * 40} end
	R.Plan(points, start, finish); R.Plan(points, start, finish, 3)
	collectgarbage("collect"); collectgarbage("stop")
	local before = collectgarbage("count")
	for _ = 1, 10 do R.Plan(points, start, finish); R.Plan(points, start, finish, 3) end
	local kib = (collectgarbage("count") - before) / 20
	collectgarbage("restart")
	assert(kib < most, n .. " stops: " .. kib .. " KiB a plan")
end
"#,
	);
}

#[test]
fn unsupported_or_invalid_inputs_request_the_existing_selector() {
	solver(
		r#"
local R, start = Polestar.FieldRoute, {x = 0, y = 0}
assert(R.Plan({}, start) == nil)
assert(R.Plan({{x = 0/0, y = 0}}, start) == nil)
assert(R.Plan({{x = 0, y = math.huge}}, start) == nil)
local points = {}; for i = 1, 33 do points[i] = {x = i, y = 0} end
assert(R.Plan(points, start) == nil)
assert(R.Plan({{x = 0, y = 1}}, start, nil, 2) == nil)
"#,
	);
}

#[test]
fn the_difficulty_preference_is_soft_and_equal_routes_stay_deterministic() {
	solver(
		r#"
local R, start = Polestar.FieldRoute, {x = 0, y = 0}
local order = R.Plan({{x = 10, y = 0, delay = 40}, {x = 10000, y = 0}}, start)
assert(order[1] == 1)
local points = {{x = 1, y = 1}, {x = 1, y = 1}, {x = 2, y = 2}, {x = 2, y = 2}}
local a = R.Plan(points, start); local b = R.Plan(points, start)
for i = 1, 4 do assert(a[i] == i); assert(a[i] == b[i]) end
"#,
	);
}
