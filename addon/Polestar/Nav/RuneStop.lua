-- The rune stop (#3547): a Mage with no Rune of Teleportation, on a route that
-- flies, standing near a vendor who sells the rune, is offered that stop when
-- walking there, buying one and teleporting clearly beats the route.
--
-- It only offers. Accepting points the arrow at the vendor as a trip
-- (Nav.StartTrip), which hands the arrow back to the guide on arrival; nothing
-- is bought for the player. Once a rune is in the bags Transit.Teleports lists
-- the teleport again and the planner weighs it as it always does.
--
--   RuneStop.Find() -> offer | nil
--     offer = { key, seller = place, yards, teleport, seconds, saves }
--   RuneStop.Check()  shows the offer, once per target

local ADDON, ns = ...
local L = ns.L
local Nav = ns.Nav

local RuneStop = {}
Nav.runeStop = RuneStop

local ipairs, format, sqrt = ipairs, string.format, math.sqrt

local NEAR = 150      -- yards, straight: a seller this close counts as nearby
local BUY_SECONDS = 10 -- opening the vendor and buying one
local RUN_SPEED = 7
local CHECK_DELAY = 1 -- seconds after a route change: routes change in bursts
local POPUP = "POLESTAR_RUNE_STOP"

local asked = {} -- target key -> true: offered once, whatever the answer
local pending = false

local function targetKey(t)
	return format("%s:%.1f:%.1f", tostring(t.map), t.x or 0, t.y or 0)
end

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
	if T.teleportsBarred or Nav.Trip() or (InCombatLockdown and InCombatLockdown()) then return nil end
	local target = Nav.GetTarget()
	if not target then return nil end
	local key = targetKey(target)
	if asked[key] then return nil end
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
					best = { key = key, seller = seller, yards = yards, teleport = t, seconds = seconds, saves = saves }
				end
			end
		end
	end
	return best
end

-- Points the arrow at the seller, as a trip that ends on arrival.
function RuneStop.Accept(offer)
	local p = offer.seller
	local t = Nav.SetTarget(p.map, p.x, p.y, p.name, p.f, nil, p.z)
	if t then Nav.StartTrip(t, p.name, L["Rune of Teleportation"]) end
	return t and true or false
end

local function show(offer)
	if ns.GamepadUI() or not (StaticPopupDialogs and StaticPopup_Show) then return false end
	StaticPopupDialogs[POPUP] = StaticPopupDialogs[POPUP] or {
		text = "%s",
		button1 = L["Go to vendor"],
		button2 = L["Keep my route"],
		OnAccept = function(_, data) RuneStop.Accept(data) end,
		timeout = 0,
		whileDead = false,
		hideOnEscape = true,
		preferredIndex = 3,
	}
	local Q = ns.QoL
	local saves = Q and Q.Duration and Q.Duration(offer.saves) or format("%d", offer.saves)
	local text = format(L["Buy a Rune of Teleportation from %s (%d yd), then cast %s? Saves about %s."],
		offer.seller.name, offer.yards + 0.5, offer.teleport.name, saves)
	StaticPopup_Show(POPUP, text, nil, offer)
	return true
end

function RuneStop.Check()
	local offer = RuneStop.Find()
	if not offer then return false end
	asked[offer.key] = true
	return show(offer)
end

local function queue()
	if pending then return end
	if not (C_Timer and C_Timer.After) then return end
	pending = true
	C_Timer.After(CHECK_DELAY, function()
		pending = false
		ns.SafeCall(RuneStop.Check)
	end)
end

ns.On("ROUTE_CHANGED", queue)
