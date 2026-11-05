'use strict';
// `planner art`: the planner's local map art from the Forever client's files
// (wago.tools, cached), written under data/local/planner/art/:
//
//   index.json                       what exists (spec: docs/ARCHITECTURE.md, "Route planner")
//   tiles/<c>/<L>/<tx>_<ty>.bc1.gz   terrain pyramid: gzip of BC1 512 x 512 + mips to 4 x 4
//   zones/<uiMapID>.png              each zone's painted world map, every overlay drawn
//                                    (UiMap types 3 zone and 6 orphan: Forever's
//                                    Darkspear Islands, the battlegrounds)
//
// Terrain: every continent map-frames.json names (`c`) that Map.csv gives a
// WDT; the WDT's MAID names each ADT tile's minimap block. Level 0 is one
// block (its own DXT1 data); level L tile (tx, ty) is the 2 x 2 box
// downsample of its four level L-1 children, the sea colour where none
// exists, up to level 6 (the whole 64 x 64 grid). Tiles are built depth
// first; the encoding runs in worker threads, higher levels first, so few
// child images wait in memory.
//
// Incremental: a present tile or zone file is kept unless `force`; a tile is
// rebuilt when it or any tile under it is missing (an existing child is then
// read back from its file). A block or zone that fails is a warning.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const zlib = require('node:zlib');
const { Worker } = require('node:worker_threads');
const { ROOT, SOURCES, DATA } = require('../../paths');
const { cachedTable, PRODUCTS } = require('../../data/wago');
const { buildOverlays } = require('../../maps/overlays');
const { openCasc, fetchRetry, checkBuild } = require('./casc');
const { readMaid, GRID } = require('./wdt');
const { decodeBlp, readBlp } = require('./blp');
const { encodePng } = require('./png');
const { runJob } = require('./worker');
const { TILE, CHAIN_LEVELS, flatColour } = require('./bc1');

const SCHEMA = 1;
const MAX_LEVEL = 6;
// The default sea: the minimap's own deep-ocean colour (Eastern Kingdoms and
// Kalimdor), so filled tiles meet the blocks seamlessly. A continent whose
// uniform blocks mostly share another colour (Forever's black-sea maps) uses
// that one (index continents[c].sea).
const SEA = [8, 16, 16];
const SEA_BLOCKS = 8;
const ADT_YARDS = 1600 / 3;
const ZONE_TYPES = new Set([3, 6]); // UiMap types drawn as zone art: zone, orphan
const TABLES = ['Map', 'UiMap', 'UiMapXMapArt', 'UiMapArt', 'UiMapArtStyleLayer', 'UiMapArtTile', 'WorldMapOverlay', 'WorldMapOverlayTile'];

const num = Number;

// The wago.tools client tables of `build` -> { [table]: rows }, fetching the
// ones not cached under <sources>/wago/<build>/.
async function loadTables({ sourcesDir, build, offline, fetchImpl, log }) {
	checkBuild(build, 'wago tables');
	const get = async (url) => (await fetchRetry(url, { fetchImpl, timeout: 600000 })).toString('utf8');
	const tables = {};
	for (const t of TABLES) tables[t] = await cachedTable({ sourcesDir, build, table: t, offline, get, log });
	return tables;
}

// Runs worker jobs on `size` threads (0: inline), highest level first. A
// worker that dies fails its job and is replaced.
class Pool {
	constructor(size) {
		this.queues = Array.from({ length: MAX_LEVEL + 1 }, () => []);
		this.idle = [];
		this.busy = new Map(); // worker -> its task
		this.workers = new Set();
		this.inline = size <= 0;
		this.closing = false;
		for (let i = 0; i < size; i++) this.spawn();
	}

