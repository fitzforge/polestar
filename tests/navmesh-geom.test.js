'use strict';
// Client geometry per ADT tile (tools/lib/nav/geom): synthetic root/obj0
// ADTs, WMOs and M2s through tileGeometry and continentTiles with an
// in-memory CASC, and the placement transform against real Forever MODF
// extents (skipped without the CASC cache under data/sources/casc).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { tmpdir } = require('./helpers/tmp');
const { tileGeometry, continentTiles } = require('../tools/lib/nav/geom');
const { chunks } = require('../tools/lib/nav/geom/adt');
const { parsePlacements, placementMatrix, transformBox } = require('../tools/lib/nav/geom/place');
const { parseRoot: parseWmoRoot } = require('../tools/lib/nav/geom/wmo');
const { openCasc } = require('../tools/lib/planner/art/casc');

const ADT = 1600 / 3;
const CHUNK = ADT / 16;
const U = CHUNK / 8;
const ORIGIN = 32 * ADT;
const COL = 32;
const ROW = 48;
const X0 = (32 - ROW) * ADT; // the tile's north edge
const Y0 = (32 - COL) * ADT; // its west edge

// --- binary builders ---------------------------------------------------------

const f32 = (...v) => {
	const b = Buffer.alloc(v.length * 4);
	v.forEach((x, i) => b.writeFloatLE(x, i * 4));
	return b;
};
const u32 = (...v) => {
	const b = Buffer.alloc(v.length * 4);
	v.forEach((x, i) => b.writeUInt32LE(x, i * 4));
	return b;
};
const u16 = (...v) => {
	const b = Buffer.alloc(v.length * 2);
	v.forEach((x, i) => b.writeUInt16LE(x, i * 2));
	return b;
};
// A chunk with its tag stored reversed (ADT, WDT, WMO).
const chunk = (tag, data) => {
	const h = Buffer.alloc(8);
	h.write(tag.split('').reverse().join(''), 0, 'latin1');
	h.writeUInt32LE(data.length, 4);
	return Buffer.concat([h, data]);
};

// Outer vertex (r, c) and inner vertex (r, c) heights of every chunk.
const outerH = (r, c) => r + c * 0.25;
const innerH = (r, c) => 5 + r + c * 0.25;

function mcnk(ci, { flags = 0, highRes = null, lowRes = 0, junk14 = false } = {}) {
	const ix = ci % 16;
	const iy = ci >> 4;
	const h = Buffer.alloc(128);
	h.writeUInt32LE(flags, 0);
	h.writeUInt32LE(ix, 4);
	h.writeUInt32LE(iy, 8);
	if (highRes) highRes.forEach((b, y) => (h[0x14 + y] = b));
	if (junk14) h.fill(0xff, 0x14, 0x1c); // ofsHeight / ofsNormal when the high-res flag is clear
	h.writeUInt32LE(1000 + ci, 0x34);
	h.writeUInt16LE(lowRes, 0x3c);
	h.writeFloatLE(X0 - iy * CHUNK, 0x68);
	h.writeFloatLE(Y0 - ix * CHUNK, 0x6c);
	h.writeFloatLE(100, 0x70);
	const heights = [];
	for (let r = 0; r < 17; r++) {
		if (r % 2 === 0) for (let c = 0; c < 9; c++) heights.push(outerH(r / 2, c));
		else for (let c = 0; c < 8; c++) heights.push(innerH((r - 1) / 2, c));
	}
	return chunk('MCNK', Buffer.concat([h, chunk('MCVT', f32(...heights)), chunk('MCNR', Buffer.alloc(448))]));
}

// MH2O: { [chunkIndex]: [instance] }, instance { type, lvf, min, x, y, w, h,
// exists?: [bytes], heights?: [f32] } (heights followed by LVF 0 depths).
function mh2o(layers) {
	const head = Buffer.alloc(256 * 12);
	const parts = [head];
	let at = head.length;
	const put = (buf) => {
		const o = at;
		parts.push(buf);
		at += buf.length;
		return o;
	};
	for (const [ci, list] of Object.entries(layers)) {
		const block = Buffer.alloc(list.length * 24);
		head.writeUInt32LE(put(block), ci * 12);
		head.writeUInt32LE(list.length, ci * 12 + 4);
		list.forEach((L, k) => {
			const p = k * 24;
			block.writeUInt16LE(L.type, p);
			block.writeUInt16LE(L.lvf, p + 2);
			block.writeFloatLE(L.min, p + 4);
			block.writeFloatLE(L.min, p + 8);
			block[p + 12] = L.x;
			block[p + 13] = L.y;
			block[p + 14] = L.w;
			block[p + 15] = L.h;
			if (L.exists) block.writeUInt32LE(put(Buffer.from(L.exists)), p + 16);
			if (L.heights) block.writeUInt32LE(put(Buffer.concat([f32(...L.heights), Buffer.alloc(L.heights.length)])), p + 20);
		});
	}
	return Buffer.concat(parts);
}

