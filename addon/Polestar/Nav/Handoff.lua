-- Hand-off to Shortest Path Forever: with it installed (and nav.spfHandoff
-- on, the default), it guides to Polestar's target and Polestar's own
-- guidance steps aside, so the two never guide at once. Contract:
-- docs/ARCHITECTURE.md, "Hand-off to Shortest Path Forever".
--
-- Shortest Path Forever by Cillian Berragan (GPL-3.0-or-later,
-- https://github.com/cjber/shortest-path-forever) is driven only through its
-- public API, ShortestPathForever.API (version 1; minor 1 adds Subscribe),
-- each function checked before it is called.
--
--   Nav.HandedOff() -> bool   the one predicate every guidance surface checks:
--       the arrow, the trail and transport alerts; the travel planner, which
--       then plans no route, so no route lines, journey steps or travel
--       button; the walking engine (Nav/Walk.lua neither loads Polestar_Nav
--       nor searches); map clicks, the TomTom stand-in and /way
--       (Nav/Journey.lua); and the TomTom and Blizzard waypoint mirrors
--       (Nav/Bridges.lua). Pins, the guide window and everything else stay.
--
-- The target goes as one stop, owner "Polestar": its live map point, its
-- label as the title, a stop kind (the goal's verb, a hand-set target's
-- `stop`, else a flight master, inn, dock or portal it stands at), and for a
-- kill, collect, use or click goal with a spawn area `hold` with `radius`,
-- `shapes` (every spawn spot) and the quests the area stands for, so the
-- stop never "arrives" while the area is worked. It is sent again only when
-- what it says changes; one the player or another addon cleared or replaced,
-- or that arrived, stays theirs until Polestar's target changes. A send
-- refused in combat (or without a position: an instance, a loading screen)
-- waits for combat's end or the world; one refused otherwise (Journeys off in
-- Shortest Path Forever, a point it cannot place) lets Polestar guide that
-- target itself. While the player is dead or a ghost nothing is sent: it
-- guides corpse runs itself.

local ADDON, ns = ...
local Nav = ns.Nav
local L = ns.L

local type, ipairs, tonumber, pcall, tostring = type, ipairs, tonumber, pcall, tostring
local format, concat = string.format, table.concat

local Handoff = {}
Nav.handoff = Handoff

ns.RegisterDefaults("nav", { spfHandoff = true })

local OWNER = "Polestar"
local PLACE = 15 -- yards: a target this close to a flight master, inn or portal stands at it
local DOCK = 30  -- yards: ... to a boat, zeppelin, lift or tram's landing

-- Stop kinds by guide verb.
local VERB_KIND = {
	accept = "pickup", turnin = "turnin",
	complete = "objective", kill = "objective", collect = "objective", use = "objective", interact = "objective",
	train = "trainer", sethome = "innkeeper", getfp = "flightmaster", fly = "flightmaster",
}
-- Verbs whose spawn area is held: worked there, never arrived at.
local HELD = { kill = true, collect = true, use = true, interact = true }

---------------------------------------------------------------------------
-- Shortest Path Forever
---------------------------------------------------------------------------

local function api()
	local S = _G.ShortestPathForever
	local A = type(S) == "table" and S.API
	if type(A) ~= "table" or A.version ~= 1 or type(A.Cancel) ~= "function" then return nil end
	if type(A.NavigateRoute) ~= "function" and type(A.Navigate) ~= "function" then return nil end
	return A
end

-- Shortest Path Forever is installed and answers the API.
function Handoff.Available()
	return api() ~= nil
end

local function engaged()
	return ns.Get("nav.spfHandoff") and api() ~= nil or false
end

local refused = false -- it refused the last stop: Polestar guides that target itself
local refusedKey      -- the stop (or target) refused, not offered again until it changes or the world reloads
local sentKey         -- the stop it last took, kept after its journey ends: never sent twice
local live = false    -- that journey still runs, as far as Polestar knows
local pending = false -- a stop waits for combat's end or a position
local worldUp = false -- PLAYER_ENTERING_WORLD seen: nothing is sent before
local subscribed = false
local wasEngaged

function Nav.HandedOff()
	return not refused and engaged()
end

local function inCombat()
	local C = ns.Compat
	if C and C.InCombat then return C.InCombat() end
	return InCombatLockdown ~= nil and InCombatLockdown() and true or false
end

local function dead()
	if not UnitIsDeadOrGhost then return false end
	local v = UnitIsDeadOrGhost("player")
	local C = ns.Compat
	if C and C.Readable then v = C.Readable(v) end
	return v == true
end

local function positioned()
	local C = ns.Compat
	if not C or (C.IsInInstance and C.IsInInstance()) then return false end
	return C.GetPlayerWorldPosition ~= nil and C.GetPlayerWorldPosition() ~= nil
end

---------------------------------------------------------------------------
-- The stop
---------------------------------------------------------------------------

local function fraction(x, y)
	return x ~= nil and y ~= nil and x >= 0 and x <= 1 and y >= 0 and y <= 1
end

-- A point as Shortest Path Forever takes it: uiMapID and live-frame 0-1 x, y.
local function livePoint(map, x, y, f)
	local m, lx, ly = Nav.LiveCoords({ map = map, x = x, y = y, f = f })
	lx, ly = lx and lx / 100, ly and ly / 100
	if m and fraction(lx, ly) then return m, lx, ly end
end

-- The guide goal an Engine waypoint stands for and its step (nil for a hand-set target).
local function goalOf(t)
	if t.kind == "manual" or not (t.stepIndex and t.goalIndex) then return nil end
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	local step = type(guide) == "table" and type(guide.steps) == "table" and guide.steps[t.stepIndex]
	local goal = type(step) == "table" and type(step.goals) == "table" and step.goals[t.goalIndex]
	if type(goal) == "table" then return goal, step end
end

-- The flight master, inn, landing or portal a target stands at, as a stop kind.
local function placeKind()
	local c, wx, wy = Nav.GetTargetWorld()
	local D = c and Nav.GetTravelData and Nav.GetTravelData()
	if not D then return nil end
	local function near(p, yards)
		return type(p) == "table" and p.c == c and (p.wx - wx) ^ 2 + (p.wy - wy) ^ 2 <= yards * yards
	end
	for _, t in ipairs(D.transports or {}) do
		if near(t.a, DOCK) or near(t.b, DOCK) then return t.kind end
	end
	for _, p in ipairs(D.portals or {}) do
		if near(p.a, PLACE) then return "portal" end
	end
	for _, n in ipairs(D.taxi or {}) do
		if near(n, PLACE) then return "flightmaster" end
	end
	for _, inn in ipairs(D.inns or {}) do
		if near(inn, PLACE) then return "innkeeper" end
	end
end

local function questID(v)
	v = tonumber(v)
	if v and v >= 1 and v % 1 == 0 then return v end
end

-- A goal's spawn spots in world yards: { c, wx, wy, reach }.
local function worldSpots(goal)
	local C, out = ns.Compat, {}
	if not (C and C.MapToWorld and type(goal.spots) == "table" and goal.map) then return out end
	local r = tonumber(goal.r) or Nav.DEFAULT_RADIUS
	for _, s in ipairs(goal.spots) do
		local c, wx, wy = C.MapToWorld(goal.map, s.x, s.y, goal.f)
		if c then out[#out + 1] = { c, wx, wy, (tonumber(s.r) or 0) + r } end
	end
	return out
end

local function overlap(a, b)
	for _, p in ipairs(a) do
		for _, q in ipairs(b) do
			local reach = p[4] + q[4]
			if p[1] == q[1] and (p[2] - q[2]) ^ 2 + (p[3] - q[3]) ^ 2 <= reach * reach then return true end
		end
	end
	return false
end

-- The quests a held area stands for: the goal's own, then every other open
-- objective of the step with a spawn area overlapping it.
local function questsOf(goal, t)
	local own = questID(goal.quest)
	if not own then return nil end
	local list, seen = { own }, { [own] = true }
	local E = ns.Engine
	local view = E and E.GetStepView and E.GetStepView(t.stepIndex)
	local step = select(2, goalOf(t))
	if not (type(view) == "table" and type(view.goals) == "table" and step) then return list end
	local mine
	for _, v in ipairs(view.goals) do
		local other = (v.status == "active" or v.status == "pending") and v.index ~= t.goalIndex and step.goals[v.index]
		local q = other and HELD[other.t] and questID(other.quest)
		if q and not seen[q] and other.spots and other.map == goal.map then
			mine = mine or worldSpots(goal)
			if overlap(mine, worldSpots(other)) then
				seen[q] = true
				list[#list + 1] = q
			end
		end
	end
	return list
end

-- The target as one stop, or nil when it has no point Shortest Path Forever can take.
local function stopOf(t)
	local map, x, y = livePoint(t.map, t.x, t.y, t.f)
	if not map then return nil end
	local verb = t.kind ~= "manual" and t.kind or nil
	local stop = { map = map, x = x, y = y, title = t.label, kind = t.stop or VERB_KIND[verb] or placeKind() }
	local area = tonumber(t.area)
	if HELD[verb] and area and area > 0 then
		local r = tonumber(t.r) or Nav.DEFAULT_RADIUS
		local goal = goalOf(t)
		stop.hold, stop.radius = true, area + r
		local shapes = {}
		if goal and type(goal.spots) == "table" then
			for _, s in ipairs(goal.spots) do
				local sm, sx, sy = livePoint(goal.map, s.x, s.y, goal.f)
				if sm then shapes[#shapes + 1] = { map = sm, x = sx, y = sy, radius = (tonumber(s.r) or 0) + r } end
			end
		end
		if #shapes == 0 then shapes[1] = { map = map, x = x, y = y, radius = area + r } end
		stop.shapes = shapes
		local quests = goal and questsOf(goal, t)
		if quests then
			stop.questID = quests[1]
			if #quests > 1 then stop.questIDs = quests end
		end
	end
	return stop
end

-- Everything the stop says, as one string: the same string is the same stop.
local function keyOf(s)
	local parts = {
		format("%d:%.4f:%.4f", s.map, s.x, s.y), s.title or "", s.kind or "", s.hold and "hold" or "",
		s.radius and format("%.1f", s.radius) or "", tostring(s.questID or ""), s.questIDs and concat(s.questIDs, ",") or "",
	}
	for _, sh in ipairs(s.shapes or {}) do
		parts[#parts + 1] = format("%d:%.4f:%.4f:%.1f", sh.map, sh.x, sh.y, sh.radius)
	end
	return concat(parts, "|")
end

---------------------------------------------------------------------------
-- Sending
---------------------------------------------------------------------------

local function send(A, s)
	local ok, took
	if type(A.NavigateRoute) == "function" then
		ok, took = pcall(A.NavigateRoute, OWNER, { s })
	else
		ok, took = pcall(A.Navigate, OWNER, s.map, s.x, s.y, s.title, s.kind)
	end
	return ok and took == true
end

local function cancel(A)
	if live and A then pcall(A.Cancel, OWNER) end
	live = false
end

-- Polestar's own guidance comes back (or steps aside again) for the same target.
local function setRefused(on)
	if refused == on then return end
	refused = on
	Nav.Reapply()
end

local function step(force)
	local A = api()
	if not engaged() then
		cancel(A)
		sentKey, pending, refusedKey, refused = nil, false, nil, false
		return
	end
	if not worldUp or dead() then return end
	local t = Nav.GetTarget()
	if not t then
		cancel(A)
		sentKey, pending, refusedKey = nil, false, nil
		setRefused(false)
		return
	end
	local s = stopOf(t)
	local key = s and keyOf(s) or t
	if key == sentKey then
		pending = false
		return
	end
	if refused and key == refusedKey and not force then return end
	if s and (inCombat() or not positioned()) then
		pending = true
		return
	end
	if s and send(A, s) then
		sentKey, pending, live, refusedKey = key, false, true, nil
		setRefused(false)
	elseif s and inCombat() then
		pending = true
	else
		-- Refused (or nothing it can take): its journey to an earlier target of ours goes too.
		cancel(A)
		sentKey, pending, refusedKey = nil, false, key
		setRefused(true)
	end
end

local syncing = false
local function sync(force)
	if syncing then return end
	syncing = true
	local ok, err = pcall(step, force)
	syncing = false
	if not ok then error(err, 0) end
end
Handoff.Sync = sync

-- Its guidance changed: has the journey Polestar sent ended (arrived, cleared,
-- replaced)? Then it stays ended until Polestar's target changes.
local function heard()
	local A = api()
	if not (A and live) then return end
	local why = type(A.Ended) == "function" and A.Ended(OWNER)
	if why or (type(A.CurrentStop) == "function" and A.CurrentStop(OWNER) == nil) then live = false end
end

local function subscribe()
	if subscribed then return end
	local A = api()
	if not (A and type(A.Subscribe) == "function") then return end
	subscribed = pcall(A.Subscribe, heard) and true or false
end

---------------------------------------------------------------------------
-- Wiring
---------------------------------------------------------------------------

function Handoff:OnTarget()
	sync()
end

-- Without Subscribe (minor 0): Nav's once-a-second tick asks instead.
function Handoff:Refresh()
	if live and not subscribed then heard() end
end

function Handoff:OnSettings()
	local now = engaged()
	if wasEngaged == nil then wasEngaged = now end
	if now == wasEngaged then return end
	wasEngaged = now
	if now then
		sentKey, refusedKey, refused = nil, nil, false
		subscribe()
	else
		sync()
	end
	Nav.Reapply()
end

Nav.RegisterModule(Handoff)

ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	worldUp = true
	wasEngaged = engaged()
	if wasEngaged then subscribe() end
	sync(true)
end)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", function()
	if pending or refused then sync(true) end
end)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if pending then sync() end
end)
-- Dead or a ghost, nothing is sent; alive again, the target goes as it is.
for _, event in ipairs({ "PLAYER_DEAD", "PLAYER_ALIVE", "PLAYER_UNGHOST" }) do
	ns.RegisterEvent(event, function() sync() end)
end

if ns.RegisterOptions then
	local ok, err = ns.RegisterOptions({
		page = L["Integrations"], section = "Shortest Path Forever",
		controls = {
			{ kind = "toggle", key = "nav.spfHandoff", label = L["Guide with Shortest Path Forever when it's installed"],
				help = L["Shortest Path Forever's arrow, route and journey take you to each goal. Polestar's arrow, route lines, journey steps, travel button, transport alerts, map clicks and /way step aside; the guide window and map pins stay."],
				needs = Handoff.Available },
		},
	})
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