	spawn() {
		const w = new Worker(path.join(__dirname, 'worker.js'));
		w.on('message', ({ out, error }) => {
			const t = this.busy.get(w);
			this.busy.delete(w);
			if (error) t.reject(new Error(error));
			else t.resolve(out);
			this.idle.push(w);
			this.pump();
		});
		w.on('error', (err) => {
			const t = this.busy.get(w);
			this.busy.delete(w);
			this.workers.delete(w);
			this.idle = this.idle.filter((x) => x !== w);
			if (t) t.reject(err);
			if (!this.closing) {
				this.spawn();
				this.pump();
			}
		});
		this.workers.add(w);
		this.idle.push(w);
	}

	run(job, level, transfer = []) {
		return new Promise((resolve, reject) => {
			this.queues[level].push({ job, transfer, resolve, reject });
			this.pump();
		});
	}

	take() {
		for (let L = MAX_LEVEL; L >= 0; L--) if (this.queues[L].length) return this.queues[L].shift();
		return null;
	}

	pump() {
		if (this.inline) {
			if (this.running) return;
			this.running = true;
			// Inline: one job per macrotask so the caller's awaits interleave.
			setImmediate(() => {
				this.running = false;
				const t = this.take();
				if (!t) return;
				try {
					t.resolve(runJob(t.job));
				} catch (err) {
					t.reject(err);
				}
				this.pump();
			});
			return;
		}
		while (this.idle.length) {
			const t = this.take();
			if (!t) return;
			const w = this.idle.pop();
			this.busy.set(w, t);
			w.postMessage({ job: t.job }, t.transfer);
		}
	}

	close() {
		this.closing = true;
		return Promise.all([...this.workers].map((w) => w.terminate()));
	}
}

function defaultWorkers() {
	return Math.max(1, Math.min(15, (os.availableParallelism ? os.availableParallelism() : os.cpus().length) - 1));
}

// The continents to draw: every `c` of map-frames.json with a WDT in Map.csv.
function continentRows(frames, mapRows) {
	const cs = new Set();
	for (const set of ['era', 'forever']) for (const f of Object.values(frames[set] || {})) cs.add(num(f.c));
	const byId = new Map(mapRows.map((r) => [num(r.ID), r]));
	return [...cs]
		.sort((a, b) => a - b)
		.map((c) => byId.get(c))
		.filter((r) => r && num(r.WdtFileDataID) > 0);
}

// The colour at least SEA_BLOCKS of a continent's uniform minimap blocks
// share (the most common), else SEA. items: [{ file }] (a built level-0 tile)
// or [{ blp }] (a cached block); unreadable ones are left to the tile jobs to
// report.
function seaOf(items) {
	const count = new Map();
	for (const { file, blp } of items) {
		let colour = null;
		try {
			if (file) colour = flatColour(zlib.gunzipSync(fs.readFileSync(file)), TILE, TILE);
			else {
				const b = readBlp(fs.readFileSync(blp));
				if (b.format === 'dxt1' && b.alphaDepth === 0) colour = flatColour(b.mips[0].raw, b.mips[0].width, b.mips[0].height);
			}
		} catch {
			continue;
		}
		if (colour) count.set(colour.join(','), (count.get(colour.join(',')) || 0) + 1);
	}
	const [best, n] = [...count].sort((a, b) => b[1] - a[1])[0] || [null, 0];
	return n >= SEA_BLOCKS ? best.split(',').map(Number) : SEA;
}

