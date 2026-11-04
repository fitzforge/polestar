//! The travel route's trail (Pins.SetTrail, published by Nav/Layers.lua): dots from the player along the
//! route's lines on the minimap and the world map. Real Core/Init.lua + Nav/Nav.xml against
//! tests/lua/stub_nav.lua (map 9000: 2000 yd across, 20 yd per map percent, origin at its centre; map 9001 on
//! continent 1, 1000 yd across; a 140 px minimap).

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

type Pt = (f64, f64);

const MM_SPACING: f64 = 40.0; // yards between minimap dots
const MM_LIMIT: f64 = (70.0 - 2.5) / 0.35; // yards from the player a 5 px dot may sit at, view radius 200 on a 140 px minimap

fn world_spacing(yards_across: f64) -> f64 {
	(yards_across / 60.0).max(15.0)
}

const PRELUDE: &str = r#"
local N, Pins, nav = Polestar.Nav, Polestar.Pins, stub.nav
local function target(wx, wy, label)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, label or "Target")
end
local function known(...)
	local flags = Polestar.CharState().flags
	flags.taxi = {}
	for _, id in ipairs({ ... }) do flags.taxi[id] = true end
end
local function route()
	local legs, ci = N.GetRoute()
	local out = {}
	for i = ci or 1, legs and #legs or 0 do out[#out + 1] = legs[i].kind end
	return out
end
-- Minimap dots: pixel offsets and the world points they show (north-up minimap).
local function mmDots()
	local out = {}
	local scale = Minimap:GetWidth() / 2 / nav.viewRadius
	for i, t in ipairs(Pins.GetTrailFrames("minimap")) do
		local _, _, _, x, y = t:GetPoint(1)
		out[i] = { x = x, y = y, wx = nav.player.wx + y / scale, wy = nav.player.wy - x / scale }
	end
	return out
end
-- World map dots on map id: map percent and the world points they show.
local function worldDots(id)
	local b, out = nav.maps[id], {}
	for i, dot in ipairs(Pins.GetTrailFrames("world")) do
		local x, y = nav.worldPoint(dot)
		out[i] = { x = x, y = y, wx = b.top + (b.bottom - b.top) * y / 100, wy = b.left + (b.right - b.left) * x / 100 }
	end
	return out
end
-- The published trail: runs of world points.
local function runsOf()
	local t = Pins.GetTrail()
	local out = { n = 0, list = {} }
	for i, run in ipairs(t and t.runs or {}) do
		local pts = {}
		for k = 1, run.n do pts[k] = { run.wx[k], run.wy[k] } end
		out.list[i] = { c = run.c, live = run.live, pts = pts }
		out.n = i
	end
	return out
end
"#;

fn run(script: &str) -> Vec<Value> {
	emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml"])],
		login: true,
		script: format!("{PRELUDE}\nnav.faction = \"Alliance\"\nnav.useTravelWorld()\n{script}"),
		..Default::default()
	})
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

fn arr(v: &Value) -> &Vec<Value> {
	v.as_array().unwrap_or_else(|| panic!("not an array: {v}"))
}

// Dots along a world polyline, anchored to its end: dot k sits (k + frac) * spacing yards before the last
// point; the start carries none. From the start.
fn expect_dots(pts: &[Pt], spacing: f64, frac: f64) -> Vec<Pt> {
	let n = pts.len();
	let mut rem = vec![0.0; n];
	for i in (0..n - 1).rev() {
		rem[i] = rem[i + 1] + (pts[i + 1].0 - pts[i].0).hypot(pts[i + 1].1 - pts[i].1);
	}
	let mut out = Vec::new();
	let mut k = (rem[0] / spacing - frac).ceil() as i64 - 1;
	while k >= 0 {
		let d = (k as f64 + frac) * spacing;
		let mut i = 0;
		while i < n - 2 && rem[i + 1] > d {
			i += 1;
		}
		let t = (rem[i] - d) / (rem[i] - rem[i + 1]);
		out.push((pts[i].0 + (pts[i + 1].0 - pts[i].0) * t, pts[i].1 + (pts[i + 1].1 - pts[i].1) * t));
		k -= 1;
	}
	out
}

