//! Bounded transport-aware planning for the completed-quest hand-in route.

use super::{codex, run, run_with, ID};
use serde_json::json;

#[path = "handins-travel.rs"]
mod travel;

#[test]
fn a_busy_navigation_budget_yields_and_closing_the_route_cancels_its_work() {
	let out = run(
		"for _,q in ipairs({7101,7103,7104}) do w.onQuest(q,{}) end",
		None,
		r#"
local calls, frames, budgeted = 0, {}, true
Polestar.Nav = { EstimateTravelCooperative = function(from, to, budget)
	calls = calls + 1; budgeted = budgeted and type(budget) == "function"
	frames[GetTime()] = (frames[GetTime()] or 0) + 1
	return nil, 'busy'
end }
local id = H.Start()
local synchronous = calls
settle()
local maximum = 0
for _, count in pairs(frames) do maximum = math.max(maximum, count) end
local before = calls
for i,t in ipairs(E.GetTabs()) do if t.guideId == id then E.CloseTab(i); break end end
settle()
emit({synchronous=synchronous, calls=before, maximum=maximum, budgeted=budgeted, after=calls, ids=ids(Polestar.Guides.Get(id))})
"#,
	);
	assert_eq!(out["synchronous"], 0, "opening the guide must not run expensive travel estimates synchronously");
	assert!(out["calls"].as_u64().unwrap() > 0, "the queued travel refinement was exercised");
	assert_eq!(out["maximum"], 1, "busy means yield rather than retrying or falling back within the same frame");
	assert_eq!(out["budgeted"], true);
	assert_eq!(out["calls"], out["after"], "closing the route cancels pending planning");
	assert_eq!(out["ids"], json!([7101, 7103, 7104]));
}

