'use strict';
// Builds the six generated profession guides (Mining, Herbalism, Skinning,
// Fishing, Cooking, First Aid) from their specs (specs.js) and the reference
// data:
//
//   node tools/polestar.js profession gathering build    # rewrite guides/forever/professions/<those>.guide
//   node tools/polestar.js profession gathering check    # exit 1 when a guide is out of date
//
// Herbalism, Mining and Skinning: each skill range is one step whose skill goal
// carries several gathering areas (`area <zone> "<name>" …`, docs/GUIDE_FORMAT.md
// "Gathering areas"); the engine picks one where the player is (travel plus the
// time the rest takes there, never creatures 2+ levels above them while another
// area is not). The areas offered are the best few of every zone a faction may
// use (areas.js: subzones and stretches of open ground with the most nodes up
// per yard of a sweep at a safe level), for a character at the range's start
// and at its end, plus each race's own zone for the first ranges and the best
// of each continent. A range splits where a common herb first becomes pickable
// inside it (#2892). Trainers and the tool vendor are smart targets
// (`train <Profession> <Rank>`, `buy … nearest`): the engine picks the nearest
// one of the player's faction at runtime.

const fs = require('node:fs');
const path = require('node:path');
const { ZONES, RANKS, color, bandWeight } = require('./tables');
const { RACE_GROUPS, REGIONS, SIDE, maxZoneLevel, raceCondition } = require('./groups');
const N = require('./nodes');
const { areasIn, rankScore, skillLevel, sweepSeconds } = require('./areas');
const { OUT_DIR, GUIDE_HEADER, FACTIONS, fmt, money, zoneName, rankInfo } = require('./common');
const { byBanners } = require('../sections');

// ------------------------------------------------------------------ planning

function continentOf(ctx, map) {
	const f = ctx.data.eraFrame(map);
	return f ? f.c : (ctx.project.bounds(map) || {}).c;
}

// The zones a faction may farm a range in: those of its side whose creatures
// start low enough for the range's skill (maxZoneLevel).
function zonesFor(faction, band) {
	const side = SIDE[faction];
	const max = maxZoneLevel(band.from);
	return Object.entries(ZONES)
		.filter(([, z]) => z.side.includes(side) && z.min <= max)
		.map(([id]) => Number(id));
}

// Whether some point still gives skill-ups at the band's top skill. A zone
// whose nodes all turn grey inside the band cannot take a player to its end,
// however dense they are: Teldrassil's Amber (requirement 1, grey from 101)
// for Mining 65-125.
function coversTop(points, band) {
	return points.some((p) => {
		const c = color(band.to - 1, p.req);
		return c !== null && c !== 'grey';
	});
}

// prof.points, one array per zone and band (areas.js memoises areas per points array).
const pointCache = new WeakMap();
function pointsOf(ctx, prof, map, from, to) {
	if (!pointCache.has(prof)) pointCache.set(prof, new Map());
	const c = pointCache.get(prof);
	const key = `${map}|${from}|${to}`;
	if (!c.has(key) || c.get(key).ctx !== ctx) c.set(key, { ctx, points: prof.points(ctx, map, from, to) });
	return c.get(key).points;
}

// The points of a part [at, next) of a range: those its starting skill can gather and that are not grey
// for it, weighted for the part (#2892, #3355: an area never leads to nodes or beasts the skill cannot take
// yet). One array per points array and part, for areas.js's memo.
const partCache = new WeakMap();
function partPoints(points, at, next) {
	if (!partCache.has(points)) partCache.set(points, new Map());
	const c = partCache.get(points);
	const key = `${at}|${next}`;
	if (!c.has(key)) {
		const here = [];
		for (const p of points) {
			if (p.req > at) continue;
			const w = bandWeight(p.req, at, next) * (p.up === undefined ? 1 : p.up);
			if (w > 0) here.push({ ...p, w });
		}
		c.set(key, here);
	}
	return c.get(key);
}

// The seconds the band's nodes take to come back in a zone (their spawns' median, weighted by how many
// are up; nodes.js), or the beasts' (`prof.respawn`).
function respawnIn(prof, map, points) {
	if (prof.respawn) return prof.respawn;
	let s = 0;
	let n = 0;
	for (const p of points) {
		const r = N.respawnOf(map, p.name);
		if (r === null) continue;
		s += r * p.up;
		n += p.up;
	}
	return n > 0 ? s / n : 300;
}

