'use strict';
// polestar dev: watches a pack, rebuilds into <dest>/<folder> on
// every save, says once that a new addon needs a restart, and never replaces
// a folder it did not generate. Runs the real command in a child process.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const net = require('node:net');
const os = require('node:os');
const path = require('node:path');
const { spawn } = require('node:child_process');
const { DATA_DIR } = require('./helpers/dsl');
const { tmpdir } = require('./helpers/tmp');
const { CLI, polestar, quiet } = require('./helpers/cli');
const { needs } = require('./helpers/data');
const { TOC_MARKER } = require('../tools/lib/pack/format');

const PACKS = path.join(__dirname, 'fixtures', 'packs');
const FOLDER = 'PolestarPack_MiniPack';
const RESTART = /New addon: restart the game once so it sees PolestarPack_MiniPack; after that \/reload shows every change\./g;

function miniCopy() {
	const dir = tmpdir();
	fs.cpSync(path.join(PACKS, 'mini'), dir, { recursive: true });
	return dir;
}

// Start `dev` in the folder cwd (the pack, unless a test names it) into dest
// (extra arguments after; a repeated option wins); the playground's
// SavedVariables and client art (no maps) are temp folders.
// -> { child, out(), waitFor(re), exited, stop(), playData }.
function dev(cwd, dest, ...extra) {
	const args = [CLI, 'dev', ...(dest ? ['--dest', dest] : []), '--data', DATA_DIR, '--context', path.join(PACKS, 'context'), '--context-data', DATA_DIR, ...extra];
	const playData = path.join(tmpdir(), 'play');
	const art = tmpdir();
	fs.writeFileSync(path.join(art, 'maps.json'), '{}\n');
	const env = { ...process.env, POLESTAR_PLAY_DATA: playData, POLESTAR_CLIENT_ART: art };
	const child = spawn(process.execPath, args, { cwd, env, stdio: ['ignore', 'pipe', 'pipe'] });
	let text = '';
	const waiters = [];
	const feed = (chunk) => {
		text += chunk;
		for (const w of [...waiters]) if (w.re.test(text)) w.resolve();
	};
	child.stdout.setEncoding('utf8').on('data', feed);
	child.stderr.setEncoding('utf8').on('data', feed);
	const exited = new Promise((resolve) => child.on('exit', resolve));
	return {
		child,
		exited,
		playData,
		out: () => text,
		waitFor(re, ms = 5000) {
			if (re.test(text)) return Promise.resolve();
			return new Promise((resolve, reject) => {
				const w = { re, resolve: () => (clearTimeout(timer), resolve()) };
				const timer = setTimeout(() => reject(new Error(`timed out waiting for ${re}; output:\n${text}`)), ms);
				waiters.push(w);
			});
		},
		async stop() {
			child.kill('SIGINT');
			return exited;
		},
	};
}

async function until(fn, ms = 5000) {
	const t0 = Date.now();
	for (;;) {
		if (fn()) return;
		if (Date.now() - t0 > ms) throw new Error('timed out');
		await new Promise((r) => setTimeout(r, 50));
	}
}

test('dev builds into <dest>/<folder>, rebuilds on save and asks for one restart only', { timeout: 30000 }, async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	const d = dev(pack, dest);
	try {
		await d.waitFor(/watching/);
		const guides = path.join(dest, FOLDER, 'Guides.lua');
		assert.match(fs.readFileSync(guides, 'utf8'), /"Mini B"/);
		assert.equal((d.out().match(RESTART) || []).length, 1, d.out());
		const src = path.join(pack, 'guides', 'b.guide');
		fs.writeFileSync(src, fs.readFileSync(src, 'utf8').replace('title Mini B', 'title Mini B Edited'));
		await until(() => fs.readFileSync(guides, 'utf8').includes('"Mini B Edited"'));
		await d.waitFor(/built 2 guides[\s\S]*built 2 guides/);
		assert.equal((d.out().match(RESTART) || []).length, 1, 'the second build does not ask for a restart');
		// A save with an error prints it and keeps the last good build.
		fs.writeFileSync(src, fs.readFileSync(src, 'utf8').replace('goto 47.6,35.1', 'goto nowhere'));
		await d.waitFor(/b\.guide:\d+: error/);
		assert.match(fs.readFileSync(guides, 'utf8'), /"Mini B Edited"/);
	} finally {
		await d.stop();
	}
});

