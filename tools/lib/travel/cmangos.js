'use strict';
// Server-side facts the client tables lack, from the CMaNGOS classic-db
// world database (GPL-3.0; https://github.com/cmangos/classic-db), pinned to
// the commit Shortest Path Forever by Cillian Berragan reads (his
// tools/gen_transit.py, GPL-3.0-or-later, adapted with permission):
// Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever, GPL-3.0-or-later); adapted for Polestar, 2026-10-15.
//
//   gameobject              where each lift car and tram train is spawned
//                           (its TransportAnimation is relative to the spawn)
//   areatrigger_teleport    where a walk-in portal (Darnassus <-> Rut'theran)
//                           puts you
//   spell_target_position   where a class teleport (Teleport: Orgrimmar,
//                           Teleport: Moonglade) puts you
//
// and, for `data build` (data/forever/spawnz.json), every creature and
// gameobject spawn on maps 0 and 1 with its height (loadSpawnHeights): the
// compiler gives a guide goal, spawn spot or smart-target candidate at an NPC
// or object (and `trainers build` Core/ClassTrainers.lua's class trainers) its
// spawn's z (tools/lib/dsl/heights.js), facts like the transport periods; and, for
// `nav layers hubs`, every
// creature template's name, faction template, NPC flags, extra flags, rank and
// level (loadCreatureTemplates, cached as creature_template.json).
//
// The dump (~13 MB gzip, its sha256 pinned, at most MAX_BYTES read) is
// fetched once into <sources>/cmangos/<rev>/ and only the rows above are
// kept, in transit.json and spawnz.json beside it; a present extract is never
// rebuilt, so builds are offline and deterministic after the first. A cached dump
// whose hash is wrong (a broken download) is deleted and fetched again.

const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const crypto = require('node:crypto');
const readline = require('node:readline');

const DB_REV = '22b51464f1625f6ef6275771de1f5466c6f5d19e';
const DB_URL = `https://raw.githubusercontent.com/cmangos/classic-db/${DB_REV}/Full_DB/ClassicDB_1_12_1_z2815.sql.gz`;
const DB_SHA256 = '4f92db520868ab4e566726f68b5b2e380ae781209beaf22237b4f7f04600d0c0';
const MAX_BYTES = 32 * 1024 * 1024;
// Lift cars and tram trains (gameobject entries animated by TransportAnimation).
const LIFT_ENTRIES = [4170, 4171, 11898, 11899, 20649, 20652, 20655, 47296, 47297];
const TRAM_ENTRIES = [176080, 176081, 176082, 176083, 176084, 176085];
// Walk-in portals the planner uses: Darnassus <-> Rut'theran Village.
const PORTAL_TRIGGERS = [527, 542];
const SPAWN_MAPS = new Set([0, 1, 369]);
// Maps whose spawn heights `data build` keeps: Eastern Kingdoms and Kalimdor.
const HEIGHT_MAPS = new Set([0, 1]);

// The fields of one SQL tuple body, quoted strings unquoted.
function sqlFields(body) {
	const out = [];
	let cur = '';
	let quoted = false;
	for (let i = 0; i < body.length; i++) {
		const ch = body[i];
		if (quoted) {
			if (ch === '\\' && i + 1 < body.length) cur += body[++i];
			else if (ch === "'") quoted = false;
			else cur += ch;
		} else if (ch === "'") quoted = true;
		else if (ch === ',') {
			out.push(cur.trim());
			cur = '';
		} else cur += ch;
	}
	out.push(cur.trim());
	return out;
}

// Tuple bodies of one `INSERT INTO ... VALUES (...),(...);` line.
const TUPLE = /\(((?:'(?:\\.|[^'\\])*'|[^()'])*)\)/g;
function* tuples(line) {
	TUPLE.lastIndex = line.indexOf(' VALUES ');
	let m;
	while ((m = TUPLE.exec(line))) yield sqlFields(m[1]);
}

