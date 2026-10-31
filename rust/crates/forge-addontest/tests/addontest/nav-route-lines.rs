//! Route lines (Maps/RouteStrokes.lua, ported from Shortest Path Forever's UI/Strokes.lua, and
//! Maps/RouteLines.lua, its painters): breadcrumbs spaced evenly along a walk's bends, the gap they leave at
//! each stop's mark, later legs receding, flights along their tracks, solid strokes for rides, bounded pools,
//! and the painters fed from Nav.GetRouteGeometry.

use forge_addontest::run::addons_dir;
use forge_addontest::{emitted, truthy, Addon, RunAddon};
use serde_json::{json, Value};

const DOT: f64 = 4.0;
const RIM: f64 = 1.0;
const SPACING: f64 = 9.0;
const SMALL_SPACING: f64 = 7.0;
const STOP_GAP: f64 = 2.0;
const LATER_ALPHA: f64 = 0.4;

// The geometry alone: Core/Init.lua for the namespace, then RouteStrokes.lua. `view(extra)` is a 1000 x 1000
// unit world map at 1 px per unit over a map whose fraction is world yards / 1000 (fx = wy / 1000,
// fy = wx / 1000).
const STROKES_PRELUDE: &str = r#"
local S = Polestar.RouteStrokes
local WALK, FLY, BOAT, TRAM = { 1, 1, 0 }, { 0, 1, 0 }, { 0, 0, 1 }, { 1, 0, 1 }
local COLORS = { walk = WALK, flight = FLY, boat = BOAT, zeppelin = BOAT, tram = TRAM }
local function view(extra)
	local v = { c = 0, left = 0, top = 0, kx = 1 / 1000, ky = 1 / 1000, width = 1000, height = 1000, scale = 1, colors = COLORS, markCount = 0, marks = {} }
	for k, x in pairs(extra or {}) do v[k] = x end
	return v
end
-- A path from map-unit points { x, y } (x right, y down): wx = y, wy = x.
local function path(kind, xy, later)
	local pts = {}
	for i, p in ipairs(xy) do pts[i] = { 0, p[2], p[1] } end
	return S.Path(kind, pts, later)
end
-- The strokes as plain records: centre (x right, y down), length, width, alpha, dot, kind of colour.
local function list(buf)
	local out = {}
	for i = 1, buf.n do
		local c = buf.color[i]
		out[i] = {
			x = (buf.x1[i] + buf.x2[i]) / 2, y = -(buf.y1[i] + buf.y2[i]) / 2,
			len = math.sqrt((buf.x2[i] - buf.x1[i]) ^ 2 + (buf.y2[i] - buf.y1[i]) ^ 2),
			width = buf.width[i], under = buf.under[i], alpha = buf.alpha[i], dot = buf.dot[i],
			color = c == WALK and "walk" or c == FLY and "flight" or c == BOAT and "boat" or c == TRAM and "tram" or "?",
		}
	end
	return out
end
"#;

