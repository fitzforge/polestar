'use strict';
// Our navigation grid as Polestar's walking maps (format 2), the maps of
// Polestar's walking router (Routing/PathGrid.lua, Path.lua, PathJobs.lua),
// grown from Shortest Path Forever's walking-map format (docs/ARCHITECTURE.md,
// "Navigation grid", "Packing for the in-game engine").
//
// Ported from Shortest Path Forever v1.15.0 by Cillian Berragan
// (github.com/cjber/shortest-path-forever, GPL-3.0-or-later, used with his
// permission): the HPA* graph, the cluster encodings and the floor links of
// tools/baker/gen_nav.py, and the zlib + base64 parts of tools/pack_nav.py.
// The format is written down in each generated NavN.lua's header (HEADER).
// Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
//
// The walking-map writer is `forge nav pack` (rust/crates/forge-nav/src/pack, the port of this file:
// docs/forge/nav.md). What stays here is what `nav eval` and its tests still load: the CellGrid,
// the HPA* graph and the encoders, on hand-made maps (tests/nav-eval.test.js), the capitals
// (cityTest, nav eval's indoor layer) and the zones (zoneAreas, router.js):
//
//   const { CellGrid, buildHpa, encodeMaps, packFiles } = require('tools/lib/nav/pack');
//   buildHpa(cg)         the HPA* graph, each edge priced per profile
//   encodeMaps(cg, hpa)  -> the five per-cluster strings (graph, grid,
//                        height, floor, class) and the zone field's
//   packFiles(...)       strings -> NavN.lua (metadata) + NavN_i.lua parts
//                        of zlib-compressed, base64 blocks
//
// Ground classes (maps format 2, decided 2026-10-16 in the pathing v2
// design, its section 1): each surface carries a class
// byte (nodeClass; Routing/Costs.lua and its copy costs.js price it): steep
// slope when its steepest terrain triangle (the grid's tslope, over its
// columns) is from SLOPE.STEEP degrees, else indoor when most of its entries
// are FLAG.INDOOR (indoor city in a capital: the chunk's area or the zone map
// around it, readLayers), else road when any of its columns is road (the
// roads layer through roadmask.js), else gentle slope from SLOPE.GENTLE; and
// a hub bit for each side whose hub disk touches the cell (markHubs). A graph
// edge carries the cost of its grid path under each profile (Alliance, Horde,
// none: a step costs its length times the class's multiplier, times swim in
// water) and its yards.
//
// Zones (decided 2026-10-17, the zone danger design): each cluster carries
// the zone of its 16 x 16 chunks (the grid's chunk area, up its AreaTable
// parents to a zone of zones.json, as its uiMapID, no map frame needed:
// zoneAreas, through readLayers) in the
// metadata's zone field; the router prices a step into a zone its caller
// marks dangerous (Routing/Path.lua). Nothing else depends on it: every other
// field is the same bytes with or without zones.
//
// Entrances (his rule, plus roads decided 2026-10-16, Ruling 31). A cluster
// border's crossings are grouped by the region on each side; his rule puts
// one entrance in every run of ENTRANCE_YD-in-cells crossings, at its middle
// (a straight crossing first). Every walk across the border goes through an
// entrance, so a road crossing it between two of them was walked off: Fitz
// at Ratchet, where the border crosses the north-east road 35 yd from the
// main road and the one entrance sat on the main road, saw his walk leave
// the road along the border. So each run of road crossings (both cells road)
// gets an entrance of its own at its middle, unless one of his lies within
// ROAD_NEAR_YD of the run. Dry ground too (Ruling 37, 2026-10-17): a region
// holds land and the water it wades into, so his entrance can fall in the
// water beside a beach or a pier's root, and every walk across that border
// swam (Fitz at Auberdine, where the pier's beach crosses x = 6400 and walks
// to the boats swam 200 yd across the bay). So each run of dry crossings
// (both cells ground, value 1) that no entrance crosses dry gets one at its
// middle.
//
// Cells (decided here). SPF's cluster is one ADT tile cut into C x C cells
// (C = `cells`), x north, y west; our tile is 256 x 256 columns (format.js),
// column (i, j) falls in cell (floor((255.5 - j) C / 256), floor((255.5 - i)
// C / 256)) by its centre. A cell's surfaces are the connected pieces of
// our walkable surfaces in its columns, joined by our links inside the
// cell (every stored link but a closed one, CLOSED below), leaving out
// regions of under MIN_REGION surfaces (rooftops, props) and anything below
// the cell's top water surface (lake beds; SPF's rule) but an indoor floor
// with a solid span over it below the water (its entry's ceil): a city or a
// cave under a lake. SPF's rule alone dropped every floor under a lake, and
// the Undercity's Royal Quarter lies under one of Tirisfal's: its corridor
// (1458 46,73 to 49,88) and every room past it were cut out, so walks to
// Varimathras, Sylvanas and Sharlindra climbed out of the city and ended in
// a straight line down (#420). Outdoor ground under water stays out even when
// roofed: the terrain under Stormwind's canals, which no one walks, joined
// up drew walks across the city on it. The piece of the
// largest region (then the most columns, then the highest) is the base
// surface, the others are floors, by height: pieces at one height that a
// wall inside the cell parts stay apart, so a wall never leaks through a
// cell. A piece's height is its entry nearest the cell's centre; its value
// 2 (water) when most of its entries are swim surfaces, else 1.
// Edges (decided here): two surfaces of neighbouring cells (8 directions)
// are joined when one of our links (not a closed one; either way) crosses
// between their entries (a face link only as a bridge, Faces below). The base-to-base steps go to the grid's close
// flags (an orthogonal step with no link is closed; a diagonal with a link
// whose L-shaped detours are closed is opened explicitly), every pair with
// a floor to the floor links. Falls (one way down) and lifts (SPF keeps
// lifts outside the grid, in its transport data) are left out; a step costs
// its length times its ground class's multiplier (water `swim` times that).
// Fatigue water is no surface of our grid (SWIM | BLOCKED,
// grid/surfaces.js), so no route here crosses open sea.
// Faces (decided 2026-10-16). His steps are two-way and cost their flat
// length, so a face packed as steps is a straight line up it. Forever's
// client slides off terrain whose triangle is steeper than about 50°
// (FLAG.STEEP, the triangle under the column): Fitz could not walk up the
// slope by the Raptor Horns (the Barrens, 61.66,35.46 to 61.00,33.70), 51-56°
// triangles rising 14 yd, that the engine drew a line up. Column-to-column
// gradients there read 32-49° on half the links (the columns sample the
// ADT's triangles alternately), and the 4.17 yd cells average the rest, so
// neither our link classes nor the cells' heights see that face. Hence:
// - climbed links (CLIMB, 60-80°, one way up) are no step (CLOSED);
// - face links are held back: steep links (STEEP, 50-60°), and terrain links
//   touching a FLAG.STEEP column inside a run of them (along the link's
//   direction) that rises more than JUMP: a hop up one steep triangle is
//   kept, a slope of them is not; and terrain links touching ground whose
//   height, over FALL_SPAN columns either way (8.3 yd across), rises more
//   than 50° (a hillside whose triangles alternate 49° and 54° is such a
//   slope, though no run of steep ones is);
// - and every face link that is the only way between two parts of the map
//   is opened again (Faces: union-find over all other joins, then the face
//   links gentlest first, each opened only when it joins two parts). Every
//   part connected with all steep links open stays connected, so no place
//   is lost; a face with a way round is walked round. Closing them all
//   instead cut off 84 guide goals (roads up to Ironforge and Stormwind's
//   canals among them): steep triangles are common on ground players
//   cross, a bridge between two places is not a face to avoid.
// A route down a face goes round too, a little longer; slopes under 50° are
// priced by their class (gentle, steep), so a walk goes round a hill when
// that is not much longer.

