'use strict';
// The fishing side of Fishing + Cooking 1-300 (the paired guide: ../pair-fishing.js, blended by ../pairs.js):
// the Fishing bands, the waters each band fishes as farming loops, and the cooking those bands' fish carry.
//
// Each fishing band plans its cooking on one water per group of characters (by starting area, then
// faction: BANDS) and walks a round of its stands: the places players stood when they caught fish there
// (fishing-waters.json, from Polestar_Recorder sessions), weighted by how much of the band's fish (`want`)
// players caught there, ordered as a closed loop (loop.js) that leaves out stands near creatures more
// than a level above the band's character level (an elite counts three levels higher), near the other
// faction's towns and guards, and near boat docks. A water with fewer than two stands adds its
// fishing-pool clusters (objects.json). Every other water of the faction's side whose round gives the
// same fish is offered beside it as a farming loop (docs/GUIDE_FORMAT.md, "Farming loops"): the arrow
// takes the one that gets the player the fish soonest from where they are, travel included
// (candidateRounds). A loop's lap counts what makes a water slower and less safe: the hostile creatures
// that would fight the player at its stops (loop.js threats) and the deaths players' recordings show at
// its stands, so the pick prefers the quieter water.
//
// Pairing: each band also takes the cooking to `cookTo` with the fish it catches, as the band's `cook`
// says: per stretch, the first of its recipes whose fish the round gives (RECORDED_MIN recorded catches at
// its stands, else the zone's fishing loot from the world database) or the bags kept from earlier bands
// hold, with the crafts the Classic chance asks (always below yellow, then (grey - skill) / (grey - yellow)).
//
//   plan(ctx) -> per faction, the bands in order: { kind: 'band', band, group, round, loops, need, kept,
//     catches, cook, shop } (loops: the band's farming loops for the group, [] when no round of two stops
//     is safe), with { kind: 'rank' } and { kind: 'artisan' } between them.

const R = require('./route');
const W = require('./waters');
const { buildLoop, hazards, levelFor, roundLevel, threats } = require('./loop');
const { RUN } = require('./farm');
const fishing = require('./fishing');
const { RACE_GROUPS, SIDE, TWO_SIDED, raceCondition } = require('./groups');
const { ZONES } = require('./tables');
const { pathLength } = require('../../route/tour');
const { FACTIONS, fmt, money, zoneName, rankInfo, vendorSpawns, flightMaster, npcSpawn } = require('./common');
const { dist } = require('../../route/geo');

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
// What makes a lap slower and less safe: FIGHT_SECONDS for each hostile creature that would fight the
// player at a stop (a pull fought off every lap: they respawn while the round goes on), and DEATH_SECONDS
// (the run back from the graveyard) for each death players' recordings show at a stand, per catch there.
const FIGHT_SECONDS = 20;
const DEATH_SECONDS = 180;

