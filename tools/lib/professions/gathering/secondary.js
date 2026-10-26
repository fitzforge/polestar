'use strict';
// Cooking and First Aid 1-300 guides (see build.js). A route is a list of
// entries; each recipe segment names who does it (races, a faction, or
// everyone), the zone, the recipe spell (professions.json) and the skill range.
// The generator adds how many crafts the range takes (Classic chance: always
// below yellow, then (grey - skill) / (grey - yellow)) and where each reagent
// comes from: a vendor (`buy … nearest`), the densest cluster of the normal
// creatures that drop it in the zone (items.json drops), or a fishing spot.
//
// Trainers, rank books and vendors are smart targets (`train <Profession>
// <Rank>`, `buy … nearest`, `learn <spell>` without an npc): the engine picks
// the nearest one of the player's faction at runtime. Each segment is split
// into a shopping step, a gathering step and a crafting step, so bought or
// gathered items used up by the crafting never reopen a finished goal.

const { dist } = require('../../route/geo');
const R = require('./route');
const { RACE_GROUPS } = require('./groups');
const { FACTIONS, GUIDE_HEADER, fmt, zoneName, npcSpawn, rankInfo, vendorSpawns } = require('./common');
const { ERA_NOTE } = require('./notes');

const SIDE_OF_RACE = {};
for (const f of FACTIONS) for (const g of RACE_GROUPS[f]) for (const r of g.races) SIDE_OF_RACE[r] = f;

// who: { races: [...] } | { faction } | ALL.
const ALL = {};
const A = { faction: 'Alliance' };
const H = { faction: 'Horde' };
const GROUPS = Object.fromEntries(FACTIONS.flatMap((f) => RACE_GROUPS[f].map((g) => [g.key, { races: g.races }])));

function factionsOf(who) {
	if (who.faction) return [who.faction];
	if (who.races) return [...new Set(who.races.map((r) => SIDE_OF_RACE[r]))];
	return FACTIONS;
}

function onlyLines(who) {
	if (who.races) return [`only ${who.races.join(',')}`];
	if (who.faction) return [`only ${who.faction}`];
	return [];
}

// Expected crafts to go from skill `from` to `to` with a recipe.
function expectedCrafts(recipe, from, to) {
	let n = 0;
	for (let s = from; s < to; s++) {
		const p = s < recipe.yellow ? 1 : (recipe.grey - s) / (recipe.grey - recipe.yellow);
		if (p <= 0) throw new Error(`${recipe.name} is grey at ${s}`);
		n += 1 / p;
	}
	return Math.ceil(n);
}

function recipeOf(ctx, spell) {
	const r = ctx.data.recipe(spell);
	if (!r) throw new Error(`recipe ${spell} not in professions.json`);
	return r.recipe;
}

// Densest cluster of the normal creatures in `zone` that drop `item`
// (weighted by drop chance), as the real spawn nearest the cluster's centre,
// plus the best droppers' names. The data rates an item's droppers from one
// table (items.json `dropScale`), so a dropper that table does not rate has a
// null chance: when no rated dropper of 5% or more stands in the zone, the
// unrated ones count, weighted alike and named without a chance.
function dropSpot(ctx, item, zone) {
	const it = ctx.data.item(item);
	const droppers = Object.entries((it && it.drops && it.drops.npc) || {});
	const gather = (rated) => {
		const pts = [];
		const names = new Map();
		for (const [id, chance] of droppers) {
			if (rated ? chance === null || chance < 5 : chance !== null) continue;
			const n = ctx.data.npc(id);
			if (!n || n.rank || (n.roles && n.roles.length)) continue; // no elites, rares or service NPCs
			if (n.faction !== null && n.faction !== undefined) continue;
			const s = n.spawns && n.spawns[String(zone)];
			if (!s || s.pts.length < 3) continue; // no lone named spawns
			for (const [x, y] of s.pts) pts.push({ name: n.name, w: rated ? chance / 100 : 1, pt: ctx.project.point(zone, x, y, s.f) });
			names.set(n.name, rated ? Math.max(names.get(n.name) || 0, chance) : (names.get(n.name) || 0) + s.pts.length);
		}
		return { pts, names };
	};
	let rated = true;
	let { pts, names } = gather(true);
	if (!pts.length) ({ pts, names } = gather((rated = false)));
	if (!pts.length) throw new Error(`no creature in ${zoneName(ctx, zone)} drops ${it ? it.name : item}`);
	const best = R.weightedClusters(pts, 120, ctx.project)[0];
	let spawn = pts[0];
	for (const p of pts) if (dist(p.pt, best.pt) < dist(spawn.pt, best.pt)) spawn = p;
	const top = [...names.entries()]
		.filter(([nm]) => best.counts[nm])
		.sort((a, b) => b[1] - a[1] || (a[0] < b[0] ? -1 : a[0] > b[0] ? 1 : 0))
		.slice(0, 3)
		.map(([nm, c]) => (rated ? `${nm} (${Math.round(c)}%)` : nm));
	return { pt: spawn.pt, mobs: top };
}

