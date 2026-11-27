'use strict';
// Fishing + Cooking 1-300, paired (see build.js): one route where the fish you catch feed the cooking,
// band by band.
//
// Each fishing band plans its cooking on one water per group of characters (by starting area, then
// faction: BANDS) and walks a round of its stands: the places players stood when they caught fish there
// (fishing-waters.json, from Polestar_Recorder sessions), weighted by how much of the band's fish (`want`)
// players caught there, ordered as a closed loop (loop.js) that leaves out stands near creatures more
// than a level above the band's character level and near the other faction's towns. A water with fewer
// than two stands adds its fishing-pool clusters (objects.json). Every other water of the faction's side
// whose round gives the same fish is offered beside it as a farming loop (docs/GUIDE_FORMAT.md, "Farming
// loops"): the arrow takes the one that gets the player there soonest from where they are
// (candidateRounds).
//
// Pairing: each band also takes the cooking to `cookTo` with the fish it catches. A deterministic
// walk over the cooking skill picks, at each point, the vendor recipe with the best chance of a skill-up
// (Classic: always below yellow, then (grey - skill) / (grey - yellow)) among those learnt by then whose
// fish the round gives (RECORDED_MIN recorded catches at its stands, else the zone's fishing loot from
// the world database) or the bags kept from earlier bands; ties keep the recipe already on, else take the
// one orange longest. The expected crafts give the fish each recipe takes: the fishing step holds until
// the bags hold them (`collect … anywhere`), so the cooking never runs dry, and a fish caught for later
// stays in the bags. Recipes, spices and lures are bought before the band, from the seller nearest the
// player (or the one in the round's zone when the band has one water).
//
// fishLoops(ctx): every band's waters as data, for the crafting guides' "Get it" steps.

const R = require('./route');
const W = require('./waters');
const { buildLoop, hazards, levelFor, roundLevel } = require('./loop');
const { RUN } = require('./farm');
const fishing = require('./fishing');
const secondary = require('./secondary');
const { RACE_GROUPS, SIDE, TWO_SIDED, raceCondition } = require('./groups');
const { ZONES } = require('./tables');
const { pathLength } = require('../../route/tour');
const { FACTIONS, GUIDE_HEADER, fmt, liveMark, money, zoneName, rankInfo, vendorSpawns, flightMaster, npcSpawn } = require('./common');
const { dist } = require('../../route/geo');
const { ERA_NOTE } = require('./notes');

const GUIDE = 'forever/professions/fishing-cooking';
const RECORDED_MIN = 100;
const STAND_R = 15;
const POOL_NEAR = 25;
const MAX_STOPS = 6;
const SPAN = 400;
// Levels above the least safe one a round may ask to keep three stops (or every good stand) in its loop.
const LOOP_LEVELS = 5;
// Fish that bite only in one season (Classic: Winter Squid in winter, Summer Bass in summer): never a
// band's cooking, whatever the recordings of one month say.
const SEASONAL = new Set([13755, 13756]);
// A fish the round gives: this share of its catches or more.
const BITES = 0.03;
// A stand worth a stop: this share of its catches is the band's fish (while two such stands are left).
const WANTED = 0.15;
// Farming loops (docs/GUIDE_FORMAT.md, "Farming loops"): the waters a band offers per faction besides its
// own, at most this many; a lap's seconds are its walk at RUN yards a second plus CASTS casts of
// CAST_SECONDS at each stand (cast, wait for the splash, loot).
const MAX_LOOPS = 4;
const CASTS = 5;
const CAST_SECONDS = 12;

// The bands. `by`: race (RACE_GROUPS key) or faction; `level`: the least character level the band asks
// (rank gates; the round's hazards may ask more); `want`: the fish the band's cooking is after (they
// weigh the stands); `cookTo`: the cooking skill the band's fish take you to; `waters`: the water the
// band's cooking is planned on. Every other water of the faction whose round gives the fish that cooking
// takes, asks at most `maxLevel` and loses no fish from `lure` skill points above the band's start (a
// lure closes that gap) is a farming loop of the band too, so the arrow takes the one that gets the
// player there soonest from where they are (candidateRounds).
// - Starting areas to Fishing 75: below 75 every catch raises the skill wherever you fish, and their
//   water loses no fish from 25; Brilliant Smallfish or Slitherskin Mackerel to Cooking 50.
// - Capitals to 150: city water loses nothing from 75 and gives Longjaw Mud Snapper and Bristle Whisker
//   Catfish (cooking 50-140), beside the cooking trainer and supplies; no creatures.
// - Catfish water to 190, for Cooking 140-175, where the Expert Cookbook is sold: Ashenvale (Alliance),
//   Desolace (Horde).
// - 190-225 for Cooking 175-225: Mithril Head Trout (or Rockscale Cod) water: northern Stranglethorn
//   Vale, by the Expert Fishing book (Alliance), Shadowprey Village in Desolace (Horde).
// - 225-300 from Artisan: Spotted Yellowtail water that loses no fish from 225 (Dustwallow Marsh, where Nat
//   Pagle's hand-in ends, and the other 225 waters), so no lure the whole band; Tanaris and the other 300
//   waters (more Yellowtail, Glossy Mightfish) would need one for about two and a half hours.
const BANDS = [
	{ key: 'start', from: 1, to: 75, cookTo: 50, by: 'race', level: 1, maxLevel: 12, lure: 25, want: [6291, 6303], waters: { human: 1429, 'dwarf-gnome': 1426, nightelf: 1438, 'skyborne-a': 2521, 'orc-troll': 1411, tauren: 1412, undead: 1420, 'skyborne-h': 2521 } },
	{ key: 'city', from: 75, to: 150, cookTo: 140, by: 'faction', level: 10, maxLevel: 22, lure: 75, want: [6289, 6308], waters: { Alliance: 1453, Horde: 1454 } },
	{ key: 'catfish', from: 150, to: 190, cookTo: 175, by: 'faction', level: 20, maxLevel: 32, lure: 75, want: [6308], waters: { Alliance: 1440, Horde: 1443 } },
	{ key: 'cod', from: 190, to: 225, cookTo: 225, by: 'faction', level: 20, maxLevel: 42, lure: 75, want: [6362, 8365], waters: { Alliance: 1434, Horde: 1443 } },
	{ key: 'late', from: 225, to: 300, cookTo: 300, by: 'faction', level: 35, maxLevel: 52, lure: 0, want: [4603, 13754], waters: { Alliance: 1445, Horde: 1445 }, prefer: [1445] },
];

