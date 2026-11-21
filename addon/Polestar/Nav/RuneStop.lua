-- The rune stop (#3547): a Mage with no Rune of Teleportation, on a route that
-- flies, near a vendor who sells the rune, sees that stop in While you're here
-- when walking there, buying one and teleporting clearly beats the route.
--
-- It only suggests (Engine.SetRuneStop makes the line; a click points the arrow
-- at the vendor, as a sell or repair line's does) and buys nothing. Once a rune
-- is in the bags the line goes, Transit.Teleports lists the teleport again and
-- the planner weighs it as it always does.
--
--   RuneStop.Find() -> offer | nil
--     offer = { seller = place, places = { place }, yards, teleport, seconds, saves }
--   RuneStop.Refresh()  hands the Engine the offer there is now

local ADDON, ns = ...
local Nav = ns.Nav

local RuneStop = {}
Nav.runeStop = RuneStop

local ipairs, sqrt = ipairs, math.sqrt

local NEAR = 150       -- yards, straight: a seller this close counts as nearby
local BUY_SECONDS = 10 -- opening the vendor and buying one
local RUN_SPEED = 7
local CHECK_DELAY = 1  -- seconds after a route or bag change: they come in bursts
local TICK = 3         -- seconds: walking up to a seller changes no route

local pending, showing = false, false

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

local function nearest(places, px, py)
	local best, bestD
	for _, p in ipairs(places) do
		local d = (p.wx - px) ^ 2 + (p.wy - py) ^ 2
		if d <= NEAR * NEAR and (not bestD or d < bestD) then best, bestD = p, d end
	end
	if best then return best, sqrt(bestD) end
end

function RuneStop.Find()
	local T, X, near, C = Nav.travel, ns.Transit, Nav.nearby, ns.Compat
	if not (T and X and X.MissingRunes and near and near.Sellers) then return nil end
	if ns.Get("behavior.whileHere") == false or ns.Get("behavior.whileHereVendors") == false then return nil end
	if T.teleportsBarred or Nav.Trip() or (InCombatLockdown and InCombatLockdown()) then return nil end
	local target = Nav.GetTarget()
	if not target then return nil end
	local legs, ci = Nav.GetRoute()
	if not fliesAhead(legs, ci) then return nil end
	local missing = X.MissingRunes()
	if #missing == 0 then return nil end
	local pc, px, py = C.GetPlayerWorldPosition()
	if not pc then return nil end
	local base = legs[ci].seconds + (legs[ci].rest or 0)
	local need = math.max(T.TELEPORT_MARGIN, T.TELEPORT_SHARE * base)
	local best
	for _, t in ipairs(missing) do
		local places = near.Sellers(t.rune, pc)
		local seller, yards
		if places then seller, yards = nearest(places, px, py) end
		if seller then
			local walk = Nav.EstimateTravel(nil, seller) or yards / RUN_SPEED
			local after = Nav.EstimateTravel(t.to, target)
			if after then
				local seconds = walk + BUY_SECONDS + t.cast + after
				local saves = base - seconds
				if saves >= need and (not best or saves > best.saves) then
					best = { seller = seller, places = { seller }, yards = yards, teleport = t, seconds = seconds, saves = saves }
				end
			end
		end
	end
	return best
end

-- While the player's click leads the arrow to the seller the route no longer
-- flies, so the line holds until a rune is in the bags. A fight changes nothing.
function RuneStop.Refresh()
	local E, X = ns.Engine, ns.Transit
	if not (E and E.SetRuneStop and X and X.MissingRunes) then return end
	if InCombatLockdown and InCombatLockdown() then return end
	if showing and E.RuneStopAimed and E.RuneStopAimed() and #X.MissingRunes() > 0 then return end
	local offer = RuneStop.Find()
	if offer or showing then E.SetRuneStop(offer) end
	showing = offer ~= nil
end

local function queue()
	if pending or not (C_Timer and C_Timer.After) then return end
	pending = true
	C_Timer.After(CHECK_DELAY, function()
		pending = false
		ns.SafeCall(RuneStop.Refresh)
	end)
end

ns.On("ROUTE_CHANGED", queue)
ns.RegisterEvent("BAG_UPDATE_DELAYED", queue)
ns.OnLogin(function()
	if C_Timer and C_Timer.NewTicker then
		C_Timer.NewTicker(TICK, function() ns.SafeCall(RuneStop.Refresh) end)
	end
end)
