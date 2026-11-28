'use strict';
// Farming loops: a short round of places the arrow walks and repeats, for a gathering band (fishing
// stands, and the herb, ore and skinning rounds next). A guide writes one as a `loop` step
// (docs/GUIDE_FORMAT.md, "Spawn areas", Loop): its gotos, in this order, are the places of its goal.
//
// buildLoop(points, project, opts) -> { stops, lap }
//   points: [{ pt, w, name? }]: world points (route.js projector) with a weight (what a visit is worth).
//   1. Points inside `avoid` ([{ pt, yards }]: hazards below) are dropped.
//   2. The rest become weighted clusters of `radius` yards (route.js weightedClusters).
//   3. Stops: the head (the heaviest cluster, or with `head` the head-th heaviest, from 0), then the next
//      heaviest within `span` yards of it (one water or one stretch of hills, never a tour of the zone), until
//      they hold `cover` of that ground's weight or there are `maxStops`.
//   4. Order: a closed tour from the stop nearest `entry` (else the heaviest): nearest neighbour, then
//      2-opt (route/tour.js planTour).
//   `lap` is the closed tour's length in yards. `clusters`: step 2's clusters of these points, when the
//   caller already has them (several spans over one ground); `avoid` is then not applied.
//
// hazards(ctx, map, { level, faction, strict }) -> avoid list: every spawn on `map` of a hostile creature more
// than ABOVE levels above `level` (MOB_YARDS of aggro ground: Polestar's level bar, never a solo player at
// mobs 2+ levels above), every hostile elite (never a solo player's ground at any level), and every spawn of
// an NPC of the other faction's towns (ENEMY_YARDS). `strict` (the fishing rounds): an elite counts ELITE
// levels higher where it stands farther off, and the other faction's guard posts count as towns.
// pointLevels / levelFor: the character level a point (or `need` of them) asks by the same rule.
// threats(ctx, map, stops, level) -> how many hostile creature spawns stand within MOB_YARDS of a stop and
// are not grey to a player of `level` (they would fight the player there).
//
// The safety rule (levelAt): a place asks the lowest character level at which no hostile creature that can
// reach it is more than ABOVE levels above the player. Within MOB_YARDS every creature can; out to
// FAR_YARDS one far above the player still can, as a creature's aggro reach grows a yard for every level it
// is above the player (AGGRO_YARDS at the player's level): it asks the level that puts the place out of its
// reach. A hostile elite within MOB_YARDS makes the place unsafe at every level (null).

const { dist } = require('../../route/geo');
const { planTour, pathLength } = require('../../route/tour');
const { weightedClusters, allPoints } = require('./route');

const ABOVE = 1;
const MOB_YARDS = 30;
const FAR_YARDS = 45;
const AGGRO_YARDS = 20;
const ENEMY_YARDS = 150;
const SIDE = { Alliance: 'A', Horde: 'H' };
// An elite (Blizzard rank 1) or boss (3) hits like a creature this many levels above its own.
const ELITE = new Set([1, 3]);
const ELITE_LEVELS = 3;
// A guard: an NPC of a side at GUARD_LEVEL or above with GUARD_SPAWNS spawns or more on the map (a post or
// a patrol), a hazard to the other side on its own, town or not; one NPC of that level standing alone (a
// quest giver, a festival keeper) is none.
const GUARD_LEVEL = 50;
const GUARD_SPAWNS = 3;
// A creature this many levels or more below the player is grey: it leaves the player alone.
const GREY = 6;

function buildLoop(points, project, { radius = 30, span = 250, cover = 0.9, maxStops = 6, entry = null, avoid = [], clusters = null, head: headAt = 0 } = {}) {
	const open = clusters ? points : points.filter((p) => !avoid.some((a) => dist(a.pt, p.pt) < a.yards));
	if (!open.length) return { stops: [], lap: 0 };
	const cl = clusters || weightedClusters(open, radius, project);
	const head = cl[headAt] || cl[0];
	const ground = [head, ...cl.filter((c) => c !== head && dist(head.pt, c.pt) <= span)];
	const total = ground.reduce((s, c) => s + c.w, 0);
	const keep = [];
	let acc = 0;
	for (const c of ground) {
		if (keep.length >= maxStops || (keep.length >= 2 && acc >= cover * total)) break;
		keep.push(c);
		acc += c.w;
	}
	let first = keep[0];
	if (entry) for (const c of keep) if (dist(entry, c.pt) < dist(entry, first.pt)) first = c;
	const rest = planTour(first.pt, keep.filter((c) => c !== first), first.pt);
	const stops = [first, ...rest];
	return { stops, lap: stops.length > 1 ? pathLength(first.pt, rest, first.pt) : 0 };
}

