//! The answer for every group quest (behavior.groupQuests, Options, Guide, Automation, Quests): "ask" (the
//! default) asks at each `when group` step, "do" and "skip" answer every quest the player has not answered
//! one by one, so the route never waits. An answer given for one quest (Engine.AnswerGroup, the banner,
//! Discovery > Group quests) wins over it. Same world and guides as tests/engine-when-group.test.js.

use forge_addontest::{emitted, lua_value, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.titles[7] = "Kobold Camp Cleanup"
w.onQuest(783, {})
"#;

const GROUP_GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/group", pack = "test", title = "Group", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Group quest", when = { { k = "group", q = 7 } }, goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "The solo way", when = { { k = "group", q = 7, neg = true } }, goals = { { t = "task", text = "Pull one at a time" } } },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

fn run(all: Option<&str>, answers: Option<Value>, script: &str) -> Vec<Value> {
	let mut char = json!({ "schema": 1, "guide": "test/group" });
	if let Some(a) = answers {
		char["groupQuests"] = a;
	}
	let account = all.map(|a| format!("PolestarDB = {{ schema = 1, settings = {{ behavior = {{ groupQuests = {} }} }} }}\n", lua_value(&json!(a)))).unwrap_or_default();
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), format!("{account}PolestarCharDB = {}", lua_value(&char)))],
		script: [TEST_PACK, TEST_SOURCE, GROUP_GUIDE, "E = Polestar.Engine", "function flush() stub.advance(0.25) end", "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script]
			.join("\n"),
		..Default::default()
	})
}

const STATE: &str = "emit({ at = E.GetLiveStep(), q = E.GroupQuestion() or false, answer = E.GroupAnswer(7) or false, s1 = E.GetStepView(1).status, s2 = E.GetStepView(2).status })";

#[test]
fn group_quests_ask_the_default_waits_at_the_step_and_asks() {
	let out = run(None, None, STATE);
	assert_eq!(out[0], json!({ "at": 1, "q": 7, "answer": false, "s1": "current", "s2": "upcoming" }));
}

#[test]
fn group_quests_skip_takes_the_solo_way_without_asking_do_the_group_way() {
	let skip = &run(Some("skip"), None, STATE)[0];
	assert_eq!(skip["q"], false, "nothing to ask");
	assert_eq!(skip["answer"], "skip");
	assert_eq!(skip["s1"], "skipped");
	assert_eq!(skip["at"], 2, "the solo step");
	let do_it = &run(Some("do"), None, STATE)[0];
	assert_eq!(*do_it, json!({ "at": 1, "q": false, "answer": "do", "s1": "current", "s2": "na" }));
}

#[test]
fn group_quests_an_answer_for_one_quest_wins_over_the_answer_for_all() {
	let out = run(Some("skip"), Some(json!({ "7": "do" })), STATE);
	assert_eq!(out[0], json!({ "at": 1, "q": false, "answer": "do", "s1": "current", "s2": "na" }));
}

#[test]
fn group_quests_changing_the_answer_for_all_re_evaluates_the_route() {
	let out = run(None, None, &format!("{STATE}\nPolestar.Set(\"behavior.groupQuests\", \"skip\"); flush()\n{STATE}"));
	let (asked, skipped) = (&out[0], &out[1]);
	assert_eq!(asked["q"], 7);
	assert_eq!(skipped["q"], false);
	assert_eq!(skipped["at"], 2);
}
