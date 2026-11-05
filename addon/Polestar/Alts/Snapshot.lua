-- The Characters page's data: one small snapshot per character on the
-- account, written as each one plays and read back by the others. Stored in
-- PolestarDB.alts.chars["Name-Realm"], the same key Maps/Instances.lua files
-- its instance entries under.
--
--   Alts.Key() -> "Name-Realm" of the current character
--   Alts.List(sortBy) -> entries, the current character first, then by
--     "seen" (newest first, the default), "rested" or "level"
--   Alts.Forget(key) -> true | false (the current character is never forgotten)
--   Alts.ProjectRested(entry, now) -> rested XP now, from its logout (pure)
--   Alts.Rested(entry, now) -> that, or the live value for the current character
--   Alts.IsCurrent(entry), Alts.MaxLevel(), Alts.Enabled()
--
-- When it writes: in the world, at login (after five seconds), on level-ups,
-- XP, zone, money, skill and tab changes (coalesced into one write every ten
-- seconds), on resting changes at once, and at once when the player asks to
-- leave (PLAYER_CAMPING, PLAYER_QUITING). While the player is resting (an inn
-- or city) those frequent events write at once too, so an instant logout there
-- leaves the entry current. Logout() and Quit() are protected and not hooked.
-- It writes NOTHING read from the client on PLAYER_LEAVING_WORLD or
-- PLAYER_LOGOUT, only `seen`:
-- the client answers those reads wrongly while the world goes (resting false,
-- no gold, no map, the indoor area for the zone), plausibly enough that
-- nothing can tell. Writes merge into the entry, so a field that does not
-- read keeps its saved value.
--
-- An entry: name, realm, class (file token), race, faction, level, xp, xpMax,
-- rested (XP, absent when none), resting (in an inn or city), zone, bind,
-- money (copper), profs { [skillLine] = rank }, tabs { { id, title, step,
-- count, complete } } with active (the tab index), seen (server time), key. Values
-- that equal nothing are left out.

local ADDON, ns = ...
local Compat = ns.Compat
local min, max, pairs, ipairs, type = math.min, math.max, pairs, ipairs, type

local L = ns.L
local Alts = {}
ns.Alts = Alts

-- Classic's rested rules. Forever's rates are unverified: these are the
-- Classic numbers, and a character logged out away from an inn is a rough guess.
local REST_PER_8H = 0.05 -- of a level's XP, per 8 hours logged out in an inn or city
local AWAY_FACTOR = 0.25 -- of that, anywhere else
local REST_CAP = 1.5 -- levels of rested XP at most
local DEFAULT_MAX_LEVEL = 60
local DELAY = 10 -- seconds between writes while the frequent events fire
local LOGIN_DELAY = 5 -- the guide tabs exist by then
local MAX_TABS = 6
local RIDING = 762

Alts.REST_PER_8H, Alts.AWAY_FACTOR, Alts.REST_CAP = REST_PER_8H, AWAY_FACTOR, REST_CAP

ns.RegisterDefaults("alts", { enabled = true, sort = "seen" }) -- sort: the Characters page's order, seen | rested | level

local function chars()
	local db = ns.DB()
	if type(db.alts) ~= "table" then db.alts = {} end
	if type(db.alts.chars) ~= "table" then db.alts.chars = {} end
	return db.alts.chars
end

-- Formed exactly as Maps/Instances.lua's charName() forms it.
function Alts.Key()
	local info = Compat and Compat.GetPlayerInfo and Compat.GetPlayerInfo()
	if not (info and info.name) then return nil end
	return info.realm and (info.name .. "-" .. info.realm) or info.name
end

local function maxLevel()
	local cap = Compat.Readable(GetMaxPlayerLevel and GetMaxPlayerLevel())
	return type(cap) == "number" and cap > 0 and cap or DEFAULT_MAX_LEVEL
end
Alts.MaxLevel = maxLevel

function Alts.Enabled() return ns.Get("alts.enabled") and true or false end

local function liveRested()
	local v = Compat.Readable(GetXPExhaustion and GetXPExhaustion())
	return type(v) == "number" and v > 0 and v or nil
end

-- The professions with a rank, or nil when none reads (the saved ones then stay).
local function professions()
	local out
	for _, line in pairs(Compat.SKILL_LINES or {}) do
		if line ~= RIDING then
			local rank = Compat.GetSkillRank(line)
			if rank and rank > 0 then
				out = out or {}
				out[line] = rank
			end
		end
	end
	return out
end

