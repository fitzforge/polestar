'use strict';
// The generator behind guides/forever/professions/{mining,herbalism,skinning,
// fishing,cooking,first-aid,fishing-cooking}.guide (tools/lib/professions/gathering): the
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

// A test context: map 1 is 1000 x 1000 yards (a map percent is 10 yards), with these creatures on it.
// npc: [id, name, level, faction, x, y] (faction null = hostile; items.json makes them drop something).
function stubCtx(npcs = []) {
	const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 }, 2: { c: 1, left: 0, right: -1000, top: 0, bottom: -1000 }, 1432: { c: 2, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	const data = { npcs: {}, items: { 900: { drops: { npc: {} } } } };
	for (const [id, name, level, faction, x, y] of npcs) {
		data.npcs[id] = data.npcs[id] || { id, name, level, rank: 0, faction, spawns: { 1: { f: 'e', pts: [] } } };
		data.npcs[id].spawns[1].pts.push([x, y]);
		if (!faction) data.items[900].drops.npc[id] = 10;
	}
	return { project, data };
}

test('farm: a loop through the densest ground a character of the band\'s level can work, never by the other faction\'s town', () => {
	const { farm, skillLevel } = require('../tools/lib/professions/gathering/farm');
	const mobs = [];
	// Level 30 creatures stand over the dense ground at 70,70; a Horde town (three kinds of NPC) at 15,42.
	for (let x = 68; x <= 74; x += 2) for (let y = 68; y <= 80; y += 2) mobs.push([100, 'Ogre', 30, null, x, y]);
	mobs.push([200, 'Guard', 30, 'H', 15, 42], [201, 'Vendor', 30, 'H', 16, 42], [202, 'Innkeeper', 30, 'H', 15, 43]);
	const ctx = stubCtx(mobs);
	const pts = [];
	const at = (x, y, n) => {
		for (let i = 0; i < n; i++) pts.push({ name: 'Mageroyal', req: 50, up: 1, w: 1, pt: ctx.project.point(1, x + (i % 3) * 0.6, y + Math.floor(i / 3) * 0.6, 'e') });
	};
	at(20, 20, 6);
	at(30, 20, 6);
	at(30, 30, 6);
	at(22, 31, 9);
	at(70, 70, 40);
	const prof = { radius: 40, stopYards: 35 };
	const near = (f, x, y, yards) => f.stops.some((s) => Math.hypot(s.pt.x - x, s.pt.y - y) * 10 < yards);
	const low = farm(ctx, prof, 1, pts, { faction: 'Alliance', level: skillLevel(50) });
	assert.equal(skillLevel(50), 10);
	assert.ok(!near(low, 70, 70, 100), 'the guarded ground is left out at level 10');
	assert.ok(low.level <= 10 && low.stops.length >= 3, `level ${low.level}, ${low.stops.length} stops`);
	assert.ok(!near(low, 22.6, 31.6, 40), 'no stop by the Horde town');
	const horde = farm(ctx, prof, 1, pts, { faction: 'Horde', level: skillLevel(50) });
	assert.ok(near(horde, 22, 31, 50), 'the Horde may work by its own town');
	const high = farm(ctx, prof, 1, pts, { faction: 'Alliance', level: skillLevel(150) });
	assert.ok(near(high, 70, 70, 50), 'at level 30 the dense ground wins');
	assert.equal(high.level, 29, 'a level-30 creature on the loop: it asks 29');
	assert.ok(high.on.length >= 30 && high.lap > 0);
});

test('a zone\'s rare kind (under a twentieth of the nodes) opens no part of a range and is left out of its title', () => {
	const { rareKinds, startParts } = require('../tools/lib/professions/gathering/build');
	const pts = [];
	for (let i = 0; i < 20; i++) pts.push({ name: 'Peacebloom', req: 1, up: 0.1 }, { name: 'Silverleaf', req: 1, up: 0.1 });
	pts.push({ name: 'Stranglekelp', req: 85, up: 0.05 });
	const rare = rareKinds({}, pts);
	assert.deepEqual([...rare], ['Stranglekelp']);
	assert.equal(rareKinds({ rareLeads: true }, pts).size, 0, 'skinning: every beast counts');
	assert.deepEqual(startParts({}, pts, 50, 100), [{ from: 50, to: 100 }]);
});

