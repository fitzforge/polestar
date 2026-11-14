#!/usr/bin/env node
'use strict';
// The flow audit and the route-feel gate (docs/ROUTE-FEEL.md): how a guide set's route feels to play, branch by
// branch (every start x class), and whether a candidate got worse than the guides that shipped.
//
//   node tools/flow-audit.js run --addon <dir> [options]          one audit: JSON (--out) and a report (--md)
//   node tools/flow-audit.js modes --addon <dir> --out-dir <dir>   every way to play: the default route, each route choice and
//                                                                   all of them; --with-dungeons adds dungeons in the route
//                                                                   (both styles), alone and with the route choices
//   node tools/flow-audit.js gate <before> <after> [--reasons F]   the gate: two audits, or two --out-dir folders
//
//   --addon DIR      the compiled guides: the folder holding Polestar_Guides* (and Polestar_Experimental for the route
//                    choices), as `forge guide compile --out <dir>/Polestar_Guides` writes them
//   --data DIR       reference data (default data/forever)
//   --faction F      Horde or Alliance (default both); --start, --class: comma lists to narrow the branches
//   --route LIST     route choices to take where a guide offers them (comma list: riverglades, shendralas, hyjal)
//   --dungeons D     "all" or dungeon map ids: the `when dungeon` steps of the dungeons the player runs (default none)
//   --dungeon-quests S  with --dungeons: all (default: every dungeon quest, the `when dungeon "X" all` steps too) or
//                    way (only the quests on the way)
//   --dynamic V      the While-here rules the player follows: 037 (default), 036, or off (the strict walk only)
//   --wh-take T      near (default: lines taken where nearly free, as players do) or all
//   --no-followups   an early hand-in's NPC's follow-ups are not taken there
//   --no-legs        straight lines instead of the baked legs (both sides of a gate must use the same)
//   --with-dungeons  modes: also every way with dungeons in the route (both sides of a gate must use the same)
//   --reasons FILE   the stated reasons for accepted regressions (default data/flow-gate.json)
// gate exits 1 when a check got worse without a reason, 0 otherwise.

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('./lib/cli');
const { ROOT, DATA } = require('./lib/paths');
const { loadCompiled } = require('./lib/flow/data');
const { runAudit, routeChoices, renderMd } = require('./lib/flow/audit');
const { compare, table, formatResult } = require('./lib/flow/gate');

const USAGE = `usage: node tools/flow-audit.js run --addon <dir> [--data DIR] [--faction F] [--start LIST] [--class LIST] [--route LIST]
                                [--dungeons all|IDS] [--dungeon-quests all|way] [--dynamic 037|036|off] [--wh-take near|all] [--no-followups] [--no-legs]
                                [--out FILE] [--md FILE]
       node tools/flow-audit.js modes --addon <dir> --out-dir <dir> [--faction F] [--with-dungeons] [the run options]
       node tools/flow-audit.js gate <before.json|dir> <after.json|dir> [--reasons FILE] [--json]`;

const listOf = (s) => (s ? String(s).split(',').map((x) => x.trim()).filter(Boolean) : []);

function auditOpts(opts) {
	const dynamic = opts.dynamic === 'off' ? null : opts.dynamic || '037';
	if (dynamic && !['036', '037'].includes(dynamic)) throw new Error(`--dynamic ${opts.dynamic}: 037, 036 or off`);
	if (opts.whTake && !['near', 'all'].includes(opts.whTake)) throw new Error(`--wh-take ${opts.whTake}: near or all`);
	if (opts.dungeonQuests && !['all', 'way'].includes(opts.dungeonQuests)) throw new Error(`--dungeon-quests ${opts.dungeonQuests}: all or way`);
	return {
		faction: opts.faction || '', starts: listOf(opts.start).map((s) => s.toLowerCase()), classes: listOf(opts.class).map((s) => s.toUpperCase()),
		guide: opts.guide || '', route: listOf(opts.route), dungeons: opts.dungeons || '', dungeonQuests: opts.dungeonQuests || 'all', dynamic, whTake: opts.whTake || 'near',
		followups: !opts.noFollowups, noLegs: Boolean(opts.noLegs),
	};
}

function writeJson(file, value) {
	fs.mkdirSync(path.dirname(path.resolve(file)), { recursive: true });
	fs.writeFileSync(file, JSON.stringify(value, null, 1) + '\n');
}

function run(opts) {
	const compiled = loadCompiled(path.resolve(opts.addon));
	const res = runAudit(compiled, path.resolve(opts.data || DATA), auditOpts(opts), (l) => console.error(l));
	if (opts.out) writeJson(opts.out, res);
	if (opts.md) fs.writeFileSync(opts.md, renderMd(res) + '\n');
	if (!opts.out && !opts.md) console.log(JSON.stringify(res));
	return 0;
}

