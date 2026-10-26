'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const syn = require('./fixtures/sim/synthetic');
const { DATA, needs } = require('./helpers/data');
const { buildWorld, pointKey } = require('../tools/lib/sim/world');

function worldWith(data) {
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	w.questXp = syn.questXpRows();
	return w;
}

test('points take z from spawnz near the site; without a height z is null', () => {
	const data = syn.makeData();
	const w0 = worldWith(data);
	const q0 = w0.quests[0];
	const giverId = data.quests[q0.id].start.npc[0];
	// spawnz map ids are instance maps (0 Eastern Kingdoms, 1 Kalimdor), the
	// same numbers as the world's continent id c, so plant the height at c.
	const [c, , wx, wy] = w0.points[q0.giver];
	data.spawnz = { npc: { [giverId]: [[c, wx + 3, wy - 2, 55.5, 300]] }, object: {} };
	const w = worldWith(data);
	assert.equal(w.points[w.quests[0].giver][5], 55.5);
	const other = w.quests.find((q) => w.points[q.ender][2] !== w.points[q.giver][2] && data.quests[q.id] && data.quests[q.id].end.npc[0] !== giverId);
	if (other) assert.equal(w.points[other.ender][5], null);
});

// opts.floor (getWorld: the walking grid's, gridFloor): a point without a spawn's height takes the
// floor's, asked with the height of the entity's nearest spawn within 70 yd as the hint.
test('a point without a spawn height takes the walking floor\'s, hinted by a spawn within 70 yd', () => {
	const data = syn.makeData();
	const w0 = worldWith(data);
	const q0 = w0.quests[0];
	const giverId = data.quests[q0.id].start.npc[0];
	const [c, , wx, wy] = w0.points[q0.giver];
	// The giver's spawn 40 yd off (no height of its own: over 15 yd), a flight master 30 yd from its node.
	data.spawnz = { npc: { [giverId]: [[c, wx + 40, wy, 80, 300]], 77: [[1, 530, 500, 12, 300]] }, object: {} };
	data.travel.taxi.nodes.push({ id: 900, name: 'Test Roost', c: 1, wx: 500, wy: 500, map: syn.VALE, faction: 2, npc: 77 });
	const asked = [];
	const floor = (fc, fx, fy, hint) => {
		asked.push(hint);
		return { z: hint == null ? 7 : hint + 0.5, floors: hint == null ? 1 : 2 };
	};
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, floor });
	assert.equal(w.points[w.quests[0].giver][5], 80.5, 'the floor nearest the giver\'s spawn 40 yd off');
	assert.equal(w.points[w.nodes.find((n) => n.kind === 'fp').pt][5], 12.5, 'the flight master\'s height picks the node\'s floor');
	assert.ok(w.points.every((p) => p[5] != null), 'every point has a height');
	assert.ok(asked.includes(null));
	assert.equal(w.heights.hinted, 2);
	assert.equal(w.heights.source + w.heights.floor + w.heights.hinted + w.heights.ambiguous + w.heights.none, w.points.length);
	// A spawn's own height stays the point's (within 15 yd); without a floor the point has none.
	data.spawnz.npc[giverId] = [[c, wx + 3, wy, 55.5, 300]];
	const own = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, floor });
	assert.equal(own.points[own.quests[0].giver][5], 55.5);
	const bare = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	assert.equal(bare.points[bare.nodes.find((n) => n.kind === 'fp').pt][5], null);
	assert.equal(bare.heights.none, bare.points.filter((p) => p[5] == null).length);
});

// gridFloor on a stand-in grid: one column, terrain at 0, a storey at 20 (and 21.5, the same
// storey), a blocked surface at 35 and a roof at 50 too small a region to snap to.
test('gridFloor: snap\'s column, its storeys, and the storey nearest the hint', () => {
	const { gridFloor } = require('../tools/lib/sim/world');
	const { FLAG } = require('../tools/lib/nav/grid/format');
	const zs = [0, 20, 21.5, 35, 50];
	const t = { first: new Uint32Array(256 * 256 + 1).fill(zs.length), z: Float32Array.from(zs), flags: Uint8Array.from([FLAG.TERRAIN, FLAG.WMO, FLAG.WMO, FLAG.BLOCKED, FLAG.WMO]) };
	t.first[0] = 0;
	const nav = {
		snap: ({ z }) => (z == null ? { z: 0, tile: { col: 3, row: 4 }, cell: { i: 0, j: 0 } } : null),
		tile: (c, col, row) => (col === 3 && row === 4 ? t : null),
		isOpen: () => true,
		regionSize: (c, col, row, e) => (e === 4 ? 10 : null),
	};
	const floor = gridFloor(nav);
	assert.deepEqual(floor(0, 1, 2), { z: 0, floors: 2 });
	assert.deepEqual(floor(0, 1, 2, 18), { z: 20, floors: 2 });
	assert.deepEqual(floor(0, 1, 2, 60), { z: 21.5, floors: 2 }, 'not the roof nor the blocked surface');
	assert.equal(gridFloor({ snap: () => null })(0, 1, 2, 5), null);
});

test('the world hash reads the walking grid (index and tile files)', () => {
	const { dataHash } = require('../tools/lib/sim/world');
	const os = require('node:os');
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'sim-grid-'));
	const grid = path.join(dir, 'grid');
	const none = dataHash(dir, null, undefined, grid);
	fs.mkdirSync(path.join(grid, 'tiles', '1'), { recursive: true });
	fs.writeFileSync(path.join(grid, 'index.json'), '{"version":4}');
	fs.writeFileSync(path.join(grid, 'tiles', '1', '35_40.nav.gz'), 'aaaa');
	const one = dataHash(dir, null, undefined, grid);
	assert.notEqual(one, none);
	assert.equal(dataHash(dir, null, undefined, grid), one);
	fs.writeFileSync(path.join(grid, 'tiles', '1', '35_40.nav.gz'), 'aaaaa');
	assert.notEqual(dataHash(dir, null, undefined, grid), one, 'a rebuilt tile');
	fs.rmSync(dir, { recursive: true, force: true });
});

