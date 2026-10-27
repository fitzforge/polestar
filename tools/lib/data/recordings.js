'use strict';
// Recorder overlay (data/recordings/*.json, schema in docs/ARCHITECTURE.md).
// Recordings are live Forever observations, so they win over Era data:
// - positions at quest accept/turn-in and at gossip/trainer/vendor/flight
//   master interactions become live-frame ("l") spawns that replace the Era
//   spawns of that npc/object on that map;
// - accept titles and quest levels correct the quest;
// - xp is the quest's full reward (see resolveXp): quest-log rewardXpBase
//   wins; otherwise the largest quest-log rewardXp or turn-in xpReward seen
//   by a character not out-levelling the quest (Classic reduces XP when the
//   player is more than 5 levels above it). xpSamples counts the
//   observations behind it and source gains "recorder:xp-<kind>";
// - recorded givers/enders are added to start/end when missing;
// - objective progress ("Kobold Vermin slain: 3/10") fills counts and the
//   client's objective order;
// - quests and npcs seen only in recordings are added (source ["recorder"]);
// - recorded maps missing from zones.json are added.
// - factions from the session's `factions` dump and `rep` events: live names
//   win, factions seen only in Forever are added, every one seen gets source
//   "recorder"; recorded parents/sides only fill gaps (resolveFactions).
// - quest rewards seen on the quest frames (items, choices, money) become
//   the quest's `rewards` (a turn-in wins over an accept);
// - finds (addon/Polestar_Recorder/Finds.lua), see applyFinds: rare
//   sightings and kills give npc rank, levels, the "rare" role, instances and
//   spawns; loot windows give drop chances (loots / kills) with their counts
//   (`seen`), objects opened give treasure roles and spawns; instance entries
//   and encounters fill `instances` (instances.json).

const fs = require('node:fs');
const path = require('node:path');
const { reduceSpawns, spawnRecord } = require('./spawns');
const { parseProgressText } = require('./objectives');

const INTERACTIONS = { gossip: null, trainer: 'trainer', vendor: 'vendor', fp: 'flightmaster' };
const OBJECTIVE_TYPES = { monster: 'kill', item: 'item', object: 'object' };

// UnitClassification -> npc rank as pfQuest stores it (normalize.js).
const RANKS = { normal: 0, trivial: 0, minus: 0, elite: 1, rareelite: 2, worldboss: 3, rare: 4 };
const RARE_CLASSES = new Set(['rare', 'rareelite']);
// A recorded drop chance from fewer kills (or opens) only fills a gap (no
// chance, or null: unknown); from
// this many it replaces the chance pfQuest or QuestieDB gives.
const MIN_KILLS = 10;
// Gathering loot of a game object: its role. Skinning loot is no npc drop.
const GATHER_ROLES = { herb: 'herb', mine: 'mine' };
// Entrance points closer than this (map percent) are one entrance.
const ENTRANCE_RADIUS = 1.5;

// data/recordings/*.json, schema 1 or 2 (config.json and dot files are not
// sessions). This JS overlay has none of the trust rules the Rust overlay
// applies (rust/crates/forge-data/src/recordings.rs, docs/RECORDING.md
// "Trust"), so it reads only the maintainer's own sessions: schema 1, and
// schema 2 whose contributor is `local`. Other players' recordings reach the
// data only through forge.
function readRecordings(dir) {
	if (!dir || !fs.existsSync(dir)) return [];
	const out = [];
	for (const file of fs.readdirSync(dir).filter((f) => f.endsWith('.json') && !f.startsWith('.') && f !== 'config.json').sort()) {
		const p = path.join(dir, file);
		let rec;
		try {
			rec = JSON.parse(fs.readFileSync(p, 'utf8'));
		} catch (err) {
			throw new Error(`recording ${file}: ${err.message}`);
		}
		if (!rec || (rec.schema !== 1 && rec.schema !== 2) || !Array.isArray(rec.events)) throw new Error(`recording ${file}: expected { schema: 1 or 2, events: [...] }`);
		if (rec.schema === 2 && rec.contributor !== 'local') continue;
		out.push({ file, rec });
	}
	return out;
}

