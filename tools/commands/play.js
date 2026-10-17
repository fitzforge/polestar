'use strict';
// `node tools/polestar.js play`: the browser playground (tools/play). Starts
// the local server over one live Lua session of the real addons and prints
// the URL; Ctrl-C saves the SavedVariables and stops it. Given another guide
// pack (a folder argument, --pack, or the nearest pack.json) that pack is
// built into a temp folder and loaded after our guides.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { parseArgs, printDiagnostics, resolvePath, plural } = require('../lib/cli');
const { writePackDir } = require('../lib/dsl/project');
const { PACK_OPTIONS, PACK_USAGE, otherPack, buildPack, folderIn } = require('../lib/pack/build');

const { ROOT } = require('../lib/paths');
const DEFAULT_ART = '/tmp/polestar-art';

// Client art when none is named: $POLESTAR_CLIENT_ART, else /tmp/polestar-art
// when it holds maps.json, else '' (draw without art).
function defaultArt() {
	return process.env.POLESTAR_CLIENT_ART || (fs.existsSync(path.join(DEFAULT_ART, 'maps.json')) ? DEFAULT_ART : '');
}

// The playground's SavedVariables folder: $POLESTAR_PLAY_DATA, else data/play/.
function playDataDir() {
	return process.env.POLESTAR_PLAY_DATA ? path.resolve(process.env.POLESTAR_PLAY_DATA) : path.join(ROOT, 'data', 'play');
}

function parse(argv) {
	const { opts: o, positional, error } = parseArgs(argv, { flags: ['--fresh', '--no-art'], options: ['--port', '--art', ...PACK_OPTIONS] });
	if (error) throw new Error(error);
	const opts = { ...o, positional, port: o.port === undefined ? 8077 : Number(o.port), art: o.noArt ? '' : o.art === undefined ? null : o.art, fresh: !!o.fresh, host: '127.0.0.1' };
	if (!Number.isInteger(opts.port) || opts.port < 0 || opts.port > 65535) throw new Error('--port needs a port number');
	if (opts.art === null) opts.art = defaultArt();
	return opts;
}

// A fresh temp folder for a pack's build in the playground; removed at exit.
function playPackRoot() {
	const root = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-play-pack-'));
	process.once('exit', () => fs.rmSync(root, { recursive: true, force: true }));
	return root;
}

// Build another pack for the playground: lint it (diagnostics printed) and
// write it into <root>/<folder>. -> { dir, built } or { built } with
// built.ok false when it has errors.
function buildPlayPack(pack, { dataDir, root = playPackRoot(), cache = null } = {}) {
	const built = buildPack(pack, { dataDir, cache });
	printDiagnostics(built.diag);
	if (!built.ok) return { built };
	const dir = folderIn(root, built.manifest.folder);
	writePackDir(dir, built.files);
	return { dir, built };
}

async function run(argv) {
	let opts;
	try {
		opts = parse(argv);
	} catch (err) {
		console.error(`${err.message}\n\n${usage}`);
		return 2;
	}
	if (opts.help) {
		console.log(usage);
		return 0;
	}
	const other = otherPack(opts, opts.positional);
	if (other && other.error) {
		console.error(`${other.error}\n\n${usage}`);
		return 2;
	}
	if (!fs.existsSync(path.join(ROOT, 'data', 'forever', 'races.json'))) {
		console.error('data/forever is not built: run node tools/polestar.js data build first');
		return 1;
	}
	const packs = [];
	if (other) {
		const { dir, built } = buildPlayPack(other, { dataDir: resolvePath(opts.data, 'data/forever', ROOT) });
		if (!dir) {
			console.error(built.noData ? 'play: not started: no reference data' : `play: the pack has ${plural(built.diag.errors.length, 'error')}; fix them first`);
			return 1;
		}
		console.log(`community addon ${built.manifest.id}: ${plural(built.guides.length, 'guide')}, loaded after ours`);
		packs.push(dir);
	}
	const { startServer } = require('../play/server');
	const t0 = Date.now();
	const dataDir = playDataDir();
	const play = await startServer({
		port: opts.port, host: opts.host, artDir: opts.art || null, fresh: opts.fresh, packs,
		dataDir,
		log: (m) => console.log(`[play] ${m}`),
	});
	console.log(`Polestar playground: ${play.url}  (started in ${Date.now() - t0} ms${opts.art ? `, art from ${opts.art}` : ', no client art'})`);
	console.log(`SavedVariables in ${path.relative(process.cwd(), dataDir) || '.'} (--fresh resets them). Ctrl-C to stop.`);
	await untilStopped(() => play.close({ save: true }));
	return 0;
}

// Resolves after SIGINT/SIGTERM once stop() has finished.
function untilStopped(stop) {
	return new Promise((resolve) => {
		let stopping = false;
		const once = () => {
			if (stopping) return;
			stopping = true;
			console.log('\nSaving and stopping...');
			Promise.resolve()
				.then(stop)
				.catch((e) => console.error(String(e && e.message ? e.message : e)))
				.finally(resolve);
		};
		process.once('SIGINT', once);
		process.once('SIGTERM', once);
	});
}

const usage = [
	'usage: node tools/polestar.js play [<dir>] [--port 8077] [--art <dir>] [--fresh]',
	'',
	'Starts a local server running the real Polestar, Polestar_Guides and the',
	'built data packs against the simulated world, and prints its URL. Click,',
	'hover, scroll, drag and type in the game screen; the side panel sets the',
	'character, moves them, plays guide goals and tweaks the look live.',
	'Given another pack (<dir>, --pack, or run inside one) that pack is',
	'linted, built into a temp folder and loaded after our guides.',
	'',
	'  --port <n>   port on 127.0.0.1 (default 8077; 0 picks a free one)',
	'  --art <dir>  local client art (default $POLESTAR_CLIENT_ART, else',
	'               /tmp/polestar-art when present); served locally only',
	'  --no-art     draw without client art',
	'  --fresh      forget the character and SavedVariables (data/play/, or',
	'               $POLESTAR_PLAY_DATA)',
	PACK_USAGE,
].join('\n');

module.exports = {
	name: 'play',
	summary: 'Play with the real addon in the browser (local playground)',
	usage,
	run,
	buildPlayPack,
	playPackRoot,
	untilStopped,
	defaultArt,
	playDataDir,
};
