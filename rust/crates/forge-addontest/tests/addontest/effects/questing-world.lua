-- env: world
-- The Questing page's quest automation, objective clicks and its two buttons (Core/Automation.lua,
-- UI/NameTargets.lua, QoL/Options.lua) on the whole addon: a guide at a step handing in A Threat Within to
-- Marshal McBride and taking Kobold Camp Cleanup from him, and killing Kobold Vermin. The quest windows open as in
-- automation.rs; the accept and the hand-in are counted, not made, so the guide stays where it is.
local w
-- Opens a quest window (fn), counts the call the automation makes on it at once, closes it.
local function counted(name, open)
	local real, n = _G[name], 0
	_G[name] = function() n = n + 1 end
	open()
	stub.advance(0.1)
	_G[name] = real
	w.close()
	return n
end
local function options()
	local O = Polestar.UI.Options
	return { shown = PolestarOptions ~= nil and PolestarOptions:IsShown() or false, page = O.page and O.page.key or false }
end
local function hideOptions() if PolestarOptions then PolestarOptions:Hide() end end
return {
	setup = function()
		w = stub.world
		w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
		w.moveTo(1429, 48, 42)
		Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 1, title = "Test", author = "Test", version = "1", license = "MIT" })
		Polestar.RegisterGuide({ id = "test/questing", pack = "test", title = "Questing", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
			{ goals = {
				{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
				{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
				{ t = "kill", quest = 7, target = "Kobold Vermin", count = 10, map = 1429, x = 47, y = 35 },
			} },
		} })
		w.onQuest(783, { { required = 1, fulfilled = 1 } })
		Polestar.Engine.SetGuide("test/questing")
		-- The client's secure state driver (the objective clicks' holder hides in combat by it).
		RegisterStateDriver = RegisterStateDriver or function() end
		stub.advance(0.5)
	end,
	probes = {
		["behavior.autoAccept"] = function() return counted("AcceptQuest", function() w.questDetail(197, 7) end) end,
		["behavior.autoTurnin"] = function() return counted("CompleteQuest", function() w.questProgress(197, 783, { completable = true }) end) end,
		-- The guide window's objective rows: a secure click target over each.
		["qol.guideNameTarget"] = function()
			local n = 0
			for _, b in ipairs(Polestar.UI.NameTargets.buttons) do if b:IsShown() then n = n + 1 end end
			return n
		end,
		["Questing:Button look"] = { press = true, prepare = hideOptions, probe = options, cleanup = hideOptions },
		["Questing:Clean up quest log"] = { press = true,
			prepare = function() if PolestarQuestRoom then PolestarQuestRoom:Hide() end end,
			probe = function() return PolestarQuestRoom ~= nil and PolestarQuestRoom:IsShown() and true or false end,
			cleanup = function() if PolestarQuestRoom then PolestarQuestRoom:Hide() end end },
	},
}
