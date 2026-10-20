'use strict';
// `polestar sim`: route simulation and optimization (docs/SIMULATION.md).

const path = require('node:path');
const sim = require('../lib/sim');
const { fmtH, fmtHM, table } = require('../lib/sim/report');
const { objectiveName, parseOverrides, tagName } = require('../lib/sim/params');

const usage = `usage: node tools/polestar.js sim <command> [options]

  sim world   [--faction F] [--rebuild] [--elites]    build/cache the world model (data/sim/world-<faction>.json)
  sim walks   [--faction F] [--radius Y] [--workers W]  route the world's walks with the walking router
              (data/sim/walks-<faction>.json, with --elites walks-<faction>-group.json;
               run, robust, compare, bench and consensus use them)
  sim calibrate [--fdj DIR]                            fit parameters to quest data and recordings
  sim run     --faction F [--race R] [--class C] [--paths N] [--workers W] [--seed S] [--dungeons] [--party N] [--elites]
              [--jobs J] [--anneal A] [--max-paths M] [--objective time|smooth] [--param K=V ...] [--tag T]
  sim robust  --faction F [--race R] [--class C] [--draws K] [--top N] [--objective O]   robustness of the top routes
  sim compare --faction F [--race R] [--class C] [--guides DIR] [--pack DIR | DIR] [--to 10,20,30] [--with-optional]
              [--objective O]   Polestar's routes vs the best found, same model
  sim bench   --faction F [--race R] [--class C]      bracket table: zones, levels, quests per 10 levels
  sim export  --result <file> --out <dir>             zone-by-zone skeleton guides + visits.json for authors
  sim consensus --faction F [--dungeons] [--evals N] [--objective O]   one 12-60 route shared by the faction's starts (+ exports)
  sim weave   --faction F [--race R] [--class C] [--party N] [--elites] [--draws K]   what each dungeon is worth on a
              searched route: its best spot, the time to 60 it saves or costs, the recommended set (data/sim/weave/),
              and with --draws how sure that is under K parameter draws
  sim elites  --faction F [--race R] [--party N] [--min M] [--apply]   what each elite quest saves a party on its
              --elites route (more than M minutes, default 5), and draft \`when group\` steps for the
              ones our guides lack, placed where a guide visits the giver (data/sim/elites/); --apply
              writes them into the guide files and takes out any block lint reports in
  sim advice  [--lua <file>]   what each dungeon is worth to a party of 1 to 5, from the weaves in
              data/sim/weave/ (run \`sim weave --party N --draws K\` per start race), for the addon's
              dungeon offer (addon/Polestar/Dungeons/AdviceData.lua)

Without --race, run/robust/compare/bench cover every start of the faction
(Horde: Orc, Tauren, Undead, Skyborne; Alliance: Human, Dwarf, NightElf,
Skyborne). Class defaults to none ("any": class quests excluded, class factor
1); with --class the class's quests and kill-speed prior are used, and
compare/bench write their own files so the class-agnostic ones stay.

options:
  --data <dir>       reference data (default data/forever)
  --sim <dir>        simulator outputs (default data/sim)
  --fdj <dir>        calibrate: ForeverDungeonJournal folder (default: the installed one)
  --class <name>     Warrior, Paladin, Hunter, Rogue, Priest, Shaman, Mage, Warlock or Druid:
                     score for that class (run/robust/compare/bench); default none ("any")
  --band <levels>    level width of the world's quest packages (default 5; a new width rebuilds the world)
  --guides <dir>     compare: Polestar guides folder to score (default guides/), e.g. an old copy
  --pack <dir>       compare: also score this pack's chain (or name the pack folder
                     as the one argument; default: the nearest pack.json); after our chain
                     up to its first level when it starts above 1;
                     written to data/bench/compare-<faction>-<race>-<pack id>.json
  --to <levels>      compare: levels to show time to (default 10,20,30,40,50,60)
  --with-optional    compare/bench: also score the guides' optional goals (default: only what
                     a guide requires; elite and dungeon quests stay out either way)
  --jobs <n>         run: search jobs per round (default 32)
  --anneal <n>       run: annealing evaluations per job (default 6000)
  --max-paths <n>    run: hard cap on evaluated routes (default 3x --paths)
  --dungeons         run/robust/consensus: the dungeon-inclusive family (needs data/forever/dungeons.json)
  --party <n>        run/robust/compare/consensus: a party of n (1-5) levelling together: shared kills
                     and group XP, drops per member, a premade dungeon group (docs/SIMULATION.md,
                     "Party"); results get the tag party<n> unless --tag names another
  --elites           world/run/robust/compare/consensus: keep elite quests (the group world,
                     data/sim/world-<faction>-group.json); results get the tag elites (with
                     --party: party<n>-elites) unless --tag names another
  --objective <o>    run/robust/compare/consensus: what the search optimises (default time):
                     time = the fastest route; smooth = fewer zone changes, returns into zones
                     left earlier and returns to spots already worked (docs/SIMULATION.md);
                     smooth results are their own files (horde-orc-any-smooth.json)
  --param <k=v>      run/robust/compare/consensus: set a model parameter (params.js), after the
                     objective's preset; repeatable (--param grindWeight=6 --param zoneReturn=0)
  --tag <name>       run/robust/compare/consensus: a result file variant, e.g. --tag g6 writes
                     horde-orc-any-smooth-g6.json (and robust/compare/consensus read and write it)
  --radius <yards>   walks: route every pair of points up to this far apart (default 4000)
  --no-walks         run/robust/compare/bench/consensus: walk the straight line × detour even
                     when data/sim/walks-<faction>.json is there
  --offline          never download the QuestXP table
  --quiet            less output`;