// Lures (fishing.js): the cheapest one usable at the band's first skill (Bright Baubles ask Fishing 100)
// that closes the gap between that skill and its water's `full`, else the strongest usable one.
const LURES = [
	[fishing.SHINY_BAUBLE, 25],
	[fishing.NIGHTCRAWLERS, 50],
	[fishing.BRIGHT_BAUBLES, 75],
	[fishing.FISH_ATTRACTOR, 100],
];
// A lure lasts ten minutes; a catch takes a cast (CAST_SECONDS) and the loot and recast, about 15 s.
const LURE_SECONDS = 600;
const CATCH_SECONDS = CAST_SECONDS + 3;

// Forever's own fish, for the tips: Whimsyfin, and its recipe (Savory Whimsyfin Delight).
const WHIMSYFIN = 251524;
const WHIMSYFIN_RECIPE = 251526;
// Fishin' Time (Stormwind harbor): a Shiny Bauble and three Nightcrawlers for cooked fish.
const FISHIN_TIME = 95065;

function itemName(ctx, id) {
	return (ctx.data.item(id) || {}).name || `item ${id}`;
}

function pct(v) {
	return `${Math.round(v * 100)}%`;
}

function named(list) {
	return list.length > 1 ? `${list.slice(0, -1).join(', ')} and ${list[list.length - 1]}` : list[0] || '';
}

// --------------------------------------------------------------------- waters and rounds

// A water: its table entry with stands and pools as world points.
const waterCache = new WeakMap();
function waterOf(ctx, map) {
	let byMap = waterCache.get(ctx.data);
	if (!byMap) waterCache.set(ctx.data, (byMap = new Map()));
	if (!byMap.has(map)) {
		const w = W.load()[map] || { full: null, loot: {} };
		const stands = (w.stands || []).map((s) => ({ ...s, pt: ctx.project.point(map, s.x, s.y, s.f || 'e') }));
		const pools = [];
		for (const o of Object.values(ctx.data.objects)) {
			if (!o.roles || !o.roles.includes('fishing')) continue;
			const s = o.spawns && o.spawns[String(map)];
			if (s) for (const [x, y] of R.allPoints(s)) pools.push({ name: o.name, w: 1, pt: ctx.project.point(map, x, y, s.f) });
		}
		byMap.set(map, { map, full: w.full, loot: w.loot || {}, stands, pools });
	}
	return byMap.get(map);
}

// Share of a stand's catches that are one of `want`.
function wantedShare(stand, want) {
	return want.reduce((s, item) => s + (stand.fish[item] || 0), 0) / Math.max(1, stand.catches);
}

// Boat and zeppelin stops with a boarding point (travel.json): a stand within TRANSPORT_YARDS of one is a
// dock the ship comes to (Theramore's), where a goto would have to stand on the boarding point itself (#2876).
const TRANSPORT_YARDS = 40;
function transportStops(ctx) {
	return ((ctx.data.travel || {}).transports || []).flatMap((t) => ['a', 'b'].map((side) => t[side]).filter((s) => s && s.board && s.c != null).map((s) => ({ pt: { c: s.c, wx: s.wx, wy: s.wy }, yards: TRANSPORT_YARDS })));
}

// The round a group fishes at `map`: { map, level, stops: [{ pt, stand, pool }], lap, fish: { item:
// share }, recorded, catches, pools: Map(name -> n), full }. A stand weighs its people times the share
// of the band's fish caught there, plus two per fishing pool within POOL_NEAR yards.
function roundAt(ctx, map, faction, band) {
	const w = waterOf(ctx, map);
	let stands = w.stands;
	const good = stands.filter((s) => wantedShare(s, band.want) >= WANTED);
	if (good.length >= 2) stands = good;
	const pts = stands.map((s) => ({ name: 'stand', pt: s.pt, stand: s, w: s.people * (0.1 + wantedShare(s, band.want)) + 2 * w.pools.filter((p) => dist(p.pt, s.pt) <= POOL_NEAR).length }));
	if (pts.length < 2 && w.pools.length) {
		for (const c of R.weightedClusters(w.pools, 40, ctx.project)) pts.push({ name: 'pool', pt: c.pt, pool: c, w: c.w });
	}
	if (!pts.length) throw new Error(`Fishing + Cooking: no stand or pool in ${zoneName(ctx, map)}`);
	const least = levelFor(ctx, map, pts, { faction, min: band.level, need: Math.min(2, pts.length) });
	if (least === null) throw new Error(`Fishing + Cooking: no safe stand for ${faction} in ${zoneName(ctx, map)}`);
	const fm = flightMaster(ctx, map, faction);
	const loopAt = (level) => buildLoop(pts, ctx.project, { radius: 10, span: SPAN, cover: 0.9, maxStops: MAX_STOPS, entry: fm ? fm.pt : null, avoid: [...hazards(ctx, map, { level, faction }), ...transportStops(ctx)] });
	// The least safe level, or a few more when that keeps the loop three stops long.
	let level = least;
	let loop = loopAt(least);
	for (let l = least + 1; l <= least + LOOP_LEVELS && loop.stops.length < Math.min(3, pts.length); l++) {
		const more = loopAt(l);
		if (more.stops.length >= Math.min(3, pts.length)) {
			level = l;
			loop = more;
		}
	}
	const stops = loop.stops.map((c) => {
		const here = pts.filter((p) => dist(p.pt, c.pt) <= 10).sort((a, b) => b.w - a.w);
		return { pt: here[0].pt, stand: here[0].stand || null, pool: here[0].pool || null, members: here };
	});
	// What bites: the recorded catches at the round's stands, else the zone's fishing loot.
	const caught = {};
	let catches = 0;
	for (const s of stops) {
		for (const m of s.members) {
			if (!m.stand) continue;
			catches += m.stand.catches;
			for (const [item, n] of Object.entries(m.stand.fish)) caught[item] = (caught[item] || 0) + n;
		}
	}
	const recorded = catches >= RECORDED_MIN;
	const fish = {};
	if (recorded) for (const [item, n] of Object.entries(caught)) fish[item] = n / catches;
	else for (const [item, p] of Object.entries(w.loot)) fish[item] = p / 100;
	const pools = new Map();
	for (const s of stops) for (const p of w.pools) if (dist(p.pt, s.pt) <= POOL_NEAR) pools.set(p.name, (pools.get(p.name) || 0) + 1);
	return { map, level, stops: stops.map(({ members, ...s }) => s), lap: loop.lap, fish, recorded, catches, pools, full: w.full };
}