// Every way to play a faction's route: the default route ("skip": dungeons off), each experimental route choice its
// guides offer and all of them together; with `dungeons`, also dungeons in the route with every dungeon quest ("run")
// or only the quests on the way ("run-way"), alone and with the route choices. -> [{ mode, route, dungeons, dungeonQuests }]
function modesOf(compiled, faction, { dungeons = false } = {}) {
	const routes = routeChoices(compiled, faction);
	const out = [{ mode: 'skip', route: [], dungeons: '', dungeonQuests: 'all' }];
	const ways = routes.map(([label, id]) => [label, [id]]);
	if (routes.length > 1) ways.push([routes.map(([label]) => label).join('+'), routes.map(([, id]) => id)]);
	for (const [label, route] of ways) out.push({ mode: label, route, dungeons: '', dungeonQuests: 'all' });
	if (!dungeons) return out;
	for (const [run, dungeonQuests] of [['run', 'all'], ['run-way', 'way']]) {
		out.push({ mode: run, route: [], dungeons: 'all', dungeonQuests });
		for (const [label, route] of ways) out.push({ mode: `${run}+${label}`, route, dungeons: 'all', dungeonQuests });
	}
	return out;
}

function modes(opts) {
	if (!opts.outDir) throw new Error('modes needs --out-dir');
	const compiled = loadCompiled(path.resolve(opts.addon));
	const dataDir = path.resolve(opts.data || DATA);
	const base = auditOpts(opts);
	for (const faction of opts.faction ? [opts.faction] : ['Alliance', 'Horde']) {
		for (const m of modesOf(compiled, faction, { dungeons: Boolean(opts.withDungeons) })) {
			const res = runAudit(compiled, dataDir, { ...base, faction, route: m.route, dungeons: m.dungeons, dungeonQuests: m.dungeonQuests });
			res.mode = m.mode;
			res.faction = faction;
			const file = path.join(opts.outDir, `${m.mode}-${faction}.json`);
			writeJson(file, res);
			console.error(`${m.mode} ${faction}: ${res.branches.length} branches -> ${file}`);
		}
	}
	return 0;
}

// The before/after pairs: two files, or the files two --out-dir folders share.
function pairs(before, after) {
	if (fs.statSync(before).isDirectory() !== fs.statSync(after).isDirectory()) throw new Error('gate: give two audit files or two folders');
	if (!fs.statSync(before).isDirectory()) return [[path.basename(after, '.json'), before, after]];
	const names = fs.readdirSync(after).filter((f) => f.endsWith('.json')).sort();
	const missing = names.filter((f) => !fs.existsSync(path.join(before, f)));
	if (missing.length) throw new Error(`gate: ${before} has no ${missing.join(', ')} (run modes on both trees with the same options)`);
	return names.map((f) => [path.basename(f, '.json'), path.join(before, f), path.join(after, f)]);
}

function gate(opts, positional) {
	if (positional.length !== 2) throw new Error('gate needs <before> <after>');
	const reasonsFile = path.resolve(opts.reasons || path.join(ROOT, 'data', 'flow-gate.json'));
	const reasons = fs.existsSync(reasonsFile) ? JSON.parse(fs.readFileSync(reasonsFile, 'utf8')).reasons || [] : [];
	let failed = 0;
	const results = [];
	for (const [label, b, a] of pairs(positional[0], positional[1])) {
		const before = JSON.parse(fs.readFileSync(b, 'utf8'));
		const after = JSON.parse(fs.readFileSync(a, 'utf8'));
		const cut = label.lastIndexOf('-');
		const [mode, faction] = before.mode ? [before.mode, before.faction] : [label.slice(0, cut), label.slice(cut + 1)];
		const res = compare(before, after, reasons, { mode, faction });
		failed += res.fail.length;
		results.push({ label, mode, faction, ...res, table: table(before, after, { dungeons: Boolean(after.dungeons) }) });
	}
	if (opts.json) {
		console.log(JSON.stringify(results, null, 1));
	} else {
		for (const r of results) {
			console.log(formatResult(r, r.label));
			if (opts.table) console.log(`\n${r.table}\n`);
		}
		console.log(failed ? `flow gate: ${failed} checks worse than before without a reason (data/flow-gate.json)` : 'flow gate: pass');
	}
	return failed ? 1 : 0;
}

function main(argv) {
	const [cmd, ...rest] = argv;
	const { opts, positional, error } = parseArgs(rest, {
		flags: ['--no-followups', '--no-legs', '--json', '--table', '--with-dungeons'],
		options: ['--addon', '--data', '--faction', '--start', '--class', '--guide', '--route', '--dungeons', '--dungeon-quests', '--dynamic', '--wh-take', '--out', '--md', '--out-dir', '--reasons'],
	});
	if (opts.help || error || !['run', 'modes', 'gate'].includes(cmd) || (cmd !== 'gate' && !opts.addon)) {
		console.error((error ? error + '\n' : '') + USAGE);
		return opts.help ? 0 : 2;
	}
	try {
		if (cmd === 'run') return run(opts);
		if (cmd === 'modes') return modes(opts);
		return gate(opts, positional);
	} catch (e) {
		console.error(`flow-audit: ${e.message}`);
		return 2;
	}
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = { main, modesOf, pairs };
