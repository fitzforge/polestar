'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const syn = require('./fixtures/sim/synthetic');
const { buildWorld, BUILDER_VERSION } = require('../tools/lib/sim/world');
const { buildAreas } = require('../tools/lib/sim/areas');

const w = () => { const x = buildWorld(syn.makeData(), { faction: 'Horde', bandWidth: 5, extraStarts: syn.START }); x.questXp = syn.questXpRows(); return x; };

// Every area's members share its region and lie within its span of each other.
const checkSpans = (W, areas, span, hubSpan) => {
	const P = W.points;
	for (const ar of areas) {
		const lim = ar.hub ? hubSpan : span;
		for (const m of ar.members) {
			assert.equal(P[m][1], ar.region, `area ${ar.id} member ${m} region`);
			for (const n of ar.members) assert.ok(Math.hypot(P[m][2] - P[n][2], P[m][3] - P[n][3]) <= lim + 1e-6, `area ${ar.id}: ${m}-${n} beyond ${lim}`);
		}
	}
};

const checkCover = (W, pointArea) => {
	for (const q of W.quests) {
		assert.ok(pointArea[q.giver] >= 0, `giver of ${q.id}`);
		assert.ok(pointArea[q.ender] >= 0, `ender of ${q.id}`);
		for (const o of q.objs || []) for (const c of o.camps) assert.ok(pointArea[W.camps[c].pt] >= 0, `camp ${c} of ${q.id}`);
	}
};

test('areas cover every giver, ender and camp; same world gives the same areas', () => {
	const a = buildAreas(w());
	const b = buildAreas(w());
	assert.deepEqual(a.areas.map((x) => x.members), b.areas.map((x) => x.members));
	assert.deepEqual([...a.pointArea], [...b.pointArea]);
	const W = w();
	const r = buildAreas(W);
	checkCover(W, r.pointArea);
});

test('no area spans more than its limit; areas never cross regions', () => {
	const W = w();
	const r = buildAreas(W, { span: 250, hubSpan: 400 });
	checkSpans(W, r.areas, 250, 400);
});

test('a small span splits places a large one keeps together', () => {
	const W = w();
	const tight = buildAreas(W, { span: 1, hubSpan: 1 });
	const loose = buildAreas(W, { span: 250, hubSpan: 400 });
	checkSpans(W, tight.areas, 1, 1);
	assert.ok(tight.areas.length > loose.areas.length, `${tight.areas.length} > ${loose.areas.length}`);
});

test('hub areas reach hubSpan/2 from the hub; other areas are at most span across; regions apart', () => {
	// points: [c, region, wx, wy, map, z]
	const points = [
		[1, 10, 0, 0, 1, null], // 0 hub centre (not a member)
		[1, 10, 190, 0, 1, null], // 1 giver, joins the hub (190 <= 200)
		[1, 10, -190, 0, 1, null], // 2 ender, joins the hub (380 apart, <= 400)
		[1, 10, 1000, 0, 1, null], // 3 camp, new area
		[1, 10, 1120, 0, 1, null], // 4 service, joins 3 (120 <= 250)
		[1, 10, 1260, 0, 1, null], // 5 node, 140 from 4 but 260 from 3: new area
		[1, 20, 1000, 0, 1, null], // 6 giver on another region: its own area
		[1, 10, 5000, 0, 1, null], // 7 not a member of anything
	];
	const W = {
		points,
		hubs: [{ pt: 0, fp: 0, inn: -1 }],
		quests: [{ giver: 1, ender: 2, objs: [{ camps: [0] }], tasks: [] }, { giver: 6, ender: 6, tasks: [] }],
		camps: [{ pt: 3 }],
		serviceSet: { 4: ['repair'] },
		nodes: [{ pt: 5, kind: 'fp' }],
	};
	const r = buildAreas(W);
	assert.deepEqual(r.areas.map((a) => [a.hub, a.region, a.members]), [[true, 10, [1, 2]], [false, 10, [3, 4]], [false, 10, [5]], [false, 20, [6]]]);
	assert.deepEqual([...r.pointArea], [-1, 0, 0, 1, 1, 2, 3, -1]);
	assert.deepEqual(r.areas[1].kinds, { giver: 0, ender: 0, camp: 1, service: 1, node: 0, task: 0 });
	// Without the flight master the hub needs 3 givers: 1 and 2 are 380 apart, two areas.
	W.hubs[0].fp = -1;
	assert.deepEqual(buildAreas(W).areas.map((a) => a.members), [[1], [2], [3, 4], [5], [6]]);
	// Three givers in the hub make it a hub area again.
	W.quests.push({ giver: 1, ender: 1, hubGiver: 0, tasks: [] }, { giver: 2, ender: 2, hubGiver: 0, tasks: [] });
	assert.equal(buildAreas(W).areas[0].hub, false);
	W.quests.push({ giver: 4, ender: 4, hubGiver: 0, tasks: [] });
	assert.deepEqual(buildAreas(W).areas[0], { id: 0, pt: 1, c: 1, region: 10, members: [1, 2], hub: true, kinds: { giver: 2, ender: 2, camp: 0, service: 0, node: 0, task: 0 } });
});

