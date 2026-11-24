'use strict';
// Synthetic source-specific drop gates: every prerequisite must be held or
// completed. No private data, live quest assumptions, or Lua are needed.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { Data } = require('../tools/lib/dsl/data');
const { playChain } = require('../tools/lib/playtest-honest');

function play(verb, before = [], { gated = true, other = false, optional = false, objective = false } = {}) {
	const source = { id: 11, name: 'Source', spawns: { 99101: { f: 'e', pts: [[50, 50]] } } };
	const quest = (id) => ({ id, title: `Quest ${id}`, start: { npc: [1] }, end: { npc: [1] }, objectives: [] });
	const data = new Data({
		quests: { 510: quest(510), 511: quest(511), 540: { ...quest(540), start: { item: [101] } }, ...(objective ? { 502: { ...quest(502), objectives: [{ type: 'item', id: 101, count: 1 }] } } : {}) },
		items: { 101: { id: 101, name: 'Starter', drops: { npc: { 11: 100, ...(other ? { 12: 100 } : {}) }, object: { 21: 100, ...(other ? { 22: 100 } : {}) } }, ...(gated ? { dropRequires: { npc: { 11: [510, 511] }, object: { 21: [510, 511] } } } : {}) } },
		npcs: { 1: { ...source, id: 1 }, 11: source, 12: { ...source, id: 12 } }, objects: { 21: { ...source, id: 21 }, 22: { ...source, id: 22 } },
		zones: { 99101: { id: 99101, name: 'Testvale' } }, 'map-frames': { era: { 99101: { c: 1, left: 0, right: -1000, top: 1000, bottom: 0 } } },
	});
	const goal = (t, extra) => ({ t, map: 99101, x: 50, y: 50, f: 'e', ...extra });
	const goals = before.map(([t, quest]) => goal(t, { quest, npc: 1 }));
	if (objective) goals.push(goal('accept', { quest: 502, npc: 1 }));
	goals.push(goal(verb, { npc: other ? 12 : 11, object: other ? 22 : 21, item: 101, optional }));
	goals.push(objective ? goal('turnin', { quest: 502, npc: 1 }) : goal('accept', { quest: 540, item: 101 }));
	return playChain([{ id: 'test/gates', steps: [{ title: 'Drops', goals }] }], data, { race: 'Orc', faction: 'Horde', cls: 'WARRIOR' });
}

for (const verb of ['kill', 'interact', 'collect']) {
	test(`${verb}: source drop prerequisites must all be held or completed`, () => {
		const rule = verb === 'collect' ? 'R3' : 'R2';
		for (const before of [[], [['accept', 510]]]) {
			assert.ok(play(verb, before).some((f) => f.rule === rule && f.severity === 'fail'), `${verb}: missing prerequisite must be diagnosed`);
		}
		for (const before of [
			[['accept', 510], ['accept', 511]],
			[['accept', 510], ['turnin', 510], ['accept', 511]],
			[['accept', 510], ['turnin', 510], ['accept', 511], ['turnin', 511]],
		]) assert.deepEqual(play(verb, before), [], `${verb}: held and completed prerequisites qualify`);
		assert.deepEqual(play(verb, [], { gated: false }), [], 'absent metadata keeps the existing source');
	});
}

test('a gated source does not block another eligible source of the same item', () => {
	for (const verb of ['kill', 'interact', 'collect']) assert.deepEqual(play(verb, [], { other: true }), []);
});

test('a gated optional collect gives no item; a mandatory collect reports the failure then plays on', () => {
	const optional = play('collect', [], { optional: true });
	assert.ok(optional.some((f) => f.rule === 'R3' && f.severity === 'warn'));
	assert.ok(optional.some((f) => f.rule === 'R2' && f.severity === 'fail'));
	const required = play('collect');
	assert.ok(required.some((f) => f.rule === 'R3' && f.severity === 'fail'));
	assert.equal(required.some((f) => f.rule === 'R2'), false, 'one cause, one finding for mandatory work');
});

test('kills do not award gated item objectives merely because their own quest is held', () => {
	assert.ok(play('kill', [], { objective: true }).some((f) => f.rule === 'R5' && f.severity === 'fail'));
	assert.deepEqual(play('kill', [['accept', 510], ['accept', 511]], { objective: true }), []);
});
