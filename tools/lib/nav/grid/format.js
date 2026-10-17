'use strict';
// The navigation grid's constants and its files under data/local/nav/
// (docs/ARCHITECTURE.md, "Navigation grid").
//
//   index.json                        schema, product, build, builtAt, constants (every value
//                                     below), continents: { [c]: { name, tiles: ['col_row'],
//                                     surfaces, walkable, falls, nodes, edges, regions, graph } }
//   tiles/<c>/<col>_<row>.nav.gz      one ADT tile's surfaces and links (TILE below)
//   tiles/<c>/<col>_<row>.walls.gz    the tile's walls (WALLS below; build cache, read by the links pass)
//   tiles/<c>/<col>_<row>.hpa.gz      the tile's part of the abstract graph (JSON, build cache)
//   graph/<c>.bin.gz                  the continent's abstract graph and regions (GRAPH below)
//   lifts.json                        lifts per continent: { [c]: [{ name, id, a, b, h }] }, a and b
//                                     { col, row, k, entry, z } (build.js liftLinks; path.js links them both ways)
//
// Cells: CELL = ADT / 256; a tile is 256 x 256 columns, column (i, j) with i
// eastward (wy decreasing) and j southward (wx decreasing), k = j * 256 + i,
// centre wx = (32 - row) * ADT - (j + 0.5) * CELL, wy = (32 - col) * ADT - (i + 0.5) * CELL.
// Column i = 256 is column 0 of tile col + 1, j = 256 row + 1.
//
// A column holds its entries (span tops) in ascending z: every solid span of
// the rasterised geometry, walkable or not (BLOCKED), plus swim surfaces.
// An entry's `ceil` is the bottom of the next span above (Infinity: open sky).
//
// TILE (gzip; little-endian; arrays start 4-aligned):
//   0  u32  magic 'PNAV' (0x564e4150)
//   4  u32  VERSION
//   8  u32  c
//   12 u16  col, 14 u16 row
//   16 u32  n        entries
//   20 u32  m        falls
//   24 u32  nComp    local components (links present)
//   28 u32  bits     1: links present
//   32 u16[256]      areas: chunk area id, index (j >> 4) * 16 + (i >> 4)
//      u8[65536]     count: entries per column k (prefix sums give `first`)
//      f32[n]        z
//      f32[n]        ceil
//      u32[n]        comp: local component of each walkable entry (NO_COMP for blocked) [links]
//      u32[m]        fallFrom: entry index, ascending                                    [links]
//      u16[m] pad 4  fallTo: (offset << 5) | layer, offset = (di + R) * (2R + 1) + (dj + R), R = FALL_SLIDE [links]
//      u8[n]         flags (FLAG)
//      u8[n]         slope, degrees
//      u8[8n]        links: per entry, per direction DIRS[d]: NO_LINK or (cls << 5) | layer [links]
//      u8[n]         tslope, degrees: the steepest terrain triangle of the entry's span, 0 on
//                    model and swim surfaces (surfaces.js) [version 4; version 3 ends before it]
//
// WALLS (gzip; little-endian): model triangles of WALL_MIN or steeper, kept
// as the z ranges where they cross each column's four half-lines (from the
// centre to the middle of a side: HALF.E, S, W, N, the half-line of
// orthogonal direction DIRS[d] being d >> 1), merged per half-line.
//   0  u32  magic 'PNWL', 4 u32 VERSION, 8 u32 w ranges
//   12 u8[4 * 65536]  count: ranges per half-line k * 4 + h (prefix sums give `at`)
//      f32[w]  lo, f32[w] hi
//
// GRAPH (gzip; little-endian): the abstract graph over tile borders the route
// search runs first (path.js; built by graph.js): nodes at border entrances
// (runs of links between two tiles, up to RUN_MAX border columns each), the
// edges between a tile's nodes inside the tile per reference profile
// (REF_PROFILES) and the links across borders, plus the region of every
// local component.
//   0  u32 magic 'PNGR', 4 u32 GRAPH_VERSION, 8 u32 c, 12 u32 T tiles, 16 u32 N nodes,
//   20 u32 R total local components, 24 u32 G graphs (REF_PROFILES.length), 28 u32 K regions
//   T x { u16 col, u16 row, u32 nodeBase, u32 nodeCount, u32 compBase, u32 compCount }  (20 bytes)
//   u32[N] node entry index, u16[N] node column k (pad 4), f32[N] node z
//   u32[R] region of each local component (compBase[tile] + comp)
//   u32[K] walkable surfaces of each region
//   G x { u32 E, u32[N + 1] offsets, u32[E] target node, u16[E * 7] cost terms }
// Cost terms of an edge (move.js TERMS): outdoor and indoor yards weighted
// by their slope class (move.js SLOPE_MUL) and swim yards, each x 4; jumps;
// fall seconds x 10; remounts; lift seconds x 10 (each u16, saturating).