fn strokes(script: &str) -> Value {
	emitted(&RunAddon { addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Maps/RouteStrokes.lua"])], script: format!("{STROKES_PRELUDE}{script}"), ..Default::default() }).remove(0)
}

fn near(a: f64, b: f64) -> bool {
	(a - b).abs() < 1e-6
}

fn f(v: &Value) -> f64 {
	v.as_f64().unwrap_or_else(|| panic!("not a number: {v}"))
}

fn arr(v: &Value) -> &Vec<Value> {
	v.as_array().unwrap_or_else(|| panic!("not an array: {v}"))
}

#[test]
fn a_walk_is_breadcrumbs_spaced_evenly_along_it_the_spacing_carried_across_its_bends() {
	let out = strokes(
		r#"
		local buf = S.New()
		S.Map(buf, { path("walk", { { 100, 500 }, { 400, 500 }, { 400, 800 } }) }, view())
		emit(list(buf))"#,
	);
	let out = arr(&out);
	assert!(!out.is_empty());
	assert!(out.iter().all(|s| truthy(&s["dot"]) && s["color"] == "walk" && f(&s["alpha"]) == 1.0), "all dots, walk colour, full strength");
	// Arc length along the L from (100, 500): every dot sits a whole number of spacings in.
	let along = |s: &Value| if f(&s["y"]) == 500.0 { f(&s["x"]) - 100.0 } else { 300.0 + (f(&s["y"]) - 500.0) };
	for (i, s) in out.iter().enumerate() {
		let a = along(s);
		assert!(near(a % SPACING, 0.0) || near(a % SPACING, SPACING), "dot {} at {} yd", i + 1, a);
		if i > 0 {
			assert!(near(a - along(&out[i - 1]), SPACING), "dot {} follows {SPACING} px on", i + 1);
		}
	}
	// 600 px of walk: dots at 0, 9, ..., 594.
	assert_eq!(out.len(), (599.999 / SPACING).floor() as usize + 1);
	assert!(out.iter().any(|s| f(&s["y"]) > 500.0 && f(&s["x"]) == 400.0), "dots run on round the bend");
	// Each dot's quad: the dot's diameter over the texture's disc share (64 / 42).
	assert!(near(f(&out[0]["len"]), DOT * 64.0 / 42.0) && near(f(&out[0]["width"]), DOT * 64.0 / 42.0));
	assert!(near(f(&out[0]["under"]), (DOT + 2.0 * RIM) * 64.0 / 42.0));
}

#[test]
fn continent_maps_use_smaller_closer_dots() {
	let out = strokes(
		r#"
		local buf = S.New()
		S.Map(buf, { path("walk", { { 100, 500 }, { 400, 500 } }) }, view({ small = true }))
		emit(list(buf))"#,
	);
	let out = arr(&out);
	assert!(near(f(&out[1]["x"]) - f(&out[0]["x"]), SMALL_SPACING));
	assert_eq!(out.len(), (299.999 / SMALL_SPACING).floor() as usize + 1);
}

#[test]
fn dots_leave_a_gap_round_each_stop_mark_and_run_up_to_it() {
	let out = strokes(
		r#"
		local buf = S.New()
		S.Map(buf, { path("walk", { { 100, 500 }, { 900, 500 } }) }, view({ marks = { 0.5, 0.5, 6 }, markCount = 1 }))
		emit(list(buf))"#,
	);
	let reach = 6.0 + STOP_GAP + DOT / 2.0 + RIM; // the mark's radius, the gap and a dot's rim
	let centres: Vec<f64> = arr(&out).iter().map(|s| f(&s["x"])).collect();
	assert!(centres.iter().all(|x| (x - 500.0).abs() >= reach), "no dot inside the gap");
	let before = centres.iter().copied().rfind(|x| *x < 500.0);
	let after = centres.iter().copied().find(|x| *x > 500.0);
	assert!(before.is_some_and(|b| 500.0 - b < reach + SPACING) && after.is_some_and(|a| a - 500.0 < reach + SPACING), "the dots come up to the gap on both sides");
}

#[test]
fn legs_after_the_current_one_recede_each_kind_keeps_its_colour_rides_are_solid_strokes() {
	let out = strokes(
		r#"
		local buf = S.New()
		S.Map(buf, {
			path("walk", { { 100, 100 }, { 200, 100 } }),
			path("tram", { { 200, 100 }, { 300, 100 } }, true),
			path("boat", { { 300, 100 }, { 600, 100 } }, true),
		}, view())
		emit(list(buf))"#,
	);
	let out = arr(&out);
	let of = |c: &str| out.iter().filter(|s| s["color"] == c).collect::<Vec<_>>();
	let walk = of("walk");
	let tram = of("tram");
	let boat = of("boat");
	assert!(walk.len() > 5 && walk.iter().all(|s| truthy(&s["dot"]) && f(&s["alpha"]) == 1.0), "the current walk: dots at full strength");
	assert_eq!(tram.len(), 1, "the tram: one stroke");
	assert!(!truthy(&tram[0]["dot"]) && near(f(&tram[0]["alpha"]), LATER_ALPHA) && near(f(&tram[0]["width"]), 2.0), "solid, 2 px, receding");
	assert_eq!(boat.len(), 12, "a crossing between two docks: a bow of 12 strokes");
	assert!(boat.iter().all(|s| !truthy(&s["dot"]) && near(f(&s["alpha"]), LATER_ALPHA)));
	assert!(boat.iter().any(|s| (f(&s["y"]) - 100.0).abs() > 10.0), "the crossing bows off the straight line");
}

#[test]
fn a_flight_follows_its_track_between_the_flight_masters_corners_cut_ends_kept() {
	let out = strokes(
		r#"
		-- Nodes 1 and 2 at wx 500, wy 100 and 900; the track bends north (wx 300) halfway.
		local tracks = { [1] = { [2] = { 505, 105, 300, 500, 495, 895 } } }
		local p = S.Path("flight", { { 0, 500, 100 }, { 0, 500, 900 } }, false, tracks, { 1, 2 })
		local plain = S.Path("flight", { { 0, 500, 100 }, { 0, 500, 900 } }, false, tracks, nil)
		local pts = {}
		for i = 1, p.n do pts[i] = { p.x[i], p.y[i] } end
		local buf = S.New()
		S.Map(buf, { p }, view())
		emit({ pts = pts, plain = plain.n, strokes = list(buf) })"#,
	);
	let pts = arr(&out["pts"]);
	assert_eq!(pts[0], json!([500, 100]), "starts at the flight master");
	assert_eq!(pts[pts.len() - 1], json!([500, 900]), "ends at the flight master");
	assert!(pts.len() > 3, "the track adds its bend, rounded into more points");
	let min_x = pts.iter().map(|p| f(&p[0])).fold(f64::INFINITY, f64::min);
	assert!(min_x < 450.0, "the line swings north with the track");
	assert!(min_x > 300.0, "cut corners never overshoot the track");
	assert_eq!(out["plain"], 2, "no node ids: straight between the nodes");
	let st = arr(&out["strokes"]);
	assert!(st.len() > 2 && st.iter().all(|s| !truthy(&s["dot"]) && s["color"] == "flight"));
}

#[test]
fn lines_are_clipped_to_the_map_nothing_is_drawn_for_another_continent() {
	let out = strokes(
		r#"
		local buf = S.New()
		S.Map(buf, { path("tram", { { -500, 500 }, { 1500, 500 } }) }, view())
		local clipped = list(buf)
		local other = S.Path("tram", { { 1, 500, 100 }, { 1, 500, 900 } })
		S.Map(buf, { other }, view())
		emit({ clipped = clipped, other = buf.n })"#,
	);
	let clipped = arr(&out["clipped"]);
	assert_eq!(clipped.len(), 1);
	assert!(near(f(&clipped[0]["x"]), 500.0) && near(f(&clipped[0]["len"]), 1000.0), "only the part on the map");
	assert_eq!(out["other"], 0);
}

#[test]
fn every_buffer_is_bounded_a_pool_never_grows_past_its_limit() {
	let out = strokes(
		r#"
		local small, full = S.New(50), S.New()
		local long = path("walk", { { 0, 0 }, { 1000, 0 }, { 1000, 1000 }, { 0, 1000 }, { 0, 0 }, { 1000, 1000 } })
		S.Map(small, { long }, view({ scale = 4 }))
		-- At 40 px per unit the same walk asks for far more than the limit.
		S.Map(full, { long }, view({ scale = 40 }))
		emit({ small = small.n, full = full.n, limit = S.LIMIT, cap = S.New(99999).limit })"#,
	);
	assert_eq!(out["small"], 50);
	assert_eq!(out["full"], out["limit"]);
	assert_eq!(out["cap"], out["limit"], "a buffer never asks for more than the limit");
}

#[test]
fn redrawing_reuses_the_buffer_no_table_is_allocated_per_draw() {
	let out = strokes(
		r#"
		local buf = S.New()
		local paths = { path("walk", { { 100, 500 }, { 400, 500 }, { 400, 800 } }), path("tram", { { 400, 800 }, { 900, 800 } }, true) }
		local v = view({ marks = { 0.4, 0.8, 6 }, markCount = 1 })
		for _ = 1, 50 do S.Map(buf, paths, v) end -- the interpreter's own first-run growth
		local function grown(n)
			collectgarbage("collect"); collectgarbage("stop")
			local before = collectgarbage("count")
			for _ = 1, n do S.Map(buf, paths, v) end
			local kb = collectgarbage("count") - before
			collectgarbage("restart")
			return kb
		end
		local base = grown(10)
		emit({ grown = grown(3000) - base, n = buf.n })"#,
	);
	assert!(f(&out["n"]) > 0.0);
	assert!(f(&out["grown"]) < 1.0, "2990 more redraws allocated {} KB", out["grown"]);
}

#[test]
fn minimap_projected_around_the_player_turned_with_the_facing_clipped_to_the_face_a_gap_at_the_guide_pin() {
	let out = strokes(
		r#"
		local buf = S.New()
		-- Player at the origin, 100 yd view radius, a 100 px minimap. The walk runs 200 yd east (wy -200).
		local walk = S.Path("walk", { { 0, 0, 0 }, { 0, 0, -200 } })
		local v = { c = 0, x = 0, y = 0, radius = 100, facing = 0, width = 100, height = 100, scale = 1, colors = COLORS }
		S.Minimap(buf, { walk }, v)
		local east = list(buf)
		v.facing = math.pi / 2 -- facing west: east is down on a rotating minimap
		S.Minimap(buf, { walk }, v)
		local turned = list(buf)
		v.facing = 0
		v.goalC, v.goalX, v.goalY, v.goalRadius = 0, 0, -50, 8
		local gx, gy = S.Minimap(buf, { walk }, v)
		emit({ east = east, turned = turned, gap = list(buf), gx = gx, gy = gy })"#,
	);
	let east = arr(&out["east"]);
	assert!(east.iter().all(|s| near(f(&s["y"]), 50.0) && f(&s["x"]) >= 50.0), "east of the centre, on its row");
	assert!(east.iter().map(|s| f(&s["x"])).fold(f64::NEG_INFINITY, f64::max) < 100.0, "clipped inside the face");
	assert!(arr(&out["turned"]).iter().all(|s| near(f(&s["x"]), 50.0) && f(&s["y"]) >= 50.0), "turned: down from the centre");
	assert!(near(f(&out["gx"]), 0.5) && near(f(&out["gy"]), 0.0));
	let reach = 8.0 + STOP_GAP + DOT / 2.0 + RIM;
	assert!(arr(&out["gap"]).iter().all(|s| (f(&s["x"]) - 75.0).abs() >= reach), "no dot under the guide pin");
}

#[test]
fn the_live_start_the_nearest_point_ahead_on_the_walk_progress_never_runs_back() {
	let out = strokes(
		r#"
		local p = S.Path("walk", { { 0, 0, 0 }, { 0, 0, -100 }, { 0, -100, -100 }, { 0, -100, 0 } })
		local a = S.Live(p, 0, 5, -50, nil, 60)
		local b = S.Live(p, 0, -50, -95, a, 60)
		local back = S.Live(p, 0, 5, -50, b, 60)
		local far = S.Live(p, 0, 500, 500, nil, 60)
		emit({ a = a, b = b, back = back, far = far or false })"#,
	);
	assert_eq!(out["a"], 2, "on the first segment");
	assert_eq!(out["b"], 3, "on the second");
	assert_eq!(out["back"], 3, "walking back does not undo progress");
	assert_eq!(out["far"], false, "off the walk: no live start");
}

// The painters with Nav: Core/Init.lua, Nav/Nav.xml and the route line files against tests/lua/stub_nav.lua
// (map 9000: 2000 yd across, origin at its centre).
fn lines() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml", "Maps/FlightPaths.lua", "Maps/RouteStrokes.lua", "Maps/RouteLines.lua"])
}

const PAINTED_PRELUDE: &str = r#"
local N, R, Pins, nav = Polestar.Nav, Polestar.RouteLines, Polestar.Pins, stub.nav
local function target(wx, wy)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, "Target")
end
WorldMapFrame:GetCanvas():SetSize(1000, 1000)
local function shown(owner)
	local n = 0
	for _, line in ipairs(owner and owner.lines or {}) do if line:IsShown() then n = n + 1 end end
	return n
