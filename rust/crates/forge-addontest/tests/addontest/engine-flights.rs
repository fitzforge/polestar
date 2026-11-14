//! Flights the travel route takes better (#1191, #1212; addon/Polestar/Core/Engine.lua, "Flights the travel
//! route takes better"): with the planner on, a flight step leads to the flight's end, a travel step passes when
//! another flight follows with nothing left to do between, and a flight step passes when the planner reaches the
//! next work clearly sooner without landing at its end. Nav is faked: its taxi nodes, the flight paths the
//! character knows, the planner's estimates and whether TomTom's arrow leads.

use forge_addontest::run::root;
use forge_addontest::{emitted, Addon, RunAddon, TEST_PACK, TEST_SOURCE};
use serde_json::{json, Value};

const WORLD: &str = r#"
local w = stub.world
w.addMap(1440, { name = "Ashenvale", c = 1, left = 3000, right = -1000, top = 3000, bottom = 0 })
w.addMap(1439, { name = "Darkshore", c = 1, left = 3000, right = -1000, top = 7000, bottom = 3000 })
w.addMap(1442, { name = "Stonetalon Mountains", c = 1, left = 3000, right = -1000, top = 0, bottom = -3000 })
w.addMap(1412, { name = "Mulgore", c = 1, left = 3000, right = -1000, top = -3000, bottom = -6000 })
w.addMap(1437, { name = "Wetlands", c = 0, left = 3000, right = -1000, top = 3000, bottom = 0 })
w.moveTo(1442, 50, 50)
"#;

// Nav as the Engine reads it: the taxi nodes by id, the known ones, and EST(from, to) for the planner.
const NAV: &str = r#"
NODES = {
	[26] = { id = 26, name = "Auberdine, Darkshore", c = 1, map = 1439, x = 36.3, y = 45.6, f = "e" },
	[28] = { id = 28, name = "Astranaar, Ashenvale", c = 1, map = 1440, x = 34.4, y = 48.0, f = "e" },
	[33] = { id = 33, name = "Stonetalon Peak, Stonetalon Mountains", c = 1, map = 1442, x = 36.4, y = 7.2, f = "e" },
	[77] = { id = 77, name = "Camp Taurajo, The Barrens", c = 1, map = 1412, x = 90, y = 50, f = "e" },
	[22] = { id = 22, name = "Thunder Bluff, Mulgore", c = 1, map = 1412, x = 47, y = 50, f = "e" },
}
KNOWN = { [26] = true, [28] = true, [33] = true }
EST = function() return nil end
ESTIMATES = 0
Polestar.Nav = {
	GetTaxiNode = function(id) return id and NODES[id] end,
	GetKnownTaxiNodes = function() return KNOWN end,
	EstimateTravel = function(from, to) ESTIMATES = ESTIMATES + 1; return EST(from, to) end,
	HandedOff = function() return false end,
	UsingTomTomArrow = function() return TOMTOM == true end,
}
Polestar.Set("nav.travel", true)
-- The quest log reads (the client fires this after login).
stub.fire("QUEST_LOG_UPDATE")
"#;

fn run(guides: &str, script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_world.lua"],
		before: WORLD.to_string(),
		addons: vec![Addon::files("Polestar", &["Core/Core.xml"])],
		script: format!("{TEST_PACK}\n{TEST_SOURCE}\n{guides}\nE = Polestar.Engine\nfunction flush() stub.advance(0.25) end\nstub.login()\n{NAV}\n{script}"),
		..Default::default()
	})
	.remove(0)
}

// 0.3.4's Ashenvale (#1191): after Windshear Crag a walk to Astranaar's flight master, then the flight to
// Auberdine from there, the boat on. A player with Stonetalon Peak was routed by air to Astranaar first.
const ASHENVALE: &str = r#"
Polestar.RegisterGuide({ id = "test/ashenvale", pack = "test", title = "Ashenvale", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Webwinder Path", goals = { { t = "turnin", quest = 1093, title = "Super Reaper 6000", npc = 4201, map = 1442, x = 59, y = 67 } } },
	{ title = "Ashenvale", goals = { { t = "goto", map = 1440, x = 34.5, y = 48.0, text = "Ashenvale" } } },
	{ title = "Fly to Auberdine", goals = {
		{ t = "goto", map = 1440, x = 34.5, y = 48.0, text = "Astranaar flight master" },
		{ t = "fly", location = "Auberdine", node = 26 },
	} },
	{ title = "Boat to Menethil Harbor", goals = { { t = "goto", map = 1439, x = 32.4, y = 43.8, text = "Boat to Menethil Harbor" } } },
	{ title = "Menethil Harbor", goals = { { t = "getfp", location = "Menethil Harbor", node = 7, map = 1437, x = 9.5, y = 59.7 } } },
} })
"#;

// #1853: the Druid opening of Horde Stranglethorn Vale puts a bare flight and
// Turak's training in one step. The navigation nodes use this file's fake world.
const MIXED_FLIGHT: &str = r#"
stub.world.class, stub.world.className, stub.world.level = "DRUID", "Druid", 36
Polestar.Set("behavior.trainReminder", "off")
Polestar.RegisterMapFrames({ era = { [1412] = { c = 1, left = 3000, right = -1000, top = -3000, bottom = -6000 } } })
Polestar.RegisterGuide({ id = "test/mixed-flight", pack = "test", title = "Thunder Bluff", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Thunder Bluff", goals = {
		{ t = "fly", location = "Thunder Bluff", node = 22 },
		{ t = "train", class = true, npc = 3033, npcName = "Turak Runetotem", map = 1456, x = 76.48, y = 27.22 },
	} },
	{ title = "Fly to Astranaar", goals = { { t = "fly", location = "Astranaar", node = 28 } } },
	{ title = "Astranaar", goals = { { t = "accept", quest = 1008, title = "The Zoram Strand", npc = 3880, map = 1440, x = 34.7, y = 48.8 } } },
} })
"#;

