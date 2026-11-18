'use strict';
// `nav city trails`: the aggregated trail layer that ships, from `nav city match`'s private density (<priv>/<uiMap>/).
// Only counts leave the build machine: per cell of 4.17 yd (128 per ADT tile, the walking maps' cells) the levels
// that 3+ distinct people walked (k-anonymity), each as a height (0.25 yd steps) and a weight class: 1 = 3-9 people,
// 2 = 10-49, 3 = 50+. No positions, times, sequences, sessions or contributors.
//
//   buildTrails({ priv, maps, grid, frames, train }) -> trails.json document:
//     { format: 1, k: 3, train, cells: 128, maps: { "<c>": { "<col>_<row>": [[i, j, z, w], ...] } } }
//     i east, j south within the tile (as the grid's columns), sorted by j, i, z; levels of one cell 3+ yd apart.
//     train: count only the people outside the gate's held-out fifth (a pack the gate may judge).
//   trailsLua(doc, header) -> Lua source of the trail tiles (Trails/Trails.lua: the addon namespace's PathTrails, read
//   by Routing/Path.lua's Path.TrailFloor).
//
// Tile strings: per entry a varint pair (little-endian base-128): v1 = (cell index delta from the previous entry,
// cell = j * 128 + i) * 4 + w; v2 = the zigzag of round(z * 4) minus the previous entry's (0 before the first): a
// city's levels sit at a few heights, so most entries take 2 bytes. A delta of 0 is another level of the same cell.

const fs = require('node:fs');
const path = require('node:path');
const { AreaGraph, CITIES } = require('./graph');
const F = require('../grid/format');

const K = 3;
const MERGE = 3; // yd: levels of one cell this close are one
const weightOf = (p) => (p >= 50 ? 3 : p >= 10 ? 2 : 1);

function buildTrails({ priv, maps = Object.keys(CITIES).map(Number), grid, frames, train = false }) {
	const doc = { format: 1, k: K, train, cells: 128, maps: {} };
	for (const map of maps) {
		const dir = path.join(priv, String(map));
		const g = AreaGraph.forMap(map, { grid, frames });
		const meta = JSON.parse(fs.readFileSync(path.join(dir, 'graph.json'), 'utf8'));
		if (meta.n !== g.n || meta.gi0 !== g.gi0 || meta.gj0 !== g.gj0) throw new Error(`${map}: ${dir} was matched on another grid`);
		const dens = fs.readFileSync(path.join(dir, 'density.bin'));
		const cells = new Map(); // "<col>_<row>" -> Map(cell -> [[z, people], ...])
		for (let v = 0; v < g.n; v++) {
			const p = dens.readUInt16LE(12 * v + (train ? 2 : 0));
			if (p < K) continue;
			const ci = g.ncol[v];
			const gi = g.gi0 + (ci % g.W);
			const gj = g.gj0 + Math.floor(ci / g.W);
			const ti = gi >> 1;
			const tj = gj >> 1;
			const key = `${ti >> 7}_${tj >> 7}`;
			const cell = (tj & 127) * 128 + (ti & 127);
			if (!cells.has(key)) cells.set(key, new Map());
			const m = cells.get(key);
			if (!m.has(cell)) m.set(cell, []);
			const lv = m.get(cell);
			const z = g.nz[v];
			const same = lv.find((x) => Math.abs(x[0] - z) <= MERGE);
			if (!same) lv.push([z, p]);
			else if (p > same[1]) {
				same[0] = z;
				same[1] = p;
			}
		}
		const out = (doc.maps[g.c] = doc.maps[g.c] || {});
		for (const [key, m] of cells) {
			const list = out[key] || (out[key] = []);
			for (const [cell, lv] of m) for (const [z, p] of lv) list.push([cell & 127, cell >> 7, Math.round(z * 4) / 4, weightOf(p)]);
		}
	}
	for (const tiles of Object.values(doc.maps)) for (const list of Object.values(tiles)) list.sort((a, b) => a[1] - b[1] || a[0] - b[0] || a[2] - b[2]);
	return doc;
}

function varint(x, bytes) {
	do {
		let b = x % 128;
		x = Math.floor(x / 128);
		if (x) b += 128;
		bytes.push(b);
	} while (x);
}

// One tile's entries as a Lua string literal.
function tileLiteral(list) {
	const bytes = [];
	let prev = 0;
	let prevQ = 0;
	const sorted = list.slice().sort((a, b) => a[1] - b[1] || a[0] - b[0] || a[2] - b[2]);
	for (const [i, j, z, w] of sorted) {
		const cell = j * 128 + i;
		varint((cell - prev) * 4 + w, bytes);
		prev = cell;
		const q = Math.round(z * 4);
		const dq = q - prevQ;
		prevQ = q;
		varint(dq >= 0 ? 2 * dq : -2 * dq - 1, bytes);
	}
	let s = '"';
	// decimal escapes always take 3 digits, so a digit after one never reads on
	for (const b of bytes) s += b >= 32 && b < 127 && b !== 34 && b !== 92 ? String.fromCharCode(b) : `\\${String(b).padStart(3, '0')}`;
	return s + '"';
}

function trailsLua(doc, header) {
	const lines = [header, '-- The capitals\' trail layer (Routing/Path.lua: Path.TrailFloor): per ADT tile "<col>_<row>" of each map its walked', '-- levels, aggregated from players\' recordings (3+ distinct people per level; only counts, no positions).', 'local _, ns = ...', 'ns.PathTrails = {'];
	for (const [c, tiles] of Object.entries(doc.maps)) {
		lines.push(`\t[${c}] = {`);
		for (const key of Object.keys(tiles).sort()) lines.push(`\t\t["${key}"] = ${tileLiteral(tiles[key])},`);
		lines.push('\t},');
	}
	lines.push('}', '');
	return lines.join('\n');
}

module.exports = { buildTrails, trailsLua, K, MERGE, CELLS: 128, TILE_YD: F.ADT };