function posInt(v) {
	const n = Number(v);
	return Number.isInteger(n) && n > 0 ? n : null;
}

function coord(ev) {
	const map = posInt(ev.map);
	const x = Number(ev.x);
	const y = Number(ev.y);
	if (!map || !Number.isFinite(x) || !Number.isFinite(y) || x < 0 || x > 100 || y < 0 || y > 100) return null;
	return { map, x, y };
}

function same(a, b) {
	return typeof a === 'string' && typeof b === 'string' && a.trim().toLowerCase() === b.trim().toLowerCase();
}

function newQuest(id) {
	return {
		id, title: null, level: null, minLevel: null, races: null, classes: null,
		start: { npc: [], object: [], item: [] }, end: { npc: [], object: [] },
		pre: [], excl: [], next: null, objectives: [], objectiveText: null, zone: null, xp: null,
		skill: null, event: null, source: ['recorder'],
	};
}

function front(list, id) {
	if (!list.includes(id)) list.unshift(id);
}

function ids(v) {
	return Array.isArray(v) ? [...new Set(v.map(posInt).filter(Boolean))] : [];
}

function bump(map, key, n = 1) {
	map.set(key, (map.get(key) || 0) + n);
}

function getOr(map, key, make) {
	if (!map.has(key)) map.set(key, make());
	return map.get(key);
}

function round2(v) {
	return Math.round(v * 100) / 100;
}

// Quest rewards from the quest frames (items, choices, rewardMoney; a
// turn-in's own money fills the money): { items, choices, money } of the
// best observation (turn-in 2 over accept 1, later over earlier).
function createRewards() {
	const seen = new Map();
	return {
		observe(qid, ev, weight) {
			const items = ids(ev.items);
			const choices = ids(ev.choices);
			const frameMoney = posInt(ev.rewardMoney);
			if (!items.length && !choices.length && !frameMoney) return;
			const money = frameMoney || (weight === 2 ? posInt(ev.money) : null);
			const cur = seen.get(qid);
			if (cur && cur.weight > weight) return;
			seen.set(qid, { weight, rewards: { items, choices, money } });
		},
		apply(q) {
			const r = seen.get(q.id);
			if (r) q.rewards = r.rewards;
		},
	};
}

// Greedy clusters of [x, y] points within `radius` -> [{ x, y, n }], the
// biggest first (then by x, y).
function clusters(points, radius) {
	const out = [];
	for (const [x, y] of points) {
		const c = out.find((k) => Math.hypot(k.sx / k.n - x, k.sy / k.n - y) <= radius);
		if (c) {
			c.sx += x;
			c.sy += y;
			c.n++;
		} else {
			out.push({ sx: x, sy: y, n: 1 });
		}
	}
	return out
		.map((c) => ({ x: round2(c.sx / c.n), y: round2(c.sy / c.n), n: c.n }))
		.sort((a, b) => b.n - a.n || a.x - b.x || a.y - b.y);
}

