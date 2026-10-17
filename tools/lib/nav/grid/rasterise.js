'use strict';
// Triangles -> solid spans per column (Recast's rcRasterizeTriangles): each
// triangle is clipped to every column it covers; the clipped polygon's z
// range is a span carrying the triangle's slope (degrees) and kind. Spans of
// a column that overlap merge into one: the merged span keeps the attributes
// of the higher top, or of the flatter one when the tops are within
// MERGE_TOP (Recast's flagMergeThreshold).
//
// Model triangles too steep to stand on (decided 2026-10-15). Taken over a
// whole 2.08 yd column, the end of a door jamb, a stair stringer or a post
// poking into its corner closed it from floor to ceiling, so doorways
// narrower than about two columns were shut (the Lion's Pride Inn's halls,
// the Undercity lift station's arch). So:
// - walls (WALL_MIN or steeper) are no spans: they are kept as the z
//   ranges where they cross each of the column's four half-lines (from its
//   centre to the middle of each side, format.js HALF), and links.js lets no
//   link or fall cross one between a step and a body height above the feet;
// - faces between WALK_MAX and WALL_MIN (roofs, rock faces, a cave's leaning
//   walls) are spans only where they cross one of the column's two centre
//   lines, over the z range of that crossing (as walls, a leaning cave wall
//   at head height closed passages one walks through in the client).
//
// rasterise({ tris, kind }, { col, row }) -> Heightfield
//   head: Int32Array(COLUMNS) first span of each column (ascending z), -1 none
//   next, smin, smax, slope (Uint8, degrees), kind (Uint8) per span
//   tslope (Uint8, degrees) per span: the steepest terrain triangle merged
//     into it (0 when none)
//   walls(): the walls (format.js WALLS), merged per half-line

const { ADT, CELL, TILE_CELLS, COLUMNS, MERGE_TOP, WALK_MAX, WALL_MIN, HALF, wallIndex } = require('./format');

class Heightfield {
	constructor(capacity = 1 << 18) {
		this.head = new Int32Array(COLUMNS).fill(-1);
		this.cap = 0;
		this.used = 0;
		this.free = -1;
		this.grow(capacity);
		this.wn = 0;
		this.wKey = new Uint32Array(1 << 12);
		this.wLo = new Float32Array(1 << 12);
		this.wHi = new Float32Array(1 << 12);
	}

	// A wall crossing half-line h (format.js HALF) of column k over [lo, hi].
	addWall(k, h, lo, hi) {
		if (this.wn === this.wKey.length) {
			const grow = (Ctor, old) => {
				const a = new Ctor(old.length * 2);
				a.set(old);
				return a;
			};
			this.wKey = grow(Uint32Array, this.wKey);
			this.wLo = grow(Float32Array, this.wLo);
			this.wHi = grow(Float32Array, this.wHi);
		}
		this.wKey[this.wn] = k * 4 + h;
		this.wLo[this.wn] = lo;
		this.wHi[this.wn] = hi;
		this.wn++;
	}

	walls() {
		return wallIndex(this.wKey.subarray(0, this.wn), this.wLo.subarray(0, this.wn), this.wHi.subarray(0, this.wn));
	}

	grow(cap) {
		const copy = (Ctor, old) => {
			const a = new Ctor(cap);
			if (old) a.set(old);
			return a;
		};
		this.next = copy(Int32Array, this.next);
		this.smin = copy(Float32Array, this.smin);
		this.smax = copy(Float32Array, this.smax);
		this.slope = copy(Uint8Array, this.slope);
		this.kind = copy(Uint8Array, this.kind);
		this.tslope = copy(Uint8Array, this.tslope);
		this.cap = cap;
	}

	alloc() {
		if (this.free >= 0) {
			const s = this.free;
			this.free = this.next[s];
			return s;
		}
		if (this.used === this.cap) this.grow(this.cap * 2);
		return this.used++;
	}

	release(s) {
		this.next[s] = this.free;
		this.free = s;
	}