test('the world hash reads the data by content: a rebuilt meta.json keeps it, a quest edit changes it', () => {
	const { dataHash, worldInputs, changedInputs } = require('../tools/lib/sim/world');
	const os = require('node:os');
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'sim-content-'));
	const grid = path.join(dir, 'grid');
	fs.writeFileSync(path.join(dir, 'meta.json'), '{"builtAt":"2026-10-20T15:14:13.649Z"}');
	fs.writeFileSync(path.join(dir, 'quests.json'), '{"1":{"title":"A"}}');
	const base = dataHash(dir, null, undefined, grid);
	const was = worldInputs(dir, null, undefined, grid);
	// A no-op data build: the same files written again, meta.json with a new builtAt.
	fs.writeFileSync(path.join(dir, 'meta.json'), '{"builtAt":"2026-10-21T09:00:00.000Z"}');
	fs.writeFileSync(path.join(dir, 'quests.json'), '{"1":{"title":"A"}}');
	assert.equal(dataHash(dir, null, undefined, grid), base);
	// A hand edit of quests.json (same size, so not caught by a size check).
	fs.writeFileSync(path.join(dir, 'quests.json'), '{"1":{"title":"B"}}');
	assert.notEqual(dataHash(dir, null, undefined, grid), base);
	assert.deepEqual(changedInputs(was, worldInputs(dir, null, undefined, grid)), ['quests.json']);
	fs.rmSync(dir, { recursive: true, force: true });
});

// buildWorld has no clean way to put two sites of one x/y at two heights,
// so the point key is tested directly.
test('same x/y at two heights are two points; heights in one 3-yd step are one', () => {
	assert.notEqual(pointKey(0, 100.5, -20.1, 40), pointKey(0, 100.5, -20.1, 50));
	assert.equal(pointKey(0, 100.5, -20.1, 30.2), pointKey(0, 100.5, -20.1, 31));
	assert.notEqual(pointKey(0, 100.5, -20.1, null), pointKey(0, 100.5, -20.1, 0));
	assert.equal(pointKey(0, 100.5, -20.1, null), pointKey(0, 100.5, -20.1, undefined));
	const w = worldWith(syn.makeData());
	assert.ok(w.points.every((p) => p.length === 6 && p[5] === null));
});

// R22: someone recorded on both a city map and the zone around it stands in
// the city. The world exposes sites only through quests, so one Horde
// quest is pointed at Varimathras (giver) and Argent Guard Manados (ender).
test('a place on a city map belongs to the city (Undercity, Darnassus)', { skip: needs('npcs.json', 'zones.json', 'quests.json', 'map-frames.json') }, () => {
	const { loadData } = require('../tools/lib/route/model');
	const data = loadData(DATA);
	const probe = buildWorld(data, { faction: 'Horde' });
	const id = probe.quests[0].id;
	const q = data.quests[String(id)];
	data.quests[String(id)] = { ...q, start: { ...q.start, npc: [2425], object: [] }, end: { ...q.end, npc: [4784], object: [] } };
	const w = buildWorld(data, { faction: 'Horde' });
	const wq = w.quests.find((x) => x.id === id);
	assert.ok(wq, `quest ${id} still in the world`);
	assert.equal(w.points[wq.giver][4], 1458, 'Varimathras on Undercity');
	assert.equal(w.points[wq.ender][4], 1457, 'Argent Guard Manados on Darnassus');
});

test('a spawn recorded twice (within 4 yd) counts once in its site', () => {
	const data = syn.makeData();
	const w0 = worldWith(data);
	const q = w0.quests.find((x) => x.tasks.some((t) => t.work.some((wk) => wk[0] === 'kill')));
	const mobId = q.tasks.flatMap((t) => t.work).find((wk) => wk[0] === 'kill')[5];
	const mob = data.npcs[mobId];
	const [map] = Object.keys(mob.spawns);
	const before = mob.spawns[map].pts.length;
	mob.spawns[map].pts = mob.spawns[map].pts.flatMap((p) => [p, [p[0] + 0.01, p[1] + 0.01]]);
	const w = worldWith(data);
	// The mob is the target of several quests, each with its own camps: count this quest's.
	const site = (world) => world.camps
		? (world.quests.find((x) => x.id === q.id).objCamps || []).flatMap(([, ids]) => ids).map((id) => world.camps[id])
			.filter((c) => c.sources.some((s) => s.id === mobId)).reduce((n, c) => n + c.spawns, 0)
		: null;
	assert.equal(site(w), before, 'doubled spawns count once');
});

test('an item objective gets camps from every dropper, merged where their spawns meet', () => {
	const data = syn.makeData();
	const w = worldWith(data);
	const withItem = w.quests.find((q) => (q.objCamps || []).length);
	assert.ok(withItem, 'the synthetic data has an item or kill objective');
	for (const [, ids] of withItem.objCamps) {
		for (const id of ids) {
			const camp = w.camps[id];
			assert.ok(camp.spawns > 0);
			assert.ok(camp.sources.length >= 1);
			assert.ok(Number.isFinite(camp.levelMin));
		}
	}
});

test('every exclusion has a code', () => {
	const w = worldWith(syn.makeData());
	assert.ok(w.excluded.every((e) => typeof e.code === 'string' && e.code.length));
});

