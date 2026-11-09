//! A quest the route had passed leaves the log (addon/Polestar/Core/Engine.lua, Own.holdLost): the live
//! step stays where it was and Engine.LostQuestion asks; "back" sends the route to the giver, "skip"
//! skips the quest and what follows from it. While it asks, the quest's own goals are greyed and the
//! arrow leads to its giver (#1365); behavior.lostQuests answers at once. Real Core manifest, stub world
//! (a level 1 Human Warrior in Elwynn Forest).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.titles[7] = "Kobold Camp Cleanup"
w.onQuest(783, {})
w.onQuest(7, {})
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/lost", pack = "test", title = "Lost", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Trainer", goals = { { t = "train", npc = 911, npcName = "Llane Beshere" } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function state()
	local q, title = E.LostQuestion()
	return { live = E.GetLiveStep(), lost = q, title = title, skipped = E.IsQuestSkipped(7) }
end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/lost" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn a_passed_quest_leaving_the_log_holds_the_live_step_and_asks() {
	let out = run(r#"
		emit(state())
		stub.world.abandon(7); flush()
		emit(state())
		emit(PolestarCharDB.lostQuests["test/lost"][7])
	"#);
	assert_eq!(out[0], json!({ "live": 3, "skipped": false }));
	assert_eq!(out[1], json!({ "live": 3, "lost": 7, "title": "Kobold Camp Cleanup", "skipped": false }));
	assert_eq!(out[2], 3, "the hold is saved for the character");
}

#[test]
fn going_back_for_a_lost_quest_sends_the_route_to_its_giver() {
	let out = run(r#"
		stub.world.abandon(7); flush()
		E.AnswerLost(7, "back"); flush()
		emit(state())
		emit(PolestarCharDB.lostQuests == nil)
	"#);
	assert_eq!(out[0], json!({ "live": 2, "skipped": false }));
	assert_eq!(out[1], true);
}

#[test]
fn skipping_a_lost_quest_keeps_the_route_and_skips_the_quest() {
	let out = run(r#"
		stub.world.abandon(7); flush()
		E.AnswerLost(7, "skip"); flush()
		emit(state())
	"#);
	assert_eq!(out[0], json!({ "live": 3, "skipped": true }));
}

#[test]
fn taking_a_lost_quest_again_ends_the_question() {
	let out = run(r#"
		stub.world.abandon(7); flush()
		stub.world.accept(7, {}); flush()
		emit(state())
	"#);
	assert_eq!(out[0], json!({ "live": 3, "skipped": false }));
}

// The held quest's work in the live step (#1365: Cutting Teeth's boars, Durotar): the kills, then the
// turn-in ahead, and a trainer after it.
const WORK_GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/lostwork", pack = "test", title = "Lost work", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Kobolds", goals = {
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
		} },
		{ title = "Back to McBride", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Trainer", goals = { { t = "train", npc = 911, npcName = "Llane Beshere", map = 1429, x = 50.2, y = 42.3 } } },
	},
})
"#;

const WORK_HELPERS: &str = r#"
function work()
	local q = E.LostQuestion()
	local wp = E.GetWaypoint()
	local kill = E.GetStepView(3).goals[1]
	local said = {}
	for _, m in ipairs(stub.messages) do
		if m:find("quest log", 1, true) then said[#said + 1] = m:gsub("^.-: ", "") end
	end
	return {
		live = E.GetLiveStep(), lost = q or false, skipped = E.IsQuestSkipped(7),
		kill = kill.status, killLost = kill.lost or false, killNotice = kill.noticeText or false,
		turnin = E.GetStepView(4).goals[1].status,
		arrow = wp and { step = wp.stepIndex, goal = wp.goalIndex, kind = wp.kind, x = wp.x, y = wp.y } or false,
		said = table.concat(said, "\n"),
	}
end
"#;

fn run_work(setting: Option<&str>, script: &str) -> Vec<Value> {
	let world = format!("{WORLD}\nw.onQuest(7, {{ {{ required = 10, fulfilled = 2 }} }})\n");
	let set = setting.map(|s| format!(r#"Polestar.Set("behavior.lostQuests", "{s}"); flush()"#)).unwrap_or_default();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: world,
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/lostwork" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, WORK_GUIDE, HELPERS, WORK_HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, &set, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn while_asked_the_lost_quests_goals_are_greyed_and_the_arrow_leads_to_its_giver() {
	let out = run_work(
		None,
		r#"
		emit(work())
		stub.world.abandon(7); flush()
		emit(work())
	"#,
	);
	assert_eq!(
		out[0],
		json!({ "live": 3, "lost": false, "skipped": false, "kill": "active", "killLost": false, "killNotice": false,
			"turnin": "pending", "arrow": { "step": 3, "goal": 1, "kind": "kill", "x": 47.6, "y": 35.1 }, "said": "" })
	);
	assert_eq!(
		out[1],
		json!({ "live": 3, "lost": 7, "skipped": false, "kill": "skipped", "killLost": true,
			"killNotice": "Kobold Camp Cleanup isn't in your quest log", "turnin": "skipped",
			"arrow": { "step": 2, "goal": 1, "kind": "accept", "x": 48.9, "y": 41.6 }, "said": "" }),
		"the step and the notice stay; its kills and turn-in are greyed, the arrow is on the giver"
	);
}

#[test]
fn taking_the_lost_quest_again_brings_its_goals_and_the_arrow_back() {
	let out = run_work(
		None,
		r#"
		stub.world.abandon(7); flush()
		stub.world.accept(7, { { required = 10, fulfilled = 0 } }); flush()
		emit(work())
	"#,
	);
	assert_eq!(
		out[0],
		json!({ "live": 3, "lost": false, "skipped": false, "kill": "active", "killLost": false, "killNotice": false,
			"turnin": "pending", "arrow": { "step": 3, "goal": 1, "kind": "kill", "x": 47.6, "y": 35.1 }, "said": "" })
	);
}

#[test]
fn skip_it_and_what_follows_still_works_while_the_goals_are_greyed() {
	let out = run_work(
		None,
		r#"
		stub.world.abandon(7); flush()
		E.AnswerLost(7, "skip"); flush()
		emit(work())
	"#,
	);
	assert_eq!(out[0]["live"], 5);
	assert_eq!(out[0]["lost"], false);
	assert_eq!(out[0]["skipped"], true);
	assert_eq!(out[0]["arrow"]["kind"], "train");
}

#[test]
fn the_ask_setting_is_the_default() {
	let out = run_work(None, r#"emit(Polestar.Get("behavior.lostQuests"))"#);
	assert_eq!(out[0], "ask");
}

#[test]
fn always_go_back_for_it_returns_to_the_giver_without_asking_and_says_so() {
	let out = run_work(
		Some("back"),
		r#"
		stub.world.abandon(7); flush()
		emit(work())
		emit(PolestarCharDB.lostQuests == nil)
	"#,
	);
	assert_eq!(
		out[0],
		json!({ "live": 2, "lost": false, "skipped": false, "kill": "pending", "killLost": false, "killNotice": false,
			"turnin": "pending", "arrow": { "step": 2, "goal": 1, "kind": "accept", "x": 48.9, "y": 41.6 },
			"said": "Kobold Camp Cleanup is no longer in your quest log: the guide goes back for it." })
	);
	assert_eq!(out[1], true, "nothing is held");
}

#[test]
fn always_skip_it_skips_the_quest_and_what_follows_without_asking_and_says_so() {
	let out = run_work(
		Some("skip"),
		r#"
		stub.world.abandon(7); flush()
		emit(work())
		emit(PolestarCharDB.lostQuests == nil)
	"#,
	);
	assert_eq!(out[0]["live"], 5);
	assert_eq!(out[0]["lost"], false);
	assert_eq!(out[0]["skipped"], true);
	assert_eq!(out[0]["kill"], "skipped");
	assert_eq!(out[0]["arrow"]["kind"], "train");
	assert_eq!(out[0]["said"], "Kobold Camp Cleanup is no longer in your quest log: the guide skips it and what follows.");
	assert_eq!(out[1], true, "nothing is held");
}

#[test]
fn choosing_an_always_answer_answers_the_question_already_up() {
	let out = run_work(
		None,
		r#"
		stub.world.abandon(7); flush()
		Polestar.Set("behavior.lostQuests", "back"); flush()
		emit(work())
	"#,
	);
	assert_eq!(out[0]["live"], 2);
	assert_eq!(out[0]["lost"], false);
	assert_eq!(out[0]["arrow"]["kind"], "accept");
}
