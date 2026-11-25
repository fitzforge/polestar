//! Escorts are the player's choice (addon/Polestar/Core/Engine.lua, #3439): a required accept of an escort
//! quest (compiled `escort`) asks at its step as a group quest does, "Escort, about 12 min; 1 in 3 runs fails.
//! Optional: the route doesn't need it." (players' recorded time and failures, compiled `escortSecs` and
//! `escortFail`), with Skip it and Do it. Skipped, the quest is out of the route (its accept, work and hand-in),
//! with no nag; the answer is kept per quest like a group answer and listed with the group quests; a step that
//! asks about the quest itself (`when group`) keeps the author's choice. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.level = 20
w.titles[309] = "Protecting the Shipment"; w.titles[7] = "Kobold Camp Cleanup"
"#;

// Step 2 takes an escort (309) beside a plain quest (7); step 3 escorts, step 4 hands it in; step 5 goes on. A second
// guide's step asks about the same escort itself (`when group 309`).
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/escort", pack = "test", title = "Escort", minLevel = 1, maxLevel = 30, steps = {
	{ title = "Start", goals = { { t = "goto", map = 1429, x = 48, y = 42, text = "Start" } } },
	{ title = "Miran", goals = {
		{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		{ t = "accept", quest = 309, title = "Protecting the Shipment", npc = 1379, npcName = "Miran", map = 1429, x = 49, y = 41.5, escort = true, escortSecs = 718, escortFail = 0.33 },
	} },
	{ title = "The walk", goals = { { t = "complete", quest = 309, title = "Protecting the Shipment", map = 1429, x = 55, y = 45, escort = true } } },
	{ title = "Hand in", goals = { { t = "turnin", quest = 309, title = "Protecting the Shipment", npc = 1379, npcName = "Miran", map = 1429, x = 56, y = 46 } } },
	{ title = "Kobolds", goals = { { t = "kill", npc = 6, target = "Kobold Vermin", count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
} })
Polestar.RegisterGuide({ id = "test/asked", pack = "test", title = "Asked", minLevel = 1, maxLevel = 30, steps = {
	{ title = "Miran", when = { { k = "group", q = 309 } }, goals = {
		{ t = "accept", quest = 309, title = "Protecting the Shipment", npc = 1379, npcName = "Miran", map = 1429, x = 49, y = 41.5, escort = true },
	} },
} })
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function status(s) return E.GetStepView(s).goals[#E.GetStepView(s).goals].status end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".to_string(), r#"PolestarDB = { schema = 1, settings = { behavior = { autoAccept = false } } }; PolestarCharDB = { schema = 1, guide = "test/escort" }"#.to_string())],
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

const AT_MIRAN: &str = r#"E.SkipUpTo(2); flush()"#;

#[test]
fn an_escort_asks_at_its_accept_with_players_time_and_failures_and_waits_for_the_answer() {
	let out = run(&format!(
		r#"{AT_MIRAN}
		local q, title, info = E.GroupQuestion()
		emit({{ live = E.GetLiveStep(), q = q or false, title = title or false, info = info or false }})"#
	));
	assert_eq!(out["live"], 2, "{out}");
	assert_eq!(out["q"], 309);
	assert_eq!(out["title"], "Protecting the Shipment");
	assert_eq!(out["info"], json!({ "escort": true, "text": "Escort, about 12 min; 1 in 3 runs fails. Optional: the route doesn't need it." }));
}

#[test]
fn skipped_the_escort_leaves_the_route_with_its_work_and_hand_in_and_the_answer_is_kept_and_listed() {
	let out = run(&format!(
		r#"{AT_MIRAN}
		E.AnswerGroup(309, "skip"); flush()
		local listed
		for _, gq in ipairs(E.GroupQuests()) do if gq.quest == 309 then listed = gq end end
		emit({{ live = E.GetLiveStep(), question = E.GroupQuestion() or false, accept = E.GetStepView(2).goals[2].status, other = E.GetStepView(2).goals[1].status,
			walk = status(3), handin = status(4), kept = Polestar.CharState().groupQuests[309], listed = listed or false }})"#
	));
	assert_eq!(out["question"], false, "{out}");
	assert_eq!(out["live"], 2, "Kobold Camp Cleanup is still to take: {out}");
	assert_ne!(out["other"], "na", "the plain quest beside it stays: {out}");
	for k in ["accept", "walk", "handin"] {
		assert_eq!(out[k], "na", "{k}: {out}");
	}
	assert_eq!(out["kept"], "skip");
	assert_eq!(out["listed"], json!({ "quest": 309, "title": "Protecting the Shipment", "escort": true }));
}

#[test]
fn done_the_escort_is_the_route_s_as_any_quest() {
	let out = run(&format!(
		r#"{AT_MIRAN}
		E.AnswerGroup(309, "do"); flush()
		emit({{ question = E.GroupQuestion() or false, accept = E.GetStepView(2).goals[2].status, walk = status(3), handin = status(4) }})"#
	));
	assert_eq!(out["question"], false, "{out}");
	for k in ["accept", "walk", "handin"] {
		assert_ne!(out[k], "na", "{k}: {out}");
	}
}

#[test]
fn a_step_that_asks_about_the_escort_itself_keeps_the_author_s_choice() {
	let out = run(r#"
		E.SetGuide("test/asked"); flush()
		local q, _, info = E.GroupQuestion()
		emit({ q = q or false, info = info or false, note = E.EscortNote(309) or false })"#);
	assert_eq!(out, json!({ "q": 309, "info": false, "note": false }), "the `when group` question, a group quest's words");
}
