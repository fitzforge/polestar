'use strict';
// `sim compare` (docs/legacy/SIMULATION-js.md §5): Polestar's guides
// (the default route and every route choice) and the best route found, all
// scored under the same calibrated model. Inside another guide pack (or with
// --pack) compare also scores that pack's chain (after our default chain up
// to the pack's first level when it starts above level 1). Outputs go to data/bench/.

const fs = require('node:fs');
const path = require('node:path');
const sim = require('./index');
const { Evaluator } = require('./evaluate');
const { K_TURNIN } = require('./run');
const { compileSequence, routeSequence } = require('./sequence');
const { fmtH, table, mdTable } = require('./report');
const { LEVEL_XP } = require('../game/xp');
const { loadPolestarRoutes, requiredEvents } = require('./baselines/polestar');
const { resolvePack, packArgument } = require('../pack/locate');
const { printDiagnostics } = require('../cli');
const { isDir } = require('../addons');
const { ROOT } = require('../paths');

let LEVELS = [10, 20, 30, 40, 50, 60];

// A class run writes its own files, so the class-agnostic ones are left alone.
const clsPart = (cls) => (cls ? `-${cls.toLowerCase()}` : '');

// Every source for one character: [{ id, label, source, events | route, family?, guides? }]
function sources(o, faction, race, run, runD) {
	const out = [];
	const warn = [];
	// Guides are scored on what they require; --with-optional adds their optional goals.
	const evs = (events) => (o.withOptional ? events : requiredEvents(events));
	const res = loadResult(o, faction, race, 'solo', run.world, warn);
	if (res) out.push({ id: 'best', label: 'Best found (solo)', source: 'sim', route: sim.routeFromKeys(run, res.best.route) });
	const resD = loadResult(o, faction, race, 'dungeons', run.world, warn);
	if (resD) out.push({ id: 'best-dungeons', label: 'Best found (dungeons)', source: 'sim', route: sim.routeFromKeys(runD, resD.best.route), family: 'dungeons' });
	const guidesDir = o.guidesDir || path.join(ROOT, 'guides');
	try {
		const L = loadPolestarRoutes({ guidesDir, dataDir: o.dataDir, faction, race, cls: o.cls || null });
		if (L) {
			out.push({ id: 'polestar', label: 'Polestar default', source: 'polestar', events: evs(L.default.events) });
			L.variants.forEach((v, i) => out.push({ id: `polestar-${i + 1}`, label: `Polestar ${v.label}`, source: 'polestar-variant', events: evs(v.sequence.events) }));
		}
	} catch (err) {
		warn.push(`Polestar: ${err.message}`);
	}
	if (o.pack) {
		const id = o.pack.manifest.id;
		const ids = (seq) => seq.guides.map((g) => g.id);
		try {
			const P = loadPolestarRoutes({ guidesDir, dataDir: o.dataDir, faction, race, cls: o.cls || null, pack: o.pack });
			if (P) {
				out.push({ id: 'pack', label: `${id} default`, source: 'pack', events: evs(P.default.events), guides: ids(P.default) });
				P.variants.forEach((v, i) => out.push({ id: `pack-${i + 1}`, label: `${id} ${v.label}`, source: 'pack-variant', events: evs(v.sequence.events), guides: ids(v.sequence) }));
			} else {
				warn.push(`${id}: no leveling guide of the pack starts ${race}`);
			}
		} catch (err) {
			warn.push(`${id}: ${err.message}`);
		}
	}
	return { list: out, warn };
}

// A `sim run` result, or null when missing; a result searched on another
// world (data or builder changed) is refused, never replayed.
function loadResult(o, faction, race, family, world, warn) {
	const f = sim.resultFile(o.simDir, faction, race, o.cls || null, family, o.objective || 'time', o.tag || null);
	if (!fs.existsSync(f)) return null;
	const res = JSON.parse(fs.readFileSync(f, 'utf8'));
	try {
		sim.assertFresh(res, world, path.basename(f));
	} catch (err) {
		warn.push(`best found (${family}) not shown: ${err.message}`);
		return null;
	}
	return res;
}

