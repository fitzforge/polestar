//! A walk to a stop that holds nothing for the character passes (#1596; addon/Polestar/Core/Engine.lua,
//! Own.stopEmpty). 0.3.6's Ashenvale & Thousand Needles walks up into Thunder Bluff (step 40) for Zangen
//! (`when complete 1195`), Tah (`when complete 97538`), Ansekhwa (Warriors without maces) and the flight path,
//! then flies to Camp Taurajo for The Tear of the Moons. A Skyborne Rogue standing in Camp Taurajo, with none of
//! that to do, was sent 2,247 yards back up to Thunder Bluff. Nav is faked as in engine-flights.rs.

use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 2622.917, right = -7510.417, top = 1612.5, bottom = -5143.75 })
w.addMap(1412, { name = "Mulgore", c = 1, left = 2047.917, right = -3089.583, top = -272.917, bottom = -3697.917 })
w.addMap(1456, { name = "Thunder Bluff", c = 1, left = 516.667, right = -527.083, top = -849.999, bottom = -1545.833 })
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Skyborne", "Skyborne", "Horde", "ROGUE", "Rogue", 30
w.money = 50000
"#;

const NAV: &str = r#"
NODES = {
	[22] = { id = 22, name = "Thunder Bluff, Mulgore", c = 1, map = 1456, x = 46.7, y = 49.9, f = "e" },
	[77] = { id = 77, name = "Camp Taurajo, The Barrens", c = 1, map = 1413, x = 44.4, y = 59.1, f = "e" },
}
KNOWN = { [22] = true, [77] = true }
Polestar.Nav = {
	GetTaxiNode = function(id) return id and NODES[id] end,
	GetKnownTaxiNodes = function() return KNOWN end,
	EstimateTravel = function() return nil end,
	HandedOff = function() return false end,
	UsingTomTomArrow = function() return false end,
}
Polestar.Set("nav.travel", true)
Polestar.CharState().flags.taxi = { [22] = true, [77] = true }
stub.fire("QUEST_LOG_UPDATE")
"#;

// Steps 38-47 of 0.3.6's forever/horde/07-ashenvale, as the compiler writes them.
const TB: &str = r#"
Polestar.RegisterGuide({ id = "test/tb", pack = "test", title = "Ashenvale & Thousand Needles", minLevel = 1, maxLevel = 60, steps = {
	{ title = "The Earthen Ring", goals = { { t = "turnin", quest = 96259, title = "Defending the Dead", npc = 3053, map = 1412, x = 32.7, y = 36.1 } } },
	{ title = "Class trainer", only = { classes = { "PALADIN", "PRIEST", "SHAMAN", "MAGE", "DRUID" } }, goals = { { t = "train", class = true } } },
	{ title = "Thunder Bluff", goals = { { t = "goto", map = 1456, x = 47.0, y = 49.8, text = "Thunder Bluff's central rise" } } },
	{ title = "Thunder Bluff", goals = {
		{ t = "getfp", location = "Thunder Bluff", node = 22, npc = 2995, map = 1456, x = 46.9, y = 49.9 },
		{ t = "kill", target = "Talk to Cairne Bloodhoof", npc = 3057, count = 1, quest = 93739, oi = 3, optional = true, only = { races = { "Skyborne" } }, map = 1456, x = 60.2, y = 51.7 },
	} },
	{ title = "Zangen Stonehoof", when = { { k = "complete", q = 1195 } }, goals = {
		{ t = "turnin", quest = 1195, title = "The Sacred Flame", npc = 4721, map = 1456, x = 54.0, y = 52.0 },
		{ t = "accept", quest = 1196, title = "The Sacred Flame", npc = 4721, map = 1456, x = 54.0, y = 52.0 },
	} },
	{ title = "Tah Winterhoof", when = { { k = "complete", q = 97538 } }, goals = { { t = "turnin", quest = 97538, title = "Pigments for Paints", npc = 3018, map = 1456, x = 54.5, y = 52.5 } } },
	{ title = "Ansekhwa", only = { classes = { "WARRIOR" } }, when = { { k = "money", op = ">=", n = 1000 }, { k = "skill", name = "Two-Handed Maces", n = 1, neg = true } }, goals = {
		{ t = "train", npc = 11869, npcName = "Ansekhwa", map = 1456, x = 40.0, y = 63.0 },
	} },
	{ title = "Fly to Camp Taurajo", goals = {
		{ t = "goto", map = 1456, x = 46.7, y = 49.9, text = "Thunder Bluff flight master" },
		{ t = "fly", location = "Camp Taurajo", node = 77 },
	} },
	{ title = "Brine", only = { classes = { "SHAMAN" } }, goals = { { t = "turnin", quest = 1534, title = "Call of Water", npc = 5899, map = 1413, x = 43.4, y = 77.4 } } },
	{ title = "Tear of the Moons", goals = { { t = "accept", quest = 857, title = "The Tear of the Moons", npc = 3446, map = 1413, x = 48.1, y = 86.3 } } },
} })
"#;