#[test]
fn a_flight_before_training_in_the_same_step_leads_to_its_landing_and_keeps_the_training_1853() {
	for known in [true, false] {
		let out = run(
			MIXED_FLIGHT,
			&format!(
				r#"
				KNOWN[22] = {known}
				E.SetGuide("test/mixed-flight"); flush()
				local function at()
					local wp, v = E.GetWaypoint(), E.GetStepView(1)
					return {{ E.GetStepIndex(), wp and wp.kind or false, wp and wp.goalIndex or false,
						wp and wp.map or false, v.goals[1].status, v.goals[2].status }}
				end
				local r = {{ lead = at() }}
				stub.world.moveTo(1412, 47, 50); stub.advance(1)
				r.landed = at()
				stub.world.trainer(3033); stub.world.learnSpell(774); flush()
				r.trained = at()
				emit(r)
				"#
			),
		);
		assert_eq!(out["lead"], json!([1, "fly", 1, 1412, "active", "active"]), "known={known}: {out}");
		assert_eq!(out["landed"], json!([1, "train", 2, 1456, "done", "active"]), "known={known}: {out}");
		assert_eq!(out["trained"], json!([2, "fly", 1, 1440, "done", "done"]), "known={known}: {out}");
	}
}

#[test]
fn earlier_work_keeps_its_waypoint_before_a_mixed_flight_1853() {
	let guides = MIXED_FLIGHT.replace(
		"{ t = \"fly\", location = \"Thunder Bluff\", node = 22 },",
		r#"{ t = "accept", quest = 1436, title = "Alliance Relations", npc = 5641, map = 1442, x = 70, y = 50 },
		{ t = "goto", map = 1442, x = 36.4, y = 7.2, text = "Stonetalon Peak flight master" },
		{ t = "fly", location = "Thunder Bluff", node = 22 },"#,
	);
	let out = run(
		&guides,
		r#"
		KNOWN[22] = true
		E.SetGuide("test/mixed-flight"); flush()
		local function at()
			local wp = E.GetWaypoint()
			return { wp and wp.kind or false, wp and wp.goalIndex or false, wp and wp.map or false }
		end
		local r = { before = at() }
		stub.world.accept(1436, {}); flush()
		r.accepted = at()
		emit(r)
		"#,
	);
	assert_eq!(out, json!({ "before": ["accept", 1, 1442], "accepted": ["fly", 3, 1412] }));
}

#[test]
fn a_mixed_flight_does_not_aim_an_optional_or_inapplicable_flight_1853() {
	let guides = MIXED_FLIGHT.replace(
		"{ t = \"fly\", location = \"Thunder Bluff\", node = 22 },",
		r#"{ t = "fly", location = "Auberdine", node = 26, optional = true },
		{ t = "fly", location = "Astranaar", node = 28, only = { classes = { "MAGE" } } },
		{ t = "fly", location = "Thunder Bluff", node = 22 },"#,
	);
	let out = run(
		&guides,
		r#"
		KNOWN[22] = true
		E.SetGuide("test/mixed-flight"); flush()
		local function at()
			local wp = E.GetWaypoint()
			return { wp and wp.kind or false, wp and wp.goalIndex or false, wp and wp.map or false, E.GetStepView(1).current }
		end
		local r = { before = at() }
		assert(E.SkipGoal(1, 1)); flush()
		r.skipped = at()
		emit(r)
		"#,
	);
	assert_eq!(out, json!({ "before": ["fly", 3, 1412, 3], "skipped": ["fly", 3, 1412, 3] }));
}

#[test]
fn a_mixed_flight_without_a_landing_does_not_aim_a_later_flight_1853() {
	let guides = MIXED_FLIGHT.replace(
		"{ t = \"fly\", location = \"Thunder Bluff\", node = 22 },",
		r#"{ t = "fly", location = "Thunder Bluff", node = 22 },
		{ t = "fly", location = "Astranaar", node = 28 },"#,
	);
	let out = run(
		&guides,
		r#"
		NODES[22] = nil
		E.SetGuide("test/mixed-flight"); flush()
		emit({ E.GetWaypoint() or false, E.GetStepView(1).current })
		"#,
	);
	assert_eq!(out, json!([false, 1]));
}

#[test]
fn a_mixed_flight_keeps_the_named_departure_when_the_planner_is_not_leading_1853() {
	let guides = MIXED_FLIGHT.replace(
		"{ t = \"fly\", location = \"Thunder Bluff\", node = 22 },",
		r#"{ t = "goto", map = 1442, x = 36.4, y = 7.2, text = "Stonetalon Peak flight master" },
		{ t = "fly", location = "Thunder Bluff", node = 22 },"#,
	);
	for setup in [r#"Polestar.Set("nav.travel", false)"#, r#"Polestar.Set("nav.arrow", false)"#, "TOMTOM = true", "Polestar.Nav.HandedOff = function() return true end"] {
		let out = run(
			&guides,
			&format!(
				r#"
				KNOWN[22] = true
				{setup}
				E.SetGuide("test/mixed-flight"); flush()
				local wp = E.GetWaypoint()
				emit({{ wp and wp.kind or false, wp and wp.goalIndex or false, wp and wp.map or false }})
				"#
			),
		);
		assert_eq!(out, json!(["goto", 1, 1442]), "{setup}: {out}");
	}
}

