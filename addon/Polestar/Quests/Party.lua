-- Party sync: your quest progress, shared with the people in your party who
-- run Polestar, and theirs shown under the guide's quest goals ("Ana 5/8").
-- Quest IDs and counts only, never text, so players on other guides, classes
-- or client languages agree on what they share.
--
-- Rules: hidden addon messages to the party only (never chat, never a raid),
-- sent when a count changes (QUEST_LOG_UPDATE, 2 s debounce) and as a full
-- snapshot a few seconds after someone joins; never on a timer. Settings
-- party.share (send) and party.show (receive and show), both off until the
-- player turns them on; with both off nothing is registered. Every client
-- API is checked first.
--
-- Message: "1|33:5/8,0/1;60:-", version first; "1S|" marks a snapshot that
-- replaces what is known of the sender; "1R|" is a snapshot sent after a
-- login or reload in a party, asking the others for theirs; "1Q|" asks for
-- theirs and carries nothing (showing without sharing). "33:-" is a quest
-- that left the log; "33:" one without objectives. Split by whole quests
-- under 255 bytes.

local ADDON, ns = ...

local tonumber, ipairs, pairs, next, type = tonumber, ipairs, pairs, next, type
local concat = table.concat

local Party = {}
ns.Party = Party

Party.PREFIX = "Polestar"
Party.MAX_BYTES = 255
local VERSION = "1"
-- Forever's log holds 40 quests (QuestLogConstsMainlineCamelot.
-- MAXIMUM_NUM_QUESTS_LOG_CAN_ACCEPT); a message carries at most that many.
local MAX_QUESTS, MAX_OBJECTIVES, MAX_COUNT = 40, 10, 999

---------------------------------------------------------------------------
-- The message format
---------------------------------------------------------------------------

local function piece(e)
	if e.counts == false then return e.q .. ":-" end
	local parts = {}
	for i, c in ipairs(e.counts) do parts[i] = c[1] .. "/" .. c[2] end
	return e.q .. ":" .. concat(parts, ",")
end

