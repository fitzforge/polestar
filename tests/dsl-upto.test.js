'use strict';
// The compiler side of an objective goal's `upto` (pack format 11; docs/GUIDE_FORMAT.md,
// Modifiers): the modifier, its checks, the emitted key and the pack format. The JS twin of
// forge-guide's tests/guide/dsl_upto.rs; the engine side is tests/engine-upto.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, lineOf, compile, plain } = require('./helpers/dsl');
const { emitGuides } = require('../tools/lib/dsl/emit');
const { formatFor, UPTO_FORMAT, FORMAT, NEEDS } = require('../tools/lib/pack/format');

const goalsOf = (r, s = 0) => plain(r.guides[0].steps)[s].goals;
const emit = (r) => emitGuides(r.guides.map((guide) => ({ guide, source: null })), false);

test('`upto <N>`: part of a quest objective\'s count, by the line named or the one the data finds', () => {
	const r = compile(guideText(['step One', '  accept 7', '  kill 6 quest 7.1 upto 4', '  kill 6 quest 7 upto 6']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(r.warnings.filter((w) => w.includes('upto')), []);
	const [, named, found] = goalsOf(r);
	assert.deepEqual([named.quest, named.oi, named.upto], [7, 1, 4]);
	assert.deepEqual([found.quest, found.oi, found.upto], [7, 1, 6]);
	assert.match(emit(r), /\{ t = "kill", quest = 7, title = "Kobold Camp Cleanup", target = "Kobold Vermin", npc = 6, count = 10, oi = 1, upto = 4, map = /);
});

test('`upto` needs a quest objective to count, and a count of 1 or more', () => {
	const bare = guideText(['step One', '  kill 6 upto 4']);
	assert.deepEqual(compile(bare).errors, [`test.guide:${lineOf(bare, 'kill 6 upto 4')}: \`upto\` counts part of a quest objective: the goal needs \`quest <id>.<objective>\``]);
	for (const bad of ['kill 6 quest 7.1 upto 0', 'kill 6 quest 7.1 upto', 'kill 6 quest 7.1 upto four', 'kill 6 quest 7.1 upto 2 upto 3']) {
		assert.ok(compile(guideText(['step One', '  accept 7', `  ${bad}`])).errors.length >= 1, bad);
	}
	assert.ok(compile(guideText(['step One', '  accept 7 upto 2'])).errors.some((e) => e.includes('`upto <N>` does not apply to `accept`')));
});

test('a part that is the whole of the objective is a warning: the goal is the objective itself', () => {
	const text = guideText(['step One', '  accept 7', '  kill 6 quest 7.1 upto 10']);
	const r = compile(text);
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(r.warnings.filter((w) => w.includes('upto')), [`test.guide:${lineOf(text, 'kill 6 quest 7.1 upto 10')}: \`upto 10\` is the whole of quest 7.1 (x10): the goal is done with the objective, as without it`]);
	assert.equal(goalsOf(r)[1].upto, 10);
});

test('format 11: a guide with an `upto` goal, read by Polestar 0.4.1 and later', () => {
	assert.equal(UPTO_FORMAT, 11);
	assert.equal(NEEDS[UPTO_FORMAT], '0.4.1');
	assert.equal(formatFor(compile(guideText(['step One', '  accept 7', '  kill 6 quest 7.1 upto 4'])).guides), UPTO_FORMAT);
	assert.equal(formatFor(compile(guideText(['step One', '  accept 7', '  kill 6 quest 7.1'])).guides), FORMAT);
});

test("the route planner's goal editor writes `upto` and offers it where a goal can count an objective", () => {
	const { goalFields, formatGoal, verbSchema } = require('../tools/lib/planner/goalfmt');
	const { parseGuide } = require('../tools/lib/dsl/parse');
	const { Diagnostics } = require('../tools/lib/dsl/diag');
	const written = (text) => formatGoal(goalFields(parseGuide(guideText(['step One', `  ${text}`]), 'x', new Diagnostics()).steps[0].goals[0]));
	assert.equal(written('kill 6 upto 5 quest 7.1'), 'kill 6 quest 7.1 upto 5');
	assert.equal(written('collect 769 upto 2 x4 quest 86.1 optional'), 'collect 769 quest 86.1 x4 upto 2 optional');
	assert.equal(formatGoal({ verb: 'kill', npc: 6, quest: 7, oi: 1, upto: '5' }), 'kill 6 quest 7.1 upto 5');
	const { verbs } = verbSchema();
	assert.ok(verbs.kill.modifiers.some((m) => m.key === 'upto' && m.type === 'int' && m.mod === 'upto'));
	assert.ok(!verbs.accept.modifiers.some((m) => m.key === 'upto'));
});
