'use strict';
// `node tools/polestar.js planner`: the route planner (tools/planner). Serves
// the page that plays a guide on the real map and edits its .guide source;
// `planner art` builds the local map art it draws (tools/lib/planner/art);
// `planner mcp` offers the same commands to an agent over MCP stdio.

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs } = require('../lib/cli');
const { ROOT, DATA, SOURCES } = require('../lib/paths');

const DEFAULT_PORT = 8078;
const DEFAULT_ART = path.join(ROOT, 'data', 'local', 'planner', 'art');
const DEFAULT_NAV = path.join(ROOT, 'data', 'local', 'nav');

const usage = `usage: node tools/polestar.js planner [<pack dir>...] [--port ${DEFAULT_PORT}] [--art <dir>] [--nav <dir>] [--open]
       node tools/polestar.js planner art [--continents 0,1] [--no-zones] [--force] [--offline] [--concurrency N] [--out <dir>]
       node tools/polestar.js planner mcp [<pack dir>...] [--port ${DEFAULT_PORT}] [--art <dir>] [--nav <dir>]

The route planner: a local page (http://127.0.0.1:${DEFAULT_PORT}) that plays a
guide on the real map, step by step, with the clock, the XP and the quest
log, and edits the .guide files (fields, steps, dragged waypoints): every
edit is written to the file at once. Our guides/ are always loaded; other
packs (a folder holding pack.json, as arguments or --pack) come after them.
Inspired by Nivek_Gaming (@Nivek_Gaming on X): thank you, Nivek.

  --port <n>          port on 127.0.0.1 (default ${DEFAULT_PORT}; 0 picks a free one)
  --art <dir>         the map art (default data/local/planner/art)
  --nav <dir>         the navigation grid walks are routed on (default data/local/nav;
                      built by node tools/polestar.js nav build; without it walks are straight lines)
  --data <dir>        reference data (default data/forever/)
  --pack <dir>        one more pack folder
  --open              open the page in the browser

planner art: fetch the Forever client's minimap blocks and zone maps from
wago.tools (cached under data/sources/casc/) and build the art the page
draws into data/local/planner/art/ (never committed).

  --continents <c,..> only these continents (map ids, e.g. 0,1; default all)
  --no-zones          skip the painted zone maps
  --force             rebuild files that exist
  --offline           use only cached downloads
  --concurrency <n>   parallel downloads (default 8)
  --product <p>       wago.tools product (default wow_classic_beta)
  --out <dir>         output folder (default data/local/planner/art)

planner mcp: the planner's commands as an MCP server on stdin/stdout
(JSON-RPC, one message per line). It uses the planner running on --port, so
an agent's edits show live in the open page, else starts one itself.`;

const SERVE_OPTIONS = { flags: ['--open'], options: ['--port', '--art', '--nav', '--data', '--pack'] };
const ART_OPTIONS = { flags: ['--no-zones', '--force', '--offline'], options: ['--continents', '--concurrency', '--out', '--product'] };

function portOf(o) {
	const port = o.port === undefined ? DEFAULT_PORT : Number(o.port);
	if (!Number.isInteger(port) || port < 0 || port > 65535) throw Object.assign(new Error('--port needs a port number'), { exit: 2 });
	return port;
}

// The pack folders named on the command line (each must hold pack.json).
function packDirs(o, positional) {
	const dirs = [...positional, ...(o.pack ? [o.pack] : [])].map((d) => path.resolve(d));
	for (const d of dirs) if (!fs.existsSync(path.join(d, 'pack.json'))) throw Object.assign(new Error(`no pack.json in ${d}`), { exit: 2 });
	return dirs;
}

function makeWorkspace(o, positional, log) {
	const dataDir = o.data ? path.resolve(o.data) : DATA;
	if (!fs.existsSync(path.join(dataDir, 'races.json'))) throw Object.assign(new Error(`${dataDir} holds no reference data: run forge data build first`), { exit: 1 });
	const { Workspace } = require('../planner/workspace');
	const artDir = o.art ? path.resolve(o.art) : DEFAULT_ART;
	const navDir = o.nav ? path.resolve(o.nav) : DEFAULT_NAV;
	try {
		return new Workspace({ dataDir, packs: packDirs(o, positional), artDir, navDir, log });
	} catch (err) {
		if (!err.exit) err.exit = 1;
		throw err;
	}
}

function artNote(artDir) {
	return fs.existsSync(path.join(artDir, 'index.json')) ? `map art from ${path.relative(process.cwd(), artDir) || '.'}` : 'no map art yet: run `node tools/polestar.js planner art` for the terrain';
}

// Resolves after SIGINT/SIGTERM once stop() has finished.
function untilStopped(stop) {
	return new Promise((resolve) => {
		let stopping = false;
		const once = () => {
			if (stopping) return;
			stopping = true;
			console.error('\nStopping...');
			Promise.resolve()
				.then(stop)
				.catch((e) => console.error(String(e && e.message ? e.message : e)))
				.finally(resolve);
		};
		process.once('SIGINT', once);
		process.once('SIGTERM', once);
	});
}

