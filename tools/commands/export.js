'use strict';
// export: one guide of a community pack as an import string
// (tools/lib/pack/importstring.js), printed on stdout. Lints the guide's
// pack first and refuses a guide with errors.

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs, resolvePath, printDiagnostics, plural } = require('../lib/cli');
const { ROOT } = require('../lib/paths');
const { commandPack, findPackDir } = require('../lib/pack/locate');
const { buildPack, noReferenceData } = require('../lib/pack/build');
const { importString, LIMITS } = require('../lib/pack/importstring');

const usage = `usage: node tools/polestar.js export <file.guide> [options]

Prints the import string of the one guide in <file.guide>: a line of text a
player pastes into Polestar's Import page (/polestar import) to get the
guide without installing anything (docs/GUIDE_PACKS.md, "Import strings").
The guide belongs to a community pack: the nearest folder above the file
holding a pack.json, whose id is the guide id's prefix and whose license the
string carries. The pack is linted first, with our guides as context, and a
guide with errors is refused. A string holds one guide of at most
${LIMITS.steps} steps and ${LIMITS.length} characters; anything bigger, or a
set of guides, is a community addon (\`forge release pack\`).

The string goes to stdout, everything else to stderr, so
\`polestar export my.guide > my.txt\` keeps only the string.

options:
  --data <dir>          reference data (default data/forever/)
  --context <dir>       our guides, read as context (default guides/)
  --context-data <dir>  reference data for the context (default data/forever/)
  --quiet               print errors only`;

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { flags: ['--quiet'], options: ['--data', '--context', '--context-data'] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const usageError = error || (positional.length !== 1 ? 'name one .guide file' : !positional[0].endsWith('.guide') ? `${positional[0]} is not a .guide file` : null);
	if (usageError) {
		console.error(`${usageError}\n\n${usage}`);
		return 2;
	}
	const file = path.resolve(positional[0]);
	if (!fs.existsSync(file) || !fs.statSync(file).isFile()) {
		console.error(`export failed: no file ${positional[0]}`);
		return 1;
	}
	const packDir = findPackDir(path.dirname(file));
	if (!packDir) {
		console.error(`export failed: ${positional[0]} is in no pack: no pack.json in its folder or above (\`polestar new\` makes one)`);
		return 1;
	}
	const pack = commandPack({ pack: packDir, context: opts.context, contextData: opts.contextData });
	if (pack.error) {
		console.error(`${pack.error}\n\n${usage}`);
		return 2;
	}
	const out = { quiet: !!opts.quiet, format: 'text' };
	if (!pack.manifest) {
		printDiagnostics(pack.diags, out);
		console.error('export failed: pack.json has errors');
		return 1;
	}
	if (pack.official) {
		console.error("export failed: that is one of Polestar's own guides, which ship with Polestar; an import string carries a community pack's guide");
		return 1;
	}
	const dataDir = resolvePath(opts.data, 'data/forever', ROOT);
	const missing = noReferenceData(pack, dataDir, false);
	if (missing) {
		printDiagnostics(missing, out);
		console.error('export failed: no reference data');
		return 1;
	}
	const { guides, diag, data } = buildPack(pack, { dataDir, files: false });
	const rel = path.relative(pack.dir, file).split(path.sep).join('/');
	const mine = guides.filter((g) => g._ast && g._ast.source === rel);
	// Only this file's diagnostics: another guide's errors do not stop it.
	const own = diag.sorted().filter((d) => d.file && path.resolve(d.file) === file);
	printDiagnostics(own, out);
	const errors = own.filter((d) => d.severity === 'error').length;
	if (errors) {
		console.error(`export failed: lint found ${plural(errors, 'error')} in ${positional[0]}`);
		return 1;
	}
	if (mine.length !== 1) {
		console.error(
			mine.length
				? `export failed: ${positional[0]} holds ${mine.length} guides; an import string carries one (put each guide in its own file, or ship them together as a community addon: forge release pack)`
				: `export failed: no guide compiled from ${positional[0]} (a file under the pack's drafts/ or dist/ is not part of it)`,
		);
		return 1;
	}
	const guide = mine[0];
	const r = importString(guide, { manifest: pack.manifest, data });
	if (r.error) {
		console.error(`export failed: ${r.error}`);
		return 1;
	}
	// `next` and route choices reach Polestar's guides or guides imported
	// before this one (Core/Import.lua): say which must come first.
	const ahead = [guide.next, ...(guide.nextChoices || [])].filter((id) => id && !String(id).startsWith('forever/'));
	if (ahead.length && !opts.quiet) console.error(`note: ${guide.id} leads on to ${ahead.join(', ')}: players import ${ahead.length === 1 ? 'that guide' : 'those guides'} first`);
	console.log(r.text);
	if (!opts.quiet) console.error(`exported ${guide.id}: ${plural(r.steps, 'step')}, ${r.text.length} characters`);
	return 0;
}

module.exports = { name: 'export', summary: 'Print the import string of one guide', usage, run };
