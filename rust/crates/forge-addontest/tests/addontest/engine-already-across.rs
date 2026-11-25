//! A walk to a boat, zeppelin or portal the player is already across passes (#1971, #1978, #1983, #3906;
//! addon/Polestar/Core/Engine.lua, Own.alreadyAcross). 0.3.7.2's Thousand Needles & Desolace opens with "Zeppelin
//! to Orgrimmar", a walk to the Undercity's tower in Tirisfal Glades, because the previous guide ends in the
//! Undercity. A Scourge Warrior who loaded it at Freewind Post was sent to Orgrimmar, onto the zeppelin to the
//! Undercity, and back to Orgrimmar for Craven Drok (#1971); Dustwallow Marsh & Desolace opens the same way at
//! Grom'gol and sent an Orc Shaman in Orgrimmar to Stranglethorn and back (#1978). Along one continent (#1983):
//! Feralas's "Boat to Feathermoon Stronghold" sent a Druid who had flown in to Feathermoon back over the water to
//! the Forgotten Coast's dock and across again. Through a portal (#3906): Tanaris's "Portal to Darnassus", a walk
//! to the portal's mouth in Rut'theran Village, stayed open in Darnassus, since the portal takes the player before
//! the walk's goto is reached. Nav is faked as in engine-empty-stop.rs.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 3033.333, right = -1485.417, top = 3837.5, bottom = 825 })
w.addMap(1424, { name = "Hillsbrad Foothills", c = 0, left = 1066.667, right = -2133.333, top = 400, bottom = -1733.333 })
w.addMap(1434, { name = "Stranglethorn Vale", c = 0, left = 2220.833, right = -4160.417, top = -11168.75, bottom = -15422.916 })
w.addMap(1441, { name = "Thousand Needles", c = 1, left = -433.333, right = -4833.333, top = -3966.667, bottom = -6900 })
w.addMap(1444, { name = "Feralas", c = 1, left = 5441.667, right = -1508.333, top = -2366.667, bottom = -7000 })
w.addMap(1454, { name = "Orgrimmar", c = 1, left = -3680.601, right = -5083.206, top = 2273.877, bottom = 1338.461 })
w.addMap(1438, { name = "Teldrassil", c = 1, left = 3814.583, right = -1277.083, top = 11831.25, bottom = 8437.5 })
w.addMap(1457, { name = "Darnassus", c = 1, left = 2938.363, right = 1880.03, top = 10238.316, bottom = 9532.587 })
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Scourge", "Undead", "Horde", "WARRIOR", "Warrior", 32
w.money = 50000
"#;

const NAV: &str = r#"
NODES = {
	[23] = { id = 23, name = "Orgrimmar, Durotar", c = 1, map = 1454, x = 45.3, y = 63.7, f = "e" },
	[30] = { id = 30, name = "Freewind Post, Thousand Needles", c = 1, map = 1441, x = 45.0, y = 49.1, f = "e" },
}
KNOWN = { [23] = true, [30] = true }
Polestar.Nav = {
	GetTaxiNode = function(id) return id and NODES[id] end,
	GetKnownTaxiNodes = function() return KNOWN end,
	EstimateTravel = function() return nil end,
	HandedOff = function() return false end,
	UsingTomTomArrow = function() return false end,
}
Polestar.Set("nav.travel", true)
Polestar.CharState().flags.taxi = { [23] = true, [30] = true }
stub.fire("QUEST_LOG_UPDATE")
"#;

// Steps 1-3 of 0.3.7.2's forever/horde/30-40/02-thousand-needles, as the compiler writes them.
const NEEDLES: &str = r#"
Polestar.RegisterGuide({ id = "test/tn", pack = "test", title = "Thousand Needles & Desolace", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Zeppelin to Orgrimmar", goals = { { t = "goto", map = 1420, x = 60.7, y = 58.8, text = "Zeppelin to Orgrimmar" } } },
	{ title = "Alliance Relations", goals = {
		{ t = "accept", quest = 1431, title = "Alliance Relations", npc = 5639, map = 1454, x = 51.3, y = 45.9 },
		{ t = "turnin", quest = 1431, title = "Alliance Relations", npc = 5640, map = 1454, x = 22.56, y = 52.63 },
	} },
	{ title = "Orgrimmar flight master", goals = { { t = "goto", map = 1454, x = 45.3, y = 63.7, text = "Orgrimmar flight master" } } },
} })
"#;

