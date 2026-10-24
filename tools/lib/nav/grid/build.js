'use strict';
// `nav build`: the navigation grid of every continent from the Forever
// client's geometry (format.js documents the files). Per continent, three
// passes over its ADT tiles run in worker threads (worker.js), each waiting
// for the one before (a tile's links need its neighbours' surfaces, its
// graph part their links):
//
//   surfaces  tileGeometry -> rasterise -> surfaces (<tile>.surf.gz)
//   links     links, falls, components (<tile>.nav.gz; the .surf.gz is removed)
//   graph     the tile's abstract graph part (<tile>.hpa.gz)
//
// then the main thread joins the graph parts and regions (graph/<c>.bin.gz)
// and writes index.json. Incremental: a tile whose .nav.gz exists is kept
// unless `force`; tiles next to a rebuilt one are relinked, and graph parts
// redone around every relinked tile. Rebuilding a tile is deterministic.
//
// buildNav(opts) reads the client through a Casc (tools/lib/planner/art/casc.js)
// and NavGeom (tools/lib/nav/geom); buildGrid(opts) is the same from any
// source of tile geometry (tests feed triangles).

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const zlib = require('node:zlib');
const { Worker } = require('node:worker_threads');
const { ROOT, SOURCES, DATA } = require('../../paths');
const { CONSTANTS, VERSION, GRAPH_VERSION, encodeGraph, decodeTile, tileKey, cellOf, cellCentre, FLAG, LIFT_RADIUS, LIFT_REACH, LIFT_MIN, LIFT_FIT, LIFT_OPEN, LIFT_LEVEL, LIFT_CAR, CELL, TILE_CELLS } = require('./format');
const { isOpen } = require('./search');
const { assembleGraph, compactPart } = require('./graph');
const { runJob } = require('./worker');

const SCHEMA = 1;

