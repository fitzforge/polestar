'use strict';
// Client geometry per ADT tile (docs/ARCHITECTURE.md, "Navigation grid"): terrain triangles, area ids and liquids
// from the root ADT, WMO and M2 collision and WMO liquids from the obj0
// placements, all in world yards (wx north, wy west, z up).
//
// Files come through the planner's CASC cache (tools/lib/planner/art/casc.js);
// the client tables (Map, LiquidType, LiquidMaterial, LiquidObject) from
// wago.tools for the same build, cached as <sources>/wago/<build>/<Table>.csv
// like tools/lib/data/wago.js does (<sources> is the CASC cache's root).
//
// Liquid kinds come from LiquidType.SoundBank, as TrinityCore's map_extractor
// (src/tools/map_extractor/System.cpp, LiqType[] from LiquidType SoundBank:
// 0 water, 1 ocean, 2 magma, 3 slime). Forever's PBR oceans
// (1250 "PBRWater - Generic - Ocean", Map.csv OceanLiquidTypeID of Azeroth
// and Kalimdor, and 1296 "PBRWater - Darkspear Islands - Ocean") carry
// SoundBank 0; they are the only rows with LiquidType.Flags & 0x400 in 1.60.1,
// so a water row with that flag is ocean. Fel liquids carry SoundBank 2
// (magma). A LiquidType whose LiquidMaterial has Flags & 0x2 (VisualOnly) is
// no liquid, as both TrinityCore extractors skip it (map_extractor
// System.cpp, vmap4_extractor vmapexport.cpp IsLiquidIgnored; the flag value
// from src/common/Collision/Maps/MapDefines.h LiquidMaterialFlags).

const path = require('node:path');
const { cachedTable } = require('../../data/wago');
const { chunks, parseRoot, terrainTriangles, ADT } = require('./adt');
const { parseMh2o } = require('./mh2o');
const { parsePlacements, placementMatrix, transformPoints, transformBox } = require('./place');
const { loadWmo } = require('./wmo');
const { parseM2 } = require('./m2');

const GRID = 64;
const KIND = { terrain: 0, wmoOutdoor: 1, wmoIndoor: 2, m2: 3 };
const LIQUID = { none: 0, water: 1, ocean: 2, magma: 3, slime: 4 };
const SOUND_BANK = [LIQUID.water, LIQUID.ocean, LIQUID.magma, LIQUID.slime];
const OCEAN_FLAG = 0x400;
const VISUAL_ONLY = 0x2; // LiquidMaterial.Flags

const num = (v) => Number(v) || 0;

// <sources> of a Casc (its dir is <sources>/casc/<product>/<build>).
const sourcesOf = (casc) => path.resolve(casc.dir, '..', '..', '..');

// Client table rows for casc's build: cached CSV, else fetched from wago.tools.
const tables = new Map(); // csv path -> Promise of rows
function wagoTable(casc, name) {
	const file = path.join(sourcesOf(casc), 'wago', casc.build, `${name}.csv`);
	if (!tables.has(file)) {
		const get = async (url) => {
			const res = await (casc.fetchImpl || globalThis.fetch)(url, { headers: { 'user-agent': 'polestar-nav' } });
			if (!res.ok) throw new Error(`GET ${url}: HTTP ${res.status}`);
			return res.text();
		};
		const p = cachedTable({ sourcesDir: sourcesOf(casc), build: casc.build, table: name, offline: casc.offline, get });
		tables.set(file, p);
		p.catch(() => tables.delete(file));
	}
	return tables.get(file);
}

// { kind(liquidType), lvf(liquidType, objectOrLvf) } from the liquid tables
// (one per build).
const liquids = new Map(); // <sources>/wago/<build> -> Promise of { kind, lvf }
function liquidInfo(casc) {
	const key = path.join(sourcesOf(casc), 'wago', casc.build);
	if (!liquids.has(key)) {
		const p = loadLiquids(casc);
		liquids.set(key, p);
		p.catch(() => liquids.delete(key));
	}
	return liquids.get(key);
}