// The zone's gathering areas for these points and `faction` (areas.js), best first, or [].
function areasFor(ctx, prof, map, points, faction, maxLevel = 60) {
	return areasIn(ctx, prof, map, points, { faction, respawn: respawnIn(prof, map, points), maxLevel });
}

// The zones that can take a player through the band from its first point, best first by their best area's
// worth for a character of `level` (areas.js rankScore): [{ zone, points, best, score }].
function rankIn(ctx, prof, band, zones, faction, level) {
	const ranked = [];
	const min = prof.minPoints || 6;
	for (const id of zones) {
		const points = pointsOf(ctx, prof, id, band.from, band.to);
		const start = partPoints(points, band.from, band.to);
		if (start.length < min || !coversTop(start, band)) continue;
		const list = areasFor(ctx, prof, id, start, faction);
		if (!list.length) continue;
		const best = list.reduce((a, b) => (rankScore(b, level) > rankScore(a, level) ? b : a));
		ranked.push({ zone: id, points, best, score: rankScore(best, level) });
	}
	return ranked.sort((a, b) => b.score - a.score || a.zone - b.zone);
}

// The zones a faction's areas for a band come from: the TOP best for a character at the band's start,
// at its end and past every zone's level (the densest: Winterspring's Thorium and Icecap; the
// engine skips an area above the player), each race's own zone for the start and next
// bands, and on a continent the faction lives on with none of those, its best zone when that is worth
// WORTH of the best area at least. [zone id]
const TOP = 2;
const WORTH = 0.25;
const MAX_LEVEL = 60;
function zonePicks(ctx, prof, band, faction) {
	const zones = band.zones ? band.zones[faction] || [] : zonesFor(faction, band);
	const keep = [];
	const add = (r) => r && !keep.includes(r.zone) && keep.push(r.zone);
	const low = rankIn(ctx, prof, band, zones, faction, skillLevel(band.from));
	// For a character at the band's end, the zones workable at its end skill (Mining 175-230: the
	// Hinterlands' Mithril, 17 nodes up at once, opens at 40 where Alterac keeps 5).
	const high = rankIn(ctx, prof, band, band.zones ? zones : zonesFor(faction, { from: band.to }), faction, skillLevel(band.to));
	const top = rankIn(ctx, prof, band, band.zones ? zones : zonesFor(faction, { from: 300 }), faction, MAX_LEVEL);
	for (const r of [...low.slice(0, TOP), ...high.slice(0, TOP), ...top.slice(0, TOP)]) add(r);
	if (band.scope === 'start' || band.scope === 'next') for (const g of RACE_GROUPS[faction]) add(low.find((r) => g[band.scope].includes(r.zone)));
	// The first band also offers each race's next zone (the Barrens, Westfall, Silverpine): a character past the
	// starting area mines there, never in the starting area's own small patch.
	if (band.scope === 'start') for (const g of RACE_GROUPS[faction]) add(low.find((r) => g.next.includes(r.zone)));
	// Zones a profession's band names for the side (`band.add`: map ids) are offered whenever they can take the band.
	for (const id of (band.add && band.add[faction]) || []) add(low.find((r) => r.zone === id));
	for (const g of REGIONS[faction]) {
		if (keep.some((z) => continentOf(ctx, z) === g.c)) continue;
		add(low.find((r) => continentOf(ctx, r.zone) === g.c && r.score >= WORTH * low[0].score));
	}
	if (!keep.length) throw new Error(`${prof.skill} ${band.from}-${band.to}: no zone workable from ${band.from} for the ${faction}`);
	return keep;
}

// Trainer recipes worth learning (`prof.trainerRecipes`: the smelts of
// Mining): bought from a trainer (Smelt Copper comes with the skill) and
// giving points once learned. `recipesAt`: learnable since the last band start
// and still giving points past `from`; `recipesWithin`: first learnable inside
// the band, which splits it there (Smelt Silver at 75 in 65-125).
function trainerRecipes(ctx, prof) {
	if (!prof.trainerRecipes) return [];
	const p = ctx.data.professionNamed(prof.skill);
	return ((p && p.recipes) || []).filter((r) => r.source === 'trainer' && r.cost > 0 && prof.trainerRecipes(r)).sort((a, b) => a.learnedAt - b.learnedAt || a.spell - b.spell);
}

function recipesAt(ctx, prof, from, prevFrom) {
	return trainerRecipes(ctx, prof).filter((r) => r.learnedAt <= from && r.learnedAt > prevFrom && r.grey > from);
}

