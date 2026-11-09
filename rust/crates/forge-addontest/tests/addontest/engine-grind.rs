//! Grind steps (`level N grind <npc>`): the compiler places the level goal at the mob's spawn areas, and the
//! arrow leads to the nearest of them instead of the step's goto, which leads only where the mob has no known
//! spawns. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// Stranglethorn Vale's Era frame (data/forever/map-frames.json): about 64 yd per map percent across, 43 down.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1434, { name = "Stranglethorn Vale", c = 0, left = 2220.833, right = -4160.417, top = -11168.75, bottom = -15422.916 })
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "Warrior", 34
w.moveTo(1434, 37.1, 28.3)
"#;

// Horde 30-40/03-stranglethorn-vale's "Level 35" as compiled: the goto to the raptors on the coast, then the level
// goal on the Lashtail Raptor (686) with its spawn areas (west by the coast, east by the road, north). The
// second guide has the same step for a mob without spawn data: the compiler gave the goal no place.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/stv", pack = "test", title = "Stranglethorn", faction = "Horde", minLevel = 30, maxLevel = 40, zone = 1434, steps = {
	{ title = "Level 35", goals = {
		{ t = "goto", map = 1434, x = 30.4, y = 23.6, text = "Lashtail Raptors" },
		{ t = "level", level = 35, grind = 686, npcName = "Lashtail Raptor", map = 1434, x = 30.6, y = 23.5, note = "grind on Lashtail Raptor",
			spots = { { x = 30.6, y = 23.5, r = 60, n = 6 }, { x = 37.9, y = 26.7, r = 50, n = 6 }, { x = 38.4, y = 20.4, r = 50, n = 6 } } },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/stv-nodata", pack = "test", title = "Stranglethorn", faction = "Horde", minLevel = 30, maxLevel = 40, zone = 1434, steps = {
	{ title = "Level 35", goals = {
		{ t = "goto", map = 1434, x = 30.4, y = 23.6, text = "Lashtail Raptors" },
		{ t = "level", level = 35, grind = 99999, note = "grind on a mob with no spawns" },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\nE = Polestar.Engine\nfunction flush() stub.advance(0.25) end\nstub.login()\nE.SetGuide(\"test/stv\")\nflush()\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// The report: a player at 37.1,28.3 stood 35 yd from Lashtail Raptors by the road while the arrow pointed 470 yd
// west at the step's goto. Now the arrow leads to the raptors' nearest spawn area, the window marks the level goal,
// and the goto is done with the level.
#[test]
fn a_grind_step_leads_to_the_nearest_spawn_area_of_its_mob_not_the_goto() {
	let out = run(r#"
		local w = stub.world
		local wp = E.GetWaypoint()
		local r = { goal = wp.goalIndex, kind = wp.kind, at = { wp.x, wp.y }, mark = E.GetStepView(1).current }
		-- Walked over to the coast, the west area is the nearest.
		w.moveTo(1434, 31, 24); stub.advance(1)
		wp = E.GetWaypoint()
		r.coast = { wp.goalIndex, wp.x, wp.y }
		-- Level 35: the step is done, its goto with it.
		w.setLevel(35); flush()
		r.step = E.GetStepIndex()
		emit(r)
	"#);
	assert_eq!(out["goal"], 2, "the level goal leads, not the goto");
	assert_eq!(out["kind"], "level");
	assert_eq!(out["at"], json!([37.9, 26.7]), "the raptors by the road, 35 yd off, not the coast 470 yd west");
	assert_eq!(out["mark"], 2);
	assert_eq!(out["coast"], json!([2, 30.6, 23.5]));
	assert_eq!(out["step"], 2, "level 35 done: on to the next step");
}

#[test]
fn a_grind_mob_without_spawn_data_keeps_the_steps_goto() {
	let out = run(r#"
		E.SetGuide("test/stv-nodata"); flush()
		local wp = E.GetWaypoint()
		emit({ goal = wp.goalIndex, kind = wp.kind, at = { wp.x, wp.y } })
	"#);
	assert_eq!(out, json!({ "goal": 1, "kind": "goto", "at": [30.4, 23.6] }));
}

// The dwell (Engine.lua, Spots "Dwell") on a grind: standing in a Lashtail camp with no XP coming in for the dwell
// moves the arrow to the nearest camp not left; XP from a kill starts the count again, and with the camps left
// in turn the arrow walks them as a loop.
#[test]
fn a_grind_camp_with_no_xp_for_the_dwell_hands_the_arrow_to_the_nearest_camp_not_left() {
	let out = run(r#"
		local w = stub.world
		local function wait(s) for _ = 1, s * 2 do stub.advance(0.5) end end
		local function arrow() local wp = E.GetWaypoint(); return { wp.goalIndex, wp.x, wp.y } end
		w.moveTo(1434, 37.9, 26.7); stub.advance(1)
		local r = { road = arrow() }
		wait(9); r.empty = arrow()                    -- the road camp empty: on to the north camp
		w.moveTo(1434, 38.4, 20.4); wait(5)
		w.setXP(5000, 70000)                          -- a kill there
		wait(5); r.killing = arrow()
		wait(4); r.dwelt = arrow()                    -- nothing more: the coast camp, not back to the road
		emit(r)
	"#);
	assert_eq!(out, json!({ "road": [2, 37.9, 26.7], "empty": [2, 38.4, 20.4], "killing": [2, 38.4, 20.4], "dwelt": [2, 30.6, 23.5] }));
}
