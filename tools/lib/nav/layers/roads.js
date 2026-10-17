'use strict';
// The roads layer: per grid column, how much of the ground the client paints
// with a road texture, from the terrain's own texture layers (tex0.js) and
// the reviewed allowlist of road textures (road-textures.json, names from the
// community listfile, listfile.js). One file per ADT tile,
// data/local/nav-layers/roads/<c>/<col>_<row>.bin: 65536 bytes, the weight
// 0-255 of column (i, j) at j * 256 + i (the grid's column order,
// tools/lib/nav/grid/format.js); a column is road from 128 (half the ground).
// index.json there: { build, continents: { [c]: ['col_row'] } } of the tiles
// with any road.
//
//   tileRoadWeights(parsedTex0, roadFdids) -> Uint8Array(65536)
//   roadWeights(c, col, row, dir?) -> Uint8Array(65536) | null (tile not built)
//   isRoadTexture(path) -> bool
//   buildRoads({ casc, sourcesDir, continents, dir, log }) -> per continent stats
//   roadAllowlist({ casc, sourcesDir, continents, reviewed, log }) -> { textures, shapes, used, unnamed }
//   shapeOf(weights) -> [{ area, weight, perimeter, width, length, elongation }]
//   roadByShape(components) -> { road, share, columns, components, medianWidth }
//   roadsPng(weights) -> PNG Buffer (the planner's Roads layer)
//
// Blending: a layer above the base weighs its alpha; the base what they
// leave (255 minus their sum, at least 0); weights are normalised by their
// sum, as the client's terrain shader blends (height bias left out). A
// column's weight is the mean of its 4 x 4 alpha texels (a chunk is 16 x 16
// columns and 64 x 64 texels).

const fs = require('node:fs');
const path = require('node:path');
const { ROOT } = require('../../paths');
const { parseTex0, MPHD_BIG_ALPHA } = require('./tex0');
const { chunks } = require('../geom/adt');
const { continentTiles, continentFlags } = require('../geom');
const { ensureListfile, scanListfile } = require('./listfile');

const ROADS_DIR = path.join(ROOT, 'data', 'local', 'nav-layers', 'roads');
const ALLOWLIST_FILE = path.join(__dirname, 'road-textures.json');
const COLUMNS = 65536;
const ROAD = 128;

// The allowlist (roadAllowlist): a tileset texture whose path names a road
// (NAMED_PATTERN) is a road texture; one whose path names ground that may be
// painted as a road (GROUND_PATTERN) is one when its shape is a road's; any
// other only when a person checked that its road-shaped strips lie on known
// roads (the allowlist's `reviewed`) and its shape is a road's.
const NAMED_PATTERN = /road|path|cobble|street|trail/;
const GROUND_PATTERN = /dirt|footprint|brick|gravel/;

// Road by shape: a road texture paints long thin strips, a ground texture
// broad patches. A component (8-connected columns where the texture weighs
// >= 128, within one tile) is a strip when it is long (its bounding box's
// diagonal >= LONG_YD), narrow (mean width, area over half its 4-side
// perimeter, <= NARROW columns: a w x L strip gives w L / (w + L), about w)
// and elongated (diagonal^2 / area >= ELONGATED columns: a strip's is about
// L / w, a patch's about 2, and a noisy or pinholed patch, narrow by its
// perimeter, stays near its own). A texture's shape is a road's when at
// least ROAD_SHARE of its weight lies in strips.
const LONG_YD = 60;
const NARROW = 6;
const ELONGATED = 10;
const ROAD_SHARE = 0.5;
const CELL = 1600 / 3 / 256;

// A texture path as the allowlist names it: lowercase, forward slashes, the
// `_s` (specular, what MDID names) and `_h` (height) variants as their base.
const textureKey = (p) => String(p).toLowerCase().replace(/\\/g, '/').replace(/_[sh]\.blp$/, '.blp');

const tilesetPath = (k) => k.startsWith('tileset/') && k.endsWith('.blp') && !/_[sh]\.blp$/.test(k);

