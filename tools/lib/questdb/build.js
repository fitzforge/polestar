'use strict';
// `questdb build`: data/forever (quests, npcs, objects, items, map-frames)
// -> the load-on-demand addon addon/Polestar_QuestDB: a compact quest
// database for Polestar's quest markers, available-quest markers, tooltips
// and nameplate icons (runtime: addon/Polestar/Quests). Same inputs give
// byte-identical files.
//
// Lua record layouts (positional, read by addon/Polestar/Quests/QuestDB.lua):
//
//   quests[id]  = { title, level, minLevel, races, classes, faction, start, finish,
//                   startItem, pre, excl, objectives, zone, events, skill, holiday,
//                   preAll, raceHigh, items }
//     races     the race mask's low 32 bits (the Era races), for bit.band
//     raceHigh  the mask's Skyborne bits as a number: +1 High Order (Alliance,
//               mask bit 2^32), +2 Windshaper (Horde, 2^33). 3 for a pfQuest-only
//               (Era) mask, which never excludes Skyborne; nil when races is nil
//     faction   1 Alliance, 2 Horde, nil either (from the race mask, else the givers)
//     start/finish  one ref or a list of refs: NPC id > 0, object id < 0
//     startItem one item id or a list; excl: one id or a list
//     items     the items the quest hands over (QuestieDB's sourceItemId and
//               requiredSourceItems: Bethor's Scroll for Thule Ravenclaw), one
//               id or a list; never its rewards
//     pre / preAll  blocking prerequisites (tools/lib/data/prereqs.js, breadcrumbs
//               dropped): one of `pre` must be done, and every one of `preAll`
//     objectives  flat triples kind, id, count: kind 1 kill (npc), 2 item, 3 object,
//                 4 event (id = 1-based group in `events`, count nil)
//     events    flat quads map, frame, x, y (frame 0 Era, 1 live)
//     skill     required profession skill line; holiday: event id (never "available")
//   npcs[id]    = { name, map, frame, n, x1, y1, r1, ..., map, frame, n, ... }
//   objects[id] = same as npcs
//     n clusters per map, together covering every known spawn there (the
//     reference data's `pts` and `more`); x, y map percent (frame 0 = Era,
//     1 = live), r yards
//   items[id]   = { name, nNpc, npc, chance, ..., nObj, object, chance, ..., vendor, ... }
//     chance in percent, best first; vendors to the end of the record

const fs = require('node:fs');
const path = require('node:path');
const { clusterPoints } = require('./cluster');
const { blockingPrereqs } = require('../data/prereqs');
const { header } = require('../generated');

const { ROOT, DATA } = require('../paths');
const { FACTION_RACES } = require('../game/races');
const SCHEMA = 1;
const CHUNK = 1000; // records per AddData call
const OBJECTIVE_KIND = { kill: 1, item: 2, object: 3, event: 4 };

const DEFAULTS = {
	clusterRadius: 70, // yards: points closer than this to a centroid join it
	maxDroppers: 8, // NPC drop sources per item (best chance first)
	maxObjectSources: 6, // object sources per item
	maxVendors: 4, // vendors per item
};