#[test]
fn a_walk_to_the_flight_master_passes_and_the_flight_step_leads_to_its_end_so_the_route_flies_there_directly_1191() {
	let out = run(
		ASHENVALE,
		r#"
		stub.world.complete({ 1093 })
		E.SetGuide("test/ashenvale"); flush()
		local function at()
			local wp = E.GetWaypoint()
			return { E.GetStepIndex(), wp and wp.map, wp and wp.goalIndex, wp and wp.kind }
		end
		emit(at())
		"#,
	);
	let off = |setup: &str| {
		run(
			ASHENVALE,
			&format!(
				r#"
				stub.world.complete({{ 1093 }})
				{setup}
				E.SetGuide("test/ashenvale"); flush()
				local wp = E.GetWaypoint()
				emit({{ E.GetStepIndex(), wp and wp.map, wp and wp.goalIndex, wp and wp.kind }})
				"#
			),
		)
	};
	let out = json!({
		"on": out,
		"off": off(r#"Polestar.Set("nav.travel", false)"#),
		"tomtom": off("TOMTOM = true"),
		"unknownEnd": off("KNOWN[26] = nil"),
	});
	assert_eq!(
		out,
		json!({
			// The walk to Astranaar passes; the flight leads to Auberdine, for the route to fly there from Stonetalon Peak.
			"on": [3, 1439, 2, "fly"],
			// The planner off: the steps as written.
			"off": [2, 1440, 1, "goto"],
			// TomTom's arrow gets the target alone, no route legs: the steps as written.
			"tomtom": [2, 1440, 1, "goto"],
			// Auberdine unknown: no flight there to plan, the steps as written.
			"unknownEnd": [2, 1440, 1, "goto"],
		})
	);
}

// The reporter's guess (#1191): the work at the stop in between is done already (here Astranaar's hand-in),
// yet the guide flew there first and on to Auberdine after.
const HUB: &str = r#"
Polestar.RegisterGuide({ id = "test/hub", pack = "test", title = "Hub", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fly to Astranaar", goals = {
		{ t = "goto", map = 1442, x = 36.4, y = 7.2, text = "Stonetalon Peak flight master" },
		{ t = "fly", location = "Astranaar", node = 28 },
	} },
	{ title = "Astranaar", goals = { { t = "turnin", quest = 1008, title = "The Zoram Strand", npc = 3880, map = 1440, x = 34.7, y = 48.8 } } },
	{ title = "Astranaar", only = { classes = { "DRUID" } }, goals = { { t = "train", npc = 3602 } } },
	{ title = "Fly to Auberdine", goals = {
		{ t = "goto", map = 1440, x = 34.5, y = 48.0, text = "Astranaar flight master" },
		{ t = "fly", location = "Auberdine", node = 26 },
	} },
	{ title = "Auberdine", goals = { { t = "accept", quest = 963, title = "For Love Eternal", npc = 3693, map = 1439, x = 37.5, y = 41.9 } } },
} })
"#;

#[test]
fn a_flight_to_a_stop_whose_work_is_done_or_for_other_classes_passes_and_the_next_flight_leads_1191() {
	let out = run(
		HUB,
		r#"
		local w = stub.world
		w.onQuest(1008, { { required = 1, fulfilled = 1 } })
		E.SetGuide("test/hub"); flush()
		local function at()
			local wp = E.GetWaypoint()
			return { E.GetStepIndex(), wp and wp.map, wp and wp.kind }
		end
		local r = { open = at() }
		w.turnIn(1008); flush()
		r.done = at()
		emit(r)
		"#,
	);
	assert_eq!(
		out,
		json!({
			// A hand-in left at Astranaar: the flight there leads (its end, Astranaar).
			"open": [1, 1440, "fly"],
			// Handed in elsewhere, and the Druid's training is not for a Warrior: the route flies on to Auberdine.
			"done": [4, 1439, "fly"],
		})
	);
}

// #1212: the Earthen Ring from Zoram'gar Outpost. The guide flies Orcs, Trolls and Undead to Camp Taurajo and
// walks them through Mulgore; one who knows Thunder Bluff gets there sooner by the flight to Thunder Bluff.
const EARTHEN: &str = r#"
Polestar.RegisterGuide({ id = "test/earthen", pack = "test", title = "Earthen Ring", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fly to Camp Taurajo", goals = {
		{ t = "goto", map = 1440, x = 12.2, y = 33.8, text = "Zoram'gar Outpost flight master" },
		{ t = "fly", location = "Camp Taurajo", node = 77 },
	} },
	{ title = "Mulgore", goals = { { t = "goto", map = 1412, x = 40.6, y = 22.2, text = "Mulgore" } } },
	{ title = "Gloomrise", goals = { { t = "kill", target = "Gloomrise Spinner", npc = 264083, count = 5, quest = 96259, oi = 1, map = 1412, x = 32.5, y = 20.6 } } },
} })
"#;

