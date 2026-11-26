'use strict';
// Guide goals at an NPC's or object's floor that the walking maps don't reach (#4146, #4133): one walk per goal, from
// the flight master of its map open to its side (else a portal's end on its map, as Darnassus' from Rut'theran, else
// the nearest flight master on its continent within NEAR_FM yards), to the goal at its height, on a Polestar_Nav folder's maps through the eval harness (run.js). A goal is listed when
//   none              the router finds no walk at all;
//   reached-elsewhere the walk ends on another floor than the goal's (Path.lua's reach: its own floor is cut off from
//                     the flight master's, as Gretta Finespindle's shop from the Great Forge's walkway, #4133);
//   off-floor         the node the goal stands on lies more than OFF_YARDS across or OFF_HEIGHT above or below it:
//                     the walking maps have no floor there (Zilzibin Drumlore's house in the Drag, #4146), and the
//                     drawn line goes on straight from that node through the wall.
//
//   goalPoints(srcs, geo, { maps }) -> [{ map, x, y, z, c, wx, wy, sides: Set, what: Set }]  (the compiled guides'
//     Guides.lua sources; `maps`: only goals on these uiMapIDs, all when null)
//   goalFloorQueries(points, taxi, portals) -> { queries, meta }  (data/forever/travel.json's taxi.nodes and
//     transit.portals)
//   judgeGoalFloors(results, meta) -> [{ bad, map, x, y, z, from, profile, off, dz, what }]

const NEAR_FM = 2500;
const OFF_YARDS = 9; // past a counter (an auctioneer's 7 yd behind his)
const OFF_HEIGHT = 4;
const SIDES = { Alliance: [1, 3], Horde: [2, 3] };

function goalPoints(srcs, geo, { maps = null } = {}) {
	const points = new Map();
	for (const { src, side } of srcs) {
		for (const m of src.matchAll(/\{ t = "(\w+)"[^\n]*?(npc|object) = (\d+)[^\n]*?map = (\d+), x = ([\d.]+), y = ([\d.]+), z = (-?[\d.]+)(, f = "e")?/g)) {
			const [, t, kind, id, map, x, y, z, fe] = m;
			if (maps && !maps.has(+map)) continue;
			const w = geo.toWorld(+map, +x, +y, fe ? 'e' : 'l');
			if (!w || ![0, 1].includes(w.c)) continue;
			const key = `${map}|${(+x).toFixed(2)}|${(+y).toFixed(2)}|${z}`;
			const g = points.get(key) || { map: +map, x: +x, y: +y, z: +z, c: w.c, wx: w.wx, wy: w.wy, sides: new Set(), what: new Set() };
			for (const s of side ? [side] : ['Alliance', 'Horde']) g.sides.add(s);
			g.what.add(`${t} ${kind} ${id}`);
			points.set(key, g);
		}
	}
	return [...points.values()].sort((a, b) => a.map - b.map || a.x - b.x || a.y - b.y);
}

function goalFloorQueries(points, taxi, portals = []) {
	const queries = [];
	const meta = {};
	for (const g of points) {
		let fm = null;
		let profile = null;
		for (const s of ['Alliance', 'Horde'].filter((s) => g.sides.has(s))) {
			fm = taxi.find((t) => t.map === g.map && t.c === g.c && SIDES[s].includes(t.faction)) || null;
			if (!fm) {
				const end = portals.flatMap((p) => [p.a, p.b]).find((e) => e && e.map === g.map && e.c === g.c);
				if (end) fm = { name: end.name, wx: end.wx, wy: end.wy };
			}
			if (!fm) {
				let best = NEAR_FM;
				for (const t of taxi) {
					const d = t.c === g.c && SIDES[s].includes(t.faction) ? Math.hypot(t.wx - g.wx, t.wy - g.wy) : Infinity;
					if (d < best) [best, fm] = [d, t];
				}
			}
			if (fm) {
				profile = s;
				break;
			}
		}
		if (!fm) continue;
		const id = `g${queries.length}`;
		meta[id] = { g, from: fm.name, profile };
		queries.push({ type: 'route', id, map: g.c, from: [fm.wx, fm.wy, null], to: [g.wx, g.wy, g.z], floors: null, reach: null, profile, style: 'balanced', level: null, danger: null });
	}
	return { queries, meta };
}

function judgeGoalFloors(results, meta) {
	const out = [];
	for (const r of results) {
		const m = r.type === 'route' && meta[r.id];
		if (!m) continue;
		const { g } = m;
		const off = r.goal ? Math.hypot(r.goal[0] - g.wx, r.goal[1] - g.wy) : null;
		const dz = r.goal ? Math.abs(r.goal[2] - g.z) : null;
		const bad = !r.ok ? 'none' : r.reached ? 'reached-elsewhere' : off !== null && (off > OFF_YARDS || dz > OFF_HEIGHT) ? 'off-floor' : null;
		if (bad) out.push({ bad, map: g.map, x: g.x, y: g.y, z: g.z, from: m.from, profile: m.profile, off: off === null ? null : +off.toFixed(1), dz: dz === null ? null : +dz.toFixed(1), what: [...g.what].sort() });
	}
	return out;
}

module.exports = { goalPoints, goalFloorQueries, judgeGoalFloors, OFF_YARDS, OFF_HEIGHT };