fn run(guides: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{guides}\nE = Polestar.Engine\nfunction flush() stub.advance(0.25) end\nstub.login()\n{NAV}\nstub.world.complete({{ 96259 }})\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// Redrett (#1596): in Camp Taurajo by its flight master; the flight to Camp Taurajo reads done there.
const AT_CAMP: &str = r#"stub.world.moveTo(1413, 44.53, 58.97); stub.world.setZone("The Barrens", "Camp Taurajo")"#;

fn at(setup: &str) -> Value {
	run(
		TB,
		&format!(
			r#"
			{AT_CAMP}
			{setup}
			E.SetGuide("test/tb"); flush()
			local wp = E.GetWaypoint()
			emit({{ E.GetStepIndex(), wp and wp.map or false, wp and wp.kind or false }})
			"#
		),
	)
}

#[test]
fn t_1596_in_camp_taurajo_with_nothing_to_do_in_thunder_bluff_the_walk_up_passes_and_the_tear_of_the_moons_leads() {
	assert_eq!(at(""), json!([10, 1413, "accept"]), "Redrett: the walk to Thunder Bluff passes; the Tear of the Moons leads");
}

#[test]
fn t_1596_the_walk_to_thunder_bluff_holds_while_something_there_is_for_the_character() {
	let out = json!({
		// The Sacred Flame ready to hand in: Zangen is work at the stop.
		"sacredFlame": at("stub.world.onQuest(1195, { { required = 1, fulfilled = 1 } }); stub.fire(\"QUEST_LOG_UPDATE\")"),
		// A Warrior with the money and no maces yet: Ansekhwa's training.
		"warrior": at("stub.world.class, stub.world.className = \"WARRIOR\", \"Warrior\""),
		// Thunder Bluff's flight path not known yet: Tal's flight path.
		"noFlightPath": at("Polestar.CharState().flags.taxi[22] = nil"),
		// The planner off: the guide's steps as written.
		"plannerOff": at("Polestar.Set(\"nav.travel\", false)"),
	});
	assert_eq!(
		out,
		json!({
			"sacredFlame": [3, 1456, "goto"],
			"warrior": [3, 1456, "goto"],
			"noFlightPath": [3, 1456, "goto"],
			"plannerOff": [3, 1456, "goto"],
		})
	);
}

// The same guide for a Rogue in Mulgore (Gloomrise, before the walk up): the walk passes, and the flight to Camp
// Taurajo leads to its landing for the route to plan (that much Own.flightOn did before).
#[test]
fn t_1596_away_from_camp_taurajo_the_empty_stop_passes_to_the_flight() {
	let out = run(
		TB,
		r#"
		stub.world.moveTo(1412, 33.0, 20.0); stub.world.setZone("Mulgore", "Gloomrise")
		E.SetGuide("test/tb"); flush()
		local wp = E.GetWaypoint()
		emit({ E.GetStepIndex(), wp and wp.map or false, wp and wp.kind or false })
		"#,
	);
	assert_eq!(out, json!([8, 1413, "fly"]));
}

// What is not an empty stop: open optional work (a riding trainer), a walk followed only by other classes' steps
// (it is the way on), and a stop with no travel step after it (the guide's end). Walks only here: a flight right
// after a stop is Own.flightOn's.
const KEPT: &str = r#"
Polestar.RegisterGuide({ id = "test/kept", pack = "test", title = "Kept", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Start", goals = { { t = "turnin", quest = 96259, title = "Defending the Dead", npc = 3053, map = 1412, x = 32.7, y = 36.1 } } },
	{ title = "Thunder Bluff", goals = { { t = "goto", map = 1456, x = 47.0, y = 49.8, text = "Thunder Bluff's central rise" } } },
	{ title = "Riding", goals = { { t = "train", npc = 3690, npcName = "Kar Stormsinger", optional = true, map = 1456, x = 47.5, y = 58.0 } } },
	{ title = "Mulgore", goals = { { t = "goto", map = 1412, x = 46.0, y = 58.0, text = "Bloodhoof Village" } } },
	{ title = "Brine", only = { classes = { "SHAMAN" } }, goals = { { t = "turnin", quest = 1534, title = "Call of Water", npc = 5899, map = 1413, x = 43.4, y = 77.4 } } },
	{ title = "The Great Lift", goals = { { t = "goto", map = 1413, x = 31.9, y = 23.9, text = "The Great Lift" } } },
	{ title = "Tear of the Moons", goals = { { t = "accept", quest = 857, title = "The Tear of the Moons", npc = 3446, map = 1413, x = 48.1, y = 86.3 } } },
	{ title = "Freewind Post", goals = { { t = "goto", map = 1413, x = 44.9, y = 48.9, text = "Freewind Post" } } },
	{ title = "Rau", when = { { k = "complete", q = 1196 } }, goals = { { t = "turnin", quest = 1196, title = "The Sacred Flame", npc = 4721, map = 1413, x = 44.0, y = 49.0 } } },
} })
"#;