local function tabList()
	local E = ns.Engine
	if not (E and E.GetTabs) then return nil end
	local ok, list, active = pcall(E.GetTabs)
	if not (ok and type(list) == "table") then return nil end
	local out = {}
	for i = 1, min(#list, MAX_TABS) do
		local t = list[i]
		out[i] = { id = t.guideId, title = t.title, step = t.stepIndex, count = t.stepCount, complete = t.complete or nil }
	end
	if #out == 0 then return nil end
	return out, active
end

local ZONE_TYPE = 3 -- Enum.UIMapType.Zone

-- The zone the player is in, not an indoor area: the zone-type map above the
-- player's best map (an inn's own name is GetZoneText's), else
-- GetRealZoneText, else GetZoneText. nil when none reads.
local function zoneName()
	local M = C_Map
	if M and M.GetBestMapForUnit and M.GetMapInfo then
		local ok, map = pcall(M.GetBestMapForUnit, "player")
		for _ = 1, 12 do
			if not (ok and map) then break end
			local info = M.GetMapInfo(map)
			if not info then break end
			if info.mapType == ZONE_TYPE then
				local name = Compat.Readable(info.name)
				if type(name) == "string" and name ~= "" then return name end
				break
			end
			if not info.parentMapID or info.parentMapID == 0 or info.parentMapID == map then break end
			map = info.parentMapID
		end
	end
	for _, get in ipairs({ GetRealZoneText or false, GetZoneText or false }) do
		if get then
			local name = Compat.Readable(get())
			if type(name) == "string" and name ~= "" then return name end
		end
	end
	return nil
end

local function number(v)
	v = Compat.Readable(v)
	return type(v) == "number" and v or nil
end

-- The current character's entry, written to the saved table. A write MERGES
-- into the entry: a field the client does not read now (it reads empty around
-- logout) keeps its saved value. touch: only `seen` moves and nothing is read
-- (leaving the world, when the client's answers are wrong), and no entry yet
-- is not made. silent: no
-- ALTS_UPDATED (the page asks for a fresh one while it paints). Nothing is
-- written with alts.enabled off.
function Alts.Write(silent, touch)
	if not Alts.Enabled() then return false end
	local key = Alts.Key()
	if not key then return false end
	local store = chars()
	local e = store[key]
	if touch then
		if type(e) ~= "table" then return false end
		e.seen = Compat.Now()
		return true
	end
	if type(e) ~= "table" then
		e = {}
		store[key] = e
	end
	e.key = key
	e.seen = Compat.Now()
	do
		local resting = Compat.Readable(IsResting and IsResting())
		if resting ~= nil then e.resting = resting and true or nil end
		e.rested = liveRested()
		local info = Compat.GetPlayerInfo()
		e.name, e.realm = info.name or e.name, info.realm or e.realm
		e.class, e.race = info.class or e.class, info.race or e.race
		e.faction = Compat.GetPlayerFaction() or e.faction
		local level = number(UnitLevel and UnitLevel("player"))
		if level and level >= 1 then e.level = level end
		local xpMax = number(UnitXPMax and UnitXPMax("player"))
		local xp = number(UnitXP and UnitXP("player"))
		if xp and xpMax and (xpMax > 0 or (e.level or 0) >= maxLevel()) then e.xp, e.xpMax = xp, xpMax end
		e.zone = zoneName() or e.zone
		e.bind = Compat.GetBindLocation() or e.bind
		local money = number(GetMoney and GetMoney())
		if money then e.money = money end
		if Compat.Supports and Compat.Supports("skill") then
			local profs = professions()
			if profs then e.profs = profs end
		end
		local tabs, active = tabList()
		if tabs then e.tabs, e.active = tabs, active end
	end
	if not silent then ns.Fire("ALTS_UPDATED") end
	return true
end

-- One write at most every DELAY seconds however often the events come: one
-- pending timer. A write made at once (camping, quitting, any change while
-- resting) retires it, so a timer from
-- before it does nothing when it fires.
local pending, gen = false, 0

local function schedule(delay)
	if pending then return end
	if C_Timer and C_Timer.After then
		pending = true
		local mine = gen
		C_Timer.After(delay, function()
			if mine ~= gen or not pending then return end
			pending = false
			Alts.Write()
		end)
	else
		Alts.Write()
	end
end

local function now()
	gen = gen + 1
	pending = false
	Alts.Write()
end

-- The frequent events: coalesced, except while resting, when an instant
-- logout is possible and nothing else would catch the change.
local function later()
	if Compat.Readable(IsResting and IsResting()) then now() else schedule(DELAY) end
end

-- The world is going (PLAYER_LEAVING_WORLD, PLAYER_LOGOUT): the client reads
-- wrong now, so only `seen` moves. A pending write is left alone for the
-- same reason.
local function leaving()
	Alts.Write(true, true)
end

---------------------------------------------------------------------------
-- Reading
---------------------------------------------------------------------------

-- Rested XP a character logged out at entry.seen has by `now`: gaining
-- REST_PER_8H of a level per 8 hours in an inn or city, AWAY_FACTOR of that
-- elsewhere, up to REST_CAP levels. nil at the level cap.
function Alts.ProjectRested(entry, at)
	if type(entry) ~= "table" or not entry.xpMax or entry.xpMax <= 0 then return nil end
	if (entry.level or 0) >= maxLevel() then return nil end
	local rested = entry.rested or 0
	local hours = max(0, (at or Compat.Now()) - (entry.seen or at or 0)) / 3600
	local rate = REST_PER_8H * (entry.resting and 1 or AWAY_FACTOR)
	return min(REST_CAP * entry.xpMax, rested + entry.xpMax * rate * hours / 8)
end

local function isCurrent(entry)
	return entry.key ~= nil and entry.key == Alts.Key()
end
Alts.IsCurrent = isCurrent

function Alts.Rested(entry, at)
	if isCurrent(entry) then
		if (entry.level or 0) >= maxLevel() then return nil end
		return liveRested() or 0
	end
	return Alts.ProjectRested(entry, at)
end

local function fraction(entry, at)
	local r = Alts.Rested(entry, at)
	if not r or not entry.xpMax or entry.xpMax <= 0 then return 0 end
	return r / entry.xpMax
end

function Alts.List(sortBy)
	local at = Compat.Now()
	local list = {}
	for key, e in pairs(chars()) do
		if type(e) == "table" then
			e.key = e.key or key
			list[#list + 1] = e
		end
	end
	local function byRecent(a, b)
		local sa, sb = a.seen or 0, b.seen or 0
		if sa ~= sb then return sa > sb end
		return a.key < b.key
	end
	local rank
	if sortBy == "rested" then
		local cache = {}
		for _, e in ipairs(list) do cache[e] = fraction(e, at) end
		rank = function(a, b)
			if cache[a] ~= cache[b] then return cache[a] > cache[b] end
			return byRecent(a, b)
		end
	elseif sortBy == "level" then
		rank = function(a, b)
			if (a.level or 0) ~= (b.level or 0) then return (a.level or 0) > (b.level or 0) end
			return byRecent(a, b)
		end
	else
		rank = byRecent
	end
	local me = Alts.Key()
	table.sort(list, function(a, b)
		local am, bm = a.key == me, b.key == me
		if am ~= bm then return am end
		return rank(a, b)
	end)
	return list
end

function Alts.Forget(key)
	if key == nil or key == Alts.Key() then return false end
	local c = chars()
	if c[key] == nil then return false end
	c[key] = nil
	return true
end

---------------------------------------------------------------------------
-- Writing as the character plays
---------------------------------------------------------------------------

local EVENTS = { "PLAYER_LEVEL_UP", "PLAYER_XP_UPDATE", "ZONE_CHANGED_NEW_AREA", "PLAYER_MONEY", "SKILL_LINES_CHANGED" }
local REQUESTS = { "PLAYER_CAMPING", "PLAYER_QUITING" } -- the player asked to leave: still in the world
local started, tabsHandle = false, nil

-- Listening only while alts.enabled is on.
local function start()
	if started then return end
	started = true
	for _, ev in ipairs(EVENTS) do ns.RegisterEvent(ev, later) end
	tabsHandle = ns.On("TABS_CHANGED", later)
	ns.RegisterEvent("PLAYER_UPDATE_RESTING", now) -- an inn entered and left within seconds still counts
	for _, ev in ipairs(REQUESTS) do ns.RegisterEvent(ev, now) end -- an event this client lacks is skipped
	ns.RegisterEvent("PLAYER_LEAVING_WORLD", leaving)
	ns.RegisterEvent("PLAYER_LOGOUT", leaving)
end

local function stop()
	if not started then return end
	started = false
	gen, pending = gen + 1, false
	for _, ev in ipairs(EVENTS) do ns.UnregisterEvent(ev, later) end
	ns.Off(tabsHandle)
	ns.UnregisterEvent("PLAYER_UPDATE_RESTING", now)
	for _, ev in ipairs(REQUESTS) do ns.UnregisterEvent(ev, now) end
	ns.UnregisterEvent("PLAYER_LEAVING_WORLD", leaving)
	ns.UnregisterEvent("PLAYER_LOGOUT", leaving)
end

local loggedIn = false
ns.OnLogin(function()
	loggedIn = true
	if not Alts.Enabled() then return end
	if C_Timer and C_Timer.After then schedule(LOGIN_DELAY) else now() end
	start()
end)

ns.On("SETTING_CHANGED", function(path)
	if not loggedIn or type(path) ~= "string" or not (path == "alts.enabled" or path == "alts" or path == "") then return end
	if Alts.Enabled() then
		start()
		now()
	else
		stop()
	end
end)

ns.RegisterCommand("alts", function() ns.Fire("SHOW_ALTS") end, L["Show your characters"])