// Per column weights (65536, j * 256 + i) -> the components (8-connected: a
// thin diagonal road is a staircase of corner-touching columns) where they
// are >= ROAD; the perimeter counts the 4 sides.
function shapeOf(w) {
	const label = new Int32Array(COLUMNS).fill(-1);
	const stack = new Int32Array(COLUMNS);
	const out = [];
	for (let s = 0; s < COLUMNS; s++) {
		if (w[s] < ROAD || label[s] >= 0) continue;
		const id = out.length;
		let top = 0;
		stack[top++] = s;
		label[s] = id;
		let area = 0;
		let weight = 0;
		let perimeter = 0;
		let i0 = 255, i1 = 0, j0 = 255, j1 = 0;
		while (top) {
			const k = stack[--top];
			const i = k & 255;
			const j = k >> 8;
			area++;
			weight += w[k];
			if (i < i0) i0 = i;
			if (i > i1) i1 = i;
			if (j < j0) j0 = j;
			if (j > j1) j1 = j;
			for (const [ok, n] of [[i > 0, k - 1], [i < 255, k + 1], [j > 0, k - 256], [j < 255, k + 256]]) {
				if (!ok || w[n] < ROAD) {
					perimeter++;
				} else if (label[n] < 0) {
					label[n] = id;
					stack[top++] = n;
				}
			}
			for (const [ok, n] of [[i > 0 && j > 0, k - 257], [i < 255 && j > 0, k - 255], [i > 0 && j < 255, k + 255], [i < 255 && j < 255, k + 257]]) {
				if (ok && w[n] >= ROAD && label[n] < 0) {
					label[n] = id;
					stack[top++] = n;
				}
			}
		}
		const diagonal = Math.hypot(i1 - i0 + 1, j1 - j0 + 1);
		out.push({ area, weight, perimeter, width: area / (perimeter / 2), length: diagonal * CELL, elongation: (diagonal * diagonal) / area });
	}
	return out;
}

// A texture's components (shapeOf, over every tile) -> its verdict and
// measures; medianWidth: the width half the texture's weight lies under.
function roadByShape(components) {
	let total = 0;
	let thin = 0;
	let columns = 0;
	for (const s of components) {
		total += s.weight;
		columns += s.area;
		if (s.length >= LONG_YD && s.width <= NARROW && s.elongation >= ELONGATED) thin += s.weight;
	}
	const byWidth = [...components].sort((a, b) => a.width - b.width);
	let medianWidth = null;
	for (let k = 0, sum = 0; k < byWidth.length && medianWidth === null; k++) if ((sum += byWidth[k].weight) >= total / 2) medianWidth = byWidth[k].width;
	const share = total ? thin / total : 0;
	return { road: share >= ROAD_SHARE, share, columns, components: components.length, medianWidth };
}

let allowed = null;
function allowlist() {
	if (!allowed) allowed = new Set(JSON.parse(fs.readFileSync(ALLOWLIST_FILE, 'utf8')).textures.map(textureKey));
	return allowed;
}

const isRoadTexture = (p) => allowlist().has(textureKey(p));

// Parsed tex0 (tex0.js) and the road textures' fdids -> per column weights.
function tileRoadWeights({ textures, chunks }, roadFdids) {
	const out = new Uint8Array(COLUMNS);
	const sum = new Float64Array(16 * 16);
	const road = new Float64Array(64 * 64);
	chunks.forEach(({ layers }, n) => {
		const isRoad = layers.map((l) => roadFdids.has(textures[l.tex]));
		if (!isRoad.some(Boolean)) return;
		for (let t = 0; t < 4096; t++) {
			let above = 0;
			let roadAbove = 0;
			for (let k = 1; k < layers.length; k++) {
				const a = layers[k].alpha ? layers[k].alpha[t] : 0;
				above += a;
				if (isRoad[k]) roadAbove += a;
			}
			const base = Math.max(0, 255 - above);
			const total = base + above;
			road[t] = total ? (255 * (roadAbove + (isRoad[0] ? base : 0))) / total : 0;
		}
		sum.fill(0);
		for (let y = 0; y < 64; y++) for (let x = 0; x < 64; x++) sum[(y >> 2) * 16 + (x >> 2)] += road[y * 64 + x];
		const x0 = (n % 16) * 16;
		const y0 = Math.floor(n / 16) * 16;
		for (let j = 0; j < 16; j++) for (let i = 0; i < 16; i++) out[(y0 + j) * 256 + x0 + i] = Math.round(sum[j * 16 + i] / 16);
	});
	return out;
}

