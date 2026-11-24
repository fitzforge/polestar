-- The rune stop (#3547): a Mage with no Rune of Teleportation, on a route that
-- flies, with a vendor who sells the rune in the same zone and a short walk
-- away (a capital's seller counts from anywhere in it), sees that stop in While
-- you're here when walking there, buying one and teleporting clearly beats the
-- route.
--
-- It only suggests (Engine.SetRuneStop makes the line; a click points the arrow
-- at the vendor, as a sell or repair line's does) and buys nothing. Once a rune
-- is in the bags the line goes, Transit.Teleports lists the teleport again and
-- the planner weighs it as it always does.
--
-- The planning is done when the route or the bags change (Survey): the sellers
-- worth a look, each with the teleport's way on from where it lands and the walk
-- to the seller as the planner measured it. The 3 s tick plans nothing: it
-- scales each walk by the straight line from where the player stands now (Pick),
-- and asks the planner whether it would cast the teleport only for a seller
-- that clears the margin, once per seller, teleport and target.
--
--   RuneStop.Find() -> offer | nil   (Survey, then Pick)
--     offer = { seller = place, places = { place }, yards, teleport, seconds, saves }
--   RuneStop.Refresh()  surveys and hands the Engine the offer there is now

local ADDON, ns = ...
local Nav = ns.Nav

local RuneStop = {}
Nav.runeStop = RuneStop

local ipairs, sqrt, sort, format, min, max = ipairs, math.sqrt, table.sort, string.format, math.min, math.max

local MAX_WALK = 120   -- seconds to the seller: in a wide zone, further is another trip
local TRY = 3          -- sellers, closest first, worth a travel estimate on each survey
local BUY_SECONDS = 10 -- opening the vendor and buying one
local RUN_SPEED = 7
local DETOUR_MAX = 2.5 -- a walk measured at most this many times its straight line
local CHECK_DELAY = 1  -- seconds after a route or bag change: they come in bursts
local TICK = 3         -- seconds: walking up to a seller changes no route

local VERDICT_SECONDS = 15 -- how long the planner's answer for one seller and target is kept
local VERDICT_MAX = 32

local pending, showing, ticker = false, false, nil
local survey -- { target, zone, list = { { place, t, after, detour } } } | nil: nothing to offer until the next change
local verdicts, verdictCount = {}, 0

-- The route still ahead flies and casts no teleport.
local function fliesAhead(legs, ci)
	local flies = false
	for k = ci or 1, legs and #legs or 0 do
		local kind = legs[k].kind
		if kind == "teleport" then return false end
		if kind == "fly" then flies = true end
	end
	return flies
end

-- Whether the planner would cast t from the seller, once the rune is bought: the line never promises a teleport the
-- route then leaves out. A full plan, so its answer is kept a while for each seller, teleport and target.
local function plannerAgrees(t, seller, target)
	local key = format("%s:%s:%s:%s:%s", t.spell, seller.id or "?", target.map or "?", target.x or "?", target.y or "?")
	local now, hit = GetTime(), verdicts[key]
	if hit and now - hit.at < VERDICT_SECONDS then return hit.yes end
	local yes = Nav.WouldCastTeleport(seller, target, t)
	if verdictCount >= VERDICT_MAX then verdicts, verdictCount = {}, 0 end
	if not hit then verdictCount = verdictCount + 1 end
	verdicts[key] = { at = now, yes = yes }
	return yes
end

local queue

-- The sellers worth a look for this route, target and zone, with what the planner says of each. Plans (estimates
-- in the per-frame budget: a busy frame tries again a moment later). -> true when surveyed
function RuneStop.Survey()
	survey = nil
	local T, X, near, C = Nav.travel, ns.Transit, Nav.nearby, ns.Compat
	if not (T and X and X.MissingRunes and near and near.Sellers) then return true end
	local target = Nav.GetTarget()
	if not (target and fliesAhead(Nav.GetRoute())) then return true end
	local missing = X.MissingRunes()
	if #missing == 0 then return true end
	local pc, px, py = C.GetPlayerWorldPosition()
	local zone = C.GetUnitZone and C.GetUnitZone("player")
	if not (pc and zone) then return true end
	local list = {}
	for _, t in ipairs(missing) do
		local places = near.Sellers(t.rune, pc)
		local reach = {}
		for _, p in ipairs(places or {}) do
			-- Twice the walk: a seller just out of reach comes into it as the player walks on.
			if p.map == zone then
				local yards = sqrt((p.wx - px) ^ 2 + (p.wy - py) ^ 2)
				if yards / RUN_SPEED <= 2 * MAX_WALK then reach[#reach + 1] = { place = p, yards = yards } end
			end
		end
		if #reach > 0 then
			sort(reach, function(a, b) return a.yards < b.yards end)
			local after, busy = Nav.EstimateTravel(t.to, target, true)
			if busy then queue(); return false end
			for k = 1, after and min(TRY, #reach) or 0 do
				local s = reach[k]
				local walk, wbusy = Nav.EstimateTravel(nil, s.place, true)
				if wbusy then queue(); return false end
				local straight = s.yards / RUN_SPEED
				local detour = (walk and straight > 3) and max(1, min(DETOUR_MAX, walk / straight)) or 1
				list[#list + 1] = { place = s.place, t = t, after = after, detour = detour }
			end
		end
	end
	if #list > 0 then survey = { target = target, zone = zone, list = list } end
	return true
end

-- The offer from the last survey, for where the player stands now. Plans nothing but the planner's yes or no for a
-- seller that clears the margin (kept, see plannerAgrees).
function RuneStop.Pick()
	if not survey then return nil end
	local T, C = Nav.travel, ns.Compat
	if ns.Get("behavior.whileHere") == false or ns.Get("behavior.whileHereVendors") == false then return nil end
	if T.teleportsBarred or Nav.Trip() or (InCombatLockdown and InCombatLockdown()) then return nil end
	if Nav.GetTarget() ~= survey.target then return nil end
	local legs, ci = Nav.GetRoute()
	if not fliesAhead(legs, ci) then return nil end
	local pc, px, py = C.GetPlayerWorldPosition()
	if not pc then return nil end
	if (C.GetUnitZone and C.GetUnitZone("player")) ~= survey.zone then
		queue() -- another zone: another set of sellers
		return nil
	end
	local base = legs[ci].seconds + (legs[ci].rest or 0)
	local need = max(T.TELEPORT_MARGIN, T.TELEPORT_SHARE * base)
	local best
	for _, c in ipairs(survey.list) do
		local p = c.place
		local yards = sqrt((p.wx - px) ^ 2 + (p.wy - py) ^ 2)
		local walk = yards / RUN_SPEED * c.detour
		local seconds = walk + BUY_SECONDS + c.t.cast + c.after
		local saves = base - seconds
		if walk <= MAX_WALK and saves >= need and (not best or saves > best.saves) then
			if c.yes == nil then c.yes = plannerAgrees(c.t, p, survey.target) end
		end
		if c.yes and walk <= MAX_WALK and saves >= need and (not best or saves > best.saves) then
			best = { seller = p, places = { p }, yards = yards, teleport = c.t, seconds = seconds, saves = saves }
		end
	end
	return best
end

function RuneStop.Find()
	RuneStop.Survey()
	return RuneStop.Pick()
end

-- While the player's click leads the arrow to the seller the route no longer
-- flies, so the line holds until a rune is in the bags (the bag change surveys
-- again). A fight changes nothing.
local function show(again)
	local E, X = ns.Engine, ns.Transit
	if not (E and E.SetRuneStop and X and X.MissingRunes) then return end
	if InCombatLockdown and InCombatLockdown() then return end
	if showing and E.RuneStopAimed and E.RuneStopAimed() and (not again or #X.MissingRunes() > 0) then return end
	if again then RuneStop.Survey() end
	local offer = RuneStop.Pick()
	if offer or showing then E.SetRuneStop(offer) end
	showing = offer ~= nil
end

function RuneStop.Refresh() show(true) end
local function tick() show(false) end

queue = function()
	if pending or ns.Hidden() or not (C_Timer and C_Timer.After) then return end
	pending = true
	ns.After(CHECK_DELAY, function()
		pending = false
		if not ns.Hidden() then RuneStop.Refresh() end
	end)
end

-- The tick runs only while Polestar shows: hidden, it has no line to show.
local function syncTicker()
	if ns.Hidden() then
		if ticker then
			ticker:Cancel()
			ticker = nil
		end
	else
		if not ticker and C_Timer and C_Timer.NewTicker then ticker = ns.NewTicker(TICK, tick) end
		queue()
	end
end

ns.On("ROUTE_CHANGED", queue)
ns.RegisterEvent("BAG_UPDATE_DELAYED", queue)
ns.On("POLESTAR_HIDDEN", syncTicker)
ns.OnLogin(syncTicker)
