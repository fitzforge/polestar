'use strict';
// Connected spawn areas share target names without joining separate camps (#1869, #1616);
// at a hand pin only the droppers at the point join them (#1695).
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

// A hand pin's droppers at the point (#1869's bears) and one a chain of spawns reaches
// from 417 yd (#1695's 32-34 yetis beside the Foothill Caverns): B, 209 yd from the pin,
// is at the point; C is not; E spawns only in A's far camp, beside B's.
const E = 95935;
const camps = () => ({ [A]: spawn([...pair(20), ...pair(70)]), [B]: spawn(pair(26)), [C]: spawn(pair(76)), [E]: spawn(pair(70.3)) });

test('a hand pin names its droppers across their connected areas, never a dropper only a chain of spawns reaches', () => {
	const goal = collect(sourceData({ [A]: spawn([...pair(20), ...pair(70)]), [B]: spawn([...pair(26), ...pair(76)]), [C]: spawn(pair(32)), [E]: spawn(pair(70.3)) }));
	assert.deepEqual(goal.spots.map((s) => s.x), [20, 26.1, 70.1, 76.1]);
	assert.deepEqual(goal.fromNpcs.map((n) => n.npc), [A, B, E], 'C, linked to the pin only through B, is not a target');
	assert.deepEqual(targets(goal), [[A, B], [B, A], [A, E, B], [B, A]], 'local targets first, then the droppers at the point in the same area; E only where it spawns');
});

test('a picked camp keeps linking all its sources, through a chain of small spawn areas', () => {
	// Five more droppers in the first camp leave the goal's own names short of the chain.
	const more = [95941, 95942, 95943, 95944, 95945];
	const sources = { [A]: spawn(pair(20)), [B]: spawn(pair(26)), [C]: spawn(pair(32)) };
	more.forEach((id, k) => { sources[id] = spawn(pair(20, 20 + 0.02 * (k + 1))); });
	const goal = collect(sourceData(sources), '');
	assert.deepEqual(goal.spots.map((s) => s.x), [20, 26.1, 32.1]);
	assert.deepEqual(targets(goal)[0], [A, ...more, B, C], 'C, two links away, is a target at the first camp');
});

test('one NPC kind in two distant camps does not connect those camps', () => {
	const goal = collect(sourceData(camps()));
	assert.deepEqual(goal.fromNpcs.map((n) => n.npc), [A, B, E]);
	assert.deepEqual(targets(goal), [[A, B], [B, A], [A, E]], 'B is not a target at A\'s far camp');
});

for (const bridge of ['elite', 'object']) {
	test(`an ${bridge} source cannot bridge two NPC target areas`, () => {
		const pts = [32, 38, 44, 50, 56, 62].flatMap((x) => pair(x));
		const sources = camps();
		const objects = {};
		if (bridge === 'elite') sources[95934] = spawn(pts, { rank: 1 });
		else objects[95934] = { id: 95934, name: 'Token Cache', ...spawn(pts) };
		const goal = collect(sourceData(sources, objects));
		assert.deepEqual(targets(goal), [[A, B], [B, A], [A, E]]);
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
