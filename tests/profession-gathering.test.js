'use strict';
// The generator behind guides/forever/professions/{mining,herbalism,skinning,
// fishing,cooking,first-aid}.guide (tools/lib/professions/gathering): the
// skill-up tables, the craft-count model and the route clustering on synthetic
// data, then (with data/forever built) that the generated guides match the
// files on disk and compile without errors. Playing them is
// tests/guides.test.js's job.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const T = require('../tools/lib/professions/gathering/tables');
const R = require('../tools/lib/professions/gathering/route');
const { expectedCrafts } = require('../tools/lib/professions/gathering/secondary');
const { makeProjector } = require('../tools/lib/route/geo');

const ROOT = path.resolve(__dirname, '..');
const DATA = path.join(ROOT, 'data', 'forever');
const hasData = fs.existsSync(path.join(DATA, 'professions.json')) && fs.existsSync(path.join(DATA, 'objects.json'));

test('node colors follow the Classic +25/+50/+100 steps', () => {
	assert.equal(T.color(64, 65), null);
	assert.equal(T.color(65, 65), 'orange');
	assert.equal(T.color(89, 65), 'orange');
	assert.equal(T.color(90, 65), 'yellow');
	assert.equal(T.color(115, 65), 'green');
	assert.equal(T.color(165, 65), 'grey');
	// Copper over 1-65 is orange then yellow then green: strictly between 0 and 1.
	const w = T.bandWeight(1, 1, 65);
	assert.ok(w > T.COLOR_WEIGHT.green && w < 1);
	assert.equal(T.bandWeight(300, 275, 300), 0);
});

test('node tables cover every rank of ore and herb up to 300', () => {
	assert.equal(T.MINING_NODES['Copper Vein'], 1);
	assert.equal(T.MINING_NODES['Rich Thorium Vein'], 275);
	assert.equal(T.HERB_NODES.Peacebloom, 1);
	assert.equal(T.HERB_NODES['Black Lotus'], 300);
	for (const table of [T.MINING_NODES, T.HERB_NODES]) for (const v of Object.values(table)) assert.ok(v >= 1 && v <= 300);
});

test('skinning requirement by beast level', () => {
	assert.equal(T.skinningReq(5), 1);
	assert.equal(T.skinningReq(16), 60);
	assert.equal(T.skinningReq(20), 100);
	assert.equal(T.skinningReq(40), 200);
	assert.equal(T.skinningReq(60), 300);
});

test('expected crafts: one per point below yellow, more as the recipe greys', () => {
	const r = { name: 'Test', yellow: 50, grey: 100 };
	assert.equal(expectedCrafts(r, 1, 50), 49);
	// At 75 the chance is (100 - 75) / 50 = 0.5: two crafts for that point.
	assert.equal(expectedCrafts(r, 75, 76), 2);
	assert.ok(expectedCrafts(r, 50, 90) > 40);
	assert.throws(() => expectedCrafts(r, 99, 101), /grey/);
});

test('fishing catches: one per point below 75, then (skill - 50) / 25 per point; about 1,300 in all', () => {
	const { catches } = require('../tools/lib/professions/gathering/fishing');
	assert.equal(catches(1, 50), 49);
	// At 100 one catch in two raises the skill.
	assert.equal(catches(100, 101), 2);
	assert.equal(Math.round(catches(125, 225)), 498);
	assert.ok(Math.abs(catches(1, 300) - 1300) < 20);
});

test('loop: clusters ordered as a tour starting near the entry point', () => {
	const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	const pts = [];
	const at = (x, y, n) => {
		for (let i = 0; i < n; i++) pts.push({ name: 'Copper Vein', w: 1, pt: project.point(1, x + i * 0.5, y, 'e') });
	};
	at(10, 10, 4);
	at(80, 10, 3);
	at(80, 80, 5);
	at(10, 80, 2);
	const loop = R.loop(pts, project, { radius: 40, cover: 1, entry: project.point(1, 12, 78, 'e') });
	assert.equal(loop.length, 4);
	assert.ok(loop[0].pt.x < 20 && loop[0].pt.y > 70, 'starts at the cluster nearest the entry');
	const score = R.scorePoints(pts);
	assert.ok(score.gain === 14 && score.score > 0);
});