// Sold to every faction `who` covers (professions.json materials, else the
// item's vendors).
function soldTo(ctx, P, item, who) {
	const m = P.materials && P.materials[item];
	return factionsOf(who).every((f) => {
		const ids = m && m.vendors && m.vendors[f];
		return vendorSpawns(ctx, item, f, ids && ids.length ? ids : null).length > 0;
	});
}

function itemName(ctx, id) {
	return (ctx.data.item(id) || {}).name || `item ${id}`;
}

function step(L, title, lines) {
	L.push('', `step ${title}`, ...lines.map((l) => `  ${l}`));
}

function craftTip(P, recipe, from, to, crafts, extra) {
	const color = from < recipe.yellow ? 'orange' : 'yellow';
	return `tip ${recipe.name} is ${color} from ${from} (yellow at ${recipe.yellow}, grey at ${recipe.grey}): about ${crafts} crafts to ${to}.${P.craftTip ? ` ${P.craftTip}` : ''}${extra ? ` ${extra}` : ''}`;
}

function renderSegment(ctx, P, seg, L) {
	const recipe = recipeOf(ctx, seg.spell);
	const crafts = expectedCrafts(recipe, seg.from, seg.to);
	const shop = [];
	const gather = [];
	const notes = [];
	if (seg.learn === 'vendor') {
		if (!factionsOf(seg.who).every((f) => vendorSpawns(ctx, recipe.recipeItem, f).length)) throw new Error(`${recipe.name}: recipe ${recipe.recipeItem} not sold to ${factionsOf(seg.who)}`);
		shop.push(`buy ${recipe.recipeItem} x1 nearest`);
	}
	for (const rg of recipe.reagents) {
		const need = crafts * rg.count;
		const name = itemName(ctx, rg.item);
		const src = (seg.sources && seg.sources[rg.item]) || null;
		if (src && src.fish) {
			gather.push(`goto ${fmt(src.fish.x)},${fmt(src.fish.y)} "${src.fish.label}" r 25`);
			gather.push(`note Catch about ${need} ${name} here by fishing (see the Fishing guide).`);
		} else if (src && src.note) {
			notes.push(`note About ${need} ${name}: ${src.note}`);
		} else if (soldTo(ctx, P, rg.item, seg.who)) {
			shop.push(`buy ${rg.item} x${need} nearest`);
		} else {
			// Smart farm spot; the planned zone's best droppers go in the note.
			const d = dropSpot(ctx, rg.item, seg.zone);
			gather.push(`collect ${rg.item} x${need} nearest     -- ${d.mobs.join(', ')} in ${zoneName(ctx, seg.zone)}, or wherever the arrow points`);
		}
	}
	const only = onlyLines(seg.who);
	if (shop.length) {
		step(L, `${recipe.name}: shopping`, [...only, 'tip The arrow picks the nearest vendor of your faction for each item.', ...shop]);
	}
	if (gather.length) {
		step(L, `${recipe.name}: ingredients`, [...only, `zone ${zoneName(ctx, seg.zone)}`, ...gather]);
	}
	const learn = seg.learn === 'trainer' || seg.learn === 'vendor' || seg.learn === 'item' ? [`learn ${seg.spell}`] : [];
	step(L, `${recipe.name} (${seg.from}-${seg.to})`, [
		...only,
		`zone ${zoneName(ctx, seg.zone)}`,
		craftTip(P, recipe, seg.from, seg.to, crafts, seg.tip),
		...learn,
		...notes,
		`craft ${seg.spell} until ${seg.to}`,
	]);
}

