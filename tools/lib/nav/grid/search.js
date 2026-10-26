'use strict';
// Search primitives over linked tiles (format.js TILE with links), shared by
// the abstract graph's build (graph.js) and the route search (path.js).
//
// A Space numbers the entries of a set of tiles (slots) as one node range:
// node = base[slot] + entry. expand() lists a node's out-links that stay in
// the Space, with their seconds for a profile (move.js); inLinks() the
// in-links of an entry from inside its tile.

const { TILE_CELLS, CELL, ADT, NO_LINK, DIRS, FLAG, CLS, CODE_LIFT, FALL_SLIDE } = require('./format');
const { FALL_SPAN } = require('./links');
const { linkSeconds, fallSeconds, liftSeconds, segmentClass } = require('../move');

const DIAG = CELL * Math.SQRT2;

class MinHeap {
	constructor(cap = 1024) {
		this.keys = new Float64Array(cap);
		this.vals = new Int32Array(cap);
		this.size = 0;
	}

	push(key, val) {
		if (this.size === this.keys.length) {
			const k = new Float64Array(this.size * 2);
			k.set(this.keys);
			this.keys = k;
			const v = new Int32Array(this.size * 2);
			v.set(this.vals);
			this.vals = v;
		}
		let i = this.size++;
		const { keys, vals } = this;
		while (i > 0) {
			const p = (i - 1) >> 1;
			if (keys[p] <= key) break;
			keys[i] = keys[p];
			vals[i] = vals[p];
			i = p;
		}
		keys[i] = key;
		vals[i] = val;
	}

	// Removes the smallest; its key is this.top afterwards.
	pop() {
		const { keys, vals } = this;
		const val = vals[0];
		this.top = keys[0];
		const n = --this.size;
		if (n > 0) {
			const key = keys[n];
			const v = vals[n];
			let i = 0;
			for (;;) {
				let c = 2 * i + 1;
				if (c >= n) break;
				if (c + 1 < n && keys[c + 1] < keys[c]) c++;
				if (keys[c] >= key) break;
				keys[i] = keys[c];
				vals[i] = vals[c];
				i = c;
			}
			keys[i] = key;
			vals[i] = v;
		}
		return val;
	}
}

class Space {
	// tiles: linked tiles (slot = index). load(col, row) -> tile or null: tiles
	// the search may enter beyond them, loaded (and numbered) when first reached.
	constructor(tiles, load = null) {
		this.tiles = [];
		this.base = [0];
		this.slots = new Map();
		// The 3 x 3 neighbourhood of each slot: slot, -1 none, -2 not looked up yet.
		this.nb = [];
		this.load = load;
		for (const t of tiles) this.add(t);
		const cap = 32;
		this.outTo = new Int32Array(cap);
		this.outK = new Int32Array(cap);
		this.outCls = new Uint8Array(cap);
		this.outCode = new Uint8Array(cap);
		this.outCost = new Float64Array(cap);
		this.outD = new Float64Array(cap);
		this.outH = new Float64Array(cap);
		this.outSlot = new Int32Array(cap);
	}

	add(t) {
		const s = this.tiles.length;
		this.tiles.push(t);
		this.base.push(this.base[s] + t.n);
		this.slots.set(t.col * 65536 + t.row, s);
		for (let x = 0; x < 9; x++) this.nb.push(x === 4 ? s : -2);
		return s;
	}

	get size() {
		return this.base[this.tiles.length];
	}

	slot(col, row) {
		const key = col * 65536 + row;
		const s = this.slots.get(key);
		if (s !== undefined) return s;
		const t = this.load ? this.load(col, row) : null;
		if (!t) {
			this.slots.set(key, -1);
			return -1;
		}
		return this.add(t);
	}

	slotOf(node) {
		const b = this.base;
		let lo = 0;
		let hi = this.tiles.length - 1;
		while (lo < hi) {
			const mid = (lo + hi + 1) >> 1;
			if (b[mid] <= node) lo = mid;
			else hi = mid - 1;
		}
		return lo;
	}