const zlib = require('node:zlib');

const ADT = 1600 / 3;
const TILE_CELLS = 256;
const CELL = ADT / TILE_CELLS;
const COLUMNS = TILE_CELLS * TILE_CELLS;

// Slope classes (decided in the spec; sources checked 2026-10-15): the 1.12
// client's walk resolver (github.com/samwhosung/wow-1121-client-internals,
// docs/collision.md, "The WALK resolver") counts a hit walkable at cos 50°
// on models and cos 80° on terrain and steps up collHeight x tan 50°, so the
// client is more lenient on terrain than these classes; TrinityCore's mmaps
// generator (src/common/mmaps_common/Generator/TileBuilder.cpp) uses
// walkableSlopeAngle 55 with an optional steep band up to its configured
// maximum, walkableHeight and walkableClimb 6 x 0.2667 = 1.6 yd.
// Reachability follows the client (models walkable to 50°, terrain to 80°);
// the route cost grades terrain (decided here, move.js SLOPE_MUL): gradient
// up to GENTLE_MAX x1, to WALK_MAX x1.5, to STEEP_MAX x3 (steep), to
// CLIMB_MAX x6 (climb).
const GENTLE_MAX = 35; // degrees
const WALK_MAX = 50; // degrees: model surfaces walkable up to here
const STEEP_MAX = 60; // degrees: terrain steep band
const CLIMB_MAX = 80; // degrees: terrain walkable (as a climb) up to here
// WMO staircases modelled as treads and risers: column tops 2.08 yd apart
// differ by more than STEP on any stair over 26°; links.js walks them as a
// slope up to this gradient when the treads under the upper column's top
// climb from the lower surface in rises of at most STEP (decided 2026-10-15:
// the stairs of crypts and keeps were falls one way and nothing the other).
// Steps higher than that, rises to STEP under a top rise to JUMP and at most
// STEP + JUMP in all (decided 2026-10-15: the Ruins of Lordaeron's throne
// room above the Undercity's lift halls, 0.7 and 1.5 yd in one column), are
// a jump at any gradient.
const STAIR_MAX = 45; // degrees
// Walls (rasterise.js): model triangles this steep or steeper (whole degrees) are kept as the
// ranges where they cross each column's half-lines, not as spans; links.js
// lets no move cross one between a step and a body height above the feet
// (decided 2026-10-15; faces between WALK_MAX and here, roofs, rock faces
// and leaning cave walls, are spans where they cross a centre line).
const WALL_MIN = 80; // degrees
const HALF = { E: 0, S: 1, W: 2, N: 3 }; // half-lines; orthogonal direction DIRS[d] is d >> 1
const AGENT_HEIGHT = 1.6; // yd of clearance a surface needs
const STEP = 1.0; // yd: the smallest step up any surface allows
const JUMP = 1.6; // yd: the highest ledge a jump climbs
const SWIM_DEPTH = 1.5; // yd of liquid above the floor that make it a swim surface
// Falls (cMaNGOS mangos-classic Player::HandleFall, src/game/Entities/Player.cpp:
// no damage below 14.57 yd, damage share 0.018 * h - 0.2426 of max health).
const SAFE_FALL = 14.57;
const FALL_MAX = 30; // yd onto ground
const FALL_MAX_WATER = 60; // yd into a swim surface
// A fall lands on stable ground: a 2 x 2 block of walkable surfaces level
// with the landing (within STEP), all under STEEP_MAX (STABLE_CELLS = 4);
// otherwise it slides on, one fall of the total height (links.js).
const STABLE_CELLS = 4;
const MERGE_TOP = 0.5; // yd: spans whose tops are this close keep the flatter top's slope
// Lifts (decided here; build.js liftPoints, liftLinks): the spawns of objects
// the client animates as transports (TransportAnimation) whose car rises at
// least LIFT_MIN and sways at most LIFT_RADIUS join two landings within
// LIFT_REACH of the spawn, both ways: open walkable surfaces (search.js
// isOpen, LIFT_OPEN surfaces; not a shaft's roof or beams) whose heights
// differ by the car's rise within LIFT_FIT. The animated rise is the
// landings' (the Undercity's cars rise 96.5 yd, their lower and upper
// stations are 96.6 yd apart, the upper 8.7 yd from the spawn, the car's
// middle); a lid over the shaft 103.7 yd up is no landing.
const LIFT_RADIUS = 8; // yd a car may sway
const LIFT_REACH = 10; // yd from the spawn a landing may lie
const LIFT_MIN = 10; // yd of height a lift must span (shorter animations are doors and plungers: Undercity lowerLdoor 8.1 yd)
const LIFT_FIT = 2; // yd between the landings' height difference and the car's rise
const LIFT_OPEN = 200; // surfaces a landing reaches (and is reached from) inside its tile

