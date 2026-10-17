'use strict';
// The roads layer (tools/lib/nav/layers): a synthetic tex0 ADT through the
// parser (uncompressed 8-bit, RLE-compressed and 4-bit alpha maps) and the
// per-column road weights, the road-texture allowlist, and known roads on
// the built layer (data/local/nav-layers/roads; skipped until
// `nav layers roads` has run).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { parseTex0 } = require('../tools/lib/nav/layers/tex0');
const { tileRoadWeights, isRoadTexture, roadWeights, shapeOf, roadByShape, ROADS_DIR } = require('../tools/lib/nav/layers/roads');
const { cellOf } = require('../tools/lib/nav/grid/format');
const { Geo } = require('../tools/lib/planner/geo');
const { DATA } = require('../tools/lib/paths');

// --- binary builders ---------------------------------------------------------

const u32 = (...v) => {
	const b = Buffer.alloc(v.length * 4);
	v.forEach((x, k) => b.writeUInt32LE(x, k * 4));
	return b;
};
const chunk = (tag, data) => {
	const h = Buffer.alloc(8);
	h.write(tag.split('').reverse().join(''), 0, 'latin1');
	h.writeUInt32LE(data.length, 4);
	return Buffer.concat([h, data]);
};
// MCLY entry: texture index, flags, offset in MCAL, effect id.
const layer = (tex, flags, offset) => u32(tex, flags, offset, 0);

const GRASS = 1000; // MDID fdids
const ROAD = 2000;
const ROAD_IDS = new Set([ROAD]);

// 64 x 64 alpha, value v where x < 32 and y < 32 (the chunk's top-left quarter), else 0.
function quarter(v) {
	const a = Buffer.alloc(4096);
	for (let y = 0; y < 32; y++) a.fill(v, y * 64, y * 64 + 32);
	return a;
}
// The same as RLE: per row a fill run of 32 x v and one of 32 x 0 (rows 0-31), then fills of 0.
function rle(alpha) {
	const out = [];
	for (let o = 0; o < 4096; ) {
		let n = 1;
		while (n < 127 && o + n < 4096 && alpha[o + n] === alpha[o]) n++;
		out.push(0x80 | n, alpha[o]);
		o += n;
	}
	return Buffer.from(out);
}
// 4-bit: two texels per byte, low nibble first.
function nibbles(alpha) {
	const out = Buffer.alloc(2048);
	for (let k = 0; k < 4096; k += 2) out[k >> 1] = (alpha[k] >> 4) | (alpha[k + 1] & 0xf0);
	return out;
}

// A tex0 whose chunks (x, y) in `roads` carry a road layer with `mcal`; the rest only grass.
function tex0(roads, { mcal, flags }) {
	const mcnk = [];
	for (let n = 0; n < 256; n++) {
		const road = roads.some(([x, y]) => y * 16 + x === n);
		const mcly = road ? Buffer.concat([layer(0, 0, 0), layer(1, flags, 0)]) : layer(0, 0, 0);
		mcnk.push(chunk('MCNK', Buffer.concat([chunk('MCLY', mcly), chunk('MCAL', road ? mcal : Buffer.alloc(0))])));
	}
	return Buffer.concat([chunk('MVER', u32(18)), chunk('MAMP', u32(0)), chunk('MDID', u32(GRASS, ROAD)), chunk('MHID', u32(0, 0)), ...mcnk]);
}

// Columns (i, j) of the road chunks' top-left 8 x 8 are 255, every other 0.
function assertQuarters(w, roads) {
	assert.equal(w.length, 65536);
	const want = new Uint8Array(65536);
	for (const [x, y] of roads) for (let j = 0; j < 8; j++) for (let i = 0; i < 8; i++) want[(y * 16 + j) * 256 + x * 16 + i] = 255;
	const bad = [];
	for (let k = 0; k < 65536; k++) if (w[k] !== want[k]) bad.push(`(${k % 256},${Math.floor(k / 256)})=${w[k]}`);
	assert.deepEqual(bad.slice(0, 8), []);
}

const ROADS = [[0, 0], [3, 2], [15, 15]];

// --- tex0 and weights --------------------------------------------------------

test('tex0: MDID textures and per chunk the MCLY layers with their alpha maps', () => {
	const t = parseTex0(tex0(ROADS, { mcal: quarter(255), flags: 0x100 }), { bigAlpha: true });
	assert.deepEqual(t.textures, [GRASS, ROAD]);
	assert.equal(t.chunks.length, 256);
	assert.equal(t.chunks[0].layers.length, 2);
	assert.equal(t.chunks[0].layers[0].alpha, null);
	assert.equal(t.chunks[0].layers[1].tex, 1);
	assert.equal(t.chunks[0].layers[1].alpha.length, 4096);
	assert.equal(t.chunks[0].layers[1].alpha[0], 255);
	assert.equal(t.chunks[0].layers[1].alpha[32], 0);
	assert.equal(t.chunks[1].layers.length, 1);
});

