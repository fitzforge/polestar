-- The Liminal Passage scroll (#4341): a Mage's Scroll of Liminal Passage teleports to a party member when both
-- stand in an inn or a city (the game's own words: "Both you and the target must be resting at an inn or city").
-- On a long trip, a Mage resting in an inn or city is offered two lines, as it fits:
--
--   "use"  carries a scroll, and a party member stands at an inn we know, from where the way to the target is so much
--          shorter than the way from here that the teleport clearly pays (the planner's margin for a class teleport).
--   "need" carries no scroll, nor keeps one in the bank: a scroll bought at the auction house would shorten trips
--          like this one. (UI/LiminalCard.lua adds the auctioneer: it says so only where one is near.)
--
-- It only suggests: the route is the planner's as ever, and the player casts the scroll. Nothing is bought or cast.
-- A trip is "long" when the way ahead takes at least the Hearthstone's HEARTH_MIN_TRIP. A member is taken to rest when
-- they stand within INN_NEAR yards of a known inn (Nav.InnNear); a member elsewhere in a city is not counted, so
-- the line is never wrong about who the scroll can reach.
--
--   Liminal.Find() -> offer | nil
--     offer = { kind = "use", member = first name, inn = inn name, seconds, saves, target } | { kind = "need", base, target }
--   Liminal.Refresh()  finds the offer now and fires LIMINAL_OFFER (offer | nil, once, when it goes)
--
-- The planning is done when the route, the bags, the group or the resting state change, and every TICK seconds while a
-- Mage rests (a member walks into an inn without any of those): estimates are cached, so a tick costs little.

local ADDON, ns = ...
local Nav = ns.Nav

local Liminal = {}
Nav.liminal = Liminal

ns.RegisterDefaults("nav", { liminalScroll = true })

local ipairs, max = ipairs, math.max

Liminal.ITEM = 213548  -- Scroll of Liminal Passage
Liminal.SPELL = 434752 -- its Use spell
Liminal.CAST = 6       -- seconds: the 1 s cast and the loading screen
Liminal.INN_NEAR = 60  -- yards: as near an inn as a bound inn is matched (Travel's BIND_MATCH)
local CHECK_DELAY = 1  -- seconds after a change: they come in bursts
local TICK = 10        -- seconds between looks while a Mage rests

local pending, ticker = false, nil
local current, wasOffered -- the offer found last, and whether it was handed on

local function isMage()
	local _, class = nil, nil
	if UnitClass then _, class = UnitClass("player") end
	return class == "MAGE"
end

local function scrolls(withBank)
	local C = ns.Compat
	return C and C.GetItemCount and C.GetItemCount(Liminal.ITEM, withBank) or 0
end

-- The seconds the way ahead takes, or nil: no target, no route, route planning or class teleports off, or a moment
-- when no teleport is wanted (a ghost, a quest timer, a field goal).
local function wayAhead()
	local T = Nav.travel
	if not (T and Nav.GetTarget() and ns.Get("nav.travel") and ns.Get("nav.teleports")) or T.teleportsBarred then return nil end
	local legs, ci = Nav.GetRoute()
	local leg = legs and legs[ci]
	return leg and (leg.seconds + (leg.rest or 0)) or nil
end

-- The party members who stand at a known inn: { unit, name, inn, point = the place as a travel end }.
local function membersAtInns()
	local C, list = ns.Compat, {}
	for i = 1, GetNumSubgroupMembers and GetNumSubgroupMembers() or 0 do
		local unit = "party" .. i
		if not (UnitIsConnected and not UnitIsConnected(unit)) then
			local map, x, y = C.GetUnitMapPosition(unit)
			local c, wx, wy
			if map then c, wx, wy = C.MapToWorld(map, x, y) end
			local inn = c and Nav.InnNear(c, wx, wy, Liminal.INN_NEAR)
			local _, name = C.UnitFullName(unit)
			if inn and name then
				list[#list + 1] = { unit = unit, name = name, inn = inn, point = { c = c, wx = wx, wy = wy, map = map, x = x, y = y } }
			end
		end
	end
	return list
end

-- The best member to travel to, or nil; "busy" while the planner's budget for this frame is spent.
local function bestMember(base, target)
	local T = Nav.travel
	local need = max(T.TELEPORT_MARGIN, T.TELEPORT_SHARE * base)
	local best
	for _, m in ipairs(membersAtInns()) do
		local after, busy = Nav.EstimateTravel(m.point, target, true)
		if busy then return "busy" end
		local seconds = after and (Liminal.CAST + after)
		if seconds and base - seconds >= need and (not best or seconds < best.seconds) then
			best = { kind = "use", member = m.name, inn = Nav.travel.PlaceName(m.inn), seconds = seconds, saves = base - seconds, target = target }
		end
	end
	return best
end

local queue

-- -> offer | nil; false when the planner is busy and the look is queued again.
function Liminal.Find()
	if not ns.Get("nav.liminalScroll") or not isMage() or not (IsResting and IsResting()) then return nil end
	if InCombatLockdown and InCombatLockdown() then return nil end
	local base = wayAhead()
	if not base or base < Nav.HEARTH_MIN_TRIP then return nil end
	if scrolls(false) > 0 then
		local best = bestMember(base, Nav.GetTarget())
		if best == "busy" then
			queue()
			return false
		end
		return best
	end
	if scrolls(true) == 0 then return { kind = "need", base = base, target = Nav.GetTarget() } end
	return nil
end

-- Finds the offer and hands it on: every look that finds one fires LIMINAL_OFFER (UI/LiminalCard.lua tells it once),
-- and the first look that finds none fires it with nil.
function Liminal.Refresh()
	local offer = Liminal.Find()
	if offer == false then return end
	current = offer
	if offer or wasOffered then ns.Fire("LIMINAL_OFFER", offer) end
	wasOffered = offer ~= nil
end

function Liminal.Current() return current end

queue = function()
	if pending or ns.Hidden() or not (C_Timer and C_Timer.After) then return end
	pending = true
	ns.After(CHECK_DELAY, function()
		pending = false
		if not ns.Hidden() then Liminal.Refresh() end
	end)
end

-- The tick runs only while Polestar shows, for a Mage: nobody else has a scroll to use.
local function syncTicker()
	if ns.Hidden() or not isMage() then
		if ticker then
			ticker:Cancel()
			ticker = nil
		end
	else
		if not ticker and C_Timer and C_Timer.NewTicker then ticker = ns.NewTicker(TICK, queue) end
		queue()
	end
end

ns.On("ROUTE_CHANGED", queue)
ns.On("SETTING_CHANGED", queue)
for _, event in ipairs({ "BAG_UPDATE_DELAYED", "GROUP_ROSTER_UPDATE", "PLAYER_UPDATE_RESTING" }) do ns.RegisterEvent(event, queue) end
ns.On("POLESTAR_HIDDEN", syncTicker)
ns.OnLogin(syncTicker)
