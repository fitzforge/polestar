'use strict';
// Routed walks (docs/legacy/SIMULATION-js.md §1 "Walks"): walking distances between the
// world's points from a walking router: the node router (router: 'node', the
// default: tools/lib/nav/router.js on the local walking grid, data/local/nav4,
// on worker threads sharing one decoded copy) or Polestar's own (router: 'lua':
// addon/Polestar_Nav run standalone by `nav eval`'s harness), so the simulator
// walks round cliffs, mountains and water as the arrow does, not straight through
// them. Without them every walk is the straight line × the continent's detour
// factor, which is right on average (1.3) but prices a walk through a mountain
// wall as if it were open ground: Silithus to Feralas is 1,785 yd straight and
// 13,807 yd walked.
//
//   anchorPoints(world) -> Set of the points walks reach further between (ANCHOR_RADIUS):
//     inns, transport nodes (flight masters, docks, lifts, portals), starts and service points
//   walkPoints(world, maps, { camps = true }) -> sorted world point indices a run can walk between:
//     quest givers, enders, accept and task sites, package steps, the anchors and (camps) the
//     camps any kept objective works at (q.objs[].camps), on the maps the router has walking
//     maps for (PACK.json `maps`)
//   walkQueries(world, { radius, anchorRadius, style, maps, band, snap, camps, sample }) -> { points,
//     queries, campPoints, campPairs }: `many` queries from each point to every later point
//     (index order) on its landmass within the pair's radius (radiusFor: `anchorRadius` between
//     two anchors, CAMP_CAMP_RADIUS between two camps, CAMP_RADIUS from a camp to any other point,
//     else `radius`; a camp point that is also another walk point counts as that), as the
//     faction (profile). Band 0 is the base walk (no zone danger): one query per point.
//     Band b (a character level) keeps only the pairs
//     whose straight line crosses a zone, other than the two end zones, at least 4 levels
//     above b (the router's danger starts there), one query per point and target zone, with
//     `level` b and `to` the first target, so the router exempts both end zones. Each point is
//     sent at snap(pt)'s x, y (the grid's surface for it) with its own height, else as the
//     world has it (sendAt). sample (a Set of world points): only the walk points in it (a
//     measurement on part of a world).
//   buildWalks(world, { navDir, radius, anchorRadius, bands, style, cacheDir, workers, log,
//     runQueries?, snap?, camps?, router }) -> { doc, routed, cached, failed, recovered, oneWay }:
//     the walks document
//     { schema, faction, dataHash, router, nav, smooth, style, radius, anchorRadius, bands,
//       oneWayDz, points, pairs: { [band]: [a, b, yards, cost, oneWay, ...] }, zones, unwalkable }
//     unwalkable: [a, b, ...] base pairs the router walks neither way whose ends differ
//     by more than UNWALK_DZ in height (a cliff and its foot, #579): no walk on foot, the
//     lookup's yd is Infinity (absent in older documents: none)
//     zones (null when not built): per base pair (pairs[0], in its order) the walk's yards
//     per zone, flat [zone, yards, zone, yards, ...] (zone: world.danger's map per 200 yd
//     cell, the zones territory.js weighs; yards the router's, summing to the pair's), or
//     null where the grid could not route it. Node router: counted from the cells its path
//     crosses (kept with each base walk in the cache, so a new danger grid needs no
//     routing). Lua router (FindMany returns no path): a walk whose every possible way (the
//     disc round its middle, half its yards wide) lies in one zone's cells is that zone's
//     whole; any other is routed on the local grid (openGrid, nav.route) and its yards split
//     as that route's samples fall, kept in <cacheDir>/walkzones-<faction>.json by place
//     pair, as fractions, with the zone grid's hash.
//     (bands: 0 and the asked bands; world point indices; oneWay 0: a < b, the a to b search,
//     walked both ways; oneWay 1: the walk from a to b only. A band other than 0 lists
//     only the pairs re-routed for it, every other pair walks band 0's; a pair the router
//     could not walk is left out, so it keeps the straight line × detour). A pair the router
//     could not walk is asked once more with the surface's height for an end whose surface
//     lies at another height (recovered: those it then walks). One-way walks (descents, #363):
//     a base pair whose ends' heights differ by more than ONE_WAY_DZ is also searched from b
//     to a; where the two directions differ, both are stored one-way (where they are alike,
//     or only one walks, that walk both ways). oneWay: { pairs: such base pairs, searches:
//     the searches asked for their directions not cached, directed: one-way walks stored }. Every answer is
//     kept in cacheFile(cacheDir, faction, router) (node: walkcache-node-<faction>.bin, each band
//     walk with the multipliers of the zones it could have entered; lua: walkcache-<faction>.json)
//     keyed by place (continent, x, y and height rounded to 2 yd) and band, failures too, so a
//     rebuild on a changed world routes only the pairs it has not asked before (node: and a band
//     walk only where a zone it could have entered changed level); a key's order is its search's
//     direction (from its first place), which one-way walks read exactly
//   walksFile(simDir, faction) (walks-<faction>.bin), writeWalks, readWalks, loadWalks (the
//     walks a run uses, reassembled from the node cache when only the world changed),
//     navFingerprint(navDir), nodeFingerprint(dir), pairStride(doc) -> values per pair
//     (5; 4 in a schema 2 document: [a, b, yards, cost], every pair both ways)
//   attachWalks(world, simDir, { navDir, log }) -> world.walks = Map(a * NW + b -> yards, both
//     orders, a one-way walk its own: band 30's where re-routed, else band 0's) and world.walkBands =
//     { [band]: Map(a * NW + b -> [yards, cost]) } (band 0 every pair, other bands only
//     their re-routed pairs; yards are the router's × smoothOf(doc), the drawn line's length;
//     cost as routed; a one-way walk replaces a both-ways one in its direction) when
//     the faction's walks (loadWalks) were built on this world and these walking
//     maps; else none (and a note why)
//   walkYards(world, a, b) -> routed yards from world point a to b, or undefined
//   openGrid(dir, opts) -> the local walking grid (data/local/nav4, path.js openNav) or null;
//   gridSnap(world, nav) -> (pt) -> the grid's surface for world point pt (nav.snap) or null.
//     buildWalks' snap defaults to gridSnap on openGrid() when the grid is built (snap: null: none)
//   sendAt(P, snap, full) -> (pt) -> [x, y, z] the router is sent for world point pt: the grid's
//     x, y with the point's own height (full: the surface's height too), else the point
//   gridRoute(nav, snap) -> (a, b) -> the grid's route between world points (nav.route), for
//     classifyFailures (sim walks --report)
//
// A walk is priced on one side's route (the faction's profile: its hostile towns
// cost more) in the arrow's default route style (balanced). The pairs are one
// direction's search (a to b), used both ways, except a base pair whose ends lie
// at different heights: the router walks a drop it would not climb (a cliff jumped
// down, a slope run down), so its two directions are searched apart. A band's walk
// carries the router's zone danger for a character of that level (band b stands
// for levels b-5 to b+5, the lowest and highest open-ended), on the world's zone
// levels; band walks are one search, used both ways.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const crypto = require('node:crypto');
const { Worker, isMainThread, parentPort, workerData } = require('node:worker_threads');
const { ROOT } = require('../paths');
const { crossedZones } = require('./travel');

const WALKS_SCHEMA = 4; // 4: zones, each base pair's yards per zone; 3: one-way walks (pairs of 5); 2 (pairs of 4, both ways) still loads
const BIN_SCHEMA = 5; // a binary walks file (writeWalks): schema 4's content, typed arrays and prebuilt lookup tables
const READ_SCHEMAS = new Set([2, 3, WALKS_SCHEMA, BIN_SCHEMA]);
// Zones of a base walk (schema 4): yards between samples of the grid's route, and
// base walks per worker job.
const ZONE_SAMPLE = 25;
const ZONE_CHUNK = 200;
const ZONE_SAVE = 100000;
// A zone worker's tile cache: 64 tiles peak at 1.4 GB a worker (the default 256: 1.9 GB), as fast.
const ZONE_TILES = 64;
const RADIUS = 4000; // yards: longer walks keep the straight line × detour (a flight or a ride usually wins)
const ANCHOR_RADIUS = 12000; // yards: between anchors (inns, transport nodes, starts, services)
const CAMP_RADIUS = 1500; // yards: from a camp (a kept objective's) to any other walk point
const CAMP_CAMP_RADIUS = 600; // yards: between two camps
const BANDS = [10, 20, 30, 40, 50]; // character levels of the danger bands
const V1_BAND = 30; // the band world.walks (one walk per pair) takes
// Yards of height: a base pair whose ends differ by more is searched both ways (descents,
// #363: a slope or a drop walked down is shorter than the way back up).
const ONE_WAY_DZ = 15;
// Yards of height: a base pair the router walks neither way whose ends differ by more is
// unwalkable (doc.unwalkable; the lookup's yd is Infinity): a cliff top and its foot
// (#579: Teldrassil's top and Rut'theran Village, joined only by the portal) were priced
// as a walk of the straight line × detour. A pair failed at a smaller height difference
// keeps the straight line (a gap in the grid, not a cliff). An estimate: a few storeys.
const UNWALK_DZ = 40;
// Two directions within SAME_REL of the shorter (yards and cost, and at least 1) are one both-ways
// walk: well inside routeMul's ±5% stray. Measured with an absolute 1 yd/1 cost (2026-10-20): 43%
// of Horde's descents differed, median 0.0%, p90 0.4%, p99 4.9% of the shorter walk.
const SAME_REL = 0.02;
const alike = (u, v) => Math.abs(u - v) <= Math.max(1, SAME_REL * Math.min(u, v));
const DANGER_GAP = 4; // levels: the router's zone danger starts at zoneMin >= level + 4 (harness.lua dangerOf)
// The router's danger rule (tools/lib/nav/eval/harness.lua dangerOf: ×3 at zoneMin >= level + 4,
// ×20 above level + 10, both end zones exempt). Bump whenever that rule changes: cached band
// walks (band ≠ 0) are routed again; base walks (band 0, no danger) stay.
const DANGER_VERSION = 1;
const STYLE = 'balanced';
// Walked yards per routed yard. The router's `many` search (FindMany, every walk here) measures
// the unsmoothed grid steps of the cost-best path; the arrow walks the drawn, smoothed line
// (Find). Measured route ÷ many yards over 67 pairs (same pairs, stored heights, Horde,
// balanced, 2026-10-18): median 0.964, p10 0.941, p90 0.983, tightest above 1,000 yd
// (0.96-0.97). The cache and the walks file keep the router's yards; attachWalks applies this.
const SMOOTH = 0.965;
const NAV_DIR = path.join(ROOT, 'addon', 'Polestar_Nav');
const { GRID_DIR } = require('../nav/router'); // the local walking grid (nav build; $POLESTAR_GRID), when built
const CHUNK = 8; // queries per worker job (progress granularity)
// The routers sim walks can route with: 'node' (tools/lib/nav/router.js on the grid in GRID_DIR, worker
// threads over one shared decoded copy) or 'lua' (Polestar_Nav's in-game router through nav eval's harness).
const ROUTERS = ['node', 'lua'];
const NODE_CHUNK = 16; // node router: searches per worker job, from neighbouring starts
const NODE_WORKER_GB = 0.6; // node router: a worker's own memory (caches, scratch) besides the shared maps

