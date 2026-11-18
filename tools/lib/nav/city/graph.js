'use strict';
// The walking grid of one area as a plain surface graph, for `nav city` (map-matching players' recordings onto
// floors, scoring drawn lines): every walkable surface of the grid (tools/lib/nav/grid/format.js, the 2.08 yd
// grid of `nav build`) in a box is a node; the grid's stored links (8 directions, with their class) and falls are its
// edges. Searches are Dijkstra / A* with an optional per-node cost multiplier and extra edges.
//
//   const { AreaGraph, CITIES, toWorld, toMap } = require('tools/lib/nav/city/graph');
//   const g = AreaGraph.forMap(uiMap, { grid, frames })     a capital's map frame plus 60 yd
//   g.n, g.nz[v], g.nflags[v], g.ncol[v]; g.xy(v) -> [wx, wy]; g.colNodes(ci); g.colIndex(wx, wy) (-1 outside)
//   g.levels(wx, wy, R) the column's surfaces plus each level within R columns the column lacks
//   g.search(sources [[v, d0]], targets, { bound, mult, goal [li, lj], extra Map(v -> [[u, yd]]) }); g.d(v); g.pathTo(v)
//
// World coordinates as the client's UnitPosition (wx north, wy west); map percent through map-frames.json's live
// (`forever`) frames.

const fs = require('node:fs');
const path = require('node:path');
const F = require('../grid/format');

const { TILE_CELLS, CELL, ADT, NO_LINK, DIRS, FLAG, FALL_SLIDE } = F;
const FALL_SPAN = 2 * FALL_SLIDE + 1;

// The capitals: uiMap -> continent, side (the walker's faction profile).
const CITIES = {
	1455: { name: 'Ironforge', c: 0, side: 'Alliance' },
	1453: { name: 'Stormwind', c: 0, side: 'Alliance' },
	1454: { name: 'Orgrimmar', c: 1, side: 'Horde' },
	1458: { name: 'Undercity', c: 0, side: 'Horde' },
	1456: { name: 'Thunder Bluff', c: 1, side: 'Horde' },
	1457: { name: 'Darnassus', c: 1, side: 'Alliance' },
};

function frameOf(frames, map) {
	const f = frames[String(map)];
	if (!f) throw new Error(`no live frame for uiMap ${map}`);
	return f;
}
const toWorld = (frames, map, x, y) => {
	const f = frameOf(frames, map);
	return [f.top + (f.bottom - f.top) * y / 100, f.left + (f.right - f.left) * x / 100];
};
const toMap = (frames, map, wx, wy) => {
	const f = frameOf(frames, map);
	return [(wy - f.left) / (f.right - f.left) * 100, (wx - f.top) / (f.bottom - f.top) * 100];
};
// Global grid column of a world point (gi east, gj south) and a column's centre.
const colOf = (wx, wy) => [Math.floor((32 * ADT - wy) / CELL), Math.floor((32 * ADT - wx) / CELL)];
const centre = (gi, gj) => [32 * ADT - (gj + 0.5) * CELL, 32 * ADT - (gi + 0.5) * CELL];

class Heap {
	constructor(cap) {
		this.k = new Float64Array(cap);
		this.v = new Int32Array(cap);
		this.size = 0;
		this.lastKey = 0;
	}
	clear() {
		this.size = 0;
	}
	push(v, key) {
		if (this.size === this.k.length) {
			const k = new Float64Array(this.size * 2);
			k.set(this.k);
			this.k = k;
			const vv = new Int32Array(this.size * 2);
			vv.set(this.v);
			this.v = vv;
		}
		let i = this.size++;
		const K = this.k;
		const V = this.v;
		while (i > 0) {
			const p = (i - 1) >> 1;
			if (K[p] <= key) break;
			K[i] = K[p];
			V[i] = V[p];
			i = p;
		}
		K[i] = key;
		V[i] = v;
	}
	pop() {
		const K = this.k;
		const V = this.v;
		const top = V[0];
		this.lastKey = K[0];
		const key = K[--this.size];
		const v = V[this.size];
		let i = 0;
		for (;;) {
			let c = 2 * i + 1;
			if (c >= this.size) break;
			if (c + 1 < this.size && K[c + 1] < K[c]) c++;
			if (K[c] >= key) break;
			K[i] = K[c];
			V[i] = V[c];
			i = c;
		}
		K[i] = key;
		V[i] = v;
		return top;
	}
}