// R9b (#424): an item no dropper, object, vendor or hand-out provides is a
// gap in the data, not something made on the spot at the giver.
test('an item objective with no source excludes the quest (unsourced-item)', () => {
	const data = syn.makeData();
	data.items[900] = { id: 900, name: 'Nowhere Trinket', drops: { npc: {}, object: {} }, vendors: [] };
	data.quests[502] = { ...data.quests[502], objectives: [{ type: 'item', id: 900, count: 1 }] };
	const w = worldWith(data);
	const e = w.excluded.find((x) => x.id === 502);
	assert.ok(e, 'quest 502 is excluded');
	assert.equal(e.code, 'unsourced-item');
	assert.equal(e.reason, 'item objective 900 has no source');
	// The quest's own hand-out stays: made or used on the spot at the giver.
	data.quests[502] = { ...data.quests[502], sourceItem: 900 };
	assert.ok(worldWith(data).quests.some((q) => q.id === 502));
});

test('two quests whose objectives share the same mob get the same camp ids; chances sit on the objective', () => {
	const w = worldWith(syn.makeData());
	const byMob = new Map();
	for (const q of w.quests) {
		for (const [, ids, chances] of q.objCamps || []) {
			assert.ok(chances && typeof chances === 'object');
			for (const id of ids) assert.ok(w.camps[id].sources.every((s) => !('chance' in s)));
			const key = Object.keys(chances).sort().join(',');
			if (!byMob.has(key)) byMob.set(key, []);
			byMob.get(key).push(ids.join(','));
		}
	}
	const shared = [...byMob.values()].find((l) => l.length > 1);
	assert.ok(shared, 'the synthetic data has a mob two quests kill');
	assert.ok(shared.every((ids) => ids === shared[0]));
});

// R9b: an item the world doesn't place may still have a source elsewhere.
test('an item from a turninAfter parent or another quest\'s reward is sourced', () => {
	const data = syn.makeData();
	data.items[900] = { id: 900, name: 'Chapter', drops: { npc: {}, object: {} }, vendors: [] };
	data.quests[502] = { ...data.quests[502], objectives: [{ type: 'item', id: 900, count: 1 }] };
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, overrides: { turninAfter: { 502: [501] } } });
	assert.ok(w.quests.some((q) => q.id === 502), 'turninAfter parent stays');
	data.quests[501] = { ...data.quests[501], web: { items: [[900, 1]], choices: [] } };
	assert.ok(worldWith(data).quests.some((q) => q.id === 502), 'another quest\'s reward stays');
});

test('item camps leave out droppers below 1% and elites', () => {
	const data = syn.makeData();
	const shift = (dx) => Object.fromEntries(Object.entries(data.npcs[11].spawns).map(([m, s]) => [m, { ...s, pts: s.pts.map(([x, y]) => [x - dx, y]) }]));
	data.npcs[14] = { id: 14, name: 'Elite Fox', level: 4, rank: 1, faction: null, spawns: shift(5) };
	data.npcs[15] = { id: 15, name: 'Shy Fox', level: 4, faction: null, spawns: shift(10) };
	data.items[100].drops.npc = { 11: 50, 14: 50, 15: 0.5 };
	const w = worldWith(data);
	const q = w.quests.find((x) => x.id === 502);
	const [, ids, chances] = q.objCamps[0];
	assert.deepEqual(Object.keys(chances), ['npc:11']);
	for (const id of ids) assert.deepEqual(w.camps[id].sources.map((s) => s.id), [11]);
});

test('exclusions carry their codes', () => {
	const data = syn.makeData();
	const base = data.quests[501];
	data.items[900] = { id: 900, name: 'Nowhere Trinket', drops: { npc: {}, object: {} }, vendors: [] };
	data.quests[601] = { ...base, id: 601, title: 'Alliance Only', races: 1 };
	data.quests[602] = { ...base, id: 602, title: 'Smithing', skill: { id: 164, value: 1 } };
	data.quests[603] = { ...base, id: 603, title: 'Lost Giver', start: { npc: [999], object: [], item: [] } };
	data.quests[604] = { ...base, id: 604, title: 'Trinket', objectives: [{ type: 'item', id: 900, count: 1 }] };
	const w = worldWith(data);
	const code = (id) => (w.excluded.find((e) => e.id === id) || {}).code;
	assert.deepEqual([601, 602, 603, 604].map(code), ['faction', 'profession', 'no-giver', 'unsourced-item']);
	assert.ok(w.excluded.every((e) => typeof e.code === 'string' && e.code.length));
});

const { buildCamps } = require('../tools/lib/sim/camps');
function campsOf(spawns) {
	const out = [];
	const ids = buildCamps({
		sources: [{ kind: 'npc', id: 1 }],
		spawnsOf: () => spawns.map(([wx, wy]) => ({ c: 1, region: 0, wx, wy, map: 1 })),
		levelOf: () => 5, respawnOf: () => 300,
		addCamp: (c) => out.push(c) - 1,
		pointAt: (kind, id, s) => `${s.wx},${s.wy}`,
	});
	return ids.map((i) => out[i]);
}

test('buildCamps: spawns chain at 80 yd, not beyond', () => {
	const chain = (x0) => [0, 30, 60].map((d) => [x0 + d, 0]);
	assert.equal(campsOf([...chain(0), ...chain(60 + 79)]).length, 1);
	assert.equal(campsOf([...chain(0), ...chain(60 + 81)]).length, 2);
});

test('buildCamps: a 400 yd line splits under the 350 yd cap; pt is a member spawn', () => {
	const line = Array.from({ length: 21 }, (_, i) => [i * 20, 0]);
	const camps = campsOf(line);
	assert.ok(camps.length >= 2);
	assert.equal(camps.reduce((n, c) => n + c.spawns, 0), 21);
	const members = new Set(line.map(([x, y]) => `${x},${y}`));
	for (const c of camps) assert.ok(members.has(c.pt));
});

