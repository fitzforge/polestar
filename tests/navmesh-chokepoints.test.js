'use strict';
// Chokepoints for the journey's walk steps (tools/lib/nav/chokepoints.js) on
// a synthetic tile built by the real grid build: a bridge over a river, a
// gate through a wall, a lift; names and the Lua table. Ids in test names
// are rows of docs/superpowers/specs/2026-10-15-spf-issues.md.

const test = require('node:test');
const assert = require('node:assert/strict');
const { Scene, ADT } = require('./helpers/navscene');
const { tmpdir } = require('./helpers/tmp');
const { buildGrid } = require('../tools/lib/nav/grid/build');
const { openNav } = require('../tools/lib/nav/path');
const { chokepoints, chokepointsLua, areaNames, gridChokepoints } = require('../tools/lib/nav/chokepoints');
const { cellOf } = require('../tools/lib/nav/grid/format');

const areas = areaNames([
	{ ID: '1', AreaName_lang: 'Test Vale', ParentAreaID: '0' },
	{ ID: '2', AreaName_lang: 'Riverwatch', ParentAreaID: '1' },
]);

async function scene() {
	// A river (x 200..300, bed 6 yd down) under a 10 yd wide bridge at y 240..250; a 4 yd thick wall
	// along x = 400 with a 12 yd arched gate at y 250..262. The east chunks are Riverwatch, a subzone.
	const s = new Scene({ height: (x) => (x > 200 && x < 300 ? -6 : 0) });
	s.water(200, 0, 300, ADT, 0, 1);
	s.box(190, 240, 0.5, 310, 250, 1, 1);
	s.box(398, -1, -1, 402, 250, 10).box(398, 262, -1, 402, ADT + 1, 10).box(398, 250, 4, 402, 262, 10);
	const geom = s.geom();
	for (let cy = 0; cy < 16; cy++) for (let cx = 0; cx < 16; cx++) geom.areas[cy * 16 + cx] = cx >= 12 ? 2 : 1;
	const dir = tmpdir('polestar-choke-');
	await buildGrid({ outDir: dir, workers: 0, continents: [{ c: 0, name: 'test', tiles: [{ col: 32, row: 32 }] }], geometryJob: () => ({ geom }) });
	return { s, nav: openNav({ dir }) };
}

test('chokepoints: a bridge over a river and a gate through a wall, from the grid; lift landings top and bottom (K1, K4)', async () => {
	const { s, nav } = await scene();
	const lift = (x, y, z) => {
		const w = s.world(x, y);
		const p = cellOf(w.wx, w.wy);
		return { col: p.col, row: p.row, k: p.j * 256 + p.i, entry: 0, z };
	};
	const lifts = [{ name: 'Test Lift', id: 7, a: lift(100, 100, 0), b: lift(100, 104, 40), h: 40 }];
	const list = chokepoints({ nav, c: 0, aids: null, lifts, geo: null, areas });
	const near = (kind, x, y, tol) => list.filter((e) => e.kind === kind && Math.hypot(e.wx - s.world(x, y).wx, e.wy - s.world(x, y).wy) <= tol);
	const bridge = near('bridge', 250, 245, 15);
	assert.equal(bridge.length, 1, `one bridge over the river: ${JSON.stringify(list.map((e) => [e.kind, e.wx, e.wy]))}`);
	assert.equal(bridge[0].sides.length, 2, 'its two ends');
	assert.ok(bridge[0].r >= 6);
	// Gates come from the grid's rule; the list keeps them only where an aids passage is (none here).
	const place = (wx, wy) => {
		const p = cellOf(wx, wy);
		return areas(nav.tile(0, p.col, p.row).areas[(p.j >> 4) * 16 + (p.i >> 4)]);
	};
	const gates = gridChokepoints(nav, 0, place).filter((e) => e.kind === 'gate');
	const w = s.world(400, 256);
	assert.equal(gates.length, 1, 'one gate through the wall, none along the plain wall');
	assert.ok(Math.hypot(gates[0].wx - w.wx, gates[0].wy - w.wy) <= 15);
	assert.deepEqual(gates[0].sides.map((x) => x.area).sort(), ['Riverwatch', 'Test Vale'], 'in from the vale, out into the subzone');
	assert.equal(list.filter((e) => e.kind === 'gate').length, 0, 'no gate without a passage of the aids');
	const landings = list.filter((e) => e.kind === 'lift');
	assert.equal(landings.length, 2);
	const bottom = landings.find((e) => e.liftEnd === 'bottom');
	const top = landings.find((e) => e.liftEnd === 'top');
	assert.ok(bottom && top && bottom.lift === 'Test Lift');
	assert.equal(list[bottom.pair], top, 'each landing names the other');
	for (const e of list) {
		assert.ok(e.name && e.zone, `a name and a zone for every ${e.kind} (K1)`);
		assert.equal(e.zone, 'Test Vale');
	}
	const lua = chokepointsLua({ 0: list }, 'test');
	assert.match(lua, /^PolestarNavChokepoints = PolestarNavChokepoints or \{\}$/m);
	assert.match(lua, /kind = "bridge", name = "Test Vale", area = \d+, zone = "Test Vale", zoneArea = \d+, sides = \{ \{ wx = /);
	assert.match(lua, new RegExp(`liftEnd = "bottom", pair = ${list.indexOf(top) + 1}`), 'pair is a 1-based Lua index');
});
