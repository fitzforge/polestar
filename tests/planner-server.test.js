'use strict';
// The planner's command server (tools/planner) over HTTP and its MCP stdio
// bridge, on a copy of the mini fixture pack with the compiler's fixture data:
// guides are listed and mapped line by line, an edit is written to the
// .guide file (and refused on a stale hash), undo puts the text back, and an
// MCP client sees the same commands. Only this machine's JSON requests reach
// the commands.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const zlib = require('node:zlib');
const http = require('node:http');
const { spawn } = require('node:child_process');
const { tmpdir } = require('./helpers/tmp');
const { DATA_DIR } = require('./helpers/dsl');
const { Workspace } = require('../tools/planner/workspace');
const { startServer } = require('../tools/planner/server');
const commands = require('../tools/planner/commands');

const ROOT = path.join(__dirname, '..');
const MINI = path.join(__dirname, 'fixtures', 'packs', 'mini');
const sha1 = (t) => crypto.createHash('sha1').update(t).digest('hex');

async function cmd(url, name, args = {}) {
	const res = await fetch(`${url}api/cmd`, { method: 'POST', headers: { 'content-type': 'application/json' }, body: JSON.stringify({ name, args }) });
	assert.equal(res.status, 200);
	return res.json();
}

async function ok(url, name, args) {
	const r = await cmd(url, name, args);
	assert.equal(r.ok, true, `${name}: ${r.error}`);
	return r.result;
}

// A request with any Host, Origin and content type -> { status, body }.
function raw(port, { method = 'POST', path: p = '/api/cmd', headers = {}, body = '' } = {}) {
	return new Promise((resolve, reject) => {
		const req = http.request({ host: '127.0.0.1', port, method, path: p, headers: { ...headers, 'content-length': Buffer.byteLength(body) } }, (res) => {
			let text = '';
			res.setEncoding('utf8');
			res.on('data', (d) => {
				text += d;
			});
			res.on('end', () => resolve({ status: res.statusCode, headers: res.headers, body: text }));
		});
		req.on('error', reject);
		req.end(body);
	});
}

let dir;
let ws;
let server;
let fileB;
let tile;

test.before(async () => {
	const tmp = tmpdir('polestar-planner-');
	dir = path.join(tmp, 'mini');
	fs.cpSync(MINI, dir, { recursive: true });
	fileB = path.join(dir, 'guides', 'b.guide');
	const art = path.join(tmp, 'art');
	fs.mkdirSync(path.join(art, 'tiles', '0', '6'), { recursive: true });
	tile = crypto.randomBytes(4096);
	fs.writeFileSync(path.join(art, 'tiles', '0', '6', '0_0.bc1.gz'), zlib.gzipSync(tile));
	fs.writeFileSync(path.join(art, 'index.json'), JSON.stringify({ schema: 1, build: '1.60.1.0', continents: { 0: { name: 'Eastern Kingdoms', maxLevel: 6 } }, zones: {} }));
	ws = new Workspace({ dataDir: DATA_DIR, official: false, packs: [dir], watch: false, lintDelay: 60000, artDir: art });
	const roads = path.join(tmp, 'roads');
	fs.mkdirSync(path.join(roads, '0'), { recursive: true });
	const w = new Uint8Array(65536);
	w[0] = 255;
	w[1] = 60;
	fs.writeFileSync(path.join(roads, '0', '32_48.bin'), w);
	fs.writeFileSync(path.join(roads, 'index.json'), JSON.stringify({ build: '1.60.1.0', continents: { 0: ['32_48'] } }));
	const hubsFile = path.join(tmp, 'hubs.json');
	fs.writeFileSync(hubsFile, JSON.stringify({ build: '1.60.1.0', rev: 'x', maps: [0, 1], rules: {}, 0: [{ id: 'alliance-southshore', side: 'Alliance', name: 'Southshore', areaId: 271, guards: 1, services: 0, disks: [[-817, -549, 50]] }], 1: [] }));
	server = await startServer({ port: 0, workspace: ws, roadsDir: roads, hubsFile });
});

