'use strict';
// Plain-language descriptions for the crafting guides (guide.js): where a
// material comes from, who sells a recipe and where, who trains a rank.
// Everything is read from the reference data (professions.json, npcs.json,
// zones.json, objects.json); the level bands of cloth, leather and
// disenchanted materials are Classic game knowledge (Forever keeps the loot
// tables' shape: humanoids drop the cloth of their level, beasts the leather).

const { homeMap } = require('./materials');
const { MINING_NODES, HERB_NODES, ZONES } = require('./gathering/tables');
const abundance = require('./gathering/abundance');

// A map with no spawn-pool table (gathering/node-abundance.json) keeps about this
// share of a node kind's spawn points up at once (the tables' median for veins).
const UP_PER_POINT = 0.14;

// The spawn-pool table of `map` ({ name: { up } }), or null: `data.nodeAbundance`
// (map -> table) stands in for the committed gathering/node-abundance.json (test fixtures).
function nodeTable(data, map) {
	return ((data && data.nodeAbundance) || abundance.load())[String(map)] || null;
}

// Nodes named `name` that `map` keeps up at once: the spawn-pool table's count,
// or `points` (the kind's spawn points there) x UP_PER_POINT for a map the table
// lacks. 0 when the map's table has no such node.
function nodesUp(data, map, name, points) {
	const t = nodeTable(data, map);
	if (!t) return points * UP_PER_POINT;
	return t[name] ? t[name].up : 0;
}

const SIDES = ['Alliance', 'Horde'];

function money(copper) {
	const c = Math.round(copper);
	const g = Math.floor(c / 10000);
	const s = Math.floor((c % 10000) / 100);
	const k = c % 100;
	const parts = [];
	if (g) parts.push(`${g}g`);
	if (s) parts.push(`${s}s`);
	if (k && g < 10) parts.push(`${k}c`);
	return parts.length ? parts.join(' ') : 'free';
}

// "a, b and c"
function list(items) {
	const xs = items.filter(Boolean);
	if (xs.length <= 1) return xs.join('');
	return `${xs.slice(0, -1).join(', ')} and ${xs[xs.length - 1]}`;
}

function article(word) {
	return /^[AEIOU]/i.test(word) ? `an ${word}` : `a ${word}`;
}

// Humanoids of these levels drop the cloth.
const CLOTH_LEVELS = {
	'Linen Cloth': [5, 20],
	'Wool Cloth': [15, 30],
	'Silk Cloth': [25, 45],
	'Mageweave Cloth': [35, 50],
	Runecloth: [45, 60],
};

// Beasts of these levels yield the leather or hide when skinned.
const HIDE_LEVELS = [
	{ re: /^Ruined Leather Scraps$/, min: 1, max: 15 },
	{ re: /^Light (Leather|Hide)$/, min: 5, max: 20 },
	{ re: /^Medium (Leather|Hide)$/, min: 18, max: 30 },
	{ re: /^Heavy (Leather|Hide)$/, min: 28, max: 40 },
	{ re: /^Thick (Leather|Hide)$/, min: 38, max: 50 },
	{ re: /^Rugged (Leather|Hide)$/, min: 48, max: 60 },
];

