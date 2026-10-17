'use strict';
// The cached Wowhead Forever facts the Codex reads: per entity, what its
// other release-safe inputs lack. Facts only (ids, numbers, coordinates);
// credited in THIRD_PARTY.md; provenance `wowhead`, below recordings and the
// client tables (docs/SUITE.md, "Data layer").
//
// Builds read what is cached in data/sources/wowhead/.
// No cache: empty facts, and the build goes on without them.
//
// <sources>/wowhead/codex/<type>/<id>.json, one entity each ({ notFound: true }
// for one Wowhead had not):
//   npc     name, level [lo, hi], classification (rare, rareelite, elite,
//           boss), boss (Wowhead's boss flag), location (AreaTable ids: an
//           instance's area for an NPC inside one), spawns { uiMap: [[x, y]] }
//           (map percent), drops [{ item, count, outof, common }] (count out
//           of the looted kills; common: the world-drop pool)
//   object  the same: spawns, location, drops (count out of the looted opens)
//   spell   usedBy (the NPCs that cast it: Duke Hydraxis's Create Aqual
//           Quintessence)
//   item    rep [{ faction, standing }] and pvpRank: the reputation and PvP
//           rank the item's tooltip asks for, or none
// <sources>/wowhead/codex/lists/<npc|object|item>.json, the list rows by id
// range ({ chunks: [{ lo, hi, rows }] }): id, name, location, and for NPCs
// level, classification, boss. `codex build` takes only the level of an NPC
// nothing else levels (a row is no page).
//
//   loadWowhead(sourcesDir) -> { npc: { id: facts }, object: {...}, item: {...}, spell: {...}, listed: { npc: { id: row }, ... } }
//   chanceOf(drop)          -> percent, 2 decimals
//   LOCALE_PATHS            Wowhead's path segment of each client language

const fs = require('node:fs');
const path = require('node:path');

const TYPES = ['npc', 'object', 'item', 'spell'];
const CODEX_LISTS = ['npc', 'object', 'item'];
// Wowhead's path segment of each client language (www.wowhead.com/forever/ru/...).
const LOCALE_PATHS = { deDE: 'de', esES: 'es', esMX: 'mx', frFR: 'fr', koKR: 'ko', ptBR: 'pt', ruRU: 'ru', zhCN: 'cn', zhTW: 'tw' };

// The cached pages; `listed` holds the list rows by type (the pages' own
// facts stay what the pages said: a row is no page, and parity's verdicts
// read only pages).
function loadWowhead(sourcesDir) {
	const out = { npc: {}, object: {}, item: {}, spell: {}, listed: {} };
	for (const type of TYPES) {
		const dir = path.join(sourcesDir, 'wowhead', 'codex', type);
		if (!fs.existsSync(dir)) continue;
		for (const f of fs.readdirSync(dir).sort()) {
			if (!f.endsWith('.json')) continue;
			const facts = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
			if (!facts.notFound) out[type][facts.id] = facts;
		}
	}
	for (const type of CODEX_LISTS) {
		const file = path.join(sourcesDir, 'wowhead', 'codex', 'lists', `${type}.json`);
		if (!fs.existsSync(file)) continue;
		const rows = (out.listed[type] = {});
		for (const c of JSON.parse(fs.readFileSync(file, 'utf8')).chunks || []) for (const r of c.rows || []) rows[r.id] = r;
	}
	return out;
}

function chanceOf(d) {
	return Math.round((d.count / d.outof) * 10000) / 100;
}

module.exports = { loadWowhead, chanceOf, LOCALE_PATHS };
