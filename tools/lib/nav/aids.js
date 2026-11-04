'use strict';
// The arrow's aids from the navigation grid
// (docs/ARCHITECTURE.md, "Navigation grid"):
// zone crossings, open borders and approach chains in the crossings schema
// (tools/lib/travel/crossings.js), generated from the grid's walkable
// surfaces, links and chunk area ids. No place is known by name: every
// entry comes from the rules below, the same for every border and target.
//
//   const { generateAids, loadZoneResolver, collectTargets } = require('tools/lib/nav/aids');
//   const zoneOfArea = loadZoneResolver({ dataDir, sourcesDir, build, frames });   // (c, areaId) -> uiMap | null
//   const targets = collectTargets({ guides, data, geo, travel, entrances, continents });
//   const { doc, stats } = generateAids({ nav, frames, zoneOfArea, targets, continents, log });
//   // doc: { schema: 1, frame: 'e', source, build, crossings, open, chains } (validateCrossings: no errors)
//
// Zones. A surface's zone is its chunk's area id walked up ParentAreaID
// (Forever's AreaTable) to the first area a zone map of zones.json names
// (type 3; the capitals are zones of their own), kept when that map has an
// Era frame on the continent (the schema's frame).
//
// Borders (decided here). For each pair of zones that touch on a continent,
// the border is the column edges between their chunks. An edge is land when
// both columns hold a dry top (no liquid surface above every floor) and
// walkable when a walk, slope, steep or jump link crosses it between the
// two zones' open ground (FootRegions below). A pair is open when its land
// border is at least OPEN_MIN yd, at least OPEN_SHARE of it is walkable, no
// blocked stretch is longer than OPEN_GAP yd, and at least OPEN_SHARE of
// the probes along it (one per OPEN_PROBE yd of walkable border, at most
// OPEN_PROBES, PROBE_DEPTH yd either side) route across easily (`easy`: no
// steep ground or climbs, at most PROBE_SLACK of the straight line's running
// time; slopes over 35° cost double, move.js). Every other pair gets one
// crossing per passage: walkable edges and falls between the open grounds
// clustered within PASSAGE_JOIN yd, cut into pieces of at most PASSAGE_MAX
// yd. A piece is a crossing when an easy route (PASSAGE_SLACK) between
// points of the zones' open ground PROBE_DEPTHS yd from it (walked in from
// the passage; straight out for falls) goes through it; its ends lie END_AT
// yd (END_MIN-END_MAX) inside each zone along that route, on open ground,
// its radius is half the piece's width (RADIUS_MIN-RADIUS_MAX), and it is
// one way when only falls cross it (or the way back is not easy). Kinds by
// the route through it: a lift ride (lift), mostly indoor surfaces
// (tunnel), a model surface (WMO or M2) with liquid or BRIDGE_DROP yd of air
// under it at the crossing point (bridge); captions 'Take the lift to
// <Zone>', 'Walk through the tunnel to <Zone>', 'Cross the bridge to
// <Zone>', none otherwise (the addon says "Go to <Zone>").
//
// Pockets (decided here). For each target (collectTargets: guide goals and
// spawn spots, quest givers and enders, flight masters, inns, trainers,
// dungeon entrances; one per TARGET_GRID yd, spawn spots one per SPOT_GRID
// yd), up to SAMPLES points of its zone's open ground (dry), one
// per bearing at the first of SAMPLE_RADII that has one, are routed to it on
// foot when most of their straight lines are not walkable (nav.los); first
// FIRST_ROUTES of them, the rest only when those already share a stretch.
// Where at least SHARE_QUORUM of the routes coincide (within SHARE_TOL yd)
// over their last stretch for at least POCKET_MIN yd, and that stretch is
// indoor (at least INDOOR_SHARE of it: a cave when most of it lies under
// terrain, else a building), a lift, a climb (CLIMB_RISE yd up, or
// CLIMB_YARDS of steep or climb links) or narrow (median corridor width at
// most NARROW yd), the stretch becomes an approach chain from its mouth
// (where the routes meet) to the target: nodes by Douglas-Peucker (NODE_TOL
// yd; hops at most LIMITS.hopYards, at least NODE_MIN), radius half the
// corridor width (NODE_RADIUS), the first node's caption by kind ('Take the
// lift', 'Enter the cave', 'Go inside', 'Follow the path up', 'Follow the
// path'), 'Follow the path' further in, and `back` at the mouth ('Leave the
// cave', 'Go outside', 'Follow the path down'). A target within MERGE_REACH
// yd of a deeper chain's way, most of whose stretch runs along it, joins
// that chain (one chain per cave, a node kept at each target). Ids: zone
// and place names, lower-case, unique.

const fs = require('node:fs');
const path = require('node:path');
const { CELL, TILE_CELLS, NO_LINK, FLAG, CLS, DIRS, LINK_SLOPE, cellOf, cellCentre } = require('./grid/format');
const { fallTarget } = require('./grid/links');
const { Space, MinHeap } = require('./grid/search');
const { profileFor } = require('./move');
const { parseCsv } = require('../data/csv');
const { round, Frames } = require('../travel/geo');
const { LIMITS, validateCrossings } = require('../travel/crossings');

const OPEN_MIN = 100; // yd of land border
const OPEN_REGION_MIN = 20000; // surfaces (about 87,000 yd²) a foot region needs to be open ground
const OPEN_REGION_SHARE = 0.05; // ... and this share of the zone's largest
const OPEN_SHARE = 0.6;
const OPEN_GAP = 400; // yd
const OPEN_PROBE = 200; // yd
const OPEN_PROBES = 12;
const PROBE_DEPTH = 60; // yd either side of the border
// A probe route is easy: no steep ground or climbs, and its seconds (falls
// and lifts left out) at most x1.6 + 5 s running the straight line.
const PROBE_SLACK = [1.6, 5];
const PASSAGE_JOIN = 40; // yd
const PASSAGE_MAX = 200; // yd
const PROBE_DEPTHS = [60, 90, 120]; // yd either side of a passage
const PASSAGE_SLACK = [1.6, 8]; // a crossing's route: no steep ground or climbs, seconds at most x1.6 + 8 s running its probe distance
const END_AT = 40;
const END_MIN = 25;
const END_MAX = 60;
const END_TRY = [END_AT, 30, 50, END_MIN, END_MAX];
const RADIUS_MIN = LIMITS.radiusMin;
const RADIUS_MAX = LIMITS.radiusMax;
const DEDUPE = 60; // yd: crossings of one pair whose ends are this close are one
const BRIDGE_DROP = 4; // yd of air under a bridge's walk
const POCKET_BLOCK = 40; // targets per message to a worker thread

const TARGET_GRID = 8; // yd
const SPOT_GRID = 20; // yd: spawn spots (clusters already) are tested this sparsely
const FIRST_ROUTES = 4; // routes tried before the rest (the rest only when these share a stretch)
const MERGE_REACH = 20; // yd: a target this close to a deeper chain's way joins that chain
const SAMPLES = 12;
const SAMPLE_RADII = [120, 200, 350, 600, 1000, 1500];
const SHARE_TOL = 15;
const SHARE_STEP = 3;
const SHARE_QUORUM = 0.75;
const POCKET_MIN = 40;
const INDOOR_SHARE = 0.3;
const CLIMB_RISE = 12;
const CLIMB_YARDS = 10;
const NARROW = 30;
const CORRIDOR_MAX = 50; // yd each side measured
const NODE_TOL = 8;
const NODE_MIN = 10;
const NODE_RADIUS = [5, 15];
const NAME_MAX = 60;

// Stored link codes (format.js) walkable on foot: walk, steep, jump, slope.
const FOOT = [true, true, false, true, false, false, false, true];
// ... and those an easy walk takes (no steep ground): walk, jump, slope.
const EASY_CODE = [true, false, false, true, false, false, false, true];
const INWARD_POPS = 40000;
const foot = profileFor({});

// A route that is ok, crosses no steep ground or climbs and runs (falls and
// lifts left out) at most slack[0] x the running time of `yards` + slack[1]
// seconds.
function easy(r, yards, slack) {
	if (!r.ok || r.byClass.climb > 0 || r.byClass.steep > 0) return false;
	const s = r.seconds - (r.byClass.fall || 0) - (r.byClass.lift || 0);
	return s <= (yards / foot.run) * slack[0] + slack[1];
}

