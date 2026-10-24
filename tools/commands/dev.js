'use strict';
// dev: the author's loop. Watches a guide pack's pack.json and
// .guide files; on every save it lints (printing the diagnostics) and, without
// errors, compiles into the game's AddOns folder (as install finds it, or
// --dest; --no-game skips it) and reloads the playground when --play started
// one. A folder in AddOns is replaced only when it is absent, empty or a
// generated build of the same pack.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { parseArgs, printDiagnostics, resolvePath, plural } = require('../lib/cli');
const { writePackDir, loadProjectData } = require('../lib/dsl/project');
const { ROOT } = require('../lib/paths');
const { Diagnostics } = require('../lib/dsl/diag');
const { loadData } = require('../lib/dsl/data');
const { isDir } = require('../lib/addons');
const { PACK_OPTIONS, PACK_USAGE, otherPack, noDataConflict, noDataCache, noReferenceData, buildPack, folderIn } = require('../lib/pack/build');
const { commandPack } = require('../lib/pack/locate');
const { packImporter } = require('../lib/pack/importstring');
const { chooseDest } = require('./install');
const { playPackRoot, untilStopped, defaultArt, playDataDir } = require('./play');

const DEBOUNCE_MS = 200;

const usage = `usage: node tools/polestar.js dev [<dir>] [options]

On a pack (<dir>, --pack, or run inside one): watches pack.json and
the pack's .guide files. On every save it lints, printing the diagnostics,
and without errors compiles the pack into <AddOns>/<folder>, then reloads
the playground when --play started one. In game, /reload shows the change;
a pack's first build needs one restart of the game. A folder in AddOns is
replaced only when it is empty or a generated build of the same pack.
Ctrl-C stops. Without reference data (\`data build\`) dev stops at once with
one error, unless --no-data says to build without it.

options:
  --dest <dir>          the Interface/AddOns folder (default: the one install finds)
  --client <folder-or-flavor>  build into one detected client (e.g. _forever_, wowf, beta)
  --no-game             do not write into AddOns (lint, and the playground)
  --play                also start the playground with the pack loaded (client
                        art and SavedVariables folder as play finds them)
  --port <n>            the playground's port (default 8077; 0 picks a free one)
  --no-data             build without reference data: every quest title, NPC
                        name and place must be given in the guide
${PACK_USAGE}`;

// Paths (relative to the pack, forward slashes) whose change rebuilds.
function watched(rel) {
	if (rel === 'pack.json') return true;
	if (!rel.endsWith('.guide')) return false;
	const top = rel.split('/')[0];
	return top !== 'dist' && top !== 'drafts' && !rel.split('/').some((p) => p.startsWith('.') || p === 'node_modules');
}