function recipesWithin(ctx, prof, from, to) {
	return trainerRecipes(ctx, prof).filter((r) => r.learnedAt > from && r.learnedAt < to && r.grey > r.learnedAt);
}

// Whether a trainer recipe is worth a trip of its own in a band: some reagent
// is no gathered material, or one the band's zones hold more than a
// twentieth of their nodes of (Smelt Gold where Gold Veins are one node in
// fifty is not).
function worthTrip(ctx, prof, recipe, zonePoints) {
	const P = ctx.data.professionNamed(prof.skill) || {};
	return recipe.reagents.some((g) => {
		const m = (P.materials || {})[g.item];
		const ids = m && m.gather ? Object.values(m.gather).flat() : [];
		if (!ids.length) return true;
		const kinds = new Set(ids.map((id) => (ctx.data.objects[id] || {}).name).filter(Boolean));
		return zonePoints.some((points) => {
			const up = (p) => (p.up === undefined ? 1 : p.up);
			const total = points.reduce((s, p) => s + up(p), 0);
			const mine = points.filter((p) => kinds.has(p.name)).reduce((s, p) => s + up(p), 0);
			return total > 0 && mine >= total / 20;
		});
	});
}

// The kinds under a twentieth of the nodes listed (nodeSummary's `rare`:
// Mulgore's Stunted Silverleaf, a Forever node a few spots carry). They
// count where they grow, but open no part of a range of their own and are
// left out of a step's title. None for a profession whose rare kinds may
// lead (skinning's beasts: `rareLeads`).
function rareKinds(prof, points) {
	if (prof.rareLeads) return new Set();
	const up = (p) => (p.up === undefined ? 1 : p.up);
	const byKind = new Map();
	for (const p of points) byKind.set(p.name, (byKind.get(p.name) || 0) + up(p));
	const total = [...byKind.values()].reduce((a, b) => a + b, 0);
	return new Set([...byKind].filter(([, n]) => n < total / 20).map(([k]) => k));
}

// A common kind first gathered inside [from, to) splits the range there
// (#2892): each part's areas take only points its starting skill can gather
// and that are not grey for it (partPoints). Rare kinds add no split.
// Skinning keeps its bands: its beasts' levels follow the bands already.
// -> [{ from, to }]
function startParts(prof, points, from, to) {
	if (prof.rareLeads) return [{ from, to }];
	const rare = rareKinds(prof, points);
	const cuts = [...new Set(points.filter((p) => !rare.has(p.name) && p.req > from && p.req < to).map((p) => p.req))].sort((a, b) => a - b);
	const parts = [];
	let at = from;
	for (const next of [...cuts, to]) {
		parts.push({ from: at, to: next });
		at = next;
	}
	return parts;
}

// The areas of one part of a range for both factions: per faction and zone its best ZONE_AREAS (and its
// lowest-level one, so a character new to the zone has one there), the same area for both factions once with
// no faction of its own. Best first for a character at the part's start. A range's first band (scope 'start')
// adds each starting area's own areas (`starter`): the best STARTER_AREAS a character of level 1 to
// STARTER_LEVEL may roam, so a new character always has one at their level. Any area in a starting zone that
// asks no more than STARTER_LEVEL is a starter area too: the engine offers starter areas to low levels only (a
// level 26 in Durotar was sent to the Valley of Trials). -> [{ zone, area, factions, starter? }]
const STARTER_LEVEL = 5;
const ZONE_AREAS = 3;
const STARTER_AREAS = 2;
const START_MAPS = new Set(Object.values(RACE_GROUPS).flatMap((gs) => gs.map((x) => x.start[0])));
function partAreas(ctx, prof, picks, part) {
	const level = skillLevel(part.from);
	const out = [];
	const add = (zone, a, faction, own) => {
		const starter = own || (START_MAPS.has(zone) && a.level <= STARTER_LEVEL);
		const same = out.find((l) => l.zone === zone && l.area.name === a.name && l.area.near === a.near && l.area.level === a.level && Math.abs(l.area.up - a.up) < 0.05);
		if (same) {
			if (!same.factions.includes(faction)) same.factions.push(faction);
			if (starter) same.starter = true;
		} else out.push({ zone, area: a, factions: [faction], ...(starter ? { starter: true } : {}) });
	};
	for (const faction of FACTIONS) {
		for (const zone of picks[faction]) {
			const pts = partPoints(pointsOf(ctx, prof, zone, part.band.from, part.band.to), part.from, part.to);
			if (pts.length < 2) continue;
			for (const a of zoneAreas(areasFor(ctx, prof, zone, pts, faction), partLevels(prof, part), !!prof.spanLevels)) add(zone, a, faction, false);
		}
	}
	for (const s of starterAreas(ctx, prof, part)) add(s.zone, s.area, s.faction, true);
	if (!out.length) throw new Error(`${prof.skill} ${part.from}-${part.to}: no area`);
	return out.sort((a, b) => rankScore(b.area, level) - rankScore(a.area, level) || a.zone - b.zone || a.area.name.localeCompare(b.area.name));
}