	// Adds [lo, hi] to column k, merging every span it overlaps; tslope: the
	// triangle's slope when it is terrain, else 0.
	add(k, lo, hi, slope, kind, tslope = 0) {
		let topZ = hi;
		let topSlope = slope;
		let topKind = kind;
		let tmax = tslope;
		let prev = -1;
		let cur = this.head[k];
		while (cur !== -1) {
			if (this.smin[cur] > hi) break;
			if (this.smax[cur] < lo) {
				prev = cur;
				cur = this.next[cur];
				continue;
			}
			const cz = this.smax[cur];
			if (this.tslope[cur] > tmax) tmax = this.tslope[cur];
			if (Math.abs(cz - topZ) <= MERGE_TOP) {
				if (this.slope[cur] < topSlope) {
					topSlope = this.slope[cur];
					topKind = this.kind[cur];
				}
				if (cz > topZ) topZ = cz;
			} else if (cz > topZ) {
				topZ = cz;
				topSlope = this.slope[cur];
				topKind = this.kind[cur];
			}
			if (this.smin[cur] < lo) lo = this.smin[cur];
			if (cz > hi) hi = cz;
			const nx = this.next[cur];
			this.release(cur);
			if (prev === -1) this.head[k] = nx;
			else this.next[prev] = nx;
			cur = nx;
		}
		const s = this.alloc();
		this.smin[s] = lo;
		this.smax[s] = hi;
		this.slope[s] = topSlope;
		this.kind[s] = topKind;
		this.tslope[s] = tmax;
		if (prev === -1) {
			this.next[s] = this.head[k];
			this.head[k] = s;
		} else {
			this.next[s] = this.next[prev];
			this.next[prev] = s;
		}
	}
}

// Recast's dividePoly: splits polygon `src` (n vertices, 3 floats each) at
// value x on axis into a (<= x) and b (>= x) -> (na << 8) | nb.
//
// Ported to JavaScript from dividePoly in Recast/Source/RecastRasterization.cpp
// of Recast & Detour (https://github.com/recastnavigation/recastnavigation);
// altered: flat arrays, the counts packed into one return value. Its notice:
//
// Copyright (c) 2009-2010 Mikko Mononen memon@inside.org
//
// This software is provided 'as-is', without any express or implied
// warranty.  In no event will the authors be held liable for any damages
// arising from the use of this software.
// Permission is granted to anyone to use this software for any purpose,
// including commercial applications, and to alter it and redistribute it
// freely, subject to the following restrictions:
// 1. The origin of this software must not be misrepresented; you must not
//    claim that you wrote the original software. If you use this software
//    in a product, an acknowledgment in the product documentation would be
//    appreciated but is not required.
// 2. Altered source versions must be plainly marked as such, and must not be
//    misrepresented as being the original software.
// 3. This notice may not be removed or altered from any source distribution.
function divide(src, n, a, b, x, axis, d) {
	for (let i = 0; i < n; i++) d[i] = x - src[i * 3 + axis];
	let na = 0;
	let nb = 0;
	for (let i = 0, j = n - 1; i < n; j = i, i++) {
		const ina = d[j] >= 0;
		const inb = d[i] >= 0;
		if (ina !== inb) {
			const s = d[j] / (d[j] - d[i]);
			for (let c = 0; c < 3; c++) {
				const v = src[j * 3 + c] + (src[i * 3 + c] - src[j * 3 + c]) * s;
				a[na * 3 + c] = v;
				b[nb * 3 + c] = v;
			}
			na++;
			nb++;
			if (d[i] > 0) {
				a[na * 3] = src[i * 3];
				a[na * 3 + 1] = src[i * 3 + 1];
				a[na * 3 + 2] = src[i * 3 + 2];
				na++;
			} else if (d[i] < 0) {
				b[nb * 3] = src[i * 3];
				b[nb * 3 + 1] = src[i * 3 + 1];
				b[nb * 3 + 2] = src[i * 3 + 2];
				nb++;
			}
		} else {
			if (d[i] >= 0) {
				a[na * 3] = src[i * 3];
				a[na * 3 + 1] = src[i * 3 + 1];
				a[na * 3 + 2] = src[i * 3 + 2];
				na++;
				if (d[i] !== 0) continue;
			}
			b[nb * 3] = src[i * 3];
			b[nb * 3 + 1] = src[i * 3 + 1];
			b[nb * 3 + 2] = src[i * 3 + 2];
			nb++;
		}
	}
	return (na << 8) | nb;
}

