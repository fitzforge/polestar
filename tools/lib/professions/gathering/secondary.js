'use strict';
// Cooking and First Aid 1-300 guides (see build.js). A route is a list of
// entries; each recipe segment names who does it (races, a faction, or
// everyone), the zone, the recipe spell (professions.json) and the skill range.
// The generator adds how many crafts the range takes (Classic chance: always
// below yellow, then (grey - skill) / (grey - yellow)) and where each reagent
// comes from: a vendor (`buy … nearest`) or the densest cluster of the normal
// creatures that drop it in the zone (items.json drops, or the clams that hold it).
//
// Trainers, rank books and vendors are smart targets (`train <Profession>
// <Rank>`, `buy … nearest`, `learn <spell>` without an npc): the engine picks
// the nearest one of the player's faction at runtime. Each segment is split
// into a shopping step, a gathering step and a crafting step, so bought or
// gathered items used up by the crafting never reopen a finished goal.

const { dist } = require('../../route/geo');
const R = require('./route');
const { RACE_GROUPS, TWO_SIDED, raceCondition } = require('./groups');
const { FACTIONS, GUIDE_HEADER, fmt, money, zoneName, rankInfo, vendorSpawns } = require('./common');
const { ERA_NOTE } = require('./notes');
const SECTIONS = require('../sections');

const SIDE_OF_RACE = {};
for (const f of FACTIONS) for (const g of RACE_GROUPS[f]) for (const r of g.races) if (!TWO_SIDED.has(r)) SIDE_OF_RACE[r] = f;

// who: { races: [...] } | { faction } | ALL.
const ALL = {};
const A = { faction: 'Alliance' };
const H = { faction: 'Horde' };
// A race group of one side (Skyborne play on both: `side` says which).
const GROUPS = Object.fromEntries(FACTIONS.flatMap((f) => RACE_GROUPS[f].map((g) => [g.key, { races: g.races, side: f }])));

function factionsOf(who) {
	if (who.faction) return [who.faction];
	if (who.races) return [...new Set(who.races.flatMap((r) => (SIDE_OF_RACE[r] ? [SIDE_OF_RACE[r]] : who.side ? [who.side] : FACTIONS)))];
	return FACTIONS;
}