// Lines of the dump -> { spawns: { entry: [{ guid, map, x, y, z, o }] },
// portals: { trigger: { map, x, y, z } }, positions: { spell: { map, x, y, z } } }.
async function extractLines(lines) {
	const wantSpawn = new Set([...LIFT_ENTRIES, ...TRAM_ENTRIES]);
	const wantPortal = new Set(PORTAL_TRIGGERS);
	const spawns = {};
	const portals = {};
	const positions = {};
	const point = (map, f) => ({ map: Number(map), x: Number(f[0]), y: Number(f[1]), z: Number(f[2]) });
	for await (const line of lines) {
		if (line.startsWith('INSERT INTO `gameobject` VALUES')) {
			for (const r of tuples(line)) {
				const entry = Number(r[1]);
				const map = Number(r[2]);
				if (!wantSpawn.has(entry) || !SPAWN_MAPS.has(map)) continue;
				(spawns[entry] = spawns[entry] || []).push({ guid: Number(r[0]), ...point(map, r.slice(4, 7)), o: Number(r[7]) });
			}
		} else if (line.startsWith('INSERT INTO `areatrigger_teleport` VALUES')) {
			for (const r of tuples(line)) if (wantPortal.has(Number(r[0]))) portals[r[0]] = point(r[6], r.slice(7, 10));
		} else if (line.startsWith('INSERT INTO `spell_target_position` VALUES')) {
			for (const r of tuples(line)) positions[r[0]] = point(r[1], r.slice(2, 5));
		}
	}
	for (const list of Object.values(spawns)) list.sort((a, b) => a.guid - b.guid);
	const missing = [...wantSpawn].filter((e) => !spawns[e]).concat(PORTAL_TRIGGERS.filter((t) => !portals[t]).map((t) => `trigger ${t}`));
	if (missing.length || !Object.keys(positions).length) throw new Error(`classic-db ${DB_REV.slice(0, 8)}: missing ${missing.join(', ') || 'spell_target_position'}`);
	return { spawns, portals, positions };
}

// Heights are kept to a tenth of a yard.
const tenth = (v) => {
	const r = Math.round(Number(v) * 10) / 10;
	return Object.is(r, -0) ? 0 : r;
};

// Lines of the dump -> { npc: { id: [[map, x, y, z], ...] }, object: { ... } }:
// every creature and gameobject spawn on HEIGHT_MAPS, positions to 0.1 yd
// (x north, y west, as UnitPosition), each id's spawns sorted, ids ascending.
// A spawn whose `id` is 0 takes the entries its <table>_spawn_entry rows give.
async function extractSpawnHeights(lines) {
	const out = { npc: {}, object: {} };
	const pooled = { npc: new Map(), object: new Map() }; // guid -> [map, x, y, z] of id-0 spawns
	const entries = { npc: [], object: [] }; // [guid, entry] of <table>_spawn_entry
	const add = (kind, id, pos) => (out[kind][id] = out[kind][id] || []).push(pos);
	const TABLES = [
		['INSERT INTO `creature` VALUES', 'npc', false],
		['INSERT INTO `gameobject` VALUES', 'object', false],
		['INSERT INTO `creature_spawn_entry` VALUES', 'npc', true],
		['INSERT INTO `gameobject_spawn_entry` VALUES', 'object', true],
	];
	for await (const line of lines) {
		const t = TABLES.find(([prefix]) => line.startsWith(prefix));
		if (!t) continue;
		const [, kind, isEntry] = t;
		for (const r of tuples(line)) {
			if (isEntry) {
				entries[kind].push([Number(r[0]), Number(r[1])]);
				continue;
			}
			const map = Number(r[2]);
			if (!HEIGHT_MAPS.has(map)) continue;
			const pos = [map, tenth(r[4]), tenth(r[5]), tenth(r[6])];
			const id = Number(r[1]);
			if (id > 0) add(kind, id, pos);
			else pooled[kind].set(Number(r[0]), pos);
		}
	}
	for (const kind of ['npc', 'object']) {
		for (const [guid, entry] of entries[kind]) {
			const pos = pooled[kind].get(guid);
			if (pos && entry > 0) add(kind, entry, pos.slice());
		}
	}
	const sorted = {};
	for (const kind of ['npc', 'object']) {
		sorted[kind] = {};
		for (const id of Object.keys(out[kind]).map(Number).sort((a, b) => a - b)) {
			const list = out[kind][id].sort((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2] || a[3] - b[3]);
			sorted[kind][id] = list.filter((p, i) => i === 0 || p.some((v, k) => v !== list[i - 1][k]));
		}
	}
	return sorted;
}