const { pickServices, serviceSetOf } = require('../tools/lib/sim/services');

test('services pick friendly NPCs by role, subName and trainer class', () => {
	const npcs = {
		1: { id: 1, faction: 'H', roles: ['repair', 'vendor'], subName: 'Blacksmith' },
		2: { id: 2, faction: 'H', roles: ['vendor'], subName: 'Food & Drink' },
		3: { id: 3, faction: 'A', roles: ['repair'] },
		4: { id: 4, faction: 'H', roles: ['vendor'], subName: 'Bowyer' },
		5: { id: 5, faction: 'AH', roles: ['innkeeper'] },
		6: { id: 6, faction: 'H', roles: ['trainer'] },
	};
	const trainers = { 6: { id: 6, classes: ['WARRIOR'] } };
	const sitesOf = (kind, id) => ({ sites: [{ pt: 100 + Number(id) }] });
	const friendlyTo = (fac) => fac == null || fac === 'AH' || fac === 'H';
	const s = pickServices({ npcs, trainers, faction: 'Horde', sitesOf, friendly: friendlyTo });
	const at = (list) => list.map((s) => [s.pt, s.npc]);
	assert.deepEqual(at(s.repair), [[101, 1]]);
	assert.deepEqual(at(s.food), [[102, 2]]);
	assert.deepEqual(at(s.ammo), [[104, 4]]);
	assert.deepEqual(at(s.inn), [[105, 5]]);
	assert.deepEqual(at(s.trainer.WARRIOR), [[106, 6]]);
	assert.equal(s.flight, undefined, 'flights come from the flight nodes');
	assert.deepEqual(serviceSetOf({ ...s, flight: [{ pt: 101, npc: 9 }] })[101].sort(), ['flight', 'repair']);
	assert.deepEqual(serviceSetOf(s)[106], ['trainer:WARRIOR']);
});

test('lifts and portals from travel data become rides between their two ends', () => {
	const data = syn.makeRulesData ? syn.makeRulesData() : syn.makeData();
	data.travel.transit = {
		services: { 'lift-test': { kind: 'lift', c: 1, wx: 100, wy: 100, map: syn.VALE, bottom: 10, top: 60, ride: { a: 10, b: 10 }, wait: { a: 12, b: 12 } } },
		portals: [
			{ id: 'portal-test', a: { c: 1, wx: 0, wy: 0, map: syn.VALE }, b: { c: 1, wx: 300, wy: 300, map: syn.VALE }, seconds: 5 },
			{ id: 'portal-far', a: { c: 1, wx: 0, wy: 0, map: syn.VALE }, b: { c: 1, wx: 5000, wy: 5000, map: syn.VALE }, seconds: 5 },
		],
	};
	// A Horde flight master near the first portal's ends; the second's arrival is 7,000 yd away.
	data.travel.taxi.nodes.push({ id: 900, name: 'Test Roost', c: 1, wx: 500, wy: 500, map: syn.VALE, faction: 2, npc: 77 });
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	const lift = w.rides.filter((r) => r[4] === 'lift-test');
	assert.equal(lift.length, 2);
	const [a, b] = [w.nodes[lift[0][0]].pt, w.nodes[lift[0][1]].pt];
	assert.deepEqual([w.points[a][5], w.points[b][5]].sort((x, y) => x - y), [10, 60]);
	assert.ok(w.rides.some((r) => r[4] === 'portal-test' && r[2] === 5));
	assert.ok(!w.rides.some((r) => r[4] === 'portal-far'), 'a portal with an end far from the faction\'s nodes and inns is dropped');
	const fp = w.nodes.find((n) => n.kind === 'fp');
	assert.deepEqual(w.services.flight, [{ pt: fp.pt, npc: 77 }]);
	assert.deepEqual(w.serviceSet[fp.pt], ['flight']);
});

test('a lift without a map takes the zone map its spawns vote for; the tram adds its boarding time', () => {
	const data = syn.makeData();
	data.travel.transit = {
		services: {
			'lift-nomap': { kind: 'lift', c: 1, wx: 500, wy: -500, bottom: 0, top: 30, ride: { a: 4, b: 4 }, wait: { a: 1, b: 1 } },
			'tram-test': { kind: 'tram', pre: 15, post: 15 },
		},
	};
	data.travel.transports.push({ id: 'tram-test', kind: 'tram', faction: 3, a: { name: 'A', c: 1, wx: 900, wy: -100, map: syn.VALE }, b: { name: 'B', c: 1, wx: 100, wy: -900, map: syn.VALE }, ab: 70, ba: 70, waitA: 60, waitB: 60 });
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	const lift = w.rides.filter((r) => r[4] === 'lift-nomap');
	assert.equal(lift.length, 2);
	assert.equal(w.points[w.nodes[lift[0][0]].pt][4], syn.VALE);
	assert.equal(w.nodes[lift[0][0]].kind, 'lift');
	assert.deepEqual(w.rides.filter((r) => r[4] === 'tram-test').map((r) => r[2]), [100, 100]);
});

