-- Boosted Rest status (qol.boostedRest, on by default): how long the
-- campfire's Boosted Rest lasts ("Boosted Rest: 42m", or "off") and, when
-- you carry the Cozy Sleeping Bag, its cooldown ("Sleeping bag ready" /
-- "Sleeping bag: 12m"), on the guide window's XP line. Party members'
-- Boosted Rest comes through party sync ("2B|", Quests/Party.lua) and shows
-- in the party panel.
--
--   Polestar.QoL.Rest.Left() -> seconds left, true (on, no end given) or nil (off)
--   Polestar.QoL.Rest.BagLeft() -> nil (no bag), 0 (ready) or seconds
--   Polestar.QoL.Rest.Parts(withOff) -> { text, ... } for the XP line; empty while
--     the setting is off. "Boosted Rest: off" only with `withOff` (the line
--     shows anyway), so it never makes the line appear by itself.
--   message QOL_REST_UPDATED(changed): changed true when Boosted Rest starts,
--     ends or is renewed, the bag's cooldown starts or ends, or the setting
--     moves; false for the minute redraws
--
-- The client is read on UNIT_AURA (player), BAG_UPDATE_COOLDOWN and
-- BAG_UPDATE_DELAYED, registered only while the setting is on. While a
-- minute count shows, one timer per minute redraws the line from the times
-- already read; it asks the client nothing.
--
-- Client: C_UnitAuras.GetPlayerAuraBySpellID (AuraData.expirationTime),
-- C_Container.GetItemCooldown and C_Item.GetItemCount through Compat
-- (Forever API docs: UnitAuraDocumentation, ContainerDocumentation).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local readable = ns.Compat.Readable

local type, ceil, format = type, math.ceil, string.format

local Rest = {}
QoL.Rest = Rest

Rest.SPELL = 1229451 -- Boosted Rest, from sitting by a campfire
Rest.BAG = 211527    -- Cozy Sleeping Bag
local GCD = 1.5      -- a cooldown this short is the global cooldown

local expires        -- GetTime() when Boosted Rest ends; true: on without an end; nil: off
local bagEnds        -- GetTime() when the bag's cooldown ends; 0: ready; nil: no bag

local function enabled() return QoL.On("boostedRest") end

local function readAura()
	local A = C_UnitAuras
	if not (A and A.GetPlayerAuraBySpellID) then return nil end
	local ok, aura = pcall(A.GetPlayerAuraBySpellID, Rest.SPELL)
	if not ok or type(aura) ~= "table" then return nil end
	local at = readable(aura.expirationTime)
	if type(at) == "number" and at > 0 then return at end
	return true
end

local function readBag()
	local C = ns.Compat
	if (C.GetItemCount(Rest.BAG) or 0) <= 0 then return nil end
	local start, duration = C.GetItemCooldown(Rest.BAG)
	if duration <= GCD then return 0 end
	local ends = start + duration
	return ends > GetTime() and ends or 0
end

function Rest.Left()
	if expires == true or expires == nil then return expires end
	local left = expires - GetTime()
	return left > 0 and left or nil
end

function Rest.BagLeft()
	if bagEnds == nil or bagEnds == 0 then return bagEnds end
	local left = bagEnds - GetTime()
	return left > 0 and left or 0
end

-- "42m" for minutes left, rounded up: 30 seconds still reads "1m".
local function minutes(left)
	if left >= 60 and QoL.Duration then return QoL.Duration(ceil(left / 60) * 60) end
	return format(L["%dm"], ceil(left / 60))
end
Rest.Minutes = minutes

local parts = {}
function Rest.Parts(withOff)
	for i = #parts, 1, -1 do parts[i] = nil end
	if not enabled() then return parts end
	local left = Rest.Left()
	if left == true then
		parts[1] = L["Boosted Rest: on"]
	elseif left then
		parts[1] = format(L["Boosted Rest: %s"], minutes(left))
	elseif withOff then
		parts[1] = L["Boosted Rest: off"]
	end
	local bag = Rest.BagLeft()
	if bag == 0 then
		parts[#parts + 1] = L["Sleeping bag ready"]
	elseif bag then
		parts[#parts + 1] = format(L["Sleeping bag: %s"], minutes(bag))
	end
	return parts
end

-- One redraw at the next whole minute of whichever count shows; a newer
-- schedule makes the older one a no-op.
local gen = 0
local function nextMinute()
	gen = gen + 1
	if not enabled() or not C_Timer then return end
	local soonest
	local left, bag = Rest.Left(), Rest.BagLeft()
	for _, s in ipairs({ type(left) == "number" and left or 0, bag or 0 }) do
		if s > 0 then
			local wait = s % 60
			if wait < 0.05 then wait = 60 end
			if not soonest or wait < soonest then soonest = wait end
		end
	end
	if not soonest then return end
	local mine = gen
	ns.After(soonest + 0.05, function()
		if mine ~= gen then return end
		ns.Fire("QOL_REST_UPDATED", false)
		nextMinute()
	end)
end

local function refresh(force)
	local e, b = enabled() and readAura() or nil, enabled() and readBag() or nil
	if not force and e == expires and b == bagEnds then return end
	expires, bagEnds = e, b
	ns.Fire("QOL_REST_UPDATED", true)
	nextMinute()
end
Rest.Refresh = refresh

QoL.WhileOn("boostedRest", "UNIT_AURA", function(_, unit)
	if unit == "player" then refresh(false) end
end)
QoL.WhileOn("boostedRest", "BAG_UPDATE_COOLDOWN", function() refresh(false) end)
QoL.WhileOn("boostedRest", "BAG_UPDATE_DELAYED", function() refresh(false) end)
ns.OnLogin(function() refresh(true) end)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.boostedRest" or path == "qol" or path == "" then refresh(true) end
end)
