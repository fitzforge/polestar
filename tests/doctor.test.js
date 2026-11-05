'use strict';
// polestar doctor: one line per check, each failing one with its fix for
// Windows, macOS and Linux; exit 1 only when Node or the reference data fail.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { quiet } = require('./helpers/cli');
const { tmpdir } = require('./helpers/tmp');
const doctor = require('../tools/commands/doctor');

const JOE = path.join(__dirname, 'fixtures', 'packs', 'joe');

// A healthy environment: Node 24, lua5.1, built data, one client found, outside any pack.
function good(over = {}) {
	const data = tmpdir();
	fs.writeFileSync(path.join(data, 'races.json'), '{}');
	const addons = tmpdir();
	return {
		platform: 'linux',
		nodeVersion: '24.1.0',
		findLua: () => 'lua5.1',
		luaVersion: () => 'Lua 5.1',
		dataDir: data,
		detectAddons: () => [{ addons, client: path.dirname(addons), kind: 'forever' }],
		cwd: tmpdir(),
		vars: {},
		...over,
	};
}

async function run(env, argv = []) {
	const { result, out } = await quiet(() => doctor.run(argv, env));
	return { code: result, lines: out.split('\n').filter(Boolean) };
}

const FIXES = (lines, check) => {
	const i = lines.findIndex((l) => l.startsWith(`fix ${check}:`));
	assert.ok(i >= 0, `no fix line for ${check}:\n${lines.join('\n')}`);
	const out = [];
	for (let j = i + 1; j < lines.length && lines[j].startsWith('    '); j++) out.push(lines[j].trim());
	return out;
};

test('all good: exit 0 and every line ok', async () => {
	const { code, lines } = await run(good());
	assert.equal(code, 0);
	assert.deepEqual(lines.map((l) => l.split(':')[0]), ['ok  node', 'ok  lua', 'ok  data', 'ok  addons']);
	assert.match(lines[1], /lua5\.1 \(Lua 5\.1\)/);
});

test('Node 22: exit 1 with the Node fix for Windows, macOS and Linux', async () => {
	const { code, lines } = await run(good({ nodeVersion: '22.3.0' }));
	assert.equal(code, 1);
	assert.match(lines.find((l) => l.startsWith('fix node:')), /22\.3\.0.*24 or newer/);
	const fixes = FIXES(lines, 'node');
	assert.deepEqual(fixes.map((f) => f.split(':')[0]), ['Windows', 'macOS', 'Linux']);
});

test('no Lua: exit 0 with the Lua fix', async () => {
	const { code, lines } = await run(
		good({
			findLua: () => {
				throw new Error('No Lua 5.1 interpreter found');
			},
		}),
	);
	assert.equal(code, 0);
	assert.match(lines.find((l) => l.startsWith('fix lua:')), /no Lua 5\.1 interpreter.*play and playtest need one/);
	assert.deepEqual(FIXES(lines, 'lua').map((f) => f.split(':')[0]), ['Windows', 'macOS', 'Linux']);
});

test('no reference data: exit 1', async () => {
	const { code, lines } = await run(good({ dataDir: path.join(tmpdir(), 'missing') }));
	assert.equal(code, 1);
	assert.ok(lines.some((l) => l.startsWith('fix data:')));
	assert.deepEqual(FIXES(lines, 'data').map((f) => f.split(':')[0]), ['Windows', 'macOS', 'Linux']);
});

test('no AddOns folder: the fix names the variable and --dest', async () => {
	const { code, lines } = await run(good({ detectAddons: () => [] }));
	assert.equal(code, 0);
	assert.ok(lines.some((l) => l.startsWith('fix addons:')));
	const fixes = FIXES(lines, 'addons');
	assert.deepEqual(fixes.map((f) => f.split(':')[0]), ['Windows', 'macOS', 'Linux']);
	assert.ok(fixes.every((f) => f.includes('WOW_FOREVER_ADDONS') && f.includes('--dest')));
});

test('$WOW_FOREVER_ADDONS wins over detection', async () => {
	const dir = tmpdir();
	const { lines } = await run(good({ vars: { WOW_FOREVER_ADDONS: dir }, detectAddons: () => [] }));
	assert.ok(lines.includes(`ok  addons: ${dir} ($WOW_FOREVER_ADDONS)`), lines.join('\n'));
});

test('addons: doctor picks the client install would pick (a live client over a beta one)', async () => {
	const live = tmpdir();
	const beta = tmpdir();
	const both = [{ addons: beta, client: path.dirname(beta), kind: 'beta' }, { addons: live, client: path.dirname(live), kind: 'forever' }];
	const one = await run(good({ detectAddons: () => both }));
	assert.ok(one.lines.includes(`ok  addons: ${live} (found)`), one.lines.join('\n'));
	const two = await run(good({ detectAddons: () => [...both, { addons: tmpdir(), client: '/x', kind: 'forever' }] }));
	assert.match(two.lines.find((l) => l.startsWith('fix addons:')), /^fix addons: 2 Forever clients found .*; choose one$/);
});

test('the Fedora Lua fix names a Lua 5.1 the tools find', async () => {
	const { lines } = await run(good({ findLua: () => null }));
	const linux = FIXES(lines, 'lua').find((f) => f.startsWith('Linux:'));
	assert.match(linux, /sudo dnf install luajit \(Fedora; or sudo dnf install compat-lua, then export LUA=lua-5\.1\)/);
});

test('inside a valid pack: its pack.json is checked', async () => {
	const { code, lines } = await run(good({ cwd: path.join(JOE, 'guides') }));
	assert.equal(code, 0);
	assert.match(lines.at(-1), /^ok {2}pack\.json: joe 1\.2\.0/);
});

test('doctor <dir> checks that pack; two folders, or one without pack.json, are a usage error', async () => {
	const one = await run(good(), [JOE]);
	assert.equal(one.code, 0);
	assert.match(one.lines.at(-1), /^ok {2}pack\.json: joe 1\.2\.0/);
	const two = await run(good(), [JOE, JOE]);
	assert.equal(two.code, 2);
	assert.match(two.lines[0], /one pack folder only, got 2/);
	const none = await run(good(), [tmpdir()]);
	assert.equal(none.code, 2);
	assert.match(none.lines[0], /no pack\.json in /);
});

test('our guides reached through a symlink are checked as ours', async () => {
	const { OFFICIAL_DIR } = require('../tools/lib/dsl/project');
	const link = path.join(tmpdir(), 'guides-link');
	fs.symlinkSync(OFFICIAL_DIR, link, 'dir');
	const { lines } = await run(good(), ['--pack', link]);
	assert.match(lines.at(-1), /^ok {2}pack\.json: guides /, lines.join('\n'));
});

test('a pack with an invalid pack.json: its diagnostics are printed', async () => {
	const dir = tmpdir();
	fs.writeFileSync(path.join(dir, 'pack.json'), JSON.stringify({ id: 'lookup', title: 'T', author: 'A', version: '1', license: 'MIT' }));
	const { code, lines } = await run(good(), ['--pack', dir]);
	assert.equal(code, 0);
	assert.ok(lines.some((l) => l.startsWith('fix pack.json:')));
	assert.ok(lines.some((l) => /pack\.json:\d+: error: pack id "lookup" is reserved/.test(l)), lines.join('\n'));
});
