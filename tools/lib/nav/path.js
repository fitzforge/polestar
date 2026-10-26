'use strict';
// Routes on the navigation grid (docs/ARCHITECTURE.md, "Navigation grid").
//
//   const { openNav } = require('tools/lib/nav/path');
//   const { profileFor } = require('tools/lib/nav/move');
//   const nav = openNav({ dir: 'data/local/nav', cacheTiles = 256, shared = null });
//   shared: shareNav's store (every tile and graph decoded once into shared memory, for worker
//   threads); its tiles and graphs are read from there, never from files.
//   nav.available                 false without a build (every call then answers null / { ok: false })
//   nav.index                     index.json (format.js), or null
//   Reads grids of tile versions 3 and 4 (format.js TILE_VERSIONS; a version
//   3 tile's tslope is null).
//
//   nav.snap({ c, wx, wy, z?, prefer = 'any', radius = 20, under = false, stand = false })
//     -> { c, wx, wy, z, tile: { col, row }, cell: { i, j }, layer, entry, region, flags } | null
//     The walkable surface (swim surfaces count) nearest the point within
//     `radius` yards; wx, wy are its column's centre, layer its index in the
//     column (format.js), entry its index in the tile, region its region
//     (null when the graph is missing), flags format.js FLAG bits. With z:
//     the surface nearest in 3D (under: one more than UNDER_SLACK above z counts its height
//     difference UNDER_WEIGHT times: a point's height is its feet's; stand: first an open surface
//     within STAND_DZ of z within STAND_RADIUS, by distance plus twice the height gap, as the
//     in-game router snaps an end). Without: first the floor rule, for a point
//     inside a building: the nearest column holding any surface gives its
//     lowest indoor floor (walkable, or blocked only by a low clearance:
//     the floor under an NPC behind a counter; not a slime canal's bed),
//     and a surface level with it (within STEP) is taken, from the 3 x 3
//     columns around when that column has an indoor surface of its own
//     (never the storey above or below), else the nearest within `radius`
//     (an inn's floor, not its roof or the terrain under the city); else in
//     the nearest column with one, an indoor surface (the lowest), then
//     the top surface under the open sky, then terrain ground (the highest),
//     then the lowest; prefer 'indoor' /
//     'ground' first looks for the nearest column holding such a surface.
//     The floor rule and the first pass only take surfaces open both ways
//     (search.js isOpen: walking reaches SNAP_OPEN surfaces from it and it
//     from them; a ledge one only falls off, a roof or a pen one only falls
//     into are not) in regions of at least SNAP_REGION (not a pocket under
//     a floor); the others are taken only when no other is in reach.
//
//   nav.route(a, b, profile = profileFor({}))
//     a, b: snapped points or { c, wx, wy, z?, prefer? } (snapped here)
//     -> { ok, reason, pts: Float32Array (wx, wy, z per point), cls: Uint8Array
//          (per segment, format.js CLS: 0 walk, 1 steep, 2 swim, 3 jump, 4 fall, 5 indoor, 6 climb, 7 lift),
//          yards, seconds, byClass: { walk, steep, climb, swim, indoor, fall, lift } (seconds; jumps
//          count as walk), falls: [{ h, damage }], from, to (the snapped ends),
//          cells (grid steps before smoothing), tiles (tiles the search loaded) }
//     Minimises seconds for the profile (move.js, times its step multipliers). An end in a
//     pocket the search cannot leave or enter is moved to a surface near it (settleCandidates;
//     settled: 'from' or 'to' says which, from / to the moved end). Not ok: reason 'no nav
//     data', 'no surface near the start' / 'near the end', 'different
//     continents', 'different regions' (certain: regions join everything one
//     can reach either way), 'no path'.
//     With { smooth: false }: { ok, reason, yards, seconds, from, to, cells, tiles } of the
//     searched cell path itself (yards its steps' 3D lengths), no line drawn.
//
//   nav.routeMany(a, targets, profile, { limit = Infinity, cellOf }) -> { yards, seconds, cells }
//     (Float64Array per target, -1 where none; cells with cellOf: per target its yards per zone
//     cell): the cell paths route(a, b, { smooth: false }) measures, found for all targets at
//     once (sim walks): see routeMany. Ends in pockets settle as route's do.
//
//   A step's multiplier (edgecost.js's terms beyond time; search.js areaAt), from the profile:
//   profile.ground (optional, router.js): (t, k, flags) -> the road and hostile hub terms of a
//     step into a surface with flags `flags` in column k of tile t, static per faction:
//     profile.groundKey names it (the walk graph and the caches are kept per key), profile.minMult
//     is its smallest value (the searches' heuristics).
//   profile.area (optional, router.js): { key, mult(t, k), touches(t), zoneMult(z) }: zone
//     danger: a step into column k of tile t costs its seconds times mult(t, k) (touches(t): some
//     column of t is above 1); an abstract edge its seconds times its zone mix's (coarseDanger:
//     the shares of its way's seconds per zone, each times zoneMult). key names the multipliers
//     (routeMany's caches keep a tile's legs and pieces per key where it touches).
//   profile.zoneOf (router.js): (t, k) -> the zone of column k of tile t (repriceTiles' zone mix);
//     profile.mixKey names the zones (the zone mix file's name).
//
//   shareNav(dir, continents) -> the store openNav's `shared` reads: every tile and graph of those
//     continents decoded into SharedArrayBuffers (structured clone passes them to workers
//     without copying; the tiles' fall indexes with them), the graphs' foot-profile edge seconds.
//
//   nav.los(a, b) -> boolean  a straight walkable line on the grid (no falls or jumps)
//
// The search: hierarchical A*. Ends at most SHORT_TILES tiles apart are
// searched directly (A* over the tiles around them, heuristic weight
// SHORT_WEIGHT, at most SHORT_EXPAND pops). Otherwise, and when that gives
// up: the continent's abstract graph (graph/<c>.bin.gz, precomputed at build
// time by grid/graph.js: border entrances and lift ends per tile, their
// in-tile shortest costs per reference profile, the links across borders and
// the lift rides; edge seconds per profile cached by edgeSeconds) is searched
// by A*, the ends joined to their tiles' nodes by bounded Dijkstra
// (LEG_NODES, LEG_SLACK; the goal's backwards over search.js inLinks); the
// cell path is stitched from one A* per stretch between consecutive nodes
// (inside one tile, or across one border link or lift; heuristic weight
// PIECE_WEIGHT). The in-tile paths are recomputed per query rather than
// stored: one stored polyline per node pair would take about 1 GB for the
// two continents. Smoothing replaces runs of cells by straight lines over
// walkable cells where that costs no more (never across a fall, a jump or a
// lift; a line is cut where its class changes); simplification drops points
// within SIMPLIFY yd of the line inside runs of one class.

const fs = require('node:fs');
const path = require('node:path');
const {
	ADT, CELL, TILE_CELLS, NO_LINK, NO_COMP, DIRS, FLAG, CLS, REF_PROFILES, AGENT_HEIGHT, WALK_MAX, STEP, decodeTile, decodeGraphRaw, gunzip, cellOf, cellCentre, tileKey,
} = require('./grid/format');
const { Space, MinHeap, inLinks, IN, isOpen, fallIndex, fallsInto, areaAt } = require('./grid/search');
const { TERM_SCALE } = require('./grid/graph');
const { profileFor, linkSeconds, segmentClass, termSeconds, maxSpeed, fallDamage } = require('./move');
const { SETTLE_RADIUS, SETTLE_RISE, SETTLE_DROP, SETTLE_TRIES } = require('./edgecost');
const { ROOT } = require('../paths');

const SIMPLIFY = 1; // yd
const SHORT_TILES = 1; // ends at most this many tiles apart try the local search first
const SHORT_EXPAND = 40000; // ... abandoned after this many pops
// Heuristic weight of the short direct search (routes cost at most this factor more) and of the
// per-stretch searches of a stitched route. Well under 1 / ROAD (edgecost.js): with more slack
// than a road saves, a weighted search walks beside the road it should take.
const SHORT_WEIGHT = 1.05;
const PIECE_WEIGHT = 1.05;
const LEG_NODES = 12; // abstract nodes an end joins at most (tileLegs)
const LEG_SLACK = 30; // s: ... and none further than this beyond the nearest
const OCT = Math.SQRT2 - 1;
const HEURISTIC_WEIGHT = 1; // exact (consistent heuristic); a larger weight trades optimality for speed
const SNAP_REGION = 1000; // walkable surfaces a region needs for snapping to prefer it (about 4,300 yd²)
const SNAP_OPEN = 400; // surfaces an open one reaches (and is reached from) inside its tile
const EDGE_PROFILES = 3; // profiles whose abstract edge seconds a graph keeps (edgeSeconds)
const LEG_CACHE = 20000; // routeMany: goals whose legs a Nav keeps
const PIECE_CACHE = 400000; // routeMany: abstract edges whose cell path's yards a Nav keeps
const WALK_GRAPH_VERSION = 2; // bump when repriceTiles changes: the walk graph files are searched again
// snap's `under`: a surface more than UNDER_SLACK yd above the point's height counts its height
// difference UNDER_WEIGHT times (a point's height is its feet's, a surface over them is a roof).
const UNDER_SLACK = 2;
const UNDER_WEIGHT = 5;
// snap's stand pass (Routing/PathGrid.lua snap): a point with a height stands on a surface within
// STAND_DZ yd of it (ZTOL) within STAND_RADIUS yd (SNAP's 6 cells of 4.17 yd to the square's corners).
const STAND_DZ = 10;
const STAND_RADIUS = 36;
const DEFAULT_DIR = path.join(ROOT, 'data', 'local', 'nav');

const isHop = (cls) => cls === CLS.FALL || cls === CLS.JUMP || cls === CLS.LIFT;

class Nav {
	constructor({ dir = DEFAULT_DIR, cacheTiles = 256, shared = null } = {}) {
		this.dir = dir;
		this.cacheTiles = cacheTiles;
		this.shared = shared;
		this.tiles = new Map();
		this.graphs = new Map();
		this.index = null;
		try {
			this.index = JSON.parse(fs.readFileSync(path.join(dir, 'index.json'), 'utf8'));
		} catch {
			this.index = null;
		}
		this.available = !!(this.index && this.index.continents && Object.keys(this.index.continents).length);
		this.buf = { size: 0 };
		this.legCache = new Map();
		this.pieceCache = new Map();
		// Lift rides by tile: `${c}:${col}_${row}` -> Map entry -> [{ col, row, k, entry, h }].
		this.rides = new Map();
		let lifts = {};
		try {
			lifts = JSON.parse(fs.readFileSync(path.join(dir, 'lifts.json'), 'utf8'));
		} catch {
			lifts = {};
		}
		for (const [c, list] of Object.entries(lifts)) {
			for (const L of list) {
				for (const [x, y] of [[L.a, L.b], [L.b, L.a]]) {
					const key = `${c}:${x.col}_${x.row}`;
					if (!this.rides.has(key)) this.rides.set(key, new Map());
					const m = this.rides.get(key);
					if (!m.has(x.entry)) m.set(x.entry, []);
					m.get(x.entry).push({ col: y.col, row: y.row, k: y.k, entry: y.entry, h: y.z - x.z });
				}
			}
		}
	}