#[test]
fn a_flight_step_passes_when_the_planner_reaches_the_work_after_it_clearly_sooner_without_landing_there_1212() {
	let out = run(
		EARTHEN,
		r#"
		local w = stub.world
		w.onQuest(96259, { { required = 5, fulfilled = 0 } })
		w.moveTo(1440, 12, 34)
		KNOWN = { [77] = true, [22] = true }
		-- Straight to the Earthen Ring (by Thunder Bluff) 300 s; to Camp Taurajo 200 s and on from there 400 s.
		EST = function(from, to)
			if from == nil then return to.id == 77 and 200 or (TB and 300 or 580) end
			return 400
		end
		TB = true
		local function at()
			local wp = E.GetWaypoint()
			return { E.GetStepIndex(), wp and wp.map, wp and wp.kind }
		end
		E.SetGuide("test/earthen"); flush()
		local r = { knowsBluff = at(), estimates = ESTIMATES }
		-- Judged once: moving about plans nothing more.
		w.moveTo(1440, 13, 34); flush()
		r.again = ESTIMATES
		emit(r)
		"#,
	);
	assert_eq!(out, json!({ "knowsBluff": [3, 1412, "kill"], "estimates": 3, "again": 3 }));

	let held = run(
		EARTHEN,
		r#"
		stub.world.onQuest(96259, { { required = 5, fulfilled = 0 } })
		stub.world.moveTo(1440, 12, 34)
		KNOWN = { [77] = true }
		-- Without Thunder Bluff the straight way is no clear gain (580 against 600): the flight stays.
		EST = function(from, to)
			if from == nil then return to.id == 77 and 200 or 580 end
			return 400
		end
		E.SetGuide("test/earthen"); flush()
		local wp = E.GetWaypoint()
		emit({ E.GetStepIndex(), wp.map, wp.kind })
		"#,
	);
	assert_eq!(held, json!([1, 1412, "fly"]));
}

#[test]
fn a_flight_step_reached_on_a_taxi_is_not_judged_and_the_planner_off_keeps_every_step() {
	let out = run(
		EARTHEN,
		r#"
		local w = stub.world
		w.onQuest(96259, { { required = 5, fulfilled = 0 } })
		KNOWN = { [77] = true, [22] = true }
		EST = function(from, to) if from == nil then return to.id == 77 and 200 or 300 end return 400 end
		w.onTaxi = true
		E.SetGuide("test/earthen"); flush()
		local r = { taxi = { E.GetStepIndex(), ESTIMATES } }
		emit(r)
		"#,
	);
	assert_eq!(out, json!({ "taxi": [1, 0] }));

	let off = run(
		EARTHEN,
		r#"
		stub.world.onQuest(96259, { { required = 5, fulfilled = 0 } })
		KNOWN = { [77] = true, [22] = true }
		EST = function(from, to) if from == nil then return to.id == 77 and 200 or 300 end return 400 end
		Polestar.Set("nav.travel", false)
		E.SetGuide("test/earthen"); flush()
		local wp = E.GetWaypoint()
		emit({ E.GetStepIndex(), wp.map, wp.kind, ESTIMATES })
		"#,
	);
	assert_eq!(off, json!([1, 1440, "goto", 0]));
}

// A player who loaded a new guide mid-level was sent to Stormwind's flight master to "Fly to Menethil Harbor",
// a flight path they had never learned. With the planner on, a flight to a landing the character does not know
// leads to the landing as travel: the arrow aims at Menethil's flight master and reads "Go to", for the route to
// walk, sail or take the flights the character knows, and the goal is done on arriving there (a goto's radius) or
// once that flight path is learned. A known landing leads as before.
const MENETHIL: &str = r#"
stub.world.addMap(1453, { name = "Stormwind City", c = 0, left = 3000, right = -1000, top = -1000, bottom = -4000 })
Polestar.RegisterGuide({ id = "test/menethil", pack = "test", title = "Wetlands", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fly to Menethil Harbor", goals = {
		{ t = "goto", map = 1453, x = 66.3, y = 62.1, text = "Stormwind flight master" },
		{ t = "fly", location = "Menethil Harbor", node = 7 },
	} },
	{ title = "Menethil Harbor", goals = { { t = "getfp", location = "Menethil Harbor", node = 7, map = 1437, x = 9.5, y = 59.7 } } },
} })
"#;

const MENETHIL_NAV: &str = r#"
-- Taxi nodes sit on the Era map frames (f = "e"), as Nav/Travel.lua's data does: the same bounds here.
Polestar.RegisterMapFrames({ era = {
	[1437] = { c = 0, left = 3000, right = -1000, top = 3000, bottom = 0 },
	[1453] = { c = 0, left = 3000, right = -1000, top = -1000, bottom = -4000 },
} })
NODES[2] = { id = 2, name = "Stormwind, Elwynn", c = 0, map = 1453, x = 66.3, y = 62.1, f = "e" }
NODES[7] = { id = 7, name = "Menethil Harbor, Wetlands", c = 0, map = 1437, x = 9.5, y = 59.7, f = "e" }
stub.world.moveTo(1453, 60, 70)
local function at()
	local wp = E.GetWaypoint()
	return { E.GetStepIndex(), wp and wp.map or false, wp and wp.kind or false, wp and wp.label or false }
end
"#;