// A zone's areas a step offers: its best ZONE_AREAS for a character at each of `levels`, and its lowest-level one.
// With `tiers` (a profession's `spanLevels`) every tier of a chosen area comes too (the same place cut at a lower
// level: the engine offers the largest one safe for the character, so a character below the larger's level gets the
// lower one).
function zoneAreas(list, levels, tiers = false) {
	const best = [];
	for (const level of [].concat(levels)) {
		for (const a of list
			.slice()
			.sort((x, y) => rankScore(y, level) - rankScore(x, level))
			.slice(0, ZONE_AREAS)) {
			if (!best.includes(a)) best.push(a);
		}
	}
	if (tiers) for (const a of list) if (!best.includes(a) && best.some((b) => b.name === a.name && b.near === a.near)) best.push(a);
	const low = list.reduce((a, b) => (!a || b.level < a.level || (b.level === a.level && b.score > a.score) ? b : a), null);
	if (low && !best.includes(low)) best.push(low);
	return best;
}

// The levels a part of a range is planned for: its start, or with `prof.spanLevels` also its middle and end. One level
// only keeps the areas that rank best for the start level and pushes a zone's larger areas a few levels up (Mulgore's
// Thunderhorn at 8 behind Red Cloud Mesa's two tiers and Palemane Rock) out of the guide for the characters who need
// them.
function partLevels(prof, part) {
	const a = skillLevel(part.from);
	if (!prof.spanLevels) return [a];
	const b = skillLevel(part.to);
	return [...new Set([a, Math.round((a + b) / 2), b])];
}

// Each starting area's own areas for a part of a range's first band (partAreas): [{ zone, faction, area }],
// and in `gaps` the areas of each faction with none (no nodes of the part there, or none safe by level 5).
function starterAreas(ctx, prof, part, gaps = null) {
	if (part.band.scope !== 'start') return [];
	const out = [];
	for (const faction of FACTIONS) {
		for (const g of RACE_GROUPS[faction]) {
			const zone = g.start[0];
			const pts = partPoints(pointsOf(ctx, prof, zone, part.band.from, part.band.to), part.from, part.to);
			const list = pts.length >= 2 ? areasFor(ctx, prof, zone, pts, faction, STARTER_LEVEL).slice(0, STARTER_AREAS) : [];
			for (const area of list) out.push({ zone, faction, area, key: g.key });
			if (!list.length && gaps) gaps.push({ key: g.key, zone, faction, points: pts.length });
		}
	}
	return out;
}

