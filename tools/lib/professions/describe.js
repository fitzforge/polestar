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

// "40 Woolen Capes", "14 Bolts of Linen Cloth", "17 Formal White Shirts"; a name that already reads as a
// plural (Gloves, Boots), a mass noun (Light Leather, Rough Blasting Powder), a fish ("52 Longjaw Mud
// Snapper", "40 Bristle Whisker Catfish") or an enchant ("Enchant Bracer - Minor Stamina") stays as it is.
function crafts(n, name) {
	if (n === 1 || / - /.test(name) || /^Enchant /.test(name)) return `${n} ${name}`;
	const one = (w) => (/s$/.test(w) ? w : /(x|ch|sh)$/.test(w) ? `${w}es` : /[^aeiou]y$/.test(w) ? `${w.slice(0, -1)}ies` : `${w}s`);
	const of = /^(\S+)( of .+)$/.exec(name);
	if (of) return `${n} ${one(of[1])}${of[2]}`;
	if (/(Leather|Cloth|Powder|Mail|fish|Snapper|Mackerel|Trout|Cod|Yellowtail|Salmon)$/.test(name)) return `${n} ${name}`;
	const words = name.split(' ');
	words[words.length - 1] = one(words[words.length - 1]);
	return `${n} ${words.join(' ')}`;
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

// The character levels ("Requires Level", the line the game shows) of the green armour that disenchants into
// a dust, essence or shard, or of green weapons when no armour gives it: data/disenchant.json (the client's
// disenchant bands by item level with the server's loot), the item level about five above the level asked.
// -> { min, max } or null.
const DISENCHANT = require('../../../data/disenchant.json');
function disenchantLevels(name) {
	const id = Number(Object.keys(DISENCHANT.names).find((k) => DISENCHANT.names[k] === name));
	if (!id) return null;
	const greens = (cls) => DISENCHANT.bands.filter((b) => b.class === cls && b.quality === 2 && b.loot.some((l) => l.item === id));
	const bands = greens(4).length ? greens(4) : greens(2);
	if (!bands.length) return null;
	const req = (ilvl) => Math.max(1, Math.min(60, ilvl - 5));
	return { min: req(Math.min(...bands.map((b) => b.ilvl[0]))), max: req(Math.max(...bands.map((b) => b.ilvl[1]))) };
}

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
// `marked` is the map that step marks (named among the zones). `market: false`
// leaves out "or the Auction House": a gather step whose Auction House goal is
// a step of its own (docs/GUIDE_FORMAT.md, "Materials").
function sourceText(data, item, m, src, side, { zones: withZones = true, marked = null, market = true } = {}) {
	const name = (m && m.name) || `item ${item}`;
	const each = m && m.buy > 0 ? money(m.buy / (m.buyCount || 1)) : null;
	const ah = market ? '; or the Auction House' : '';
	switch (src.kind) {
		case 'vendor':
			return `sold by vendors${each ? ` for ${each} each` : ''}`;
		case 'limited':
			return `sold in limited stock by ${list((src.vendors || []).slice(0, 2).map((id) => npcPlace(data, id)))}${m && m.bop ? '' : ', or the Auction House'}`;
		case 'herb': {
			const node = nodeNames(data, m.gather.herb)[0] || name;
			const sk = nodeSkill(node);
			const zones = withZones ? nodeZones(data, m.gather.herb, side, 3, marked) : [];
			return `Herbalism: ${node}${sk != null ? ` (skill ${sk})` : ''}${zones.length ? ` in ${list(zones)}` : ''}${ah}`;
		}
		case 'mine': {
			const node = nodeNames(data, m.gather.mine)[0] || name;
			const sk = nodeSkill(node);
			const zones = withZones ? nodeZones(data, m.gather.mine, side, 3, marked) : [];
			return `Mining: ${node}${sk != null ? ` (skill ${sk})` : ''}${zones.length ? ` in ${list(zones)}` : ''}${ah}`;
		}
		case 'skinning': {
			const t = HIDE_LEVELS.find((h) => h.re.test(name));
			return t ? `Skinning: beasts of level ${t.min}-${t.max}${ah}` : `Skinning${ah}`;
		}
		case 'cloth': {
			const lv = CLOTH_LEVELS[name];
			return lv ? `humanoids of level ${lv[0]}-${lv[1]} drop it${ah}` : `humanoids drop it${ah}`;
		}
		case 'disenchant': {
			const t = disenchantLevels(name);
			return `Enchanting: disenchant green armour${t ? ` that requires level ${t.min}-${t.max}` : ''}${ah}`;
		}
		case 'fishing':
			return `Fishing${ah}`;
		case 'crafted':
		case 'drop':
			return src.note.replace(/ \(or the Auction House\)$/, ah);
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

// Where a step's spell is on Forever's client, for its row: profession spells (a craft or smelt, Find Minerals,
// Find Herbs, Fishing, Disenchant) are in the Professions tab, class spells (Pick Lock) in the Spellbook. Each is one
// guide string, so the guide translations carry it (forge i18n guides sync).
const PROFESSIONS_TAB = 'Professions tab (K by default)';
const SPELLBOOK = 'Spellbook (P by default)';

// The where of a step from its goal lines (two-space indented), or null: a spell cast with no button of its own
// (`cast`: Find Minerals, Find Herbs), smelting, Fishing's casts, a disenchanting step, Lockpicking's skill (Pick
// Lock, a Rogue spell). Craft rows get none: the guide window gives them an "Open <profession>" button.
function spellWhere(title, goals) {
	if (goals.some((g) => /^ {2}skill Lockpicking /.test(g))) return `Pick Lock: ${SPELLBOOK}`;
	if (goals.some((g) => /^ {2}skill Fishing /.test(g)) || /^(Fish|Catch an?) /.test(title)) return `Fishing: ${PROFESSIONS_TAB}`;
	if (/^Disenchant /.test(title) || goals.some((g) => /^ {2}collect .* gather Enchanting\b/.test(g))) return `Disenchant: ${PROFESSIONS_TAB}`;
	if (goals.some((g) => /^ {2}cast /.test(g)) || (/^Smelt /.test(title) && goals.some((g) => /^ {2}craft /.test(g)))) return PROFESSIONS_TAB;
	return null;
}

// A profession guide's text with every spell step's row saying where the spell is ("Turn on Find Minerals ·
// Professions tab (K by default)"): the one place every profession and paired guide generator passes its text
// through, so a new guide gets it too.
function withSpellWhere(text) {
	const lines = text.split('\n');
	for (let i = 0; i < lines.length; i++) {
		if (!lines[i].startsWith('step ')) continue;
		const goals = [];
		for (let j = i + 1; j < lines.length && /^ {2}\S/.test(lines[j]); j++) goals.push(lines[j]);
		const where = spellWhere(lines[i].slice(5), goals);
		if (where && !lines[i].includes(where)) lines[i] = `${lines[i]} · ${where}`;
	}
	return lines.join('\n');
}

module.exports = { SIDES, money, list, article, crafts, sourceText, townVendors, mainTown, rankTrainers, npcPlace, nodeZones, nodesUp, nodeTable, nodeNames, nodeSkill, CLOTH_LEVELS, HIDE_LEVELS, disenchantLevels, zoneName, PROFESSIONS_TAB, SPELLBOOK, spellWhere, withSpellWhere };
