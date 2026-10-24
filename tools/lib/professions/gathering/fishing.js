'use strict';
// Fishing 1-300 guide (see build.js). Fishing gains skill per catch wherever
// you fish; low skill only makes fish get away in harder waters. So the guide
// sends each group to water near where it levels: a fishing-pool cluster from
// objects.json (role fishing), or the shore where water creatures from
// npcs.json live. Expert comes from a book (professions.json rank `book`),
// Artisan from Nat Pagle's quest (quests 6608/6609 -> 6607).

const R = require('./route');
const { RACE_GROUPS, REGIONS } = require('./groups');
const { dist } = require('../../route/geo');
const { FACTIONS, GUIDE_HEADER, fmt, zoneName, npcSpawn, rankInfo, flightMaster } = require('./common');
const { ERA_NOTE } = require('./notes');

const POLE = { item: 6256, name: 'Fishing Pole' };

// Where each group fishes. pools: fishing-pool clusters; npcs: shore creatures.
const START_SPOTS = {
	human: { zone: 1429, npcs: ['Murloc Streamrunner', 'Murloc'], label: 'Crystal Lake' },
	'dwarf-gnome': { zone: 1432, pools: true, label: 'The Loch' },
	nightelf: { zone: 1439, pools: true, label: 'Auberdine shore' },
	'orc-troll': { zone: 1411, npcs: ['Pygmy Surf Crawler', 'Makrura Shellhide', 'Makrura Clacker', 'Surf Crawler'], label: 'Durotar coast' },
	tauren: { zone: 1413, pools: true, label: 'Barrens oasis' },
	undead: { zone: 1420, npcs: ['Vile Fin Puddlejumper', 'Vile Fin Minor Oracle', 'Vile Fin Muckdweller'], label: 'Vile Fin shore' },
};
const NEXT_SPOTS = {
	human: { zone: 1436, pools: true, label: 'Westfall coast' },
	'dwarf-gnome': { zone: 1432, pools: true, label: 'The Loch' },
	nightelf: { zone: 1439, pools: true, label: 'Darkshore coast' },
	'orc-troll': { zone: 1413, pools: true, label: 'Barrens oasis' },
	tauren: { zone: 1413, pools: true, label: 'Barrens oasis' },
	undead: { zone: 1421, pools: true, label: 'Lordamere Lake', anchor: 6570 }, // Fenwick Thatros at the Decrepit Ferry, not the west coast near the Sepulcher
};
const REGION_SPOTS = {
	'alliance-ek': { zone: 1437, pools: true, label: 'Wetlands coast' },
	'alliance-kalimdor': { zone: 1440, pools: true, label: 'Ashenvale waters' },
	'horde-kalimdor': { zone: 1440, pools: true, label: 'Ashenvale waters', anchor: 12616 }, // Splintertree Post, not Astranaar
	'horde-ek': { zone: 1424, pools: true, label: 'Hillsbrad coast' },
};
const LATE_SPOT = { zone: 1434, pools: true, label: 'Booty Bay coast' };

// Nat Pagle's four fish (quest 6607). Spots: shore creatures of the named
// strands; Feralas has none in the data, so that one is a tip only.
const PAGLE_FISH = [
	{ item: 16968, zone: 1443, npcs: ['Slitherblade Myrmidon', 'Slitherblade Sea Witch', 'Slitherblade Warrior', 'Slitherblade Oracle'], where: "Sar'theris Strand, the north-west coast of Desolace (Slitherblade naga shore)" },
	{ item: 16967, zone: 1444, where: 'the Verdantis River in Feralas' },
	{ item: 16969, zone: 1434, npcs: ['Saltwater Crocolisk', 'Elder Saltwater Crocolisk'], where: 'the Savage Coast, the north-west shore of Stranglethorn Vale' },
	{ item: 16970, zone: 1435, npcs: ['Marsh Inkspewer', 'Marsh Murloc'], where: 'the Misty Reed Strand, the south-east shore of Swamp of Sorrows' },
];

function fishingPoints(ctx, zone) {
	const out = [];
	for (const o of Object.values(ctx.data.objects)) {
		if (!o.roles || !o.roles.includes('fishing')) continue;
		const s = o.spawns && o.spawns[String(zone)];
		if (!s) continue;
		for (const [x, y] of s.pts) out.push({ name: o.name, w: 1, pt: ctx.project.point(zone, x, y, s.f) });
	}
	return out;
}

function npcPoints(ctx, zone, names) {
	const out = [];
	for (const n of Object.values(ctx.data.npcs)) {
		if (!names.includes(n.name)) continue;
		const s = n.spawns && n.spawns[String(zone)];
		if (!s) continue;
		for (const [x, y] of s.pts) out.push({ name: n.name, w: 1, pt: ctx.project.point(zone, x, y, s.f) });
	}
	return out;
}

