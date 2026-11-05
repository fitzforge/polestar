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
// level (loadCreatureTemplates, cached as creature_template.json); and, for
// `data build`'s quests.json, each quest's kill, object and item counts
// (loadQuestCounts, cached as quest_counts.json); and, for the sim world, every
// gameobject's type, respawn and quest-item loot (loadObjectFacts, cached as
// gameobject_facts.json), and each graveyard with the zones whose dead it takes
// (loadGraveyards, cached as graveyards.json; the sim's deathskip).
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

// Column names of the dump's tables, read from their CREATE TABLE blocks.
function columnTracker() {
	const cols = {};
	let table = null;
	return {
		cols,
		see(line) {
			const open = /^CREATE TABLE `(\w+)` \(/.exec(line);
			if (open) {
				table = open[1];
				cols[table] = [];
				return true;
			}
			if (table) {
				const c = /^\s+`(\w+)`/.exec(line);
				if (c) cols[table].push(c[1]);
				if (/^\)/.test(line)) table = null;
				return true;
			}
			return false;
		},
		at(tableName, name, fallback) {
			const i = (cols[tableName] || []).findIndex((c) => c.toLowerCase() === name.toLowerCase());
			return i >= 0 ? i : fallback;
		},
	};
}

// Lines of the dump -> { npc: { id: [[map, x, y, z, respawnSec], ...] }, object: { id: [[map, x, y, z], ...] } }:
// every creature and gameobject spawn on HEIGHT_MAPS, positions to 0.1 yd
// (x north, y west, as UnitPosition), each id's spawns sorted, ids ascending.
// A creature's respawnSec is its spawntimesecs (the min of min/max), present
// when the dump's CREATE TABLE names the column. Columns are found by name,
// falling back to the classic positions when no CREATE TABLE was seen.
// A spawn whose `id` is 0 takes the entries its <table>_spawn_entry rows give.
async function extractSpawnHeights(lines) {
	const out = { npc: {}, object: {} };
	const pooled = { npc: new Map(), object: new Map() }; // guid -> [map, x, y, z] of id-0 spawns
	const entries = { npc: [], object: [] }; // [guid, entry] of <table>_spawn_entry
	const add = (kind, id, pos) => (out[kind][id] = out[kind][id] || []).push(pos);
	const TABLES = [
		['INSERT INTO `creature` VALUES', 'npc', false, 'creature'],
		['INSERT INTO `gameobject` VALUES', 'object', false, 'gameobject'],
		['INSERT INTO `creature_spawn_entry` VALUES', 'npc', true],
		['INSERT INTO `gameobject_spawn_entry` VALUES', 'object', true],
	];
	const t = columnTracker();
	for await (const line of lines) {
		if (t.see(line)) continue;
		const hit = TABLES.find(([prefix]) => line.startsWith(prefix));
		if (!hit) continue;
		const [, kind, isEntry, table] = hit;
		const im = isEntry ? 0 : t.at(table, 'map', 2);
		const ix = isEntry ? 0 : t.at(table, 'position_x', 4);
		const respawnCol = kind === 'npc' && !isEntry ? t.at(table, 'spawntimesecsmin', t.at(table, 'spawntimesecs', -1)) : -1;
		for (const r of tuples(line)) {
			if (isEntry) {
				entries[kind].push([Number(r[0]), Number(r[1])]);
				continue;
			}
			const map = Number(r[im]);
			if (!HEIGHT_MAPS.has(map)) continue;
			const pos = [map, tenth(r[ix]), tenth(r[ix + 1]), tenth(r[ix + 2])];
			if (respawnCol >= 0 && r[respawnCol] !== '' && Number.isFinite(Number(r[respawnCol]))) pos.push(Number(r[respawnCol]));
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

const CLASS_BY_ID = { 1: 'WARRIOR', 2: 'PALADIN', 3: 'HUNTER', 4: 'ROGUE', 5: 'PRIEST', 7: 'SHAMAN', 8: 'MAGE', 9: 'WARLOCK', 11: 'DRUID' };

// Lines of the dump -> { classes: { CLASS: { reqLevel: copper } }, spells }:
// class trainers' templates (creature_template TrainerClass/TrainerTemplateId),
// each spell counted once per class at its required level.
async function extractTraining(lines) {
	const t = columnTracker();
	const templateClass = new Map();
	const rows = [];
	for await (const line of lines) {
		if (t.see(line)) continue;
		if (line.startsWith('INSERT INTO `creature_template` VALUES')) {
			const ic = t.at('creature_template', 'TrainerClass', -1);
			const it = t.at('creature_template', 'TrainerTemplateId', -1);
			if (ic < 0 || it < 0) continue;
			for (const r of tuples(line)) if (CLASS_BY_ID[Number(r[ic])] && Number(r[it]) > 0) templateClass.set(Number(r[it]), CLASS_BY_ID[Number(r[ic])]);
		} else if (line.startsWith('INSERT INTO `npc_trainer_template` VALUES')) {
			const at = (name, fallback) => t.at('npc_trainer_template', name, fallback);
			const [ie, is, ic, il] = [at('entry', 0), at('spell', 1), at('spellcost', 2), at('reqlevel', 5)];
			for (const r of tuples(line)) rows.push([Number(r[ie]), Number(r[is]), Number(r[ic]), Number(r[il])]);
		}
	}
	const classes = {};
	const seen = new Set();
	let spells = 0;
	for (const [tpl, spell, cost, level] of rows) {
		const cls = templateClass.get(tpl);
		if (!cls || !(level > 0) || seen.has(`${cls}:${spell}`)) continue;
		seen.add(`${cls}:${spell}`);
		classes[cls] = classes[cls] || {};
		classes[cls][level] = (classes[cls][level] || 0) + cost;
		spells++;
	}
	return { classes, spells };
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

const SLOTS = [1, 2, 3, 4];

// Lines of the dump -> { quest: { kill: [[npc, count]], object: [[gameobject,
// count]], item: [[item, count]] } } from quest_template's ReqCreatureOrGOId/
// Count 1-4 (a negative id is a gameobject) and ReqItemId/Count 1-4, in slot
// order, the columns found by name. Quests with nothing to count are left out.
async function extractQuestCounts(lines) {
	const out = {};
	let cols = null;
	let creating = false;
	for await (const line of lines) {
		if (line.startsWith('CREATE TABLE `quest_template` (')) {
			creating = true;
			cols = [];
		} else if (creating) {
			const m = /^\s*`(\w+)`/.exec(line);
			if (m) cols.push(m[1]);
			else creating = false;
		} else if (line.startsWith('INSERT INTO `quest_template` VALUES')) {
			if (!cols) throw new Error('classic-db: quest_template rows before its CREATE TABLE');
			const at = (c) => {
				const i = cols.indexOf(c);
				if (i < 0) throw new Error(`classic-db: quest_template has no ${c}`);
				return i;
			};
			const entry = at('entry');
			const kills = SLOTS.map((i) => [at(`ReqCreatureOrGOId${i}`), at(`ReqCreatureOrGOCount${i}`)]);
			const items = SLOTS.map((i) => [at(`ReqItemId${i}`), at(`ReqItemCount${i}`)]);
			for (const r of tuples(line)) {
				const q = { kill: [], object: [], item: [] };
				for (const [i, c] of kills) {
					const id = Number(r[i]);
					const count = Number(r[c]);
					if (id > 0 && count > 0) q.kill.push([id, count]);
					else if (id < 0 && count > 0) q.object.push([-id, count]);
				}
				for (const [i, c] of items) {
					const id = Number(r[i]);
					const count = Number(r[c]);
					if (id > 0 && count > 0) q.item.push([id, count]);
				}
				if (q.kill.length + q.object.length + q.item.length) out[Number(r[entry])] = q;
			}
		}
	}
	if (!Object.keys(out).length) throw new Error(`classic-db ${DB_REV.slice(0, 8)}: no quest_template rows`);
	return out;
}

// Lines of the dump -> { id: { type, respawn, loot } } per gameobject template
// with a spawn or loot: its gameobject_template type, its spawns' least
// positive spawntimesecsmin (seconds; null without one) and, for a chest or a
// fishing hole (type 3, 25: the loot id is data1), its gameobject_loot_template
// rows that drop an item themselves (mincountOrRef > 0, not a reference) as
// { item: [ChanceOrQuestChance, mincount, maxcount] } (a negative chance: a
// quest item's; 0: an equal share of the row's group). Spawns whose `id` is 0
// take their entry from gameobject_spawn_entry. The columns found by name.
const LOOT_TYPES = new Set([3, 25]);
async function extractObjectFacts(lines) {
	const t = columnTracker();
	const tpl = new Map(); // entry -> [type, lootId]
	const respawn = new Map(); // entry -> least respawn seconds
	const pooled = new Map(); // guid -> respawn of an id-0 spawn
	const entries = []; // [guid, entry]
	const loot = new Map(); // lootId -> { item: [chance, min, max] }
	// A spawntimesecs of 0 or less is no timed respawn (a script spawns it): left out.
	const least = (id, s) => {
		if (!Number.isFinite(s) || s <= 0) return;
		if (!respawn.has(id) || s < respawn.get(id)) respawn.set(id, s);
	};
	for await (const line of lines) {
		if (t.see(line)) continue;
		if (line.startsWith('INSERT INTO `gameobject_template` VALUES')) {
			const [ie, it, id1] = [t.at('gameobject_template', 'entry', 0), t.at('gameobject_template', 'type', 1), t.at('gameobject_template', 'data1', 9)];
			for (const r of tuples(line)) tpl.set(Number(r[ie]), [Number(r[it]), Number(r[id1])]);
		} else if (line.startsWith('INSERT INTO `gameobject` VALUES')) {
			const [ig, ii, is] = [t.at('gameobject', 'guid', 0), t.at('gameobject', 'id', 1), t.at('gameobject', 'spawntimesecsmin', t.at('gameobject', 'spawntimesecs', -1))];
			if (is < 0) continue;
			for (const r of tuples(line)) {
				const id = Number(r[ii]);
				if (id > 0) least(id, Number(r[is]));
				else pooled.set(Number(r[ig]), Number(r[is]));
			}
		} else if (line.startsWith('INSERT INTO `gameobject_spawn_entry` VALUES')) {
			for (const r of tuples(line)) entries.push([Number(r[0]), Number(r[1])]);
		} else if (line.startsWith('INSERT INTO `gameobject_loot_template` VALUES')) {
			const at = (name, fallback) => t.at('gameobject_loot_template', name, fallback);
			const [ie, ii, ic, imin, imax] = [at('entry', 0), at('item', 1), at('ChanceOrQuestChance', 2), at('mincountOrRef', 4), at('maxcount', 5)];
			for (const r of tuples(line)) {
				const min = Number(r[imin]);
				if (!(min > 0)) continue;
				const e = Number(r[ie]);
				if (!loot.has(e)) loot.set(e, {});
				loot.get(e)[Number(r[ii])] = [Number(r[ic]), min, Number(r[imax])];
			}
		}
	}
	for (const [guid, entry] of entries) if (pooled.has(guid) && entry > 0) least(entry, pooled.get(guid));
	const out = {};
	for (const id of [...tpl.keys()].sort((a, b) => a - b)) {
		const [type, lootId] = tpl.get(id);
		const l = LOOT_TYPES.has(type) ? loot.get(lootId) || null : null;
		if (!respawn.has(id) && !l) continue;
		out[id] = { type, respawn: respawn.has(id) ? respawn.get(id) : null, ...(l ? { loot: l } : {}) };
	}
	if (!Object.keys(out).length) throw new Error(`classic-db ${DB_REV.slice(0, 8)}: no gameobject rows`);
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
// spawnz.json's text (serializeSpawnHeights), cached beside the dump as
// SPAWNZ_CACHE (its name changes whenever the extract's shape does, so an
// older extract is not reused). Throws like loadClassicDb (--offline without
// a cached dump or extract).
const SPAWNZ_CACHE = 'spawnz.2.json';
async function loadSpawnHeights({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const data = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: SPAWNZ_CACHE, extract: extractSpawnHeights, write: serializeSpawnHeights });
	return { rev: DB_REV, url: DB_URL, text: serializeSpawnHeights(data), npc: data.npc, object: data.object };
}

// -> { rev, url, classes, spells }: extractTraining's class training costs,
// cached as training.json beside the dump. Throws like loadClassicDb.
async function loadTraining({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const data = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: 'training.json', extract: extractTraining });
	return { rev: DB_REV, url: DB_URL, ...data };
}

// -> { rev, url, templates }: extractCreatureTemplates' table, cached as
// creature_template.json beside the dump. Throws like loadClassicDb.
async function loadCreatureTemplates({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const templates = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: 'creature_template.json', extract: extractCreatureTemplates, write: (data) => `${JSON.stringify(data)}\n` });
	return { rev: DB_REV, url: DB_URL, templates };
}

// -> { rev, url, counts }: extractQuestCounts' table, cached as
// quest_counts.json beside the dump. Throws like loadClassicDb.
async function loadQuestCounts({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const counts = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: 'quest_counts.json', extract: extractQuestCounts, write: (data) => `${JSON.stringify(data)}\n` });
	return { rev: DB_REV, url: DB_URL, counts };
}

// Lines of the dump -> { links: [[graveyard, zone, team], ...], locs: { graveyard: [map, x, y, z, name] } }:
// game_graveyard_zone (the zones whose dead each graveyard takes: zone an AreaTable
// zone id, team 0 either, 67 Horde, 469 Alliance; link_kind 0 only) and the
// world_safe_locs it names (x north, y west, as UnitPosition, to 0.1 yd), links sorted.
async function extractGraveyards(lines) {
	const t = columnTracker();
	const links = [];
	const locs = {};
	for await (const line of lines) {
		if (t.see(line)) continue;
		if (line.startsWith('INSERT INTO `game_graveyard_zone` VALUES')) {
			const [id, zone, kind, team] = ['id', 'ghost_loc', 'link_kind', 'faction'].map((c, i) => t.at('game_graveyard_zone', c, i));
			for (const r of tuples(line)) if (Number(r[kind]) === 0) links.push([Number(r[id]), Number(r[zone]), Number(r[team])]);
		} else if (line.startsWith('INSERT INTO `world_safe_locs` VALUES')) {
			const [id, map, x, y, z, name] = ['id', 'map', 'x', 'y', 'z', 'name'].map((c, i) => t.at('world_safe_locs', c, i < 5 ? i : 6));
			for (const r of tuples(line)) locs[r[id]] = [Number(r[map]), tenth(r[x]), tenth(r[y]), tenth(r[z]), r[name].trim()];
		}
	}
	if (!links.length || !Object.keys(locs).length) throw new Error(`classic-db ${DB_REV.slice(0, 8)}: missing game_graveyard_zone or world_safe_locs`);
	links.sort((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2]);
	return { links, locs };
}

// -> { rev, url, links, locs }: extractGraveyards' tables, cached as
// graveyards.json beside the dump (sim's loadWorld, for the deathskip).
async function loadGraveyards({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const data = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: 'graveyards.json', extract: extractGraveyards, write: (d) => `${JSON.stringify(d)}\n` });
	return { rev: DB_REV, url: DB_URL, ...data };
}

