//! The arrow cycles a step's places by itself (Fitz, 2026-11-09: "have the arrow automatically cycle different
//! area waypoints within a step without having to click on it each time"): a camp, searched spot or field goal
//! the player has stood at for Spots.DWELL seconds, out of combat and with no progress, is left, and the arrow moves
//! on to the nearest place not left (Engine.lua, Spots "Dwell", Own.dwelt). Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

// Elwynn here: 30 yd per map percent across (x), 20 down (y).
const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.race, w.faction, w.class, w.className, w.level = "Human", "Alliance", "WARRIOR", "Warrior", 10
"#;

// test/camps: three kobold camps along y = 50 (radius 30), A at 40, B at 60, C at 15. test/crates: an object
// searched spot by spot (`spread`), crates at 30, 50 and 75. test/fields: two field goals at points, wolves at 40
// and boars at 70. test/overlap: three field goals, wolves at 40 and boars at 41 (the same ground), workers at 80.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/camps", pack = "test", title = "camps", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = {
	{ title = "Kobolds", goals = {
		{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 40, y = 50,
			spots = { { x = 40, y = 50, r = 30, n = 5 }, { x = 60, y = 50, r = 30, n = 4 }, { x = 15, y = 50, r = 30, n = 3 } } },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/crates", pack = "test", title = "crates", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = {
	{ title = "Crates", goals = {
		{ t = "interact", object = 31, objName = "Supply Crate", quest = 8, oi = 1, count = 3, map = 1429, x = 30, y = 50, spread = true,
			spots = { { x = 30, y = 50, r = 30, n = 2 }, { x = 50, y = 50, r = 30, n = 2 }, { x = 75, y = 50, r = 30, n = 1 } } },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/fields", pack = "test", title = "fields", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = {
	{ title = "Wolves and boars", goals = {
		{ t = "kill", target = "Timber Wolf", npc = 69, count = 6, quest = 9, oi = 1, map = 1429, x = 40, y = 50 },
		{ t = "kill", target = "Young Boar", npc = 113, count = 6, quest = 9, oi = 2, map = 1429, x = 70, y = 50 },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
Polestar.RegisterGuide({ id = "test/overlap", pack = "test", title = "overlap", faction = "Alliance", minLevel = 1, maxLevel = 20, zone = 1429, steps = {
	{ title = "Three kinds", goals = {
		{ t = "kill", target = "Timber Wolf", npc = 69, count = 1, quest = 10, oi = 1, map = 1429, x = 40, y = 50 },
		{ t = "kill", target = "Young Boar", npc = 113, count = 1, quest = 10, oi = 2, map = 1429, x = 41, y = 50 },
		{ t = "kill", target = "Kobold Worker", npc = 257, count = 1, quest = 10, oi = 3, map = 1429, x = 80, y = 50 },
	} },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!(
			r#"{TEST_PACK}
{TEST_SOURCE}
{GUIDE}
E = Polestar.Engine
local w = stub.world
function at(x) w.moveTo(1429, x, 50) end
function wait(s) for _ = 1, s * 2 do stub.advance(0.5) end end
function arrow() local wp = E.GetWaypoint(); return wp and wp.x end
function goal() local wp = E.GetWaypoint(); return wp and wp.goalIndex end
stub.login()
Polestar.Set("behavior.autoAccept", false)
Polestar.Set("behavior.autoTurnin", false)
{script}"#
		),
		..Default::default()
	})
	.remove(0)
}

// (a) One goal with several camps: at a camp where nothing happens the arrow moves on after the dwell, to the
// nearest camp not left, never back to a left one while another is open, and with every camp left to the one left
// longest ago.
#[test]
fn a_camp_with_no_progress_for_the_dwell_hands_the_arrow_to_the_nearest_camp_not_left() {
	let out = run(
		"w.onQuest(7, { 10 }); w.moveTo(1429, 40, 50)",
		r#"
		E.SetGuide("test/camps"); stub.advance(0.25)
		local r = { start = arrow() }
		wait(5); r.at5 = arrow()
		wait(4); r.dwelt = arrow()                  -- A empty: on to B (C is farther)
		at(60); wait(9); r.atB = arrow()            -- B empty: on to C, not back to A
		at(15); wait(9); r.atC = arrow()            -- every camp left: the one left longest ago, A
		emit(r)
	"#,
	);
	assert_eq!(out, json!({ "start": 40, "at5": 40, "dwelt": 60, "atB": 15, "atC": 40 }));
}

// A camp being cleared keeps the arrow (ArrowGuard's replay: with the dwell alone, the drink or the walk to the
// next pull moved it off camps still worked): a kill there, or a fight up to 40 yd past its edge, holds it for
// FORGET (300 s); after that the dwell moves on as before.
#[test]
fn a_camp_worked_in_the_last_five_minutes_is_never_left_drinks_and_pulls_from_the_edge_included() {
	let out = run(
		"w.onQuest(7, { 10 }); w.moveTo(1429, 40, 50)",
		r#"
		E.SetGuide("test/camps"); stub.advance(0.25)
		local r = {}
		wait(3); w.progress(7, 1, 1)                -- a kill at A
		wait(60); r.drink = arrow()                 -- a minute's drink in the camp: still A
		at(42)                                      -- 30 yd past A's edge: a pull from there
		stub.inCombat = true; wait(5); stub.inCombat = false
		at(40); wait(200); r.later = arrow()        -- 200 s after the fight: still A
		wait(110); r.forgot = arrow()               -- 310 s after it, with the dwell: on to B
		emit(r)
	"#,
	);
	assert_eq!(out, json!({ "drink": 40, "later": 40, "forgot": 60 }));
}

#[test]
fn no_move_on_in_a_fight_nor_between_two_camps_and_a_spot_cycled_by_hand_holds_until_reached() {
	let out = run(
		"w.onQuest(7, { 10 }); w.moveTo(1429, 40, 50)",
		r#"
		E.SetGuide("test/camps"); stub.advance(0.25)
		local r = {}
		stub.inCombat = true
		wait(12); r.fight = arrow()                 -- fighting at A: the arrow stays
		stub.inCombat = false
		wait(12); r.after = arrow()                 -- a camp fought at is worked: it holds
		-- Between A and B (each edge 270 yd off): A, fought at, counts as visited off its ground, so B, and no
		-- flapping back.
		at(50)
		local seen = {}
		for i = 1, 20 do wait(1); seen[#seen + 1] = arrow() end
		r.between = table.concat(seen, ",")
		-- By hand to C from A: it holds while the player stands at A, past the dwell.
		at(40); stub.advance(1)
		E.CycleSpot(1, 1, 3)
		wait(12); r.cycled = arrow()
		emit(r)
	"#,
	);
	let between = vec!["60"; 20].join(",");
	assert_eq!(out, json!({ "fight": 40, "after": 40, "between": between, "cycled": 15 }));
}

// (b) An object searched spot by spot: before, the arrow stayed on the spot the player stood in until they walked
// out of it; now the dwell moves it on, to the nearest spot not visited.
#[test]
fn a_searched_object_spot_with_nothing_to_click_moves_the_arrow_on_after_the_dwell() {
	let out = run(
		"w.onQuest(8, { 3 }); w.moveTo(1429, 30, 50)",
		r#"
		E.SetGuide("test/crates"); stub.advance(0.25)
		local r = { start = arrow() }
		wait(5); r.at5 = arrow()
		wait(4); r.dwelt = arrow()
		emit(r)
	"#,
	);
	assert_eq!(out, json!({ "start": 30, "at5": 30, "dwelt": 50 }));
}

// (c) A step with field goals at different places: the goal the arrow is on, left after the dwell with nothing to
// show, gives way to the nearest other one.
#[test]
fn a_field_goal_left_after_the_dwell_gives_way_to_the_steps_nearest_other_field_goal() {
	let out = run(
		"w.onQuest(9, { 6, 6 }); w.moveTo(1429, 40, 50)",
		r#"
		E.SetGuide("test/fields"); stub.advance(0.25)
		local r = { start = goal() }
		wait(5); r.at5 = goal()
		wait(4); r.dwelt = goal()
		emit(r)
	"#,
	);
	assert_eq!(out, json!({ "start": 1, "at5": 1, "dwelt": 2 }));
}

// ArrowGuard's replay: work is kept by where it happened, not by goal. Fighting on ground the next goal shares
// (wolves done at 40, boars at 41) holds that goal too; moving on from an empty camp never picks a camp worked
// lately behind the player.
#[test]
fn ground_fought_on_holds_every_goal_there_and_moving_on_never_picks_a_camp_worked_behind() {
	let shared = run(
		"w.onQuest(10, { 1, 1, 1 }); w.moveTo(1429, 40, 50)",
		r#"
		E.SetGuide("test/overlap"); stub.advance(0.25)
		local r = { start = goal() }
		stub.inCombat = true; wait(5); stub.inCombat = false
		w.progress(10, 1, 1); stub.advance(0.5)     -- the wolf: on to the boars on the same ground
		r.next = goal()
		wait(10); r.held = goal()                   -- not left for the workers 1200 yd off
		emit(r)
	"#,
	);
	assert_eq!(shared, json!({ "start": 1, "next": 2, "held": 2 }));
	let behind = run(
		"w.onQuest(7, { 10 }); w.moveTo(1429, 40, 50)",
		r#"
		E.SetGuide("test/camps"); stub.advance(0.25)
		stub.inCombat = true; wait(5); stub.inCombat = false
		at(60); wait(2)                             -- on to B: the nearest camp now
		local r = { atB = arrow() }
		wait(9); r.fromB = arrow()                  -- B empty: C, not A (worked behind)
		emit(r)
	"#,
	);
	assert_eq!(behind, json!({ "atB": 60, "fromB": 15 }));
}

// ArrowGuard's grind sweep: running across a wide camp to its middle took the dwell's 7 s and the camp was left on
// arrival; then the player fought there for ten minutes with the arrow on the next camp. Walking on restarts the
// count (more than Spots.STILL yards), and a fight at a camp left already brings the arrow back to it.
#[test]
fn walking_into_a_camp_never_counts_and_a_fight_at_a_left_camp_brings_the_arrow_back() {
	let out = run(
		"w.onQuest(7, { 10 }); w.moveTo(1429, 41.2, 50)",
		r#"
		E.SetGuide("test/camps"); stub.advance(0.25)
		local r = {}
		-- From A's arrival radius (36 yd from its centre) to its middle at 4 yd/s: 9 s inside the radius.
		local x = 41.2
		while x > 40 do x = math.max(40, x - 0.0667); at(x); stub.advance(0.5) end
		r.walked = arrow()
		wait(5); r.stopped = arrow()                -- the count starts where the player stopped
		wait(3); r.dwelt = arrow()                  -- 8 s still: on to B
		stub.inCombat = true; wait(2)               -- a fight at A after all
		r.back = arrow()
		emit(r)
	"#,
	);
	assert_eq!(out, json!({ "walked": 40, "stopped": 40, "dwelt": 60, "back": 40 }));
}
