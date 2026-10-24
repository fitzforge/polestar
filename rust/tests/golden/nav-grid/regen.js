'use strict';
// Regenerates rust/tests/golden/nav-grid (README.md): a synthetic walking grid of four tiles of continent 0
// built by the JS grid builder (tools/lib/nav/grid/build.js buildGrid, worker.js), its per-tile stage files
// (tileGeometry-shaped geometry, surfaces), the synthetic layers and data the router reads, and router.js
// prepare's walk graphs. No client file is read: the geometry is tests/helpers/navscene.js scenes.
//
//   node regen.js <js root> <out dir>
//
// <js root>: a scratch copy of the repository (tools/, tests/helpers/navscene.js) whose data/ this script
// owns: it writes data/forever/zones.json, data/sources/wago/<build>/AreaTable.csv, data/local/nav-layers
// (hubs.json, a roads layer) and builds data/local/nav4 there. Never point it at a working checkout.
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');

const [jsRoot, outArg] = process.argv.slice(2);
if (!jsRoot || !outArg) throw new Error('usage: node regen.js <js root> <out dir>');
const ROOT = path.resolve(jsRoot);
const OUT = path.resolve(outArg);
process.env.POLESTAR_GRID = path.join(ROOT, 'data', 'local', 'nav4');
const { Scene, ADT, QUAD } = require(path.join(ROOT, 'tests/helpers/navscene'));
const { buildGrid } = require(path.join(ROOT, 'tools/lib/nav/grid/build'));
const { runJob } = require(path.join(ROOT, 'tools/lib/nav/grid/worker'));
const { TILE_CELLS, CELL } = require(path.join(ROOT, 'tools/lib/nav/grid/format'));

const C = 0;
const BUILD = '1.60.0.99999'; // the synthetic AreaTable's build folder name
const TILES = [[32, 32], [33, 32], [32, 33], [33, 33]];
const GRID = path.join(ROOT, 'data', 'local', 'nav4');
const LAYERS = path.join(ROOT, 'data', 'local', 'nav-layers');

// Global coordinates: E east, S south from the north-west corner of tile (32, 32); wx = -S, wy = -E.
const lakeDepth = (E, S) => {
	const d = Math.hypot(E - 760, S - 280);
	return d < 110 ? 9 * (1 - d / 110) : 0;
};
function height(E, S) {
	let h = 0;
	if (E > ADT) h += 4 * Math.sin((E - ADT) / 90) * Math.sin(S / 70);
	if (S > ADT) h += 3 * Math.sin((S - ADT) / 55) * Math.cos(E / 140);
	h -= lakeDepth(E, S);
	// A plateau in the south-east, sheer on its west and north, a ramp up from the west.
	if (E > 860 && S > 860) h += 30;
	else if (S > 880 && S < 940 && E > 760 && E <= 860) h += (30 * (E - 760)) / 100;
	return h;
}
// Areas by chunk centre: west Westvale (its mill a sub-area), a dangerous ridge band, east Eastmarsh, the
// south-east Highmoor.
function areaOf(E, S) {
	if (E < 330) return E < 160 && S < 260 ? 9011 : 9001;
	if (E < 600) return S > 700 ? 9021 : 9002;
	return S > 760 ? 9004 : 9003;
}
const AREAS = [
	{ ID: 9001, AreaName_lang: 'Westvale', ContinentID: 0, ParentAreaID: 0 },
	{ ID: 9011, AreaName_lang: 'Westvale Mill', ContinentID: 0, ParentAreaID: 9001 },
	{ ID: 9002, AreaName_lang: 'Mid Ridge', ContinentID: 0, ParentAreaID: 0 },
	{ ID: 9021, AreaName_lang: 'Ridge Hollow', ContinentID: 0, ParentAreaID: 9002 },
	{ ID: 9003, AreaName_lang: 'Eastmarsh', ContinentID: 0, ParentAreaID: 0 },
	{ ID: 9004, AreaName_lang: 'Highmoor', ContinentID: 0, ParentAreaID: 0 },
	{ ID: 9099, AreaName_lang: 'Nowhere', ContinentID: 1, ParentAreaID: 0 },
];
const ZONES = {
	1901: { id: 1901, name: 'Westvale', type: 3, areaId: 9001 },
	1902: { id: 1902, name: 'Mid Ridge', type: 3, areaId: 9002 },
	1903: { id: 1903, name: 'Eastmarsh', type: 3, areaId: 9003 },
	1904: { id: 1904, name: 'Highmoor', type: 3, areaId: 9004 },
	1900: { id: 1900, name: 'Synthetic Continent', type: 2 },
};

