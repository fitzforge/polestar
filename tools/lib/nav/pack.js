'use strict';
// Our navigation grid in Shortest Path Forever's walking-map format, so his
// in-game engine (Routing/PathGrid.lua, Path.lua, PathJobs.lua) runs on it
// unchanged (docs/ARCHITECTURE.md, "Navigation grid", "Packing for the
// in-game engine").
//
// Ported from Shortest Path Forever v1.15.0 by Cillian Berragan
// (github.com/cjber/shortest-path-forever, GPL-3.0-or-later, used with his
// permission): the HPA* graph, the cluster encodings and the floor links of
// tools/baker/gen_nav.py, and the zlib + base64 parts of tools/pack_nav.py.
// The format is written down in each generated NavN.lua's header (HEADER).
// Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
//
//   const { packNav, shipPack, checkPack } = require('tools/lib/nav/pack');
//   const files = await packNav({ dir, cells = 128, continents, places, date, log });
//   // files: Map 'Nav0.lua' | 'Nav0_1.lua' | ... | 'Chokepoints.lua' -> Lua source, in load order;
//   // files.manifest: PACK.json without hashes; files.timing: seconds and memory per map
//   shipPack(files, 'addon/Polestar_Nav');   // Nav/<files>, PACK.json, Nav/Nav.xml
//   checkPack('addon/Polestar_Nav');         // -> [problem, ...], [] when it matches PACK.json
//
// Three stages, each usable on its own so another surface source can feed
// the same encoder:
//   cellGrid(source, C)  our grid -> cells: per SPF cell its surfaces (the
//                        base one and floors) and which neighbouring
//                        surfaces a link joins (a CellGrid, below)
//   encodeMaps(cg)       CellGrid -> HPA* graph and the four per-cluster
//                        strings (graph, grid, height, floor)
//   packFiles(...)       strings -> NavN.lua (metadata) + NavN_i.lua parts
//                        of zlib-compressed, base64 blocks
//
// Cells (decided here). SPF's cluster is one ADT tile cut into C x C cells
// (C = `cells`), x north, y west; our tile is 256 x 256 columns (format.js),
// column (i, j) falls in cell (floor((255.5 - j) C / 256), floor((255.5 - i)
// C / 256)) by its centre. A cell's surfaces are the connected pieces of
// our walkable surfaces in its columns, joined by our links inside the
// cell (every stored link but a closed one, CLOSED below), leaving out
// regions of under MIN_REGION surfaces (rooftops, props) and anything below
// the cell's top water surface (lake beds; SPF's rule). The piece of the
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
// lifts outside the grid, in its transport data) are left out; slope costs
// have no place in the format (a step costs its length, water `swim` times
// that). Fatigue water is no surface of our grid (SWIM | BLOCKED,
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
// A route down a face goes round too, a little longer; slopes under 50°
// still cost their flat length (a height-aware step cost is his engine's to
// add).

const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const { header } = require('../generated');
const { ADT, TILE_CELLS, CELL, NO_LINK, NO_COMP, DIRS, FLAG, CLS, STEP, JUMP, WALK_MAX, STEEP_MAX, decodeTile, tileKey } = require('./grid/format');

const T = ADT;
const SWIM = 3.0; // gen_nav.py: a swum yard counts as three running ones
const WEIGHTS = [SWIM, 1.0]; // every graph edge carries one cost per weight: swimming, walking on water
const ENTRANCE_YD = (20 * T) / 67; // gen_nav.py's 20-cell entrance runs at 67 cells, in yards
const PRUNE = 1.02; // drop an intra edge when a two-hop path is within 2% (and both hops are shorter: never cuts a region)
const ZQ = 2; // base heights are stored to this step (yd)
const MIN_REGION = 1000; // walkable surfaces a region needs to be packed (path.js SNAP_REGION)
const BLOCK_BYTES = 16 * 1024; // pack_nav.py: the client decompresses blocks into a 16 KB buffer
const PART_BYTES = 512 * 1024; // pack_nav.py: bytes per Lua part file
// Stored link classes that are no step in the pack: steep (50-60°) and climbed (60-80°) terrain.
const CLOSED = (code) => code === NO_LINK || code >> 5 === CLS.CLIMB;
const TAN_WALK = Math.tan((WALK_MAX * Math.PI) / 180);
const FALL_SPAN = 2; // columns either way the ground's steepness is measured over (8.3 yd across)
const TAN_STEEP = Math.tan((STEEP_MAX * Math.PI) / 180); // a steep link across tiles: ranked as the steepest of its class
const B64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
// SPF directions: +x, -x, +y, -y, +x+y, +x-y, -x+y, -x-y (x north, y west).
const SDX = [1, -1, 0, 0, 1, 1, -1, -1];
const SDY = [0, 0, 1, -1, 1, -1, 1, -1];
const OPP = [1, 0, 3, 2, 7, 6, 5, 4];
const DIR_OF = new Int8Array(9).fill(-1); // [(dx + 1) * 3 + dy + 1]
for (let d = 0; d < 8; d++) DIR_OF[(SDX[d] + 1) * 3 + SDY[d] + 1] = d;
const NAMES = { 0: 'Eastern Kingdoms', 1: 'Kalimdor' };