// SWIM | BLOCKED: fatigue water (MH2O deep quads, surfaces.js), never swum.
const FLAG = { TERRAIN: 1, WMO: 2, M2: 4, INDOOR: 8, SWIM: 16, OCEAN: 32, STEEP: 64, BLOCKED: 128 };
// The route's segment classes (path.js). Stored link codes (3 bits) are the
// same numbers for walk, steep, swim, jump and climb, plus LINK_SLOPE (walk
// at x1.5); falls and lifts are stored apart. Search steps (grid/search.js
// outCode) carry a stored link code, CLS.FALL (4, never stored) or CODE_LIFT
// (8: CLS.LIFT is 7, the stored LINK_SLOPE).
const CLS = { WALK: 0, STEEP: 1, SWIM: 2, JUMP: 3, FALL: 4, INDOOR: 5, CLIMB: 6, LIFT: 7 };
const CLS_NAMES = ['walk', 'steep', 'swim', 'jump', 'fall', 'indoor', 'climb', 'lift'];
const LINK_SLOPE = 7;
const CODE_LIFT = 8;
const NO_LINK = 0xff;
const NO_COMP = 0xffffffff;
const MAX_LAYERS = 31;
// Directions: E, SE, S, SW, W, NW, N, NE (i east, j south).
const DIRS = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]];
const FALL_REACH = 3; // cells to the first landing: two past a cliff's lip (spec: "within two cells")
const FALL_SLIDE = 12; // cells a fall may carry in all, sliding over unstable ground

const RUN_MAX = 32; // border columns per abstract entrance at most
const REF_PROFILES = ['foot', 'mount'];

const VERSION = 4; // TILE; 4: tslope (surfaces.js); 3: fatigue water is blocked (surfaces.js)
const TILE_VERSIONS = [3, 4]; // TILE versions decodeTile reads (version 3: tslope null)
const WALLS_VERSION = 1;
const GRAPH_VERSION = 5; // 5: slope links are no lift rides (CODE_LIFT); 4: move.js costs of 2026-10-15 (fall comfort, slope x2 / x4 / x10)
const MAGIC_TILE = 0x564e4150; // 'PNAV'
const MAGIC_GRAPH = 0x52474e50; // 'PNGR'
const MAGIC_WALLS = 0x4c574e50; // 'PNWL'
const WALL_MERGE = 0.05; // yd: ranges of a half-line this close merge

