#!/usr/bin/env node
// Cuts the knowledge-base golden's own inputs (not run in CI):
//   node slice.js <data/sources> <out input dir> [eg]
// `eg`: only the EG Link output (a pin move), leaving the other inputs as they are.
// The ids are the data golden's (../data/slice-ids.json: quests, units, objects, items of Durotar,
// Elwynn Forest and Ragefire Chasm).
// - sources/forever-tdb/extract.json: the Forever TrinityCore world DB extract (advocaite/TrinityCore
//   `forever`, GPL-2.0, used as facts): its quests, spawns, names, loot, vendors and trainers cut to
//   the ids; the class training tables (training, trainingSpells, trainingDropped, riding) whole.
// - sources/eg-link/<commit>/: the EG Link output (Efficient Games, CC BY 4.0): index.json cut to the
//   three newest builds of each product (EG_BUILDS: wowf, the live game, and wow_classic_beta), their
//   datasets cut to the ids (quest records, scans, turn-ins, prerequisites and objective progress of
//   the quests; the npcs and objects; loot of the units, objects and items).
// - sources/wago/1.15.9.70003/QuestXP.csv verbatim; sources/wago/1.60.1.70450/{Item,SpellName}.csv cut to the
//   items and the extract's class training spells (Blizzard client tables, rows verbatim).
'use strict';
const fs = require('node:fs');
const path = require('node:path');

const EG = '156f29c9af78';
// The three newest of each product.
const EG_BUILDS = { wowf: ['1.60.1.70790', '1.60.1.70840', '1.60.1.70862'], wow_classic_beta: ['1.60.1.70425', '1.60.1.70450', '1.60.1.70532'] };
const [src, out, only] = process.argv.slice(2);
if (!src || !out || (only && only !== 'eg')) throw new Error('usage: slice.js <data/sources> <out input dir> [eg]');
const ids = JSON.parse(fs.readFileSync(path.join(__dirname, '../data/slice-ids.json'), 'utf8'));
const Q = new Set(ids.quests.map(String));
const U = new Set(ids.units.map(String));
const O = new Set(ids.objects.map(String));
const I = new Set(ids.items.map(String));
const read = (f) => JSON.parse(fs.readFileSync(f, 'utf8'));
const write = (f, v) => {
	fs.mkdirSync(path.dirname(f), { recursive: true });
	fs.writeFileSync(f, typeof v === 'string' ? v : `${JSON.stringify(v)}\n`);
};
const pick = (o, set) => Object.fromEntries(Object.entries(o || {}).filter(([k]) => set.has(k)));
const byKind = (o) => ({ ...o, npc: pick(o.npc, U), object: pick(o.object, O) });

// Forever TDB extract.
if (only !== 'eg') {
	const tdb = read(path.join(src, 'forever-tdb', 'extract.json'));
	const cutTdb = { ...tdb, quests: pick(tdb.quests, Q), spawns: byKind(tdb.spawns), names: byKind(tdb.names), loot: byKind(tdb.loot), vendors: pick(tdb.vendors, U), trainers: pick(tdb.trainers, U) };
	write(path.join(out, 'sources', 'forever-tdb', 'extract.json'), `${JSON.stringify(cutTdb)}\n`);
}

// EG Link output.
const eg = path.join(src, 'eg-link', EG);
const egOut = path.join(out, 'sources', 'eg-link', EG);
fs.mkdirSync(egOut, { recursive: true });
const index = read(path.join(eg, 'index.json'));
for (const [p, builds] of Object.entries(EG_BUILDS)) index.products[p] = pick(index.products[p], new Set(builds));
for (const p of Object.keys(index.products)) if (!EG_BUILDS[p]) delete index.products[p];
write(path.join(egOut, 'index.json'), `${JSON.stringify(index, null, 1)}\n`);
const key = (k) => {
	const [kind, id] = k.split(':');
	return (kind === 'npc' && U.has(id)) || (kind === 'object' && O.has(id)) || (kind === 'item' && I.has(id));
};
const cut = {
	'quests.enUS': (d) => ({ ...d, quests: pick(d.quests, Q) }),
	quest_scan: (d) => ({ ...d, described: pick(d.described, Q), pushable: pick(d.pushable, Q), repeatable: pick(d.repeatable, Q), frequency: pick(d.frequency, Q), noData: (d.noData || []).filter((q) => Q.has(String(q))) }),
	turn_ins: (d) => ({ ...d, quests: pick(d.quests, Q), withLegacy: pick(d.withLegacy, Q) }),
	npcs: (d) => ({ ...d, approached: pick(d.approached, O), npcs: pick(d.npcs, U), objects: pick(d.objects, O) }),
	loot: (d) => ({ ...d, kills: Object.fromEntries(Object.entries(d.kills || {}).filter(([k]) => key(k))), sources: Object.fromEntries(Object.entries(d.sources || {}).filter(([k]) => key(k))), rolls: Object.fromEntries(Object.entries(d.rolls || {}).filter(([k]) => key(k))) }),
	quest_prerequisites: (d) => ({ ...d, quests: pick(d.quests, Q) }),
	objectives: (d) => ({ ...d, quests: pick(d.quests, Q), completed: pick(d.completed, Q), failed: pick(d.failed, Q), gossip: pick(d.gossip, Q) }),
};
for (const [p, builds] of Object.entries(EG_BUILDS)) {
	const product = path.join(eg, p);
	for (const b of builds) {
		for (const f of fs.readdirSync(path.join(product, b))) {
			const name = f.replace(/\.json$/, '');
			if (!cut[name]) throw new Error(`eg-link ${p}/${b}/${f}: no cut for it`);
			write(path.join(egOut, p, b, f), cut[name](read(path.join(product, b, f))));
		}
	}
}
if (only === 'eg') process.exit(0);

for (const f of ['wago/1.15.9.70003/QuestXP.csv']) {
	fs.mkdirSync(path.dirname(path.join(out, 'sources', f)), { recursive: true });
	fs.copyFileSync(path.join(src, f), path.join(out, 'sources', f));
}

// Forever client Item (the items) and SpellName (the class training spells of the extract), rows verbatim.
const { parseCsv } = require(path.join(__dirname, '../../../../tools/lib/data/csv.js'));
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
	return recs.filter((r) => r !== '');
}
const spells = new Set();
for (const per of Object.values(read(path.join(src, 'forever-tdb', 'extract.json')).trainingSpells || {})) for (const list of Object.values(per)) for (const [s] of list) spells.add(String(s));
for (const [t, set] of [['Item', I], ['SpellName', spells]]) {
	const f = path.join(src, 'wago', '1.60.1.70450', `${t}.csv`);
	const text = fs.readFileSync(f, 'utf8');
	const recs = records(text);
	const rows = parseCsv(text);
	if (rows.length !== recs.length - 1) throw new Error(`${f}: ${rows.length} rows, ${recs.length - 1} records`);
	const kept = rows.map((r, i) => [r, recs[i + 1]]).filter(([r]) => set.has(String(Math.trunc(Number(r.ID))))).map(([, x]) => x);
	write(path.join(out, 'sources', 'wago', '1.60.1.70450', `${t}.csv`), `${[recs[0], ...kept].join('\n')}\n`);
}
