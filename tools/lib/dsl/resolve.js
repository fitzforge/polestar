'use strict';
// Resolver: turns a parsed guide into the compiled structure of
// docs/ARCHITECTURE.md ("Guide data"), filling titles, names, entities,
// coordinates, objective indexes and counts from reference data
// (docs/GUIDE_FORMAT.md, "What the compiler fills in").
//
// resolveGuide(ast, data, diag, { pack, author }) -> guide (`author`: the pack's, for a guide without one)
// Compiled goals and steps carry non-enumerable `_line` (source line) for the
// validator; everything enumerable is part of the compiled schema.

const SPAWN_CHECK_YARDS = 50;
// The fix hint for an id that is not in the reference data.
const FIND_ID_HINT = 'find the id with `polestar find <name>`, or give its name in quotes';

const { buildCandidates } = require('./candidates');
const { farmSpots } = require('./farmspots');
const { applicable, raceSides, characterKeys, whoLabel } = require('./conditions');
const { objectiveLabel } = require('./data');
const { checkLocation } = require('./places');
const { blockingPrereqs, closedByOf } = require('../data/prereqs');
const { clusterPoints, scaleOf } = require('../questdb/cluster');
const { groupOf, isElite, isRare, hostileTo, dungeonNamed } = require('./group');
const { escortOf } = require('./escort');
const { goalHeight, spotHeight } = require('./heights');
const { goalArea, goalNode, goalInnkeeper, goalFlightMaster } = require('./places');
const { areaNamed } = require('../data/areas');
const { levelRange } = require('./when');

// A collect's sources are named only for an item that few creatures or
// objects drop (at 2% or more, with spawns); past this it drops everywhere.
const MAX_NAMED_SOURCES = 8;

// `fromNpcs` on a collect: the mobs its point and spots belong to, for the
// target button, which cycles at most this many names.
const MAX_SOURCE_NPCS = 5;

// A collect's droppers this many levels or more above its quest (by their
// lowest level) do not set the likely-dropper bar where they would crowd out
// the droppers nearer the quest's level (levelSplit): a level 7 player farms
// the level 5 Timberlings beside Denalan, not the level 10 Elder Timberlings
// 1,400 yards away (#327).
const ABOVE_QUEST_LEVELS = 3;

// Standard rank caps and the skill each rank can first be trained at (Classic).
const RANK_CAPS = [75, 150, 225, 300];
const RANK_MIN_SKILL = [0, 50, 125, 225];
const RANK_NAMES = ['Apprentice', 'Journeyman', 'Expert', 'Artisan'];

function round2(n) {
	const r = Math.round(n * 100) / 100;
	return Object.is(r, -0) ? 0 : r;
}

function hidden(obj, key, value) {
	Object.defineProperty(obj, key, { value, enumerable: false, writable: true, configurable: true });
	return obj;
}

function setIf(obj, key, value) {
	if (value !== undefined && value !== null && value !== '') obj[key] = value;
}

function nameOf(data, kind, id) {
	const e = kind === 'npc' ? data.npc(id) : kind === 'object' ? data.object(id) : kind === 'item' ? data.item(id) : null;
	return e && e.name ? String(e.name) : null;
}

// Distance between two points on one map: yards when the map's size is
// known, else map percent.
function distance(data, map, ax, ay, bx, by) {
	const size = data.mapSize(map);
	const dx = (ax - bx) * (size ? size.w / 100 : 1);
	const dy = (ay - by) * (size ? size.h / 100 : 1);
	return Math.sqrt(dx * dx + dy * dy);
}

// Pick an entity and a point for it. candidates: [{ kind, id }] in priority
// order (e.g. by drop chance). -> { cand, map, x, y, f, sources, elites } |
// { cand } (no usable spawns) | null (no candidates). `sources`: the
// candidates the point was chosen among on its map (the likely droppers
// there), `elites`: the elite droppers there passed over for them (see onMap).
// opts: { usedMaps, sides, rares, qlvl } (`sides`: the factions the goal
// applies to, for passing over elite droppers; `qlvl`: a collect's quest
// level, for passing over droppers far above it).
//
// Maps are tried in this order: the current zone, then maps the guide has
// already used (most recent first). On the first map where any candidate
// spawns, the spawn nearest the previous goal wins when that goal is on the
// same map; otherwise the centroid of the highest-priority candidate there.
// Only when no candidate spawns on any of those maps does the first candidate
// with spawns fall back to its largest map.
function pickSpawn(data, candidates, zoneMap, prev, opts = {}) {
	if (!candidates.length) return null;
	const all = candidates.map((cand) => ({ cand, spawns: data.spawns(cand.kind, cand.id) }));
	const centroid = (cand, s) => {
		let sx = 0;
		let sy = 0;
		for (const p of s.pts) {
			sx += p[0];
			sy += p[1];
		}
		return point(cand, s.map, sx / s.pts.length, sy / s.pts.length, s.f);
	};
	const maps = [];
	if (zoneMap != null) maps.push(zoneMap);
	for (const m of opts.usedMaps || []) if (!maps.includes(m)) maps.push(m);
	for (const m of maps) {
		const { on, elites } = onMap(data, all, m, opts.sides, opts.rares, opts.qlvl);
		if (!on.length) continue;
		const found = { sources: on.map((o) => o.cand), elites: elites.map((o) => o.cand) };
		if (prev && prev.map === m) {
			let best = null;
			for (const { cand, s } of on) {
				for (const p of s.pts) {
					const d = distance(data, m, p[0], p[1], prev.x, prev.y);
					if (!best || d < best.d) best = { d, cand, x: p[0], y: p[1], f: s.f };
				}
			}
			return { ...point(best.cand, m, best.x, best.y, best.f), ...found };
		}
		return { ...centroid(on[0].cand, on[0].s), ...found };
	}
	for (const { cand, spawns } of all) {
		if (!spawns.length) continue;
		const s = spawns.reduce((a, b) => (b.pts.length > a.pts.length ? b : a));
		return { ...centroid(cand, s), sources: [cand] };
	}
	return { cand: candidates[0] };
}

// The candidates ([{ cand, spawns }]) that spawn on `map`, with their spawns
// there. -> { on: [{ cand, s }], elites: [{ cand, s }] }
//
// With `sides` (the factions the goal applies to): where elites (group.js
// isElite) drop it beside normal sources (a non-elite npc hostile to a side,
// or an object), each at 1% or more (any chance when nothing here drops it
// at 1%), only the normal ones count, at any chance the elites have: a
// player farms the normal mobs, not the elite camp beside them. The elites
// passed over are `elites` (spawnSpots keeps the arrow out of their camps).
// An item only elites drop here keeps them. With `rares` (see rareLeads) a
// rare (isRare) is passed over the same way. With `qlvl` (a collect's quest
// level), droppers ABOVE_QUEST_LEVELS or more above it are passed over where
// they would crowd out the droppers nearer its level (levelSplit).
//
// Sources with a drop chance: only the likely ones count (at least half the
// best chance here; sub-1% drops only when nothing better drops here).
function onMap(data, all, map, sides, rares = false, qlvl) {
	let on = [];
	let elites = [];
	for (const { cand, spawns } of all) {
		const s = spawns.find((sp) => sp.map === map);
		if (s) on.push({ cand, s });
	}
	const chanceOf = (o) => o.cand.chance || 0;
	const split = sides ? eliteSplit(data, on.map((o) => o.cand), sides, rares) : null;
	if (split) {
		elites = on.filter((o) => split.elites.includes(o.cand));
		on = on.filter((o) => split.normal.includes(o.cand));
	}
	const level = levelSplit(data, on.map((o) => o.cand), qlvl);
	if (level) on = on.filter((o) => level.near.includes(o.cand));
	if (on.some((o) => typeof o.cand.chance === 'number')) {
		const best = Math.max(...on.map(chanceOf));
		const likely = on.filter((o) => chanceOf(o) >= best / 2 && (chanceOf(o) >= 1 || best < 1));
		if (likely.length) on = likely;
	}
	return { on, elites };
}

// The NPC sources a goal's point and spawn areas belong to (pickSpawn's
// `sources`, onMap's likely droppers on that map), `first` (the source the
// point itself belongs to, when it is one of them) leading: the mobs the
// arrow leads to. The target button names them, which the item's own droppers
// cannot give it, as those rank over the whole world: the best droppers of an
// item many creatures drop are usually in other zones (Small Spider Leg's are
// in Elwynn Forest, Loch Modan and Silverpine, not the Teldrassil spiders a
// Teldrassil goal points at). Objects are left out: a macro can only target a
// creature.
// -> [{ npc, npcName }] | undefined
function sourceNpcs(data, first, sources) {
	const list = sources || [];
	const out = [];
	const seen = new Set();
	for (const s of list.includes(first) ? [first, ...list] : list) {
		if (out.length >= MAX_SOURCE_NPCS) break;
		if (!s || s.kind !== 'npc' || seen.has(s.id)) continue;
		seen.add(s.id);
		const rec = data.npc(s.id);
		if (rec && rec.name) out.push({ npc: s.id, npcName: String(rec.name) });
	}
	return out.length ? out : undefined;
}

// The sources a hand-placed point stands among: those with a spawn within
// `near` yards of it (handSpots' own test for a point the data knows),
// nearest spawn first. The point is the author's, so the creature it belongs
// to is the nearest one, not the best dropper pickSpawn would have chosen.
// -> [{ kind, id, chance? }]
function pointSources(data, sources, map, f, x, y, near) {
	const out = [];
	for (const src of sources) {
		let d = Infinity;
		for (const p of spawnPointsOf(data, [src], map, f)) d = Math.min(d, distance(data, map, p[0], p[1], x, y));
		if (d <= near) out.push({ src, d });
	}
	out.sort((a, b) => a.d - b.d);
	return out.map((o) => o.src);
}

// Sources ([{ kind, id, chance? }]) that elites (group.js isElite, and rares
// with `rares`) and normal sources (a non-elite npc hostile to one of
// `sides`, or an object) both drop at 1% or more (any chance when none drops
// it at 1%, or none has a chance).
// -> { normal, elites } | null (not both)
function eliteSplit(data, cands, sides, rares = false) {
	const chances = cands.some((c) => typeof c.chance === 'number');
	const best = Math.max(0, ...cands.map((c) => c.chance || 0));
	const real = cands.filter((c) => !chances || (c.chance || 0) >= 1 || best < 1);
	const elites = real.filter((c) => eliteSource(data, c, sides, rares));
	const normal = real.filter((c) => normalSource(data, c, sides, rares));
	return elites.length && normal.length ? { normal, elites } : null;
}

// Sources ([{ kind, id, chance? }], by chance) whose likely ones (at least
// half the best chance; sub-1% drops only when nothing drops it at 1%) leave
// out droppers near a quest's level `qlvl` only because an npc whose lowest
// level is ABOVE_QUEST_LEVELS or more above it drops it at a higher chance:
// `near`, the likely ones among the droppers near the quest's level (their
// own best chance sets the bar), `above`, those far above it.
// -> { near, above } | null (no quest level, no chances, nothing near the
// quest's level drops it at 1% while something does, or none crowded out)
function levelSplit(data, cands, qlvl) {
	if (!(qlvl > 0) || !cands.some((c) => typeof c.chance === 'number')) return null;
	const chanceOf = (c) => c.chance || 0;
	const likely = (list) => {
		const best = Math.max(0, ...list.map(chanceOf));
		return list.filter((c) => chanceOf(c) >= best / 2 && (chanceOf(c) >= 1 || best < 1));
	};
	const above = cands.filter((c) => {
		const n = c.kind === 'npc' ? data.npc(c.id) : null;
		return !!n && Number(n.level) >= qlvl + ABOVE_QUEST_LEVELS;
	});
	const rest = cands.filter((c) => !above.includes(c));
	if (!above.length || !rest.length) return null;
	if (Math.max(...rest.map(chanceOf)) < 1 && Math.max(...cands.map(chanceOf)) >= 1) return null;
	const all = likely(cands);
	const near = likely(rest);
	return near.some((c) => !all.includes(c)) ? { near, above } : null;
}