// Finds.lua events -> npc, object, item and instance facts. handle(ev) takes
// one event (true when it was a find); apply(stats) writes the facts once
// every session has been read, so counts merge across sessions:
// - rank from the latest classification seen (rare 4, rareelite 2, elite 1,
//   worldboss 3, normal 0); levels widen the npc's range to cover what was
//   seen; rare / rareelite (and any vignette rare) get the "rare" role;
// - drop chance = 100 * windows with the item / kills (2 decimals), kills
//   being `slain` events not `denied` (never fewer than the npc's loot
//   windows); objects: windows with the item / windows opened. A chance from
//   MIN_KILLS or more replaces the existing one, a smaller sample only fills
//   a missing or null one; `seen: { npc|object: { <id>: { n, of } } }` keeps the
//   counts. Skinning windows are left out;
// - an object whose window held a non-quest item, or seen behind a
//   vignette, is a "chest"; herb / mine gathering give those roles;
// - sightings and opened objects are spawn points: a map without spawns
//   gets them, live-frame spawns and Era spawns on unchanged frames take
//   them in; kill positions only fill a map without spawns;
// - `inst` adds the instance map id to the entity's `instances`; encounters
//   give their bosses `encounter` and fill instances.json with entrances.
function createFinds({ db, entity, itemEntry, spawnOptions, liveMaps }) {
	const { items, instances } = db;
	const kills = new Map(); // npc -> kills
	const windows = { npc: new Map(), object: new Map() }; // id -> loot windows
	const loots = { npc: new Map(), object: new Map() }; // id -> Map(item -> windows with it)
	const found = { npc: new Map(), object: new Map() }; // id -> Map(map -> [[x, y]]) joined into spawns
	const killed = new Map(); // npc -> Map(map -> [[x, y]]) filling empty maps only
	const rank = new Map();
	const levels = new Map(); // npc -> [min, max]
	const roles = { npc: new Map(), object: new Map() }; // id -> Set
	const inside = { npc: new Map(), object: new Map() }; // id -> Set(instance)
	const encounterOf = new Map(); // npc -> encounter id
	const entrances = new Map(); // instance -> Map(map -> [[x, y]])
	const inst = new Map(); // instance -> { name, type, encounters: Map(enc -> { name, npcs: Set, kills }) }
	const counts = { recordedKills: 0, recordedLoots: 0, recordedSightings: 0 };

	const point = (byId, id, ev) => {
		const c = coord(ev);
		if (c) getOr(getOr(byId, id, () => new Map()), c.map, () => []).push([c.x, c.y]);
	};
	const instance = (id, ev) => {
		const i = getOr(inst, id, () => ({ name: null, type: null, encounters: new Map() }));
		if (typeof ev.instName === 'string' && ev.instName !== '') i.name = ev.instName;
		if (ev.instType === 'party' || ev.instType === 'raid') i.type = ev.instType;
		return i;
	};
	const where = (kind, id, ev) => {
		const i = posInt(ev.inst);
		if (i) getOr(inside[kind], id, () => new Set()).add(i);
	};
	const unit = (id, ev) => {
		entity('npc', id, ev.npcName);
		if (ev.cls in RANKS) rank.set(id, RANKS[ev.cls]);
		if (RARE_CLASSES.has(ev.cls)) getOr(roles.npc, id, () => new Set()).add('rare');
		const lvl = posInt(ev.npcLvl);
		if (lvl) {
			const r = levels.get(id);
			levels.set(id, r ? [Math.min(r[0], lvl), Math.max(r[1], lvl)] : [lvl, lvl]);
		}
		where('npc', id, ev);
	};
	const lootList = (ev) => (Array.isArray(ev.items) ? ev.items : []).filter((i) => i && posInt(i.item));

	function handle(ev) {
		const npc = posInt(ev.npc);
		const obj = posInt(ev.object);
		switch (ev.e) {
			case 'rare':
				if (!npc) return true;
				unit(npc, ev);
				getOr(roles.npc, npc, () => new Set()).add('rare');
				point(found.npc, npc, ev);
				counts.recordedSightings++;
				return true;
			case 'treasure':
				if (!obj) return true;
				entity('object', obj, ev.objName);
				getOr(roles.object, obj, () => new Set()).add('chest');
				point(found.object, obj, ev);
				where('object', obj, ev);
				counts.recordedSightings++;
				return true;
			case 'slain':
				if (!npc) return true;
				unit(npc, ev);
				point(killed, npc, ev);
				if (!ev.denied) bump(kills, npc);
				counts.recordedKills++;
				return true;
			case 'drop': {
				const list = lootList(ev);
				const kind = npc ? 'npc' : obj ? 'object' : null;
				if (!kind || (kind === 'npc' && ev.gather)) {
					if (npc) unit(npc, ev);
					return true;
				}
				const id = npc || obj;
				if (kind === 'npc') unit(npc, ev);
				else {
					entity('object', obj, ev.objName);
					where('object', obj, ev);
					point(found.object, obj, ev);
					const role = GATHER_ROLES[ev.gather] || (!ev.gather && list.some((i) => !i.q) ? 'chest' : null);
					if (role) getOr(roles.object, obj, () => new Set()).add(role);
				}
				bump(windows[kind], id);
				const m = getOr(loots[kind], id, () => new Map());
				for (const item of new Set(list.map((i) => posInt(i.item)))) {
					bump(m, item);
					itemEntry(item);
				}
				counts.recordedLoots++;
				return true;
			}
			case 'enter': {
				const id = posInt(ev.inst);
				if (!id) return true;
				instance(id, ev);
				point(entrances, id, ev);
				return true;
			}
			case 'encounter': {
				const id = posInt(ev.inst);
				const enc = posInt(ev.enc);
				if (!enc) return true;
				const bosses = ids(ev.npcs);
				for (const b of bosses) {
					entity('npc', b, null);
					encounterOf.set(b, enc);
					if (id) getOr(inside.npc, b, () => new Set()).add(id);
				}
				if (!id) return true;
				const e = getOr(instance(id, ev).encounters, enc, () => ({ name: null, npcs: new Set(), kills: 0 }));
				if (typeof ev.encName === 'string' && ev.encName !== '') e.name = ev.encName;
				for (const b of bosses) e.npcs.add(b);
				if (ev.ok) e.kills++;
				return true;
			}
			default:
				return false;
		}
	}

	// Recorded points into e.spawns[map] (see createFinds).
	function join(e, byMap, fillOnly) {
		for (const [map, pts] of byMap) {
			const cur = e.spawns[map];
			if (cur && (fillOnly || (cur.f !== 'l' && (!liveMaps || liveMaps.has(map))))) continue;
			const all = cur ? [...cur.pts, ...(cur.more || []), ...pts] : pts;
			const reduced = reduceSpawns(all, spawnOptions);
			if (reduced.pts.length) e.spawns[map] = spawnRecord(cur ? cur.f : 'l', reduced);
		}
	}

	function apply(stats) {
		const tables = { npc: db.npcs, object: db.objects };
		let chances = 0;
		for (const kind of ['npc', 'object']) {
			for (const [id, m] of loots[kind]) {
				const of = kind === 'npc' ? Math.max(kills.get(id) || 0, windows.npc.get(id) || 0) : windows.object.get(id);
				for (const [item, n] of m) {
					const it = items && items[item];
					if (!it) continue;
					if (!it.drops) it.drops = { npc: {}, object: {} };
					if (!it.drops[kind]) it.drops[kind] = {};
					// null: a known dropper whose chance no source gives
					if (of >= MIN_KILLS || it.drops[kind][id] == null) {
						it.drops[kind][id] = round2((100 * n) / of);
						chances++;
					}
					if (!it.seen) it.seen = {};
					if (!it.seen[kind]) it.seen[kind] = {};
					it.seen[kind][id] = { n, of };
					if (Array.isArray(it.source) && !it.source.includes('recorder')) it.source.push('recorder');
					else if (!it.source) it.source = ['recorder'];
				}
			}
		}
		for (const [id, r] of rank) tables.npc[id].rank = r;
		for (const [id, [lo, hi]] of levels) {
			const e = tables.npc[id];
			const min = Number.isInteger(e.level) ? Math.min(e.level, lo) : lo;
			const max = Math.max(Number.isInteger(e.levelMax) ? e.levelMax : Number.isInteger(e.level) ? e.level : hi, hi);
			e.level = min;
			if (max > min) e.levelMax = max;
			else delete e.levelMax;
		}
		let treasures = 0;
		for (const kind of ['npc', 'object']) {
			for (const [id, set] of roles[kind]) {
				const e = tables[kind][id];
				e.roles = [...new Set([...(e.roles || []), ...set])].sort();
				if (kind === 'object' && set.has('chest')) treasures++;
			}
			for (const [id, set] of inside[kind]) {
				const e = tables[kind][id];
				e.instances = [...new Set([...(e.instances || []), ...set])].sort((a, b) => a - b);
			}
			for (const [id, byMap] of found[kind]) join(tables[kind][id], byMap, false);
		}
		for (const [id, byMap] of killed) join(tables.npc[id], byMap, true);
		for (const [id, enc] of encounterOf) tables.npc[id].encounter = enc;

		let encounters = 0;
		if (instances) {
			for (const [id, i] of [...inst].sort((a, b) => a[0] - b[0])) {
				const out = instances[id] || { id, name: null, type: null, entrances: [], encounters: {}, source: [] };
				if (i.name) out.name = i.name;
				if (i.type) out.type = i.type;
				const pts = entrances.get(id);
				if (pts) {
					out.entrances = [...pts]
						.sort((a, b) => a[0] - b[0])
						.flatMap(([map, list]) => clusters(list, ENTRANCE_RADIUS).map((c) => ({ map, ...c })))
						.sort((a, b) => b.n - a.n || a.map - b.map);
				}
				for (const [enc, e] of [...i.encounters].sort((a, b) => a[0] - b[0])) {
					out.encounters[enc] = { name: e.name, npcs: [...e.npcs].sort((a, b) => a - b), kills: e.kills };
					encounters++;
				}
				if (!out.source.includes('recorder')) out.source.push('recorder');
				instances[id] = out;
			}
		}
		Object.assign(stats, counts, {
			recordedDropChances: chances,
			recordedTreasures: treasures,
			recordedInstances: inst.size,
			recordedEncounters: encounters,
		});
	}

	return { handle, apply };
}

