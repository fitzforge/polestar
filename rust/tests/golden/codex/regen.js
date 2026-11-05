#!/usr/bin/env node
// Writes the codex golden with the JavaScript `codex build --offline` (release build; not run in CI):
//   node regen.js <JS checkout> [<out dir>]
// buildCodex as `codex build --offline` calls it, with the inputs the test gives the Rust build:
// - data: the world slice's data/forever plus the professions golden's professions.json (one folder);
// - sources: input/sources (client table slices; no web quest database cache);
// - guides: the guide golden's slice (../guide/slice/forever);
// - addons: the gear golden's synthetic MIT ForeverLevelingBiS (../gear/input/AddOns);
// - data/codex/*.json: the checkout's own (input/root/data/codex holds copies for the Rust);
// - version 0.2.6, no pack memory measure (lua5.1), no parity build to compare with.
// expected/: codex/*.json, Polestar_Codex/*, warnings.txt; files over 64 KiB gzipped (<name>.gz).
'use strict';
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const [jsArg, outArg] = process.argv.slice(2);
if (!jsArg) throw new Error('usage: node regen.js <JS checkout> [<out dir>]');
const js = path.resolve(jsArg);
const here = __dirname;
const out = path.resolve(outArg || path.join(here, 'expected'));
const { buildCodex } = require(path.join(js, 'tools/lib/codex/build.js'));

const tmp = fs.mkdtempSync(path.join(os.tmpdir(), 'codex-golden-'));
const data = path.join(tmp, 'data');
fs.cpSync(path.join(here, '../world/root/data/forever'), data, { recursive: true });
fs.copyFileSync(path.join(here, '../professions/expected/professions.json'), path.join(data, 'professions.json'));
const guides = path.join(tmp, 'guides');
fs.cpSync(path.join(here, '../guide/slice/forever'), path.join(guides, 'forever'), { recursive: true });
for (const f of fs.readdirSync(path.join(here, 'input/root/data/codex'))) {
	if (fs.readFileSync(path.join(here, 'input/root/data/codex', f), 'utf8') !== fs.readFileSync(path.join(js, 'data/codex', f), 'utf8')) throw new Error(`input/root/data/codex/${f} differs from the checkout's`);
}

(async () => {
	fs.rmSync(out, { recursive: true, force: true });
	process.chdir(tmp);
	const res = await buildCodex({
		addons: path.join(here, '../gear/input/AddOns'),
		offline: true,
		dataDir: data,
		sourcesDir: path.join(here, 'input/sources'),
		guidesDir: guides,
		outDir: path.join(out, 'codex'),
		packDir: path.join(out, 'Polestar_Codex'),
		measure: false,
		version: '0.2.6',
		parityAgainst: path.join(tmp, 'no-extras'),
		log: (m) => console.error(m),
	});
	fs.writeFileSync(path.join(out, 'warnings.txt'), res.warnings.map((w) => `warning: ${w}\n`).join(''));
	fs.rmSync(tmp, { recursive: true, force: true });
	const zlib = require('node:zlib');
	for (const d of ['codex', 'Polestar_Codex']) {
		for (const f of fs.readdirSync(path.join(out, d))) {
			const p = path.join(out, d, f);
			const b = fs.readFileSync(p);
			if (b.length <= 64 * 1024) continue;
			fs.writeFileSync(`${p}.gz`, zlib.gzipSync(b, { level: 9 }));
			fs.rmSync(p);
		}
	}
})();