test('a zone whose nodes all turn grey inside a band is never picked for it: Teldrassil\'s Amber for Mining 65-125', () => {
	const { coversTop } = require('../tools/lib/professions/gathering/build');
	const amber = [{ name: 'Large Chunk of Amber', req: 1 }, { name: 'Chunk of Amber', req: 1 }];
	assert.equal(coversTop(amber, { from: 1, to: 65 }), true, 'green at 64: Amber takes a Night Elf to 65');
	assert.equal(coversTop(amber, { from: 65, to: 125 }), false, 'grey from 101: no point between 101 and 125');
	assert.equal(coversTop([...amber, { name: 'Tin Vein', req: 65 }], { from: 65, to: 125 }), true, 'one Tin Vein (green at 124) is enough');
	assert.equal(coversTop([{ name: 'Iron Deposit', req: 125 }], { from: 65, to: 125 }), false, 'nor a zone of nodes the band cannot reach yet');
});

test('a range\'s loops take only what its starting skill can skin, mine or pick: no beast that needs 105 at Skinning 100 (#3355)', () => {
	const { partPoints } = require('../tools/lib/professions/gathering/build');
	// Gray Bear (21) needs 105, Vicious Gray Bear (22) 110; a level-12 beast (20) is green at 100, a level-5 one
	// (1) green too, grey from 101.
	const pts = [105, 105, 110, 20, 1].map((req, i) => ({ name: `beast ${req}`, req, up: 1, w: 1, pt: { c: 0, wx: i * 30, wy: 0 } }));
	assert.deepEqual(partPoints(pts, 100, 125).map((p) => p.req), [20, 1], 'not yet skinnable (105, 110) left out');
	assert.deepEqual(partPoints(pts, 105, 125).map((p) => p.req), [105, 105, 20], 'from 105 the bears; the level-5 beast is grey');
	assert.equal(partPoints(pts, 105, 125), partPoints(pts, 105, 125), 'one array per part: the loops are memoised on it');
});