// Whether a round gives `item`: a fish of BITES or more of its catches, in every season.
function bitesAt(round, item) {
	return !SEASONAL.has(Number(item)) && (round.fish[item] || 0) >= BITES;
}

// The `only` a loop at `map` carries for `faction`: the faction, or with it the races that can reach the
// water at all (Zephras Isle: Skyborne).
function loopOnly(map, faction) {
	const only = RACE_GROUPS[faction].filter((g) => g.start.includes(map));
	return only.length && only.every((g) => g.races.every((r) => TWO_SIDED.has(r))) ? raceCondition(only.flatMap((g) => g.races), [faction]) : faction;
}

// The side a water belongs to: the gathering zone table's (A, H or AH), the capitals their faction's.
const CITY_SIDE = { 1453: 'A', 1455: 'A', 1457: 'A', 1454: 'H', 1456: 'H', 1458: 'H' };
function sideOf(map) {
	return (ZONES[map] && ZONES[map].side) || CITY_SIDE[map] || '';
}

// A round as a farming loop for `faction`, or null: its walk (loop.js roundLevel, the whole round, not
// only its stands) must not pass the other faction's towns; while it asks more than the stands do, the
// stop whose leaving lowers it most is left out (down to two stops).
function asLoop(ctx, band, faction, round) {
	let stops = round.stops;
	let walk = roundLevel(ctx, round.map, stops, faction);
	while (walk !== null && walk > round.level && stops.length > 2) {
		let best = null;
		for (let i = 0; i < stops.length; i++) {
			const fewer = stops.filter((_, j) => j !== i);
			const w = roundLevel(ctx, round.map, fewer, faction);
			if (w !== null && (!best || w < best.walk)) best = { stops: fewer, walk: w };
		}
		if (!best || best.walk >= walk) break;
		({ stops, walk } = best);
	}
	if (walk === null) return null;
	const lap = stops.length > 1 ? pathLength(stops[0].pt, stops.slice(1), stops[0].pt) : 0;
	const casts = stops.length * CASTS;
	return {
		...round,
		stops,
		lap,
		level: Math.max(round.level, walk),
		only: loopOnly(round.map, faction),
		seconds: Math.round(lap / RUN + casts * CAST_SECONDS),
		gain: (casts * (band.to - band.from)) / fishing.catches(band.from, band.to),
	};
}

// The band's farming loops for `faction`, or [] when the planned round is no loop of two stops: the
// planned round, then every other water of the faction's side (or both sides) whose round gives every fish
// of `need`, has two stops or more, asks at most the band's `maxLevel` along its whole walk and loses no
// fish from the band's start plus its `lure`: the band's `prefer` waters first (Dustwallow Marsh, where Nat
// Pagle sends you off), then the lowest asking, most fished, up to MAX_LOOPS. Each with `level` (what its
// walk asks), `only`, `seconds` and `gain` (skill points) a lap.
function candidateRounds(ctx, band, faction, planned, need) {
	const fits = (round) => Object.keys(need).every((item) => bitesAt(round, item));
	const first = planned.stops.length > 1 ? asLoop(ctx, band, faction, planned) : null;
	if (!first || first.stops.length < 2) return [];
	const rest = [];
	// A lure closes the gap only as far as the strongest one usable at the band's first skill goes (at 75:
	// Nightcrawlers' +50, not Bright Baubles' +75, which ask Fishing 100).
	const reach = Math.min(band.lure, Math.max(0, ...LURES.filter(([id]) => fishing.lureSkill(ctx, id) <= band.from).map(([, b]) => b)));
	for (const [key, w] of Object.entries(W.load())) {
		const map = Number(key);
		if (map === planned.map || !sideOf(map).includes(SIDE[faction]) || (w.full !== null && w.full > band.from + reach)) continue;
		let round;
		try {
			round = roundAt(ctx, map, faction, band);
		} catch {
			continue;
		}
		if (round.stops.length < 2 || !fits(round)) continue;
		const loop = asLoop(ctx, band, faction, round);
		if (loop && loop.stops.length > 1 && loop.level <= band.maxLevel) rest.push(loop);
	}
	const prefer = (r) => ((band.prefer || []).includes(r.map) ? 0 : 1);
	rest.sort((a, b) => prefer(a) - prefer(b) || a.level - b.level || b.catches - a.catches || a.map - b.map);
	return [first, ...rest.slice(0, MAX_LOOPS)];
}

// --------------------------------------------------------------------- cooking

// The sellers of a recipe for `faction`: professions.json's vendors for that faction (it lists neutral
// goblins such as Gikkix for both, whose NPC record carries no side), else the item's vendors of the side.
function sellersOf(ctx, mats, item, faction) {
	const ids = ((mats[item] || {}).vendors || {})[faction];
	if (ids && ids.length) return ids.map((id) => npcSpawn(ctx, id)).filter(Boolean);
	return vendorSpawns(ctx, item, faction);
}

