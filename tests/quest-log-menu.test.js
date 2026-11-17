'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('quest log starts the selected quest guide and still offers guide search', () => {
	const { emitted } = runAddon({ script: `
		local menus, buttons = {}, {}
		Menu = { ModifyMenu = function(name, build) menus[name] = build end }
		local ns = {
			UI = { Picker = { ShowQuest = function(id) emit({ "search", id }) end } },
			Lookup = { Guide = function(kind, id) emit({ kind, id }) end },
			L = setmetatable({}, { __index = function(_, key) return key end }),
			Compat = { Readable = function(value) return value end },
			Hidden = function() return false end, GamepadUI = function() return false end,
			OnLogin = function(fn) fn() end,
		}
		assert(loadfile("addon/Polestar/UI/QuestLinks.lua"))("Polestar", ns)
		menus.MENU_QUEST_MAP_LOG_TITLE({questID = 42}, {
			QueueDivider = function() end,
			CreateButton = function(_, label, action) buttons[label] = action end,
		})
		buttons["Polestar: Show in Guides"]()
		buttons["Polestar: Start quest guide"]()
	` });
	assert.deepEqual(emitted, [['search', 42], ['quest', 42]]);
});
