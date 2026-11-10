//! A quest that failed in the log (an escort lost, an event's NPC killed: C_QuestLog.IsFailed, via
//! Compat.IsQuestFailed) can't be done until it is abandoned and taken again (addon/Polestar/Core/Engine.lua,
//! Own.lostGoal / Own.failedQuest / Own.failedAim). Its goals are greyed with "failed: abandon it and take it
//! again", the step waits as before, other open work of the step comes first, then the arrow leads to the
//! giver; abandoning it sends the route back there without asking. Players' recordings: The Absent Minded
//! Prospector's escort (731) failed for 4 of 24 who took it, Gerenzo's Orders (1090) for 7.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1439, { name = "Darkshore", c = 1, left = 2000, right = -2000, top = 2000, bottom = -2000 })
w.addMap(1442, { name = "Stonetalon Mountains", c = 1, left = 3000, right = -3000, top = 3000, bottom = -3000 })
w.titles[731] = "The Absent Minded Prospector"
w.titles[1090] = "Gerenzo's Orders"
w.titles[1093] = "Super Reaper 6000"
FAILED = {}
function C_QuestLog.IsFailed(q) return FAILED[q] == true end
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/failed", pack = "test", title = "Failed", minLevel = 1, maxLevel = 30,
	steps = {
		{ title = "Prospector Remtravel", goals = {
			{ t = "accept", quest = 731, title = "The Absent Minded Prospector", npc = 2917, npcName = "Prospector Remtravel", map = 1439, x = 35.7, y = 83.7 },
		} },
		{ title = "Escort Remtravel", goals = {
			{ t = "complete", quest = 731, title = "The Absent Minded Prospector", escort = true, map = 1439, x = 36.0, y = 85.0 },
		} },
		{ title = "Archaeologist Hollee", goals = {
			{ t = "turnin", quest = 731, title = "The Absent Minded Prospector", npc = 2912, npcName = "Archaeologist Hollee", map = 1439, x = 36.4, y = 44.6 },
		} },
		{ title = "Gerenzo Wrenchwhistle", goals = {
			{ t = "accept", quest = 1090, title = "Gerenzo's Orders", npc = 4202, npcName = "Gerenzo Wrenchwhistle", map = 1442, x = 63.2, y = 40.2 },
			{ t = "accept", quest = 1093, title = "Super Reaper 6000", npc = 4202, npcName = "Gerenzo Wrenchwhistle", map = 1442, x = 63.2, y = 40.2 },
		} },
		{ title = "Windshear Crag", goals = {
			{ t = "complete", quest = 1090, title = "Gerenzo's Orders", map = 1442, x = 59.0, y = 62.0 },
			{ t = "kill", target = "Super Reaper 6000", npc = 4215, count = 1, quest = 1093, oi = 1, map = 1442, x = 61.0, y = 52.0 },
		} },
		{ title = "Trainer", goals = { { t = "train", npc = 911, npcName = "Trainer" } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25) end
function state(s)
	local live = E.GetLiveStep()
	local wp = E.GetWaypoint()
	local said = {}
	for _, m in ipairs(stub.messages) do
		if m:find("quest log", 1, true) then said[#said + 1] = m:gsub("^.-: ", "") end
	end
	local goals = {}
	for _, gv in ipairs(E.GetStepView(s).goals) do goals[#goals + 1] = { status = gv.status, notice = gv.noticeText or false } end
	local cands = {}
	for _, c in ipairs(E.GetWhileHereCandidates()) do cands[#cands + 1] = c.step .. ":" .. c.index end
	return { live = live, lost = E.LostQuestion() or false, goals = goals,
		arrow = wp and (wp.stepIndex .. ":" .. wp.goalIndex) or false, said = table.concat(said, "\n"), cands = cands }
end
"#;

fn run(before: &str, script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}\n{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/failed" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn a_failed_escort_greys_its_goal_says_to_take_it_again_and_leads_to_its_giver() {
	let out = run(
		r#"stub.world.moveTo(1439, 36, 84)
stub.world.onQuest(731, { { type = "event", required = 1, fulfilled = 0 } })"#,
		r#"
		emit(state(2))
		FAILED[731] = true; flush()
		emit(state(2))
		stub.world.abandon(731); FAILED[731] = nil; flush()
		emit(state(2))
		stub.world.accept(731, { { type = "event", required = 1, fulfilled = 0 } }); flush()
		emit(state(2))
	"#,
	);
	assert_eq!(out[0]["live"], 2, "{}", out[0]);
	assert_eq!(out[0]["goals"], json!([{ "status": "active", "notice": false }]), "{}", out[0]);
	assert_eq!(out[0]["arrow"], "2:1", "{}", out[0]);
	// Failed: the step waits, its goal greyed with the reason, the arrow on Remtravel.
	assert_eq!(out[1]["live"], 2, "{}", out[1]);
	assert_eq!(
		out[1]["goals"],
		json!([{ "status": "skipped", "notice": "“The Absent Minded Prospector” failed: abandon it and take it again" }]),
		"{}",
		out[1]
	);
	assert_eq!(out[1]["arrow"], "1:1", "{}", out[1]);
	// Abandoned to take it again: back to the giver, no question.
	assert_eq!(out[2]["live"], 1, "{}", out[2]);
	assert_eq!(out[2]["lost"], false, "{}", out[2]);
	assert!(out[2]["said"].as_str().unwrap().contains("goes back for it"), "{}", out[2]);
	// Taken again: the escort is work again.
	assert_eq!(out[3]["live"], 2, "{}", out[3]);
	assert_eq!(out[3]["goals"], json!([{ "status": "active", "notice": false }]), "{}", out[3]);
}

#[test]
fn a_failed_quest_beside_other_work_lets_that_work_lead_then_leads_to_its_giver() {
	let out = run(
		r#"stub.world.moveTo(1442, 60, 55)
stub.world.complete({ 731 })
stub.world.onQuest(1090, { { type = "event", required = 1, fulfilled = 0 } })
stub.world.onQuest(1093, { { type = "monster", required = 1, fulfilled = 0 } })"#,
		r#"
		FAILED[1090] = true; flush()
		emit(state(5))
		stub.world.progress(1093, 1, 1); flush()
		emit(state(5))
	"#,
	);
	assert_eq!(out[0]["live"], 5, "{}", out[0]);
	assert_eq!(
		out[0]["goals"],
		json!([{ "status": "skipped", "notice": "“Gerenzo's Orders” failed: abandon it and take it again" }, { "status": "active", "notice": false }]),
		"{}",
		out[0]
	);
	assert_eq!(out[0]["arrow"], "5:2", "the Super Reaper first: {}", out[0]);
	// The Reaper done: the step still waits on Gerenzo's Orders, and the arrow leads to Gerenzo.
	assert_eq!(out[1]["live"], 5, "{}", out[1]);
	assert_eq!(out[1]["arrow"], "4:1", "{}", out[1]);
}
