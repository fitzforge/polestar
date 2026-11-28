'use strict';
// Cooking and First Aid 1-300 guides (see build.js): built by ../route.js from their route files
// (routes/cooking.json, routes/first-aid.json; docs/forge/professions.md, "Route files"), on the data the
// crafting drafts use. What else lives here serves Fishing + Cooking (../pair-fishing.js): the expected
// crafts of a cooking stretch, where a drop is farmed, and the Clamlette Surprise steps.

const { dist } = require('../../route/geo');
const R = require('./route');
const { fmt, zoneName } = require('./common');

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

// The crafts 9 players in 10 need at most (the same chance per point; a normal approximation of the sum of
// one geometric draw per point). Gathered and dropped ingredients are counted to it, so a yellow or green
// stretch rarely sends a player back to farm; vendor goods stay at the expected count.
function crafts90(recipe, from, to) {
	let mean = 0;
	let v = 0;
	for (let s = from; s < to; s++) {
		const p = s < recipe.yellow ? 1 : (recipe.grey - s) / (recipe.grey - recipe.yellow);
		mean += 1 / p;
		v += (1 - p) / (p * p);
	}
	return Math.max(expectedCrafts(recipe, from, to), Math.ceil(mean + 1.2816 * Math.sqrt(v)));
}

// The normal creatures in `zone` that drop `item`, weighted by drop chance:
// { pts, names, rated, weight, levels }. The data rates an item's droppers from one
// table (items.json `dropScale`), so a dropper that table does not rate has a
// null chance: when no rated dropper of 5% or more stands in the zone, the
// unrated ones count, weighted alike and named without a chance. `minChance`:
// the least rated chance that counts (percent). `levels`: [lowest, highest] of
// the droppers counted (their `level` to `levelMax`), or null.
function zoneDroppers(ctx, item, zone, minChance = 5) {
	const it = ctx.data.item(item);
	const droppers = Object.entries((it && it.drops && it.drops.npc) || {});
	const gather = (rated) => {
		const pts = [];
		const names = new Map();
		let levels = null;
		for (const [id, chance] of droppers) {
			if (rated ? chance === null || chance < minChance : chance !== null) continue;
			const n = ctx.data.npc(id);
			if (!n || n.rank || (n.roles && n.roles.length)) continue; // no elites, rares or service NPCs
			if (n.faction !== null && n.faction !== undefined) continue;
			const s = n.spawns && n.spawns[String(zone)];
			if (!s || R.allPoints(s).length < 3) continue; // no lone named spawns
			for (const [x, y] of R.allPoints(s)) pts.push({ name: n.name, w: rated ? chance / 100 : 0.05, pt: ctx.project.point(zone, x, y, s.f) });
			names.set(n.name, rated ? Math.max(names.get(n.name) || 0, chance) : (names.get(n.name) || 0) + R.allPoints(s).length);
			if (n.level > 0) levels = levels ? [Math.min(levels[0], n.level), Math.max(levels[1], n.levelMax || n.level)] : [n.level, n.levelMax || n.level];
		}
		return { pts, names, rated, weight: pts.reduce((a, p) => a + p.w, 0), levels };
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
	return { pt: spawn.pt, mobs: top, via: best.via, levels: best.levels };
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

// Artisan Cooking: Clamlette Surprise (6610), from the capital cooking trainer's quest to the hand-in in
// Gadgetzan, with its three ingredients on the way. `eggNote`: what the Giant Eggs step adds.
function clamletteSteps(ctx, eggNote = '') {
	const quest = ctx.data.quest(6610);
	const level = quest.minLevel;
	// The capital cooking trainers' errands to Dirge, while the data makes Clamlette Surprise follow them (the
	// corrections drop them: he offers it to anyone from level 35).
	const feeders = new Set(quest.pre || []);
	const clamlette = (f, zone, giver) => ({
		title: 'Dirge Quikcleave',
		raw: [`only ${f}`, `zone ${zone}`, `tip Artisan Cooking comes from Dirge Quikcleave in Gadgetzan (Tanaris). The cooking trainer in ${zone} sends you; it needs skill 225 and level ${level}.`, 'skill Cooking 225', `level ${level}`, giver],
	});
	const errands = [
		[6612, clamlette('Alliance', 'Ironforge', 'accept 6612                             -- Daryl Riknussun, Ironforge')],
		[6611, clamlette('Horde', 'Orgrimmar', 'accept 6611                             -- Zamja, Orgrimmar')],
	].filter(([q]) => feeders.has(q));
	const egg = dropSpot(ctx, 12207, 1425);
	const muckshells = npcCluster(ctx, 1445, 'Muckshell Scrabbler');
	return [
		...errands.map(([, s]) => s),
		{
			title: 'Giant Eggs',
			raw: ['zone The Hinterlands', `tip Clamlette Surprise asks for 12 Giant Eggs, 10 Zesty Clam Meat and 20 Alterac Swiss: bring all three before you go to Tanaris, so you make the trip once. Giant Eggs drop from the owlbeasts of The Hinterlands: ${egg.mobs.join(', ')}.${eggNote ? ` ${eggNote}` : ''}`, 'collect 12207 x12'],
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
			raw: ['zone Tanaris', ...(errands.length ? [] : ['skill Cooking 225', `level ${level}`]), ...errands.map(([q]) => `turnin ${q} only ${q === 6612 ? 'Alliance' : 'Horde'}`), 'accept 6610', 'turnin 6610                             -- Artisan Cooking'],
		},
	];
}

// A route-built guide for build.js: route.js over its route file, on the crafting drafts' data.
let routeData = null;
function routed(name) {
	return (ctx) => {
		const { draftData } = require('../guide');
		const { routeGuide } = require('../route');
		if (!routeData || routeData.dir !== ctx.data.dir) routeData = { dir: ctx.data.dir, data: draftData(ctx.data.dir) };
		return routeGuide(name, routeData.data, { command: 'profession gathering build' }).text;
	};
}

module.exports = {
	firstAid: { file: 'first-aid', skill: 'First Aid', render: routed('First Aid') },
	cooking: { file: 'cooking', skill: 'Cooking', render: routed('Cooking') },
	expectedCrafts,
	crafts90,
	dropSpot,
	clamletteSteps,
};
