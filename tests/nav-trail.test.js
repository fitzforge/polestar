'use strict';
// The travel route's trail (Pins.SetTrail, published by Nav/Layers.lua):
// dots from the player along the route's lines on the minimap and the world
// map. Real Core/Init.lua + Nav/Nav.xml against tests/lua/stub_nav.lua
// (map 9000: 2000 yd across, 20 yd per map percent, origin at its centre;
// map 9001 on continent 1, 1000 yd across; a 140 px minimap).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const NAV = { name: 'Polestar', files: ['Core/Init.lua', 'Nav/Nav.xml'] };

const MM_SPACING = 40; // yards between minimap dots
const MM_LIMIT = (70 - 2.5) / 0.35; // yards from the player a 5 px dot may sit at, view radius 200 on a 140 px minimap
const worldSpacing = (yardsAcross) => Math.max(15, yardsAcross / 60);

const PRELUDE = `
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
`;

function run(script) {
	return runAddon({
		stubs: ['stub_nav.lua'],
		addons: [NAV],
		login: true,
		script: `${PRELUDE}
nav.faction = "Alliance"
nav.useTravelWorld()
${script}`,
	}).emitted;
}

// Dots along a world polyline, anchored to its end: dot k sits (k + frac) *
// spacing yards before the last point; the start carries none. From the start.
function expectDots(pts, spacing, frac) {
	const n = pts.length;
	const rem = new Array(n).fill(0);
	for (let i = n - 2; i >= 0; i--) rem[i] = rem[i + 1] + Math.hypot(pts[i + 1][0] - pts[i][0], pts[i + 1][1] - pts[i][1]);
	const out = [];
	for (let k = Math.ceil(rem[0] / spacing - frac) - 1; k >= 0; k--) {
		const d = (k + frac) * spacing;
		let i = 0;
		while (i < n - 2 && rem[i + 1] > d) i++;
		const t = (rem[i] - d) / (rem[i] - rem[i + 1]);
		out.push([pts[i][0] + (pts[i + 1][0] - pts[i][0]) * t, pts[i][1] + (pts[i + 1][1] - pts[i][1]) * t]);
	}
	return out;
}

// Drawn dots (objects with wx, wy) match the expected world points, in order.
function assertDots(drawn, expected, what) {
	const got = (drawn || []).map((d) => [d.wx, d.wy]);
	assert.equal(got.length, expected.length, `${what}: ${got.length} dots, expected ${expected.length}`);
	got.forEach(([wx, wy], i) => {
		const [ex, ey] = expected[i];
		assert.ok(Math.abs(wx - ex) < 1e-6 && Math.abs(wy - ey) < 1e-6, `${what}: dot ${i + 1} at ${wx},${wy}, expected ${ex},${ey}`);
	});
}

function assertPoints(got, expected, what) {
	assert.equal(got.length, expected.length, what);
	got.forEach((p, i) => {
		assert.ok(Math.abs(p[0] - expected[i][0]) < 1e-6 && Math.abs(p[1] - expected[i][1]) < 1e-6,
			`${what}: point ${i + 1} ${p}, expected ${expected[i]}`);
	});
}

test('placement: a dot every spacing counted back from the end, continuous over joints, clipped and capped', () => {
	const [out] = run(`
		local function dots(...) local n, pts = Pins.TrailDots(...) return { n = n, pts = pts } end
		local L = { { 0, 0 }, { 100, 0 }, { 100, 100 } }
		emit({
			half = dots(L, 40, 0.5),
			zero = dots(L, 40, 0),
			clipped = dots(L, 40, 0.5, { 0, -10, 50, 10 }),
			capped = dots(L, 40, 0.5, nil, 3),
			later = dots({ { 30, 0 }, { 100, 0 }, { 100, 100 } }, 40, 0.5),
		})`);
	assertPoints(out.half.pts, [[20, 0], [60, 0], [100, 0], [100, 40], [100, 80]], 'phase 0.5');
	assertPoints(out.zero.pts, [[40, 0], [80, 0], [100, 20], [100, 60], [100, 100]], 'phase 0: a dot on the end');
	assertPoints(out.clipped.pts, [[20, 0]], 'only the part inside the rectangle');
	assertPoints(out.capped.pts, [[20, 0], [60, 0], [100, 0]], 'the cap keeps the dots nearest the start');
	assertPoints(out.later.pts, [[60, 0], [100, 0], [100, 40], [100, 80]], 'a later start keeps the dots in place');
});