test('road weights: a road layer at alpha 255 on a chunk\'s top-left quarter weighs 255 on its top-left 8 x 8 columns, 0 elsewhere', () => {
	assertQuarters(tileRoadWeights(parseTex0(tex0(ROADS, { mcal: quarter(255), flags: 0x100 }), { bigAlpha: true }), ROAD_IDS), ROADS);
});

test('road weights: an RLE-compressed alpha map (layer flag 0x200) decodes to the same', () => {
	const mcal = rle(quarter(255));
	assert.ok(mcal.length < 4096);
	assertQuarters(tileRoadWeights(parseTex0(tex0(ROADS, { mcal, flags: 0x300 }), { bigAlpha: true }), ROAD_IDS), ROADS);
});

test('road weights: a 4-bit alpha map (no big alpha in MPHD) scales 15 to 255, with or without the last row/column fix', () => {
	const mcal = nibbles(quarter(255));
	assert.equal(mcal.length, 2048);
	assertQuarters(tileRoadWeights(parseTex0(tex0(ROADS, { mcal, flags: 0x100 }), { bigAlpha: false }), ROAD_IDS), ROADS);
	assertQuarters(tileRoadWeights(parseTex0(tex0(ROADS, { mcal, flags: 0x100 }), { bigAlpha: false, fix: true }), ROAD_IDS), ROADS);
});

test('tex0: the 4-bit fix copies the 63rd row and column into the 64th', () => {
	const a = Buffer.alloc(4096);
	for (let y = 0; y < 64; y++) for (let x = 0; x < 64; x++) a[y * 64 + x] = x === 62 || y === 62 ? 0xff : x === 63 || y === 63 ? 0 : 0x11;
	const buf = tex0([[0, 0]], { mcal: nibbles(a), flags: 0x100 });
	const raw = parseTex0(buf, { bigAlpha: false }).chunks[0].layers[1].alpha;
	const fixed = parseTex0(buf, { bigAlpha: false, fix: true }).chunks[0].layers[1].alpha;
	assert.equal(raw[63], 0);
	assert.equal(fixed[63], 255);
	assert.equal(fixed[63 * 64], 255);
	assert.equal(fixed[63 * 64 + 63], 255);
	assert.equal(fixed[0], 17);
});

test('road weights: the base layer weighs what the layers above leave; a road base under half a grass layer weighs half', () => {
	const mcnk = [];
	for (let n = 0; n < 256; n++) {
		const mcly = Buffer.concat([layer(1, 0, 0), layer(0, 0x100, 0)]); // road base, grass on top at 128
		mcnk.push(chunk('MCNK', Buffer.concat([chunk('MCLY', mcly), chunk('MCAL', Buffer.alloc(4096, 128))])));
	}
	const buf = Buffer.concat([chunk('MVER', u32(18)), chunk('MDID', u32(GRASS, ROAD)), ...mcnk]);
	const w = tileRoadWeights(parseTex0(buf, { bigAlpha: true }), ROAD_IDS);
	assert.equal(w[0], 127);
	assert.equal(w[65535], 127);
});

test('isRoadTexture: the reviewed allowlist, by path; the _s and _h variants name the same texture', () => {
	assert.equal(isRoadTexture('tileset/barrens/barrensroad01.blp'), true);
	assert.equal(isRoadTexture('tileset/barrens/barrensroad01_s.blp'), true);
	assert.equal(isRoadTexture('Tileset\\Barrens\\BarrensRoad01.blp'), true);
	assert.equal(isRoadTexture('tileset/barrens/barrensgrass01.blp'), false);
	assert.equal(isRoadTexture('tileset/barrens/barrensbasegrass_s.blp'), false);
});

// --- road by shape -----------------------------------------------------------

// Weights w at the columns where fn(i, j).
const painted = (fn, w = 200) => {
	const out = new Uint8Array(65536);
	for (let j = 0; j < 256; j++) for (let i = 0; i < 256; i++) if (fn(i, j)) out[j * 256 + i] = w;
	return out;
};

