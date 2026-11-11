'use strict';
// The danger-at-the-spot gate's rules and baseline comparison (tools/lib/danger.js, #1575), on made-up mobs: no
// reference data needed. The gate itself runs on the release candidate (tools/danger-gate.js, gate 10).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { flagGoal, compare, GATE_MARGIN, KINDS } = require('../tools/lib/danger');

const npcs = {
	1: { name: 'Cave Yeti', level: 30, levelMax: 31, spawns: { 1424: { pts: [[1, 1], [2, 2]] } } },
	2: { name: 'Giant Yeti', level: 33, levelMax: 34, spawns: { 1424: { pts: [[3, 3], [4, 4]] } } },
	3: { name: 'Frostmaw', level: 37, rank: 4, spawns: {} },
	4: { name: 'Halikor', level: 12, rank: 1, spawns: {} },
	5: { name: 'Syndicate Footpad', level: 32, levelMax: 33, spawns: {} },
};
const kinds = (flags) => flags.map((f) => f.kind).sort();

test('a collect whose tour reaches droppers 4+ over while ones at your level drop it too is flagged mixed (#1695)', () => {
	const goal = { t: 'collect', quest: 552, oi: 1, fromNpcs: [{ npc: 1 }, { npc: 2 }], spots: [{ x: 1, y: 1 }, { x: 3, y: 3 }] };
	assert.deepEqual(kinds(flagGoal({ goal, level: 29.4, near: [], npcs })), ['mixed']);
	// Pinned to the caverns (one target, no tour): nothing.
	assert.deepEqual(flagGoal({ goal: { ...goal, fromNpcs: [{ npc: 1 }], spots: [] }, level: 29.4, near: [], npcs }), []);
});

test('mobs over the level around a goal, an elite, a rare and a pack are flagged; a group goal is not flagged for its elite', () => {
	const goal = { t: 'use', quest: 553, oi: 3 };
	const near = [{ id: 2, count: 4, dmin: 5 }, { id: 3, count: 1, dmin: 30 }, { id: 5, count: 3, dmin: 20 }];
	assert.deepEqual(kinds(flagGoal({ goal, level: 30.2, near, npcs })), ['over', 'pack', 'rare']);
	const elite = { t: 'collect', quest: 1498, oi: 1, fromNpcs: [] };
	assert.deepEqual(kinds(flagGoal({ goal: elite, level: 11.7, near: [{ id: 4, count: 3, dmin: 10 }], npcs })), ['elite']);
	assert.deepEqual(flagGoal({ goal: elite, level: 11.7, near: [{ id: 4, count: 3, dmin: 10 }], npcs, group: true }), []);
	// A kill of its own mob more than 3 over.
	assert.deepEqual(kinds(flagGoal({ goal: { t: 'kill', quest: 1, oi: 1, npc: 2 }, level: 29.5, near: [], npcs })), ['target']);
});

test('compare fails a new flag past the margin, lists a borderline one and baseline rows no longer flagged', () => {
	const flags = [
		{ key: 'a|kill 1.1|target', margin: 2 },
		{ key: 'b|use 2.1|over', margin: GATE_MARGIN / 2 },
		{ key: 'c|collect 3.1|elite', margin: 4 },
	];
	const baseline = [{ key: 'c|collect 3.1|elite' }, { key: 'd|kill 4.1|pack' }];
	const r = compare(flags, baseline);
	assert.deepEqual(r.fail.map((f) => f.key), ['a|kill 1.1|target']);
	assert.deepEqual(r.borderline.map((f) => f.key), ['b|use 2.1|over']);
	assert.deepEqual(r.stale.map((f) => f.key), ['d|kill 4.1|pack']);
});

test('the committed baseline: every row is a known kind with its guide, goal, reason and evidence, keys unique', () => {
	const file = path.join(__dirname, '..', 'data', 'danger-baseline.json');
	const { flags } = JSON.parse(fs.readFileSync(file, 'utf8'));
	assert.ok(flags.length > 0);
	const keys = new Set();
	for (const r of flags) {
		assert.ok(!keys.has(r.key), `${r.key}: listed once`);
		keys.add(r.key);
		assert.ok(KINDS.includes(r.kind), `${r.key}: kind ${r.kind}`);
		assert.equal(r.key, `${r.guide}|${r.goal}|${r.kind}`, `${r.key}: key is guide|goal|kind`);
		assert.ok(r.reason && r.reason.length > 10, `${r.key}: a reason`);
		assert.ok(r.evidence && r.evidence.length > 5, `${r.key}: evidence`);
	}
});
