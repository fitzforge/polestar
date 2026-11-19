'use strict';
// playtest: the guide simulator as a command (tools/lib/playtest.js).

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs, resolvePath, printDiagnostics, plural } = require('../lib/cli');
const { ROOT } = require('../lib/paths');
const { commandPack, packArgument } = require('../lib/pack/locate');
const { playtest, personaPlaytest, resultLines, CLASSES } = require('../lib/playtest');
const { PERSONAS } = require('../lib/playtest-personas');
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
  stuck joe/elwynn (Human Mage) at hand-over to forever/alliance/dwarf/01-dun-morogh: no Human can follow it
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

--persona plays our guides as imperfect players instead of the perfect
follower, one race and class per guide, each variant a play of its own:

  skip       skips one step (every step that gets an item a later hand-in
             needs, plus an even sample of the rest, --sample in all)
  lost       loses an item a direct hand-in or an item-started quest needs
  elsewhere  did one of the guide's quests before the guide offers it
  update     played the last release's guide (--from) to a point, then
             updated: the guide opens on that save and goes on from there
  fresh      opens a guide the route leads into with nothing from the guides
             before it (a character who starts the route there)

A play is stuck when the guide holds the player on a step they can never
complete. One line per stuck play, then a count per persona:

  stuck forever/alliance/human/01-elwynn-forest (Human Warrior) [lost: loses Thunder Applejack (247824) after getting it] at step 64 "Westbrook Garrison": goal 4 (turnin) stays active
  persona lost: 412 plays, 1 stuck

A guide stuck with nothing taken away is listed once as \`baseline\`.
Exit code 1 when any play is stuck.

options:
  --persona <list>      skip, lost, elsewhere, update, fresh (comma-separated)
                        or all
  --sample <n>          the most skip and elsewhere plays per guide (default 8)
  --points <n>          update: the points of each changed guide (default 3)
  --from <dir>          update: the last release's guides (its pack.json names
                        the version), e.g. from \`git archive v0.3.7.2 guides\`
  --honest              play from the lines and the data only (see above)
  --format text|json    json: one document with the counts and every finding
  --kb <file>           the knowledge base for R5 (default
                        data/local/kb/forever-kb.sqlite when present)
                        an explicitly named file must exist
  --filter <text>       play only the guides whose file or id contains it
  --class <c>           play only this class (e.g. Warrior), in every guide
  --group do|skip       the answer at every group quest (when group): skip
                        (the default, the solo route) or do (with a group)
  --dungeon <list>      play as a player who chose these dungeons in Options
                        (\`when dungeon\`): names or map ids, comma-separated
                        (\`--dungeon "The Deadmines,Wailing Caverns"\`), or all;
                        none by default (the solo route)
  --learn <list>        play as a player who chose these professions
                        (\`--learn Herbalism,"First Aid"\`): the guide's optional
                        \`train\` of each is taken, then the steps behind
                        \`when skill\` it opens are played; on its own the
                        simulator takes no optional goal, so it learns none
                        (a profession taught by an item is not taken)
  <dir>, --pack <dir>   the pack folder (holding pack.json)
  --guides <dir>        our pack's guide sources in another folder (default guides/)
  --data <dir>          reference data (default data/forever/)
  --context <dir>       our guides, loaded beside another pack (default guides/)
  --context-data <dir>  reference data for the context (default data/forever/)`;

// --dungeon: "all", or the names and map ids listed (null: none, the solo route).
function dungeonsArg(v) {
	if (!v) return null;
	return v.trim().toLowerCase() === 'all' ? 'all' : v.split(',').map((x) => x.trim()).filter(Boolean);
}

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, {
		flags: ['--honest'],
		options: ['--filter', '--class', '--group', '--dungeon', '--pack', '--guides', '--data', '--context', '--context-data', '--format', '--kb', '--learn', '--persona', '--sample', '--points', '--from'],
	});
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const cls = opts.class ? CLASSES.find((c) => c === opts.class.toUpperCase()) : null;
	const learn = opts.learn ? parseLearn(opts.learn) : null;
	const arg = error ? {} : packArgument(opts, positional);
	const problem =
		error ||
		arg.error ||
		(opts.class && !cls && `--class must be one of ${CLASSES.map((c) => c[0] + c.slice(1).toLowerCase()).join(', ')}`) ||
		(opts.group && opts.group !== 'do' && opts.group !== 'skip' && '--group must be do or skip') ||
		(opts.format && opts.format !== 'text' && opts.format !== 'json' && '--format must be text or json') ||
		(opts.format === 'json' && !opts.honest && '--format json needs --honest') ||
		(opts.kb && !opts.honest && '--kb needs --honest') ||
		(learn && learn.error) ||
		(learn && opts.honest && '--learn plays in the addon: it does not go with --honest');
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
	if (opts.persona) return runPersonas(opts, pack, cls);
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
		dungeons: dungeonsArg(opts.dungeon),
		dataDir: resolvePath(opts.data, 'data/forever', ROOT),
		...(pack.official ? {} : { contextDir: pack.contextDir, contextDataDir: pack.contextDataDir }),
		learn,
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

