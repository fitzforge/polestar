'use strict';
// Group content (docs/GUIDE_FORMAT.md, "Group content"): the compiled
// `group` of a goal, which the guide window shows as "Elite: group advised",
// "Dungeon: Dire Maul" or "Group of 3 advised".
//
// eliteWork(goal, sides, data) — elite work (also the Leveling-guide elite
//   rule in validate.js).
// eliteNear(goal, sides, data) — an object's work among hostile elites.
// groupOf(goal, explicit, sides, data) — the goal's compiled `group`.
// dungeonNamed(data, name) — the dungeon a `when dungeon` names.

const SOLO = require('../sim/solo');
const { worldPos } = require('./candidates');

// An elite is an npcs.json rank 1-3 (elite, rare elite, boss) hostile to a
// side the goal applies to; a friendly one is a talk credit (Questie encodes
// "listen to X" as a kill).
const ELITE_RANKS = new Set([1, 2, 3]);
const RARE_RANK = 4;
const FRIENDLY_TO = { Alliance: ['A', 'AH'], Horde: ['H', 'AH'] };

// Whether an npc of `faction` is hostile to one of `sides`.
function hostileTo(faction, sides) {
	return sides.some((s) => !FRIENDLY_TO[s].includes(faction));
}

function isElite(rank, faction, sides) {
	return ELITE_RANKS.has(Number(rank)) && hostileTo(faction, sides);
}

// A rare (rank 4): one hostile mob standing among a camp's common ones. Not
// group content (it is no elite), but where a collect would lead to it, see
// the resolver's rareLeads.
function isRare(rank, faction, sides) {
	return Number(rank) === RARE_RANK && hostileTo(faction, sides);
}

// A `kill` of an elite, or a `collect` of an item whose every located dropper
// in data is an elite (the compiler's `from` names one source of the same
// data; one normal dropper keeps the item soloable). -> { rank, names, lvl }
// (the droppers' names, the likeliest first; `rank` that one's; `lvl` their
// highest level, 0 when unknown) | null
function topLevel(n) {
	const l = Number(n.levelMax) > 0 ? Number(n.levelMax) : Number(n.level);
	return l > 0 ? l : 0;
}

