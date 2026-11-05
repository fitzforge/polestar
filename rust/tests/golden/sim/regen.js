'use strict';
// Regenerates rust/tests/golden/sim/v1-<faction>-<race>-off.json.gz: v1's chain (the committed guide
// slice rust/tests/golden/guide/slice) walked by the JS judge (tools/lib/judge/walk.js walkChain) on
// the committed data slice, then replayed event by event on the JS v1 evaluator (tools/lib/sim) in
// the golden slice world (rust/tests/golden/world/expected/world-<faction>.json.gz) with walks off and
// the committed params.json: the removed forge-sim/tests/js/v1chain.js on committed inputs. Not run in CI.
// usage: JS_ROOT=<checkout at 734380d2a> node rust/tests/golden/sim/regen.js
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');

const HERE = __dirname;
const GOLDEN = path.resolve(HERE, '..');
if (!process.env.JS_ROOT) {
	console.error('usage: JS_ROOT=<checkout at 734380d2a> node rust/tests/golden/sim/regen.js (this checkout no longer has the JS judge walk)');
	process.exit(2);
}
// A temp copy of the data slice: the JS sim caches what it derives (escort facts) into its sources dir.
const ROOT = path.join(fs.mkdtempSync(path.join(require('node:os').tmpdir(), 'sim-golden-root-')), 'root');
fs.cpSync(path.join(GOLDEN, 'world/root'), ROOT, { recursive: true });
const JS = path.resolve(process.env.JS_ROOT);
const GUIDES = path.join(GOLDEN, 'guide/slice');
process.env.POLESTAR_GRID = path.join(ROOT, 'data/local/nav4');
process.env.POLESTAR_CAS = 'off';
process.env.POLESTAR_CAS_SKIP = 'walks';

const sim = require(path.join(JS, 'tools/lib/sim/index'));
const { walkChain } = require(path.join(JS, 'tools/lib/judge/walk'));
const { compileSequence } = require(path.join(JS, 'tools/lib/sim/sequence'));
const { K_GRIND } = require(path.join(JS, 'tools/lib/sim/run'));
const { LEVEL_XP } = require(path.join(JS, 'tools/lib/game/xp'));

// A sim dir holding the golden worlds (their dataHash fits the slice, so getWorld keeps them) and params.json.
function simDir() {
	const dir = fs.mkdtempSync(path.join(process.env.SCRATCH || HERE, '.simdir-'));
	for (const f of ['horde', 'alliance']) fs.writeFileSync(path.join(dir, `world-${f}.json`), zlib.gunzipSync(fs.readFileSync(path.join(GOLDEN, `world/expected/world-${f}.json.gz`))));
	fs.copyFileSync(path.join(HERE, 'params.json'), path.join(dir, 'params.json'));
	return dir;
}

(async () => {
	const SIMDIR = simDir();
	Object.assign(sim.DEFAULTS, { simDir: SIMDIR, dataDir: path.join(ROOT, 'data/forever'), sourcesDir: path.join(ROOT, 'data/sources') });
	for (const [faction, race] of [['Horde', 'Orc'], ['Alliance', 'Human']]) {
		const w = await walkChain({ guides: GUIDES, faction, race, dataDir: path.join(ROOT, 'data/forever'), simDir: SIMDIR, log: (m) => console.error(m) });
		const { world } = await sim.loadWorld({ faction, simDir: SIMDIR, offline: true, walks: false, log: (m) => console.error(m) });
		const golden = JSON.parse(zlib.gunzipSync(fs.readFileSync(path.join(GOLDEN, `world/expected/world-${faction.toLowerCase()}.json.gz`))));
		if (world.dataHash !== golden.dataHash) throw new Error(`${faction}: the JS rebuilt the world (dataHash ${world.dataHash}, golden ${golden.dataHash})`);
		const { mean } = sim.paramsFor(SIMDIR, null);
		const { run, ev } = sim.makeRun(world, { race, cls: null, params: mean, family: 'solo' });
		const goals = w.goals.map((g) => ({ i: g.i, guide: g.guide, file: path.isAbsolute(g.file) ? path.relative(GUIDES, g.file) : g.file, line: g.line, t: g.t, q: g.q, oi: g.oi, level: g.level, npc: g.npc, map: g.map, w: g.w ? { c: g.w.c, wx: g.w.wx, wy: g.w.wy } : null, title: g.title }));
		const kind = [], qq = [], task = [], pt = [], gOf = [];
		for (const g of goals) {
			let e = null;
			if (g.t === 'level') e = { t: 'level', level: g.level, xp: null };
			else if (g.q == null) continue;
			else if (g.t === 'accept' || g.t === 'turnin') e = { t: g.t, q: g.q };
			else e = { t: 'complete', q: g.q, obj: g.oi };
			const s = compileSequence(run, [e]);
			for (let k = 0; k < s.kind.length; k++) { kind.push(s.kind[k]); qq.push(s.q[k]); task.push(s.task[k]); pt.push(s.pt[k]); gOf.push(g.i); }
		}
		ev.reset();
		const lvlNow = () => ev.level + (ev.level < 60 ? ev.xp / LEVEL_XP[ev.level] : 0);
		let si = 0;
		const per = [];
		for (const g of goals) {
			while (si < kind.length && gOf[si] < g.i) si++;
			while (si < kind.length && gOf[si] === g.i) {
				if (kind[si] === K_GRIND) ev.grindTo(qq[si], task[si]);
				else ev.step(kind[si], qq[si], task[si], pt[si]);
				si++;
			}
			per.push([+lvlNow().toFixed(6), +ev.time.toFixed(4)]);
		}
		const atEnd = { time: ev.time, level: lvlNow(), questsDone: ev.questsDone, steps: ev.steps, grindSec: ev.grindSec, travelSec: ev.travelSec };
		ev.finish();
		const res = ev.result();
		const out = { faction, race, walks: 'off', chain: w.chain, goals, per, atEnd, hours60: res.seconds / 3600, levelTimes: res.levelTimes, result: res, judgeHours: w.hours };
		fs.writeFileSync(path.join(HERE, `v1-${faction.toLowerCase()}-${race.toLowerCase()}-off.json.gz`), zlib.gzipSync(JSON.stringify(out), { level: 9 }));
		console.error(`${faction} ${race}: goals ${goals.length}, steps ${atEnd.steps}, chain end ${(atEnd.time / 3600).toFixed(2)} h at L${atEnd.level.toFixed(2)}, to 60 ${(res.seconds / 3600).toFixed(2)} h`);
	}
	fs.rmSync(SIMDIR, { recursive: true, force: true });
})().catch((e) => {
	console.error(e.stack);
	process.exit(1);
});