const CONSTANTS = {
	ADT, CELL, TILE_CELLS, GENTLE_MAX, WALK_MAX, STEEP_MAX, CLIMB_MAX, STAIR_MAX, WALL_MIN, AGENT_HEIGHT, STEP, JUMP, SWIM_DEPTH, SAFE_FALL, FALL_MAX, FALL_MAX_WATER,
	STABLE_CELLS, MERGE_TOP, MAX_LAYERS, FALL_REACH, FALL_SLIDE, RUN_MAX, LIFT_RADIUS, LIFT_REACH, LIFT_MIN, LIFT_FIT, LIFT_OPEN,
};

const tileKey = (col, row) => `${col}_${row}`;
const align4 = (n) => (n + 3) & ~3;

// The world centre of column (i, j) of tile (col, row).
function cellCentre(col, row, i, j) {
	return { wx: (32 - row) * ADT - (j + 0.5) * CELL, wy: (32 - col) * ADT - (i + 0.5) * CELL };
}

// The tile and column of a world point.
function cellOf(wx, wy) {
	const u = (32 * ADT - wy) / CELL;
	const v = (32 * ADT - wx) / CELL;
	const gi = Math.floor(u);
	const gj = Math.floor(v);
	const col = Math.floor(gi / TILE_CELLS);
	const row = Math.floor(gj / TILE_CELLS);
	return { col, row, i: gi - col * TILE_CELLS, j: gj - row * TILE_CELLS };
}

function firstOf(count) {
	const first = new Uint32Array(COLUMNS + 1);
	for (let k = 0; k < COLUMNS; k++) first[k + 1] = first[k] + count[k];
	return first;
}

// tile: { c, col, row, n, count, z, ceil, flags, slope, tslope, areas, links?, comp?, nComp?, fallFrom?, fallTo? } -> gzip Buffer
function encodeTile(t) {
	const hasLinks = !!t.links;
	const n = t.n;
	const m = hasLinks ? t.fallFrom.length : 0;
	let size = 32 + 512 + COLUMNS + 8 * n;
	if (hasLinks) size += 4 * n + 4 * m + align4(2 * m);
	size += 2 * n + (hasLinks ? 8 * n : 0) + n;
	if (!t.tslope || t.tslope.length !== n) throw new Error(`nav tile ${t.c} ${tileKey(t.col, t.row)}: no tslope (a version 3 tile is never written)`);
	const buf = Buffer.alloc(size);
	const dv = new DataView(buf.buffer, buf.byteOffset, buf.byteLength);
	dv.setUint32(0, MAGIC_TILE, true);
	dv.setUint32(4, VERSION, true);
	dv.setUint32(8, t.c, true);
	dv.setUint16(12, t.col, true);
	dv.setUint16(14, t.row, true);
	dv.setUint32(16, n, true);
	dv.setUint32(20, m, true);
	dv.setUint32(24, hasLinks ? t.nComp : 0, true);
	dv.setUint32(28, hasLinks ? 1 : 0, true);
	let o = 32;
	const put = (arr) => {
		const bytes = new Uint8Array(arr.buffer, arr.byteOffset, arr.byteLength);
		buf.set(bytes, o);
		o += bytes.length;
	};
	put(t.areas);
	put(t.count);
	put(t.z);
	put(t.ceil);
	if (hasLinks) {
		put(t.comp);
		put(t.fallFrom);
		put(t.fallTo);
		o = align4(o);
	}
	put(t.flags);
	put(t.slope);
	if (hasLinks) put(t.links);
	put(t.tslope);
	return zlib.gzipSync(buf, { level: 6 });
}