// Placement-space vector for world (wx, wy, z).
const P = (wx, wy, z) => [ORIGIN - wy, z, ORIGIN - wx];

function modf({ fdid, uniqueId, at, rot, scale = 1024, flags = 0x8 | 0x4 }) {
	const b = Buffer.alloc(64);
	b.writeUInt32LE(fdid, 0);
	b.writeUInt32LE(uniqueId, 4);
	f32(...P(...at), ...rot).copy(b, 8);
	const lo = P(at[0] + 100, at[1] + 100, at[2] - 100);
	const hi = P(at[0] - 100, at[1] - 100, at[2] + 100);
	f32(...lo, ...hi).copy(b, 32);
	b.writeUInt16LE(flags, 56);
	b.writeUInt16LE(scale, 62);
	return b;
}

function mddf({ fdid, uniqueId, at, rot, scale = 1024, flags = 0x40 }) {
	const b = Buffer.alloc(36);
	b.writeUInt32LE(fdid, 0);
	b.writeUInt32LE(uniqueId, 4);
	f32(...P(...at), ...rot).copy(b, 8);
	b.writeUInt16LE(scale, 32);
	b.writeUInt16LE(flags, 34);
	return b;
}

// WMO group: MOGP header (68 bytes: name, flags, bounding box, groupLiquid)
// + MOPY MOVI MOVT [+ MLIQ].
function wmoGroup({ flags, name = 0, polys = [], verts = [], box = [0, 0, 0, 0, 0, 0], liquid = 0, mliq = null }) {
	const h = Buffer.alloc(68);
	h.writeUInt32LE(name, 0);
	h.writeUInt32LE(flags, 8);
	f32(...box).copy(h, 0x0c);
	h.writeUInt32LE(liquid, 0x34);
	const mopy = Buffer.alloc(polys.length * 2);
	polys.forEach((p, i) => (mopy[i * 2] = p.flags));
	const movi = u16(...polys.flatMap((p) => p.idx));
	const sub = [h, chunk('MOPY', mopy), chunk('MOVI', movi), chunk('MOVT', f32(...verts.flat()))];
	if (mliq) sub.push(chunk('MLIQ', mliq));
	return Buffer.concat([chunk('MVER', u32(17)), chunk('MOGP', Buffer.concat(sub))]);
}

// MLIQ: xtiles x ytiles tiles at corner (model space), heights per vertex
// (row-major, x fastest), one flag byte per tile.
function mliq({ corner, xt, yt, heights, tiles }) {
	const h = Buffer.alloc(30);
	h.writeInt32LE(xt + 1, 0);
	h.writeInt32LE(yt + 1, 4);
	h.writeInt32LE(xt, 8);
	h.writeInt32LE(yt, 12);
	f32(...corner).copy(h, 16);
	const v = Buffer.alloc(heights.length * 8);
	heights.forEach((z, i) => v.writeFloatLE(z, i * 8 + 4));
	return Buffer.concat([h, v, Buffer.from(tiles)]);
}

function wmoRootFile({ flags, groups, names = Buffer.from('\0', 'latin1') }) {
	const mohd = Buffer.alloc(64);
	mohd.writeUInt32LE(groups.length, 4);
	f32(0, 0, 0, 1, 1, 1).copy(mohd, 0x24);
	mohd.writeUInt16LE(flags, 0x3c);
	return Buffer.concat([chunk('MVER', u32(17)), chunk('MOHD', mohd), chunk('MOGN', names), chunk('GFID', u32(...groups))]);
}

