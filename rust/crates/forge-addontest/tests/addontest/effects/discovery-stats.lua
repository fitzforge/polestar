-- env: stats
-- The Discovery page's Stats tab (Polestar_Options/Stats/Options.lua; Polestar_Stats/Collect.lua) on the whole addon
-- with the Stats addon installed, as stats.rs plays it: the character on Darkshore's map, and each check does what
-- its part counts and reads whether the count rose.
local w, S
local n = 0
local function next() n = n + 1 return n end
-- The runner also reads a check in a login of its own, without `setup`: each check places the character itself.
-- With Stats off at that login the addon is not loaded (Core/StatsPack.lua): nothing counts.
local function place()
	if S then return true end
	if not Polestar.Stats then return false end
	w = stub.world
	w.addMap(1439, { name = "Darkshore", c = 1, left = 1000, right = -1000, top = 1000, bottom = -1000 })
	w.moveTo(1439, 40, 50)
	w.money = 100000
	S = Polestar.Stats
	return true
end
return {
	setup = place,
	probes = {
		["stats.enabled"] = function()
			if not place() then return false end
			local before = S.Store().active
			S.Tick(2)
			return S.Store().active > before
		end,
		["stats.activity"] = function()
			if not place() then return false end
			local before = S.Summary().played
			S.Tick(2)
			return S.Summary().played > before
		end,
		["stats.xp"] = function()
			if not place() then return false end
			local before = #S.Store().levels
			stub.fire("PLAYER_LEVEL_UP", 20 + next())
			return #S.Store().levels > before
		end,
		["stats.quests"] = function()
			if not place() then return false end
			local before = S.Summary().accepted
			stub.fire("QUEST_ACCEPTED", 5000 + next())
			return S.Summary().accepted > before
		end,
		["stats.fights"] = function()
			if not place() then return false end
			local before = S.Summary().fights
			stub.fire("PLAYER_REGEN_DISABLED")
			return S.Summary().fights > before
		end,
		["stats.money"] = function()
			if not place() then return false end
			local before = S.Summary().spent.trainer
			stub.fire("TRAINER_SHOW")
			w.money = w.money - 10
			stub.fire("TRAINER_CLOSED")
			return S.Summary().spent.trainer > before
		end,
		["stats.heat"] = function()
			if not place() then return false end
			local _, before = S.Heat(1439, "t")
			w.moveTo(1439, 40 + next() % 20, 50)
			S.Tick(2)
			local _, after = S.Heat(1439, "t")
			return (after or 0) > (before or 0)
		end,
		["stats.path"] = function()
			if not place() then return false end
			local before = #S.Store().path
			w.moveTo(1439, 40 + next() % 20, 52)
			S.Tick(2)
			w.moveTo(1439, 40 + next() % 20, 54)
			S.Tick(2)
			return #S.Store().path > before
		end,
		["stats.travel"] = function()
			if not place() then return false end
			local before = S.Summary().flights
			w.onTaxi = true
			S.Tick(2)
			w.onTaxi = false
			S.Tick(2)
			return S.Summary().flights > before
		end,
		["stats.character"] = function()
			if not place() then return false end
			local before = #S.Store().dungeons
			local inside = true
			local was = IsInInstance
			IsInInstance = function() if inside then return true, "party" end return false end
			S.Tick(2)
			inside = false
			S.Tick(2)
			IsInInstance = was
			return #S.Store().dungeons > before
		end,
	},
}
