'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

// Quest lines on tooltips name the quest with its level and difficulty colour:
// a mob's objective, a quest that handed an item over while it is in the log,
// and a leftover item's done quests.
test('quest tooltips name the quest with its level, difficulty colour and state', () => {
	const fixture = path.join(__dirname, 'fixtures', 'questdb', 'expected', 'Quests.lua');
	const out = runAddon({
		before: `state = { done = {}, log = {}, ready = {} }
			C_QuestLog = {
				IsOnQuest = function(id) return state.log[id] == true end,
				IsQuestFlaggedCompleted = function(id) return state.done[id] == true end,
				IsRepeatableQuest = function() return false end,
			}
			QuestDifficultyColors = {
				impossible = { r = 1, g = 0.1, b = 0.1 }, verydifficult = { r = 1, g = 0.5, b = 0.25 },
				difficult = { r = 1, g = 0.82, b = 0 }, standard = { r = 0.25, g = 0.75, b = 0.25 },
				trivial = { r = 0.5, g = 0.5, b = 0.5 },
			}`,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/LuaChunks.lua', 'Core/BagSlots.lua', 'Quests/QuestDB.lua', 'Quests/Tooltips.lua', 'Quests/BagMarks.lua'] }],
		script: `
		local Q, s = Polestar.QuestDB, state
		dofile(${JSON.stringify(fixture.replace(/\\/g, '/'))})
		local fields = {}
		for i = 1, 20 do fields[i] = "" end
		fields[1], fields[2], fields[19] = "'Mail Run", "12", "902"
		Q.AddChunk("quests", 9001, 9001, string.char(10) .. "9001" .. string.char(9) .. table.concat(fields, ";") .. string.char(10))
		Q.SetMeta({})
		-- The item index is built over the next frames (Q.ITEM_SLICE quests each).
		Q.ItemQuests(0)
		stub.advance(0.5)
		Q.IsRunning = function() return true end
		Q.ObjectivesForItem = function() return nil end
		Q.Color = function(name) return { r = 0, g = 0, b = 0, name = name } end
		Polestar.Compat = {
			GetPlayerLevel = function() return 10 end,
			GetQuestLevel = function() return nil end,
			IsSecret = function() return false end,
			IsQuestTrivial = function(q, p) return q <= p - 6 end,
			IsOnQuest = function(id) return s.log[id] == true end,
			IsQuestCompleted = function(id) return s.done[id] == true end,
			IsQuestReadyForTurnIn = function(id) return s.ready[id] == true end,
		}
		Polestar.QoL = { Client = { CLASS_QUEST = 12, ItemClass = function() return 12 end }, Kept = function() return nil end }
		local lines
		local function round(x) return x and math.floor(x * 100 + 0.5) / 100 end
		Polestar.Hooks = {
			UnitLines = function() end,
			ItemLines = function(owner, fn) if owner == "quest-leftovers" then Polestar._leftover = fn end end,
			AddLine = function(_, l, r, cr, cg, cb) lines[#lines + 1] = { l, r or false, round(cr) or false, round(cg) or false, round(cb) or false } end,
		}
		local function hover(item)
			lines = {}
			Q.AddItemLines({}, item)
			if Polestar._leftover then Polestar._leftover({}, nil, item) end
			return lines
		end
		Polestar.Set("qol.questTooltips", true)
		Q.RedrawBagMarks()
		emit(#hover(902))
		s.log[9001] = true
		emit(hover(902))
		s.ready[9001] = true
		emit(hover(902))
		Polestar.Set("qol.questLevels", false)
		emit(hover(902))
		Polestar.Set("qol.questLevels", true)
		s.done[33] = true
		emit(hover(750))
		Q.ObjectivesForNpc = function(id)
			if id == 55 then return { { q = 9001, kind = 1, id = 55, name = "Kobold Vermin", cur = 3, max = 10, entry = { title = "Mail Run" } } } end
		end
		Q.ObjectivesForTalk = function() return nil end
		Q.ProgressText = function(o) return o.cur .. "/" .. o.max end
		Polestar.Set("qol.questTooltipsNpc", false)
		lines = {}
		Q.AddUnitLines({}, 55)
		emit(lines)
		-- The item index in, the item tooltip on show is drawn again.
		local refreshed = {}
		Polestar.Hooks.HoveredItem = function() return "link", 902 end
		Polestar.Hooks.RefreshItem = function(id) refreshed[#refreshed + 1] = id end
		Polestar.Fire("QUESTDB_ITEM_QUESTS")
		emit(refreshed)
	` }).emitted;
	assert.deepEqual(out, [
		0,
		[['[12] Mail Run:', 'In your quest log', 1, 0.82, 0]],
		[['[12] Mail Run:', 'Turn in', 1, 0.82, 0]],
		[['Mail Run:', 'Turn in', 1, 0.82, 0]],
		[
			['Related quests completed (likely safe to delete)', false, false, false, false],
			['[2] Wolves Across the Border:', 'Done', 0.5, 0.5, 0.5],
		],
		[['[12] Mail Run:', 'Kill Kobold Vermin 3/10', 1, 0.82, 0]],
		[902],
	]);
});

