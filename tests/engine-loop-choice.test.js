'use strict';
// Which farming loop the Engine picks (Core/Engine.lua pickFor, Own.tripSafe, Own.loopShare; Polestar 0.4.4, two
// in-game reports on try10): a level 3 Tauren on Red Cloud Mesa was sent to Durotar's loop across the Barrens
// (creatures of 10-20), and a level 26 in Durotar was sent round the Valley of Trials' starter loop. Now a loop only
// reached through zones well above the character is none of theirs, a loop on the player's own map comes first
// while it is competitive, a starting area's own loop (`starter`) is for low levels unless nothing else is left, and
// a loop mined out hands over to the next best with one line, never flip-flopping.
// Stub world: Mulgore (west), the Barrens (between, 10-25) and Durotar (east) on one continent, 5000 yd each.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const loop = (map, lvl, lap, yld, pts, extra = '') => `{ map = ${map}, x = ${pts[0][0]}, y = ${pts[0][1]}, faction = "H", lvl = { min = ${lvl}, max = ${lvl} }, lap = ${lap}, yield = ${yld}${extra}, spotsPacked = "${pts.map(([x, y]) => `${x},${y},,60`).join(';')}" }`;
// Red Cloud Mesa's copper (safe from 2, 5.9 a lap) and Durotar's Valley of Trials (safe from 3, 14.2 a lap), as
// try10's Mining guide has them; a full Durotar loop and a Barrens one.
const RED_CLOUD = loop(1412, 2, 307, 5.9, [[49, 92.8], [49.2, 87.7], [41.8, 79.8], [41.2, 82]], ', starter = true');
const VALLEY = loop(1411, 3, 331, 14.2, [[45.8, 66.6], [45.6, 70.8], [43, 71.6], [40.3, 70.7]], ', starter = true');
const DUROTAR = loop(1411, 8, 400, 14, [[55, 30], [60, 32], [58, 40], [53, 38]]);
const BARRENS = loop(1413, 12, 420, 16, [[50, 30], [55, 33], [52, 40]]);

function engine(cands, { level, at, race = 'Tauren', count = 140 }, script = 'emit(view())', before = '') {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: `
local w = stub.world
w.addMap(1412, { name = "Mulgore", c = 1, left = 0, right = -5000, top = 0, bottom = -5000 })
w.addMap(1413, { name = "The Barrens", c = 1, left = -5000, right = -10000, top = 0, bottom = -5000 })
w.addMap(1411, { name = "Durotar", c = 1, left = -10000, right = -15000, top = 0, bottom = -5000 })
w.race, w.raceName, w.faction = "${race}", "${race}", "Horde"
w.level = ${level}
w.moveTo(${at[0]}, ${at[1]}, ${at[2]})
${before}
`,
		addons: ['Polestar'],
		script: `${TEST_PACK}
${TEST_SOURCE}
Polestar.Set("nav.travel", true)
-- The zones by world position (the walking maps' answer) and their levels.
Polestar.Nav.danger.ZoneAt = function(c, wx, wy) return wy > -5000 and 1412 or wy > -10000 and 1413 or 1411 end
local levels = { [1412] = { 1, 10 }, [1413] = { 10, 25 }, [1411] = { 1, 10 } }
Polestar.Maps.GetZoneLevels = function(id) local l = levels[id]; if l then return l[1], l[2], l[1] end end
Polestar.RegisterGuide({ id = "test/loops", pack = "test", title = "Mining", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Mine ${count} Copper Ore", goals = { { t = "collect", item = 2770, itemName = "Copper Ore", count = ${count}, gather = { rank = 1, skill = "Mining", skillLine = 186 }, candidates = { ${cands.join(', ')} } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
E = Polestar.Engine
local w = stub.world
stub.login()
E.SetGuide("test/loops")
stub.advance(0.6)
function view()
	local v = E.GetStepView(1).goals[1]
	local f = v.farm
	return { map = v.map or false, lap = f and f.lap or false, line = Polestar.UI.FarmLine(v) or false, out = f and f.out and f.out.map or false }
end
${script}`,
	}).emitted[0];
}

test('a level 3 Tauren on Red Cloud Mesa gets the Red Cloud Mesa loop, never Durotar\'s across the Barrens', () => {
	const out = engine([VALLEY, RED_CLOUD], { level: 3, at: [1412, 57.8, 83] });
	assert.equal(out.map, 1412, `the loop picked is on map ${out.map}`);
	assert.equal(out.lap, 5);
});

test('a loop only reached across the Barrens is none of a low-level character\'s', () => {
	const out = engine([VALLEY], { level: 3, at: [1412, 57.8, 83] });
	assert.equal(out.map, false, 'no loop: the Valley is 10k yards across creatures of 10 and more');
	const later = engine([VALLEY], { level: 9, at: [1412, 57.8, 83] });
	assert.equal(later.map, 1411, 'at level 9 the Barrens (from 10) are within a level or two: the Valley is fine');
});

test('a level 3 orc in the Valley of Trials gets the Valley loop', () => {
	const out = engine([RED_CLOUD, VALLEY, BARRENS], { level: 3, at: [1411, 44, 68], race: 'Orc' });
	assert.equal(out.map, 1411);
	assert.equal(out.lap, 6, 'the Valley loop (331 s)');
});

test('a level 26 in Durotar gets a full Durotar or Barrens loop, not the Valley of Trials starter loop', () => {
	const out = engine([VALLEY, DUROTAR, BARRENS], { level: 26, at: [1411, 44, 68], race: 'Orc' });
	assert.ok(out.map === 1411 || out.map === 1413, `map ${out.map}`);
	assert.notEqual(out.lap, 6, 'not the Valley loop');
});

test('a starting area\'s loop is still offered past its band when it is the only one left', () => {
	const out = engine([VALLEY], { level: 26, at: [1411, 44, 68], race: 'Orc' });
	assert.equal(out.map, 1411);
	assert.equal(out.lap, 6);
});

test('a small loop mined out hands over to the next best with one line, and never flips back while that one is worked', () => {
	// The Valley loop (14.2 a lap, ore grows back over 600 s) and the full Durotar loop; a level 8 orc on the Valley.
	const out = engine([VALLEY, DUROTAR], { level: 8, at: [1411, 45.8, 66.6], race: 'Orc' }, `
local r = { first = view() }
-- Mining on the Valley's track: 10 ore, then 6 more within a minute (16 of its 14.2 a lap gone).
w.addItem(2770, 10); stub.advance(0.6)
w.moveTo(1411, 45.7, 68.5); w.addItem(2770, 6); stub.advance(0.6)
stub.advance(0.6)
r.out = view()
-- Over at the Durotar loop, mining there; the Valley grows back for 300 s (half way): no flip.
w.moveTo(1411, 55, 30); stub.advance(0.6)
w.addItem(2770, 3); stub.advance(0.6)
stub.advance(300)
r.later = view()
emit(r)`);
	assert.equal(out.first.lap, 6, 'the Valley loop first');
	assert.equal(out.out.lap, 7, 'mined out: the Durotar loop (400 s)');
	assert.equal(out.out.out, 1411);
	assert.match(out.out.line, /^The Durotar loop is mined out for now · next: another loop in Durotar/);
	assert.equal(out.later.lap, 7, 'half grown back, the player on the Durotar loop: it stays');
});
