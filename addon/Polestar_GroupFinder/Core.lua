-- Polestar Group Finder: the module's own namespace over Polestar's.
--
-- This folder loads on demand (Data.Pack): at login while the finder is on
-- (groupFinder.enabled, off by default), or the first time the player turns
-- it on or opens its panel. Polestar's door (Polestar/Quests/GroupFinder.lua)
-- holds its settings, its key bindings' and command's entry points and the
-- guide menu's row; docs/ARCHITECTURE.md, "Group Finder", is the contract.
--
-- The files here talk to each other through `ns` (the folder's own table,
-- as an addon's second argument): a small message bus of their own
-- (ns.On / ns.Fire: SETTING, ENABLED, SESSION, PEERS, ...), their game events
-- (ns.RegisterEvent) and their settings, which are Polestar's under
-- "groupFinder." (ns.Get("autoGroup") reads Polestar.Get("groupFinder.autoGroup")).
-- The per-character memory of a group formed through the finder is in
-- Polestar.CharState().groupFinder.

local ADDON, ns = ...
local P = Polestar
local L = P.L

ns.P = P
ns.L = L
ns.name = ADDON
ns.SECTION = "groupFinder"

ns.ICON = P.Theme.Media("icon-group")

function ns.ApplyIcon(tex, size)
	if not (tex and tex.SetTexture) then return false end
	tex:SetTexture(ns.ICON)
	if size and tex.SetSize then tex:SetSize(size, size) end
	return true
end

---------------------------------------------------------------------------
-- Settings: Polestar's, under groupFinder. (defaults in the door)
---------------------------------------------------------------------------

function ns.Get(key) return P.Get(ns.SECTION .. "." .. key) end
function ns.Set(key, value) P.Set(ns.SECTION .. "." .. key, value) end

-- The per-character memory (Leave.lua).
function ns.Char()
	local c = P.CharState()
	c.groupFinder = c.groupFinder or {}
	return c.groupFinder
end

---------------------------------------------------------------------------
-- Chat, timers, names
---------------------------------------------------------------------------

function ns.Print(fmt, ...)
	P.Print(select("#", ...) > 0 and string.format(fmt, ...) or fmt)
end

function ns.Debug(fmt, ...)
	if not ns.Get("debug") then return end
	ns.Print("|cff888888" .. fmt .. "|r", ...)
end

function ns.After(seconds, fn) return P.After(seconds, fn) end
function ns.Now() return GetTime() end

-- A player's name as shown ("Ana Smith", realm dropped) and as a table key.
function ns.ShortName(name)
	return Ambiguate and Ambiguate(name, "none") or name
end
function ns.NameKey(name)
	return ns.ShortName(name):lower()
end

-- Secret values (Forever inherits the client's restricted values): never
-- compare or send them.
function ns.Readable(v)
	if v ~= nil and issecretvalue and issecretvalue(v) then return nil end
	return v
end

---------------------------------------------------------------------------
-- The module's own message bus and game events
---------------------------------------------------------------------------

local listeners = {}
function ns.On(msg, fn)
	listeners[msg] = listeners[msg] or {}
	table.insert(listeners[msg], fn)
end
function ns.Fire(msg, ...)
	for _, fn in ipairs(listeners[msg] or {}) do
		local ok, err = pcall(fn, ...)
		if not ok then P.Debug("GroupFinder", msg, tostring(err)) end
	end
end

local frame = CreateFrame("Frame")
ns.eventFrame = frame
local handlers = {}
function ns.RegisterEvent(event, fn)
	if not handlers[event] then
		handlers[event] = {}
		frame:RegisterEvent(event)
	end
	table.insert(handlers[event], fn)
end
-- Runs our handlers for `event` (also how the tests feed one in).
function ns.Dispatch(event, ...)
	for _, fn in ipairs(handlers[event] or {}) do
		local ok, err = pcall(fn, event, ...)
		if not ok then P.Debug("GroupFinder", event, tostring(err)) end
	end
end
frame:SetScript("OnEvent", function(_, event, ...) ns.Dispatch(event, ...) end)

---------------------------------------------------------------------------
-- The calls that act on the world, in one place
---------------------------------------------------------------------------

function ns.InGroup()
	return (IsInGroup and IsInGroup()) and true or false
end

function ns.InviteUnit(name)
	local fn = (C_PartyInfo and C_PartyInfo.InviteUnit) or InviteUnit
	if fn then pcall(fn, name) end
end

function ns.LeaveParty()
	local fn = (C_PartyInfo and C_PartyInfo.LeaveParty) or LeaveParty
	if fn then pcall(fn) end
end

-- A chat line (whisper, party, channel), only ever from the player's click
-- or key; true when the client took it.
function ns.SendChat(text, chatType, target)
	if type(text) ~= "string" or text == "" then return false end
	local fn = (C_ChatInfo and C_ChatInfo.SendChatMessage) or SendChatMessage
	if not fn then return false end
	return pcall(fn, text, chatType, nil, target) and true or false
end

---------------------------------------------------------------------------
-- On / off, and Polestar's setting changes as our SETTING messages
---------------------------------------------------------------------------

function ns.SetEnabled(on)
	ns.Set("enabled", on and true or false)
end

local wasOn
local function checkEnabled()
	local on = ns.Get("enabled") and true or false
	if on == wasOn then return end
	wasOn = on
	ns.Fire("ENABLED", on)
end

P.On("SETTING_CHANGED", function(path)
	if path == nil or path == "" then
		-- A profile switch or Reset all: every setting may have moved.
		ns.Fire("SETTING", nil)
		checkEnabled()
		return
	end
	local key = path:match("^groupFinder%.(.+)$")
	if not key then return end
	ns.Fire("SETTING", key, ns.Get(key))
	if key == "enabled" then checkEnabled() end
end)

-- Door.lua, the last file: every file is in. Tell them, then start: now
-- when the folder loads after login, else with Polestar's login.
local function start()
	ns.Fire("LOGIN")
	checkEnabled()
	ns.Fire("POLESTAR", P)
end
function ns.Start() P.OnLogin(start) end