	// A linked tile with its lift rides, or null (cached, least recently used dropped; from the
	// shared store when it holds the tile's continent).
	tile(c, col, row) {
		const key = `${c}:${col}_${row}`;
		if (this.shared && this.shared.continents.includes(Number(c))) {
			const t = this.shared.tiles[key] || null;
			if (t && t.lifts === undefined) t.lifts = this.rides.get(key) || null;
			return t;
		}
		if (this.tiles.has(key)) {
			const t = this.tiles.get(key);
			this.tiles.delete(key);
			this.tiles.set(key, t);
			return t;
		}
		let t = null;
		try {
			t = decodeTile(fs.readFileSync(path.join(this.dir, 'tiles', String(c), `${tileKey(col, row)}.nav.gz`)));
			if (!t.links) t = null;
		} catch {
			t = null;
		}
		if (t) t.lifts = this.rides.get(key) || null;
		this.tiles.set(key, t);
		while (this.tiles.size > this.cacheTiles) this.tiles.delete(this.tiles.keys().next().value);
		return t;
	}

	graph(c) {
		if (this.graphs.has(c)) return this.graphs.get(c);
		let g = null;
		const sg = this.shared && this.shared.graphs[c];
		try {
			g = sg ? decodeGraphRaw(sg.raw) : decodeGraphRaw(gunzip(fs.readFileSync(path.join(this.dir, 'graph', `${c}.bin.gz`))));
		} catch {
			g = null;
		}
		if (g && sg) {
			g.secs = new Map(Object.entries(sg.secs));
			g.walk = new Map(Object.entries(sg.walk || {}));
			if (sg.mix) g.mix = Object.assign([], sg.mix);
		}
		if (g) {
			const N = g.nodeEntry.length;
			g.at = new Map(g.tiles.map((t, i) => [t.col * 65536 + t.row, i]));
			g.nodeTile = new Uint32Array(N);
			g.nodeWx = new Float64Array(N);
			g.nodeWy = new Float64Array(N);
			g.tiles.forEach((t, ti) => {
				for (let x = t.nodeBase; x < t.nodeBase + t.nodeCount; x++) {
					g.nodeTile[x] = ti;
					const k = g.nodeK[x];
					g.nodeWx[x] = (32 - t.row) * ADT - ((k >> 8) + 0.5) * CELL;
					g.nodeWy[x] = (32 - t.col) * ADT - ((k & 255) + 0.5) * CELL;
				}
			});
			g.score = new Float64Array(N);
			g.parent = new Int32Array(N);
			g.stamp = new Uint32Array(N);
			g.gen = 0;
		}
		this.graphs.set(c, g);
		return g;
	}

	region(c, col, row, entry) {
		const g = this.graph(c);
		const t = this.tile(c, col, row);
		if (!g || !t) return null;
		const ti = g.at.get(col * 65536 + row);
		if (ti === undefined || t.comp[entry] === NO_COMP) return null;
		return g.region[g.tiles[ti].compBase + t.comp[entry]];
	}

	// Walkable surfaces in the region of an entry, or null without a graph.
	regionSize(c, col, row, entry) {
		const r = this.region(c, col, row, entry);
		return r === null ? null : this.graph(c).regionSize[r];
	}

	// Whether entry e (column k) of tile t is open both ways (search.js
	// isOpen, SNAP_OPEN surfaces), cached on the tile.
	isOpen(t, k, e) {
		if (!t.open) t.open = new Map();
		if (!t.open.has(e)) t.open.set(e, isOpen(t, k, e, SNAP_OPEN));
		return t.open.get(e);
	}

	// snap's floor rule (see there): cells nearest first; usable, make: snap's.
	floorSnap(c, cells, usable, make) {
		let c0 = null;
		let t0 = null;
		let k0 = -1;
		for (const cell of cells) {
			const t = this.tile(c, cell.col, cell.row);
			if (!t) continue;
			const k = cell.j * TILE_CELLS + cell.i;
			if (t.first[k] === t.first[k + 1]) continue;
			c0 = cell;
			t0 = t;
			k0 = k;
			break;
		}
		if (!c0) return null;
		let zf = null;
		let strictIndoor = false;
		for (let e = t0.first[k0]; e < t0.first[k0 + 1]; e++) {
			if (!(t0.flags[e] & FLAG.INDOOR)) continue;
			if (zf === null && (!(t0.flags[e] & FLAG.BLOCKED) || (t0.ceil[e] - t0.z[e] < AGENT_HEIGHT && t0.slope[e] <= WALK_MAX))) zf = t0.z[e];
			if (usable(t0, k0, c0, e, true)) strictIndoor = true;
		}
		if (zf === null) return null;
		const gi0 = c0.col * TILE_CELLS + c0.i;
		const gj0 = c0.row * TILE_CELLS + c0.j;
		for (const cell of cells) {
			if (strictIndoor && (Math.abs(cell.col * TILE_CELLS + cell.i - gi0) > 1 || Math.abs(cell.row * TILE_CELLS + cell.j - gj0) > 1)) continue;
			const t = this.tile(c, cell.col, cell.row);
			if (!t) continue;
			const k = cell.j * TILE_CELLS + cell.i;
			let best = -1;
			let bestDz = Infinity;
			for (let e = t.first[k]; e < t.first[k + 1]; e++) {
				const dz = Math.abs(t.z[e] - zf);
				if (dz <= STEP && dz < bestDz && usable(t, k, cell, e, true)) {
					best = e;
					bestDz = dz;
				}
			}
			if (best >= 0) return make(t, k, cell, best);
		}
		return null;
	}

	snap({ c, wx, wy, z = null, prefer = 'any', radius = 20, under = false, stand = false } = {}) {
		if (!this.available || !Number.isFinite(wx) || !Number.isFinite(wy)) return null;
		const at = cellOf(wx, wy);
		// With stand and a height, the cells out to STAND_RADIUS (the stand pass below), else to radius.
		const standing = stand && Number.isFinite(z);
		const reach = standing ? Math.max(radius, STAND_RADIUS) : radius;
		const R = Math.ceil(reach / CELL);
		const cells = [];
		for (let dj = -R; dj <= R; dj++) {
			for (let di = -R; di <= R; di++) {
				const gi = at.col * TILE_CELLS + at.i + di;
				const gj = at.row * TILE_CELLS + at.j + dj;
				const col = Math.floor(gi / TILE_CELLS);
				const row = Math.floor(gj / TILE_CELLS);
				const i = gi - col * TILE_CELLS;
				const j = gj - row * TILE_CELLS;
				const ctr = cellCentre(col, row, i, j);
				const dh = Math.hypot(ctr.wx - wx, ctr.wy - wy);
				if (dh <= reach + CELL) cells.push({ col, row, i, j, dh, ...ctr });
			}
		}
		cells.sort((a, b) => a.dh - b.dh);
		const walk = (fn) => {
			for (const cell of cells) {
				const t = this.tile(c, cell.col, cell.row);
				if (!t) continue;
				const k = cell.j * TILE_CELLS + cell.i;
				const r = fn(t, k, cell);
				if (r) return r;
			}
			return null;
		};
		const make = (t, k, cell, e) => ({
			c, wx: cell.wx, wy: cell.wy, z: t.z[e], tile: { col: cell.col, row: cell.row }, cell: { i: cell.i, j: cell.j },
			layer: e - t.first[k], entry: e, region: this.region(c, cell.col, cell.row, e), flags: t.flags[e],
		});
		// Strict passes only consider open surfaces (isOpen) of regions of at
		// least SNAP_REGION; pockets under floors, roofs and rock tops are left
		// for the loose pass.
		const usable = (t, k, cell, e, strict) => {
			if (t.flags[e] & FLAG.BLOCKED) return false;
			if (!strict) return true;
			const size = this.regionSize(c, cell.col, cell.row, e);
			return (size === null || size >= SNAP_REGION) && this.isOpen(t, k, e);
		};
		const pick = (t, k, cell, strict, test, highest) => {
			let best = -1;
			for (let e = t.first[k]; e < t.first[k + 1]; e++) {
				if (!usable(t, k, cell, e, strict) || !test(t.flags[e], t.ceil[e])) continue;
				if (best < 0 || highest) best = e;
			}
			return best;
		};
		// Outdoors (no indoor floor in the column) a place stands on its top surface under the open
		// sky: the terrain under a city's streets, a harbour's decks or a bridge is the ground the
		// models were built over, not where anyone stands.
		const rule = (t, k, cell, strict) => {
			let e = pick(t, k, cell, strict, (f) => f & FLAG.INDOOR, false);
			if (e < 0) e = pick(t, k, cell, strict, (f, ceil) => ceil === Infinity, true);
			if (e < 0) e = pick(t, k, cell, strict, (f) => f & FLAG.TERRAIN, true);
			if (e < 0) e = pick(t, k, cell, strict, () => true, false);
			return e;
		};
		// Without z, a point over an indoor floor means that floor (an NPC
		// behind a counter, under a roof, in a room the grid closes): the
		// lowest indoor floor of the nearest column holding any surface,
		// walkable or blocked only by a low clearance (not a slime canal's bed
		// or a face). A strict surface level with it (within STEP) is taken:
		// in the 3 x 3 columns around when that column has a strict indoor
		// surface of its own (not across a floor to the storey below), else
		// the nearest within `radius` (not the terrain under a city).
		if (!Number.isFinite(z) && prefer === 'any') {
			const r = this.floorSnap(c, cells, usable, make);
			if (r) return r;
		}
		// stand (the router's ends, its attach step): a point with a height stands on an open
		// surface within STAND_DZ of it, the least distance plus twice the height gap, when one lies
		// within STAND_RADIUS (Routing/PathGrid.lua snap: SNAP cells, ZTOL), before any other: the
		// mesa top a point at its edge means, not the canyon floor under the drop beside it.
		if (standing) {
			let best = null;
			let bestCost = Infinity;
			for (const cell of cells) {
				if (cell.dh > bestCost) break;
				const t = this.tile(c, cell.col, cell.row);
				if (!t) continue;
				const k = cell.j * TILE_CELLS + cell.i;
				for (let e = t.first[k]; e < t.first[k + 1]; e++) {
					const gap = Math.abs(t.z[e] - z);
					if (gap > STAND_DZ || cell.dh + 2 * gap >= bestCost || !usable(t, k, cell, e, true)) continue;
					bestCost = cell.dh + 2 * gap;
					best = { t, k, cell, e };
				}
			}
			if (best) return make(best.t, best.k, best.cell, best.e);
		}
		for (const strict of [true, false]) {
			if (Number.isFinite(z)) {
				let best = null;
				let bestScore = Infinity;
				for (const cell of cells) {
					if (cell.dh > bestScore || cell.dh > radius + CELL) break;
					const t = this.tile(c, cell.col, cell.row);
					if (!t) continue;
					const k = cell.j * TILE_CELLS + cell.i;
					for (let e = t.first[k]; e < t.first[k + 1]; e++) {
						if (!usable(t, k, cell, e, strict)) continue;
						const dz = t.z[e] - z;
						const score = Math.hypot(cell.dh, under && dz > UNDER_SLACK ? dz * UNDER_WEIGHT : dz);
						if (score < bestScore) {
							bestScore = score;
							best = { t, k, cell, e };
						}
					}
				}
				if (best) return make(best.t, best.k, best.cell, best.e);
				continue;
			}
			if (prefer === 'indoor' || prefer === 'ground') {
				const flag = prefer === 'indoor' ? FLAG.INDOOR : FLAG.TERRAIN;
				const r = walk((t, k, cell) => {
					const e = pick(t, k, cell, strict, (f) => f & flag, prefer === 'ground');
					return e >= 0 ? make(t, k, cell, e) : null;
				});
				if (r) return r;
			}
			const r = walk((t, k, cell) => {
				const e = rule(t, k, cell, strict);
				return e >= 0 ? make(t, k, cell, e) : null;
			});
			if (r) return r;
		}
		return null;
	}

