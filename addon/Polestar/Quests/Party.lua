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
-- predate it drop it as malformed. It gives a once-a-session notice when a
-- member runs another Polestar version or a newer guide pack. Right after it goes
-- "2P|<step key>|<guide id>" (Party.StepKey: the step by what it holds, not
-- its number), which version-1 decoders drop: the "N steps ahead/behind"
-- line matches the step in your own copy of the guide and counts only the
-- steps you and the member both have (a Warrior-only step between a
-- Warrior and a Mage does not count). A member who sends only "1P|"
-- (0.3.5) is compared by its number, on the same guide and pack version.
--
-- Sync to my guide: "2G|<step key>|<guide id>" asks the party
-- to move to your step; each member gets an accept/decline prompt, never
-- an automatic move, and answers "2A|<y|n|x|=>" (accepted, declined, cannot:
-- no such guide or step for them, already there). Accepting opens the guide
-- (another tab when needed) and skips the steps up to it (Engine.SkipUpTo);
-- ticks and skips the member had stay. Once per SYNC_GAP seconds each way.
--
-- Who you are: "2U|<level>|<XP %>|<class id>|<race id>|<Polestar
-- version>", version 2, which every version-1 decoder (Decode, DecodePos)
-- drops as malformed; sent with every snapshot and when the level or the
-- whole XP percent changes (debounced). Fields after the race are ignored by
-- 0.3.6 and older (the Polestar version came in 0.3.7), and after the
-- version by this one, so a later version can add more. It gives the party
-- panel's level and XP, the reason a member cannot take a quest you would
-- share, and, with the hello's and "1P|"'s version, the once-a-session
-- note that a member on another Polestar version may see other guides.
--
-- What you did: "2D|<quest>,<quest>,..." the quests of the steps around
-- your live step (DONE_BACK before it, DONE_AHEAD after) that you handed
-- in, sent after "1P|"/"2P|" when it changed and with every snapshot (a
-- snapshot makes the party forget the last one). Every older decoder drops
-- it. It turns a member's "Not on this quest: Ana" into "Ana (already
-- done)" and keeps Share from offering her the quest.
--
-- Boosted Rest: "2B|<seconds left>" ("2B|*" on without an end given, "2B|0"
-- ended), version 2, which version-1 decoders and 0.3.6's version-2 ones
-- (DecodeUnit, DecodeAt, DecodeAnswer) drop. A separate message rather
-- than a field on "2U|", so it adds nothing to clients that ignore it and
-- leaves "2U|"'s later fields to the Polestar version. Sent when Boosted
-- Rest starts, ends or is renewed (QoL/Rest.lua's QOL_REST_UPDATED,
-- debounced) and with every snapshot while it is on; never while it was
-- never on. Fields after the first are ignored. The party panel shows it.
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