#[test]
fn navigation_orders_worldwide_stops_by_directed_travel_time_from_the_player() {
	let out = run(
		"for _,q in ipairs({7101,7103,7104}) do w.onQuest(q,{}) end",
		None,
		r#"
local fromPlayer, budgeted = false, true
Polestar.Nav = { EstimateTravelCooperative = function(from, to, budget)
	budgeted = budgeted and type(budget) == "function"
	if not from then fromPlayer = true; return to.map == 9003 and 20 or 200 end
	if from.map == 9003 and to.map == 9001 then return 20 end
	if from.map == 9001 and to.map == 9002 then return 20 end
	return 200
end }
local id = H.Start(); stub.advance(4)
local order = {}
for _,s in ipairs(Polestar.Guides.Get(id).steps) do
	for _,g in ipairs(s.goals) do if g.t == 'turnin' then order[#order+1] = g.quest end end
end
emit({order=order, fromPlayer=fromPlayer, budgeted=budgeted, active=E.GetGuide().id})
"#,
	);
	assert_eq!(out["order"], json!([7103, 7101, 7104]));
	assert_eq!(out["fromPlayer"], true, "nil origin allows the navigation planner to account for the player's current travel abilities");
	assert_eq!(out["budgeted"], true);
	assert_eq!(out["active"], ID);
}

#[test]
fn a_missing_travel_estimate_keeps_the_known_recipient_and_its_waypoint() {
	let out = run(
		"w.onQuest(7101,{}); w.onQuest(7103,{})",
		None,
		r#"
Polestar.Nav = { EstimateTravelCooperative = function(from, to)
	if to.map == 9003 then return nil end
	return 30
end }
local id = H.Start(); stub.advance(4)
local g = Polestar.Guides.Get(id)
local waypoint, warning
for _,s in ipairs(g.steps) do for _,goal in ipairs(s.goals) do
	if goal.quest == 7103 then waypoint, warning = {goal.map,goal.x,goal.y}, s.note end
end end
emit({ids=ids(g), warning=warning or '', waypoint=waypoint})
"#,
	);
	assert_eq!(out["ids"], json!([7101, 7103]));
	assert_eq!(out["waypoint"], json!([9003, 35, 65]));
	assert!(out["warning"].as_str().unwrap().contains("unknown"));
}

#[test]
fn forty_distinct_handins_are_all_covered_without_exceeding_the_per_frame_budget() {
	let mut data = codex();
	data["quests"] = json!({});
	for i in 1..=40 {
		let q = 7200 + i;
		let npc = 5200 + i;
		data["quests"][q.to_string()] = json!({ "id":q, "title":format!("Delivery {i}"), "level":20, "minLevel":1,
			"start":{"npc":[npc],"object":[],"item":[]}, "end":{"npc":[npc],"object":[]}, "objectives":[],
			"pre":[],"preAny":[],"zone":9001,"rewards":[],"choices":[] });
		data["npcs"][npc.to_string()] = json!({"id":npc,"name":format!("Recipient {i}"),"faction":"A","roles":[],
			"spawns":[{"map":9001,"x":10+i*2,"y":50,"f":"e"}]});
	}
	let out = run_with(
		&data,
		"for q=7201,7240 do w.onQuest(q,{}) end",
		None,
		r#"
local calls, frames, budgeted = 0, {}, true
Polestar.Nav = { EstimateTravelCooperative = function(from, to, budget)
	calls = calls + 1; frames[GetTime()] = (frames[GetTime()] or 0) + 1
	budgeted = budgeted and type(budget) == "function"
	return 30 + math.abs((from and from.x or 50) - to.x)
end }
local id = H.Start(); stub.advance(26)
local maximum = 0
for _,n in pairs(frames) do maximum = math.max(maximum,n) end
local g = Polestar.Guides.Get(id)
emit({quests=ids(g), maximum=maximum, calls=calls, budgeted=budgeted, finished=g.steps[1].note == nil})
"#,
	);
	assert_eq!(out["quests"], json!((7201..=7240).collect::<Vec<_>>()));
	assert!(out["maximum"].as_u64().unwrap() <= 4, "navigation work must yield between bounded batches");
	assert!((40..=160).contains(&out["calls"].as_u64().unwrap()));
	assert_eq!(out["budgeted"], true);
	assert_eq!(out["finished"], true, "the entire route refinement completes before its deadline");
}

#[test]
fn a_navigation_timeout_keeps_unestimated_handins_and_explains_the_incomplete_estimates() {
	let out = run(
		"w.onQuest(7101,{}); w.onQuest(7103,{})",
		None,
		r#"
local calls = 0
Polestar.Nav = { EstimateTravelCooperative = function() calls = calls + 1; return nil, 'busy' end }
local id = H.Start(); stub.advance(31)
local g, ended = Polestar.Guides.Get(id), calls
stub.advance(3)
emit({quests=ids(g), explanation=notes(g) .. ' ' .. (g.steps[1].note or ''), ended=ended, after=calls})
"#,
	);
	assert_eq!(out["quests"], json!([7101, 7103]), "a budget timeout is not evidence that any recipient is unreachable");
	assert!(out["explanation"].as_str().unwrap().to_lowercase().contains("estimat"), "the route explains that its estimates are incomplete");
	assert_eq!(out["ended"], out["after"], "the expired planning job stops making requests");
}

#[test]
fn a_partial_pass_uses_completed_travel_estimates_to_improve_the_final_order() {
	let out = run(
		"for _,q in ipairs({7101,7103,7104}) do w.onQuest(q,{}) end",
		None,
		r#"
local calls = 0
Polestar.Nav = { EstimateTravelCooperative = function(from, to)
	calls = calls + 1
	if not from then return to.map == 9003 and 1 or 99999 end
	return nil, 'busy'
end }
local id = H.Start(); stub.advance(31)
local g, order, ended = Polestar.Guides.Get(id), {}, calls
for _,s in ipairs(g.steps) do for _,goal in ipairs(s.goals) do
	if goal.t == 'turnin' then order[#order+1] = goal.quest end
end end
stub.advance(2)
emit({order=order, quests=ids(g), note=g.steps[1].note or '', ended=ended, after=calls})
"#,
	);
	assert_eq!(out["order"][0], 7103, "the cheap first trip discovered before timeout must still improve the route");
	assert_eq!(out["quests"], json!([7101, 7103, 7104]));
	assert!(out["note"].as_str().unwrap().contains("incomplete"));
	assert_eq!(out["ended"], out["after"]);
}

// Each budget check consumes five synthetic milliseconds, making the real planner suspend.
// Observe pause calls at its explicit cooperation boundary; the algorithm and publishing stay real.
const COOPERATIVE_NAV: &str = r#"
local estimates, pauses, pauseFrames, clock = 0, 0, {}, 0
debugprofilestop = function() clock = clock + 5; return clock end
Polestar.Nav = { EstimateTravelCooperative = function(from, to)
	estimates = estimates + 1
	if not from then return to.map == 9003 and 20 or 200 end
	if from.map == 9003 and to.map == 9001 then return 20 end
	if from.map == 9001 and to.map == 9002 then return 20 end
	return 200
end }
local plan = Polestar.Dungeons.PlanStops
Polestar.Dungeons.PlanStops = function(stops, from, finish, travel, opts)
	if not (opts and opts.pause) then return plan(stops, from, finish, travel, opts) end
	local wrapped, pause = {}, opts.pause
	for k,v in pairs(opts) do wrapped[k] = v end
	wrapped.pause = function()
		pauses = pauses + 1
		pauseFrames[GetTime()] = true
		pause()
	end
	return plan(stops, from, finish, travel, wrapped)
end
local id = H.Start()
for _=1,400 do if estimates >= 9 then break end; stub.advance(0.05) end
assert(estimates == 9, 'all three-stop travel estimates must be collected before testing optimizer work')
stub.advance(0.05)
"#;

#[test]
fn cooperative_optimization_resumes_across_frames_to_the_correct_directed_route() {
	let script = format!(
		"{COOPERATIVE_NAV}\n{}",
		r#"
local suspended = Polestar.Guides.Get(id).steps[1].note ~= nil
local started = pauses
stub.advance(10)
local g, order, frames = Polestar.Guides.Get(id), {}, 0
for _,s in ipairs(g.steps) do for _,goal in ipairs(s.goals) do if goal.t == 'turnin' then order[#order+1] = goal.quest end end end
for _ in pairs(pauseFrames) do frames = frames + 1 end
emit({suspended=suspended, started=started, frames=frames, order=order, finished=g.steps[1].note == nil})
"#
	);
	let out = run("for _,q in ipairs({7101,7103,7104}) do w.onQuest(q,{}) end", None, &script);
	assert!(out["started"].as_u64().unwrap() > 0, "the actual optimizer, not only estimate collection, started");
	assert_eq!(out["suspended"], true, "one over-budget frame cannot run the entire optimization");
	assert!(out["frames"].as_u64().unwrap() > 1, "the optimizer resumes on later frames");
	assert_eq!(out["order"], json!([7103, 7101, 7104]), "yielding preserves the optimal directed route");
	assert_eq!(out["finished"], true);
}

#[test]
fn closing_the_guide_cancels_an_optimizer_already_suspended_between_frames() {
	let script = format!(
		"{COOPERATIVE_NAV}\n{}",
		r#"
local before, registered = pauses, Polestar.Guides.Get(id)
E.CloseTab(1)
stub.advance(10)
emit({before=before, after=pauses, tabs=tabIds(), republished=Polestar.Guides.Get(id) ~= registered})
"#
	);
	let out = run("for _,q in ipairs({7101,7103,7104}) do w.onQuest(q,{}) end", None, &script);
	assert!(out["before"].as_u64().unwrap() > 0, "cancellation occurs after optimization has actually started");
	assert_eq!(out["after"], out["before"], "the cancelled coroutine performs no further optimization work");
	assert_eq!(out["tabs"], json!({}));
	assert_eq!(out["republished"], false);
}

#[test]
fn a_ready_set_change_that_reverts_before_debounce_still_restarts_cancelled_planning() {
	let out = run(
		"w.onQuest(7101,{})",
		None,
		r#"
local calls, busy = 0, true
Polestar.Nav = { EstimateTravelCooperative = function()
	calls = calls + 1
	if busy then return nil, 'busy' end
	return 30
end }
local id = H.Start(); stub.advance(0.1)
w.onQuest(7103,{}); stub.fire('QUEST_LOG_UPDATE'); stub.advance(0.05)
local cancelled = calls
w.abandon(7103)
busy = false
stub.advance(2)
local g = Polestar.Guides.Get(id)
emit({cancelled=cancelled, calls=calls, quests=ids(g), finished=g.steps[1].note == nil})
"#,
	);
	assert!(out["cancelled"].as_u64().unwrap() > 0, "the original planner was running before the temporary quest change");
	assert!(out["calls"].as_u64().unwrap() > out["cancelled"].as_u64().unwrap(), "the cancelled job must restart even though the final ready set matches its old signature");
	assert_eq!(out["quests"], json!([7101]));
	assert_eq!(out["finished"], true);
}
