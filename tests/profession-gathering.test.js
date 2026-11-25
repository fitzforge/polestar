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

test('a band\'s zone is workable from its first point: Hillsbrad Foothills\' beasts (105 and up) split Skinning 100-125 at 105 (#3355)', () => {
	const { coversStart, pickZones } = require('../tools/lib/professions/gathering/build');
	// Gray Bear (21) needs 105, Vicious Gray Bear (22) 110, Starving Mountain Lion (23) 115.
	const reqs = { 1: [105, 105, 105, 105, 110, 110, 115, 115], 2: [60, 60, 60, 60, 60, 60, 20, 20] };
	const zonePoints = (id) => reqs[id].map((req, i) => ({ name: `beast ${req}`, req, pt: { c: 0, wx: id * 5000 + i * 30, wy: 0 } }));
	assert.equal(coversStart(zonePoints(1), { from: 100, to: 125 }, 4), false, 'nothing in Hillsbrad at 100-104');
	assert.equal(coversStart(zonePoints(1), { from: 105, to: 125 }, 4), true, 'four Gray Bears at 105');
	assert.equal(coversStart(zonePoints(2), { from: 100, to: 125 }, 4), true);
	assert.equal(coversStart([{ req: 1 }, { req: 1 }, { req: 1 }, { req: 1 }], { from: 101, to: 125 }, 4), false, 'grey nodes do not count');
	const prof = {
		skill: 'Skinning',
		minPoints: 4,
		points: (ctx, id, from, to) => zonePoints(id).map((p) => ({ ...p, w: T.bandWeight(p.req, from, to) })).filter((p) => p.w > 0),
	};
	const band = { from: 100, to: 125, zones: { Horde: [1, 2] } };
	// Hillsbrad (1) scores best over the band; Silverpine (2) is the zone workable at 100.
	const parts = pickZones({}, prof, band, 'Horde', { key: 'undead' }).map((p) => [p.zone, p.from, p.to]);
	assert.deepEqual(parts, [
		[2, 100, 105],
		[1, 105, 125],
	]);
	assert.deepEqual(pickZones({}, prof, { ...band, from: 105 }, 'Horde', { key: 'undead' }).map((p) => [p.zone, p.from, p.to]), [[1, 105, 125]]);
	assert.throws(() => pickZones({}, prof, { ...band, zones: { Horde: [1] } }, 'Horde', { key: 'undead' }), /no zone workable from 100/);
});

