#!/usr/bin/env node
// Cuts the professions golden's inputs (not run in CI):
//   node slice.js <data/sources> <public data/forever> <out input dir>
// Professions kept: SKILLS (First Aid, Alchemy, Cooking, Mining); the other skill lines keep their
// SkillLine row and no abilities.
// - Forever 1.60.1.70450 and Classic Era 1.15.9.70003 client tables (wago.tools CSVs, rows verbatim):
//   SkillLine and SpellFocusObject whole; SkillLineAbility rows of SKILLS; the spell rows (SpellName,
//   SpellEffect, SpellReagents, SpellTotems, SpellCastingRequirements) of their spells and of the
//   spells that teach them; the item rows (ItemSparse, Item) of the items they make, use and need,
//   the tools of their tool categories and the recipe items that teach them; the ItemEffect and
//   ItemXItemEffect rows of those recipe items.
// - data/items.json: the public data build's items.json (pfQuest, MIT, + client tables) cut to those
//   items, their vendors and drops cut to the world slice's npcs and objects (the build reads no
//   others). npcs.json and objects.json are the world slice's (../world/root/data/forever), copied
//   next to it by the test and regen.sh.
// - sources/pfQuest/db/items.lua (MIT; LICENSE kept): pfQuest's entries for those items, each cut to
//   its vendor block (["V"], the stock limits the build reads), lines verbatim.
'use strict';
const fs = require('node:fs');
const path = require('node:path');

const SKILLS = new Set([129, 171, 185, 186]);
const ERA = '1.15.9.70003';
const FOREVER = '1.60.1.70450';
const TABLES = ['SkillLine', 'SkillLineAbility', 'SpellName', 'SpellEffect', 'SpellReagents', 'SpellTotems', 'SpellCastingRequirements', 'SpellFocusObject', 'ItemSparse', 'Item', 'ItemEffect', 'ItemXItemEffect'];

const [src, forever, out] = process.argv.slice(2);
if (!src || !forever || !out) throw new Error('usage: slice.js <data/sources> <public data/forever> <out input dir>');
const { parseCsv } = require(path.join(__dirname, '../../../../tools/lib/data/csv.js'));