function walksFile(simDir, faction) {
	return path.join(simDir, `walks-${String(faction).toLowerCase()}.bin`);
}

// The walks as JSON: `sim walks --json`'s export, and the format before the binary one.
function walksJsonFile(simDir, faction) {
	return path.join(simDir, `walks-${String(faction).toLowerCase()}.json`);
}

// One cache per router (their walks differ): the Lua router's keeps its old name and JSON, the
// node router's is binary (readNodeCache).
function cacheFile(dir, faction, router = 'lua') {
	return path.join(dir, router === 'lua' ? `walkcache-${String(faction).toLowerCase()}.json` : `walkcache-${router}-${String(faction).toLowerCase()}.bin`);
}

function readPack(navDir = NAV_DIR) {
	return JSON.parse(fs.readFileSync(path.join(navDir, 'PACK.json'), 'utf8'));
}

// The walking maps and router a walks file was built on: PACK.json (it lists
// every map file's sha256) and the router's code (API.lua, Routing/), the
// folder's own where it has them, else the repository's (as nav eval loads them).
function navFingerprint(navDir = NAV_DIR) {
	const h = crypto.createHash('sha1').update(fs.readFileSync(path.join(navDir, 'PACK.json')));
	const code = ['API.lua', ...fs.readdirSync(path.join(NAV_DIR, 'Routing')).sort().map((f) => `Routing/${f}`)];
	for (const f of code) {
		const own = path.join(navDir, f);
		h.update(`\n${f}\n`).update(fs.readFileSync(fs.existsSync(own) ? own : path.join(NAV_DIR, f)));
	}
	return h.digest('hex');
}

// The node router's fingerprint on the grid in dir (router.js: its maps, the hubs layer and its
// code), once per process; null without a grid.
const nodeFps = new Map();
function nodeFingerprint(dir = GRID_DIR) {
	if (!nodeFps.has(dir)) nodeFps.set(dir, fs.existsSync(path.join(dir, 'index.json')) ? require('../nav/router').fingerprint(dir) : null);
	return nodeFps.get(dir);
}

// Inns, transport nodes (every kind), starts and service points (services.js:
// trainer by class, repair, food, ammo, inn, flight).
function anchorPoints(world) {
	const set = new Set();
	const add = (pt) => {
		if (pt != null) set.add(pt);
	};
	for (const n of world.inns || []) add(n.pt);
	for (const n of world.nodes || []) add(n.pt);
	for (const s of Object.values(world.starts || {})) add(s.pt);
	for (const v of Object.values(world.services || {})) for (const s of Array.isArray(v) ? v : Object.values(v).flat()) add(s.pt);
	return set;
}

// opts.camps (default true): with the camps any kept objective works at (world.camps[id].pt).
function walkPoints(world, maps, { camps = true } = {}) {
	const set = new Set();
	const add = (pt) => {
		if (pt != null && world.points[pt] && maps.has(world.points[pt][0])) set.add(pt);
	};
	for (const q of world.quests) {
		add(q.giver);
		add(q.ender);
		// Every giver and ender of a quest that has several (a guide is scored at the one it names).
		for (const pt of Object.values(q.gAlt || {})) add(pt);
		for (const pt of Object.values(q.eAlt || {})) add(pt);
		if (q.accept) add(q.accept.pt);
		for (const t of q.tasks) add(t.pt);
	}
	for (const p of world.packages) for (const s of p.steps) add(s[3]);
	for (const pt of anchorPoints(world)) add(pt);
	if (camps) for (const pt of campPoints(world)) add(pt);
	return [...set].sort((a, b) => a - b);
}

// The points of the camps any kept objective works at.
function campPoints(world) {
	const set = new Set();
	for (const q of world.quests) for (const o of q.objs || []) for (const id of o.camps || []) if (world.camps[id]) set.add(world.camps[id].pt);
	return set;
}

// The walk radius between two points by kind ('anchor', 'camp': a camp point that is no other
// walk point, 'other'; a point is the kind with the longer reach): anchor-anchor anchorRadius
// (never under radius), camp-camp CAMP_CAMP_RADIUS, a camp and anything else CAMP_RADIUS, else radius.
// The camp radii never exceed radius.
function radiusFor(ka, kb, radius, anchorRadius) {
	if (ka === 'anchor' && kb === 'anchor') return Math.max(radius, anchorRadius);
	if (ka === 'camp' && kb === 'camp') return Math.min(radius, CAMP_CAMP_RADIUS);
	if (ka === 'camp' || kb === 'camp') return Math.min(radius, CAMP_RADIUS);
	return radius;
}

// The local walking grid (tools/lib/nav/path.js openNav on data/local/nav4), or null when not built.
function openGrid(dir = GRID_DIR, opts = {}) {
	if (!fs.existsSync(path.join(dir, 'index.json'))) return null;
	const nav = require('../nav/path').openNav({ dir, ...opts });
	return nav.available ? nav : null;
}

// world point -> the grid's walkable surface for it (nav.snap: { wx, wy, z, region, ... }), or
// null; each point snapped once.
function gridSnap(world, nav) {
	const P = world.points;
	const seen = new Map();
	return (pt) => {
		if (!seen.has(pt)) seen.set(pt, nav.snap({ c: P[pt][0], wx: P[pt][2], wy: P[pt][3], z: P[pt][5] }));
		return seen.get(pt);
	};
}

// A point's place in the walk cache: continent, x, y and height rounded to 2 yd
// (n: no height), so a rebuilt world's points find their walks again.
function keyOf(P, pt) {
	const p = P[pt];
	return `${p[0]}:${Math.round(p[2] / 2)}:${Math.round(p[3] / 2)}:${p[5] == null ? 'n' : Math.round(p[5] / 2)}`;
}

// (a, b) -> the highest minimum level of the zones the straight line from
// world point a to b crosses (end zones not counted), -Infinity for none.
function crossing(world) {
	const P = world.points;
	const zoneMin = new Map(Object.entries(world.zoneMin || {}).map(([m, l]) => [Number(m), l]));
	const grids = new Map((world.danger || []).map((g) => [g.region, g]));
	return (a, b) => {
		const g = grids.get(P[a][1]);
		if (!g) return -Infinity;
		const mins = crossedZones(g, zoneMin, P[a][2], P[a][3], P[b][2], P[b][3], P[a][4], P[b][4]);
		return mins.length ? mins[0] : -Infinity;
	};
}

// pt -> what the router is sent for world point pt: the grid's x, y (snap(pt), the surface's
// column) with the point's own height (none stays none), or with `full` the surface's height
// too; the point as the world has it when it has no surface. The grid's floor and the
// stored height disagree at lift landings and z-less city points (a 6 yd higher surface,
// another storey), so the stored one is tried first.
function sendAt(P, snap, full) {
	return (pt) => {
		const s = snap && snap(pt);
		const z = P[pt][5] == null ? null : P[pt][5];
		return s ? [s.wx, s.wy, full ? s.z : z] : [P[pt][2], P[pt][3], z];
	};
}

function walkQueries(world, { radius = RADIUS, anchorRadius = ANCHOR_RADIUS, style = STYLE, maps, band = 0, snap = null, camps = true, sample = null }) {
	const P = world.points;
	const pts = walkPoints(world, maps, { camps }).filter((pt) => !sample || sample.has(pt));
	const anchors = anchorPoints(world);
	// A camp point that is also another walk point keeps that point's kind (its longer reach),
	// so camps only add pairs.
	const plain = camps ? new Set(walkPoints(world, maps, { camps: false })) : null;
	const kind = new Map(pts.map((pt) => [pt, anchors.has(pt) ? 'anchor' : plain && !plain.has(pt) ? 'camp' : 'other']));
	const highest = band ? crossing(world) : null;
	const at = sendAt(P, snap, false);
	const queries = [];
	let campPairs = 0;
	for (let i = 0; i < pts.length; i++) {
		const src = pts[i];
		const a = P[src];
		const ka = kind.get(src);
		const groups = new Map(); // target zone (band walks; 0 for the base walk) -> targets
		for (let j = i + 1; j < pts.length; j++) {
			const t = pts[j];
			const b = P[t];
			if (b[0] !== a[0] || b[1] !== a[1]) continue;
			const kb = kind.get(t);
			if (Math.hypot(b[2] - a[2], b[3] - a[3]) > radiusFor(ka, kb, radius, anchorRadius)) continue;
			if (band && highest(src, t) < band + DANGER_GAP) continue;
			if (ka === 'camp' || kb === 'camp') campPairs++;
			const g = band ? b[4] : 0;
			if (!groups.has(g)) groups.set(g, []);
			groups.get(g).push(t);
		}
		for (const [zone, ids] of groups) {
			const q = { type: 'many', id: band ? `${src}:${zone}` : String(src), map: a[0], from: at(src), targets: ids.map(at), profile: world.faction, style };
			if (band) {
				q.level = band;
				q.to = q.targets[0];
			}
			q.src = src;
			q.ids = ids;
			queries.push(q);
		}
	}
	let campPts = 0;
	for (const k of kind.values()) if (k === 'camp') campPts++;
	return { points: pts, queries, campPoints: campPts, campPairs };
}

// The danger a band walk was routed with: DANGER_VERSION and the zone levels sent to the router.
function dangerFingerprint(zoneLevels) {
	const rows = Object.entries(zoneLevels || {}).map(([id, z]) => [Number(id), z.min]).sort((a, b) => a[0] - b[0]);
	return crypto.createHash('sha1').update(JSON.stringify([DANGER_VERSION, rows])).digest('hex');
}

// The walk cache: Map(`${keyA}|${keyB}|${band}` -> [yards, cost]), [-1, -1] for
// a pair the router could not walk; only on the walking maps and style it was routed on,
// and band walks (band ≠ 0) only with the danger (zone levels, rule) they were routed with.
// -> { cache, dropped: band walks left out for another danger }
function readCache(file, nav, style, danger) {
	const cache = new Map();
	let dropped = 0;
	if (!fs.existsSync(file)) return { cache, dropped };
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	if (doc.schema !== 2 || doc.nav !== nav || doc.style !== style) return { cache, dropped };
	const sameDanger = doc.danger === danger;
	for (let i = 0; i < doc.pairs.length; i += 5) {
		if (!sameDanger && doc.pairs[i + 2] !== 0) {
			dropped++;
			continue;
		}
		cache.set(`${doc.keys[doc.pairs[i]]}|${doc.keys[doc.pairs[i + 1]]}|${doc.pairs[i + 2]}`, [doc.pairs[i + 3], doc.pairs[i + 4]]);
	}
	return { cache, dropped };
}

