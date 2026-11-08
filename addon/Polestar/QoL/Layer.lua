-- Layer hop (opt in, "qol.layerHop"): which layer of the zone the player is
-- on, a group invite from a Polestar player on another layer, and the game's
-- world refresh that then moves the player there.
--
-- Forever splits a zone into layers and exposes no layer id. Like other layer
-- addons, the id is read from creature and vehicle GUIDs
-- (Creature-0-<server>-<instance>-<zoneUID>-<npc>-<spawn>): field LAYER_FIELD,
-- the one constant to change should Forever vary another field
-- (/polestar layer debug prints them all).
--
-- Joining a group whose leader is on another layer makes the server schedule
-- a world refresh: SHARD_TRANSFER_IMMINENT, GetEvictionTimeRemaining() seconds
-- left, C_PlayerInteractionManager.ShardTransferConfirm() to take it now (out
-- of combat; Blizzard's SHARD_TRANSFER_IMMEDIATE dialog is the fallback when
-- the call does nothing), SHARD_TRANSFER when it happens,
-- SHARD_TRANSFER_CANCELLED when it is called off. UnitInPartyShard tells
-- whether a party member is on the player's shard.
--
-- Live Forever realms (build 70862): addon messages are refused on every channel,
-- plain channel text goes out only inside a click or keypress (measured with
-- one client); addon whispers and invites from code are what the other layer
-- addons rely on there (their source, not measured here).
-- So a request goes out two ways. Plain lines on the hidden custom channel
-- PolestarLayer, sent only by Layer.Request and Layer.Ask, synchronously
-- inside the click or typed command that called them:
--   PLH1 R <map>:<from>:<want>   a hop request (from: a layer id or empty; want: an id or *)
--   PLH1 Q <map>                 asks the players on this map for their layer
-- And addon whispers, prefix PolestarLayer, protocol version 1, fields ":"-separated:
--   1R<map>:<from>:<want>        the request, to the hosts heard on the map and the zone's /who names
--   1H<map>:<layer>:<host 0|1>   the answer to a Q, to the asker
--   1I<name>                     a host's claim, to <name> right before its invite
-- A chat filter hides the lines and the channel is taken out of the chat
-- windows. Names are used as the client gives them ("First Surname"), never split.
--
-- While the opt-in is off nothing is registered, joined, filtered or sent:
-- every game event goes through QoL.WhileOn (the /who answer through a frame
-- of the module's own, registered only while its /who is out), the channel is
-- joined on enable and left on disable. Every change fires LAYER_CHANGED (the
-- window, UI/LayerHop.lua).
-- Client: SHARD_TRANSFER_IMMINENT, SHARD_TRANSFER, SHARD_TRANSFER_CANCELLED,
-- GetEvictionTimeRemaining, C_PlayerInteractionManager.ShardTransferConfirm,
-- UnitInPartyShard, JoinChannelByName, LeaveChannelByName, GetChannelName,
-- SendChatMessage, ChatFrame_AddMessageEventFilter (ChatFrameUtil when it has
-- it), C_ChatInfo.SendAddonMessage, RegisterAddonMessagePrefix and
-- InChatMessagingLockdown, C_FriendList.SendWho, SetWhoToUi, GetNumWhoResults
-- and GetWhoInfo, WhoFrame and LFGWhoListFrame, GetRealZoneText, EnumerateFrames,
-- C_PartyInfo.InviteUnit and
-- LeaveParty, C_NamePlate.GetNamePlates (Forever's API documentation); the
-- SHARD_TRANSFER_IMMEDIATE dialog (GameDialogDefs.lua).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local readable = ns.Compat.Readable

local format, tonumber, tostring, type, pairs, ipairs = string.format, tonumber, tostring, type, pairs, ipairs
local floor, random, sort, concat, remove = math.floor, math.random, table.sort, table.concat, table.remove

local Layer = {}
QoL.Layer = Layer

local PREFIX = "PolestarLayer"  -- addon-message prefix (16 characters at most)
local CHANNEL = "PolestarLayer" -- the hidden custom channel
local VERSION = "1"
local LINE = "PLH"              -- a channel line starts LINE .. VERSION .. " "
local LAYER_FIELD = 5           -- the GUID field read as the layer id
Layer.PREFIX, Layer.CHANNEL, Layer.LAYER_FIELD = PREFIX, CHANNEL, LAYER_FIELD

local MAX_BYTES = 120      -- longer messages are dropped
local FLOOD = 2            -- s: the window a sender's messages are counted in
local BURST = 4            -- messages per sender per FLOOD window; more are dropped
local PEER_AGE = 600       -- s: a peer not heard from this long is dropped
local ASK_EVERY = 60       -- s: Q at most this often; one answer per asker in this while
local INVITE_AGAIN = 300   -- s: a host invites one name once in this while
local PENDING = 120        -- s: a request waits this long for an invite
local WHO_EVERY = 10       -- s: one /who at most this often
local WHO_WAIT = 5         -- s: a /who not answered by then is given up
local WHO_MAX = 30         -- names taken from a /who answer
local WHISPER_BURST = 5    -- request whispers per second
local DONE_HOLD = 10       -- s: "done" shows this long
local CONFIRM_WAIT = 3     -- s: no SHARD_TRANSFER after a confirm: Blizzard's dialog
local AUTO_FOR = 60        -- s: auto refresh retries this long
local AFTER_JOIN = 2       -- s: the same-shard check after joining
local LEAVE_AFTER = 2      -- s: leaving the hop group after the refresh
local JOIN_DELAY = 10      -- s after login: the game's own channels join first
local JOIN_SETTLE = 3      -- s: the chat windows drop the channel again once the join went through
local LOG_SIZE = 10        -- messages /polestar layer debug shows

local enabled, joined, prefixed, filtered = false, false, false, false
local gen = 0              -- bumped on disable: timers from before return
local current              -- { map, id, at }
local known = {}           -- map -> id -> { seenAt, peers = { name = at }, hosts = { name = at } }
local transfer, evictAt = "none", nil -- none | offered | refreshing | done
local asked                -- a hop this module asked for: { want, at, map, line, msg, channel, reach, queue, seen, stopped }
local hopGroup, joinedFrom = false, nil
local groupGen = 0         -- bumped on every group join and departure: timers armed in another group return
local hostClaims, invited, hosting, answered = {}, {}, {}, {}
local lastFrom, fromCount = {}, 0
local lastAsk = nil
local heard = {}
local autoTimer, doneTimer
local whoFrame, whoOut, whoAt = nil, nil, nil -- the /who: our frame, the query out, when the last went
local muted = {}           -- frames whose WHO_LIST_UPDATE waits until our /who is answered

local function now() return GetTime() end
local function changed() ns.Fire("LAYER_CHANGED") end
local function cancel(t)
	if t then t:Cancel() end
	return nil
end

local function inCombat()
	return UnitAffectingCombat and readable(UnitAffectingCombat("player")) and true or false
end

-- A name as this realm writes it ("Name", or "Name-Realm" for another
-- realm), or nil.
local function short(name)
	name = readable(name)
	if type(name) ~= "string" or name == "" then return nil end
	local s = Ambiguate and readable(Ambiguate(name, "none")) or name
	return type(s) == "string" and s ~= "" and s or nil
end

-- Whether a sender is someone else on this realm (Nav/Transit.lua's rule).
local function fromThisRealm(sender)
	if type(sender) ~= "string" or sender == "" then return false end
	if ns.Compat.SenderIsMe(sender) then return false end
	local name = Ambiguate and Ambiguate(sender, "none") or sender
	local realm = name:match("%-(.+)$")
	if not realm then return true end
	local mine = GetNormalizedRealmName and GetNormalizedRealmName()
	return type(mine) == "string" and realm == mine
end

---------------------------------------------------------------------------
-- Layer identity
---------------------------------------------------------------------------

local function guidFields(guid)
	local out = {}
	for part in (guid .. "-"):gmatch("([^%-]*)%-") do out[#out + 1] = part end
	return out
end

-- The layer id (digits, as a string) a creature or vehicle GUID carries; nil
-- for players, pets, objects and anything unreadable.
function Layer.IdFromGUID(guid)
	guid = readable(guid)
	if type(guid) ~= "string" then return nil end
	local kind = guid:match("^(%a+)%-")
	if kind ~= "Creature" and kind ~= "Vehicle" then return nil end
	local id = guidFields(guid)[LAYER_FIELD]
	return id and id:match("^%d+$") and id or nil
end

local function playerMap()
	local m = C_Map and C_Map.GetBestMapForUnit and readable(C_Map.GetBestMapForUnit("player"))
	return type(m) == "number" and m or nil
end

local function layerOf(map, id)
	local m = known[map]
	if not m then
		m = {}
		known[map] = m
	end
	local e = m[id]
	if not e then
		e = { seenAt = now(), peers = {}, hosts = {} }
		m[id] = e
	end
	return e
end

-- A peer is on one layer of a map at a time.
local function notePeer(map, id, name, host)
	local m = known[map]
	if m then
		for _, e in pairs(m) do e.peers[name], e.hosts[name] = nil, nil end
	end
	local t = now()
	local e = layerOf(map, id)
	e.seenAt, e.peers[name] = t, t
	if host then e.hosts[name] = t end
end

local function byId(a, b)
	local x, y = tonumber(a.id), tonumber(b.id)
	if x ~= y then return x < y end
	return a.id < b.id
end

-- The layers seen on `map` this session, in numeric id order:
-- { id, n, peers, hosts, mine }, n the 1-based position (the label's number).
function Layer.Known(map)
	map = map or (current and current.map) or playerMap()
	local list = {}
	local m = map and known[map]
	if not m then return list end
	local t = now()
	for id, e in pairs(m) do
		local peers, hosts = 0, 0
		for name, at in pairs(e.peers) do
			if t - at > PEER_AGE then e.peers[name] = nil else peers = peers + 1 end
		end
		for name, at in pairs(e.hosts) do
			if t - at > PEER_AGE then e.hosts[name] = nil else hosts = hosts + 1 end
		end
		list[#list + 1] = { id = id, peers = peers, hosts = hosts,
			mine = current ~= nil and current.map == map and current.id == id }
	end
	sort(list, byId)
	for i = 1, #list do list[i].n = i end
	return list
end

function Layer.Label(map, id)
	if not map or not id then return nil end
	for _, row in ipairs(Layer.Known(map)) do
		if row.id == id then return format(L["Layer %d"], row.n) end
	end
	return nil
end

-- mapID, layer id; nil while the layer is unknown.
function Layer.Current()
	if not current then return nil end
	return current.map, current.id
end

---------------------------------------------------------------------------
-- The channel and the whispers
---------------------------------------------------------------------------

local function lockdown()
	local C = C_ChatInfo
	return C and C.InChatMessagingLockdown and readable(C.InChatMessagingLockdown()) and true or false
end

local function channelIndex()
	local index = GetChannelName and readable((GetChannelName(CHANNEL)))
	return type(index) == "number" and index > 0 and index or nil
end

-- The channel out of every chat window (its lines are filtered as well).
local function hideChannel()
	for i = 1, 10 do
		local f = _G["ChatFrame" .. i]
		if type(f) == "table" and type(f.RemoveChannel) == "function" then pcall(f.RemoveChannel, f, CHANNEL) end
	end
end

local function join()
	if not enabled then return end
	joined = true
	if JoinChannelByName then pcall(JoinChannelByName, CHANNEL) end
	hideChannel()
	local g = gen
	ns.After(JOIN_SETTLE, function()
		if g == gen then hideChannel() end
	end)
end

-- The chat windows' filter: true (hidden) for a PLH line on our channel
-- (arg 9, the channel's base name).
local function lineFilter(_, _, text, _, _, _, _, _, _, _, base)
	text, base = readable(text), readable(base)
	return type(base) == "string" and base:lower() == CHANNEL:lower() and type(text) == "string"
		and text:sub(1, #LINE) == LINE
end

local function setFilter(on)
	if on == filtered then return end
	filtered = on
	local U = ChatFrameUtil
	local add, drop = ChatFrame_AddMessageEventFilter, ChatFrame_RemoveMessageEventFilter
	if type(U) == "table" and U.AddMessageEventFilter and U.RemoveMessageEventFilter then
		add, drop = U.AddMessageEventFilter, U.RemoveMessageEventFilter
	end
	local fn = on and add or drop
	if fn then pcall(fn, "CHAT_MSG_CHANNEL", lineFilter) end
end

-- A pcall'd SendAddonMessage that the client took (Quests/Party.lua's rule).
local function went(ok, r)
	if not ok or r == false then return false end
	local results = Enum and Enum.SendAddonMessageResult
	return type(r) ~= "number" or r == (results and results.Success or 0)
end

-- An addon whisper: whether the client took it, and its result code. Never
-- during a chat lockdown.
local function whisper(name, msg)
	local fn = C_ChatInfo and C_ChatInfo.SendAddonMessage
	if not enabled or not fn or type(name) ~= "string" or name == "" or lockdown() then return false end
	local ok, r = pcall(fn, PREFIX, msg, "WHISPER", name)
	if ok then r = readable(r) else r = nil end
	return went(ok, r), r
end

-- A plain line on the channel: whether the client took the call. The live
-- realms drop channel text an addon sends outside a hardware event, so this
-- runs only inside Layer.Request and Layer.Ask, synchronously: never from a
-- timer (ns.After) or an event handler.
local function sendLine(text)
	local index = channelIndex()
	if not enabled or not index or not SendChatMessage or lockdown() then return false end
	return (pcall(SendChatMessage, text, "CHANNEL", nil, index))
end

-- PLH1 Q: the window's Refresh list; the answers come back as 1H whispers.
-- Only from a click or the typed command: the line goes out synchronously,
-- inside that hardware event (sendLine).
function Layer.Ask()
	if not enabled then return false, L["Layer hop is off."] end
	local t = now()
	if lastAsk and t - lastAsk < ASK_EVERY then return false, L["Asked a moment ago."] end
	local map = current and current.map or playerMap()
	if not map then return false, L["Your map is unknown."] end
	if not channelIndex() then join() end
	if not sendLine(format("%s%s Q %d", LINE, VERSION, map)) then
		if not channelIndex() then return false, L["Joining the layer channel; try again in a moment."] end
		return false, L["The message could not be sent."]
	end
	lastAsk = t
	return true
end

---------------------------------------------------------------------------
-- Sampling
---------------------------------------------------------------------------

local function sample(unit, quiet)
	if not enabled or type(unit) ~= "string" then return end
	local id = Layer.IdFromGUID(UnitGUID and UnitGUID(unit))
	local map = id and playerMap()
	if not map then return end
	local t = now()
	layerOf(map, id).seenAt = t
	local was = current
	current = { map = map, id = id, at = t }
	if quiet or (was and was.map == map and was.id == id) then return end
	changed()
end

local function resample()
	sample("target", true)
	sample("mouseover", true)
	local plates = C_NamePlate and C_NamePlate.GetNamePlates and C_NamePlate.GetNamePlates()
	if type(plates) ~= "table" then return end
	for _, plate in ipairs(plates) do
		local unit = type(plate) == "table" and readable(plate.namePlateUnitToken)
		if unit then sample(unit, true) end
	end
end

---------------------------------------------------------------------------
-- The hop group
---------------------------------------------------------------------------

local function inHopGroup()
	if hopGroup and not (IsInGroup and IsInGroup()) then hopGroup = false end
	return hopGroup
end

-- The waiting request, or nil. It lives PENDING seconds on the map it was
-- made on (kept while the map is unknown); a stale one is dropped here. In
-- the hop group it was answered: it lives until the refresh or the leave.
local function requestLive()
	if not asked then return nil end
	if inHopGroup() then return asked end
	local map = playerMap()
	if (not map or map == asked.map) and now() - asked.at <= PENDING then return asked end
	asked, joinedFrom = nil, nil
	changed()
	return nil
end

-- A zone change or a loading screen: the layer is unknown again, and a
-- request made on another map ends.
local function forget()
	requestLive()
	if not current then return end
	current = nil
	changed()
end

-- Leaves a group joined for a hop; never another group.
function Layer.LeaveGroup()
	if not inHopGroup() then return false, L["Not in a group joined for a layer hop."] end
	hopGroup, asked = false, nil
	if C_PartyInfo and C_PartyInfo.LeaveParty then C_PartyInfo.LeaveParty() end
	changed()
	return true
end

---------------------------------------------------------------------------
-- The world refresh
---------------------------------------------------------------------------

local function evictionLeft()
	local s = GetEvictionTimeRemaining and readable(GetEvictionTimeRemaining())
	return type(s) == "number" and s > 0 and s or nil
end

local function secondsLeft()
	if transfer ~= "offered" or not evictAt then return nil end
	local s = evictAt - now()
	return s > 0 and s or 0
end

-- Blizzard's own refresh dialog as the fallback; never with the gamepad
-- interface (ns.GamepadUI), whose focus owns the game's dialogs.
local function showDialog()
	if StaticPopup_Show and not ns.GamepadUI() then StaticPopup_Show("SHARD_TRANSFER_IMMEDIATE") end
end

-- Takes the offered refresh now: true, or false and why not. When the
-- confirm errors or no SHARD_TRANSFER follows, Blizzard's own dialog asks the
-- player to click (the call may be protected).
function Layer.RefreshNow()
	if not enabled or transfer ~= "offered" then return false, L["No world refresh is offered."] end
	if inCombat() then return false, L["You are in combat."] end
	transfer = "refreshing"
	changed()
	local fn = C_PlayerInteractionManager and C_PlayerInteractionManager.ShardTransferConfirm
	local ok = fn and pcall(fn)
	if not ok then
		if transfer == "refreshing" then
			transfer = "offered"
			changed()
		end
		showDialog()
		return true
	end
	-- The dialog belongs to the group the offer came with: a group left or
	-- joined in the meantime (groupGen) leaves the state to the game's
	-- SHARD_TRANSFER or SHARD_TRANSFER_CANCELLED.
	local g, gg = gen, groupGen
	ns.After(CONFIRM_WAIT, function()
		if g ~= gen or gg ~= groupGen or transfer ~= "refreshing" then return end
		transfer = "offered"
		changed()
		showDialog()
	end)
	return true
end

local function stopAuto() autoTimer = cancel(autoTimer) end

-- Only for a hop this module asked for, in the group it joined for it: after
-- layerRefreshDelay seconds, RefreshNow each second until it goes out or
-- AUTO_FOR seconds pass.
local function startAuto()
	if autoTimer or not inHopGroup() or not requestLive() or not QoL.On("layerAutoRefresh") then return end
	local delay = tonumber(ns.Get("qol.layerRefreshDelay")) or 5
	if delay < 0 then delay = 0 elseif delay > 60 then delay = 60 end
	local giveUp = now() + delay + AUTO_FOR
	local function try()
		autoTimer = nil
		if not enabled or not asked or not inHopGroup() or transfer ~= "offered" or not QoL.On("layerAutoRefresh") then return end
		if Layer.RefreshNow() or now() >= giveUp then return end
		autoTimer = ns.NewTimer(1, try)
	end
	autoTimer = ns.NewTimer(delay, try)
end

local function onImminent()
	local s = evictionLeft()
	transfer, evictAt = "offered", s and now() + s or nil
	changed()
	startAuto()
end

local function onTransfer()
	stopAuto()
	transfer, evictAt, asked, current = "done", nil, nil, nil
	changed()
	if QoL.On("layerLeaveAfter") and inHopGroup() then
		local g, gg = gen, groupGen
		ns.After(LEAVE_AFTER, function()
			if g == gen and gg == groupGen then Layer.LeaveGroup() end
		end)
	end
	doneTimer = cancel(doneTimer)
	doneTimer = ns.NewTimer(DONE_HOLD, function()
		doneTimer = nil
		if transfer ~= "done" then return end
		transfer = "none"
		changed()
	end)
end

local function onCancelled()
	stopAuto()
	if transfer == "none" then return end
	transfer, evictAt = "none", nil
	changed()
end

---------------------------------------------------------------------------
-- Requesting
---------------------------------------------------------------------------

local function throttled(r)
	local results = Enum and Enum.SendAddonMessageResult
	return r ~= nil and r == (results and results.AddonMessageThrottle or 3)
end

-- One burst of the request's whispers, WHISPER_BURST at most, the next a
-- second later: a name the client throttled ends the burst and goes first in
-- the next; any other refusal drops it. Ends with the request (a cancel, the
-- expiry, a map change, the disable) or a group join.
local function pump(a)
	a.timer = nil
	if not enabled or a.stopped or requestLive() ~= a then return end
	a.pumpAt = now()
	local n, reach = 0, a.reach
	while a.queue[1] and n < WHISPER_BURST do
		local ok, r = whisper(a.queue[1], a.msg)
		if throttled(r) then break end
		remove(a.queue, 1)
		n = n + 1
		if ok then a.reach = a.reach + 1 end
	end
	if a.reach ~= reach then changed() end
	if not a.queue[1] then return end
	a.timer = true
	local g = gen
	ns.After(1, function()
		if g == gen then pump(a) end
	end)
end

-- The next burst now, or a second after the last one.
local function burst(a)
	if a.timer or not a.queue[1] then return end
	local wait = a.pumpAt and a.pumpAt + 1 - now() or 0
	if wait <= 0 then return pump(a) end
	a.timer = true
	local g = gen
	ns.After(wait, function()
		if g == gen then pump(a) end
	end)
end

-- Whether one of the game's who lists is open (the social frame's on
-- retail-style clients, the group finder's on Forever): its answers stay
-- routed to it.
local function shown(f)
	return type(f) == "table" and f.IsShown and f:IsShown() and true or false
end

local function whoListShown()
	return shown(LFGWhoListFrame) or shown(WhoFrame)
end

-- Our /who is answered or given up: the frames that listen for its answer
-- get it again, ours no longer does, and the game's /who answers go back to
-- chat (SetWhoToUi) unless a who list is open.
local function release()
	local out = whoOut
	whoOut = nil
	if whoFrame then whoFrame:UnregisterEvent("WHO_LIST_UPDATE") end
	for f in pairs(muted) do
		pcall(f.RegisterEvent, f, "WHO_LIST_UPDATE")
		muted[f] = nil
	end
	if out and C_FriendList and C_FriendList.SetWhoToUi and not whoListShown() then
		pcall(C_FriendList.SetWhoToUi, false)
	end
end

local function mute(f)
	if f ~= whoFrame and f:IsEventRegistered("WHO_LIST_UPDATE") then
		f:UnregisterEvent("WHO_LIST_UPDATE")
		muted[f] = true
	end
end

-- The game's who lists open on any answer: every other frame listening for
-- it waits until ours has it.
local function hush()
	if not EnumerateFrames then return end
	local f = EnumerateFrames()
	while f do
		pcall(mute, f)
		f = EnumerateFrames(f)
	end
end

-- The /who answer: the zone's players, not the player, not a name already
-- whispered, WHO_MAX at most, join the whispers of the request live now
-- (which may have replaced the one that asked: cancelled and asked again
-- while the /who was out).
local function onWho()
	if not whoOut then return end
	release()
	local a = requestLive()
	if not enabled or not a or a.stopped then return end
	local F = C_FriendList
	local ok, n = pcall(F.GetNumWhoResults)
	n = ok and readable(n)
	local added = 0
	for i = 1, type(n) == "number" and n or 0 do
		if added >= WHO_MAX then break end
		local okI, info = pcall(F.GetWhoInfo, i)
		info = okI and readable(info)
		local name = type(info) == "table" and readable(info.fullName) or nil
		if type(name) == "string" and name ~= "" and not a.seen[name] and not ns.Compat.SenderIsMe(name) then
			a.seen[name] = true
			a.queue[#a.queue + 1] = name
			added = added + 1
		end
	end
	burst(a)
end

-- One /who of the zone for a request, at most every WHO_EVERY seconds;
-- skipped when the client lacks the calls or the zone is unreadable. Given up
-- after WHO_WAIT seconds.
local function askWho()
	local F = C_FriendList
	if type(F) ~= "table" or not (F.SendWho and F.SetWhoToUi and F.GetNumWhoResults and F.GetWhoInfo) then return end
	local t = now()
	if whoOut or (whoAt and t - whoAt < WHO_EVERY) then return end
	local zone = GetRealZoneText and readable(GetRealZoneText())
	if type(zone) ~= "string" or zone == "" then return end
	if not whoFrame then
		whoFrame = CreateFrame("Frame")
		whoFrame:SetScript("OnEvent", ns.Safe(onWho))
	end
	hush()
	whoFrame:RegisterEvent("WHO_LIST_UPDATE")
	pcall(F.SetWhoToUi, true)
	local w = {}
	whoOut = w
	local origin = Enum and Enum.SocialWhoOrigin and Enum.SocialWhoOrigin.Social or 1
	if not pcall(F.SendWho, 'z-"' .. zone .. '"', origin) then return release() end
	whoAt = t
	ns.After(WHO_WAIT, function()
		if whoOut == w then release() end
	end)
end

-- The hosts heard on `map` within PEER_AGE, in name order.
local function knownHosts(map)
	local out, t = {}, now()
	for _, e in pairs(known[map] or {}) do
		for name, at in pairs(e.hosts) do
			if t - at <= PEER_AGE then out[#out + 1] = name end
		end
	end
	sort(out)
	return out
end

-- The request's channel line, joining first while the channel's index is
-- unknown: true, or false and why.
local function lineOf(a)
	if not channelIndex() then join() end
	a.channel = sendLine(a.line)
	if a.channel then return true end
	if not channelIndex() then return false, L["Joining the layer channel; try again in a moment."] end
	return false, L["The message could not be sent."]
end

-- Asks the Polestar players on this map for a group invite onto layer
-- `want` (an id, or "*" for any other): true, or false and why not. A line
-- on the channel, then whispers to the hosts heard on the map and to the
-- zone's players one /who lists. Only from a click or the typed command: the
-- line goes out synchronously, inside that hardware event (sendLine); never
-- call this from a timer or an event handler. A request whose line could not
-- go out still whispers; the next click sends its line.
function Layer.Request(want)
	want = want == nil and "*" or tostring(want)
	if want ~= "*" and not want:match("^%d+$") then return false, L["Unknown layer."] end
	if not enabled then return false, L["Layer hop is off."] end
	if IsInGroup and IsInGroup() then return false, L["You are already in a group."] end
	if lockdown() then return false, L["Chat is locked down; try again shortly."] end
	local a = asked
	if a and now() - a.at < PENDING then
		if a.channel then return false, L["A hop request is already waiting."] end
		local ok, why = lineOf(a)
		changed()
		return ok, why
	end
	local map = current and current.map or playerMap()
	if not map then return false, L["Your map is unknown."] end
	local body = format("%d:%s:%s", map, current and current.id or "", want)
	a = { want = want, at = now(), map = map, line = format("%s%s R %s", LINE, VERSION, body),
		msg = VERSION .. "R" .. body, channel = false, reach = 0, queue = {}, seen = {} }
	asked, joinedFrom = a, nil
	local ok, why = lineOf(a)
	for _, name in ipairs(knownHosts(map)) do
		a.seen[name] = true
		a.queue[#a.queue + 1] = name
	end
	burst(a)
	askWho()
	local g = gen
	ns.After(PENDING, function()
		if g ~= gen or asked ~= a or inHopGroup() then return end
		asked = nil
		changed()
	end)
	changed()
	return ok, why
end

function Layer.CancelRequest()
	if not asked then return false, L["No hop request is waiting."] end
	asked, joinedFrom = nil, nil
	stopAuto()
	changed()
	return true
end

-- An invite this request waits for: from a host that claimed the player
-- since the request, or (fallback) a peer heard on the request's map.
local function expected(name)
	local a = requestLive()
	if not a or not name then return false end
	local at = hostClaims[name]
	if at and at >= a.at then return true end
	local m = known[a.map]
	if not m then return false end
	local t = now()
	for _, e in pairs(m) do
		local seen = e.peers[name]
		if seen and t - seen <= PEER_AGE then return true end
	end
	return false
end

-- Whether an invite from `name` is one a waiting request expects:
-- QoL/Social.lua then leaves it to this module.
function Layer.Expects(name)
	return enabled and expected(short(name)) or false
end

-- Any other invite is left to the player and QoL/Social.lua's own rules.
local function onPartyInvite(_, name)
	name = short(name)
	if not expected(name) or not QoL.Social.AcceptInvite() then return end
	joinedFrom = name
	ns.Print(format(L["Joined %s's group for a layer hop."], name))
end

-- Only a group joined through an invite this module accepted is the hop group.
local function onGroupJoined()
	groupGen = groupGen + 1
	if asked then asked.stopped = true end -- the request's whispers end with any group
	if not joinedFrom or not asked then return end
	joinedFrom, hopGroup = nil, true
	changed()
	local g, gg = gen, groupGen
	ns.After(AFTER_JOIN, function()
		if g ~= gen or gg ~= groupGen or not inHopGroup() or transfer ~= "none" then return end
		-- The same shard only when the player and the host are both on the
		-- party's shard; the host alone there means the player's refresh is coming.
		if not (UnitInPartyShard and readable(UnitInPartyShard("player"))
			and readable(UnitInPartyShard("party1"))) then return end
		asked = nil
		ns.Print(L["Same layer as the host; nothing to refresh."])
		changed()
		if QoL.On("layerLeaveAfter") then Layer.LeaveGroup() end
	end)
	-- An offer that came before the join waited for the hop group.
	if transfer == "offered" then startAuto() end
end

-- Leaving any group ends the hop group and the request (hopped or not, it
-- is over: a late claimed invite does not bring the player back without a
-- new click, and a request that outlived PENDING inside the hop group does
-- not stay waiting); timers armed in the group then return.
local function onGroupLeft()
	groupGen = groupGen + 1
	hopGroup, joinedFrom, asked = false, nil, nil
	stopAuto()
	changed()
end

---------------------------------------------------------------------------
-- Hosting
---------------------------------------------------------------------------

local function mayHost(name, map, from, want)
	if not QoL.On("layerHost") or not current or current.map ~= map then return false end
	if from == current.id then return false end
	if want ~= "*" and want ~= current.id then return false end
	if inCombat() then return false end
	local members = GetNumGroupMembers and readable(GetNumGroupMembers()) or 0
	if type(members) ~= "number" or members >= 5 then return false end
	if IsInGroup and IsInGroup() and not (UnitIsGroupLeader and readable(UnitIsGroupLeader("player"))) then
		return false
	end
	local t = now()
	if invited[name] and t - invited[name] < INVITE_AGAIN then return false end
	return true
end

-- A random wait first; then the claim, whispered to the asker, and the invite
-- (it goes even when the whisper was refused). Hosts no longer hear each
-- other's claims: the asker takes the first invite, a second one fails.
local function onRequest(name, map, from, want)
	if hosting[name] or not mayHost(name, map, from, want) then return end
	hosting[name] = true
	local g = gen
	ns.After(0.5 + random() * 2, function()
		hosting[name] = nil
		if g ~= gen or not mayHost(name, map, from, want) then return end
		invited[name] = now()
		whisper(name, VERSION .. "I" .. name)
		if C_PartyInfo and C_PartyInfo.InviteUnit then C_PartyInfo.InviteUnit(name) end
	end)
end

---------------------------------------------------------------------------
-- Receiving
---------------------------------------------------------------------------

local function remember(name, message)
	heard[#heard + 1] = { at = now(), sender = name, message = message }
	if #heard > LOG_SIZE then remove(heard, 1) end
end

-- A repeat of the last text a sender's counted message carried within FLOOD
-- seconds is dropped and not counted. Past that, at most BURST messages per
-- sender per FLOOD seconds, channel lines and whispers together (a
-- requester's Q then R, a host's H then I):
-- lastFrom[name] = { at = the window's start, n, text, textAt }.
local function flooding(name, t, message)
	local last = lastFrom[name]
	if last and last.text == message and t - last.textAt < FLOOD then return true end
	if last and t - last.at < FLOOD then
		if last.n >= BURST then return true end
		last.n, last.text, last.textAt = last.n + 1, message, t
		return false
	end
	if not last then fromCount = fromCount + 1 end
	lastFrom[name] = { at = t, n = 1, text = message, textAt = t }
	if fromCount > 200 then
		for who, e in pairs(lastFrom) do
			if t - e.textAt >= FLOOD then
				lastFrom[who] = nil
				fromCount = fromCount - 1
			end
		end
	end
	return false
end

-- The sender's name when a message may be read: someone else on this realm,
-- not oversize, not flooding. Kept for /polestar layer debug.
local function accept(sender, message)
	if type(message) ~= "string" or #message > MAX_BYTES or not fromThisRealm(sender) then return nil end
	local name = short(sender)
	if not name or flooding(name, now(), message) then return nil end
	remember(name, message)
	return name
end

local function request(name, body)
	local map, from, want = body:match("^(%d+):(%d*):([%d%*]+)$")
	if not map or (want ~= "*" and not want:match("^%d+$")) then return end
	onRequest(name, tonumber(map), from, want)
end

-- A Q: the 1H answer whispered to the asker after a random wait, once per
-- asker in ASK_EVERY seconds.
local function answer(name, body)
	local map = tonumber(body:match("^(%d+)$") or "")
	if not map or not current or current.map ~= map then return end
	local t = now()
	if answered[name] and t - answered[name] < ASK_EVERY then return end
	for who, at in pairs(answered) do
		if t - at >= ASK_EVERY then answered[who] = nil end
	end
	answered[name] = t
	local g = gen
	ns.After(0.5 + random() * 2, function()
		if g ~= gen or not current or current.map ~= map then return end
		whisper(name, format("%sH%d:%s:%d", VERSION, map, current.id, QoL.On("layerHost") and 1 or 0))
	end)
end

-- A line on the channel (arg 9 its base name): R and Q.
local function onChannel(_, text, sender, _, _, _, _, _, _, base)
	if not enabled then return end
	base, text = readable(base), readable(text)
	if type(base) ~= "string" or base:lower() ~= CHANNEL:lower() then return end
	local name = accept(readable(sender), text)
	if not name then return end
	local version, kind, body = text:match("^" .. LINE .. "(%d+) (%u) (.*)$")
	if version ~= VERSION then return end
	if kind == "R" then
		request(name, body)
	elseif kind == "Q" then
		answer(name, body)
	end
end

-- An addon whisper: H, R, I and Q. Any other chat type is not ours.
local function onAddonMessage(_, prefix, message, chatType, sender)
	if not enabled or readable(prefix) ~= PREFIX or readable(chatType) ~= "WHISPER" then return end
	message = readable(message)
	local name = accept(readable(sender), message)
	if not name then return end
	local version, kind, body = message:match("^(%d+)(%u)(.*)$")
	if version ~= VERSION then return end
	if kind == "H" then
		local map, id, host = body:match("^(%d+):(%d+):([01])$")
		if not map then return end
		notePeer(tonumber(map), id, name, host == "1")
		changed()
	elseif kind == "R" then
		request(name, body)
	elseif kind == "Q" then
		answer(name, body)
	elseif kind == "I" then
		local target = body:match("^([^:]+)$")
		if target and ns.Compat.SenderIsMe(target) then hostClaims[name] = now() end
	end
end

---------------------------------------------------------------------------
-- State, debug
---------------------------------------------------------------------------

-- A plain table for the window and /polestar layer status.
function Layer.Status()
	local map = current and current.map or playerMap()
	local id = current and current.id or nil
	return {
		on = enabled, map = map, id = id, label = id and Layer.Label(map, id) or nil,
		transfer = transfer, secondsLeft = secondsLeft(),
		asked = asked and { want = asked.want, at = asked.at, reach = asked.reach, channel = asked.channel } or nil,
		hopGroup = inHopGroup(), host = QoL.On("layerHost"),
		peers = map and Layer.Known(map) or {},
	}
end

local function escaped(s) return (tostring(s):gsub("|", "||")) end

-- The GUID fields of target and mouseover, the state and the last messages.
function Layer.Debug()
	for _, unit in ipairs({ "target", "mouseover" }) do
		local guid = readable(UnitGUID and UnitGUID(unit))
		local text = "-"
		if type(guid) == "string" then
			local parts = guidFields(guid)
			for i = 1, #parts do parts[i] = i .. "=" .. parts[i] end
			text = concat(parts, " ")
		end
		ns.Print(format("layer %s: %s", unit, escaped(text)))
	end
	local s = Layer.Status()
	ns.Print(format("layer: on=%s field=%d map=%s id=%s transfer=%s left=%s asked=%s hopGroup=%s host=%s channel=%s",
		tostring(s.on), LAYER_FIELD, tostring(s.map), tostring(s.id), s.transfer,
		tostring(s.secondsLeft and floor(s.secondsLeft)), tostring(s.asked and s.asked.want),
		tostring(s.hopGroup), tostring(s.host), tostring(channelIndex())))
	local t = now()
	for i = 1, #heard do
		local h = heard[i]
		ns.Print(format("layer heard %ds ago %s: %s", floor(t - h.at), escaped(h.sender), escaped(h.message)))
	end
end

---------------------------------------------------------------------------
-- On and off
---------------------------------------------------------------------------

local function onEnteringWorld()
	forget()
	if joined then return end
	local g = gen
	ns.After(JOIN_DELAY, function()
		if g ~= gen or joined then return end
		join()
	end)
end

local function enable()
	if enabled then return end
	enabled = true
	if not prefixed and C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
		prefixed = pcall(C_ChatInfo.RegisterAddonMessagePrefix, PREFIX) and true or false
	end
	setFilter(true)
	-- A refresh may already be scheduled; shown, never auto-confirmed.
	local s = evictionLeft()
	if s then transfer, evictAt = "offered", now() + s end
	if ns.IsLoggedIn() then join() end
	resample()
	changed()
end

local function disable()
	if not enabled then return end
	enabled = false
	gen = gen + 1
	if joined and LeaveChannelByName then pcall(LeaveChannelByName, CHANNEL) end
	joined = false
	setFilter(false)
	release()
	stopAuto()
	doneTimer = cancel(doneTimer)
	current, asked, joinedFrom, hopGroup = nil, nil, nil, false
	transfer, evictAt = "none", nil
	known, hostClaims, invited, hosting, answered, heard = {}, {}, {}, {}, {}, {}
	lastFrom, fromCount = {}, 0
	lastAsk = nil
	changed()
end

local function sync()
	if QoL.On("layerHop") then enable() else disable() end
end

local ON = "layerHop"
QoL.WhileOn(ON, "PLAYER_TARGET_CHANGED", function() sample("target") end)
QoL.WhileOn(ON, "UPDATE_MOUSEOVER_UNIT", function() sample("mouseover") end)
QoL.WhileOn(ON, "NAME_PLATE_UNIT_ADDED", function(_, unit) sample(readable(unit)) end)
QoL.WhileOn(ON, "PLAYER_ENTERING_WORLD", onEnteringWorld)
QoL.WhileOn(ON, "ZONE_CHANGED_NEW_AREA", forget)
QoL.WhileOn(ON, "SHARD_TRANSFER_IMMINENT", onImminent)
QoL.WhileOn(ON, "SHARD_TRANSFER", onTransfer)
QoL.WhileOn(ON, "SHARD_TRANSFER_CANCELLED", onCancelled)
QoL.WhileOn(ON, "CHAT_MSG_ADDON", onAddonMessage)
QoL.WhileOn(ON, "CHAT_MSG_CHANNEL", onChannel)
QoL.WhileOn(ON, "PARTY_INVITE_REQUEST", onPartyInvite)
QoL.WhileOn(ON, "GROUP_JOINED", onGroupJoined)
QoL.WhileOn(ON, "GROUP_LEFT", onGroupLeft)

local initialized = false
ns.OnInit(function()
	initialized = true
	sync()
end)

ns.On("SETTING_CHANGED", function(path)
	if not initialized then return end
	local all = path == "" or path == "qol"
	if all or path == "qol.layerHop" then sync() end
	if not enabled then return end
	if (all or path == "qol.layerAutoRefresh") and not QoL.On("layerAutoRefresh") then stopAuto() end
end)

---------------------------------------------------------------------------
-- /polestar layer [hop | now | leave | status | debug]
---------------------------------------------------------------------------

local function mmss(s)
	s = floor(s + 0.5)
	return format("%d:%02d", floor(s / 60), s % 60)
end

local function printStatus()
	local s = Layer.Status()
	ns.Print(s.label and format(L["You are on %s."], s.label) or L["Layer unknown: target or mouse over a creature."])
	if s.transfer == "offered" then
		ns.Print(format(L["World refresh in %s"], s.secondsLeft and mmss(s.secondsLeft) or "?"))
	end
	for _, row in ipairs(s.peers) do
		ns.Print(format(L["Layer %d: %d peers, %d hosts"], row.n, row.peers, row.hosts))
	end
end

ns.RegisterCommand("layer", function(rest)
	local word = (rest or ""):lower():match("^(%S*)")
	if word == "debug" then return Layer.Debug() end
	if not enabled then
		ns.Print(L["Layer hop is off: turn it on in the options, Quality of Life, Layers."])
		return
	end
	local ok, why = true, nil
	if word == "" then
		ns.Fire("TOGGLE_LAYER_HOP")
	elseif word == "hop" then
		ok, why = Layer.Request("*")
		if ok then ns.Print(L["Asked for a layer hop."]) end
	elseif word == "now" then
		ok, why = Layer.RefreshNow()
	elseif word == "leave" then
		ok, why = Layer.LeaveGroup()
	elseif word == "status" then
		printStatus()
	else
		why = L["Usage: /polestar layer [hop | now | leave | status | debug]"]
	end
	if why then ns.Print(why) end
end, L["the layer hop window; hop, now, leave, status, debug"])