// The cooking recipes for fish: vendor recipes with a reagent some water gives, sold to the faction.
// Each with `fish` (its fish reagents) and `extra` (the rest: spices, water).
function fishRecipes(ctx, faction) {
	const P = ctx.data.professionNamed('Cooking') || {};
	const mats = P.materials || {};
	const fishItems = new Set();
	for (const w of Object.values(W.load())) {
		for (const id of Object.keys(w.loot || {})) fishItems.add(Number(id));
		for (const s of w.stands || []) for (const id of Object.keys(s.fish)) fishItems.add(Number(id));
	}
	return (P.recipes || [])
		.filter((r) => r.source === 'vendor' && r.recipeItem && r.grey > r.learnedAt && r.reagents.some((g) => fishItems.has(g.item)))
		.filter((r) => sellersOf(ctx, mats, r.recipeItem, faction).length > 0)
		.map((r) => ({ ...r, fish: r.reagents.filter((g) => fishItems.has(g.item)), extra: r.reagents.filter((g) => !fishItems.has(g.item)) }))
		.sort((a, b) => a.learnedAt - b.learnedAt || a.spell - b.spell);
}

// Chance of a skill-up at skill s.
function chance(r, s) {
	if (s >= r.grey) return 0;
	return s < r.yellow ? 1 : (r.grey - s) / (r.grey - r.yellow);
}

// The cooking from skill `from` to `to`: [{ recipe, from, to, crafts }], and the fish they take
// ({ item: n }). `bites(item)`: the round gives it; `kept`: { item: n } in the bags from earlier bands.
// Throws when no recipe carries a skill point.
function cookingPlan(recipes, from, to, bites, kept) {
	const segs = [];
	const used = {};
	let cur = null;
	for (let s = from; s < to; s++) {
		let best = null;
		for (const r of recipes) {
			if (r.learnedAt > s) continue;
			const p = chance(r, s);
			if (p <= 0) continue;
			const ok = r.fish.every((g) => bites(g.item) || (kept[g.item] || 0) - (used[g.item] || 0) >= g.count / p);
			if (!ok) continue;
			// Ties: the recipe already on, else the one orange longest (one recipe bought, not two).
			const tie = best && Math.abs(p - best.p) < 1e-9;
			const better = !best || p > best.p + 1e-9 || (tie && best.r !== cur && (r === cur || r.yellow > best.r.yellow));
			if (better) best = { r, p };
		}
		if (!best) throw new Error(`Fishing + Cooking: no fish recipe carries Cooking ${s} (fish: ${Object.keys(kept).join(',')})`);
		for (const g of best.r.fish) used[g.item] = (used[g.item] || 0) + g.count / best.p;
		if (cur === best.r) {
			const last = segs[segs.length - 1];
			last.to = s + 1;
			last.crafts += 1 / best.p;
		} else segs.push({ recipe: best.r, from: s, to: s + 1, crafts: 1 / best.p });
		cur = best.r;
	}
	for (const seg of segs) seg.crafts = Math.ceil(seg.crafts);
	return { segs, used };
}

// --------------------------------------------------------------------- plan

// Who a band's group is: { key, races, faction, cond }.
function groupsOf(by, faction) {
	if (by === 'race') return RACE_GROUPS[faction].map((g) => ({ key: g.key, races: g.races, faction, cond: raceCondition(g.races, [faction]) }));
	return [{ key: faction, races: null, faction, cond: faction }];
}

// The plan: per faction, the entries the renderer writes, in order:
//   { kind: 'band', band, group, round, need: { item: n }, catches, cook: [seg | { rank }], shop }
//   { kind: 'rank', skill, rank } and { kind: 'artisan' }.
function plan(ctx) {
	const out = {};
	const jm = rankInfo(ctx, 'Cooking', 'Journeyman');
	for (const faction of FACTIONS) {
		const recipes = fishRecipes(ctx, faction);
		// What each race group holds after a band: the fish kept and the recipes bought. A faction band
		// takes what all its races hold in common (the least of each fish).
		const kept = new Map(RACE_GROUPS[faction].map((g) => [g.key, { inv: {}, owned: new Set() }]));
		const entries = [];
		let cooking = 1;
		for (const band of BANDS) {
			if (band.key === 'city') entries.push({ kind: 'rank', skill: 'Fishing', rank: 'Journeyman' });
			if (band.key === 'catfish') entries.push({ kind: 'rank', skill: 'Fishing', rank: 'Expert' }, { kind: 'rank', skill: 'Cooking', rank: 'Expert' });
			if (band.key === 'late') entries.push({ kind: 'artisan' });
			for (const g of groupsOf(band.by, faction)) {
				const members = RACE_GROUPS[faction].filter((r) => !g.races || r.races.some((x) => g.races.includes(x))).map((r) => kept.get(r.key));
				const inv = {};
				for (const item of new Set(members.flatMap((m) => Object.keys(m.inv)))) inv[item] = Math.min(...members.map((m) => m.inv[item] || 0));
				const owned = new Set([...members[0].owned].filter((s) => members.every((m) => m.owned.has(s))));
				const round = roundAt(ctx, band.waters[g.key], faction, band);
				const bites = (item) => bitesAt(round, item);
				const { segs, used } = cookingPlan(recipes, band.key === 'start' ? 1 : BANDS[BANDS.indexOf(band) - 1].cookTo, band.cookTo, bites, inv);
				// The fish to hold before cooking: all the band's cooking takes (the bags count what was kept).
				const need = {};
				for (const [item, n] of Object.entries(used)) need[item] = Math.ceil(n);
				// Catches: what the skill takes, or what the fish take at their shares, whichever is more.
				let catches = fishing.catches(band.from, band.to);
				for (const [item, n] of Object.entries(need)) if (bites(item)) catches = Math.max(catches, (n - (inv[item] || 0)) / round.fish[item]);
				const after = { ...inv };
				for (const [item, share] of Object.entries(round.fish)) after[item] = (after[item] || 0) + catches * share;
				for (const [item, n] of Object.entries(used)) after[item] -= n;
				// Journeyman Cooking where the cooking reaches its skill.
				const cook = [];
				const journeyman = () => {
					if (owned.has('Journeyman')) return;
					cook.push({ rank: 'Journeyman' });
					owned.add('Journeyman');
				};
				for (const seg of segs) {
					if (seg.from >= jm.minSkill) journeyman();
					cook.push(seg);
				}
				if (band.cookTo >= jm.minSkill) journeyman();
				const shopRecipes = [...new Map(segs.map((s) => s.recipe).filter((r) => !owned.has(r.spell)).map((r) => [r.spell, r])).values()];
				const extras = new Map();
				for (const s of segs) for (const x of s.recipe.extra) extras.set(x.item, (extras.get(x.item) || 0) + x.count * s.crafts);
				// The band's farming loops (two or more: the arrow picks; else the planned round alone), and the
				// lure for the water among them that loses fish longest.
				const loops = candidateRounds(ctx, band, faction, round, Object.fromEntries(Object.entries(need).filter(([item]) => bites(item))));
				const waters = loops.length > 1 ? loops : [round];
				const full = Math.max(0, ...waters.map((w) => w.full || 0));
				const gap = full > band.from ? full - band.from : 0;
				const usable = LURES.filter(([id]) => fishing.lureSkill(ctx, id) <= band.from);
				const lure = gap && usable.length ? usable.find(([, b]) => b >= gap) || usable[usable.length - 1] : null;
				// Enough lures for every catch below the water's `full` (the skill's catches, Classic's rate).
				const lures = lure ? Math.max(1, Math.ceil((fishing.catches(band.from, Math.min(full, band.to)) * CATCH_SECONDS) / LURE_SECONDS)) : 0;
				entries.push({ kind: 'band', band, group: g, round, loops: loops.length > 1 ? loops : null, need, kept: inv, catches, cook, shop: { recipes: shopRecipes, extras: [...extras], lure, lures, full } });
				for (const m of members) {
					m.inv = Object.fromEntries(Object.entries(after).filter(([item, v]) => v >= 1 && !SEASONAL.has(Number(item))));
					for (const r of shopRecipes) m.owned.add(r.spell);
					if (owned.has('Journeyman')) m.owned.add('Journeyman');
				}
			}
			cooking = band.cookTo;
		}
		if (cooking !== 300) throw new Error(`Fishing + Cooking: the ${faction} route ends at Cooking ${cooking}`);
		out[faction] = entries;
	}
	return out;
}