// The world points (wx, wy) of drawn dots; none for a missing list.
fn wxy(drawn: &Value) -> Vec<Pt> {
	drawn.as_array().map(|a| a.iter().map(|d| (num(&d["wx"]), num(&d["wy"]))).collect()).unwrap_or_default()
}

// Drawn dots match the expected world points, in order.
fn assert_dots(got: &[Pt], expected: &[Pt], what: &str) {
	assert_eq!(got.len(), expected.len(), "{what}: {} dots, expected {}", got.len(), expected.len());
	for (i, (&(wx, wy), &(ex, ey))) in got.iter().zip(expected).enumerate() {
		assert!((wx - ex).abs() < 1e-6 && (wy - ey).abs() < 1e-6, "{what}: dot {} at {wx},{wy}, expected {ex},{ey}", i + 1);
	}
}

fn assert_points(got: &Value, expected: &[Pt], what: &str) {
	let got = arr(got);
	assert_eq!(got.len(), expected.len(), "{what}");
	for (i, (p, &(ex, ey))) in got.iter().zip(expected).enumerate() {
		let (px, py) = (num(&p[0]), num(&p[1]));
		assert!((px - ex).abs() < 1e-6 && (py - ey).abs() < 1e-6, "{what}: point {} {px},{py}, expected {ex},{ey}", i + 1);
	}
}

fn round6(x: f64) -> f64 {
	(x * 1e6).round() / 1e6
}