// Chunked M2: MD21 (forward tag) holding an MD20 with collision only.
function m2({ idx, verts, box = [0, 0, 0, 1, 2, 3] }) {
	const d = Buffer.alloc(0x100 + idx.length * 2 + verts.length * 12);
	d.write('MD20', 0, 'latin1');
	d.writeUInt32LE(272, 4);
	f32(...box).copy(d, 0xbc);
	d.writeUInt32LE(idx.length, 0xd8);
	d.writeUInt32LE(0x100, 0xdc);
	d.writeUInt32LE(verts.length, 0xe0);
	d.writeUInt32LE(0x100 + idx.length * 2, 0xe4);
	u16(...idx).copy(d, 0x100);
	f32(...verts.flat()).copy(d, 0x100 + idx.length * 2);
	const h = Buffer.alloc(8);
	h.write('MD21', 0, 'latin1');
	h.writeUInt32LE(d.length, 4);
	return Buffer.concat([h, d]);
}

// A CASC stand-in over in-memory files, with the client tables under
// <sources>/wago/<build>/ as tileGeometry reads them.
function fakeCasc(files, tables) {
	const sources = tmpdir('polestar-navgeom-');
	const build = '1.60.1.1';
	fs.mkdirSync(path.join(sources, 'wago', build), { recursive: true });
	for (const [name, text] of Object.entries(tables)) fs.writeFileSync(path.join(sources, 'wago', build, `${name}.csv`), text);
	return {
		build,
		offline: true,
		dir: path.join(sources, 'casc', 'wow_classic_beta', build),
		get: async (fdid) => {
			if (files.has(fdid)) return files.get(fdid);
			throw Object.assign(new Error(`GET ${fdid}: HTTP 404`), { status: 404 });
		},
	};
}

const TABLES = {
	LiquidType:
		'ID,Name,Flags,SoundBank,MaterialID\n1,Water,15,0,1\n3,Magma,120,2,2\n4,Slime,322,3,2\n13,WMO Water,15,0,1\n14,WMO Ocean,527,1,1\n19,WMO Magma,120,2,2\n30,Visual Water,15,0,9\n1250,PBRWater - Generic - Ocean,5135,0,7\n',
	LiquidMaterial: 'ID,Flags,LVF\n1,1,0\n2,0,1\n7,1,2\n9,2,0\n',
	LiquidObject: 'ID,FlowDirection,FlowSpeed,LiquidTypeID,Fishable,Reflection\n20335,0,0,1250,1,0\n',
	Map: 'ID,MapName_lang,WdtFileDataID\n0,Eastern Kingdoms,9000\n',
};

// World coordinates of the synthetic placements.
const WMO_AT = [-8800, -200, 50];
const WMO2_AT = [-8900, -400, 0];
const M2_AT = { a: [-8700, -100, 20], b: [-8650, -50, 10], c: [-8600, -300, 0], out: [X0 + 30, -100, 0] };

