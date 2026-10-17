'use strict';
// pack: release archives. In the repository: dist/Polestar-<version>.zip
// (Polestar, Polestar_Guides, Polestar_Nav and the built data addons) and
// dist/Polestar_Recorder-<version>.zip, each with the GPL in its first folder
// (and the player's README.txt in Polestar/), plus dist/SHA256SUMS for both.
// Given another pack (a folder argument, --pack, or the nearest pack.json):
// <pack>/dist/<folder>-<version>.zip holding the built pack folder.

const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const { parseArgs, resolvePath, printDiagnostics, plural } = require('../lib/cli');
const project = require('../lib/dsl/project');
const { commandPack, packArgument } = require('../lib/pack/locate');
const { PACK_OPTIONS, PACK_USAGE, otherPack, noDataConflict, noDataCache, buildPack, folderIn } = require('../lib/pack/build');
const { writeZip, directoryEntries } = require('../lib/zip');
const { ROOT, DATA } = require('../lib/paths');
const { releaseRefusal, ADDON: CODEX } = require('../lib/codex/pack');

const usage = `usage: node tools/polestar.js pack [<dir>] [options]

In the repository: compiles our guides, then writes dist/Polestar-<version>.zip
(Polestar, Polestar_Guides, Polestar_Nav, Polestar_Codex, the names addons
Polestar_Names_<locale>, and Polestar_QuestDB / Polestar_ItemDB when built),
dist/Polestar_Recorder-<version>.zip and
dist/SHA256SUMS. Polestar/ in the zip also carries LICENSE and README.txt
(install steps), Polestar_Recorder/ the LICENSE. The Codex must be built
first (\`codex build\`) from release-safe inputs: pack stops on a missing
Codex or a --local-extras one.

Given another guide pack (<dir>, --pack, or run inside one): lints and builds it with our
guides as context, then writes <pack>/dist/<folder>-<version>.zip holding its
addon folder, the version taken from pack.json. Both are byte for byte
reproducible. Without reference data (\`data build\`) pack stops with one
error; a guide pack can be built without it with --no-data.

options:
${PACK_USAGE}
  --guides <dir>        our guide sources (default guides/; not with a pack folder)
  --addons <dir>        addon source folder (default addon/)
  --dist <dir>          output folder (default dist/, <pack>/dist/ for a pack)
  --no-data             a guide pack only: build it without reference data
                        (every quest title, NPC name and place given in the guide)`;

// Our guides (in dirs.guides) built in memory; null (reported) on errors.
function compile(ours, dirs) {
	// pack.json's diagnostics are printed already.
	const built = buildPack({ ...ours, diags: [] }, { dataDir: dirs.data });
	printDiagnostics(built.diag, { quiet: true });
	if (!built.ok) {
		console.error(`pack failed: ${built.noData ? 'no reference data' : `${plural(built.diag.errors.length, 'error')} in guides (run lint for details)`}`);
		return null;
	}
	return built;
}

function tocVersion(dir, name) {
	try {
		const m = /^## Version:\s*(\S+)/m.exec(fs.readFileSync(path.join(dir, `${name}.toc`), 'utf8'));
		return m ? m[1] : null;
	} catch {
		return null;
	}
}

// Install steps for players, Polestar/README.txt in the zip. CRLF so Notepad
// shows it as written.
function readme(version, names) {
	return [
		`Polestar ${version}`,
		'Leveling guides for World of Warcraft: Forever.',
		'',
		'Install',
		'1. Copy these folders from the zip into',
		'   World of Warcraft/_forever_/Interface/AddOns/',
		'   (_classic_beta_ instead of _forever_ on the beta client):',
		...names.map((n) => `     ${n}`),
		'   They are all part of Polestar: Polestar_Codex holds what Lookup,',
		'   Dungeons and Rares show; Polestar_Nav the arrow\'s walking routes',
		'   (Shortest Path Forever\'s pathing, by Cillian Berragan, GPL-3.0 or',
		'   later: see its LICENSE and CREDITS.md); the Polestar_Names_ folders',
		'   the game\'s quest, NPC, object and item names in each language (the',
		'   game loads only its own). To update, delete the old Polestar folders',
		'   there first.',
		'2. Quit the game completely and start it again. A /reload does not',
		'   load new addon folders.',
		'',
		'Polestar_Recorder (a separate zip) is optional: it records your sessions',
		'to improve the routes and stays off until you turn it on.',
		'',
		'Source, issues and documentation: https://github.com/fitzforge/polestar',
		'Polestar is free software under the GNU General Public License, version 3',
		'only (LICENSE). The data folders carry their own notices (LICENSE-DATA.txt).',
		'Portions Copyright (C) 2026 Cillian Berragan (Shortest Path Forever),',
		'GPL-3.0 or later, adapted with his permission: the route lines, journey',
		'panel, transit times, travel prompts and alerts in Polestar/ (LICENSE',
		'names the files) and the walking routes in Polestar_Nav/.',
		'',
	].join('\r\n');
}

// Zip entries for the addon folders, with `extras` ({ folder: [{ name, data }] })
// placed right after their folder's own entry.
function archiveEntries(addonsDir, names, extras) {
	const entries = [];
	for (const n of names) {
		const [dir, ...rest] = directoryEntries([path.join(addonsDir, n)]);
		const added = (extras[n] || []).map((e) => ({ name: `${n}/${e.name}`, data: e.data }));
		const taken = new Set(added.map((e) => e.name));
		entries.push(dir, ...added, ...rest.filter((e) => !taken.has(e.name)));
	}
	return entries;
}

function sha256(file) {
	return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
}

