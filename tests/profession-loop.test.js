'use strict';
// The farming-loop builder (tools/lib/professions/gathering/loop.js), the fishing waters table
// (waters.js) and the Fishing + Cooking rounds and pairing (fish-rounds.js), on synthetic data: no reference data.

const { test } = require('node:test');
const assert = require('node:assert/strict');

const { buildLoop, hazards, pointLevels, levelFor, threats } = require('../tools/lib/professions/gathering/loop');
const Wt = require('../tools/lib/professions/gathering/waters');
const { chance, cookingPlan, asLoop, loopOnly, sideOf } = require('../tools/lib/professions/gathering/fish-rounds');
const { makeProjector, dist } = require('../tools/lib/route/geo');
const { pathLength } = require('../tools/lib/route/tour');

// Map 1: 1000 x 1000 yards, so a map percent is 10 yards.
const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
const at = (x, y, w = 1) => ({ name: 'stand', pt: project.point(1, x, y, 'e'), w });

test('buildLoop: a closed tour of the heaviest ground, from the stop nearest the entry', () => {
	const points = [at(10, 10, 5), at(12, 30, 4), at(30, 12, 3), at(30, 30, 2), at(90, 90, 9)];
	const { stops, lap } = buildLoop(points, project, { radius: 5, span: 400, cover: 1, maxStops: 6, entry: project.point(1, 32, 32, 'e') });
	// The heaviest stand (90,90) is a ground of its own: a loop never tours the zone.
	assert.equal(stops.length, 1);
	assert.deepEqual([stops[0].pt.x, stops[0].pt.y], [90, 90]);
	assert.equal(lap, 0);
	const near = buildLoop(points.slice(0, 4), project, { radius: 5, span: 400, cover: 1, maxStops: 6, entry: project.point(1, 32, 32, 'e') });
	assert.equal(near.stops.length, 4);
	assert.deepEqual([near.stops[0].pt.x, near.stops[0].pt.y], [30, 30], 'starts nearest the entry');
	// A closed tour round the square, never across it.
	const square = pathLength(near.stops[0].pt, near.stops.slice(1), near.stops[0].pt);
	assert.ok(Math.abs(near.lap - square) < 1e-6);
	assert.ok(near.lap < 800, `lap ${near.lap}`);
	for (let i = 0; i < near.stops.length; i++) {
		const a = near.stops[i].pt;
		const b = near.stops[(i + 1) % near.stops.length].pt;
		assert.ok(dist(a, b) < 250, 'no diagonal leg');
	}
});

test('buildLoop: avoided ground, cover and maxStops', () => {
	const points = [at(10, 10, 10), at(15, 10, 1), at(20, 10, 1), at(25, 10, 1), at(30, 10, 1)];
	const avoid = [{ pt: project.point(1, 15, 10, 'e'), yards: 20 }];
	const { stops } = buildLoop(points, project, { radius: 5, avoid, cover: 1 });
	assert.ok(!stops.some((s) => s.pt.x === 15), 'the avoided stand is left out');
	assert.equal(stops.length, 4);
	assert.equal(buildLoop(points, project, { radius: 5, cover: 1, maxStops: 2 }).stops.length, 2);
	// Cover: the heaviest holds most of the weight, so two stops (the least a loop has) do.
	assert.equal(buildLoop(points, project, { radius: 5, cover: 0.5 }).stops.length, 2);
	assert.deepEqual(buildLoop([], project).stops, []);
});

// A data object for hazards: NPCs with spawns on map 1, and the items that say who drops something.
function ctxWith(npcs, droppers) {
	const items = { 1: { id: 1, drops: { npc: Object.fromEntries(droppers.map((id) => [id, 10])) } } };
	return { data: { npcs: Object.fromEntries(npcs.map((n) => [n.id, n])), items }, project };
}
const npc = (id, level, faction, x, y, extra = {}) => ({ id, name: `npc ${id}`, level, faction, spawns: { 1: { pts: [[x, y]] } }, ...extra });