	ensureSnapped(p) {
		if (!p) return null;
		if (p.entry !== undefined && p.tile) return p;
		return this.snap(p);
	}

	los(a, b) {
		const A = this.ensureSnapped(a);
		const B = this.ensureSnapped(b);
		if (!A || !B || A.c !== B.c) return false;
		const tiles = this.tilesBetween(A, B);
		const space = new Space(tiles);
		const sa = space.slot(A.tile.col, A.tile.row);
		const sb = space.slot(B.tile.col, B.tile.row);
		if (sa < 0 || sb < 0) return false;
		const r = this.lineCost(space, sa, A.entry, A.cell.j * 256 + A.cell.i, sb, B.entry, B.cell.j * 256 + B.cell.i, profileFor({}));
		return r.ok;
	}

	// The straight line between two points as los walks it, cut where its link class changes: null when it is no
	// straight walkable line, else lineCost's runs ([{ cls, seconds, t, z }]; cls CLS.SWIM where it swims).
	lineRuns(a, b) {
		const A = this.ensureSnapped(a);
		const B = this.ensureSnapped(b);
		if (!A || !B || A.c !== B.c) return null;
		const space = new Space(this.tilesBetween(A, B));
		const sa = space.slot(A.tile.col, A.tile.row);
		const sb = space.slot(B.tile.col, B.tile.row);
		if (sa < 0 || sb < 0) return null;
		const r = this.lineCost(space, sa, A.entry, A.cell.j * 256 + A.cell.i, sb, B.entry, B.cell.j * 256 + B.cell.i, profileFor({}), true);
		return r.ok ? r.runs : null;
	}

	// The tiles a straight line between two snapped points crosses (bounding box).
	tilesBetween(A, B) {
		const out = [];
		for (let col = Math.min(A.tile.col, B.tile.col); col <= Math.max(A.tile.col, B.tile.col); col++) {
			for (let row = Math.min(A.tile.row, B.tile.row); row <= Math.max(A.tile.row, B.tile.row); row++) {
				const t = this.tile(A.c, col, row);
				if (t) out.push(t);
			}
		}
		return out;
	}

	// The straight line from entry ea (slot sa, column ka) to eb, stepping
	// cell to cell through links (walk, steep, swim; no jumps or falls) ->
	// { ok, seconds, cls (the class most of its steps have), runs? }. With
	// `runs`: the line cut where its class changes, [{ cls, seconds, t, z }]
	// (t: the end along the line, 0..1; z: the height there).
	lineCost(space, sa, ea, ka, sb, eb, kb, p, runs = false) {
		const ta = space.tiles[sa];
		const tb = space.tiles[sb];
		let x = ta.col * 256 + (ka & 255);
		let y = ta.row * 256 + (ka >> 8);
		const x1 = tb.col * 256 + (kb & 255);
		const y1 = tb.row * 256 + (kb >> 8);
		const dx = x1 - x;
		const dy = y1 - y;
		const sx = Math.sign(dx);
		const sy = Math.sign(dy);
		const adx = Math.abs(dx);
		const ady = Math.abs(dy);
		// Amanatides-Woo from centre to centre, in units of the line's parameter.
		const tdx = adx ? 1 / adx : Infinity;
		const tdy = ady ? 1 / ady : Infinity;
		let tmx = adx ? 0.5 / adx : Infinity;
		let tmy = ady ? 0.5 / ady : Infinity;
		let slot = sa;
		let e = ea;
		let k = ka;
		const st = this.lineScratch || (this.lineScratch = {
			dz: new Float64Array(4096), fa: new Uint8Array(4096), fb: new Uint8Array(4096), cls: new Uint8Array(4096), t: new Float64Array(4096), z: new Float64Array(4096), m: new Float64Array(4096),
		});
		let steps = 0;
		while (x !== x1 || y !== y1) {
			let mx = 0;
			let my = 0;
			const cross = Math.min(tmx, tmy);
			if (Math.abs(tmx - tmy) < 1e-9) {
				mx = sx;
				my = sy;
				tmx += tdx;
				tmy += tdy;
			} else if (tmx < tmy) {
				mx = sx;
				tmx += tdx;
			} else {
				my = sy;
				tmy += tdy;
			}
			let d = -1;
			for (let q = 0; q < 8; q++) if (DIRS[q][0] === mx && DIRS[q][1] === my) d = q;
			const t = space.tiles[slot];
			const b = t.links[e * 8 + d];
			if (b === NO_LINK || b >> 5 === CLS.JUMP) return { ok: false };
			const k2 = space.col(slot, (k & 255) + mx, (k >> 8) + my);
			if (k2 < 0) return { ok: false };
			const s2 = space.rs;
			const t2 = space.tiles[s2];
			const v = t2.first[k2] + (b & 31);
			if (steps === st.dz.length) {
				for (const key of Object.keys(st)) {
					const a = new st[key].constructor(steps * 2);
					a.set(st[key]);
					st[key] = a;
				}
			}
			st.dz[steps] = t2.z[v] - t.z[e];
			st.fa[steps] = t.flags[e];
			st.fb[steps] = t2.flags[v];
			st.cls[steps] = b >> 5;
			st.t[steps] = cross;
			st.z[steps] = t2.z[v];
			st.m[steps] = areaAt(p, t2, k2, t2.flags[v]);
			steps++;
			x += mx;
			y += my;
			slot = s2;
			e = v;
			k = k2;
		}
		if (slot !== sb || e !== eb) return { ok: false };
		if (!steps) return { ok: true, seconds: 0, cls: CLS.WALK, runs: [] };
		const h = (Math.hypot(dx, dy) * CELL) / steps;
		let seconds = 0;
		const counts = [0, 0, 0, 0, 0, 0];
		const out = runs ? [] : null;
		for (let s = 0; s < steps; s++) {
			const len = Math.sqrt(h * h + st.dz[s] * st.dz[s]);
			const sec = linkSeconds(p, st.cls[s], st.fa[s], st.fb[s], len) * st.m[s];
			const c = segmentClass(st.cls[s], st.fa[s], st.fb[s]);
			seconds += sec;
			counts[c]++;
			if (!out) continue;
			const last = out[out.length - 1];
			if (last && last.cls === c) last.seconds += sec;
			else {
				if (last) {
					last.t = st.t[s];
					last.z = st.z[s - 1];
				}
				out.push({ cls: c, seconds: sec, t: 1, z: st.z[steps - 1] });
			}
		}
		let cls = 0;
		for (let q = 1; q < 6; q++) if (counts[q] > counts[cls]) cls = q;
		return { ok: true, seconds, cls, runs: out };
	}

	// Seconds from entry e of tile t to every abstract node of the tile in its
	// component (forward), or from them to e (reverse), inside the tile; also
	// to `target` (an entry of the same tile) when given.
	tileLegs(g, ti, t, e, k, p, reverse, target = -1) {
		const info = g.tiles[ti];
		const want = new Map();
		if (info) {
			for (let x = info.nodeBase; x < info.nodeBase + info.nodeCount; x++) if (t.comp[g.nodeEntry[x]] === t.comp[e]) want.set(g.nodeEntry[x], x);
		}
		if (target >= 0 && t.comp[target] !== t.comp[e]) target = -1;
		const space = new Space([t]);
		// Scratch over the tile's entries, reused: dist valid where stamp is this call's.
		let sc = this.legScratch;
		if (!sc || sc.dist.length < t.n) {
			const cap = Math.max(t.n, sc ? sc.dist.length * 2 : 1 << 17);
			sc = this.legScratch = { dist: new Float64Array(cap), kOf: new Int32Array(cap), stamp: new Uint32Array(cap), gen: 0, heap: new MinHeap(4096) };
		}
		if (++sc.gen === 0xffffffff) {
			sc.stamp.fill(0);
			sc.gen = 1;
		}
		const { dist, kOf, stamp, gen, heap } = sc;
		const D = (v) => (stamp[v] === gen ? dist[v] : Infinity);
		heap.size = 0;
		stamp[e] = gen;
		dist[e] = 0;
		kOf[e] = k;
		heap.push(0, e);
		let left = want.size + (target >= 0 ? 1 : 0);
		const legs = [];
		let direct = Infinity;
		// Bounded: past LEG_NODES nodes or LEG_SLACK seconds beyond the first
		// one (once the target, if any, is found) the rest are left out.
		while (heap.size && left > 0) {
			const u = heap.pop();
			if (heap.top > dist[u]) continue;
			if (legs.length && (target < 0 || direct < Infinity) && (legs.length >= LEG_NODES || heap.top > legs[0][1] + LEG_SLACK)) break;
			if (want.has(u)) {
				legs.push([want.get(u), dist[u]]);
				left--;
			}
			if (u === target) {
				direct = dist[u];
				left--;
			}
			if (!reverse) {
				const cnt = space.expand(0, u, kOf[u], p);
				for (let x = 0; x < cnt; x++) {
					const v = space.outTo[x];
					const nd = dist[u] + space.outCost[x];
					if (nd < D(v)) {
						stamp[v] = gen;
						dist[v] = nd;
						kOf[v] = space.outK[x];
						heap.push(nd, v);
					}
				}
			} else {
				const cnt = inLinks(t, u, kOf[u], p);
				for (let x = 0; x < cnt; x++) {
					const src = IN.from[x];
					const nd = dist[u] + IN.cost[x];
					if (nd < D(src)) {
						stamp[src] = gen;
						dist[src] = nd;
						kOf[src] = IN.k[x];
						heap.push(nd, src);
					}
				}
			}
		}
		return { legs, direct };
	}

