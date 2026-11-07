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
-- Players find each other with addon messages, prefix PolestarLayer, in the
-- guild and on the hidden custom channel PolestarLayer, never in party, raid
-- or instance chat. Protocol version 1, fields ":"-separated:
--   1H<map>:<layer>:<host 0|1>   presence
--   1Q<map>                      ask for presence
--   1R<map>:<layer>:<want>       a hop request (want: a layer id or *)
--   1I<name>                     a host's claim: it is inviting <name>
--
-- While the opt-in is off nothing is registered, joined or sent: every game
-- event goes through QoL.WhileOn, the channel is joined on enable and left on
-- disable. Every change fires LAYER_CHANGED (the window, UI/LayerHop.lua).
-- Client: SHARD_TRANSFER_IMMINENT, SHARD_TRANSFER, SHARD_TRANSFER_CANCELLED,
-- GetEvictionTimeRemaining, C_PlayerInteractionManager.ShardTransferConfirm,
-- UnitInPartyShard, JoinChannelByName, LeaveChannelByName, GetChannelName,
-- C_ChatInfo.SendAddonMessage, RegisterAddonMessagePrefix and
-- InChatMessagingLockdown, C_PartyInfo.InviteUnit and LeaveParty,
-- C_NamePlate.GetNamePlates (Forever's API documentation); the
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
local LAYER_FIELD = 5           -- the GUID field read as the layer id
Layer.PREFIX, Layer.CHANNEL, Layer.LAYER_FIELD = PREFIX, CHANNEL, LAYER_FIELD

local MAX_BYTES = 120      -- longer messages are dropped
local FLOOD = 2            -- s: the window a sender's messages are counted in
local BURST = 4            -- messages per sender per FLOOD window; more are dropped
local PEER_AGE = 600       -- s: a peer not heard from this long is dropped
local PRESENCE_EVERY = 30  -- s: presence on a change at most this often
local ASK_EVERY = 60       -- s: Q at most this often
local CLAIM_HOLD = 30      -- s: hosts stand down for a name another host claimed
local INVITE_AGAIN = 300   -- s: a host invites one name once in this while
local PENDING = 120        -- s: a request waits this long for an invite
local DONE_HOLD = 10       -- s: "done" shows this long
local CONFIRM_WAIT = 3     -- s: no SHARD_TRANSFER after a confirm: Blizzard's dialog
local AUTO_FOR = 60        -- s: auto refresh retries this long
local AFTER_JOIN = 2       -- s: the same-shard check after joining
local LEAVE_AFTER = 2      -- s: leaving the hop group after the refresh
local JOIN_DELAY = 10      -- s after login: the game's own channels join first
local JOIN_SETTLE = 3      -- s: the channel's index once a join went through
local LOG_SIZE = 10        -- messages /polestar layer debug shows

local enabled, joined, prefixed = false, false, false
local gen = 0              -- bumped on disable: timers from before return
local current              -- { map, id, at }
local known = {}           -- map -> id -> { seenAt, peers = { name = at }, hosts = { name = at } }
local transfer, evictAt = "none", nil -- none | offered | refreshing | done
local asked                -- { want, at, map }: a hop this module asked for
local hopGroup, joinedFrom = false, nil
local groupGen = 0         -- bumped on every group join and departure: timers armed in another group return
local claims, hostClaims, invited, hosting = {}, {}, {}, {}
local lastFrom, fromCount = {}, 0
local lastPresence, lastPresenceKey, lastAsk = nil, nil, nil
local answering = false
local heard = {}
local autoTimer, presenceTimer, doneTimer

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
-- Addon messages
---------------------------------------------------------------------------

local function lockdown()
	local C = C_ChatInfo
	return C and C.InChatMessagingLockdown and readable(C.InChatMessagingLockdown()) and true or false
end

local function channelIndex()
	local index = GetChannelName and readable((GetChannelName(CHANNEL)))
	return type(index) == "number" and index > 0 and index or nil
end

-- A pcall'd SendAddonMessage that the client took (Quests/Party.lua's rule).
local function went(ok, r)
	if not ok or r == false then return false end
	local results = Enum and Enum.SendAddonMessageResult
	return type(r) ~= "number" or r == (results and results.Success or 0)
