'use strict';
// Specs for the generated profession guides (see build.js). Mining, Herbalism
// and Skinning are band specs rendered by build.js; Fishing renders itself.
// scope: 'start' = each race's starting zone, 'next' = the zone after it,
// 'region' = per continent group, 'faction' = anywhere the faction can work.

const { MINING_NODES, HERB_NODES } = require('./tables');
const abundance = require('./abundance');
const { SKINNING_POINTS } = require('./skinning');
const { GATHERING_NOTE } = require('./notes');
const fishing = require('./fishing');
const secondary = require('./secondary');
const R = require('./route');
const { money } = require('./common');

// "Smelt Copper (orange to 25, grey at 70)".
function colours(r) {
	return `${r.name} (${r.yellow > r.learnedAt ? `orange to ${r.yellow}, ` : ''}grey at ${r.grey})`;
}

// The Camping 101 quest of every starting area and Zephras Isle teaches the
// profession's skill-20 camping recipe (Forever).
function campingTip(skill, camp) {
	return `If you sat at your starting area's campfire for The Great Outdoors, the camping guide there also offers Camping 101: ${skill}: hand it in to the ${skill.toLowerCase()} trainer it names once you reach skill 20, for the ${camp} recipe.`;
}

// Forever's gathering manuals: a reward choice of one early quest per starting
// area (quests.json reward choices 247840 / 247841 / 247846); the client spell
// of each adds 2 skill up to 15.
function manualTip(book) {
	return `The first-hour quest of each starting area (Rascally Rodents, Coldridge Valley Mail Delivery, The Woodland Protector, Galgar's Cactus Apple Surprise, A Humble Task, Marla's Last Wish) offers ${book} as a reward: reading it gives 2 skill, up to 15.`;
}

// Quests in a band's zone that need the profession (quests.json `skill`) and
// that a side of the step can take, on the band's first step: " A quest here
// needs Skinning: Rough Wolf Pelts (level 7, Helene Peltskinner; Alliance)."
// Camping 101 has its own tip.
const RACE_SIDE = { Human: 'A', Dwarf: 'A', Gnome: 'A', NightElf: 'A', Orc: 'H', Troll: 'H', Tauren: 'H', Undead: 'H' };
function skillQuests(ctx, skillLine, e) {
	if (e.cont) return '';
	const words = e.cond ? e.cond.split(',') : [];
	const sides = new Set(e.cond ? words.map((w) => (w === 'Alliance' ? 'A' : w === 'Horde' ? 'H' : RACE_SIDE[w])).filter(Boolean) : ['A', 'H']);
	if (!sides.size) ['A', 'H'].forEach((s) => sides.add(s));
	const seen = new Set();
	const out = [];
	for (const q of Object.values(ctx.data.quests || {})) {
		if (!q || q.skill !== skillLine || q.zone !== e.zone || /^Camping 101/.test(q.title)) continue;
		const races = q.races ? BigInt(q.races) : null;
		const side = races === null ? null : races & 1n && !(races & 2n) ? 'A' : races & 2n && !(races & 1n) ? 'H' : null;
		if (side && !sides.has(side)) continue;
		const giver = q.start && q.start.npc && q.start.npc.length ? (ctx.data.npc(q.start.npc[0]) || {}).name : null;
		const text = `${q.title} (level ${q.level}${giver ? `, ${giver}` : ''}${side && sides.size > 1 ? `; ${side === 'A' ? 'Alliance' : 'Horde'}` : ''})`;
		if (seen.has(text)) continue;
		seen.add(text);
		out.push({ level: q.level, text });
	}
	if (!out.length) return '';
	out.sort((a, b) => a.level - b.level || a.text.localeCompare(b.text));
	const skill = { 182: 'Herbalism', 186: 'Mining', 393: 'Skinning' }[skillLine];
	return out.length > 1 ? ` Quests here that need ${skill}: ${out.map((q) => q.text).join(', ')}.` : ` A quest here needs ${skill}: ${out[0].text}.`;
}

// Tier-1 camping item learned at skill 20 (Forever's camps: placed beside a
// campfire, it gives everyone at the camp a buff for an hour).
function campTip(skill, what) {
	return (r) => `${r.name}, Forever's camping item for ${skill}, is taught from skill ${r.learnedAt} (${money(r.cost)}, or free from Camping 101: ${skill}): ${what}, it gives points until ${r.grey}; placed beside a campfire it gives everyone at the camp a buff for an hour.`;
}

