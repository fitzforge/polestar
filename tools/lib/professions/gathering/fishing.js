'use strict';
// Fishing 1-300 guide (see build.js). Fishing gains skill per catch wherever
// you fish; low skill only makes fish get away in harder waters. So the guide
// sends each group to water near where it levels: the shore beside a starting
// area's fishing trainer, then a fishing-pool cluster from objects.json (role
// fishing). Expert comes from a book (professions.json rank `book`), Artisan
// from Nat Pagle's quest (quests 6608/6609 -> 6607); his four fish are placed
// on their fishing-location objects (objects.json).
//
// Two Classic rules drive the numbers (Forever's notes say fishing is
// unchanged; the header flags both as ASSUMED):
// - catches per skill point: every catch raises the skill below 75, then one
//   catch in (skill - 50) / 25 does (`catches`);
// - getaways: a zone loses no fish from its base skill + 95 (`full` below: the
//   Forever TrinityCore DB's skill_fishing_base_level, Classic values, + 95).

const fs = require('node:fs');
const path = require('node:path');
const R = require('./route');
const { RACE_GROUPS, REGIONS, raceCondition } = require('./groups');
const { dist } = require('../../route/geo');
const { FACTIONS, GUIDE_HEADER, fmt, liveMark, money, zoneName, npcSpawn, rankInfo, flightMaster } = require('./common');
const { byBanners } = require('../sections');
const { ERA_NOTE } = require('./notes');

const POLE = 6256;
const STRONG_POLE = 6365;
const SHINY_BAUBLE = 6529;
const NIGHTCRAWLERS = 6530;
const BRIGHT_BAUBLES = 6532;
const FISH_ATTRACTOR = 6533;
const FISHING_RACK = 1262990;

// Where each group fishes first: the shore beside its starting area's fishing
// trainer (`at`), water that loses no fish from skill 25. Zephras Isle has no
// pools and no base skill in the data: fish beside Valanaar's fishing trainer.
const START_SPOTS = {
	human: { zone: 1429, at: 1651, label: 'Crystal Lake', full: 25 },
	'dwarf-gnome': { zone: 1426, at: 1700, label: 'Iceflow Lake', full: 25 },
	nightelf: { zone: 1438, at: 3607, label: "Rut'theran Village", full: 25 },
	'orc-troll': { zone: 1411, at: 5941, label: "Sen'jin coast", full: 25 },
	tauren: { zone: 1412, at: 5938, label: 'Stonebull Lake', full: 25 },
	undead: { zone: 1420, at: 5690, label: 'Brightwater Lake', full: 25 },
	'skyborne-a': { zone: 2521, at: 257008, label: 'Valanaar shore' },
	'skyborne-h': { zone: 2521, at: 257008, label: 'Valanaar shore' },
};
const NEXT_SPOTS = {
	human: { zone: 1436, pools: true, label: 'Westfall coast', full: 75 },
	'dwarf-gnome': { zone: 1432, pools: true, label: 'The Loch', full: 75 },
	nightelf: { zone: 1439, pools: true, label: 'Darkshore coast', full: 75 },
	'orc-troll': { zone: 1413, pools: true, label: 'Barrens oasis', full: 75 },
	tauren: { zone: 1413, pools: true, label: 'Barrens oasis', full: 75 },
	undead: { zone: 1421, pools: true, label: 'Lordamere Lake', full: 75, anchor: 6570 }, // Fenwick Thatros at the Decrepit Ferry, not the west coast near the Sepulcher (#718)
	'skyborne-a': { zone: 1436, pools: true, label: 'Westfall coast', full: 75 },
	'skyborne-h': { zone: 1413, pools: true, label: 'Barrens oasis', full: 75 },
};
// Horde Kalimdor fishes Mirkfallon Lake's pools, north of Sun Rock Retreat:
// Ashenvale's pools nearest Splintertree are Mystral Lake's, beside the
// Alliance's Silverwind Refuge.
const REGION_SPOTS = {
	'alliance-ek': { zone: 1437, pools: true, label: 'Wetlands coast', full: 150 },
	'alliance-kalimdor': { zone: 1440, pools: true, label: 'Ashenvale waters', full: 150 },
	'horde-kalimdor': { zone: 1442, pools: true, label: 'Mirkfallon Lake', full: 150 },
	'horde-ek': { zone: 1424, pools: true, label: 'Hillsbrad coast', full: 150 },
};
const LATE_SPOT = { zone: 1434, pools: true, label: 'Booty Bay coast', full: 225 };