async function loadLiquids(casc) {
	const [types, materials, objects] = await Promise.all(['LiquidType', 'LiquidMaterial', 'LiquidObject'].map((t) => wagoTable(casc, t)));
	const type = new Map(types.map((r) => [num(r.ID), r]));
	const material = new Map(materials.map((r) => [num(r.ID), r]));
	const typeOfObject = new Map(objects.map((r) => [num(r.ID), num(r.LiquidTypeID)]));
	const kinds = new Map();
	const kind = (id) => {
		if (!kinds.has(id)) {
			const r = type.get(id);
			if (!r) throw new Error(`LiquidType ${id}: not in LiquidType.csv (${casc.build})`);
			const k = SOUND_BANK[num(r.SoundBank)];
			if (!k) throw new Error(`LiquidType ${id}: SoundBank ${r.SoundBank} is none of water/ocean/magma/slime`);
			const m = material.get(num(r.MaterialID));
			if (m && num(m.Flags) & VISUAL_ONLY) kinds.set(id, LIQUID.none);
			else kinds.set(id, k === LIQUID.water && num(r.Flags) & OCEAN_FLAG ? LIQUID.ocean : k);
		}
		return kinds.get(id);
	};
	const lvf = (liquidType, objectOrLvf) => {
		if (objectOrLvf < 42) return objectOrLvf;
		const r = type.get(typeOfObject.get(objectOrLvf) || liquidType);
		const v = r && material.get(num(r.MaterialID));
		if (!v) throw new Error(`LiquidObject ${objectOrLvf} (LiquidType ${liquidType}): no LiquidMaterial vertex format`);
		return num(v.LVF);
	};
	return { kind, lvf };
}

// The travel of every transport the client animates (TransportAnimation:
// positions relative to the spawn per TransportID) -> Map id -> { rise:
// vertical span, sway: horizontal span } in yards.
async function transportTravel(casc) {
	const out = new Map();
	for (const r of await wagoTable(casc, 'TransportAnimation')) {
		const id = num(r.TransportID);
		const x = num(r.Pos_0);
		const y = num(r.Pos_1);
		const z = num(r.Pos_2);
		let t = out.get(id);
		if (!t) out.set(id, (t = { x0: x, x1: x, y0: y, y1: y, z0: z, z1: z }));
		t.x0 = Math.min(t.x0, x);
		t.x1 = Math.max(t.x1, x);
		t.y0 = Math.min(t.y0, y);
		t.y1 = Math.max(t.y1, y);
		t.z0 = Math.min(t.z0, z);
		t.z1 = Math.max(t.z1, z);
	}
	for (const [id, t] of out) out.set(id, { rise: t.z1 - t.z0, sway: Math.hypot(t.x1 - t.x0, t.y1 - t.y0) });
	return out;
}

// The top-level chunks of continent (Map ID) c's WDT, from Map.csv WdtFileDataID.
async function continentWdt(casc, c) {
	const row = (await wagoTable(casc, 'Map')).find((r) => num(r.ID) === c);
	if (!row) throw new Error(`Map ${c}: not in Map.csv (${casc.build})`);
	const wdt = num(row.WdtFileDataID);
	if (!wdt) throw new Error(`Map ${c} (${row.MapName_lang}): no WdtFileDataID`);
	return { fdid: wdt, chunks: chunks(await casc.get(wdt)) };
}

// -> [{ col, row, root, obj0, tex0 }] of every tile of continent (Map ID) c,
// from the WDT's MAID (8 u32 per tile, index row * 64 + col: root, obj0,
// obj1, tex0, lod, map texture, map normal, minimap).
async function continentTiles(casc, c) {
	const { fdid, chunks: top } = await continentWdt(casc, c);
	const maid = top.find((x) => x.tag === 'MAID');
	if (!maid || maid.data.length < GRID * GRID * 32) throw new Error(`Map ${c}: WDT ${fdid} has no full MAID`);
	const out = [];
	for (let i = 0; i < GRID * GRID; i++) {
		const root = maid.data.readUInt32LE(i * 32);
		if (root) out.push({ col: i % GRID, row: Math.floor(i / GRID), root, obj0: maid.data.readUInt32LE(i * 32 + 4), tex0: maid.data.readUInt32LE(i * 32 + 12) });
	}
	return out;
}

