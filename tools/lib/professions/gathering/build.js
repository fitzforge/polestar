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
// yard (route.js); the winner's nodes become a loop of goto waypoints. A zone
// must hold nodes the band's starting skill can gather; when the best one
// does not, the band splits where it starts to (pickZones). Groups that pick
// the same zone share one step. Trainers and the tool vendor are
// smart targets (`train <Profession> <Rank>`, `buy … nearest`): the engine
// picks the nearest one of the player's faction at runtime.

const { ZONES, RANKS, color, bandWeight } = require('./tables');
const { RACE_GROUPS, REGIONS, SIDE, TWO_SIDED, raceCondition, maxZoneLevel } = require('./groups');
const N = require('./nodes');
const { farm, rankScore, skillLevel, RUN } = require('./farm');
const { OUT_DIR, GUIDE_HEADER, FACTIONS, context, fmt, liveMark, money, zoneName, rankInfo } = require('./common');
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

// Whether a zone can be worked from the band's first point: at least `min`
// points the starting skill can already gather (and not grey for it). A zone
// whose nodes all need more than the band's start leaves a player there with
// nothing to gather: Hillsbrad Foothills for Skinning 100-125, whose lowest
// beast (Gray Bear, level 21) needs 105 (#3355).
function coversStart(points, band, min) {
	let n = 0;
	for (const p of points) {
		const c = color(band.from, p.req);
		if (c !== null && c !== 'grey') n++;
	}
	return n >= min;
}