async function buildContinent({ row, prev, casc, pool, outDir, force, log, warnings }) {
	const c = num(row.ID);
	const name = row.MapName_lang;
	const tag = `${name} (${c})`;
	let blocks;
	try {
		blocks = readMaid(await casc.get(num(row.WdtFileDataID)));
	} catch (err) {
		warnings.push(`${tag}: WDT ${row.WdtFileDataID}: ${err.message}`);
		return null;
	}
	const tileFile = (L, tx, ty) => path.join(outDir, 'tiles', String(c), String(L), `${tx}_${ty}.bc1.gz`);
	const key = (tx, ty) => `${tx}_${ty}`;

	// Blocks whose level-0 tile is missing are fetched first.
	const failed = new Set();
	const fetch = blocks.filter((b) => force || !fs.existsSync(tileFile(0, b.col, b.row)));
	const toFetch = fetch.filter((b) => !casc.has(b.fdid)).length;
	log(`${tag}: ${blocks.length} blocks, ${fetch.length} to build, ${toFetch} to download`);
	let done = 0;
	await Promise.all(
		fetch.map((b) =>
			casc
				.ensure(b.fdid)
				.catch((err) => {
					failed.add(key(b.col, b.row));
					warnings.push(`${tag}: block ${b.col},${b.row} (${b.fdid}): ${err.message}`);
				})
				.finally(() => {
					if (++done % 200 === 0 || done === fetch.length) log(`${tag}: ${done}/${fetch.length} blocks ready`);
				}),
		),
	);
	const fdidOf = new Map(blocks.filter((b) => !failed.has(key(b.col, b.row))).map((b) => [key(b.col, b.row), b.fdid]));

	// Candidate tiles per level and which need (re)building.
	const levels = [new Map([...fdidOf.keys()].map((k) => [k, k.split('_').map(Number)]))];
	for (let L = 1; L <= MAX_LEVEL; L++) {
		const m = new Map();
		for (const [tx, ty] of levels[L - 1].values()) m.set(key(tx >> 1, ty >> 1), [tx >> 1, ty >> 1]);
		levels.push(m);
	}
	const children = (L, tx, ty) => {
		const out = [];
		for (let dy = 0; dy < 2; dy++) for (let dx = 0; dx < 2; dx++) if (levels[L - 1].has(key(2 * tx + dx, 2 * ty + dy))) out.push([2 * tx + dx, 2 * ty + dy, dx, dy]);
		return out;
	};
	const dirty = levels.map(() => new Set());
	for (let L = 0; L <= MAX_LEVEL; L++) {
		for (const [k, [tx, ty]] of levels[L]) {
			if (force || !fs.existsSync(tileFile(L, tx, ty)) || (L > 0 && children(L, tx, ty).some(([cx, cy]) => dirty[L - 1].has(key(cx, cy))))) dirty[L].add(k);
		}
	}
	for (let L = 0; L <= MAX_LEVEL; L++) if (dirty[L].size) fs.mkdirSync(path.dirname(tileFile(L, 0, 0)), { recursive: true });
	const sea =
		!dirty[0].size && prev && Array.isArray(prev.sea)
			? prev.sea
			: seaOf([...levels[0].entries()].map(([k, [tx, ty]]) => (dirty[0].has(k) ? { blp: casc.path(fdidOf.get(k)) } : { file: tileFile(0, tx, ty) })));
	const written = levels.map(() => 0);
	const total = levels.reduce((n, m) => n + m.size, 0);
	let finished = 0;
	const tick = () => {
		if (++finished % 250 === 0) log(`${tag}: ${finished} tiles encoded`);
	};

	// -> the tile's 256 x 256 downsample (null when nothing under it could be built).
	const node = async (L, tx, ty, half) => {
		const file = tileFile(L, tx, ty);
		const at = `${tag}: tile ${L}/${tx}_${ty}`;
		try {
			if (!dirty[L].has(key(tx, ty))) return (await pool.run({ op: 'file', file }, L)).half;
			if (L === 0) {
				const out = await pool.run({ op: 'block', blp: casc.path(fdidOf.get(key(tx, ty))), file, sea, half }, 0);
				written[0]++;
				tick();
				return out.half;
			}
			const kids = children(L, tx, ty);
			const halves = await Promise.all(kids.map(([cx, cy]) => node(L - 1, cx, cy, true)));
			if (!halves.some(Boolean)) return null;
			const rgba = new Uint8Array(TILE * TILE * 4);
			for (let i = 0; i < rgba.length; i += 4) rgba.set(sea, i), (rgba[i + 3] = 255);
			const H = TILE / 2;
			kids.forEach(([, , dx, dy], i) => {
				const h = halves[i];
				if (!h) return;
				for (let y = 0; y < H; y++) rgba.set(h.subarray(y * H * 4, (y + 1) * H * 4), ((dy * H + y) * TILE + dx * H) * 4);
			});
			const out = await pool.run({ op: 'tile', rgba, file, half }, L, [rgba.buffer]);
			written[L]++;
			tick();
			return out.half;
		} catch (err) {
			warnings.push(`${at}: ${err.message}`);
			return null;
		}
	};
	const t0 = Date.now();
	await Promise.all([...levels[MAX_LEVEL].values()].filter(([tx, ty]) => dirty[MAX_LEVEL].has(key(tx, ty))).map(([tx, ty]) => node(MAX_LEVEL, tx, ty, false)));

	const index = {};
	const counts = [];
	for (let L = 0; L <= MAX_LEVEL; L++) {
		const list = [...levels[L].values()].filter(([tx, ty]) => fs.existsSync(tileFile(L, tx, ty))).sort((a, b) => a[1] - b[1] || a[0] - b[0]);
		index[L] = list;
		counts.push(`L${L} ${list.length}${written[L] ? ` (+${written[L]})` : ''}`);
	}
	log(`${tag}: ${counts.join(', ')} of ${total} tiles; sea ${sea}; ${((Date.now() - t0) / 1000).toFixed(1)} s`);
	const cols = blocks.map((b) => b.col), rows = blocks.map((b) => b.row);
	return {
		name,
		directory: row.Directory,
		maxLevel: MAX_LEVEL,
		bounds: { minCol: Math.min(...cols), maxCol: Math.max(...cols), minRow: Math.min(...rows), maxRow: Math.max(...rows) },
		sea,
		levels: index,
	};
}

