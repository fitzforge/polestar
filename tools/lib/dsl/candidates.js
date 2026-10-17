'use strict';
// Candidate sets for smart targets (`train <Profession>`, `train class`,
// `buy … nearest`, `vendor nearest`, `sethome nearest`): every matching NPC
// with a spawn point and a faction tag. The engine picks one at runtime by
// the player's faction and position (docs/ARCHITECTURE.md, "Smart logic").
//
// Sets keep one candidate per town (hub): per continent, faction tag and class
// list, a candidate within HUB_YARDS of one already kept is dropped, nearest to
// the reference point first when it is on that continent. Every town stays
// reachable, so the Engine can pick the nearest from wherever the player is;
// MAX_PER_GROUP only guards against runaway data. Each candidate carries the
// height of its NPC's spawn there (`z`, heights.js) when spawnz.json has one.

const { candidateHeight } = require('./heights');

const CAP = 6; // kept for callers that ask for a hard per-group limit
const HUB_YARDS = 250;
const MAX_PER_GROUP = 120;
const SERVICE_ROLES = ['vendor', 'innkeeper', 'repair'];
const SAME_SPOT_YARDS = 100;

function round2(n) {
	const r = Math.round(n * 100) / 100;
	return Object.is(r, -0) ? 0 : r;
}

function worldPos(data, map, x, y) {
	const fr = data.eraFrame(map);
	if (!fr) return null;
	return { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * y) / 100, wy: fr.left + ((fr.right - fr.left) * x) / 100 };
}

// One point per map an npc spawns on: the spawn nearest that map's centroid.
function spawnPoints(data, id) {
	return data.spawns('npc', id).map((s) => {
		let cx = 0;
		let cy = 0;
		for (const p of s.pts) {
			cx += p[0];
			cy += p[1];
		}
		cx /= s.pts.length;
		cy /= s.pts.length;
		let best = s.pts[0];
		let bd = Infinity;
		for (const p of s.pts) {
			const d = (p[0] - cx) ** 2 + (p[1] - cy) ** 2;
			if (d < bd) {
				bd = d;
				best = p;
			}
		}
		// Era points need the map's Era bounds to be placed; without them the
		// client reads the point as live-frame.
		const era = s.f === 'e' && (data.eraFrame(s.map) || !Object.keys(data.mapFrames.era || {}).length);
		return { map: s.map, x: round2(best[0]), y: round2(best[1]), f: era ? 'e' : undefined };
	});
}

// "A" | "H" | "AH" | null: the union of npcs.json's faction and the sides the
// id was listed for (a goblin listed as both factions' quest giver serves
// both); with neither, neutral-town service NPCs (goblins) count as both.
function factionTag(npc, side) {
	const f = npc.faction === 'A' || npc.faction === 'H' || npc.faction === 'AH' ? npc.faction : '';
	const s = side === 'A' || side === 'H' || side === 'AH' ? side : '';
	const a = f.includes('A') || s.includes('A');
	const h = f.includes('H') || s.includes('H');
	if (a || h) return `${a ? 'A' : ''}${h ? 'H' : ''}`;
	if (!npc.faction && (npc.roles || []).some((r) => SERVICE_ROLES.includes(r))) return 'AH';
	return null;
}

function usableBy(tag, side) {
	return tag === 'AH' || tag === (side === 'Alliance' ? 'A' : 'H');
}

// An NPC's points with world positions, the same spot seen on two maps (a
// city and the zone around it) kept once, on the smaller (more detailed) map.
function distinctPoints(data, id) {
	const area = (map) => {
		const fr = data.eraFrame(map);
		return fr ? Math.abs((fr.right - fr.left) * (fr.bottom - fr.top)) : Infinity;
	};
	const pts = spawnPoints(data, id)
		.map((p) => ({ p, w: worldPos(data, p.map, p.x, p.y), a: area(p.map) }))
		.sort((x, y) => x.a - y.a || x.p.map - y.p.map);
	const kept = [];
	for (const q of pts) {
		if (q.w && kept.some((k) => k.w && k.w.c === q.w.c && Math.hypot(k.w.wx - q.w.wx, k.w.wy - q.w.wy) < SAME_SPOT_YARDS)) continue;
		kept.push(q);
	}
	return kept;
}

// entries: [{ npc, side?: "A"|"H", classes?: [classFile] }]
// opts: { sides: ["Alliance","Horde"], ref: { map, x, y } | null, cap }
// -> { candidates, coverage: { Alliance: bool, Horde: bool } }
function buildCandidates(data, entries, opts) {
	const sides = opts.sides;
	const cap = opts.cap || MAX_PER_GROUP;
	const ref = opts.ref ? worldPos(data, opts.ref.map, opts.ref.x, opts.ref.y) : null;
	const merged = new Map(); // npc id -> { side, classes }
	for (const e of entries) {
		const id = Number(e.npc);
		if (!(id > 0)) continue;
		const prev = merged.get(id);
		if (!prev) merged.set(id, { side: e.side, classes: e.classes ? [...e.classes] : null });
		else {
			if (e.side && prev.side !== e.side) prev.side = prev.side ? 'AH' : e.side;
			if (e.classes && prev.classes) for (const c of e.classes) if (!prev.classes.includes(c)) prev.classes.push(c);
		}
	}
	const all = [];
	for (const id of [...merged.keys()].sort((a, b) => a - b)) {
		const npc = data.npc(id);
		if (!npc) continue;
		const meta = merged.get(id);
		const tag = factionTag(npc, meta.side);
		if (!tag || !sides.some((s) => usableBy(tag, s))) continue;
		for (const { p, w } of distinctPoints(data, id)) {
			const cand = { npc: id };
			if (npc.name) cand.npcName = String(npc.name);
			cand.map = p.map;
			cand.x = p.x;
			cand.y = p.y;
			if (p.f) cand.f = p.f;
			const z = candidateHeight(data, cand);
			if (z !== undefined) cand.z = round2(z);
			cand.faction = tag;
			if (meta.classes && meta.classes.length) cand.classes = meta.classes;
			const near = ref && w && w.c === ref.c;
			all.push({ cand, c: w ? w.c : null, w, d: near ? Math.hypot(w.wx - ref.wx, w.wy - ref.wy) : null });
		}
	}
	const coverage = {};
	for (const s of sides) coverage[s] = all.some((a) => usableBy(a.cand.faction, s));

	const order = (a, b) => {
		if ((a.d === null) !== (b.d === null)) return a.d === null ? 1 : -1;
		if (a.d !== null && a.d !== b.d) return a.d - b.d;
		return a.cand.map - b.cand.map || a.cand.npc - b.cand.npc;
	};
	const groups = new Map();
	for (const a of all) {
		const key = `${a.c}|${a.cand.faction}|${(a.cand.classes || []).join(',')}`;
		if (!groups.has(key)) groups.set(key, []);
		groups.get(key).push(a);
	}
	const kept = [];
	for (const list of groups.values()) {
		list.sort(order);
		const hubs = [];
		for (const a of list) {
			if (hubs.length >= cap) break;
			const sameHub = a.w && hubs.some((h) => h.w && h.w.c === a.w.c && Math.hypot(h.w.wx - a.w.wx, h.w.wy - a.w.wy) < HUB_YARDS);
			if (sameHub) continue;
			if (!a.w && hubs.some((h) => !h.w && h.cand.map === a.cand.map)) continue;
			hubs.push(a);
		}
		kept.push(...hubs);
	}
	kept.sort(order);
	return { candidates: kept.map((a) => a.cand), coverage };
}

module.exports = { buildCandidates, factionTag, usableBy, spawnPoints, worldPos, CAP };
