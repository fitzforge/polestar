'use strict';
// Dungeon weave (docs/SIMULATION.md, "Weave"): what each dungeon is worth on
// a route that is already searched. Takes a `sim run` result (the solo
// family, any party size or tag) and, in the dungeon family's run, tries each
// dungeon's package at every place in that route: the place where it saves
// the most time to 60 (or costs the least) is its spot, and the difference
// is what the dungeon is worth for that character and party. Then adds the
// dungeons that pay, best first, each at its best spot in the route as it
// stands, while one still saves time: the recommended set.
//
// The route around a dungeon stays as searched, so a weave is a lower bound
// on what a dungeon search could find (a route rebuilt around the dungeon may
// gain more); it is what a guide with `when dungeon` steps offers: the solo
// route, with the dungeon run where the steps put it.

const fs = require('node:fs');
const path = require('node:path');
const sim = require('./index');
const { compileRun, makeTables } = require('./run');
const { Evaluator } = require('./evaluate');
const { fmtH, table } = require('./report');
const { draws: drawParams, NAMES } = require('./params');
const { spearman, quantile } = require('./robust');

// Time to 60 of a route followed as a plan (an under-levelled package is
// caught up by grinding, as a player following the guide would).
function seconds(ev, route) {
	return ev.evaluate(route).seconds;
}

// The best place for package `d` in `route` where its dungeon is run:
// { at, seconds } (at = index the package is inserted before; route.length =
// at the end; -1 and Infinity when no place runs it).
function bestSpot(ev, route, d) {
	let best = { at: -1, seconds: Infinity };
	const ran = ev.evaluate(route).dungeonsRun;
	for (let at = 0; at <= route.length; at++) {
		const r = ev.evaluate([...route.slice(0, at), d, ...route.slice(at)]);
		if (r.dungeonsRun > ran && r.seconds < best.seconds) best = { at, seconds: r.seconds };
	}
	return best;
}

// Where in the route a package runs: the level the character arrives with
// and the package before it.
function placeOf(ev, route, at) {
	const r = ev.evaluate(route, { detail: true });
	const rec = (r.perPackage || [])[at];
	return { level: rec ? rec.levelIn : null, after: at > 0 ? ev.run.packages[route[at - 1]].key : null };
}

// res: a `sim run` result (its best route); world: the world it was searched
// on; params: the parameters (the result's own). -> { base, dungeons, chosen, route, seconds }
function weave({ world, res, cls, params }) {
	const run = compileRun(world, { race: res.race, cls, family: 'dungeons' });
	if (!run.dungeons.length) throw new Error('no dungeons in the world: build data/forever/dungeons.json (`polestar dungeons build`) and rebuild the world');
	const ev = new Evaluator(run, makeTables(run, params), { catchUp: true });
	const base = sim.routeFromKeys(run, res.best.route);
	const baseSec = seconds(ev, base);
	const dpk = [];
	run.packages.forEach((p, i) => {
		if (p.dungeon !== undefined) dpk.push(i);
	});

	const first = new Map(dpk.map((d) => [d, bestSpot(ev, base, d)]));
	const dungeons = dpk.map((d) => {
		const pk = run.packages[d];
		const dg = run.dungeons[pk.dungeon];
		const spot = first.get(d);
		const place = spot.at >= 0 ? placeOf(ev, [...base.slice(0, spot.at), d, ...base.slice(spot.at)], spot.at) : { level: null, after: null };
		return {
			name: dg.name, levels: [dg.min, dg.max], quests: dg.quests.length, key: pk.key,
			at: spot.at, level: place.level, after: place.after,
			seconds: spot.seconds, delta: spot.seconds - baseSec,
		};
	});

	// The recommended set: add the dungeon that saves the most at its best
	// spot in the route as it stands, while one saves time.
	let route = base.slice();
	let cur = baseSec;
	const chosen = [];
	const left = new Set(dpk);
	for (;;) {
		let pick = null;
		for (const d of left) {
			// The first round is on the route as searched: the spots above.
			const s = chosen.length ? bestSpot(ev, route, d) : first.get(d);
			if (s.seconds < cur - 1 && (!pick || s.seconds < pick.seconds)) pick = { d, ...s };
		}
		if (!pick) break;
		route = [...route.slice(0, pick.at), pick.d, ...route.slice(pick.at)];
		chosen.push({ name: run.dungeons[run.packages[pick.d].dungeon].name, saves: cur - pick.seconds });
		cur = pick.seconds;
		left.delete(pick.d);
	}
	const at = new Map(route.map((p, i) => [p, i]));
	for (const c of chosen) {
		const d = dpk.find((p) => run.dungeons[run.packages[p].dungeon].name === c.name);
		c.level = placeOf(ev, route, at.get(d)).level;
	}
	return { base: baseSec, dungeons, chosen, route: route.map((p) => run.packages[p].key), seconds: cur };
}