class AreaGraph {
	// box: { c, wxMin, wxMax, wyMin, wyMax } in world yards; grid: a `nav build` grid folder.
	constructor({ c, wxMin, wxMax, wyMin, wyMax }, { grid }) {
		this.c = c;
		const [gi0, gj0] = colOf(wxMax, wyMax);
		const [gi1, gj1] = colOf(wxMin, wyMin);
		this.gi0 = gi0;
		this.gj0 = gj0;
		const W = (this.W = gi1 - gi0 + 1);
		const H = (this.H = gj1 - gj0 + 1);
		const NC = W * H;
		const tiles = new Map();
		const tileAt = (col, row) => {
			const key = col * 64 + row;
			if (!tiles.has(key)) {
				const p = path.join(grid, 'tiles', String(c), `${col}_${row}.nav.gz`);
				tiles.set(key, fs.existsSync(p) ? F.decodeTile(fs.readFileSync(p)) : null);
			}
			return tiles.get(key);
		};
		const colFirst = new Uint32Array(NC + 1);
		const colTile = new Array(NC);
		for (let lj = 0; lj < H; lj++) {
			for (let li = 0; li < W; li++) {
				const gi = gi0 + li;
				const gj = gj0 + lj;
				const t = tileAt(Math.floor(gi / TILE_CELLS), Math.floor(gj / TILE_CELLS));
				const k = (gj % TILE_CELLS) * TILE_CELLS + (gi % TILE_CELLS);
				const ci = lj * W + li;
				colFirst[ci + 1] = t ? t.count[k] : 0;
				colTile[ci] = t ? [t, t.first[k]] : null;
			}
		}
		for (let ci = 0; ci < NC; ci++) colFirst[ci + 1] += colFirst[ci];
		const layerNode = new Int32Array(colFirst[NC]).fill(-1);
		let n = 0;
		for (let ci = 0; ci < NC; ci++) {
			const ct = colTile[ci];
			if (!ct) continue;
			const [t, e0] = ct;
			for (let L = 0; L < colFirst[ci + 1] - colFirst[ci]; L++) if (!(t.flags[e0 + L] & FLAG.BLOCKED)) layerNode[colFirst[ci] + L] = n++;
		}
		this.n = n;
		const ncol = new Uint32Array(n);
		const nz = new Float32Array(n);
		const nflags = new Uint8Array(n);
		const nceil = new Float32Array(n);
		const edges = [];
		for (let ci = 0; ci < NC; ci++) {
			const ct = colTile[ci];
			if (!ct) continue;
			const [t, e0] = ct;
			const li = ci % W;
			const lj = (ci - li) / W;
			for (let L = 0; L < colFirst[ci + 1] - colFirst[ci]; L++) {
				const v = layerNode[colFirst[ci] + L];
				if (v < 0) continue;
				const e = e0 + L;
				ncol[v] = ci;
				nz[v] = t.z[e];
				nflags[v] = t.flags[e];
				nceil[v] = t.ceil[e];
				if (!t.links) continue;
				for (let d = 0; d < 8; d++) {
					const code = t.links[8 * e + d];
					if (code === NO_LINK) continue;
					const ni = li + DIRS[d][0];
					const nj = lj + DIRS[d][1];
					if (ni < 0 || nj < 0 || ni >= W || nj >= H) continue;
					const nc = nj * W + ni;
					const lay = code & 31;
					if (colFirst[nc] + lay >= colFirst[nc + 1]) continue;
					const u = layerNode[colFirst[nc] + lay];
					if (u >= 0) edges.push(v, u, code >> 5);
				}
			}
		}
		// falls: per tile, its fallFrom entries
		for (const t of tiles.values()) {
			if (!t || !t.fallFrom) continue;
			const tc = t.col * TILE_CELLS;
			const tr = t.row * TILE_CELLS;
			let k = 0;
			for (let f = 0; f < t.fallFrom.length; f++) {
				const e = t.fallFrom[f];
				while (t.first[k + 1] <= e) k++;
				const i = k % TILE_CELLS;
				const j = (k - i) / TILE_CELLS;
				const li = tc + i - gi0;
				const lj = tr + j - gj0;
				if (li < 0 || lj < 0 || li >= W || lj >= H) continue;
				const v = layerNode[colFirst[lj * W + li] + (e - t.first[k])];
				if (v < 0) continue;
				const off = t.fallTo[f] >> 5;
				const ni = li + Math.floor(off / FALL_SPAN) - FALL_SLIDE;
				const nj = lj + (off % FALL_SPAN) - FALL_SLIDE;
				if (ni < 0 || nj < 0 || ni >= W || nj >= H) continue;
				const nc = nj * W + ni;
				const lay = t.fallTo[f] & 31;
				if (colFirst[nc] + lay >= colFirst[nc + 1]) continue;
				const u = layerNode[colFirst[nc] + lay];
				if (u >= 0) edges.push(v, u, 4);
			}
		}
		const m = edges.length / 3;
		const adjStart = new Uint32Array(n + 1);
		for (let x = 0; x < m; x++) adjStart[edges[3 * x] + 1]++;
		for (let v = 0; v < n; v++) adjStart[v + 1] += adjStart[v];
		const adj = new Uint32Array(m);
		const acls = new Uint8Array(m);
		const alen = new Float32Array(m);
		const fill = adjStart.slice(0, n);
		for (let x = 0; x < m; x++) {
			const v = edges[3 * x];
			const u = edges[3 * x + 1];
			const p = fill[v]++;
			adj[p] = u;
			acls[p] = edges[3 * x + 2];
			const a = ncol[v];
			const b = ncol[u];
			const flat = Math.hypot((a % W) - (b % W), Math.floor(a / W) - Math.floor(b / W)) * CELL;
			alen[p] = acls[p] === 4 ? flat + 0.5 : Math.hypot(flat, nz[u] - nz[v]);
		}
		Object.assign(this, { m, colFirst, layerNode, ncol, nz, nflags, nceil, adjStart, adj, acls, alen });
		this.dist = new Float64Array(n);
		this.prev = new Int32Array(n);
		this.stamp = new Uint32Array(n);
		this.cur = 0;
		this.heap = new Heap(1 << 16);
	}