#[test]
fn a_flight_to_a_landing_the_character_never_learned_leads_there_as_travel_and_is_done_on_arrival_or_once_learned() {
	let out = run(
		MENETHIL,
		&format!(
			r#"{MENETHIL_NAV}
			KNOWN = {{ [2] = true }}
			E.SetGuide("test/menethil"); flush()
			local r = {{ unknown = at() }}
			-- On the way, still short of the landing (arrivals are polled every half second).
			stub.world.moveTo(1437, 30, 50); stub.advance(1)
			r.onTheWay = at()
			stub.world.moveTo(1437, 9.5, 59.7); stub.advance(1)
			r.arrived = at()
			emit(r)
			"#
		),
	);
	assert_eq!(
		out,
		json!({
			// Menethil Harbor unknown: the arrow leads to its flight master as travel, not to Stormwind's.
			"unknown": [1, 1437, "fly", "Go to Menethil Harbor"],
			"onTheWay": [1, 1437, "fly", "Go to Menethil Harbor"],
			// Arrived at the landing: the step is done, on to the flight path there.
			"arrived": [2, 1437, "getfp", "Get the flight path at Menethil Harbor"],
		})
	);

	let learned = run(
		MENETHIL,
		&format!(
			r#"{MENETHIL_NAV}
			KNOWN = {{ [2] = true }}
			E.SetGuide("test/menethil"); flush()
			-- Learned by talking to a flight master short of the landing's radius: the flight map opens.
			stub.world.moveTo(1437, 10.5, 59.7)
			KNOWN[7] = true
			stub.fire("TAXIMAP_OPENED"); flush()
			emit(E.GetStepIndex())
			"#
		),
	);
	assert_eq!(learned, json!(2), "the flight path learned: the travel is behind the player");

	let known = run(
		MENETHIL,
		&format!(
			r#"{MENETHIL_NAV}
			KNOWN = {{ [2] = true, [7] = true }}
			E.SetGuide("test/menethil"); flush()
			emit(at())
			"#
		),
	);
	let off = run(
		MENETHIL,
		&format!(
			r#"{MENETHIL_NAV}
			KNOWN = {{ [2] = true }}
			Polestar.Set("nav.travel", false)
			E.SetGuide("test/menethil"); flush()
			emit(at())
			"#
		),
	);
	assert_eq!(
		json!({ "known": known, "off": off }),
		json!({
			// A known landing: the flight leads to its end, as before.
			"known": [1, 1437, "fly", "Fly to Menethil Harbor"],
			// The planner off: the steps as written, the walk to Stormwind's flight master, unknown landing or not.
			"off": [1, 1453, "goto", "Go to Stormwind flight master"],
		})
	);
}

// 0.3.5's Wetlands "Fly to Astranaar" for a player whose Darkshore work around it was skipped: the step is only the
// walk to Auberdine's flight master and the flight. Flying to Astranaar from another flight master (here Stonetalon
// Peak), or getting there any other way when Astranaar is unknown, finishes the whole step, the walk to Auberdine's
// flight master included.
const ASTRANAAR: &str = r#"
Polestar.RegisterMapFrames({ era = { [1440] = { c = 1, left = 3000, right = -1000, top = 3000, bottom = 0 } } })
Polestar.RegisterGuide({ id = "test/astranaar", pack = "test", title = "Wetlands", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fly to Astranaar", goals = {
		{ t = "goto", map = 1439, x = 36.3, y = 45.6, text = "Auberdine flight master" },
		{ t = "fly", location = "Astranaar", node = 28 },
	} },
	{ title = "Astranaar", goals = { { t = "accept", quest = 1008, title = "The Zoram Strand", npc = 3880, map = 1440, x = 34.7, y = 48.8 } } },
} })
"#;

#[test]
fn a_flight_step_reached_by_another_way_is_done_whole_its_walk_to_the_named_flight_master_included() {
	let trip = |known: &str, land: &str| {
		run(
			ASTRANAAR,
			&format!(
				r#"
				KNOWN = {known}
				E.SetGuide("test/astranaar"); flush()
				local wp = E.GetWaypoint()
				local r = {{ lead = {{ E.GetStepIndex(), wp and wp.map or false, wp and wp.kind or false }} }}
				{land}
				local v = E.GetStepView(1)
				r.landed = {{ E.GetStepIndex(), v.goals[1].status, v.goals[2].status }}
				emit(r)
				"#
			),
		)
	};
	// Astranaar known: flown there from Stonetalon Peak; the client names the subzone on landing.
	let known = trip("{ [26] = true, [28] = true, [33] = true }", r#"stub.world.moveTo(1440, 34.4, 48.0); stub.world.setZone("Ashenvale", "Astranaar"); stub.fire("ZONE_CHANGED"); stub.advance(1)"#);
	// Astranaar unknown: walked there; arriving at its flight master is enough.
	let unknown = trip("{ [26] = true, [33] = true }", "stub.world.moveTo(1440, 34.4, 48.0); stub.advance(1)");
	assert_eq!(
		json!({ "known": known, "unknown": unknown }),
		json!({
			"known": { "lead": [1, 1440, "fly"], "landed": [2, "done", "done"] },
			"unknown": { "lead": [1, 1440, "fly"], "landed": [2, "done", "done"] },
		})
	);
}

// #1530 (Horde 30-40 Hillsbrad's opening "Fly to the Crossroads"): the player landed, the arrow said "Fly to
// Crossroads · 5 yd", and the step waited for a tick. The goal names "Crossroads" with no area (none is called
// that; the client's subzone text is "The Crossroads"), so the zone text never matched, and only an unknown
// landing arrived by its flight master. 37 such flights in 24 guides: Crossroads, Stormwind ("Stormwind City"),
// Grom'gol ("Grom'gol Base Camp"), Theramore ("Theramore Isle"), Feathermoon, Bloodvenom Post. Now any flight
// with a landing node arrives at its flight master, off the taxi.
const CROSSROADS: &str = r#"
stub.world.addMap(1413, { name = "The Barrens", c = 1, left = 3000, right = -1000, top = -1000, bottom = -5000 })
Polestar.RegisterGuide({ id = "test/crossroads", pack = "test", title = "Hillsbrad", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fly to the Crossroads", goals = {
		{ t = "goto", map = 1442, x = 36.4, y = 7.2, text = "Stonetalon Peak flight master" },
		{ t = "fly", location = "Crossroads", node = 25 },
	} },
	{ title = "Orgrimmar", goals = { { t = "accept", quest = 1008, title = "Quest", npc = 3880, map = 1413, x = 52, y = 31 } } },
} })
"#;