function eliteWork(goal, sides, data) {
	if (goal.t === 'kill' && goal.npc !== undefined) {
		const n = data.npc(goal.npc);
		return n && isElite(n.rank, n.faction, sides) ? { rank: Number(n.rank), names: [n.name], lvl: topLevel(n) } : null;
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
	return { rank: Number(recs[0].rank), names: [...new Set(recs.map((r) => r.name))], lvl: Math.max(...recs.map(topLevel)) };
}

// Whether an npc or object spawns in the open world (a map of the reference
// data), or an item drops from one that does.
function placed(data, kind, id) {
	if (kind !== 'item') return data.spawns(kind, id).length > 0;
	const drops = (data.item(id) || {}).drops || {};
	return ['npc', 'object'].some((k) => Object.keys(drops[k] || {}).some((src) => data.spawns(k, Number(src)).length > 0));
}

// Elites at an object's work (#1778: Berard's Bookshelf in Pyrewood Village,
// beside Apothecary Berard, 16 elite, among the village's elite Watchers,
// Sentries and Elders), as the Codex build marks Lookup's quest objectives
// (forge-data codex/elites.rs): an `interact`, or a `collect` of an item only
// objects give (one an npc drops is eliteWork's), whose object's spawn points
// (every one, those the cap left out too) have, at least half of them, an
// elite (rank 1-3) hostile to a side the goal applies to within NEAR yards.
// Not one of no real level, nor one of no side that gives or takes a quest
// or has a role (a friendly NPC whose side the data lacks: Keeper Remulos).
// -> { rank, lvl } (the highest among them; lvl 0 when unknown) | null
const NEAR = 40;
const MAX_LEVEL = 63;
const eliteGrids = new WeakMap(); // data -> Map("c,gx,gy" -> [{ wx, wy, rank, lvl, faction }])
function eliteGrid(data) {
	let grid = eliteGrids.get(data);
	if (grid) return grid;
	grid = new Map();
	const givers = new Set();
	for (const q of Object.values(data.quests || {})) {
		for (const end of ['start', 'end']) for (const n of (q && q[end] && q[end].npc) || []) givers.add(Number(n));
	}
	for (const n of Object.values(data.npcs || {})) {
		if (!n || !ELITE_RANKS.has(Number(n.rank))) continue;
		const lvl = topLevel(n);
		if (lvl > MAX_LEVEL || n.faction === 'AH') continue;
		if (!n.faction && (givers.has(Number(n.id)) || (n.roles && n.roles.length))) continue;
		for (const s of data.spawns('npc', n.id)) {
			for (const p of [...s.pts, ...s.more]) {
				const w = worldPos(data, s.map, p[0], p[1], s.f);
				if (!w) continue;
				const key = `${w.c},${Math.floor(w.wx / NEAR)},${Math.floor(w.wy / NEAR)}`;
				if (!grid.has(key)) grid.set(key, []);
				grid.get(key).push({ wx: w.wx, wy: w.wy, rank: Number(n.rank), lvl, faction: n.faction });
			}
		}
	}
	eliteGrids.set(data, grid);
	return grid;
}

function eliteNear(goal, sides, data) {
	if (goal.quest === undefined) return null;
	let sources;
	if (goal.t === 'interact' && goal.object !== undefined) sources = [Number(goal.object)];
	else if (goal.t === 'collect' && goal.item !== undefined && !goal.candidates) {
		const drops = (data.item(goal.item) || {}).drops || {};
		if (Object.keys(drops.npc || {}).length) return null;
		sources = Object.keys(drops.object || {}).map(Number);
	} else return null;
	const pts = [];
	for (const id of sources) {
		for (const s of data.spawns('object', id)) for (const p of [...s.pts, ...s.more]) pts.push(worldPos(data, s.map, p[0], p[1], s.f));
	}
	const placed = pts.filter(Boolean);
	if (!placed.length) return null;
	const grid = eliteGrid(data);
	let hits = 0;
	let rank = 0;
	let lvl = 0;
	for (const w of placed) {
		let hit = false;
		const gx = Math.floor(w.wx / NEAR);
		const gy = Math.floor(w.wy / NEAR);
		for (let dx = -1; dx <= 1; dx++) {
			for (let dy = -1; dy <= 1; dy++) {
				for (const e of grid.get(`${w.c},${gx + dx},${gy + dy}`) || []) {
					if (Math.hypot(e.wx - w.wx, e.wy - w.wy) > NEAR || !hostileTo(e.faction, sides)) continue;
					hit = true;
					rank = Math.max(rank, e.rank);
					lvl = Math.max(lvl, e.lvl);
				}
			}
		}
		if (hit) hits++;
	}
	return hits >= Math.ceil(placed.length / 2) ? { rank, lvl } : null;
}

const RUN = new Set(['dungeon', 'raid']);

// The goal's compiled `group`: the author's `group [N]` (explicit: { size? })
// wins; else the dungeon or raid of the goal's quest (the solo filter's
// instance rule, SOLO.instanceQuest) or of the instance map the goal is
// placed on; else elite work; else an object's work among elites (`near`:
// the guide menu's "Group" chip leaves it out). -> { kind: 'group', size? } |
// { kind: 'dungeon' | 'raid', name, map (its Map.csv id) } | { kind: 'elite',
// rank, lvl?, near? } | null
function groupOf(goal, explicit, sides, data) {
	if (explicit) return explicit.size !== undefined ? { kind: 'group', size: explicit.size } : { kind: 'group' };
	const inst = data.instances;
	if (inst) {
		const byQuest = goal.quest !== undefined && SOLO.instanceQuest(data.quest(goal.quest), inst.areas, (kind, id) => placed(data, kind, id));
		const run = (byQuest && RUN.has(byQuest.kind) && byQuest) || (goal.map !== undefined && (inst.maps || {})[goal.map]);
		if (run && RUN.has(run.kind)) return run.map ? { kind: run.kind, name: run.name, map: run.map } : { kind: run.kind, name: run.name };
	}
	const elite = eliteWork(goal, sides, data);
	if (elite) return elite.lvl > 0 ? { kind: 'elite', rank: elite.rank, lvl: elite.lvl } : { kind: 'elite', rank: elite.rank };
	const near = eliteNear(goal, sides, data);
	if (!near) return null;
	return near.lvl > 0 ? { kind: 'elite', rank: near.rank, lvl: near.lvl, near: true } : { kind: 'elite', rank: near.rank, near: true };
}

// The dungeon a name stands for, from the same instance tables: its Map.csv
// name ("Ragefire Chasm"), else an area of that name on one dungeon's map
// (AreaTable: "The Deadmines" for map 36, "Deadmines" in Map.csv), case
// aside. Raids and battlegrounds are no dungeon. -> { name, map } | null
function dungeonNamed(data, name) {
	const inst = data.instances;
	if (!inst) return null;
	const key = String(name).trim().toLowerCase();
	const runs = [...Object.values(inst.areas || {}), ...Object.values(inst.maps || {})].filter((r) => r && r.kind === 'dungeon' && r.map);
	const byName = runs.find((r) => String(r.name).toLowerCase() === key);
	if (byName) return { name: byName.name, map: byName.map };
	const maps = new Set();
	for (const a of (data.areas && data.areas.byName.get(key)) || []) {
		const r = (inst.areas || {})[a.id];
		if (r && r.kind === 'dungeon' && r.map) maps.add(r.map);
	}
	if (maps.size !== 1) return null;
	const map = [...maps][0];
	return { name: runs.find((r) => r.map === map).name, map };
}

module.exports = { eliteWork, eliteNear, groupOf, isElite, isRare, hostileTo, dungeonNamed };