// One step per rank: smart trainer (or book vendor for book ranks).
function renderRank(ctx, P, e, L) {
	const info = rankInfo(ctx, P.skill, e.rank);
	const how = info.book
		? `it is a book, ${itemName(ctx, info.book.item)}; the arrow picks its nearest seller for your faction. Buy it and read it`
		: `the arrow picks the nearest ${P.skill} trainer of your faction`;
	const train = info.book ? `train ${P.skill} ${e.rank} "Buy and read ${itemName(ctx, info.book.item)} (${e.rank} ${P.skill})"` : `train ${P.skill} ${e.rank}`;
	const lines = [`tip ${e.rank} ${P.skill} raises the cap to ${info.max}; it needs skill ${info.minSkill} and character level ${info.minLevel}: ${how}.${e.tip ? ` ${e.tip}` : ''}`, `level ${info.minLevel}`, train];
	for (const extra of e.alsoBuy || []) lines.push(`buy ${extra} x1 nearest`);
	for (const sp of e.learn || []) lines.push(`learn ${sp}`);
	step(L, `${e.rank} ${P.skill}`, lines);
}

function renderGuide(ctx, P) {
	P.materials = (ctx.data.professionNamed(P.skill) || {}).materials || {};
	const L = [GUIDE_HEADER, `guide forever/professions/${P.file}`, `title ${P.title}`, 'category Professions', 'coords era', `levels ${P.levels}`, 'zone Ironforge', ''];
	for (const c of [...P.header, '', ...ERA_NOTE]) L.push(c ? `# ${c}` : '#');
	for (const e of P.route(ctx)) {
		if (e.section) L.push('', `# ---------------------------------------------------------------- ${e.section}`);
		else if (e.apprentice) {
			step(L, `Learn ${P.skill}`, [`tip Any ${P.skill} trainer of your faction teaches Apprentice ${P.skill} (character level 5); the arrow picks the nearest.`, 'level 5', `train ${P.skill} Apprentice`]);
		} else if (e.rank) renderRank(ctx, P, e, L);
		else if (e.bandage) renderBandage(ctx, P, e, L);
		else if (e.raw) step(L, e.title, e.raw);
		else renderSegment(ctx, P, e, L);
	}
	return `${L.join('\n')}\n`;
}

// ------------------------------------------------------------------ First Aid

// Cloth level bands are general game knowledge (humanoids drop the cloth of
// their level).
const CLOTH = {
	2589: 'humanoids of level 5-20 drop Linen Cloth (or buy it at the Auction House).',
	2592: 'humanoids of level 15-30 drop Wool Cloth (or buy it at the Auction House).',
	4306: 'humanoids of level 25-45 drop Silk Cloth (or buy it at the Auction House).',
	4338: 'humanoids of level 35-50 drop Mageweave Cloth (or buy it at the Auction House).',
	14047: 'humanoids of level 45-60 drop Runecloth (or buy it at the Auction House).',
};
const clothSources = Object.fromEntries(Object.entries(CLOTH).map(([id, note]) => [id, { note }]));

