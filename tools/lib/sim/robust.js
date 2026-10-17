'use strict';
// Robustness (docs/SIMULATION.md §3): draw K parameter sets from the
// (calibrated) priors, re-evaluate the top routes of a `sim run` result under
// each, and report every route's win rate, mean and 90% interval of time to
// 60, and which parameters flip the ranking (Spearman correlation of each
// parameter with the time difference between the two leading routes, and
// with "the leader wins").

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const sim = require('./index');
const { draws: drawParams, NAMES } = require('./params');
const { Pool } = require('./pool');
const { compileRun, makeTables } = require('./run');
const { Evaluator } = require('./evaluate');
const { fmtH, table } = require('./report');

function quantile(sorted, q) {
	if (!sorted.length) return NaN;
	const i = (sorted.length - 1) * q;
	const lo = Math.floor(i);
	const hi = Math.ceil(i);
	return sorted[lo] + (sorted[hi] - sorted[lo]) * (i - lo);
}

function ranks(a) {
	const idx = a.map((v, i) => [v, i]).sort((x, y) => x[0] - y[0]);
	const r = new Array(a.length);
	for (let i = 0; i < idx.length; ) {
		let j = i;
		while (j + 1 < idx.length && idx[j + 1][0] === idx[i][0]) j++;
		for (let k = i; k <= j; k++) r[idx[k][1]] = (i + j) / 2;
		i = j + 1;
	}
	return r;
}

function spearman(x, y) {
	const rx = ranks(x);
	const ry = ranks(y);
	const n = x.length;
	const mx = rx.reduce((a, b) => a + b, 0) / n;
	const my = ry.reduce((a, b) => a + b, 0) / n;
	let sxy = 0;
	let sxx = 0;
	let syy = 0;
	for (let i = 0; i < n; i++) {
		sxy += (rx[i] - mx) * (ry[i] - my);
		sxx += (rx[i] - mx) ** 2;
		syy += (ry[i] - my) ** 2;
	}
	return sxx > 0 && syy > 0 ? sxy / Math.sqrt(sxx * syy) : 0;
}

// seconds[d][r] for routes (run package indices) under draws, on workers.
// Routes are followed as plans: an under-levelled package is caught up by
// grinding (evaluate.js `catchUp`), as a player following the guide would.
async function evaluateDraws({ world, worldFile, runOpts, routes, draws, workers }) {
	if (workers <= 1) {
		const run = compileRun(world, runOpts);
		return draws.map((p) => {
			const ev = new Evaluator(run, makeTables(run, p), { catchUp: true });
			return routes.map((r) => ev.cost(r));
		});
	}
	const pool = new Pool(workers, { worldFile, runOpts, params: draws[0] });
	try {
		const chunk = Math.max(1, Math.ceil(draws.length / (workers * 4)));
		const msgs = [];
		for (let i = 0; i < draws.length; i += chunk) msgs.push({ type: 'robust', draws: draws.slice(i, i + chunk), routes });
		const res = await pool.run(msgs);
		return res.flatMap((r) => r.seconds);
	} finally {
		await pool.close();
	}
}

function analyze(seconds, draws, labels, margin = 0.01) {
	const R = labels.length;
	const K = seconds.length;
	const wins = new Array(R).fill(0);
	const within = new Array(R).fill(0);
	for (const row of seconds) {
		let b = 0;
		for (let r = 1; r < R; r++) if (row[r] < row[b]) b = r;
		wins[b]++;
		for (let r = 0; r < R; r++) if (row[r] <= row[b] * (1 + margin)) within[r]++;
	}
	const routes = labels.map((label, r) => {
		const s = seconds.map((row) => row[r]).sort((a, b) => a - b);
		return { label, winRate: wins[r] / K, withinMargin: within[r] / K, mean: s.reduce((a, b) => a + b, 0) / K, p5: quantile(s, 0.05), p50: quantile(s, 0.5), p95: quantile(s, 0.95) };
	});
	// Leader = best mean; challenger = second best mean.
	const order = routes.map((r, i) => i).sort((a, b) => routes[a].mean - routes[b].mean);
	const [a, b] = order;
	const flips = [];
	if (b != null) {
		const diff = seconds.map((row) => row[a] - row[b]);
		const leaderWins = seconds.map((row) => (row.indexOf(Math.min(...row)) === a ? 1 : 0));
		for (const k of NAMES) {
			const x = draws.map((p) => p[k]);
			if (new Set(x).size < 3) continue;
			flips.push({ param: k, rhoDiff: spearman(x, diff), rhoWin: spearman(x, leaderWins) });
		}
		flips.sort((p, q) => Math.abs(q.rhoDiff) - Math.abs(p.rhoDiff));
	}
	// Sensitivity of the leader's own time to each parameter.
	const lead = seconds.map((row) => row[a]);
	const sens = NAMES.filter((k) => new Set(draws.map((p) => p[k])).size >= 3)
		.map((k) => ({ param: k, rho: spearman(draws.map((p) => p[k]), lead) }))
		.sort((p, q) => Math.abs(q.rho) - Math.abs(p.rho));
	return { routes, leader: a, challenger: b, flips, sensitivity: sens };
}

