'use strict';
// Route lines as sparkles (Maps/RouteSparkle.lua, ported from Forever Sparkle
// Trail, and its painters in Maps/RouteLines.lua, nav.lineStyle "sparkle"):
// the draw paths measured by continent, sparkles spaced evenly and drifting
// toward the goal, the settings in range, both surfaces painted from their
// own pools, OpenMap's stitched world map, and the style window behind the
// "Route lines" gear.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

function sparkle(script) {
	return runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Maps/RouteStrokes.lua', 'Maps/RouteSparkle.lua'] }],
		script: `
local S, Sp = Polestar.RouteStrokes, Polestar.RouteSparkle
local function path(kind, pts, later) return S.Path(kind, pts, later) end
${script}`,
	}).emitted;
}

const near = (a, b, eps = 1e-6) => Math.abs(a - b) < eps;

test('the draw paths become runs measured in yards, split where they change continent; later legs only on request', () => {
	const [out] = sparkle(`
		local walk = path("walk", { { 0, 0, 0 }, { 0, 0, -300 }, { 0, 400, -300 } })
		local boat = path("boat", { { 0, 400, -300 }, { 1, 0, 0 }, { 1, 0, 500 } }, true)
		local now, all = Sp.Paths({ walk, boat }, false), Sp.Paths({ walk, boat }, true)
		local r = { now = #now, all = #all, total = now[1].total, c = {} }
		for i, run in ipairs(all) do r.c[i] = { c = run.c, later = run.later, total = run.total } end
		emit(r)`);
	assert.equal(out.now, 1, 'the current walk only');
	assert.ok(near(out.total, 700));
	assert.equal(out.all, 2, 'the boat\'s one point on its first continent draws nothing; its run on the second does');
	assert.deepEqual(out.c[1], { c: 1, later: true, total: 500 });
});

test('sparkles sit a spacing apart from the start on, ease in and out, and keep their numbers as they flow', () => {
	const [out] = sparkle(`
		local run = Sp.Paths({ path("walk", { { 0, 0, 0 }, { 0, 0, -100 } }) })[1]
		local function list(from, phase)
			local out = {}
			Sp.Emit(run, from, 10, phase, 100, function(x, y, k, nx, ny, fade) out[#out + 1] = { along = -y, k = k, fade = fade } end)
			return out
		end
		emit({ still = list(0, 0), flowed = list(0, 0.25), ahead = list(42, 0), capped = Sp.Emit(run, 0, 10, 0, 3, function() end) })`);
	const along = out.still.map((s) => s.along);
	assert.ok(along.every((a, i) => i === 0 || near(a - along[i - 1], 10)), 'evenly spaced');
	assert.ok(out.still.every((s) => s.fade > 0 && s.fade <= 1));
	assert.ok(near(out.flowed[0].along, 2.5) && out.flowed[0].k === 0, 'a quarter spacing on, sparkle 0 is still sparkle 0');
	assert.ok(out.ahead.every((s) => s.along >= 42), 'nothing behind the start');
	assert.equal(out.capped, 3);
});

test('the nearest point on a run is measured along it; another continent has none', () => {
	const [out] = sparkle(`
		local run = Sp.Paths({ path("walk", { { 0, 0, 0 }, { 0, 0, -100 }, { 0, 100, -100 } }) })[1]
		local a, off = Sp.Nearest(run, 0, 5, -50)
		local b = Sp.Nearest(run, 0, 50, -110)
		emit({ a = a, off = off, b = b, other = Sp.Nearest(run, 1, 5, -50) or false })`);
	assert.ok(near(out.a, 50) && near(out.off, 5));
	assert.ok(near(out.b, 150));
	assert.equal(out.other, false);
});

test('a draw looks only along the stretches that reach the view, and finds the same sparkles there as the whole run', () => {
	const [out] = sparkle(`
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
			unprojected = Sp.Spans(run, {}, {}, -1e9, 1e9, -1e9, 1e9, spans) })`);
	assert.equal(out.n, 1, 'the two segments at the corner, merged');
	assert.ok(near(out.lo, 500) && near(out.hi, 1500), `${out.lo}..${out.hi}`);
	assert.deepEqual(out.inside, out.whole, 'same numbers, same fades');
	assert.ok(out.inside.length > 10);
	assert.equal(out.none, 0, 'nothing reaches a box off the run');
	assert.equal(out.unprojected, 0, 'points that could not be projected show nothing');
});

test('the style brings hand-edited settings into range, and subtlety calms every sparkle', () => {
	const [out] = sparkle(`
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
			calm = { halo = calm.halo, jitter = calm.jitter, size = calm.size }, bold = { halo = bold.halo, size = bold.size }, peak = peak })`);
	assert.ok(out.wild.alpha <= 1, 'intensity at most 100%');
	assert.equal(out.wild.spacing, 9, 'density at most 10');
	assert.ok(near(out.wild.size, 14 * (1 - 0.45 * 0.35)), 'a size that is not a number: the default');
	assert.equal(out.wild.max, 10, 'at least 10 sparkles');
	assert.equal(out.wild.gold, true, 'an unknown colour: loot gold');
	assert.equal(out.route, true, 'route colours: each leg its own');
	assert.equal(out.calm.halo, 0, 'no glow at full subtlety');
	assert.equal(out.calm.jitter, 0);
	assert.ok(out.calm.size < out.bold.size);
	assert.ok(out.peak > 0 && out.peak <= 1);
});

// The painters with Nav, as tests/nav-route-lines.test.js (map 9000: 2000 yd
// across, origin at its centre).
const LINES = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml', 'Maps/FlightPaths.lua', 'Maps/RouteStrokes.lua', 'Maps/RouteSparkle.lua', 'Maps/RouteLines.lua'] };