// The cluster of water points (3+ points) nearest `anchor`.
function spot(ctx, def, anchor) {
	const pts = def.pools ? fishingPoints(ctx, def.zone) : npcPoints(ctx, def.zone, def.npcs || []);
	if (!pts.length) return null;
	const cl = R.weightedClusters(pts, 80, ctx.project);
	const big = cl.filter((c) => c.w >= 3);
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

function render(ctx) {
	const L = [];
	const step = (title, lines) => {
		L.push('', `step ${title}`, ...lines.map((l) => `  ${l}`));
	};
	const section = (s) => L.push('', `# ---------------------------------------------------------------- ${s}`);
	const spotLines = (def, anchor, to, tip) => {
		const c = spot(ctx, def, anchor);
		if (!c) throw new Error(`Fishing: no water found in ${zoneName(ctx, def.zone)}`);
		return { pt: c.pt, lines: [`zone ${zoneName(ctx, def.zone)}`, `tip ${tip}`, `goto ${fmt(c.pt.x)},${fmt(c.pt.y)} "${def.label}" r 25`, `skill Fishing ${to}`] };
	};

	L.push(GUIDE_HEADER, 'guide forever/professions/fishing', 'title Fishing 1-300', 'category Professions', 'coords era', 'levels 5-60', 'zone Ironforge', '');
	for (const c of [
		'Fishing 1-300 for both factions. Every catch can raise the skill wherever you',
		'fish; low skill only makes fish get away in harder waters, so each band sends',
		'you to water near where you level (fishing-pool clusters from objects.json,',
		'or the shore where water creatures live). Expert Fishing is a book sold by',
		'Old Man Heming in Booty Bay; Artisan Fishing is Nat Pagle\'s quest in',
		'Dustwallow Marsh (four rare fish).',
		'',
		...ERA_NOTE,
	])
		L.push(c ? `# ${c}` : '#');

	// Groups that fish the same water share a step.
	const spotSteps = (groups, spots, faction, title, to, tip) => {
		const byKey = new Map();
		for (const g of groups) {
			const def = spots[g.key];
			const key = `${def.zone}|${def.label}|${def.anchor || ''}`;
			if (!byKey.has(key)) byKey.set(key, { def, races: [] });
			byKey.get(key).races.push(...g.races);
		}
		for (const { def, races } of byKey.values()) {
			const s = spotLines(def, anchorFor(ctx, def, faction), to, tip);
			step(`Fishing: ${zoneName(ctx, def.zone)} (${title})`, [`only ${races.join(',')}`, ...s.lines]);
		}
	};

	section('Apprentice');
	step('Learn Fishing', [
		`tip Any Fishing trainer of your faction teaches Apprentice Fishing (character level 5); the arrow picks the nearest. Buy a ${POLE.name} from a trade goods or fishing vendor and equip it.`,
		'level 5',
		'train Fishing Apprentice',
		`buy ${POLE.item} x1 nearest`,
	]);

	section('Fishing 1-75');
	const journeyman = rankInfo(ctx, 'Fishing', 'Journeyman');
	for (const faction of FACTIONS) spotSteps(RACE_GROUPS[faction], START_SPOTS, faction, '1-50', 50, 'Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill.');
	step('Journeyman Fishing', [
		`tip Journeyman Fishing raises the cap to ${journeyman.max}; it needs skill ${journeyman.minSkill} and character level ${journeyman.minLevel}. The arrow picks the nearest Fishing trainer of your faction.`,
		`level ${journeyman.minLevel}`,
		'train Fishing Journeyman',
	]);

	section('Fishing 50-125');
	const expert = rankInfo(ctx, 'Fishing', 'Expert');
	for (const faction of FACTIONS) spotSteps(RACE_GROUPS[faction], NEXT_SPOTS, faction, `50-${expert.minSkill}`, expert.minSkill, `Fish the pools and open water here until skill ${expert.minSkill}. Pools (floating debris, schools of fish) also drop extra loot.`);

	section('Expert Fishing');
	const seller = npcSpawn(ctx, expert.book.vendors.Alliance[0]);
	const bookName = ctx.data.item(expert.book.item).name;
	step('Expert Fishing', [
		`tip Expert Fishing (cap ${expert.max}) is a book, not a trainer rank: ${seller.name} sells ${bookName} in Booty Bay, at the south tip of Stranglethorn Vale, to both factions. Buy it and read it; it needs skill ${expert.minSkill} and level ${expert.minLevel}.`,
		`level ${expert.minLevel}`,
		`train Fishing Expert "Buy and read ${bookName} (Expert Fishing)"`,
	]);

	section('Fishing 125-225');
	for (const faction of FACTIONS) spotSteps(REGIONS[faction], REGION_SPOTS, faction, `${expert.minSkill}-225`, 225, 'Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up.');

	section("Artisan Fishing: Nat Pagle");
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
		'tip Nat Pagle fishes from the shore of a small island off the east coast, south of Theramore.',
		'turnin 6609 only Alliance',
		'turnin 6608 only Horde',
		'accept 6607',
	]);
	for (const f of PAGLE_FISH) {
		const item = ctx.data.item(f.item).name;
		const lines = [`zone ${zoneName(ctx, f.zone)}`, `tip Fish in ${f.where} until you catch a ${item}; it only bites there.`];
		if (f.npcs) {
			const c = spot(ctx, f, null);
			lines.push(`collect ${f.item} quest 6607 @${fmt(c.pt.x)},${fmt(c.pt.y)}`);
		} else {
			lines.push(`collect ${f.item} quest 6607`);
		}
		step(item, lines);
	}
	step('Nat Pagle', ['zone Dustwallow Marsh', 'turnin 6607                             -- Artisan Fishing']);

	section('Fishing 225-300');
	const late = spotLines(LATE_SPOT, anchorFor(ctx, LATE_SPOT, 'Alliance'), 300, 'Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. Booty Bay sells bait and Nightcrawlers for a small fishing bonus.');
	step(`Fishing: ${zoneName(ctx, LATE_SPOT.zone)} (225-300)`, late.lines);

	return `${L.join('\n')}\n`;
}

module.exports = { file: 'fishing', skill: 'Fishing', render, PAGLE_FISH };