function writeCache(file, nav, style, danger, m) {
	const keys = [];
	const idx = new Map();
	const id = (k) => (idx.has(k) ? idx.get(k) : (idx.set(k, keys.length), keys.push(k), keys.length - 1));
	const pairs = [];
	for (const [k, [y, c]] of m) {
		const [ka, kb, band] = k.split('|');
		pairs.push(id(ka), id(kb), Number(band), y, c);
	}
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(`${file}.tmp`, JSON.stringify({ schema: 2, nav, style, danger, keys, pairs }));
	fs.renameSync(`${file}.tmp`, file);
}

// The node router's walk cache (cacheFile's .bin; binfile.js): Map(`${keyA}|${keyB}|${band}` ->
// [yards, cost, extra]), [-1, -1] for a pair the router could not walk; only on the grid and
// style it was routed on (nav) and the danger rule version. extra: a base walk's yards per zone
// cell (Float32Array [cellKey, yards, ...]: its zones are read off the danger grid, no routing),
// a band walk's danger signature (nodeAnswer's sigs: it stands while its zones' multipliers do,
// bandValid), else null.
const NODE_CACHE_SCHEMA = 3;
function readNodeCache(file, nav, style) {
	const cache = new Map();
	if (!fs.existsSync(file)) return cache;
	const { header: h, sections: s } = require('./binfile').readBin(file);
	if (h.schema !== NODE_CACHE_SCHEMA || h.nav !== nav || h.style !== style || h.dangerVersion !== DANGER_VERSION) return cache;
	const n = s.band.length;
	for (let i = 0; i < n; i++) {
		const lo = s.xoff[i];
		const hi = s.xoff[i + 1];
		cache.set(`${h.keys[s.ka[i]]}|${h.keys[s.kb[i]]}|${s.band[i]}`, [s.y[i], s.c[i], hi > lo ? s.x.slice(lo, hi) : null]);
	}
	return cache;
}

function writeNodeCache(file, nav, style, m) {
	const keys = [];
	const idx = new Map();
	const id = (k) => (idx.has(k) ? idx.get(k) : (idx.set(k, keys.length), keys.push(k), keys.length - 1));
	const n = m.size;
	const ka = new Int32Array(n);
	const kb = new Int32Array(n);
	const band = new Uint8Array(n);
	const y = new Float32Array(n);
	const c = new Float32Array(n);
	const xoff = new Uint32Array(n + 1);
	let i = 0;
	let len = 0;
	for (const [k, v] of m) {
		const [a, b, bd] = k.split('|');
		ka[i] = id(a);
		kb[i] = id(b);
		band[i] = Number(bd);
		y[i] = v[0];
		c[i] = v[1];
		len += v[2] ? v[2].length : 0;
		xoff[++i] = len;
	}
	const x = new Float32Array(len);
	i = 0;
	for (const v of m.values()) {
		if (v[2]) x.set(v[2], xoff[i]);
		i++;
	}
	fs.mkdirSync(path.dirname(file), { recursive: true });
	require('./binfile').writeBin(file, { schema: NODE_CACHE_SCHEMA, router: 'node', nav, style, dangerVersion: DANGER_VERSION, keys }, { ka, kb, band, y, c, xoff, x });
}

// The router's danger multiplier for a zone of lowest level `min` at character level `level`
// (harness.lua dangerOf, router.js dangerOf).
const dangerMult = (min, level) => (min > level + 10 ? 20 : min >= level + 4 ? 3 : 1);

// Whether a cached band walk still stands for `band` on zone levels zoneMins: a node walk with a
// danger signature while every zone in it costs as it did (its ends' zones exempt); a failure or
// a walk without a signature always (the Lua cache drops band walks on any change, readCache).
function bandValid(v, band, zoneMins) {
	const sig = v[2];
	if (!band || !sig || v[0] < 0) return true;
	for (let i = 2; i < sig.length; i += 2) {
		const z = sig[i];
		const m = z === sig[0] || z === sig[1] || !zoneMins || zoneMins[z] == null ? 1 : dangerMult(zoneMins[z], band);
		if (m !== sig[i + 1]) return false;
	}
	return true;
}

// Run the queries on `workers` threads, CHUNK at a time (cold), or as one large sorted batch per
// worker (warm: router caches survive across queries; sources sorted by region for cache reuse).
function runParallel(queries, { navDir, workers, zoneLevels, log, warm = false }) {
	if (!queries.length) return Promise.resolve([]);
	if (warm) {
		// Sort by (map, x) for geographic locality so each worker's caches stay hot.
		const sorted = queries.slice().sort((a, b) => (a.map - b.map) || (a.from[0] - b.from[0]) || (a.from[1] - b.from[1]));
		const W = Math.max(1, Math.min(workers, sorted.length));
		const sliceSize = Math.ceil(sorted.length / W);
		const slices = Array.from({ length: W }, (_, i) => sorted.slice(i * sliceSize, (i + 1) * sliceSize).filter(Boolean));
		const out = [];
		const t0 = Date.now();
		return new Promise((resolve, reject) => {
			let done = false;
			let finished = 0;
			const fail = (err) => { if (!done) { done = true; threads.forEach((w) => w.terminate()); reject(err); } };
			const threads = slices.map((slice) => {
				const w = new Worker(__filename, { workerData: { walksWorker: true, navDir, zoneLevels, warm: true } });
				w.once('error', fail);
				w.once('message', (msg) => {
					if (msg.error) return fail(new Error(msg.error));
					out.push(...msg.results);
					finished++;
					if (log) {
						const s = (Date.now() - t0) / 1000;
						log(`  walks: ${finished * sliceSize}/${sorted.length} searches (warm), ${s.toFixed(0)} s`);
					}
					// Each worker answers once: end every thread, or the process never exits.
					if (finished === slices.length && !done) { done = true; threads.forEach((t) => t.terminate()); resolve(out); }
				});
				w.postMessage(slice.map(({ ids, src, ...q }) => q));
				return w;
			});
		});
	}
	const W = Math.max(1, Math.min(workers, Math.ceil(queries.length / CHUNK)));
	const jobs = [];
	for (let i = 0; i < queries.length; i += CHUNK) jobs.push(queries.slice(i, i + CHUNK));
	const out = [];
	const t0 = Date.now();
	return new Promise((resolve, reject) => {
		let next = 0;
		let done = 0;
		let live = W;
		const threads = Array.from({ length: W }, () => new Worker(__filename, { workerData: { walksWorker: true, navDir, zoneLevels } }));
		const finish = (err) => {
			for (const w of threads) w.terminate();
			if (err) reject(err);
			else resolve(out);
		};
		const feed = (w) => {
			if (next >= jobs.length) {
				if (--live === 0) finish();
				return;
			}
			const job = jobs[next++];
			w.once('message', (msg) => {
				if (msg.error) return finish(new Error(msg.error));
				out.push(...msg.results);
				done += job.length;
				if (log && (done === queries.length || Math.floor((done - job.length) / 200) !== Math.floor(done / 200))) {
					const s = (Date.now() - t0) / 1000;
					log(`  walks: ${done}/${queries.length} searches, ${s.toFixed(0)} s, about ${Math.round((s / done) * (queries.length - done))} s left`);
				}
				feed(w);
			});
			w.postMessage(job.map(({ ids, src, ...q }) => q));
		};
		for (const w of threads) {
			w.once('error', finish);
			feed(w);
		}
	});
}

// Route same-region pairs across `workers` threads for classifyFailures.
// pairs: [{ a, b, sa, sb }] (sa, sb: pre-computed snaps with entry+tile so nav.route skips re-snapping);
// returns [{ a, b, okAB, okBA, ridesAB, ridesBA, climbsAB, climbsBA }].
function runParallelRoute(pairs, { navDir, workers }) {
	if (!pairs.length) return Promise.resolve([]);
	const W = Math.max(1, Math.min(workers, pairs.length));
	const sliceSize = Math.ceil(pairs.length / W);
	const slices = Array.from({ length: W }, (_, i) => pairs.slice(i * sliceSize, (i + 1) * sliceSize)).filter((s) => s.length > 0);
	const out = [];
	return new Promise((resolve, reject) => {
		let done = false;
		let finished = 0;
		const fail = (err) => { if (!done) { done = true; threads.forEach((w) => w.terminate()); reject(err); } };
		const threads = slices.map((slice) => {
			const w = new Worker(__filename, { workerData: { classifyWorker: true, navDir } });
			w.once('error', fail);
			w.once('message', (msg) => {
				if (msg.error) return fail(new Error(msg.error));
				out.push(...msg.results);
				finished++;
				if (finished === slices.length && !done) { done = true; threads.forEach((t) => t.terminate()); resolve(out); }
			});
			w.postMessage(slice);
			return w;
		});
	});
}

// GB of memory the system has available now (/proc/meminfo MemAvailable; os.freemem elsewhere).
function availableGB() {
	try {
		const m = /MemAvailable:\s+(\d+) kB/.exec(fs.readFileSync('/proc/meminfo', 'utf8'));
		if (m) return Number(m[1]) / 1048576;
	} catch {
		// not Linux
	}
	return os.freemem() / 1073741824;
}

