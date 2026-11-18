//! A goal on a ship's stop is walked to on the pier (addon/Polestar/Nav/Nav.lua, resolve): a guide's boat
//! step goes to where the ship lies in the water off its pier, and the walk to it ended in the sea, under
//! the pier. The dock's board point (TravelData's end board: on the deck, with its height) is the arrow's
//! world target instead, as the travel planner walks to a dock; a goal elsewhere, or with a height of its
//! own, is left as it is. Runs the real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

// The test map's boat with a board point on the pier: the ship stops at (-900, 0), boarded at (-890, 6) on the
// deck at height 4.5 (TravelData's transport end: name, c, wx, wy, map, x, y, f, area, board).
const SCRIPT_PRELUDE: &str = r#"
local N = Polestar.Nav
local nav = stub.nav
N.RegisterTravelData({
	build = "test",
	taxi = {},
	flights = {},
	transports = {
		{ id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
			a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95, "e", 1, { wx = -890, wy = 6, z = 4.5 } },
			b = { "Farland Pier", 1, 400, 0, 9001, 50, 10, "e", 2 } },
	},
	inns = {},
}, true)
local function world(wx, wy, z)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, "Boat to Farland", nil, nil, z)
	local c, tx, ty, tz = N.GetTargetWorld()
	return { c, math.floor(tx * 10 + 0.5) / 10, math.floor(ty * 10 + 0.5) / 10, tz or "none" }
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{SCRIPT_PRELUDE}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_goal_on_a_ships_stop_is_walked_to_on_the_pier_at_its_board_point_with_its_height() {
	let out = run(r#"
		emit({ onStop = world(-900, 0), nearStop = world(-895, 4) })
	"#);
	assert_eq!(out["onStop"], json!([0, -890, 6, 4.5]), "the ship's stop itself goes to the deck");
	assert_eq!(out["nearStop"], json!([0, -890, 6, 4.5]), "a guide point rounded a few yards off the stop too");
}

#[test]
fn a_goal_away_from_the_stop_or_with_its_own_height_or_at_a_dock_without_a_board_is_left_as_it_is() {
	let out = run(r#"
		emit({ away = world(-900, 40), ownZ = world(-900, 0, 7), farland = world(-500, -700) })
	"#);
	assert_eq!(out["away"], json!([0, -900, 40, "none"]), "40 yd off the stop is another place");
	assert_eq!(out["ownZ"], json!([0, -900, 0, 7]), "a goal with its height is where it says");
	assert_eq!(out["farland"], json!([0, -500, -700, "none"]), "a plain point on the map");
}