test('hub seeds closer than hubSpan/2 merge into the one with more givers (lower index on a tie)', () => {
	const points = [
		[1, 10, 0, 0, 1, null], // 0 hub 0 centre
		[1, 10, 150, 0, 1, null], // 1 hub 1 centre, 150 yd away
		[1, 10, 160, 0, 1, null], // 2 giver (hub 1)
		[1, 10, 140, 10, 1, null], // 3 giver (hub 1)
		[1, 10, 150, -10, 1, null], // 4 giver (hub 1)
		[1, 10, -10, 0, 1, null], // 5 giver (hub 0)
		[1, 10, -5, 0, 1, null], // 6 flight master, owned by hub 0 (the nearer hub listing it)
		[1, 10, 330, 0, 1, null], // 7 giver of no hub: 180 yd from hub 1, 330 from hub 0
	];
	const q = (giver, hubGiver) => ({ giver, ender: giver, hubGiver, tasks: [] });
	const W = {
		points,
		hubs: [{ pt: 0, fp: 0, inn: -1 }, { pt: 1, fp: 0, inn: -1 }],
		quests: [q(2, 1), q(3, 1), q(4, 1), q(5, 0), q(7, -1)],
		camps: [],
		serviceSet: {},
		nodes: [{ pt: 6, kind: 'fp' }],
	};
	// Both qualify (hub 0 owns the flight master, hub 1 has 3 givers); hub 1 has more givers.
	assert.deepEqual(buildAreas(W).areas.map((a) => [a.hub, a.members]), [[true, [2, 3, 4, 5, 6, 7]]]);
	// 3 givers each: hub 0 (lower index) is kept, and 7 is beyond its reach.
	W.quests.push(q(0, 0), q(6, 0));
	assert.deepEqual(buildAreas(W).areas.map((a) => [a.hub, a.members]), [[true, [0, 2, 3, 4, 5, 6]], [false, [7]]]);
	// A hub that lists a flight master another hub is nearer to does not own it.
	const far = {
		points: [[1, 10, 0, 0, 1, null], [1, 10, 1000, 0, 1, null], [1, 10, 10, 0, 1, null], [1, 10, 1010, 0, 1, null]],
		hubs: [{ pt: 0, fp: 0, inn: -1 }, { pt: 1, fp: 0, inn: -1 }],
		quests: [q(2, 0)],
		camps: [],
		serviceSet: {},
		nodes: [{ pt: 3, kind: 'fp' }],
	};
	assert.deepEqual(buildAreas(far).areas.map((a) => [a.hub, a.members]), [[true, [3]], [false, [2]]]);
	// An inn makes its owner a hub too.
	far.inns = [{ name: 'inn', pt: 2 }];
	far.hubs[0].inn = 0;
	assert.deepEqual(buildAreas(far).areas.map((a) => [a.hub, a.members]), [[true, [2]], [true, [3]]]);
});