// -> the MPHD flags of continent c's WDT (0x4 | 0x80: 8-bit 'big' alpha maps).
async function continentFlags(casc, c) {
	const { fdid, chunks: top } = await continentWdt(casc, c);
	const mphd = top.find((x) => x.tag === 'MPHD');
	if (!mphd || mphd.data.length < 4) throw new Error(`Map ${c}: WDT ${fdid} has no MPHD`);
	return mphd.data.readUInt32LE(0);
}

// Growable triangle soup: 9 floats and a kind per triangle.
class Soup {
	constructor(tris = 1 << 16) {
		this.tris = new Float32Array(tris * 9);
		this.kind = new Uint8Array(tris);
		this.n = 0;
	}
	reserve(more) {
		if (this.n + more <= this.kind.length) return;
		let cap = this.kind.length;
		while (cap < this.n + more) cap *= 2;
		const t = new Float32Array(cap * 9);
		t.set(this.tris.subarray(0, this.n * 9));
		const k = new Uint8Array(cap);
		k.set(this.kind.subarray(0, this.n));
		this.tris = t;
		this.kind = k;
	}
	// Adds the triangles idx (into world points w) whose xy box meets box
	// [minX, minY, maxX, maxY]; kinds: one per triangle or a single number.
	add(w, idx, kinds, box) {
		this.reserve(idx.length / 3);
		const start = this.n;
		for (let t = 0, i = 0; i < idx.length; t++, i += 3) {
			const a = idx[i] * 3, b = idx[i + 1] * 3, c = idx[i + 2] * 3;
			const ax = w[a], bx = w[b], cx = w[c];
			if ((ax > box[2] && bx > box[2] && cx > box[2]) || (ax < box[0] && bx < box[0] && cx < box[0])) continue;
			const ay = w[a + 1], by = w[b + 1], cy = w[c + 1];
			if ((ay > box[3] && by > box[3] && cy > box[3]) || (ay < box[1] && by < box[1] && cy < box[1])) continue;
			const o = this.n * 9;
			const T = this.tris;
			T[o] = ax; T[o + 1] = ay; T[o + 2] = w[a + 2];
			T[o + 3] = bx; T[o + 4] = by; T[o + 5] = w[b + 2];
			T[o + 6] = cx; T[o + 7] = cy; T[o + 8] = w[c + 2];
			this.kind[this.n++] = typeof kinds === 'number' ? kinds : kinds[t];
		}
		return this.n - start;
	}
}

const overlaps = (aabb, box) => aabb[0] <= box[2] && aabb[3] >= box[0] && aabb[1] <= box[3] && aabb[4] >= box[1];

// Parsed model by fdid through cache (fdid -> Promise); a 404 resolves null.
function model(cache, fdid, load) {
	if (!cache.has(fdid))
		cache.set(
			fdid,
			load().catch((err) => {
				if (err.status === 404) return null;
				cache.delete(fdid);
				throw err;
			}),
		);
	return cache.get(fdid);
}

