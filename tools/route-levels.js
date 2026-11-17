#!/usr/bin/env node
'use strict';
// Refreshes data/route-levels.json, the levels the route brings a player to each leveling guide, from a level model
// run on the release candidate (tools/lib/route-levels.js; tests/route-levels.test.js checks every leveling guide's
// `levels` header against it). Keeps the file's `_about` and its `keep` rows.
//
//   node tools/route-levels.js --levels <Alliance.json>,<Horde.json> [--out FILE]
//     --levels FILES   the calibrated level model's output per faction (the same runs the danger gate reads)
//     --out FILE       the snapshot to rewrite (default data/route-levels.json)
// Prints every guide whose arrival or exit moved by half a level or more.

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('./lib/cli');
const { ROOT } = require('./lib/paths');
const { FACTIONS, summarize } = require('./lib/route-levels');

function main(argv) {
	const { opts, error } = parseArgs(argv, { options: ['--levels', '--out'] });
	if (opts.help || error || !opts.levels) {
		console.error((error ? error + '\n' : '') + 'usage: node tools/route-levels.js --levels <Alliance.json>,<Horde.json> [--out FILE]');
		return opts.help ? 0 : 2;
	}
	const out = path.resolve(opts.out || path.join(ROOT, 'data', 'route-levels.json'));
	const old = JSON.parse(fs.readFileSync(out, 'utf8'));
	const routes = summarize(opts.levels.split(',').map((f) => path.resolve(f)));
	for (const f of FACTIONS) {
		for (const [id, [a, e]] of Object.entries(routes[f])) {
			const was = (old.routes[f] || {})[id];
			if (!was) console.log(`${f} ${id}: new, ${a} -> ${e}`);
			else if (Math.abs(was[0] - a) >= 0.5 || Math.abs(was[1] - e) >= 0.5) console.log(`${f} ${id}: ${was[0]} -> ${was[1]} is now ${a} -> ${e}`);
		}
		for (const id of Object.keys(old.routes[f] || {})) if (!routes[f][id]) console.log(`${f} ${id}: gone`);
	}
	// Tab-indented like the other data files, each [arrival, exit] (and kept [min, max]) on its guide's line.
	const text = JSON.stringify({ _about: old._about, keep: old.keep, routes }, null, '\t').replace(/\[\n\t+([\d.]+),\n\t+([\d.]+)\n\t+\]/g, '[$1, $2]') + '\n';
	fs.writeFileSync(out, text);
	console.log(`route levels: ${FACTIONS.map((f) => `${Object.keys(routes[f]).length} ${f}`).join(', ')} guides written to ${path.relative(ROOT, out)}`);
	return 0;
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = { main };
