'use strict';
// tools/testsel.js: a change maps to the test files that can see it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { select } = require('../tools/testsel');

const ROOT = path.join(__dirname, '..');
const picked = (changed) => {
	const { selected, unmapped } = select(changed);
	return { files: [...selected.keys()].map((f) => path.relative(ROOT, f).split(path.sep).join('/')), selected, unmapped };
};

test('a tools module selects the tests that require it, and a test file selects itself', () => {
	const { files, selected, unmapped } = picked(['tools/lib/sim/walklookup.js', 'tests/guides-parse.test.js']);
	assert.ok(files.includes('tests/sim-walklookup.test.js'));
	assert.deepEqual(selected.get(path.join(ROOT, 'tests', 'sim-walklookup.test.js')), ['requires tools/lib/sim/walklookup.js']);
	assert.ok(files.includes('tests/guides-parse.test.js'));
	assert.ok(!files.includes('tests/guides.test.js'));
	assert.ok(!files.includes('tests/core.test.js'));
	assert.deepEqual(unmapped, []);
});

test('runFiles runs each file in its own process, one at a time while memory is short, and fails when one fails', async () => {
	const fs = require('node:fs');
	const { runFiles } = require('../tools/testsel');
	const { tmpdir } = require('./helpers/tmp');
	const dir = tmpdir('polestar-testsel-');
	const write = (name, body) => {
		const f = path.join(dir, name);
		fs.writeFileSync(f, `const { test } = require('node:test');\ntest('t', () => { ${body} });\n`);
		return f;
	};
	const files = [write('a.test.js', ''), write('b.test.js', "throw new Error('boom');"), write('c.test.js', '')];
	const lines = [];
	let asked = 0;
	// Memory always short: a file starts only when none runs.
	const code = await runFiles(files, { jobs: 3, reserveGb: 6, cwd: dir, log: (m) => lines.push(m), memAvailable: () => (++asked, 1) });
	assert.equal(code, 1);
	assert.ok(asked >= 1, 'it asked for memory before starting a second file');
	assert.equal(lines.filter((l) => /^ok /.test(l)).length, 2);
	assert.match(lines.find((l) => /^FAIL /.test(l)), /b\.test\.js[\s\S]*boom/);
	assert.match(lines.at(-1), /^2 of 3 files passed/);
});

test('CLI validates job counts and still runs tests with valid or default jobs', async (t) => {
	const fs = require('node:fs');
	const { spawnSync } = require('node:child_process');
	const { tmpdir } = require('./helpers/tmp');
	const dir = tmpdir('polestar-testsel-cli-');
	// A small project exercises the real CLI without recursively running this test.
	for (const file of ['tools/testsel.js', 'tools/lib/requires.js']) {
		fs.mkdirSync(path.dirname(path.join(dir, file)), { recursive: true });
		fs.copyFileSync(path.join(ROOT, file), path.join(dir, file));
	}
	fs.mkdirSync(path.join(dir, 'tests'));
	fs.writeFileSync(path.join(dir, 'tests/fail.test.js'), "throw new Error('fixture ran');\n");
	const env = { ...process.env };
	delete env.NODE_TEST_CONTEXT;
	const run = (args) => spawnSync(process.execPath, ['tools/testsel.js', '--run', 'tests/fail.test.js', ...args], { cwd: dir, env, encoding: 'utf8', timeout: 10000 });
	for (const value of ['0', '-1', '1.5', 'nope', 'Infinity', '', '--json', undefined]) {
		await t.test(`rejects ${value === undefined ? 'a missing value' : JSON.stringify(value)}`, () => {
			const result = run(['--jobs', ...(value === undefined ? [] : [value])]);
			assert.ifError(result.error);
			assert.equal(result.status, 2);
			assert.match(result.stderr, /--jobs needs a positive integer/);
			assert.equal(result.stdout, '', 'invalid jobs must fail before selecting or running tests');
		});
	}
	for (const args of [[], ['--jobs', '1'], ['--jobs', '2']]) {
		await t.test(`runs with ${args.length ? args.join(' ') : 'default jobs'}`, () => {
			const result = run(args);
			assert.ifError(result.error);
			assert.equal(result.status, 1);
			assert.equal(result.stderr, '');
			assert.match(result.stdout, /FAIL[\s\S]*fixture ran/);
			assert.match(result.stdout, /0 of 1 files passed/);
		});
	}
});