// Lines of the dump -> { paths: { entry: [yd, waitSec] }, summons: { script: n } }:
// script_waypoint, the paths escort scripts walk (an entry's PathId 0, else its
// lowest; yd its 3D length, rounded; waitSec its points' WaitTime, ms → s,
// rounded), and dbscripts_on_quest_start's summons (command 10
// SCRIPT_COMMAND_TEMP_SUMMON_CREATURE) per script id (a quest's StartScript, its
// id). For the sim's escort facts (sim/escorts.js).
async function extractEscortPaths(lines) {
	const t = columnTracker();
	const pts = new Map();
	const summons = {};
	for await (const line of lines) {
		if (t.see(line)) continue;
		if (line.startsWith('INSERT INTO `script_waypoint` VALUES')) {
			const [entry, pid, point, x, y, z, wait] = ['Entry', 'PathId', 'Point', 'PositionX', 'PositionY', 'PositionZ', 'WaitTime'].map((c, i) => t.at('script_waypoint', c, i < 6 ? i : 7));
			for (const r of tuples(line)) {
				const k = Number(r[entry]);
				if (!pts.has(k)) pts.set(k, new Map());
				const byPath = pts.get(k);
				const p = Number(r[pid]);
				if (!byPath.has(p)) byPath.set(p, []);
				byPath.get(p).push([Number(r[point]), Number(r[x]), Number(r[y]), Number(r[z]), Number(r[wait])]);
			}
		} else if (line.startsWith('INSERT INTO `dbscripts_on_quest_start` VALUES')) {
			const [id, cmd] = ['id', 'command'].map((c, i) => t.at('dbscripts_on_quest_start', c, i === 0 ? 0 : 3));
			for (const r of tuples(line)) if (Number(r[cmd]) === 10) summons[r[id]] = (summons[r[id]] || 0) + 1;
		}
	}
	if (!pts.size) throw new Error(`classic-db ${DB_REV.slice(0, 8)}: missing script_waypoint`);
	const paths = {};
	for (const k of [...pts.keys()].sort((a, b) => a - b)) {
		const byPath = pts.get(k);
		const list = byPath.get(0) || byPath.get(Math.min(...byPath.keys()));
		list.sort((a, b) => a[0] - b[0]);
		let yd = 0;
		let wait = 0;
		for (let i = 0; i < list.length; i++) {
			wait += list[i][4];
			if (i) yd += Math.hypot(list[i][1] - list[i - 1][1], list[i][2] - list[i - 1][2], list[i][3] - list[i - 1][3]);
		}
		paths[k] = [Math.round(yd), Math.round(wait / 1000)];
	}
	return { paths, summons };
}