// Nat Pagle's four fish (quest 6607): the fishing-location object of each
// (objects.json), the spot nearest the faction's flight master in the zone.
// One catch in five brings the fish up there (the TDB's fishing loot, 20%).
const PAGLE_FISH = [
	{ item: 16968, zone: 1443, object: 400008, full: 225, where: "the coast of Desolace (Sar'theris Strand in the north-west, or the shore west of Shadowprey Village)" },
	{ item: 16967, zone: 1444, object: 400006, full: 300, where: 'the Verdantis River in Feralas (south-east of Dire Maul)' },
	{ item: 16969, zone: 1434, object: 400009, full: 225, where: "Stranglethorn Vale's Savage Coast (the west shore)" },
	{ item: 16970, zone: 1435, object: 400007, full: 225, where: 'the Misty Reed Strand (the east shore of Swamp of Sorrows)' },
];
const PAGLE_RATE = 'about one catch in five';

// Expected catches from skill `from` to `to` (Classic's rate, see the top).
function catches(from, to) {
	let n = 0;
	for (let s = Math.max(1, from); s < to; s++) n += s < 75 ? 1 : (s - 50) / 25;
	return n;
}

function about(n) {
	const step = n >= 200 ? 50 : n >= 60 ? 10 : 5;
	return `about ${Math.max(step, Math.round(n / step) * step)}`;
}

// An item's Codex record (data/forever/codex/items.json: vendor prices, the
// skill it asks for), or {} without the Codex.
const codexCache = new Map();
function codexItem(ctx, item) {
	const dir = ctx.data.dir || '';
	if (!codexCache.has(dir)) {
		const file = path.join(dir, 'codex', 'items.json');
		codexCache.set(dir, fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : {});
	}
	return codexCache.get(dir)[String(item)] || {};
}

// The lowest vendor price of an item, or 0.
function price(ctx, item) {
	const costs = (codexItem(ctx, item).sources || []).filter((s) => s.type === 'vendor' && s.cost > 0).map((s) => s.cost);
	return costs.length ? Math.min(...costs) : 0;
}

// " from skill 50" when the item asks for Fishing skill.
function fromSkill(ctx, item) {
	const it = codexItem(ctx, item);
	return it.reqSkill === 356 && it.reqSkillRank > 0 ? ` from skill ${it.reqSkillRank}` : '';
}

function itemName(ctx, id) {
	return ctx.data.item(id).name;
}

// " (+50 from skill 50, 1s each)": a lure's or pole's bonus, the skill it asks
// for and its vendor price, whichever are known.
function note(ctx, id, bonus = 0, each = false) {
	const parts = [];
	if (bonus) parts.push(`+${bonus}${fromSkill(ctx, id)}`);
	const p = price(ctx, id);
	if (p) parts.push(`${money(p)}${each ? ' each' : ''}`);
	return parts.length ? ` (${parts.join(', ')})` : '';
}

function fishingPoints(ctx, zone) {
	const out = [];
	for (const o of Object.values(ctx.data.objects)) {
		if (!o.roles || !o.roles.includes('fishing')) continue;
		const s = o.spawns && o.spawns[String(zone)];
		if (!s) continue;
		for (const [x, y] of R.allPoints(s)) out.push({ name: o.name, w: 1, pt: ctx.project.point(zone, x, y, s.f) });
	}
	return out;
}

function objectPoints(ctx, zone, id) {
	const o = ctx.data.objects[String(id)];
	const s = o && o.spawns && o.spawns[String(zone)];
	return R.allPoints(s).map(([x, y]) => ({ name: o.name, w: 1, pt: ctx.project.point(zone, x, y, s.f) }));
}

