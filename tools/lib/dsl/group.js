'use strict';
// Group content (docs/GUIDE_FORMAT.md, "Group content"): the compiled
// `group` of a goal, which the guide window shows as "Elite: group advised",
// "Dungeon: Dire Maul" or "Group of 3 advised".
//
// eliteWork(goal, sides, data) — elite work (also the Leveling-guide elite
//   rule in validate.js).
// groupOf(goal, explicit, sides, data) — the goal's compiled `group`.

const SOLO = require('../sim/solo');

// An elite is an npcs.json rank 1-3 (elite, rare elite, boss) hostile to a
// side the goal applies to; a friendly one is a talk credit (Questie encodes
// "listen to X" as a kill).
const ELITE_RANKS = new Set([1, 2, 3]);
const FRIENDLY_TO = { Alliance: ['A', 'AH'], Horde: ['H', 'AH'] };

// Whether an npc of `faction` is hostile to one of `sides`.
function hostileTo(faction, sides) {
	return sides.some((s) => !FRIENDLY_TO[s].includes(faction));
}

function isElite(rank, faction, sides) {
	return ELITE_RANKS.has(Number(rank)) && hostileTo(faction, sides);
}

// A `kill` of an elite, or a `collect` of an item whose every located dropper
// in data is an elite (the compiler's `from` names one source of the same
// data; one normal dropper keeps the item soloable). -> { rank, names } (the
// droppers' names, the likeliest first; `rank` that one's) | null
function eliteWork(goal, sides, data) {
	if (goal.t === 'kill' && goal.npc !== undefined) {
		const n = data.npc(goal.npc);
		return n && isElite(n.rank, n.faction, sides) ? { rank: Number(n.rank), names: [n.name] } : null;
	}
	if (goal.t !== 'collect' || goal.candidates) return null;
	const it = data.item(goal.item);
	const sources = [];
	for (const kind of ['npc', 'object']) {
		for (const [id, chance] of Object.entries((it && it.drops && it.drops[kind]) || {})) sources.push({ kind, id: Number(id), chance: Number(chance) || 0 });
	}
	const located = sources.filter((s) => data.spawns(s.kind, s.id).length);
	const list = (located.length ? located : sources).sort((a, b) => b.chance - a.chance);
	if (!list.length) return null;
	const recs = list.map((s) => (s.kind === 'npc' ? data.npc(s.id) : null));
	if (!recs.every((r) => r && isElite(r.rank, r.faction, sides))) return null;
	return { rank: Number(recs[0].rank), names: [...new Set(recs.map((r) => r.name))] };
}

// Whether an npc or object spawns in the open world (a map of the reference
// data), or an item drops from one that does.
function placed(data, kind, id) {
	if (kind !== 'item') return data.spawns(kind, id).length > 0;
	const drops = (data.item(id) || {}).drops || {};
	return ['npc', 'object'].some((k) => Object.keys(drops[k] || {}).some((src) => data.spawns(k, Number(src)).length > 0));
}

const RUN = new Set(['dungeon', 'raid']);

// The goal's compiled `group`: the author's `group [N]` (explicit: { size? })
// wins; else the dungeon or raid of the goal's quest (the solo filter's
// instance rule, SOLO.instanceQuest) or of the instance map the goal is
// placed on; else elite work. -> { kind: 'group', size? } | { kind:
// 'dungeon' | 'raid', name, map (its Map.csv id) } | { kind: 'elite', rank } | null
function groupOf(goal, explicit, sides, data) {
	if (explicit) return explicit.size !== undefined ? { kind: 'group', size: explicit.size } : { kind: 'group' };
	const inst = data.instances;
	if (inst) {
		const byQuest = goal.quest !== undefined && SOLO.instanceQuest(data.quest(goal.quest), inst.areas, (kind, id) => placed(data, kind, id));
		const run = (byQuest && RUN.has(byQuest.kind) && byQuest) || (goal.map !== undefined && (inst.maps || {})[goal.map]);
		if (run && RUN.has(run.kind)) return run.map ? { kind: run.kind, name: run.name, map: run.map } : { kind: run.kind, name: run.name };
	}
	const elite = eliteWork(goal, sides, data);
	return elite ? { kind: 'elite', rank: elite.rank } : null;
}

module.exports = { eliteWork, groupOf, isElite, hostileTo };
