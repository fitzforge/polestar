//! A quest the route had passed leaves the log (addon/Polestar/Core/Engine.lua, Own.holdLost): the live
//! step stays where it was and Engine.LostQuestion asks; "back" sends the route to the giver, "skip"
//! skips the quest and what follows from it. Real Core manifest, stub world (a level 1 Human Warrior in
//! Elwynn Forest).

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
