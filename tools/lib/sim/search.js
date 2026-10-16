'use strict';
// Route search (docs/SIMULATION.md §3):
//   1. randomized greedy construction: from the current state the next package
//      is drawn with probability ∝ exp(XP/hour of the package incl. the trip to
//      it / τ), each candidate simulated exactly and undone; a package already
//      run is a candidate again (a return, up to MAX_VISITS runs) and scores
//      only what opened since;
//   2. local search on the best routes: swap, insert, reverse, drop, add,
//      replace and merge (bring a same-zone package next to another) moves
//      under simulated annealing; add and replace also bring returns;
//   3. rounds of independent jobs until the best stops improving over the
//      last share of evaluations, with at least `paths` evaluated routes.
//
// Determinism: a job depends only on (seed, round, job index, elite routes of
// earlier rounds), and rounds merge in job order, so any number of workers
// gives the same result as one.

const { Rng, hashSeed } = require('./rng');
const { maxVisits } = require('./evaluate');
const { CUM_XP } = require('../game/xp');

function cumXp(ev) {
	return CUM_XP[ev.level] + ev.xp;
}

// Construct one route. Returns { route, seconds, trials }. While home
// packages (the starting area) are left, only they are candidates
// (evaluate.js route rules).
//
// Completionist runs score a package by progress per hour instead of XP per
// hour: quests turned in, plus a fifth for every other step done (accepts
// and objectives lead to turn-ins elsewhere), over the package's time with
// its policy costs (grey XP, grinding, zone changes: Evaluator.policyCost).
// Every package up to the level window's top is a candidate (low ones are
// cleanup), and construction stops when no package makes progress.
function construct(ev, rng, { tau = 0.1, window = [-9, 4] } = {}) {
	const run = ev.run;
	const comp = run.completionist;
	ev.reset();
	ev.journaling = true;
	const route = [];
	let trials = 0;
	const scores = new Float64Array(run.P);
	const cand = new Int32Array(run.P);
	while (!ev.finished) {
		const L = ev.level;
		let n = 0;
		let max = 0;
		const c0 = comp ? ev.policyCost() : 0;
		for (let p = 0; p < run.P; p++) {
			if (!ev.canVisit(p)) continue;
			const pk = run.packages[p];
			if (ev.homeLeft > 0) {
				if (!run.pkgHome[p]) continue;
			} else if ((!comp && pk.levels[1] < L + window[0]) || pk.levels[0] > L + window[1]) continue;
			const s = ev.snapshot();
			const x0 = cumXp(ev);
			ev.runPackage(p);
			// Progress (comp: quests + steps / 5; else XP) and its time.
			const dx = comp ? ev.questsDone - s.questsDone + (ev.steps - s.steps) / 5 : cumXp(ev) - x0 + (ev.finished ? 1e9 : 0);
			// policyCost counts each undone quest at missWeight: done ones lower it.
			const dt = comp ? ev.policyCost() - c0 + (ev.questsDone - s.questsDone) * (ev.p.missWeight || 0) : ev.time - s.time;
			ev.restore(s);
			trials++;
			// Home packages must all be run, even ones that give nothing.
			if ((dx <= 0 || dt <= 0) && ev.homeLeft === 0) continue;
			const sc = dx > 0 && dt > 0 ? (dx / dt) * 3600 : 1e-6;
			cand[n] = p;
			scores[n++] = sc;
			if (sc > max) max = sc;
		}
		// Nothing worth doing (below half the grind rate): grind out the rest.
		// Completionist: nothing left that makes progress.
		if (!n || (!comp && max < 0.5 * ev.t.grindRate[L] * 3600 && ev.homeLeft === 0)) break;
		let tot = 0;
		for (let i = 0; i < n; i++) {
			scores[i] = Math.exp((scores[i] - max) / (tau * max));
			tot += scores[i];
		}
		let r = rng.next() * tot;
		let pick = cand[n - 1];
		for (let i = 0; i < n; i++) {
			r -= scores[i];
			if (r <= 0) {
				pick = cand[i];
				break;
			}
		}
		ev.runPackage(pick);
		route.push(pick);
	}
	ev.journaling = false;
	const seconds = ev.cost(route);
	return { route: route.slice(0, ev.lastUsed), seconds, trials };
}