function pack(dirs, version) {
	const ours = commandPack({ guides: dirs.guides });
	const { manifest, diags } = ours;
	printDiagnostics(diags);
	if (!manifest) {
		console.error('pack failed: guides/pack.json is invalid');
		return 1;
	}
	if (manifest.version !== version) console.warn(`warning: guides/pack.json says version ${manifest.version}, package.json says ${version}`);
	const product = project.releaseAddons(dirs.addons);
	// The Codex is part of Polestar (Lookup, Dungeons, Rares): built from
	// release-safe inputs, or no release.
	const codexRefusal = releaseRefusal(path.join(dirs.addons, CODEX));
	if (codexRefusal) {
		console.error(`pack failed: ${CODEX} ${codexRefusal}`);
		return 1;
	}
	for (const n of product.skipped) console.log(`note: ${n} not built (no ${n}/${n}.toc); leaving it out of the zip`);
	const license = { name: 'LICENSE', data: fs.readFileSync(path.join(ROOT, 'LICENSE')) };
	const archives = [
		{ file: `Polestar-${version}.zip`, names: product.names, extras: { Polestar: [license, { name: 'README.txt', data: readme(version, product.names) }] } },
		{ file: `Polestar_Recorder-${version}.zip`, names: ['Polestar_Recorder'], extras: { Polestar_Recorder: [license] } },
	];
	for (const { names } of archives) {
		// Our guide pack's TOC is generated below.
		for (const n of names.filter((x) => x !== manifest.folder)) {
			if (!fs.existsSync(path.join(dirs.addons, n, `${n}.toc`))) {
				console.error(`missing ${path.join(dirs.addons, n, `${n}.toc`)}`);
				return 1;
			}
			const v = tocVersion(path.join(dirs.addons, n), n);
			if (v !== version) console.warn(`warning: ${n}.toc says version ${v}, package.json says ${version}`);
		}
	}
	let built;
	try {
		// Building reads Polestar.toc's `## Interface` line: a missing one is an error here too.
		built = compile(ours, dirs);
		if (!built) return 1;
		project.writePackDir(path.join(dirs.addons, manifest.folder), built.files);
		const sums = [];
		for (const { file, names, extras } of archives) {
			const out = path.join(dirs.dist, file);
			writeZip(out, archiveEntries(dirs.addons, names, extras));
			sums.push(`${sha256(out)}  ${file}\n`);
			console.log(`wrote ${path.relative(process.cwd(), out)}`);
		}
		const sumsFile = path.join(dirs.dist, 'SHA256SUMS');
		fs.writeFileSync(sumsFile, sums.join(''));
		console.log(`wrote ${path.relative(process.cwd(), sumsFile)}`);
	} catch (e) {
		console.error(`pack failed: ${e.message}`);
		return 1;
	}
	console.log(`guide pack: ${plural(built.guides.length, 'guide')}`);
	return 0;
}

// Another pack: <dist>/<folder>-<version>.zip from the build, in memory.
function packOther(other, opts) {
	const built = buildPack(other, { dataDir: resolvePath(opts.data, 'data/forever', ROOT), cache: opts.noData ? noDataCache() : null, noDataFlag: true });
	printDiagnostics(built.diag, { quiet: true });
	if (!built.ok) {
		console.error(`pack failed: ${built.noData ? 'no reference data' : `${plural(built.diag.errors.length, 'error')} (run lint for details)`}`);
		return 1;
	}
	const { manifest, files } = built;
	try {
		const dist = opts.dist ? path.resolve(opts.dist) : path.join(other.dir, 'dist');
		const folder = manifest.folder;
		const out = `${folderIn(dist, folder)}-${manifest.version}.zip`;
		// Files named ../<folder>_<locale>/... are its texts addons, folders of their own in the zip.
		const at = (name) => path.posix.normalize(`${folder}/${name}`);
		const dirs = [...new Set(Object.keys(files).map((name) => at(name).split('/')[0]))].sort();
		const entries = dirs.flatMap((d) => [{ name: `${d}/` }, ...Object.keys(files).filter((name) => at(name).startsWith(`${d}/`)).sort().map((name) => ({ name: at(name), data: files[name] }))]);
		writeZip(out, entries);
		console.log(`wrote ${path.relative(process.cwd(), out)} (${plural(built.guides.length, 'guide')})`);
	} catch (e) {
		console.error(`pack failed: ${e.message}`);
		return 1;
	}
	return 0;
}

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, { flags: ['--no-data'], options: [...PACK_OPTIONS, '--guides', '--addons', '--dist'] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const arg = error ? {} : packArgument(opts, positional);
	const usageError = error || arg.error || (opts.guides && arg.pack !== undefined ? '--guides and a pack folder cannot be used together' : null) || noDataConflict(opts);
	if (usageError) {
		console.error(`${usageError}\n\n${usage}`);
		return 2;
	}
	const other = opts.guides ? null : otherPack(opts, positional);
	if (other && other.error) {
		console.error(`${other.error}\n\n${usage}`);
		return 2;
	}
	if (other) return packOther(other, opts);
	if (opts.noData) {
		console.error(`--no-data builds a guide pack; our release needs the reference data\n\n${usage}`);
		return 2;
	}
	const dirs = {
		guides: resolvePath(opts.guides, 'guides', ROOT),
		data: resolvePath(opts.data, 'data/forever', ROOT),
		addons: resolvePath(opts.addons, 'addon', ROOT),
		dist: resolvePath(opts.dist, 'dist', ROOT),
	};
	return pack(dirs, project.packageVersion());
}

module.exports = { name: 'pack', summary: 'Build the release zips, or a guide pack\'s zip', usage, run };