function painted(script, before = '') {
	return runAddon({
		stubs: ['stub_nav.lua'],
		before,
		addons: [LINES],
		login: true,
		script: `
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
${script}`,
	}).emitted;
}

test('the sparkle style paints both surfaces instead of the dots, still standing in for the trail, and back', () => {
	const [out] = painted(`
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
		emit(r)`);
	assert.ok(out.world > 5, `world map: ${out.world} sparkles`);
	assert.ok(out.minimap >= 2, `minimap: ${out.minimap} sparkles`);
	assert.equal(out.lines, 0, 'no dots under them');
	assert.equal(out.strokes, 0);
	assert.equal(out.active, true);
	assert.equal(out.trail, false, 'the trail stays down');
	assert.equal(out.dotsWorld, 0, 'dots again: the sparkles hide');
	assert.equal(out.dotsMinimap, 0);
	assert.ok(out.dotLines > 10, 'and the dots are back');
});

test('the sparkles drift toward the goal while they flow, and hold still at no flow', () => {
	const [out] = painted(`
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
		emit({ a = a, b = b, c = c, d = stars(world) })`);
	const { a, b, c, d } = out;
	assert.ok(a.length > 5);
	const ahead = Math.sign(a[a.length - 1].x - a[0].x); // the goal's way along the map
	const mid = a[Math.floor(a.length / 2)];
	const moved = b.map((s) => (s.x - mid.x) * ahead).filter((dx) => Math.abs(dx) < 5).sort((p, q) => Math.abs(p) - Math.abs(q))[0];
	assert.ok(moved > 0, `the middle sparkle moved ${moved} toward the goal`);
	assert.deepEqual(d.map((s) => [s.x, s.y]), c.map((s) => [s.x, s.y]), 'no flow: they stay put');
});

test('OpenMap\'s stitched world map places the sparkles through its API, above its art', () => {
	const before = `
_G.OpenMapAPI = {
	major = 1,
	IsStitched = function() return stub.stitched end,
	WorldFromMap = function() end,
	MapFromWorld = function() end,
	-- A stitched world 4000 yd across on the canvas: u east (from wy), v south (from wx).
	CanvasFromWorldPos = function(c, wx, wy) stub.asked = (stub.asked or 0) + 1; return (2000 - wy) / 4000, (2000 - wx) / 4000 end,
	ArtTopLevel = function() return 700 end,
}`;
	const [out] = painted(`
		walkTo(-600)
		Polestar.Set("nav.lineStyle", "sparkle")
		stub.stitched = true
		nav.showWorldMap(9000)
		stub.advance(0.5)
		local world = R.GetWorldFrame()
		local s = stars(world)
		local xs = {}
		for i, p in ipairs(s) do xs[i] = p.x end
		emit({ n = #s, asked = stub.asked or 0, level = world:GetFrameLevel(), lo = math.min(unpack(xs)), hi = math.max(unpack(xs)) })`, before);
	assert.ok(out.n > 5, `${out.n} sparkles`);
	assert.ok(out.asked > out.n, 'placed by CanvasFromWorldPos');
	assert.ok(out.level > 700, 'above OpenMap\'s art');
	// Player at wy 0 (u 0.5, x 500), goal at wy -600 (u 0.65, x 650).
	assert.ok(out.lo >= 495 && out.hi <= 655, `along the walk (${out.lo}..${out.hi})`);
});

test('the most sparkles shown bounds each surface; a preset sets the look and nothing else', () => {
	const [out] = painted(`
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
		emit(r)`);
	assert.equal(out.world, 10);
	assert.equal(out.minimap, 10);
	assert.equal(out.preset, true);
	assert.equal(out.unknown, false);
	assert.equal(out.intensity, 1);
	assert.equal(out.max, 10, 'the ceiling is kept');
	assert.equal(out.style, 'sparkle');
});

test('a long route costs a draw only the sparkles near the view, not its length', () => {
	const [out] = painted(`
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
		emit({ looked = looked, world = R.GetSparkles("world"), minimap = R.GetSparkles("minimap") })`);
	assert.ok(out.world > 5 && out.minimap >= 2, `${out.world} + ${out.minimap} shown`);
	assert.ok(out.looked <= out.world + out.minimap + 10, `${out.looked} places looked at for ${out.world + out.minimap} sparkles`);
});

test('the whole route sparkles the later legs too, fainter', () => {
	const [out] = painted(`
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
		emit({ now = now, all = #runs, later = runs[2] and runs[2].later })`);
	assert.equal(out.now, 1);
	assert.equal(out.all, 2);
	assert.equal(out.later, true);
});

test('the Route lines option has a gear that opens the line style window; the sparkle settings wait for the sparkle style', () => {
	const [out] = runAddon({
		stubs: ['stub_ui.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Maps/RouteSparkle.lua', 'UI/UI.xml'] }],
		script: `
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
emit(r)`,
	}).emitted;
	assert.equal(out.gear, true, 'a gear beside the switch');
	assert.equal(out.shown, true, 'the gear opens the window');
	assert.deepEqual(out.keys, ['nav.lineStyle', 'nav.sparkleColor', 'nav.sparkleDensity', 'nav.sparkleFlow', 'nav.sparkleIntensity',
		'nav.sparkleLater', 'nav.sparkleMax', 'nav.sparkleSize', 'nav.sparkleSubtlety']);
	assert.equal(out.offWhileDots, true);
	assert.equal(out.onWhileSparkle, true);
});