// db: { quests, npcs, objects, items, zones, factions, instances? } (mutated).
// liveMaps: { has(map) } maps whose Forever frame differs from the Era one
// (build.js liveMapsFrom); recorded points join Era spawns only elsewhere.
function applyRecordings(db, recordings, { spawnOptions, liveMaps } = {}) {
	const { quests, npcs, objects, items, zones, factions } = db;
	const stats = { recordings: recordings.length, events: 0, recorderOnlyQuests: 0, touchedQuests: 0, liveSpawnMaps: 0, recorderOnlyFactions: 0 };
	const live = { npc: new Map(), object: new Map() };
	const touched = new Set();
	const recordedObjectives = new Map(); // quest -> Map(oi -> { name, type, max, id })
	const touchedEntities = new Map(); // "kind:id" -> [kind, id]
	const xpSeen = new Map(); // quest -> [{ kind, xp, lvl }]
	function xpObservation(qid, kind, value, lvl) {
		const xp = posInt(value);
		if (!xp) return;
		if (!xpSeen.has(qid)) xpSeen.set(qid, []);
		xpSeen.get(qid).push({ kind, xp, lvl: posInt(lvl) });
	}
	function itemEntry(id, name) {
		if (!items) return;
		if (!items[id]) items[id] = { id, name: null, drops: { npc: {}, object: {} }, vendors: [] };
		if (typeof name === 'string' && name !== '') items[id].name = name;
	}

	function quest(id) {
		if (!quests[id]) {
			quests[id] = newQuest(id);
			stats.recorderOnlyQuests++;
		}
		touched.add(id);
		return quests[id];
	}
	function entity(kind, id, name) {
		const table = kind === 'npc' ? npcs : objects;
		if (!table[id]) {
			table[id] = kind === 'npc' ? { id, name: null, level: null, faction: null, spawns: {} } : { id, name: null, spawns: {} };
		}
		if (typeof name === 'string' && name !== '') table[id].name = name;
		touchedEntities.set(`${kind}:${id}`, [kind, id]);
		return table[id];
	}
	function livePoint(kind, id, name, ev) {
		const e = entity(kind, id, name);
		const c = coord(ev);
		if (!c) return e;
		const byMap = live[kind];
		if (!byMap.has(id)) byMap.set(id, new Map());
		const m = byMap.get(id);
		if (!m.has(c.map)) m.set(c.map, []);
		m.get(c.map).push([c.x, c.y]);
		return e;
	}
	function addRole(e, role) {
		if (!role) return;
		const roles = new Set(e.roles || []);
		roles.add(role);
		e.roles = [...roles].sort();
	}
	function objectiveSlot(q, oi) {
		if (!recordedObjectives.has(q)) recordedObjectives.set(q, new Map());
		const m = recordedObjectives.get(q);
		if (!m.has(oi)) m.set(oi, {});
		return m.get(oi);
	}
	// Factions as the live client reports them. Recorded names win; parent and
	// side are only filled where the Era table has nothing.
	const factionParent = new Map(); // id -> recorded parent id
	const factionSide = new Map(); // id -> recorded side
	function faction(id, name) {
		if (!factions) return null;
		if (!factions[id]) {
			factions[id] = { id, name: null, side: null, parent: null, source: [] };
			stats.recorderOnlyFactions++;
		}
		const f = factions[id];
		if (typeof name === 'string' && name.trim() !== '') f.name = name.trim();
		if (!f.source.includes('recorder')) f.source.push('recorder');
		return f;
	}
	function factionDump(dump) {
		const entries = Array.isArray(dump) ? dump.map((d) => [d && d.id, d]) : Object.entries(dump || {});
		for (const [key, d] of entries) {
			const id = posInt(key) || posInt(d && (d.id ?? d.factionID));
			if (!id || !d || typeof d !== 'object') continue;
			if (!faction(id, d.name)) return;
			const parent = posInt(d.parent ?? d.parentID ?? d.parentFactionID);
			if (parent && parent !== id) factionParent.set(id, parent);
			if (d.side === 'Alliance' || d.side === 'Horde') factionSide.set(id, d.side);
		}
	}

	const finds = createFinds({ db, entity, itemEntry, spawnOptions, liveMaps });
	const rewardsSeen = createRewards();

	for (const { rec } of recordings) {
		for (const [mapId, m] of Object.entries(rec.maps || {})) {
			const id = posInt(mapId);
			if (id && !zones[id] && m && typeof m.name === 'string') {
				zones[id] = { id, name: m.name, areaId: null, parent: posInt(m.parent), type: Number.isFinite(Number(m.type)) ? Number(m.type) : null };
			}
		}
		factionDump(rec.factions);
		for (const ev of rec.events) {
			if (!ev || typeof ev.e !== 'string') continue;
			stats.events++;
			const qid = posInt(ev.q);
			const npc = posInt(ev.npc);
			if (ev.e === 'accept' && qid) {
				const q = quest(qid);
				if (typeof ev.title === 'string' && ev.title !== '') q.title = ev.title;
				const qlvl = posInt(ev.qlvl);
				if (qlvl) q.level = qlvl;
				xpObservation(qid, 'base', ev.rewardXpBase, ev.lvl);
				xpObservation(qid, 'log', ev.rewardXp, ev.lvl);
				if (npc) {
					front(q.start.npc, npc);
					livePoint('npc', npc, ev.npcName, ev);
				}
				const obj = posInt(ev.object);
				if (obj) {
					front(q.start.object, obj);
					livePoint('object', obj, ev.objName, ev);
				}
				// Item-started quests: the position says nothing about the item.
				const item = posInt(ev.item);
				if (item) front(q.start.item, item);
				const c = coord(ev);
				if (!q.zone && c) q.zone = c.map;
				rewardsSeen.observe(qid, ev, 1);
			} else if (ev.e === 'turnin' && qid) {
				const q = quest(qid);
				xpObservation(qid, 'turnin', ev.xpReward, ev.lvl);
				if (npc) {
					front(q.end.npc, npc);
					livePoint('npc', npc, ev.npcName, ev);
				}
				const obj = posInt(ev.object);
				if (obj) {
					front(q.end.object, obj);
					livePoint('object', obj, ev.objName, ev);
				}
				rewardsSeen.observe(qid, ev, 2);
			} else if (ev.e === 'reward' && qid) {
				quest(qid);
				xpObservation(qid, 'base', ev.rewardXpBase, ev.lvl);
				xpObservation(qid, 'log', ev.rewardXp, ev.lvl);
			} else if (ev.e === 'progress' && qid) {
				quest(qid);
				const oi = posInt(ev.oi);
				const p = parseProgressText(ev.text);
				if (!oi || !p) continue;
				const slot = objectiveSlot(qid, oi);
				slot.name = p.name;
				slot.max = Math.max(slot.max || 0, p.max);
				slot.type = OBJECTIVE_TYPES[ev.type] || slot.type || (p.slain ? 'kill' : null);
			} else if (ev.e === 'kill' || ev.e === 'loot') {
				const id = ev.e === 'kill' ? npc : posInt(ev.item);
				if (!id) continue;
				if (ev.e === 'kill') entity('npc', id, ev.npcName);
				else itemEntry(id, ev.itemName);
				const oi = posInt(ev.oi);
				if (qid && oi) {
					const slot = objectiveSlot(qid, oi);
					slot.id = id;
					slot.type = slot.type || (ev.e === 'kill' ? 'kill' : 'item');
				}
			} else if (finds.handle(ev)) {
				// rare, treasure, slain, drop, enter, encounter
			} else if (ev.e in INTERACTIONS && npc) {
				addRole(livePoint('npc', npc, ev.npcName, ev), INTERACTIONS[ev.e]);
			} else if (ev.e === 'rep') {
				const id = posInt(ev.faction);
				if (id) faction(id, ev.factionName);
			}
		}
	}

	// Kill/loot events can link objectives of a quest that neither the data nor
	// any recorded accept/turnin/reward/progress knows (accepted in a lost
	// session); without a quest to attach them to they are dropped.
	for (const [qid, slots] of recordedObjectives) {
		if (quests[qid]) mergeObjectives(quests[qid], slots);
	}

	for (const kind of ['npc', 'object']) {
		const table = kind === 'npc' ? npcs : objects;
		for (const [id, byMap] of live[kind]) {
			const e = table[id];
			for (const [map, pts] of byMap) {
				const reduced = reduceSpawns(pts, spawnOptions);
				if (!reduced.pts.length) continue;
				e.spawns[map] = spawnRecord('l', reduced);
				stats.liveSpawnMaps++;
			}
		}
	}
	finds.apply(stats);
	for (const [kind, id] of touchedEntities.values()) {
		const table = kind === 'npc' ? npcs : objects;
		table[id] = canonical(table[id], kind === 'npc' ? NPC_KEYS : OBJECT_KEYS);
	}

	for (const id of [...touched].sort((a, b) => a - b)) {
		const q = quests[id];
		if (!q.source.includes('recorder')) q.source.push('recorder');
		if (xpSeen.has(id)) resolveXp(q, xpSeen.get(id));
		rewardsSeen.apply(q);
		quests[id] = canonical(q, QUEST_KEYS);
	}
	stats.touchedQuests = touched.size;
	if (factions) resolveFactions(factions, factionParent, factionSide);
	return stats;
}

