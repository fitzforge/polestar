'use strict';
// The node router's cost model (tools/lib/nav/edgecost.js) through router.js over synthetic
// tiles built by the real build (grid/build.js): roads, hostile hubs (also on the coarse graph:
// the walk graphs router.js prepare builds per faction), and ends settled out of a pocket.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { Scene } = require('./helpers/navscene');
const { tmpdir } = require('./helpers/tmp');
const { buildGrid } = require('../tools/lib/nav/grid/build');
const { CELL, FLAG } = require('../tools/lib/nav/grid/format');
const Costs = require('../tools/lib/nav/costs');
const { open, prepare } = require('../tools/lib/nav/router');
const { edgeCost, stepMult, ROAD, HUB, SWIM } = require('../tools/lib/nav/edgecost');

async function gridOf(...scenes) {
	const dir = tmpdir('polestar-router-');
	const byKey = new Map(scenes.map((s) => [`${s.col}_${s.row}`, s]));
	await buildGrid({
		outDir: dir, workers: 0,
		continents: [{ c: 0, name: 'test', tiles: scenes.map((s) => ({ col: s.col, row: s.row })) }],
		geometryJob: (c, t) => ({ geom: byKey.get(`${t.col}_${t.row}`).geom() }),
	});
	return dir;
}

// A roads layer (layers/roads.js's files) painting every column of scene s within `half` yd of the
// polyline pts (local [x, y] pairs) at full weight.
function roadsLayer(s, pts, half = 4) {
	const dir = tmpdir('polestar-roads-');
	const w = Buffer.alloc(256 * 256);
	for (let j = 0; j < 256; j++) {
		for (let i = 0; i < 256; i++) {
			const x = (i + 0.5) * CELL;
			const y = (j + 0.5) * CELL;
			for (let q = 1; q < pts.length; q++) {
				const [ax, ay] = pts[q - 1];
				const [bx, by] = pts[q];
				const L2 = (bx - ax) ** 2 + (by - ay) ** 2;
				const f = Math.max(0, Math.min(1, ((x - ax) * (bx - ax) + (y - ay) * (by - ay)) / L2));
				if (Math.hypot(ax + (bx - ax) * f - x, ay + (by - ay) * f - y) <= half) w[j * 256 + i] = 255;
			}
		}
	}
	fs.mkdirSync(path.join(dir, '0'), { recursive: true });
	fs.writeFileSync(path.join(dir, '0', `${s.col}_${s.row}.bin`), w);
	fs.writeFileSync(path.join(dir, 'index.json'), JSON.stringify({ continents: { 0: [`${s.col}_${s.row}`] } }));
	return dir;
}

const NO_ROADS = path.join(__dirname, 'no-roads-layer'); // no index.json there: no road anywhere

// The local (x, y) of a route's drawn points in scene s.
const localPts = (s, r) => {
	const out = [];
	for (let p = 0; p < r.pts.length; p += 3) out.push([s.west - r.pts[p + 1], s.north - r.pts[p]]);
	return out;
};

test('edgeCost: seconds times road, swim (never a road), hostile hub (only the other side\'s) and zone danger', () => {
	const road = Costs.CLASS.ROAD;
	assert.equal(stepMult(road, FLAG.TERRAIN, null), ROAD);
	assert.equal(stepMult(road, FLAG.TERRAIN | FLAG.SWIM, null), SWIM, 'a road under water is swum, no road');
	assert.ok(Math.abs(SWIM * (7 / 4.722222) - 3) < 1e-6, 'a swum yard costs 3 run yards in all, as the maps\' swim factor');
	assert.equal(stepMult(Costs.HUB_ALLIANCE, FLAG.TERRAIN, 'Horde'), HUB);
	assert.equal(stepMult(Costs.HUB_ALLIANCE, FLAG.TERRAIN, 'Alliance'), 1, 'one\'s own hub costs nothing more');
	assert.equal(stepMult(Costs.HUB_ALLIANCE, FLAG.TERRAIN, null), 1, 'no faction, no hostile hub');
	assert.equal(stepMult(road | Costs.HUB_HORDE, FLAG.TERRAIN, 'Alliance'), ROAD * HUB);
	assert.equal(edgeCost({ seconds: 2, cls: road, flags: FLAG.TERRAIN, zone: 40 }, { faction: 'Horde', danger: { 40: 3 } }), 2 * ROAD * 3);
	assert.equal(edgeCost({ seconds: 2, cls: 0, flags: FLAG.TERRAIN, zone: 12 }, { faction: null, danger: { 40: 3 } }), 2);
});