// Bandages: crafted anywhere, so one gathering step (cloth from the nearest
// farm spot the engine picks) and one crafting step for everyone.
function renderBandage(ctx, P, e, L) {
	const recipe = recipeOf(ctx, e.spell);
	const crafts = expectedCrafts(recipe, e.from, e.to);
	step(
		L,
		`${recipe.name}: cloth`,
		recipe.reagents.map((rg) => `collect ${rg.item} x${crafts * rg.count} nearest     -- ${clothSources[rg.item].note}`),
	);
	const lines = [craftTip(P, recipe, e.from, e.to, crafts, e.tip)];
	if (e.learn) lines.push(...e.learn);
	lines.push(`craft ${e.spell} until ${e.to}`);
	step(L, `${recipe.name} (${e.from}-${e.to})`, lines);
}

const firstAid = {
	file: 'first-aid',
	skill: 'First Aid',
	title: 'First Aid 1-300',
	levels: '5-60',
	craftTip: 'Bandages need no fire: craft them anywhere.',
	header: [
		'First Aid 1-300 for both factions: bandage recipes in orange/yellow order from',
		'professions.json, learned on as few trainer visits as the recipes allow. Expert',
		"is a book (Deneb Walker, Stromgarde / Balai Lok'Wein, Brackenwall Village);",
		'Artisan is the Triage quest, and the Triage doctor teaches Runecloth Bandage.',
		'Craft counts use the Classic skill-up chance (grey - skill) / (grey - yellow).',
	],
	route() {
		const band = (spell, from, to, learn, tip) => ({ bandage: true, spell, from, to, learn, tip });
		return [
			{ section: 'Apprentice' },
			{ apprentice: true },
			{ section: 'First Aid 1-125' },
			band(3275, 1, 50, null),
			{ rank: 'Journeyman', learn: [3276], tip: 'Learn Heavy Linen Bandage on the same visit.' },
			band(3276, 50, 80, null),
			band(3277, 80, 115, ['learn 3277'], 'Any First Aid trainer of your faction teaches it; the arrow picks the nearest.'),
			band(3278, 115, 125, ['learn 3278']),
			{ section: 'Expert First Aid' },
			{ rank: 'Expert', alsoBuy: [16112, 16113], tip: 'The same vendor sells the Heavy Silk and Mageweave Bandage manuals: buy both now, you read them at 180 and 210.' },
			{ section: 'First Aid 125-225' },
			band(3278, 125, 150, null),
			band(7928, 150, 180, ['learn 7928']),
			band(7929, 180, 210, ['learn 7929']),
			band(10840, 210, 225, ['learn 10840']),
			{ section: 'Artisan First Aid: Triage' },
			{
				title: 'Trauma',
				raw: [
					'only Alliance',
					'zone Ironforge',
					'tip Artisan First Aid comes from the Triage quest. It needs skill 225 and level 40; the First Aid trainer in Ironforge sends you to the doctor in Theramore.',
					'skill "First Aid" 225',
					'level 40',
					'accept 6625                             -- Nissa Firestone, Ironforge',
				],
			},
			{
				title: 'Trauma',
				raw: [
					'only Horde',
					'zone Orgrimmar',
					'tip Artisan First Aid comes from the Triage quest. It needs skill 225 and level 40; the First Aid trainer in Orgrimmar sends you to the doctor in Hammerfall.',
					'skill "First Aid" 225',
					'level 40',
					'accept 6623                             -- Arnok, Orgrimmar',
				],
			},
			{
				title: 'Triage',
				raw: [
					'only Alliance',
					'zone Dustwallow Marsh',
					"tip Triage: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die.",
					'turnin 6625                             -- Doctor Gustaf VanHowzen, Theramore Isle',
					'accept 6624',
					'complete 6624',
					'turnin 6624                             -- Artisan First Aid',
				],
			},
			{
				title: 'Triage',
				raw: [
					'only Horde',
					'zone Arathi Highlands',
					"tip Triage: treat the wounded soldiers in the doctor's tent with the bandages the doctor gives you, the most critical first, before any of them die.",
					'turnin 6623                             -- Doctor Gregory Victor, Hammerfall',
					'accept 6622',
					'complete 6622',
					'turnin 6622                             -- Artisan First Aid',
				],
			},
			{ section: 'First Aid 225-300' },
			band(10840, 225, 260, null, 'Mageweave Bandage stays yellow to 270; one recipe to 260 saves two trips to the doctor.'),
			{
				title: 'Runecloth Bandage',
				raw: [
					'tip Runecloth Bandage (skill 260) is an Artisan recipe: only the Triage doctor teaches it (Doctor Gustaf VanHowzen in Theramore, Doctor Gregory Victor in Hammerfall).',
					'learn 18629 npc 12939 only Alliance',
					'learn 18629 npc 12920 only Horde',
				],
			},
			band(18629, 260, 300, null, 'Runecloth Bandage stays yellow to 320, so it carries you to 300 without a trip for Heavy Runecloth.'),
		];
	},
};

