'use strict';
// `goto x,y ["Text"] nearest` (docs/GUIDE_FORMAT.md, "Smart targets"): the step's `nearest` gotos are one goal whose
// places are smart-target `candidates`, each for the characters its `only` (and the step's) names: a profession guide's
// "Go to an anvil", where the arrow leads to the nearest station and arriving at any of them finishes the step.
// The Rust twin: forge-guide's tests/guide/dsl_goto_nearest.rs; the engine side: tests/engine-goto-nearest.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, compile, plain } = require('./helpers/dsl');

const goalsOf = (r, s = 0) => plain(r.guides[0].steps)[s].goals;
const ANVILS = ['  goto 47.4,62.2 "Anvil" nearest only Alliance', '  goto 35.4,40.1 "Anvil" map 1426 nearest only Alliance'];

test('`goto … nearest` points are one goal: the first keeps the text, the places become its candidates', () => {
	const r = compile(guideText(['step Go to an anvil', ...ANVILS]));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(r.warnings, [], 'its places on other maps than the zone are no typo');
	const goals = goalsOf(r);
	assert.equal(goals.length, 1, 'one goal');
	const [g] = goals;
	assert.deepEqual([g.t, g.text, g.map, g.x, g.only], ['goto', 'Anvil', undefined, undefined, undefined], 'no fixed place');
	assert.deepEqual(g.candidates, [
		{ map: 1429, x: 47.4, y: 62.2, f: 'e', faction: 'A' },
		{ map: 1426, x: 35.4, y: 40.1, f: 'e', faction: 'A' },
	]);
});

test('other goals of the step stay; a goto without `nearest` stays a place to walk', () => {
	const r = compile(guideText(['step Go to an anvil', '  goto 50,50', ...ANVILS, '  note ready']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(goalsOf(r).map((g) => [g.t, !!g.candidates]), [['goto', false], ['goto', true], ['note', false]]);
});

test('`goto … nearest` needs two points, none optional, and is neither a `loop` nor beside `skill … nearest`', () => {
	const errors = (lines) => compile(guideText(['step S', ...lines])).errors.join('\n');
	assert.match(errors([ANVILS[0]]), /needs at least two `nearest` points/);
	assert.match(errors([ANVILS[0], `${ANVILS[1]} optional`]), /cannot be `optional`/);
	assert.match(errors(['  loop', ...ANVILS]), /`loop` walks them all/);
	assert.match(errors([...ANVILS, '  skill Mining 50 nearest']), /use one/);
});