end

-- To the guild and the custom channel; never during a chat lockdown.
local function send(msg)
	local fn = C_ChatInfo and C_ChatInfo.SendAddonMessage
	if not enabled or not fn or lockdown() then return false end
	local sent = false
	if IsInGuild and IsInGuild() then sent = went(pcall(fn, PREFIX, msg, "GUILD")) or sent end
	local index = channelIndex()
	if index then sent = went(pcall(fn, PREFIX, msg, "CHANNEL", index)) or sent end
	return sent
end

-- 1H: forced on enable and in answer to Q; otherwise only when the map,
-- layer or host flag changed, at most every PRESENCE_EVERY seconds.
local function presence(force)
	if not enabled or not current then return end
	local t = now()
	local key = format("%d:%s:%d", current.map, current.id, QoL.On("layerHost") and 1 or 0)
	if not force then
		if key == lastPresenceKey then return end
		if lastPresence and t - lastPresence < PRESENCE_EVERY then
			if not presenceTimer then
				presenceTimer = ns.NewTimer(PRESENCE_EVERY - (t - lastPresence), function()
					presenceTimer = nil
					presence(false)
				end)
			end
			return
		end
	end
	if send(VERSION .. "H" .. key) then
		lastPresence, lastPresenceKey = t, key
		presenceTimer = cancel(presenceTimer)
	end
end

-- Presence now and, when the channel join has not gone through yet, again
-- once it has.
local function announce()
	presence(true)
	if channelIndex() then return end
	local g = gen
	ns.After(JOIN_SETTLE, function()
		if g == gen and channelIndex() then presence(true) end
	end)
end

-- 1Q: the window's Refresh list.
function Layer.Ask()
	if not enabled then return false, L["Layer hop is off."] end
	local t = now()
	if lastAsk and t - lastAsk < ASK_EVERY then return false, L["Asked a moment ago."] end
	local map = current and current.map or playerMap()
	if not map then return false, L["Your map is unknown."] end
	if not send(format("%sQ%d", VERSION, map)) then return false, L["The message could not be sent."] end
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
	presence(false)
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

