'use strict';
// Synthetic client geometry for the navigation grid's tests: a tile's
// triangle soup in the shape tools/lib/nav/geom tileGeometry returns, built
// in local yards (x east from the tile's west edge, y south from its north
// edge, z up).

const ADT = 1600 / 3;
const QUAD = ADT / 128;

class Scene {
	// areas: the tile's 256 chunk area ids (index (j >> 4) * 16 + (i >> 4), j along local y, i along local x), a
	// function (x, y) of a chunk's local centre, or null for none (the grid's areas are then 0); default area 1.
	constructor({ c = 0, col = 32, row = 32, height = () => 0, hole = () => false, areas = undefined } = {}) {
		this.areas = areas;
		this.c = c;
		this.col = col;
		this.row = row;
		this.west = (32 - col) * ADT;
		this.north = (32 - row) * ADT;
		this.tris = [];
		this.kind = [];
		this.liquid = { type: new Uint8Array(16384), z: new Float32Array(16384), deep: new Uint8Array(16384) };
		// Terrain: 128 x 128 quads, two triangles each.
		for (let qy = 0; qy < 128; qy++) {
			for (let qx = 0; qx < 128; qx++) {
				const x0 = qx * QUAD;
				const y0 = qy * QUAD;
				if (hole(x0 + QUAD / 2, y0 + QUAD / 2)) continue;
				const p = (x, y) => [x, y, height(x, y)];
				const a = p(x0, y0);
				const b = p(x0 + QUAD, y0);
				const cc = p(x0 + QUAD, y0 + QUAD);
				const d = p(x0, y0 + QUAD);
				this.tri(a, b, cc, 0);
				this.tri(a, cc, d, 0);
			}
		}
	}

	tri(a, b, c, kind) {
		for (const [x, y, z] of [a, b, c]) this.tris.push(this.north - y, this.west - x, z);
		this.kind.push(kind);
		return this;
	}

	quad(a, b, c, d, kind) {
		return this.tri(a, b, c, kind).tri(a, c, d, kind);
	}

	// A solid box (12 triangles).
	box(x0, y0, z0, x1, y1, z1, kind = 1) {
		const v = (x, y, z) => [x, y, z];
		const A = v(x0, y0, z0);
		const B = v(x1, y0, z0);
		const C = v(x1, y1, z0);
		const D = v(x0, y1, z0);
		const E = v(x0, y0, z1);
		const F = v(x1, y0, z1);
		const G = v(x1, y1, z1);
		const H = v(x0, y1, z1);
		return this.quad(A, B, C, D, kind).quad(E, F, G, H, kind).quad(A, B, F, E, kind).quad(B, C, G, F, kind).quad(C, D, H, G, kind).quad(D, A, E, H, kind);
	}

	// A flat floor plate at z.
	floor(x0, y0, x1, y1, z, kind = 2) {
		return this.quad([x0, y0, z], [x1, y0, z], [x1, y1, z], [x0, y1, z], kind);
	}

	// Liquid over quads covering [x0, x1] x [y0, y1] at height z (type 1 water, 2 ocean, 3 magma);
	// deep: fatigue water (MH2O's deep bit).
	water(x0, y0, x1, y1, z, type = 1, deep = false) {
		for (let qy = Math.floor(y0 / QUAD); qy < Math.ceil(y1 / QUAD); qy++) {
			for (let qx = Math.floor(x0 / QUAD); qx < Math.ceil(x1 / QUAD); qx++) {
				this.liquid.type[qy * 128 + qx] = type;
				this.liquid.z[qy * 128 + qx] = z;
				this.liquid.deep[qy * 128 + qx] = deep ? 1 : 0;
			}
		}
		return this;
	}

	// World point of local (x, y).
	world(x, y, z) {
		const p = { c: this.c, wx: this.north - y, wy: this.west - x };
		if (z !== undefined) p.z = z;
		return p;
	}

	geom() {
		return {
			c: this.c, col: this.col, row: this.row, tris: Float32Array.from(this.tris), kind: Uint8Array.from(this.kind),
			areas: this.chunkAreas(), liquid: this.liquid,
			stats: { terrainTris: 0, wmo: 0, wmoTris: 0, m2: 0, m2Tris: 0, holes: 0, missing: [] },
		};
	}

	chunkAreas() {
		if (this.areas === null) return undefined;
		if (this.areas === undefined) return new Uint16Array(256).fill(1);
		if (typeof this.areas !== 'function') return Uint16Array.from(this.areas);
		const span = ADT / 16;
		return Uint16Array.from({ length: 256 }, (_, ch) => this.areas(((ch & 15) + 0.5) * span, ((ch >> 4) + 0.5) * span));
	}
}

module.exports = { Scene, ADT, QUAD };