#[test]
fn a_flight_to_a_known_landing_the_zone_text_names_otherwise_is_done_on_landing_1530() {
	let out = run(
		CROSSROADS,
		r#"
		Polestar.RegisterMapFrames({ era = { [1413] = { c = 1, left = 3000, right = -1000, top = -1000, bottom = -5000 } } })
		NODES[25] = { id = 25, name = "Crossroads, The Barrens", c = 1, map = 1413, x = 51.5, y = 30.3, f = "e" }
		KNOWN = { [25] = true, [33] = true }
		E.SetGuide("test/crossroads"); flush()
		local r = { before = E.GetStepIndex() }
		-- Landed beside the Crossroads' flight master; the client names the subzone "The Crossroads".
		stub.world.moveTo(1413, 51.6, 30.4); stub.world.setZone("The Barrens", "The Crossroads"); stub.fire("ZONE_CHANGED"); stub.advance(1)
		local v = E.GetStepView(1)
		r.landed = { E.GetStepIndex(), v.goals[1].status, v.goals[2].status }
		emit(r)
		"#,
	);
	assert_eq!(out, json!({ "before": 1, "landed": [2, "done", "done"] }));
}

// #1768 (and #1596): Ashenvale & Thousand Needles after the Earthen Ring, for a character who knows Thunder Bluff's
// flight path and has nothing else in Thunder Bluff. The walk up to its central rise passed because the flight to
// Camp Taurajo follows (Own.flightOn), and nothing latched it; on landing in Camp Taurajo the flight read done, the
// next open step was the work south of the camp, so the walk was open again and the arrow sent the player back up to
// Thunder Bluff, where the flight to Camp Taurajo (never latched: it was no longer the live step when it landed) was
// open again: Camp Taurajo, Thunder Bluff, Camp Taurajo. The same for a walk straight before a flight (Alliance
// Arathi Highlands 30-40: "Duskwood", then "Fly to Stormwind", open again on landing in Stormwind). A travel step the
// route passes for the planner's flight now stays passed.
const TAURAJO: &str = r#"
Polestar.RegisterMapFrames({ era = { [1412] = { c = 1, left = 3000, right = -1000, top = -3000, bottom = -6000 } } })
Polestar.RegisterGuide({ id = "test/taurajo", pack = "test", title = "Ashenvale & Thousand Needles", minLevel = 1, maxLevel = 60, steps = {
	{ title = "The Earthen Ring", goals = { { t = "turnin", quest = 96259, title = "Defending the Dead", npc = 259118, map = 1412, x = 33.4, y = 22.5 } } },
	{ title = "Thunder Bluff", goals = { { t = "goto", map = 1412, x = 47.0, y = 49.8, text = "Thunder Bluff's central rise" } } },
	{ title = "Thunder Bluff", goals = { { t = "getfp", location = "Thunder Bluff", node = 22, map = 1412, x = 47, y = 50 } } },
	{ title = "Fly to Camp Taurajo", goals = {
		{ t = "goto", map = 1412, x = 47, y = 50, text = "Thunder Bluff flight master" },
		{ t = "fly", location = "Camp Taurajo", node = 77 },
	} },
	{ title = "Tear of the Moons", goals = { { t = "accept", quest = 857, title = "The Tear of the Moons", npc = 3421, map = 1412, x = 90, y = 80 } } },
} })
"#;

const STRAIGHT: &str = r#"
Polestar.RegisterMapFrames({ era = { [1412] = { c = 1, left = 3000, right = -1000, top = -3000, bottom = -6000 } } })
Polestar.RegisterGuide({ id = "test/straight", pack = "test", title = "Arathi Highlands", minLevel = 1, maxLevel = 60, steps = {
	{ title = "The Earthen Ring", goals = { { t = "turnin", quest = 96259, title = "Defending the Dead", npc = 259118, map = 1412, x = 33.4, y = 22.5 } } },
	{ title = "Bloodhoof Village", goals = { { t = "goto", map = 1412, x = 47.0, y = 60.0, text = "Bloodhoof Village" } } },
	{ title = "Fly to Camp Taurajo", goals = { { t = "fly", location = "Camp Taurajo", node = 77 } } },
	{ title = "Tear of the Moons", goals = { { t = "accept", quest = 857, title = "The Tear of the Moons", npc = 3421, map = 1412, x = 90, y = 80 } } },
} })
"#;

#[test]
fn a_travel_step_passed_for_the_planners_flight_stays_passed_once_that_flight_lands_1768() {
	let trip = |guide: &str, id: &str| {
		run(
			guide,
			&format!(
				r#"
				local w = stub.world
				w.complete({{ 96259 }})
				w.moveTo(1412, 33.4, 22.5)
				KNOWN = {{ [22] = true, [77] = true }}
				Polestar.CharState().flags.taxi = {{ [22] = true, [77] = true }}
				E.SetGuide("{id}"); flush()
				local r = {{ before = E.GetStepIndex() }}
				-- Landed beside Camp Taurajo's flight master.
				w.moveTo(1412, 90, 50); w.setZone("The Barrens", "Camp Taurajo"); stub.fire("ZONE_CHANGED"); stub.advance(1)
				r.landed = E.GetStepIndex()
				-- On south to the work, out of the camp's subzone.
				w.moveTo(1412, 90, 70); w.setZone("The Barrens", ""); stub.fire("ZONE_CHANGED"); stub.advance(1)
				r.on = E.GetStepIndex()
				emit(r)
				"#
			),
		)
	};
	assert_eq!(
		json!({ "taurajo": trip(TAURAJO, "test/taurajo"), "straight": trip(STRAIGHT, "test/straight") }),
		json!({
			// The walk up to Thunder Bluff passes for the flight; landed, the work south of the camp leads, and stays.
			"taurajo": { "before": 4, "landed": 5, "on": 5 },
			// A walk straight before the flight: the same.
			"straight": { "before": 3, "landed": 4, "on": 4 },
		})
	);
}