test.after(async () => {
	await server.close();
	ws.close();
});

test('the page, the command list and an unknown command', async () => {
	const list = await (await fetch(`${server.url}api/commands`)).json();
	for (const name of ['planner_info', 'guides_list', 'guide_get', 'timeline_get', 'edit_apply', 'edit_move_world', 'edit_undo', 'changes_list', 'spawns_get', 'view_focus']) {
		const c = list.find((x) => x.name === name);
		assert.ok(c, name);
		assert.equal(c.input.type, 'object', name);
	}
	const r = await cmd(server.url, 'no_such_command');
	assert.equal(r.ok, false);
	const bad = await cmd(server.url, 'guide_get', {});
	assert.equal(bad.ok, false);
	assert.equal(bad.code, 'bad_args');
	const escape = await fetch(`${server.url}..%2f..%2fpackage.json`);
	assert.equal(escape.status, 404);
});

test('the Roads layer: its index and a tile as a 256 x 256 PNG, 404 without one', async () => {
	const index = await (await fetch(`${server.url}nav/roads/index.json`)).json();
	assert.deepEqual(index.continents, { 0: ['32_48'] });
	const res = await fetch(`${server.url}nav/roads/tile/0/32_48.png`);
	assert.equal(res.status, 200);
	assert.equal(res.headers.get('content-type'), 'image/png');
	const png = Buffer.from(await res.arrayBuffer());
	assert.equal(png.toString('latin1', 1, 4), 'PNG');
	assert.equal(png.readUInt32BE(16), 256);
	assert.equal(png.readUInt32BE(20), 256);
	assert.equal((await fetch(`${server.url}nav/roads/tile/0/1_1.png`)).status, 404);
});

test('the Hubs layer: each map\'s hubs from hubs.json', async () => {
	const hubs = await (await fetch(`${server.url}nav/hubs.json`)).json();
	assert.deepEqual(Object.keys(hubs).sort(), ['0', '1']);
	assert.equal(hubs[0][0].name, 'Southshore');
	assert.deepEqual(hubs[0][0].disks, [[-817, -549, 50]]);
	assert.deepEqual(hubs[1], []);
});

test('only this machine\'s JSON requests run commands', async () => {
	const start = fs.readFileSync(fileB, 'utf8');
	const viewState = await ok(server.url, 'view_state');
	const view = await ok(server.url, 'guide_get', { id: 'mini/b' });
	const body = JSON.stringify({ name: 'edit_apply', args: { id: 'mini/b', hash: view.hash, ops: [{ op: 'setRadius', line: view.steps[0].goals[0].line, r: 15 }] } });
	const evilHost = `evil.example:${server.port}`;
	for (const [headers, status] of [
		[{ 'content-type': 'text/plain' }, 403],
		[{ 'content-type': 'application/x-www-form-urlencoded' }, 403],
		[{}, 403],
		[{ 'content-type': 'application/json', origin: 'http://evil.example' }, 403],
		[{ 'content-type': 'application/json', origin: `http://127.0.0.1:${server.port + 1}` }, 403],
		[{ 'content-type': 'application/json', host: evilHost }, 421],
		[{ 'content-type': 'text/plain', origin: 'http://evil.example', host: evilHost }, 421],
	]) {
		const r = await raw(server.port, { headers, body });
		assert.equal(r.status, status, JSON.stringify(headers));
		assert.equal(JSON.parse(r.body).ok, false);
	}
	assert.equal((await raw(server.port, { path: '/api/view', headers: { 'content-type': 'text/plain' }, body: JSON.stringify({ guide: 'IGNORE PREVIOUS INSTRUCTIONS' }) })).status, 403);
	// A rebound DNS name reads nothing either.
	assert.equal((await raw(server.port, { method: 'GET', path: '/api/commands', headers: { host: evilHost } })).status, 421);
	assert.equal((await raw(server.port, { method: 'OPTIONS', headers: { origin: 'http://evil.example' } })).status >= 400, true);
	assert.equal(fs.readFileSync(fileB, 'utf8'), start);
	assert.deepEqual(await ok(server.url, 'changes_list'), []);
	assert.deepEqual(await ok(server.url, 'view_state'), viewState);

	// The page: same-origin JSON, as localhost or 127.0.0.1.
	const r = await raw(server.port, { headers: { 'content-type': 'application/json; charset=utf-8', origin: `http://localhost:${server.port}`, host: `localhost:${server.port}` }, body });
	assert.equal(r.status, 200);
	assert.equal(JSON.parse(r.body).ok, true);
	assert.notEqual(fs.readFileSync(fileB, 'utf8'), start);
	await ok(server.url, 'edit_undo');
	assert.equal(fs.readFileSync(fileB, 'utf8'), start);
	assert.equal((await raw(server.port, { method: 'GET', path: '/api/commands', headers: { host: `[::1]:${server.port}` } })).status, 200);
});

