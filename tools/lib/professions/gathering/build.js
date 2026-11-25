'use strict';
// Builds the six generated profession guides (Mining, Herbalism, Skinning,
// Fishing, Cooking, First Aid) from their specs (specs.js) and the reference
// data:
//
//   node tools/polestar.js profession gathering build    # rewrite guides/forever/professions/<those>.guide
//   node tools/polestar.js profession gathering check    # exit 1 when a guide is out of date
//
// Herbalism, Mining and Skinning: each skill range is one step whose skill goal
// carries several farming loops (`loop <zone> …`, docs/GUIDE_FORMAT.md "Farming
// loops"); the engine picks one where the player is (travel plus the laps left,
// never creatures 2+ levels above them while another loop is not). The loops
// offered are the best few of every zone a faction may use (farm.js: densest
// ground per yard of a lap at a safe level), for a character at the range's
// start and at its end, plus each race's own zone for the first ranges and the
// best of each continent. A range splits where a common herb first becomes
// pickable inside it (#2892). Trainers and the tool vendor are smart targets
// (`train <Profession> <Rank>`, `buy … nearest`): the engine picks the nearest
// one of the player's faction at runtime.

const { ZONES, RANKS, color, bandWeight } = require('./tables');
const { RACE_GROUPS, REGIONS, SIDE, maxZoneLevel } = require('./groups');
const N = require('./nodes');
const { farm, rankScore, skillLevel, RUN } = require('./farm');
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

// prof.points, one array per zone and band (farm.js memoises loops per points array).
const pointCache = new WeakMap();
function pointsOf(ctx, prof, map, from, to) {
	if (!pointCache.has(prof)) pointCache.set(prof, new Map());
	const c = pointCache.get(prof);
	const key = `${map}|${from}|${to}`;
	if (!c.has(key) || c.get(key).ctx !== ctx) c.set(key, { ctx, points: prof.points(ctx, map, from, to) });
	return c.get(key).points;
}

// The points of a part [at, next) of a range: those its starting skill can gather and that are not grey
// for it, weighted for the part (#2892, #3355: a loop never leads to nodes or beasts the skill cannot take
// yet). One array per points array and part, for farm.js's memo.
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

// The zone's farming loop for these points and `faction`, for a character of `level` (farm.js), or null.
function farmIn(ctx, prof, map, points, faction, level) {
	return farm(ctx, prof, map, points, { faction, respawn: respawnIn(prof, map, points), level });
}

// The zones that can take a player through the band from its first point, best first by their loop's
// worth for a character of `level` (farm.js rankScore): [{ zone, points, farm, score }].
function rankIn(ctx, prof, band, zones, faction, level) {
	const ranked = [];
	const min = prof.minPoints || 6;
	for (const id of zones) {
		const points = pointsOf(ctx, prof, id, band.from, band.to);
		const start = partPoints(points, band.from, band.to);
		if (start.length < min || !coversTop(start, band)) continue;
		const f = farmIn(ctx, prof, id, start, faction, level);
		if (!f) continue;
		ranked.push({ zone: id, points, farm: f, score: rankScore(f, level) });
	}
	return ranked.sort((a, b) => b.score - a.score || a.zone - b.zone);
}

