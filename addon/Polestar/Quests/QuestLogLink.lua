-- "Show in quest log": the game's quest log opened at a quest, from the menu
-- a right-click opens on a quest's row (the guide window's goals, the
-- While-here rows).
--
--   ns.ShowInQuestLog(questID) -> true when the log opened
--     The log opens at that quest (Compat.OpenQuestLog). A quest that is not
--     in the log is named in chat, nothing opens. In combat the client keeps
--     the map shut to addons, so the request waits: chat says the log opens
--     when combat ends, and it does then (PLAYER_REGEN_ENABLED), the last
--     quest asked for if several were.
--   ns.QuestLogMenuItem(questID) -> a W.ShowMenu row, or nil
--     "Show in quest log", greyed while the quest is not in the log; nil when
--     the client cannot open the log at a quest (Compat.CanOpenQuestLog: the
--     gamepad interface, a client without the opener).

local ADDON, ns = ...

local L = ns.L

local pending -- questID waiting for combat to end

local function title(questID)
	local C, Q = ns.Compat, ns.QuestDB
	return C.GetQuestTitle(questID) or (Q and Q.GetQuestTitle and Q.GetQuestTitle(questID)) or nil
end

local afterCombat

function ns.ShowInQuestLog(questID)
	local C = ns.Compat
	if type(questID) ~= "number" or not C.CanOpenQuestLog() then return false end
	if not C.IsOnQuest(questID) then
		local name = title(questID)
		ns.Print(name and string.format(L["%s isn't in your quest log."], ns.Quoted(name)) or L["That quest isn't in your quest log."])
		return false
	end
	if C.InCombat() then
		if not pending then ns.RegisterEvent("PLAYER_REGEN_ENABLED", afterCombat) end
		pending = questID
		ns.Print(L["The quest log opens when combat ends."])
		return false
	end
	return C.OpenQuestLog(questID)
end

afterCombat = function()
	local questID = pending
	pending = nil
	ns.UnregisterEvent("PLAYER_REGEN_ENABLED", afterCombat)
	if questID then ns.ShowInQuestLog(questID) end
end

function ns.QuestLogMenuItem(questID)
	if type(questID) ~= "number" or not ns.Compat.CanOpenQuestLog() then return nil end
	return { text = L["Show in quest log"], icon = "guides", disabled = not ns.Compat.IsOnQuest(questID),
		onClick = function() ns.ShowInQuestLog(questID) end }
end
