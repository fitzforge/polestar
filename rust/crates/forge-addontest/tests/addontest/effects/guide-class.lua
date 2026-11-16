-- env: world
-- The Guide page's class rows (Polestar_Options/UI/Options.lua; Core/Engine.lua's training reminder,
-- QoL/ClassQuests.lua) on the whole addon: a Human Warrior in Elwynn Forest with a leveling guide open; what the
-- guide window's banner shows. Each check levels the character past where the last left off: trained by Llane
-- Beshere at an even level, then one level up (due every level, not every 2); a Warrior class guide of its own,
-- registered as a pack would, then offered or not.
local w, E, GF
local k, classes = 0, 0
local function flush() stub.advance(1.2) end
local function banner()
	local B = GF.parts.banner
	return B:IsShown() and B.psKind or false
end
-- Llane Beshere's window opened and closed: the class trainer visited at this level.
local function trained()
	w.trainer(911)
	w.close()
	flush()
end
return {
	setup = function()
		w, E, GF = stub.world, Polestar.Engine, Polestar.UI.GuideFrame
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48, 42)
		w.setLevel(10)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/elwynn", pack = "test", title = "Elwynn", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
			{ goals = { { t = "level", level = 60 } } },
		} })
		E.SetGuide("test/elwynn")
		flush()
		trained()
	end,
	probes = {
		-- Trained at an even level, then one up: the reminder with the nearest trainer, or none.
		["behavior.trainReminder"] = function()
			k = k + 1
			local base = 10 + 2 * k
			w.setLevel(base); flush()
			trained()
			w.setLevel(base + 1); flush()
			local out = banner()
			trained()
			return out
		end,
		-- A Warrior class guide open at this level: the banner offers it in a tab, or says nothing. Dismissed after.
		["behavior.offerClassQuests"] = function()
			classes = classes + 1
			local id = "test/class" .. classes
			Polestar.RegisterGuide({ id = id, pack = "test", title = "Warrior quest " .. classes, category = "Class", classes = { "WARRIOR" },
				minLevel = 1, maxLevel = 60, steps = { { goals = { { t = "accept", quest = 9000 + classes, title = "Class quest " .. classes } } } } })
			Polestar.QoL.ClassQuests.Check()
			flush()
			local out = banner()
			local B = GF.parts.banner
			while B:IsShown() and B.psKind == "classQuest" do B.Close:Click(); flush() end
			return out
		end,
	},
}
