//! Delivery readiness and unchanged-log event handling for the live hand-in route.

use super::{codex, run, run_with};
use serde_json::json;

#[test]
fn the_recent_turnin_hold_excludes_only_the_stale_quest_and_expires_at_ten_seconds() {
	let out = run(
		"w.repeatable[7110]=true; w.onQuest(7110,{}); w.onQuest(7101,{})",
		None,
		r#"
local id = assert(H.Start()); settle()
w.turnIn(7110)
local turnedAt = GetTime()
w.onQuest(7110,{}) -- The client's old ready entry lags QUEST_TURNED_IN.
local immediate = H.Ready()
settle()
local route = ids(Polestar.Guides.Get(id))
stub.now = turnedAt + 9.999
local held = H.Ready()
stub.now = turnedAt + 10
local expired = H.Ready()
stub.fire('QUEST_LOG_UPDATE'); settle()
emit({immediate=immediate, route=route, held=held, expired=expired, refreshed=ids(Polestar.Guides.Get(id))})
"#,
	);
	for stage in ["immediate", "route", "held"] {
		assert_eq!(out[stage], json!([7101]), "{stage}: the turn-in hold applies to that quest alone");
	}
	for stage in ["expired", "refreshed"] {
		assert_eq!(out[stage], json!([7101, 7110]), "{stage}: an unconfirmed stale entry must not be hidden indefinitely");
	}
}

