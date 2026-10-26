//! The travel planner's newer legs (addon/Polestar/Nav/Travel.lua): timetable waits and departure captions from
//! Nav/Transit.lua (a fake ns.Transit here), class teleports, walk-in portals, a ghost's walk-only route,
//! skipping a leg, and the leg fields the prompts and map lines read. Runs the real Core/Init.lua + Nav/Nav.xml
//! against tests/lua/stub_nav.lua's travel world.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const PRELUDE: &str = r#"
local N = Polestar.Nav
local T = N.travel
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
local function leg(kind)
	local legs = N.GetRoute()
	for _, l in ipairs(legs or {}) do if l.kind == kind then return l end end
end
"#;

fn run(script: &str) -> Value {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}\nnav.faction = \"Alliance\"\nnav.useTravelWorld()\n{script}"),
		..Default::default()
	})
	.remove(0)
}

#[test]
fn a_ride_waits_as_the_timetable_says_from_when_the_player_reaches_the_dock_the_caption_counts_down_to_it() {
	let out = run(r#"
		local r, seen = {}, nil
		nav.place(0, 0, 1)
		target(-800, 100, "Docks quest")
		r.average = leg("boat").seconds
		Polestar.Transit = {
			Now = function() return 1000 end,
			NextDeparture = function(kind, id, now, side) seen = seen or { kind, id, now, side } return 500, 60 end,
			Caption = function(kind, id, now, side) return "Next " .. kind .. " in 1:20 (" .. side .. ")" end,
		}
		target(-800, 100, "Docks quest")
		r.timed = leg("boat").seconds
		r.seen = { seen[1], seen[2], seen[3] > 1000, seen[4] }
		local boat = leg("boat")
		r.fields = { boat.transport.id, boat.side }
		nav.place(400, 0, 1)                              -- at Farland Pier
		target(-800, 100, "Docks quest")
		r.label = T.CurrentLabel()
		emit(r)"#);
	assert_eq!(out["average"], 90, "without timetables: the average wait plus the ride");
	assert_eq!(out["timed"], 560);
	assert_eq!(out["seen"], json!(["boat", "boat-test", true, "b"]), "asked for the time the player gets to the pier, boarding at b");
	assert_eq!(out["fields"], json!(["boat-test", "b"]));
	assert_eq!(out["label"], "Take the boat to Testshire Docks\nNext boat in 1:20 (b)");
}

#[test]
fn c11_a_class_teleport_is_a_leg_from_the_start_when_it_is_faster_a_ghost_only_walks_with_no_error() {
	let out = run(r#"
		local r = {}
		Polestar.Transit = {
			Now = function() return 0 end,
			Teleports = function() return { { spell = 3561, name = "Teleport: Testshire", cast = 10, ready = 0,
				to = { name = "Testshire", c = 0, wx = -500, wy = -500, map = 9000, x = 75, y = 75 } } } end,
		}
		nav.place(0, 0, 1)
		target(-500, -480, "Quest")
		r.teleport = route()
		r.spell = leg("teleport").spell
		r.mode = N.Sample()
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		r.alive = route()
		UnitIsGhost = function() return true end
		target(0, -780, "Kobolds")
		r.ghost = route()
		emit(r)"#);
	assert_eq!(out["teleport"], json!(["teleport|Cast Teleport: Testshire", "walk|Quest"]));
	assert_eq!(out["spell"], 3561);
	assert_eq!(out["mode"], "instruction");
	assert_eq!(out["alive"], json!(["walk|Walk to the flight master", "fly|Fly to East Hold", "walk|Kobolds"]));
	assert_eq!(out["ghost"], json!(["walk|Kobolds"]));
}

#[test]
fn a_walk_in_portal_goes_one_way_only() {
	let out = run(r#"
		local r = {}
		N.RegisterTravelData({ portals = { { id = "gate", name = "Far Gate portal", seconds = 5,
			a = { "West Portal", 0, 0, 900, 9000, 5, 50 }, b = { "Far Gate", 1, 0, -400, 9001, 90, 50 } } } })
		nav.place(0, 850)
		N.SetTarget(9001, 80, 60, "Target")               -- Farland (-100, -300)
		r.there = route()
		r.mode = (function() nav.place(0, 899) return N.Sample() end)()
		nav.place(0, -400, 1)
		local m, x, y = nav.mapPoint(-890, 0)
		N.SetTarget(m, x, y, "Docks")
		r.back = route()
		emit(r)"#);
	assert_eq!(out["there"], json!(["walk|Walk to the portal", "portal|Take the portal to Far Gate", "walk|Target"]));
	assert_eq!(out["mode"], "instruction");
	assert_eq!(out["back"][0], "walk|Walk to the boat", "never back through it");
}

#[test]
fn t_11_skipping_a_hearth_leg_plans_this_target_without_the_hearthstone_another_target_may_hearth_again() {
	let out = run(r#"
		local r = {}
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		r.before = route()
		r.item = leg("hearth").item
		r.skipped = T.SkipLeg()
		r.after = route()
		target(-520, -680, "Other quest")
		r.other = route()[1]
		emit(r)"#);
	assert_eq!(out["before"], json!(["hearth|Hearth to Testshire Inn", "walk|Innkeeper quest"]));
	assert_eq!(out["item"], 6948);
	assert_eq!(out["skipped"], true);
	assert_eq!(out["after"], json!(["walk|Walk to the boat", "boat|Take the boat to Testshire Docks", "walk|Innkeeper quest"]));
	assert_eq!(out["other"], "hearth|Hearth to Testshire Inn");
}

#[test]
fn skipping_another_leg_moves_on_to_the_next_flights_list_every_node_they_hop() {
	let out = run(r#"
		local r = {}
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		local fly = leg("fly")
		r.stops = { #fly.stops, fly.stops[1].id, fly.stops[#fly.stops].id }
		T.SkipLeg()
		r.after = route()
		emit(r)"#);
	assert_eq!(out["stops"], json!([2, 1, 2]));
	assert_eq!(out["after"], json!(["fly|Fly to East Hold", "walk|Kobolds"]));
}

#[test]
fn t_11_after_skipping_the_hearthstone_a_class_teleport_is_still_planned() {
	let out = run(r#"
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		Polestar.Transit = {
			Now = function() return 0 end,
			Teleports = function() return { { spell = 3561, name = "Teleport: Testshire", cast = 10, ready = 200,
				to = { name = "Testshire", c = 0, wx = -480, wy = -690, map = 9000, x = 84.5, y = 74 } } } end,
		}
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		local before = route()[1]
		T.SkipLeg()
		emit({ before, route()[1] })"#);
	assert_eq!(out, json!(["hearth|Hearth to Testshire Inn", "teleport|Cast Teleport: Testshire"]));
}

#[test]
fn t_2_3_no_flight_leg_lands_at_or_passes_through_an_unknown_flight_master_the_known_set_is_read_on_every_plan() {
	let out = run(r#"
		local r = {}
		N.RegisterTravelData({ build = "test", inns = {}, transports = {},
			taxi = {
				{ 1, 0, 0, 900, 9000, 5, 5, 3, "North Post, Testshire" },
				{ 2, 0, 0, 0, 9000, 50, 50, 3, "Middle Post, Testshire" },
				{ 3, 0, 0, -900, 9000, 95, 95, 3, "South Post, Testshire" },
			},
			flights = { 1, 2, 900, 2, 1, 900, 2, 3, 900, 3, 2, 900 } }, true)
		known(1, 3)
		nav.place(0, 850)
		target(0, -890, "South")
		r.unknownMiddle = route()
		Polestar.CharState().flags.taxi[2] = true      -- learned in place, as the client does
		target(0, -890, "South")
		r.known = route()
		local legs = N.GetRoute()
		local stops = {}
		for _, n in ipairs(leg("fly").stops) do stops[#stops + 1] = n.id end
		r.stops = stops
		emit(r)"#);
	assert_eq!(out["unknownMiddle"], json!(["walk|South"]), "Middle Post unknown: no flight through it");
	assert_eq!(out["known"], json!(["walk|Walk to the flight master", "fly|Fly to South Post", "walk|South"]));
	assert_eq!(out["stops"], json!([1, 2, 3]));
}

#[test]
fn c9_a_flight_leg_carries_no_wait_only_flying_time_and_the_stops() {
	let out = run(r#"
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		emit(leg("fly").seconds)"#);
	assert_eq!(out, (1700.0_f64 / 30.0 + 2.0 + 0.5).floor());
}

#[test]
fn c15_the_other_faction_s_transports_are_neither_planned_nor_estimated() {
	let out = run(r#"
		local r = {}
		N.RegisterTravelData({ build = "test", taxi = {}, flights = {}, inns = {},
			transports = { { id = "tram-test", kind = "tram", faction = 1, ab = 100, ba = 100, waitA = 30, waitB = 30,
				a = { "Northgate", 0, 900, 0, 9000, 50, 5 }, b = { "Southgate", 0, -900, 0, 9000, 50, 95 } } } }, true)
		local m, x, y = nav.mapPoint(-950, 0)
		nav.place(890, 0)
		target(-950, 0, "South")
		r.alliance = route()[1]
		r.allianceEta = N.EstimateTravel(nil, { map = m, x = x, y = y })
		nav.faction = "Horde"
		stub.advance(10)                              -- past the estimate cache
		target(-950, 0, "South")
		r.horde = route()
		r.hordeEta = N.EstimateTravel(nil, { map = m, x = x, y = y })
		emit(r)"#);
	assert_eq!(out["alliance"], "tram|Take the tram to Southgate");
	assert_eq!(out["horde"], json!(["walk|South"]));
	assert!(out["hordeEta"].as_f64().unwrap() > out["allianceEta"].as_f64().unwrap(), "the estimate walks too ({} s vs {} s)", out["hordeEta"], out["allianceEta"]);
}

// ---------------------------------------------------------------------------
// Review fixes (code review at agent://ReviewCode, security review at agent://ReviewSecurity).

const TELEPORT: &str = r#"{ spell = 3561, name = "Teleport: Testshire", cast = 10, ready = 0,
	to = { name = "Testshire", c = 0, wx = -500, wy = -500, map = 9000, x = 75, y = 75 } }"#;

#[test]
fn review_p0_1_a_timetable_that_raises_or_answers_nonsense_never_breaks_planning_that_ride_waits_its_average() {
	let out = run(r#"
		local r = {}
		nav.place(0, 0, 1)
		Polestar.Transit = { Now = function() return 0 end, NextDeparture = function() error("stops[0]") end }
		target(-800, 100, "Docks quest")
		r.raises = leg("boat") and leg("boat").seconds
		Polestar.Transit = { Now = function() return 0 end, NextDeparture = function() return 0 / 0, 60 end }
		target(-800, 100, "Docks quest")
		r.nan = leg("boat") and leg("boat").seconds
		Polestar.Transit = { Now = function() return 0 end, NextDeparture = function() return -5, 60 end }
		target(-800, 100, "Docks quest")
		r.negative = leg("boat") and leg("boat").seconds
		emit(r)"#);
	assert_eq!(out, json!({ "raises": 90, "nan": 90, "negative": 90 }));
}

#[test]
fn security_m3_shared_times_replan_only_a_route_using_the_changed_service_at_most_every_20_s_own_rides_at_once() {
	let out = run(r#"
		local r, plans = {}, 0
		Polestar.On("ROUTE_CHANGED", function() plans = plans + 1 end)
		nav.place(0, 0, 1)
		target(-800, 100, "Docks quest")
		local function count(changed, own)
			local before = plans
			Polestar.Fire("NAV_TRANSIT", changed, own)
			return plans - before
		end
		stub.advance(30)
		r.other = count({ ["zeppelin-x"] = "zeppelin" })
		r.own = count({ ["zeppelin-x"] = "zeppelin" }, true)
		r.all = count(nil)
		stub.advance(30)
		r.used = count({ ["boat-test"] = "boat" })
		r.tooSoon = count({ ["boat-test"] = "boat" })
		local before = plans
		stub.advance(21)
		Polestar.Nav.Refresh()
		r.owed = plans - before
		emit(r)"#);
	assert_eq!(out, json!({ "other": 0, "used": 1, "tooSoon": 0, "own": 1, "all": 1, "owed": 1 }));
}

#[test]
fn review_p2_4_progress_counts_a_ride_flight_or_hearth_down_from_when_it_became_current() {
	let out = run(r#"
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		nav.place(0, 0, 1)
		target(-520, -690, "Innkeeper quest")
		local T = Polestar.Nav.travel
		local a = T.Progress()
		stub.advance(5)
		local b = T.Progress()
		stub.advance(60)
		emit({ a, b, T.Progress() })"#);
	assert_eq!(out, json!([15, 10, 0]));
}

#[test]
fn review_p2_5_the_arrow_eta_adds_the_1_25_detour_only_to_straight_distances_not_to_path_yards() {
	let out = run(r#"
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		local T = Polestar.Nav.travel
		local legs = N.GetRoute()
		local rest = legs[1].rest
		emit({ T.Remaining(70, true) - rest, T.Remaining(70) - rest })"#);
	assert_eq!(out, json!([10, 12.5]));
}

#[test]
fn review_p2_6_skipping_a_teleport_a_flight_or_a_ride_plans_the_rest_of_the_way_without_it() {
	let out = run(&r#"
		local r = {}
		Polestar.Transit = { Now = function() return 0 end, Teleports = function() return { @TELEPORT@ } end }
		nav.place(0, 0, 1)
		target(-500, -480, "Quest")
		r.teleport = route()[1]
		T.SkipLeg()
		r.afterTeleport = route()[1]
		target(-500, -470, "Other")
		r.otherTarget = route()[1]
		Polestar.Transit = nil
		known(1, 2)
		nav.place(0, 790)
		target(0, -780, "Kobolds")
		T.SkipLeg()
		r.afterFlight = route()
		nav.place(0, 0, 1)
		target(-800, 100, "Docks quest")
		while T.CurrentLeg() and T.CurrentLeg().kind ~= "boat" do T.SkipLeg() end
		T.SkipLeg()
		r.afterBoat = #route()
		emit(r)"#
		.replace("@TELEPORT@", TELEPORT));
	assert_eq!(out["teleport"], "teleport|Cast Teleport: Testshire");
	assert_eq!(out["afterTeleport"], "walk|Walk to the boat", "without that spell for this target");
	assert_eq!(out["otherTarget"], "teleport|Cast Teleport: Testshire", "another target may cast it again");
	assert_eq!(out["afterFlight"], json!(["walk|Kobolds"]));
	assert_eq!(out["afterBoat"], 0, "no other way across: nothing left to follow");
}

#[test]
fn security_l6_estimates_evict_the_oldest_entry_instead_of_wiping_the_cache_and_stop_planning_for_the_frame_past_25_ms() {
	let out = run(r#"
		local r, plans = {}, 0
		local plan = N.PlanRoute
		N.PlanRoute = function(p) plans = plans + 1 return plan(p) end
		local function at(i) local m, x, y = nav.mapPoint(-900 + i * 10, -500) return { map = m, x = x, y = y } end
		nav.place(0, 0)
		for i = 1, 65 do N.EstimateTravel(nil, at(i)) end
		local before = plans
		N.EstimateTravel(nil, at(1))
		r.oldestGone = plans - before
		before = plans
		N.EstimateTravel(nil, at(3))
		r.othersKept = plans - before
		stub.advance(10)
		local t = 0
		debugprofilestop = function() t = t + 30 return t end
		N.EstimateTravel(nil, at(1))
		local first, why = N.EstimateTravel(nil, at(2), true)
		r.busy = { first == nil, why }
		stub.advance(0.02)
		r.nextFrame = select(2, N.EstimateTravel(nil, at(2), true)) ~= "busy"
		emit(r)"#);
	assert_eq!(out["oldestGone"], 1);
	assert_eq!(out["othersKept"], 0);
	assert_eq!(out["busy"], json!([true, "busy"]));
	assert_eq!(out["nextFrame"], true);
}

#[test]
fn second_review_p2_a_ranking_burst_past_the_estimate_budget_still_compares_full_plans_only() {
	let out = run(r#"
		known(1, 2)
		nav.place(0, 700)
		local function place(id, wx, wy)
			local m, x, y = nav.mapPoint(wx, wy)
			return { id = id, c = 0, wx = wx, wy = wy, map = m, x = x, y = y }
		end
		-- Nearer in a straight line: a long walk. Farther: a short flight away.
		local walk, flight = place(1, 900, 700), place(2, 0, -780)
		-- Every plan "takes" 30 ms (the planner's own clock checks see no time pass).
		local t, plan = 0, N.PlanRoute
		debugprofilestop = function() return t end
		N.PlanRoute = function(p) local legs, why = plan(p) t = t + 30 return legs, why end
		local seen = {}
		local best = N.nearby.Rank({ walk, flight }, { c = 0, wx = 0, wy = 700 }, function(p)
			local s = N.journey.Estimate(nil, p)
			seen[#seen + 1] = s
			return s
		end)
		stub.advance(10)
		emit({ best = best.id, seen = seen, planned = { N.EstimateTravel(nil, walk), N.EstimateTravel(nil, flight) } })"#);
	assert_eq!(out["seen"].as_array().unwrap().len(), 2);
	assert_eq!(out["seen"], out["planned"], "both candidates got the planner's answer, not a straight line");
	assert!(out["planned"][1].as_f64().unwrap() < out["planned"][0].as_f64().unwrap(), "the flight is the quicker one");
	assert_eq!(out["best"], 2);
}

#[test]
fn second_review_p2_api_estimate_answers_busy_past_the_budget_and_a_number_the_next_frame() {
	let out = run(r#"
		nav.place(0, 0)
		local function at(i) local m, x, y = nav.mapPoint(-900 + i * 10, -500) return m, x / 100, y / 100 end
		local t, plan = 0, N.PlanRoute
		debugprofilestop = function() return t end
		N.PlanRoute = function(p) local legs, why = plan(p) t = t + 30 return legs, why end
		local r = {}
		r.first = type(N.API.Estimate(nil, nil, nil, at(1))) == "number"
		local s, why = N.API.Estimate(nil, nil, nil, at(2))
		r.busy = { s == nil, why }
		local m, x, y = at(3)
		r.internal = type(N.EstimateTravel(nil, { map = m, x = x * 100, y = y * 100 })) == "number"
		stub.advance(0.02)
		r.nextFrame = type(N.API.Estimate(nil, nil, nil, at(2))) == "number"
		emit(r)"#);
	assert_eq!(out["first"], true, "the frame's first estimate is planned");
	assert_eq!(out["busy"], json!([true, "busy"]), "no straight line stands in for it");
	assert_eq!(out["internal"], true, "Polestar's own estimates are never refused");
	assert_eq!(out["nextFrame"], true);
}

#[test]
fn second_review_p3_the_arrow_and_the_panel_count_down_alike_while_waiting_at_a_dock() {
	let out = run(r#"
		nav.place(400, 0, 1)
		target(-800, 100, "Docks quest")
		local leg = T.CurrentLeg()
		local before = T.Remaining(nil)
		stub.advance(20)
		local s = T.Progress()
		local secs = math.floor(T.Remaining(nil) + 0.5)
		emit({ kind = leg.kind, waited = before - T.Remaining(nil), agree = T.Remaining(nil) - (s + leg.rest),
			mode = Polestar.Nav.arrow.GetMode(), eta = Polestar.Nav.arrow.etaText:GetText(),
			want = string.format("%d:%02d total", math.floor(secs / 60), secs % 60) })"#);
	assert_eq!(out["kind"], "boat");
	assert_eq!(out["waited"], 20);
	assert_eq!(out["agree"], 0, "Remaining is Progress plus the legs after it");
	assert_eq!(out["mode"], "instruction");
	assert_eq!(out["eta"], out["want"], "the arrow shows the countdown");
}

#[test]
fn second_review_p3_a_flight_counts_down_from_take_off_not_from_reaching_the_flight_master() {
	let out = run(r#"
		known(1, 2)
		nav.place(0, 790)
		target(0, -780, "Kobolds")
		local leg = T.CurrentLeg()
		stub.advance(30)                       -- talking to the flight master
		nav.taxi = true
		Polestar.Nav.Refresh()
		stub.advance(10)
		emit({ kind = leg.kind, seconds = leg.seconds, left = T.Progress(), remaining = T.Remaining(nil) - leg.rest })"#);
	assert_eq!(out["kind"], "fly");
	let seconds = out["seconds"].as_f64().unwrap();
	assert!(seconds > 40.0, "a flight long enough to tell");
	assert_eq!(out["left"], seconds - 10.0);
	assert_eq!(out["remaining"], seconds - 10.0);
}

#[test]
fn review_p3_10_the_arrow_dial_shows_the_leg_s_own_glyph_for_a_teleport() {
	let out = run(&r#"
		Polestar.Transit = { Now = function() return 0 end, Teleports = function() return { @TELEPORT@ } end }
		nav.place(0, 0, 1)
		target(-500, -480, "Quest")
		stub.advance(0.2)
		local A = Polestar.Nav.arrow
		emit({ A.GetMode(), (A.legIcon:GetTexture() or ""):match("[^\\]+$") })"#
		.replace("@TELEPORT@", TELEPORT));
	assert_eq!(out, json!(["instruction", "icon-use"]));
}