// gunzip in one output chunk (the gzip trailer's ISIZE): no chunk concatenation.
function gunzip(gz) {
	const isize = gz.length >= 18 ? gz.readUInt32LE(gz.length - 4) : 0;
	return zlib.gunzipSync(gz, { chunkSize: Math.max(64 * 1024, isize + 1) });
}

function decodeTile(gz) {
	const raw = gunzip(gz);
	// Typed views need 4-aligned offsets: copy when the buffer is not.
	const buf = raw.byteOffset % 4 ? new Uint8Array(raw) : raw;
	const ab = buf.buffer;
	const base = buf.byteOffset;
	const dv = new DataView(ab, base, buf.byteLength);
	if (dv.getUint32(0, true) !== MAGIC_TILE) throw new Error('not a nav tile');
	const version = dv.getUint32(4, true);
	if (!TILE_VERSIONS.includes(version)) throw new Error(`nav tile version ${version}, expected ${TILE_VERSIONS.join(' or ')}`);
	const n = dv.getUint32(16, true);
	const m = dv.getUint32(20, true);
	const hasLinks = (dv.getUint32(28, true) & 1) === 1;
	let o = base + 32;
	const take = (Ctor, len) => {
		const a = new Ctor(ab, o, len);
		o += len * Ctor.BYTES_PER_ELEMENT;
		return a;
	};
	const t = { c: dv.getUint32(8, true), col: dv.getUint16(12, true), row: dv.getUint16(14, true), n };
	t.areas = take(Uint16Array, 256);
	t.count = take(Uint8Array, COLUMNS);
	t.z = take(Float32Array, n);
	t.ceil = take(Float32Array, n);
	if (hasLinks) {
		t.nComp = dv.getUint32(24, true);
		t.comp = take(Uint32Array, n);
		t.fallFrom = take(Uint32Array, m);
		t.fallTo = take(Uint16Array, m);
		o = base + align4(o - base);
	}
	t.flags = take(Uint8Array, n);
	t.slope = take(Uint8Array, n);
	if (hasLinks) t.links = take(Uint8Array, 8 * n);
	t.tslope = version >= 4 ? take(Uint8Array, n) : null;
	t.first = firstOf(t.count);
	return t;
}

// Wall ranges (key = k * 4 + h, lo, hi; any order) -> { at: Uint32Array(4 *
// COLUMNS + 1), lo, hi }: half-line key's ranges at [at[key], at[key + 1]),
// ascending, those within WALL_MERGE merged (at most 255 per half-line).
function wallIndex(key, lo, hi) {
	const K = 4 * COLUMNS;
	const at = new Uint32Array(K + 1);
	for (let r = 0; r < key.length; r++) at[key[r] + 1]++;
	for (let x = 0; x < K; x++) at[x + 1] += at[x];
	const fill = at.slice(0, K);
	const sLo = new Float32Array(key.length);
	const sHi = new Float32Array(key.length);
	for (let r = 0; r < key.length; r++) {
		const p = fill[key[r]]++;
		sLo[p] = lo[r];
		sHi[p] = hi[r];
	}
	// Per half-line: sort by lo (lists are short) and merge.
	const oLo = new Float32Array(key.length);
	const oHi = new Float32Array(key.length);
	const out = new Uint32Array(K + 1);
	let w = 0;
	for (let x = 0; x < K; x++) {
		const a = at[x];
		const b = at[x + 1];
		for (let p = a + 1; p < b; p++) {
			const l = sLo[p];
			const h = sHi[p];
			let q = p - 1;
			while (q >= a && sLo[q] > l) {
				sLo[q + 1] = sLo[q];
				sHi[q + 1] = sHi[q];
				q--;
			}
			sLo[q + 1] = l;
			sHi[q + 1] = h;
		}
		const start = w;
		for (let p = a; p < b; p++) {
			if (w > start && (sLo[p] <= oHi[w - 1] + WALL_MERGE || w - start === 255)) {
				if (sHi[p] > oHi[w - 1]) oHi[w - 1] = sHi[p];
				continue;
			}
			oLo[w] = sLo[p];
			oHi[w] = sHi[p];
			w++;
		}
		out[x + 1] = w;
	}
	return { at: out, lo: oLo.slice(0, w), hi: oHi.slice(0, w) };
}