// --------------------------------------------------------------------- render

function render(ctx) {
	const L = [];
	const step = (title, lines) => L.push('', `step ${title}`, ...lines.map((l) => `  ${l}`));
	const banner = (s) => L.push('', `# ---------------------------------------------------------------- ${s}`);
	const P = ctx.data.professionNamed('Cooking') || {};
	const mats = P.materials || {};
	const plans = plan(ctx);

	L.push(GUIDE_HEADER, `guide ${GUIDE}`, 'title Fishing + Cooking 1-300', 'category Professions', 'kind profession', 'skills Fishing, Cooking', 'coords era', 'levels 5-60', 'zone Ironforge', '');
	for (const c of [
		'Fishing and Cooking 1-300 together, for both factions: each fishing band',
		'catches the fish its cooking takes, so neither waits on the other. Each band',
		'fishes a round of stands: the places players stood when they caught the',
		"band's fish there (Polestar_Recorder sessions, three or more players each), in",
		'a loop the arrow walks, leaving out stands near creatures more than a level',
		"above the band's level and near the other faction's towns. Each band offers",
		"every water of your side that gives its fish as a farming loop, and the arrow",
		'takes the one that gets you there soonest from where you are: starting areas',
		'to 75 (Cooking 50), the capitals and other Longjaw Mud Snapper and catfish',
		'water to 150 (Cooking 140), catfish water to 190 (Cooking 175), Mithril Head',
		'Trout water to 225, Nat Pagle and Clamlette Surprise for Artisan, then',
		'Spotted Yellowtail water (Tanaris and others) to 300.',
		'',
		'What bites at a round: the recorded catches at its stands (100 or more), else',
		"the zone's fishing loot from Forever's server data; when a water loses no fish:",
		"its base fishing skill + 95 (Forever's server data). Recipes, their skill",
		"colours, prices and sellers are the data's (professions.json, Cooking).",
		"ASSUMED: catches per point follow Classic's rate (every catch below 75, then",
		'one in (skill - 50) / 25), cooking skill-ups the Classic chance; the fish a',
		"band holds you for are the expected crafts' worth; a loop's lap is its walk",
		'at 7 yards a second and five casts of 12 seconds at each stand.',
		'Not routed: the Ravaged Fishing Pole (one source, no loot row in the server',
		'data), Recipe: Plated Armorfish (one source), the Winter Frontier Fishery',
		'quests (Winter Squid only bites in winter).',
		'',
		...ERA_NOTE,
	])
		L.push(c ? `# ${c}` : '#');

	// Apprentice: both professions, the pole.
	banner('Apprentice');
	const apF = rankInfo(ctx, 'Fishing', 'Apprentice');
	const apC = rankInfo(ctx, 'Cooking', 'Apprentice');
	const bowl = ctx.data.recipe(1229745).recipe;
	step('Learn Fishing and Cooking', [
		`tip Any Fishing trainer of your faction teaches Apprentice Fishing (${money(apF.cost)}) and any Cooking trainer Apprentice Cooking (${money(apC.cost)}), at any character level; the arrow picks the nearest of each, and every starting area has both. Buy a Fishing Pole${fishing.note(ctx, fishing.POLE)} and equip it (you can only fish with a pole in your hands). Forever: every cook knows Basic Campfire: a Basic Campfire Kit from one Simple Wood with Flint and Tinder lights a cooking fire anywhere, so you can cook beside the water. If you sat at your starting area's campfire for The Great Outdoors, its camping guide also offers Camping 101: Fishing (handed in at Fishing 20 for the ${bowl.name} recipe) and Camping 101: Cooking.`,
		'train Fishing Apprentice',
		'train Cooking Apprentice',
		`buy ${fishing.POLE} x1 nearest`,
	]);

	// Each slot of the route (a band, a rank, Artisan) in order, both factions' steps under one banner.
	const slotOf = (e) => (e.kind === 'band' ? `band|${e.band.key}` : e.kind === 'rank' ? `rank|${e.skill}|${e.rank}` : 'artisan');
	const slots = new Map();
	for (const faction of FACTIONS) {
		for (const e of plans[faction]) {
			const k = slotOf(e);
			if (!slots.has(k)) slots.set(k, []);
			slots.get(k).push(e);
		}
	}
	for (const list of slots.values()) {
		const e = list[0];
		if (e.kind === 'band') {
			banner(`Fishing ${e.band.from}-${e.band.to}`);
			// Groups whose steps match but for `only` (the same round, recipes and fish) share them: races of
			// one faction under one `only`, both factions' whole routes with none.
			const bare = (steps) => JSON.stringify(steps.map(([t, lines]) => [t, lines.filter((l) => !l.startsWith('only '))]));
			const buckets = new Map();
			for (const b of list) {
				const steps = renderBand(ctx, b, mats);
				const key = bare(steps);
				if (!buckets.has(key)) buckets.set(key, { steps, groups: [] });
				buckets.get(key).groups.push(b.group);
			}
			for (const { steps, groups } of buckets.values()) {
				const factions = [...new Set(groups.map((g) => g.faction))];
				const everyone = groups.every((g) => !g.races) && factions.length === FACTIONS.length;
				const cond = everyone ? null : groups.every((g) => g.races) ? raceCondition(groups.flatMap((g) => g.races), factions) : factions.join(',');
				for (const [t, lines] of steps) step(t, lines.map((l) => (l.startsWith('only ') ? (cond ? `only ${cond}` : null) : l)).filter((l) => l !== null));
			}
		} else if (e.kind === 'rank') renderRank(ctx, e, step, banner);
		else {
			banner('Artisan: Nat Pagle and Clamlette Surprise');
			fishing.pagleSteps(ctx, step);
			for (const s of secondary.clamletteSteps(ctx)) step(s.title, s.raw);
		}
	}
	return `${L.join('\n')}\n`;
}