const clamp = (v, lo, hi) => Math.max(lo, Math.min(hi, v));
const slug = (s) => String(s).toLowerCase().normalize('NFKD').replace(/[\u0300-\u036f]/g, '').replace(/'/g, '').replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'x';

// --- zones ----------------------------------------------------------------------

// zones: zones.json; areaRows: AreaTable rows (ID, ParentAreaID); frames: Era
// Frames -> (c, areaId) -> uiMap | null; `.spec` keeps the inputs (worker threads rebuild it).
function zoneResolver({ zones, areaRows, frames }) {
	const byArea = new Map();
	for (const z of Object.values(zones)) if (z.type === 3 && z.areaId) byArea.set(Number(z.areaId), Number(z.id));
	const parent = new Map();
	for (const r of areaRows) parent.set(Number(r.ID), Number(r.ParentAreaID) || 0);
	const memo = new Map();
	const spec = { zones, areaRows: [...parent].map(([ID, ParentAreaID]) => ({ ID, ParentAreaID })) };
	return Object.assign((c, areaId) => {
		const key = `${c}:${areaId}`;
		if (memo.has(key)) return memo.get(key);
		let cur = Number(areaId);
		let map = null;
		const seen = new Set();
		while (cur > 0 && !seen.has(cur)) {
			seen.add(cur);
			if (byArea.has(cur)) {
				map = byArea.get(cur);
				break;
			}
			cur = parent.get(cur) || 0;
		}
		const f = map && frames.frame(map);
		const out = f && f.c === c ? map : null;
		memo.set(key, out);
		return out;
	}, { spec });
}

// The resolver over data/forever/zones.json and the AreaTable of the nav
// build (data/sources/wago/<build>/AreaTable.csv; the newest cached build
// when that one is missing).
function loadZoneResolver({ dataDir, sourcesDir, build, frames }) {
	const zones = JSON.parse(fs.readFileSync(path.join(dataDir, 'zones.json'), 'utf8'));
	const wago = path.join(sourcesDir, 'wago');
	let dir = build && fs.existsSync(path.join(wago, build, 'AreaTable.csv')) ? path.join(wago, build) : null;
	if (!dir) {
		const builds = fs.existsSync(wago) ? fs.readdirSync(wago).filter((b) => fs.existsSync(path.join(wago, b, 'AreaTable.csv'))) : [];
		builds.sort((a, b) => a.localeCompare(b, 'en', { numeric: true }));
		if (!builds.length) throw new Error(`no AreaTable.csv under ${wago} (forge data build)`);
		dir = path.join(wago, builds[builds.length - 1]);
	}
	const areaRows = parseCsv(fs.readFileSync(path.join(dir, 'AreaTable.csv'), 'utf8'));
	return Object.assign(zoneResolver({ zones, areaRows, frames }), { areaTable: path.relative(sourcesDir, dir) });
}

// Zones on one continent's grid: zone per chunk, cached on the tile.
class Zones {
	constructor(nav, c, zoneOfArea) {
		this.nav = nav;
		this.c = c;
		this.zoneOfArea = zoneOfArea;
	}

	of(t) {
		if (!t.zones) {
			t.zones = new Int32Array(256);
			for (let x = 0; x < 256; x++) t.zones[x] = this.zoneOfArea(this.c, t.areas[x]) || 0;
		}
		return t.zones;
	}

	at(wx, wy) {
		const p = cellOf(wx, wy);
		const t = this.nav.tile(this.c, p.col, p.row);
		if (!t) return null;
		return this.of(t)[(p.j >> 4) * 16 + (p.i >> 4)] || null;
	}
}

// --- grid helpers -------------------------------------------------------------------

// A dry top: some floor (blocked or not) at or above every liquid surface.
function isLand(t, k) {
	let swim = -Infinity;
	for (let e = t.first[k]; e < t.first[k + 1]; e++) if (t.flags[e] & FLAG.SWIM && t.z[e] > swim) swim = t.z[e];
	for (let e = t.first[k]; e < t.first[k + 1]; e++) if (!(t.flags[e] & FLAG.SWIM) && t.z[e] >= swim - 0.5) return true;
	return false;
}

// Column entries at a world point: { t, k } or null.
function columnAt(nav, c, wx, wy) {
	const p = cellOf(wx, wy);
	const t = nav.tile(c, p.col, p.row);
	return t ? { t, k: p.j * TILE_CELLS + p.i } : null;
}

// The z of a dry walkable surface within tol of z at a world point, or null.
function surfaceNear(nav, c, wx, wy, z, tol) {
	const at = columnAt(nav, c, wx, wy);
	if (!at) return null;
	const { t, k } = at;
	let best = null;
	let bd = tol;
	for (let e = t.first[k]; e < t.first[k + 1]; e++) {
		if (t.flags[e] & (FLAG.BLOCKED | FLAG.SWIM)) continue;
		const d = Math.abs(t.z[e] - z);
		if (d <= bd) {
			bd = d;
			best = t.z[e];
		}
	}
	return best;
}

// Corridor width (yd) across direction (tx, ty) at p: dry walkable surfaces
// continuing from p's height, at most CORRIDOR_MAX each side.
function corridorWidth(nav, c, p, tx, ty) {
	const px = -ty;
	const py = tx;
	let total = CELL;
	for (const side of [1, -1]) {
		let z = p.z;
		let m = 1;
		for (; m * CELL <= CORRIDOR_MAX; m++) {
			const q = surfaceNear(nav, c, p.wx + px * side * m * CELL, p.wy + py * side * m * CELL, z, 1.5 + CELL);
			if (q === null) break;
			z = q;
		}
		total += (m - 1) * CELL;
	}
	return total;
}

// --- polylines --------------------------------------------------------------------------

// A route's points as a polyline with 2D arc lengths.
function polyOf(r) {
	const n = r.pts.length / 3;
	const P = [];
	const S = new Float64Array(n);
	for (let i = 0; i < n; i++) {
		P.push({ wx: r.pts[i * 3], wy: r.pts[i * 3 + 1], z: r.pts[i * 3 + 2] });
		if (i) S[i] = S[i - 1] + Math.hypot(P[i].wx - P[i - 1].wx, P[i].wy - P[i - 1].wy);
	}
	return { P, S, L: n ? S[n - 1] : 0, cls: r.cls };
}

// The point at arc length s (clamped) -> { wx, wy, z, seg, tx, ty }.
function pointAt(poly, s) {
	const { P, S } = poly;
	if (P.length === 1) return { ...P[0], seg: 0, tx: 1, ty: 0 };
	s = clamp(s, 0, poly.L);
	let lo = 0;
	let hi = P.length - 1;
	while (hi - lo > 1) {
		const mid = (lo + hi) >> 1;
		if (S[mid] <= s) lo = mid;
		else hi = mid;
	}
	const len = S[hi] - S[lo];
	const f = len > 0 ? (s - S[lo]) / len : 0;
	const a = P[lo];
	const b = P[hi];
	const dx = b.wx - a.wx;
	const dy = b.wy - a.wy;
	const d = Math.hypot(dx, dy) || 1;
	return { wx: a.wx + dx * f, wy: a.wy + dy * f, z: a.z + (b.z - a.z) * f, seg: lo, tx: dx / d, ty: dy / d };
}

// Yards of each segment class between arc lengths s0 and s1.
function classYards(poly, s0, s1) {
	const out = new Float64Array(8);
	for (let i = 0; i + 1 < poly.P.length; i++) {
		const a = Math.max(s0, poly.S[i]);
		const b = Math.min(s1, poly.S[i + 1]);
		if (b > a) out[poly.cls[i]] += b - a;
	}
	return out;
}

// Classes present between s0 and s1 (hops included even when they have no length).
function hasClass(poly, s0, s1, cls) {
	for (let i = 0; i + 1 < poly.P.length; i++) {
		if (poly.cls[i] !== cls) continue;
		if (poly.S[i + 1] >= s0 && poly.S[i] <= s1) return true;
	}
	return false;
}

const d3 = (a, b) => Math.hypot(a.wx - b.wx, a.wy - b.wy, (a.z || 0) - (b.z || 0));
const d2 = (a, b) => Math.hypot(a.wx - b.wx, a.wy - b.wy);

// The longest final stretch SHARE_QUORUM of the routes (polylines ending at
// one target) share with one of them (within SHARE_TOL yd): { L, ref }.
function shared(polys) {
	let best = { L: 0, ref: null };
	for (const ref of polys) {
		const agree = polys.map((q) => {
			let good = 0;
			const lim = Math.min(q.L, ref.L);
			for (let s = SHARE_STEP; s <= lim; s += SHARE_STEP) {
				if (d2(pointAt(q, q.L - s), pointAt(ref, ref.L - s)) > SHARE_TOL) break;
				good = s;
			}
			return good;
		});
		agree.sort((x, y) => y - x);
		const L = agree[Math.max(0, Math.ceil(SHARE_QUORUM * polys.length) - 1)];
		if (L > best.L) best = { L, ref };
	}
	return best;
}

// Distance (3D) from p to the polyline P.
function toPolyline(p, P) {
	let best = Infinity;
	for (let i = 0; i + 1 < P.length; i++) {
		const a = P[i];
		const b = P[i + 1];
		const vx = b.wx - a.wx;
		const vy = b.wy - a.wy;
		const vz = b.z - a.z;
		const L2 = vx * vx + vy * vy + vz * vz;
		let f = L2 > 0 ? ((p.wx - a.wx) * vx + (p.wy - a.wy) * vy + (p.z - a.z) * vz) / L2 : 0;
		f = clamp(f, 0, 1);
		const d = Math.hypot(a.wx + vx * f - p.wx, a.wy + vy * f - p.wy, a.z + vz * f - p.z);
		if (d < best) best = d;
	}
	if (P.length === 1) best = d3(p, P[0]);
	return best;
}

// Douglas-Peucker (3D) over P keeping `forced` indices -> kept indices.
function simplifyKeep(P, tol, forced) {
	const keep = new Uint8Array(P.length);
	keep[0] = 1;
	keep[P.length - 1] = 1;
	for (const i of forced) keep[i] = 1;
	const stack = [];
	const fixed = [...keep.keys()].filter((i) => keep[i]);
	for (let x = 0; x + 1 < fixed.length; x++) stack.push([fixed[x], fixed[x + 1]]);
	while (stack.length) {
		const [a, b] = stack.pop();
		let worst = -1;
		let wd = tol;
		for (let i = a + 1; i < b; i++) {
			const d = toPolyline(P[i], [P[a], P[b]]);
			if (d > wd) {
				wd = d;
				worst = i;
			}
		}
		if (worst >= 0) {
			keep[worst] = 1;
			stack.push([a, worst], [worst, b]);
		}
	}
	return [...keep.keys()].filter((i) => keep[i]);
}

// --- clustering -------------------------------------------------------------------------

// Single-linkage clusters of points ({ wx, wy }) within `dist` yd.
function cluster(items, dist) {
	const parent = items.map((_, i) => i);
	const find = (i) => {
		while (parent[i] !== i) i = parent[i] = parent[parent[i]];
		return i;
	};
	const grid = new Map();
	const key = (gx, gy) => `${gx},${gy}`;
	items.forEach((p, i) => {
		const gx = Math.floor(p.wx / dist);
		const gy = Math.floor(p.wy / dist);
		for (let dx = -1; dx <= 1; dx++) {
			for (let dy = -1; dy <= 1; dy++) {
				for (const j of grid.get(key(gx + dx, gy + dy)) || []) {
					if (d2(p, items[j]) <= dist) parent[find(i)] = find(j);
				}
			}
		}
		const k = key(gx, gy);
		if (!grid.has(k)) grid.set(k, []);
		grid.get(k).push(i);
	});
	const groups = new Map();
	items.forEach((p, i) => {
		const r = find(i);
		if (!groups.has(r)) groups.set(r, []);
		groups.get(r).push(p);
	});
	return [...groups.values()];
}

function extent(items) {
	let x0 = Infinity;
	let x1 = -Infinity;
	let y0 = Infinity;
	let y1 = -Infinity;
	for (const p of items) {
		x0 = Math.min(x0, p.wx);
		x1 = Math.max(x1, p.wx);
		y0 = Math.min(y0, p.wy);
		y1 = Math.max(y1, p.wy);
	}
	return { x0, x1, y0, y1, len: Math.hypot(x1 - x0, y1 - y0) };
}

// A cluster cut into pieces of at most `max` yd along its longer axis.
function pieces(items, max) {
	const e = extent(items);
	if (e.len <= max) return [items];
	const alongX = e.x1 - e.x0 >= e.y1 - e.y0;
	const v = (p) => (alongX ? p.wx : p.wy);
	const sorted = items.slice().sort((a, b) => v(a) - v(b));
	const span = alongX ? e.x1 - e.x0 : e.y1 - e.y0;
	const n = Math.ceil(span / max);
	const step = span / n;
	const out = Array.from({ length: n }, () => []);
	const lo = v(sorted[0]);
	for (const p of sorted) out[Math.min(n - 1, Math.floor((v(p) - lo) / step))].push(p);
	return out.filter((x) => x.length);
}

// --- borders ----------------------------------------------------------------------------

// Foot regions: connected components of a continent's surfaces over links
// one walks either way on gentle ground (walk links up to GENTLE_MAX, 35°;
// jumps; swims; slopes over 35° between two model surfaces, the ramps and
// stairs of buildings and gates) and lift rides, inside one zone (links between two zones'
// chunks do not join). A zone's open ground is the foot regions its chunks'
// centres stand on (dry; city streets are indoor surfaces in some capitals)
// of at least OPEN_REGION_MIN surfaces and OPEN_REGION_SHARE of the largest.
// Mountain sides (slopes over 35°, steep ground, climbs) and the small tops
// one reaches only over them or only through another zone are not in it
// (decided here: the grid counts terrain walkable up to 80°, far more than
// an arrow should lead over).
const FOOT_REGION = [true, false, true, true, false, false, false, false];
const MODEL = FLAG.WMO | FLAG.M2;

class FootRegions {
	constructor(nav, c, tileKeys) {
		this.base = new Map();
		const order = [];
		let total = 0;
		for (const key of tileKeys) {
			const [col, row] = key.split('_').map(Number);
			const t = nav.tile(c, col, row);
			if (!t) continue;
			this.base.set(col * 65536 + row, total);
			total += t.n;
			order.push([col, row]);
		}
		// Shared, so worker threads read the same regions (generateAids flattens it first).
		const parent = new Int32Array(new SharedArrayBuffer(Math.max(4, total * 4)));
		for (let i = 0; i < total; i++) parent[i] = i;
		this.parent = parent;
		this.order = order;
		this.size = total;
	}

	// Every entry pointing at its root (finds then never write: safe to share).
	flatten() {
		for (let i = 0; i < this.size; i++) this.parent[i] = this.find(i);
	}

	// What a worker thread needs: { parent (shared), base, size }.
	share() {
		return { parent: this.parent, base: [...this.base], size: this.size };
	}

	static from({ parent, base, size }) {
		const f = Object.create(FootRegions.prototype);
		f.parent = parent;
		f.base = new Map(base);
		f.size = size;
		f.order = [];
		return f;
	}

	find(x) {
		const p = this.parent;
		while (p[x] !== x) {
			p[x] = p[p[x]];
			x = p[x];
		}
		return x;
	}

	union(a, b) {
		const ra = this.find(a);
		const rb = this.find(b);
		if (ra !== rb) this.parent[Math.max(ra, rb)] = Math.min(ra, rb);
	}

	// Global index of entry e of tile (col, row), or -1.
	index(col, row, e) {
		const b = this.base.get(col * 65536 + row);
		return b === undefined ? -1 : b + e;
	}

	// The foot region of a snapped point, or -1.
	of(s) {
		if (!s) return -1;
		const g = this.index(s.tile.col, s.tile.row, s.entry);
		return g < 0 ? -1 : this.find(g);
	}
}

// Border edges and falls between zones, the foot regions and each zone's main one.
// -> { pairs: Map 'a-b' -> { a, b, recs }, foot: FootRegions, main: Map zone -> foot region, chunks: Map zone -> count }
// rec: { wx, wy, z, nx, ny (unit, zone a -> b), land, ab, ba (foot links, any ground), walk (a foot link
// between both zones' open ground), fab, fba (falls from one open ground onto the other) }
function scanBorders(nav, c, zones, tileKeys) {
	const pairs = new Map();
	const chunks = new Map();
	const centres = new Map(); // zone -> [global entry]
	const foot = new FootRegions(nav, c, tileKeys);
	const add = (za, zb, rec) => {
		const a = Math.min(za, zb);
		const b = Math.max(za, zb);
		const key = `${a}-${b}`;
		let p = pairs.get(key);
		if (!p) pairs.set(key, (p = { a, b, recs: [] }));
		if (za !== a) {
			rec.nx = -rec.nx;
			rec.ny = -rec.ny;
			[rec.ab, rec.ba] = [rec.ba, rec.ab];
			rec.links = rec.links.map(([u, v]) => [v, u]);
			[rec.fab, rec.fba] = [rec.fba, rec.fab];
		}
		p.recs.push(rec);
	};
	const edge = (tu, ku, tv, kv, d, zu, zv) => {
		let ab = false;
		let ba = false;
		let z = NaN;
		const links = []; // [global entry in zu, global entry in zv]
		let seed = null; // a walkable surface of the edge: [col, row, k, entry]
		const bu = foot.index(tu.col, tu.row, 0);
		const bv = foot.index(tv.col, tv.row, 0);
		for (let e = tu.first[ku]; e < tu.first[ku + 1]; e++) {
			if (tu.flags[e] & FLAG.BLOCKED) continue;
			const b = tu.links[e * 8 + d];
			if (b !== NO_LINK && FOOT[b >> 5]) {
				ab = true;
				z = tu.z[e];
				seed = [tu.col, tu.row, ku, e];
				links.push([bu + e, bv + tv.first[kv] + (b & 31)]);
			}
		}
		const r = (d + 4) & 7;
		for (let e = tv.first[kv]; e < tv.first[kv + 1]; e++) {
			if (tv.flags[e] & FLAG.BLOCKED) continue;
			const b = tv.links[e * 8 + r];
			if (b !== NO_LINK && FOOT[b >> 5]) {
				ba = true;
				if (Number.isNaN(z)) {
					z = tv.z[e];
					seed = [tv.col, tv.row, kv, e];
				}
				links.push([bu + tu.first[ku] + (b & 31), bv + e]);
			}
		}
		const land = isLand(tu, ku) && isLand(tv, kv);
		if (!land && !ab && !ba) return;
		const cu = cellCentre(tu.col, tu.row, ku & 255, ku >> 8);
		const cv = cellCentre(tv.col, tv.row, kv & 255, kv >> 8);
		const dx = cv.wx - cu.wx;
		const dy = cv.wy - cu.wy;
		const dl = Math.hypot(dx, dy) || 1;
		add(zu, zv, { wx: (cu.wx + cv.wx) / 2, wy: (cu.wy + cv.wy) / 2, z, seed, nx: dx / dl, ny: dy / dl, land, ab, ba, links, walk: false, fab: false, fba: false });
	};
	for (const [col, row] of foot.order) {
		const t = nav.tile(c, col, row);
		const zt = zones.of(t);
		// The 3 x 3 neighbourhood: tiles and their global bases.
		const nt = [];
		const nb = [];
		for (let dr = -1; dr <= 1; dr++) {
			for (let dc = -1; dc <= 1; dc++) {
				const tt = dc || dr ? nav.tile(c, col + dc, row + dr) : t;
				nt.push(tt);
				nb.push(tt ? foot.index(col + dc, row + dr, 0) : -1);
			}
		}
		const base = nb[4];
		// Foot links and lift rides into the union-find.
		for (let k = 0; k < 65536; k++) {
			const i = k & 255;
			const j = k >> 8;
			for (let e = t.first[k]; e < t.first[k + 1]; e++) {
				if (t.flags[e] & FLAG.BLOCKED) continue;
				for (let d = 0; d < 8; d++) {
					const b = t.links[e * 8 + d];
					if (b === NO_LINK) continue;
					const code = b >> 5;
					if (!FOOT_REGION[code] && code !== LINK_SLOPE) continue;
					let i2 = i + DIRS[d][0];
					let j2 = j + DIRS[d][1];
					const dc = i2 < 0 ? -1 : i2 >= TILE_CELLS ? 1 : 0;
					const dr = j2 < 0 ? -1 : j2 >= TILE_CELLS ? 1 : 0;
					const x = (dr + 1) * 3 + (dc + 1);
					const t2 = nt[x];
					if (!t2 || nb[x] < 0) continue;
					i2 -= dc * TILE_CELLS;
					j2 -= dr * TILE_CELLS;
					const v = t2.first[j2 * TILE_CELLS + i2] + (b & 31);
					// Slopes over 35° join only between model surfaces (ramps, stairs), never on terrain.
					if (code === LINK_SLOPE && ((t.flags[e] | t2.flags[v]) & FLAG.TERRAIN || !(t.flags[e] & MODEL) || !(t2.flags[v] & MODEL))) continue;
					if (x !== 4 || i2 >> 4 !== i >> 4 || j2 >> 4 !== j >> 4) {
						const za = zt[(j >> 4) * 16 + (i >> 4)];
						if (!za || zones.of(t2)[(j2 >> 4) * 16 + (i2 >> 4)] !== za) continue;
					}
					foot.union(base + e, nb[x] + v);
				}
			}
		}
		if (t.lifts) {
			for (const [e, rides] of t.lifts) {
				for (const L of rides) {
					const g = foot.index(L.col, L.row, L.entry);
					if (g >= 0) foot.union(base + e, g);
				}
			}
		}
		const tE = nt[5];
		const tS = nt[7];
		const zE = tE && zones.of(tE);
		const zS = tS && zones.of(tS);
		for (let cy = 0; cy < 16; cy++) {
			for (let cx = 0; cx < 16; cx++) {
				const za = zt[cy * 16 + cx];
				if (!za) continue;
				chunks.set(za, (chunks.get(za) || 0) + 1);
				// Candidates for the zone's open ground: every dry walkable surface at its centre.
				const kc = (cy * 16 + 8) * TILE_CELLS + cx * 16 + 8;
				for (let e = t.first[kc]; e < t.first[kc + 1]; e++) {
					if (t.flags[e] & (FLAG.BLOCKED | FLAG.SWIM)) continue;
					if (!centres.has(za)) centres.set(za, []);
					centres.get(za).push(base + e);
				}
				const east = cx < 15 ? { t, zb: zt[cy * 16 + cx + 1], i2: cx * 16 + 16 } : tE ? { t: tE, zb: zE[cy * 16], i2: 0 } : null;
				if (east && east.zb && east.zb !== za) {
					for (let j = cy * 16; j < cy * 16 + 16; j++) edge(t, j * TILE_CELLS + cx * 16 + 15, east.t, j * TILE_CELLS + east.i2, 0, za, east.zb);
				}
				const south = cy < 15 ? { t, zb: zt[(cy + 1) * 16 + cx], j2: cy * 16 + 16 } : tS ? { t: tS, zb: zS[cx], j2: 0 } : null;
				if (south && south.zb && south.zb !== za) {
					for (let i = cx * 16; i < cx * 16 + 16; i++) edge(t, (cy * 16 + 15) * TILE_CELLS + i, south.t, south.j2 * TILE_CELLS + i, 2, za, south.zb);
				}
			}
		}
		// Falls whose landing is in another zone.
		const ff = t.fallFrom;
		let k = 0;
		for (let f = 0; f < ff.length; f++) {
			const e = ff[f];
			while (t.first[k + 1] <= e) k++;
			const i = k & 255;
			const j = k >> 8;
			const za = zt[(j >> 4) * 16 + (i >> 4)];
			if (!za) continue;
			const { di, dj, layer } = fallTarget(t.fallTo[f]);
			const gi = i + di;
			const gj = j + dj;
			const dc = Math.floor(gi / TILE_CELLS);
			const dr = Math.floor(gj / TILE_CELLS);
			const t2 = dc || dr ? nav.tile(c, col + dc, row + dr) : t;
			if (!t2) continue;
			const i2 = gi - dc * TILE_CELLS;
			const j2 = gj - dr * TILE_CELLS;
			const zb = zones.of(t2)[(j2 >> 4) * 16 + (i2 >> 4)];
			if (!zb || zb === za) continue;
			const g2 = foot.index(t2.col, t2.row, t2.first[j2 * TILE_CELLS + i2] + layer);
			if (g2 < 0) continue;
			const cu = cellCentre(col, row, i, j);
			const cv = cellCentre(t2.col, t2.row, i2, j2);
			const dx = cv.wx - cu.wx;
			const dy = cv.wy - cu.wy;
			const dl = Math.hypot(dx, dy) || 1;
			add(za, zb, { wx: (cu.wx + cv.wx) / 2, wy: (cu.wy + cv.wy) / 2, z: t.z[e], nx: dx / dl, ny: dy / dl, land: false, ab: false, ba: false, links: [[base + e, g2]], walk: false, fab: true, fba: false });
		}
	}
	// Each zone's open ground: the foot regions its chunk centres stand on of
	// at least OPEN_REGION_MIN surfaces and OPEN_REGION_SHARE of the largest;
	// then which border links join two open grounds.
	const size = new Map(); // root -> surfaces
	for (const list of centres.values()) for (const g of list) size.set(foot.find(g), 0);
	for (let g = 0; g < foot.size; g++) {
		const r = foot.find(g);
		const n = size.get(r);
		if (n !== undefined) size.set(r, n + 1);
	}
	const open = new Map();
	for (const [z, list] of centres) {
		const roots = [...new Set(list.map((g) => foot.find(g)))];
		const largest = Math.max(...roots.map((r) => size.get(r)));
		const floor = Math.min(largest, Math.max(OPEN_REGION_MIN, OPEN_REGION_SHARE * largest));
		open.set(z, new Set(roots.filter((r) => size.get(r) >= floor)));
	}
	const none = new Set();
	for (const p of pairs.values()) {
		const oa = open.get(p.a) || none;
		const ob = open.get(p.b) || none;
		for (const r of p.recs) {
			// links: [entry in a, entry in b]; a fall or foot link joins the two open grounds.
			const joins = r.links.some(([u, v]) => oa.has(foot.find(u)) && ob.has(foot.find(v)));
			if (r.fab || r.fba) {
				if (!joins) r.fab = r.fba = false;
			} else r.walk = joins;
			delete r.links;
		}
	}
	return { pairs, foot, open, size, chunks };
}

// --- generation ---------------------------------------------------------------------------

class Generator {
	// open: Map zone -> Set of foot regions (scanBorders); foot: FootRegions.
	constructor({ nav, c, frames, zones, open, foot, log }) {
		this.nav = nav;
		this.c = c;
		this.frames = frames;
		this.zones = zones;
		this.open = open;
		this.foot = foot;
		this.log = log || (() => {});
	}

	name(map) {
		return this.frames.name(map) || String(map);
	}

	// A snapped point on `zone`'s open ground, or null.
	snapIn(p, zone, z, radius = 20) {
		const s = this.nav.snap({ c: this.c, wx: p.wx, wy: p.wy, ...(Number.isFinite(z) ? { z } : {}), radius });
		if (!s || this.zones.at(s.wx, s.wy) !== zone) return null;
		return this.onOpen(s, zone) ? s : null;
	}

	// Whether snapped point s stands on `zone`'s open ground.
	onOpen(s, zone) {
		const set = this.open.get(zone);
		return set !== undefined && set.has(this.foot.of(s));
	}

	// The open ground of `zone` at a route point (within 4 yd), or null.
	openAt(p, zone) {
		const s = this.nav.snap({ c: this.c, wx: p.wx, wy: p.wy, z: p.z, radius: 4 });
		return s && this.zones.at(s.wx, s.wy) === zone && this.onOpen(s, zone) ? s : null;
	}

	// An open pair: the land border's walkable share, its longest blocked stretch, probes across.
	openPair(pair) {
		const land = pair.recs.filter((r) => r.land);
		const walk = land.filter((r) => r.walk);
		const out = { landYards: Math.round(land.length * CELL), share: land.length ? walk.length / land.length : 0, gap: 0, probes: 0, probesOk: 0, open: false };
		const blocked = land.filter((r) => !r.walk);
		for (const g of cluster(blocked, 3 * CELL)) out.gap = Math.max(out.gap, extent(g).len + CELL);
		out.gap = Math.round(out.gap);
		if (out.landYards < OPEN_MIN || out.share < OPEN_SHARE || out.gap > OPEN_GAP) return out;
		// Probes: walkable edges at least OPEN_PROBE yd apart.
		const picks = [];
		for (const r of walk) {
			if (picks.length >= OPEN_PROBES * 4) break;
			if (picks.every((q) => d2(q, r) >= OPEN_PROBE)) picks.push(r);
		}
		const step = Math.max(1, Math.ceil(picks.length / OPEN_PROBES));
		for (let x = 0; x < picks.length; x += step) {
			const r = picks[x];
			const A = this.snapIn({ wx: r.wx - r.nx * PROBE_DEPTH, wy: r.wy - r.ny * PROBE_DEPTH }, pair.a, r.z);
			const B = this.snapIn({ wx: r.wx + r.nx * PROBE_DEPTH, wy: r.wy + r.ny * PROBE_DEPTH }, pair.b, r.z);
			if (!A || !B) continue;
			out.probes++;
			if (easy(this.nav.route(A, B, foot), d2(A, B), PROBE_SLACK)) out.probesOk++;
		}
		out.open = out.probes > 0 && out.probesOk / out.probes >= OPEN_SHARE;
		return out;
	}

	// The zone change along a route from zone `from` into `to`: arc length of the first point in `to`, or null.
	crossingAt(poly, from, to) {
		let seenFrom = false;
		for (let i = 0; i < poly.P.length; i++) {
			const z = this.zones.at(poly.P[i].wx, poly.P[i].wy);
			if (z === from) seenFrom = true;
			else if (z === to && seenFrom) {
				if (i === 0) return 0;
				for (let s = poly.S[i - 1]; s < poly.S[i]; s += 1) {
					const q = pointAt(poly, s);
					if (this.zones.at(q.wx, q.wy) === to) return s;
				}
				return poly.S[i];
			}
		}
		return null;
	}

	// A crossing over one passage piece, or null.
	crossing(pair, piece) {
		const anyFoot = piece.some((r) => r.walk);
		const fallAB = piece.some((r) => r.fab);
		const fallBA = piece.some((r) => r.fba);
		// Walking direction to try first: a -> b unless only falls b -> a cross here.
		let from = pair.a;
		let to = pair.b;
		if (!anyFoot && !fallAB && fallBA) [from, to] = [to, from];
		let mx = 0;
		let my = 0;
		let nx = 0;
		let ny = 0;
		for (const r of piece) {
			mx += r.wx;
			my += r.wy;
			nx += r.nx;
			ny += r.ny;
		}
		mx /= piece.length;
		my /= piece.length;
		let centre = piece[0];
		for (const r of piece) if (Math.hypot(r.wx - mx, r.wy - my) < Math.hypot(centre.wx - mx, centre.wy - my)) centre = r;
		let nl = Math.hypot(nx, ny);
		if (nl < 0.2) {
			nx = centre.nx;
			ny = centre.ny;
			nl = 1;
		}
		nx /= nl;
		ny /= nl;
		if (from !== pair.a) {
			nx = -nx;
			ny = -ny;
		}
		const width = extent(piece).len + CELL;
		const S0 = this.seedPoint(centre.seed || (piece.find((r) => r.seed) || {}).seed);
		for (const D of PROBE_DEPTHS) {
			// Probe ends: D yd into each zone along its open ground from the
			// passage (falls only: straight out along the border's normal).
			let A = null;
			let B = null;
			let ref = 0;
			if (anyFoot && S0) {
				const ia = this.inward(S0, from, D);
				const ib = this.inward(S0, to, D);
				if (ia && ib) {
					A = ia.s;
					B = ib.s;
					ref = ia.d + ib.d;
				}
			}
			if (!A || !B) {
				A = this.snapIn({ wx: centre.wx - nx * D, wy: centre.wy - ny * D }, from, centre.z);
				B = this.snapIn({ wx: centre.wx + nx * D, wy: centre.wy + ny * D }, to, centre.z);
			}
			if (!A || !B) continue;
			ref = Math.max(ref, d2(A, B));
			const r = this.nav.route(A, B, foot);
			if (!easy(r, ref, PASSAGE_SLACK)) continue;
			const poly = polyOf(r);
			const sx = this.crossingAt(poly, from, to);
			if (sx === null) continue;
			const X = pointAt(poly, sx);
			if (d2(X, centre) > width / 2 + PASSAGE_JOIN) continue; // went through another passage
			const end = (sign, zone) => {
				for (const dd of END_TRY) {
					const q = pointAt(poly, sx + sign * dd);
					if (Math.abs(sx + sign * dd - clamp(sx + sign * dd, 0, poly.L)) > 0.5) continue;
					if (this.zones.at(q.wx, q.wy) === zone && this.openAt(q, zone)) return { ...q, at: sx + sign * dd };
				}
				return null;
			};
			const ea = end(-1, from);
			const eb = end(1, to);
			if (!ea || !eb) continue;
			// One way when only falls cross, or the way back does not route here.
			let oneWay = !anyFoot;
			if (!oneWay) {
				const back = this.nav.route(B, A, foot);
				oneWay = !easy(back, ref, PASSAGE_SLACK);
			}
			const kind = this.kind(poly, ea.at, eb.at, sx);
			return { from, to, ea, eb, oneWay, kind, width: Math.round(width), probe: D };
		}
		return null;
	}

	// A border record's seed ([col, row, k, entry]) as a snapped point, or null.
	seedPoint(seed) {
		if (!seed) return null;
		const [col, row, k, e] = seed;
		const t = this.nav.tile(this.c, col, row);
		if (!t) return null;
		const i = k & 255;
		const j = k >> 8;
		const ctr = cellCentre(col, row, i, j);
		return { c: this.c, wx: ctr.wx, wy: ctr.wy, z: t.z[e], tile: { col, row }, cell: { i, j }, layer: e - t.first[k], entry: e, region: this.nav.region(this.c, col, row, e), flags: t.flags[e] };
	}

	// The first point of `zone`'s open ground `depth` yd (walked on foot
	// links, no steep ground or climbs) from snapped point s into the zone:
	// { s (snapped), d (yd walked) } or null.
	inward(s, zone, depth) {
		const space = new Space([], (col, row) => this.nav.tile(this.c, col, row));
		const s0 = space.slot(s.tile.col, s.tile.row);
		if (s0 < 0) return null;
		const start = space.base[s0] + s.entry;
		const dist = new Map([[start, 0]]);
		const where = new Map([[start, [s0, s.entry, s.cell.j * TILE_CELLS + s.cell.i]]]);
		const heap = new MinHeap();
		heap.push(0, start);
		let pops = 0;
		while (heap.size && pops++ < INWARD_POPS) {
			const u = heap.pop();
			const du = heap.top;
			if (du > dist.get(u)) continue;
			const [slot, e, k] = where.get(u);
			const t = space.tiles[slot];
			const i = k & 255;
			const j = k >> 8;
			const zu = this.zones.of(t)[(j >> 4) * 16 + (i >> 4)];
			if (du > 6 && zu !== zone) continue; // left the zone past the border's first steps
			if (du >= depth && zu === zone && !(t.flags[e] & FLAG.SWIM)) {
				const ctr = cellCentre(t.col, t.row, i, j);
				const p = {
					c: this.c, wx: ctr.wx, wy: ctr.wy, z: t.z[e], tile: { col: t.col, row: t.row }, cell: { i, j }, layer: e - t.first[k], entry: e,
					region: this.nav.region(this.c, t.col, t.row, e), flags: t.flags[e],
				};
				if (this.onOpen(p, zone)) return { s: p, d: du };
			}
			const n = space.expand(slot, e, k, foot);
			for (let x = 0; x < n; x++) {
				const code = space.outCode[x];
				const cls = space.outCls[x];
				if (cls === CLS.FALL || cls === CLS.LIFT || !EASY_CODE[code]) continue;
				const v = space.outTo[x];
				const dv = du + space.outD[x];
				if (dv < (dist.has(v) ? dist.get(v) : Infinity)) {
					dist.set(v, dv);
					const s2 = space.outSlot[x];
					where.set(v, [s2, v - space.base[s2], space.outK[x]]);
					heap.push(dv, v);
				}
			}
		}
		return null;
	}

	// tunnel | bridge | lift | null for the stretch [s0, s1] of a route crossing at sx.
	kind(poly, s0, s1, sx) {
		if (hasClass(poly, s0, s1, CLS.LIFT)) return 'lift';
		const by = classYards(poly, s0, s1);
		const total = by.reduce((a, b) => a + b, 0) || 1;
		if (by[CLS.INDOOR] / total >= INDOOR_SHARE) return 'tunnel';
		for (const ds of [0, -4, 4]) {
			const p = pointAt(poly, sx + ds);
			if (this.bridgeAt(p)) return 'bridge';
		}
		return null;
	}

	// A bridge at p: the walk there is a model surface (WMO or M2, not
	// terrain) with liquid or at least BRIDGE_DROP yd of air under it.
	bridgeAt(p) {
		const at = columnAt(this.nav, this.c, p.wx, p.wy);
		if (!at) return false;
		const { t, k } = at;
		let walk = -1;
		for (let e = t.first[k]; e < t.first[k + 1]; e++) {
			if (t.flags[e] & (FLAG.BLOCKED | FLAG.SWIM)) continue;
			if (walk < 0 || Math.abs(t.z[e] - p.z) < Math.abs(t.z[walk] - p.z)) walk = e;
		}
		if (walk < 0 || Math.abs(t.z[walk] - p.z) > 3) return false;
		const f = t.flags[walk];
		if (f & FLAG.TERRAIN || !(f & (FLAG.WMO | FLAG.M2))) return false;
		if (walk === t.first[k]) return true; // nothing under it
		const below = walk - 1; // entries ascend in z
		return (t.flags[below] & FLAG.SWIM) !== 0 || t.z[walk] - t.z[below] >= BRIDGE_DROP;
	}

	caption(kind, zone) {
		const n = this.name(zone);
		if (kind === 'tunnel') return `Walk through the tunnel to ${n}`;
		if (kind === 'bridge') return `Cross the bridge to ${n}`;
		if (kind === 'lift') return `Take the lift to ${n}`;
		return undefined;
	}

	// Map percent of a world point on `map` -> { x, y, offMap? } or null.
	mapPoint(map, wx, wy) {
		const p = this.frames.toMap(map, this.c, wx, wy);
		if (!p) return null;
		const x = round(p.x, 2);
		const y = round(p.y, 2);
		const [lo, hi] = LIMITS.offMap;
		if (x < lo || x > hi || y < lo || y > hi) return null;
		const out = { x, y };
		if (x < 0 || x > 100 || y < 0 || y > 100) out.offMap = true;
		return out;
	}

	// Every border of the continent -> { open: [], crossings: [], pairs: [stats] }.
	borders(pairs) {
		const open = [];
		const crossings = [];
		const stats = [];
		const keys = [...pairs.keys()].sort((x, y) => {
			const [a1, b1] = x.split('-').map(Number);
			const [a2, b2] = y.split('-').map(Number);
			return a1 - a2 || b1 - b2;
		});
		for (const key of keys) {
			const pair = pairs.get(key);
			const o = this.openPair(pair);
			const st = { a: pair.a, b: pair.b, ...o, passages: 0, pieces: 0, crossings: 0 };
			stats.push(st);
			if (o.open) {
				open.push({ a: pair.a, b: pair.b });
				continue;
			}
			const passable = pair.recs.filter((r) => r.walk || r.fab || r.fba);
			const groups = cluster(passable, PASSAGE_JOIN);
			st.passages = groups.length;
			const mine = [];
			for (const g of groups) {
				for (const piece of pieces(g, PASSAGE_MAX)) {
					st.pieces++;
					const x = this.crossing(pair, piece);
					if (!x) continue;
					if (mine.some((m) => (d2(m.ea, x.ea) <= DEDUPE && d2(m.eb, x.eb) <= DEDUPE) || (d2(m.ea, x.eb) <= DEDUPE && d2(m.eb, x.ea) <= DEDUPE))) continue;
					mine.push(x);
				}
			}
			mine.sort((p, q) => p.ea.wx - q.ea.wx || p.ea.wy - q.ea.wy);
			const base = `${slug(this.name(pair.a))}--${slug(this.name(pair.b))}`;
			let n = 0;
			for (const x of mine) {
				const radius = clamp(Math.round(x.width / 2), RADIUS_MIN, RADIUS_MAX);
				const pa = this.mapPoint(x.from, x.ea.wx, x.ea.wy);
				const pb = this.mapPoint(x.to, x.eb.wx, x.eb.wy);
				if (!pa || !pb) continue;
				n++;
				const e = {
					id: mine.length > 1 ? `${base}-${n}` : base,
					a: { map: x.from, ...pa, radius },
					b: { map: x.to, ...pb, radius },
				};
				const ab = this.caption(x.kind, x.to);
				const ba = x.oneWay ? undefined : this.caption(x.kind, x.from);
				if (ab) e.ab = ab;
				if (ba) e.ba = ba;
				if (x.oneWay) e.oneWay = true;
				Object.defineProperty(e, 'meta', { value: { kind: x.kind, width: x.width, wa: x.ea, wb: x.eb }, enumerable: false });
				crossings.push(e);
				st.crossings++;
			}
		}
		return { open, crossings, stats };
	}

	// --- pockets ---

	// The pocket a target sits in -> { target, zone, stretch: [{ wx, wy, z, cls }], L, kind } or null (with why).
	pocket(target, why) {
		const nav = this.nav;
		const T = nav.snap({ c: this.c, wx: target.wx, wy: target.wy, radius: 15 });
		if (!T) return why('no surface'), null;
		const zone = this.zones.at(T.wx, T.wy) || (this.frames.frame(target.map) && this.frames.frame(target.map).c === this.c ? target.map : null);
		if (!zone) return why('no zone'), null;
		if (!this.open.has(zone)) return why('no open ground'), null;
		const mainOk = (s) => this.onOpen(s, zone);
		const samples = [];
		for (let b = 0; b < SAMPLES; b++) {
			const ang = (b * 2 * Math.PI) / SAMPLES;
			for (const R of SAMPLE_RADII) {
				const p = { c: this.c, wx: T.wx + Math.cos(ang) * R, wy: T.wy + Math.sin(ang) * R, radius: 20 };
				const good = (s) => s && !(s.flags & (FLAG.SWIM | FLAG.BLOCKED)) && mainOk(s) && this.zones.at(s.wx, s.wy) === zone;
				let s = nav.snap({ ...p, prefer: 'ground' });
				if (!good(s)) s = nav.snap(p);
				if (good(s)) {
					samples.push(s);
					break;
				}
			}
		}
		if (samples.length < SAMPLES / 2) return why('little open ground'), null;
		const blocked = samples.filter((s) => !nav.los(s, T));
		if (blocked.length * 2 <= samples.length) return why('in the open'), null;
		// Routes from a first spread of samples; the rest only when those share a stretch.
		const polys = [];
		const routeFrom = (s) => {
			const r = nav.route(s, T, foot);
			if (r.ok && r.pts.length >= 6) polys.push(polyOf(r));
		};
		const step = Math.max(1, Math.floor(samples.length / FIRST_ROUTES));
		const first = new Set();
		for (let x = 0; x < samples.length && first.size < FIRST_ROUTES; x += step) first.add(x);
		for (const x of first) routeFrom(samples[x]);
		if (polys.length < 3 || shared(polys).L < POCKET_MIN) return why(polys.length < 3 ? 'few routes' : 'no common mouth'), null;
		samples.forEach((s, x) => first.has(x) || routeFrom(s));
		if (polys.length < 4) return why('few routes'), null;
		const best = shared(polys);
		if (best.L < POCKET_MIN) return why('no common mouth'), null;
		const ref = best.ref;
		const s0 = ref.L - best.L;
		const mouth = pointAt(ref, s0);
		const by = classYards(ref, s0, ref.L);
		const total = by.reduce((a, b) => a + b, 0) || 1;
		const lift = hasClass(ref, s0, ref.L, CLS.LIFT);
		const indoor = by[CLS.INDOOR] / total >= INDOOR_SHARE;
		const end = ref.P[ref.P.length - 1];
		const climb = end.z - mouth.z >= CLIMB_RISE || by[CLS.STEEP] + by[CLS.CLIMB] >= CLIMB_YARDS;
		const widths = [];
		let inside = 0;
		let underground = 0;
		for (let s = s0; s <= ref.L - 5; s += 10) {
			const p = pointAt(ref, s);
			widths.push(corridorWidth(nav, this.c, p, p.tx, p.ty));
			const at = columnAt(nav, this.c, p.wx, p.wy);
			if (!at) continue;
			const { t, k } = at;
			let floor = -1;
			for (let e = t.first[k]; e < t.first[k + 1]; e++) if (!(t.flags[e] & FLAG.BLOCKED) && (floor < 0 || Math.abs(t.z[e] - p.z) < Math.abs(t.z[floor] - p.z))) floor = e;
			if (floor < 0 || !(t.flags[floor] & FLAG.INDOOR)) continue;
			inside++;
			for (let e = floor + 1; e < t.first[k + 1]; e++) {
				if (t.flags[e] & FLAG.TERRAIN) {
					underground++;
					break;
				}
			}
		}
		widths.sort((x, y) => x - y);
		const narrow = widths.length > 0 && widths[widths.length >> 1] <= NARROW;
		// Indoors under terrain is a cave; indoors with no ground above, a building.
		const kind = lift ? 'lift' : indoor ? (underground * 2 >= inside ? 'cave' : 'building') : climb ? 'climb' : narrow ? 'narrow' : null;
		if (!kind) return why('open beyond the mouth'), null;
		// The stretch from the mouth to the target as a polyline (cut at the mouth).
		const stretch = [{ wx: mouth.wx, wy: mouth.wy, z: mouth.z }];
		for (let i = mouth.seg + 1; i < ref.P.length; i++) stretch.push(ref.P[i]);
		return { target, zone, T, stretch, L: best.L, kind, samples: samples.length, blocked: blocked.length, routes: polys.length };
	}

	// Pockets -> chains (merged), entries in the schema.
	chains(pockets, taken) {
		const sorted = pockets.slice().sort((a, b) => b.L - a.L || a.T.wx - b.T.wx || a.T.wy - b.T.wy);
		const kept = [];
		for (const p of sorted) {
			// A deeper chain takes this target when the target lies on its way
			// (MERGE_REACH yd) and most of this stretch runs along it.
			const home = kept.find((k) => k.zone === p.zone && toPolyline(p.T, k.stretch) <= MERGE_REACH && p.stretch.filter((q) => toPolyline(q, k.stretch) <= SHARE_TOL).length * 2 >= p.stretch.length);
			if (home) home.members.push(p);
			else kept.push({ ...p, members: [p] });
		}
		const out = [];
		for (const k of kept) {
			const P = k.stretch;
			// A node at each member target's nearest stretch point.
			const forced = new Set();
			for (const m of k.members) {
				let bi = P.length - 1;
				let bd = Infinity;
				P.forEach((q, i) => {
					const d = d3(q, m.T);
					if (d < bd) {
						bd = d;
						bi = i;
					}
				});
				forced.add(bi);
			}
			let idx = simplifyKeep(P, NODE_TOL, forced);
			// Drop nodes closer than NODE_MIN to the one before (never the ends or a member's).
			idx = idx.filter((i, x) => x === 0 || x === idx.length - 1 || forced.has(i) || d2(P[i], P[idx[x - 1]]) >= NODE_MIN);
			const pts = [];
			for (let x = 0; x < idx.length; x++) {
				const q = P[idx[x]];
				if (x) {
					const prev = pts[pts.length - 1];
					const d = d2(prev, q);
					const parts = Math.ceil(d / (LIMITS.hopYards - 10));
					for (let s = 1; s < parts; s++) pts.push({ wx: prev.wx + ((q.wx - prev.wx) * s) / parts, wy: prev.wy + ((q.wy - prev.wy) * s) / parts, z: prev.z + ((q.z - prev.z) * s) / parts });
				}
				pts.push(q);
			}
			if (pts.length < 2) continue;
			const nodes = [];
			let ok = true;
			pts.forEach((q, x) => {
				const nb = pts[x + 1] || pts[x - 1];
				const dir = x + 1 < pts.length ? { tx: nb.wx - q.wx, ty: nb.wy - q.wy } : { tx: q.wx - nb.wx, ty: q.wy - nb.wy };
				const dl = Math.hypot(dir.tx, dir.ty) || 1;
				const w = corridorWidth(this.nav, this.c, q, dir.tx / dl, dir.ty / dl);
				const map = this.zones.at(q.wx, q.wy) || k.zone;
				const mp = this.mapPoint(map, q.wx, q.wy);
				if (!mp) {
					ok = false;
					return;
				}
				const n = { map, ...mp, radius: clamp(Math.round(w / 2), NODE_RADIUS[0], NODE_RADIUS[1]) };
				if (x === 0) {
					n.caption = { lift: 'Take the lift', cave: 'Enter the cave', building: 'Go inside', climb: 'Follow the path up' }[k.kind] || 'Follow the path';
					const back = { cave: 'Leave the cave', building: 'Go outside', climb: 'Follow the path down' }[k.kind];
					if (back) n.back = back;
				} else n.caption = 'Follow the path';
				nodes.push(n);
			});
			if (!ok) continue;
			const name = String(k.target.name || this.name(k.zone)).replace(/\s+/g, ' ').trim().slice(0, NAME_MAX).trim() || this.name(k.zone);
			let id = slug(`${this.name(k.zone)}-${name}`);
			if (taken.has(id)) {
				let n = 2;
				while (taken.has(`${id}-${n}`)) n++;
				id = `${id}-${n}`;
			}
			taken.add(id);
			const ch = { id, name, open: 'mouth', nodes };
			Object.defineProperty(ch, 'meta', {
				value: { kind: k.kind, L: Math.round(k.L), zone: k.zone, mouth: P[0], targets: k.members.map((m) => ({ name: m.target.name, kind: m.target.kind, wx: m.target.wx, wy: m.target.wy })) },
				enumerable: false,
			});
			out.push(ch);
		}
		return out;
	}
}

// Deduplicated targets of continent c (TARGET_GRID yd), in their given order.
function dedupeTargets(targets, c) {
	const seen = new Set();
	const spots = new Set();
	const out = [];
	for (const t of targets) {
		if (t.c !== c) continue;
		const key = `${Math.floor(t.wx / TARGET_GRID)},${Math.floor(t.wy / TARGET_GRID)}`;
		if (seen.has(key)) continue;
		if (t.kind === 'spot') {
			const sk = `${Math.floor(t.wx / SPOT_GRID)},${Math.floor(t.wy / SPOT_GRID)}`;
			if (spots.has(sk)) continue;
			spots.add(sk);
		}
		seen.add(key);
		out.push(t);
	}
	return out;
}

// Pocket tests of a continent's targets, here or in `workers` threads (each
// with its own nav, sharing the flattened foot regions) -> { pockets, why }
// (pockets in target order: the result does not depend on the threads).
async function pocketsOf({ gen, nav, c, frames, zoneOfArea, scan, mine, workers, log, t0 }) {
	const why = new Map();
	const note = (w) => why.set(w, (why.get(w) || 0) + 1);
	const found = new Array(mine.length).fill(null);
	let done = 0;
	const progress = () => {
		if (++done % 500 === 0) log(`continent ${c}: ${done} of ${mine.length} targets, ${found.filter(Boolean).length} in pockets (${((Date.now() - t0) / 1000).toFixed(0)} s)`);
	};
	if (!workers || !zoneOfArea.spec || mine.length < POCKET_BLOCK * 2) {
		mine.forEach((t, i) => {
			found[i] = gen.pocket(t, note);
			progress();
		});
	} else {
		scan.foot.flatten();
		const { Worker } = require('node:worker_threads');
		const data = {
			aidsWorker: true, dir: nav.dir, c, eraFrames: Object.fromEntries(frames.frames), zonesJson: frames.zones, spec: zoneOfArea.spec,
			foot: scan.foot.share(), open: [...scan.open].map(([z, set]) => [z, [...set]]),
		};
		let next = 0;
		await Promise.all(Array.from({ length: Math.min(workers, Math.ceil(mine.length / POCKET_BLOCK)) }, () => new Promise((resolve, reject) => {
			const w = new Worker(__filename, { workerData: data });
			const send = () => {
				if (next >= mine.length) {
					w.postMessage(null);
					return;
				}
				const from = next;
				next = Math.min(mine.length, next + POCKET_BLOCK);
				w.postMessage({ from, items: mine.slice(from, next) });
			};
			w.on('message', ({ from, results }) => {
				results.forEach(([p, reason], k) => {
					found[from + k] = p;
					if (reason) note(reason);
					progress();
				});
				send();
			});
			w.on('error', reject);
			w.on('exit', (code) => (code === 0 ? resolve() : reject(new Error(`aids worker exited with ${code}`))));
			send();
		})));
	}
	return { pockets: found.filter(Boolean), why };
}

// nav: openNav(); frames: Era Frames (travel/geo.js); zoneOfArea: zoneResolver /
// loadZoneResolver; targets: collectTargets; continents: ids (default: every
// continent of the nav index); workers: threads testing pockets (0: here).
// -> Promise<{ doc, stats, set }> (set: validateCrossings of doc)
async function generateAids({ nav, frames, zoneOfArea, targets = [], continents = null, log = () => {}, source = null, workers = 0 }) {
	if (!nav.available) throw new Error('no navigation grid (node tools/polestar.js nav build)');
	const list = (continents || Object.keys(nav.index.continents).map(Number)).filter((c) => nav.index.continents[c]);
	const doc = {
		schema: 1,
		frame: 'e',
		source: source || `nav aids: generated from the navigation grid (data/local/nav, client build ${nav.index.build}, grid built ${nav.index.builtAt}) by tools/lib/nav/aids.js`,
		build: nav.index.build,
		crossings: [],
		open: [],
		chains: [],
	};
	const stats = { continents: {} };
	const taken = new Set();
	for (const c of list) {
		const t0 = Date.now();
		const zones = new Zones(nav, c, zoneOfArea);
		const tileKeys = nav.index.continents[c].tiles;
		const scan = scanBorders(nav, c, zones, tileKeys);
		const t1 = Date.now();
		log(`continent ${c}: ${tileKeys.length} tiles, ${scan.chunks.size} zones, ${scan.pairs.size} zone pairs touching (${((t1 - t0) / 1000).toFixed(1)} s)`);
		const gen = new Generator({ nav, c, frames, zones, open: scan.open, foot: scan.foot, log });
		const b = gen.borders(scan.pairs);
		const t2 = Date.now();
		log(`continent ${c}: ${b.open.length} open pairs, ${b.crossings.length} crossings (${((t2 - t1) / 1000).toFixed(1)} s)`);
		const mine = dedupeTargets(targets, c);
		const { pockets, why } = await pocketsOf({ gen, nav, c, frames, zoneOfArea, scan, mine, workers, log, t0: t2 });
		const chains = gen.chains(pockets, taken);
		for (const e of b.crossings) taken.add(e.id);
		const t3 = Date.now();
		log(`continent ${c}: ${mine.length} targets, ${pockets.length} in pockets, ${chains.length} chains (${((t3 - t2) / 1000).toFixed(1)} s)`);
		doc.crossings.push(...b.crossings);
		doc.open.push(...b.open);
		doc.chains.push(...chains);
		const kinds = (arr, f) => arr.reduce((m, x) => ((m[f(x) || 'plain'] = (m[f(x) || 'plain'] || 0) + 1), m), {});
		stats.continents[c] = {
			tiles: tileKeys.length,
			zones: [...scan.chunks.keys()].sort((x, y) => x - y),
			pairs: b.stats,
			open: b.open.length,
			crossings: b.crossings.length,
			crossingKinds: kinds(b.crossings, (e) => e.meta.kind),
			oneWay: b.crossings.filter((e) => e.oneWay).length,
			targets: mine.length,
			pockets: pockets.length,
			notPockets: Object.fromEntries([...why].sort((x, y) => y[1] - x[1])),
			chains: chains.length,
			chainKinds: kinds(chains, (ch) => ch.meta.kind),
			chainNodes: chains.reduce((s, ch) => s + ch.nodes.length, 0),
			seconds: { borders: (t1 - t0) / 1000, crossings: (t2 - t1) / 1000, pockets: (t3 - t2) / 1000 },
		};
	}
	// Ids are unique across crossings and chains: a chain id that a later crossing took gets a suffix.
	const ids = new Set(doc.crossings.map((e) => e.id));
	for (const ch of doc.chains) {
		if (!ids.has(ch.id)) {
			ids.add(ch.id);
			continue;
		}
		let n = 2;
		while (ids.has(`${ch.id}-${n}`)) n++;
		ch.id = `${ch.id}-${n}`;
		ids.add(ch.id);
	}
	const v = validateCrossings(JSON.parse(JSON.stringify(doc)), frames);
	stats.errors = v.errors;
	return { doc, stats, set: v };
}

// --- targets ------------------------------------------------------------------------------

// Places the arrow leads to -> [{ c, wx, wy, map, name, kind }]:
// guides: compiled guides (compileProject): every located goal and its spawn spots;
// data: { quests, npcs, objects, trainers } (data/forever); geo: planner Geo
// (Era and live frames); travel: travel.json (flight masters, inns);
// entrances: data/codex/entrances.json (live map percent).
function collectTargets({ guides = [], data = {}, geo, travel = null, entrances = null, continents = null }) {
	const out = [];
	const keep = (c) => !continents || continents.includes(c);
	const push = (map, x, y, f, name, kind) => {
		const w = geo.toWorld(map, x, y, f === 'e' ? 'e' : 'l');
		if (!w || !keep(w.c)) return;
		out.push({ c: w.c, wx: w.wx, wy: w.wy, map, name: name ? String(name) : '', kind });
	};
	for (const g of guides) {
		for (const step of g.steps || []) {
			for (const goal of step.goals || []) {
				if (goal.map == null || goal.x == null) continue;
				const name = goal.npcName || goal.objName || goal.location || goal.target || goal.itemName || goal.title || step.title || '';
				push(goal.map, goal.x, goal.y, goal.f, name, 'goal');
				for (const s of goal.spots || []) push(goal.map, s.x, s.y, goal.f, name, 'spot');
			}
		}
	}
	const spawnsOf = (rec, kind) => {
		if (!rec || !rec.spawns) return;
		for (const [map, s] of Object.entries(rec.spawns)) for (const [x, y] of s.pts || []) push(Number(map), x, y, s.f, rec.name, kind);
	};
	const quests = data.quests ? (Array.isArray(data.quests) ? data.quests : Object.values(data.quests)) : [];
	const givers = new Set();
	const things = new Set();
	for (const q of quests) {
		for (const side of [q.start, q.end]) {
			if (!side) continue;
			for (const id of side.npc || []) givers.add(id);
			for (const id of side.object || []) things.add(id);
		}
	}
	for (const id of [...givers].sort((a, b) => a - b)) spawnsOf(data.npcs && data.npcs[id], 'quest');
	for (const id of [...things].sort((a, b) => a - b)) spawnsOf(data.objects && data.objects[id], 'quest');
	if (travel) {
		for (const n of (travel.taxi && travel.taxi.nodes) || []) if (keep(n.c)) out.push({ c: n.c, wx: n.wx, wy: n.wy, map: n.map, name: n.npcName || n.name, kind: 'flight' });
		for (const i of travel.inns || []) if (keep(i.c)) out.push({ c: i.c, wx: i.wx, wy: i.wy, map: i.map, name: i.npcName || i.location, kind: 'inn' });
	}
	for (const id of Object.keys(data.trainers || {}).map(Number).sort((a, b) => a - b)) spawnsOf(data.npcs && data.npcs[id], 'trainer');
	for (const e of (entrances && entrances.entrances) || []) push(e.map, e.x, e.y, 'l', e.key.replace(/-/g, ' '), 'entrance');
	return out;
}

module.exports = {
	generateAids,
	zoneResolver,
	loadZoneResolver,
	collectTargets,
	scanBorders,
	Zones,
	Generator,
	polyOf,
	pointAt,
	slug,
	CONSTANTS: {
		OPEN_MIN, OPEN_SHARE, OPEN_GAP, OPEN_PROBE, OPEN_PROBES, PASSAGE_JOIN, PASSAGE_MAX, END_AT, END_MIN, END_MAX, DEDUPE, TARGET_GRID,
		SAMPLES, SAMPLE_RADII, SHARE_TOL, SHARE_QUORUM, POCKET_MIN, INDOOR_SHARE, CLIMB_RISE, NARROW, NODE_TOL, NODE_RADIUS,
	},
};

// A pocket-testing worker thread (pocketsOf): blocks of targets in, [pocket | null, reason] out.
const threads = require('node:worker_threads');

if (!threads.isMainThread && threads.workerData && threads.workerData.aidsWorker) {
	const d = threads.workerData;
	const { openNav } = require('./path');
	const nav = openNav({ dir: d.dir, cacheTiles: 96 });
	const frames = new Frames(d.eraFrames, d.zonesJson);
	const zones = new Zones(nav, d.c, zoneResolver({ zones: d.spec.zones, areaRows: d.spec.areaRows, frames }));
	const gen = new Generator({ nav, c: d.c, frames, zones, open: new Map(d.open.map(([z, list]) => [z, new Set(list)])), foot: FootRegions.from(d.foot) });
	threads.parentPort.on('message', (msg) => {
		if (!msg) {
			threads.parentPort.close();
			return;
		}
		const results = msg.items.map((t) => {
			let reason = null;
			const p = gen.pocket(t, (w) => {
				reason = w;
			});
			return [p, reason];
		});
		threads.parentPort.postMessage({ from: msg.from, results });
	});
}
