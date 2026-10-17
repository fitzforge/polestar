-- Polestar's walking router: what a step costs on each kind of ground, for each faction.
-- Copyright (c) 2026 The Polestar authors. GPL-3.0-or-later, as the rest of this folder (LICENSE).
--
-- A map of format 2 carries a ground class byte per node (Routing/PathGrid.lua decodes it): bits 0-2 the base class
-- (CLASS), bit 3 inside an Alliance hub (hostile to Horde players), bit 4 inside a Horde hub (hostile to Alliance
-- players), bits 5-7 zero. A step into a node costs its length times Mult(its class, the player's profile, the route
-- style), times the map's swim factor in water (Routing/Path.lua). A map without classes (format 1) is class 0
-- everywhere: one cost for both profiles and every style. A packer writing format 2 prices the graph's edges by
-- Balanced's numbers (MULT, HUB): tune them together.
---@class SPFNamespace
local ns = select(2, ...)

---@class PolestarNavCosts
local Costs = {
	CLASS = { NORMAL = 0, ROAD = 1, GENTLE = 2, STEEP = 3, INDOOR = 4, CITY = 5 },
	HUB_ALLIANCE = 8,
	HUB_HORDE = 16,
	-- Balanced (the default, and what the packer bakes into the graph's edges), by base class: normal, road (a road
	-- way is taken up to 1 / 0.8 = 1.25 times longer), gentle slope, steep slope, indoor, indoor city (no penalty).
	-- Classes 6 and 7 are reserved and cost as normal ground.
	MULT = { [0] = 1.0, 0.8, 1.3, 2.5, 2.0, 1.0 },
	HUB = 20, -- a hostile hub, on top of its base class: kept out of, never closed
	MIN = 0.8, -- Balanced's smallest multiplier: the A* heuristic's factor, so it never overstates a remaining cost
}

-- The player's route style (nav.routeStyle): the multipliers of the grid's steps and the smallest of them. Graph
-- edges keep Balanced's baked costs in every style; the style prices every grid step (searches, connections,
-- refinement) and straightening. Fastest: the shortest walk (steep ground at 1.2 breaks near ties). Roads: a road
-- way is taken up to 1 / 0.5 = 2 times longer, and hills cost more.
Costs.STYLES = {
	fastest = { MULT = { [0] = 1.0, 1.0, 1.0, 1.2, 2.0, 1.0 }, MIN = 1.0 },
	balanced = { MULT = Costs.MULT, MIN = Costs.MIN },
	roads = { MULT = { [0] = 1.0, 0.5, 1.6, 4.0, 2.0, 1.0 }, MIN = 0.5 },
}

-- A style name: "fastest", "balanced" or "roads"; anything else (nil, an unknown name) is "balanced".
---@param style string?
---@return string
function Costs.Style(style)
	return Costs.STYLES[style] and style or "balanced"
end

-- The smallest multiplier of style.
---@param style string?
---@return number
function Costs.Min(style)
	return Costs.STYLES[Costs.Style(style)].MIN
end

-- The profile of a UnitFactionGroup value: "Alliance" or "Horde"; nil for anything else (no faction yet, neutral),
-- which prices no hub as hostile.
---@param faction string?
---@return string?
function Costs.Profile(faction)
	if faction == "Alliance" or faction == "Horde" then
		return faction
	end
	return nil
end

-- The multiplier of a step into a node of class classByte for profile, in style (nil: Balanced).
---@param classByte number
---@param profile string?
---@param style string?
---@return number
function Costs.Mult(classByte, profile, style)
	local mult = Costs.STYLES[Costs.Style(style)].MULT[classByte % 8] or 1.0
	local hub = classByte - classByte % 8
	local hostile = (profile == "Horde" and hub % 16 >= 8) or (profile == "Alliance" and hub % 32 >= 16)
	return hostile and mult * Costs.HUB or mult
end

ns.Costs = Costs
Polestar_NavCosts = Costs
