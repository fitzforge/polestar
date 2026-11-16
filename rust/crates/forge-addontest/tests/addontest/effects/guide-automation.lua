-- env: world
-- The Guide page's quest-window automation (Polestar_Options/UI/Options.lua; Core/Automation.lua, Core/Closes.lua)
-- on the whole addon: a level 1 Human Warrior in Elwynn Forest whose guide takes Kobold Camp Cleanup from Marshal
-- McBride and two quests from Sven Yorgen, one of which (Sven's Revenge) closes the other (Deliveries to Sven) for
-- good, as closes.rs has them. The accepts are counted, not made, so the guide stays where it is.
local w
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
		w = stub.world
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48, 42)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/automation", pack = "test", title = "Automation", minLevel = 1, maxLevel = 30, steps = {
			{ goals = {
				{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
				{ t = "accept", quest = 164, title = "Deliveries to Sven", closedBy = { 95, 97 }, preTitles = { [95] = "Sven's Revenge", [97] = "Other Way" } },
				{ t = "accept", quest = 95, title = "Sven's Revenge" },
			} },
			{ goals = { { t = "level", level = 30 } } },
		} })
		Polestar.Engine.SetGuide("test/automation")
		stub.advance(0.5)
	end,
	probes = {
		-- Polestar takes Kobold Camp Cleanup from McBride; the game opens his next offer, one the guide skips (The
		-- Relics of Wakening): closed, or left open.
		["behavior.closeSkipped"] = function()
			counted(function() w.questDetail(197, 7) end)
			w.questDetail(197, 483, { title = "The Relics of Wakening" })
			stub.advance(0.5)
			local open = w.frame and (w.frame.kind .. " " .. tostring(w.frame.questID)) or "none"
			w.close()
			return open
		end,
		-- Sven offers Sven's Revenge: taken, or named in chat with what it closes and left to the player.
		["behavior.warnClosing"] = function()
			local said = #stub.messages
			local n = counted(function() w.questDetail(311, 95, { title = "Sven's Revenge" }) end)
			w.close()
			local line = false
			for i = said + 1, #stub.messages do
				if stub.messages[i]:find("for good", 1, true) then line = stub.messages[i]:gsub("^.-|r: ", "") end
			end
			return { accepted = n, said = line }
		end,
	},
}
