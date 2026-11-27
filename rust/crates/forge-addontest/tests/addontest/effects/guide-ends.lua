-- env: world
-- The Guide page's guide rows (Polestar_Options/UI/Options.lua; Core/Engine.lua) on the whole addon: an Orc Warrior
-- in Durotar, as engine-guide-end.rs and engine-routes.rs have them. Each check finishes a fresh leveling guide of
-- two quests: the guide-end window asks, or The Barrens loads in its tab; a guide that offers The Barrens or
-- Silverpine Forest asks where to go, or takes the recommended zone. The guide opened at login when no tab is
-- saved. And Polestar Experimental's guides (Core/Guides.lua, Guides.OWN_EXTRA), one registered into the pack
-- Polestar registers itself (Polestar/Experimental), listed with ours or taken out.
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
	Polestar.RegisterGuide({ id = "polestar-experimental/barrens", pack = "polestar-experimental", title = "The Barrens (experimental)", faction = "Horde",
		minLevel = 10, maxLevel = 20, zone = 1413, zoneName = "The Barrens", steps = { { goals = { { t = "level", level = 20 } } } } })
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
		-- The guides the guide menu lists (Guides.List): the experimental Barrens guide among them, or not.
		["behavior.experimentalGuides"] = function()
			local out = {}
			for _, g in ipairs(Polestar.Guides.List()) do
				if Polestar.Guides.IsExperimental(g) then out[#out + 1] = g.id end
			end
			return table.concat(out, ",")
		end,
		-- The quests off the route (#4288): two in the log no guide takes, one a dungeon's (the dungeon mark,
		-- Dungeons.QuestMark, given for the check); counted, or the dungeon's left out.
		["guideWindow.offRouteDungeons"] = {
			prepare = function()
				Polestar.RegisterGuide({ id = "test/offroute", pack = "test", title = "Off route", faction = "Horde", minLevel = 1, maxLevel = 12, zone = 1411,
					steps = { { goals = { { t = "accept", quest = 4641, title = "Your Place In The World", map = 1411, x = 42, y = 68 } } } } })
				w.onQuest(1901, nil, "A dungeon's quest")
				w.onQuest(1902, nil, "Another quest")
				stub.fire("QUEST_LOG_UPDATE"); flush()
				local D = Polestar.Dungeons
				D.psQuestMark = D.QuestMark
				D.QuestMark = function(q) if q == 1901 then return { key = "ragefire" } end end
			end,
			probe = function()
				local list = Polestar.RoutePlan.OffRoute("test/offroute")
				if not list then return false end
				local out = {}
				for i, r in ipairs(list) do out[i] = r.quest end
				return table.concat(out, ",")
			end,
			cleanup = function()
				local D = Polestar.Dungeons
				D.QuestMark, D.psQuestMark = D.psQuestMark, nil
			end },
	},
}
