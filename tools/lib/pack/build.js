'use strict';
// The one build path for every command that lints or builds a guide pack
// (compile, lint, play, dev, install, pack): which pack (a folder argument
// or `--pack`, else the nearest pack.json, else our guides), compiled with
// our guides as context when it is another pack, and where its folder may go.

const fs = require('node:fs');
const path = require('node:path');
const { Diagnostics } = require('../dsl/diag');
const { parseArgs, resolvePath, printDiagnostics, formatError, plural } = require('../cli');
const { compileProject, buildPackFiles } = require('../dsl/project');
const { packTranslations } = require('../i18n/guides');
const { ROOT, DATA } = require('../paths');
const { hasCoreData, emptyData, CORE_FILES } = require('../dsl/data');
const { commandPack, packArgument } = require('./locate');
const { FOLDER_RE, LICENSE_PLACEHOLDER } = require('./format');

// The options every pack-building command takes (parseArgs `options`).
const PACK_OPTIONS = ['--pack', '--data', '--context', '--context-data'];

const PACK_USAGE = `  <dir>, --pack <dir>   the pack folder, holding pack.json (default: the nearest pack.json)
  --data <dir>          reference data (default data/forever/)
  --context <dir>       our guides, read as context (default guides/)
  --context-data <dir>  reference data for the context (default data/forever/)`;

// The other pack a command works on: the folder argument (`positional`) or
// `--pack`, else the nearest pack.json. -> null when that is our own guides
// (the command's usual mode), else commandPack's result ({ dir, manifest,
// diags, contextDir, contextDataDir }), or { error } for a usage error (two
// pack folders, one without pack.json, a --context folder that does not
// exist): callers print it with their usage and exit 2.
function otherPack(opts, positional = [], cwd = process.cwd()) {
	const arg = packArgument(opts, positional, cwd);
	if (arg.error) return { error: arg.error };
	const pack = commandPack({ pack: arg.pack, context: opts.context, contextData: opts.contextData }, cwd);
	return pack.official ? null : pack;
}

// compile and lint: parse argv (`spec`: parseArgs flags/options, --format
// checked), find the pack (packArgument, commandPack) and its reference data.
// -> { exit } when the command is done (help 0, usage error 2, invalid
// pack.json or no reference data 1: the diagnostics printed), else
// { opts, pack, out, dataDir, cache } with out = printDiagnostics' options and
// cache buildPack's (empty data with `--no-data`, else null).
function packCommand(argv, { name, usage, flags, options }) {
	const { opts, positional, error } = parseArgs(argv, { flags, options });
	if (opts.help) {
		console.log(usage);
		return { exit: 0 };
	}
	const arg = error ? {} : packArgument(opts, positional);
	const usageError = error || arg.error || formatError(opts.format) || noDataConflict(opts);
	const pack = usageError ? null : commandPack({ ...opts, pack: arg.pack });
	if (!pack || pack.error) {
		console.error(`${usageError || pack.error}\n\n${usage}`);
		return { exit: 2 };
	}
	const out = { quiet: !!opts.quiet, format: opts.format || 'text' };
	if (!pack.manifest) {
		printDiagnostics(pack.diags, out);
		if (out.format !== 'json') console.error(`${name} failed: ${plural(pack.diags.filter((d) => d.severity === 'error').length, 'error')} in pack.json`);
		return { exit: 1 };
	}
	const dataDir = resolvePath(opts.data, 'data/forever', ROOT);
	if (opts.noData) return { opts, pack, out, dataDir, cache: noDataCache() };
	const missing = noReferenceData(pack, dataDir, true);
	if (missing) {
		printDiagnostics(missing, out);
		if (out.format !== 'json') console.error(`${name} failed: no reference data`);
		return { exit: 1 };
	}
	return { opts, pack, out, dataDir, cache: null };
}

// --no-data next to an option naming data (parseArgs' opts) -> the usage error, or null.
function noDataConflict(opts) {
	if (!opts.noData) return null;
	const named = [['--data', opts.data], ['--context-data', opts.contextData], ['--sim', opts.sim]].find(([, value]) => value !== undefined);
	return named ? `--no-data and ${named[0]} cannot be used together` : null;
}

// buildPack's cache for --no-data: empty reference data for the pack and its context.
function noDataCache() {
	return { data: emptyData(), contextData: emptyData(), diags: [] };
}

// dir relative to the working directory when inside it, else absolute.
function shownPath(dir) {
	const shown = path.relative(process.cwd(), dir);
	return shown.startsWith('..') || path.isAbsolute(shown) ? dir : shown.split(path.sep).join('/') || '.';
}