// Plan: a list of { kind: 'learn'|'train'|'recipes'|'band', ... } entries in guide order.
// A trainer recipe is learned on a rank visit, or on a visit of its own at a
// band start when its reagent is common there; else it is named in the
// band's tip (`soon`).
function plan(ctx, prof) {
	const out = [{ kind: 'learn' }];
	let prevFrom = 0;
	for (const band of prof.bands) {
		const splits = RANKS.filter((r) => r.learnAt > band.from && r.learnAt < band.to);
		const rankAtStart = RANKS.find((r) => r.learnAt === band.from && r.learnAt > 0);
		const atStart = recipesAt(ctx, prof, band.from, prevFrom);
		const within = recipesWithin(ctx, prof, band.from, band.to);
		prevFrom = band.from;
		const picks = Object.fromEntries(FACTIONS.map((f) => [f, zonePicks(ctx, prof, band, f)]));
		const zones = [...new Set(FACTIONS.flatMap((f) => picks[f]))];
		const zonePts = zones.map((z) => pointsOf(ctx, prof, z, band.from, band.to));
		const recipes = rankAtStart ? atStart : atStart.filter((r) => worthTrip(ctx, prof, r, zonePts));
		const skipped = atStart.filter((r) => !recipes.includes(r));
		// A rank or recipes trained at the band's start open the band: under its banner (and section),
		// so a player whose skill is in the band but lacks the rank is held at its trainer there.
		if (rankAtStart) out.push({ kind: 'train', rank: rankAtStart, recipes, band });
		else if (recipes.length) out.push({ kind: 'recipes', recipes, at: band.from, band });
		let from = band.from;
		for (const stop of [...splits.map((r) => r.learnAt), band.to]) {
			const soon = [...(from === band.from ? skipped : []), ...within.filter((r) => r.learnedAt > from && r.learnedAt < stop)];
			for (const p of startParts(prof, zonePts.flat(), from, stop)) {
				const areas = partAreas(ctx, prof, picks, { ...p, band });
				out.push({ kind: 'band', from: p.from, to: p.to, band, areas, cont: p.from !== from, soon: p.from === from ? soon : [] });
			}
			const rank = splits.find((r) => r.learnAt === stop);
			if (rank) out.push({ kind: 'train', rank, recipes: within.filter((r) => r.learnedAt === stop) });
			from = stop;
		}
	}
	return out;
}

// "Smelt Bronze (2s; orange to 90, grey at 115)".
function recipeLine(r) {
	const col = r.yellow > r.learnedAt ? `orange to ${r.yellow}, ` : '';
	return `${r.name} (${money(r.cost)}; ${col}grey at ${r.grey})`;
}

// Node kinds in a band's areas, lowest requirement first, each with its color at the
// band start (or at its own requirement when that is higher: `later`), the
// nodes of it up at a time (`up`; one per point when unpooled), its expected
// skill-ups per sweep over [from, to) (`gain`) and `rare` when it is under a
// twentieth of the nodes listed.
function nodeSummary(prof, points, from, to = from + 1) {
	const seen = new Map();
	for (const p of points) {
		const k = p.name;
		if (!seen.has(k)) seen.set(k, { name: k, req: p.req, level: p.level, n: 0, up: 0, gain: 0 });
		const s = seen.get(k);
		const up = p.up === undefined ? 1 : p.up;
		s.n++;
		s.up += up;
		s.gain += up * bandWeight(p.req, from, to);
	}
	const list = [...seen.values()];
	const total = list.reduce((a, s) => a + s.up, 0);
	return list
		.sort((a, b) => a.req - b.req || a.name.localeCompare(b.name))
		.map((s) => ({ ...s, color: color(Math.max(from, s.req), s.req), later: s.req > from, rare: s.up < total / 20 }));
}

// About how many nodes a band takes: the skill points over the mean chance of
// a point per node (color weights) across what the areas hold, to the nearest 10.
function nodesNeeded(nodes, from, to) {
	const up = nodes.reduce((a, s) => a + s.up, 0);
	const gain = nodes.reduce((a, s) => a + s.gain, 0);
	if (!(gain > 0)) return null;
	return Math.max(10, Math.round(((to - from) * up) / gain / 10) * 10);
}

// Who may take an area: its sides, and on Zephras Isle (the Skyborne's starting island, nobody else's) the
// Skyborne only. -> the `only` condition, or null for anyone.
function areaOnly(zone, factions) {
	if (zone === SKYBORNE_ISLE) return raceCondition(['Skyborne'], factions);
	return factions.length === 1 ? factions[0] : null;
}
const SKYBORNE_ISLE = 2521;

// A band's area (partAreas: { zone, area, factions, starter }) as the plain record areaLine writes, with
// `per`: 'gain' (skill points a sweep) or 'yield' and its `value`.
function areaRecord(ctx, prof, l, per = 'gain', value = l.area.gain) {
	const a = l.area;
	// What its nodes give, most first: the items at least a fifth of a sweep's yield, at most two (the arrow's line
	// names them: "Roam Red Cloud Mesa for Copper Ore").
	const sweep = ctx && !prof.skins ? bandYield(ctx, prof, a.on, a.up) : [];
	const total = sweep.reduce((s, x) => s + x.count, 0);
	const items = sweep.filter((x) => x.count >= total / 5).slice(0, 2).map((x) => x.item);
	return {
		map: l.zone,
		name: a.name,
		near: a.near,
		lvl: a.level,
		count: a.up,
		lap: Math.round(sweepSeconds(prof, a)),
		per,
		value,
		levels: a.levels || null,
		items: items.length ? items : null,
		only: areaOnly(l.zone, l.factions),
		live: a.live,
		starter: !!l.starter,
		respawn: Math.round(a.respawn),
		poly: a.poly,
		dots: a.dots,
	};
}