	// A capital's map frame plus pad yards.
	static forMap(map, { grid, frames, pad = 60 }) {
		const f = frameOf(frames, map);
		const city = CITIES[map];
		const c = city ? city.c : f.c;
		return new AreaGraph({ c, wxMin: Math.min(f.top, f.bottom) - pad, wxMax: Math.max(f.top, f.bottom) + pad, wyMin: Math.min(f.left, f.right) - pad, wyMax: Math.max(f.left, f.right) + pad }, { grid });
	}

	colNodes(ci) {
		const out = [];
		for (let p = this.colFirst[ci]; p < this.colFirst[ci + 1]; p++) if (this.layerNode[p] >= 0) out.push(this.layerNode[p]);
		return out;
	}
	colIndex(wx, wy) {
		const [gi, gj] = colOf(wx, wy);
		const li = gi - this.gi0;
		const lj = gj - this.gj0;
		if (li < 0 || lj < 0 || li >= this.W || lj >= this.H) return -1;
		return lj * this.W + li;
	}
	local(wx, wy) {
		const [gi, gj] = colOf(wx, wy);
		return [gi - this.gi0, gj - this.gj0];
	}
	xy(v) {
		const ci = this.ncol[v];
		const li = ci % this.W;
		return centre(this.gi0 + li, this.gj0 + (ci - li) / this.W);
	}
	// The point's column's surfaces plus each level within R columns (rings outward) the column lacks: beside a wall or a
	// counter the column's own floor can be blocked while the roof or the mountain over it is walkable.
	levels(wx, wy, R = 2) {
		const ci = this.colIndex(wx, wy);
		if (ci < 0) return [];
		const li = ci % this.W;
		const lj = (ci - li) / this.W;
		const out = this.colNodes(ci);
		for (let r = 1; r <= R; r++) {
			for (let dj = -r; dj <= r; dj++) {
				for (let di = -r; di <= r; di++) {
					if (Math.max(Math.abs(di), Math.abs(dj)) !== r) continue;
					const a = li + di;
					const b = lj + dj;
					if (a < 0 || b < 0 || a >= this.W || b >= this.H) continue;
					for (const u of this.colNodes(b * this.W + a)) if (!out.some((v) => Math.abs(this.nz[v] - this.nz[u]) <= 3)) out.push(u);
				}
			}
		}
		return out;
	}
	// Dijkstra (A* toward goal, local column coordinates) from sources until every target is settled or past bound.
	// mult: per-node multiplier (Float32Array) or null, hmin its smallest value (the heuristic's factor); extra:
	// Map(node -> [[node, yards], ...]).
	search(sources, targets, { bound = Infinity, mult = null, hmin = 1, goal = null, extra = null } = {}) {
		const st = ++this.cur;
		const { dist, prev, stamp, heap, adjStart, adj, alen, ncol, W } = this;
		heap.clear();
		const want = new Set(targets);
		let left = want.size;
		const gx = goal ? goal[0] : 0;
		const gy = goal ? goal[1] : 0;
		const h = goal ? (v) => Math.hypot((ncol[v] % W) - gx, Math.floor(ncol[v] / W) - gy) * CELL * hmin : () => 0;
		for (const [v, d0] of sources) {
			if (stamp[v] === st && dist[v] <= d0) continue;
			stamp[v] = st;
			dist[v] = d0;
			prev[v] = -1;
			heap.push(v, d0 + h(v));
		}
		const relax = (v, u, w) => {
			const du = dist[v] + w;
			if (stamp[u] !== st || du < dist[u]) {
				stamp[u] = st;
				dist[u] = du;
				prev[u] = v;
				heap.push(u, du + h(u));
			}
		};
		while (heap.size) {
			const v = heap.pop();
			const dv = dist[v];
			if (heap.lastKey > dv + h(v) + 1e-9) continue;
			if (dv > bound) break;
			if (want.has(v)) {
				want.delete(v);
				if (--left === 0) break;
			}
			for (let p = adjStart[v]; p < adjStart[v + 1]; p++) relax(v, adj[p], mult ? alen[p] * mult[adj[p]] : alen[p]);
			const ex = extra && extra.get(v);
			if (ex) for (const [u, len] of ex) relax(v, u, mult ? len * mult[u] : len);
		}
		return st;
	}
	d(v) {
		return this.stamp[v] === this.cur ? this.dist[v] : Infinity;
	}
	pathTo(v) {
		if (this.stamp[v] !== this.cur || this.dist[v] === Infinity) return null;
		const out = [];
		for (let x = v; x >= 0; x = this.prev[x]) out.push(x);
		return out.reverse();
	}
	pathYards(p) {
		let L = 0;
		for (let i = 1; i < p.length; i++) {
			const [ax, ay] = this.xy(p[i - 1]);
			const [bx, by] = this.xy(p[i]);
			L += Math.hypot(ax - bx, ay - by, this.nz[p[i]] - this.nz[p[i - 1]]);
		}
		return L;
	}
}

module.exports = { AreaGraph, CITIES, FLAG, CELL, toWorld, toMap, colOf, centre };
