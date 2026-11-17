-- "Show in quest log": the game's quest log opened at a quest, from the menu
-- a right-click opens on a quest's row (the guide window's goals, the
-- While-here rows), or a middle-click on the row; and a shift-click that
-- links the quest in chat, as the game's own quest log does (#2545).
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
--   ns.QuestChatText(questID) -> the client's link to the quest (what a
--     shift-click in its quest log puts in chat), else its title as plain text
--     in quote marks; nil when neither can be read
--   ns.LinkQuestInChat(questID) -> true when it went into a chat box
--     ns.QuestChatText into the chat box being typed in, or a chat box opened
--     with it.
--   ns.QuestLinkMenuItem(questID) -> a W.ShowMenu row "Link in chat" with the
--     gamepad interface (no shift-click there), else nil
--   ns.QuestRowClick(questID, button) -> true when the click was the quest's
--     What a row that belongs to a quest does on top of its own clicks: a
--     middle-click shows it in the quest log, a shift-click (the game's
--     chat-link modifier) links it in chat. Any other click is the row's.
--   ns.QuestClickTips(questID, lines) -> lines, with a line naming those
--     clicks added (none without a quest, nor with the gamepad interface)

local ADDON, ns = ...

local L = ns.L

local pending -- questID waiting for combat to end

local function title(questID)
	local C, Q = ns.Compat, ns.QuestDB
	return C.GetQuestTitle(questID) or (Q and Q.GetQuestTitle and Q.GetQuestTitle(questID)) or nil
end

-- Text that goes out as it is: square brackets dropped, which the server
-- would turn into parentheses (only links may carry them).
local function plain(s)
	return (s:gsub("[%[%]]", ""))
end

function ns.QuestChatText(questID)
	local C = ns.Compat
	local link = GetQuestLink and GetQuestLink(questID)
	if type(link) == "string" and not C.IsSecret(link) and link ~= "" then return link end
	local name = C.GetQuestTitle(questID) or (ns.Names and ns.Names.Quest and ns.Names.Quest(questID))
		or (ns.QuestDB and ns.QuestDB.GetQuestTitle and ns.QuestDB.GetQuestTitle(questID))
	if type(name) == "string" and not C.IsSecret(name) and name ~= "" then return ns.Quoted(plain(name)) end
	return nil
end

function ns.LinkQuestInChat(questID)
	if type(questID) ~= "number" then return false end
	local text = ns.QuestChatText(questID)
	if not text then return false end
	local insert = (ChatFrameUtil and ChatFrameUtil.InsertLink) or ChatEdit_InsertLink
	if insert and insert(text) then return true end
	local open = (ChatFrameUtil and ChatFrameUtil.OpenChat) or ChatFrame_OpenChat
	if not open then return false end
	open(text)
	return true
end

function ns.QuestLinkMenuItem(questID)
	if type(questID) ~= "number" or not (ns.GamepadUI and ns.GamepadUI()) then return nil end
	return { text = L["Link in chat"], icon = "icon-talk", onClick = function() ns.LinkQuestInChat(questID) end }
end

function ns.QuestRowClick(questID, button)
	if type(questID) ~= "number" then return false end
	if button == "MiddleButton" then
		ns.ShowInQuestLog(questID)
		return true
	end
	if button ~= "RightButton" and IsModifiedClick and IsModifiedClick("CHATLINK") then
		ns.LinkQuestInChat(questID)
		return true
	end
	return false
end

function ns.QuestClickTips(questID, lines)
	if type(questID) ~= "number" or (ns.GamepadUI and ns.GamepadUI()) then return lines end
	local text = ns.Compat.CanOpenQuestLog() and L["Middle-click: show in quest log. Shift-click: link in chat."] or L["Shift-click: link in chat."]
	lines[#lines + 1] = { text, ns.Theme.Color("textDim") }
	return lines
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