function scene(col, row) {
	const e0 = (col - 32) * ADT;
	const s0 = (row - 32) * ADT;
	const s = new Scene({
		c: C, col, row,
		height: (x, y) => height(e0 + x, s0 + y),
		hole: (x, y) => col === 32 && row === 33 && x > 400 && x < 430 && y > 400 && y < 430,
		areas: (x, y) => areaOf(e0 + x, s0 + y),
	});
	const extra = { wmoLiquid: [], openings: [] };
	if (col === 32 && row === 32) {
		// A sheer mesa (top 60) with an elevator at its east edge under a shaft roof at 75.
		s.box(60, 300, -1, 200, 450, 60);
		s.floor(198, 369, 210, 381, 75, 1);
		// A two-storey house: walls with doorways, an indoor floor, a ramp to an upper floor at 6.
		s.floor(300, 60, 460, 200, 0.2, 2);
		s.box(300, 60, 0.2, 460, 63, 14).box(300, 197, 0.2, 380, 200, 14).box(400, 197, 0.2, 460, 200, 14);
		s.box(300, 60, 0.2, 303, 120, 14).box(300, 140, 0.2, 303, 200, 14).box(457, 60, 0.2, 460, 200, 14);
		s.quad([320, 70, 0.2], [360, 70, 6], [360, 90, 6], [320, 90, 0.2], 2);
		s.floor(360, 70, 450, 190, 6, 2);
		s.floor(300, 60, 460, 200, 14, 2);
	}
	if (col === 33 && row === 32) {
		// The lake (fresh water over the depression, deep in the middle), an ocean inlet, a magma pool.
		s.water(120, 170, 330, 390, -1.5, 1, false);
		s.water(200, 250, 260, 310, -1.5, 1, true);
		s.water(20, 470, 90, 520, 1, 2, false);
		s.water(450, 20, 480, 50, 2, 3, false);
		// A WMO pool: a basin floor at 3 under WMO water at 5.
		s.floor(380, 80, 440, 130, 3, 2);
		const pool = new Scene({ c: C, col, row });
		pool.tris = [];
		pool.kind = [];
		pool.floor(380, 80, 440, 130, 5, 0);
		extra.wmoLiquid.push({ type: 1, tris: Float32Array.from(pool.tris) });
		// A wall with a reviewed opening cut through it.
		s.box(300, 400, -1, 304, 520, 15);
		const w = (x, y) => [s.north - y, s.west - x];
		extra.openings.push({ id: 'synthetic-door', pts: [w(298, 450), w(306, 450), w(306, 462), w(298, 462)], zlo: -1, zhi: 8 });
	}
	if (col === 32 && row === 33) {
		// A zigzag maze.
		for (let k = 0; k < 4; k++) {
			const x = 220 + k * 50;
			if (k % 2 === 0) s.box(x, 20, -10, x + 4, 300, 12);
			else s.box(x, 80, -10, x + 4, 360, 12);
		}
		// A model plateau (top 20) with a ramp up from the east: falls off its other sides.
		s.box(50, 50, -10, 150, 150, 20);
		s.quad([150, 90, 20], [230, 90, -3], [230, 110, -3], [150, 110, 20], 1);
		// An enclosure nothing reaches.
		s.box(60, 400, -10, 160, 404, 40).box(60, 496, -10, 160, 500, 40).box(60, 400, -10, 64, 500, 40).box(156, 400, -10, 160, 500, 40);
	}
	if (col === 33 && row === 33) {
		// A bridge over the plateau's cliff foot and a pillar field.
		s.floor(250, 400, 330, 412, 12, 1);
		for (let k = 0; k < 6; k++) s.box(100 + 30 * k, 100, -10, 104 + 30 * k, 104, 10);
	}
	const g = s.geom();
	g.wmoLiquid = extra.wmoLiquid;
	g.openings = extra.openings;
	return { s, g };
}

