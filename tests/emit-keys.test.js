'use strict';
// Every table key the guide emitter writes is a bare Lua identifier or a
// quoted string: a hostile key cannot break out of its table.

const test = require('node:test');
const assert = require('node:assert/strict');
const { spawnSync } = require('node:child_process');
const { findLua } = require('../tools/lib/lua');
const { luaKey, luaString, inline, idMap } = require('../tools/lib/dsl/emit');

const HOSTILE = ['a = 1 }) os.exit() --', ']]', '\n', 'end', '__index_x y', 'q"u\'o\\te', 'NaN', '1e3', 'nil', ''];

// Run `return <expr>` in Lua 5.1 and print each key=value pair, sorted.
function luaPairs(expr) {
	const program = `local t = assert(loadstring(${luaString(`return ${expr}`)}))()
local out = {}
for k, v in pairs(t) do out[#out + 1] = type(k) .. ':' .. string.format('%q', tostring(k)) .. '=' .. tostring(v) end
table.sort(out)
io.write(table.concat(out, '\\n'))`;
	const r = spawnSync(findLua(), ['-e', program], { encoding: 'utf8' });
	assert.equal(r.status, 0, r.stderr);
	return r.stdout;
}

function expected(entries) {
	return entries
		.map(([k, v]) => `${typeof k === 'number' ? 'number' : 'string'}:${JSON.stringify(String(k)).replace(/\\n/g, '\\\n')}=${v}`)
		.sort()
		.join('\n');
}

test('identifier keys stay bare', () => {
	for (const k of ['x', 'npcName', '_a1', '__index', 'NaN']) assert.equal(luaKey(k), k);
});

test('keywords and other keys are quoted strings', () => {
	for (const k of HOSTILE.filter((k) => k !== 'NaN')) assert.equal(luaKey(k), `[${luaString(k)}]`);
});

test('inline: hostile nested keys round-trip through Lua', () => {
	const nested = Object.fromEntries(HOSTILE.map((k, i) => [k, i]));
	const src = inline({ wrap: nested }, ['wrap']);
	assert.match(src, /^\{ wrap = \{ /);
	assert.equal(luaPairs(`(${src}).wrap`), expected(HOSTILE.map((k, i) => [k, i])));
});

test('idMap: integers stay [n], anything else is a string key, never [NaN]', () => {
	const map = { 12: 'a', 3: 'b', '-4': 'c', NaN: 'd', '1e3': 'e', '012': 'f', 'x"]] = 1 --': 'g' };
	const src = idMap(map);
	assert.ok(!src.includes('[NaN]'));
	assert.ok(src.startsWith('{ [-4] = "c", [3] = "b", [12] = "a", '));
	assert.equal(
		luaPairs(src),
		expected([
			[-4, 'c'],
			[3, 'b'],
			[12, 'a'],
			['NaN', 'd'],
			['1e3', 'e'],
			['012', 'f'],
			['x"]] = 1 --', 'g'],
		]),
	);
});
