'use strict';
// Solid spans -> a column's entries (format.js TILE): every span top, with
// the gap above it (`ceil`), walkable when its slope is at most CLIMB_MAX
// (terrain) or WALK_MAX (WMO and M2 surfaces; steeper terrain is STEEP)
// and the gap is at least AGENT_HEIGHT (else BLOCKED). Liquids (MH2O, per
// quad of 2 x 2 columns): the entry whose gap holds the liquid's surface is
// its floor; water or ocean at least SWIM_DEPTH above the floor (or with no
// floor) turns it into a swim surface at the liquid's height; magma and slime
// block their floor at any depth. Fatigue water (MH2O's deep quads,
// geom/mh2o.js) is a swim surface that is BLOCKED (SWIM | BLOCKED): never
// swum, by the route search or the packed maps (decided 2026-10-15, the
// owner: never route across open sea). Each entry keeps the steepest
// terrain triangle of its span (`tslope`) when its surface is terrain, 0 on
// model and swim surfaces (the walking maps' slope classes; decided
// 2026-10-16: column-to-column gradients 2.08 yd apart read 32-60° on a face
// of 51-56° triangles, Raptor Horns in the Barrens).

const {
	COLUMNS, WALK_MAX, CLIMB_MAX, AGENT_HEIGHT, SWIM_DEPTH, FLAG, MAX_LAYERS,
} = require('./format');
const { rasterise } = require('./rasterise');

const KIND_FLAGS = [FLAG.TERRAIN, FLAG.WMO, FLAG.WMO | FLAG.INDOOR, FLAG.M2];
const LIQUID = { NONE: 0, WATER: 1, OCEAN: 2, MAGMA: 3, SLIME: 4 };