test('hazards and levels: hostile creatures above the level, the other side\'s towns', () => {
	const ctx = ctxWith(
		[
			npc(10, 30, null, 52, 50), // a level-30 creature 20 yd from the stand at 50,50
			npc(11, 55, null, 50, 52), // a friendly messenger: drops nothing
			npc(12, 44, null, 51, 50, { rank: 4 }), // a rare
			npc(13, 1, null, 50, 51, { levelMax: 30 }), // scales to the player: its lowest level counts
			npc(20, 60, 'H', 50, 60), // one festival keeper of the other side, 100 yd off: no town
			npc(30, 55, 'H', 10, 10),
			npc(31, 55, 'H', 11, 10),
			npc(32, 30, 'H', 10, 11), // a Horde town at 10,10
		],
		[10, 12, 13],
	);
	const stand = at(50, 50);
	const town = at(12, 12);
	assert.deepEqual(pointLevels(ctx, 1, [stand, town], 'Alliance'), [29, null]);
	assert.deepEqual(pointLevels(ctx, 1, [stand, town], 'Horde'), [29, 1], 'their own town is no hazard');
	assert.equal(levelFor(ctx, 1, [stand, town], { faction: 'Alliance' }), 29);
	assert.equal(levelFor(ctx, 1, [stand, town], { faction: 'Alliance', need: 2 }), null);
	assert.equal(levelFor(ctx, 1, [stand], { faction: 'Alliance', min: 35 }), 35);
	const h = hazards(ctx, 1, { level: 20, faction: 'Alliance' });
	assert.equal(h.filter((a) => a.yards === 30).length, 1, 'the level-30 creature only');
	assert.equal(h.filter((a) => a.yards === 150).length, 3, 'the town\'s three NPCs, not the lone keeper');
	assert.equal(hazards(ctx, 1, { level: 29, faction: 'Alliance' }).filter((a) => a.yards === 30).length, 0);
});

test('hazards (strict, the fishing rounds): an elite by a stand makes it unsafe at any level; a guard of the other side is a hazard on its own, a lone keeper is none', () => {
	const ctx = ctxWith(
		[
			npc(40, 20, null, 52, 50, { rank: 1 }), // a level-20 elite 20 yd from the stand at 50,50
			npc(41, 20, null, 80, 50), // a level-20 creature
			{ id: 50, name: 'Orgrimmar Grunt', level: 55, faction: 'H', spawns: { 1: { pts: [[20, 80], [21, 80], [20, 81]] } } }, // a guard post of three
			npc(51, 60, 'H', 80, 80), // one keeper of the other side
		],
		[40, 41],
	);
	const [elite, plain, post, keeper] = [at(50, 50), at(78, 50), at(22, 82), at(80, 82)];
	assert.deepEqual(pointLevels(ctx, 1, [elite, plain, post, keeper], 'Alliance', { strict: true }), [null, 19, null, 1], 'the elite within 30 yards: never safe; the creature asks 19; the guards are never safe, the keeper is no town');
	assert.deepEqual(pointLevels(ctx, 1, [elite, post], 'Alliance'), [null, 1], 'not strict (the herb, ore and skinning loops): the elite the same, the post no town');
	assert.deepEqual(pointLevels(ctx, 1, [post], 'Horde', { strict: true }), [1], 'their own guards are no hazard');
	const h = hazards(ctx, 1, { level: 21, faction: 'Alliance', strict: true });
	assert.equal(h.filter((a) => a.yards === 30).length, 1, 'the elite (at any level), not the plain creature, at level 21');
	assert.equal(h.filter((a) => a.yards === 150).length, 3, 'the three guards');
	// Threats: creatures at a stop not grey to the player (six levels or more below).
	assert.equal(threats(ctx, 1, [elite, plain], 20), 2);
	assert.equal(threats(ctx, 1, [elite, plain], 26), 1, 'the creature is grey at 26, the elite (23) is not');
	assert.equal(threats(ctx, 1, [keeper], 20), 0);
});

