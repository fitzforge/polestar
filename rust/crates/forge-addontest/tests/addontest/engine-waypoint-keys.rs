//! The waypoint keys (addon/Polestar/Core/Engine.lua, Engine.CycleWaypoint; Bindings.xml): the arrow moves to
//! the next or previous open goal of the step that has a place, round the step, and a goal with spawn spots
//! moves on through its spots. Real Core manifest, stub world (a level 1 Human Warrior in Elwynn Forest).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/keys", pack = "test", title = "Keys", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Around Goldshire", goals = {
			{ t = "talk", npc = 1, npcName = "Smith Argus", map = 1429, x = 41.7, y = 65.5 },
			{ t = "note", text = "Mind the wolves" },
			{ t = "talk", npc = 2, npcName = "Innkeeper Farley", map = 1429, x = 43.8, y = 65.8 },
			{ t = "talk", npc = 3, npcName = "Remy", map = 1429, x = 42.1, y = 67.3 },
		} },
	},
})
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/keys" }"#.into())],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, "E = Polestar.Engine", "stub.login()", r#"stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)"#, script].join("\n"),
		..Default::default()
	})
}

#[test]
fn the_waypoint_keys_move_the_arrow_to_the_next_or_previous_located_goal_of_the_step_round_the_step() {
	let out = run(r#"
		local function at() local wp = E.GetWaypoint(); return wp and wp.goalIndex end
		local seen = { at() }
		Polestar.Bindings.NextWaypoint(); seen[#seen + 1] = at()
		Polestar.Bindings.NextWaypoint(); seen[#seen + 1] = at()
		Polestar.Bindings.NextWaypoint(); seen[#seen + 1] = at()
		Polestar.Bindings.PrevWaypoint(); seen[#seen + 1] = at()
		emit(seen)
	"#);
	assert_eq!(out[0], json!([1, 3, 4, 1, 4]), "the note has no place and is passed over; past the last goal it comes round");
}
