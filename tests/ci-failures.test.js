'use strict';
// tools/ci-failures.js and tools/ci-tests.sh (docs/CI.md, "Reference data"): the reporter records each test, and a
// run fails only on failures next's baseline lacks and the base checkout does not have either.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { compare, rerunArgs } = require('../tools/ci-failures');
const { tmpdir } = require('./helpers/tmp');

const ROOT = path.join(__dirname, '..');
const TOOL = path.join(ROOT, 'tools', 'ci-failures.js');

test('compare: a failure the baseline has is known, one of a test next passes is new, one of a test next never ran is unseen', () => {
	const base = [{ file: 'tests/a.test.js', name: 'x' }, { file: 'tests/a.test.js', name: 'y', ok: true }, { file: 'tests/b.test.js', name: 'x', ok: true }];
	const run = [{ file: 'tests/a.test.js', name: 'x' }, { file: 'tests/a.test.js', name: 'y' }, { file: 'tests/a.test.js', name: 'y' }, { file: 'tests/b.test.js', name: 'x' }, { file: 'tests/b.test.js', name: 'renamed' }, { file: 'tests/b.test.js', name: 'z', ok: true }];
	assert.deepEqual(compare(base, run), {
		known: [{ file: 'tests/a.test.js', name: 'x' }],
		added: [{ file: 'tests/a.test.js', name: 'y' }, { file: 'tests/b.test.js', name: 'x' }],
		unseen: [{ file: 'tests/b.test.js', name: 'renamed' }],
	});
	assert.deepEqual(compare(base, []), { known: [], added: [], unseen: [] });
});

test('compare: a baseline of failures only tells a new test by its name in the base checkout\'s file', () => {
	const baseDir = tmpdir('ci-failures-base-');
	fs.mkdirSync(path.join(baseDir, 'tests'));
	fs.writeFileSync(path.join(baseDir, 'tests', 'a.test.js'), "test('old name', () => {});\n");
	const base = [{ file: 'tests/a.test.js', name: 'x' }];
	const run = [{ file: 'tests/a.test.js', name: 'old name' }, { file: 'tests/a.test.js', name: 'new name' }];
	assert.deepEqual(compare(base, run, { baseDir }), { known: [], added: [{ file: 'tests/a.test.js', name: 'old name' }], unseen: [{ file: 'tests/a.test.js', name: 'new name' }] });
	// Without the base checkout every failure the baseline lacks is new.
	assert.equal(compare(base, run).added.length, 2);
});

