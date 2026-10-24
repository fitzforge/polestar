'use strict';
// World model per faction (docs/legacy/SIMULATION-js.md §1), built once from
// data/forever and cached in data/sim/world-<faction>.json. The cache records
// a hash of what the builder reads (worldInputs: the data/forever files by
// content, not meta.json; the local walking grid, data/local/nav4: its index
// and tile files, gridFingerprint; the rules' hand-overs; the client instance
// tables; this builder's version): when any of them changes the world
// is rebuilt. Spawns flagged f "l" convert through the
// Forever (live) map frames. Race masks carry Forever's Skyborne bits (32
// Alliance, 33 Horde). Prerequisites: the canonical blocking prerequisites of
// tools/lib/data/prereqs.js (the guide compiler's), DungeonJournal-only quests
// keep their journal chain, and a quest without any prerequisite data gets
// the `next` implication (`preRules` counts each rule). Exclusive quests are
// one-way lists (`excl`: unavailable while one of them is in the log or done).
// Dungeons (dungeons.json) add one package per dungeon and the quests whose
// objectives are inside it. Solo filter (tools/lib/sim/solo.js): quests a
// levelling character cannot do alone (instance, PvP, rare drops,
// reputation) are excluded with a category, counted in `solo`; the dungeon
// family gets dungeons.json's quests back as dungeon packages. Quests on
// elites or on droppers 5+ levels above the quest are kept (Fitz 2026-10-20;
// #638's rule): a quest is `elite`, group work, when an elite (rank 1-3) is a
// kill target, the dropper chosen for an item objective or the dropper of its
// starting item; its elite camps are `elite`. v2 prices them for a party
// (camp.js) and marks the actions group.
//
// Contents (all positions are indices into `points`):
//   points   [[c, region, wx, wy, map, z]]   world yards; region separates islands; z the
//            height: a spawn's (spawnz.json) or travel end's, else the walking grid's floor
//            (gridFloor; null off the grid); `heights` counts each source
//   nodes    transport nodes: flight masters usable by the faction and docks
//   taxi     [[a, b, seconds]] flights between nodes (both must be known)
//   rides    [[a, b, seconds, wait, id]] boats, zeppelins, trams (both ways);
//            the Zephras Isle exits one way only (isle -> mainland)
//   inns     [{ name, pt }]
//   hubs     quest givers/enders clustered at 150 yd, with fp/inn/trainers
//   quests   [{ id, title, level, minLevel, races, classes, pre, preAll, excl, ...,
//              giver, ender, accept: {pt, work}, tasks: [{pt, work}],
//              gName, eName (giver/ender names), gPos, ePos ({map, x, y} map percent),
//              gAlt?, eAlt? (every friendly giver/ender, { 'npc:<id>': pt }, when more than one),
//              kind: 'delivery' (no objectives, ender ≠ giver) | 'startItem' (accepted from an item)
//                    | 'talk' (no objectives, ender = giver) | 'work',
//              objs: [{ oi (raw objectives index; -1: the run of an escort with no raw
//                       objectives, 96204), type: kill|item|object|event|talk, id, count,
//                       item, questItem, camps: [campId], chances: { 'npc:<id>': % | null }, task }] }]
//              (an object's chance is % of a loot × its mean count: over 100 when a
//              loot gives several, a termite mound's 1-20)
//              (every event objective points at the one placed task and any one trigger
//              completes the quest: count tasks, not objs, as units of work)
//              (an escort's escortRun, its NPC's walk, is attached by sim's loadWorld:
//              escorts.js, not part of the file)
//   camps    [{ id, pt, c, region, radius (yd to the farthest member spawn), spawns, levelMin, levelMax, respawn, sources }]
//              (respawn: seconds, the creatures' and objects' spawntimesecs from CMaNGOS
//              classic-db; an object without one OBJECT_RESPAWN_EST, a used one USED_OBJECT_RESPAWN)
//   packages [{ key, zone, zoneName, band, quests, steps: [[kind, quest, task, pt]] }]
//   grind    { spacing: [yards by mob level] }
//   starts   { Race: { zone, pt, quest } }
//   zoneMin  { map: level }  P10 of the zone's hostile normal-rank spawns (tools/lib/maps/zonelevels.js)
//   danger   [{ region, gx0, gy0, nx, ny, cell, z: [map per cell, 0 = unknown] }]
//            which zone each 200-yard cell belongs to (most NPC spawns, gaps
//            filled from neighbours up to 3 cells): the travel-safety check
//            samples walking legs on it (docs/legacy/SIMULATION-js.md §1)
//   services { trainer: { CLASS: [{ pt, npc }] }, repair, food, ammo, inn, flight: [{ pt, npc }],
//            riding: [{ pt, npc, races, vendor?, vendorPt?, item?, itemCopper? }] }
//            friendly service NPCs' sites (tools/lib/sim/services.js);
//            flight: this faction's flight nodes; riding: each friendly riding
//            trainer's site, with the friendly mount vendor standing by it and its mount
//   serviceSet { pt: [kind…] } the services at each point (trainers as 'trainer:CLASS')
//   areas    [{ id, pt, c, region, members: [pt], hub, kinds: { giver, ender, camp, service, node, task } }]
//            the places a route chooses between: every giver, ender, task, camp, service, inn and
//            node point; towns (hubs) first within 200 yd of their centre, the rest at most
//            250 yd across (tools/lib/sim/areas.js)
//   pointArea [area id per point, -1 = none]
//   training { CLASS: { level: copper } } class training costs (training.json)
//   trainingSpells { CLASS: { level: [[spell, copper, name, rank]] } } | null:
//            the spells behind them (training.json spells)
//   riding   { level, cost } | null: Apprentice Riding's level and copper
//            (training.json riding)
//   classes  { Race: [CLASS] } this faction's races (labelled as in `starts`) and their classes (races.json)
// Work items: [kind, a, b, c, d]
//   ['kill', mobLevel, count, elite(0/1), spacingYards, npcId]   count may be fractional (expected kills);
//                        npcId: the mob killed (shared kill credit, evaluate.js)
//   ['use', count]       object uses
//   ['escort']           fixed-duration event (an escort or a defend event), run where it starts
//   ['buy']              vendor purchase
//   ['visit']            reach a place

const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const { loadData } = require('../route/model');
const { planOrder } = require('./tour');
const { zoneLevels } = require('../maps/zonelevels');
const SOLO = require('./solo');
const { blockingPrereqs } = require('../data/prereqs');
const { CLASS_BY_FILE, FACTION_RACES, SKYBORNE_BIT, RACE_BY_FILE, hasBit, raceLabel } = require('../game/races');
const { boxOf, moreInner } = require('../maps/inner');
const { buildCamps } = require('./camps');
const { pickServices, serviceSetOf } = require('./services');
const { buildAreas } = require('./areas');
const { isEscort } = require('../dsl/escort');
const RULES = require('./rules');
const { readObjectFacts, objectFactsFile } = require('../travel/cmangos');

const BUILDER_VERSION = 30;
// Yards: a mount vendor this close to a riding trainer is its stop's optional mount buy.
const RIDE_PAIR_YD = 60;

// The floor each city lift's city lies on: Thunder Bluff on the mesa top,
// the Undercity below the Ruins. A check, not the rule: the end maps come
// from the spawns (liftEndMaps, the busier floor is the city); `sim world`
// warns when they disagree with this table.
const CITY_LIFT_FLOOR = {
	'lift-thunder-bluff-north': 'top',
	'lift-thunder-bluff-west': 'top',
	'lift-undercity-east': 'bottom',
	'lift-undercity-south': 'bottom',
	'lift-undercity-west': 'bottom',
};

const FACTION_BIT = { Alliance: 1, Horde: 2 };
const PROFESSION_SORTS = new Set([24, 101, 121, 181, 182, 201, 264, 304, 324]);
const BATTLEGROUNDS = new Set([1459, 1460, 1461]);
// Maps whose land does not connect to the rest of their continent on foot.
const ISLANDS = { 1438: 1, 1457: 1, 2521: 2, 2665: 2 };
// Zephras Isle (Forever): Skyborne-only starting island.
const ISLE_MAPS = [2521, 2665];
const DANGER_CELL = 200; // yards per travel-safety grid cell

// Is a race mask open to some race of the faction? Era bits 0-7, and Forever's
// Skyborne bit on each side past 32 bits.
function maskForFaction(races, faction) {
	return ((races % 2 ** 32) & FACTION_RACES[faction]) !== 0 || hasBit(races, SKYBORNE_BIT[faction]);
}

// Zephras Isle exits (Forever, in-game transports; positions from the live
// client maps, rides estimated): Horde airship to northern Mulgore; Alliance
// zeppelin to Dalaran and the Skyborne portal to Stormwind. One way: the
// Skyborne leave the isle for good (docs/legacy/SIMULATION-js.md "Starts").
const SKYBORNE_EXITS = {
	Horde: [{ name: 'Zephras Isle airship', a: { map: 2521, x: 57.92, y: 80.78, f: 'l' }, b: { c: 1, wx: -658, wy: 426, map: 1412 }, ab: 90, wait: 60 }],
	Alliance: [{ name: 'Zephras Isle zeppelin + Skyborne portal', a: { map: 2521, x: 65.81, y: 83.44, f: 'l' }, b: { c: 0, wx: -8840.6, wy: 489.7, map: 1453 }, ab: 110, wait: 60 }],
};

const SITE_R = 70; // yards: objective spawns this close form one site
const DUP_R = 10; // yards: one spawn recorded on two overlapping zone maps
const SPAWN_DUP_R = 4; // yards: one spawn recorded twice (QuestieDB's Forever spawns, pfQuest's copies)
const VOTE_R = 150; // yards: cell of the zone vote (spawn records per map around a spot)
const HUB_R = 150; // yards: givers/enders this close form one hub
const NEAR_HUB = 200; // yards: a flight master or inn this close belongs to the hub
// Quest log size: Forever's client accepts 40 quests
// (Constants.QuestLogConsts.MAXIMUM_NUM_QUESTS_LOG_CAN_ACCEPT = 40 for its
// Camelot game type, Blizzard_APIDocumentationGenerated/QuestConstantsDocumentation.lua;
// its quest log shows N/40; issue #30). The results up to 0.2.5 were searched
// at 20. A world option (opts.maxOpen): the cached world records it and is
// rebuilt when it differs.
const MAX_OPEN = 40;
const MIN_START_DROP = 1; // % drop chance for a quest-starting item to count
// % assumed for an item drop (objective or quest-starting item) without a
// recorded rate (Forever creatures in items.json drops with chance null);
// quest-only items (items.json `questItem`, drop only while on the quest)
// drop more often.
const UNKNOWN_DROP = 30;
const UNKNOWN_QUEST_DROP = 60;
// A kill objective on an NPC of the character's own faction that gives or
// ends the quest, or whose objective text opens with one of these verbs, is
// Questie's kill credit for a conversation ("Listen as Kalaran Windblade
// tells his story"): one interaction at the NPC.
const TALK_RE = /^\s*(speak|listen|talk|hear|show|wait|watch)\b/i;
// An NPC of the character's own faction proper (A or H, not AH: the
// Threshwackonator turns hostile) cannot be attacked, so these deeds are
// interactions too, one per credit ("Find Grunt Kor'ja and heal her wounds",
// "Use the Foreman's Blackjack on Lazy Peons", "Keep searching for Fillion").
const DEED_RE = /^\s*(find|heal|use|locate|keep searching)\b/i;

// Gameobjects that are used, not looted (CMaNGOS gameobject_template.type:
// questgiver 2, generic 5, spellfocus 8, goober 10, spellcaster 22: a tide pool,
// a moonwell, the Undercity's Testing Equipment): an item they give takes one
// use, every time, and they stay where they are.
const USED_OBJECT_TYPES = new Set([2, 5, 8, 10, 22]);
// Seconds a used object takes back: none to wait (1, so a camp's supply stays finite).
const USED_OBJECT_RESPAWN = 1;
// Seconds an object without a respawn in the data (one CMaNGOS doesn't have:
// Forever's own) takes back: an estimate, the median spawntimesecs of CMaNGOS
// classic-db's quest-item chests (180 s; 2026-10-20).
const OBJECT_RESPAWN_EST = 180;
// % a quest item drops from an object without a recorded rate: CMaNGOS
// classic-db's quest-item chests drop theirs at 99 % or more (273 of 278 pairs,
// 1.1 items a loot on average; 2026-10-20).
const OBJECT_QUEST_DROP = 100;

// Does any dropper of the item have a recorded rate?
function hasRecordedDrop(item) {
	return ['npc', 'object'].some((k) => Object.values(item.drops[k] || {}).some((c) => c != null && Number(c) > 0));
}

// Assumed % for a dropper without a recorded rate.
function unknownDrop(item) {
	return item.questItem ? UNKNOWN_QUEST_DROP : UNKNOWN_DROP;
}

// Race starts: the first quest of each starting area (its giver is the start).
// Forever: Skyborne starts on Zephras Isle for both factions (start quest found from the data).
const SKYBORNE_START = { maps: [2521, 2665], zone: 'Zephras Isle' };
const STARTS = {
	Horde: { Orc: [4641, 'Durotar'], Troll: [4641, 'Durotar'], Tauren: [747, 'Mulgore'], Undead: [363, 'Tirisfal Glades'], Skyborne: SKYBORNE_START },
	Alliance: { Human: [783, 'Elwynn Forest'], Dwarf: [179, 'Dun Morogh'], Gnome: [179, 'Dun Morogh'], NightElf: [456, 'Teldrassil'], Skyborne: SKYBORNE_START },
};

// The handover rules (rules.json, R9b) as the world reads them: quest,
// objective, item and npc, sorted by id. Their facts, sources and the other
// kinds don't change the world, nor its hash.
function handoverKey(rules) {
	return JSON.stringify(rules.filter((r) => r && r.kind === 'handover')
		.map((r) => [String(r.id), Number(r.quest), Number(r.objective), Number(r.item), Number(r.npc)])
		.sort((a, b) => (a[0] < b[0] ? -1 : a[0] > b[0] ? 1 : 0)));
}

