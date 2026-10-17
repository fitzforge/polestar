'use strict';
// install: copy (or symlink) the Polestar addon folders into the Forever
// client's Interface/AddOns. Only the Polestar folders being installed are
// touched; each is replaced by a rename so the game never sees a half copy.
// Given a guide pack (a folder argument, --pack, or the nearest pack.json) it
// builds that pack and installs its folder instead.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { parseArgs, resolvePath, printDiagnostics, plural } = require('../lib/cli');
const { LOCALE_CODES } = require('../lib/i18n/locales');
const { releaseAddons, packDirRefusal, textsDirRefusal, textsAddon, writePackDir } = require('../lib/dsl/project');
const { ROOT } = require('../lib/paths');
const { detectAddonsDirs, pickAddonsDir, isDir } = require('../lib/addons');
const { PACK_OPTIONS, PACK_USAGE, otherPack, noDataConflict, noDataCache, buildPack, folderIn } = require('../lib/pack/build');

// Data addons built locally from inputs that may not be redistributed
// (docs/SUITE.md, "In-game packs"): installed when built, never packaged.
const LOCAL_DATA_ADDONS = ['Polestar_Travel'];

const usage = `usage: node tools/polestar.js install [<dir>] [options]

Installs addon/Polestar, addon/Polestar_Guides and addon/Polestar_Nav, plus
the data addons Polestar_QuestDB, Polestar_ItemDB, Polestar_Codex and the
names addons Polestar_Names_<locale> when they have been built (and with
--recorder, addon/Polestar_Recorder) into World of Warcraft: Forever's AddOns
folder.

Given another pack (<dir>, --pack, or run inside one) it lints and
builds that pack into <pack>/dist/<folder>/ instead and installs that
folder; an existing <AddOns>/<folder> is replaced only when it is empty or a
generated build of the same pack (its TOC's X-Polestar-Pack names this
pack's id). Without reference data (\`data build\`) it stops with one error,
unless --no-data says to build without it.

Destination, first match wins:
  --dest <dir>             the Interface/AddOns folder to install into
  $WOW_FOREVER_ADDONS      same, from the environment
  auto-detect              Wine/Proton/Faugus/Lutris/Bottles prefixes under your home
                           folder, and native installs (C:\\Program Files (x86)\\World of
                           Warcraft on Windows, /Applications/World of Warcraft on macOS);
                           a "_forever_" or "_classic_beta_" client folder whose
                           .flavor.info names Forever (wow_forever*) or the classic beta

options:
  --link        symlink the folders instead of copying (edit, then /reload)
  --recorder    also install Polestar_Recorder
  --dry-run     print what would happen, change nothing
  --addons <dir>  source folder holding the addons (default addon/)
  --no-data     a pack only: build it without reference data (every
                quest title, NPC name and place given in the guide)
${PACK_USAGE}`;

// -> { dir, how } or { error }. `native` ({ platform, root }, tools/lib/addons.js
// nativeWowDir) is passed to detectAddonsDirs; tests inject it.
function chooseDest(opts, env = process.env, home = os.homedir(), native = {}) {
	if (opts.dest) return isDir(opts.dest) ? { dir: path.resolve(opts.dest), how: '--dest' } : { error: `--dest ${opts.dest} is not a folder` };
	if (env.WOW_FOREVER_ADDONS) {
		const d = env.WOW_FOREVER_ADDONS;
		return isDir(d) ? { dir: path.resolve(d), how: '$WOW_FOREVER_ADDONS' } : { error: `$WOW_FOREVER_ADDONS (${d}) is not a folder` };
	}
	const { pick, several } = pickAddonsDir(detectAddonsDirs(home, native));
	if (several) return { error: `several Forever clients found; choose one with --dest:\n${several.map((f) => `  ${f.addons}`).join('\n')}` };
	if (!pick) {
		return { error: 'no World of Warcraft: Forever client found (under your home folder or a native install); pass --dest <.../Interface/AddOns> or set $WOW_FOREVER_ADDONS' };
	}
	return { dir: pick.addons, how: `auto-detected, flavor ${pick.flavor}`, create: true };
}

function removePath(p) {
	const st = fs.lstatSync(p);
	if (st.isSymbolicLink() || !st.isDirectory()) fs.unlinkSync(p);
	else fs.rmSync(p, { recursive: true, force: true });
}

function exists(p) {
	try {
		fs.lstatSync(p);
		return true;
	} catch {
		return false;
	}
}

function real(p) {
	try {
		return fs.realpathSync(p);
	} catch {
		return null;
	}
}