// The zones a faction's loops for a band come from: the TOP best for a character at the band's start and
// at its end (the engine skips a loop above the player), each race's own zone for the start and next
// bands, and on a continent the faction lives on with none of those, its best zone when that is worth
// WORTH of the best loop at least. [zone id]
const TOP = 2;
const WORTH = 0.25;
function zonePicks(ctx, prof, band, faction) {
	const zones = band.zones ? band.zones[faction] || [] : zonesFor(faction, band);
	const keep = [];
	const add = (r) => r && !keep.includes(r.zone) && keep.push(r.zone);
	const low = rankIn(ctx, prof, band, zones, faction, skillLevel(band.from));
	const high = rankIn(ctx, prof, band, zones, faction, skillLevel(band.to));
	for (const r of [...low.slice(0, TOP), ...high.slice(0, TOP)]) add(r);
	if (band.scope === 'start' || band.scope === 'next') for (const g of RACE_GROUPS[faction]) add(low.find((r) => g[band.scope].includes(r.zone)));
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
// (#2892): each part's loops take only points its starting skill can gather
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

// The loops of one part of a range for both factions: one per zone and faction, the same loop for
// both factions once with no faction of its own. Best first for a character at the part's start.
// -> [{ zone, farm, factions }]
function partLoops(ctx, prof, picks, part) {
	const level = skillLevel(part.from);
	const out = [];
	for (const faction of FACTIONS) {
		for (const zone of picks[faction]) {
			const pts = partPoints(pointsOf(ctx, prof, zone, part.band.from, part.band.to), part.from, part.to);
			if (pts.length < 2) continue;
			const f = farmIn(ctx, prof, zone, pts, faction, level);
			if (!f) continue;
			const same = out.find((l) => l.zone === zone && l.farm.level === f.level && l.farm.stops.map((s) => `${s.pt.x},${s.pt.y}`).join(' ') === f.stops.map((s) => `${s.pt.x},${s.pt.y}`).join(' '));
			if (same) same.factions.push(faction);
			else out.push({ zone, farm: f, factions: [faction] });
		}
	}
	if (!out.length) throw new Error(`${prof.skill} ${part.from}-${part.to}: no loop`);
	return out.sort((a, b) => rankScore(b.farm, level) - rankScore(a.farm, level) || a.zone - b.zone);
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
				const loops = partLoops(ctx, prof, picks, { ...p, band });
				out.push({ kind: 'band', from: p.from, to: p.to, band, loops, cont: p.from !== from, soon: p.from === from ? soon : [] });
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
// a point per node (color weights) across what the loops hold, to the nearest 10.
function nodesNeeded(nodes, from, to) {
	const up = nodes.reduce((a, s) => a + s.up, 0);
	const gain = nodes.reduce((a, s) => a + s.gain, 0);
	if (!(gain > 0)) return null;
	return Math.max(10, Math.round(((to - from) * up) / gain / 10) * 10);
}

// The seconds a lap of a loop takes: its walk (never under its nodes' respawn) and the stops.
function lapSeconds(prof, f) {
	return (Math.max(f.lap, f.respawn * RUN) + (prof.stopYards || 0) * f.up) / RUN;
}

// One farming loop line: `loop <zone> lvl <strongest creature> lap <seconds> gain <points a lap>
// [only <Faction>] [live] r <yards> at <x,y> …` (docs/GUIDE_FORMAT.md, "Farming loops").
function loopLine(ctx, prof, l) {
	const f = l.farm;
	const live = f.stops[0].pt.f === 'l';
	const words = [`  loop ${zoneName(ctx, l.zone)}`, `lvl ${f.level + 1}`, `lap ${Math.round(lapSeconds(prof, f))}`, `gain ${fmt(f.gain)}`];
	if (l.factions.length === 1) words.push(`only ${l.factions[0]}`);
	if (live) words.push('live');
	words.push(`r ${prof.radius || 60}`, 'at', ...f.stops.map((s) => `${fmt(s.pt.x)},${fmt(s.pt.y)}`));
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
			const on = e.loops.flatMap((l) => l.farm.on);
			const nodes = nodeSummary(prof, on, e.from, e.to);
			L.push('');
			L.push(`step ${prof.bandTitle(nodes, e)} (${e.from}-${e.to})${e.cont ? ' cont.' : ''}`);
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
			for (const l of e.loops) L.push(loopLine(ctx, prof, l));
			L.push(`  skill ${prof.skill} ${e.to}`);
		}
	}
	L.push('');
	for (const line of prof.footer || []) L.push(line);
	// Each band's range is a section (the guide window's heading; the guide starts at the player's skill).
	return `${byBanners(L.join('\n').replace(/\n+$/, ''), prof.skill)}\n`;
}

const PICK_TIP = 'The arrow takes the loop that gets you there soonest from where you are and walks it until the skill is reached; each loop keeps to creatures no more than a level above you and away from the other faction\'s towns, and the window names it and its lap.';

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

// " For Alchemy: about 75 Mageroyal and 150 Briarthorn in all." for the items a band's loops give that
// a crafting partner needs (from 1 to 300).
function partnerLine(ctx, prof, got) {
	let out = '';
	for (const [partner, needs] of partnerNeeds(ctx, prof)) {
		const used = got.filter((x) => needs.get(x.item) >= 5).map((x) => ({ ...x, count: Math.round(needs.get(x.item) / 5) * 5 }));
		if (used.length) out += ` For ${partner}: about ${listItems(used)} in all.`;
	}
	return out;
}

// What `n` gatherings among loop points `on` give: [{ item, name, count }], most first. Each kind (or
// beast level) is gathered as often as it is up on the loops; a node gives what players' gathers of it
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

// Every range's loops as data for the crafting guides' Get it steps (`collect <item> xN` with `loop`
// lines whose `yield` is that item): [{ item, kind: 'herb'|'ore'|'hide', skill: [from, to], factions,
// map, lvl, lap, yield, r, live, pts }], one per loop and item that is a twentieth or more of the loop's
// yield. `lvl`: the strongest creature on the loop; `lap`: seconds a lap takes; `yield`: that item from
// one lap (every node up on the loop once); `factions`: the sides it is for.
const KIND = { herbalism: 'herb', mining: 'ore', skinning: 'hide' };
function gatherLoops(ctx) {
	const { SPECS } = require('./specs');
	const out = [];
	for (const prof of SPECS.filter((p) => KIND[p.file])) {
		for (const e of plan(ctx, prof)) {
			if (e.kind !== 'band') continue;
			for (const l of e.loops) {
				const lap = bandYield(ctx, prof, l.farm.on, l.farm.up);
				const all = lap.reduce((s, x) => s + x.count, 0);
				for (const x of lap) {
					if (x.count < all / 20) continue;
					out.push({
						item: x.item,
						kind: KIND[prof.file],
						skill: [e.from, e.to],
						factions: l.factions,
						map: l.zone,
						lvl: l.farm.level + 1,
						lap: Math.round(lapSeconds(prof, l.farm)),
						yield: Math.round(x.count * 10) / 10,
						r: prof.radius || 60,
						live: l.farm.stops[0].pt.f === 'l',
						pts: l.farm.stops.map((s) => [s.pt.x, s.pt.y]),
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

module.exports = { plan, render, buildAll, gatherLoops, zonePicks, partLoops, partPoints, rareKinds, startParts, bandYield, coversTop, OUT_DIR };
