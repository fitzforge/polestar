'use strict';
// Goal heights (docs/GUIDE_FORMAT.md, "Heights"): a goal whose point stands
// for an NPC or object gets `z`, the height of that entity's spawn, so the
// in-game walking engine ends on its floor (an Undercity quarter, not the
// street above it). The heights are CMaNGOS classic-db's spawn positions
// (data/forever/spawnz.json, `data build`), used as facts. A goal gets one
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
// Never: goto and explore (a place, not an entity), collect (a farming spot
// among the item's sources), use (an item). Smart targets (`candidates`: the
// engine picks the NPC at runtime) get the picked NPC's height through
// entityHeight, applied per candidate by candidates.js.

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

// An entity's height at a point, or undefined: the z of the nearest spawn of
// (kind, id) on the point's instance map, when that spawn is within
// HEIGHT_YARDS. `point` is a goal point ({ map, x, y, f }).
function entityHeight(data, kind, id, point) {
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

// The goal's height, or undefined: the z of the nearest spawn of its entity on
// its world point's map, when that spawn is within HEIGHT_YARDS.
function goalHeight(data, goal) {
	const e = heightEntity(goal);
	if (!e) return undefined;
	return entityHeight(data, e.kind, e.id, goal);
}

// -> { eligible, withZ }: goals whose point stands for an NPC or object, and
// how many of them got a height.
function heightCounts(guides) {
	let eligible = 0;
	let withZ = 0;
	for (const g of guides) {
		for (const step of g.steps || []) {
			for (const goal of step.goals || []) {
				if (!heightEntity(goal)) continue;
				eligible++;
				if (goal.z !== undefined) withZ++;
			}
		}
	}
	return { eligible, withZ };
}

module.exports = { HEIGHT_YARDS, HEIGHT_VERBS, heightEntity, worldPoint, entityHeight, goalHeight, heightCounts };
