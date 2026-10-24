-- Position trail: `/psrec trail on [label]` records where the player walks,
-- densely enough to rebuild the path (city ramps, lifts, rope bridges) for
-- Polestar's navigation. Off by default, and only while the Recorder itself
-- records; `/psrec trail off` ends it, and it stops by itself after
-- MAX_TIME, at the session's cap, on /psrec off and on logout or /reload.
--
-- Events: `trail_start` { label } and `trail_stop` { label, n, reason } at
-- the player's position, and between them `trail` samples. A 4 Hz ticker
-- stores a sample when the player moved MIN_YARDS (in world coordinates,
-- height included, when the client gives them), changed map (a city floor is
-- its own map), or MAX_GAP seconds passed. Flags are stored only when true.

local ADDON, ns = ...

local type, pcall, floor, GetTime = type, pcall, math.floor, GetTime

local TICK = 0.25 -- seconds between samples (4 Hz)
local MIN_YARDS = 1 -- store a sample after moving this far ...
local MAX_GAP = 2 -- ... or after this long (seconds)
local MAX_TIME = 30 * 60 -- the trail stops by itself after this long (seconds)
ns.TRAIL_MAX_MINUTES = MAX_TIME / 60

local function round(v, scale) return floor(v * scale + 0.5) / scale end

-- First return of fn(...), nil when fn is missing, fails or returns a secret.
local function value(fn, ...)
	if type(fn) ~= "function" then return nil end
	local ok, v = pcall(fn, ...)
	if ok and ns.Usable(v) then return v end
	return nil
end

local function num(v, scale)
	if type(v) == "number" then return round(v, scale) end
	return nil
end

local function flag(fn, ...)
	return value(fn, ...) and true or nil
end

-- uiMapID, x, y (0-1, unrounded) | uiMapID | nil
local function position()
	local map = value(C_Map and C_Map.GetBestMapForUnit, "player")
	if not map then return nil end
	local v = value(C_Map.GetPlayerMapPosition, map, "player")
	if not v then return map end
	local x, y = v.x, v.y
	if not (ns.Usable(x) and ns.Usable(y)) then return map end
	return map, x, y
end

-- World coordinates (the Map frames convention of ARCHITECTURE: wx north,
-- wy west): UnitPosition when it answers (with the height), else the map
-- position converted, without a height. Forever's client has answered a
-- height of exactly 0 where the ground is at 12 yd (Polestar's
-- Compat.GetPlayerUnitPosition); a real height is never exactly 0, so that
-- one is left out.
local function world(map, x, y)
	if type(UnitPosition) == "function" then
		local ok, wx, wy, wz = pcall(UnitPosition, "player")
		if ok and type(wx) == "number" and type(wy) == "number" and ns.Usable(wx) and ns.Usable(wy) then
			if not (type(wz) == "number" and ns.Usable(wz) and wz ~= 0) then wz = nil end
			return wx, wy, wz
		end
	end
	if x and C_Map.GetWorldPosFromMapPos and CreateVector2D then
		local ok, _, pos = pcall(C_Map.GetWorldPosFromMapPos, map, CreateVector2D(x, y))
		if ok and pos and type(pos.x) == "number" and type(pos.y) == "number" then return pos.x, pos.y, nil end
	end
	return nil
end

-- The running trail: { label, started, n, yards, ticker, at, map, x, y, wx,
-- wy, wz } (the last stored sample's unrounded position).
local trail

-- This session's finished trails, oldest first: { label, n, secs, yards,
-- reason }. Read back from the session's events once (after a /reload),
-- then kept as trails stop.
local history
local stopHooks = {}