// Records where polygon `p` (n vertices, 3 floats each: u, v, z) of a wall
// crosses the half-lines of column k, centre (cu, cv): the line v = cv
// (halves E, u >= cu, and W) and the line u = cu (S, v >= cv, and N). A
// crossing's whole z range goes to each half it touches.
function crossWalls(hf, k, p, n, cu, cv) {
	for (let axis = 1; axis >= 0; axis--) {
		const c = axis === 1 ? cv : cu; // the line's fixed coordinate
		const along = 1 - axis; // the coordinate along the line
		let lo = Infinity;
		let hi = -Infinity;
		let p0 = Infinity;
		let p1 = -Infinity;
		for (let i = 0, j = n - 1; i < n; j = i, i++) {
			const a = p[j * 3 + axis] - c;
			const b = p[i * 3 + axis] - c;
			let z;
			let at;
			if (a === 0) {
				z = p[j * 3 + 2];
				at = p[j * 3 + along];
			} else if ((a < 0 && b > 0) || (a > 0 && b < 0)) {
				const f = a / (a - b);
				z = p[j * 3 + 2] + (p[i * 3 + 2] - p[j * 3 + 2]) * f;
				at = p[j * 3 + along] + (p[i * 3 + along] - p[j * 3 + along]) * f;
			} else continue;
			if (z < lo) lo = z;
			if (z > hi) hi = z;
			if (at < p0) p0 = at;
			if (at > p1) p1 = at;
		}
		if (lo > hi) continue;
		const mid = axis === 1 ? cu : cv;
		// axis 1 (line v = cv): E / W; axis 0 (line u = cu): S / N.
		if (p1 >= mid) hf.addWall(k, axis === 1 ? HALF.E : HALF.S, lo, hi);
		if (p0 <= mid) hf.addWall(k, axis === 1 ? HALF.W : HALF.N, lo, hi);
	}
}

// The z range where polygon `p` meets either centre line of its column
// (centre cu, cv) -> out[0], out[1]; false when it meets neither.
function crossRange(p, n, cu, cv, out) {
	let lo = Infinity;
	let hi = -Infinity;
	for (let axis = 0; axis < 2; axis++) {
		const c = axis === 0 ? cu : cv;
		for (let i = 0, j = n - 1; i < n; j = i, i++) {
			const a = p[j * 3 + axis] - c;
			const b = p[i * 3 + axis] - c;
			let z;
			if (a === 0) z = p[j * 3 + 2];
			else if ((a < 0 && b > 0) || (a > 0 && b < 0)) z = p[j * 3 + 2] + ((p[i * 3 + 2] - p[j * 3 + 2]) * a) / (a - b);
			else continue;
			if (z < lo) lo = z;
			if (z > hi) hi = z;
		}
	}
	if (lo > hi) return false;
	out[0] = lo;
	out[1] = hi;
	return true;
}

const DEG = 180 / Math.PI;