function within(child, parent) {
	const rel = path.relative(parent, child);
	return rel === '' || (!rel.startsWith('..') && !path.isAbsolute(rel));
}

// Why replacing <dest>/<name> with <src> would be destructive, or null. The
// old target is deleted after the swap, so a real folder there must not be (or
// contain) the source, the destination must not lie inside the source, and an
// existing real folder must be that addon: `owned(target)` says so (default:
// it has <name>.toc; a guide pack: it is generated). An old symlink (from
// --link) is only unlinked, so replacing it is always safe.
function unsafeTarget(src, destDir, name, owned = null) {
	const s = real(src);
	const d = real(destDir) || path.resolve(destDir);
	const target = path.join(destDir, name);
	if (s && within(d, s)) return `${destDir} is inside the source ${src}`;
	if (!exists(target)) return null;
	const st = fs.lstatSync(target);
	if (st.isSymbolicLink()) return null;
	const t = real(target);
	if (s && t && within(s, t)) return `${target} is (or contains) the source ${src}`;
	if (!st.isDirectory()) return `${target} exists and is not a folder`;
	if (owned) return owned(target);
	if (!fs.existsSync(path.join(target, `${name}.toc`))) return `${target} exists but has no ${name}.toc; not an installed ${name}`;
	return null;
}

// unsafeTarget's check for pack packId's folder (the rule writePackDir keeps).
const generatedPack = (packId) => (target) => {
	const refusal = packDirRefusal(target, packId);
	return refusal && `${target}: ${refusal}`;
};

function installOne(src, dest, name, link) {
	const target = path.join(dest, name);
	const tmp = path.join(dest, `${name}.polestar-new-${process.pid}`);
	const old = path.join(dest, `${name}.polestar-old-${process.pid}`);
	if (exists(tmp)) removePath(tmp);
	if (link) fs.symlinkSync(src, tmp, 'dir');
	else fs.cpSync(src, tmp, { recursive: true, filter: (s) => !path.basename(s).startsWith('.') || s === src });
	const had = exists(target);
	if (had) fs.renameSync(target, old);
	try {
		fs.renameSync(tmp, target);
	} catch (e) {
		if (had) fs.renameSync(old, target);
		removePath(tmp);
		throw e;
	}
	if (had) removePath(old);
}

function hasCompiledGuides(dir) {
	try {
		return fs.readFileSync(path.join(dir, 'Guides.lua'), 'utf8').includes('RegisterGuide(');
	} catch {
		return false;
	}
}

// Install folders [{ src, name, owned? }] into the chosen destination.
// `prepare()` (unless --dry-run) runs after every check passed, before anything
// is installed; it returns an error message or null. `ctx`: { env, native } (see run).
// `drop`: { drop: [folder name], owned(target) -> bool }, folders removed
// from the destination where owned says they are ours to remove.
function installFolders(folders, opts, ctx, prepare = null, drop = null) {
	const dest = chooseDest(opts, ctx.env, ctx.env.HOME || os.homedir(), ctx.native);
	if (dest.error) {
		console.error(dest.error);
		return 1;
	}
	const unsafe = folders.map((f) => unsafeTarget(f.src, dest.dir, f.name, f.owned)).filter(Boolean);
	if (unsafe.length) {
		for (const msg of unsafe) console.error(`refusing to install: ${msg}`);
		return 1;
	}
	const verb = opts.link ? 'link' : 'copy';
	if (prepare && !opts.dryRun) {
		const err = prepare();
		if (err) {
			console.error(`install failed: ${err}`);
			return 1;
		}
	}
	console.log(`${opts.dryRun ? 'would install' : 'installing'} into ${dest.dir} (${dest.how})`);
	if (dest.create && !isDir(dest.dir)) {
		console.log(`  ${opts.dryRun ? 'would create' : 'creating'} ${dest.dir}`);
		if (!opts.dryRun) fs.mkdirSync(dest.dir, { recursive: true });
	}
	for (const { src, name } of folders) {
		const target = path.join(dest.dir, name);
		const action = `${exists(target) ? 'replace' : 'add'} ${name} (${verb} from ${src})`;
		if (opts.dryRun) {
			console.log(`  would ${action}`);
			continue;
		}
		installOne(src, dest.dir, name, !!opts.link);
		console.log(`  ${action.replace(/^replace/, 'replaced').replace(/^add/, 'added')}`);
	}
	for (const name of (drop && drop.drop) || []) {
		const target = path.join(dest.dir, name);
		if (!exists(target) || !drop.owned(target)) continue;
		console.log(`  ${opts.dryRun ? 'would remove' : 'removed'} ${name} (the pack no longer translates that language)`);
		if (!opts.dryRun) removePath(target);
	}
	return 0;
}

