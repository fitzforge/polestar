'use strict';
// tools/lib/lua.js loading data files under each Lua 5.1 interpreter the tools
// accept: lua5.1 and LuaJIT. LuaJIT allows one function 65536 constants, fewer
// than pfQuest's db/units.lua holds in its one table constructor.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { tmpdir } = require('./helpers/tmp');

const LUA_JS = path.join(__dirname, '..', 'tools', 'lib', 'lua.js');

function works(bin) {
	const r = spawnSync(bin, ['-e', 'io.write(_VERSION)'], { encoding: 'utf8' });
	return r.status === 0 && /5\.1/.test(r.stdout);
}

// luaToJson in a child, since findLua keeps the first interpreter it finds.
function load(bin, file, expr) {
	const script = `const { luaToJson } = require(${JSON.stringify(LUA_JS)});
try {
	process.stdout.write(JSON.stringify({ value: luaToJson({ files: [${JSON.stringify(file)}], prelude: 'pfDB = { units = {} }', expr: ${JSON.stringify(expr)} }) }));
} catch (e) {
	process.stdout.write(JSON.stringify({ error: e.message }));
}`;
	const r = spawnSync(process.execPath, ['-e', script], { encoding: 'utf8', env: { ...process.env, LUA: bin } });
	assert.equal(r.status, 0, r.stderr);
	return JSON.parse(r.stdout);
}

// A database file the way pfQuest writes one, with more constants than
// LuaJIT allows one function.
function bigDatabase(n = 70000) {
	const lines = ['pfDB["units"]["data"] = {'];
	for (let i = 1; i <= n; i++) lines.push(`  [${i}] = {`, `    ["lvl"] = "${i}",`, '  },');
	lines.push('}', '');
	const file = path.join(tmpdir(), 'units.lua');
	fs.writeFileSync(file, lines.join('\n'));
	return file;
}

for (const bin of ['lua5.1', 'luajit']) {
	test(`${bin}: a pfQuest database file with more than 65536 constants loads whole`, { skip: !works(bin) && `${bin} is not installed` }, () => {
		const { value, error } = load(bin, bigDatabase(), 'local n = 0 for _ in pairs(pfDB.units.data) do n = n + 1 end return { n = n, first = pfDB.units.data[1].lvl, last = pfDB.units.data[70000].lvl }');
		assert.equal(error, undefined);
		assert.deepEqual(value, { n: 70000, first: '1', last: '70000' });
	});
}

test('luajit: a file too big for it in any other shape names the way out', { skip: !works('luajit') && 'luajit is not installed' }, () => {
	const file = bigDatabase();
	fs.appendFileSync(file, 'pfDB.units.extra = true\n');
	const { error } = load('luajit', file, 'return true');
	assert.match(error, /more than 65536 constants \(LuaJIT cannot load this file; set LUA to a Lua 5\.1 interpreter\)/);
});