test('fish rounds: a lap counts a fight for each threat by a stop and the deaths recorded at its stands', () => {
	const ctx = ctxWith([npc(40, 20, null, 50, 52)], [40]);
	const band = { from: 75, to: 150 };
	const stop = (x, y, stand) => ({ pt: project.point(1, x, y, 'e'), stand, pool: null });
	const round = (stops) => ({ map: 1, level: 20, stops, fish: {}, full: null });
	const quiet = asLoop(ctx, band, 'Alliance', round([stop(10, 10, { catches: 100 }), stop(10, 20, { catches: 100 })]));
	const busy = asLoop(ctx, band, 'Alliance', round([stop(50, 50, { catches: 100, deaths: 4 }), stop(50, 60, { catches: 100 })]));
	assert.equal(quiet.fights, 0);
	assert.equal(busy.fights, 1);
	assert.equal(busy.deaths, 0.2, 'four deaths in 100 catches, five casts a stop');
	// Same walk and casts: the busy round's lap is a fight (20 s) and its deaths (180 s each) longer.
	assert.equal(busy.seconds - quiet.seconds, 20 + 36);
});

test('waters: a loot group\'s rows without a chance share what the others leave', () => {
	const rows = [
		{ item: 1, chance: 40, g: 1 },
		{ item: 2, chance: 0, g: 1 },
		{ item: 3, chance: 0, g: 1 },
		{ item: 4, chance: 5, g: 0 },
	];
	const out = Object.fromEntries(Wt.share(rows).map((x) => [x.item, x.p]));
	assert.deepEqual(out, { 1: 40, 2: 30, 3: 30, 4: 5 });
});

test('waters: zone loot and the no-loss skill from the world database', () => {
	const { DatabaseSync } = require('node:sqlite');
	const fs = require('node:fs');
	const os = require('node:os');
	const path = require('node:path');
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'waters-'));
	const file = path.join(dir, 'world.sqlite');
	const db = new DatabaseSync(file);
	db.exec(`CREATE TABLE fishing_loot_template (Entry INTEGER, ItemType INTEGER, Item INTEGER, Chance REAL, QuestRequired INTEGER, GroupId INTEGER);
		CREATE TABLE reference_loot_template (Entry INTEGER, ItemType INTEGER, Item INTEGER, Chance REAL, GroupId INTEGER);
		CREATE TABLE skill_fishing_base_level (entry INTEGER, skill INTEGER);
		INSERT INTO fishing_loot_template VALUES (12, 0, 6289, 38, 0, 1), (12, 0, 6291, 0, 0, 1), (12, 0, 999, 100, 1, 0), (12, 1, 500, 10, 0, 0);
		INSERT INTO reference_loot_template VALUES (500, 0, 7, 50, 1), (500, 0, 8, 0, 1);
		INSERT INTO skill_fishing_base_level VALUES (12, -70);`);
	db.close();
	try {
		const z = Wt.zoneWaters(file, { 1429: { id: 1429, areaId: 12 }, 1: { id: 1, areaId: 99 } });
		assert.deepEqual(Object.keys(z), ['1429']);
		assert.equal(z[1429].full, 25);
		assert.deepEqual(z[1429].loot, { 6291: 62, 6289: 38, 7: 5, 8: 5 }, 'the quest-only row is left out, a reference row splits by its own table');
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('waters: stands are the densest catch positions three or more people fished at, with the deaths recorded by them', () => {
	const catches = [];
	const add = (person, x, y, item, n = 1) => {
		for (let i = 0; i < n; i++) catches.push({ map: 1, x, y, person, items: [[item, 1]] });
	};
	// Three people at 50,50 (within 20 yd), two at 80,80.
	add('a', 50, 50, 6291, 5);
	add('b', 50.5, 50, 6291, 2);
	add('c', 51, 51, 6289, 1);
	add('a', 80, 80, 6291, 9);
	add('b', 80, 80, 6291, 9);
	// Two deaths within 30 yd of the stand, one 100 yd off.
	const deaths = [
		{ map: 1, x: 52, y: 50 },
		{ map: 1, x: 50, y: 52.5 },
		{ map: 1, x: 60, y: 50 },
	];
	const lp = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } }, forever: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	const st = Wt.stands(catches, lp, deaths);
	assert.equal(st[1].length, 1);
	assert.deepEqual({ x: st[1][0].x, y: st[1][0].y, people: st[1][0].people, catches: st[1][0].catches, fish: st[1][0].fish, deaths: st[1][0].deaths }, { x: 50, y: 50, people: 3, catches: 8, fish: { 6289: 1, 6291: 7 }, deaths: 2 });
	assert.equal(Wt.stands(catches, lp)[1][0].deaths, undefined, 'no deaths: no field');
});

