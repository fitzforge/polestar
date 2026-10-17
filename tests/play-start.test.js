'use strict';
// The playground's Lua session when it cannot start: a Lua that never answers
// is stopped and its program file removed, so `play` and `dev --play` exit.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { needs } = require('./helpers/data');
const { tmpdir } = require('./helpers/tmp');

const ROOT = path.join(__dirname, '..');

test('a Lua session that never gets ready is stopped and leaves no program file; the process exits', { skip: needs('races.json') || (process.platform === 'win32' && 'needs a shell script') }, () => {
	const dir = tmpdir('polestar-play-start-');
	// Passes the version check, then hangs without answering.
	const lua = path.join(dir, 'lua');
	fs.writeFileSync(lua, '#!/bin/sh\nif [ "$1" = "-e" ]; then printf "Lua 5.1"; exit 0; fi\nexec sleep 60\n', { mode: 0o755 });
	const script = `
const fs = require('node:fs'); const os = require('node:os');
const { Session } = require(${JSON.stringify(path.join(ROOT, 'tools', 'play', 'session'))});
const s = new Session({ dataDir: ${JSON.stringify(path.join(dir, 'data'))}, timeoutMs: 300 });
s.start().then(() => console.log('started'), (err) => {
	const left = fs.readdirSync(os.tmpdir()).filter((f) => f.startsWith('polestar-play-' + process.pid + '-'));
	console.log(JSON.stringify({ error: err.message, proc: !!s.proc, left }));
});`;
	const r = spawnSync(process.execPath, ['-e', script], { env: { ...process.env, LUA: lua }, encoding: 'utf8', timeout: 20000 });
	assert.equal(r.error, undefined, 'the process exits on its own');
	assert.equal(r.status, 0, r.stderr);
	const out = JSON.parse(r.stdout.trim());
	assert.match(out.error, /Lua session failed to start/);
	assert.equal(out.proc, false);
	assert.deepEqual(out.left, []);
});

test('GET /api/version moves when a rebuild restarts the session, so the page can redraw on its own; a restart that fails leaves it alone', { skip: needs('races.json'), timeout: 120000 }, async () => {
	const { startServer } = require('../tools/play/server');
	const play = await startServer({ port: 0, dataDir: tmpdir('polestar-play-version-'), artDir: null });
	try {
		const get = async (p) => (await fetch(`${play.url}api/${p}`)).json();
		const version = async () => (await get('version')).version;
		const before = await version();
		assert.equal((await get('meta')).version, before, '/api/meta gives the page the same count to start from');
		assert.equal(await version(), before, 'steady while nothing restarts');
		await play.reload({ why: 'Community addon rebuilt; UI reloaded.' });
		const after = await version();
		assert.notEqual(after, before);
		// A pack whose Lua fails while loading: the restart fails, and the
		// page must not be sent into redrawing (which would restart again).
		const broken = path.join(tmpdir('polestar-play-broken-'), 'Broken');
		fs.mkdirSync(broken);
		fs.writeFileSync(path.join(broken, 'Broken.toc'), '## Interface: 16001\nBad.lua\n');
		fs.writeFileSync(path.join(broken, 'Bad.lua'), 'error("broken pack")\n');
		await assert.rejects(play.reload({ packs: [broken] }), /Lua session failed to start/);
		assert.equal(await version(), after);
	} finally {
		await play.close({ save: false });
	}
});