test('a zone\'s rare kind (under a twentieth of the nodes) never leads or names a waypoint, but still counts beside common ones', () => {
	const { rareKinds, label } = require('../tools/lib/professions/gathering/build');
	const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	const pts = [];
	const at = (name, x, y, n, up) => {
		for (let i = 0; i < n; i++) pts.push({ name, up, w: up, pt: project.point(1, x + i * 0.2, y, 'e') });
	};
	at('Peacebloom', 10, 10, 20, 0.1);
	at('Silverleaf', 80, 10, 20, 0.1);
	at('Peacebloom', 80, 80, 20, 0.1);
	// Beside a common herb: counts there, never names it.
	at('Stunted Silverleaf', 81, 80, 1, 0.05);
	// Mulgore's case: a Forever node a few spots carry, beside one common herb far from the rest.
	at('Stunted Silverleaf', 40, 60, 3, 0.05);
	at('Silverleaf', 41, 60, 1, 0.1);
	const rare = rareKinds({}, pts);
	assert.equal(rareKinds({ rareLeads: true }, pts).size, 0, 'skinning: a rare beast may lead');
	assert.deepEqual([...rare], ['Stunted Silverleaf']);
	const atRareSpot = (loop) => loop.some((c) => Math.abs(c.pt.x - 40) < 5 && Math.abs(c.pt.y - 60) < 5);
	assert.ok(atRareSpot(R.loop(pts, project, { radius: 40, cover: 1 })), 'without `rare` the rare spot is a waypoint');
	const loop = R.loop(pts, project, { radius: 40, cover: 1, rare });
	assert.equal(loop.length, 3);
	assert.ok(!atRareSpot(loop), 'the rare spot leads no waypoint');
	const beside = loop.find((c) => c.counts['Stunted Silverleaf']);
	assert.ok(beside, 'a rare node beside common ones still counts in their waypoint');
	assert.equal(label({}, beside, rare), 'Peacebloom');
	// With fewer than three waypoints left every cluster counts.
	const few = pts.filter((p) => !(p.name === 'Peacebloom' && p.pt.x < 20));
	assert.ok(atRareSpot(R.loop(few, project, { radius: 40, cover: 1, rare: rareKinds({}, few) })));
});

test('a zone whose nodes all turn grey inside a band is never picked for it: Teldrassil\'s Amber for Mining 65-125', () => {
	const { coversTop } = require('../tools/lib/professions/gathering/build');
	const amber = [{ name: 'Large Chunk of Amber', req: 1 }, { name: 'Chunk of Amber', req: 1 }];
	assert.equal(coversTop(amber, { from: 1, to: 65 }), true, 'green at 64: Amber takes a Night Elf to 65');
	assert.equal(coversTop(amber, { from: 65, to: 125 }), false, 'grey from 101: no point between 101 and 125');
	assert.equal(coversTop([...amber, { name: 'Tin Vein', req: 65 }], { from: 65, to: 125 }), true, 'one Tin Vein (green at 124) is enough');
	assert.equal(coversTop([{ name: 'Iron Deposit', req: 125 }], { from: 65, to: 125 }), false, 'nor a zone of nodes the band cannot reach yet');
});

