-- Polestar Group Finder: searches, and what to do with the messages of
-- other players who run it.
--
-- The message formats are in Protocol.lua, the channels in Channels.lua.
-- A search of your own only ever goes out from a click or a key press, and
-- its updates (a quest left it, it ended) go to the same players. An answer
-- to someone else's search goes out without a click only while `autoReply`
-- is on (off by default), and only for quests you have.

local _, ns = ...
local L = ns.L
local Protocol = ns.Protocol
local Channels = ns.Channels

local Comm = {}
ns.Comm = Comm

local SEARCH_GAP = 10     -- seconds between two searches of yours (a click)
local RETRY_EVERY = 10    -- while nobody is found, the search is asked again this often
local SEARCH_FOR = 300    -- for at most this long, then it is over
local REPLY_GAP = 20      -- seconds between two answers to the same player (a searcher's own gap)
local QUEST_ANSWERS = 6   -- answers to other players' quest searches per QUEST_WINDOW
local QUEST_WINDOW = 30

local lastSearch = -math.huge
local searchStart       -- when the click started the search in progress
local run = 0           -- the retry loop in force (a new search or Stop ends the old one)
local lastReply = {} -- sender (or sender#quest) -> time
local answered = {}  -- times of our recent answers to quest searches

-- Why a search cannot go out now (printed), or nil.
local function blocked()
	if not ns.Get("enabled") then return L["The group finder is off. Turn it on in its panel or in Polestar's settings."] end
	if IsInInstance and IsInInstance() then return L["Searching is off inside an instance."] end
end

---------------------------------------------------------------------------
-- Searches
---------------------------------------------------------------------------

Comm.SEARCH_GAP = SEARCH_GAP
function Comm.SearchCooldown()
	return math.max(0, SEARCH_GAP - (ns.Now() - lastSearch))
end

-- Your quests near you: a session (Session.lua) that lasts until they are done.
-- `only`: one quest of your log to search for (a goal row's button, a quest
-- menu's row), whatever the route; else the quests worth a group.
function Comm.Search(only)
	local why = blocked()
	if why then ns.Print(why) return false end
	local wait = Comm.SearchCooldown()
	if wait > 0 then ns.Debug(L["Wait %d s before searching again."], math.ceil(wait)) return false end
	local quests = ns.Quests.Relevant()
	if only then
		quests = ns.Quests.Has(only) and { { id = only, kind = ns.Quests.Kind(only) or "k" } } or {}
	end
	if #quests == 0 then ns.Print(L["No quest to search for: kill, named, loot or group quests in progress."]) return false end
	local text, count = Protocol.Search(quests)
	local sentOn = Channels.SendPublic(text)
	if #sentOn == 0 then ns.Print(L["The finder's channel cannot send right now. Try /polestar finder test."]) return false end
	lastSearch = ns.Now()
	ns.searchedAt = lastSearch
	searchStart = lastSearch
	ns.Session.Start(quests)
	-- One quest asked for (a goal row's button, a quest menu): the panel names it.
	ns.searchOnly = only
	ns.Debug(L["Search sent on %s for %d quest(s)."], table.concat(sentOn, ", "), count)
	ns.Fire("SEARCHED", quests, sentOn)
	run = run + 1
	Comm.Retry(run)
	return true
end

-- How long a search asks: SEARCH_FOR with the option autoRetry, else one
-- wait (RETRY_EVERY) and it is over.
local function askFor()
	return ns.Get("autoRetry") and SEARCH_FOR or RETRY_EVERY
end

-- Is the search still asking (nobody found yet, within its time)?
function Comm.Searching()
	return ns.Session.Active() and searchStart ~= nil and #ns.Matcher.List() == 0
		and ns.Now() - searchStart < askFor()
end

-- Seconds before the search is asked again.
function Comm.RetryLeft()
	return math.max(0, RETRY_EVERY - (ns.Now() - lastSearch))
end
Comm.RETRY_EVERY, Comm.SEARCH_FOR = RETRY_EVERY, SEARCH_FOR

-- With the option autoRetry (off by default), the search you started asks
-- again every RETRY_EVERY seconds while nobody is found, for SEARCH_FOR at
-- most; without it, it asks once. Then, with nobody found, it looks over. It
-- stops asking once someone is found (the search stays, for its updates),
-- at Stop, at a new search, in an instance or with the finder off.
function Comm.Retry(id)
	ns.After(RETRY_EVERY, function()
		if id ~= run or not ns.Session.Active() or not ns.Get("enabled") then return end
		if #ns.Matcher.List() > 0 then return end
		-- Asked out: no more asking. The search itself stays (its updates
		-- reach whoever listed you) until its quests are done or Stop.
		if ns.Now() - (searchStart or 0) >= askFor() then
			if ns.Get("autoRetry") then ns.Debug(L["No one found in 5 minutes: no more asking. Press Find a group to try again."]) end
			ns.Fire("SEARCH_RETRY")
			return
		end
		if IsInInstance and IsInInstance() then return end
		if #Channels.SendPublic((Protocol.Search(ns.Session.List()))) > 0 then
			lastSearch = ns.Now()
			ns.searchedAt = lastSearch
			ns.Fire("SEARCH_RETRY")
		end
		Comm.Retry(id)
	end)
end

-- The search changed (an objective is done): say what is left.
function Comm.Update()
	if not (ns.Get("enabled") and ns.Session.Active()) then return end
	Channels.SendQuiet((Protocol.Search(ns.Session.List())))
end

-- The search is over: tell the players who listed us.
function Comm.Stop()
	if not ns.Get("enabled") then return end
	Channels.SendQuiet(Protocol.Stop())
end

-- Stop from a click or /polestar finder stop.
-- Everything at once: the retries, the session, the wait; Find a group is
-- back at once.
function Comm.StopSearch()
	if not ns.Session.Active() then return end
	Comm.Stop()
	run = run + 1
	ns.searchedAt = nil
	ns.searchOnly = nil
	lastSearch = -math.huge
	ns.Session.Stop("manual")
	ns.Debug(L["Search stopped."])
end

---------------------------------------------------------------------------
-- Receiving
---------------------------------------------------------------------------

local ACCEPTED = { CHANNEL = true, WHISPER = true }

local function ignored(sender)
	if C_FriendList and C_FriendList.IsIgnored then
		local ok, r = pcall(C_FriendList.IsIgnored, sender)
		if ok and r then return true end
	end
	return false
end

-- Answers wait a moment at random, so that a crowd does not answer at once.
local function answerLater(text, sender)
	ns.After(0.5 + math.random() * 2, function() Channels.Whisper(text, sender) end)
end

-- Q: "who has quest N?" An A goes back if we have it, within limits.
local function onQuestSearch(sender, q, chatType)
	-- A Q is never whispered.
	if chatType == "WHISPER" or not ns.Get("autoReply") or not ns.Quests.Has(q.id) then return end
	local now = ns.Now()
	local k = sender .. "#" .. q.id
	if now - (lastReply[k] or -math.huge) < REPLY_GAP then return end
	-- A crowd of askers cannot make us whisper without end.
	local recent = {}
	for _, t in ipairs(answered) do if now - t < QUEST_WINDOW then recent[#recent + 1] = t end end
	answered = recent
	if #answered >= QUEST_ANSWERS then return end
	answered[#answered + 1] = now
	lastReply[k] = now
	local id = q.id
	ns.After(0.5 + math.random() * 2, function()
		Channels.Whisper(Protocol.QuestReply(id, ns.Quests.Progress(id) or 0), sender)
	end)
end

-- S and R. `listed`: quests of my active search (else any open one) they
-- share; `answer`: every open quest of mine they look for.
local function onSearchOrReply(sender, m, chatType)
	local Matcher = ns.Matcher
	local listed, answer = {}, {}
	for _, q in ipairs(m.quests) do
		if ns.Quests.Pending(q.id) then
			answer[#answer + 1] = q.id
			if Matcher.Mine(q.id) then listed[#listed + 1] = q.id end
		end
	end
	if m.kind == "R" then
		if #listed > 0 then Matcher.Add(sender, m, listed, "reply") end
		return
	end
	if #listed == 0 then
		-- Their search no longer covers anything we look for.
		Matcher.Remove(sender)
	else
		Matcher.Add(sender, m, listed, "asking")
	end
	if #answer == 0 then return end
	if ns.Get("autoGroup") and m.flags:find("g", 1, true) then ns.Group.Expect(sender) end
	-- A whispered search is an update to a player already found: no new answer.
	-- Two players with auto-group on group without a click: the answer goes
	-- even with autoReply off.
	local wantsGroup = ns.Get("autoGroup") and m.flags:find("g", 1, true)
	if (ns.Get("autoReply") or wantsGroup) and chatType ~= "WHISPER" and ns.Now() - (lastReply[sender] or -math.huge) >= REPLY_GAP then
		lastReply[sender] = ns.Now()
		answerLater(Protocol.Reply(answer), sender)
	end
end

local function onMessage(_, prefix, text, chatType, sender)
	if prefix ~= Protocol.PREFIX or not ns.Get("enabled") or not ACCEPTED[chatType] then return end
	sender = ns.Readable(sender)
	text = ns.Readable(text)
	if type(sender) ~= "string" or sender == "" then return end
	local m = Protocol.Decode(text)
	if not m then return end
	if m.sid == Protocol.sid then
		-- Our own message came back: this channel works.
		Channels.SetStatus(chatType, "ok")
		return
	end
	ns.Debug("<- %s from %s on %s", m.kind, sender, chatType)
	if m.kind == "T" or ignored(sender) then return end
	if IsInInstance and IsInInstance() then return end
	if m.kind == "X" then ns.Matcher.Remove(sender) return end
	if m.kind == "G" then ns.Group.OnRequest(sender, m) return end
	-- A player of the other faction cannot group with us.
	local theirs, mine = m.flags:match("[AH]"), Protocol.Flags():match("[AH]")
	if theirs and mine and theirs ~= mine then return end
	if not ns.Lang.Compatible(m.langs) then
		if m.kind == "S" or m.kind == "R" then ns.Matcher.Remove(sender) end
		return
	end
	if m.kind == "Q" or m.kind == "A" then
		local q = m.quests[1]
		if not q then return end
		-- A Q is answered (Let others find me); an A answers a quest search this client never sends.
		if m.kind == "Q" then onQuestSearch(sender, q, chatType) end
		return
	end
	onSearchOrReply(sender, m, chatType)
end

ns.RegisterEvent("CHAT_MSG_ADDON", onMessage)

ns.Search = Comm.Search
