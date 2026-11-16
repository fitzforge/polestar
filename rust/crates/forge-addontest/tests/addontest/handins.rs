//! Completed quest-log errands, independent of the player's leveling guide (#2480).
//! Synthetic Codex data runs through the real pack decoder, planner and Engine tab lifecycle.

use forge_addontest::codex::{fixture, write_codex_pack, CodexOpts};
use forge_addontest::{emitted, lua_value, Addon, RunAddon};
use serde_json::{json, Value};

const ID: &str = "lookup/handins/ready";

#[path = "handins-routing.rs"]
mod routing;

#[path = "handins-readiness.rs"]
mod readiness;

fn codex() -> Value {
	let mut c = fixture("lookup.json");
	c["quests"] = json!({});
	for (q, title, npcs, objects) in [
		(7101, "Amber Parcel", vec![5001], vec![]),
		(7102, "Amber Letter", vec![5001], vec![]),
		(7103, "Island Parcel", vec![5015], vec![]),
		(7104, "Hollow Offering", vec![], vec![6010]),
		(7105, "Hostile Recipient", vec![5002], vec![]),
		(7106, "Lost Recipient", vec![], vec![]),
		(7107, "Both Factions", vec![5002, 5001], vec![]),
		(7108, "Unfinished Parcel", vec![5001], vec![]),
		(7109, "Failed Parcel", vec![5001], vec![]),
		(7110, "Repeatable Parcel", vec![5001], vec![]),
		(7111, "New Follow-up", vec![5001], vec![]),
	] {
		c["quests"][q.to_string()] = json!({ "id": q, "title": title, "level": 20, "minLevel": 1,
			"start": { "npc": [5001], "object": [], "item": [] }, "end": { "npc": npcs, "object": objects },
			"objectives": [], "pre": [], "preAny": [], "zone": 9001, "rewards": [], "choices": [] });
	}
	c["quests"]["7111"]["pre"] = json!([7101]);
	c["npcs"]["5015"] = json!({ "id": 5015, "name": "Island Courier", "faction": "A", "roles": [],
		"spawns": [{ "map": 9003, "x": 35, "y": 65, "f": "e", "z": 12 }] });
	c["objects"]["6010"] = json!({ "id": 6010, "name": "Hollow Altar", "spawns": [{ "map": 9002, "x": 40, "y": 60, "f": "e" }] });
	c
}

const WORLD: &str = r#"
local w = stub.world
w.level, w.race, w.raceName, w.faction, w.class, w.className = 30, "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.addMap(9001, { name = "Amber Vale", c = 0, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.addMap(9002, { name = "Ember Hollow", c = 0, left = -1000, right = -3000, top = 1000, bottom = -1000 })
w.addMap(9003, { name = "Frost Isle", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
w.moveTo(9001, 50, 50)
function C_QuestLog.IsFailed(q) return q == 7109 end
"#;

const HELPERS: &str = r#"
local H, E, L = Polestar.Handins, Polestar.Engine, Polestar.Lookup
local function ids(g)
	local out = {}
	for _, s in ipairs(g and g.steps or {}) do
		for _, goal in ipairs(s.goals or {}) do if goal.t == "turnin" then out[#out + 1] = goal.quest end end
	end
	table.sort(out)
	return out
end
local function notes(g)
	local out = {}
	for _, s in ipairs(g and g.steps or {}) do
		for _, goal in ipairs(s.goals or {}) do if goal.t == "note" then out[#out + 1] = goal.text or "" end end
	end
	return table.concat(out, " ")
end
local function tabIds()
	local out = {}
	for i, t in ipairs(E.GetTabs()) do out[i] = t.guideId end
	return out
end
local function settle() stub.advance(1) end
local fillerPack = false
local function openOther(id)
	if not fillerPack then
		assert(Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" }))
		fillerPack = true
	end
	assert(Polestar.RegisterGuide({ id = id, pack = "test", title = id, category = "Test", steps = {
		{ title = "Keep this progress", goals = {{ t = "level", level = 60 }} }
	} }))
	return assert(E.OpenTab(id, true))
end
"#;

fn run(before: &str, saved: Option<String>, script: &str) -> Value {
	run_with(&codex(), before, saved, script)
}

fn run_with(data: &Value, before: &str, saved: Option<String>, script: &str) -> Value {
	let pack = write_codex_pack(data, &CodexOpts::default());
	let names: serde_json::Map<String, Value> = data["quests"].as_object().unwrap().iter().map(|(id, q)| (id.clone(), q["title"].clone())).collect();
	let names = lua_value(&Value::Object(names));
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{}\n{WORLD}\nfor q,title in pairs({names}) do w.titles[tonumber(q)] = title end\n{before}", pack.stub_lua),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Lookup/Lookup.xml", "Dungeons/Dungeons.xml"])],
		saved: saved.map(|s| ("Polestar".into(), s)).into_iter().collect(),
		login: true,
		script: format!("{HELPERS}\n{script}"),
	})
	.remove(0)
}

