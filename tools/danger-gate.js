#!/usr/bin/env node
'use strict';
// The danger-at-the-spot release gate (#1575): every leveling guide's kill/collect/use goals against the hostile mobs
// around them and the route's level there (tools/lib/danger.js has the rules), compared with the reviewed baseline in
// data/danger-baseline.json. A flag the baseline lacks fails the gate, so a route rebuild or a guide edit that sends
// players among mobs well above them, elites or a high camp is caught before it ships.
//
//   node tools/danger-gate.js --levels <Alliance.json>,<Horde.json> [options]
//     --levels FILES       the calibrated level model's output per faction (the release audit's level run on the
//                          release candidate): the route's level at each step comes from it
//     --baseline FILE      the reviewed flags (default data/danger-baseline.json)
//     --data DIR           reference data (default data/forever); --guides DIR (default guides)
//     --recordings FILE    a recordings index (the maintainer's local rec index: deaths, objective ticks, abandons):
//                          each new flag is printed with what players' recordings show at that goal
//     --archive DIR        the recordings archive (the session files): the Recorder's census settles which npcs are a
//                          threat to each side (tools/lib/danger.js, "Who is a threat"), and the npcs it settles
//                          otherwise than the data around the goals are listed. Without it every npc of no side in
//                          the data counts as hostile; the release candidate's gate runs with it
//     --out FILE           write every current flag (JSON)
//     --json               print the result as JSON
// Exit 0: no new flag past GATE_MARGIN (borderline ones and baseline rows that no longer flag are listed); 1: new
// flags. A new flag is reviewed like the baseline's: fixed in the guide (a tip, a level hold, a better point) or
// added to the baseline with its reason and evidence.

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('./lib/cli');
const { ROOT, DATA } = require('./lib/paths');
const { levelsOf, sweep, compare, GATE_MARGIN, CENSUS_MIN } = require('./lib/danger');
const { Geo } = require('./lib/planner/geo.js');

function evidence(rec, flag, geo) {
	if (!rec) return null;
	const w = (map, x, y, f) => {
		const p = geo.toWorld(map, x, y, f === 'e' ? 'e' : 'l');
		return p ? { c: p.c, x: p.wx ?? p[0], y: p.wy ?? p[1] } : null;
	};
	const at = w(flag.at.map, flag.at.x, flag.at.y, flag.at.f);
	const deaths = at ? rec.deaths.filter((d) => {
		if (d.map == null || d.x == null) return false;
		const p = w(d.map, d.x, d.y, 'l');
		return p && p.c === at.c && Math.hypot(p.x - at.x, p.y - at.y) <= 60;
	}) : [];
	const ticks = flag.quest && flag.oi ? rec.ticks[`${flag.quest}.${flag.oi}`] || [] : [];
	const lv = ticks.map((t) => t[1]).filter((v) => v != null).sort((a, b) => a - b);
	return {
		deathPeople: new Set(deaths.map((d) => d.person)).size,
		donePeople: new Set(ticks.map((t) => t[0])).size,
		doneMedian: lv.length ? lv[Math.floor(lv.length / 2)] : null,
		abandons: flag.quest ? new Set((rec.abandons[flag.quest] || []).map((a) => a[0])).size : 0,
	};
}

function main(argv) {
	const { opts, error } = parseArgs(argv, { flags: ['--json'], options: ['--levels', '--baseline', '--data', '--guides', '--recordings', '--archive', '--out'] });
	if (opts.help || error || !opts.levels) {
		console.error((error ? error + '\n' : '') + 'usage: node tools/danger-gate.js --levels <Alliance.json>,<Horde.json> [--baseline FILE] [--data DIR] [--guides DIR] [--recordings FILE] [--archive DIR] [--out FILE] [--json]');
		return opts.help ? 0 : 2;
	}
	const dataDir = path.resolve(opts.data || DATA);
	const guidesDir = path.resolve(opts.guides || path.join(ROOT, 'guides'));
	const baseline = JSON.parse(fs.readFileSync(path.resolve(opts.baseline || path.join(ROOT, 'data', 'danger-baseline.json')), 'utf8')).flags;
	const { flags, census } = sweep({ dataDir, guidesDir, levels: levelsOf(opts.levels.split(',').map((f) => path.resolve(f))), archive: opts.archive ? path.resolve(opts.archive) : null });
	if (opts.out) fs.writeFileSync(path.resolve(opts.out), JSON.stringify(flags, null, 1) + '\n');
	const result = compare(flags, baseline);
	const rec = opts.recordings ? JSON.parse(fs.readFileSync(path.resolve(opts.recordings), 'utf8')) : null;
	const geo = new Geo(JSON.parse(fs.readFileSync(path.join(dataDir, 'map-frames.json'), 'utf8')), JSON.parse(fs.readFileSync(path.join(dataDir, 'zones.json'), 'utf8')));
	for (const f of [...result.fail, ...result.borderline]) f.recordings = evidence(rec, f, geo);
	if (opts.json) {
		console.log(JSON.stringify({ flags: flags.length, baseline: baseline.length, census, ...result }, null, 1));
	} else {
		const line = (f) => `  ${f.guide} step ${f.step} "${f.title}": ${f.goal} ${f.kind} (+${f.margin}) at level ${f.level}: ${f.mobs.join(', ')}` +
			(f.recordings ? ` | recordings: done by ${f.recordings.donePeople} (median ${f.recordings.doneMedian}), deaths ${f.recordings.deathPeople}, abandons ${f.recordings.abandons}` : '');
		console.log(`danger gate: ${flags.length} flags, ${baseline.length} in the baseline`);
		if (census) {
			const npc = (s) => `${s.name} ${s.level} (${s.side}, ${s.people})`;
			const group = (why) => census.cleared.filter((s) => s.why === why).map(npc).join(', ');
			console.log(`census of ${census.sessions} sessions: npcs around the goals it settles otherwise than the data (side, people)`);
			console.log(`  no threat, met as friendly and never as hostile: ${group('met friendly') || 'none'}`);
			console.log(`  not there, never met though ${CENSUS_MIN}+ people's census ran by their spawns: ${group('never met') || 'none'}`);
			console.log(`  a threat, met as hostile or killing one though the data has them friendly: ${census.added.map(npc).join(', ') || 'none'}`);
		}
		if (result.fail.length) console.log(`NEW (${result.fail.length}): fix the guide or review into data/danger-baseline.json\n${result.fail.map(line).join('\n')}`);
		if (result.borderline.length) console.log(`borderline, under +${GATE_MARGIN} (${result.borderline.length}): not failing\n${result.borderline.map(line).join('\n')}`);
		if (result.stale.length) console.log(`baseline rows no longer flagged (${result.stale.length}): drop them at the next review\n${result.stale.map((r) => `  ${r.key}`).join('\n')}`);
		console.log(result.fail.length ? 'danger gate: FAIL' : 'danger gate: pass');
	}
	return result.fail.length ? 1 : 0;
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = { main };
