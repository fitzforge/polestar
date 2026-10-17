'use strict';
// Route lines (Maps/RouteStrokes.lua, ported from Shortest Path Forever's
// UI/Strokes.lua, and Maps/RouteLines.lua, its painters): breadcrumbs spaced
// evenly along a walk's bends, the gap they leave at each stop's mark, later
// legs receding, flights along their tracks, solid strokes for rides, bounded
// pools, and the painters fed from Nav.GetRouteGeometry.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const DOT = 4, RIM = 1, SPACING = 9, SMALL_SPACING = 7, STOP_GAP = 2, LATER_ALPHA = 0.4;

// The geometry alone: Core/Init.lua for the namespace, then RouteStrokes.lua.
// `view(extra)` is a 1000 x 1000 unit world map at 1 px per unit over a map
// whose fraction is world yards / 1000 (fx = wy / 1000, fy = wx / 1000).
function strokes(script) {
	return runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Maps/RouteStrokes.lua'] }],
		script: `
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
${script}`,
	}).emitted;
}

const near = (a, b, eps = 1e-6) => Math.abs(a - b) < eps;

test('a walk is breadcrumbs spaced evenly along it, the spacing carried across its bends', () => {
	const [out] = strokes(`
		local buf = S.New()
		S.Map(buf, { path("walk", { { 100, 500 }, { 400, 500 }, { 400, 800 } }) }, view())
		emit(list(buf))`);
	assert.ok(out.length > 0);
	assert.ok(out.every((s) => s.dot && s.color === 'walk' && s.alpha === 1), 'all dots, walk colour, full strength');
	// Arc length along the L from (100, 500): every dot sits a whole number of spacings in.
	const along = (s) => (s.y === 500 ? s.x - 100 : 300 + (s.y - 500));
	out.forEach((s, i) => {
		assert.ok(near(along(s) % SPACING, 0, 1e-6) || near(along(s) % SPACING, SPACING, 1e-6), `dot ${i + 1} at ${along(s)} yd`);
		if (i > 0) assert.ok(near(along(s) - along(out[i - 1]), SPACING), `dot ${i + 1} follows ${SPACING} px on`);
	});
	// 600 px of walk: dots at 0, 9, ..., 594.
	assert.equal(out.length, Math.floor(599.999 / SPACING) + 1);
	assert.ok(out.some((s) => s.y > 500 && s.x === 400), 'dots run on round the bend');
	// Each dot's quad: the dot's diameter over the texture's disc share (64 / 42).
	assert.ok(near(out[0].len, DOT * 64 / 42) && near(out[0].width, DOT * 64 / 42));
	assert.ok(near(out[0].under, (DOT + 2 * RIM) * 64 / 42));
});

test('continent maps use smaller, closer dots', () => {
	const [out] = strokes(`
		local buf = S.New()
		S.Map(buf, { path("walk", { { 100, 500 }, { 400, 500 } }) }, view({ small = true }))
		emit(list(buf))`);
	assert.ok(near(out[1].x - out[0].x, SMALL_SPACING));
	assert.equal(out.length, Math.floor(299.999 / SMALL_SPACING) + 1);
});

test('dots leave a gap round each stop mark, and run up to it', () => {
	const [out] = strokes(`
		local buf = S.New()
		S.Map(buf, { path("walk", { { 100, 500 }, { 900, 500 } }) }, view({ marks = { 0.5, 0.5, 6 }, markCount = 1 }))
		emit(list(buf))`);
	const reach = 6 + STOP_GAP + DOT / 2 + RIM; // the mark's radius, the gap and a dot's rim
	const centres = out.map((s) => s.x);
	assert.ok(centres.every((x) => Math.abs(x - 500) >= reach), 'no dot inside the gap');
	const before = centres.filter((x) => x < 500).pop();
	const after = centres.find((x) => x > 500);
	assert.ok(500 - before < reach + SPACING && after - 500 < reach + SPACING, 'the dots come up to the gap on both sides');
});