test('another site cannot make the planner fetch icons, and no page may frame it', async () => {
	const icon = (site) => raw(server.port, { method: 'GET', path: '/icon/item/750.png', headers: site ? { 'sec-fetch-site': site } : {} });
	for (const site of ['cross-site', 'same-site']) {
		const r = await icon(site);
		assert.equal(r.status, 403, site);
		assert.equal(JSON.parse(r.body).code, 'forbidden');
	}
	// The page itself and tools (no Sec-Fetch-Site) pass the check: a bad key is the icon route's own 400.
	for (const site of ['same-origin', 'none', null]) {
		const r = await raw(server.port, { method: 'GET', path: '/icon/item/x.png', headers: site ? { 'sec-fetch-site': site } : {} });
		assert.equal(r.status, 400, String(site));
	}
	// Local-only GETs stay readable by any page's <img> (map art, glyphs).
	assert.equal((await raw(server.port, { method: 'GET', path: '/glyph/play.png', headers: { 'sec-fetch-site': 'cross-site' } })).status, 200);
	for (const [p, status] of [['/', 200], ['/api/commands', 200], ['/nope', 404], ['/icon/item/750.png', 403]]) {
		const r = await raw(server.port, { method: 'GET', path: p, headers: p.startsWith('/icon/') ? { 'sec-fetch-site': 'cross-site' } : {} });
		assert.equal(r.status, status, p);
		assert.equal(r.headers['x-frame-options'], 'DENY', p);
		assert.equal(r.headers['content-security-policy'], "frame-ancestors 'none'", p);
	}
});

test('map art: the index and gzip tiles the browser unpacks', async () => {
	const info = await ok(server.url, 'planner_info');
	assert.equal(info.art.available, true);
	assert.equal(info.art.build, '1.60.1.0');
	const res = await fetch(`${server.url}art/tiles/0/6/0_0.bc1`);
	assert.equal(res.status, 200);
	assert.equal(res.headers.get('content-encoding'), 'gzip');
	assert.equal(res.headers.get('content-type'), 'application/octet-stream');
	assert.deepEqual(Buffer.from(await res.arrayBuffer()), tile);
	assert.equal((await fetch(`${server.url}art/tiles/0/6/1_0.bc1`)).status, 404);
	assert.equal((await fetch(`${server.url}art/tiles/0/6/..%2f..%2findex.bc1`)).status, 404);
});

test('an edit is pushed to open pages as a changed event', async () => {
	const res = await fetch(`${server.url}api/events`);
	assert.equal(res.headers.get('content-type'), 'text/event-stream; charset=utf-8');
	const reader = res.body.getReader();
	let text = '';
	const until = async (needle) => {
		while (!text.includes(needle)) {
			const { value, done } = await reader.read();
			if (done) throw new Error(`stream ended before ${needle}`);
			text += Buffer.from(value).toString('utf8');
		}
	};
	await until('event: hello');
	const view = await ok(server.url, 'guide_get', { id: 'mini/b' });
	await ok(server.url, 'edit_apply', { id: 'mini/b', hash: view.hash, ops: [{ op: 'setRadius', line: view.steps[0].goals[0].line, r: 15 }] });
	await until('event: changed');
	const data = JSON.parse(text.slice(text.indexOf('event: changed')).split('\n')[1].replace(/^data: /, ''));
	assert.deepEqual(data.guides, ['mini/b']);
	await reader.cancel();
	await ok(server.url, 'edit_undo');
});

