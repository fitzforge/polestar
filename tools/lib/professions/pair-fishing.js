'use strict';
// Fishing + Cooking as a paired guide (pairs.js renderPair, like the other pairs). The gathering side is the
// Fishing bands and the waters each fishes (gathering/fish-rounds.js: per band and faction, the stand rounds
// of every water of the side that gives the band's fish, one farming loop each); the crafting side is the
// cooking those bands' fish carry (fish-rounds.js plan: per band, its `cook` stretches, each the first of
// its recipes whose fish the band's water gives or the bags hold), cut at the Cooking ranks' caps into sections. The
// blend is pairs.js's: before each cooking stretch a fishing step sized to the fish it still needs (its loops
// the band's waters, the arrow taking the one that gets the player the fish soonest), then the cooking.
//
// Where the cooking differs between groups of characters (the starting areas: Brilliant Smallfish by some
// starting waters, Slitherskin Mackerel by others), each group's stretches are a variant (`variant <only>`
// lines, which pairs.js turns into the steps' `only`): each starts from the same state, and the route goes
// on from what all of them leave (the least of each fish, the lowest skill). A band then has a track entry
// per variant (`who`) and one over all its waters for the steps every group shares (`shadowed` while a
// variant runs).
//
// Fishing's ranks are their own steps where the Fishing guide has them (Journeyman at a trainer from level
// 10, Expert from Old Man Heming's book, Artisan from Nat Pagle's quests), never folded into a cooking
// trainer visit; Cooking's are the sections' first steps (Expert from its book, Artisan from Clamlette
// Surprise).
//
//   fishingSide(ctx) -> { prof, track, draft, header, coords, gatherNote } for renderPair

const FR = require('./gathering/fish-rounds');
const fishing = require('./gathering/fishing');
const secondary = require('./gathering/secondary');
const { FACTIONS, fmt, money, rankInfo, zoneName } = require('./gathering/common');
const { raceCondition } = require('./gathering/groups');
const { ERA_NOTE } = require('./gathering/notes');
const D = require('./describe');

// The Cooking ranks' sections: [rank, from, to].
const SECTIONS = [
	['Apprentice', 1, 75],
	['Journeyman', 75, 150],
	['Expert', 150, 225],
	['Artisan', 225, 300],
];

// The `only` of a set of plan entries: their races (with the side for a two-sided race of one faction), else
// their factions.
function whoOf(entries) {
	const factions = [...new Set(entries.map((e) => e.group.faction))];
	if (entries.every((e) => e.group.races)) return raceCondition(entries.flatMap((e) => e.group.races), factions);
	return factions.join(',');
}

// A band's track entry over some plan entries' waters: every loop once, the rates pairs.js simulates with
// (per catch: Fishing points, the share of each fish; a lap's seconds and catches), averaged over the loops.
// Entries with no loop (a starting area whose water has one stand players fish at: Teldrassil, Durotar)
// fish their planned round's stand: the entry is `solo` (its zone and the stand), one place to stand at.
function bandEntry(ctx, band, entries, who, shadowed) {
	const seen = new Set();
	let loops = [];
	let solo = null;
	for (const e of entries) {
		for (const w of e.loops) {
			const line = `  ${FR.loopLine(ctx, w)}`;
			if (seen.has(line)) continue;
			seen.add(line);
			loops.push({ ...w, line });
		}
	}
	if (!loops.length) {
		const rounds = [...new Map(entries.map((e) => [e.round.map, e.round])).values()];
		if (rounds.length !== 1) throw new Error(`Fishing + Cooking: no fishing loop of two stands for Fishing ${band.from}-${band.to}${who ? ` (${who})` : ''}, and ${rounds.length} single stands`);
		const r = rounds[0];
		const pt = r.stops[0].pt;
		solo = { zone: zoneName(ctx, r.map), at: `${fmt(pt.x)},${fmt(pt.y)}${pt.f === 'l' ? ' live' : ''}` };
		const casts = r.stops.length * FR.CASTS;
		loops = [{ ...r, casts, seconds: casts * FR.CAST_SECONDS }];
	}
	const perLoop = loops.map((w) => new Map(Object.entries(w.fish).filter(([item]) => FR.bitesAt(w, item)).map(([item, s]) => [Number(item), s * w.casts])));
	const items = new Map();
	loops.forEach((w, i) => {
		for (const [item, n] of perLoop[i]) items.set(item, (items.get(item) || 0) + n / w.casts / loops.length);
	});
	const avg = (f) => loops.reduce((s, w) => s + f(w), 0) / loops.length;
	const name = (id) => (ctx.data.item(id) || {}).name || `item ${id}`;
	return {
		kind: 'band',
		key: band.key,
		from: band.from,
		to: band.to,
		who,
		shadowed,
		loops,
		solo,
		perLoop,
		rate: { gain: (band.to - band.from) / fishing.catches(band.from, band.to), items, lap: avg((w) => w.seconds), up: avg((w) => w.casts) },
		title: solo ? `${solo.zone}'s water` : `${D.list(band.want.map(name))} water`,
	};
}