// --learn 'Herbalism,"First Aid"' -> [name], or { error }.
function parseLearn(text) {
	const out = text.split(',').map((s) => s.trim().replace(/^"(.*)"$/, '$1'));
	if (out.some((s) => !s)) return { error: `--learn takes profession names separated by commas, e.g. --learn Herbalism,Skinning (got "${text}")` };
	return out;
}

// playtest --honest: the findings as text (two lines each, then a count per
// rule) or one JSON document; 1 when any is a fail.
async function runHonest(opts, pack, cls) {
	const json = opts.format === 'json';
	const { findings, diag, played, plays, dataMissing } = await playtest({
		dir: pack.dir,
		manifest: pack.manifest,
		official: pack.official,
		filter: opts.filter || null,
		classes: cls ? [cls] : null,
		groups: opts.group || 'skip',
		dungeons: dungeonsArg(opts.dungeon),
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
	if (!plays) {
		console.error(`playtest --honest failed: nothing played: ${plural(played, 'guide')}, but no eligible characters${cls ? ` for ${cls[0] + cls.slice(1).toLowerCase()}` : ''}`);
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

// playtest --persona: a line per stuck play, a count per persona; 1 when any play is stuck.
async function runPersonas(opts, pack, cls) {
	const asked = opts.persona.trim().toLowerCase() === 'all' ? PERSONAS : opts.persona.split(',').map((p) => p.trim().toLowerCase());
	const bad = asked.find((p) => !PERSONAS.includes(p));
	const int = (v, d) => (v === undefined ? d : /^\d+$/.test(v) && Number(v) > 0 ? Number(v) : NaN);
	const sample = int(opts.sample, 8);
	const points = int(opts.points, 3);
	const problem =
		(bad && `--persona must be ${PERSONAS.join(', ')} or all (got "${bad}")`) ||
		(!pack.official && '--persona plays our guides only') ||
		(opts.honest && '--persona does not go with --honest') ||
		(Number.isNaN(sample) && '--sample must be a whole number of 1 or more') ||
		(Number.isNaN(points) && '--points must be a whole number of 1 or more') ||
		(asked.includes('update') && !opts.from && 'the update persona needs --from <the last release\'s guides>');
	if (problem) {
		console.error(`${problem}\n\n${usage}`);
		return 2;
	}
	let from = null;
	if (opts.from) {
		const dir = resolvePath(opts.from, opts.from, process.cwd());
		let version = null;
		try {
			version = JSON.parse(fs.readFileSync(path.join(dir, 'pack.json'), 'utf8')).version;
		} catch {
			version = null;
		}
		if (!version) {
			console.error(`--from ${opts.from}: no pack.json with a version there`);
			return 2;
		}
		from = { dir, version };
	}
	try {
		findLua();
	} catch (e) {
		console.error(`playtest failed: ${e.message} Run \`polestar doctor\` for the install steps.`);
		return 1;
	}
	const counts = new Map([['baseline', { plays: 0, stuck: 0 }], ...asked.map((p) => [p, { plays: 0, stuck: 0 }])]);
	const { results, diag, played, dataMissing } = await personaPlaytest({
		dir: pack.dir,
		manifest: pack.manifest,
		personas: asked,
		filter: opts.filter || null,
		classes: cls ? [cls] : null,
		sample,
		points,
		from,
		dataDir: resolvePath(opts.data, 'data/forever', ROOT),
		onResult: (r) => {
			const c = counts.get(r.persona);
			c.plays++;
			if (!r.stuck) return;
			c.stuck++;
			const s = r.stuck;
			console.log(`stuck ${r.guide} (${personaWho(r)}) [${r.persona}: ${r.variant}]${s.step != null ? ` at step ${s.step}` : ''}${s.title != null ? ` "${s.title}"` : ''}: ${s.reason}`);
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
	let stuck = 0;
	for (const [p, c] of counts) {
		if (p === 'baseline' && !c.stuck) continue;
		console.log(`persona ${p}: ${plural(c.plays, 'play')}, ${c.stuck} stuck`);
		stuck += c.stuck;
	}
	const summary = `${plural(played, 'guide')}, ${plural(results.length, 'play')}: ${stuck} stuck`;
	if (stuck) console.error(`playtest --persona failed: ${summary}`);
	else console.log(`playtest --persona ok: ${summary}`);
	return stuck ? 1 : 0;
}

const personaWho = (r) => `${r.race === 'Scourge' ? 'Undead' : r.race === 'NightElf' ? 'Night Elf' : r.race} ${r.cls.charAt(0)}${r.cls.slice(1).toLowerCase()}`;

module.exports = { name: 'playtest', summary: "Play a pack's guides to the end for every class", usage, run };
