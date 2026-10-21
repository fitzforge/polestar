'use strict';
// playtest: the guide simulator as a command (tools/lib/playtest.js).

const { parseArgs, resolvePath, printDiagnostics, plural } = require('../lib/cli');
const { ROOT } = require('../lib/paths');
const { commandPack, packArgument } = require('../lib/pack/locate');
const { playtest, resultLines, CLASSES } = require('../lib/playtest');
const { findLua } = require('../lib/lua');

const usage = `usage: node tools/polestar.js playtest [<dir>] [options]

Plays a pack's guides to the end in the real addon against a simulated
world (needs Lua 5.1; \`doctor\` checks): each guide once per class it
branches on (\`only\`) plus one class it never names, as each race that can
reach it. The pack is the one in <dir> (or --pack), else the nearest folder
holding a pack.json, else our guides/. Another pack plays with our guides
loaded too: a guide whose \`next\` names one of ours must land on it with
something to do, and the guide it lands on must apply to the character (its
race, class and faction). --filter plays only the guides whose file or id
contains its text.
One line per guide, race and class (only pairs that exist in the game):

  ok  joe/elwynn (Human Warrior)
  stuck joe/elwynn (Human Paladin) at step 3 "Kobolds": goal 1 (kill "Kobold Vermin") stays active
  stuck joe/elwynn (Human Mage) at hand-over to forever/alliance/02-westfall: <why>
  stuck joe/elwynn (Human Mage) at hand-over to forever/alliance/dwarf-gnome/01-dun-morogh: no Human can follow it
  fail joe/elwynn (Human Warrior): no location for step 2 goal 1: accept 33

Exit code 1 when any guide is stuck or fails, nothing was played, or the
pack does not compile.

options:
  --filter <text>       play only the guides whose file or id contains it
  --class <c>           play only this class (e.g. Warrior), in every guide
  --group do|skip       the answer at every group quest (when group): skip
                        (the default, the solo route) or do (with a group)
  <dir>, --pack <dir>   the pack folder (holding pack.json)
  --data <dir>          reference data (default data/forever/)
  --context <dir>       our guides, loaded beside another pack (default guides/)
  --context-data <dir>  reference data for the context (default data/forever/)`;

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { options: ['--filter', '--class', '--group', '--pack', '--data', '--context', '--context-data'] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const cls = opts.class ? CLASSES.find((c) => c === opts.class.toUpperCase()) : null;
	const arg = error ? {} : packArgument(opts, positional);
	const problem =
		error ||
		arg.error ||
		(opts.class && !cls && `--class must be one of ${CLASSES.map((c) => c[0] + c.slice(1).toLowerCase()).join(', ')}`) ||
		(opts.group && opts.group !== 'do' && opts.group !== 'skip' && '--group must be do or skip');
	const pack = problem ? null : commandPack({ ...opts, pack: arg.pack });
	if (!pack || pack.error) {
		console.error(`${problem || pack.error}\n\n${usage}`);
		return 2;
	}
	if (!pack.manifest) {
		printDiagnostics(pack.diags);
		console.error(`playtest failed: ${plural(pack.diags.filter((d) => d.severity === 'error').length, 'error')} in pack.json`);
		return 1;
	}
	try {
		findLua();
	} catch (e) {
		console.error(`playtest failed: ${e.message} Run \`polestar doctor\` for the install steps.`);
		return 1;
	}
	let stuck = 0;
	let failed = 0;
	const { results, diag, played, dataMissing } = playtest({
		dir: pack.dir,
		manifest: pack.manifest,
		official: pack.official,
		filter: opts.filter || null,
		classes: cls ? [cls] : null,
		groups: opts.group || 'skip',
		dataDir: resolvePath(opts.data, 'data/forever', ROOT),
		...(pack.official ? {} : { contextDir: pack.contextDir, contextDataDir: pack.contextDataDir }),
		onResult: (r) => {
			if (r.stuck) stuck++;
			else if (!r.ok) failed++;
			for (const line of resultLines(r)) console.log(line);
		},
	});
	if (diag.hasErrors()) {
		printDiagnostics(diag, { quiet: true });
		console.error(dataMissing ? 'playtest failed: no reference data to play against' : `playtest failed: ${plural(diag.errors.length, 'error')}; \`lint\` shows the warnings too`);
		return 1;
	}
	if (!played) {
		console.error(opts.filter ? `no guide matches "${opts.filter}"` : 'no guides in the pack');
		return 1;
	}
	if (!results.length) {
		console.error(`playtest failed: nothing played: ${plural(played, 'guide')}, but no race can play ${cls ? `a ${cls[0] + cls.slice(1).toLowerCase()}` : 'them'}`);
		return 1;
	}
	const summary = `${plural(played, 'guide')}, ${plural(results.length, 'play')}: ${stuck} stuck, ${failed} failed`;
	if (stuck || failed) console.error(`playtest failed: ${summary}`);
	else console.log(`playtest ok: ${summary}`);
	return stuck || failed ? 1 : 0;
}

module.exports = { name: 'playtest', summary: "Play a pack's guides to the end for every class", usage, run };