end
local function worldPin()
	local f = R.GetWorldFrame()
	if f and f:IsShown() then return f end
end
"#;

fn painted(script: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_nav.lua"], addons: vec![lines()], login: true, script: format!("{PAINTED_PRELUDE}{script}"), ..Default::default() }).remove(0)
}

#[test]
fn the_painters_draw_the_route_on_the_world_map_and_the_minimap_and_stand_in_for_the_trail() {
	let out = painted(
		r#"
		Polestar.Set("nav.travel", false)
		nav.viewRadius = 200
		nav.place(0, 0)
		target(0, -600)
		nav.showWorldMap(9000)
		stub.advance(0.3)
		local r = {}
		r.active = R.Active()
		r.trail = Pins.GetTrail() ~= nil
		r.world = R.GetStrokes("world").n
		r.worldLines = shown(worldPin())
		r.minimap = R.GetStrokes("minimap").n
		r.paths = #R.GetPaths()
		Polestar.Set("nav.routeLines", false)
		stub.advance(0.3)
		r.offWorld = worldPin() == nil
		r.offTrail = Pins.GetTrail() ~= nil
		Polestar.Set("nav.routeLines", true)
		stub.advance(0.3)
		r.backTrail = Pins.GetTrail() ~= nil
		r.backWorld = shown(worldPin())
		emit(r)"#,
	);
	assert_eq!(out["active"], true);
	assert_eq!(out["paths"], 1, "one walk to the target");
	assert!(f(&out["world"]) > 10.0 && out["worldLines"] == out["world"], "world map: {} strokes, {} lines shown", out["world"], out["worldLines"]);
	assert!(f(&out["minimap"]) > 5.0, "minimap: {} strokes", out["minimap"]);
	assert_eq!(out["trail"], false, "the trail stands down while the lines draw");
	assert_eq!(out["offWorld"], true, "nav.routeLines off: no world lines");
	assert_eq!(out["offTrail"], true, "and the trail is back");
	assert_eq!(out["backTrail"], false);
	assert!(f(&out["backWorld"]) > 10.0);
}