// Steps 1-3 of 0.3.7.2's forever/horde/30-40/04-dustwallow-marsh: the walk to Grom'gol, then a walk in Orgrimmar.
const DUSTWALLOW: &str = r#"
Polestar.RegisterGuide({ id = "test/dw", pack = "test", title = "Dustwallow Marsh & Desolace", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Zeppelin to Orgrimmar", goals = { { t = "goto", map = 1434, x = 31.4, y = 29.9, text = "Zeppelin to Orgrimmar" } } },
	{ title = "Orgrimmar", goals = { { t = "goto", map = 1454, x = 51.5, y = 45.6, text = "The middle of Orgrimmar" } } },
	{ title = "Sorek", goals = { { t = "accept", quest = 1718, title = "The Islander", npc = 3354, map = 1454, x = 80.4, y = 32.4 } } },
} })
"#;

// Steps 3-4 of 0.4.0.1's forever/alliance/40-50/03-feralas: the walk to the Forgotten Coast's dock, then the
// Feathermoon Stronghold stop (Pratt McGrubben by the flight master).
const FERALAS: &str = r#"
Polestar.RegisterGuide({ id = "test/fe", pack = "test", title = "Feralas", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Boat to Feathermoon Stronghold", goals = { { t = "goto", map = 1444, x = 43.3, y = 42.7, text = "Boat to Feathermoon Stronghold" } } },
	{ title = "Feathermoon Stronghold", goals = { { t = "accept", quest = 2821, title = "The Mark of Quality", npc = 7854, map = 1444, x = 30.6, y = 42.7 } } },
} })
-- Nav/Travel.lua's Feathermoon boat: Feathermoon Stronghold's end, the Forgotten Coast's dock.
FEATHERMOON = { a = { c = 1, wx = -4197.3, wy = 3286.6 }, b = { c = 1, wx = -4347.8, wy = 2444.4 } }
function boats() Polestar.Nav.GetTravelData = function() return { transports = { FEATHERMOON } } end end
"#;

// Steps 33-34 of 0.4.2.2's forever/alliance/40-50/04-tanaris: the walk to the portal into Darnassus in Rut'theran
// Village, then Tyrande Whisperwind's hand-in in the Temple of the Moon.
const TANARIS: &str = r#"
Polestar.RegisterGuide({ id = "test/ta", pack = "test", title = "Tanaris", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Portal to Darnassus", goals = { { t = "goto", map = 1438, x = 55.9, y = 89.3, text = "Portal to Darnassus" } } },
	{ title = "Temple of the Moon", goals = { { t = "turnin", quest = 2972, title = "Doling Justice", npc = 7999, map = 1457, x = 38.81, y = 81.1 } } },
} })
-- Nav/Travel.lua's walk-in portal from Rut'theran Village (a, its mouth) into Darnassus (b, where it lands).
RUTTHERAN = { kind = "portal", a = { c = 1, wx = 8799.4, wy = 969.8 }, b = { c = 1, wx = 9946.3, wy = 2613 } }
function portals() Polestar.Nav.GetTravelData = function() return { portals = { RUTTHERAN } } end end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{NEEDLES}\n{DUSTWALLOW}\n{FERALAS}\n{TANARIS}\nE = Polestar.Engine\nfunction flush() stub.advance(0.25) end\nstub.login()\n{NAV}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

const FREEWIND: &str = r#"stub.world.moveTo(1441, 46.6, 47.68); stub.world.setZone("Thousand Needles", "Freewind Post")"#;

fn at(place: &str, setup: &str, guide: &str) -> Value {
	run(&format!(
		r#"
		{place}
		{setup}
		E.SetGuide("{guide}"); flush()
		local wp = E.GetWaypoint()
		emit({{ E.GetStepIndex(), wp and wp.map or false, wp and wp.kind or false }})
		"#
	))
}

#[test]
fn t_1971_at_freewind_post_the_walk_to_the_undercity_zeppelin_passes_and_craven_drok_leads() {
	assert_eq!(at(FREEWIND, "", "test/tn"), json!([2, 1454, "accept"]), "TheMoe87: straight to Orgrimmar, not to Tirisfal and back");
}

#[test]
fn t_1971_the_walk_passes_with_the_planner_off_too() {
	assert_eq!(at(FREEWIND, "Polestar.Set(\"nav.travel\", false)", "test/tn"), json!([2, 1454, "accept"]));
}