// Same field order as normalize.js builds, whatever the overlay added.
const NPC_KEYS = ['id', 'name', 'level', 'levelMax', 'rank', 'faction', 'roles', 'spawns', 'instances', 'encounter'];
const OBJECT_KEYS = ['id', 'name', 'roles', 'faction', 'spawns', 'instances'];
const QUEST_KEYS = [
	'id', 'title', 'level', 'minLevel', 'races', 'classes', 'start', 'end', 'pre', 'excl', 'next',
	'objectives', 'objectiveText', 'zone', 'xp', 'xpSamples', 'rewards', 'skill', 'event', 'source',
];
const FACTION_KEYS = ['id', 'name', 'side', 'parent', 'source'];

// Recorded header links fill missing parents (only to factions in the file,
// never creating a cycle); then recorder-touched factions without a side take
// the recorded side or inherit their parent's.
function resolveFactions(factions, parents, sides) {
	const ancestorOf = (id, target) => {
		const seen = new Set();
		for (let cur = id; cur && !seen.has(cur); cur = factions[cur] ? factions[cur].parent : null) {
			if (cur === target) return true;
			seen.add(cur);
		}
		return false;
	};
	for (const id of [...parents.keys()].sort((a, b) => a - b)) {
		const f = factions[id];
		const p = parents.get(id);
		if (f.parent === null && factions[p] && !ancestorOf(p, id)) f.parent = p;
	}
	const sideOf = (id) => {
		const seen = new Set();
		for (let cur = id; cur && factions[cur] && !seen.has(cur); cur = factions[cur].parent) {
			seen.add(cur);
			if (factions[cur].side) return factions[cur].side;
			if (sides.has(cur)) return sides.get(cur);
		}
		return null;
	};
	for (const key of Object.keys(factions)) {
		const f = factions[key];
		if (!f.source.includes('recorder')) continue;
		if (!f.side) f.side = sideOf(f.id);
		factions[key] = canonical(f, FACTION_KEYS);
	}
}