#[test]
fn readiness_comes_from_the_current_log_and_keeps_ready_repeatables() {
	let out = run(
		"w.onQuest(7101, {})\nw.onQuest(7108, {1})\nw.onQuest(7109, {})\nw.complete({7103,7110})\nw.onQuest(7110, {})",
		None,
		r#"
local get = Polestar.Compat.GetLogQuests
Polestar.Compat.GetLogQuests = function() local q = get(); q[#q+1] = 7101; return q end
emit(H.Ready())
"#,
	);
	assert_eq!(out, json!([7101, 7110]));
}

#[test]
fn the_route_groups_recipients_across_the_world_and_contains_only_ready_turnins() {
	let out = run(
		"for _, q in ipairs({7101,7102,7103,7104}) do w.onQuest(q, {}) end\nw.onQuest(7108, {1})",
		None,
		r#"
local id, why = H.Start()
settle()
local guide = Polestar.Guides.Get(id)
local counts, places, verbs = {}, {}, {}
for _, s in ipairs(guide.steps) do
	local group = {}
	for _, g in ipairs(s.goals) do
		verbs[g.t] = true
		if g.t == "turnin" then group[#group + 1] = g.quest; places[tostring(g.quest)] = {g.map,g.x,g.y,g.npc or false,g.object or false} end
	end
	if #group > 0 then table.sort(group); counts[#counts + 1] = table.concat(group, ",") end
end
table.sort(counts)
emit({id=id, why=why or false, ids=ids(guide), groups=counts, places=places, accepts=verbs.accept or false, talks=verbs.talk or false})
"#,
	);
	assert_eq!(out["id"], ID);
	assert_eq!(out["ids"], json!([7101, 7102, 7103, 7104]));
	assert_eq!(out["groups"], json!(["7101,7102", "7103", "7104"]));
	assert_eq!(out["places"]["7103"], json!([9003, 35, 65, 5015, false]));
	assert_eq!(out["places"]["7104"], json!([9002, 40, 60, false, 6010]));
	assert_eq!(out["accepts"], false);
	assert_eq!(out["talks"], false);
}

#[test]
fn hostile_and_missing_recipients_are_named_without_inventing_a_destination() {
	let out = run(
		"for _, q in ipairs({7105,7106,7107,7120}) do w.onQuest(q, {}, q == 7120 and 'Uncatalogued Errand' or nil) end",
		None,
		r#"
local id = H.Start(); settle()
local g = Polestar.Guides.Get(id)
local recipient
for _, s in ipairs(g.steps) do for _, goal in ipairs(s.goals) do if goal.quest == 7107 then recipient = goal.npc end end end
emit({ids=ids(g), recipient=recipient, notes=notes(g)})
"#,
	);
	assert_eq!(out["ids"], json!([7107]));
	assert_eq!(out["recipient"], 5001);
	let note = out["notes"].as_str().unwrap();
	for title in ["Hostile Recipient", "Lost Recipient", "Uncatalogued Errand"] {
		assert!(note.contains(title), "missing {title} in {note}");
	}
}

#[test]
fn unknown_handins_remain_visible_as_actionable_information_even_after_known_handins_finish() {
	for mixed in [false, true] {
		let before = if mixed { "w.onQuest(7106,{}); w.onQuest(7101,{})" } else { "w.onQuest(7106,{})" };
		let deliver = if mixed { "assert(E.WantsQuest('turnin',7101)); w.turnIn(7101); settle()" } else { "" };
		let script = format!(
			"local id = H.Start(); stub.fire('QUEST_LOG_UPDATE'); settle(); {deliver}\n{}",
			r#"
local g, live, task = E.GetGuide(), E.GetLiveStep(), false
local view = live and E.GetStepView(live)
for _,goal in ipairs(view and view.goals or {}) do if goal.t == 'task' and goal.status == 'active' then task = true end end
emit({id=id, ids=ids(g), notes=notes(g), live=live or false, task=task, complete=E.GetTabs()[1].complete == true})
"#
		);
		let out = run(before, None, &script);
		assert_eq!(out["id"], ID);
		assert_eq!(out["ids"], json!({}));
		assert!(out["notes"].as_str().unwrap().contains("Lost Recipient"));
		assert_eq!(out["live"], 1, "unknown hand-ins cannot disappear behind the completed-guide screen (mixed={mixed})");
		assert_eq!(out["task"], true, "the player can review the remaining manual hand-in");
		assert_eq!(out["complete"], false);
	}
}

#[test]
fn nothing_ready_does_not_open_or_replace_a_tab() {
	let out = run("w.onQuest(7108, {1})", None, "openOther('test/current'); local id, why = H.Start(); settle(); emit({id=id or false, why=why, tabs=tabIds(), active=E.GetGuide().id})");
	assert_eq!(out, json!({"id":false,"why":"nothing","tabs":["test/current"],"active":"test/current"}));
}

#[test]
fn missing_codex_data_explains_why_no_route_can_be_opened() {
	let out = run(
		"w.onQuest(7101,{})\nlocal load = C_AddOns.LoadAddOn\nC_AddOns.LoadAddOn = function(name) if name == 'Polestar_Codex' then return false,'MISSING' end return load(name) end",
		None,
		r#"
openOther('test/current')
local count = #stub.messages
local id, why = H.Start(); settle()
emit({id=id or false, why=why or false, tabs=tabIds(), active=E.GetGuide().id, explained=#stub.messages > count})
"#,
	);
	assert_eq!(out["id"], false);
	assert!(out["why"].as_str().is_some_and(|s| !s.is_empty()));
	assert_eq!(out["explained"], true);
	assert_eq!(out["tabs"], json!(["test/current"]));
	assert_eq!(out["active"], "test/current");
}

#[test]
fn quest_changes_refresh_in_place_without_stealing_the_other_guides_focus() {
	let out = run(
		"w.onQuest(7101, {})",
		None,
		r#"
openOther('test/current')
local id = H.Start(); settle()
E.SelectTab(1)
w.onQuest(7103, {}); stub.fire('QUEST_LOG_UPDATE'); settle()
local added = ids(Polestar.Guides.Get(id))
w.abandon(7101); settle()
local removed = ids(Polestar.Guides.Get(id))
w.onQuest(7103, {1}); stub.fire('QUEST_LOG_UPDATE'); settle()
local empty = Polestar.Guides.Get(id)
local active = E.GetGuide().id
E.SelectTab(2)
emit({added=added, removed=removed, empty=ids(empty), shown=ids(E.GetGuide()), note=notes(empty), tabs=tabIds(), active=active})
"#,
	);
	assert_eq!(out["added"], json!([7101, 7103]));
	assert_eq!(out["removed"], json!([7103]));
	assert_eq!(out["empty"], json!({}));
	assert_eq!(out["shown"], json!({}));
	assert!(!out["note"].as_str().unwrap().is_empty());
	assert_eq!(out["tabs"], json!(["test/current", ID]));
	assert_eq!(out["active"], "test/current");
}

#[test]
fn a_turnin_finishes_without_adding_the_followup_or_reopening_a_closed_route() {
	let out = run(
		"w.onQuest(7101, {})",
		None,
		r#"
local id = H.Start(); settle()
w.turnIn(7101); settle()
local done = Polestar.Guides.Get(id)
local left, message = ids(done), notes(done)
for i,t in ipairs(E.GetTabs()) do if t.guideId == id then E.CloseTab(i); break end end
local closed = Polestar.Guides.Get(id)
w.onQuest(7103, {}); stub.fire('QUEST_LOG_UPDATE'); settle()
emit({left=left, message=message, tabs=tabIds(), changed=Polestar.Guides.Get(id) ~= closed, accepted=w.log[7111] ~= nil})
"#,
	);
	assert_eq!(out["left"], json!({}));
	assert!(!out["message"].as_str().unwrap().is_empty());
	assert_eq!(out["tabs"], json!({}));
	assert_eq!(out["changed"], false);
	assert_eq!(out["accepted"], false);
}

#[test]
fn a_saved_route_waits_for_the_quest_log_then_restores_ready_quests() {
	let first = run("w.onQuest(7101, {})", None, "H.Start(); settle(); emit(Polestar.CharState())");
	let saved = format!("PolestarCharDB = {}", lua_value(&first));
	let out = run(
		"",
		Some(saved),
		r#"
local before = tabIds()
w.onQuest(7101, {}); w.onQuest(7103, {}); stub.fire('QUEST_LOG_UPDATE'); settle()
emit({before=before, after=tabIds(), ids=ids(Polestar.Guides.Get('lookup/handins/ready'))})
"#,
	);
	assert_eq!(out["before"], json!([ID]));
	assert_eq!(out["after"], json!([ID]));
	assert_eq!(out["ids"], json!([7101, 7103]));
}

#[test]
fn six_existing_tabs_are_preserved_when_start_cannot_open_a_route() {
	let out = run(
		"w.onQuest(7101, {})",
		None,
		r#"
for i=1,6 do openOther('test/' .. i) end
local before, active = tabIds(), E.GetGuide().id
local id, why = H.Start(); settle()
emit({before=before, after=tabIds(), id=id or false, why=why, active=E.GetGuide().id, prior=active})
"#,
	);
	assert_eq!(out["id"], false);
	assert_eq!(out["why"], "tabs");
	assert_eq!(out["before"], out["after"]);
	assert_eq!(out["before"].as_array().unwrap().len(), 6);
	assert_eq!(out["active"], out["prior"]);
}

#[test]
fn accepting_a_repeatable_again_clears_the_recent_turnin_bridge() {
	let out = run(
		"w.repeatable[7110] = true; w.onQuest(7110,{})",
		None,
		r#"
local id = H.Start(); settle()
w.turnIn(7110)
w.onQuest(7110,{}) -- The old ready log entry can briefly lag the hand-in event.
local lag = H.Ready(); settle()
w.accept(7110,{})
local accepted = H.Ready(); settle()
emit({lag=lag, accepted=accepted, route=ids(Polestar.Guides.Get(id))})
"#,
	);
	assert_eq!(out["lag"], json!({}));
	assert_eq!(out["accepted"], json!([7110]));
	assert_eq!(out["route"], json!([7110]));
}

#[test]
fn a_ready_repeatable_remains_an_actionable_engine_goal_despite_its_completion_history() {
	let out = run(
		"w.repeatable[7110] = true; w.complete({7110}); w.onQuest(7110,{})",
		None,
		r#"
local function action()
	local live = E.GetLiveStep()
	local view = live and E.GetStepView(live)
	local g = view and view.goals and view.goals[1]
	return {step=live or false, quest=g and g.quest or false, status=g and g.status or false, wants=E.WantsQuest('turnin',7110)}
end
H.Start(); stub.fire('QUEST_LOG_UPDATE'); settle()
local first = action()
w.turnIn(7110); settle()
w.accept(7110,{}); settle()
emit({first=first, again=action()})
"#,
	);
	let actionable = json!({"step":1,"quest":7110,"status":"active","wants":true});
	assert_eq!(out["first"], actionable, "the player still has a ready quest even when its historical completed flag is set");
	assert_eq!(out["again"], actionable, "a new accepted repeatable is actionable after this session's earlier hand-in");
}

#[test]
fn the_handin_command_opens_the_route_through_the_real_command_dispatcher() {
	let out = run("w.onQuest(7101,{})", None, "Polestar.RunCommand('handin'); settle(); emit({tabs=tabIds(), active=E.GetGuide().id, quests=ids(E.GetGuide())})");
	assert_eq!(out, json!({"tabs":[ID], "active":ID, "quests":[7101]}));
}

#[test]
fn closing_an_inactive_handin_tab_then_reopening_it_restarts_cancelled_planning() {
	let out = run(
		"w.onQuest(7101,{}); w.onQuest(7103,{})",
		None,
		r#"
local calls, busy = 0, true
Polestar.Nav = { EstimateTravelCooperative = function()
	calls = calls + 1
	if busy then return nil, 'busy' end
	return 30
end }
openOther('test/current')
local id = H.Start(); settle()
E.SelectTab(1); E.CloseTab(2); settle()
local closed = calls
busy = false
assert(E.ReopenClosedTab(id))
stub.advance(4)
local g = E.GetGuide()
emit({closed=closed, calls=calls, active=g.id, quests=ids(g), finished=g.steps[1].note == nil})
"#,
	);
	assert!(out["calls"].as_u64().unwrap() > out["closed"].as_u64().unwrap(), "a reopened route resumes its navigation estimates");
	assert_eq!(out["active"], ID);
	assert_eq!(out["quests"], json!([7101, 7103]));
	assert_eq!(out["finished"], true);
}
