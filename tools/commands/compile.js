'use strict';
// compile: a guide pack's .guide files (with its pack.json) -> its addon
// folder: ours (guides/) -> addon/Polestar_Guides, another pack -> <pack>/dist/<folder>.

const path = require('node:path');
const { printDiagnostics, plural } = require('../lib/cli');
const { writePackDir } = require('../lib/dsl/project');
const { heightCounts } = require('../lib/dsl/heights');
const { placeCounts } = require('../lib/dsl/places');
const { ROOT, DATA } = require('../lib/paths');
const { packCommand, buildPack } = require('../lib/pack/build');

const usage = `usage: node tools/polestar.js compile [<dir>] [options]

Compiles a guide pack's .guide files (docs/GUIDE_FORMAT.md) into its addon
folder, as its pack.json describes it: the generated TOC, Pack.lua,
MapFrames.lua, Guides.lua and LICENSE-DATA.txt, plus the pack's LICENSE file
as LICENSE.txt when it has one. The pack is the one in <dir> (or
--pack), else the nearest folder holding a pack.json (this one or a parent),
else our guides/. Another pack is checked with our guides as context and
written to <pack>/dist/<folder>/; ours to addon/Polestar_Guides/. Nothing is
written when there are errors, nor without reference data (\`data build\`):
compile then stops with one error before reading any guide, unless --no-data
says to compile without it.

options:
  <dir>, --pack <dir>   the pack folder (holding pack.json)
  --guides <dir>        our pack's guide sources in another folder (default guides/)
  --data <dir>          reference data (default data/forever/)
  --context <dir>       our guides, read as context for another pack (default guides/)
  --context-data <dir>  reference data for the context (default data/forever/)
  --no-data             compile without reference data: every quest title,
                        NPC name and place must be given in the guide
  --out <dir>           pack folder (default addon/<folder>/ for ours,
                        <pack>/dist/<folder>/ for another pack)
  --include-drafts      also compile the pack's drafts/**
  --format <f>          diagnostics as text (default), json (one document on
                        stdout, no summary) or github (workflow annotations)
  --quiet               print errors only`;

async function run(argv) {
	const cmd = packCommand(argv, { name: 'compile', usage, flags: ['--include-drafts', '--quiet', '--no-data'], options: ['--pack', '--guides', '--data', '--context', '--context-data', '--out', '--format'] });
	if (cmd.exit !== undefined) return cmd.exit;
	const { opts, pack, out, dataDir, cache } = cmd;
	const summary = out.format !== 'json';
	const { manifest } = pack;
	const outDir = opts.out ? path.resolve(opts.out) : pack.official ? path.join(ROOT, 'addon', manifest.folder) : path.join(pack.dir, 'dist', manifest.folder);
	const { guides, diag, sources, files, data } = buildPack(pack, { dataDir, cache, includeDrafts: !!opts.includeDrafts });
	// Write before reporting: a failed write is one more error, so the JSON
	// document's `ok` matches the exit code.
	if (!diag.hasErrors()) {
		try {
			writePackDir(outDir, files);
		} catch (e) {
			diag.error(outDir, 0, e.message);
		}
	}
	printDiagnostics(diag, out);
	if (diag.hasErrors()) {
		if (summary) console.error(`compile failed: ${plural(diag.errors.length, 'error')}, ${plural(diag.warnings.length, 'warning')}`);
		return 1;
	}
	const steps = guides.reduce((n, g) => n + g.steps.length, 0);
	if (summary) {
		console.log(
			`compiled ${plural(guides.length, 'guide')} (${plural(steps, 'step')}) from ${plural(sources.length, 'file')} into ${outDir}; ${plural(diag.warnings.length, 'warning')}`,
		);
		// Place IDs (tools/lib/dsl/places.js): how many place goals got an area, getfp goals a taxi node.
		const p = placeCounts(guides);
		console.log(data && data.areas ? `areas: ${p.withArea} of ${plural(p.places, 'place goal')} got an area (AreaTable ${data.areas.build})` : 'areas: none (no cached Forever AreaTable in the sources beside the reference data; `data build` downloads it)');
		console.log(data && data.flightNodes().length ? `nodes: ${p.withNode} of ${plural(p.getfp, 'getfp goal')} got a taxi node (travel.json)` : 'nodes: none (no travel.json in the reference data; `travel build` writes it)');
		// Heights (tools/lib/dsl/heights.js): how many NPC and object goals, smart-target
		// candidates and those goals' spawn spots got z.
		const h = heightCounts(guides);
		console.log(
			data && data.spawnz
				? `heights: ${h.withZ} of ${plural(h.eligible, 'NPC or object goal')}, ${h.candidatesWithZ} of ${plural(h.candidates, 'smart-target candidate')} and ${h.spotsWithZ} of ${plural(h.spots, 'spawn spot')} got z (spawnz.json)`
				: 'heights: none (no spawnz.json in the reference data; `data build` writes it)',
		);
	}
	return 0;
}

module.exports = { name: 'compile', summary: 'Compile a guide pack into its addon folder', usage, run };