const read = (f) => fs.readFileSync(f, 'utf8');
const write = (f, t) => {
	fs.mkdirSync(path.dirname(f), { recursive: true });
	fs.writeFileSync(f, t);
};
// CSV records (quoted fields may hold newlines) -> [text of each record].
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
// build -> table -> { header, rows: [{ row, text }] } (absent tables skipped).
const tables = {};
for (const b of [FOREVER, ERA]) {
	tables[b] = {};
	for (const t of TABLES) {
		const f = path.join(src, 'wago', b, `${t}.csv`);
		if (!fs.existsSync(f)) continue;
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

// The spells: SKILLS' abilities, and the spells that teach them (SpellEffect 36).
const spells = new Set();
each('SkillLineAbility', (r) => SKILLS.has(int(r.SkillLine)) && spells.add(int(r.Spell)));
const teach = new Set();
each('SpellEffect', (r) => int(r.Effect) === 36 && spells.has(int(r.EffectTriggerSpell)) && teach.add(int(r.SpellID)));
const allSpells = new Set([...spells, ...teach]);
// The items: made (Effect 24), reagents, tools and their categories' items, recipe items.
const items = new Set();
const cats = new Set();
each('SpellEffect', (r) => spells.has(int(r.SpellID)) && int(r.EffectItemType) > 0 && items.add(int(r.EffectItemType)));
each('SpellReagents', (r) => {
	if (!spells.has(int(r.SpellID))) return;
	for (let i = 0; i < 8; i++) if (int(r[`Reagent_${i}`]) > 0) items.add(int(r[`Reagent_${i}`]));
});
each('SpellTotems', (r) => {
	if (!spells.has(int(r.SpellID))) return;
	for (const i of [0, 1]) {
		if (int(r[`Totem_${i}`]) > 0) items.add(int(r[`Totem_${i}`]));
		if (int(r[`RequiredTotemCategoryID_${i}`]) > 0) cats.add(int(r[`RequiredTotemCategoryID_${i}`]));
	}
});
each('ItemSparse', (r) => cats.has(int(r.TotemCategoryID)) && items.add(int(r.ID)));
// Recipe item effects: TriggerType 6 teaches SpellID (Forever), else SpellID is a teaching spell.
const effects = new Map(); // build -> Set(ItemEffect ID)
for (const b of [FOREVER, ERA]) effects.set(b, new Set());
each('ItemEffect', (r, b) => {
	const s = int(r.SpellID);
	if ((int(r.TriggerType) === 6 && spells.has(s)) || teach.has(s)) {
		effects.get(b).add(int(r.ID));
		if (int(r.ParentItemID) > 0) items.add(int(r.ParentItemID));
	}
});
each('ItemXItemEffect', (r, b) => effects.get(b).has(int(r.ItemEffectID)) && items.add(int(r.ItemID)));

const keep = {
	SkillLine: () => true,
	SpellFocusObject: () => true,
	SkillLineAbility: (r) => SKILLS.has(int(r.SkillLine)),
	SpellName: (r) => allSpells.has(int(r.ID)),
	SpellEffect: (r) => allSpells.has(int(r.SpellID)),
	SpellReagents: (r) => allSpells.has(int(r.SpellID)),
	SpellTotems: (r) => allSpells.has(int(r.SpellID)),
	SpellCastingRequirements: (r) => allSpells.has(int(r.SpellID)),
	ItemSparse: (r) => items.has(int(r.ID)),
	Item: (r) => items.has(int(r.ID)),
	ItemEffect: (r, b) => effects.get(b).has(int(r.ID)),
	ItemXItemEffect: (r, b) => effects.get(b).has(int(r.ItemEffectID)),
};
for (const b of [FOREVER, ERA]) {
	for (const [t, { header, rows }] of Object.entries(tables[b])) {
		const kept = rows.filter(({ row }) => keep[t](row, b)).map((r) => r.text);
		write(path.join(out, 'sources', 'wago', b, `${t}.csv`), `${[header, ...kept].join('\n')}\n`);
	}
}

// items.json: one item per line, like the data build's; vendors and drops cut to the world slice's
// npcs and objects (the build reads no others).
const world = path.join(__dirname, '../world/root/data/forever');
const npcs = JSON.parse(read(path.join(world, 'npcs.json')));
const objects = JSON.parse(read(path.join(world, 'objects.json')));
const within = (o, set) => Object.fromEntries(Object.entries(o || {}).filter(([k]) => set[k]));
const all = JSON.parse(read(path.join(forever, 'items.json')));
const ids = Object.keys(all).filter((id) => items.has(Number(id)));
const cut = (it) => {
	const o = { ...it };
	if (o.vendors) o.vendors = o.vendors.filter((v) => npcs[v]);
	if (o.drops) o.drops = { ...o.drops, npc: within(o.drops.npc, npcs), object: within(o.drops.object, objects) };
	return o;
};
write(path.join(out, 'data', 'items.json'), `{\n${ids.map((id) => `${JSON.stringify(id)}:${JSON.stringify(cut(all[id]))}`).join(',\n')}\n}\n`);

// pfQuest db/items.lua: those items' entries, each cut to its vendor block (["V"], the stock limits).
const lines = read(path.join(src, 'pfQuest', 'db', 'items.lua')).split('\n');
const body = [];
let i = 1;
let keepIt = false;
let inV = false;
for (; i < lines.length; i++) {
	const l = lines[i];
	if (l === '}' || l === '') break;
	const m = /^ {2}\[(-?\d+)\] = (\{\},?)?/.exec(l);
	if (m) {
		keepIt = items.has(Number(m[1]));
		if (keepIt) body.push(m[2] ? l : `  [${m[1]}] = {`);
		inV = false;
		continue;
	}
	if (!keepIt) continue;
	if (/^ {4}\["V"\] = \{/.test(l)) inV = true;
	if (inV || /^ {2}\},?$/.test(l)) body.push(l);
	if (inV && /^ {4}\},?$/.test(l)) inV = false;
}
write(path.join(out, 'sources', 'pfQuest', 'db', 'items.lua'), `${[lines[0], ...body].join('\n')}\n${lines.slice(i).join('\n')}`);
fs.copyFileSync(path.join(src, 'pfQuest', 'LICENSE'), path.join(out, 'sources', 'pfQuest', 'LICENSE'));
console.log(`${spells.size} spells (+${teach.size} teaching), ${items.size} items, ${ids.length} in items.json`);