// hf: rasterise()'s Heightfield; geom: tileGeometry's { c, col, row, areas,
// liquid, wmoLiquid? } -> { tile (format.js TILE without links, plus walls:
// format.js wallIndex), stats: { entries, walkable, swim, dropped } }
// WMO liquids (city canals, the forge's lava) are rasterised like the
// collision; each column takes the highest liquid surface over it and
// applies it as MH2O's.
function buildSurfaces(hf, geom) {
	const wmoLiquid = wmoLiquidColumns(geom);
	const count = new Uint8Array(COLUMNS);
	let cap = Math.max(1 << 16, hf.used + 4096);
	let z = new Float32Array(cap);
	let ceil = new Float32Array(cap);
	let flags = new Uint8Array(cap);
	let slope = new Uint8Array(cap);
	let tslope = new Uint8Array(cap);
	let n = 0;
	let dropped = 0;
	let walkable = 0;
	let swim = 0;
	const liquid = geom.liquid || null;
	// Scratch for one column.
	const cz = new Float32Array(256);
	const cc = new Float32Array(256);
	const cf = new Uint8Array(256);
	const cs = new Uint8Array(256);
	const ct = new Uint8Array(256);
	for (let k = 0; k < COLUMNS; k++) {
		let m = 0;
		let firstBottom = Infinity;
		for (let s = hf.head[k]; s !== -1; s = hf.next[s]) {
			if (m === 0) firstBottom = hf.smin[s];
			if (m === cz.length) break;
			const nx = hf.next[s];
			const top = hf.smax[s];
			const gap = nx === -1 ? Infinity : hf.smin[nx];
			const sl = hf.slope[s];
			let f = KIND_FLAGS[hf.kind[s]] || 0;
			if (sl > WALK_MAX) f |= FLAG.STEEP;
			if (sl > (hf.kind[s] === 0 ? CLIMB_MAX : WALK_MAX) || gap - top < AGENT_HEIGHT) f |= FLAG.BLOCKED;
			cz[m] = top;
			cc[m] = gap;
			cf[m] = f;
			cs[m] = sl;
			ct[m] = hf.kind[s] === 0 ? hf.tslope[s] : 0;
			m++;
		}
		const apply = (type, lz, deep = 0) => {
			// The floor: the highest entry whose gap holds the liquid surface.
			let e = -1;
			for (let x = m - 1; x >= 0; x--) {
				if (cz[x] <= lz && lz <= cc[x]) {
					e = x;
					break;
				}
			}
			if (type === LIQUID.MAGMA || type === LIQUID.SLIME) {
				if (e >= 0 && lz > cz[e]) cf[e] |= FLAG.BLOCKED;
			} else if (e >= 0) {
				if (lz - cz[e] >= SWIM_DEPTH) {
					cz[e] = lz;
					cs[e] = 0;
					ct[e] = 0;
					cf[e] = (cf[e] & (FLAG.INDOOR | FLAG.WMO | FLAG.M2 | FLAG.TERRAIN)) | FLAG.SWIM | (type === LIQUID.OCEAN ? FLAG.OCEAN : 0) | (deep ? FLAG.BLOCKED : 0);
				}
			} else if (m === 0 || lz < firstBottom) {
				// No floor under the liquid: a swim surface below every span.
				for (let x = m; x > 0; x--) {
					cz[x] = cz[x - 1];
					cc[x] = cc[x - 1];
					cf[x] = cf[x - 1];
					cs[x] = cs[x - 1];
					ct[x] = ct[x - 1];
				}
				cz[0] = lz;
				cc[0] = m ? firstBottom : Infinity;
				cf[0] = FLAG.SWIM | (type === LIQUID.OCEAN ? FLAG.OCEAN : 0) | (deep ? FLAG.BLOCKED : 0);
				cs[0] = 0;
				ct[0] = 0;
				m++;
			}
		};
		if (liquid) {
			const q = ((k >> 8) >> 1) * 128 + ((k & 255) >> 1);
			if (liquid.type[q] !== LIQUID.NONE) apply(liquid.type[q], liquid.z[q], liquid.deep ? liquid.deep[q] : 0);
		}
		if (wmoLiquid && wmoLiquid.type[k] !== LIQUID.NONE) apply(wmoLiquid.type[k], wmoLiquid.z[k]);
		if (m > MAX_LAYERS) {
			dropped += m - MAX_LAYERS;
			m = MAX_LAYERS;
		}
		if (n + m > cap) {
			cap *= 2;
			const grow = (Ctor, old) => {
				const a = new Ctor(cap);
				a.set(old);
				return a;
			};
			z = grow(Float32Array, z);
			ceil = grow(Float32Array, ceil);
			flags = grow(Uint8Array, flags);
			slope = grow(Uint8Array, slope);
			tslope = grow(Uint8Array, tslope);
		}
		for (let x = 0; x < m; x++) {
			z[n] = cz[x];
			ceil[n] = cc[x];
			flags[n] = cf[x];
			slope[n] = cs[x];
			tslope[n] = ct[x];
			if (!(cf[x] & FLAG.BLOCKED)) walkable++;
			if (cf[x] & FLAG.SWIM) swim++;
			n++;
		}
		count[k] = m;
	}
	const areas = new Uint16Array(256);
	if (geom.areas) areas.set(geom.areas);
	const tile = {
		c: geom.c, col: geom.col, row: geom.row, n, count,
		z: z.slice(0, n), ceil: ceil.slice(0, n), flags: flags.slice(0, n), slope: slope.slice(0, n), tslope: tslope.slice(0, n), areas,
		walls: hf.walls(),
	};
	let first = 0;
	tile.first = new Uint32Array(COLUMNS + 1);
	for (let k = 0; k < COLUMNS; k++) {
		tile.first[k] = first;
		first += count[k];
	}
	tile.first[COLUMNS] = first;
	return { tile, stats: { entries: n, walkable, swim, dropped } };
}

// The WMO liquid over each column: { type: Uint8Array(COLUMNS), z: Float32Array(COLUMNS) }
// (the highest surface; null without WMO liquids).
function wmoLiquidColumns(geom) {
	const list = geom.wmoLiquid || [];
	if (!list.length) return null;
	const type = new Uint8Array(COLUMNS);
	const z = new Float32Array(COLUMNS).fill(-Infinity);
	for (const { type: ty, tris } of list) {
		if (!tris || !tris.length) continue;
		const hf = rasterise({ tris, kind: new Uint8Array(tris.length / 9) }, geom);
		for (let k = 0; k < COLUMNS; k++) {
			let top = -Infinity;
			for (let s = hf.head[k]; s !== -1; s = hf.next[s]) top = hf.smax[s];
			if (top > z[k]) {
				z[k] = top;
				type[k] = ty;
			}
		}
	}
	return { type, z };
}

module.exports = { buildSurfaces, wmoLiquidColumns, LIQUID };
