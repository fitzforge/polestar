'use strict';
// An objective goal's `upto` (pack format 11; docs/GUIDE_FORMAT.md, Modifiers) in the real
// Engine: the goal is done at part of the quest log line's count, so an objective worked in
// several places has a step for each. Each guide is compiled from the fixture data and played
// against the stub world (tests/helpers/play-guide.js). The compiler side: tests/dsl-upto.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { playGuide } = require('./helpers/play-guide');

// Quest 7 (fixture): Kobold Camp Cleanup, ten Kobold Vermin.
const CAMPS = ['step Take it', '  accept 7', 'step The near camp', '  kill 6 quest 7.1 upto 4', 'step The far camp', '  kill 6 quest 7.1', 'step Back', '  turnin 7'];
const counts = (snapshot, s) => [snapshot.steps[s - 1].goals[0].cur, snapshot.steps[s - 1].goals[0].max];

test('`upto` ends an objective goal at part of the line\'s count, and the goal counts toward it', () => {
	const [none, some, part, more] = playGuide(CAMPS,
		`w.accept(7, { 10 })
		snap()
		w.progress(7, 1, 3)
		snap()
		w.progress(7, 1, 4)
		snap()
		w.progress(7, 1, 10)
		snap()`);
	assert.equal(none.live, 2);
	assert.deepEqual(counts(none, 2), [0, 4]);
	assert.equal(some.live, 2);
	assert.deepEqual(counts(some, 2), [3, 4]);
	assert.equal(part.live, 3, 'four of ten: the near camp is done, the far camp is not');
	assert.deepEqual(counts(part, 2), [4, 4]);
	assert.deepEqual(counts(part, 3), [4, 10], 'the goal without `upto` counts the whole line');
	assert.equal(more.live, 4, 'all ten: both done, the hand-in is next');
});

test('more than the part at once passes the step all the same, and the part reads full', () => {
	const [over] = playGuide(CAMPS, `w.accept(7, { 10 })
		w.progress(7, 1, 7)
		snap()`);
	assert.equal(over.live, 3);
	assert.deepEqual(counts(over, 2), [4, 4]);
});

test('a part that is the whole count, or more, is the objective itself', () => {
	const lines = ['step Take it', '  accept 7', 'step All of them', '  kill 6 quest 7.1 upto 10', 'step Back', '  turnin 7'];
	const [most, all] = playGuide(lines, `w.accept(7, { 10 })
		w.progress(7, 1, 9)
		snap()
		w.progress(7, 1, 10)
		snap()`);
	assert.equal(most.live, 2);
	assert.deepEqual(counts(most, 2), [9, 10]);
	assert.equal(all.live, 3);
});

test('a quest handed in has every part done', () => {
	const [done] = playGuide(CAMPS, 'snap()', 'w.completed[7] = true');
	assert.equal(done.live, 0, 'nothing left open');
	assert.equal(done.steps[1].goals[0].status, 'done');
});

test('Guides.Validate refuses an `upto` that is no number', () => {
	const [out] = playGuide(['step One', '  task "A"'], `local function def(upto)
			return { id = "test/v", title = "V", steps = { { goals = { { t = "kill", target = "Kobold Vermin", npc = 6, quest = 7, oi = 1, count = 10, upto = upto } } } } }
		end
		emit({ ok = Polestar.Guides.Validate(def(4)) == nil, bad = Polestar.Guides.Validate(def("four")) })`);
	assert.equal(out.ok, true);
	assert.match(out.bad, /bad upto/);
});