// A city's lift: the city is the busier floor, the other end the zone around
// the shaft, even when the quiet floor's spawns are recorded on the city's map
// (the Ruins above the Undercity).
test('a city lift\'s busier floor is the city, the other end the zone around it', () => {
	const data = syn.makeData();
	data.zones[syn.VALE].areaId = 777;
	// The shaft on the Testvale/Farfield line: city folk on top (z 100), one
	// guard below (z 0), both on the city's map; Farfield's striders nearby
	// have no recorded height.
	data.npcs[30] = { id: 30, name: 'City Guard', level: 30, faction: 'H', spawns: { [syn.VALE]: { f: 'e', pts: [[99, 50], [99.5, 50]] } } };
	data.npcs[31] = { id: 31, name: 'Plains Strider', level: 5, faction: null, spawns: { [syn.FIELD]: { f: 'e', pts: [[1, 50], [2, 50]] } } };
	data.spawnz = { npc: { 30: [[1, 500, -990, 100, 300], [1, 505, -990, 101, 300], [1, 495, -990, 99, 300], [1, 500, -995, 0, 300]] }, object: {} };
	data.travel.transit = { services: { 'lift-city': { kind: 'lift', area: 777, c: 1, wx: 500, wy: -1000, bottom: 0, top: 100, ride: { a: 10, b: 10 }, wait: { a: 5, b: 5 } } } };
	const w = worldWith(data);
	const end = (which) => w.points[w.nodes.find((n) => n.name === `lift-city (${which})`).pt][4];
	assert.equal(end('top'), syn.VALE);
	assert.equal(end('bottom'), syn.FIELD);
	assert.ok(!w.warnings.some((x) => x.startsWith('lift ')));
	// The check table expects the Undercity's city below: a busier top floor is warned about.
	data.travel.transit.services['lift-undercity-east'] = data.travel.transit.services['lift-city'];
	delete data.travel.transit.services['lift-city'];
	assert.ok(worldWith(data).warnings.some((x) => x.startsWith('lift lift-undercity-east: the city') && x.includes('bottom end')));
});

test('objs carry type, item, count, camps and chances; two quests on one item from one mob share the camp', () => {
	const data = syn.makeData();
	// Two synthetic quests needing the same item from the same mob (Fox Pelt, from the Pelt Fox camp).
	const item = Object.values(data.items)[0];
	const [q1, q2] = Object.values(data.quests).slice(0, 2);
	for (const q of [q1, q2]) q.objectives = [{ type: 'item', id: item.id, count: 3, text: item.name }];
	const w = worldWith(data);
	const a = w.quests.find((q) => q.id === q1.id);
	const b = w.quests.find((q) => q.id === q2.id);
	assert.ok(a && b, 'both quests stay in the world');
	assert.equal(a.objs[0].type, 'item');
	assert.equal(a.objs[0].item, item.id);
	assert.equal(a.objs[0].count, 3);
	assert.equal(a.objs[0].oi, 0);
	assert.equal(a.objs[0].task, 0);
	assert.deepEqual(a.objs[0].chances, { 'npc:11': 50 });
	assert.deepEqual(a.objs[0].camps, b.objs[0].camps, 'same sources → same camps');
	assert.ok(a.objs[0].camps.length > 0);
	for (const id of a.objs[0].camps) assert.ok(w.camps[id].radius >= 0);
});

test('kill objectives: one obj per objective, chance 100, task index of its work', () => {
	const w = worldWith(syn.makeData());
	const q = w.quests.find((x) => x.id === 501);
	assert.equal(q.objs.length, 1);
	const [o] = q.objs;
	assert.deepEqual({ oi: o.oi, type: o.type, id: o.id, count: o.count, item: o.item, chances: o.chances }, { oi: 0, type: 'kill', id: 10, count: 8, item: null, chances: { 'npc:10': 100 } });
	assert.equal(q.tasks[o.task].work[0][5], 10, 'the task holds the kill');
	assert.deepEqual(o.camps, q.objCamps[0][1]);
	// A 12-spawn grid 1.5% of the map apart: the camp spans more than nothing, less than its cap.
	const camp = w.camps[o.camps[0]];
	assert.ok(camp.radius > 0 && camp.radius <= 350, `radius ${camp.radius}`);
});

test('services name their NPC; flights come from this faction\'s flight nodes', () => {
	const w = worldWith(syn.makeData());
	for (const list of [w.services.repair, w.services.inn]) for (const s of list) assert.ok(Number.isFinite(s.pt) && Number.isFinite(s.npc));
	const fpPts = new Set(w.nodes.filter((n) => n.kind === 'fp').map((n) => n.pt));
	for (const s of w.services.flight) assert.ok(fpPts.has(s.pt));
});

test('quest kinds: delivery, talk, startItem, work', () => {
	const data = syn.makeData();
	data.quests[509] = { ...data.quests[503], id: 509, title: 'Word to the Elder', end: { npc: [1], object: [] } };
	// Accepted from the Fox Pelt the Pelt Foxes drop; no objectives, turned in elsewhere: still a start item.
	data.quests[510] = { ...data.quests[503], id: 510, title: 'A Curious Pelt', start: { npc: [], object: [], item: [100] } };
	const w = worldWith(data);
	for (const q of w.quests) assert.ok(['delivery', 'talk', 'startItem', 'work'].includes(q.kind), `${q.id} ${q.kind}`);
	const kind = (id) => w.quests.find((q) => q.id === id).kind;
	assert.equal(kind(501), 'work');
	assert.equal(kind(503), 'delivery');
	assert.equal(kind(509), 'talk');
	assert.equal(kind(510), 'startItem');
});