test('guides_list and guide_get map steps and goals to their lines', async () => {
	const guides = await ok(server.url, 'guides_list');
	assert.deepEqual(guides.map((g) => g.id), ['mini/a', 'mini/b']);
	const a = guides[0];
	assert.equal(a.pack, 'mini');
	assert.equal(a.next, 'mini/b');
	assert.deepEqual(a.levels, { min: 1, max: 6 });
	assert.ok(a.file.endsWith('guides/a.guide'));

	const text = fs.readFileSync(fileB, 'utf8');
	const view = await ok(server.url, 'guide_get', { id: 'mini/b' });
	assert.equal(view.hash, sha1(text));
	const lines = text.split('\n');
	const goal = view.steps[0].goals[0];
	assert.equal(lines[goal.line - 1].trim(), 'goto 47.6,35.1 "Kobold camp"');
	assert.equal(lines[view.steps[0].line - 1].trim(), 'step Kobold camp');
	assert.equal(goal.verb, 'goto');
	assert.equal(goal.compiled.map, 1429);
	assert.equal(goal.compiled.x, 47.6);
	assert.ok(goal.world && Number.isFinite(goal.world.wx) && Number.isFinite(goal.world.wy));
});

test('edits write the file, refuse a stale hash, and undo puts the text back', async () => {
	const start = fs.readFileSync(fileB, 'utf8');
	const view = await ok(server.url, 'guide_get', { id: 'mini/b' });
	const line = view.steps[0].goals[0].line;

	const r = await ok(server.url, 'edit_apply', { id: 'mini/b', hash: view.hash, ops: [{ op: 'setCoords', line, x: 50.2, y: 40.7 }] });
	const now = fs.readFileSync(fileB, 'utf8');
	assert.match(now.split('\n')[line - 1], /^\s*goto 50\.2,40\.7 "Kobold camp"/);
	assert.equal(r.guide.hash, sha1(now));
	assert.notEqual(r.guide.hash, view.hash);
	assert.equal(r.guide.steps[0].goals[0].compiled.x, 50.2);

	const stale = await cmd(server.url, 'edit_apply', { id: 'mini/b', hash: view.hash, ops: [{ op: 'setCoords', line, x: 10, y: 10 }] });
	assert.equal(stale.ok, false);
	assert.equal(stale.code, 'stale');
	assert.equal(fs.readFileSync(fileB, 'utf8'), now);

	const changes = await ok(server.url, 'changes_list');
	assert.deepEqual(changes.map((c) => [c.guide, c.added, c.removed]), [['mini/b', 1, 1]]);

	const undone = await ok(server.url, 'edit_undo');
	assert.equal(fs.readFileSync(fileB, 'utf8'), start);
	assert.equal(undone.guide.hash, sha1(start));
	assert.deepEqual(await ok(server.url, 'changes_list'), []);

	await ok(server.url, 'edit_redo');
	assert.equal(fs.readFileSync(fileB, 'utf8'), now);
	// Undo only restores a file that still holds what the edit wrote.
	fs.writeFileSync(fileB, `${now}# edited elsewhere\n`);
	const conflict = await cmd(server.url, 'edit_undo');
	assert.equal(conflict.ok, false);
	assert.equal(conflict.code, 'conflict');
	await ok(server.url, 'changes_revert', { file: r.guide.file });
	assert.equal(fs.readFileSync(fileB, 'utf8'), start);
});

