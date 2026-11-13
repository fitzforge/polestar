//! Exact points (#1944; docs/ARCHITECTURE.md, "Spawn areas"): a goal whose spawn spots are all exact points
//! (radius 0: an object's spawns, a mob at a few fixed places; the compiler's) is searched point by point. The
//! arrow leads to the nearest point the player has not checked; coming within the arrival radius (8 yd)
//! checks a point and moves the arrow on at once to the nearest unchecked one, never to the other places
//! the target spawns (`alt`); with every point checked, to the one checked longest ago. Real Core manifest,
//! stub world; Elwynn here is 30 yd per map percent across.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 30, 50)
"#;

const HELPERS: &str = r#"
E = Polestar.Engine
w = stub.world
-- Stand at map x (y 50) for a second of arrival polls: the waypoint's x.
function at(x) w.moveTo(1429, x, 50); stub.advance(1); return E.GetWaypoint().x end
"#;

// Four Sprung Traps along a road (x 40, 46 and 52, 180 yd apart, and 70), and one far off it, another place
// they spawn; packed as the compiler writes them.
const TRAPS: &str = r#"
Polestar.RegisterGuide({ id = "test/traps", pack = "test", title = "Traps", zone = 1429, steps = {
	{ title = "The Dry Hills", goals = {
		{ t = "collect", item = 269719, itemName = "Trapped Game", count = 8, map = 1429, x = 40, y = 50,
			spotsPacked = "40,50,,0;46,50,,0;52,50,,0;70,50,,0;90,10,,0,,1", from = "Sprung Trap", fromKind = "object", fromId = 640104 },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: [TEST_PACK, TEST_SOURCE, TRAPS, HELPERS, "stub.login()", script].join("\n"),
		login: false,
		..Default::default()
	})
	.remove(0)
}

#[test]
fn the_arrow_leads_to_the_nearest_unchecked_point_and_moves_on_once_the_player_has_been_there_1944() {
	let out = run(r#"
		E.SetGuide("test/traps"); stub.advance(0.25)
		local goal = Polestar.Guides.Get("test/traps").steps[1].goals[1]
		local r = { start = at(30) }
		r.reached = at(39.9)     -- 3 yd from the first trap: checked, on to the next at once
		r.road = at(43)          -- between the first two: the unchecked one
		r.second = at(46)
		r.back = at(41)          -- back by the first: still the third, never a checked one
		r.checked = { E.SpotChecked(goal.spots[1]), E.SpotChecked(goal.spots[2]), E.SpotChecked(goal.spots[3]) }
		r.third = at(52)         -- on to 70, not to the other place they spawn (90, 10)
		r.fourth = at(70)        -- every trap checked: the one checked longest ago
		local wp = E.GetWaypoint()
		r.wp = { wp.search, wp.exact, #wp.spots, wp.area }
		r.view = { E.GetStepView(1).goals[1].exact, E.GetStepView(1).goals[1].spots }
		r.exact = E.SpotsExact(goal)
		emit(r)"#);
	assert_eq!(
		out,
		json!({
			"start": 40, "reached": 46, "road": 46, "second": 52, "back": 52,
			"checked": [true, true, false],
			"third": 70, "fourth": 40,
			"wp": [true, true, 5, 0],
			"view": [true, 5],
			"exact": true,
		})
	);
}

#[test]
fn a_point_picked_by_hand_holds_until_reached_then_the_arrow_moves_on() {
	let out = run(r#"
		E.SetGuide("test/traps"); stub.advance(0.25)
		local r = { start = at(30) }
		r.picked = E.CycleSpot(1, 1, 3)        -- the third trap, by hand (a click on its mark)
		r.held = at(31)                        -- the first is nearer: the pick holds
		r.reached = at(52)                     -- there: checked, on to the nearest unchecked
		emit(r)"#);
	assert_eq!(out, json!({ "start": 40, "picked": 3, "held": 52, "reached": 46 }));
}