// Escorts (dsl/escort.js isEscort, with the guides) and timed events: an
// escort or a defend event is one fixed-duration run where it starts.
test('escorts follow isEscort; defend events are timed events but not escorts', () => {
	const data = syn.makeData();
	const ev = (text) => ({ type: 'event', id: null, count: null, text, map: 99101, f: 'e', x: 60, y: 60 });
	const base = { ...data.quests[501], pre: [], next: null };
	data.quests[511] = { ...base, id: 511, title: 'Escort', objectiveText: 'Escort Testa.', objectives: [ev('Escort Testa to the road')] };
	data.quests[512] = { ...base, id: 512, title: 'Defend', objectiveText: 'Protect Testa during the attack.', objectives: [ev('Defend Testa')] };
	// Lost! (4492): its objective was copied from the escort after it.
	data.quests[513] = { ...base, id: 513, title: 'Lost', escort: false, objectiveText: 'Find Testa.', objectives: [ev('Escort Testa to the warden')] };
	// Tooga's Quest (1560): the escort ends when the NPC reaches a friendly one,
	// whose kill credit the data lists.
	data.quests[514] = { ...base, id: 514, title: 'Tooga', escort: true, objectiveText: 'Show Testa the way back.', objectives: [{ type: 'kill', id: 2, count: null, text: 'Warden Fieldy' }] };
	// The Windshaper's Wrath (96204): an escort with no objectives.
	data.quests[515] = { ...base, id: 515, title: 'Wrath', escort: true, objectiveText: 'Accompany Testa and help her escape.', objectives: [] };
	const w = worldWith(data);
	const q = (id) => w.quests.find((x) => x.id === id);
	const works = (id) => q(id).tasks.flatMap((t) => t.work.map((x) => x[0]));
	assert.deepEqual([q(511).escort, works(511)], [true, ['escort']]);
	assert.deepEqual([q(512).escort, works(512)], [false, ['escort']], 'a defend event is timed, not an escort');
	assert.deepEqual([q(513).escort, works(513)], [false, ['visit']], 'escort: false is neither');
	assert.deepEqual([511, 512, 513].map((id) => q(id).tier), [7, 7, 5], 'the XP tier counts escorts and defend events alike');
	assert.deepEqual([q(514).escort, works(514)], [true, ['escort']], 'the arrival is the escort, not a talk to the NPC');
	assert.equal(q(514).tasks[0].pt, q(514).giver, 'runs where it starts');
	assert.deepEqual(q(514).objs.map((o) => [o.oi, o.type, o.task]), [[0, 'event', 0]]);
	assert.deepEqual([q(515).escort, q(515).kind, q(515).breadcrumb, works(515)], [true, 'work', false, ['escort']]);
	assert.equal(q(515).tasks[0].pt, q(515).giver);
	assert.deepEqual(q(515).objs.map((o) => [o.oi, o.type, o.task]), [[-1, 'event', 0]], 'no raw objective: oi -1');
});

// R9b (#337, PR #457): a guide names the NPC who hands an item over in gossip
// (a `handover` rule): the item is sourced, a talk at the NPC.
test('a handover rule sources an item: a talk at the NPC who hands it over', () => {
	const data = syn.makeData();
	data.items[900] = { id: 900, name: 'Report', drops: { npc: {}, object: {} }, vendors: [] };
	data.quests[502] = { ...data.quests[502], objectives: [{ type: 'item', id: 900, count: 1 }] };
	const rule = { id: 'T1', kind: 'handover', quest: 502, objective: 0, item: 900, npc: 2, fact: 'x', source: { refs: ['#337'] } };
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, rules: [rule] });
	const q = w.quests.find((x) => x.id === 502);
	assert.ok(q, 'quest 502 stays');
	assert.deepEqual(q.objs.map((o) => [o.type, o.id, o.item, o.task]), [['talk', 2, 900, 0]]);
	assert.deepEqual(q.tasks[0].work, [['use', 1]]);
	assert.equal(w.points[q.tasks[0].pt][4], 99102, 'at the NPC\'s spawn');
});

test('a bad handover rule fails the build with its id and source', () => {
	const data = syn.makeData();
	data.items[900] = { id: 900, name: 'Report', drops: { npc: {}, object: {} }, vendors: [] };
	data.items[901] = { id: 901, name: 'Other', drops: { npc: {}, object: {} }, vendors: [] };
	data.npcs[3] = { id: 3, name: 'Nowhere Npc', level: 10, faction: 'AH', spawns: {} };
	data.quests[502] = { ...data.quests[502], objectives: [{ type: 'item', id: 900, count: 1 }] };
	const rule = { id: 'T1', kind: 'handover', quest: 502, objective: 0, item: 900, npc: 2, fact: 'x', source: { refs: ['#337'] } };
	const build = (r) => () => buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START, rules: [r] });
	assert.throws(build({ ...rule, objective: 1 }), /handover rule T1: quest 502 has no item objective 1 .*#337/);
	assert.throws(build({ ...rule, item: 901 }), /handover rule T1: quest 502 has no item objective 0 for item 901/);
	assert.throws(build({ ...rule, npc: 3 }), /handover rule T1: npc 3 has no open-world spawn/);
	assert.throws(build({ ...rule, npc: 999 }), /handover rule T1: .*npc 999 not in the world or the data/);
	assert.throws(build({ ...rule, objective: 'a' }), /handover rule T1: .*objective must be/);
});

test('the world hash reads only the handover rules\' quest, objective, item and npc', () => {
	const { dataHash } = require('../tools/lib/sim/world');
	const { FILE, loadRules } = require('../tools/lib/sim/rules');
	const dir = fs.mkdtempSync(path.join(require('node:os').tmpdir(), 'sim-hash-'));
	const write = (rules) => {
		const f = path.join(dir, `rules-${Math.random()}.json`);
		fs.writeFileSync(f, JSON.stringify({ schema: 1, rules }));
		return f;
	};
	const rules = loadRules();
	const base = dataHash(dir, null, FILE);
	const other = rules.findIndex((r) => r.kind !== 'handover');
	const hand = rules.findIndex((r) => r.kind === 'handover');
	const edit = (i, patch) => rules.map((r, k) => (k === i ? { ...r, ...patch } : r));
	assert.equal(dataHash(dir, null, write(edit(other, { fact: 'changed' }))), base, 'another kind\'s fact');
	assert.equal(dataHash(dir, null, write(edit(hand, { fact: 'changed', source: { refs: ['#1'] } }))), base, 'a handover\'s fact and source');
	assert.equal(dataHash(dir, null, write([...rules].reverse())), base, 'rule order');
	assert.notEqual(dataHash(dir, null, write(edit(hand, { npc: 1 }))), base, 'a handover\'s npc');
	fs.rmSync(dir, { recursive: true, force: true });
});