function enc(v, width) {
	if (!(v >= 0 && v < 64 ** width && Number.isInteger(v))) throw new Error(`pack: ${v} does not fit ${width} base64 digits`);
	let s = '';
	for (let i = width - 1; i >= 0; i--) s += B64[Math.floor(v / 64 ** i) % 64];
	return s;
}

// The region and region size of every local component, from the graph
// file's head (format.js GRAPH), streamed so the edges are never inflated.
async function readRegions(file) {
	const head = [];
	let have = 0;
	let need = 32;
	let header = null;
	const stream = fs.createReadStream(file).pipe(zlib.createGunzip());
	for await (const chunk of stream) {
		head.push(chunk);
		have += chunk.length;
		if (!header && have >= 32) {
			const b = Buffer.concat(head);
			header = { T: b.readUInt32LE(12), N: b.readUInt32LE(16), R: b.readUInt32LE(20), K: b.readUInt32LE(28) };
			const a4 = (n) => (n + 3) & ~3;
			header.region = 32 + 20 * header.T + 4 * header.N + a4(2 * header.N) + 4 * header.N;
			need = header.region + 4 * header.R + 4 * header.K;
		}
		if (header && have >= need) break;
	}
	stream.destroy();
	const b = Buffer.concat(head);
	if (!header || b.length < need) throw new Error(`pack: ${file} is truncated`);
	const compBase = new Map();
	for (let i = 0, o = 32; i < header.T; i++, o += 20) compBase.set(tileKey(b.readUInt16LE(o), b.readUInt16LE(o + 2)), b.readUInt32LE(o + 12));
	const copy = (o, n) => {
		const out = new Uint32Array(n);
		for (let i = 0; i < n; i++) out[i] = b.readUInt32LE(o + 4 * i);
		return out;
	};
	const region = copy(header.region, header.R);
	const regionSize = copy(header.region + 4 * header.R, header.K);
	return { compBase, region, regionSize };
}

// A CellGrid: SPF's cell surfaces and their joins for one continent.
//   C, NX, NY, CX0, CY0, GW = NX C, GH = NY C; a base node is its global cell
//   gx * GH + gy, a floor GW * GH + its index.
//   clusters: Map k -> { val: Uint8Array(C²) (0 blocked, 1 ground, 2 water),
//     zq: Int16Array(C²) (base height / ZQ, rounded), mask: Uint8Array(C²)
//     (bit d: the base surface joins the neighbour's base in SPF direction d),
//     floorStart, floorEnd (its floors, contiguous, by cell then height) }
//   floorCell, floorVal, floorZ, floorLayer: per floor (layer 1 = lowest)
//   links: (a, b) node pairs, either a floor, both ways (Int32Array pairs, sorted, unique)
class CellGrid {
	constructor({ C, NX, NY, CX0, CY0 }) {
		Object.assign(this, { C, NX, NY, CX0, CY0, GW: NX * C, GH: NY * C });
		this.clusters = new Map();
		this.floorCell = [];
		this.floorVal = [];
		this.floorZ = [];
		this.floorLayer = [];
		this.floorAt = new Map(); // base cell -> its first floor
		this.pairs = []; // a, b, ... (unsorted; finish() sorts into links)
	}

	cluster(k) {
		let cl = this.clusters.get(k);
		if (!cl) {
			const C2 = this.C * this.C;
			cl = { val: new Uint8Array(C2), zq: new Int16Array(C2), mask: new Uint8Array(C2), flags: new Uint8Array(C2), floorStart: 0, floorEnd: 0 };
			this.clusters.set(k, cl);
		}
		return cl;
	}

