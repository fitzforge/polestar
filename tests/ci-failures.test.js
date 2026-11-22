'use strict';
// tools/ci-failures.js (docs/CI.md, "Reference data"): the reporter records each failing test, and a run fails only
// on failures next's baseline lacks.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { compare } = require('../tools/ci-failures');
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
