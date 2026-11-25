'use strict';
// Where the Forever server puts herb and ore nodes, and what a node or a skinned beast gives
// (tools/lib/professions/gathering/gathering-nodes.json), for the farming loops of the Herbalism,
// Mining and Skinning guides:
//
//   node tools/polestar.js profession gathering nodes --recordings DIR [--tdb FILE]
//
// - `maps`: per zone map and node kind, every spawn of the Forever TrinityCore world database's
//   `gameobject` table as "x,y,u" (map percent in the Era frame, or Forever's own frame on a map
//   without an Era frame: `f: "l"`; `u` the chance it is up, from the spawn pools: abundance.js
//   poolOdds) and the kind's respawn time in seconds. A spawn that comes back only after a day or
//   more (an event or one-off node) is left out: a loop cannot count on it. Each spawn counts for the
//   zone of the nearest gathering node of objects.json (as node-abundance.json does). A kind the world
//   database has no spawn of in a zone, but that MIN_PEOPLE players gathered there (Forever's own
//   Amber on Teldrassil, the Poor Copper Veins of Zephras Isle), takes its objects.json spawns, each
//   up as one of the kinds listed at its point (`src: "objects"`, no respawn).
// - `yields`: per node kind, what one node gives (items per node), from players' gathers in the
//   recordings archive (Polestar_Recorder `drop` records with `gather` herb or mine). A vein is mined
//   in several loot windows: the windows of one session at one node (same kind, within NODE_YARDS and
//   NODE_SECONDS of the one before) are one node.
// - `skins`: per beast level (npcs.json), what one skinning gives (`gather` skin records).
// Kinds and levels with fewer than MIN_NODES records are left out of `yields` / `skins`.

const fs = require('node:fs');
const path = require('node:path');
const { MINING_NODES, HERB_NODES, bandWeight } = require('./tables');
const { poolOdds, nodeGrid, nearestMap } = require('./abundance');
const { peopleOf } = require('./waters');
const { dist } = require('../../route/geo');

const FILE = path.join(__dirname, 'gathering-nodes.json');
const ABOUT = 'Herb and ore nodes per zone map and kind: every spawn of the Forever TrinityCore world database as "x,y,u" (map percent, Era frame unless f is "l"; u = the chance the spawn pools keep it up) and the kind\'s respawn in seconds (spawns that return only after a day or more are left out); yields: items one node gives, and skins: items one skinning gives per beast level, from players\' gathers in Polestar_Recorder sessions. Written by `node tools/polestar.js profession gathering nodes` (tools/lib/professions/gathering/nodes.js); read by the gathering guides\' farming loops.';
const DAY = 86400;
const NODE_YARDS = 10;
const NODE_SECONDS = 120;
const MIN_NODES = 20;
const MIN_PEOPLE = 3;
const MIN_ITEM = 0.02;

function round(v, d) {
	const k = 10 ** d;
	return Math.round(v * k) / k;
}

// { <uiMap>: { f?, kinds: { <name>: { respawn, pts: "x,y,u ..." } } } } from the world DB.
function spawnTable(db, objects, project, frames) {
	const names = new Set([...Object.keys(MINING_NODES), ...Object.keys(HERB_NODES)]);
	const odds = poolOdds(db.prepare('SELECT entry, max_limit FROM pool_template').all(), db.prepare('SELECT type, spawnId, poolSpawnId, chance FROM pool_members WHERE type IN (1, 2)').all());
	const grid = nodeGrid(objects, project, names);
	const rows = db.prepare('SELECT g.guid, g.map, g.position_x AS x, g.position_y AS y, g.spawntimesecs AS respawn, t.name FROM gameobject g JOIN gameobject_template t ON t.entry = g.id WHERE t.type = 3 ORDER BY g.guid').all();
	const maps = {};
	for (const r of rows) {
		if (!names.has(r.name) || r.respawn >= DAY) continue;
		const map = nearestMap(grid, r.map, r.x, r.y);
		if (map === null) continue;
		const b = project.bounds(map);
		if (b.c !== r.map) continue;
		const u = odds(r.guid);
		if (!(u > 0)) continue;
		const z = (maps[map] = maps[map] || { live: !(frames.era && frames.era[String(map)]), kinds: {} });
		const k = (z.kinds[r.name] = z.kinds[r.name] || { respawn: [], pts: [] });
		k.respawn.push(r.respawn);
		k.pts.push([round(((r.y - b.left) / (b.right - b.left)) * 100, 1), round(((r.x - b.top) / (b.bottom - b.top)) * 100, 1), round(u, 2)]);
	}
	const out = {};
	for (const map of Object.keys(maps).sort((a, b) => a - b)) {
		const z = maps[map];
		const kinds = {};
		for (const name of Object.keys(z.kinds).sort()) {
			const k = z.kinds[name];
			const sorted = k.respawn.slice().sort((a, b) => a - b);
			const pts = k.pts.sort((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2]);
			kinds[name] = { respawn: sorted[sorted.length >> 1], pts: pts.map((p) => p.join(',')).join(' ') };
		}
		out[map] = z.live ? { f: 'l', kinds } : { kinds };
	}
	return out;
}

