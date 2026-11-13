'use strict';
// Builds the six generated profession guides (Mining, Herbalism, Skinning,
// Fishing, Cooking, First Aid) from their specs (specs.js) and the reference
// data:
//
//   node tools/polestar.js profession gathering build    # rewrite guides/forever/professions/<those>.guide
//   node tools/polestar.js profession gathering check    # exit 1 when a guide is out of date
//
// For each band and each group of characters (starting area, continent, or
// faction) the zones a group can use are ranked by expected skill-ups per
// yard (route.js); the winner's nodes become a loop of goto waypoints. Groups
// that pick the same zone share one step. Trainers and the tool vendor are
// smart targets (`train <Profession> <Rank>`, `buy … nearest`): the engine
// picks the nearest one of the player's faction at runtime.

const { ZONES, RANKS, color, bandWeight } = require('./tables');
const { RACE_GROUPS, REGIONS, SIDE, TWO_SIDED, raceCondition, maxZoneLevel } = require('./groups');
const R = require('./route');
const { OUT_DIR, GUIDE_HEADER, FACTIONS, context, fmt, liveMark, money, zoneName, flightMaster, rankInfo } = require('./common');
const { byBanners } = require('../sections');

// ------------------------------------------------------------------ planning

function continentOf(ctx, map) {
	const f = ctx.data.eraFrame(map);
	return f ? f.c : null;
}

// Zone candidates for one group in one band.
function candidatesFor(ctx, band, faction, group) {
	const side = SIDE[faction];
	if (band.zones && band.zones[faction]) return band.zones[faction];
	if (band.scope === 'start') return group.start;
	if (band.scope === 'next') return group.next;
	const max = maxZoneLevel(band.from);
	return Object.entries(ZONES)
		.filter(([id, z]) => z.side.includes(side) && z.min <= max && (band.scope !== 'region' || continentOf(ctx, Number(id)) === group.c))
		.map(([id]) => Number(id));
}