function onlyLines(who) {
	if (who.races) return [`only ${raceCondition(who.races, factionsOf(who))}`];
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

// The normal creatures in `zone` that drop `item`, weighted by drop chance:
// { pts, names, rated, weight }. The data rates an item's droppers from one
// table (items.json `dropScale`), so a dropper that table does not rate has a
// null chance: when no rated dropper of 5% or more stands in the zone, the
// unrated ones count, weighted alike and named without a chance. `minChance`:
// the least rated chance that counts (percent).
function zoneDroppers(ctx, item, zone, minChance = 5) {
	const it = ctx.data.item(item);
	const droppers = Object.entries((it && it.drops && it.drops.npc) || {});
	const gather = (rated) => {
		const pts = [];
		const names = new Map();
		for (const [id, chance] of droppers) {
			if (rated ? chance === null || chance < minChance : chance !== null) continue;
			const n = ctx.data.npc(id);
			if (!n || n.rank || (n.roles && n.roles.length)) continue; // no elites, rares or service NPCs
			if (n.faction !== null && n.faction !== undefined) continue;
			const s = n.spawns && n.spawns[String(zone)];
			if (!s || R.allPoints(s).length < 3) continue; // no lone named spawns
			for (const [x, y] of R.allPoints(s)) pts.push({ name: n.name, w: rated ? chance / 100 : 0.05, pt: ctx.project.point(zone, x, y, s.f) });
			names.set(n.name, rated ? Math.max(names.get(n.name) || 0, chance) : (names.get(n.name) || 0) + R.allPoints(s).length);
		}
		return { pts, names, rated, weight: pts.reduce((a, p) => a + p.w, 0) };
	};
	const r = gather(true);
	return r.pts.length ? r : gather(false);
}

// Densest cluster of the creatures in `zone` that drop `item`, or a container
// that holds it (items.json `containers`: the clams that murlocs drop hold the
// clam meat) when its droppers there weigh more: the real spawn nearest the
// cluster's centre, the best droppers' names, and `via`, the container to loot
// and open (null for the item itself).
function dropSpot(ctx, item, zone, minChance = 5) {
	const it = ctx.data.item(item);
	let best = { via: null, ...zoneDroppers(ctx, item, zone, minChance) };
	for (const c of (it && it.containers) || []) {
		const d = zoneDroppers(ctx, c, zone, minChance);
		if (d.weight > best.weight) best = { via: c, ...d };
	}
	const { pts, names, rated } = best;
	if (!pts.length) throw new Error(`no creature in ${zoneName(ctx, zone)} drops ${it ? it.name : item}`);
	const top1 = R.weightedClusters(pts, 120, ctx.project)[0];
	let spawn = pts[0];
	for (const p of pts) if (dist(p.pt, top1.pt) < dist(spawn.pt, top1.pt)) spawn = p;
	const top = [...names.entries()]
		.filter(([nm]) => top1.counts[nm])
		.sort((a, b) => b[1] - a[1] || (a[0] < b[0] ? -1 : a[0] > b[0] ? 1 : 0))
		.slice(0, 3)
		.map(([nm, c]) => (rated ? `${nm} (${Math.round(c)}%)` : nm));
	return { pt: spawn.pt, mobs: top, via: best.via };
}

// The centre of the densest cluster of an NPC's spawns in a zone (map percent).
function npcCluster(ctx, zone, name) {
	const pts = [];
	for (const n of Object.values(ctx.data.npcs)) {
		const s = n.name === name && n.spawns && n.spawns[String(zone)];
		if (s) for (const [x, y] of R.allPoints(s)) pts.push({ name, w: 1, pt: ctx.project.point(zone, x, y, s.f) });
	}
	if (!pts.length) throw new Error(`no ${name} in ${zoneName(ctx, zone)}`);
	return R.weightedClusters(pts, 120, ctx.project)[0].pt;
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
	const color = from < recipe.yellow ? 'orange' : from < recipe.green ? 'yellow' : 'green';
	return `tip ${recipe.name} is ${color} from ${from} (yellow at ${recipe.yellow}, green at ${recipe.green}, grey at ${recipe.grey}): about ${crafts} crafts to ${to}.${P.craftTip ? ` ${P.craftTip}` : ''}${extra ? ` ${extra}` : ''}`;
}

// What learning a segment's recipe costs and where: "The trainer teaches it
// (skill 75) for 2s." / "Recipe: X costs 4s at its vendor (limited stock)."
// Limited stock only when a faction the segment covers has no vendor with
// unlimited stock (a limited seller beside unlimited ones changes nothing).
function learnNote(ctx, P, recipe, seg) {
	if (seg.learn === 'trainer') return `Any ${P.skill} trainer teaches it from skill ${recipe.learnedAt} for ${money(recipe.cost)}.`;
	if (seg.learn === 'vendor') {
		const m = (P.materials && P.materials[recipe.recipeItem]) || {};
		const limited = factionsOf(seg.who).some((f) => !((m.vendors || {})[f] || []).length && ((m.limitedVendors || {})[f] || []).length);
		return `${itemName(ctx, recipe.recipeItem)} costs ${money(m.buy || recipe.cost)} at its vendor${limited ? ' (limited stock: if it is sold out, wait for the restock or check the Auction House)' : ''}; the arrow picks the nearest one of your faction.`;
	}
	return '';
}

// Vendor price of `count` of a material: "about 1s 20c".
function priceOf(P, item, count) {
	const m = P.materials && P.materials[item];
	if (!m || !(m.buy > 0)) return '';
	return money(Math.ceil(count / (m.buyCount || 1)) * m.buy);
}

function renderSegment(ctx, P, seg, L) {
	const recipe = recipeOf(ctx, seg.spell);
	const crafts = expectedCrafts(recipe, seg.from, seg.to);
	const shop = [];
	const bought = [];
	const gather = [];
	if (seg.learn === 'vendor') {
		if (!factionsOf(seg.who).every((f) => vendorSpawns(ctx, recipe.recipeItem, f).length)) throw new Error(`${recipe.name}: recipe ${recipe.recipeItem} not sold to ${factionsOf(seg.who)}`);
		shop.push(`buy ${recipe.recipeItem} x1 nearest`);
	}
	// A later segment's recipe sold beside this one's vendor: bought now, so the
	// later shopping step is done when the player gets there.
	for (const item of seg.alsoBuy || []) shop.push(`buy ${item} x1 nearest`);
	for (const rg of recipe.reagents) {
		const need = crafts * rg.count;
		const name = itemName(ctx, rg.item);
		if (soldTo(ctx, P, rg.item, seg.who)) {
			shop.push(`buy ${rg.item} x${need} nearest`);
			const price = priceOf(P, rg.item, need);
			if (price) bought.push(`${need} ${name} (${price})`);
		} else {
			// Smart farm spot; the planned zone's best droppers go in the note.
			const d = dropSpot(ctx, rg.item, seg.zone);
			const open = d.via ? `; open each ${itemName(ctx, d.via)} for its ${name}` : '';
			gather.push(`collect ${d.via || rg.item} x${need} nearest     -- ${d.mobs.join(', ')} in ${zoneName(ctx, seg.zone)}, or wherever the arrow points${open}`);
		}
	}
	const only = onlyLines(seg.who);
	if (shop.length) {
		const list = bought.length ? ` You need ${bought.join(', ')}.` : '';
		step(L, `${recipe.name}: shopping`, [...only, `tip The arrow picks the nearest vendor of your faction for each item.${list}`, ...shop]);
	}
	if (gather.length) {
		step(L, `${recipe.name}: ingredients`, [...only, `zone ${zoneName(ctx, seg.zone)}`, ...gather]);
	}
	const learn = seg.learn === 'trainer' || seg.learn === 'vendor' || seg.learn === 'item' ? [`learn ${seg.spell}`] : [];
	const extra = [learnNote(ctx, P, recipe, seg), seg.tip].filter(Boolean).join(' ');
	step(L, `${recipe.name} (${seg.from}-${seg.to})`, [
		...only,
		`zone ${zoneName(ctx, seg.zone)}`,
		craftTip(P, recipe, seg.from, seg.to, crafts, extra),
		...learn,
		`craft ${seg.spell} until ${seg.to}`,
	]);
}

// One step per rank: smart trainer (or book vendor for book ranks), with what
// it costs (the sniffed trainer price, or the book's vendor price).
function renderRank(ctx, P, e, L) {
	const info = rankInfo(ctx, P.skill, e.rank);
	const bookPrice = info.book && P.materials[info.book.item] ? P.materials[info.book.item].buy : 0;
	const how = info.book
		? `it is a book, ${itemName(ctx, info.book.item)}${bookPrice ? ` (${money(bookPrice)})` : ''}; the arrow picks its nearest seller for your faction. Buy it and read it`
		: `the arrow picks the nearest ${P.skill} trainer of your faction${info.cost ? `; training costs ${money(info.cost)}` : ''}`;
	const train = info.book ? `train ${P.skill} ${e.rank} "Buy and read ${itemName(ctx, info.book.item)} (${e.rank} ${P.skill})"` : `train ${P.skill} ${e.rank}`;
	// Forever's Cooking and First Aid Journeyman ask no character level (professions.json minLevel 0).
	const level = info.minLevel > 0 ? ` and character level ${info.minLevel}` : ' and no character level';
	const lines = [`tip ${e.rank} ${P.skill} raises the cap to ${info.max}; it needs skill ${info.minSkill}${level}: ${how}.${e.tip ? ` ${e.tip}` : ''}`, ...(info.minLevel > 0 ? [`level ${info.minLevel}`] : []), train];
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
			const ap = rankInfo(ctx, P.skill, 'Apprentice');
			const apTip = typeof P.apprenticeTip === 'function' ? P.apprenticeTip(ctx) : P.apprenticeTip;
			// Forever's Cooking and First Aid Apprentice ask no level (Classic's 5): professions.json says 1.
			const apLevel = ap && ap.minLevel > 1 ? ap.minLevel : 0;
			step(L, `Learn ${P.skill}`, [`tip Any ${P.skill} trainer of your faction teaches Apprentice ${P.skill} (${apLevel ? `character level ${apLevel}` : 'any character level'}${ap && ap.cost ? `, ${money(ap.cost)}` : ''}); the arrow picks the nearest.${apTip ? ` ${apTip}` : ''}`, ...(apLevel ? [`level ${apLevel}`] : []), `train ${P.skill} Apprentice`]);
		} else if (e.rank) renderRank(ctx, P, e, L);
		else if (e.bandage) renderBandage(ctx, P, e, L);
		else if (e.raw) step(L, e.title, e.raw);
		else renderSegment(ctx, P, e, L);
	}
	// The skill ranges as sections (the guide window's headings; the guide starts at the player's skill):
	// per bandage band for First Aid, whose every band gathers its own cloth; per banner for Cooking.
	return `${SECTIONS[P.sections || 'byBanners'](L.join('\n'), P.skill)}\n`;
}

