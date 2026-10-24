//! Route lines as sparkles (Maps/RouteSparkle.lua, ported from Forever Sparkle Trail, and its painters in
//! Maps/RouteLines.lua, nav.lineStyle "sparkle"): the draw paths measured by continent, sparkles spaced evenly
//! and drifting toward the goal, the settings in range, both surfaces painted from their own pools, OpenMap's
//! stitched world map, and the style window behind the "Route lines" gear.

use forge_addontest::{emitted, Addon, RunAddon};
use serde_json::{json, Value};

const SPARKLE_PRELUDE: &str = r#"
local S, Sp = Polestar.RouteStrokes, Polestar.RouteSparkle
local function path(kind, pts, later) return S.Path(kind, pts, later) end
"#;

fn sparkle(script: &str) -> Value {
	emitted(&RunAddon {
		addons: vec![Addon::files("Polestar", &["Core/Init.lua", "Maps/RouteStrokes.lua", "Maps/RouteSparkle.lua"])],
		script: format!("{SPARKLE_PRELUDE}{script}"),
		..Default::default()
	})
	.remove(0)
}

fn num(v: &Value) -> f64 {
	v.as_f64().unwrap_or(f64::NAN)
}

fn near(a: f64, b: f64) -> bool {
	(a - b).abs() < 1e-6
}

fn list(v: &Value) -> Vec<Value> {
	v.as_array().cloned().unwrap_or_default()
}