// Evaluate a source; returns metrics plus a turn-in trace for bench.
// Package routes run through the route evaluator (two passes per package),
// guide sequences through the sequence evaluator (as written, grinding at
// their level steps). Both record a turn-in/zone trace.
function score(ev, run, src) {
	const trace = { turnins: [], zones: [] };
	const zname = run.world.zones;
	ev.hook = (k, q, pt) => {
		const lvl = ev.level + (ev.level < 60 ? ev.xp / LEVEL_XP[ev.level] : 0);
		const z = zname[run.world.points[run.ptList[pt]][4]] || '?';
		const last = trace.zones[trace.zones.length - 1];
		if (last && last.zone === z) last.to = lvl;
		else trace.zones.push({ zone: z, from: last ? last.to : 1, to: lvl });
		if (k === K_TURNIN) trace.turnins.push({ q: run.quests[q].id, level: lvl, time: ev.time });
	};
	let r;
	let seq;
	try {
		if (src.route) {
			seq = routeSequence(run, src.route);
			r = ev.evaluate(src.route);
			r.endLevel = 60;
		} else {
			seq = compileSequence(run, src.events);
			r = ev.evaluateSequence(seq, { honorCheckpoints: true });
		}
	} finally {
		ev.hook = null;
	}
	return { seq, r, trace };
}

async function compare(o) {
	const faction = sim.normFaction(o.faction);
	const { world } = await sim.loadWorld({ ...o, faction });
	const { mean } = sim.paramsFor(o.simDir, o.cls || null, o.objective || 'time', o.overrides || {});
	const out = [];
	for (const race of o.race ? [o.race] : sim.START_RACES[faction]) {
		// Solo sources run without dungeons, dungeon routes with them.
		const solo = sim.makeRun(world, { race, cls: o.cls || null, params: mean, family: 'solo' });
		const dung = sim.makeRun(world, { race, cls: o.cls || null, params: mean, family: 'dungeons' });
		const { list, warn } = sources(o, faction, race, solo.run, dung.run);
		const rows = [];
		for (const src of list) {
			const m = src.family === 'dungeons' ? dung : solo;
			const { seq, r, trace } = score(m.ev, m.run, src);
			const lastLevel = trace.turnins.length ? trace.turnins[trace.turnins.length - 1].level : 1;
			rows.push({
				id: src.id, label: src.label, source: src.source, family: src.family || 'solo', dungeonsRun: r.dungeonsRun || 0,
				levelsCovered: [1, Math.floor(r.endLevel || lastLevel)],
				timeTo: Object.fromEntries(r.levelTimes.map((t, l) => [l, t || null]).filter(([l]) => l >= 2)),
				seconds: r.seconds, endLevel: r.endLevel, endTime: r.endTime,
				quests: r.questsDone,
				// Partial guides: travel and grind inside the guide's own range.
				travelShare: r.endTime && r.endLevel < 59.5 ? r.endTravel / r.endTime : r.travelSeconds / r.seconds,
				grindSeconds: r.endTime && r.endLevel < 59.5 ? r.endGrind : r.grindSeconds,
				segment20to30: r.levelTimes[30] && (r.endLevel == null || r.endLevel >= 29.5) ? (r.levelTimes[20] ? r.levelTimes[30] - r.levelTimes[20] : null) : null,
				unknown: seq.unknown.length, unknownIds: seq.unknown,
				...sim.smoothness(r),
				...(src.guides ? { guides: src.guides } : {}),
				trace,
			});
		}
		out.push({ faction, race, class: sim.className(o.cls), objective: o.objective || 'time', overrides: o.overrides || {}, tag: o.tag || null, rows, warn });
	}
	return out;
}

function fmtRow(x) {
	return [
		x.label.length > 60 ? `${x.label.slice(0, 57)}...` : x.label,
		`${x.levelsCovered[0]}-${x.levelsCovered[1]}`,
		...LEVELS.map((l) => (x.timeTo[l] ? fmtH(x.timeTo[l]) : '-')),
		x.segment20to30 ? fmtH(x.segment20to30) : '-',
		x.quests, x.dungeonsRun, `${(100 * x.travelShare).toFixed(0)}%`, fmtH(x.grindSeconds), x.unknown,
		`${x.zoneChanges}/${x.zoneReturns}/${x.spotReturns}`,
	];
}

const makeHead = () => ['route', 'levels', ...LEVELS.map((l) => `to ${l}`), '20->30', 'quests', 'dungeons', 'travel', 'grind', 'unknown', 'zones/returns/spot returns'];
let HEAD = makeHead();