test('dev refuses to replace a folder it did not generate', { timeout: 30000 }, async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	fs.mkdirSync(path.join(dest, FOLDER));
	fs.writeFileSync(path.join(dest, FOLDER, 'notes.txt'), 'mine\n');
	const d = dev(pack, dest);
	try {
		await d.waitFor(/refusing to write into .*PolestarPack_MiniPack: it is not a generated community addon/);
		assert.deepEqual(fs.readdirSync(path.join(dest, FOLDER)), ['notes.txt']);
		assert.doesNotMatch(d.out(), RESTART);
	} finally {
		await d.stop();
	}
});

test('dev refuses a generated folder of another pack with the same folder name, pointing to "folder" in pack.json', { timeout: 30000 }, async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	const other = path.join(dest, FOLDER);
	fs.mkdirSync(other);
	const toc = `## Title: Mini Pack\n${TOC_MARKER}\n## X-Polestar-Pack: someone-else\n`;
	fs.writeFileSync(path.join(other, `${FOLDER}.toc`), toc);
	const d = dev(pack, dest);
	try {
		await d.waitFor(/refusing to write into .*PolestarPack_MiniPack: it holds the community addon "someone-else", not "mini"; set "folder" in pack\.json/);
		assert.equal(fs.readFileSync(path.join(other, `${FOLDER}.toc`), 'utf8'), toc);
		assert.deepEqual(fs.readdirSync(other), [`${FOLDER}.toc`]);
	} finally {
		await d.stop();
	}
});

test('dev builds into an empty folder of the pack\'s name (the one folder rule) and asks for the restart', { timeout: 30000 }, async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	fs.mkdirSync(path.join(dest, FOLDER));
	const d = dev(pack, dest);
	try {
		await d.waitFor(/watching/);
		assert.ok(fs.existsSync(path.join(dest, FOLDER, 'Guides.lua')), d.out());
		assert.equal((d.out().match(RESTART) || []).length, 1, d.out());
	} finally {
		await d.stop();
	}
});

test('dev takes the pack folder as its one argument; two folders, or one without pack.json, are a usage error', { timeout: 30000 }, async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	const d = dev(tmpdir(), dest, pack);
	try {
		await d.waitFor(/watching/);
		assert.ok(fs.existsSync(path.join(dest, FOLDER, 'Guides.lua')), d.out());
	} finally {
		await d.stop();
	}
	const two = polestar(['dev', pack, miniCopy(), '--no-game'], { cwd: tmpdir() });
	assert.equal(two.status, 2, two.stderr);
	assert.match(two.stderr, /one pack folder only/);
	const none = polestar(['dev', '../my-pack', '--no-game'], { cwd: miniCopy() });
	assert.equal(none.status, 2, none.stderr);
	assert.match(none.stderr, /no pack\.json in \.\.\/my-pack/);
});

test('without reference data dev prints one error and exits instead of watching', { timeout: 30000 }, async () => {
	const dest = tmpdir();
	const missing = path.join(tmpdir(), 'no-data');
	const d = dev(miniCopy(), dest, '--data', missing);
	const code = await d.exited;
	assert.equal(code, 1, d.out());
	assert.equal(d.out().split('\n').filter((l) => /error:/.test(l)).length, 1, d.out());
	assert.match(d.out(), new RegExp(`${missing.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}: error: no reference data: the folder does not exist`));
	assert.match(d.out(), /hint: run `node tools\/polestar\.js data build`, or pass --data <dir>; --no-data/);
	assert.match(d.out(), /dev: not started: no reference data\n$/);
	assert.doesNotMatch(d.out(), /watching|\.guide/);
	assert.deepEqual(fs.readdirSync(dest), []);
	const both = polestar(['dev', miniCopy(), '--no-game', '--no-data', '--data', missing], { cwd: tmpdir() });
	assert.equal(both.status, 2, both.stderr);
	assert.match(both.stderr, /--no-data and --data cannot be used together/);
});