function syntheticTile() {
	const mcnks = [];
	for (let ci = 0; ci < 256; ci++) {
		if (ci === 0) mcnks.push(mcnk(ci, { flags: 0x10000, highRes: [0, 0b100, 0, 0, 0, 0, 0, 0] }));
		else if (ci === 1) mcnks.push(mcnk(ci, { lowRes: 0x1, junk14: true }));
		else mcnks.push(mcnk(ci));
	}
	const water = mh2o({
		5: [{ type: 1, lvf: 0, min: 10, x: 2, y: 3, w: 2, h: 1, exists: [0b01], heights: [10, 11, 12, 10.5, 11.5, 12] }],
		16: [{ type: 3, lvf: 0, min: 50, x: 0, y: 0, w: 8, h: 8 }],
		17: [
			{ type: 1250, lvf: 20335, min: 5, x: 0, y: 0, w: 1, h: 1, heights: [999, 999, 999, 999] },
			{ type: 4, lvf: 0, min: 3, x: 0, y: 0, w: 2, h: 1 },
		],
		18: [{ type: 30, lvf: 0, min: 1, x: 0, y: 0, w: 1, h: 1 }], // a VisualOnly LiquidMaterial: no liquid
	});
	const root = Buffer.concat([chunk('MVER', u32(18)), chunk('MHDR', Buffer.alloc(64)), chunk('MH2O', water), ...mcnks]);
	const obj0 = Buffer.concat([
		chunk('MVER', u32(18)),
		chunk(
			'MDDF',
			Buffer.concat([
				mddf({ fdid: 500, uniqueId: 1, at: M2_AT.a, rot: [0, 0, 0] }),
				mddf({ fdid: 500, uniqueId: 2, at: M2_AT.b, rot: [90, 0, 0], scale: 512 }),
				mddf({ fdid: 500, uniqueId: 3, at: M2_AT.c, rot: [0, 0, 90] }),
				mddf({ fdid: 501, uniqueId: 4, at: M2_AT.a, rot: [0, 0, 0] }),
				mddf({ fdid: 502, uniqueId: 5, at: M2_AT.a, rot: [0, 0, 0] }),
				mddf({ fdid: 500, uniqueId: 6, at: M2_AT.out, rot: [0, 0, 0] }),
			]),
		),
		chunk('MODF', Buffer.concat([modf({ fdid: 400, uniqueId: 7, at: WMO_AT, rot: [0, 90, 0], scale: 2048 }), modf({ fdid: 450, uniqueId: 8, at: WMO2_AT, rot: [0, 0, 0] })])),
	]);
	const verts = [
		[0, 0, 0],
		[1, 0, 0],
		[0, 1, 0],
		[0, 0, 1],
	];
	const names = Buffer.from('\0\0group\0antiportal\0', 'latin1');
	const one = (corner, z, tile) => mliq({ corner, xt: 1, yt: 1, heights: [z, z, z, z], tiles: [tile] });
	const files = new Map([
		[100, root],
		[101, obj0],
		// use_liquid_type_dbc_id: groupLiquid is a LiquidType (through GetLiquidTypeId)
		[400, wmoRootFile({ flags: 0x4, groups: [410, 411, 412, 413, 414, 415, 416], names })],
		[
			410,
			wmoGroup({
				flags: 0x2000,
				name: 2,
				verts,
				polys: [
					{ flags: 0x20, idx: [0, 1, 2] }, // render: collides
					{ flags: 0x24, idx: [0, 1, 3] }, // render + detail: no
					{ flags: 0x0c, idx: [0, 2, 3] }, // collision + detail: collides
					{ flags: 0x00, idx: [1, 2, 3] }, // neither: no
				],
			}),
		],
		// groupLiquid 5 (Slow Water) -> 13 WMO Water; the second tile has no liquid
		[411, wmoGroup({ flags: 0x8, name: 2, verts, polys: [{ flags: 0x08, idx: [0, 1, 2] }], liquid: 5, mliq: mliq({ corner: [10, 20, 0], xt: 2, yt: 1, heights: [1, 2, 3, 4, 5, 6], tiles: [0x00, 0x0f] }) })],
		[412, wmoGroup({ flags: 0x8 | 0x80, name: 2, verts, polys: [{ flags: 0x20, idx: [0, 1, 2] }], liquid: 5, mliq: one([0, 0, 0], 0, 0) })],
		[413, wmoGroup({ flags: 0x8, name: 8, verts, polys: [{ flags: 0x20, idx: [0, 1, 2] }] })],
		// 414: missing
		// groupLiquid 3 (Magma) -> 19 WMO Magma, no MLIQ: filled to the box top
		[415, wmoGroup({ flags: 0x8, box: [0, 0, -1, 3, 4, 7], liquid: 3 })],
		// a VisualOnly LiquidMaterial: no liquid
		[416, wmoGroup({ flags: 0x8, liquid: 30, mliq: one([0, 0, 0], 0, 0) })],
		// without use_liquid_type_dbc_id: groupLiquid 15 takes the first tile's
		// legacy type (2 + 1 -> 19 WMO Magma); groupLiquid 0 + 1 -> 13, ocean (14)
		// with MOGP flags 0x80000
		[450, wmoRootFile({ flags: 0, groups: [451, 452, 453] })],
		[451, wmoGroup({ flags: 0x8, liquid: 15, mliq: one([0, 0, 0], 2, 0x02) })],
		[452, wmoGroup({ flags: 0x8 | 0x80000, liquid: 0, mliq: one([5, 5, 0], 1, 0x00) })],
		// ... and a dry group of such a WMO (no MLIQ) has none
		[453, wmoGroup({ flags: 0x8, box: [0, 0, 0, 9, 9, 9], liquid: 0 })],
		[500, m2({ idx: [0, 1, 2], verts: [[1, 2, 3], [0, 0, 0], [0, 1, 0]] })],
		[501, m2({ idx: [], verts: [], box: [1e7, 1e7, 1e7, -1e7, -1e7, -1e7] })],
		// 502: missing
	]);
	return fakeCasc(files, TABLES);
}

const TILE = { c: 0, col: COL, row: ROW, root: 100, obj0: 101 };