// Draws img (iw x ih) as a map tile at (x, y) of a W x H canvas: pw x ph
// canvas pixels sampling the image's top-left pw/fw x ph/fh (the client's
// texcoords for a tile file of nominal size fw x fh), alpha-blended.
function drawTile(canvas, W, H, img, iw, ih, x, y, pw, ph, fw, fh) {
	for (let py = 0; py < ph; py++) {
		const cy = y + py;
		if (cy < 0 || cy >= H) continue;
		const sy = Math.min(ih - 1, Math.floor(((py + 0.5) * ih) / fh));
		for (let px = 0; px < pw; px++) {
			const cx = x + px;
			if (cx < 0 || cx >= W) continue;
			const sx = Math.min(iw - 1, Math.floor(((px + 0.5) * iw) / fw));
			const s = (sy * iw + sx) * 4, d = (cy * W + cx) * 4;
			const a = img[s + 3];
			if (a === 255) {
				canvas[d] = img[s];
				canvas[d + 1] = img[s + 1];
				canvas[d + 2] = img[s + 2];
			} else if (a) {
				for (let k = 0; k < 3; k++) canvas[d + k] = (img[s + k] * a + canvas[d + k] * (255 - a) + 127) / 255;
			}
		}
	}
}

// The client's file size for the last, partial tile of an overlay row/column.
const fileSize = (pixels) => {
	let n = 16;
	while (n < pixels) n *= 2;
	return n;
};

async function zoneImage({ casc, art, layer, overlays }) {
	const W = num(layer.LayerWidth), H = num(layer.LayerHeight);
	const tw = num(layer.TileWidth), th = num(layer.TileHeight);
	const canvas = new Uint8Array(W * H * 4);
	for (let i = 0; i < canvas.length; i += 4) canvas.set(SEA, i), (canvas[i + 3] = 255);
	const images = new Map();
	const load = async (fdid) => {
		if (!images.has(fdid)) images.set(fdid, casc.get(fdid).then((b) => decodeBlp(b, { levels: 1 })));
		const blp = await images.get(fdid);
		return { img: blp.mips[0].rgba, iw: blp.width, ih: blp.height };
	};
	const base = art.tiles;
	const overlayTiles = [];
	for (const o of overlays) {
		const cols = Math.ceil(o.width / tw);
		o.files.forEach((fdid, i) => overlayTiles.push({ o, fdid, r: Math.floor(i / cols), c: i % cols, cols, rows: o.files.length / cols }));
	}
	await Promise.all([...base.map((t) => t.fdid), ...overlayTiles.map((t) => t.fdid)].map(load));
	for (const t of base) {
		const { img, iw, ih } = await load(t.fdid);
		drawTile(canvas, W, H, img, iw, ih, t.col * tw, t.row * th, tw, th, tw, th);
	}
	for (const { o, fdid, r, c, cols, rows } of overlayTiles) {
		const { img, iw, ih } = await load(fdid);
		const pw = c < cols - 1 ? tw : o.width - c * tw || tw;
		const ph = r < rows - 1 ? th : o.height - r * th || th;
		drawTile(canvas, W, H, img, iw, ih, o.x + c * tw, o.y + r * th, pw, ph, c < cols - 1 ? tw : fileSize(pw), r < rows - 1 ? th : fileSize(ph));
	}
	return { rgba: canvas, w: W, h: H };
}