// The node router's worker threads for one build: the walk graphs built where missing (router.js
// prepare, on `workers` threads), then the grid's continents `continents` decoded once into shared
// memory (router.js share), at most `workers` threads, fewer when the memory available (after the
// shared maps) holds fewer at NODE_WORKER_GB each.
// -> Promise<{ store, workers, sharedGB, run(queries, log) -> Promise<results>, close() }>
async function nodePool({ dir = GRID_DIR, continents, workers, zones, zoneMins, log }) {
	const { share, sharedBytes, prepare } = require('../nav/router');
	await prepare(dir, continents, { workers, log });
	const t0 = Date.now();
	const store = share(dir, continents);
	const sharedGB = sharedBytes(store) / 1073741824;
	const fit = Math.max(1, Math.floor((availableGB() - 1) / NODE_WORKER_GB));
	const W = Math.max(1, Math.min(workers, fit));
	if (log) log(`  walks: node router: grid ${path.relative(ROOT, dir)} continents ${continents.join(', ')} decoded once into shared memory (${sharedGB.toFixed(1)} GB, ${((Date.now() - t0) / 1000).toFixed(0)} s); ${W} workers${W < workers ? ` (memory holds ${fit})` : ''}`);
	const threads = Array.from({ length: W }, () => new Worker(__filename, { workerData: { walksNodeWorker: true, dir, store, zones, zoneMins } }));
	const run = (queries, plog) => {
		if (!queries.length) return Promise.resolve([]);
		// Neighbouring starts together: a worker's leg and piece caches serve its next searches.
		const sorted = queries.slice().sort((a, b) => a.map - b.map || a.from[0] - b.from[0] || a.from[1] - b.from[1]);
		const jobs = [];
		for (let i = 0; i < sorted.length; i += NODE_CHUNK) jobs.push(sorted.slice(i, i + NODE_CHUNK).map(({ ids, src, ...q }) => q));
		const out = [];
		const start = Date.now();
		return new Promise((resolve, reject) => {
			let next = 0;
			let done = 0;
			let live = threads.length;
			let failed = false;
			onError = (err) => {
				failed = true;
				reject(err);
			};
			const feed = (w) => {
				if (failed) return;
				if (next >= jobs.length) {
					if (--live === 0) resolve(out);
					return;
				}
				const job = jobs[next++];
				w.once('message', (msg) => {
					if (msg.error) {
						failed = true;
						reject(new Error(msg.error));
						return;
					}
					out.push(...msg.results);
					done += job.length;
					if (plog && Math.floor((done - job.length) / 2000) !== Math.floor(done / 2000)) {
						const s = (Date.now() - start) / 1000;
						plog(`  walks: ${done}/${queries.length} searches, ${s.toFixed(0)} s, about ${Math.round((s / done) * (queries.length - done))} s left`);
					}
					feed(w);
				});
				w.postMessage(job);
			};
			for (const w of threads) feed(w);
		});
	};
	let onError = null;
	for (const w of threads) w.on('error', (err) => onError && onError(err));
	return { store, workers: W, sharedGB, run, close: () => Promise.all(threads.map((w) => w.terminate())) };
}

// The sim world's danger grids with their continents (router.js zones): a grid's region is the
// world points' second field; its continent their first.
function zonesOf(world) {
	const cOf = new Map();
	for (const p of world.points) if (!cOf.has(p[1])) cOf.set(p[1], p[0]);
	return (world.danger || []).filter((g) => cOf.has(g.region)).map((g) => ({ c: cOf.get(g.region), gx0: g.gx0, gy0: g.gy0, nx: g.nx, ny: g.ny, cell: g.cell, z: g.z }));
}

const round1 = (v) => Math.round(v * 10) / 10;

// opts.router: 'node' (default: the grid's router, nodePool) or 'lua' (nav eval's harness, runParallel).
// opts.runQueries (tests) stands in for the harness's runQueries: the Lua router's unless opts.router says.
async function buildWalks(world, opts = {}) {
	const router = opts.router || (opts.runQueries ? 'lua' : 'node');
	if (!ROUTERS.includes(router)) throw new Error(`walks: no router ${router} (${ROUTERS.join(', ')})`);
	if (router !== 'node' || opts.runQueries) return walksWith(world, { ...opts, router, pool: null });
	if (!fs.existsSync(path.join(GRID_DIR, 'index.json'))) throw new Error(`walks: the node router needs the grid in ${path.relative(ROOT, GRID_DIR)} (node tools/polestar.js nav build), or --router lua`);
	const maps = Object.keys(readPack(opts.navDir || NAV_DIR).maps).map(Number);
	const workers = opts.workers || Math.max(1, os.availableParallelism() - 1);
	const pool = await nodePool({ continents: maps, workers, zones: zonesOf(world), zoneMins: world.zoneMin || null, log: opts.log });
	try {
		return await walksWith(world, { ...opts, router, pool, workers: pool.workers });
	} finally {
		await pool.close();
	}
}

async function walksWith(world, { navDir = NAV_DIR, radius = RADIUS, anchorRadius = ANCHOR_RADIUS, bands = BANDS, style = STYLE, cacheDir = null, workers = Math.max(1, os.availableParallelism() - 1), log, runQueries, snap, camps = true, warm = true, zoneQueries = null, router, pool }) {
	const maps = new Set(Object.keys(readPack(navDir).maps).map(Number));
	const node = router === 'node';
	const nav = node ? nodeFingerprint(GRID_DIR) : navFingerprint(navDir);
	const P = world.points;
	if (snap === undefined) {
		const grid = openGrid(GRID_DIR, pool ? { shared: pool.store } : {});
		snap = grid ? gridSnap(world, grid) : null;
		if (log) log(grid ? `  walks: the router is sent each point at its surface's x, y on the grid in ${path.relative(ROOT, GRID_DIR)}` : `  walks: no grid in ${path.relative(ROOT, GRID_DIR)}: the router is sent the points as they are`);
	}
	const file = cacheDir ? cacheFile(cacheDir, world.faction, router) : null;
	// The router's zone danger on the world's zone levels (the ones band selection reads).
	const zoneLevels = Object.keys(world.zoneMin || {}).length ? Object.fromEntries(Object.entries(world.zoneMin).map(([id, min]) => [id, { min }])) : null;
	const danger = dangerFingerprint(zoneLevels);
	let cache;
	let dropped = 0;
	if (node) cache = file ? readNodeCache(file, nav, style) : new Map();
	else ({ cache, dropped } = file ? readCache(file, nav, style, danger) : { cache: new Map(), dropped: 0 });
	if (log && dropped) log(`  walks: ${dropped} cached band walks were routed with other zone levels or another danger rule: routed again`);
	const save = (m) => {
		if (!file) return;
		if (node) writeNodeCache(file, nav, style, m);
		else writeCache(file, nav, style, danger, m);
	};
	const key = placeKeys(P);
	const zoneMins = world.zoneMin || null;
	const { lookup, exact } = cacheLookup(cache, key, zoneMins);
	const descent = (a, b) => P[a][5] != null && P[b][5] != null && Math.abs(P[a][5] - P[b][5]) > ONE_WAY_DZ;
	const all = [...new Set([0, ...bands.map(Number)])].sort((x, y) => x - y);
	let routed = 0;
	let cached = 0;
	let stale = 0;
	let recovered = 0;
	const oneWay = { pairs: 0, searches: 0, directed: 0 };
	const ask = (list) => (runQueries
		? runQueries({ navDir, queries: list.map(({ ids, src, ...q }) => q), zoneLevels }).results.filter((r) => r.type === 'many')
		: pool ? pool.run(list, log) : runParallel(list, { navDir, workers, zoneLevels, log, warm }));
	const full = sendAt(P, snap, true);
	const first = sendAt(P, snap, false);
	const differs = (pt) => first(pt)[2] !== full(pt)[2];
	// What the node router returns with each walk: a base walk's zone cells, a band walk's danger signature.
	const extras = (band) => (node ? (band ? { sig: true } : { cells: true }) : {});
	// Route `todo` (each query from q.src to q.ids) for `band`; every answer is cached under
	// key(q.src)|key(t), so the key's order is the search's direction.
	const route = async (todo, band, label) => {
		// -> [ok pairs, failed pairs ([q, t])] of one pass's answers, cached.
		const take = (list, results) => {
			const byId = new Map(list.map((q) => [q.id, q]));
			const bad = [];
			let good = 0;
			for (const r of results) {
				const q = byId.get(r.id);
				if (!q) continue;
				q.ids.forEach((t, k) => {
					const y = r.yards && r.yards[k];
					const c = r.costs && r.costs[k];
					const ok = typeof y === 'number' && y >= 0 && typeof c === 'number' && c >= 0;
					const x = (r.cells && r.cells[k]) || (r.sigs && r.sigs[k]) || null;
					cache.set(`${key(q.src)}|${key(t)}|${band}`, ok ? [round1(y), round1(c), x ? Float32Array.from(x) : null] : [-1, -1, null]);
					if (ok) good++;
					else bad.push([q, t]);
				});
			}
			return [good, bad];
		};
		const [good, bad] = take(todo, await ask(todo));
		routed += good + bad.length;
		// A pair the router could not walk is asked once more with the grid's height for an end
		// whose surface lies at another height (the grid's floor and the stored one can differ).
		const again = new Map();
		for (const [q, t] of bad) {
			if (!differs(q.src) && !differs(t)) continue;
			if (!again.has(q.id)) again.set(q.id, { ...q, id: `${q.id}:z`, from: full(q.src), targets: [], ids: [] });
			const r = again.get(q.id);
			r.ids.push(t);
			r.targets.push(full(t));
			if (band) r.to = r.targets[0];
		}
		const retry = [...again.values()];
		let back = 0;
		if (retry.length) [back] = take(retry, await ask(retry));
		recovered += back;
		if (log) log(`  walks: ${label}: ${good} walked first time, ${back} of ${bad.length} failed walked with the grid's height (${retry.length} searches), ${bad.length - back} not walkable`);
		// After every pass: a long build stopped part way keeps what it routed.
		save(cache);
	};
	const queriesOf = new Map();
	for (const band of all) {
		const wq = walkQueries(world, { radius, anchorRadius, style, maps, band, snap, camps });
		queriesOf.set(band, wq);
		const { points, queries, campPoints: campPts, campPairs } = wq;
		const todo = [];
		let wanted = 0;
		let have = 0;
		for (const q of queries) {
			wanted += q.ids.length;
			const keep = [];
			q.ids.forEach((t, k) => {
				if (lookup(q.src, t, band)) have++;
				else {
					if (cache.has(`${key(q.src)}|${key(t)}|${band}`) || cache.has(`${key(t)}|${key(q.src)}|${band}`)) stale++;
					keep.push(k);
				}
			});
			if (!keep.length) continue;
			const targets = keep.map((k) => q.targets[k]);
			todo.push({ ...q, ...extras(band), targets, ids: keep.map((k) => q.ids[k]), ...(band ? { to: targets[0] } : {}) });
		}
		cached += have;
		if (log) log(`  walks: ${world.faction} ${band ? `band ${band}` : 'base'}: ${points.length} points (${campPts} camps), ${wanted} pairs (${campPairs} to a camp; ${have} cached, ${wanted - have} new), ${todo.length} searches on ${runQueries ? 1 : workers} workers`);
		if (todo.length) await route(todo, band, band ? `band ${band}` : 'base');
		if (band === 0) {
			// One-way walks: each direction of a base pair whose ends lie at different heights
			// searched from its own start, one search per start for its directions not cached.
			// The way back (b to a) is the new search; a to b is the base walk unless the cache
			// holds that pair the other way round only (a renumbered world).
			const from = new Map(); // start -> ends
			let backHave = 0;
			let fresh = 0;
			const want = (a, b) => {
				fresh++;
				if (!from.has(a)) from.set(a, []);
				from.get(a).push(b);
			};
			for (const q of queries) {
				for (const t of q.ids) {
					if (!descent(q.src, t)) continue;
					oneWay.pairs++;
					if (!exact(q.src, t, 0)) want(q.src, t);
					if (exact(t, q.src, 0)) backHave++;
					else want(t, q.src);
				}
			}
			const at = sendAt(P, snap, false);
			const dirTodo = [...from].map(([src, ids]) => ({ type: 'many', id: `d${src}`, map: P[src][0], from: at(src), targets: ids.map(at), profile: world.faction, style, ...extras(0), src, ids }));
			oneWay.searches = dirTodo.length;
			cached += backHave;
			if (log) log(`  walks: ${world.faction} base one-way: ${oneWay.pairs} pairs with ends over ${ONE_WAY_DZ} yd apart in height (${backHave} ways back cached, ${fresh} directions new), ${dirTodo.length} searches`);
			if (dirTodo.length) await route(dirTodo, 0, 'base one-way');
		}
	}
	if (log && stale) log(`  walks: ${stale} cached band walks crossed zones whose danger changed: routed again`);
	// Prune by place: drop a walk only when one of its ends is no longer a walk point's
	// place in this world (moved or gone); walks between two current places stay, whatever
	// radius, anchor radius or bands this run asked for.
	if (file) {
		const live = new Set(walkPoints(world, maps).map(key));
		const kept = new Map([...cache].filter(([k]) => {
			const [ka, kb] = k.split('|');
			return live.has(ka) && live.has(kb);
		}));
		if (routed || dropped || kept.size !== cache.size) save(kept);
		if (log && kept.size !== cache.size) log(`  walks: ${cache.size - kept.size} cached walks from places no longer in the world, pruned`);
	}
	const smooth = node ? require('../nav/router').SMOOTH : SMOOTH;
	const { doc, failed, missing, directed } = assembleWalks(world, { cache, key, zoneMins, queriesOf: (b) => queriesOf.get(b), bands: all, router, nav, smooth, style, radius, anchorRadius });
	if (missing) throw new Error(`walks: ${missing} walks neither routed nor cached (a router answered no search for them)`);
	oneWay.directed = directed;
	if (log) log(`  walks: ${routed} pairs routed, ${cached} from the cache, ${failed} the router could not walk (they keep the straight line × detour); ${oneWay.directed} one-way walks of ${oneWay.pairs} pairs at different heights`);
	// The router's threads are done: their caches give way to the zone workers (the shared grid stays).
	if (pool) await pool.close();
	// Zones: the node router's walks carry their zone cells (assembleWalks); the Lua router's are
	// routed on the grid unless the caller routes (tests pass zoneQueries).
	if (!node && (zoneQueries || (!runQueries && fs.existsSync(GRID_DIR)))) {
		doc.zones = await walkZones(world, doc.pairs[0] || [], { workers, cacheDir, log, zoneQueries, key, store: pool ? pool.store : null });
	}
	return { doc, routed, cached, failed, recovered, oneWay };
}