function openBrowser(url) {
	const { spawn } = require('node:child_process');
	const cmd = process.platform === 'darwin' ? 'open' : process.platform === 'win32' ? 'explorer' : 'xdg-open';
	try {
		const child = spawn(cmd, [url], { detached: true, stdio: 'ignore' });
		child.on('error', () => console.error(`could not run ${cmd}; open ${url} yourself`));
		child.unref();
	} catch {
		console.error(`could not run ${cmd}; open ${url} yourself`);
	}
}

async function serve(argv) {
	const { opts: o, positional, error } = parseArgs(argv, SERVE_OPTIONS);
	if (error) throw Object.assign(new Error(error), { exit: 2 });
	const port = portOf(o);
	const t0 = Date.now();
	const ws = makeWorkspace(o, positional, (m) => console.error(`[planner] ${m}`));
	const { startServer } = require('../planner/server');
	let server;
	try {
		server = await startServer({ port, workspace: ws, log: (m) => console.error(`[planner] ${m}`) });
	} catch (err) {
		ws.close();
		if (err.code === 'EADDRINUSE') throw Object.assign(new Error(`port ${port} is in use (another planner?); pass --port <n>`), { exit: 1 });
		throw err;
	}
	ws.lintAll();
	const guides = [...ws.sources.values()].filter((s) => s.id).length;
	console.log(`Polestar planner: ${server.url}  (${ws.packs.map((p) => p.id).join(', ')}: ${guides} guides; started in ${Date.now() - t0} ms)`);
	console.log(`${artNote(ws.artDir)}. Inspired by Nivek_Gaming (@Nivek_Gaming on X). Ctrl-C to stop.`);
	if (o.open) openBrowser(server.url);
	await untilStopped(async () => {
		await server.close();
		ws.close();
	});
	return 0;
}

async function art(argv) {
	const { opts: o, positional, error } = parseArgs(argv, ART_OPTIONS);
	if (error || positional.length) throw Object.assign(new Error(error || `unexpected argument "${positional[0]}"`), { exit: 2 });
	let continents = null;
	if (o.continents !== undefined) {
		continents = String(o.continents).split(',').map((s) => Number(s.trim()));
		if (continents.some((c) => !Number.isInteger(c) || c < 0)) throw Object.assign(new Error('--continents needs map ids, e.g. 0,1'), { exit: 2 });
	}
	const concurrency = o.concurrency === undefined ? 8 : Number(o.concurrency);
	if (!Number.isInteger(concurrency) || concurrency < 1) throw Object.assign(new Error('--concurrency needs a positive number'), { exit: 2 });
	const outDir = o.out ? path.resolve(o.out) : DEFAULT_ART;
	const { buildArt } = require('../lib/planner/art/build');
	const t0 = Date.now();
	const r = await buildArt({
		outDir, sourcesDir: SOURCES, dataDir: DATA, product: o.product || 'wow_classic_beta', continents,
		zones: !o.noZones, force: !!o.force, offline: !!o.offline, concurrency, log: (m) => console.error(m),
	});
	for (const w of r.warnings || []) console.error(`warning: ${typeof w === 'string' ? w : w.message || JSON.stringify(w)}`);
	const count = (v) => (Array.isArray(v) ? v.length : typeof v === 'object' && v ? Object.keys(v).length : v);
	console.log(`map art ${r.build}: ${count(r.continents)} continents, ${count(r.tiles)} tiles, ${count(r.zones)} zone maps in ${path.relative(process.cwd(), outDir) || '.'} (${((Date.now() - t0) / 1000).toFixed(1)} s)`);
	return 0;
}

async function mcp(argv) {
	const { opts: o, positional, error } = parseArgs(argv, { flags: [], options: ['--port', '--art', '--nav', '--data', '--pack'] });
	if (error) throw Object.assign(new Error(error), { exit: 2 });
	const port = portOf(o);
	const log = (m) => process.stderr.write(`${m}\n`);
	const { runMcp } = require('../planner/mcp');
	let ws = null;
	await runMcp({
		port,
		log,
		start: async (p) => {
			ws = makeWorkspace(o, positional, (m) => log(`[planner] ${m}`));
			const { startServer } = require('../planner/server');
			let server;
			try {
				server = await startServer({ port: p, workspace: ws, log: (m) => log(`[planner] ${m}`) });
			} catch (err) {
				if (err.code !== 'EADDRINUSE') throw err;
				server = await startServer({ port: 0, workspace: ws, log: (m) => log(`[planner] ${m}`) });
			}
			log(`polestar planner: ${server.url} (${artNote(ws.artDir)})`);
			return {
				url: server.url,
				close: async () => {
					await server.close();
					ws.close();
				},
			};
		},
	});
	return 0;
}

async function run(argv) {
	const [sub, ...rest] = argv;
	try {
		if (sub === 'art') return await art(rest);
		if (sub === 'mcp') return await mcp(rest);
		return await serve(argv);
	} catch (err) {
		if (err.exit === 2) {
			console.error(`${err.message}\n\n${usage}`);
			return 2;
		}
		if (err.exit === 1 || err.code === 'EADDRINUSE') {
			console.error(`planner: ${err.message}`);
			return 1;
		}
		throw err;
	}
}

module.exports = { name: 'planner', summary: 'Plan routes: play a guide on the map and edit it (local page, MCP)', usage, run };
