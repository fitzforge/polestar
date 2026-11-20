//! A "Go to" with a height (a guide goto's `z`, on a floor above the ground) and what the client gives for the
//! player's height (UnitPosition's third value; Compat.GetPlayerUnitPosition, Nav.AllowGuideArrival). With a real
//! height the goto is reached only on its floor. With none to use (none at all, exactly 0, or the same height while
//! the player walks) it is reached as before heights were checked: within its radius on the map, and the arrow says
//! no floor. The debug log says once which it was. Real Core and Nav manifests, stub world: Tirisfal here is 30 yd
//! per map percent across (x) and 20 yd per percent down (y).

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 1500, right = -1500, top = 2500, bottom = 500 })
w.race, w.raceName, w.faction, w.class, w.className = "Scourge", "Undead", "Horde", "ROGUE", "Rogue"
w.level = 10
w.moveTo(1420, 50, 30)
"#;

// The goto's floor is at 110; the ground under it at 100.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/upstairs", pack = "test", title = "Upstairs", category = "Leveling", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "goto", map = 1420, x = 50, y = 50, z = 110, text = "Upstairs" } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

// The client's UnitPosition: H.z as the height ("real"), none ("none"), 0 ("zero") or H.z whatever the floor
// ("fixed": the caller leaves H.z alone).
const HELPERS: &str = r#"
E, Nav, w = Polestar.Engine, Polestar.Nav, stub.world
H = { mode = "real", z = 100 }
function UnitPosition(unit)
	if unit ~= "player" then return nil end
	local c, pos = C_Map.GetWorldPosFromMapPos(w.map, CreateVector2D(w.x / 100, w.y / 100))
	if not pos then return nil end
	local z = H.z
	if H.mode == "none" then z = nil elseif H.mode == "zero" then z = 0 end
	return pos.x, pos.y, z, c
end
-- Stand at (x, y) for a second of arrival polls; the step the guide is on.
function at(x, y) w.moveTo(1420, x, y); stub.advance(1); return E.GetStepIndex() end
-- The debug log's arrival lines, without the time.
function said()
	local out = {}
	for _, line in ipairs(Polestar.DebugLog()) do
		if line:find("Arrival: ", 1, true) then out[#out + 1] = line:sub(10) end
	end
	return out
end
"#;

const REAL: &str = "Arrival: the game gives the player's height: a point with a height is reached on its floor";

fn heightless(mode: &str) -> String {
	format!("Arrival: no player height from the game ({mode}): a point with a height is reached by map distance")
}

/// `pre` sets what the client gives before login (the arrow samples from then on).
fn run(pre: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Nav/Nav.xml"])],
		script: [TEST_PACK, TEST_SOURCE, GUIDE, HELPERS, pre, "stub.login()", r#"E.SetGuide("test/upstairs"); stub.advance(0.5)"#, script].join("\n"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn with_the_client_s_height_a_goto_on_a_raised_floor_is_reached_only_on_that_floor() {
	let out = run(
		"",
		r#"
		local r = { below = at(50, 50) }          -- right under it, on the ground (100)
		r.hint = Nav.FloorHint()
		H.z = 110                                 -- up the stairs
		r.onFloor = at(50, 50)
		r.said = said()
		emit(r)"#,
	);
	assert_eq!(out, json!({ "below": 1, "hint": "up", "onFloor": 2, "said": [REAL] }));
}

#[test]
fn with_no_height_from_the_client_a_goto_with_a_height_is_reached_within_its_radius_on_the_map() {
	let out = run(
		r#"H.mode = "none""#,
		r#"
		Nav.walk.Floor = function() return 100 end -- the floor Walk follows: the ground
		w.moveTo(1420, 50, 50.5)                     -- 10 yd short, near enough for a floor hint
		Nav.Sample()
		local r = { hint = Nav.FloorHint() or "none" }
		w.moveTo(1420, 50, 50.3)                     -- 6 yd: within the goto's 8
		r.arrow = Nav.Sample()
		r.there = at(50, 50.3)
		r.said = said()
		emit(r)"#,
	);
	assert_eq!(out, json!({ "hint": "none", "arrow": "arrived", "there": 2, "said": [heightless("none")] }));
}

#[test]
fn a_height_of_exactly_0_on_a_raised_floor_is_no_height_and_the_goto_is_reached_on_the_map() {
	let out = run(
		r#"H.mode = "zero""#,
		r#"
		local r = { there = at(50, 50.3) }
		r.mode = Polestar.Compat.PlayerHeight()
		r.said = said()
		emit(r)"#,
	);
	assert_eq!(out, json!({ "there": 2, "mode": "zero", "said": [heightless("zero")] }));
}

#[test]
fn a_height_that_stays_the_same_while_the_player_walks_is_no_height_once_forty_readings_5_yd_apart_agree() {
	let out = run(
		"H.z = 12 -- what the client says wherever the player is",
		r#"
		local r = { first = at(50, 50) }          -- taken for real (one reading on the move so far), and 98 yd off the floor
		r.firstMode = Polestar.Compat.PlayerHeight()
		-- Walk back 240 yd and up to the goto again, 6 yd (0.3 percent) a reading.
		local y = 38
		while y < 49.2 do                         -- the 2nd to the 39th
			w.moveTo(1420, 50, y)
			Polestar.Compat.GetPlayerUnitPosition()
			y = y + 0.3
		end
		r.short = Polestar.Compat.PlayerHeight()
		w.moveTo(1420, 50, 49.4)                  -- the 40th
		Polestar.Compat.GetPlayerUnitPosition()
		r.mode = Polestar.Compat.PlayerHeight()
		r.there = at(50, 50)
		-- A different height ends it.
		H.z = 13
		Polestar.Compat.GetPlayerUnitPosition()
		r.after = Polestar.Compat.PlayerHeight()
		r.said = said()
		emit(r)"#,
	);
	assert_eq!(
		out,
		json!({ "first": 1, "firstMode": "real", "short": "real", "mode": "fixed", "there": 2, "after": "real",
			"said": [REAL, heightless("fixed")] })
	);
}
