'use strict';
// Goal heights (docs/GUIDE_FORMAT.md, "Heights"): a goal whose point stands
// for an NPC or object gets `z`, the height of that entity's spawn, so the
// in-game walking engine ends on its floor (an Undercity quarter, not the
// street above it). The heights are CMaNGOS classic-db's spawn positions
// (data/forever/spawnz.json, `data build`), used as facts. A point gets one
// only from a spawn of its own NPC or object on the instance map of its world
// point and within HEIGHT_YARDS of it; never a guess (a Forever-only NPC, a
// moved spawn: no z).
//
// Which goals: those whose point resolve.js takes from the NPC or object the
// goal names or picks (its spawn, or the author's @x,y at it):
//   accept, turnin   the quest giver or ender (npc or object)
//   talk, kill       the npc (a kill's point: the spawn nearest the previous
//                    goal, else the centre of its spawns, which is seldom
//                    within HEIGHT_YARDS of one)
//   interact         the object
//   buy, train, vendor, sethome, getfp, learn   the named npc
// Their spawn spots (`spots`, the other places the entity spawns) get one by
// the same rule, each from its own point. A smart target's candidates
// (`candidates` with an npc: trainers, vendors, innkeepers, and
// Core/ClassTrainers.lua's) get one each, from their own NPC (#180).
// Never: goto and explore (a place, not an entity), collect (a farming spot
// among the item's sources), use (an item), and `collect … nearest`'s farm
// spots (a cluster of several droppers, no single NPC).

const HEIGHT_YARDS = 15;
const HEIGHT_VERBS = new Set(['accept', 'turnin', 'talk', 'kill', 'interact', 'buy', 'train', 'vendor', 'sethome', 'getfp', 'learn']);

// The NPC or object a goal's point stands for: { kind, id } or null.
function heightEntity(goal) {
	if (!HEIGHT_VERBS.has(goal.t) || goal.candidates || goal.x === undefined || goal.y === undefined || goal.map === undefined) return null;
	if (goal.npc !== undefined) return { kind: 'npc', id: goal.npc };
	if (goal.object !== undefined) return { kind: 'object', id: goal.object };
	return null;
}

// A goal's world point: { c (instance map), wx (north), wy (west) } in its
// frame (`f` "e": Era bounds; else the live frame, Era's when Forever has none),
// or null without bounds (docs/ARCHITECTURE.md, "Map frames").
function worldPoint(data, goal) {
	const frames = data.mapFrames || {};
	const fr = goal.f === 'e' ? data.eraFrame(goal.map) : (frames.forever || {})[goal.map] || data.eraFrame(goal.map);
	if (!fr) return null;
	return { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * goal.y) / 100, wy: fr.left + ((fr.right - fr.left) * goal.x) / 100 };
}

// The height at `point` ({ map, x, y, f }) of an entity, or undefined: the z
// of its nearest spawn on the point's instance map, when that spawn is within
// HEIGHT_YARDS.
function spawnHeight(data, kind, id, point) {
	if (!data.spawnz) return undefined;
	const list = (data.spawnz[kind] || {})[id];
	if (!Array.isArray(list)) return undefined;
	const p = worldPoint(data, point);
	if (!p) return undefined;
	let best = null;
	for (const [map, x, y, z] of list) {
		if (map !== p.c) continue;
		const d = Math.hypot(x - p.wx, y - p.wy);
		if (d <= HEIGHT_YARDS && (!best || d < best.d)) best = { d, z };
	}
	return best ? best.z : undefined;
}

// The goal's height, or undefined (heightEntity).
function goalHeight(data, goal) {
	const e = heightEntity(goal);
	return e ? spawnHeight(data, e.kind, e.id, goal) : undefined;
}

// A spawn spot's height ({ x, y } of the goal's `spots`, on the goal's map
// and frame), or undefined: by the goal's own NPC or object.
function spotHeight(data, goal, spot) {
	const e = heightEntity(goal);
	return e ? spawnHeight(data, e.kind, e.id, { map: goal.map, x: spot.x, y: spot.y, f: goal.f }) : undefined;
}

// A smart target's candidate's height ({ npc, map, x, y, f }), or undefined:
// by its own NPC.
function candidateHeight(data, cand) {
	if (cand.npc === undefined || cand.map === undefined || cand.x === undefined || cand.y === undefined) return undefined;
	return spawnHeight(data, 'npc', cand.npc, cand);
}

// -> { eligible, withZ, candidates, candidatesWithZ, spots, spotsWithZ }:
// goals whose point stands for an NPC or object, their spawn spots, smart
// targets' NPC candidates, and how many of each got a height.
function heightCounts(guides) {
	const n = { eligible: 0, withZ: 0, candidates: 0, candidatesWithZ: 0, spots: 0, spotsWithZ: 0 };
	for (const g of guides) {
		for (const step of g.steps || []) {
			for (const goal of step.goals || []) {
				for (const c of goal.candidates || []) {
					if (c.npc === undefined) continue;
					n.candidates++;
					if (c.z !== undefined) n.candidatesWithZ++;
				}
				if (!heightEntity(goal)) continue;
				n.eligible++;
				if (goal.z !== undefined) n.withZ++;
				for (const s of goal.spots || []) {
					n.spots++;
					if (s.z !== undefined) n.spotsWithZ++;
				}
			}
		}
	}
	return n;
}

module.exports = { HEIGHT_YARDS, HEIGHT_VERBS, heightEntity, worldPoint, spawnHeight, goalHeight, spotHeight, candidateHeight, heightCounts };
