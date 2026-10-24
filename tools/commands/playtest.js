'use strict';
// playtest: the guide simulator as a command (tools/lib/playtest.js).

const { parseArgs, resolvePath, printDiagnostics, plural } = require('../lib/cli');
const { ROOT } = require('../lib/paths');
const { commandPack, packArgument } = require('../lib/pack/locate');
const { playtest, resultLines, CLASSES } = require('../lib/playtest');
const { findingLines } = require('../lib/playtest-honest');
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

--honest plays the guides from their lines and the reference data only,
with nothing free (no Lua needed): each \`next\` chain whole from its first
guide, carrying the quest log, the bags, the flight paths and the hearth.
Each line a player could not follow is a finding:

  R1  travel: another continent needs a travel line (hearth, a boat,
      zeppelin or portal goto, a deathskip), another zone one (goto, fly...)
      unless it is a step over the border; fly needs both flight paths
      learnt, hearth the inn bound
  R2  accept: the giver stands at the step's place; an item-started quest
      needs the item in the bags from an earlier line
  R3  items: a collect needs a source in the data near its place; quest items
      drop only while their quest is held (unflagged: a warning); use needs
      the item
  R4  NPCs: an accept's or turn-in's NPC gives or takes the quest; a step
      titled with an NPC has a goal at it; a quest with several givers and no
      npc resolves to the one near the player
  R5  turn-in: the quest is in the log and every objective was credited by an
      earlier line; with data/local/kb/forever-kb.sqlite, each required step
      (use an item, combine, summon, escort, buy, loot an object) has a line

  R3 fail forever/x/01.guide:704 (Human Warrior) step 52 "Murlocs": collect Murloc Eye at Elwynn Forest 47,85: nothing there drops it
    repair: place the goal at a camp that drops it (\`collect 730 nearest\`)

Exit code 1 when any finding is a fail (warnings do not fail).

options:
  --honest              play from the lines and the data only (see above)
  --format text|json    json: one document with the counts and every finding
  --kb <file>           the knowledge base for R5 (default
                        data/local/kb/forever-kb.sqlite when present)
  --filter <text>       play only the guides whose file or id contains it
  --class <c>           play only this class (e.g. Warrior), in every guide
  --group do|skip       the answer at every group quest (when group): skip
                        (the default, the solo route) or do (with a group)
  <dir>, --pack <dir>   the pack folder (holding pack.json)
  --guides <dir>        our pack's guide sources in another folder (default guides/)
  --data <dir>          reference data (default data/forever/)
  --context <dir>       our guides, loaded beside another pack (default guides/)
  --context-data <dir>  reference data for the context (default data/forever/)`;

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { flags: ['--honest'], options: ['--filter', '--class', '--group', '--pack', '--guides', '--data', '--context', '--context-data', '--format', '--kb'] });
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
		(opts.group && opts.group !== 'do' && opts.group !== 'skip' && '--group must be do or skip') ||
		(opts.format && opts.format !== 'text' && opts.format !== 'json' && '--format must be text or json') ||
		(opts.format === 'json' && !opts.honest && '--format json needs --honest') ||
		(opts.kb && !opts.honest && '--kb needs --honest');
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
	if (opts.honest) return runHonest(opts, pack, cls);
	try {
		findLua();
	} catch (e) {
		console.error(`playtest failed: ${e.message} Run \`polestar doctor\` for the install steps.`);
		return 1;
	}
	let stuck = 0;
	let failed = 0;
	const { results, diag, played, dataMissing } = await playtest({
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

// playtest --honest: the findings as text (two lines each, then a count per
// rule) or one JSON document; 1 when any is a fail.
async function runHonest(opts, pack, cls) {
	const json = opts.format === 'json';
	const { findings, diag, played, dataMissing } = await playtest({
		dir: pack.dir,
		manifest: pack.manifest,
		official: pack.official,
		filter: opts.filter || null,
		classes: cls ? [cls] : null,
		groups: opts.group || 'skip',
		dataDir: resolvePath(opts.data, 'data/forever', ROOT),
		...(pack.official ? {} : { contextDir: pack.contextDir, contextDataDir: pack.contextDataDir }),
		honest: true,
		...(opts.kb ? { kb: resolvePath(opts.kb, opts.kb, process.cwd()) } : {}),
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
	const counts = {};
	for (const rule of ['R1', 'R2', 'R3', 'R4', 'R5']) counts[rule] = { fail: 0, warn: 0 };
	for (const f of findings) counts[f.rule][f.severity]++;
	const fails = findings.filter((f) => f.severity === 'fail').length;
	if (json) {
		console.log(JSON.stringify({ ok: !fails, played, fails, warnings: findings.length - fails, counts, findings }, null, 2));
		return fails ? 1 : 0;
	}
	for (const f of findings) for (const line of findingLines(f)) console.log(line);
	const per = Object.entries(counts).map(([r, c]) => `${r} ${c.fail}${c.warn ? `+${c.warn}w` : ''}`).join(', ');
	const summary = `${plural(played, 'guide')}: ${plural(fails, 'fail')}, ${plural(findings.length - fails, 'warning')} (${per})`;
	if (fails) console.error(`playtest --honest failed: ${summary}`);
	else console.log(`playtest --honest ok: ${summary}`);
	return fails ? 1 : 0;
}

module.exports = { name: 'playtest', summary: "Play a pack's guides to the end for every class", usage, run };