// Simulated annealing from `start`. Returns { route, seconds, evals, accepted }.
function anneal(ev, rng, start, { evals = 3000, t0 = 1500, t1 = 20 } = {}) {
	const run = ev.run;
	let cur = start.route.slice();
	let curCost = start.seconds;
	let best = cur.slice();
	let bestCost = curCost;
	const inRoute = new Uint8Array(run.P); // runs of each package in `cur`
	const cap = maxVisits(run);
	const zoneOf = run.packages.map((p) => p.zone);
	let accepted = 0;
	for (let it = 0; it < evals; it++) {
		const T = t0 * (t1 / t0) ** (it / evals);
		const n = cur.length;
		const next = cur.slice();
		const m = rng.int(8);
		inRoute.fill(0);
		for (const p of cur) inRoute[p]++;
		const randomUnused = (near) => {
			// A package near position `near`'s level band: unused, or (one try
			// in four) a return to a non-home package run fewer than
			// maxVisits(run) times.
			const pk = near >= 0 && near < n ? run.packages[cur[near]] : null;
			for (let tries = 0; tries < 30; tries++) {
				const p = rng.int(run.P);
				if (inRoute[p] && (run.pkgHome[p] || inRoute[p] >= cap || rng.int(4) > 0)) continue;
				if (pk && Math.abs(run.packages[p].band - pk.band) > 1 && tries < 25) continue;
				return p;
			}
			return -1;
		};
		if (n < 2 && m < 5) continue;
		if (m === 0) {
			// swap
			const i = rng.int(n);
			const j = rng.int(n);
			if (i === j) continue;
			next[i] = cur[j];
			next[j] = cur[i];
		} else if (m === 1 || m === 2) {
			// insert (move), mostly short distances
			const i = rng.int(n);
			const span = m === 1 ? 6 : n;
			let j = i + rng.int(2 * span + 1) - span;
			j = Math.max(0, Math.min(n - 1, j));
			if (i === j) continue;
			const [x] = next.splice(i, 1);
			next.splice(j, 0, x);
		} else if (m === 3) {
			// reverse a short segment
			const i = rng.int(n - 1);
			const j = Math.min(n - 1, i + 1 + rng.int(5));
			for (let a = i, b = j; a < b; a++, b--) {
				const tmp = next[a];
				next[a] = next[b];
				next[b] = tmp;
			}
		} else if (m === 4) {
			// merge: bring another package of the same zone right after i
			const i = rng.int(n);
			const z = zoneOf[cur[i]];
			const others = [];
			for (let k = 0; k < n; k++) if (k !== i && k !== i + 1 && zoneOf[cur[k]] === z) others.push(k);
			if (!others.length) continue;
			const k = others[rng.int(others.length)];
			const [x] = next.splice(k, 1);
			next.splice(k < i ? i : i + 1, 0, x);
		} else if (m === 5) {
			// drop
			if (n < 2) continue;
			next.splice(rng.int(n), 1);
		} else if (m === 6) {
			// add an unused package
			const j = rng.int(n + 1);
			const p = randomUnused(Math.min(j, n - 1));
			if (p < 0) continue;
			next.splice(j, 0, p);
		} else {
			// replace
			const i = rng.int(n);
			const p = randomUnused(i);
			if (p < 0) continue;
			next[i] = p;
		}
		const c = ev.cost(next);
		const used = ev.lastUsed;
		const d = c - curCost;
		if (d < 0 || rng.next() < Math.exp(-d / T)) {
			cur = next.slice(0, used);
			curCost = c;
			accepted++;
			if (c < bestCost - 1e-9) {
				bestCost = c;
				best = cur.slice();
			}
		}
	}
	return { route: best, seconds: bestCost, evals, accepted };
}