	// The abstract route: the ends joined to their tiles' nodes by bounded
	// Dijkstra inside the tiles (tileLegs), A* over the continent's graph ->
	// { nodes: [node] from A's side to B's, seconds, direct } (direct: the
	// in-tile way from A to B is best; nodes empty) | null.
	abstractPath(c, A, B, p) {
		const g = this.graph(c);
		const ta = this.tile(c, A.tile.col, A.tile.row);
		const tb = this.tile(c, B.tile.col, B.tile.row);
		const key = (col, row) => col * 65536 + row;
		const ka = key(A.tile.col, A.tile.row);
		const kb = key(B.tile.col, B.tile.row);
		const same = ka === kb;
		if (!g || !ta || !tb) return null;
		const gi = REF_PROFILES.indexOf(p.ref);
		const gr = g.graphs[gi < 0 ? 0 : gi];
		const tia = g.at.get(ka);
		const tib = g.at.get(kb);
		const start = this.tileLegs(g, tia, ta, A.entry, A.cell.j * 256 + A.cell.i, p, false, same ? B.entry : -1);
		const goal = this.tileLegs(g, tib, tb, B.entry, B.cell.j * 256 + B.cell.i, p, true);
		const toGoal = new Map(goal.legs);
		let best = start.direct;
		let bestNode = -1;
		g.gen++;
		if (g.gen === 0xffffffff) {
			g.stamp.fill(0);
			g.gen = 1;
		}
		const { score, parent, stamp, gen } = { score: g.score, parent: g.parent, stamp: g.stamp, gen: g.gen };
		const vmax = maxSpeed(p) / (p.minMult || 1);
		const nwx = g.nodeWx;
		const nwy = g.nodeWy;
		const h = (x) => {
			const dx = nwx[x] - B.wx;
			const dy = nwy[x] - B.wy;
			return Math.sqrt(dx * dx + dy * dy) / vmax;
		};
		const heap = this.absHeap || (this.absHeap = new MinHeap(1 << 14));
		heap.size = 0;
		for (const [x, s] of start.legs) {
			stamp[x] = gen;
			score[x] = s;
			parent[x] = -1;
			heap.push(s + h(x), x);
		}
		const secs = this.edgeSecs(c, g, gi < 0 ? 0 : gi, p);
		const dm = this.coarseDanger(c, g, gi < 0 ? 0 : gi, p);
		const { off, to } = gr;
		while (heap.size) {
			const u = heap.pop();
			if (heap.top >= best) break;
			const gu = score[u];
			if (heap.top > gu + h(u) + 1e-9) continue;
			const tg = toGoal.get(u);
			if (tg !== undefined && gu + tg < best) {
				best = gu + tg;
				bestNode = u;
			}
			for (let x = off[u], end = off[u + 1]; x < end; x++) {
				const v = to[x];
				const nd = gu + secs[x] * (dm ? dm(x, u) : 1);
				if (stamp[v] !== gen || nd < score[v]) {
					stamp[v] = gen;
					score[v] = nd;
					parent[v] = u;
					heap.push(nd + h(v), v);
				}
			}
		}
		if (best === Infinity) return null;
		if (bestNode < 0) return { nodes: [], seconds: best, direct: true };
		const nodes = [];
		for (let u = bestNode; u !== -1; u = parent[u]) nodes.push(u);
		nodes.reverse();
		return { nodes, seconds: best, direct: false };
	}

	// Abstract node x of continent c as a snapped point.
	nodePoint(c, x) {
		const g = this.graph(c);
		const info = g.tiles[g.nodeTile[x]];
		const k = g.nodeK[x];
		return {
			c, wx: g.nodeWx[x], wy: g.nodeWy[x], z: g.nodeZ[x], tile: { col: info.col, row: info.row }, cell: { i: k & 255, j: k >> 8 }, entry: g.nodeEntry[x],
		};
	}

	// The cell path A -> B through abstract nodes: a bounded A* per stretch
	// (inside one tile, or across the two tiles of a border link or a lift),
	// joined -> the search() shape over one Space, or null.
	stitch(c, A, B, nodes, p) {
		const pts = [A, ...nodes.map((x) => this.nodePoint(c, x)), B];
		const pieces = [];
		for (let x = 0; x + 1 < pts.length; x++) {
			const U = pts[x];
			const V = pts[x + 1];
			if (U.tile.col === V.tile.col && U.tile.row === V.tile.row && U.entry === V.entry) continue;
			const ok = new Set([U.tile.col * 65536 + U.tile.row, V.tile.col * 65536 + V.tile.row]);
			const piece = this.search(c, (col, row) => ok.has(col * 65536 + row), U, V, p, Infinity, PIECE_WEIGHT);
			if (!piece) return null;
			pieces.push(piece);
		}
		const space = new Space([], (col, row) => this.tile(c, col, row));
		let n = 1;
		for (const q of pieces) n += q.n - 1;
		const slotOf = new Int32Array(n);
		const entry = new Int32Array(n);
		const kk = new Int32Array(n);
		const stepCls = new Uint8Array(Math.max(0, n - 1));
		const stepCost = new Float64Array(Math.max(0, n - 1));
		const stepH = new Float64Array(Math.max(0, n - 1));
		const C = new Float64Array(n);
		slotOf[0] = space.slot(A.tile.col, A.tile.row);
		entry[0] = A.entry;
		kk[0] = A.cell.j * 256 + A.cell.i;
		let at = 0;
		for (const q of pieces) {
			for (let y = 1; y < q.n; y++) {
				at++;
				const t = q.space.tiles[q.slotOf[y]];
				slotOf[at] = space.slot(t.col, t.row);
				entry[at] = q.entry[y];
				kk[at] = q.kk[y];
				stepCls[at - 1] = q.stepCls[y - 1];
				stepCost[at - 1] = q.stepCost[y - 1];
				stepH[at - 1] = q.stepH[y - 1];
				C[at] = C[at - 1] + q.stepCost[y - 1];
			}
		}
		return { space, n, slotOf, entry, kk, stepCls, stepCost, stepH, C };
	}

	// Scratch arrays for the exact search: grow(size) keeps their contents
	// (a search that loads tiles grows them); a new search bumps `gen`.
	grow(size) {
		const old = this.buf;
		if (old.size >= size) return old;
		const cap = Math.max(size, Math.ceil(old.size * 1.5), 1 << 18);
		const buf = {
			size: cap, g: new Float64Array(cap), parent: new Int32Array(cap), k: new Int32Array(cap), cls: new Uint8Array(cap),
			cost: new Float64Array(cap), h: new Float32Array(cap), slot: new Int32Array(cap), stamp: new Uint32Array(cap), closed: new Uint32Array(cap), gen: old.gen || 0,
		};
		if (old.size) for (const key of ['g', 'parent', 'k', 'cls', 'cost', 'h', 'slot', 'stamp', 'closed']) buf[key].set(old[key]);
		this.buf = buf;
		return buf;
	}

	// A* from A to B over the tiles allow(col, row) admits (loaded as
	// reached; heuristic weight `weight`, 1 exact), abandoned once the best
	// estimate passes `limit` seconds or after maxExpand pops -> the cell path or null.
	search(c, allow, A, B, p, limit, weight = HEURISTIC_WEIGHT, maxExpand = Infinity) {
		const space = new Space([], (col, row) => (allow(col, row) ? this.tile(c, col, row) : null));
		const sa = space.slot(A.tile.col, A.tile.row);
		const sb = space.slot(B.tile.col, B.tile.row);
		if (sa < 0 || sb < 0) return null;
		let st = this.grow(space.size);
		st.gen++;
		if (st.gen === 0xffffffff) {
			st.stamp.fill(0);
			st.closed.fill(0);
			st.gen = 1;
		}
		const gen = st.gen;
		let { g: gs, parent, k: kOf, cls: pCls, cost: pCost, h: pH, slot: slotArr, stamp, closed } = st;
		const S = space.base[sa] + A.entry;
		const G = space.base[sb] + B.entry;
		// Octile distance to B over the fastest speed, times the profile's smallest step
		// multiplier (p.minMult, edgecost.js MIN_MULT: a road): every move costs at least
		// its horizontal length at that speed times it (falls at least a second), so the
		// heuristic is consistent. Weighted by HEURISTIC_WEIGHT (expanded nodes
		// are not reopened): routes cost at most that factor of the optimum.
		const scale = ((CELL * (p.minMult || 1)) / maxSpeed(p)) * weight;
		const bi = B.tile.col * TILE_CELLS + B.cell.i;
		const bj = B.tile.row * TILE_CELLS + B.cell.j;
		const hOf = (slot, k) => {
			const t = space.tiles[slot];
			const dx = Math.abs(t.col * TILE_CELLS + (k & 255) - bi);
			const dy = Math.abs(t.row * TILE_CELLS + (k >> 8) - bj);
			return (dx > dy ? dx + OCT * dy : dy + OCT * dx) * scale;
		};
		const heap = this.searchHeap || (this.searchHeap = new MinHeap(1 << 14));
		heap.size = 0;
		stamp[S] = gen;
		gs[S] = 0;
		parent[S] = -1;
		kOf[S] = A.cell.j * 256 + A.cell.i;
		slotArr[S] = sa;
		heap.push(hOf(sa, kOf[S]), S);
		let found = false;
		while (heap.size) {
			const u = heap.pop();
			if (u === G) {
				found = true;
				break;
			}
			if (heap.top > limit || --maxExpand < 0) break;
			const slot = slotArr[u];
			const e = u - space.base[slot];
			const gu = gs[u];
			const ku = kOf[u];
			if (closed[u] === gen) continue;
			closed[u] = gen;
			const cnt = space.expand(slot, e, ku, p);
			if (space.size > st.size) {
				st = this.grow(space.size);
				({ g: gs, parent, k: kOf, cls: pCls, cost: pCost, h: pH, slot: slotArr, stamp, closed } = st);
			}
			for (let x = 0; x < cnt; x++) {
				const v = space.outTo[x];
				const nd = gu + space.outCost[x];
				if (closed[v] !== gen && (stamp[v] !== gen || nd < gs[v])) {
					stamp[v] = gen;
					gs[v] = nd;
					parent[v] = u;
					const kv = space.outK[x];
					kOf[v] = kv;
					const sv = space.outSlot[x];
					slotArr[v] = sv;
					pCls[v] = space.outCls[x];
					pCost[v] = space.outCost[x];
					pH[v] = space.outH[x];
					heap.push(nd + hOf(sv, kv), v);
				}
			}
		}
		if (!found) return null;
		const nodes = [];
		for (let u = G; u !== -1; u = parent[u]) nodes.push(u);
		nodes.reverse();
		const n = nodes.length;
		const slotOf = new Int32Array(n);
		const entry = new Int32Array(n);
		const kk = new Int32Array(n);
		const stepCls = new Uint8Array(Math.max(0, n - 1));
		const stepCost = new Float64Array(Math.max(0, n - 1));
		const stepH = new Float64Array(Math.max(0, n - 1));
		const C = new Float64Array(n);
		for (let x = 0; x < n; x++) {
			const u = nodes[x];
			slotOf[x] = slotArr[u];
			entry[x] = u - space.base[slotOf[x]];
			kk[x] = kOf[u];
			if (x > 0) {
				stepCls[x - 1] = pCls[u];
				stepCost[x - 1] = pCost[u];
				stepH[x - 1] = pH[u];
				C[x] = C[x - 1] + pCost[u];
			}
		}
		return { space, n, slotOf, entry, kk, stepCls, stepCost, stepH, C };
	}

