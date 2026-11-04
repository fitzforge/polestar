#!/usr/bin/env node
// Cuts the CMaNGOS classic-db dump (GPL facts) to the data golden's slice (not run in CI):
//   node slice.js <full classicdb.sql.gz> <out classicdb.sql.gz> <../data/slice-ids.json>
// Keeps the CREATE TABLE blocks and rows of the tables the extracts read, rows cut to the slice:
// creature/gameobject spawns (and their *_spawn_entry rows) of the slice's units/objects, their
// templates, the trainer templates those name, the quests' quest_template and
// dbscripts_on_quest_start rows, the chests' loot, script_waypoint of the slice's units (else the
// first escort), game_graveyard_zone and world_safe_locs whole (a few hundred rows).
'use strict';
const fs = require('node:fs');
const zlib = require('node:zlib');

const [src, out, idsFile] = process.argv.slice(2);
if (!src || !out || !idsFile) throw new Error('usage: node slice.js <full classicdb.sql.gz> <out classicdb.sql.gz> <../data/slice-ids.json>');
const ids = JSON.parse(fs.readFileSync(idsFile, 'utf8'));
const U = new Set(ids.units);
const O = new Set(ids.objects);
const Q = new Set(ids.quests);
const lines = zlib.gunzipSync(fs.readFileSync(src)).toString('utf8').split('\n');

const TABLES = ['creature', 'gameobject', 'creature_spawn_entry', 'gameobject_spawn_entry', 'creature_template', 'npc_trainer_template', 'quest_template', 'gameobject_template', 'gameobject_loot_template', 'game_graveyard_zone', 'world_safe_locs', 'script_waypoint', 'dbscripts_on_quest_start'];
const cols = {};
const ddl = [];
const rows = {}; // table -> [[fields, raw]]
const TUPLE = /\(((?:'(?:\\.|[^'\\])*'|[^()'])*)\)/g;
function fields(body) {
	const o = [];
	let cur = '';
	let q = false;
	for (let i = 0; i < body.length; i++) {
		const ch = body[i];
		if (q) {
			if (ch === '\\' && i + 1 < body.length) cur += body[++i];
			else if (ch === "'") q = false;
			else cur += ch;
		} else if (ch === "'") q = true;
		else if (ch === ',') {
			o.push(cur.trim());
			cur = '';
		} else cur += ch;
	}
	o.push(cur.trim());
	return o;
}
let table = null;
for (const line of lines) {
	const open = /^CREATE TABLE `(\w+)` \(/.exec(line);
	if (open) {
		table = TABLES.includes(open[1]) ? open[1] : '';
		if (table) {
			cols[table] = [];
			ddl.push([table, [line]]);
		}
		continue;
	}
	if (table !== null) {
		if (table) {
			ddl[ddl.length - 1][1].push(line);
			const c = /^\s+`(\w+)`/.exec(line);
			if (c) cols[table].push(c[1]);
		}
		if (/^\)/.test(line)) table = null;
		continue;
	}
	const ins = /^INSERT INTO `(\w+)` VALUES/.exec(line);
	if (!ins || !TABLES.includes(ins[1])) continue;
	const list = (rows[ins[1]] ||= []);
	TUPLE.lastIndex = line.indexOf(' VALUES ');
	let m;
	while ((m = TUPLE.exec(line))) list.push([fields(m[1]), m[0]]);
}
const col = (t, name) => {
	const i = cols[t].findIndex((c) => c.toLowerCase() === name.toLowerCase());
	if (i < 0) throw new Error(`${t}.${name}?`);
	return i;
};
const keep = {};
const by = (t, name, set) => (keep[t] = rows[t].filter(([f]) => set.has(Number(f[col(t, name)]))));
// Spawns: the slice's ids, and id-0 spawns whose *_spawn_entry names one.
for (const [t, set] of [['creature', U], ['gameobject', O]]) {
	const entries = by(`${t}_spawn_entry`, 'entry', set);
	const guids = new Set(entries.map(([f]) => Number(f[col(`${t}_spawn_entry`, 'guid')])));
	keep[t] = rows[t].filter(([f]) => set.has(Number(f[col(t, 'id')])) || guids.has(Number(f[col(t, 'guid')])));
}
by('quest_template', 'entry', Q);
by('dbscripts_on_quest_start', 'id', Q);
by('creature_template', 'Entry', U);
// One class trainer per class (its trainer template's spells give training.json).
{
	const [ic, it, ie] = ['TrainerClass', 'TrainerTemplateId', 'Entry'].map((c) => col('creature_template', c));
	const perClass = new Map();
	for (const r of rows.creature_template) {
		const [cls, tpl] = [Number(r[0][ic]), Number(r[0][it])];
		if (cls > 0 && tpl > 0 && (!perClass.has(cls) || tpl < Number(perClass.get(cls)[0][it]))) perClass.set(cls, r);
	}
	const have = new Set(keep.creature_template.map(([f]) => Number(f[ie])));
	for (const r of perClass.values()) if (!have.has(Number(r[0][ie]))) keep.creature_template.push(r);
	keep.creature_template.sort((a, b) => Number(a[0][ie]) - Number(b[0][ie]));
}
const tpls = new Set(keep.creature_template.map(([f]) => Number(f[col('creature_template', 'TrainerTemplateId')])).filter((x) => x > 0));
by('npc_trainer_template', 'entry', tpls);
by('gameobject_template', 'entry', O);
const loot = new Set(keep.gameobject_template.filter(([f]) => [3, 25].includes(Number(f[col('gameobject_template', 'type')]))).map(([f]) => Number(f[col('gameobject_template', 'data1')])));
by('gameobject_loot_template', 'entry', loot);
keep.game_graveyard_zone = rows.game_graveyard_zone;
keep.world_safe_locs = rows.world_safe_locs;
by('script_waypoint', 'Entry', U);
if (!keep.script_waypoint.length) {
	const first = Math.min(...rows.script_waypoint.map(([f]) => Number(f[col('script_waypoint', 'Entry')])));
	by('script_waypoint', 'Entry', new Set([first]));
}

// Rows 500 to a line, as the dump splits its INSERTs.
const text = [];
for (const [t, block] of ddl) {
	text.push(...block, '');
	const list = keep[t] || [];
	for (let i = 0; i < list.length; i += 500) text.push(`INSERT INTO \`${t}\` VALUES ${list.slice(i, i + 500).map(([, raw]) => raw).join(',')};`);
	text.push('');
}
fs.writeFileSync(out, zlib.gzipSync(Buffer.from(text.join('\n')), { level: 9 }));
console.error(TABLES.map((t) => `${t} ${(keep[t] || []).length}`).join(', '));
