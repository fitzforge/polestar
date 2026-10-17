'use strict';
// The navigation grid's rules (tools/lib/nav/grid; docs/ARCHITECTURE.md,
// "Navigation grid") on
// synthetic triangle soups: slopes, steps and jumps, falls, liquids, doors,
// components, and the tile file format.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const { Scene } = require('./helpers/navscene');
const { rasterise } = require('../tools/lib/nav/grid/rasterise');
const { buildSurfaces } = require('../tools/lib/nav/grid/surfaces');
const { linkTile, fallTarget } = require('../tools/lib/nav/grid/links');
const { localComponents } = require('../tools/lib/nav/grid/regions');
const { Space, inLinks, IN, isOpen } = require('../tools/lib/nav/grid/search');
const { profileFor } = require('../tools/lib/nav/move');
const { CELL, FLAG, CLS, LINK_SLOPE, NO_LINK, NO_COMP, FALL_MAX, VERSION, encodeTile, decodeTile } = require('../tools/lib/nav/grid/format');

const TAN = (deg) => Math.tan((deg * Math.PI) / 180);
const E = 0; // direction east (format.js DIRS)
const W = 4;

function linked(scene) {
	const g = scene.geom();
	const { tile } = buildSurfaces(rasterise(g, g), g);
	const around = Array(9).fill(null);
	around[4] = tile;
	Object.assign(tile, linkTile(around));
	Object.assign(tile, localComponents(tile));
	return tile;
}

// The entries of the column under local (x, y): [{ e, z, flags }].
function column(t, x, y) {
	const k = Math.floor(y / CELL) * 256 + Math.floor(x / CELL);
	const out = [];
	for (let e = t.first[k]; e < t.first[k + 1]; e++) out.push({ e, k, z: t.z[e], flags: t.flags[e] });
	return out;
}
const top = (t, x, y) => column(t, x, y).filter((s) => !(s.flags & FLAG.BLOCKED)).pop();
// The walkable top nearest x = from going west at height about z (a cliff's edge).
const edgeWest = (t, from, y, z) => {
	for (let x = from; x > from - 20; x -= CELL) {
		const s = top(t, x, y);
		if (s && Math.abs(s.z - z) < 1) return s;
	}
	return null;
};
const linkOf = (t, e, d) => t.links[e * 8 + d];
const falls = (t, e) => {
	const out = [];
	for (let f = 0; f < t.fallFrom.length; f++) if (t.fallFrom[f] === e) out.push(fallTarget(t.fallTo[f]));
	return out;
};

test('slopes: terrain walks to 35°, x1.5 to 50°, steep to 60°, climb to 80°, blocked above; models walk to 50°', () => {
	// Ramps rising eastward, 30 yd long, each followed by a 30 yd plateau.
	const ramps = [[30, 20], [45, 80], [55, 140], [70, 200], [85, 260]];
	const height = (x, y) => {
		for (const [deg, x0] of ramps) if (y > 100 && y < 160 && x >= x0 && x <= x0 + 30) return (x - x0) * TAN(deg);
		for (const [deg, x0] of ramps) if (y > 100 && y < 160 && x > x0 + 30 && x < x0 + 60) return 30 * TAN(deg);
		return 0;
	};
	const s = new Scene({ height });
	// A 55° model ramp (WMO) far to the south.
	s.tri([300, 400, 0], [330, 400, 30 * TAN(55)], [330, 440, 30 * TAN(55)], 1).tri([300, 400, 0], [330, 440, 30 * TAN(55)], [300, 440, 0], 1);
	const t = linked(s);
	const mid = (x0) => top(t, x0 + 15, 130);
	const code = (x0) => linkOf(t, mid(x0).e, E) >> 5;
	assert.equal(code(20), CLS.WALK, '30°');
	assert.equal(code(80), LINK_SLOPE, '45°');
	assert.equal(code(140), CLS.STEEP, '55°');
	assert.equal(code(200), CLS.CLIMB, '70°');
	assert.ok(column(t, 260 + 15, 130).every((x) => x.flags & FLAG.BLOCKED), '85° is not walkable');
	assert.ok(column(t, 315, 420).pop().flags & FLAG.BLOCKED, 'a 55° model surface is not walkable');
});

