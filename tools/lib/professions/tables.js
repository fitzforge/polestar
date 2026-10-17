'use strict';
// Blizzard client tables (DB2 as CSV from wago.tools) that describe the
// professions, cached per build next to the map tables of `data build`
// (<sources>/wago/<build>/<Table>.csv; a cached build is immutable, so a
// present file is never fetched again).
//
// They are the Forever client's (`wow_classic_beta`, 1.60+; tools/lib/data/wago.js):
// Forever changed recipe skill thresholds, reagents and names from Classic
// Era (1.60.1.70425 against 1.15.9.70003: the thresholds of 597 of 1,265
// recipes, 127 reagent lists; issue #109). Classic Era only fills gaps:
//   - a table wago.tools has no Forever export of: SpellTotems,
//     SpellCastingRequirements and SpellFocusObject (tools and spell foci)
//     come whole from the newest Era build, with a warning;
//   - with `eraFill`, the rows the Forever client lacks (1.60.1.70425: eight
//     recipe spells such as the healing potions, which SkillLineAbility lists
//     but SpellName and SpellEffect do not, and ~5k items, as the Codex
//     found): Forever's rows win, Era's fill the spells and items it has none for.
//
// Columns used (inspected on wow_classic_beta 1.60.1.70425, 2026-10; where the
// Era client names them differently, extract.js reads both):
//   SkillLine            ID, DisplayName_lang, CategoryID (11 profession, 9 secondary)
//   SkillLineAbility     SkillLine, Spell, AcquireMethod (1 = known with the skill),
//                        TrivialSkillLineRankLow (yellow), TrivialSkillLineRankHigh (grey),
//                        MinSkillLineRank, NumSkillUps, RaceMasks_0 (Era RaceMask_0), ClassMask
//   SpellName            ID, Name_lang
//   SpellEffect          SpellID, DifficultyID, Effect (24 create item, 36 learn spell,
//                        53 enchant item, 118 skill), EffectItemType, EffectBasePointsF
//                        (Era: EffectBasePoints + EffectDieSides), EffectTriggerSpell,
//                        EffectMiscValue_0
//   SpellReagents        SpellID, Reagent_0..7, ReagentCount_0..7
//   SpellTotems          SpellID, Totem_0..1 (tools such as Blacksmith Hammer)
//   SpellCastingRequirements SpellID, RequiresSpellFocus -> SpellFocusObject (Anvil, Forge...)
//   ItemSparse           ID, Display_lang, BuyPrice, SellPrice, VendorStackCount,
//                        OverallQualityID, RequiredSkill, RequiredSkillRank, RequiredAbility,
//                        Bonding (1 = binds when picked up)
//   Item                 ID, ClassID (9 = recipe)
//   ItemEffect           ID, SpellID, TriggerType (6: teaches SpellID, Forever's recipe
//                        items; else SpellID is a teaching spell, Era's); the Era client
//                        names the item in ParentItemID, Forever in ItemXItemEffect
//   ItemXItemEffect      ItemEffectID, ItemID

const { pickBuild, cachedTable, tableUrl } = require('../data/wago');

const TABLES = [
	'SkillLine',
	'SkillLineAbility',
	'SpellName',
	'SpellEffect',
	'SpellReagents',
	'SpellTotems',
	'SpellCastingRequirements',
	'SpellFocusObject',
	'ItemSparse',
	'Item',
	'ItemEffect',
	'ItemXItemEffect',
];

// The tables that may come whole from Classic Era when the Forever build lacks them.
const ERA_FALLBACK = ['SpellTotems', 'SpellCastingRequirements', 'SpellFocusObject'];
// `eraFill`: per spell (a spell the Forever SpellEffect has is wholly Forever's) and per id.
const SPELL_ROWS = ['SpellEffect', 'SpellReagents', 'SpellTotems', 'SpellCastingRequirements'];
const ID_ROWS = ['SpellName', 'ItemSparse', 'Item', 'SpellFocusObject'];
// What fillFromEra reads from Era: never the skill lines, whose recipes and
// thresholds are Forever's alone.
const ERA_ROWS = [...SPELL_ROWS, ...ID_ROWS, 'ItemEffect'];