// A world's place keys (keyOf), each computed once: pt -> key.
function placeKeys(P) {
	const keys = new Map();
	return (pt) => {
		let k = keys.get(pt);
		if (k === undefined) keys.set(pt, (k = keyOf(P, pt)));
		return k;
	};
}

// The cache's answers for world points: lookup(a, b, band) either direction, exact(a, b, band) the
// search from a itself; a band walk only while it stands on zoneMins (bandValid).
function cacheLookup(cache, key, zoneMins) {
	const ok = (v, band) => (v && bandValid(v, band, zoneMins) ? v : undefined);
	return {
		// Either direction: a rebuilt world may number two places the other way round.
		lookup: (a, b, band) => ok(cache.get(`${key(a)}|${key(b)}|${band}`), band) || ok(cache.get(`${key(b)}|${key(a)}|${band}`), band),
		exact: (a, b, band) => ok(cache.get(`${key(a)}|${key(b)}|${band}`), band),
	};
}

// The walks document of a world from the cache alone (no routing): every band's pairs as walkQueries
// asks them (queriesOf(band) -> its { points, queries }), the one-way walks, the unwalkable pairs
// and, where the cache keeps the walks' zone cells (the node router's), each base walk's yards per
// zone off the world's danger grid (zonesFromCells; else zones null). -> { doc, failed: pairs the
// cache holds as not walked, missing: pairs it holds no (standing) answer for, directed }
function assembleWalks(world, { cache, key, zoneMins, queriesOf, bands, router, nav, smooth, style, radius, anchorRadius }) {
	const { lookup, exact } = cacheLookup(cache, key, zoneMins);
	const doc = walksDoc(world, { router, nav, smooth, style, radius, anchorRadius, bands });
	let failed = 0;
	let missing = 0;
	let directed = 0;
	for (const band of bands) {
		const { points, queries } = queriesOf(band);
		doc.points = points.length;
		const r = assembleBand(world, queries, band, (a, b) => lookup(a, b, band), (a, b) => exact(a, b, band), doc.unwalkable);
		doc.pairs[band] = r.pairs;
		failed += r.failed;
		missing += r.missing;
		directed += r.directed;
	}
	if (router === 'node') doc.zones = zonesFromCells(world, doc.pairs[0] || [], (a, b) => exact(a, b, 0) || lookup(a, b, 0));
	return { doc, failed, missing, directed };
}

// An empty walks document of a world (assembleWalks fills its pairs and zones).
function walksDoc(world, { router, nav, smooth, style, radius, anchorRadius, bands }) {
	return { schema: WALKS_SCHEMA, faction: world.faction, dataHash: world.dataHash, router, nav, smooth, style, radius, anchorRadius, bands, oneWayDz: ONE_WAY_DZ, points: 0, nw: world.points.length, pairs: {}, unwalkable: [], zones: null };
}

// One band's pairs (5 a pair) from its queries (walkQueries') and its answers: lookup(a, b) either
// direction, exact(a, b) the search from a itself, each -> [yards, cost, extra] or undefined. A base
// descent's two directions are stored one-way where they differ; a base pair walked neither way
// whose ends differ by more than UNWALK_DZ goes into unwalkable. -> { pairs, failed, missing, directed }
function assembleBand(world, queries, band, lookup, exact, unwalkable) {
	const P = world.points;
	const descent = (a, b) => P[a][5] != null && P[b][5] != null && Math.abs(P[a][5] - P[b][5]) > ONE_WAY_DZ;
	const pairs = [];
	let failed = 0;
	let missing = 0;
	let directed = 0;
	for (const q of queries) {
		for (const t of q.ids) {
			if (band === 0 && descent(q.src, t)) {
				const f = exact(q.src, t);
				const r = exact(t, q.src);
				if (!f || !r) {
					// A renumbered world's pair cached the other way round only: its one search, both ways.
					const v = f || r || lookup(q.src, t);
					if (!v) missing++;
					else if (v[0] >= 0) pairs.push(q.src, t, v[0], v[1], 0);
					else failed++;
					continue;
				}
				const fOk = f[0] >= 0;
				const rOk = r[0] >= 0;
				if (fOk && rOk && !(alike(f[0], r[0]) && alike(f[1], r[1]))) {
					pairs.push(q.src, t, f[0], f[1], 1, t, q.src, r[0], r[1], 1);
					directed += 2;
				} else if (fOk || rOk) {
					// The two alike, or one way only walkable (a drop not climbed back): that walk
					// both ways, as a pair's one search always was (the way it does not walk is
					// longer still, not the straight line × detour).
					const v = fOk ? f : r;
					pairs.push(q.src, t, v[0], v[1], 0);
				} else {
					failed++;
					if (Math.abs(P[q.src][5] - P[t][5]) > UNWALK_DZ) unwalkable.push(q.src, t);
				}
				continue;
			}
			const v = lookup(q.src, t);
			if (!v) missing++;
			else if (v[0] >= 0) pairs.push(q.src, t, v[0], v[1], 0);
			else failed++;
		}
	}
	return { pairs, failed, missing, directed };
}

// Each base pair's yards per zone (doc.zones' layout) off its walk's zone cells (the node router's
// cache: Float32Array [cellKey, yards, ...]) and the world's danger grid of the pair's region; null
// for a pair without cells. walkOf(a, b) -> the cached walk.
function zonesFromCells(world, base, walkOf) {
	const share = zoneSharer(world);
	const n = base.length / 5;
	const out = new Array(n).fill(null);
	for (let k = 0; k < n; k++) {
		const v = walkOf(base[5 * k], base[5 * k + 1]);
		out[k] = share(base[5 * k], v && v[2], base[5 * k + 2]);
	}
	return out;
}

// (a, cells, Y) -> a walk from world point a's yards Y per zone, flat [zone, yards, ...] by zone, from
// its zone cells ([cellKey, yards, ...]) on the world's danger grid of a's region; null without cells.
function zoneSharer(world) {
	const { cellXY } = require('../nav/router');
	const P = world.points;
	const grids = new Map((world.danger || []).map((g) => [g.region, g]));
	return (a, cells, Y) => {
		if (!cells || !cells.length) return null;
		const g = grids.get(P[a][1]);
		const yd = new Map();
		let total = 0;
		for (let i = 0; i < cells.length; i += 2) {
			const [gx, gy] = cellXY(cells[i]);
			const x = gx - (g ? g.gx0 : 0);
			const y = gy - (g ? g.gy0 : 0);
			const z = g && x >= 0 && y >= 0 && x < g.nx && y < g.ny ? g.z[x * g.ny + y] : 0;
			yd.set(z, (yd.get(z) || 0) + cells[i + 1]);
			total += cells[i + 1];
		}
		if (!(total > 0)) return null;
		const flat = [];
		for (const [z, y] of [...yd].sort((p, q) => p[0] - q[0])) flat.push(z, Math.round((y / total) * Y * 10) / 10);
		return flat;
	};
}

// Per region of world.danger: { g, far }, far[cell] the cells (4-neighbour steps) to the
// nearest cell of another zone (0 at a border).
function zoneGrids(world) {
	const out = new Map();
	for (const g of world.danger || []) {
		const N = g.nx * g.ny;
		const far = new Float32Array(N).fill(Infinity);
		let front = [];
		const near4 = (i, f) => {
			const x = Math.floor(i / g.ny);
			const y = i % g.ny;
			if (x > 0) f(i - g.ny);
			if (x + 1 < g.nx) f(i + g.ny);
			if (y > 0) f(i - 1);
			if (y + 1 < g.ny) f(i + 1);
		};
		for (let i = 0; i < N; i++) {
			let edge = false;
			near4(i, (j) => { if (g.z[j] !== g.z[i]) edge = true; });
			if (edge) {
				far[i] = 0;
				front.push(i);
			}
		}
		while (front.length) {
			const next = [];
			for (const i of front) near4(i, (j) => { if (far[j] > far[i] + 1) { far[j] = far[i] + 1; next.push(j); } });
			front = next;
		}
		out.set(g.region, { g, far });
	}
	return out;
}