// tileGeometry's shape, serialised as forge-navbuild/tests/common.rs reads it.
function serialise(g) {
	const parts = [];
	const u32 = (v) => { const b = Buffer.alloc(4); b.writeUInt32LE(v >>> 0); parts.push(b); };
	const i32 = (v) => { const b = Buffer.alloc(4); b.writeInt32LE(v); parts.push(b); };
	const f64 = (v) => { const b = Buffer.alloc(8); b.writeDoubleLE(v); parts.push(b); };
	const arr = (a) => parts.push(Buffer.from(a.buffer, a.byteOffset, a.byteLength));
	u32(g.c); i32(g.col); i32(g.row);
	u32(g.kind.length); arr(g.tris); arr(g.kind);
	u32(g.areas.length); arr(g.areas);
	const l = g.liquid;
	u32(l ? l.type.length : 0);
	if (l) { arr(l.type); arr(l.z); arr(l.deep); }
	u32(g.wmoLiquid.length);
	for (const w of g.wmoLiquid) { u32(w.type); u32(w.tris.length); arr(w.tris); }
	u32(g.openings.length);
	for (const o of g.openings) {
		const id = Buffer.from(o.id, 'utf8'); u32(id.length); parts.push(id);
		for (const [x, y] of o.pts) { f64(x); f64(y); }
		f64(o.zlo); f64(o.zhi);
	}
	return zlib.gzipSync(Buffer.concat(parts), { level: 9 });
}

function writeData() {
	const data = path.join(ROOT, 'data');
	fs.rmSync(data, { recursive: true, force: true });
	fs.mkdirSync(path.join(data, 'forever'), { recursive: true });
	fs.writeFileSync(path.join(data, 'forever', 'zones.json'), `${JSON.stringify(ZONES, null, '\t')}\n`);
	const wago = path.join(data, 'sources', 'wago', BUILD);
	fs.mkdirSync(wago, { recursive: true });
	const cols = ['ID', 'AreaName_lang', 'ContinentID', 'ParentAreaID'];
	fs.writeFileSync(path.join(wago, 'AreaTable.csv'), `${cols.join(',')}\n${AREAS.map((a) => cols.map((c) => a[c]).join(',')).join('\n')}\n`);
	// Hubs: an Alliance keep in Westvale, a Horde camp in Eastmarsh (world x = -S, y = -E).
	const hubs = {
		0: [
			{ id: 1, name: 'Westvale Keep', areaId: 9011, side: 'Alliance', disks: [[-130, -90, 45], [-180, -150, 25]] },
			{ id: 2, name: 'Eastmarsh Camp', areaId: 9003, side: 'Horde', disks: [[-470, -900, 60]] },
		],
	};
	fs.mkdirSync(LAYERS, { recursive: true });
	fs.writeFileSync(path.join(LAYERS, 'hubs.json'), `${JSON.stringify(hubs)}\n`);
	// The roads layer: weights per column, a road east-west along S = 100 (strong, a weak stretch, a
	// gap the road mask bridges) and one south along E = 640.
	const roads = path.join(LAYERS, 'roads');
	fs.mkdirSync(path.join(roads, String(C)), { recursive: true });
	fs.writeFileSync(path.join(roads, 'index.json'), `${JSON.stringify({ synthetic: true, build: BUILD })}\n`);
	for (const [col, row] of TILES) {
		const w = new Uint8Array(TILE_CELLS * TILE_CELLS);
		let any = false;
		for (let j = 0; j < TILE_CELLS; j++) {
			for (let i = 0; i < TILE_CELLS; i++) {
				const E = (col - 32) * ADT + (i + 0.5) * CELL;
				const S = (row - 32) * ADT + (j + 0.5) * CELL;
				let v = 0;
				if (Math.abs(S - 100 - 10 * Math.sin(E / 60)) < 3.2 && E > 15 && E < 1050 && !(E > 500 && E < 530)) v = E > 380 && E < 450 ? 60 : 200;
				if (Math.abs(E - 640) < 2.2 && S > 100 && S < 820) v = Math.max(v, 170);
				if (v) {
					w[j * TILE_CELLS + i] = v;
					any = true;
				}
			}
		}
		if (any) fs.writeFileSync(path.join(roads, String(C), `${col}_${row}.bin`), w);
	}
	return { hubs };
}

