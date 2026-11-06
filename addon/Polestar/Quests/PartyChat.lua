-- Party chat: in a party, one chat line when you finish one of a quest's
-- objectives ("[Polestar] Finished: Plagued Hide 5/5 - [Plagued Lands]") and
-- one when the quest is ready to turn in ("[Polestar] Ready to turn in:
-- [Plagued Lands]"), with the client's quest link. A plain party line that
-- everyone in the party sees, Polestar or not; group play's hidden addon
-- messages (Quests/Party.lua) are separate and never reach chat.
--
-- Rules: setting party.chat (on unless the player turned it off), a party or
-- an instance group only, never solo or in a raid; only the QUEST_LOG_UPDATE
-- and PLAYER_ENTERING_WORLD listeners while in one. The finishing read
-- gives the ready line alone (it says every objective is done). Each
-- objective and each quest is said at most once while the quest stays in
-- the log: a count that drops and comes back says nothing. For SETTLE
-- seconds after login, a reload, joining a party, the setting turned on or a
-- loading screen, reads only learn the log (the client fills counts in
-- late), so nothing already done is said. Lines go out GAP seconds apart;
-- while the client locks chat (InChatMessagingLockdown: boss encounters and
-- the like) they wait, and one held over MAX_AGE is dropped. The first line
-- sent says once per account where to turn it off.

local _, ns = ...
local L = ns.L

local ipairs, pairs, type = ipairs, pairs, type

local PartyChat = {}
ns.PartyChat = PartyChat

local TAG = "[Polestar] "
local READ_DELAY = 0.5 -- seconds after QUEST_LOG_UPDATE: one read per burst
local SETTLE = 5 -- seconds in which reads only learn the log
local GAP = 1.5 -- seconds between two lines
local LOCK_RETRY = 2 -- seconds between looks while chat is locked
local MAX_AGE = 120 -- seconds a line may wait
local MAX_QUEUE = 5

local live = false -- listening: the setting on and in a party
local state = {} -- quest id -> { done = { [objective index] = true }, ready = bool }
local queue = {} -- { text, at } lines waiting to go out
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

-- The client's link (what a shift-click on the quest puts in chat), else its
-- title in brackets; nil when neither can be read.
local function questLink(q)
	local C = ns.Compat
	local link = GetQuestLink and GetQuestLink(q)
	if type(link) == "string" and not C.IsSecret(link) and link ~= "" then return link end
	local title = C_QuestLog and C_QuestLog.GetTitleForQuestID and C_QuestLog.GetTitleForQuestID(q)
	if type(title) == "string" and not C.IsSecret(title) and title ~= "" then return "[" .. title .. "]" end
	return nil
end

-- Once per account, with the first line: where to turn it off.
local function tellOnce()
	local db = ns.DB()
	if db.partyChatTold then return end
	db.partyChatTold = true
	ns.Print(L["Polestar told your party you finished a quest objective (Options > Questing > Quests > Group to turn it off)."])
end

local function pump()
	pumpPending = false
	local now = GetTime()
	while queue[1] and now - queue[1].at > MAX_AGE do table.remove(queue, 1) end
	if not queue[1] then return end
	local send = (C_ChatInfo and C_ChatInfo.SendChatMessage) or SendChatMessage
	if not (live and send) then
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
	if #queue >= MAX_QUEUE then return end
	queue[#queue + 1] = { text = TAG .. text, at = GetTime() }
	if not pumpPending then pump() end
end

-- "Plagued Hide 5/5": the objective's name as the log words it, and its counts.
local function objectiveText(o)
	if ns.Compat.IsSecret(o.text) then return nil end
	local label = ns.Compat.ObjectiveLabel(o.text)
	local counts = o.numFulfilled .. "/" .. o.numRequired
	if label == "" then return counts end
	return label .. " " .. counts
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
	local link = questLink(q)
	if not link then return end
	if nowReady then return say(L["Ready to turn in: %s"]:format(link)) end
	for _, o in ipairs(newly) do
		local text = objectiveText(o)
		if text then say(L["Finished: %s - %s"]:format(text, link)) end
	end
end

local function read()
	readPending = false
	if not live then return end
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
		if not seen[q] and not C.IsOnQuest(q) then state[q] = nil end
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

-- Listens while the setting is on and you are in a party; solo, only the
-- roster events (with the setting on).
local function apply()
	local enabled = ns.Get("party.chat") and true or false
	local on = enabled and grouped()
	if enabled then
		ns.RegisterEvent("GROUP_ROSTER_UPDATE", apply)
		ns.RegisterEvent("GROUP_LEFT", apply)
	else
		ns.UnregisterEvent("GROUP_ROSTER_UPDATE", apply)
		ns.UnregisterEvent("GROUP_LEFT", apply)
	end
	if on == live then return end
	live = on
	if on then
		ns.RegisterEvent("QUEST_LOG_UPDATE", onLog)
		ns.RegisterEvent("PLAYER_ENTERING_WORLD", settle)
		settle()
	else
		ns.UnregisterEvent("QUEST_LOG_UPDATE", onLog)
		ns.UnregisterEvent("PLAYER_ENTERING_WORLD", settle)
		state, queue = {}, {}
	end
end

ns.OnLogin(apply)
ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and (path == "" or path == "party" or path == "party.chat") and ns.IsLoggedIn() then
		apply()
	end
end)