// -> { rev, url, paths, summons }: extractEscortPaths' tables, cached as
// escort_paths.json beside the dump (sim/escorts.js). Throws like loadClassicDb.
async function loadEscortPaths({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const data = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: 'escort_paths.json', extract: extractEscortPaths, write: (d) => `${JSON.stringify(d)}\n` });
	return { rev: DB_REV, url: DB_URL, ...data };
}

// -> { rev, url, objects }: extractObjectFacts' table, cached as
// OBJECT_FACTS_CACHE beside the dump (readObjectFacts reads it back without
// the dump). Throws like loadClassicDb.
const OBJECT_FACTS_CACHE = 'gameobject_facts.json';
async function loadObjectFacts({ sourcesDir, offline = false, fetchImpl = globalThis.fetch, log = () => {}, url = DB_URL, hash = DB_SHA256, maxBytes = MAX_BYTES }) {
	const objects = await cachedExtract({ sourcesDir, offline, fetchImpl, log, url, hash, maxBytes, name: OBJECT_FACTS_CACHE, extract: extractObjectFacts, write: (data) => `${JSON.stringify(data)}\n` });
	return { rev: DB_REV, url: DB_URL, objects };
}

// The cached extract's path, and its table when present (null otherwise): for
// synchronous readers (the sim world), after loadObjectFacts made it.
const objectFactsFile = (sourcesDir) => path.join(sourcesDir, 'cmangos', DB_REV.slice(0, 12), OBJECT_FACTS_CACHE);
function readObjectFacts(sourcesDir) {
	const file = objectFactsFile(sourcesDir);
	return fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null;
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

// meta.json's entry when `data build` filled objective counts from quest_template.
const COUNTS_SOURCE = {
	name: 'CMaNGOS classic-db: quest objective counts',
	url: DB_URL,
	revision: DB_REV,
	license: 'GPL-3.0; quest objective counts only, used as facts: an objective whose count QuestieDB and pfQuest lack takes the matching quest_template count',
	copyright: 'CMaNGOS (https://github.com/cmangos/classic-db)',
};

module.exports = {
	loadClassicDb, loadSpawnHeights, loadTraining, loadCreatureTemplates, loadQuestCounts, loadObjectFacts, loadGraveyards, loadEscortPaths, readObjectFacts, objectFactsFile, extractLines, extractSpawnHeights, extractTraining, extractCreatureTemplates, extractQuestCounts, extractObjectFacts, extractGraveyards, extractEscortPaths, serializeSpawnHeights, sqlFields,
	DB_REV, DB_URL, DB_SHA256, MAX_BYTES, LIFT_ENTRIES, TRAM_ENTRIES, PORTAL_TRIGGERS, HEIGHTS_SOURCE, SPAWNZ_CACHE, COUNTS_SOURCE, OBJECT_FACTS_CACHE,
};