#[test]
fn t_1596_optional_work_other_classes_steps_and_the_guides_end_keep_the_walk() {
	let out = run(
		KEPT,
		r#"
		stub.world.moveTo(1412, 33.0, 20.0); stub.world.setZone("Mulgore", "Gloomrise")
		E.SetGuide("test/kept"); flush()
		local r = { riding = E.GetStepIndex() }
		-- Past the riding stop: the walk to Bloodhoof, followed only by a Shaman's step, holds (the way on).
		E.SkipUpTo(4); flush()
		r.otherClass = E.GetStepIndex()
		-- At the guide's end: a walk to Freewind Post whose stop (Rau) does not apply holds.
		stub.world.complete({ 857 }); E.SkipUpTo(8); flush()
		r.guideEnd = E.GetStepIndex()
		emit(r)
		"#,
	);
	assert_eq!(out, json!({ "riding": 2, "otherClass": 4, "guideEnd": 8 }));
}

// The shipped guide (addon/Polestar_Guides_Horde) on the real addon, with Redrett's quest log from the report:
// 2841 0/2, 567 2/4, 515 0/3, 4542 done, 6681 0/1; every quest of the guide before the walk up done, every flight
// path in it known; standing in Camp Taurajo.
#[test]
fn t_1596_redrett_on_the_shipped_ashenvale_passes_the_thunder_bluff_walk() {
	let dir = forge_addontest::run::addons_dir();
	let before = r#"local w = stub.world
w.race, w.raceName, w.faction, w.class, w.className, w.level = "Skyborne", "Skyborne", "Horde", "ROGUE", "Rogue", 30
w.money = 500000
w.onQuest(2841, { { required = 2, fulfilled = 0 } })
w.onQuest(567, { { required = 4, fulfilled = 2 } })
w.onQuest(515, { { required = 3, fulfilled = 0 } })
w.onQuest(4542, { { required = 1, fulfilled = 1 } })
w.onQuest(6681, { { required = 1, fulfilled = 0 } })"#;
	let script = r#"
E = Polestar.Engine
for id, b in pairs(Polestar.MapFrames.era) do stub.world.addMap(id, b) end
stub.login(); stub.advance(0.25)
Polestar.Set("behavior.autoAccept", false)
E.SetGuide("forever/horde/07-ashenvale"); stub.advance(0.25)
local g = E.GetGuide()
local tb, tear
for i, step in ipairs(g.steps) do
	local goal = step.goals[1]
	if not tb and step.title == "Thunder Bluff" and #step.goals == 1 and goal.t == "goto" then tb = i end
	for _, x in ipairs(step.goals) do if x.t == "accept" and x.quest == 857 then tear = tear or i end end
end
local done, taxi = {}, Polestar.CharState().flags
taxi.taxi = {}
for i, step in ipairs(g.steps) do
	for _, x in ipairs(step.goals) do
		if i < tb and x.quest and (x.t == "accept" or x.t == "turnin") and x.quest ~= 4542 then done[#done + 1] = x.quest end
		if x.node then taxi.taxi[x.node] = true end
	end
end
stub.world.complete(done)
stub.world.moveTo(1413, 44.53, 58.97); stub.world.setZone("The Barrens", "Camp Taurajo")
stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.25)
if E.GetStepIndex() < tb then E.SkipUpTo(tb); stub.advance(0.25) end
emit({ tb = tb, tear = tear, at = E.GetStepIndex() })
"#;
	let out = emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: before.to_string(),
		addons: vec![Addon::name("Polestar"), Addon::dir("Polestar_Guides", dir.join("Polestar_Guides")), Addon::dir("Polestar_Guides_Horde", dir.join("Polestar_Guides_Horde"))],
		script: script.to_string(),
		..Default::default()
	})
	.remove(0);
	assert!(out["tb"].is_u64() && out["tear"].is_u64(), "{out}");
	assert_eq!(out["at"], out["tear"], "the walk up to Thunder Bluff passes; the Tear of the Moons leads: {out}");
}
