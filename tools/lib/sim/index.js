'use strict';
// Simulator orchestration shared by the `sim` subcommands
// (docs/SIMULATION.md): world loading, character runs, search on workers,
// result files and route descriptions.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { getWorld, worldFile } = require('./world');
const { attachWalks } = require('./walks');
const { loadQuestXp } = require('../game/xp');
const { compileRun, makeTables } = require('./run');
const { Evaluator } = require('./evaluate');
const { runJob, search } = require('./search');
const { Pool } = require('./pool');
const { loadParamsFile, effective, means, objectiveName, tagName } = require('./params');
const { CLASSES, classLabel } = require('../game/races');

const { ROOT, DATA, SOURCES } = require('../paths');
const DEFAULTS = {
	dataDir: DATA,
	simDir: path.join(ROOT, 'data', 'sim'),
	sourcesDir: SOURCES,
	benchDir: path.join(ROOT, 'data', 'bench'),
};

const FACTIONS = { alliance: 'Alliance', horde: 'Horde' };
// Start races the runs cover (one per starting area, plus Forever's own).
const START_RACES = { Horde: ['Orc', 'Tauren', 'Undead', 'Skyborne'], Alliance: ['Human', 'Dwarf', 'NightElf', 'Skyborne'] };

// Class names as the rest of the model writes them (title case: the keys of
// CLASS_FACTOR in params.js and of CLASS_BITS in run.js), from any case. An
// unknown name fails here: left alone it is a silent wrong answer, because
// `q.classes & CLASS_BITS[undefined]` is 0, so every class quest drops out.
function normClass(c) {
	if (c == null || c === '') return null;
	const k = String(c).toLowerCase();
	if (!CLASSES[k]) throw new Error(`--class must be one of ${Object.values(CLASSES).map((x) => classLabel(x.file)).join(', ')} (got ${c})`);
	return classLabel(CLASSES[k].file);
}

function normFaction(f) {
	const v = FACTIONS[String(f || '').toLowerCase()];
	if (!v) throw new Error(`--faction must be Alliance or Horde (got ${f})`);
	return v;
}

async function loadWorld(o) {
	const opts = { ...DEFAULTS, ...o };
	const questXp = await loadQuestXp({ sourcesDir: opts.sourcesDir, offline: opts.offline, log: opts.log });
	const world = getWorld({ dataDir: opts.dataDir, sourcesDir: opts.sourcesDir, simDir: opts.simDir, faction: opts.faction, rebuild: opts.rebuild, questXp, log: opts.log, bandWidth: opts.bandWidth, maxOpen: opts.maxOpen, extraStarts: opts.extraStarts, variant: opts.variant });
	// Routed walks (sim walks), unless --no-walks: the straight line × detour then.
	if (opts.walks !== false) attachWalks(world, opts.simDir, { log: opts.log });
	else world.walks = null;
	return { world, worldFile: worldFile(opts.simDir, opts.faction, opts.variant) };
}

// Parameters for a class under an objective (params.js OBJECTIVES) and
// `--param` overrides ({ key: value }, applied last).
function paramsFor(simDir, cls, objective = 'time', overrides = {}) {
	const doc = loadParamsFile(simDir);
	const eff = effective(doc, cls, objective, overrides);
	return { doc, eff, mean: means(eff) };
}

function makeRun(world, { race, cls, params, family = 'solo' }) {
	const run = compileRun(world, { race, cls, family });
	const tables = makeTables(run, params);
	return { run, tables, ev: new Evaluator(run, tables) };
}

function className(cls) {
	return cls ? String(cls) : 'any';
}

// File name suffix of a search variant: the time objective without a tag
// keeps the plain name; another objective and a `--tag` get their own
// (horde-orc-any-smooth.json, horde-orc-any-smooth-g6.json), so variants
// never overwrite each other.
function variantSuffix(objective = 'time', tag = null) {
	const obj = objectiveName(objective);
	const t = tagName(tag);
	return `${obj === 'time' ? '' : `-${obj}`}${t ? `-${t}` : ''}`;
}

