'use strict';
// The planner's HTTP server (node tools/polestar.js planner): the page in
// tools/planner/public, the local map art, and the command registry over one
// Workspace (tools/planner/workspace.js). Local only: it binds 127.0.0.1.
//
//   GET  /                             the page (and its files)
//   GET  /api/commands                 [{ name, description, input, mutates }]
//   POST /api/cmd                      { name, args } -> { ok, result } | { ok: false, error, code }
//   POST /api/view                     the page reports what it shows (view_state)
//   GET  /api/events                   SSE: hello, changed, diagnostics, routing, focus, seek, play
//   GET  /art/index.json               the art index (planner art)
//   GET  /art/tiles/<c>/<L>/<tx>_<ty>.bc1   a terrain tile: the .bc1.gz bytes, content-encoding gzip
//   GET  /art/zones/<uiMapID>.png      a zone's painted map
//   GET  /nav/index.json               the navigation grid: { build, continents: { [c]: ['col_row'] } } (tiles built), or 404
//   GET  /nav/tile/<c>/<col>_<row>.png the Walkable layer of an ADT tile (navpool.js walkable), 256x256
//   GET  /nav/aids.json                the arrow aids (data/local/nav/aids.json) as world points (Workspace.navAids), or 404
//   GET  /nav/roads/index.json         the roads layer (data/local/nav-layers/roads/index.json): { build, continents: { [c]: ['col_row'] } } (tiles with road), or 404
//   GET  /nav/roads/tile/<c>/<col>_<row>.png  the Roads layer of an ADT tile (tools/lib/nav/layers/roads.js roadsPng), 256x256
//   GET  /nav/hubs.json                the Hubs layer (data/local/nav-layers/hubs.json): { [c]: [{ id, side, name, areaId, disks: [[x, y, r]] }] }, or 404
//   GET  /glyph/<name>.png?px=<24..256>  a Polestar glyph, white on transparent (default 96 px)
//   GET  /emblem.png?px=               the Polestar emblem
//   GET  /band.png, /band-stars.png    the night-sky header layers (1024x128)
//   GET  /icon/<kind>/<key>.png        a game icon (tools/planner/icons.js), local only
//   GET  /fonts/<file>.ttf             the Inter faces of addon/Polestar/Media/Fonts
//   GET  /media/<UI|Nav>/<name>.png    an addon texture (addon/Polestar/Media/*/<name>.tga)
//
// Commands that edit files run one at a time; a failing command answers
// { ok: false } and never stops the server.
//
// Only this machine's pages and tools may talk to it: every request must
// name the server itself in Host (127.0.0.1, localhost or [::1] at its port;
// else 421, against DNS rebinding), and a POST must be application/json with
// no Origin or our own (else 403): a cross-site JSON POST needs a preflight,
// which the 405 for OPTIONS fails, so another site cannot run commands. A GET
// that fetches from wago.tools (/icon/) is refused (403) when the browser
// says another site asked for it (Sec-Fetch-Site other than same-origin or
// none), and no answer may be framed by another page (X-Frame-Options DENY,
// Content-Security-Policy frame-ancestors 'none').

const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const commands = require('./commands');
const { PlannerError } = require('./workspace');
const { version } = require('../../package.json');
const glyphs = require('./glyphs');
const { openIcons, keyOf, KINDS } = require('./icons');
const roads = require('../lib/nav/layers/roads');
const { HUBS_FILE } = require('../lib/nav/layers/hubs');

const PUBLIC = path.join(__dirname, 'public');
const TYPES = {
	'.html': 'text/html; charset=utf-8', '.js': 'text/javascript; charset=utf-8', '.mjs': 'text/javascript; charset=utf-8', '.css': 'text/css; charset=utf-8',
	'.json': 'application/json; charset=utf-8', '.svg': 'image/svg+xml', '.png': 'image/png', '.ttf': 'font/ttf', '.woff2': 'font/woff2', '.ico': 'image/x-icon',
};
const HEARTBEAT_MS = 20000;
const TILE_CACHE = 'max-age=604800';
const FONTS = path.join(__dirname, '..', '..', 'addon', 'Polestar', 'Media', 'Fonts');
// The Inter faces shipped with the addon, read once.
const FONT_FILES = new Set(fs.readdirSync(FONTS).filter((f) => /^[A-Za-z0-9-]+\.ttf$/.test(f)));

function body(req, limit = 4 << 20) {
	return new Promise((resolve, reject) => {
		let size = 0;
		const chunks = [];
		req.on('data', (c) => {
			size += c.length;
			if (size > limit) {
				reject(new Error('request too large'));
				req.destroy();
			} else chunks.push(c);
		});
		req.on('end', () => {
			const text = Buffer.concat(chunks).toString('utf8');
			try {
				resolve(text ? JSON.parse(text) : {});
			} catch (err) {
				reject(err);
			}
		});
		req.on('error', reject);
	});
}