// One gathering area line: `area <zone> "<name>" [near] lvl <the least character level safe in it> count <nodes
// (beasts) up at once> lap <seconds a sweep of its nodes takes> gain|yield <per sweep> [levels <min>-<max>]
// [only <conditions>] [live] [starter] respawn <seconds> at <x,y> … dots <x,y> …` (docs/GUIDE_FORMAT.md,
// "Gathering areas"): `near` for open ground named after the subzone nearest it, `levels` the beasts' levels
// (Skinning), `starter` for a starting area's own, `at` its outline, `dots` its node spots.
function areaLine(ctx, rec) {
	const pt = (p) => `${fmt(p.x)},${fmt(p.y)}`;
	const words = [`  area ${zoneName(ctx, rec.map)}`, `"${rec.name}"`];
	if (rec.near) words.push('near');
	words.push(`lvl ${rec.lvl}`, `count ${Math.max(1, Math.round(rec.count))}`, `lap ${rec.lap}`, `${rec.per} ${fmt(rec.value)}`);
	if (rec.levels) words.push(`levels ${rec.levels[0]}-${rec.levels[1]}`);
	if (rec.items) words.push(`items ${rec.items.join(',')}`);
	if (rec.only) words.push(`only ${rec.only}`);
	if (rec.live) words.push('live');
	if (rec.starter) words.push('starter');
	if (rec.respawn) words.push(`respawn ${rec.respawn}`);
	words.push('at', ...rec.poly.map(pt), 'dots', ...rec.dots.map(pt));
	return words.join(' ');
}

function render(ctx, prof) {
	const entries = plan(ctx, prof);
	const L = [];
	L.push(GUIDE_HEADER, `guide forever/professions/${prof.file}`);
	L.push(`title ${prof.title}`);
	L.push('category Professions');
	L.push('coords era');
	L.push(`levels ${prof.levels}`);
	L.push(`zone ${prof.headerZone}`);
	L.push('');
	for (const c of prof.header) L.push(c ? `# ${c}` : '#');
	let lastBand = null;
	const banner = (band) => {
		const key = `${band.from}-${band.to}`;
		if (lastBand === key) return;
		L.push('');
		L.push(`# ---------------------------------------------------------------- ${prof.skill} ${key}`);
		lastBand = key;
	};
	for (const e of entries) {
		if (e.kind === 'learn') {
			const ap = rankInfo(ctx, prof.skill, 'Apprentice');
			L.push('', '# ---------------------------------------------------------------- Apprentice', '');
			L.push(`step Learn ${prof.skill}`);
			L.push(`  tip Any ${prof.skill} trainer of your faction teaches Apprentice ${prof.skill} at any level${ap && ap.cost ? ` (${money(ap.cost)})` : ''}, and so does the Junior ${prof.skill} Trainer in each starting area; the arrow picks the nearest.${prof.tool ? ` Buy a ${prof.tool.name} from a trade goods or general vendor: ${prof.tool.why}` : ''}${prof.learnTip ? ` ${prof.learnTip}` : ''}`);
			L.push(`  train ${prof.skill} Apprentice`);
			if (prof.tool) L.push(`  buy ${prof.tool.item} x1 nearest`);
		} else if (e.kind === 'train') {
			if (e.band) banner(e.band);
			const info = rankInfo(ctx, prof.skill, e.rank.name) || {};
			const camp = e.rank.name === 'Journeyman' && prof.camp ? ctx.data.recipe(prof.camp) : null;
			const learnt = [...e.recipes, ...(camp ? [camp.recipe] : [])];
			L.push('');
			L.push(`step ${e.rank.name} ${prof.skill}`);
			let tip = `${e.rank.name} ${prof.skill} raises the cap to ${e.rank.max}; it needs skill ${e.rank.learnAt} and no character level${info.cost ? `, and costs ${money(info.cost)}` : ''}: train it as soon as you reach ${e.rank.learnAt}. The arrow picks the nearest ${prof.skill} trainer of your faction.`;
			if (e.recipes.length) tip += ` Learn ${e.recipes.map(recipeLine).join(' and ')} on the same visit: ${prof.recipesWhy}`;
			if (camp) tip += ` ${prof.campTip(camp.recipe)}`;
			L.push(`  tip ${tip}`);
			L.push(`  train ${prof.skill} ${e.rank.name}`);
			for (const r of learnt) L.push(`  learn ${r.spell}`);
		} else if (e.kind === 'recipes') {
			if (e.band) banner(e.band);
			L.push('');
			L.push(`step ${e.recipes.map((r) => r.name).join(' & ')}`);
			L.push(`  tip At ${e.at} a ${prof.skill} trainer teaches ${e.recipes.map(recipeLine).join(' and ')}: ${prof.recipesWhy}`);
			for (const r of e.recipes) L.push(`  learn ${r.spell}`);
		} else {
			banner(e.band);
			const on = e.areas.flatMap((l) => l.area.on);
			const nodes = nodeSummary(prof, on, e.from, e.to);
			L.push('');
			L.push(`step ${prof.bandTitle(nodes, e)} (${e.from}-${e.to})`);
			let tip = `${prof.bandTip(nodes, e, ctx)} ${PICK_TIP}`;
			const need = prof.countNodes ? nodesNeeded(nodes, e.from, e.to) : null;
			if (need) {
				const got = bandYield(ctx, prof, on, need)
					.map((x) => ({ ...x, count: Math.round(x.count / 5) * 5 }))
					.filter((x) => x.count >= 5);
				tip += ` Expect about ${need} ${prof.countNodes} for these ${e.to - e.from} points${got.length ? `: about ${listItems(got)}` : ''}.`;
				tip += partnerLine(ctx, prof, got);
			}
			for (const r of e.soon || []) tip += ` ${recipeLine(r)} is taught from ${r.learnedAt}: learn it if you pass a ${prof.skill} trainer, it is not worth a trip of its own.`;
			L.push(`  tip ${tip}`);
			for (const l of e.areas) L.push(areaLine(ctx, areaRecord(ctx, prof, l)));
			L.push(`  skill ${prof.skill} ${e.to}`);
		}
	}
	L.push('');
	for (const line of prof.footer || []) L.push(line);
	// Each band's range is a section (the guide window's heading; the guide starts at the player's skill).
	return `${byBanners(L.join('\n').replace(/\n+$/, ''), prof.skill)}\n`;
}