const zlib = require('node:zlib');
const { ADT } = require('./grid/format');
const Costs = require('./costs');

const { CLASS, HUB_ALLIANCE, HUB_HORDE, PROFILES } = Costs;
// Per profile (Costs.PROFILES), the multiplier of every class byte (5 bits).
const MULTS = PROFILES.map((p) => Float64Array.from({ length: 32 }, (_, c) => Costs.mult(c, p)));
const T = ADT;
const SWIM = 3.0; // gen_nav.py: a swum yard counts as three running ones
const COST_MAX = 64 ** 3 - 1; // a graph edge's cost per profile: 3 symbols (a hostile hub's x20 passes 4095)
const YARDS_MAX = 64 ** 2 - 1; // its yards: 2 symbols
const AREA_CAPITAL = 0x100; // AreaTable Flags_0: a capital city (layers/hubs.js); 0x138 on the six capitals
const ENTRANCE_YD = (20 * T) / 67; // gen_nav.py's 20-cell entrance runs at 67 cells, in yards
const ROAD_NEAR_YD = 8; // a road crossing a border gets its own entrance unless a chunk entrance is this near its run
const PRUNE = 1.02; // drop an intra edge when a two-hop path is within 2% (and both hops are shorter: never cuts a region)
const ZQ = 2; // base heights are stored to this step (yd)
const BLOCK_BYTES = 16 * 1024; // pack_nav.py: the client decompresses blocks into a 16 KB buffer
const PART_BYTES = 512 * 1024; // pack_nav.py: bytes per Lua part file
// Stored link classes that are no step in the pack: steep (50-60°) and climbed (60-80°) terrain.
const B64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
// SPF directions: +x, -x, +y, -y, +x+y, +x-y, -x+y, -x-y (x north, y west).
const SDX = [1, -1, 0, 0, 1, 1, -1, -1];
const SDY = [0, 0, 1, -1, 1, -1, 1, -1];
const OPP = [1, 0, 3, 2, 7, 6, 5, 4];
const DIR_OF = new Int8Array(9).fill(-1); // [(dx + 1) * 3 + dy + 1]
for (let d = 0; d < 8; d++) DIR_OF[(SDX[d] + 1) * 3 + SDY[d] + 1] = d;
const NAMES = { 0: 'Eastern Kingdoms', 1: 'Kalimdor', 2991: 'Zephras Isle' };

// The capitals' area ids from AreaTable rows: an area flagged AREA_CAPITAL and every area under one.
function capitalAreas(areaTable) {
	const parent = new Map();
	const capital = new Set();
	for (const r of areaTable) {
		parent.set(Number(r.ID), Number(r.ParentAreaID) || 0);
		if (Number(r.Flags_0) & AREA_CAPITAL) capital.add(Number(r.ID));
	}
	const out = new Set();
	for (const id of parent.keys()) {
		for (let cur = id, n = 0; cur && n < 8; cur = parent.get(cur) || 0, n++) {
			if (capital.has(cur)) {
				out.add(id);
				break;
			}
		}
	}
	return out;
}

// The zone of each AreaTable area (rows: ID, ParentAreaID) by zones.json (its zones, type 3, with an areaId): the
// uiMapID of the first area up its ParentAreaID chain that is a zone's area, else 0. Entries of other types
// (battlegrounds, Darkspear Islands) never count. No map frame is needed, so a Forever zone without an Era frame
// (Riverglades, Zephras Isle) resolves too. -> (c, areaId) -> uiMapID (0 for none)
function zoneAreas({ areaTable, zones }) {
	const parent = new Map();
	for (const r of areaTable) parent.set(Number(r.ID), Number(r.ParentAreaID) || 0);
	const byArea = new Map();
	for (const z of Object.values(zones)) if (z && z.type === 3 && z.areaId) byArea.set(Number(z.areaId), Number(z.id));
	const memo = new Map();
	return (c, areaId) => {
		const id = Number(areaId) || 0;
		if (!memo.has(id)) {
			let out = 0;
			for (let cur = id, n = 0; cur && n < 8; cur = parent.get(cur) || 0, n++) {
				if (byArea.has(cur)) {
					out = byArea.get(cur);
					break;
				}
			}
			memo.set(id, out);
		}
		return memo.get(id);
	};
}

function enc(v, width) {
	if (!(v >= 0 && v < 64 ** width && Number.isInteger(v))) throw new Error(`pack: ${v} does not fit ${width} base64 digits`);
	let s = '';
	for (let i = width - 1; i >= 0; i--) s += B64[Math.floor(v / 64 ** i) % 64];
	return s;
}

// A CellGrid: SPF's cell surfaces and their joins for one continent.
//   C, NX, NY, CX0, CY0, GW = NX C, GH = NY C; a base node is its global cell
//   gx * GH + gy, a floor GW * GH + its index.
//   clusters: Map k -> { val: Uint8Array(C²) (0 blocked, 1 ground, 2 water),
//     zq: Int16Array(C²) (base height / ZQ, rounded), mask: Uint8Array(C²)
//     (bit d: the base surface joins the neighbour's base in SPF direction d),
//     cls: Uint8Array(C²) (the base surface's ground class byte, nodeClass),
//     floorStart, floorEnd (its floors, contiguous, by cell then height) }
//   floorCell, floorVal, floorZ, floorLayer, floorClass: per floor (layer 1 = lowest)
//   links: (a, b) node pairs, either a floor, both ways (Int32Array pairs, sorted, unique)
// Every CellGrid carries classes (format 2); a map whose clusters lack `cls`
// (a hand-made one, tests) is written without them (format 1) and no graph.
class CellGrid {
	constructor({ C, NX, NY, CX0, CY0 }) {
		Object.assign(this, { C, NX, NY, CX0, CY0, GW: NX * C, GH: NY * C });
		this.clusters = new Map();
		this.floorCell = [];
		this.floorVal = [];
		this.floorZ = [];
		this.floorLayer = [];
		this.floorClass = [];
		this.floorAt = new Map(); // base cell -> its first floor
		this.pairs = []; // a, b, ... (unsorted; finish() sorts into links)
	}

	cluster(k) {
		let cl = this.clusters.get(k);
		if (!cl) {
			const C2 = this.C * this.C;
			cl = { val: new Uint8Array(C2), zq: new Int16Array(C2), mask: new Uint8Array(C2), flags: new Uint8Array(C2), cls: new Uint8Array(C2), floorStart: 0, floorEnd: 0 };
			this.clusters.set(k, cl);
		}
		return cl;
	}

	addFloor(cell, val, z, cls = 0) {
		const f = this.floorCell.length;
		if (!this.floorAt.has(cell)) this.floorAt.set(cell, f);
		this.floorLayer.push(f - this.floorAt.get(cell) + 1);
		this.floorCell.push(cell);
		this.floorVal.push(val);
		this.floorZ.push(z);
		this.floorClass.push(cls);
		return this.GW * this.GH + f;
	}