test('steep faces: along or down a terrain face over 60° nothing walks, it is climbed up or slid down', () => {
	// A 70° face rising eastward from x = 200, 30 yd wide, then a plateau;
	// a cell 5 yd up the face is about 14 yd above its foot.
	const height = (x) => (x < 200 ? 0 : x <= 230 ? (x - 200) * TAN(70) : 30 * TAN(70));
	const t = linked(new Scene({ height }));
	const face = top(t, 205, 250);
	assert.ok(t.slope[face.e] > 60, `face ${t.slope[face.e]}°`);
	const N = 6;
	const S = 2;
	assert.equal(linkOf(t, face.e, N), NO_LINK, 'no walk along the face (north)');
	assert.equal(linkOf(t, face.e, S), NO_LINK, 'nor south');
	assert.equal(linkOf(t, face.e, E) >> 5, CLS.CLIMB, 'climbed up');
	assert.equal(linkOf(t, face.e, W), NO_LINK, 'never walked down');
	const down = falls(t, face.e).filter((f) => f.di < 0 && f.dj === 0);
	assert.equal(down.length, 1, 'slid down westward');
	const k = face.k + down[0].di;
	assert.ok(Math.abs(t.z[t.first[k] + down[0].layer]) < 0.5, 'to the foot of the face');
});

test('in-links: every link and fall into an entry, with the seconds expand gives it', () => {
	const s = new Scene({ height: (x) => Math.sin(x / 25) * 6 });
	s.box(100, 100, -1, 160, 160, 12).box(300, 300, -1, 330, 330, 3, 1);
	const t = linked(s);
	const p = profileFor({});
	const space = new Space([t]);
	const into = new Map();
	for (let k = 0; k < 256 * 256; k++) {
		for (let e = t.first[k]; e < t.first[k + 1]; e++) {
			if (t.flags[e] & FLAG.BLOCKED) continue;
			const n = space.expand(0, e, k, p);
			for (let x = 0; x < n; x++) {
				const v = space.outTo[x];
				if (!into.has(v)) into.set(v, []);
				into.get(v).push(`${e}:${space.outCost[x].toFixed(6)}`);
			}
		}
	}
	let checked = 0;
	for (const [v, list] of into) {
		if (checked++ % 37) continue;
		let k = 0;
		while (t.first[k + 1] <= v) k++;
		const n = inLinks(t, v, k, p);
		const got = [];
		for (let x = 0; x < n; x++) got.push(`${IN.from[x]}:${IN.cost[x].toFixed(6)}`);
		assert.deepEqual(got.sort(), list.sort(), `entry ${v}`);
	}
	assert.ok(checked > 1000);
});

test('open surfaces: a roof one only falls onto is not open, the ground is', () => {
	// A broad block (top 15) beside a small roof (top 10) one falls onto from it.
	const s = new Scene();
	s.box(100, 100, -1, 300, 300, 15).box(300, 180, 8, 320, 220, 10);
	const t = linked(s);
	const roof = top(t, 310, 200);
	assert.ok(Math.abs(roof.z - 10) < 0.5, `roof ${roof.z}`);
	assert.ok(t.fallFrom.some((f, i) => {
		const g = fallTarget(t.fallTo[i]);
		return g.di > 0 && Math.abs(t.z[f] - 15) < 0.5;
	}), 'falls from the block toward the roof');
	assert.equal(isOpen(t, roof.k, roof.e, 400), false, 'the roof');
	const ground = top(t, 400, 400);
	assert.equal(isOpen(t, ground.k, ground.e, 400), true, 'the ground');
});