test('live-frame spawns come out in the Era frame, so loops on redrawn maps match `coords era`', () => {
	// A map Forever redrew: its live frame is offset from the Era frame and
	// covers 800 yards instead of 1000.
	const frames = {
		era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } },
		forever: { 1: { c: 0, left: 100, right: -700, top: 200, bottom: -600 } },
	};
	const project = makeProjector(frames);
	// Live 50,50 is world (-200, -300): Era 30,20.
	const p = project.point(1, 50, 50, 'l');
	assert.deepEqual([p.x, p.y, p.f, p.wx, p.wy], [30, 20, 'e', -200, -300]);
	// Nodes recorded in both frames cluster together, and the waypoint is Era.
	const pts = [
		{ name: 'Copper Vein', w: 1, pt: project.point(1, 50, 50, 'l') },
		{ name: 'Copper Vein', w: 1, pt: project.point(1, 50.5, 50, 'l') },
		{ name: 'Copper Vein', w: 1, pt: project.point(1, 30, 21, 'e') },
	];
	const [c] = R.weightedClusters(pts, 30, project);
	assert.equal(c.w, 3);
	assert.equal(c.pt.f, 'e');
	assert.deepEqual([c.pt.x, c.pt.y], [30.1, 20.3]);
	// A map with live bounds only stays live.
	const only = makeProjector({ era: {}, forever: frames.forever }).point(1, 50, 50, 'l');
	assert.deepEqual([only.x, only.y, only.f, only.wx, only.wy], [50, 50, 'l', -200, -300]);
});

test('node routes read every spawn (`pts` and `more`) and Forever\'s starting-area nodes, which carry no role', () => {
	const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	const objects = {
		1: { id: 1, name: 'Copper Vein', roles: ['mine'], spawns: { 1: { f: 'e', pts: [[10, 10]], more: [[60, 60]] } } },
		2: { id: 2, name: 'Poor Copper Vein', spawns: { 1: { f: 'e', pts: [[30, 30]] } } },
		3: { id: 3, name: 'Copper Vein', spawns: { 1: { f: 'e', pts: [[90, 90]] } } }, // no role, not a Forever node: left out
	};
	const pts = R.nodePoints(objects, project, { table: T.MINING_NODES, role: 'mine', map: 1, from: 1, to: 50 });
	assert.deepEqual(pts.map((p) => [p.name, p.pt.x, p.pt.y]), [
		['Copper Vein', 10, 10],
		['Copper Vein', 60, 60],
		['Poor Copper Vein', 30, 30],
	]);
});

test('pooled node points count for the nodes the server keeps up: a point listed for several kinds is one node, a rare kind weighs little', () => {
	const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	// Two vein points, each listed as Iron and Gold (one pool picks one of them).
	const objects = {
		1: { id: 1, name: 'Iron Deposit', roles: ['mine'], spawns: { 1: { f: 'e', pts: [[10, 10], [50, 50]] } } },
		2: { id: 2, name: 'Gold Vein', roles: ['mine'], spawns: { 1: { f: 'e', pts: [[10, 10], [50, 50]] } } },
	};
	// Without a pool table each point splits between its two kinds.
	const split = R.nodePoints(objects, project, { table: T.MINING_NODES, role: 'mine', map: 1, from: 155, to: 175 });
	assert.deepEqual(split.map((p) => [p.name, p.up]), [['Iron Deposit', 0.5], ['Iron Deposit', 0.5], ['Gold Vein', 0.5], ['Gold Vein', 0.5]]);
	// The zone keeps 1.8 Iron and 0.2 Gold up: each point carries its kind's share.
	const abundance = { 'Iron Deposit': { up: 1.8 }, 'Gold Vein': { up: 0.2 } };
	const pooled = R.nodePoints(objects, project, { table: T.MINING_NODES, role: 'mine', map: 1, from: 155, to: 175, abundance });
	assert.deepEqual(pooled.map((p) => [p.name, p.up]), [['Iron Deposit', 0.9], ['Iron Deposit', 0.9], ['Gold Vein', 0.1], ['Gold Vein', 0.1]]);
	assert.ok(pooled[0].w > pooled[2].w * 4, 'yellow Iron outweighs rare orange Gold');
	// A kind the zone's table does not have counts nothing.
	assert.equal(R.nodePoints(objects, project, { table: T.MINING_NODES, role: 'mine', map: 1, from: 155, to: 175, abundance: { 'Iron Deposit': { up: 2 } } }).length, 2);
	// A zone whose table holds none of the profession's kinds (Teldrassil lists its herbs, not its Amber)
	// splits points as a zone without a table does: Forever's Chunks of Amber are mined there from skill 1.
	const amber = { 4: { id: 4, name: 'Chunk of Amber', spawns: { 1: { f: 'e', pts: [[20, 20]] } } }, 5: { id: 5, name: 'Large Chunk of Amber', spawns: { 1: { f: 'e', pts: [[40, 40]] } } } };
	const herbsOnly = { Peacebloom: { up: 20 } };
	assert.deepEqual(R.nodePoints(amber, project, { table: T.MINING_NODES, role: 'mine', map: 1, from: 1, to: 50, abundance: herbsOnly }).map((p) => [p.name, p.up]), [['Chunk of Amber', 1], ['Large Chunk of Amber', 1]]);
});

