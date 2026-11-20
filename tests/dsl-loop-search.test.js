'use strict';
// `loop` beside goals that are no kill, collect or interact (docs/GUIDE_FORMAT.md, "Spawn areas",
// Loop): a `skill` goal takes the step's points for a gathering round, and in a step with nothing
// else to search the points are where to look for an NPC who walks, so its accept, turnin and
// talk goals take them. The JS twin of forge-guide's tests/guide/dsl_loop.rs; the engine side is
// tests/engine-loop-search.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { guideText, compile, plain } = require('./helpers/dsl');
const { formatFor, FORMAT } = require('../tools/lib/pack/format');
const { readFileSync } = require('node:fs');
const { Data } = require('../tools/lib/dsl/data');

const goalsOf = (r, s = 0) => plain(r.guides[0].steps)[s].goals;
const POINTS = ['  loop', '  goto 47.6,35.1', '  goto 49.0,32.4 r 20'];

test('`loop` places a `skill` goal on its points, as it does a kill, collect or interact', () => {
	const r = compile(guideText(['step Copper round', ...POINTS, '  skill Mining 50']));
	assert.deepEqual(r.errors, [], r.text);
	const goals = goalsOf(r);
	assert.equal(goals.length, 1, 'the gotos leave the step');
	const [skill] = goals;
	assert.deepEqual([skill.t, skill.level, skill.map, skill.x, skill.y, skill.spread], ['skill', 50, 1429, 47.6, 35.1, true]);
	assert.deepEqual(skill.spots, [{ x: 47.6, y: 35.1, r: 30 }, { x: 49, y: 32.4, r: 20 }]);
	assert.equal(formatFor(r.guides), FORMAT, 'no pack format change');
});

test('the displacer and its kill share only the four authored silo points', () => {
	const text = readFileSync(require.resolve('./fixtures/dsl/silo-loop.guide'), 'utf8');
	const r = compile(text, new Data(require('./fixtures/dsl/silo-loop.json')));
	assert.deepEqual(r.errors, [], r.text);
	const goals = goalsOf(r, 1);
	assert.deepEqual(goals.map((g) => [g.t, g.item ?? g.npc]), [['use', 12627], ['kill', 10717]]);
	for (const g of goals) {
		assert.deepEqual(g.spots?.map((p) => [p.x, p.y, p.r]), [[45.15, 62.28, 8], [46.38, 62.33, 8], [47.83, 63.45, 8], [48.45, 62.81, 8]], g.t);
		assert.deepEqual([g.quest, g.oi, g.map, g.x, g.y, g.spread], [4971, 1, 1422, 45.15, 62.28, true]);
	}
	assert.ok(!r.warnings.some((w) => w.includes('has no coordinates')), r.text);
});

test('`loop` with nothing else to search places the NPC of an accept, turnin or talk on its points', () => {
	const r = compile(guideText(['step A deputy on his rounds', ...POINTS, '  accept 783', '  talk 197', 'step Back', ...POINTS, '  turnin 783']));
	assert.deepEqual(r.errors, [], r.text);
	for (const goal of [...goalsOf(r, 0), ...goalsOf(r, 1)]) {
		assert.deepEqual([goal.map, goal.x, goal.y, goal.spread, goal.spots.length], [1429, 47.6, 35.1, true, 2], goal.t);
	}
	assert.deepEqual(goalsOf(r, 0).map((g) => g.t), ['accept', 'talk']);
	assert.deepEqual(goalsOf(r, 1).map((g) => g.t), ['turnin']);
	assert.equal(formatFor(r.guides), FORMAT, 'no pack format change');
});

test('beside a goal the loop searches for, an accept keeps the place the data gives it', () => {
	const alone = goalsOf(compile(guideText(['step Willem', '  accept 783'])))[0];
	const r = compile(guideText(['step Kobolds', ...POINTS, '  accept 783', '  kill 6']));
	assert.deepEqual(r.errors, [], r.text);
	const [accept, kill] = goalsOf(r);
	assert.deepEqual(accept, alone);
	assert.equal(kill.spread, true);
});

test('a loop with no goal to place is an error that names what it takes', () => {
	const message = /`loop` needs an unpinned kill, collect, interact, skill or `use … quest Q.O` goal, or with none of those an accept, turnin or talk/;
	for (const goal of ['note Nobody here', 'talk 197 @50,30', 'kill 6 @50,30', 'use 750 quest 7.1 @50,30', 'use 750']) {
		const r = compile(guideText(['step L', ...POINTS, `  ${goal}`]));
		assert.equal(r.errors.filter((e) => message.test(e)).length, 1, goal);
	}
});

test("the format reference's loop examples compile", () => {
	const copper = compile(guideText(['step Copper, round the hills', '  loop', '  goto 47.6,35.1', '  goto 49.0,32.4', '  goto 52.3,26.8', '  skill Mining 50']));
	assert.deepEqual(copper.errors, [], copper.text);
	const willem = compile(guideText(['step Deputy Willem, somewhere on his rounds', '  loop', '  goto 48.2,42.0', '  goto 46.9,40.3', '  goto 45.5,42.6', '  accept 783', 'step Hand in', '  turnin 783']));
	assert.deepEqual(willem.errors, [], willem.text);
	assert.equal(goalsOf(willem)[0].spots.length, 3);
});