// ------------------------------------------------------------------ Cooking

const fishSpot = (ctx, npcId, label) => {
	const n = npcSpawn(ctx, npcId);
	return { fish: { x: n.pt.x, y: n.pt.y, label } };
};

const cooking = {
	file: 'cooking',
	skill: 'Cooking',
	title: 'Cooking 1-300',
	levels: '5-60',
	craftTip: 'Cook at any fire: Basic Campfire comes with Cooking.',
	header: [
		'Cooking 1-300 for both factions: recipes in orange/yellow order from',
		'professions.json, each with where its ingredients drop (the densest cluster',
		'of normal creatures that drop them in the zone, from items.json) or a vendor',
		'that sells them. Expert is a cookbook (Shandrina, Ashenvale / Wulan,',
		'Desolace); Artisan is the Clamlette Surprise quest in Gadgetzan.',
		'Craft counts use the Classic skill-up chance (grey - skill) / (grey - yellow).',
	],
	route(ctx) {
		const G = GROUPS;
		const rut = fishSpot(ctx, 3838, "Rut'theran Village docks"); // Vesprystus, the flight master on the docks
		const auberdine = fishSpot(ctx, 3841, 'Auberdine docks');
		const roastBoar = 2540;
		const charredWolf = 2538;
		const ekAlliance = { races: ['Human', 'Dwarf', 'Gnome'] };
		const clamlette = (f, zone, giver) => ({
			title: 'Dirge Quikcleave',
			raw: [`only ${f}`, `zone ${zone}`, `tip Artisan Cooking comes from Dirge Quikcleave in Gadgetzan (Tanaris). The cooking trainer in ${zone} sends you; it needs skill 225 and level 35.`, 'skill Cooking 225', 'level 35', giver],
		});
		return [
			{ section: 'Apprentice' },
			{ apprentice: true },
			{ section: 'Cooking 1-50' },
			{ who: G.human, zone: 1429, spell: charredWolf, from: 1, to: 50 },
			{ who: G['dwarf-gnome'], zone: 1426, spell: roastBoar, from: 1, to: 50 },
			{ who: G.nightelf, zone: 1438, spell: 7751, from: 1, to: 50, learn: 'vendor', sources: { 6291: rut }, tip: 'Raw Brilliant Smallfish is the common catch in Teldrassil\'s waters.' },
			{ who: G['orc-troll'], zone: 1411, spell: roastBoar, from: 1, to: 50 },
			{ who: G.tauren, zone: 1412, spell: charredWolf, from: 1, to: 50 },
			{ who: G.undead, zone: 1420, spell: charredWolf, from: 1, to: 50 },
			{ rank: 'Journeyman' },
			{ section: 'Cooking 50-125' },
			{ who: G.human, zone: 1436, spell: 2542, from: 50, to: 100, learn: 'vendor' },
			{ who: G['dwarf-gnome'], zone: 1432, spell: 7754, from: 50, to: 100, learn: 'vendor' },
			{ who: G.nightelf, zone: 1439, spell: 7827, from: 50, to: 110, learn: 'vendor', sources: { 6361: auberdine }, tip: 'Fishing off the Auberdine docks catches Raw Rainbow Fin Albacore.' },
			{ who: { races: ['Orc', 'Troll', 'Tauren', 'Undead'] }, zone: 1413, spell: 6416, from: 50, to: 100, learn: 'vendor' },
			{ who: ekAlliance, zone: 1437, spell: 3370, from: 100, to: 125, learn: 'vendor' },
			{ who: G.nightelf, zone: 1440, spell: 6419, from: 110, to: 125, learn: 'vendor' },
			{ who: H, zone: 1413, spell: 6418, from: 100, to: 125, learn: 'vendor' },
			{ section: 'Expert Cooking' },
			{ rank: 'Expert' },
			{ section: 'Cooking 125-175' },
			{ who: ekAlliance, zone: 1437, spell: 3370, from: 125, to: 130 },
			{ who: ekAlliance, zone: 1437, spell: 3376, from: 130, to: 175, learn: 'vendor' },
			{ who: G.nightelf, zone: 1440, spell: 6419, from: 125, to: 150 },
			{ who: G.nightelf, zone: 1437, spell: 3376, from: 150, to: 175, learn: 'vendor' },
			{ who: H, zone: 1413, spell: 6418, from: 125, to: 140 },
			{ who: H, zone: 1424, spell: 3398, from: 140, to: 175, learn: 'vendor' },
			{ section: 'Cooking 175-225' },
			{ who: ALL, zone: 1445, spell: 15855, from: 175, to: 215, learn: 'vendor' },
			{ who: ALL, zone: 1443, spell: 15910, from: 215, to: 225, learn: 'vendor' },
			{ section: 'Artisan Cooking: Clamlette Surprise' },
			clamlette('Alliance', 'Ironforge', 'accept 6612                             -- Daryl Riknussun, Ironforge'),
			clamlette('Horde', 'Orgrimmar', 'accept 6611                             -- Zamja, Orgrimmar'),
			{
				title: 'Clamlette Surprise',
				raw: ['zone Tanaris', 'turnin 6612 only Alliance', 'turnin 6611 only Horde', 'accept 6610'],
			},
			{
				title: 'Alterac Swiss',
				raw: ['tip Clamlette Surprise asks for 20 Alterac Swiss (check the quest log); innkeepers and food vendors sell it, and the arrow picks the nearest.', 'buy 8932 x20 nearest'],
			},
			{
				title: 'Giant Eggs',
				raw: ['zone Felwood', 'tip Giant Eggs drop from the Ironbeak owls of Felwood.', 'collect 12207 quest 6610'],
			},
			{
				title: 'Zesty Clam Meat',
				raw: [
					'zone Tanaris',
					'tip Zesty Clam Meat has no drop data: buy it at the Gadgetzan Auction House, next to Dirge, or open clams looted from coastal creatures.',
					`collect 7974 quest 6610 ${(() => {
						const n = npcSpawn(ctx, 8125);
						return `@${fmt(n.pt.x)},${fmt(n.pt.y)} map ${n.map}`;
					})()}`,
				],
			},
			{ title: 'Dirge Quikcleave', raw: ['zone Tanaris', 'turnin 6610                             -- Artisan Cooking'] },
			{ section: 'Cooking 225-300' },
			{ who: ALL, zone: 1443, spell: 15910, from: 225, to: 240 },
			{ who: ALL, zone: 1448, spell: 15933, from: 240, to: 300, learn: 'vendor' },
		];
	},
};

module.exports = {
	firstAid: { file: firstAid.file, skill: firstAid.skill, render: (ctx) => renderGuide(ctx, firstAid) },
	cooking: { file: cooking.file, skill: cooking.skill, render: (ctx) => renderGuide(ctx, cooking) },
	expectedCrafts,
};
