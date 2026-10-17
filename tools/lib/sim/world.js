'use strict';
// World model per faction (docs/SIMULATION.md §1), built once from
// data/forever and cached in data/sim/world-<faction>.json. The cache records
// a hash of data/forever/meta.json, travel.json, trainers.json and
// dungeons.json (and of this builder's version): when the reference data is
// rebuilt the world is rebuilt. Spawns flagged f "l" convert through the
// Forever (live) map frames. Race masks carry Forever's Skyborne bits (32
// Alliance, 33 Horde). Prerequisites: the canonical blocking prerequisites of
// tools/lib/data/prereqs.js (the guide compiler's), DungeonJournal-only quests
// keep their journal chain, and a quest without any prerequisite data gets
// the `next` implication (`preRules` counts each rule). Exclusive quests are
// one-way lists (`excl`: unavailable while one of them is in the log or done).
// Dungeons (dungeons.json) add one package per dungeon and the quests whose
// objectives are inside it. Solo filter (tools/lib/sim/solo.js): quests a
// levelling character cannot do alone (instance, PvP, elite targets or
// droppers, rare drops, reputation) are excluded with a category, counted in
// `solo`; the dungeon family gets dungeons.json's quests back as dungeon
// packages.
//
// Contents (all positions are indices into `points`):
//   points   [[c, region, wx, wy, map]]   world yards; region separates islands
//   nodes    transport nodes: flight masters usable by the faction and docks
//   taxi     [[a, b, seconds]] flights between nodes (both must be known)
//   rides    [[a, b, seconds, wait, id]] boats, zeppelins, trams (both ways);
//            the Zephras Isle exits one way only (isle -> mainland)
//   inns     [{ name, pt }]
//   hubs     quest givers/enders clustered at 150 yd, with fp/inn/trainers
//   quests   [{ id, title, level, minLevel, races, classes, pre, preAll, excl, ...,
//              giver, ender, accept: {pt, work}, tasks: [{pt, work}],
//              gName, eName (giver/ender names), gPos, ePos ({map, x, y} map percent) }]
//   packages [{ key, zone, zoneName, band, quests, steps: [[kind, quest, task, pt]] }]
//   grind    { spacing: [yards by mob level] }
//   starts   { Race: { zone, pt, quest } }
//   zoneMin  { map: level }  P10 of the zone's hostile normal-rank spawns (tools/lib/maps/zonelevels.js)
//   danger   [{ region, gx0, gy0, nx, ny, cell, z: [map per cell, 0 = unknown] }]
//            which zone each 200-yard cell belongs to (most NPC spawns, gaps
//            filled from neighbours up to 3 cells): the travel-safety check
//            samples walking legs on it (docs/SIMULATION.md §1)
// Work items: [kind, a, b, c, d]
//   ['kill', mobLevel, count, elite(0/1), spacingYards]   count may be fractional (expected kills)
//   ['use', count]       object uses
//   ['escort']           fixed-duration event
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
const { CLASS_BY_FILE, FACTION_RACES, SKYBORNE_BIT, hasBit } = require('../game/races');

const BUILDER_VERSION = 18;

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
// Skyborne leave the isle for good (docs/SIMULATION.md "Starts").
const SKYBORNE_EXITS = {
	Horde: [{ name: 'Zephras Isle airship', a: { map: 2521, x: 57.92, y: 80.78, f: 'l' }, b: { c: 1, wx: -658, wy: 426, map: 1412 }, ab: 90, wait: 60 }],
	Alliance: [{ name: 'Zephras Isle zeppelin + Skyborne portal', a: { map: 2521, x: 65.81, y: 83.44, f: 'l' }, b: { c: 0, wx: -8840.6, wy: 489.7, map: 1453 }, ab: 110, wait: 60 }],
};