// Every herb, ore and skinning record of the archive: { kind: 'herb'|'mine'|'skin', name (node kind,
// or the beast's level for skins), person, items: { item: n } }, one per node (a vein's loot windows
// joined) or skinning.
function readGathers(dir, objects, npcs, project) {
	const names = fs.readdirSync(dir).filter((n) => n.endsWith('.json') && n !== 'config.json').sort();
	const cfgFile = path.join(dir, 'config.json');
	const exclude = new Set(fs.existsSync(cfgFile) ? JSON.parse(fs.readFileSync(cfgFile, 'utf8')).exclude || [] : []);
	const P = peopleOf(names);
	const out = [];
	for (const name of names) {
		if (exclude.has(P.contributor(name))) continue;
		const text = fs.readFileSync(path.join(dir, name), 'utf8');
		if (!/"gather":\s*"(herb|mine|skin)"/.test(text)) continue;
		const s = JSON.parse(text);
		if (exclude.has(s.contributor)) continue;
		const person = P.person(name) || s.contributor;
		let last = null;
		for (const e of s.events || []) {
			if (!e || e.e !== 'drop' || !['herb', 'mine', 'skin'].includes(e.gather)) continue;
			const items = {};
			for (const i of e.items || []) items[i.item] = (items[i.item] || 0) + (i.count || 1);
			if (e.gather === 'skin') {
				const n = npcs[e.npc];
				if (n && n.level) out.push({ kind: 'skin', name: String(n.level), person, items });
				continue;
			}
			const o = objects[e.object];
			if (!o || !Number.isFinite(e.x) || !e.map) continue;
			const pt = project.point(e.map, e.x, e.y, 'l');
			if (last && last.object === e.object && e.t - last.t <= NODE_SECONDS && dist(last.pt, pt) <= NODE_YARDS) {
				for (const [item, n] of Object.entries(items)) last.rec.items[item] = (last.rec.items[item] || 0) + n;
				last.t = e.t;
				continue;
			}
			const rec = { kind: e.gather, name: o.name, map: e.map, person, items };
			out.push(rec);
			last = { object: e.object, t: e.t, pt, rec };
		}
	}
	return out;
}

// Records -> { <key>: { nodes, people, items: { item: per node } } }, keys with MIN_NODES records.
function perNode(records) {
	const by = new Map();
	for (const r of records) {
		if (!by.has(r.name)) by.set(r.name, { nodes: 0, people: new Set(), items: {} });
		const e = by.get(r.name);
		e.nodes++;
		e.people.add(r.person);
		for (const [item, n] of Object.entries(r.items)) e.items[item] = (e.items[item] || 0) + n;
	}
	const out = {};
	for (const key of [...by.keys()].sort((a, b) => (/^\d+$/.test(a) && /^\d+$/.test(b) ? a - b : a.localeCompare(b)))) {
		const e = by.get(key);
		if (e.nodes < MIN_NODES) continue;
		const items = {};
		for (const [item, n] of Object.entries(e.items).sort((a, b) => b[1] - a[1] || a[0] - b[0])) if (n / e.nodes >= MIN_ITEM) items[item] = round(n / e.nodes, 2);
		out[key] = { nodes: e.nodes, people: e.people.size, items };
	}
	return out;
}

// Kinds the world database lacks in a zone but players gather there: their objects.json spawns.
function fill(maps, records, objects, project, frames) {
	const seen = new Map();
	for (const r of records) {
		if (r.kind === 'skin') continue;
		const k = `${r.map}|${r.name}`;
		if (!seen.has(k)) seen.set(k, new Set());
		seen.get(k).add(r.person);
	}
	const names = new Set([...Object.keys(MINING_NODES), ...Object.keys(HERB_NODES)]);
	const listed = new Map();
	for (const o of Object.values(objects)) {
		if (!names.has(o.name)) continue;
		for (const [map, s] of Object.entries(o.spawns || {})) {
			for (const [x, y] of [...(s.pts || []), ...(s.more || [])]) {
				const pt = project.point(Number(map), x, y, s.f);
				const key = `${map}|${pt.x.toFixed(1)}|${pt.y.toFixed(1)}`;
				if (!listed.has(key)) listed.set(key, { map, pt, kinds: new Set() });
				listed.get(key).kinds.add(o.name);
			}
		}
	}
	const add = new Map();
	for (const { map, pt, kinds } of listed.values()) {
		for (const name of kinds) {
			const z = maps[map];
			if ((z && z.kinds[name]) || (seen.get(`${map}|${name}`) || new Set()).size < MIN_PEOPLE) continue;
			const k = `${map}|${name}`;
			if (!add.has(k)) add.set(k, []);
			add.get(k).push([round(pt.x, 1), round(pt.y, 1), round(1 / kinds.size, 2)]);
		}
	}
	for (const k of [...add.keys()].sort()) {
		const [map, name] = k.split('|');
		if (!maps[map]) maps[map] = frames.era && frames.era[map] ? { kinds: {} } : { f: 'l', kinds: {} };
		const pts = add.get(k).sort((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2]);
		maps[map].kinds[name] = { src: 'objects', pts: pts.map((p) => p.join(',')).join(' ') };
		maps[map].kinds = Object.fromEntries(Object.entries(maps[map].kinds).sort(([a], [b]) => a.localeCompare(b)));
	}
	const out = {};
	for (const map of Object.keys(maps).sort((a, b) => a - b)) out[map] = maps[map];
	return out;
}

