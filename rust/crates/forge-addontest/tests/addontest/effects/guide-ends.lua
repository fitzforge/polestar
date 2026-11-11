-- env: world
-- The Guide page's guide rows (Polestar_Options/UI/Options.lua; Core/Engine.lua) on the whole addon: an Orc Warrior
-- in Durotar, as engine-guide-end.rs and engine-routes.rs have them. Each check finishes a fresh leveling guide of
-- two quests: the guide-end window asks, or The Barrens loads in its tab; a guide that offers The Barrens or
-- Silverpine Forest asks where to go, or takes the recommended zone. And the guide opened at login when no tab is
-- saved.
local w, E
local n = 0
local function flush() stub.advance(0.6) end
local function world()
	w = stub.world
	w.addMap(1411, { name = "Durotar", c = 1, left = -3000, right = -6000, top = 1000, bottom = -2000 })
	w.addMap(1413, { name = "The Barrens", c = 1, left = 0, right = -3000, top = 1000, bottom = -2000 })
	w.addMap(1421, { name = "Silverpine Forest", c = 0, left = 3000, right = 0, top = 0, bottom = -3000 })
	w.race, w.raceName, w.faction, w.class = "Orc", "Orc", "Horde", "WARRIOR"
	w.moveTo(1411, 52, 43)
	Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
	Polestar.Set("behavior.suggestFrom", "test")
	Polestar.RegisterGuide({ id = "test/durotar", pack = "test", title = "Durotar", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411,
		next = "test/barrens", steps = { { goals = { { t = "accept", quest = 4641, title = "Your Place In The World", map = 1411, x = 42, y = 68 } } } } })
	Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413,
		zoneName = "The Barrens", steps = { { goals = { { t = "level", level = 20 } } } } })
	Polestar.RegisterGuide({ id = "test/silverpine", pack = "test", title = "Silverpine Forest", faction = "Horde", minLevel = 10, maxLevel = 18, zone = 1421,
		zoneName = "Silverpine Forest", steps = { { goals = { { t = "level", level = 18 } } } } })
end
-- A fresh leveling guide in Durotar, finished: its two quests taken. -> the guide in the tab then ("stays": the
-- finished one)
local function finish(choices)
	n = n + 1
	local id, q = "test/end" .. n, 1000 + n * 2
	Polestar.RegisterGuide({ id = id, pack = "test", title = "Durotar " .. n, faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411,
		next = "test/barrens", nextChoices = choices and { "test/barrens", "test/silverpine" } or nil, steps = {
			{ goals = { { t = "accept", quest = q, title = "One", map = 1411, x = 50, y = 50 } } },
			{ goals = { { t = "accept", quest = q + 1, title = "Two", map = 1411, x = 50, y = 50 } } },
		} })
	E.SetGuide(id); flush()
	w.accept(q, {}); flush()
	w.accept(q + 1, {}); flush()
	local g = E.GetGuide()
	if g and g.id == id then return "stays" end
	return g and g.id or false
end
return {
	setup = function()
		world()
		E = Polestar.Engine
	end,
	probes = {
		["behavior.guideEnd"] = function() return finish(false) end,
		-- Handed off by itself at the end ("Continue automatically"), where the route choice is made.
		["behavior.routeChoice"] = { with = { ["behavior.guideEnd"] = "continue" }, probe = function() return finish(true) end },
		-- Nothing saved, the test guides the suggestion's source: the starting guide opens, or no guide.
		["behavior.autoSelectGuide"] = { login = true, prepare = world, probe = function()
			local g = Polestar.Engine.GetGuide()
			return g and g.id or false
		end },
	},
}