#[test]
fn the_minimap_redraws_only_when_something_changed_and_its_line_pool_never_shrinks_or_passes_its_bound() {
	let out = painted(
		r#"
		Polestar.Set("nav.travel", false)
		nav.viewRadius = 200
		nav.place(0, 0)
		target(0, -600)
		stub.advance(0.5)
		local strokes = R.GetStrokes("minimap")
		local first = strokes.n
		-- Standing still: the buffer is not rewritten (a sentinel survives).
		strokes.x1[1] = 12345
		stub.advance(1)
		local still = strokes.x1[1] == 12345
		nav.place(0, -100)
		stub.advance(0.3)
		local moved = strokes.x1[1] ~= 12345
		emit({ first = first, still = still, moved = moved, limit = strokes.limit })"#,
	);
	assert!(f(&out["first"]) > 0.0);
	assert_eq!(out["still"], true, "no redraw while nothing changes");
	assert_eq!(out["moved"], true, "moving redraws");
	assert!(f(&out["limit"]) <= 600.0);
}

// The lines are Polestar's own frame on the canvas (Nav/MapCanvas.lua): nothing is acquired from the map or
// released to it, so combat changes nothing.
#[test]
fn nav_qa_c4_in_combat_the_world_map_lines_redraw_on_the_frame_in_hand_and_turn_off_at_once() {
	let out = painted(
		r#"
		local C = Polestar.Compat
		function C.InCombat() return stub.inCombat and true or false end
		Polestar.Set("nav.travel", false)
		nav.place(0, 0)
		target(0, -600)
		nav.showWorldMap(9000)
		stub.advance(0.3)
		local pin = worldPin()
		stub.inCombat = true
		target(300, -600)
		stub.advance(0.3)
		local r = { samePin = worldPin() == pin, lines = shown(pin) }
		Polestar.Set("nav.routeLines", false)
		r.offInCombat = worldPin() == nil
		stub.inCombat = false
		emit(r)"#,
	);
	assert_eq!(out["samePin"], true, "the frame in hand is redrawn, not swapped");
	assert!(f(&out["lines"]) > 10.0);
	assert_eq!(out["offInCombat"], true, "turning the lines off in combat takes effect at once");
}