test('a batch names goals and steps as the view at its hash shows them', async () => {
	const start = fs.readFileSync(fileB, 'utf8');
	const view = await ok(server.url, 'guide_get', { id: 'mini/b' });
	const goals = (r) => r.guide.steps[0].goals.map((g) => g.raw.trim());
	// Positions (`index`) count in the guide as the earlier ops left it.
	let r = await ok(server.url, 'edit_apply', { id: 'mini/b', hash: view.hash, ops: [1, 2, 3].map((n) => ({ op: 'insertGoal', step: 0, index: n, fields: { verb: 'goto', x: n, y: n } })) });
	assert.deepEqual(goals(r), ['goto 47.6,35.1 "Kobold camp"', 'goto 1.0,1.0', 'goto 2.0,2.0', 'goto 3.0,3.0']);
	// Delete the second goal, then move the third by its line in the view.
	const g = r.guide.steps[0].goals;
	r = await ok(server.url, 'edit_apply', { id: 'mini/b', hash: r.guide.hash, ops: [{ op: 'deleteGoal', line: g[1].line }, { op: 'setCoords', line: g[2].line, x: 10, y: 10 }] });
	assert.deepEqual(goals(r), ['goto 47.6,35.1 "Kobold camp"', 'goto 10.0,10.0', 'goto 3.0,3.0']);
	// A goal an earlier op deleted cannot be named again; nothing is written.
	const kept = fs.readFileSync(fileB, 'utf8');
	const second = r.guide.steps[0].goals[1].line;
	const bad = await cmd(server.url, 'edit_apply', { id: 'mini/b', hash: r.guide.hash, ops: [{ op: 'deleteGoal', line: second }, { op: 'setRadius', line: second, r: 5 }] });
	assert.equal(bad.code, 'bad_args');
	assert.equal(fs.readFileSync(fileB, 'utf8'), kept);
	// Steps follow the step ops: step 0 of the view is step 1 after the insert.
	r = await ok(server.url, 'edit_apply', { id: 'mini/b', hash: r.guide.hash, ops: [{ op: 'insertStep', index: 0, title: 'First', goals: [{ verb: 'goto', x: 5, y: 5 }] }, { op: 'setStep', step: 0, title: 'Kobolds' }, { op: 'setCoords', line: second, x: 20, y: 20 }] });
	assert.deepEqual(r.guide.steps.map((s) => s.title), ['First', 'Kobolds']);
	assert.deepEqual(r.guide.steps[1].goals.map((x) => x.raw.trim()), ['goto 47.6,35.1 "Kobold camp"', 'goto 20.0,20.0', 'goto 3.0,3.0']);
	// Each batch is one undo.
	for (let i = 0; i < 3; i++) await ok(server.url, 'edit_undo');
	assert.equal(fs.readFileSync(fileB, 'utf8'), start);
});

test('a conflicting undo entry can be dropped; a deleted guide is reverted by writing it back', async () => {
	const start = fs.readFileSync(fileB, 'utf8');
	const view = await ok(server.url, 'guide_get', { id: 'mini/b' });
	await ok(server.url, 'edit_apply', { id: 'mini/b', hash: view.hash, ops: [{ op: 'setRadius', line: view.steps[0].goals[0].line, r: 20 }], label: 'Radius 20' });
	const elsewhere = `${fs.readFileSync(fileB, 'utf8')}# edited elsewhere\n`;
	fs.writeFileSync(fileB, elsewhere);
	assert.equal((await cmd(server.url, 'edit_undo')).code, 'conflict');
	const dropped = await ok(server.url, 'edit_undo', { drop: true });
	assert.equal(dropped.dropped, true);
	assert.equal(dropped.label, 'Radius 20');
	assert.equal(fs.readFileSync(fileB, 'utf8'), elsewhere);
	await ok(server.url, 'changes_revert', { file: view.file });
	assert.equal(fs.readFileSync(fileB, 'utf8'), start);

	fs.rmSync(fileB);
	const back = await ok(server.url, 'changes_revert', { file: view.file });
	assert.equal(fs.readFileSync(fileB, 'utf8'), start);
	assert.equal(back.guide.id, 'mini/b');
	// Undo deletes it again, redo writes it back.
	const undone = await ok(server.url, 'edit_undo');
	assert.equal(undone.guide, null);
	assert.equal(fs.existsSync(fileB), false);
	assert.equal((await cmd(server.url, 'guide_get', { id: 'mini/b' })).code, 'not_found');
	await ok(server.url, 'edit_redo');
	assert.equal(fs.readFileSync(fileB, 'utf8'), start);
	assert.equal((await ok(server.url, 'guide_get', { id: 'mini/b' })).hash, sha1(start));
});