// What the world is built from, one digest per input: the builder version, the walking grid,
// every data/forever file the builder reads (by content: a no-op `data build` keeps them, a
// hand edit changes them; meta.json, whose builtAt moves on every build, is not read), the
// handover rules, the gameobject facts and the client's instance tables. -> { name: digest }
// gridDir: the local walking grid points take their floors from (walks.js GRID_DIR).
const WORLD_DATA_FILES = [...require('../route/model').FILES, 'travel', 'trainers', 'dungeons', 'training', 'races', 'mechanics', 'spawnz'].map((f) => `${f}.json`);
function worldInputs(dataDir, sourcesDir = null, rulesFile = RULES.FILE, gridDir = require('./walks').GRID_DIR) {
	const { fileHash } = require('../requires');
	const sha1 = (s) => crypto.createHash('sha1').update(s).digest('hex');
	const out = { builder: String(BUILDER_VERSION), grid: gridFingerprint(gridDir) || '-' };
	for (const f of WORLD_DATA_FILES) {
		const file = path.join(dataDir, f);
		out[f] = fs.existsSync(file) ? fileHash(file) : '-';
	}
	// Hand-overs the guides name (rules.json `handover`, R9b).
	out.handover = sha1(handoverKey(RULES.loadRules(rulesFile)));
	// Gameobject facts (CMaNGOS classic-db): types, respawns, loot.
	const facts = sourcesDir ? objectFactsFile(sourcesDir) : null;
	out.objects = facts && fs.existsSync(facts) ? fileHash(facts) : '-';
	// Instance areas for the solo filter (Forever client Map/AreaTable).
	const qa = sourcesDir ? SOLO.foreverBuild(sourcesDir) : null;
	out.areas = qa ? `${path.basename(qa)}:${['Map.csv', 'AreaTable.csv'].map((f) => fileHash(path.join(qa, f))).join(':')}` : '-';
	return out;
}

const inputsHash = (inputs) => crypto.createHash('sha1').update(Object.entries(inputs).map(([k, v]) => `${k}:${v}\n`).join('')).digest('hex');

// The world's identity: a hash of its inputs (worldInputs).
function dataHash(dataDir, sourcesDir = null, rulesFile = RULES.FILE, gridDir = require('./walks').GRID_DIR) {
	return inputsHash(worldInputs(dataDir, sourcesDir, rulesFile, gridDir));
}

// The inputs that differ between two worlds' `inputs` (names; all of them when one has none).
function changedInputs(was, now) {
	if (!was || !now) return Object.keys(now || was || {});
	return [...new Set([...Object.keys(was), ...Object.keys(now)])].filter((k) => was[k] !== now[k]);
}

// The walking grid's identity: its index.json and every tile and graph file's name and size
// (a rebuilt tile is another size), or null without a grid.
function gridFingerprint(dir) {
	const index = path.join(dir, 'index.json');
	if (!fs.existsSync(index)) return null;
	const h = crypto.createHash('sha1').update(fs.readFileSync(index));
	for (const sub of ['tiles', 'graph']) {
		const root = path.join(dir, sub);
		if (!fs.existsSync(root)) continue;
		const files = fs.readdirSync(root, { recursive: true }).map(String).sort();
		for (const f of files) {
			const st = fs.statSync(path.join(root, f));
			if (st.isFile()) h.update(`${sub}/${f}:${st.size}\n`);
		}
	}
	return h.digest('hex');
}

// A point's floor on the walking grid (tools/lib/nav/path.js on data/local/nav4): ->
// (c, wx, wy, hint) => { z, floors } | null (no surface within snap's reach). The column is the
// one the router snaps a point without a height to (snap's rule: the nearest column holding a
// surface, its lowest indoor floor, else the terrain's top); its storeys are its surfaces snap
// would take strictly (open, in a region of at least SNAP_REGION) more than Z_STEP apart. With a
// hint (the height of a nearby spawn of the point's entity) the storey nearest it is the floor,
// else snap's surface; floors counts the storeys (several and no hint: a guess, `ambiguous`).
// cache (optional, floorCache's map): (c, wx, wy) -> [snap's z, ...storeys] or 0 (no surface),
// read before the grid and filled from it (the snap and the storeys don't depend on the hint).
function gridFloor(nav, cache = null) {
	const { TILE_CELLS, FLAG } = require('../nav/grid/format');
	const { SNAP_REGION } = require('../nav/path');
	const surfaces = (c, wx, wy) => {
		const s = nav.snap({ c, wx, wy });
		if (!s) return 0;
		const { col, row } = s.tile;
		const t = nav.tile(c, col, row);
		const k = s.cell.j * TILE_CELLS + s.cell.i;
		const open = [];
		for (let e = t.first[k]; e < t.first[k + 1]; e++) {
			if (t.flags[e] & FLAG.BLOCKED || !nav.isOpen(t, k, e)) continue;
			const size = nav.regionSize(c, col, row, e);
			if (size === null || size >= SNAP_REGION) open.push(t.z[e]);
		}
		open.sort((a, b) => a - b);
		return [s.z, ...open];
	};
	return (c, wx, wy, hint = null) => {
		let v;
		if (cache) {
			const key = `${c}:${wx}:${wy}`;
			v = cache.get(key);
			if (v === undefined) cache.set(key, (v = surfaces(c, wx, wy)));
		} else v = surfaces(c, wx, wy);
		if (!v) return null;
		let floors = 0;
		for (let i = 1; i < v.length; i++) if (i === 1 || v[i] - v[i - 1] > Z_STEP) floors++;
		let z = v[0];
		if (Number.isFinite(hint)) for (let i = 1; i < v.length; i++) if (Math.abs(v[i] - hint) < Math.abs(z - hint)) z = v[i];
		return { z, floors };
	};
}

// The floors gridFloor read from the walking grid, kept across world builds (BuildPerf: the
// snap pass decodes some 800 tiles 2.8 times over, most of a world build) in
// <simDir>/floors.json (a worktree's data/sim: the shared store's, cas.js), valid for one grid and one snap rule (key: gridFingerprint and the
// sources of nav/path.js and nav/grid/format.js). -> { map, save() }; save merges with what
// another world build (the other faction) wrote meanwhile.
function floorCache(simDir, gridDir = require('./walks').GRID_DIR) {
	const { fileHash } = require('../requires');
	const key = crypto.createHash('sha1').update(`${gridFingerprint(gridDir)}|${fileHash(require.resolve('../nav/path'))}|${fileHash(require.resolve('../nav/grid/format'))}`).digest('hex');
	// A worktree's data/sim reads and writes the shared store's floors (cas.js), seeded from its own.
	const cas = require('./cas');
	const own = path.join(simDir, 'floors.json');
	const file = cas.enabled(simDir) ? cas.file('floors', key) : own;
	if (file !== own && !fs.existsSync(file) && fs.existsSync(own)) {
		try {
			if (JSON.parse(fs.readFileSync(own, 'utf8')).key === key) cas.copy(own, file);
		} catch {}
	}
	const read = () => {
		try {
			const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
			if (doc.key === key) return new Map(Object.entries(doc.floors));
		} catch {}
		return new Map();
	};
	const map = read();
	const n0 = map.size;
	return {
		map,
		save() {
			if (map.size === n0) return;
			for (const [k, v] of read()) if (!map.has(k)) map.set(k, v);
			fs.mkdirSync(path.dirname(file), { recursive: true });
			fs.writeFileSync(`${file}.${process.pid}.tmp`, JSON.stringify({ key, floors: Object.fromEntries(map) }));
			fs.renameSync(`${file}.${process.pid}.tmp`, file);
		},
	};
}

function friendly(fac, faction) {
	if (typeof fac !== 'string' || !fac) return true;
	const f = fac.toLowerCase();
	if (f === 'a' || f === 'alliance') return faction === 'Alliance';
	if (f === 'h' || f === 'horde') return faction === 'Horde';
	return true;
}

function npcLevel(raw, fallback) {
	const lo = typeof raw.level === 'number' ? raw.level : Number.parseInt(raw.level, 10);
	const hi = typeof raw.levelMax === 'number' ? raw.levelMax : lo;
	if (!Number.isFinite(lo)) return fallback;
	return Math.round((lo + (Number.isFinite(hi) ? hi : lo)) / 2);
}

const ELITE_RANKS = new Set([1, 2, 3]);

// Greedy density clustering on world points (radius r): seeds in order of
// most neighbours (ties: input order). -> [{ members: [idx], cx, cy, size }]
function cluster(pts, r) {
	const n = pts.length;
	if (!n) return [];
	const cell = new Map();
	const key = (gx, gy) => gx * 100003 + gy;
	for (let i = 0; i < n; i++) {
		const k = key(Math.floor(pts[i].wx / r), Math.floor(pts[i].wy / r));
		if (!cell.has(k)) cell.set(k, []);
		cell.get(k).push(i);
	}
	const r2 = r * r;
	const neigh = (i) => {
		const out = [];
		const gx = Math.floor(pts[i].wx / r);
		const gy = Math.floor(pts[i].wy / r);
		for (let dx = -1; dx <= 1; dx++) {
			for (let dy = -1; dy <= 1; dy++) {
				const list = cell.get(key(gx + dx, gy + dy));
				if (!list) continue;
				for (const j of list) {
					if (pts[j].region !== pts[i].region) continue;
					const ddx = pts[j].wx - pts[i].wx;
					const ddy = pts[j].wy - pts[i].wy;
					if (ddx * ddx + ddy * ddy <= r2) out.push(j);
				}
			}
		}
		return out;
	};
	const nb = [];
	for (let i = 0; i < n; i++) nb.push(neigh(i));
	const order = [...Array(n).keys()].sort((a, b) => nb[b].length - nb[a].length || a - b);
	const used = new Uint8Array(n);
	const out = [];
	for (const s of order) {
		if (used[s]) continue;
		const members = nb[s].filter((j) => !used[j]);
		for (const j of members) used[j] = 1;
		let cx = 0;
		let cy = 0;
		for (const j of members) {
			cx += pts[j].wx;
			cy += pts[j].wy;
		}
		out.push({ seed: s, members, cx: cx / members.length, cy: cy / members.length, size: members.length });
	}
	return out;
}

// One spawn recorded on two overlapping zone maps (map frames overlap: the
// Barrens map covers Durotar, so two of the Valley of Trials' Lazy Peons are
// recorded on both) counts once, on its home map: the map most spawn records
// around it use (`votes`, every entity's records nearby: zones are
// contiguous), then the map most of the entity's own spawns use, then the map
// where it lies furthest from the edge (Gryphon Master Talonaxe: Hillsbrad
// 94.3,3.5 and The Hinterlands 9.75,44.47). Before any of that, a city map
// beats the zone around it (`inner(a, b)`: a's map lies inside b's, R22):
// someone in Darnassus is recorded on Teldrassil too, but stands in the city.
// -> { pts, better } with better(a, b) > 0 when a's map is the better home.
function dedupeMaps(pts, votes, inner = () => false) {
	const perMap = new Map();
	for (const p of pts) perMap.set(p.map, (perMap.get(p.map) || 0) + 1);
	const better = (a, b) => {
		if (a.map === b.map) return a.edge - b.edge;
		if (inner(a, b)) return 1;
		if (inner(b, a)) return -1;
		const v = votes(a);
		return (v.get(a.map) || 0) - (v.get(b.map) || 0) || perMap.get(a.map) - perMap.get(b.map) || a.edge - b.edge;
	};
	if (perMap.size < 2) return { pts, better };
	const cell = new Map();
	const key = (gx, gy) => gx * 100003 + gy;
	pts.forEach((p, i) => {
		const k = key(Math.floor(p.wx / DUP_R), Math.floor(p.wy / DUP_R));
		if (!cell.has(k)) cell.set(k, []);
		cell.get(k).push(i);
	});
	const drop = new Uint8Array(pts.length);
	for (let i = 0; i < pts.length; i++) {
		const p = pts[i];
		const gx = Math.floor(p.wx / DUP_R);
		const gy = Math.floor(p.wy / DUP_R);
		for (let dx = -1; dx <= 1 && !drop[i]; dx++) {
			for (let dy = -1; dy <= 1 && !drop[i]; dy++) {
				for (const j of cell.get(key(gx + dx, gy + dy)) || []) {
					const q = pts[j];
					if (drop[j] || q.map === p.map || q.region !== p.region || Math.hypot(q.wx - p.wx, q.wy - p.wy) > DUP_R) continue;
					if (better(q, p) > 0) {
						drop[i] = 1;
						break;
					}
					drop[j] = 1;
				}
			}
		}
	}
	return { pts: pts.filter((_, i) => !drop[i]), better };
}

// A world point's identity: region, x/y to 0.1 yd and height in Z_STEP
// buckets ('n' when unknown), so a mesa top and its foot are two points.
const Z_STEP = 3; // yards
function pointKey(region, rx, ry, z) {
	return `${region}:${rx}:${ry}:${z == null ? 'n' : Math.round(z / Z_STEP)}`;
}

// Mean nearest-neighbour distance inside a cluster (yards); 0 for one spawn.
function spacingOf(pts, members) {
	if (members.length < 2) return 0;
	const m = members.length > 60 ? members.slice(0, 60) : members;
	let sum = 0;
	for (const i of m) {
		let best = Infinity;
		for (const j of members) {
			if (i === j) continue;
			const d = Math.hypot(pts[i].wx - pts[j].wx, pts[i].wy - pts[j].wy);
			if (d < best) best = d;
		}
		sum += best;
	}
	return sum / m.length;
}