	// The ground class byte of node n (nodeClass); 0 without classes.
	nodeClass(n) {
		const NB = this.GW * this.GH;
		if (n >= NB) return this.floorClass[n - NB] || 0;
		if (!this.at(Math.floor(n / this.GH), n % this.GH)) return 0;
		return this.hit.cls ? this.hit.cls[this.hitL] : 0;
	}

	// ORs hub bits into every surface of global cell (gx, gy).
	addHub(gx, gy, bits) {
		if (!this.at(gx, gy)) return;
		if (this.hit.val[this.hitL]) this.hit.cls[this.hitL] |= bits;
		const c = gx * this.GH + gy;
		const f0 = this.floorAt.get(c);
		if (f0 !== undefined) for (let f = f0; f < this.floorCell.length && this.floorCell[f] === c; f++) this.floorClass[f] |= bits;
	}

	cellOf(n) {
		const NB = this.GW * this.GH;
		return n < NB ? n : this.floorCell[n - NB];
	}

	clusterOfCell(c) {
		const gx = Math.floor(c / this.GH);
		const gy = c % this.GH;
		return Math.floor(gx / this.C) * this.NY + Math.floor(gy / this.C);
	}

	// Value of global cell (gx, gy); 0 outside.
	value(gx, gy) {
		const { C, GW, GH } = this;
		if (gx < 0 || gy < 0 || gx >= GW || gy >= GH) return 0;
		const cl = this.clusters.get(Math.floor(gx / C) * this.NY + Math.floor(gy / C));
		return cl ? cl.val[(gx % C) * C + (gy % C)] : 0;
	}

	nodeValue(n) {
		const NB = this.GW * this.GH;
		if (n >= NB) return this.floorVal[n - NB];
		return this.value(Math.floor(n / this.GH), n % this.GH);
	}

	// The cluster and local cell of global cell (gx, gy) into this.hit / this.hitL; false outside the data.
	at(gx, gy) {
		const C = this.C;
		if (gx < 0 || gy < 0 || gx >= this.GW || gy >= this.GH) return false;
		const cl = this.clusters.get(Math.floor(gx / C) * this.NY + Math.floor(gy / C));
		if (!cl) return false;
		this.hit = cl;
		this.hitL = (gx % C) * C + (gy % C);
		return true;
	}

	// Two nodes of neighbouring cells are joined (either way round).
	join(a, b) {
		const ca = this.cellOf(a);
		const cb = this.cellOf(b);
		const GH = this.GH;
		const dx = Math.floor(cb / GH) - Math.floor(ca / GH);
		const dy = (cb % GH) - (ca % GH);
		if (dx < -1 || dx > 1 || dy < -1 || dy > 1 || (!dx && !dy)) return;
		const NB = this.GW * GH;
		if (a < NB && b < NB) {
			const d = DIR_OF[(dx + 1) * 3 + dy + 1];
			this.at(Math.floor(ca / GH), ca % GH);
			this.hit.mask[this.hitL] |= 1 << d;
			this.at(Math.floor(cb / GH), cb % GH);
			this.hit.mask[this.hitL] |= 1 << OPP[d];
			return;
		}
		this.pairs.push(a, b, b, a);
	}

	// Sorted unique links (CSR by node), the grid's flags, and per cluster its linked nodes.
	finish() {
		const n = this.pairs.length / 2;
		const idx = new Uint32Array(n);
		for (let i = 0; i < n; i++) idx[i] = i;
		const p = this.pairs;
		idx.sort((x, y) => p[2 * x] - p[2 * y] || p[2 * x + 1] - p[2 * y + 1]);
		const from = [];
		const to = [];
		for (const i of idx) {
			const a = p[2 * i];
			const b = p[2 * i + 1];
			if (from.length && from[from.length - 1] === a && to[to.length - 1] === b) continue;
			from.push(a);
			to.push(b);
		}
		this.pairs = null;
		this.links = new Map(); // node -> sorted targets
		for (let i = 0; i < from.length; i++) {
			if (!this.links.has(from[i])) this.links.set(from[i], []);
			this.links.get(from[i]).push(to[i]);
		}
		this.linkedOf = new Map(); // cluster -> sorted nodes with links
		for (const a of [...this.links.keys()].sort((x, y) => x - y)) {
			const k = this.clusterOfCell(this.cellOf(a));
			if (!this.linkedOf.has(k)) this.linkedOf.set(k, []);
			this.linkedOf.get(k).push(a);
		}
		this.cutFlags();
	}

	// gen_nav.py step_ok: the orthogonal step from (ux, uy) into (vx, vy).
	stepOk(ux, uy, vx, vy) {
		if (!this.value(vx, vy)) return false;
		if (vx !== ux) return this.at(Math.min(ux, vx), uy) && !(this.hit.flags[this.hitL] & 1);
		return this.at(ux, Math.min(uy, vy)) && !(this.hit.flags[this.hitL] & 2);
	}

	// gen_nav.py diag_ok: either L-shaped detour open, or the explicit diagonal flag.
	diagOk(ux, uy, vx, vy) {
		if (!this.value(vx, vy)) return false;
		if ((this.stepOk(ux, uy, vx, uy) && this.stepOk(vx, uy, vx, vy)) || (this.stepOk(ux, uy, ux, vy) && this.stepOk(ux, vy, vx, vy))) return true;
		const [ax, ay, by] = vx > ux ? [ux, uy, vy] : [vx, vy, uy];
		return this.at(ax, ay) && !!(this.hit.flags[this.hitL] & (by > ay ? 4 : 8));
	}

	cutFlags() {
		const { C, NY } = this;
		const ks = [...this.clusters.keys()].sort((a, b) => a - b);
		for (const pass of [0, 1]) {
			for (const k of ks) {
				const cl = this.clusters.get(k);
				const gx0 = Math.floor(k / NY) * C;
				const gy0 = (k % NY) * C;
				for (let l = 0; l < C * C; l++) {
					if (!cl.val[l]) continue;
					const gx = gx0 + Math.floor(l / C);
					const gy = gy0 + (l % C);
					const m = cl.mask[l];
					if (pass === 0) {
						if (this.value(gx + 1, gy) && !(m & 1)) cl.flags[l] |= 1;
						if (this.value(gx, gy + 1) && !(m & 4)) cl.flags[l] |= 2;
					} else {
						// Diagonals once every orthogonal flag is known.
						if (m & 16 && this.value(gx + 1, gy + 1) && !this.diagOk(gx, gy, gx + 1, gy + 1)) cl.flags[l] |= 4;
						if (m & 32 && this.value(gx + 1, gy - 1) && !this.diagOk(gx, gy, gx + 1, gy - 1)) cl.flags[l] |= 8;
					}
				}
			}
		}
	}
}