// The other pack compare scores: the folder named (one argument after
// `compare`, or --pack), else the nearest pack.json; null for ours.
// -> { pack }, { usage } for a usage error, or { error }
function comparePack(args) {
	const arg = packArgument(args, (args._ || []).slice(1));
	if (arg.error) return { usage: arg.error };
	const r = resolvePack({ pack: arg.pack });
	if (r.official) return { pack: null };
	if (!r.manifest) {
		printDiagnostics(r.diags);
		return { error: `${path.join(r.dir, 'pack.json')} is invalid` };
	}
	return { pack: { dir: r.dir, manifest: r.manifest } };
}

async function compareCommand(args, o) {
	// A mistyped --guides would score nothing of ours, silently.
	if (args.guides && !isDir(args.guides)) {
		console.error(`sim compare: --guides ${args.guides} is not a folder`);
		return 2;
	}
	let cls;
	try {
		cls = sim.normClass(args.class);
	} catch (err) {
		console.error(`sim compare: ${err.message}`);
		return 2;
	}
	const { pack, usage, error } = comparePack(args);
	if (usage) {
		console.error(`sim compare: ${usage}`);
		return 2;
	}
	if (error) {
		console.error(`sim compare: ${error}`);
		return 1;
	}
	const opts = { ...sim.DEFAULTS, ...o, faction: args.faction, race: args.race, cls, guidesDir: args.guides ? path.resolve(args.guides) : undefined, pack, withOptional: !!args['with-optional'] };
	if (args.to) LEVELS = String(args.to).split(',').map(Number).filter((l) => l >= 2 && l <= 60);
	HEAD = makeHead();
	const res = await compare(opts);
	fs.mkdirSync(opts.benchDir, { recursive: true });
	// [name, variant source, row label prefix] for ours and the pack.
	const kinds = [['Polestar', 'polestar-variant', /^Polestar /], ...(pack ? [[pack.manifest.id, 'pack-variant', new RegExp(`^${pack.manifest.id} `)]] : [])];
	for (const c of res) {
		const shown = c.rows.filter((x) => !kinds.some(([, src]) => x.source === src));
		const choices = [];
		for (const [name, src, prefix] of kinds) {
			const variants = c.rows.filter((x) => x.source === src).sort((a, b) => a.seconds - b.seconds);
			if (!variants.length) continue;
			shown.push({ ...variants[0], label: `${name} best choice: ${variants[0].label.replace(prefix, '')}` });
			shown.push({ ...variants[variants.length - 1], label: `${name} worst choice: ${variants[variants.length - 1].label.replace(prefix, '')}` });
			choices.push([name, variants]);
		}
		console.log(`\n== ${c.faction} ${c.race} (${c.class}): same calibrated model (guides ${opts.withOptional ? 'with' : 'without'} their optional goals; times are /played hours; grind = time spent grinding incl. after the guide ends) ==`);
		console.log(table(HEAD, shown.map(fmtRow)));
		for (const [name, variants] of choices) {
			console.log(`\n${name} route choices (${variants.length} complete paths):`);
			console.log(table(HEAD, variants.map(fmtRow)));
		}
		for (const w of c.warn) console.log(`warning: ${w}`);
		// A pack's comparison is its own file, so ours is never overwritten.
		const file = path.join(opts.benchDir, `compare-${c.faction.toLowerCase()}-${c.race.toLowerCase()}${clsPart(opts.cls)}${pack ? `-${pack.manifest.id}` : ''}${sim.variantSuffix(c.objective, c.tag)}.json`);
		fs.writeFileSync(file, `${JSON.stringify({ ...c, ...(pack ? { pack: pack.manifest.id } : {}), rows: c.rows.map(({ trace, ...x }) => x) }, null, 1)}\n`);
		const md = choices.length ? choices.map(([name, variants]) => `## ${name} route choices\n\n${mdTable(HEAD, variants.map(fmtRow))}\n`).join('\n') : `## Polestar route choices\n\n${mdTable(HEAD, [])}\n`;
		fs.writeFileSync(file.replace(/\.json$/, '.md'), `# ${c.faction} ${c.race} (${c.class})${pack ? ` (${pack.manifest.id})` : ''}: route comparison\n\n${mdTable(HEAD, shown.map(fmtRow))}\n\n${md}`);
		console.log(`wrote ${path.relative(process.cwd(), file)} (+ .md)`);
	}
	return 0;
}

module.exports = { compare, compareCommand, score, sources, LEVELS };