// Whether a rare drops the item at the highest chance while normal sources
// drop it at 50% or more (the `fromAlso` bar): the goal would read "Kill
// <rare> or <normal>", and the arrow would lead to the rare's spawns, which
// are the camps of other mobs (Ribchaser stands among the Redridge Mongrels,
// who drop nothing). Not for an item that drops all over the world.
function rareLeads(data, cands, sides) {
	const top = cands.reduce((a, b) => (b.chance > a.chance ? b : a), cands[0] || { chance: 0 });
	const n = top.kind === 'npc' ? data.npc(top.id) : null;
	if (!n || !isRare(n.rank, n.faction, sides)) return false;
	return cands.some((c) => c.chance >= 50 && normalSource(data, c, sides, true));
}

function eliteSource(data, cand, sides, rares) {
	const n = cand.kind === 'npc' ? data.npc(cand.id) : null;
	return !!(n && (isElite(n.rank, n.faction, sides) || (rares && isRare(n.rank, n.faction, sides))));
}

function normalSource(data, cand, sides, rares) {
	if (cand.kind !== 'npc') return true;
	const n = data.npc(cand.id);
	return !!(n && hostileTo(n.faction, sides) && !isElite(n.rank, n.faction, sides) && !(rares && isRare(n.rank, n.faction, sides)));
}

function point(cand, map, x, y, f) {
	return { cand, map, x: round2(x), y: round2(y), f: f === 'e' ? 'e' : undefined };
}

// Spawn areas of a goal whose target is an npc or object (docs/GUIDE_FORMAT.md,
// "Spawn areas"): the spawns of its sources on the goal's map and in its frame,
// clustered with the quest database's clusterPoints. Every spawn lies in a
// spot: the ones the arrow picks by itself come first, the rest follow as
// alternatives (`alt = true`), which the world map marks and the arrow button
// reaches, so a player who finds no target where the arrow led can try every
// other place it spawns. Fewer than two spawns there: none (a single spawn
// stays a point).
//
// Places: a target with at most SPOT_CAP spawns is found at one of a few
// places (a named NPC or a quest object that appears at one of them, or the
// handful of mobs the objective needs), so every place is a spot the arrow
// may pick: spawns within SPOT_CLUSTER_YARDS of each other are one place, at
// least SPOT_MIN_RADIUS wide. Places that reach further than SPREAD_YARDS are
// searched (`spread`, a walk from the goal's point); closer ones are camps,
// nearest to the goal's point first.
//
// Otherwise the cluster radius is the quest database's 70 yd, widened for
// targets that spawn far apart to twice the median spacing between
// neighbouring spawns (at most SPOT_MAX_CLUSTER_YARDS).
//
// Camps: 90% of the spawns within SPREAD_YARDS of their centre. The arrow
// picks among the clusters of two or more spawns (all clusters when none has
// two), nearest to the goal's point first, at most SPOT_CAP; lone spawns and
// clusters past the cap are alternatives.
//
// Area objectives (`spread`): the spawns reach further. Every cluster counts,
// lone spawns too, each at least as wide as the spacing between spawns
// (SPREAD_MIN_RADIUS..SPREAD_MAX_MIN_RADIUS); beyond SPREAD_CAP the searched
// ones are spread evenly over the area (farthest-point picks, from the cluster
// nearest the goal's point), ordered as a walk from the goal's point (each
// next spot the nearest one not yet in the walk); the others are alternatives.
//
// Alternatives come nearest to the goal's point first.
//
// Strays: a target with more than SPOT_CAP spawns whose spawns, linked
// wherever two lie within STRAY_YARDS of each other, mostly (STRAY_SHARE)
// form one area: a group of at most STRAY_MAX spawns apart from the rest is a
// stray (a mob or two on their own, hundreds of yards from the camps). The
// arrow never picks a place of strays while it has another place, and a goal
// point there (the spawn nearest the previous goal) moves to the nearest other
// place (`at`).
//
// Elite camps: `elites` are elite droppers passed over for the normal sources
// (onMap). A place of the sources with more of their spawns than its own
// within its radius (at least SPOT_CLUSTER_YARDS) is in their camp: the
// arrow never picks it while it has another place, and a goal point there
// moves to the nearest other place (`at`), as for strays.
//
// -> { spots: [{ x, y, r, n, alt? }], spread: bool, at?: { x, y } } (map
// percent, radius in yards, spawn count) | undefined
const SPOT_CAP = 6;
const SPOT_CLUSTER_YARDS = 70;
const SPOT_MAX_CLUSTER_YARDS = 250;
const SPOT_MIN_RADIUS = 15;
const SPREAD_YARDS = 250;
const SPREAD_CAP = 12;
const SPREAD_MIN_RADIUS = 40;
const SPREAD_MAX_MIN_RADIUS = 150;
const STRAY_YARDS = 300;
const STRAY_MAX = 2;
const STRAY_SHARE = 0.75;

// Median distance in yards from a spawn to its nearest neighbour.
function medianSpacing(pts, frame) {
	const { sx, sy } = scaleOf(frame);
	const nn = pts.map((p, i) => {
		let best = Infinity;
		for (let j = 0; j < pts.length; j++) {
			if (j === i) continue;
			const d = Math.hypot((p[0] - pts[j][0]) * sx, (p[1] - pts[j][1]) * sy);
			if (d < best) best = d;
		}
		return best;
	});
	nn.sort((a, b) => a - b);
	return nn[Math.floor(nn.length / 2)];
}

// Yards from the spawns' centre within which 90% of them lie.
function extent90(pts, frame) {
	const { sx, sy } = scaleOf(frame);
	let cx = 0;
	let cy = 0;
	for (const p of pts) {
		cx += p[0] / pts.length;
		cy += p[1] / pts.length;
	}
	const ds = pts.map((p) => Math.hypot((p[0] - cx) * sx, (p[1] - cy) * sy)).sort((a, b) => a - b);
	return ds[Math.min(ds.length - 1, Math.floor(ds.length * 0.9))];
}

// Up to `cap` clusters spread evenly: start from the one nearest (x, y), then
// repeatedly the one farthest from every pick (ties: more spawns, then position).
function evenly(data, map, clusters, cap, x, y) {
	if (clusters.length <= cap) return clusters.slice();
	const dist = (a, b) => distance(data, map, a.x, a.y, b.x, b.y);
	const here = { x, y };
	const tie = (a, b) => b.n - a.n || a.x - b.x || a.y - b.y;
	const rest = clusters.slice().sort((a, b) => dist(a, here) - dist(b, here) || tie(a, b));
	const picked = [rest.shift()];
	const gap = new Map(rest.map((c) => [c, dist(c, picked[0])]));
	while (picked.length < cap && rest.length) {
		let bi = 0;
		for (let i = 1; i < rest.length; i++) {
			const d = gap.get(rest[i]) - gap.get(rest[bi]);
			if (d > 0 || (d === 0 && tie(rest[i], rest[bi]) < 0)) bi = i;
		}
		const next = rest.splice(bi, 1)[0];
		picked.push(next);
		for (const c of rest) gap.set(c, Math.min(gap.get(c), dist(c, next)));
	}
	return picked;
}

// The spots as a walk from (x, y): each next one the nearest left.
function walk(data, map, spots, x, y) {
	const left = spots.slice();
	const out = [];
	let at = { x, y };
	while (left.length) {
		let bi = 0;
		for (let i = 1; i < left.length; i++) {
			const d = distance(data, map, left[i].x, left[i].y, at.x, at.y) - distance(data, map, left[bi].x, left[bi].y, at.x, at.y);
			if (d < 0 || (d === 0 && (left[i].n > left[bi].n || (left[i].n === left[bi].n && (left[i].x - left[bi].x || left[i].y - left[bi].y) < 0)))) bi = i;
		}
		at = left.splice(bi, 1)[0];
		out.push(at);
	}
	return out;
}

// The stray spawns of `pts` (see spawnSpots, "Strays"): the groups of at most
// STRAY_MAX spawns, linked within STRAY_YARDS, beside one group holding at
// least STRAY_SHARE of them. -> Set of points
function strayPoints(pts, frame) {
	const strays = new Set();
	if (pts.length <= SPOT_CAP) return strays;
	const { sx, sy } = scaleOf(frame);
	const root = pts.map((_, i) => i);
	const find = (i) => (root[i] === i ? i : (root[i] = find(root[i])));
	for (let i = 0; i < pts.length; i++) {
		for (let j = i + 1; j < pts.length; j++) {
			if (Math.hypot((pts[i][0] - pts[j][0]) * sx, (pts[i][1] - pts[j][1]) * sy) <= STRAY_YARDS) root[find(i)] = find(j);
		}
	}
	const groups = new Map();
	pts.forEach((p, i) => {
		const g = find(i);
		if (!groups.has(g)) groups.set(g, []);
		groups.get(g).push(p);
	});
	const sizes = [...groups.values()];
	if (Math.max(...sizes.map((g) => g.length)) < STRAY_SHARE * pts.length) return strays;
	for (const g of sizes) if (g.length <= STRAY_MAX) for (const p of g) strays.add(p);
	return strays;
}

// Every known spawn point of `sources` on `map` in frame `f`: the reference
// data's spread points and the ones its cap left out.
function spawnPointsOf(data, sources, map, f) {
	const pts = [];
	for (const src of sources) {
		for (const s of data.spawns(src.kind, src.id)) {
			if (s.map === map && (s.f === 'e' ? 'e' : undefined) === f) pts.push(...s.pts, ...s.more);
		}
	}
	return pts;
}

// A gathering node (mine, herb or fishing object): the real source of what
// it yields at any chance.
const GATHER_ROLES = ['mine', 'herb', 'fishing'];
function gatherNode(data, src) {
	const o = src.kind === 'object' ? data.object(src.id) : null;
	return !!(o && Array.isArray(o.roles) && o.roles.some((r) => GATHER_ROLES.includes(r)));
}