-- entries: { { q = id, counts = { { cur, max }, ... } or false }, ... } ->
-- the messages to send, in order (only the first carries the snapshot mark,
-- "R" when it also asks the party for theirs), and for each message the index
-- of the last entry it carries.
function Party.Encode(entries, snapshot, asks)
	local out, ends, parts, size = {}, {}, {}, 0
	local function header()
		if #out > 0 or not (snapshot or asks) then return VERSION .. "|" end
		return VERSION .. (asks and "R|" or "S|")
	end
	for i, e in ipairs(entries) do
		local p = piece(e)
		local extra = (#parts > 0 and 1 or 0) + #p
		if #parts > 0 and (#parts >= MAX_QUESTS or #header() + size + extra > Party.MAX_BYTES) then
			out[#out + 1] = header() .. concat(parts, ";")
			ends[#out] = i - 1
			parts, size, extra = {}, 0, #p
		end
		parts[#parts + 1] = p
		size = size + extra
	end
	if #parts > 0 or #out == 0 then
		out[#out + 1] = header() .. concat(parts, ";")
		ends[#out] = #entries
	end
	return out, ends
end

local function count(s)
	local n = tonumber(s)
	return n and n <= MAX_COUNT and n or nil
end

-- Returns snapshot, entries, asks; nil for anything malformed or of another
-- version.
function Party.Decode(text)
	if type(text) ~= "string" then return nil end
	local mark, body = text:match("^" .. VERSION .. "([SRQ]?)|(.*)$")
	if not mark or (mark == "Q" and body ~= "") then return nil end
	local entries = {}
	if body ~= "" then
		for p in (body .. ";"):gmatch("([^;]*);") do
			local q, rest = p:match("^(%d+):(.*)$")
			q = q and tonumber(q)
			if not q or q <= 0 or #entries >= MAX_QUESTS then return nil end
			local counts
			if rest == "-" then
				counts = false
			else
				counts = {}
				if rest ~= "" then
					for c in (rest .. ","):gmatch("([^,]*),") do
						local cur, max = c:match("^(%d+)/(%d+)$")
						cur, max = count(cur), count(max)
						if not (cur and max) or #counts >= MAX_OBJECTIVES then return nil end
						counts[#counts + 1] = { cur, max }
					end
				end
			end
			entries[#entries + 1] = { q = q, counts = counts }
		end
	end
	return mark == "S" or mark == "R", entries, mark == "R" or mark == "Q"
end

-- The request for the party's snapshots that shares nothing of ours.
Party.ASK = VERSION .. "Q|"

---------------------------------------------------------------------------
-- Your quest log
---------------------------------------------------------------------------

-- quest id -> its counts as sent ("5/8,0/1"; "" without objectives).
function Party.ReadLog()
	local out = {}
	local Q = C_QuestLog
	if not (Q and Q.GetNumQuestLogEntries and Q.GetInfo) then return out end
	local n, kept = Q.GetNumQuestLogEntries() or 0, 0
	for i = 1, n do
		local info = Q.GetInfo(i)
		local q = info and not info.isHeader and not info.isHidden and info.questID
		if q and q > 0 and not out[q] and kept < MAX_QUESTS then
			kept = kept + 1
			local objs = ns.Compat.GetQuestObjectives(q) or {}
			local parts = {}
			for j = 1, math.min(#objs, MAX_OBJECTIVES) do
				local o = objs[j]
				parts[j] = math.min(o.numFulfilled, MAX_COUNT) .. "/" .. math.min(o.numRequired, MAX_COUNT)
			end
			out[q] = concat(parts, ",")
		end
	end
	return out
end

---------------------------------------------------------------------------
-- Sending
---------------------------------------------------------------------------

ns.RegisterDefaults("party", { share = false, show = false })

local DEBOUNCE = 2 -- seconds after a quest log change
local JOIN_MIN, JOIN_SPREAD = 3, 3 -- snapshot 3-6 s after the roster gains someone
-- A request for our snapshot within this of our last one: the requester, up
-- at least JOIN_MIN before asking, already got it.
local REPLY_GAP = JOIN_MIN

local lastSent = {} -- quest id -> counts string the party last got from us
local shared = false -- the party holds counts of ours (lastSent empties on a resync)
local flushPending, snapPending, pendingAsks = false, false, false
local owed -- a snapshot the client refused (throttle, instance lockdown): { asks = bool }
local askOwed = false -- a bare request the client refused: asked again when a member's log changes
local lastSnapshotAt -- GetTime() of our last snapshot
local roster = {} -- "Name" or "Name-Realm" -> short name: the party but you, online

local function grouped()
	return IsInGroup and IsInGroup() and not (IsInRaid and IsInRaid()) or false
end

local function sharing() return ns.Get("party.share") and grouped() end

local function countsOf(s)
	if s == nil then return false end
	local out = {}
	for cur, max in s:gmatch("(%d+)/(%d+)") do out[#out + 1] = { tonumber(cur), tonumber(max) } end
	return out
end

-- Sends `msgs` in order and stops at the first the client refuses (a
-- throttle, or a lockdown in an instance): returns how many went out.
local function send(msgs)
	local fn = C_ChatInfo and C_ChatInfo.SendAddonMessage
	if not fn then return 0 end
	local results = Enum and Enum.SendAddonMessageResult
	local ok = results and results.Success or 0
	for i, m in ipairs(msgs) do
		local r = fn(Party.PREFIX, m, "PARTY")
		if r == false or (type(r) == "number" and r ~= ok) then return i - 1 end
	end
	return #msgs
end

-- Sends quests `ids` (sorted) as they are in `now`; what went out becomes
-- lastSent, the rest stays pending for the next change.
local function sendQuests(ids, now, snapshot, asks)
	local entries = {}
	for i, q in ipairs(ids) do entries[i] = { q = q, counts = countsOf(now[q]) } end
	local msgs, ends = Party.Encode(entries, snapshot, asks)
	local n = send(msgs)
	if n == 0 then return false end
	if snapshot then lastSent = {} end
	for i = 1, ends[n] do
		local q = ids[i]
		lastSent[q] = now[q]
	end
	if ends[n] > 0 then shared = true elseif snapshot then shared = false end
	return true
end

-- The whole log, replacing what the party knows of us; `asks`: and asking
-- for theirs.
local function snapshot(asks)
	snapPending, pendingAsks = false, false
	if not grouped() then return end
	if not ns.Get("party.share") then
		-- Showing without sharing: ask for theirs, send nothing of ours.
		if asks and ns.Get("party.show") then askOwed = send({ Party.ASK }) == 0 end
		return
	end
	askOwed = false
	local now, ids = Party.ReadLog(), {}
	for q in pairs(now) do ids[#ids + 1] = q end
	table.sort(ids)
	if sendQuests(ids, now, true, asks) then
		owed, lastSnapshotAt = nil, GetTime()
	else
		owed = { asks = (owed and owed.asks) or asks }
	end
end

local function scheduleSnapshot(asks)
	if asks then pendingAsks = true end
	if snapPending or not C_Timer then return end
	snapPending = true
	C_Timer.After(JOIN_MIN + math.random() * JOIN_SPREAD, function() snapshot(pendingAsks) end)
end

local function flush()
	flushPending = false
	-- A snapshot on its way carries every change; sending them first would
	-- send the log twice (after a join, nothing has been sent yet).
	if not sharing() or snapPending then return end
	if owed then return snapshot(owed.asks) end
	local now, ids = Party.ReadLog(), {}
	for q, s in pairs(now) do
		if lastSent[q] ~= s then ids[#ids + 1] = q end
	end
	for q in pairs(lastSent) do
		if now[q] == nil then ids[#ids + 1] = q end
	end
	if #ids == 0 then return end
	table.sort(ids)
	sendQuests(ids, now, false)
end

local function onLog()
	if flushPending or not sharing() or not C_Timer then return end
	flushPending = true
	C_Timer.After(DEBOUNCE, flush)
end

---------------------------------------------------------------------------
-- Receiving
---------------------------------------------------------------------------

local members = {} -- roster key -> { name = short name, quests = { [q] = { { cur, max }, ... } }, n = quests }
local progressPending = false
local PROGRESS_DELAY = 0.5 -- seconds: a burst of messages refreshes the guide once

local function progressChanged()
	if progressPending then return end
	if not C_Timer then return ns.Fire("PARTY_PROGRESS") end
	progressPending = true
	C_Timer.After(PROGRESS_DELAY, function()
		progressPending = false
		ns.Fire("PARTY_PROGRESS")
	end)
end

local function forgetAll()
	local had = next(members) ~= nil or next(roster) ~= nil
	roster, lastSent, members, owed, shared, askOwed = {}, {}, {}, nil, false, false
	if had then progressChanged() end
end

-- The roster key a party unit's messages arrive under: chat senders carry
-- the normalized realm (no spaces or hyphens); nil while the name is unknown,
-- false while the client keeps it secret (identity restricted).
local function memberKey(unit)
	local name, realm = UnitName(unit)
	if ns.Compat.IsSecret(name) or ns.Compat.IsSecret(realm) then return false end
	if not name or name == "" or name == UNKNOWNOBJECT then return nil end
	if realm and realm ~= "" then return name .. "-" .. realm:gsub("[%s%-]", ""), name end
	return name, name
end

-- Offline members are left out: they drop off the line and count as new
-- when back. A roster read when we knew nobody (login, reload, joining from
-- solo, the settings back on: `asks`) asks the party for their snapshots.
local function readRoster(asks)
	if not grouped() then return forgetAll() end
	local wasEmpty = next(roster) == nil
	local now, gained, changed = {}, false, false
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, n do
		local unit = "party" .. i
		local key, short = memberKey(unit)
		-- A secret name: keep the roster as it was until the next roster event.
		if key == false then return end
		if key and not (UnitIsConnected and not UnitIsConnected(unit)) then
			now[key] = short
			if not roster[key] then gained = true end
		end
	end
	for key in pairs(roster) do
		if not now[key] then changed = true end
	end
	roster = now
	for key in pairs(members) do
		if not now[key] then members[key] = nil end
	end
	if gained or changed then progressChanged() end
	if gained then scheduleSnapshot(asks or wasEmpty) end
end

local function onRoster() readRoster(false) end

local function onConnection(_, unit)
	if type(unit) == "string" and unit:match("^party%d$") then readRoster(false) end
end

-- A party member's log changed: the "Not on this quest" nudge may be stale
-- (their client tells ours even without Polestar).
local function onUnitQuestLog(_, unit)
	if type(unit) == "string" and unit:match("^party%d$") then
		if askOwed then scheduleSnapshot(true) end
		progressChanged()
	end
end

local function apply(m, entries, snap)
	if snap then m.quests, m.n = {}, 0 end
	for _, e in ipairs(entries) do
		local had = m.quests[e.q] ~= nil
		if e.counts == false then
			if had then
				m.quests[e.q] = nil
				m.n = m.n - 1
			end
		elseif had or m.n < MAX_QUESTS then
			if not had then m.n = m.n + 1 end
			m.quests[e.q] = e.counts
		end
	end
end

local function onAddonMessage(_, prefix, text, channel, sender)
	if prefix ~= Party.PREFIX or channel ~= "PARTY" or type(sender) ~= "string" then return end
	local key = Ambiguate and Ambiguate(sender, "none") or sender
	local short = roster[key]
	if not short then return end
	local snap, entries, asks = Party.Decode(text)
	if snap == nil then return end
	if asks and sharing() and not snapPending and not (lastSnapshotAt and GetTime() - lastSnapshotAt < REPLY_GAP) then
		scheduleSnapshot(false)
	end
	-- A bare request (showing without sharing) is no member's progress.
	if not ns.Get("party.show") or (not snap and #entries == 0) then return end
	local m = members[key]
	if not m then
		m = { name = short, quests = {}, n = 0 }
		members[key] = m
	end
	apply(m, entries, snap)
	progressChanged()
end

-- The party members whose progress we have, by name:
-- { { name = "Ana", quests = { [q] = { { cur, max }, ... } } }, ... }.
function Party.Members()
	local out = {}
	for _, m in pairs(members) do out[#out + 1] = m end
	table.sort(out, function(a, b) return a.name < b.name end)
	return out
end

---------------------------------------------------------------------------
-- Settings
---------------------------------------------------------------------------

local prefixed = false
local wasShare, wasShow -- the settings at the last Apply; nil before login

local function want(event, on, fn)
	if on then ns.RegisterEvent(event, fn) else ns.UnregisterEvent(event, fn) end
end

-- Registers what the settings need and nothing else; at login and whenever
-- a party setting changes. Sharing turned off in a group sends one empty
-- snapshot when the party has counts of ours, so it drops them rather than
-- showing them frozen; a setting turned back on resyncs.
function Party.Apply()
	local share, show = ns.Get("party.share") and true or false, ns.Get("party.show") and true or false
	local any = share or show
	-- After a reload in a party, the others may still hold counts sent before it.
	if wasShare == nil and share and grouped() then shared = true end
	want("GROUP_ROSTER_UPDATE", any, onRoster)
	want("GROUP_LEFT", any, forgetAll)
	want("UNIT_CONNECTION", any, onConnection)
	want("QUEST_LOG_UPDATE", share, onLog)
	-- Received with showing off too: a request for our snapshot still counts.
	want("CHAT_MSG_ADDON", any, onAddonMessage)
	want("UNIT_QUEST_LOG_CHANGED", show, onUnitQuestLog)
	local turnedOff = wasShare and not share
	local turnedOn = (wasShare == false and share) or (wasShow == false and show)
	wasShare, wasShow = share, show
	if turnedOff then
		if grouped() and shared then send(Party.Encode({}, true)) end
		lastSent, owed, shared = {}, nil, false
	end
	if not any then return forgetAll() end
	if not show and next(members) then
		members = {}
		progressChanged()
	end
	if not prefixed and C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
		prefixed = true
		C_ChatInfo.RegisterAddonMessagePrefix(Party.PREFIX)
	end
	if turnedOn and grouped() then
		lastSent = {}
		scheduleSnapshot(true)
	end
	readRoster(true)
end

ns.OnLogin(Party.Apply)
ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and (path == "" or path == "party" or path:sub(1, 6) == "party.") and ns.IsLoggedIn() then
		Party.Apply()
	end
end)

---------------------------------------------------------------------------
-- What the guide shows
---------------------------------------------------------------------------

local L = ns.L
local DOT = "  \194\183  "

-- Party members (connected) who lack quest `q`, by name: the client's own
-- party check first; without it, what a member running Polestar sent us;
-- never a guess about the rest.
function Party.Missing(q)
	local out = {}
	local check = C_QuestLog and C_QuestLog.IsUnitOnQuest
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, n do
		local unit = "party" .. i
		local key, short = memberKey(unit)
		if key and not (UnitIsConnected and not UnitIsConnected(unit)) then
			-- What a member running Polestar sent outranks the client's check,
			-- which may not know about members far away.
			local m = members[key]
			local on = (m and m.quests[q] ~= nil) or nil
			if not on and check then on = check(unit, q) end
			if on == nil and m then on = false end
			if on == false then out[#out + 1] = short end
		end
	end
	table.sort(out)
	return out
end

-- The party part of a goal's line (UI.GoalSubline), or nil: on an objective
-- goal each member's count ("Ana 5/8", "Ben done"), then, on a quest you
-- have, who lacks it ("Not on this quest: Ben"). Not on the accept: taking
-- the quest moves the window past it. `noMissing`: a row above already
-- names them (said once per card).
function Party.Line(goal, noMissing)
	if type(goal) ~= "table" or not goal.quest or not goal.oi or goal.status == "skipped" then return nil end
	if not ns.Get("party.show") or not grouped() then return nil end
	local parts = {}
	for _, m in ipairs(Party.Members()) do
		local counts = m.quests[goal.quest]
		local c = counts and counts[ns.Engine.ObjectiveLine(goal)]
		if c then
			parts[#parts + 1] = c[1] >= c[2] and L["%s done"]:format(m.name) or (m.name .. " " .. c[1] .. "/" .. c[2])
		end
	end
	if not noMissing and ns.Compat.IsOnQuest(goal.quest) then
		local missing = Party.Missing(goal.quest)
		if #missing > 0 then parts[#parts + 1] = L["Not on this quest: %s"]:format(concat(missing, ", ")) end
	end
	if #parts == 0 then return nil end
	return concat(parts, DOT)
end

-- The Party section of the Questing page (its Quests tab), after the quest
-- settings (Quests/Options.lua registers first: this file loads after it).
Party.OPTIONS = {
	page = L["Questing"], tab = L["Quests"], section = L["Party"],
	controls = {
		{ kind = "toggle", key = "party.share", label = L["Share my quest progress with my party"],
			help = L["Party members who run Polestar see your counts under their quest goals. Nothing goes to chat."] },
		{ kind = "toggle", key = "party.show", label = L["Show my party's progress in the guide"],
			help = L["Their counts under your quest goals, and who lacks a quest you took."] },
	},
}

local registered = false
local function register()
	if registered or not ns.RegisterOptions then return end
	registered = true
	ns.RegisterOptions(Party.OPTIONS)
end
ns.OnInit(register)
ns.OnLogin(register)