#[test]
fn the_draw_paths_become_runs_measured_in_yards_split_where_they_change_continent_later_legs_only_on_request() {
	let out = sparkle(
		r#"
		local walk = path("walk", { { 0, 0, 0 }, { 0, 0, -300 }, { 0, 400, -300 } })
		local boat = path("boat", { { 0, 400, -300 }, { 1, 0, 0 }, { 1, 0, 500 } }, true)
		local now, all = Sp.Paths({ walk, boat }, false), Sp.Paths({ walk, boat }, true)
		local r = { now = #now, all = #all, total = now[1].total, c = {} }
		for i, run in ipairs(all) do r.c[i] = { c = run.c, later = run.later, total = run.total } end
		emit(r)"#,
	);
	assert_eq!(out["now"], 1, "the current walk only");
	assert!(near(num(&out["total"]), 700.0));
	assert_eq!(out["all"], 2, "the boat's one point on its first continent draws nothing; its run on the second does");
	assert_eq!(out["c"][1], json!({ "c": 1, "later": true, "total": 500 }));
}

#[test]
fn sparkles_sit_a_spacing_apart_from_the_start_on_ease_in_and_out_and_keep_their_numbers_as_they_flow() {
	let out = sparkle(
		r#"
		local run = Sp.Paths({ path("walk", { { 0, 0, 0 }, { 0, 0, -100 } }) })[1]
		local function list(from, phase)
			local out = {}
			Sp.Emit(run, from, 10, phase, 100, function(x, y, k, nx, ny, fade) out[#out + 1] = { along = -y, k = k, fade = fade } end)
			return out
		end
		emit({ still = list(0, 0), flowed = list(0, 0.25), ahead = list(42, 0), capped = Sp.Emit(run, 0, 10, 0, 3, function() end) })"#,
	);
	let still = list(&out["still"]);
	let along: Vec<f64> = still.iter().map(|s| num(&s["along"])).collect();
	assert!(along.iter().enumerate().all(|(i, a)| i == 0 || near(a - along[i - 1], 10.0)), "evenly spaced");
	assert!(still.iter().all(|s| num(&s["fade"]) > 0.0 && num(&s["fade"]) <= 1.0));
	assert!(near(num(&out["flowed"][0]["along"]), 2.5) && out["flowed"][0]["k"] == 0, "a quarter spacing on, sparkle 0 is still sparkle 0");
	assert!(list(&out["ahead"]).iter().all(|s| num(&s["along"]) >= 42.0), "nothing behind the start");
	assert_eq!(out["capped"], 3);
}

#[test]
fn the_nearest_point_on_a_run_is_measured_along_it_another_continent_has_none() {
	let out = sparkle(
		r#"
		local run = Sp.Paths({ path("walk", { { 0, 0, 0 }, { 0, 0, -100 }, { 0, 100, -100 } }) })[1]
		local a, off = Sp.Nearest(run, 0, 5, -50)
		local b = Sp.Nearest(run, 0, 50, -110)
		emit({ a = a, off = off, b = b, other = Sp.Nearest(run, 1, 5, -50) or false })"#,
	);
	assert!(near(num(&out["a"]), 50.0) && near(num(&out["off"]), 5.0));
	assert!(near(num(&out["b"]), 150.0));
	assert_eq!(out["other"], false);
}

#[test]
fn a_draw_looks_only_along_the_stretches_that_reach_the_view_and_finds_the_same_sparkles_there_as_the_whole_run() {
	let out = sparkle(
		r#"
		-- An L: 1000 yd south, then 1000 yd west; a box over the corner only.
		local run = Sp.Paths({ path("walk", { { 0, 0, 0 }, { 0, -500, 0 }, { 0, -1000, 0 }, { 0, -1000, -500 }, { 0, -1000, -1000 } }) })[1]
		local spans = {}
		local n = Sp.Spans(run, run.xs, run.ys, -1100, -900, -100, 100, spans)
		local lo, hi = spans[1], spans[2]
		local inside, whole = {}, {}
		Sp.Emit(run, 0, 30, 0.4, 1000, function(x, y, k, nx, ny, fade) inside[#inside + 1] = k .. ":" .. fade end, lo, hi)
		Sp.Emit(run, 0, 30, 0.4, 1000, function(x, y, k, nx, ny, fade)
			local along = (k + 0.4) * 30
			if along >= lo and along <= hi then whole[#whole + 1] = k .. ":" .. fade end
		end)
		emit({ n = n, lo = lo, hi = hi, inside = inside, whole = whole,
			none = Sp.Spans(run, run.xs, run.ys, 500, 600, 500, 600, spans),
			unprojected = Sp.Spans(run, {}, {}, -1e9, 1e9, -1e9, 1e9, spans) })"#,
	);
	assert_eq!(out["n"], 1, "the two segments at the corner, merged");
	assert!(near(num(&out["lo"]), 500.0) && near(num(&out["hi"]), 1500.0), "{}..{}", out["lo"], out["hi"]);
	assert_eq!(out["inside"], out["whole"], "same numbers, same fades");
	assert!(list(&out["inside"]).len() > 10);
	assert_eq!(out["none"], 0, "nothing reaches a box off the run");
	assert_eq!(out["unprojected"], 0, "points that could not be projected show nothing");
}

#[test]
fn the_style_brings_hand_edited_settings_into_range_and_subtlety_calms_every_sparkle() {
	let out = sparkle(
		r#"
		local function style(over)
			return Sp.Style(function(key) if over[key] ~= nil then return over[key] end return Sp.DEFAULTS[key] end)
		end
		local wild = style({ sparkleIntensity = 5, sparkleDensity = 99, sparkleSize = "big", sparkleMax = 0, sparkleColor = "plaid" })
		local calm, bold = style({ sparkleSubtlety = 1 }), style({ sparkleSubtlety = 0 })
		local peak = 0
		for k = 0, 50 do
			for t = 0, 4, 0.1 do
				local a = Sp.Twinkle(k, t, bold, 1)
				if a > peak then peak = a end
			end
		end
		emit({ wild = { alpha = wild.alpha, spacing = wild.spacing, size = wild.size, max = wild.max, gold = wild.color == Sp.COLORS.gold },
			route = style({ sparkleColor = "route" }).color == nil,
			calm = { halo = calm.halo, jitter = calm.jitter, size = calm.size }, bold = { halo = bold.halo, size = bold.size }, peak = peak })"#,
	);
	assert!(num(&out["wild"]["alpha"]) <= 1.0, "intensity at most 100%");
	assert_eq!(out["wild"]["spacing"], 9, "density at most 10");
	assert!(near(num(&out["wild"]["size"]), 14.0 * (1.0 - 0.45 * 0.35)), "a size that is not a number: the default");
	assert_eq!(out["wild"]["max"], 10, "at least 10 sparkles");
	assert_eq!(out["wild"]["gold"], true, "an unknown colour: loot gold");
	assert_eq!(out["route"], true, "route colours: each leg its own");
	assert_eq!(out["calm"]["halo"], 0, "no glow at full subtlety");
	assert_eq!(out["calm"]["jitter"], 0);
	assert!(num(&out["calm"]["size"]) < num(&out["bold"]["size"]));
	assert!(num(&out["peak"]) > 0.0 && num(&out["peak"]) <= 1.0);
}

// The painters with Nav, as tests/nav-route-lines.rs (map 9000: 2000 yd across, origin at its centre).
fn lines() -> Addon {
	Addon::files("Polestar", &["Core/Init.lua", "Nav/Nav.xml", "Maps/FlightPaths.lua", "Maps/RouteStrokes.lua", "Maps/RouteSparkle.lua", "Maps/RouteLines.lua"])
}

const PAINTED_PRELUDE: &str = r#"
local N, R, Pins, nav = Polestar.Nav, Polestar.RouteLines, Polestar.Pins, stub.nav
local function target(wx, wy)
	local m, x, y = nav.mapPoint(wx, wy)
	N.SetTarget(m, x, y, "Target")
end
WorldMapFrame:GetCanvas():SetSize(1000, 1000)
local function shownLines(owner)
	local n = 0
	for _, line in ipairs(owner and owner.lines or {}) do if line:IsShown() then n = n + 1 end end
	return n
end
local function stars(owner)
	local out = {}
	for i, s in ipairs(owner and owner.stars or {}) do
		if s:IsShown() then out[#out + 1] = { x = s.points[1].x, y = s.points[1].y, alpha = s.alpha or 1 } end
	end
	return out
end
local function walkTo(wy)
	Polestar.Set("nav.travel", false)
	nav.viewRadius = 200
	nav.place(0, 0)
	target(0, wy)
end
"#;

fn painted_with(script: &str, before: &str) -> Value {
	emitted(&RunAddon { stubs: vec!["stub_nav.lua"], before: before.into(), addons: vec![lines()], login: true, script: format!("{PAINTED_PRELUDE}{script}"), ..Default::default() }).remove(0)
}

fn painted(script: &str) -> Value {
	painted_with(script, "")
}

#[test]
fn the_sparkle_style_paints_both_surfaces_instead_of_the_dots_still_standing_in_for_the_trail_and_back() {
	let out = painted(
		r#"
		walkTo(-600)
		Polestar.Set("nav.lineStyle", "sparkle")
		nav.showWorldMap(9000)
		stub.advance(0.5)
		local world = R.GetWorldFrame()
		local r = {}
		r.world, r.minimap = R.GetSparkles("world"), R.GetSparkles("minimap")
		r.lines = shownLines(world)
		r.strokes = R.GetStrokes("minimap").n
		r.active, r.trail = R.Active(), Pins.GetTrail() ~= nil
		Polestar.Set("nav.lineStyle", "dots")
		stub.advance(0.3)
		r.dotsWorld, r.dotsMinimap = R.GetSparkles("world"), R.GetSparkles("minimap")
		r.dotLines = shownLines(world)
		emit(r)"#,
	);
	assert!(num(&out["world"]) > 5.0, "world map: {} sparkles", out["world"]);
	assert!(num(&out["minimap"]) >= 2.0, "minimap: {} sparkles", out["minimap"]);
	assert_eq!(out["lines"], 0, "no dots under them");
	assert_eq!(out["strokes"], 0);
	assert_eq!(out["active"], true);
	assert_eq!(out["trail"], false, "the trail stays down");
	assert_eq!(out["dotsWorld"], 0, "dots again: the sparkles hide");
	assert_eq!(out["dotsMinimap"], 0);
	assert!(num(&out["dotLines"]) > 10.0, "and the dots are back");
}

#[test]
fn the_sparkles_drift_toward_the_goal_while_they_flow_and_hold_still_at_no_flow() {
	let out = painted(
		r#"
		walkTo(-600)
		Polestar.Set("nav.lineStyle", "sparkle")
		Polestar.Set("nav.sparkleSubtlety", 1) -- no jitter or spin: only the flow moves them
		nav.showWorldMap(9000)
		stub.advance(0.5)
		local world = R.GetWorldFrame()
		local a = stars(world)
		stub.advance(0.1)
		local b = stars(world)
		Polestar.Set("nav.sparkleFlow", 0)
		stub.advance(0.1)
		local c = stars(world)
		stub.advance(0.5)
		emit({ a = a, b = b, c = c, d = stars(world) })"#,
	);
	let (a, b, c, d) = (list(&out["a"]), list(&out["b"]), list(&out["c"]), list(&out["d"]));
	assert!(a.len() > 5);
	// the goal's way along the map
	let way = num(&a[a.len() - 1]["x"]) - num(&a[0]["x"]);
	let ahead = if way > 0.0 {
		1.0
	} else if way < 0.0 {
		-1.0
	} else {
		0.0
	};
	let mid = &a[a.len() / 2];
	let moved = b.iter().map(|s| (num(&s["x"]) - num(&mid["x"])) * ahead).filter(|dx| dx.abs() < 5.0).min_by(|p, q| p.abs().partial_cmp(&q.abs()).unwrap()).unwrap_or(f64::NAN);
	assert!(moved > 0.0, "the middle sparkle moved {moved} toward the goal");
	let xy = |v: &[Value]| v.iter().map(|s| json!([s["x"], s["y"]])).collect::<Vec<Value>>();
	assert_eq!(xy(&d), xy(&c), "no flow: they stay put");
}

const OPENMAP: &str = r#"
_G.OpenMapAPI = {
	IsStitched = function() return stub.stitched end,
	-- A stitched world 4000 yd across on the canvas: u east (from wy), v south (from wx).
	CanvasFromWorldPos = function(c, wx, wy) stub.asked = (stub.asked or 0) + 1; return (2000 - wy) / 4000, (2000 - wx) / 4000 end,
	ArtTopLevel = function() return 700 end,
}"#;

#[test]
fn openmap_s_stitched_world_map_places_the_sparkles_through_its_api_above_its_art() {
	let out = painted_with(
		r#"
		walkTo(-600)
		Polestar.Set("nav.lineStyle", "sparkle")
		stub.stitched = true
		nav.showWorldMap(9000)
		stub.advance(0.5)
		local world = R.GetWorldFrame()
		local s = stars(world)
		local xs = {}
		for i, p in ipairs(s) do xs[i] = p.x end
		emit({ n = #s, asked = stub.asked or 0, level = world:GetFrameLevel(), lo = math.min(unpack(xs)), hi = math.max(unpack(xs)) })"#,
		OPENMAP,
	);
	assert!(num(&out["n"]) > 5.0, "{} sparkles", out["n"]);
	assert!(num(&out["asked"]) > num(&out["n"]), "placed by CanvasFromWorldPos");
	assert!(num(&out["level"]) > 700.0, "above OpenMap's art");
	// Player at wy 0 (u 0.5, x 500), goal at wy -600 (u 0.65, x 650).
	assert!(num(&out["lo"]) >= 495.0 && num(&out["hi"]) <= 655.0, "along the walk ({}..{})", out["lo"], out["hi"]);
}

#[test]
fn the_most_sparkles_shown_bounds_each_surface_a_preset_sets_the_look_and_nothing_else() {
	let out = painted(
		r#"
		walkTo(-900)
		Polestar.Set("nav.lineStyle", "sparkle")
		Polestar.Set("nav.sparkleDensity", 10)
		Polestar.Set("nav.sparkleMax", 10)
		nav.viewRadius = 900
		Minimap:SetSize(400, 400)
		nav.showWorldMap(9000)
		stub.advance(0.5)
		local r = { world = R.GetSparkles("world"), minimap = R.GetSparkles("minimap") }
		r.preset = R.ApplySparklePreset("dazzling")
		r.unknown = R.ApplySparklePreset("loud")
		r.intensity, r.max, r.style = Polestar.Get("nav.sparkleIntensity"), Polestar.Get("nav.sparkleMax"), Polestar.Get("nav.lineStyle")
		emit(r)"#,
	);
	assert_eq!(out["world"], 10);
	assert_eq!(out["minimap"], 10);
	assert_eq!(out["preset"], true);
	assert_eq!(out["unknown"], false);
	assert_eq!(out["intensity"], 1);
	assert_eq!(out["max"], 10, "the ceiling is kept");
	assert_eq!(out["style"], "sparkle");
}

#[test]
fn a_long_route_costs_a_draw_only_the_sparkles_near_the_view_not_its_length() {
	let out = painted(
		r#"
		walkTo(-600)
		-- A 3000 yd walk, most of it past the shown map, and a 12000 yd flight on.
		local walk, flight = {}, {}
		for i = 0, 199 do walk[#walk + 1] = { 0, 60 * math.sin(i / 7), -i * 15 } end
		for i = 0, 59 do flight[#flight + 1] = { 0, i * 8000 / 59, -2985 - i * 9000 / 59 } end
		local geom = { legs = { { kind = "walk", pts = walk, current = true }, { kind = "flight", pts = flight } } }
		N.GetRouteGeometry = function() return geom end
		Polestar.Set("nav.lineStyle", "sparkle")
		Polestar.Set("nav.sparkleLater", true)
		nav.viewRadius = 150
		Minimap:SetSize(140, 140)
		nav.showWorldMap(9000)
		Polestar.Fire("NAV_ROUTE_GEOMETRY")
		stub.advance(0.5)
		local Sp = Polestar.RouteSparkle
		local twinkle, looked = Sp.Twinkle, 0
		Sp.Twinkle = function(...) looked = looked + 1; return twinkle(...) end
		stub.advance(0.05) -- one draw on each surface
		Sp.Twinkle = twinkle
		emit({ looked = looked, world = R.GetSparkles("world"), minimap = R.GetSparkles("minimap") })"#,
	);
	let (world, minimap, looked) = (num(&out["world"]), num(&out["minimap"]), num(&out["looked"]));
	assert!(world > 5.0 && minimap >= 2.0, "{} + {} shown", out["world"], out["minimap"]);
	assert!(looked <= world + minimap + 10.0, "{} places looked at for {} sparkles", out["looked"], world + minimap);
}

#[test]
fn the_whole_route_sparkles_the_later_legs_too_fainter() {
	let out = painted(
		r#"
		walkTo(-600)
		Polestar.Set("nav.lineStyle", "sparkle")
		local geom = { legs = {
			{ kind = "walk", pts = { { 0, 0, 0 }, { 0, 0, -300 } }, current = true },
			{ kind = "tram", pts = { { 0, 0, -300 }, { 0, 0, -600 } } },
		} }
		N.GetRouteGeometry = function() return geom end
		Polestar.Fire("NAV_ROUTE_GEOMETRY")
		local _, runs = R.GetSparkles("minimap")
		local now = #runs
		Polestar.Set("nav.sparkleLater", true)
		_, runs = R.GetSparkles("minimap")
		emit({ now = now, all = #runs, later = runs[2] and runs[2].later })"#,
	);
	assert_eq!(out["now"], 1);
	assert_eq!(out["all"], 2);
	assert_eq!(out["later"], true);
}

#[test]
fn the_route_lines_option_has_a_gear_that_opens_the_line_style_window_the_sparkle_settings_wait_for_the_sparkle_style() {
	let out = emitted(&RunAddon {
		stubs: vec!["stub_ui.lua"],
		addons: vec![Addon::files("Polestar", &["Core/Core.xml", "Theme/Theme.xml", "Maps/RouteSparkle.lua", "UI/UI.xml"])],
		script: r#"
Polestar.RegisterDefaults("nav", { routeLines = true, lineStyle = "dots" })
Polestar.RegisterDefaults("nav", Polestar.RouteSparkle.DEFAULTS)
uistub.install()
stub.login()
local UI, O = Polestar.UI, Polestar.UI.Options
UI.ShowOptions("guide")
O.Select("guide", "Arrow & routes")
local row = O.Controls("guide", "Arrow & routes")["nav.routeLines"]
local r = { gear = row and row.Gear ~= nil or false }
if row and row.Gear then row.Gear:Click() end
local win = _G.PolestarLineStyle
r.shown = win ~= nil and win:IsShown()
local controls = UI.LineStyleControls() or {}
local keys = {}
for key in pairs(controls) do keys[#keys + 1] = key end
table.sort(keys)
r.keys = keys
local intensity = controls["nav.sparkleIntensity"]
r.offWhileDots = intensity and not Polestar.Widgets.Enabled(intensity)
Polestar.Set("nav.lineStyle", "sparkle")
r.onWhileSparkle = intensity and Polestar.Widgets.Enabled(intensity)
emit(r)"#
			.into(),
		..Default::default()
	});
	let out = &out[0];
	assert_eq!(out["gear"], true, "a gear beside the switch");
	assert_eq!(out["shown"], true, "the gear opens the window");
	assert_eq!(
		out["keys"],
		json!(["nav.lineStyle", "nav.sparkleColor", "nav.sparkleDensity", "nav.sparkleFlow", "nav.sparkleIntensity", "nav.sparkleLater", "nav.sparkleMax", "nav.sparkleSize", "nav.sparkleSubtlety"])
	);
	assert_eq!(out["offWhileDots"], true);
	assert_eq!(out["onWhileSparkle"], true);
}