function resultFile(simDir, faction, race, cls, family = 'solo', objective = 'time', tag = null) {
	return path.join(simDir, 'results', `${faction.toLowerCase()}-${race.toLowerCase()}-${className(cls).toLowerCase()}${family === 'solo' ? '' : `-${family}`}${variantSuffix(objective, tag)}.json`);
}

// ", smooth objective, grindWeight=6 (tag g6)" for report headers; "" for
// the plain time search.
function variantLabel(objective = 'time', overrides = {}, tag = null) {
	const parts = [];
	if (objectiveName(objective) !== 'time') parts.push(`${objectiveName(objective)} objective`);
	for (const [k, v] of Object.entries(overrides || {})) parts.push(`${k}=${v}`);
	if (tag) parts.push(`tag ${tag}`);
	return parts.map((p) => `, ${p}`).join('');
}

// Smoothness counters of an evaluation (evaluate.js result()).
function smoothness(r) {
	return {
		zoneChanges: r.zoneChanges, zoneReturns: r.zoneReturns, spotReturns: r.spotReturns, sharedKills: r.sharedKills,
		logPeak: r.logPeak, logDeferred: r.logDeferred, logSkipped: r.logSkipped, logAbandoned: r.logAbandoned, acceptedNeverTurnedIn: r.acceptedNeverTurnedIn,
	};
}

// Drop packages that changed nothing (all steps skipped): same cost, shorter
// route. Home packages stay (the route rules need every one of them).
function prune(ev, route) {
	const r = ev.evaluate(route, { detail: true });
	if (!r.feasible) return route;
	return r.perPackage.filter((x) => x.leave > x.arrive || x.quests > 0 || ev.run.pkgHome[x.pkg]).map((x) => x.pkg);
}

// Zone visits (consecutive packages in one zone) with level ranges and times.
function describe(ev, route) {
	const r = ev.evaluate(route, { detail: true });
	const visits = [];
	for (const x of r.perPackage) {
		const last = visits[visits.length - 1];
		if (last && last.zone === x.zone) {
			last.leave = x.leave;
			last.levelOut = x.levelOut;
			last.quests += x.quests;
			last.packages.push(x.key);
			last.travel += x.travel;
			last.grind += x.grind;
		} else visits.push({ zone: x.zone, arrive: x.arrive, leave: x.leave, levelIn: x.levelIn, levelOut: x.levelOut, quests: x.quests, packages: [x.key], travel: x.travel, grind: x.grind });
	}
	if (r.levelTimes[60] > 0 && r.grindSeconds > 0 && visits.length) {
		const last = visits[visits.length - 1];
		if (last.levelOut < 60) visits.push({ zone: '(grind to 60)', arrive: last.leave, leave: r.seconds, levelIn: last.levelOut, levelOut: 60, quests: 0, packages: [], travel: 0, grind: r.seconds - last.leave });
	}
	return { ...r, visits };
}

// Measured milliseconds per full route evaluation.
function benchEval(ev, route, ms = 1500) {
	let n = 0;
	const t0 = process.hrtime.bigint();
	let el = 0;
	while (el < ms) {
		for (let i = 0; i < 50; i++) ev.cost(route);
		n += 50;
		el = Number(process.hrtime.bigint() - t0) / 1e6;
	}
	return el / n;
}

