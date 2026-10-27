-- Position trail: `/psrec trail on [label]` records where the player walks,
-- densely enough to rebuild the path (city ramps, lifts, rope bridges) for
-- Polestar's navigation. Off by default, and only while the Recorder itself
-- records; `/psrec trail off` ends it, and it stops by itself after
-- MAX_TIME, on /psrec off and on logout or /reload.
--
-- Records (docs/RECORDING.md): a `mark` "trail on: <label>" at the start
-- and "trail off: <label> (<points> points, <yards> yd, <reason>)" at the
-- end, and between them `pos` records with the trail flag (64). A 4 Hz
-- ticker writes a sample when the player moved MIN_YARDS (in world
-- coordinates, height included, when the client gives them), changed map
-- (a city floor is its own map), or MAX_GAP seconds passed.

local ADDON, ns = ...

local type, pcall, floor, GetTime = type, pcall, math.floor, GetTime

local TICK = 0.25 -- seconds between samples (4 Hz)
local MIN_YARDS = 1 -- write a sample after moving this far ...
local MAX_GAP = 2 -- ... or after this long (seconds)
local MAX_TIME = 30 * 60 -- the trail stops by itself after this long (seconds)
ns.TRAIL_MAX_MINUTES = MAX_TIME / 60

-- First return of fn(...), nil when fn is missing, fails or returns a secret.
local function value(fn, ...)
	if type(fn) ~= "function" then return nil end
	local ok, v = pcall(fn, ...)
	if ok and ns.Usable(v) then return v end
	return nil
end

-- World coordinates (the Map frames convention of ARCHITECTURE: wx north,
-- wy west): UnitPosition when it answers (with the height), else the map
-- position converted, without a height. Forever's client has answered a
-- height of exactly 0 where the ground is at 12 yd (Polestar's
-- Compat.GetPlayerUnitPosition); a real height is never exactly 0, so that
-- one is left out. Only for spacing the samples: `pos` has no height.
local function world(map, x, y)
	if type(UnitPosition) == "function" then
		local ok, wx, wy, wz = pcall(UnitPosition, "player")
		if ok and type(wx) == "number" and type(wy) == "number" and ns.Usable(wx) and ns.Usable(wy) then
			if not (type(wz) == "number" and ns.Usable(wz) and wz ~= 0) then wz = nil end
			return wx, wy, wz
		end
	end
	if x and C_Map.GetWorldPosFromMapPos and CreateVector2D then
		local ok, _, pos = pcall(C_Map.GetWorldPosFromMapPos, map, CreateVector2D(x / 100, y / 100))
		if ok and pos and type(pos.x) == "number" and type(pos.y) == "number" then return pos.x, pos.y, nil end
	end
	return nil
end

-- The running trail: { label, started, n, yards, ticker, at, map, x, y, wx,
-- wy, wz } (the last written sample's position).
local trail

-- This session's finished trails, oldest first: { label, n, secs, yards, reason }.
local history = {}
local stopHooks = {}

-- fn(summary) after every trail stop (Panel.lua ticks its spot).
function ns.OnTrailStop(fn) stopHooks[#stopHooks + 1] = fn end

function ns.TrailHistory() return history end

local function stop(reason)
	local tr = trail
	if not tr then return nil end
	trail = nil
	if tr.ticker then tr.ticker:Cancel() end
	local yards = floor(tr.yards + 0.5)
	ns.Rec("mark", ns.P(), ("trail off: %s (%d points, %d yd, %s)"):format(tr.label, tr.n, yards, reason))
	local summary = { label = tr.label, n = tr.n, secs = GetTime() - tr.started, yards = yards, reason = reason }
	history[#history + 1] = summary
	for i = 1, #stopHooks do
		local ok, err = pcall(stopHooks[i], summary)
		if not ok then geterrorhandler()(err) end
	end
	return tr
end

-- Yards walked from the last written sample (nil across a loading screen).
local MAX_STEP = 200
local function stepYards(tr, map, x, y, wx, wy, wz)
	local d
	if wx and tr.wx then
		local dx, dy = wx - tr.wx, wy - tr.wy
		local dz = (wz and tr.wz) and wz - tr.wz or 0
		d = (dx * dx + dy * dy + dz * dz) ^ 0.5
	elseif x and tr.x and map == tr.map then
		d = ns.Yards(map, x - tr.x, y - tr.y)
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
	if x and tr.x then return ns.Yards(map, x - tr.x, y - tr.y) >= MIN_YARDS end
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
	local map, x, y = ns.Position()
	if not x then return end
	local wx, wy, wz = world(map, x, y)
	if now - tr.at < MAX_GAP and not moved(tr, map, x, y, wx, wy, wz) then return end
	if not ns.RecPos(map, x, y, ns.POS_TRAIL) then
		stop("off")
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
	ns.Rec("mark", ns.P(), "trail on: " .. label)
	sample()
	trail.ticker = C_Timer.NewTicker(TICK, sample)
	return trail
end

-- Stops the running trail (recording why); returns it, or nil.
ns.TrailStop = stop

function ns.Trail() return trail end

-- A new session (a login, /psrec clear) starts an empty list; a /reload or
-- logout ends the Lua state, so the trail is closed while it can be.
ns.OnSession(function()
	history = {}
	local tr = trail
	if not tr then return end
	trail = nil
	if tr.ticker then tr.ticker:Cancel() end
end)
ns.OnLogout(function() stop("logout") end)
