'use strict';
// World <-> Era map conversions over data/forever/map-frames.json.
// World coordinates follow the client: wx grows north, wy grows west.
// For a frame { c, left, right, top, bottom }:
//   x% = (wy - left) / (right - left) * 100,  y% = (wx - top) / (bottom - top) * 100

const round = (v, places) => {
	const k = 10 ** places;
	const r = Math.round(v * k) / k;
	return Object.is(r, -0) ? 0 : r;
};

class Frames {
	// frames: map-frames.json `era`; zones: zones.json
	constructor(frames, zones) {
		this.frames = new Map();
		this.zones = zones || {};
		for (const [id, b] of Object.entries(frames || {})) this.frames.set(Number(id), b);
	}

	// These frames and, for a map with no frame here, its frame in `forever`
	// (map-frames.json `forever`: the maps Forever added, the Riverglades).
	withForever(forever) {
		const all = Object.fromEntries(this.frames);
		for (const [id, b] of Object.entries(forever || {})) if (!this.frames.has(Number(id))) all[id] = b;
		return new Frames(all, this.zones);
	}

	frame(map) {
		return this.frames.get(Number(map)) || null;
	}

	name(map) {
		const z = this.zones[String(map)];
		return z ? z.name : null;
	}

	toWorld(map, x, y) {
		const b = this.frame(map);
		if (!b) return null;
		return { c: b.c, wx: b.top + (b.bottom - b.top) * (y / 100), wy: b.left + (b.right - b.left) * (x / 100) };
	}

	toMap(map, c, wx, wy) {
		const b = this.frame(map);
		if (!b || b.c !== c) return null;
		return { x: ((wy - b.left) / (b.right - b.left)) * 100, y: ((wx - b.top) / (b.bottom - b.top)) * 100 };
	}

	// Zone/city maps (type 3) of continent c whose rectangle holds the point,
	// smallest first (a city wins over the zone around it).
	containing(c, wx, wy) {
		const out = [];
		for (const [id, b] of this.frames) {
			const z = this.zones[String(id)];
			if (b.c !== c || (z && z.type !== 3)) continue;
			const p = this.toMap(id, c, wx, wy);
			if (p.x < 0 || p.x > 100 || p.y < 0 || p.y > 100) continue;
			out.push({ map: id, x: p.x, y: p.y, area: Math.abs((b.right - b.left) * (b.bottom - b.top)) });
		}
		return out.sort((a, b) => a.area - b.area || a.map - b.map);
	}

	// Continent uiMap per continent id ({ 0: 1415, 1: 1414 }): the type 2 map
	// with the largest rectangle (the world-map-sized one).
	continents() {
		const best = {};
		for (const [id, b] of this.frames) {
			const z = this.zones[String(id)];
			if (!z || z.type !== 2) continue;
			const area = Math.abs((b.right - b.left) * (b.bottom - b.top));
			if (!best[b.c] || area > best[b.c].area) best[b.c] = { map: id, area };
		}
		const out = {};
		for (const c of Object.keys(best).sort((a, b) => a - b)) out[c] = best[c].map;
		return out;
	}
}

// Pick the map for a world point: a map in `prefer` (e.g. where the matching
// NPC spawns), then the exact location named before the comma in `label`,
// then the region after it, then the smallest containing map. A flight
// master listed on both city and region maps belongs to the named city.
function placePoint(frames, c, wx, wy, { prefer = [], label = '' } = {}) {
	const cands = frames.containing(c, wx, wy);
	if (!cands.length) return null;
	// "Tarren Mill, Hillsbrad" names its zone after the comma, sometimes shortened.
	const comma = String(label).indexOf(',');
	const location = (comma >= 0 ? String(label).slice(0, comma) : String(label)).trim().toLowerCase();
	const suffix = comma >= 0 ? String(label).slice(comma + 1).trim().toLowerCase() : '';
	const score = (cand) => {
		let s = 0;
		if (prefer.includes(cand.map)) s += 4;
		const name = frames.name(cand.map);
		if (name && location && name.toLowerCase() === location) s += 2;
		if (name && suffix && name.toLowerCase().startsWith(suffix)) s += 1;
		return s;
	};
	let best = cands[0];
	for (const cand of cands) if (score(cand) > score(best)) best = cand;
	return { map: best.map, x: round(best.x, 2), y: round(best.y, 2) };
}

const dist2d = (a, b) => Math.hypot(a.wx - b.wx, a.wy - b.wy);

// A step between two TaxiPathNode points that is not flown/sailed: a
// continent change, a point flagged as a teleport (Flags & 1), or a jump
// longer than any real segment (a transport loop closing through a teleport).
const JUMP_YARDS = 3000; // real flight segments reach ~2000 yd; transport teleports are 4500+
const isJump = (a, b) => a.c !== b.c || (a.flags & 1) !== 0 || dist2d(a, b) > JUMP_YARDS;

module.exports = { Frames, placePoint, round, dist2d, isJump, JUMP_YARDS };