test('shapeOf: a dominant texture\'s components with their area, weight, mean width (area over half the perimeter), length in yards and elongation', () => {
	const strip = shapeOf(painted((i, j) => i >= 10 && i < 14 && j >= 20 && j < 120));
	assert.equal(strip.length, 1);
	assert.equal(strip[0].area, 400);
	assert.equal(strip[0].weight, 400 * 200);
	assert.ok(Math.abs(strip[0].width - 400 / 104) < 1e-9);
	assert.ok(strip[0].length > 200 && strip[0].length < 215, `${strip[0].length}`);
	assert.ok(Math.abs(strip[0].elongation - (16 + 10000) / 400) < 1e-9);
	const two = shapeOf(painted((i, j) => (i < 50 && j < 50) || (i === 200 && j === 200)));
	assert.deepEqual(two.map((s) => s.area).sort((a, b) => a - b), [1, 2500]);
	assert.equal(shapeOf(painted((i) => i < 50, 127)).length, 0); // under half: not dominant
});

test('shapeOf: a one-column diagonal road is one component (corners touch), a strip', () => {
	const diagonal = shapeOf(painted((i, j) => i === j && j < 100));
	assert.equal(diagonal.length, 1);
	assert.equal(diagonal[0].area, 100);
	assert.equal(roadByShape(diagonal).road, true);
});

test('roadByShape: a pinholed patch is narrow by its perimeter but not elongated: no road', () => {
	const pinholed = shapeOf(painted((i, j) => i < 60 && j < 60 && !(i % 3 === 1 && j % 3 === 1)));
	assert.equal(pinholed.length, 1);
	assert.ok(pinholed[0].width < 6 && pinholed[0].length > 60);
	assert.ok(pinholed[0].elongation < 10);
	assert.equal(roadByShape(pinholed).road, false);
});

test('roadByShape: road when most of the weight lies in long (>= 60 yd) narrow (width <= 6) components', () => {
	const strips = shapeOf(painted((i, j) => i % 40 < 5 && j < 200));
	const patches = shapeOf(painted((i, j) => i % 80 < 60 && j % 80 < 60));
	assert.equal(roadByShape(strips).road, true);
	assert.equal(roadByShape(patches).road, false);
	assert.equal(roadByShape(shapeOf(painted((i, j) => i < 5 && j < 10))).road, false); // short
	assert.equal(roadByShape([...strips, ...patches]).road, false);
	assert.ok(roadByShape(strips).share > 0.99);
});

// --- the built layer ---------------------------------------------------------

const built = (c) => fs.existsSync(path.join(ROADS_DIR, String(c)));
const weightAt = (c, wx, wy) => {
	const { col, row, i, j } = cellOf(wx, wy);
	const w = roadWeights(c, col, row);
	assert.ok(w, `roads tile ${c}/${col}_${row} built`);
	return w[j * 256 + i];
};

test('the built layer: Goldshire\'s main road is road, open grass in Elwynn is not', { skip: !built(0) && 'no roads layer for map 0 (node tools/polestar.js nav layers roads --c 0)' }, () => {
	assert.ok(weightAt(0, -9464, 62) >= 128);
	assert.ok(weightAt(0, -9300, -200) < 64);
});

// (-441, -2650) is the Crossroads' junction, 5.6 yd from the nearest road
// column (the painted road passes beside it); (-560, -2654) is on the
// Southern Gold Road south of it.
test('the built layer: the Barrens\' Gold Road is road', { skip: !built(1) && 'no roads layer for map 1 (node tools/polestar.js nav layers roads --c 1)' }, () => {
	assert.ok(weightAt(1, -560, -2654) >= 128);
	let near = 0;
	for (let dx = -8; dx <= 8; dx++) for (let dy = -8; dy <= 8; dy++) if (Math.hypot(dx, dy) <= 8) near = Math.max(near, weightAt(1, -441 + dx, -2650 + dy));
	assert.ok(near >= 128);
});

// Desolace's main road (uiMap 1443) runs north-south at about x 49 from
// y 49.5 to 54.5 (painted with desolacecracks, a reviewed texture; Main's
// 55,50 to 50,60 brackets it). Map points convert as nav eval does
// (Geo.toWorld, frame 'l'); each sample wants a road column within 10 yd
// east or west of it.
const FRAMES = path.join(DATA, 'map-frames.json');
test('the built layer: Desolace\'s main road has road columns along it', { skip: (!built(1) && 'no roads layer for map 1 (node tools/polestar.js nav layers roads --c 1)') || (!fs.existsSync(FRAMES) && 'no data/forever/map-frames.json (node tools/polestar.js data build)') }, () => {
	const geo = new Geo(JSON.parse(fs.readFileSync(FRAMES, 'utf8')), JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')));
	const misses = [];
	for (let y = 49.5; y <= 54.5; y += 0.5) {
		const p = geo.toWorld(1443, 49, y, 'l');
		assert.equal(p.c, 1);
		let near = 0;
		for (let d = -10; d <= 10; d++) near = Math.max(near, weightAt(1, p.wx, p.wy + d));
		if (near < 128) misses.push(y);
	}
	assert.ok(misses.length <= 1, `no road near 49,${misses.join(' 49,')}`);
});