test('minimap: dots 40 yd apart inside the visible disc or square, honouring rotation and the indoor zoom', () => {
	const [out] = run(`
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
		emit(r)`);
	// Phase 0.5 (held still): dots 20, 60, ... yd before the target, so 40, 80, 120, 160 yd east of the player.
	assert.deepEqual(out.east.map((d) => +d.x.toFixed(6)), [14, 28, 42, 56], '14 px (40 yd) apart, the 200 yd one clipped');
	assert.ok(out.east.every((d) => Math.abs(d.y) < 1e-9));
	const diagonal = expectDots([[0, 0], [-700, -500]], MM_SPACING, 0.5);
	assertDots(out.round, diagonal.filter(([n, w]) => Math.hypot(n, w) <= MM_LIMIT), 'round minimap');
	assertDots(out.square, diagonal.filter(([n, w]) => Math.max(Math.abs(n), Math.abs(w)) <= MM_LIMIT), 'square minimap');
	assert.ok(out.square.length > out.round.length, 'the square reaches further along a diagonal');
	assert.deepEqual(out.rotated.map(([x, y]) => [+x.toFixed(6), +y.toFixed(6)]), [[0, -14], [0, -28], [0, -42], [0, -56]]);
	assert.equal(out.indoor, 3, 'indoors the view is 150 yd: dots at 40, 80 and 120 yd');
	assert.deepEqual(out.look, [5, 0.85]);
	assert.ok(out.levels[0] < out.levels[1], `dots (level ${out.levels[0]}) under the target pin (${out.levels[1]})`);
});

test('world map: spacing scales with the viewed map (60 to its width, at least 15 yd), clipped to the map', () => {
	const [out] = run(`
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
		emit(r)`);
	const line = [[0, 0], [0, -900]];
	assertDots(out.zone, expectDots(line, worldSpacing(2000), 0.5), 'map 9000: 33.3 yd apart');
	assert.equal(out.zone.length, 27);
	assertDots(out.small, expectDots(line, worldSpacing(400), 0.5).filter(([, w]) => w >= -200), 'map 9002: the 15 yd floor');
	assert.equal(out.small.length, 13);
	const far = expectDots([[0, 1400], [0, 0]], worldSpacing(2000), 0.5);
	assertDots(out.clipped, far.filter(([, w]) => w <= 1000), 'only the part on the map');
	assert.ok(far.length > out.clipped.length);
	assert.ok(out.clipped.every((d) => d.x >= 0 && d.x <= 100 && d.y >= 0 && d.y <= 100));
	assert.deepEqual(out.pin, [6, false, 2010], "small, no mouse, under the pins (the map's PIN_FRAME_LEVEL_QUEST_BLOB)");
});

test('a flight route: dots run from the player along every leg on both surfaces', () => {
	const [out] = run(`
		Polestar.Set("ui.reduceMotion", true)
		nav.viewRadius = 200
		known(1, 2)
		nav.place(0, 600)
		target(0, -780, "Kobolds")
		nav.showWorldMap(9000)
		emit({ route = route(), runs = runsOf(), world = worldDots(9000), mm = mmDots() })`);
	assert.deepEqual(out.route, ['walk', 'fly', 'walk']);
	assert.equal(out.runs.n, 1);
	assert.equal(out.runs.list[0].live, true);
	assertPoints(out.runs.list[0].pts, [[0, 790], [0, -800], [0, -780]], 'flight master, East Hold, target');
	const line = [[0, 600], [0, 790], [0, -800], [0, -780]];
	assertDots(out.world, expectDots(line, worldSpacing(2000), 0.5), 'world map');
	assert.equal(out.world.length, 54, '1800 yd of route');
	assertDots(out.mm, expectDots(line, MM_SPACING, 0.5).filter(([n, w]) => Math.hypot(n, w - 600) <= MM_LIMIT), 'minimap');
});