// geom: { tris: Float32Array (wx, wy, z) x 3 per triangle, kind: Uint8Array }
function rasterise(geom, { col, row }) {
	const { tris, kind } = geom;
	const count = kind.length;
	const hf = new Heightfield(Math.max(1 << 16, Math.min(1 << 22, count * 2)));
	const west = (32 - col) * ADT;
	const north = (32 - row) * ADT;
	const inv = 1 / CELL;
	// Polygon buffers: a triangle clipped by 4 planes has at most 7 vertices.
	let poly = new Float64Array(36);
	let rest = new Float64Array(36);
	let rowPoly = new Float64Array(36);
	let rowRest = new Float64Array(36);
	const cellPoly = new Float64Array(36);
	const d = new Float64Array(12);
	for (let t = 0; t < count; t++) {
		const o = t * 9;
		// Local (u east, v south, z) in cells.
		const u0 = (west - tris[o + 1]) * inv;
		const v0 = (north - tris[o]) * inv;
		const u1 = (west - tris[o + 4]) * inv;
		const v1 = (north - tris[o + 3]) * inv;
		const u2 = (west - tris[o + 7]) * inv;
		const v2 = (north - tris[o + 6]) * inv;
		const vmin = Math.min(v0, v1, v2);
		const vmax = Math.max(v0, v1, v2);
		const umin = Math.min(u0, u1, u2);
		const umax = Math.max(u0, u1, u2);
		if (vmax < 0 || vmin >= TILE_CELLS || umax < 0 || umin >= TILE_CELLS) continue;
		// Slope from the world-space normal.
		const ax = tris[o + 3] - tris[o];
		const ay = tris[o + 4] - tris[o + 1];
		const az = tris[o + 5] - tris[o + 2];
		const bx = tris[o + 6] - tris[o];
		const by = tris[o + 7] - tris[o + 1];
		const bz = tris[o + 8] - tris[o + 2];
		const nx = ay * bz - az * by;
		const ny = az * bx - ax * bz;
		const nz = ax * by - ay * bx;
		const len = Math.sqrt(nx * nx + ny * ny + nz * nz);
		if (!(len > 1e-9)) continue;
		const slope = Math.min(90, Math.round(Math.acos(Math.min(1, Math.abs(nz) / len)) * DEG));
		const kd = kind[t];
		const wall = kd !== 0 && slope >= WALL_MIN;
		const steep = kd !== 0 && slope > WALK_MAX;
		poly[0] = u0;
		poly[1] = v0;
		poly[2] = tris[o + 2];
		poly[3] = u1;
		poly[4] = v1;
		poly[5] = tris[o + 5];
		poly[6] = u2;
		poly[7] = v2;
		poly[8] = tris[o + 8];
		let n = 3;
		const y0 = Math.max(-1, Math.min(TILE_CELLS - 1, Math.floor(vmin)));
		const y1 = Math.max(0, Math.min(TILE_CELLS - 1, Math.floor(vmax)));
		for (let y = y0; y <= y1; y++) {
			const r = divide(poly, n, rowPoly, rest, y + 1, 1, d);
			const nRow = r >> 8;
			n = r & 0xff;
			let tmp = poly;
			poly = rest;
			rest = tmp;
			if (nRow < 3 || y < 0) continue;
			let rmin = rowPoly[0];
			let rmax = rowPoly[0];
			for (let i = 1; i < nRow; i++) {
				const x = rowPoly[i * 3];
				if (x < rmin) rmin = x;
				if (x > rmax) rmax = x;
			}
			if (rmax < 0 || rmin >= TILE_CELLS) continue;
			const x0 = Math.max(-1, Math.min(TILE_CELLS - 1, Math.floor(rmin)));
			const x1 = Math.max(0, Math.min(TILE_CELLS - 1, Math.floor(rmax)));
			let m = nRow;
			for (let x = x0; x <= x1; x++) {
				const q = divide(rowPoly, m, cellPoly, rowRest, x + 1, 0, d);
				const nc = q >> 8;
				m = q & 0xff;
				tmp = rowPoly;
				rowPoly = rowRest;
				rowRest = tmp;
				if (nc < 3 || x < 0) continue;
				if (wall) {
					crossWalls(hf, y * TILE_CELLS + x, cellPoly, nc, x + 0.5, y + 0.5);
					continue;
				}
				let lo = cellPoly[2];
				let hi = cellPoly[2];
				if (steep) {
					if (!crossRange(cellPoly, nc, x + 0.5, y + 0.5, d)) continue;
					lo = d[0];
					hi = d[1];
				} else {
					for (let i = 1; i < nc; i++) {
						const z = cellPoly[i * 3 + 2];
						if (z < lo) lo = z;
						if (z > hi) hi = z;
					}
				}
				hf.add(y * TILE_CELLS + x, lo, hi, slope, kd, kd === 0 ? slope : 0);
			}
		}
	}
	return hf;
}

module.exports = { rasterise, Heightfield };
