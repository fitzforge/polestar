'use strict';
// The studio page (polestar studio --serve): the scenarios and their shots
// on the left, the picked shot's render on the right, re-rendered whenever
// the addon's Lua or XML (addon/Polestar), a scenario or the studio's client
// changes. Local only: it binds 127.0.0.1.
//
//   GET /                         the page
//   GET /api/shots                [{ scenario, title, shots: [{ name, title }] }]
//   GET /shot/<scenario>/<shot>   the render (PNG, else SVG), made when missing or stale
//   GET /shot/.../closeup         its close-up
//   GET /events                   server-sent events: "changed" after a source change,
//                                 "rendered <scenario>/<shot>" when a render is done

const fs = require('node:fs');
const http = require('node:http');
const path = require('node:path');

const studio = require('./studio');

const PAGE = `<!doctype html>
<html><head><meta charset="utf-8"><title>Polestar studio</title>
<style>
body { margin: 0; display: flex; height: 100vh; font: 14px system-ui, sans-serif; background: #0b0d12; color: #d8dbe2; }
nav { width: 320px; overflow: auto; border-right: 1px solid #222632; padding: 12px; box-sizing: border-box; }
nav h2 { font-size: 13px; color: #e8c06a; margin: 14px 0 4px; }
nav a { display: block; padding: 4px 8px; color: #b9c0cf; text-decoration: none; border-radius: 4px; cursor: pointer; }
nav a.on, nav a:hover { background: #1c2130; color: #fff; }
main { flex: 1; overflow: auto; padding: 12px; }
#state { color: #8a91a3; margin-bottom: 8px; }
img { max-width: 100%; display: block; margin-bottom: 12px; border: 1px solid #222632; }
label { color: #8a91a3; }
</style></head><body>
<nav id="list"></nav>
<main><div id="state">Pick a shot.</div><label><input type="checkbox" id="full"> whole screen</label><div id="view"></div></main>
<script>
let current = null, stamp = 0;
const $ = (id) => document.getElementById(id);
async function load() {
	const list = await (await fetch('/api/shots')).json();
	$('list').innerHTML = list.map((s) => '<h2>' + s.scenario + '</h2><div style="color:#7b8294;font-size:12px;padding:0 8px">' + s.title + '</div>'
		+ s.shots.map((x) => '<a data-k="' + s.scenario + '/' + x.name + '" title="' + x.title.replace(/"/g, '&quot;') + '">' + x.name + '</a>').join('')).join('');
	for (const a of document.querySelectorAll('nav a')) a.onclick = () => pick(a.dataset.k);
	const k = location.hash.slice(1);
	if (k) pick(k);
}
function show() {
	if (!current) return;
	stamp++;
	$('state').textContent = 'Rendering ' + current + '…';
	const src = '/shot/' + current + ($('full').checked ? '' : '/closeup') + '?' + stamp;
	const img = new Image();
	img.onload = () => { $('view').replaceChildren(img); $('state').textContent = current + ' (' + new Date().toLocaleTimeString() + ')'; };
	img.onerror = () => { $('state').textContent = current + ': render failed (see the terminal)'; };
	img.src = src;
}
function pick(k) {
	current = k;
	location.hash = k;
	for (const a of document.querySelectorAll('nav a')) a.classList.toggle('on', a.dataset.k === k);
	show();
}
$('full').onchange = show;
new EventSource('/events').addEventListener('changed', show);
load();
</script></body></html>`;

// opts: { port, outDir, world, offline, stubsDir, only: [scenario names] }
async function serve(opts) {
	const { ADDONS } = require('../../tests/helpers/lua');
	let version = 0;
	const made = new Map(); // "scenario/shot" -> { version, result }
	const clients = new Set();
	let queue = Promise.resolve();
	const log = (m) => console.log(`[studio] ${m}`);

	const names = () => (opts.only && opts.only.length ? opts.only.map((n) => n.split('/')[0]) : studio.listScenarios());
	function render(name, shot) {
		const key = `${name}/${shot}`;
		const have = made.get(key);
		if (have && have.version === version) return Promise.resolve(have.result);
		const job = queue.then(async () => {
			const again = made.get(key);
			if (again && again.version === version) return again.result;
			const v = version;
			const result = await studio.runShot(studio.loadScenario(name), shot, { ...opts, log });
			made.set(key, { version: v, result });
			for (const res of clients) res.write(`event: rendered\ndata: ${key}\n\n`);
			return result;
		});
		queue = job.catch(() => {});
		return job;
	}

	// A change to the addon, the scenarios or the studio's client: every render is stale.
	let timer = null;
	const changed = (what) => {
		clearTimeout(timer);
		timer = setTimeout(() => {
			version++;
			log(`changed (${what}): renders are stale`);
			for (const res of clients) res.write('event: changed\ndata: \n\n');
		}, 300);
	};
	const watchers = [
		fs.watch(path.join(ADDONS, 'Polestar'), { recursive: true }, (_, f) => { if (/\.(lua|xml|toc)$/.test(f || '')) changed(f); }),
		fs.watch(studio.SCENARIOS, (_, f) => changed(f)),
		fs.watch(path.join(__dirname, 'client.lua'), () => changed('client.lua')),
	];

	const server = http.createServer(async (req, res) => {
		const url = new URL(req.url, 'http://127.0.0.1');
		try {
			if (url.pathname === '/') {
				res.writeHead(200, { 'content-type': 'text/html; charset=utf-8' });
				return res.end(PAGE);
			}
			if (url.pathname === '/api/shots') {
				const list = names().map((n) => {
					const sc = studio.loadScenario(n);
					return { scenario: n, title: sc.title, shots: Object.entries(sc.shots).map(([k, s]) => ({ name: k, title: s.title || '' })) };
				});
				res.writeHead(200, { 'content-type': 'application/json' });
				return res.end(JSON.stringify(list));
			}
			if (url.pathname === '/events') {
				res.writeHead(200, { 'content-type': 'text/event-stream', 'cache-control': 'no-cache', connection: 'keep-alive' });
				res.write(': studio\n\n');
				clients.add(res);
				req.on('close', () => clients.delete(res));
				return undefined;
			}
			const m = /^\/shot\/([\w-]+)\/([\w-]+)(\/closeup)?$/.exec(url.pathname);
			if (m) {
				const r = await render(m[1], m[2]);
				const file = m[3] ? (r.closeup || r.png || r.svg) : (r.png || r.svg);
				res.writeHead(200, { 'content-type': file.endsWith('.png') ? 'image/png' : 'image/svg+xml', 'cache-control': 'no-store' });
				return fs.createReadStream(file).pipe(res);
			}
			res.writeHead(404);
			return res.end();
		} catch (err) {
			log(err.message);
			res.writeHead(500, { 'content-type': 'text/plain' });
			return res.end(err.message);
		}
	});
	await new Promise((resolve) => server.listen(opts.port, '127.0.0.1', resolve));
	const url = `http://127.0.0.1:${server.address().port}/`;
	return {
		url,
		close() {
			for (const w of watchers) w.close();
			for (const res of clients) res.end();
			server.close();
		},
	};
}

module.exports = { serve };