// Per cluster: the local moves of every node (gen_nav.py moves(): the base
// grid's steps by the flags, then the floor links), inside the cluster.
function clusterMoves(cg, k) {
	const { C, NY, GH } = cg;
	const NB = cg.GW * GH;
	const cl = cg.clusters.get(k);
	const gx0 = Math.floor(k / NY) * C;
	const gy0 = (k % NY) * C;
	const nf = cl.floorEnd - cl.floorStart;
	const N = C * C + nf;
	const local = (n) => {
		if (n >= NB) {
			const f = n - NB;
			return f >= cl.floorStart && f < cl.floorEnd ? C * C + f - cl.floorStart : -1;
		}
		const gx = Math.floor(n / GH) - gx0;
		const gy = (n % GH) - gy0;
		return gx >= 0 && gy >= 0 && gx < C && gy < C ? gx * C + gy : -1;
	};
	const global = (l) => (l < C * C ? (gx0 + Math.floor(l / C)) * GH + gy0 + (l % C) : NB + cl.floorStart + l - C * C);
	const value = new Uint8Array(N);
	value.set(cl.val);
	for (let f = 0; f < nf; f++) value[C * C + f] = cg.floorVal[cl.floorStart + f];
	const cls = new Uint8Array(N); // ground class bytes (0 on a map without classes)
	if (cl.cls) cls.set(cl.cls);
	for (let f = 0; f < nf; f++) cls[C * C + f] = cg.floorClass[cl.floorStart + f] || 0;
	// gen_nav.py step_ok / diag_ok inside the cluster (PathGrid.lua decodeGrid's moves).
	const { val, flags } = cl;
	const step = (x, y, dx, dy) => {
		const l = x * C + y;
		if (dx) return !!val[l + dx * C] && !(flags[dx > 0 ? l : l - C] & 1);
		return !!val[l + dy] && !(flags[dy > 0 ? l : l - 1] & 2);
	};
	const diag = (x, y, dx, dy) => {
		const v = (x + dx) * C + y + dy;
		if (!val[v]) return false;
		if ((step(x, y, dx, 0) && step(x + dx, y, 0, dy)) || (step(x, y, 0, dy) && step(x, y + dy, dx, 0))) return true;
		return !!(flags[dx > 0 ? x * C + y : v] & (dx * dy > 0 ? 4 : 8));
	};
	// CSR of moves: target local node, length in cells.
	const off = new Uint32Array(N + 1);
	const to = [];
	const len = [];
	for (let l = 0; l < N; l++) {
		if (value[l]) {
			if (l < C * C) {
				const lx = Math.floor(l / C);
				const ly = l % C;
				for (let d = 0; d < 8; d++) {
					const vx = lx + SDX[d];
					const vy = ly + SDY[d];
					if (vx < 0 || vy < 0 || vx >= C || vy >= C) continue;
					if (d < 4 ? step(lx, ly, SDX[d], SDY[d]) : diag(lx, ly, SDX[d], SDY[d])) {
						to.push(vx * C + vy);
						len.push(d < 4 ? 1 : Math.SQRT2);
					}
				}
			}
			const u = global(l);
			const cu = cg.cellOf(u);
			for (const v of cg.links.get(u) || []) {
				const lv = local(v);
				if (lv < 0) continue;
				const cv = cg.cellOf(v);
				to.push(lv);
				len.push(Math.floor(cv / GH) !== Math.floor(cu / GH) && cv % GH !== cu % GH ? Math.SQRT2 : 1);
			}
		}
		off[l + 1] = to.length;
	}
	return { N, value, cls, off, to: Int32Array.from(to), len: Float64Array.from(len), local, global };
}