// Search for one character. Returns the result object (also written to disk
// unless opts.write === false).
async function runCharacter(o) {
	const opts = { ...DEFAULTS, seed: 1, paths: 1e6, workers: Math.max(1, os.availableParallelism ? os.availableParallelism() : os.cpus().length), family: 'solo', ...Object.fromEntries(Object.entries(o).filter(([, v]) => v !== undefined)) };
	const faction = normFaction(opts.faction);
	const { world, worldFile: wf } = opts.world ? { world: opts.world, worldFile: opts.worldFile } : await loadWorld({ ...opts, faction });
	const objective = objectiveName(opts.objective);
	const overrides = opts.overrides || {};
	const tag = tagName(opts.tag);
	const { eff, mean } = paramsFor(opts.simDir, opts.cls, objective, overrides);
	const params = opts.params || mean;
	const runOpts = { race: opts.race, cls: opts.cls || null, family: opts.family };
	const local = makeRun(world, { ...runOpts, params });
	const log = opts.log || (() => {});
	log(`${faction} ${opts.race} ${className(opts.cls)} (${opts.family}, ${objective} objective${Object.keys(overrides).length ? `, ${Object.entries(overrides).map(([k, v]) => `${k}=${v}`).join(' ')}` : ''}): ${local.run.Q} quests in ${local.run.P} packages`);

	let pool = null;
	let exec;
	if (opts.workers > 1) {
		pool = new Pool(opts.workers, { worldFile: wf, runOpts, params, walks: !!world.walks });
		exec = (jobs) => pool.run(jobs.map((job) => ({ type: 'search', job })));
	} else exec = async (jobs) => jobs.map((job) => runJob(local.ev, job));
	let res;
	try {
		res = await search(exec, { paths: opts.paths, seed: opts.seed, jobsPerRound: opts.jobsPerRound, constructions: opts.constructions, anneal: opts.anneal, maxPaths: opts.maxPaths, log });
	} finally {
		if (pool) await pool.close();
	}
	const ev = local.ev;
	const keys = (route) => route.map((p) => local.run.packages[p].key);
	const bestRoute = prune(ev, res.best.route);
	const best = describe(ev, bestRoute);
	const msPerEval = opts.benchMs === 0 ? null : benchEval(ev, bestRoute, opts.benchMs || 1500);
	const out = {
		schema: 1,
		faction, race: opts.race, class: className(opts.cls), family: opts.family, objective, overrides, tag,
		seed: opts.seed, workers: opts.workers, paths: opts.paths,
		evaluatedRoutes: res.evals, packageTrials: res.trials, rounds: res.rounds, converged: res.converged,
		wallSeconds: res.wallSeconds, msPerEval,
		dataHash: world.dataHash,
		walks: world.walksId || null,
		params, priors: eff,
		curve: downsample(res.curve, 200),
		best: {
			route: keys(bestRoute), seconds: best.seconds, timeTo: best.timeTo, levelTimes: best.levelTimes, xpSplit: best.xpSplit,
			travelSeconds: best.travelSeconds, grindSeconds: best.grindSeconds, questsDone: best.questsDone, hearths: best.hearths, flights: best.flights,
			...smoothness(best),
			visits: best.visits,
		},
		elite: res.elite.map((e) => ({ route: keys(prune(ev, e.route)), seconds: e.seconds })),
	};
	if (opts.write !== false) {
		const file = resultFile(opts.simDir, faction, opts.race, opts.cls, opts.family, objective, tag);
		fs.mkdirSync(path.dirname(file), { recursive: true });
		fs.writeFileSync(file, `${JSON.stringify(out, null, 1)}\n`);
		out.file = file;
	}
	return out;
}

function downsample(curve, n) {
	if (curve.length <= n) return curve;
	const out = [];
	for (let i = 0; i < n; i++) out.push(curve[Math.round((i * (curve.length - 1)) / (n - 1))]);
	return out;
}

// Package keys -> run indices (unknown keys are dropped).
function routeFromKeys(run, keys) {
	const idx = new Map(run.packages.map((p, i) => [p.key, i]));
	return keys.map((k) => idx.get(k)).filter((i) => i != null);
}

// A result replays only on the world it was searched on (same data and
// builder hash); anything else would silently replay a different route.
function assertFresh(res, world, file) {
	if (res.dataHash !== world.dataHash) {
		throw new Error(`${file || 'result'} was searched on world ${String(res.dataHash).slice(0, 12)}, the current ${world.faction} world is ${String(world.dataHash).slice(0, 12)} (data or builder changed): rerun \`sim run --faction ${world.faction.toLowerCase()}\``);
	}
	if ((res.walks || null) !== (world.walksId || null)) {
		throw new Error(`${file || 'result'} was searched ${res.walks ? 'with other routed walks' : 'without routed walks'}, the current ${world.faction} world walks ${world.walksId ? 'routed (sim walks)' : 'the straight line × detour'}: rerun \`sim run --faction ${world.faction.toLowerCase()}\``);
	}
}

module.exports = {
	DEFAULTS, START_RACES, normFaction, normClass, loadWorld, paramsFor, makeRun, className, resultFile, assertFresh,
	prune, describe, benchEval, runCharacter, routeFromKeys, downsample, smoothness, variantSuffix, variantLabel,
};