-- fn(summary) after every trail stop (Panel.lua ticks its spot).
function ns.OnTrailStop(fn) stopHooks[#stopHooks + 1] = fn end

function ns.TrailHistory()
	if history then return history end
	history = {}
	local s = ns.Session()
	local open
	for _, ev in ipairs(s and s.events or {}) do
		if ev.e == "trail_start" then
			open = ev
		elseif ev.e == "trail_stop" then
			history[#history + 1] = {
				label = ev.label, n = ev.n or 0, reason = ev.reason, yards = ev.yd or 0,
				secs = open and type(ev.t) == "number" and type(open.t) == "number" and ev.t - open.t or 0,
			}
			open = nil
		end
	end
	return history
end

local function stop(reason)
	local tr = trail
	if not tr then return nil end
	trail = nil
	if tr.ticker then tr.ticker:Cancel() end
	local yards = floor(tr.yards + 0.5)
	ns.Record("trail_stop", ns.Here({ label = tr.label, n = tr.n, yd = yards, reason = reason }))
	local summary = { label = tr.label, n = tr.n, secs = GetTime() - tr.started, yards = yards, reason = reason }
	local list = ns.TrailHistory()
	list[#list + 1] = summary
	for i = 1, #stopHooks do
		local ok, err = pcall(stopHooks[i], summary)
		if not ok then geterrorhandler()(err) end
	end
	return tr
end

-- Yards walked from the last stored sample (nil across a loading screen).
local MAX_STEP = 200
local function stepYards(tr, map, x, y, wx, wy, wz)
	local d
	if wx and tr.wx then
		local dx, dy = wx - tr.wx, wy - tr.wy
		local dz = (wz and tr.wz) and wz - tr.wz or 0
		d = (dx * dx + dy * dy + dz * dz) ^ 0.5
	elseif x and tr.x and map == tr.map then
		d = ns.Yards(map, (x - tr.x) * 100, (y - tr.y) * 100)
	end
	if d and d <= MAX_STEP then return d end
	return nil
end

local function moved(tr, map, x, y, wx, wy, wz)
	if map ~= tr.map then return true end
	if wx and tr.wx then
		local dx, dy = wx - tr.wx, wy - tr.wy
		local dz = (wz and tr.wz) and wz - tr.wz or 0
		return dx * dx + dy * dy + dz * dz >= MIN_YARDS * MIN_YARDS
	end
	if x and tr.x then return ns.Yards(map, (x - tr.x) * 100, (y - tr.y) * 100) >= MIN_YARDS end
	return x ~= nil and tr.x == nil
end

local function sample()
	local tr = trail
	if not tr then return end
	local now = GetTime()
	if now - tr.started >= MAX_TIME then
		stop("timeout")
		ns.Print(ns.L["trail stopped after %d min: %s, %d points"]:format(MAX_TIME / 60, tr.label, tr.n))
		return
	end
	local map, x, y = position()
	if not map then return end
	local wx, wy, wz = world(map, x, y)
	if now - tr.at < MAX_GAP and not moved(tr, map, x, y, wx, wy, wz) then return end
	local ev = {
		map = map,
		x = x and round(x * 100, 10000),
		y = y and round(y * 100, 10000),
		wx = num(wx, 100),
		wy = num(wy, 100),
		wz = num(wz, 100),
		facing = num(value(GetPlayerFacing), 1000),
		speed = num(value(GetUnitSpeed, "player"), 100),
		mounted = flag(IsMounted),
		swimming = flag(IsSwimming),
		falling = flag(IsFalling),
		indoors = flag(IsIndoors),
		onTaxi = flag(UnitOnTaxi, "player"),
	}
	if not ns.Record("trail", ev) then
		stop("cap")
		ns.Print(ns.L["trail stopped: the session's trail cap is reached (%s, %d points)"]:format(tr.label, tr.n))
		return
	end
	if tr.n > 0 then tr.yards = tr.yards + (stepYards(tr, map, x, y, wx, wy, wz) or 0) end
	tr.n = tr.n + 1
	tr.at, tr.map, tr.x, tr.y, tr.wx, tr.wy, tr.wz = now, map, x, y, wx, wy, wz
end

-- Starts a trail; returns it, or nil and the running one.
function ns.TrailStart(label)
	if trail then return nil, trail end
	if not label or label == "" then
		label = value(GetSubZoneText) or ""
		if label == "" then label = value(GetRealZoneText) or "trail" end
	end
	trail = { label = label, started = GetTime(), n = 0, yards = 0, at = -math.huge }
	ns.Record("trail_start", ns.Here({ label = label }))
	sample()
	trail.ticker = C_Timer.NewTicker(TICK, sample)
	return trail
end

-- Stops the running trail (recording why); returns it, or nil.
ns.TrailStop = stop

function ns.Trail() return trail end

-- A new session (a /psrec clear, a login) ends the trail with the old one
-- and starts an empty list.
ns.OnSession(function()
	history = nil
	local tr = trail
	if not tr then return end
	trail = nil
	if tr.ticker then tr.ticker:Cancel() end
end)

-- A /reload or logout ends the Lua state; close the trail while it can.
ns.On("PLAYER_LOGOUT", function() stop("logout") end)
