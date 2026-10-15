'use strict';
// `loop` steps. In a step with a `loop` line, the `goto`
// points (in order) are the circuit to search: each kill, collect or interact
// goal of the step that has no `@` coordinates of its own gets them as its
// spawn areas (`spots`, searched one after another: `spread`), placed at the
// first point; the gotos themselves are not goals any more. The runtime keys
// are format 1's, so a loop alone does not make a pack format 2.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, guideText, plain } = require('./helpers/dsl');
const { packFormat } = require('../tools/lib/dsl/project');

const LOOP = [
	'step Kobold circuit',
	'  loop',
	'  goto 47.6,35.1 "North camp"',
	'  goto 49.0,32.4 r 20',
	'  goto 52.3,26.8',
	'  kill 6 x10 quest 7.1',
	'  collect 750 x2',
	'  note Pull one at a time.',
];

function compiled(lines) {
	const r = compile(guideText(lines));
	return { r, steps: r.errors.length ? null : plain(r.guides[0].steps) };
}

test('a loop step turns its gotos into the spots of its kill and collect goals', () => {
	const { r, steps } = compiled(['step Accept', '  accept 7', ...LOOP]);
	assert.deepEqual(r.errors, [], r.text);
	const goals = steps[1].goals;
	assert.deepEqual(goals.map((g) => g.t), ['kill', 'collect', 'note'], 'the gotos are gone');
	for (const g of goals.slice(0, 2)) {
		assert.equal(g.map, 1429);
		assert.deepEqual([g.x, g.y], [47.6, 35.1], 'placed at the first point');
		assert.equal(g.spread, true);
		assert.deepEqual(g.spots, [
			{ x: 47.6, y: 35.1, r: 30, n: 0 },
			{ x: 49, y: 32.4, r: 20, n: 0 },
			{ x: 52.3, y: 26.8, r: 30, n: 0 },
		]);
	}
	assert.equal(goals[0].quest, 7);
	assert.equal(goals[0].count, 10);
	assert.equal(steps[1].loop, undefined, 'loop is a compile-time line, not a runtime key');
	assert.equal(packFormat(r.guides), 2);
});

test('a goal with its own @ coordinates keeps them; only the others join the circuit', () => {
	const { r, steps } = compiled(['step Accept', '  accept 7', 'step Loop', '  loop', '  goto 47.6,35.1', '  goto 52.3,26.8', '  kill 6 x10 quest 7.1', '  collect 750 x2 @40,60']);
	assert.deepEqual(r.errors, [], r.text);
	const [kill, collect] = steps[1].goals;
	assert.equal(kill.spots.length, 2);
	assert.deepEqual([collect.x, collect.y], [40, 60]);
	assert.notDeepEqual(collect.spots && collect.spots.map((s) => [s.x, s.y]), [[47.6, 35.1], [52.3, 26.8]]);
});

test('loop errors', () => {
	const err = (lines) => compile(guideText(lines)).errors.join('\n');
	assert.match(err(['step L', '  loop', '  goto 47.6,35.1', '  kill 6 x10']), /`loop` needs at least two `goto` points/);
	assert.match(err(['step L', '  loop', '  goto 47.6,35.1', '  goto 52.3,26.8', '  talk 197']), /`loop` needs a kill, collect or interact goal/);
	assert.match(err(['step L', '  loop', '  loop', '  goto 47.6,35.1', '  goto 52.3,26.8', '  kill 6']), /duplicate `loop` in step/);
	assert.match(err(['step L', '  loop now', '  goto 47.6,35.1', '  goto 52.3,26.8', '  kill 6']), /`loop` takes nothing/);
	assert.match(err(['step L', '  loop', '  goto 47.6,35.1', '  goto 50,50 map 1411', '  kill 6']), /`loop` points must all be on one map/);
});