	// Seconds of every abstract edge of graph gi of continent c for profile p: from the edge terms
	// (edgeSeconds), or for a profile that prices links its own way (reprices) the walk graph:
	// kept on the graph (g.walk, never dropped: one per faction at most), else read from
	// walkGraphFile (router.js prepare builds it on worker threads: repriceTiles over every tile);
	// none there is an error.
	edgeSecs(c, g, gi, p) {
		if (!reprices(p)) return edgeSeconds(g, gi, p);
		const key = edgeKey(gi, p);
		if (!g.walk) g.walk = new Map();
		let s = g.walk.get(key);
		if (s) return s;
		const file = this.walkGraphFile(c, gi, p);
		if (!fs.existsSync(file)) throw new Error(`path: no walk graph ${file} for continent ${c} (tools/lib/nav/router.js prepare builds it; sim walks does)`);
		const buf = fs.readFileSync(file);
		s = new Float32Array(buf.buffer, buf.byteOffset, buf.byteLength / 4).slice();
		g.walk.set(key, s);
		return s;
	}

	// Where the walk graph of continent c's graph gi for profile p is kept: <dir>/walk/, named by
	// the graph file's size, the build (index.json builtAt) and the profile's prices.
	walkGraphFile(c, gi, p) {
		const gz = path.join(this.dir, 'graph', `${c}.bin.gz`);
		const size = fs.existsSync(gz) ? fs.statSync(gz).size : 0;
		const tag = require('node:crypto').createHash('sha1').update(`${WALK_GRAPH_VERSION}|${this.index && this.index.builtAt}|${size}|${edgeKey(gi, p)}`).digest('hex').slice(0, 16);
		return path.join(this.dir, 'walk', `${c}-${gi}-${tag}.f32`);
	}

	// The walk graph's edge seconds (edgeSecs) of the edges leaving the nodes of g.tiles[t0, t1)
	// into out: an edge inside a tile by a search of the tile from its start node (tileTree, p's
	// own prices and ground: edgecost.js's road and hostile hub terms), an edge across a border or
	// a lift its terms' seconds (edgeSeconds), times p.faceMul where either end stands on a
	// FLAG.STEEP column, times the ground multiplier of the surface it enters. only(ti): the tiles
	// to search (the rest of out is left as it is), every one without.
	repriceTiles(c, g, gi, p, t0, t1, out, only = null) {
		const { off, to } = g.graphs[gi];
		const plain = edgeSeconds(g, gi, { ...p, faceMul: 0, slopeMul: null, area: null });
		const q = { ...p, area: null };
		for (let ti = t0; ti < t1; ti++) {
			if (only && !only(ti)) continue;
			const info = g.tiles[ti];
			const t = this.tile(c, info.col, info.row);
			for (let u = info.nodeBase; u < info.nodeBase + info.nodeCount; u++) {
				const sc = t ? this.tileTree(t, g.nodeEntry[u], g.nodeK[u], q, false, 'fwdScratch') : null;
				const fu = t ? t.flags[g.nodeEntry[u]] : 0;
				for (let x = off[u]; x < off[u + 1]; x++) {
					const v = to[x];
					const ev = g.nodeEntry[v];
					if (sc && g.nodeTile[v] === ti && sc.stamp[ev] === sc.gen) {
						out[x] = sc.dist[ev];
						continue;
					}
					const vi = g.tiles[g.nodeTile[v]];
					const tv = g.nodeTile[v] === ti ? t : this.tile(c, vi.col, vi.row);
					const fv = tv ? tv.flags[ev] : 0;
					out[x] = plain[x] * (p.faceMul && (fu | fv) & FLAG.STEEP ? p.faceMul : 1) * (tv ? areaAt(q, tv, g.nodeK[v], fv) : 1);
				}
			}
		}
		return out;
	}

	// The zone mix (zoneMix) of the edges leaving the nodes of g.tiles[t0, t1), for p (the
	// factionless walk profile; p.zoneOf): nodeZone[u] gets each node's zone; an edge whose way
	// inside its tile (tileTree, as repriceTiles prices it) steps into columns of zones other than
	// its start node's adds, per such zone, the share of its seconds spent stepping into them
	// (add(x, zone, share)); an edge across a border or a lift ride is one step into its end node's
	// zone (share 1 when that is another).
	mixTiles(c, g, gi, p, t0, t1, nodeZone, add) {
		const { off, to } = g.graphs[gi];
		const q = { ...p, area: null };
		for (let ti = t0; ti < t1; ti++) {
			const info = g.tiles[ti];
			const t = this.tile(c, info.col, info.row);
			const zoneOfNode = (v) => {
				const vi = g.tiles[g.nodeTile[v]];
				const tv = g.nodeTile[v] === ti ? t : this.tile(c, vi.col, vi.row);
				return tv ? p.zoneOf(tv, g.nodeK[v]) : 0;
			};
			// The tile's zones (its chunks'), indexed for the per-entry seconds vectors.
			const zones = [];
			if (t) for (let ch = 0; ch < 256; ch++) {
				const z = p.zoneOf(t, ((ch >> 4) * 16 + 8) * TILE_CELLS + (ch & 15) * 16 + 8);
				if (!zones.includes(z)) zones.push(z);
			}
			const Z = zones.length;
			for (let u = info.nodeBase; u < info.nodeBase + info.nodeCount; u++) {
				const home = (nodeZone[u] = t ? p.zoneOf(t, g.nodeK[u]) : 0);
				const sc = t && Z > 1 ? this.tileTree(t, g.nodeEntry[u], g.nodeK[u], q, false, 'fwdScratch') : null;
				let acc = null;
				if (sc) {
					if (!this.mixScratch || this.mixScratch.stamp.length < t.n || this.mixScratch.acc.length < t.n * Z) this.mixScratch = { stamp: new Uint32Array(Math.max(t.n, 1 << 17)), acc: new Float64Array(Math.max(t.n * Z, 1 << 19)) };
					const ms = this.mixScratch;
					const { par, dist, kOf, gen } = sc;
					const stack = [];
					// Seconds per tile zone of the tree's way to entry e (memoized for this tree).
					acc = (e) => {
						let y = e;
						while (y !== -1 && ms.stamp[y] !== gen) {
							stack.push(y);
							y = par[y];
						}
						while (stack.length) {
							const s = stack.pop();
							const pr = par[s];
							for (let z = 0; z < Z; z++) ms.acc[s * Z + z] = pr === -1 ? 0 : ms.acc[pr * Z + z];
							if (pr !== -1) ms.acc[s * Z + zones.indexOf(p.zoneOf(t, kOf[s]))] += dist[s] - dist[pr];
							ms.stamp[s] = gen;
						}
						return ms.acc.subarray(e * Z, e * Z + Z);
					};
				}
				for (let x = off[u]; x < off[u + 1]; x++) {
					const v = to[x];
					const ev = g.nodeEntry[v];
					if (g.nodeTile[v] === ti && (!sc || sc.stamp[ev] === sc.gen)) {
						if (!sc) continue; // one zone in the tile: all of it the start node's
						const total = sc.dist[ev];
						const secs = acc(ev);
						if (total > 0) for (let z = 0; z < Z; z++) if (zones[z] !== home && secs[z] > 0) add(x, zones[z], secs[z] / total);
						continue;
					}
					const zv = zoneOfNode(v);
					if (zv !== home) add(x, zv, 1);
				}
			}
		}
	}

	// Dijkstra over one tile from entry e (column k): forward (from it, Space.expand) or, reverse,
	// back (to it, inLinks: no lifts) -> scratch `which` { dist, yd, par, kOf, stamp, gen }: dist
	// (seconds), yd (that way's 3D yards), par (the entry before, forward; after, reverse) and kOf
	// (its column) valid where stamp is gen. Two scratches are kept, so the start's forward tree
	// outlives the goals' reverse ones.
	tileTree(t, e, k, p, reverse, which) {
		let sc = this[which];
		if (!sc || sc.dist.length < t.n) {
			const cap = Math.max(t.n, sc ? sc.dist.length * 2 : 1 << 17);
			sc = this[which] = { dist: new Float64Array(cap), yd: new Float64Array(cap), par: new Int32Array(cap), kOf: new Int32Array(cap), stamp: new Uint32Array(cap), done: new Uint32Array(cap), gen: 0, heap: new MinHeap(4096) };
		}
		if (++sc.gen === 0xffffffff) {
			sc.stamp.fill(0);
			sc.done.fill(0);
			sc.gen = 1;
		}
		const { dist, yd, par, kOf, stamp, done, gen, heap } = sc;
		heap.size = 0;
		stamp[e] = gen;
		dist[e] = 0;
		yd[e] = 0;
		par[e] = -1;
		kOf[e] = k;
		heap.push(0, e);
		const space = reverse ? null : new Space([t]);
		while (heap.size) {
			const u = heap.pop();
			if (done[u] === gen) continue;
			done[u] = gen;
			const du = dist[u];
			if (!reverse) {
				const cnt = space.expand(0, u, kOf[u], p);
				for (let x = 0; x < cnt; x++) {
					if (space.outSlot[x] !== 0) continue;
					const v = space.outTo[x];
					const nd = du + space.outCost[x];
					if (stamp[v] !== gen || nd < dist[v]) {
						stamp[v] = gen;
						dist[v] = nd;
						yd[v] = yd[u] + space.outD[x];
						par[v] = u;
						kOf[v] = space.outK[x];
						heap.push(nd, v);
					}
				}
			} else {
				const cnt = inLinks(t, u, kOf[u], p);
				for (let x = 0; x < cnt; x++) {
					const s = IN.from[x];
					const nd = du + IN.cost[x];
					if (stamp[s] !== gen || nd < dist[s]) {
						stamp[s] = gen;
						dist[s] = nd;
						yd[s] = yd[u] + IN.d[x];
						par[s] = u;
						kOf[s] = IN.k[x];
						heap.push(nd, s);
					}
				}
			}
		}
		return sc;
	}

	// The yards of a tree's way per zone cell (cellOf: world x, y -> key), added to acc (Map key ->
	// yards): forward, the way from the root to entry e (each step counted in the cell of the
	// column it enters); reverse, the way from e to the root.
	treeCells(t, sc, e, reverse, cellOf, acc) {
		const { yd, par, kOf } = sc;
		for (let v = e; par[v] !== -1; v = par[v]) {
			const w = reverse ? par[v] : v;
			const k = kOf[w];
			const key = cellOf((32 - t.row) * ADT - ((k >> 8) + 0.5) * CELL, (32 - t.col) * ADT - ((k & 255) + 0.5) * CELL);
			acc.set(key, (acc.get(key) || 0) + Math.abs(yd[v] - yd[par[v]]));
		}
		return acc;
	}