// The bands. `by`: race (RACE_GROUPS key) or faction; `level`: the least character level the band asks
// (rank gates; the round's hazards may ask more); `want`: the fish the band's cooking is after (they
// weigh the stands); `cookTo`: the cooking skill the band's fish take you to; `cook`: that cooking, in
// order: { spells, from, to }, the first recipe of `spells` whose fish the band's water gives or the bags
// hold; `waters`: the water the band's cooking is planned on. Every other water of the faction whose round
// gives the fish that cooking takes, asks at most `maxLevel` and loses no fish from `lure` skill points
// above the band's start (a lure closes that gap) is a farming loop of the band too, so the arrow takes the
// one that gets the player there soonest from where they are (candidateRounds).
// - Starting areas to Fishing 75: below 75 every catch raises the skill wherever you fish, and their
//   water loses no fish from 25; Brilliant Smallfish or Slitherskin Mackerel to Cooking 50.
// - Capitals to 130: city water loses nothing from 75 and gives Longjaw Mud Snapper (Cooking 50-100) and
//   the first Bristle Whisker Catfish, beside the cooking trainer and supplies; no creatures.
// - Catfish water to 205, for Cooking 100-175: Mystral Lake in Ashenvale (Alliance), where the Expert
//   Cookbook and Nightcrawlers are sold; Stonetalon Mountains (Horde), a flight from the cookbook in Desolace.
// - Dustwallow Marsh's swamp to 225 (no cooking: Nat Pagle, Angler Extreme is taken there at 225), then on
//   to 255 for Mithril Head Trout, Cooking 175-225 (the swamp's inland water: the coast gives cod).
// - Feralas to 300 with Bright Baubles (its water loses fish below 300): the trout kept from the swamp to
//   Cooking 250, then Filet of Redgill to 285 and Nightfin Soup to 300.
const BANDS = [
	{ key: 'start', from: 1, to: 75, cookTo: 50, by: 'race', level: 1, maxLevel: 12, lure: 25, want: [6291, 6303], cook: [{ spells: [7751, 7752], from: 1, to: 50 }], waters: { human: 1429, 'dwarf-gnome': 1426, nightelf: 1438, 'skyborne-a': 2521, 'orc-troll': 1411, tauren: 1412, undead: 1420, 'skyborne-h': 2521 } },
	{ key: 'city', from: 75, to: 130, cookTo: 100, by: 'faction', level: 10, maxLevel: 22, lure: 75, want: [6289, 6308], cook: [{ spells: [7753], from: 50, to: 100 }], waters: { Alliance: 1453, Horde: 1454 } },
	{ key: 'catfish', from: 130, to: 205, cookTo: 175, by: 'faction', level: 20, maxLevel: 32, lure: 75, want: [6308], cook: [{ spells: [7755], from: 100, to: 175 }], waters: { Alliance: 1440, Horde: 1442 } },
	{ key: 'swamp', from: 205, to: 225, cookTo: 175, by: 'faction', level: 30, maxLevel: 45, lure: 75, want: [8365], cook: [], waters: { Alliance: 1434, Horde: 1443 } },
	{ key: 'trout', from: 225, to: 255, cookTo: 225, by: 'faction', level: 35, maxLevel: 45, lure: 0, want: [8365], cook: [{ spells: [20916], from: 175, to: 225 }], waters: { Alliance: 1434, Horde: 1443 } },
	{ key: 'late', from: 255, to: 300, cookTo: 300, by: 'faction', level: 35, maxLevel: 52, lure: 75, want: [13758, 13759], cook: [{ spells: [20916], from: 225, to: 250 }, { spells: [18241], from: 250, to: 285 }, { spells: [18243], from: 285, to: 300 }], waters: { Alliance: 1444, Horde: 1444 }, prefer: [1444] },
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
	const least = levelFor(ctx, map, pts, { faction, min: band.level, need: Math.min(2, pts.length), strict: true });
	if (least === null) throw new Error(`Fishing + Cooking: no safe stand for ${faction} in ${zoneName(ctx, map)}`);
	const fm = flightMaster(ctx, map, faction);
	const loopAt = (level) => buildLoop(pts, ctx.project, { radius: 10, span: SPAN, cover: 0.9, maxStops: MAX_STOPS, entry: fm ? fm.pt : null, avoid: [...hazards(ctx, map, { level, faction, strict: true }), ...transportStops(ctx)] });
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
// stop whose leaving lowers it most is left out (down to two stops). Its `seconds` a lap: the walk, the
// casts, a fight for each hostile creature at a stop that is not grey to the loop's level (`fights`) and
// the deaths recorded at its stands (`deaths`, per catch, times the lap's casts there).
function asLoop(ctx, band, faction, round) {
	let stops = round.stops;
	let walk = roundLevel(ctx, round.map, stops, faction, { strict: true });
	while (walk !== null && walk > round.level && stops.length > 2) {
		let best = null;
		for (let i = 0; i < stops.length; i++) {
			const fewer = stops.filter((_, j) => j !== i);
			const w = roundLevel(ctx, round.map, fewer, faction, { strict: true });
			if (w !== null && (!best || w < best.walk)) best = { stops: fewer, walk: w };
		}
		if (!best || best.walk >= walk) break;
		({ stops, walk } = best);
	}
	if (walk === null) return null;
	const lap = stops.length > 1 ? pathLength(stops[0].pt, stops.slice(1), stops[0].pt) : 0;
	const casts = stops.length * CASTS;
	const level = Math.max(round.level, walk);
	const fights = threats(ctx, round.map, stops, level);
	const deaths = stops.reduce((s, x) => s + (x.stand && x.stand.deaths ? (x.stand.deaths / Math.max(1, x.stand.catches)) * CASTS : 0), 0);
	return {
		...round,
		stops,
		lap,
		level,
		only: loopOnly(round.map, faction),
		casts,
		fights,
		deaths,
		seconds: Math.round(lap / RUN + casts * CAST_SECONDS + fights * FIGHT_SECONDS + deaths * DEATH_SECONDS),
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

// A band's cooking (its `cook` stretches): [{ recipe, from, to, crafts }], and the fish they take
// ({ item: n }). `bites(item)`: the round gives it; `kept`: { item: n } in the bags from earlier bands.
// Throws when no recipe of a stretch has its fish.
function bandCooking(recipes, band, bites, kept) {
	const segs = [];
	const used = {};
	const craftsOf = (r, from, to) => {
		let n = 0;
		for (let s = from; s < to; s++) {
			const p = chance(r, s);
			if (p <= 0) throw new Error(`Fishing + Cooking: ${r.name} is grey at Cooking ${s}`);
			n += 1 / p;
		}
		return n;
	};
	for (const c of band.cook) {
		const r = c.spells
			.map((spell) => recipes.find((x) => x.spell === spell))
			.filter(Boolean)
			.find((x) => x.fish.every((g) => bites(g.item) || (kept[g.item] || 0) - (used[g.item] || 0) >= craftsOf(x, c.from, c.to) * g.count));
		if (!r) throw new Error(`Fishing + Cooking: no fish for Cooking ${c.from}-${c.to} (recipes ${c.spells.join(', ')}) in Fishing ${band.from}-${band.to}`);
		const crafts = craftsOf(r, c.from, c.to);
		for (const g of r.fish) used[g.item] = (used[g.item] || 0) + crafts * g.count;
		segs.push({ recipe: r, from: c.from, to: c.to, crafts: Math.ceil(crafts) });
	}
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
			if (band.key === 'trout') entries.push({ kind: 'artisan' });
			for (const g of groupsOf(band.by, faction)) {
				const members = RACE_GROUPS[faction].filter((r) => !g.races || r.races.some((x) => g.races.includes(x))).map((r) => kept.get(r.key));
				const inv = {};
				for (const item of new Set(members.flatMap((m) => Object.keys(m.inv)))) inv[item] = Math.min(...members.map((m) => m.inv[item] || 0));
				const owned = new Set([...members[0].owned].filter((s) => members.every((m) => m.owned.has(s))));
				const round = roundAt(ctx, band.waters[g.key], faction, band);
				const bites = (item) => bitesAt(round, item);
				const { segs, used } = bandCooking(recipes, band, bites, inv);
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
				// The band's farming loops (the arrow picks one; [] when the planned round is no loop of two
				// stops), and the lure for the water among them that loses fish longest.
				// The other waters give what the band cooks and the fish it is after for later (the capitals' catfish).
				const wanted = [...new Set([...Object.keys(need), ...band.want.map(String)])].filter((item) => bites(item));
				const loops = candidateRounds(ctx, band, faction, round, Object.fromEntries(wanted.map((item) => [item, need[item] || 0])));
				const waters = loops.length ? loops : [round];
				const full = Math.max(0, ...waters.map((w) => w.full || 0));
				const gap = full > band.from ? full - band.from : 0;
				const usable = LURES.filter(([id]) => fishing.lureSkill(ctx, id) <= band.from);
				const lure = gap && usable.length ? usable.find(([, b]) => b >= gap) || usable[usable.length - 1] : null;
				// Enough lures for every catch below the water's `full` (the skill's catches, Classic's rate).
				const lures = lure ? Math.max(1, Math.ceil((fishing.catches(band.from, Math.min(full, band.to)) * CATCH_SECONDS) / LURE_SECONDS)) : 0;
				entries.push({ kind: 'band', band, group: g, round, loops, need, kept: inv, catches, cook, shop: { recipes: shopRecipes, extras: [...extras], lure, lures, full } });
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

// --------------------------------------------------------------------- what the pair's steps say

// A farming loop line (docs/GUIDE_FORMAT.md, "Farming loops"): its strongest creature's level (a level
// above the one its walk asks), a lap's seconds and skill points, who may take it, its stands.
function loopLine(ctx, w) {
	const live = w.stops[0].pt.f === 'l';
	return [`loop ${zoneName(ctx, w.map)}`, `lvl ${w.level + 1}`, `lap ${w.seconds}`, `gain ${fmt(w.gain)}`, `only ${w.only}`, ...(live ? ['live'] : []), `r ${w.stops.some((s) => s.pool) ? 25 : STAND_R}`, 'at', ...w.stops.map((s) => `${fmt(s.pt.x)},${fmt(s.pt.y)}`)].join(' ');
}

// A rank of Fishing or Cooking as steps ([title, lines]): Journeyman at a trainer, Expert from its book.
function rankSteps(ctx, skill, rank) {
	const info = rankInfo(ctx, skill, rank);
	if (rank === 'Journeyman') {
		const gate = info.minLevel > 1 ? ` and character level ${info.minLevel} (Forever's trainer lists ask for that level)` : ' and no character level';
		return [[`Journeyman ${skill}`, [`tip Journeyman ${skill} raises the cap to ${info.max}; it needs skill ${info.minSkill}${gate}, and costs ${money(info.cost)}. The arrow picks the nearest ${skill} trainer of your faction.`, ...(info.minLevel > 1 ? [`level ${info.minLevel}`] : []), `train ${skill} Journeyman`]]];
	}
	const book = info.book;
	const name = itemName(ctx, book.item);
	const P = ctx.data.professionNamed(skill) || {};
	const cost = ((P.materials || {})[book.item] || {}).buy || fishing.price(ctx, book.item);
	const sellers = FACTIONS.map((f) => npcSpawn(ctx, book.vendors[f][0]));
	const same = book.vendors.Alliance[0] === book.vendors.Horde[0];
	const sold = same ? `${sellers[0].name} (${zoneName(ctx, sellers[0].map)}) sells it to both factions` : `sold by ${named(sellers.map((s, i) => `${s.name} (${zoneName(ctx, s.map)}) for the ${FACTIONS[i]}`))}`;
	let tip = `Expert ${skill} (cap ${info.max}) is a book, not a trainer rank: ${name}${cost ? ` (${money(cost)})` : ''}, ${sold}. Buy it and read it; it needs skill ${info.minSkill} and level ${info.minLevel}.`;
	if (skill === 'Fishing') {
		const rack = ctx.data.recipe(fishing.FISHING_RACK);
		tip += ` At level 20 the safe way to Booty Bay is the boat from Ratchet in The Barrens. ${sellers[0].name} also sells Bright Baubles${fishing.note(ctx, fishing.BRIGHT_BAUBLES, 75, true)}, the lure for harder water.`;
		if (rack && rack.recipe) tip += ` Forever's ${rack.recipe.name} (a camping item, from Fishing ${rack.recipe.learnedAt}) is a blueprint that drops from Gelihast in Blackfathom Deeps.`;
	}
	return [[`Expert ${skill}`, [`tip ${tip}`, `level ${info.minLevel}`, `train ${skill} Expert "Buy and read ${name} (Expert ${skill})"`]]];
}

// The lines of a band's lure step (`shop`: plan's), for one water or several.
function lureLines(ctx, band, shop, several) {
	const to = Math.min(shop.full, band.to);
	return [
		`when !skill Fishing ${shop.full}`,
		`tip ${several ? 'Some of these waters lose' : 'This water loses'} fish below Fishing ${shop.full}: a lure on the pole adds to your skill for ten minutes. ${itemName(ctx, shop.lure[0])}${fishing.note(ctx, shop.lure[0], shop.lure[1], true)}${shop.lure[1] >= shop.full - band.from ? ` closes the gap from ${band.from}` : ` is the strongest you can use at ${band.from}`}: about ${shop.lures} ${shop.lures > 1 ? 'see' : 'sees'} you to ${to} (${Math.round((fishing.catches(band.from, to) * CATCH_SECONDS) / 60)} minutes of fishing).`,
		`buy ${shop.lure[0]} x${shop.lures} nearest`,
	];
}

// Forever's own content at a band's waters, from the data: Whimsyfin where players catch it on a round,
// Fishin' Time when Stormwind's water is one of the Alliance's.
function forever(ctx, waters, faction) {
	const out = [];
	const rec = ((ctx.data.professionNamed('Cooking') || {}).recipes || []).find((r) => r.recipeItem === WHIMSYFIN_RECIPE);
	const whimsy = waters.filter((w) => (w.fish[WHIMSYFIN] || 0) >= BITES);
	if (whimsy.length && rec) out.push(`${itemName(ctx, WHIMSYFIN)}, one of Forever's own fish, bites in ${named([...new Set(whimsy.map((w) => zoneName(ctx, w.map)))])}: ${rec.name} (Cooking ${rec.learnedAt}) cooks it, from a recipe that drops in the world.`);
	const q = ctx.data.quest(FISHIN_TIME);
	if (q && faction === 'Alliance' && waters.some((w) => w.map === 1453)) {
		const giver = q.start && q.start.npc && q.start.npc[0] && ctx.data.npc(q.start.npc[0]);
		const wants = (q.objectives || []).map((o) => `${o.count} ${itemName(ctx, o.id)}`);
		if (giver) out.push(`From level ${q.minLevel}, ${giver.name} at the Stormwind harbor gives ${q.title}: bring ${named(wants)} for cooked fish.`);
	}
	return out;
}

module.exports = { BANDS, CASTS, CAST_SECONDS, plan, roundAt, asLoop, candidateRounds, loopOnly, sideOf, bitesAt, bandCooking, fishRecipes, sellersOf, chance, loopLine, rankSteps, lureLines, forever };