// Without any core file in dataDir every quest, NPC and place lookup fails:
// -> Diagnostics holding the one error that says so (instead of an error on
// every line of every guide), or null when there is data. The hint names
// --context-data when another pack's context data is missing too, and
// --no-data when the command takes it (`flag`).
function noReferenceData(pack, dataDir, flag) {
	if (hasCoreData(dataDir)) return null;
	const what = fs.existsSync(dataDir) ? `the folder holds none of ${CORE_FILES.join(', ')}` : 'the folder does not exist';
	const context = pack.contextDataDir && !hasCoreData(pack.contextDataDir) ? ', and --context-data <dir> for our guides read as context' : '';
	const diag = new Diagnostics();
	diag.error(
		shownPath(dataDir),
		0,
		`no reference data: ${what}, so no quest, NPC or place can be looked up`,
		`run \`node tools/polestar.js data build\`, or pass --data <dir>${context}${flag ? '; --no-data checks guides that give every quest title, name and place themselves' : ''}`,
	);
	return diag;
}

// The pack's LICENSE file (its text, or null without one), with a warning in
// diag while it still holds the placeholder line `new` writes.
function readLicense(pack, diag) {
	const file = path.join(pack.dir, 'LICENSE');
	let text;
	try {
		text = fs.readFileSync(file, 'utf8');
	} catch {
		return null;
	}
	const at = text.split(/\r?\n/).findIndex((l) => l.includes(LICENSE_PLACEHOLDER));
	if (at >= 0) {
		const shown = path.relative(process.cwd(), file);
		diag.warn(
			shown.startsWith('..') ? file : shown.split(path.sep).join('/'),
			at + 1,
			'LICENSE still holds the placeholder line `polestar new` writes, not the licence text',
			`replace the line with the full text of the ${pack.manifest.license} licence: the built addon ships LICENSE as LICENSE.txt`,
		);
	}
	return text;
}

// Lint and build a pack (commandPack's result) in memory. `cache` ({ data,
// contextData, diags }) skips reloading the reference data on a rebuild;
// `diags` are the warnings loading it gave (project.js loadProjectData),
// reported with every build. Without a cache and without reference data in
// dataDir no guide is read: the result holds noReferenceData's one error
// (its hint names --no-data when `noDataFlag`, the command taking it) and
// `noData` true. `files: false` only lints. The pack folder's LICENSE, when
// it has one, goes into the addon folder as LICENSE.txt.
// -> { ok, diag, manifest, guides, sources, data, files, noData }: files
// (folder name -> content) only when there are no errors.
function buildPack(pack, { dataDir = DATA, cache = null, includeDrafts = false, files = true, noDataFlag = false } = {}) {
	if (!pack.manifest) {
		const diag = new Diagnostics();
		diag.list.push(...pack.diags);
		return { ok: false, diag, manifest: null, guides: [], sources: [], data: null, files: null, noData: false };
	}
	const missing = cache && cache.data ? null : noReferenceData(pack, dataDir, noDataFlag);
	if (missing) {
		missing.list.push(...pack.diags);
		return { ok: false, diag: missing, manifest: pack.manifest, guides: [], sources: [], data: null, files: null, noData: true };
	}
	const r = compileProject({
		packDir: pack.dir,
		manifest: pack.manifest,
		dataDir,
		includeDrafts,
		data: cache && cache.data,
		contextDir: pack.contextDir,
		contextData: cache && cache.contextData,
		contextDataDir: pack.contextDataDir,
	});
	r.diag.list.push(...pack.diags, ...((cache && cache.diags) || []));
	const license = readLicense(pack, r.diag);
	// The pack's translations (<pack>/locales/<locale>/, docs/TRANSLATING.md
	// "Guide texts"): a file Lua cannot load, a broken or stale translation and
	// an orphan file are warnings; the English shows for each.
	let translations = {};
	if (!r.diag.hasErrors()) {
		const got = packTranslations(pack.dir, pack.manifest, r.guides);
		translations = got.translations;
		for (const w of got.warnings) r.diag.warn(w.file, 0, w.message);
	}
	const ok = !r.diag.hasErrors();
	return {
		ok,
		diag: r.diag,
		manifest: pack.manifest,
		guides: r.guides,
		sources: r.sources,
		data: r.data,
		files: ok && files ? buildPackFiles({ guides: r.guides, manifest: pack.manifest, data: r.data, license, translations }) : null,
		tokens: r.tokens,
		noData: false,
	};
}

// <parent>/<folder>, refusing a folder that is not a plain name: a manifest's
// `folder` never reaches a path that leaves `parent` (manifest.js validates
// it; this is the last guard before anything is written).
function folderIn(parent, folder) {
	if (typeof folder !== 'string' || !FOLDER_RE.test(folder)) throw new Error(`refusing the pack folder ${JSON.stringify(folder)}: not a plain folder name`);
	return path.join(parent, folder);
}

module.exports = { PACK_OPTIONS, PACK_USAGE, otherPack, packCommand, noDataConflict, noDataCache, noReferenceData, buildPack, folderIn };
