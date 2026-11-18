'use strict';
// `skill <Profession> <N> nearest` (docs/GUIDE_FORMAT.md, "Smart targets"; #2529): the step's `goto` points are the
// places to raise the skill, each for the characters its `only` (and the step's) names. They become the goal's
// `candidates`, as for `train … nearest`, so the arrow leads to the one nearest the player; the gotos leave the step.
// The JS twin of forge-guide's tests/guide/dsl_skill_nearest.rs; the engine side is tests/engine-skill-nearest.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, compile, plain } = require('./helpers/dsl');
const { formatFor, FORMAT } = require('../tools/lib/pack/format');

const goalsOf = (r, s = 0) => plain(r.guides[0].steps)[s].goals;
const POINTS = ['  goto 47.4,62.2 "Crystal Lake" only Human', '  goto 35.4,40.1 map 1426 "Iceflow Lake" only Dwarf,Gnome'];

test('`skill … nearest` takes the step\'s points as the places the arrow picks from, each for its own characters', () => {
	const r = compile(guideText(['step Fishing 1-50', ...POINTS, '  skill Mining 50 nearest']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(r.warnings, [], 'its places on other maps than the zone are no typo');
	const goals = goalsOf(r);
	assert.equal(goals.length, 1, 'the gotos leave the step');
	const [skill] = goals;
	assert.deepEqual([skill.t, skill.level, skill.map, skill.x], ['skill', 50, undefined, undefined], 'no fixed place');
	assert.deepEqual(skill.candidates, [
		{ map: 1429, x: 47.4, y: 62.2, f: 'e', faction: 'A', races: ['Human'] },
		{ map: 1426, x: 35.4, y: 40.1, f: 'e', faction: 'A', races: ['Dwarf', 'Gnome'] },
	]);
	assert.equal(formatFor(r.guides), FORMAT, 'no pack format change');
});

test('a point without `only` is for whoever the step (or the guide) is for', () => {
	const r = compile(guideText(['step Fishing 1-50', '  goto 47.4,62.2', '  goto 35.4,40.1 map 1426', '  skill Mining 50 nearest']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(goalsOf(r)[0].candidates.map((c) => [c.faction, c.races]), [['A', undefined], ['A', undefined]]);
	const both = compile(guideText(['guide t/both', 'title Both', 'levels 1-10', 'zone Elwynn Forest', '', 'step Fishing 1-50', '  goto 47.4,62.2 only Horde', '  goto 35.4,40.1 map 1426 only Alliance', '  goto 50,50 map 1411', '  skill Mining 50 nearest']));
	assert.deepEqual(both.errors, [], both.text);
	assert.deepEqual(goalsOf(both)[0].candidates.map((c) => c.faction), ['H', 'A', 'AH']);
});

test('`skill … nearest` needs two points of its step and no place of its own, and is no `loop`', () => {
	const errors = (lines) => compile(guideText(['step S', ...lines])).errors.join('\n');
	assert.match(errors(['  goto 47.4,62.2', '  skill Mining 50 nearest']), /needs at least two `goto` points/);
	assert.match(errors([...POINTS, '  skill Mining 50 nearest @47.4,62.2']), /drop `@x,y`/);
	assert.match(errors(['  loop', ...POINTS.map((p) => p.replace(/ only .*/, '')), '  skill Mining 50 nearest']), /`loop` walks them all/);
	assert.match(errors(['  goto 47.4,62.2 optional', '  goto 35.4,40.1 map 1426', '  skill Mining 50 nearest']), /cannot be `optional`/);
});

test('without `nearest` a skill goal keeps the step\'s points as places to walk', () => {
	const r = compile(guideText(['step Copper', ...POINTS, '  skill Mining 50']));
	assert.deepEqual(r.errors, [], r.text);
	assert.deepEqual(goalsOf(r).map((g) => g.t), ['goto', 'goto', 'skill']);
	assert.equal(goalsOf(r)[2].candidates, undefined);
});
