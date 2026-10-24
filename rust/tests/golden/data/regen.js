#!/usr/bin/env node
// Writes the data-build golden's expected outputs with the JavaScript `data build` (not run in CI):
//   node regen.js <JS checkout> [<out dir>]
// Inputs: ./input (pfQuest slice, wago CSV slices, the CMaNGOS spawnz.json cache, recordings).
// Release pipeline (no knowledge base), no QuestieDB, no web XP, no web zone lists, offline.
// The input folder's absolute path (in meta.json's warnings) is written as `<input>`.
'use strict';
const fs = require('node:fs');
const path = require('node:path');

const [js, outArg] = process.argv.slice(2);
if (!js) throw new Error('usage: regen.js <JS checkout> [<out dir>]');
const here = __dirname;
const input = path.join(here, 'input');
const outDir = path.resolve(outArg || path.join(here, 'expected'));
const { buildData } = require(path.join(path.resolve(js), 'tools/lib/data/build'));
buildData({
	root: input,
	sourcesDir: path.join(input, 'sources'),
	pfquestDir: path.join(input, 'pfQuest'),
	recordingsDir: path.join(input, 'recordings'),
	outDir,
	offline: true,
	questieDir: null,
	forever: true,
	webXp: false,
	webZones: false,
	builtAt: '2026-10-22T00:00:00.000Z',
	log: (m) => console.error(m),
})
	.then(({ meta }) => {
		for (const w of meta.warnings) console.error(`warning: ${w}`);
		for (const f of fs.readdirSync(outDir)) {
			const file = path.join(outDir, f);
			fs.writeFileSync(file, fs.readFileSync(file, 'utf8').split(input).join('<input>'));
		}
	})
	.catch((e) => {
		console.error(e);
		process.exit(1);
	});
