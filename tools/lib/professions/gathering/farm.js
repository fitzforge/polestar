'use strict';
// Farming loops for the Herbalism, Mining and Skinning bands: a short round through the densest ground
// of a zone that a character of the round's level can work safely, built with loop.js.
//
// farm(ctx, prof, map, points, { faction, respawn, level }) -> { stops, lap, level, gain, up, on, score }
// or null. `level`: the character level the band is planned for (skillLevel).
//   points: the band's node or beast points (route points with `w`, `up`, `name`, `req`).
//   1. Each point asks a character level (loop.js pointLevels: the highest creature within its aggro
//      ground minus one, so never a mob two or more levels above you; a point by a town of the other
//      faction is never safe). A beast to skin is a creature of the point itself: its level counts.
//      A loop asks the highest level along its whole walk (loop.js roundLevel), and one that passes a
//      town of the other faction is never taken.
//   2. For each level a point asks (lowest first), the points safe at that level are clustered
//      (`prof.radius` yards) and turned into loops of up to MAX_STOPS stops within each of SPANS
//      yards of the heaviest cluster (loop.js buildLoop).
//   3. A loop's worth: the nodes up at once within CORRIDOR yards of its round (`gain`: weighted by the
//      band's skill-up chances) per yard of a lap, where a lap costs its walk plus `prof.stopYards` per
//      node gathered (or beast killed and skinned), and never less than the walk of the kind's
//      respawn time (a faster round finds the nodes it took still gone).
//   4. The loop kept is the one with the best worth discounted by LEVEL_DECAY per level it asks above
//      the planned level (rankScore), the lowest level on a tie: lower is better, and a loop that asks
//      more must be that much better to win. Zones are ranked by the same number.
// skillLevel(skill): the character level a band is planned for, a fifth of the skill and at least 5
// (ASSUMED: a character levelling with the profession; the ranks ask no level; any starting area's
// creatures are level 5 or below).

const { segDist } = require('../../route/geo');
const { buildLoop, pointLevels, roundLevel } = require('./loop');
const { weightedClusters } = require('./route');
const { ZONES } = require('./tables');

// Loop sizes tried: a camp's worth up to most of a zone (sparse veins: a lap shorter than their respawn
// only waits for them).
const SPANS = [250, 400, 600, 900, 1400, 2000];
const MAX_STOPS = 12;
// Running speed, yards per second.
const RUN = 7;
// Worth kept per level a loop asks above the band's planned character level: a loop two levels above
// must be nearly twice as good to win, four levels above three times.
const LEVEL_DECAY = 0.75;
// A loop of fewer stops is only taken when no level gives one this long.
const MIN_STOPS = 3;

function skillLevel(skill) {
	return Math.max(5, Math.round(skill / 5));
}

function up(p) {
	return p.up === undefined ? 1 : p.up;
}

// Yards from `pt` to the closed round through `stops`.
function toRound(pt, stops) {
	if (stops.length === 1) return segDist(pt, stops[0].pt, stops[0].pt);
	let best = Infinity;
	for (let i = 0; i < stops.length; i++) best = Math.min(best, segDist(pt, stops[i].pt, stops[(i + 1) % stops.length].pt));
	return best;
}

// The worth of one loop over `open` points; `on`: the points within `corridor` of its round.
function worth(loop, open, { corridor, stopYards, respawnYards }) {
	let gain = 0;
	let n = 0;
	const on = [];
	for (const p of open) {
		if (toRound(p.pt, loop.stops) > corridor) continue;
		gain += p.w;
		n += up(p);
		on.push(p);
	}
	const walk = Math.max(loop.lap, respawnYards);
	return { gain, up: n, on, score: gain / (walk + stopYards * n) };
}

// A zone's own level (tables.js ZONES min) is the least a loop there asks: a round whose stops have no
// hostile creature in aggro range (a friendly town's shore, Revantusk's coast in the Hinterlands, the
// Riverglades with no world-DB spawns) still walks a character through the zone's creatures on the way
// in. Without it such loops read "lvl 2" and were offered to characters of 10-20 in zones of 40-50.
function floorOf(map) {
	return (ZONES[map] && ZONES[map].min) || 1;
}

// Memoised per points array (one per band part, zone and faction).
const memo = new WeakMap();
function farm(ctx, prof, map, points, { faction = null, respawn = 300, level: planned = 60 } = {}) {
	if (!points.length) return null;
	const key = `${map}|${faction}|${respawn}|${planned}`;
	let byKey = memo.get(points);
	if (!byKey) memo.set(points, (byKey = new Map()));
	if (byKey.has(key)) return byKey.get(key);
	const radius = prof.radius || 60;
	const opts = { corridor: radius, stopYards: prof.stopYards || 0, respawnYards: respawn * RUN };
	const levels = pointLevels(ctx, map, points, faction);
	const asks = [...new Set(levels.filter((l) => l !== null && l <= 60))].sort((a, b) => a - b);
	const found = [];
	for (const level of asks) {
		const open = points.filter((p, i) => levels[i] !== null && levels[i] <= level);
		if (open.length < 2) continue;
		const clusters = weightedClusters(open, radius, ctx.project);
		for (const span of SPANS) {
			const loop = buildLoop(open, ctx.project, { radius, span, cover: 1, maxStops: MAX_STOPS, clusters });
			// `prof.maxLap` (yards): past it the round never comes back to what respawned (Skinning).
			if (loop.stops.length < 2 || loop.lap > (prof.maxLap || Infinity)) continue;
			const walk = roundLevel(ctx, map, loop.stops, faction);
			if (walk === null) continue;
			found.push({ ...loop, ...worth(loop, open, opts), level: Math.max(level, walk, floorOf(map)), span, respawn });
		}
	}
	const long = found.filter((f) => f.stops.length >= MIN_STOPS);
	const pool = long.length ? long : found;
	if (!pool.length) {
		byKey.set(key, null);
		return null;
	}
	let pick = pool[0];
	for (const f of pool) if (rankScore(f, planned) > rankScore(pick, planned) * (1 + 1e-9)) pick = f;
	byKey.set(key, pick);
	return pick;
}

// A farm's worth for ranking zones in a band planned for character level `level`.
function rankScore(f, level) {
	return f ? f.score * LEVEL_DECAY ** Math.max(0, f.level - level) : 0;
}

module.exports = { farm, rankScore, skillLevel, toRound, SPANS, MAX_STOPS, RUN, LEVEL_DECAY };