test('pool odds: a member holds its share of the pool\'s slots, scaled by how often its parent pool picks it', () => {
	const A = require('../tools/lib/professions/gathering/abundance');
	const odds = A.poolOdds(
		[{ entry: 10, max_limit: 1 }, { entry: 20, max_limit: 2 }, { entry: 30, max_limit: 1 }],
		[
			// Master pool 10 picks one of its two child pools.
			{ type: 2, spawnId: 20, poolSpawnId: 10, chance: 0 },
			{ type: 2, spawnId: 30, poolSpawnId: 10, chance: 0 },
			// Pool 20 keeps 2 of its 4 spawns up; pool 30 picks spawn 5 at 80%, 6 at 20%.
			...[1, 2, 3, 4].map((g) => ({ type: 1, spawnId: g, poolSpawnId: 20, chance: 0 })),
			{ type: 1, spawnId: 5, poolSpawnId: 30, chance: 80 },
			{ type: 1, spawnId: 6, poolSpawnId: 30, chance: 20 },
		],
	);
	assert.equal(odds(1), 0.25);
	assert.equal(odds(5), 0.4);
	assert.ok(Math.abs(odds(6) - 0.1) < 1e-9);
	assert.equal(odds(99), 1, 'a spawn in no pool is always up');
});

test('each gathering spec teaches its own camping recipe and sells its own bag', () => {
	const { SPECS } = require('../tools/lib/professions/gathering/specs');
	const by = Object.fromEntries(SPECS.map((s) => [s.file, s]));
	assert.equal(by.mining.camp, 1230161);
	assert.equal(by.herbalism.camp, 1229705);
	assert.equal(by.skinning.camp, 1229517);
	assert.match(by.herbalism.learnTip, /Herb Pouch/);
	assert.match(by.herbalism.learnTip, /Camping 101: Herbalism/);
	assert.doesNotMatch(by.herbalism.learnTip, /Skinning/);
	assert.match(by.skinning.learnTip, /Skinning Satchel/);
});

test('Skyborne play on both sides: an `only` with them names the side, and a side whose twin went elsewhere gets its own step', () => {
	const { raceCondition } = require('../tools/lib/professions/gathering/groups');
	assert.equal(raceCondition(['Human', 'Skyborne'], ['Alliance']), 'Human,Skyborne,Alliance');
	assert.equal(raceCondition(['Skyborne', 'Skyborne'], ['Alliance', 'Horde']), 'Skyborne');
	assert.equal(raceCondition(['Orc', 'Troll'], ['Horde']), 'Orc,Troll');
	const { mergePicks } = require('../tools/lib/professions/gathering/build');
	const pick = (faction, races, zone) => ({ faction, zone, points: [], group: { races } });
	const merged = mergePicks([pick('Alliance', ['NightElf'], 1440), pick('Alliance', ['Human', 'Skyborne'], 1436), pick('Horde', ['Orc', 'Skyborne'], 1440)]);
	assert.deepEqual(merged.map((m) => [m.zone, m.cond]), [
		[1440, 'NightElf'],
		[1436, 'Human,Skyborne,Alliance'],
		[1440, 'Orc,Skyborne,Horde'],
	]);
	// Same-side groups on the Skyborne's map share their step.
	const westfall = mergePicks([pick('Alliance', ['Human'], 1436), pick('Alliance', ['Skyborne'], 1436), pick('Horde', ['Skyborne'], 1413)]);
	assert.deepEqual(westfall.map((m) => [m.zone, m.cond]), [
		[1436, 'Human,Skyborne,Alliance'],
		[1413, 'Skyborne,Horde'],
	]);
	// Both sides' Skyborne on one map (Zephras Isle): one step for both.
	assert.deepEqual(mergePicks([pick('Alliance', ['Skyborne'], 2521), pick('Horde', ['Skyborne'], 2521)]).map((m) => m.cond), ['Skyborne']);
});