// Disenchanting an uncommon (green) item of these item levels gives the
// material (Classic's table; shards come mostly from rare items).
const DISENCHANT_LEVELS = [
	{ re: /^Strange Dust$/, min: 5, max: 20 },
	{ re: /^(Lesser|Greater) Magic Essence$/, min: 5, max: 15 },
	{ re: /^(Lesser|Greater) Astral Essence$/, min: 16, max: 25 },
	{ re: /^Soul Dust$/, min: 21, max: 30 },
	{ re: /^(Lesser|Greater) Mystic Essence$/, min: 26, max: 35 },
	{ re: /^Vision Dust$/, min: 31, max: 40 },
	{ re: /^(Lesser|Greater) Nether Essence$/, min: 36, max: 45 },
	{ re: /^Dream Dust$/, min: 41, max: 50 },
	{ re: /^(Lesser|Greater) Eternal Essence$/, min: 46, max: 60 },
	{ re: /^Illusion Dust$/, min: 51, max: 60 },
	{ re: /^Small Glimmering Shard$/, min: 16, max: 20 },
	{ re: /^Large Glimmering Shard$/, min: 21, max: 25 },
	{ re: /^Small Glowing Shard$/, min: 26, max: 30 },
	{ re: /^Large Glowing Shard$/, min: 31, max: 35 },
	{ re: /^Small Radiant Shard$/, min: 36, max: 40 },
	{ re: /^Large Radiant Shard$/, min: 41, max: 45 },
	{ re: /^Small Brilliant Shard$/, min: 46, max: 50 },
	{ re: /^Large Brilliant Shard$/, min: 51, max: 60 },
];

function zoneName(data, map) {
	const z = (data.zones || {})[map];
	return z && z.name ? z.name : null;
}

// "Name (Zone)" for an npc id, or null.
function npcPlace(data, id) {
	const n = (data.npcs || {})[id];
	if (!n) return null;
	const z = zoneName(data, homeMap(n));
	return z ? `${n.name} (${z})` : n.name;
}

// The npc ids of `ids` that stand on `map`, else [].
function onMap(data, ids, map) {
	return (ids || []).filter((id) => homeMap((data.npcs || {})[id]) === map);
}

// Zones (names) that keep the most of a node kind up at once (nodesUp), own side
// first; `include` (a map id: the zone a step marks) takes the last place when
// it is not among them, so the tip names the zone its arrow points to.
function nodeZones(data, objectIds, side, max = 3, include = null) {
	const counts = new Map();
	const seen = new Set(); // map|name: objects sharing a name (Mithril Deposit 2040 and 150079) count once
	for (const oid of objectIds || []) {
		const o = (data.objects || {})[oid];
		for (const [map, s] of Object.entries((o && o.spawns) || {})) {
			const z = ZONES[map];
			if (!z || seen.has(`${map}|${o.name}`)) continue;
			seen.add(`${map}|${o.name}`);
			const n = nodesUp(data, map, o.name, ((s && s.pts) || []).length + ((s && s.more) || []).length);
			if (n > 0) counts.set(Number(map), (counts.get(Number(map)) || 0) + n);
		}
	}
	const mine = side === 'Alliance' ? 'A' : 'H';
	const top = [...counts.entries()]
		.filter(([map]) => ZONES[map].side && ZONES[map].side.includes(mine))
		.sort((a, b) => b[1] - a[1] || a[0] - b[0])
		.slice(0, max);
	if (include != null && ZONES[include] && !top.some(([map]) => map === Number(include))) top.splice(max - 1, 1, [Number(include), 0]);
	return top
		.sort((a, b) => ZONES[a[0]].min - ZONES[b[0]].min || a[0] - b[0])
		.map(([map]) => `${zoneName(data, map)} (${ZONES[map].min}-${ZONES[map].max})`);
}

function nodeNames(data, ids) {
	const out = [];
	for (const id of ids || []) {
		const o = (data.objects || {})[id];
		if (o && o.name && !out.includes(o.name)) out.push(o.name);
	}
	return out;
}

// Skill a herb or vein asks for (gathering/tables.js), or null.
function nodeSkill(name) {
	if (HERB_NODES[name] != null) return HERB_NODES[name];
	if (MINING_NODES[name] != null) return MINING_NODES[name];
	return null;
}

