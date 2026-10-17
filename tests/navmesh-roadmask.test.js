'use strict';
// The walking maps' road columns (tools/lib/nav/roadmask.js) from the roads
// layer's raw weights: hysteresis along a road's blended edges, and gaps in
// its texture bridged over ground our grid walks, on synthetic tiles built by
// the real grid build.

const test = require('node:test');
const assert = require('node:assert/strict');
const { Scene, ADT } = require('./helpers/navscene');
const { tmpdir } = require('./helpers/tmp');
const { buildGrid } = require('../tools/lib/nav/grid/build');
const { openNav } = require('../tools/lib/nav/path');
const { roadMask, STRONG, WEAK } = require('../tools/lib/nav/roadmask');

const CELL = ADT / 256;

async function navOf(scene) {
	const dir = tmpdir('polestar-roadmask-');
	await buildGrid({
		outDir: dir, workers: 0,
		continents: [{ c: 0, name: 'test', tiles: [{ col: scene.col, row: scene.row }] }],
		geometryJob: () => ({ geom: scene.geom() }),
	});
	return openNav({ dir });
}

// A weight buffer with rectangles of columns [i0, i1) x [j0, j1) at weight w.
function weights(...rects) {
	const b = new Uint8Array(256 * 256);
	for (const [i0, i1, j0, j1, w] of rects) for (let j = j0; j < j1; j++) for (let i = i0; i < i1; i++) b[j * 256 + i] = w;
	return b;
}

const maskOf = (w, nav) => roadMask({ c: 0, tiles: ['32_32'], weights: () => w, nav }).get('32_32');
const roadAt = (m, i, j) => m[j * 256 + i] === 1;

test('roadmask: a column is road at STRONG, or at WEAK joined to a STRONG one through WEAK columns', () => {
	const w = weights(
		[100, 104, 20, 200, 200], // the road
		[96, 100, 20, 200, 64], // its blended shoulder
		[150, 156, 50, 60, 100], // a weak patch on its own
		[104, 108, 20, 200, WEAK - 1], // fainter than WEAK
	);
	const m = maskOf(w, null);
	assert.ok(roadAt(m, 101, 50) && STRONG <= 200);
	assert.ok(roadAt(m, 97, 50), 'the shoulder joins the road');
	assert.ok(!roadAt(m, 152, 55), 'a weak patch apart from any road is not road');
	assert.ok(!roadAt(m, 105, 50), 'under WEAK is never road');
});

test('roadmask: a gap in a straight road is bridged over walkable ground, never through a wall, never across a turn or past 100 yd', async () => {
	// Two pieces of a north-south road (columns i 100-105) with a 20-column (42 yd) gap at j 100-120.
	const flat = new Scene();
	const gap = weights([100, 106, 10, 100, 200], [100, 106, 120, 200, 200]);
	const bridged = maskOf(gap, await navOf(flat));
	for (let j = 100; j < 120; j += 4) assert.ok(roadAt(bridged, 102, j) || roadAt(bridged, 103, j), `the gap is road at j ${j}`);
	assert.ok(!roadAt(bridged, 110, 110), 'only a band along the gap');
	// A wall across the gap: our grid cannot walk the straight segment.
	const walled = new Scene();
	walled.box(150, 110 * CELL - 0.5, -1, 280, 110 * CELL + 0.5, 10);
	const blocked = maskOf(gap, await navOf(walled));
	assert.ok(!roadAt(blocked, 102, 110) && !roadAt(blocked, 103, 110), 'not through a wall');
	const nav = await navOf(flat);
	// A road turning: the second piece runs east-west from beside the gap's end.
	const turn = maskOf(weights([100, 106, 10, 100, 200], [110, 200, 115, 121, 200]), nav);
	assert.ok(!roadAt(turn, 103, 110), 'pieces that do not run on towards each other stay apart');
	// Past BRIDGE_YD: a 60-column (125 yd) gap.
	const far = maskOf(weights([100, 106, 10, 80, 200], [100, 106, 140, 220, 200]), nav);
	assert.ok(!roadAt(far, 103, 110), 'a gap over 100 yd stays open');
});

test('roadmask: a gap over a river is never bridged, and no swim surface is road (a road texture under a ford)', async () => {
	const { packNav } = require('../tools/lib/nav/pack');
	const S = require('./helpers/spfnav');
	// Flat ground with a river 6 yd deep across the gap (local y 205-255 yd, columns j 98-122), the road's two pieces
	// either side of it; the road's texture also runs on under the water at columns i 140-145.
	const river = (y) => y > 205 && y < 255;
	const s = new Scene({ height: (x, y) => (river(y) ? -6 : 0) }).water(-1, 205, ADT + 1, 255, 0);
	const dir = tmpdir('polestar-roadmask-river-');
	await buildGrid({ outDir: dir, workers: 0, continents: [{ c: 0, name: 'test', tiles: [{ col: 32, row: 32 }] }], geometryJob: () => ({ geom: s.geom() }) });
	const w = weights([100, 106, 10, 96, 200], [100, 106, 124, 200, 200], [140, 146, 10, 200, 200]);
	const m = maskOf(w, openNav({ dir }));
	assert.ok(!roadAt(m, 102, 110) && !roadAt(m, 103, 110), 'no bridge across the river');
	const files = await packNav({ dir, cells: 128, layers: { roads: () => w } });
	const D = S.loadPack(files, 0);
	const cl = S.decodeCluster(D, 0);
	let water = 0;
	let road = 0;
	for (let n = 0; n < cl.nodes; n++) {
		if (cl.val[n] === 2) {
			water++;
			assert.notEqual(cl.cls[n] & 7, 1, `water node ${n} is not road`);
		} else if (cl.val[n] && (cl.cls[n] & 7) === 1) road++;
	}
	assert.ok(water > 100 && road > 100, `water ${water}, road ${road} nodes`);
});