test('edit_insert_world writes the point in the zone in effect where it lands', async () => {
	// Stormwind City's map lies inside Elwynn Forest's, as in the game.
	const tmp = tmpdir('polestar-planner-zones-');
	const data = path.join(tmp, 'data');
	fs.cpSync(DATA_DIR, data, { recursive: true });
	const frames = JSON.parse(fs.readFileSync(path.join(data, 'map-frames.json'), 'utf8'));
	frames.era[1453] = { ...frames.era[1429], top: 600, bottom: -100, left: 900, right: 100 };
	fs.writeFileSync(path.join(data, 'map-frames.json'), JSON.stringify(frames));
	const pack = path.join(tmp, 'mini');
	fs.cpSync(MINI, pack, { recursive: true });
	const file = path.join(pack, 'guides', 'c.guide');
	fs.writeFileSync(file, ['guide mini/c', 'title Mini C', 'faction Alliance', 'levels 2-6', 'zone Elwynn Forest', '', 'step City', '  zone Stormwind City', '  goto 50.0,50.0', '', 'step Walk', '  zone Elwynn Forest', '  goto 40.0,60.0', '  zone Stormwind City', '  goto 60.0,70.0', ''].join('\n'));
	const w = new Workspace({ dataDir: data, official: false, packs: [pack], watch: false, lintDelay: 60000 });
	try {
		const near = (goal, p) => assert.ok(goal.world && goal.world.c === p.c && Math.hypot(goal.world.wx - p.wx, goal.world.wy - p.wy) < 5, `${goal.raw} at ${JSON.stringify(goal.world)}, want ${JSON.stringify(p)}`);
		// Between a goal and the `zone Stormwind City` line above the next: read in Stormwind.
		const city = w.geo.toWorld(1453, 55, 55, 'e');
		let r = await commands.run(w, 'edit_insert_world', { id: 'mini/c', hash: w.view('mini/c').hash, step: 1, index: 1, c: city.c, wx: city.wx, wy: city.wy });
		let goal = r.guide.steps[1].goals[1];
		assert.equal(goal.raw.trim(), 'goto 55.0,55.0');
		near(goal, city);
		// A new first step comes before step 0's own `zone` line: read in the header's zone.
		const gate = w.geo.toWorld(1453, 45, 45, 'e');
		r = await commands.run(w, 'edit_insert_world', { id: 'mini/c', hash: r.guide.hash, step: 0, title: 'Gate', c: gate.c, wx: gate.wx, wy: gate.wy });
		goal = r.guide.steps[0].goals[0];
		assert.equal(r.guide.steps[0].title, 'Gate');
		assert.doesNotMatch(goal.raw, /map/);
		near(goal, gate);
	} finally {
		w.close();
	}
});