function spawnSpots(data, sources, map, f, x, y, elites = []) {
	const pts = spawnPointsOf(data, sources, map, f);
	if (pts.length < 2) return undefined;
	const frame = data.frame(map);
	const spread = extent90(pts, frame) > SPREAD_YARDS;
	let clusters;
	if (pts.length <= SPOT_CAP) clusters = clusterPoints(pts, frame, { radius: SPOT_CLUSTER_YARDS, cap: Infinity, minRadius: SPOT_MIN_RADIUS });
	else {
		const spacing = medianSpacing(pts, frame);
		const radius = Math.min(SPOT_MAX_CLUSTER_YARDS, Math.max(SPOT_CLUSTER_YARDS, 2 * spacing));
		const minRadius = spread ? Math.round(Math.min(SPREAD_MAX_MIN_RADIUS, Math.max(SPREAD_MIN_RADIUS, spacing))) : SPOT_MIN_RADIUS;
		clusters = clusterPoints(pts, frame, { radius, cap: Infinity, minRadius });
	}
	// The places the arrow may pick: outside elite camps, then not strays, each
	// while any place is left; the goal's point leaves any other place for the
	// nearest of them.
	const { sx, sy } = scaleOf(frame);
	const yards = (a, b) => Math.hypot((a.x - b.x) * sx, (a.y - b.y) * sy);
	const keep = (list, out) => {
		const rest = list.filter((c) => !out(c));
		return rest.length ? rest : list;
	};
	const elitePts = spawnPointsOf(data, elites, map, f).map(([ex, ey]) => ({ x: ex, y: ey }));
	const inCamp = (c) => elitePts.filter((p) => yards(p, c) <= Math.max(c.r, SPOT_CLUSTER_YARDS)).length > c.n;
	let open = elitePts.length ? keep(clusters, inCamp) : clusters;
	const strays = strayPoints(pts, frame);
	if (strays.size) {
		const settled = pts.filter((p) => !strays.has(p)).map(([px, py]) => ({ x: px, y: py }));
		open = keep(open, (c) => !settled.some((p) => yards(p, c) <= c.r));
	}
	let at;
	if (open.length < clusters.length) {
		const here = { x, y };
		const nearest = (list) => list.reduce((a, b) => (yards(b, here) < yards(a, here) ? b : a));
		if (!open.includes(nearest(clusters))) {
			const to = nearest(open);
			x = to.x;
			y = to.y;
			at = { x, y };
		}
	}
	const nearestFirst = (spots) => {
		const d = new Map(spots.map((s) => [s, distance(data, map, s.x, s.y, x, y)]));
		return spots.sort((a, b) => d.get(a) - d.get(b) || b.n - a.n || a.x - b.x || a.y - b.y);
	};
	// The clusters the arrow picks from first, then every other one as an alternative.
	const withRest = (picked) => [...picked, ...nearestFirst(clusters.filter((c) => !picked.includes(c))).map((c) => ({ ...c, alt: true }))];
	let spots;
	if (pts.length <= SPOT_CAP) spots = withRest(spread ? walk(data, map, open, x, y) : nearestFirst(open.slice()));
	else if (spread) spots = withRest(walk(data, map, evenly(data, map, open, SPREAD_CAP, x, y), x, y));
	else {
		const camps = open.some((s) => s.n > 1) ? open.filter((s) => s.n > 1) : open;
		spots = withRest(nearestFirst(camps.slice()).slice(0, SPOT_CAP));
	}
	return at ? { spots, spread, at } : { spots, spread };
}

// A hand-placed goal (`@x,y`) whose target spawns at several places: the
// author's point is the spot the arrow takes, and every place the data knows
// is an alternative (a place within SPOT_MIN_RADIUS of the point joins it,
// the point's radius growing to cover that place's spawns; when every place
// joins, the point is the goal's only spot). Only while the point lies where
// the data has the target, within `near` yards of a known spawn: a point
// further from every spawn places the target where the data does not (Forever
// moved it), and the data's places would mislead.
// -> spots | undefined
function handSpots(data, sources, map, f, x, y, near) {
	if (!data.mapSize(map)) return undefined;
	const pts = spawnPointsOf(data, sources, map, f);
	if (!pts.some((p) => distance(data, map, p[0], p[1], x, y) <= near)) return undefined;
	const sp = spawnSpots(data, sources, map, f, x, y);
	if (!sp) return undefined;
	const own = { x, y, r: SPOT_MIN_RADIUS, n: 0 };
	const alts = [];
	for (const s of sp.spots) {
		const d = distance(data, map, s.x, s.y, x, y);
		if (d <= s.r + SPOT_MIN_RADIUS) {
			own.r = Math.max(own.r, Math.ceil(d + s.r));
			own.n += s.n;
		} else alts.push({ x: s.x, y: s.y, r: s.r, n: s.n, alt: true, d });
	}
	alts.sort((a, b) => a.d - b.d || a.x - b.x || a.y - b.y);
	return [own, ...alts.map(({ d, ...s }) => s)];
}

// A `loop` step (docs/GUIDE_FORMAT.md, "Spawn areas"): its `goto` points, in
// order, are the places to search. Each kill, collect or interact goal the
// author did not place (`@x,y`) and that picks no place at runtime gets them
// as its spawn areas, searched one after another (`spread`), its point at the
// first; the gotos leave the step. A spot's radius is its goto's `r`, else
// LOOP_RADIUS yards.
const LOOP_RADIUS = 30;
const LOOP_VERBS = new Set(['kill', 'collect', 'interact']);
function applyLoop(step, s, data, err) {
	const ln = s.loop;
	const gotos = step.goals.filter((g) => g.t === 'goto');
	if (gotos.some((g) => g.x === undefined)) return; // its coordinates' error is reported
	if (gotos.length < 2) return err(ln, '`loop` needs at least two `goto` points in its step', 'list the places to search as `goto x,y` lines, in the order to walk them');
	const first = gotos[0];
	if (gotos.some((g) => g.map !== first.map)) return err(ln, '`loop` points must all be on one map', 'split the search into a step per map');
	if (gotos.some((g) => g.f !== first.f)) return err(ln, '`loop` points must all be in one map frame: all Era, or all `live`');
	const own = gotos.find((g) => g.only || g.optional);
	if (own) return err(own._line, 'a `loop` point cannot be `optional` or have `only`: every goal of the loop searches it');
	const targets = step.goals.filter((g, i) => LOOP_VERBS.has(g.t) && !s.goals[i].explicitCoords && !g.candidates);
	if (!targets.length) {
		return err(ln, '`loop` needs a kill, collect or interact goal without its own `@x,y`', 'a goal placed with `@x,y` keeps its point; drop `loop` to walk the gotos as a path');
	}
	for (const goal of targets) {
		goal.map = first.map;
		goal.x = first.x;
		goal.y = first.y;
		if (first.f) goal.f = first.f;
		else delete goal.f;
		goal.spots = gotos.map((g) => ({ x: g.x, y: g.y, r: g.r !== undefined ? g.r : LOOP_RADIUS }));
		goal.spread = true;
		delete goal.z;
		setIf(goal, 'z', goalHeight(data, goal));
		for (const p of goal.spots) setIf(p, 'z', spotHeight(data, goal, p));
	}
	step.goals = step.goals.filter((g) => g.t !== 'goto');
}

function onlyOf(c) {
	if (!c) return undefined;
	const o = {};
	setIf(o, 'classes', c.classes);
	setIf(o, 'races', c.races);
	setIf(o, 'factions', c.factions);
	return Object.keys(o).length ? o : undefined;
}