// Classic gives full quest XP up to 5 levels above the quest, less beyond.
const FULL_XP_LEVELS = 5;

// rewardXpBase (the unreduced reward) wins outright. Otherwise rewardXp and
// turn-in xpReward count only when the character was provably not
// out-levelling the quest: player level known and <= quest level + 5 (any
// player level when the quest level is unknown). A reduced observation never
// replaces a full one; without a qualifying observation xp is left as is.
function resolveXp(q, list) {
	let pick = list.filter((o) => o.kind === 'base');
	if (!pick.length) {
		pick = list.filter((o) => o.kind !== 'base' && (q.level === null || (o.lvl !== null && o.lvl <= q.level + FULL_XP_LEVELS)));
	}
	if (!pick.length) return;
	let best = pick[0];
	for (const o of pick) if (o.xp > best.xp) best = o;
	q.xp = best.xp;
	q.xpSamples = pick.length;
	const tag = `recorder:xp-${best.kind}`;
	if (!q.source.includes(tag)) q.source.push(tag);
}

// Listed keys first in that order, any others after in their existing order.
function canonical(e, keys) {
	const out = {};
	for (const k of keys) if (k in e) out[k] = e[k];
	for (const k of Object.keys(e)) if (!(k in out)) out[k] = e[k];
	return out;
}

