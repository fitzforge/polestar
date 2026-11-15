'use strict';
// The compiler side of a goal's `either` (pack format 11; docs/GUIDE_FORMAT.md, "One of several"):
// the modifier, the checks on a set, the emitted key and the pack format. The JS twin of
// forge-guide's tests/guide/dsl_either.rs; the engine side is tests/engine-either.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { fixtureData, guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { Data } = require('../tools/lib/dsl/data');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { formatFor, EITHER_FORMAT, MONEY_TASK_FORMAT, FORMAT, NEEDS } = require('../tools/lib/pack/format');

const goalsOf = (r, s = 0) => plain(r.guides[0].steps)[s].goals;
const emit = (r) => emitGuides(r.guides.map((guide) => ({ guide, source: null })), false);

test('`either` marks the goals of a step that are alternatives; the others are not of the set', () => {
	const r = compile(guideText(['step Pick one', '  accept 783 either', '  task "Ask around" either only Warrior', '  accept 7']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(goalsOf(r).map((g) => g.either), [true, true, undefined]);
	const text = emit(r);
	assert.match(text, /\{ t = "accept", quest = 783, .* f = "e", either = true \},\n/);
	assert.match(text, /\{ t = "task", text = "Ask around", either = true, only = \{ classes = \{ "WARRIOR" \} \} \},\n/);
	assert.doesNotMatch(text, /quest = 7, .*either/);
});

test('a set is two goals or more, none of them optional', () => {
	const alone = guideText(['step One', '  accept 783 either', '  accept 7']);
	assert.deepEqual(compile(alone).errors, [`test.guide:${lineOf(alone, 'accept 783 either')}: \`either\` needs a second \`either\` goal in its step: the step is done when any one of them is`]);
	const optional = guideText(['step One', '  accept 783 either optional', '  accept 7 either']);
	assert.deepEqual(compile(optional).errors, [`test.guide:${lineOf(optional, 'accept 783 either optional')}: a goal cannot be both \`either\` and \`optional\`: an optional goal never holds its step`]);
	// One set a step: two goals in each of two steps are two sets.
	const two = compile(guideText(['step One', '  accept 783 either', '  accept 7 either', 'step Two', '  turnin 783 either', '  turnin 7 either']));
	assert.deepEqual(two.errors, [], two.text);
});

test('`either` goes on every goal that can hold a step, and on no `note` or `wait`', () => {
	const lines = ['accept 783', 'kill 6', 'collect 750 x2', 'goto 47.6,35.1', 'talk 197', 'money 1s', 'task "Take the boat"', 'destroy 750', 'abandon 7', 'level 3', 'hearth "Goldshire"'];
	const r = compile(guideText(['step One', ...lines.map((l) => `  ${l} either`)]));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(goalsOf(r).map((g) => g.either), lines.map(() => true));
	for (const [line, verb] of [['note "Words" either', 'note'], ['wait 30 either', 'wait']]) {
		const errors = compile(guideText(['step One', `  ${line}`, '  accept 7 either', '  accept 783 either'])).errors;
		assert.ok(errors.some((e) => e.includes(`\`either\` does not apply to \`${verb}\``)), `${verb}: ${errors.join('\n')}`);
	}
});

// The fixture data plus two quests of Marshal McBride's of which a character takes one: 9720
// By the Road and 9721 By the River close each other (`excl`).
function forkData() {
	const base = fixtureData();
	const quest = (id, title, excl) => ({ ...base.quests[7], id, title, pre: [], objectives: [], excl });
	const quests = { ...base.quests, 9720: quest(9720, 'By the Road', [9721]), 9721: quest(9721, 'By the River', [9720]) };
	return new Data({ quests, npcs: base.npcs, objects: base.objects, items: base.items, zones: base.zones, 'map-frames': base.mapFrames, meta: base.meta }, { dir: base.dir });
}

test('quests that close each other are no warning as an `either` set, and still one a step apart', () => {
	const closed = (r) => r.warnings.filter((w) => w.includes('is not offered once'));
	const set = compile(guideText(['step Fork', '  accept 9720 either', '  accept 9721 either', 'step Back', '  turnin 9720', '  turnin 9721']), forkData());
	assert.deepEqual(set.errors, [], set.text);
	assert.deepEqual(closed(set), [], set.text);
	const apart = guideText(['step Road', '  accept 9720', 'step River', '  accept 9721', 'step Back', '  turnin 9720', '  turnin 9721']);
	assert.deepEqual(closed(compile(apart, forkData())), [
		`test.guide:${lineOf(apart, 'accept 9721')}: quest 9721 (By the River) is not offered once 9720 (By the Road) is in the log or done, and the chain takes that quest earlier`,
	]);
	// Another quest of the set's step that is not of the set closes it as before.
	const beside = guideText(['step Fork', '  accept 9720', '  accept 9721 either', '  accept 783 either', 'step Back', '  turnin 9720', '  turnin 9721', '  turnin 783']);
	assert.equal(closed(compile(beside, forkData())).length, 1);
});

test('format 11: a guide with an `either` goal, read by Polestar 0.4.1 and later', () => {
	assert.equal(EITHER_FORMAT, 11);
	assert.equal(NEEDS[EITHER_FORMAT], '0.4.1');
	const set = compile(guideText(['step One', '  accept 783 either', '  accept 7 either']));
	assert.equal(formatFor(set.guides), EITHER_FORMAT);
	assert.equal(formatFor(compile(guideText(['step One', '  accept 783', '  accept 7'])).guides), FORMAT);
	assert.equal(formatFor(compile(guideText(['step One', '  task "A"', '  task "B"'])).guides), MONEY_TASK_FORMAT);
});
