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
