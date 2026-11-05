#!/usr/bin/env node
// Cuts the data-build golden's inputs from a full local source cache (not run in CI):
//   node slice.js <data/sources> <out input dir>
// - pfQuest (MIT): the units/objects with a spawn in ZONES, the quests they start or end, those
//   quests' objective units/objects/items, the items' refloot, the zones' areatriggers and meta
//   rows, the matching enUS names. Rows are copied verbatim (the Lua text of each entry).
// - Classic Era 1.15.9 and Forever 1.60.1 client tables (wago.tools CSVs): UiMap and
//   UiMapAssignment whole (a few hundred rows), AreaTable's top-level areas plus ZONES' sub-areas,
//   Faction, ChrRaces, ChrClasses, CharBaseInfo, Map whole (small), ItemSparse cut to the items.
// - CMaNGOS classic-db: see ../extracts/slice.js (the spawnz.json cache is that slice's extract).
// Prints the chosen id sets to <out>/../slice-ids.json for the other stages' slicers.
'use strict';
const fs = require('node:fs');
const path = require('node:path');

const ZONES = new Set([14, 12, 2437]); // Durotar, Elwynn Forest, Ragefire Chasm
const ERA = '1.15.9.70003';
const FOREVER = '1.60.1.70450';

const [src, out] = process.argv.slice(2);
if (!src || !out) throw new Error('usage: slice.js <data/sources> <out>');

// A pfQuest file -> { head, entries: Map(id -> text), tail } at the given indent ("  " for data).
function entries(text, indent = '  ') {
	const lines = text.split('\n');
	const head = lines[0];
	const map = new Map();
	const order = [];
	let cur = null;
	let i = 1;
	const open = new RegExp(`^${indent}\\[(-?\\d+)\\] = `);
	for (; i < lines.length; i++) {
		const l = lines[i];
		if (l === '}' || l === '') break;
		const m = open.exec(l);
		if (m) {
			cur = Number(m[1]);
			order.push(cur);
			map.set(cur, [l]);
		} else map.get(cur).push(l);
	}
	return { head, map, order, tail: lines.slice(i).join('\n') };
}
function emit(e, keep) {
	const body = e.order.filter((id) => keep(id)).map((id) => e.map.get(id).join('\n'));
	return `${[e.head, ...body].join('\n')}\n${e.tail}`;
}
const read = (f) => fs.readFileSync(f, 'utf8');
const write = (f, t) => {
	fs.mkdirSync(path.dirname(f), { recursive: true });
	fs.writeFileSync(f, t);
};
const nums = (s) => (s ? s.split(',').map((x) => Number(x.trim())).filter((x) => Number.isFinite(x)) : []);
const pick = (block, kind, key) => {
	const m = new RegExp(`\\["${kind}"\\] = \\{[^]*?\\n    \\},`).exec(block);
	if (!m) return [];
	const k = new RegExp(`\\["${key}"\\] = \\{ ([^}]*) \\}`).exec(m[0]);
	return k ? nums(k[1]) : [];
};
const zonesOf = (block) => [...block.matchAll(/\{ -?[\d.]+, -?[\d.]+, (\d+)/g)].map((m) => Number(m[1]));

const pf = path.join(src, 'pfQuest');
const db = path.join(pf, 'db');
const units = entries(read(path.join(db, 'units.lua')));
const objects = entries(read(path.join(db, 'objects.lua')));
const quests = entries(read(path.join(db, 'quests.lua')));
const items = entries(read(path.join(db, 'items.lua')));
const refloot = entries(read(path.join(db, 'refloot.lua')));
const areatrigger = entries(read(path.join(db, 'areatrigger.lua')));

const U = new Set([...units.order].filter((id) => zonesOf(units.map.get(id).join('\n')).some((z) => ZONES.has(z))));
const O = new Set([...objects.order].filter((id) => zonesOf(objects.map.get(id).join('\n')).some((z) => ZONES.has(z))));
const Q = new Set();
for (const id of quests.order) {
	const b = quests.map.get(id).join('\n');
	const ends = [...pick(b, 'start', 'U'), ...pick(b, 'end', 'U')].some((u) => U.has(u)) || [...pick(b, 'start', 'O'), ...pick(b, 'end', 'O')].some((o) => O.has(o));
	if (ends) Q.add(id);
}
const I = new Set();
for (const id of Q) {
	const b = quests.map.get(id).join('\n');
	for (const u of pick(b, 'obj', 'U')) U.add(u);
	for (const o of pick(b, 'obj', 'O')) O.add(o);
	for (const i of [...pick(b, 'obj', 'I'), ...pick(b, 'start', 'I')]) I.add(i);
}
for (const id of [...I]) if (!items.map.has(id)) I.delete(id);
const R = new Set();
for (const id of I) for (const m of items.map.get(id).join('\n').matchAll(/\["R"\] = \{([^}]*)\}/g)) for (const r of m[1].matchAll(/\[(\d+)\]/g)) R.add(Number(r[1]));
const T = new Set([...areatrigger.order].filter((id) => zonesOf(areatrigger.map.get(id).join('\n')).some((z) => ZONES.has(z))));

