'use strict';
// Connected spawn areas share target names without joining separate camps (#1869, #1616).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { Data } = require('../tools/lib/dsl/data');
const { fixtureData, guideText, compile, plain } = require('./helpers/dsl');

const ITEM = 95930;
const A = 95931;
const B = 95932;
const C = 95933;
const pair = (x, y = 20) => [[x, y], [x + 0.1, y]];

function sourceData(sources, objects = {}) {
	const base = fixtureData();
	const npcs = { ...base.npcs };
	for (const [id, rec] of Object.entries(sources)) {
		npcs[id] = { id: Number(id), name: `Source ${id}`, level: 5, faction: null, ...rec };
	}
	return new Data({
		quests: base.quests, npcs, objects: { ...base.objects, ...objects },
		items: { ...base.items, [ITEM]: {
			id: ITEM, name: 'Area Token', vendors: [],
			drops: { npc: Object.fromEntries(Object.keys(sources).map((id) => [id, 80])), object: Object.fromEntries(Object.keys(objects).map((id) => [id, 80])) },
		} },
		zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta,
	}, { dir: base.dir });
}

const spawn = (pts, extra = {}) => ({ spawns: { 1429: { f: 'e', pts } }, ...extra });

function collect(data, pin = '@20,20') {
	const r = compile(guideText(['step One', `  collect ${ITEM} x1 ${pin}`]), data);
	assert.deepEqual(r.errors, [], r.text);
	return plain(r.guides[0].steps)[0].goals[0];
}

function targets(goal) {
	assert.equal(typeof goal.fromNpcsAt, 'string', 'the goal carries per-spot target names');
	const groups = goal.fromNpcsAt.split(';').map((row) => row ? row.split(',').map((k) => goal.fromNpcs[Number(k) - 1].npc) : []);
	assert.equal(groups.length, goal.spots.length);
	return groups;
}

test('small, transitively connected spawn areas name a source beyond every marker circle', () => {
	// Adjacent kinds are 209 yd apart; the last is 417 yd from the pin. Its
	// spawns are outside the hand pin's 250 yd alternatives as well as its circle.
	const data = sourceData({ [A]: spawn(pair(20)), [B]: spawn(pair(26)), [C]: spawn(pair(32)) });
	const goal = collect(data);
	assert.deepEqual(goal.spots, [
		{ x: 20, y: 20, r: 19, n: 2 },
		{ x: 26.1, y: 20, r: 15, n: 2, alt: true },
	]);
	assert.deepEqual(goal.fromNpcs.map((n) => n.npc), [A, B, C]);
	assert.deepEqual(targets(goal), [[A, B, C], [B, A, C]], 'local targets stay first, then the connected area');
	assert.equal(collect(data, '').fromNpcsAt, undefined, 'no mapping when the initial names already cover the area');
});

test('one NPC kind in two distant camps does not connect those camps', () => {
	const goal = collect(sourceData({ [A]: spawn([...pair(20), ...pair(70)]), [B]: spawn(pair(26)), [C]: spawn(pair(76)) }));
	const at = targets(goal);
	for (let i = 0; i < goal.spots.length; i++) {
		assert.deepEqual(at[i], goal.spots[i].x < 50 ? (goal.spots[i].x < 23 ? [A, B] : [B, A]) : [A, C]);
	}
});

for (const bridge of ['elite', 'object']) {
	test(`an ${bridge} source cannot bridge two NPC target areas`, () => {
		const pts = [32, 38, 44, 50, 56, 62].flatMap((x) => pair(x));
		const sources = { [A]: spawn([...pair(20), ...pair(70)]), [B]: spawn(pair(26)), [C]: spawn(pair(76)) };
		const objects = {};
		if (bridge === 'elite') sources[95934] = spawn(pts, { rank: 1 });
		else objects[95934] = { id: 95934, name: 'Token Cache', ...spawn(pts) };
		const goal = collect(sourceData(sources, objects));
		assert.deepEqual(targets(goal)[0], [A, B]);
		assert.ok(!goal.fromNpcs.some((n) => n.npc === 95934));
	});
}

test('a connected area that exceeds the import text limit keeps the local target mapping', () => {
	const sources = {};
	const cells = [];
	for (let i = 0; i < 64; i++) {
		const id = A + i % 32;
		const x = 10 + 6 * (i % 8);
		const y = 10 + 8 * Math.floor(i / 8);
		cells.push({ id, x: x + 0.05, y });
		if (!sources[id]) sources[id] = spawn([]);
		sources[id].spawns[1429].pts.push(...pair(x, y));
	}
	const goal = collect(sourceData(sources), '');
	assert.equal(goal.spots.length, 64);
	assert.equal(goal.fromNpcs.length, 32);
	assert.ok(goal.fromNpcsAt.length <= 4096);
	const at = targets(goal);
	for (let i = 0; i < goal.spots.length; i++) {
		const spot = goal.spots[i];
		const cell = cells.find((c) => Math.abs(c.x - spot.x) < 0.1 && c.y === spot.y);
		assert.ok(cell, `known camp at ${spot.x},${spot.y}`);
		assert.deepEqual(at[i], [cell.id], 'each circle still targets its own source');
	}
});