// The report's trip on the real addon (TravelData's taxi nodes through Nav.GetTaxiNode, the known ones through
// Nav.GetKnownTaxiNodes, the client's map frames): 0.3.4's Ashenvale after Webwinder Path in Stonetalon, a walk to
// Astranaar's flight master and the flight to Auberdine. A Night Elf who knows Stonetalon Peak, Astranaar and
// Auberdine was routed by air to Astranaar first and flew on from there; now the walk passes and the arrow's target is
// Auberdine's flight master, which Stonetalon Peak reaches in one flight (Travel's multi-hop flights: travel.rs).
#[test]
fn on_the_real_addon_the_reported_stonetalon_trip_leads_to_auberdine_not_astranaar_1191() {
	let data_dir = root().join("data/forever");
	if !data_dir.join("map-frames.json").exists() {
		eprintln!("skipped: no reference data at data/forever");
		return;
	}
	let data = forge_guide::data::load_data(&data_dir).expect("data/forever");
	let mut maps = String::new();
	for era in ["forever", "era"] {
		for (id, f) in data.map_frames.get(era).as_obj().map(|o| o.entries()).unwrap_or_default() {
			let name = data.zones.get(&id).get("name").to_js_string();
			maps.push_str(&format!(
				"w.addMap({id}, {{ name = {}, c = {}, left = {}, right = {}, top = {}, bottom = {} }})\n",
				serde_json::to_string(if name == "undefined" { "" } else { &name }).unwrap(),
				f.get("c").to_js_string(),
				f.get("left").to_js_string(),
				f.get("right").to_js_string(),
				f.get("top").to_js_string(),
				f.get("bottom").to_js_string()
			));
		}
	}
	let before = format!("local w = stub.world\n{maps}w.race, w.raceName, w.faction = \"NightElf\", \"Night Elf\", \"Alliance\"\nw.level = 26\nw.moveTo(1442, 59.0, 67.0)\n");
	let script = format!(
		r#"{TEST_PACK}
{TEST_SOURCE}
{ASHENVALE}
E = Polestar.Engine
stub.login()
stub.fire("QUEST_LOG_UPDATE")
Polestar.CharState().flags.taxi = {{ [26] = true, [27] = true, [28] = true, [33] = true }}
stub.world.complete({{ 1093 }})
E.SetGuide("test/ashenvale")
stub.advance(1)
local wp = E.GetWaypoint()
local node = Polestar.Nav.GetTaxiNode(26)
local out = {{ step = E.GetStepIndex(), kind = wp and wp.kind or false, map = wp and wp.map or false, atNode = wp ~= nil and wp.x == node.x and wp.y == node.y and Polestar.Nav.GetTarget() ~= nil }}
emit(out)"#
	);
	let out = emitted(&RunAddon { stubs: vec!["stub_world.lua"], before, addons: vec![Addon::name("Polestar")], script, ..Default::default() }).remove(0);
	assert_eq!(out, json!({ "step": 3, "kind": "fly", "map": 1439, "atNode": true }), "the walk passes; the arrow leads to Auberdine's flight master");
}

// #1588 (Fitz, 2026-11-10): "Fly to Camp Taurajo" read as a flight for no reason; its work was Feegly the Exiled and
// the Great Lift, south of the camp. A travel step's flight (the step's last open fly or goto goal, after the walk
// to its flight master) says what it leads to: the first step after it with open quest work for the character,
// travel steps between passed over (the Great Lift's walk, a done step), at most six steps on.
const PURPOSE: &str = r#"
local function guide(id, steps) Polestar.RegisterGuide({ id = id, pack = "test", title = id, minLevel = 1, maxLevel = 60, steps = steps }) end
local FLY = { title = "Fly to Camp Taurajo", goals = {
	{ t = "goto", map = 1412, x = 47, y = 50, text = "Thunder Bluff flight master" },
	{ t = "fly", location = "Camp Taurajo", node = 77 },
} }
local WALK = { title = "South", goals = { { t = "goto", map = 1412, x = 90, y = 70, text = "South of the camp" } } }
local FEEGLY = { title = "Feegly", goals = { { t = "accept", quest = 9001, title = "The Tear of the Moons", npc = 4521, npcName = "Feegly the Exiled", map = 1412, x = 90, y = 80 } } }
local DONE = { title = "Done", goals = { { t = "turnin", quest = 9009, title = "Old", npc = 4600, npcName = "Old Friend", map = 1412, x = 90, y = 60 } } }
local TWO = { title = "Ratchet", goals = {
	{ t = "turnin", quest = 9002, title = "Wharf Work", npc = 3453, npcName = "Wharfmaster Dizzywig", map = 1412, x = 91, y = 80 },
	{ t = "accept", quest = 9003, title = "Goblin Work", npc = 3442, npcName = "Sputtervalve", map = 1412, x = 91, y = 81 },
	{ t = "accept", quest = 9004, title = "More Goblin Work", npc = 3442, npcName = "Sputtervalve", map = 1412, x = 91, y = 81 },
} }
local ONE = { title = "Sputtervalve", goals = {
	{ t = "turnin", quest = 9002, title = "Wharf Work", npc = 3442, npcName = "Sputtervalve", map = 1412, x = 91, y = 81 },
	{ t = "accept", quest = 9003, title = "Goblin Work", npc = 3442, npcName = "Sputtervalve", map = 1412, x = 91, y = 81 },
} }
local KILL = { title = "Bael Modan", goals = { { t = "kill", target = "Bael'dun Digger", npc = 2989, count = 8, quest = 9005, title = "Diggers", oi = 1, map = 1412, x = 85, y = 85 } } }
guide("test/feegly", { FLY, WALK, FEEGLY })
guide("test/done", { FLY, DONE, WALK, FEEGLY })
guide("test/two", { FLY, TWO })
guide("test/one", { FLY, ONE })
guide("test/kill", { FLY, KILL })
guide("test/far", { FLY, WALK, WALK, WALK, WALK, WALK, WALK, FEEGLY })
guide("test/none", { FLY })
stub.world.onQuest(9005, { { required = 8, fulfilled = 0 } }, "Diggers")
stub.world.onQuest(9002, { { required = 1, fulfilled = 1 } }, "Wharf Work")
stub.world.complete({ 9009 })
-- Each fly step goal's purpose line (its view's `purposeText`), on the live step and on a later one.
function purposes(id)
	E.SetGuide(id); flush()
	local v = E.GetStepView(1)
	return { v.goals[1].purposeText or false, v.goals[2].purposeText or false }