function buildWorld(data, opts = {}) {
	const faction = opts.faction;
	if (!FACTION_RACES[faction]) throw new Error(`faction must be Alliance or Horde (got ${faction})`);
	const bandWidth = opts.bandWidth || 5;
	const maxOpen = opts.maxOpen || MAX_OPEN;
	const warnings = [];
	const frames = (data['map-frames'] && data['map-frames'].era) || {};
	// Live-frame (Forever) bounds: for spawns flagged f "l" and maps without an Era frame.
	const liveFrames = (data['map-frames'] && data['map-frames'].forever) || {};
	const frameOf = (map, f) => (f === 'l' && liveFrames[String(map)]) || frames[String(map)] || liveFrames[String(map)] || null;
	const zones = data.zones || {};
	const zoneName = (m) => (zones[String(m)] && zones[String(m)].name) || `map ${m}`;
	const allowedMap = (m) => {
		const z = zones[String(m)];
		return !!z && z.type === 3 && !BATTLEGROUNDS.has(Number(m));
	};

	// ---- points ----
	const points = [];
	const pointIdx = new Map();
	const regionOf = (c, map) => c * 10 + (ISLANDS[map] || 0);
	function toWorld(map, x, y, f = null) {
		const b = frameOf(map, f);
		if (b) return { c: b.c, wx: b.top + ((b.bottom - b.top) * y) / 100, wy: b.left + ((b.right - b.left) * x) / 100 };
		// No Era frame: a map-local 1000-yard square on its own continent id.
		return { c: 1000 + Number(map), wx: -10 * y, wy: -10 * x };
	}
	// Spawn records a, b (same place, different maps): a's map is the inner
	// one, by the Codex's rule (#384, maps/inner.js). Degenerate frames count as none.
	const innerBox = (map, f) => {
		const fr = frameOf(map, f);
		return fr && Math.abs(fr.right - fr.left) > 0 && Math.abs(fr.bottom - fr.top) > 0 ? boxOf(fr) : null;
	};
	const innerMap = (a, b) => moreInner(innerBox(a.map, a.f), innerBox(b.map, b.f));
	const HEIGHT_YARDS = 15;
	// A spawn this close (and over HEIGHT_YARDS) is no height for the point, but picks its storey on the grid.
	const HINT_YARDS = SITE_R;
	const spawnz = data.spawnz || { npc: {}, object: {} };
	// Height of the entity's spawn record nearest (wx, wy) within `yards`, else null.
	function heightOf(kind, id, c, wx, wy, yards = HEIGHT_YARDS) {
		let best = null;
		let bd = yards;
		for (const s of (spawnz[kind] || {})[String(id)] || []) {
			if (s[0] !== c) continue;
			const d = Math.hypot(s[1] - wx, s[2] - wy);
			if (d <= bd) {
				bd = d;
				best = s[3];
			}
		}
		return best;
	}
	// The point of an entity at (wx, wy): its spawn's height, else the floor nearest a spawn within HINT_YARDS.
	const entityPoint = (kind, id, c, wx, wy, map) => {
		const z = heightOf(kind, id, c, wx, wy);
		return addPoint(c, wx, wy, map, z, z == null ? heightOf(kind, id, c, wx, wy, HINT_YARDS) : null);
	};
	// Heights without a source's: opts.floor ((c, wx, wy, hint) => { z, floors } | null, gridFloor),
	// once per place and hint. heights counts the points by where their z came from: source (a spawn
	// or travel end), floor (one storey), hinted (a storey picked by a nearby spawn's height),
	// ambiguous (several storeys, no hint: snap's), none.
	const floorOf = opts.floor || null;
	const floorCache = new Map();
	const heights = { source: 0, floor: 0, hinted: 0, ambiguous: 0, none: 0 };
	function floorAt(c, wx, wy, hint) {
		const k = `${c}:${wx}:${wy}:${hint == null ? 'n' : hint}`;
		if (!floorCache.has(k)) floorCache.set(k, floorOf ? floorOf(c, wx, wy, hint) : null);
		return floorCache.get(k);
	}
	function addPoint(c, wx, wy, map, z = null, hint = null) {
		const rx = Math.round(wx * 10) / 10;
		const ry = Math.round(wy * 10) / 10;
		const region = regionOf(c, Number(map));
		let from = 'source';
		if (z == null) {
			const f = floorAt(c, rx, ry, hint);
			z = f ? f.z : null;
			from = !f ? 'none' : f.floors < 2 ? 'floor' : hint != null ? 'hinted' : 'ambiguous';
		}
		const k = pointKey(region, rx, ry, z);
		let i = pointIdx.get(k);
		if (i == null) {
			i = points.length;
			points.push([c, region, rx, ry, Number(map), z == null ? null : Math.round(z * 10) / 10]);
			pointIdx.set(k, i);
			heights[from]++;
		}
		return i;
	}
	const P = (i) => ({ c: points[i][0], region: points[i][1], wx: points[i][2], wy: points[i][3], map: points[i][4] });
	const dist = (a, b) => {
		const A = points[a];
		const B = points[b];
		if (A[1] !== B[1]) return Infinity;
		return Math.hypot(A[2] - B[2], A[3] - B[3]);
	};

	// ---- zone vote: spawn records per zone map around a point ----
	// Every NPC's and object's records, in VOTE_R cells; read over the 3x3
	// cells around the point (dedupeMaps).
	let voteGrid = null;
	const voteCache = new Map();
	function votes(p) {
		const gx = Math.floor(p.wx / VOTE_R);
		const gy = Math.floor(p.wy / VOTE_R);
		const ck = `${p.region}:${gx}:${gy}`;
		if (voteCache.has(ck)) return voteCache.get(ck);
		if (!voteGrid) {
			voteGrid = new Map();
			for (const set of [data.npcs, data.objects]) {
				for (const raw of Object.values(set || {})) {
					for (const [map, sp] of Object.entries((raw && raw.spawns) || {})) {
						if (!allowedMap(map) || !sp || !Array.isArray(sp.pts)) continue;
						for (const q of sp.pts) {
							if (!Array.isArray(q) || q.length < 2) continue;
							const w = toWorld(map, q[0], q[1], sp.f);
							const k = `${regionOf(w.c, Number(map))}:${Math.floor(w.wx / VOTE_R)}:${Math.floor(w.wy / VOTE_R)}`;
							let m = voteGrid.get(k);
							if (!m) voteGrid.set(k, (m = new Map()));
							m.set(Number(map), (m.get(Number(map)) || 0) + 1);
						}
					}
				}
			}
		}
		const out = new Map();
		for (let dx = -1; dx <= 1; dx++) {
			for (let dy = -1; dy <= 1; dy++) {
				const m = voteGrid.get(`${p.region}:${gx + dx}:${gy + dy}`);
				if (m) for (const [map, n] of m) out.set(map, (out.get(map) || 0) + n);
			}
		}
		voteCache.set(ck, out);
		return out;
	}

	// ---- entity spawn sites (cached) ----
	const siteCache = new Map();
	function sites(kind, id) {
		const k = `${kind}:${id}`;
		if (siteCache.has(k)) return siteCache.get(k);
		const raw = (kind === 'npc' ? data.npcs : data.objects)[String(id)];
		let out = null;
		if (raw) {
			const all = [];
			for (const [map, sp] of Object.entries(raw.spawns || {})) {
				if (!allowedMap(map) || !sp || !Array.isArray(sp.pts)) continue;
				// Every spawn: data build keeps at most 24 a map in `pts`, spread far
				// apart (data/spawns.js), and the rest in `more`. Camps and their
				// supply need them all: 24 spread points made one-spawn camps of
				// 52 termite mounds.
				for (const p of Array.isArray(sp.more) ? sp.pts.concat(sp.more) : sp.pts) {
					if (!Array.isArray(p) || p.length < 2) continue;
					const w = toWorld(map, p[0], p[1], sp.f);
					all.push({ ...w, region: regionOf(w.c, Number(map)), map: Number(map), f: sp.f || null, edge: Math.min(p[0], 100 - p[0], p[1], 100 - p[1]) });
				}
			}
			if (all.length) {
				// A site whose spawns lie on more than one zone map belongs to
				// the members' best home map (dedupeMaps).
				const { pts: mapPts, better } = dedupeMaps(all, votes, innerMap);
				// QuestieDB's Forever spawns aren't deduplicated, and pfQuest's copies sit on top: one place, one spawn.
				const pts = [];
				for (const p of mapPts) if (!pts.some((u) => u.region === p.region && Math.hypot(u.wx - p.wx, u.wy - p.wy) <= SPAWN_DUP_R)) pts.push(p);
				const cl = cluster(pts, SITE_R).map((c) => {
					let home = pts[c.seed];
					for (const m of c.members) if (better(pts[m], home) > 0) home = pts[m];
					return { pt: entityPoint(kind, id, home.c, c.cx, c.cy, home.map), size: c.size, spacing: spacingOf(pts, c.members), map: home.map, f: home.f };
				});
				out = {
					kind, id: Number(id), raw, name: raw.name != null ? String(raw.name) : `${kind} ${id}`,
					friendly: kind === 'object' || friendly(raw.faction, faction),
					total: pts.length, sites: cl,
					// The deduped spawns themselves (camps link on them).
					spawns: pts.map((p) => ({ c: p.c, region: p.region, wx: p.wx, wy: p.wy, map: p.map })),
				};
			}
		}
		siteCache.set(k, out);
		return out;
	}
	// Map position (percent of the zone map) of a site, for exports.
	function posOf(site) {
		if (!site) return null;
		const [, , wx, wy, map] = points[site.pt];
		const b = frameOf(map, site.f);
		const r1 = (v) => Math.round(v * 10) / 10;
		if (!b) return { map, x: r1(-wy / 10), y: r1(-wx / 10) };
		return { map, x: r1(((wy - b.left) * 100) / (b.right - b.left)), y: r1(((wx - b.top) * 100) / (b.bottom - b.top)) };
	}

	// Site of an entity nearest an anchor point, preferring big sites:
	// score = size / (1 + distance / 400).
	function bestSite(ent, anchor) {
		let best = null;
		let bs = -Infinity;
		for (const s of ent.sites) {
			const d = anchor != null ? dist(s.pt, anchor) : 0;
			if (!Number.isFinite(d) && anchor != null) continue;
			const sc = Math.min(s.size, 12) / (1 + d / 400);
			if (sc > bs) {
				bs = sc;
				best = s;
			}
		}
		return best || ent.sites[0];
	}

	// ---- reference: taxi/transport/inns ----
	const travel = data.travel || { taxi: { nodes: [], legs: [] }, transports: [], inns: [] };
	const nodes = [];
	const nodeByTaxi = new Map();
	const fbit = FACTION_BIT[faction];
	const fpNpc = new Map(); // taxi node id -> its flight master's npc id, or null
	for (const n of travel.taxi.nodes || []) {
		if (!(n.faction & fbit)) continue;
		// The node's height: its flight master's (travel.json `npc`).
		const pt = n.npc ? entityPoint('npc', n.npc, n.c, n.wx, n.wy, n.map) : addPoint(n.c, n.wx, n.wy, n.map);
		nodeByTaxi.set(n.id, nodes.length);
		fpNpc.set(n.id, Number(n.npc) || null);
		nodes.push({ kind: 'fp', taxi: n.id, name: n.short || n.name, pt });
	}
	const taxi = [];
	for (const l of travel.taxi.legs || []) {
		const a = nodeByTaxi.get(l.from);
		const b = nodeByTaxi.get(l.to);
		if (a != null && b != null) taxi.push([a, b, l.cost]);
	}
	// A transport or portal end's height: its board point's own if it has one, else the end's.
	const endZ = (end) => {
		const z = end.board && Number.isFinite(end.board.z) ? end.board.z : end.z;
		return Number.isFinite(z) ? z : null;
	};
	const rides = [];
	for (const t of travel.transports || []) {
		if (!(t.faction & fbit)) continue;
		// The dock: the deck where a ship lying off its pier is boarded (travel build's `board`), else the stop;
		// its height is the deck's, else the stop's (the floor the router walks to).
		const da = t.a.board || t.a;
		const db = t.b.board || t.b;
		const a = nodes.length;
		nodes.push({ kind: 'dock', name: `${t.a.name} (${t.kind})`, pt: addPoint(t.a.c, da.wx, da.wy, t.a.map, endZ(t.a)) });
		const b = nodes.length;
		nodes.push({ kind: 'dock', name: `${t.b.name} (${t.kind})`, pt: addPoint(t.b.c, db.wx, db.wy, t.b.map, endZ(t.b)) });
		rides.push([a, b, t.ab, t.waitA || 0, t.id]);
		rides.push([b, a, t.ba, t.waitB || 0, t.id]);
	}
	const transit = travel.transit || {};
	const transitServices = transit.services || {};
	// travel.json's lifts carry no zone map: the map most spawns around the shaft lie on.
	const liftMap = (s) => {
		if (s.map != null) return s.map;
		let best = null;
		let bn = 0;
		for (const [map, n] of votes({ region: regionOf(s.c, null), wx: s.wx, wy: s.wy })) if (n > bn) [best, bn] = [map, n];
		return best;
	};
	// Each end on its own floor. Spawns within LIFT_END_R of the shaft whose
	// recorded height is within LIFT_END_Z of an end's are that end's floor
	// (a spawn recorded on several maps counts for each).
	// - A city's lift (its travel area is a city map's: Thunder Bluff,
	//   Undercity): the city is the busier floor (the mesa top, the city
	//   below); the other end lands on the zone around the shaft, the map
	//   other than the city's most spawns around it vote for (Mulgore,
	//   Tirisfal). The floor spawns alone can't say so: the Ruins above the
	//   Undercity are recorded on the city's map.
	// - Any other lift: each end takes the map most particular to its floor
	//   (its share of the floor's spawns less its share of the other floor's:
	//   the Great Lift's top is the Barrens, its bottom Thousand Needles).
	// Without floor spawns an end keeps the shaft's vote.
	const LIFT_END_R = 150;
	const LIFT_END_Z = 25;
	const mapsOfSpawn = (kind, id, c, wx, wy) => {
		const raw = (kind === 'npc' ? data.npcs : data.objects)[String(id)];
		const maps = new Set();
		for (const [map, sp] of Object.entries((raw && raw.spawns) || {})) {
			if (!allowedMap(map) || !sp || !Array.isArray(sp.pts)) continue;
			for (const p of sp.pts) {
				if (!Array.isArray(p) || p.length < 2) continue;
				const w = toWorld(map, p[0], p[1], sp.f);
				if (w.c === c && Math.hypot(w.wx - wx, w.wy - wy) <= HEIGHT_YARDS) maps.add(Number(map));
			}
		}
		return maps;
	};
	// -> { n: floor spawns placed on some map, maps: Map(map -> spawns) }
	const liftFloor = (s, z) => {
		const out = { n: 0, maps: new Map() };
		if (!Number.isFinite(z)) return out;
		for (const kind of ['npc', 'object']) {
			for (const [id, list] of Object.entries(spawnz[kind] || {})) {
				for (const r of list) {
					if (r[0] !== s.c || !Number.isFinite(r[3]) || Math.abs(r[3] - z) > LIFT_END_Z || Math.hypot(r[1] - s.wx, r[2] - s.wy) > LIFT_END_R) continue;
					const maps = mapsOfSpawn(kind, id, r[0], r[1], r[2]);
					if (!maps.size) continue;
					out.n++;
					for (const m of maps) out.maps.set(m, (out.maps.get(m) || 0) + 1);
				}
			}
		}
		return out;
	};
	const cityMapOfArea = new Map();
	for (const z of Object.values(zones)) if (z && z.areaId != null && allowedMap(z.id)) cityMapOfArea.set(Number(z.areaId), Number(z.id));
	// -> [bottomMap, topMap]
	const liftEndMaps = (s, shared) => {
		if (s.map != null) return [s.map, s.map];
		const floors = [liftFloor(s, s.bottom), liftFloor(s, s.top)];
		const city = cityMapOfArea.get(Number(s.area));
		if (city != null && floors[0].n + floors[1].n > 0) {
			let outer = null;
			let on = 0;
			for (const [map, n] of votes({ region: regionOf(s.c, null), wx: s.wx, wy: s.wy })) if (map !== city && n > on) [outer, on] = [map, n];
			if (outer == null) outer = city;
			return floors[0].n >= floors[1].n ? [city, outer] : [outer, city];
		}
		return floors.map((here, i) => {
			const other = floors[1 - i];
			let best = shared;
			let bs = -Infinity;
			for (const [map, n] of here.maps) {
				const score = n / here.n - (other.n ? (other.maps.get(map) || 0) / other.n : 0);
				if (score > bs) [best, bs] = [map, score];
			}
			return best;
		});
	};
	for (const [id, s] of Object.entries(transitServices)) {
		if (s.kind !== 'lift') continue;
		if (s.faction != null && !(s.faction & fbit)) continue;
		const [bottomMap, topMap] = liftEndMaps(s, liftMap(s));
		const cityFloor = CITY_LIFT_FLOOR[id];
		if (cityFloor) {
			const city = cityMapOfArea.get(Number(s.area));
			const got = bottomMap === city && topMap !== city ? 'bottom' : topMap === city && bottomMap !== city ? 'top' : null;
			if (got !== cityFloor) warnings.push(`lift ${id}: the city (map ${city}) should be its ${cityFloor} end; got bottom ${bottomMap}, top ${topMap}`);
		}
		const a = nodes.length;
		nodes.push({ kind: 'lift', name: `${id} (bottom)`, pt: addPoint(s.c, s.wx, s.wy, bottomMap, s.bottom) });
		const b = nodes.length;
		nodes.push({ kind: 'lift', name: `${id} (top)`, pt: addPoint(s.c, s.wx, s.wy, topMap, s.top) });
		rides.push([a, b, s.ride.a, s.wait.a || 0, id]);
		rides.push([b, a, s.ride.b, s.wait.b || 0, id]);
	}
	// The tram is in `transports` (its stops); its boarding and leaving time is in transit.
	for (const r of rides) {
		const svc = transitServices[r[4]];
		if (svc && svc.kind === 'tram') r[2] += (svc.pre || 0) + (svc.post || 0);
	}
	// A portal is this faction's when both ends lie within PORTAL_NEAR of one
	// of its flight nodes or inns (Rut'theran and Darnassus are not the Horde's).
	const PORTAL_NEAR = 1500;
	const innOk = (inn) => {
		const npc = data.npcs[String(inn.npc)];
		return !(npc && !friendly(npc.faction, faction));
	};
	const anchorsOfFaction = [
		...nodes.filter((n) => n.kind === 'fp').map((n) => ({ region: points[n.pt][1], wx: points[n.pt][2], wy: points[n.pt][3] })),
		...(travel.inns || []).filter(innOk).map((inn) => ({ region: regionOf(inn.c, Number(inn.map)), wx: inn.wx, wy: inn.wy })),
	];
	const ownEnd = (e) => {
		const region = regionOf(e.c, Number(e.map));
		return anchorsOfFaction.some((x) => x.region === region && Math.hypot(x.wx - e.wx, x.wy - e.wy) <= PORTAL_NEAR);
	};
	for (const p of transit.portals || []) {
		if (p.faction != null && !(p.faction & fbit)) continue;
		if (!ownEnd(p.a) || !ownEnd(p.b)) continue;
		const a = nodes.length;
		nodes.push({ kind: 'portal', name: p.id, pt: addPoint(p.a.c, p.a.wx, p.a.wy, p.a.map, endZ(p.a)) });
		const b = nodes.length;
		nodes.push({ kind: 'portal', name: `${p.id} (arrival)`, pt: addPoint(p.b.c, p.b.wx, p.b.wy, p.b.map, endZ(p.b)) });
		rides.push([a, b, p.seconds || 5, 0, p.id]);
	}
	for (const x of SKYBORNE_EXITS[faction]) {
		const wa = toWorld(x.a.map, x.a.x, x.a.y, x.a.f);
		const a = nodes.length;
		nodes.push({ kind: 'dock', name: x.name, pt: addPoint(wa.c, wa.wx, wa.wy, x.a.map) });
		const b = nodes.length;
		nodes.push({ kind: 'dock', name: `${x.name} (arrival)`, pt: addPoint(x.b.c, x.b.wx, x.b.wy, x.b.map) });
		rides.push([a, b, x.ab, x.wait, x.name]);
	}
	const inns = [];
	for (const inn of travel.inns || []) {
		if (!innOk(inn)) continue;
		inns.push({ name: inn.location, pt: inn.npc ? entityPoint('npc', inn.npc, inn.c, inn.wx, inn.wy, inn.map) : addPoint(inn.c, inn.wx, inn.wy, inn.map) });
	}

	// ---- quests ----
	const excluded = [];
	// Camps (camps.js): every kill and item objective's sources, clustered.
	const camps = [];
	// Group work (Fitz 2026-10-20; #638's rule): a camp with an elite source
	// (rank 1-3) is `elite`; v2's camp.js prices it for a party.
	const eliteNpc = (id) => ELITE_RANKS.has((data.npcs[String(id)] || {}).rank);
	const addCamp = (camp) => {
		const elite = camp.sources.some((s) => s.kind === 'npc' && eliteNpc(s.id));
		camps.push({ id: camps.length, ...camp, ...(elite ? { elite: true } : {}) });
		return camps.length - 1;
	};
	// Gameobject facts (CMaNGOS classic-db, cmangos.js loadObjectFacts): type, respawn, loot.
	const objFacts = data.objectFacts || {};
	const respawnOf = (kind, id) => {
		if (kind === 'object') {
			const f = objFacts[String(id)];
			if (f && USED_OBJECT_TYPES.has(f.type)) return USED_OBJECT_RESPAWN;
			return f && f.respawn > 0 ? f.respawn : OBJECT_RESPAWN_EST;
		}
		const list = (spawnz[kind] || {})[String(id)] || [];
		const r = list.map((s) => s[4]).filter((x) => Number.isFinite(x)).sort((a, b) => a - b);
		return r.length ? r[Math.floor(r.length / 2)] : null;
	};
	// An object's chance for item `item` (% of a loot × the loot's mean count):
	// a used object gives it every time; else CMaNGOS's loot row (|chance| ×
	// mean of min and max count) when it has one; else the recorded `chance`,
	// a quest item's OBJECT_QUEST_DROP without one.
	const objectChance = (id, item, chance) => {
		const f = objFacts[String(id)];
		if (f && USED_OBJECT_TYPES.has(f.type)) return 100;
		const l = f && f.loot ? f.loot[String(item.id)] : null;
		if (l && l[0] !== 0) return (Math.abs(l[0]) * (l[1] + l[2])) / 2;
		return chance == null && item.questItem ? OBJECT_QUEST_DROP : chance;
	};
	const levelOfEnt = (kind, id) => (kind === 'npc' && data.npcs[String(id)] ? npcLevel(data.npcs[String(id)], null) : null);
	const spawnsOf = (kind, id) => {
		const e = sites(kind, id);
		return e ? e.spawns : [];
	};
	const pointAt = (kind, id, s) => entityPoint(kind, id, s.c, s.wx, s.wy, s.map);
	const solidSource = (kind, id) => {
		if (kind !== 'npc') return true;
		const n = data.npcs[String(id)];
		// No faction is a monster (friendly() says true for "any faction" givers).
		return !!n && !ELITE_RANKS.has(n.rank) && n.rank !== 4 && !(n.faction && friendly(n.faction, faction));
	};
	// A camp is its geometry and source set: objectives with the same sources share camps.
	const campCache = new Map();
	// Items some quest gives as a reward or a choice (R9b: such an item has a source).
	const rewardItems = new Set();
	for (const r of Object.values(data.quests)) {
		const rw = r && r.web;
		if (!rw) continue;
		for (const [it] of [...(rw.items || []), ...(rw.choices || [])]) rewardItems.add(Number(it));
	}
	const campsFor = (sources) => {
		// Sources without open-world spawns add nothing to the geometry.
		const placed = sources.filter((s) => spawnsOf(s.kind, s.id).length);
		const key = placed.map((s) => `${s.kind}:${s.id}`).sort().join(',');
		if (!campCache.has(key)) campCache.set(key, buildCamps({ sources: placed, spawnsOf, levelOf: levelOfEnt, respawnOf, addCamp, pointAt }));
		return campCache.get(key);
	};
	const chancesOf = (sources) => Object.fromEntries(sources.map((s) => [`${s.kind}:${s.id}`, s.chance]));
	const quests = [];
	const byId = new Map();
	const timedIds = new Set(); // escorts and defend events: the XP tier
	// Solo filter (tools/lib/sim/solo.js): categories, overrides, instance areas.
	const solo = SOLO.compileOverrides(opts.overrides || SOLO.OVERRIDES);
	const questAreas = (data.questAreas && data.questAreas.areas) || {};
	const dungeonQuestIds = new Set();
	for (const d of (data.dungeons && data.dungeons.dungeons) || []) for (const dq of d.quests || []) if (!dq.hidden) dungeonQuestIds.add(Number(dq.id));
	const soloOut = new Map(); // quest id -> category
	const soloCounts = Object.fromEntries(SOLO.CATEGORIES.map((c) => [c, 0]));
	let repeatNoXp = 0;
	const ids = Object.keys(data.quests).map(Number).filter(Number.isFinite).sort((a, b) => a - b);
	// A timed event run at once, besides escorts (isEscort, dsl/escort.js):
	// a defend event, "Defend Shakes O'Breen" (667), "Help Perith Stormhoof
	// escape Palemane Rock" (98430).
	const DEFEND_RE = /\bprotect\b|\bdefend\b|\bkeep .* safe|\bguide .* safely|\blead .* to safety|\bescape\b/i;
	// R9b: an item the guides name the NPC who hands it over in gossip
	// (rules.json `handover`, which getWorld passes as opts.rules; none by
	// default): quest -> objective -> rule. A rule for a quest the data doesn't
	// hold is for other data (a synthetic test set; sim-rules checks the
	// shipped rules' ids against data/forever); any other rule that is
	// malformed, names an id the data doesn't know, misses its quest's item
	// objective or names an NPC with no open-world spawn is an error.
	const handRules = (opts.rules || []).filter((r) => r && r.kind === 'handover' && data.quests[String(r.quest)]);
	{
		const ids = (o) => new Set(Object.keys(o || {}).map(Number));
		const known = { quests: ids(data.quests), npcs: ids(data.npcs), items: ids(data.items) };
		const fail = (r, message) => {
			throw new Error(`handover rule ${r.id}: ${message} (source ${JSON.stringify(r.source || null)})`);
		};
		const checked = RULES.checkRules(handRules, { quests: [] }, known);
		if (checked.errors.length) {
			const [e] = checked.errors;
			fail({ id: e.id, source: e.source }, e.message.replace(`${e.id}: `, ''));
		}
		for (const r of handRules) {
			const o = ((data.quests[String(r.quest)] || {}).objectives || [])[r.objective];
			if (!o || o.type !== 'item' || Number(o.id) !== Number(r.item)) fail(r, `quest ${r.quest} has no item objective ${r.objective} for item ${r.item}`);
			const spawns = (data.npcs[String(r.npc)] || {}).spawns || {};
			if (!Object.entries(spawns).some(([map, sp]) => allowedMap(map) && sp && Array.isArray(sp.pts) && sp.pts.some((p) => Array.isArray(p) && p.length >= 2))) fail(r, `npc ${r.npc} has no open-world spawn`);
		}
	}
	const handovers = RULES.rulesFor(handRules).byQuest;
	const handoverOf = (qid, oi) => (handovers.get(qid) || []).find((r) => Number(r.objective) === oi) || null;
	const UNUSED_RE = /\b(UNUSED|NYI|TEST|DEPRECATED)\b|^\[|<.*>|\(123\)/i;

	for (const id of ids) {
		const raw = data.quests[String(id)];
		if (!raw) continue;
		const races = Number(raw.races) || 0;
		if (races && !maskForFaction(races, faction)) {
			excluded.push({ id, title: raw.title, reason: 'other faction', code: 'faction' });
			continue;
		}
		const ex = (reason, category, code) => {
			excluded.push(category ? { id, title: raw.title, reason, category, code } : { id, title: raw.title, reason, code });
			if (category) {
				soloOut.set(id, category);
				soloCounts[category]++;
			}
		};
		const title = raw.title != null ? String(raw.title) : `Quest ${id}`;
		if (UNUSED_RE.test(title)) {
			ex('unused/test quest', null, 'unused');
			continue;
		}
		if (raw.event) {
			ex('seasonal event', null, 'event');
			continue;
		}
		// Solo rules (unless allowed, which also keeps a profession quest the
		// guides make possible: Cooking rank 1 trained next to the giver).
		const strict = !solo.allow.has(id);
		const sortId = typeof raw.zone === 'number' && raw.zone < 0 ? -raw.zone : null;
		if (strict && (raw.skill || (sortId != null && PROFESSION_SORTS.has(sortId)))) {
			ex('profession', null, 'profession');
			continue;
		}
		const level = Number(raw.level) > 0 ? Number(raw.level) : Number(raw.minLevel) || 1;
		const minLevel = Number(raw.minLevel) > 0 ? Number(raw.minLevel) : Math.max(1, level - 5);
		if (minLevel >= 60) {
			ex('needs level 60 (mount swaps, endgame)', null, 'endgame');
			continue;
		}
		// Listed, reputation. An instance/PvP area or dungeons.json listing
		// (`inst`) only marks a candidate: Questie's area is the quest's story
		// zone, so it is a dungeon/raid/pvp quest only when its giver or ender
		// has no open-world site or an objective cannot be placed in the open
		// world (decided below, once they are located).
		let inst = null;
		if (strict) {
			const listed = solo.exclude.get(id);
			if (listed) {
				ex(`listed: ${listed.reason}`, listed.category, 'listed');
				continue;
			}
			inst = questAreas[raw.area] || (dungeonQuestIds.has(id) ? 'dungeon' : null);
			if (raw.reputation && Number(raw.reputation.value) > SOLO.FRIENDLY) {
				ex('needs reputation above Friendly', 'reputation', 'reputation');
				continue;
			}
		}
		const exInst = () => ex(`${inst} quest (instance area or dungeons.json)`, inst, 'dungeon');
		// Droppers a solo character farms: not elite, under quest level + 5
		// (the others are taken only when nothing else has the item).
		const soloDropper = (e) => !strict || !(ELITE_RANKS.has(e.raw.rank) || npcLevel(e.raw, 0) >= level + SOLO.HIGH_DROPPER);
		const start = raw.start || {};
		const end = raw.end || {};
		// Giver. One standing in several places (Minor Manifestation of
		// Earth: the Valley of Trials and Mulgore) is met at the site nearest
		// the quest's turn-in (1518 ends in the valley, 1521 in Mulgore).
		const endAnchor = () => {
			for (const kind of ['npc', 'object']) {
				for (const eid of end[kind] || []) {
					const e = sites(kind, eid);
					if (e && e.friendly) return bestSite(e, null).pt;
				}
			}
			return null;
		};
		let giver = null;
		let accept = null;
		let gName = null;
		let gPos = null;
		for (const kind of ['npc', 'object']) {
			for (const gid of start[kind] || []) {
				const e = sites(kind, gid);
				if (e && e.friendly) {
					const s = bestSite(e, e.sites.length > 1 ? endAnchor() : null);
					giver = s.pt;
					gName = e.name;
					gPos = posOf(s);
					break;
				}
			}
			if (giver != null) break;
		}
		let startHigh = null;
		let startElite = false;
		const startAt = (b) => {
			const s = bestSite(b.e, null);
			giver = s.pt;
			gName = `${b.item.name || 'item'} (drop: ${b.e.name})`;
			gPos = posOf(s);
			const n = 100 / Math.min(100, b.chance);
			accept = { pt: s.pt, work: b.kind === 'npc' ? [['kill', npcLevel(b.e.raw, level), n, ELITE_RANKS.has(b.e.raw.rank) ? 1 : 0, s.spacing, b.e.id]] : [['use', n]] };
		};
		if (giver == null) {
			// Quest-starting item: expected kills of its best (solo) dropper;
			// startHigh the best elite or 5+-levels-up one (taken below when none).
			// Without any recorded rate for the item, its droppers count at the
			// assumed rate (as for objective items).
			let best = null;
			for (const itemId of start.item || []) {
				const item = data.items[String(itemId)];
				if (!item || !item.drops) continue;
				const recorded = hasRecordedDrop(item);
				for (const kind of ['npc', 'object']) {
					for (const [eid, ch] of Object.entries(item.drops[kind] || {})) {
						const chance = ch == null ? (recorded ? 0 : unknownDrop(item)) : Number(ch) || 0;
						if (chance < MIN_START_DROP) continue;
						const e = sites(kind, eid);
						if (!e || (kind === 'npc' && e.friendly && e.raw.faction)) continue;
						const score = chance * Math.min(e.total, 20);
						if (kind === 'npc' && !soloDropper(e)) {
							if (!startHigh || score > startHigh.score) startHigh = { e, kind, chance, score, item };
							continue;
						}
						if (!best || score > best.score) best = { e, kind, chance, score, item };
					}
				}
			}
			if (best) startAt(best);
		}
		// A starting item handed over by another quest's turn-in (the data has
		// no quest rewards; solo overrides `startItemFrom`): the quest starts
		// at that quest's ender, once that quest is done (preAll, below).
		let startFrom = null;
		if (giver == null && solo.startItemFrom.has(id)) {
			const src = data.quests[String(solo.startItemFrom.get(id))];
			for (const kind of ['npc', 'object']) {
				for (const eid of ((src && src.end) || {})[kind] || []) {
					const e = sites(kind, eid);
					if (!e || !e.friendly) continue;
					const s = bestSite(e, null);
					giver = s.pt;
					gName = `${e.name} (turn in ${src.title} for the item)`;
					gPos = posOf(s);
					startFrom = src.id;
					break;
				}
				if (giver != null) break;
			}
		}
		// Only elites or mobs 5+ levels above drop the starting item: such a
		// dropper (group work when an elite, #638's rule).
		if (giver == null && startHigh) {
			startAt(startHigh);
			startElite = ELITE_RANKS.has(startHigh.e.raw.rank);
		}
		if (giver == null) {
			if (inst) exInst();
			else ex('no located quest giver', null, 'no-giver');
			continue;
		}
		// Ender.
		let ender = null;
		let eName = null;
		let ePos = null;
		for (const kind of ['npc', 'object']) {
			for (const eid of end[kind] || []) {
				const e = sites(kind, eid);
				if (e && e.friendly) {
					const s = bestSite(e, giver);
					ender = s.pt;
					eName = e.name;
					ePos = posOf(s);
					break;
				}
			}
			if (ender != null) break;
		}
		if (ender == null) {
			if (inst) exInst();
			else ex('no located turn-in', null, 'no-ender');
			continue;
		}
		// Every friendly giver and ender by entity ("npc:5489"), kept when there
		// is more than one: a guide that names one (`accept 8254 npc 11406`) is
		// scored there (sequence.js). The route search keeps giver and ender.
		const alts = (list, anchor) => {
			const out = {};
			let n = 0;
			for (const kind of ['npc', 'object']) {
				for (const eid of list[kind] || []) {
					const e = sites(kind, eid);
					if (!e || !e.friendly) continue;
					out[`${kind}:${eid}`] = bestSite(e, anchor(e)).pt;
					n++;
				}
			}
			return n > 1 ? out : null;
		};
		const gAlt = alts(start, (e) => (e.sites.length > 1 ? endAnchor() : null));
		const eAlt = alts(end, () => giver);
		// Objectives.
		const objs = Array.isArray(raw.objectives) ? raw.objectives : [];
		const located = [];
		let missing = null;
		let missingCat = null; // solo category of the exclusion, if any
		let missingCode = null;
		// Group work (#638's rule): an elite (rank 1-3) as a kill target, as the
		// dropper chosen for an item objective, or as the starting item's dropper.
		// A non-elite dropper 5+ levels above the quest is kept, not group work.
		let elite = startElite;
		const objCamps = [];
		// One entry per raw objective the quest keeps (`objs` on the record);
		// `task` is filled once the work is grouped into tasks.
		const objList = [];
		// dur: seconds an objective's item lasts in the bags (items.json duration,
		// the client's DurationInInventory), set only for a timed item.
		const durOf = (it) => {
			const d = it == null ? 0 : Number((data.items[String(it)] || {}).duration);
			return d > 0 ? d : 0;
		};
		const addObj = (oi, type, oid, count, item, questItem, camps, chances) => objList.push({
			oi, type, id: oid == null ? null : Number(oid), count: count == null ? 1 : Number(count),
			item: item == null ? null : Number(item), questItem: !!questItem, camps: camps || [], chances: chances || {}, task: null,
			...(durOf(item) ? { dur: durOf(item) } : {}),
		});
		// An objective with no open-world place: missing outside the open
		// world, or put at the giver for want of one (`inst` decides).
		let outside = false;
		// An escort (with the guides: isEscort and its corrections) is a timed
		// event; so is a defend event, which is no escort (667 Death From Below).
		const escort = isEscort(raw);
		const timedEvent = escort || (raw.escort !== false
			&& objs.some((o) => o && o.type === 'event' && DEFEND_RE.test([o.text, raw.objectiveText].filter(Boolean).join(' '))));
		// An escort without an event objective runs where it starts; a kill
		// credit on a friendly NPC is the escort's arrival (Tooga reaching
		// Torta, 1560), not a talk.
		const noEvent = escort && !objs.some((o) => o && o.type === 'event');
		const arrivals = [];
		const events = [];
		const eventOis = [];
		// Driving mechanics (data/forever/mechanics.json, the knowledge base): a target summoned by using an item at a
		// place (summon-by-item) is worked there, use then kill, not at a camp of its static spawn; an item made by
		// using an item at a place (use-item-at-place, `produces`) is one use there. Positions are in the live frame.
		const mq = data.mechanics && data.mechanics.quests ? data.mechanics.quests[String(id)] : null;
		const mechPlace = (p) => {
			const pos = p.place && Array.isArray(p.place.positions) ? p.place.positions.find((x) => allowedMap(x.map)) : null;
			if (!pos) return null;
			const w = toWorld(pos.map, pos.x, pos.y, 'l');
			return addPoint(w.c, w.wx, w.wy, pos.map);
		};
		const summoned = new Map(); // npc -> place point
		const madeAt = new Map(); // item -> place point
		for (const p of (mq && mq.params) || []) {
			if (!p.drives) continue;
			if (p.kind === 'summon-by-item' && p.npc != null) {
				const pt = mechPlace(p);
				if (pt != null) summoned.set(Number(p.npc), pt);
			} else if (p.kind === 'use-item-at-place' && p.produces != null) {
				const pt = mechPlace(p);
				if (pt != null) for (const it of [].concat(p.produces)) madeAt.set(Number(it), pt);
			}
		}
		const summonWork = (oi, npcId, count) => {
			const n = data.npcs[String(npcId)];
			const el = n && ELITE_RANKS.has(n.rank) ? 1 : 0;
			if (el) elite = true;
			const pt = summoned.get(npcId);
			located.push({ pt, work: ['use', 1], ois: [oi] });
			located.push({ pt, work: ['kill', n ? npcLevel(n, level) : level, count, el, 0, npcId], ois: [oi] });
		};
		for (const [oi, o] of objs.entries()) {
			if (!o) continue;
			const count = Number(o.count) > 0 ? Number(o.count) : 1;
			if (o.type === 'kill') {
				if (summoned.has(Number(o.id))) {
					summonWork(oi, Number(o.id), count);
					addObj(oi, 'kill', Number(o.id), count, null, false, [], {});
					continue;
				}
				const e = sites('npc', o.id);
				if (!e) {
					missing = `kill objective npc ${o.id} has no open-world spawns`;
					missingCode = 'unplaceable';
					outside = true;
					break;
				}
				const s = bestSite(e, giver);
				// Kill credit for a conversation with an NPC of the character's
				// faction (it cannot be attacked): one interaction, never elite.
				// The Threshwackonator (2078, AH elite, turns hostile) stays a fight.
				// A deed on an NPC of the character's own faction proper (DEED_RE:
				// healing Grunt Kor'ja, waking Lazy Peons) is one interaction per
				// credit. In a conversation quest the other faction's NPC is that
				// faction's counterpart (92640 lists Ayessa for the Horde, Elaadrin
				// for the Alliance): no work for this one.
				const nid = Number(o.id);
				const own = (list) => (list || []).map(Number).includes(nid);
				const talk = TALK_RE.test(String(raw.objectiveText || ''));
				const ownFaction = String(e.raw.faction).toUpperCase() === (faction === 'Alliance' ? 'A' : 'H');
				const deed = ownFaction && DEED_RE.test(String(raw.objectiveText || ''));
				if (noEvent && e.raw.faction && e.friendly) {
					arrivals.push(oi);
					addObj(oi, 'event', nid, 1, null, false, [], {});
					continue;
				}
				if (e.raw.faction && e.friendly && (own(start.npc) || own(end.npc) || talk || deed)) {
					located.push({ pt: s.pt, work: ['use', deed ? count : 1], ois: [oi] });
					addObj(oi, 'talk', nid, deed ? count : 1, null, false, [], {});
					continue;
				}
				if (e.raw.faction && !e.friendly && talk) continue;
				// An elite target is group work (Fitz 2026-10-20: elite quests are in,
				// grouping advised; v2 prices the party): its camps, marked elite.
				const el = ELITE_RANKS.has(e.raw.rank) ? 1 : 0;
				if (el) elite = true;
				located.push({ pt: s.pt, work: ['kill', npcLevel(e.raw, level), count, el, s.spacing, e.id], ois: [oi] });
				const src = [{ kind: 'npc', id: e.id, chance: 100 }];
				const killCamps = solidSource('npc', o.id) || el ? campsFor(src) : null;
				if (killCamps) objCamps.push([oi, killCamps, chancesOf(src)]);
				addObj(oi, 'kill', e.id, count, null, false, killCamps, chancesOf(src));
			} else if (o.type === 'object') {
				const e = sites('object', o.id);
				if (!e) {
					missing = `object objective ${o.id} has no open-world spawns`;
					missingCode = 'unplaceable';
					outside = true;
					break;
				}
				located.push({ pt: bestSite(e, giver).pt, work: ['use', count], ois: [oi] });
				addObj(oi, 'object', o.id, count, null, false, [], {});
			} else if (o.type === 'item') {
				const item = data.items[String(o.id)];
				// Handed over in gossip by an NPC the guides name: one talk there.
				const hand = handoverOf(id, oi);
				if (hand) {
					located.push({ pt: bestSite(sites('npc', hand.npc), giver).pt, work: ['use', 1], ois: [oi] });
					addObj(oi, 'talk', hand.npc, 1, o.id, !!(item && item.questItem), [], {});
					continue;
				}
				// Summoned dropper or made at a place (driving mechanics): point work there, no camps.
				const summoner = [...summoned.keys()].find((n) => item && item.drops && item.drops.npc && String(n) in item.drops.npc);
				if (summoner != null) {
					const ch = Number(item.drops.npc[String(summoner)]);
					summonWork(oi, summoner, ch >= 50 ? count : Math.ceil((count * 100) / (ch > 0 ? ch : unknownDrop(item))));
					addObj(oi, 'item', o.id, count, o.id, !!(item && item.questItem), [], {});
					continue;
				}
				if (madeAt.has(Number(o.id))) {
					located.push({ pt: madeAt.get(Number(o.id)), work: ['use', count], ois: [oi] });
					addObj(oi, 'item', o.id, count, o.id, !!(item && item.questItem), [], {});
					continue;
				}
				let itemCamps = [];
				let itemChances = {};
				let best = null;
				let anyDrop = false;
				let skippedRare = false;
				// The best high dropper (an elite or a mob 5+ levels above),
				// taken only when no solo source or vendor has the item; highSrc
				// its camps' sources.
				let highBest = null;
				const highSrc = [];
				if (item && item.drops) {
					// Camps: every hostile non-elite, non-rare dropper at >= 1% or
					// with no recorded rate, and every object, on the item's own scale.
					const sources = [];
					for (const kind of ['npc', 'object']) {
						for (const [eid, ch] of Object.entries(item.drops[kind] || {})) {
							let chance = ch == null ? null : Number(ch);
							if (kind === 'npc' && (!solidSource(kind, eid) || (chance != null && !(chance >= SOLO.MIN_DROP)))) continue;
							if (kind === 'object') chance = objectChance(eid, item, chance);
							sources.push({ kind, id: Number(eid), chance });
						}
					}
					if (sources.length) {
						const ids = campsFor(sources);
						if (ids.length) objCamps.push([oi, ids, chancesOf(sources)]);
						[itemCamps, itemChances] = [ids, chancesOf(sources)];
					}
					// A dropper without a recorded rate (null) is costed at
					// UNKNOWN_DROP % (quest items UNKNOWN_QUEST_DROP %) unless some
					// dropper with a recorded rate lives on the giver's landmass or
					// has no open-world site: next to recorded rates it is not
					// evidence of a better one (Kum'isha's sphere: 0.01% recorded
					// in the Blasted Lands, one dropper null; Sweet Amber's bars:
					// 75% from a dummy nowhere, chests null), but it is the only
					// source where every recorded dropper is on another landmass
					// (Galestrider on Zephras Isle, 92553).
					const recorded = hasRecordedDrop(item);
					const giverRegion = points[giver][1];
					let recordedNear = null; // computed on the first null-rate dropper
					const nearRecorded = () => ['npc', 'object'].some((k) => Object.entries(item.drops[k] || {}).some(([eid, c]) => {
						if (c == null || !(Number(c) > 0)) return false;
						const e = sites(k, eid);
						return !e || e.sites.some((s) => points[s.pt][1] === giverRegion);
					}));
					for (const kind of ['npc', 'object']) {
						for (const [eid, ch] of Object.entries(item.drops[kind] || {})) {
							if (ch == null && recorded) {
								if (recordedNear == null) recordedNear = nearRecorded();
								if (recordedNear) continue;
							}
							const chance = ch == null ? unknownDrop(item) : Math.min(100, Number(ch) || 0);
							if (chance <= 0) continue;
							anyDrop = true;
							const e = sites(kind, eid);
							if (!e) continue;
							// A friendly NPC "drops" what it hands over: one talk. A
							// friendly with a low "drop" chance (killed by the other
							// faction: Nethergarde Miners 0.01%) is no source for this
							// one, nor is a rare spawn (rank 4: Gluggle's 50% page from
							// 2 kills), nor any dropper below 1%.
							const friendlyNpc = kind === 'npc' && e.friendly && !!e.raw.faction;
							const handed = friendlyNpc && chance >= 50;
							if (strict && ((friendlyNpc && !handed) || (kind === 'npc' && e.raw.rank === 4) || chance < SOLO.MIN_DROP)) {
								skippedRare = true;
								continue;
							}
							if (!handed && kind === 'npc' && !soloDropper(e)) {
								highSrc.push({ kind: 'npc', id: Number(eid), chance: ch == null ? null : Number(ch) });
								const s = bestSite(e, giver);
								const d = dist(s.pt, giver);
								const cost = 100 / chance + (Number.isFinite(d) ? d / 300 : 1e6);
								if (!highBest || cost < highBest.cost) highBest = { e, chance, s, cost };
								continue;
							}
							const s = bestSite(e, giver);
							const d = dist(s.pt, giver);
							// Expected effort ~ actions per item, plus distance from the giver;
							// a source on another landmass only when there is none on the giver's.
							const cost = (handed ? 1 : 100 / chance) + (Number.isFinite(d) ? d / 300 : 1e6) + (kind === 'npc' && ELITE_RANKS.has(e.raw.rank) ? 4 : 0);
							if (!best || cost < best.cost) best = { e, kind: handed ? 'talk' : kind, chance, s, cost };
						}
					}
				}
				if (best) {
					const n = (count * 100) / best.chance;
					if (best.kind === 'talk') located.push({ pt: best.s.pt, work: ['use', 1], ois: [oi] });
					else if (best.kind === 'npc') {
						const el = ELITE_RANKS.has(best.e.raw.rank) ? 1 : 0;
						if (el) elite = true;
						located.push({ pt: best.s.pt, work: ['kill', npcLevel(best.e.raw, level), n, el, best.s.spacing, best.e.id], ois: [oi] });
					} else located.push({ pt: best.s.pt, work: ['use', n], ois: [oi] });
					addObj(oi, 'item', o.id, count, o.id, item.questItem, itemCamps, itemChances);
				} else {
					// The friendly vendor nearest the giver (same landmass first).
					let v = null;
					let vd = Infinity;
					for (const vid of (item && item.vendors) || []) {
						const e = sites('npc', vid);
						if (!e || !e.friendly) continue;
						const s = bestSite(e, giver);
						const d = dist(s.pt, giver);
						const dd = Number.isFinite(d) ? d : 1e9;
						if (!v || dd < vd) {
							v = s;
							vd = dd;
						}
					}
					if (v) {
						located.push({ pt: v.pt, work: ['buy'], ois: [oi] });
						addObj(oi, 'item', o.id, count, o.id, item && item.questItem, itemCamps, itemChances);
					} else if (highBest) {
						const n = (count * 100) / highBest.chance;
						const el = ELITE_RANKS.has(highBest.e.raw.rank) ? 1 : 0;
						if (el) elite = true;
						located.push({ pt: highBest.s.pt, work: ['kill', npcLevel(highBest.e.raw, level), n, el, highBest.s.spacing, highBest.e.id], ois: [oi] });
						const ids = campsFor(highSrc);
						if (ids.length) objCamps.push([oi, ids, chancesOf(highSrc)]);
						addObj(oi, 'item', o.id, count, o.id, item.questItem, ids, chancesOf(highSrc));
					} else if (skippedRare) {
						missing = `item objective ${o.id} drops below 1%`;
						missingCat = 'rareDrop';
						missingCode = 'rare-drop';
						break;
					} else if (!anyDrop) {
						// Made or handed over on the spot, or got elsewhere in ways the
						// world doesn't place: the quest's own hand-out (sourceItem,
						// requiredItems: a kit that makes the sample, 654), its starting
						// item, a turninAfter parent (338's chapters come from 339-342),
						// another quest's reward, or a container. An NPC the guides name
						// handing it over is a `handover` rule (above). Anything else is
						// a gap in the data (R9b).
						const handout = Number(raw.sourceItem) > 0 || (raw.requiredItems || []).length > 0
							|| (start.item || []).map(Number).includes(Number(o.id))
							|| solo.turninAfter.has(id) || rewardItems.has(Number(o.id))
							|| ((item && item.containers) || []).length > 0;
						if (!handout) {
							missing = `item objective ${o.id} has no source`;
							missingCode = 'unsourced-item';
							outside = true; // an instance quest's item may come from inside: dungeon, not a gap
							break;
						}
						located.push({ pt: giver, work: ['use', 1], ois: [oi] });
						addObj(oi, 'item', o.id, count, o.id, item && item.questItem, itemCamps, itemChances);
						outside = true;
					} else {
						missing = `item objective ${o.id} drops only outside the open world`;
						missingCode = 'outside';
						outside = true;
						break;
					}
				}
			} else if (o.type === 'event') {
				events.push(o);
				eventOis.push(oi);
			}
		}
		if (!missing && noEvent) {
			// One run where it starts: the arrival credits, or the quest itself
			// (no objectives: 96204 The Windshaper's Wrath).
			if (!objs.length) {
				arrivals.push(-1);
				addObj(-1, 'event', null, 1, null, false, [], {});
			}
			if (arrivals.length) located.push({ pt: giver, work: ['escort'], ois: arrivals });
		}
		if (!missing && events.length) {
			// Any one trigger completes an exploration; escorts run where they
			// start. An event counted in its text ("Free 6 Webbed Forsaken",
			// "Motivate 5 Deathguards"; the data has no count) is that many
			// interactions there.
			const placed = events.filter((o) => o.map != null && Number.isFinite(o.x) && Number.isFinite(o.y) && allowedMap(o.map));
			if (placed.length) {
				let best = null;
				for (const o of placed) {
					const w = toWorld(o.map, o.x, o.y, o.f);
					const pt = addPoint(w.c, w.wx, w.wy, o.map);
					const d = dist(pt, giver);
					if (!best || d < best.d) best = { pt, d, o };
				}
				const n = Number((String(best.o.text || '').match(/^\s*[A-Za-z']+\s+(\d+)\b/) || [])[1]);
				located.push({ pt: best.pt, work: timedEvent ? ['escort'] : n > 1 ? ['use', n] : ['visit'], ois: eventOis });
			} else if (timedEvent || events.every((o) => o.map == null)) {
				located.push({ pt: giver, work: ['escort'], ois: eventOis }); // runs where it starts
				outside = true;
			} else {
				missing = 'event objective outside the open world';
				missingCode = 'outside';
				outside = true;
			}
		}
		// Any one trigger completes an exploration: every event objective points at the one placed.
		if (!missing) for (const [k, o] of events.entries()) addObj(eventOis[k], 'event', o.id, o.count, null, false, [], {});
		if (inst && outside) {
			exInst();
			continue;
		}
		if (missing) {
			ex(missing, missingCat, missingCode);
			continue;
		}
		// Tasks: objectives grouped by site; each kept objective learns its task.
		const tasks = [];
		const taskOfOi = new Map();
		for (const l of located) {
			let ti = tasks.findIndex((x) => dist(x.pt, l.pt) <= SITE_R);
			if (ti < 0) {
				ti = tasks.length;
				tasks.push({ pt: l.pt, work: [] });
			}
			tasks[ti].work.push(l.work);
			for (const oi of l.ois) taskOfOi.set(oi, ti);
		}
		objList.sort((a, b) => a.oi - b.oi);
		for (const ob of objList) if (taskOfOi.has(ob.oi)) ob.task = taskOfOi.get(ob.oi);
		// What the quest asks: accepted from an item, a hand-over (no objectives) elsewhere or to the giver, or work.
		const kind = accept != null || startFrom != null ? 'startItem' : objList.length ? 'work' : ender !== giver ? 'delivery' : 'talk';
		const q = {
			id, title, level, minLevel,
			races: races || null,
			classes: Number(raw.classes) || null,
			pre: (Array.isArray(raw.pre) ? raw.pre : []).map(Number).filter(Number.isFinite),
			excl: (Array.isArray(raw.excl) ? raw.excl : []).map(Number).filter(Number.isFinite),
			next: Number(raw.next) || null,
			xp: typeof raw.xp === 'number' && raw.xp > 0 ? raw.xp : null,
			// Repeatables count once; without a recorded reward they give no XP
			// (the QuestXP tier estimate is for one-time quests).
			noXp: !!raw.repeatable && !(typeof raw.xp === 'number' && raw.xp > 0),
			giver, ender, accept, tasks,
			zone: P(giver).map,
			breadcrumb: !objs.length && !escort,
			kind,
			objs: objList,
			escort,
			elite,
			gName, eName, gPos, ePos,
		};
		if (gAlt) q.gAlt = gAlt;
		// The knowledge base's facts that change routing (data/forever/mechanics.json, `drives`): the quest's time
		// limit (TimeAllowed, seconds) and its driving mechanics (kinds, and the parameters with items, NPCs and
		// places). Tips (drives false) stay out of the world.
		if (Number(raw.limit) > 0) q.limit = Number(raw.limit);
		if (mq) {
			const kinds = (mq.kinds || []).filter((k) => k.drives).map((k) => k.kind);
			const params = (mq.params || []).filter((p) => p.drives).map(({ drives, ...p }) => p);
			if (kinds.length) q.mech = { kinds, ...(params.length ? { params } : {}) };
		}
		if (eAlt) q.eAlt = eAlt;
		if (startFrom != null) q.startFrom = startFrom;
		// The item the accept hands over vanishes this many seconds later (sourceItem's duration).
		if (durOf(raw.sourceItem)) q.sourceDur = durOf(raw.sourceItem);
		if (objCamps.length) q.objCamps = objCamps;
		if (raw.parent != null) q.inLog = Number(raw.parent);
		byId.set(id, q);
		if (timedEvent) timedIds.add(id);
		quests.push(q);
	}
	// Repeatables without a recorded reward give no XP (`noXp`): kept only
	// when another quest needs them (a prerequisite, or a child whose reward
	// a parent's turn-in needs: 349 for 348); the rest are excluded
	// ('repeatable': time, no XP).
	const needed = new Set();
	for (const r of Object.values(data.quests)) for (const k of ['pre', 'preAny', 'preAll']) for (const p of (r && Array.isArray(r[k]) ? r[k] : [])) needed.add(Number(p));
	for (const kids of solo.turninAfter.values()) for (const c of kids) needed.add(c);
	for (const src of solo.startItemFrom.values()) needed.add(src); // their turn-in hands over a starting item
	for (let i = quests.length - 1; i >= 0; i--) {
		const q = quests[i];
		if (!q.noXp) continue;
		if (needed.has(q.id) || solo.allow.has(q.id)) {
			repeatNoXp++;
			continue;
		}
		quests.splice(i, 1);
		byId.delete(q.id);
		excluded.push({ id: q.id, title: q.title, reason: 'repeatable without a recorded reward (no XP)', category: 'repeatable', code: 'repeatable' });
		soloOut.set(q.id, 'repeatable');
		soloCounts.repeatable++;
	}

	// ---- dungeons (data/forever/dungeons.json) ----
	// Quests whose objectives are inside a dungeon become dungeon quests: one
	// task at the entrance, done by running the dungeon. Quests already doable
	// in the open world stay as they are. Chain quests missing from the world
	// are added as talk-to quests at their recorded positions.
	const dungeons = [];
	const djPoint = (pos, fallback) => {
		if (!pos || pos.inDungeon || pos.map == null || !Number.isFinite(pos.x) || !Number.isFinite(pos.y) || !frameOf(pos.map, pos.f)) return fallback;
		const w = toWorld(pos.map, pos.x, pos.y, pos.f);
		return addPoint(w.c, w.wx, w.wy, pos.map);
	};
	const djFaction = (f) => f == null || f === faction;
	const djClasses = (list) => (Array.isArray(list) && list.length ? list.reduce((m, c) => m | ((CLASS_BY_FILE[String(c).toUpperCase()] || {}).bit || 0), 0) || null : null);
	for (const d of (data.dungeons && data.dungeons.dungeons) || []) {
		const ent = d.entrance;
		if (!ent || ent.map == null || !frameOf(ent.map, ent.f)) {
			warnings.push(`dungeon ${d.name}: entrance has no Era map frame`);
			continue;
		}
		const w = toWorld(ent.map, ent.x, ent.y, ent.f);
		const di = dungeons.length;
		const bossLevels = (d.bosses || []).map((b) => (typeof b.level === 'number' ? b.level : b.level && Number.isFinite(b.level.max) ? Math.round((b.level.min + b.level.max) / 2) : null)).filter((l) => l != null);
		const dg = { key: d.key, name: d.name, min: d.levels.min, max: d.levels.max, pt: addPoint(w.c, w.wx, w.wy, ent.map), zone: Number(ent.map), bosses: bossLevels, bossCount: (d.bosses || []).length, quests: [] };
		dungeons.push(dg);
		const addQuest = (dq, inside) => {
			if (byId.has(dq.id) || !djFaction(dq.faction)) return null;
			const raw = data.quests[String(dq.id)] || {};
			const level = Number(dq.level) || Number(raw.level) || dg.min;
			const giver = djPoint(dq.start, dg.pt);
			const ender = djPoint(dq.end, dg.pt);
			const djPos = (pos) => (pos && !pos.inDungeon && pos.map != null && Number.isFinite(pos.x) ? { map: Number(pos.map), x: pos.x, y: pos.y } : { ...posOf({ pt: dg.pt, f: ent.f }), inDungeon: true });
			const djName = (pos) => {
				if (!pos || pos.id == null) return pos && pos.inDungeon ? `inside ${d.name}` : null;
				const e = (pos.kind === 'object' ? data.objects : data.npcs)[String(pos.id)];
				return e && e.name != null ? String(e.name) : null;
			};
			const pre = (Array.isArray(dq.chain) && dq.chain.length ? [Number(dq.chain[dq.chain.length - 1])] : (raw.pre || []).map(Number)).filter(Number.isFinite);
			const q = {
				id: Number(dq.id), title: dq.title || raw.title || `Quest ${dq.id}`, level,
				minLevel: Number(dq.minLevel) || Number(raw.minLevel) || Math.max(1, level - 5),
				races: Number(raw.races) || null,
				classes: djClasses(dq.classes) || Number(raw.classes) || null,
				pre, excl: (raw.excl || []).map(Number), next: Number(raw.next) || null,
				xp: Number(dq.xp) > 0 ? Number(dq.xp) : typeof raw.xp === 'number' && raw.xp > 0 ? raw.xp : null,
				giver, ender, accept: null,
				tasks: inside ? [{ pt: dg.pt, work: [['dungeon', di]] }] : [],
				zone: P(giver).map, breadcrumb: !inside, escort: false, elite: inside, dungeon: inside ? di : undefined,
				// The work inside is the dungeon task: no open-world objectives.
				kind: inside ? 'work' : ender !== giver ? 'delivery' : 'talk', objs: [],
				gName: djName(dq.start), eName: djName(dq.end), gPos: djPos(dq.start), ePos: djPos(dq.end),
			};
			byId.set(q.id, q);
			quests.push(q);
			return q;
		};
		for (const dq of d.quests || []) {
			if (dq.hidden) continue;
			const q = addQuest(dq, true);
			if (q) dg.quests.push(q.id);
		}
		// Chain quests outside the dungeon come back only when the solo filter
		// did not exclude them (an elite chain step is not a free talk quest).
		for (const cq of Object.values(d.chainQuests || {})) {
			const inside = !!cq.dungeon && cq.dungeon === d.key;
			if (!inside && soloOut.has(Number(cq.id))) continue;
			addQuest(cq, inside);
		}
	}
	for (const dg of dungeons) dg.quests = dg.quests.concat(quests.filter((q) => q.dungeon === dungeons.indexOf(dg) && !dg.quests.includes(q.id)).map((q) => q.id));

	// Prerequisites. A quest with a quests.json record gets the canonical
	// blocking prerequisites the guide compiler and validator use
	// (tools/lib/data/prereqs.js: breadcrumbs, exclusive quests, the parent
	// and unstartable quests never block; preAll all-of, preAny/pre any-of).
	// A DungeonJournal-only quest keeps its journal chain. Last, `next` implies
	// the prerequisite of a quest with no prerequisite data at all (no
	// pre/preAny/preAll/breadcrumbs/breadcrumbFor): any-of over every quest
	// whose `next` it is (5093/5094/5095 -> 5096), never just one.
	const questOf = (id) => data.quests[String(id)] || null;
	const hasPreData = (raw) => !!raw && (['pre', 'preAny', 'preAll', 'breadcrumbs'].some((k) => Array.isArray(raw[k]) && raw[k].length) || Number(raw.breadcrumbFor) > 0);
	const preRules = { canonical: 0, journal: 0, next: 0 };
	for (const q of quests) {
		const raw = questOf(q.id);
		if (!raw) {
			q.preAll = [];
			if (q.pre.length) {
				q.preRule = 'journal';
				preRules.journal++;
			}
			continue;
		}
		const b = blockingPrereqs(raw, questOf);
		q.pre = b.any;
		q.preAll = q.startFrom != null ? [...new Set([...b.all, q.startFrom])] : b.all;
		if (hasPreData(raw)) {
			q.preRule = 'canonical';
			preRules.canonical++;
		}
	}
	const nextOf = new Map(); // target -> quests whose `next` it is
	for (const q of quests) {
		if (!q.next || !byId.has(q.next)) continue;
		if (!nextOf.has(q.next)) nextOf.set(q.next, []);
		nextOf.get(q.next).push(q.id);
	}
	for (const [t, src] of [...nextOf].sort((a, b) => a[0] - b[0])) {
		const f = byId.get(t);
		if (f.pre.length || f.preAll.length || hasPreData(questOf(t))) continue;
		f.pre = [...new Set(src)].sort((a, b) => a - b);
		f.preRule = 'next';
		preRules.next++;
	}
	// Child quests (Questie parentQuest): accepted while the parent is in the
	// log, not after it is turned in, so the parent is no prerequisite. The
	// parent's turn-in waits for the children listed in the solo overrides'
	// `turninAfter` (their rewards are its objective items: 348 <- 349,
	// 338 <- 339-342).
	let children = 0;
	for (const q of quests) {
		if (q.inLog == null) continue;
		if (!byId.has(q.inLog) && !excluded.some((e) => e.id === q.inLog && e.code !== 'faction')) {
			delete q.inLog; // other faction or race: no constraint
			continue;
		}
		q.pre = q.pre.filter((p) => p !== q.inLog);
		q.preAll = q.preAll.filter((p) => p !== q.inLog);
		children++;
	}
	for (const [parent, kids] of solo.turninAfter) {
		const q = byId.get(parent);
		if (q) q.after = kids.slice();
	}
	preRules.children = children;
	// Exclusive quests are one-way: quests.json `excl` merges pfQuest's
	// `close` (symmetric: both sides list each other) and Questie's
	// exclusiveTo (one-way: 526 lists 322 and 324, which do not list it). A
	// quest is unavailable while any quest of its own `excl` is in the log or
	// done; taking it closes nothing else (282 then 287 is fine).
	const followers = new Map();
	for (const q of quests) for (const p of q.pre) {
		if (!followers.has(p)) followers.set(p, []);
		followers.get(p).push(q.id);
	}
	for (const q of quests) {
		q.excl = [...new Set(q.excl.filter((e) => e !== q.id && byId.has(e)))].sort((a, b) => a - b);
		const chainEnd = q.pre.length > 0 && !(followers.get(q.id) || []).length;
		// Difficulty tier of the QuestXP table (used when no recorded XP).
		q.tier = q.breadcrumb ? 3 : timedIds.has(q.id) || q.elite ? 7 : chainEnd ? 6 : 5;
	}

	// ---- services (friendly trainers, repair, food, ammo, inns; flight from this faction's flight nodes) and class training ----
	const services = pickServices({ npcs: data.npcs, trainers: data.trainers, faction, sitesOf: sites, friendly });
	services.flight = nodes.filter((n) => n.kind === 'fp').map((n) => ({ pt: n.pt, npc: fpNpc.get(n.taxi) })).sort((a, b) => a.pt - b.pt);
	// Riding (training.json riding): each friendly riding trainer's site is a
	// riding stop for the races its gossip allows (races, the race mask, 0: no
	// race condition; compile.js keeps a race's own), with the
	// friendly mount vendor nearest it within RIDE_PAIR_YD and its mount
	// (vendors: npc -> [copper, item]) for an optional buy: the shipped mount
	// guides say learning gives a mount, the client's spell data shows none
	// (data/local/research/W1bInGameChecks.md).
	const rideDoc = data.training && data.training.riding;
	services.riding = [];
	let riding = null;
	if (rideDoc && (rideDoc.trainers || []).length) {
		const vendorSites = [];
		for (const [vid, v] of Object.entries(rideDoc.vendors || {})) {
			const n = data.npcs[vid];
			const e = n && friendly(n.faction, faction) ? sites('npc', vid) : null;
			if (e) for (const s of e.sites) vendorSites.push({ pt: s.pt, npc: Number(vid), copper: v[0], item: v[1] });
		}
		for (const { id: tid, races } of rideDoc.trainers) {
			const n = data.npcs[String(tid)];
			const e = n && friendly(n.faction, faction) ? sites('npc', tid) : null;
			if (!e) continue;
			for (const s of e.sites) {
				const a = P(s.pt);
				let best = null;
				let bd = RIDE_PAIR_YD;
				for (const v of vendorSites) {
					const b = P(v.pt);
					if (b.c !== a.c) continue;
					const d = Math.hypot(b.wx - a.wx, b.wy - a.wy);
					if (d <= bd) { bd = d; best = v; }
				}
				const stop = { pt: s.pt, npc: Number(tid), races: races || 0 };
				services.riding.push(best ? { ...stop, vendor: best.npc, vendorPt: best.pt, item: best.item, itemCopper: best.copper } : stop);
			}
		}
		services.riding.sort((x, y) => x.pt - y.pt);
		if (services.riding.length) riding = { level: rideDoc.level, cost: rideDoc.cost };
	}
	const serviceSet = serviceSetOf(services);
	const training = (data.training && data.training.classes) || {};
	// Keyed by the labels `starts` uses (races.json's Scourge is Undead).
	const classes = {};
	for (const [race, sides] of Object.entries(data.races || {})) if (sides[faction]) classes[RACE_BY_FILE[race] ? raceLabel(race) : race] = sides[faction].classes;

	// Prerequisites that are not quests of this world: other faction/race
	// (drop at run time) vs excluded for missing data (keep: unreachable).
	const excludedIds = new Set(excluded.filter((e) => e.code !== 'faction').map((e) => e.id));

	// ---- hubs ----
	const hubPts = [];
	for (const q of quests) {
		hubPts.push(q.giver);
		hubPts.push(q.ender);
	}
	const uniqHub = [...new Set(hubPts)].sort((a, b) => a - b);
	const hubCl = cluster(uniqHub.map((i) => ({ ...P(i) })), HUB_R);
	const hubs = [];
	const hubOfPoint = new Map();
	const trainerPts = [];
	for (const [tid, t] of Object.entries(data.trainers || {})) {
		const e = sites('npc', tid);
		if (!e || !e.friendly) continue;
		for (const s of e.sites) trainerPts.push({ pt: s.pt, classes: t.classes || [] });
	}
	for (const c of hubCl) {
		const seedPt = uniqHub[c.seed];
		const center = addPoint(P(seedPt).c, c.cx, c.cy, P(seedPt).map);
		let fp = -1;
		let fpd = NEAR_HUB;
		nodes.forEach((n, i) => {
			if (n.kind !== 'fp') return;
			const d = dist(n.pt, center);
			if (d <= fpd) {
				fpd = d;
				fp = i;
			}
		});
		let inn = -1;
		let innd = NEAR_HUB;
		inns.forEach((n, i) => {
			const d = dist(n.pt, center);
			if (d <= innd) {
				innd = d;
				inn = i;
			}
		});
		const trainers = [...new Set(trainerPts.filter((t) => dist(t.pt, center) <= NEAR_HUB).flatMap((t) => t.classes))].sort();
		const h = hubs.length;
		hubs.push({ pt: center, zone: P(center).map, size: c.size, fp, inn, trainers });
		for (const m of c.members) hubOfPoint.set(uniqHub[m], h);
	}

	// ---- packages ----
	// Band of a quest: by level, but a chain stays with its predecessor's band
	// while its level is within the band (plus 2 levels of slack).
	const bandOf = new Map();
	const sorted = quests.slice().sort((a, b) => a.level - b.level || a.id - b.id);
	const bandIdx = (lvl) => Math.floor((Math.max(1, lvl) - 1) / bandWidth);
	for (let pass = 0; pass < 3; pass++) {
		for (const q of sorted) {
			let b = bandIdx(q.level);
			for (const p of q.inLog != null ? q.pre.concat(q.inLog) : q.pre) {
				const pq = byId.get(p);
				if (!pq || pq.zone !== q.zone || !bandOf.has(p)) continue;
				const pb = bandOf.get(p);
				if (q.level <= (pb + 1) * bandWidth + 2 && pb < b) b = pb;
			}
			bandOf.set(q.id, b);
		}
	}
	// Steps by (zone of the step's point, band of its quest).
	const groups = new Map();
	const addStep = (q, kind, task, pt) => {
		const zone = P(pt).map;
		const k = `${zone}:${bandOf.get(q.id)}`;
		if (!groups.has(k)) groups.set(k, { zone, band: bandOf.get(q.id), steps: [] });
		groups.get(k).steps.push({ kind, q: q.id, task, pt, quest: q });
	};
	for (const q of quests) {
		if (q.dungeon !== undefined) continue; // in its dungeon's package
		addStep(q, 'accept', -1, q.accept ? q.accept.pt : q.giver);
		q.tasks.forEach((t, i) => addStep(q, 'task', i, t.pt));
		addStep(q, 'turnin', -1, q.ender);
	}
	const packages = [];
	const keys = [...groups.keys()].sort((a, b) => {
		const A = groups.get(a);
		const B = groups.get(b);
		return A.band - B.band || A.zone - B.zone;
	});
	for (const k of keys) {
		const g = groups.get(k);
		const order = planOrder(g.steps, { dist: (a, b) => dist(a, b) });
		// Split when more than maxOpen quests would be open at once.
		const chunks = [];
		let cur = [];
		let open = 0;
		for (const s of order) {
			if (s.kind === 'accept' && open >= maxOpen) {
				chunks.push(cur);
				cur = [];
				open = 0;
			}
			if (s.kind === 'accept') open++;
			else if (s.kind === 'turnin' && open > 0) open--;
			cur.push(s);
		}
		if (cur.length) chunks.push(cur);
		chunks.forEach((steps, ci) => {
			const qs = [...new Set(steps.map((s) => s.q))];
			const lv = qs.map((id) => byId.get(id).level);
			const lo = Math.min(...lv);
			const hi = Math.max(...lv);
			packages.push({
				key: `${zoneName(g.zone)} ${g.band * bandWidth + 1}-${(g.band + 1) * bandWidth}${chunks.length > 1 ? String.fromCharCode(97 + ci) : ''}`,
				zone: g.zone,
				zoneName: zoneName(g.zone),
				band: g.band,
				levels: [lo, hi],
				quests: qs,
				steps: steps.map((s) => [s.kind === 'accept' ? 0 : s.kind === 'task' ? 1 : 2, s.q, s.task, s.pt]),
			});
		});
	}
	// One package per dungeon: accept its quests (nearest first), run it at
	// the entrance (step kind 4, quest field = dungeon index), turn them in.
	dungeons.forEach((dg, di) => {
		const qs = dg.quests.map((id) => byId.get(id)).filter(Boolean);
		const near = (from, list, pick) => {
			const out = [];
			const left = list.slice();
			let cur = from;
			while (left.length) {
				let bi = 0;
				for (let i = 1; i < left.length; i++) if (dist(cur, pick(left[i])) < dist(cur, pick(left[bi]))) bi = i;
				const [x] = left.splice(bi, 1);
				out.push(x);
				cur = pick(x);
			}
			return out;
		};
		const accepts = near(dg.pt, qs, (q) => q.giver).reverse(); // end nearest the entrance
		const turnins = near(dg.pt, qs, (q) => q.ender);
		packages.push({
			key: `Dungeon: ${dg.name}`,
			zone: dg.zone,
			zoneName: zoneName(dg.zone),
			band: bandIdx(dg.min),
			levels: [dg.min, dg.max],
			dungeon: di,
			quests: qs.map((q) => q.id),
			steps: [...accepts.map((q) => [0, q.id, -1, q.giver]), [4, di, -1, dg.pt], ...turnins.map((q) => [2, q.id, -1, q.ender])],
		});
	});

	// ---- grinding sites: spacing of the densest hostile non-elite camps by mob level ----
	const spacing = [];
	for (const [id, raw] of Object.entries(data.npcs)) {
		if (!raw || raw.faction || ELITE_RANKS.has(raw.rank) || raw.rank === 4 || (raw.roles && raw.roles.length)) continue;
		const lvl = npcLevel(raw, 0);
		if (!(lvl >= 1 && lvl <= 63)) continue;
		let n = 0;
		for (const sp of Object.values(raw.spawns || {})) n += (sp.pts || []).length;
		if (n < 10) continue;
		const e = sites('npc', id);
		if (!e) continue;
		for (const s of e.sites) {
			if (s.size < 8 || s.spacing <= 0) continue;
			if (spacing[lvl] == null || s.spacing < spacing[lvl]) spacing[lvl] = Math.round(s.spacing * 10) / 10;
		}
	}
	for (let l = 1; l <= 63; l++) {
		if (spacing[l] == null) {
			// Nearest known level.
			let best = null;
			for (let d = 1; d < 63 && best == null; d++) best = spacing[l - d] != null ? spacing[l - d] : spacing[l + d] != null ? spacing[l + d] : null;
			spacing[l] = best != null ? best : 30;
		}
		spacing[l] = Math.max(12, spacing[l]);
	}
	spacing[0] = spacing[1];

	// ---- travel safety: zone levels and the zone of each 200-yard cell ----
	const zoneMin = {};
	for (const [id, z] of Object.entries(zoneLevels(data.npcs || {}, zones))) if (Number.isFinite(z.min)) zoneMin[id] = z.min;
	const cellCount = new Map(); // region -> Map(cell key -> Map(map -> spawns))
	for (const raw of Object.values(data.npcs || {})) {
		for (const [map, sp] of Object.entries((raw && raw.spawns) || {})) {
			if (!allowedMap(map) || !sp || !Array.isArray(sp.pts)) continue;
			for (const p of sp.pts) {
				if (!Array.isArray(p) || p.length < 2) continue;
				const w = toWorld(map, p[0], p[1], sp.f);
				const region = regionOf(w.c, Number(map));
				if (!cellCount.has(region)) cellCount.set(region, new Map());
				const cells = cellCount.get(region);
				const k = `${Math.floor(w.wx / DANGER_CELL)},${Math.floor(w.wy / DANGER_CELL)}`;
				if (!cells.has(k)) cells.set(k, new Map());
				const m = cells.get(k);
				m.set(Number(map), (m.get(Number(map)) || 0) + 1);
			}
		}
	}
	const danger = [];
	for (const region of [...cellCount.keys()].sort((a, b) => a - b)) {
		const cells = cellCount.get(region);
		let gx0 = Infinity;
		let gy0 = Infinity;
		let gx1 = -Infinity;
		let gy1 = -Infinity;
		for (const k of cells.keys()) {
			const [gx, gy] = k.split(',').map(Number);
			gx0 = Math.min(gx0, gx);
			gy0 = Math.min(gy0, gy);
			gx1 = Math.max(gx1, gx);
			gy1 = Math.max(gy1, gy);
		}
		const nx = gx1 - gx0 + 1;
		const ny = gy1 - gy0 + 1;
		const z = new Array(nx * ny).fill(0);
		for (const [k, m] of cells) {
			const [gx, gy] = k.split(',').map(Number);
			let best = 0;
			let bn = 0;
			for (const [map, n] of [...m].sort((a, b) => a[0] - b[0])) if (n > bn) {
				bn = n;
				best = map;
			}
			z[(gx - gx0) * ny + (gy - gy0)] = best;
		}
		// Gaps (no spawns): the zone of the nearest labelled cell, up to 3 cells away.
		let frontier = [];
		for (let i = 0; i < z.length; i++) if (z[i]) frontier.push(i);
		for (let ring = 0; ring < 3 && frontier.length; ring++) {
			const next = [];
			const add = new Map();
			for (const i of frontier) {
				const x = Math.floor(i / ny);
				const y = i % ny;
				for (const [dx, dy] of [[1, 0], [-1, 0], [0, 1], [0, -1]]) {
					const xx = x + dx;
					const yy = y + dy;
					if (xx < 0 || yy < 0 || xx >= nx || yy >= ny) continue;
					const j = xx * ny + yy;
					if (z[j] || add.has(j)) continue;
					add.set(j, z[i]);
				}
			}
			for (const [j, v] of [...add].sort((a, b) => a[0] - b[0])) {
				z[j] = v;
				next.push(j);
			}
			frontier = next;
		}
		danger.push({ region, gx0, gy0, nx, ny, cell: DANGER_CELL, z });
	}

	// ---- starts ----
	const starts = {};
	for (const [race, spec] of Object.entries(STARTS[faction])) {
		let qid;
		let zname;
		if (Array.isArray(spec)) [qid, zname] = spec;
		else {
			// The level-1 quest without prerequisites on the start maps that
			// the most quests follow from (ties: lowest id).
			zname = spec.zone;
			const maps = new Set(spec.maps);
			const follows = new Map();
			for (const q of quests) for (const p of q.pre.concat(q.preAll)) follows.set(p, (follows.get(p) || 0) + 1);
			const cand = quests.filter((q) => maps.has(P(q.giver).map) && !q.pre.length && !q.preAll.length && q.level <= 1 && (!q.races || hasBit(q.races, SKYBORNE_BIT[faction])));
			cand.sort((a, b) => (follows.get(b.id) || 0) - (follows.get(a.id) || 0) || a.id - b.id);
			qid = cand.length ? cand[0].id : null;
		}
		const q = byId.get(qid);
		if (!q) {
			warnings.push(`start quest ${qid} for ${race} not in the world`);
			continue;
		}
		starts[race] = { zone: zname, pt: q.giver, quest: qid };
	}
	for (const [race, s] of Object.entries(opts.extraStarts || {})) {
		const q = byId.get(s.quest);
		if (q) starts[race] = { zone: s.zone, pt: q.giver, quest: s.quest };
		else warnings.push(`start quest ${s.quest} for ${race} not in the world`);
	}

	for (const q of quests) {
		q.hubGiver = hubOfPoint.has(q.giver) ? hubOfPoint.get(q.giver) : -1;
		q.hubEnder = hubOfPoint.has(q.ender) ? hubOfPoint.get(q.ender) : -1;
	}
	const { areas, pointArea } = buildAreas({ points, nodes, inns, hubs, quests, camps, serviceSet });

	return {
		schema: 1,
		builderVersion: BUILDER_VERSION,
		faction,
		bandWidth,
		maxOpen,
		points,
		heights,
		nodes,
		taxi,
		rides,
		inns,
		hubs,
		quests,
		excluded,
		camps,
		services,
		serviceSet,
		areas,
		pointArea: Array.from(pointArea),
		training,
		trainingSpells: (data.training && data.training.spells) || null,
		riding,
		classes,
		excludedIds: [...excludedIds].sort((a, b) => a - b),
		solo: { counts: soloCounts, repeatNoXp, instanceAreas: data.questAreas ? data.questAreas.build : null, overrides: { exclude: solo.exclude.size, allow: solo.allow.size, turninAfter: solo.turninAfter.size } },
		packages,
		dungeons,
		grind: { spacing },
		zoneMin,
		danger,
		starts,
		zones: Object.fromEntries([...new Set(points.map((p) => p[4]))].sort((a, b) => a - b).map((m) => [m, zoneName(m)])),
		warnings,
		preRules,
	};
}

function worldFile(simDir, faction) {
	return path.join(simDir, `world-${String(faction).toLowerCase()}.json`);
}

// sourcesDir (data/sources): the cached Forever client tables give the
// solo filter its instance areas (tools/lib/sim/solo.js).
function loadSimData(dataDir, sourcesDir = null) {
	const data = loadData(dataDir);
	for (const f of ['travel', 'trainers', 'dungeons', 'training', 'races', 'mechanics']) {
		const file = path.join(dataDir, `${f}.json`);
		data[f] = fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null;
	}
	data.questAreas = sourcesDir ? SOLO.loadQuestAreas(sourcesDir) : null;
	const spawnzFile = path.join(dataDir, 'spawnz.json');
	if (fs.existsSync(spawnzFile)) data.spawnz = JSON.parse(fs.readFileSync(spawnzFile, 'utf8'));
	// Gameobject facts, extracted by sim's loadWorld (cmangos.js loadObjectFacts); none: estimates.
	data.objectFacts = sourcesDir ? readObjectFacts(sourcesDir) : null;
	return data;
}

// Cached world, rebuilt when an input changed (worldInputs: the data files it reads, by content,
// the walking grid, the rules' hand-overs, the client instance tables, the builder) or the band
// width or open cap differ. The world keeps its inputs' digests (`inputs`), so a rebuild names
// what changed.
// opts: { dataDir, sourcesDir, simDir, faction, rebuild, questXp, log, bandWidth, maxOpen }
// A world's key in the shared store (cas.js): its inputs' hash, the faction, band width, open cap
// and extra starts, and the world builder's code (another worktree's may differ).
let builderHash = null;
function worldKey(hash, opts) {
	if (!builderHash) {
		const { requireClosure, hashFiles } = require('../requires');
		builderHash = hashFiles(requireClosure([__filename]), path.join(__dirname, '..', '..', '..'));
	}
	return crypto.createHash('sha1').update([hash, opts.faction, opts.bandWidth || 5, opts.maxOpen || MAX_OPEN, JSON.stringify(opts.extraStarts || null), builderHash].join('|')).digest('hex');
}

function getWorld(opts) {
	const file = worldFile(opts.simDir, opts.faction);
	const inputs = worldInputs(opts.dataDir, opts.sourcesDir);
	const hash = inputsHash(inputs);
	const fits = (w) => w.dataHash === hash && w.bandWidth === (opts.bandWidth || 5) && w.maxOpen === (opts.maxOpen || MAX_OPEN);
	// The shared store (cas.js): a worktree's data/sim gets a world built anywhere on the same inputs.
	const cas = require('./cas');
	const key = cas.enabled(opts.simDir) ? worldKey(hash, opts) : null;
	let old = null;
	if (!opts.rebuild && fs.existsSync(file)) {
		old = readWorldFile(file);
		if (fits(old)) {
			if (key) cas.store('world', key, file);
			return old;
		}
	}
	if (!opts.rebuild && key && cas.fetch('world', key, file)) {
		const w = readWorldFile(file);
		if (fits(w)) {
			if (opts.log) opts.log(`world model for ${opts.faction} from the shared store (${cas.dir()})`);
			return w;
		}
	}
	if (opts.log) opts.log(`building world model for ${opts.faction}...${old ? ` (changed: ${changedInputs(old.inputs, inputs).join(', ') || 'band width or open cap'})` : ''}`);
	old = null;
	const data = opts.data || loadSimData(opts.dataDir, opts.sourcesDir);
	if (!data.questAreas && opts.log) opts.log('  warning: no cached Forever Map/AreaTable: the solo filter knows instances from dungeons.json only');
	const grid = require('./walks').openGrid();
	if (!grid && opts.log) opts.log('  warning: no walking grid (data/local/nav4): points without a spawn height have none');
	const floors = grid ? floorCache(opts.simDir) : null;
	const w = buildWorld(data, { faction: opts.faction, bandWidth: opts.bandWidth, maxOpen: opts.maxOpen, extraStarts: opts.extraStarts, rules: RULES.loadRules(), floor: grid ? gridFloor(grid, floors.map) : null });
	if (floors) floors.save();
	if (opts.log) opts.log(`  heights: ${Object.entries(w.heights).map(([k, n]) => `${k} ${n}`).join(', ')} (of ${w.points.length} points)`);
	w.dataHash = hash;
	w.inputs = inputs;
	w.questXp = opts.questXp;
	fs.mkdirSync(opts.simDir, { recursive: true });
	fs.writeFileSync(`${file}.tmp`, JSON.stringify(w));
	fs.renameSync(`${file}.tmp`, file);
	if (key) cas.store('world', key, file);
	return w;
}

// A world file, parsed; a long-running process (sim serve) keeps it by the file's content (memo.js).
function readWorldFile(file) {
	const { memo } = require('./memo');
	return memo(`world:${fs.realpathSync(file)}|${require('../requires').fileHash(file)}`, () => JSON.parse(fs.readFileSync(file, 'utf8')));
}

module.exports = { buildWorld, getWorld, worldKey, readWorldFile, worldFile, dataHash, worldInputs, changedInputs, gridFingerprint, gridFloor, floorCache, cluster, pointKey, ISLANDS, ISLE_MAPS, MAX_OPEN, BUILDER_VERSION };