#[test]
fn t_1971_on_the_walks_own_continent_the_walk_to_the_zeppelin_holds() {
	let out = json!({
		// In Brill, by the tower: the zeppelin is the way to Orgrimmar.
		"brill": at(r#"stub.world.moveTo(1420, 61.7, 52.0); stub.world.setZone("Tirisfal Glades", "Brill")"#, "", "test/tn"),
		// In Hillsbrad: still Eastern Kingdoms, so the walk to the tower holds as written.
		"hillsbrad": at(r#"stub.world.moveTo(1424, 61.5, 20.8); stub.world.setZone("Hillsbrad Foothills", "Tarren Mill")"#, "", "test/tn"),
	});
	assert_eq!(out, json!({ "brill": [1, 1420, "goto"], "hillsbrad": [1, 1420, "goto"] }));
}

// Passed at Freewind Post, then the player crosses to the Eastern Kingdoms before Orgrimmar (a hearth to the
// Undercity): the walk stays behind them (latched), and Craven Drok still leads.
#[test]
fn t_1971_a_walk_passed_across_stays_passed_after_crossing_back() {
	let out = run(&format!(
		r#"
		{FREEWIND}
		E.SetGuide("test/tn"); flush()
		local before = E.GetStepIndex()
		stub.world.moveTo(1420, 61.7, 52.0); stub.world.setZone("Tirisfal Glades", "Brill"); flush()
		emit({{ before, E.GetStepIndex() }})
		"#
	));
	assert_eq!(out, json!([2, 2]));
}

#[test]
fn t_1978_in_orgrimmar_the_walk_to_gromgol_passes() {
	let out = at(r#"stub.world.moveTo(1454, 52.04, 83.85); stub.world.setZone("Orgrimmar", "Valley of Strength")"#, "", "test/dw");
	assert_eq!(out, json!([2, 1454, "goto"]), "gabriel pasternak: in Orgrimmar, not to Grom'gol and back");
}

const THALANAAR: &str = r#"stub.world.moveTo(1444, 89.5, 45.9); stub.world.setZone("Feralas", "Thalanaar")"#;

// The guide loaded at Thalanaar (the walk to the dock live), then a flight to Feathermoon: the live step before and
// after landing, and where the arrow points then. (Loading the guide at Feathermoon places past the walk anyway.)
fn flown_in(setup: &str) -> Value {
	run(&format!(
		r#"
		{THALANAAR}
		{setup}
		E.SetGuide("test/fe"); flush()
		local before = E.GetStepIndex()
		stub.world.moveTo(1444, 30.47, 42.73); stub.world.setZone("Feralas", "Feathermoon Stronghold"); flush()
		local wp = E.GetWaypoint()
		emit({{ before, E.GetStepIndex(), wp and wp.map or false, wp and wp.kind or false }})
		"#
	))
}

#[test]
fn t_1983_flown_in_to_feathermoon_the_walk_to_the_boat_passes() {
	assert_eq!(flown_in("boats()"), json!([1, 2, 1444, "accept"]), "Visur: Pratt leads, not the dock across the water");
}

#[test]
fn t_1983_on_the_mainland_or_without_crossing_data_the_walk_to_the_boat_holds() {
	let out = json!({
		// Thalanaar's flight master, where the guide walks from.
		"thalanaar": at(THALANAAR, "boats()", "test/fe"),
		// On the coast by the dock.
		"coast": at(r#"stub.world.moveTo(1444, 45.0, 43.5); stub.world.setZone("Feralas", "The Forgotten Coast")"#, "boats()", "test/fe"),
		// Flown in to Feathermoon, with no crossing data: as before.
		"nodata": flown_in(""),
	});
	assert_eq!(out, json!({ "thalanaar": [1, 1444, "goto"], "coast": [1, 1444, "goto"], "nodata": [1, 1, 1444, "goto"] }));
}

const RUTTHERAN: &str = r#"stub.world.moveTo(1438, 58.4, 94.0); stub.world.setZone("Teldrassil", "Rut'theran Village")"#;

// Doling Justice in the log, ready for Tyrande.
const DOLING: &str = r#"stub.world.onQuest(2972, {}); stub.fire("QUEST_LOG_UPDATE")"#;

// The guide loaded by Rut'theran Village's flight master with Doling Justice ready (the walk to the portal live),
// then through the portal, landing in Darnassus: the live step before and after, and where the arrow points then.
fn through_portal(setup: &str) -> Value {
	run(&format!(
		r#"
		{RUTTHERAN}
		{setup}
		{DOLING}
		E.SetGuide("test/ta"); flush()
		local before = E.GetStepIndex()
		stub.world.moveTo(1457, 30.75, 41.39); stub.world.setZone("Darnassus", "Darnassus"); flush()
		local wp = E.GetWaypoint()
		emit({{ before, E.GetStepIndex(), wp and wp.map or false, wp and wp.kind or false }})
		"#
	))
}

#[test]
fn t_3906_through_the_portal_into_darnassus_the_walk_to_it_passes() {
	assert_eq!(through_portal("portals()"), json!([1, 2, 1457, "turnin"]), "lordp: Tyrande leads, not the portal behind you");
}

#[test]
fn t_3906_in_ruttheran_or_without_portal_data_the_walk_to_the_portal_holds() {
	let out = json!({
		// By Rut'theran Village's flight master, short of the portal.
		"ruttheran": at(RUTTHERAN, &format!("portals(); {DOLING}"), "test/ta"),
		// Through the portal with no portal data: as before.
		"nodata": through_portal(""),
	});
	assert_eq!(out, json!({ "ruttheran": [1, 1438, "goto"], "nodata": [1, 1, 1438, "goto"] }));
}