	// The legs into goal B from its tile's nodes, each node's way inside the tile:
	// { nodes: Int32Array, sec, yd: Float64Array, cells: per node flat [key, yards, ...] | null },
	// kept per goal (and area key where the area touches the tile) in legCache. cellOf: the zone
	// cells to count the ways in (the cells kept with the legs; none without).
	goalLegs(c, g, B, p, cellOf = null) {
		const t = this.tile(c, B.tile.col, B.tile.row);
		const touched = !!(t && p.area && p.area.touches(t));
		const key = `${c}:${B.tile.col}_${B.tile.row}:${B.entry}:${p.outdoor}:${p.indoor}:${p.swim}:${p.groundKey || ''}:${touched ? p.area.key : ''}`;
		let L = this.legCache.get(key);
		if (L && (L.cells || !cellOf)) return L;
		const ti = g.at.get(B.tile.col * 65536 + B.tile.row);
		const nodes = [];
		const sec = [];
		const yd = [];
		const cells = cellOf ? [] : null;
		if (t && ti !== undefined) {
			const info = g.tiles[ti];
			const sc = this.tileTree(t, B.entry, B.cell.j * 256 + B.cell.i, p, true, 'backScratch');
			for (let x = info.nodeBase; x < info.nodeBase + info.nodeCount; x++) {
				const e = g.nodeEntry[x];
				if (sc.stamp[e] !== sc.gen) continue;
				nodes.push(x);
				sec.push(sc.dist[e]);
				yd.push(sc.yd[e]);
				if (cells) cells.push(flatCells(this.treeCells(t, sc, e, true, cellOf, new Map())));
			}
		}
		L = { nodes: Int32Array.from(nodes), sec: Float64Array.from(sec), yd: Float64Array.from(yd), cells };
		this.legCache.set(key, L);
		if (this.legCache.size > LEG_CACHE) this.legCache.delete(this.legCache.keys().next().value);
		return L;
	}

	// The cell path between abstract nodes u and v (one A* over their tiles, as stitch joins
	// them): { y: its yards, cells: flat [key, yards, ...] by cellOf, or null without }, kept per
	// pair (and area key where the area touches their tiles) in pieceCache.
	piece(c, g, u, v, p, cellOf = null) {
		const U = this.nodePoint(c, u);
		const V = this.nodePoint(c, v);
		const tu = this.tile(c, U.tile.col, U.tile.row);
		const tv = this.tile(c, V.tile.col, V.tile.row);
		const touched = !!(p.area && ((tu && p.area.touches(tu)) || (tv && p.area.touches(tv))));
		const key = `${c}:${u}:${v}:${p.outdoor}:${p.indoor}:${p.swim}:${p.groundKey || ''}:${touched ? p.area.key : ''}`;
		let pc = this.pieceCache.get(key);
		if (pc && (pc.cells || !cellOf)) return pc;
		if (U.tile.col === V.tile.col && U.tile.row === V.tile.row && U.entry === V.entry) pc = { y: 0, cells: cellOf ? [] : null };
		else {
			const ok = new Set([U.tile.col * 65536 + U.tile.row, V.tile.col * 65536 + V.tile.row]);
			const cells = this.search(c, (col, row) => ok.has(col * 65536 + row), U, V, p, Infinity, PIECE_WEIGHT);
			const acc = cellOf ? new Map() : null;
			const y = cells ? cellYards(cells, cellOf, acc) : Math.hypot(U.wx - V.wx, U.wy - V.wy, U.z - V.z);
			if (acc && !cells) acc.set(cellOf(V.wx, V.wy), y);
			pc = { y, cells: acc ? flatCells(acc) : null };
		}
		this.pieceCache.set(key, pc);
		if (this.pieceCache.size > PIECE_CACHE) this.pieceCache.delete(this.pieceCache.keys().next().value);
		return pc;
	}

	// Zone danger on the coarse graph (edgecost.js danger): an edge of continent c's graph gi costs
	// its seconds times Σ over the zones its way crosses of the share of its seconds spent there ×
	// the zone's multiplier (zoneMix: the shares on the factionless walk graph's ways, so the sum
	// of the way's step weights). -> (x, u) => the multiplier of edge x out of node u, or null
	// without danger.
	coarseDanger(c, g, gi, p) {
		if (!p.area) return null;
		const { off, zone, frac, nodeZone } = this.zoneMix(c, g, gi, p);
		const zm = p.area.zoneMult;
		return (x, u) => {
			let m = 0;
			let rest = 1;
			for (let y = off[x]; y < off[x + 1]; y++) {
				m += frac[y] * zm(zone[y]);
				rest -= frac[y];
			}
			return m + rest * zm(nodeZone[u]);
		};
	}

	// The zone mix of continent c's graph gi (router.js prepare measures it with repriceTiles' mix):
	// { nodeZone: Uint16Array (each node's column's zone), off: Uint32Array(E + 1), zone: Uint16Array,
	// frac: Float32Array }: edge x's way spends frac[y] of its seconds in zone[y] for y in [off[x],
	// off[x + 1]), the rest in its start node's zone. Kept on the graph (or from the shared store),
	// else read from walkMixFile; none there is an error.
	zoneMix(c, g, gi, p) {
		if (!g.mix) g.mix = [];
		if (g.mix[gi]) return g.mix[gi];
		const file = this.walkMixFile(c, gi, p);
		if (!fs.existsSync(file)) throw new Error(`path: no zone mix ${file} for continent ${c} (tools/lib/nav/router.js prepare builds it; sim walks does)`);
		g.mix[gi] = decodeMix(fs.readFileSync(file));
		return g.mix[gi];
	}

	// Where the zone mix of continent c's graph gi is kept: next to the walk graphs, named as the
	// factionless one's and by the zones (p.mixKey).
	walkMixFile(c, gi, p) {
		const gz = path.join(this.dir, 'graph', `${c}.bin.gz`);
		const size = fs.existsSync(gz) ? fs.statSync(gz).size : 0;
		const tag = require('node:crypto').createHash('sha1').update(`${WALK_GRAPH_VERSION}|${this.index && this.index.builtAt}|${size}|${gi}|${p.mixKey || ''}`).digest('hex').slice(0, 16);
		return path.join(this.dir, 'walk', `${c}-${gi}-${tag}.mix`);
	}

	// One start, many goals (sim walks' searches). The start's tile is searched whole from it
	// (tileTree: goals inside it directly, its nodes' legs); one Dijkstra over the continent's
	// abstract graph from those nodes (edges as abstractPath prices them) settles every goal: a
	// goal is joined from its own tile's nodes (goalLegs, its tile searched back from it) and is
	// done once the search passes its best; the search stops when every goal is done or past
	// `limit` seconds. A goal's yards are its two legs' and, per abstract edge on its way, the
	// cell path between the edge's nodes (piece): the cell path route(..., { smooth: false })
	// measures, up to the pieces' heuristic weight. Unlike route, ends in the same or
	// neighbouring tiles are not searched directly over the tiles around them: the way leaves the
	// start's tile through its nodes (a goal in the same tile also directly inside it).
	// cellOf (world x, y -> a zone cell's key): each goal's yards per cell too (cells).
	// -> { yards, seconds: Float64Array per target, -1 where none; cells: per target flat
	// [key, yards, ...] or null (with cellOf) }.
	routeMany(a, targets, profile = profileFor({}), { limit = Infinity, cellOf = null, settled = false } = {}) {
		const T = targets.length;
		const yards = new Float64Array(T).fill(-1);
		const seconds = new Float64Array(T).fill(-1);
		const out = { yards, seconds, cells: cellOf ? new Array(T).fill(null) : null };
		if (!this.available || !T) return out;
		const A = this.ensureSnapped(a);
		if (!A) return out;
		const c = A.c;
		const p = profile;
		const ta = this.tile(c, A.tile.col, A.tile.row);
		if (!ta) return out;
		const g = this.graph(c);
		const Bs = targets.map((b) => this.ensureSnapped(b));
		const fw = this.tileTree(ta, A.entry, A.cell.j * 256 + A.cell.i, p, false, 'fwdScratch');
		const best = new Float64Array(T).fill(Infinity);
		const bestYd = new Float64Array(T);
		const via = new Int32Array(T).fill(-1); // the node a goal is joined from; -1: directly inside the start's tile
		const viaYd = new Float64Array(T);
		const viaLeg = new Int32Array(T).fill(-1); // its leg's index in its goal's legs
		const legsOf = new Array(T);
		const live = [];
		for (let t = 0; t < T; t++) {
			const B = Bs[t];
			if (!B || B.c !== c) continue;
			if (A.region !== null && B.region !== null && A.region !== B.region) continue;
			live.push(t);
			if (B.tile.col === A.tile.col && B.tile.row === A.tile.row && fw.stamp[B.entry] === fw.gen) {
				best[t] = fw.dist[B.entry];
				bestYd[t] = fw.yd[B.entry];
			}
		}
		if (!live.length) return out;
		const ti = g ? g.at.get(A.tile.col * 65536 + A.tile.row) : undefined;
		const startYd = new Map();
		const parent = g ? g.parent : null;
		if (ti !== undefined) {
			const info = g.tiles[ti];
			const starts = [];
			for (let x = info.nodeBase; x < info.nodeBase + info.nodeCount; x++) {
				const e = g.nodeEntry[x];
				if (fw.stamp[e] !== fw.gen) continue;
				starts.push(x, fw.dist[e]);
				startYd.set(x, fw.yd[e]);
			}
			// A start in a pocket that reaches none of its tile's nodes and no goal: moved to a surface
			// near it (settleCandidates), the first from which some goal is reached (the tries reuse
			// this search's scratch, so none reached is the answer).
			if (!starts.length && info.nodeCount > 0 && !settled && live.every((t) => best[t] === Infinity)) {
				for (const S of this.settleCandidates(A, p, false)) {
					const r = this.routeMany(S, targets, profile, { limit, cellOf, settled: true });
					if (r.seconds.some((s) => s >= 0)) return r;
				}
				return out;
			}
			// Goal legs by node: [goal, seconds, yards, leg index, ...].
			const goalAt = new Map();
			for (const t of live) {
				const L = (legsOf[t] = this.goalLegs(c, g, Bs[t], p, cellOf));
				for (let y = 0; y < L.nodes.length; y++) {
					let arr = goalAt.get(L.nodes[y]);
					if (!arr) goalAt.set(L.nodes[y], (arr = []));
					arr.push(t, L.sec[y], L.yd[y], y);
				}
			}
			const gi = Math.max(0, REF_PROFILES.indexOf(p.ref));
			const { off, to } = g.graphs[gi];
			const secs = this.edgeSecs(c, g, gi, p);
			const dm = this.coarseDanger(c, g, gi, p);
			g.gen++;
			if (g.gen === 0xffffffff) {
				g.stamp.fill(0);
				g.gen = 1;
			}
			const { score, stamp, gen } = g;
			const heap = this.absHeap || (this.absHeap = new MinHeap(1 << 14));
			heap.size = 0;
			for (let s = 0; s < starts.length; s += 2) {
				const x = starts[s];
				stamp[x] = gen;
				score[x] = starts[s + 1];
				parent[x] = -1;
				heap.push(starts[s + 1], x);
			}
			const worstBest = () => {
				let w = 0;
				for (const t of live) if (best[t] > w) w = best[t];
				return w;
			};
			let worst = worstBest();
			while (heap.size) {
				const u = heap.pop();
				const gu = heap.top;
				if (gu > score[u]) continue;
				if (gu >= worst || gu > limit) break;
				const ga = goalAt.get(u);
				if (ga) {
					let better = false;
					for (let y = 0; y < ga.length; y += 4) {
						const t = ga[y];
						const s = gu + ga[y + 1];
						if (s < best[t]) {
							best[t] = s;
							via[t] = u;
							viaYd[t] = ga[y + 2];
							viaLeg[t] = ga[y + 3];
							better = true;
						}
					}
					if (better) worst = worstBest();
				}
				for (let x = off[u], end = off[u + 1]; x < end; x++) {
					const v = to[x];
					const nd = gu + secs[x] * (dm ? dm(x, u) : 1);
					if (stamp[v] !== gen || nd < score[v]) {
						stamp[v] = gen;
						score[v] = nd;
						parent[v] = u;
						heap.push(nd, v);
					}
				}
			}
			// A goal in a pocket the search never entered: the nearest surface around it that the search
			// reached (settleCandidates), as route() moves it.
			for (const t of live) {
				if (best[t] !== Infinity) continue;
				for (const S of this.settleCandidates(Bs[t], p, true)) {
					if (S.tile.col === A.tile.col && S.tile.row === A.tile.row && fw.stamp[S.entry] === fw.gen) {
						best[t] = fw.dist[S.entry];
						bestYd[t] = fw.yd[S.entry];
						Bs[t] = S;
						break;
					}
					const L = this.goalLegs(c, g, S, p, cellOf);
					for (let y = 0; y < L.nodes.length; y++) {
						const x = L.nodes[y];
						if (stamp[x] !== gen || score[x] + L.sec[y] >= best[t]) continue;
						best[t] = score[x] + L.sec[y];
						via[t] = x;
						viaYd[t] = L.yd[y];
						viaLeg[t] = y;
						legsOf[t] = L;
						Bs[t] = S;
					}
					if (best[t] < Infinity) break;
				}
			}
		}
		for (const t of live) {
			if (best[t] === Infinity) continue;
			seconds[t] = best[t];
			const acc = cellOf ? new Map() : null;
			if (via[t] < 0) {
				yards[t] = bestYd[t];
				if (acc) out.cells[t] = flatCells(this.treeCells(ta, fw, Bs[t].entry, false, cellOf, acc));
				continue;
			}
			let y = viaYd[t];
			let v = via[t];
			for (let u = parent[v]; u !== -1; v = u, u = parent[u]) {
				const pc = this.piece(c, g, u, v, p, cellOf);
				y += pc.y;
				if (acc) addCells(acc, pc.cells);
			}
			yards[t] = y + startYd.get(v);
			if (acc) {
				this.treeCells(ta, fw, g.nodeEntry[v], false, cellOf, acc);
				addCells(acc, legsOf[t].cells[viaLeg[t]]);
				out.cells[t] = flatCells(acc);
			}
		}
		return out;
	}

