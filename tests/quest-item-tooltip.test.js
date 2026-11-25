'use strict';
const { test } = require('node:test');
const assert = require('node:assert/strict');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');

// Quest items name their quests with the level and difficulty colour: a quest
// that handed the item over while it is in the log, and a leftover's done quests.
test('quest item tooltips name the quest with its level, difficulty colour and state', () => {
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
	]);
});
