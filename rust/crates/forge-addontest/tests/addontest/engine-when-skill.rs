//! `when skill` during play (addon/Polestar/Core/Engine.lua): the step applies while the character's rank in the
//! profession (Compat.GetSkillRank, by skill line, else by name) is N or more; one not learned is rank 0, so
//! `!skill X 1` is "has no X". A skill-up re-evaluates the guide (SKILL_LINES_CHANGED, CHAT_MSG_SKILL); a step
//! the route has passed keeps its stored outcome. Real Core manifest, stub world (a level 1 Human Warrior in
//! Elwynn Forest), as tests/engine-when-dungeon.rs.

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.onQuest(783, {})
"#;

// Step 2 is the conditional one, between taking and handing in A Threat Within: @WHEN@ is Lua for its
// predicates.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/skill", pack = "test", title = "Skill", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Trainer", when = @WHEN@, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
function flush() stub.advance(0.25) end
function state() local v = E.GetStepView(2); return { live = E.GetLiveStep(), status = v.status } end
"#;

const COOKING_50: &str = r#"{ { k = "skill", name = "Cooking", skillLine = 185, n = 50 } }"#;
const NO_HERBALISM: &str = r#"{ { k = "skill", name = "Herbalism", skillLine = 182, n = 1, neg = true } }"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(when: &str, login: &str, script: &str) -> Vec<Value> {
	let guide = GUIDE.replace("@WHEN@", when);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/skill" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", login, r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn when_skill_applies_at_the_rank_or_above_not_below_or_unlearned_skill_x_1_applies_while_x_is_not_learned() {
	assert_eq!(run(COOKING_50, "", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(run(COOKING_50, r#"stub.world.learnSkill(185, "Cooking", 49, 75)"#, "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(run(COOKING_50, r#"stub.world.learnSkill(185, "Cooking", 50, 75)"#, "emit(state())")[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(run(NO_HERBALISM, "", "emit(state())")[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(run(NO_HERBALISM, r#"stub.world.learnSkill(182, "Herbalism", 1, 75)"#, "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn without_a_skill_line_the_profession_is_read_by_its_name() {
	let view = &run(r#"{ { k = "skill", name = "Cooking", n = 50 } }"#, r#"stub.world.learnSkill(185, "Cooking", 60, 75)"#, "emit(state())")[0];
	assert_eq!(*view, json!({ "live": 2, "status": "current" }));
}

#[test]
fn a_skill_up_re_evaluates_the_guide_before_the_route_has_passed_the_step() {
	// Before the quest log is read nothing is stored, so step 2 is decided live.
	let out = run(COOKING_50, r#"stub.world.learnSkill(185, "Cooking", 49, 75); stub.advance(0.25); emit(state()); stub.world.skillUp(185, 50); stub.advance(0.25); emit(state())"#, "");
	assert_eq!(out[0], json!({ "live": 3, "status": "na" }));
	assert_eq!(out[1], json!({ "live": 2, "status": "current" }));
}

#[test]
fn a_step_the_route_has_passed_keeps_its_stored_outcome_when_the_rank_rises_later() {
	let out = run(COOKING_50, r#"stub.world.learnSkill(185, "Cooking", 1, 75)"#, "emit(state()); stub.world.skillUp(185, 50); flush(); emit(state())");
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn guides_validate_takes_a_skill_predicate_with_a_name_and_rank_and_refuses_one_without() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![core()],
		script: r#"
			local V = Polestar.Guides.Validate
			local function g(pred) return { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { { when = { pred }, goals = { { t = "note", text = "x" } } } } } end
			emit({
				ok = V(g({ k = "skill", name = "Cooking", skillLine = 185, n = 50 })) or "ok",
				byName = V(g({ k = "skill", name = "Cooking", n = 50 })) or "ok",
				noRank = V(g({ k = "skill", name = "Cooking" })) or "ok",
				noName = V(g({ k = "skill", skillLine = 185, n = 50 })) or "ok",
			})
		"#
		.into(),
		..Default::default()
	});
	let rows = &out[0];
	assert_eq!(rows["ok"], "ok");
	assert_eq!(rows["byName"], "ok");
	assert!(is_match(text(&rows["noRank"]), "bad when"));
	assert!(is_match(text(&rows["noName"]), "bad when"));
}