// Per data object: map -> [{ pt, level, faction, town }] for every spawn on the map of an NPC of a side,
// and of every creature without a side that drops something (items.json: one players kill; a messenger
// or emissary friendly to all drops nothing) other than a rare, but no service NPC. A creature whose levels span more than
// SCALING levels scales to the player: its lowest level counts; an elite's counts ELITE_LEVELS higher. `town`:
// an NPC of a side with at least TOWN_MATES other kinds of NPC of its side within ENEMY_YARDS (a town or
// a guard post; the festival keepers the seasonal events put by a lake or in the other side's capital are
// none), or a guard (GUARD_LEVEL, GUARD_SPAWNS).
const SERVICE = new Set(['vendor', 'innkeeper', 'repair', 'flightmaster', 'banker', 'stablemaster', 'auctioneer', 'battlemaster', 'spirithealer', 'trainer', 'questgiver']);
const TOWN_MATES = 2;
const SCALING = 5;
const MAX_LEVEL = 63;
// Rare creatures (Blizzard ranks 2 rare elite, 4 rare) come and go; the round does not move for them.
const RARE = new Set([2, 4]);
// Per data object: the ids of the NPCs some item drops from.
const killCache = new WeakMap();
function killable(data) {
	if (!killCache.has(data)) {
		const ids = new Set();
		for (const it of Object.values(data.items || {})) for (const id of Object.keys((it && it.drops && it.drops.npc) || {})) ids.add(Number(id));
		killCache.set(data, ids);
	}
	return killCache.get(data);
}
const spawnCache = new WeakMap();
// `strict`: an elite's level counts ELITE_LEVELS higher and a guard of a side is a town on its own (the fishing
// rounds); without it the herb, ore and skinning loops keep the plain rule.
function mapSpawns(ctx, map, strict = false) {
	let byMap = spawnCache.get(ctx.data);
	if (!byMap) spawnCache.set(ctx.data, (byMap = new Map()));
	const key = `${map}|${strict ? 1 : 0}`;
	if (!byMap.has(key)) {
		const kills = killable(ctx.data);
		const out = [];
		for (const n of Object.values(ctx.data.npcs)) {
			const s = n && n.spawns && n.spawns[String(map)];
			if (!s || (!n.faction && Array.isArray(n.roles) && n.roles.some((r) => SERVICE.has(r)))) continue;
			if (!n.faction && (!kills.has(Number(n.id)) || RARE.has(n.rank))) continue;
			const lo = Number(n.level) || 0;
			// Level 9999 (9000-9999) is the data's placeholder for event creatures that scale (Ashenvale's
			// battle NPCs): no level to go by, so a hostile one asks none ("Ashenvale lvl 9999"); one of a
			// side still marks its camp.
			if (!n.faction && lo > MAX_LEVEL) continue;
			const hi = Math.min(MAX_LEVEL, Math.max(lo, Number(n.levelMax) || 0));
			const level = (hi - lo > SCALING ? lo : hi) + (strict && !n.faction && ELITE.has(n.rank) ? ELITE_LEVELS : 0);
			const pts = allPoints(s);
			const guard = strict && (n.faction === 'A' || n.faction === 'H') && lo >= GUARD_LEVEL && pts.length >= GUARD_SPAWNS && !(Array.isArray(n.roles) && n.roles.some((r) => SERVICE.has(r)));
			for (const [x, y] of pts) out.push({ id: n.id, pt: ctx.project.point(map, x, y, s.f), level, faction: n.faction || null, guard, elite: !n.faction && ELITE.has(n.rank) });
		}
		for (const s of out) {
			if (s.faction !== 'A' && s.faction !== 'H') continue;
			const mates = new Set();
			for (const o of out) if (o.id !== s.id && o.faction === s.faction && dist(o.pt, s.pt) < ENEMY_YARDS && mates.add(o.id).size >= TOWN_MATES) break;
			s.town = s.guard || mates.size >= TOWN_MATES;
		}
		byMap.set(key, out);
	}
	return byMap.get(key);
}

function hazards(ctx, map, { level = 60, faction = null, strict = false } = {}) {
	const other = faction ? (SIDE[faction] === 'A' ? 'H' : 'A') : null;
	const out = [];
	for (const s of mapSpawns(ctx, map, strict)) {
		if (other && s.faction === other && s.town) out.push({ pt: s.pt, yards: ENEMY_YARDS });
		else if (!s.faction && (s.level > level + ABOVE || s.elite)) out.push({ pt: s.pt, yards: MOB_YARDS });
	}
	return out;
}

// The spawns of `map` by ENEMY_YARDS grid cell (every spawn within ENEMY_YARDS of a point lies in its
// cell or the eight around it).
const gridCache = new WeakMap();
function spawnGrid(ctx, map, strict = false) {
	let byMap = gridCache.get(ctx.data);
	if (!byMap) gridCache.set(ctx.data, (byMap = new Map()));
	const key = `${map}|${strict ? 1 : 0}`;
	if (!byMap.has(key)) {
		const grid = new Map();
		for (const s of mapSpawns(ctx, map, strict)) {
			const k = `${s.pt.c}|${Math.floor(s.pt.wx / ENEMY_YARDS)}|${Math.floor(s.pt.wy / ENEMY_YARDS)}`;
			if (!grid.has(k)) grid.set(k, []);
			grid.get(k).push(s);
		}
		byMap.set(key, grid);
	}
	return byMap.get(key);
}