test('no dots across a continent change or along a Hearthstone jump', () => {
	const [boat, hearth] = run(`
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
		emit({ route = route(), runs = runsOf(), world = worldDots(9000) })`);
	assert.deepEqual(boat.route, ['walk', 'boat', 'walk']);
	assert.equal(boat.runs.n, 2, 'the sea crossing breaks the line');
	assert.deepEqual([boat.runs.list[0].c, boat.runs.list[0].live, boat.runs.list[1].c, boat.runs.list[1].live], [1, true, 0, false]);
	assertDots(boat.farland, expectDots([[0, 0], [400, 0]], worldSpacing(1000), 0.5), 'Farland: to the pier only');
	assertDots(boat.testshire, expectDots([[-900, 0], [-800, 100]], worldSpacing(2000), 0.5), 'Testshire: from the docks only');

	assert.deepEqual(hearth.route, ['hearth', 'walk']);
	assert.equal(hearth.runs.n, 1, 'nothing between the player and the inn');
	assert.equal(hearth.runs.list[0].live, false);
	assertDots(hearth.world, expectDots([[-500, -700], [-200, -400]], worldSpacing(2000), 0.5), 'from the inn to the target only');
});

test('counts are capped: 40 on the minimap, 300 on the world map', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.equal(out.mm, 40);
	assert.equal(out.world, 300);
	assert.equal(out.pool, 300, 'no dots made beyond the cap');
});

test('the dots crawl toward the target while shown, and hold still with reduced motion', () => {
	const [out] = run(`
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
		emit(r)`);
	// x px = 0.35 * (900 - (k + phase) * 40): recover the phase from the first dot.
	const phase = (x) => ((((900 - x / 0.35) / 40) % 1) + 1) % 1;
	const moved = (((phase(out.x0[0]) - phase(out.x1[0])) % 1) + 1) % 1;
	assert.ok(Math.abs(moved - 0.5 / 1.5) < 0.04, `0.5 s moved the dots ${moved} of a spacing toward the target`);
	assert.equal(out.driver, true);
	assert.equal(out.hidden, false, 'no animation while the minimap is hidden');
	assert.equal(out.shown, true, 'it resumes once the minimap shows again');
	assert.deepEqual(out.s1, out.s0, 'reduced motion: the dots hold still');
	assert.equal(out.still, false, 'and nothing runs per frame');
	assert.ok(out.after.length >= out.before.length);
	for (const d of out.before) {
		assert.ok(out.after.some((e) => Math.abs(e.wx - d.wx) < 1e-6 && Math.abs(e.wy - d.wy) < 1e-6),
			`the dot at ${d.wx},${d.wy} stays put as the player walks`);
	}
});

test('nav.trailDots, nav.worldPins and nav.minimapPins switch the trail; no target, no trail', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.ok(out.on[0] >= 4 && out.on[0] <= 5 && out.on[1] === 27, `on: ${out.on}`);
	assert.equal(out.driverOn, true);
	assert.deepEqual(out.off, [0, 0]);
	assert.equal(out.gone, true);
	assert.equal(out.driver, false, 'the animation stops with the trail');
	assert.deepEqual(out.back, [4, 27]);
	assert.deepEqual(out.noMinimap, [0, 27]);
	assert.deepEqual(out.noWorld, [4, 0]);
	assert.deepEqual(out.noTarget, [0, 0]);
});

test('the trail follows the route as its legs advance (ROUTE_ADVANCED)', () => {
	const [out] = run(`
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
		emit(r)`);
	assert.ok(out.advanced >= 1);
	assert.equal(out.republished, true, 'a new trail on the advance');
	assert.deepEqual(out.route, ['fly', 'walk']);
	assertPoints(out.runs.list[0].pts, [[0, 790], [0, -800], [0, -780]], 'from the flight master on');
	assert.equal(out.last.runs.n, 1);
	assertPoints(out.last.runs.list[0].pts, [[0, -780]], 'only the target is left');
	const line = [[0, 785], [0, -780]];
	assertDots(out.last.mm, expectDots(line, MM_SPACING, 0.5).filter(([n, w]) => Math.hypot(n, w - 785) <= MM_LIMIT), 'minimap');
});