test('floors: a step up to 1 yd walks, a ledge up to 1.6 yd is a jump, higher has no link', () => {
	const s = new Scene({ height: () => -100 });
	s.floor(0, 0, 100, 512, 0, 1);
	s.floor(100, 0, 200, 100, 0.8, 1);
	s.floor(100, 100, 200, 200, 1.4, 1);
	s.floor(100, 200, 200, 300, 2.5, 1);
	const t = linked(s);
	const x = 100 - CELL / 2;
	assert.equal(linkOf(t, top(t, x, 50).e, E) >> 5, CLS.WALK, '0.8 yd step');
	assert.equal(linkOf(t, top(t, x, 150).e, E) >> 5, CLS.JUMP, '1.4 yd ledge');
	assert.equal(linkOf(t, top(t, x, 250).e, E), NO_LINK, '2.5 yd wall');
	// Down the 2.5 yd ledge is a fall, one way.
	const high = top(t, 100 + CELL / 2, 250);
	assert.equal(linkOf(t, high.e, W), NO_LINK);
	const down = falls(t, high.e);
	assert.ok(down.length >= 1 && down.every((f) => f.di === -1), 'falls only westward, off the ledge');
});

test('steps: a WMO tread under a top over a jump high climbs as a jump both ways; a high tread or a top rise over a jump does not', () => {
	// Floor at 0 west of x = 101; east of it a top, with a tread from x = 100.3
	// under the top's edge, both in the column at x 100-102: a 0.7 yd tread
	// under a 2.2 yd top (the Ruins of Lordaeron's throne room steps), a 1.2 yd
	// tread under it, a 0.7 yd tread under a 2.9 yd top.
	const s = new Scene({ height: () => -100 });
	s.floor(0, 0, 101, 300, 0);
	s.floor(100.3, 0, 101.6, 100, 0.7).floor(101, 0, 200, 100, 2.2);
	s.floor(100.3, 100, 101.6, 200, 1.2).floor(101, 100, 200, 200, 2.2);
	s.floor(100.3, 200, 101.6, 300, 0.7).floor(101, 200, 200, 300, 2.9);
	const t = linked(s);
	const x = 100 - CELL / 2;
	const up = linkOf(t, top(t, x, 50).e, E);
	assert.equal(up >> 5, CLS.JUMP, 'onto the top over the tread');
	assert.ok(Math.abs(column(t, 101, 50)[(up & 31)].z - 2.2) < 0.01, 'lands on the top');
	assert.equal(linkOf(t, top(t, 101, 50).e, W) >> 5, CLS.JUMP, 'and down again');
	assert.equal(linkOf(t, top(t, x, 150).e, E), NO_LINK, 'a 1.2 yd tread is no step');
	// A 0.7 yd tread 2.2 yd under a 2.9 yd top is a floor of its own: a step onto it, nothing on.
	const tread = linkOf(t, top(t, x, 250).e, E);
	assert.equal(tread >> 5, CLS.WALK);
	const t07 = column(t, 101, 250)[tread & 31];
	assert.ok(Math.abs(t07.z - 0.7) < 0.01);
	assert.equal(linkOf(t, t07.e, E), NO_LINK, 'a 2.2 yd rise from the tread is no jump');
});

test('falls: one way, onto ground up to FALL_MAX, into water up to 60 yd', () => {
	// Model plateaus west of x = 200 (top 20 in the north, 40 in the south);
	// east of them ground at 0 in the north and a deep lake (water at 0) in the south.
	const s = new Scene({ height: (x, y) => (x > 200 && y >= 256 ? -20 : 0) });
	s.box(0, 0, -1, 200, 250, 20).box(0, 262, -30, 200, 512, 40);
	s.water(200, 256, 512, 512, 0, 1);
	const t = linked(s);
	const edge20 = edgeWest(t, 200 - CELL / 2, 100, 20);
	assert.ok(falls(t, edge20.e).length >= 1, 'a 20 yd fall onto ground');
	const below = top(t, 200 + CELL * 1.5, 100);
	assert.ok(below.z < 1 && falls(t, below.e).length === 0, 'none back up');
	// Westward from the ground at the plateau's foot nothing climbs it, and its wall shuts the ground inside it off.
	const foot = top(t, 200 + CELL / 2, 100);
	assert.ok(foot.z < 1, 'ground at the foot');
	const west = linkOf(t, foot.e, W);
	assert.equal(west, NO_LINK, 'no link into or onto the plateau');
	const edge40 = edgeWest(t, 200 - CELL / 2, 400, 40);
	assert.ok(falls(t, edge40.e).length >= 1, 'a 40 yd fall into water');
	const water = top(t, 200 + CELL * 1.5, 400);
	assert.ok(water.flags & FLAG.SWIM && Math.abs(water.z) < 0.01, 'the lake is a swim surface at its level');
	// Over 40 yd onto ground is too far.
	const s2 = new Scene();
	s2.box(0, 0, -1, 200, 512, 40);
	const t2 = linked(s2);
	assert.ok(40 > FALL_MAX);
	assert.equal(falls(t2, edgeWest(t2, 200 - CELL / 2, 100, 40).e).length, 0);
});