test('dev reports a deleted pack.json, keeps the last good build and watching, and builds again once it is back', { timeout: 30000 }, async () => {
	const pack = miniCopy();
	const dest = tmpdir();
	const d = dev(pack, dest);
	try {
		await d.waitFor(/watching/);
		const guides = path.join(dest, FOLDER, 'Guides.lua');
		const before = fs.readFileSync(guides, 'utf8');
		const manifest = path.join(pack, 'pack.json');
		const text = fs.readFileSync(manifest, 'utf8');
		fs.renameSync(manifest, path.join(pack, 'pack.json.bak'));
		await d.waitFor(/pack\.json:1: error: no pack\.json in [\s\S]*dev: 1 error, 0 warnings; not built \(the last good build stays\)/);
		assert.doesNotMatch(d.out(), /TypeError|\n\s+at /);
		assert.equal(fs.readFileSync(guides, 'utf8'), before);
		fs.writeFileSync(manifest, text);
		await d.waitFor(/not built \(the last good build stays\)[\s\S]*built 2 guides/);
		assert.equal(d.child.exitCode, null, 'still watching');
	} finally {
		await d.stop();
	}
});

const noPlay = needs('races.json');

test('dev --play on a taken port exits 1 promptly and leaves no Lua session behind', { skip: noPlay, timeout: 60000 }, async () => {
	const holder = net.createServer();
	await new Promise((resolve) => holder.listen(0, '127.0.0.1', resolve));
	const { port } = holder.address();
	try {
		const d = dev(miniCopy(), null, '--no-game', '--play', '--port', String(port));
		const t0 = Date.now();
		const timer = setTimeout(() => d.child.kill('SIGKILL'), 30000);
		const code = await d.exited;
		clearTimeout(timer);
		assert.equal(code, 1, d.out());
		assert.ok(Date.now() - t0 < 30000, 'exits on its own');
		assert.match(d.out(), new RegExp(`the playground could not start: .*port ${port} is taken`));
		assert.ok(fs.existsSync(d.playData), 'the playground used the temp SavedVariables folder');
		const tag = `polestar-play-${d.child.pid}-`;
		assert.deepEqual(fs.readdirSync(os.tmpdir()).filter((f) => f.startsWith(tag)), [], 'no Lua program file left');
		if (fs.existsSync('/proc')) {
			const left = fs.readdirSync('/proc').filter((p) => /^\d+$/.test(p)).filter((p) => {
				try {
					return fs.readFileSync(`/proc/${p}/cmdline`, 'utf8').includes(tag);
				} catch {
					return false;
				}
			});
			assert.deepEqual(left, [], 'no Lua process left');
		}
	} finally {
		holder.close();
	}
});

test('dev --no-game builds and rebuilds without writing anywhere, and never looks for the game', { timeout: 30000 }, async () => {
	const pack = miniCopy();
	const before = fs.readdirSync(pack).sort();
	const d = dev(pack, null, '--no-game');
	try {
		await d.waitFor(/watching/);
		assert.match(d.out(), /^dev: built 2 guides, \d+ warnings? \(not written: --no-game\)$/m);
		assert.doesNotMatch(d.out(), /building into|New addon/);
		fs.appendFileSync(path.join(pack, 'guides', 'b.guide'), '\nstep More\n  goto 47.0,35.0 "More"\n');
		await d.waitFor(/\(not written: --no-game\)[\s\S]*\(not written: --no-game\)/);
		assert.deepEqual(fs.readdirSync(pack).sort(), before, 'nothing written into the pack');
	} finally {
		await d.stop();
	}
});

test('dev and play: a --port that is not a port number is a usage error', async () => {
	const play = require('../tools/commands/play');
	for (const port of ['abc', '-1', '65536', '1.5']) {
		const r = polestar(['dev', miniCopy(), '--no-game', '--port', port], { cwd: tmpdir() });
		assert.equal(r.status, 2, `dev --port ${port}: ${r.stderr}`);
		assert.match(r.stderr, /^--port needs a port number$/m);
		const p = await quiet(() => play.run(['--port', port]));
		assert.equal(p.result, 2, `play --port ${port}: ${p.out}`);
		assert.match(p.out, /--port needs a port number/);
	}
});