test('every generated gathering band lists something the band\'s starting skill can gather (#3355)', () => {
	const dir = path.join(ROOT, 'guides', 'forever', 'professions');
	// Skinning names a beast the start can skin as "Gray Bear (21)", one it cannot yet as "(22, needs 110)";
	// Mining and Herbalism name a node as "Copper (1, orange)", one for later as "(from 65)".
	const workable = { 'skinning.guide': /\(\d+\)/, 'mining.guide': /\(\d+, (orange|yellow|green)/, 'herbalism.guide': /\(\d+, (orange|yellow|green)/ };
	const bad = [];
	for (const [file, re] of Object.entries(workable)) {
		let step = null;
		for (const line of fs.readFileSync(path.join(dir, file), 'utf8').split('\n')) {
			if (line.startsWith('step ')) step = /\(\d+-\d+\)( cont\.)?$/.test(line) ? line : null;
			else if (step && line.startsWith('  tip ') && !re.test(line)) bad.push(`${file}: ${step}`);
		}
	}
	assert.deepEqual(bad, []);
});

test('a step splits where a common kind first becomes gatherable, and no part leads to one it cannot gather yet: Loch Modan\'s Briarthorn (70) in Herbalism 50-100 (#2892)', () => {
	const { startParts } = require('../tools/lib/professions/gathering/build');
	const pts = [];
	const at = (name, req, n) => {
		for (let i = 0; i < n; i++) pts.push({ name, req, up: 1, w: 1, pt: { c: 0, wx: pts.length * 30, wy: 0 } });
	};
	at('Earthroot', 15, 10);
	at('Mageroyal', 50, 20);
	at('Briarthorn', 70, 20);
	at('Stranglekelp', 85, 10);
	// Under a twentieth: it opens no part of its own and joins at the next split.
	at('Wild Steelbloom', 75, 1);
	const parts = startParts({}, pts, 50, 100).map((p) => [p.from, p.to, [...new Set(p.points.map((q) => q.name))].sort().join(', ')]);
	assert.deepEqual(parts, [
		[50, 70, 'Earthroot, Mageroyal'],
		[70, 85, 'Briarthorn, Earthroot, Mageroyal'],
		[85, 100, 'Briarthorn, Earthroot, Mageroyal, Stranglekelp, Wild Steelbloom'],
	]);
	assert.deepEqual(startParts({}, pts, 85, 100).length, 1, 'nothing new inside 85-100');
	assert.deepEqual(startParts({ rareLeads: true }, pts, 50, 100).map((p) => [p.from, p.to, p.points.length]), [[50, 100, pts.length]], 'skinning: one part, every beast (coversStart splits its bands)');
});

test('a rare herb that becomes common after a split cannot lead a waypoint before its skill (#2892)', () => {
	const { startParts, rareKinds, label } = require('../tools/lib/professions/gathering/build');
	const project = makeProjector({ era: { 1432: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	const points = [];
	const add = (name, count, x, y) => {
		for (let i = 0; i < count; i++) {
			points.push({ name, req: T.HERB_NODES[name], w: 1, up: 1, pt: project.point(1432, x + i * 0.15, y, 'e') });
		}
	};
	add('Mageroyal', 6, 10, 10);
	add('Briarthorn', 40, 80, 80);
	add('Stranglekelp', 1, 50, 50);
	assert.ok(rareKinds({}, points).has('Stranglekelp'));
	const [early] = startParts({}, points, 50, 100);
	const rare = rareKinds({}, early.points);
	const waypoints = R.loop(early.points, project, { rare }).map((cluster) => label({}, cluster, rare));
	assert.deepEqual(waypoints, ['Mageroyal']);
});

test('no Herbalism waypoint names a herb the step\'s starting skill cannot pick (#2892)', () => {
	const bad = [];
	let step = null;
	let from = null;
	for (const line of fs.readFileSync(path.join(ROOT, 'guides', 'forever', 'professions', 'herbalism.guide'), 'utf8').split('\n')) {
		if (line.startsWith('step ')) {
			const m = line.match(/\((\d+)-\d+\)( cont\.)?$/);
			step = m ? line : null;
			from = m ? Number(m[1]) : null;
		} else if (step && line.startsWith('  goto ')) {
			const label = (line.match(/"([^"]*)"/) || [])[1] || '';
			for (const name of label.split(', ')) {
				const req = T.HERB_NODES[name];
				assert.ok(req !== undefined, `${step}: "${name}" is no herb`);
				if (req > from) bad.push(`${step}: ${name} (${req})`);
			}
		}
	}
	assert.deepEqual(bad, []);
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

test("the Fishing guide names each band's cooking recipes with their sellers, buys one only by the water, and says what Darkshore Grouper and Oily Blackmouth are for (#1883)", { skip: hasData ? false : 'data/forever not built' }, () => {
	const { context, money } = require('../tools/lib/professions/gathering/common');
	const fishing = require('../tools/lib/professions/gathering/fishing');
	const ctx = context(DATA);
	const text = fishing.render(ctx);
	const cook = ctx.data.professionNamed('Cooking');
	const recipes = [6325, 6326, 6328, 6368, 6330, 6369];
	for (const item of recipes) {
		const m = cook.materials[item];
		assert.ok(text.includes(`${m.name} for the `), `${m.name} is named`);
		assert.ok(text.includes(`, ${money(m.buy)}: `), `${m.name}'s price, ${money(m.buy)}`);
	}
	// A recipe is bought only where a seller of it stands by a band's water: an optional goal on that fishing step.
	let buys = 0;
	for (const s of text.split('\nstep ').slice(1)) {
		for (const [, item, npc, optional] of s.matchAll(/\n {2}buy (\d+) x1 npc (\d+)( optional)?/g)) {
			if (!recipes.includes(Number(item))) continue;
			buys++;
			const title = s.split('\n')[0];
			assert.ok(optional, `${title}: the recipe is an optional buy`);
			assert.ok(title.startsWith('Fishing: '), `${title}: a band's fishing step`);
			const v = cook.materials[item].vendors;
			assert.ok([...(v.Alliance || []), ...(v.Horde || [])].includes(Number(npc)), `${title}: ${npc} sells ${item}`);
		}
	}
	assert.ok(buys > 0, 'some band fishes beside a recipe seller');
	assert.match(text, /Darkshore Grouper bites only here: eat it as it is\. Gubber Blump \(Darkshore\) takes 6 for The Family and the Fishing Pole, which gives the Blump Family Fishing Pole\./);
	assert.match(text, /Oily Blackmouth from the schools here is no food: alchemists make Blackmouth Oil from it \(Alchemy 80\); keep it to sell or trade\./);
});

// Hotline (#3759): the Undead's "Hillsbrad coast" pin lay on the lake south of Tarren Mill, the pool cluster nearest the
// flight master. A coast spot takes its pools from the sea's schools; Sagefish Schools are lake and river water.
test('the Fishing guide\'s coast spots lie by sea pools, never a lake\'s Sagefish Schools (#3759)', { skip: hasData ? false : 'data/forever not built' }, () => {
	const { context } = require('../tools/lib/professions/gathering/common');
	const fishing = require('../tools/lib/professions/gathering/fishing');
	const ctx = context(DATA);
	const text = fishing.render(ctx);
	const coasts = [];
	for (const s of text.split('\nstep ').slice(1)) {
		const zone = (s.match(/\n {2}zone (.+)/) || [])[1];
		for (const [, x, y, label] of s.matchAll(/\n {2}goto ([\d.]+),([\d.]+) "([^"]* coast)"/g)) coasts.push({ zone, x: Number(x), y: Number(y), label });
	}
	const hillsbrad = coasts.find((c) => c.label === 'Hillsbrad coast');
	assert.ok(hillsbrad, 'the Hillsbrad coast spot is in the guide');
	const zoneId = { 'Hillsbrad Foothills': 1424, Westfall: 1436, Darkshore: 1439, Wetlands: 1437, 'Stranglethorn Vale': 1434 };
	for (const c of coasts) {
		const map = zoneId[c.zone];
		if (!map) continue;
		let nearest = null;
		for (const o of Object.values(ctx.data.objects)) {
			if (!o.roles || !o.roles.includes('fishing')) continue;
			const s = o.spawns && o.spawns[String(map)];
			for (const [x, y] of (s && s.pts) || []) {
				const d = Math.hypot(x - c.x, y - c.y);
				if (!nearest || d < nearest.d) nearest = { d, name: o.name };
			}
		}
		assert.ok(nearest, `${c.label}: pools on the map`);
		assert.doesNotMatch(nearest.name, /Sagefish School/, `${c.label} (${c.x},${c.y}) lies by ${nearest.name}`);
	}
});

test('a band keeps the zone its group worked before when another scores within 3% (no trip for a near tie)', () => {
	const { pickZones } = require('../tools/lib/professions/gathering/build');
	const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	// The same 20 nodes in both zones; zone 1's are worth `w1` each, so its score is w1 times zone 2's.
	const line = (w) => Array.from({ length: 20 }, (_, i) => ({ name: 'Node', req: 1, w, pt: project.point(1, 10 + i, 10, 'e') }));
	let w1 = 1.02;
	const prof = { skill: 'Test', minPoints: 4, points: (ctx, zone) => line(zone === 1 ? w1 : 1) };
	const band = { from: 1, to: 25, zones: { Alliance: [1, 2] } };
	const ctx = { project, data: {} };
	assert.equal(pickZones(ctx, prof, band, 'Alliance', { key: 'a' })[0].zone, 1, 'the better zone with no zone before');
	assert.equal(pickZones(ctx, prof, band, 'Alliance', { key: 'a' }, new Set([2]))[0].zone, 2, 'the zone worked before, 2% behind');
	w1 = 1.05;
	assert.equal(pickZones(ctx, prof, band, 'Alliance', { key: 'a' }, new Set([2]))[0].zone, 1, 'a zone 5% better still wins');
});

test('Skinning 125-150 stays in Ashenvale for Night Elves and the Horde (a near tie with Thousand Needles)', { skip: hasData ? false : 'data/forever not built' }, () => {
	const text = fs.readFileSync(path.join(__dirname, '..', 'guides', 'forever', 'professions', 'skinning.guide'), 'utf8');
	const steps = text.split('\nstep ').slice(1).filter((s) => /\(125-150\)/.test(s.split('\n')[0]));
	const night = steps.filter((s) => /\n {2}only NightElf\n/.test(s) || /\n {2}only Orc,Troll,Tauren/.test(s));
	assert.equal(night.length, 2);
	for (const s of night) assert.match(s, /\n {2}zone Ashenvale\n/, s.split('\n')[0]);
});