const VALUE = new Set(['faction', 'race', 'class', 'paths', 'workers', 'seed', 'draws', 'top', 'result', 'out', 'data', 'sim', 'fdj', 'guides', 'pack', 'to', 'band', 'jobs', 'anneal', 'max-paths', 'evals', 'radius', 'objective', 'param', 'tag', 'party', 'lua']);
const REPEAT = new Set(['param']);
const FLAGS = new Set(['rebuild', 'offline', 'quiet', 'help', 'dungeons', 'with-optional', 'no-walks', 'elites', 'apply']);

function parseArgs(argv) {
	const out = { _: [] };
	for (let i = 0; i < argv.length; i++) {
		const a = argv[i];
		const m = /^--([a-z-]+)(?:=(.*))?$/.exec(a);
		if (!m) {
			out._.push(a);
			continue;
		}
		const key = m[1];
		if (FLAGS.has(key)) {
			out[key] = true;
			continue;
		}
		if (!VALUE.has(key)) throw new Error(`unknown option --${key}`);
		const v = m[2] != null ? m[2] : argv[++i];
		if (v == null) throw new Error(`--${key} needs a value`);
		if (REPEAT.has(key)) (out[key] = out[key] || []).push(v);
		else out[key] = v;
	}
	return out;
}

function common(args) {
	const o = {};
	if (args.data) o.dataDir = path.resolve(args.data);
	if (args.sim) o.simDir = path.resolve(args.sim);
	if (args.offline) o.offline = true;
	if (args.band) o.bandWidth = Number(args.band);
	if (args.objective) o.objective = objectiveName(args.objective);
	if (args.param) o.overrides = parseOverrides(args.param);
	if (args.tag) o.tag = tagName(args.tag);
	// A party levelling together: partySize fixed, results in their own files (`party3`).
	if (args.party) {
		o.overrides = { ...(o.overrides || {}), partySize: partyArg(args.party) };
		if (!o.tag) o.tag = `party${o.overrides.partySize}`;
	}
	// Elite quests open: the group world (world-<faction>-group.json), results
	// in their own files (`elites`, `party3-elites`).
	if (args.elites) {
		o.variant = 'group';
		if (!args.tag) o.tag = o.tag ? `${o.tag}-elites` : 'elites';
	}
	if (args['no-walks']) o.walks = false;
	o.log = args.quiet ? () => {} : (m) => console.error(m);
	return o;
}

