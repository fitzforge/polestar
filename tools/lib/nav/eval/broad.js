'use strict';
// nav eval's broad sample: how good a Polestar_Nav folder's walking graph is overall, not only on the reported
// walks. Random pairs of quest points per continent, drawn from the sim worlds' points (data/sim/world-<faction>.json:
// every giver, ender and objective spot), run through the eval harness (harness.lua, the addon's own router), and
// measured on each drawn line.
//
//   node tools/lib/nav/eval/broad.js sample [--per 1000] [--max 4000] [--min 40] [--seed 1] [--worlds <dir>] --out pairs.json
//   node tools/lib/nav/eval/broad.js run --nav <Polestar_Nav dir> --pairs pairs.json [--workers N] [--grid <dir>] --out run.json
//   node tools/lib/nav/eval/broad.js compare <base run.json> <cand run.json>
//   node tools/lib/nav/eval/broad.js workers --nav <Polestar_Nav dir>     the harness processes run would use there
//
// sample: per continent (0, 1) `per` pairs, half from each faction's world (its profile), both points in the same
// region (the world's islands), between `min` and `max` yd apart (flat), from a seeded generator: the same seed and
// worlds give the same pairs. Points carry no height (as the client reports the player and most quest spots).
// run: the harness in `workers` processes (each row keeps its drawn line, pts, for chokecheck.js) (each loads the whole folder; the default fits the free memory), then per
// pair: ok, straight and drawn yards, detour (drawn / straight), cold and warm search ms, and the anomalies:
//   drop15     a step (consecutive points) that falls more than 15 yd (dropSteep: and steeper than 45 deg)
//   underground a vertex of the line more than 4 yd under the column's terrain with no surface of any kind within
//              4 yd of its height on our grid (--grid, default data/local/nav4): a node in solid ground (2 yd samples
//              of the drawn segments are not judged: a straight segment between two valley nodes dips under a ridge)
//   steepStep  a step climbing or falling steeper than 50 deg over at least 1 yd
//   cliff      2 yd samples standing (within 3 yd) on a grid surface whose steepest terrain triangle (tslope) is over
//              50 deg: any (cliffPct), and 5 or more, 10 yd (cliff10Pct)
// The summary per continent and overall: routed share, detour median and p95, the share of routed pairs with each
// anomaly, search ms median and p95; and the harness's packed KB and largest Lua KB seen (memory after loading).
// compare: both summaries side by side, and the pairs routed in one and not the other, and the largest detour changes.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawn } = require('node:child_process');
const { ROOT } = require('../../paths');
const { navFiles, findInterpreter } = require('./run');
const { samples } = require('./compare');
const { lineLength } = require('./metrics');

const HARNESS = path.join(__dirname, 'harness.lua');
const ENCODING = path.join(ROOT, 'tests', 'lua', 'stub_encoding.lua');
const FACTIONS = ['alliance', 'horde'];
const PROFILE = { alliance: 'Alliance', horde: 'Horde' };

function rng(seed) {
	let a = seed >>> 0;
	return () => {
		a = (a + 0x6d2b79f5) >>> 0;
		let t = a;
		t = Math.imul(t ^ (t >>> 15), t | 1);
		t ^= t + Math.imul(t ^ (t >>> 7), t | 61);
		return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
	};
}

