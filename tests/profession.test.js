'use strict';
// `profession build` / `profession draft`: client-table parsing (fixture CSVs
// under tests/fixtures/professions/wago: a Forever build, 1.60.1.1, and the
// Classic Era build, 1.15.9.1, that fills its gaps), skill thresholds, the
// recipe planner's choices on small professions, and deterministic output.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const { loadTables } = require('../tools/lib/professions/tables');
const { extractProfessions } = require('../tools/lib/professions/extract');
const { buildProfessions, parseVendorStock } = require('../tools/lib/professions/build');
const { resolveTrainers } = require('../tools/lib/professions/trainers');
const { planProfession, chance, expectedCrafts, SWITCH_BASE, SWITCH_CRAFTS } = require('../tools/lib/professions/plan');
const { draftGuide, farmSpot, skinSpot } = require('../tools/lib/professions/guide');
const { sourceOf, gatherCost, homeMap, zoneOf } = require('../tools/lib/professions/materials');
const { tmpdir } = require('./helpers/tmp');
const { DATA: REAL_DATA, needs } = require('./helpers/data');

const FX = path.join(__dirname, 'fixtures', 'professions');
const DATA = path.join(FX, 'data');
const readJson = (name) => JSON.parse(fs.readFileSync(path.join(DATA, `${name}.json`), 'utf8'));

async function fixtureBuild(outFile) {
	return buildProfessions({ offline: true, sourcesDir: FX, dataDir: DATA, outFile });
}

function tmpFile(name) {
	return path.join(tmpdir('polestar-prof-'), name);
}

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

async function fixtureTables() {
	const { tables, eraTables } = await loadTables({ sourcesDir: FX, offline: true, product: 'forever', eraFill: true });
	const season = new Set(eraTables.SkillLineAbility.map((r) => Number(r.Spell)).filter((s) => s >= 400000));
	return extractProfessions(tables, {
		items: readJson('items'),
		npcs: readJson('npcs'),
		objects: readJson('objects'),
		season,
		trainers: (id, kind) => resolveTrainers(id, readJson('npcs'), { kind }),
	});
}

test('recipes: created items, reagents, thresholds and learn sources from the client tables', async () => {
	const { professions, report } = await fixtureTables();
	const tailoring = professions[197];
	assert.equal(tailoring.name, 'Tailoring');
	assert.equal(tailoring.kind, 'primary');
	const by = Object.fromEntries(tailoring.recipes.map((r) => [r.spell, r]));
	// Known with the skill: learned at 1, free; green is floor((yellow + grey) / 2).
	assert.deepEqual(
		{ ...by[2963] },
		{ spell: 2963, name: 'Bolt of Linen Cloth', item: 2996, itemCount: 1, reagents: [{ item: 2589, count: 2 }], source: 'trainer', learnedAt: 1, cost: 0, yellow: 25, grey: 50, green: 37 },
	);
	// A trainer recipe: the learn skill is not in the client, so it is estimated
	// at yellow (trainers teach many recipes only there; never later).
	assert.equal(by[2387].learnedAt, 35);
	assert.equal(by[2387].learnedAtEstimated, true);
	// A recipe item: its RequiredSkillRank, its vendor, its price.
	assert.equal(by[2389].source, 'vendor');
	assert.equal(by[2389].recipeItem, 2598);
	assert.equal(by[2389].learnedAt, 40);
	assert.equal(by[2389].cost, 200);
	assert.equal(by[2389].learnedAtEstimated, undefined);
	// Forever's thresholds, not Classic Era's (issue #109: Red Linen Shirt is
	// 50/67/85 on Forever, 65/82/100 in the Era client).
	assert.deepEqual([by[2392].yellow, by[2392].green, by[2392].grey], [50, 67, 85]);
	// Season of Discovery spells (in the Era client too) are left out, and so are
	// the ones Forever retired (AcquireMethod 3); rank spells and non-recipes are
	// not recipes. Forever's own spells, past 1,000,000, stay.
	assert.equal(by[439085], undefined);
	assert.equal(by[2386], undefined);
	assert.equal(by[3908], undefined);
	assert.deepEqual(report[197].skipped, { season: 1, retired: 1 });
	// Forever's columns: EffectBasePointsF (2 made), a signed race mask read
	// unsigned, a tool category (162) resolved to its plain tool.
	assert.equal(by[1257000].itemCount, 2);
	assert.equal(by[1257000].races, 2973060173);
	assert.deepEqual(by[1257000].tools, [5956]);
	// Rank spells: tier index from the skill effect.
	assert.equal(tailoring.ranks[0].spell, 3908);
	assert.equal(tailoring.ranks[1].spell, 3909);
	assert.deepEqual(tailoring.ranks.map((r) => r.max), [75, 150, 225, 300]);
	// Materials: unit price and vendors per side (a limited-stock vendor is kept apart).
	assert.deepEqual(tailoring.materials[2320].vendors, { Alliance: [1347, 5000], Horde: [3364] });
	assert.equal(tailoring.materials[2996].madeBy[0].spell, 2963);
	// ItemSparse Bonding 1 (binds when picked up), as Forever made many vendor recipes (#315).
	assert.equal(tailoring.materials[2598].bop, true);
	assert.equal(tailoring.materials[2320].bop, undefined);
	// Spells and items the Forever tables lack come from Era: Minor Healing
	// Potion's name and reagents, Empty Vial's prices.
	assert.equal(professions[171].recipes[0].name, 'Minor Healing Potion');
	assert.deepEqual(professions[171].recipes[0].reagents.map((g) => g.item), [2447, 765, 3371]);
	assert.deepEqual(professions[171].materials[3371], { name: 'Empty Vial', buy: 20, buyCount: 5, sell: 1, quality: 1, vendors: { Alliance: [1347], Horde: [3364] } });
});

