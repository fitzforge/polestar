'use strict';
// `maps build`: each zone's level range, computed from data/forever, ->
// addon/Polestar/Maps/ZoneLevels.lua. Same inputs give byte-identical output.
//
// Heuristic (what a player levelling there actually fights):
//   1. Samples are spawn points of NPCs that are friendly to neither faction
//      (npcs.json `faction` null: hostile or neutral creatures) and of normal
//      rank (`rank` absent: elites, rares, rare elites and bosses are not what
//      a zone is levelled on). Each spawn point weighs 1, spread evenly over
//      the NPC's level..levelMax.
//   2. Critters and stragglers go: samples more than CRITTER_GAP levels below
//      the zone's spawn-weighted median are dropped (level 1 rabbits in a
//      level 50 zone).
//   3. The range is the spawn-weighted P10..P90 of what is left, so a handful
//      of outliers at either end does not stretch it.
//   4. Zones without enough wildlife get no range: fewer than MIN_WEIGHT
//      hostile spawn points, or hostile spawns under MIN_SHARE of all NPC
//      spawn points there (capital cities, empty battleground maps).
//      Forever-only zones (`sparse`: maps with Forever frames and no Era
//      frames in map-frames.json) are thinly recorded in every source, so
//      they pass with SPARSE_MIN_WEIGHT and SPARSE_MIN_SHARE instead.
//   5. The label point (where the range is drawn on the continent map) is the
//      spawn-weighted median x and y of the kept samples, in zone map percent.

const fs = require('node:fs');
const path = require('node:path');
const { header } = require('../generated');

const { ROOT, DATA } = require('../paths');

const DEFAULTS = {
	low: 0.1,
	high: 0.9,
	critterGap: 15,
	minWeight: 100,
	minShare: 0.4,
	sparse: [], // uiMapIDs held to the sparse thresholds
	sparseMinWeight: 30,
	sparseMinShare: 0.2,
	zoneType: 3, // UiMap type 3: zone
};

// Spawn-weighted percentile of [[value, weight], ...] sorted by value.
function percentile(sorted, p) {
	let total = 0;
	for (const s of sorted) total += s[1];
	if (total <= 0) return null;
	let acc = 0;
	for (const s of sorted) {
		acc += s[1];
		if (acc >= p * total - 1e-9) return s[0];
	}
	return sorted[sorted.length - 1][0];
}

function byValue(a, b) {
	return a[0] - b[0];
}

function round1(n) {
	return Math.round(n * 10) / 10;
}