function samplePairs({ worlds = path.join(ROOT, 'data', 'sim'), per = 1000, max = 4000, min = 40, seed = 1 }) {
	const rand = rng(seed);
	const pairs = [];
	for (const c of [0, 1]) {
		for (const [fi, faction] of FACTIONS.entries()) {
			const world = JSON.parse(fs.readFileSync(path.join(worlds, `world-${faction}.json`), 'utf8'));
			const seen = new Set();
			const pts = [];
			for (const [pc, region, wx, wy] of world.points) {
				const key = `${pc}|${wx.toFixed(1)}|${wy.toFixed(1)}`;
				if (pc !== c || seen.has(key)) continue;
				seen.add(key);
				pts.push([region, wx, wy]);
			}
			const want = Math.floor(per / 2) + (fi === 0 ? per % 2 : 0);
			let got = 0;
			for (let tries = 0; got < want && tries < want * 200; tries++) {
				const a = pts[Math.floor(rand() * pts.length)];
				const b = pts[Math.floor(rand() * pts.length)];
				const d = Math.hypot(a[1] - b[1], a[2] - b[2]);
				if (a[0] !== b[0] || d < min || d > max) continue;
				pairs.push({ id: `${c}|${faction}|${got}`, map: c, profile: PROFILE[faction], from: [a[1], a[2], null], to: [b[1], b[2], null], straight: +d.toFixed(1) });
				got++;
			}
		}
	}
	return { seed, per, max, min, worlds: path.relative(ROOT, worlds), pairs };
}

// One harness process over `queries`; resolves { init, results }.
function harness({ navDir, queries, lua, tag }) {
	const tmp = fs.mkdtempSync(path.join(os.tmpdir(), `polestar-broad-${tag}-`));
	const list = path.join(tmp, 'files.txt');
	const qfile = path.join(tmp, 'queries.jsonl');
	const out = path.join(tmp, 'out.jsonl');
	fs.writeFileSync(list, navFiles(path.resolve(navDir)).join('\n') + '\n');
	fs.writeFileSync(qfile, queries.map((q) => JSON.stringify(q)).join('\n') + '\n');
	return new Promise((resolve, reject) => {
		const p = spawn(lua, [HARNESS, ENCODING, list, qfile, out], { stdio: ['ignore', 'ignore', 'pipe'] });
		let err = '';
		p.stderr.on('data', (d) => (err += d));
		p.on('close', (code) => {
			try {
				if (code !== 0) throw new Error(`harness (${lua}) failed: ${err.trim()}`);
				const lines = fs.readFileSync(out, 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l));
				resolve({ init: lines[0], results: lines.slice(1) });
			} catch (e) {
				reject(e);
			} finally {
				fs.rmSync(tmp, { recursive: true, force: true });
			}
		});
	});
}

// Workers that fit: each holds the folder's maps packed and a share decoded (about 3x the folder's size, at least
// 0.6 GB), leaving 4 GB free; 1 to 8.
function defaultWorkers(navDir) {
	let bytes = 0;
	const walk = (d) => {
		for (const e of fs.readdirSync(d, { withFileTypes: true })) {
			const p = path.join(d, e.name);
			if (e.isDirectory()) walk(p);
			else bytes += fs.statSync(p).size;
		}
	};
	walk(navDir);
	const per = Math.max(0.6, (3 * bytes) / 2 ** 30);
	const avail = os.freemem() / 2 ** 30;
	return { workers: Math.max(1, Math.min(8, Math.floor((avail - 4) / per))), perGB: +per.toFixed(2), availGB: +avail.toFixed(1), navMB: +(bytes / 2 ** 20).toFixed(1) };
}

// The grid's surfaces in a column: [{ z, flags, tslope }].
function columnOf(grid, c, x, y) {
	const { cellOf, TILE_CELLS } = require('../grid/format');
	const { col, row, i, j } = cellOf(x, y);
	const t = grid.tile(c, col, row);
	if (!t) return null;
	const k = j * TILE_CELLS + i;
	const out = [];
	for (let e = t.first[k]; e < t.first[k + 1]; e++) out.push({ z: t.z[e], flags: t.flags[e], tslope: t.tslope ? t.tslope[e] : null });
	return out;
}

const DEG = 180 / Math.PI;

