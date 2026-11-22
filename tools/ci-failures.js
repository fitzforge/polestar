#!/usr/bin/env node
'use strict';
// The failing Node tests of a run, and which of them are new against a baseline (docs/CI.md, "Reference data").
// On GitHub's runners the data-dependent tests run on public data (.github/actions/public-data), which is close to the
// release data but not equal to it: some tests fail on it on next too. next's run records its failures (the
// baseline); a pull request's run fails only on failures the baseline does not have.
//
//   node --test --test-reporter=spec --test-reporter-destination=stdout \
//     --test-reporter=./tools/ci-failures.js --test-reporter-destination=<run.jsonl> <files>
//                                       as a reporter: one JSON line per failing test, { file, name }
//   node tools/ci-failures.js compare <baseline.jsonl> <run.jsonl>
//                                       the run's failures the baseline lacks; exit 1 when there is one
//   --github                            also each new failure as an error annotation and a table in
//                                       $GITHUB_STEP_SUMMARY

const fs = require('node:fs');
const path = require('node:path');

const ROOT = path.join(__dirname, '..');
const rel = (file) => (file ? path.relative(ROOT, file.startsWith('file:') ? new URL(file).pathname : file).split(path.sep).join('/') : '');

// The reporter: node:test's events in, a JSON line per failing test out. A failing subtest fails the tests around it
// too; each is a line.
async function* reporter(source) {
	for await (const event of source) {
		if (event.type !== 'test:fail') continue;
		const { file, name } = event.data;
		yield `${JSON.stringify({ file: rel(file), name })}\n`;
	}
}

const key = (f) => `${f.file}\u0000${f.name}`;
// A JSON lines file -> [{ file, name }]; a missing file is none.
function read(file) {
	if (!fs.existsSync(file)) return [];
	return fs.readFileSync(file, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
}

// baseline, run: [{ file, name }] -> { added: failures of the run the baseline lacks, known: those it has }
function compare(baseline, run) {
	const base = new Set(baseline.map(key));
	const seen = new Set();
	const added = [];
	const known = [];
	for (const f of run) {
		const k = key(f);
		if (seen.has(k)) continue;
		seen.add(k);
		(base.has(k) ? known : added).push(f);
	}
	return { added, known };
}

function main(argv) {
	const github = argv.includes('--github');
	const args = argv.filter((a) => a !== '--github');
	if (args[0] !== 'compare' || args.length !== 3) {
		console.error('usage: node tools/ci-failures.js compare <baseline.jsonl> <run.jsonl> [--github]');
		return 2;
	}
	const { added, known } = compare(read(args[1]), read(args[2]));
	console.log(`${known.length} failure(s) next has too (the public data's, not this change's); ${added.length} new`);
	for (const f of known) console.log(`  known: ${f.file}: ${f.name}`);
	for (const f of added) console.log(`  NEW:   ${f.file}: ${f.name}`);
	if (github) {
		for (const f of added) console.log(`::error file=${f.file}::${f.name.replace(/[\r\n]+/g, ' ')} fails here and passes on next`);
		const rows = ['## Tests on public data', '', `${added.length} new failure(s); ${known.length} failing on next too (left out).`, ''];
		if (added.length) rows.push('| file | test |', '|---|---|', ...added.map((f) => `| ${f.file} | ${f.name.replace(/\|/g, '\\|')} |`), '');
		fs.appendFileSync(process.env.GITHUB_STEP_SUMMARY, rows.join('\n'));
	}
	return added.length ? 1 : 0;
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = reporter;
module.exports.compare = compare;
module.exports.read = read;