// ------------------------------------------------------------------ First Aid

// Cloth level bands are general game knowledge (humanoids drop the cloth of
// their level). What the bags (and bank) hold counts; the rest drops as the
// character levels, or comes from the Auction House. No farm trip by default:
// a named farm spot can be a long journey for a few pieces the player picks
// up anyway.
const CLOTH = {
	2589: 'Linen Cloth drops from humanoids of level 5-20',
	2592: 'Wool Cloth drops from humanoids of level 15-30',
	4306: 'Silk Cloth drops from humanoids of level 25-45',
	4338: 'Mageweave Cloth drops from humanoids of level 35-50',
	14047: 'Runecloth drops from humanoids of level 45-60',
};

// Bandages: crafted anywhere, so one gathering step (the cloth, counted in the
// bags with no place: `anywhere`) and one crafting step for everyone.
function renderBandage(ctx, P, e, L) {
	const recipe = recipeOf(ctx, e.spell);
	const crafts = expectedCrafts(recipe, e.from, e.to);
	const tip = recipe.reagents.map((rg) => `${CLOTH[rg.item]}: keep what you loot as you level, take it from your bank, or buy it at the Auction House.`).join(' ');
	step(L, `${recipe.name}: cloth`, [`tip ${tip}`, ...recipe.reagents.map((rg) => `collect ${rg.item} x${crafts * rg.count} anywhere`)]);
	// A recipe learned in this step: where and what it costs (sniffed trainer lists).
	const learnTip = e.learn && e.learn.some((l) => l.startsWith(`learn ${e.spell}`) && !l.includes(' npc ')) && recipe.source === 'trainer' ? `Any ${P.skill} trainer of your faction teaches it from skill ${recipe.learnedAt} for ${money(recipe.cost)}; the arrow picks the nearest.` : '';
	const lines = [craftTip(P, recipe, e.from, e.to, crafts, [learnTip, e.tip].filter(Boolean).join(' '))];
	if (e.learn) lines.push(...e.learn);
	lines.push(`craft ${e.spell} until ${e.to}`);
	step(L, `${recipe.name} (${e.from}-${e.to})`, lines);
}

