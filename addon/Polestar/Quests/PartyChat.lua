-- Party chat: in a party, plain chat lines about your quests that everyone in
-- the party sees, Polestar or not, each starting with a star marker:
--   "{rt1} Polestar: [Plagued Lands] Plagued Hide 5/5, Rabid Wolves 8/8"
--   "{rt1} Polestar: [Plagued Lands] is ready to turn in"
--   "{rt1} Polestar: looted [Mysterious Letter], which starts [The Dark Iron War]"
-- with the client's quest and item links. `{rt1}` is the chat token every
-- client draws as the Star raid icon (ruRU sends its own star name,
-- `{звезда}`); the marker is L["{rt1} Polestar: "]. Square brackets go out
-- only inside real links: the server rewrites plain ones. Group play's hidden
-- addon messages (Quests/Party.lua) are separate and never reach chat.
--
-- Rules: settings party.chat (objectives and ready quests) and party.chatLoot
-- (a looted item that starts a quest), both on unless the player turned them
-- off; a party or an instance group only, never solo or in a raid; only the
-- QUEST_LOG_UPDATE, PLAYER_ENTERING_WORLD and CHAT_MSG_LOOT listeners while
-- in one. Objectives of one quest finished within BATCH seconds go out as one
-- line; the read in which the quest becomes ready gives the ready line alone,
-- and drops the objectives still waiting. Each objective and each quest is
-- said at most once while the quest stays in the log: a count that drops and
-- comes back says nothing. For SETTLE seconds after login, a reload, joining a
-- party, the setting turned on or a loading screen, reads only learn the log
-- (the client fills counts in late), so nothing already done is said. Lines
-- go out GAP seconds apart, each under MAX_BYTES (the objective list is cut,
-- never a link); while the client locks chat (InChatMessagingLockdown: boss
-- encounters and the like) they wait, and one held over MAX_AGE is dropped.
-- With party.chatOnlyNeeded on, nothing goes out while every member online
-- runs Polestar (Party.AllRunPolestar). The first line sent says once per
-- account where to turn it off.
--
-- A chat filter on the party and instance channels draws Polestar's star
-- (the addon's logo) in place of the marker's token for Polestar users, drops
-- your own lines unless party.chatEcho is on, and drops other players' lines
-- with party.chatHideOthers on.

local ADDON, ns = ...
local L, LC = ns.L, ns.LC

local ipairs, pairs, type, tonumber = ipairs, pairs, type, tonumber
local concat = table.concat

local PartyChat = {}
ns.PartyChat = PartyChat

local READ_DELAY = 0.5 -- seconds after QUEST_LOG_UPDATE: one read per burst
local SETTLE = 5 -- seconds in which reads only learn the log
local BATCH = 3 -- seconds a quest's finished objectives wait for more of it
local GAP = 1.5 -- seconds between two lines
local LOCK_RETRY = 2 -- seconds between looks while chat is locked
local MAX_AGE = 120 -- seconds a line may wait
local MAX_QUEUE = 5
local MAX_BYTES = 255 -- the most a chat message carries
local ELLIPSIS = "\226\128\166"
PartyChat.MAX_BYTES = MAX_BYTES

local live = false -- in a party with party.chat or party.chatLoot on
local logLive, lootLive = false, false -- the log and loot listeners registered
local state = {} -- quest id -> { done = { [objective index] = true }, ready = bool }
local batches = {} -- quest id -> { objective text, ... } waiting BATCH seconds
local queue = {} -- { text, at } lines waiting to go out
local lootSaid = {} -- quest id -> true: its starting item was said this session
local settleUntil = 0
local readPending, pumpPending = false, false
local lastSentAt

local function grouped()
	return IsInGroup and IsInGroup() and not (IsInRaid and IsInRaid()) or false
end

local function chatType()
	if LE_PARTY_CATEGORY_INSTANCE and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then return "INSTANCE_CHAT" end
	return "PARTY"
end

local function locked()
	local C = C_ChatInfo
	return C and C.InChatMessagingLockdown and C.InChatMessagingLockdown() and true or false
end

-- Text that goes out as it is: square brackets dropped, which the server
-- would turn into parentheses (only links may carry them).
local function plain(s)
	return (s:gsub("[%[%]]", ""))
end

-- The client's link (what a shift-click on the quest puts in chat), else its
-- title as plain text; nil when neither can be read.
local function questLink(q)
	local C = ns.Compat
	local link = GetQuestLink and GetQuestLink(q)
	if type(link) == "string" and not C.IsSecret(link) and link ~= "" then return link end
	local title = C.GetQuestTitle(q) or (ns.Names and ns.Names.Quest and ns.Names.Quest(q))
		or (ns.QuestDB and ns.QuestDB.GetQuestTitle and ns.QuestDB.GetQuestTitle(q))
	if type(title) == "string" and not C.IsSecret(title) and title ~= "" then return plain(title) end
	return nil
end

-- s cut to at most n bytes, never inside a UTF-8 character.
local function cut(s, n)
	if #s <= n then return s end
	local i = n
	while i > 0 do
		local b = s:byte(i + 1)
		if b < 0x80 or b >= 0xC0 then break end
		i = i - 1
	end
	return s:sub(1, i)
end

-- The marker every line starts with.
local function marker() return L["{rt1} Polestar: "] end

-- "[Plagued Lands] Plagued Hide 5/5, Rabid Wolves 8/8": the objectives as
-- many as fit under MAX_BYTES, the rest cut to an ellipsis; nil when not even
-- the link fits.
function PartyChat.ObjectivesLine(link, texts)
	local frame = LC("party chat", "%s %s")
	local room = MAX_BYTES - #marker() - #frame:format(link, "")
	if room <= #ELLIPSIS or #texts == 0 then return nil end
	local sep = LC("party chat", ", ")
	for n = #texts, 1, -1 do
		local list = concat(texts, sep, 1, n)
		if n < #texts then list = list .. sep .. ELLIPSIS end
		if #list <= room then return frame:format(link, list) end
	end
	return frame:format(link, cut(texts[1], room - #ELLIPSIS) .. ELLIPSIS)
end

-- Once per account, with the first line: where to turn it off.
local function tellOnce()
	local db = ns.DB()
	if db.partyChatTold then return end
	db.partyChatTold = true
	ns.Print(L["Polestar told your party about your quest progress in chat (Options > Questing > Quests > Group to change this)."])
end

-- Every member online runs Polestar, and the player asked to stay quiet then.
local function allHavePolestar()
	local P = ns.Party
	return ns.Get("party.chatOnlyNeeded") and P and P.AllRunPolestar and P.AllRunPolestar() or false
end

local function pump()
	pumpPending = false
	local now = GetTime()
	while queue[1] and now - queue[1].at > MAX_AGE do table.remove(queue, 1) end
	if not queue[1] then return end
	local send = (C_ChatInfo and C_ChatInfo.SendChatMessage) or SendChatMessage
	if not (live and send) or allHavePolestar() then
		queue = {}
		return
	end
	local wait
	if locked() then
		wait = LOCK_RETRY
	elseif lastSentAt and now - lastSentAt < GAP then
		wait = GAP - (now - lastSentAt)
	end
	if not wait then
		local line = table.remove(queue, 1)
		send(line.text, chatType())
		lastSentAt = now
		tellOnce()
		if not queue[1] then return end
		wait = GAP
	end
	pumpPending = true
	ns.After(wait, pump)
end

local function say(text)
	if not text or #queue >= MAX_QUEUE then return end
	text = marker() .. text
	if #text > MAX_BYTES then return end
	queue[#queue + 1] = { text = text, at = GetTime() }
	if not pumpPending then pump() end
end

-- "Plagued Hide 5/5": the objective's name as the log words it, and its counts.
local function objectiveText(o)
	if ns.Compat.IsSecret(o.text) then return nil end
	local label = plain(ns.Compat.ObjectiveLabel(o.text))
	local counts = o.numFulfilled .. "/" .. o.numRequired
	if label == "" then return counts end
	return label .. " " .. counts
end

local function flushBatch(q, b)
	if batches[q] ~= b then return end
	batches[q] = nil
	if not logLive or #b == 0 then return end
	local link = questLink(q)
	if link then say(PartyChat.ObjectivesLine(link, b)) end
end

-- A quest first seen is learned, never said. `finished` is the client's
-- verdict on an objective: Forever can report 1/1 on one not done yet.
local function check(q, objs, quiet)
	local C = ns.Compat
	local ready = C.IsQuestReadyForTurnIn(q)
	local s = state[q]
	if not s then
		s = { done = {}, ready = ready }
		for i, o in ipairs(objs) do
			if o.finished then s.done[i] = true end
		end
		state[q] = s
		return
	end
	local newly = {}
	for i, o in ipairs(objs) do
		if o.finished and not s.done[i] then
			s.done[i] = true
			newly[#newly + 1] = o
		end
	end
	local nowReady = ready and not s.ready
	if nowReady then s.ready = true end
	if quiet or (not nowReady and #newly == 0) then return end
	if nowReady then
		-- The ready line says it all: objectives still waiting are dropped.
		batches[q] = nil
		local link = questLink(q)
		if link then say(L["%s is ready to turn in"]:format(link)) end
		return
	end
	local b = batches[q]
	if not b then
		b = {}
		batches[q] = b
		ns.After(BATCH, function() flushBatch(q, b) end)
	end
	for _, o in ipairs(newly) do
		local text = objectiveText(o)
		if text then b[#b + 1] = text end
	end
end

local function read()
	readPending = false
	if not logLive then return end
	local Q, C = C_QuestLog, ns.Compat
	if not (Q and Q.GetNumQuestLogEntries and Q.GetInfo) then return end
	local quiet = GetTime() < settleUntil
	local seen = {}
	for i = 1, Q.GetNumQuestLogEntries() or 0 do
		local info = Q.GetInfo(i)
		local q = info and not info.isHeader and not info.isHidden and info.questID
		if q and q > 0 and not seen[q] then
			seen[q] = true
			local objs = C.GetQuestObjectives(q)
			if objs then check(q, objs, quiet) end
		end
	end
	-- Gone from the log (turned in, abandoned): taken again, it starts over.
	for q in pairs(state) do
		if not seen[q] and not C.IsOnQuest(q) then
			state[q] = nil
			batches[q] = nil
		end
	end
end

local function onLog()
	if readPending then return end
	readPending = true
	ns.After(READ_DELAY, read)
end

local function settle()
	settleUntil = GetTime() + SETTLE
	onLog()
end

---------------------------------------------------------------------------
-- Loot that starts a quest
---------------------------------------------------------------------------

-- The client's own lines for your loot (GlobalStrings LOOT_ITEM_SELF_MULTIPLE
-- "You receive loot: %sx%d.", LOOT_ITEM_SELF "You receive loot: %s.", in the
-- client's language) as patterns capturing the item link; the multiple one
-- first, as the single one would match it too.
local lootPatterns
local function patterns()
	if lootPatterns then return lootPatterns end
	lootPatterns = {}
	for _, fmt in ipairs({ LOOT_ITEM_SELF_MULTIPLE, LOOT_ITEM_SELF }) do
		if type(fmt) == "string" then
			local p = fmt:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
			p = p:gsub("%%%%s", "(.+)", 1):gsub("%%%%d", "%%d+")
			lootPatterns[#lootPatterns + 1] = "^" .. p .. "$"
		end
	end
	return lootPatterns
end

-- The first quest item `id` starts that you have neither done nor taken,
-- from the quest database (as the item tooltip's "Starts a quest" line).
local function startedBy(id)
	local Q, C = ns.QuestDB, ns.Compat
	local list = Q and Q.StartedBy and Q.StartedBy(id)
	for _, q in ipairs(list or {}) do
		if not lootSaid[q] and not C.IsQuestCompleted(q) and not C.IsOnQuest(q) then return q end
	end
	return nil
end

local function onLoot(_, msg)
	local C = ns.Compat
	if not lootLive or type(msg) ~= "string" or C.IsSecret(msg) then return end
	local link
	for _, p in ipairs(patterns()) do
		link = msg:match(p)
		if link then break end
	end
	local id = link and tonumber(link:match("|Hitem:(%d+)"))
	local q = id and startedBy(id)
	if not q then return end
	lootSaid[q] = true
	-- A quest not taken yet: its link needs the client to know it.
	C.RequestQuest(q)
	ns.After(READ_DELAY, function()
		if not lootLive then return end
		local ql = questLink(q)
		if ql then say(L["looted %s, which starts %s"]:format(link, ql)) end
	end)
end

---------------------------------------------------------------------------
-- Listening
---------------------------------------------------------------------------

-- Listens while a setting is on and you are in a party; solo, only the
-- roster events (with a setting on).
local function apply()
	local chat, loot = ns.Get("party.chat") and true or false, ns.Get("party.chatLoot") and true or false
	local enabled = chat or loot
	if enabled then
		ns.RegisterEvent("GROUP_ROSTER_UPDATE", apply)
		ns.RegisterEvent("GROUP_LEFT", apply)
	else
		ns.UnregisterEvent("GROUP_ROSTER_UPDATE", apply)
		ns.UnregisterEvent("GROUP_LEFT", apply)
	end
	local on = enabled and grouped()
	live = on
	if not on then queue = {} end
	local wantLog, wantLoot = on and chat, on and loot
	if wantLog ~= logLive then
		logLive = wantLog
		if wantLog then
			ns.RegisterEvent("QUEST_LOG_UPDATE", onLog)
			ns.RegisterEvent("PLAYER_ENTERING_WORLD", settle)
			settle()
		else
			ns.UnregisterEvent("QUEST_LOG_UPDATE", onLog)
			ns.UnregisterEvent("PLAYER_ENTERING_WORLD", settle)
			state, batches = {}, {}
		end
	end
	if wantLoot ~= lootLive then
		lootLive = wantLoot
		if wantLoot then
			ns.RegisterEvent("CHAT_MSG_LOOT", onLoot)
		else
			ns.UnregisterEvent("CHAT_MSG_LOOT", onLoot)
		end
	end
end

---------------------------------------------------------------------------
-- The chat filter: Polestar's star for Polestar users
---------------------------------------------------------------------------

-- The tokens the marker starts with in every language (the locales'
-- L["{rt1} Polestar: "]: "{rt1} Polestar: ", frFR "{rt1} Polestar : ",
-- ruRU "{звезда} Polestar: ").
local TOKENS = { "{rt1}", "{звезда}" }
PartyChat.ICON = "|TInterface\\AddOns\\" .. ADDON .. "\\Media\\UI\\logo:0|t"

-- A line's marker token length, nil when it is no Polestar line.
function PartyChat.MarkerToken(msg)
	if type(msg) ~= "string" or ns.Compat.IsSecret(msg) then return nil end
	for _, t in ipairs(TOKENS) do
		if msg:sub(1, #t) == t and msg:find("^ Polestar ?: ", #t + 1) then return #t end
	end
	return nil
end

-- ChatFrameUtil.AddMessageEventFilter's callback: true drops the line;
-- false and the arguments shows it with them.
local function filter(_, _, msg, author, ...)
	local n = PartyChat.MarkerToken(msg)
	if not n then return false end
	if ns.Compat.SenderIsMe(author) then
		if not ns.Get("party.chatEcho") then return true end
	elseif ns.Get("party.chatHideOthers") then
		return true
	end
	return false, PartyChat.ICON .. msg:sub(n + 1), author, ...
end

local FILTERED = { "CHAT_MSG_PARTY", "CHAT_MSG_PARTY_LEADER", "CHAT_MSG_INSTANCE_CHAT", "CHAT_MSG_INSTANCE_CHAT_LEADER" }
local filtering = false
local function addFilter()
	local add = (ChatFrameUtil and ChatFrameUtil.AddMessageEventFilter) or ChatFrame_AddMessageEventFilter
	if filtering or not add then return end
	filtering = true
	for _, ev in ipairs(FILTERED) do add(ev, filter) end
end

ns.OnLogin(function()
	addFilter()
	apply()
end)
ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and (path == "" or path == "party" or path:find("^party%.chat")) and ns.IsLoggedIn() then
		apply()
	end
end)