	// An end in a pocket (edgecost.js "Ends", Routing/Path.lua settle): the surfaces within
	// SETTLE_RADIUS yd of snapped end E, from SETTLE_DROP below it to SETTLE_RISE above, in its
	// region, outside its own pocket inside its tile (what E reaches, for a start; what reaches E,
	// for a goal: a way from or to any of those is no other way), nearest first, at most
	// SETTLE_TRIES -> [snapped point].
	settleCandidates(E, p, goal) {
		const t0 = this.tile(E.c, E.tile.col, E.tile.row);
		if (!t0) return [];
		const sc = this.tileTree(t0, E.entry, E.cell.j * TILE_CELLS + E.cell.i, p, goal, 'settleScratch');
		const R = Math.ceil(SETTLE_RADIUS / CELL);
		const gi0 = E.tile.col * TILE_CELLS + E.cell.i;
		const gj0 = E.tile.row * TILE_CELLS + E.cell.j;
		const out = [];
		for (let dj = -R; dj <= R; dj++) {
			for (let di = -R; di <= R; di++) {
				const dh = Math.hypot(di, dj) * CELL;
				if (dh > SETTLE_RADIUS) continue;
				const col = Math.floor((gi0 + di) / TILE_CELLS);
				const row = Math.floor((gj0 + dj) / TILE_CELLS);
				const t = this.tile(E.c, col, row);
				if (!t) continue;
				const i = gi0 + di - col * TILE_CELLS;
				const j = gj0 + dj - row * TILE_CELLS;
				const k = j * TILE_CELLS + i;
				for (let e = t.first[k]; e < t.first[k + 1]; e++) {
					if (t.flags[e] & FLAG.BLOCKED) continue;
					const dz = t.z[e] - E.z;
					if (dz > SETTLE_RISE || dz < -SETTLE_DROP) continue;
					if (t === t0 && sc.stamp[e] === sc.gen) continue;
					const region = this.region(E.c, col, row, e);
					if (E.region !== null && region !== E.region) continue;
					out.push({ dh, dz: Math.abs(dz), pt: { c: E.c, ...cellCentre(col, row, i, j), z: t.z[e], tile: { col, row }, cell: { i, j }, layer: e - t.first[k], entry: e, region, flags: t.flags[e] } });
				}
			}
		}
		out.sort((a, b) => a.dh - b.dh || a.dz - b.dz);
		return out.slice(0, SETTLE_TRIES).map((x) => x.pt);
	}

	route(a, b, profile = profileFor({}), { smooth = true, settled = false } = {}) {
		const fail = (reason, extra = {}) => ({ ok: false, reason, pts: new Float32Array(0), cls: new Uint8Array(0), yards: 0, seconds: 0, byClass: null, falls: [], ...extra });
		if (!this.available) return fail('no nav data');
		const A = this.ensureSnapped(a);
		const B = this.ensureSnapped(b);
		if (!A) return fail('no surface near the start', { to: B });
		if (!B) return fail('no surface near the end', { from: A });
		if (A.c !== B.c) return fail('different continents', { from: A, to: B });
		if (A.region !== null && B.region !== null && A.region !== B.region) return fail('different regions', { from: A, to: B });
		const c = A.c;
		const p = profile;
		let cells = null;
		// Near ends: A* over the tiles around them first, abandoned after
		// SHORT_EXPAND pops (then the hierarchical search finds the way round).
		const span = Math.max(Math.abs(A.tile.col - B.tile.col), Math.abs(A.tile.row - B.tile.row));
		if (span <= SHORT_TILES) {
			const c0 = Math.min(A.tile.col, B.tile.col) - 1;
			const c1 = Math.max(A.tile.col, B.tile.col) + 1;
			const r0 = Math.min(A.tile.row, B.tile.row) - 1;
			const r1 = Math.max(A.tile.row, B.tile.row) + 1;
			cells = this.search(c, (col, row) => col >= c0 && col <= c1 && row >= r0 && row <= r1, A, B, p, Infinity, SHORT_WEIGHT, SHORT_EXPAND);
		}
		if (!cells) {
			const abs = this.abstractPath(c, A, B, p);
			if (abs && abs.direct) {
				const one = A.tile.col * 65536 + A.tile.row;
				cells = this.search(c, (col, row) => col * 65536 + row === one, A, B, p, Infinity);
			} else if (abs) cells = this.stitch(c, A, B, abs.nodes, p);
		}
		if (!cells) {
			// An end in a pocket: the goal, then the start, moved to a surface near it (settleCandidates).
			if (!settled) {
				for (const goal of [true, false]) {
					for (const S of this.settleCandidates(goal ? B : A, p, goal)) {
						const r = this.route(goal ? A : S, goal ? S : B, profile, { smooth, settled: true });
						if (r.ok) return { ...r, settled: goal ? 'to' : 'from' };
					}
				}
			}
			return fail('no path', { from: A, to: B });
		}
		const { space, n, slotOf, entry, kk, stepCls, stepCost, stepH, C } = cells;
		if (!smooth) return { ok: true, reason: null, yards: cellYards(cells), seconds: C[n - 1], from: A, to: B, cells: n, tiles: space.tiles.length };
		// Smoothing: from each anchor, the farthest point a straight line
		// reaches for no more seconds (galloping, then bisection).
		const segs = []; // { to, cls, seconds } per step, or { from, to, t, z, cls, seconds } per run of a line
		const lineOk = (a0, j) => {
			const r = this.lineCost(space, slotOf[a0], entry[a0], kk[a0], slotOf[j], entry[j], kk[j], p);
			return r.ok && r.seconds <= C[j] - C[a0] + 1e-6;
		};
		let a0 = 0;
		while (a0 < n - 1) {
			if (isHop(stepCls[a0])) {
				segs.push({ to: a0 + 1, cls: stepCls[a0], seconds: stepCost[a0] });
				a0++;
				continue;
			}
			let lim = a0 + 1;
			while (lim < n - 1 && !isHop(stepCls[lim])) lim++;
			let good = a0 + 1;
			let span = 2;
			let bad = lim + 1;
			while (a0 + span <= lim) {
				if (!lineOk(a0, a0 + span)) {
					bad = a0 + span;
					break;
				}
				good = a0 + span;
				span *= 2;
			}
			if (good === lim) bad = good + 1;
			while (bad - good > 1) {
				const mid = (good + bad) >> 1;
				if (lineOk(a0, mid)) good = mid;
				else bad = mid;
			}
			if (good === a0 + 1) segs.push({ to: good, cls: stepCls[a0], seconds: stepCost[a0] });
			else {
				const r = this.lineCost(space, slotOf[a0], entry[a0], kk[a0], slotOf[good], entry[good], kk[good], p, true);
				for (const run of r.runs) segs.push({ from: a0, to: good, t: run.t, z: run.z, cls: run.cls, seconds: run.seconds });
			}
			a0 = good;
		}
		// Points (a line's class changes cut it where they happen) and
		// simplification within runs of one class.
		const P = (x) => {
			const t = space.tiles[slotOf[x]];
			const ctr = cellCentre(t.col, t.row, kk[x] & 255, kk[x] >> 8);
			return [ctr.wx, ctr.wy, t.z[entry[x]]];
		};
		const ptsList = [P(0)];
		const clsList = [];
		const secList = [];
		for (const sg of segs) {
			if (sg.t === undefined || sg.t >= 1) ptsList.push(P(sg.to));
			else {
				const a = P(sg.from);
				const b = P(sg.to);
				ptsList.push([a[0] + (b[0] - a[0]) * sg.t, a[1] + (b[1] - a[1]) * sg.t, sg.z]);
			}
			clsList.push(sg.cls);
			secList.push(sg.seconds);
		}
		const keep = simplify(ptsList, clsList);
		const pts = [];
		const outCls = [];
		let yards = 0;
		const byClass = { walk: 0, steep: 0, climb: 0, swim: 0, indoor: 0, fall: 0, lift: 0 };
		const names = ['walk', 'steep', 'swim', 'walk', 'fall', 'indoor', 'climb', 'lift'];
		let seconds = 0;
		for (let x = 0; x < secList.length; x++) {
			byClass[names[clsList[x]]] += secList[x];
			seconds += secList[x];
		}
		for (let x = 0; x < keep.length; x++) {
			const q = ptsList[keep[x]];
			pts.push(q[0], q[1], q[2]);
			if (x > 0) {
				const pq = ptsList[keep[x - 1]];
				yards += Math.hypot(q[0] - pq[0], q[1] - pq[1], q[2] - pq[2]);
				outCls.push(clsList[keep[x] - 1]);
			}
		}
		const falls = [];
		for (let x = 0; x < n - 1; x++) {
			if (stepCls[x] !== CLS.FALL) continue;
			const t2 = space.tiles[slotOf[x + 1]];
			const water = (t2.flags[entry[x + 1]] & FLAG.SWIM) !== 0;
			falls.push({ h: Math.round(stepH[x] * 100) / 100, damage: Math.round(fallDamage(stepH[x], water) * 1000) / 1000 });
		}
		return {
			ok: true, reason: null, pts: Float32Array.from(pts), cls: Uint8Array.from(outCls), yards, seconds, byClass, falls, from: A, to: B,
			cells: n, tiles: space.tiles.length,
		};
	}
}