// gen_nav.py grid_hpa: regions per cluster, entrances per border group (the crossings between one region on
// each side) every `run` crossings (ENTRANCE_YD in cells; a cell crosses straight and both ways diagonally, so on
// open ground that is an entrance about every ENTRANCE_YD / 3), plus one on each road crossing the border away
// from those and one on each dry run of crossings none of them crosses dry (Polestar's, 2026-10-16 and -17),
// intra-cluster edges by Dijkstra per profile, pruned.
// An edge is { a, b, ab, ba, yab, yba }: ab the costs from a to b (Costs.PROFILES order: Alliance, Horde, none),
// each priced as the router prices a grid step (its length times Costs.mult of the node it enters, times SWIM in
// water), ba the way back, yab and yba the yards walked along the cost-best way with no profile.
function buildHpa(cg, log = () => {}) {
	const { C, NX, NY, GH } = cg;
	const CS = T / C;
	const run = Math.max(1, Math.round(ENTRANCE_YD / CS));
	const near = Math.max(1, Math.round(ROAD_NEAR_YD / CS));
	const isRoad = (n) => (cg.nodeClass(n) & 7) === CLASS.ROAD;
	const isDry = (c) => cg.nodeValue(c[2]) === 1 && cg.nodeValue(c[3]) === 1; // a crossing with ground on both sides
	const ks = [...cg.clusters.keys()].sort((a, b) => a - b);
	const moves = new Map();
	const region = new Map(); // k -> Int32Array local -> region (local root)
	for (const k of ks) {
		const mv = clusterMoves(cg, k);
		moves.set(k, mv);
		const reg = new Int32Array(mv.N).fill(-1);
		const stack = [];
		// gen_nav.py visits cells, then floors, in order.
		for (let s = 0; s < mv.N; s++) {
			if (!mv.value[s] || reg[s] >= 0) continue;
			reg[s] = s;
			stack.push(s);
			while (stack.length) {
				const u = stack.pop();
				for (let q = mv.off[u]; q < mv.off[u + 1]; q++) {
					const v = mv.to[q];
					if (reg[v] < 0) {
						reg[v] = s;
						stack.push(v);
					}
				}
			}
		}
		region.set(k, reg);
	}
	const regionOf = (n) => {
		const k = cg.clusterOfCell(cg.cellOf(n));
		const mv = moves.get(k);
		return mv ? region.get(k)[mv.local(n)] : -1;
	};
	const edges = new Map(); // 'a,b' -> [a, b, costs]
	const nodes = new Map(); // k -> Set
	const addNode = (n) => {
		const k = cg.clusterOfCell(cg.cellOf(n));
		if (!nodes.has(k)) nodes.set(k, new Set());
		nodes.get(k).add(n);
	};
	for (const k of ks) {
		const kx = Math.floor(k / NY);
		const ky = k % NY;
		for (const axis of [0, 1]) {
			if ((axis === 0 && kx + 1 >= NX) || (axis === 1 && ky + 1 >= NY)) continue;
			const other = k + (axis === 0 ? NY : 1);
			if (!cg.clusters.has(other)) continue;
			const groups = new Map();
			const push = (key, item) => {
				if (!groups.has(key)) groups.set(key, []);
				groups.get(key).push(item);
			};
			for (let t = 0; t < C; t++) {
				const [ux, uy, vx, vy] = axis === 0 ? [kx * C + C - 1, ky * C + t, (kx + 1) * C, ky * C + t] : [kx * C + t, ky * C + C - 1, kx * C + t, (ky + 1) * C];
				if (!cg.value(ux, uy)) continue;
				const u = ux * GH + uy;
				for (const s of [0, -1, 1]) {
					if (t + s < 0 || t + s >= C) continue;
					const [wx, wy] = axis === 0 ? [vx, vy + s] : [vx + s, vy];
					const ok = s === 0 ? cg.stepOk(ux, uy, wx, wy) : cg.diagOk(ux, uy, wx, wy);
					if (ok) {
						const w = wx * GH + wy;
						push(`${regionOf(u)},${regionOf(w)}`, [t, Math.abs(s), u, w]);
					}
				}
			}
			for (const u of cg.linkedOf.get(k) || []) {
				const cu = cg.cellOf(u);
				const ux = Math.floor(cu / GH);
				const uy = cu % GH;
				for (const w of cg.links.get(u)) {
					const cw = cg.cellOf(w);
					if (cg.clusterOfCell(cw) !== other) continue;
					const wx = Math.floor(cw / GH);
					const wy = cw % GH;
					const t = axis === 0 ? uy - ky * C : ux - kx * C;
					push(`${regionOf(u)},${regionOf(w)}`, [t, Number(wx !== ux && wy !== uy), u, w]);
				}
			}
			// A group's entrances: one per chunk of `run` crossings, at its middle (a straight crossing first), then one
			// per run of road crossings (both cells road, along the border without a gap) that no chunk entrance lies
			// within `near` cells of: a road crossing the border far from the chunk's middle otherwise sends every walk
			// along it out along the border to that entrance (Fitz at Ratchet, 2026-10-16). Then one per run of dry
			// crossings (both cells ground, no swim surface) that no entrance so far crosses dry: a group holds land and
			// the water it wades into, so a chunk's middle can fall in the water beside a beach or a pier's root, and
			// every walk across that border swam to it (Fitz at Auberdine's pier, 2026-10-17, Ruling 37).
			const pick = (list) => {
				const mid = list[list.length >> 1][0];
				let best = list[0];
				for (const c of list) if (c[1] < best[1] || (c[1] === best[1] && Math.abs(c[0] - mid) < Math.abs(best[0] - mid))) best = c;
				return best;
			};
			const place = ([, diagonal, u, v]) => {
				const len = CS * (diagonal ? Math.SQRT2 : 1);
				const into = (w) => MULTS.map((mt) => len * mt[cg.nodeClass(w)] * (cg.nodeValue(w) === 2 ? SWIM : 1));
				edges.set(`${u},${v}`, { a: u, b: v, ab: into(v), ba: into(u), yab: len, yba: len });
				addNode(u);
				addNode(v);
			};
			for (const crossings of groups.values()) {
				crossings.sort((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2] || a[3] - b[3]);
				const placed = [];
				for (let i = 0; i < crossings.length; i += run) {
					const best = pick(crossings.slice(i, i + run));
					placed.push(best);
					place(best);
				}
				const roads = crossings.filter((c) => isRoad(c[2]) && isRoad(c[3]));
				const onRoads = [];
				for (let i = 0; i < roads.length; ) {
					let j = i + 1;
					while (j < roads.length && roads[j][0] - roads[j - 1][0] <= 1) j++;
					const t0 = roads[i][0] - near;
					const t1 = roads[j - 1][0] + near;
					if (!placed.some((c) => c[0] >= t0 && c[0] <= t1)) {
						const best = pick(roads.slice(i, j));
						onRoads.push(best);
						place(best);
					}
					i = j;
				}
				placed.push(...onRoads);
				const drys = crossings.filter(isDry);
				for (let i = 0; i < drys.length; ) {
					let j = i + 1;
					while (j < drys.length && drys[j][0] - drys[j - 1][0] <= 1) j++;
					const t0 = drys[i][0];
					const t1 = drys[j - 1][0];
					if (!placed.some((c) => isDry(c) && c[0] >= t0 && c[0] <= t1)) place(pick(drys.slice(i, j)));
					i = j;
				}
			}
		}
	}
	const inter = edges.size;
	// Intra-cluster edges: per entrance a Dijkstra per profile, the hostile profiles only where the cluster holds a
	// hub hostile to them (elsewhere they price as no profile).
	const heap = new Heap();
	const NONE = PROFILES.length - 1;
	for (const k of [...nodes.keys()].sort((a, b) => a - b)) {
		const mv = moves.get(k);
		const el = [...nodes.get(k)].sort((a, b) => a - b);
		const n = el.length;
		const target = new Int32Array(mv.N).fill(-1);
		el.forEach((g, i) => (target[mv.local(g)] = i));
		let hubBits = 0;
		for (let l = 0; l < mv.N; l++) hubBits |= mv.cls[l];
		const priced = PROFILES.map((p, i) => i === NONE || !!(hubBits & (p === 'Alliance' ? HUB_HORDE : HUB_ALLIANCE)));
		const dists = PROFILES.map(() => null);
		const yards = new Float64Array(n * n).fill(Infinity);
		const gd = new Float64Array(mv.N);
		const gy = new Float64Array(mv.N);
		for (let p = NONE; p >= 0; p--) {
			if (!priced[p]) {
				dists[p] = dists[NONE];
				continue;
			}
			const D = (dists[p] = new Float64Array(n * n).fill(Infinity));
			const mt = MULTS[p];
			for (let s = 0; s < n; s++) {
				gd.fill(Infinity);
				const src = mv.local(el[s]);
				gd[src] = 0;
				gy[src] = 0;
				heap.clear();
				heap.push(0, src);
				let left = n - 1;
				while (heap.size && left) {
					const u = heap.pop();
					const du = heap.top;
					if (du > gd[u]) continue;
					const tu = target[u];
					if (u !== src && tu >= 0 && D[s * n + tu] === Infinity) {
						D[s * n + tu] = du;
						if (p === NONE) yards[s * n + tu] = gy[u];
						left--;
					}
					for (let q = mv.off[u]; q < mv.off[u + 1]; q++) {
						const v = mv.to[q];
						const step = mv.len[q] * CS;
						const c = du + step * mt[mv.cls[v]] * (mv.value[v] === 2 ? SWIM : 1);
						if (c < gd[v]) {
							gd[v] = c;
							gy[v] = gy[u] + step;
							heap.push(c, v);
						}
					}
				}
			}
		}
		const tables = [...new Set(dists)];
		// The way from a to b goes when no table keeps it: in each, a detour via some x within PRUNE whose legs are
		// both shorter than the edge (a detour never prunes the edges it rests on: two entrances a few yards apart at
		// the far end of a long walk would otherwise prune each other's edge to it).
		const pruned = (a, b) => tables.every((D) => {
			const d = D[a * n + b];
			for (let x = 0; x < n; x++) if (x !== a && x !== b && D[a * n + x] < d && D[x * n + b] < d && D[a * n + x] + D[x * n + b] <= d * PRUNE) return true;
			return false;
		});
		for (let a = 0; a < n; a++) {
			for (let b = a + 1; b < n; b++) {
				if (dists[NONE][a * n + b] === Infinity || dists[NONE][b * n + a] === Infinity) continue;
				if (pruned(a, b) && pruned(b, a)) continue;
				edges.set(`${el[a]},${el[b]}`, {
					a: el[a], b: el[b],
					ab: dists.map((D) => D[a * n + b]), ba: dists.map((D) => D[b * n + a]),
					yab: yards[a * n + b], yba: yards[b * n + a],
				});
			}
		}
	}
	log(`grid HPA: nodes ${[...nodes.values()].reduce((s, x) => s + x.size, 0)}, edges ${edges.size} (inter ${inter})`);
	return { nodes, edges };
}

class Heap {
	constructor() {
		this.k = [];
		this.v = [];
		this.size = 0;
	}

	clear() {
		this.size = 0;
	}

	push(key, val) {
		const { k, v } = this;
		let i = this.size++;
		while (i > 0) {
			const p = (i - 1) >> 1;
			if (k[p] <= key) break;
			k[i] = k[p];
			v[i] = v[p];
			i = p;
		}
		k[i] = key;
		v[i] = val;
	}

