'use strict';
// Regenerates rust/tests/golden/judge/<case>.json.gz: the JS judge (tools/lib/judge/index.js judgeWalk:
// the walk, passed by, avoidable returns) of the checkout $POLESTAR_JS (required: the v2-route branch's
// tree, the judge with returns that forge-judge ports) on the committed
// guide slice (rust/tests/golden/guide/slice) and data slice (rust/tests/golden/world/root), its sim
// world the golden slice world with the committed params (rust/tests/golden/sim/params.json): the
// dumps of forge-judge/tests/js/judge-ref.js. No walking grid: no subzones. File names are written
// relative to the guide slice. Not run in CI. usage: POLESTAR_JS=<checkout> node rust/tests/golden/judge/regen.js
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');

const HERE = __dirname;
const GOLDEN = path.resolve(HERE, '..');
// A temp copy of the data slice: the JS sim caches what it derives (escort facts) into its sources dir.
const ROOT = path.join(fs.mkdtempSync(path.join(require('node:os').tmpdir(), 'judge-golden-root-')), 'root');
fs.cpSync(path.join(GOLDEN, 'world/root'), ROOT, { recursive: true });
const JS = process.env.POLESTAR_JS;
if (!JS) {
	console.error('usage: POLESTAR_JS=<checkout of the v2-route JS judge> node rust/tests/golden/judge/regen.js');
	process.exit(2);
}
const GUIDES = path.join(GOLDEN, 'guide/slice');
process.env.POLESTAR_GRID = path.join(ROOT, 'data/local/nav4');
process.env.POLESTAR_CAS = 'off';
process.env.POLESTAR_CAS_SKIP = 'walks';

/// (case, faction, race, class, to): the forge-judge/tests/judge_parity.rs CASES.
const CASES = [
	['orc61', 'Horde', 'Orc', 'Warrior', 61],
	['orc12', 'Horde', 'Orc', 'Warrior', 12],
	['human61', 'Alliance', 'Human', 'Warrior', 61],
	['human10', 'Alliance', 'Human', 'Warrior', 10],
];

const gunzip = (f) => zlib.gunzipSync(fs.readFileSync(f));

(async () => {
	const sim = require(path.join(JS, 'tools/lib/sim/index'));
	const { judgeWalk } = require(path.join(JS, 'tools/lib/judge/index.js'));
	const simDir = fs.mkdtempSync(path.join(process.env.SCRATCH || HERE, '.simdir-'));
	for (const f of ['horde', 'alliance']) fs.writeFileSync(path.join(simDir, `world-${f}.json`), gunzip(path.join(GOLDEN, `world/expected/world-${f}.json.gz`)));
	fs.copyFileSync(path.join(GOLDEN, 'sim/params.json'), path.join(simDir, 'params.json'));
	Object.assign(sim.DEFAULTS, { simDir, dataDir: path.join(ROOT, 'data/forever'), sourcesDir: path.join(ROOT, 'data/sources') });
	for (const [name, faction, race, cls, to] of CASES) {
		const t0 = process.hrtime.bigint();
		const { w, pb, returns } = await judgeWalk({ guides: GUIDES, faction, race, cls, to, simDir, dataDir: path.join(ROOT, 'data/forever'), relFiles: false });
		const ms = Number(process.hrtime.bigint() - t0) / 1e6;
		const goals = w.goals.map((g) => ({
			i: g.i, guide: g.guide, file: g.file, line: g.line ?? null, step: g.step ?? null, t: g.t, q: g.q, oi: g.oi, optional: g.optional, passing: g.passing,
			map: g.map, w: g.w, npc: g.npc, level: g.level, title: g.title, lvl: g.lvl, time: g.time, lvlAfter: g.lvlAfter ?? null, timeAfter: g.timeAfter ?? null, pos: g.pos,
		}));
		const text = JSON.stringify({ chain: w.chain, goals, passedBy: pb, returns, ms }).split(JSON.stringify(GUIDES + path.sep).slice(1, -1)).join('').split(JSON.stringify(path.relative(process.cwd(), GUIDES) + path.sep).slice(1, -1)).join('');
		fs.writeFileSync(path.join(HERE, `${name}.json.gz`), zlib.gzipSync(text, { level: 9 }));
		console.error(`${name}: ${goals.length} goals, ${pb.count} passed by, ${returns.summary.returns} returns, ${ms.toFixed(0)} ms`);
	}
	// The world the walk replayed levels on must be the golden one (judge_simlevels.rs replays on it).
	for (const f of ['horde', 'alliance']) {
		const was = JSON.parse(gunzip(path.join(GOLDEN, `world/expected/world-${f}.json.gz`))).dataHash;
		const now = JSON.parse(fs.readFileSync(path.join(simDir, `world-${f}.json`), 'utf8')).dataHash;
		if (was !== now) throw new Error(`${f}: the JS judge rebuilt the sim world (${now}, golden ${was})`);
	}
	fs.rmSync(simDir, { recursive: true, force: true });
})().catch((e) => {
	console.error(e.stack);
	process.exit(1);
});