function renderRank(ctx, e, step, banner) {
	const info = rankInfo(ctx, e.skill, e.rank);
	if (e.skill === 'Fishing' && e.rank === 'Journeyman') {
		step('Journeyman Fishing', [
			`tip Journeyman Fishing raises the cap to ${info.max}; it needs skill ${info.minSkill} and character level ${info.minLevel} (Forever's trainer lists ask for that level), and costs ${money(info.cost)}. The arrow picks the nearest Fishing trainer of your faction.`,
			`level ${info.minLevel}`,
			'train Fishing Journeyman',
		]);
		return;
	}
	if (e.skill === 'Fishing') banner('Expert Fishing and Expert Cooking');
	const book = info.book;
	const name = itemName(ctx, book.item);
	const P = ctx.data.professionNamed(e.skill) || {};
	const cost = ((P.materials || {})[book.item] || {}).buy || fishing.price(ctx, book.item);
	const lines = [];
	for (const f of FACTIONS) {
		const seller = npcSpawn(ctx, book.vendors[f][0]);
		lines.push(`${seller.name} (${zoneName(ctx, seller.map)}) for the ${f}`);
	}
	const same = book.vendors.Alliance[0] === book.vendors.Horde[0];
	const sold = same ? `${npcSpawn(ctx, book.vendors.Alliance[0]).name} (${zoneName(ctx, npcSpawn(ctx, book.vendors.Alliance[0]).map)}) sells it to both factions` : `sold by ${named(lines)}`;
	let tip = `Expert ${e.skill} (cap ${info.max}) is a book, not a trainer rank: ${name}${cost ? ` (${money(cost)})` : ''}, ${sold}. Buy it and read it; it needs skill ${info.minSkill} and level ${info.minLevel}.`;
	if (e.skill === 'Fishing') {
		const rack = ctx.data.recipe(fishing.FISHING_RACK);
		tip += ` At level 20 the safe way to Booty Bay is the boat from Ratchet in The Barrens. ${npcSpawn(ctx, book.vendors.Alliance[0]).name} also sells Bright Baubles${fishing.note(ctx, fishing.BRIGHT_BAUBLES, 75, true)}, the lure for harder water.`;
		if (rack && rack.recipe) tip += ` Forever's ${rack.recipe.name} (a camping item, from Fishing ${rack.recipe.learnedAt}) is a blueprint that drops from Gelihast in Blackfathom Deeps.`;
	}
	step(`Expert ${e.skill}`, [`tip ${tip}`, `level ${info.minLevel}`, `train ${e.skill} Expert "Buy and read ${name} (Expert ${e.skill})"`]);
}

// What a round's stands give: "Raw Longjaw Mud Snapper (55%), ..." (items of 3% or more).
function biteLine(ctx, round) {
	return Object.entries(round.fish)
		.filter(([, s]) => s >= BITES)
		.sort((a, b) => b[1] - a[1] || a[0] - b[0])
		.slice(0, 6)
		.map(([item, s]) => `${itemName(ctx, Number(item))} (${pct(s)}${SEASONAL.has(Number(item)) ? ', in its season only' : ''})`)
		.join(', ');
}