// The zone of the cell under (wx, wy) on grid g, 0 off it.
function zoneOf(g, wx, wy) {
	const gx = Math.floor(wx / g.cell) - g.gx0;
	const gy = Math.floor(wy / g.cell) - g.gy0;
	return gx < 0 || gy < 0 || gx >= g.nx || gy >= g.ny ? 0 : g.z[gx * g.ny + gy];
}

// A route's points (wx, wy, z per point) -> flat [zone, share, ...] of its length per zone (0 for none).
function zoneShares(g, pts) {
	const yd = new Map();
	let total = 0;
	for (let i = 3; i + 2 < pts.length; i += 3) {
		const ax = pts[i - 3];
		const ay = pts[i - 2];
		const dx = pts[i] - ax;
		const dy = pts[i + 1] - ay;
		const L = Math.hypot(dx, dy);
		const n = Math.max(1, Math.ceil(L / ZONE_SAMPLE));
		for (let k = 0; k < n; k++) {
			const z = zoneOf(g, ax + (dx * (k + 0.5)) / n, ay + (dy * (k + 0.5)) / n);
			yd.set(z, (yd.get(z) || 0) + L / n);
		}
		total += L;
	}
	if (!(total > 0)) return null;
	const out = [];
	for (const [z, y] of [...yd].sort((a, b) => a[0] - b[0])) out.push(z, Math.round((y / total) * 1000) / 1000);
	return out;
}

function zonesCacheFile(dir, faction) {
	return path.join(dir, `walkzones-${String(faction).toLowerCase()}.json`);
}

// Each base pair's yards per zone (the doc.zones layout above). key(pt): a point's place.
// store: the node router's shared grid (nodePool), which the zone workers then read too.
async function walkZones(world, base, { workers = 1, cacheDir = null, log, zoneQueries = null, key, store = null }) {
	const P = world.points;
	const grids = zoneGrids(world);
	const hash = crypto.createHash('sha1').update(JSON.stringify((world.danger || []).map((g) => [g.region, g.gx0, g.gy0, g.nx, g.ny, g.cell, g.z]))).digest('hex');
	const file = cacheDir ? zonesCacheFile(cacheDir, world.faction) : null;
	let cache = new Map();
	if (file && fs.existsSync(file)) {
		const c = JSON.parse(fs.readFileSync(file, 'utf8'));
		if (c.schema === 1 && c.grid === hash) cache = new Map(Object.entries(c.shares));
	}
	const n = base.length / 5;
	const shares = new Array(n).fill(null);
	const ask = [];
	let one = 0;
	for (let k = 0; k < n; k++) {
		const a = base[5 * k];
		const b = base[5 * k + 1];
		const G = grids.get(P[a][1]);
		if (!G) continue;
		const mx = (P[a][2] + P[b][2]) / 2;
		const my = (P[a][3] + P[b][3]) / 2;
		const gx = Math.floor(mx / G.g.cell) - G.g.gx0;
		const gy = Math.floor(my / G.g.cell) - G.g.gy0;
		const inside = gx >= 0 && gy >= 0 && gx < G.g.nx && gy < G.g.ny;
		// Every way of at most Y yards from a to b stays within Y/2 of their middle.
		if (inside && G.g.z[gx * G.g.ny + gy] && (G.far[gx * G.g.ny + gy] - 1) * G.g.cell > base[5 * k + 2] / 2) {
			shares[k] = [G.g.z[gx * G.g.ny + gy], 1];
			one++;
			continue;
		}
		const ck = `${key(a)}|${key(b)}`;
		if (cache.has(ck)) {
			shares[k] = cache.get(ck);
			continue;
		}
		ask.push({ k, ck, c: P[a][0], r: P[a][1], a: [P[a][2], P[a][3]], b: [P[b][2], P[b][3]] });
	}
	const ckOf = new Map(ask.map((q) => [q.k, q.ck]));
	const save = () => {
		if (!file) return;
		fs.mkdirSync(path.dirname(file), { recursive: true });
		fs.writeFileSync(`${file}.tmp`, JSON.stringify({ schema: 1, grid: hash, shares: Object.fromEntries(cache) }));
		fs.renameSync(`${file}.tmp`, file);
	};
	// Each finished batch goes into the cache, saved every ZONE_SAVE routes, so a stopped build keeps its work.
	let unsaved = 0;
	const take = (batch) => {
		for (const { k, z } of batch) {
			shares[k] = z;
			cache.set(ckOf.get(k), z);
		}
		unsaved += batch.length;
		if (unsaved >= ZONE_SAVE) {
			save();
			unsaved = 0;
		}
	};
	if (zoneQueries) take(zoneQueries(ask));
	else await runZones(ask, { workers, world, log, take, store });
	if (unsaved) save();
	const zones = shares.map((sh, k) => {
		if (!sh) return null;
		const Y = base[5 * k + 2];
		const out = [];
		for (let i = 0; i < sh.length; i += 2) out.push(sh[i], Math.round(sh[i + 1] * Y * 10) / 10);
		return out;
	});
	const missing = zones.filter((z) => z == null).length;
	if (log) log(`  walks: zones of ${n} base walks: ${one} in one zone, ${n - one - ask.length} from the cache, ${ask.length} routed on the grid, ${missing} without (the straight line stands in)`);
	return zones;
}

// The grid's routes for the zone queries, on `workers` threads, ZONE_CHUNK at a time,
// each finished chunk's [{ k, z }] handed to take.
function runZones(ask, { workers, world, log, take, store = null }) {
	if (!ask.length) return Promise.resolve();
	const jobs = [];
	for (let i = 0; i < ask.length; i += ZONE_CHUNK) jobs.push(ask.slice(i, i + ZONE_CHUNK).map(({ ck, ...q }) => q));
	const W = Math.max(1, Math.min(workers, jobs.length));
	const t0 = Date.now();
	return new Promise((resolve, reject) => {
		let next = 0;
		let live = W;
		let done = 0;
		const threads = Array.from({ length: W }, () => new Worker(__filename, { workerData: { zonesWorker: true, danger: world.danger, store } }));
		const finish = (err) => {
			for (const w of threads) w.terminate();
			if (err) reject(err);
			else resolve();
		};
		const feed = (w) => {
			if (next >= jobs.length) {
				if (--live === 0) finish();
				return;
			}
			const job = jobs[next++];
			w.once('message', (msg) => {
				if (msg.error) return finish(new Error(msg.error));
				take(msg.results);
				done += job.length;
				if (log && Math.floor((done - job.length) / 20000) !== Math.floor(done / 20000)) {
					const s = (Date.now() - t0) / 1000;
					log(`  walks: zones ${done}/${ask.length} routed, ${s.toFixed(0)} s, about ${Math.round((s / done) * (ask.length - done))} s left`);
				}
				feed(w);
			});
			w.postMessage(job);
		};
		for (const w of threads) {
			w.once('error', finish);
			feed(w);
		}
	});
}

// Writes a walks document as walks-<faction>.bin (binfile.js): the header (every field but the
// arrays, `nw` the world's point count), per band its pairs (`p<band>`, Float64Array of 5 per
// pair) and its lookup table as walklookup.js builds it (`L<band>.<field>`: offsets, nbr, yd,
// cost, src), the unwalkable pairs and the zones (zoff/zval: base pair k's flat [zone, yards, ...]
// at zval[zoff[k] .. zoff[k + 1]], zhas[k] 0 for none). json: a walks-<faction>.json too (for
// reading by eye; nothing loads it while the .bin is there). -> the .bin's path
function writeWalks(simDir, doc, { json = false, nw = doc.nw } = {}) {
	const { buildBand } = require('./walklookup');
	const file = walksFile(simDir, doc.faction);
	fs.mkdirSync(simDir, { recursive: true });
	const { pairs, unwalkable, zones, lookup: _lookup, contentId: _id, ...rest } = doc;
	const header = { ...rest, schema: BIN_SCHEMA, nw };
	const sections = {};
	const stride = pairStride(doc);
	for (const [band, arr] of Object.entries(pairs)) {
		// Always 5 a pair, doubles (yards and costs exactly as routed): a schema 2 document's pairs
		// of 4, all both ways, get oneWay 0.
		const p = new Float64Array((arr.length / stride) * 5);
		for (let i = 0, j = 0; i < arr.length; i += stride, j += 5) {
			for (let k = 0; k < 4; k++) p[j + k] = arr[i + k];
			p[j + 4] = stride === 5 ? arr[i + 4] : 0;
		}
		sections[`p${band}`] = p;
		if (nw) for (const [k, v] of Object.entries(buildBand(p, nw, 5, smoothOf(doc)))) sections[`L${band}.${k}`] = v;
	}
	sections.unwalkable = Int32Array.from(unwalkable || []);
	if (zones && zones.off) Object.assign(sections, { zoff: zones.off, zval: zones.val, zhas: zones.has }); // readWalks' shape
	else if (zones) {
		const zoff = new Uint32Array(zones.length + 1);
		const zhas = new Uint8Array(zones.length);
		zones.forEach((z, k) => {
			zoff[k + 1] = zoff[k] + (z ? z.length : 0);
			zhas[k] = z ? 1 : 0;
		});
		// Doubles, as the JSON document held them: a float32 yard moves zone shares and with them decisions.
		const zval = new Float64Array(zoff[zones.length]);
		zones.forEach((z, k) => z && zval.set(z, zoff[k]));
		Object.assign(sections, { zoff, zval, zhas });
	}
	const contentId = require('./binfile').writeBin(file, header, sections);
	const cas = require('./cas');
	if (cas.enabled(simDir)) cas.store('walks', walksStoreKey(doc.dataHash, doc.faction, doc.router, doc.nav), file);
	if (json) {
		const out = walksJsonFile(simDir, doc.faction);
		fs.writeFileSync(`${out}.tmp`, JSON.stringify({ contentId, ...doc, schema: doc.schema === BIN_SCHEMA ? WALKS_SCHEMA : doc.schema }, (k, v) => (ArrayBuffer.isView(v) ? Array.from(v) : v)));
		fs.renameSync(`${out}.tmp`, out);
	}
	return file;
}

