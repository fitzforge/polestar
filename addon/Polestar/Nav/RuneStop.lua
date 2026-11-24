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
--   RuneStop.Find() -> offer | nil
--     offer = { seller = place, places = { place }, yards, teleport, seconds, saves }
--   RuneStop.Refresh()  hands the Engine the offer there is now

local ADDON, ns = ...
local Nav = ns.Nav

local RuneStop = {}
Nav.runeStop = RuneStop

local ipairs, sqrt, sort, format = ipairs, math.sqrt, table.sort, string.format

local MAX_WALK = 120   -- seconds to the seller: in a wide zone, further is another trip
local TRY = 3          -- sellers, closest first, worth a travel estimate on each check
local BUY_SECONDS = 10 -- opening the vendor and buying one
local RUN_SPEED = 7
local CHECK_DELAY = 1  -- seconds after a route or bag change: they come in bursts
local TICK = 3         -- seconds: walking up to a seller changes no route

local VERDICT_SECONDS = 15 -- how long the planner's answer for one seller and target is kept
local VERDICT_MAX = 32

local pending, showing, ticker = false, false, nil
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

-- The sellers in `zone` that a straight run could reach in MAX_WALK, closest first.
local function inReach(places, zone, px, py)
	local out = {}
	for _, p in ipairs(places) do
		if p.map == zone then
			local yards = sqrt((p.wx - px) ^ 2 + (p.wy - py) ^ 2)
			if yards / RUN_SPEED <= MAX_WALK then out[#out + 1] = { place = p, yards = yards } end
		end
	end
	sort(out, function(a, b) return a.yards < b.yards end)
	return out
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
	local zone = C.GetUnitZone and C.GetUnitZone("player")
	if not zone then return nil end
	local base = legs[ci].seconds + (legs[ci].rest or 0)
	local need = math.max(T.TELEPORT_MARGIN, T.TELEPORT_SHARE * base)
	local best
	for _, t in ipairs(missing) do
		local places = near.Sellers(t.rune, pc)
		local after = places and Nav.EstimateTravel(t.to, target)
		if after then
			for k, s in ipairs(inReach(places, zone, px, py)) do
				if k > TRY then break end
				local walk = Nav.EstimateTravel(nil, s.place) or s.yards / RUN_SPEED
				local seconds = walk + BUY_SECONDS + t.cast + after
				local saves = base - seconds
				if walk <= MAX_WALK and saves >= need and (not best or saves > best.saves) and plannerAgrees(t, s.place, target) then
					best = { seller = s.place, places = { s.place }, yards = s.yards, teleport = t, seconds = seconds, saves = saves }
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
	if pending or ns.Hidden() or not (C_Timer and C_Timer.After) then return end
	pending = true
	ns.After(CHECK_DELAY, function()
		pending = false
		if not ns.Hidden() then RuneStop.Refresh() end
	end)
end

-- The poll runs only while Polestar shows: hidden, it has no line to show.
local function syncTicker()
	if ns.Hidden() then
		if ticker then
			ticker:Cancel()
			ticker = nil
		end
	elseif not ticker and C_Timer and C_Timer.NewTicker then
		ticker = ns.NewTicker(TICK, RuneStop.Refresh)
	end
end

ns.On("ROUTE_CHANGED", queue)
ns.RegisterEvent("BAG_UPDATE_DELAYED", queue)
ns.On("POLESTAR_HIDDEN", syncTicker)
ns.OnLogin(syncTicker)