// How sure a dungeon's worth is: K parameter draws from the result's priors,
// each dungeon at the spot the mean parameters gave it (the spot a guide
// ships), against the route alone under the same draw. Per dungeon: the mean,
// the 5th and 95th percentile of the time it saves (negative) or costs, the
// share of draws where it saves time, and the parameters that move it most
// (Spearman correlation with the delta). A draw in which the dungeon is not
// run at that spot (the character is past its levels, or at 60 first) says
// nothing about its worth and is left out: `draws` counts those that ran.
function uncertainty({ world, res, cls, dungeons, k = 200, seed = 7 }) {
	const run = compileRun(world, { race: res.race, cls, family: 'dungeons' });
	const base = sim.routeFromKeys(run, res.best.route);
	const placed = dungeons.filter((d) => d.at >= 0).map((d) => ({ d, pkg: run.packages.findIndex((p) => p.key === d.key) }));
	const ps = drawParams(res.priors, k, seed);
	const deltas = placed.map(() => []);
	for (const p of ps) {
		const ev = new Evaluator(run, makeTables(run, p), { catchUp: true });
		const b = ev.evaluate(base);
		placed.forEach((x, i) => {
			const r = ev.evaluate([...base.slice(0, x.d.at), x.pkg, ...base.slice(x.d.at)]);
			deltas[i].push(r.dungeonsRun > b.dungeonsRun ? r.seconds - b.seconds : NaN);
		});
	}
	const varied = NAMES.filter((n) => ps.some((p) => p[n] !== ps[0][n]));
	return placed.map((x, i) => {
		const v = deltas[i].filter(Number.isFinite);
		const sorted = v.slice().sort((a, b) => a - b);
		const drivers = varied.map((n) => ({ param: n, rho: spearman(ps.filter((_, j) => Number.isFinite(deltas[i][j])).map((p) => p[n]), v) }))
			.filter((d) => Number.isFinite(d.rho)).sort((a, b) => Math.abs(b.rho) - Math.abs(a.rho)).slice(0, 3);
		return {
			name: x.d.name, draws: v.length,
			mean: v.reduce((a, b) => a + b, 0) / (v.length || 1), p5: quantile(sorted, 0.05), p95: quantile(sorted, 0.95),
			saves: v.filter((d) => d < 0).length / (v.length || 1),
			drivers: drivers.map((d) => ({ param: d.param, rho: Math.round(d.rho * 100) / 100 })),
		};
	});
}

function weaveFile(simDir, faction, race, cls, objective, tag) {
	return path.join(simDir, 'weave', path.basename(sim.resultFile(simDir, faction, race, cls, 'solo', objective, tag)));
}

const fmtMin = (s) => (Number.isFinite(s) ? `${s >= 0 ? '+' : ''}${(s / 60).toFixed(0)} min` : 'not run');

async function command(args, o) {
	const faction = sim.normFaction(args.faction);
	const cls = sim.normClass(args.class);
	const simDir = o.simDir || sim.DEFAULTS.simDir;
	const objective = o.objective || 'time';
	const { world, worldFile } = await sim.loadWorld({ ...o, faction });
	const races = args.race ? [args.race] : sim.START_RACES[faction];
	for (const race of races) {
		const file = sim.resultFile(simDir, faction, race, cls, 'solo', objective, o.tag || null);
		if (!fs.existsSync(file)) {
			console.error(`sim weave: no result ${path.relative(process.cwd(), file)}: run \`sim run --faction ${faction.toLowerCase()} --race ${race}\` with the same options first`);
			return 1;
		}
		const res = JSON.parse(fs.readFileSync(file, 'utf8'));
		sim.assertFresh(res, world, file);
		// Today's priors (with --party and --param), not the ones the result
		// was searched under: a dungeon parameter added since then counts too.
		const { eff, mean } = sim.paramsFor(simDir, cls, objective, o.overrides || {});
		const now = { ...res, params: mean, priors: eff };
		const w = weave({ world, res: now, cls, params: mean });
		if (args.draws) w.uncertainty = uncertainty({ world, res: now, cls, dungeons: w.dungeons, k: Number(args.draws), seed: args.seed ? Number(args.seed) : 7 });
		const out = { schema: 1, faction, race, class: sim.className(cls), objective, tag: o.tag || null, partySize: mean.partySize || 1, dataHash: world.dataHash, result: path.relative(process.cwd(), file), worldFile: path.relative(process.cwd(), worldFile), ...w };
		const wf = weaveFile(simDir, faction, race, cls, objective, o.tag || null);
		fs.mkdirSync(path.dirname(wf), { recursive: true });
		fs.writeFileSync(wf, `${JSON.stringify(out, null, 1)}\n`);
		console.log(`\n== ${faction} ${race} (${sim.className(cls)}, party of ${out.partySize}${o.tag ? `, ${o.tag}` : ''}) ==`);
		console.log(`solo route: ${fmtH(w.base)} to 60`);
		const rows = w.dungeons.slice().sort((a, b) => a.delta - b.delta).map((d) => [d.name, `${d.levels[0]}-${d.levels[1]}`, d.quests, d.level != null ? d.level.toFixed(1) : '-', fmtMin(d.delta)]);
		console.log(table(['dungeon', 'levels', 'quests', 'run at', 'time to 60'], rows));
		if (w.uncertainty) {
			const urows = w.uncertainty.slice().sort((a, b) => a.mean - b.mean).map((u) => [u.name, fmtMin(u.mean), `${fmtMin(u.p5)} .. ${fmtMin(u.p95)}`, `${Math.round(100 * u.saves)}%`, u.drivers.map((d) => `${d.param} ${d.rho}`).join(', ')]);
			console.log(`\nunder ${w.uncertainty[0] ? w.uncertainty[0].draws : 0} parameter draws (the dungeon at its spot):`);
			console.log(table(['dungeon', 'mean', '90% interval', 'saves in', 'moved most by'], urows));
		}
		console.log(w.chosen.length ? `recommended: ${w.chosen.map((c) => `${c.name} (at ${c.level.toFixed(1)}, saves ${(c.saves / 60).toFixed(0)} min)`).join(', ')}; ${fmtH(w.seconds)} to 60` : 'recommended: none (no dungeon saves time on this route)');
		console.log(`wrote ${path.relative(process.cwd(), wf)}`);
	}
	return 0;
}

module.exports = { weave, bestSpot, uncertainty, command, weaveFile };
