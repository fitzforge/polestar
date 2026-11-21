//! Whether the guide has the character hearth before it sets a home (addon/Polestar/Core/Engine.lua,
//! Engine.HearthBeforeHome): the level 1 offer to delete the Hearthstone (QoL/Space.lua) waits on it. From the live
//! step on, the first `hearth` for this character before the first `sethome` it still has to do keeps the
//! Hearthstone. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest, bound at Northshire Abbey).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[7] = "Kobold Camp Cleanup"
"#;

// Each guide opens on a walk the player has not made, so the live step stays 1 and the scan reads every step after.
const GUIDES: &str = r#"
local WALK = { title = "Fargodeep Mine", goals = { { t = "goto", map = 1429, x = 39, y = 82 } } }
local HOME = { title = "Goldshire inn", goals = { { t = "sethome", location = "Goldshire", npc = 295, npcName = "Innkeeper Farley", map = 1429, x = 43.8, y = 65.8 } } }
local HEARTH = { title = "Back to the inn", goals = { { t = "hearth", location = "Goldshire" }, { t = "note", text = "Back to the inn." } } }
local MAGE_HEARTH = { title = "Mage trainer", goals = { { t = "hearth", location = "Goldshire", only = { classes = { "MAGE" } } }, { t = "goto", map = 1429, x = 43, y = 66 } } }
local function guide(id, steps)
	Polestar.RegisterGuide({ id = "test/" .. id, pack = "test", title = id, minLevel = 1, maxLevel = 10, steps = steps })
end
guide("home-first", { WALK, HOME, HEARTH })
guide("hearth-first", { WALK, HEARTH, HOME })
guide("neither", { WALK, { title = "Goldshire", goals = { { t = "goto", map = 1429, x = 42, y = 65 } } } })
guide("mage-hearth", { WALK, MAGE_HEARTH, HOME, HEARTH })
guide("no-home", { WALK, HEARTH })
local LATER = { { k = "level", op = ">=", n = 5 } }
local function later(step) local c = {}; for k, v in pairs(step) do c[k] = v end; c.when = LATER; return c end
guide("home-later", { WALK, later(HOME), HEARTH, HOME })
guide("hearth-later", { WALK, later(HEARTH), HOME })
guide("home-optional", { WALK, { title = "Goldshire inn", goals = { { t = "sethome", location = "Goldshire", optional = true }, { t = "goto", map = 1429, x = 43, y = 66 } } }, HEARTH })
guide("mage-step", { WALK, { title = "Mage trainer", only = { classes = { "MAGE" } }, goals = { { t = "hearth", location = "Goldshire" }, { t = "goto", map = 1429, x = 43, y = 66 } } }, HOME, HEARTH })
guide("behind", { { title = "Hearth", goals = { { t = "hearth", location = "Goldshire" } } }, WALK, HOME, HEARTH })
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/home-first" }"#.into())],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{GUIDES}
E = Polestar.Engine
w = stub.world
function flush() stub.advance(1.1) end
stub.login(); stub.fire("QUEST_LOG_UPDATE"); flush()
function first(id) E.SetGuide("test/" .. id); flush(); return E.HearthBeforeHome() end
{script}"#
		),
		..Default::default()
	})
}

#[test]
fn a_hearth_before_the_guide_s_first_sethome_keeps_the_hearthstone() {
	let out = run(r#"
		emit({ first("home-first"), first("hearth-first"), first("neither"), first("no-home") })
	"#);
	assert_eq!(out[0], json!([false, true, false, true]));
}

// A step whose `when` fails now may hold by the time the player gets there: its hearth keeps the Hearthstone, but its
// sethome brings no new one the player can count on.
#[test]
fn a_step_whose_when_fails_now_counts_its_hearth_but_not_its_sethome() {
	let out = run(r#"
		emit({ first("home-later"), first("hearth-later") })
	"#);
	assert_eq!(out[0], json!([true, true]));
}

#[test]
fn another_class_s_hearth_does_not_count() {
	let out = run(r#"
		emit(first("mage-hearth"))
		emit(first("mage-step"))
	"#);
	assert_eq!(out[0], false, "the Mage's hearth goal is not this Warrior's; the Goldshire sethome comes first");
	assert_eq!(out[1], false, "nor a hearth in a Mage's step");
}

// The scan starts at the live step: a hearth the route has passed (a hearth-only step is no step of its own) is behind
// the player.
#[test]
fn a_hearth_behind_the_live_step_does_not_count() {
	let out = run(r#"
		emit({ first = first("behind"), live = E.GetLiveStep() })
	"#);
	assert_eq!(out[0], json!({ "first": false, "live": 2 }));
}

#[test]
fn a_skipped_sethome_goal_does_not_count() {
	let out = run(r#"
		emit(first("home-optional"))
		emit({ skipped = E.SkipGoal(2, 1), first = E.HearthBeforeHome() })
	"#);
	assert_eq!(out[0], false);
	assert_eq!(out[1], json!({ "skipped": true, "first": true }));
}

#[test]
fn a_sethome_already_bound_there_does_not_bring_a_new_hearthstone() {
	let out = run(r#"
		emit(first("home-first"))
		w.bind("Goldshire"); flush()
		emit({ live = E.GetLiveStep(), first = E.HearthBeforeHome() }) -- bound there already: the hearth after it needs this Hearthstone
	"#);
	assert_eq!(out[0], false);
	assert_eq!(out[1], json!({ "live": 1, "first": true }));
}

#[test]
fn a_skipped_sethome_does_not_count() {
	let out = run(r#"
		E.SetGuide("test/home-first"); flush()
		E.Goto(2); flush()
		E.Skip(); flush()                         -- the sethome step skipped; the walk before it is still open
		emit({ live = E.GetLiveStep(), first = E.HearthBeforeHome() })
	"#);
	assert_eq!(out[0], json!({ "live": 1, "first": true }));
}