// One job: constructions, then annealing from the best of them or from a
// given elite route. Deterministic in (seed, round, index, elite).
function runJob(ev, job) {
	const rng = new Rng(hashSeed(job.seed, job.round, job.index));
	let evals = 0;
	let trials = 0;
	let best = null;
	const curve = [];
	for (let c = 0; c < job.constructions; c++) {
		const tau = 0.03 + rng.next() * 0.3;
		const r = construct(ev, rng, { tau });
		evals++;
		trials += r.trials;
		if (!best || r.seconds < best.seconds) best = r;
	}
	let start = best;
	if (job.elite && job.elite.length && job.index % 2 === 1) {
		const e = job.elite[(job.index >> 1) % job.elite.length];
		const sec = ev.cost(e);
		evals++;
		start = { route: e.slice(0, ev.lastUsed), seconds: sec };
	}
	curve.push([evals, best.seconds]);
	const sa = anneal(ev, rng, start, { evals: job.anneal, t0: job.t0, t1: job.t1 });
	evals += sa.evals;
	if (sa.seconds < best.seconds) best = { route: sa.route, seconds: sa.seconds };
	curve.push([evals, best.seconds]);
	return { round: job.round, index: job.index, route: best.route, seconds: best.seconds, evals, trials, constructionBest: curve[0][1] };
}

function routeKey(route) {
	return route.join(',');
}

// Merge job results (in job order) into the elite pool: distinct routes, best first.
function mergeElite(elite, results, size) {
	const all = elite.concat(results.map((r) => ({ route: r.route, seconds: r.seconds })));
	all.sort((a, b) => a.seconds - b.seconds || (routeKey(a.route) < routeKey(b.route) ? -1 : 1));
	const out = [];
	const seen = new Set();
	for (const e of all) {
		const k = routeKey(e.route);
		if (seen.has(k)) continue;
		seen.add(k);
		out.push(e);
		if (out.length >= size) break;
	}
	return out;
}

// Driver. execJobs(jobs) -> Promise<results[]> (in job order) runs a round,
// inline or on workers. opts: { paths, seed, jobsPerRound, constructions,
// anneal, eliteSize, convergeShare, maxPaths, log }
async function search(execJobs, opts) {
	const o = {
		paths: 1e6, seed: 1, jobsPerRound: 32, constructions: 6, anneal: 6000, eliteSize: 12, minRounds: 4,
		convergeShare: 0.25, convergeTol: 0.0005, maxPaths: null, t0: 1500, t1: 20, log: () => {},
		...Object.fromEntries(Object.entries(opts).filter(([, v]) => v !== undefined)),
	};
	const maxPaths = o.maxPaths || o.paths * 3;
	let elite = [];
	let evals = 0;
	let trials = 0;
	const curve = []; // [evals, best seconds] after each job, in job order
	let round = 0;
	const t0 = Date.now();
	for (;;) {
		const jobs = [];
		for (let j = 0; j < o.jobsPerRound; j++) {
			jobs.push({ seed: o.seed, round, index: j, constructions: o.constructions, anneal: o.anneal, t0: o.t0, t1: o.t1, elite: elite.map((e) => e.route) });
		}
		const results = await execJobs(jobs);
		let best = elite.length ? elite[0].seconds : Infinity;
		for (const r of results) {
			evals += r.evals;
			trials += r.trials;
			if (r.seconds < best) best = r.seconds;
			curve.push([evals, best]);
		}
		elite = mergeElite(elite, results, o.eliteSize);
		round++;
		o.log(`round ${round}: ${evals.toLocaleString('en-US')} routes, best ${(elite[0].seconds / 3600).toFixed(2)} h (${((Date.now() - t0) / 1000).toFixed(0)} s)`);
		if (evals >= o.paths && round >= o.minRounds && converged(curve, o.convergeShare, o.convergeTol)) break;
		if (evals >= maxPaths) break;
	}
	return { elite, best: elite[0], evals, trials, rounds: round, curve, converged: converged(curve, o.convergeShare, o.convergeTol), wallSeconds: (Date.now() - t0) / 1000 };
}

// Converged when the best improved by less than `tol` (relative) over the
// last `share` of evaluations.
function converged(curve, share, tol) {
	if (!curve.length) return false;
	const total = curve[curve.length - 1][0];
	const cut = total * (1 - share);
	let before = null;
	for (const [e, b] of curve) {
		if (e <= cut) before = b;
		else break;
	}
	if (before == null) return false;
	const now = curve[curve.length - 1][1];
	return (before - now) / before < tol;
}

module.exports = { construct, anneal, runJob, search, mergeElite, converged, routeKey };
