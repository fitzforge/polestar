#!/usr/bin/env node
'use strict';
// CI lanes (.github/workflows/ci.yml, docs/CI.md "Lanes"): what a pull request's changes need from the Tests job.
// Documentation alone takes the docs lane: the checks every tracked file gets (DOCS_TESTS: wording, names, SVGs).
// Anything else, or anything unsure, takes the full lane: the forge build, the Node suite, the changelog,
// translation and preview checks. Tests reports on every pull request either way, so the required check never
// waits. The Rust and Lua suites (forge.yml) start only on their own paths.
//
//   node tools/ci-lane.js <file>...         the lane and why
//   node tools/ci-lane.js --files <list>    the changed paths from a file, one a line (git diff --name-only)
//   --github                                also lane=<lane> and tests=<files> to $GITHUB_OUTPUT, the reasons to
//                                           $GITHUB_STEP_SUMMARY
//
// A changed file is documentation when it is under docs/ or .github/ISSUE_TEMPLATE/, or a .md at the
// repository's root or under .github/, and nothing the full lane runs reads it: no Node test
// (tools/testsel.js's mapping, the DOCS_TESTS aside) and none of the job's own checks (CI_READS: the changelog
// check reads CHANGELOG.md). Markdown in the code folders (changes/, tools/, tests/, skills/, addon/, guides/...)
// is a fragment, a template, a fixture or shipped with something: the full lane.

const fs = require('node:fs');
const path = require('node:path');

// Run in both lanes (`npm test` holds them too): each reads every tracked file, documentation included.
const DOCS_TESTS = ['tests/wording.test.js', 'tests/nameguard.test.js', 'tests/svg-assets.test.js'];
// Read by ci.yml's checks other than the Node suite.
const CI_READS = ['CHANGELOG.md'];
// Name documents without reading them: this script's own test, whose example paths testsel takes for reads.
const NOT_READERS = ['tests/ci-lane.test.js'];

const isDocPath = (f) => f.startsWith('docs/') || f.startsWith('.github/ISSUE_TEMPLATE/') || (f.endsWith('.md') && (!f.includes('/') || f.startsWith('.github/')));

// files: changed paths relative to the repository -> { lane: 'docs' | 'full', reasons: [string], tests: [path] }
// select: tools/testsel.js's select (a parameter for the tests).
function lane(files, { select = require('./testsel').select } = {}) {
	const changed = [...new Set(files.map((f) => f.trim()).filter(Boolean))];
	if (!changed.length) return { lane: 'full', reasons: ['no changed files listed'], tests: [] };
	const reasons = [];
	for (const f of changed) {
		if (!isDocPath(f)) reasons.push(`${f}: not documentation`);
		else if (CI_READS.includes(f)) reasons.push(`${f}: read by ci.yml's own checks`);
	}
	const docs = changed.filter(isDocPath);
	if (docs.length) {
		const root = path.join(__dirname, '..');
		for (const [test, why] of select(docs).selected) {
			const rel = path.relative(root, test).split(path.sep).join('/');
			if (!DOCS_TESTS.includes(rel) && !NOT_READERS.includes(rel)) reasons.push(`${rel} ${why.join(', ')}`);
		}
	}
	if (reasons.length) return { lane: 'full', reasons, tests: [] };
	return { lane: 'docs', reasons: [`documentation only (${changed.length} file${changed.length === 1 ? '' : 's'})`], tests: DOCS_TESTS };
}

function main(argv) {
	const github = argv.includes('--github');
	const at = argv.indexOf('--files');
	const files = at >= 0 ? fs.readFileSync(argv[at + 1], 'utf8').split('\n') : argv.filter((a) => !a.startsWith('--'));
	const r = lane(files);
	console.log(`lane: ${r.lane}`);
	for (const why of r.reasons) console.log(`  ${why}`);
	if (github) {
		fs.appendFileSync(process.env.GITHUB_OUTPUT, `lane=${r.lane}\ntests=${r.tests.join(' ')}\n`);
		const summary = [`## Lane: ${r.lane}`, '', ...r.reasons.slice(0, 50).map((w) => `- ${w}`), r.reasons.length > 50 ? `- and ${r.reasons.length - 50} more` : '', ''];
		fs.appendFileSync(process.env.GITHUB_STEP_SUMMARY, summary.join('\n'));
	}
	return 0;
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = { lane, isDocPath, DOCS_TESTS, CI_READS };