#[test]
fn a_repeatable_reaccepted_inside_the_hold_is_a_new_unfinished_then_ready_attempt() {
	for accept in ["w.accept(7110,{1})", "w.onQuest(7110,{1}); stub.fire('QUEST_ACCEPTED',1,7110); stub.fire('QUEST_LOG_UPDATE')"] {
		let script = format!(
			r#"
local id = assert(H.Start()); settle()
w.turnIn(7110)
local turnedAt = GetTime()
w.onQuest(7110,{{}}) -- Keep the stale entry until the next accept arrives.
stub.advance(2)
local held = H.Ready()
{accept}
local unfinished = H.Ready()
w.progress(7110,1,1)
local ready, acceptedAfter = H.Ready(), GetTime() - turnedAt
settle()
local route, actionable = ids(Polestar.Guides.Get(id)), E.WantsQuest('turnin',7110)
w.turnIn(7110)
w.onQuest(7110,{{}})
local nextHold = H.Ready()
emit({{held=held, unfinished=unfinished, ready=ready, acceptedAfter=acceptedAfter,
	route=route, actionable=actionable, nextHold=nextHold, tabs=#E.GetTabs()}})
"#
		);
		let out = run("w.repeatable[7110]=true; w.onQuest(7110,{})", None, &script);
		assert_eq!(out["held"], json!({}));
		assert_eq!(out["unfinished"], json!({}), "a new attempt still needs its own objectives");
		assert!(out["acceptedAfter"].as_f64().is_some_and(|seconds| (0.0..10.0).contains(&seconds)));
		assert_eq!(out["ready"], json!([7110]), "{accept}: reaccept clears the previous attempt's hold immediately");
		assert_eq!(out["route"], json!([7110]));
		assert_eq!(out["actionable"], true);
		assert_eq!(out["nextHold"], json!({}), "the new attempt's turn-in starts its own hold");
		assert_eq!(out["tabs"], 1, "the same live hand-in tab is reused");
	}
}

#[test]
fn codex_live_and_era_recipient_frames_build_valid_goals_at_the_same_world_point() {
	for frame in ["e", "l"] {
		let mut data = codex();
		data["npcs"]["5001"]["spawns"] = json!([{ "map":9001, "x":52, "y":50, "f":frame, "z":12 }]);
		// Distinct bounds expose an accidental change from live to Era coordinates.
		data["frames"]["9001"] = json!({ "c":0, "left":2000, "right":-2000, "top":2000, "bottom":-2000 });
		let out = run_with(
			&data,
			"w.onQuest(7101,{})",
			None,
			r#"
local id = assert(H.Start()); settle()
local raw = Polestar.Codex.Npc(5001).spawns[1]
local at = Polestar.RoutePlan.Ender(7101)
local goal = Polestar.Guides.Get(id).steps[1].goals[1]
local C = Polestar.Compat
emit({rawFrame=raw.f, enderFrame=at.f or false, goalFrame=goal.f or false,
	place={goal.map,goal.x,goal.y,goal.z}, currentLog=goal.currentLog,
	rawWorld={C.MapToWorld(raw.map,raw.x,raw.y,raw.f)}, goalWorld={C.MapToWorld(goal.map,goal.x,goal.y,goal.f)}})
"#,
		);
		assert_eq!(out["rawFrame"], frame);
		let goal_frame = if frame == "e" { json!("e") } else { json!(false) };
		assert_eq!(out["enderFrame"], goal_frame);
		assert_eq!(out["goalFrame"], goal_frame);
		assert_eq!(out["place"], json!([9001, 52, 50, 12]));
		assert_eq!(out["currentLog"], true);
		assert_eq!(out["rawWorld"].as_array().unwrap().len(), 3);
		assert_eq!(out["rawWorld"], out["goalWorld"], "{frame}: normalizing the frame must preserve the recipient's location");
	}
}

#[test]
fn dungeon_recipients_keep_the_entrance_and_inside_note_through_travel_refinement() {
	let mut data = codex();
	data["npcs"]["5001"]["instance"] = json!("test-dungeon");
	data["npcs"]["5001"]["spawns"] = json!([]);
	let out = run_with(
		&data,
		"w.onQuest(7101,{})",
		None,
		r#"
Polestar.Dungeons.Get = function(key)
	if key == 'test-dungeon' then
		return {name='Synthetic Dungeon',entrance={map=9001,x=40,y=60,f='e'}}
	end
end
Polestar.Nav = {EstimateTravelCooperative=function() return nil,'unknown' end}
local id = assert(H.Start())
local initial = Polestar.Guides.Get(id).steps[1].note or ''
settle()
local step = E.GetGuide().steps[1]
local goal = step.goals[1]
emit({initial=initial,note=step.note or '',goalNote=goal.note or '',quest=goal.quest,currentLog=goal.currentLog,
	map=goal.map,x=goal.x,y=goal.y,f=goal.f})
"#,
	);
	for stage in ["initial", "note", "goalNote"] {
		assert!(out[stage].as_str().unwrap().contains("Mira Saddler: inside Synthetic Dungeon."), "{stage}: {}", out[stage]);
	}
	assert!(out["note"].as_str().unwrap().contains("Travel time to this hand-in is unknown."));
	assert_eq!(out["quest"], 7101);
	assert_eq!(out["currentLog"], true);
	assert_eq!(out["map"], 9001);
	assert_eq!(out["x"], 40);
	assert_eq!(out["y"], 60);
	assert_eq!(out["f"], "e");
}

#[test]
fn a_new_unknown_recipient_does_not_inherit_an_earlier_manual_steps_checkoff() {
	let out = run(
		"w.onQuest(7106,{})",
		None,
		r#"
H.Start(); settle()
E.ToggleGoal(1,1); settle()
local checked = E.GetTabs()[1].complete == true
w.abandon(7106); w.onQuest(7105,{}); stub.fire('QUEST_LOG_UPDATE'); settle()
emit({checked=checked, live=E.GetLiveStep() or false, complete=E.GetTabs()[1].complete == true, notes=notes(E.GetGuide())})
"#,
	);
	assert_eq!(out["checked"], false, "unknown hand-ins remain active until the quest leaves the log, like known hand-ins");
	assert_eq!(out["live"], 1, "a different unknown hand-in must be visible again");
	assert_eq!(out["complete"], false);
	assert!(out["notes"].as_str().unwrap().contains("Hostile Recipient"));
}

#[test]
fn an_unknown_recipient_repeatable_stays_active_after_a_rapid_new_attempt() {
	let out = run(
		"w.repeatable[7106]=true; w.onQuest(7106,{})",
		None,
		r#"
H.Start(); settle()
E.ToggleGoal(1,1); settle()
-- The same delivery is accepted before the hand-in guide's refresh runs.
w.turnIn(7106); w.accept(7106,{}); settle()
local live, complete = E.GetLiveStep() or false, E.GetTabs()[1].complete == true
H.Start(); settle()
emit({ready=H.Ready(), live=live, complete=complete,
	reopenedLive=E.GetLiveStep() or false, reopenedComplete=E.GetTabs()[1].complete == true})
"#,
	);
	assert_eq!(out["ready"], json!([7106]));
	assert_eq!(out["live"], 1, "a new quest-log attempt must not inherit the manual check-off");
	assert_eq!(out["complete"], false);
	assert_eq!(out["reopenedLive"], 1, "opening the existing guide again still shows the new attempt");
	assert_eq!(out["reopenedComplete"], false);
}

#[test]
fn unflagged_deliveries_need_no_client_or_codex_objectives_and_must_not_be_failed() {
	let mut data = codex();
	data["quests"]["7108"]["objectives"] = json!([{ "type":"kill", "id":5001, "count":1 }]);
	let out = run_with(
		&data,
		"w.onQuest(7101,{}); w.onQuest(7102,{1}); w.onQuest(7108,{}); w.onQuest(7109,{}); w.onQuest(7120,{})\nfunction C_QuestLog.ReadyForTurnIn() return false end\nfunction C_QuestLog.IsComplete() return false end",
		None,
		r#"
local ready = H.Ready()
local id = H.Start(); settle()
emit({ready=ready, quests=ids(Polestar.Guides.Get(id)), wants=E.WantsQuest('turnin',7101)})
"#,
	);
	assert_eq!(out["ready"], json!([7101]), "only the known delivery with no remaining work is eligible");
	assert_eq!(out["quests"], json!([7101]));
	assert_eq!(out["wants"], true);
}

#[test]
fn an_empty_or_unfinished_log_does_not_load_codex_to_inspect_readiness() {
	for before in ["", "w.onQuest(7108,{1})"] {
		let out = run(
			before,
			None,
			r#"
local loads, load = 0, C_AddOns.LoadAddOn
C_AddOns.LoadAddOn = function(name) if name == 'Polestar_Codex' then loads = loads + 1 end; return load(name) end
emit({ready=H.Ready(), loads=loads})
"#,
		);
		assert_eq!(out, json!({"ready":{}, "loads":0}));
	}
}

#[test]
fn ordinary_progress_without_a_new_ready_quest_does_not_republish_the_guide() {
	let out = run(
		"w.onQuest(7101,{}); w.onQuest(7108,{10})",
		None,
		r#"
local id = H.Start(); settle()
local initial, publishes = Polestar.Guides.Get(id), 0
Polestar.On('PACKS_CHANGED', function() publishes = publishes + 1 end)
for progress=1,4 do w.progress(7108,1,progress); settle() end
emit({publishes=publishes, same=initial==Polestar.Guides.Get(id), quests=ids(E.GetGuide())})
"#,
	);
	assert_eq!(out, json!({"publishes":0, "same":true, "quests":[7101]}));
}
