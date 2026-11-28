'use strict';
// Farming loops (Core/Engine.lua pickFor, Own.farmView, Own.loopAim; Core/LoopTrack.lua; Polestar 0.4.4).
// Level: a loop's `lvl` is the least level safe on it (the profession builder's rule: no creature that can reach it
// more than a level above the player, no elite by it), and the Engine never takes a loop above the character,
// whatever else is left. A fresh level 3 Tauren in Mulgore was sent on the zone's level 8 loop, the only one then.
// With none at their level the goal has no place and the window says from which level one is safe; a level-up
// picks again. A loop being walked stays on a zone change unless another is much faster.
// Track: the picked loop is one closed track; the arrow joins it at the nearest point and leads a short way ahead
// along it, the points' way round, lap after lap, back to the nearest point ahead from off it; with no route to
// follow (TomTom, the planner off) the next point is a plain waypoint.
// Stub world, synthetic map (a map percent is 50 yards).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

// Red Cloud Mesa's starter loop (lvl 3) by Camp Narache, and a denser loop to the north-west (lvl 8).
const STARTER = '{ map = 1412, x = 45, y = 75, faction = "H", lvl = { min = 3, max = 3 }, lap = 300, yield = 6, spotsPacked = "45,75,,60;47,77,,60;45,79,,60" }';
const NORTH = '{ map = 1412, x = 35, y = 60, faction = "H", lvl = { min = 8, max = 8 }, lap = 540, yield = 24, spotsPacked = "35,60,,60;33,65,,60;36,70,,60" }';
// A square 1000 yards a side: 40,40 -> 60,40 -> 60,60 -> 40,60 and back.
const SQUARE = '{ map = 1412, x = 40, y = 40, faction = "H", lvl = { min = 1, max = 1 }, lap = 600, yield = 10, spotsPacked = "40,40,,60;60,40,,60;60,60,,60;40,60,,60" }';
// Two quick loops 2000 yards apart (one lap does the ore).
const WEST = '{ map = 1412, x = 20, y = 50, faction = "H", lvl = { min = 1, max = 1 }, lap = 120, yield = 20, spotsPacked = "20,50,,60;22,50,,60;21,52,,60" }';
const EAST = '{ map = 1412, x = 60, y = 50, faction = "H", lvl = { min = 1, max = 1 }, lap = 120, yield = 20, spotsPacked = "60,50,,60;62,50,,60;61,52,,60" }';

// The Engine with one Get step over `cands`, a level `level` Tauren at `at`; `script` runs after it is up, with
// view() (the goal's place and farm numbers) and emit. `planner`: a travel planner leading Polestar's own arrow
// (the track); without, the plain waypoint.
function engine(cands, level, at, script, planner = true) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: `
local w = stub.world
w.addMap(1412, { name = "Mulgore", c = 1, left = 0, right = -5000, top = 0, bottom = -5000 })
w.race, w.raceName, w.faction = "Tauren", "Tauren", "Horde"
w.level = ${level}
w.moveTo(1412, ${at[0]}, ${at[1]})
w.zone, w.subzone = "Mulgore", "Red Cloud Mesa"
`,
		addons: ['Polestar'],
		script: `${TEST_PACK}
${TEST_SOURCE}
${planner ? 'Polestar.Set("nav.travel", true)' : 'Polestar.Set("nav.travel", false)'}
Polestar.RegisterGuide({ id = "test/loops", pack = "test", title = "Mining", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Get Copper Ore", goals = { { t = "collect", item = 2770, itemName = "Copper Ore", count = 20, gather = { rank = 1, skill = "Mining", skillLine = 186 }, candidates = { ${cands.join(', ')} } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
E = Polestar.Engine
local w = stub.world
stub.login()
E.SetGuide("test/loops")
stub.advance(0.6)
local function round(v) return v and math.floor(v * 10 + 0.5) / 10 or false end
function view()
	local v = E.GetStepView(1).goals[1]
	local f = v.farm
	return { map = v.map or false, x = round(v.x), y = round(v.y), lap = f and f.lap or false, safeFrom = f and f.safeFrom or false,
		line = Polestar.UI.FarmLine(v) or false }
end
function at(x, y)
	w.moveTo(1412, x, y)
	stub.advance(0.6)
	return view()
end
${script}`,
	}).emitted[0];
}

function run(cands, level, levels = []) {
	return engine(cands, level, [45, 76], `
local out = { first = view(), after = {} }
for _, level in ipairs({ ${levels.join(', ')} }) do
	w.setLevel(level)
	stub.advance(0.6)
	out.after[#out.after + 1] = view()
end
emit(out)`);
}

