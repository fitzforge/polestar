'use strict';
// A step's `either` goals (pack format 11; docs/GUIDE_FORMAT.md, "One of several") in the real
// Engine: the step is done when any one goal of the set is. Each guide is compiled from the
// fixture data and played against the stub world (tests/helpers/play-guide.js). The compiler
// side: tests/dsl-either.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { playGuide, statuses } = require('./helpers/play-guide');

test('`either`: the step is done when any one goal of the set is, and the others read done', () => {
	const [start, took] = playGuide(
		['step Pick one', '  accept 783 either', '  accept 7 either', 'step Then', '  task "Go on"'],
		`snap()
		w.accept(7, { 10 })
		snap()`,
	);
	assert.equal(start.live, 1);
	assert.equal(statuses(start, 1).includes('done'), false);
	assert.equal(took.live, 2, 'one accept taken: the route moves on');
	assert.deepEqual(statuses(took, 1), ['done', 'done']);
});

test('`either` beside a goal that is not of the set: that goal still holds the step', () => {
	const [took, both] = playGuide(
		['step Pick one', '  accept 783 either', '  accept 7 either', '  accept 33', 'step Then', '  task "Go on"'],
		`w.accept(783, {})
		snap()
		w.accept(33, { 8 })
		snap()`,
	);
	assert.equal(took.live, 1);
	assert.deepEqual(statuses(took, 1).slice(0, 2), ['done', 'done']);
	assert.notEqual(statuses(took, 1)[2], 'done');
	assert.equal(both.live, 2);
});

test('a quest taken as one of an `either` set: its later goals hold only those who took it', () => {
	// The player takes 7; the hand-in of 783, the accept they passed over, is no step of theirs.
	const [took] = playGuide(
		['step Pick one', '  accept 783 either', '  accept 7 either', 'step The other', '  turnin 783', 'step Then', '  task "Go on"'],
		`w.accept(7, { 10 })
		snap()`,
	);
	assert.equal(took.live, 3, 'the hand-in of the quest not taken does not hold the route');
});

test('once one quest of the set is taken, the guide no longer asks for the others', () => {
	const [before, after] = playGuide(
		['step Pick one', '  accept 783 either', '  accept 7 either', '  accept 33', 'step Then', '  task "Go on"'],
		`stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6)
		emit({ a = E.WantsQuest("accept", 783), b = E.WantsQuest("accept", 7), c = E.WantsQuest("accept", 33) })
		w.accept(7, { 10 })
		stub.advance(0.6)
		emit({ a = E.WantsQuest("accept", 783), b = E.WantsQuest("accept", 7), c = E.WantsQuest("accept", 33) })`,
	);
	assert.deepEqual([before.a, before.b, before.c], [true, true, true]);
	assert.deepEqual([after.a, after.c], [false, true], 'the quest passed over is not taken for the player; the one outside the set still is');
});

test('a tick on one `either` goal is not stored for the others: unticking reopens the step', () => {
	const [ticked, cleared] = playGuide(
		['step Either way', '  task "Ask the guard" either', '  collect 750 x2 either', '  accept 783', 'step Then', '  task "Go on"'],
		`E.ToggleGoal(1, 1)
		snap()
		E.ToggleGoal(1, 1)
		snap()`,
	);
	assert.deepEqual(statuses(ticked, 1).slice(0, 2), ['done', 'done']);
	assert.equal(statuses(cleared, 1).slice(0, 2).includes('done'), false, "the collect was never latched by its partner's tick");
});

test('a goal of the set that is not for this character does not finish it', () => {
	const [start, done] = playGuide(
		['step Either way', '  task "The Mage portal" either only Mage', '  task "The boat" either', '  task "The tunnel" either', 'step Then', '  task "Go on"'],
		`snap()
		E.ToggleGoal(1, 3)
		snap()`,
	);
	assert.equal(start.live, 1, 'a Warrior: the Mage way is no way of theirs');
	assert.equal(done.live, 2);
});

test('Guides.Validate refuses an `either` that is not true', () => {
	const [out] = playGuide(['step One', '  task "A"'], `local function def(either)
			return { id = "test/v", title = "V", steps = { { goals = { { t = "task", text = "A", either = either }, { t = "task", text = "B", either = true } } } } }
		end
		emit({ ok = Polestar.Guides.Validate(def(true)) == nil, bad = Polestar.Guides.Validate(def("yes")) })`);
	assert.equal(out.ok, true);
	assert.match(out.bad, /bad either/);
});