function measure(pair, res, grid) {
	const pts = res.pts || [];
	const drawn = lineLength(pts);
	const m = { id: pair.id, map: pair.map, ok: !!res.ok, reason: res.ok ? null : res.reason, straight: pair.straight, ms: res.ms, warmMs: res.warmMs, kb: res.kb };
	if (!res.ok) return m;
	m.yards = +drawn.toFixed(1);
	m.pts = pts.map(([x, y, z]) => [+x.toFixed(1), +y.toFixed(1), typeof z === 'number' ? +z.toFixed(1) : null]);
	m.detour = +(drawn / Math.max(1, pair.straight)).toFixed(3);
	let drop = 0;
	let dropSteep = 0;
	let steep = 0;
	for (let i = 1; i < pts.length; i++) {
		const [ax, ay, az] = pts[i - 1];
		const [bx, by, bz] = pts[i];
		if (typeof az !== 'number' || typeof bz !== 'number') continue;
		const d = Math.hypot(bx - ax, by - ay);
		const dz = bz - az;
		if (dz < -15) {
			drop = Math.max(drop, -dz);
			if (Math.atan2(-dz, d) * DEG > 45) dropSteep = Math.max(dropSteep, -dz);
		}
		if (d >= 1 && Math.atan2(Math.abs(dz), d) * DEG > 50) steep++;
	}
	m.drop15 = drop > 0 ? +drop.toFixed(1) : 0;
	m.dropSteep = dropSteep > 0 ? +dropSteep.toFixed(1) : 0;
	m.steepSteps = steep;
	if (grid) {
		const { FLAG } = require('../grid/format');
		// A vertex under the terrain in solid ground: the router put a node where no surface is.
		const solid = (x, y, z) => {
			const col = columnOf(grid, pair.map, x, y);
			if (!col || !col.length) return false;
			let terrain = null;
			let nearest = Infinity;
			for (const s of col) {
				if (s.flags & FLAG.TERRAIN) terrain = terrain === null ? s.z : Math.max(terrain, s.z);
				nearest = Math.min(nearest, Math.abs(s.z - z));
			}
			return terrain !== null && z < terrain - 4 && nearest > 4;
		};
		let under = 0;
		for (const [x, y, z] of pts) if (typeof z === 'number' && solid(x, y, z)) under++;
		let cliff = 0;
		let n = 0;
		samples(pts, 2, (x, y, z) => {
			if (z === null) return;
			const col = columnOf(grid, pair.map, x, y);
			if (!col || !col.length) return;
			n++;
			let on = null;
			for (const s of col) if (Math.abs(s.z - z) <= 3 && (!on || Math.abs(s.z - z) < Math.abs(on.z - z))) on = s;
			if (on && on.tslope !== null && on.tslope > 50) cliff++;
		});
		m.samples = n;
		m.underground = under;
		m.cliff = cliff;
	}
	return m;
}

const pct = (xs, p) => {
	if (!xs.length) return null;
	const s = [...xs].sort((a, b) => a - b);
	return +s[Math.min(s.length - 1, Math.floor(p * (s.length - 1) + 0.5))].toFixed(3);
};
const share = (n, d) => (d ? +((100 * n) / d).toFixed(1) : null);

function summarize(rows) {
	const ok = rows.filter((r) => r.ok);
	const withGrid = ok.filter((r) => r.samples !== undefined);
	const ms = rows.map((r) => r.ms).filter((v) => typeof v === 'number');
	return {
		pairs: rows.length,
		routed: ok.length,
		routedPct: share(ok.length, rows.length),
		unreachable: rows.length - ok.length,
		reasons: rows.filter((r) => !r.ok).reduce((o, r) => ((o[r.reason] = (o[r.reason] || 0) + 1), o), {}),
		detourMedian: pct(ok.map((r) => r.detour), 0.5),
		detourP95: pct(ok.map((r) => r.detour), 0.95),
		drop15Pct: share(ok.filter((r) => r.drop15 > 0).length, ok.length),
		dropSteepPct: share(ok.filter((r) => r.dropSteep > 0).length, ok.length),
		undergroundPct: withGrid.length ? share(withGrid.filter((r) => r.underground > 0).length, withGrid.length) : null,
		steepStepPct: share(ok.filter((r) => r.steepSteps > 0).length, ok.length),
		cliffPct: withGrid.length ? share(withGrid.filter((r) => r.cliff > 0).length, withGrid.length) : null,
		cliff10Pct: withGrid.length ? share(withGrid.filter((r) => r.cliff >= 5).length, withGrid.length) : null,
		msMedian: pct(ms, 0.5),
		msP95: pct(ms, 0.95),
		kbMax: Math.max(0, ...rows.map((r) => r.kb || 0)),
	};
}