test('a level 3 Tauren gets the Red Cloud Mesa starter loop, never the level 8 loop', () => {
	const out = run([NORTH, STARTER], 3);
	assert.equal(out.first.lap, 5, 'the starter loop: 5 min a lap');
	assert.ok(out.first.y >= 75 && out.first.y <= 79, `the arrow is on the starter loop (${out.first.x},${out.first.y})`);
});

test('no loop at the character\'s level: no place, and the window says from which level one is safe', () => {
	const out = run([NORTH], 3, [7, 8]);
	assert.equal(out.first.map, false, 'nothing to lead to');
	assert.equal(out.first.safeFrom, 8);
	assert.equal(out.first.line, 'Safe Copper Ore loop from level 8');
	assert.equal(out.after[0].safeFrom, 8, 'still none at 7');
	assert.equal(out.after[1].safeFrom, false, 'the level-up picks again');
	assert.equal(out.after[1].lap, 9);
	assert.equal(out.after[1].map, 1412);
});

test('the starter loop until the denser one is safe; the level-up keeps the loop the player is on, off it the faster one', () => {
	const out = engine([NORTH, STARTER], 2, [45, 76], `
local first = view()
w.setLevel(3); stub.advance(0.6)
local three = view()
w.setLevel(8); stub.advance(0.6)
local eight = view()
w.moveTo(1412, 40, 68); w.setZone("Mulgore", ""); stub.advance(0.6)
emit({ first = first, three = three, eight = eight, off = view() })`);
	assert.equal(out.first.safeFrom, 3, 'level 2: the starter loop opens at 3');
	assert.equal(out.three.lap, 5, 'level 3: the starter loop');
	assert.equal(out.eight.lap, 5, 'level 8 on the starter loop: it stays');
	assert.equal(out.off.lap, 9, 'off it, between the two: the denser loop finishes the ore sooner');
});

test('the arrow leads a short way ahead along the track, in the points\' order, and wraps round the lap', () => {
	const out = engine([SQUARE], 10, [41, 40], `
local wp = E.GetWaypoint()
emit({ walk = { view(), at(42, 40), at(43, 40) }, corner = at(59.9, 40), last = at(40, 40.2), wp = { loop = wp.loop or false, search = wp.search or false } })`);
	// 40 yards (0.8 %) ahead, on the next node (every 20 yards, 0.4 %) past that.
	assert.deepEqual(out.walk.map((v) => [v.x, v.y]), [[42, 40], [42.8, 40], [44, 40]], 'moves on as the player walks the first side');
	assert.deepEqual([out.corner.x, out.corner.y], [60, 40.8], 'round the corner onto the second side');
	assert.deepEqual([out.last.x, out.last.y], [40.8, 40], 'from the last side on round the lap to the first');
	assert.deepEqual(out.wp, { loop: true, search: true }, 'a track aim: never "arrived"');
});

test('off the track the arrow leads back to the nearest point of it, a short way ahead', () => {
	const out = engine([SQUARE], 10, [50, 30], 'emit({ off = view(), inside = at(50, 47) })');
	assert.deepEqual([out.off.x, out.off.y], [50.8, 40], '500 yards north of the first side: just past its nearest point');
	assert.deepEqual([out.inside.x, out.inside.y], [50.8, 40], 'inside the square, the first side is nearest');
});

test('with no route to follow, the next loop point is a plain waypoint', () => {
	const out = engine([SQUARE], 10, [45, 40], 'emit({ a = view(), b = at(59.8, 40), c = at(40, 40.2) })', false);
	assert.deepEqual([out.a.x, out.a.y], [60, 40], 'the next point');
	assert.deepEqual([out.b.x, out.b.y], [60, 60], '15 yards short of a point, the one after it');
	assert.deepEqual([out.c.x, out.c.y], [60, 40], 'round the lap');
});

test('a zone change keeps the loop being walked unless another is much faster', () => {
	const out = engine([WEST, EAST], 10, [21, 51], `
local first = view()
w.moveTo(1412, 41, 51)
w.setZone("Durotar", "")
stub.advance(0.6)
local midway = view()
w.moveTo(1412, 61, 51)
w.setZone("Mulgore", "")
stub.advance(0.6)
emit({ first = first, midway = midway, there = view() })`);
	assert.ok(out.first.x < 30, `the west loop (${out.first.x})`);
	assert.ok(out.midway.x < 30, `midway, the east loop a little nearer: still the west one (${out.midway.x})`);
	assert.ok(out.there.x > 50, `standing at the east loop, far faster: it (${out.there.x})`);
});
