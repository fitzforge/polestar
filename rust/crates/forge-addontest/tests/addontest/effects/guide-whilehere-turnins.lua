-- env: world
-- The Guide page's Dynamic Questing hand-ins (Core/Engine.lua: Own.hereBuild's detour), as engine-while-here.rs's
-- turn-in tests play them: the arrow leading west to the wolves, A Fishy Peril ready to hand in to Marshal Dughan
-- 60 yd east of the player (21 s out of the way), in town or not.
local w, E
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
local function at(x, y) w.moveTo(1429, x, y); stub.advance(0.6) end
-- Walking up from far off (a line shown stays a little past its limit): the line by Dughan, or none.
local function here()
	at(75.0, 80.0)
	at(40.0, 35.1)
	local v = E.GetWhileHere()
	return v and plain(v.hereText) or false
end
local ELSEWHERE = { title = "Bandits", goals = { { t = "kill", target = "Defias Bandit", npc = 116, count = 2, quest = 88, oi = 1, map = 1429, x = 30.0, y = 80.0 } } }
return {
	setup = function()
		w, E = stub.world, Polestar.Engine
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.setLevel(5)
		w.setZone("Elwynn Forest", "")
		w.moveTo(1429, 40.0, 35.1)
		w.onQuest(33, { 8 }, "Wolves Across the Border")
		w.onQuest(7, { { required = 10, fulfilled = 8 } }, "Kobold Camp Cleanup")
		w.onQuest(40, {}, "A Fishy Peril")
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/turnins", pack = "test", title = "Turnins", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 20.0, y = 35.1 } } },
			ELSEWHERE, ELSEWHERE,
			{ title = "Dughan", goals = {
				{ t = "turnin", quest = 40, title = "A Fishy Peril", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1 },
				{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 240, npcName = "Marshal Dughan", map = 1429, x = 42.0, y = 35.1 },
			} },
		} })
		E.SetGuide("test/turnins")
		-- The quests put in the log above, as the client announces a log change.
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6)
	end,
	settle = 0.3,
	probes = {
		-- In town (the inn's rest area), where any detour does: the hand-in line, or none.
		["behavior.whileHereTurnins"] = { prepare = function() w.resting = true end, cleanup = function() w.resting = false end, probe = here },
		-- Out of town: 21 s out of the way, over 20 s, within 60.
		["behavior.whileHereTurninSeconds"] = here,
	},
}
