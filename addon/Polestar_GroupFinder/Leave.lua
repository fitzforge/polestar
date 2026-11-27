-- Polestar Group Finder: the group formed through the finder, from hello
-- to goodbye.
--
-- A group counts as formed through the finder when you invited a player it
-- found (the Invite button, or auto-group) or accepted the invitation of a
-- player it had found. The quest ids you shared at that moment (and that are
-- in your log) are remembered, per character, until the group ends.
--   * When such a player joins, "GROUP_FORMED" fires: the party box
--     (UI/PartyBox.lua) offers to say hello.
--   * When none of the remembered quests has anything left to do
--     (objectives complete, ready to hand in, or handed in), "GROUP_DONE"
--     fires: the party box offers to say goodbye and leave, for a while.
--
-- Nothing here leaves by itself. The goodbye message is said just before
-- leaving a group formed through the finder, from Leave.Do: the party box's
-- Say goodbye, the panel's Leave button, the key binding. Leaving through
-- the game (portrait menu, /leave) says nothing: wrapping the game's
-- LeaveParty would taint it. A group joined by hand gets no message.

local _, ns = ...
local L = ns.L

local Leave = {}
ns.Leave = Leave

local WINDOW = 300       -- seconds an invitation stays linked to the group it makes
local READY_AFTER = 8    -- seconds after login before the log counts as read
local CHECK_DELAY = 1.5  -- seconds after the last log update before checking
local outgoing = {}      -- key -> { name, quests, at }
local incoming           -- { name, quests, at }
local ready = false
local token = 0
local waitingCombat = false

local key = ns.NameKey

local function inGroup()
	return ns.InGroup()
end

local function memory()
	return ns.Char().party
end

local function inParty(name)
	local ok, r = pcall(function() return ns.Matcher.InGroup(name) end)
	return ok and r
end

-- The goodbye text (Messages.lua).
function Leave.Message()
	return ns.Messages.Expand("goodbye", Leave.Quests())
end

-- The quest ids the current finder group was formed for, sorted.
function Leave.Quests()
	local mem = memory()
	local out = {}
	for id in pairs(mem and mem.quests or {}) do out[#out + 1] = id end
	table.sort(out)
	return out
end

function Leave.Active() return memory() ~= nil end

-- Remembers `ids` (the ones in the log) as the reason for the current group.
local function merge(ids)
	local mem = ns.Char().party
	local added = false
	for _, id in ipairs(ids or {}) do
		if ns.Quests.Has(id) then
			mem = mem or { quests = {} }
			mem.quests[id] = true
			added = true
		end
	end
	if added then
		mem.dismissed, mem.offered = nil, nil
		mem.at = mem.at or time()
		ns.Char().party = mem
		ns.Fire("LEAVE_MEMORY")
	end
	return added
end

-- A player was invited from the finder (Invite button or auto-group).
function Leave.NoteInvite(name, quests)
	if type(name) ~= "string" or not quests then return end
	local ids = {}
	for _, id in ipairs(quests) do ids[#ids + 1] = type(id) == "table" and id.id or id end
	outgoing[key(name)] = { name = name, quests = ids, at = ns.Now() }
end

function Leave.Forget()
	ns.Char().party = nil
	wipe(outgoing)
	incoming = nil
	ns.Fire("LEAVE_MEMORY")
end

local function resolve()
	local now = ns.Now()
	for k, o in pairs(outgoing) do
		if now - o.at > WINDOW then
			outgoing[k] = nil
		elseif inParty(o.name) then
			outgoing[k] = nil
			if merge(o.quests) then ns.Fire("GROUP_FORMED", o.name) end
		end
	end
	if incoming then
		if now - incoming.at > WINDOW then
			incoming = nil
		elseif inParty(incoming.name) then
			local ids, name = incoming.quests, incoming.name
			incoming = nil
			if merge(ids) then ns.Fire("GROUP_FORMED", name) end
		end
	end
end

local function onInvite(_, inviter)
	inviter = ns.Readable(inviter)
	if type(inviter) ~= "string" or not ns.Get("enabled") then return end
	local ids = ns.Matcher.QuestsOf(inviter)
	if #ids == 0 then return end -- not a player the finder found
	incoming = { name = inviter, quests = ids, at = ns.Now() }
end
ns.RegisterEvent("PARTY_INVITE_REQUEST", onInvite)

-- Quests of the memory with nothing left to do; drops abandoned ones.
-- Returns true when there is a memory and every quest in it is done.
function Leave.AllDone()
	local mem = memory()
	if not (mem and mem.quests) then return false end
	local any, open = false, false
	for id in pairs(mem.quests) do
		local state = ns.Quests.State(id)
		if state == "gone" then
			mem.quests[id] = nil
		else
			any = true
			if state == "open" then open = true end
		end
	end
	if not any then
		ns.Char().party = nil
		return false
	end
	return not open
end

function Leave.Check()
	local mem = memory()
	if not mem then return end
	if not inGroup() then
		Leave.Forget()
		return
	end
	if not ready or not (ns.Get("enabled") and ns.Get("partyBox")) then return end
	if mem.dismissed or mem.offered then return end
	if IsInInstance and IsInInstance() then return end
	if not Leave.AllDone() then return end
	if InCombatLockdown and InCombatLockdown() then
		waitingCombat = true
		return
	end
	mem.offered = true
	ns.Fire("GROUP_DONE")
end

local function schedule()
	token = token + 1
	local mine = token
	ns.After(CHECK_DELAY, function() if mine == token then Leave.Check() end end)
end

ns.RegisterEvent("GROUP_ROSTER_UPDATE", function()
	resolve()
	if not inGroup() and memory() then Leave.Forget() return end
	schedule()
end)
for _, ev in ipairs({ "QUEST_LOG_UPDATE", "QUEST_TURNED_IN", "QUEST_REMOVED", "ZONE_CHANGED_NEW_AREA" }) do
	ns.RegisterEvent(ev, function() if memory() then schedule() end end)
end
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if waitingCombat then waitingCombat = false schedule() end
end)
ns.On("LOGIN", function() ns.After(READY_AFTER, function() ready = true schedule() end) end)

-- Would leaving say goodbye? A finder group, with the message on.
function Leave.Speaks()
	return memory() ~= nil and ns.Messages.On("goodbye")
end

-- The goodbye message in the party, for a group formed through the finder.
function Leave.Announce()
	if not memory() then return false end
	return ns.Messages.SayParty("goodbye", Leave.Quests())
end

-- Leave the group: the goodbye message first (unless `quiet`), then the party.
function Leave.Do(quiet)
	if not inGroup() then return end
	if not quiet then Leave.Announce() end
	ns.LeaveParty()
	Leave.Forget()
	ns.Debug(L["You left the group."])
end

-- Not now: goodbye is not offered again for this group.
function Leave.Stay()
	local mem = memory()
	if mem then mem.dismissed = true end
end

Leave.IsReady = function() return ready end
-- Tests: skip the post-login wait.