test('roads: a walk takes a road up to 1.25 times the straight way (Costs.lua Balanced 0.8), not a longer one', async () => {
	const s = new Scene();
	const dir = await gridOf(s);
	const a = s.world(100, 300);
	const b = s.world(400, 300);
	// A road bent over (250, 260): 310 yd against the straight 300.
	const near = roadsLayer(s, [[100, 300], [250, 260], [400, 300]]);
	await prepare(dir, [0], { workers: 1, hubs: null, roadsDir: near });
	const onRoad = open(dir, { hubs: null, roadsDir: near, fingerprint: false }).route(a, b, { faction: null });
	assert.ok(onRoad.ok, onRoad.reason);
	const north = Math.min(...localPts(s, onRoad).map(([, y]) => y));
	assert.ok(north < 268, `the walk follows the road over y 260 (reaches y ${north.toFixed(1)})`);
	// Without the road layer: straight.
	await prepare(dir, [0], { workers: 1, hubs: null, roadsDir: NO_ROADS });
	const plain = open(dir, { hubs: null, roadsDir: NO_ROADS, fingerprint: false }).route(a, b, { faction: null });
	assert.ok(Math.min(...localPts(s, plain).map(([, y]) => y)) > 295, 'no road, the straight way');
	// A road bent over (250, 140): 439 yd, over 1.25 times the straight way, so not taken.
	const far = roadsLayer(s, [[100, 300], [250, 140], [400, 300]]);
	await prepare(dir, [0], { workers: 1, hubs: null, roadsDir: far });
	const offRoad = open(dir, { hubs: null, roadsDir: far, fingerprint: false }).route(a, b, { faction: null });
	assert.ok(offRoad.ok, offRoad.reason);
	assert.ok(Math.min(...localPts(s, offRoad).map(([, y]) => y)) > 250, 'the long road is left');
});

test('swimming: a walk crosses a river by a bridge a little way off rather than swim it (Nav<map>.lua swim 3)', async () => {
	// A channel 30 yd wide and 3 deep at y 250-280, water at 0; a plank bridge 10 yd wide at x 140-150.
	const s = new Scene({ height: (x, y) => (y > 250 && y < 280 ? -3 : 0) });
	s.water(0, 246, 533, 284, 0);
	s.floor(140, 244, 150, 286, 0.4, 1);
	const dir = await gridOf(s);
	await prepare(dir, [0], { workers: 1, hubs: null, roadsDir: NO_ROADS });
	const r = open(dir, { hubs: null, roadsDir: NO_ROADS, fingerprint: false });
	const walk = r.route(s.world(100, 200), s.world(100, 330), { faction: null });
	assert.ok(walk.ok, walk.reason);
	assert.ok(!walk.byClass.swim, `no swim (${(walk.byClass.swim || 0).toFixed(1)} s)`);
	assert.ok(Math.max(...localPts(s, walk).map(([x]) => x)) > 138, 'over the bridge');
});

