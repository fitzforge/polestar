'use strict';
// Farming loops and the character's level (Core/Engine.lua pickFor, Own.farmView; Polestar 0.4.4): a loop's `lvl`
// is the least level safe on it (the profession builder's rule: no creature that can reach it more than a level
// above the player, no elite by it), and the Engine never takes a loop above the character, whatever else is left.
// A fresh level 3 Tauren in Mulgore was sent on the zone's level 8 loop, the only one then. With none at their
// level the goal has no place and the window says from which level one is safe; a level-up picks again.
// Stub world, synthetic map (a map percent is 50 yards).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

// Red Cloud Mesa's starter loop (lvl 3) by Camp Narache, and a denser loop to the north-west (lvl 8).
const STARTER = '{ map = 1412, x = 45, y = 75, faction = "H", lvl = { min = 3, max = 3 }, lap = 300, yield = 6, spotsPacked = "45,75,,60;47,77,,60;45,79,,60" }';
const NORTH = '{ map = 1412, x = 35, y = 60, faction = "H", lvl = { min = 8, max = 8 }, lap = 540, yield = 24, spotsPacked = "35,60,,60;33,65,,60;36,70,,60" }';

function run(cands, level, levels = [], extra = '') {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: `
local w = stub.world
w.addMap(1412, { name = "Mulgore", c = 1, left = 0, right = -5000, top = 0, bottom = -5000 })
w.race, w.raceName, w.faction = "Tauren", "Tauren", "Horde"
w.level = ${level}
w.moveTo(1412, 45, 76)
w.zone, w.subzone = "Mulgore", "Red Cloud Mesa"
`,
		addons: ['Polestar'],
		script: `${TEST_PACK}
${TEST_SOURCE}
<<<<<<< HEAD
${planner ? 'Polestar.Set("nav.travel", true)' : 'Polestar.Set("nav.travel", false)'}
=======
>>>>>>> parent of fc9a69f093 (Farming loops: one closed track the arrow runs round, drawn on the zone map and minimap)
Polestar.RegisterGuide({ id = "test/loops", pack = "test", title = "Mining", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Get Copper Ore", goals = { { t = "collect", item = 2770, itemName = "Copper Ore", count = 20, gather = { rank = 1, skill = "Mining", skillLine = 186 }, candidates = { ${cands.join(', ')} } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
E = Polestar.Engine
local w = stub.world
stub.login()
E.SetGuide("test/loops")
stub.advance(0.6)
local function view()
	local v = E.GetStepView(1).goals[1]
	local f = v.farm
	return { map = v.map or false, x = v.x or false, y = v.y or false, lap = f and f.lap or false, safeFrom = f and f.safeFrom or false,
		line = Polestar.UI.FarmLine(v) or false }
end
local out = { first = view(), after = {} }
for _, level in ipairs({ ${levels.join(', ')} }) do
	w.setLevel(level)
	stub.advance(0.6)
	out.after[#out.after + 1] = view()
end
${extra}
emit(out)`,
	}).emitted[0];
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
