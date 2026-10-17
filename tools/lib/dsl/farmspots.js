'use strict';
// Farm spots for `collect <item> xN nearest` (docs/ARCHITECTURE.md, "Smart
// logic", Farm spots): where to kill mobs that drop the item.
//
//   spot = { map, x, y, f, faction, npc, npcName, lvl = { min, max }, rate, spawns }
//
// Droppers: npcs with a drop chance of at least MIN_CHANCE percent, normal or
// rare (no elites, rare elites or bosses), hostile to everyone (no faction tag
// and no service role). Their spawn points inside towns and guard posts (within
// TOWN_YARDS of any faction-tagged or service npc) are dropped; the rest are
// clustered per npc and map (70-yd clusters, as in the quest database).
// `faction` is the zone's safety: "A"/"H" in a faction's own zones, "AH" in
// contested ones. Per continent at most MAX_PER_CONTINENT spots are kept,
// taken round-robin over (safety, 10-level band) groups by rate × spawns, so
// every faction and level range keeps its best spots (the Engine drops spots
// 3+ levels above the player, so a set of only level-50 camps helps nobody at 10).

const { clusterPoints } = require('../questdb/cluster');
const { ZONES } = require('../professions/gathering/tables');

const MIN_CHANCE = 2;
const TOWN_YARDS = 90;
const CLUSTER_YARDS = 70;
const MAX_PER_CONTINENT = 16;
const PER_NPC_MAP = 4;
// Blizzard creature ranks: 0 normal, 1 elite, 2 rare elite, 3 boss, 4 rare.
const FARMABLE_RANKS = new Set([undefined, null, 0, 4]);
const SERVICE_ROLES = new Set(['vendor', 'innkeeper', 'repair', 'flightmaster', 'banker', 'stablemaster', 'auctioneer', 'battlemaster', 'spirithealer']);

function round2(n) {
	const r = Math.round(n * 100) / 100;
	return Object.is(r, -0) ? 0 : r;
}

function round3(n) {
	return Math.round(n * 1000) / 1000;
}

// Zone safety for a map: the gathering zone table, else contested for any
// open-world zone in zones.json (UIMapType 3) with Era bounds, else not
// farmable (cities, instances, battlegrounds, maps the client cannot place).
function zoneSafety(data, map) {
	const z = ZONES[map];
	if (z) return z.side;
	const info = data.zone(map);
	const fr = data.eraFrame(map);
	// Continents 0 (Eastern Kingdoms) and 1 (Kalimdor) only: battlegrounds are zones too.
	return info && info.type === 3 && fr && (fr.c === 0 || fr.c === 1) ? 'AH' : null;
}

// Town markers per map, in yards: every spawn of an npc that is
// faction-tagged or offers a service. Cached per data object.
const townCache = new WeakMap();
function townPoints(data) {
	if (townCache.has(data)) return townCache.get(data);
	const byMap = new Map();
	for (const n of Object.values(data.npcs)) {
		if (!n || !n.spawns) continue;
		const tagged = n.faction === 'A' || n.faction === 'H' || n.faction === 'AH';
		const service = Array.isArray(n.roles) && n.roles.some((r) => SERVICE_ROLES.has(r));
		if (!tagged && !service) continue;
		for (const s of data.spawns('npc', n.id)) {
			if (!byMap.has(s.map)) byMap.set(s.map, []);
			byMap.get(s.map).push(...s.pts);
		}
	}
	townCache.set(data, byMap);
	return byMap;
}

function yardScale(data, map) {
	const fr = data.frame(map);
	if (!fr) return { sx: 30, sy: 20 };
	return { sx: Math.abs(fr.right - fr.left) / 100, sy: Math.abs(fr.bottom - fr.top) / 100 };
}

// -> [spot] sorted by continent, then rate × spawns (best first), map, x, y.
function farmSpots(data, itemId) {
	const it = data.item(itemId);
	const drops = (it && it.drops && it.drops.npc) || {};
	const towns = townPoints(data);
	const all = [];
	for (const id of Object.keys(drops).map(Number).sort((a, b) => a - b)) {
		const chance = Number(drops[id]) || 0;
		if (chance < MIN_CHANCE) continue;
		const npc = data.npc(id);
		if (!npc || !FARMABLE_RANKS.has(npc.rank)) continue;
		if (npc.faction) continue;
		if (Array.isArray(npc.roles) && npc.roles.some((r) => SERVICE_ROLES.has(r))) continue;
		for (const s of data.spawns('npc', id)) {
			const faction = zoneSafety(data, s.map);
			if (!faction) continue;
			const { sx, sy } = yardScale(data, s.map);
			const markers = towns.get(s.map) || [];
			const open = s.pts.filter((p) => !markers.some((m) => Math.hypot((p[0] - m[0]) * sx, (p[1] - m[1]) * sy) <= TOWN_YARDS));
			if (!open.length) continue;
			const fr = data.eraFrame(s.map);
			const era = s.f === 'e' && (fr || !Object.keys(data.mapFrames.era || {}).length);
			for (const c of clusterPoints(open, fr, { radius: CLUSTER_YARDS, cap: PER_NPC_MAP })) {
				const spot = { map: s.map, x: round2(c.x), y: round2(c.y) };
				if (era) spot.f = 'e';
				spot.faction = faction;
				spot.npc = id;
				spot.npcName = String(npc.name);
				const lo = Number(npc.level) || 1;
				const hi = Math.max(lo, Number(npc.levelMax) || lo);
				spot.lvl = { min: lo, max: hi };
				spot.rate = round3(Math.min(1, chance / 100));
				spot.spawns = c.n;
				all.push({ spot, c: fr ? fr.c : null, score: spot.rate * spot.spawns });
			}
		}
	}
	const byContinent = new Map();
	for (const a of all) {
		if (!byContinent.has(a.c)) byContinent.set(a.c, []);
		byContinent.get(a.c).push(a);
	}
	const order = (a, b) => b.score - a.score || a.spot.map - b.spot.map || a.spot.x - b.spot.x || a.spot.y - b.spot.y;
	const out = [];
	for (const c of [...byContinent.keys()].sort((a, b) => (a === null ? 1 : b === null ? -1 : a - b))) {
		const groups = new Map();
		for (const a of byContinent.get(c)) {
			const key = `${a.spot.faction}|${Math.floor(a.spot.lvl.min / 10)}`;
			if (!groups.has(key)) groups.set(key, []);
			groups.get(key).push(a);
		}
		const lists = [...groups.keys()].sort().map((k) => groups.get(k).sort(order));
		const kept = [];
		for (let round = 0; kept.length < MAX_PER_CONTINENT; round++) {
			const layer = lists.filter((l) => l[round]).map((l) => l[round]).sort(order);
			if (!layer.length) break;
			kept.push(...layer.slice(0, MAX_PER_CONTINENT - kept.length));
		}
		out.push(...kept.sort(order).map((a) => a.spot));
	}
	return out;
}

module.exports = { farmSpots, zoneSafety, MIN_CHANCE, TOWN_YARDS, MAX_PER_CONTINENT };