test('legs after the current one recede; each kind keeps its colour; rides are solid strokes', () => {
	const [out] = strokes(`
		local buf = S.New()
		S.Map(buf, {
			path("walk", { { 100, 100 }, { 200, 100 } }),
			path("tram", { { 200, 100 }, { 300, 100 } }, true),
			path("boat", { { 300, 100 }, { 600, 100 } }, true),
		}, view())
		emit(list(buf))`);
	const walk = out.filter((s) => s.color === 'walk');
	const tram = out.filter((s) => s.color === 'tram');
	const boat = out.filter((s) => s.color === 'boat');
	assert.ok(walk.length > 5 && walk.every((s) => s.dot && s.alpha === 1), 'the current walk: dots at full strength');
	assert.equal(tram.length, 1, 'the tram: one stroke');
	assert.ok(!tram[0].dot && near(tram[0].alpha, LATER_ALPHA) && near(tram[0].width, 2), 'solid, 2 px, receding');
	assert.equal(boat.length, 12, 'a crossing between two docks: a bow of 12 strokes');
	assert.ok(boat.every((s) => !s.dot && near(s.alpha, LATER_ALPHA)));
	assert.ok(boat.some((s) => Math.abs(s.y - 100) > 10), 'the crossing bows off the straight line');
});

test('a flight follows its track between the flight masters, corners cut, ends kept', () => {
	const [out] = strokes(`
		-- Nodes 1 and 2 at wx 500, wy 100 and 900; the track bends north (wx 300) halfway.
		local tracks = { [1] = { [2] = { 505, 105, 300, 500, 495, 895 } } }
		local p = S.Path("flight", { { 0, 500, 100 }, { 0, 500, 900 } }, false, tracks, { 1, 2 })
		local plain = S.Path("flight", { { 0, 500, 100 }, { 0, 500, 900 } }, false, tracks, nil)
		local pts = {}
		for i = 1, p.n do pts[i] = { p.x[i], p.y[i] } end
		local buf = S.New()
		S.Map(buf, { p }, view())
		emit({ pts = pts, plain = plain.n, strokes = list(buf) })`);
	const { pts } = out;
	assert.deepEqual(pts[0], [500, 100], 'starts at the flight master');
	assert.deepEqual(pts[pts.length - 1], [500, 900], 'ends at the flight master');
	assert.ok(pts.length > 3, 'the track adds its bend, rounded into more points');
	assert.ok(Math.min(...pts.map((p) => p[0])) < 450, 'the line swings north with the track');
	assert.ok(Math.min(...pts.map((p) => p[0])) > 300, 'cut corners never overshoot the track');
	assert.equal(out.plain, 2, 'no node ids: straight between the nodes');
	assert.ok(out.strokes.length > 2 && out.strokes.every((s) => !s.dot && s.color === 'flight'));
});

test('lines are clipped to the map; nothing is drawn for another continent', () => {
	const [out] = strokes(`
		local buf = S.New()
		S.Map(buf, { path("tram", { { -500, 500 }, { 1500, 500 } }) }, view())
		local clipped = list(buf)
		local other = S.Path("tram", { { 1, 500, 100 }, { 1, 500, 900 } })
		S.Map(buf, { other }, view())
		emit({ clipped = clipped, other = buf.n })`);
	assert.equal(out.clipped.length, 1);
	assert.ok(near(out.clipped[0].x, 500) && near(out.clipped[0].len, 1000), 'only the part on the map');
	assert.equal(out.other, 0);
});

test('every buffer is bounded: a pool never grows past its limit', () => {
	const [out] = strokes(`
		local small, full = S.New(50), S.New()
		local long = path("walk", { { 0, 0 }, { 1000, 0 }, { 1000, 1000 }, { 0, 1000 }, { 0, 0 }, { 1000, 1000 } })
		S.Map(small, { long }, view({ scale = 4 }))
		-- At 40 px per unit the same walk asks for far more than the limit.
		S.Map(full, { long }, view({ scale = 40 }))
		emit({ small = small.n, full = full.n, limit = S.LIMIT, cap = S.New(99999).limit })`);
	assert.equal(out.small, 50);
	assert.equal(out.full, out.limit);
	assert.equal(out.cap, out.limit, 'a buffer never asks for more than the limit');
});

test('redrawing reuses the buffer: no table is allocated per draw', () => {
	const [out] = strokes(`
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
		emit({ grown = grown(3000) - base, n = buf.n })`);
	assert.ok(out.n > 0);
	assert.ok(out.grown < 1, `2990 more redraws allocated ${out.grown} KB`);
});

test('minimap: projected around the player, turned with the facing, clipped to the face, a gap at the guide pin', () => {
	const [out] = strokes(`
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
		emit({ east = east, turned = turned, gap = list(buf), gx = gx, gy = gy })`);
	assert.ok(out.east.every((s) => near(s.y, 50) && s.x >= 50), 'east of the centre, on its row');
	assert.ok(Math.max(...out.east.map((s) => s.x)) < 100, 'clipped inside the face');
	assert.ok(out.turned.every((s) => near(s.x, 50, 1e-6) && s.y >= 50), 'turned: down from the centre');
	assert.ok(near(out.gx, 0.5) && near(out.gy, 0));
	const reach = 8 + STOP_GAP + DOT / 2 + RIM;
	assert.ok(out.gap.every((s) => Math.abs(s.x - 75) >= reach), 'no dot under the guide pin');
});