#[test]
fn nav_qa_c5_a_secret_position_or_facing_hides_the_minimap_line_with_no_error() {
	let out = painted(
		r#"
		local C = Polestar.Compat
		-- The client's secret values cannot be faked in plain Lua: this facing reads as secret.
		local SECRET = 1.2345
		function C.IsSecret(v) return v == SECRET end
		Polestar.Set("nav.travel", false)
		nav.viewRadius = 200
		nav.place(0, 0)
		target(0, -600)
		stub.advance(0.3)
		local before = R.GetStrokes("minimap").n
		local real = C.GetPlayerFacing
		C.GetPlayerFacing = function() return SECRET end
		SetCVar("rotateMinimap", "1")
		stub.advance(0.3)
		local hidden = R.GetStrokes("minimap").n
		C.GetPlayerFacing = real
		SetCVar("rotateMinimap", "0")
		stub.advance(0.3)
		emit({ before = before, hidden = hidden, back = R.GetStrokes("minimap").n })"#,
	);
	assert!(f(&out["before"]) > 0.0);
	assert_eq!(out["hidden"], 0, "hidden while the facing is unreadable");
	assert!(f(&out["back"]) > 0.0, "back once it reads again");
}

#[test]
fn nav_qa_c12_a_pooled_line_swapping_between_dot_and_stroke_starts_from_the_whole_texture() {
	let out = painted(
		r#"
		Polestar.Set("nav.travel", false)
		nav.viewRadius = 200
		nav.place(0, 0)
		target(0, -600)
		nav.showWorldMap(9000)
		stub.advance(0.3)
		local pin = worldPin()
		local line = pin.lines[1]
		line:SetTexCoord(0, 0.5, 0, 0.5) -- as if left over from another use
		-- The route becomes a tram ride: line 1 swaps from a dot to a stroke.
		local geom = { legs = { { kind = "tram", pts = { { 0, 0, 0 }, { 0, 0, -600 } }, current = true } } }
		local real = N.GetRouteGeometry
		N.GetRouteGeometry = function() return geom end
		Polestar.Fire("NAV_ROUTE_GEOMETRY")
		N.GetRouteGeometry = real
		emit({ coords = line.texCoord, dot = pin.dots[1] })"#,
	);
	assert_eq!(out["dot"], false);
	assert_eq!(out["coords"], json!([0, 1, 0, 1]));
}

