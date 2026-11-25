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
// contested ones. `rate` is the items a looted kill yields: the drop chance
// times the item's YIELD (below). A cluster of fewer than MIN_SPAWNS mobs is
// no farm while the continent has another. Of the rest, each zone keeps its
// best cluster per safety and 5-level band (by rate × spawns), so every zone
// that has droppers keeps a camp for each level range (Linen Cloth: the
// Defias of Elwynn Forest and of Westfall, not only Dun Morogh's trolls). Per
// continent at most MAX_PER_CONTINENT of those are kept, taken round-robin
// over (safety, 10-level band) groups, so every faction and level range keeps
// its best spots (the Engine drops spots 2+ levels above the player, so a set
// of only level-50 camps helps nobody at 10).

const { clusterPoints } = require('../questdb/cluster');
const { ZONES } = require('../professions/gathering/tables');

const MIN_CHANCE = 2;
const TOWN_YARDS = 90;
const CLUSTER_YARDS = 70;
const MAX_PER_CONTINENT = 32;
const MIN_SPAWNS = 3;
const BAND = 5;
const PER_NPC_MAP = 4;
// Items a looted kill yields per drop chance, from players' recordings (loot
// windows of the item's droppers, Nov 2026: items looted per window divided by
// the data's chance per window; items with 500+ windows). Cloth drops one to
// three at a time, so a looted humanoid yields about one and a half times its
// chance; meats and eggs drop less often on Forever than the data's chance.
// Any other item: its chance.
const YIELD = {
	769: 0.77, // Chunk of Boar Meat
	2589: 1.53, // Linen Cloth
	2592: 1.54, // Wool Cloth
	2672: 0.83, // Stringy Wolf Meat
	2673: 0.78, // Coyote Meat
	2674: 0.95, // Crawler Meat
	2677: 0.61, // Boar Ribs
	3173: 0.72, // Bear Meat
	3685: 0.43, // Raptor Egg
	3731: 0.56, // Lion Meat
	4306: 1.56, // Silk Cloth
	4338: 1.48, // Mageweave Cloth
	5469: 0.73, // Strider Meat
	5470: 0.45, // Thunder Lizard Tail
	6889: 0.97, // Small Egg
	12184: 0.59, // Raptor Flesh
	12207: 0.81, // Giant Egg
	14047: 1.47, // Runecloth
	14227: 2.2, // Ironweb Spider Silk
};
// Blizzard creature ranks: 0 normal, 1 elite, 2 rare elite, 3 boss, 4 rare.
const FARMABLE_RANKS = new Set([undefined, null, 0, 4]);
const SERVICE_ROLES = new Set(['vendor', 'innkeeper', 'repair', 'flightmaster', 'banker', 'stablemaster', 'auctioneer', 'battlemaster', 'spirithealer']);
// Hostile mobs whose kill costs reputation a player wants (the world DB's
// creature_onkill_reputation): every Timbermaw furbolg costs 25 Timbermaw
// Hold reputation, whose tunnels lead to Moonglade and Everlook and whose
// quartermaster sells Timbermaw patterns. Never a farm spot.
const PROTECTED_MOBS = new Set([6184, 6185, 6186, 6187, 6188, 6189, 6651, 11516, 11552, 11553, 11555, 11557, 11558]);
// The data spawns a creature at one spot on every map whose frame covers it
// (the Jaedenar cultists of Felwood also stand on Darkshore's south edge): a
// map's copy whose every point lies this close (yards) to a point of another
// copy is that spot seen from the neighbouring zone (see overlapMaps).
const DUP_YARDS = 30;

function round2(n) {
	const r = Math.round(n * 100) / 100;
	return Object.is(r, -0) ? 0 : r;
}

function round3(n) {
	return Math.round(n * 1000) / 1000;
}

