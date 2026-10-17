'use strict';
// `polestar sim`: route simulation and optimization (docs/SIMULATION.md).

const path = require('node:path');
const sim = require('../lib/sim');
const { fmtH, fmtHM, table } = require('../lib/sim/report');

const usage = `usage: node tools/polestar.js sim <command> [options]

  sim world   [--faction F] [--rebuild]               build/cache the world model (data/sim/world-<faction>.json)
  sim calibrate [--fdj DIR]                            fit parameters to quest data and recordings
  sim run     --faction F [--race R] [--class C] [--paths N] [--workers W] [--seed S] [--dungeons]
              [--jobs J] [--anneal A] [--max-paths M]
  sim robust  --faction F [--race R] [--class C] [--draws K] [--top N]   robustness of the top routes
  sim compare --faction F [--race R] [--class C] [--guides DIR] [--pack DIR | DIR] [--to 10,20,30] [--with-optional]
              Polestar's routes vs the best found, same model
  sim bench   --faction F [--race R] [--class C]      bracket table: zones, levels, quests per 10 levels
  sim export  --result <file> --out <dir>             zone-by-zone skeleton guides + visits.json for authors
  sim consensus --faction F [--dungeons] [--evals N]  one 12-60 route shared by the faction's starts (+ exports)

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
  --pack <dir>       compare: also score this guide pack's chain (or name the pack folder
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
  --offline          never download the QuestXP table
  --quiet            less output`;

const VALUE = new Set(['faction', 'race', 'class', 'paths', 'workers', 'seed', 'draws', 'top', 'result', 'out', 'data', 'sim', 'fdj', 'guides', 'pack', 'to', 'band', 'jobs', 'anneal', 'max-paths', 'evals']);
const FLAGS = new Set(['rebuild', 'offline', 'quiet', 'help', 'dungeons', 'with-optional']);

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
		out[key] = v;
	}
	return out;
}

function common(args) {
	const o = {};
	if (args.data) o.dataDir = path.resolve(args.data);
	if (args.sim) o.simDir = path.resolve(args.sim);
	if (args.offline) o.offline = true;
	if (args.band) o.bandWidth = Number(args.band);
	o.log = args.quiet ? () => {} : (m) => console.error(m);
	return o;
}

function races(args, faction) {
	return args.race ? [args.race] : sim.START_RACES[faction];
}

function printRun(r) {
	console.log(`\n== ${r.faction} ${r.race} (${r.class}, ${r.family}) ==`);
	console.log(`evaluated routes ${r.evaluatedRoutes.toLocaleString('en-US')} in ${r.rounds} rounds, ${r.wallSeconds.toFixed(1)} s on ${r.workers} workers; ${r.msPerEval != null ? r.msPerEval.toFixed(3) : '?'} ms per route evaluation; converged: ${r.converged ? 'yes' : 'no'}`);
	console.log(`best: ${fmtH(r.best.seconds)} to 60 (${fmtHM(r.best.seconds)}); quests ${r.best.questsDone}; XP quest/kill/grind ${r.best.xpSplit.quest}/${r.best.xpSplit.kill}/${r.best.xpSplit.grind}; travel ${((100 * r.best.travelSeconds) / r.best.seconds).toFixed(1)}%; grinding ${fmtH(r.best.grindSeconds)}`);
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
		console.error(`unknown sim command "${cmd}"\n\n${usage}`);
		return 2;
	} catch (err) {
		console.error(err && err.stack ? err.stack : String(err));
		return 1;
	}
}

module.exports = { name: 'sim', summary: 'simulate and optimize leveling routes (docs/SIMULATION.md)', usage, run, parseArgs };
