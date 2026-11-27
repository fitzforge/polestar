-- Polestar Group Finder: keeping the game's notices about our own traffic
-- out of the chat.
--
-- Two kinds of lines are side effects of the finder, not news for the player:
--   * "No player named X is currently playing." after an addon whisper to a
--     player who logged off since (answers, updates, group requests). Hidden
--     only for a name we whispered in the last WHISPER_TTL seconds, so a
--     whisper the player typed still reports normally.
--   * The notices of the hidden PSGroupFinder channel (joined, left, changed).
-- With /polestar finder debug on, nothing is hidden.

local _, ns = ...

local ChatFilter = {}
ns.ChatFilter = ChatFilter

local WHISPER_TTL = 10
local whispered = {} -- NameKey -> time of our last addon whisper
local notFound       -- Lua pattern built from the client's ERR_CHAT_PLAYER_NOT_FOUND_S

function ChatFilter.NoteWhisper(name)
	if type(name) == "string" then whispered[ns.NameKey(name)] = ns.Now() end
end

-- "No player named '%s' is currently playing." -> a pattern capturing the name.
local function pattern(fmt)
	if type(fmt) ~= "string" or not fmt:find("%s", 1, true) then return nil end
	local escaped = fmt:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
	return "^" .. escaped:gsub("%%%%s", "(.+)", 1) .. "$"
end

-- True when `text` reports an offline player we just whispered.
function ChatFilter.IsOurNotFound(text)
	notFound = notFound or pattern(ERR_CHAT_PLAYER_NOT_FOUND_S)
	if not (notFound and type(text) == "string") then return false end
	local name = text:match(notFound)
	if not name then return false end
	local t = whispered[ns.NameKey(name)]
	return t ~= nil and ns.Now() - t <= WHISPER_TTL
end

local function quiet() return not ns.Get("debug") end

local function onSystem(_, _, text)
	return quiet() and ChatFilter.IsOurNotFound(text)
end

-- Channel notices name the channel in one of their arguments ("5. PSGroupFinder"
-- or the base name, depending on the client): look at every string.
local function onChannelNotice(_, _, ...)
	if not quiet() then return false end
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		if type(v) == "string" and v:find(ns.Channels.NAME, 1, true) then return true end
	end
	return false
end

-- The Mainline client's ChatFrameUtil, else the older global (as Quests/PartyChat.lua).
local add = (ChatFrameUtil and ChatFrameUtil.AddMessageEventFilter) or ChatFrame_AddMessageEventFilter
if add then
	add("CHAT_MSG_SYSTEM", onSystem)
	add("CHAT_MSG_CHANNEL_NOTICE", onChannelNotice)
	add("CHAT_MSG_CHANNEL_NOTICE_USER", onChannelNotice)
end

-- Tests.
ChatFilter.OnSystem, ChatFilter.OnChannelNotice = onSystem, onChannelNotice