// npcs: npcs.json object; zones: zones.json object; opts: DEFAULTS overrides.
// -> { [uiMapID]: { id, name, min, max, x, y, weight } } for zones with a range.
function zoneLevels(npcs, zones, opts = {}) {
	const o = { ...DEFAULTS, ...opts };
	const levels = new Map(); // map -> [[level, weight]]
	const xs = new Map(); // map -> [[x, weight, level]]
	const ys = new Map();
	const all = new Map(); // map -> every NPC spawn point
	const hostile = new Map(); // map -> hostile spawn points
	const ids = Object.keys(npcs).map(Number).sort((a, b) => a - b);
	for (const id of ids) {
		const npc = npcs[id];
		const eligible = npc.faction == null && npc.rank == null && Number(npc.level) > 0;
		const lo = Number(npc.level);
		const hi = Math.max(lo, Number(npc.levelMax) || lo);
		for (const [mapKey, spawn] of Object.entries(npc.spawns || {})) {
			const map = Number(mapKey);
			const pts = (spawn && spawn.pts) || [];
			if (!pts.length) continue;
			all.set(map, (all.get(map) || 0) + pts.length);
			if (!eligible) continue;
			hostile.set(map, (hostile.get(map) || 0) + pts.length);
			if (!levels.has(map)) {
				levels.set(map, []);
				xs.set(map, []);
				ys.set(map, []);
			}
			const per = 1 / (hi - lo + 1);
			for (let l = lo; l <= hi; l++) levels.get(map).push([l, pts.length * per]);
			const mid = (lo + hi) / 2;
			for (const [x, y] of pts) {
				xs.get(map).push([x, 1, mid]);
				ys.get(map).push([y, 1, mid]);
			}
		}
	}

	const out = {};
	const sparse = new Set((o.sparse || []).map(Number));
	const zoneIds = Object.keys(zones).map(Number).sort((a, b) => a - b);
	for (const id of zoneIds) {
		const zone = zones[id];
		if (!zone || zone.type !== o.zoneType) continue;
		const weight = hostile.get(id) || 0;
		const share = weight / (all.get(id) || 1);
		const thin = sparse.has(id);
		if (weight < (thin ? o.sparseMinWeight : o.minWeight) || share < (thin ? o.sparseMinShare : o.minShare)) continue;
		const samples = levels.get(id).slice().sort(byValue);
		const median = percentile(samples, 0.5);
		const floor = median - o.critterGap;
		const kept = samples.filter((s) => s[0] >= floor);
		const min = percentile(kept, o.low);
		const max = percentile(kept, o.high);
		const keepPoint = (s) => s[2] >= floor;
		const px = xs.get(id).filter(keepPoint).sort(byValue);
		const py = ys.get(id).filter(keepPoint).sort(byValue);
		out[id] = {
			id,
			name: zone.name,
			min,
			max,
			x: round1(percentile(px, 0.5)),
			y: round1(percentile(py, 0.5)),
			weight: Math.round(weight),
		};
	}
	return out;
}

function emitLua(levels) {
	const lines = [];
	lines.push(header('lua', 'maps build', 'data/forever/npcs.json'));
	lines.push('-- Zone level ranges from data/forever/npcs.json (pfQuest, MIT): spawn-weighted');
	lines.push('-- P10..P90 of normal-rank creatures friendly to neither faction, critters more');
	lines.push('-- than 15 levels under the median dropped (tools/lib/maps/zonelevels.js).');
	lines.push('');
	lines.push('local ADDON, ns = ...');
	lines.push('local M = ns.Maps');
	lines.push('if not (M and M.RegisterZoneLevels) then return end');
	lines.push('');
	lines.push('M.RegisterZoneLevels({');
	lines.push('\t-- [uiMapID] = { minLevel, maxLevel, labelX, labelY } (label point in zone map percent)');
	for (const id of Object.keys(levels).map(Number).sort((a, b) => a - b)) {
		const z = levels[id];
		lines.push(`\t[${id}] = { ${z.min}, ${z.max}, ${z.x}, ${z.y} }, -- ${z.name.replace(/\n/g, ' ')}`);
	}
	lines.push('})');
	lines.push('');
	return lines.join('\n');
}

function readJson(file) {
	if (!fs.existsSync(file)) throw new Error(`missing ${file} (run: forge data build)`);
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

// Maps with Forever frames and no Era frames: the Forever-only zones.
function foreverOnly(frames) {
	const era = (frames && frames.era) || {};
	return Object.keys((frames && frames.forever) || {}).filter((id) => !(id in era)).map(Number).sort((a, b) => a - b);
}

function buildZoneLevels({ dataDir = DATA, ...opts } = {}) {
	const npcs = readJson(path.join(dataDir, 'npcs.json'));
	const zones = readJson(path.join(dataDir, 'zones.json'));
	const framesFile = path.join(dataDir, 'map-frames.json');
	const sparse = opts.sparse || (fs.existsSync(framesFile) ? foreverOnly(readJson(framesFile)) : []);
	const levels = zoneLevels(npcs, zones, { ...opts, sparse });
	return { levels, lua: emitLua(levels) };
}

module.exports = { zoneLevels, percentile, emitLua, buildZoneLevels, foreverOnly, DEFAULTS };
