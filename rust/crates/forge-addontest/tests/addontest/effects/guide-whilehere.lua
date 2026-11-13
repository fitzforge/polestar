-- env: world
-- The Guide page's Dynamic Questing (Core/Engine.lua's While you're here; UI/GuideFrame.lua's panel; UI/WhileHere.lua's
-- toast; QoL/Buttons.lua's step key) on the whole addon, as ui-while-here.rs plays it: a guide at a wolf step far away,
-- with Kobold Camp Cleanup's vermin (8 of 10) and Candles' candles at later steps; the player walks up to the vermin's
-- camp.
local w, GF, H
local function plain(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end
local function at(x, y) w.moveTo(1429, x, y); stub.advance(0.6) end
-- The window's While you're here panel, standing (x, y): its line, or nothing.
local function panel(x, y)
	at(x, y)
	local row = H.Rows and H.Rows[1]
	local out = H:IsShown() and row and plain(row.Text:GetText()) or false
	at(47.6, 70.0)
	return out
end
local function chimes()
	local n = 0
	for _, s in ipairs(stub.sounds) do if type(s) == "string" and s:find("while%-here%.ogg$") then n = n + 1 end end
	return n
end
return {
	setup = function()
		w, GF = stub.world, Polestar.UI.GuideFrame
		H = GF.parts.here
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.setLevel(5)
		w.setZone("Elwynn Forest", "")
		w.moveTo(1429, 47.6, 70.0)
		w.onQuest(33, { 8 }, "Wolves Across the Border")
		w.onQuest(7, { { required = 10, fulfilled = 8 } }, "Kobold Camp Cleanup")
		w.onQuest(60, { { text = "Large Candle: 1/3", type = "item", required = 3, fulfilled = 1 } }, "Candles")
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/here", pack = "test", title = "Here", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Wolves", goals = { { t = "kill", target = "Young Wolf", npc = 299, count = 8, quest = 33, oi = 1, map = 1429, x = 60, y = 60 } } },
			{ title = "Vermin", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
			{ title = "Candles", goals = { { t = "collect", item = 772, itemName = "Large Candle", count = 3, quest = 60, oi = 1, map = 1429, x = 52.0, y = 35.1,
				spots = { { x = 52.0, y = 35.1, r = 15, n = 3 }, { x = 53.0, y = 36.0, r = 10, n = 2 } } } } },
		} })
		Polestar.Engine.SetGuide("test/here")
		-- A friendly flight master by the road at 30,60, its flight path not learned (Nav's travel data, its point on
		-- the game's frame, as engine-while-here.rs's flight paths have it).
		Polestar.Nav.RegisterTravelData({ build = "test", taxi = { { 2, 0, -700, 600, 1429, 30, 60, 1, "Brackwell Pumpkin Patch, Elwynn Forest" } } }, true)
		Polestar.MapFrames.era[1429] = { c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }
		-- A herbalist, and a spot at 40,50 where Peacebloom can grow, far from the rest (Core/Gather.lua's data: x, then
		-- y, two base-60 digits each in 3599ths of the map).
		w.learnSkill(182, "Herbalism", 1, 75)
		Polestar.Gather.Register({ kinds = { { "Peacebloom", 182, 1, 1618 } }, maps = { [1429] = "e;1:O0U0" } })
		-- The quests put in the log above, as the client announces a log change.
		stub.fire("QUEST_LOG_UPDATE")
		stub.advance(0.6)
	end,
	settle = 0.3,
	probes = {
		-- 50 yd from the vermin.
		["behavior.whileHere"] = function() return panel(47.6, 37.6) end,
		-- 250 yd from them: out of 180 yd's reach, within 400's.
		["behavior.whileHereRadius"] = function() return panel(47.6, 47.6) end,
		-- Walking up to them in a new stay in the zone (a line chimes once a stay): the chime for the new line.
		["behavior.whileHereSound"] = function()
			stub.advance(31)
			w.setZone("Westfall")
			w.setZone("Elwynn Forest", "")
			local before = chimes()
			panel(47.6, 37.6)
			return chimes() - before
		end,
		-- 10 yd from the flight master, far from the guide's own work: its line.
		["behavior.whileHereFlights"] = function() return panel(30, 60.5) end,
		-- 6 yd from the Peacebloom spot: its line.
		["behavior.whileHereGather"] = function() return panel(40.2, 50) end,
		-- The toast that says a suggestion while the window is hidden (UI/WhileHere.lua), shown afresh: still there
		-- 10 s on.
		["toasts.whilehere.seconds"] = function()
			local T = Polestar.UI.WhileHereToast
			T.Show({ t = "kill", hereText = "Kill Kobold Vermin  8/10", yards = 50, step = 2, index = 1 })
			stub.advance(10)
			local out = PolestarWhileHereToast:IsShown()
			T.Hide()
			stub.advance(1)
			return out
		end,
		-- By the vermin: the step key's macro tries them after the step's own wolves.
		["behavior.whileHereStepKey"] = function()
			at(47.6, 37.6)
			stub.runTimers()
			local macro = PolestarStepButton:GetAttribute("macrotext") or ""
			at(47.6, 70.0)
			return macro:find("Kobold Vermin", 1, true) ~= nil
		end,
	},
}