const firstAid = {
	file: 'first-aid',
	skill: 'First Aid',
	title: 'First Aid 1-300',
	sections: 'byBands',
	levels: '5-60',
	craftTip: 'Bandages need no fire: craft them anywhere.',
	header: [
		'First Aid 1-300 for both factions: bandage recipes in orange/yellow order from',
		'professions.json, learned on as few trainer visits as the recipes allow (learn',
		"skills and prices: Forever's sniffed trainer lists). Expert is a book (Deneb",
		"Walker, Stromgarde / Balai Lok'Wein, Brackenwall Village); Artisan is the",
		'Triage quest, and the Triage doctor teaches the Artisan bandages. Forever also',
		"teaches healing potions, anti-venoms, poultices and tourniquets in First Aid:",
		'the potions are the herbalist\'s alternative (tips at 1, 55 and 110).',
		'Craft counts use the Classic skill-up chance (grey - skill) / (grey - yellow).',
		'INGAME: can a character under level 20 read Expert First Aid - Under Wraps at',
		'skill 125? (the book carries no level requirement; Classic guides gate it at 20)',
	],
	apprenticeTip: 'Forever teaches Minor Healing Potion with it: Peacebloom, Mild Spices and an Empty Vial, orange to 55. With Herbalism it can replace the Linen Bandages below.',
	route(ctx) {
		const band = (spell, from, to, learn, tip) => ({ bandage: true, spell, from, to, learn, tip });
		const triage = ctx.data.quest(6624).minLevel;
		const recipe = (spell) => recipeOf(ctx, spell);
		const kit = recipe(1230117);
		const lesser = recipe(1244432);
		const healing = recipe(1244433);
		const mw = recipe(10840);
		const hmw = recipe(10841);
		const rune = recipe(18629);
		const mageweave = expectedCrafts(mw, 225, hmw.learnedAt) + 2 * expectedCrafts(hmw, hmw.learnedAt, rune.learnedAt);
		const runecloth = expectedCrafts(rune, rune.learnedAt, 300);
		// The Artisan recipes: only the Triage doctor teaches them.
		const doctorLearn = (spell) => ({
			title: recipe(spell).name,
			raw: [
				`tip ${recipe(spell).name} (skill ${recipe(spell).learnedAt}) is an Artisan recipe: only the Triage doctor teaches it (Doctor Gustaf VanHowzen in Theramore, Doctor Gregory Victor in Hammerfall).`,
				`learn ${spell} npc 12939 only Alliance`,
				`learn ${spell} npc 12920 only Horde`,
			],
		});
		const triageTip = (where) => `tip Triage: the doctor hands you Triage Bandages; use those, not your own. Fifteen wounded soldiers lie ${where}: bandage the critically injured first, then the badly injured, then the injured, before any die (show the health bars with Ctrl+V). Turn the quest in the moment fifteen are saved: the others keep dying, and too many deaths fail it even after it reads complete. If it fails, abandon it and take it again.`;
		return [
			{ section: 'Apprentice' },
			{ apprentice: true },
			{ section: 'First Aid 1-125' },
			band(3275, 1, 40, null, `At ${kit.learnedAt} the trainer also teaches ${kit.name} (${money(kit.cost)}; the Camping 101: First Aid quest at your starting area's camp teaches it free), Forever's camping item for First Aid: three Linen Bandages and a Refreshing Spring Water; it gives a few points until ${kit.grey}.`),
			band(3276, 40, 50, ['learn 3276']),
			{ rank: 'Journeyman' },
			band(3276, 50, 80, null, `Herbalists: ${lesser.name} (from ${lesser.learnedAt}, ${money(lesser.cost)}; Briarthorn, two Mild Spices and an Empty Vial) is orange to ${lesser.yellow}.`),
			band(3277, 80, 115, ['learn 3277'], 'Anti-Venom (Small Venom Sac, from spiders) is taught at 80 too: Rogues need it for Touch of Zanzil, and it sells.'),
			band(3278, 115, 125, ['learn 3278'], `Herbalists: ${healing.name} (from ${healing.learnedAt}, ${money(healing.cost)}; Bruiseweed, Hot Spices and a Leaded Vial) is orange to ${healing.yellow}.`),
			{ section: 'Expert First Aid' },
			{ rank: 'Expert', alsoBuy: [16112, 16113], tip: `The same vendor sells the Heavy Silk and Mageweave Bandage manuals (${money((this.materials[16112] || {}).buy)} and ${money((this.materials[16113] || {}).buy)}): buy both now, you read them at 180 and 210.` },
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
					`tip Artisan First Aid comes from the Triage quest. It needs skill 225 and level ${triage}; the First Aid trainer in Ironforge sends you to the doctor in Theramore. Bring the Mageweave (about ${mageweave}) and Runecloth (about ${runecloth}) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages.`,
					'skill "First Aid" 225',
					`level ${triage}`,
					'accept 6625                             -- Nissa Firestone, Ironforge',
				],
			},
			{
				title: 'Trauma',
				raw: [
					'only Horde',
					'zone Orgrimmar',
					`tip Artisan First Aid comes from the Triage quest. It needs skill 225 and level ${triage}; the First Aid trainer in Orgrimmar sends you to the doctor in Hammerfall. Bring the Mageweave (about ${mageweave}) and Runecloth (about ${runecloth}) for 225-300 now: bandages need no fire, so you craft 225-300 beside the doctor, who teaches the Artisan bandages.`,
					'skill "First Aid" 225',
					`level ${triage}`,
					'accept 6623                             -- Arnok, Orgrimmar',
				],
			},
			{
				title: 'Triage',
				raw: [
					'only Alliance',
					'zone Dustwallow Marsh',
					triageTip('inside'),
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
					triageTip('on the floor inside'),
					'turnin 6623                             -- Doctor Gregory Victor, Hammerfall',
					'accept 6622',
					'complete 6622',
					'turnin 6622                             -- Artisan First Aid',
				],
			},
			{ section: 'First Aid 225-300' },
			band(10840, 225, hmw.learnedAt, null, `Mageweave Bandage turns green at ${mw.green}: switch to Heavy Mageweave there, which costs less cloth than green Mageweave Bandages to ${rune.learnedAt}.`),
			doctorLearn(10841),
			band(10841, hmw.learnedAt, rune.learnedAt, null),
			doctorLearn(18629),
			band(18629, rune.learnedAt, 300, null, `Runecloth Bandage turns green at ${rune.green}, yet to 300 it takes about the same Runecloth as switching to Heavy Runecloth Bandage (the doctor teaches it at ${recipe(18630).learnedAt}): one recipe is enough.`),
		];
	},
};

