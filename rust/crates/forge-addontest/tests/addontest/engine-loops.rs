//! Farming loops (`loop <zone> …`, docs/GUIDE_FORMAT.md "Farming loops", #3661): a `skill` goal whose
//! candidates are loops picks one where the player is, with the farm spots' ranking (pickFor: travel seconds
//! plus the laps left times a lap; a loop whose creatures are 2+ levels above the player only when nothing
//! else is left), and walks that loop's stops as its spawn areas. Real Core manifest, stub world.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::Value;

// Elwynn Forest and Westfall side by side on Eastern Kingdoms (Westfall to the west), Durotar on Kalimdor.
const WORLD: &str = r#"
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1000, right = -1000, top = 0, bottom = -2000 })
w.addMap(1436, { name = "Westfall", c = 0, left = 3000, right = 1000, top = 0, bottom = -2000 })
w.addMap(1411, { name = "Durotar", c = 1, left = -3000, right = -5000, top = 1000, bottom = -1000 })
w.race, w.faction, w.class, w.className, w.level = "Human", "Alliance", "WARRIOR", "Warrior", 14
w.learnSkill(186, "Mining", 20, 75)
"#;

// Mining 1-65 with three loops: Elwynn Forest (creatures up to 6, two stops), Westfall (up to 15, three
// stops) and Durotar (up to 6, four stops), each 300 seconds a lap for 2 points.
const GUIDE: &str = r#"
Polestar.RegisterGuide({ id = "test/mining", pack = "test", title = "Mining", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Copper", goals = { { t = "skill", skill = "Mining", skillLine = 186, level = 65, map = 1429, x = 40, y = 40, spotsPacked = "40,40,,60;45,45,,60", spread = true, candidates = {
		{ map = 1429, x = 40, y = 40, faction = "AH", lvl = { 6, 6 }, lap = 300, gain = 2, spotsPacked = "40,40,,60;45,45,,60" },
		{ map = 1436, x = 50, y = 50, faction = "AH", lvl = { 15, 15 }, lap = 300, gain = 2, spotsPacked = "50,50,,60;55,55,,60;60,50,,60" },
		{ map = 1411, x = 50, y = 50, faction = "AH", lvl = { 6, 6 }, lap = 300, gain = 2, spotsPacked = "50,50,,60;52,52,,60;54,50,,60;52,48,,60" },
	} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
"#;

const SCRIPT: &str = r#"
	E = Polestar.Engine
	function flush() stub.advance(0.25) end
	function view()
		local v = E.GetStepView(1).goals[1]
		return { map = v.map or false, spots = v.spots or false, alts = v.alternatives or false, farm = v.farm or false }
	end
	stub.login()
	E.SetGuide("test/mining")
	flush()
"#;

fn run(before: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: format!("{WORLD}{before}"),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{GUIDE}\n{SCRIPT}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_human_at_mining_20_standing_in_westfall_gets_the_westfall_loop_and_walks_its_stops() {
	let out = run("w.moveTo(1436, 52, 52); w.setZone(\"Westfall\")", "emit(view())");
	assert_eq!(out["map"], 1436, "the loop where the player stands, not the first one (Elwynn Forest)");
	assert_eq!(out["spots"], 3, "the arrow walks the Westfall loop's three stops");
	assert_eq!(out["alts"], 2, "Elwynn Forest, and Durotar on the other continent, rank after it");
	let farm = &out["farm"];
	assert_eq!(farm["loop"], true);
	assert_eq!(farm["lap"], 5, "300 seconds a lap");
	assert_eq!(farm["laps"], 23, "45 points to 65 at 2 a lap");
	assert_eq!(farm["second"]["map"], 1429, "the second choice: Elwynn Forest");
}

#[test]
fn flying_to_another_continent_re_picks_the_loop_there() {
	let out = run(
		"w.moveTo(1436, 52, 52); w.setZone(\"Westfall\")",
		r#"
		local r = { westfall = view() }
		stub.world.moveTo(1411, 51, 51); stub.world.setZone("Durotar"); flush()
		r.durotar = view()
		emit(r)"#,
	);
	assert_eq!(out["westfall"]["map"], 1436);
	assert_eq!(out["durotar"]["map"], 1411, "landing on Kalimdor re-picks: the Durotar loop");
	assert_eq!(out["durotar"]["spots"], 4);
}

#[test]
fn a_loop_whose_creatures_are_two_levels_above_the_player_is_skipped_for_one_at_their_level() {
	let out = run("w.level = 10; w.moveTo(1436, 52, 52); w.setZone(\"Westfall\")", "emit(view())");
	assert_eq!(out["map"], 1429, "Westfall's creatures (15) are 5 above a level 10: Elwynn Forest instead, though farther");
	assert_eq!(out["spots"], 2);
	assert_eq!(out["farm"]["above"], Value::Null, "the pick is at the player's level");
	// Only loops above the player: the smallest gap, with the warning.
	let high = run("w.level = 3; w.moveTo(1436, 52, 52); w.setZone(\"Westfall\")", "emit(view())");
	assert_eq!(high["map"], 1429, "level 3: every loop is above; Elwynn Forest's 6 is the smallest gap");
	assert_eq!(high["farm"]["above"], 3);
}

#[test]
fn cycling_moves_the_arrow_to_the_next_loop_and_its_stops() {
	let out = run(
		"w.moveTo(1436, 52, 52); w.setZone(\"Westfall\")",
		r#"
		local r = { before = view() }
		r.i = E.CycleCandidate(1, 1); flush()
		r.after = view()
		emit(r)"#,
	);
	assert_eq!(out["before"]["map"], 1436);
	assert_eq!(out["i"], 2);
	assert_eq!(out["after"]["map"], 1429);
	assert_eq!(out["after"]["spots"], 2);
}
