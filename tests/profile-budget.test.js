'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { withinBudget } = require('./helpers/profile');
const { assertTiming } = require('./helpers/timing');

const ROOT = path.join(__dirname, '..');
const workflow = (name) => fs.readFileSync(path.join(ROOT, '.github', 'workflows', name), 'utf8');

test('performance budgets account for one measured clock step, capped at one millisecond', () => {
	assert.equal(withinBudget(1, 1, 1, 1), true, 'a sub-ms frame can be reported as one whole ms');
	assert.equal(withinBudget(1.001, 1, 1, 0.001), false, 'a precise clock does not get millisecond slack');
	assert.equal(withinBudget(2, 1, 1, 1), false, 'two clock steps still exceed the frame budget');
	assert.equal(withinBudget(3, 1, 1, 100), false, 'a coarse clock cannot grant unbounded slack');
	assert.equal(withinBudget(8, 8, 1, 0), false, 'the exact budget remains a strict boundary');
	assert.equal(withinBudget(14, 8, 1.455, 1), false, 'the previous full-suite step failure is not waived');
});

test('performance budgets retain load calibration and reject invalid timing readings', () => {
	assert.equal(withinBudget(11, 8, 1.5, 0.001), true);
	assert.equal(withinBudget(12.001, 8, 1.5, 0.001), false);
	for (const bad of [NaN, Infinity, -1]) {
		assert.equal(withinBudget(bad, 1, 1, 0.001), false);
		assert.equal(withinBudget(0.1, 1, bad, 0.001), false);
		assert.equal(withinBudget(0.1, 1, 1, bad), false);
	}
	assert.equal(withinBudget(0.5, 1, 0, 0), false, 'a missing reference must not pass');
});

test('a reading over its timing budget fails where budgets are enforced and only warns where CI says warn', () => {
	assert.equal(assertTiming(true, 'unused', {}), null);
	assert.equal(assertTiming(true, 'unused', { POLESTAR_TIMING_BUDGETS: 'warn' }), null);
	assert.throws(() => assertTiming(false, 'burst over budget', {}), { message: 'burst over budget' });
	assert.throws(() => assertTiming(false, 'burst over budget', { POLESTAR_TIMING_BUDGETS: 'enforce' }), { message: 'burst over budget' });
	assert.equal(
		assertTiming(false, '50% over\nbudget', { POLESTAR_TIMING_BUDGETS: 'warn' }),
		'::warning title=Timing budget (POLESTAR_TIMING_BUDGETS=warn)::50%25 over%0Abudget',
	);
});

test("CI's timing budgets only warn: the workflows running forge-addontest and the Node suite say so", () => {
	for (const f of ['ci.yml', 'forge.yml', 'ondemand-suites.yml']) assert.match(workflow(f), /^\s+POLESTAR_TIMING_BUDGETS: warn$/m, f);
});

test('the release gate finds every timing test: each file using assert_timing! or assertTiming is in its list', { skip: process.platform === 'win32' && 'bash script' }, () => {
	const r = spawnSync('bash', ['rust/scripts/timing-budgets.sh', '--list'], { cwd: ROOT, encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	const listed = r.stdout.split('\n').filter(Boolean);
	for (const want of [
		'settings_perf::a_dragged_slider_repaints_once_a_frame_within_budget_and_lays_out_once_when_it_ends',
		'settings_session::a_session_in_the_settings_window_stays_within_each_action_s_budget_and_a_round_keeps_nothing_more',
		'recorder_perf::',
		'tests/perf.test.js',
		'tests/codex-lookup.test.js',
	]) assert.ok(listed.includes(want), `${want} in ${listed.join(', ')}`);
	const dir = path.join(ROOT, 'rust', 'crates', 'forge-addontest', 'tests', 'addontest');
	const using = fs.readdirSync(dir).filter((f) => f.endsWith('.rs') && fs.readFileSync(path.join(dir, f), 'utf8').includes('assert_timing!'));
	for (const f of using) {
		const mod = f.slice(0, -3).replace(/-/g, '_');
		assert.ok(listed.some((l) => l.startsWith(`${mod}::`)), `${f}: no test of it in the list`);
	}
	assert.ok(using.length >= 14, `files using assert_timing!: ${using.join(', ')}`);
});
