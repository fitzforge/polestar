'use strict';
// `nav city` (tools/lib/nav/city): the trail layer's tile strings (trails.js) read back by the router's
// Path.TrailFloor (Routing/Path.lua) through nav eval's harness, on a synthetic map folder.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { tmpdir } = require('./helpers/tmp');
const { CellGrid, buildHpa, encodeMaps, packFiles } = require('../tools/lib/nav/pack');
const { trailsLua } = require('../tools/lib/nav/city/trails');

const lua = ['luajit', 'lua5.1'].find((b) => spawnSync(b, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' }).status === 0);
const noLua = lua ? false : 'no luajit or lua5.1';
const T = 1600 / 3;
const CELL = T / 128;

// A one-cluster map 0 (the router needs a map to load) and the given trail layer.
function folder(doc) {
	const cg = new CellGrid({ C: 16, NX: 1, NY: 1, CX0: 0, CY0: 0 });
	cg.cluster(0).val.fill(1);
	cg.finish();
	const { files } = packFiles({ map: 0, cg, maps: encodeMaps(cg, buildHpa(cg)), global: 'PolestarPathData', gen: '-- nav-city test map' });
	const dir = tmpdir('polestar-city-');
	fs.mkdirSync(path.join(dir, 'Nav'));
	for (const [name, text] of files) fs.writeFileSync(path.join(dir, 'Nav', name), text);
	fs.writeFileSync(path.join(dir, 'Nav', 'Nav.xml'), `<Ui>\n${files.map(([name]) => `\t<Script file="${name}"/>`).join('\n')}\n</Ui>\n`);
	fs.mkdirSync(path.join(dir, 'Trails'));
	fs.writeFileSync(path.join(dir, 'Trails', 'Trails.lua'), trailsLua(doc, '-- nav-city test trails'));
	return dir;
}

// The world point at the centre of trail cell (i, j) of tile col_row.
const at = (col, row, i, j) => [(32 - row) * T - (j + 0.5) * CELL, (32 - col) * T - (i + 0.5) * CELL];

function floors(dir, queries) {
	const { runQueries } = require('../tools/lib/nav/eval/run');
	return runQueries({ navDir: dir, lua, queries: queries.map((q, n) => ({ type: 'trailfloor', id: `q${n}`, map: 0, reach: 4, near: null, ...q })) }).results.map((r) => [r.z, r.weight]);
}

test('trail floor: the heaviest level within reach, near filters by height, nothing far away or on a map without trails', { skip: noLua }, () => {
	const doc = {
		format: 1, k: 3, cells: 128,
		maps: { 0: {
			'31_31': [[10, 20, 501.5, 3], [10, 20, 770.25, 1], [11, 20, 498.75, 1], [127, 5, -41.5, 2]],
			'32_31': [[0, 5, 55.25, 1]],
		} },
	};
	const dir = folder(doc);
	const [here, nearTop, beside, far, edge, other] = floors(dir, [
		{ at: at(31, 31, 10, 20) },
		{ at: at(31, 31, 10, 20), near: 765 },
		{ at: at(31, 31, 11, 20) },
		{ at: at(31, 31, 40, 40) },
		{ at: at(32, 31, 0, 5) },
		{ at: at(31, 31, 10, 20), map: 1 },
	]);
	assert.deepEqual(here, [501.5, 3], 'the most-walked level of the cell, not the mountain over it');
	assert.deepEqual(nearTop, [770.25, 1], 'near keeps the levels within 10 yd of it');
	assert.deepEqual(beside, [501.5, 3], 'reach 4 sees the heavier level of the next cell over');
	assert.deepEqual(far, [null, null], 'none within reach');
	assert.deepEqual(edge, [-41.5, 2], "across a tile edge: the last cell of the tile west outweighs this one's");
	assert.deepEqual(other, [null, null], 'a map without a trail layer');
});

test('trail tiles: negative heights, many levels and long cell gaps round-trip through the varint strings', { skip: noLua }, () => {
	const list = [];
	for (let n = 0; n < 300; n++) list.push([(n * 37) % 128, Math.floor(n / 3), -600 + n * 7.25, 1 + (n % 3)]);
	list.sort((a, b) => a[1] - b[1] || a[0] - b[0] || a[2] - b[2]);
	const dir = folder({ format: 1, k: 3, cells: 128, maps: { 0: { '30_30': list } } });
	const sample = list.filter((_, n) => n % 29 === 0);
	const got = floors(dir, sample.map(([i, j, z]) => ({ at: at(30, 30, i, j), reach: 0.5, near: z })));
	sample.forEach(([, , z, w], n) => assert.deepEqual(got[n], [z, w], `entry ${n}`));
});

test("the city gate's ends: a landing on the flight master's floor, an NPC the match had no height for on the NPC's", () => {
	const { anchorEnds } = require('../tools/lib/nav/city/gate');
	const g = { colIndex: () => 0, colNodes: () => [0, 1, 2, 3], nz: [39.5, 61.4, 95, -85.1] };
	const taxi = [{ c: 1, wx: 1677.5, wy: -4315.7, npc: 3310 }];
	const npcZ = (npc) => ({ 3310: 61.7, 270038: -85.1 })[npc] ?? null;
	const B = { kind: 'vendor', wx: 1690, wy: -4400, z: 39.5, node: 0, npc: 3322, anchored: true };
	const trip = { c: 1, A: { kind: 'land', wx: 1677.5, wy: -4315.7, z: 39.5, node: 0 }, B };
	const moved = anchorEnds(g, trip, taxi, npcZ);
	assert.deepEqual(moved.A, { ...trip.A, z: 61.4, node: 1, was: 39.5 });
	assert.equal(moved.B, B, 'an anchored end stays');
	assert.equal(anchorEnds(g, { ...trip, A: { ...trip.A, wx: 1900 } }, taxi, npcZ).A.z, 39.5, 'no flight master within 40 yd');
	const lab = { ...B, npc: 270038, anchored: false };
	assert.deepEqual(anchorEnds(g, { ...trip, B: lab }, taxi, npcZ).B, { ...lab, z: -85.1, node: 3, was: 39.5 });
	assert.equal(anchorEnds(g, { ...trip, B: { ...lab, npc: 1 } }, taxi, npcZ).B.z, 39.5, 'no height known');
});

test("the city gate's judge: a long straight line follows the ground between its points, not its chord; a step no surface walks stays judged on the chord", () => {
	const { judge } = require('../tools/lib/nav/city/gate');
	// one row of 2.08 yd columns, one walked (3+ people) surface each: ground(x) its height
	const area = (ground) => {
		const W = 60;
		const nz = Array.from({ length: W }, (_, i) => ground((i + 0.5) * 2.08));
		const g = { W, H: 1, nz, nflags: new Uint8Array(W), ncol: nz.map((_, i) => i), colIndex: (x) => (x >= 0 && x < W * 2.08 ? Math.floor(x / 2.08) : -1), colNodes: (ci) => [ci], search: () => {}, d: () => 0 };
		const people = new Uint16Array(W).fill(5);
		return judge({ g, people, train: people });
	};
	// a slope that bends (down 0.8 yd a yard to 60 yd, then flat): the chord from 120 to 72 runs up to 19 yd over the
	// ground, which the chord alone judged void
	const bend = area((x) => (x < 60 ? 120 - 0.8 * x : 72));
	const m = bend.measure([[1, 0, 119.2], [120, 0, 72]]);
	assert.deepEqual([m.void, m.wrongFloor], [0, 0], `followed: ${JSON.stringify(m)}`);
	// a 20 yd step half way: no surface walks down it, so the samples followed from each end never meet, and the line
	// is judged on its chord there
	const step = area((x) => (x < 60 ? 80 : 60));
	assert.ok(step.measure([[1, 0, 80], [120, 0, 60]]).void > 20, 'the step: void on the chord');
});