async function robust(o) {
	const faction = sim.normFaction(o.faction);
	const file = sim.resultFile(o.simDir, faction, o.race, o.cls, o.family || 'solo');
	if (!fs.existsSync(file)) throw new Error(`${file} not found: run \`sim run --faction ${faction} --race ${o.race}\` first`);
	const res = JSON.parse(fs.readFileSync(file, 'utf8'));
	const { world, worldFile } = await sim.loadWorld({ ...o, faction });
	sim.assertFresh(res, world, path.basename(file));
	const runOpts = { race: o.race, cls: o.cls || null, family: o.family || 'solo' };
	const run = compileRun(world, runOpts);
	const top = res.elite.slice(0, o.top || 10);
	const routes = top.map((e) => sim.routeFromKeys(run, e.route));
	const { eff } = sim.paramsFor(o.simDir, o.cls);
	const K = o.draws || 2000;
	const draws = drawParams(eff, K, o.seed || 7);
	const t0 = Date.now();
	const seconds = await evaluateDraws({ world, worldFile, runOpts, routes, draws, workers: o.workers || os.availableParallelism() });
	const wall = (Date.now() - t0) / 1000;
	const labels = top.map((e, i) => `#${i + 1}`);
	const a = analyze(seconds, draws, labels);
	// How each route differs from #1 (packages added/removed).
	const first = new Set(top[0].route);
	a.routes.forEach((r, i) => {
		const s = new Set(top[i].route);
		r.diffVsFirst = { added: top[i].route.filter((k) => !first.has(k)), removed: top[0].route.filter((k) => !s.has(k)) };
		r.searchSeconds = top[i].seconds;
	});
	const out = { schema: 1, faction, race: o.race, class: sim.className(o.cls), family: runOpts.family, draws: K, seed: o.seed || 7, wallSeconds: wall, result: path.basename(file), ...a };
	const outFile = file.replace(/\.json$/, '-robust.json');
	fs.writeFileSync(outFile, `${JSON.stringify(out, null, 1)}\n`);
	out.file = outFile;
	return out;
}

async function command(args, o) {
	const faction = sim.normFaction(args.faction);
	let cls;
	try {
		cls = sim.normClass(args.class);
	} catch (err) {
		console.error(`sim robust: ${err.message}`);
		return 2;
	}
	const racesList = args.race ? [args.race] : sim.START_RACES[faction];
	for (const race of racesList) {
		const r = await robust({
			...sim.DEFAULTS, ...o, faction, race, cls, family: args.dungeons ? 'dungeons' : 'solo',
			draws: args.draws ? Number(args.draws) : 2000, top: args.top ? Number(args.top) : 10,
			workers: args.workers ? Number(args.workers) : undefined, seed: args.seed ? Number(args.seed) : undefined,
		});
		console.log(`\n== robustness ${r.faction} ${r.race} (${r.class}, ${r.family}): ${r.draws} draws, ${r.routes.length} routes, ${r.wallSeconds.toFixed(1)} s ==`);
		console.log(table(['route', 'search', 'win rate', 'within 1%', 'mean', '5%', '95%', 'vs #1'], r.routes.map((x) => [
			x.label, fmtH(x.searchSeconds), `${(100 * x.winRate).toFixed(1)}%`, `${(100 * x.withinMargin).toFixed(1)}%`, fmtH(x.mean), fmtH(x.p5), fmtH(x.p95),
			x.diffVsFirst.added.length || x.diffVsFirst.removed.length ? `+${x.diffVsFirst.added.length}/-${x.diffVsFirst.removed.length} pkgs` : 'same set, order',
		])));
		console.log(`leader ${r.routes[r.leader].label} vs ${r.challenger != null ? r.routes[r.challenger].label : '-'}: parameters that move the gap (Spearman ρ with leader − challenger time; with "leader wins"):`);
		console.log(`  ${r.flips.slice(0, 6).map((f) => `${f.param} ${f.rhoDiff.toFixed(2)}/${f.rhoWin.toFixed(2)}`).join(', ')}`);
		console.log(`leader time sensitivity (ρ): ${r.sensitivity.slice(0, 6).map((f) => `${f.param} ${f.rho.toFixed(2)}`).join(', ')}`);
		console.log(`wrote ${path.relative(process.cwd(), r.file)}`);
	}
	return 0;
}

module.exports = { robust, command, analyze, spearman, evaluateDraws };
