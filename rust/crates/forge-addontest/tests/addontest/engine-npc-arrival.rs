//! Where the arrow says Arrived at a goal done with one NPC (accept, turn in, train, talk), with no height from the
//! client (Forever's UnitPosition gives 0). Since 0.4.1 the compiler gives such a goal the NPC's spawn records as a
//! spot when the data has several (Marshal McBride: three records spread over 29 yd in Northshire Abbey, packed as
//! one spot of radius 19 at their middle). The arrow took that spot for a spawn area, as for a kill: it led to the
//! records' middle and said Arrived anywhere within the area plus the goal's 8 yd, up to 27 yd from the NPC. Fitz on
//! the 0.4.2.1 candidate: "the arrow says it's 'here' when I'm like 10 yards away from an NPC". The NPC goal is
//! reached within its radius of the route's own point for it again, as in 0.4.0; a kill keeps its spawn area. Real
//! Core and Nav manifests, stub world: Tirisfal here is 30 yd per map percent across (x) and 20 yd per percent down (y).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 1500, right = -1500, top = 2500, bottom = 500 })
w.race, w.raceName, w.faction, w.class, w.className = "Scourge", "Undead", "Horde", "ROGUE", "Rogue"
w.level = 10
w.moveTo(1420, 50, 30)
"#;

// The NPC's point (50, 50), the route's pick among his records; their spot's middle 15 yd east of it (x 50.5),
// radius 19, three records. The kill's spot is the same: its mobs are found anywhere in it.
const GUIDES: &str = r#"
Polestar.RegisterGuide({ id = "test/npc", pack = "test", title = "NPC", category = "Leveling", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1420, x = 50, y = 50,
		spotsPacked = "50.5,50,,19,3" } } },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/kill", pack = "test", title = "Kill", category = "Leveling", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "kill", target = "Mindless Zombie", npc = 1501, npcName = "Mindless Zombie", count = 8, map = 1420, x = 50, y = 50,
		spotsPacked = "50.5,50,,19,3" } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

// The client's UnitPosition: a height of exactly 0, as Forever's.
const HELPERS: &str = r#"
E, Nav, w = Polestar.Engine, Polestar.Nav, stub.world
function UnitPosition(unit)
	if unit ~= "player" then return nil end
	local c, pos = C_Map.GetWorldPosFromMapPos(w.map, CreateVector2D(w.x / 100, w.y / 100))
	if not pos then return nil end
	return pos.x, pos.y, 0, c
end
-- The arrow's state with the player at (x, y), after a second of polls (each approach starts from 30 yd off).
function at(x, y)
	w.moveTo(1420, 50, 30)
	stub.advance(1)
	Nav.Sample()
	w.moveTo(1420, x, y)
	stub.advance(1)
	return (Nav.Sample())
end
"#;

fn run(guide: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml"])],
		script: [TEST_PACK, TEST_SOURCE, GUIDES, HELPERS, "stub.login()", &format!(r#"E.SetGuide("{guide}"); stub.advance(0.5)"#), script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn with_no_height_an_npc_goal_whose_spawn_records_spread_is_arrived_at_within_its_radius_of_the_npc_not_10_yd_away() {
	let out = run(
		"test/npc",
		r#"
		local t = Nav.GetTarget()
		local r = { x = t.x, y = t.y, area = t.area or false }
		r.ten = at(50, 50.5)    -- 10 yd south of him; 18 yd from his records' middle, inside its 19
		r.four = at(50, 50.2)   -- 4 yd: talking distance
		r.twelve = at(50.4, 50) -- 12 yd east, toward the records' middle
		emit(r)"#,
	);
	assert_eq!(out, json!({ "x": 50, "y": 50, "area": false, "ten": "travel", "four": "arrived", "twelve": "travel" }), "{out}");
}

#[test]
fn with_no_height_a_kill_goal_keeps_its_spawn_area_and_is_reached_anywhere_in_it() {
	let out = run(
		"test/kill",
		r#"
		local t = Nav.GetTarget()
		emit({ guide = E.GetGuide().id, x = t.x, area = t.area or false, inside = at(50, 50.5) })"#,
	);
	assert_eq!(out, json!({ "guide": "test/kill", "x": 50.5, "area": 19, "inside": "arrived" }), "{out}");
}