const near = (a, b, msg) => assert.ok(Math.abs(a - b) < 1e-3, `${msg}: ${a} != ${b}`);
const triAt = (g, t) => Array.from(g.tris.subarray(t * 9, t * 9 + 9));
const sameTri = (got, want, msg) => want.flat().forEach((v, i) => near(got[i], v, `${msg} [${i}]`));

test('terrain: four triangles per quad around the inner vertex, counter-clockwise from above, none on holes', async () => {
	const g = await tileGeometry(syntheticTile(), TILE);
	assert.equal(g.stats.holes, 5);
	assert.equal(g.stats.terrainTris, (256 * 64 - 5) * 4);
	const z = (h) => 100 + h;
	const NW = [X0, Y0, z(outerH(0, 0))];
	const NE = [X0, Y0 - U, z(outerH(0, 1))];
	const SW = [X0 - U, Y0, z(outerH(1, 0))];
	const SE = [X0 - U, Y0 - U, z(outerH(1, 1))];
	const C = [X0 - U / 2, Y0 - U / 2, z(innerH(0, 0))];
	sameTri(triAt(g, 0), [NW, C, NE], 'north');
	sameTri(triAt(g, 1), [NE, C, SE], 'east');
	sameTri(triAt(g, 2), [SE, C, SW], 'south');
	sameTri(triAt(g, 3), [SW, C, NW], 'west');

	const holed = [
		// chunk 0, high-res byte 1 bit 2: quad x 2, y 1
		[X0 - U, X0 - 2 * U, Y0 - 2 * U, Y0 - 3 * U],
		// chunk 1, low-res bit 0: quads x 0-1, y 0-1
		[X0, X0 - 2 * U, Y0 - CHUNK, Y0 - CHUNK - 2 * U],
	];
	for (let t = 0; t < g.stats.terrainTris; t++) {
		const v = triAt(g, t);
		assert.equal(g.kind[t], 0);
		const nz = (v[3] - v[0]) * (v[7] - v[1]) - (v[4] - v[1]) * (v[6] - v[0]);
		assert.ok(nz > 0, `triangle ${t} faces down`);
		const cx = (v[0] + v[3] + v[6]) / 3;
		const cy = (v[1] + v[4] + v[7]) / 3;
		for (const [n, s, w, e] of holed) assert.ok(!(cx < n && cx > s && cy < w && cy > e), `triangle ${t} over a hole`);
	}
	assert.deepEqual(Array.from(g.areas), Array.from({ length: 256 }, (_, i) => 1000 + i));
});

test('liquids: MH2O quads by type, exists bitmap, vertex heights, layers and LiquidType kinds', async () => {
	const g = await tileGeometry(syntheticTile(), TILE);
	const { type, z } = g.liquid;
	const at = (row, col) => row * 128 + col;
	// chunk 5 (indexX 5), instance at x 2, y 3: the first quad exists, the second not
	assert.equal(type[at(3, 42)], 1);
	near(z[at(3, 42)], (10 + 11 + 10.5 + 11.5) / 4, 'water z');
	assert.equal(type[at(3, 43)], 0);
	// chunk 16 (indexY 1): magma without vertex data, at its min height
	for (let r = 8; r < 16; r++)
		for (let c = 0; c < 8; c++) {
			assert.equal(type[at(r, c)], 3);
			assert.equal(z[at(r, c)], 50);
		}
	// chunk 17: the PBR ocean (SoundBank 0, Flags 0x400) through LiquidObject -> LVF 2
	// (depth only: min height), over a lower slime layer; slime alone next to it
	assert.equal(type[at(8, 8)], 2);
	assert.equal(z[at(8, 8)], 5);
	assert.equal(type[at(8, 9)], 4);
	assert.equal(z[at(8, 9)], 3);
	let wet = 0;
	for (const t of type) if (t) wet++;
	assert.equal(wet, 1 + 64 + 2);
});

