'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

test('quest details show the existing Polestar actions for the currently viewed quest', () => {
	const { emitted } = runAddon({ script: `
		local noop = function() end
		local back = {}
		local header = { BackButton = back, GetFrameLevel = function() return 1 end }
		local onShow
		local detailsVisible = false
		local details = { BackFrame = header, IsShown = function() return detailsVisible end,
			HookScript = function(_, event, fn) assert(event == "OnShow"); onShow = fn end }
		QuestMapFrame = { DetailsFrame = details }
		C_Timer = { After = function(_, fn) fn() end }
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
			Get = function(key) return key == "lookup.enabled" end,
			Hidden = function() return hidden end, GamepadUI = function() return gamepad end,
			On = function(event, fn) assert(event == "POLESTAR_HIDDEN"); onHidden = fn end,
			CreateFrameUnder = function(_, _, parent)
				assert(parent == header)
				return { HookScript = noop, SetFrameLevel = noop, SetSize = noop,
					CreateTexture = function() return art end, CreateMaskTexture = function() return art end,
					SetHighlightTexture = noop, SetPoint = function(_, point, relative, relativePoint, x, y)
						assert(point == "LEFT" and relative == back and relativePoint == "RIGHT" and x == 4 and y == 0)
					end,
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
		assert(not shown)
		detailsVisible = true
		details.questID = 42
		onShow()
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