// Every answer: no other page may frame the planner (against clickjacking its edit buttons).
const FRAMING = { 'x-frame-options': 'DENY', 'content-security-policy': "frame-ancestors 'none'" };

function send(res, status, type, data, cache = 'no-store', extra = {}) {
	res.writeHead(status, { 'content-type': type, 'cache-control': cache, ...FRAMING, ...extra });
	res.end(data);
}
const json = (res, status, value) => send(res, status, 'application/json; charset=utf-8', JSON.stringify(value));

// A JSON answer, gzipped when large and the client takes gzip (a timeline is megabytes).
function jsonFor(req, res, status, value) {
	const text = JSON.stringify(value);
	if (text.length < 16384 || !/\bgzip\b/.test(req.headers['accept-encoding'] || '')) return send(res, status, 'application/json; charset=utf-8', text);
	return send(res, status, 'application/json; charset=utf-8', zlib.gzipSync(text, { level: 4 }), 'no-store', { 'content-encoding': 'gzip', vary: 'accept-encoding' });
}

// A file under dir (rel from the URL); false when it is not one (or leaves dir).
function staticFile(res, dir, rel, cache = 'no-cache', extra = {}, type = null) {
	const file = path.resolve(dir, rel);
	if (!file.startsWith(dir + path.sep)) return false;
	let stat;
	try {
		stat = fs.statSync(file);
	} catch {
		return false;
	}
	if (!stat.isFile()) return false;
	send(res, 200, type || TYPES[path.extname(file)] || 'application/octet-stream', fs.readFileSync(file), cache, extra);
	return true;
}