function readJson(file) {
	if (!fs.existsSync(file)) throw new Error(`missing ${file} (run: node tools/polestar.js data build)`);
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

const byNum = (a, b) => a - b;
const ids = (obj) => Object.keys(obj).map(Number).filter(Number.isFinite).sort(byNum);
const list = (v) => (Array.isArray(v) ? v.filter((x) => Number.isFinite(x)) : []);
// One value stays a number, several become a list, none is nil.
const oneOrList = (arr) => (arr.length === 0 ? null : arr.length === 1 ? arr[0] : arr);

function roundChance(c) {
	if (!Number.isFinite(c)) return 0;
	return c < 1 ? Math.round(c * 100) / 100 : Math.round(c * 10) / 10;
}

// Race masks may carry Forever's Skyborne bits, 2^32 (Alliance) and 2^33
// (Horde), past the reach of 32-bit bitwise operators: split arithmetically.
function raceParts(races) {
	return { low: races % 2 ** 32, high: Math.floor(races / 2 ** 32) };
}

function questFaction(q, npcs) {
	if (q.races) {
		const { low, high } = raceParts(q.races);
		if ((low & ~FACTION_RACES.Alliance) === 0 && (high & ~1) === 0) return 1;
		if ((low & ~FACTION_RACES.Horde) === 0 && (high & ~2) === 0) return 2;
		return null;
	}
	const givers = list(q.start && q.start.npc);
	if (givers.length === 0) return null;
	let side = null;
	for (const id of givers) {
		const f = npcs[id] && npcs[id].faction;
		const s = f === 'A' ? 1 : f === 'H' ? 2 : 0;
		if (s === 0 || (side !== null && side !== s)) return null;
		side = s;
	}
	return side;
}

// Sorted top-N sources from { "<id>": chance } (ties by id).
function topSources(drops, cap) {
	return Object.entries(drops || {})
		.map(([id, chance]) => [Number(id), roundChance(Number(chance))])
		.filter(([id]) => Number.isFinite(id))
		.sort((a, b) => b[1] - a[1] || a[0] - b[0])
		.slice(0, cap);
}

function buildQuestDB({ dataDir, options = {} } = {}) {
	const opts = { ...DEFAULTS, ...options };
	dataDir = dataDir || DATA;
	const quests = readJson(path.join(dataDir, 'quests.json'));
	const npcs = readJson(path.join(dataDir, 'npcs.json'));
	const objects = readJson(path.join(dataDir, 'objects.json'));
	const items = readJson(path.join(dataDir, 'items.json'));
	const frames = (readJson(path.join(dataDir, 'map-frames.json')).era) || {};
	const metaFile = path.join(dataDir, 'meta.json');
	const meta = fs.existsSync(metaFile) ? JSON.parse(fs.readFileSync(metaFile, 'utf8')) : { sources: [] };
	const warnings = [];

	const wantNpc = new Set();
	const wantObject = new Set();
	const wantItem = new Set();
	const usedMaps = new Set();

	// --- quests -------------------------------------------------------------
	const questRecords = new Map();
	for (const id of ids(quests)) {
		const q = quests[id];
		if (!q || typeof q.title !== 'string') continue;
		const start = [...list(q.start && q.start.npc), ...list(q.start && q.start.object).map((o) => -o)];
		const finish = [...list(q.end && q.end.npc), ...list(q.end && q.end.object).map((o) => -o)];
		for (const r of [...start, ...finish]) (r > 0 ? wantNpc : wantObject).add(Math.abs(r));
		const startItems = list(q.start && q.start.item);
		for (const it of startItems) wantItem.add(it);

		const objectives = [];
		const events = [];
		for (const o of q.objectives || []) {
			const kind = OBJECTIVE_KIND[o.type];
			if (!kind) continue;
			if (kind === 4) {
				if (!(Number.isFinite(o.map) && Number.isFinite(o.x) && Number.isFinite(o.y))) {
					objectives.push(4, 0, null);
					continue;
				}
				events.push(o.map, o.f === 'l' ? 1 : 0, Math.round(o.x * 10) / 10, Math.round(o.y * 10) / 10);
				if (o.f !== 'l') usedMaps.add(o.map);
				objectives.push(4, events.length / 4, null);
				continue;
			}
			if (!Number.isFinite(o.id)) continue;
			objectives.push(kind, o.id, Number.isFinite(o.count) ? o.count : null);
			if (kind === 1) wantNpc.add(o.id);
			else if (kind === 2) wantItem.add(o.id);
			else wantObject.add(o.id);
		}

		const { all: preAll, any: preAny } = blockingPrereqs(q, (p) => quests[p] || null);
		// Only QuestieDB's Forever store carries the Skyborne bits; a pfQuest mask is an Era mask.
		const forever = Array.isArray(q.source) && q.source.some((s) => String(s).startsWith('questie'));
		questRecords.set(id, [
			q.title,
			Number.isFinite(q.level) ? q.level : null,
			Number.isFinite(q.minLevel) ? q.minLevel : null,
			q.races ? raceParts(q.races).low : null,
			q.classes || null,
			questFaction(q, npcs),
			oneOrList(start),
			oneOrList(finish),
			oneOrList(startItems),
			oneOrList(preAny.filter((p) => quests[p])),
			oneOrList(list(q.excl).filter((p) => quests[p])),
			objectives.length ? objectives : null,
			Number.isFinite(q.zone) ? q.zone : null,
			events.length ? events : null,
			Number.isFinite(Number(q.skill)) && q.skill ? Number(q.skill) : null,
			q.event ? (Number(q.event) || 1) : null,
			oneOrList(preAll.filter((p) => quests[p])),
			q.races ? (forever ? raceParts(q.races).high : 3) : null,
			oneOrList([...new Set([...list([q.sourceItem]), ...list(q.requiredItems)])].sort(byNum)),
		]);
	}

	// --- items (their sources pull in more NPCs and objects) ----------------
	const itemRecords = new Map();
	for (const id of [...wantItem].sort(byNum)) {
		const it = items[id];
		if (!it) {
			warnings.push(`item ${id} referenced by a quest is missing from items.json`);
			continue;
		}
		const droppers = topSources(it.drops && it.drops.npc, opts.maxDroppers);
		const objSources = topSources(it.drops && it.drops.object, opts.maxObjectSources);
		const vendors = list(it.vendors).slice().sort(byNum).slice(0, opts.maxVendors);
		for (const [n] of droppers) wantNpc.add(n);
		for (const [o] of objSources) wantObject.add(o);
		for (const v of vendors) wantNpc.add(v);
		itemRecords.set(id, [it.name || `Item ${id}`, droppers.length, ...droppers.flat(), objSources.length, ...objSources.flat(), ...vendors]);
	}

	// --- NPCs and objects with clustered spawns -----------------------------
	const spawnStats = { points: 0, clusters: 0 };
	function entityRecord(e) {
		const rec = [e.name];
		for (const map of ids(e.spawns || {})) {
			const s = e.spawns[map];
			const live = s.f === 'l';
			const frame = frames[map];
			if (!live && !frame) continue; // an Era point without an Era frame cannot be placed
			// Every known spawn, so every place the entity spawns gets a marker.
			const pts = [...(s.pts || []), ...(s.more || [])];
			const clusters = clusterPoints(pts, frame, { radius: opts.clusterRadius });
			if (clusters.length === 0) continue;
			spawnStats.points += pts.length;
			spawnStats.clusters += clusters.length;
			if (!live) usedMaps.add(map);
			rec.push(map, live ? 1 : 0, clusters.length);
			for (const c of clusters) rec.push(c.x, c.y, c.r);
		}
		return rec;
	}
	const npcRecords = new Map();
	for (const id of [...wantNpc].sort(byNum)) {
		const n = npcs[id];
		if (!n) continue;
		npcRecords.set(id, entityRecord(n));
	}
	const objectRecords = new Map();
	for (const id of [...wantObject].sort(byNum)) {
		const o = objects[id];
		if (!o) continue;
		objectRecords.set(id, entityRecord(o));
	}

	const mapFrames = {};
	for (const map of [...usedMaps].sort(byNum)) {
		if (frames[map]) mapFrames[map] = frames[map];
		else warnings.push(`map ${map} has Era-frame data but no Era frame`);
	}

	const db = { quests: questRecords, npcs: npcRecords, objects: objectRecords, items: itemRecords, mapFrames };
	const files = emitFiles(db, meta);
	const luaBytes = Object.entries(files)
		.filter(([name]) => name.endsWith('.lua'))
		.reduce((s, [, text]) => s + Buffer.byteLength(text), 0);
	const stats = {
		quests: questRecords.size,
		npcs: npcRecords.size,
		objects: objectRecords.size,
		items: itemRecords.size,
		maps: Object.keys(mapFrames).length,
		spawnPoints: spawnStats.points,
		clusters: spawnStats.clusters,
		luaBytes,
		memoryBytes: estimateMemory(db),
	};
	return { db, files, stats, warnings };
}

// --- Lua emission -------------------------------------------------------------

function luaStr(s) {
	return `"${String(s).replace(/[\\"]/g, '\\$&').replace(/\n/g, '\\n').replace(/[\x00-\x1f\x7f]/g, (c) => `\\${c.charCodeAt(0)}`)}"`;
}

function luaVal(v) {
	if (v === null || v === undefined) return 'nil';
	if (typeof v === 'number') {
		if (!Number.isFinite(v)) throw new Error(`non-finite number in quest data: ${v}`);
		return String(Object.is(v, -0) ? 0 : v);
	}
	if (typeof v === 'string') return luaStr(v);
	if (typeof v === 'boolean') return v ? 'true' : 'false';
	if (Array.isArray(v)) {
		let end = v.length;
		while (end > 0 && (v[end - 1] === null || v[end - 1] === undefined)) end--;
		return `{${v.slice(0, end).map(luaVal).join(',')}}`;
	}
	const keys = Object.keys(v).sort();
	return `{${keys.map((k) => `${/^[A-Za-z_]\w*$/.test(k) ? k : `[${/^-?\d+$/.test(k) ? k : luaStr(k)}]`}=${luaVal(v[k])}`).join(',')}}`;
}

const HEADER = header('lua', 'questdb build', 'data/forever');

function dataFile(kind, records, comment) {
	const lines = [HEADER, `-- ${comment}`, '', 'local Q = Polestar and Polestar.QuestDB', 'if not (Q and Q.AddData) then return end', 'local add = Q.AddData', ''];
	const entries = [...records.entries()];
	for (let i = 0; i < entries.length; i += CHUNK) {
		lines.push(`add(${luaStr(kind)}, {`);
		for (const [id, rec] of entries.slice(i, i + CHUNK)) lines.push(`[${id}]=${luaVal(rec)},`);
		lines.push('})');
	}
	if (entries.length === 0) lines.push(`add(${luaStr(kind)}, {})`);
	return lines.join('\n') + '\n';
}

function version() {
	try {
		return JSON.parse(fs.readFileSync(path.join(ROOT, 'package.json'), 'utf8')).version || '0.0.0';
	} catch {
		return '0.0.0';
	}
}

function licenseText(meta) {
	const out = ['Polestar quest database: third-party notices', '============================================', '',
		'The data in this folder was generated for Polestar from the reference data', 'sources below (quest, NPC, object and item facts, spawn positions, map frames).', ''];
	for (const s of meta.sources || []) {
		const title = s.name || 'source';
		out.push(title, '-'.repeat(title.length));
		if (s.url) out.push(`URL: ${s.url}`);
		if (s.revision) out.push(`Revision: ${s.revision}`);
		if (s.license) out.push(`License: ${s.license}`);
		if (s.notice) out.push('', s.notice.trim());
		out.push('');
	}
	return out.join('\n');
}

const DATA_FILES = ['MapFrames.lua', 'Quests.lua', 'Npcs.lua', 'Objects.lua', 'Items.lua'];

function emitFiles(db, meta) {
	const files = {};
	files['Polestar_QuestDB.toc'] = [
		'## Interface: 16001',
		'## Title: Polestar Quest Database',
		'## Notes: Quest, NPC, object and item data for Polestar\'s quest markers and tooltips. Loaded on demand.',
		...require('../i18n/toc').tocLines('Polestar_QuestDB'),
		'## Author: Polestar',
		`## Version: ${version()}`,
		'## Category: Quests',
		'## LoadOnDemand: 1',
		'## Dependencies: Polestar',
		'',
		...DATA_FILES,
		'',
	].join('\n');
	const frameLines = [HEADER, '-- Era map frames for every map this database places points on.', '', 'local Q = Polestar and Polestar.QuestDB',
		'if not (Q and Q.AddData) then return end', '', `Q.AddData("meta", ${luaVal({ schema: SCHEMA, quests: db.quests.size, npcs: db.npcs.size, objects: db.objects.size, items: db.items.size })})`, ''];
	frameLines.push('if Polestar.RegisterMapFrames then', '\tPolestar.RegisterMapFrames({ era = {');
	for (const map of Object.keys(db.mapFrames).map(Number).sort(byNum)) {
		const f = db.mapFrames[map];
		frameLines.push(`\t\t[${map}] = ${luaVal({ c: f.c, left: f.left, right: f.right, top: f.top, bottom: f.bottom })},`);
	}
	frameLines.push('\t} })', 'end');
	files['MapFrames.lua'] = frameLines.join('\n') + '\n';
	files['Quests.lua'] = dataFile('quests', db.quests, 'title, level, minLevel, races, classes, faction, start, finish, startItem, pre (one of), excl, objectives, zone, events, skill, holiday, preAll (every one), raceHigh, items (handed over)');
	files['Npcs.lua'] = dataFile('npcs', db.npcs, 'name, then per map: uiMapID, frame (0 Era, 1 live), cluster count, x, y, radius (yd) per cluster');
	files['Objects.lua'] = dataFile('objects', db.objects, 'name, then per map: uiMapID, frame (0 Era, 1 live), cluster count, x, y, radius (yd) per cluster');
	files['Items.lua'] = dataFile('items', db.items, 'name, NPC source count, (npc, chance)..., object source count, (object, chance)..., vendors...');
	files['LICENSE-DATA.txt'] = licenseText(meta);
	return files;
}

// --- In-game memory estimate (Lua 5.1, 64-bit client) ----------------------------
// Table header 56 B; array slot 16 B (TValue); hash node 40 B, rounded up to
// a power of two; interned strings 25 B + length, counted once. Plus 10%
// allocator overhead.

function estimateMemory(db) {
	const strings = new Set();
	let bytes = 0;
	const pow2 = (n) => (n <= 0 ? 0 : 2 ** Math.ceil(Math.log2(n)));
	function walk(v) {
		if (typeof v === 'string') strings.add(v);
		else if (Array.isArray(v)) {
			let end = v.length;
			while (end > 0 && (v[end - 1] === null || v[end - 1] === undefined)) end--;
			bytes += 56 + 16 * end;
			for (let i = 0; i < end; i++) walk(v[i]);
		}
	}
	for (const kind of ['quests', 'npcs', 'objects', 'items']) {
		const m = db[kind];
		bytes += 56 + 40 * pow2(m.size);
		for (const rec of m.values()) walk(rec);
	}
	for (const s of strings) bytes += 25 + Buffer.byteLength(s);
	return Math.round(bytes * 1.1);
}

function writeQuestDB(result, outDir) {
	fs.mkdirSync(outDir, { recursive: true });
	for (const name of fs.readdirSync(outDir)) {
		if (name.endsWith('.lua') && !(name in result.files)) fs.rmSync(path.join(outDir, name));
	}
	for (const [name, text] of Object.entries(result.files)) fs.writeFileSync(path.join(outDir, name), text);
}

module.exports = { buildQuestDB, writeQuestDB, estimateMemory, questFaction, DEFAULTS, SCHEMA };