// Real worlds (POLESTAR_SIM_DIR, default the sim command's data/sim): skipped
// only when there is no world; a world from an older builder fails.
const { BUILDER_VERSION } = require('../tools/lib/sim/world');
const REAL_SIM = process.env.POLESTAR_SIM_DIR || path.join(__dirname, '..', 'data', 'sim');
const realFile = (faction) => path.join(REAL_SIM, `world-${faction}.json`);
const noWorld = (faction) => !fs.existsSync(realFile(faction)) && `no ${realFile(faction)}`;
const realWorlds = {};
const realWorld = (faction) => {
	if (realWorlds[faction]) return realWorlds[faction];
	const w = JSON.parse(fs.readFileSync(realFile(faction), 'utf8'));
	assert.ok((w.builderVersion || 0) >= BUILDER_VERSION, `${realFile(faction)} is from builder ${w.builderVersion || `< ${BUILDER_VERSION}`}: rebuild with \`sim world --rebuild\``);
	return (realWorlds[faction] = { w });
};
const liftEnds = (w, prefix) => w.nodes.filter((n) => n.kind === 'lift' && n.name.startsWith(prefix)).map((n) => [n.name.endsWith('(top)') ? 'top' : 'bottom', w.points[n.pt][4]]);

test('real Horde world: lift ends on their own maps, no Rut\'theran portal, Undead classes', { skip: needs('quests.json', 'npcs.json', 'travel.json', 'races.json') || noWorld('horde') }, () => {
	const { w } = realWorld('horde');
	const tb = liftEnds(w, 'lift-thunder-bluff');
	const uc = liftEnds(w, 'lift-undercity');
	assert.equal(tb.length, 4);
	assert.equal(uc.length, 6);
	for (const [end, map] of tb) assert.equal(map, end === 'bottom' ? 1412 : 1456, `Thunder Bluff ${end}`);
	for (const [end, map] of uc) assert.equal(map, end === 'bottom' ? 1458 : 1420, `Undercity ${end}`);
	assert.ok(!w.nodes.some((n) => n.name.startsWith('portal-ruttheran') || n.name.startsWith('portal-darnassus')));
	const races = JSON.parse(fs.readFileSync(path.join(DATA, 'races.json'), 'utf8'));
	assert.deepEqual(w.classes.Undead, races.Scourge.Horde.classes);
	assert.equal(w.classes.Scourge, undefined);
	const fpNpcs = new Set(w.services.flight.map((s) => s.npc));
	assert.ok(!fpNpcs.has(11798) && !fpNpcs.has(11800), 'no Moonglade druid flight masters');
	assert.equal(w.services.flight.length, w.nodes.filter((n) => n.kind === 'fp').length);
});

test('real Alliance world keeps the Darnassus portals', { skip: needs('travel.json') || noWorld('alliance') }, () => {
	const { w } = realWorld('alliance');
	assert.ok(w.nodes.some((n) => n.name === 'portal-ruttheran'));
	assert.ok(w.nodes.some((n) => n.name === 'portal-darnassus'));
});

test('real worlds: escorts and timed events (4492 neither, 1560 and 96204 escorts, 667 timed)', { skip: needs('quests.json') || noWorld('horde') || noWorld('alliance') }, () => {
	const h = realWorld('horde').w;
	const a = realWorld('alliance').w;
	const q = (w, id) => w.quests.find((x) => x.id === id);
	const works = (w, id) => q(w, id).tasks.flatMap((t) => t.work.map((x) => x[0]));
	for (const w of [h, a]) {
		assert.deepEqual([q(w, 4492).escort, works(w, 4492).includes('escort')], [false, false], 'Lost! is no escort');
		assert.deepEqual([q(w, 1560).escort, works(w, 1560)], [true, ['escort']], 'Tooga: the arrival, not a kill or a talk');
		assert.deepEqual([q(w, 667).escort, works(w, 667), q(w, 667).tier], [false, ['escort'], 7], 'Death From Below is timed, XP tier 7');
	}
	assert.deepEqual([q(h, 96204).escort, works(h, 96204), q(h, 96204).objs.map((o) => o.oi)], [true, ['escort'], [-1]]);
	assert.deepEqual(q(a, 87491).objs.map((o) => o.oi), [-1]);
});

test('real Horde world: Patience (99141) is three talks to the NPCs who hand the reports over', { skip: needs('quests.json') || noWorld('horde') }, () => {
	const { w } = realWorld('horde');
	const q = w.quests.find((x) => x.id === 99141);
	assert.ok(q, '99141 is in the world');
	assert.deepEqual(q.objs.map((o) => [o.type, o.id, o.item]), [['talk', 1496, 286200], ['talk', 251001, 286201], ['talk', 10666, 286202]]);
	assert.equal(new Set(q.objs.map((o) => o.task)).size, 3);
	for (const t of q.tasks) assert.deepEqual(t.work, [['use', 1]]);
});

// data build keeps at most 24 spawns a map in `pts` (spread apart) and the
// rest in `more`: a camp counts them all (52 termite mounds, not 24).
test('an entity with more than 24 spawns gives all of them to its camps (pts and more)', () => {
	const data = syn.makeData();
	const rat = data.npcs[10].spawns[99101];
	const all = [];
	for (let i = 0; i < 30; i++) all.push([20 + (i % 6) * 1.5, 20 + Math.floor(i / 6) * 1.5]);
	rat.pts = all.slice(0, 24);
	rat.more = all.slice(24);
	const w = worldWith(data);
	const q = w.quests.find((x) => x.id === 501);
	const o = q.objs.find((x) => x.type === 'kill');
	assert.equal(o.camps.reduce((n, id) => n + w.camps[id].spawns, 0), 30);
});