	// World position of column k of slot.
	wx(slot, k) {
		return (32 - this.tiles[slot].row) * ADT - ((k >> 8) + 0.5) * CELL;
	}

	wy(slot, k) {
		return (32 - this.tiles[slot].col) * ADT - ((k & 255) + 0.5) * CELL;
	}

	// The slot and column of (i, j) relative to slot -> sets this.rs, returns k or -1.
	col(slot, i, j) {
		const dc = i < 0 ? -1 : i >= TILE_CELLS ? 1 : 0;
		const dr = j < 0 ? -1 : j >= TILE_CELLS ? 1 : 0;
		let s = slot;
		if (dc !== 0 || dr !== 0) {
			const x = slot * 9 + (dr + 1) * 3 + (dc + 1);
			s = this.nb[x];
			if (s === -2) {
				const t = this.tiles[slot];
				s = this.slot(t.col + dc, t.row + dr);
				this.nb[x] = s;
			}
		}
		this.rs = s;
		if (s < 0) return -1;
		return (j - dr * TILE_CELLS) * TILE_CELLS + (i - dc * TILE_CELLS);
	}

	// Out-links of entry e (column k) of slot for profile p -> count; fills
	// outTo (node), outSlot, outK (column), outCode (stored link code, or
	// CLS.FALL / format.js CODE_LIFT), outCls (route class), outCost (seconds), outD
	// (yards), outH (fall or lift height, else 0). Lifts come from
	// tile.lifts (Map entry -> [{ col, row, k, entry, h }], path.js). A step's
	// seconds are times the multiplier of the surface it enters (areaAt:
	// edgecost.js's ground, hub and danger terms, where p has them).
	expand(slot, e, k, p) {
		const t = this.tiles[slot];
		const i = k & 255;
		const j = k >> 8;
		const fa = t.flags[e];
		const za = t.z[e];
		let n = 0;
		const lk = t.links;
		for (let d = 0; d < 8; d++) {
			const b = lk[e * 8 + d];
			if (b === NO_LINK) continue;
			const k2 = this.col(slot, i + DIRS[d][0], j + DIRS[d][1]);
			if (k2 < 0) continue;
			const s2 = this.rs;
			const t2 = this.tiles[s2];
			const v = t2.first[k2] + (b & 31);
			const cls = b >> 5;
			const dz = t2.z[v] - za;
			const h = d & 1 ? DIAG : CELL;
			const dist = Math.sqrt(h * h + dz * dz);
			const fb = t2.flags[v];
			this.outTo[n] = this.base[s2] + v;
			this.outSlot[n] = s2;
			this.outK[n] = k2;
			this.outCode[n] = cls;
			this.outCls[n] = segmentClass(cls, fa, fb);
			this.outCost[n] = linkSeconds(p, cls, fa, fb, dist) * areaAt(p, t2, k2, fb);
			this.outD[n] = dist;
			this.outH[n] = 0;
			n++;
		}
		if (t.lifts && t.lifts.has(e)) {
			for (const L of t.lifts.get(e)) {
				const s2 = L.col === t.col && L.row === t.row ? slot : this.slot(L.col, L.row);
				if (s2 < 0) continue;
				this.outTo[n] = this.base[s2] + L.entry;
				this.outSlot[n] = s2;
				this.outK[n] = L.k;
				this.outCode[n] = CODE_LIFT;
				this.outCls[n] = CLS.LIFT;
				this.outCost[n] = liftSeconds(L.h) * areaAt(p, this.tiles[s2], L.k, this.tiles[s2].flags[L.entry]);
				this.outD[n] = Math.abs(L.h);
				this.outH[n] = L.h;
				n++;
			}
		}
		if (fa & FLAG.SWIM || !t.fallFrom.length) return n;
		// Falls of e: fallFrom is ascending; fallAt (per tile, lazily) is its index of each entry's first.
		const at = t.fallAt || fallIndex(t);
		for (let f = at[e], end = at[e + 1]; f < end; f++) {
			const code = t.fallTo[f];
			const off = code >> 5;
			const di = Math.floor(off / FALL_SPAN) - FALL_SLIDE;
			const dj = (off % FALL_SPAN) - FALL_SLIDE;
			const k2 = this.col(slot, i + di, j + dj);
			if (k2 < 0) continue;
			const s2 = this.rs;
			const t2 = this.tiles[s2];
			const v = t2.first[k2] + (code & 31);
			const hgt = za - t2.z[v];
			const hor = Math.sqrt(di * di + dj * dj) * CELL;
			this.outTo[n] = this.base[s2] + v;
			this.outSlot[n] = s2;
			this.outK[n] = k2;
			this.outCode[n] = CLS.FALL;
			this.outCls[n] = CLS.FALL;
			this.outCost[n] = fallSeconds(hgt, (t2.flags[v] & FLAG.SWIM) !== 0) * areaAt(p, t2, k2, t2.flags[v]);
			this.outD[n] = Math.sqrt(hor * hor + hgt * hgt);
			this.outH[n] = hgt;
			n++;
		}
		return n;
	}
}