test('the reporter writes a line per test, and the compare command fails on a new failure, an unseen one only without --unseen-ok', () => {
	const dir = tmpdir('ci-failures-');
	const file = path.join(dir, 'sample.test.js');
	fs.writeFileSync(file, "const { test } = require('node:test');\ntest('passes', () => {});\ntest('fails', () => { throw new Error('no'); });\n");
	// A node --test of its own: without the parent run's context, which would make it skip its files.
	const env = { ...process.env };
	delete env.NODE_TEST_CONTEXT;
	const out = path.join(dir, 'run.jsonl');
	const r = spawnSync(process.execPath, ['--test', '--test-reporter=dot', '--test-reporter-destination=stdout', `--test-reporter=${TOOL}`, `--test-reporter-destination=${out}`, file], { cwd: ROOT, env, encoding: 'utf8' });
	assert.equal(r.status, 1, r.stdout + r.stderr);
	const lines = fs.readFileSync(out, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
	assert.deepEqual(lines.map((l) => [l.name, !!l.ok]).sort(), [['fails', false], ['passes', true]]);
	const run = (...args) => spawnSync(process.execPath, [TOOL, 'compare', ...args], { encoding: 'utf8' });
	// The test passed on next: new.
	const passed = path.join(dir, 'passed.jsonl');
	fs.writeFileSync(passed, lines.map((l) => JSON.stringify({ ...l, ok: true })).join('\n'));
	assert.equal(run(passed, out).status, 1);
	assert.match(run(passed, out).stdout, /NEW: .*fails/);
	// Next never ran it: unseen, failing unless --unseen-ok.
	const other = path.join(dir, 'other.jsonl');
	fs.writeFileSync(other, JSON.stringify({ file: 'tests/x.test.js', name: 'other', ok: true }));
	assert.equal(run(other, out).status, 1);
	assert.equal(run(other, out, '--unseen-ok').status, 0);
	// Next fails it too: known.
	assert.equal(run(out, out).status, 0);
	assert.equal(run(out).status, 2);
});

test('compare: a failure the baseline has not run is next\'s when the base checkout fails it too, new when it passes there', () => {
	const base = [{ file: 'tests/a.test.js', name: 'old', ok: true }];
	const run = [{ file: 'tests/a.test.js', name: 'merged to next since' }, { file: 'tests/a.test.js', name: 'next passes it' }, { file: 'tests/a.test.js', name: 'the change adds it' }];
	const baseRun = [{ file: 'tests/a.test.js', name: 'merged to next since' }, { file: 'tests/a.test.js', name: 'next passes it', ok: true }];
	assert.deepEqual(compare(base, run, { baseRun }), {
		known: [{ file: 'tests/a.test.js', name: 'merged to next since' }],
		added: [{ file: 'tests/a.test.js', name: 'next passes it' }],
		unseen: [{ file: 'tests/a.test.js', name: 'the change adds it' }],
	});
});

test('rerunArgs: an exact name pattern per unseen failure, then the files the base checkout has', () => {
	const baseDir = tmpdir('ci-failures-base-');
	fs.mkdirSync(path.join(baseDir, 'tests'));
	fs.writeFileSync(path.join(baseDir, 'tests', 'a.test.js'), '');
	const name = "#3823 Cooking 1-300: a recipe's learn (x) [y] leads to $1 a.b/c|d? \\";
	const args = rerunArgs([{ file: 'tests/a.test.js', name }, { file: 'tests/a.test.js', name }, { file: 'tests/new.test.js', name: 'only here' }], baseDir);
	assert.equal(args.length, 2);
	assert.equal(args[1], 'tests/a.test.js');
	const pattern = new RegExp(args[0].slice('--test-name-pattern='.length));
	assert.ok(pattern.test(name));
	assert.ok(!pattern.test(`${name} more`) && !pattern.test(name.slice(1)));
	assert.deepEqual(rerunArgs([{ file: 'tests/new.test.js', name: 'only here' }], baseDir), []);
});

test('ci-tests.sh: a failure the baseline has not run is run again in the base checkout; only one the base passes or lacks fails', () => {
	const tmp = tmpdir('ci-tests-');
	const checkout = (dir, tests) => {
		fs.mkdirSync(path.join(dir, 'tests'), { recursive: true });
		fs.writeFileSync(path.join(dir, 'tests', 's.test.js'), `const { test } = require('node:test');\n${tests.map(([name, ok]) => `test(${JSON.stringify(name)}, () => { ${ok ? '' : "throw new Error('no');"} });`).join('\n')}\n`);
		return dir;
	};
	const head = (tests) => {
		const dir = checkout(fs.mkdtempSync(path.join(tmp, 'head-')), tests);
		fs.mkdirSync(path.join(dir, 'tools'));
		for (const f of ['ci-tests.sh', 'ci-failures.js']) fs.copyFileSync(path.join(ROOT, 'tools', f), path.join(dir, 'tools', f));
		return dir;
	};
	// next's tree: a test merged since the baseline that fails on this data, and one that passes.
	const merged = "#3823 Cooking: a recipe's learn (merged since)";
	const base = checkout(path.join(tmp, 'base'), [['old', true], [merged, false], ['next passes it', true]]);
	const baseline = path.join(tmp, 'baseline.jsonl');
	fs.writeFileSync(baseline, `${JSON.stringify({ file: 'tests/s.test.js', name: 'old', ok: true })}\n`);
	const env = { ...process.env, CI_BASE: base, RUNNER_TEMP: tmp };
	delete env.NODE_TEST_CONTEXT;
	delete env.GITHUB_ACTIONS;
	delete env.CI_UNSEEN_OK;
	const run = (dir, extra = {}) => spawnSync('bash', ['tools/ci-tests.sh', baseline, 'tests/s.test.js'], { cwd: dir, env: { ...env, ...extra }, encoding: 'utf8' });
	const broken = head([['old', true], [merged, false], ['next passes it', false], ['the change adds it', false]]);
	let r = run(broken);
	assert.equal(r.status, 1, r.stdout + r.stderr);
	assert.match(r.stdout, /known: {2}tests\/s\.test\.js: #3823 Cooking/);
	assert.match(r.stdout, /NEW: {4}tests\/s\.test\.js: next passes it/);
	assert.match(r.stdout, /UNSEEN: tests\/s\.test\.js: the change adds it/);
	assert.equal(run(broken, { CI_UNSEEN_OK: '1' }).status, 1, 'a failure the base passes fails our branches too');
	// Only next's failing test and the change's own: a fork fails on its own test, our branches warn.
	const own = head([['old', true], [merged, false], ['next passes it', true], ['the change adds it', false]]);
	assert.equal(run(own).status, 1);
	r = run(own, { CI_UNSEEN_OK: '1' });
	assert.equal(r.status, 0, r.stdout + r.stderr);
	// Next's failing test alone fails no pull request.
	const clean = head([['old', true], [merged, false], ['next passes it', true]]);
	r = run(clean);
	assert.equal(r.status, 0, r.stdout + r.stderr);
	assert.match(r.stdout, /1 failure\(s\) next has too/);
});