// Douglas-Peucker (SIMPLIFY yd, 3D) inside runs of one class -> kept point indices.
function simplify(pts, cls) {
	const keep = new Uint8Array(pts.length);
	keep[0] = 1;
	keep[pts.length - 1] = 1;
	for (let x = 1; x < pts.length - 1; x++) if (cls[x - 1] !== cls[x]) keep[x] = 1;
	const dist = (p, a, b) => {
		const ab = [b[0] - a[0], b[1] - a[1], b[2] - a[2]];
		const ap = [p[0] - a[0], p[1] - a[1], p[2] - a[2]];
		const L = ab[0] * ab[0] + ab[1] * ab[1] + ab[2] * ab[2];
		const s = L ? Math.max(0, Math.min(1, (ap[0] * ab[0] + ap[1] * ab[1] + ap[2] * ab[2]) / L)) : 0;
		return Math.hypot(ap[0] - s * ab[0], ap[1] - s * ab[1], ap[2] - s * ab[2]);
	};
	const rec = (lo, hi) => {
		let worst = -1;
		let wd = SIMPLIFY;
		for (let x = lo + 1; x < hi; x++) {
			const d = dist(pts[x], pts[lo], pts[hi]);
			if (d > wd) {
				wd = d;
				worst = x;
			}
		}
		if (worst < 0) return;
		keep[worst] = 1;
		rec(lo, worst);
		rec(worst, hi);
	};
	let lo = 0;
	for (let x = 1; x < pts.length; x++) {
		if (!keep[x]) continue;
		rec(lo, x);
		lo = x;
	}
	const out = [];
	for (let x = 0; x < pts.length; x++) if (keep[x]) out.push(x);
	return out;
}

// Seconds of every edge of abstract graph gi of g for profile p (move.js
// termSeconds of its terms), cached on g for the last EDGE_PROFILES profiles.
function edgeSeconds(g, gi, p) {
	const key = edgeKey(gi, p);
	if (!g.secs) g.secs = new Map();
	let s = g.secs.get(key);
	if (s) {
		g.secs.delete(key);
		g.secs.set(key, s);
		return s;
	}
	const { terms } = g.graphs[gi];
	const E = terms.length / 7;
	s = new Float32Array(E);
	const sc = TERM_SCALE;
	for (let x = 0, o = 0; x < E; x++, o += 7) {
		s[x] = termSeconds(p, terms[o] / sc[0], terms[o + 1] / sc[1], terms[o + 2] / sc[2], terms[o + 3] / sc[3], terms[o + 4] / sc[4], terms[o + 5] / sc[5], terms[o + 6] / sc[6]);
	}
	g.secs.set(key, s);
	while (g.secs.size > EDGE_PROFILES) g.secs.delete(g.secs.keys().next().value);
	return s;
}

// p.groundKey names p.ground's multipliers (router.js: the road mask and the faction's hostile hubs).
function edgeKey(gi, p) {
	return `${gi}|${p.outdoor}|${p.indoor}|${p.swim}|${p.remount}|${p.faceMul || 0}|${p.slopeMul ? p.slopeMul.join(',') : ''}|${p.groundKey || ''}`;
}

// Whether profile p prices links its own way (move.js slopeMul, faceMul; p.ground): the graph's edge
// terms do not hold its prices, so its edge seconds come from a search per tile (Nav.repriceTiles).
const reprices = (p) => !!(p.faceMul || p.slopeMul || p.ground);

// A zone mix (Nav.zoneMix) as bytes and back: uint32 E (edges), M (entries), N (nodes), then
// nodeZone (uint16 × N), off (uint32 × E + 1), zone (uint16 × M), frac (float32 × M), each
// section padded to 4 bytes. With shared: the arrays in SharedArrayBuffers (router.js share).
const pad4 = (n) => (n + 3) & ~3;
function encodeMix({ nodeZone, off, zone, frac }) {
	const N = nodeZone.length;
	const E = off.length - 1;
	const M = zone.length;
	const buf = Buffer.alloc(12 + pad4(2 * N) + 4 * (E + 1) + pad4(2 * M) + 4 * M);
	buf.writeUInt32LE(E, 0);
	buf.writeUInt32LE(M, 4);
	buf.writeUInt32LE(N, 8);
	let o = 12;
	for (const [arr, size] of [[nodeZone, pad4(2 * N)], [off, 4 * (E + 1)], [zone, pad4(2 * M)], [frac, 4 * M]]) {
		Buffer.from(arr.buffer, arr.byteOffset, arr.byteLength).copy(buf, o);
		o += size;
	}
	return buf;
}
function decodeMix(buf, shared = false) {
	const E = buf.readUInt32LE(0);
	const M = buf.readUInt32LE(4);
	const N = buf.readUInt32LE(8);
	let o = 12;
	const take = (Type, n, size) => {
		const a = new Type(shared ? new SharedArrayBuffer(n * Type.BYTES_PER_ELEMENT) : n * Type.BYTES_PER_ELEMENT);
		a.set(new Type(buf.buffer.slice(buf.byteOffset + o, buf.byteOffset + o + n * Type.BYTES_PER_ELEMENT)));
		o += size;
		return a;
	};
	const nodeZone = take(Uint16Array, N, pad4(2 * N));
	const off = take(Uint32Array, E + 1, 4 * (E + 1));
	const zone = take(Uint16Array, M, pad4(2 * M));
	const frac = take(Float32Array, M, 4 * M);
	return { nodeZone, off, zone, frac };
}

// The 3D yards of a searched cell path (search()'s shape): cell centre to cell centre. With
// cellOf and acc (Map), each step's yards are added to the zone cell of the column it enters.
function cellYards({ space, n, slotOf, entry, kk }, cellOf = null, acc = null) {
	let yards = 0;
	let t = space.tiles[slotOf[0]];
	let q = cellCentre(t.col, t.row, kk[0] & 255, kk[0] >> 8);
	let qz = t.z[entry[0]];
	for (let x = 1; x < n; x++) {
		t = space.tiles[slotOf[x]];
		const r = cellCentre(t.col, t.row, kk[x] & 255, kk[x] >> 8);
		const rz = t.z[entry[x]];
		const d = Math.hypot(r.wx - q.wx, r.wy - q.wy, rz - qz);
		yards += d;
		if (acc) {
			const key = cellOf(r.wx, r.wy);
			acc.set(key, (acc.get(key) || 0) + d);
		}
		q = r;
		qz = rz;
	}
	return yards;
}

// A Map key -> yards as a flat [key, yards, ...] (Float64Array).
function flatCells(acc) {
	const out = new Float64Array(acc.size * 2);
	let i = 0;
	for (const [k, y] of acc) {
		out[i++] = k;
		out[i++] = y;
	}
	return out;
}

// Adds a flat [key, yards, ...] into acc (Map key -> yards).
function addCells(acc, flat) {
	for (let i = 0; i < flat.length; i += 2) acc.set(flat[i], (acc.get(flat[i]) || 0) + flat[i + 1]);
	return acc;
}

// A copy of o whose typed arrays live in one SharedArrayBuffer (plain nested objects too,
// each its own); numbers and strings kept, anything else dropped.
function shareObject(o) {
	let size = 0;
	const views = [];
	const out = {};
	for (const [k, v] of Object.entries(o)) {
		if (ArrayBuffer.isView(v)) {
			size = Math.ceil(size / 8) * 8;
			views.push([k, v, size]);
			size += v.byteLength;
		} else if (typeof v === 'number' || typeof v === 'string') out[k] = v;
		else if (v && typeof v === 'object' && Object.getPrototypeOf(v) === Object.prototype) out[k] = shareObject(v);
	}
	const sab = new SharedArrayBuffer(Math.max(8, size));
	for (const [k, v, at] of views) {
		const a = new v.constructor(sab, at, v.length);
		a.set(v);
		out[k] = a;
	}
	return out;
}

// tiles: false shares the graphs only (store.continents then lists none: tiles come from files).
function shareNav(dir, continents, { tiles = true } = {}) {
	const index = JSON.parse(fs.readFileSync(path.join(dir, 'index.json'), 'utf8'));
	const store = { dir, continents: [], tiles: {}, graphs: {} };
	const foot = profileFor({});
	for (const c of continents) {
		const cont = index.continents[c];
		if (!cont) continue;
		if (tiles) store.continents.push(Number(c));
		for (const key of tiles ? cont.tiles : []) {
			let t = null;
			try {
				t = decodeTile(fs.readFileSync(path.join(dir, 'tiles', String(c), `${key}.nav.gz`)));
			} catch {
				t = null;
			}
			if (!t || !t.links) continue;
			fallIndex(t);
			fallsInto(t);
			store.tiles[`${c}:${key}`] = shareObject(t);
		}
		let raw = null;
		try {
			raw = gunzip(fs.readFileSync(path.join(dir, 'graph', `${c}.bin.gz`)));
		} catch {
			raw = null;
		}
		if (!raw) continue;
		const sraw = new Uint8Array(new SharedArrayBuffer(raw.byteLength));
		sraw.set(raw);
		const g = decodeGraphRaw(sraw);
		const gi = Math.max(0, REF_PROFILES.indexOf(foot.ref));
		const s = edgeSeconds(g, gi, foot);
		const ss = new Float32Array(new SharedArrayBuffer(s.byteLength));
		ss.set(s);
		store.graphs[c] = { raw: sraw, secs: { [edgeKey(gi, foot)]: ss } };
	}
	return store;
}

function openNav(opts = {}) {
	return new Nav(opts);
}

module.exports = { openNav, shareNav, edgeKey, encodeMix, decodeMix, Nav, SIMPLIFY, SNAP_REGION };