// ------------------------------------------------------------------ Cooking

const cooking = {
	file: 'cooking',
	skill: 'Cooking',
	title: 'Cooking 1-300',
	levels: '5-60',
	craftTip: 'Cook at any fire: a town hearth or your own Basic Campfire.',
	header: [
		'Cooking 1-300 for both factions: recipes in orange/yellow order from',
		'professions.json. Trainer recipes up to 130 (Forever teaches Coyote Steak,',
		'Boiled Clams, Crab Cake and Dry Pork Ribs well below their yellow rank: the',
		'sniffed trainer lists), then vendor recipes whose ingredients drop far more',
		'often than the trainer\'s clams and spider meat (Curiously Tasty Omelet, Hot',
		'Lion Chops, Roast Raptor). Each segment says where its ingredients drop (the',
		'densest cluster of normal creatures that drop them, or the clams that hold',
		'them, from items.json) or the vendor that sells them. Expert is a cookbook',
		'(Shandrina, Ashenvale / Wulan, Desolace); Artisan is the Clamlette Surprise',
		'quest in Gadgetzan. Poached Sunscale Salmon, the usual Classic finish, needs',
		'an Iron Oven on Forever (the skill-300 camp feature): the route ends on',
		'Monster Omelet.',
		'Craft counts use the Classic skill-up chance (grey - skill) / (grey - yellow).',
		'INGAME: can a character under level 20 read the Expert Cookbook at skill 125?',
		'(the book carries no level requirement; Classic guides gate it at 20)',
	],
	apprenticeTip(ctx) {
		const fire = recipeOf(ctx, 1229737);
		const m = (id) => money((this.materials[id] || {}).buy);
		return `Forever: every cook knows Basic Campfire. Craft a Basic Campfire Kit from one Simple Wood (${m(4470)}) with Flint and Tinder (${m(4471)}, kept in your bags), then place the kit to light a cooking fire anywhere; make a few in advance (one use every 5 minutes). The first kits also raise Cooking to about ${fire.grey}. The Camping 101: Cooking quest at your starting area's camp sends you to this trainer.`;
	},
	route(ctx) {
		const G = GROUPS;
		const roastBoar = 2540;
		const charredWolf = 2538;
		const crabCake = 2544;
		const omelet = recipeOf(ctx, 15933);
		const omeletCrafts = expectedCrafts(omelet, 225, 300);
		const skyborne = { races: ['Skyborne'] };
		const westfall = { races: ['Human', 'Skyborne'], side: 'Alliance' };
		const clamlette = (f, zone, giver) => ({
			title: 'Dirge Quikcleave',
			raw: [`only ${f}`, `zone ${zone}`, `tip Artisan Cooking comes from Dirge Quikcleave in Gadgetzan (Tanaris). The cooking trainer in ${zone} sends you; it needs skill 225 and level ${ctx.data.quest(6610).minLevel}.`, 'skill Cooking 225', `level ${ctx.data.quest(6610).minLevel}`, giver],
		});
		const egg = dropSpot(ctx, 12207, 1425);
		const muckshells = npcCluster(ctx, 1445, 'Muckshell Scrabbler');
		const raptors = 'Arathi Highlands: Hammon Karwn at Refuge Pointe (Alliance) and Keena at Hammerfall (Horde) sell the recipe and Hot Spices beside the raptors.';
		return [
			{ section: 'Apprentice' },
			{ apprentice: true },
			{ section: 'Cooking 1-50' },
			{ who: G.human, zone: 1429, spell: charredWolf, from: 1, to: 50 },
			{ who: G['dwarf-gnome'], zone: 1426, spell: roastBoar, from: 1, to: 50 },
			{ who: G.nightelf, zone: 1438, spell: 8604, from: 1, to: 50, tip: "Herb Baked Egg comes with Cooking (the client teaches it with the skill); Mild Spices are a cooking vendor's. The Strigid owls of Teldrassil drop a Small Egg more often than not, and Darkshore's moonkin drop them too. Fishers can cook Brilliant Smallfish (recipe 40c) from Rut'theran's waters instead, and Zarrin in Dolanaar gives Recipe of the Kaldorei (seven Small Spider Legs from the Webwood spiders) for Kaldorei Spider Kabob, orange from 10 to 50." },
			{ who: skyborne, zone: 2521, spell: charredWolf, from: 1, to: 50, tip: 'The Vuldren of Zephras Isle drop Stringy Wolf Meat.' },
			{ who: G['orc-troll'], zone: 1411, spell: roastBoar, from: 1, to: 50 },
			{ who: G.tauren, zone: 1412, spell: charredWolf, from: 1, to: 50 },
			{ who: G.undead, zone: 1420, spell: charredWolf, from: 1, to: 50 },
			// Journeyman opens 50-130 (a player past 50 who lacks it is held at its trainer there).
			{ section: 'Cooking 50-130' },
			{ rank: 'Journeyman' },
			{ who: westfall, zone: 1436, spell: 2541, from: 50, to: 90, learn: 'trainer', tip: 'Coyotes roam the middle of Westfall; Salma Saldean on the farm north of Sentinel Hill also gives Westfall Stew and Goretusk Liver Pie quests that use what you loot here.' },
			{ who: westfall, zone: 1436, spell: crabCake, from: 90, to: 130, learn: 'trainer', tip: 'Crawlers line the whole Westfall coast. Cook it to 130, where Curiously Tasty Omelet takes over.' },
			{ who: G['dwarf-gnome'], zone: 1432, spell: 8607, from: 50, to: 80, learn: 'vendor', tip: 'Black bears roam the hills of Loch Modan.' },
			{ who: G['dwarf-gnome'], zone: 1432, spell: 2546, from: 80, to: 130, learn: 'trainer', tip: 'Mountain boars roam all of Loch Modan. Cook it to 130, where Curiously Tasty Omelet takes over.' },
			{ who: G.nightelf, zone: 1439, spell: 6499, from: 50, to: 90, learn: 'trainer', tip: 'The same coastal crawlers drop Crawler Meat for Crab Cake next: keep it.' },
			{ who: G.nightelf, zone: 1439, spell: crabCake, from: 90, to: 130, learn: 'trainer', tip: 'Crawlers line the whole Darkshore coast. Cook it to 130, where Curiously Tasty Omelet takes over.' },
			{ who: H, zone: 1413, spell: 6416, from: 50, to: 100, learn: 'vendor' },
			{ who: H, zone: 1413, spell: 6418, from: 100, to: 130, learn: 'vendor', alsoBuy: [3735], tip: `Zargh, the butcher beside this vendor at the Crossroads, sells Recipe: Hot Lion Chops (${money((this.materials[3735] || {}).buy)}), the recipe after Expert: buy it now.` },
			{ section: 'Expert Cooking' },
			{ rank: 'Expert' },
			{ section: 'Cooking 130-175' },
			{ who: A, zone: 1437, spell: 3376, from: 130, to: 175, learn: 'vendor', tip: 'The raptors of the Wetlands drop a Raptor Egg about two kills in three. Kendor Kabonka in Stormwind sells the recipe.' },
			{ who: H, zone: 1424, spell: 3398, from: 130, to: 175, learn: 'vendor', tip: 'The Feral and Hulking Mountain Lions of Hillsbrad Foothills drop Lion Meat more often than the Starving ones.' },
			{ section: 'Cooking 175-225' },
			{ who: ALL, zone: 1417, spell: 15855, from: 175, to: 225, learn: 'vendor', tip: `${raptors} Spider Sausage (any trainer from 200, 40s) is the alternative, but it takes two White Spider Meat a craft and Dustwallow's spiders drop one about two kills in five.` },
			{ section: 'Artisan Cooking: Clamlette Surprise' },
			clamlette('Alliance', 'Ironforge', 'accept 6612                             -- Daryl Riknussun, Ironforge'),
			clamlette('Horde', 'Orgrimmar', 'accept 6611                             -- Zamja, Orgrimmar'),
			{
				title: 'Giant Eggs',
				raw: ['zone The Hinterlands', `tip Clamlette Surprise asks for 12 Giant Eggs, 10 Zesty Clam Meat and 20 Alterac Swiss: bring all three before you go to Tanaris, so you make the trip once. Giant Eggs drop from the owlbeasts of The Hinterlands: ${egg.mobs.join(', ')}. Monster Omelet takes about ${omeletCrafts} more after Artisan: farm them now too if you like.`, 'collect 12207 x12'],
			},
			{
				title: 'Alterac Swiss',
				raw: ['tip Innkeepers and food vendors sell Alterac Swiss; the arrow picks the nearest.', 'buy 8932 x20 nearest'],
			},
			{
				title: 'Zesty Clam Meat',
				raw: [
					'zone Dustwallow Marsh',
					"tip Zesty Clam Meat comes from Big-mouth Clams: open each one, every clam holds one. The Muckshell crabs on the Dustwallow Marsh coast south-west of Theramore drop a clam about seven kills in ten, so ten clams take about fifteen kills, on your way to Tanaris. The Steeljaw Snappers on Tanaris's east coast drop them about one kill in three.",
					`collect 7974 x10 @${fmt(muckshells.x)},${fmt(muckshells.y)}`,
				],
			},
			{
				title: 'Clamlette Surprise',
				raw: ['zone Tanaris', 'turnin 6612 only Alliance', 'turnin 6611 only Horde', 'accept 6610', 'turnin 6610                             -- Artisan Cooking'],
			},
			{ section: 'Cooking 225-300' },
			{ who: ALL, zone: 1425, spell: 15933, from: 225, to: 300, learn: 'vendor', tip: `Monster Omelet is orange to ${omelet.yellow} and green from ${omelet.green}, yet it still carries you to 300. Fishers can finish on Nightfin Soup (Gikkix, Steamwheedle Port; yellow to 310) instead; Poached Sunscale Salmon needs an Iron Oven on Forever.` },
		];
	},
};

module.exports = {
	firstAid: { file: firstAid.file, skill: firstAid.skill, render: (ctx) => renderGuide(ctx, firstAid) },
	cooking: { file: cooking.file, skill: cooking.skill, render: (ctx) => renderGuide(ctx, cooking) },
	expectedCrafts,
	dropSpot,
	learnNote,
};