class Pool {
	constructor(size) {
		this.inline = size <= 0;
		this.queue = [];
		this.idle = [];
		this.busy = new Map();
		this.workers = new Set();
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

	run(job) {
		return new Promise((resolve, reject) => {
			this.queue.push({ job, resolve, reject });
			this.pump();
		});
	}

	pump() {
		if (this.inline) {
			if (this.running) return;
			const t = this.queue.shift();
			if (!t) return;
			this.running = true;
			runJob(t.job).then(t.resolve, t.reject).finally(() => {
				this.running = false;
				this.pump();
			});
			return;
		}
		while (this.idle.length && this.queue.length) {
			const t = this.queue.shift();
			const w = this.idle.pop();
			this.busy.set(w, t);
			w.postMessage({ job: t.job });
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

const exists = (f) => fs.existsSync(f);

// Runs jobs on the pool (a failed job tried `retries` more times), logging
// progress every 10 s -> results in order (null for a failed job).
async function runAll(pool, jobs, { label, log, warnings, retries = 0 }) {
	const t0 = Date.now();
	let done = 0;
	let last = t0;
	const attempt = (job, left) => pool.run(job).catch((err) => {
		if (left > 0) return attempt(job, left - 1);
		throw err;
	});
	const out = await Promise.all(jobs.map((job) => attempt(job, retries).then(
		(r) => {
			done++;
			if (Date.now() - last > 10000) {
				last = Date.now();
				log(`  ${label}: ${done}/${jobs.length} (${((last - t0) / 1000).toFixed(0)} s)`);
			}
			return r;
		},
		(err) => {
			done++;
			warnings.push(`${label} ${job.c} ${tileKey(job.col, job.row)}: ${err.message.split('\n')[0]}`);
			return null;
		},
	)));
	if (jobs.length) log(`  ${label}: ${jobs.length} tiles in ${((Date.now() - t0) / 1000).toFixed(1)} s`);
	return out;
}

const neighbours = (t) => {
	const out = [];
	for (let dr = -1; dr <= 1; dr++) for (let dc = -1; dc <= 1; dc++) if (dc || dr) out.push(tileKey(t.col + dc, t.row + dr));
	return out;
};

// One continent: { c, name, tiles: [{ col, row, ... }] }; geometryJob(tile) -> extra job fields.
async function buildContinent({ cont, outDir, pool, force, geometryJob, prev, log, warnings }) {
	const { c } = cont;
	const dir = path.join(outDir, 'tiles', String(c));
	fs.mkdirSync(dir, { recursive: true });
	const tiles = [...cont.tiles].sort((a, b) => a.row - b.row || a.col - b.col);
	const byKey = new Map(tiles.map((t) => [tileKey(t.col, t.row), t]));
	const file = (t, ext) => path.join(dir, `${tileKey(t.col, t.row)}.${ext}.gz`);
	const t0 = Date.now();
	log(`${cont.name || 'continent'} (${c}): ${tiles.length} tiles`);
	const stats = { ...((prev && prev.tileStats) || {}) };

	const surf = tiles.filter((t) => force || (!exists(file(t, 'nav')) && !exists(file(t, 'surf'))));
	// Surfaces download client files: a failed tile is tried once more.
	const r1 = await runAll(pool, surf.map((t) => ({ op: 'surfaces', dir, c, col: t.col, row: t.row, ...geometryJob(t) })), { label: 'surfaces', log, warnings, retries: 1 });
	const built = new Set();
	const geomTotals = { tris: 0, missing: new Set() };
	surf.forEach((t, i) => {
		if (!r1[i]) return;
		built.add(tileKey(t.col, t.row));
		geomTotals.tris += r1[i].tris;
		for (const m of (r1[i].geom && r1[i].geom.missing) || []) geomTotals.missing.add(m);
	});
	if (geomTotals.missing.size) warnings.push(`continent ${c}: ${geomTotals.missing.size} models missing (${[...geomTotals.missing].slice(0, 10).join(', ')}${geomTotals.missing.size > 10 ? ', ...' : ''})`);

	const relink = new Set();
	for (const t of tiles) {
		const key = tileKey(t.col, t.row);
		if (!exists(file(t, 'surf')) && !exists(file(t, 'nav'))) continue;
		if (force || built.has(key) || !exists(file(t, 'nav')) || neighbours(t).some((n) => built.has(n))) relink.add(key);
	}
	const linkTiles = tiles.filter((t) => relink.has(tileKey(t.col, t.row)));
	const r2 = await runAll(pool, linkTiles.map((t) => ({ op: 'links', dir, c, col: t.col, row: t.row })), { label: 'links', log, warnings });
	linkTiles.forEach((t, i) => {
		if (r2[i]) stats[tileKey(t.col, t.row)] = [r2[i].entries, r2[i].walkable, r2[i].falls];
	});
	for (const t of tiles) {
		if (exists(file(t, 'nav')) && exists(file(t, 'surf'))) fs.rmSync(file(t, 'surf'));
	}

	// Lifts from the continent's lift points (this build's tiles).
	const lifts = liftLinks(dir, c, cont.liftPoints || []);
	const liftsKey = JSON.stringify(lifts);
	const liftTiles = new Set();
	for (const L of [...lifts, ...((prev && prev.lifts) || [])]) for (const x of [L.a, L.b]) liftTiles.add(tileKey(x.col, x.row));
	const liftsChanged = !prev || prev.liftsKey !== liftsKey;
	// Each tile's lift rides from its ends: [{ from, to: { col, row, k, entry }, h }].
	const ridesOf = (t) => {
		const out = [];
		for (const L of lifts) {
			if (L.a.col === t.col && L.a.row === t.row) out.push({ from: L.a.entry, to: L.b, h: L.b.z - L.a.z });
			if (L.b.col === t.col && L.b.row === t.row) out.push({ from: L.b.entry, to: L.a, h: L.a.z - L.b.z });
		}
		return out;
	};
	// Graph parts of another graph format are all redone.
	const stale = !prev || prev.graphVersion !== GRAPH_VERSION;
	const regraph = new Set();
	for (const t of tiles) {
		const key = tileKey(t.col, t.row);
		if (!exists(file(t, 'nav'))) continue;
		if (force || stale || !exists(file(t, 'hpa')) || relink.has(key) || neighbours(t).some((n) => relink.has(n)) || (liftsChanged && liftTiles.has(key))) regraph.add(key);
	}
	const graphTiles = tiles.filter((t) => regraph.has(tileKey(t.col, t.row)));
	await runAll(pool, graphTiles.map((t) => ({ op: 'graph', dir, c, col: t.col, row: t.row, rides: ridesOf(t) })), { label: 'graph', log, warnings });

	const present = tiles.filter((t) => exists(file(t, 'nav')) && exists(file(t, 'hpa')));
	const parts = present.map((t) => compactPart(JSON.parse(zlib.gunzipSync(fs.readFileSync(file(t, 'hpa'))).toString('utf8'))));
	const { graph, stats: gs } = assembleGraph(c, parts, lifts);
	if (lifts.length) log(`  lifts: ${lifts.map((L) => `${L.name} ${Math.round(L.h)} yd`).join(', ')}`);
	if (gs.broken) warnings.push(`continent ${c}: ${gs.broken} border edges without a node on the other side`);
	const graphFile = path.join(outDir, 'graph', `${c}.bin.gz`);
	fs.mkdirSync(path.dirname(graphFile), { recursive: true });
	const tmp = `${graphFile}.${process.pid}.tmp`;
	fs.writeFileSync(tmp, encodeGraph(graph));
	fs.renameSync(tmp, graphFile);
	for (const k of Object.keys(stats)) if (!byKey.has(k)) delete stats[k];
	let entries = 0;
	let walkable = 0;
	let falls = 0;
	for (const [e, w, f] of Object.values(stats)) {
		entries += e;
		walkable += w;
		falls += f;
	}
	const seconds = (Date.now() - t0) / 1000;
	log(`  ${present.length} tiles, ${walkable} walkable surfaces, ${falls} falls, ${gs.nodes} nodes, ${gs.regions} regions (${seconds.toFixed(1)} s)`);
	return {
		name: cont.name || null,
		tiles: present.map((t) => tileKey(t.col, t.row)),
		entries, surfaces: walkable, falls,
		nodes: gs.nodes, edges: gs.edges, regions: gs.regions, components: gs.components,
		graph: path.relative(outDir, graphFile).split(path.sep).join('/'),
		graphVersion: GRAPH_VERSION,
		lifts, liftsKey,
		tris: geomTotals.tris || (prev && prev.tris) || 0,
		seconds,
		tileStats: stats,
	};
}

// Lifts of continent c: each point { wx, wy, name, id, rise, floor? } joins
// two landings (format.js LIFT_*): open walkable entries within LIFT_REACH of
// the car whose heights differ by the car's rise within LIFT_FIT, the pair
// nearest the car; with floor ([lower, upper]: the car's floor at its two
// stops) each landing's height off the car's floor there counts LIFT_LEVEL
// times its distance (a landing level with the car, not a step below it)
// -> [{ name, id, a, b, h }], ends { col, row, k, entry, z } (a the lower),
// one per pair of ends. A point with no such pair is no lift.
function liftLinks(dir, c, points) {
	const cache = new Map();
	const tileAt = (col, row) => {
		const key = tileKey(col, row);
		if (!cache.has(key)) {
			let t = null;
			try {
				t = decodeTile(fs.readFileSync(path.join(dir, `${key}.nav.gz`)));
			} catch {
				t = null;
			}
			cache.set(key, t);
		}
		return cache.get(key);
	};
	const out = new Map();
	const R = Math.ceil(LIFT_REACH / CELL);
	for (const pt of points) {
		const at = cellOf(pt.wx, pt.wy);
		const ends = [];
		for (let dj = -R; dj <= R; dj++) {
			for (let di = -R; di <= R; di++) {
				const gi = at.col * TILE_CELLS + at.i + di;
				const gj = at.row * TILE_CELLS + at.j + dj;
				const col = Math.floor(gi / TILE_CELLS);
				const row = Math.floor(gj / TILE_CELLS);
				const i = gi - col * TILE_CELLS;
				const j = gj - row * TILE_CELLS;
				const ctr = cellCentre(col, row, i, j);
				const d = Math.hypot(ctr.wx - pt.wx, ctr.wy - pt.wy);
				if (d > LIFT_REACH) continue;
				const t = tileAt(col, row);
				if (!t || !t.links) continue;
				const k = j * TILE_CELLS + i;
				for (let e = t.first[k]; e < t.first[k + 1]; e++) {
					if (t.flags[e] & FLAG.BLOCKED || !isOpen(t, k, e, LIFT_OPEN)) continue;
					ends.push({ col, row, k, entry: e, z: t.z[e], d });
				}
			}
		}
		ends.sort((x, y) => x.z - y.z);
		let best = null;
		let score = Infinity;
		for (let x = 0, y = 0; x < ends.length; x++) {
			const lo = ends[x];
			while (y < ends.length && ends[y].z < lo.z + pt.rise - LIFT_FIT) y++;
			for (let w = y; w < ends.length && ends[w].z <= lo.z + pt.rise + LIFT_FIT; w++) {
				const hi = ends[w];
				const s = pt.floor
					? lo.d + hi.d + LIFT_LEVEL * (Math.abs(lo.z - pt.floor[0]) + Math.abs(hi.z - pt.floor[1]))
					: lo.d + hi.d + Math.abs(hi.z - lo.z - pt.rise);
				if (s < score) {
					score = s;
					best = { lo, hi };
				}
			}
		}
		if (!best) continue;
		const end = ({ col, row, k, entry, z }) => ({ col, row, k, entry, z });
		const [lo, hi] = [end(best.lo), end(best.hi)];
		const key = `${lo.col}_${lo.row}_${lo.entry}:${hi.col}_${hi.row}_${hi.entry}`;
		if (!out.has(key)) out.set(key, { name: pt.name, id: pt.id, a: lo, b: hi, h: hi.z - lo.z });
	}
	return [...out.values()];
}

// Lift points: every spawn (objects.json) of an object the client animates
// as a transport whose car rises at least LIFT_MIN and sways at most
// LIFT_RADIUS; travel: Map id -> { rise, sway } (geom transportTravel), in
// world yards -> [{ c, wx, wy, name, id, rise, floor? }]. cars (liftCars:
// where each car stands at its stops, to the yard) replace the spawns within
// LIFT_CAR yd of them: a spawn's map position is a tenth of a percent of its
// map (Mulgore's: 5 yd), and each of an object's spawns (one per map it is
// shown on) picked its own landings, a few yards round the car apart. A car
// takes the nearest such spawn's object.
function liftPoints(objects, geo, travel, cars = []) {
	const spawns = [];
	for (const o of Array.isArray(objects) ? objects : Object.values(objects)) {
		const tr = o && travel.get(o.id);
		if (!tr || tr.rise < LIFT_MIN || tr.sway > LIFT_RADIUS) continue;
		for (const [map, s] of Object.entries(o.spawns || {})) {
			for (const [x, y] of s.pts || []) {
				const w = geo.toWorld(Number(map), x, y, s.f === 'e' ? 'e' : 'l');
				if (w) spawns.push({ c: w.c, wx: w.wx, wy: w.wy, name: o.name, id: o.id, rise: tr.rise });
			}
		}
	}
	const taken = new Set();
	const out = [];
	for (const car of cars) {
		const near = spawns.filter((p) => p.c === car.c && Math.hypot(p.wx - car.wx, p.wy - car.wy) <= LIFT_CAR);
		if (!near.length) continue;
		const p = near.reduce((a, b) => (Math.hypot(b.wx - car.wx, b.wy - car.wy) < Math.hypot(a.wx - car.wx, a.wy - car.wy) ? b : a));
		for (const q of near) taken.add(q);
		out.push({ c: car.c, wx: car.wx, wy: car.wy, name: p.name, id: p.id, rise: p.rise, floor: [car.lo, car.hi] });
	}
	return [...out, ...spawns.filter((p) => !taken.has(p))];
}

// Lift cars from travel.json: each car of each lift route (transit.routes,
// kind 'lift'; a stop is [from, to, c, wx, wy, z, car]) -> [{ c, wx, wy, lo, hi }],
// at its first stop, lo and hi its floor at the lowest and highest.
function liftCars(travelDoc) {
	const out = [];
	for (const r of Object.values((travelDoc && travelDoc.transit && travelDoc.transit.routes) || {})) {
		if (!r || r.kind !== 'lift') continue;
		const cars = new Map();
		for (const s of r.stops || []) {
			if (!cars.has(s[6])) cars.set(s[6], []);
			cars.get(s[6]).push(s);
		}
		for (const stops of cars.values()) {
			const zs = stops.map((s) => s[5]);
			out.push({ c: stops[0][2], wx: stops[0][3], wy: stops[0][4], lo: Math.min(...zs), hi: Math.max(...zs) });
		}
	}
	return out;
}

function readIndex(file) {
	try {
		return JSON.parse(fs.readFileSync(file, 'utf8'));
	} catch {
		return null;
	}
}

// Builds from any geometry source.
// continents: [{ c, name, tiles: [{ col, row, ... }] }]; geometryJob(c, tile) -> job fields; liftPoints: [{ c, wx, wy, name, id }]
// (geom: triangles inline, or casc + root/obj0 for tileGeometry in the worker).
// -> { continents: { [c]: entry }, warnings }
async function buildGrid({ outDir, continents, geometryJob, product = null, build = null, force = false, workers = defaultWorkers(), log = () => {}, liftPoints = [] }) {
	const warnings = [];
	const indexFile = path.join(outDir, 'index.json');
	let index = readIndex(indexFile);
	if (!index || index.schema !== SCHEMA || index.version !== VERSION || index.product !== product || index.build !== build) {
		if (index && !force) log('nav: index from another schema, product or build: rebuilding every tile');
		if (index) force = true;
		index = null;
	}
	const pool = new Pool(workers);
	const out = { ...((index && index.continents) || {}) };
	try {
		for (const cont of continents) {
			out[cont.c] = await buildContinent({
				cont: { ...cont, liftPoints: liftPoints.filter((p) => p.c === cont.c) }, outDir, pool, force, prev: out[cont.c], log, warnings, geometryJob: (t) => geometryJob(cont.c, t),
			});
		}
	} finally {
		await pool.close();
	}
	const doc = { schema: SCHEMA, version: VERSION, product, build, builtAt: new Date().toISOString(), constants: CONSTANTS, continents: out };
	fs.mkdirSync(outDir, { recursive: true });
	fs.writeFileSync(`${indexFile}.tmp`, `${JSON.stringify(doc, null, '\t')}\n`);
	fs.renameSync(`${indexFile}.tmp`, indexFile);
	const liftsDoc = {};
	for (const [c, entry] of Object.entries(out)) liftsDoc[c] = entry.lifts || [];
	fs.writeFileSync(path.join(outDir, 'lifts.json.tmp'), `${JSON.stringify(liftsDoc)}\n`);
	fs.renameSync(path.join(outDir, 'lifts.json.tmp'), path.join(outDir, 'lifts.json'));
	return { index: doc, warnings };
}

// The continents map-frames.json names, from the client (NavGeom continentTiles).
async function buildNav({
	outDir = path.join(ROOT, 'data', 'local', 'nav'),
	sourcesDir = SOURCES,
	dataDir = DATA,
	product = 'wow_classic_beta',
	continents = null,
	force = false,
	offline = false,
	workers = defaultWorkers(),
	concurrency = 8,
	log = () => {},
} = {}) {
	const { openCasc } = require('../../planner/art/casc');
	const { continentTiles, transportTravel } = require('../geom');
	const { Geo } = require('../../planner/geo');
	const framesFile = path.join(dataDir, 'map-frames.json');
	if (!fs.existsSync(framesFile)) throw new Error(`${framesFile} not found (forge data build)`);
	const frames = JSON.parse(fs.readFileSync(framesFile, 'utf8'));
	const zonesFile = path.join(dataDir, 'zones.json');
	const geo = new Geo(frames, fs.existsSync(zonesFile) ? JSON.parse(fs.readFileSync(zonesFile, 'utf8')) : {});
	const names = new Map(geo.continents().map((x) => [x.c, x.name]));
	const objectsFile = path.join(dataDir, 'objects.json');
	const casc = await openCasc({ sourcesDir, product, offline, concurrency });
	log(`${product} ${casc.build}`);
	const travelFile = path.join(dataDir, 'travel.json');
	const cars = fs.existsSync(travelFile) ? liftCars(JSON.parse(fs.readFileSync(travelFile, 'utf8'))) : [];
	const lifts = fs.existsSync(objectsFile) ? liftPoints(JSON.parse(fs.readFileSync(objectsFile, 'utf8')), geo, await transportTravel(casc), cars) : [];
	const want = continents ? new Set(continents) : null;
	const cs = [...names.keys()].filter((c) => !want || want.has(c));
	const warnings = [];
	if (want) for (const c of want) if (!names.has(c)) warnings.push(`continent ${c}: not in map-frames.json`);
	const list = [];
	for (const c of cs) {
		let tiles;
		try {
			tiles = await continentTiles(casc, c);
		} catch (err) {
			warnings.push(`continent ${c}: ${err.message}`);
			continue;
		}
		if (!tiles || !tiles.length) {
			warnings.push(`continent ${c}: no ADT tiles`);
			continue;
		}
		list.push({ c, name: names.get(c), tiles });
	}
	const cascOpts = { sourcesDir, product, build: casc.build, offline, concurrency: Math.max(2, Math.ceil(concurrency / 2)) };
	const r = await buildGrid({
		outDir, continents: list, product, build: casc.build, force, workers, log, liftPoints: lifts,
		geometryJob: (c, t) => ({ root: t.root, obj0: t.obj0, casc: cascOpts }),
	});
	return { ...r, build: casc.build, warnings: [...warnings, ...r.warnings] };
}

module.exports = { buildNav, buildGrid, liftLinks, liftPoints, liftCars, defaultWorkers, SCHEMA };