test('placements: WMO collision faces and groups, M2 collision, rotation and scale into world yards', async () => {
	const g = await tileGeometry(syntheticTile(), TILE);
	const base = g.stats.terrainTris;
	assert.equal(g.stats.wmo, 2);
	assert.equal(g.stats.wmoTris, 3);
	assert.equal(g.stats.m2, 6);
	assert.equal(g.stats.m2Tris, 3);
	assert.deepEqual(g.stats.missing, [414, 502]);
	assert.equal(g.kind.length, base + 6);

	// WMO: rot y 90, scale 2 -> model (x, y, z) to world (+2y, -2x, +2z)
	const [wx, wy, wz] = WMO_AT;
	const v0 = [wx, wy, wz];
	const v1 = [wx, wy - 2, wz];
	const v2 = [wx + 2, wy, wz];
	const v3 = [wx, wy, wz + 2];
	sameTri(triAt(g, base), [v0, v1, v2], 'indoor render face');
	sameTri(triAt(g, base + 1), [v0, v2, v3], 'indoor collision face');
	sameTri(triAt(g, base + 2), [v0, v1, v2], 'outdoor group');
	assert.deepEqual(Array.from(g.kind.subarray(base, base + 3)), [2, 2, 1]);

	// M2 model vertices (1, 2, 3), (0, 0, 0), (0, 1, 0):
	// rot 0 -> (-x, -y, z); rot x 90, scale 0.5 -> 0.5 (-z, -y, -x); rot z 90 -> (-x, z, y)
	const add = (o, d) => o.map((v, i) => v + d[i]);
	sameTri(triAt(g, base + 3), [add(M2_AT.a, [-1, -2, 3]), M2_AT.a, add(M2_AT.a, [0, -1, 0])], 'm2 yaw 0');
	sameTri(triAt(g, base + 4), [add(M2_AT.b, [-1.5, -1, -0.5]), M2_AT.b, add(M2_AT.b, [0, -0.5, 0])], 'm2 rot x');
	sameTri(triAt(g, base + 5), [add(M2_AT.c, [-1, 3, 2]), M2_AT.c, add(M2_AT.c, [0, 0, 1])], 'm2 rot z');
	assert.deepEqual(Array.from(g.kind.subarray(base + 3)), [3, 3, 3]);

	const placed = g.placements.map((p) => [p.type, p.uniqueId, p.count]);
	assert.deepEqual(placed, [
		['wmo', 7, 3],
		['wmo', 8, 0],
		['m2', 1, 1],
		['m2', 2, 1],
		['m2', 3, 1],
		['m2', 6, 0],
	]);
});

test('WMO liquids: MLIQ tiles and filled groups by LiquidType, placed, counter-clockwise from above', async () => {
	const g = await tileGeometry(syntheticTile(), TILE);
	// WMO 400: rot y 90, scale 2 -> model (x, y, z) to world (+2y, -2x, +2z)
	const w1 = ([x, y, z]) => [WMO_AT[0] + 2 * y, WMO_AT[1] - 2 * x, WMO_AT[2] + 2 * z];
	// WMO 450: rot 0 -> (-x, -y, z)
	const w2 = ([x, y, z]) => [WMO2_AT[0] - x, WMO2_AT[1] - y, WMO2_AT[2] + z];
	const mv = (i, j, z) => [10 + i * U, 20 + j * U, z];
	const quad = (a, b, c, d) => [a, b, c, a, c, d];
	const want = {
		1: quad(mv(0, 0, 1), mv(1, 0, 2), mv(1, 1, 5), mv(0, 1, 4)).map(w1),
		2: quad([5, 5, 1], [5 + U, 5, 1], [5 + U, 5 + U, 1], [5, 5 + U, 1]).map(w2),
		3: [...quad([0, 0, 7], [3, 0, 7], [3, 4, 7], [0, 4, 7]).map(w1), ...quad([0, 0, 2], [U, 0, 2], [U, U, 2], [0, U, 2]).map(w2)],
	};
	assert.deepEqual(
		g.wmoLiquid.map((l) => [l.type, l.tris.length / 9]),
		[
			[1, 2],
			[2, 2],
			[3, 4],
		],
	);
	assert.equal(g.stats.wmoLiquidTris, 8);
	for (const { type, tris } of g.wmoLiquid) {
		const pts = want[type];
		for (let t = 0; t < tris.length / 9; t++) {
			const v = Array.from(tris.subarray(t * 9, t * 9 + 9));
			sameTri(v, pts.slice(t * 3, t * 3 + 3), `liquid ${type} triangle ${t}`);
			const nz = (v[3] - v[0]) * (v[7] - v[1]) - (v[4] - v[1]) * (v[6] - v[0]);
			assert.ok(nz > 0, `liquid ${type} triangle ${t} faces down`);
		}
	}
	// Kept where they meet the tile: WMO 450 placed outside it adds none.
	const away = await tileGeometry(syntheticTile(), { ...TILE, col: COL + 2 });
	assert.deepEqual(away.wmoLiquid, []);
});