test('hostile hubs: a Horde walk goes round an Alliance hub, across tiles too (its walk graph), and reports one it enters', async () => {
	const tiles = [32, 33, 34].map((col) => new Scene({ col }));
	const dir = await gridOf(...tiles);
	// An Alliance hub in the middle tile, on the straight way from the first tile to the third.
	const centre = tiles[1].world(266, 266);
	const hubs = { 0: [{ id: 1, side: 'Alliance', name: 'Testhold', areaId: 9, disks: [[centre.wx, centre.wy, 80]] }] };
	await prepare(dir, [0], { workers: 1, hubs, roadsDir: NO_ROADS });
	const r = open(dir, { hubs, roadsDir: NO_ROADS, fingerprint: false });
	const a = tiles[0].world(266, 266);
	const b = tiles[2].world(266, 266);
	// The drawn line's nearest approach to the hub's centre.
	const nearest = (walk) => {
		let d = Infinity;
		for (let p = 3; p < walk.pts.length; p += 3) {
			const [ax, ay, bx, by] = [walk.pts[p - 3], walk.pts[p - 2], walk.pts[p], walk.pts[p + 1]];
			const L2 = (bx - ax) ** 2 + (by - ay) ** 2;
			const f = L2 > 0 ? Math.max(0, Math.min(1, ((centre.wx - ax) * (bx - ax) + (centre.wy - ay) * (by - ay)) / L2)) : 0;
			d = Math.min(d, Math.hypot(ax + (bx - ax) * f - centre.wx, ay + (by - ay) * f - centre.wy));
		}
		return d;
	};
	const horde = r.route(a, b, { faction: 'Horde' });
	assert.ok(horde.ok, horde.reason);
	assert.ok(nearest(horde) > 80, `the Horde walk keeps out of the hub (comes within ${nearest(horde).toFixed(1)} yd of its centre)`);
	assert.deepEqual(horde.hubs, []);
	const alliance = r.route(a, b, { faction: 'Alliance' });
	assert.ok(nearest(alliance) < 10, 'its own side walks through it');
	const none = r.route(a, b, { faction: null });
	assert.ok(nearest(none) < 10, 'no faction walks through it');
	// The coarse graph alone (routeMany's search) prices the Horde way round too.
	const many = r.routeMany(a, [b], { faction: 'Horde' });
	const plain = r.routeMany(a, [b], { faction: null });
	assert.ok(many.yards[0] > plain.yards[0] + 20, `the Horde's coarse way is the long one (${many.yards[0].toFixed(0)} against ${plain.yards[0].toFixed(0)} yd)`);
	// A walk into the hub enters it and names it, as Routing/Path.lua's job.hubs.
	const into = r.route(a, centre, { faction: 'Horde' });
	assert.ok(into.ok, into.reason);
	assert.deepEqual(into.hubs, [{ id: 1, name: 'Testhold', areaId: 9 }]);
});

test('settled ends: a goal on a plateau one only falls from is walked to its foot (Routing/Path.lua settle)', async () => {
	// A model plateau (top 20), sheer on every side, ground below.
	const s = new Scene();
	s.box(50, 50, -1, 150, 150, 20);
	const dir = await gridOf(s);
	await prepare(dir, [0], { workers: 1, hubs: null, roadsDir: NO_ROADS });
	const r = open(dir, { hubs: null, roadsDir: NO_ROADS, fingerprint: false });
	const top = s.world(140, 100, 20);
	const ground = s.world(400, 100);
	const up = r.route(ground, top, { faction: null });
	assert.ok(up.ok, up.reason);
	assert.equal(up.settled, 'to');
	const n = up.pts.length;
	const leg = Math.hypot(up.pts[n - 3] - top.wx, up.pts[n - 2] - top.wy);
	assert.ok(leg < 25, `ends ${leg.toFixed(1)} yd from the goal, at the plateau's foot`);
	assert.ok(up.pts[n - 1] < 5, 'on the ground');
	const many = r.routeMany(ground, [top], { faction: null });
	assert.ok(many.yards[0] > 0 && many.yards[0] < up.yards + 30, `routeMany settles the same goal (${many.yards[0].toFixed(0)} yd)`);
});