function renderBand(ctx, e, mats) {
	const out = [];
	const step = (title, lines) => out.push([title, lines]);
	const { band, group, round, shop, cook, need, loops } = e;
	const faction = group.faction;
	const zone = zoneName(ctx, round.map);
	// With farming loops the water is the arrow's pick: titles name the band, not a zone.
	const label = loops ? `Fishing ${band.from}-${band.to}` : zone;
	const only = `only ${group.cond}`;
	const first = round.stops[0].pt;
	// A character whose cooking is past the band's (it cooked from elsewhere) skips the band's shopping and
	// fish; one whose fishing is past the waters' loss skill skips the lure. The guide has no `section`s:
	// a section follows one skill, and a band here is a Fishing range and a Cooking range at once.
	const cooked = `skill Cooking ${band.cookTo}`;
	// Shopping: the band's new recipes, from the seller in the round's zone (`npc`) when the band has one
	// water, else the one nearest the player (`nearest`; the tip names the two nearest the planned round);
	// spices.
	const buys = [];
	const notes = [];
	for (const r of shop.recipes) {
		const m = mats[r.recipeItem] || {};
		const all = sellersOf(ctx, mats, r.recipeItem, faction);
		const near = all.filter((x) => x.pt.c === first.c).sort((a, b) => dist(first, a.pt) - dist(first, b.pt) || a.id - b.id);
		const here = loops ? null : near.find((x) => x.map === round.map);
		buys.push(here ? `buy ${r.recipeItem} x1 npc ${here.id}` : `buy ${r.recipeItem} x1 nearest`);
		const who = here ? [here] : (near.length ? near : all).slice(0, 2);
		notes.push(`${itemName(ctx, r.recipeItem)} (Cooking ${r.learnedAt}, ${money(m.buy || r.cost)}: ${who.map((v) => `${v.name}, ${zoneName(ctx, v.map)}`).join(', or ')})`);
	}
	for (const [item, n] of shop.extras) {
		buys.push(`buy ${item} x${Math.ceil(n)} nearest`);
		notes.push(`${Math.ceil(n)} ${itemName(ctx, item)}`);
	}
	if (buys.length) step(`Recipes for ${label} (Cooking to ${band.cookTo})`, [only, `when !${cooked}`, ...(loops ? [] : [`zone ${zone}`]), `tip Before the round: ${named(notes)}.${shop.recipes.length ? ' A recipe teaches itself when you use it from your bags.' : ''}`, ...buys]);
	if (shop.lure) {
		step(`Lures for ${label}`, [
			only,
			`when !skill Fishing ${shop.full}`,
			`tip ${loops ? 'Some of these waters lose' : 'This water loses'} fish below Fishing ${shop.full}: a lure on the pole adds to your skill for ten minutes. ${itemName(ctx, shop.lure[0])}${fishing.note(ctx, shop.lure[0], shop.lure[1], true)}${shop.lure[1] >= shop.full - band.from ? ` closes the gap from ${band.from}` : ` is the strongest you can use at ${band.from}`}: about ${shop.lures} ${shop.lures > 1 ? 'see' : 'sees'} you to ${Math.min(shop.full, band.to)} (${Math.round((fishing.catches(band.from, Math.min(shop.full, band.to)) * CATCH_SECONDS) / 60)} minutes of fishing).`,
			`buy ${shop.lure[0]} x${shop.lures} nearest`,
		]);
	}

	// The fishing: the skill, and while the cooking needs them, the fish it takes (a second copy of the
	// step: `when` holds for a whole step).
	const skillCatches = fishing.catches(band.from, band.to);
	const holds = Object.entries(need).filter(([item]) => bitesAt(round, item));
	const waters = loops || [round];
	const rate = band.from >= 75 ? ' (from 75 a catch raises the skill less often: one in two by 100, one in seven by 225)' : ' (below 75 every catch raises the skill)';
	// Never the word "bite" alone in a tip: the compiler then reads the spell Bite as a common word in every guide.
	const standTip = 'stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy.';
	const roundTip = (withFish) => {
		const tip = [];
		const fishNote = withFish ? ` and until your bags hold ${named(holds.map(([item, n]) => `${n} ${itemName(ctx, Number(item))}`))} for the cooking` : '';
		tip.push(`Fish the round until Fishing ${band.to}${fishNote}: ${fishing.about(withFish ? Math.max(skillCatches, e.catches) : skillCatches)} catches${rate}.`);
		if (loops) {
			// Each water with the share of the band's fish players catch there (or its two commonest fish).
			const shown = holds.length ? holds.map(([item]) => Number(item)) : null;
			const shares = (w) => (shown || Object.entries(w.fish).filter(([item]) => bitesAt(w, item)).sort((a, b) => b[1] - a[1]).slice(0, 2).map(([item]) => Number(item))).map((item) => `${itemName(ctx, item)} ${pct(w.fish[item] || 0)}`).join(', ');
			tip.push(`The arrow takes the water that gets you there soonest from where you are, and picks again when you change zones: ${loops.map((w) => `${zoneName(ctx, w.map)} (${shares(w)})`).join('; ')}. At each it leads stand to stand: ${standTip}`);
			const losing = loops.filter((w) => w.full && w.full > band.from);
			if (losing.length) tip.push(`${named(losing.map((w) => zoneName(ctx, w.map)))} ${losing.length > 1 ? 'lose' : 'loses'} fish below skill ${shop.full}: keep a lure on the pole there until then.`);
		} else {
			if (round.stops.length > 1) tip.push(`The arrow leads stand to stand: ${standTip}`);
			tip.push(`What bites here${round.recorded ? " (players' catches at these stands)" : " (the zone's fishing loot)"}: ${biteLine(ctx, round)}.`);
			if (round.pools.size) tip.push(`Fishing pools by the round: ${named([...round.pools.keys()].sort())}.`);
			if (round.full && round.full > band.from) tip.push(`This water loses fish below skill ${round.full}: keep a lure on the pole until then.`);
			else if (round.full) tip.push(`From skill ${round.full} this water loses no fish.`);
		}
		tip.push(...forever(ctx, waters, faction));
		return `tip ${tip.join(' ')}`;
	};
	// A farming loop line (docs/GUIDE_FORMAT.md, "Farming loops"): its strongest creature's level (a level
	// above the one its walk asks), a lap's seconds and skill points, who may take it, its stands.
	const loopLine = (w) => {
		const live = w.stops[0].pt.f === 'l';
		return [`loop ${zoneName(ctx, w.map)}`, `lvl ${w.level + 1}`, `lap ${w.seconds}`, `gain ${fmt(w.gain)}`, `only ${w.only}`, ...(live ? ['live'] : []), `r ${w.stops.some((s) => s.pool) ? 25 : STAND_R}`, 'at', ...w.stops.map((s) => `${fmt(s.pt.x)},${fmt(s.pt.y)}`)].join(' ');
	};
	const roundLines = (withFish) => {
		const lines = [only];
		if (holds.length) lines.push(withFish ? `when !${cooked}` : `when ${cooked}`);
		if (!loops) lines.push(`zone ${zone}`);
		lines.push(withFish || !holds.length ? roundTip(withFish) : `tip Your Cooking is past ${band.cookTo}, so there are no fish to keep: fish the round until Fishing ${band.to}, ${fishing.about(skillCatches)} catches.`);
		if (loops) {
			for (const w of loops) lines.push(loopLine(w));
		} else {
			if (round.level > band.level) lines.push(`level ${round.level}`);
			// A round of two or more stops is a `loop` (the places of the skill).
			if (round.stops.length > 1) lines.push('loop');
			for (const s of round.stops) lines.push(`goto ${fmt(s.pt.x)},${fmt(s.pt.y)}${liveMark(s.pt)} r ${s.pool ? 25 : STAND_R}`);
		}
		// The fish to hold are a bag count (`anywhere`: the stands are where they bite, not the creatures that
		// also drop them).
		if (withFish) for (const [item, n] of holds) lines.push(`collect ${item} x${n} anywhere`);
		lines.push(`skill Fishing ${band.to}`);
		return lines;
	};
	const title = loops ? `Fishing ${band.from}-${band.to}` : `Fishing: ${zone} (${band.from}-${band.to})`;
	step(title, roundLines(holds.length > 0));
	if (holds.length) step(title, roundLines(false));

	// Cooking: one step per recipe stretch; Journeyman Cooking where the cooking reaches it.
	for (const c of cook) {
		if (c.rank) {
			const info = rankInfo(ctx, 'Cooking', 'Journeyman');
			step('Journeyman Cooking', [only, `tip Journeyman Cooking raises the cap to ${info.max}; it needs skill ${info.minSkill} and no character level, and costs ${money(info.cost)}. The arrow picks the nearest Cooking trainer of your faction.`, 'train Cooking Journeyman']);
			continue;
		}
		const r = c.recipe;
		const colour = c.from < r.yellow ? 'orange' : c.from < r.green ? 'yellow' : 'green';
		const fish = r.fish.map((g) => `${Math.ceil(c.crafts * g.count)} ${itemName(ctx, g.item)}`).join(' and ');
		step(`Cook ${r.name} (${c.from}-${c.to})`, [
			only,
			`tip ${r.name} is ${colour} from ${c.from} (yellow at ${r.yellow}, green at ${r.green}, grey at ${r.grey}): about ${c.crafts} crafts to ${c.to}, ${fish}. Cook at any fire: a town hearth or your own Basic Campfire. Short of fish: fish the round a little longer.`,
			`learn ${r.spell}`,
			`craft ${r.spell} until ${c.to}`,
		]);
	}
	return out;
}