test('vendor stock limits come from pfQuest items.lua; zero means unlimited', () => {
	const stock = parseVendorStock(fs.readFileSync(path.join(FX, 'pfQuest', 'db', 'items.lua'), 'utf8'));
	assert.deepEqual([...stock.get(2320).entries()], [[1347, 0], [3364, 0], [5000, 3]]);
	assert.deepEqual([...stock.get(2598).entries()], [[6000, 1]]);
});

test('trainers: curated names resolve per side; missing ones warn instead of guessing', () => {
	const res = resolveTrainers(197, readJson('npcs'), { kind: 'primary' });
	assert.deepEqual(res.trainers, { Alliance: [1346], Horde: [3363] });
	assert.deepEqual(res.main, { Alliance: 1346, Horde: 3363 });
	assert.deepEqual(res.ranks[3].trainers, { Alliance: [], Horde: [] });
	assert.ok(res.warnings.some((w) => /Timothy Worthington": not in npcs\.json/.test(w)));
	const cooking = resolveTrainers(185, {}, { kind: 'secondary' });
	assert.equal(cooking.ranks[3].minSkill, 225);
});

test('build writes the same professions.json twice and reads limited stock', async () => {
	const a = tmpFile('a.json');
	const b = tmpFile('b.json');
	const ra = await fixtureBuild(a);
	await fixtureBuild(b);
	assert.equal(fs.readFileSync(a, 'utf8'), fs.readFileSync(b, 'utf8'));
	const json = JSON.parse(fs.readFileSync(a, 'utf8'));
	assert.deepEqual(Object.keys(json), ['171', '197']);
	assert.deepEqual(json[197].materials[2320].vendors, { Alliance: [1347], Horde: [3364] });
	assert.deepEqual(json[197].materials[2320].limitedVendors, { Alliance: [5000], Horde: [] });
	assert.equal(ra.report[197].recipes, 6);
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
	const { text } = draftGuide('Tailoring', data, { to: 75 });
	assert.match(text, /^# {4}60-75 not routed: /m);
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
	const tip = (text) => text.split('\n').find((l) => l.startsWith('  tip Teaches R2'));
	assert.equal(tip(draftGuide('Tailoring', data, { to: 75 }).text), '  tip Teaches R2 (needs Tailoring 40). Vendors sell it in limited stock that restocks.');
	delete prof.materials[50].bop;
	assert.equal(tip(draftGuide('Tailoring', data, { to: 75 }).text), '  tip Teaches R2 (needs Tailoring 40). Vendors sell it in limited stock that restocks; the Auction House often has it too.');
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
	const file = tmpFile('professions.json');
	await fixtureBuild(file);
	const data = {
		professions: JSON.parse(fs.readFileSync(file, 'utf8')),
		npcs: readJson('npcs'),
		objects: readJson('objects'),
		zones: readJson('zones'),
		items: readJson('items'),
		mapFrames: readJson('map-frames'),
	};
	const a = draftGuide('tailoring', data, { to: 75 });
	const b = draftGuide('Tailoring', data, { to: 75 });
	assert.equal(a.text, b.text);
	const lines = a.text.split('\n');
	const has = (re) => assert.ok(lines.some((l) => re.test(l)), `missing ${re}`);
	has(/^guide forever\/professions\/tailoring$/);
	has(/^category Professions$/);
	has(/^zone Azeroth$/);
	has(/^step Apprentice Tailoring$/);
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
	has(/^ {2}collect 2589 x\d+ @50,40 era$/);
	has(/^ {2}collect 2589 x\d+ @40,40 era$/);
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
	// Without the town (innkeeper and vendors) the bruiser is just a hostile mob and wins.
	const noInn = { ...data, npcs: { ...data.npcs } };
	for (const id of [1003, 5000, 6000]) delete noInn.npcs[id];
	assert.equal(farmSpot(2589, 'cloth', 'Alliance', 0, noInn).label, 'Town Bruiser');
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
	};
	assert.equal(farmSpot(2452, 'herb', 'Horde', 1, data).map, 1413);
	assert.equal(farmSpot(2452, 'herb', 'Alliance', 1, data).map, 1439);
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

test('draft: mob drops the compiler can place become one `collect … nearest` step', async () => {
	const file = tmpFile('professions.json');
	await fixtureBuild(file);
	const base = {
		professions: JSON.parse(fs.readFileSync(file, 'utf8')),
		npcs: readJson('npcs'),
		objects: readJson('objects'),
		zones: readJson('zones'),
		items: readJson('items'),
		mapFrames: readJson('map-frames'),
	};
	const both = draftGuide('Tailoring', { ...base, farmable: () => ({ Alliance: 3, Horde: 5 }) }, { to: 75 }).text;
	assert.match(both, /^step Linen Cloth\n {2}tip [^\n]+\n {2}collect 2589 x\d+ nearest$/m);
	assert.ok(!/^ {2}only (Alliance|Horde)$/m.test(both));
	assert.ok(!/@\d/.test(both));
	// A side without a farm spot, or whose lowest spot is 3+ levels above the
	// level the guide has asked for (5 here), keeps the per-faction farming steps.
	for (const farmable of [() => ({ Alliance: 3, Horde: null }), () => ({ Alliance: 3, Horde: 8 })]) {
		const one = draftGuide('Tailoring', { ...base, farmable }, { to: 75 }).text;
		assert.doesNotMatch(one, /collect 2589 x\d+ nearest/);
		assert.match(one, /collect 2589 x\d+ @40,40 era/);
	}
	assert.match(draftGuide('Tailoring', { ...base, farmable: () => ({ Alliance: 7, Horde: 7 }) }, { to: 75 }).text, /collect 2589 x\d+ nearest/);
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

test('farm spots prefer real sources (2% or more), including clickable clams, over rare drops from common mobs', () => {
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
	// Without any real source, the rare drop is still better than nothing.
	delete data.objects[7];
	delete data.items[5500].drops.object[7];
	assert.equal(farmSpot(5500, 'drop', 'Alliance', 0, data).label, 'Bluegill Murloc');
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