function resolveGuide(ast, data, diag, opts = {}) {
	const file = ast.file;
	const err = (ln, msg, hint) => diag.error(file, ln, msg, hint);
	const warn = (ln, msg, hint) => diag.warn(file, ln, msg, hint);
	const h = ast.header;
	const zoneCache = new Map();

	const resolveZone = (spec) => {
		if (!spec) return null;
		if (zoneCache.has(spec)) return zoneCache.get(spec);
		let out = null;
		if (spec.map !== undefined) {
			const z = data.zone(spec.map);
			if (!z && Object.keys(data.zones).length) warn(spec.line, `map ${spec.map} is not in zones.json`);
			out = { id: spec.map, name: z && z.name ? String(z.name) : undefined };
		} else {
			const found = data.zoneNamed(spec.name);
			if (!found) {
				err(spec.line, `unknown zone "${spec.name}" (not in zones.json; use \`zone map <uiMapID>\`)`);
			} else {
				if (found.ambiguous) {
					warn(spec.line, `zone "${spec.name}" matches maps ${found.ambiguous.map((z) => z.id).join(', ')}; using ${found.zone.id} (write \`zone map <uiMapID>\` to choose)`);
				}
				out = { id: found.zone.id, name: String(found.zone.name) };
			}
		}
		zoneCache.set(spec, out);
		return out;
	};

	const guide = { id: ast.id };
	guide.pack = opts.pack || 'guides';
	guide.title = h.title;
	setIf(guide, 'faction', h.faction);
	setIf(guide, 'races', h.races);
	setIf(guide, 'classes', h.classes);
	if (h.levels) {
		guide.minLevel = h.levels.min;
		guide.maxLevel = h.levels.max;
	}
	guide.category = canonicalCategory(h.category, ast, warn);
	setIf(guide, 'folder', h.folder);
	setIf(guide, 'keywords', h.keywords);
	if (h.collects) {
		guide.collects = h.collects.slice();
		// Validated only when items.json is loaded: a missing data directory already warns.
		const haveItems = Object.keys(data.items || {}).length > 0;
		for (const id of h.collects) {
			if (haveItems && !data.item(id)) warn(ast.lines.collects, `\`collects\` item ${id} is not in data (new Forever content?)`);
		}
	}
	// `reward` / `why`: what the guide's goal gives and why it is worth it,
	// shown in the guide menu. Display only: an item's name from the line,
	// else items.json (an id with neither is an error); a spell needs its name.
	if (h.reward) {
		guide.reward = h.reward.map((e) => {
			if (e.text !== undefined) return { text: e.text };
			if (e.spell !== undefined) {
				if (!e.spellName) err(e.line, `reward spell ${e.spell} needs its name: \`reward spell ${e.spell} "Spell name"\``);
				return { spell: e.spell, spellName: e.spellName };
			}
			const known = data.item(e.item);
			const out = { item: e.item };
			const name = e.itemName || (known && known.name ? String(known.name) : null);
			if (!name) err(e.line, `reward item ${e.item} is not in data; give its name: \`${e.item} "Item name"\``, FIND_ID_HINT);
			else out.itemName = name;
			setIf(out, 'quality', e.quality);
			if (e.choice) out.choice = true;
			return out;
		});
	}
	setIf(guide, 'why', h.why);
	if (guide.category === 'Class') {
		if (!h.reward) warn(ast.line, 'a Class guide needs `reward`: what its chain gives (`reward item <id>`, `reward spell <id> "Name"` or `reward text <words>`), shown in the guide menu');
		if (!h.why) warn(ast.line, 'a Class guide needs `why`: one short line on why the chain is worth doing, shown in the guide menu');
	}
	const hz = resolveZone(h.zone);
	if (hz) {
		guide.zone = hz.id;
		setIf(guide, 'zoneName', hz.name);
	}
	// `next`: the default route; with several, `nextChoices` lists every
	// option in the author's order (the default first) for the route choice.
	// `next <id> when ...`: `nextWhen` maps such an option to its predicate
	// (as a step's `when`, the subzone looked up where the guide ends), and
	// the options are listed in `nextChoices` even when there is one, for the
	// engine to check at the hand-off.
	if (h.next && h.next.length) {
		guide.next = h.next[0];
		if (h.next.length > 1 || h.nextWhen) guide.nextChoices = h.next.slice();
	}
	if (h.nextWhen) {
		const lastStep = ast.steps[ast.steps.length - 1];
		const lastGoal = lastStep && lastStep.goals[lastStep.goals.length - 1];
		const endZone = resolveZone((lastStep && lastStep.zone) || (lastGoal && lastGoal.zone)) || hz;
		guide.nextWhen = {};
		for (const id of h.next) {
			const p = h.nextWhen[id];
			if (!p) continue;
			// `done` names a step of the guide being played; the options are also listed from other guides.
			if (p.k === 'done') err(p.line, '`done` checks a step of the guide being played: it cannot decide a `next` option', 'use a predicate on the character, such as `turnedin <quest>`');
			else if (p.k === 'group') err(p.line, '`group` asks the player at a step of the guide: it cannot decide a `next` option', 'put `when group <quest>` on the steps of that quest');
			else guide.nextWhen[id] = resolveWhen([p], endZone ? endZone.id : null, null, data, warn);
		}
	}
	setIf(guide, 'pitch', h.pitch);
	setIf(guide, 'pros', h.pros);
	setIf(guide, 'cons', h.cons);
	// A guide without `author` is its pack's author's (opts.author, from
	// pack.json); ours when no pack author is given.
	guide.author = h.author || opts.author || 'Polestar';
	guide.version = h.version !== undefined ? h.version : 1;
	guide.steps = [];
	hidden(guide, '_ast', ast);

	// Every zone the guide sets anywhere (header and `zone` directives).
	const zonesSet = new Set();
	if (hz) zonesSet.add(hz.id);
	for (const s of ast.steps) {
		for (const g of s.goals) {
			const z = resolveZone(g.zone);
			if (z) zonesSet.add(z.id);
		}
	}

	let prev = null;
	const usedMaps = []; // most recent first
	const use = (m) => {
		const i = usedMaps.indexOf(m);
		if (i >= 0) usedMaps.splice(i, 1);
		usedMaps.unshift(m);
	};
	// A `zone` line holds for the steps after it, also when its step is for
	// some characters only: a Druid trip's `zone Moonglade` would hold for the
	// rest of a Darkshore guide. Typed coordinates without `map` are on the zone
	// in effect, so they warn when characters who see them skip the step that
	// set it and are in another zone (the last `zone` line of the steps they
	// see, or the header's).
	const classesOf = (race, side) => data.raceClasses(race, side);
	const headLayer = { factions: h.faction ? [h.faction] : null, races: h.races || null, classes: h.classes || null };
	const setters = ast.steps.filter((s) => s.zone).map((s) => ({ spec: s.zone, only: s.only, who: characterKeys([headLayer, s.only], classesOf) }));
	const zoneOfOthers = (s, g) => {
		const own = setters.find((z) => z.spec === g.zone);
		const here = resolveZone(g.zone);
		if (!own || !here) return null;
		for (const k of characterKeys([headLayer, s.only, g.only], classesOf)) {
			if (own.who.has(k)) continue;
			let spec = h.zone || null;
			for (const z of setters) {
				if (z.spec.line > g.line) break;
				if (z.who.has(k)) spec = z.spec;
			}
			const there = resolveZone(spec);
			if (there && there.id !== here.id) return { here, there, own };
		}
		return null;
	};
	const frameDefault = { frame: h.coords || 'era', explicit: h.coords !== undefined };
	// Per skill line, in step order: the last `skill`/`until` target and the last rank trained.
	const profProgress = new Map();
	for (const s of ast.steps) {
		const step = {};
		setIf(step, 'title', s.title);
		setIf(step, 'note', s.tip);
		// The picture's path in the pack's addon folder, as the client writes
		// paths; its file and size are checked against the pack folder later
		// (images.js checkImages), which fills in a size the author left out.
		if (s.image) {
			step.image = s.image.w ? { file: s.image.path.split('/').join('\\'), w: s.image.w, h: s.image.h } : { file: s.image.path.split('/').join('\\') };
			hidden(step, '_imageSpec', s.image);
		}
		setIf(step, 'only', onlyOf(s.only));
		const stepZone = resolveZone(s.zone || (s.goals[0] && s.goals[0].zone));
		setIf(step, 'when', resolveWhen(s.when, stepZone ? stepZone.id : null, h.levels ? [h.levels.min, h.levels.max] : null, data, warn));
		setIf(step, 'label', s.label);
		setIf(step, 'along', s.along);
		// `skipto <label> when <predicate>`: { to, when } in the step's order, `when` one predicate.
		if (s.skipto) step.skipto = s.skipto.map((k) => ({ to: k.to, when: resolveWhen([k.when], stepZone ? stepZone.id : null, null, data, warn)[0] }));
		step.goals = [];
		hidden(step, '_line', s.line);
		hidden(step, '_only', s.only);
		for (const g of s.goals) {
			const zone = resolveZone(g.zone);
			const zoneId = zone ? zone.id : null;
			const ctx = {
				sides: sidesFor([h.faction ? [h.faction] : null, s.only && s.only.factions, g.only && g.only.factions]),
				usedMaps,
				frame: g.frame ? { frame: g.frame, explicit: true } : frameDefault,
				layers: [{ factions: h.faction ? [h.faction] : null, races: h.races || null, classes: h.classes || null }, s.only, g.only],
				prof: profProgress,
				zoneId,
				loop: !!s.loop,
			};
			const goal = resolveGoal(g, zoneId, prev, data, err, warn, ctx);
			hidden(goal, '_line', g.line);
			hidden(goal, '_only', g.only || null);
			step.goals.push(goal);
			// Leveling guides are for every character: a goal only those with a
			// profession see should be optional, unless the guide trains it first
			// (and levels it to the quest's rank above 1).
			if (guide.category === 'Leveling' && goal.profLine !== undefined && !goal.optional) {
				const prog = profProgress.get(goal.profLine);
				if (!prog || !(prog.target >= goal.profRank || (prog.rank >= 1 && goal.profRank <= 1))) {
					const prof = `${goal.profName || `skill ${goal.profLine}`} ${goal.profRank}`;
					warn(
						g.line,
						`quest ${goal.quest} (${goal.title || 'untitled'}) needs ${prof}, and the guide does not train it before here: characters without it never see this goal`,
						`make the goal \`optional\`, or \`train ${goal.profName || '<Profession>'}\` earlier in the guide`,
					);
				}
			}
			if (goal.map !== undefined && zoneId !== null && goal.map !== zoneId && !zonesSet.has(goal.map)) {
				const name = (id) => {
					const z = data.zone(id);
					return z && z.name ? `${id} (${z.name})` : String(id);
				};
				warn(
					g.line,
					`coordinates on map ${name(goal.map)}, but this step's zone is ${name(zoneId)} and the guide never sets zone ${goal.map}; check the target, or add \`zone map ${goal.map}\` if the route really goes there`,
				);
			}
			const other = g.explicitCoords && g.coordMap === undefined ? zoneOfOthers(s, g) : null;
			if (other) {
				const o = other.own.only || {};
				const who = whoLabel({ faction: o.factions ? o.factions.join('/') : null, races: o.races, classes: o.classes });
				warn(
					g.line,
					`coordinates on ${other.here.name}, the zone line ${g.zone.line} sets in a step for ${who} only; the others who see this goal are in ${other.there.name}`,
					`add \`zone ${other.there.name}\` to this step (or to the first step after the ${who} ones), or \`map ${other.there.id}\` to the goal`,
				);
			}
			if (zoneId !== null) use(zoneId);
			if (goal.x !== undefined) {
				prev = { map: goal.map, x: goal.x, y: goal.y };
				use(goal.map);
			}
		}
		if (s.loop) {
			applyLoop(step, s, data, err);
			const last = step.goals.findLast((goal) => goal.x !== undefined);
			if (last) prev = { map: last.map, x: last.x, y: last.y };
		}
		guide.steps.push(step);
	}
	// The guide menu's "Group" chip: some goal of the route needs a group.
	if (guide.steps.some((s) => s.goals.some((goal) => goal.group && !goal.optional))) guide.group = true;
	checkLabels(ast.steps, err);
	checkAlongGoals(guide.steps, warn);
	return guide;
}

// Step labels are guide-wide: each names one step, `along until <label>` and
// `skipto <label>` name a step after their own, and `done <label>` (in a
// step's `when` or a `skipto`) names any step of the guide (ast.steps and the
// compiled steps share their indexes).
function checkLabels(steps, err) {
	const labels = new Map(); // name -> { index, line }
	steps.forEach((s, i) => {
		if (!s.label) return;
		if (labels.has(s.label)) err(s.labelLine, `duplicate label "${s.label}" (first at line ${labels.get(s.label).line})`);
		else labels.set(s.label, { index: i, line: s.labelLine });
	});
	steps.forEach((s, i) => {
		if (typeof s.along !== 'string') return;
		const t = labels.get(s.along);
		if (!t) err(s.alongLine, `unknown label "${s.along}"`, 'name it on a later step with `label <name>`');
		else if (t.index <= i) err(s.alongLine, `\`along until ${s.along}\` must name a later step (the label is on line ${t.line})`);
	});
	steps.forEach((s, i) => {
		for (const k of s.skipto || []) {
			const t = labels.get(k.to);
			if (!t) err(k.line, `unknown label "${k.to}"`, 'name it on a later step with `label <name>`');
			else if (t.index <= i) err(k.line, `\`skipto ${k.to}\` must name a later step (the label is on line ${t.line})`);
		}
		for (const p of [...(s.when || []), ...(s.skipto || []).map((k) => k.when)]) {
			if (p.k === 'done' && !labels.has(p.label)) err(p.line, `unknown label "${p.label}"`, 'name a step with `label <name>`');
		}
	});
}

// Goals Polestar checks off only on the step the route is on: arrivals, NPC
// visits, flights, hearths, and tasks and kills, clicks and uses without a
// quest (the player ticks those). In an along step they never check off.
const ON_STEP_ONLY = new Set(['goto', 'talk', 'hearth', 'getfp', 'fly', 'vendor', 'task']);
function onStepOnly(goal) {
	if (ON_STEP_ONLY.has(goal.t)) return true;
	if (goal.t === 'train') return goal.skillLine === undefined;
	return (goal.t === 'kill' || goal.t === 'interact' || goal.t === 'use') && goal.quest === undefined;
}

function checkAlongGoals(steps, warn) {
	for (const step of steps) {
		if (!step.along) continue;
		for (const goal of step.goals) {
			if (!onStepOnly(goal)) continue;
			const what = goal.quest === undefined && ['kill', 'interact', 'use'].includes(goal.t) ? `\`${goal.t}\` without \`quest\`` : `\`${goal.t}\``;
			warn(goal._line, `${what} in an \`along\` step never checks off: Polestar checks it only on the step the route is on, so it stays listed${typeof step.along === 'string' ? ` until the step labelled ${step.along}` : ''}`, 'put it in a step of its own, or track something the game counts (a quest objective, a bag count)');
		}
	}
}

// What an accept of quest `id` (record `q`, or null) waits on, for the
// engine: blocking prerequisites only (breadcrumbs dropped: `pre` = one of
// them suffices, `preAll` = every one is needed), the quests that close it
// for good once taken or done (closedByOf: the quest a breadcrumb leads to,
// also when only that quest's `breadcrumbs` name it, and its exclusive group:
// another race's or class's version of the same chain), and their titles for
// the engine's "needs <quest> first" / "you took <quest>" text.
function acceptGate(q, id, data) {
	const out = {};
	const { all, any } = blockingPrereqs(q, (p) => data.quest(p));
	if (any.length) out.pre = any;
	if (all.length) out.preAll = all;
	const closedBy = closedByOf(id, data.quests || {});
	if (closedBy.length) out.closedBy = closedBy;
	const titles = {};
	for (const p of [...all, ...any, ...closedBy]) {
		const pq = data.quest(p);
		if (pq && pq.title) titles[p] = String(pq.title);
	}
	if (Object.keys(titles).length) out.preTitles = titles;
	return out;
}