// One sentence on where `item` comes from for `side`: `src` is the planner's
// sourceOf result, `m` the professions.json material. `zones: false` leaves out
// a node's zones (a step that marks the patch in the player's starting area);
// `marked` is the map that step marks (named among the zones).
function sourceText(data, item, m, src, side, { zones: withZones = true, marked = null } = {}) {
	const name = (m && m.name) || `item ${item}`;
	const each = m && m.buy > 0 ? money(m.buy / (m.buyCount || 1)) : null;
	switch (src.kind) {
		case 'vendor':
			return `sold by vendors${each ? ` for ${each} each` : ''}`;
		case 'limited':
			return `sold in limited stock by ${list((src.vendors || []).slice(0, 2).map((id) => npcPlace(data, id)))}${m && m.bop ? '' : ', or the Auction House'}`;
		case 'herb': {
			const node = nodeNames(data, m.gather.herb)[0] || name;
			const sk = nodeSkill(node);
			const zones = withZones ? nodeZones(data, m.gather.herb, side, 3, marked) : [];
			return `Herbalism: ${node}${sk != null ? ` (skill ${sk})` : ''}${zones.length ? ` in ${list(zones)}` : ''}; or the Auction House`;
		}
		case 'mine': {
			const node = nodeNames(data, m.gather.mine)[0] || name;
			const sk = nodeSkill(node);
			const zones = withZones ? nodeZones(data, m.gather.mine, side, 3, marked) : [];
			return `Mining: ${node}${sk != null ? ` (skill ${sk})` : ''}${zones.length ? ` in ${list(zones)}` : ''}; or the Auction House`;
		}
		case 'skinning': {
			const t = HIDE_LEVELS.find((h) => h.re.test(name));
			return t ? `Skinning: beasts of level ${t.min}-${t.max}; or the Auction House` : 'Skinning; or the Auction House';
		}
		case 'cloth': {
			const lv = CLOTH_LEVELS[name];
			return lv ? `humanoids of level ${lv[0]}-${lv[1]} drop it; or the Auction House` : 'humanoids drop it; or the Auction House';
		}
		case 'disenchant': {
			const t = DISENCHANT_LEVELS.find((h) => h.re.test(name));
			return `Enchanting: disenchant green items${t ? ` of item level ${t.min}-${t.max}` : ''}; or the Auction House`;
		}
		case 'fishing':
			return 'Fishing; or the Auction House';
		case 'crafted':
			return src.note.replace(/ \(or the Auction House\)$/, '; or the Auction House');
		case 'drop':
			return src.note.replace(/ \(or the Auction House\)$/, '; or the Auction House');
		default:
			return src.note;
	}
}

// The vendors of `item` in the main trainer's town of `side`: "Name" list, or [].
function townVendors(data, prof, item, m, side) {
	const main = prof.mainTrainer && prof.mainTrainer[side];
	const map = main != null ? homeMap((data.npcs || {})[main]) : null;
	if (map == null) return [];
	const ids = onMap(data, (m && m.vendors && m.vendors[side]) || [], map);
	return ids.map((id) => data.npcs[id].name).sort();
}

function mainTown(data, prof, side) {
	const main = prof.mainTrainer && prof.mainTrainer[side];
	const map = main != null ? homeMap((data.npcs || {})[main]) : null;
	return map != null ? zoneName(data, map) : null;
}

// "Name (Zone)" of each trainer of a rank on `side`, sorted by name; with `prof`, only those who
// train at the rank's skill (its `trainerSkill`: Doctor Herbert Halsey trains Alchemy from 125, #1708).
function rankTrainers(data, rank, side, prof) {
	const gates = (prof && prof.trainerSkill) || {};
	const ids = ((rank && rank.trainers && rank.trainers[side]) || []).filter((id) => gates[id] === undefined || Number(gates[id]) <= Number(rank.minSkill || 0));
	return [...new Set(ids.map((id) => npcPlace(data, id)).filter(Boolean))].sort();
}

module.exports = { SIDES, money, list, article, sourceText, townVendors, mainTown, rankTrainers, npcPlace, nodeZones, nodesUp, nodeTable, nodeNames, nodeSkill, CLOTH_LEVELS, HIDE_LEVELS, DISENCHANT_LEVELS, zoneName };
