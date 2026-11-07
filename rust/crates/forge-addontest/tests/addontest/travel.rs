//! Travel planner (addon/Polestar/Nav/Travel.lua): Dijkstra over walking, known flights, transports, the
//! Hearthstone and learned paths, and how the arrow follows the route. Runs the real Core/Init.lua + Nav/Nav.xml
//! against tests/lua/stub_nav.lua with a small fixture travel world (stub.nav.useTravelWorld).

use forge_addontest::{emitted, fake_locale, is_match, text, Addon, RunAddon};
use serde_json::{json, Value};

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
"#;

fn nav() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])
}

fn run_with(script: &str, flight_yards: Option<i32>, before: String) -> Value {
	let yards = flight_yards.map_or_else(|| "nil".to_string(), |y| y.to_string());
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		before,
		addons: vec![nav()],
		login: true,
		script: format!("{PRELUDE}\nnav.faction = \"Alliance\"\nnav.useTravelWorld({yards})\n{script}"),
		..Default::default()
	})
	.remove(0)
}

fn run(script: &str) -> Value {
	run_with(script, None, String::new())
}

#[test]
fn every_leg_caption_is_in_the_client_language_flight_boat_and_tram() {
	let out = run_with(
		r#"
		nav.place(0, 600)
		known(1, 2)
		target(0, -780, "Kobolds")
		local flying = route()
		nav.place(0, 0, 1)
		target(-800, 100, "Docks quest")
		local boat = route()
		N.RegisterTravelData({ build = "test", taxi = {}, flights = {}, inns = {},
			transports = { { id = "tram-test", kind = "tram", faction = 1, ab = 100, ba = 100, waitA = 30, waitB = 30,
				a = { "Northgate", 0, 900, 0, 9000, 50, 5 }, b = { "Southgate", 0, -900, 0, 9000, 50, 95 } } } }, true)
		nav.place(890, 0)
		target(-950, 0, "Nightbane Shadow Weavers")
		emit({ flying = flying, boat = boat, tram = route() })"#,
		None,
		fake_locale(
			"itIT",
			&[
				("Walk to the flight master", "Geh zum Flugmeister"),
				("Fly to %s", "Flieg nach %s"),
				("Walk to the boat", "Geh zum Schiff"),
				("Take the boat to %s", "Nimm das Schiff nach %s"),
				("Take the tram to %s", "Nimm die Tiefenbahn nach %s"),
			],
		),
	);
	assert_eq!(
		out,
		json!({
			"flying": ["walk|Geh zum Flugmeister", "fly|Flieg nach East Hold", "walk|Kobolds"],
			"boat": ["walk|Geh zum Schiff", "boat|Nimm das Schiff nach Testshire Docks", "walk|Docks quest"],
			"tram": ["tram|Nimm die Tiefenbahn nach Southgate", "walk|Nightbane Shadow Weavers"],
		})
	);
}

