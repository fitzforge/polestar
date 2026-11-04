#!/usr/bin/env node
// Writes the CMaNGOS extracts golden with the JavaScript extractors (not run in CI):
//   node regen.js <next JS checkout (v1 seed)> <sim-v2 JS checkout> [<out dir>]
// Input: ./input/sources/cmangos/22b51464f162/classicdb.sql.gz (slice.js's cut of the pinned dump).
// next: spawnz.json, quest_counts.json; sim-v2: spawnz.2.json, training.json,
// gameobject_facts.json, graveyards.json, escort_paths.json; each serialized as its loader caches it.
'use strict';
const fs = require('node:fs');
const path = require('node:path');
const readline = require('node:readline');
const zlib = require('node:zlib');

const [nextJs, simJs, outArg] = process.argv.slice(2);
if (!nextJs || !simJs) throw new Error('usage: regen.js <next JS checkout> <sim-v2 JS checkout> [<out dir>]');
const dump = path.join(__dirname, 'input/sources/cmangos/22b51464f162/classicdb.sql.gz');
const out = path.resolve(outArg || path.join(__dirname, 'expected'));
const next = require(path.join(path.resolve(nextJs), 'tools/lib/travel/cmangos'));
const sim = require(path.join(path.resolve(simJs), 'tools/lib/travel/cmangos'));
const lines = () => readline.createInterface({ input: fs.createReadStream(dump).pipe(zlib.createGunzip()), crlfDelay: Infinity });
const compact = (d) => `${JSON.stringify(d)}\n`;
const tabbed = (d) => `${JSON.stringify(d, null, '\t')}\n`;
const jobs = [
	['spawnz.json', next.extractSpawnHeights, next.serializeSpawnHeights],
	['quest_counts.json', next.extractQuestCounts, compact],
	['spawnz.2.json', sim.extractSpawnHeights, sim.serializeSpawnHeights],
	['training.json', sim.extractTraining, tabbed],
	['gameobject_facts.json', sim.extractObjectFacts, compact],
	['graveyards.json', sim.extractGraveyards, compact],
	['escort_paths.json', sim.extractEscortPaths, compact],
];
(async () => {
	fs.mkdirSync(out, { recursive: true });
	for (const [name, extract, write] of jobs) fs.writeFileSync(path.join(out, name), write(await extract(lines())));
})().catch((e) => {
	console.error(e);
	process.exit(1);
});