// qol.questTooltipsQuestie: Questie's GetTooltip leaves out the quests Polestar
// names on that mob or item, puts its entries back, and stays as it was
// with the setting off, in a group, or when Polestar's side fails.
test('Questie leaves out its lines for the quests Polestar names', () => {
	const fixture = path.join(__dirname, 'fixtures', 'questdb', 'expected', 'Quests.lua');
	const out = runAddon({
		before: `state = { log = {}, group = false }
			C_QuestLog = { IsOnQuest = function(id) return state.log[id] == true end }
			C_AddOns = C_AddOns or {}
			C_AddOns.IsAddOnLoaded = function(name) return name == "Questie" end
			IsInGroup = function() return state.group end
			questie = { lookupByKey = {} }
			function questie.GetTooltip(key)
				if questie.fail then error("questie broke") end
				local ids = {}
				for _, e in pairs(questie.lookupByKey[key] or {}) do ids[#ids + 1] = e.questId end
				table.sort(ids)
				return ids
			end
			QuestieLoader = { ImportModule = function(_, name) if name == "QuestieTooltips" then return questie end end }`,
		addons: [{ name: 'Polestar', files: ['Core/Init.lua', 'Core/LuaChunks.lua', 'Core/BagSlots.lua', 'Quests/QuestDB.lua', 'Quests/Tooltips.lua', 'Quests/QuestieLines.lua'] }],
		script: `
		local Q, s = Polestar.QuestDB, state
		dofile(${JSON.stringify(fixture.replace(/\\/g, '/'))})
		local fields = {}
		for i = 1, 20 do fields[i] = "" end
		fields[1], fields[2], fields[19] = "'Mail Run", "12", "902"
		Q.AddChunk("quests", 9001, 9001, string.char(10) .. "9001" .. string.char(9) .. table.concat(fields, ";") .. string.char(10))
		Q.SetMeta({})
		-- The item index is built over the next frames (Q.ITEM_SLICE quests each).
		Q.ItemQuests(0)
		stub.advance(0.5)
		Q.IsRunning = function() return true end
		Q.Color = function() return { r = 0, g = 0, b = 0 } end
		Q.ProgressText = function() return "3/10" end
		Q.ObjectivesForItem = function() return nil end
		Q.ObjectivesForTalk = function() return nil end
		Q.ObjectivesForNpc = function(id)
			if id == 66 then error("polestar broke") end
			if id == 55 then return { { q = 9001, kind = 1, id = 55, name = "Kobold Vermin", entry = { title = "Mail Run" } } } end
		end
		Polestar.Compat = {
			GetPlayerLevel = function() return 10 end, IsSecret = function() return false end,
			IsOnQuest = function(id) return s.log[id] == true end, IsQuestCompleted = function() return false end,
		}
		Polestar.Hooks = { UnitLines = function() end, ItemLines = function() end, AddLine = function() end }
		local errors = 0
		Polestar.NoteError = function() errors = errors + 1 end
		questie.lookupByKey.m_55 = { ["9001 1"] = { questId = 9001 }, ["9002 1"] = { questId = 9002 } }
		questie.lookupByKey.m_66 = { ["9001 1"] = { questId = 9001 } }
		questie.lookupByKey.i_902 = { ["9001 1"] = { questId = 9001 } }
		local function count(key) local n = 0 for _ in pairs(questie.lookupByKey[key]) do n = n + 1 end return n end
		Polestar.Set("qol.questTooltips", true)
		emit(questie.GetTooltip("m_55"))
		Polestar.Set("qol.questTooltipsQuestie", true)
		emit(questie.GetTooltip("m_55"))
		emit(count("m_55"))
		emit(#questie.GetTooltip("i_902"))
		s.log[9001] = true
		emit(#questie.GetTooltip("i_902"))
		s.group = true
		emit(questie.GetTooltip("m_55"))
		s.group = false
		emit({ #questie.GetTooltip("m_66"), errors })
		questie.fail = true
		emit({ pcall(questie.GetTooltip, "m_55") == false, count("m_55") })
		questie.fail = nil
		Polestar.Set("qol.questTooltips", false)
		emit(questie.GetTooltip("m_55"))
		Polestar.Set("qol.questTooltips", true)
		Polestar.Set("qol.questTooltipsQuestie", false)
		emit(questie.GetTooltip("m_55"))
	` }).emitted;
	assert.deepEqual(out, [
		[9001, 9002], [9002], 2, 1, 0, [9001, 9002], [1, 1], [true, 2], [9001, 9002], [9001, 9002],
	]);
});