function list(nodes, short) {
	return nodes
		.filter((n) => n.color && n.color !== 'grey')
		.map((n) => (n.later ? `${short(n.name)} (from ${n.req}${n.rare ? ', rare' : ''})` : `${short(n.name)} (${n.req}, ${n.color}${n.rare ? ', rare' : ''})`))
		.join(', ');
}

// The node that gives the band the most skill-ups, and the next one when it
// gives at least a quarter as many (rare ones left out): what the band is
// about, lower requirement first.
function title(nodes, short) {
	const useful = nodes.filter((n) => n.gain > 0 && !n.rare);
	const ranked = (useful.length ? useful : nodes.filter((n) => n.gain > 0)).slice().sort((a, b) => b.gain - a.gain);
	const pick = ranked.filter((n, i) => i === 0 || (i === 1 && n.gain >= ranked[0].gain / 4)).sort((a, b) => a.req - b.req || a.name.localeCompare(b.name));
	return pick.map((n) => short(n.name)).join(' & ');
}

function zoneWarn(z) {
	return z ? ` Zone level ${z.min}-${z.max}.` : '';
}

// "Peacebloom, Silverleaf 1, Earthroot 15, ...": the herb table by skill,
// Forever's starter herbs left out (they share Peacebloom's and Silverleaf's).
function herbSkills() {
	const by = new Map();
	for (const [name, req] of Object.entries(HERB_NODES)) {
		if (/^(Wilted|Stunted) /.test(name)) continue;
		if (!by.has(req)) by.set(req, []);
		by.get(req).push(name);
	}
	return [...by.entries()].map(([req, names]) => `${names.join(', ')} ${req}`).join(', ');
}

// Header comment lines of at most 76 characters.
function wrap(text) {
	const out = [''];
	for (const word of text.split(' ')) {
		const cur = out[out.length - 1];
		if (cur && cur.length + 1 + word.length > 76) out.push(word);
		else out[out.length - 1] = cur ? `${cur} ${word}` : word;
	}
	return out;
}

const shortOre = (n) => n.replace(/ (Mineral Vein|Vein|Deposit)$/, '');