// A step's `when` predicates (tools/lib/dsl/when.js) as the engine reads them
// (docs/PACK_FORMAT.md, "Format 4"): quest and item ids (`has`, `upgrade`)
// checked against the data; `available` with what an accept of the quest waits on (minLevel,
// pre, preAll, closedBy); a zone, subzone or bind location with its area
// (places.js, "Places by ID"), the subzone looked up in the step's zone; a
// dungeon with its Map.csv id (group.js dungeonNamed), the key of the
// player's choice; a profession with its skill line (`skill`); a `cooldown`
// item checked against the data; a `group` quest checked as one. `levels`: the
// guide's [min, max], to warn about a step no character in that range sees.
function resolveWhen(list, zoneId, levels, data, warn) {
	if (!list || !list.length) return undefined;
	const haveQuests = Object.keys(data.quests || {}).length > 0;
	const haveItems = Object.keys(data.items || {}).length > 0;
	const haveZones = Object.keys(data.zones || {}).length > 0;
	const out = list.map((p) => {
		const w = { k: p.k };
		if (p.neg) w.neg = true;
		switch (p.k) {
			case 'level':
				w.op = p.op;
				w.n = p.n;
				if (p.frac) w.frac = p.frac;
				break;
			case 'money':
				w.op = p.op;
				w.n = p.n;
				break;
			case 'onquest':
			case 'complete':
			case 'turnedin':
			case 'available':
			case 'group': {
				w.q = Array.isArray(p.q) ? p.q.slice() : p.q;
				for (const id of [].concat(p.q)) {
					if (haveQuests && !data.quest(id)) warn(p.line, `quest ${id} is not in data (new Forever content?)`);
				}
				if (p.k === 'available') {
					const q = data.quest(p.q);
					if (q && q.minLevel > 0) w.minLevel = Number(q.minLevel);
					const gate = acceptGate(q, p.q, data);
					setIf(w, 'pre', gate.pre);
					setIf(w, 'preAll', gate.preAll);
					setIf(w, 'closedBy', gate.closedBy);
				}
				break;
			}
			case 'has':
				w.item = p.item;
				w.n = p.n;
				if (haveItems && !data.item(p.item)) warn(p.line, `item ${p.item} is not in data (new Forever content?)`);
				break;
			case 'upgrade':
				w.item = p.item;
				if (haveItems && !data.item(p.item)) warn(p.line, `item ${p.item} is not in data (new Forever content?)`);
				break;
			case 'zone': {
				w.name = p.name;
				const found = data.zoneNamed(p.name);
				if (found && found.zone.areaId) w.area = Number(found.zone.areaId);
				else if (!found && haveZones) warn(p.line, `zone "${p.name}" is not in zones.json: the game never reports that zone name, so the predicate never holds there`, 'write the zone as the game names it (`polestar find --kind zone <text>`)');
				break;
			}
			case 'subzone': {
				w.name = p.name;
				const z = zoneId != null ? data.zone(zoneId) : null;
				const area = areaNamed(data.areas, p.name, z && z.areaId);
				if (area) w.area = area.id;
				else if (data.areas) warn(p.line, `subzone "${p.name}" names no single area${z && z.name ? ` in ${z.name}` : ''}: the predicate compares the subzone text as written, in English only`);
				break;
			}
			case 'done':
				w.label = p.label;
				break;
			case 'skill': {
				const prof = data.professionNamed(p.name);
				w.name = prof ? String(prof.name) : p.name;
				if (prof) w.skillLine = prof.id;
				else warn(p.line, `profession "${p.name}" is not in data: the predicate reads the skill by that name, in English only`);
				w.n = p.n;
				break;
			}
			case 'cooldown':
				if (p.item) {
					w.item = p.item;
					if (haveItems && !data.item(p.item)) warn(p.line, `item ${p.item} is not in data (new Forever content?)`);
				} else w.spell = p.spell;
				break;
			case 'dungeon': {
				w.name = p.name;
				const run = dungeonNamed(data, p.name);
				if (run) w.map = run.map;
				else if (data.instances) warn(p.line, `dungeon "${p.name}" is not a dungeon in the client's instance tables: no character can choose it, so \`when dungeon\` never holds and \`when !dungeon\` always does`, 'write the dungeon as the game names it, as the guide window\'s "Dungeon:" line shows it ("Ragefire Chasm")');
				break;
			}
			default: {
				// bound
				w.name = p.name;
				const bad = checkLocation(data, 'sethome', p.name);
				if (bad) warn(p.line, bad.message.replace(/^sethome/, 'bound'), bad.hint);
				const area = areaNamed(data.areas, p.name);
				if (area) w.area = area.id;
			}
		}
		return w;
	});
	// No character in the guide's levels sees a step whose `level` predicates
	// leave no level; nor any character a step that asks for one state both ways.
	const lv = list.filter((p) => p.k === 'level');
	if (lv.length && levels) {
		let [lo, hi] = levels;
		for (const p of lv) {
			const [a, b] = levelRange(p);
			lo = Math.max(lo, a);
			hi = Math.min(hi, b);
		}
		if (lo > hi) warn(lv[lv.length - 1].line, `the step's \`when level\` never holds for this guide's levels (${levels[0]}-${levels[1]}): no character sees the step`);
	}
	const key = (p) => JSON.stringify({ ...p, neg: undefined, line: undefined });
	for (const p of list) {
		if (p.k !== 'level' && list.some((o) => o !== p && !!o.neg !== !!p.neg && key(o) === key(p))) {
			warn(p.line, `the step asks for \`${p.k}\` and \`!${p.k}\` of the same ${p.k === 'has' || p.k === 'upgrade' ? 'item' : p.k === 'onquest' || p.k === 'complete' || p.k === 'turnedin' || p.k === 'available' || p.k === 'group' ? 'quest' : p.k === 'dungeon' ? 'dungeon' : p.k === 'done' ? 'step' : p.k === 'skill' ? 'profession and rank' : p.k === 'cooldown' ? (p.item ? 'item' : 'spell') : 'place'}: no character sees it`);
			break;
		}
	}
	return out;
}

function objectiveFor(q, kind, id) {
	if (!q || !Array.isArray(q.objectives)) return null;
	const idx = q.objectives.findIndex((o) => o && o.id === id && (kind === null || o.type === kind));
	return idx < 0 ? null : idx + 1;
}

const CATEGORIES = ['Leveling', 'Class', 'Professions', 'Reputation', 'Legacy', 'Exploration', 'Collectibles', 'Miscellaneous', 'Dungeons'];

// Documented categories are matched case-insensitively; others pass through with a warning.
function canonicalCategory(raw, ast, warn) {
	if (raw === undefined) return 'Leveling';
	const known = CATEGORIES.find((c) => c.toLowerCase() === raw.toLowerCase());
	if (known) return known;
	warn(ast.lines.category, `unknown category "${raw}" (known: ${CATEGORIES.join(', ')})`);
	return raw;
}

// Factions a smart goal serves: the goal's factions, narrowed by the races it
// can apply to (a Human-only guide needs no Horde trainers). Skyborne and
// unknown races (new Forever races) keep both.
function smartSides(sides, chars) {
	const fromRaces = new Set(chars.races.flatMap(raceSides));
	const narrowed = sides.filter((s) => fromRaces.has(s));
	return narrowed.length ? narrowed : sides;
}

function progressOf(ctx, skillLine) {
	if (!ctx.prof) return { target: undefined, rank: 0 };
	if (!ctx.prof.has(skillLine)) ctx.prof.set(skillLine, { target: undefined, rank: 0 });
	return ctx.prof.get(skillLine);
}

// `train <Profession> [Rank]`. Without a rank: the highest rank whose minimum
// skill the guide's last `skill`/`until` target for that profession reaches
// (Apprentice when there is none), and always above a rank trained earlier in
// the guide.
function trainProfession(g, goal, data, ctx, err, warn, smart) {
	const ln = g.line;
	const p = data.professionNamed(g.profession);
	if (!p) {
		err(ln, `unknown profession "${g.profession}" (write \`train <Profession> [Apprentice|Journeyman|Expert|Artisan]\`, \`train class\` or \`train <npcId>\`)`);
		return;
	}
	const full = data.profession(p.id) || p;
	const ranks = Array.isArray(full.ranks) ? full.ranks : [];
	const minSkill = (r) => (ranks[r - 1] && Number.isFinite(Number(ranks[r - 1].minSkill)) ? Number(ranks[r - 1].minSkill) : RANK_MIN_SKILL[r - 1]);
	const prog = progressOf(ctx, p.id);
	let rank = g.rank;
	if (rank === undefined) {
		rank = 1;
		if (prog.target !== undefined) {
			for (let r = 4; r >= 1; r--) {
				if (minSkill(r) <= prog.target) {
					rank = r;
					break;
				}
			}
		}
		if (rank <= prog.rank) rank = prog.rank + 1;
		if (rank > 4) {
			err(ln, `\`train ${p.name}\`: Artisan is already trained earlier in this guide`);
			return;
		}
		const have = prog.target === undefined ? 0 : prog.target;
		if (minSkill(rank) > have) {
			warn(ln, `\`train ${p.name}\` means ${RANK_NAMES[rank - 1]} here (needs skill ${minSkill(rank)}), but no earlier \`skill ${p.name}\` target reaches ${minSkill(rank)}; name the rank or add the skill goal`);
		}
	}
	goal.skill = String(p.name);
	goal.skillLine = p.id;
	goal.rank = rank;
	goal.rankMax = ranks[rank - 1] && Number(ranks[rank - 1].max) > 0 ? Number(ranks[rank - 1].max) : RANK_CAPS[rank - 1];
	prog.rank = Math.max(prog.rank, rank);
	if (g.npc !== undefined) return; // an explicit trainer stays fixed
	const rk = ranks[rank - 1] || {};
	const entries = [];
	const addSides = (bySide) => {
		for (const side of Object.keys(bySide || {}).sort()) {
			const tag = side === 'Alliance' || side === 'A' ? 'A' : side === 'Horde' || side === 'H' ? 'H' : undefined;
			for (const id of Array.isArray(bySide[side]) ? bySide[side] : []) entries.push({ npc: Number(id), side: tag });
		}
	};
	let what = `${p.name} ${RANK_NAMES[rank - 1]} trainer`;
	if (rk.trainers) addSides(rk.trainers);
	else if (rk.book && rk.book.vendors) {
		addSides(rk.book.vendors);
		what = `vendor of the ${p.name} ${RANK_NAMES[rank - 1]} book`;
	} else if (rk.quest && rk.quest.npcs) {
		addSides(rk.quest.npcs);
		what = `${p.name} ${RANK_NAMES[rank - 1]} quest giver`;
	} else addSides(full.trainers);
	smart(goal, entries, `${what}${data.hasProfessions ? '' : ' (professions.json missing)'}`);
}

// Factions a goal can apply to, from the guide faction and step/goal conditions.
function sidesFor(lists) {
	let sides = ['Alliance', 'Horde'];
	for (const l of lists) if (l) sides = sides.filter((s) => l.includes(s));
	return sides;
}

