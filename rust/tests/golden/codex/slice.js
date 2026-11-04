#!/usr/bin/env node
// Cuts the codex golden's client tables (not run in CI):
//   node slice.js <data/sources> <out input dir>
// Forever 1.60.1.70450 (the 16 tables `codex build` reads) and Classic Era 1.15.9.70003 (Item,
// ItemSparse, ItemEffect, Map) client tables, wago.tools CSV rows verbatim:
// - AreaTable: top-level areas plus the slice zones' sub-areas;
// - whole: SkillLine, Map, DungeonEncounter, LFGDungeons, MapDifficulty, ContentTuning,
//   Mount, BattlePetSpecies (small);
// - SkillLineAbility: the rows of SKILLS (First Aid, riding, companions);
// - the items: the world slice's items.json, the gear golden's ForeverLevelingBiS items, and the items that teach the first MOUNTS mounts and PETS pets
//   or SKILLS' spells; Item, ItemSparse, ItemEffect and ItemXItemEffect rows of those items;
// - SpellEffect and SpellName rows of SKILLS' spells, the mount and pet spells, the spells those items
//   cast and the spells they teach (SpellEffect 36).
'use strict';
const fs = require('node:fs');
const path = require('node:path');

const SKILLS = new Set([129, 777, 778]);
const MOUNTS = 10;
const PETS = 10;
const ERA = '1.15.9.70003';
const FOREVER = '1.60.1.70450';
const FOREVER_TABLES = ['Item', 'ItemSparse', 'ItemEffect', 'ItemXItemEffect', 'SpellEffect', 'SpellName', 'SkillLine', 'SkillLineAbility', 'Map', 'AreaTable', 'DungeonEncounter', 'LFGDungeons', 'MapDifficulty', 'ContentTuning', 'Mount', 'BattlePetSpecies'];
const ERA_TABLES = ['Item', 'ItemSparse', 'ItemEffect', 'Map'];
const WHOLE = new Set(['SkillLine', 'Map', 'DungeonEncounter', 'LFGDungeons', 'MapDifficulty', 'ContentTuning', 'Mount', 'BattlePetSpecies']);

const [src, out] = process.argv.slice(2);
if (!src || !out) throw new Error('usage: slice.js <data/sources> <out input dir>');
const golden = path.join(__dirname, '..');
const { parseCsv } = require(path.join(golden, '../../../tools/lib/data/csv.js'));

const read = (f) => fs.readFileSync(f, 'utf8');
const write = (f, t) => {
	fs.mkdirSync(path.dirname(f), { recursive: true });
	fs.writeFileSync(f, t);
};
function records(text) {
	const recs = [];
	let start = 0;
	let q = false;
	for (let i = 0; i < text.length; i++) {
		const c = text[i];
		if (c === '"') q = !q;
		else if (c === '\n' && !q) {
			recs.push(text.slice(start, i));
			start = i + 1;
		}
	}
	if (start < text.length) recs.push(text.slice(start));
	return recs;
}
const tables = { [FOREVER]: {}, [ERA]: {} };
for (const [b, list] of [[FOREVER, FOREVER_TABLES], [ERA, ERA_TABLES]]) {
	for (const t of list) {
		const f = path.join(src, 'wago', b, `${t}.csv`);
		const text = read(f);
		const recs = records(text).filter((r) => r !== '');
		const rows = parseCsv(text);
		if (rows.length !== recs.length - 1) throw new Error(`${f}: ${rows.length} rows, ${recs.length - 1} records`);
		tables[b][t] = { header: recs[0], rows: rows.map((row, i) => ({ row, text: recs[i + 1] })) };
	}
}
const int = (v) => Math.trunc(Number(v)) || 0;
const each = (t, fn) => {
	for (const b of [FOREVER, ERA]) for (const r of tables[b][t]?.rows || []) fn(r.row, b);
};

const items = new Set();
const ids = (f) => Object.keys(JSON.parse(read(f))).map(Number);
for (const id of ids(path.join(golden, 'world/root/data/forever/items.json'))) items.add(id);
for (const m of read(path.join(golden, 'gear/input/AddOns/ForeverLevelingBiS/Data/Items.lua')).matchAll(/^\[(\d+)\]=/gm)) items.add(Number(m[1]));

const spells = new Set();
each('SkillLineAbility', (r) => SKILLS.has(int(r.SkillLine)) && spells.add(int(r.Spell)));
tables[FOREVER].Mount.rows.slice(0, MOUNTS).forEach(({ row }) => spells.add(int(row.SourceSpellID)));
tables[FOREVER].BattlePetSpecies.rows.slice(0, PETS).forEach(({ row }) => spells.add(int(row.SummonSpellID)));
const teach = new Set();
each('SpellEffect', (r) => int(r.Effect) === 36 && spells.has(int(r.EffectTriggerSpell)) && teach.add(int(r.SpellID)));
// Items whose effect casts or teaches those spells.
const effectsOf = new Map(); // build -> Set(ItemEffect ID)
for (const b of [FOREVER, ERA]) effectsOf.set(b, new Set());
each('ItemEffect', (r, b) => {
	const s = int(r.SpellID);
	if (spells.has(s) || teach.has(s)) {
		effectsOf.get(b).add(int(r.ID));
		if (int(r.ParentItemID) > 0) items.add(int(r.ParentItemID));
	}
});
each('ItemXItemEffect', (r, b) => effectsOf.get(b).has(int(r.ItemEffectID)) && items.add(int(r.ItemID)));
// Every effect of the kept items, and the spells they cast.
const forever = new Set();
each('ItemXItemEffect', (r) => items.has(int(r.ItemID)) && forever.add(int(r.ItemEffectID)));
const keepEffect = (r, b) => (b === ERA ? items.has(int(r.ParentItemID)) : forever.has(int(r.ID)));
const allSpells = new Set([...spells, ...teach]);
each('ItemEffect', (r, b) => keepEffect(r, b) && allSpells.add(int(r.SpellID)));
const more = new Set();
each('SpellEffect', (r) => allSpells.has(int(r.SpellID)) && int(r.Effect) === 36 && more.add(int(r.EffectTriggerSpell)));
for (const s of more) allSpells.add(s);

// AreaTable: top-level areas (zones, cities, instances) plus the world slice's zones' sub-areas.
const ZONES = new Set([14, 17, 1637, 12, 1519]); // Durotar, the Barrens, Orgrimmar, Elwynn Forest, Stormwind City
const keep = {
	AreaTable: (r) => int(r.ParentAreaID) === 0 || ZONES.has(int(r.ParentAreaID)) || ZONES.has(int(r.ID)),
	SkillLineAbility: (r) => SKILLS.has(int(r.SkillLine)),
	Item: (r) => items.has(int(r.ID)),
	ItemSparse: (r) => items.has(int(r.ID)),
	ItemEffect: keepEffect,
	ItemXItemEffect: (r) => items.has(int(r.ItemID)),
	SpellEffect: (r) => allSpells.has(int(r.SpellID)),
	SpellName: (r) => allSpells.has(int(r.ID)),
};
for (const b of [FOREVER, ERA]) {
	for (const [t, { header, rows }] of Object.entries(tables[b])) {
		const kept = WHOLE.has(t) ? rows : rows.filter(({ row }) => keep[t](row, b));
		write(path.join(out, 'sources', 'wago', b, `${t}.csv`), `${[header, ...kept.map((r) => r.text)].join('\n')}\n`);
	}
}
console.log(`${items.size} items, ${allSpells.size} spells`);