// The tile's geometry (the spec's tileGeometry shape) plus
//   wmoLiquid: [{ type: 1 water | 2 ocean | 3 magma | 4 slime, tris:
//     Float32Array (9 floats per triangle) }], the WMO liquid surfaces, one
//     entry per type present, triangles counter-clockwise seen from above;
//   placements: [{ type: 'wmo' | 'm2', fdid, uniqueId, first, count }], the
//     collision triangle range each placement added (a WMO appears, with the
//     same uniqueId, in every tile it touches).
// Model triangles (collision and liquid) are kept when their xy box meets the
// tile grown by `margin` yards (default 0); terrain triangles are
// counter-clockwise seen from above, collision triangles as the model
// stores them. opts.cache: Map fdid -> parsed WMO/M2, shared across tiles.
async function tileGeometry(casc, { c, col, row, root, obj0 }, { cache = new Map(), margin = 0 } = {}) {
	const [rootBuf, objBuf, liquid] = await Promise.all([casc.get(root), obj0 ? casc.get(obj0) : null, liquidInfo(casc)]);
	const terrain = parseRoot(rootBuf);
	const { tris: ttris, holes } = terrainTriangles(terrain.mcnk);
	const areas = new Uint16Array(256);
	for (const m of terrain.mcnk) areas[m.indexY * 16 + m.indexX] = m.areaId;
	const water = parseMh2o(terrain.mh2o, liquid);

	const box = [(31 - row) * ADT - margin, (31 - col) * ADT - margin, (32 - row) * ADT + margin, (32 - col) * ADT + margin];
	const soup = new Soup(ttris.length / 9 + (1 << 15));
	soup.tris.set(ttris);
	soup.n = ttris.length / 9;
	const stats = { terrainTris: soup.n, wmo: 0, wmoTris: 0, wmoLiquidTris: 0, m2: 0, m2Tris: 0, holes, missing: [] };
	const wet = new Soup(1 << 10);
	const missing = new Set();
	const placements = [];
	const get = (fdid) => casc.get(fdid);

	const { wmo, m2 } = objBuf ? parsePlacements(chunks(objBuf)) : { wmo: [], m2: [] };
	const wmoModels = await Promise.all(wmo.map((p) => model(cache, p.fdid, () => loadWmo(get, p.fdid, liquid.kind))));
	const m2Models = await Promise.all(m2.map((p) => model(cache, p.fdid, async () => parseM2(await get(p.fdid)))));
	const place = (type, p, mdl, m, aabb, kinds) => {
		const first = soup.n;
		const count = overlaps(aabb, box) ? soup.add(transformPoints(m, mdl.verts), mdl.idx, kinds, box) : 0;
		placements.push({ type, fdid: p.fdid, uniqueId: p.uniqueId, first, count });
		return count;
	};
	wmo.forEach((p, i) => {
		stats.wmo++;
		const mdl = wmoModels[i];
		if (!mdl) return missing.add(p.fdid);
		for (const g of mdl.missing) missing.add(g);
		const m = placementMatrix(p);
		stats.wmoTris += place('wmo', p, mdl, m, p.extents, mdl.kind);
		if (mdl.liquid.idx.length && overlaps(p.extents, box)) stats.wmoLiquidTris += wet.add(transformPoints(m, mdl.liquid.verts), mdl.liquid.idx, mdl.liquid.kind, box);
	});
	m2.forEach((p, i) => {
		stats.m2++;
		const mdl = m2Models[i];
		if (!mdl) return missing.add(p.fdid);
		if (!mdl.idx.length) return;
		const m = placementMatrix(p);
		stats.m2Tris += place('m2', p, mdl, m, transformBox(m, mdl.box), KIND.m2);
	});
	stats.missing = [...missing].sort((a, b) => a - b);
	const wmoLiquid = [];
	for (let type = LIQUID.water; type <= LIQUID.slime; type++) {
		let n = 0;
		for (let t = 0; t < wet.n; t++) if (wet.kind[t] === type) n++;
		if (!n) continue;
		const tris = new Float32Array(n * 9);
		let o = 0;
		for (let t = 0; t < wet.n; t++) {
			if (wet.kind[t] !== type) continue;
			tris.set(wet.tris.subarray(t * 9, t * 9 + 9), o);
			o += 9;
		}
		wmoLiquid.push({ type, tris });
	}
	return {
		c,
		col,
		row,
		tris: soup.tris.slice(0, soup.n * 9),
		kind: soup.kind.slice(0, soup.n),
		areas,
		liquid: water,
		wmoLiquid,
		stats,
		placements,
	};
}

module.exports = { continentTiles, continentFlags, tileGeometry, liquidInfo, transportTravel, KIND, LIQUID };