const dst = path.join(out, 'pfQuest');
fs.copyFileSync(path.join(pf, 'LICENSE'), (fs.mkdirSync(dst, { recursive: true }), path.join(dst, 'LICENSE')));
write(path.join(dst, 'db', 'units.lua'), emit(units, (id) => U.has(id)));
write(path.join(dst, 'db', 'objects.lua'), emit(objects, (id) => O.has(id)));
write(path.join(dst, 'db', 'quests.lua'), emit(quests, (id) => Q.has(id)));
write(path.join(dst, 'db', 'items.lua'), emit(items, (id) => I.has(id)));
write(path.join(dst, 'db', 'refloot.lua'), emit(refloot, (id) => R.has(id)));
write(path.join(dst, 'db', 'areatrigger.lua'), emit(areatrigger, (id) => T.has(id)));
// meta: pfDB["meta"] = { ["cat"] = { [id] = "AH", ... }, ... }; objects are negative ids.
{
	const lines = read(path.join(db, 'meta.lua')).split('\n');
	const keep = lines.filter((l) => {
		const m = /^    \[(-?\d+)\] = /.exec(l);
		if (!m) return true;
		const id = Number(m[1]);
		return id < 0 ? O.has(-id) : U.has(id) || O.has(id);
	});
	write(path.join(dst, 'db', 'meta.lua'), keep.join('\n'));
}
const sets = { quests: Q, units: U, objects: O, items: I };
for (const [name, set] of Object.entries(sets)) {
	write(path.join(dst, 'db', 'enUS', `${name}.lua`), emit(entries(read(path.join(db, 'enUS', `${name}.lua`))), (id) => set.has(id)));
}

// CSV records (quoted fields may hold newlines) -> [text of each record].
function records(text) {
	const out = [];
	let start = 0;
	let q = false;
	for (let i = 0; i < text.length; i++) {
		const c = text[i];
		if (c === '"') q = !q;
		else if (c === '\n' && !q) {
			out.push(text.slice(start, i));
			start = i + 1;
		}
	}
	if (start < text.length) out.push(text.slice(start));
	return out;
}
const firstField = (r) => r.slice(0, r.indexOf(','));
function csv(build, table, keep) {
	const f = path.join(src, 'wago', build, `${table}.csv`);
	const recs = records(read(f));
	const header = recs[0].split(',');
	const kept = keep ? recs.slice(1).filter((r) => keep(r, header)) : recs.slice(1);
	write(path.join(out, 'sources', 'wago', build, `${table}.csv`), `${[recs[0], ...kept].join('\n')}\n`);
}
// AreaTable: top-level areas (zones, cities, instances) plus ZONES' sub-areas.
const parentCol = (header) => header.indexOf('ParentAreaID');
const areaKeep = (r, header) => {
	const f = r.split(',');
	const p = Number(f[parentCol(header)]);
	return p === 0 || ZONES.has(p) || ZONES.has(Number(f[0]));
};
for (const t of ['UiMap', 'UiMapAssignment', 'Faction']) csv(ERA, t);
csv(ERA, 'AreaTable', areaKeep);
for (const t of ['UiMap', 'UiMapAssignment', 'Faction', 'ChrRaces', 'ChrClasses', 'CharBaseInfo', 'Map']) csv(FOREVER, t);
csv(FOREVER, 'AreaTable', areaKeep);
csv(FOREVER, 'ItemSparse', (r) => I.has(Number(firstField(r))));

// forever-db/corrections is NOT cut from Polestar's file (its notes cite web sources): the
// golden holds synthetic entries in the same schema, kept as committed (read by the build; applied
// only with QuestieDB, so this golden only proves it parses).

const ids = Object.fromEntries(Object.entries({ ...sets, refloot: R, areatriggers: T }).map(([k, s]) => [k, [...s].sort((a, b) => a - b)]));
write(path.join(out, '..', 'slice-ids.json'), `${JSON.stringify({ zones: [...ZONES], ...ids })}\n`);
console.error(Object.entries(ids).map(([k, v]) => `${k} ${v.length}`).join(', '));