const tileFile = (dir, c, col, row) => path.join(dir, String(c), `${col}_${row}.bin`);

function roadWeights(c, col, row, dir = ROADS_DIR) {
	const file = tileFile(dir, c, col, row);
	if (!fs.existsSync(file)) return null;
	const b = fs.readFileSync(file);
	if (b.length !== COLUMNS) throw new Error(`${file}: ${b.length} bytes, not ${COLUMNS}`);
	return new Uint8Array(b.buffer, b.byteOffset, b.length);
}

// fn(tile) over tiles, `limit` at a time.
async function eachLimited(list, limit, fn) {
	let next = 0;
	const run = async () => {
		while (next < list.length) await fn(list[next++]);
	};
	await Promise.all(Array.from({ length: Math.min(limit, list.length) }, run));
}

// The 4-bit fix per chunk (root MCNK without 0x8000), only read when the WDT has no big alpha.
async function fixOf(casc, tile, bigAlpha) {
	if (bigAlpha) return false;
	const flags = chunks(await casc.get(tile.root)).filter((x) => x.tag === 'MCNK').map((x) => x.data.readUInt32LE(0));
	return (n) => !(flags[n] & 0x8000);
}

async function buildRoads({ casc, sourcesDir, continents = [0, 1], dir = ROADS_DIR, offline = false, log = () => {} }) {
	const listfile = await ensureListfile({ sourcesDir, offline, log });
	const roadFdids = new Set();
	const names = new Map();
	await scanListfile(listfile, (fdid, p) => {
		if (isRoadTexture(p)) {
			roadFdids.add(fdid);
			names.set(fdid, p);
		}
	});
	const indexFile = path.join(dir, 'index.json');
	const index = fs.existsSync(indexFile) ? JSON.parse(fs.readFileSync(indexFile, 'utf8')) : { continents: {} };
	const stats = {};
	for (const c of continents) {
		const t0 = Date.now();
		const tiles = (await continentTiles(casc, c)).filter((t) => t.tex0);
		const bigAlpha = !!((await continentFlags(casc, c)) & MPHD_BIG_ALPHA);
		fs.mkdirSync(path.join(dir, String(c)), { recursive: true });
		const withRoad = [];
		const used = new Map(); // road fdid -> tiles using it
		let roadColumns = 0;
		let done = 0;
		await eachLimited(tiles, 8, async (t) => {
			const parsed = parseTex0(await casc.get(t.tex0), { bigAlpha, fix: await fixOf(casc, t, bigAlpha) });
			const w = tileRoadWeights(parsed, roadFdids);
			for (const f of new Set(parsed.textures)) if (roadFdids.has(f)) used.set(f, (used.get(f) || 0) + 1);
			let n = 0;
			for (let k = 0; k < COLUMNS; k++) if (w[k] >= ROAD) n++;
			roadColumns += n;
			if (w.some((v) => v)) withRoad.push(`${t.col}_${t.row}`);
			const file = tileFile(dir, c, t.col, t.row);
			fs.writeFileSync(`${file}.tmp`, w);
			fs.renameSync(`${file}.tmp`, file);
			if (++done % 200 === 0) log(`roads ${c}: ${done}/${tiles.length} tiles`);
		});
		withRoad.sort((a, b) => a.localeCompare(b, 'en', { numeric: true }));
		index.build = casc.build;
		index.continents[c] = withRoad;
		stats[c] = {
			tiles: tiles.length, roadTiles: withRoad.length, roadColumns, bigAlpha, seconds: +((Date.now() - t0) / 1000).toFixed(1),
			textures: [...used].sort((a, b) => b[1] - a[1]).map(([f, n]) => ({ fdid: f, path: names.get(f), tiles: n })),
		};
		fs.writeFileSync(indexFile, JSON.stringify(index) + '\n');
	}
	return stats;
}