async function buildZones({ tables, frames, casc, outDir, only, force, log, warnings }) {
	const uiMaps = new Map(tables.UiMap.map((r) => [num(r.ID), r]));
	const artOf = new Map();
	for (const r of [...tables.UiMapXMapArt].sort((a, b) => num(a.PhaseID) - num(b.PhaseID) || num(a.ID) - num(b.ID))) {
		if (!artOf.has(num(r.UiMapID))) artOf.set(num(r.UiMapID), num(r.UiMapArtID));
	}
	const styleOf = new Map(tables.UiMapArt.map((r) => [num(r.ID), num(r.UiMapArtStyleID)]));
	const layerOf = new Map();
	for (const r of tables.UiMapArtStyleLayer) if (num(r.LayerIndex) === 0) layerOf.set(num(r.UiMapArtStyleID), r);
	const tilesOf = new Map();
	for (const r of tables.UiMapArtTile) {
		if (num(r.LayerIndex) !== 0) continue;
		const a = num(r.UiMapArtID);
		if (!tilesOf.has(a)) tilesOf.set(a, []);
		tilesOf.get(a).push({ row: num(r.RowIndex), col: num(r.ColIndex), fdid: num(r.FileDataID) });
	}
	const overlayRes = buildOverlays(tables);
	const ids = [...new Set([...Object.keys(frames.forever || {}), ...Object.keys(frames.era || {})].map(num))].sort((a, b) => a - b);
	const zones = {};
	let built = 0;
	const dir = path.join(outDir, 'zones');
	for (const id of ids) {
		const um = uiMaps.get(id);
		const frame = (frames.forever || {})[id] || (frames.era || {})[id];
		if (!um || !ZONE_TYPES.has(num(um.Type)) || !frame || (only && !only.has(num(frame.c)))) continue;
		const artID = artOf.get(id);
		const tiles = tilesOf.get(artID);
		if (!artID || !tiles) continue;
		const layer = layerOf.get(styleOf.get(artID));
		if (!layer) {
			warnings.push(`zone ${um.Name_lang} (${id}): art ${artID} has no style layer 0`);
			continue;
		}
		const entry = {
			c: num(frame.c),
			name: um.Name_lang,
			file: `zones/${id}.png`,
			w: num(layer.LayerWidth),
			h: num(layer.LayerHeight),
			frame: { left: frame.left, right: frame.right, top: frame.top, bottom: frame.bottom },
		};
		const file = path.join(outDir, entry.file);
		if (force || !fs.existsSync(file)) {
			try {
				const overlays = (overlayRes.arts[artID] || { overlays: [] }).overlays;
				const img = await zoneImage({ casc, art: { tiles }, layer, overlays });
				fs.mkdirSync(dir, { recursive: true });
				fs.writeFileSync(`${file}.tmp`, encodePng(img.rgba, img.w, img.h));
				fs.renameSync(`${file}.tmp`, file);
				built++;
				log(`zone ${um.Name_lang} (${id}): ${tiles.length} tiles, ${overlays.length} overlays`);
			} catch (err) {
				warnings.push(`zone ${um.Name_lang} (${id}): ${err.message}`);
				continue;
			}
		}
		zones[id] = entry;
	}
	return { zones, built, warnings: overlayRes.warnings };
}