// Whether a wall crosses half-line h of column k anywhere in (lo, hi).
function wallBlocks(walls, k, h, lo, hi) {
	if (!walls) return false;
	const key = k * 4 + h;
	for (let r = walls.at[key], e = walls.at[key + 1]; r < e; r++) if (walls.lo[r] < hi && walls.hi[r] > lo) return true;
	return false;
}

// wallIndex()'s walls -> gzip Buffer (WALLS).
function encodeWalls(walls) {
	const K = 4 * COLUMNS;
	const w = walls.lo.length;
	const buf = Buffer.alloc(12 + K + 8 * w);
	buf.writeUInt32LE(MAGIC_WALLS, 0);
	buf.writeUInt32LE(WALLS_VERSION, 4);
	buf.writeUInt32LE(w, 8);
	for (let x = 0; x < K; x++) buf[12 + x] = walls.at[x + 1] - walls.at[x];
	Buffer.from(walls.lo.buffer, walls.lo.byteOffset, 4 * w).copy(buf, 12 + K);
	Buffer.from(walls.hi.buffer, walls.hi.byteOffset, 4 * w).copy(buf, 12 + K + 4 * w);
	return zlib.gzipSync(buf, { level: 6 });
}

function decodeWalls(gz) {
	const buf = gunzip(gz);
	if (buf.readUInt32LE(0) !== MAGIC_WALLS) throw new Error('not a nav walls file');
	if (buf.readUInt32LE(4) !== WALLS_VERSION) throw new Error(`nav walls version ${buf.readUInt32LE(4)}, expected ${WALLS_VERSION}`);
	const K = 4 * COLUMNS;
	const w = buf.readUInt32LE(8);
	const at = new Uint32Array(K + 1);
	for (let x = 0; x < K; x++) at[x + 1] = at[x] + buf[12 + x];
	const lo = new Float32Array(w);
	const hi = new Float32Array(w);
	new Uint8Array(lo.buffer).set(buf.subarray(12 + K, 12 + K + 4 * w));
	new Uint8Array(hi.buffer).set(buf.subarray(12 + K + 4 * w, 12 + K + 8 * w));
	return { at, lo, hi };
}

// The abstract graph of a continent -> gzip Buffer.
// g: { c, tiles: [{ col, row, nodeBase, nodeCount, compBase, compCount }], nodeEntry: Uint32Array,
//      nodeK: Uint16Array, nodeZ: Float32Array, region: Uint32Array, graphs: [{ off: Uint32Array, to: Uint32Array, terms: Uint16Array }] }
function encodeGraph(g) {
	const N = g.nodeEntry.length;
	const R = g.region.length;
	const K = g.regionSize.length;
	let size = 32 + 20 * g.tiles.length + 4 * N + align4(2 * N) + 4 * N + 4 * R + 4 * K;
	for (const gr of g.graphs) size += 4 + 4 * (N + 1) + 4 * gr.to.length + align4(2 * gr.terms.length);
	const buf = Buffer.alloc(size);
	const dv = new DataView(buf.buffer, buf.byteOffset, buf.byteLength);
	dv.setUint32(0, MAGIC_GRAPH, true);
	dv.setUint32(4, GRAPH_VERSION, true);
	dv.setUint32(8, g.c, true);
	dv.setUint32(12, g.tiles.length, true);
	dv.setUint32(16, N, true);
	dv.setUint32(20, R, true);
	dv.setUint32(24, g.graphs.length, true);
	dv.setUint32(28, K, true);
	let o = 32;
	for (const t of g.tiles) {
		dv.setUint16(o, t.col, true);
		dv.setUint16(o + 2, t.row, true);
		dv.setUint32(o + 4, t.nodeBase, true);
		dv.setUint32(o + 8, t.nodeCount, true);
		dv.setUint32(o + 12, t.compBase, true);
		dv.setUint32(o + 16, t.compCount, true);
		o += 20;
	}
	const put = (arr) => {
		buf.set(new Uint8Array(arr.buffer, arr.byteOffset, arr.byteLength), o);
		o = align4(o + arr.byteLength);
	};
	put(g.nodeEntry);
	put(g.nodeK);
	put(g.nodeZ);
	put(g.region);
	put(g.regionSize);
	for (const gr of g.graphs) {
		dv.setUint32(o, gr.to.length, true);
		o += 4;
		put(gr.off);
		put(gr.to);
		put(gr.terms);
	}
	return zlib.gzipSync(buf.subarray(0, o), { level: 6 });
}