async function fetchText(fetchImpl, url) {
	const res = await fetchImpl(url, { headers: { 'user-agent': 'polestar-data-build' } });
	if (!res.ok) throw new Error(`GET ${url}: HTTP ${res.status}`);
	return res.text();
}

// Forever's rows, plus Era's for the spells and items Forever's have none of.
// `whole`: tables already read from Era entirely. -> tables
function fillFromEra(tables, era, whole = []) {
	const out = { ...tables };
	const own = (t) => tables[t] && era[t] && !whole.includes(t);
	const spells = new Set((tables.SpellEffect || []).map((r) => Number(r.SpellID)));
	for (const t of SPELL_ROWS) if (own(t)) out[t] = tables[t].concat(era[t].filter((r) => !spells.has(Number(r.SpellID))));
	for (const t of ID_ROWS) {
		if (!own(t)) continue;
		const ids = new Set(tables[t].map((r) => Number(r.ID)));
		out[t] = tables[t].concat(era[t].filter((r) => !ids.has(Number(r.ID))));
	}
	if (own('ItemEffect')) {
		const linked = new Set((tables.ItemXItemEffect || []).map((r) => Number(r.ItemID)));
		out.ItemEffect = tables.ItemEffect.concat(era.ItemEffect.filter((r) => Number(r.ParentItemID) > 0 && !linked.has(Number(r.ParentItemID))));
	}
	return out;
}

// `build` when given, else the newest build of `product` ("era", the default
// for the other tools that read client tables through here, or "forever", what
// `profession build` reads) wago.tools lists, else (offline, or wago.tools
// unreachable) the newest cached one holding every table that cannot fall back
// to Era. Forever only: a table in ERA_FALLBACK it lacks comes from Era, and
// `eraFill` also reads the newest Era build's tables and fills the rows
// Forever's lack (fillFromEra); `eraTables` returns what was read from Era,
// including its SkillLineAbility (which spells are Season of Discovery's,
// extract.js).
// -> { build, tables: { SkillLine: rows, ... }, urls, eraBuild?, eraTables?, warnings }
async function loadTables({ sourcesDir, build, offline = false, fetchImpl = globalThis.fetch, log = () => {}, tables = TABLES, product = 'era', eraFill = false }) {
	const forever = product === 'forever';
	const fallback = forever ? ERA_FALLBACK : [];
	const own = tables.filter((t) => !fallback.includes(t));
	const picked = await pickBuild({ sourcesDir, build, offline, fetchImpl, product, tables: own });
	const warnings = [...picked.warnings];
	const get = (url) => fetchText(fetchImpl, url);
	let era = null;
	const eraBuild = async () => {
		if (!era) {
			const needed = (eraFill ? [...ERA_ROWS, 'SkillLineAbility'] : ERA_FALLBACK).filter((t) => tables.includes(t));
			era = await pickBuild({ sourcesDir, offline, fetchImpl, product: 'era', tables: needed });
			warnings.push(...era.warnings);
		}
		return era.build;
	};
	const out = {};
	const urls = {};
	const whole = [];
	for (const t of tables) {
		try {
			out[t] = await cachedTable({ sourcesDir, build: picked.build, table: t, offline, get, log });
			urls[t] = tableUrl(t, picked.build);
		} catch (err) {
			if (!fallback.includes(t)) throw err;
			const b = await eraBuild();
			out[t] = await cachedTable({ sourcesDir, build: b, table: t, offline, get, log });
			urls[t] = tableUrl(t, b);
			whole.push(t);
			warnings.push(`${t}: no Forever ${picked.build} table (${err.message}); read Classic Era ${b}`);
		}
	}
	let result = out;
	let eraTables;
	if (eraFill && forever) {
		const b = await eraBuild();
		eraTables = {};
		for (const t of tables) {
			if (!(ERA_ROWS.includes(t) || t === 'SkillLineAbility') || whole.includes(t)) continue;
			eraTables[t] = await cachedTable({ sourcesDir, build: b, table: t, offline, get, log });
		}
		result = fillFromEra(out, eraTables, whole);
	}
	return { build: picked.build, tables: result, urls, ...(era ? { eraBuild: era.build } : {}), ...(eraTables ? { eraTables } : {}), warnings };
}

module.exports = { loadTables, fillFromEra, TABLES, ERA_FALLBACK };