async function runBroad({ navDir, pairsDoc, workers, gridDir, log = () => {} }) {
	const lua = findInterpreter();
	const fit = defaultWorkers(navDir);
	const W = workers || fit.workers;
	log(`broad: ${pairsDoc.pairs.length} pairs on ${navDir} in ${W} harness process(es) (${fit.navMB} MB folder, ~${fit.perGB} GB each, ${fit.availGB} GB free)`);
	const queries = pairsDoc.pairs.map((p) => ({ type: 'route', id: p.id, map: p.map, from: p.from, to: p.to, profile: p.profile, style: 'balanced', level: null, danger: null }));
	const chunks = Array.from({ length: W }, (_, i) => queries.filter((_, k) => k % W === i));
	const t0 = Date.now();
	const outs = await Promise.all(chunks.map((q, i) => harness({ navDir, queries: q, lua, tag: i })));
	log(`broad: harness done in ${((Date.now() - t0) / 1000).toFixed(1)} s`);
	const byId = new Map();
	for (const o of outs) for (const r of o.results) byId.set(r.id, r);
	let grid = null;
	if (gridDir && fs.existsSync(path.join(gridDir, 'index.json'))) grid = require('../path').openNav({ dir: gridDir, cacheTiles: 128 });
	else log(`broad: no grid at ${gridDir}: underground and cliff are n/a`);
	const rows = pairsDoc.pairs.map((p) => measure(p, byId.get(p.id) || { ok: false, reason: 'no answer' }, grid));
	const summary = { all: summarize(rows) };
	for (const c of [0, 1]) summary[c] = summarize(rows.filter((r) => r.map === c));
	return { navDir: path.resolve(navDir), lua, init: outs[0].init, workers: W, seed: pairsDoc.seed, summary, rows };
}

const LABELS = [
	['routedPct', 'routed %'],
	['unreachable', 'unreachable'],
	['detourMedian', 'detour median'],
	['detourP95', 'detour p95'],
	['dropSteepPct', 'drops > 15 yd in a step steeper than 45 deg, %'],
	['drop15Pct', 'falls > 15 yd in one drawn segment (any grade), %'],
	['undergroundPct', 'a vertex in solid ground under the terrain, %'],
	['steepStepPct', 'a step steeper than 50 deg, %'],
	['cliffPct', 'touches a >50 deg surface (any 2 yd sample), %'],
	['cliff10Pct', 'on >50 deg surfaces for 10+ yd, %'],
	['msMedian', 'search ms median'],
	['msP95', 'search ms p95'],
	['kbMax', 'Lua KB max (during searches)'],
];

function table(cols) {
	const lines = [];
	const head = ['', ...cols.map((c) => c.label)];
	lines.push(`| ${head.join(' | ')} |`, `|${head.map(() => '---').join('|')}|`);
	for (const [k, label] of LABELS) lines.push(`| ${label} | ${cols.map((c) => (c.s[k] === null || c.s[k] === undefined ? 'n/a' : c.s[k])).join(' | ')} |`);
	return lines.join('\n');
}

