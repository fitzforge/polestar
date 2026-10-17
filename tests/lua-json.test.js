'use strict';
// Lua numbers to JSON: the tools' luaToJson and the test client's emit().
// Whole numbers above 2^31 (step hashes, timestamps, packed ids) must come
// through exactly on every Lua 5.1 build, including Windows', whose "%d"
// goes through a 32-bit long.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { luaToJson } = require('../tools/lib/lua');
const { runAddon } = require('./helpers/lua');
const { needs } = require('./helpers/data');
const { tmpdir } = require('./helpers/tmp');

const NUMBERS = [0, 2147483647, 2147483648, 3000000000, 4294967295, -3000000000, 2 ** 53 - 1, 1.5];
const LUA = `{ 0, 2147483647, 2147483648, 3000000000, 4294967295, -3000000000, 2^53 - 1, 1.5 }`;

test('luaToJson writes whole numbers above 2^31 exactly', () => {
	assert.deepEqual(luaToJson({ expr: `return ${LUA}` }), NUMBERS);
});

test('emit writes whole numbers above 2^31 exactly', () => {
	const { emitted } = runAddon({ script: `emit(${LUA})` });
	assert.deepEqual(emitted, [NUMBERS]);
});

test('negative zero is written as 0', () => {
	assert.equal(Object.is(luaToJson({ expr: 'return -0.0' }), 0), true);
	const { emitted } = runAddon({ script: 'emit(-0.0)' });
	assert.equal(Object.is(emitted[0], 0), true);
});

test('the playground writes whole numbers above 2^31 exactly, in SavedVariables and in its replies', { skip: needs('races.json'), timeout: 120000 }, async () => {
	const { Session } = require('../tools/play/session');
	const s = new Session({ dataDir: tmpdir('polestar-lua-json-play-') });
	await s.start();
	try {
		const r = await s.call(`return { saved = play.serialize(${LUA}), json = ${LUA} }`);
		assert.equal(r.ok, true, r.error);
		assert.deepEqual(new Function(`return [${r.value.saved.replace(/^\{|\}$/g, '')}]`)().map(Number), NUMBERS);
		// The replies write whole numbers exactly only below 1e15 (driver.lua enc()).
		assert.deepEqual(r.value.json.filter((_, i) => Math.abs(NUMBERS[i]) < 1e15), NUMBERS.filter((v) => Math.abs(v) < 1e15));
	} finally {
		await s.stop({ save: false });
	}
});