// The water cluster nearest `anchor`: pools (3+ in 80 yards when there are
// such), or any spot of a fishing-location object; `at` is an NPC's shore.
function spot(ctx, def, anchor) {
	if (def.at) {
		const n = npcSpawn(ctx, def.at, def.zone);
		return n ? { pt: n.pt } : null;
	}
	const pts = def.object ? objectPoints(ctx, def.zone, def.object) : fishingPoints(ctx, def.zone);
	if (!pts.length) return null;
	const cl = R.weightedClusters(pts, 80, ctx.project);
	const big = def.object ? cl : cl.filter((c) => c.w >= 3);
	const list = big.length ? big : cl;
	let best = list[0];
	if (anchor) for (const c of list) if (dist(anchor, c.pt) < dist(anchor, best.pt)) best = c;
	return best;
}

// Where to look for water: the spot's own anchor NPC, else the faction's
// flight master in the zone, else mid-zone.
function anchorFor(ctx, def, faction) {
	const own = def.anchor && npcSpawn(ctx, def.anchor);
	if (own) return own.pt;
	const fm = flightMaster(ctx, def.zone, faction);
	if (fm) return fm.pt;
	return ctx.project.point(def.zone, 50, 50, 'e');
}

// What a band's water asks of the pole: from `full` nothing gets away.
function waterTip(ctx, def, from) {
	if (!def.full) return '';
	if (from >= def.full) return ` From skill ${def.full} this water loses no fish, so no lure is needed.`;
	return ` Fish get away here below skill ${def.full}; a lure on the pole adds to your skill for ten minutes and closes the gap.`;
}