test('falls: a cliff of narrow ledges is one fall of its whole height', () => {
	// Steps 0.6 cells wide and 2.5 yd high down to the ground: no ledge holds
	// a 2 x 2 level block, so the fall from the top lands on the ground.
	const s = new Scene();
	for (let q = 0; q < 8; q++) s.box(0, 0, -1, 200.3 + q * 0.6 * CELL, 512, 20 - q * 2.5);
	const t = linked(s);
	const edge = edgeWest(t, 210, 100, 20);
	const east = falls(t, edge.e).filter((f) => f.dj === 0);
	assert.equal(east.length, 1, 'one fall eastward, not one per ledge');
	const k = edge.k + east[0].di;
	const z = t.z[t.first[k] + east[0].layer];
	assert.ok(Math.abs(z) < 0.5, `lands on the ground (z ${z})`);
	assert.ok(east[0].di >= 4, `slides ${east[0].di} cells`);
});

test('liquids: shallow water is wading, deep water swims, magma blocks', () => {
	const height = (x) => (x < 100 ? -1 : x < 200 ? -5 : x < 300 ? -1 : 0);
	const s = new Scene({ height });
	s.water(0, 0, 200, 512, 0, 1);
	s.water(200, 0, 300, 512, 0, 3);
	const t = linked(s);
	const wade = top(t, 50, 50);
	assert.ok(!(wade.flags & FLAG.SWIM) && wade.z < -0.5, 'a yard deep: walk on the floor');
	const deep = top(t, 150, 50);
	assert.ok(deep.flags & FLAG.SWIM && Math.abs(deep.z) < 0.01, 'five yards deep: swim at the surface');
	assert.equal(linkOf(t, deep.e, E) >> 5, CLS.SWIM);
	const lava = column(t, 250, 50);
	assert.ok(lava.every((x) => x.flags & FLAG.BLOCKED), 'magma is never walkable');
});

test('doors: a gap narrower than a cell stays closed, a 4 yd door opens', () => {
	const s = new Scene();
	// Two walls along x = 200..203, each with a door; heights 10 yd.
	s.box(200, 0, -1, 203, 99.5, 10).box(200, 100.5, -1, 203, 250, 10); // 1 yd gap at y 99.5..100.5
	s.box(200, 250, -1, 203, 398, 10).box(200, 402.2, -1, 203, 512, 10); // 4.2 yd gap at y 398..402.2
	const t = linked(s);
	const west = (y) => top(t, 200 - CELL * 1.5, y);
	const through = (y) => {
		// Walk east from the west side along row y: links all the way past the wall?
		let e = west(y).e;
		let k = column(t, 200 - CELL * 1.5, y)[0].k;
		for (let step = 0; step < 4; step++) {
			const b = linkOf(t, e, E);
			if (b === NO_LINK) return false;
			k += 1;
			e = t.first[k] + (b & 31);
		}
		return true;
	};
	assert.equal(through(100), false, '1 yd gap');
	assert.equal(through(400), true, '4 yd door');
});