// Forever's own content at a band's waters, from the data: Whimsyfin where players catch it on a round,
// Fishin' Time when Stormwind's water is one of the Alliance's.
function forever(ctx, waters, faction) {
	const out = [];
	const rec = ((ctx.data.professionNamed('Cooking') || {}).recipes || []).find((r) => r.recipeItem === WHIMSYFIN_RECIPE);
	const whimsy = waters.filter((w) => (w.fish[WHIMSYFIN] || 0) >= BITES);
	if (whimsy.length && rec) out.push(`${itemName(ctx, WHIMSYFIN)}, one of Forever's own fish, bites ${waters.length > 1 ? `in ${named(whimsy.map((w) => zoneName(ctx, w.map)))}` : 'here'}: ${rec.name} (Cooking ${rec.learnedAt}) cooks it, from a recipe that drops in the world.`);
	const q = ctx.data.quest(FISHIN_TIME);
	if (q && faction === 'Alliance' && waters.some((w) => w.map === 1453)) {
		const giver = q.start && q.start.npc && q.start.npc[0] && ctx.data.npc(q.start.npc[0]);
		const wants = (q.objectives || []).map((o) => `${o.count} ${itemName(ctx, o.id)}`);
		if (giver) out.push(`From level ${q.minLevel}, ${giver.name} at the Stormwind harbor gives ${q.title}: bring ${named(wants)} for cooked fish.`);
	}
	return out;
}

// Every band's waters as data: [{ item, kind: 'fish', skill: [from, to], side, races, map, levels, guide,
// title, pts }], one entry per water (each farming loop, else the band's one round) and fish that is 5%
// or more of its catch.
function fishLoops(ctx) {
	const out = [];
	const plans = plan(ctx);
	for (const faction of FACTIONS) {
		for (const e of plans[faction]) {
			if (e.kind !== 'band') continue;
			for (const w of e.loops || [e.round]) {
				for (const [item, share] of Object.entries(w.fish)) {
					if (share < 0.05) continue;
					out.push({
						item: Number(item),
						kind: 'fish',
						skill: [e.band.from, e.band.to],
						side: faction,
						races: e.group.races,
						map: w.map,
						levels: [w.level, w.level + 1],
						guide: GUIDE,
						title: e.loops ? `Fishing ${e.band.from}-${e.band.to}` : `Fishing: ${zoneName(ctx, w.map)} (${e.band.from}-${e.band.to})`,
						pts: w.stops.map((s) => [s.pt.x, s.pt.y]),
					});
				}
			}
		}
	}
	return out;
}

module.exports = { file: 'fishing-cooking', skill: 'Fishing', render, plan, fishLoops, roundAt, candidateRounds, loopOnly, sideOf, cookingPlan, fishRecipes, chance, BANDS };