function render(ctx) {
	const L = [];
	const step = (title, lines) => {
		L.push('', `step ${title}`, ...lines.map((l) => `  ${l}`));
	};
	const section = (s) => L.push('', `# ---------------------------------------------------------------- ${s}`);
	const spotLines = (def, anchor, to, tip) => {
		const c = spot(ctx, def, anchor);
		if (!c) throw new Error(`Fishing: no water found in ${zoneName(ctx, def.zone)}`);
		return { pt: c.pt, lines: [`zone ${zoneName(ctx, def.zone)}`, `tip ${tip}`, `goto ${fmt(c.pt.x)},${fmt(c.pt.y)}${liveMark(c.pt)} "${def.label}" r 25`, `skill Fishing ${to}`] };
	};

	L.push(GUIDE_HEADER, 'guide forever/professions/fishing', 'title Fishing 1-300', 'category Professions', 'coords era', 'levels 5-60', 'zone Ironforge', '');
	for (const c of [
		'Fishing 1-300 for both factions. Every catch can raise the skill wherever you',
		'fish; low skill only makes fish get away in harder waters, so each band sends',
		'you to water near where you level: the shore beside your starting area\'s',
		'fishing trainer, then fishing-pool clusters from objects.json. Expert Fishing',
		'is a book sold by Old Man Heming in Booty Bay; Artisan Fishing is Nat Pagle\'s',
		'quest in Dustwallow Marsh (four rare fish). About 1,300 catches in all.',
		'',
		...ERA_NOTE,
		"ASSUMED: catches per point follow Classic's rate (every catch below 75, then",
		'one in (skill - 50) / 25) and a zone loses no fish from its Classic base skill',
		"+ 95 (25 starting areas, 75 their neighbours, 150, 225 Stranglethorn, 300",
		"Feralas); Forever's notes say fishing is unchanged. In-game check: catches",
		'from 150 to 160, and fish lost at skill 1 in a starting area.',
	])
		L.push(c ? `# ${c}` : '#');

	// Groups that fish the same water share a step.
	const spotSteps = (groups, spots, faction, from, to, tip) => {
		const byKey = new Map();
		for (const g of groups) {
			const def = spots[g.key];
			const key = `${def.zone}|${def.label}|${def.anchor || ''}`;
			if (!byKey.has(key)) byKey.set(key, { def, races: [] });
			byKey.get(key).races.push(...g.races);
		}
		for (const { def, races } of byKey.values()) {
			const s = spotLines(def, anchorFor(ctx, def, faction), to, `${tip}${waterTip(ctx, def, from)}`);
			step(`Fishing: ${zoneName(ctx, def.zone)} (${from}-${to})`, [`only ${raceCondition(races, [faction])}`, ...s.lines]);
		}
	};

	section('Apprentice');
	const apprentice = rankInfo(ctx, 'Fishing', 'Apprentice');
	const bowl = ctx.data.recipe(1229745).recipe;
	step('Learn Fishing', [
		`tip Any Fishing trainer of your faction teaches Apprentice Fishing (character level 5, ${money(apprentice.cost)}); the arrow picks the nearest, and every starting area has one on its lake or shore. Buy a Fishing Pole${note(ctx, POLE)} from a trade goods or fishing vendor and equip it (you can only fish with a pole in your hands), and two or three Shiny Baubles${note(ctx, SHINY_BAUBLE, 25, true)}: a lure adds its bonus to your skill for ten minutes, so fewer fish get away at the start. If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: Fishing, handed in to the fishing trainer it names at skill 20 for the ${bowl.name} recipe.`,
		'level 5',
		'train Fishing Apprentice',
		`buy ${POLE} x1 nearest`,
	]);

	section('Fishing 1-50');
	const journeyman = rankInfo(ctx, 'Fishing', 'Journeyman');
	for (const faction of FACTIONS)
		spotSteps(RACE_GROUPS[faction], START_SPOTS, faction, 1, 50, `Fish here until skill 50, ${about(catches(1, 50))} catches: below 75 every catch raises the skill. Cast Fishing from your spellbook, click the bobber when it splashes. Keep the fish: they are your first Cooking ingredients.`);
	step('Journeyman Fishing', [
		`tip Journeyman Fishing raises the cap to ${journeyman.max}; it needs skill ${journeyman.minSkill} and character level ${journeyman.minLevel} (Forever's sniffed trainer lists ask for that level), and costs ${money(journeyman.cost)}. The arrow picks the nearest Fishing trainer of your faction. ${bowl.name}, Forever's camping item for Fishing (from skill ${bowl.learnedAt}, ${money(bowl.cost)} or free from Camping 101: Fishing), is a Raw Brilliant Smallfish in an Empty Vial: it gives no skill, but placed beside a campfire it gives everyone at the camp a buff for an hour.`,
		`level ${journeyman.minLevel}`,
		'train Fishing Journeyman',
		`learn ${bowl.spell}`,
	]);

	section('Fishing 50-125');
	const expert = rankInfo(ctx, 'Fishing', 'Expert');
	for (const faction of FACTIONS)
		spotSteps(
			RACE_GROUPS[faction],
			NEXT_SPOTS,
			faction,
			50,
			expert.minSkill,
			`Fish the pools and open water here until skill ${expert.minSkill}, ${about(catches(50, expert.minSkill))} catches: from 75 a catch raises the skill less often (about one in two by 100, one in three by 125). Pools (floating wreckage, schools of fish) also give extra loot. Nightcrawlers${note(ctx, NIGHTCRAWLERS, 50, true)} are twice as strong as a Shiny Bauble. The Strong Fishing Pole${note(ctx, STRONG_POLE, 5)} is in limited stock at fishing vendors: buy it when you see it.`,
		);

	section('Expert Fishing');
	const seller = npcSpawn(ctx, expert.book.vendors.Alliance[0]);
	const bookName = itemName(ctx, expert.book.item);
	const bookPrice = (((ctx.data.professionNamed('Fishing') || {}).materials || {})[expert.book.item] || {}).buy || price(ctx, expert.book.item);
	step('Expert Fishing', [
		`tip Expert Fishing (cap ${expert.max}) is a book, not a trainer rank: ${seller.name} sells ${bookName}${bookPrice ? ` (${money(bookPrice)})` : ''} on the lowest dock of Booty Bay, at the south tip of Stranglethorn Vale, to both factions. Buy it and read it; it needs skill ${expert.minSkill} and level ${expert.minLevel}. At level 20 the safe way in is the boat from Ratchet in The Barrens, not the road through Stranglethorn. He also sells Bright Baubles${note(ctx, BRIGHT_BAUBLES, 75, true)}, the lure for the rest of the way.`,
		`level ${expert.minLevel}`,
		`train Fishing Expert "Buy and read ${bookName} (Expert Fishing)"`,
	]);

	section('Fishing 125-225');
	const rack = ctx.data.recipe(FISHING_RACK);
	const rackTip = rack && rack.recipe && rack.recipe.learnedAt
		? ` Forever's second camping item, the ${rack.recipe.name} (from skill ${rack.recipe.learnedAt}), is a blueprint that drops from Gelihast in Blackfathom Deeps.`
		: '';
	for (const faction of FACTIONS)
		spotSteps(REGIONS[faction], REGION_SPOTS, faction, expert.minSkill, 225, `Fish the pools here until skill 225, ${about(catches(expert.minSkill, 225))} catches: one in three raises the skill at 125, one in seven by 225, so this is the long stretch.${rackTip}`);

	section('Artisan Fishing: Nat Pagle');
	const artisan = rankInfo(ctx, 'Fishing', 'Artisan');
	const pagle = ctx.data.quest(6607);
	for (const [f, zone, accept] of [
		['Alliance', 'Ironforge', 'accept 6609                             -- Grimnur Stonebrand, Ironforge'],
		['Horde', 'Orgrimmar', 'accept 6608                             -- Lumak, Orgrimmar'],
	]) {
		step('Nat Pagle, Angler Extreme', [
			`only ${f}`,
			`zone ${zone}`,
			`tip Artisan Fishing (cap ${artisan.max}) comes from Nat Pagle in Dustwallow Marsh. The fishing trainer in ${zone} sends you to him; the quest needs skill ${artisan.minSkill} and level ${pagle.minLevel}.`,
			`skill Fishing ${artisan.minSkill}`,
			`level ${pagle.minLevel}`,
			accept,
		]);
	}
	step('Nat Pagle', [
		'zone Dustwallow Marsh',
		'tip Nat Pagle fishes from the shore of a small island off the east coast, south of Theramore; swim over from the coast.',
		'turnin 6609 only Alliance',
		'turnin 6608 only Horde',
		'accept 6607',
	]);
	for (const f of PAGLE_FISH) {
		const item = itemName(ctx, f.item);
		const lure = f.full > artisan.minSkill
			? ` This water loses fish below skill ${f.full}: at ${artisan.minSkill} most get away, so put ${itemName(ctx, BRIGHT_BAUBLES)} (+75) on the pole first.`
			: ` At skill ${artisan.minSkill} nothing gets away here.`;
		const tip = `tip Fish along ${f.where} until you catch a ${item}: ${PAGLE_RATE} there brings it up, and it bites nowhere else.${lure}`;
		const per = FACTIONS.map((side) => ({ side, c: spot(ctx, f, anchorFor(ctx, f, side)) }));
		if (per.some((p) => !p.c)) throw new Error(`Fishing: no ${item} spot in ${zoneName(ctx, f.zone)}`);
		const same = dist(per[0].c.pt, per[1].c.pt) < 1;
		const extra = f.full > artisan.minSkill ? [`buy ${BRIGHT_BAUBLES} x2 nearest`] : [];
		for (const p of same ? [per[0]] : per) {
			step(item, [...(same ? [] : [`only ${p.side}`]), `zone ${zoneName(ctx, f.zone)}`, tip, ...extra, `collect ${f.item} quest 6607 @${fmt(p.c.pt.x)},${fmt(p.c.pt.y)}`]);
		}
	}
	step('Nat Pagle', ['zone Dustwallow Marsh', 'turnin 6607                             -- Artisan Fishing']);

	section('Fishing 225-300');
	const late = spotLines(
		LATE_SPOT,
		anchorFor(ctx, LATE_SPOT, 'Alliance'),
		300,
		`Fish the pools along the coast here (eels, snappers, wreckage) until skill 300, ${about(catches(artisan.minSkill, 300))} catches (one in seven raises the skill at 225, one in ten by 300). Harder water levels no faster: a catch counts the same anywhere.${waterTip(ctx, LATE_SPOT, artisan.minSkill)} The Aquadynamic Fish Attractor${note(ctx, FISH_ATTRACTOR, 100)} and Bright Baubles are for harder water and rare fish, not for skill.`,
	);
	step(`Fishing: ${zoneName(ctx, LATE_SPOT.zone)} (225-300)`, late.lines);

	// Each band's range is a section (the guide window's heading; the guide starts at the player's skill).
	return `${byBanners(L.join('\n'), 'Fishing')}\n`;
}

module.exports = { file: 'fishing', skill: 'Fishing', render, PAGLE_FISH, catches };
