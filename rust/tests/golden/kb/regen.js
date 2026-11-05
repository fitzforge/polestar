#!/usr/bin/env node
// Writes the knowledge-base golden with the JavaScript `data build` + knowledge base (sim-v2 pipeline, m2a's
// tools/lib/data; not run in CI):
//   node regen.js <JS tree: a copy of the m2a checkout's tools/ (and tests/helpers/)> [<out dir>]
// The scratch root (the layout the Rust test builds too):
//   data/sources    ../data/input/sources + input/sources + ../extracts/expected (as cmangos/22b51464f162)
//   data/recordings ../data/input/recordings;  pfQuest: ../data/input/pfQuest
//   data/local      input/local (synthetic mechanics layers; no facts.sqlite, no TDB database)
//   data/sim        input/sim (synthetic world quest lists)
//   out/trainers.json  ../trainers/expected/trainers.json
//   tools/          the JS tree's tools/, with ../data/input/data/corrections.json where the m2a JS reads it
// cwd: the root. Offline, no QuestieDB, no web XP, no web zone lists, builtAt 2026-10-22T00:00:00.000Z.
// expected/: the data files (root path written as `<root>`), verify-in-game.json and kb-rows.txt (every row
// of the KB sqlite: `<table>\t<JSON array of the row>`, tables in creation order, rows by rowid).
'use strict';
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const [jsArg, outArg] = process.argv.slice(2);
if (!jsArg) throw new Error('usage: node regen.js <JS tree> [<out dir>]');
const here = __dirname;
const out = path.resolve(outArg || path.join(here, 'expected'));
const data = path.join(here, '../data/input');

const root = fs.mkdtempSync(path.join(os.tmpdir(), 'kb-golden-'));
const cp = (a, b) => fs.cpSync(a, b, { recursive: true });
cp(path.join(path.resolve(jsArg), 'tools'), path.join(root, 'tools'));
if (fs.existsSync(path.join(path.resolve(jsArg), 'tests/helpers'))) cp(path.join(path.resolve(jsArg), 'tests/helpers'), path.join(root, 'tests/helpers'));
cp(path.join(data, 'data/corrections.json'), path.join(root, 'tools/lib/data/corrections.json'));
cp(path.join(data, 'sources'), path.join(root, 'data/sources'));
cp(path.join(here, 'input/sources'), path.join(root, 'data/sources'));
// The CMaNGOS caches of the data slice: the extracts golden's (spawnz.2.json, training.json, ...).
cp(path.join(here, '../extracts/expected'), path.join(root, 'data/sources/cmangos/22b51464f162'));
cp(path.join(data, 'recordings'), path.join(root, 'data/recordings'));
cp(path.join(here, 'input/local'), path.join(root, 'data/local'));
cp(path.join(here, 'input/sim'), path.join(root, 'data/sim'));
const outDir = path.join(root, 'out');
cp(path.join(here, '../trainers/expected/trainers.json'), path.join(outDir, 'trainers.json'));

const { buildData } = require(path.join(root, 'tools/lib/data/build'));
const trainersIn = fs.readFileSync(path.join(outDir, 'trainers.json'), 'utf8');
process.chdir(root);
(async () => {
	const { meta } = await buildData({
		root,
		sourcesDir: path.join(root, 'data/sources'),
		pfquestDir: path.join(data, 'pfQuest'),
		recordingsDir: path.join(root, 'data/recordings'),
		outDir,
		offline: true,
		questieDir: null,
		forever: true,
		webXp: false,
		webZones: false,
		kb: true,
		builtAt: '2026-10-22T00:00:00.000Z',
		log: (m) => console.error(m),
	});
	for (const w of meta.warnings) console.error(`warning: ${w}`);
	fs.rmSync(out, { recursive: true, force: true });
	fs.mkdirSync(out, { recursive: true });
	const unroot = (t) => t.split(root).join('<root>').split(data).join('<data>');
	for (const f of fs.readdirSync(outDir)) {
		const text = fs.readFileSync(path.join(outDir, f), 'utf8');
		// trainers.json is written only when the knowledge base changed it.
		if (f === 'trainers.json' && text === trainersIn) continue;
		fs.writeFileSync(path.join(out, f), unroot(text));
	}
	const kb = path.join(root, 'data/local/kb');
	fs.writeFileSync(path.join(out, 'verify-in-game.json'), unroot(fs.readFileSync(path.join(kb, 'verify-in-game.json'), 'utf8')));
	const { DatabaseSync } = require('node:sqlite');
	const db = new DatabaseSync(path.join(kb, 'forever-kb.sqlite'), { readOnly: true });
	const lines = [];
	for (const { name } of db.prepare("select name from sqlite_master where type = 'table' order by rowid").all()) {
		for (const row of db.prepare(`select * from "${name}" order by rowid`).all()) lines.push(`${name}\t${JSON.stringify(Object.values(row))}`);
	}
	db.close();
	fs.writeFileSync(path.join(out, 'kb-rows.txt'), `${lines.join('\n')}\n`);
	// Large files gzipped (<name>.gz).
	const zlib = require('node:zlib');
	for (const f of fs.readdirSync(out)) {
		const p = path.join(out, f);
		const b = fs.readFileSync(p);
		if (b.length <= 64 * 1024) continue;
		fs.writeFileSync(`${p}.gz`, zlib.gzipSync(b, { level: 9 }));
		fs.rmSync(p);
	}
	fs.rmSync(root, { recursive: true, force: true });
})().catch((e) => {
	console.error(e);
	process.exit(1);
});
