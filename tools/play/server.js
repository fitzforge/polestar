'use strict';
// The playground's HTTP server (node tools/polestar.js play): the page in
// tools/play/public, and a JSON API over one Session (tools/play/session.js).
// Local only: it binds 127.0.0.1 and serves client art from the local cache.
//
//   GET  /                     the page (and its files)
//   GET  /api/meta             races, classes, zones (with art), screen size, the version /api/version serves
//   GET  /api/guides           every registered guide's header
//   GET  /api/version          { version }: moves once each time reload() (a rebuild) restarts the session
//   POST /api/act              { action, known } -> a frame (svg, glyphs, hits, state, errors, timing)
//   POST /api/character        { race, cls, faction } -> a new character (a relog)
//   POST /api/eui              { on } -> EllesmereUI installed or not (a relog)
//   POST /api/reload           save SavedVariables and reload the UI
//   POST /api/restart          start the Lua session again, without saving
//   GET  /tex/<hash>.png       a tinted texture crop the frame's SVG uses
//   GET  /zoneart/<map>.png    a zone's painting from the local art cache
//   GET  /fonts/<file>.ttf     the addon's Inter faces, for the page itself
//
// A Lua error is reported in the frame (the client's error frame); a crashed
// or hung Lua process is restarted and the page told so. Nothing a request
// does can stop the server.

const http = require('node:http');
const fs = require('node:fs');
const path = require('node:path');
const { Session, sharedData, CLASS_NAMES, RACE_NAMES, SCREEN } = require('./session');

const { ROOT } = require('../lib/paths');
const PUBLIC = path.join(__dirname, 'public');
const FONTS = path.join(ROOT, 'addon', 'Polestar', 'Media', 'Fonts');
const TYPES = { '.html': 'text/html; charset=utf-8', '.js': 'text/javascript; charset=utf-8', '.css': 'text/css; charset=utf-8', '.svg': 'image/svg+xml', '.png': 'image/png', '.ttf': 'font/ttf' };
const SAVE_EVERY_MS = 5000;

function readConfig(dataDir) {
	try {
		return JSON.parse(fs.readFileSync(path.join(dataDir, 'config.json'), 'utf8'));
	} catch {
		return {};
	}
}

function writeConfig(dataDir, config) {
	fs.mkdirSync(dataDir, { recursive: true });
	fs.writeFileSync(path.join(dataDir, 'config.json'), JSON.stringify(config, null, '\t') + '\n');
}