const PICK_TIP = 'The window lists the areas for your level, best first: the arrow leads to the one you pick and rests once you are in it. Each keeps to creatures no more than a level above you and away from the other faction\'s towns.';

// A crafting partner's needs per gathered item, from the crafting guides' Get it steps
// (guide.js draftGuide `materials`, every rank bracket); a bar counts as the ore it is smelted from
// (Mining's smelts). -> Map(partner -> Map(item -> count))
const needCache = new WeakMap();
function partnerNeeds(ctx, prof) {
	if (!needCache.has(ctx)) needCache.set(ctx, new Map());
	const cache = needCache.get(ctx);
	if (!cache.has(prof.file)) {
		const { draftGuide, draftData } = require('../guide');
		const data = draftData(ctx.data.dir);
		const smelts = ((ctx.data.professionNamed('Mining') || {}).recipes || []).filter((r) => r.source === 'trainer' && /^Smelt /.test(r.name));
		const out = new Map();
		const add = (map, item, n) => {
			const r = smelts.find((s) => s.item === item);
			if (!r) return map.set(item, (map.get(item) || 0) + n);
			for (const g of r.reagents) add(map, g.item, (n * g.count) / (r.itemCount || 1));
		};
		for (const partner of prof.partners || []) {
			const map = new Map();
			for (const b of draftGuide(partner, data).materials) for (const x of b.items) add(map, x.item, x.count);
			out.set(partner, map);
		}
		cache.set(prof.file, out);
	}
	return cache.get(prof.file);
}

// " For Alchemy: about 75 Mageroyal and 150 Briarthorn in all." for the items a band's areas give that
// a crafting partner needs (from 1 to 300).
function partnerLine(ctx, prof, got) {
	let out = '';
	for (const [partner, needs] of partnerNeeds(ctx, prof)) {
		const used = got.filter((x) => needs.get(x.item) >= 5).map((x) => ({ ...x, count: Math.round(needs.get(x.item) / 5) * 5 }));
		if (used.length) out += ` For ${partner}: about ${listItems(used)} in all.`;
	}
	return out;
}

