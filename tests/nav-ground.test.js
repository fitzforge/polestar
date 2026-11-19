'use strict';
const assert = require('node:assert/strict');
const test = require('node:test');
const { runAddon } = require('./helpers/lua');

test('walking distinguishes a level-one character from an unreadable level', () => {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua', 'stub_maps.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Nav/Nav.xml'] }],
		script: `
			stub.maps.useWorld()
			local d, c = Polestar.Nav.danger, Polestar.Compat
			local secret = {}
			issecretvalue = function(v) return v == secret end
			local function walk(level)
				UnitLevel = function() return level end
				return d.Blocked(0, 0, 0, 0, 10, 'Alliance', d.Level()) or 'clear'
			end
			emit({ walk(1), walk(nil), c.GetPlayerInfo().level, walk(secret), walk(-1) })`,
	});
	assert.deepEqual(emitted[0], ['clear', 'unknown-profile', 1, 'unknown-profile', 'unknown-profile']);
});
