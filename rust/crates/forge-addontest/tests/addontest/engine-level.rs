//! A `level` goal inside a level (`level 3.5`, compiled to { level = 3, frac = 0.5 }) and a `when level`
//! predicate with `frac` (addon/Polestar/Core/Engine.lua): done at the goal's level once XP / XPMax reaches
//! frac, or at any later level; the window shows the share; a bad `frac` refuses the guide (Core/Guides.lua).
//! Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
"#;

// Step 1 reaches halfway through level 3; step 2 is for characters below level 4 and a quarter (`when`);
// step 3 reaches level 6.
const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/level", pack = "test", title = "Level", minLevel = 1, maxLevel = 6,
	steps = {
		{ title = "Half of 3", goals = { { t = "level", level = 3, frac = 0.5 } } },
		{ title = "Early", when = { { k = "level", op = "<", n = 4, frac = 0.25 } }, goals = { { t = "train", npc = 911, npcName = "Llane Beshere" } } },
		{ title = "Six", goals = { { t = "level", level = 6 } } },
	},
})
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
function flush() stub.advance(0.25) end
stub.login()
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
"#;

fn core() -> Addon {
	Addon::files("Polestar", &["Core/Core.xml"])
}

fn run(script: &str) -> Value {
	json!(emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/level" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, script].join("\n"),
		..Default::default()
	}))
}

#[test]
fn a_level_goal_with_frac_is_done_at_its_level_once_that_share_of_the_xp_is_reached() {
	let out = run(r#"
		w.setLevel(3); w.setXP(0, 1400); flush()
		emit({ live = E.GetLiveStep(), verb = E.GetStepView(1).goals[1].verb, subject = E.GetStepView(1).goals[1].subject })
		w.setXP(699); flush()
		emit(E.GetLiveStep())
		w.setXP(700); flush()
		emit(E.GetLiveStep())
	"#);
	assert_eq!(out, json!([{ "live": 1, "verb": "Reach level", "subject": "3 (50%)" }, 1, 2]));
}

#[test]
fn a_later_level_counts_whatever_its_xp_a_plain_level_goal_still_shows_the_bare_level() {
	let out = run(r#"
		w.setLevel(4); w.setXP(0, 2100); flush()
		emit({ live = E.GetLiveStep(), six = E.GetStepView(3).goals[1].subject })
	"#);
	// Level 4 with no XP: step 1 is done, and step 2 (below 4.25) applies.
	assert_eq!(out, json!([{ "live": 2, "six": "6" }]));
}

#[test]
fn xp_read_before_the_client_catches_up_with_a_level_up_does_not_count_toward_the_new_level() {
	// PLAYER_LEVEL_UP says 3 while UnitLevel still reads 2 at 90% of its XP.
	let out = run(r#"
		w.level = 2; w.setXP(810, 900); flush()
		stub.fire("PLAYER_LEVEL_UP", 3, 0, 0, 0, 0, 0, 0, 0, 0); flush()
		emit(E.GetLiveStep())
	"#);
	assert_eq!(out, json!([1]));
}

#[test]
fn a_when_level_predicate_with_frac_compares_the_level_plus_the_share_of_it_done() {
	let out = run(r#"
		w.setLevel(3); w.setXP(700, 1400); flush()
		emit({ live = E.GetLiveStep(), early = E.GetStepView(2).status })
		w.setLevel(4); w.setXP(100, 2100); flush()
		emit({ live = E.GetLiveStep(), early = E.GetStepView(2).status })
		w.setXP(600); flush()
		emit({ live = E.GetLiveStep(), early = E.GetStepView(2).status })
	"#);
	// 3.5 and 4 + 100/2100 = 4.05 are below 4.25: step 2 applies; at 4 + 600/2100 = 4.29 it no longer does.
	assert_eq!(out, json!([{ "live": 2, "early": "current" }, { "live": 2, "early": "current" }, { "live": 3, "early": "skipped" }]));
}

#[test]
fn a_guide_with_a_frac_outside_0_1_on_a_goal_or_a_when_level_is_refused() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![core()],
		script: r#"
local V = Polestar.Guides.Validate
local function goal(frac) return { id = "test/x", title = "X", steps = { { goals = { { t = "level", level = 12, frac = frac } } } } } end
local function when(frac) return { id = "test/x", title = "X", steps = { { when = { { k = "level", op = ">=", n = 12, frac = frac } }, goals = { { t = "level", level = 2 } } } } } end
emit({
	ok = V(goal(0.5)) or V(goal(0.01)) or V(goal(0.99)) or V(goal(nil)) or V(when(0.5)) or false,
	one = V(goal(1)), zero = V(goal(0)), over = V(goal(1.5)), text = V(goal("0.5")),
	whenOne = V(when(1)), whenZero = V(when(0)),
})
"#
		.into(),
		..Default::default()
	});
	assert_eq!(
		out[0],
		json!({
			"ok": false,
			"one": "step 1 goal 1: bad frac",
			"zero": "step 1 goal 1: bad frac",
			"over": "step 1 goal 1: bad frac",
			"text": "step 1 goal 1: bad frac",
			"whenOne": "step 1: bad when",
			"whenZero": "step 1: bad when",
		})
	);
}