test('clearance: a tunnel lower than the agent blocks, a taller one passes', () => {
	const s = new Scene();
	// Roof slabs over the ground: 1.2 yd up (blocked) and 3 yd up (open).
	s.box(100, 50, 1.2, 200, 100, 2, 1);
	s.box(100, 300, 3, 200, 350, 4, 1);
	const t = linked(s);
	const low = column(t, 150, 75)[0];
	assert.ok(low.flags & FLAG.BLOCKED, 'ground under a 1.2 yd roof');
	const high = column(t, 150, 325)[0];
	assert.ok(!(high.flags & FLAG.BLOCKED) && high.z < 0.1, 'ground under a 3 yd roof');
	assert.ok(!(top(t, 150, 325).flags & FLAG.BLOCKED), 'and the roof top');
});

test('doorways: outdoor ground into a WMO floor over a threshold, through a door whose jambs reach into both its columns', () => {
	// A building (indoor WMO) east of x = 210: floor 0.5 yd above the ground,
	// a front wall 0.6 yd thick with a 2.6 yd door at y 100.2..102.8 (the
	// column centred on y 101.04 is the only one whose centre is in the
	// opening, and the jambs at 100.2 and 102.8 lie inside it and its
	// neighbour), a lintel at 3.5 and a roof at 5.
	const s = new Scene();
	s.box(210, 50, -1, 260, 150, 0.5, 2); // floor slab
	s.box(210, 50, 0.5, 210.6, 100.2, 5, 2).box(210, 102.8, 0.5, 210.6, 150, 5, 2); // front wall
	s.box(210, 100.2, 3.5, 210.6, 102.8, 5, 2); // lintel
	s.box(210, 50, 5, 260, 150, 5.4, 2); // roof
	const t = linked(s);
	const through = (y) => {
		// East along row y from the ground at x = 203 to the floor at x = 220.
		let k = column(t, 203, y)[0].k;
		let e = top(t, 203, y).e;
		for (let x = 203; x < 220; x += CELL) {
			const b = linkOf(t, e, E);
			if (b === NO_LINK) return false;
			k += 1;
			e = t.first[k] + (b & 31);
		}
		return t.flags[e] & FLAG.INDOOR && Math.abs(t.z[e] - 0.5) < 0.01;
	};
	assert.ok(through(101), 'in through the door onto the floor');
	assert.equal(through(80), false, 'not through the wall');
	const inside = top(t, 220, 101);
	assert.ok(inside.flags & FLAG.INDOOR && linkOf(t, inside.e, W) !== NO_LINK, 'and out again');
});

test('components: a pen walled higher than any fall is its own component', () => {
	const s = new Scene();
	s.box(100, 100, -1, 200, 104, 40).box(100, 196, -1, 200, 200, 40).box(100, 100, -1, 104, 200, 40).box(196, 100, -1, 200, 200, 40);
	const t = linked(s);
	const inside = top(t, 150, 150);
	const outside = top(t, 50, 50);
	assert.notEqual(t.comp[inside.e], NO_COMP);
	assert.notEqual(t.comp[inside.e], t.comp[outside.e]);
	assert.equal(t.comp[outside.e], t.comp[top(t, 300, 300).e]);
});

test('tile files round-trip', () => {
	const s = new Scene({ height: (x, y) => Math.sin(x / 30) * 5 + y / 50 });
	s.box(100, 100, 0, 120, 140, 6, 2).water(300, 300, 400, 400, 10, 2);
	const t = linked(s);
	const back = decodeTile(encodeTile(t));
	for (const key of ['n', 'nComp', 'c', 'col', 'row']) assert.equal(back[key], t[key], key);
	for (const key of ['count', 'z', 'ceil', 'flags', 'slope', 'tslope', 'areas', 'links', 'comp', 'fallFrom', 'fallTo']) {
		assert.deepEqual(Buffer.from(back[key].buffer, back[key].byteOffset, back[key].byteLength), Buffer.from(t[key].buffer, t[key].byteOffset, t[key].byteLength), key);
	}
	assert.deepEqual([...back.first], [...t.first]);
	// Indoor floors keep their flag.
	assert.ok(top(back, 110, 120).flags & FLAG.INDOOR);
});