test('an ingredient held in a container (clam meat in clams) is farmed as the container when its droppers weigh more', () => {
	const { dropSpot } = require('../tools/lib/professions/gathering/secondary');
	const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	const spawns = (x) => ({ 1: { f: 'e', pts: [[x, 10], [x + 1, 10], [x + 2, 10]] } });
	const items = {
		5503: { id: 5503, name: 'Clam Meat', drops: { npc: { 10: 5 } }, containers: [5523] },
		5523: { id: 5523, name: 'Small Barnacled Clam', drops: { npc: { 11: 40 } } },
	};
	const npcs = { 10: { id: 10, name: 'Crab', faction: null, spawns: spawns(10) }, 11: { id: 11, name: 'Murloc', faction: null, spawns: spawns(50) } };
	const ctx = { project, data: { item: (id) => items[id], npc: (id) => npcs[id], zone: () => ({ name: 'Test' }) } };
	const d = dropSpot(ctx, 5503, 1);
	assert.equal(d.via, 5523);
	assert.deepEqual(d.mobs, ['Murloc (40%)']);
});

test('a recipe is limited stock only when a faction has no unlimited vendor for it', () => {
	const { learnNote } = require('../tools/lib/professions/gathering/secondary');
	const ctx = { data: { item: (id) => ({ name: `Recipe ${id}` }) } };
	const recipe = { recipeItem: 1, cost: 5000 };
	const P = { skill: 'Cooking', materials: { 1: { buy: 5000, vendors: { Alliance: [10], Horde: [] }, limitedVendors: { Alliance: [12], Horde: [12] } } } };
	// Roast Raptor: plenty of unlimited sellers beside one limited one.
	assert.doesNotMatch(learnNote(ctx, P, recipe, { learn: 'vendor', who: { faction: 'Alliance' } }), /limited stock/);
	// A side whose only seller is limited.
	assert.match(learnNote(ctx, P, recipe, { learn: 'vendor', who: { faction: 'Horde' } }), /limited stock/);
	assert.match(learnNote(ctx, P, recipe, { learn: 'vendor', who: {} }), /limited stock/);
});

test('generated profession guides are up to date and compile', { skip: hasData ? false : 'data/forever not built' }, () => {
	const { buildAll } = require('../tools/lib/professions/gathering/build');
	const { context, OUT_DIR } = require('../tools/lib/professions/gathering/common');
	const { compileSources } = require('../tools/lib/dsl/project');
	const { format } = require('../tools/lib/dsl/diag');
	const ctx = context(DATA);
	const files = buildAll(ctx);
	assert.deepEqual(Object.keys(files).sort(), ['cooking.guide', 'first-aid.guide', 'fishing.guide', 'herbalism.guide', 'mining.guide', 'skinning.guide']);
	const stale = Object.entries(files)
		.filter(([name, text]) => !fs.existsSync(path.join(OUT_DIR, name)) || fs.readFileSync(path.join(OUT_DIR, name), 'utf8') !== text)
		.map(([name]) => name);
	assert.deepEqual(stale, [], 'run node tools/polestar.js profession gathering build');
	const sources = Object.entries(files).map(([name, text]) => ({ file: `guides/forever/professions/${name}`, source: `forever/professions/${name}`, text }));
	const { diag } = compileSources(sources, ctx.data);
	assert.deepEqual(diag.errors.map(format), []);
});
