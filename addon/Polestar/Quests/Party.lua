-- Party sync: your quest progress, shared with the people in your party who
-- run Polestar, and theirs shown under the guide's quest goals ("Ana 5/8").
-- Quest IDs and counts only, never text, so players on other guides, classes
-- or client languages agree on what they share.
--
-- Rules: hidden addon messages to the party only (never chat, never a raid),
-- and only once a member has shown they run Polestar. Joining a party,
-- logging in or reloading in one, and someone joining who has not spoken
-- Polestar yet send one hello, "1H|<version>"; a member
-- who answers (their snapshot, a bare "1Y|<version>", or any valid message)
-- gets the full sync, members who never answer get nothing more, and
-- everything the guide shows of the party is of members who answered.
-- Senders are matched to party members by Compat.SenderName and
-- Compat.UnitFullName (Forever's names carry a surname). Then
-- progress goes out when a count changes (QUEST_LOG_UPDATE, 2 s debounce)
-- and as a full snapshot a few seconds after a member answers; never on a
-- timer. Settings party.share (send) and party.show (receive and show), both
-- on unless the player turned them off (a stored false); solo, only the
-- roster events are registered, and with both off nothing is. Every client
-- API is checked first.
--
-- Message: "1|33:5/8,0/1;60:-", version first; "1S|" marks a snapshot that
-- replaces what is known of the sender; "1R|" is a snapshot that also asks
-- the others for theirs (answering a hello); "1Q|" asks for theirs and
-- carries nothing (showing without sharing). "33:-" is a quest
-- that left the log; "33:" one without objectives. Split by whole quests
-- under 255 bytes.
--
-- Where you are: "1P|<live step>|<Polestar version>|<pack id>|<pack
-- version>|<guide id>" (step 0: none), sent with sharing on when the live
-- step or guide changes (debounced) and with every snapshot. Clients that
-- predate it drop it as malformed. It gives the "N steps ahead/behind" line
-- on the same guide and pack version, and a once-a-session notice when a
-- member runs a newer Polestar or guide pack.
--
-- Who you are: "2U|<level>|<XP %>|<class id>|<race id>", version 2, which
-- every version-1 decoder (Decode, DecodePos) drops as malformed; sent with
-- every snapshot and when the level or the whole XP percent changes
-- (debounced). Fields after these are ignored, so a later version can add
-- some. It gives the party panel's level and XP, and the reason a member
-- cannot take a quest you would share.
--
-- Group play on top (party.waitForGroup, default on): a goal done for you
-- that a member still needs holds the live step, its turn-in and the arrow
-- (Party.Waiting, Party.HoldsQuest; Core/Engine.lua asks); a member in
-- another zone, offline for over 2 minutes, or left behind with "Go on
-- without them" (Party.GoOn) holds nothing, and solo nothing ever waits.

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

-- The handshake: "1H|<Polestar version>" asks the party who runs Polestar
-- (sent once on joining a party, at login or reload in one, or with the
-- settings back on); "1Y|<version>" answers it from a player who shares
-- nothing (a sharer answers with its snapshot). Version-1 decoders before
-- the handshake drop both. -> "H" | "Y", version; nil for anything else.
function Party.EncodeHello(reply)
	return VERSION .. (reply and "Y|" or "H|") .. (tostring(ns.version or ""):gsub("|", ""))
end
function Party.DecodeHello(text)
	if type(text) ~= "string" then return nil end
	local mark, version = text:match("^" .. VERSION .. "([HY])|([^|]*)$")
	return mark, version
end

-- pos = { step, addon, pack, packVersion, guide } -> the "1P|" message, cut to
-- MAX_BYTES; nil without a guide.
function Party.EncodePos(pos)
	if type(pos) ~= "table" or type(pos.guide) ~= "string" or pos.guide == "" then return nil end
	local function field(v) return (tostring(v or ""):gsub("|", "")) end
	local text = VERSION .. "P|" .. (tonumber(pos.step) or 0) .. "|" .. field(pos.addon) .. "|" .. field(pos.pack) .. "|"
		.. field(pos.packVersion) .. "|" .. pos.guide
	return #text <= Party.MAX_BYTES and text or nil
end

-- The "1P|" message -> pos (step nil for 0), or nil when it is none.
function Party.DecodePos(text)
	if type(text) ~= "string" then return nil end
	local step, addon, pack, packVersion, guide = text:match("^" .. VERSION .. "P|(%d+)|([^|]*)|([^|]*)|([^|]*)|(.+)$")
	if not step then return nil end
	step = tonumber(step)
	return { step = step > 0 and step or nil, addon = addon, pack = pack, packVersion = packVersion, guide = guide }
end

-- Whether version a is newer than b, both dotted numbers ("0.3.10" > "0.3.9");
-- false when either is not (a dev build).
function Party.Newer(a, b)
	if type(a) ~= "string" or type(b) ~= "string" or not a:match("^%d+[%.%d]*$") or not b:match("^%d+[%.%d]*$") then return false end
	local pa, pb = {}, {}
	for n in a:gmatch("%d+") do pa[#pa + 1] = tonumber(n) end
	for n in b:gmatch("%d+") do pb[#pb + 1] = tonumber(n) end
	for i = 1, math.max(#pa, #pb) do
		local x, y = pa[i] or 0, pb[i] or 0
		if x ~= y then return x > y end
	end
	return false
end

-- u = { level, xp (whole percent), class (class id), race (race id) } -> the
-- "2U|" message; nil without a level.
local UNIT_VERSION = "2"
function Party.EncodeUnit(u)
	local level = type(u) == "table" and tonumber(u.level)
	if not level or level < 1 then return nil end
	local function n(v, top)
		v = tonumber(v)
		return v and v >= 0 and v <= top and tostring(math.floor(v)) or ""
	end
	return UNIT_VERSION .. "U|" .. n(level, MAX_COUNT) .. "|" .. (n(u.xp, 100) ~= "" and n(u.xp, 100) or "0") .. "|"
		.. n(u.class, MAX_COUNT) .. "|" .. n(u.race, MAX_COUNT)
end

-- The "2U|" message -> u (class and race nil when not given), or nil. What
-- follows the race field (a later version's) is ignored.
function Party.DecodeUnit(text)
	if type(text) ~= "string" then return nil end
	local level, xp, class, race, rest = text:match("^" .. UNIT_VERSION .. "U|(%d+)|(%d+)|(%d*)|(%d*)(.*)$")
	if not level or (rest ~= "" and rest:sub(1, 1) ~= "|") then return nil end
	level, xp = count(level), tonumber(xp)
	if not level or level < 1 or xp > 100 then return nil end
	return { level = level, xp = xp, class = count(class), race = count(race) }
end

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

-- On by default. Up to v0.3.2 the default was off and Set stored nothing for
-- it, so a player who had it off gets it switched on once by this version
-- (the once-per-account notice says so); from now on Set stores a `false`,
-- so turning it off stays off.
-- panel: the party panel (UI/PartyPanel.lua), which opens by itself once a
-- member's Polestar is heard; false once the player closes it (0.3.3 had it
-- off by default and stored nothing for an untouched one, so those players
-- get it too). panelPos: its place once dragged.
-- chat: party chat lines for finished objectives and ready quests; chatLoot:
-- for a looted item that starts a quest; chatEcho: your own lines shown to
-- you too; chatHideOthers: other players' Polestar lines hidden;
-- chatOnlyNeeded: nothing said while every member runs Polestar
-- (Quests/PartyChat.lua).
ns.RegisterDefaults("party", { share = true, show = true, waitForGroup = true, lootNeeds = true, panel = true, panelPos = false, chat = true,
	chatLoot = true, chatEcho = false, chatHideOthers = false, chatOnlyNeeded = false })

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
-- Members who have spoken Polestar (a hello, its answer or any valid
-- message), by roster key: nothing of ours goes out, and nothing of group
-- play shows, before one has, and only theirs count.
local spoken = {}

local function grouped()
	return IsInGroup and IsInGroup() and not (IsInRaid and IsInRaid()) or false
end

local function sharing() return ns.Get("party.share") and grouped() and next(spoken) ~= nil end

local function countsOf(s)
	if s == nil then return false end
	local out = {}
	for cur, max in s:gmatch("(%d+)/(%d+)") do out[#out + 1] = { tonumber(cur), tonumber(max) } end
	return out
end

-- What `/polestar party debug` reports (Party.Debug): the prefix's
-- registration, the last send and its result, the messages heard.
local diag = { sends = 0, heard = 0, matched = 0 }

-- Sends `msgs` in order and stops at the first the client refuses (a
-- throttle, or a lockdown in an instance): returns how many went out.
local function send(msgs)
	local fn = C_ChatInfo and C_ChatInfo.SendAddonMessage
	if not fn then return 0 end
	local results = Enum and Enum.SendAddonMessageResult
	local ok = results and results.Success or 0
	for i, m in ipairs(msgs) do
		local r = fn(Party.PREFIX, m, "PARTY")
		diag.sends, diag.lastSend, diag.lastResult = diag.sends + 1, m:sub(1, 3), r
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

-- Where you are: the active guide, its live step and the versions (pos as
-- Party.EncodePos takes it), or nil without a guide.
function Party.MyPos()
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	if not g then return nil end
	local G = ns.Guides
	local pack = g.pack and G and G.Pack and G.Pack(g.pack)
	return { step = E.GetLiveStep and E.GetLiveStep() or nil, addon = ns.version, pack = g.pack or "",
		packVersion = pack and pack.version and tostring(pack.version) or "", guide = g.id }
end

local posSent -- the "1P|" text the party last got from us
local posPending = false

-- Our position to the party, unless it already has this one (`force`: with
-- a snapshot, which a member who just joined needs).
local function sendPos(force)
	posPending = false
	if not sharing() then return end
	local text = Party.EncodePos(Party.MyPos())
	if not text or (text == posSent and not force) then return end
	if send({ text }) == 1 then posSent = text end
end

local function onStep()
	if posPending or not sharing() or not C_Timer then return end
	posPending = true
	ns.After(DEBOUNCE, function() sendPos(false) end)
end

-- Who you are (Party.EncodeUnit takes it): level, whole XP percent, class
-- and race ids.
function Party.MyUnit()
	local level = UnitLevel and UnitLevel("player")
	local xp, top = UnitXP and UnitXP("player"), UnitXPMax and UnitXPMax("player")
	local class, race
	if UnitClass then class = select(3, UnitClass("player")) end
	if UnitRace then race = select(3, UnitRace("player")) end
	return { level = level, xp = (xp and top and top > 0) and math.floor(xp * 100 / top) or 0, class = class, race = race }
end

local unitSent -- the "2U|" text the party last got from us
local unitPending = false

local function sendUnit(force)
	unitPending = false
	if not sharing() then return end
	local text = Party.EncodeUnit(Party.MyUnit())
	if not text or (text == unitSent and not force) then return end
	if send({ text }) == 1 then unitSent = text end
end

-- XP or a level: sent once its text changes (a whole percent), debounced.
local function onUnit()
	if unitPending or not sharing() or not C_Timer then return end
	unitPending = true
	ns.After(DEBOUNCE, function() sendUnit(false) end)
end

-- The whole log, replacing what the party knows of us; `asks`: and asking
-- for theirs.
local function snapshot(asks)
	snapPending, pendingAsks = false, false
	-- Nobody in the party has spoken Polestar: nothing of ours goes out.
	if not grouped() or next(spoken) == nil then return end
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
		sendPos(true)
		sendUnit(true)
	else
		owed = { asks = (owed and owed.asks) or asks }
	end
end

local function scheduleSnapshot(asks)
	if asks then pendingAsks = true end
	if snapPending or not C_Timer then return end
	snapPending = true
	ns.After(JOIN_MIN + math.random() * JOIN_SPREAD, function() snapshot(pendingAsks) end)
end

-- The hello: on joining a party, at login or reload in one, and when
-- someone joins who has not spoken Polestar yet, JOIN_MIN-6 s later so the
-- others' clients listen by then. A refused one is owed: tried again
-- HELLO_RETRY seconds later (up to HELLO_TRIES times) and when a member's
-- quest log changes.
local HELLO_RETRY, HELLO_TRIES = 10, 5
local helloPending, helloOwed, helloTries = false, false, 0
local scheduleHello
local function hello()
	helloPending = false
	if not grouped() or not (ns.Get("party.share") or ns.Get("party.show")) then return end
	helloOwed = send({ Party.EncodeHello(false) }) == 0
	if not helloOwed then
		helloTries = 0
	elseif helloTries < HELLO_TRIES and C_Timer then
		helloTries = helloTries + 1
		ns.After(HELLO_RETRY, function() if helloOwed then scheduleHello() end end)
	end
end
scheduleHello = function()
	if helloPending or not C_Timer then return end
	helloPending = true
	ns.After(JOIN_MIN + math.random() * JOIN_SPREAD, hello)
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
	ns.After(DEBOUNCE, flush)
end

---------------------------------------------------------------------------
-- Receiving
---------------------------------------------------------------------------

local members = {} -- roster key -> { name = short name, quests = { [q] = { { cur, max }, ... } }, n = quests, pos, unit }
-- Members who went offline, kept GONE_GRACE seconds: a disconnect that short
-- still holds the group (Party.Waiting). roster key -> { m = member, at = GetTime() }
local gone = {}
local GONE_GRACE = 120
local units = {} -- roster key -> its unit ("party2"), online or not
local released = {} -- quest id -> true: "Go on without them" (Party.GoOn) for it
local progressPending = false
local PROGRESS_DELAY = 0.5 -- seconds: a burst of messages refreshes the guide once
local wantLive -- (Settings) the events a group needs, registered only while in one

local function progressChanged()
	if progressPending then return end
	if not C_Timer then return ns.Fire("PARTY_PROGRESS") end
	progressPending = true
	ns.After(PROGRESS_DELAY, function()
		progressPending = false
		ns.Fire("PARTY_PROGRESS")
	end)
end

local function forgetAll()
	local had = next(members) ~= nil or next(roster) ~= nil or next(gone) ~= nil
	roster, lastSent, members, owed, shared, askOwed, posSent, unitSent = {}, {}, {}, nil, false, false, nil, nil
	gone, units, released, spoken, helloOwed, helloTries = {}, {}, {}, {}, false, 0
	if wantLive then wantLive() end
	if had then progressChanged() end
end

-- The roster key a party unit's messages arrive under (Compat.UnitFullName:
-- "Ana Smith" on Forever, "Ana" or "Ana-OtherRealm" elsewhere) and its first
-- name; nil while the name is unknown, false while the client keeps it
-- secret (identity restricted).
local function memberKey(unit) return ns.Compat.UnitFullName(unit) end

-- Offline members are left out: they drop off the line and count as new
-- when back (what they sent is kept GONE_GRACE seconds for the group's
-- wait). A roster read that finds someone who has not spoken Polestar yet
-- (login, reload, joining, a new member, the settings back on) says hello;
-- the members who answer are synced, the others get nothing more. Members
-- who leave are forgotten at once, holds and all.
local function readRoster()
	if not grouped() then return forgetAll() end
	if wantLive then wantLive() end
	local now, offline, unitOf, gained, changed, fresh = {}, {}, {}, false, false, false
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, n do
		local unit = "party" .. i
		local key, short = memberKey(unit)
		-- A secret name: keep the roster as it was until the next roster event.
		if key == false then return end
		if key then
			unitOf[key] = unit
			if UnitIsConnected and not UnitIsConnected(unit) then
				offline[key] = true
			else
				now[key] = short
				if not roster[key] then
					gained = true
					if not spoken[key] then fresh = true end
				end
				-- Back within the grace: what they sent holds until their
				-- snapshot replaces it, so the wait does not let go meanwhile.
				local g = gone[key]
				if g and not members[key] and GetTime() - g.at < GONE_GRACE then members[key] = g.m end
			end
		end
	end
	for key in pairs(roster) do
		if not now[key] then changed = true end
	end
	roster, units = now, unitOf
	for key, m in pairs(members) do
		if not now[key] then
			members[key] = nil
			if offline[key] then
				gone[key] = { m = m, at = GetTime() }
				-- The wait lets go of them once the grace is over.
				if C_Timer then ns.After(GONE_GRACE + 0.5, progressChanged) end
			end
		end
	end
	for key in pairs(gone) do
		if not offline[key] then gone[key] = nil end
	end
	for key in pairs(spoken) do
		if not (now[key] or offline[key]) then spoken[key] = nil end
	end
	if gained or changed then progressChanged() end
	if fresh then scheduleHello() end
end

local function onRoster() readRoster() end

local function onConnection(_, unit)
	if type(unit) == "string" and unit:match("^party%d$") then readRoster() end
end

-- A party member's log changed: the "Not on this quest" nudge may be stale
-- (their client tells ours even without Polestar).
local function onUnitQuestLog(_, unit)
	if type(unit) == "string" and unit:match("^party%d$") then
		if askOwed then scheduleSnapshot(true) end
		if helloOwed then scheduleHello() end
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

-- Once a session each: a member runs a newer Polestar, or a newer version of
-- a guide pack you have.
local toldNewer = {}
local function noticeNewer(name, pos)
	local L = ns.L
	if not toldNewer[""] and Party.Newer(pos.addon, ns.version) then
		toldNewer[""] = true
		ns.Print(L["%s has Polestar %s; you have %s. A newer version is out."]:format(name, pos.addon, tostring(ns.version)))
	end
	local G = ns.Guides
	local mine = pos.pack ~= "" and G and G.Pack and G.Pack(pos.pack)
	if mine and not toldNewer[pos.pack] and Party.Newer(pos.packVersion, tostring(mine.version or "")) then
		toldNewer[pos.pack] = true
		ns.Print(L["%s has a newer %s guide pack (%s; yours is %s)."]:format(name, mine.title or pos.pack, pos.packVersion, tostring(mine.version)))
	end
end

local function memberFor(key, short)
	local m = members[key]
	if not m then
		m = { name = short, quests = {}, n = 0 }
		members[key] = m
	end
	return m
end

-- Once per account, on the first group with another Polestar user while you
-- share: your party sees your progress, and where to turn that off.
local function tellOnce()
	local db = ns.DB()
	if db.partySyncTold or not ns.Get("party.share") then return end
	db.partySyncTold = true
	ns.Print(ns.L["Party sync is on: your party sees your quest progress (Options > Questing > Quests > Group to turn it off)."])
end

-- A member spoke Polestar (any valid message). One new to us is told once
-- (the notice, on the first found) and gets our snapshot unless their
-- message already asks for it. True when they are new.
local function heard(key, asks)
	if spoken[key] then return false end
	spoken[key] = true
	tellOnce()
	progressChanged()
	if not asks and ns.Get("party.share") then scheduleSnapshot(false) end
	return true
end

local function onAddonMessage(_, prefix, text, channel, sender)
	local C = ns.Compat
	if C.IsSecret(prefix) or C.IsSecret(channel) or C.IsSecret(text) then return end
	if prefix ~= Party.PREFIX or channel ~= "PARTY" or type(sender) ~= "string" then return end
	local key = C.SenderName(sender)
	if not key then return end
	diag.heard, diag.lastSender = diag.heard + 1, sender
	if C.SenderIsMe(sender) then return end
	local short = roster[key]
	if not short then
		-- Only party members speak on the party channel: one not in the
		-- roster is a read that missed them (a name the client did not
		-- have yet), or a name spelled otherwise than the roster's: read it
		-- again, then ask the client which member the sender is.
		readRoster()
		short = roster[key]
		for k, unit in pairs(units) do
			if short then break end
			if roster[k] and C.SenderIsUnit(sender, unit) then key, short = k, roster[k] end
		end
		if not short then return end
	end
	diag.matched = diag.matched + 1
	local mark = Party.DecodeHello(text)
	if mark == "H" then
		-- A hello (they joined, logged in or reloaded): a sharer answers with
		-- its snapshot, asking theirs; anyone else with a bare answer.
		heard(key, true)
		if ns.Get("party.share") then
			scheduleSnapshot(true)
		else
			send({ Party.EncodeHello(true) })
		end
		return
	elseif mark == "Y" then
		heard(key, false)
		return
	end
	local pos = Party.DecodePos(text)
	if pos then
		heard(key, false)
		if not ns.Get("party.show") then return end
		memberFor(key, short).pos = pos
		noticeNewer(short, pos)
		progressChanged()
		return
	end
	local u = Party.DecodeUnit(text)
	if u then
		heard(key, false)
		if not ns.Get("party.show") then return end
		memberFor(key, short).unit = u
		progressChanged()
		return
	end
	local snap, entries, asks = Party.Decode(text)
	if snap == nil then return end
	heard(key, asks)
	if asks and sharing() and not snapPending and not (lastSnapshotAt and GetTime() - lastSnapshotAt < REPLY_GAP) then
		scheduleSnapshot(false)
	end
	-- A bare request (showing without sharing) is no member's progress.
	if not ns.Get("party.show") or (not snap and #entries == 0) then return end
	local m = memberFor(key, short)
	apply(m, entries, snap)
	progressChanged()
end

-- Whether the member under roster key `key` has spoken Polestar.
function Party.Spoke(key) return spoken[key] == true end

-- Whether every party member online runs Polestar (each has spoken it):
-- Quests/PartyChat.lua stays quiet then with party.chatOnlyNeeded on. False
-- solo, in a raid, and while a member's name is unknown or secret; with
-- sharing and showing both off nobody is heard, so false.
function Party.AllRunPolestar()
	if not grouped() then return false end
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	if n == 0 then return false end
	for i = 1, n do
		local unit = "party" .. i
		if not (UnitIsConnected and not UnitIsConnected(unit)) then
			local key = memberKey(unit)
			if not (key and spoken[key]) then return false end
		end
	end
	return true
end

-- The party members whose progress we have, by name:
-- { { name = "Ana", quests = { [q] = { { cur, max }, ... } } }, ... }.
function Party.Members()
	local out = {}
	for _, m in pairs(members) do out[#out + 1] = m end
	table.sort(out, function(a, b) return a.name < b.name end)
	return out
end

local L = ns.L
local DOT = "  \194\183  "

---------------------------------------------------------------------------
-- The group's wait (party.waitForGroup; Core/Engine.lua asks)
---------------------------------------------------------------------------

-- A member in another zone than yours: both known and different. Unknown
-- (an instance, a client without party maps) is not far.
local function farAway(unit)
	if not unit then return false end
	local C = ns.Compat
	local mine = C.GetUnitZone and C.GetUnitZone("player")
	local theirs = mine and C.GetUnitZone(unit)
	return theirs ~= nil and theirs ~= mine
end

local function waits()
	return ns.Get("party.waitForGroup") and ns.Get("party.show") and grouped() or false
end

-- The members the group waits for, by name: online in your zone (or where
-- the client does not say), and those offline under GONE_GRACE seconds.
local function holders()
	local out, now = {}, GetTime()
	for key, m in pairs(members) do
		if not farAway(units[key]) then out[#out + 1] = m end
	end
	for _, g in pairs(gone) do
		if now - g.at < GONE_GRACE then out[#out + 1] = g.m end
	end
	table.sort(out, function(a, b) return a.name < b.name end)
	return out
end

local function unfinished(counts)
	for _, c in ipairs(counts) do
		if c[1] < c[2] then return true end
	end
	return false
end

-- The members the group waits for who still need objective goal `goal`'s
-- quest-log line: { { name, cur, max }, ... } by name, or nil. Only with the
-- wait on, in a party, for a quest in your log you did not go on without
-- them for (Party.GoOn).
function Party.Waiting(goal)
	if type(goal) ~= "table" or not goal.quest or not goal.oi or released[goal.quest] or not waits() then return nil end
	if not ns.Compat.IsOnQuest(goal.quest) then return nil end
	local line = ns.Engine.ObjectiveLine(goal)
	if not line then return nil end
	local out
	for _, m in ipairs(holders()) do
		local counts = m.quests[goal.quest]
		local c = counts and counts[line]
		if c and c[1] < c[2] then
			out = out or {}
			out[#out + 1] = { name = m.name, cur = c[1], max = c[2] }
		end
	end
	return out
end

-- Of the members the group waits for: who has quest q and is not done with
-- it (names), and whether any has it.
local function notDoneWith(q)
	local names, any = {}, false
	for _, m in ipairs(holders()) do
		local counts = m.quests[q]
		if counts then
			any = true
			if unfinished(counts) then names[#names + 1] = m.name end
		end
	end
	return names, any
end

-- Whether quest q's turn-in waits for the group: a member it waits for has
-- q and is not done with it. Automation hands nothing in meanwhile.
function Party.HoldsQuest(q)
	if not q or released[q] or not waits() or not ns.Compat.IsOnQuest(q) then return false end
	return #(notDoneWith(q)) > 0
end

-- "Go on without them": the live step's quests stop waiting, until the
-- group ends.
function Party.GoOn()
	local E = ns.Engine
	local s = E and E.GetLiveStep and E.GetLiveStep()
	local view = s and E.GetStepView(s)
	for _, goal in ipairs(view and view.goals or {}) do
		if goal.quest then released[goal.quest] = true end
	end
	progressChanged()
end

-- The live step's wait: the members it waits on (names, sorted), and
-- whether it is ready: its open turn-ins are ready for you and for every
-- member on them. Nil with the wait off.
function Party.StepWait()
	if not waits() then return nil end
	local E = ns.Engine
	local s = E.GetLiveStep and E.GetLiveStep()
	local view = s and E.GetStepView(s)
	if not view then return nil end
	local names, seen, ready = {}, {}, false
	local function add(n)
		if not seen[n] then
			seen[n] = true
			names[#names + 1] = n
		end
	end
	local C = ns.Compat
	for _, goal in ipairs(view.goals or {}) do
		local q = goal.quest
		if q and not released[q] then
			if goal.oi and goal.status == "done" then
				for _, w in ipairs(Party.Waiting(goal) or {}) do add(w.name) end
			elseif goal.t == "turnin" and goal.status ~= "done" and goal.status ~= "skipped" and C.IsOnQuest(q) and C.IsQuestReadyForTurnIn(q) then
				local who, any = notDoneWith(q)
				for _, n in ipairs(who) do add(n) end
				if any and #who == 0 then ready = true end
			end
		end
	end
	table.sort(names)
	return names, ready and #names == 0
end

-- Watching the wait: a member moving to another zone or a disconnect
-- running past its grace changes who holds the group without any event of
-- ours. Read every WATCH seconds while the wait is on in a party; sends
-- nothing.
local WATCH = 5
local watchTicker, watchSig
local function holdSignature()
	local parts, now = {}, GetTime()
	for key in pairs(members) do
		if farAway(units[key]) then parts[#parts + 1] = key end
	end
	for key, g in pairs(gone) do
		if now - g.at < GONE_GRACE then parts[#parts + 1] = key .. "~" end
	end
	table.sort(parts)
	return concat(parts, ",")
end
local function watch()
	local sig = holdSignature()
	if sig ~= watchSig then
		watchSig = sig
		progressChanged()
	end
end

---------------------------------------------------------------------------
-- Sharing a quest, and why a member cannot take it
---------------------------------------------------------------------------

-- What the game said to our last share, by quest and member name (its
-- ERR_QUEST_PUSH_* system lines, read for PUSH_WINDOW seconds after it).
local pushed = {} -- quest id -> { [name] = reason }
local PUSH_WINDOW = 10
local pushQuest, pushAt, pushPatterns
-- Reasons that mean the member cannot take the quest (no Share for them).
local BLOCKS = { done = true, invalid = true, low = true, class = true, race = true }
local PUSH_ERRORS = {
	ERR_QUEST_PUSH_ALREADY_DONE_S = "done", ERR_QUEST_PUSH_LOG_FULL_S = "full", ERR_QUEST_PUSH_INVALID_S = "invalid",
	ERR_QUEST_PUSH_TOO_FAR_S = "far", ERR_QUEST_PUSH_ONQUEST_S = "on", ERR_QUEST_PUSH_LOW_LEVEL_S = "low",
	ERR_QUEST_PUSH_CLASS_S = "class", ERR_QUEST_PUSH_RACE_S = "race",
}

local function reasonText(why)
	if why == "done" then return L["already done"] end
	if why == "full" then return L["quest log full"] end
	if why == "invalid" then return L["can't take it"] end
	if why == "far" then return L["too far to share"] end
	if why == "low" then return L["level too low"] end
	if why == "class" then return L["another class"] end
	if why == "race" then return L["another race"] end
	return nil
end

-- "%s has completed that quest." -> "^(.+) has completed that quest%.$"
local function patternOf(fmt)
	local p = fmt:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%0")
	p = p:gsub("%%%%s", "(.+)")
	return "^" .. p .. "$"
end

local function onSystem(_, text)
	if not pushQuest or type(text) ~= "string" then return end
	if not pushPatterns then
		pushPatterns = {}
		for global, why in pairs(PUSH_ERRORS) do
			local fmt = _G[global]
			if type(fmt) == "string" and fmt:find("%s", 1, true) then pushPatterns[#pushPatterns + 1] = { patternOf(fmt), why } end
		end
	end
	for _, p in ipairs(pushPatterns) do
		local who = text:match(p[1])
		if who then
			who = who:match("^[^%-]+") or who
			local said = pushed[pushQuest] or {}
			pushed[pushQuest] = said
			said[who] = p[2] ~= "on" and p[2] or nil
			progressChanged()
			return
		end
	end
end

-- Share quest q with the party, as the quest log's Share button does
-- (Compat.ShareQuest: the game's own rules, a shareable quest, members in
-- range), and read what the game answers for each member. False when the
-- client cannot.
function Party.Share(q)
	if not ns.Compat.ShareQuest(q) then return false end
	local said = pushed[q]
	if said then
		for name, why in pairs(said) do
			if not BLOCKS[why] then said[name] = nil end
		end
	end
	pushQuest, pushAt = q, GetTime()
	ns.RegisterEvent("CHAT_MSG_SYSTEM", onSystem)
	if C_Timer then
		ns.After(PUSH_WINDOW, function()
			if pushAt and GetTime() - pushAt >= PUSH_WINDOW - 0.05 then
				pushQuest, pushAt = nil, nil
				ns.UnregisterEvent("CHAT_MSG_SYSTEM", onSystem)
			end
		end)
	end
	return true
end

-- A party member's level (what they sent, else the client's), XP percent
-- (sent only), class and race file names ("WARRIOR", "NightElf"; the
-- client's, else from the ids they sent).
function Party.UnitInfo(unit, key)
	local m = key and (members[key] or (gone[key] and gone[key].m))
	local u = m and m.unit
	local level = u and u.level
	if not level and unit and UnitLevel then
		level = UnitLevel(unit)
		if type(level) ~= "number" or level <= 0 then level = nil end
	end
	local class, race
	if unit and UnitClass then class = select(2, UnitClass(unit)) end
	if not class and u and u.class and GetClassInfo then
		local _, file = GetClassInfo(u.class)
		class = file
	end
	if unit and UnitRace then race = select(2, UnitRace(unit)) end
	if not race and u and u.race and C_CreatureInfo and C_CreatureInfo.GetRaceInfo then
		local info = C_CreatureInfo.GetRaceInfo(u.race)
		race = info and info.clientFileString
	end
	return { level = level, xp = u and u.xp, class = class, race = race }
end

-- Why a member cannot take quest q, when we know: what the game said to a
-- share, else the quest database against their class, race and level.
-- Returns the reason's text and whether it rules the quest out.
local function whyNot(unit, key, name, q)
	local said = pushed[q] and pushed[q][name]
	if said then return reasonText(said), BLOCKS[said] or false end
	local Q = ns.QuestDB
	local r = Q and Q.IsLoaded and Q.IsLoaded() and Q.GetQuest and Q.GetQuest(q)
	if not r then return nil, false end
	local info = Party.UnitInfo(unit, key)
	local ctx = Q.PlayerContext({ level = info.level or 1, race = info.race, class = info.class })
	local band = bit and bit.band
	if band and r.classes and r.classes > 0 and ctx.classBit and band(r.classes, ctx.classBit) == 0 then return L["another class"], true end
	if band and r.races and r.races > 0 and ctx.raceBit and band(r.races, ctx.raceBit) == 0 then return L["another race"], true end
	if r.minLevel and info.level and info.level < r.minLevel then return L["level %d, needs %d"]:format(info.level, r.minLevel), true end
	return nil, false
end

-- Party members (connected) who have spoken Polestar and lack quest `q`:
-- what they sent first, else the client's own party check (which may not
-- know about members far away); nothing is said of members without
-- Polestar. { { name, unit, key, why (text or nil), blocked }, ... } by name.
function Party.Lacking(q)
	local out = {}
	local check = C_QuestLog and C_QuestLog.IsUnitOnQuest
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, n do
		local unit = "party" .. i
		local key, name = memberKey(unit)
		if key and spoken[key] and not (UnitIsConnected and not UnitIsConnected(unit)) then
			-- What a member running Polestar sent outranks the client's check,
			-- which may not know about members far away.
			local m = members[key]
			local on = (m and m.quests[q] ~= nil) or nil
			if not on and check then on = check(unit, q) end
			if on == nil and m then on = false end
			if on == false then
				local why, blocked = whyNot(unit, key, name, q)
				out[#out + 1] = { name = name, unit = unit, key = key, why = why, blocked = blocked }
			end
		end
	end
	table.sort(out, function(a, b) return a.name < b.name end)
	return out
end

-- The names of Party.Lacking(q).
function Party.Missing(q)
	local out = {}
	for i, e in ipairs(Party.Lacking(q)) do out[i] = e.name end
	return out
end

-- Who a Share on objective goal `goal`'s row reaches: the party members who
-- lack its quest with nothing known against taking it, by name; nil when
-- none, when the quest is not in your log, or the game says it cannot be
-- shared.
function Party.ShareFor(goal)
	if type(goal) ~= "table" or not goal.quest or not goal.oi or goal.status == "skipped" then return nil end
	if not ns.Get("party.show") or not grouped() or not ns.Compat.IsOnQuest(goal.quest) then return nil end
	local QL = C_QuestLog
	if not (QL and QL.SetSelectedQuest and QuestLogPushQuest) then return nil end
	if QL.IsPushableQuest and not QL.IsPushableQuest(goal.quest) then return nil end
	local out = {}
	for _, e in ipairs(Party.Lacking(goal.quest)) do
		if not e.blocked then out[#out + 1] = e.name end
	end
	return #out > 0 and out or nil
end

---------------------------------------------------------------------------
-- Settings
---------------------------------------------------------------------------

local prefixed = false
local wasShare, wasShow, wasWait -- the settings at the last Apply; nil before login
local liveOn = false

local function want(event, on, fn)
	if on then ns.RegisterEvent(event, fn) else ns.UnregisterEvent(event, fn) end
end

local function onZone() progressChanged() end

-- What a group needs, registered only while in one (a party, not a raid);
-- solo, only the roster events of Party.Apply listen. Fires PARTY_LIVE
-- (on) when that changes, for the party panel and the loot lines.
wantLive = function()
	local share, show = ns.Get("party.share") and true or false, ns.Get("party.show") and true or false
	local on = (share or show) and grouped() or false
	want("UNIT_CONNECTION", on, onConnection)
	want("QUEST_LOG_UPDATE", on and share, onLog)
	-- Received with showing off too: a request for our snapshot still counts.
	want("CHAT_MSG_ADDON", on, onAddonMessage)
	want("UNIT_QUEST_LOG_CHANGED", on and show, onUnitQuestLog)
	want("PLAYER_XP_UPDATE", on and share, onUnit)
	want("PLAYER_LEVEL_UP", on and share, onUnit)
	want("ZONE_CHANGED_NEW_AREA", on and show, onZone)
	local watching = on and show and ns.Get("party.waitForGroup") and true or false
	if watching and not watchTicker and C_Timer and C_Timer.NewTicker then
		watchSig = holdSignature()
		watchTicker = ns.NewTicker(WATCH, watch)
	elseif not watching and watchTicker then
		watchTicker:Cancel()
		watchTicker = nil
	end
	if on ~= liveOn then
		liveOn = on
		ns.Fire("PARTY_LIVE", on)
	end
end

-- Whether party sync is listening: a party, and sharing or showing on.
function Party.IsLive() return liveOn end

-- `/polestar party debug`: the lines that say whether the party's messages
-- go out and come in, for a player to paste into a report: the last
-- sender's name as it arrived beside each member's as the roster keys it.
function Party.Debug()
	local C, out = ns.Compat, {}
	local function add(s) out[#out + 1] = s end
	local registered = C_ChatInfo and C_ChatInfo.IsAddonMessagePrefixRegistered and C_ChatInfo.IsAddonMessagePrefixRegistered(Party.PREFIX)
	add(("version %s; prefix %s registered %s (result %s)"):format(tostring(ns.version), Party.PREFIX, tostring(registered), tostring(diag.prefixResult)))
	add(("grouped %s, raid %s, live %s, share %s, show %s, panel %s"):format(tostring(grouped()), tostring(IsInRaid and IsInRaid() or false),
		tostring(liveOn), tostring(ns.Get("party.share")), tostring(ns.Get("party.show")), tostring(ns.Get("party.panel"))))
	add(("sent %d, last %s result %s; received %d, from party members %d, last sender %s"):format(diag.sends, tostring(diag.lastSend),
		tostring(diag.lastResult), diag.heard, diag.matched, tostring(diag.lastSender)))
	local me = C.UnitFullName("player")
	add(("you %s"):format(tostring(me)))
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, n do
		local key = memberKey("party" .. i)
		add(("party%d %s: in roster %s, spoke Polestar %s"):format(i, key == false and "(secret)" or tostring(key),
			tostring(key and roster[key] ~= nil or false), tostring(key and spoken[key] or false)))
	end
	return out
end

-- Registers what the settings need and nothing else; at login and whenever
-- a party setting changes. Sharing turned off in a group sends one empty
-- snapshot when the party has counts of ours, so it drops them rather than
-- showing them frozen; a setting turned back on resyncs.
function Party.Apply()
	local share, show = ns.Get("party.share") and true or false, ns.Get("party.show") and true or false
	local wait = ns.Get("party.waitForGroup") and true or false
	local any = share or show
	-- After a reload in a party, the others may still hold counts sent before it.
	if wasShare == nil and share and grouped() then shared = true end
	want("GROUP_ROSTER_UPDATE", any, onRoster)
	want("GROUP_LEFT", any, forgetAll)
	wantLive()
	local turnedOff = wasShare and not share
	local turnedOn = (wasShare == false and share) or (wasShow == false and show)
	local waitChanged = wasWait ~= nil and wasWait ~= wait
	wasShare, wasShow, wasWait = share, show, wait
	if turnedOff then
		if grouped() and shared then send(Party.Encode({}, true)) end
		lastSent, owed, shared, unitSent = {}, nil, false, nil
	end
	if not any then return forgetAll() end
	if not show and next(members) then
		members, gone = {}, {}
		progressChanged()
	end
	if waitChanged then progressChanged() end
	if not prefixed and C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
		prefixed = true
		diag.prefixResult = C_ChatInfo.RegisterAddonMessagePrefix(Party.PREFIX)
	end
	if turnedOn and grouped() then
		lastSent = {}
		scheduleSnapshot(true)
	end
	readRoster()
end

ns.OnLogin(Party.Apply)
ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and (path == "" or path == "party" or path:sub(1, 6) == "party.") and ns.IsLoggedIn() then
		Party.Apply()
	end
end)
-- Our live step or guide changed: tell the party (debounced, only a change).
for _, msg in ipairs({ "STEP_CHANGED", "STEP_UPDATED", "GUIDE_CHANGED" }) do ns.On(msg, onStep) end

---------------------------------------------------------------------------
-- What the guide shows
---------------------------------------------------------------------------

-- The party part of a goal's line (UI.GoalSubline), or nil. On an objective
-- goal each member's count ("Ana 5/8", "Ben done"; on a collect, "Ana still
-- needs 2 Boar Ribs"), and, done for you, who the group waits on ("Waiting
-- on Ana: 3/8 Boar Ribs"); then, on a quest you have, who lacks it and why
-- when we know ("Not on this quest: Ben (level 8, needs 10)"). On a turn-in
-- ready for you, the group's wait ("Waiting on Ana", "Everyone's ready").
-- Not on the accept: taking the quest moves the window past it.
-- `noMissing`: a row above already names them (said once per card).
function Party.Line(goal, noMissing)
	if type(goal) ~= "table" or not goal.quest or goal.status == "skipped" then return nil end
	if not ns.Get("party.show") or not grouped() then return nil end
	local q, C = goal.quest, ns.Compat
	if goal.t == "turnin" then
		if goal.status == "done" or released[q] or not waits() or not C.IsOnQuest(q) or not C.IsQuestReadyForTurnIn(q) then return nil end
		local who, any = notDoneWith(q)
		if #who > 0 then return L["Waiting on %s"]:format(concat(who, ", ")) end
		return any and L["Everyone's ready"] or nil
	end
	if not goal.oi then return nil end
	local parts, line = {}, ns.Engine.ObjectiveLine(goal)
	local what = type(goal.subject) == "string" and goal.subject ~= "" and goal.subject or nil
	local waited = {}
	if goal.status == "done" then
		for _, w in ipairs(Party.Waiting(goal) or {}) do
			waited[w.name] = true
			local n = w.cur .. "/" .. w.max
			parts[#parts + 1] = L["Waiting on %s: %s"]:format(w.name, what and (n .. " " .. what) or n)
		end
	end
	for _, m in ipairs(Party.Members()) do
		local counts = m.quests[q]
		local c = counts and line and counts[line]
		if c and not waited[m.name] then
			if c[1] >= c[2] then
				parts[#parts + 1] = L["%s done"]:format(m.name)
			elseif goal.t == "collect" and what then
				parts[#parts + 1] = L["%s still needs %d %s"]:format(m.name, c[2] - c[1], what)
			else
				parts[#parts + 1] = m.name .. " " .. c[1] .. "/" .. c[2]
			end
		end
	end
	if not noMissing and C.IsOnQuest(q) then
		local lacking = Party.Lacking(q)
		if #lacking > 0 then
			local named = {}
			for i, e in ipairs(lacking) do named[i] = e.why and L["%s (%s)"]:format(e.name, e.why) or e.name end
			parts[#parts + 1] = L["Not on this quest: %s"]:format(concat(named, ", "))
		end
	end
	if #parts == 0 then return nil end
	return concat(parts, DOT)
end

-- The guide window's party line for the live step, and whether the group
-- waits on it (the line then offers "Go on without them"), or nil. Where
-- members are: "Ana: 3 steps ahead" on the same guide and pack version, "Ben:
-- other guide" on another; then the wait ("Waiting on Ana", "Everyone's
-- ready"), or with nobody holding the step, a soft hint when you are done
-- with its objectives and a member is not ("Still at it: Ben").
function Party.StepLine()
	if not ns.Get("party.show") or not grouped() then return nil end
	local mine = Party.MyPos()
	local parts, list = {}, Party.Members()
	for _, m in ipairs(list) do
		local p = m.pos
		if p and p.step and mine and mine.step and p.guide == mine.guide and p.packVersion == mine.packVersion then
			local d = p.step - mine.step
			if d == 1 then parts[#parts + 1] = L["%s: 1 step ahead"]:format(m.name)
			elseif d > 1 then parts[#parts + 1] = L["%s: %d steps ahead"]:format(m.name, d)
			elseif d == -1 then parts[#parts + 1] = L["%s: 1 step behind"]:format(m.name)
			elseif d < -1 then parts[#parts + 1] = L["%s: %d steps behind"]:format(m.name, -d)
			else parts[#parts + 1] = L["%s: on this step"]:format(m.name) end
		elseif p and p.guide ~= (mine and mine.guide) then
			parts[#parts + 1] = L["%s: other guide"]:format(m.name)
		end
	end
	local names, ready = Party.StepWait()
	local holding = names ~= nil and #names > 0
	if holding then
		parts[#parts + 1] = L["Waiting on %s"]:format(concat(names, ", "))
	elseif ready then
		parts[#parts + 1] = L["Everyone's ready"]
	elseif mine and mine.step then
		local view = ns.Engine.GetStepView(mine.step)
		local still, seen = {}, {}
		for _, goal in ipairs(view and view.goals or {}) do
			local q = goal.quest
			if q and goal.oi and goal.status == "done" then
				local line = ns.Engine.ObjectiveLine(goal)
				for _, m in ipairs(list) do
					local c = line and m.quests[q] and m.quests[q][line]
					if c and c[1] < c[2] and not seen[m.name] then
						seen[m.name] = true
						still[#still + 1] = m.name
					end
				end
			end
		end
		if #still > 0 then parts[#parts + 1] = L["Still at it: %s"]:format(concat(still, ", ")) end
	end
	if #parts == 0 then return nil end
	return concat(parts, DOT), holding
end

---------------------------------------------------------------------------
-- The party panel's rows (UI/PartyPanel.lua)
---------------------------------------------------------------------------

-- What member m still needs of step view `view`'s objectives:
-- { { what, cur, max }, ... } in the step's order.
local function stepNeeds(m, view)
	local out = {}
	for _, goal in ipairs(view and view.goals or {}) do
		local counts = goal.quest and goal.oi and goal.status ~= "skipped" and m.quests[goal.quest]
		local line = counts and ns.Engine.ObjectiveLine(goal)
		local c = line and counts[line]
		if c and c[1] < c[2] then out[#out + 1] = { what = goal.subject or goal.text or "", cur = c[1], max = c[2] } end
	end
	return out
end

-- One row per party member who has spoken Polestar, in party order: { name,
-- unit, class (file), level, xp (percent), polestar (true), offline, dead,
-- far, step (their step's title on your guide), otherGuide, needs
-- (stepNeeds of your live step) }. Empty without one.
function Party.Roster()
	local out = {}
	if not grouped() then return out end
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	local live = E and E.GetLiveStep and E.GetLiveStep()
	local view = live and E.GetStepView(live)
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, n do
		local unit = "party" .. i
		local key, name = memberKey(unit)
		if key and spoken[key] then
			local m = ns.Get("party.show") and (members[key] or (gone[key] and gone[key].m)) or nil
			local info = Party.UnitInfo(unit, key)
			local row = {
				name = name, unit = unit, class = info.class, level = info.level, xp = info.xp, polestar = true,
				offline = (UnitIsConnected and not UnitIsConnected(unit)) and true or false,
				dead = (UnitIsDeadOrGhost and UnitIsDeadOrGhost(unit)) and true or false,
				far = farAway(unit),
			}
			if m then
				local p = m.pos
				if p and g and p.guide == g.id then
					local st = p.step and g.steps and g.steps[p.step]
					row.step = st and st.title or (p.step and L["Step %d"]:format(p.step)) or nil
				elseif p then
					row.otherGuide = true
				end
				row.needs = stepNeeds(m, view)
			end
			out[#out + 1] = row
		end
	end
	return out
end

-- Point the arrow at a party member, where the client gives their place on
-- the map (the open world; not in an instance), and follow them while it
-- stays the arrow's target. False when it does not.
local FOLLOW = 3 -- seconds between looks at where they are
local follow -- { unit, label, target, map, x, y, ticker }
local function stopFollow()
	if follow and follow.ticker then follow.ticker:Cancel() end
	follow = nil
end
function Party.PointAt(unit)
	local Nav = ns.Nav
	local map, x, y = ns.Compat.GetUnitMapPosition(unit)
	if not (map and Nav and Nav.SetTarget) then return false end
	local _, name = memberKey(unit)
	stopFollow()
	local label = name and L["Party: %s"]:format(name) or L["Party"]
	if not Nav.SetTarget(map, x, y, label) then return false end
	follow = { unit = unit, label = label, target = Nav.GetTarget(), map = map, x = x, y = y }
	if C_Timer and C_Timer.NewTicker then
		follow.ticker = ns.NewTicker(FOLLOW, function()
			if not follow or Nav.GetTarget() ~= follow.target then return stopFollow() end
			local m2, x2, y2 = ns.Compat.GetUnitMapPosition(follow.unit)
			if not m2 then return end
			if m2 ~= follow.map or math.abs(x2 - follow.x) + math.abs(y2 - follow.y) > 0.5 then
				Nav.SetTarget(m2, x2, y2, follow.label)
				follow.target, follow.map, follow.x, follow.y = Nav.GetTarget(), m2, x2, y2
			end
		end)
	end
	return true
end

---------------------------------------------------------------------------
-- Loot a member still needs (UI/PartyLoot.lua)
---------------------------------------------------------------------------

-- Whether your own quests still want item itemID: an open objective of a
-- quest in your log (the quest database's index of it), or the line `line`
-- of quest q.
local function youNeed(itemID, q, line)
	local Q = ns.QuestDB
	local mine = Q and Q.ObjectivesForItem and Q.ObjectivesForItem(itemID)
	for _, o in ipairs(mine or {}) do
		if not o.done then return true end
	end
	if q and line and ns.Compat.IsOnQuest(q) then
		local o = (ns.Compat.GetQuestObjectives(q) or {})[line]
		if o and o.numFulfilled < o.numRequired then return true end
	end
	return false
end

-- The party members who still need item itemID for a quest while you do
-- not: { { name, unit, need }, ... } by name; empty when you need it too or
-- the setting (party.lootNeeds) is off. The item's quest-log line comes from
-- the active guide's collect goals, else from the quest database's
-- objectives when they number as the member's counts do.
function Party.ItemNeeds(itemID)
	local out = {}
	if not itemID or not (ns.Get("party.show") and ns.Get("party.lootNeeds") and grouped()) or not next(members) then return out end
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	local lines = {}
	for _, step in ipairs(g and g.steps or {}) do
		for _, goal in ipairs(step.goals or {}) do
			if goal.t == "collect" and goal.item == itemID and goal.quest and goal.oi and lines[goal.quest] == nil then
				lines[goal.quest] = E.ObjectiveLine(goal) or false
			end
		end
	end
	local Q = ns.QuestDB
	local qdb = Q and Q.IsLoaded and Q.IsLoaded() and Q.GetQuest
	if youNeed(itemID) then return out end
	for key, m in pairs(members) do
		for q, counts in pairs(m.quests) do
			local line = lines[q]
			if line == nil and qdb then
				local r = Q.GetQuest(q)
				if r and #r.objectives == #counts then
					for i, o in ipairs(r.objectives) do
						if o.kind == "item" and o.id == itemID then
							line = i
							break
						end
					end
				end
			end
			local c = line and counts[line]
			if c and c[1] < c[2] then
				if youNeed(itemID, q, line) then return {} end
				out[#out + 1] = { name = m.name, unit = units[key], need = c[2] - c[1] }
				break
			end
		end
	end
	table.sort(out, function(a, b) return a.name < b.name end)
	return out
end

-- "For Ana: she still needs 2" for an entry of Party.ItemNeeds (the
-- member's sex as the client gives it; neither: no pronoun).
function Party.NeedText(e)
	local sex = e.unit and UnitSex and UnitSex(e.unit)
	if sex == 3 then return L["For %s: she still needs %d"]:format(e.name, e.need) end
	if sex == 2 then return L["For %s: he still needs %d"]:format(e.name, e.need) end
	return L["For %s: still needs %d"]:format(e.name, e.need)
end

---------------------------------------------------------------------------
-- Options
---------------------------------------------------------------------------

-- The Group section of the Questing page (its Quests tab), after the quest
-- settings (Quests/Options.lua registers first: this file loads after it).
-- `search`: more words the settings search finds them by (English, as the
-- other controls' `search`).
local SEARCH = "group, party, sync, friends, together"
Party.OPTIONS = {
	page = L["Questing"], tab = L["Quests"], section = L["Group"],
	controls = {
		{ kind = "toggle", key = "party.share", label = L["Share my quest progress with my party"], search = SEARCH,
			help = L["Party members who run Polestar see your counts under their quest goals, your step and your level. Hidden addon messages to your party only; nothing goes to chat."] },
		{ kind = "toggle", key = "party.show", label = L["Show my party's progress in the guide"], search = SEARCH,
			help = L["Their counts under your quest goals, and who lacks a quest you took, with a Share button."] },
		{ kind = "toggle", key = "party.waitForGroup", label = L["Wait for the group"], search = SEARCH,
			disabled = function() return not ns.Get("party.show") end,
			help = L["When a party member on your quest still needs an objective you finished, the step and its turn-in wait and the arrow leads to what they need. Members in another zone or offline for 2 minutes don't hold you; the party line offers Go on without them."] },
		{ kind = "toggle", key = "party.lootNeeds", label = L["Say who still needs quest loot"], search = SEARCH,
			disabled = function() return not ns.Get("party.show") end,
			help = L["On a loot window or roll, a line under a quest item a party member still needs and you don't. Nothing is passed or said for you."] },
		{ kind = "toggle", key = "party.panel", label = L["Party panel"], search = SEARCH,
			help = L["Opens by itself when someone in your party runs Polestar too: each member's level, step and what they still need of yours; click a name to point the arrow at them. Closed, it stays closed; /polestar party opens it again."] },
		{ kind = "toggle", key = "party.chat", label = L["Tell my party about objectives and ready quests"], search = SEARCH .. ", chat, announce, objective, tell",
			help = L["A party chat line with the quest's link when you finish its objectives, and one when the quest is ready to turn in. Everyone in the party sees it, Polestar or not. Never solo or in a raid."] },
		{ kind = "toggle", key = "party.chatLoot", label = L["Tell my party when I loot an item that starts a quest"], search = SEARCH .. ", chat, announce, loot, item, tell",
			help = L["A party chat line with the item's link and the quest it starts."] },
		{ kind = "toggle", key = "party.chatEcho", label = L["Show my own lines in my chat too"], search = SEARCH .. ", chat, announce",
			disabled = function() return not (ns.Get("party.chat") or ns.Get("party.chatLoot")) end,
			help = L["Off: your party sees the lines Polestar says for you, and your chat stays clear of them."] },
		{ kind = "toggle", key = "party.chatHideOthers", label = L["Hide other players' Polestar lines"], search = SEARCH .. ", chat, announce, hide",
			help = L["Party members' Polestar lines leave your chat. Shown, they carry Polestar's star."] },
		{ kind = "toggle", key = "party.chatOnlyNeeded", label = L["Only when someone in the party doesn't have Polestar"], search = SEARCH .. ", chat, announce",
			disabled = function() return not (ns.Get("party.chat") or ns.Get("party.chatLoot")) end,
			help = L["Nothing goes to chat while everyone in your party runs Polestar: they see your progress in their guide."] },
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
