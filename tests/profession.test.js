'use strict';
// `profession draft`: client-table loading (fixture CSVs under
// tests/fixtures/professions/wago: a Forever build, 1.60.1.1, and the Classic
// Era build, 1.15.9.1, that fills its gaps), skill thresholds, the recipe
// planner's choices on small professions, and deterministic output. The
// fixture's data/professions.json is `forge data professions --data
// tests/fixtures/professions/data --sources tests/fixtures/professions`
// (forge-data's draft_fixture_is_this_build checks it).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const { loadTables } = require('../tools/lib/professions/tables');
const { planProfession, chance, expectedCrafts, SWITCH_BASE, SWITCH_CRAFTS } = require('../tools/lib/professions/plan');
const { draftGuide, farmSpot, skinSpot } = require('../tools/lib/professions/guide');
const D = require('../tools/lib/professions/describe');
const { sourceOf, gatherCost, homeMap, zoneOf } = require('../tools/lib/professions/materials');
const { DATA: REAL_DATA, needs } = require('./helpers/data');

const FX = path.join(__dirname, 'fixtures', 'professions');
const DATA = path.join(FX, 'data');
const readJson = (name) => JSON.parse(fs.readFileSync(path.join(DATA, `${name}.json`), 'utf8'));

const PROFESSIONS = path.join(DATA, 'professions.json');

test('loadTables reads the cached Forever build offline, Era only for a table it lacks, and fails clearly on a missing table', async () => {
	const res = await loadTables({ sourcesDir: FX, offline: true, product: 'forever' });
	assert.equal(res.build, '1.60.1.1');
	assert.equal(res.tables.SkillLine.length, 2);
	assert.equal(res.tables.SkillLine[0].DisplayName_lang, 'Tailoring');
	// Not cached for Forever: read whole from Era, with a warning.
	assert.equal(res.eraBuild, '1.15.9.1');
	assert.deepEqual(res.tables.SpellFocusObject, [{ ID: '1', Name_lang: 'Anvil' }]);
	assert.ok(res.warnings.some((w) => /^SpellFocusObject: no Forever 1\.60\.1\.1 table .*read Classic Era 1\.15\.9\.1$/.test(w)));
	assert.equal(res.tables.SpellTotems.length, 1, "Forever's own SpellTotems");
	// A table no cached build holds fails.
	await assert.rejects(loadTables({ sourcesDir: FX, offline: true, product: 'forever', tables: ['SkillLine', 'Nope'] }), /no cached wago\.tools build/);
	// The other tools that read client tables through loadTables still get Era by default.
	assert.equal((await loadTables({ sourcesDir: FX, offline: true, tables: ['SkillLine'] })).build, '1.15.9.1');
});

test('skill-up chance: certain while orange, linear from yellow to grey, none at grey', () => {
	const r = { yellow: 25, grey: 50 };
	assert.equal(chance(r, 1), 1);
	assert.equal(chance(r, 24), 1);
	assert.equal(chance(r, 25), 1);
	assert.equal(chance(r, 30), 0.8);
	assert.equal(chance(r, 49), 1 / 25);
	assert.equal(chance(r, 50), 0);
	assert.equal(expectedCrafts(r, 1, 26), 25);
	assert.equal(expectedCrafts(r, 1, 27), 25 + 25 / 24);
	assert.equal(expectedCrafts(r, 45, 51), Infinity);
	assert.ok(Math.abs(expectedCrafts(r, 45, 50) - (25 / 5 + 25 / 4 + 25 / 3 + 25 / 2 + 25)) < 1e-9);
});

// A small profession: vendor-bought reagents only, both factions.
function smallProfession(recipes) {
	const vend = { Alliance: [1], Horde: [2] };
	const materials = {
		10: { name: 'Cheap Thread', buy: 10, buyCount: 1, sell: 2, quality: 1, vendors: vend },
		20: { name: 'Pricey Thread', buy: 40, buyCount: 1, sell: 10, quality: 1, vendors: vend },
		30: { name: 'Gold Thread', buy: 400, buyCount: 1, sell: 100, quality: 1, vendors: vend },
	};
	const prof = { id: 197, name: 'Tailoring', kind: 'primary', ranks: [], trainers: { Alliance: [], Horde: [] }, recipes, materials };
	return { prof, data: { professions: { 197: prof }, npcs: {}, objects: {}, zones: {} } };
}
const rec = (spell, learnedAt, yellow, grey, item, extra = {}) => ({ spell, name: `R${spell}`, item: 900 + spell, itemCount: 1, reagents: [{ item, count: 1 }], source: 'trainer', learnedAt, yellow, grey, green: Math.floor((yellow + grey) / 2), ...extra });

test('planner: the cheaper of two equal recipes wins the whole bracket', () => {
	const { prof, data } = smallProfession([rec(1, 1, 70, 90, 20), rec(2, 1, 70, 90, 10)]);
	const plan = planProfession(prof, data, { to: 75 });
	assert.deepEqual(plan.segments.map((s) => [s.spell, s.from, s.to]), [[2, 1, 75]]);
	// 69 orange crafts (1 -> 70), then 20 / (90 - k) per point while yellow.
	assert.equal(plan.segments[0].count, Math.ceil(69 + [70, 71, 72, 73, 74].reduce((a, k) => a + 20 / (90 - k), 0)));
});

test('planner: switching recipes happens at the cheapest point (checked by brute force)', () => {
	// A: cheap, turns grey at 40. B: dearer, learnable at 20, good to 90.
	const A = rec(1, 1, 15, 40, 10);
	const B = rec(2, 20, 60, 90, 20);
	const { prof, data } = smallProfession([A, B]);
	const plan = planProfession(prof, data, { to: 75 });
	const seg = (r, cost, s, t) => SWITCH_BASE + SWITCH_CRAFTS * cost + expectedCrafts(r, s, t) * cost;
	let best = { total: Infinity };
	for (let t = 20; t <= 40; t++) {
		const total = seg(A, 10, 1, t) + seg(B, 40, t, 75);
		if (total < best.total - 1e-9) best = { total, t };
	}
	assert.deepEqual(plan.segments.map((s) => [s.spell, s.from, s.to]), [[1, 1, best.t], [2, best.t, 75]]);
	assert.ok(Math.abs(plan.total - best.total) < 1e-6);
});

test('planner: segments stop at rank caps and skip unusable recipes', () => {
	const { prof, data } = smallProfession([
		rec(1, 1, 100, 140, 10),
		rec(2, 1, 100, 140, 10, { requires: 20219 }),
		rec(3, 1, 100, 140, 10, { reputation: { faction: 576, standing: 5 } }),
		rec(4, 1, 100, 140, 10, { focus: 'Black Anvil' }),
		rec(5, 1, 100, 140, 10, { name: 'Transmute: Iron to Gold' }),
		rec(6, 1, 100, 140, 10, { source: 'drop', recipeItem: 77 }),
	]);
	prof.recipes.forEach((r) => {
		r.reagents = [{ item: 30, count: 1 }];
	});
	prof.recipes[0].reagents = [{ item: 10, count: 1 }];
	const plan = planProfession(prof, data, { to: 100 });
	assert.deepEqual(plan.segments.map((s) => [s.spell, s.from, s.to]), [[1, 1, 75], [1, 75, 100]]);
	assert.deepEqual(plan.excluded.map((e) => e.spell), [2, 3, 4, 5, 6]);
});

