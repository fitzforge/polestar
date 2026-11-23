//! A walk's waypoint named only by its zone (#1334; addon/Polestar/Core/Engine.lua, Own.onThroughZone): the
//! guide writer labels points on the way through a zone with the zone's name ("Go to Mulgore"), which reads as
//! done to a player already standing in that zone. There it reads "On through <zone> to <next step's title>",
//! past further walks through the same zone; anywhere else, and for a goto named otherwise, as before. Display
//! only: the goto is done on reaching its point, as before.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1412, { name = "Mulgore", c = 1, left = 3000, right = -1000, top = -3000, bottom = -6000 })
w.addMap(1413, { name = "The Barrens", c = 1, left = 7000, right = 3000, top = -3000, bottom = -6000 })
w.moveTo(1413, 44, 59)
w.setZone("The Barrens", "Camp Taurajo")
"#;

// 0.3.5's Ashenvale for an Orc Hunter (#1334): off the flight at Camp Taurajo, two walks named "Mulgore" lead up
// to Skywatcher Plateau, then the Earthen Ring's quests.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/earthen-ring", pack = "test", title = "Ashenvale", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Mulgore", goals = { { t = "goto", map = 1412, x = 40.6, y = 22.2, text = "Mulgore" } } },
	{ title = "Mulgore", goals = { { t = "goto", map = 1412, x = 30.5, y = 8.2, text = "Mulgore" } } },
	{ title = "The Earthen Ring", goals = { { t = "accept", quest = 96260, title = "Stronger than Steel", npc = 264072, map = 1412, x = 32.5, y = 20.0 } } },
} })
Polestar.RegisterGuide({ id = "test/named-goto", pack = "test", title = "Mulgore", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Thunder Bluff", goals = { { t = "goto", map = 1412, x = 40.0, y = 30.0, text = "North of Thunder Bluff" } } },
	{ title = "The Earthen Ring", goals = { { t = "accept", quest = 96260, title = "Stronger than Steel", npc = 264072, map = 1412, x = 32.5, y = 20.0 } } },
} })
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			"{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\nE = Polestar.Engine\nfunction flush() stub.advance(0.25) end\nstub.login()\nstub.fire(\"QUEST_LOG_UPDATE\")\n\
			 local function at() local wp = E.GetWaypoint(); local v = E.GetStepView(E.GetStepIndex()); return {{ E.GetStepIndex(), v.goals[1].text, wp and wp.label or false }} end\n{script}"
		),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_walk_named_by_its_zone_reads_on_through_it_to_the_next_step_while_the_player_is_in_that_zone() {
	let out = run(r#"
		E.SetGuide("test/earthen-ring"); flush()
		local r = { barrens = at() }
		-- Into Mulgore, at Stonebull Lake: the walk leads on, not to the zone the player is in.
		stub.world.moveTo(1412, 52.0, 60.7); stub.world.setZone("Mulgore", "Stonebull Lake"); flush()
		r.mulgore = at()
		-- Arrived at the first point: done as before, the second walk reads the same.
		stub.world.moveTo(1412, 40.6, 22.2); stub.advance(1)
		r.second = at()
		emit(r)
	"#);
	assert_eq!(
		out,
		json!({
			// Still in the Barrens: the zone is where the walk goes.
			"barrens": [1, "Go to Mulgore", "Go to Mulgore"],
			// In Mulgore: on through it to the Earthen Ring, past the second walk through Mulgore.
			"mulgore": [1, "On through Mulgore to The Earthen Ring", "On through Mulgore to The Earthen Ring"],
			"second": [2, "On through Mulgore to The Earthen Ring", "On through Mulgore to The Earthen Ring"],
		})
	);
}

#[test]
fn a_goto_named_otherwise_reads_as_written_in_its_zone() {
	let out = run(r#"
		E.SetGuide("test/named-goto"); flush()
		stub.world.moveTo(1412, 50, 50); stub.world.setZone("Mulgore", "Bloodhoof Village"); flush()
		emit(at())
	"#);
	assert_eq!(out, json!([1, "Go to North of Thunder Bluff", "Go to North of Thunder Bluff"]));
}