test('towns first: a town vendor 120 yd out joins the hub, not a lower-index area 210 yd out', () => {
	const W = {
		points: [
			[1, 10, 210, 0, 1, null], // 0 camp, beyond the hub: its own area
			[1, 10, 0, 0, 1, null], // 1 hub centre, the flight master
			[1, 10, 120, 0, 1, null], // 2 vendor, 90 yd from the camp but in town
		],
		hubs: [{ pt: 1, fp: 0, inn: -1 }],
		quests: [{ giver: 1, ender: 1, objs: [{ camps: [0] }], tasks: [] }],
		camps: [{ pt: 0 }],
		serviceSet: { 2: ['food'] },
		nodes: [{ pt: 1, kind: 'fp' }],
	};
	const r = buildAreas(W);
	assert.deepEqual(r.areas.map((a) => [a.hub, a.members]), [[true, [1, 2]], [false, [0]]]);
	assert.deepEqual([...r.pointArea], [1, 0, 0]);
});

test('areas: ids in order, pt is a member, pointArea agrees with members, kinds count members', () => {
	const W = w();
	const r = buildAreas(W);
	assert.ok(r.pointArea instanceof Int32Array);
	assert.equal(r.pointArea.length, W.points.length);
	let members = 0;
	r.areas.forEach((ar, i) => {
		assert.equal(ar.id, i);
		assert.ok(ar.members.includes(ar.pt));
		assert.equal(ar.c, W.points[ar.pt][0]);
		assert.deepEqual(ar.members, ar.members.slice().sort((x, y) => x - y));
		for (const m of ar.members) assert.equal(r.pointArea[m], i);
		members += ar.members.length;
		const k = ar.kinds;
		for (const key of ['giver', 'ender', 'camp', 'service', 'node']) assert.equal(typeof k[key], 'number');
		assert.ok(k.giver + k.ender + k.camp + k.service + k.node + k.task >= ar.members.length);
	});
	assert.equal(members, [...r.pointArea].filter((x) => x >= 0).length);
	// Service and node points are members too.
	for (const pt of Object.keys(W.serviceSet).map(Number)) assert.ok(r.pointArea[pt] >= 0, `service ${pt}`);
	for (const n of W.nodes) assert.ok(r.pointArea[n.pt] >= 0, `node ${n.name}`);
});

test('the built world carries its areas and a plain pointArea', () => {
	const W = w();
	assert.ok(Array.isArray(W.areas) && W.areas.length > 0);
	assert.ok(Array.isArray(W.pointArea));
	assert.equal(W.pointArea.length, W.points.length);
	assert.deepEqual(W.areas, buildAreas(W).areas);
	assert.deepEqual(W.pointArea, [...buildAreas(W).pointArea]);
});

// Real worlds (POLESTAR_SIM_DIR, default data/sim): skipped only when there is no world.
const REAL_SIM = process.env.POLESTAR_SIM_DIR || path.join(__dirname, '..', 'data', 'sim');
for (const faction of ['horde', 'alliance']) {
	const file = path.join(REAL_SIM, `world-${faction}.json`);
	test(`real ${faction} world: every giver, ender and camp has an area; no area beyond its span`, { skip: !fs.existsSync(file) && `no ${file}` }, () => {
		const W = JSON.parse(fs.readFileSync(file, 'utf8'));
		assert.ok((W.builderVersion || 0) >= BUILDER_VERSION, `${file} is from builder ${W.builderVersion || `< ${BUILDER_VERSION}`}: rebuild with \`sim world --rebuild\``);
		assert.ok(Array.isArray(W.areas) && Array.isArray(W.pointArea), `${file} has no areas: rebuild with \`sim world --rebuild\``);
		checkCover(W, W.pointArea);
		checkSpans(W, W.areas, 250, 400);
	});
}
