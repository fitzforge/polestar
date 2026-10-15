'use strict';
// a quest action in a step that only applies while the quest is in
// the log (its `when` requires `onquest Q` or `ready Q`) does not need an
// earlier `accept Q`: the guard proves the quest is held. Guides that pick
// up a route midway (quests from another addon or an earlier session) rely
// on it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, guideText } = require('./helpers/dsl');
const { whenHolds } = require('../tools/lib/dsl/validate');

const NEVER = /never accepted earlier/;
const errorsOf = (lines) => compile(guideText(lines)).errors.join('\n');

test('a step guarded by onquest may turn in or complete the quest', () => {
	assert.doesNotMatch(errorsOf(['step Hand in', '  when onquest 783', '  turnin 783']), NEVER);
	assert.doesNotMatch(errorsOf(['step Hand in', '  when level >= 2 and onquest 783', '  turnin 783']), NEVER);
	assert.doesNotMatch(errorsOf(['step Hand in', '  when ready 783', '  turnin 783']), NEVER);
	assert.doesNotMatch(errorsOf(['step Kill', '  when onquest 7', '  kill 6 x10 quest 7.1']), NEVER);
});

test('a guard that does not prove the quest is held still reports', () => {
	assert.match(errorsOf(['step Hand in', '  turnin 783']), NEVER);
	assert.match(errorsOf(['step Hand in', '  when onquest 7', '  turnin 783']), NEVER);
	assert.match(errorsOf(['step Hand in', '  when onquest 783 or level >= 5', '  turnin 783']), NEVER);
	assert.match(errorsOf(['step Hand in', '  when not onquest 783', '  turnin 783']), NEVER);
	assert.match(errorsOf(['step Hand in', '  when turnedin 783', '  turnin 783']), NEVER);
});

test('whenHolds: which quest atoms a when expression guarantees', () => {
	const q = (node) => [...whenHolds(node)].sort((a, b) => a - b);
	assert.deepEqual(q(undefined), []);
	assert.deepEqual(q(['onquest', 783]), [783]);
	assert.deepEqual(q(['ready', 7]), [7]);
	assert.deepEqual(q(['all', ['level', '>=', 2], ['onquest', 783], ['ready', 7]]), [7, 783]);
	assert.deepEqual(q(['all', ['all', ['onquest', 5]]]), [5]);
	assert.deepEqual(q(['any', ['onquest', 783], ['onquest', 7]]), []);
	assert.deepEqual(q(['any', ['onquest', 783], ['all', ['onquest', 783], ['level', '>=', 3]]]), [783]);
	assert.deepEqual(q(['not', ['onquest', 783]]), []);
	assert.deepEqual(q(['turnedin', 783]), []);
});
