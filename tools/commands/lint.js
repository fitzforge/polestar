'use strict';
// lint: every compile check, no writes; plus the solo policy for leveling
// guides against the simulator's cached worlds (data/sim, when built).

const fs = require('node:fs');
const { resolvePath, printDiagnostics, plural } = require('../lib/cli');
const { ROOT, SOURCES } = require('../lib/paths');
const { validateSoloPolicy } = require('../lib/dsl/validate');
const { packCommand, buildPack } = require('../lib/pack/build');
const { worldFile, dataHash } = require('../lib/sim/world');

const usage = `usage: node tools/polestar.js lint [<dir>] [options]

Runs every compile check (syntax, data lookups, cross-guide validation) on a
pack without writing anything: the pack in <dir> (or --pack), else the nearest
folder holding a pack.json (this one or a parent), else our guides/. Exit
code 1 on errors. Another pack is checked with our guides as context (its
\`next\` and turn-ins see our chains; their own diagnostics are not shown).
When the simulator has cached a world (\`sim\`), also warns on leveling goals
its solo filter excludes. Without reference data (\`data build\`) lint stops
with one error before reading any guide, unless --no-data says to check
without it.

options:
  <dir>, --pack <dir>   the pack folder (holding pack.json)
  --guides <dir>        our pack's guide sources in another folder (default guides/)
  --data <dir>          reference data (default data/forever/)
  --context <dir>       our guides, read as context for another pack (default guides/)
  --context-data <dir>  reference data for the context (default data/forever/)
  --no-data             check without reference data: every quest title, NPC
                        name and place must be given in the guide
  --sim <dir>           simulator cache with world-<faction>.json (default
                        data/sim/, used only with the default --data)
  --include-drafts      also check the pack's drafts/**
  --format <f>          text (default), json (one document on stdout, no
                        summary) or github (workflow annotations)
  --quiet               print errors only`;

// Faction -> Map(quest id -> world.excluded entry) from the cached worlds in
// simDir; a faction without one is not checked, nor one whose cache was
// built from other data or by an older world builder (its exclusions may
// be wrong, e.g. friendly talk credit flagged elite before builder 16):
// -> { excluded, stale: [faction] }.
function soloExclusions(simDir, dataDir) {
	const excluded = {};
	const stale = [];
	if (!simDir) return { excluded, stale };
	const hash = dataHash(dataDir, SOURCES);
	for (const faction of ['Alliance', 'Horde']) {
		const file = worldFile(simDir, faction);
		if (!fs.existsSync(file)) continue;
		const w = JSON.parse(fs.readFileSync(file, 'utf8'));
		if (w.dataHash !== hash) {
			stale.push(faction);
			continue;
		}
		if (Array.isArray(w.excluded)) excluded[faction] = new Map(w.excluded.map((e) => [e.id, e]));
	}
	return { excluded, stale };
}

async function run(argv) {
	const cmd = packCommand(argv, { name: 'lint', usage, flags: ['--include-drafts', '--quiet', '--no-data'], options: ['--pack', '--guides', '--data', '--context', '--context-data', '--sim', '--format'] });
	if (cmd.exit !== undefined) return cmd.exit;
	const { opts, pack, out, dataDir, cache } = cmd;
	const { guides, diag, sources } = buildPack(pack, { dataDir, cache, includeDrafts: !!opts.includeDrafts, files: false });
	// The default cache was built from the default data; other data needs its own --sim.
	const simDir = opts.noData ? null : opts.sim || !opts.data ? resolvePath(opts.sim, 'data/sim', ROOT) : null;
	const { excluded, stale } = soloExclusions(simDir, dataDir);
	validateSoloPolicy(guides, excluded, diag);
	printDiagnostics(diag, out);
	// Another pack: the simulator's world is ours to rebuild, not the pack author's.
	if (stale.length && pack.official) console.error(`note: solo-filter checks skipped for ${stale.join(' and ')}: the simulator's cached world is from other data or an older builder (\`node tools/polestar.js sim world\` rebuilds it)`);
	const summary = `${plural(sources.length, 'file')}, ${plural(guides.length, 'guide')}: ${plural(diag.errors.length, 'error')}, ${plural(diag.warnings.length, 'warning')}`;
	if (out.format !== 'json') {
		if (diag.hasErrors()) console.error(`lint failed: ${summary}`);
		else console.log(`lint ok: ${summary}`);
	}
	return diag.hasErrors() ? 1 : 0;
}

module.exports = { name: 'lint', summary: 'Check .guide files without writing output', usage, run, soloExclusions };