#[test]
fn nav_qa_k7_a_zero_length_lift_leg_its_shaft_point_twice_draws_nothing_and_never_divides_by_zero() {
	let out = strokes(
		r#"
		local buf = S.New()
		local lift = S.Path("tram", { { 0, 500, 500 }, { 0, 500, 500 } })
		local walk = S.Path("walk", { { 0, 500, 100 }, { 0, 500, 100 }, { 0, 500, 300 } })
		S.Map(buf, { lift, walk }, view({ marks = { 0.5, 0.5, 6 }, markCount = 1 }))
		local ok = true
		for i = 1, buf.n do
			for _, k in ipairs({ "x1", "y1", "x2", "y2", "ux", "uy" }) do
				local v = buf[k][i]
				if v ~= v or v == math.huge or v == -math.huge then ok = false end
			end
		end
		local mm = S.New()
		S.Minimap(mm, { lift }, { c = 0, x = 500, y = 500, radius = 100, facing = 0, width = 100, height = 100, scale = 1, colors = COLORS })
		emit({ finite = ok, n = buf.n, lift = mm.n, live = S.Live(lift, 0, 500, 500, nil, 60) or false })"#,
	);
	assert_eq!(out["finite"], true, "no NaN or infinite stroke");
	assert!(f(&out["n"]) > 5.0, "the walk after it still draws");
	assert_eq!(out["lift"], 0);
}

#[test]
fn a_multi_point_boat_draws_straight_along_its_points_and_never_wraps_to_its_last_point_spf_strokes_lua_298_note() {
	let out = strokes(
		r#"
		local buf = S.New()
		S.Map(buf, { path("boat", { { 100, 100 }, { 300, 100 }, { 300, 300 } }) }, view())
		emit(list(buf))"#,
	);
	let out = arr(&out);
	assert_eq!(out.len(), 2);
	assert!(near(f(&out[0]["y"]), 100.0) && near(f(&out[0]["x"]), 200.0));
	assert!(near(f(&out[1]["x"]), 300.0) && near(f(&out[1]["y"]), 200.0));
}