// The multiplier of a step into a surface with flags `flags` in column k of tile t for profile p
// (edgecost.js): p.ground(t, k, flags) (a road, a hostile hub) times p.area.mult(t, k) (zone
// danger), each 1 where the profile has none.
function areaAt(p, t, k, flags) {
	if (!p) return 1;
	const m = p.ground ? p.ground(t, k, flags) : 1;
	return p.area ? m * p.area.mult(t, k) : m;
}

// A linked tile's fallFrom index by entry: Uint32Array(n + 1), falls of
// entry e at [at[e], at[e + 1]) (cached on the tile).
function fallIndex(t) {
	const at = new Uint32Array(t.n + 1);
	const ff = t.fallFrom;
	for (let f = 0; f < ff.length; f++) at[ff[f] + 1]++;
	for (let e = 0; e < t.n; e++) at[e + 1] += at[e];
	t.fallAt = at;
	return at;
}

// Falls of a linked tile that land inside it, by landing, cached on the
// tile: { at: Uint32Array(n + 1) (falls into entry v at [at[v], at[v + 1])),
// from: Uint32Array (source entry), k: Uint32Array (its column) }.
function fallsInto(tile) {
	if (tile.fallsInto) return tile.fallsInto;
	const { first, fallFrom, fallTo } = tile;
	const m = fallFrom.length;
	const to = new Uint32Array(m);
	const fk = new Uint32Array(m);
	const fe = new Uint32Array(m);
	let kept = 0;
	let f = 0;
	for (let k = 0; k < TILE_CELLS * TILE_CELLS && f < m; k++) {
		const i = k & 255;
		const j = k >> 8;
		for (; f < m && fallFrom[f] < first[k + 1]; f++) {
			const off = fallTo[f] >> 5;
			const ni = i + Math.floor(off / FALL_SPAN) - FALL_SLIDE;
			const nj = j + (off % FALL_SPAN) - FALL_SLIDE;
			if (ni < 0 || nj < 0 || ni >= TILE_CELLS || nj >= TILE_CELLS) continue;
			to[kept] = first[nj * TILE_CELLS + ni] + (fallTo[f] & 31);
			fe[kept] = fallFrom[f];
			fk[kept] = k;
			kept++;
		}
	}
	// Counting sort by landing.
	const at = new Uint32Array(tile.n + 1);
	for (let x = 0; x < kept; x++) at[to[x] + 1]++;
	for (let v = 0; v < tile.n; v++) at[v + 1] += at[v];
	const fill = at.slice(0, tile.n);
	const out = { at, from: new Uint32Array(kept), k: new Uint32Array(kept) };
	for (let x = 0; x < kept; x++) {
		const y = fill[to[x]]++;
		out.from[y] = fe[x];
		out.k[y] = fk[x];
	}
	tile.fallsInto = out;
	return out;
}