test('planner and draft: past the last usable recipe the plan stops and the guide names what is left', () => {
	// Forever Tailoring at 295: every recipe that still gives a point needs a
	// station (Spinning Wheel, Loom) or is a drop.
	const { prof, data } = smallProfession([rec(1, 1, 40, 60, 10), rec(2, 1, 55, 90, 10, { focus: 'Spinning Wheel' }), rec(3, 1, 55, 90, 10, { source: 'drop', recipeItem: 77 })]);
	const plan = planProfession(prof, data, { to: 75 });
	assert.equal(plan.reach, 60);
	assert.deepEqual(plan.segments.map((s) => [s.spell, s.from, s.to]), [[1, 1, 60]]);
	const { text } = draftGuide('Tailoring', data, { to: 75, spec: {} });
	assert.match(text, /^# {4}60-75 no trainer or vendor recipe gives points without a camp station \(see the last step\)$/m);
	assert.match(text, /\nstep Tailoring 60-75\n {2}tip On Forever no recipe .* past 60, .* Recipes that still do: R2 \(needs a Spinning Wheel\), R3 \(recipe is a drop\)\.\n {2}skill Tailoring 75\n$/);
	assert.throws(() => planProfession(smallProfession([rec(1, 20, 40, 60, 10)]).prof, data, { to: 75 }), /no recipe chain starts at 1/);
});

test('planner: a material the profession makes is crafted, and its recipe gates the user', () => {
	const bolt = { spell: 50, name: 'Bolt', item: 40, itemCount: 1, reagents: [{ item: 10, count: 2 }], source: 'trainer', learnedAt: 1, yellow: 25, grey: 50, green: 37 };
	const cloak = { spell: 51, name: 'Cloak', item: 41, itemCount: 1, reagents: [{ item: 40, count: 1 }], source: 'trainer', learnedAt: 1, yellow: 70, grey: 90, green: 80 };
	const { prof, data } = smallProfession([bolt, cloak]);
	prof.materials[40] = { name: 'Bolt', sell: 0, buy: 0, quality: 1, madeBy: [{ skillLine: 197, spell: 50 }] };
	const plan = planProfession(prof, data, { to: 60 });
	assert.deepEqual(plan.segments.map((s) => s.spell), [51]);
	const s = plan.segments[0];
	assert.deepEqual(s.make.map((m) => [m.recipe.spell, m.count]), [[50, s.count]]);
	assert.deepEqual(s.need.map((n) => [n.item, n.count]), [[10, 2 * s.count]]);
});

test('planner: an intermediate that is not grey gives points too, so fewer crafts reach the goal', () => {
	const bolt = { spell: 50, name: 'Bolt', item: 40, itemCount: 1, reagents: [{ item: 10, count: 2 }], source: 'trainer', learnedAt: 1, yellow: 25, grey: 50, green: 37 };
	const cloak = { spell: 51, name: 'Cloak', item: 41, itemCount: 1, reagents: [{ item: 40, count: 1 }], source: 'trainer', learnedAt: 1, yellow: 70, grey: 90, green: 80 };
	const { prof, data } = smallProfession([bolt, cloak]);
	prof.materials[40] = { name: 'Bolt', sell: 0, buy: 0, quality: 1, madeBy: [{ skillLine: 197, spell: 50 }] };
	// Bolt left out: nothing makes the cloak's bolt, so there is no route at all.
	assert.throws(() => planProfession(prof, data, { to: 60, exclude: { 50: 'not on its own' } }), /no recipe chain starts at 1/);
	const withBolt = planProfession(prof, data, { to: 60, noLevel: { 50: 'parts only' } });
	assert.deepEqual(withBolt.segments.map((s) => s.spell), [51]);
	// 1 -> 50 with a bolt per cloak: two points a craft while both are orange (below 25), one after.
	const s = withBolt.segments[0];
	assert.ok(s.count < 59, `${s.count} crafts for 59 points`);
	assert.ok(withBolt.excluded.every((e) => e.spell !== 50), 'noLevel keeps the recipe for parts');
});

test('planner: a vendor recipe whose only seller has no faction is left out (Pexmit in Mount Hyjal)', () => {
	const { prof, data } = smallProfession([rec(1, 1, 40, 60, 10), rec(2, 1, 70, 90, 10, { source: 'vendor', recipeItem: 50, cost: 100 })]);
	prof.materials[50] = { name: 'Pattern: Cuffs', buy: 100, buyCount: 1, sell: 25, quality: 1, vendors: { Alliance: [9], Horde: [9] } };
	data.npcs = { 9: { id: 9, name: 'Pexmit', faction: null } };
	const plan = planProfession(prof, data, { to: 75 });
	assert.ok(plan.excluded.some((e) => e.spell === 2 && /one faction only/.test(e.why)));
	data.npcs[9].faction = 'AH';
	assert.ok(!planProfession(prof, data, { to: 75 }).excluded.some((e) => e.spell === 2));
});

test('planner: a faction-less vendor Classic knows serves both sides (Kania\'s Formula: Lesser Mana Oil in Cenarion Hold)', () => {
	const { prof, data } = smallProfession([rec(1, 1, 40, 60, 10), rec(2, 1, 70, 90, 10, { source: 'vendor', recipeItem: 50, cost: 100 })]);
	prof.materials[50] = { name: 'Formula: Oil', buy: 100, buyCount: 1, sell: 25, quality: 1, vendors: { Alliance: [9], Horde: [9] } };
	// The data carries no side for a neutral town's NPC; pfQuest knows it, so it is a Classic one.
	data.npcs = { 9: { id: 9, name: 'Kania', faction: null, source: ['pfquest', 'questie-forever'] } };
	assert.ok(!planProfession(prof, data, { to: 75 }).excluded.some((e) => e.spell === 2));
	// A Forever-new NPC with no side still counts for neither (Pexmit).
	data.npcs[9].source = ['questie-forever'];
	assert.ok(planProfession(prof, data, { to: 75 }).excluded.some((e) => e.spell === 2 && /one faction only/.test(e.why)));
});

test('planner and draft: a quest-reward plan is usable from the quest\'s skill and costs its hand-in (Derotain\'s Imperial Plate plans)', () => {
	const { prof, data } = smallProfession([rec(1, 1, 40, 60, 10), rec(2, 30, 70, 90, 10, { source: 'item', recipeItem: 77 })]);
	prof.materials[77] = { name: 'Plans: Boots', sell: 1, buy: 4, quality: 2, bop: true };
	data.quests = {
		7652: { id: 7652, title: 'A Bargain', objectives: [], start: { npc: [5] }, minLevel: 50, skillLevel: 40 },
		7654: { id: 7654, title: 'Boots', objectives: [{ type: 'item', id: 30, count: 4 }], start: { npc: [5] }, minLevel: 50, skillLevel: 40, preAny: [7652] },
	};
	data.npcs = { 5: { id: 5, name: 'Derotain Mudsipper', faction: 'AH', spawns: { 1446: { pts: [[51, 28]] } } } };
	data.zones = { 1446: { name: 'Tanaris' } };
	assert.ok(planProfession(prof, data, { to: 75 }).excluded.some((e) => e.spell === 2 && /item/.test(e.why)), 'without the spec the item plan has no source');
	const plan = planProfession(prof, data, { to: 75, questRecipes: { 2: 7654 } });
	const seg = plan.segments.find((s) => s.spell === 2);
	assert.ok(seg && seg.from >= 40, 'not before the quest\'s skill');
	assert.equal((seg.need.find((n) => n.item === 30) || {}).count, 4, 'the hand-in is on the shopping list');
	const { text } = draftGuide('Tailoring', data, { to: 75, spec: { questRecipes: { 2: 7654 } } });
	// The step sits in the giver's zone, so its quest goals resolve there.
	assert.match(text, /\nstep Plans: Boots\n {2}zone Tanaris\n {2}tip Derotain Mudsipper \(Tanaris\) trades Plans: Boots \(Tailoring 30\) for 4 Gold Thread in Boots, which needs Tailoring 40 and character level 50; take A Bargain first \(it asks for nothing\)\. The plans bind when picked up\.\n {2}level 50\n {2}accept 7652\n {2}turnin 7652\n {2}accept 7654\n {2}turnin 7654\n/);
	assert.match(text, /\n {2}learn 2 -- from the recipe in your bags\n/);
	assert.match(text, /\(quest, 4 Gold Thread\)/);
});

test('planner: a good sold only far from the capitals is crafted when the profession can (Wizzle Brassbolts\' blasting powder)', () => {
	const powder = { spell: 50, name: 'Powder', item: 40, itemCount: 1, reagents: [{ item: 20, count: 1 }], source: 'trainer', learnedAt: 1, yellow: 25, grey: 50, green: 37 };
	const bomb = { spell: 51, name: 'Bomb', item: 41, itemCount: 1, reagents: [{ item: 40, count: 1 }], source: 'trainer', learnedAt: 1, yellow: 70, grey: 90, green: 80 };
	const { prof, data } = smallProfession([powder, bomb]);
	prof.materials[40] = { name: 'Powder', buy: 30, buyCount: 1, sell: 5, quality: 1, vendors: { Alliance: [7], Horde: [7] }, madeBy: [{ skillLine: 197, spell: 50 }] };
	data.npcs = { 7: { id: 7, name: 'Wizzle Brassbolts', faction: 'AH', spawns: { 1441: { pts: [[78, 77]] } } } };
	const far = planProfession(prof, data, { to: 60, noLevel: { 50: 'parts' } });
	assert.deepEqual(far.segments[0].make.map((m) => m.recipe.spell), [50], 'only Thousand Needles sells it: make it');
	data.npcs[7].spawns = { 1453: { pts: [[50, 50]] } };
	const near = planProfession(prof, data, { to: 60, noLevel: { 50: 'parts' } });
	assert.deepEqual(near.segments[0].make, [], 'a Stormwind seller is cheaper than making it');
});

test('planner: a tool the profession makes comes where it still gives a point, not where it is first needed (the Arclight Spanner)', () => {
	const spanner = { spell: 60, name: 'Spanner', item: 45, itemCount: 1, reagents: [{ item: 10, count: 6 }], source: 'trainer', learnedAt: 20, yellow: 40, grey: 60, green: 50 };
	const { prof, data } = smallProfession([rec(1, 1, 15, 30, 10), rec(3, 25, 50, 65, 10), rec(2, 60, 100, 140, 10, { tools: [45] }), spanner]);
	prof.materials[45] = { name: 'Spanner', sell: 0, buy: 0, quality: 1, madeBy: [{ skillLine: 197, spell: 60 }] };
	const plan = planProfession(prof, data, { to: 75, noLevel: { 60: 'a tool' } });
	const at = plan.segments.findIndex((s) => s.tools.some((t) => t.item === 45));
	const needs = plan.segments.findIndex((s) => s.spell === 2);
	assert.ok(at >= 0 && at < needs, `made in segment ${at}, needed from ${needs}`);
	assert.ok(plan.segments[at].from >= 20 && plan.segments[at].from < 40, 'learnable and still orange there');
	assert.deepEqual(plan.segments[at].make.map((m) => [m.recipe.spell, m.count]), [[60, 1]]);
});

test('materials: a smelted bar is worth at least what goes into it (Steel Bar: an Iron Bar and a Coal)', () => {
	const mining = {
		name: 'Mining',
		recipes: [
			{ spell: 3307, item: 3575, itemCount: 1, reagents: [{ item: 2772, count: 1 }] },
			{ spell: 3569, item: 3859, itemCount: 1, reagents: [{ item: 3575, count: 1 }, { item: 3857, count: 1 }] },
		],
		materials: { 2772: { name: 'Iron Ore', sell: 150, quality: 1 }, 3575: { name: 'Iron Bar', sell: 200, quality: 1 }, 3857: { name: 'Coal', buy: 500, buyCount: 1, sell: 125, quality: 1, vendors: { Alliance: [1], Horde: [2] } } },
	};
	const ctx = { professions: { 186: mining }, npcs: {}, objects: {}, zones: {}, self: 164 };
	const steel = sourceOf(3859, { name: 'Steel Bar', sell: 60, quality: 1, madeBy: [{ skillLine: 186, spell: 3569 }] }, 'Alliance', ctx);
	assert.deepEqual([steel.kind, steel.cost], ['crafted', 200 * 4 + 500], 'an Iron Bar at its worth and vendor Coal, not 4 x 60c');
	const iron = sourceOf(3575, { name: 'Iron Bar', sell: 200, quality: 1, madeBy: [{ skillLine: 186, spell: 3307 }] }, 'Alliance', ctx);
	assert.equal(iron.cost, 200 * 4, 'its own worth beats the ore it is smelted from');
});

test('materials: disenchanted, fished, cloth and other professions\' goods are valued above their sell price', () => {
	const ctx = { professions: { 171: { name: 'Alchemy', recipes: [{ spell: 3171, name: 'Elixir of Wisdom', reagents: [] }] } }, npcs: {}, objects: {}, zones: {}, self: 197 };
	const enchanter = { ...ctx, self: 333 };
	assert.equal(sourceOf(1, { name: 'Lesser Magic Essence', sell: 0, buy: 0, quality: 1 }, 'Alliance', enchanter).cost, 800);
	// Strange Dust sold at 8s stays a disenchanting material to an enchanter (worth 5s); a cheaper vendor wins.
	const dust = (buy, c = enchanter) => sourceOf(1, { name: 'Strange Dust', sell: 1, buy, quality: 1, vendors: { Alliance: [7] } }, 'Alliance', c);
	assert.deepEqual([dust(800).kind, dust(800).cost], ['disenchant', 500]);
	assert.deepEqual([dust(100).kind, dust(100).cost], ['vendor', 100]);
	// To any other profession they are an enchanter's goods (a friend or the Auction House), six times
	// that: the 8s vendor wins, and a leatherworker's 2 Soul Dust a craft lose to plain leather.
	assert.equal(sourceOf(1, { name: 'Lesser Magic Essence', sell: 0, buy: 0, quality: 1 }, 'Alliance', ctx).cost, 800 * 6);
	assert.deepEqual([dust(800, ctx).kind, dust(800, ctx).cost], ['vendor', 800]);
	assert.deepEqual([dust(4000, ctx).kind, dust(4000, ctx).cost], ['disenchant', 500 * 6]);
	assert.equal(sourceOf(1, { name: 'Raw Fish', sell: 1, quality: 1, gather: { fishing: [1] } }, 'Alliance', ctx).cost, 400);
	assert.ok(Math.abs(sourceOf(1, { name: 'Wool Cloth', sell: 33, quality: 1, dropCount: 50, drops: [{ npc: 1, chance: 20 }] }, 'Alliance', ctx).cost - 100 * Math.sqrt(0.33) * 4 * 3) < 1e-9);
	const elixir = sourceOf(1, { name: 'Elixir of Wisdom', sell: 25, quality: 1, madeBy: [{ skillLine: 171, spell: 3171 }] }, 'Alliance', ctx);
	assert.deepEqual([elixir.kind, elixir.cost], ['crafted', 25 * 4 * 6]);
});

test('materials: cloth and leather by the square root of the sell price, a hide four times that', () => {
	const ctx = { professions: {}, npcs: {}, objects: {}, zones: {}, self: 165 };
	const cost = (name, sell, extra = {}) => sourceOf(1, { name, sell, quality: 1, ...extra }, 'Alliance', ctx).cost;
	const near = (a, b) => assert.ok(Math.abs(a - b) < 1e-9, `${a} != ${b}`);
	near(cost('Medium Leather', 50), 400 * Math.sqrt(0.5));
	// Medium Hide sells for 2.5 Medium Leather but comes off one beast in twenty.
	near(cost('Medium Hide', 125), 400 * Math.sqrt(1.25) * 4);
	assert.equal(cost('Cured Medium Hide', 125), Infinity, 'a cured hide is tanned, not skinned');
	// Runecloth sells for 30 Linen; a piece of it is worth a few.
	const cloth = { dropCount: 50, drops: [{ npc: 1, chance: 20 }] };
	const ratio = cost('Runecloth', 400, cloth) / cost('Linen Cloth', 13, cloth);
	assert.ok(ratio > 4 && ratio < 6, `Runecloth / Linen ${ratio}`);
	// Other materials keep four times their sell price.
	assert.equal(cost('Iron Ore', 50, { gather: { mine: [1] } }), 200);
});

test('planner: a world-drop pattern that does not bind is bought at the Auction House from its skill on', () => {
	const { prof, data } = smallProfession([rec(1, 1, 40, 60, 10), rec(2, 30, 70, 90, 10, { source: 'drop', recipeItem: 60 }), rec(3, 30, 70, 90, 10, { source: 'drop', recipeItem: 61 })]);
	prof.materials[60] = { name: 'Pattern: Traded', sell: 1, quality: 2 };
	prof.materials[61] = { name: 'Pattern: Bound', sell: 1, quality: 2, bop: true };
	assert.equal(planProfession(prof, data, { to: 75 }).reach, 60);
	const plan = planProfession(prof, data, { to: 75, auction: { 2: 50, 3: 50 } });
	assert.deepEqual(plan.segments.map((s) => [s.spell, s.from, s.to]), [[1, 1, 50], [2, 50, 75]]);
	assert.ok(plan.excluded.some((e) => e.spell === 3 && /not a world drop that can be traded/.test(e.why)));
	const { text } = draftGuide('Tailoring', data, { to: 75, spec: { auction: { 2: 50 } } });
	assert.match(text, /^# {4}50-75 {2}R2, about \d+ \(pattern from the Auction House\)/m);
	assert.match(text, /Its pattern \(Pattern: Traded\) drops from mobs all over the world and does not bind: buy it at the Auction House\./);
	assert.match(text, /\n {2}learn 2 -- from the pattern bought at the Auction House\n {2}craft 2 until 75\n/);
	// The pattern is the bracket's Auction House buy (no gather way: always bought).
	assert.match(text, /\nstep Tailoring 1-75: Auction House\n {2}tip What 1-75 takes that the Auction House sells: a Pattern: Traded\. [^\n]+\n {2}auction 60 x1\n/);
	assert.doesNotMatch(text, /auction 61 /);
});

test('planner: what an earlier segment crafts counts against a later one\'s needs', () => {
	// R1 levels 1-45 and makes item 901; R2 takes two 901 a craft.
	const A = rec(1, 1, 40, 50, 10);
	const B = rec(2, 45, 70, 90, 901);
	B.reagents = [{ item: 901, count: 2 }];
	const { prof, data } = smallProfession([A, B]);
	prof.materials[901] = { name: 'Part', sell: 0, buy: 0, quality: 1, madeBy: [{ skillLine: 197, spell: 1 }] };
	const plan = planProfession(prof, data, { to: 75, noLevel: {} });
	const [a, b] = plan.segments;
	assert.deepEqual([a.spell, b.spell], [1, 2]);
	assert.deepEqual(b.fromStock, [{ item: 901, count: a.count }]);
	assert.equal(b.make.find((m) => m.recipe.spell === 1).count, 2 * b.count - a.count);
});

test('cloth farm spots stay in the cloth\'s level band and never cost reputation (Timbermaw)', () => {
	const pts = (n, x) => Array.from({ length: n }, (_, i) => [x + (i % 5), 40 + Math.floor(i / 5)]);
	const npc = (id, name, level, n, x) => ({ id, name, level, levelMax: level + 1, faction: null, spawns: { 1447: { f: 'e', pts: pts(n, x) } } });
	const data = {
		items: { 4338: { id: 4338, name: 'Mageweave Cloth', drops: { npc: { 1: 30, 2: 30, 6189: 40 }, object: {} } } },
		npcs: { 1: npc(1, 'Shadowsworn Adept', 52, 30, 10), 2: npc(2, 'Dunemaul Enforcer', 46, 10, 40), 6189: npc(6189, 'Timbermaw Ursa', 47, 30, 70) },
		objects: {},
		zones: { 1447: { name: 'Azshara', type: 3 } },
		mapFrames: { era: { 1447: { c: 1 } } },
	};
	assert.equal(farmSpot(4338, 'cloth', 'Horde', 1, data).label, 'Dunemaul Enforcer');
	// A drop that is not cloth has no band.
	assert.equal(farmSpot(4338, 'drop', 'Horde', 1, data).label, 'Shadowsworn Adept');
});

test('draft: a recipe only a later rank\'s trainers teach is learned there, and that rank is offered', () => {
	const { prof, data } = smallProfession([rec(1, 1, 40, 60, 10), rec(2, 55, 70, 90, 10)]);
	const at = (map, x) => ({ [map]: { f: 'e', pts: [[x, 50]] } });
	data.npcs = { 3: { id: 3, name: 'Jay', faction: 'A', spawns: at(1453, 40) }, 4: { id: 4, name: 'Kay', faction: 'H', spawns: at(1454, 40) } };
	data.zones = { 1453: { name: 'Stormwind City' }, 1454: { name: 'Orgrimmar' } };
	prof.ranks = [
		{ name: 'Apprentice', max: 75, minSkill: 0, minLevel: 5, trainers: { Alliance: [], Horde: [] } },
		{ name: 'Journeyman', max: 150, minSkill: 50, minLevel: 10, trainers: { Alliance: [3], Horde: [4] } },
	];
	const { text } = draftGuide('Tailoring', data, { to: 75, spec: { taughtBy: { 2: 'Journeyman' } } });
	assert.match(text, /R2 \(from 55\) is taught only by the Journeyman trainers: Alliance Jay \(Stormwind City\); Horde Kay \(Orgrimmar\)\. You can train Journeyman there now if you are level 10 \(it needs Tailoring 50\), which saves the trip at 75\./);
	assert.match(text, /\n {2}learn 2 npc 3 only Alliance\n {2}learn 2 npc 4 only Horde\n {2}train Tailoring Journeyman optional\n/);
});

test('draft: a Journeyman not every trainer teaches names its trainers; a smelted bar\'s vendor half is an optional buy (Coal for Steel)', () => {
	const { prof, data } = smallProfession([rec(1, 1, 140, 170, 3859, { learnedAt: 1 })]);
	const at = (map, x) => ({ [map]: { f: 'e', pts: [[x, 50]] } });
	data.npcs = { 3: { id: 3, name: 'Jay', faction: 'A', spawns: at(1453, 40) }, 4: { id: 4, name: 'Kay', faction: 'H', spawns: at(1454, 40) }, 5: { id: 5, name: 'Argus', faction: 'A', spawns: at(1453, 60) }, 6: { id: 6, name: 'Dwukk', faction: 'H', spawns: at(1454, 60) } };
	data.zones = { 1453: { name: 'Stormwind City' }, 1454: { name: 'Orgrimmar' } };
	prof.trainers = { Alliance: [3, 5], Horde: [4, 6] };
	prof.ranks = [
		{ name: 'Apprentice', max: 75, minSkill: 0, minLevel: 1, trainers: { Alliance: [3, 5], Horde: [4, 6] } },
		{ name: 'Journeyman', max: 150, minSkill: 50, minLevel: 10, trainers: { Alliance: [3], Horde: [4] } },
	];
	prof.materials[3859] = { name: 'Steel Bar', sell: 60, quality: 1, madeBy: [{ skillLine: 186, spell: 3569 }] };
	data.professions[186] = {
		id: 186,
		name: 'Mining',
		recipes: [{ spell: 3569, name: 'Smelt Steel', item: 3859, itemCount: 1, learnedAt: 165, reagents: [{ item: 3575, count: 1 }, { item: 3857, count: 1 }] }],
		materials: { 3575: { name: 'Iron Bar', sell: 200, quality: 1 }, 3857: { name: 'Coal', buy: 500, buyCount: 1, sell: 125, quality: 1, vendors: { Alliance: [1], Horde: [2] } } },
	};
	const { text } = draftGuide('Tailoring', data, { to: 150, spec: {} });
	assert.match(text, /Any Tailoring trainer of your faction teaches it; the arrow picks the nearest\./);
	assert.match(text, /Not every Tailoring trainer teaches it: Alliance Jay \(Stormwind City\); Horde Kay \(Orgrimmar\)\. The arrow picks the nearest of your faction\./);
	assert.match(text, /If you smelt the \d+ Steel Bar yourself \(Mining 165: an Iron Bar and a Coal each\), buy (\d+) Coal too \([^)]+\); skip them if you buy the bars\./);
	assert.match(text, /\n {2}buy 3857 x\d+ nearest optional\n/);
});

test('draft: a rank only a few trainers teach comes after the shopping, and its later recipes are learned on the same visit', () => {
	// Expert Alchemy: Ainethil or Halsey also teach Mana Potion (160), so the
	// player brings the materials, trains, crafts there and learns at 160.
	const { prof, data } = smallProfession([rec(1, 1, 140, 170, 10), rec(2, 160, 190, 230, 10)]);
	const at = (map, x) => ({ [map]: { f: 'e', pts: [[x, 50]] } });
	data.npcs = { 3: { id: 3, name: 'Jay', faction: 'A', spawns: at(1453, 40) }, 4: { id: 4, name: 'Kay', faction: 'H', spawns: at(1454, 40) }, 5: { id: 5, name: 'Ainethil', faction: 'A', spawns: at(1457, 40) }, 6: { id: 6, name: 'Halsey', faction: 'H', spawns: at(1458, 40) } };
	data.zones = { 1453: { name: 'Stormwind City' }, 1454: { name: 'Orgrimmar' }, 1457: { name: 'Darnassus' }, 1458: { name: 'Undercity' } };
	prof.ranks = [
		{ name: 'Apprentice', max: 75, minSkill: 0, minLevel: 1, trainers: { Alliance: [3, 5], Horde: [4, 6] } },
		{ name: 'Journeyman', max: 150, minSkill: 50, minLevel: 10, trainers: { Alliance: [3, 5], Horde: [4, 6] } },
		{ name: 'Expert', max: 225, minSkill: 125, minLevel: 20, trainers: { Alliance: [5], Horde: [6] } },
	];
	const { text } = draftGuide('Tailoring', data, { to: 225, spec: {} });
	const steps = text.split('\n').filter((l) => l.startsWith('step '));
	assert.ok(steps.indexOf('step Expert Tailoring') > steps.indexOf('step Tailoring 150-225: vendor goods'), steps.join('\n'));
	assert.match(text, /these trainers also teach R2 \(from 160\), and the crafts need no station, so craft right here and learn each recipe as you reach its skill\. One trip instead of 2\./);
	assert.match(text, /\n {2}tip Still at the Expert trainer: R2 \(from 160\)\.\n {2}learn 2\n/);
	// Journeyman is taught by every trainer: its step stays first.
	assert.ok(steps.indexOf('step Journeyman Tailoring') < steps.indexOf('step Tailoring 75-150: vendor goods'));
});

test('draft: a learn pinned to a later rank\'s trainers keeps its own trip after a one-visit bracket (Rugged Leather at Drakk Stonehand)', () => {
	// Expert Leatherworking: Telonis or Una teach Thick Leather (160) too, so
	// one visit; Rugged Leather (195) only Drakk or Hahrana teach.
	const { prof, data } = smallProfession([rec(1, 1, 140, 170, 10), rec(2, 160, 190, 200, 10), rec(3, 195, 220, 240, 10)]);
	const at = (map, x) => ({ [map]: { f: 'e', pts: [[x, 50]] } });
	data.npcs = { 3: { id: 3, name: 'Jay', faction: 'A', spawns: at(1453, 40) }, 4: { id: 4, name: 'Kay', faction: 'H', spawns: at(1454, 40) }, 5: { id: 5, name: 'Telonis', faction: 'A', spawns: at(1457, 40) }, 6: { id: 6, name: 'Una', faction: 'H', spawns: at(1456, 40) }, 7: { id: 7, name: 'Drakk', faction: 'A', spawns: at(1425, 40) }, 8: { id: 8, name: 'Hahrana', faction: 'H', spawns: at(1444, 40) } };
	data.zones = { 1453: { name: 'Stormwind City' }, 1454: { name: 'Orgrimmar' }, 1457: { name: 'Darnassus' }, 1456: { name: 'Thunder Bluff' }, 1425: { name: 'The Hinterlands' }, 1444: { name: 'Feralas' } };
	prof.ranks = [
		{ name: 'Apprentice', max: 75, minSkill: 0, minLevel: 1, trainers: { Alliance: [3, 5, 7], Horde: [4, 6, 8] } },
		{ name: 'Journeyman', max: 150, minSkill: 50, minLevel: 10, trainers: { Alliance: [3, 5, 7], Horde: [4, 6, 8] } },
		{ name: 'Expert', max: 225, minSkill: 125, minLevel: 20, trainers: { Alliance: [5, 7], Horde: [6, 8] } },
		{ name: 'Artisan', max: 300, minSkill: 200, minLevel: 35, trainers: { Alliance: [7], Horde: [8] } },
	];
	const { text } = draftGuide('Tailoring', data, { to: 225, spec: { taughtBy: { 3: 'Artisan' } } });
	assert.match(text, /these trainers also teach R2 \(from 160\), and the crafts need no station, so craft right here and learn each recipe as you reach its skill\. One trip instead of 2\. R3 \(from 195\) takes a second trip, to other trainers \(below\)\./);
	assert.match(text, /\n {2}tip Still at the Expert trainer: R2 \(from 160\)\.\n {2}learn 2\n/);
	assert.match(text, /R3 \(from 195\) is taught only by the Artisan trainers: Alliance Drakk \(The Hinterlands\); Horde Hahrana \(Feralas\)\./);
	assert.match(text, /\n {2}learn 3 npc 7 only Alliance\n {2}learn 3 npc 8 only Horde\n/);
});

test('planner: a recipe held back to a skill neither levels nor makes an intermediate before it (Tailoring\'s Runecloth to Artisan)', () => {
	// R2 makes item 902, R3 takes it; both wait for 50.
	const R3 = rec(3, 1, 70, 90, 902);
	const { prof, data } = smallProfession([rec(1, 1, 60, 80, 20), rec(2, 1, 70, 90, 10), R3]);
	prof.materials[902] = { name: 'Bolt', sell: 0, buy: 0, quality: 1, madeBy: [{ skillLine: 197, spell: 2 }] };
	assert.ok(planProfession(prof, data, { to: 75 }).segments[0].spell !== 1);
	const plan = planProfession(prof, data, { to: 75, notBefore: { 2: 50 } });
	assert.ok(plan.segments.every((s) => s.spell === 1 || s.from >= 50), JSON.stringify(plan.segments.map((s) => [s.spell, s.from, s.to])));
	assert.equal(plan.segments[0].spell, 1);
});

test('draft: specs add the camp recipe per faction, notes at a skill, a stop and its last step, and a disenchanted material is a bag count', () => {
	const dust = { name: 'Strange Dust', sell: 0, buy: 0, quality: 1 };
	const { prof, data } = smallProfession([rec(1, 1, 40, 60, 10), rec(2, 20, 70, 90, 70)]);
	prof.materials[70] = dust;
	const spec = {
		intro: ['What it makes.'],
		camp: { spells: [{ spell: 900, only: 'Alliance' }, { spell: 901, only: 'Horde' }], at: 20, tip: 'Also learn the camp item.' },
		notes: [{ at: 30, text: 'A note at 30.' }],
		to: 70,
		lastRoute: 'nothing cheap',
		last: 'The last points come from elsewhere.',
	};
	const { text } = draftGuide('Tailoring', data, { to: 75, spec });
	assert.match(text, /^# What it makes\.$/m);
	assert.match(text, /\n {2}learn 2\n {2}learn 900 only Alliance\n {2}learn 901 only Horde\n/);
	assert.match(text, /A note at 30\./);
	// Strange Dust: bought at the Auction House or disenchanted (Enchanting), one way at a time.
	assert.match(text, /\nstep Tailoring 1-75: Auction House\n {2}tip What 1-75 takes that the Auction House sells: 10 Strange Dust\. The counts drop by what your bags, bank and mail hold\.\n {2}auction 70 x10\n/);
	assert.match(text, /\nstep Strange Dust\n {2}tip 10 Strange Dust for R2: Enchanting: disenchant green items of item level 5-20\.\n {2}collect 70 x10 anywhere gather Enchanting 1\n/);
	assert.match(text, /^# {4}70-75 nothing cheap \(see the last step\)$/m);
	assert.match(text, /\nstep Tailoring 70-75\n {2}tip The last points come from elsewhere\.\n {2}skill Tailoring 75\n$/);
	assert.doesNotMatch(text, /Strange Dust \(\d+ for/);
});

test('draft: a limited-stock vendor recipe that binds when picked up is not sent to the Auction House (#315)', () => {
	// Forever's Recipe: Holy Protection Potion binds when picked up, so no
	// player can sell it there; a recipe that does not bind keeps the hint.
	const { prof, data } = smallProfession([
		rec(1, 1, 40, 60, 10),
		rec(2, 40, 70, 90, 10, { source: 'vendor', recipeItem: 50, cost: 100 }),
		rec(3, 1, 45, 65, 10),
	]);
	const limited = { Alliance: [1], Horde: [2] };
	prof.materials[50] = { name: 'Recipe: Bound', buy: 100, buyCount: 1, sell: 25, quality: 1, limitedVendors: limited, bop: true };
	const tip = (text) => text.split('\n').find((l) => l.startsWith('  tip Recipe: Bound teaches R2'));
	assert.equal(tip(draftGuide('Tailoring', data, { to: 75, spec: {} }).text), '  tip Recipe: Bound teaches R2 (Tailoring 40) for 1s. Its sellers keep one or two in stock that come back some time after a sale; it binds when picked up, so the Auction House never has it.');
	delete prof.materials[50].bop;
	assert.equal(tip(draftGuide('Tailoring', data, { to: 75, spec: {} }).text), '  tip Recipe: Bound teaches R2 (Tailoring 40) for 1s. Its sellers keep one or two in stock that come back some time after a sale; the Auction House often has it too.');
	const ctx = { professions: {}, npcs: {}, objects: {}, zones: {}, self: 197 };
	assert.equal(sourceOf(50, { ...prof.materials[50], bop: true }, 'Alliance', ctx).note, 'limited stock at a vendor');
	assert.equal(sourceOf(50, prof.materials[50], 'Alliance', ctx).note, 'limited stock at a vendor (or the Auction House)');
});

test('materials: vendor price per unit, else 4x sell price scaled by quality', () => {
	const ctx = { professions: {}, npcs: {}, objects: {}, zones: {}, self: 197 };
	const m = { name: 'Empty Vial', buy: 20, buyCount: 5, sell: 1, quality: 1, vendors: { Alliance: [1], Horde: [] } };
	assert.equal(sourceOf(3371, m, 'Alliance', ctx).cost, 4);
	const h = sourceOf(3371, m, 'Horde', ctx);
	assert.notEqual(h.kind, 'vendor');
	assert.equal(gatherCost({ sell: 100, quality: 2 }), 1200);
	assert.equal(sourceOf(1, { name: 'Light Leather', sell: 15, quality: 1 }, 'Alliance', ctx).kind, 'skinning');
	assert.equal(sourceOf(1, { name: 'Cured Light Hide', sell: 15, quality: 1 }, 'Alliance', ctx).kind, 'unknown');
	assert.equal(sourceOf(1, { name: 'Strange Dust', sell: 0, buy: 800, quality: 1 }, 'Alliance', ctx).kind, 'disenchant');
	assert.equal(sourceOf(1, { name: 'Nothing' }, 'Alliance', ctx).cost, Infinity);
});

test('draft: a deterministic guide with smart trainers and vendors, per-faction farming, crafts and checkpoints', async () => {
	const data = {
		professions: JSON.parse(fs.readFileSync(PROFESSIONS, 'utf8')),
		npcs: readJson('npcs'),
		objects: readJson('objects'),
		zones: readJson('zones'),
		items: readJson('items'),
		mapFrames: readJson('map-frames'),
	};
	const a = draftGuide('tailoring', data, { to: 75, spec: {} });
	const b = draftGuide('Tailoring', data, { to: 75, spec: {} });
	assert.equal(a.text, b.text);
	const lines = a.text.split('\n');
	const has = (re) => assert.ok(lines.some((l) => re.test(l)), `missing ${re}`);
	has(/^guide forever\/professions\/tailoring$/);
	has(/^category Professions$/);
	has(/^zone Azeroth$/);
	has(/^step Learn Tailoring$/);
	has(/^ {2}train Tailoring Apprentice$/);
	has(/^ {2}skill Tailoring 1$/);
	has(/^ {2}skill Tailoring 75$/);
	has(/^ {2}craft \d+ until 75$/);
	// Vendor reagents: the nearest vendor of the player's faction, picked at runtime.
	has(/^ {2}buy 2320 x\d+ nearest$/);
	// Trainer recipes learned later carry no fixed trainer.
	has(/^ {2}learn 3913$/);
	// Linen Cloth: the hostile mob on each faction's continent, not the friendly NPC.
	has(/^ {2}only Alliance$/);
	has(/^ {2}collect 2589 x\d+ @50,40 era gather levels \d+-\d+$/);
	has(/^ {2}collect 2589 x\d+ @40,40 era gather levels \d+-\d+$/);
	// The bracket's Auction House step buys the cloth the steps above gather.
	has(/^step Tailoring 1-75: Auction House$/);
	has(/^ {2}auction 2589 x\d+$/);
	// No faction branches for trainers or vendors, and no race branches at all.
	assert.ok(!/^ {2}(train|buy|learn) .* only (Alliance|Horde)/m.test(a.text));
	assert.ok(!/only (Human|Dwarf|Gnome|NightElf|Orc|Troll|Tauren|Undead)/.test(a.text));
	assert.ok(!a.text.includes('Friendly Merchant'));
	assert.throws(() => draftGuide('Mining', data), /not a crafting profession|unknown profession/);
});

test('farm spots skip neutral town guards and NPCs friendly to anyone', async () => {
	// Fixture: Town Bruiser (faction null, 90% Linen Cloth) stands next to the
	// Elwynn innkeeper; Friendly Merchant (Alliance) always drops Linen Cloth.
	const data = { npcs: readJson('npcs'), objects: readJson('objects'), zones: readJson('zones'), items: readJson('items'), mapFrames: readJson('map-frames') };
	const spot = farmSpot(2589, 'cloth', 'Alliance', 0, data);
	assert.equal(spot.label, 'Defias Thug');
	assert.deepEqual([spot.map, spot.x, spot.y], [1429, 50, 40]);
	// Without the town (innkeeper and vendors) the bruiser is just a hostile mob
	// and wins as a drop; as Linen Cloth it is no farm (level 55, Linen's band is 5-20).
	const noInn = { ...data, npcs: { ...data.npcs } };
	for (const id of [1003, 5000, 6000]) delete noInn.npcs[id];
	assert.equal(farmSpot(2589, 'drop', 'Alliance', 0, noInn).label, 'Town Bruiser');
	assert.equal(farmSpot(2589, 'cloth', 'Alliance', 0, noInn).label, 'Defias Thug');
});

test('farm spots weigh the zone side, not where service NPCs happen to be listed', () => {
	// Herb nodes in Darkshore (Alliance zone, more nodes) and The Barrens (Horde).
	const pts = (n, x) => Array.from({ length: n }, (_, i) => [x + (i % 5), 40 + Math.floor(i / 5)]);
	const data = {
		items: { 2452: { id: 2452, name: 'Swiftthistle', drops: { npc: {}, object: { 1: 100, 2: 100 } }, vendors: [] } },
		objects: {
			1: { id: 1, name: 'Briarthorn', roles: ['herb'], spawns: { 1439: { f: 'e', pts: pts(20, 40) } } },
			2: { id: 2, name: 'Briarthorn', roles: ['herb'], spawns: { 1413: { f: 'e', pts: pts(10, 50) } } },
		},
		// A Horde flight master whose spawns are also listed on Darkshore (like Brakkar).
		npcs: { 9: { id: 9, name: 'Border Flier', faction: 'H', roles: ['flightmaster'], spawns: { 1439: { f: 'e', pts: [[99, 1]] }, 1448: { f: 'e', pts: [[34, 53]] } } } },
		zones: { 1439: { id: 1439, name: 'Darkshore', type: 3 }, 1413: { id: 1413, name: 'The Barrens', type: 3 } },
		mapFrames: { era: { 1439: { c: 1 }, 1413: { c: 1 } } },
		nodeAbundance: {}, // no spawn-pool tables: the points decide
	};
	assert.equal(farmSpot(2452, 'herb', 'Horde', 1, data).map, 1413);
	assert.equal(farmSpot(2452, 'herb', 'Alliance', 1, data).map, 1439);
});

test('vein and herb spots count the nodes a zone keeps up at once, from the lowest-skill node, and the tip names the marked zone', () => {
	const pts = (n, x) => Array.from({ length: n }, (_, i) => [x + (i % 5), 40 + Math.floor(i / 5)]);
	const spawns = (...maps) => Object.fromEntries(maps.map((m, i) => [m, { f: 'e', pts: pts(20, 10 + 10 * i) }]));
	const data = {
		items: {
			7912: { id: 7912, name: 'Solid Stone', drops: { npc: {}, object: { 1: 40 } } },
			12365: { id: 12365, name: 'Dense Stone', drops: { npc: {}, object: { 3: 40, 4: 100 } } },
		},
		objects: {
			1: { id: 1, name: 'Mithril Deposit', roles: ['mine'], spawns: spawns(1413, 1443, 1425, 1444) },
			3: { id: 3, name: 'Small Thorium Vein', roles: ['mine'], spawns: spawns(1448) },
			4: { id: 4, name: 'Rich Thorium Vein', roles: ['mine'], spawns: spawns(1447) },
		},
		npcs: {},
		zones: Object.fromEntries([[1413, 'The Barrens'], [1425, 'The Hinterlands'], [1443, 'Desolace'], [1444, 'Feralas'], [1447, 'Azshara'], [1448, 'Felwood']].map(([id, name]) => [id, { id, name, type: 3 }])),
		mapFrames: { era: { 1413: { c: 1 }, 1425: { c: 0 }, 1443: { c: 1 }, 1444: { c: 1 }, 1447: { c: 1 }, 1448: { c: 1 } } },
		// The Barrens lists as many Mithril points as Desolace but keeps under two up.
		nodeAbundance: {
			1413: { 'Mithril Deposit': { up: 1.7 } },
			1425: { 'Mithril Deposit': { up: 16.7 } },
			1443: { 'Mithril Deposit': { up: 10.9 } },
			1444: { 'Mithril Deposit': { up: 12.6 } },
			1447: { 'Rich Thorium Vein': { up: 7.4 } },
			1448: { 'Small Thorium Vein': { up: 8.5 } },
		},
	};
	// Horde (home continent Kalimdor): Desolace, the lowest zone near the best; by points alone The Barrens.
	assert.equal(farmSpot(7912, 'mine', 'Horde', 1, data).map, 1443);
	assert.equal(farmSpot(7912, 'mine', 'Horde', 1, { ...data, nodeAbundance: {} }).map, 1413);
	// Dense Stone at the Small Thorium Veins a miner reaches at 245, not the Rich ones (275) that drop more.
	assert.equal(farmSpot(12365, 'mine', 'Horde', 1, data).map, 1448);
	// The zones a tip lists include the one its step marks.
	const m = { name: 'Solid Stone', gather: { mine: [1] } };
	assert.equal(D.sourceText(data, 7912, m, { kind: 'mine' }, 'Horde'), 'Mining: Mithril Deposit (skill 175) in Desolace (30-40), The Hinterlands (40-50) and Feralas (40-50); or the Auction House');
	assert.equal(D.sourceText(data, 7912, m, { kind: 'mine' }, 'Horde', { marked: 1413 }), 'Mining: Mithril Deposit (skill 175) in The Barrens (10-25), The Hinterlands (40-50) and Feralas (40-50); or the Auction House');
});

test('an NPC listed on two maps stands on its interior map; a capital beats its zone', () => {
	const zones = { 1424: { name: 'Hillsbrad Foothills' }, 1425: { name: 'The Hinterlands' }, 1438: { name: 'Teldrassil' }, 1457: { name: 'Darnassus' } };
	const drakk = { spawns: { 1424: { f: 'e', pts: [[98.7, 2.3]] }, 1425: { f: 'e', pts: [[13.4, 43.5]] } } };
	assert.equal(homeMap(drakk), 1425);
	assert.equal(zoneOf(drakk, zones), 'The Hinterlands');
	const ainethil = { spawns: { 1438: { f: 'e', pts: [[28.6, 51.9]] }, 1457: { f: 'e', pts: [[54.9, 24]] } } };
	assert.equal(homeMap(ainethil), 1457);
	assert.equal(homeMap({ spawns: {} }), null);
});

test('draft: cloth is counted in the bags, from humanoids as you level or the Auction House, never a farm trip', () => {
	const { prof, data } = smallProfession([rec(1, 1, 70, 90, 2589)]);
	prof.materials[2589] = { name: 'Linen Cloth', buy: 55, buyCount: 1, sell: 13, quality: 1, dropCount: 40, drops: [{ npc: 3, chance: 30 }] };
	data.npcs = { 3: { id: 3, name: 'Defias Thug', level: 9, faction: null, spawns: { 1429: { f: 'e', pts: [[50, 40]] } } } };
	data.zones = { 1429: { name: 'Elwynn Forest', type: 3 } };
	data.mapFrames = { era: { 1429: { c: 0 } } };
	data.items = {};
	const { text } = draftGuide('Tailoring', { ...data, farmable: () => ({ Alliance: 9, Horde: 9 }) }, { to: 75, spec: {} });
	assert.match(text, /\n {2}tip \d+ Linen Cloth for [^\n]*: humanoids of level 5-20 drop it\. Keep what you loot as you level, or take it from your bank\.\n {2}collect 2589 x\d+ anywhere gather levels 5-20\n/);
	assert.match(text, /\n {2}auction 2589 x\d+\n/);
	assert.doesNotMatch(text, /collect 2589 x\d+ (nearest|@)/);
});

test('draft: mob drops the compiler can place become one `collect … nearest` step', async () => {
	const base = {
		professions: JSON.parse(fs.readFileSync(PROFESSIONS, 'utf8')),
		npcs: readJson('npcs'),
		objects: readJson('objects'),
		zones: readJson('zones'),
		items: readJson('items'),
		mapFrames: readJson('map-frames'),
	};
	const both = draftGuide('Tailoring', { ...base, farmable: () => ({ Alliance: 3, Horde: 5 }) }, { to: 75, spec: {} }).text;
	assert.match(both, /^step Linen Cloth\n {2}tip [^\n]+\n {2}collect 2589 x\d+ nearest gather levels 3-5$/m);
	assert.ok(!/^ {2}only (Alliance|Horde)$/m.test(both));
	assert.ok(!/@\d/.test(both));
	// A side without a farm spot, or whose lowest spot is 3+ levels above the
	// level the guide has asked for (5 here), keeps the per-faction farming steps.
	for (const farmable of [() => ({ Alliance: 3, Horde: null }), () => ({ Alliance: 3, Horde: 8 })]) {
		const one = draftGuide('Tailoring', { ...base, farmable }, { to: 75, spec: {} }).text;
		assert.doesNotMatch(one, /collect 2589 x\d+ nearest/);
		assert.match(one, /collect 2589 x\d+ @40,40 era/);
	}
	assert.match(draftGuide('Tailoring', { ...base, farmable: () => ({ Alliance: 7, Horde: 7 }) }, { to: 75, spec: {} }).text, /collect 2589 x\d+ nearest/);
});

test('draft: each bracket buys at the Auction House what it sells, after the vendor goods, and each gather collect says what gathering takes', () => {
	const { prof, data } = smallProfession([rec(1, 1, 70, 90, 2589, { reagents: [{ item: 2589, count: 1 }, { item: 10, count: 1 }, { item: 72, count: 1 }, { item: 4234, count: 1 }] })]);
	prof.materials[2589] = { name: 'Linen Cloth', buy: 55, buyCount: 1, sell: 13, quality: 1, dropCount: 40, drops: [{ npc: 3, chance: 30 }] };
	// A rare drop that binds when picked up: no farm spot, never an Auction House buy.
	prof.materials[72] = { name: 'Bound Gizmo', sell: 1, quality: 1, bop: true, dropCount: 1, drops: [{ npc: 999, chance: 1 }] };
	prof.materials[4234] = { name: 'Medium Leather', sell: 25, quality: 1 };
	const pts = (n, x) => Array.from({ length: n }, (_, i) => [x + (i % 5), 40 + Math.floor(i / 5)]);
	// The Barrens is in the curated beast lists; its level 20 beasts yield Medium Leather (band 18-30).
	data.npcs = { 5: { id: 5, name: 'Savannah Patriarch', level: 20, faction: null, spawns: { 1413: { f: 'e', pts: pts(20, 40) } } } };
	data.zones = { 1413: { name: 'The Barrens', type: 3 } };
	data.mapFrames = { era: { 1413: { c: 1 } } };
	data.items = {};
	const { text } = draftGuide('Tailoring', data, { to: 75, spec: {} });
	const lines = text.split('\n');
	const at = (re) => lines.findIndex((l) => re.test(l));
	const order = [at(/^step Tailoring 1-75: vendor goods$/), at(/^step Tailoring 1-75: Auction House$/), at(/^step Linen Cloth$/), at(/^step R1 to 75$/)];
	assert.ok(order[0] >= 0 && order.every((v, i) => i === 0 || v > order[i - 1]), `vendor goods, Auction House, cloth, crafts: ${order}`);
	// Every material it can sell, for the whole bracket; no vendor good, nothing that binds when picked up.
	const ah = text.split('\n\n').find((b) => b.startsWith('step Tailoring 1-75: Auction House'));
	assert.match(ah, /\n {2}tip What 1-75 takes that the Auction House sells: 75 Linen Cloth and 75 Medium Leather\. [^\n]+\n {2}auction 2589 x75\n {2}auction 4234 x75$/);
	// Cloth: its humanoids' levels; leather: the skill its beasts' lowest level asks (18: 80).
	assert.match(text, /\n {2}collect 2589 x75 anywhere gather levels 5-20\n/);
	const skins = text.match(/^ {2}collect 4234 .*$/gm) || [];
	assert.ok(skins.length > 0 && skins.every((l) => / gather Skinning 80$/.test(l)), skins.join('\n'));
	assert.doesNotMatch(text, /^ {2}(collect|auction) 72 /m);
});

test('skinned materials go to beasts of their level band, or to the mobs the data says yield them', () => {
	const pts = (n, x) => Array.from({ length: n }, (_, i) => [x + (i % 5), 40 + Math.floor(i / 5)]);
	const npc = (id, name, level, map, n, x) => ({ id, name, level, faction: null, spawns: { [map]: { f: 'e', pts: pts(n, x) } } });
	const data = {
		// The Barrens (1413) and Elwynn Forest (1429) are in the curated beast lists.
		npcs: {
			1: npc(1, 'Savannah Huntress', 12, 1413, 10, 40),
			2: npc(2, 'Savannah Patriarch', 15, 1413, 5, 60),
			3: npc(3, 'Young Wolf', 1, 1429, 30, 40),
			4: npc(4, 'Prowler', 9, 1429, 12, 60),
		},
		zones: { 1413: { name: 'The Barrens', type: 3 }, 1429: { name: 'Elwynn Forest', type: 3 } },
		mapFrames: { era: { 1413: { c: 1 }, 1429: { c: 0 } } },
		items: {},
	};
	const light = skinSpot('Light Leather', 'Horde', 1, data);
	assert.equal(light.map, 1413);
	assert.deepEqual(light.beasts, ['Savannah Huntress', 'Savannah Patriarch']);
	assert.deepEqual([light.min, light.max], [5, 20]);
	// Level 1 wolves are below the Light Leather band; Elwynn still has Prowlers.
	assert.deepEqual(skinSpot('Light Leather', 'Alliance', 0, data).beasts, ['Prowler']);
	assert.equal(skinSpot('Rugged Leather', 'Alliance', 0, data), null);
	assert.equal(skinSpot('Enchanted Leather', 'Alliance', 0, data), null);
});

test('farm spots need real sources (2% or more), including clickable clams; rare drops from common mobs are no spot', () => {
	const pts = (n, x) => Array.from({ length: n }, (_, i) => [x + (i % 5), 40 + Math.floor(i / 5)]);
	const data = {
		items: { 5500: { id: 5500, name: 'Iridescent Pearl', drops: { npc: { 1: 0.3 }, object: { 7: 4, 8: 0.5 } }, vendors: [] } },
		// A murloc everywhere at 0.3% would win on spawns alone.
		npcs: { 1: { id: 1, name: 'Bluegill Murloc', level: 20, faction: null, spawns: { 1437: { f: 'e', pts: pts(30, 10) } } } },
		objects: {
			7: { id: 7, name: 'Giant Clam', spawns: { 1437: { f: 'e', pts: pts(5, 60) } } },
			8: { id: 8, name: 'Solid Chest', roles: ['chest'], spawns: { 1437: { f: 'e', pts: pts(30, 30) } } },
		},
		zones: { 1437: { name: 'Wetlands', type: 3 } },
		mapFrames: { era: { 1437: { c: 0 } } },
	};
	const spot = farmSpot(5500, 'drop', 'Alliance', 0, data);
	assert.equal(spot.label, 'Giant Clam');
	assert.equal(spot.object, true);
	assert.equal(spot.frame, 'era');
	// Without any real source there is no spot: 0.3% is three hundred kills a pearl.
	delete data.objects[7];
	delete data.items[5500].drops.object[7];
	assert.equal(farmSpot(5500, 'drop', 'Alliance', 0, data), null);
	// A real dropper above `maxLevel` is no spot either; `maps` keeps only those maps.
	data.items[5500].drops.npc[1] = 5;
	assert.equal(farmSpot(5500, 'drop', 'Alliance', 0, data).label, 'Bluegill Murloc');
	assert.equal(farmSpot(5500, 'drop', 'Alliance', 0, data, 0, { maxLevel: 19 }), null);
	assert.equal(farmSpot(5500, 'drop', 'Alliance', 0, data, 0, { maps: new Set([1429]) }), null);
	// Points in Forever's live frame (Zephras Isle, Mulgore) say so.
	data.npcs[1].spawns[1437].f = 'l';
	assert.equal(farmSpot(5500, 'drop', 'Alliance', 0, data).frame, 'live');
});

test('draft: starting-area herbs per race to Journeyman, rare node finds are a bag count, rare drops get no spot, tool materials name the tool', () => {
	const pts = (n, x, y = 40) => Array.from({ length: n }, (_, i) => [x + (i % 5), y + Math.floor(i / 5)]);
	const herb = (id, name, spawns) => ({ id, name, roles: ['herb'], spawns });
	const mine = (id, name, spawns) => ({ id, name, roles: ['mine'], spawns });
	const data = {
		professions: {
			171: {
				id: 171,
				name: 'Alchemy',
				ranks: [{ name: 'Apprentice', max: 75, minLevel: 5, minSkill: 0, trainers: { Alliance: [], Horde: [] }, cost: 10 }],
				trainers: {},
				mainTrainer: {},
				recipes: [
					{ spell: 1, name: 'Weed Tonic', item: 101, reagents: [{ item: 765, count: 1 }, { item: 7971, count: 1 }], source: 'trainer', learnedAt: 1, cost: 0, yellow: 60, green: 70, grey: 80, tools: [102] },
					{ spell: 2, name: 'Tonic Rod', item: 102, reagents: [{ item: 1210, count: 1 }], source: 'trainer', learnedAt: 1, cost: 0, yellow: 5, green: 7, grey: 10 },
				],
				materials: {
					765: { name: 'Silverleaf', sell: 5, quality: 1, gather: { herb: [10] } },
					7971: { name: 'Black Pearl', sell: 10, quality: 1, drops: [{ npc: 5, chance: 0.2 }], dropCount: 2 },
					1210: { name: 'Shadowgem', sell: 10, quality: 1, gather: { mine: [11] } },
					101: { name: 'Weed Tonic' },
					102: { name: 'Tonic Rod' },
				},
			},
		},
		items: {
			765: { id: 765, drops: { object: { 10: 100 } } },
			7971: { id: 7971, drops: { npc: { 5: 0.2 } } },
			1210: { id: 1210, drops: { object: { 11: 1 } } },
		},
		npcs: { 5: { id: 5, name: 'Silt Crawler', level: 40, faction: null, spawns: { 1435: { f: 'e', pts: pts(20, 50) } } } },
		objects: {
			// Silverleaf: Teldrassil (Night Elves), Elwynn (Humans), Zephras Isle (live frame),
			// a few in Durotar; Westfall for everyone else on the Alliance side.
			10: herb(10, 'Silverleaf', { 1438: { f: 'e', pts: pts(10, 20) }, 1429: { f: 'e', pts: pts(10, 30) }, 2521: { f: 'l', pts: pts(10, 40) }, 1436: { f: 'e', pts: pts(30, 50) }, 1411: { f: 'e', pts: pts(3, 60) }, 1413: { f: 'e', pts: pts(30, 70) } }),
			11: mine(11, 'Copper Vein', { 1436: { f: 'e', pts: pts(30, 20) } }),
		},
		zones: {
			1411: { name: 'Durotar', type: 3 },
			1413: { name: 'The Barrens', type: 3 },
			1429: { name: 'Elwynn Forest', type: 3 },
			1435: { name: 'Swamp of Sorrows', type: 3 },
			1436: { name: 'Westfall', type: 3 },
			1438: { name: 'Teldrassil', type: 3 },
			2521: { name: 'Zephras Isle', type: 3 },
		},
		mapFrames: { era: { 1411: { c: 1 }, 1413: { c: 1 }, 1429: { c: 0 }, 1435: { c: 0 }, 1436: { c: 0 }, 1438: { c: 1 } } },
		nodeAbundance: {}, // no spawn-pool tables: the points decide
	};
	const { text } = draftGuide('Alchemy', data, { to: 75, spec: {} });
	assert.match(text, /^step Silverleaf \(Teldrassil\)\n {2}only NightElf\n/m);
	assert.match(text, /^step Silverleaf \(Elwynn Forest\)\n {2}only Human\n/m);
	// Zephras Isle is one step for the Skyborne of both sides, in the live frame.
	assert.match(text, /^step Silverleaf \(Zephras Isle\)\n {2}only Skyborne\n(?: {2}[^\n]+\n)* {2}collect 765 x\d+ @[\d.]+,[\d.]+ live gather Herbalism 1$/m);
	// Three Silverleaf in Durotar are no patch: Orcs and Trolls go on to The Barrens.
	assert.match(text, /^step Silverleaf \(The Barrens\)\n {2}only Orc,Troll/m);
	assert.doesNotMatch(text, /Silverleaf \(Durotar\)/);
	// The starting-area step names no other zones.
	assert.match(text, /Herbalism: Silverleaf \(skill 1\)\. The densest patch of Silverleaf in Teldrassil is marked\./);
	// Black Pearl (0.2%) gets no spot and is bought; Shadowgem (one vein in a hundred) is kept
	// while mining or bought, and the rod's gem is "for Tonic Rod".
	assert.doesNotMatch(text, /^ {2}collect 7971 /m);
	assert.match(text, /\nstep Shadowgem\n(?: {2}zone Azeroth\n)? {2}tip 1 Shadowgem for Tonic Rod: Shadowgem turns up in about one Copper Vein in 100: keep the ones you find while mining\.\n {2}collect 1210 x1 anywhere gather Mining 1\n/);
	assert.match(text, /\n {2}auction 765 x\d+\n {2}auction 1210 x1\n {2}auction 7971 x\d+\n/);
	assert.match(text, /Black Pearl is a rare drop \(no mob gives it one time in 50\)/);
	assert.match(text, /Make the Tonic Rod first: the recipe needs it in your bags/);
});

// With the real data: every `craft <recipe> until <skill>` in the generated
// profession guides stops at or before the recipe's grey threshold. Issue #109:
// guides drafted from Classic Era thresholds sent players on past where
// Forever's recipes turn grey (Red Linen Shirt "until 82" on a recipe grey at 85
// but green from 67; Tailoring, Leatherworking and Blacksmithing steps that
// cannot be finished).
test('no profession guide crafts a recipe past its grey threshold (issue #109)', { skip: needs('professions.json', 'quests.json', 'npcs.json', 'objects.json', 'items.json', 'map-frames.json') }, () => {
	const { compileSources, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
	const { loadData } = require('../tools/lib/dsl/data');
	const dir = path.join(OFFICIAL_DIR, 'forever', 'professions');
	const sources = fs
		.readdirSync(dir)
		.filter((f) => f.endsWith('.guide'))
		.sort()
		.map((f) => ({ file: path.join(dir, f), text: fs.readFileSync(path.join(dir, f), 'utf8') }));
	const { diag } = compileSources(sources, loadData(REAL_DATA));
	const grey = diag.warnings.filter((d) => /turns grey at/.test(d.message)).map((d) => `${path.basename(d.file)}:${d.line} ${d.message}`);
	assert.deepEqual(grey, []);
});