// Another pack: lint and build it into <pack>/dist/<folder>/, then install that folder.
function installPack(other, opts, ctx) {
	if (opts.recorder || opts.addons) {
		console.error(`${opts.recorder ? '--recorder' : '--addons'} installs Polestar itself; run it outside the pack, without a pack folder\n\n${usage}`);
		return 2;
	}
	const built = buildPack(other, { dataDir: resolvePath(opts.data, 'data/forever', ROOT), cache: opts.noData ? noDataCache() : null, noDataFlag: true });
	printDiagnostics(built.diag, { quiet: true });
	if (!built.ok) {
		console.error(`install failed: ${built.noData ? 'no reference data' : `${plural(built.diag.errors.length, 'error')} (run lint for details)`}`);
		return 1;
	}
	const name = built.manifest.folder;
	let src;
	try {
		src = folderIn(path.join(other.dir, 'dist'), name);
	} catch (e) {
		console.error(`install failed: ${e.message}`);
		return 1;
	}
	if (opts.dryRun) console.log(`would build ${src} (${plural(built.guides.length, 'guide')})`);
	const prepare = () => {
		try {
			writePackDir(src, built.files);
		} catch (e) {
			return e.message;
		}
		console.log(`built ${src} (${plural(built.guides.length, 'guide')})`);
		return null;
	};
	// The pack's texts addons (one per language it translates) sit beside it.
	const texts = [...new Set(Object.keys(built.files).filter((f) => f.startsWith('../')).map((f) => f.split('/')[1]))].sort();
	const owned = (target) => {
		const refusal = textsDirRefusal(target, built.manifest.id);
		return refusal && `${target}: ${refusal}`;
	};
	const folders = [{ src, name, owned: generatedPack(built.manifest.id) }, ...texts.map((t) => ({ src: path.join(path.dirname(src), t), name: t, owned }))];
	// A texts addon of a language the pack no longer translates goes (only one generated for this pack).
	const dropped = LOCALE_CODES.map((l) => textsAddon(name, l)).filter((t) => !texts.includes(t));
	return installFolders(folders, opts, ctx, prepare, { drop: dropped, owned: (target) => !textsDirRefusal(target, built.manifest.id) });
}

// `env` and `native` ({ platform, root }) stand in for the environment and the
// native install in tests, so a test never reaches a real game folder.
async function run(argv, env = process.env, native = {}) {
	const ctx = { env, native };
	const { opts, positional, error } = parseArgs(argv, { flags: ['--link', '--recorder', '--dry-run', '--no-data'], options: ['--dest', '--addons', ...PACK_OPTIONS] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const usageError = error || noDataConflict(opts);
	if (usageError) {
		console.error(`${usageError}\n\n${usage}`);
		return 2;
	}
	const other = otherPack(opts, positional);
	if (other && other.error) {
		console.error(`${other.error}\n\n${usage}`);
		return 2;
	}
	if (other) return installPack(other, opts, ctx);
	if (opts.noData) {
		console.error(`--no-data builds a community addon; run it inside the pack or name its folder\n\n${usage}`);
		return 2;
	}
	const source = opts.addons ? path.resolve(opts.addons) : path.join(ROOT, 'addon');
	const release = releaseAddons(source);
	const local = LOCAL_DATA_ADDONS.filter((n) => fs.existsSync(path.join(source, n, `${n}.toc`)));
	const skipped = [...release.skipped, ...LOCAL_DATA_ADDONS.filter((n) => !local.includes(n))];
	for (const n of skipped) console.log(`note: ${n} not built (no ${n}/${n}.toc); skipping it`);
	const names = [...release.names, ...local, ...(opts.recorder ? ['Polestar_Recorder'] : [])];
	for (const name of names) {
		if (!fs.existsSync(path.join(source, name, `${name}.toc`))) {
			console.error(`missing ${path.join(source, name, `${name}.toc`)}`);
			return 1;
		}
	}
	if (!hasCompiledGuides(path.join(source, 'Polestar_Guides'))) {
		console.warn('warning: Polestar_Guides has no compiled guides; run `node tools/polestar.js compile` first');
	}
	return installFolders(names.map((name) => ({ src: path.join(source, name), name })), opts, ctx);
}

module.exports = { name: 'install', summary: 'Install the addons into the Forever client', usage, run, chooseDest };
