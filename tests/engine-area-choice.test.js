'use strict';
// Gathering areas (Core/Engine.lua pickFor, Own.areaEntry, Own.areaTick, Engine.AreaChoices / PickArea / AreaRoam;
// Nav/Nav.lua's arrival inside an outline; docs/GUIDE_FORMAT.md "Gathering areas"; Polestar 0.4.4, Fitz: "areas,
// not circuits"). Which areas a character is offered (safe for their level, a safe trip, a starting area's own only
// while they are new, their own map first), where the arrow leads (the fastest way in: the nearest edge, or a
// flight master or dock inside it), that it rests anywhere inside however the player got there and leaves only a
// little past the edge, the mined-out line (no flip-flop), and the pick kept per character and step.
// Stub world: Mulgore (west), the Barrens (between, 10-25) and Durotar (east) on one continent, 5000 yd each
// (a map percent is 50 yards).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const box = (x1, y1, x2, y2) => `${x1},${y1};${x2},${y1};${x2},${y2};${x1},${y2}`;
const area = (map, name, lvl, poly, extra = '') =>
	`{ map = ${map}, x = 0, y = 0, faction = "H", lvl = { min = ${lvl}, max = ${lvl} }, lap = 300, yield = 10, count = 12, area = "${name}", poly = "${poly}"${extra} }`;
const withMiddle = (s) => {
	// x, y: the middle of the outline's box, as the compilers write it.
	const pts = s.match(/poly = "([^"]+)"/)[1].split(';').map((p) => p.split(',').map(Number));
	const xs = pts.map((p) => p[0]);
	const ys = pts.map((p) => p[1]);
	return s.replace('x = 0, y = 0', `x = ${(Math.min(...xs) + Math.max(...xs)) / 2}, y = ${(Math.min(...ys) + Math.max(...ys)) / 2}`);
};
const RED_CLOUD = withMiddle(area(1412, 'Red Cloud Mesa', 1, box(40, 78, 50, 90), ', starter = true, items = "2770"'));
const SKYWATCH = withMiddle(area(1412, 'Skywatcher Plateau', 1, box(20, 30, 28, 40)));
const VALLEY = withMiddle(area(1411, 'Valley of Trials', 2, box(40, 60, 50, 75), ', starter = true'));
const SKULL = withMiddle(area(1411, 'Skull Rock', 10, box(50, 10, 60, 20)));
const THUNDER = withMiddle(area(1411, 'Thunder Ridge', 10, box(35, 15, 45, 30)));
const RIDGE = withMiddle(area(1411, 'Thunder Ridge', 6, box(36, 16, 42, 24)));
const BARRENS = withMiddle(area(1413, 'The Forgotten Pools', 12, box(45, 30, 55, 40)));