function resolveGoal(g, zoneMap, prev, data, err, warn, ctx = { sides: ['Alliance', 'Horde'] }) {
	const ln = g.line;
	const v = g.verb;
	const goal = { t: v };
	let candidates = []; // entities whose spawns give coordinates
	let checkKinds = null; // entities for the explicit-coordinates check
	let questFields = false;
	let passRares = false; // a collect whose rare tops its few droppers: the common ones lead (see onMap)
	let dropLevel; // a collect's quest level: droppers far above it are passed over (see onMap)

	const requireName = (kind, id, explicit, label) => {
		const name = explicit || nameOf(data, kind, id);
		const known = kind === 'npc' ? data.npc(id) : kind === 'object' ? data.object(id) : data.item(id);
		if (!name) {
			err(ln, `${kind} ${id} is not in data; give its name: \`${v} ${id} "${label}"\``, FIND_ID_HINT);
		} else if (!known) {
			warn(ln, `${kind} ${id} is not in data; using the explicit name (new Forever content?)`);
		}
		return name;
	};
	const optionalName = (kind, id) => {
		const name = nameOf(data, kind, id);
		const known = kind === 'npc' ? data.npc(id) : kind === 'object' ? data.object(id) : data.item(id);
		if (!known) warn(ln, `${kind} ${id} is not in data; its name and position cannot be filled`);
		return name;
	};
	// A location the game never reports (places.js): a warning with the closest names.
	const placeWarning = (verb, location) => {
		const bad = checkLocation(data, verb, location);
		if (bad) warn(ln, bad.message, bad.hint);
	};

	// Smart targets: a candidate set the engine chooses from at runtime, for
	// the factions this goal can apply to, ranked from the previous goal (else
	// the zone centre).
	const smart = (target, entries, what) => {
		const chars = applicable(ctx.layers || []);
		const sides = smartSides(ctx.sides, chars);
		const ref = prev || (ctx.zoneId != null ? { map: ctx.zoneId, x: 50, y: 50 } : null);
		const built = buildCandidates(data, entries, { sides, ref });
		if (!built.candidates.length) {
			err(ln, `\`${v}\` found no ${what} in data for ${sides.join(' or ')} characters; name one with an npc id instead`);
			return;
		}
		target.candidates = built.candidates;
		for (const s of sides) {
			if (!built.coverage[s]) warn(ln, `no ${what} for ${s} in data, but this goal applies to ${s} characters`);
		}
		if (target.class) {
			for (const s of sides) {
				for (const c of chars.classes) {
					// Only classes a race of this side can be (data/forever/races.json, the Forever client's CharBaseInfo).
					const possible = chars.races.some((r) => data.raceClasses(r, s).includes(c));
					if (!possible) continue;
					const tag = s === 'Alliance' ? 'A' : 'H';
					const has = built.candidates.some((cand) => (cand.faction === tag || cand.faction === 'AH') && (cand.classes || []).includes(c));
					if (!has) warn(ln, `no ${c[0]}${c.slice(1).toLowerCase()} trainer for ${s} in data (trainers.json)`);
				}
			}
		}
	};

	switch (v) {
		case 'accept':
		case 'turnin':
		case 'complete': {
			const q = data.quest(g.quest);
			goal.quest = g.quest;
			const title = g.title || (q && q.title ? String(q.title) : null);
			if (!title) err(ln, `quest ${g.quest} is not in data; give its title: \`${v} ${g.quest} "Title"\``, FIND_ID_HINT);
			else if (!q) warn(ln, `quest ${g.quest} is not in data; using the explicit title (new Forever content?)`);
			goal.title = title || undefined;
			if (v === 'complete') break;
			const ends = v === 'accept' ? q && q.start : q && q.end;
			if (g.npc !== undefined) {
				candidates = [{ kind: 'npc', id: g.npc }];
				optionalName('npc', g.npc);
			} else if (g.object !== undefined) {
				candidates = [{ kind: 'object', id: g.object }];
				optionalName('object', g.object);
			} else if (g.item !== undefined) {
				goal.item = g.item;
				setIf(goal, 'itemName', optionalName('item', g.item));
			} else if (ends) {
				for (const id of ends.npc || []) candidates.push({ kind: 'npc', id });
				for (const id of ends.object || []) candidates.push({ kind: 'object', id });
				if (!candidates.length && v === 'accept' && (ends.item || []).length) {
					goal.item = ends.item[0];
					setIf(goal, 'itemName', nameOf(data, 'item', goal.item));
				}
			}
			if (v === 'accept') {
				const ml = g.minLevel !== undefined ? g.minLevel : q && q.minLevel > 0 ? q.minLevel : undefined;
				setIf(goal, 'minLevel', ml);
				// For the engine's grey-quest skipping.
				if (q && Number(q.level) > 0) goal.qlvl = Number(q.level);
				Object.assign(goal, acceptGate(q, goal.quest, data));
			}
			if (v === 'turnin') {
				const rewards = {};
				// Display only: names and qualities from the line, else items.json;
				// an id with neither name is an error, an unknown named id is fine.
				const entries = (list) =>
					list.map((it) => {
						const known = data.item(it.item);
						const out = { item: it.item };
						const name = it.itemName || (known && known.name ? String(known.name) : null);
						if (!name) err(ln, `reward item ${it.item} is not in data; give its name: \`${it.item} "Item name"\``, FIND_ID_HINT);
						else out.itemName = name;
						const quality = it.quality !== undefined ? it.quality : known && Number.isInteger(known.quality) ? known.quality : undefined;
						setIf(out, 'quality', quality);
						return out;
					});
				if (g.rewardItems) rewards.items = entries(g.rewardItems);
				if (g.rewardChoices) rewards.choices = entries(g.rewardChoices);
				if (g.rewardXp !== undefined) rewards.xp = g.rewardXp;
				if (g.rewardMoney !== undefined) rewards.money = g.rewardMoney;
				if (Object.keys(rewards).length) goal.rewards = rewards;
			}
			checkKinds = candidates;
			break;
		}
		case 'kill': {
			if (g.npc !== undefined) {
				goal.target = requireName('npc', g.npc, g.target, 'Target name') || undefined;
				goal.npc = g.npc;
				candidates = [{ kind: 'npc', id: g.npc }];
			} else {
				goal.target = g.target;
			}
			questFields = true;
			checkKinds = candidates;
			break;
		}
		case 'collect': {
			goal.item = g.item;
			goal.itemName = requireName('item', g.item, g.itemName, 'Item name') || undefined;
			const it = data.item(g.item);
			const sources = [];
			if (it && it.drops) {
				for (const kind of ['npc', 'object']) {
					for (const [id, chance] of Object.entries(it.drops[kind] || {})) sources.push({ kind, id: Number(id), chance: Number(chance) || 0 });
				}
			}
			sources.sort((a, b) => b.chance - a.chance || (a.kind === b.kind ? a.id - b.id : a.kind === 'npc' ? -1 : 1));
			// Every dropping source with spawns, by drop chance; pickSpawn prefers ones on
			// the current zone and on maps the guide already uses, then the likely sources
			// on that map (see pickSpawn), nearest first. Vendors are not sources here:
			// `buy … nearest` is the vendor path.
			if (g.nearest) {
				// Farm spots: the engine picks one by level, safety and travel time.
				if (g.quest !== undefined) err(ln, '`collect … nearest` farms by bag count; drop `quest` (quest objectives use the quest’s own targets)');
				if (g.count === undefined) err(ln, '`collect … nearest` needs a count: `collect <item> xN nearest`');
				const chars = applicable(ctx.layers || []);
				const sides = smartSides(ctx.sides, chars);
				const spots = farmSpots(data, g.item).filter((sp) => sides.some((s) => sp.faction === 'AH' || sp.faction === (s === 'Alliance' ? 'A' : 'H')));
				if (!spots.length) {
					err(ln, `\`collect ${g.item} nearest\` found no farm spot (normal mobs dropping it at 2% or more, outside towns) for ${sides.join(' or ')} characters; give @x,y or a gathering step instead`);
				} else {
					goal.candidates = spots;
					for (const s of sides) {
						if (!spots.some((sp) => sp.faction === 'AH' || sp.faction === (s === 'Alliance' ? 'A' : 'H'))) {
							warn(ln, `no farm spot for item ${g.item} that is safe for ${s}, but this goal applies to ${s} characters`);
						}
					}
				}
				break;
			}
			// `npc <id>`: the NPC who hands the item over, for an item the data
			// has no source for — a quest report given in a gossip window, where
			// `drops` is empty, so nothing names anyone to target. The target
			// button and the step key read a collect's `npc` (QoL/Buttons.lua,
			// `TargetNames`), and the point is that NPC's spawn unless the author
			// places it.
			if (g.npc !== undefined) {
				goal.npc = g.npc;
				setIf(goal, 'npcName', optionalName('npc', g.npc));
				candidates = [{ kind: 'npc', id: g.npc }];
				checkKinds = candidates;
				questFields = true;
				break;
			}
			candidates = sources.filter((s) => data.spawns(s.kind, s.id).length);
			// A quest item nothing drops, whose data lists an NPC as its "vendor":
			// he hands it over in his gossip window (the Warsong Scout's update),
			// and no dropper can give the target button that name. Only for a
			// quest objective of a quest item, so a trade good a vendor happens to
			// stock (Rugged Leather, farmed at a spot) names nobody. Named, never
			// placed: `buy … nearest` is the vendor path.
			if (!candidates.length && g.quest !== undefined && it && it.questItem) {
				const handover = (it.vendors || []).map((id) => ({ kind: 'npc', id: Number(id) })).filter((h) => data.spawns('npc', h.id).length);
				setIf(goal, 'fromNpcs', sourceNpcs(data, handover[0], handover));
			}
			// The sources that matter, named for the reading flow ("Kill Aean
			// Swiftriver (rare elite)", "Kill Grell or Grellkin"): the item's
			// game objective only says "Fel Moss: 0/8", so quest objectives get
			// them too. Named only when a single located source has it or one
			// drops it at 50% or more; a second of the same kind at 50% or more
			// is named beside it (`fromAlso`). Not for an item that drops all
			// over the world (cloth: hundreds of droppers, where a guard's 100%
			// says nothing about where to farm it). `fromFaction` lets the
			// engine tell an enemy from a friend of the character's faction.
			// Where normal droppers and elites both drop it, only the normal
			// ones are named, as the arrow leads to them (onMap); so are they
			// where a rare tops the droppers (rareLeads), and the ones near the
			// quest's level where others are far above it (levelSplit).
			const widespread = candidates.filter((s) => s.chance >= 2).length > MAX_NAMED_SOURCES;
			passRares = !widespread && rareLeads(data, candidates, ctx.sides);
			const q = g.quest !== undefined ? data.quest(g.quest) : null;
			if (q && Number(q.level) > 0) dropLevel = Number(q.level);
			const split = eliteSplit(data, candidates, ctx.sides, passRares);
			const normal = split ? split.normal : candidates;
			const level = levelSplit(data, normal, dropLevel);
			const named = level ? level.near : normal;
			if (!widespread && named.length && (candidates.length === 1 || named[0].chance >= 50)) {
				const top = named[0];
				const rec = top.kind === 'npc' ? data.npc(top.id) : data.object(top.id);
				if (rec && rec.name) {
					goal.from = String(rec.name);
					goal.fromId = top.id;
					goal.fromKind = top.kind;
					if (top.kind === 'npc') {
						if (Number(rec.rank) > 0) goal.fromRank = Number(rec.rank);
						if (['A', 'H', 'AH'].includes(rec.faction)) goal.fromFaction = rec.faction;
					}
					const next = named[1];
					const nrec = next && next.kind === top.kind && next.chance >= 50 && (next.kind === 'npc' ? data.npc(next.id) : data.object(next.id));
					if (nrec && nrec.name && String(nrec.name) !== goal.from) {
						goal.fromAlso = String(nrec.name);
						goal.fromAlsoId = next.id;
					}
				}
			}
			// The 50-yard check only compares with real sources: anything dropping the
			// item at 2% or more (a rare boss at 0.2% is not where it is farmed) and
			// gathering nodes at any chance (a gem from a Copper Vein is 1% per node, yet
			// the real source; a chest at 0.5% is not).
			checkKinds = sources.filter((s) => s.chance >= 2 || gatherNode(data, s));
			questFields = true;
			break;
		}
		case 'interact': {
			goal.object = g.object;
			goal.objName = requireName('object', g.object, g.objName, 'Object name') || undefined;
			candidates = [{ kind: 'object', id: g.object }];
			checkKinds = candidates;
			questFields = true;
			break;
		}
		case 'use': {
			goal.item = g.item;
			goal.itemName = requireName('item', g.item, g.itemName, 'Item name') || undefined;
			questFields = true;
			break;
		}
		case 'talk': {
			goal.npc = g.npc;
			goal.npcName = requireName('npc', g.npc, g.npcName, 'NPC name') || undefined;
			candidates = [{ kind: 'npc', id: g.npc }];
			checkKinds = candidates;
			break;
		}
		case 'sethome':
		case 'getfp':
		case 'train':
		case 'vendor': {
			if (g.location !== undefined) goal.location = g.location;
			if (g.location !== undefined && (v === 'sethome' || v === 'getfp')) placeWarning(v, g.location);
			if (v === 'train' && g.profession !== undefined) trainProfession(g, goal, data, ctx, err, warn, smart);
			if (v === 'train' && g.classTrain) {
				goal.class = true;
				const set = applicable(ctx.layers);
				const entries = data
					.classTrainers()
					.map((t) => ({ npc: t.id, classes: t.classes.filter((c) => set.classes.includes(c)) }))
					.filter((e) => e.classes.length);
				smart(goal, entries, `class trainer`);
			}
			if (g.nearest && v === 'sethome') smart(goal, data.npcsWithRole('innkeeper').map((id) => ({ npc: id })), 'innkeeper');
			// A located `sethome` naming no npc: its inn's innkeeper, for the
			// factions the goal applies to, so the arrow leads there (places.js).
			// A located `getfp` naming no npc: its taxi node's flight master,
			// the same way (places.js).
			if ((v === 'sethome' || v === 'getfp') && g.npc === undefined && !g.nearest) {
				const sides = smartSides(ctx.sides, applicable(ctx.layers || []));
				const host = v === 'sethome' ? goalInnkeeper(data, g.location, sides) : goalFlightMaster(data, g.location, sides);
				if (host) {
					goal.npc = host.npc;
					setIf(goal, 'npcName', nameOf(data, 'npc', host.npc) || host.npcName || undefined);
					candidates = [{ kind: 'npc', id: host.npc }];
					checkKinds = candidates;
				}
			}
			// Sell junk and repair: every repairer also buys junk, a plain vendor may not repair.
			if (g.nearest && v === 'vendor') smart(goal, data.npcsWithRole('repair').map((id) => ({ npc: id })), 'repair vendor');
			if (g.npc !== undefined) {
				goal.npc = g.npc;
				if (g.npcName) {
					goal.npcName = g.npcName;
					if (!data.npc(g.npc)) warn(ln, `npc ${g.npc} is not in data; using the explicit name (new Forever content?)`);
				} else if ((v === 'train' || v === 'vendor') && !g.npcExplicit) {
					// `train <npcId> ["Name"]` / `vendor <npcId> ["Name"]` can be named, so a bare unknown id is an error.
					setIf(goal, 'npcName', requireName('npc', g.npc, null, 'NPC name'));
				} else {
					setIf(goal, 'npcName', optionalName('npc', g.npc));
				}
				candidates = [{ kind: 'npc', id: g.npc }];
				checkKinds = candidates;
			}
			break;
		}
		case 'hearth':
		case 'fly':
			goal.location = g.location;
			placeWarning(v, g.location);
			break;
		case 'buy': {
			goal.item = g.item;
			goal.itemName = requireName('item', g.item, g.itemName, 'Item name') || undefined;
			if (g.count !== undefined) goal.count = g.count;
			if (g.npc !== undefined) {
				optionalName('npc', g.npc);
				candidates = [{ kind: 'npc', id: g.npc }];
			} else if (g.nearest) {
				const it = data.item(g.item);
				smart(goal, ((it && it.vendors) || []).map((id) => ({ npc: Number(id) })), `vendor of item ${g.item}`);
			} else {
				const it = data.item(g.item);
				candidates = ((it && it.vendors) || []).slice().sort((a, b) => a - b).map((id) => ({ kind: 'npc', id }));
			}
			checkKinds = candidates;
			break;
		}
		case 'level':
			goal.level = g.level;
			if (g.frac) goal.frac = g.frac;
			break;
		case 'money':
			goal.money = g.money;
			break;
		case 'note':
		case 'task':
			break;
		case 'goto':
			break;
		case 'skill': {
			const p = data.professionNamed(g.skill);
			if (p) {
				goal.skill = String(p.name);
				goal.skillLine = p.id;
			} else if (g.skillQuoted) {
				goal.skill = g.skill;
				warn(ln, `profession "${g.skill}" is not in data${data.hasProfessions ? '' : ' (professions.json missing)'}; using the explicit name (new Forever content?)`);
			} else {
				err(ln, `unknown profession "${g.skill}"; quote the name to use it anyway: \`skill "${g.skill}" ${g.level}\``);
			}
			goal.level = g.level;
			if (goal.skillLine !== undefined) progressOf(ctx, goal.skillLine).target = g.level;
			break;
		}
		case 'learn':
		case 'craft': {
			const found = data.recipe(g.spell);
			const r = found ? found.recipe : null;
			const where = data.hasProfessions ? '' : ' (professions.json missing)';
			goal.spell = g.spell;
			const name = g.spellName || (r && r.name ? String(r.name) : null);
			if (!name) err(ln, `spell ${g.spell} is not in data${where}; give its name: \`${v} ${g.spell} "Name"\``);
			else if (!found) warn(ln, `spell ${g.spell} is not in data${where}; using the explicit name (new Forever content?)`);
			goal.spellName = name || undefined;
			if (found) goal.skillLine = found.profession.id;
			if (v === 'learn') {
				const recipeItem = g.item !== undefined ? g.item : r && Number(r.recipeItem) > 0 ? Number(r.recipeItem) : undefined;
				if (recipeItem !== undefined) {
					goal.item = recipeItem;
					setIf(goal, 'itemName', g.item !== undefined ? optionalName('item', recipeItem) : nameOf(data, 'item', recipeItem));
				}
				if (g.npc !== undefined) {
					goal.npc = g.npc;
					setIf(goal, 'npcName', optionalName('npc', g.npc));
					candidates = [{ kind: 'npc', id: g.npc }];
					checkKinds = candidates;
				} else if (r && (r.source === 'trainer' || !r.source) && recipeItem === undefined && !g.explicitCoords) {
					// Trainer-taught: every trainer of the rank that teaches this skill level,
					// both factions tagged; the engine picks the nearest own-faction one.
					const prof = found.profession;
					const ranks = Array.isArray(prof.ranks) ? prof.ranks : [];
					const at = Number(r.learnedAt) || 0;
					const rank = ranks.find((rk) => rk && rk.trainers && Number(rk.max) >= at);
					const bySide = rank ? rank.trainers : prof.trainers || {};
					const entries = [];
					for (const side of Object.keys(bySide).sort()) {
						const tag = side === 'Alliance' ? 'A' : side === 'Horde' ? 'H' : undefined;
						for (const id of Array.isArray(bySide[side]) ? bySide[side] : []) entries.push({ npc: Number(id), side: tag });
					}
					smart(goal, entries, `${prof.name}${rank && rank.name ? ` ${rank.name}` : ''} trainer`);
				} else if (g.nearest && recipeItem !== undefined) {
					const it = data.item(recipeItem);
					smart(goal, ((it && it.vendors) || []).map((id) => ({ npc: Number(id) })), `vendor of item ${recipeItem}`);
				} else if (g.nearest) {
					err(ln, `\`learn ${g.spell} nearest\`: no trainer or recipe vendor for this spell in data`);
				}
			} else {
				const made = r && Number(r.item) > 0 ? Number(r.item) : null;
				if (made) {
					goal.item = made;
					setIf(goal, 'itemName', nameOf(data, 'item', made));
				}
				// `x<N>` counts crafts; the engine counts created items.
				if (g.count !== undefined) goal.count = g.count * (r && Number(r.itemCount) > 1 ? Number(r.itemCount) : 1);
				if (g.untilSkill !== undefined) {
					goal.untilSkill = g.untilSkill;
					if (found) progressOf(ctx, found.profession.id).target = g.untilSkill;
					if (!found) {
						warn(ln, `\`until\` needs the recipe's profession, but spell ${g.spell} is not in professions.json; the engine cannot check the skill`);
					} else if (Number(r.grey) > 0 && g.untilSkill > Number(r.grey)) {
						warn(ln, `${goal.spellName} turns grey at ${r.grey}; crafting it gives no skill up to ${g.untilSkill}`);
					}
				}
				if (r && Array.isArray(r.reagents) && r.reagents.length) {
					goal.reagents = r.reagents
						.filter((x) => x && Number(x.item) > 0)
						.map((x) => {
							const reagent = { item: Number(x.item) };
							setIf(reagent, 'itemName', nameOf(data, 'item', reagent.item));
							reagent.count = Number(x.count) > 0 ? Number(x.count) : 1;
							return reagent;
						});
				}
			}
			break;
		}
		case 'rep': {
			const where = data.hasFactions ? '' : ' (factions.json missing)';
			if (g.factionId !== undefined) {
				const f = data.faction(g.factionId);
				goal.faction = g.factionId;
				const name = g.factionName || (f && f.name ? String(f.name) : null);
				if (!name) err(ln, `faction ${g.factionId} is not in data${where}; give its name: \`rep ${g.factionId} "Name" <Standing>\``);
				else if (!f) warn(ln, `faction ${g.factionId} is not in data${where}; using the explicit name (new Forever content?)`);
				goal.factionName = name || undefined;
			} else {
				const found = data.factionNamed(g.factionName);
				if (found) {
					goal.faction = found.faction.id;
					goal.factionName = String(found.faction.name);
					if (found.ambiguous) {
						warn(ln, `faction "${g.factionName}" matches ids ${found.ambiguous.map((f) => f.id).join(', ')}; using ${found.faction.id} (write \`rep <factionId> <Standing>\` to choose)`);
					}
				} else {
					// The engine tracks reputation by faction id, so a name alone cannot work.
					goal.factionName = g.factionName;
					err(ln, `unknown faction "${g.factionName}"${where}; give its id with the name: \`rep <factionId> "${g.factionName}" <Standing>\``);
				}
			}
			goal.standing = g.standing;
			break;
		}
		case 'explore':
			break;
		case 'achieve':
			goal.achievement = g.achievement;
			// No achievement data exists, so the name always comes from the guide.
			if (!g.achievementName) err(ln, `achievement ${g.achievement} has no reference data; give its name: \`achieve ${g.achievement} "Name"\``);
			goal.achievementName = g.achievementName;
			if (g.criteria !== undefined) goal.criteria = g.criteria;
			break;
	}

	if (questFields && g.quest !== undefined) {
		const q = data.quest(g.quest);
		goal.quest = g.quest;
		if (q && q.title) goal.title = String(q.title);
		let oi = g.oi;
		if (q && Array.isArray(q.objectives)) {
			// "7.1 = kill Kobold Vermin x10, 7.2 = ...": what `quest Q.O` can name.
			const listed = () => data.questObjectives(g.quest).map((o) => objectiveLabel(g.quest, o)).join(', ');
			if (oi !== undefined && oi > q.objectives.length) {
				warn(
					ln,
					`quest ${g.quest} has ${q.objectives.length} objective(s) in data, not ${oi}${q.objectives.length ? `: ${listed()}` : ''}`,
					q.objectives.length ? `write \`quest ${g.quest}.<n>\` with one of these (\`polestar find ${g.quest}\` lists them)` : `drop the \`.${oi}\`: write \`quest ${g.quest}\``,
				);
			}
			const kind = v === 'kill' ? 'kill' : v === 'collect' ? 'item' : v === 'interact' ? 'object' : null;
			const id = v === 'kill' ? g.npc : v === 'interact' ? g.object : g.item;
			// `quest Q.O` naming an objective of the same kind for another
			// target: progress and count would follow that one. When the target
			// is another objective of the quest, the index is swapped, which is
			// always wrong: an error (#214 shipped two that a warning let pass).
			// An item the quest uses without counting it (Sunscale Feather on the
			// Scytheclaw nests, the Fresh Zhevra Carcass that lures Ishamuhale,
			// #538): no line of the quest log counts it, so only the bags can say
			// it is there.
			const used = v === 'collect' && id !== undefined && ((q.requiredItems || []).includes(id) || q.sourceItem === id);
			const bagHint = `the quest uses item ${id} without counting it: drop \`quest ${g.quest}${oi !== undefined ? `.${oi}` : ''}\` so the step counts it in the bags`;
			const named = oi !== undefined && kind && id !== undefined ? data.questObjectives(g.quest)[oi - 1] : null;
			if (named && named.kind === kind && named.id != null && named.id !== id) {
				const right = objectiveFor(q, kind, id);
				const noun = v === 'kill' ? 'npc' : v === 'interact' ? 'object' : 'item';
				const own = right ? data.questObjectives(g.quest)[right - 1] : null;
				(right ? err : warn)(
					ln,
					`${objectiveLabel(g.quest, named).replace(/^(\S+) = /, 'quest $1 is ')}, not this ${noun}${own ? `; ${own.name || `${noun} ${id}`} is ${g.quest}.${right}` : ''}`,
					right ? `write \`quest ${g.quest}.${right}\`, or \`quest ${g.quest}\` to take the index from the ${noun}` : used ? bagHint : `its objectives: ${listed()}`,
				);
			}
			if (named && v === 'collect' && named.kind !== 'item') {
				const right = objectiveFor(q, 'item', id);
				warn(ln, `${objectiveLabel(g.quest, named).replace(/^(\S+) = /, 'quest $1 is ')}, not an item`, right ? `write \`quest ${g.quest}.${right}\`, or \`quest ${g.quest}\` to take the index from the item` : used ? bagHint : `its objectives: ${listed()}`);
			}
			if (oi === undefined) {
				if (id !== undefined) oi = objectiveFor(q, kind, id) || undefined;
				if (oi === undefined && q.objectives.length) {
					warn(ln, `quest ${g.quest} has no objective for this ${v === 'kill' ? 'npc' : v === 'interact' ? 'object' : 'item'}${used ? '' : `; write \`quest ${g.quest}.<objective>\``}`, used ? bagHint : `its objectives: ${listed()}`);
				}
			}
			if (oi !== undefined && g.count === undefined && (v === 'kill' || v === 'collect')) {
				const o = q.objectives[oi - 1];
				if (o && Number(o.count) > 0) goal.count = Number(o.count);
			}
		} else if (!q) {
			warn(ln, `quest ${g.quest} is not in data; objective index and count cannot be filled`);
		}
		if (oi !== undefined) goal.oi = oi;
	}
	if ((v === 'kill' || v === 'collect') && g.count !== undefined) goal.count = g.count;
	// A quest only characters with a profession can take (quests.json `skill`
	// and `skillLevel`, rank 1 when the level is unknown): every goal of it is
	// for them only, as another class's goals are not this character's.
	if (goal.quest !== undefined) {
		const q = data.quest(goal.quest);
		const line = q ? Number(q.skill) : 0;
		if (Number.isInteger(line) && line > 0) {
			const p = data.profession(line);
			goal.profLine = line;
			setIf(goal, 'profName', p && p.name ? String(p.name) : undefined);
			goal.profRank = Number(q.skillLevel) > 0 ? Number(q.skillLevel) : 1;
		}
	}

	// Explicit display text, note, flags.
	if (g.text !== undefined) goal.text = g.text;

	// Coordinates.
	const map = g.coordMap !== undefined ? g.coordMap : zoneMap;
	if (g.explicitCoords) {
		if (g.x < 0 || g.x > 100 || g.y < 0 || g.y > 100) {
			err(ln, `coordinates ${g.x},${g.y} are outside 0-100`);
		} else if (map == null) {
			err(ln, 'coordinates need a zone (`zone` in the header or step, or `map <uiMapID>`)');
		} else {
			goal.map = map;
			goal.x = round2(g.x);
			goal.y = round2(g.y);
			// Hand-typed coordinates are Era-frame unless the guide or goal says `live`.
			// A map with no Era bounds has no Era frame to be in (new Forever zones).
			const frame = ctx.frame || { frame: 'era', explicit: false };
			const hasEra = !!data.eraFrame(map);
			const anyFrames = Object.keys(data.mapFrames.era || {}).length > 0;
			if (frame.frame === 'era' && (hasEra || !anyFrames)) goal.f = 'e';
			else if (frame.frame === 'era' && frame.explicit) {
				warn(ln, `\`era\` coordinates on map ${map}, but map-frames.json has no Era bounds for it; compiling them as live-frame`);
			}
			if (checkKinds && checkKinds.length) checkNear(data, checkKinds, map, goal.x, goal.y, goal.f === 'e' ? 'e' : 'l', ln, warn);
		}
	}
	if (g.frame && !g.explicitCoords) err(ln, `\`${g.frame}\` only applies to explicit coordinates (@x,y)`);
	if (g.explicitCoords && (g.nearest || g.classTrain || (g.profession !== undefined && g.npc === undefined))) {
		err(ln, 'smart targets pick their NPC and position at runtime; drop the coordinates, or name an npc id');
	}
	// A collect's droppers: the normal ones over elites beside them, the ones
	// near its quest's level over those far above it (onMap).
	const dropSides = v === 'collect' ? ctx.sides : undefined;
	const picked = pickSpawn(data, candidates, map, prev, { usedMaps: ctx.usedMaps, sides: dropSides, rares: passRares, qlvl: dropLevel });
	if (picked) {
		const c = picked.cand;
		if (v === 'accept' || v === 'turnin') {
			if (c.kind === 'npc') {
				goal.npc = c.id;
				setIf(goal, 'npcName', nameOf(data, 'npc', c.id));
			} else {
				goal.object = c.id;
				setIf(goal, 'objName', nameOf(data, 'object', c.id));
			}
		} else if (v === 'buy') {
			goal.npc = c.id;
			setIf(goal, 'npcName', nameOf(data, 'npc', c.id));
		}
		if (!g.explicitCoords && picked.x !== undefined) {
			goal.map = picked.map;
			goal.x = picked.x;
			goal.y = picked.y;
			if (picked.f) {
				// An Era point is only usable with that map's Era bounds; without them
				// the client reads it as live-frame, so say so and emit it that way.
				const anyFrames = Object.keys(data.mapFrames.era || {}).length > 0;
				if (data.eraFrame(picked.map) || !anyFrames) goal.f = picked.f;
				else warn(ln, `Era-frame coordinates on map ${picked.map}, but map-frames.json has no Era bounds for it; compiled as live-frame`);
			}
		}
		// Every place the target spawns, so a player who finds nothing where
		// the arrow led can move it on to the others (spawnSpots). Kill,
		// collect and interact goals may be area objectives (`spread`, searched
		// spot by spot); the others go to the nearest place.
		const area = v === 'kill' || v === 'collect' || v === 'interact';
		if (!g.explicitCoords && picked.x !== undefined) {
			const sp = spawnSpots(data, area ? picked.sources || [c] : [c], picked.map, picked.f, picked.x, picked.y, area ? picked.elites : undefined);
			if (sp) {
				goal.spots = sp.spots;
				if (sp.spread && area) goal.spread = true;
				if (sp.at) {
					goal.x = sp.at.x;
					goal.y = sp.at.y;
				}
			}
			// An authored `npc` already names the one creature to target.
			if (v === 'collect' && goal.npc === undefined) setIf(goal, 'fromNpcs', sourceNpcs(data, c, picked.sources));
		} else if (g.explicitCoords && goal.x !== undefined) {
			// Hand-placed: the sources known to give the item (a drop chance, or a
			// gathering node; not loot of unknown odds). A mob or object spawns
			// around a farming point (SPREAD_YARDS); one NPC more than
			// SPAWN_CHECK_YARDS away has moved (the lint's own threshold).
			// Gathering nodes respawn over the zone's whole pool, so a route's
			// point anywhere in it lists every node place.
			const known = area ? candidates.filter((s) => s.chance === undefined || s.chance > 0 || gatherNode(data, s)) : [c];
			const all = known.map((cand) => ({ cand, spawns: data.spawns(cand.kind, cand.id) }));
			const sources = onMap(data, all, goal.map, dropSides, passRares, dropLevel).on.map((o) => o.cand);
			const near = !area ? SPAWN_CHECK_YARDS : sources.length && sources.every((s) => gatherNode(data, s)) ? Infinity : SPREAD_YARDS;
			setIf(goal, 'spots', handSpots(data, sources, goal.map, goal.f, goal.x, goal.y, near));
			if (v === 'collect' && goal.npc === undefined) {
				const own = pointSources(data, sources, goal.map, goal.f, goal.x, goal.y, near);
				setIf(goal, 'fromNpcs', sourceNpcs(data, own[0], own));
			}
		}
	}
	if (g.r !== undefined) goal.r = g.r;
	if (g.optional) goal.optional = true;
	// `turnin ... direct`: handed in from the giver's window with no accept;
	// its quest's level, as an accept's, for the engine's grey-quest skipping.
	if (g.direct) {
		goal.direct = true;
		const q = goal.quest !== undefined ? data.quest(goal.quest) : null;
		if (q && Number(q.level) > 0) goal.qlvl = Number(q.level);
	}
	// Group content (group.js): the author's `group [N]`, else derived.
	setIf(goal, 'group', groupOf(goal, g.group, ctx.sides, data));
	// An escort quest's accept and objectives (escort.js).
	setIf(goal, 'escort', escortOf(goal, data));
	setIf(goal, 'only', onlyOf(g.only));
	setIf(goal, 'note', g.note);
	// The height of the NPC or object the goal's point stands for, and of each
	// of its spawn spots (heights.js).
	setIf(goal, 'z', goalHeight(data, goal));
	for (const s of goal.spots || []) setIf(s, 'z', spotHeight(data, goal, s));
	// The area its place name stands for, and a getfp's or fly's taxi node
	// (places.js), for the factions its races can be (a Tauren-only step: Horde).
	setIf(goal, 'area', goalArea(data, goal));
	setIf(goal, 'node', goalNode(data, goal, smartSides(ctx.sides, applicable(ctx.layers || []))));

	// A `loop` step's gotos place its kill, collect and interact goals (applyLoop).
	if ((v === 'kill' || v === 'collect' || v === 'interact' || v === 'use') && goal.x === undefined && !goal.candidates && !g.nearest && !(ctx.loop && LOOP_VERBS.has(v))) {
		warn(ln, `\`${v}\` has no coordinates (no known spawns; add @x,y)`, 'add @x,y where the player finds the target (the map coordinates the game shows), so the arrow can lead there');
	}
	return goal;
}

