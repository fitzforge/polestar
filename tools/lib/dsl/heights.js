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
// the same rule, each from its own point, else from the nearest spawn within
// the spot's own radius (a camp's centre, #4352). An NPC met to talk to (not a
// kill) with one spawn with a height on the map lends it to its other points
// within WALK_HEIGHT_YARDS: they are where it walks (#4363). A smart target's candidates
// (`candidates` with an npc: trainers, vendors, innkeepers, and
// Core/ClassTrainers.lua's) get one each, from their own NPC (#180).
// A use or interact bound to a quest objective (`quest Q.O`, no npc or object
// of its own) stands for the objective's object, or its creature (kill, talk):
// the Rod of Helcular used at the Flame of Azel, in the Foothill Caverns under
// Darrow Hill (#1782); for an item objective, the objects that item comes out
// of: the Filled Etched Phial used on the Ancient Brazier whose Cloven Hoof is
// the objective, deep in Splithoof Hold (#2126).
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

// The objects or creature a use or interact goal bound to a quest objective
// is done at: [{ kind, id }], [] for none. An item objective's are the objects
// the item comes out of (items.json `drops.object`); the goal gets a height
// only from one of their spawns within HEIGHT_YARDS of its point.
function objectiveEntities(data, goal) {
	if ((goal.t !== 'use' && goal.t !== 'interact') || goal.candidates || goal.x === undefined || goal.y === undefined || goal.map === undefined) return [];
	if (goal.npc !== undefined || goal.object !== undefined || goal.quest === undefined || !Number.isInteger(goal.oi) || goal.oi < 1) return [];
	const q = data.quest(goal.quest);
	const o = q && (q.objectives || [])[goal.oi - 1];
	if (!o || o.id === undefined || o.id === null) return [];
	if (o.type === 'item') {
		const item = data.item(o.id);
		const from = (item && item.drops && item.drops.object) || {};
		return Object.keys(from)
			.map(Number)
			.filter((id) => Number.isInteger(id) && id > 0)
			.sort((a, b) => a - b)
			.map((id) => ({ kind: 'object', id }));
	}
	const kind = ({ object: 'object', kill: 'npc', talk: 'npc' })[o.type];
	return kind ? [{ kind, id: o.id }] : [];
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
	const e = heightEntity(goal);
	if (e) return [e];
	const done = objectiveEntities(data, goal);
	return done.length ? done : sourceEntities(goal);
}

// The height at point of the nearest spawn of any of list within HEIGHT_YARDS.
function nearestHeight(data, list, point) {
	if (list.length === 1) return spawnHeight(data, list[0].kind, list[0].id, point);
	return nearestWithin(data, list, point, HEIGHT_YARDS);
}

// The height at point of the nearest spawn of any of list within `yards`.
function nearestWithin(data, list, point, yards) {
	if (!list.length) return undefined;
	const p = data.spawnz && worldPoint(data, point);
	if (!p) return undefined;
	let best = null;
	for (const { kind, id } of list) {
		for (const [map, x, y, z] of (data.spawnz[kind] || {})[id] || []) {
			if (map !== p.c) continue;
			const d = Math.hypot(x - p.wx, y - p.wy);
			if (d <= yards && (!best || d < best.d)) best = { d, z };
		}
	}
	return best ? best.z : undefined;
}

// Yards from its one spawn with a height within which the points of an NPC
// met to talk to (any height verb but kill) take that spawn's height: such an
// NPC is one creature, and the data's other points for it are where it walks
// (#4363: Harbinger Balthazad's 18 points round the Undercity's Trade
// Quarter, up to 84 yd from the one spawn with a height).
const WALK_HEIGHT_YARDS = 100;

// The height at point of the NPC a goal is met at (not a kill: a creature to
// kill is many), when that NPC has one spawn with a height on the point's
// instance map, within WALK_HEIGHT_YARDS; else undefined.
function walkHeight(data, goal, point) {
	const e = heightEntity(goal);
	if (!e || e.kind !== 'npc' || goal.t === 'kill' || !data.spawnz) return undefined;
	const p = worldPoint(data, point);
	if (!p) return undefined;
	const onMap = ((data.spawnz.npc || {})[e.id] || []).filter((s) => s[0] === p.c);
	if (onMap.length !== 1) return undefined;
	const [, x, y, z] = onMap[0];
	return Math.hypot(x - p.wx, y - p.wy) <= WALK_HEIGHT_YARDS ? z : undefined;
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

// The goal's height, or undefined (entities, else pointHeight, else the one
// creature's walk: a record from players' recordings at the point says more
// than a height lent from a spawn up to 100 yd off, which can fall between
// two floors there, as at Harbinger Balthazad's point in the Trade Quarter).
function goalHeight(data, goal) {
	const z = nearestHeight(data, entities(data, goal), goal);
	if (z !== undefined) return z;
	const p = pointHeight(data, goal);
	return p !== undefined ? p : walkHeight(data, goal, goal);
}

// A spawn spot's height ({ x, y, r } of the goal's `spots`, on the goal's map
// and frame), or undefined: the nearest spawn of the goal's entities within
// HEIGHT_YARDS, else within the spot's own radius (a camp's centre between
// its spawns: #4352, the Incendosaurs' camps in the tunnels under Searing
// Gorge, 19 to 26 yd from the nearest), else the one creature's walk.
function spotHeight(data, goal, spot) {
	const list = entities(data, goal);
	if (!list.length) return undefined;
	const point = { map: goal.map, x: spot.x, y: spot.y, f: goal.f };
	let z = nearestHeight(data, list, point);
	if (z === undefined && typeof spot.r === 'number' && spot.r > HEIGHT_YARDS) z = nearestWithin(data, list, point, spot.r);
	return z !== undefined ? z : walkHeight(data, goal, point);
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

module.exports = { HEIGHT_YARDS, HEIGHT_VERBS, WALK_HEIGHT_YARDS, heightEntity, worldPoint, spawnHeight, goalHeight, spotHeight, candidateHeight, gotoHeights, heightCounts };