// prof.points, one array per zone and band (farm.js memoises loops per points array).
const pointCache = new WeakMap();
function pointsOf(ctx, prof, map, from, to) {
	if (!pointCache.has(prof)) pointCache.set(prof, new Map());
	const c = pointCache.get(prof);
	const key = `${map}|${from}|${to}`;
	if (!c.has(key) || c.get(key).ctx !== ctx) c.set(key, { ctx, points: prof.points(ctx, map, from, to) });
	return c.get(key).points;
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

// The zone's farming loop for these points, `faction` and a band starting at skill `from` (farm.js), or null.
function farmIn(ctx, prof, map, points, faction, from) {
	return farm(ctx, prof, map, points, { faction, respawn: respawnIn(prof, map, points), level: skillLevel(from) });
}

// The zones that can take a player through the band, best first by their farming loop's worth for a
// character of the band's planned level (farm.js rankScore); with `start`, only those workable from
// its first point (coversStart).
function rankIn(ctx, prof, band, zones, faction, start = true) {
	const ranked = [];
	const min = prof.minPoints || 6;
	const level = skillLevel(band.from);
	for (const id of zones) {
		const points = pointsOf(ctx, prof, id, band.from, band.to);
		if (points.length < min || !coversTop(points, band) || (start && !coversStart(points, band, min))) continue;
		const f = farmIn(ctx, prof, id, points, faction, band.from);
		if (!f) continue;
		ranked.push({ zone: id, points, farm: f, score: rankScore(f, level) });
	}
	return ranked.sort((a, b) => b.score - a.score || a.zone - b.zone);
}

// One group's zones for one band, in skill order: [{ zone, points, from, to }].
// The best zone usually covers the whole band. When too few of its nodes can be
// gathered at the band's start, the band splits at the first skill where they
// can, and the best zone workable from the start fills the part before it:
// Skinning 100-125 for Undead is Silverpine Forest to 105, then Hillsbrad
// Foothills, whose lowest beast (Gray Bear, level 21) needs 105 (#3355). A
// starting zone without nodes (Teldrassil has no ore) falls back to the
// group's next zone. A zone the group worked the band before (`prev`) is kept
// over a better one within KEEP_SHARE of its score: a near tie is not worth a
// trip (Skinning 125-150 for Night Elves and the Horde stays in Ashenvale,
// 0.0036 against Thousand Needles' 0.0036).
const KEEP_SHARE = 0.03;
function pickZones(ctx, prof, band, faction, group, prev = new Set()) {
	let zones = candidatesFor(ctx, band, faction, group);
	if (!rankIn(ctx, prof, band, zones, faction).length && band.scope === 'start') zones = group.next;
	const piece = (from, to) => {
		const ranked = rankIn(ctx, prof, { ...band, from, to }, zones, faction);
		const top = ranked[0];
		const best = (top && ranked.find((r) => prev.has(r.zone) && r.score >= top.score * (1 - KEEP_SHARE))) || top;
		return best ? { zone: best.zone, points: best.points, from, to } : null;
	};
	const min = prof.minPoints || 6;
	const best = rankIn(ctx, prof, band, zones, faction, false)[0];
	if (best && !coversStart(best.points, band, min)) {
		let at = band.from + 1;
		while (at < band.to && !coversStart(best.points, { from: at, to: band.to }, min)) at++;
		const head = at < band.to ? piece(band.from, at) : null;
		const tail = head ? piece(at, band.to) : null;
		if (head && tail) return [head, tail];
	}
	const whole = piece(band.from, band.to);
	if (!whole) throw new Error(`${prof.skill} ${band.from}-${band.to}: no zone workable from ${band.from} for ${faction} ${group.key}`);
	return [whole];
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

// A common kind first gathered inside [from, to) splits the step there
// (#2892). Each part loops only points its starting skill can gather and that
// are not grey for it, weighted for the part's own range. Rare kinds add no
// split, but count in parts that can gather them. Skinning already picks zones
// and bands around the levels of their beasts (coversStart).
// -> [{ from, to, points }]
function startParts(prof, points, from, to) {
	if (prof.rareLeads) return [{ from, to, points }];
	const rare = rareKinds(prof, points);
	const cuts = [...new Set(points.filter((p) => !rare.has(p.name) && p.req > from && p.req < to).map((p) => p.req))].sort((a, b) => a - b);
	const parts = [];
	let at = from;
	for (const next of [...cuts, to]) {
		const here = [];
		for (const p of points) {
			if (p.req > at) continue;
			const w = bandWeight(p.req, at, next) * (p.up === undefined ? 1 : p.up);
			if (w > 0) here.push({ ...p, w });
		}
		parts.push({ from: at, to: next, points: here });
		at = next;
	}
	return parts;
}

// The loops of one zone part for the factions that picked it (farm.js): one
// entry when every faction gets the same round, else one per faction (the
// other faction's towns differ). -> [{ cond, farm, factions }]
function loopsFor(ctx, prof, m, part) {
	const farms = m.factions.map((faction) => {
		const f = farmIn(ctx, prof, m.zone, part.points, faction, part.from);
		if (!f) throw new Error(`${prof.skill} ${part.from}-${part.to}: no safe loop in ${zoneName(ctx, m.zone)} for the ${faction}`);
		return f;
	});
	const sig = (f) => `${f.level}|${f.stops.map((s) => `${s.pt.x},${s.pt.y}`).join(' ')}`;
	if (farms.every((f) => sig(f) === sig(farms[0]))) return [{ cond: m.cond, farm: farms[0], factions: m.factions }];
	return m.factions.map((faction, i) => {
		const picks = m.picks.filter((p) => p.faction === faction);
		const cond = picks.every((p) => p.group.races) ? raceCondition(picks.flatMap((p) => p.group.races), [faction]) : faction;
		return { cond, farm: farms[i], factions: [faction] };
	});
}

// Plan: a list of { kind: 'learn'|'train'|'recipes'|'band', ... } entries in guide order.
// A trainer recipe is learned on a rank visit, or on a visit of its own at a
// band start when its reagent is common there; else it is named in the
// band's tip (`soon`).
function plan(ctx, prof) {
	const out = [{ kind: 'learn' }];
	let prevFrom = 0;
	// Where each race of each faction worked the band before ("Horde|Tauren" -> zone): pickZones keeps it on a near tie.
	const lastZone = new Map();
	const racesOf = (faction, group) => group.races || RACE_GROUPS[faction].flatMap((g) => g.races);
	for (const band of prof.bands) {
		const splits = RANKS.filter((r) => r.learnAt > band.from && r.learnAt < band.to);
		const rankAtStart = RANKS.find((r) => r.learnAt === band.from && r.learnAt > 0);
		const atStart = recipesAt(ctx, prof, band.from, prevFrom);
		const within = recipesWithin(ctx, prof, band.from, band.to);
		prevFrom = band.from;
		// Pick zones for every group of both factions (two for a group whose band splits).
		const picks = [];
		for (const faction of FACTIONS) {
			for (const group of groupsFor(band.scope, faction)) {
				const prev = new Set(racesOf(faction, group).map((r) => lastZone.get(`${faction}|${r}`)).filter(Boolean));
				for (const p of pickZones(ctx, prof, band, faction, group, prev)) picks.push({ faction, group, ...p });
			}
		}
		// The part that ends the band is the zone each race worked last.
		for (const p of picks) for (const r of racesOf(p.faction, p.group)) lastZone.set(`${p.faction}|${r}`, p.zone);
		// In skill order; groups keep their order within a part of the band.
		const merged = mergePicks(picks).sort((a, b) => a.from - b.from);
		const recipes = rankAtStart ? atStart : atStart.filter((r) => worthTrip(ctx, prof, r, merged));
		const skipped = atStart.filter((r) => !recipes.includes(r));
		// A rank or recipes trained at the band's start open the band: under its banner (and section),
		// so a player whose skill is in the band but lacks the rank is held at its trainer there.
		if (rankAtStart) out.push({ kind: 'train', rank: rankAtStart, recipes, band });
		else if (recipes.length) out.push({ kind: 'recipes', recipes, at: band.from, band });
		let from = band.from;
		for (const stop of [...splits.map((r) => r.learnAt), band.to]) {
			const soon = [...(from === band.from ? skipped : []), ...within.filter((r) => r.learnedAt > from && r.learnedAt < stop)];
			for (const m of merged.filter((x) => x.from < stop && x.to > from)) {
				const at = Math.max(from, m.from);
				for (const part of startParts(prof, m.points, at, Math.min(stop, m.to))) {
					for (const l of loopsFor(ctx, prof, m, part)) out.push({ kind: 'band', cond: l.cond, factions: l.factions, zone: m.zone, from: part.from, to: part.to, band, farm: l.farm, points: part.points, cont: part.from !== m.from, soon: part.from === at ? soon : [] });
				}
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

// One entry per zone and part of the band: the groups that picked it, and the
// `only` condition covering them (none when both factions are in). A race of
// both sides (Skyborne) whose other side picked another zone gets an entry of
// its own side, so the `only` can name that side.
function mergePicks(picks) {
	const out = [];
	const place = (p) => `${p.zone}|${p.from}-${p.to}`;
	const twoSided = (p) => (p.group.races || []).some((r) => TWO_SIDED.has(r));
	const alone = (p) => twoSided(p) && !picks.some((q) => q !== p && q.faction !== p.faction && place(q) === place(p) && twoSided(q));
	// Sides whose Skyborne picked a zone alone: that side's other groups there join them.
	const sided = new Set(picks.filter(alone).map((p) => `${place(p)}|${p.faction}`));
	const keyOf = (p) => (sided.has(`${place(p)}|${p.faction}`) ? `${place(p)}|${p.faction}` : place(p));
	for (const p of picks) {
		const key = keyOf(p);
		let m = out.find((x) => x.key === key);
		if (!m) {
			m = { key, zone: p.zone, from: p.from, to: p.to, points: p.points, picks: [], factions: [] };
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
			const nodes = nodeSummary(prof, e.farm.on, e.from, e.to);
			L.push('');
			L.push(`step ${prof.bandTitle(nodes, e)}: ${zn} (${e.from}-${e.to})${e.cont ? ' cont.' : ''}`);
			if (e.cond) L.push(`  only ${e.cond}`);
			L.push(`  zone ${zn}`);
			let tip = `${prof.bandTip(nodes, e, ctx)} ${loopLine(prof, e)}`;
			const need = prof.countNodes ? nodesNeeded(nodes, e.from, e.to) : null;
			if (need) {
				const got = bandYield(ctx, prof, e, need)
					.map((x) => ({ ...x, count: Math.round(x.count / 5) * 5 }))
					.filter((x) => x.count >= 5);
				tip += ` Expect about ${need} ${prof.countNodes} for these ${e.to - e.from} points${got.length ? `: about ${listItems(got)}` : ''}.`;
				tip += partnerLine(ctx, prof, got);
			}
			for (const r of e.soon || []) tip += ` ${recipeLine(r)} is taught from ${r.learnedAt}: learn it if you pass a ${prof.skill} trainer, it is not worth a trip of its own.`;
			L.push(`  tip ${tip}`);
			if (e.farm.level > 1) L.push(`  level ${e.farm.level}`);
			L.push('  loop');
			const rare = rareKinds(prof, e.points);
			const r = prof.radius || 60;
			for (const c of e.farm.stops) L.push(`  goto ${fmt(c.pt.x)},${fmt(c.pt.y)}${liveMark(c.pt)} "${label(prof, c, rare)}" r ${r}`);
			L.push(`  skill ${prof.skill} ${e.to}`);
		}
	}
	L.push('');
	for (const line of prof.footer || []) L.push(line);
	// Each band's range is a section (the guide window's heading; the guide starts at the player's skill).
	return `${byBanners(L.join('\n').replace(/\n+$/, ''), prof.skill)}\n`;
}

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

// " For Alchemy: about 75 Mageroyal and 150 Briarthorn in all." for the items a band's loop gives that
// a crafting partner needs (from 1 to 300).
function partnerLine(ctx, prof, got) {
	let out = '';
	for (const [partner, needs] of partnerNeeds(ctx, prof)) {
		const used = got.filter((x) => needs.get(x.item) >= 5).map((x) => ({ ...x, count: Math.round(needs.get(x.item) / 5) * 5 }));
		if (used.length) out += ` For ${partner}: about ${listItems(used)} in all.`;
	}
	return out;
}

// "The loop asks level 23: ..." and the lap: what a band's round is.
function loopLine(prof, e) {
	const f = e.farm;
	const walk = Math.round(f.lap / 100) * 100;
	const minutes = Math.max(1, Math.round((f.lap + (prof.stopYards || 0) * f.up) / RUN / 60));
	const level = f.level > 1 ? `The loop asks level ${f.level}: no creature on it is more than a level above that, and it keeps clear of the other faction's towns.` : "The loop keeps clear of the other faction's towns.";
	return `${level} A lap is about ${walk.toLocaleString('en-US')} yards, ${minutes} minute${minutes === 1 ? '' : 's'} with the stops; the arrow leads stop to stop.`;
}

// What `n` gatherings on a band's loop give: [{ item, name, count }], most first. Each kind (or beast
// level) is gathered as often as it is up on the loop; a node gives what players' gathers of it gave
// (nodes.js `yields`, `skins`).
function bandYield(ctx, prof, e, n) {
	const T = N.load();
	const by = new Map();
	for (const p of e.farm.on) {
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

// Every band's loop as data for the crafting guides' "Get it" steps, in the shape of fishLoops
// (fishing-cooking.js): [{ item, kind: 'herb'|'ore'|'hide', skill: [from, to], side, races, map, levels,
// guide, title, pts, perLap, lapMinutes }], one per item that is a twentieth or more of the band's
// yield. `perLap`: that item from one lap's nodes (every node up on the loop once); `races`: the
// races of the step's `only`, null for a whole faction.
const KIND = { herbalism: 'herb', mining: 'ore', skinning: 'hide' };
function gatherLoops(ctx) {
	const { SPECS } = require('./specs');
	const out = [];
	for (const prof of SPECS.filter((p) => KIND[p.file])) {
		for (const e of plan(ctx, prof)) {
			if (e.kind !== 'band') continue;
			const lap = bandYield(ctx, prof, e, e.farm.up);
			const all = lap.reduce((s, x) => s + x.count, 0);
			const words = e.cond ? e.cond.split(',') : [];
			const races = words.filter((w) => !FACTIONS.includes(w));
			const minutes = Math.round(((e.farm.lap + (prof.stopYards || 0) * e.farm.up) / RUN / 60) * 10) / 10;
			for (const side of e.factions) {
				for (const x of lap) {
					if (x.count < all / 20) continue;
					out.push({
						item: x.item,
						kind: KIND[prof.file],
						skill: [e.from, e.to],
						side,
						races: races.length ? races : null,
						map: e.zone,
						levels: [e.farm.level, e.farm.level + 1],
						guide: `forever/professions/${prof.file}`,
						title: `${prof.skill}: ${zoneName(ctx, e.zone)} (${e.from}-${e.to})`,
						pts: e.farm.stops.map((s) => [s.pt.x, s.pt.y]),
						perLap: Math.round(x.count * 10) / 10,
						lapMinutes: minutes,
					});
				}
			}
		}
	}
	return out;
}

// Every generated profession guide: { 'mining.guide': text, ... }.
function buildAll(ctx) {
	const { SPECS } = require('./specs');
	const out = {};
	for (const prof of SPECS) out[`${prof.file}.guide`] = prof.render ? prof.render(ctx) : render(ctx, prof);
	return out;
}

module.exports = { plan, render, buildAll, gatherLoops, mergePicks, pickZones, rareKinds, startParts, loopsFor, bandYield, label, coversTop, coversStart, OUT_DIR };