(async () => {
	writeData();
	fs.rmSync(GRID, { recursive: true, force: true });
	fs.rmSync(OUT, { recursive: true, force: true });
	const geoms = new Map();
	const scenes = new Map();
	for (const [col, row] of TILES) {
		const { s, g } = scene(col, row);
		geoms.set(`${col}_${row}`, g);
		scenes.set(`${col}_${row}`, s);
	}
	// Stage files: the geometry and the worker's surfaces op on it (surf.gz, walls.gz).
	const geomDir = path.join(OUT, 'geom', String(C));
	const surfDir = path.join(OUT, 'surf', String(C));
	fs.mkdirSync(geomDir, { recursive: true });
	for (const [key, g] of geoms) {
		fs.writeFileSync(path.join(geomDir, `${key}.geom.gz`), serialise(g));
		const [col, row] = key.split('_').map(Number);
		await runJob({ op: 'surfaces', dir: surfDir, c: C, col, row, geom: g });
	}
	// The grid: the lift spawn (the mesa's elevator, tile 32_32) as buildNav's liftPoints give it.
	const s0 = scenes.get('32_32');
	const spawn = s0.world(203, 375);
	await buildGrid({
		outDir: GRID, workers: 0,
		continents: [{ c: C, name: 'Synthetic', tiles: TILES.map(([col, row]) => ({ col, row })) }],
		geometryJob: (c, t) => ({ geom: geoms.get(`${t.col}_${t.row}`) }),
		liftPoints: [{ ...spawn, name: 'Mesa Elevator', id: 1, rise: 60.4 }],
	});
	// The router's road masks, walk graphs (none, Alliance, Horde) and zone mix.
	const router = require(path.join(ROOT, 'tools/lib/nav/router'));
	const prep = await router.prepare(GRID, [C], { workers: 1, log: console.log });
	console.log(prep.map((p) => `${p.faction}: ${path.basename(p.file)}`).join('\n'));
	fs.cpSync(GRID, path.join(OUT, 'nav4'), { recursive: true });
	fs.cpSync(path.join(LAYERS, 'hubs.json'), path.join(OUT, 'nav-layers', 'hubs.json'));
	fs.cpSync(path.join(ROOT, 'data', 'forever', 'zones.json'), path.join(OUT, 'data', 'zones.json'));
	fs.cpSync(path.join(ROOT, 'data', 'sources', 'wago', BUILD, 'AreaTable.csv'), path.join(OUT, 'data', 'AreaTable.csv'));
	fs.writeFileSync(path.join(OUT, 'data', 'build.txt'), `${BUILD}\n`);
	const lifts = JSON.parse(fs.readFileSync(path.join(GRID, 'lifts.json'), 'utf8'));
	console.log(`grid: ${TILES.length} tiles, lifts ${JSON.stringify(lifts)}`);
})().catch((e) => {
	console.error(e);
	process.exit(1);
});