#[test]
fn nav_qa_k8_a_chokepoint_stop_wears_its_glyph_a_hand_made_stop_no_choke_keeps_the_plain_disc() {
	let out = painted(
		r#"
		local function pt(wx, wy) return { c = 0, wx = wx, wy = wy } end
		local legs = {
			{ kind = "walk", from = pt(0, 0), to = pt(0, -100), choke = { kind = "bridge", name = "Lakeshire bridge" }, label = "Cross the bridge" },
			{ kind = "walk", from = pt(0, -100), to = pt(0, -200), choke = { kind = "tunnel" }, label = "Through the tunnel" },
			{ kind = "walk", from = pt(0, -200), to = pt(0, -300), label = "Walk to the cave mouth" },
			{ kind = "walk", from = pt(0, -300), to = pt(0, -400), label = "To the goal" },
		}
		N.GetRoute = function() return legs, 1 end
		target(0, -400)
		N.layers.Update()
		local out = {}
		for i, p in ipairs(Pins.GetLayer("nav.route") or {}) do
			GameTooltip.lines = {}
			p.tooltip(GameTooltip)
			out[i] = { icon = p.icon or false, tip = GameTooltip.lines }
		end
		emit(out)"#,
	);
	let out = arr(&out);
	assert_eq!(out.len(), 3);
	assert_eq!(out[0]["icon"], "map:bridge");
	assert!(out[0]["tip"].as_array().is_some_and(|a| a.iter().any(|l| l == "Lakeshire bridge")), "the chokepoint is named in the tooltip");
	assert_eq!(out[1]["icon"], "map:cave", "a tunnel wears the cave glyph; no name, no extra line");
	assert_eq!(out[2]["icon"], "map:stop", "no choke: the stop glyph");
}

#[test]
fn review_p3_8_blizzard_worldmap_loading_after_login_draws_the_route_lines_on_the_map() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		before: "stub.savedMap = WorldMapFrame; WorldMapFrame = nil".into(),
		addons: vec![lines()],
		login: true,
		script: r#"
local N, R, nav = Polestar.Nav, Polestar.RouteLines, stub.nav
Polestar.Set("nav.travel", false)
nav.place(0, 0)
local m, x, y = nav.mapPoint(0, -600)
N.SetTarget(m, x, y, "Target")
stub.advance(0.3)
local before = R.GetWorldFrame()
WorldMapFrame = stub.savedMap
WorldMapFrame:GetCanvas():SetSize(1000, 1000)
stub.fire("ADDON_LOADED", "Blizzard_WorldMap")
nav.showWorldMap(9000)
local f = R.GetWorldFrame()
emit({ before = before == nil, shown = f ~= nil and f:IsShown(), strokes = R.GetStrokes("world").n })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["before"], true);
	assert_eq!(out["shown"], true, "the lines show once the map addon loads");
	assert!(f(&out["strokes"]) > 10.0);
}

#[test]
fn review_p3_9_the_world_map_walk_starts_at_the_player_with_the_minimap_line_off() {
	let out = painted(
		r#"
		Polestar.Set("nav.travel", false)
		Polestar.Set("nav.minimapPins", false)
		nav.place(0, 0)
		target(0, -600)
		nav.showWorldMap(9000)
		stub.advance(0.3)
		local function firstX()
			local s, lo = R.GetStrokes("world"), math.huge
			for i = 1, s.n do lo = math.min(lo, s.x1[i], s.x2[i]) end
			return lo
		end
		local start = firstX()
		nav.place(0, -300) -- halfway, map x 650
		stub.advance(0.5)
		emit({ start = start, moved = firstX(), minimap = R.GetStrokes("minimap").n })"#,
	);
	assert_eq!(out["minimap"], 0, "no minimap line");
	assert!(f(&out["start"]) < 510.0, "starts at the planned start ({})", out["start"]);
	assert!(f(&out["moved"]) > 640.0, "then at the player ({})", out["moved"]);
}

