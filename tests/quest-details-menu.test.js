'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('quest details show the existing Polestar actions for the currently viewed quest', () => {
	const { emitted } = runAddon({ script: `
		local noop = function() end
		local details = { questID = 42, IsShown = function() return true end, GetFrameLevel = function() return 1 end }
		QuestMapFrame = { DetailsFrame = details }
		QuestMapFrame_ShowQuestDetails = noop
		hooksecurefunc = noop
		Menu = { ModifyMenu = noop }
		local click
		Spoken = { CreateRoundButton = function()
			return { HookScript = noop, SetFrameLevel = noop, ClearAllPoints = noop,
				SetPoint = noop, SetShown = noop, SetScript = function(_, _, fn) click = fn end }
		end }
		MenuUtil = { CreateContextMenu = function(_, build)
			build(nil, { QueueDivider = noop, CreateButton = function(_, label, action)
				emit(label)
				action()
			end })
		end }
		local ns = {
			UI = { Picker = { ShowQuest = emit } },
			L = setmetatable({}, { __index = function(_, key) return key end }),
			Compat = { Readable = function(value) return value end },
			Hidden = function() return false end, GamepadUI = function() return false end,
			OnLogin = function(fn) fn() end,
		}
		assert(loadfile("addon/Polestar/UI/QuestLinks.lua"))("Polestar", ns)
		click({})
		details.questID = 43
		click({})
	` });
	assert.deepEqual(emitted, ['Polestar: Show in Guides', 42, 'Polestar: Show in Guides', 43]);
});
