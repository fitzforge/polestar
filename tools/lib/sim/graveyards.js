'use strict';
// The graveyards a faction's dead resurrect at, for the deathskip (v2/travel2.js):
// CMaNGOS classic-db game_graveyard_zone and world_safe_locs (cmangos.js
// loadGraveyards), data/forever/zones.json's AreaTable zone of each map, and the
// Spirit Healer spawns of data/forever/npcs.json (the `spirithealer` role, placed
// through map-frames.json).
//
//   graveyardsFor(extract, faction, { zones, npcs, frames })
//     -> { areaOfMap: { uiMap: areaId }, list: [{ id, name, c, x, y, areas }], noHealer: [{ id, name, yd }] }
//
// The server (CMaNGOS GetClosestGraveyard) puts a dead character at the
// graveyard closest to the corpse among those linked to the zone it died in for
// its team (team 0: either), on the corpse's map: list holds the continents'
// (maps 0 and 1) graveyards with the zones (areas) whose dead they take for this
// faction, each with a Spirit Healer spawn within HEALER_YD (a graveyard without
// one is no deathskip: noHealer lists them and the nearest healer's yards). A zone
// with no linked graveyard (Forever's own, like Zephras Isle) has none.

const TEAM = { Horde: 67, Alliance: 469 };
const MAPS = new Set([0, 1]);
// A graveyard's Spirit Healer stands this close (71 of the 88 continent graveyards within 30 yd).
const HEALER_YD = 100;

// npcs.json's Spirit Healer spawns as world points { c, x, y } (map percent through the map frames).
function healerSpots(npcs, frames) {
	const out = [];
	for (const n of Object.values(npcs || {})) {
		if (!n || !(n.roles || []).includes('spirithealer')) continue;
		for (const [map, s] of Object.entries(n.spawns || {})) {
			const b = (frames.era && frames.era[map]) || (frames.forever && frames.forever[map]);
			if (!b) continue;
			for (const [px, py] of s.pts) out.push({ c: b.c, x: b.top + ((b.bottom - b.top) * py) / 100, y: b.left + ((b.right - b.left) * px) / 100 });
		}
	}
	return out;
}

function graveyardsFor(extract, faction, { zones, npcs, frames }) {
	const team = TEAM[faction];
	if (!team) throw new Error(`graveyards: unknown faction ${faction}`);
	const areaOfMap = {};
	for (const z of Object.values(zones || {})) if (z && z.id != null && z.areaId != null) areaOfMap[z.id] = Number(z.areaId);
	const healers = healerSpots(npcs, frames);
	const areas = new Map();
	for (const [id, zone, t] of extract.links) {
		if (t !== 0 && t !== team) continue;
		if (!areas.has(id)) areas.set(id, []);
		areas.get(id).push(zone);
	}
	const list = [];
	const noHealer = [];
	for (const [id, zs] of [...areas].sort((a, b) => a[0] - b[0])) {
		const loc = extract.locs[id];
		if (!loc || !MAPS.has(loc[0])) continue;
		let near = Infinity;
		for (const h of healers) if (h.c === loc[0]) near = Math.min(near, Math.hypot(h.x - loc[1], h.y - loc[2]));
		if (near > HEALER_YD) {
			noHealer.push({ id, name: loc[4], yd: Math.round(near) });
			continue;
		}
		list.push({ id, name: loc[4], c: loc[0], x: loc[1], y: loc[2], areas: zs });
	}
	return { areaOfMap, list, noHealer };
}

module.exports = { graveyardsFor, healerSpots, TEAM, HEALER_YD };
