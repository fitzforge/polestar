'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

test('obsolete quest item marks require every known quest to be turned in and non-repeatable', () => {
	const fixture = path.join(__dirname, 'fixtures', 'questdb', 'expected', 'Quests.lua');
	const out = runAddon({
		before: `state = { items = {}, done = {}, log = {}, repeatable = {} }
			C_QuestLog = {
				IsOnQuest = function(id) return state.log[id] == true end,
				IsQuestFlaggedCompleted = function(id) return state.done[id] == true end,
				IsRepeatableQuest = function(id) return state.repeatable[id] == true end,
			}`,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/LuaChunks.lua', 'Core/BagSlots.lua', 'Quests/QuestDB.lua', 'Quests/BagMarks.lua'] }],
		script: `
		local Q, q = Polestar.QuestDB, state
		dofile(${JSON.stringify(fixture.replace(/\\/g, '/'))})
		local fields = {}
		for i = 1, 20 do fields[i] = "" end
		fields[1], fields[12] = "'After an event", "{4,1,,2,901,"
		Q.AddChunk("quests", 9000, 9000, string.char(10) .. "9000" .. string.char(9) .. table.concat(fields, ";") .. string.char(10))
		Q.SetMeta({})
		Q.IsRunning = function() return true end
		Q.ObjectivesForItem = function() return nil end
		Q.IsItemNeededAhead = function() return false end
		Polestar.QoL = { Client = { CLASS_QUEST = 12, ItemClass = function(id) return q.items[id] end }, Kept = function() return nil end }
		for _, id in ipairs({ 750, 1972, 772, 901, 999 }) do q.items[id] = 12 end
		-- The index is built over the next frames (Q.ITEM_SLICE quests each).
		Q.ItemQuests(750)
		stub.advance(0.5)
		emit({ Q.ItemQuests(750), Q.ItemQuests(1972), Q.ItemQuests(772), Q.ItemQuests(901) or false, Q.ItemQuests(999) or false })
		q.done[33] = true
		emit(Q.IsObsoleteQuestItem(750))
		q.log[33] = true
		emit(Q.IsObsoleteQuestItem(750))
		q.log[33] = nil
		q.repeatable[33] = true
		emit(Q.IsObsoleteQuestItem(750))
		q.repeatable[33] = nil
		q.items[750] = 0
		emit(Q.IsObsoleteQuestItem(750))
		q.items[750] = 12
		emit(Q.IsObsoleteQuestItem(772))
		q.done[19], q.done[60] = true, true
		emit(Q.IsObsoleteQuestItem(772))
		q.done[9000] = true
		emit(Q.IsObsoleteQuestItem(901))
		local needed = Q.ObjectivesForItem
		Q.ObjectivesForItem = function(id) if id == 772 then return {} end end
		emit(Q.IsObsoleteQuestItem(772))
		Q.ObjectivesForItem = needed
		local kept = Polestar.QoL.Kept
		Polestar.QoL.Kept = function(id) if id == 772 then return 1 end end
		emit(Q.IsObsoleteQuestItem(772))
		Polestar.QoL.Kept = kept
		emit(Q.IsObsoleteQuestItem(999))
		C_QuestLog.IsRepeatableQuest = nil
		emit(Q.IsObsoleteQuestItem(750))
		C_QuestLog.IsRepeatableQuest = function() return false end
		local item = 750
		C_Container = { GetContainerItemID = function() return item end }
		local frame = CreateFrame("Frame")
		local button = CreateFrame("Button", nil, frame)
		button:SetSize(37, 37)
		button:SetID(1)
		button.GetBagID = function() return 0 end
		frame.UpdateItems = function() end
		frame.EnumerateValidItems = function() return ipairs({ button }) end
		ContainerFrameContainer = { ContainerFrames = { frame } }
		Polestar.SafeCall = function(fn, ...) return fn(...) end
		Q.RedrawBagMarks()
		local border = button:GetRegions()
		emit(border and border:IsShown() or false)
		item = 999
		Q.RedrawBagMarks()
		emit(border:IsShown())
		local hook, lines = nil, {}
		Polestar.Hooks = {
			ItemLines = function(_, fn) hook = fn end,
			AddLine = function(_, line) lines[#lines + 1] = line end,
		}
		Polestar.Set("qol.questTooltips", false)
		Q.RedrawBagMarks()
		hook({}, nil, 750)
		hook({}, nil, 999)
		emit(lines)
		Polestar.Set("qol.questBagMarks", false)
		Q.RedrawBagMarks()
		emit(hook == nil)
	` }).emitted;
	assert.deepEqual(out, [
		[[33], [17], [19, 60], [9000], false], true, false, false, false, false, true, true, false, false, false, false, true, false,
		['Related quests completed (likely safe to delete)'], true,
	]);
});

// Fitz's 0.4.3-rc probe: the bags' first paint after login read every quest record for the leftover borders' index
// (Q.ItemQuests) in one 130 ms frame. The index is built Q.ITEM_SLICE quests a frame; until it is in, an item has no
// quests (no border), and once it is the bags repaint (QUESTDB_ITEM_QUESTS).
test('the item-to-quests index is built a slice of quests a frame and the bags repaint once it is in', () => {
	const fixture = path.join(__dirname, 'fixtures', 'questdb', 'expected', 'Quests.lua');
	const out = runAddon({
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/LuaChunks.lua', 'Core/BagSlots.lua', 'Quests/QuestDB.lua', 'Quests/BagMarks.lua'] }],
		script: `
		local Q = Polestar.QuestDB
		dofile(${JSON.stringify(fixture.replace(/\\/g, '/'))})
		Q.SetMeta({})
		local n = #Q.QuestIds()
		Q.ITEM_SLICE = 1
		local redraws = 0
		Polestar.On("QUESTDB_ITEM_QUESTS", function() redraws = redraws + 1 end)
		local first = Q.ItemQuests(772)
		local frames = 0
		while Q.ItemQuests(772) == nil and frames < n + 5 do stub.advance(0.05); frames = frames + 1 end
		emit({ first = first or false, frames = frames >= n - 1 and frames <= n + 1, quests = Q.ItemQuests(772), redraws = redraws })
	` }).emitted;
	assert.deepEqual(out, [{ first: false, frames: true, quests: [19, 60], redraws: 1 }]);
});
