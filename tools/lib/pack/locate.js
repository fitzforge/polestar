'use strict';
// Which pack a command works on: the folder named on the command line (one
// argument, or `--pack <dir>`), else the nearest folder holding a pack.json
// (the working directory or a parent), else our own guides. Every
// pack-aware command calls packArgument, then resolvePack.

const fs = require('node:fs');
const path = require('node:path');
const { OFFICIAL_DIR } = require('../dsl/project');
const { ROOT, DATA } = require('../paths');
const { OWN_EXTRAS } = require('./format');
const { readManifest } = require('./manifest');

// The nearest folder holding pack.json, from startDir up to the filesystem root; null when none.
function findPackDir(startDir) {
	let dir = path.resolve(startDir);
	for (;;) {
		if (fs.existsSync(path.join(dir, 'pack.json'))) return dir;
		const up = path.dirname(dir);
		if (up === dir) return null;
		dir = up;
	}
}

function samePath(a, b) {
	const real = (p) => {
		try {
			return fs.realpathSync(p);
		} catch {
			return path.resolve(p);
		}
	};
	return real(a) === real(b);
}

// One of Polestar's own extra packs (format.js OWN_EXTRAS: experimental/
// beside guides/) when dir is its folder in this checkout, else null: read as
// another pack's, it may give the id reserved for it.
function ownExtra(dir) {
	return OWN_EXTRAS.find((e) => samePath(dir, path.join(ROOT, e.source))) || null;
}

// -> { dir, manifest, official, diags }: manifest is null when pack.json is
// missing or invalid (diags say why). `official` is true for our guides/.
function resolvePack({ pack, cwd = process.cwd() } = {}) {
	const dir = pack ? path.resolve(cwd, pack) : findPackDir(cwd) || OFFICIAL_DIR;
	const official = samePath(dir, OFFICIAL_DIR);
	const { manifest, diags } = readManifest(dir, { official, extra: official ? null : ownExtra(dir) });
	return { dir, manifest, official, diags };
}

// The pack folder named on the command line: one positional argument or
// `--pack <dir>`, not both, and it must hold pack.json. -> { pack } (pack is
// undefined when none was named), or { error } for the usage error.
function packArgument(opts, positional, cwd = process.cwd()) {
	if (positional.length > 1) return { error: `one pack folder only, got ${positional.length}: ${positional.map((p) => `"${p}"`).join(' ')}` };
	if (positional.length && opts.pack) return { error: `the pack folder is named twice ("${positional[0]}" and --pack ${opts.pack}); give it once` };
	const pack = positional.length ? positional[0] : opts.pack;
	if (pack !== undefined && !fs.existsSync(path.join(path.resolve(cwd, pack), 'pack.json'))) return { error: `no pack.json in ${pack}` };
	return { pack };
}

// --context / --context-data given as folders that do not exist -> the usage
// error, else null (a typo must not silently drop the context).
function contextError(opts, cwd = process.cwd()) {
	for (const [flag, value] of [['--context', opts.context], ['--context-data', opts.contextData]]) {
		if (!value) continue;
		let dir = false;
		try {
			dir = fs.statSync(path.resolve(cwd, value)).isDirectory();
		} catch {
			dir = false;
		}
		if (!dir) return `${flag} ${value} is not a folder`;
	}
	return null;
}

// compile and lint: what to build or check.
// --guides <dir>: our pack (guides/pack.json) with its sources in another folder.
// Else resolvePack; another pack reads our guides (--context, default
// guides/) as context, with our data (--context-data, default data/forever/).
// -> { dir, manifest, official, diags, contextDir, contextDataDir, error }
function commandPack(opts, cwd = process.cwd()) {
	if (opts.guides && opts.pack) return { error: '--guides and a pack folder cannot be used together' };
	const ctxError = contextError(opts, cwd);
	if (ctxError) return { error: ctxError };
	if (opts.guides) {
		const { manifest, diags } = readManifest(OFFICIAL_DIR, { official: true });
		return { dir: path.resolve(cwd, opts.guides), manifest, official: true, diags, contextDir: null, contextDataDir: null, error: null };
	}
	const r = resolvePack({ pack: opts.pack, cwd });
	if (r.official) return { ...r, contextDir: null, contextDataDir: null, error: null };
	return {
		...r,
		contextDir: opts.context ? path.resolve(cwd, opts.context) : OFFICIAL_DIR,
		contextDataDir: opts.contextData ? path.resolve(cwd, opts.contextData) : DATA,
		error: null,
	};
}

module.exports = { findPackDir, ownExtra, resolvePack, packArgument, commandPack, contextError };