test('placements: model triangles are kept where they meet the tile grown by the margin', async () => {
	const g = await tileGeometry(syntheticTile(), TILE, { margin: 40 });
	assert.equal(g.stats.m2Tris, 4);
	const last = triAt(g, g.kind.length - 1);
	near(last[0], M2_AT.out[0] - 1, 'outside m2 wx');
	near(last[1], M2_AT.out[1] - 2, 'outside m2 wy');
});

test('a shared cache parses each model once across tiles', async () => {
	const casc = syntheticTile();
	const reads = new Map();
	const get = casc.get;
	casc.get = (fdid) => {
		reads.set(fdid, (reads.get(fdid) || 0) + 1);
		return get(fdid);
	};
	const cache = new Map();
	const a = await tileGeometry(casc, TILE, { cache });
	const b = await tileGeometry(casc, TILE, { cache });
	assert.deepEqual(Array.from(a.tris), Array.from(b.tris));
	assert.equal(reads.get(400), 1);
	assert.equal(reads.get(410), 1);
	assert.equal(reads.get(500), 1);
	assert.equal(reads.get(100), 2);
});

test('continentTiles: every MAID tile with a root ADT, from Map.csv WdtFileDataID', async () => {
	const maid = Buffer.alloc(64 * 64 * 32);
	const set = (col, row, ids) => ids.forEach((v, k) => maid.writeUInt32LE(v, (row * 64 + col) * 32 + k * 4));
	set(32, 48, [100, 101, 102, 103, 0, 0, 0, 104]);
	set(1, 2, [200, 0, 0, 0, 0, 0, 0, 0]);
	set(5, 5, [0, 0, 0, 0, 0, 0, 0, 300]); // a minimap block without terrain
	const casc = fakeCasc(new Map([[9000, Buffer.concat([chunk('MVER', u32(18)), chunk('MPHD', Buffer.alloc(32)), chunk('MAIN', Buffer.alloc(64 * 64 * 8)), chunk('MAID', maid)])]]), TABLES);
	assert.deepEqual(await continentTiles(casc, 0), [
		{ col: 1, row: 2, root: 200, obj0: 0, tex0: 0 },
		{ col: 32, row: 48, root: 100, obj0: 101, tex0: 103 },
	]);
	await assert.rejects(continentTiles(casc, 7), /Map 7/);
});

// Real Forever tiles: Azeroth 32_48 (Northshire, yaw-only WMOs) and 41_45
// (tilted and scaled WMOs). For every MODF the root bounding box, all 8
// corners through the placement transform, matches the MODF extents.
const REAL = [
	{ tile: '32_48', obj0: 778028 },
	{ tile: '41_45', obj0: 779738 },
];
const SOURCES = path.join(__dirname, '..', 'data', 'sources');

test('transform: WMO bounding boxes land on their MODF extents within 1 yd (real tiles)', async (t) => {
	let casc;
	try {
		casc = await openCasc({ sourcesDir: SOURCES, offline: true });
	} catch (err) {
		return t.skip(`no CASC cache: ${err.message}`);
	}
	const lacking = REAL.filter((r) => !casc.has(r.obj0)).map((r) => r.obj0);
	if (lacking.length) return t.skip(`CASC cache ${casc.build} lacks obj0 ${lacking.join(', ')} (node tools/polestar.js nav build)`);
	let checked = 0;
	for (const { tile, obj0 } of REAL) {
		const { wmo } = parsePlacements(chunks(await casc.get(obj0)));
		const roots = wmo.filter((p) => !casc.has(p.fdid)).map((p) => p.fdid);
		if (roots.length) return t.skip(`CASC cache ${casc.build} lacks WMO roots ${roots.join(', ')} of ${tile}`);
		assert.ok(wmo.length > 0, `${tile} has WMOs`);
		for (const p of wmo) {
			const got = transformBox(placementMatrix(p), parseWmoRoot(await casc.get(p.fdid)).box);
			const err = Math.max(...got.map((v, i) => Math.abs(v - p.extents[i])));
			assert.ok(err < 1, `${tile} WMO ${p.fdid} (uniqueId ${p.uniqueId}, rot ${p.rot.map((r) => r.toFixed(1))}, scale ${p.scale}): ${err.toFixed(3)} yd off`);
			checked++;
		}
	}
	assert.ok(checked >= 40);
});
