-- env: world
-- Guide > Window > Pause (Polestar_Options/UI/Options.lua; Core/Init.lua, Core/Pause.lua, Core/Automation.lua,
-- Nav/Layers.lua; #1937) on the whole addon: a character in Elwynn Forest, away from the step
-- that takes Kobold Camp Cleanup from Marshal McBride and Wolves Across the Border from Eagan Peltskinner, the world
-- map open on Elwynn. The switch steps the guide window and the arrow aside; paused, its two extras take the step's
-- map pins and the quest window's automation along. The accepts are counted, not made, so the step stays.
local w, P
local function paused() Polestar.SetPaused(true, "hand") end
local function resumed() Polestar.SetPaused(false, "hand") end
-- The world map's pins of the step's goals (Nav/Layers.lua's nav.goals), after a map frame.
local function goalPins()
	stub.advance(0.1)
	stub.runMapFrame(WorldMapFrame, 0)
	local n = 0
	for _, f in ipairs(P.GetWorldFrames("pins")) do
		if f.data and f.data.layer and f.data.layer.name == "nav.goals" then n = n + 1 end
	end
	return n
end
-- Opens a quest window (fn) with AcceptQuest counting instead of accepting. -> calls
local function counted(open)
	local real, n = AcceptQuest, 0
	AcceptQuest = function() n = n + 1 end
	open()
	stub.advance(0.5)
	AcceptQuest = real
	return n
end
return {
	setup = function()
		w, P = stub.world, Polestar.Pins
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 40, 50)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/pause", pack = "test", title = "Pause", minLevel = 1, maxLevel = 30, steps = {
			{ goals = {
				{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
				{ t = "accept", quest = 33, title = "Wolves Across the Border", npc = 196, npcName = "Eagan Peltskinner", map = 1429, x = 48.9, y = 40.1 },
			} },
			{ goals = { { t = "level", level = 30 } } },
		} })
		Polestar.Engine.SetGuide("test/pause")
		stub.worldMapID = 1429
		WorldMapFrame:Show()
		stub.advance(0.5)
	end,
	settle = 0.3,
	probes = {
		-- The guide window and the arrow: up, or stepped aside.
		["Guide:Pause"] = function()
			stub.runTimers()
			return { window = PolestarGuideFrame:IsShown() and true or false, arrow = PolestarNavArrow:IsShown() and true or false }
		end,
		-- Paused: the step's goals on the world map, or gone with the pause.
		["pause.map"] = { prepare = paused, cleanup = resumed, probe = goalPins },
		-- Paused: McBride offers Kobold Camp Cleanup; taken, or left to the player until Polestar resumes.
		["pause.automation"] = { prepare = paused, cleanup = resumed, probe = function()
			local n = counted(function() w.questDetail(197, 7) end)
			w.close()
			return n
		end },
	},
}