// Warn when explicit coordinates are far from every known spawn (the capped-out
// ones too). Only spawns recorded in the same map frame (`frame`: "e" | "l")
// are comparable.
function checkNear(data, kinds, map, x, y, frame, ln, warn) {
	let any = false;
	let onMap = false;
	let otherFrame = false;
	for (const k of kinds) {
		for (const s of data.spawns(k.kind, k.id)) {
			any = true;
			if (s.map !== map) continue;
			if ((s.f === 'l' ? 'l' : 'e') !== frame) {
				otherFrame = true;
				continue;
			}
			onMap = true;
			if (!data.mapSize(map)) return; // cannot measure yards on this map
			for (const p of [...s.pts, ...s.more]) if (distance(data, map, p[0], p[1], x, y) <= SPAWN_CHECK_YARDS) return;
		}
	}
	if (!any) return;
	if (!onMap && otherFrame) return; // known spawns on this map are in the other frame: not comparable
	const what = kinds.length === 1 ? `${kinds[0].kind} ${kinds[0].id}` : 'the target';
	const look = kinds.length === 1 ? `\`polestar find ${kinds[0].id} --kind ${kinds[0].kind}\`` : '`polestar find <id>`';
	const hint = `${look} prints a known spawn: check the coordinates against it, or keep them when the target stands elsewhere in Forever`;
	if (!onMap) warn(ln, `explicit coordinates ${x},${y}: ${what} has no known spawn on map ${map}`, hint);
	else warn(ln, `explicit coordinates ${x},${y} are more than ${SPAWN_CHECK_YARDS} yards from every known spawn of ${what}`, hint);
}

module.exports = { resolveGuide, pickSpawn, round2 };