-- u = { level, xp (whole percent), class (class id), race (race id),
-- version (Polestar's) } -> the "2U|" message; nil without a level.
local UNIT_VERSION = "2"
local VERSION_MAX = 32 -- characters of a Polestar version a message carries
function Party.EncodeUnit(u)
	local level = type(u) == "table" and tonumber(u.level)
	if not level or level < 1 then return nil end
	local function n(v, top)
		v = tonumber(v)
		return v and v >= 0 and v <= top and tostring(math.floor(v)) or ""
	end
	local text = UNIT_VERSION .. "U|" .. n(level, MAX_COUNT) .. "|" .. (n(u.xp, 100) ~= "" and n(u.xp, 100) or "0") .. "|"
		.. n(u.class, MAX_COUNT) .. "|" .. n(u.race, MAX_COUNT)
	local version = u.version ~= nil and tostring(u.version):gsub("|", ""):sub(1, VERSION_MAX) or ""
	return version ~= "" and (text .. "|" .. version) or text
end

-- The "2U|" message -> u (class, race and version nil when not given; 0.3.6
-- and older send no version), or nil. What follows the version field (a
-- later version's) is ignored.
function Party.DecodeUnit(text)
	if type(text) ~= "string" then return nil end
	local level, xp, class, race, rest = text:match("^" .. UNIT_VERSION .. "U|(%d+)|(%d+)|(%d*)|(%d*)(.*)$")
	if not level or (rest ~= "" and rest:sub(1, 1) ~= "|") then return nil end
	level, xp = count(level), tonumber(xp)
	if not level or level < 1 or xp > 100 then return nil end
	local version = rest:match("^|([^|]*)")
	return { level = level, xp = xp, class = count(class), race = count(race), version = version ~= "" and version or nil }
end

-- ids: quest ids, the most wanted first -> the "2D|" message ("2D|" alone
-- for none), as many of them as fit MAX_BYTES (MAX_QUESTS at most).
local DONE_HEAD = UNIT_VERSION .. "D|"
function Party.EncodeDone(ids)
	local parts, size = {}, #DONE_HEAD
	for _, q in ipairs(type(ids) == "table" and ids or {}) do
		q = tonumber(q)
		if q and q > 0 and q == math.floor(q) then
			local p = tostring(q)
			local extra = (#parts > 0 and 1 or 0) + #p
			if #parts >= MAX_QUESTS or size + extra > Party.MAX_BYTES then break end
			parts[#parts + 1], size = p, size + extra
		end
	end
	return DONE_HEAD .. concat(parts, ",")
end

-- The "2D|" message -> { [quest id] = true } (empty for none), or nil for
-- anything else. What follows the list (a later version's "|...") is
-- ignored.
function Party.DecodeDone(text)
	if type(text) ~= "string" then return nil end
	local body, rest = text:match("^" .. UNIT_VERSION .. "D|([%d,]*)(.*)$")
	if not body or (rest ~= "" and rest:sub(1, 1) ~= "|") then return nil end
	local out, n = {}, 0
	if body == "" then return out end
	for p in (body .. ","):gmatch("([^,]*),") do
		local q = tonumber(p)
		if not q or q <= 0 or n >= MAX_QUESTS then return nil end
		if not out[q] then out[q], n = true, n + 1 end
	end
	return out
end

-- pos = { key, guide } (Party.MyPos) -> "2P|<step key>|<guide id>", where
-- you are by step identity; `request`: "2G|" instead, asking the party to
-- sync to that step. nil without a key or guide.
function Party.EncodeAt(pos, request)
	if type(pos) ~= "table" or type(pos.guide) ~= "string" or pos.guide == "" then return nil end
	if type(pos.key) ~= "string" or not pos.key:match("^[%w%.]+$") then return nil end
	local text = UNIT_VERSION .. (request and "G|" or "P|") .. pos.key .. "|" .. pos.guide
	return #text <= Party.MAX_BYTES and text or nil
end

-- "2P|"/"2G|" -> { key, guide }, and whether it is a sync request; nil for
-- anything else.
function Party.DecodeAt(text)
	if type(text) ~= "string" then return nil end
	local mark, key, guide = text:match("^" .. UNIT_VERSION .. "([PG])|([%w%.]+)|(.+)$")
	if not mark then return nil end
	return { key = key, guide = guide }, mark == "G"
end

-- The answer to a sync request: "y" accepted, "n" declined, "x" cannot (no
-- such guide or step for them), "=" already on that step.
local ANSWERS = { y = true, n = true, x = true, ["="] = true }
function Party.EncodeAnswer(code)
	return ANSWERS[code] and (UNIT_VERSION .. "A|" .. code) or nil
end
function Party.DecodeAnswer(text)
	if type(text) ~= "string" then return nil end
	local code = text:match("^" .. UNIT_VERSION .. "A|(.)$")
	return code and ANSWERS[code] and code or nil
end

-- Boosted Rest: seconds left (rounded up), true (on, no end given), or nil
-- (off) -> the "2B|" message.
function Party.EncodeRest(left)
	if left == true then return UNIT_VERSION .. "B|*" end
	if type(left) ~= "number" or left <= 0 then return UNIT_VERSION .. "B|0" end
	return UNIT_VERSION .. "B|" .. math.min(math.ceil(left), 86400)
end

-- The "2B|" message -> seconds left, true (on, no end), or false (off); nil
-- for anything else. What follows the first field is ignored.
function Party.DecodeRest(text)
	if type(text) ~= "string" then return nil end
	local v, rest = text:match("^" .. UNIT_VERSION .. "B|([%d%*]+)(.*)$")
	if not v or (rest ~= "" and rest:sub(1, 1) ~= "|") then return nil end
	if v == "*" then return true end
	local n = tonumber(v)
	if not n or n > 86400 then return nil end
	return n > 0 and n or false
end

---------------------------------------------------------------------------
-- Step identity: a step by what it holds, the same on every client with
-- the same guide whatever its class, race or language
---------------------------------------------------------------------------

-- A goal's part of its step's signature: its kind and ids (quest, line,
-- NPC, object, item, spell, level); a goal of none of those (a goto) by its
-- map and whole coordinates. Never text, which the client's language
-- changes.
local function scalar(v)
	local t = type(v)
	return (t == "number" or t == "string") and v or nil
end
local function goalSig(goal)
	if type(goal) ~= "table" then return "" end
	local q = scalar(goal.quest)
	local id = scalar(goal.npc) or scalar(goal.object) or scalar(goal.item) or scalar(goal.spell) or scalar(goal.level)
	local s = (scalar(goal.t) or "") .. ":" .. (q or "") .. "." .. (scalar(goal.oi) or "") .. ":" .. (id or "")
	if not (q or id) then
		s = s .. ":" .. (scalar(goal.map) or "") .. "@" .. math.floor(tonumber(goal.x) or 0) .. "," .. math.floor(tonumber(goal.y) or 0)
	end
	return s
end

-- A 31-bit string hash (djb2), in hex: well inside a double and a 32-bit
-- client's %x.
local function hash(s)
	local h = 5381
	for i = 1, #s do h = (h * 33 + s:byte(i)) % 2147483648 end
	return ("%x"):format(h)
end

-- steps table -> { of = { [index] = key }, at = { [key] = index } }; a key
-- is the hash of the step's goals, with ".<n>" for the nth step of the guide
-- that hashes the same (two identical gotos).
local stepKeys = setmetatable({}, { __mode = "k" })
local function keysOf(g)
	local steps = type(g) == "table" and g.steps
	if type(steps) ~= "table" then return nil end
	local k = stepKeys[steps]
	if k then return k end
	k = { of = {}, at = {} }
	local seen = {}
	for i, step in ipairs(steps) do
		local parts = {}
		for j, goal in ipairs(type(step.goals) == "table" and step.goals or {}) do parts[j] = goalSig(goal) end
		local h = hash(concat(parts, ";"))
		local n = (seen[h] or 0) + 1
		seen[h] = n
		local key = n > 1 and (h .. "." .. n) or h
		k.of[i], k.at[key] = key, i
	end
	stepKeys[steps] = k
	return k
end

-- Step i of guide g -> its key; nil when g has no step i.
function Party.StepKey(g, i)
	local k = keysOf(g)
	return k and k.of[i] or nil
end

-- The step of guide g with key `key`, or nil (another version of the guide
-- that lacks it).
function Party.StepAt(g, key)
	local k = keysOf(g)
	return k and type(key) == "string" and k.at[key] or nil
end

-- Steps from step a to step b of guide g that are steps of their own for
-- both you and `who` (a member's { class, race, faction }; Engine.
-- StepHiddenFor): b's place minus a's, counting only those. Steps one of
-- you does not have never put either ahead.
function Party.SharedSteps(g, a, b, who)
	local hidden = ns.Engine and ns.Engine.StepHiddenFor
	if not (hidden and type(g) == "table" and type(g.steps) == "table") then return b - a end
	local lo, hi, sign = a, b, 1
	if b < a then lo, hi, sign = b, a, -1 end
	local n = 0
	for s = lo, hi - 1 do
		local step = g.steps[s]
		if step and not hidden(step) and not hidden(step, who) then n = n + 1 end
	end
	return n * sign
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

-- Where you are: the active guide, its live step, the step's key
-- (Party.StepKey) and the versions (pos as Party.EncodePos and EncodeAt
-- take it), or nil without a guide.
function Party.MyPos()
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	if not g then return nil end
	local G = ns.Guides
	local pack = g.pack and G and G.Pack and G.Pack(g.pack)
	local step = E.GetLiveStep and E.GetLiveStep() or nil
	return { step = step, key = step and Party.StepKey(g, step) or nil, addon = ns.version, pack = g.pack or "",
		packVersion = pack and pack.version and tostring(pack.version) or "", guide = g.id }
end

local posSent -- the "1P|" and "2P|" texts the party last got from us
local posPending = false

-- What you did (the "2D|" message): the quests of the active guide's steps
-- from DONE_BACK before the live step to DONE_AHEAD after it (the last
-- DONE_BACK with none live) that you have handed in, nearest the live step
-- first; {} without a guide. A member behind you finds there the quests
-- you are past; only your guide's steps, so the message stays small.
local DONE_BACK, DONE_AHEAD = 20, 5
function Party.MyDone()
	local E, C = ns.Engine, ns.Compat
	local g = E and E.GetGuide and E.GetGuide()
	local steps = g and g.steps
	local out = {}
	if type(steps) ~= "table" then return out end
	local live = E.GetLiveStep and E.GetLiveStep() or (#steps + 1)
	local seen = {}
	local function look(s)
		local step = steps[s]
		if type(step) ~= "table" or type(step.goals) ~= "table" then return end
		for _, goal in ipairs(step.goals) do
			local q = type(goal) == "table" and goal.quest
			if type(q) == "number" and not seen[q] then
				seen[q] = true
				if C.IsQuestCompleted(q) then out[#out + 1] = q end
			end
		end
	end
	for d = 0, DONE_BACK do
		look(live - d)
		if d > 0 and d <= DONE_AHEAD then look(live + d) end
	end
	return out
end

-- The "2D|" text the party holds from us; nil: none (a snapshot makes the
-- party forget it: `apply`).
local doneSent

-- What you did, unless the party has it; an empty list goes out only to
-- clear one the party holds.
local function sendDone()
	local text = Party.EncodeDone(Party.MyDone())
	if text == (doneSent or DONE_HEAD) then return end
	if send({ text }) == 1 then doneSent = text ~= DONE_HEAD and text or nil end
end

-- Our position to the party, unless it already has this one (`force`: with
-- a snapshot, which a member who just joined needs): "1P|", then "2P|" when
-- the live step has a key, then what we did ("2D|") when that changed.
local function sendPos(force)
	posPending = false
	if force then doneSent = nil end
	if not sharing() then return end
	local pos = Party.MyPos()
	local text = Party.EncodePos(pos)
	if not text then return end
	local msgs = { text, Party.EncodeAt(pos) }
	local all = concat(msgs, "\n")
	if all ~= posSent or force then
		if send(msgs) ~= #msgs then return end
		posSent = all
	end
	sendDone()
end

local function onStep()
	if posPending or not sharing() or not C_Timer then return end
	posPending = true
	ns.After(DEBOUNCE, function() sendPos(false) end)
end

-- Who you are (Party.EncodeUnit takes it): level, whole XP percent, class
-- and race ids, and your Polestar version.
function Party.MyUnit()
	local level = UnitLevel and UnitLevel("player")
	local xp, top = UnitXP and UnitXP("player"), UnitXPMax and UnitXPMax("player")
	local class, race
	if UnitClass then class = select(3, UnitClass("player")) end
	if UnitRace then race = select(3, UnitRace("player")) end
	return { level = level, xp = (xp and top and top > 0) and math.floor(xp * 100 / top) or 0, class = class, race = race,
		version = ns.version }
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

-- Our Boosted Rest (QoL/Rest.lua): sent when it changes, debounced, and
-- with every snapshot while it is on; an end only to a party that was told
-- it was on.
local restShared = false -- the party last heard it on
local restPending = false
local function myRest()
	local R = ns.QoL and ns.QoL.Rest
	if not (R and R.Left and ns.QoL.On and ns.QoL.On("boostedRest")) then return nil end
	return R.Left()
end
local function sendRest()
	restPending = false
	if not sharing() then return end
	local left = myRest()
	if left == nil and not restShared then return end
	if send({ Party.EncodeRest(left) }) == 1 then restShared = left ~= nil end
end
-- QOL_REST_UPDATED(changed): only a real change goes out, not the minute
-- redraws of the guide window's line.
local function onRest(changed)
	if not changed or restPending or not sharing() or not C_Timer then return end
	restPending = true
	ns.After(DEBOUNCE, sendRest)
end
ns.On("QOL_REST_UPDATED", onRest)

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
		if myRest() ~= nil then sendRest() end
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

local members = {} -- roster key -> { name = short name, quests = { [q] = { { cur, max }, ... } }, n = quests, pos, unit, done = { [q] = true } }
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

-- A change only the party panel shows (a member's XP percent, Party.Roster):
-- PARTY_PANEL after the same delay, so the panel repaints as soon as it did,
-- without the guide window's and the engine's update for a change they do
-- not show. A PARTY_PROGRESS on its way repaints the panel too.
local panelPending = false
local function panelChanged()
	if progressPending or panelPending then return end
	if not C_Timer then return ns.Fire("PARTY_PANEL") end
	panelPending = true
	ns.After(PROGRESS_DELAY, function()
		panelPending = false
		ns.Fire("PARTY_PANEL")
	end)
end

-- Sync to my guide: when we last asked and whom (answers count from them
-- for ANSWER_WINDOW seconds), when each member last asked us, and the
-- request on our prompt ({ key, name, at }).
local sync = { asked = {}, heardAt = {} }
local SYNC_POPUP = "POLESTAR_PARTY_SYNC"

local function forgetAll()
	local had = next(members) ~= nil or next(roster) ~= nil or next(gone) ~= nil
	roster, lastSent, members, owed, shared, askOwed, posSent, unitSent, doneSent = {}, {}, {}, nil, false, false, nil, nil, nil
	gone, units, released, spoken, helloOwed, helloTries = {}, {}, {}, {}, false, 0
	sync.asked, sync.heardAt = {}, {}
	if sync.pending then
		sync.pending = nil
		if StaticPopup_Hide then StaticPopup_Hide(SYNC_POPUP) end
	end
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

-- A snapshot replaces what is known of the member's log, and what they did
-- ("2D|"), which follows it when they have any.
local function apply(m, entries, snap)
	if snap then m.quests, m.n, m.done = {}, 0, nil end
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

-- Whether v is a release's version number ("0.3.7"), not a dev build's.
local function release(v)
	return type(v) == "string" and v:match("^%d+[%.%d]*$") ~= nil
end

-- Once a session per member and version, with showing on: a member on
-- another Polestar release than yours (both known), whose guides can
-- differ from yours; theirs newer, also that a newer version is out. From
-- their hello, "1P|" or "2U|".
local toldVersion = {} -- roster key -> the version said
local function noticeVersion(key, name, version)
	if not ns.Get("party.show") or not release(version) or not release(ns.version) or toldVersion[key] == version then return end
	local newer = Party.Newer(version, ns.version)
	if not (newer or Party.Newer(ns.version, version)) then return end
	toldVersion[key] = version
	local L = ns.L
	-- The update card (UI/UpdateCard.lua) already says a newer version is out
	-- when it has shown, or will this session, for that one (Update.Covers).
	local U = ns.Update
	if newer and not (U and U.Covers(version)) then
		ns.Print(L["%s is on Polestar %s: your guides can differ. A newer version is out."]:format(name, version))
	else
		ns.Print(L["%s is on Polestar %s: your guides can differ."]:format(name, version))
	end
end

-- Once a session each: a member has a newer version of a guide pack you
-- have.
local toldPack = {}
local function noticePack(name, pos)
	local G = ns.Guides
	local mine = pos.pack ~= "" and G and G.Pack and G.Pack(pos.pack)
	if mine and not toldPack[pos.pack] and Party.Newer(pos.packVersion, tostring(mine.version or "")) then
		toldPack[pos.pack] = true
		ns.Print(ns.L["%s has a newer %s guide pack (%s; yours is %s)."]:format(name, mine.title or pos.pack, pos.packVersion, tostring(mine.version)))
	end
end

-- Once per account, the first time the guide gets a party member's
-- progress to show with sharing and showing both on (as they start): you
-- and your party see each other's, and Options turns it off. A player who
-- turned either off has been to Options already.
local function tellOnce()
	local db = ns.DB()
	if db.partySyncTold or not (ns.Get("party.share") and ns.Get("party.show")) then return end
	db.partySyncTold = true
	ns.Print(ns.L["Party sync is on: you and your party see each other's quest progress. Turn it off in Options."])
end

-- The member under roster key `key`, whose progress the guide is about to
-- show (showing is on): created when new, and the one-time notice said.
local function memberFor(key, short)
	local m = members[key]
	if not m then
		m = { name = short, key = key, quests = {}, n = 0 }
		members[key] = m
	end
	tellOnce()
	return m
end

-- A member spoke Polestar (any valid message). One new to us gets our
-- snapshot unless their message already asks for it. True when they are
-- new.
local function heard(key, asks)
	if spoken[key] then return false end
	spoken[key] = true
	progressChanged()
	if not asks and ns.Get("party.share") then scheduleSnapshot(false) end
	return true
end

---------------------------------------------------------------------------
-- Sync to my guide
---------------------------------------------------------------------------

local SYNC_GAP = 30 -- seconds between our requests, and between a member's to us
local ANSWER_WINDOW = 300 -- seconds an answer to our request counts
local NOTE_MAX = 6 -- quests a prompt's note names, then "and N more"

local function answer(code)
	if grouped() then send({ Party.EncodeAnswer(code) }) end
end

-- The member under roster key `key` as Engine.StepHiddenFor takes them:
-- their class and race (the client's, else their "2U|"), else yours, and
-- your faction.
local function memberWho(key)
	local me = ns.Compat.GetPlayerInfo()
	local info = Party.UnitInfo(units[key], key)
	return { class = info.class or me.class, race = info.race or me.race, faction = me.faction }
end

-- Goals' quests as a prompt names them, NOTE_MAX at most.
local function questList(goals)
	local L, N = ns.L, ns.Names
	local names = {}
	for i = 1, math.min(#goals, NOTE_MAX) do
		local goal = goals[i]
		names[i] = ns.Quoted(N and N.Quest and N.Quest(goal.quest) or goal.title or tostring(goal.quest))
	end
	local text = concat(names, ", ")
	if #goals > NOTE_MAX then text = L["%s and %d more"]:format(text, #goals - NOTE_MAX) end
	return text
end

-- What accepting a sync to `at` ({ key, guide }, Party.DecodeAt) from a
-- member `who` ({ class, race, faction }; nil: as you) would do for you, or
-- nil when you cannot follow it (no such guide, not one for your
-- character, or your copy lacks the step): { guide, step (its index in your
-- copy), who, switch (another tab: the guide is not the active one), same
-- (on that step already: no step you both have between), ahead (your live
-- step is past it: nothing moves), passed (quests the move leaves behind:
-- an accept you have not taken, work or a turn-in you have not done, on the
-- steps it skips; the sender is past them), done (the quests you did
-- already that your guide passes there) }; passed and done are lists of
-- goals, one per quest. The steps the member does not have (your class's,
-- your race's) are never skipped (Engine.SkipUpTo's keep).
function Party.SyncOffer(at, who)
	local G, E, C = ns.Guides, ns.Engine, ns.Compat
	local g = type(at) == "table" and G and G.Get and G.Get(at.guide)
	if not g then return nil end
	local me = C.GetPlayerInfo()
	if not (G.GuideMatches(g, me) or G.OtherStart(g, me)) then return nil end
	local t = Party.StepAt(g, at.key)
	if not t then return nil end
	local cur = E.GetGuide()
	local active = cur ~= nil and cur.id == g.id
	local live = active and E.GetLiveStep() or nil
	local offer = { guide = g, step = t, who = who, switch = not active, passed = {}, done = {} }
	if live and Party.SharedSteps(g, live, t, who) == 0 then
		offer.same = true
		return offer
	end
	local seen = {}
	-- Step s's goals for you with a quest that want(goal) takes, once per
	-- quest, onto `list`; `shared`: only on a step the member has too.
	local function quests(s, list, want, shared)
		local step = g.steps[s]
		if not step or E.StepHiddenFor(step) or (shared and E.StepHiddenFor(step, who)) then return end
		for _, goal in ipairs(step.goals) do
			local q = goal.quest
			if q and not seen[q] and G.Matches(goal.only, me) and want(goal) then
				seen[q] = true
				list[#list + 1] = goal
			end
		end
	end
	local function did(q) return C.IsQuestCompleted(q) and true or false end
	local function done(goal) return did(goal.quest) end
	if active and (not live or live > t) then
		offer.ahead = true
		for s = t, (live or #g.steps + 1) - 1 do quests(s, offer.done, done) end
		return offer
	end
	local skipped = E.IsQuestSkipped
	local function owed(goal)
		local q = goal.quest
		if did(q) or (active and skipped and skipped(q)) then return false end
		if goal.t == "accept" then return not C.IsOnQuest(q) end
		if goal.t == "turnin" then return true end
		return not (C.IsOnQuest(q) and C.IsQuestReadyForTurnIn(q))
	end
	for s = live or 1, t - 1 do quests(s, offer.passed, owed, true) end
	-- From their step on, the steps whose quests you have all done: the guide
	-- passes them on arrival.
	for s = t, #g.steps do
		local step = g.steps[s]
		if not E.StepHiddenFor(step) then
			local any = false
			for _, goal in ipairs(step.goals) do
				if goal.quest and G.Matches(goal.only, me) then
					if not did(goal.quest) then
						any = false
						break
					end
					any = true
				end
			end
			if not any then break end
			quests(s, offer.done, done)
		end
	end
	return offer
end

-- The prompt's text for a request from `name` (Party.SyncOffer's offer).
function Party.SyncPrompt(name, offer)
	local L, E = ns.L, ns.Engine
	local lines = { L["%s asks you to sync to their guide."]:format(name) }
	if offer.switch then lines[#lines + 1] = L["You'll switch to %s."]:format(offer.guide.title or offer.guide.id) end
	local step = offer.guide.steps[offer.step]
	local title = step and step.title
	if type(title) ~= "string" or title == "" then title = L["Step %d"]:format((E.StepNumberOf(offer.guide, offer.step))) end
	lines[#lines + 1] = L["Their step: %s"]:format(title)
	if offer.ahead then lines[#lines + 1] = L["You're past their step: your guide stays where you are."] end
	if #offer.passed > 0 then
		lines[#lines + 1] = L["%s is past these, which you haven't done: %s"]:format(name, questList(offer.passed))
	end
	if #offer.done > 0 then lines[#lines + 1] = L["You've done these already, so your guide passes them: %s"]:format(questList(offer.done)) end
	return concat(lines, "\n\n")
end

local function showPrompt(text, req)
	if ns.GamepadUI() or not (StaticPopupDialogs and StaticPopup_Show) then return false end
	StaticPopupDialogs[SYNC_POPUP] = StaticPopupDialogs[SYNC_POPUP] or {
		text = "%s",
		button1 = ACCEPT or YES,
		button2 = DECLINE or NO,
		OnAccept = function(_, data) Party.AcceptSync(data) end,
		-- "override": a newer request took the prompt; that one is still open.
		OnCancel = function(_, data, reason) if reason ~= "override" then Party.DeclineSync(data) end end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3,
	}
	StaticPopup_Show(SYNC_POPUP, text, nil, req)
	return true
end

-- A member's "2G|": once per SYNC_GAP from each, a prompt (never an
-- automatic move); "x" back when you cannot follow it, "=" when you are on
-- that step already. A newer request takes the prompt over. With the
-- gamepad interface (its focus owns the game's dialogs) no prompt shows:
-- chat says so and the answer is "n".
local function onSyncRequest(key, name, at)
	local now = GetTime()
	local last = sync.heardAt[key]
	if last and now - last < SYNC_GAP then return end
	sync.heardAt[key] = now
	local who = memberWho(key)
	local offer = Party.SyncOffer(at, who)
	if not offer then
		answer("x")
		ns.Print(ns.L["%s asked you to sync to their guide, but it isn't for your character or your copy lacks their step."]:format(name))
		return
	end
	if offer.same then return answer("=") end
	local req = { key = key, name = name, at = at, who = who }
	sync.pending = req
	if not showPrompt(Party.SyncPrompt(name, offer), req) then
		sync.pending = nil
		answer("n")
		ns.Print(ns.L["%s asked you to sync to their guide; that prompt can't show with the gamepad interface."]:format(name))
	end
end

-- The request on the prompt (or `req`, the prompt's own), accepted: its
-- guide active (opened in another tab when needed), then the steps up to
-- theirs skipped (Engine.SkipUpTo; your ticks and skips stay). Answers
-- "y" (or "n" with every tab taken, "x" when the guide is gone). True when
-- it synced.
function Party.AcceptSync(req)
	req = req or sync.pending
	if not req or req ~= sync.pending then return false end
	sync.pending = nil
	local E = ns.Engine
	local offer = Party.SyncOffer(req.at, req.who)
	if not offer then
		answer("x")
		return false
	end
	local cur = E.GetGuide()
	if not (cur and cur.id == offer.guide.id) and not E.OpenTab(offer.guide.id) then
		ns.Print(ns.L["No room for another guide tab: close one, then ask %s again."]:format(req.name))
		answer("n")
		return false
	end
	local t = Party.StepAt(E.GetGuide(), req.at.key)
	-- The steps they do not have (your class's own) stay yours.
	if t then E.SkipUpTo(t, function(step) return E.StepHiddenFor(step, req.who) end) end
	answer("y")
	return true
end

-- The request on the prompt (or `req`), declined: nothing changes; "n".
function Party.DeclineSync(req)
	req = req or sync.pending
	if not req or req ~= sync.pending then return false end
	sync.pending = nil
	answer("n")
	return true
end

-- An answer to our request, from a member we asked within ANSWER_WINDOW.
local function onSyncAnswer(key, name, code)
	local at = sync.asked[key]
	if not at or GetTime() - at > ANSWER_WINDOW then return end
	sync.asked[key] = nil
	local L = ns.L
	if code == "y" then
		ns.Print(L["%s synced to your guide."]:format(name))
	elseif code == "n" then
		ns.Print(L["%s declined to sync."]:format(name))
	elseif code == "x" then
		ns.Print(L["%s can't sync: your guide isn't for their character, or their copy lacks your step."]:format(name))
	else
		ns.Print(L["%s is already on your step."]:format(name))
	end
end

-- "Sync to my guide" (the party panel's button, /polestar party sync): asks
-- every member who runs Polestar to move to your live step. Once per
-- SYNC_GAP; says in chat what happened. True when it went out.
function Party.RequestSync()
	local L = ns.L
	if not grouped() or next(spoken) == nil then
		ns.Print(L["No one else in your party has been heard running Polestar yet."])
		return false
	end
	local text = Party.EncodeAt(Party.MyPos(), true)
	if not text then
		ns.Print(L["You have no step to sync to: open a guide you haven't finished."])
		return false
	end
	local now = GetTime()
	if sync.askedAt and now - sync.askedAt < SYNC_GAP then
		ns.Print(L["You asked a moment ago: wait %d seconds."]:format(math.ceil(SYNC_GAP - (now - sync.askedAt))))
		return false
	end
	if send({ text }) ~= 1 then
		ns.Print(L["The game didn't send it: try again in a moment."])
		return false
	end
	sync.askedAt = now
	for key in pairs(spoken) do sync.asked[key] = now end
	ns.Print(L["Asked your party to sync to your step. Each of them chooses."])
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
	local mark, version = Party.DecodeHello(text)
	-- Every member's Polestar version tells the update notices (Core/Update.lua).
	if mark and ns.Update then ns.Update.NotePeer(version) end
	if mark == "H" then
		-- A hello (they joined, logged in or reloaded): a sharer answers with
		-- its snapshot, asking theirs; anyone else with a bare answer.
		heard(key, true)
		noticeVersion(key, short, version)
		if ns.Get("party.share") then
			scheduleSnapshot(true)
		else
			send({ Party.EncodeHello(true) })
		end
		return
	elseif mark == "Y" then
		heard(key, false)
		noticeVersion(key, short, version)
		return
	end
	local pos = Party.DecodePos(text)
	if pos and ns.Update then ns.Update.NotePeer(pos.addon) end
	if pos then
		heard(key, false)
		if not ns.Get("party.show") then return end
		-- Its "2P|" follows (a 0.3.5 member sends none): until then, the number.
		local m = memberFor(key, short)
		m.pos, m.at = pos, nil
		noticeVersion(key, short, pos.addon)
		noticePack(short, pos)
		progressChanged()
		return
	end
	local at, request = Party.DecodeAt(text)
	if at then
		heard(key, false)
		if request then return onSyncRequest(key, short, at) end
		if not ns.Get("party.show") then return end
		memberFor(key, short).at = at
		progressChanged()
		return
	end
	local code = Party.DecodeAnswer(text)
	if code then
		heard(key, false)
		return onSyncAnswer(key, short, code)
	end
	local done = Party.DecodeDone(text)
	if done then
		heard(key, false)
		if not ns.Get("party.show") then return end
		memberFor(key, short).done = done
		progressChanged()
		return
	end
	local u = Party.DecodeUnit(text)
	if u then
		heard(key, false)
		if ns.Update then ns.Update.NotePeer(u.version) end
		if not ns.Get("party.show") then return end
		local m = members[key]
		local old = m and m.unit
		memberFor(key, short).unit = u
		noticeVersion(key, short, u.version)
		-- Level, class and race decide what a member can take (whyNot) and
		-- which steps are theirs (memberWho); the XP percent shows only on
		-- the party panel; the same unit again changes nothing.
		if old and old.level == u.level and old.class == u.class and old.race == u.race then
			if old.xp ~= u.xp then panelChanged() end
		else
			progressChanged()
		end
		return
	end
	local rest = Party.DecodeRest(text)
	if rest ~= nil then
		heard(key, false)
		if not ns.Get("party.show") then return end
		memberFor(key, short).rest = rest and { left = rest, at = GetTime() } or nil
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
	local view = s and E.GetStepView(s, true)
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
	local view = s and E.GetStepView(s, true)
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

-- In the client's chat lockdown (encounters, dungeons) the system line is a
-- secret string, and matching one throws: it reads as no answer.
local function onSystem(_, text)
	if not pushQuest or type(text) ~= "string" or ns.Compat.IsSecret(text) then return end
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
-- share, else what they did ("2D|": handed in), else the quest database
-- against their class, race and level. Returns the reason's text, whether
-- it rules the quest out, and its kind (a PUSH_ERRORS reason: "done",
-- "class", "race", "low"...).
local function whyNot(unit, key, name, q)
	local said = pushed[q] and pushed[q][name]
	if said then return reasonText(said), BLOCKS[said] or false, said end
	local m = key and members[key]
	if m and m.done and m.done[q] then return L["already done"], true, "done" end
	local Q = ns.QuestDB
	local r = Q and Q.IsLoaded and Q.IsLoaded() and Q.GetQuest and Q.GetQuest(q)
	if not r then return nil, false end
	local info = Party.UnitInfo(unit, key)
	local ctx = Q.PlayerContext({ level = info.level or 1, race = info.race, class = info.class })
	local band = bit and bit.band
	if band and r.classes and r.classes > 0 and ctx.classBit and band(r.classes, ctx.classBit) == 0 then return L["another class"], true, "class" end
	if band and r.races and r.races > 0 and ctx.raceBit and band(r.races, ctx.raceBit) == 0 then return L["another race"], true, "race" end
	if r.minLevel and info.level and info.level < r.minLevel then return L["level %d, needs %d"]:format(info.level, r.minLevel), true, "low" end
	return nil, false
end

-- Party members (connected) who have spoken Polestar and lack quest `q`:
-- what they sent first, else the client's own party check (which may not
-- know about members far away); nothing is said of members without
-- Polestar. { { name, unit, key, why (text or nil), blocked, kind (whyNot's)
-- }, ... } by name.
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
				local why, blocked, kind = whyNot(unit, key, name, q)
				out[#out + 1] = { name = name, unit = unit, key = key, why = why, blocked = blocked, kind = kind }
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
		lastSent, owed, shared, unitSent, doneSent = {}, nil, false, nil, nil
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
-- when we know ("Not on this quest: Ben (level 8, needs 10), Dee (already
-- done)"), leaving out a member whose class or race cannot take it (their
-- guide never has it). On a turn-in ready for you, the group's wait
-- ("Waiting on Ana", "Everyone's ready").
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
		local named = {}
		for _, e in ipairs(lacking) do
			if e.kind ~= "class" and e.kind ~= "race" then
				named[#named + 1] = e.why and L["%s (%s)"]:format(e.name, e.why) or e.name
			end
		end
		if #named > 0 then
			parts[#parts + 1] = L["Not on this quest: %s"]:format(concat(named, ", "))
		end
	end
	if #parts == 0 then return nil end
	return concat(parts, DOT)
end

-- Member m's step in guide g (your active one; `mine`: Party.MyPos): their
-- "2P|" key found in your copy, else, from a member who sends only "1P|"
-- (0.3.5), its number on the same pack version. nil when neither.
local function theirStep(m, g, mine)
	local at = m.at
	if at and at.guide == g.id then
		local i = Party.StepAt(g, at.key)
		if i then return i end
	end
	local p = m.pos
	if p and p.step and p.guide == g.id and p.packVersion == mine.packVersion then return p.step end
	return nil
end

-- Member m as Engine.StepHiddenFor takes them (memberWho).
local function whoOf(m) return memberWho(m.key) end

-- The guide window's party line for the live step, and whether the group
-- waits on it (the line then offers "Go on without them"), or nil. Where
-- members are on your guide: "Ana: 3 steps ahead", "Ben: 1 step behind",
-- "Cy: on this step", counting only the steps you both have (a step for one
-- of you alone never puts either ahead); "Dee: other guide" on another;
-- then the wait ("Waiting on Ana", "Everyone's ready"), or with nobody
-- holding the step, a soft hint when you are done with its objectives and
-- a member is not ("Still at it: Ben").
function Party.StepLine()
	if not ns.Get("party.show") or not grouped() then return nil end
	local mine = Party.MyPos()
	local E = ns.Engine
	local g = mine and mine.step and E.GetGuide and E.GetGuide()
	local parts, list = {}, Party.Members()
	for _, m in ipairs(list) do
		local p = m.pos
		local theirs = g and theirStep(m, g, mine)
		if theirs then
			local d = Party.SharedSteps(g, mine.step, theirs, whoOf(m))
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
		local view = ns.Engine.GetStepView(mine.step, true)
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
-- (stepNeeds of your live step), rest (Boosted Rest: seconds left, true on
-- without an end, nil off or not sent) }. Empty without one.
function Party.Roster()
	local out = {}
	if not grouped() then return out end
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	local live = E and E.GetLiveStep and E.GetLiveStep()
	local view = live and E.GetStepView(live, true)
	local mine = Party.MyPos() or {}
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
					local s = theirStep(m, g, mine) or (not m.at and p.step) or nil
					local st = s and g.steps and g.steps[s]
					row.step = st and st.title or (s and L["Step %d"]:format(E.StepNumberOf and (E.StepNumberOf(g, s)) or s)) or nil
				elseif p then
					row.otherGuide = true
				end
				row.needs = stepNeeds(m, view)
				-- Boosted Rest: seconds left now, or true (on, no end given).
				local r = m.rest
				if r and r.left == true then
					row.rest = true
				elseif r then
					local left = r.left - (GetTime() - r.at)
					row.rest = left > 0 and left or nil
				end
			end
			out[#out + 1] = row
		end
	end
	return out
end

-- Lead the arrow to a party member, where the client gives their place on
-- the map (the open world; not in an instance), following them as they
-- move (Nav.MoveTarget: one arrival, one chime). A trip (Nav.StartTrip):
-- it ends when you reach them, on "Back to the guide" (the guide window's
-- banner, the arrow's menu, the journey's x), or once they leave the party,
-- go offline or the client gives their place no more. False when there is
-- no place to lead to.
local FOLLOW = 3 -- seconds between looks at where they are
local follow -- { key, target, ticker }
local function stopFollow()
	if follow and follow.ticker then follow.ticker:Cancel() end
	follow = nil
end

-- The unit that is member `key` now (the party's slots move up when someone
-- leaves), or nil once they are gone.
local function unitOfMember(key)
	local n = GetNumSubgroupMembers and GetNumSubgroupMembers() or 0
	for i = 1, n do
		local unit = "party" .. i
		if memberKey(unit) == key then return unit end
	end
	return nil
end

local function followTick()
	local Nav = ns.Nav
	if not follow or Nav.GetTarget() ~= follow.target then return stopFollow() end
	local unit = follow.key and unitOfMember(follow.key)
	local map, x, y
	if unit and not (UnitIsConnected and not UnitIsConnected(unit)) then map, x, y = ns.Compat.GetUnitMapPosition(unit) end
	if not map then
		stopFollow()
		if not Nav.EndTrip() then Nav.ReleaseTarget() end
		return
	end
	local t = follow.target
	if map ~= t.map or math.abs(x - t.x) + math.abs(y - t.y) > 0.5 then Nav.MoveTarget(t, map, x, y) end
end

function Party.PointAt(unit)
	local Nav = ns.Nav
	local map, x, y = ns.Compat.GetUnitMapPosition(unit)
	if not (map and Nav and Nav.SetTarget) then return false end
	local key, name = memberKey(unit)
	stopFollow()
	local target = Nav.SetTarget(map, x, y, name and L["Party: %s"]:format(name) or L["Party"])
	if not target then return false end
	Nav.StartTrip(target, name, L["Party"])
	follow = { key = key, target = target }
	if C_Timer and C_Timer.NewTicker then follow.ticker = ns.NewTicker(FOLLOW, followTick) end
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

