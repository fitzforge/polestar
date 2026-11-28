'use strict';
// Gathering areas (`area <zone> "<name>" … at <x,y> … dots <x,y> …`, docs/GUIDE_FORMAT.md "Gathering areas"): each
// line becomes a candidate of its step's skill or collect goal, with its outline and node spots packed, the middle
// of its outline as its place. The JS twin of forge-addontest's dsl-areas.rs; the engine side is
// tests/engine-area-choice.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, compile, plain } = require('./helpers/dsl');

const goalsOf = (r, s = 0) => plain(r.guides[0].steps)[s].goals;
const LINE = '  area Elwynn Forest "Fargodeep Mine" near lvl 3 count 12 lap 300 gain 4.5 levels 2-5 items 2770,2835 only Alliance starter respawn 300 at 40,80 42,80 41,83 dots 40.5,80.5 41.2,81';

test('area lines become the skill goal\'s candidates, outline and node spots packed', () => {
	const r = compile(guideText(['step Mine Copper', LINE, '  area map 1429 "Jasperlode Mine" lvl 6 count 8 lap 250 gain 3 at 60,50 62,50 61,53', '  skill Mining 50']));
	assert.deepEqual(r.errors, [], r.text);
	const [skill] = goalsOf(r);
	assert.deepEqual([skill.map, skill.x, skill.y, skill.f, skill.spots, skill.spread], [1429, 41, 81.5, 'e', undefined, undefined], 'the first area\'s middle, no spawn areas');
	assert.deepEqual(skill.candidates[0], {
		map: 1429, x: 41, y: 81.5, f: 'e', faction: 'A', lvl: { min: 3, max: 3 }, lap: 300, gain: 4.5, respawn: 300, starter: true,
		area: 'Fargodeep Mine', near: true, count: 12, levels: { min: 2, max: 5 }, items: '2770,2835', poly: '40,80;42,80;41,83', dots: '40.5,80.5;41.2,81',
	});
	assert.deepEqual(skill.candidates[1], { map: 1429, x: 61, y: 51.5, f: 'e', faction: 'A', lvl: { min: 6, max: 6 }, lap: 250, gain: 3, area: 'Jasperlode Mine', count: 8, poly: '60,50;62,50;61,53' });
});

test('a collect goal\'s areas take `yield`', () => {
	const r = compile(guideText(['step Get Copper', LINE.replace('gain 4.5', 'yield 6'), '  collect 2770 "Copper Ore" x20']));
	assert.deepEqual(r.errors, [], r.text);
	assert.equal(goalsOf(r)[0].candidates[0].yield, 6);
});

test('an area line without its name, numbers or outline, beside gotos or loop lines, or twice, is an error', () => {
	const errors = (lines) => compile(guideText(['step S', ...lines])).errors.join('\n');
	assert.match(errors(['  area Elwynn Forest lvl 3 count 2 lap 3 gain 1 at 1,1 2,2 3,3', '  skill Mining 50']), /needs its name in quotes/);
	assert.match(errors(['  area Elwynn Forest "X" lvl 3 lap 3 gain 1 at 1,1 2,2 3,3', '  skill Mining 50']), /`area` needs `count`/);
	assert.match(errors(['  area Elwynn Forest "X" lvl 3 count 1 lap 3 gain 1 at 1,1 2,2', '  skill Mining 50']), /three points or more/);
	assert.match(errors(['  area Elwynn Forest "X" lvl 3 count 1 lap 3 gain 1 levels 5-2 at 1,1 2,2 3,3', '  skill Mining 50']), /`levels` in `area` needs <min>-<max>/);
	assert.match(errors(['  area Elwynn Forest "X" lvl 3 count 1 lap 3 yield 1 at 1,1 2,2 3,3', '  skill Mining 50']), /takes `gain`, not `yield`/);
	assert.match(errors(['  goto 40,40', '  area Elwynn Forest "X" lvl 3 count 1 lap 3 gain 1 at 1,1 2,2 3,3', '  skill Mining 50']), /drop the step's `goto` lines/);
	assert.match(errors(['  loop Elwynn Forest lvl 6 lap 300 gain 2.5 at 40,40 45,45', '  area Elwynn Forest "X" lvl 3 count 1 lap 3 gain 1 at 1,1 2,2 3,3', '  skill Mining 50']), /two kinds of place/);
	assert.match(errors(['  area Elwynn Forest "X" lvl 3 count 1 lap 3 gain 1 at 1,1 2,2 3,3', '  area Elwynn Forest "X" lvl 3 count 2 lap 3 gain 1 at 1,1 2,2 3,3', '  skill Mining 50']), /listed twice/);
});

test('a loop line no longer takes `starter` or `respawn`: those are an area\'s', () => {
	const errors = compile(guideText(['step S', '  loop Elwynn Forest lvl 2 lap 300 gain 2.5 starter at 40,40 45,45', '  skill Mining 50'])).errors.join('\n');
	assert.match(errors, /unexpected "starter" in `loop`/);
});