const SITE_R = 70; // yards: objective spawns this close form one site
const DUP_R = 10; // yards: one spawn recorded on two overlapping zone maps
const VOTE_R = 150; // yards: cell of the zone vote (spawn records per map around a spot)
const HUB_R = 150; // yards: givers/enders this close form one hub
const NEAR_HUB = 200; // yards: a flight master or inn this close belongs to the hub
// Quest log size. Forever's client accepts 40 quests
// (Constants.QuestLogConsts.MAXIMUM_NUM_QUESTS_LOG_CAN_ACCEPT = 40 for its
// Camelot game type, Blizzard_APIDocumentationGenerated/QuestConstantsDocumentation.lua;
// its quest log shows N/40), but the published results were searched at 20,
// which only splits a zone's quest package (one: Alliance Elwynn Forest 6-10).
// 40 lands in 0.2.5 with the next world and new searches (issue #30).
const MAX_OPEN = 20;
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

function dataHash(dataDir, sourcesDir = null) {
	const h = crypto.createHash('sha1');
	h.update(`builder:${BUILDER_VERSION}\n`);
	for (const f of ['meta.json', 'travel.json', 'trainers.json', 'dungeons.json']) {
		const file = path.join(dataDir, f);
		h.update(`${f}:`);
		if (fs.existsSync(file)) h.update(fs.readFileSync(file));
	}
	// Instance areas for the solo filter (Forever client Map/AreaTable).
	const qa = sourcesDir ? SOLO.foreverBuild(sourcesDir) : null;
	h.update(`areas:${qa ? path.basename(qa) : '-'}:`);
	if (qa) for (const f of ['Map.csv', 'AreaTable.csv']) h.update(fs.readFileSync(path.join(qa, f)));
	return h.digest('hex');
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
// 94.3,3.5 and The Hinterlands 9.75,44.47). -> { pts, better } with
// better(a, b) > 0 when a's map is the better home.
function dedupeMaps(pts, votes) {
	const perMap = new Map();
	for (const p of pts) perMap.set(p.map, (perMap.get(p.map) || 0) + 1);
	const better = (a, b) => {
		if (a.map === b.map) return a.edge - b.edge;
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
	function addPoint(c, wx, wy, map) {
		const rx = Math.round(wx * 10) / 10;
		const ry = Math.round(wy * 10) / 10;
		const region = regionOf(c, Number(map));
		const k = `${region}:${rx}:${ry}`;
		let i = pointIdx.get(k);
		if (i == null) {
			i = points.length;
			points.push([c, region, rx, ry, Number(map)]);
			pointIdx.set(k, i);
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
				for (const p of sp.pts) {
					if (!Array.isArray(p) || p.length < 2) continue;
					const w = toWorld(map, p[0], p[1], sp.f);
					all.push({ ...w, region: regionOf(w.c, Number(map)), map: Number(map), f: sp.f || null, edge: Math.min(p[0], 100 - p[0], p[1], 100 - p[1]) });
				}
			}
			if (all.length) {
				// A site whose spawns lie on more than one zone map belongs to
				// the members' best home map (dedupeMaps).
				const { pts, better } = dedupeMaps(all, votes);
				const cl = cluster(pts, SITE_R).map((c) => {
					let home = pts[c.seed];
					for (const m of c.members) if (better(pts[m], home) > 0) home = pts[m];
					return { pt: addPoint(home.c, c.cx, c.cy, home.map), size: c.size, spacing: spacingOf(pts, c.members), map: home.map, f: home.f };
				});
				out = {
					kind, id: Number(id), raw, name: raw.name != null ? String(raw.name) : `${kind} ${id}`,
					friendly: kind === 'object' || friendly(raw.faction, faction),
					total: pts.length, sites: cl,
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
	for (const n of travel.taxi.nodes || []) {
		if (!(n.faction & fbit)) continue;
		const pt = addPoint(n.c, n.wx, n.wy, n.map);
		nodeByTaxi.set(n.id, nodes.length);
		nodes.push({ kind: 'fp', taxi: n.id, name: n.short || n.name, pt });
	}
	const taxi = [];
	for (const l of travel.taxi.legs || []) {
		const a = nodeByTaxi.get(l.from);
		const b = nodeByTaxi.get(l.to);
		if (a != null && b != null) taxi.push([a, b, l.cost]);
	}
	const rides = [];
	for (const t of travel.transports || []) {
		if (!(t.faction & fbit)) continue;
		// The dock: the deck where a ship lying off its pier is boarded (travel build's `board`), else the stop.
		const da = t.a.board || t.a;
		const db = t.b.board || t.b;
		const a = nodes.length;
		nodes.push({ kind: 'dock', name: `${t.a.name} (${t.kind})`, pt: addPoint(t.a.c, da.wx, da.wy, t.a.map) });
		const b = nodes.length;
		nodes.push({ kind: 'dock', name: `${t.b.name} (${t.kind})`, pt: addPoint(t.b.c, db.wx, db.wy, t.b.map) });
		rides.push([a, b, t.ab, t.waitA || 0, t.id]);
		rides.push([b, a, t.ba, t.waitB || 0, t.id]);
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
		const npc = data.npcs[String(inn.npc)];
		if (npc && !friendly(npc.faction, faction)) continue;
		inns.push({ name: inn.location, pt: addPoint(inn.c, inn.wx, inn.wy, inn.map) });
	}

	// ---- quests ----
	const excluded = [];
	const quests = [];
	const byId = new Map();
	// Solo filter (tools/lib/sim/solo.js): categories, overrides, instance areas.
	const solo = SOLO.compileOverrides(opts.overrides || SOLO.OVERRIDES);
	const questAreas = (data.questAreas && data.questAreas.areas) || {};
	const dungeonQuestIds = new Set();
	for (const d of (data.dungeons && data.dungeons.dungeons) || []) for (const dq of d.quests || []) if (!dq.hidden) dungeonQuestIds.add(Number(dq.id));
	const soloOut = new Map(); // quest id -> category
	const soloCounts = Object.fromEntries(SOLO.CATEGORIES.map((c) => [c, 0]));
	let repeatNoXp = 0;
	const ids = Object.keys(data.quests).map(Number).filter(Number.isFinite).sort((a, b) => a - b);
	// Escorts and rescues: "Help Perith Stormhoof escape Palemane Rock" (98430).
	const ESCORT_RE = /\bescort|\bprotect\b|\bdefend\b|\bkeep .* safe|\bguide .* safely|\blead .* to safety|\bescape\b/i;
	const UNUSED_RE = /\b(UNUSED|NYI|TEST|DEPRECATED)\b|^\[|<.*>|\(123\)/i;

	for (const id of ids) {
		const raw = data.quests[String(id)];
		if (!raw) continue;
		const races = Number(raw.races) || 0;
		if (races && !maskForFaction(races, faction)) continue; // other faction
		const ex = (reason, category = null) => {
			excluded.push(category ? { id, title: raw.title, reason, category } : { id, title: raw.title, reason });
			if (category) {
				soloOut.set(id, category);
				soloCounts[category]++;
			}
		};
		const title = raw.title != null ? String(raw.title) : `Quest ${id}`;
		if (UNUSED_RE.test(title)) {
			ex('unused/test quest');
			continue;
		}
		if (raw.event) {
			ex('seasonal event');
			continue;
		}
		// Solo rules (unless allowed, which also keeps a profession quest the
		// guides make possible: Cooking rank 1 trained next to the giver).
		const strict = !solo.allow.has(id);
		const sortId = typeof raw.zone === 'number' && raw.zone < 0 ? -raw.zone : null;
		if (strict && (raw.skill || (sortId != null && PROFESSION_SORTS.has(sortId)))) {
			ex('profession');
			continue;
		}
		const level = Number(raw.level) > 0 ? Number(raw.level) : Number(raw.minLevel) || 1;
		const minLevel = Number(raw.minLevel) > 0 ? Number(raw.minLevel) : Math.max(1, level - 5);
		if (minLevel >= 60) {
			ex('needs level 60 (mount swaps, endgame)');
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
				ex(`listed: ${listed.reason}`, listed.category);
				continue;
			}
			inst = questAreas[raw.area] || (dungeonQuestIds.has(id) ? 'dungeon' : null);
			if (raw.reputation && Number(raw.reputation.value) > SOLO.FRIENDLY) {
				ex('needs reputation above Friendly', 'reputation');
				continue;
			}
		}
		const exInst = () => ex(`${inst} quest (instance area or dungeons.json)`, inst);
		// Droppers a solo character farms: not elite, under quest level + 5.
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
		let startHigh = false;
		if (giver == null) {
			// Quest-starting item: expected kills of its best (solo) dropper.
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
						if (kind === 'npc' && !soloDropper(e)) {
							startHigh = true;
							continue;
						}
						const score = chance * Math.min(e.total, 20);
						if (!best || score > best.score) best = { e, kind, chance, score, item };
					}
				}
			}
			if (best) {
				const s = bestSite(best.e, null);
				giver = s.pt;
				gName = `${best.item.name || 'item'} (drop: ${best.e.name})`;
				gPos = posOf(s);
				const n = 100 / Math.min(100, best.chance);
				accept = { pt: s.pt, work: best.kind === 'npc' ? [['kill', npcLevel(best.e.raw, level), n, ELITE_RANKS.has(best.e.raw.rank) ? 1 : 0, s.spacing]] : [['use', n]] };
			}
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
		if (giver == null && startHigh) {
			ex('quest-starting item drops only from elites or mobs 5+ levels above', 'elite');
			continue;
		}
		if (giver == null) {
			if (inst) exInst();
			else ex('no located quest giver');
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
			else ex('no located turn-in');
			continue;
		}
		// Objectives.
		const objs = Array.isArray(raw.objectives) ? raw.objectives : [];
		const located = [];
		let missing = null;
		let missingCat = null; // solo category of the exclusion, if any
		let elite = false;
		// An objective with no open-world place: missing outside the open
		// world, or put at the giver for want of one (`inst` decides).
		let outside = false;
		const escort = ESCORT_RE.test([raw.objectiveText, ...objs.map((o) => o && o.text)].filter(Boolean).join(' '));
		const events = [];
		for (const o of objs) {
			if (!o) continue;
			const count = Number(o.count) > 0 ? Number(o.count) : 1;
			if (o.type === 'kill') {
				const e = sites('npc', o.id);
				if (!e) {
					missing = `kill objective npc ${o.id} has no open-world spawns`;
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
				if (e.raw.faction && e.friendly && (own(start.npc) || own(end.npc) || talk || deed)) {
					located.push({ pt: s.pt, work: ['use', deed ? count : 1] });
					continue;
				}
				if (e.raw.faction && !e.friendly && talk) continue;
				const el = ELITE_RANKS.has(e.raw.rank) ? 1 : 0;
				if (el && strict) {
					missing = `elite kill objective npc ${o.id}`;
					missingCat = 'elite';
					break;
				}
				if (el) elite = true;
				located.push({ pt: s.pt, work: ['kill', npcLevel(e.raw, level), count, el, s.spacing] });
			} else if (o.type === 'object') {
				const e = sites('object', o.id);
				if (!e) {
					missing = `object objective ${o.id} has no open-world spawns`;
					outside = true;
					break;
				}
				located.push({ pt: bestSite(e, giver).pt, work: ['use', count] });
			} else if (o.type === 'item') {
				const item = data.items[String(o.id)];
				let best = null;
				let anyDrop = false;
				let skippedHigh = false;
				let skippedRare = false;
				if (item && item.drops) {
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
								skippedHigh = true;
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
					if (best.kind === 'talk') located.push({ pt: best.s.pt, work: ['use', 1] });
					else if (best.kind === 'npc') {
						const el = ELITE_RANKS.has(best.e.raw.rank) ? 1 : 0;
						if (el) elite = true;
						located.push({ pt: best.s.pt, work: ['kill', npcLevel(best.e.raw, level), n, el, best.s.spacing] });
					} else located.push({ pt: best.s.pt, work: ['use', n] });
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
					if (v) located.push({ pt: v.pt, work: ['buy'] });
					else if (skippedHigh) {
						missing = `item objective ${o.id} drops only from elites or mobs 5+ levels above the quest`;
						missingCat = 'elite';
						break;
					} else if (skippedRare) {
						missing = `item objective ${o.id} drops below 1%`;
						missingCat = 'rareDrop';
						break;
					} else if (!anyDrop) {
						located.push({ pt: giver, work: ['use', 1] }); // made or handed over on the spot
						outside = true;
					} else {
						missing = `item objective ${o.id} drops only outside the open world`;
						outside = true;
						break;
					}
				}
			} else if (o.type === 'event') {
				events.push(o);
			}
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
				located.push({ pt: best.pt, work: escort ? ['escort'] : n > 1 ? ['use', n] : ['visit'] });
			} else if (escort || events.every((o) => o.map == null)) {
				located.push({ pt: giver, work: ['escort'] }); // runs where it starts
				outside = true;
			} else {
				missing = 'event objective outside the open world';
				outside = true;
			}
		}
		if (inst && outside) {
			exInst();
			continue;
		}
		if (missing) {
			ex(missing, missingCat);
			continue;
		}
		// Tasks: objectives grouped by site.
		const tasks = [];
		for (const l of located) {
			let t = tasks.find((x) => dist(x.pt, l.pt) <= SITE_R);
			if (!t) {
				t = { pt: l.pt, work: [] };
				tasks.push(t);
			}
			t.work.push(l.work);
		}
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
			breadcrumb: !objs.length,
			escort: escort && objs.some((o) => o && o.type === 'event'),
			elite,
			gName, eName, gPos, ePos,
		};
		if (startFrom != null) q.startFrom = startFrom;
		if (raw.parent != null) q.inLog = Number(raw.parent);
		byId.set(id, q);
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
		excluded.push({ id: q.id, title: q.title, reason: 'repeatable without a recorded reward (no XP)', category: 'repeatable' });
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
		if (!byId.has(q.inLog) && !excluded.some((e) => e.id === q.inLog)) {
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
		q.tier = q.breadcrumb ? 3 : q.escort || q.elite ? 7 : chainEnd ? 6 : 5;
	}
	// Prerequisites that are not quests of this world: other faction/race
	// (drop at run time) vs excluded for missing data (keep: unreachable).
	const excludedIds = new Set(excluded.map((e) => e.id));

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
		// Split when more than MAX_OPEN quests would be open at once.
		const chunks = [];
		let cur = [];
		let open = 0;
		for (const s of order) {
			if (s.kind === 'accept' && open >= MAX_OPEN) {
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

	return {
		schema: 1,
		faction,
		bandWidth,
		points,
		nodes,
		taxi,
		rides,
		inns,
		hubs,
		quests,
		excluded,
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
	for (const f of ['travel', 'trainers', 'dungeons']) {
		const file = path.join(dataDir, `${f}.json`);
		data[f] = fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null;
	}
	data.questAreas = sourcesDir ? SOLO.loadQuestAreas(sourcesDir) : null;
	return data;
}

// Cached world, rebuilt when the reference data (meta/travel/trainers/
// dungeons, the client instance tables) or the builder changed.
// opts: { dataDir, sourcesDir, simDir, faction, rebuild, questXp, log }
function getWorld(opts) {
	const file = worldFile(opts.simDir, opts.faction);
	const hash = dataHash(opts.dataDir, opts.sourcesDir);
	if (!opts.rebuild && fs.existsSync(file)) {
		const w = JSON.parse(fs.readFileSync(file, 'utf8'));
		if (w.dataHash === hash && w.bandWidth === (opts.bandWidth || 5)) return w;
	}
	if (opts.log) opts.log(`building world model for ${opts.faction}...`);
	const data = opts.data || loadSimData(opts.dataDir, opts.sourcesDir);
	if (!data.questAreas && opts.log) opts.log('  warning: no cached Forever Map/AreaTable: the solo filter knows instances from dungeons.json only');
	const w = buildWorld(data, { faction: opts.faction, bandWidth: opts.bandWidth, extraStarts: opts.extraStarts });
	w.dataHash = hash;
	w.questXp = opts.questXp;
	fs.mkdirSync(opts.simDir, { recursive: true });
	fs.writeFileSync(`${file}.tmp`, JSON.stringify(w));
	fs.renameSync(`${file}.tmp`, file);
	return w;
}

module.exports = { buildWorld, getWorld, worldFile, dataHash, cluster, ISLANDS, ISLE_MAPS, MAX_OPEN };
