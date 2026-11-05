//! Zone crossings in the travel planner (addon/Polestar/Nav/Travel.lua, Nav.RegisterCrossings): routes between
//! zones go through crossing waypoints, captions follow the direction, open-ground pairs walk straight, approach
//! chains are entered at their mouth, and the re-plan triggers. Runs the real Core/Init.lua + Nav/Nav.xml
//! against tests/lua/stub_nav.lua's travel world.
//!
//! Map 9000 "Testshire" (wx, wy 1000..-1000) is split into two zones here: West Vale (9002, wy 1000..0) and
//! East Vale (9003, wy 0..-1000), joined by a gate at (600, +-20).

use forge_addontest::{emitted, lua_value, Addon, RunAddon};
use serde_json::{json, Value};

fn nav() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])
}

const PRELUDE: &str = r#"
local N = Polestar.Nav
local A = N.arrow
local nav = stub.nav
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "Target")
end
local function route()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci or 1, legs and #legs or 0 do
		local l = legs[i]
		out[#out + 1] = l.kind .. "|" .. l.label
	end
	return out
end
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
local ZONES = {
	[9002] = { name = "West Vale", c = 0, top = 1000, bottom = -1000, left = 1000, right = 0 },
	[9003] = { name = "East Vale", c = 0, top = 1000, bottom = -1000, left = 0, right = -1000 },
}
local GATE = { id = "gate", a = { map = 9002, c = 0, wx = 600, wy = 20, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -20, r = 15 },
	ab = "Through the gate to East Vale" }
local function crossings(extra)
	local d = { complete = true, zones = ZONES, crossings = { GATE } }
	for k, v in pairs(extra or {}) do d[k] = v end
	N.RegisterCrossings(d)
end
"#;

fn run_raw(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_nav.lua"], addons: vec![nav()], login: true, script: script.to_string(), ..Default::default() }).remove(0)
}

fn run(script: &str) -> Value {
	run_raw(&format!("{PRELUDE}\nnav.faction = \"Alliance\"\nnav.useTravelWorld()\n{script}"))
}

#[test]
fn a_route_into_another_zone_goes_through_the_crossing_not_a_straight_line_no_crossing_data_walks_as_before() {
	let out = run(r#"
		local r = {}
		nav.place(-500, 500)                             -- West Vale
		target(-500, -500, "Kobolds")                    -- East Vale
		r.before = route()
		crossings()
		target(-500, -500, "Kobolds")
		r.after = route()
		local legs = N.GetRoute()
		r.first = { legs[1].to.wx, legs[1].to.wy, legs[1].to.map, legs[1].radius, legs[1].waypoint }
		r.second = { legs[2].to.wx, legs[2].to.wy, legs[2].to.map }
		r.total = legs[1].seconds + legs[1].rest
		emit(r)"#);
	assert_eq!(out["before"], json!(["walk|Kobolds"]), "without crossing data: one straight walk");
	assert_eq!(out["after"], json!(["walk|Through the gate to East Vale", "walk|Through the gate to East Vale", "walk|Kobolds"]));
	assert_eq!(out["first"], json!([600, 20, 9002, 15, true]), "the gate on the West Vale side, with its radius");
	assert_eq!(out["second"], json!([600, -20, 9003]));
	let yards = 1100f64.hypot(480.0) * 2.0 + 40.0;
	let total = out["total"].as_f64().unwrap();
	assert!((total - (yards * 1.25) / 7.0).abs() < 3.0, "real seconds follow the walked line ({} s)", out["total"]);
}

#[test]
fn captions_follow_the_direction_a_crossing_without_one_says_where_it_goes() {
	let out = run(r#"
		crossings()
		nav.place(-500, -500)                            -- East Vale, heading west
		target(-500, 500)
		emit(route())"#);
	assert_eq!(out, json!(["walk|Go to West Vale", "walk|Go to West Vale", "walk|Target"]));
}

#[test]
fn an_open_ground_pair_walks_straight_across_the_border_a_one_way_pair_only_one_way() {
	let out = run(r#"
		local r = {}
		crossings({ open = { 9002, 9003, 0 } })
		nav.place(-500, 500)
		target(-500, -500)
		r.open = route()
		N.RegisterTravelData({}, true)
		nav.useTravelWorld()
		crossings({ open = { 9002, 9003, 1 } })          -- West -> East only
		nav.place(-500, 500)
		target(-500, -500)
		r.oneWayWith = route()
		nav.place(-500, -500)
		target(-500, 500)
		r.oneWayAgainst = route()
		emit(r)"#);
	assert_eq!(out["open"], json!(["walk|Target"]));
	assert_eq!(out["oneWayWith"], json!(["walk|Target"]));
	assert_eq!(out["oneWayAgainst"], json!(["walk|Go to West Vale", "walk|Go to West Vale", "walk|Target"]));
}

#[test]
fn an_approach_chain_is_entered_only_at_its_mouth_and_left_the_way_it_came() {
	let out = run(r#"
		local r = {}
		crossings({ chains = { { id = "den", name = "The Den", open = "mouth", nodes = {
			{ map = 9003, c = 0, wx = 0, wy = -300, r = 15, caption = "Enter the cave" },
			{ map = 9003, c = 0, wx = -100, wy = -300, r = 15, caption = "Follow the path" },
			{ map = 9003, c = 0, wx = -100, wy = -400, r = 15, caption = "Enter the Den" },
		} } } })
		nav.place(-100, -500)                            -- 90 yd from the target, but outside the cave
		target(-110, -410, "Den boss")                   -- inside, next to the last node
		r.into = route()
		local legs = N.GetRoute()
		r.firstTo = { legs[1].to.wx, legs[1].to.wy }
		nav.place(-105, -405)                            -- inside the cave
		target(300, -300, "Outside")
		r.out = route()
		nav.place(400, -700)                             -- an outside target is never reached through the cave
		target(300, -300, "Outside")
		r.outside = route()
		emit(r)"#);
	assert_eq!(out["into"], json!(["walk|Enter the cave", "walk|Follow the path", "walk|Den boss"]));
	assert_eq!(out["firstTo"], json!([0, -300]), "the first waypoint is the mouth");
	assert_eq!(out["out"], json!(["walk|Follow the path out", "walk|Follow the path out", "walk|Outside"]));
	assert_eq!(out["outside"], json!(["walk|Outside"]));
}

#[test]
fn a_crossings_ends_20_yd_or_more_apart_in_height_are_a_lift_its_walk_is_searched_and_a_walk_to_an_end_carries_its_height() {
	let leg = r#"
		nav.place(-500, 500)
		target(-500, -500, "Kobolds")
		local legs = N.GetRoute()
		emit({ { legs[1].to.z or false, legs[1].handmade or false }, { legs[2].to.z or false, legs[2].handmade or false, legs[2].crossing }, legs[3].handmade or false })"#;
	let lift = run(&format!(
		r#"
		N.RegisterCrossings({{ complete = true, zones = ZONES, crossings = {{
			{{ id = "lift", a = {{ map = 9002, c = 0, wx = 600, wy = 20, z = 10, r = 15 }}, b = {{ map = 9003, c = 0, wx = 600, wy = -20, z = 90, r = 15 }} }} }} }})
		{leg}"#
	));
	assert_eq!(lift, json!([[10, false], [90, false, "lift"], false]), "the walk to the near end, then the ride's walk searched, then the walk on from the far end");
	let gate = run(&format!("crossings()\n{leg}"));
	assert_eq!(gate, json!([[false, false], [false, true, "gate"], false]), "a gate without heights: laid out straight, as before; the walk on from it searched");
	let flat = run(&format!(
		r#"
		N.RegisterCrossings({{ complete = true, zones = ZONES, crossings = {{
			{{ id = "hall", a = {{ map = 9002, c = 0, wx = 600, wy = 20, z = 63, r = 15 }}, b = {{ map = 9003, c = 0, wx = 600, wy = -20, z = 60, r = 15 }} }} }} }})
		{leg}"#
	));
	assert_eq!(flat, json!([[63, false], [60, true, "hall"], false]), "heights on one floor: laid out straight, the walk to it ending on that floor");
}

#[test]
fn a_crossing_end_with_a_height_12_yd_away_is_already_walked_only_on_its_floor() {
	let legs = run(r#"
		N.RegisterCrossings({ complete = true, zones = ZONES, crossings = {
			{ id = "hall", a = { map = 9002, c = 0, wx = 600, wy = 20, z = 63, r = 30 }, b = { map = 9003, c = 0, wx = 600, wy = -20, z = 60, r = 30 } } } })
		local r = {}
		for _, f in ipairs({ { -43, 32 }, { false, 32 }, { 62, 32 }, { false, 23 } }) do
			Polestar.Nav.walk.Floor = function() return f[1] or nil end
			nav.place(600, f[2])
			target(-500, -500, "Kobolds")
			local l = N.GetRoute()
			r[#r + 1] = { #l, l[1].crossing or false }
		end
		emit(r)"#);
	assert_eq!(
		legs,
		json!([[3, false], [3, false], [2, "hall"], [2, "hall"]]),
		"below it or the floor unknown: the walk to the end, then the crossing; on its floor or right at it: the crossing's own walk"
	);
}

// The Undercity's fixed way in and out (Fitz, 2026-10-23): an approach chain both of whose ends are mouths, from the
// zone outside through the hall to its lift's top and bottom landings in the city. The hop between the two landings
// (floors 20 yd or more apart within 15 yd on the map) is a lift ride, both ways, timed by the lift's timetable.
#[test]
fn a_chain_hop_between_two_floors_is_a_lift_ride_and_a_start_in_the_chains_hall_is_held_by_it_only_on_its_floor() {
	let out = run(r#"
		N.RegisterCrossings({ complete = true, zones = ZONES, chains = { { id = "city", name = "City", open = "both", nodes = {
			{ map = 9002, c = 0, wx = 600, wy = 100, z = 60, r = 15 },
			{ map = 9003, c = 0, wx = 600, wy = -60, z = 63, r = 10 },
			{ map = 9003, c = 0, wx = 600, wy = -100, z = 55, r = 6 },
			{ map = 9003, c = 0, wx = 600, wy = -108, z = -41, r = 6 },
		} } } })
		Polestar.Transit = { LiftNear = function() return "lift-x" end, NextDeparture = function() return 12, 4 end }
		local function legs()
			local l, ci = N.GetRoute()
			local o = {}
			for i = ci, #l do o[#o + 1] = l[i].kind .. "|" .. l[i].label .. (l[i].kind == "lift" and ("|" .. l[i].side .. "|" .. l[i].lift .. "|" .. l[i].seconds) or "") end
			return o
		end
		local r = {}
		Polestar.Nav.walk.Floor = function() return -41 end
		nav.place(600, -400)
		target(600, 500, "Outside")
		r.out = legs()
		nav.place(600, 500)
		target(600, -400, "Inside")
		r.into = legs()
		Polestar.Nav.walk.Floor = function() return 62 end
		nav.place(600, -62)
		target(600, 500, "Outside")
		r.hall = legs()[1]
		Polestar.Nav.walk.Floor = function() return -41 end
		target(600, 499, "Outside")
		r.under = legs()[1]
		-- The floor unknown, the floors the player may be on known (Walk.Floors: the subzone's levels).
		Polestar.Nav.walk.Floor = function() return nil end
		Polestar.Nav.walk.Floors = function() return { 62, 100 } end
		target(600, 498, "Outside")
		r.upper = legs()[1]
		Polestar.Nav.walk.Floors = function() return { 16, -52 } end
		target(600, 497, "Outside")
		r.lower = legs()[1]
		emit(r)"#);
	assert_eq!(out["out"], json!(["walk|Walk to the lift", "lift|Ride the elevator up|bottom|lift-x|16", "walk|Follow the path out", "walk|Follow the path out", "walk|Outside"]));
	assert_eq!(out["into"], json!(["walk|Follow the path", "walk|Follow the path", "walk|Walk to the lift", "lift|Ride the elevator down|top|lift-x|16", "walk|Inside"]));
	assert_eq!(out["hall"], "walk|Follow the path", "in the hall, on its floor: on the chain, walked out along it");
	assert_eq!(out["under"], "walk|Walk to the lift", "under the hall, on the city's floor: to the lift first");
	assert_eq!(out["upper"], "walk|Follow the path", "floor unknown, but on the hall's level or above it: on the chain");
	assert_eq!(out["lower"], "walk|Walk to the lift", "floor unknown, a level below the hall possible: to the lift");
}

#[test]
fn a_crossing_set_that_is_not_complete_recorded_crossings_leaves_walking_as_before() {
	let out = run(r#"
		N.RegisterCrossings({ complete = false, zones = ZONES, crossings = { GATE } })
		nav.place(-500, 500)
		target(-500, -500)
		emit({ route(), #(Polestar.Nav.travel.CrossingCounts()) })"#);
	assert_eq!(out, json!([["walk|Target"], 0]));
}

#[test]
fn the_arrow_shows_the_leg_caption_aims_at_the_waypoint_advances_inside_its_radius_and_re_plans_there() {
	let out = run(r#"
		local r, changes, advanced = {}, 0, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		Polestar.On("ROUTE_ADVANCED", function() advanced = advanced + 1 end)
		crossings()
		nav.place(-500, 500)
		target(-500, -500, "Kobolds")
		stub.advance(0.2)
		r.walk = { A.GetMode(), A.distText:GetText(), A.labelText:GetText() }
		local before = changes
		nav.place(590, 30)                               -- 14 yd from the gate: inside its 15 yd radius
		stub.advance(0.2)
		r.advanced = advanced
		r.at = { A.distText:GetText(), A.labelText:GetText() }
		stub.advance(1.2)                                -- the ticker plans again from here
		r.replanned = changes - before
		r.route = route()
		nav.place(600, -40)                              -- through the gate, now in East Vale
		stub.fire("ZONE_CHANGED_NEW_AREA")
		r.zone = route()
		stub.advance(0.2)
		r.after = { A.labelText:GetText() }
		emit(r)"#);
	assert_eq!(out["walk"], json!(["travel", "1200 yd", "Through the gate to East Vale"]));
	assert_eq!(out["advanced"], 1);
	assert_eq!(out["at"], json!(["51 yd", "Through the gate to East Vale"]), "now aiming at the far side of the gate");
	assert_eq!(out["replanned"], 1, "arriving at a waypoint plans again");
	assert_eq!(out["route"], json!(["walk|Through the gate to East Vale", "walk|Kobolds"]));
	assert_eq!(out["zone"], json!(["walk|Kobolds"]), "a zone change plans again");
	assert_eq!(out["after"], json!(["Kobolds"]), "the last leg shows the target");
}

#[test]
fn moving_more_than_50_yd_re_plans_once_the_plan_is_30_s_old_at_most_once_a_second_and_only_with_crossing_data() {
	let out = run(r#"
		local r, changes = {}, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		local function walk(seconds)
			for _ = 1, seconds do
				local p = nav.player
				nav.place(p.wx + 5, p.wy - 1)
				stub.advance(1)
			end
		end
		nav.place(-500, 500)
		target(-500, -500)
		local c0 = changes
		walk(40)                                         -- 200 yd in 40 s, no crossing data
		r.plain = changes - c0
		crossings()
		nav.place(-500, 500)
		target(-500, -500)
		c0 = changes
		walk(25)
		r.early = changes - c0                           -- moved 125 yd, but the plan is younger than 30 s
		walk(6)
		r.late = changes - c0
		walk(5)
		r.after = changes - c0                           -- the new plan is young again
		emit(r)"#);
	assert_eq!(out["plain"], 0, "no crossing data: no movement re-plans");
	assert_eq!(out["early"], 0);
	assert_eq!(out["late"], 1);
	assert_eq!(out["after"], 1);
}

#[test]
fn learning_a_flight_path_re_plans_with_it() {
	let out = run(r#"
		ERR_NEWTAXIPATH = "New flight path discovered!"
		known(2)
		nav.place(0, 785)                                -- at West Hold, not yet known
		target(0, -780)
		local before = route()
		stub.fire("UI_INFO_MESSAGE", 0, "Something else")
		local other = route()
		stub.fire("UI_INFO_MESSAGE", 0, ERR_NEWTAXIPATH)
		emit({ before = before, other = other, after = route(), saved = Polestar.CharState().flags.taxi[1] == true })"#);
	assert_eq!(out["before"], json!(["walk|Target"]));
	assert_eq!(out["other"], json!(["walk|Target"]));
	assert_eq!(out["after"], json!(["fly|Fly to East Hold", "walk|Target"]));
	assert_eq!(out["saved"], true);
}

#[test]
fn a_flight_lands_in_the_right_zone_the_walk_after_it_crosses_at_the_gate() {
	let out = run(r#"
		crossings()
		known(1, 2)
		nav.place(0, 600)                                -- West Vale, near West Hold
		target(500, 300, "Mine")                         -- West Vale, far from the gate
		local west = route()
		target(-500, -500, "Camp")                       -- East Vale: fly to East Hold, walk from there
		emit({ west = west, east = route() })"#);
	assert_eq!(out["west"], json!(["walk|Mine"]));
	assert_eq!(out["east"], json!(["walk|Walk to the flight master", "fly|Fly to East Hold", "walk|Camp"]));
}

// The local crossings (addon/Polestar_Travel, built by `travel build` from the optional local crossings file)
// with the committed TravelData.lua: real routes go through the real gates, and planning stays cheap.
#[test]
fn the_local_crossings_route_real_trips_through_their_gates_within_the_planner_budget() {
	let root = forge_addontest::run::root();
	let local = root.join("addon").join("Polestar_Travel").join("Crossings.lua");
	let data = root.join("data").join("forever").join("map-frames.json");
	if !(local.exists() && data.exists()) {
		eprintln!("skipped: no local crossings built");
		return;
	}
	let frames: Value = serde_json::from_str(&std::fs::read_to_string(&data).unwrap()).unwrap();
	let era = &frames["era"];
	let world = |map: i64, x: f64, y: f64| {
		let b = &era[map.to_string()];
		let f = |k: &str| b[k].as_f64().unwrap();
		json!({
			"c": b["c"],
			"wx": f("top") + ((f("bottom") - f("top")) * y) / 100.0,
			"wy": f("left") + ((f("right") - f("left")) * x) / 100.0,
			"map": map,
		})
	};
	let trips = json!([
		["Horde", world(1411, 52.0, 43.0), world(1454, 50.0, 60.0)],
		["Horde", world(1413, 52.0, 30.0), world(1441, 40.0, 40.0)],
		["Alliance", world(1429, 42.0, 65.0), world(1453, 60.0, 60.0)],
		["Alliance", world(1426, 47.0, 52.0), world(1432, 35.0, 47.0)],
	]);
	let script = r#"
			assert(loadfile(__LOCAL__))("Polestar_Travel", {})
			local N = Polestar.Nav
			local list, crossings, open, chains = N.travel.CrossingCounts()
			local out = { covered = list, crossings = crossings, open = open, chains = chains, routes = {} }
			local trips = __TRIPS__
			local t0 = os.clock()
			for i, t in ipairs(trips) do
				local legs = N.PlanRoute({ c = t[2].c, wx = t[2].wx, wy = t[2].wy, map = t[2].map, faction = t[1] == "Horde" and 2 or 1,
					known = {}, target = { c = t[3].c, wx = t[3].wx, wy = t[3].wy, map = t[3].map, label = "Target" } })
				local r = {}
				for _, l in ipairs(legs or {}) do r[#r + 1] = l.label end
				out.routes[i] = r
			end
			out.ms = (os.clock() - t0) * 1000 / #trips
			emit(out)"#
		.replace("__LOCAL__", &lua_value(&json!(local.to_str().unwrap())))
		.replace("__TRIPS__", &lua_value(&trips));
	let out = run_raw(&script);
	assert_eq!(out["covered"], json!([0, 1]));
	let n = |k: &str| out[k].as_f64().unwrap_or(0.0);
	assert!(n("crossings") >= 40.0 && n("open") >= 8.0 && n("chains") >= 7.0, "{}", out);
	assert_eq!(out["routes"][0], json!(["Enter Orgrimmar", "Enter Orgrimmar", "Target"]));
	assert!(forge_addontest::is_match(forge_addontest::text(&out["routes"][1][0]), r"Thousand Needles"), "the first leg enters Thousand Needles: {}", out["routes"][1]);
	assert_eq!(out["routes"][2], json!(["Enter Stormwind City", "Enter Stormwind City", "Target"]));
	assert!(out["routes"][3].as_array().unwrap().iter().any(|l| forge_addontest::is_match(forge_addontest::text(l), r"Loch Modan")), "Dun Morogh -> Loch Modan crosses a tunnel: {}", out["routes"][3]);
	let ms = out["ms"].as_f64().unwrap();
	assert!(ms < 20.0, "a plan with crossings took {ms:.1} ms");
}

#[test]
fn a_start_already_past_a_crossing_s_near_end_walks_on_to_its_far_end_never_back() {
	let out = run(r#"
		local r = {}
		local ROAD = { id = "road", a = { map = 9002, c = 0, wx = 600, wy = 300, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -300, r = 15 } }
		crossings({ crossings = { ROAD } })
		nav.place(-500, 500)                             -- West Vale, before the road
		target(-500, -500, "Kobolds")
		r.before = route()
		nav.place(600, 100)                              -- on the road: 200 yd past its West Vale end, still in West Vale
		target(-500, -500, "Kobolds")
		r.on = route()
		local legs = N.GetRoute()
		r.firstTo = { legs[1].to.wx, legs[1].to.wy, legs[1].radius, legs[1].waypoint }
		nav.place(300, 100)                              -- 300 yd off the road: not on it
		target(-500, -500, "Kobolds")
		local off = N.GetRoute()
		r.offTo = { off[1].to.wx, off[1].to.wy }
		emit(r)"#);
	assert_eq!(out["before"], json!(["walk|Go to East Vale", "walk|Go to East Vale", "walk|Kobolds"]));
	assert_eq!(out["on"], json!(["walk|Go to East Vale", "walk|Kobolds"]), "straight on to the far end");
	assert_eq!(out["firstTo"], json!([600, -300, 15, true]));
	assert_eq!(out["offTo"], json!([600, 300]), "off the road the near end comes first, as before");
}

#[test]
fn skipping_a_crossing_s_near_end_walks_on_later_plans_near_the_crossing_walk_on_too_farther_off_the_near_end_comes_first_again() {
	let out = run(r#"
		local r, changes = {}, 0
		local ROAD = { id = "road", a = { map = 9002, c = 0, wx = 600, wy = 300, r = 15 }, b = { map = 9003, c = 0, wx = 600, wy = -300, r = 15 } }
		crossings({ crossings = { ROAD } })
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		nav.place(-500, 500)
		target(-500, -500, "Kobolds")
		stub.advance(0.2)
		local c0 = changes
		N.travel.SkipLeg()
		stub.advance(1.2)
		r.replanned = changes - c0
		r.skip = route()
		local function first()
			local legs = N.GetRoute()
			return { legs[1].to.wx, legs[1].to.wy }
		end
		nav.place(450, 200)                              -- off the road, but nearer its far end than its ends are apart
		stub.fire("ZONE_CHANGED")
		r.near = first()
		nav.place(300, 500)                              -- elsewhere in West Vale, farther from the far end than that
		stub.fire("ZONE_CHANGED")
		r.far = first()
		nav.place(450, 200)
		target(-400, -500, "Elsewhere")                  -- another target: the near end counts again
		r.other = first()
		emit(r)"#);
	assert_eq!(out["replanned"], 0, "skipping the near end moves on without planning back to it");
	assert_eq!(out["skip"], json!(["walk|Go to East Vale", "walk|Kobolds"]));
	assert_eq!(out["near"], json!([600, -300]), "near the crossing the skipped end stays skipped");
	assert_eq!(out["far"], json!([600, 300]), "far from it the skip never walks straight over the zone border");
	assert_eq!(out["other"], json!([600, 300]));
}

// #347: the player is in Thunder Bluff beside its flight master, with the flight to Camp Taurajo known. A taxi
// node assigned to Mulgore sends them through a city exit before walking back to the same flight master.
#[test]
fn thunder_bluff_to_camp_taurajo_walks_to_the_nearby_flight_master_without_leaving_the_city_347() {
	let legs = run_raw(
		r#"
			-- The report's map positions, converted through the shipped frames.
			local legs = Polestar.Nav.PlanRoute({
				c = 1, map = 1456,
				wx = -850 + (-1545.833 + 850) * 0.5434,
				wy = 516.667 + (-527.083 - 516.667) * 0.4384,
				target = {
					c = 1, map = 1413, label = "Accept Betrayal from Within",
					wx = 1612.5 + (-5143.75 - 1612.5) * 0.5926,
					wy = 2622.917 + (-7510.417 - 2622.917) * 0.4455,
				},
				faction = 2, known = { [22] = true, [77] = true },
			})
			emit(legs)"#,
	);
	let pairs: Vec<Value> = legs.as_array().unwrap().iter().map(|l| json!([l["kind"], l["label"]])).collect();
	assert_eq!(Value::Array(pairs), json!([["walk", "Walk to the flight master"], ["fly", "Fly to Camp Taurajo"], ["walk", "Accept Betrayal from Within"]]));
	assert_eq!(legs[0]["to"]["id"], 22);
	assert_eq!(legs[0]["to"]["map"], 1456, "the flight master belongs to Thunder Bluff");
	assert!(legs[0]["seconds"].as_f64().unwrap() < 10.0, "the nearby flight master does not require a lift detour");
}

// #237: on the Gold Road north out of the Barrens the real crossing's two ends (Nav/TravelData.lua,
// carbonite-ashenvale--the-barrens) are about 510 yd apart. Past the Barrens end, a plan made again before the
// client says Ashenvale (a subzone change, or 50 yd walked once the plan is 30 s old) must keep heading north,
// not send the player back to the Barrens end.
#[test]
fn the_barrens_to_ashenvale_road_plans_made_between_the_crossing_s_ends_keep_heading_north_237() {
	let out = run_raw(
		r#"
			local N, nav = Polestar.Nav, stub.nav
			nav.faction = "Horde"
			nav.maps[1413] = { name = "The Barrens", c = 1, top = 1612.5, bottom = -5143.75, left = 2622.917, right = -7510.417 }
			nav.maps[1440] = { name = "Ashenvale", c = 1, top = 4672.917, bottom = 829.167, left = 1700, right = -4066.667 }
			-- The client calls everything here the Barrens until the player is through.
			function nav.Compat.GetPlayerMapPosition()
				local p, b = nav.player, nav.maps[1413]
				return 1413, (p.wy - b.left) / (b.right - b.left) * 100, (p.wx - b.top) / (b.bottom - b.top) * 100
			end
			local function first()
				local legs, ci = N.GetRoute()
				local l = legs and legs[ci or 1]
				return l and { l.to.wx, l.to.wy } or nil
			end
			local r, back = {}, {}
			nav.place(500, -2290, 1)                         -- the Gold Road, south of the crossing
			N.SetTarget(1440, 68.60, 89.10, "Kadrak")       -- the report's waypoint
			local legs = N.GetRoute()
			local near, far = legs[1].to, legs[2].to
			r.ends = { legs[1].waypoint, legs[2].waypoint, math.floor(math.sqrt((far.wx - near.wx) ^ 2 + (far.wy - near.wy) ^ 2)) }
			-- Walk north up the road at running speed from the Barrens end, still in the Barrens.
			nav.place(near.wx - 5, near.wy, 1)
			stub.advance(0.2)
			stub.advance(1.2)
			for wx = near.wx, near.wx + 280, 7 do
				nav.place(wx, -2290, 1)
				stub.advance(1)
				local f = first()
				if f and f[1] == near.wx and f[2] == near.wy then back[#back + 1] = math.floor(wx) end
			end
			r.back = table.concat(back, ",")
			-- The report's spot: a subzone change there plans again.
			nav.place(1042, -2292, 1)
			stub.fire("ZONE_CHANGED")
			r.zone = first()
			r.far = { far.wx, far.wy }
			emit(r)"#,
	);
	assert_eq!(json!([out["ends"][0], out["ends"][1]]), json!([true, true]), "the route goes through the crossing");
	assert!(out["ends"][2].as_f64().unwrap() > 400.0, "the crossing's ends are far apart ({} yd)", out["ends"][2]);
	assert_eq!(out["back"], "", "walking north, no plan sends the player back to the Barrens end (the wx where one did)");
	assert_eq!(out["zone"], out["far"], "a subzone change between the ends keeps heading for the Ashenvale end");
}

// KEPT IN JS:
