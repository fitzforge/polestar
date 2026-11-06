'use strict';
// The client blocks item range checks on non-friendly units in combat (#871).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

test('item range: no check on a hostile target in combat; still checked out of combat or on a friend', () => {
	const out = runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true, script: `
		local C, q = Polestar.QoL.Client, stub.qol
		q.inRange = false
		q.target = { name = "Wolf", hostile = true }
		emit({ C.ItemInRange(5185) })
		q.combat(true)
		emit({ pcall(C.ItemInRange, 5185) })
		q.target = { name = "Ally", friend = true }
		emit({ C.ItemInRange(5185) })
	` }).emitted;
	assert.deepEqual(out, [[false], [true], [false]]);
});
