//! The way back from death on the real addon (Core, Nav, QoL together, stub world): as a ghost the arrow stays on
//! the corpse whatever the guide does (a step change, the next goal, a goal reached) and whatever else points it
//! (a goal clicked in the guide window, /way), until the character is alive again; then the guide's target shows
//! (#1382: "the guide step overwrote my 'Run to corpse' step").

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 1415, left = 1535.4166, right = -1941.6666, top = 1300.0, bottom = -1060.4166 })
w.moveTo(1429, 40, 60)
dead, ghost, corpseAt = false, false, nil
function UnitIsDeadOrGhost(unit) return unit == "player" and (dead or ghost) end
function UnitIsGhost(unit) return unit == "player" and ghost end
function UnitIsDead(unit) return unit == "player" and dead end
C_DeathInfo = { GetCorpseMapPosition = function(map)
	if not corpseAt or map ~= 1429 then return nil end
	return { x = corpseAt[1] / 100, y = corpseAt[2] / 100 }
end }
"#;

const GUIDE: &str = r#"
Polestar.RegisterGuide({
	id = "test/ghost", pack = "test", title = "Ghost", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Camp", goals = {
			{ t = "goto", map = 1429, x = 45, y = 45, r = 10, label = "Camp" },
			{ t = "accept", quest = 7001, title = "Q1", npc = 1, npcName = "Giver", map = 1429, x = 50, y = 50 },
		} },
		{ title = "Next", goals = {
			{ t = "accept", quest = 7002, title = "Q2", npc = 2, npcName = "Other", map = 1429, x = 70, y = 70 },
		} },
	},
})
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.into(),
		addons: vec![Addon::name("Polestar")],
		saved: vec![("Polestar".into(), r#"PolestarCharDB = { schema = 1, guide = "test/ghost" }"#.into())],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{GUIDE}
E, Nav = Polestar.Engine, Polestar.Nav
-- Every new target the arrow took (the Engine announces its own waypoints too, under the corpse: not counted).
shown, last = {{}}, nil
Polestar.On("WAYPOINT_CHANGED", function()
	local t = Nav.GetTarget()
	if t ~= last then last = t; shown[#shown + 1] = t and t.label or false end
end)
function flush() stub.advance(1.1) end
-- The arrow's target now, and every target it took since the last look (false: none).
function look()
	local t = Nav.GetTarget()
	local seen = shown
	shown = {{}}
	return {{ step = E.GetStepIndex(), target = t and t.label or false, shown = #seen > 0 and seen or false }}
end
stub.login(); stub.fire("QUEST_LOG_UPDATE"); flush()
{script}"#
		),
		..Default::default()
	})
}

#[test]
fn a_ghost_s_arrow_stays_on_the_corpse_through_step_changes_goals_and_picked_points_until_alive_1382() {
	let out = run(r#"
		look()
		corpseAt = { 46, 46 }
		dead = true; stub.fire("PLAYER_DEAD"); flush()
		dead, ghost = false, true; stub.world.moveTo(1429, 30, 70); stub.fire("PLAYER_ALIVE"); flush()
		emit(look())
		-- The guide moves on (a step clicked, a quest shared or done): not even for a frame.
		E.Next(); stub.advance(0)
		emit(look())
		flush()
		-- Back on the first step, the ghost walks through its Go to.
		E.Prev(); stub.world.moveTo(1429, 45, 45); stub.fire("ZONE_CHANGED"); flush()
		emit(look())
		-- Points picked as a ghost: a goal in the guide window, /way.
		Nav.SetTarget(1429, 50, 50, "Giver")
		Polestar.RunCommand("way 20 20 Somewhere"); stub.advance(0)
		emit(look())
		flush()
		emit(look())
		-- Alive at the corpse: the last point picked on this step shows.
		ghost, corpseAt = false, nil; stub.fire("PLAYER_UNGHOST"); flush()
		emit(look())
	"#);
	assert_eq!(out[0], json!({ "step": 1, "target": "Your corpse", "shown": ["Your corpse"] }), "released: the arrow on the corpse");
	assert_eq!(out[1], json!({ "step": 2, "target": "Your corpse", "shown": false }), "a step change leaves it there");
	assert_eq!(out[2], json!({ "step": 1, "target": "Your corpse", "shown": false }), "so do the guide's goals");
	assert_eq!(out[3], json!({ "step": 1, "target": "Your corpse", "shown": false }), "and points picked as a ghost");
	assert_eq!(out[4], json!({ "step": 1, "target": "Your corpse", "shown": false }), "and the death helper's tick");
	assert_eq!(out[5]["target"], "Somewhere", "alive: the point picked on this step, {}", out[5]);
}

#[test]
fn a_ghost_s_arrow_once_alive_after_a_step_change_is_the_new_step_s_not_a_point_picked_before_dying_1382() {
	let out = run(r#"
		Nav.SetTarget(1429, 20, 20, "Picked")
		corpseAt = { 46, 46 }
		dead = true; stub.fire("PLAYER_DEAD"); flush()
		dead, ghost = false, true; stub.fire("PLAYER_ALIVE"); flush()
		emit(look().target)
		E.Next(); flush()
		emit(look().target)
		ghost, corpseAt = false, nil; stub.fire("PLAYER_UNGHOST"); flush()
		emit(look().target)
	"#);
	assert_eq!(out, vec![json!("Your corpse"), json!("Your corpse"), json!("Accept “Q2”")]);
}

// #2106 (Agentringmuskel, the basement under Shadowvale's ruined house): the way back led over the hill above the
// basement, where the corpse lay below ground: the corpse point carried no floor. The floor the character died on
// (Walk.Floor: the client's height here, else the floor the arrow followed) goes with the corpse, so the walk ends
// on it; a corpse the client places away from where the character died gets none.
#[test]
fn the_way_back_to_a_corpse_below_ground_carries_the_floor_the_character_died_on_2106() {
	let out = run(r#"
		zNow = -42.5
		function UnitPosition(unit) if unit == "player" and zNow then return 0, 0, zNow, 1415 end end
		corpseAt = { 40, 60 } -- where the character stands
		dead = true; stub.fire("PLAYER_DEAD"); flush()
		zNow = 31.0
		dead, ghost = false, true; stub.world.moveTo(1429, 30, 70); stub.fire("PLAYER_ALIVE"); flush()
		local t = Nav.GetTarget()
		emit({ label = t and t.label or false, z = t and t.z or false })
		ghost, corpseAt = false, nil; stub.fire("PLAYER_UNGHOST"); flush()
		zNow = -42.5
		corpseAt = { 46, 46 } -- placed far from where it died
		dead = true; stub.fire("PLAYER_DEAD"); flush()
		dead, ghost = false, true; stub.fire("PLAYER_ALIVE"); flush()
		t = Nav.GetTarget()
		emit({ label = t and t.label or false, z = t and t.z or false })
	"#);
	assert_eq!(out[0], json!({ "label": "Your corpse", "z": -42.5 }), "the floor it died on");
	assert_eq!(out[1], json!({ "label": "Your corpse", "z": false }), "a corpse away from the death spot: no floor");
}

// A corpse where the character died is held with the height of the floor they died on (Walk.Floor when they died),
// so the walk back ends on it: a corpse in a cave, not the ground above it (the Fargodeep Mine, the troll cave in
// Coldridge). A corpse farther than 10 yd from where they died, or a floor not known then, holds no height, as before;
// once alive the next death starts afresh.
#[test]
fn the_way_back_to_a_corpse_ends_on_the_floor_the_character_died_on() {
	let out = run(r#"
		local floor = 12
		Nav.walk.Floor = function() return floor end
		local function die(at, corpse)
			stub.world.moveTo(1429, at[1], at[2])
			corpseAt = corpse
			dead = true; stub.fire("PLAYER_DEAD"); flush()
			dead, ghost = false, true; stub.world.moveTo(1429, 30, 70); stub.fire("PLAYER_ALIVE"); flush()
			local _, _, _, z = Nav.GetTargetWorld()
			local t = Nav.GetTarget()
			ghost, corpseAt = false, nil; stub.fire("PLAYER_UNGHOST"); flush()
			return { target = t and t.label or false, z = z or false }
		end
		local r = {}
		r.cave = die({ 46, 46 }, { 46, 46 })            -- died in the cave, the corpse there
		r.moved = die({ 46, 46 }, { 50, 50 })           -- the corpse ~150 yd from where they died
		floor = nil
		r.unknown = die({ 46, 46 }, { 46, 46 })         -- the floor not known when they died
		emit(r)"#);
	assert_eq!(out[0]["cave"], json!({ "target": "Your corpse", "z": 12 }), "{}", out[0]);
	assert_eq!(out[0]["moved"], json!({ "target": "Your corpse", "z": false }), "{}", out[0]);
	assert_eq!(out[0]["unknown"], json!({ "target": "Your corpse", "z": false }), "{}", out[0]);
}