const mining = {
	file: 'mining',
	skill: 'Mining',
	title: 'Mining 1-300',
	levels: '1-60',
	headerZone: 'Ironforge',
	role: 'mine',
	tool: { item: 2901, name: 'Mining Pick', why: 'keep it in your bags, you cannot mine without it.' },
	shortName: shortOre,
	// Yards' worth of time to stop at a node and gather it (about 5 seconds at a run).
	stopYards: 35,
	points(ctx, map, from, to) {
		return R.nodePoints(ctx.data.objects, ctx.project, { table: MINING_NODES, role: 'mine', map, from, to, abundance: abundance.load()[String(map)] || null });
	},
	bands: [
		{ from: 1, to: 65, scope: 'start' },
		{ from: 65, to: 125, scope: 'region' },
		{ from: 125, to: 155, scope: 'faction' },
		{ from: 155, to: 175, scope: 'faction' },
		{ from: 175, to: 230, scope: 'faction' },
		{ from: 230, to: 245, scope: 'faction' },
		{ from: 245, to: 275, scope: 'faction' },
		{ from: 275, to: 300, scope: 'faction' },
	],
	bandTitle(nodes) {
		return title(nodes, shortOre);
	},
	camp: 1230161,
	campTip: campTip('Mining', 'a Rough Stone and a Copper Bar each'),
	learnTip: `Turn on Find Minerals (spellbook, General tab) so veins show on the minimap. Forever's starting areas also have Poor Copper Veins (Copper Ore and Rough Stone, from skill 1). ${manualTip('Mining for Dummies')} Trade goods vendors and the junior trainers sell the Apprentice's Mining Pack, a four-slot bag for ore and stone (25c). ${campingTip('Mining', 'Lodestone')}`,
	trainerRecipes: (r) => r.focus === 'Forge' && /^Smelt /.test(r.name),
	recipesWhy: 'smelting at a forge raises Mining too, so smelt what you mine.',
	countNodes: 'nodes',
	bandTip(nodes, e, z, ctx) {
		const p = ctx.data.professionNamed('Mining');
		const all = ((p && p.recipes) || []).filter((r) => r.source === 'trainer' && /Forge$/.test(r.focus || '') && /^Smelt /.test(r.name));
		const smelts = all.filter((r) => r.focus === 'Forge' && r.learnedAt <= e.from && r.grey > e.from).sort((a, b) => a.learnedAt - b.learnedAt);
		let smelt = smelts.length ? ` Smelt at a forge when your bags fill: ${smelts.map(colours).join(', ')} ${smelts.length > 1 ? 'give' : 'gives'} points too.` : ' Smelting gives no points from here (the higher smelts are grey once learned): smelt to craft or sell, or sell the ore.';
		for (const r of smelts.filter((x) => x.reagents.length > 1)) {
			const what = r.reagents.map((g) => `${g.count > 1 ? `${g.count} ` : 'a '}${(ctx.data.item(g.item) || {}).name || `item ${g.item}`}`).join(' and ');
			smelt += ` ${r.name} takes ${what} each: keep bars from the smelts before it.`;
		}
		const names = new Set(nodes.filter((n) => n.color && n.color !== 'grey').map((n) => n.name));
		const dark = all.find((r) => r.focus === 'Black Forge');
		if (names.has('Dark Iron Deposit') && dark) smelt += ` Dark Iron Ore smelts only at the Black Forge in Blackrock Depths (${dark.reagents[0].count} ore a bar).`;
		return `Mine every ${list(nodes, shortOre)} node you pass and circle the waypoints until Mining ${e.to}.${smelt}${skillQuests(ctx, 186, e)}${zoneWarn(z)}`;
	},
	header: [
		'Mining 1-300 for both factions: loops through the densest skill-up nodes for',
		'each skill band (expected skill-ups per yard walked), with rank training.',
		'A zone counts the nodes it keeps up at once (the Forever server\'s spawn pools,',
		'tools/lib/professions/gathering/node-abundance.json), not every spot a node can use.',
		'Skill needed per node: Copper 1, Tin and Incendicite 65, Silver and Lesser',
		'Bloodstone 75, Iron 125, Gold 155, Mithril 175, Truesilver and Dark Iron 230,',
		'Small Thorium 245, Rich Thorium 275.',
		'',
		...GATHERING_NOTE,
	],
};

const herbalism = {
	file: 'herbalism',
	skill: 'Herbalism',
	title: 'Herbalism 1-300',
	levels: '1-60',
	headerZone: 'Ironforge',
	role: 'herb',
	stopYards: 35,
	points(ctx, map, from, to) {
		return R.nodePoints(ctx.data.objects, ctx.project, { table: HERB_NODES, role: 'herb', map, from, to, abundance: abundance.load()[String(map)] || null });
	},
	bands: [
		{ from: 1, to: 50, scope: 'start' },
		{ from: 50, to: 100, scope: 'next' },
		{ from: 100, to: 125, scope: 'region' },
		{ from: 125, to: 160, scope: 'faction' },
		{ from: 160, to: 185, scope: 'faction' },
		{ from: 185, to: 210, scope: 'faction' },
		{ from: 210, to: 230, scope: 'faction' },
		{ from: 230, to: 260, scope: 'faction' },
		{ from: 260, to: 285, scope: 'faction' },
		{ from: 285, to: 300, scope: 'faction' },
	],
	bandTitle(nodes) {
		return title(nodes, (n) => n);
	},
	camp: 1229705,
	campTip: campTip('Herbalism', 'a Peacebloom and a Silverleaf each'),
	learnTip: `Turn on Find Herbs (spellbook, General tab) so herbs show on the minimap. Forever's starting areas also have Wilted Peacebloom and Stunted Silverleaf (skill 1). ${manualTip('Wild Harvest')} Trade goods vendors sell the Apprentice's Herb Pouch, a four-slot bag for herbs (25c). ${campingTip('Herbalism', 'Incense Candle')}`,
	countNodes: 'herbs',
	bandTip(nodes, e, z, ctx) {
		const names = new Set(nodes.filter((n) => n.color && n.color !== 'grey').map((n) => n.name));
		const extra = [];
		if (names.has('Mageroyal') || names.has('Briarthorn')) extra.push('Mageroyal and Briarthorn sometimes give a Swiftthistle as well.');
		if (names.has('Stranglekelp')) extra.push('Stranglekelp grows underwater along the shore: watch your breath.');
		if (names.has('Grave Moss')) extra.push('Grave Moss grows in graveyards and crypts.');
		if (names.has('Ghost Mushroom')) extra.push('Ghost Mushroom grows in caves and dark hollows: look inside as well.');
		if (names.has('Purple Lotus')) extra.push('Purple Lotus sometimes gives a Wildvine as well.');
		if (names.has('Gromsblood')) extra.push('Gromsblood grows near demon and satyr camps: pull carefully.');
		return `Pick every ${list(nodes, (n) => n)} you pass and circle the waypoints until Herbalism ${e.to}.${extra.length ? ` ${extra.join(' ')}` : ''}${skillQuests(ctx, 182, e)}${zoneWarn(z)}`;
	},
	header: [
		'Herbalism 1-300 for both factions: loops through the densest skill-up herbs',
		'for each skill band (expected skill-ups per yard walked), with rank training.',
		'A zone counts the herbs it keeps up at once (the Forever server\'s spawn pools,',
		'tools/lib/professions/gathering/node-abundance.json), not every spot a herb can use.',
		...wrap(`Skill needed per herb: ${herbSkills()}.`),
		'',
		...GATHERING_NOTE,
	],
};

