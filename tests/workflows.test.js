'use strict';
// GitHub runs a `run` step under `bash -e {0}` unless a shell is named: without pipefail,
// `cargo test … 2>&1 | tee log` passes when the tests fail. The workflows name `shell: bash`
// (bash with pipefail) in their `defaults.run`, but a job's own `defaults.run` replaces the
// workflow's whole: a job that sets only its working-directory there runs every step without
// pipefail (the on-demand Rust workspace job went green over a failing test that way). So every
// job-level `defaults.run` names `shell: bash` again.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');

const DIR = path.join(__dirname, '..', '.github', 'workflows');

const indent = (l) => l.length - l.trimStart().length;
const skip = (l) => l.trim() === '' || l.trimStart().startsWith('#');
const value = (l) => l.slice(l.indexOf(':') + 1).replace(/\s+#.*$/, '').trim();

// Every job-level `defaults.run` of a workflow: { job, line, shell } (shell: its `shell:` value,
// or null). Read by indentation, two spaces a level as every workflow here is written; a
// `defaults:` written inline (`defaults: { run: … }`) comes back with shell '(inline)'.
function jobDefaults(text) {
	const lines = text.split('\n');
	const found = [];
	let inJobs = false;
	let job = null;
	let block = null; // the `defaults.run` being read
	let inDefaults = false;
	lines.forEach((l, i) => {
		if (skip(l)) return;
		const ind = indent(l);
		if (ind === 0) {
			inJobs = /^jobs:\s*(#.*)?$/.test(l);
			job = null;
			inDefaults = false;
			block = null;
			return;
		}
		if (!inJobs) return;
		if (ind === 2) {
			job = /^ {2}([\w-]+):/.exec(l)?.[1] ?? null;
			inDefaults = false;
			block = null;
			return;
		}
		if (!job) return;
		if (ind === 4) {
			block = null;
			inDefaults = /^ {4}defaults:/.test(l);
			if (inDefaults && value(l) !== '') found.push({ job, line: i + 1, shell: '(inline)' });
			return;
		}
		if (!inDefaults) return;
		if (ind === 6) {
			block = null;
			if (/^ {6}run:/.test(l)) {
				block = { job, line: i + 1, shell: value(l) === '' ? null : '(inline)' };
				found.push(block);
			}
			return;
		}
		if (block && ind === 8 && /^ {8}shell:/.test(l)) block.shell = value(l).replace(/^(['"])(.*)\1$/, '$2');
	});
	return found;
}

test('workflows: every job that sets its own defaults.run names shell: bash (steps keep pipefail)', () => {
	const files = fs.readdirSync(DIR).filter((f) => /\.ya?ml$/.test(f));
	assert.ok(files.length > 0, `no workflows in ${DIR}`);
	let seen = 0;
	const bad = [];
	for (const f of files) {
		for (const d of jobDefaults(fs.readFileSync(path.join(DIR, f), 'utf8'))) {
			seen++;
			if (d.shell !== 'bash') {
				bad.push(`.github/workflows/${f}:${d.line} job ${d.job}: defaults.run has ${d.shell === null ? 'no shell' : `shell ${d.shell}`}; add \`shell: bash\` under it`);
			}
		}
	}
	assert.deepEqual(bad, []);
	assert.ok(seen > 0, 'read no job-level defaults.run at all: the reader no longer matches how the workflows are written');
});

test('workflows: the defaults reader finds job-level blocks only, and their shell', () => {
	const yml = [
		'on: push',
		'defaults:',
		'  run:',
		'    shell: bash',
		'jobs:',
		'  plain:',
		'    runs-on: ubuntu-latest',
		'    steps:',
		'      - run: echo defaults:',
		'  lost:',
		'    defaults:',
		'      run:',
		'        working-directory: code # no shell',
		'    steps:',
		'      - run: cargo test | tee log',
		'  kept:',
		'    defaults:',
		'      run:',
		'        # pipefail',
		'        working-directory: code/rust',
		"        shell: 'bash'",
		'  other:',
		'    defaults:',
		'      run:',
		'        shell: sh',
		'  flow:',
		'    defaults: { run: { working-directory: code } }',
		'env:',
		'  defaults: x',
	].join('\n');
	assert.deepEqual(jobDefaults(yml), [
		{ job: 'lost', line: 12, shell: null },
		{ job: 'kept', line: 18, shell: 'bash' },
		{ job: 'other', line: 24, shell: 'sh' },
		{ job: 'flow', line: 27, shell: '(inline)' },
	]);
});