// opts: { port, host, workspace, artDir, icons (an openIcons() service;
// default the local one under data/local/planner/icons), roadsDir (the roads
// layer, default data/local/nav-layers/roads), hubsFile (the hubs layer,
// default data/local/nav-layers/hubs.json), log } -> { server, url, port, close }
async function startServer(opts = {}) {
	const { port = 8078, host = '127.0.0.1', workspace: ws, artDir = ws ? ws.artDir : null, icons = openIcons(), roadsDir = roads.ROADS_DIR, hubsFile = HUBS_FILE, log = () => {} } = opts;
	if (!ws) throw new Error('startServer needs a workspace');
	const art = artDir ? path.resolve(artDir) : null;
	const clients = new Set();
	let busy = Promise.resolve();

	// One mutating command at a time.
	function serial(fn) {
		const p = busy.then(fn, fn);
		busy = p.catch(() => {});
		return p;
	}

	function broadcast(event, data) {
		const chunk = `event: ${event}\ndata: ${JSON.stringify(data)}\n\n`;
		for (const res of clients) res.write(chunk);
	}
	const forward = ['changed', 'diagnostics', 'routing', 'focus', 'seek', 'play'].map((event) => {
		const fn = (data) => broadcast(event, data);
		ws.on(event, fn);
		return [event, fn];
	});
	const ctx = { clients: () => clients.size, icons };

	async function cmd(b) {
		const name = b && b.name;
		try {
			const c = commands.command(name);
			const call = () => commands.run(ws, name, b.args, ctx);
			const result = await (c.mutates ? serial(call) : call());
			return { ok: true, result: result === undefined ? null : result };
		} catch (err) {
			const known = err instanceof PlannerError;
			if (!known) log(`${name}: ${err && err.stack ? err.stack : err}`);
			return { ok: false, error: String((err && err.message) || err), code: known ? err.code : 'error' };
		}
	}

	function events(req, res) {
		res.writeHead(200, { 'content-type': 'text/event-stream; charset=utf-8', 'cache-control': 'no-store', connection: 'keep-alive', 'x-accel-buffering': 'no', ...FRAMING });
		res.write(`retry: 2000\nevent: hello\ndata: ${JSON.stringify({ version, packs: ws.packs.map((p) => p.id) })}\n\n`);
		clients.add(res);
		const beat = setInterval(() => res.write(`: ping ${Date.now()}\n\n`), HEARTBEAT_MS);
		req.on('close', () => {
			clearInterval(beat);
			clients.delete(res);
		});
	}

	function artFile(res, pathname) {
		let m;
		if (!art) return json(res, 404, { error: 'no map art: run node tools/polestar.js planner art' });
		if (pathname === '/art/index.json') {
			if (staticFile(res, art, 'index.json', 'no-cache')) return undefined;
			return json(res, 404, { error: 'no map art: run node tools/polestar.js planner art' });
		}
		if ((m = /^\/art\/tiles\/(\d+)\/(\d+)\/(\d+)_(\d+)\.bc1$/.exec(pathname))) {
			const rel = path.join('tiles', m[1], m[2], `${m[3]}_${m[4]}.bc1.gz`);
			if (staticFile(res, art, rel, TILE_CACHE, { 'content-encoding': 'gzip' }, 'application/octet-stream')) return undefined;
			return json(res, 404, { error: 'no such tile' });
		}
		if ((m = /^\/art\/zones\/(\d+)\.png$/.exec(pathname))) {
			if (staticFile(res, art, path.join('zones', `${m[1]}.png`), TILE_CACHE)) return undefined;
			return json(res, 404, { error: 'no art for that zone' });
		}
		return json(res, 404, { error: 'not found' });
	}

	// The navigation grid's overlays.
	function navFile(req, res, pathname) {
		let m;
		if (pathname === '/nav/index.json') {
			const nav = ws.navRoutes();
			const info = nav ? nav.info() : null;
			if (!info || !info.available) return json(res, 404, { error: 'no navigation grid: run node tools/polestar.js nav build' });
			const continents = Object.fromEntries(Object.entries(nav.index.continents).map(([c, v]) => [c, v.tiles || []]));
			return jsonFor(req, res, 200, { build: info.build, continents });
		}
		if (pathname === '/nav/aids.json') {
			const aids = ws.navAids();
			return aids ? jsonFor(req, res, 200, aids) : json(res, 404, { error: 'no arrow aids: run node tools/polestar.js nav aids' });
		}
		if ((m = /^\/nav\/tile\/(\d+)\/(\d+)_(\d+)\.png$/.exec(pathname))) {
			const nav = ws.navRoutes();
			const data = nav ? nav.walkable(Number(m[1]), Number(m[2]), Number(m[3])) : null;
			return data ? send(res, 200, 'image/png', data, 'no-cache') : json(res, 404, { error: 'no such nav tile' });
		}
		if (pathname === '/nav/roads/index.json') {
			const file = path.join(roadsDir, 'index.json');
			return fs.existsSync(file) ? jsonFor(req, res, 200, JSON.parse(fs.readFileSync(file, 'utf8'))) : json(res, 404, { error: 'no roads layer: run node tools/polestar.js nav layers roads' });
		}
		if ((m = /^\/nav\/roads\/tile\/(\d+)\/(\d+)_(\d+)\.png$/.exec(pathname))) {
			const w = roads.roadWeights(Number(m[1]), Number(m[2]), Number(m[3]), roadsDir);
			return w ? send(res, 200, 'image/png', roads.roadsPng(w), 'no-cache') : json(res, 404, { error: 'no such roads tile' });
		}
		if (pathname === '/nav/hubs.json') {
			if (!fs.existsSync(hubsFile)) return json(res, 404, { error: 'no hubs layer: run node tools/polestar.js nav layers hubs' });
			const doc = JSON.parse(fs.readFileSync(hubsFile, 'utf8'));
			const out = {};
			for (const c of doc.maps || []) out[c] = doc[c] || [];
			return jsonFor(req, res, 200, out);
		}
		return json(res, 404, { error: 'not found' });
	}

	const png = (res, data) => send(res, 200, 'image/png', data, TILE_CACHE);
	// Polestar's own art (/glyph, /emblem, /band) and the addon's fonts and textures.
	function ownArt(res, pathname, url) {
		let m;
		if ((m = /^\/glyph\/([a-z0-9-]+)\.png$/.exec(pathname))) {
			const data = glyphs.renderGlyph(m[1], url.searchParams.get('px') ?? undefined);
			return data ? png(res, data) : json(res, 404, { error: `no glyph "${m[1]}"` });
		}
		if (pathname === '/emblem.png') return png(res, glyphs.renderEmblem(url.searchParams.get('px') ?? undefined));
		if (pathname === '/band.png') return png(res, glyphs.renderBand().band);
		if (pathname === '/band-stars.png') return png(res, glyphs.renderBand().stars);
		if ((m = /^\/fonts\/([A-Za-z0-9-]+\.ttf)$/.exec(pathname)) && FONT_FILES.has(m[1])) {
			return send(res, 200, 'font/ttf', fs.readFileSync(path.join(FONTS, m[1])), TILE_CACHE);
		}
		if ((m = /^\/media\/(UI|Nav)\/([a-z0-9-]+)\.png$/.exec(pathname))) {
			const data = glyphs.mediaPng(m[1], m[2]);
			if (data) return png(res, data);
		}
		return json(res, 404, { error: 'not found' });
	}

	// /icon/<kind>/<key>.png: the key checked per kind (icons.keyOf), so no path reaches the disk unchecked.
	async function gameIcon(res, pathname) {
		const m = /^\/icon\/([a-z]+)\/([^/]+)\.png$/.exec(pathname);
		let key = null;
		try {
			key = m ? decodeURIComponent(m[2]) : null;
		} catch {
			key = null;
		}
		if (!m || !KINDS.includes(m[1])) return json(res, 404, { error: `no icon kind "${m ? m[1] : pathname}" (kinds: ${KINDS.join(', ')})` });
		if (!keyOf(m[1], key)) return json(res, 400, { error: `bad ${m[1]} key "${key}"` });
		if (!icons) return json(res, 404, { error: 'no icons' });
		let data;
		try {
			data = await icons.icon(m[1], key);
		} catch (err) {
			return json(res, 502, { error: `icon ${m[1]}:${key}: ${err.message || err}` });
		}
		return data ? png(res, data) : json(res, 404, { error: `no icon for ${m[1]}:${key}` });
	}

	// Host names this server answers to (set once it listens and knows its port).
	let own = new Set();
	const JSON_TYPE = /^application\/json\s*(;|$)/i;
	// GETs that may fetch from wago.tools.
	const REMOTE_GET = /^\/icon\//;
	// Why a request is refused ([status, message]), or null.
	function refused(req) {
		const hostHeader = String(req.headers.host || '').toLowerCase();
		if (!own.has(hostHeader)) return [421, `this planner answers to ${[...own][0]} only, not Host "${hostHeader}"`];
		if (req.method === 'GET' || req.method === 'HEAD') {
			// A GET that fetches remotely: only for our own page or a tool (no Sec-Fetch-Site).
			const site = req.headers['sec-fetch-site'];
			if (site !== undefined && site !== 'same-origin' && site !== 'none' && REMOTE_GET.test(new URL(req.url, 'http://localhost').pathname)) return [403, `a ${site} request for ${req.url} is refused`];
			return null;
		}
		const origin = req.headers.origin;
		if (origin !== undefined && !own.has(String(origin).toLowerCase().replace(/^http:\/\//, ''))) return [403, `requests from ${origin} are refused`];
		if (!JSON_TYPE.test(String(req.headers['content-type'] || ''))) return [403, 'requests must be application/json'];
		return null;
	}

	const server = http.createServer(async (req, res) => {
		try {
			const no = refused(req);
			if (no) {
				req.resume();
				return json(res, no[0], { ok: false, error: no[1], code: 'forbidden' });
			}
			const url = new URL(req.url, 'http://localhost');
			const p = url.pathname;
			if (req.method === 'POST' && p === '/api/cmd') return jsonFor(req, res, 200, await cmd(await body(req)));
			if (req.method === 'POST' && p === '/api/view') return json(res, 200, { ok: true, result: ws.setView(await body(req)) });
			if (req.method !== 'GET' && req.method !== 'HEAD') return json(res, 405, { error: 'method not allowed' });
			if (p === '/api/commands') return jsonFor(req, res, 200, commands.describe());
			if (p === '/api/events') return events(req, res);
			if (p.startsWith('/art/')) return artFile(res, p);
			if (p.startsWith('/nav/')) return navFile(req, res, p);
			if (p.startsWith('/icon/')) return await gameIcon(res, p);
			if (/^\/(glyph|fonts|media)\//.test(p) || p === '/emblem.png' || p === '/band.png' || p === '/band-stars.png') return ownArt(res, p, url);
			const rel = p === '/' ? 'index.html' : decodeURIComponent(p.slice(1));
			if (!rel.includes('\0') && staticFile(res, PUBLIC, rel)) return undefined;
			return json(res, 404, { error: 'not found' });
		} catch (err) {
			log(`request failed: ${err.stack || err}`);
			if (!res.headersSent) json(res, err instanceof SyntaxError ? 400 : 500, { ok: false, error: String(err.message || err) });
			else res.end();
		}
		return undefined;
	});

	await new Promise((resolve, reject) => {
		server.once('error', reject);
		server.listen(port, host, resolve);
	});
	const address = server.address();
	own = new Set([`127.0.0.1:${address.port}`, `localhost:${address.port}`, `[::1]:${address.port}`, `${host.toLowerCase()}:${address.port}`]);
	const url = `http://${host === '0.0.0.0' ? '127.0.0.1' : host}:${address.port}/`;

	async function close() {
		for (const [event, fn] of forward) ws.off(event, fn);
		for (const res of clients) res.end();
		clients.clear();
		await new Promise((resolve) => {
			server.close(() => resolve());
			server.closeAllConnections();
		});
		await busy.catch(() => {});
	}

	return { server, url, port: address.port, close };
}

module.exports = { startServer, PUBLIC };