function decodeGraph(gz) {
	const raw = gunzip(gz);
	const buf = raw.byteOffset % 4 ? new Uint8Array(raw) : raw;
	const ab = buf.buffer;
	const base = buf.byteOffset;
	const dv = new DataView(ab, base, buf.byteLength);
	if (dv.getUint32(0, true) !== MAGIC_GRAPH) throw new Error('not a nav graph');
	if (dv.getUint32(4, true) !== GRAPH_VERSION) throw new Error(`nav graph version ${dv.getUint32(4, true)}, expected ${GRAPH_VERSION}`);
	const T = dv.getUint32(12, true);
	const N = dv.getUint32(16, true);
	const R = dv.getUint32(20, true);
	const G = dv.getUint32(24, true);
	const K = dv.getUint32(28, true);
	const g = { c: dv.getUint32(8, true), tiles: [], graphs: [] };
	let o = 32;
	for (let i = 0; i < T; i++) {
		g.tiles.push({
			col: dv.getUint16(o, true), row: dv.getUint16(o + 2, true), nodeBase: dv.getUint32(o + 4, true),
			nodeCount: dv.getUint32(o + 8, true), compBase: dv.getUint32(o + 12, true), compCount: dv.getUint32(o + 16, true),
		});
		o += 20;
	}
	const take = (Ctor, len) => {
		const a = new Ctor(ab, base + o, len);
		o = align4(o + len * Ctor.BYTES_PER_ELEMENT);
		return a;
	};
	g.nodeEntry = take(Uint32Array, N);
	g.nodeK = take(Uint16Array, N);
	g.nodeZ = take(Float32Array, N);
	g.region = take(Uint32Array, R);
	g.regionSize = take(Uint32Array, K);
	for (let i = 0; i < G; i++) {
		const E = dv.getUint32(o, true);
		o += 4;
		const off = take(Uint32Array, N + 1);
		const to = take(Uint32Array, E);
		const terms = take(Uint16Array, E * 7);
		g.graphs.push({ off, to, terms });
	}
	return g;
}

module.exports = {
	ADT, TILE_CELLS, CELL, COLUMNS, GENTLE_MAX, WALK_MAX, STEEP_MAX, CLIMB_MAX, STAIR_MAX, WALL_MIN, HALF, AGENT_HEIGHT, STEP, JUMP, SWIM_DEPTH, SAFE_FALL, FALL_MAX, FALL_MAX_WATER,
	MERGE_TOP, STABLE_CELLS, LIFT_RADIUS, LIFT_REACH, LIFT_MIN, LIFT_FIT, LIFT_OPEN, LINK_SLOPE, CODE_LIFT, FALL_SLIDE,
	FLAG, CLS, CLS_NAMES, NO_LINK, NO_COMP, MAX_LAYERS, DIRS, FALL_REACH, RUN_MAX, REF_PROFILES, VERSION, TILE_VERSIONS, GRAPH_VERSION, CONSTANTS,
	tileKey, cellCentre, cellOf, firstOf, encodeTile, decodeTile, encodeGraph, decodeGraph, wallIndex, wallBlocks, encodeWalls, decodeWalls,
};