// spawnz.json's text: one id per line, deterministic.
function serializeSpawnHeights(db) {
	const part = (table) => Object.keys(table).map((id) => `${JSON.stringify(id)}:${JSON.stringify(table[id])}`).join(',\n');
	return `{"npc":{\n${part(db.npc)}\n},"object":{\n${part(db.object)}\n}}\n`;
}

// The creature_template columns `nav layers hubs` keeps, as the extract names them.
const TEMPLATE_COLUMNS = { Name: 'name', Faction: 'faction', NpcFlags: 'npcFlags', ExtraFlags: 'extraFlags', Rank: 'rank', MinLevel: 'minLevel' };

// Lines of the dump -> { entry: { name, faction (a FactionTemplate id),
// npcFlags, extraFlags, rank, minLevel } } for every creature template, the
// columns found by name in the dump's CREATE TABLE.
async function extractCreatureTemplates(lines) {
	const out = {};
	let cols = null;
	let creating = false;
	for await (const line of lines) {
		if (line.startsWith('CREATE TABLE `creature_template` (')) {
			creating = true;
			cols = [];
		} else if (creating) {
			const m = /^\s*`(\w+)`/.exec(line);
			if (m) cols.push(m[1]);
			else creating = false;
		} else if (line.startsWith('INSERT INTO `creature_template` VALUES')) {
			if (!cols) throw new Error('classic-db: creature_template rows before its CREATE TABLE');
			const at = { Entry: cols.indexOf('Entry') };
			for (const c of Object.keys(TEMPLATE_COLUMNS)) at[c] = cols.indexOf(c);
			const lost = Object.keys(at).filter((c) => at[c] < 0);
			if (lost.length) throw new Error(`classic-db: creature_template has no ${lost.join(', ')}`);
			for (const r of tuples(line)) {
				const t = {};
				for (const [c, k] of Object.entries(TEMPLATE_COLUMNS)) t[k] = c === 'Name' ? r[at[c]] : Number(r[at[c]]);
				out[Number(r[at.Entry])] = t;
			}
		}
	}
	if (!Object.keys(out).length) throw new Error(`classic-db ${DB_REV.slice(0, 8)}: no creature_template rows`);
	return out;
}

const sha256 = (buf) => crypto.createHash('sha256').update(buf).digest('hex');

// The pinned dump, read up to maxBytes, checked against its hash, written atomically.
async function fetchDump({ fetchImpl, file, log, url, hash, maxBytes }) {
	log(`fetching ${url}`);
	const res = await fetchImpl(url, { headers: { 'user-agent': 'polestar-travel-build' } });
	if (!res.ok) throw new Error(`GET ${url}: HTTP ${res.status}`);
	const declared = Number(res.headers && res.headers.get && res.headers.get('content-length'));
	if (declared > maxBytes) throw new Error(`GET ${url}: ${declared} bytes, over the ${maxBytes}-byte limit`);
	const chunks = [];
	let size = 0;
	if (res.body && res.body.getReader) {
		const reader = res.body.getReader();
		for (;;) {
			const { done, value } = await reader.read();
			if (done) break;
			size += value.length;
			if (size > maxBytes) {
				await reader.cancel();
				throw new Error(`GET ${url}: over the ${maxBytes}-byte limit`);
			}
			chunks.push(Buffer.from(value));
		}
	} else {
		const buf = Buffer.from(await res.arrayBuffer());
		if (buf.length > maxBytes) throw new Error(`GET ${url}: over the ${maxBytes}-byte limit`);
		chunks.push(buf);
	}
	const buf = Buffer.concat(chunks);
	const got = sha256(buf);
	if (got !== hash) throw new Error(`GET ${url}: sha256 ${got}, expected ${hash}`);
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(`${file}.tmp`, buf);
	fs.renameSync(`${file}.tmp`, file);
}