// The allowlist from every diffuse texture the continents' tex0 files use
// (named by the listfile), each measured by shape on those continents:
// NAMED_PATTERN by name ('name'), GROUND_PATTERN and `reviewed` by shape
// ('shape', 'review'); any other road-shaped texture is listed for review.
// -> { textures: [base path] (sorted), shapes: [{ texture, tiles, kind ('name' | 'ground' | 'review' | 'other'), road, ...roadByShape }], used: Map path -> tiles, unnamed: [fdid] }
async function roadAllowlist({ casc, sourcesDir, continents = [0, 1], reviewed = [], offline = false, log = () => {} }) {
	const counts = new Map(); // fdid -> tiles
	const lists = [];
	for (const c of continents) {
		const tiles = (await continentTiles(casc, c)).filter((t) => t.tex0);
		lists.push({ c, tiles, bigAlpha: !!((await continentFlags(casc, c)) & MPHD_BIG_ALPHA) });
		await eachLimited(tiles, 8, async (t) => {
			const mdid = chunks(await casc.get(t.tex0)).find((x) => x.tag === 'MDID');
			if (!mdid) return;
			const seen = new Set();
			for (let o = 0; o + 4 <= mdid.data.length; o += 4) seen.add(mdid.data.readUInt32LE(o));
			for (const f of seen) counts.set(f, (counts.get(f) || 0) + 1);
		});
		log(`allowlist: ${c} read (${tiles.length} tiles)`);
	}
	const listfile = await ensureListfile({ sourcesDir, offline, log });
	const used = new Map(); // base path -> tiles
	const fdidsOf = new Map(); // tileset base path -> Set of fdids
	const named = new Set();
	await scanListfile(listfile, (fdid, p) => {
		if (!counts.has(fdid)) return;
		named.add(fdid);
		const key = textureKey(p);
		used.set(key, (used.get(key) || 0) + counts.get(fdid));
		if (tilesetPath(key)) {
			if (!fdidsOf.has(key)) fdidsOf.set(key, new Set());
			fdidsOf.get(key).add(fdid);
		}
	});
	const pathOf = new Map();
	for (const [p, set] of fdidsOf) for (const f of set) pathOf.set(f, p);
	const parts = new Map([...fdidsOf.keys()].map((p) => [p, []])); // path -> components
	for (const { c, tiles, bigAlpha } of lists) {
		await eachLimited(tiles, 8, async (t) => {
			const parsed = parseTex0(await casc.get(t.tex0), { bigAlpha, fix: await fixOf(casc, t, bigAlpha) });
			const here = new Set(parsed.textures.filter((f) => pathOf.has(f)).map((f) => pathOf.get(f)));
			for (const p of here) for (const s of shapeOf(tileRoadWeights(parsed, fdidsOf.get(p)))) parts.get(p).push(s);
		});
		log(`allowlist: ${c} measured`);
	}
	const review = new Set(reviewed.map(textureKey));
	const shapes = [...parts].map(([texture, comps]) => {
		const s = roadByShape(comps);
		const name = texture.slice('tileset/'.length);
		const kind = NAMED_PATTERN.test(name) ? 'name' : GROUND_PATTERN.test(name) ? 'ground' : review.has(texture) ? 'review' : 'other';
		return { texture, tiles: used.get(texture), kind, ...s, road: kind === 'name' || ((kind === 'ground' || kind === 'review') && s.road), shapeRoad: s.road };
	}).sort((a, b) => a.texture.localeCompare(b.texture));
	const textures = shapes.filter((s) => s.road).map((s) => s.texture);
	return { textures, shapes, used, unnamed: [...counts.keys()].filter((f) => !named.has(f)) };
}

// Road weights -> a 256 x 256 RGBA PNG: the page's success green
// (docs/DESIGN.md), strong on road columns (>= 128), faint below.
function roadsPng(w) {
	const { encodePng } = require('../../planner/art/png');
	const px = new Uint8Array(COLUMNS * 4);
	for (let k = 0; k < COLUMNS; k++) {
		if (!w[k]) continue;
		px[k * 4] = 0x6b;
		px[k * 4 + 1] = 0xd9;
		px[k * 4 + 2] = 0x99;
		px[k * 4 + 3] = w[k] >= ROAD ? 200 : Math.round(w[k] * 0.6);
	}
	return encodePng(px, 256, 256);
}

module.exports = { tileRoadWeights, roadWeights, isRoadTexture, textureKey, shapeOf, roadByShape, buildRoads, roadAllowlist, roadsPng, ROADS_DIR, ALLOWLIST_FILE, NAMED_PATTERN, GROUND_PATTERN, LONG_YD, NARROW, ELONGATED, ROAD_SHARE, ROAD };