// The walks document of a faction as written (writeWalks; an older walks-<faction>.json where no
// .bin is), or null: the header's fields, pairs { band: Float32Array }, unwalkable, zones ({ off,
// val, has } or a JSON document's array) and lookup ({ band: walklookup's table }, the .bin's).
// Nothing is kept between calls.
function readWalks(simDir, faction) {
	const file = walksFile(simDir, faction);
	if (!fs.existsSync(file)) {
		const old = walksJsonFile(simDir, faction);
		return fs.existsSync(old) ? JSON.parse(fs.readFileSync(old, 'utf8')) : null;
	}
	const { header, sections: s } = require('./binfile').readBin(file);
	const { sections: _, ...doc } = header;
	doc.pairs = {};
	doc.lookup = {};
	for (const band of doc.bands) {
		doc.pairs[band] = s[`p${band}`];
		if (s[`L${band}.offsets`]) doc.lookup[band] = { offsets: s[`L${band}.offsets`], nbr: s[`L${band}.nbr`], yd: s[`L${band}.yd`], cost: s[`L${band}.cost`], src: s[`L${band}.src`] };
	}
	doc.unwalkable = s.unwalkable;
	doc.zones = s.zoff ? { off: s.zoff, val: s.zval, has: s.zhas } : null;
	return doc;
}

// The header of a faction's walks file alone (readBinHeader: no arrays read), or null.
function readWalksHeader(simDir, faction) {
	return require('./binfile').readBinHeader(walksFile(simDir, faction));
}

// The content id of a faction's walks (the .bin header's contentId: sha1 of what it holds), or
// null without a .bin (runKey's walks hash).
function walksContentId(simDir, faction) {
	const h = readWalksHeader(simDir, faction);
	return h ? h.contentId : null;
}

// The walks a run of this world uses: the faction's walks document when walksUsable; else one
// from the shared store (cas.js) for this world and grid; else, when only the world changed or
// there is no document, the document reassembled from the node router's walk cache with no
// routing (assembleWalks, on the last document's radius, bands and style, else the defaults) and
// written, when the cache holds every walk the world asks; else null (log says why; a walks file
// binfile.js can't read is unreadable, never replaced). -> { doc, why } (why: null, or the reason
// there are none)
function loadWalks(world, simDir, { navDir = NAV_DIR, log } = {}) {
	let doc;
	try {
		doc = readWalks(simDir, world.faction);
	} catch (err) {
		return { doc: null, why: `unreadable (${err.message})` };
	}
	let why = doc ? walksUsable(doc, world, navDir) : 'none built';
	const cas = require('./cas');
	const shared = cas.enabled(simDir) && fs.existsSync(walksFile(simDir, world.faction)) ? (d) => cas.store('walks', walksStoreKey(d.dataHash, d.faction, d.router, d.nav), walksFile(simDir, world.faction)) : null;
	if (!why) {
		if (shared) shared(doc);
		return { doc, why: null };
	}
	// The shared store (cas.js): walks built anywhere for this world and these walking maps. The
	// file they replace goes into the store first (under its own world's key).
	if (cas.enabled(simDir)) {
		const keys = [];
		const nodeFp = nodeFingerprint(GRID_DIR);
		if (nodeFp) keys.push(walksStoreKey(world.dataHash, world.faction, 'node', nodeFp));
		if (fs.existsSync(path.join(navDir, 'PACK.json'))) keys.push(walksStoreKey(world.dataHash, world.faction, 'lua', navFingerprint(navDir)));
		for (const k of keys) {
			if (!fs.existsSync(cas.file('walks', k))) continue;
			if (doc && shared && READ_SCHEMAS.has(doc.schema)) shared(doc);
			cas.fetch('walks', k, walksFile(simDir, world.faction));
			const got = readWalks(simDir, world.faction);
			if (!walksUsable(got, world, navDir)) {
				if (log) log(`  walks: ${path.basename(walksFile(simDir, world.faction))} from the shared store (${cas.dir()})`);
				return { doc: got, why: null };
			}
			doc = got;
			why = walksUsable(got, world, navDir);
		}
	}
	if (doc && why !== 'built on another world') return { doc: null, why };
	if (doc && doc.router && doc.router !== 'node') return { doc: null, why };
	const nav = nodeFingerprint(GRID_DIR);
	const file = cacheFile(simDir, world.faction, 'node');
	if (!nav || !fs.existsSync(file) || !fs.existsSync(path.join(navDir, 'PACK.json'))) return { doc: null, why };
	const t0 = Date.now();
	const style = (doc && doc.style) || STYLE;
	const cache = readNodeCache(file, nav, style);
	if (!cache.size) return { doc: null, why };
	const maps = new Set(Object.keys(readPack(navDir).maps).map(Number));
	const radius = (doc && doc.radius) || RADIUS;
	const anchorRadius = (doc && doc.anchorRadius) || ANCHOR_RADIUS;
	const bands = (doc && doc.bands) || [0, ...BANDS];
	const { doc: next, missing } = assembleWalks(world, {
		cache, key: placeKeys(world.points), zoneMins: world.zoneMin || null, bands, router: 'node', nav, smooth: require('../nav/router').SMOOTH, style, radius, anchorRadius,
		queriesOf: (band) => walkQueries(world, { radius, anchorRadius, style, maps, band }),
	});
	if (missing) return { doc: null, why: `${why}; the walk cache lacks ${missing} of this world's walks (\`forge walks walks\` routes them)` };
	writeWalks(simDir, next, { nw: world.points.length });
	if (log) log(`  walks: reassembled from the walk cache for this world (${((Date.now() - t0) / 1000).toFixed(1)} s, no routing)`);
	return { doc: readWalks(simDir, world.faction), why: null };
}

// A walks file's key in the shared store (cas.js): what walksUsable checks it against.
function walksStoreKey(dataHash, faction, router, nav) {
	return `${dataHash}.${String(faction).toLowerCase()}.${router || 'lua'}.${nav || '-'}`;
}

// Why a walks document can't price this world's walks, or null when it can:
// a schema it can't read (schema 2, before one-way walks, still prices every
// pair both ways), another world (pairs are world point indices, so walks
// from another world would price the wrong places) or other walking maps
// (the node router's: the grid in GRID_DIR, when built; the Lua router's, a
// document without doc.router: navDir's PACK.json).
// One check for v1 (attachWalks), the v2 driver (v2/sim.js loadLookup) and
// the v2 commands.
function walksUsable(doc, world, navDir = NAV_DIR) {
	if (!doc || !READ_SCHEMAS.has(doc.schema)) return `schema ${doc ? doc.schema : null}`;
	if (doc.dataHash !== world.dataHash) return 'built on another world';
	if (doc.router === 'node') {
		const fp = nodeFingerprint(GRID_DIR);
		if (fp && doc.nav !== fp) return 'built on another walking grid or node router';
	} else if (fs.existsSync(path.join(navDir, 'PACK.json')) && doc.nav !== navFingerprint(navDir)) return 'built on other walking maps';
	return null;
}

// Walked yards per stored yard of a walks document: its router's (doc.smooth), SMOOTH for a
// document from before routers were named (the Lua router's).
function smoothOf(doc) {
	return typeof doc.smooth === 'number' ? doc.smooth : SMOOTH;
}

// Values per pair in doc.pairs: [a, b, yards, cost, oneWay]; schema 2 (and a
// document without a schema) [a, b, yards, cost], every pair both ways.
function pairStride(doc) {
	return doc.schema >= 3 ? 5 : 4;
}

// What a result records of the walks it used (index.js assertFresh): these walks, on these maps
// (one-way walks: their height threshold).
function walksIdOf(doc) {
	return `${doc.nav.slice(0, 12)}:${doc.style}:${doc.radius}:${doc.anchorRadius}:${doc.bands.join('-')}${doc.oneWayDz != null ? `:dz${doc.oneWayDz}` : ''}`;
}

// world.walks for a run (v1: one walk per pair, band 30's where re-routed, else
// the base walk) and world.walkBands (every band), keyed a * NW + b (world
// point indices, both orders; a one-way walk only its own, over the pair's
// both-ways walk).
function attachWalks(world, simDir, { navDir = NAV_DIR, log } = {}) {
	world.walks = null;
	world.walkBands = null;
	world.walksId = null;
	const { doc, why } = loadWalks(world, simDir, { navDir, log });
	if (!doc) {
		if (log) log(`  walks: ${path.basename(walksFile(simDir, world.faction))} not used (${why}): walking is the straight line × detour; rerun \`forge walks walks . data/local/nav4 <simDir> <faction> <store> <navFp>\` (or forge build)`);
		return null;
	}
	const NW = world.points.length;
	const stride = pairStride(doc);
	const bands = {};
	for (const [band, arr] of Object.entries(doc.pairs)) {
		const m = new Map();
		// Both-ways walks first, then the one-way ones over them.
		for (const one of [0, 1]) {
			for (let i = 0; i < arr.length; i += stride) {
				if ((stride === 5 && arr[i + 4] === 1 ? 1 : 0) !== one) continue;
				const v = [arr[i + 2] * smoothOf(doc), arr[i + 3]];
				m.set(arr[i] * NW + arr[i + 1], v);
				if (!one) m.set(arr[i + 1] * NW + arr[i], v);
			}
		}
		bands[band] = m;
	}
	const m = new Map();
	for (const band of ['0', String(V1_BAND)]) for (const [k, v] of bands[band] || []) m.set(k, v[0]);
	world.walkBands = bands;
	world.walks = m;
	world.walksId = walksIdOf(doc);
	return m;
}

// Every walk in a faction's walk cache, whatever maps or danger rule it was
// routed on: `${ka}|${kb}|${band}` -> [yards, cost] (yards -1: not walkable).
function cachedWalks(dir, faction, router = 'lua') {
	const file = cacheFile(dir, faction, router);
	if (!fs.existsSync(file)) return new Map();
	if (router === 'node') {
		const h = require('./binfile').readBinHeader(file);
		return h ? readNodeCache(file, h.nav, h.style) : new Map();
	}
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	return readCache(file, doc.nav, doc.style, doc.danger).cache;
}

