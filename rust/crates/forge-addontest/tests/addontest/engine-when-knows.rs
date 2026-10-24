//! `when knows` during play (addon/Polestar/Core/Engine.lua, Own.predicateHolds): the step applies while
//! the character knows the spell (Compat.IsSpellKnown, else Compat.IsPlayerSpell). Learning one
//! re-evaluates the guide (SPELLS_CHANGED), and a step the route has passed keeps its stored outcome.
//! Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest), as tests/engine-when-skill.rs.

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
	id = "test/knows", pack = "test", title = "Knows", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Train Charge", when = @WHEN@, goals = {
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

const KNOWS: &str = r#"{ { k = "knows", spell = 100 } }"#;
const NOT_KNOWN: &str = r#"{ { k = "knows", spell = 100, neg = true } }"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(when: &str, login: &str, script: &str) -> Vec<Value> {
	let guide = GUIDE.replace("@WHEN@", when);
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/knows" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, &guide, HELPERS, "stub.login()", login, r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn when_knows_applies_while_the_spell_is_known_bang_knows_while_it_is_not() {
	assert_eq!(run(KNOWS, "", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(run(KNOWS, "stub.world.spells[100] = true", "emit(state())")[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(run(NOT_KNOWN, "", "emit(state())")[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(run(NOT_KNOWN, "stub.world.spells[100] = true", "emit(state())")[0], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn a_spell_the_spellbook_check_does_not_list_but_is_player_spell_knows_counts() {
	// A weapon skill: Forever's spellbook check says no for it.
	let login = "C_SpellBook.IsSpellKnown = function() return false end; IsPlayerSpell = function(id) return id == 100 end";
	assert_eq!(run(KNOWS, login, "emit(state())")[0], json!({ "live": 2, "status": "current" }));
}

#[test]
fn learning_the_spell_re_evaluates_the_guide_before_the_route_has_passed_the_step() {
	// Before the quest log is read nothing is stored, so step 2 is decided live.
	let out = run(NOT_KNOWN, "flush(); emit(state()); stub.world.learnSpell(100); flush(); emit(state())", "");
	assert_eq!(out[0], json!({ "live": 2, "status": "current" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "na" }));
}

#[test]
fn a_step_the_route_has_passed_keeps_its_stored_outcome_when_the_spell_is_learned_later() {
	let out = run(KNOWS, "", "emit(state()); stub.world.learnSpell(100); flush(); emit(state())");
	assert_eq!(out[0], json!({ "live": 3, "status": "skipped" }));
	assert_eq!(out[1], json!({ "live": 3, "status": "skipped" }));
}

#[test]
fn guides_validate_takes_a_knows_predicate_with_a_spell_id_and_refuses_one_without() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		addons: vec![core()],
		script: r#"
			local V = Polestar.Guides.Validate
			local function g(pred) return { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { { when = { pred }, goals = { { t = "note", text = "x" } } } } } end
			emit({
				spell = V(g({ k = "knows", spell = 100, neg = true })) or "ok",
				none = V(g({ k = "knows" })) or "ok",
				name = V(g({ k = "knows", spell = "Charge" })) or "ok",
			})
		"#
		.into(),
		..Default::default()
	});
	let rows = &out[0];
	assert_eq!(rows["spell"], "ok");
	assert!(is_match(text(&rows["none"]), "bad when"));
	assert!(is_match(text(&rows["name"]), "bad when"));
}