	addFloor(cell, val, z) {
		const f = this.floorCell.length;
		if (!this.floorAt.has(cell)) this.floorAt.set(cell, f);
		this.floorLayer.push(f - this.floorAt.get(cell) + 1);
		this.floorCell.push(cell);
		this.floorVal.push(val);
		this.floorZ.push(z);
		return this.GW * this.GH + f;
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

// Our grid (format.js tiles, regions from the graph) -> CellGrid.
// The joins between cells, holding back those up a face (steep links, and
// links in a run of terrain the client slides off): union-find over the
// nodes; bridge() then opens, gentlest first, only the face links that join
// two parts nothing else joins, so every part of the map stays as connected
// as with all of them open.
class Faces {
	constructor(cg) {
		this.cg = cg;
		this.NB = cg.GW * cg.GH;
		this.base = new Int32Array(this.NB); // parent + 1, 0 a root
		this.floor = new Int32Array(1 << 16);
		this.a = [];
		this.b = [];
		this.g = [];
		this.count = 0;
	}

	up(x) {
		if (x < this.NB) return this.base[x] - 1;
		const f = x - this.NB;
		return f < this.floor.length ? this.floor[f] - 1 : -1;
	}

	set(x, p) {
		if (x < this.NB) {
			this.base[x] = p + 1;
			return;
		}
		const f = x - this.NB;
		if (f >= this.floor.length) {
			const grown = new Int32Array(Math.max(f + 1, this.floor.length * 2));
			grown.set(this.floor);
			this.floor = grown;
		}
		this.floor[f] = p + 1;
	}

	find(x) {
		let p = this.up(x);
		while (p >= 0) {
			const q = this.up(p);
			if (q >= 0) this.set(x, q);
			x = p;
			p = this.up(x);
		}
		return x;
	}

	// An open join. One between clusters that meet only at a corner joins
	// nothing for the engine (his entrances cross a cluster's sides), so it
	// does not count as a way in.
	join(a, b) {
		this.cg.join(a, b);
		const cg = this.cg;
		const ka = cg.clusterOfCell(cg.cellOf(a));
		const kb = cg.clusterOfCell(cg.cellOf(b));
		if (Math.floor(ka / cg.NY) !== Math.floor(kb / cg.NY) && ka % cg.NY !== kb % cg.NY) return;
		const ra = this.find(a);
		const rb = this.find(b);
		if (ra !== rb) this.set(Math.max(ra, rb), Math.min(ra, rb));
	}

	// A face link, its gradient (rise over run).
	add(a, b, g) {
		this.a.push(a);
		this.b.push(b);
		this.g.push(g);
		this.count++;
	}

	bridge() {
		const order = Array.from(this.g.keys()).sort((x, y) => this.g[x] - this.g[y] || this.a[x] - this.a[y] || this.b[x] - this.b[y]);
		let opened = 0;
		for (const x of order) {
			if (this.find(this.a[x]) === this.find(this.b[x])) continue;
			this.join(this.a[x], this.b[x]);
			opened++;
		}
		return opened;
	}
}

// source: { tiles: [{ col, row, tile }] or a loader, regions } — see cellGridFromDir.
function cellGrid({ tiles, loadTile, regions, C, log = () => {} }) {
	const rows = tiles.map((t) => t.row);
	const cols = tiles.map((t) => t.col);
	const maxRow = Math.max(...rows);
	const maxCol = Math.max(...cols);
	const cg = new CellGrid({ C, NX: maxRow - Math.min(...rows) + 1, NY: maxCol - Math.min(...cols) + 1, CX0: 31 - maxRow, CY0: 31 - maxCol });
	const { GH } = cg;
	// Column -> cell, and each cell's columns (k ascending).
	const LX = new Int32Array(TILE_CELLS);
	const LY = new Int32Array(TILE_CELLS);
	for (let j = 0; j < TILE_CELLS; j++) LX[j] = Math.floor(((TILE_CELLS - 1 - j + 0.5) * C) / TILE_CELLS);
	for (let i = 0; i < TILE_CELLS; i++) LY[i] = Math.floor(((TILE_CELLS - 1 - i + 0.5) * C) / TILE_CELLS);
	const colsAt = new Int32Array(C * C + 1);
	for (let k = 0; k < TILE_CELLS * TILE_CELLS; k++) colsAt[LX[k >> 8] * C + LY[k & 255] + 1]++;
	for (let l = 0; l < C * C; l++) colsAt[l + 1] += colsAt[l];
	const colList = new Int32Array(TILE_CELLS * TILE_CELLS);
	const fill = colsAt.slice(0, C * C);
	for (let k = 0; k < TILE_CELLS * TILE_CELLS; k++) colList[fill[LX[k >> 8] * C + LY[k & 255]]++] = k;
	// A column's centre against its cell's, in columns.
	const off = new Float64Array(TILE_CELLS);
	for (let q = 0; q < TILE_CELLS; q++) off[q] = q + 0.5 - ((Math.floor(((q + 0.5) * C) / TILE_CELLS) + 0.5) * TILE_CELLS) / C;
	const order = tiles.map((t, i) => ({ ...t, i })).sort((a, b) => b.row - a.row || b.col - a.col); // cluster order
	const byKey = new Map(order.map((t) => [tileKey(t.col, t.row), t]));
	const border = new Map(); // tile key -> Map (k << 5 | layer) -> node
	const cross = []; // node, neighbour tile key, (k2 << 5) | layer, 1 when a steep link
	const faces = new Faces(cg);
	let packed = 0;
	let dropped = 0;
	for (const meta of order) {
		const t = meta.tile || loadTile(meta.col, meta.row);
		if (!t.links) throw new Error(`pack: tile ${meta.col}_${meta.row} is not linked`);
		const kx = maxRow - meta.row;
		const ky = maxCol - meta.col;
		const k = kx * cg.NY + ky;
		const cl = cg.cluster(k);
		cl.floorStart = cg.floorCell.length;
		const { n, first, z, flags, links, comp } = t;
		const terr = (e) => (flags[e] & (FLAG.TERRAIN | FLAG.WMO | FLAG.M2)) === FLAG.TERRAIN;
		// A terrain link touching terrain the client slides off, inside a run of such columns (along the link's
		// direction, following links) that rises more than JUMP: a face link (Faces).
		const steepRun = (e, i, j, d, e2) => {
			if (!terr(e) || !terr(e2) || !(slide(e) || slide(e2))) return false;
			let lo = Infinity;
			let hi = -Infinity;
			const walk = (x, ci, cj, dir) => {
				for (let n = 0; n < 64 && slide(x); n++) {
					if (z[x] < lo) lo = z[x];
					if (z[x] > hi) hi = z[x];
					const c = links[x * 8 + dir];
					const ni = ci + DIRS[dir][0];
					const nj = cj + DIRS[dir][1];
					if (c === NO_LINK || ni < 0 || nj < 0 || ni > 255 || nj > 255) return;
					x = first[nj * TILE_CELLS + ni] + (c & 31);
					if (!terr(x)) return;
					ci = ni;
					cj = nj;
				}
			};
			walk(e2, i + DIRS[d][0], j + DIRS[d][1], d);
			walk(e, i, j, (d + 4) & 7);
			return hi > lo + JUMP;
		};
		// The ground's own steepness at a terrain entry: its height's gradient over FALL_SPAN columns either way along
		// i and j (following links on its surface), so the triangles' alternation the columns sample averages out;
		// tan of the slope, 0 when no neighbour is linked.
		const fall = new Float32Array(n).fill(-1);
		const reach = (e, i, j, d) => {
			let x = e;
			let ci = i;
			let cj = j;
			let steps = 0;
			for (; steps < FALL_SPAN; steps++) {
				const c = links[x * 8 + d];
				const ni = ci + DIRS[d][0];
				const nj = cj + DIRS[d][1];
				if (c === NO_LINK || ni < 0 || nj < 0 || ni > 255 || nj > 255) break;
				const y = first[nj * TILE_CELLS + ni] + (c & 31);
				if (!terr(y)) break;
				x = y;
				ci = ni;
				cj = nj;
			}
			return [x, steps];
		};
		const fallOf = (e, k2) => {
			if (fall[e] >= 0) return fall[e];
			const i = k2 & 255;
			const j = k2 >> 8;
			let g2 = 0;
			for (const d of [0, 2]) {
				const [p, sp] = reach(e, i, j, d);
				const [q, sq] = reach(e, i, j, d + 4);
				if (sp + sq) g2 += ((z[p] - z[q]) / ((sp + sq) * CELL)) ** 2;
			}
			return (fall[e] = Math.sqrt(g2));
		};
		// Terrain whose triangle is over WALK_MAX (FLAG.STEEP, surfaces.js): the client slides off it.
		const slide = (e) => (flags[e] & (FLAG.TERRAIN | FLAG.WMO | FLAG.M2 | FLAG.STEEP)) === (FLAG.TERRAIN | FLAG.STEEP);
		const base = regions.compBase.get(tileKey(meta.col, meta.row));
		const big = (e) => !(flags[e] & FLAG.BLOCKED) && comp[e] !== NO_COMP && base !== undefined && regions.regionSize[regions.region[base + comp[e]]] >= MIN_REGION;
		const node = new Int32Array(n).fill(-1);
		const loc = new Int32Array(n).fill(-1);
		const parent = [];
		const find = (x) => {
			while (parent[x] !== x) {
				parent[x] = parent[parent[x]];
				x = parent[x];
			}
			return x;
		};
		// Entries with a link (not a closed one) out of or into their cell: a piece
		// with none is cut off (a wall's top, a pillar) and left out.
		const joined = new Uint8Array(n);
		for (let k2 = 0; k2 < TILE_CELLS * TILE_CELLS; k2++) {
			const i = k2 & 255;
			const j = k2 >> 8;
			for (let e = first[k2]; e < first[k2 + 1]; e++) {
				if (!big(e)) continue;
				for (let d = 0; d < 8; d++) {
					const code = links[e * 8 + d];
					if (CLOSED(code)) continue;
					const i2 = i + DIRS[d][0];
					const j2 = j + DIRS[d][1];
					if (i2 < 0 || j2 < 0 || i2 > 255 || j2 > 255) joined[e] = 1;
					else if (LX[j2] !== LX[j] || LY[i2] !== LY[i]) {
						const f = first[j2 * TILE_CELLS + i2] + (code & 31);
						if (big(f)) joined[e] = joined[f] = 1;
					}
				}
			}
		}
		for (let lc = 0; lc < C * C; lc++) {
			const ents = [];
			for (let q = colsAt[lc]; q < colsAt[lc + 1]; q++) {
				const kk = colList[q];
				for (let e = first[kk]; e < first[kk + 1]; e++) {
					if (!big(e)) {
						if (!(flags[e] & FLAG.BLOCKED)) dropped++;
						continue;
					}
					const a = ents.length / 2;
					loc[e] = a;
					parent[a] = a;
					ents.push(e, kk);
				}
			}
			const m = ents.length / 2;
			if (!m) continue;
			const lx = Math.floor(lc / C);
			const ly = lc % C;
			for (let a = 0; a < m; a++) {
				const e = ents[2 * a];
				const kk = ents[2 * a + 1];
				const i = kk & 255;
				const j = kk >> 8;
				for (let d = 0; d < 8; d++) {
					const code = links[e * 8 + d];
					if (CLOSED(code)) continue;
					const i2 = i + DIRS[d][0];
					const j2 = j + DIRS[d][1];
					if (i2 < 0 || j2 < 0 || i2 > 255 || j2 > 255 || LX[j2] !== lx || LY[i2] !== ly) continue;
					const b = loc[first[j2 * TILE_CELLS + i2] + (code & 31)];
					if (b >= 0) {
						const ra = find(a);
						const rb = find(b);
						if (ra !== rb) parent[Math.max(ra, rb)] = Math.min(ra, rb);
					}
				}
			}
			// Pieces: entries, swim entries, the entry nearest the centre, region size.
			const pieces = new Map();
			for (let a = 0; a < m; a++) {
				const r = find(a);
				const e = ents[2 * a];
				const kk = ents[2 * a + 1];
				let p = pieces.get(r);
				if (!p) {
					p = { root: r, count: 0, wet: 0, rep: -1, d2: Infinity, size: 0, joined: 0, members: [] };
					pieces.set(r, p);
				}
				p.count++;
				p.members.push(e);
				if (flags[e] & FLAG.SWIM) p.wet++;
				p.joined |= joined[e];
				const d2 = off[255 - (kk >> 8)] ** 2 + off[255 - (kk & 255)] ** 2;
				if (d2 < p.d2 || (d2 === p.d2 && z[e] > z[p.rep])) {
					p.d2 = d2;
					p.rep = e;
				}
				p.size = Math.max(p.size, regions.regionSize[regions.region[base + comp[e]]]);
			}
			// Joined pieces whose height the format stores (floors: -2048..2047 yd).
			let list = [...pieces.values()].filter((p) => p.joined && z[p.rep] >= -2048 && z[p.rep] <= 2047);
			if (!list.length) {
				for (let a = 0; a < m; a++) loc[ents[2 * a]] = -1;
				continue;
			}
			for (const p of list) {
				p.z = z[p.rep];
				p.val = p.wet * 2 > p.count ? 2 : 1;
			}
			const water = Math.max(-Infinity, ...list.filter((p) => p.val === 2).map((p) => p.z));
			list = list.filter((p) => p.z >= water - STEP);
			list.sort((p, q) => q.size - p.size || q.count - p.count || q.z - p.z || p.root - q.root);
			const [bottom, ...rest] = list;
			rest.sort((p, q) => p.z - q.z || q.count - p.count || p.root - q.root);
			const gx = kx * C + lx;
			const gy = ky * C + ly;
			const cell = gx * GH + gy;
			cl.val[lc] = bottom.val;
			cl.zq[lc] = Math.round(bottom.z / ZQ);
			for (const e of bottom.members) node[e] = cell;
			for (const p of rest) {
				const f = cg.addFloor(cell, p.val, p.z);
				for (const e of p.members) node[e] = f;
			}
			packed += list.length;
			for (let a = 0; a < m; a++) loc[ents[2 * a]] = -1;
		}
		cl.floorEnd = cg.floorCell.length;
		// Joins: every link (not a closed one) into another cell.
		const mine = new Map();
		for (let k2 = 0; k2 < TILE_CELLS * TILE_CELLS; k2++) {
			const i = k2 & 255;
			const j = k2 >> 8;
			const edge = i === 0 || j === 0 || i === 255 || j === 255;
			for (let e = first[k2]; e < first[k2 + 1]; e++) {
				const a = node[e];
				if (a < 0) continue;
				if (edge) mine.set((k2 << 5) | (e - first[k2]), a);
				for (let d = 0; d < 8; d++) {
					const code = links[e * 8 + d];
					if (CLOSED(code)) continue;
					let i2 = i + DIRS[d][0];
					let j2 = j + DIRS[d][1];
					if (i2 >= 0 && j2 >= 0 && i2 <= 255 && j2 <= 255) {
						if (LX[j2] === LX[j] && LY[i2] === LY[i]) continue;
						const e2 = first[j2 * TILE_CELLS + i2] + (code & 31);
						const b = node[e2];
						if (b < 0) continue;
						if (code >> 5 === CLS.STEEP || steepRun(e, i, j, d, e2) || (terr(e) && terr(e2) && (fallOf(e, k2) > TAN_WALK || fallOf(e2, j2 * TILE_CELLS + i2) > TAN_WALK))) faces.add(a, b, Math.abs(z[e2] - z[e]) / (d & 1 ? CELL * Math.SQRT2 : CELL));
						else faces.join(a, b);
						continue;
					}
					let col = meta.col;
					let row = meta.row;
					if (i2 < 0) (col--, (i2 += 256));
					else if (i2 > 255) (col++, (i2 -= 256));
					if (j2 < 0) (row--, (j2 += 256));
					else if (j2 > 255) (row++, (j2 -= 256));
					if (byKey.has(tileKey(col, row))) cross.push(a, tileKey(col, row), (((j2 << 8) | i2) << 5) | (code & 31), code >> 5 === CLS.STEEP ? 1 : 0);
				}
			}
		}
		border.set(tileKey(meta.col, meta.row), mine);
	}
	for (let x = 0; x < cross.length; x += 4) {
		const b = border.get(cross[x + 1])?.get(cross[x + 2]);
		if (b === undefined) continue;
		if (cross[x + 3]) faces.add(cross[x], b, TAN_STEEP);
		else faces.join(cross[x], b);
	}
	const opened = faces.bridge();
	cg.finish();
	log(`cells ${C}: ${cg.clusters.size} clusters, surfaces ${packed} (floors ${cg.floorCell.length}), dropped small-region entries ${dropped}, face links ${faces.count} (opened as the only way in ${opened})`);
	return cg;
}

async function cellGridFromDir({ dir, c, C, log }) {
	const index = JSON.parse(fs.readFileSync(path.join(dir, 'index.json'), 'utf8'));
	const cont = index.continents[c];
	if (!cont) throw new Error(`pack: no continent ${c} in ${dir}`);
	const regions = await readRegions(path.join(dir, 'graph', `${c}.bin.gz`));
	const tiles = cont.tiles.map((key) => {
		const [col, row] = key.split('_').map(Number);
		return { col, row };
	});
	// Every tile index.json lists has its file: a missing, truncated or older one stops the pack (no map with holes).
	const loadTile = (col, row) => {
		const key = `${c}/${tileKey(col, row)}`;
		let t;
		try {
			t = decodeTile(fs.readFileSync(path.join(dir, 'tiles', String(c), `${tileKey(col, row)}.nav.gz`)));
		} catch (e) {
			throw new Error(`pack: tile ${key}: ${e.message}`);
		}
		if (!t.links) throw new Error(`pack: tile ${key}: not linked (rerun \`node tools/polestar.js nav build\`)`);
		return t;
	};
	return { cg: cellGrid({ tiles, loadTile, regions, C, log }), index };
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
	return { N, value, off, to: Int32Array.from(to), len: Float64Array.from(len), local, global };
}

// gen_nav.py grid_hpa: regions per cluster, entrances per border group every
// ENTRANCE_YD, intra-cluster edges by Dijkstra per weight, pruned.
function buildHpa(cg, log = () => {}) {
	const { C, NX, NY, GH } = cg;
	const CS = T / C;
	const run = Math.max(1, Math.round(ENTRANCE_YD / CS));
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
			for (const crossings of groups.values()) {
				crossings.sort((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2] || a[3] - b[3]);
				for (let i = 0; i < crossings.length; i += run) {
					const chunk = crossings.slice(i, i + run);
					const mid = chunk[chunk.length >> 1][0];
					let best = chunk[0];
					for (const c of chunk) if (c[1] < best[1] || (c[1] === best[1] && Math.abs(c[0] - mid) < Math.abs(best[0] - mid))) best = c;
					const [, diagonal, u, v] = best;
					const wet = ((cg.nodeValue(u) === 2) + (cg.nodeValue(v) === 2)) / 2;
					edges.set(`${u},${v}`, [u, v, WEIGHTS.map((w) => CS * (diagonal ? Math.SQRT2 : 1) * (1 + (w - 1) * wet))]);
					addNode(u);
					addNode(v);
				}
			}
		}
	}
	const inter = edges.size;
	// Intra-cluster edges.
	const heap = new Heap();
	for (const k of [...nodes.keys()].sort((a, b) => a - b)) {
		const mv = moves.get(k);
		const el = [...nodes.get(k)].sort((a, b) => a - b);
		const n = el.length;
		const target = new Int32Array(mv.N).fill(-1);
		el.forEach((g, i) => (target[mv.local(g)] = i));
		const dists = WEIGHTS.map(() => new Float64Array(n * n).fill(Infinity));
		const gd = new Float64Array(mv.N);
		WEIGHTS.forEach((w, mode) => {
			const D = dists[mode];
			for (let s = 0; s < n; s++) {
				gd.fill(Infinity);
				const src = mv.local(el[s]);
				gd[src] = 0;
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
						left--;
					}
					for (let q = mv.off[u]; q < mv.off[u + 1]; q++) {
						const v = mv.to[q];
						const c = du + mv.len[q] * CS * (mv.value[v] === 2 ? w : 1);
						if (c < gd[v]) {
							gd[v] = c;
							heap.push(c, v);
						}
					}
				}
			}
		});
		for (let a = 0; a < n; a++) {
			for (let b = a + 1; b < n; b++) {
				if (dists[0][a * n + b] === Infinity) continue;
				const ds = dists.map((D) => D[a * n + b]);
				let pruned = true;
				for (let mode = 0; mode < WEIGHTS.length && pruned; mode++) {
					const D = dists[mode];
					let any = false;
					// Both legs shorter than the edge: a detour never prunes the edges it rests on (two entrances a few
					// yards apart at the far end of a long walk would otherwise prune each other's edge to it).
					for (let x = 0; x < n && !any; x++) if (x !== a && x !== b && D[a * n + x] < ds[mode] && D[x * n + b] < ds[mode] && D[a * n + x] + D[x * n + b] <= ds[mode] * PRUNE) any = true;
					pruned = any;
				}
				if (!pruned) edges.set(`${el[a]},${el[b]}`, [el[a], el[b], ds]);
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

// gen_nav.py encode_map + encode_floors: CellGrid + HPA -> strings per cluster (0-based k).
function encodeMaps(cg, hpa) {
	const { C, NY, GH } = cg;
	const NB = cg.GW * GH;
	const { nodes, edges } = hpa;
	const all = [...nodes.values()].flatMap((s) => [...s]).sort((a, b) => a - b);
	const parent = new Map(all.map((c) => [c, c]));
	const find = (x) => {
		while (parent.get(x) !== x) {
			parent.set(x, parent.get(parent.get(x)));
			x = parent.get(x);
		}
		return x;
	};
	for (const [a, b] of [...edges.values()].sort((p, q) => p[0] - q[0] || p[1] - q[1])) parent.set(find(a), find(b));
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
	for (const [a, b, d] of edges.values()) {
		if (!nbrs.has(a)) nbrs.set(a, []);
		if (!nbrs.has(b)) nbrs.set(b, []);
		nbrs.get(a).push([b, d]);
		nbrs.get(b).push([a, d]);
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
	let clamped = 0;
	let maxDegree = 0;
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
				const list = (nbrs.get(c) || []).sort((p, q) => p[0] - q[0] || p[1][0] - q[1][0] || p[1][1] - q[1][1]);
				maxDegree = Math.max(maxDegree, list.length);
				if (list.length >= 64) throw new Error(`pack: entrance ${c} has ${list.length} edges (at most 63)`);
				// The entrance's local cell (a floor's own cell, gen_nav.py lcell(cell_of(c))) and its layer.
				rec += enc(lcell(cg.cellOf(c)), 3) + enc(layerOf(c), 1) + enc(comp.get(c), 2) + enc(list.length, 1);
				for (const [m, d] of list) {
					const km = cg.clusterOfCell(cg.cellOf(m));
					const dx = Math.floor(km / NY) - kx;
					const dy = (km % NY) - ky;
					erec += enc((dx + 1) * 3 + dy + 1, 1) + enc(local.get(m), 2);
					for (const w of d) {
						const r = Math.round(w);
						if (r > 4095) clamped++;
						erec += enc(Math.min(r, 4095), 2);
					}
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
	return { graph, grid: grids, height: heights, floor: floors, components: roots.size, clamped, maxDegree };
}

const HEADER = [
	'-- UnitPosition\'s frame (x north, y west). Cluster k (0-based) is the ADT tile x in [(cx0 + k // ny) T, +T),',
	'-- y in [(cy0 + k % ny) T, +T), T = 1600 / 3, cut into cells x cells cells, x-major. Base64 (A-Za-z0-9+/).',
	'-- graph[k + 1]: n(2) | n x [cell(3) layer(1) component(2) degree(1)] | edges in node order [cluster offset(1):',
	'--   (dx + 1) * 3 + dy + 1, node(2), cost(2) swimming with water at swim, cost(2) walking on water, both in',
	'--   running yards]. grid[k + 1]: per cell value * 16 + flags, where value 0 blocked, 1 ground, 2 water;',
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
	'-- Packed (pack_nav.py\'s layout): data.packed.<field>[k + 1] = { base64(zlib(16 KB block)), ... } in the parts.',
];

const FIELDS = ['graph', 'grid', 'height', 'floor'];
const PART_NOTE = '-- Compressed terrain for on-demand decoding (Shortest Path Forever\'s pack_nav.py layout).';
const CREDIT = [
	'-- The navigation grid in Shortest Path Forever\'s walking-map format (github.com/cjber/shortest-path-forever),',
	'-- written by tools/lib/nav/pack.js, a port of his tools/baker/gen_nav.py and tools/pack_nav.py, used with his permission.',
	'-- Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.',
];

// One map's strings -> its metadata file and parts (pack_nav.py write_bundle);
// `gen` is the generated-file header line.
function packFiles({ map, cg, maps, global, gen }) {
	const files = [];
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
		`\tcx0 = ${cg.CX0},`,
		`\tcy0 = ${cg.CY0},`,
		`\tnx = ${cg.NX},`,
		`\tny = ${cg.NY},`,
		`\tcells = ${cg.C},`,
		`\tswim = ${SWIM.toFixed(6)},`,
		`\tzstep = ${ZQ},`,
		'\tgraph = {},',
		'\tgrid = {},',
		'\theight = {},',
		'\tfloor = {},',
		`\tcounts = { ${FIELDS.map((f) => `${f} = ${maps[f].size}`).join(', ')} },`,
		'\tpacked = { graph = {}, grid = {}, height = {}, floor = {} },',
		'}',
		'',
	].join('\n');
	files.push([`Nav${map}.lua`, meta]);
	const header = `${gen}\n${PART_NOTE}\n---@type SPFNavData\nlocal data = ${global}[${map}]\n-- stylua: ignore start\n`;
	let part = 1;
	let content = header;
	const keys = [...new Set(FIELDS.flatMap((f) => [...maps[f].keys()]))].sort((a, b) => a - b);
	let packedBytes = 0;
	for (const k of keys) {
		for (const field of FIELDS) {
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

// The pack: every continent of the grid (or `continents`) -> files.
// places: { aids, lifts, geo, areas } (chokepoints.js) adds Chokepoints.lua.
// date (YYYY-MM-DD) goes into the generated-file headers; the same grid,
// cells and date give the same bytes. -> Map name -> Lua source, in load
// order, with .manifest (PACK.json's content without the hashes: grid,
// cells, date, per map its counts and sizes) and .log (timings, memory).
async function packNav({ dir, cells = 128, continents, global = 'PolestarPathData', places = null, date = new Date().toISOString().slice(0, 10), log = () => {} }) {
	if (!/^\d{4}-\d\d-\d\d$/.test(String(date))) throw new Error(`pack: date must be YYYY-MM-DD, got ${date}`);
	const index = JSON.parse(fs.readFileSync(path.join(dir, 'index.json'), 'utf8'));
	const list = (continents || Object.keys(index.continents).map(Number)).slice().sort((a, b) => a - b);
	const files = new Map();
	const grid = { product: index.product || null, build: index.build || null, builtAt: index.builtAt || null, version: index.version };
	const manifest = { generator: 'node tools/polestar.js nav pack', grid, cells, date, maps: {} };
	const timing = {};
	const source = `the navigation grid (${grid.product} ${grid.build}, built ${String(grid.builtAt).slice(0, 10)}) on ${date}`;
	const gen = header('lua', `nav pack --cells ${cells}`, source);
	const byMap = {};
	for (const c of list) {
		const t0 = Date.now();
		const { cg } = await cellGridFromDir({ dir, c, C: cells, log });
		const hpa = buildHpa(cg, log);
		const maps = encodeMaps(cg, hpa);
		const m = {};
		if (places) {
			const { openNav } = require('./path');
			const { chokepoints } = require('./chokepoints');
			byMap[c] = chokepoints({ nav: openNav({ dir, cacheTiles: 16 }), c, aids: places.aids, lifts: (places.lifts || {})[c] || [], geo: places.geo, areas: places.areas });
			m.chokepoints = byMap[c].length;
		}
		const { files: out, packedBytes } = packFiles({ map: c, cg, maps, global, gen });
		for (const [name, content] of out) files.set(name, content);
		const raw = FIELDS.reduce((s, f) => s + [...maps[f].values()].reduce((a, v) => a + v.length, 0), 0);
		Object.assign(m, {
			clusters: cg.clusters.size, floors: cg.floorCell.length, nodes: [...hpa.nodes.values()].reduce((s, x) => s + x.size, 0), edges: hpa.edges.size,
			components: maps.components, clampedCosts: maps.clamped, maxDegree: maps.maxDegree, rawBytes: raw, packedBytes, files: out.length,
		});
		manifest.maps[c] = m;
		timing[c] = { seconds: (Date.now() - t0) / 1000, peakRssMB: Math.round(process.resourceUsage().maxRSS / 1024) };
		log(`map ${c}: ${JSON.stringify({ ...m, ...timing[c] })}`);
	}
	if (places) files.set('Chokepoints.lua', require('./chokepoints').chokepointsLua(byMap, gen));
	files.manifest = manifest;
	files.timing = timing;
	return files;
}

const sha256 = (text) => crypto.createHash('sha256').update(text).digest('hex');
const PACK_JSON = 'PACK.json';
// Files of ours in an addon's Nav/: our maps' files and the chokepoints.
const ownFile = (name, maps) => name === 'Chokepoints.lua' || maps.some((m) => new RegExp(`^Nav${m}(_\\d+)?\\.lua$`).test(name));

// Writes a pack (packNav's files) into an addon folder: Nav/<files>, PACK.json
// (its manifest with the sha256 of every file, in load order), and Nav/Nav.xml
// (vendor.js navXml: our files, then the vendored maps). Our files the new
// pack has no more are removed. -> { written, removed }
function shipPack(files, addonDir) {
	const { navXml, OWN_MAPS } = require('./vendor');
	const navDir = path.join(addonDir, 'Nav');
	fs.mkdirSync(navDir, { recursive: true });
	const removed = [];
	for (const name of fs.readdirSync(navDir)) {
		if (ownFile(name, OWN_MAPS) && !files.has(name)) {
			fs.rmSync(path.join(navDir, name));
			removed.push(`Nav/${name}`);
		}
	}
	const hashes = {};
	for (const [name, text] of files) {
		fs.writeFileSync(path.join(navDir, name), text);
		hashes[`Nav/${name}`] = sha256(text);
	}
	fs.writeFileSync(path.join(addonDir, PACK_JSON), `${JSON.stringify({ ...files.manifest, files: hashes }, null, '\t')}\n`);
	fs.writeFileSync(path.join(navDir, 'Nav.xml'), navXml(addonDir));
	return { written: Object.keys(hashes), removed };
}

// What differs between an addon folder and its PACK.json: changed, missing
// and unlisted files of ours, and a Nav.xml that is not navXml's. [] when it
// matches; a missing or unreadable PACK.json is the one problem reported.
function checkPack(addonDir) {
	const { navXml, OWN_MAPS } = require('./vendor');
	const file = path.join(addonDir, PACK_JSON);
	if (!fs.existsSync(file)) return [`${file} is missing: run \`node tools/polestar.js nav pack\``];
	let manifest;
	try {
		manifest = JSON.parse(fs.readFileSync(file, 'utf8'));
	} catch (e) {
		return [`${file} is not valid JSON (${e.message})`];
	}
	if (!manifest || !manifest.files || typeof manifest.files !== 'object') return [`${file} lacks files`];
	const problems = [];
	for (const [rel, want] of Object.entries(manifest.files)) {
		const name = rel.startsWith('Nav/') ? rel.slice(4) : '';
		if (!ownFile(name, OWN_MAPS)) {
			problems.push(`${rel} in PACK.json is not a packed file`);
			continue;
		}
		const target = path.join(addonDir, 'Nav', name);
		if (!fs.existsSync(target)) problems.push(`${rel} is missing`);
		else if (sha256(fs.readFileSync(target, 'utf8')) !== want) problems.push(`${rel} differs from PACK.json`);
	}
	const navDir = path.join(addonDir, 'Nav');
	for (const name of fs.existsSync(navDir) ? fs.readdirSync(navDir) : []) {
		if (ownFile(name, OWN_MAPS) && !(`Nav/${name}` in manifest.files)) problems.push(`Nav/${name} is not listed in PACK.json`);
	}
	const xml = path.join(navDir, 'Nav.xml');
	if (!fs.existsSync(xml) || fs.readFileSync(xml, 'utf8') !== navXml(addonDir)) problems.push('Nav/Nav.xml does not list the packed and vendored maps (rerun `nav pack`)');
	return problems;
}

module.exports = {
	SWIM, WEIGHTS, ZQ, MIN_REGION, BLOCK_BYTES, PART_BYTES, B64, SDX, SDY, OPP, PACK_JSON,
	CellGrid, cellGrid, cellGridFromDir, readRegions, buildHpa, encodeMaps, packFiles, packNav, shipPack, checkPack,
};
