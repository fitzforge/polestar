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

test('compare: a failure the baseline has is known, any other is new; repeats count once', () => {
	const base = [{ file: 'tests/a.test.js', name: 'x' }];
	const run = [{ file: 'tests/a.test.js', name: 'x' }, { file: 'tests/a.test.js', name: 'y' }, { file: 'tests/a.test.js', name: 'y' }, { file: 'tests/b.test.js', name: 'x' }];
	assert.deepEqual(compare(base, run), {
		known: [{ file: 'tests/a.test.js', name: 'x' }],
		added: [{ file: 'tests/a.test.js', name: 'y' }, { file: 'tests/b.test.js', name: 'x' }],
	});
	assert.deepEqual(compare(base, []), { known: [], added: [] });
});

test('the reporter writes a line per failing test, and the compare command fails on a new one only', () => {
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
	assert.deepEqual(lines.map((l) => l.name), ['fails']);
	const empty = path.join(dir, 'empty.jsonl');
	fs.writeFileSync(empty, '');
	const added = spawnSync(process.execPath, [TOOL, 'compare', empty, out], { encoding: 'utf8' });
	assert.equal(added.status, 1, added.stdout);
	assert.match(added.stdout, /NEW: .*fails/);
	const known = spawnSync(process.execPath, [TOOL, 'compare', out, out], { encoding: 'utf8' });
	assert.equal(known.status, 0, known.stdout);
	assert.equal(spawnSync(process.execPath, [TOOL, 'compare', out], { encoding: 'utf8' }).status, 2);
});
