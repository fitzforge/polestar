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

// The reporter: node:test's events in, a JSON line per test out: { file, name } for a failing one, { file, name, ok:
// true } for a passing one (the baseline needs both: a failure is new only against a test next has run). A failing
// subtest fails the tests around it too; each is a line.
async function* reporter(source) {
	for await (const event of source) {
		if (event.type !== 'test:fail' && event.type !== 'test:pass') continue;
		const { file, name } = event.data;
		yield `${JSON.stringify(event.type === 'test:pass' ? { file: rel(file), name, ok: true } : { file: rel(file), name })}\n`;
	}
}

const key = (f) => `${f.file}\u0000${f.name}`;
// A JSON lines file -> [{ file, name, ok? }]; a missing file is none.
function read(file) {
	if (!fs.existsSync(file)) return [];
	return fs.readFileSync(file, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
}

// Whether next has run a test at all: in the baseline (when it lists passing tests too), else named in the base
// checkout's copy of its file (a baseline from before passes were recorded).
function seenOnNext(baseline, baseDir) {
	const names = new Set(baseline.map(key));
	if (baseline.some((f) => f.ok)) return (f) => names.has(key(f));
	return (f) => {
		if (!baseDir) return true;
		const p = path.join(baseDir, f.file);
		return fs.existsSync(p) && fs.readFileSync(p, 'utf8').includes(f.name);
	};
}

// baseline, run: [{ file, name, ok? }] -> { added: the run's failures next passes, unseen: failures of tests next
// has not run (new or renamed), known: failures next has too }
function compare(baseline, run, { baseDir = null } = {}) {
	const failing = new Set(baseline.filter((f) => !f.ok).map(key));
	const seen = seenOnNext(baseline, baseDir);
	const done = new Set();
	const out = { added: [], unseen: [], known: [] };
	for (const f of run) {
		const k = key(f);
		if (f.ok || done.has(k)) continue;
		done.add(k);
		(failing.has(k) ? out.known : seen(f) ? out.added : out.unseen).push({ file: f.file, name: f.name });
	}
	return out;
}

// --unseen-ok: a failure of a test next has not run only warns (this repository's own branches: their Release
// data job runs it on the release data). --base <dir>: the base checkout, for a baseline without passing tests.
function main(argv) {
	const github = argv.includes('--github');
	const unseenOk = argv.includes('--unseen-ok');
	const at = argv.indexOf('--base');
	const baseDir = at >= 0 ? argv[at + 1] : null;
	const args = argv.filter((a, i) => !['--github', '--unseen-ok', '--base'].includes(a) && !(at >= 0 && i === at + 1));
	if (args[0] !== 'compare' || args.length !== 3) {
		console.error('usage: node tools/ci-failures.js compare <baseline.jsonl> <run.jsonl> [--github] [--unseen-ok] [--base <dir>]');
		return 2;
	}
	const { added, unseen, known } = compare(read(args[1]), read(args[2]), { baseDir });
	console.log(`${known.length} failure(s) next has too (the public data's, not this change's); ${added.length} new; ${unseen.length} of tests next has not run`);
	for (const f of known) console.log(`  known:  ${f.file}: ${f.name}`);
	for (const f of added) console.log(`  NEW:    ${f.file}: ${f.name}`);
	for (const f of unseen) console.log(`  UNSEEN: ${f.file}: ${f.name}`);
	const failing = unseenOk ? added : [...added, ...unseen];
	if (github) {
		for (const f of added) console.log(`::error file=${f.file}::${f.name.replace(/[\r\n]+/g, ' ')} fails here and passes on next`);
		for (const f of unseen) console.log(`::${unseenOk ? 'warning' : 'error'} file=${f.file}::${f.name.replace(/[\r\n]+/g, ' ')} fails on the public data and next has no such test${unseenOk ? ': the Release data job runs it on the release data' : ''}`);
		const rows = ['## Tests on public data', '', `${added.length} new failure(s); ${unseen.length} failure(s) of tests next has not run${unseenOk ? ' (warnings: Release data runs them)' : ''}; ${known.length} failing on next too (left out).`, ''];
		const list = [...added, ...unseen];
		if (list.length) rows.push('| file | test |', '|---|---|', ...list.map((f) => `| ${f.file} | ${f.name.replace(/\|/g, '\\|')} |`), '');
		fs.appendFileSync(process.env.GITHUB_STEP_SUMMARY, rows.join('\n'));
	}
	return failing.length ? 1 : 0;
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = reporter;
module.exports.compare = compare;
module.exports.read = read;
