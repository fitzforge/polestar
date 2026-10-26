'use strict';
// Regenerates rust/tests/golden/guidetext/<case>.json.gz: guidetext.js scoreTarget (via
// forge-judge/tests/js/guidetext-dump.js: the result, its goals with the sim replay's levels, the sim view)
// on the committed guide slice (rust/tests/golden/guide/slice) and data slice
// (rust/tests/golden/world/root/data/forever), its sim dir the golden slice worlds
// (rust/tests/golden/world/expected) with the committed params (rust/tests/golden/sim/params.json). No
// consensus export, no walks, no walking grid. Not run in CI.
// usage: node rust/tests/golden/guidetext/regen.js <guidetext.js>
//   <guidetext.js>: a copy of guidetext.js inside a copy of this checkout's tools/ (see README.md).
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const zlib = require('node:zlib');
const { execFileSync } = require('node:child_process');

const HERE = __dirname;
const GOLDEN = path.resolve(HERE, '..');
const DUMP = path.resolve(GOLDEN, '../../crates/forge-judge/tests/js/guidetext-dump.js');
const GT = process.argv[2];
if (!GT || !fs.existsSync(GT)) {
	console.error('usage: node rust/tests/golden/guidetext/regen.js <tools/lib/judge/guidetext.js>');
	process.exit(2);
}
const GUIDES = path.join(GOLDEN, 'guide/slice');

/// (case, target): the forge-judge/tests/guidetext_parity.rs CASES. `@` is the guide slice.
const CASES = [
	['shipped-orc', 'polestar:Horde:Orc'],
	['shipped-human', 'polestar:Alliance:Human'],
	['dir-orc', 'file:@/forever/horde/orc-troll:Horde:Orc'],
];

const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'guidetext-golden-'));
// A temp copy of the data slice: the JS sim caches what it derives (escort facts) into its sources dir.
const ROOT = path.join(tmp, 'root');
fs.cpSync(path.join(GOLDEN, 'world/root'), ROOT, { recursive: true });
const DATA = path.join(ROOT, 'data/forever');
const simDir = path.join(tmp, 'sim');
fs.mkdirSync(simDir);
for (const f of ['horde', 'alliance']) fs.writeFileSync(path.join(simDir, `world-${f}.json`), zlib.gunzipSync(fs.readFileSync(path.join(GOLDEN, `world/expected/world-${f}.json.gz`))));
fs.copyFileSync(path.join(GOLDEN, 'sim/params.json'), path.join(simDir, 'params.json'));
const env = {
	...process.env,
	POLESTAR_JUDGE_SIM: simDir,
	POLESTAR_JUDGE_GUIDES: GUIDES,
	POLESTAR_JUDGE_DATA: DATA,
	POLESTAR_JUDGE_EXPORT: path.join(tmp, 'no-export'),
	POLESTAR_GRID: path.join(ROOT, 'data/local/nav4'),
	POLESTAR_CAS: 'off',
};
// guidetext.js leaves the sim's data and sources dirs at the checkout's: point them at the slice.
const preload = path.join(tmp, 'slice-defaults.js');
fs.writeFileSync(preload, `Object.assign(require(${JSON.stringify(path.resolve(path.dirname(GT), '../sim/index'))}).DEFAULTS, ${JSON.stringify({ dataDir: DATA, sourcesDir: path.join(ROOT, 'data/sources') })});\n`);
for (const [name, target] of CASES) {
	const out = path.join(tmp, `${name}.json`);
	execFileSync('node', ['--require', preload, DUMP, GT, target.replace('@', GUIDES), out], { env, stdio: 'inherit' });
	const text = fs.readFileSync(out, 'utf8');
	for (const p of [GOLDEN, os.tmpdir()]) if (text.includes(p)) throw new Error(`${name}: the dump holds the path ${p}`);
	fs.writeFileSync(path.join(HERE, `${name}.json.gz`), zlib.gzipSync(text, { level: 9 }));
}
// The world the scorer replayed on must be the golden one.
for (const f of ['horde', 'alliance']) {
	const was = JSON.parse(zlib.gunzipSync(fs.readFileSync(path.join(GOLDEN, `world/expected/world-${f}.json.gz`)))).dataHash;
	const now = JSON.parse(fs.readFileSync(path.join(simDir, `world-${f}.json`), 'utf8')).dataHash;
	if (was !== now) throw new Error(`${f}: guidetext.js rebuilt the sim world (${now}, golden ${was})`);
}
fs.rmSync(tmp, { recursive: true, force: true });