#[test]
fn placement_a_dot_every_spacing_counted_back_from_the_end_continuous_over_joints_clipped_and_capped() {
	let out = run(r#"
		local function dots(...) local n, pts = Pins.TrailDots(...) return { n = n, pts = pts } end
		local L = { { 0, 0 }, { 100, 0 }, { 100, 100 } }
		emit({
			half = dots(L, 40, 0.5),
			zero = dots(L, 40, 0),
			clipped = dots(L, 40, 0.5, { 0, -10, 50, 10 }),
			capped = dots(L, 40, 0.5, nil, 3),
			later = dots({ { 30, 0 }, { 100, 0 }, { 100, 100 } }, 40, 0.5),
		})"#);
	let out = &out[0];
	assert_points(&out["half"]["pts"], &[(20.0, 0.0), (60.0, 0.0), (100.0, 0.0), (100.0, 40.0), (100.0, 80.0)], "phase 0.5");
	assert_points(&out["zero"]["pts"], &[(40.0, 0.0), (80.0, 0.0), (100.0, 20.0), (100.0, 60.0), (100.0, 100.0)], "phase 0: a dot on the end");
	assert_points(&out["clipped"]["pts"], &[(20.0, 0.0)], "only the part inside the rectangle");
	assert_points(&out["capped"]["pts"], &[(20.0, 0.0), (60.0, 0.0), (100.0, 0.0)], "the cap keeps the dots nearest the start");
	assert_points(&out["later"]["pts"], &[(60.0, 0.0), (100.0, 0.0), (100.0, 40.0), (100.0, 80.0)], "a later start keeps the dots in place");
}

#[test]
fn minimap_dots_40_yd_apart_inside_the_visible_disc_or_square_honouring_rotation_and_the_indoor_zoom() {
	let out = run(r#"
		Polestar.Set("nav.travel", false)
		Polestar.Set("ui.reduceMotion", true)
		nav.viewRadius = 200
		nav.place(0, 0)
		target(0, -900)                                   -- 900 yd east
		local r = {}
		r.east = mmDots()
		target(-700, -500)                                -- south-east
		r.round = mmDots()
		function GetMinimapShape() return "SQUARE" end
		stub.advance(0.2)                                 -- the watcher notices the shape
		r.square = mmDots()
		GetMinimapShape = nil
		target(0, -900)
		SetCVar("rotateMinimap", "1")
		nav.facing = math.pi / 2                          -- facing west: east is behind
		stub.advance(0.2)
		r.rotated = {}
		for i, t in ipairs(Pins.GetTrailFrames("minimap")) do
			local _, _, _, x, y = t:GetPoint(1)
			r.rotated[i] = { x, y }
		end
		SetCVar("rotateMinimap", "0")
		nav.viewRadius = nil                              -- no C_Minimap.GetViewRadius: zoom tables
		nav.indoors = true                                -- 300 yd across at zoom 0
		stub.advance(0.2)
		r.indoor = #Pins.GetTrailFrames("minimap")
		local t = Pins.GetTrailFrames("minimap")[1]
		r.look = { t:GetWidth(), select(4, t:GetVertexColor()) }
		r.levels = { t.parent:GetFrameLevel(), Pins.GetMinimapFrames("nav.target")[1]:GetFrameLevel() }
		emit(r)"#);
	let out = &out[0];
	// Phase 0.5 (held still): dots 20, 60, ... yd before the target, so 40, 80, 120, 160 yd east of the player.
	let east: Vec<f64> = arr(&out["east"]).iter().map(|d| round6(num(&d["x"]))).collect();
	assert_eq!(east, vec![14.0, 28.0, 42.0, 56.0], "14 px (40 yd) apart, the 200 yd one clipped");
	assert!(arr(&out["east"]).iter().all(|d| num(&d["y"]).abs() < 1e-9));
	let diagonal = expect_dots(&[(0.0, 0.0), (-700.0, -500.0)], MM_SPACING, 0.5);
	let round: Vec<Pt> = diagonal.iter().copied().filter(|&(n, w)| n.hypot(w) <= MM_LIMIT).collect();
	assert_dots(&wxy(&out["round"]), &round, "round minimap");
	let square: Vec<Pt> = diagonal.iter().copied().filter(|&(n, w)| n.abs().max(w.abs()) <= MM_LIMIT).collect();
	assert_dots(&wxy(&out["square"]), &square, "square minimap");
	assert!(arr(&out["square"]).len() > arr(&out["round"]).len(), "the square reaches further along a diagonal");
	let rotated: Vec<Pt> = arr(&out["rotated"]).iter().map(|p| (round6(num(&p[0])), round6(num(&p[1])))).collect();
	assert_eq!(rotated, vec![(0.0, -14.0), (0.0, -28.0), (0.0, -42.0), (0.0, -56.0)]);
	assert_eq!(out["indoor"], 3, "indoors the view is 150 yd: dots at 40, 80 and 120 yd");
	assert_eq!(out["look"], json!([5, 0.85]));
	let (l0, l1) = (num(&out["levels"][0]), num(&out["levels"][1]));
	assert!(l0 < l1, "dots (level {l0}) under the target pin ({l1})");
}

#[test]
fn world_map_spacing_scales_with_the_viewed_map_60_to_its_width_at_least_15_yd_clipped_to_the_map() {
	let out = run(r#"
		Polestar.Set("nav.travel", false)
		Polestar.Set("ui.reduceMotion", true)
		nav.maps[9002] = { c = 0, top = 200, bottom = -200, left = 200, right = -200, name = "Tinyshire" }
		nav.place(0, 0)
		target(0, -900)
		local r = {}
		nav.showWorldMap(9000)
		r.zone = worldDots(9000)
		nav.showWorldMap(9002)
		r.small = worldDots(9002)
		nav.place(0, 1400)                                -- 400 yd off the map's west edge
		target(0, 0)
		nav.showWorldMap(9000)
		r.clipped = worldDots(9000)
		local dot = Pins.GetTrailFrames("world")[1]
		r.pin = { dot.width, dot.parent:IsMouseEnabled() and true or false, dot.parent:GetFrameLevel() }
		emit(r)"#);
	let out = &out[0];
	let line = [(0.0, 0.0), (0.0, -900.0)];
	assert_dots(&wxy(&out["zone"]), &expect_dots(&line, world_spacing(2000.0), 0.5), "map 9000: 33.3 yd apart");
	assert_eq!(arr(&out["zone"]).len(), 27);
	let small: Vec<Pt> = expect_dots(&line, world_spacing(400.0), 0.5).into_iter().filter(|&(_, w)| w >= -200.0).collect();
	assert_dots(&wxy(&out["small"]), &small, "map 9002: the 15 yd floor");
	assert_eq!(arr(&out["small"]).len(), 13);
	let far = expect_dots(&[(0.0, 1400.0), (0.0, 0.0)], world_spacing(2000.0), 0.5);
	let on_map: Vec<Pt> = far.iter().copied().filter(|&(_, w)| w <= 1000.0).collect();
	assert_dots(&wxy(&out["clipped"]), &on_map, "only the part on the map");
	assert!(far.len() > arr(&out["clipped"]).len());
	assert!(arr(&out["clipped"]).iter().all(|d| {
		let (x, y) = (num(&d["x"]), num(&d["y"]));
		(0.0..=100.0).contains(&x) && (0.0..=100.0).contains(&y)
	}));
	assert_eq!(out["pin"], json!([6, false, 2010]), "small, no mouse, under the pins (the map's PIN_FRAME_LEVEL_QUEST_BLOB)");
}

#[test]
fn a_flight_route_dots_run_from_the_player_along_every_leg_on_both_surfaces() {
	let out = run(r#"
		Polestar.Set("ui.reduceMotion", true)
		nav.viewRadius = 200
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		nav.showWorldMap(9000)
		emit({ route = route(), runs = runsOf(), world = worldDots(9000), mm = mmDots() })"#);
	let out = &out[0];
	assert_eq!(out["route"], json!(["walk", "fly", "walk"]));
	assert_eq!(out["runs"]["n"], 1);
	assert_eq!(out["runs"]["list"][0]["live"], true);
	assert_points(&out["runs"]["list"][0]["pts"], &[(0.0, 790.0), (0.0, -800.0), (0.0, -780.0)], "flight master, East Hold, target");
	let line = [(0.0, 600.0), (0.0, 790.0), (0.0, -800.0), (0.0, -780.0)];
	assert_dots(&wxy(&out["world"]), &expect_dots(&line, world_spacing(2000.0), 0.5), "world map");
	assert_eq!(arr(&out["world"]).len(), 54, "1800 yd of route");
	let mm: Vec<Pt> = expect_dots(&line, MM_SPACING, 0.5).into_iter().filter(|&(n, w)| n.hypot(w - 600.0) <= MM_LIMIT).collect();
	assert_dots(&wxy(&out["mm"]), &mm, "minimap");
}

#[test]
fn no_dots_across_a_continent_change_or_along_a_hearthstone_jump() {
	let out = run(r#"
		Polestar.Set("ui.reduceMotion", true)
		nav.place(0, 0, 1)                                -- Farland, continent 1
		target(-800, 100, "Docks quest")
		local r = { route = route(), runs = runsOf() }
		nav.showWorldMap(9001)
		r.farland = worldDots(9001)
		nav.showWorldMap(9000)
		r.testshire = worldDots(9000)
		emit(r)
		nav.items[6948] = 1
		nav.bind = "Testshire Inn"
		nav.place(800, 800, 0)
		target(-200, -400, "Inn quest")
		nav.showWorldMap(9000)
		emit({ route = route(), runs = runsOf(), world = worldDots(9000) })"#);
	let (boat, hearth) = (&out[0], &out[1]);
	assert_eq!(boat["route"], json!(["walk", "boat", "walk"]));
	assert_eq!(boat["runs"]["n"], 2, "the sea crossing breaks the line");
	let list = &boat["runs"]["list"];
	assert_eq!(json!([list[0]["c"].clone(), list[0]["live"].clone(), list[1]["c"].clone(), list[1]["live"].clone()]), json!([1, true, 0, false]));
	assert_dots(&wxy(&boat["farland"]), &expect_dots(&[(0.0, 0.0), (400.0, 0.0)], world_spacing(1000.0), 0.5), "Farland: to the pier only");
	assert_dots(&wxy(&boat["testshire"]), &expect_dots(&[(-900.0, 0.0), (-800.0, 100.0)], world_spacing(2000.0), 0.5), "Testshire: from the docks only");

	assert_eq!(hearth["route"], json!(["hearth", "walk"]));
	assert_eq!(hearth["runs"]["n"], 1, "nothing between the player and the inn");
	assert_eq!(hearth["runs"]["list"][0]["live"], false);
	assert_dots(&wxy(&hearth["world"]), &expect_dots(&[(-500.0, -700.0), (-200.0, -400.0)], world_spacing(2000.0), 0.5), "from the inn to the target only");
}

#[test]
fn counts_are_capped_40_on_the_minimap_300_on_the_world_map() {
	let out = run(r#"
		Polestar.Set("nav.travel", false)
		Polestar.Set("ui.reduceMotion", true)
		nav.viewRadius = 3000
		nav.place(0, 1000)
		target(0, -1000)                                  -- 2000 yd in view: 50 dots
		local r = { mm = #Pins.GetTrailFrames("minimap") }
		local legs = {}                                   -- a winding route, ~1800 yd a leg
		for i = 1, 30 do
			legs[i] = { kind = "walk", label = "Leg " .. i, to = { c = 0, wx = i % 2 == 0 and 900 or -900, wy = 900 - i * 60 } }
		end
		N.GetRoute = function() return legs, 1 end
		Polestar.Fire("ROUTE_CHANGED", legs)
		nav.showWorldMap(9000)
		r.world = #Pins.GetTrailFrames("world")
		r.pool = #Pins.GetTrailFrames("world")[1].parent.regions
		emit(r)"#);
	let out = &out[0];
	assert_eq!(out["mm"], 40);
	assert_eq!(out["world"], 300);
	assert_eq!(out["pool"], 300, "no dots made beyond the cap");
}

#[test]
fn the_dots_crawl_toward_the_target_while_shown_and_hold_still_with_reduced_motion() {
	let out = run(r#"
		Polestar.Set("nav.travel", false)
		nav.viewRadius = 200
		nav.place(0, 0)
		target(0, -900)
		stub.advance(0.1)
		local function xs() local out = {} for i, d in ipairs(mmDots()) do out[i] = d.x end return out end
		local r = {}
		r.x0 = xs()
		r.driver = Pins.trailDriver:IsShown()
		stub.advance(0.5)
		r.x1 = xs()
		Minimap:Hide()
		stub.advance(0.2)
		r.hidden = Pins.trailDriver:IsShown()
		Minimap:Show()
		stub.advance(0.3)
		r.shown = Pins.trailDriver:IsShown()
		Polestar.Set("ui.reduceMotion", true)
		r.s0 = xs()
		stub.advance(1)
		r.s1 = xs()
		r.still = Pins.trailDriver:IsShown()
		r.before = mmDots()
		nav.place(0, -10)                                 -- walk 10 yd along the line
		stub.advance(0.2)
		r.after = mmDots()
		emit(r)"#);
	let out = &out[0];
	// x px = 0.35 * (900 - (k + phase) * 40): recover the phase from the first dot.
	let phase = |x: f64| ((900.0 - x / 0.35) / 40.0 % 1.0 + 1.0) % 1.0;
	let moved = ((phase(num(&out["x0"][0])) - phase(num(&out["x1"][0]))) % 1.0 + 1.0) % 1.0;
	assert!((moved - 0.5 / 1.5).abs() < 0.04, "0.5 s moved the dots {moved} of a spacing toward the target");
	assert_eq!(out["driver"], true);
	assert_eq!(out["hidden"], false, "no animation while the minimap is hidden");
	assert_eq!(out["shown"], true, "it resumes once the minimap shows again");
	assert_eq!(out["s1"], out["s0"], "reduced motion: the dots hold still");
	assert_eq!(out["still"], false, "and nothing runs per frame");
	let (before, after) = (wxy(&out["before"]), wxy(&out["after"]));
	assert!(after.len() >= before.len());
	for (wx, wy) in before {
		assert!(after.iter().any(|&(ex, ey)| (ex - wx).abs() < 1e-6 && (ey - wy).abs() < 1e-6), "the dot at {wx},{wy} stays put as the player walks");
	}
}

#[test]
fn nav_traildots_nav_worldpins_and_nav_minimappins_switch_the_trail_no_target_no_trail() {
	let out = run(r#"
		Polestar.Set("nav.travel", false)
		nav.viewRadius = 200
		nav.place(0, 0)
		target(0, -900)
		nav.showWorldMap(9000)
		local function counts() return { #Pins.GetTrailFrames("minimap"), #Pins.GetTrailFrames("world") } end
		local r = {}
		stub.advance(0.1)
		r.on = counts()
		r.driverOn = Pins.trailDriver:IsShown()
		Polestar.Set("nav.trailDots", false)
		r.off = counts()
		r.gone = Pins.GetTrail() == nil
		stub.advance(0.2)
		r.driver = Pins.trailDriver:IsShown()
		Polestar.Set("ui.reduceMotion", true)            -- phase 0.5 from here: 4 minimap dots
		Polestar.Set("nav.trailDots", true)
		r.back = counts()
		Polestar.Set("nav.minimapPins", false)
		r.noMinimap = counts()
		Polestar.Set("nav.minimapPins", true)
		Polestar.Set("nav.worldPins", false)
		r.noWorld = counts()
		Polestar.Set("nav.worldPins", true)
		N.ReleaseTarget()
		r.noTarget = counts()
		emit(r)"#);
	let out = &out[0];
	let on0 = num(&out["on"][0]);
	assert!((4.0..=5.0).contains(&on0) && out["on"][1] == 27, "on: {},{}", out["on"][0], out["on"][1]);
	assert_eq!(out["driverOn"], true);
	assert_eq!(out["off"], json!([0, 0]));
	assert_eq!(out["gone"], true);
	assert_eq!(out["driver"], false, "the animation stops with the trail");
	assert_eq!(out["back"], json!([4, 27]));
	assert_eq!(out["noMinimap"], json!([0, 27]));
	assert_eq!(out["noWorld"], json!([4, 0]));
	assert_eq!(out["noTarget"], json!([0, 0]));
}

#[test]
fn the_trail_follows_the_route_as_its_legs_advance_route_advanced() {
	let out = run(r#"
		Polestar.Set("ui.reduceMotion", true)
		nav.viewRadius = 200
		known(1, 2)
		nav.place(0, 600)
		target(0, -780)
		local advanced = 0
		Polestar.On("ROUTE_ADVANCED", function() advanced = advanced + 1 end)
		local before = Pins.GetTrail()
		nav.place(0, 785)                                 -- at the flight master: the walk is done
		stub.advance(0.2)
		local r = { advanced = advanced, republished = Pins.GetTrail() ~= before, route = route(), runs = runsOf() }
		local legs = N.GetRoute()                         -- on to the last leg: straight to the target
		N.GetRoute = function() return legs, 3 end
		Polestar.Fire("ROUTE_ADVANCED", legs, 3)
		r.last = { runs = runsOf(), mm = mmDots() }
		emit(r)"#);
	let out = &out[0];
	assert!(num(&out["advanced"]) >= 1.0);
	assert_eq!(out["republished"], true, "a new trail on the advance");
	assert_eq!(out["route"], json!(["fly", "walk"]));
	assert_points(&out["runs"]["list"][0]["pts"], &[(0.0, 790.0), (0.0, -800.0), (0.0, -780.0)], "from the flight master on");
	assert_eq!(out["last"]["runs"]["n"], 1);
	assert_points(&out["last"]["runs"]["list"][0]["pts"], &[(0.0, -780.0)], "only the target is left");
	let line = [(0.0, 785.0), (0.0, -780.0)];
	let mm: Vec<Pt> = expect_dots(&line, MM_SPACING, 0.5).into_iter().filter(|&(n, w)| n.hypot(w - 785.0) <= MM_LIMIT).collect();
	assert_dots(&wxy(&out["last"]["mm"]), &mm, "minimap");
}

// OpenMap's stitched map (OpenMapAPI, a fake): every map placed on one world, 0..1 across and down. Map 9000
// (continent 0) and 9001 (continent 1) as on that world; 9002 inside 9000 where its yards put it; 947 the world
// itself, the two as its children. The view is the map frame's scroll frame (WorldMapFrame.ScrollContainer)
// over the 1000 px canvas.
const OPENMAP: &str = r#"
local rects = { [947] = { 0, 1, 0, 1 }, [9000] = { 0.1, 0.4, 0.2, 0.6 }, [9001] = { 0.6, 0.8, 0.3, 0.5 },
	[9002] = { 0.22, 0.28, 0.36, 0.44 } }
local OM = { major = 1, version = 1, stitched = true, toggles = {}, callbacks = {}, calls = 0 }
OpenMapAPI = OM
function OM.IsStitched() return OM.stitched end
function OM.WorldFromMap(id, x, y)
	OM.calls = OM.calls + 1
	local r = rects[id]
	if r then return r[1] + x * (r[2] - r[1]), r[3] + y * (r[4] - r[3]) end
end
function OM.MapFromWorld(id, u, v)
	OM.calls = OM.calls + 1
	local r = rects[id]
	if r then return (u - r[1]) / (r[2] - r[1]), (v - r[3]) / (r[4] - r[3]) end
end
function OM.RegisterMenuToggle(owner, spec) OM.toggles[owner .. "." .. spec.id] = spec end
function OM.RegisterCallback(owner, event, fn) OM.callbacks[event] = fn end
function C_Map.GetMapChildrenInfo(id)
	if id == 947 then return { { mapID = 9000 }, { mapID = 9001 } } end
	return {}
end
local sc = WorldMapFrame.ScrollContainer
-- the view: the scroll frame over canvas percent x0..x1, y0..y1 (the canvas: 1000 px at 0, 0)
local function view(x0, y0, x1, y1)
	sc.x, sc.width = x0 * 10, (x1 - x0) * 10
	sc.height = (y1 - y0) * 10
	sc.y = 1000 - y1 * 10
end
view(0, 0, 100, 100)
-- the dots drawn: percent of the viewed map
local function rawDots()
	local out = {}
	for i, dot in ipairs(Pins.GetTrailFrames("world")) do
		local x, y = nav.worldPoint(dot)
		out[i] = { x = x, y = y }
	end
	return out
end
"#;

// The spacing on OpenMap's map: a 60th of the view's width in yards, at least 15 yd, in steps of twice the last.
fn stitched_spacing(yards_across: f64) -> f64 {
	let raw = yards_across / 60.0;
	if raw <= 15.0 {
		15.0
	} else {
		15.0 * 2f64.powf(((raw / 15.0).log2() - 1e-9).ceil())
	}
}

#[test]
fn openmap_on_a_zone_the_dots_run_on_past_its_edges_as_far_as_the_view_shows_through_openmap_s_placement() {
	let out = run(&(OPENMAP.to_string()
		+ r#"
		Polestar.Set("nav.travel", false)
		Polestar.Set("ui.reduceMotion", true)
		nav.maps[9002] = { c = 0, top = 200, bottom = -200, left = 200, right = -200, name = "Tinyshire" }
		nav.place(0, 0)
		target(0, -900)
		view(-100, -100, 200, 200)                       -- three of Tinyshire's widths across
		nav.showWorldMap(9002)
		local r = { dots = rawDots() }
		OM.stitched = false                              -- Blizzard's own map again
		OM.callbacks.OpenMap_StitchedChanged(false)
		stub.runMapFrame(WorldMapFrame, 0)
		r.plain = worldDots(9002)
		r.writes = #stub.mapWrites
		emit(r)"#));
	let out = &out[0];
	// 9002 percent -> yards: wy = 200 - 4 * x, wx = 200 - 4 * y
	let dots: Vec<Pt> = arr(&out["dots"]).iter().map(|d| (200.0 - 4.0 * num(&d["y"]), 200.0 - 4.0 * num(&d["x"]))).collect();
	let spacing = stitched_spacing(300.0 * 4.0); // 1200 yd across: 30 yd
	assert_eq!(spacing, 30.0);
	let reach = 200.0 + 300.0 * 0.04; // the view's right edge and its margin, in percent
	let want: Vec<Pt> = expect_dots(&[(0.0, 0.0), (0.0, -900.0)], spacing, 0.5).into_iter().filter(|&(_, wy)| (200.0 - wy) / 4.0 <= reach).collect();
	assert_dots(&dots, &want, "stitched, to the view's edge");
	assert!(arr(&out["dots"]).iter().any(|d| num(&d["x"]) > 100.0), "dots past the zone's own edge");
	let plain = arr(&out["plain"]);
	assert!(!plain.is_empty() && plain.iter().all(|d| (0.0..=100.0).contains(&num(&d["x"]))), "not stitched: clipped to the zone as before");
	assert_eq!(out["writes"], 0, "nothing written into the map");
}

#[test]
fn openmap_the_world_view_places_each_continent_s_dots_through_its_own_map_and_follows_a_pan() {
	let out = run(&(OPENMAP.to_string()
		+ r#"
		Polestar.Set("nav.travel", false)
		Polestar.Set("ui.reduceMotion", true)
		nav.place(0, 300, 1)                             -- on Farland (continent 1)
		Polestar.Nav.SetTarget(9001, 80, 50, "Far target")
		nav.showWorldMap(947)
		local r = { world = rawDots() }
		view(70, 0, 80, 100)                             -- pan: a strip of the world
		stub.runMapFrame(WorldMapFrame, 0)
		r.panned = rawDots()
		local calls = OM.calls
		stub.runMapFrame(WorldMapFrame, 0)               -- still: no redraw, no new placement asked
		r.callsStill = OM.calls - calls
		emit(r)"#));
	let out = &out[0];
	// world percent -> Farland yards: u = 0.6 + (500 - wy) / 1000 * 0.2, v = 0.3 + (500 - wx) / 1000 * 0.2
	let to_yards = |v: &Value| -> Vec<Pt> { arr(v).iter().map(|d| (500.0 - (num(&d["y"]) / 100.0 - 0.3) / 0.2 * 1000.0, 500.0 - (num(&d["x"]) / 100.0 - 0.6) / 0.2 * 1000.0)).collect() };
	let line = [(0.0, 300.0), (0.0, -300.0)]; // Farland (80, 50): wy = 500 - 0.8 * 1000
	let spacing = stitched_spacing(1000.0 * 5.0); // the world's width: 5000 Farland yards
	assert_eq!(spacing, 120.0);
	assert_dots(&to_yards(&out["world"]), &expect_dots(&line, spacing, 0.5), "world view");
	let strip = stitched_spacing(10.0 * 50.0); // 10% of the world: 500 yd, 15 yd apart
	let (lo, hi) = (70.0 - 10.0 * 0.04, 80.0 + 10.0 * 0.04);
	let want: Vec<Pt> = expect_dots(&line, strip, 0.5)
		.into_iter()
		.filter(|&(_, wy)| {
			let x = (0.6 + (500.0 - wy) / 1000.0 * 0.2) * 100.0;
			x >= lo - 1e-9 && x <= hi + 1e-9
		})
		.collect();
	assert_dots(&to_yards(&out["panned"]), &want, "after the pan: the strip, at its spacing");
	assert_eq!(out["callsStill"], 0);
}

#[test]
fn openmap_its_menu_has_a_switch_for_the_dots_nav_openmapdots_and_polestar_s_trail_setting_still_rules() {
	let out = run(&(OPENMAP.to_string()
		+ r#"
		Polestar.Set("nav.travel", false)
		Polestar.Set("ui.reduceMotion", true)
		nav.place(0, 0)
		target(0, -900)
		nav.showWorldMap(9000)
		local spec = OM.toggles["Polestar.trailDots"]
		local r = { on = #rawDots(), get = spec and spec.get(), label = spec and spec.label, section = spec and spec.section }
		spec.set(false)
		stub.runMapFrame(WorldMapFrame, 0)
		r.off, r.setting, r.getOff = #rawDots(), Polestar.Get("nav.openmapDots"), spec.get()
		OM.stitched = false
		OM.callbacks.OpenMap_StitchedChanged(false)
		stub.runMapFrame(WorldMapFrame, 0)
		r.blizzard = #rawDots()                          -- the switch is OpenMap's map's only
		spec.set(true)
		OM.stitched = true
		OM.callbacks.OpenMap_StitchedChanged(true)
		Polestar.Set("nav.trailDots", false)
		stub.runMapFrame(WorldMapFrame, 0)
		r.trailOff = #rawDots()
		emit(r)"#));
	let out = &out[0];
	assert!(num(&out["on"]) > 0.0);
	assert_eq!(out["get"], true);
	assert_eq!(out["label"], "Polestar trail dots");
	assert_eq!(out["section"], "Polestar");
	assert_eq!(out["off"], 0);
	assert_eq!(out["setting"], false);
	assert_eq!(out["getOff"], false);
	assert!(num(&out["blizzard"]) > 0.0);
	assert_eq!(out["trailOff"], 0);
}