end
"#;

#[test]
fn a_travel_step_says_what_its_flight_is_for_1588() {
	let out = run(
		PURPOSE,
		r#"
		emit({
			feegly = purposes("test/feegly"), done = purposes("test/done"), two = purposes("test/two"), one = purposes("test/one"),
			kill = purposes("test/kill"), far = purposes("test/far"), none = purposes("test/none"),
		})
		"#,
	);
	assert_eq!(
		out,
		json!({
			"feegly": [false, "For Feegly the Exiled's quests"],
			"done": [false, "For Feegly the Exiled's quests"],
			"two": [false, "For quests from Wharfmaster Dizzywig and Sputtervalve"],
			"one": [false, "For Sputtervalve's quests"],
			"kill": [false, "For \u{201c}Diggers\u{201d}"],
			"far": [false, false],
			"none": [false, false],
		}),
		"the walk to the flight master says nothing; the flight names the work after it"
	);
}

// A step with quest work of its own says nothing more, nor does a travel step looked at ahead of the live one.
#[test]
fn a_step_with_work_of_its_own_or_one_looked_at_ahead_has_no_purpose_line() {
	let out = run(
		PURPOSE,
		r#"
		guide("test/work", { FEEGLY, FLY, ONE })
		E.SetGuide("test/work"); flush()
		local live = E.GetStepView(1)
		local ahead = E.GetStepView(2)
		emit({ live = live.goals[1].purposeText or false, ahead = ahead.goals[2].purposeText or false })
		"#,
	);
	assert_eq!(out, json!({ "live": false, "ahead": false }));
}

// #1756 (Konky88, 0.3.6, Troll Shaman 33, TomTom's arrow): Thousand Needles' "Fly to Freewind Post" leads to
// Ratchet's flight master, where the route expected the player after Islen Waterseer. He stood in Mulgore, 1,100
// yd from Thunder Bluff's flight master, knowing Freewind Post. With TomTom's arrow leading (the planner's flight
// handling is Polestar's own arrow's) the step still holds as written, but its arrow leads to the nearest flight
// master the character knows when it is clearly nearer than the named one; the landing still finishes the step.
// Near the named flight master, or with the landing not known, the step leads there as before.
const FREEWIND: &str = r#"
Polestar.RegisterGuide({ id = "test/needles", pack = "test", title = "Thousand Needles", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Fly to Freewind Post", goals = {
		{ t = "goto", map = 1442, x = 90, y = 50, text = "Ratchet flight master" },
		{ t = "fly", location = "Freewind Post", node = 30 },
	} },
	{ title = "Freewind Post", goals = { { t = "goto", map = 1412, x = 10, y = 90, text = "Freewind Post" } } },
} })
"#;

#[test]
fn a_flight_step_off_the_planner_leads_to_a_clearly_nearer_known_flight_master_not_the_named_one_1756() {
	let out = run(
		FREEWIND,
		r#"
		local w = stub.world
		-- (This world's maps are live frames only: the nodes here too.)
		NODES[30] = { id = 30, name = "Freewind Post, Thousand Needles", c = 1, map = 1412, x = 10, y = 90 }
		NODES[22] = { id = 22, name = "Thunder Bluff, Mulgore", c = 1, map = 1412, x = 47, y = 50 }
		local r = {}
		local function aim()
			local wp = E.GetWaypoint()
			return { E.GetStepIndex(), wp and wp.map, wp and wp.x, wp and wp.kind, wp and wp.label }
		end
		-- TomTom's arrow leads (no planner), in Mulgore beside Thunder Bluff, knowing Thunder Bluff and Freewind Post.
		TOMTOM = true
		KNOWN = { [22] = true, [30] = true }
		w.moveTo(1412, 50, 50)
		E.SetGuide("test/needles"); flush()
		r.mulgore = aim()
		-- Beside the named flight master: it leads there.
		w.moveTo(1442, 88, 50); stub.fire("QUEST_LOG_UPDATE"); flush()
		r.named = aim()
		-- Freewind Post not learned yet: the step holds as written.
		KNOWN = { [22] = true }
		w.moveTo(1412, 50, 50); stub.fire("QUEST_LOG_UPDATE"); flush()
		r.unknown = aim()
		emit(r)
		"#,
	);
	assert_eq!(out["mulgore"], json!([1, 1412, 47, "goto", "Walk to the flight master"]), "Thunder Bluff's flight master: {out}");
	assert_eq!(out["named"][1], 1442, "near the named flight master it leads there: {out}");
	assert_eq!(out["unknown"][1], 1442, "a landing not known keeps the step as written: {out}");
}
