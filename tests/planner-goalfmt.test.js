'use strict';
// The planner's goal lines (tools/lib/planner/goalfmt.js): a goal written back
// as the parser reads it, and a point inside a level played to the XP. The
// compiler's side of these goals is forge-guide's (dsl_level.rs, dsl_money_task.rs).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { levelReached } = require('../tools/lib/game/xp');
const { parseGoalLine, goalFields, formatGoal } = require('../tools/lib/planner/goalfmt');
const { guideText } = require('./helpers/dsl');

const goalOf = (line) => {
	const diag = new Diagnostics();
	const ast = parseGuide(guideText(['step S', `  ${line}`]), 'x.guide', diag);
	return { goal: ast.steps[0].goals[0], errors: diag.sorted().filter((d) => d.severity === 'error').map((d) => d.message) };
};

test('the planner writes the goal line back as written and plays it to the XP', () => {
	const line = (text) => formatGoal(goalFields(goalOf(text).goal));
	assert.equal(line('level 12.5'), 'level 12.5');
	assert.equal(line('level 12.05'), 'level 12.05');
	assert.equal(line('level 12+2500'), 'level 12+2500');
	assert.equal(line('level 12'), 'level 12');
	assert.throws(() => formatGoal({ verb: 'level', level: 12, frac: 1.5 }), /between 0 and 1/);
	// Done past the level, or at it with the share of its XP.
	assert.equal(levelReached({ level: 12, xp: 5049 }, 12, 0.5), false);
	assert.equal(levelReached({ level: 12, xp: 5050 }, 12, 0.5), true);
	assert.equal(levelReached({ level: 13, xp: 0 }, 12, 0.5), true);
	assert.equal(levelReached({ level: 11, xp: 8000 }, 12, 0.5), false);
	assert.equal(levelReached({ level: 12, xp: 0 }, 12), true);
});

test('the planner writes money and task goals back as the parser reads them', () => {
	const line = (text) => formatGoal(goalFields(parseGoalLine(text).goal));
	assert.equal(line('money 1s50c'), 'money 1s50c');
	assert.equal(line('money 350 optional'), 'money 3s50c optional');
	assert.equal(line('task Kill Gru\'ark when he becomes hostile'), 'task Kill Gru\'ark when he becomes hostile');
	assert.equal(line('task "Tame a Venomtail Scorpid" @45,60 optional'), 'task "Tame a Venomtail Scorpid" @45.0,60.0 optional');
	assert.equal(line('task "Logout skip" only Hunter'), 'task "Logout skip" only Hunter');
});