// The table: { maps, yields, skins }.
function derive({ tdbFile, recordingsDir, objects, npcs, project, frames }) {
	const { DatabaseSync } = require('node:sqlite');
	const db = new DatabaseSync(tdbFile, { readOnly: true });
	let maps;
	try {
		maps = spawnTable(db, objects, project, frames);
	} finally {
		db.close();
	}
	const records = readGathers(recordingsDir, objects, npcs, project);
	return { maps: fill(maps, records, objects, project, frames), yields: perNode(records.filter((r) => r.kind !== 'skin')), skins: perNode(records.filter((r) => r.kind === 'skin')) };
}

// The file's text: one line per zone map and node kind, per yield and per skin level.
function render(table) {
	const L = ['{', `\t"about": ${JSON.stringify(ABOUT)},`, '\t"maps": {'];
	const ids = Object.keys(table.maps);
	ids.forEach((map, i) => {
		const z = table.maps[map];
		const names = Object.keys(z.kinds);
		L.push(`\t\t${JSON.stringify(map)}: {${z.f ? ` "f": ${JSON.stringify(z.f)},` : ''} "kinds": {`);
		names.forEach((name, j) => L.push(`\t\t\t${JSON.stringify(name)}: ${JSON.stringify(z.kinds[name])}${j < names.length - 1 ? ',' : ''}`));
		L.push(`\t\t} }${i < ids.length - 1 ? ',' : ''}`);
	});
	L.push('\t},');
	for (const key of ['yields', 'skins']) {
		const keys = Object.keys(table[key]);
		L.push(`\t${JSON.stringify(key)}: {`);
		keys.forEach((k, i) => L.push(`\t\t${JSON.stringify(k)}: ${JSON.stringify(table[key][k])}${i < keys.length - 1 ? ',' : ''}`));
		L.push(`\t}${key === 'yields' ? ',' : ''}`);
	}
	L.push('}', '');
	return L.join('\n');
}

let cached = null;
// The committed table, or an empty one without it.
function load() {
	if (!cached) cached = fs.existsSync(FILE) ? JSON.parse(fs.readFileSync(FILE, 'utf8')) : { maps: {}, yields: {}, skins: {} };
	return cached;
}

// The spawns of `table`'s kinds on `map` as route points, weighted for the band [from, to):
// { name, req, up, w, pt }. `nodes`: a table in the file's shape (tests), else the committed one.
const pointCache = new WeakMap();
function nodePoints(project, { table, map, from, to, nodes = null }) {
	const t = nodes || load();
	const z = t.maps[String(map)];
	if (!z) return [];
	if (!pointCache.has(t)) pointCache.set(t, new Map());
	const cache = pointCache.get(t);
	const key = `${map}`;
	let all = cache.get(key);
	if (!all || all.project !== project) {
		all = { project, list: [] };
		for (const [name, k] of Object.entries(z.kinds)) {
			for (const s of k.pts ? k.pts.split(' ') : []) {
				const [x, y, u] = s.split(',').map(Number);
				all.list.push({ name, up: u, pt: project.point(Number(map), x, y, z.f || 'e') });
			}
		}
		cache.set(key, all);
	}
	const out = [];
	for (const p of all.list) {
		const req = table[p.name];
		if (req === undefined) continue;
		const bw = bandWeight(req, from, to);
		if (bw <= 0) continue;
		out.push({ name: p.name, req, up: p.up, w: bw * p.up, pt: p.pt });
	}
	return out;
}

// Seconds a kind takes to come back on `map` (the median spawn's), or null.
function respawnOf(map, name, nodes = null) {
	const z = (nodes || load()).maps[String(map)];
	return z && z.kinds[name] ? z.kinds[name].respawn : null;
}

module.exports = { FILE, ABOUT, DAY, MIN_NODES, MIN_PEOPLE, spawnTable, readGathers, perNode, fill, derive, render, load, nodePoints, respawnOf };
