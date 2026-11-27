'use strict';
// #4272: a quest item no quest needs any more (handed in, grey, abandoned or
// never taken, not for this character) gets the red leftover border, its
// tooltip says why quest by quest, and the bag-space button may delete it
// once no quest in the log asks for it.
const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const SETUP = `state = { done = {}, log = {}, level = {}, avail = {}, starts = {}, ahead = {}, objectives = {}, plevel = 30 }
	C_QuestLog = {
		IsOnQuest = function(id) return state.log[id] == true end,
		IsQuestFlaggedCompleted = function(id) return state.done[id] == true end,
		IsRepeatableQuest = function() return false end,
	}`;

const STUBS = `
	local Q, s = Polestar.QuestDB, state
	Q.IsRunning = function() return true end
	Q.ItemQuests = function(id) return ({ [1] = { 10 }, [2] = { 20 }, [3] = { 30 }, [4] = { 40 }, [5] = { 50 }, [6] = { 60, 61 } })[id] end
	Q.GetQuestLevel = function(q) return s.level[q] end
	Q.CheckAvailable = function(q) local r = s.avail[q]; if r == true then return true end; return false, r end
	Q.StartedBy = function(id) return s.starts[id] end
	Q.PlayerContext = function(_, ctx) ctx.level = s.plevel; return ctx end
	Q.ObjectivesForItem = function(id) return s.objectives[id] end
	Q.IsItemNeededAhead = function(id) return s.ahead[id] == true end
	Polestar.Compat = Polestar.Compat or {}
	Polestar.Compat.GetPlayerInfo = function() return { level = s.plevel } end
	Polestar.QoL = Polestar.QoL or {}
	Polestar.QoL.Client = Polestar.QoL.Client or {}
	Polestar.QoL.Client.CLASS_QUEST = 12
	Polestar.QoL.Client.ItemClass = function() return 12 end
	Polestar.QoL.Kept = function() return nil end
	local function why(id)
		local list = Q.LeftoverQuests(id)
		if not list then return false end
		local out = {}
		for i = 1, #list do out[i] = list[i].why end
		return table.concat(out, ",")
	end`;

test('a quest item is a leftover when its quests are done, grey, dropped or not for you', () => {
	const out = runAddon({
		before: SETUP,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/LuaChunks.lua', 'Core/BagSlots.lua', 'Quests/QuestDB.lua', 'Quests/BagMarks.lua'] }],
		script: STUBS + `
		-- Grey at 30 is 22 or lower (Q.GreyLevel).
		s.done[10] = true
		s.level[20], s.avail[20] = 12, "grey"
		s.level[30], s.avail[30] = 28, true
		s.level[40], s.avail[40] = 28, "eligibility"
		s.level[50], s.avail[50] = 28, "level"
		s.starts[5] = { 50 }
		emit({ why(1), why(2), why(3), why(4), why(5) })
		-- A grey quest in the log lets its item go, but not for the delete; a green one keeps it.
		s.log[20], s.objectives[2] = true, {}
		s.log[30], s.objectives[3] = true, {}
		emit({ why(2), Q.IsDeletableLeftover(2), why(3), Q.IsDeletableLeftover(1) })
		-- A guide ahead that takes the quest again keeps the item.
		s.ahead[1] = true
		emit(why(1))
		s.ahead[1] = nil
		-- Every quest must let it go: one handed in, one still open in the log.
		s.done[60], s.log[61], s.level[61] = true, true, 28
		emit(why(6))
		s.level[61] = 15
		emit(why(6))
	` }).emitted;
	assert.deepEqual(out, [
		['done', 'grey', 'dropped', 'other', false],
		['grey', false, false, true],
		false,
		false,
		'done,grey',
	]);
});

test('the leftover tooltip says why, quest by quest', () => {
	const out = runAddon({
		before: SETUP,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/LuaChunks.lua', 'Core/BagSlots.lua', 'Quests/QuestDB.lua', 'Quests/BagMarks.lua'] }],
		script: STUBS + `
		s.done[10] = true
		s.level[20], s.avail[20] = 12, "grey"
		s.level[30], s.avail[30] = 28, true
		Q.TooltipQuestName = function(q) return "Q" .. q, { r = 1, g = 1, b = 1 } end
		Q.Color = function() return { r = 0.5, g = 0.5, b = 0.5 } end
		local hook, lines = nil, {}
		Polestar.Hooks = {
			ItemLines = function(_, fn) hook = fn end,
			AddLine = function(_, a, b) lines[#lines + 1] = b and (a .. " " .. b) or a end,
		}
		Q.RedrawBagMarks()
		hook({}, nil, 1); hook({}, nil, 3)
		s.log[20], s.objectives[2] = true, {}
		hook({}, nil, 2)
		emit(lines)
	` }).emitted;
	assert.deepEqual(out, [[
		'Related quests completed (likely safe to delete)', 'Q10: Done',
		'No quest needs this any more (likely safe to delete)', 'Q30: Not in your log',
		'Its quest is grey: abandon it, then this is likely safe to delete', 'Q20: Grey',
	]]);
});

test('the bag-space button offers a leftover no quest in the log asks for, never a quest starter', () => {
	const out = runAddon({
		before: SETUP,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Core/LuaChunks.lua', 'Core/BagSlots.lua', 'Quests/QuestDB.lua', 'Quests/BagMarks.lua', 'QoL/QoL.lua', 'QoL/Space.lua'] }],
		script: STUBS + `
		s.done[10] = true
		s.level[20], s.avail[20] = 12, "grey"
		-- Bag 0: slot 1 item 2 (grey quest), slot 2 item 1 (handed in), slot 3 a grey-quality junk item worth 5.
		local bag = { { itemID = 2, stackCount = 1, hasNoValue = true }, { itemID = 1, stackCount = 1, hasNoValue = true }, { itemID = 77, stackCount = 1, quality = 0 } }
		local starter = {}
		local C = Polestar.QoL.Client
		C.QUALITY_POOR, C.QUALITY_COMMON = 0, 1
		C.NumBags = function() return 0 end
		C.NumSlots = function() return #bag end
		C.SlotInfo = function(_, slot) return bag[slot] end
		C.SellPrice = function() return 5 end
		C.SlotSellPrice = function() return 5 end
		C.SlotQuest = function(_, slot) return bag[slot].itemID ~= 77 end
		C.SlotStartsQuest = function(_, slot) return starter[slot] end
		Polestar.QoL.Marks = { Protected = function() return false end, Junk = function() return false end }
		local Space = Polestar.QoL.Space
		local j = Space.Cheapest()
		emit({ j.slot, j.id })
		-- Abandoning-only: a grey quest still in the log keeps its item out of the delete.
		s.log[20], s.objectives[2] = true, {}
		bag[2] = { itemID = 1, stackCount = 1, hasNoValue = true }
		starter[2] = 99
		j = Space.Cheapest()
		emit({ j.slot, j.id })
	` }).emitted;
	assert.deepEqual(out, [[1, 2], [3, 77]]);
});