function partyArg(v) {
	const n = Number(v);
	if (!Number.isInteger(n) || n < 1 || n > 5) throw new Error(`--party must be 1 to 5 players (got ${v})`);
	return n;
}

function races(args, faction) {
	return args.race ? [args.race] : sim.START_RACES[faction];
}

function printRun(r) {
	console.log(`\n== ${r.faction} ${r.race} (${r.class}, ${r.family}${sim.variantLabel(r.objective, r.overrides, r.tag)}) ==`);
	console.log(`evaluated routes ${r.evaluatedRoutes.toLocaleString('en-US')} in ${r.rounds} rounds, ${r.wallSeconds.toFixed(1)} s on ${r.workers} workers; ${r.msPerEval != null ? r.msPerEval.toFixed(3) : '?'} ms per route evaluation; converged: ${r.converged ? 'yes' : 'no'}`);
	console.log(`best: ${fmtH(r.best.seconds)} to 60 (${fmtHM(r.best.seconds)}); quests ${r.best.questsDone}; XP quest/kill/grind ${r.best.xpSplit.quest}/${r.best.xpSplit.kill}/${r.best.xpSplit.grind}; travel ${((100 * r.best.travelSeconds) / r.best.seconds).toFixed(1)}%; grinding ${fmtH(r.best.grindSeconds)}`);
	console.log(`smoothness: zone changes ${r.best.zoneChanges}; zone returns ${r.best.zoneReturns}; spot returns ${r.best.spotReturns}; shared-credit kills saved ${Math.round(r.best.sharedKills)}`);
	console.log(`quest log: peak ${r.best.logPeak}; accepts deferred for a full log ${r.best.logDeferred}, skipped ${r.best.logSkipped}; quests abandoned ${r.best.logAbandoned}; accepted but never turned in ${r.best.acceptedNeverTurnedIn}`);
	console.log(`time to: ${Object.entries(r.best.timeTo).map(([l, s]) => `${l}: ${fmtH(s)}`).join('  ')}`);
	console.log(table(['zone', 'levels', 'arrive', 'hours', 'quests'], r.best.visits.map((v) => [v.zone, `${v.levelIn.toFixed(1)}-${v.levelOut.toFixed(1)}`, fmtH(v.arrive), ((v.leave - v.arrive) / 3600).toFixed(2), v.quests])));
	const c = r.curve;
	const pts = [0.1, 0.25, 0.5, 0.75, 1].map((f) => c[Math.min(c.length - 1, Math.round(f * (c.length - 1)))]);
	console.log(`convergence (routes -> best h): ${pts.map(([e, s]) => `${e.toLocaleString('en-US')} -> ${(s / 3600).toFixed(2)}`).join(', ')}`);
	if (r.file) console.log(`wrote ${path.relative(process.cwd(), r.file)}`);
}