	pop() {
		const { k, v } = this;
		const out = v[0];
		this.top = k[0];
		const n = --this.size;
		if (n > 0) {
			const key = k[n];
			const val = v[n];
			let i = 0;
			for (;;) {
				let c = 2 * i + 1;
				if (c >= n) break;
				if (c + 1 < n && k[c + 1] < k[c]) c++;
				if (k[c] >= key) break;
				k[i] = k[c];
				v[i] = v[c];
				i = c;
			}
			k[i] = key;
			v[i] = val;
		}
		return out;
	}
}

// Run-length symbols of a cell list (gen_nav.py encode_map's grid part).
function runLength(vals) {
	let out = '';
	for (let i = 0; i < vals.length; ) {
		let j = i + 1;
		while (j < vals.length && vals[j] === vals[i]) j++;
		out += B64[vals[i]];
		for (let r = j - i - 1; r > 0; r -= 16) out += B64[48 + Math.min(r, 16) - 1];
		i = j;
	}
	return out;
}

// The zone field of a cluster (HEADER): its 256 chunk uiMapIDs, each a 2-symbol number (under 48 * 64, so its first
// symbol is under 48), a symbol >= 48 repeating the previous one (symbol - 47) more times.
function encodeZones(vals) {
	let out = '';
	for (let i = 0; i < vals.length; ) {
		let j = i + 1;
		while (j < vals.length && vals[j] === vals[i]) j++;
		if (!(vals[i] < 48 * 64)) throw new Error(`pack: zone ${vals[i]} does not fit the zone field`);
		out += enc(vals[i], 2);
		for (let r = j - i - 1; r > 0; r -= 16) out += B64[48 + Math.min(r, 16) - 1];
		i = j;
	}
	return out;
}

// gen_nav.py encode_heights.
function encodeHeights(cl, C) {
	const q = new Int32Array(C * C);
	const has = new Uint8Array(C * C);
	const items = [];
	let last = 0;
	for (let i = 0; i < C; i++) {
		for (let j = 0; j < C; j++) {
			const l = i * C + j;
			if (!cl.val[l]) continue;
			const v = cl.zq[l];
			const pred = j > 0 && has[l - 1] ? q[l - 1] : i > 0 && has[l - C] ? q[l - C] : last;
			items.push(Math.abs(v - pred) <= 23 ? ['d', v - pred] : ['a', v]);
			q[l] = last = v;
			has[l] = 1;
		}
	}
	let out = '';
	for (let i = 0; i < items.length; ) {
		const [kind, v] = items[i];
		if (kind === 'a') {
			out += B64[47] + enc(v + 2048, 2);
			i++;
			continue;
		}
		out += B64[v + 23];
		let j = i + 1;
		while (j < items.length && items[j][0] === 'd' && items[j][1] === v) j++;
		for (let r = j - i - 1; r > 0; r -= 16) out += B64[48 + Math.min(r, 16) - 1];
		i = j;
	}
	return out;
}

