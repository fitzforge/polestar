-- env: world
-- The Guide page's route rows (Polestar_Options/UI/Options.lua; Core/Engine.lua) on the whole addon, each on a
-- guide shaped like its engine test's: a quest the route passed abandoned (engine-lost-quest.rs), a group quest
-- (engine-group-default.rs), a dungeon's pick-up in the route (engine-dungeon-route.rs), a grey quest at level 20
-- (engine-smart.rs), a deathskip (engine-die.rs), and a guide with a step skipped by hand for Reset guide progress.
-- A level 1 Human Warrior in Elwynn Forest.
local w, E
local function flush() stub.advance(0.6) end
local function open(id)
	E.SetGuide(id)
	stub.fire("QUEST_LOG_UPDATE")
	flush()
end
local level
return {
	setup = function()
		w, E = stub.world, Polestar.Engine
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.addMap(1411, { name = "Durotar", c = 1, left = -1962.5, right = -7250, top = 1808.333, bottom = -1716.667 })
		w.moveTo(1429, 48, 42)
		w.titles[783] = "A Threat Within"
		w.titles[7] = "Kobold Camp Cleanup"
		UnitIsDeadOrGhost = UnitIsDeadOrGhost or function() return false end
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/lost", pack = "test", title = "Lost", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Deputy Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
			{ title = "Marshal McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
			{ title = "Trainer", goals = { { t = "train", npc = 911, npcName = "Llane Beshere" } } },
		} })
		Polestar.RegisterGuide({ id = "test/group", pack = "test", title = "Group", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Group quest", when = { { k = "group", q = 7 } }, goals = {
				{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			} },
			{ title = "The solo way", when = { { k = "group", q = 7, neg = true } }, goals = { { t = "task", text = "Pull one at a time" } } },
			{ title = "Marshal McBride", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		} })
		Polestar.RegisterGuide({ id = "test/grey", pack = "test", title = "Grey", minLevel = 15, maxLevel = 25, steps = {
			{ goals = { { t = "accept", quest = 101, title = "Grey alone", qlvl = 2 } } },
			{ goals = { { t = "accept", quest = 104, title = "Current", qlvl = 19 } } },
			{ goals = { { t = "level", level = 30 } } },
		} })
		Polestar.RegisterGuide({ id = "test/die", pack = "test", title = "Die", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Deathskip to Sen'jin Village", goals = { { t = "die", location = "Sen'jin Village", map = 1411, x = 57.2, y = 73.3, f = "e" } } },
			{ title = "Razor Hill", goals = { { t = "accept", quest = 840, title = "Conscript of the Horde", npc = 3336, npcName = "Takrin Pathseeker", map = 1411, x = 50.8, y = 43.6 } } },
		} })
		Polestar.RegisterGuide({ id = "test/reset", pack = "test", title = "Reset", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "accept", quest = 201, title = "First" } } },
			{ goals = { { t = "accept", quest = 202, title = "Second" } } },
			{ goals = { { t = "accept", quest = 203, title = "Third" } } },
		} })
		-- A dungeon in the route (engine-dungeon-route.rs): its pick-up ahead of the live step, behind `when dungeon`.
		Polestar.RegisterGuide({ id = "test/dungeon", pack = "test", title = "Dungeon", minLevel = 1, maxLevel = 30, steps = {
			{ title = "Marshal McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
			{ title = "Scout Riell", when = { { k = "dungeon", name = "The Deadmines", map = 36 } }, goals = {
				{ t = "accept", quest = 214, title = "Red Silk Bandanas", npc = 6087, npcName = "Scout Riell", map = 1429, x = 49.5, y = 41.0 },
			} },
			{ title = "Deputy Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		} })
		open("test/reset")
	end,
	probes = {
		-- Kobold Camp Cleanup, taken (the route at the trainer), abandoned: the guide holds and asks, or goes back
		-- for it at once. The quest taken again afterwards.
		["behavior.lostQuests"] = { prepare = function()
			w.onQuest(783, {})
			w.onQuest(7, {})
			open("test/lost")
		end, probe = function()
			w.abandon(7); flush()
			local q = E.LostQuestion()
			local out = { live = E.GetLiveStep(), asks = q or false }
			if q then E.AnswerLost(q, "back"); flush() end
			w.onQuest(7, {}); stub.fire("QUEST_LOG_UPDATE"); flush()
			return out
		end },
		-- Kobold Camp Cleanup marked for a group: the guide waits and asks, or takes it with a group, or the solo way.
		["behavior.groupQuests"] = { prepare = function()
			if w.log[7] then w.abandon(7) end
			w.onQuest(783, {})
			open("test/group")
		end, probe = function() return { at = E.GetLiveStep(), asks = E.GroupQuestion() or false } end },
		-- The Deadmines' pick-up ahead: no number for a character who skips it (the solo route's numbers), its own
		-- number when asked about or run.
		["behavior.dungeons"] = { prepare = function() open("test/dungeon") end, probe = function()
			return { total = E.StepTotal(), third = (E.StepNumber(3)), pickup = select(2, E.StepNumber(2)) }
		end },
		-- At level 20, a level 2 quest: left out (the route on the next), or the guide's first step.
		["behavior.skipGrey"] = { prepare = function()
			level = w.level
			w.setLevel(20)
			open("test/grey")
		end, probe = function() return E.GetLiveStep() end, cleanup = function() w.setLevel(level) end },
		-- A deathskip to Sen'jin Village: the guide's step, or passed.
		["behavior.deathskips"] = { prepare = function() open("test/die") end, probe = function()
			return { at = E.GetLiveStep(), status = E.GetStepView(1).goals[1].status }
		end },
		-- The first step skipped by hand: back once reset.
		["Guide:Reset guide progress"] = { press = true, prepare = function()
			open("test/reset")
			E.Skip(); flush()
		end, probe = function() return E.GetLiveStep() end },
	},
}