test('waters: one person behind several contributors, installs and characters', () => {
	const P = Wt.peopleOf(['20261101T000000Z-aaaa-inst1-charA.json', '20261102T000000Z-bbbb-inst1-charB.json', '20261103T000000Z-cccc-inst2-charB.json', '20261104T000000Z-dddd-inst3-charC.json']);
	const first = P.person('20261101T000000Z-aaaa-inst1-charA.json');
	assert.equal(P.person('20261102T000000Z-bbbb-inst1-charB.json'), first, 'same install');
	assert.equal(P.person('20261103T000000Z-cccc-inst2-charB.json'), first, 'same character');
	assert.notEqual(P.person('20261104T000000Z-dddd-inst3-charC.json'), first);
});

// Cooking recipes as fish-rounds.js reads them (professions.json, with fish/extra split).
const rec = (spell, name, item, learnedAt, yellow, green, grey) => ({ spell, name, learnedAt, yellow, green, grey, fish: [{ item, count: 1 }], extra: [] });
const SMALLFISH = rec(1, 'Smallfish', 6291, 1, 45, 65, 85);
const LONGJAW = rec(2, 'Longjaw', 6289, 50, 90, 110, 130);
const CATFISH = rec(3, 'Catfish', 6308, 100, 140, 160, 180);
const COD = rec(4, 'Cod', 6362, 175, 190, 210, 230);
const TROUT = rec(5, 'Trout', 8365, 175, 215, 235, 255);

test('pairing: the skill-up chance is the Classic one', () => {
	assert.equal(chance(LONGJAW, 60), 1);
	assert.equal(chance(LONGJAW, 110), 0.5);
	assert.equal(chance(LONGJAW, 130), 0);
});

test('pairing: each point cooks the best recipe of a fish the round gives, the orange one longest', () => {
	const bites = (item) => [6289, 6308].includes(item);
	const { segs, used } = cookingPlan([SMALLFISH, LONGJAW, CATFISH], 50, 140, bites, {});
	assert.deepEqual(segs.map((s) => [s.recipe.name, s.from, s.to]), [['Longjaw', 50, 100], ['Catfish', 100, 140]]);
	assert.equal(segs[0].crafts, 52, '40 orange, then ten yellow at (130 - s) / 40');
	assert.equal(Math.ceil(used[6308]), 40);
	// Cod and Trout both orange at 175: Trout stays orange to 215, so one recipe does it all.
	const both = cookingPlan([COD, TROUT], 175, 225, () => true, {});
	assert.deepEqual(both.segs.map((s) => s.recipe.name), ['Trout']);
});

test('pairing: fish kept from an earlier band count, and a gap no fish covers is an error', () => {
	const none = () => false;
	const { segs } = cookingPlan([SMALLFISH, LONGJAW], 50, 60, none, { 6289: 10 });
	assert.deepEqual(segs.map((s) => [s.recipe.name, s.from, s.to, s.crafts]), [['Longjaw', 50, 60, 10]]);
	assert.throws(() => cookingPlan([SMALLFISH, LONGJAW], 50, 70, none, { 6289: 10 }), /no fish recipe carries Cooking 60/);
});

test('farming loops: who may take a water, and which side it is on', () => {
	// Zephras Isle is the Skyborne start on both sides: only they reach its water.
	assert.equal(loopOnly(2521, 'Alliance'), 'Skyborne,Alliance');
	assert.equal(loopOnly(2521, 'Horde'), 'Skyborne,Horde');
	assert.equal(loopOnly(1429, 'Alliance'), 'Alliance');
	assert.equal(loopOnly(1446, 'Horde'), 'Horde');
	// The capitals are their faction's; contested zones both sides'.
	assert.deepEqual([sideOf(1453), sideOf(1458), sideOf(1446), sideOf(1420), sideOf(1459)], ['A', 'H', 'AH', 'H', '']);
});