// The cached walks of `band` the router could not make, by why (sim walks
// --report): 'separate' (the ends snap to different grid regions: a lift, a
// boat or nothing joins them; or, in one region, the grid's route either way
// rides a lift, which the world's lift rides cover; or climbs a link the pack
// closes (pack.js CLOSED: the router never climbs there); or one way has no
// grid path: a region joins what one can reach either way, so a drop one only
// falls down is in it), 'noHeight' (an end without a height does not snap),
// 'offGrid' (an end with one does not), 'unknown' (anything else, and two
// ends of one city in different regions: a city is walkable). snap(pt) ->
// { region } or null; route(a, b) -> the grid's route between world points
// (path.js nav.route: { ok, byClass: { lift, climb: seconds, ... } }; gridRoute),
// or none: same-region failures stay 'unknown'. Only 'unknown' counts against
// the gate. walkGap: the 'separate' pairs only a closed climb explains (both
// ways a path, no lift): places the sim cannot reach on foot that the game can.
function classifyFailures(world, cache, { band = 0, snap, route = null, cityMaps = new Set() }) {
	const rides = (r) => r.byClass != null && r.byClass.lift > 0;
	const climbs = (r) => r.byClass != null && r.byClass.climb > 0;
	const P = world.points;
	const byKey = new Map();
	for (let i = 0; i < P.length; i++) byKey.set(keyOf(P, i), i);
	const out = { total: 0, separate: 0, noHeight: 0, offGrid: 0, unknown: 0, pairs: { separate: [], noHeight: [], offGrid: [], unknown: [] }, walkGap: [] };
	const snaps = new Map();
	const at = (pt) => {
		if (!snaps.has(pt)) snaps.set(pt, snap(pt));
		return snaps.get(pt);
	};
	for (const [k, [y]] of cache) {
		if (y !== -1) continue;
		const [ka, kb, bd] = k.split('|');
		if (Number(bd) !== band) continue;
		const a = byKey.get(ka);
		const b = byKey.get(kb);
		if (a == null || b == null) continue;
		out.total++;
		const sa = at(a);
		const sb = at(b);
		let kind = 'unknown';
		if (!sa || !sb) kind = (!sa && P[a][5] == null) || (!sb && P[b][5] == null) ? 'noHeight' : 'offGrid';
		else if (sa.region !== sb.region) kind = P[a][4] === P[b][4] && cityMaps.has(P[a][4]) ? 'unknown' : 'separate';
		else if (route) {
			const ab = route(a, b);
			const ba = route(b, a);
			if (!ab.ok || !ba.ok || rides(ab) || rides(ba)) kind = 'separate';
			else if (climbs(ab) || climbs(ba)) {
				kind = 'separate';
				out.walkGap.push([a, b]);
			}
		}
		out[kind]++;
		out.pairs[kind].push([a, b]);
	}
	return out;
}

// Async variant of classifyFailures: routes same-region pairs across `workers` threads in parallel.
// navDir: the nav grid directory each worker opens; workers: thread count (default all cores).
// Snap objects from snap(pt) are passed to workers via structured clone; they must carry entry and
// tile so nav.route's ensureSnapped returns them as-is (gridSnap results qualify).
async function classifyFailuresParallel(world, cache, { band = 0, snap, cityMaps = new Set(), navDir = NAV_DIR, workers = os.availableParallelism() }) {
	const rides = (r) => r.byClass != null && r.byClass.lift > 0;
	const climbs = (r) => r.byClass != null && r.byClass.climb > 0;
	const P = world.points;
	const byKey = new Map();
	for (let i = 0; i < P.length; i++) byKey.set(keyOf(P, i), i);
	const out = { total: 0, separate: 0, noHeight: 0, offGrid: 0, unknown: 0, pairs: { separate: [], noHeight: [], offGrid: [], unknown: [] }, walkGap: [] };
	const snaps = new Map();
	const at = (pt) => {
		if (!snaps.has(pt)) snaps.set(pt, snap(pt));
		return snaps.get(pt);
	};
	const toRoute = []; // same-region pairs deferred to parallel routing
	for (const [k, [y]] of cache) {
		if (y !== -1) continue;
		const [ka, kb, bd] = k.split('|');
		if (Number(bd) !== band) continue;
		const a = byKey.get(ka);
		const b = byKey.get(kb);
		if (a == null || b == null) continue;
		out.total++;
		const sa = at(a);
		const sb = at(b);
		let kind = 'unknown';
		if (!sa || !sb) kind = (!sa && P[a][5] == null) || (!sb && P[b][5] == null) ? 'noHeight' : 'offGrid';
		else if (sa.region !== sb.region) kind = P[a][4] === P[b][4] && cityMaps.has(P[a][4]) ? 'unknown' : 'separate';
		else { toRoute.push({ a, b, sa, sb }); continue; }
		out[kind]++;
		out.pairs[kind].push([a, b]);
	}
	if (toRoute.length > 0) {
		const routed = await runParallelRoute(toRoute, { navDir, workers });
		for (const { a, b, okAB, okBA, ridesAB, ridesBA, climbsAB, climbsBA } of routed) {
			let kind;
			if (!okAB || !okBA || ridesAB || ridesBA) kind = 'separate';
			else if (climbsAB || climbsBA) { kind = 'separate'; out.walkGap.push([a, b]); }
			else kind = 'unknown';
			out[kind]++;
			out.pairs[kind].push([a, b]);
		}
	}
	return out;
}

// (a, b) -> the grid's route between world points a and b (nav.route on their snap), for classifyFailures.
function gridRoute(nav, snap) {
	return (a, b) => {
		const A = snap(a);
		const B = snap(b);
		return A && B ? nav.route(A, B) : { ok: false, reason: 'no surface', byClass: null };
	};
}

function walkYards(world, a, b) {
	return world.walks ? world.walks.get(a * world.points.length + b) : undefined;
}

// The node router's answer to a `many` query, in the harness's shape ({ id, ok, reason, yards,
// costs }, -1 where a target is not walked). A band query (level) carries the zone danger
// harness.lua gives it: the level's table (zoneMins: world.zoneMin) without the zones of its
// start and of q.to (router.zoneAt). q.cells: each walk's yards per zone cell too (cells: flat
// [cellKey, yards, ...] per target, null where none). q.sig (a band query): each walk's danger
// signature too (sigs: [start zone, q.to's zone, zone, multiplier, ...] of every zone a way no
// costlier than it can enter, router.zonesNear: the walk stands while those multipliers do).
function nodeAnswer(router, q, zoneMins) {
	const { dangerOf } = require('../nav/router');
	const pt = (p) => ({ c: q.map, wx: p[0], wy: p[1], z: p[2] == null ? null : p[2] });
	const from = pt(q.from);
	const to = q.to ? pt(q.to) : from;
	const za = q.level ? router.zoneAt(q.map, from.wx, from.wy) : 0;
	const zb = q.level ? router.zoneAt(q.map, to.wx, to.wy) : 0;
	const danger = q.level ? dangerOf(q.level, zoneMins, za, zb) : null;
	const targets = q.targets.map(pt);
	const r = router.distanceTable([from], targets, { faction: q.profile, style: q.style, danger }, { cells: !!q.cells });
	const out = { type: 'many', id: q.id, ok: true, reason: null, yards: Array.from(r.yards, round1), costs: Array.from(r.costs, round1) };
	if (q.cells) out.cells = r.cells.map((c) => (c ? Array.from(c, (v, i) => (i & 1 ? round1(v) : v)) : null));
	if (q.sig && q.level) {
		out.sigs = targets.map((b, k) => {
			if (!(r.costs[k] >= 0)) return null;
			const sig = [za, zb];
			for (const z of router.zonesNear(q.map, from, b, r.costs[k])) sig.push(z, (danger && danger[z]) || 1);
			return sig;
		});
	}
	return out;
}

// The node router's worker (nodePool): `many` queries in, nodeAnswer's out.
if (!isMainThread && workerData && workerData.walksNodeWorker) {
	const router = require('../nav/router').open(workerData.dir, { shared: workerData.store, zones: workerData.zones, fingerprint: false });
	parentPort.on('message', (queries) => {
		try {
			parentPort.postMessage({ results: queries.map((q) => nodeAnswer(router, q, workerData.zoneMins)) });
		} catch (err) {
			parentPort.postMessage({ error: err && err.stack ? err.stack : String(err) });
		}
	});
}

if (!isMainThread && workerData && workerData.walksWorker) {
	const { runQueries } = require('../nav/eval/run');
	parentPort.on('message', (queries) => {
		try {
			const { results } = runQueries({ navDir: workerData.navDir, queries, zoneLevels: workerData.zoneLevels, warm: workerData.warm || false });
			parentPort.postMessage({ results: results.filter((r) => r.type === 'many').map((r) => ({ id: r.id, ok: r.ok, reason: r.reason, yards: r.yards, costs: r.costs })) });
		} catch (err) {
			parentPort.postMessage({ error: err && err.stack ? err.stack : String(err) });
		}
	});
}

if (!isMainThread && workerData && workerData.zonesWorker) {
	const nav = openGrid(GRID_DIR, workerData.store ? { shared: workerData.store } : { cacheTiles: ZONE_TILES });
	const grids = new Map((workerData.danger || []).map((g) => [g.region, g]));
	parentPort.on('message', (qs) => {
		try {
			const results = qs.map((q) => {
				const g = grids.get(q.r);
				const r = nav && g ? nav.route({ c: q.c, wx: q.a[0], wy: q.a[1] }, { c: q.c, wx: q.b[0], wy: q.b[1] }) : null;
				return { k: q.k, z: r && r.ok ? zoneShares(g, r.pts) : null };
			});
			parentPort.postMessage({ results });
		} catch (err) {
			parentPort.postMessage({ error: err && err.stack ? err.stack : String(err) });
		}
	});
}

if (!isMainThread && workerData && workerData.classifyWorker) {
	const { openNav } = require('../nav/path');
	const nav = openNav({ dir: workerData.navDir });
	const rides = (r) => r.byClass != null && r.byClass.lift > 0;
	const climbs = (r) => r.byClass != null && r.byClass.climb > 0;
	parentPort.on('message', (pairs) => {
		try {
			const results = pairs.map(({ a, b, sa, sb }) => {
				const ab = nav.route(sa, sb);
				const ba = nav.route(sb, sa);
				return { a, b, okAB: ab.ok, okBA: ba.ok, ridesAB: rides(ab), ridesBA: rides(ba), climbsAB: climbs(ab), climbsBA: climbs(ba) };
			});
			parentPort.postMessage({ results });
		} catch (err) {
			parentPort.postMessage({ error: err && err.stack ? err.stack : String(err) });
		}
	});
}

module.exports = { WALKS_SCHEMA, RADIUS, ANCHOR_RADIUS, CAMP_RADIUS, CAMP_CAMP_RADIUS, BANDS, V1_BAND, ONE_WAY_DZ, STYLE, SMOOTH, GRID_DIR, ROUTERS, walksFile, walksJsonFile, cacheFile, readWalks, readWalksHeader, walksContentId, loadWalks, assembleWalks, assembleBand, walksDoc, zoneSharer, readNodeCache, writeNodeCache, bandValid, placeKeys, navFingerprint, nodeFingerprint, walksUsable, smoothOf, zonesOf, nodePool, nodeAnswer, pairStride, zoneGrids, zoneShares, walkZones, walksIdOf, anchorPoints, walkPoints, sendAt, walkQueries, keyOf, openGrid, gridSnap, gridRoute, cachedWalks, classifyFailures, classifyFailuresParallel, buildWalks, writeWalks, attachWalks, walkYards, runParallel };