test('terrain slope: each surface keeps its steepest terrain triangle (tslope), 0 on model surfaces; tile format 4 carries it', () => {
	// A 45° terrain plane rising eastward; a flat WMO floor far above part of it.
	const s = new Scene({ height: (x) => x * TAN(45) });
	s.floor(100, 100, 200, 200, 1000, 1);
	const t = linked(s);
	assert.ok(t.tslope instanceof Uint8Array && t.tslope.length === t.n, 'one tslope per surface');
	let terrain = 0;
	for (let e = 0; e < t.n; e++) {
		if (!(t.flags[e] & FLAG.TERRAIN)) continue;
		assert.equal(t.tslope[e], 45, `terrain surface ${e}`);
		terrain++;
	}
	assert.ok(terrain > 60000, `${terrain} terrain surfaces`);
	const col = column(t, 150, 150);
	assert.equal(col.length, 2, 'the plane and the floor');
	assert.ok(col[1].flags & FLAG.WMO && Math.abs(col[1].z - 1000) < 0.01, 'the floor is the top');
	assert.equal(t.tslope[col[1].e], 0, 'a flat WMO floor has no terrain slope');
	assert.equal(t.tslope[col[0].e], 45, 'the plane under it does');
	const gz = encodeTile(t);
	assert.equal(VERSION, 4);
	assert.equal(zlib.gunzipSync(gz).readUInt32LE(4), 4, 'written as format 4');
	assert.deepEqual([...decodeTile(gz).tslope], [...t.tslope]);
});

test('tile files of format 3 still decode, with tslope null', () => {
	const t = linked(new Scene({ height: (x, y) => Math.sin(x / 30) * 5 + y / 50 }).box(100, 100, 0, 120, 140, 6, 2));
	// Format 3 is format 4 without the trailing tslope bytes.
	const raw = zlib.gunzipSync(encodeTile(t));
	const v3 = Buffer.from(raw.subarray(0, raw.length - t.n));
	v3.writeUInt32LE(3, 4);
	const back = decodeTile(zlib.gzipSync(v3));
	assert.equal(back.tslope, null);
	for (const key of ['z', 'slope', 'links']) assert.deepEqual([...back[key]], [...t[key]], key);
	const v2 = Buffer.from(v3);
	v2.writeUInt32LE(2, 4);
	assert.throws(() => decodeTile(zlib.gzipSync(v2)), /^Error: nav tile version 2, expected 3 or 4$/);
});

const NAV3_TILE = path.join(__dirname, '..', 'data', 'local', 'nav3', 'tiles', '0', '23_54.nav.gz');
test('real: a tile of the version 3 grid (data/local/nav3) decodes, with links and tslope null', { skip: fs.existsSync(NAV3_TILE) ? false : 'no data/local/nav3' }, () => {
	const gz = fs.readFileSync(NAV3_TILE);
	assert.equal(zlib.gunzipSync(gz).readUInt32LE(4), 3);
	const t = decodeTile(gz);
	assert.equal(t.tslope, null);
	assert.ok(t.n > 0 && t.links.length === 8 * t.n && t.first[65536] === t.n);
});

test('WMO liquids: a canal swims, lava blocks its floor', () => {
	const floors = new Scene({ hole: () => true });
	const sheet = (x0, x1, z) => {
		const v = (x, y) => [floors.north - y, floors.west - x, z];
		return Float32Array.from([...v(x0, 100), ...v(x1, 100), ...v(x1, 200), ...v(x0, 100), ...v(x1, 200), ...v(x0, 200)]);
	};
	floors.floor(100, 100, 200, 200, -4, 1).floor(300, 100, 400, 200, -4, 1);
	const fg = floors.geom();
	fg.wmoLiquid = [{ type: 1, tris: sheet(100, 200, 0) }, { type: 3, tris: sheet(300, 400, -3) }];
	const { tile } = buildSurfaces(rasterise(fg, fg), fg);
	const canal = top(tile, 150, 150);
	assert.ok(canal.flags & FLAG.SWIM && Math.abs(canal.z) < 0.01, 'canal water 4 yd deep is a swim surface');
	assert.ok(column(tile, 350, 150).every((x) => x.flags & FLAG.BLOCKED), 'a floor under lava is blocked');
});
