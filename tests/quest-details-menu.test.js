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
		local gamepad, hidden, shown, onHidden = true, false
		local art = { SetPoint = noop, SetSize = noop, SetTexture = noop,
			SetAllPoints = noop, SetTexCoord = noop, AddMaskTexture = noop }
		MenuUtil = { CreateContextMenu = function(_, build)
			build(nil, { QueueDivider = noop, CreateButton = function(_, label, action)
				if label == "Polestar: Show in Guides" then action() end
			end })
		end }
		local ns = {
			UI = { Picker = { ShowQuest = emit } },
			L = setmetatable({}, { __index = function(_, key) return key end }),
			Compat = { Readable = function(value) return value end },
			Hidden = function() return hidden end, GamepadUI = function() return gamepad end,
			On = function(event, fn) assert(event == "POLESTAR_HIDDEN"); onHidden = fn end,
			CreateFrameUnder = function(_, _, parent)
				assert(parent == details)
				return { HookScript = noop, SetFrameLevel = noop, SetSize = noop,
					CreateTexture = function() return art end, CreateMaskTexture = function() return art end,
					SetHighlightTexture = noop, SetPoint = noop,
					SetShown = function(_, value) shown = value end,
					SetScript = function(_, _, fn) click = fn end }
			end,
			OnLogin = function(fn) fn() end,
		}
		local loadQuestLinks = assert(loadfile("addon/Polestar/UI/QuestLinks.lua"))
		loadQuestLinks("Polestar", ns)
		assert(click == nil, "gamepad mode must not create the details button")
		gamepad = false
		loadQuestLinks("Polestar", ns)
		assert(shown)
		hidden = true
		onHidden()
		assert(not shown)
		hidden = false
		onHidden()
		assert(shown)
		click({})
		details.questID = 43
		click({})
	` });
	assert.deepEqual(emitted, [42, 43]);
});