// The level a place asks (pointLevels) from the map's spawn grid (the safety rule above), or null.
function levelAt(grid, pt, other) {
	let top = 1;
	const gx = Math.floor(pt.wx / ENEMY_YARDS);
	const gy = Math.floor(pt.wy / ENEMY_YARDS);
	for (let dx = -1; dx <= 1; dx++) {
		for (let dy = -1; dy <= 1; dy++) {
			for (const s of grid.get(`${pt.c}|${gx + dx}|${gy + dy}`) || []) {
				const d = dist(s.pt, pt);
				if (other && s.faction === other && s.town && d < ENEMY_YARDS) return null;
				if (s.faction || d >= FAR_YARDS) continue;
				if (d < MOB_YARDS) {
					if (s.elite) return null;
					top = Math.max(top, s.level - ABOVE);
				} else top = Math.max(top, Math.ceil(s.level + AGGRO_YARDS - d));
			}
		}
	}
	return top;
}

// The level each point asks (levelAt: no hostile creature that can reach it more than ABOVE levels above
// the player, no elite within MOB_YARDS), or null for a point by an elite or within ENEMY_YARDS of the
// other faction (never safe).
function pointLevels(ctx, map, points, faction = null, { strict = false } = {}) {
	const other = faction ? (SIDE[faction] === 'A' ? 'H' : 'A') : null;
	const grid = spawnGrid(ctx, map, strict);
	return points.map((p) => levelAt(grid, p.pt, other));
}

// The level a closed round through `stops` asks along its whole walk, sampled every `step` yards
// (pointLevels' rule), or null when it passes an elite or within ENEMY_YARDS of the other faction's town.
// Each leg's level is kept per data object, map and side (the planner tries many rounds over the same legs).
const legCache = new WeakMap();
function roundLevel(ctx, map, stops, faction = null, { step = 15, strict = false } = {}) {
	const other = faction ? (SIDE[faction] === 'A' ? 'H' : 'A') : null;
	const grid = spawnGrid(ctx, map, strict);
	let byData = legCache.get(ctx.data);
	if (!byData) legCache.set(ctx.data, (byData = new Map()));
	const ck = `${map}|${strict ? 1 : 0}|${other}|${step}`;
	let legs = byData.get(ck);
	if (!legs) byData.set(ck, (legs = new Map()));
	let top = 1;
	for (let i = 0; i < stops.length; i++) {
		const a = stops[i].pt;
		const b = stops[(i + 1) % stops.length].pt;
		const key = `${a.c}|${a.wx}|${a.wy}|${b.wx}|${b.wy}`;
		let leg = legs.get(key);
		if (leg === undefined) {
			leg = 1;
			const n = Math.max(1, Math.ceil(dist(a, b) / step));
			for (let k = 0; k < n; k++) {
				const t = k / n;
				const l = levelAt(grid, { c: a.c, wx: a.wx + (b.wx - a.wx) * t, wy: a.wy + (b.wy - a.wy) * t }, other);
				if (l === null) {
					leg = null;
					break;
				}
				if (l > leg) leg = l;
			}
			legs.set(key, leg);
		}
		if (leg === null) return null;
		if (leg > top) top = leg;
	}
	return top;
}

// The lowest character level, at least `min`, at which `need` of `points` are safe (pointLevels), or
// null when fewer than `need` ever are.
function levelFor(ctx, map, points, { faction = null, min = 1, need = 1, strict = false } = {}) {
	const lv = pointLevels(ctx, map, points, faction, { strict })
		.filter((l) => l !== null)
		.sort((a, b) => a - b);
	return lv.length >= need ? Math.max(min, lv[need - 1]) : null;
}

// The hostile creature spawns within MOB_YARDS of a stop that are not grey to a player of `level`, each
// counted once (elites at their strict level).
function threats(ctx, map, stops, level) {
	const grid = spawnGrid(ctx, map, true);
	const seen = new Set();
	for (const st of stops) {
		const gx = Math.floor(st.pt.wx / ENEMY_YARDS);
		const gy = Math.floor(st.pt.wy / ENEMY_YARDS);
		for (let dx = -1; dx <= 1; dx++) {
			for (let dy = -1; dy <= 1; dy++) {
				for (const s of grid.get(`${st.pt.c}|${gx + dx}|${gy + dy}`) || []) {
					if (!s.faction && s.level > level - GREY && dist(s.pt, st.pt) < MOB_YARDS) seen.add(s);
				}
			}
		}
	}
	return seen.size;
}

module.exports = { buildLoop, hazards, pointLevels, roundLevel, levelFor, threats, ABOVE, MOB_YARDS, FAR_YARDS, ENEMY_YARDS };