// CMaNGOS classic-db's gameobject facts: a termite mound (a chest, 1-20
// termites a loot at 100 %) and a tide pool (a spell focus: used, not looted).
test('object sources take the classic-db loot (chance × mean count) and respawn; a used object gives its item every time, with no wait', () => {
	const data = syn.makeData();
	data.objects = {
		900: { id: 900, name: 'Termite Mound', spawns: { 99101: { f: 'e', pts: [[60, 20], [61, 21]] } } },
		901: { id: 901, name: 'Tide Pool', spawns: { 99101: { f: 'e', pts: [[60, 60]] } } },
		902: { id: 902, name: 'Forever Crate', spawns: { 99101: { f: 'e', pts: [[30, 60]] } } },
	};
	data.items[910] = { id: 910, name: 'Termites', questItem: true, drops: { npc: {}, object: { 900: 100 } }, vendors: [] };
	data.items[911] = { id: 911, name: 'Vial of Pool Water', questItem: true, drops: { npc: {}, object: { 901: null } }, vendors: [] };
	data.items[912] = { id: 912, name: 'Crate Goods', questItem: true, drops: { npc: {}, object: { 902: null } }, vendors: [] };
	data.quests[502] = { ...data.quests[502], objectives: [{ type: 'item', id: 910, count: 100 }, { type: 'item', id: 911, count: 1 }, { type: 'item', id: 912, count: 4 }] };
	data.objectFacts = { 900: { type: 3, respawn: 300, loot: { 910: [-100, 1, 20] } }, 901: { type: 8, respawn: 180 } };
	const w = worldWith(data);
	const objs = w.quests.find((x) => x.id === 502).objs;
	const of = (item) => objs.find((o) => o.item === item);
	assert.equal(of(910).chances['object:900'], 1050);
	assert.equal(w.camps[of(910).camps[0]].respawn, 300);
	assert.equal(of(911).chances['object:901'], 100);
	assert.equal(w.camps[of(911).camps[0]].respawn, 1);
	// No facts (a Forever object): a quest item at 100 %, the respawn estimate.
	assert.equal(of(912).chances['object:902'], 100);
	assert.equal(w.camps[of(912).camps[0]].respawn, 180);
});

// BuildPerf: the floors a world build reads from the grid are kept in the sim
// dir (floorCache), so the next build with the same grid snaps nothing; the
// floors (and the hint's storey) are the grid's own.
test('gridFloor with floorCache: a second build reads the floors, not the grid', () => {
	const { gridFloor, floorCache } = require('../tools/lib/sim/world');
	const { tmpdir } = require('./helpers/tmp');
	let snaps = 0;
	const tile = { first: Int32Array.from([0, 2]), flags: new Uint8Array(2), z: Float32Array.from([10, 20]) };
	const nav = {
		snap: () => { snaps++; return { tile: { col: 0, row: 0 }, cell: { i: 0, j: 0 }, z: 10 }; },
		tile: () => tile,
		isOpen: () => true,
		regionSize: () => null,
	};
	const dir = tmpdir('polestar-floors-');
	const grid = path.join(dir, 'no-grid');
	const a = floorCache(dir, grid);
	const f1 = gridFloor(nav, a.map);
	assert.deepEqual(f1(1, 5, 5, null), { z: 10, floors: 2 });
	assert.deepEqual(f1(1, 5, 5, 19), { z: 20, floors: 2 }, 'the hint picks the storey nearest it');
	assert.equal(snaps, 1, 'one snap for the place, whatever the hint');
	a.save();
	const f2 = gridFloor(nav, floorCache(dir, grid).map);
	assert.deepEqual(f2(1, 5, 5, 19), { z: 20, floors: 2 });
	assert.equal(snaps, 1, 'the next build reads the floor from the cache');
	assert.equal(gridFloor(nav)(1, 5, 5, null).z, 10, 'without a cache: the grid');
});

// Riding (RouteLessons 7, PR #522): a friendly riding trainer's site is a
// riding stop, with the mount vendor standing by it and its mount (an
// optional buy); the world carries the skill's level and copper. A trainer
// with no vendor near is a stop without one.
test('riding: a trainer\'s site is a riding stop, with the mount vendor beside it', () => {
	const data = syn.makeData();
	const at = (x, y) => ({ [syn.VALE]: { f: 'e', pts: [[x, y]] } });
	data.npcs[90] = { id: 90, name: 'Kildar', level: 50, faction: 'H', spawns: at(40, 40) };
	data.npcs[91] = { id: 91, name: 'Ogunaro', level: 30, faction: 'H', spawns: at(40.2, 40.2) };
	data.npcs[92] = { id: 92, name: 'Far Trainer', level: 50, faction: 'H', spawns: at(90, 10) };
	data.training = { classes: {}, riding: { level: 40, cost: 1000000, trainers: [{ id: 90, races: 2 }, { id: 92, races: 0 }], vendors: { 91: [200000, 5665] } } };
	const w = buildWorld(data, { faction: 'Horde', bandWidth: 5, extraStarts: syn.START });
	assert.deepEqual(w.riding, { level: 40, cost: 1000000 });
	const stops = w.services.riding.map((r) => [r.npc, r.races, r.vendor, r.item, r.itemCopper]);
	assert.deepEqual(stops.sort((a, b) => a[0] - b[0]), [[90, 2, 91, 5665, 200000], [92, 0, undefined, undefined, undefined]]);
	assert.ok(w.serviceSet[w.services.riding[0].pt].includes('riding'));
	assert.equal(buildWorld(syn.makeData(), { faction: 'Horde', bandWidth: 5, extraStarts: syn.START }).riding, null, 'no riding data: none');
});