test('walks are routed on the navigation grid in workers, cached on disk, and the grid\'s overlays are served', { timeout: 120000 }, async () => {
	const { Scene } = require('./helpers/navscene');
	const { buildGrid } = require('../tools/lib/nav/grid/build');
	const tmp = tmpdir('polestar-planner-nav-');
	// The fixture's Elwynn Forest (continent 1415) holds tile 32_32: flat
	// ground with a wall from the north edge to y = 300 between the two gotos.
	const scene = new Scene({ c: 1415, col: 32, row: 32 });
	scene.box(150, 0, -1, 154, 300, 12);
	const navDir = path.join(tmp, 'nav');
	await buildGrid({ outDir: navDir, workers: 0, continents: [{ c: 1415, name: 'test', tiles: [{ col: 32, row: 32 }] }], geometryJob: () => ({ geom: scene.geom() }) });
	const pack = path.join(tmp, 'mini');
	fs.cpSync(MINI, pack, { recursive: true });
	fs.writeFileSync(path.join(pack, 'guides', 'w.guide'), ['guide mini/w', 'title Mini W', 'faction Alliance', 'levels 2-6', 'zone Elwynn Forest', '', 'step Here', '  goto 45.0,62.0', 'step There', '  goto 52.8,62.0', 'step Back', '  goto 45.0,62.0', ''].join('\n'));
	const character = { race: 'Human', cls: 'WARRIOR', faction: 'Alliance' };
	const open = () => new Workspace({ dataDir: DATA_DIR, official: false, packs: [pack], watch: false, lintDelay: 60000, navDir });
	const w = open();
	const srv = await startServer({ port: 0, workspace: w });
	try {
		const info = await ok(srv.url, 'planner_info');
		assert.equal(info.nav.available, true);
		assert.match(info.nav.build, /^[0-9a-f]{12}$/);
		assert.deepEqual(info.nav.continents, [1415]);
		assert.equal(info.nav.aids, false);

		// Cold: the straight-line timeline at once, the legs routed in the background.
		const arrived = new Promise((resolve) => w.once('changed', (d) => d.timeline && resolve()));
		const args = { start: 'mini/w', character, view: 'steps' };
		const cold = await ok(srv.url, 'timeline_get', args);
		assert.equal(cold.totals.legs, 2);
		assert.equal(cold.totals.routed, 0);
		assert.ok(cold.nav.routing && cold.nav.routing.pending + cold.nav.routing.done === 2);
		assert.deepEqual(cold.steps[1].straight, [{ line: 10, reason: 'pending' }]);
		await arrived;
		const warm = await ok(srv.url, 'timeline_get', args);
		assert.equal(warm.totals.routed, 2);
		assert.equal(warm.nav.routing, null);
		assert.equal(warm.steps[1].estimate, false);
		assert.equal(warm.steps[1].routed, 1);
		// Around the wall: longer than the straight line, the time the route's.
		const full = await ok(srv.url, 'timeline_get', { ...args, view: 'full' });
		const there = full.steps[1].goals[0];
		assert.ok(there.route.yards > 330, `around the wall: ${there.route.yards} yd`);
		assert.ok(Math.abs(there.split.travel - there.route.byClass.walk) < 0.5);
		assert.ok(full.track.m.length > cold.totals.legs * 2);
		const r = await ok(srv.url, 'nav_route', { from: { map: 1429, x: 45, y: 62 }, to: { map: 1429, x: 52.8, y: 62 }, character, level: 2 });
		assert.equal(r.ok, true);
		assert.ok(r.yards > r.straight.yards * 1.2);
		assert.ok(r.points.length >= 3 && r.points.every((p) => p.c === 1415 && p.map === 1429));
		assert.ok(r.points.some((p) => p.y > 66), 'the path goes south around the wall');
		const files = fs.readdirSync(navDir).filter((f) => /^routes-[0-9a-f]{12}\.jsonl$/.test(f));
		assert.equal(files.length, 1);

		// The grid's tiles, and the Walkable layer of one; none for a tile not built.
		assert.deepEqual(await (await fetch(`${srv.url}nav/index.json`)).json(), { build: info.nav.build, continents: { 1415: ['32_32'] } });
		const png = await fetch(`${srv.url}nav/tile/1415/32_32.png`);
		assert.equal(png.status, 200);
		const buf = Buffer.from(await png.arrayBuffer());
		assert.equal(buf.readUInt32BE(16), 256);
		assert.equal(buf.readUInt32BE(20), 256);
		assert.equal((await fetch(`${srv.url}nav/tile/1415/40_40.png`)).status, 404);

		// Arrow aids: 404 without the file, world points with it.
		assert.equal((await fetch(`${srv.url}nav/aids.json`)).status, 404);
		fs.writeFileSync(path.join(navDir, 'aids.json'), JSON.stringify({
			schema: 1, frame: 'era', source: 'test', build: 'b1',
			crossings: [{ id: 'gap', a: { map: 1429, x: 45, y: 70, radius: 10 }, b: { map: 1429, x: 52.8, y: 70, radius: 10 }, ab: 'Around the wall' }],
			open: [{ a: 1429, b: 1429 }],
			chains: [{ id: 'c1', name: 'Wall', open: 'mouth', nodes: [{ map: 1429, x: 45, y: 70, radius: 8 }, { map: 1429, x: 48, y: 72, radius: 8, caption: 'In' }] }],
		}));
		const aids = await (await fetch(`${srv.url}nav/aids.json`)).json();
		assert.equal(aids.build, 'b1');
		assert.equal(aids.crossings[0].a.c, 1415);
		assert.equal(aids.crossings[0].ab, 'Around the wall');
		assert.equal(aids.open[0].aName, 'Elwynn Forest');
		assert.equal(aids.chains[0].nodes[1].caption, 'In');
		assert.equal((await ok(srv.url, 'planner_info')).nav.aids, true);
	} finally {
		await srv.close();
		w.close();
	}
	// A restart is warm: every leg comes from the file.
	const again = open();
	try {
		const t = again.timeline({ start: 'mini/w', character });
		assert.equal(t.totals.routed, 2);
		assert.equal(t.routing, undefined);
	} finally {
		again.close();
	}
});