// Match recorded objectives (by name, else by id) to existing ones; recorded
// counts win and recorded indices reorder. Unmatched recorded objectives are
// appended (their type/id only when the recording proves it).
function mergeObjectives(q, slots) {
	const oiOf = new Map();
	for (const oi of [...slots.keys()].sort((a, b) => a - b)) {
		const s = slots.get(oi);
		let idx = q.objectives.findIndex((o, i) => !oiOf.has(i) && s.name && (same(o.text, s.name) || same(`${o.text}s`, s.name)));
		if (idx < 0 && s.id) idx = q.objectives.findIndex((o, i) => !oiOf.has(i) && o.id === s.id && (!s.type || o.type === s.type));
		if (idx < 0) {
			q.objectives.push({ type: s.type || 'event', id: s.id || null, count: s.max || null, text: s.name || null });
			idx = q.objectives.length - 1;
		} else if (s.max) {
			q.objectives[idx].count = s.max;
		}
		oiOf.set(idx, oi);
	}
	// Recorded objectives take slot oi - 1; the rest keep their order in the gaps.
	const result = new Array(q.objectives.length).fill(null);
	const rest = [];
	q.objectives.forEach((o, i) => {
		const oi = oiOf.get(i);
		if (oi !== undefined && oi - 1 < result.length && result[oi - 1] === null) result[oi - 1] = o;
		else rest.push(o);
	});
	for (let i = 0; i < result.length; i++) if (result[i] === null) result[i] = rest.shift();
	q.objectives = result;
}

module.exports = { readRecordings, applyRecordings };
