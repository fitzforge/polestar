'use strict';
// Regenerates rust/tests/golden/honest/: the JS honest playtest (`playtest --honest`: tools/lib/playtest.js
// playtest({ official: true, honest: true }), through forge-judge/tests/js/honest-ref.js) on a pack made
// from the guide slice (rust/tests/golden/guide/slice) that compiles without errors on the data slice
// (rust/tests/golden/world/root/data/forever). The slice data has no QuestieDB, so some goal lines name
// quests, items or objectives it lacks; playtest refuses a pack with compile errors. drop.json lists those
// lines (file -> line numbers), found by compiling until no error is left; the tests blank them the same
// way (forge-judge/tests/common clean_slice: the line emptied, so line numbers stay) and play the result.
// No knowledge base. Not run in CI.
// usage: JS_ROOT=<tree> node rust/tests/golden/honest/regen.js   (JS_ROOT: the JS tree, see README.md)
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { execFileSync } = require('node:child_process');

const HERE = __dirname;
const GOLDEN = path.resolve(HERE, '..');
if (!process.env.JS_ROOT) {
	console.error('usage: JS_ROOT=<tree> node rust/tests/golden/honest/regen.js (see README.md for the tree)');
	process.exit(2);
}
const JS = path.resolve(process.env.JS_ROOT);
const REF = path.resolve(GOLDEN, '../../crates/forge-judge/tests/js/honest-ref.js');
/// (case, filter): forge-judge/tests/honest_parity.rs honest_parity_slice's.
const CASES = [
	['orc', 'forever/horde/'],
	['human', 'forever/alliance/'],
];

const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'honest-golden-'));
// Temp copies: the JS reads them only, but it never gets a path into the golden dirs.
const DATA = path.join(tmp, 'forever');
fs.cpSync(path.join(GOLDEN, 'world/root/data/forever'), DATA, { recursive: true });
const PACK = path.join(tmp, 'slice');
fs.cpSync(path.join(GOLDEN, 'guide/slice'), PACK, { recursive: true });

const { compileProject } = require(path.join(JS, 'tools/lib/dsl/project'));
const drop = {};
for (let round = 1; ; round++) {
	const cwd = process.cwd();
	process.chdir(tmp); // diagnostics name files relative to the working directory
	const { diag } = compileProject({ packDir: PACK, dataDir: DATA });
	process.chdir(cwd);
	const errors = diag.list.filter((d) => d.severity === 'error');
	if (errors.some((d) => !d.file || !d.line)) throw new Error(`an error without a line: ${JSON.stringify(errors.find((d) => !d.file || !d.line))}`);
	if (!errors.length) break;
	if (round > 20) throw new Error('errors left after 20 rounds');
	const now = new Set();
	for (const e of errors) {
		const rel = path.relative(PACK, path.resolve(tmp, e.file));
		if (now.has(`${rel}:${e.line}`)) continue; // two errors on one line
		now.add(`${rel}:${e.line}`);
		const file = path.join(PACK, rel);
		const lines = fs.readFileSync(file, 'utf8').split('\n');
		if (lines[e.line - 1] === '') throw new Error(`${rel}:${e.line} still fails once dropped: ${e.message}`);
		// A blank line, not a comment: with comment lines inside steps, forge's route writer wrote work before its accepts (README.md).
		lines[e.line - 1] = '';
		fs.writeFileSync(file, lines.join('\n'));
		(drop[rel] ||= []).push(e.line);
	}
	console.error(`round ${round}: ${now.size} error lines dropped`);
}
const sorted = Object.fromEntries(Object.keys(drop).sort().map((f) => [f, [...new Set(drop[f])].sort((a, b) => a - b)]));
fs.writeFileSync(path.join(HERE, 'drop.json'), `${JSON.stringify({ lines: sorted }, null, 1)}\n`);

for (const [name, filter] of CASES) {
	const out = path.join(tmp, `${name}.json`);
	execFileSync('node', [REF, PACK, filter, out, '--data', DATA], { env: { ...process.env, POLESTAR_HONEST_JS: JS }, stdio: 'inherit' });
	const text = fs.readFileSync(out, 'utf8');
	if (text.includes(tmp)) throw new Error(`${name}: the reference holds the temp path`);
	fs.writeFileSync(path.join(HERE, `${name}.json`), text);
}
fs.rmSync(tmp, { recursive: true, force: true });