// One MCP session: send each message, read one answer per request.
function mcpSession(port) {
	const child = spawn(process.execPath, [path.join(ROOT, 'tools', 'polestar.js'), 'planner', 'mcp', '--port', String(port)], { cwd: ROOT, stdio: ['pipe', 'pipe', 'pipe'] });
	let buf = '';
	const waiting = [];
	const answers = [];
	child.stdout.on('data', (d) => {
		buf += d;
		let i;
		while ((i = buf.indexOf('\n')) >= 0) {
			const msg = JSON.parse(buf.slice(0, i));
			buf = buf.slice(i + 1);
			if (waiting.length) waiting.shift()(msg);
			else answers.push(msg);
		}
	});
	const request = (msg) => {
		child.stdin.write(`${JSON.stringify(msg)}\n`);
		return answers.length ? Promise.resolve(answers.shift()) : new Promise((resolve) => waiting.push(resolve));
	};
	const notify = (msg) => child.stdin.write(`${JSON.stringify(msg)}\n`);
	const close = () => new Promise((resolve) => {
		child.once('exit', resolve);
		child.stdin.end();
	});
	return { request, notify, close };
}

test('MCP over stdio proxies to the running planner', { timeout: 30000 }, async () => {
	const s = mcpSession(server.port);
	try {
		const init = await s.request({ jsonrpc: '2.0', id: 1, method: 'initialize', params: { protocolVersion: '2025-03-26', capabilities: {}, clientInfo: { name: 'test', version: '1' } } });
		assert.equal(init.id, 1);
		assert.equal(init.result.protocolVersion, '2025-03-26');
		assert.equal(init.result.serverInfo.name, 'polestar-planner');
		assert.deepEqual(init.result.capabilities, { tools: { listChanged: false } });
		s.notify({ jsonrpc: '2.0', method: 'notifications/initialized' });

		const tools = await s.request({ jsonrpc: '2.0', id: 2, method: 'tools/list', params: {} });
		const timeline = tools.result.tools.find((t) => t.name === 'timeline_get');
		assert.ok(timeline);
		assert.deepEqual(timeline.inputSchema.required, ['start', 'character']);

		const got = await s.request({ jsonrpc: '2.0', id: 3, method: 'tools/call', params: { name: 'guide_get', arguments: { id: 'mini/b' } } });
		assert.equal(got.result.isError, undefined);
		assert.equal(got.result.structuredContent.id, 'mini/b');
		assert.equal(JSON.parse(got.result.content[0].text).id, 'mini/b');

		const missing = await s.request({ jsonrpc: '2.0', id: 4, method: 'tools/call', params: { name: 'guide_get', arguments: { id: 'mini/nope' } } });
		assert.equal(missing.result.isError, true);
		assert.match(missing.result.content[0].text, /no guide "mini\/nope"/);

		// JSON.stringify leaves U+2028/U+2029 as they are: still one message.
		const ping = await s.request({ jsonrpc: '2.0', id: 5, method: 'ping', params: { note: 'a\u2028b\u2029c' } });
		assert.deepEqual(ping, { jsonrpc: '2.0', id: 5, result: {} });
	} finally {
		await s.close();
	}
});
