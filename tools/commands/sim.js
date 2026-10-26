'use strict';
// `polestar sim compare`: score a leveling chain against Polestar's under the
// earlier JS route model (docs/legacy/SIMULATION-js.md). Every other `sim`
// subcommand was retired for Forge; each prints its replacement.

const path = require('node:path');
const { objectiveName, parseOverrides, tagName } = require('../lib/sim/params');

const RETIRED = {
	world: 'forge walks world <root> <grid> <simDir> <faction> (e.g. forge walks world . data/local/nav4 data/sim horde), or forge build',
	walks: 'forge walks walks <root> <grid> <simDir> <faction> <store> <navFp> [bands] (e.g. forge walks walks . data/local/nav4 data/sim horde data/sim/store-horde.psbn forge-walks-1), or forge build; --report and --parity: removed, no replacement',
	calibrate: 'forge sim calibrate [--root R] [--world-dir D] [--fdj DIR] [--recordings DIR] [--out FILE]',
	run: 'forge sim route --faction F --start <race> --out <json> (routes are made by forge build; not a port of the v1 search)',
	robust: 'forge sim route ... --search-draws K --holdout N (the nearest thing; not a port)',
	bench: 'removed, no replacement',
	export: 'removed, no replacement (forge writer apply-route <route.json> --world <world-faction.json> --out DIR writes a route into the guides, not skeletons)',
	consensus: 'forge sim widen --faction F --starts A,B,... --out <json> or forge sim shared --faction F --out <json> (other algorithms)',
	route: 'forge sim route --faction F --start <race> --out <json>; the whole pipeline is forge build',
	guides: 'forge build (guides stage), or forge writer apply-route <route.json> --world <world-faction.json> --out DIR',
	cases: "removed, no CLI replacement (forge-judge's cases.rs is checked by cargo test -p forge-judge)",
	audit: 'removed, no replacement (forge judge <pack dir> --faction F --race R reports passed-by quests and avoidable returns)',
	zoneplan: 'removed, no replacement',
	search: "removed, no replacement (forge sim route/forge sim shared run Forge's own search)",
	cas: 'removed, no replacement (Forge keeps its stage cache in <out>/.forge)',
	tune: 'removed, no replacement',
	shrink: 'removed, no replacement',
	bisect: 'removed, no replacement',
	serve: 'removed, no replacement',
	ask: 'removed, no replacement',
};

const usage = `usage: node tools/polestar.js sim compare [options]

  sim compare --faction F [--race R] [--class C] [--guides DIR] [--pack DIR | DIR] [--to 10,20,30] [--with-optional]
              [--objective O]   Polestar's routes vs a pack's chain (and earlier best-found results), same model

Without --race, compare covers every start of the faction (Horde: Orc, Tauren,
Undead, Skyborne; Alliance: Human, Dwarf, NightElf, Skyborne). Class defaults
to none ("any"); with --class the class's quests and kill-speed prior are used.

options:
  --data <dir>       reference data (default data/forever)
  --sim <dir>        sim world and walks (default data/sim; forge walks world / forge walks walks)
  --band <levels>    level width of the world's quest packages (default 5)
  --guides <dir>     Polestar guides folder to score (default guides/), e.g. an old copy
  --pack <dir>       also score this pack's chain (or name the pack folder as the one
                     argument; default: the nearest pack.json); written to
                     data/bench/compare-<faction>-<race>-<pack id>.json
  --to <levels>      levels to show time to (default 10,20,30,40,50,60)
  --with-optional    also score the guides' optional goals (default: only what a guide requires)
  --objective <o>    time, smooth or smooth2 (default time)
  --param <k=v>      set a model parameter (params.js); repeatable
  --tag <name>       a result file variant
  --no-walks         walk the straight line × detour even when data/sim/walks-<faction>.bin is there
  --offline          never download the QuestXP table
  --quiet            less output

Retired (each prints its replacement and exits 2):
${Object.entries(RETIRED).map(([k, v]) => `  sim ${k}: ${v}`).join('\n')}`;

const VALUE = new Set(['faction', 'race', 'class', 'guides', 'pack', 'to', 'objective', 'param', 'tag', 'data', 'sim', 'band']);
const REPEAT = new Set(['param']);
const FLAGS = new Set(['offline', 'quiet', 'help', 'with-optional', 'no-walks']);

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
	if (args['no-walks']) o.walks = false;
	o.log = args.quiet ? () => {} : (m) => console.error(m);
	return o;
}

async function run(argv) {
	const sub = argv[0];
	if (Object.hasOwn(RETIRED, sub)) {
		console.error(`polestar sim ${sub} was retired: ${RETIRED[sub]}`);
		return 2;
	}
	let args;
	try {
		args = parseArgs(argv);
		if (args.objective) objectiveName(args.objective);
		parseOverrides(args.param);
		tagName(args.tag);
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
		if (cmd === 'compare') return await require('../lib/sim/compare').compareCommand(args, o);
		console.error(`unknown sim command "${cmd}"\n\n${usage}`);
		return 2;
	} catch (err) {
		console.error(err && err.stack ? err.stack : String(err));
		return 1;
	}
}

module.exports = { name: 'sim', summary: "score a leveling chain against Polestar's under the route model (sim compare)", usage, run, parseArgs };