test('a range offers the loops of several zones for both factions, one loop once when both sides share it', () => {
	const { partLoops } = require('../tools/lib/professions/gathering/build');
	const ctx = stubCtx([[200, 'Guard', 30, 'H', 90, 90], [201, 'Vendor', 30, 'H', 91, 90], [202, 'Innkeeper', 30, 'H', 90, 91]]);
	const line = (zone, x0) => Array.from({ length: 12 }, (_, i) => ({ name: 'Copper Vein', req: 1, up: 1, w: 1, pt: ctx.project.point(zone, x0 + (i % 4) * 4, 10 + Math.floor(i / 4) * 4, 'e') }));
	const zones = { 1: line(1, 10), 2: line(2, 80) };
	// Zone 2's ground lies by a Horde town: no Alliance loop there.
	ctx.data.npcs[200].spawns[2] = { f: 'e', pts: [[86, 14]] };
	ctx.data.npcs[201].spawns[2] = { f: 'e', pts: [[87, 14]] };
	ctx.data.npcs[202].spawns[2] = { f: 'e', pts: [[86, 15]] };
	const prof = { skill: 'Mining', radius: 40, points: (c, zone) => zones[zone] };
	const loops = partLoops(ctx, prof, { Alliance: [1, 2], Horde: [1, 2] }, { from: 1, to: 50, band: { from: 1, to: 50 } });
	assert.deepEqual(
		loops.map((l) => [l.zone, l.factions.join(',')]).sort(),
		[
			[1, 'Alliance,Horde'],
			[2, 'Horde'],
		],
	);
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

test('a step splits where a common kind first becomes gatherable: Loch Modan\'s Briarthorn (70) in Herbalism 50-100 (#2892)', () => {
	const { startParts, partPoints } = require('../tools/lib/professions/gathering/build');
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
	const parts = startParts({}, pts, 50, 100).map((p) => [p.from, p.to, [...new Set(partPoints(pts, p.from, p.to).map((q) => q.name))].sort().join(', ')]);
	assert.deepEqual(parts, [
		[50, 70, 'Earthroot, Mageroyal'],
		[70, 85, 'Briarthorn, Earthroot, Mageroyal'],
		[85, 100, 'Briarthorn, Earthroot, Mageroyal, Stranglekelp, Wild Steelbloom'],
	]);
	assert.deepEqual(startParts({}, pts, 85, 100).length, 1, 'nothing new inside 85-100');
	assert.deepEqual(startParts({ rareLeads: true }, pts, 50, 100), [{ from: 50, to: 100 }], 'skinning: one part');
});

test('a rare herb that becomes common after a split is on no loop before its skill (#2892)', () => {
	const { startParts, partPoints, rareKinds } = require('../tools/lib/professions/gathering/build');
	const { farm } = require('../tools/lib/professions/gathering/farm');
	const ctx = stubCtx();
	const points = [];
	const add = (name, count, x, y) => {
		for (let i = 0; i < count; i++) {
			points.push({ name, req: T.HERB_NODES[name], w: 1, up: 1, pt: ctx.project.point(1432, x + i * 0.15, y, 'e') });
		}
	};
	add('Mageroyal', 6, 10, 10);
	add('Mageroyal', 6, 20, 10);
	add('Mageroyal', 6, 15, 20);
	add('Briarthorn', 40, 80, 80);
	add('Stranglekelp', 1, 15, 15);
	assert.ok(rareKinds({}, points).has('Stranglekelp'));
	const [early] = startParts({}, points, 50, 100);
	const f = farm(ctx, { radius: 40 }, 1432, partPoints(points, early.from, early.to), { level: 10 });
	assert.ok(f.on.length > 0 && f.on.every((p) => p.req <= 50), 'nothing on the loop needs more than 50');
	assert.ok(f.stops.every((s) => Object.keys(s.counts).every((k) => k === 'Mageroyal')));
});

test('no Herbalism loop holds a herb its range\'s starting skill cannot pick (#2892)', { skip: hasData ? false : 'data/forever not built' }, () => {
	const { plan } = require('../tools/lib/professions/gathering/build');
	const { context } = require('../tools/lib/professions/gathering/common');
	const { SPECS } = require('../tools/lib/professions/gathering/specs');
	const bad = [];
	for (const e of plan(context(DATA), SPECS.find((s) => s.file === 'herbalism'))) {
		if (e.kind !== 'band') continue;
		for (const l of e.loops) for (const p of l.farm.on) if (p.req > e.from) bad.push(`${e.from}-${e.to} ${l.zone}: ${p.name} (${p.req})`);
	}
	assert.deepEqual([...new Set(bad)], []);
});

test('a band also offers its densest zones for a character past every zone\'s level: Winterspring\'s Small Thorium in Mining 245-275', { skip: hasData ? false : 'data/forever not built' }, () => {
	const { plan } = require('../tools/lib/professions/gathering/build');
	const { context } = require('../tools/lib/professions/gathering/common');
	const { SPECS } = require('../tools/lib/professions/gathering/specs');
	const band = plan(context(DATA), SPECS.find((s) => s.file === 'mining')).find((e) => e.kind === 'band' && e.from === 245);
	assert.ok(band.loops.some((l) => l.zone === 1452), String(band.loops.map((l) => l.zone)));
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

test('node points are the server\'s spawns, each counting for the chance its pool keeps it up', () => {
	const N = require('../tools/lib/professions/gathering/nodes');
	const project = makeProjector({ era: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	// Two vein spots, each a pool of Iron (90%) and Gold (10%); a herb the Mining table does not know.
	const nodes = { maps: { 1: { kinds: { 'Gold Vein': { respawn: 600, pts: '10,10,0.1 50,50,0.1' }, 'Iron Deposit': { respawn: 600, pts: '10,10,0.9 50,50,0.9' }, Peacebloom: { respawn: 300, pts: '30,30,1' } } } } };
	const pts = N.nodePoints(project, { table: T.MINING_NODES, map: 1, from: 155, to: 175, nodes });
	assert.deepEqual(pts.map((p) => [p.name, p.up, p.pt.x, p.pt.y]), [
		['Gold Vein', 0.1, 10, 10],
		['Gold Vein', 0.1, 50, 50],
		['Iron Deposit', 0.9, 10, 10],
		['Iron Deposit', 0.9, 50, 50],
	]);
	assert.ok(pts[2].w > pts[0].w * 4, 'yellow Iron outweighs rare orange Gold');
	assert.deepEqual(N.nodePoints(project, { table: T.MINING_NODES, map: 1, from: 300, to: 301, nodes }), [], 'grey for the band: nothing');
	assert.equal(N.respawnOf(1, 'Iron Deposit', nodes), 600);
	assert.equal(N.respawnOf(2, 'Iron Deposit', nodes), null);
});

test('a kind the world database lacks in a zone takes its objects.json spawns once three players gathered it there: Teldrassil\'s Amber', () => {
	const N = require('../tools/lib/professions/gathering/nodes');
	const project = makeProjector({ era: { 1438: { c: 1, left: 0, right: -1000, top: 0, bottom: -1000 } } });
	const objects = {
		1: { id: 1, name: 'Chunk of Amber', spawns: { 1438: { f: 'e', pts: [[20, 20]], more: [[40, 40]] } } },
		2: { id: 2, name: 'Large Chunk of Amber', spawns: { 1438: { f: 'e', pts: [[40, 40]] } } },
		3: { id: 3, name: 'Peacebloom', spawns: { 1438: { f: 'e', pts: [[60, 60]] } } },
	};
	const maps = { 1438: { kinds: { Peacebloom: { respawn: 300, pts: '60,60,1' } } } };
	const rec = (name, person) => ({ kind: 'mine', name, map: 1438, person, items: {} });
	const records = [rec('Chunk of Amber', 'a'), rec('Chunk of Amber', 'b'), rec('Chunk of Amber', 'c'), rec('Large Chunk of Amber', 'a'), rec('Large Chunk of Amber', 'b')];
	const out = N.fill(maps, records, objects, project, { era: { 1438: {} } });
	assert.deepEqual(Object.keys(out[1438].kinds), ['Chunk of Amber', 'Peacebloom'], 'two gatherers are not enough for the Large Chunk');
	// 40,40 carries two kinds: half a node of each.
	assert.deepEqual(out[1438].kinds['Chunk of Amber'], { src: 'objects', pts: '20,20,1 40,40,0.5' });
	assert.deepEqual(out[1438].kinds.Peacebloom, { respawn: 300, pts: '60,60,1' }, 'a kind the database has keeps its spawns');
});

test('what a node gives: a vein\'s loot windows in one session at one spot are one node', () => {
	const N = require('../tools/lib/professions/gathering/nodes');
	const os = require('node:os');
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'gather-'));
	try {
		const project = makeProjector({ era: {}, forever: { 1: { c: 0, left: 0, right: -1000, top: 0, bottom: -1000 } } });
		const events = [];
		for (let i = 0; i < N.MIN_NODES; i++) {
			const t = i * 600;
			// Two windows at one vein (ore, then ore and stone), then a herb.
			events.push({ t, e: 'drop', object: 10, gather: 'mine', map: 1, x: 10 + i, y: 10, items: [{ item: 2771, count: 1 }] });
			events.push({ t: t + 5, e: 'drop', object: 10, gather: 'mine', map: 1, x: 10 + i, y: 10.2, items: [{ item: 2771, count: 1 }, { item: 2836, count: 1 }] });
			events.push({ t: t + 60, e: 'drop', object: 20, gather: 'herb', map: 1, x: 50, y: 50, items: [{ item: 785, count: 2 }] });
			events.push({ t: t + 90, e: 'drop', npc: 30, gather: 'skin', map: 1, x: 50, y: 50, items: [{ item: 2318, count: 1 }] });
		}
		fs.writeFileSync(path.join(dir, '20261101T000000Z-c1-i1-h1.json'), JSON.stringify({ contributor: 'c1', events }));
		const objects = { 10: { name: 'Tin Vein' }, 20: { name: 'Mageroyal' } };
		const npcs = { 30: { level: 12 } };
		const records = N.readGathers(dir, objects, npcs, project);
		const yields = N.perNode(records.filter((r) => r.kind !== 'skin'));
		assert.deepEqual(yields['Tin Vein'], { nodes: N.MIN_NODES, people: 1, items: { 2771: 2, 2836: 1 } });
		assert.deepEqual(yields.Mageroyal.items, { 785: 2 });
		assert.deepEqual(N.perNode(records.filter((r) => r.kind === 'skin'))['12'].items, { 2318: 1 });
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
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

test('Skyborne play on both sides: an `only` with them names the side', () => {
	const { raceCondition } = require('../tools/lib/professions/gathering/groups');
	assert.equal(raceCondition(['Human', 'Skyborne'], ['Alliance']), 'Human,Skyborne,Alliance');
	assert.equal(raceCondition(['Skyborne', 'Skyborne'], ['Alliance', 'Horde']), 'Skyborne');
	assert.equal(raceCondition(['Orc', 'Troll'], ['Horde']), 'Orc,Troll');
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
	assert.deepEqual(Object.keys(files).sort(), ['cooking.guide', 'first-aid.guide', 'fishing-cooking.guide', 'fishing.guide', 'herbalism.guide', 'mining.guide', 'skinning.guide']);
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

// Every Herbalism, Mining and Skinning farming loop (`loop <zone> lvl <n> … at …`) names the strongest
// creature along its whole walk (`lvl`; loop.js roundLevel: the engine's level rule reads it) and never
// passes a town of the other faction, for every faction it is for. Catches a hand edit or a generator
// change that sends a player at creatures 2+ levels above them.
test('every gathering loop names the strongest creature along its walk and keeps clear of the other faction\'s towns', { skip: hasData ? false : 'data/forever not built' }, () => {
	const { context, zoneName } = require('../tools/lib/professions/gathering/common');
	const { roundLevel } = require('../tools/lib/professions/gathering/loop');
	const ctx = context(DATA);
	const byName = Object.fromEntries(Object.keys(T.ZONES).map((id) => [zoneName(ctx, Number(id)), Number(id)]));
	const bad = [];
	let loops = 0;
	for (const file of ['herbalism.guide', 'mining.guide', 'skinning.guide']) {
		for (const line of fs.readFileSync(path.join(ROOT, 'guides', 'forever', 'professions', file), 'utf8').split('\n')) {
			const m = line.match(/^ {2}loop (.+?) lvl (\d+) .*?(?: only (Alliance|Horde))?( live)? r \d+ at (.+)$/);
			if (!m) continue;
			loops++;
			const zone = byName[m[1]];
			assert.ok(zone, `${file}: unknown zone in ${line}`);
			const stops = m[5].split(' ').map((p) => ({ pt: ctx.project.point(zone, ...p.split(',').map(Number), m[4] ? 'l' : 'e') }));
			for (const f of m[3] ? [m[3]] : ['Alliance', 'Horde']) {
				const need = roundLevel(ctx, zone, stops, f);
				if (need === null || need + 1 > Number(m[2])) bad.push(`${file} ${m[1]} (${f}): lvl ${m[2]}, the walk has ${need === null ? 'a town of the other faction' : `level ${need + 1}`}`);
			}
		}
	}
	assert.ok(loops > 80, `${loops} loops`);
	assert.deepEqual(bad, []);
});

test('the gathering loops as data for the crafting guides: one entry per loop and item it gives', { skip: hasData ? false : 'data/forever not built' }, () => {
	const { gatherLoops } = require('../tools/lib/professions/gathering/build');
	const { context } = require('../tools/lib/professions/gathering/common');
	const loops = gatherLoops(context(DATA));
	const keys = ['item', 'kind', 'skill', 'factions', 'map', 'lvl', 'lap', 'yield', 'r', 'live', 'pts'];
	for (const l of loops) assert.deepEqual(Object.keys(l), keys);
	assert.deepEqual([...new Set(loops.map((l) => l.kind))].sort(), ['herb', 'hide', 'ore']);
	// Briarthorn (2450) comes from loops that start at 70 or later (#2892).
	const briar = loops.filter((l) => l.item === 2450);
	assert.ok(briar.length > 0 && briar.every((l) => l.skill[0] >= 70), JSON.stringify(briar.map((l) => l.skill)));
	for (const l of loops) assert.ok(l.pts.length >= 2 && l.yield > 0 && l.lap > 0 && l.lvl >= 1, JSON.stringify(l));
});