test('zone danger on the coarse graph: a band walk goes round a dangerous strip its coarse edges cross between safe ends (the zone mix)', async (t) => {
	// Two rows of three tiles; in the middle tile of the north row a strip of chunks (x 167-233 yd, every
	// y) is another zone. The straight way east crosses it; round it is the south row.
	const STRIP = 40;
	const REST = 12;
	const tiles = [];
	for (const row of [32, 33]) for (const col of [32, 33, 34]) tiles.push(new Scene({ col, row, areas: col === 33 && row === 32 ? (x) => (x > 166 && x < 234 ? STRIP : REST) : () => REST }));
	const dir = await gridOf(...tiles);
	const r = open(dir, { hubs: null, roadsDir: NO_ROADS, fingerprint: false });
	const mid = tiles[1];
	const zStrip = r.zoneAt(0, mid.world(200, 266).wx, mid.world(200, 266).wy);
	const zRest = r.zoneAt(0, mid.world(400, 266).wx, mid.world(400, 266).wy);
	if (!zStrip || zStrip === zRest) return t.skip('no AreaTable to tell the strip\'s zone from the rest');
	await prepare(dir, [0], { workers: 1, hubs: null, roadsDir: NO_ROADS });
	const danger = { [zStrip]: 20 };
	const a = tiles[0].world(266, 266);
	const b = tiles[2].world(266, 266);
	const walk = r.route(a, b, { faction: null, danger });
	assert.ok(walk.ok, walk.reason);
	let inStrip = 0;
	for (let p = 3; p < walk.pts.length; p += 3) {
		const n = Math.ceil(Math.hypot(walk.pts[p] - walk.pts[p - 3], walk.pts[p + 1] - walk.pts[p - 2]) / 2);
		for (let k = 0; k < n; k++) {
			const f = (k + 0.5) / n;
			if (r.zoneAt(0, walk.pts[p - 3] + (walk.pts[p] - walk.pts[p - 3]) * f, walk.pts[p - 2] + (walk.pts[p + 1] - walk.pts[p - 2]) * f) === zStrip) inStrip += 2;
		}
	}
	assert.ok(inStrip <= 4, `the walk goes round the strip (${inStrip} yd in it)`);
	// The coarse search alone prices the strip too: its cost is never below the drawn walk's.
	const many = r.routeMany(a, [b], { faction: null, danger });
	assert.ok(many.costs[0] >= walk.cost * 0.95, `coarse cost ${many.costs[0].toFixed(0)} against the walk's ${walk.cost.toFixed(0)}`);
});

test('distanceTable and distanceRows: every source to every target as routeMany answers it, with cells; metricKey names the weights', async () => {
	const tiles = [32, 33].map((col) => new Scene({ col }));
	tiles[0].box(250, 0, -1, 254, 450, 15);
	const dir = await gridOf(...tiles);
	await prepare(dir, [0], { workers: 1, hubs: null, roadsDir: NO_ROADS });
	const r = open(dir, { hubs: null, roadsDir: NO_ROADS, fingerprint: false });
	const S = [tiles[0].world(100, 100), tiles[1].world(300, 300)];
	const T = [tiles[1].world(100, 100), tiles[0].world(400, 100), tiles[0].world(100, 100)];
	const t = r.distanceTable(S, T, { faction: null }, { cells: true });
	for (let i = 0; i < S.length; i++) {
		const m = r.routeMany(S[i], T, { faction: null }, { cells: true });
		for (let j = 0; j < T.length; j++) {
			const k = i * T.length + j;
			assert.equal(t.costs[k], m.costs[j]);
			assert.equal(t.yards[k], m.yards[j]);
			assert.ok(Math.abs(t.seconds[k] * 7 - t.costs[k]) < 1e-9);
			assert.deepEqual(t.cells[k], m.cells[j]);
		}
	}
	assert.ok(t.yards[1] > 300, 'round the wall');
	const rows = r.distanceRows(S.map((source) => ({ source, targets: T })), { faction: null }, { cells: true });
	rows.forEach((row, i) => {
		assert.deepEqual(Array.from(row.costs), Array.from(t.costs.subarray(i * T.length, (i + 1) * T.length)));
		assert.deepEqual(Array.from(row.yards), Array.from(t.yards.subarray(i * T.length, (i + 1) * T.length)));
		assert.deepEqual(row.cells, t.cells.slice(i * T.length, (i + 1) * T.length));
	});
	assert.equal(r.backend, 'js');
	assert.notEqual(r.metricKey({ faction: 'Horde' }), r.metricKey({ faction: 'Alliance' }));
	assert.notEqual(r.metricKey({ faction: null }), r.metricKey({ faction: null, danger: { 12: 3 } }));
	assert.equal(r.metricKey({ faction: null, danger: { 12: 3, 4: 20 } }), r.metricKey({ faction: null, danger: { 4: 20, 12: 3 } }));
});