// gen_nav.py encode_map + encode_floors: CellGrid + HPA -> strings per cluster (0-based k). A CellGrid with
// ground classes (cluster.cls) gives maps format 2: the class field and the graph's per-profile edge records
// (Routing/PathGrid.lua adjacent); one without (a hand-made map) format 1 with no graph.
function encodeMaps(cg, hpa) {
	const { C, NY, GH } = cg;
	const NB = cg.GW * GH;
	const { nodes, edges } = hpa;
	const classed = [...cg.clusters.values()].every((cl) => cl.cls);
	if (!classed && edges.size) throw new Error('pack: a graph needs ground classes (maps format 2)');
	const all = [...nodes.values()].flatMap((s) => [...s]).sort((a, b) => a - b);
	const parent = new Map(all.map((c) => [c, c]));
	const find = (x) => {
		while (parent.get(x) !== x) {
			parent.set(x, parent.get(parent.get(x)));
			x = parent.get(x);
		}
		return x;
	};
	for (const { a, b } of [...edges.values()].sort((p, q) => p.a - q.a || p.b - q.b)) parent.set(find(a), find(b));
	// Component ids (2 digits, < 4096) by size, largest first; past 4094 the
	// smallest share 4095 (decided 2026-10-15: Kalimdor has 4,346 at 67 cells,
	// most of them islets of a few entrances; a shared id only costs the
	// runtime a failed abstract search instead of its quick "not connected").
	const size = new Map();
	for (const c of all) size.set(find(c), (size.get(find(c)) || 0) + 1);
	const ranked = [...size].sort((p, q) => q[1] - p[1] || p[0] - q[0]);
	const roots = new Map(ranked.map(([r], i) => [r, Math.min(i, 4095)]));
	const comp = new Map();
	for (const c of all) comp.set(c, roots.get(find(c)));
	const order = new Map();
	const local = new Map();
	for (const [k, set] of nodes) {
		const cs = [...set].sort((a, b) => a - b);
		order.set(k, cs);
		cs.forEach((c, i) => local.set(c, i));
	}
	const nbrs = new Map();
	for (const e of edges.values()) {
		if (!nbrs.has(e.a)) nbrs.set(e.a, []);
		if (!nbrs.has(e.b)) nbrs.set(e.b, []);
		nbrs.get(e.a).push([e.b, e.ab, e.yab]);
		nbrs.get(e.b).push([e.a, e.ba, e.yba]);
	}
	const lcell = (c) => {
		if (c >= NB) {
			const f = c - NB;
			const cl = cg.clusters.get(cg.clusterOfCell(cg.floorCell[f]));
			return C * C + f - cl.floorStart;
		}
		const gx = Math.floor(c / GH);
		const gy = c % GH;
		return (gx % C) * C + (gy % C);
	};
	const layerOf = (n) => (n >= NB ? cg.floorLayer[n - NB] : 0);
	const storedZ = (n) => {
		if (n >= NB) return Math.round(cg.floorZ[n - NB]);
		cg.at(Math.floor(n / GH), n % GH);
		return cg.hit.zq[cg.hitL] * ZQ;
	};
	const direction = (u, v) => {
		const cu = cg.cellOf(u);
		const cv = cg.cellOf(v);
		return DIR_OF[(Math.floor(cv / GH) - Math.floor(cu / GH) + 1) * 3 + ((cv % GH) - (cu % GH)) + 1];
	};
	// The surface in direction d from u nearest u's height (the base first on a tie).
	const matched = (u, d) => {
		const cu = cg.cellOf(u);
		const tx = Math.floor(cu / GH) + SDX[d];
		const ty = (cu % GH) + SDY[d];
		if (tx < 0 || ty < 0 || tx >= cg.GW || ty >= GH) return null;
		const c = tx * GH + ty;
		const cands = cg.value(tx, ty) ? [c] : [];
		const f0 = cg.floorAt.get(c);
		if (f0 !== undefined) for (let f = f0; f < cg.floorCell.length && cg.floorCell[f] === c; f++) cands.push(NB + f);
		let best = null;
		let gap = Infinity;
		const zu = storedZ(u);
		for (const v of cands) {
			const g = Math.abs(storedZ(v) - zu);
			if (g < gap) {
				best = v;
				gap = g;
			}
		}
		return best;
	};
	const graph = new Map();
	const grids = new Map();
	const heights = new Map();
	const floors = new Map();
	const classes = new Map();
	let clamped = 0;
	let maxDegree = 0;
	const NONE = PROFILES.length - 1;
	for (const k of [...cg.clusters.keys()].sort((a, b) => a - b)) {
		const kx = Math.floor(k / NY);
		const ky = k % NY;
		const cl = cg.clusters.get(k);
		const cs = order.get(k) || [];
		if (cs.length) {
			if (cs.length >= 4096) throw new Error(`pack: cluster ${k} has ${cs.length} entrances (at most 4095)`);
			let rec = enc(cs.length, 2);
			let erec = '';
			for (const c of cs) {
				const list = (nbrs.get(c) || []).sort((p, q) => p[0] - q[0] || p[1][NONE] - q[1][NONE] || p[2] - q[2]);
				maxDegree = Math.max(maxDegree, list.length);
				if (list.length >= 64) throw new Error(`pack: entrance ${c} has ${list.length} edges (at most 63)`);
				// The entrance's local cell (a floor's own cell, gen_nav.py lcell(cell_of(c))) and its layer.
				rec += enc(lcell(cg.cellOf(c)), 3) + enc(layerOf(c), 1) + enc(comp.get(c), 2) + enc(list.length, 1);
				// Its edges (adjacent's format 2 record): cluster offset(1), node(2), costAlliance(3), costHorde(3),
				// costNone(3), yards(2).
				for (const [m, costs, yd] of list) {
					const km = cg.clusterOfCell(cg.cellOf(m));
					const dx = Math.floor(km / NY) - kx;
					const dy = (km % NY) - ky;
					erec += enc((dx + 1) * 3 + dy + 1, 1) + enc(local.get(m), 2);
					for (const w of costs) {
						const r = Math.round(w);
						if (r > COST_MAX) clamped++;
						erec += enc(Math.min(r, COST_MAX), 3);
					}
					const y = Math.round(yd);
					if (y > YARDS_MAX) clamped++;
					erec += enc(Math.min(y, YARDS_MAX), 2);
				}
			}
			graph.set(k, rec + erec);
		}
		const vals = new Array(C * C);
		let any = false;
		for (let l = 0; l < C * C; l++) {
			vals[l] = cl.val[l] * 16 + cl.flags[l];
			if (vals[l]) any = true;
		}
		if (any) {
			grids.set(k, runLength(vals));
			heights.set(k, encodeHeights(cl, C));
		}
		if (classed) {
			const nf = cl.floorEnd - cl.floorStart;
			const cv = new Array(C * C + nf);
			let nonzero = false;
			for (let l = 0; l < C * C; l++) nonzero = (cv[l] = cl.cls[l]) !== 0 || nonzero;
			for (let f = 0; f < nf; f++) nonzero = (cv[C * C + f] = cg.floorClass[cl.floorStart + f]) !== 0 || nonzero;
			if (nonzero) classes.set(k, runLength(cv));
		}
		const linked = cg.linkedOf.get(k) || [];
		if (cl.floorEnd > cl.floorStart || linked.length) {
			const cells = [];
			for (let f = cl.floorStart; f < cl.floorEnd; f++) {
				const c = cg.floorCell[f];
				if (!cells.length || cells[cells.length - 1][0] !== c) cells.push([c, []]);
				cells[cells.length - 1][1].push(NB + f);
			}
			let out = enc(cells.length, 3);
			const extra = [];
			for (const [c, ns] of cells) {
				out += enc(lcell(c), 3) + enc(ns.length, 1);
				for (const n of ns) {
					let steps = 0;
					for (const v of cg.links.get(n) || []) {
						const d = direction(n, v);
						if (matched(n, d) === v) steps |= 1 << d;
						else extra.push([lcell(n), d, layerOf(v)]);
					}
					out += enc(cg.floorVal[n - NB], 1) + enc(storedZ(n) + 2048, 2) + enc(steps, 2);
				}
			}
			for (const u of linked) {
				if (u >= NB) continue;
				for (const v of cg.links.get(u)) if (cg.clusterOfCell(cg.cellOf(v)) !== k) extra.push([lcell(u), direction(u, v), layerOf(v)]);
			}
			extra.sort((p, q) => p[0] - q[0] || p[1] - q[1] || p[2] - q[2]);
			out += enc(extra.length, 3);
			for (const [n, d, la] of extra) out += enc(n, 3) + enc(d, 1) + enc(la, 1);
			floors.set(k, out);
		}
	}
	// The zone field (maps format 2 only): clusters whose chunks lie in a zone (cellGrid's cl.zone).
	const zones = new Map();
	for (const k of [...cg.clusters.keys()].sort((a, b) => a - b)) if (cg.clusters.get(k).zone) zones.set(k, encodeZones(cg.clusters.get(k).zone));
	return { graph, grid: grids, height: heights, floor: floors, class: classed ? classes : undefined, zone: classed ? zones : undefined, components: roots.size, clamped, maxDegree };
}

const HEADER = [
	'-- UnitPosition\'s frame (x north, y west). Cluster k (0-based) is the ADT tile x in [(cx0 + k // ny) T, +T),',
	'-- y in [(cy0 + k % ny) T, +T), T = 1600 / 3, cut into cells x cells cells, x-major. Base64 (A-Za-z0-9+/).',
	'-- graph[k + 1]: n(2) | n x [cell(3) layer(1) component(2) degree(1)] | edges in node order [cluster offset(1):',
	'--   (dx + 1) * 3 + dy + 1, node(2), costAlliance(3), costHorde(3), costNone(3), yards(2)]: an edge\'s cost under',
	'--   each profile (Routing/Costs.lua; water at swim) in running yards, and the yards walked along the cost-best way',
	'--   with no profile (one value for every profile: a walk round a hostile hub inside a cluster is longer than its',
	'--   yards say; Routing/PathGrid.lua adjacent). grid[k + 1]: per cell value * 16 + flags, where value 0 blocked,',
	'--   1 ground, 2 water;',
	'--   flags 1/2 close the step to the +x/+y neighbour, 4/8 open the +x+y/+x-y',
	'--   diagonal (otherwise a diagonal is open when either L-shaped detour is). A symbol >= 48 repeats the',
	'--   previous cell (symbol - 47) more times. Nodes are local cells, then floors from cells * cells on.',
	'-- height[k + 1]: base heights of the walkable cells in cell order, in zstep yards, each against its -y',
	'--   neighbour (else its -x neighbour, else the previous cell): symbols 0-46 add -23..23, 47 is followed by',
	'--   an absolute value + 2048 (2), a symbol >= 48 repeats the previous difference (symbol - 47) more times.',
	'-- floor[k + 1]: surfaces above or below the base one, numbered from cells * cells in order.',
	'--   n(3) | n x [cell(3) count(1) count x [value(1) height + 2048(2) steps(2)]] | m(3) | m x [node(3) direction(1)',
	'--   layer(1)]. A floor\'s steps bit d links it to the surface in direction d nearest its height; the m links are',
	'--   the rest: a floor\'s links to another surface, and a base cell\'s links to floors across the cluster border',
	'--   (inside the cluster they are the reverse of the floors\' own). Layer 0 is the base surface, i the cell\'s ith',
	'--   floor from the bottom; directions 0-7 are +x, -x, +y, -y, +x+y, +x-y, -x+y, -x-y.',
	'-- class[k + 1]: per node in node order its ground class byte (Routing/Costs.lua: bits 0-2 the base class,',
	'--   bit 3 inside an Alliance hub, bit 4 inside a Horde hub), run-length as the grid field; nodes past the end',
	'--   are class 0, and so is every node of a cluster without one. hubs: the hostile hubs, for the router\'s report:',
	'--   { id, side, name (English), areaId (AreaTable: the town in the client\'s language), disks = { { x, y, r } } }.',
	'-- zone[k + 1] (format 2, optional, not packed): the zone of each of the cluster\'s 16 x 16 chunks (cells / 16 cells',
	'--   square; chunk (x // (cells / 16)) * 16 + y // (cells / 16) of its local cell x, y) as its uiMapID, 0 for none:',
	'--   a 2-symbol number, a symbol >= 48 repeating the previous one (symbol - 47) more times. A cluster without one',
	'--   lies in no zone; the router prices a step into a zone by its caller\'s danger table (Routing/Path.lua).',
	'-- Packed (pack_nav.py\'s layout): data.packed.<field>[k + 1] = { base64(zlib(16 KB block)), ... } in the parts.',
];