// In-links of entry u (column k) of a linked tile from inside the tile ->
// count; fills IN.from (source entries), IN.k (their columns), IN.d (yards)
// and, with a profile p, IN.cost (seconds, as Space.expand gives them).
// Neighbour links are read off the eight neighbouring columns, falls (unless
// `falls` is false) off fallsInto(); lifts are left out.
const IN = { from: new Uint32Array(256), k: new Uint32Array(256), cost: new Float64Array(256), d: new Float64Array(256) };
function inLinks(t, u, k, p = null, falls = true) {
	const { first, links, z, flags } = t;
	const i = k & 255;
	const j = k >> 8;
	const layer = u - first[k];
	const fb = flags[u];
	const am = areaAt(p, t, k, fb);
	let n = 0;
	const add = (s, ks, cost, d) => {
		if (n === IN.from.length) {
			for (const key of ['from', 'k', 'cost', 'd']) {
				const a = new IN[key].constructor(n * 2);
				a.set(IN[key]);
				IN[key] = a;
			}
		}
		IN.from[n] = s;
		IN.k[n] = ks;
		IN.cost[n] = cost;
		IN.d[n] = d;
		n++;
	};
	for (let d = 0; d < 8; d++) {
		const si = i - DIRS[d][0];
		const sj = j - DIRS[d][1];
		if (si < 0 || sj < 0 || si >= TILE_CELLS || sj >= TILE_CELLS) continue;
		const ks = sj * TILE_CELLS + si;
		for (let s = first[ks], end = first[ks + 1]; s < end; s++) {
			const b = links[s * 8 + d];
			if (b === NO_LINK || (b & 31) !== layer) continue;
			const h = d & 1 ? DIAG : CELL;
			const dz = z[u] - z[s];
			const dist = Math.sqrt(h * h + dz * dz);
			add(s, ks, p ? linkSeconds(p, b >> 5, flags[s], fb, dist) * am : 0, dist);
		}
	}
	if (!falls) return n;
	const fi = fallsInto(t);
	for (let x = fi.at[u], end = fi.at[u + 1]; x < end; x++) {
		const s = fi.from[x];
		const ks = fi.k[x];
		const hgt = z[s] - z[u];
		const hor = Math.hypot((ks & 255) - i, (ks >> 8) - j) * CELL;
		add(s, ks, p ? fallSeconds(hgt, (fb & FLAG.SWIM) !== 0) * am : 0, Math.sqrt(hor * hor + hgt * hgt));
	}
	return n;
}

// Whether entry e (column k) of a linked tile is open both ways: walking
// (neighbour links: no falls, no lifts) inside the tile leads from it to
// `limit` surfaces, or to a link leaving the tile, and from as many to it.
// A ledge one can only fall off, a pen or a roof one can only fall into, a
// pocket under a floor, a tower's roof or a beam in a lift shaft are not.
function isOpen(t, k, e, limit) {
	const { first, links } = t;
	const spread = (forward) => {
		const seen = new Set([e]);
		const queue = [e, k];
		for (let q = 0; q < queue.length && seen.size < limit; q += 2) {
			const u = queue[q];
			const ku = queue[q + 1];
			const i = ku & 255;
			const j = ku >> 8;
			// A link of u leaving the tile: open that way (links are as good as symmetric).
			for (let d = 0; d < 8; d++) {
				if (links[u * 8 + d] === NO_LINK) continue;
				const ni = i + DIRS[d][0];
				const nj = j + DIRS[d][1];
				if (ni < 0 || nj < 0 || ni >= TILE_CELLS || nj >= TILE_CELLS) return true;
				if (!forward) continue;
				const kv = nj * TILE_CELLS + ni;
				const v = first[kv] + (links[u * 8 + d] & 31);
				if (seen.has(v)) continue;
				seen.add(v);
				queue.push(v, kv);
			}
			if (forward) continue;
			const cnt = inLinks(t, u, ku, null, false);
			for (let x = 0; x < cnt; x++) {
				if (seen.has(IN.from[x])) continue;
				seen.add(IN.from[x]);
				queue.push(IN.from[x], IN.k[x]);
			}
		}
		return seen.size >= limit;
	};
	return spread(true) && spread(false);
}

module.exports = { MinHeap, Space, inLinks, IN, isOpen, fallIndex, fallsInto, areaAt };