function groupsFor(scope, faction) {
	if (scope === 'start' || scope === 'next') return RACE_GROUPS[faction];
	if (scope === 'region') return REGIONS[faction];
	return [{ key: faction.toLowerCase(), faction }];
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

function rankIn(ctx, prof, band, zones) {
	const ranked = [];
	for (const id of zones) {
		const points = prof.points(ctx, id, band.from, band.to);
		if (points.length < (prof.minPoints || 6) || !coversTop(points, band)) continue;
		ranked.push({ zone: id, points, ...R.scorePoints(points, { perPoint: prof.stopYards || 0 }) });
	}
	return ranked.sort((a, b) => b.score - a.score || a.zone - b.zone);
}

// Best zone for one group; a starting zone without nodes (Teldrassil has no
// ore) falls back to the group's next zone.
function pickZone(ctx, prof, band, faction, group) {
	let ranked = rankIn(ctx, prof, band, candidatesFor(ctx, band, faction, group));
	if (!ranked.length && band.scope === 'start') ranked = rankIn(ctx, prof, band, group.next);
	if (!ranked.length) throw new Error(`${prof.skill} ${band.from}-${band.to}: no zone with nodes for ${faction} ${group.key}`);
	return { ...ranked[0], ranked };
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
// is no gathered material, or one the band's loops hold more than a
// twentieth of their nodes of (Smelt Gold where Gold Veins are one node in
// fifty is not).
function worthTrip(ctx, prof, recipe, merged) {
	const P = ctx.data.professionNamed(prof.skill) || {};
	return recipe.reagents.some((g) => {
		const m = (P.materials || {})[g.item];
		const ids = m && m.gather ? Object.values(m.gather).flat() : [];
		if (!ids.length) return true;
		const kinds = new Set(ids.map((id) => (ctx.data.objects[id] || {}).name).filter(Boolean));
		return merged.some((x) => {
			const up = (p) => (p.up === undefined ? 1 : p.up);
			const total = x.points.reduce((s, p) => s + up(p), 0);
			const mine = x.points.filter((p) => kinds.has(p.name)).reduce((s, p) => s + up(p), 0);
			return total > 0 && mine >= total / 20;
		});
	});
}

// The kinds under a twentieth of the nodes listed (nodeSummary's `rare`:
// Mulgore's Stunted Silverleaf, a Forever node a few spots carry). They still
// count where a loop's common nodes are, but never lead a waypoint or name it
// (route.js `loop`, `label` below); the band's tip still names them. None for
// a profession whose rare kinds may lead (skinning's beasts: `rareLeads`).
function rareKinds(prof, points) {
	if (prof.rareLeads) return new Set();
	const up = (p) => (p.up === undefined ? 1 : p.up);
	const byKind = new Map();
	for (const p of points) byKind.set(p.name, (byKind.get(p.name) || 0) + up(p));
	const total = [...byKind.values()].reduce((a, b) => a + b, 0);
	return new Set([...byKind].filter(([, n]) => n < total / 20).map(([k]) => k));
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
		// Pick a zone for every group of both factions.
		const picks = [];
		for (const faction of FACTIONS) {
			for (const group of groupsFor(band.scope, faction)) {
				picks.push({ faction, group, ...pickZone(ctx, prof, band, faction, group) });
			}
		}
		const merged = mergePicks(picks);
		const recipes = rankAtStart ? atStart : atStart.filter((r) => worthTrip(ctx, prof, r, merged));
		const skipped = atStart.filter((r) => !recipes.includes(r));
		// A rank or recipes trained at the band's start open the band: under its banner (and section),
		// so a player whose skill is in the band but lacks the rank is held at its trainer there.
		if (rankAtStart) out.push({ kind: 'train', rank: rankAtStart, recipes, band });
		else if (recipes.length) out.push({ kind: 'recipes', recipes, at: band.from, band });
		let from = band.from;
		for (const stop of [...splits.map((r) => r.learnAt), band.to]) {
			const soon = [...(from === band.from ? skipped : []), ...within.filter((r) => r.learnedAt > from && r.learnedAt < stop)];
			for (const m of merged) {
				const entry = m.factions.length === 1 ? flightMaster(ctx, m.zone, m.factions[0]) : null;
				const loop = R.loop(m.points, ctx.project, { entry: entry ? entry.pt : null, radius: prof.radius || 110, rare: rareKinds(prof, m.points) });
				out.push({ kind: 'band', cond: m.cond, zone: m.zone, from, to: stop, band, loop, points: m.points, cont: from !== band.from, soon });
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

// One entry per zone: the groups that picked it, and the `only` condition
// covering them (none when both factions are in). A race of both sides
// (Skyborne) whose other side picked another zone gets an entry of its own
// side, so the `only` can name that side.
function mergePicks(picks) {
	const out = [];
	const twoSided = (p) => (p.group.races || []).some((r) => TWO_SIDED.has(r));
	const alone = (p) => twoSided(p) && !picks.some((q) => q !== p && q.faction !== p.faction && q.zone === p.zone && twoSided(q));
	// Sides whose Skyborne picked a zone alone: that side's other groups there join them.
	const sided = new Set(picks.filter(alone).map((p) => `${p.zone}|${p.faction}`));
	const keyOf = (p) => (sided.has(`${p.zone}|${p.faction}`) ? `${p.zone}|${p.faction}` : String(p.zone));
	for (const p of picks) {
		const key = keyOf(p);
		let m = out.find((x) => x.key === key);
		if (!m) {
			m = { key, zone: p.zone, points: p.points, picks: [], factions: [] };
			out.push(m);
		}
		m.picks.push(p);
		if (!m.factions.includes(p.faction)) m.factions.push(p.faction);
	}
	for (const m of out) {
		const byRace = m.picks.every((p) => p.group.races);
		if (byRace) m.cond = raceCondition(m.picks.flatMap((p) => p.group.races), m.factions);
		else m.cond = m.factions.length === FACTIONS.length ? null : m.factions.join(',');
	}
	return out;
}

// Node kinds on a loop, lowest requirement first, each with its color at the
// band start (or at its own requirement when that is higher: `later`), the
// nodes of it up at a time (`up`; one per point when unpooled), its expected
// skill-ups per lap over [from, to) (`gain`) and `rare` when it is under a
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
// a point per node (color weights) across what the loop holds, to the nearest 10.
function nodesNeeded(nodes, from, to) {
	const up = nodes.reduce((a, s) => a + s.up, 0);
	const gain = nodes.reduce((a, s) => a + s.gain, 0);
	if (!(gain > 0)) return null;
	return Math.max(10, Math.round(((to - from) * up) / gain / 10) * 10);
}

function shortName(prof, name) {
	return prof.shortName ? prof.shortName(name) : name;
}

// A waypoint's name: its two most plentiful kinds, the zone's rare ones only
// where it holds nothing else.
function label(prof, cluster, rare) {
	const all = Object.entries(cluster.counts);
	const common = all.filter(([n]) => !rare.has(n));
	const names = (common.length ? common : all)
		.sort((a, b) => b[1] - a[1] || a[0].localeCompare(b[0]))
		.slice(0, 2)
		.map(([n]) => shortName(prof, n));
	return names.join(', ');
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
			const zn = zoneName(ctx, e.zone);
			banner(e.band);
			const nodes = nodeSummary(prof, e.points, e.from, e.to);
			const z = ZONES[e.zone];
			L.push('');
			L.push(`step ${prof.bandTitle(nodes, e)}: ${zn} (${e.from}-${e.to})${e.cont ? ' cont.' : ''}`);
			if (e.cond) L.push(`  only ${e.cond}`);
			L.push(`  zone ${zn}`);
			let tip = prof.bandTip(nodes, e, z, ctx);
			const need = prof.countNodes ? nodesNeeded(nodes, e.from, e.to) : null;
			if (need) tip += ` Expect about ${need} ${prof.countNodes} for these ${e.to - e.from} points.`;
			for (const r of e.soon || []) tip += ` ${recipeLine(r)} is taught from ${r.learnedAt}: learn it if you pass a ${prof.skill} trainer, it is not worth a trip of its own.`;
			L.push(`  tip ${tip}`);
			const rare = rareKinds(prof, e.points);
			for (const c of e.loop) L.push(`  goto ${fmt(c.pt.x)},${fmt(c.pt.y)}${liveMark(c.pt)} "${label(prof, c, rare)}" r 30`);
			L.push(`  skill ${prof.skill} ${e.to}`);
		}
	}
	L.push('');
	for (const line of prof.footer || []) L.push(line);
	// Each band's range is a section (the guide window's heading; the guide starts at the player's skill).
	return `${byBanners(L.join('\n').replace(/\n+$/, ''), prof.skill)}\n`;
}

// Every generated profession guide: { 'mining.guide': text, ... }.
function buildAll(ctx) {
	const { SPECS } = require('./specs');
	const out = {};
	for (const prof of SPECS) out[`${prof.file}.guide`] = prof.render ? prof.render(ctx) : render(ctx, prof);
	return out;
}

module.exports = { plan, render, buildAll, mergePicks, rareKinds, label, coversTop, OUT_DIR };