async function run(argv, env = process.env) {
	const { opts, positional, error } = parseArgs(argv, { flags: ['--no-game', '--play', '--no-data'], options: ['--dest', '--port', '--client', ...PACK_OPTIONS] });
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const port = opts.port === undefined ? 8077 : Number(opts.port);
	const usageError =
		error ||
		(opts.noGame && (opts.dest || opts.client) ? `--${opts.dest ? 'dest' : 'client'} and --no-game cannot be used together` : null) ||
		(!Number.isInteger(port) || port < 0 || port > 65535 ? '--port needs a port number' : null) ||
		noDataConflict(opts);
	if (usageError) {
		console.error(`${usageError}\n\n${usage}`);
		return 2;
	}
	const first = otherPack(opts, positional);
	if (first && first.error) {
		console.error(`${first.error}\n\n${usage}`);
		return 2;
	}
	if (!first) {
		console.error('dev works on a pack: run it inside one (a folder with pack.json) or name its folder; our guides build with `compile`');
		return 2;
	}
	const dataDir = resolvePath(opts.data, 'data/forever', ROOT);
	// No watching without data: every build would fail the same way.
	const missing = opts.noData ? null : noReferenceData(first, dataDir, true);
	if (missing) {
		printDiagnostics(missing);
		console.error('dev: not started: no reference data');
		return 1;
	}
	if (opts.play && !fs.existsSync(path.join(ROOT, 'data', 'forever', 'races.json'))) {
		console.error('dev --play: data/forever is not built (the playground needs it): run forge data build first');
		return 1;
	}
	const packDir = first.dir;
	let addonsDirs = [];
	if (!opts.noGame) {
		const dest = chooseDest(opts, env, env.HOME || os.homedir());
		if (dest.error) {
			console.error(`${dest.error}\n(or pass --no-game to build without the game)`);
			return 1;
		}
		for (const d of dest.dirs || [dest]) {
			if (d.create && !isDir(d.dir)) fs.mkdirSync(d.dir, { recursive: true });
			console.log(`dev: building into ${d.dir} (${d.how})`);
			addonsDirs.push(d.dir);
		}
	}
	// The reference data is read once; its warnings (missing core files or
	// context data, as lint prints them) are added to every build's diagnostics.
	let cache = noDataCache();
	if (!opts.noData) {
		const dataDiag = new Diagnostics();
		cache = { data: loadProjectData(dataDir, dataDiag), diags: dataDiag.list };
		if (first.contextDataDir && fs.existsSync(first.contextDataDir)) cache.contextData = path.resolve(first.contextDataDir) === path.resolve(dataDir) ? cache.data : loadData(first.contextDataDir);
	}
	const playRoot = opts.play ? playPackRoot() : null;
	let playDir = null; // the last good build for the playground
	let play = null;
	let lastImporter = null; // the last good build's import strings (the playground's Copy import string)

	// One rebuild: the pack is read again (pack.json may have changed, or be
	// gone: its error is printed like any other and the last good build stays).
	async function rebuild() {
		const pack = commandPack({ pack: packDir, context: opts.context, contextData: opts.contextData });
		if (pack.error) {
			console.error(`dev: ${pack.error}; not built (the last good build stays)`);
			return;
		}
		const built = buildPack(pack, { dataDir, cache });
		printDiagnostics(built.diag);
		if (!built.ok) {
			console.error(`dev: ${plural(built.diag.errors.length, 'error')}, ${plural(built.diag.warnings.length, 'warning')}; not built (the last good build stays)`);
			return;
		}
		const { manifest, files } = built;
		lastImporter = packImporter(built);
		const summary = `${plural(built.guides.length, 'guide')}, ${plural(built.diag.warnings.length, 'warning')}`;
		for (const addonsDir of addonsDirs) {
			try {
				const target = folderIn(addonsDir, manifest.folder);
				const isNew = !fs.existsSync(path.join(target, `${manifest.folder}.toc`));
				writePackDir(target, files);
				console.log(`dev: built ${summary} into ${target}`);
				if (isNew) console.log(`New addon: restart the game once so it sees ${manifest.folder}; after that /reload shows every change.`);
			} catch (e) {
				console.error(`dev: ${e.message}`);
			}
		}
		if (!addonsDirs.length) {
			console.log(`dev: built ${summary} (not written: --no-game)`);
		}
		if (playRoot) {
			playDir = folderIn(playRoot, manifest.folder);
			writePackDir(playDir, files);
			if (play) {
				await play.reload({ packs: [playDir] });
				console.log('dev: playground reloaded');
			}
		}
	}

	// Rebuilds run one at a time; saves during a build queue one more.
	let running = null;
	let again = false;
	async function trigger() {
		if (running) {
			again = true;
			return;
		}
		do {
			again = false;
			running = rebuild().catch((e) => console.error(`dev: ${e.stack || e.message}`));
			await running;
		} while (again);
		running = null;
	}

	await trigger();
	// The playground starts once, after the first build (with it when it built).
	if (playRoot) {
		const { startServer } = require('../play/server');
		const art = defaultArt();
		try {
			play = await startServer({ port, host: '127.0.0.1', artDir: art || null, packs: playDir ? [playDir] : [], importString: (id) => (lastImporter ? lastImporter(id) : { error: 'the pack has not built yet' }), dataDir: playDataDir(), log: (m) => console.log(`[play] ${m}`) });
		} catch (e) {
			console.error(`dev: the playground could not start: ${e.message}${e.code === 'EADDRINUSE' ? ` (port ${port} is taken; pass --port <n>, 0 picks a free one)` : ''}`);
			return 1;
		}
		console.log(`Polestar playground: ${play.url}${art ? `  (art from ${art})` : '  (no client art)'}`);
	}
	let timer = null;
	const watcher = fs.watch(packDir, { recursive: true }, (_event, name) => {
		if (!name || !watched(String(name).split(path.sep).join('/'))) return;
		clearTimeout(timer);
		timer = setTimeout(trigger, DEBOUNCE_MS);
	});
	console.log(`dev: watching ${packDir} (Ctrl-C to stop)`);
	await untilStopped(async () => {
		watcher.close();
		clearTimeout(timer);
		if (running) await running;
		if (play) await play.close({ save: true });
	});
	return 0;
}

module.exports = { name: 'dev', summary: 'Rebuild a pack into the game on every save', usage, run };
