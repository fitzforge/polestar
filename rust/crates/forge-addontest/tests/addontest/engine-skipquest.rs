//! Skipping a quest (Engine.SkipQuest): the player passes on one quest and the guide drops it with the quests
//! that follow from it, here and in the guides after, the other quests of the same step staying. Saved per
//! character, in every guide; the quest may be in the log; bringing it back undoes it all. Real Core manifest,
//! stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 50, 50)
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Human", "Human", "Alliance", "WARRIOR", "Warrior", 10
"#;

// A -> B -> C in one guide, D after C in the next one; Other shares A's step.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/c", pack = "test", title = "Chain", faction = "Alliance", minLevel = 1, maxLevel = 20, next = "test/c2", steps = {
	{ goals = { { t = "accept", quest = 1, title = "A", qlvl = 10 }, { t = "accept", quest = 9, title = "Other", qlvl = 10 } } },
	{ goals = { { t = "turnin", quest = 1, title = "A" }, { t = "accept", quest = 2, title = "B", qlvl = 10, pre = { 1 } } } },
	{ goals = { { t = "turnin", quest = 2, title = "B" }, { t = "accept", quest = 3, title = "C", qlvl = 10, pre = { 2 } } } },
	{ goals = { { t = "turnin", quest = 3, title = "C" } } },
	{ goals = { { t = "turnin", quest = 9, title = "Other" } } },
} })
Polestar.RegisterGuide({ id = "test/c2", pack = "test", title = "Chain 2", faction = "Alliance", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 4, title = "D", qlvl = 12, pre = { 3 } } } },
	{ goals = { { t = "accept", quest = 8, title = "Unrelated", qlvl = 12 } } },
} })
"#;

const HELPERS: &str = r#"
			E = Polestar.Engine
			function flush() stub.advance(0.25) end
			stub.login()
			stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
			-- Each step's statuses, goal by goal ("skipped" for a skipped quest).
			function statuses()
				local out = {}
				for i = 1, #E.GetGuide().steps do
					local g = {}
					for j, v in ipairs(E.GetStepView(i).goals) do g[j] = v.status end
					out[i] = table.concat(g, ",")
				end
				return out
			end
"#;

fn run(before: &str, saved: Option<&str>, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: saved.map(|s| ("Polestar".to_string(), s.to_string())).into_iter().collect(),
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_skipped_quest_goes_with_the_quests_that_follow_from_it_the_rest_of_its_step_stays_and_it_comes_back() {
	let out = run(
		"",
		None,
		r#"
			E.SetGuide("test/c"); flush()
			E.SkipQuest(1); flush()
			local skipped = { at = E.GetStepIndex(), statuses = statuses(), saved = PolestarCharDB.skippedQuests[1] or false,
				text = E.GetStepView(1).goals[1].unavailableText or false, follow = E.GetStepView(2).goals[2].unavailableText or false }
			E.SkipQuest(1, false); flush()
			emit({ skipped = skipped, back = { at = E.GetStepIndex(), statuses = statuses(), saved = PolestarCharDB.skippedQuests or false } })"#,
	);
	assert_eq!(
		out["skipped"],
		json!({
			"at": 1,
			"statuses": ["skipped,active", "skipped,skipped", "skipped,skipped", "skipped", "pending"],
			"saved": true,
			"text": "You skipped this quest",
			"follow": "Requires A first",
		}),
		"A, B and C go; Other in the same step stays"
	);
	assert_eq!(out["back"], json!({ "at": 1, "statuses": ["active,active", "pending,pending", "pending,pending", "pending", "pending"], "saved": false }));
}

#[test]
fn the_quests_that_follow_in_the_next_guide_go_too_and_the_automation_never_takes_a_skipped_quest() {
	let out = run(
		"stub.world.complete({ 9 })",
		None,
		r#"
			E.SetGuide("test/c"); flush()
			E.SkipQuest(1); flush()
			local wants = E.WantsQuest("accept", 1)
			stub.world.accept(9, {}, "Other"); flush()
			emit({ wants = wants, guide = E.GetGuide().id, at = E.GetStepIndex() or false, d = E.GetGuide().id == "test/c2" and E.GetStepView(1).goals[1].status or false })"#,
	);
	assert_eq!(out, json!({ "wants": false, "guide": "test/c2", "at": 2, "d": "skipped" }));
}

#[test]
fn a_quest_in_the_log_can_be_skipped_too_the_guide_stops_leading_to_it_and_a_reload_keeps_it_skipped() {
	let in_log = run(
		"stub.world.onQuest(1, {})",
		None,
		r#"
			E.SetGuide("test/c"); flush()
			local before = E.GetStepIndex()
			E.SkipQuest(1); flush()
			emit({ before = before, after = E.GetStepIndex(), turnin = E.GetStepView(2).goals[1].status })"#,
	);
	assert_eq!(in_log, json!({ "before": 1, "after": 1, "turnin": "skipped" }), "Other still waits in step 1; the turn-in of A is skipped");

	let reload =
		run("", Some(r#"PolestarCharDB = { schema = 1, tabs = { "test/c" }, activeTab = 1, skippedQuests = { [1] = true } }"#), "emit({ statuses = statuses(), skipped = E.IsQuestSkipped(1) })");
	assert_eq!(reload["statuses"].as_array().unwrap()[..2], [json!("skipped,active"), json!("skipped,skipped")]);
	assert_eq!(reload["skipped"], true);
}

#[test]
fn a_skipped_quest_done_anyway_counts_as_done_and_its_follow_ups_come_back() {
	let out = run(
		"",
		None,
		r#"
			E.SetGuide("test/c"); flush()
			E.SkipQuest(1); flush()
			stub.world.complete({ 1 }); stub.fire("QUEST_LOG_UPDATE"); flush()
			emit({ statuses = statuses() })"#,
	);
	assert_eq!(out["statuses"].as_array().unwrap()[..3], [json!("done,active"), json!("done,pending"), json!("pending,pending")]);
}