// Builds (or completes) the art. continents: ids to build (null: all);
// workers: encode threads (0: inline). -> { build, continents: [c],
// tiles (tile files listed), zones (zone images listed), warnings }
async function buildArt({
	outDir = path.join(ROOT, 'data', 'local', 'planner', 'art'),
	sourcesDir = SOURCES,
	dataDir = DATA,
	product = 'wow_classic_beta',
	continents = null,
	zones = true,
	force = false,
	offline = false,
	concurrency = 8,
	workers = defaultWorkers(),
	fetchImpl = globalThis.fetch,
	log = () => {},
} = {}) {
	const warnings = [];
	const framesFile = path.join(dataDir, 'map-frames.json');
	if (!fs.existsSync(framesFile)) throw new Error(`${framesFile} not found (forge data build)`);
	const frames = JSON.parse(fs.readFileSync(framesFile, 'utf8'));
	const casc = await openCasc({ sourcesDir, product, offline, concurrency, fetchImpl });
	const family = Object.values(PRODUCTS).find((p) => p.key === product);
	if (family && !family.family.test(casc.build)) throw new Error(`wago.tools: ${product} is at build ${casc.build}, not ${family.family.source}; its files would not be Forever's`);
	log(`${product} ${casc.build}`);
	const tables = await loadTables({ sourcesDir, build: casc.build, offline, fetchImpl, log });

	const indexFile = path.join(outDir, 'index.json');
	let index = null;
	if (fs.existsSync(indexFile)) {
		try {
			index = JSON.parse(fs.readFileSync(indexFile, 'utf8'));
		} catch {
			index = null;
		}
	}
	if (!index || index.schema !== SCHEMA || index.product !== product) index = { continents: {}, zones: {} };
	index = {
		schema: SCHEMA,
		product,
		build: casc.build,
		tile: { px: TILE, mips: CHAIN_LEVELS, format: 'bc1', adtYards: ADT_YARDS, sea: SEA },
		continents: index.continents || {},
		zones: index.zones || {},
	};

	const want = continents ? new Set(continents.map(num)) : null;
	const rows = continentRows(frames, tables.Map).filter((r) => !want || want.has(num(r.ID)));
	if (want) for (const c of want) if (!rows.some((r) => num(r.ID) === c)) warnings.push(`continent ${c}: not in map-frames.json or no WDT in Map.csv`);
	const pool = new Pool(workers);
	const built = [];
	try {
		for (const row of rows) {
			const entry = await buildContinent({ row, prev: index.continents[row.ID], casc, pool, outDir, force, log, warnings });
			if (!entry) continue;
			index.continents[row.ID] = entry;
			built.push(num(row.ID));
		}
	} finally {
		await pool.close();
	}
	if (zones) {
		const res = await buildZones({ tables, frames, casc, outDir, only: want, force, log, warnings });
		for (const [id, z] of Object.entries(res.zones)) index.zones[id] = z;
		warnings.push(...res.warnings);
		log(`zones: ${Object.keys(res.zones).length} (${res.built} drawn)`);
	}
	fs.mkdirSync(outDir, { recursive: true });
	fs.writeFileSync(`${indexFile}.tmp`, `${JSON.stringify(index, null, '\t')}\n`);
	fs.renameSync(`${indexFile}.tmp`, indexFile);
	if (casc.fetched) log(`downloaded ${casc.fetched} files to ${path.relative(process.cwd(), casc.dir) || casc.dir}`);
	let tiles = 0;
	for (const c of Object.values(index.continents)) for (const l of Object.values(c.levels)) tiles += l.length;
	return { build: casc.build, continents: built, tiles, zones: Object.keys(index.zones).length, warnings };
}

module.exports = { buildArt, loadTables, continentRows, drawTile, SEA, MAX_LEVEL, ADT_YARDS, GRID };
