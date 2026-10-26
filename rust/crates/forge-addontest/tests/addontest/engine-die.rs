//! The `die` goal (addon/Polestar/Core/Engine.lua): a deathskip's step points at the graveyard's Spirit Healer
//! and is done once the player is back alive beside him (PLAYER_UNGHOST / PLAYER_ALIVE there), never by a
//! ghost standing there, never by a resurrection elsewhere. Real Core manifest, stub world (a level 5 Orc
//! Warrior in Durotar).

use forge_addontest::{emitted, is_match, text, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

const WORLD: &str = r#"
local w = stub.world
w.addMap(1411, { name = "Durotar", c = 1, left = -1962.5, right = -7250, top = 1808.333, bottom = -1716.667 })
w.moveTo(1411, 52, 68)
w.titles[840] = "Conscript of the Horde"
dead = false
function UnitIsDeadOrGhost(unit) return unit == "player" and dead end
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/die", pack = "test", title = "Die", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deathskip to Sen'jin Village", goals = {
			{ t = "die", location = "Sen'jin Village", map = 1411, x = 57.2, y = 73.3, f = "e" },
		} },
		{ title = "Razor Hill", goals = {
			{ t = "accept", quest = 840, title = "Conscript of the Horde", npc = 3336, npcName = "Takrin Pathseeker", map = 1411, x = 50.8, y = 43.6 },
		} },
	},
})
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/die" }"#.into())],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{GUIDE}
E = Polestar.Engine
function flush() stub.advance(1.1) end
function state() local g = E.GetStepView(1).goals[1]; return {{ step = E.GetStepIndex(), status = g.status, text = g.text, verb = g.verb }} end
stub.login(); stub.fire("QUEST_LOG_UPDATE"); flush()
{script}"#
		),
		..Default::default()
	})
}

#[test]
fn a_die_goal_is_open_with_its_place_holds_while_a_ghost_stands_at_the_healer_and_is_done_back_alive_beside_him() {
	let out = run(r#"
		emit(state())
		dead = true; stub.fire("PLAYER_DEAD"); stub.world.moveTo(1411, 57.2, 73.3); flush()
		emit(state())
		dead = false; stub.fire("PLAYER_UNGHOST"); flush()
		emit(state())
	"#);
	let (start, ghost, alive) = (&out[0], &out[1], &out[2]);
	assert_eq!(start["step"], 1);
	assert_ne!(start["status"], "done");
	assert!(is_match(&format!("{} {}", text(&start["verb"]), text(&start["text"])), "Sen'jin Village"));
	assert_eq!(ghost["step"], 1, "a ghost at the healer has not resurrected");
	assert_eq!(alive["step"], 2, "back alive beside the healer: the step is done");
}

#[test]
fn a_resurrection_elsewhere_leaves_the_die_goal_open() {
	let out = run(r#"
		dead = true; stub.fire("PLAYER_DEAD"); stub.world.moveTo(1411, 44.2, 69.4); flush()
		dead = false; stub.fire("PLAYER_UNGHOST"); flush()
		emit(state())
	"#);
	assert_eq!(out[0]["step"], 1);
}