const skinning = {
	file: 'skinning',
	skill: 'Skinning',
	title: 'Skinning 1-300',
	levels: '1-60',
	headerZone: 'Ironforge',
	tool: { item: 7005, name: 'Skinning Knife', why: 'keep it in your bags, you cannot skin without it.' },
	radius: 150,
	minPoints: 4,
	// Yards' worth of time to kill and skin one beast (about 15 seconds at a run).
	stopYards: 100,
	// Every beast kind is a camp of its own: a rare one may lead and name a
	// waypoint (for nodes, build.js `rareKinds` keeps rare kinds from leading).
	rareLeads: true,
	points: SKINNING_POINTS,
	bands: [
		{ from: 1, to: 50, scope: 'start' },
		{ from: 50, to: 100, scope: 'next' },
		{ from: 100, to: 125, scope: 'region' },
		{ from: 125, to: 150, scope: 'region' },
		{ from: 150, to: 175, scope: 'faction' },
		{ from: 175, to: 200, scope: 'faction' },
		{ from: 200, to: 225, scope: 'faction' },
		{ from: 225, to: 250, scope: 'faction' },
		{ from: 250, to: 275, scope: 'faction' },
		{ from: 275, to: 300, scope: 'faction' },
	],
	bandTitle(nodes) {
		const lv = nodes.map((n) => n.level);
		return `Beasts ${Math.min(...lv)}-${Math.max(...lv)}`;
	},
	camp: 1229517,
	campTip: campTip('Skinning', 'three Light Leather and two Simple Wood each'),
	learnTip: `${manualTip('Pelt Collecting for Beginners')} Trade goods vendors and the junior trainers sell the Apprentice's Skinning Satchel, a four-slot bag for leather and hides (25c). ${campingTip('Skinning', 'Camp Chair')}`,
	countNodes: 'beasts',
	bandTip(nodes, e, z, ctx) {
		const names = nodes.filter((n) => n.color && n.color !== 'grey').map((n) => `${n.name} (${n.level}${n.later ? `, needs ${n.req}` : ''})`);
		return `Kill and skin ${names.join(', ')} along the loop until Skinning ${e.to}; loot each corpse, then skin it, and skin the highest-level beasts your skill allows. A beast of level L needs skill (L-10)x10 up to level 20 and Lx5 above.${skillQuests(ctx, 393, e)}${zoneWarn(z)}`;
	},
	header: [
		'Skinning 1-300 for both factions: loops through the densest skinnable beasts',
		'of the right level for each skill band, with rank training. Skill needed: 1 for',
		'level 10 and below, (level-10)x10 for 11-20, level x5 above 20.',
		'Beast lists per zone are curated (tools/lib/professions/gathering/skinning.js);',
		'levels and spawns come from npcs.json.',
		'',
		...GATHERING_NOTE,
	],
};

const SPECS = [mining, herbalism, skinning, fishing, secondary.cooking, secondary.firstAid];

module.exports = { SPECS };