function compareRuns(base, cand) {
	const out = [];
	out.push(`packed KB after loading: base ${base.init.packedKB}, cand ${cand.init.packedKB}; load ms: base ${base.init.loadMs}, cand ${cand.init.loadMs}`);
	for (const k of ['all', '0', '1']) {
		out.push('', `### ${k === 'all' ? 'Both continents' : k === '0' ? 'Eastern Kingdoms' : 'Kalimdor'}`, '', table([{ label: 'base', s: base.summary[k] }, { label: 'cand', s: cand.summary[k] }]));
	}
	const bById = new Map(base.rows.map((r) => [r.id, r]));
	const lost = [];
	const won = [];
	const worse = [];
	for (const r of cand.rows) {
		const b = bById.get(r.id);
		if (!b) continue;
		if (b.ok && !r.ok) lost.push(`${r.id} (${r.reason})`);
		if (!b.ok && r.ok) won.push(r.id);
		if (b.ok && r.ok && Math.abs(r.detour - b.detour) > 0.001) worse.push({ id: r.id, from: b.detour, to: r.detour, d: r.detour - b.detour });
	}
	worse.sort((a, b) => b.d - a.d);
	out.push('', `Routed in base, unreachable in cand: ${lost.length}${lost.length ? `: ${lost.slice(0, 20).join(', ')}` : ''}`);
	out.push(`Unreachable in base, routed in cand: ${won.length}`);
	out.push(`Pairs whose detour changed: ${worse.length}`);
	out.push(`Largest detour increases: ${worse.filter((w) => w.d > 0).slice(0, 10).map((w) => `${w.id} ${w.from} -> ${w.to}`).join('; ') || 'none'}`);
	out.push(`Largest detour decreases: ${worse.filter((w) => w.d < 0).slice(-10).reverse().map((w) => `${w.id} ${w.from} -> ${w.to}`).join('; ') || 'none'}`);
	return out.join('\n');
}

async function main(argv) {
	const { parseArgs } = require('../../cli');
	const [cmd, ...rest] = argv;
	const { opts: o, positional, error } = parseArgs(rest, { flags: [], options: ['--per', '--max', '--min', '--seed', '--worlds', '--out', '--nav', '--pairs', '--workers', '--grid'] });
	if (error) throw new Error(error);
	if (cmd === 'sample') {
		const doc = samplePairs({ worlds: o.worlds ? path.resolve(o.worlds) : undefined, per: o.per ? +o.per : 1000, max: o.max ? +o.max : 4000, min: o.min ? +o.min : 40, seed: o.seed ? +o.seed : 1 });
		fs.writeFileSync(path.resolve(o.out), JSON.stringify(doc) + '\n');
		console.log(`broad: ${doc.pairs.length} pairs in ${o.out}`);
	} else if (cmd === 'run') {
		const pairsDoc = JSON.parse(fs.readFileSync(path.resolve(o.pairs), 'utf8'));
		const rep = await runBroad({ navDir: path.resolve(o.nav), pairsDoc, workers: o.workers ? +o.workers : null, gridDir: path.resolve(o.grid || path.join(ROOT, 'data', 'local', 'nav4')), log: (m) => console.error(m) });
		fs.writeFileSync(path.resolve(o.out), JSON.stringify(rep) + '\n');
		console.log(table([{ label: path.basename(path.dirname(rep.navDir)) || rep.navDir, s: rep.summary.all }]));
	} else if (cmd === 'workers') {
		console.log(defaultWorkers(path.resolve(o.nav)).workers);
	} else if (cmd === 'compare') {
		const [a, b] = positional.map((f) => JSON.parse(fs.readFileSync(path.resolve(f), 'utf8')));
		console.log(compareRuns(a, b));
	} else {
		throw new Error('usage: broad.js sample|run|compare|workers (see the header)');
	}
}

if (require.main === module) {
	main(process.argv.slice(2)).catch((e) => {
		console.error(e.message);
		process.exit(1);
	});
}

module.exports = { samplePairs, runBroad, summarize, compareRuns, measure };