// Zone safety for a map: the gathering zone table, else contested for any
// open-world zone in zones.json (UIMapType 3) on Eastern Kingdoms or Kalimdor
// by its frame (Era, else Forever's for a map Forever added, such as
// Riverglades or Mount Hyjal), else not farmable (cities, instances,
// battlegrounds, other continents, maps the client cannot place).
function zoneSafety(data, map) {
	const z = ZONES[map];
	if (z) return z.side;
	const info = data.zone(map);
	const fr = data.frame(map);
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

// The maps where an npc's spawns are only another map's spawns seen over the
// zone border: of two copies on one continent whose points all lie within
// DUP_YARDS of the other's, the one nearer its map's edge (its most inland
// point's distance to the edge; the higher map id on a tie) goes. Era-frame
// copies only: a map Forever added has no Era frame to compare in.
function overlapMaps(data, spawns) {
	const copies = [];
	for (const s of spawns) {
		const fr = s.f === 'e' ? data.eraFrame(s.map) : null;
		if (!fr) continue;
		const pts = [...s.pts, ...s.more];
		const world = pts.map((p) => [fr.top + ((fr.bottom - fr.top) * p[1]) / 100, fr.left + ((fr.right - fr.left) * p[0]) / 100]);
		const edge = Math.max(...pts.map((p) => Math.min(p[0], 100 - p[0], p[1], 100 - p[1])));
		copies.push({ map: s.map, c: fr.c, world, edge });
	}
	const out = new Set();
	for (const a of copies) {
		for (const b of copies) {
			if (a === b || a.c !== b.c || out.has(b.map)) continue;
			const nearer = a.edge < b.edge || (a.edge === b.edge && a.map > b.map);
			if (nearer && a.world.every((p) => b.world.some((q) => Math.hypot(p[0] - q[0], p[1] - q[1]) <= DUP_YARDS))) {
				out.add(a.map);
				break;
			}
		}
	}
	return out;
}

// -> [spot] sorted by continent, then rate × spawns (best first), map, x, y.
// Memoised per data and item: a guide set farms the same items many times.
const SPOTS = new WeakMap();
function farmSpots(data, itemId) {
	let byItem = SPOTS.get(data);
	if (!byItem) SPOTS.set(data, (byItem = new Map()));
	if (!byItem.has(itemId)) byItem.set(itemId, farmSpotsOf(data, itemId));
	return byItem.get(itemId);
}

function farmSpotsOf(data, itemId) {
	const it = data.item(itemId);
	const drops = (it && it.drops && it.drops.npc) || {};
	const yieldOf = YIELD[Number(itemId)] || 1;
	const towns = townPoints(data);
	const all = [];
	for (const id of Object.keys(drops).map(Number).sort((a, b) => a - b)) {
		const chance = Number(drops[id]) || 0;
		if (chance < MIN_CHANCE) continue;
		const npc = data.npc(id);
		if (!npc || !FARMABLE_RANKS.has(npc.rank) || PROTECTED_MOBS.has(id)) continue;
		if (npc.faction) continue;
		if (Array.isArray(npc.roles) && npc.roles.some((r) => SERVICE_ROLES.has(r))) continue;
		const spawns = data.spawns('npc', id);
		const seenOver = overlapMaps(data, spawns);
		for (const s of spawns) {
			if (seenOver.has(s.map)) continue;
			const faction = zoneSafety(data, s.map);
			if (!faction) continue;
			const { sx, sy } = yardScale(data, s.map);
			const markers = towns.get(s.map) || [];
			const open = s.pts.filter((p) => !markers.some((m) => Math.hypot((p[0] - m[0]) * sx, (p[1] - m[1]) * sy) <= TOWN_YARDS));
			if (!open.length) continue;
			const fr = data.frame(s.map);
			const era = s.f === 'e' && (data.eraFrame(s.map) || !Object.keys(data.mapFrames.era || {}).length);
			for (const c of clusterPoints(open, fr, { radius: CLUSTER_YARDS, cap: PER_NPC_MAP })) {
				const spot = { map: s.map, x: round2(c.x), y: round2(c.y) };
				if (era) spot.f = 'e';
				spot.faction = faction;
				spot.npc = id;
				spot.npcName = String(npc.name);
				const lo = Number(npc.level) || 1;
				const hi = Math.max(lo, Number(npc.levelMax) || lo);
				spot.lvl = { min: lo, max: hi };
				spot.rate = round3((chance / 100) * yieldOf);
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
		let list = byContinent.get(c);
		if (list.some((a) => a.spot.spawns >= MIN_SPAWNS)) list = list.filter((a) => a.spot.spawns >= MIN_SPAWNS);
		// Each zone's best camp per safety and level band.
		const best = new Map();
		for (const a of list) {
			const key = `${a.spot.faction}|${a.spot.map}|${Math.floor(a.spot.lvl.min / BAND)}`;
			const b = best.get(key);
			if (!b || order(a, b) < 0) best.set(key, a);
		}
		const groups = new Map();
		for (const a of best.values()) {
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

module.exports = { farmSpots, zoneSafety, MIN_CHANCE, TOWN_YARDS, MAX_PER_CONTINENT, MIN_SPAWNS, YIELD, PROTECTED_MOBS };