function body(req, limit = 1 << 20) {
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

function send(res, status, type, data, cache = 'no-store') {
	res.writeHead(status, { 'content-type': type, 'cache-control': cache });
	res.end(data);
}
const json = (res, status, value) => send(res, status, 'application/json; charset=utf-8', JSON.stringify(value));

function staticFile(res, dir, rel) {
	const file = path.join(dir, rel);
	if (!file.startsWith(dir + path.sep) || !fs.existsSync(file) || !fs.statSync(file).isFile()) return false;
	send(res, 200, TYPES[path.extname(file)] || 'application/octet-stream', fs.readFileSync(file), dir === FONTS ? 'max-age=86400' : 'no-cache');
	return true;
}

// opts: { port, host, dataDir, artDir, fresh, packs, log }; packs: other guide
// packs' built folders, loaded after ours (see Session).
// -> { server, url, port, session, reload, close }: reload({ packs?, why? })
// saves, restarts the Lua session (with the new pack folders when given) and
// tells the page on its next frame; `polestar dev` calls it after a rebuild.
async function startServer(opts = {}) {
	const { port = 8077, host = '127.0.0.1', dataDir = path.join(ROOT, 'data', 'play'), artDir = null, fresh = false, packs = [], log = () => {} } = opts;
	if (fresh) fs.rmSync(dataDir, { recursive: true, force: true });
	fs.mkdirSync(dataDir, { recursive: true });
	let config = readConfig(dataDir);
	const session = new Session({ dataDir, artDir, config, packs, log });
	await session.start();
	let notice = null; // what the next frame tells the page (a restart, its reason)
	let busy = Promise.resolve();
	// Moves only when reload() restarted the session: the page redraws on a
	// change, so a failed restart must not move it (that would loop).
	let rebuilds = 0;

	// Restart the Lua session: saving first unless it is gone.
	async function relog({ save = true, why = null } = {}) {
		if (save) await session.save({ logout: true }).catch(() => {});
		session.kill();
		session.config = config;
		await session.start();
		if (why) notice = why;
	}

	async function frame(action, known) {
		let out = await session.act(action, known);
		if (out.crashed) {
			const why = `The Lua session stopped (${out.error.split('\n')[0]}); it was restarted from the last save.`;
			log(why);
			await relog({ save: false });
			out = await session.act({ type: 'render' }, 0);
			out.notice = why;
		} else if (out.failed) {
			const err = out.error;
			out = await session.act({ type: 'render' }, known);
			out.actionError = err;
		}
		if (notice) {
			out.notice = notice;
			notice = null;
		}
		if (Date.now() - session.lastSave > SAVE_EVERY_MS) await session.save().catch(() => {});
		return out;
	}

	// One request at a time touches the session.
	function serial(fn) {
		const p = busy.then(fn, fn);
		busy = p.catch(() => {});
		return p;
	}

	const handlers = {
		'GET /api/meta': async () => {
			const d = sharedData();
			const art = session.art;
			return {
				screen: SCREEN, races: d.races, raceNames: RACE_NAMES, classNames: CLASS_NAMES,
				zones: d.zones.map((z) => ({ ...z, art: !!art[z.id] })).sort((a, b) => a.name.localeCompare(b.name)),
				art: !!session.artDir, config, startMs: session.startMs, version: rebuilds,
				emblem: session.textures.uri('emblem', [0.31, 0.82, 0.77, 1]), stars: session.textures.uri('band-stars', [1, 1, 1, 1]),
			};
		},
		// Cheap and not queued: the page polls it to redraw after a rebuild.
		'GET /api/version': () => ({ version: rebuilds }),
		'GET /api/guides': () => serial(async () => {
			const r = await session.call(`local out = {}
for i, h in ipairs(Polestar.Guides.List()) do
	out[i] = { id = h.id, title = h.title, faction = h.faction, lo = h.minLevel, hi = h.maxLevel, cat = h.category or "Leveling", races = h.races, classes = h.classes }
end
return out`);
			return r.ok ? r.value : [];
		}),
		'POST /api/act': (b) => serial(() => frame(b.action || { type: 'render' }, Number(b.known) || 0)),
		'POST /api/character': (b) => serial(async () => {
			const races = sharedData().races;
			const race = races[b.race] ? b.race : 'Human';
			const faction = races[race][b.faction] ? b.faction : Object.keys(races[race])[0];
			const cls = races[race][faction].classes.includes(b.cls) ? b.cls : races[race][faction].classes[0];
			await session.save({ logout: true }).catch(() => {});
			session.kill();
			// A new character: their world and per-character variables start over;
			// the account's settings (PolestarDB) carry over.
			fs.rmSync(path.join(dataDir, 'world.lua'), { force: true });
			fs.rmSync(path.join(dataDir, 'Character'), { recursive: true, force: true });
			config = { ...config, race, cls, faction };
			writeConfig(dataDir, config);
			await relog({ save: false, why: `New character: a level 1 ${RACE_NAMES[race]} ${CLASS_NAMES[cls]} (${faction}).` });
			return frame({ type: 'render' }, 0);
		}),
		'POST /api/eui': (b) => serial(async () => {
			config = { ...config, eui: !!b.on };
			writeConfig(dataDir, config);
			await relog({ why: b.on ? 'EllesmereUI installed; UI reloaded.' : 'EllesmereUI removed; UI reloaded.' });
			return frame({ type: 'render' }, 0);
		}),
		'POST /api/reload': () => serial(async () => {
			await relog({ why: 'UI reloaded (SavedVariables written and read back).' });
			return frame({ type: 'render' }, 0);
		}),
		'POST /api/restart': () => serial(async () => {
			await relog({ save: false, why: 'Session restarted from the last save.' });
			return frame({ type: 'render' }, 0);
		}),
	};

	const server = http.createServer(async (req, res) => {
		try {
			const url = new URL(req.url, 'http://localhost');
			const key = `${req.method} ${url.pathname}`;
			if (handlers[key]) {
				const b = req.method === 'POST' ? await body(req) : {};
				return json(res, 200, await handlers[key](b));
			}
			if (req.method !== 'GET') return json(res, 404, { error: 'not found' });
			let m;
			if ((m = /^\/tex\/([0-9a-f]{16})\.png$/.exec(url.pathname))) {
				const buf = session.texture(m[1]);
				return buf ? send(res, 200, 'image/png', buf, 'max-age=86400') : json(res, 404, { error: 'no texture' });
			}
			if ((m = /^\/zoneart\/(\d+)\.png$/.exec(url.pathname))) {
				const buf = session.zoneArt(Number(m[1]));
				return buf ? send(res, 200, 'image/png', buf, 'max-age=86400') : json(res, 404, { error: 'no art' });
			}
			if ((m = /^\/fonts\/([\w-]+\.ttf)$/.exec(url.pathname)) && staticFile(res, FONTS, m[1])) return undefined;
			const rel = url.pathname === '/' ? 'index.html' : decodeURIComponent(url.pathname.slice(1));
			if (staticFile(res, PUBLIC, rel)) return undefined;
			return json(res, 404, { error: 'not found' });
		} catch (err) {
			log(`request failed: ${err.stack || err}`);
			if (!res.headersSent) json(res, 500, { error: String(err.message || err) });
			else res.end();
		}
		return undefined;
	});

	try {
		await new Promise((resolve, reject) => {
			server.once('error', reject);
			server.listen(port, host, resolve);
		});
	} catch (err) {
		// The port is taken (or not ours): the Lua session must not outlive the call.
		await session.stop({ save: false });
		throw err;
	}
	const address = server.address();
	const url = `http://${host === '0.0.0.0' ? '127.0.0.1' : host}:${address.port}/`;

	async function close({ save = true } = {}) {
		await new Promise((resolve) => {
			server.close(() => resolve());
			server.closeAllConnections();
		});
		await busy.catch(() => {});
		await session.stop({ save });
	}

	function reload({ packs: next = null, why = 'Community addon rebuilt; UI reloaded.' } = {}) {
		return serial(async () => {
			if (next) session.packs = next;
			await relog({ why });
			rebuilds++;
		});
	}

	return { server, url, port: address.port, session, reload, close };
}

module.exports = { startServer };