// The pinned dump's extract `name` (built by `extract` from the dump's lines
// when missing, fetching the dump first unless cached) -> its parsed JSON.
// `write` serializes it (default: tab-indented JSON).
async function cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name, extract, write = (data) => `${JSON.stringify(data, null, '\t')}\n` }) {
	const dir = path.join(sourcesDir, 'cmangos', DB_REV.slice(0, 12));
	const file = path.join(dir, name);
	if (!fs.existsSync(file)) {
		const dump = path.join(dir, 'classicdb.sql.gz');
		if (fs.existsSync(dump) && sha256(fs.readFileSync(dump)) !== hash) {
			log(`${dump}: wrong sha256, deleted`);
			fs.rmSync(dump);
		}
		if (!fs.existsSync(dump)) {
			if (offline) throw new Error(`--offline: missing cached ${file}`);
			await fetchDump({ fetchImpl, file: dump, log, url, hash, maxBytes });
		}
		const lines = readline.createInterface({ input: fs.createReadStream(dump).pipe(zlib.createGunzip()), crlfDelay: Infinity });
		const data = await extract(lines);
		fs.writeFileSync(`${file}.tmp`, write(data));
		fs.renameSync(`${file}.tmp`, file);
	}
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

// -> { rev, url, spawns, portals, positions }. url, hash and maxBytes are
// the pinned dump's unless a test passes its own.
async function loadClassicDb({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const data = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: 'transit.json', extract: extractLines });
	return { rev: DB_REV, url: DB_URL, ...data };
}

// -> { rev, url, text, npc, object }: extractSpawnHeights' tables and
// spawnz.json's text (serializeSpawnHeights), cached as spawnz.json beside the
// dump. Throws like loadClassicDb (--offline without a cached dump or extract).
async function loadSpawnHeights({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const data = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: 'spawnz.json', extract: extractSpawnHeights, write: serializeSpawnHeights });
	return { rev: DB_REV, url: DB_URL, text: serializeSpawnHeights(data), npc: data.npc, object: data.object };
}

// -> { rev, url, templates }: extractCreatureTemplates' table, cached as
// creature_template.json beside the dump. Throws like loadClassicDb.
async function loadCreatureTemplates({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const templates = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: 'creature_template.json', extract: extractCreatureTemplates, write: (data) => `${JSON.stringify(data)}\n` });
	return { rev: DB_REV, url: DB_URL, templates };
}

// The reference data source the heights come from: meta.json's entry (`data
// build`), and the LICENSE-DATA.txt section of a pack whose goals carry z.
const HEIGHTS_SOURCE = {
	name: 'CMaNGOS classic-db: creature and gameobject spawn heights',
	url: DB_URL,
	revision: DB_REV,
	license: "GPL-3.0; spawn heights (z) only, used as facts like the transport periods: a guide goal, spawn spot or smart-target candidate at an NPC or object (and Core/ClassTrainers.lua's class trainers) carries its spawn's height",
	copyright: 'CMaNGOS (https://github.com/cmangos/classic-db)',
};

module.exports = {
	loadClassicDb, loadSpawnHeights, loadCreatureTemplates, extractLines, extractSpawnHeights, extractCreatureTemplates, serializeSpawnHeights, sqlFields,
	DB_REV, DB_URL, DB_SHA256, MAX_BYTES, LIFT_ENTRIES, TRAM_ENTRIES, PORTAL_TRIGGERS, HEIGHTS_SOURCE,
};