#[test]
fn takes_a_known_flight_over_a_long_walk_and_walks_when_no_flight_is_known() {
	let out = run(r#"
		nav.place(0, 600)                        -- 190 yd from West Hold
		known(1, 2)
		target(0, -780, "Kobolds")
		local flying = route()
		local legs = N.GetRoute()
		local total = legs[1].seconds + legs[1].rest
		known()
		target(0, -780, "Kobolds")
		emit({ flying = flying, total = total, walking = route() })"#);
	assert_eq!(out["flying"], json!(["walk|Walk to the flight master", "fly|Fly to East Hold", "walk|Kobolds"]));
	assert!(out["total"].as_f64().unwrap() < 1380.0 / 7.0, "flying ({} s) beats walking 1380 yd", out["total"]);
	assert_eq!(out["walking"], json!(["walk|Kobolds"]));
}

#[test]
fn never_flies_through_a_node_the_character_does_not_know_or_cannot_use() {
	let out = run(r#"
		nav.place(0, 790)
		known(1)                                  -- East Hold unknown
		target(0, -780)
		local unknownEnd = route()
		known(1, 3)                               -- Horde Roost "known" by an Alliance character
		target(500, -790)
		emit({ unknownEnd = unknownEnd, hordeNode = route() })"#);
	assert_eq!(out["unknownEnd"], json!(["walk|Target"]));
	assert_eq!(out["hordeNode"], json!(["walk|Target"]));
}

#[test]
fn crosses_continents_by_boat() {
	let out = run(r#"
		nav.place(0, 0, 1)                        -- Farland, continent 1
		target(-800, 100, "Docks quest")
		local legs = N.GetRoute()
		emit({ route = route(), to = { legs[2].to.name, legs[2].to.c }, boatSecs = legs[2].seconds })"#);
	assert_eq!(out["route"], json!(["walk|Walk to the boat", "boat|Take the boat to Testshire Docks", "walk|Docks quest"]));
	assert_eq!(out["to"], json!(["Testshire Docks", 0]));
	assert_eq!(out["boatSecs"], 90, "wait + ride");
}

// The Hearthstone's hour-long cooldown is spent once a trip is long enough for it to clearly pay (Fitz, #1096):
// a route hearths only when the way without it takes at least 3 minutes (Nav.HEARTH_MIN_TRIP) and hearthing
// saves at least 2 (Nav.HEARTH_MARGIN), after its cast and loading screen. The boat waits `wait` seconds.
#[test]
fn hearths_only_when_the_stone_is_ready_and_it_saves_a_long_haul() {
	let out = run(r#"
		local r = {}
		local function trip(noHearth)
			local m, x, y = nav.mapPoint(-520, -690)
			return math.floor(N.EstimateTravel(nil, { map = m, x = x, y = y }, nil, noHearth) + 0.5)
		end
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		nav.useTravelWorld(nil, 400)              -- a 12-minute trip without the Hearthstone
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		r.long = route()
		r.longTrip = trip(true)
		stub.advance(10)                          -- the client clock never reads 0
		nav.hearthCooldown = { GetTime(), 3600 }
		target(-520, -690, "Innkeeper quest")
		r.cooldown = route()
		nav.hearthCooldown = nil
		nav.useTravelWorld()                      -- the boat waits 30 s: about a 5-minute trip
		target(-520, -690, "Innkeeper quest")
		r.short = route()
		r.shortTrip = trip(true)
		nav.place(150, -690, 0)                   -- 670 yd from the target, the inn next to it: a 2-minute walk
		target(-520, -690, "Innkeeper quest")
		r.near = route()
		nav.items[6948] = nil
		nav.useTravelWorld(nil, 400)
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		r.noStone = route()[2]
		emit(r)"#);
	assert!(out["longTrip"].as_i64().unwrap() >= 600, "the long trip takes {} s", out["longTrip"]);
	assert_eq!(out["long"], json!(["hearth|Hearth to Testshire Inn: saves 10 min", "walk|Innkeeper quest"]));
	assert_eq!(out["cooldown"], json!(["walk|Walk to the boat", "boat|Take the boat to Testshire Docks", "walk|Innkeeper quest"]));
	let short = out["shortTrip"].as_i64().unwrap();
	assert!(short < 480 && short > 240, "the short trip takes {short} s");
	assert_eq!(out["short"], json!(["hearth|Hearth to Testshire Inn: saves 4 min", "walk|Innkeeper quest"]), "a 5-minute trip the hearth shortens by 4 takes it (#1096)");
	assert_eq!(out["near"], json!(["walk|Innkeeper quest"]));
	assert_eq!(out["noStone"], "boat|Take the boat to Testshire Docks");
}

// The hearth must save at least 2 minutes (Nav.HEARTH_MARGIN): a 4-minute trip with the target 560 yd (100 s)
// from the inn, 15 s for the cast, saves 119 s (walk, and the estimate weighs it the same way) or 121 s (hearth).
#[test]
fn a_hearth_that_saves_under_two_minutes_keeps_the_stone_and_one_that_saves_two_takes_it() {
	let out = run(r#"
		local function trip(noHearth)
			local m, x, y = nav.mapPoint(60, -700)
			return math.floor(N.EstimateTravel(nil, { map = m, x = x, y = y }, nil, noHearth) + 0.5)
		end
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		known()
		local r = {}
		nav.place(60, -700 + 234 * 5.6)           -- 1310.4 yd: 234 s on foot, 119 s more than the hearth's 115
		target(60, -700, "Past the inn")
		r.under, r.underTrip, r.underWith = route(), trip(true), trip(false)
		stub.advance(6)                           -- past the estimate cache (5 s, 25 yd cells)
		nav.place(60, -700 + 236 * 5.6)           -- 1321.6 yd: 236 s on foot, 121 s more
		target(60, -700, "Past the inn")
		r.over, r.overTrip = route(), trip(true)
		emit(r)"#);
	assert_eq!(out["underTrip"], 234);
	assert_eq!(out["under"], json!(["walk|Past the inn"]), "saves 119 s: keep the Hearthstone");
	assert_eq!(out["underWith"], out["underTrip"], "the estimate weighs the Hearthstone the same way");
	assert_eq!(out["overTrip"], 236);
	assert_eq!(out["over"], json!(["hearth|Hearth to Testshire Inn: saves 2 min", "walk|Past the inn"]), "saves 121 s: hearth");
}

// The trip must take at least 3 minutes (Nav.HEARTH_MIN_TRIP): the target 10 yd from the inn, a 179 s walk keeps the
// Hearthstone though the hearth would save over 2 minutes; a 181 s walk takes it.
#[test]
fn a_trip_under_three_minutes_keeps_the_stone_and_one_over_three_hearths() {
	let out = run(r#"
		local function trip(noHearth)
			local m, x, y = nav.mapPoint(-500, -690)
			return math.floor(N.EstimateTravel(nil, { map = m, x = x, y = y }, nil, noHearth) + 0.5)
		end
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		known()
		local r = {}
		nav.place(-500 + 179 * 5.6, -690)         -- 1002.4 yd: 179 s on foot
		target(-500, -690, "By the inn")
		r.under, r.underTrip = route(), trip(true)
		stub.advance(6)                           -- past the estimate cache (5 s, 25 yd cells)
		nav.place(-500 + 181 * 5.6, -690)         -- 1013.6 yd: 181 s on foot
		target(-500, -690, "By the inn")
		r.over, r.overTrip = route(), trip(true)
		emit(r)"#);
	assert_eq!(out["underTrip"], 179);
	assert_eq!(out["under"], json!(["walk|By the inn"]), "a 179 s trip keeps the Hearthstone");
	assert_eq!(out["overTrip"], 181);
	assert_eq!(out["over"], json!(["hearth|Hearth to Testshire Inn: saves 2 min", "walk|By the inn"]), "a 181 s trip hearths");
}

#[test]
fn the_cooldown_running_out_triggers_a_new_plan_with_the_hearth() {
	let out = run(r#"
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		nav.useTravelWorld(nil, 400)              -- a long haul: the Hearthstone pays
		stub.advance(10)
		nav.hearthCooldown = { GetTime(), 5 }
		nav.place(0, 0, 1)
		target(-520, -690, "Q")
		local before = route()[1]
		stub.advance(6.5)
		emit({ before = before, after = route()[1] })"#);
	assert_eq!(out["before"], "walk|Walk to the boat");
	assert_eq!(out["after"], "hearth|Hearth to Testshire Inn: saves 10 min");
}

// A hearth leg has no direction: the arrow's dial shows the Hearthstone glyph instead of an empty space above
// "Hearth to ...".
#[test]
fn a_hearth_instruction_shows_the_hearthstone_glyph_on_the_arrow_dial() {
	let out = run(r#"
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		nav.useTravelWorld(nil, 400)
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		stub.advance(0.2)
		emit({ A.GetMode(), A.distText:GetText(), A.dial:IsShown(), A.legIcon:IsShown(), (A.legIcon:GetTexture() or ""):match("[^\\]+$") })"#);
	assert_eq!(out, json!(["instruction", "Hearth to Testshire Inn: saves 10 min", true, true, "icon-hearth"]));
}

#[test]
fn learned_walking_paths_change_the_route() {
	let out = run_with(
		r#"
		nav.place(0, 790)
		known(1, 2)
		target(0, -790)
		local before = route()
		N.AddTravelPaths({ nodes = { 0, 0, 780, 0, 9000,  0, 0, 0, 0, 9000,  0, 0, -780, 0, 9000 } })
		N.AddTravelPaths({ edges = { 1, 2, 780, 2, 3, 780 } })
		target(0, -790)
		local legs = N.GetRoute()
		emit({ before = before, after = route(), secs = legs[1].seconds })"#,
		Some(7500),
		String::new(),
	);
	assert_eq!(out["before"], json!(["fly|Fly to East Hold", "walk|Target"]));
	assert_eq!(out["after"], json!(["walk|Target"]));
	assert!(out["secs"].as_f64().unwrap() < 1580.0 * 1.25 / 7.0, "the learned path ({} s) beats a straight-line estimate", out["secs"]);
}

#[test]
fn the_arrow_follows_the_legs_walk_act_at_the_flight_master_re_plan_on_landing() {
	let out = run(r#"
		local r, changes = {}, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		stub.advance(0.2)
		r.walk = { A.GetMode(), A.distText:GetText(), A.labelText:GetText(), A.etaText:GetText(), A.GetAngle() }
		nav.place(0, 785)                         -- at the flight master
		stub.advance(0.2)
		r.at = { A.GetMode(), A.distText:GetText(), A.labelText:GetText(), A.dial:IsShown(), (A.legIcon:GetTexture() or ""):match("[^\\]+$") }
		nav.taxi = true
		stub.advance(0.2)
		r.flying = A.frame:IsShown()
		nav.place(0, -795)
		nav.taxi = false
		stub.advance(1.2)                         -- landed: the ticker re-plans
		r.landed = { A.GetMode(), A.distText:GetText(), A.labelText:GetText() }
		r.route = route()
		r.changes = changes
		emit(r)"#);
	assert_eq!(out["walk"][0], "travel");
	assert_eq!(out["walk"][1], "190 yd");
	assert_eq!(out["walk"][2], "Walk to the flight master");
	assert!(is_match(text(&out["walk"][3]), r"^\d+:\d\d total$"));
	assert!((out["walk"][4].as_f64().unwrap().abs() - std::f64::consts::PI / 2.0).abs() < 1e-3, "points west at the flight master");
	assert_eq!(out["at"], json!(["instruction", "Fly to East Hold", "Kobolds", true, "icon-fly"]), "the dial shows the flight glyph");
	assert_eq!(out["flying"], false);
	assert_eq!(out["landed"], json!(["travel", "15 yd", "Kobolds"]));
	assert_eq!(out["route"], json!(["walk|Kobolds"]));
	assert!(out["changes"].as_f64().unwrap() >= 2.0, "ROUTE_CHANGED on plan and re-plan");
}

#[test]
fn opening_the_flight_map_records_known_nodes_and_re_plans() {
	let out = run(r#"
		nav.place(0, 790)
		target(0, -780)
		local before = route()
		nav.taxiMap = { mapID = 1415, nodes = { 1, 2 } }
		stub.fire("TAXIMAP_OPENED", 1)
		local saved = Polestar.CharState().flags.taxi
		emit({ before = before, after = route(), saved = { saved[1] == true, saved[2] == true, saved[3] == true } })"#);
	assert_eq!(out["before"], json!(["walk|Target"]));
	assert_eq!(out["after"], json!(["fly|Fly to East Hold", "walk|Target"]));
	assert_eq!(out["saved"], json!([true, true, false]));
}

#[test]
fn binding_at_an_innkeeper_teaches_nav_what_the_bind_location_means() {
	let out = run(r#"
		nav.items[6948] = 1
		nav.bind = "Lion's Den Tavern"              -- a name the data does not list
		nav.useTravelWorld(nil, 400)
		nav.place(0, 0, 1)
		target(-520, -690, "Q")
		local before = route()[1]
		nav.place(-505, -700, 0)                     -- standing at the innkeeper
		stub.fire("HEARTHSTONE_BOUND")
		nav.place(0, 0, 1)
		target(-520, -690, "Q")
		emit({ before = before, after = route()[1], learned = Polestar.CharState().flags.inn })"#);
	assert_eq!(out["before"], "walk|Walk to the boat");
	assert_eq!(out["after"], "hearth|Hearth to Lion's Den Tavern: saves 10 min");
	assert_eq!(out["learned"], json!({ "lion's den tavern": 900 }));
}

#[test]
fn a_target_change_re_plans_nav_travel_off_falls_back_to_the_direct_arrow() {
	let out = run(r#"
		local r = {}
		known(1, 2)
		nav.place(0, 600)
		target(0, -780)
		r.first = #route()
		target(0, 500)
		r.second = route()
		target(0, -780)
		Polestar.Set("nav.travel", false)
		stub.advance(0.2)
		r.off = { N.GetRoute() == nil, A.GetMode(), A.labelText:GetText() }
		Polestar.Set("nav.travel", true)
		r.on = #route()
		emit(r)"#);
	assert_eq!(out["first"], 3);
	assert_eq!(out["second"], json!(["walk|Target"]));
	assert_eq!(out["off"], json!([true, "travel", "Target"]));
	assert_eq!(out["on"], 3);
}

#[test]
fn world_map_shows_the_final_target_pin_plus_the_route_waypoints() {
	let out = run(r#"
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		nav.showWorldMap(9000)
		local pins = nav.pins()
		local r = {}
		for _, pin in ipairs(pins) do
			local tip = nav.tooltipOf(pin)
			r[#r + 1] = { pin.data.layer.name, tip[1], tip[2] or false, math.floor(pin.width * 10 + 0.5) / 10 }
		end
		emit(r)"#);
	assert_eq!(out, json!([["nav.target", "Kobolds", "1380 yd", 22.4], ["nav.route", "Fly to East Hold", "Travel route, step 1/3", 13.5], ["nav.route", "Kobolds", "Travel route, step 2/3", 13.5],]));
}

#[test]
fn estimatetravel_prices_trips_with_the_planner_caches_briefly_and_leaves_the_route_alone() {
	let out = run(r#"
		local r, changes = {}, 0
		Polestar.On("ROUTE_CHANGED", function() changes = changes + 1 end)
		nav.place(0, 600)
		local m, x, y = nav.mapPoint(0, -780)
		local far = { map = m, x = x, y = y }
		r.walking = N.EstimateTravel(nil, far)
		known(1, 2)
		r.cached = N.EstimateTravel(nil, far)          -- same start cell within 5 s: cached
		stub.advance(6)
		r.flying = N.EstimateTravel(nil, far)
		local fm, fx, fy = nav.mapPoint(0, 780)
		r.fromPoint = N.EstimateTravel({ map = fm, x = fx, y = fy }, far)
		r.crossSea = N.EstimateTravel(nil, { map = 9001, x = 50, y = 50 })
		r.unknownMap = N.EstimateTravel(nil, { map = 4242, x = 50, y = 50 })
		r.route = N.GetRoute() == nil
		r.changes = changes
		emit(r)"#);
	let walking = out["walking"].as_f64().unwrap();
	let flying = out["flying"].as_f64().unwrap();
	assert!((walking - (1380.0 * 1.25) / 7.0).abs() < 2.0, "walk estimate {walking}");
	assert_eq!(out["cached"], out["walking"]);
	assert!(flying < walking / 2.0, "known flight is cheaper ({flying} s)");
	assert!(out["fromPoint"].as_f64().unwrap() < flying, "from the flight master itself is quicker still");
	assert!(out["crossSea"].as_f64().unwrap() > 0.0, "the boat reaches the other continent");
	assert!(out["unknownMap"].is_null());
	assert_eq!(out["route"], true, "no route was planned");
	assert_eq!(out["changes"], 0, "no ROUTE_CHANGED");
}

#[test]
fn estimatetravel_stays_cheap_for_a_burst_of_candidates_on_the_real_network() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![nav()],
		login: true,
		script: r#"
			local N, nav = Polestar.Nav, stub.nav
			nav.faction = "Alliance"
			Polestar.RegisterMapFrames({ era = { [1436] = { c = 0, left = 3016.667, right = -483.333, top = -9400, bottom = -11733.333 },
				[1433] = { c = 0, left = -1570.833, right = -3741.667, top = -8575, bottom = -10022.916 } } })
			nav.place(-10500, 1046, 0)
			Polestar.CharState().flags.taxi = { [2] = true, [4] = true, [5] = true }
			local t0 = os.clock()
			local first
			for i = 1, 10 do
				local s = N.EstimateTravel(nil, { map = 1433, x = 20 + i, y = 44, f = "e" })
				first = first or s
			end
			emit({ ms = (os.clock() - t0) * 1000, first = first })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	let first = out["first"].as_f64().unwrap();
	let ms = out["ms"].as_f64().unwrap();
	assert!(first > 0.0 && first < 600.0, "Sentinel Hill -> Redridge by air: {first} s");
	assert!(ms < 200.0, "10 estimates took {ms:.1} ms");
}

#[test]
fn only_discovered_flight_masters_are_recorded_from_the_flight_map() {
	let out = run(r#"
		nav.place(0, 790)
		target(0, -780)
		-- Current (0) here, East Hold listed as Unreachable (2): a pass-through node, not discovered.
		nav.taxiMap = { mapID = 1415, nodes = { { 1, 0 }, { 2, 2 } } }
		stub.fire("TAXIMAP_OPENED", 1)
		local saved = Polestar.CharState().flags.taxi
		local r = { saved = { saved[1] == true, saved[2] == true }, route = route() }
		nav.taxiMap = { mapID = 1415, nodes = { { 1, 0 }, { 2, 1 } } }
		stub.fire("TAXIMAP_OPENED", 1)
		r.after = route()
		emit(r)"#);
	assert_eq!(out["saved"], json!([true, false]));
	assert_eq!(out["route"], json!(["walk|Target"]), "no flight to an undiscovered node");
	assert_eq!(out["after"], json!(["fly|Fly to East Hold", "walk|Target"]));
}

#[test]
fn the_hearthstone_coming_off_cooldown_mid_ride_does_not_re_plan_from_the_boat() {
	let out = run(r#"
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		stub.advance(10)
		nav.hearthCooldown = { GetTime(), 30 }
		nav.useTravelWorld(nil, 400)                     -- a long wait: the stone would pay
		nav.place(395, 0, 1)                             -- at Farland Pier
		target(-520, -690, "Q")
		stub.advance(0.2)
		local before = route()
		nav.place(200, 0, 1)                             -- sailing away from the pier
		stub.advance(35)                                 -- the stone comes off cooldown on the way (at 40 s)
		emit({ before = before, during = route(), leg = (select(2, N.GetRoute())) })"#);
	assert_eq!(out["before"], json!(["boat|Take the boat to Testshire Docks", "walk|Q"]));
	assert_eq!(out["during"], out["before"], "still on the boat leg");
	assert_eq!(out["leg"], 1);
}

// Playtest: at Auberdine the walk to the boat ended at the ship's stop, in the water off the pier, and swam. An
// end with a board point (TravelData's 10th field, after the area: the deck, from the navigation grid) is the
// dock: the walk ends there, with its height, and boarding, leaving and arrival measure from it. The board
// points here lie 70 yd off their stops (real ones are 12-14 yd), past BOARD (60 yd), so measuring from the stop
// shows.
#[test]
fn a_boat_end_with_a_board_point_the_walk_ends_on_the_deck_and_arriving_there_boards() {
	let out = run(r#"
		N.RegisterTravelData({ build = "test", taxi = {}, flights = {}, inns = {},
			transports = { { id = "boat-test", kind = "boat", faction = 3, ab = 60, ba = 60, waitA = 30, waitB = 30,
				a = { "Testshire Docks", 0, -900, 0, 9000, 50, 95, "e", nil, { wx = -900, wy = 70, z = 5.9 } },
				b = { "Farland Pier", 1, 400, 0, 9001, 50, 10, "e", nil, { wx = 400, wy = 70, z = 4.5 } } } } }, true)
		local function at(p) return p and { p.c, p.wx, p.wy, p.z or "none" } end
		local r = {}
		nav.place(0, 0, 1)                               -- Farland, continent 1
		target(-800, 100, "Docks quest")
		stub.advance(0.2)
		local legs = N.GetRoute()
		r.route = route()
		r.walkTo, r.rideFrom, r.rideTo = at(legs[1].to), at(legs[2].from), at(legs[2].to)
		r.stop = at(N.GetTravelData().transports[1].b)
		nav.place(400, 70, 1)                            -- on the deck at the board point (70 yd from the stop)
		stub.advance(0.2)
		r.atDeck = { (select(2, N.GetRoute())), route()[1] }
		nav.place(250, 70, 1)                            -- sailing away: 150 yd from the deck
		stub.advance(0.2)
		stub.advance(1.2)
		r.sailing = { (select(2, N.GetRoute())), route()[1] }
		nav.place(-900, 70)                              -- landed on the Testshire deck
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.advance(1.2)
		r.landed = route()
		emit(r)"#);
	assert_eq!(out["route"], json!(["walk|Walk to the boat", "boat|Take the boat to Testshire Docks", "walk|Docks quest"]));
	assert_eq!(out["walkTo"], json!([1, 400, 70, 4.5]), "the walk ends at the board point, with its height");
	assert_eq!(out["rideFrom"], json!([1, 400, 70, 4.5]), "the ride is boarded there");
	assert_eq!(out["rideTo"], json!([0, -900, 70, 5.9]), "and arrives at the far deck");
	assert_eq!(out["stop"], json!([1, 400, 0, "none"]), "the transport end stays the ship's stop");
	assert_eq!(out["atDeck"], json!([2, "boat|Take the boat to Testshire Docks"]), "at the deck: the ride");
	assert_eq!(out["sailing"], json!([2, "boat|Take the boat to Testshire Docks"]), "boarded at the deck: sailing away is the ride, no new plan");
	assert_eq!(out["landed"], json!(["walk|Docks quest"]));
}

// Igotthis rode the Deeprun Tram toward Duskwood and the arrow vanished: the tram is a map of its own (Map 369,
// no UiMap), so the client gives no player position on the ride. The arrow keeps the ride's caption and glyph,
// and points again on arrival.
#[test]
fn on_the_tram_with_no_player_position_the_arrow_keeps_the_ride_caption_and_resumes_on_arrival() {
	let out = run(r#"
		N.RegisterTravelData({ build = "test", taxi = {}, flights = {}, inns = {},
			transports = { { id = "tram-test", kind = "tram", faction = 1, ab = 100, ba = 100, waitA = 30, waitB = 30,
				a = { "Northgate", 0, 900, 0, 9000, 50, 5 }, b = { "Southgate", 0, -900, 0, 9000, 50, 95 } } } }, true)
		local function snap()
			return { A.frame:IsShown(), A.GetMode() or "hidden", A.distText:GetText(), A.labelText:GetText(), A.dial:IsShown(),
				A.legIcon:IsShown(), (A.legIcon:GetTexture() or ""):match("[^\\]+$"), table.concat(route(), ", ") }
		end
		local r = {}
		nav.place(890, 0)                          -- at the Northgate door
		target(-950, 0, "Nightbane Shadow Weavers")
		stub.advance(0.2); r.door = snap()
		nav.player = nil                           -- through the portal: no position on the ride
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.advance(1.2); r.riding = snap()
		stub.advance(60); r.later = snap()
		nav.place(-895, 0)                         -- out at Southgate
		stub.fire("ZONE_CHANGED_NEW_AREA")
		stub.advance(1.2); r.arrived = snap()
		emit(r)"#);
	let ride = json!([true, "instruction", "Take the tram to Southgate", "Nightbane Shadow Weavers", true, true, "icon-boat", "tram|Take the tram to Southgate, walk|Nightbane Shadow Weavers"]);
	assert_eq!(out["door"], ride);
	assert_eq!(out["riding"], ride, "the ride keeps its caption with no position");
	assert_eq!(out["later"], ride);
	assert_eq!(out["arrived"], json!([true, "travel", "55 yd", "Nightbane Shadow Weavers", true, false, "icon-boat", "walk|Nightbane Shadow Weavers"]));
}

#[test]
fn walk_legs_are_priced_unmounted_so_a_fast_mount_never_swaps_a_flight_for_a_straight_swim() {
	let out = run_with(
		r#"
		known(1, 2)
		nav.place(0, 600)
		nav.runSpeed = 7
		target(0, -780)
		local foot = route()
		nav.runSpeed = 14                                -- mounted
		target(0, -780)
		emit({ foot = foot, mounted = route() })"#,
		Some(4000),
		String::new(),
	);
	assert_eq!(out["foot"], json!(["walk|Walk to the flight master", "fly|Fly to East Hold", "walk|Target"]));
	assert_eq!(out["mounted"], out["foot"]);
}

#[test]
fn estimatetravel_takes_a_live_frame_start_and_an_era_frame_destination_on_a_re_framed_map() {
	let out = run(r#"
		-- Map 9000's Era frame is shifted from the live one (like Mulgore 1412).
		Polestar.RegisterMapFrames({ era = { [9000] = { c = 0, top = 1030, bottom = -970, left = 960, right = -1040 } } })
		nav.place(0, 0)
		local fm, fx, fy = nav.mapPoint(0, 0)            -- the player's live map position, no f
		local here = { map = fm, x = fx, y = fy }
		-- Era (50, 50) is world (30, -40): 50 yd away; the same numbers in the live frame are 0 yd away.
		local era = N.EstimateTravel(here, { map = 9000, x = 50, y = 50, f = "e" })
		local live = N.EstimateTravel(here, { map = 9000, x = 50, y = 50 })
		local ok, bad = pcall(N.EstimateTravel, here, { map = 4242, x = 1, y = 1, f = "e" })
		emit({ era = era, live = live, ok = ok, bad = bad == nil })"#);
	let era = out["era"].as_f64().unwrap();
	let live = out["live"].as_f64().unwrap();
	assert!((era - (50.0 * 1.25) / 7.0).abs() < 1.5, "era estimate {era}");
	assert!(live <= 1.0, "live estimate {live}");
	assert_eq!(json!([out["ok"], out["bad"]]), json!([true, true]));
}

#[test]
fn a_class_flight_node_flies_that_class_alone_with_no_path_learnt() {
	// Nighthaven (TaxiNodes 62/63): Bunthen Plainswind and Silva Fil'naveth fly Druids out of Moonglade.
	// A Warrior is never routed through it; a Druid flies from it without learning it.
	let out = run(r#"
		N.RegisterTravelData({ build = "test",
			taxi = {
				{ 2, 0, 0, -800, 9000, 90, 50, 1, "East Hold, Testshire" },
				{ 4, 0, 0, 590, 9000, 12, 50, 3, "Nighthaven, Testshire", "DRUID" },
			},
			flights = { 4, 2, 1400 }, inns = {} }, true)
		nav.place(0, 600)
		known(2)
		local C = Polestar.Compat
		C.GetPlayerInfo = function() return { faction = "Alliance", class = "WARRIOR" } end
		target(0, -780, "Kobolds")
		local warrior = route()
		C.GetPlayerInfo = function() return { faction = "Alliance", class = "DRUID" } end
		target(0, -780, "Kobolds")
		emit({ warrior = warrior, druid = route() })"#);
	assert_eq!(out["warrior"], json!(["walk|Kobolds"]));
	assert!(out["druid"].as_array().unwrap().iter().any(|l| l.as_str().is_some_and(|s| s.starts_with("fly|"))), "{}", out["druid"]);
}