function engine(cands, { level, at, race = 'Tauren' }, script = 'emit(choices())', before = '') {
	return lists(runAddon({
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
Polestar.Set("nav.travel", false)
-- The zones by world position (the walking maps' answer) and their levels.
Polestar.Nav.danger.ZoneAt = function(c, wx, wy) return wy > -5000 and 1412 or wy > -10000 and 1413 or 1411 end
local levels = { [1412] = { 1, 10 }, [1413] = { 10, 25 }, [1411] = { 1, 10 } }
Polestar.Maps.GetZoneLevels = function(id) local l = levels[id]; if l then return l[1], l[2], l[1] end end
Polestar.RegisterGuide({ id = "test/areas", pack = "test", title = "Mining", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ title = "Mine 140 Copper Ore", goals = { { t = "collect", item = 2770, itemName = "Copper Ore", count = 140, gather = { rank = 1, skill = "Mining", skillLine = 186 }, candidates = { ${cands.join(', ')} } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
E = Polestar.Engine
N = Polestar.Nav
local w = stub.world
stub.login()
E.SetGuide("test/areas")
stub.advance(0.6)
-- The list as strings (an empty Lua table reads as an object): names, maps, here, minutes joined by "|".
function choices()
	local v = E.AreaChoices(1, 1)
	local names, maps, here, minutes = {}, {}, {}, {}
	local out = { best = false, safeFrom = v and v.safeFrom or false, out = v and v.out or false, picked = v and v.picked or false }
	for k, e in ipairs(v and v.list or {}) do
		names[k], maps[k], here[k], minutes[k] = e.name, tostring(e.map), tostring(e.here), tostring(e.minutes or "")
		if e.best then out.best = k end
	end
	out.names, out.maps, out.here, out.minutes = table.concat(names, "|"), table.concat(maps, "|"), table.concat(here, "|"), table.concat(minutes, "|")
	return out
end
function arrow()
	local g = E.GetStepView(1).goals[1]
	local roam = E.AreaRoam()
	return { state = N.Sample(), map = g.map or false, x = g.x or false, y = g.y or false, roam = roam and roam.name or false,
		items = roam and roam.items and roam.items[1] or false }
end
${script}`,
	}).emitted[0]);
}

// choices()'s strings as lists.
function lists(o) {
	if (!o || typeof o !== 'object') return o;
	if (typeof o.names === 'string') {
		const split = (s) => (s ? s.split('|') : []);
		return { ...o, names: split(o.names), maps: split(o.maps).map(Number), here: split(o.here).map((x) => x === 'true'), minutes: split(o.minutes).map((x) => (x === '' ? false : Number(x))) };
	}
	return Object.fromEntries(Object.entries(o).map(([k, v]) => [k, lists(v)]));
}

test('a level 3 Tauren on Red Cloud Mesa gets Red Cloud Mesa first, and no Durotar area across the Barrens', () => {
	const out = engine([VALLEY, SKULL, BARRENS, SKYWATCH, RED_CLOUD], { level: 3, at: [1412, 45, 84] });
	assert.equal(out.names[0], 'Red Cloud Mesa');
	assert.equal(out.here[0], true, 'they stand in it');
	assert.equal(out.minutes[0], 0);
	assert.ok(!out.maps.includes(1411), `no Durotar area: ${out.names}`);
	assert.ok(!out.maps.includes(1413), 'nor the Barrens (level 12)');
	assert.deepEqual(out.names, ['Red Cloud Mesa', 'Skywatcher Plateau']);
});

test('a level 26 in Durotar sees several Durotar and Barrens areas, never the Valley of Trials starter', () => {
	const out = engine([VALLEY, SKULL, THUNDER, BARRENS, RED_CLOUD], { level: 26, at: [1411, 44, 68], race: 'Orc' });
	assert.ok(out.names.length >= 3, `${out.names}`);
	assert.notEqual(out.names[0], 'Valley of Trials');
	assert.ok(!out.names.includes('Valley of Trials'), 'a starting area past its band goes while others are left');
	assert.ok(out.names.includes('Skull Rock') && out.names.includes('Thunder Ridge') && out.names.includes('The Forgotten Pools'), `${out.names}`);
	assert.equal(out.best, 1);
});

test('safe level: no area above the character; with none, the level the first opens at', () => {
	const none = engine([SKULL, BARRENS], { level: 5, at: [1411, 44, 68], race: 'Orc' });
	assert.deepEqual(none.names, []);
	assert.equal(none.safeFrom, 10);
	const two = engine([RIDGE, THUNDER], { level: 8, at: [1411, 44, 68], race: 'Orc' });
	assert.deepEqual(two.names, ['Thunder Ridge'], 'the level 6 cut of Thunder Ridge; the level 10 one is not safe yet');
	const both = engine([RIDGE, THUNDER], { level: 12, at: [1411, 44, 68], race: 'Orc' });
	assert.deepEqual(both.names, ['Thunder Ridge'], 'one area of a name: the larger cut once it is safe');
});

test('trip safety: an area only reached through zones well above the character is none of theirs', () => {
	const low = engine([VALLEY], { level: 3, at: [1412, 45, 84] });
	assert.deepEqual(low.names, [], 'the Valley lies 10k yards across creatures of 10 and more');
	const later = engine([VALLEY], { level: 9, at: [1412, 45, 84] });
	assert.deepEqual(later.names, ['Valley of Trials'], 'at 9 the Barrens (from 10) are within reach');
});

test('Guide me leads to the area\'s nearest edge; inside, the arrow rests with the area\'s line', () => {
	const out = engine([RED_CLOUD], { level: 3, at: [1412, 45, 60] }, `
local r = { outside = arrow() }
w.moveTo(1412, 45, 84); stub.advance(0.6)
r.inside = arrow()
emit(r)`);
	assert.equal(out.outside.map, 1412);
	assert.ok(Math.abs(out.outside.x - 45) < 0.5, `straight south to the edge: x ${out.outside.x}`);
	assert.ok(out.outside.y > 78 && out.outside.y < 78.6, `just inside the north edge (78): y ${out.outside.y}`);
	assert.equal(out.outside.roam, false);
	assert.notEqual(out.outside.state, 'arrived');
	assert.equal(out.inside.state, 'arrived', 'the arrow rests');
	assert.equal(out.inside.roam, 'Red Cloud Mesa');
	assert.equal(out.inside.items, 2770, 'the line names what the area gives');
});

test('border hysteresis: out of the area only a little past its edge, in again only inside it', () => {
	const out = engine([RED_CLOUD], { level: 3, at: [1412, 45, 84] }, `
local r = {}
stub.advance(0.6)
w.moveTo(1412, 45, 77.8); stub.advance(0.6) -- 10 yards north of the edge
r.near = arrow()
w.moveTo(1412, 45, 77.0); stub.advance(0.6) -- 50 yards out
r.out = arrow()
w.moveTo(1412, 45, 77.8); stub.advance(0.6) -- back to 10 yards out: still out
r.back = arrow()
w.moveTo(1412, 45, 78.4); stub.advance(0.6) -- inside again
r.inside = arrow()
emit(r)`);
	assert.equal(out.near.state, 'arrived', '10 yards past the edge: still in it');
	assert.equal(out.near.roam, 'Red Cloud Mesa');
	assert.notEqual(out.out.state, 'arrived');
	assert.equal(out.out.roam, false);
	assert.notEqual(out.back.state, 'arrived', 'coming back, the edge itself is the way in');
	assert.equal(out.inside.state, 'arrived');
});

test('already inside when Guide me is pressed, or landed inside by a zeppelin: the arrow rests at once', () => {
	const out = engine([SKYWATCH, RED_CLOUD], { level: 3, at: [1413, 50, 50] }, `
local r = {}
E.PickArea(1, 1, 2) -- Red Cloud Mesa, from the Barrens
stub.advance(0.6)
r.away = arrow()
w.moveTo(1412, 45, 84) -- the landing: no walk in between
stub.advance(0.6)
r.landed = arrow()
E.PickArea(1, 1, 2) -- Guide me again while inside
stub.advance(0.1)
r.again = arrow()
emit(r)`);
	assert.notEqual(out.away.state, 'arrived');
	assert.equal(out.landed.state, 'arrived');
	assert.equal(out.landed.roam, 'Red Cloud Mesa');
	assert.equal(out.again.state, 'arrived');
});

test('a flight master inside the area that gets there sooner than the walk: the arrow leads to it', () => {
	const out = engine([RED_CLOUD], { level: 3, at: [1412, 45, 20] }, `
local C = Polestar.Compat
local _, fx, fy = C.MapToWorld(1412, 47, 86)
N.AreaLandings = function() return { { wx = fx, wy = fy } } end
Polestar.Nav.EstimateTravel = function(from, to)
	if math.abs(to.x - 47) < 0.2 and math.abs(to.y - 86) < 0.2 then return 60 end -- a flight
	return 600 -- the walk
end
E.PickArea(1, 1, 1)
stub.advance(0.6)
emit(arrow())`);
	assert.ok(Math.abs(out.x - 47) < 0.2 && Math.abs(out.y - 86) < 0.2, `the flight master: ${out.x},${out.y}`);
});

test('mined out: nothing gathered inside for a while offers the next area once, and it never flips back by itself', () => {
	const out = engine([SKYWATCH, RED_CLOUD], { level: 3, at: [1412, 45, 84] }, `
local r = { first = choices() }
w.addItem(2770, 2); stub.advance(0.6) -- mining
stub.advance(120); r.busy = choices()
stub.advance(120); r.out = choices()
stub.advance(600); r.still = choices()
w.addItem(2770, 1); stub.advance(0.6) -- a node grew back
r.back = choices()
emit(r)`);
	assert.equal(out.first.names[0], 'Red Cloud Mesa');
	assert.equal(out.busy.out, false, 'two minutes after the last gather: not yet');
	assert.deepEqual(out.out.out && [out.out.out.name, out.out.out.next], ['Red Cloud Mesa', 'Skywatcher Plateau']);
	assert.equal(out.out.out.i, 1, 'its Guide me picks Skywatcher Plateau');
	assert.equal(out.still.names[0], 'Red Cloud Mesa', 'the arrow stays: the line offers, the player picks');
	assert.ok(out.still.out, 'the line holds');
	assert.equal(out.back.out, false, 'a gather there takes it back');
});

test('the player\'s pick holds over a level-up and a reload of the guide, and goes once it is no longer safe', () => {
	const out = engine([SKYWATCH, RED_CLOUD, RIDGE], { level: 8, at: [1412, 45, 84] }, `
local r = {}
E.PickArea(1, 1, 1) -- Skywatcher Plateau
stub.advance(0.6)
r.picked = choices()
w.setLevel(9); stub.advance(0.6)
r.level = choices()
E.SetGuide(nil); stub.advance(0.1); E.SetGuide("test/areas"); stub.advance(0.6)
r.reload = choices()
r.saved = Polestar.CharState().areaPicks["test/areas#1#1"].area
emit(r)`);
	assert.equal(out.picked.names[0], 'Skywatcher Plateau');
	assert.equal(out.picked.picked, 1);
	assert.equal(out.level.names[0], 'Skywatcher Plateau', 'a level-up keeps it');
	assert.equal(out.reload.names[0], 'Skywatcher Plateau', 'a reload of the guide keeps it');
	assert.equal(out.saved, 'Skywatcher Plateau');
});