#[test]
fn review_p3_9_active_counts_only_legs_that_draw_no_one_point_jump_only_or_zero_length_route_stands_in_for_the_trail() {
	let out = painted(
		r#"
		nav.place(0, 0)
		target(0, -600)
		local geom
		N.GetRouteGeometry = function() return geom end
		local r = {}
		for _, case in ipairs({
			{ "hearth", { { kind = "hearth", pts = { { 0, 0, 0 }, { 0, 300, 300 } }, current = true } } },
			{ "teleport", { { kind = "teleport", pts = { { 0, 0, 0 }, { 1, 300, 300 } }, current = true } } },
			{ "onePoint", { { kind = "walk", pts = { { 0, 0, 0 } }, current = true } } },
			{ "shaft", { { kind = "lift", pts = { { 0, 5, 5 }, { 0, 5, 5 } }, current = true } } },
			{ "unknownKind", { { kind = "balloon", pts = { { 0, 0, 0 }, { 0, 300, 300 } }, current = true } } },
			{ "walk", { { kind = "hearth", pts = { { 0, 0, 0 }, { 0, 300, 300 } }, current = true },
				{ kind = "walk", pts = { { 0, 300, 300 }, { 0, 300, 0 } } } } },
		}) do
			geom = { legs = case[2] }
			Polestar.Fire("NAV_ROUTE_GEOMETRY")
			r[case[1]] = { active = R.Active(), trail = Pins.GetTrail() ~= nil }
		end
		emit(r)"#,
	);
	for k in ["hearth", "teleport", "onePoint", "shaft", "unknownKind"] {
		assert_eq!(out[k]["active"], false, "{k}: nothing to draw");
		assert_eq!(out[k]["trail"], true, "{k}: the trail stands in");
	}
	assert_eq!(out["walk"]["active"], true);
	assert_eq!(out["walk"]["trail"], false);
}

#[test]
fn review_p3_9_a_theme_change_re_applies_the_outline_colour_to_pooled_lines() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_nav.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Theme/Theme.xml", "Nav/Nav.xml", "Maps/FlightPaths.lua", "Maps/RouteStrokes.lua", "Maps/RouteLines.lua"])],
		login: true,
		script: r#"
local N, nav, T = Polestar.Nav, stub.nav, Polestar.Theme
WorldMapFrame:GetCanvas():SetSize(1000, 1000)
Polestar.Set("nav.travel", false)
nav.place(0, 0)
local m, x, y = nav.mapPoint(0, -600)
N.SetTarget(m, x, y, "Target")
nav.showWorldMap(9000)
stub.advance(0.3)
local pin = Polestar.RouteLines.GetWorldFrame()
local outline = pin.outlines[1]
outline:SetVertexColor(1, 0, 0) -- stale
T.Refresh()
local r, g, b = outline:GetVertexColor()
local sr, sg, sb = T.Color("scrim")
emit({ got = { r, g, b }, want = { sr, sg, sb } })"#
			.into(),
		..Default::default()
	})
	.remove(0);
	assert_eq!(out["got"], out["want"]);
}

#[test]
fn the_committed_flightpaths_lua_holds_the_real_network_s_tracks_not_a_test_fixture_s() {
	let file = addons_dir().join("Polestar").join("Maps").join("FlightPaths.lua");
	let file = serde_json::to_string(file.to_str().unwrap()).unwrap();
	let script = String::from("\n\t\tlocal f = assert(loadfile(")
		+ &file
		+ r#"))
		local ns = {}
		f("Polestar", ns)
		local pairs_, from = 0, 0
		for _, to in pairs(ns.FlightTracks) do
			from = from + 1
			for _ in pairs(to) do pairs_ = pairs_ + 1 end
		end
		local sw = ns.FlightTracks[2] and ns.FlightTracks[2][4]
		emit({ pairs = pairs_, from = from, stormwindToSentinel = sw and #sw or 0 })"#;
	let out = strokes(&script);
	assert!(f(&out["pairs"]) > 200.0, "{} tracks", out["pairs"]);
	assert!(f(&out["stormwindToSentinel"]) >= 6.0, "Stormwind to Sentinel Hill has its bends");
}