local function showDialog()
	if StaticPopup_Show then StaticPopup_Show("SHARD_TRANSFER_IMMEDIATE") end
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
	local g = gen
	ns.After(CONFIRM_WAIT, function()
		if g ~= gen or transfer ~= "refreshing" then return end
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

-- Asks the Polestar players on this map for a group invite onto layer
-- `want` (an id, or "*" for any other): true, or false and why not.
function Layer.Request(want)
	want = want == nil and "*" or tostring(want)
	if want ~= "*" and not want:match("^%d+$") then return false, L["Unknown layer."] end
	if not enabled then return false, L["Layer hop is off."] end
	if IsInGroup and IsInGroup() then return false, L["You are already in a group."] end
	if lockdown() then return false, L["Chat is locked down; try again shortly."] end
	if asked and now() - asked.at < PENDING then return false, L["A hop request is already waiting."] end
	local map = current and current.map or playerMap()
	if not map then return false, L["Your map is unknown."] end
	local from = current and current.id or ""
	if not send(format("%sR%d:%s:%s", VERSION, map, from, want)) then
		return false, L["The message could not be sent."]
	end
	local a = { want = want, at = now(), map = map }
	asked, joinedFrom = a, nil
	local g = gen
	ns.After(PENDING, function()
		if g ~= gen or asked ~= a or inHopGroup() then return end
		asked = nil
		changed()
	end)
	changed()
	return true
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

-- Leaving any group ends the hop group; timers armed in it then return.
local function onGroupLeft()
	groupGen = groupGen + 1
	hopGroup, joinedFrom = false, nil
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
	if claims[name] and t - claims[name] < CLAIM_HOLD then return false end
	return true
end

-- A random wait first, so one host claims the name and the others stand down.
local function onRequest(name, map, from, want)
	if hosting[name] or not mayHost(name, map, from, want) then return end
	hosting[name] = true
	local g = gen
	ns.After(0.5 + random() * 2, function()
		hosting[name] = nil
		if g ~= gen or not mayHost(name, map, from, want) then return end
		if not send(VERSION .. "I" .. name) then return end
		invited[name] = now()
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

-- send() puts each message on GUILD and on the channel: a copy of the last
-- text a sender's counted message carried within FLOOD seconds is the same
-- message, dropped and not counted. Past that, at most BURST messages per
-- sender per FLOOD seconds (a requester's H, Q then R, a host's H then I):
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

local function onAddonMessage(_, prefix, message, _, sender)
	if not enabled or readable(prefix) ~= PREFIX then return end
	message, sender = readable(message), readable(sender)
	if type(message) ~= "string" or #message > MAX_BYTES or not fromThisRealm(sender) then return end
	local name = short(sender)
	local t = now()
	if not name or flooding(name, t, message) then return end
	remember(name, message)
	local version, kind, body = message:match("^(%d+)(%u)(.*)$")
	if version ~= VERSION then return end
	if kind == "H" then
		local map, id, host = body:match("^(%d+):(%d+):([01])$")
		if not map then return end
		notePeer(tonumber(map), id, name, host == "1")
		changed()
	elseif kind == "Q" then
		local map = tonumber(body:match("^(%d+)$") or "")
		if not map or not current or current.map ~= map or answering then return end
		answering = true
		local g = gen
		ns.After(0.5 + random() * 2.5, function()
			if g ~= gen then return end
			answering = false
			presence(true)
		end)
	elseif kind == "R" then
		local map, from, want = body:match("^(%d+):(%d*):([%d%*]+)$")
		if not map or (want ~= "*" and not want:match("^%d+$")) then return end
		onRequest(name, tonumber(map), from, want)
	elseif kind == "I" then
		local target = body:match("^([^:]+)$")
		if not target then return end
		claims[short(target) or target] = t
		if ns.Compat.SenderIsMe(target) then hostClaims[name] = t end
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
		asked = asked and { want = asked.want, at = asked.at } or nil,
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

local function join()
	if joined or not enabled then return end
	joined = true
	if JoinChannelByName then pcall(JoinChannelByName, CHANNEL) end
end

local function onEnteringWorld()
	forget()
	if joined then return end
	local g = gen
	ns.After(JOIN_DELAY, function()
		if g ~= gen or joined then return end
		join()
		announce()
	end)
end

local function enable()
	if enabled then return end
	enabled = true
	if not prefixed and C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
		prefixed = pcall(C_ChatInfo.RegisterAddonMessagePrefix, PREFIX) and true or false
	end
	-- A refresh may already be scheduled; shown, never auto-confirmed.
	local s = evictionLeft()
	if s then transfer, evictAt = "offered", now() + s end
	if ns.IsLoggedIn() then join() end
	resample()
	announce()
	changed()
end

local function disable()
	if not enabled then return end
	enabled = false
	gen = gen + 1
	if joined and LeaveChannelByName then pcall(LeaveChannelByName, CHANNEL) end
	joined = false
	stopAuto()
	presenceTimer, doneTimer = cancel(presenceTimer), cancel(doneTimer)
	current, asked, joinedFrom, hopGroup = nil, nil, nil, false
	transfer, evictAt, answering = "none", nil, false
	known, claims, hostClaims, invited, hosting, heard = {}, {}, {}, {}, {}, {}
	lastFrom, fromCount = {}, 0
	lastPresence, lastPresenceKey, lastAsk = nil, nil, nil
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
	if all or path == "qol.layerHost" then presence(false) end
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
