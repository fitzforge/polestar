'use strict';
// Polestar Experimental's Shen'dralas guide (experimental/guides/shendralas.guide), compiled with the
// reference data: the order players' recordings support, pinned so an edit can't undo it unseen.
//
// Needs data/forever (forge data build); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { compileSources } = require('../tools/lib/dsl/project');
const { loadData } = require('../tools/lib/dsl/data');
const { DATA, ROOT } = require('../tools/lib/paths');

const skip = needs('quests.json', 'npcs.json', 'objects.json', 'items.json', 'map-frames.json');

let list;
// The guide's goals in order, as { step, goal }.
function goals() {
	if (!list) {
		const file = path.join(ROOT, 'experimental', 'guides', 'shendralas.guide');
		const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], loadData(DATA));
		assert.equal(guides.length, 1, 'the guide compiles');
		list = guides[0].steps.flatMap((step) => step.goals.map((goal) => ({ step, goal })));
	}
	return list;
}
const first = (pred, what) => {
	const i = goals().findIndex(({ goal }) => pred(goal));
	assert.ok(i >= 0, `${what} is in the guide`);
	return i;
};
const is = (t, quest) => (g) => g.t === t && g.quest === quest;

test("Shen'dralas: Mordent's pylons come in the order he offers them, each after the hand-in before it", { skip }, () => {
	const order = [
		[is('accept', 92914), 'Strange Pylons taken'],
		[is('turnin', 92914), 'Strange Pylons handed in'],
		[is('accept', 96010), 'Fragments of the Pylons taken'],
		[is('turnin', 96010), 'Fragments of the Pylons handed in'],
		[is('accept', 96018), 'Powering the Pylons taken'],
		[is('turnin', 96018), 'Powering the Pylons handed in'],
		[is('accept', 93016), 'A Brief History Lesson taken'],
		[is('accept', 93394), 'Meeting the Magister taken'],
		[is('turnin', 93394), 'Meeting the Magister handed in'],
	].map(([pred, what]) => first(pred, what));
	assert.deepEqual([...order].sort((a, b) => a - b), order, 'each comes after the one before it');
	assert.equal(goals()[order[0]].goal.object, 577959, 'Strange Pylons starts at the western pylon');
});

test("Shen'dralas: the temple's quests wait for Meeting the Magister, as the only recorded player had them", { skip }, () => {
	const met = first(is('turnin', 93394), 'Meeting the Magister handed in');
	assert.ok(first(is('accept', 93341), 'Forlorn Gardens taken') > met, 'Mithera after Kirandis');
	const lateBiraxas = goals().findIndex(({ goal }, i) => i > met && is('accept', 99257)(goal));
	assert.ok(lateBiraxas > met, 'Biraxas is offered again after Kirandis');
	for (const { goal } of goals().filter(({ goal }) => is('accept', 99257)(goal))) assert.equal(goal.optional, true, 'never recorded: always optional');
});

// The client gives Repair and Recharge Pylon (the spell players cast at each pylon) to the Pile of Pylon Parts, and
// each repair is its own quest log line, so the guide counts the line, whatever finishes it.
test("Shen'dralas: each pylon repair is the Pile of Pylon Parts at that pylon, counted by its quest log line, after the Mana Sieve", { skip }, () => {
	const sieve = first((g) => g.t === 'collect' && g.item === 255662, 'the Mana Sieve');
	const repairs = goals().map(({ goal }, i) => ({ goal, i })).filter(({ goal }) => goal.t === 'use' && goal.item === 271882);
	assert.equal(repairs.length, 2, 'two repairs');
	for (const { goal, i } of repairs) {
		assert.ok(i > sieve, 'after the Mana Sieve');
		assert.equal(goal.map, 2652);
		assert.equal(goal.quest, 96018);
	}
	assert.deepEqual(repairs.map(({ goal }) => goal.oi), [2, 3], 'Western pylon repaired, then Eastern pylon repaired');
	assert.ok(repairs[0].goal.x < 50 && repairs[1].goal.x > 70, 'the western pylon, then the eastern one');
});