async function run(argv) {
	let args;
	try {
		args = parseArgs(argv);
		if (args.objective) objectiveName(args.objective);
		parseOverrides(args.param);
		tagName(args.tag);
		if (args.party) partyArg(args.party);
	} catch (err) {
		console.error(`${err.message}\n\n${usage}`);
		return 2;
	}
	const cmd = args._[0];
	if (!cmd || args.help || cmd === 'help') {
		console.log(usage);
		return cmd ? 0 : 2;
	}
	const o = common(args);
	try {
		if (cmd === 'world') {
			const factions = args.faction ? [sim.normFaction(args.faction)] : ['Horde', 'Alliance'];
			for (const faction of factions) {
				const { world, worldFile } = await sim.loadWorld({ ...o, faction, rebuild: !!args.rebuild });
				const reasons = {};
				for (const e of world.excluded) {
					const k = e.reason.replace(/\d+/g, 'N');
					reasons[k] = (reasons[k] || 0) + 1;
				}
				console.log(`${faction}: ${world.quests.length} quests, ${world.packages.length} packages (${world.packages.filter((p) => p.dungeon).length} dungeon), ${world.hubs.length} hubs, ${world.nodes.length} transport nodes, ${world.points.length} points; starts ${Object.keys(world.starts).join(', ')}`);
				console.log(`  excluded ${world.excluded.length}: ${Object.entries(reasons).sort((a, b) => b[1] - a[1]).map(([k, n]) => `${n} ${k}`).join('; ')}`);
				if (world.solo) console.log(`  solo filter: ${Object.entries(world.solo.counts).map(([k, n]) => `${n} ${k}`).join(', ')}; ${world.solo.repeatNoXp} repeatables without a recorded reward give no XP; instance areas from client build ${world.solo.instanceAreas || 'none (dungeons.json only)'}`);
				for (const w of world.warnings || []) console.log(`  warning: ${w}`);
				console.log(`  ${path.relative(process.cwd(), worldFile)}`);
			}
			return 0;
		}
		if (cmd === 'walks') {
			const { buildWalks, writeWalks } = require('../lib/sim/walks');
			const factions = args.faction ? [sim.normFaction(args.faction)] : ['Horde', 'Alliance'];
			for (const faction of factions) {
				const { world } = await sim.loadWorld({ ...o, faction, walks: false });
				const t0 = Date.now();
				const doc = await buildWalks(world, {
					log: o.log,
					radius: args.radius ? Number(args.radius) : undefined,
					workers: args.workers ? Number(args.workers) : undefined,
				});
				const file = writeWalks(o.simDir || sim.DEFAULTS.simDir, doc);
				console.log(`${faction}: ${doc.points} points, ${doc.pairs.length / 3} routed walks within ${doc.radius} yd (${doc.style}) in ${((Date.now() - t0) / 1000).toFixed(0)} s`);
				console.log(`  ${path.relative(process.cwd(), file)}`);
			}
			return 0;
		}
		if (cmd === 'run') {
			const faction = sim.normFaction(args.faction);
			let cls;
			try {
				cls = sim.normClass(args.class);
			} catch (err) {
				console.error(`sim run: ${err.message}`);
				return 2;
			}
			const family = args.dungeons ? 'dungeons' : 'solo';
			for (const race of races(args, faction)) {
				const r = await sim.runCharacter({
					...o, faction, race, cls, family,
					paths: args.paths ? Number(args.paths) : undefined,
					workers: args.workers ? Number(args.workers) : undefined,
					seed: args.seed ? Number(args.seed) : undefined,
					jobsPerRound: args.jobs ? Number(args.jobs) : undefined,
					anneal: args.anneal ? Number(args.anneal) : undefined,
					maxPaths: args['max-paths'] ? Number(args['max-paths']) : undefined,
				});
				printRun(r);
			}
			return 0;
		}
		if (cmd === 'robust') return await require('../lib/sim/robust').command(args, o);
		if (cmd === 'compare') return await require('../lib/sim/compare').compareCommand(args, o);
		if (cmd === 'bench') return await require('../lib/sim/compare').benchCommand(args, o);
		if (cmd === 'calibrate') return await require('../lib/sim/calibrate').command(args, o);
		if (cmd === 'export') return await require('../lib/sim/export').command(args, o);
		if (cmd === 'consensus') return await require('../lib/sim/consensus').command(args, o);
		if (cmd === 'weave') return await require('../lib/sim/weave').command(args, o);
		if (cmd === 'elites') return await require('../lib/sim/elites').command(args, o);
		if (cmd === 'advice') return require('../lib/sim/advice').command(args, o);
		console.error(`unknown sim command "${cmd}"\n\n${usage}`);
		return 2;
	} catch (err) {
		console.error(err && err.stack ? err.stack : String(err));
		return 1;
	}
}

module.exports = { name: 'sim', summary: 'simulate and optimize leveling routes (docs/SIMULATION.md)', usage, run, parseArgs };
