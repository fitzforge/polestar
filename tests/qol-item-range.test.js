'use strict';
// The client blocks item range checks in combat, on friendly targets too (#871, #1198).
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const FILES = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Theme/Theme.xml', 'QoL/QoL.xml'] };

test('item range: no check in combat on any target; still checked out of combat', () => {
	const out = runAddon({ stubs: ['stub_qol.lua'], addons: [FILES], login: true, script: `
		local C, q = Polestar.QoL.Client, stub.qol
		q.inRange = false
		q.target = { name = "Wolf", hostile = true }
		emit({ C.ItemInRange(5185) })
		q.combat(true)
		emit({ pcall(C.ItemInRange, 5185) })
		q.target = { name = "Ally", friend = true }
		emit({ pcall(C.ItemInRange, 5185) })
		q.combat(false)
		emit({ C.ItemInRange(5185) })
	` }).emitted;
	assert.deepEqual(out, [[false], [true], [true], [false]]);
});