const FIELDS = ['graph', 'grid', 'height', 'floor'];
const CLASS_FIELDS = [...FIELDS, 'class'];
const PART_NOTE = '-- Compressed terrain for on-demand decoding (Shortest Path Forever\'s pack_nav.py layout).';
const CREDIT = [
	'-- Polestar\'s walking maps (format 2: ground classes and per-faction costs) of the navigation grid, written by',
	'-- tools/lib/nav/pack.js, started from Shortest Path Forever\'s walking-map format (github.com/cjber/shortest-path-forever):',
	'-- a port of his tools/baker/gen_nav.py and tools/pack_nav.py, used with his permission.',
	'-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.',
];

// A Lua string literal.
const luaStr = (s) => `"${String(s).replace(/[\\"]/g, (ch) => `\\${ch}`).replace(/\n/g, '\\n')}"`;

// One map's strings -> its metadata file and parts (pack_nav.py write_bundle);
// `gen` is the generated-file header line. Maps format 2 (maps.class set)
// carry format = 2, the profiles, the hubs ([{ id, side, name, areaId, disks }]), the class field and, when a
// cluster lies in a zone (maps.zone), the zone field in the metadata itself.
function packFiles({ map, cg, maps, global, gen, hubs = [] }) {
	const files = [];
	const classed = maps.class !== undefined;
	const fields = classed ? CLASS_FIELDS : FIELDS;
	const hubLines = hubs
		.filter((h) => h.side === 'Alliance' || h.side === 'Horde')
		.map((h) => `\t\t{ id = ${luaStr(h.id)}, side = ${luaStr(h.side)}, name = ${luaStr(h.name)}, areaId = ${Number(h.areaId) || 0}, disks = { ${h.disks.map(([x, y, r]) => `{ ${x}, ${y}, ${r} }`).join(', ')} } },`);
	const meta = [
		gen,
		...CREDIT,
		`-- Map ${map} (${NAMES[map] || `map ${map}`}), ADT rows ${31 - cg.CX0 - cg.NX + 1}-${31 - cg.CX0} x cols ${31 - cg.CY0 - cg.NY + 1}-${31 - cg.CY0}.`,
		...HEADER,
		`${global} = ${global} or {}`,
		'',
		'---@type SPFNavData',
		'-- stylua: ignore',
		`${global}[${map}] = {`,
		...(classed ? ['\tformat = 2,', '\tprofiles = { "Alliance", "Horde" },'] : []),
		`\tcx0 = ${cg.CX0},`,
		`\tcy0 = ${cg.CY0},`,
		`\tnx = ${cg.NX},`,
		`\tny = ${cg.NY},`,
		`\tcells = ${cg.C},`,
		`\tswim = ${SWIM.toFixed(6)},`,
		`\tzstep = ${ZQ},`,
		...(classed ? (hubLines.length ? ['\thubs = {', ...hubLines, '\t},'] : ['\thubs = {},']) : []),
		'\tgraph = {},',
		'\tgrid = {},',
		'\theight = {},',
		'\tfloor = {},',
		...(classed ? ['\tclass = {},'] : []),
		...(classed && maps.zone && maps.zone.size ? ['\tzone = {', ...[...maps.zone].sort((p, q) => p[0] - q[0]).map(([k, s]) => `\t\t[${k + 1}] = "${s}",`), '\t},'] : []),
		`\tcounts = { ${fields.map((f) => `${f} = ${maps[f].size}`).join(', ')} },`,
		`\tpacked = { ${fields.map((f) => `${f} = {}`).join(', ')} },`,
		'}',
		'',
	].join('\n');
	files.push([`Nav${map}.lua`, meta]);
	const header = `${gen}\n${PART_NOTE}\n---@type SPFNavData\nlocal data = ${global}[${map}]\n-- stylua: ignore start\n`;
	let part = 1;
	let content = header;
	const keys = [...new Set(fields.flatMap((f) => [...maps[f].keys()]))].sort((a, b) => a - b);
	let packedBytes = 0;
	for (const k of keys) {
		for (const field of fields) {
			const raw = maps[field].get(k);
			if (raw === undefined) continue;
			const buf = Buffer.from(raw, 'ascii');
			const blocks = [];
			for (let o = 0; o < buf.length || (o === 0 && !blocks.length); o += BLOCK_BYTES) {
				blocks.push(zlib.deflateSync(buf.subarray(o, o + BLOCK_BYTES), { level: 9 }).toString('base64'));
				if (!buf.length) break;
			}
			const line = `data.packed.${field}[${k + 1}] = {${blocks.map((b) => `"${b}"`).join(', ')}}\n`;
			packedBytes += line.length;
			if (Buffer.byteLength(header + line) + 32 > PART_BYTES) throw new Error(`pack: map ${map} cluster ${k} exceeds the part limit`);
			if (Buffer.byteLength(content + line) + 32 > PART_BYTES) {
				files.push([`Nav${map}_${part}.lua`, `${content}-- stylua: ignore end\n`]);
				part++;
				content = header;
			}
			content += line;
		}
	}
	files.push([`Nav${map}_${part}.lua`, `${content}-- stylua: ignore end\n`]);
	return { files, packedBytes };
}

// Whether a chunk lies in a capital (cellGrid's layers.city): its area is one (capitalAreas of the AreaTable rows)
// or the zone map around it is (zoneAt(c, x, y) -> area id, optional: Ironforge's and the Undercity's chunks under
// their WMOs carry Dun Morogh's and Tirisfal's areas). -> city(c, x, y, areaId)
function cityTest({ areaTable, zoneAt = null }) {
	const capitals = capitalAreas(areaTable);
	return (c, x, y, areaId) => capitals.has(areaId) || (!!zoneAt && capitals.has(Number(zoneAt(c, x, y)) || 0));
}

module.exports = {
	SWIM, ZQ, BLOCK_BYTES, PART_BYTES, B64, SDX, SDY, OPP, COST_MAX, YARDS_MAX, AREA_CAPITAL,
	CellGrid, buildHpa, encodeMaps, packFiles, capitalAreas, zoneAreas, cityTest, encodeZones,
};