test('the live start: the nearest point ahead on the walk, progress never runs back', () => {
	const [out] = strokes(`
		local p = S.Path("walk", { { 0, 0, 0 }, { 0, 0, -100 }, { 0, -100, -100 }, { 0, -100, 0 } })
		local a = S.Live(p, 0, 5, -50, nil, 60)
		local b = S.Live(p, 0, -50, -95, a, 60)
		local back = S.Live(p, 0, 5, -50, b, 60)
		local far = S.Live(p, 0, 500, 500, nil, 60)
		emit({ a = a, b = b, back = back, far = far or false })`);
	assert.equal(out.a, 2, 'on the first segment');
	assert.equal(out.b, 3, 'on the second');
	assert.equal(out.back, 3, 'walking back does not undo progress');
	assert.equal(out.far, false, 'off the walk: no live start');
});

// The painters with Nav: Core/Init.lua, Nav/Nav.xml and the route line files
// against tests/lua/stub_nav.lua (map 9000: 2000 yd across, origin at its centre).
const LINES = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml', 'Maps/FlightPaths.lua', 'Maps/RouteStrokes.lua', 'Maps/RouteLines.lua'] };

function painted(script) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [LINES],
		login: true,
		script: `
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
${script}`,
	}).emitted;
}

test('the painters draw the route on the world map and the minimap, and stand in for the trail', () => {
	const [out] = painted(`
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
		emit(r)`);
	assert.equal(out.active, true);
	assert.equal(out.paths, 1, 'one walk to the target');
	assert.ok(out.world > 10 && out.worldLines === out.world, `world map: ${out.world} strokes, ${out.worldLines} lines shown`);
	assert.ok(out.minimap > 5, `minimap: ${out.minimap} strokes`);
	assert.equal(out.trail, false, 'the trail stands down while the lines draw');
	assert.equal(out.offWorld, true, 'nav.routeLines off: no world lines');
	assert.equal(out.offTrail, true, 'and the trail is back');
	assert.equal(out.backTrail, false);
	assert.ok(out.backWorld > 10);
});

test('the minimap redraws only when something changed, and its line pool never shrinks or passes its bound', () => {
	const [out] = painted(`
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
		emit({ first = first, still = still, moved = moved, limit = strokes.limit })`);
	assert.ok(out.first > 0);
	assert.equal(out.still, true, 'no redraw while nothing changes');
	assert.equal(out.moved, true, 'moving redraws');
	assert.ok(out.limit <= 600);
});

// The lines are Polestar's own frame on the canvas (Nav/MapCanvas.lua): nothing
// is acquired from the map or released to it, so combat changes nothing.
test('NAV_QA C4: in combat the world map lines redraw on the frame in hand and turn off at once', () => {
	const [out] = painted(`
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
		emit(r)`);
	assert.equal(out.samePin, true, 'the frame in hand is redrawn, not swapped');
	assert.ok(out.lines > 10);
	assert.equal(out.offInCombat, true, 'turning the lines off in combat takes effect at once');
});

test('NAV_QA C5: a secret position or facing hides the minimap line, with no error', () => {
	const [out] = painted(`
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
		emit({ before = before, hidden = hidden, back = R.GetStrokes("minimap").n })`);
	assert.ok(out.before > 0);
	assert.equal(out.hidden, 0, 'hidden while the facing is unreadable');
	assert.ok(out.back > 0, 'back once it reads again');
});

test('NAV_QA C12: a pooled line swapping between dot and stroke starts from the whole texture', () => {
	const [out] = painted(`
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
		emit({ coords = line.texCoord, dot = pin.dots[1] })`);
	assert.equal(out.dot, false);
	assert.deepEqual(out.coords, [0, 1, 0, 1]);
});

test('NAV_QA K7: a zero-length lift leg (its shaft point twice) draws nothing and never divides by zero', () => {
	const [out] = strokes(`
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
		emit({ finite = ok, n = buf.n, lift = mm.n, live = S.Live(lift, 0, 500, 500, nil, 60) or false })`);
	assert.equal(out.finite, true, 'no NaN or infinite stroke');
	assert.ok(out.n > 5, 'the walk after it still draws');
	assert.equal(out.lift, 0);
});

