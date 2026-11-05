'use strict';
// The cached Forever facts the Codex reads: per entity, what its
// other release-safe inputs lack. Facts only (ids, numbers, coordinates);
// credited in THIRD_PARTY.md; provenance `web`, below recordings and the
// client tables (docs/SUITE.md, "Data layer").
//
// Builds read what is cached in data/sources/web/.
// No cache: empty facts, and the build goes on without them.
//
// <sources>/web/codex/<type>/<id>.json, one entity each ({ notFound: true }
// for one the source had not):
//   npc     name, level [lo, hi], classification (rare, rareelite, elite,
//           boss), boss (the boss flag), location (AreaTable ids: an
//           instance's area for an NPC inside one), spawns { uiMap: [[x, y]] }
//           (map percent), drops [{ item, count, outof, common }] (count out
//           of the looted kills; common: the world-drop pool)
//   object  the same: spawns, location, drops (count out of the looted opens)
//   spell   usedBy (the NPCs that cast it: Duke Hydraxis's Create Aqual
//           Quintessence)
//   item    rep [{ faction, standing }] and pvpRank: the reputation and PvP
//           rank the item's tooltip asks for, or none
// <sources>/web/codex/lists/<npc|object|item>.json, the list rows by id
// range ({ chunks: [{ lo, hi, rows }] }): id, name, location, and for NPCs
// level, classification, boss. `codex build` takes only the level of an NPC
// nothing else levels (a row is no page).
//
//   loadWeb(sourcesDir)     -> { npc: { id: facts }, object: {...}, item: {...}, spell: {...}, listed: { npc: { id: row }, ... } }
//   chanceOf(drop)          -> percent, 2 decimals
//   LOCALE_PATHS            the path segment of each client language
//   isWebCitation(c)        c is a web quest database citation (below)
//   citationText(c)         -> a curated table's source (a citation or a
//                           URL) as report text ("Forever quest 7848")
//
// A citation of the web quest database in the curated tables
// (attunements.json, repgates.json, journal-quests.json): { edition:
// "forever" | "classic", kind: "quest" | "npc" | "item" | "object" | "zone" |
// "spell", id: <number> } or, for a guide page, { edition, kind: "guide",
// ref: "<slug>" }; `note` (optional) quotes or summarises the page.

const fs = require('node:fs');
const path = require('node:path');

const TYPES = ['npc', 'object', 'item', 'spell'];
const CODEX_LISTS = ['npc', 'object', 'item'];
// The URL path segment of each client language (.../forever/ru/...).
const LOCALE_PATHS = { deDE: 'de', esES: 'es', esMX: 'mx', frFR: 'fr', koKR: 'ko', ptBR: 'pt', ruRU: 'ru', zhCN: 'cn', zhTW: 'tw' };

// The cached pages; `listed` holds the list rows by type (the pages' own
// facts stay what the pages said: a row is no page, and parity's verdicts
// read only pages).
function loadWeb(sourcesDir) {
	const out = { npc: {}, object: {}, item: {}, spell: {}, listed: {} };
	for (const type of TYPES) {
		const dir = path.join(sourcesDir, 'web', 'codex', type);
		if (!fs.existsSync(dir)) continue;
		for (const f of fs.readdirSync(dir).sort()) {
			if (!f.endsWith('.json')) continue;
			const facts = JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
			if (!facts.notFound) out[type][facts.id] = facts;
		}
	}
	for (const type of CODEX_LISTS) {
		const file = path.join(sourcesDir, 'web', 'codex', 'lists', `${type}.json`);
		if (!fs.existsSync(file)) continue;
		const rows = (out.listed[type] = {});
		for (const c of JSON.parse(fs.readFileSync(file, 'utf8')).chunks || []) for (const r of c.rows || []) rows[r.id] = r;
	}
	return out;
}

function chanceOf(d) {
	return Math.round((d.count / d.outof) * 10000) / 100;
}

const EDITIONS = new Set(['forever', 'classic']);
const KINDS = new Set(['quest', 'npc', 'item', 'object', 'zone', 'spell']);

function isWebCitation(c) {
	if (!c || typeof c !== 'object' || Array.isArray(c) || !EDITIONS.has(c.edition)) return false;
	if (c.note !== undefined && typeof c.note !== 'string') return false;
	if (c.kind === 'guide') return typeof c.ref === 'string' && c.ref !== '' && c.id === undefined;
	return KINDS.has(c.kind) && Number.isInteger(c.id) && c.id > 0 && c.ref === undefined;
}

function citationText(c) {
	if (typeof c === 'string') return c;
	const edition = c.edition === 'classic' ? 'Classic' : 'Forever';
	const what = c.kind === 'guide' ? `guide "${c.ref}"` : `${c.kind} ${c.id}`;
	return `${edition} ${what}${c.note ? ` (${c.note})` : ''}`;
}

module.exports = { loadWeb, chanceOf, LOCALE_PATHS, isWebCitation, citationText };