// A Fishing rank as a track entry with its own steps.
function rankEntry(ctx, rank, steps) {
	const info = rankInfo(ctx, 'Fishing', rank);
	return { kind: 'train', rank: { name: rank, learnAt: info.minSkill, max: info.max }, steps };
}

function fishingSide(ctx) {
	const plans = FR.plan(ctx);
	const P = ctx.data.professionNamed('Cooking') || {};
	const mats = P.materials || {};
	const itemName = (id) => (ctx.data.item(id) || {}).name || `item ${id}`;

	// ------------------------------------------------------------ the fishing track
	const byBand = new Map(FR.BANDS.map((b) => [b.key, []]));
	for (const f of FACTIONS) for (const e of plans[f]) if (e.kind === 'band') byBand.get(e.band.key).push(e);
	const track = [{ kind: 'learn' }];
	const cooking = [];
	for (const band of FR.BANDS) {
		if (band.key === 'city') track.push(rankEntry(ctx, 'Journeyman', FR.rankSteps(ctx, 'Fishing', 'Journeyman')));
		if (band.key === 'catfish') track.push(rankEntry(ctx, 'Expert', FR.rankSteps(ctx, 'Fishing', 'Expert')));
		if (band.key === 'trout') {
			const steps = [];
			fishing.pagleSteps(ctx, (title, lines) => steps.push([title, lines]));
			track.push(rankEntry(ctx, 'Artisan', steps));
		}
		const list = byBand.get(band.key);
		// Groups with the same cooking share a variant (one variant is none); a group that fishes a single
		// stand (no loop) is one of its own, at that stand.
		const sig = new Map();
		for (const e of list) {
			const key = `${e.cook
				.filter((c) => !c.rank)
				.map((c) => `${c.recipe.spell}:${c.from}-${c.to}`)
				.join(' ')}${e.loops.length ? '' : ` @${e.round.map}`}`;
			if (!sig.has(key)) sig.set(key, []);
			sig.get(key).push(e);
		}
		const variants = [...sig.values()].map((entries) => ({ who: sig.size > 1 ? whoOf(entries) : null, entries }));
		for (const v of variants) if (v.who) track.push(bandEntry(ctx, band, v.entries, v.who, false));
		track.push(bandEntry(ctx, band, list, null, variants.length > 1));
		cooking.push({ band, variants, entries: list });
	}

	// ------------------------------------------------------------ the cooking draft
	const L = [];
	const step = (title, lines) => L.push('', `step ${title}`, ...lines.map((l) => `  ${l}`));
	const segments = [];
	const apC = rankInfo(ctx, 'Cooking', 'Apprentice');
	const bowl = ctx.data.recipe(1229745).recipe;
	L.push(
		'# Cooking turns the fish into food: each recipe here is a vendor recipe whose fish the band you fish',
		'# then gives, the one with the best chance of a skill-up at each point (orange first, the one already',
		'# on when two tie). Recipes and spices are bought from the vendor nearest you; Expert Cooking is a',
		'# book and Artisan Cooking is Clamlette Surprise in Tanaris.',
	);
	let sec = -1;
	const open = (i) => {
		const [rank, from, to] = SECTIONS[i];
		L.push('', `# ---------------------------------------------------------------- ${rank} (${from}-${to})`, `section Cooking ${from}-${to}`);
		if (i === 0) {
			step('Learn Cooking', [
				`tip Any Cooking trainer of your faction teaches Apprentice Cooking (${money(apC.cost)}) at any character level; the arrow picks the nearest, and every starting area has one. Forever: every cook knows Basic Campfire: a Basic Campfire Kit from one Simple Wood with Flint and Tinder lights a cooking fire anywhere, so you can cook beside the water. If you sat at your starting area's campfire for The Great Outdoors, its camping guide also offers Camping 101: Fishing (handed in at Fishing 20 for the ${bowl.name} recipe) and Camping 101: Cooking.`,
				'train Cooking Apprentice',
				'skill Cooking 1',
			]);
		} else if (i === 3) {
			for (const s of secondary.clamletteSteps(ctx)) step(s.title, s.raw);
		} else for (const [t, lines] of FR.rankSteps(ctx, 'Cooking', rank)) step(t, lines);
	};
	// The recipes each variant's characters hold ('' for every character).
	const owned = new Map([['', new Set()]]);
	const learnedIn = new Map(); // recipe spell -> the section its first learn is in
	const holds = (who, spell) => owned.get('').has(spell) || (who !== null && (owned.get(who) || new Set()).has(spell));
	const own = (who, spell) => {
		const k = who || '';
		if (!owned.has(k)) owned.set(k, new Set());
		owned.get(k).add(spell);
	};
	// A cooking stretch cut at the rank caps.
	const pieces = (c) => {
		const out = [];
		let a = c.from;
		for (const [, , cap] of SECTIONS) {
			if (a >= cap || a >= c.to) continue;
			const b = Math.min(c.to, cap);
			out.push({ from: a, to: b });
			a = b;
		}
		return out;
	};
	// "Sold by Alliance: Tharynn Bouden (Elwynn Forest), ...; Horde: ...": up to three sellers a side.
	const soldBy = (item, factions) => {
		const per = factions.map((f) => [f, FR.sellersOf(ctx, mats, item, f).slice(0, 3).map((v) => `${v.name} (${zoneName(ctx, v.map)})`)]);
		const parts = per.filter(([, names]) => names.length);
		if (parts.length === 1 && factions.length === 1) return `Sold by ${D.list(parts[0][1])}.`;
		return `Sold by ${parts.map(([f, names]) => `${f}: ${D.list(names)}`).join('; ')}.`;
	};
	const reagents = (r) => D.list(r.reagents.map((g) => `${g.count} ${itemName(g.item)}`));
	let last = null;
	for (const { band, variants, entries } of cooking) {
		// The band's lures: one step per lure the groups take (the waters of some lose fish below `full`).
		const lureSets = new Map();
		for (const e of entries) {
			if (!e.shop.lure) continue;
			const k = `${e.shop.lure[0]}|${e.shop.lures}|${e.shop.full}`;
			if (!lureSets.has(k)) lureSets.set(k, []);
			lureSets.get(k).push(e);
		}
		let lured = false;
		const lures = () => {
			if (lured) return;
			lured = true;
			for (const es of lureSets.values()) step(`Lures for Fishing ${band.from}-${band.to}`, [...(es.length === entries.length ? [] : [`only ${whoOf(es)}`]), ...FR.lureLines(ctx, band, es[0].shop, es.some((e) => e.loops.length > 1))]);
		};
		// What Forever adds at the band's waters, said once on its first cooking step.
		const notes = [...new Set(FACTIONS.flatMap((f) => FR.forever(ctx, entries.filter((e) => e.group.faction === f).flatMap((e) => e.loops), f)))];
		for (const v of variants) {
			const factions = [...new Set(v.entries.map((e) => e.group.faction))];
			const tag = v.who ? [`variant ${v.who}`] : [];
			for (const c of v.entries[0].cook.filter((x) => !x.rank)) {
				const r = c.recipe;
				for (const piece of pieces(c)) {
					while (sec + 1 < SECTIONS.length && piece.from >= SECTIONS[sec + 1][1]) {
						if (v.who && sec >= 0) throw new Error(`Fishing + Cooking: the ${v.who} cooking of Fishing ${band.from}-${band.to} crosses Cooking ${SECTIONS[sec + 1][1]} (a variant stays in one section)`);
						open(++sec);
					}
					lures();
					const fresh = !holds(v.who, r.spell);
					const extras = r.extra.map((x) => ({ item: x.item, count: Math.ceil(secondary.expectedCrafts(r, piece.from, piece.to) * x.count) }));
					const buys = extras.map((x) => `buy ${x.item} x${x.count} nearest`);
					const extraText = extras.length ? `; ${D.list(extras.map((x) => `${x.count} ${itemName(x.item)}`))} for the crafts` : '';
					if (fresh) {
						const cost = (mats[r.recipeItem] || {}).buy || r.cost;
						step(`Cooking recipes at ${piece.from}`, [...tag, `tip ${itemName(r.recipeItem)} teaches ${r.name} (Cooking ${r.learnedAt}${cost ? `, ${money(cost)}` : ''})${extraText}. ${soldBy(r.recipeItem, factions)} The arrow picks the nearest seller of your faction.`, `buy ${r.recipeItem} x1 nearest`, ...buys]);
						own(v.who, r.spell);
					} else if (buys.length) step(`Cooking ${piece.from}-${piece.to}: vendor goods`, [...tag, `tip ${D.list(extras.map((x) => `${x.count} ${itemName(x.item)}`))} for ${r.name}: a cooking supplies or trade goods vendor sells them, and the arrow picks the nearest.`, ...buys]);
					const count = secondary.expectedCrafts(r, piece.from, piece.to);
					const count90 = secondary.crafts90(r, piece.from, piece.to);
					const colour = piece.from < r.yellow ? 'orange' : piece.from < r.green ? 'yellow' : 'green';
					// A recipe learned in an earlier section is learned again here: a player who came into this
					// section past that one never saw its step (#3401).
					const again = !fresh && learnedIn.get(r.spell) !== sec;
					if (fresh) learnedIn.set(r.spell, sec);
					const tip = [
						`${r.name} is ${colour} at ${piece.from} (yellow ${r.yellow}, green ${r.green}, grey ${r.grey}): about ${count} crafts to ${piece.to}${colour === 'orange' && piece.to <= r.yellow ? ', a point every craft' : ''}${count90 > count ? `, up to ${count90} for 9 players in 10 (the fish above count that many)` : ''}.`,
						`Each takes ${reagents(r)}. Cook at any fire: a town hearth or your own Basic Campfire.`,
						...(again ? [`If you got here without learning ${r.name}, learn it now: an earlier step teaches it.`] : []),
						...notes.splice(0),
					];
					const lines = [...tag, `tip ${tip.join(' ')}`];
					if (fresh || again) lines.push(`learn ${r.spell} -- from the recipe in your bags`);
					lines.push(`craft ${r.spell} until ${piece.to}`);
					if (piece.to === 300) lines.push('skill Cooking 300');
					step(`${r.name} to ${piece.to}`, lines);
					segments.push({ recipe: r, from: piece.from, to: piece.to, count, count90, need: [...r.fish.map((g) => ({ item: g.item, count: count90 * g.count })), ...extras] });
					last = piece.to;
				}
			}
			// A variant's band ends inside it: the steps every group shares fish other waters.
			if (v.who) step(`@raise ${band.to}`, tag);
		}
	}
	if (last !== 300) throw new Error(`Fishing + Cooking: the cooking ends at ${last}`);

	const pole = `Buy a Fishing Pole${fishing.note(ctx, fishing.POLE)} and equip it: you can only fish with a pole in your hands.`;
	return {
		prof: { tool: { item: fishing.POLE, text: pole } },
		track,
		draft: { text: `${L.join('\n')}\n`, plan: { segments }, alt: null },
		coords: 'era',
		gatherNote: 'At the water it leads stand to stand: stay while you catch fish (casting holds the arrow there), walk on when a pool is fished out or the spot is busy.',
		header: [
			'Fishing and Cooking 1-300 together, for both factions: each Cooking stretch starts with a Fishing step sized to the fish that stretch still needs, which also raises Fishing, and the cooking follows with the fish in your bags. Spares carry to the next stretch, and when a stretch needs a fish Fishing cannot catch yet, Fishing catches up first. Fishing reaches 300 before the last Cooking stretch.',
			"Each Fishing step offers its band's waters as farming loops: a round of stands, the places players stood when they caught the band's fish (Polestar_Recorder sessions, three or more players each), leaving out stands near creatures more than a level above the band's level (an elite counts three levels higher), near the other faction's towns and guards, and boat docks. The arrow takes the one water that gets you the fish soonest from where you are, travel included, and walks its stands; a water's lap counts the hostile creatures by its stands and the deaths players' recordings show there, so the quieter water wins a close call. Starting areas to 75, the capitals and other Longjaw Mud Snapper water to 130, catfish water to 205, Mithril Head Trout water to 225, Nat Pagle for Artisan, trout water to 255, then Feralas to 300 for Redgill and Nightfin Snapper.",
			"What bites at a water: the recorded catches at its stands (100 or more), else the zone's fishing loot from Forever's server data; when a water loses no fish: its base fishing skill + 95 (Forever's server data). Recipes, their skill colours, prices and sellers are the data's (professions.json, Cooking). The fish can be bought at the Auction House instead of caught (Gather, Buy or Mix).",
			"ASSUMED: catches per point follow Classic's rate (every catch below 75, then one in (skill - 50) / 25), averaged over each band; cooking skill-ups the Classic chance; a loop's lap is its walk at 7 yards a second, five casts of 12 seconds at each stand, 20 seconds for each hostile creature by a stand and three minutes for each death recorded there, per catch.",
			'Not routed: the Ravaged Fishing Pole (one source, no loot row in the server data), Recipe: Plated Armorfish (one source), the Winter Frontier Fishery quests (Winter Squid only bites in winter).',
			ERA_NOTE.join(' '),
		],
	};
}

module.exports = { fishingSide, whoOf };