test('a multi-point boat draws straight along its points and never wraps to its last point (SPF Strokes.lua:298 note)', () => {
	const [out] = strokes(`
		local buf = S.New()
		S.Map(buf, { path("boat", { { 100, 100 }, { 300, 100 }, { 300, 300 } }) }, view())
		emit(list(buf))`);
	assert.equal(out.length, 2);
	assert.ok(near(out[0].y, 100) && near(out[0].x, 200));
	assert.ok(near(out[1].x, 300) && near(out[1].y, 200));
});

test('NAV_QA K8: a chokepoint stop wears its glyph; a hand-made stop (no choke) keeps the plain disc', () => {
	const [out] = painted(`
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
			out[i] = { icon = p.icon or false, backdrop = p.backdrop or false, tip = GameTooltip.lines }
		end
		emit(out)`);
	assert.equal(out.length, 3);
	assert.equal(out[0].icon, 'icon-bridge');
	assert.equal(out[0].backdrop, true);
	assert.ok(out[0].tip.includes('Lakeshire bridge'), 'the chokepoint is named in the tooltip');
	assert.equal(out[1].icon, 'icon-cave', 'a tunnel wears the cave glyph; no name, no extra line');
	assert.equal(out[2].icon, false, 'no choke: the plain disc');
	assert.equal(out[2].backdrop, false);
});

test('review P3-8: Blizzard_WorldMap loading after login draws the route lines on the map', () => {
	const [out] = runAddon({
		stubs: ['stub_nav.lua'],
		before: 'stub.savedMap = WorldMapFrame; WorldMapFrame = nil',
		addons: [LINES],
		login: true,
		script: `
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
emit({ before = before == nil, shown = f ~= nil and f:IsShown(), strokes = R.GetStrokes("world").n })`,
	}).emitted;
	assert.equal(out.before, true);
	assert.equal(out.shown, true, 'the lines show once the map addon loads');
	assert.ok(out.strokes > 10);
});

test('review P3-9: the world map walk starts at the player with the minimap line off', () => {
	const [out] = painted(`
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
		emit({ start = start, moved = firstX(), minimap = R.GetStrokes("minimap").n })`);
	assert.equal(out.minimap, 0, 'no minimap line');
	assert.ok(out.start < 510, `starts at the planned start (${out.start})`);
	assert.ok(out.moved > 640, `then at the player (${out.moved})`);
});

test('review P3-9: Active() counts only legs that draw: no one-point, jump-only or zero-length route stands in for the trail', () => {
	const [out] = painted(`
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
		emit(r)`);
	for (const k of ['hearth', 'teleport', 'onePoint', 'shaft', 'unknownKind']) {
		assert.equal(out[k].active, false, `${k}: nothing to draw`);
		assert.equal(out[k].trail, true, `${k}: the trail stands in`);
	}
	assert.equal(out.walk.active, true);
	assert.equal(out.walk.trail, false);
});

test('review P3-9: a theme change re-applies the outline colour to pooled lines', () => {
	const [out] = runAddon({
		stubs: ['stub_nav.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Theme/Theme.xml', 'Nav/Nav.xml', 'Maps/FlightPaths.lua', 'Maps/RouteStrokes.lua', 'Maps/RouteLines.lua'] }],
		login: true,
		script: `
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
emit({ got = { r, g, b }, want = { sr, sg, sb } })`,
	}).emitted;
	assert.deepEqual(out.got, out.want);
});

test('the committed FlightPaths.lua holds the real network\'s tracks (not a test fixture\'s)', () => {
	const [out] = strokes(`
		local f = assert(loadfile(${JSON.stringify(require('node:path').join(__dirname, '..', 'addon', 'Polestar', 'Maps', 'FlightPaths.lua'))}))
		local ns = {}
		f("Polestar", ns)
		local pairs_, from = 0, 0
		for _, to in pairs(ns.FlightTracks) do
			from = from + 1
			for _ in pairs(to) do pairs_ = pairs_ + 1 end
		end
		local sw = ns.FlightTracks[2] and ns.FlightTracks[2][4]
		emit({ pairs = pairs_, from = from, stormwindToSentinel = sw and #sw or 0 })`);
	assert.ok(out.pairs > 200, `${out.pairs} tracks`);
	assert.ok(out.stormwindToSentinel >= 6, 'Stormwind to Sentinel Hill has its bends');
});
