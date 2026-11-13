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
// A use or interact bound to a quest objective (`quest Q.O`, no npc or object
// of its own) stands for the objective's object, or its creature (kill, talk):
// the Rod of Helcular used at the Flame of Azel, in the Foothill Caverns under
// Darrow Hill (#1782).
// A goto leading to a goal with a height takes it (gotoHeights).
// A collect or a level … grind: its sources' nearest spawn (sourceEntities).
// Never: any other goto and explore (a place, not an entity), any other use
// (an item), and `collect … nearest`'s farm spots (a cluster of several
// droppers, no single NPC).

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

// The object or creature a use or interact goal bound to a quest objective is
// done at: { kind, id } or null.
function objectiveEntity(data, goal) {
	if ((goal.t !== 'use' && goal.t !== 'interact') || goal.candidates || goal.x === undefined || goal.y === undefined || goal.map === undefined) return null;
	if (goal.npc !== undefined || goal.object !== undefined || goal.quest === undefined || !Number.isInteger(goal.oi) || goal.oi < 1) return null;
	const q = data.quest(goal.quest);
	const o = q && (q.objectives || [])[goal.oi - 1];
	const kind = o && ({ object: 'object', kill: 'npc', talk: 'npc' })[o.type];
	return kind && o.id !== undefined ? { kind, id: o.id } : null;
}

// What a goal without an NPC or object of its own is done at: a collect's
// sources (fromNpcs; its one source, fromKind npc or object, fromId) and a level … grind
// goal's creature (#1782: the Rod of Helcular from the Foothill Caverns'
// yetis, under Darrow Hill).
function sourceEntities(goal) {
	if (goal.candidates || goal.x === undefined || goal.y === undefined || goal.map === undefined) return [];
	if (goal.t === 'collect') {
		const out = (goal.fromNpcs || []).filter((n) => n.npc !== undefined).map((n) => ({ kind: 'npc', id: n.npc }));
		const kind = goal.fromKind === 'object' || goal.fromKind === 'npc' ? goal.fromKind : null;
		if (kind && goal.fromId !== undefined && !out.some((e) => e.kind === kind && e.id === goal.fromId)) out.push({ kind, id: goal.fromId });
		return out;
	}
	if (goal.t === 'level' && goal.grind !== undefined) return [{ kind: 'npc', id: goal.grind }];
	return [];
}

function entities(data, goal) {
	const e = heightEntity(goal) || objectiveEntity(data, goal);
	return e ? [e] : sourceEntities(goal);
}

// The height at point of the nearest spawn of any of list within HEIGHT_YARDS.
function nearestHeight(data, list, point) {
	if (!list.length) return undefined;
	if (list.length === 1) return spawnHeight(data, list[0].kind, list[0].id, point);
	const p = data.spawnz && worldPoint(data, point);
	if (!p) return undefined;
	let best = null;
	for (const { kind, id } of list) {
		for (const [map, x, y, z] of (data.spawnz[kind] || {})[id] || []) {
			if (map !== p.c) continue;
			const d = Math.hypot(x - p.wx, y - p.wy);
			if (d <= HEIGHT_YARDS && (!best || d < best.d)) best = { d, z };
		}
	}
	return best ? best.z : undefined;
}

// The height data/goal-heights.json gives a goal's point (a record within
// POINT_YARDS), or undefined: the floor players' recordings show such a goal
// done on where no NPC or object says (inside a mine or cave, #1782).
const POINT_YARDS = 5;
function pointHeight(data, goal) {
	if (!Array.isArray(data.goalHeights) || goal.candidates || goal.map === undefined || goal.x === undefined || goal.y === undefined) return undefined;
	const p = worldPoint(data, goal);
	if (!p) return undefined;
	let best = null;
	for (const r of data.goalHeights) {
		const q = worldPoint(data, { map: r.map, x: r.x, y: r.y, f: r.frame === 'era' ? 'e' : 'l' });
		if (!q || q.c !== p.c || typeof r.z !== 'number') continue;
		const d = Math.hypot(q.wx - p.wx, q.wy - p.wy);
		if (d <= POINT_YARDS && (!best || d < best.d)) best = { d, z: r.z };
	}
	return best ? best.z : undefined;
}

// The goal's height, or undefined (entities, else pointHeight).
function goalHeight(data, goal) {
	const z = nearestHeight(data, entities(data, goal), goal);
	return z !== undefined ? z : pointHeight(data, goal);
}

// A spawn spot's height ({ x, y } of the goal's `spots`, on the goal's map
// and frame), or undefined: by the goal's own NPC or object.
function spotHeight(data, goal, spot) {
	return nearestHeight(data, entities(data, goal), { map: goal.map, x: spot.x, y: spot.y, f: goal.f });
}

// A goto without a height that leads to a goal with one (a later goal of its
// own step, or one of the next step) whose point lies within HEIGHT_YARDS of
// its own gets that goal's height, the nearest such goal's: the walk to the
// place ends on the floor the goal is done on (#1786: "Azurelode Mine" at the
// miners, over the hill the mine runs under). steps: a guide's resolved steps.
function gotoHeights(data, steps) {
	steps.forEach((step, i) => {
		const goals = step.goals || [];
		goals.forEach((goto, k) => {
			if (goto.t !== 'goto' || goto.z !== undefined || goto.map === undefined || goto.x === undefined || goto.y === undefined) return;
			const p = worldPoint(data, goto);
			if (!p) return;
			let best = null;
			for (const g of [...goals.slice(k + 1), ...((steps[i + 1] && steps[i + 1].goals) || [])]) {
				if (g.z === undefined || g.map === undefined || g.x === undefined || g.y === undefined) continue;
				const q = worldPoint(data, g);
				if (!q || q.c !== p.c) continue;
				const d = Math.hypot(q.wx - p.wx, q.wy - p.wy);
				if (d <= HEIGHT_YARDS && (!best || d < best.d)) best = { d, z: g.z };
			}
			if (best) goto.z = best.z;
		});
	});
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

module.exports = { HEIGHT_YARDS, HEIGHT_VERBS, heightEntity, worldPoint, spawnHeight, goalHeight, spotHeight, candidateHeight, gotoHeights, heightCounts };