// What `n` gatherings among area points `on` give: [{ item, name, count }], most first. Each kind (or
// beast level) is gathered as often as it is up in the areas; a node gives what players' gathers of it
// gave (nodes.js `yields`, `skins`).
function bandYield(ctx, prof, on, n) {
	const T = N.load();
	const by = new Map();
	for (const p of on) {
		const key = prof.skins ? String(p.level) : p.name;
		by.set(key, (by.get(key) || 0) + (p.up === undefined ? 1 : p.up));
	}
	const total = [...by.values()].reduce((a, b) => a + b, 0);
	const table = prof.skins ? T.skins : T.yields;
	const items = new Map();
	for (const [key, up] of by) {
		const y = table[key];
		if (!y) continue;
		for (const [item, per] of Object.entries(y.items)) items.set(Number(item), (items.get(Number(item)) || 0) + (n * up * per) / total);
	}
	return [...items].map(([item, count]) => ({ item, name: (ctx.data.item(item) || {}).name || `item ${item}`, count })).sort((a, b) => b.count - a.count || a.item - b.item);
}

function listItems(got) {
	const parts = got.map((x) => `${x.count} ${x.name}`);
	return parts.length > 1 ? `${parts.slice(0, -1).join(', ')} and ${parts[parts.length - 1]}` : parts[0];
}

// Every range's areas as data for the crafting guides' Get it steps (`collect <item> xN` with `area`
// lines whose `yield` is that item): [{ item, kind: 'herb'|'ore'|'hide', skill: [from, to], factions, rec }],
// one per area and item that is a twentieth or more of the area's yield. `rec`: the area as areaLine writes
// it (areaRecord) with `yield`: that item from one sweep (every node up in the area once); `factions`: the
// sides it is for.
const KIND = { herbalism: 'herb', mining: 'ore', skinning: 'hide' };
function gatherAreas(ctx) {
	const { SPECS } = require('./specs');
	const out = [];
	for (const prof of SPECS.filter((p) => KIND[p.file])) {
		for (const e of plan(ctx, prof)) {
			if (e.kind !== 'band') continue;
			for (const l of e.areas) {
				const sweep = bandYield(ctx, prof, l.area.on, l.area.up);
				const all = sweep.reduce((s, x) => s + x.count, 0);
				for (const x of sweep) {
					if (x.count < all / 20) continue;
					out.push({ item: x.item, kind: KIND[prof.file], skill: [e.from, e.to], factions: l.factions, rec: areaRecord(ctx, prof, l, 'yield', Math.round(x.count * 10) / 10) });
				}
			}
		}
	}
	return out;
}

// Every generated profession guide: { 'mining.guide': text, ... }. A profession with a gathering route file
// (routes/<file>.json, `"kind": "gathering"`) is written from it (steps.js), and so is a gathering route with
// no spec (Lockpicking: the route says everything); `notes` collects the route zones that have no safe area.
function buildAll(ctx, notes = []) {
	const { SPECS } = require('./specs');
	const { loadRoute } = require('../route');
	const { renderRoute } = require('./steps');
	const out = {};
	const put = (prof, route) => {
		const r = renderRoute(ctx, prof, route);
		notes.push(...r.notes);
		out[`${prof.file}.guide`] = r.text;
	};
	for (const prof of SPECS) {
		const route = prof.skill && prof.file ? loadRoute(prof.file) : null;
		if (route && route.kind === 'gathering') put(prof, route);
		else out[`${prof.file}.guide`] = prof.render ? prof.render(ctx) : render(ctx, prof);
	}
	const dir = path.join(__dirname, '..', 'routes');
	for (const f of fs.readdirSync(dir).filter((x) => x.endsWith('.json')).sort()) {
		const file = f.slice(0, -5);
		if (SPECS.some((p) => p.file === file)) continue;
		const route = loadRoute(file);
		if (route.kind === 'gathering') put({ file, skill: route.profession }, route);
	}
	// Every spell step's row says where the spell is (describe.js withSpellWhere).
	const { withSpellWhere } = require('../describe');
	for (const name of Object.keys(out)) out[name] = withSpellWhere(out[name]);
	return out;
}

module.exports = { START_MAPS, zoneAreas, partLevels, areaOnly, plan, render, buildAll, gatherAreas, zonePicks, partAreas, starterAreas, partPoints, pointsOf, areasFor, rareKinds, startParts, bandYield, coversTop, areaLine, areaRecord, nodeSummary, STARTER_LEVEL, OUT_DIR };
