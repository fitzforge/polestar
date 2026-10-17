-- Nav's own pins, drawn through Polestar.Pins:
--   nav.target  the point being guided to (world map + minimap, clamped to the rim); an
--               area target that is not a guide goal's also shows its area as a soft disc
--   nav.route   where the travel route changes mode: flight masters, docks, the inn (world map)
--   nav.goals   the current step's other open goals; click one to point the arrow there (world map)
--   nav.spots   the target's other spawn places, small marks (other places it spawns fainter);
--               click one to search there next (world map)
--   nav.areas   the regions the target's goal spawns in, in the arrow's colour (world
--               map + minimap)
--   nav.goalAreas  the regions the step's other open goals spawn in, fainter, in the
--               goals' colour (world map)
-- and the trail (Pins.SetTrail): dots from the player along the travel route's lines (each
-- leg's start where the mode changes, and its end), broken at a Hearthstone (a jump, not a
-- path) and across continents; without a route, straight to the target (both surfaces).
-- nav.worldPins / nav.minimapPins switch Nav's layers on each surface; nav.trailDots the trail,
-- which stands in only while Maps/RouteLines.lua draws no route (nav.routeLines off).

local ADDON, ns = ...
local Nav = ns.Nav
local Pins = ns.Pins
local L = ns.L

local format = string.format

local Layers = {}
Nav.layers = Layers

local TARGET, ROUTE, GOALS, SPOTS = "nav.target", "nav.route", "nav.goals", "nav.spots"
local AREAS, GOAL_AREAS = "nav.areas", "nav.goalAreas"

local function color(name)
	local r, g, b = Nav.RGB(name)
	return { r, g, b, 1 }
end

local function targetTooltip(tip)
	local target = Nav.GetTarget()
	if not target then return end
	tip:SetText(target.label or "")
	local dist = Nav.GetDistance()
	if dist then tip:AddLine(ns.FormatDistance(dist), 1, 1, 1) end
end

-- The compiled guide goal the target was picked from, if any.
local function goalOf(target)
	local Engine = ns.Engine
	local guide = target and target.stepIndex and Engine and Engine.GetGuide and Engine.GetGuide()
	local step = guide and guide.steps and guide.steps[target.stepIndex]
	return step and step.goals and step.goals[target.goalIndex] or nil
end

local function updateTarget(world, minimap)
	local target = Nav.GetTarget()
	if not target then
		Pins.ClearLayer(TARGET)
		return
	end
	-- A guide goal's spawn areas are its regions (nav.areas), which cover the
	-- spot the target sits in; any other area target shows its own disc.
	local goal = target.area and goalOf(target)
	local area = not (goal and goal.spots) and target.area or nil
	-- The target wears the arrow's colour (Theme "arrow": the accent unless
	-- the player picked their own), so map and arrow agree.
	Pins.SetLayer(TARGET, {
		{ map = target.map, x = target.x, y = target.y, f = target.f, color = color("arrow"), glow = true,
			area = area, tooltip = targetTooltip, priority = 100 },
	}, { world = world, minimap = minimap, edge = true, scale = 1.4, minimapAreas = true })
end

-- Every other spot of the target's spawn places, so the player sees where
-- else it may be and can pick where to look next; the other places it spawns
-- (`alt`, never picked by the arrow on its own) are marked fainter.
local function updateSpots(world)
	local target = Nav.GetTarget()
	local spots = world and target and target.spots
	if not spots then
		Pins.ClearLayer(SPOTS)
		return
	end
	local pins, n, label = {}, #spots, target.label
	local r, g, b = Nav.RGB("arrow")
	for i, s in ipairs(spots) do
		if i ~= target.spot then
			local alt = s.alt
			pins[#pins + 1] = {
				map = target.map, x = s.x, y = s.y, f = target.f, color = { r, g, b, alt and 0.5 or 0.75 },
				size = alt and 7 or 9, priority = alt and 15 or 20,
				tooltip = function(tip)
					tip:SetText(label or "")
					tip:AddLine(format(L["Spot %d of %d"], i, n), 0.7, 0.7, 0.7)
					if alt then tip:AddLine(L["It also spawns here"], 0.7, 0.7, 0.7) end
					tip:AddLine(L["Click to search here next"], 0.7, 0.7, 0.7)
				end,
				onClick = function(button)
					if button == "LeftButton" then Nav.NextSpot(i) end
				end,
			}
		end
	end
	Pins.SetLayer(SPOTS, pins, { world = true, minimap = false })
end

-- A leg that ends at a chokepoint (leg.choke = { kind, name }, Travel.lua)
-- marks it with its glyph; other stops are plain discs.
local CHOKE_ICON = {
	lift = "icon-lift", gate = "icon-gate", building = "icon-gate", bridge = "icon-bridge",
	cave = "icon-cave", tunnel = "icon-cave", pass = "icon-pass",
}

local function updateRoute(world)
	local legs, ci
	if Nav.GetRoute then legs, ci = Nav.GetRoute() end
	if not (world and legs and #legs > 1) then
		Pins.ClearLayer(ROUTE)
		return
	end
	local pins = {}
	for i = ci, #legs - 1 do
		local to, nextLeg, choke = legs[i].to, legs[i + 1], legs[i].choke
		local icon = type(choke) == "table" and CHOKE_ICON[choke.kind] or nil
		local place = icon and choke.name
		local step = format(L["Travel route, step %s"], i .. "/" .. #legs)
		pins[#pins + 1] = {
			c = to.c, wx = to.wx, wy = to.wy, color = color("arrow"), priority = 50,
			icon = icon, backdrop = icon and true or nil,
			label = nextLeg.label, step = i,
			tooltip = function(tip)
				tip:SetText(nextLeg.label or "")
				if place then tip:AddLine(place, 1, 1, 1) end
				tip:AddLine(step, 0.7, 0.7, 0.7)
			end,
		}
	end
	Pins.SetLayer(ROUTE, pins, { world = true, minimap = false, scale = 0.9 })
end

local function updateGoals(world)
	local Engine = ns.Engine
	local index = world and Engine and Engine.GetStepIndex and Engine.GetStepIndex()
	local view = index and Engine.GetStepView and Engine.GetStepView(index)
	if not (view and view.goals) then
		Pins.ClearLayer(GOALS)
		return
	end
	local target = Nav.GetTarget()
	local pins = {}
	for _, goal in ipairs(view.goals) do
		if goal.map and goal.x and goal.y and (goal.status == "active" or goal.status == "pending")
			and not (target and target.map == goal.map and target.x == goal.x and target.y == goal.y) then
			local text = goal.text
			pins[#pins + 1] = {
				map = goal.map, x = goal.x, y = goal.y, f = goal.f, color = color("place"), priority = 10,
				label = text,
				tooltip = function(tip)
					tip:SetText(text or "")
					tip:AddLine(L["Click to point the arrow here"], 0.7, 0.7, 0.7)
				end,
				onClick = function(button)
					if button == "LeftButton" then Nav.SetTarget(goal.map, goal.x, goal.y, text, goal.f, nil, goal.z) end
				end,
			}
		end
	end
	if #pins == 0 then
		Pins.ClearLayer(GOALS)
	else
		Pins.SetLayer(GOALS, pins, { world = true, minimap = false })
	end
end

-- Spawn regions: the places a goal's mobs or objects spawn (compiled
-- `spots`: centres with the radius that covers their spawns) grouped into
-- regions, each the convex hull of its spots' discs (REGION_PAD wider) as a
-- REGION_SIDES-gon around it. Spots whose discs come within REGION_LINK yards
-- of each other join, nearest first, while the region stays at most
-- REGION_MAX_SPAN across: where the player hunts, not one camp at a time, and
-- a long coast of spawns is a chain of regions, not one hull over the sea.
-- Every polygon side is tangent to the hull, so the polygon covers every
-- spawn. Built once per goal (the compiled guide never changes):
-- regions = { { c, wx, wy (its centre), hull = { wx1, wy1, ... }, n (spawns), alt (only
-- places the arrow does not pick by itself) }, ... }, nil without spots or a map frame.
-- A region narrower than REGION_SMALL yards is an 8-gon (a handful of pixels
-- on the world map), the others REGION_SIDES-gons.
local REGION_SIDES, REGION_SMALL = 16, 200
local REGION_LINK = 90
local REGION_MAX_SPAN = 700
local REGION_PAD = 10
local REGION_MIN_RADIUS = 15
local regionCache = setmetatable({}, { __mode = "k" })
local sides = {}
for _, k in ipairs({ 8, REGION_SIDES }) do
	local t = { n = k, cos = {}, sin = {}, det = math.sin(2 * math.pi / k) }
	for i = 1, k do
		local a = 2 * math.pi * (i - 1) / k
		t.cos[i], t.sin[i] = math.cos(a), math.sin(a)
	end
	sides[k] = t
end

-- The polygon whose sides touch the hull of the discs (members of cs, xs,
-- ys, rs listed in group, span yards across) from outside.
local function regionOf(group, span, cs, xs, ys, rs, spots)
	local t = sides[span < REGION_SMALL and 8 or REGION_SIDES]
	local K, cosK, sinK = t.n, t.cos, t.sin
	local h = {}
	for k = 1, K do
		local ux, uy, best = cosK[k], sinK[k], -math.huge
		for _, i in ipairs(group) do
			local v = xs[i] * ux + ys[i] * uy + rs[i]
			if v > best then best = v end
		end
		h[k] = best
	end
	-- Corner k: where side k meets side k + 1.
	local hull, sx, sy, m = {}, 0, 0, 0
	for k = 1, K do
		local j = k % K + 1
		local x = (h[k] * sinK[j] - h[j] * sinK[k]) / t.det
		local y = (h[j] * cosK[k] - h[k] * cosK[j]) / t.det
		if m == 0 or math.abs(x - hull[2 * m - 1]) > 0.5 or math.abs(y - hull[2 * m]) > 0.5 then
			m = m + 1
			hull[2 * m - 1], hull[2 * m] = x, y
			sx, sy = sx + x, sy + y
		end
	end
	local n, alt = 0, true
	for _, i in ipairs(group) do
		n = n + (tonumber(spots[i].n) or 0)
		if not spots[i].alt then alt = false end
	end
	return { c = cs[group[1]], wx = sx / m, wy = sy / m, hull = hull, n = n, alt = alt }
end

local function regionsOf(goal)
	local cached = regionCache[goal]
	if cached ~= nil then return cached or nil end
	local C = ns.Compat
	local spots = goal.spots
	if not (C and C.MapToWorld and type(spots) == "table" and goal.map) then return nil end
	local cs, xs, ys, rs = {}, {}, {}, {}
	local groupOf, members, span = {}, {}, {}
	for i, s in ipairs(spots) do
		local c, wx, wy = C.MapToWorld(goal.map, s.x, s.y, goal.f)
		if not c then return nil end -- not resolvable yet: try again later
		cs[i], xs[i], ys[i] = c, wx, wy
		rs[i] = math.max(tonumber(s.r) or 0, REGION_MIN_RADIUS) + REGION_PAD
		groupOf[i], members[i], span[i] = i, { i }, 2 * rs[i]
	end
	local function across(i, j)
		local dx, dy = xs[i] - xs[j], ys[i] - ys[j]
		return math.sqrt(dx * dx + dy * dy) + rs[i] + rs[j]
	end
	-- Pairs close enough to join, nearest (smallest gap between discs) first:
	-- a sweep along wx (no pair further apart than the widest reach), each
	-- pair one number (the gap in hundredths of a yard, then i, then j), so
	-- the sort compares plain numbers.
	local n, order, maxR = #spots, {}, 0
	for i = 1, n do
		order[i] = i
		if rs[i] > maxR then maxR = rs[i] end
	end
	table.sort(order, function(a, b)
		if xs[a] ~= xs[b] then return xs[a] < xs[b] end
		return a < b
	end)
	local reach, B, bias = 2 * maxR + REGION_LINK, n + 1, math.ceil(2 * maxR * 100) + 1
	local near = {}
	for a = 1, n do
		local i = order[a]
		for b = a + 1, n do
			local j = order[b]
			if xs[j] - xs[i] > reach then break end
			if cs[i] == cs[j] then
				local gap = across(i, j) - 2 * (rs[i] + rs[j])
				if gap <= REGION_LINK then
					local lo, hi = math.min(i, j), math.max(i, j)
					near[#near + 1] = (math.floor(gap * 100 + 0.5) + bias) * B * B + lo * B + hi
				end
			end
		end
	end
	table.sort(near)
	-- Groups found too wide together stay apart: groups only grow.
	local apart = {}
	local function keepApart(a, b)
		apart[a] = apart[a] or {}
		apart[b] = apart[b] or {}
		apart[a][b], apart[b][a] = true, true
	end
	for _, key in ipairs(near) do
		local a, b = groupOf[math.floor(key / B) % B], groupOf[key % B]
		if a ~= b and not (apart[a] and apart[a][b]) then
			local s = math.max(span[a], span[b])
			for _, i in ipairs(members[a]) do
				for _, j in ipairs(members[b]) do
					local d = across(i, j)
					if d > s then s = d end
				end
				if s > REGION_MAX_SPAN then break end
			end
			if s <= REGION_MAX_SPAN then
				if a > b then a, b = b, a end
				for _, j in ipairs(members[b]) do
					groupOf[j] = a
					table.insert(members[a], j)
				end
				members[b], span[a] = nil, s
				for c in pairs(apart[b] or {}) do keepApart(a, c) end
			else
				keepApart(a, b)
			end
		end
	end
	local regions = {}
	for i = 1, #spots do
		local group = members[i]
		if group then
			table.sort(group)
			regions[#regions + 1] = regionOf(group, span[i], cs, xs, ys, rs, spots)
		end
	end
	regionCache[goal] = regions
	return regions
end
Layers.Regions = regionsOf

-- The spawn regions of the step's open goals. The target's goal's wear the
-- arrow's colour on both surfaces; the other goals', fainter in their pins'
-- colour, show only on the world map, so the minimap stays about where the
-- arrow leads. Regions of only the other places a target spawns (`alt`) are
-- fainter still. The layers are set again only when what they show changed
-- (another step, goal opened or closed, the arrow on another goal, colours,
-- surfaces), so a route or progress update redraws nothing.
local shownSig = {}

local function sameSig(sig)
	if #sig ~= #shownSig then return false end
	for i = 1, #sig do
		if sig[i] ~= shownSig[i] then return false end
	end
	return true
end

local function updateAreas(world, minimap)
	local Engine = ns.Engine
	local index = (world or minimap) and Engine and Engine.GetStepIndex and Engine.GetStepIndex()
	local view = index and Engine.GetStepView and Engine.GetStepView(index)
	local guide = view and view.goals and Engine.GetGuide and Engine.GetGuide()
	local step = guide and guide.steps and guide.steps[index]
	local ar, ag, ab = Nav.RGB("arrow")
	local pr, pg, pb = Nav.RGB("place")
	local sig = { world, minimap, ar, ag, ab, pr, pg, pb }
	local shown = {} -- goal regions, then whether they are the target's goal's
	if step then
		local target = Nav.GetTarget()
		local tg = target and target.stepIndex == index and target.goalIndex or nil
		for _, v in ipairs(view.goals) do
			local goal = (v.status == "active" or v.status == "pending") and step.goals and step.goals[v.index]
			local regions = goal and goal.map and goal.spots and regionsOf(goal)
			if regions then
				shown[#shown + 1], shown[#shown + 2] = regions, v.index == tg
				sig[#sig + 1], sig[#sig + 2] = regions, v.index == tg
			end
		end
	end
	if sameSig(sig) then return end
	shownSig = sig
	local own, others = {}, {}
	for i = 1, #shown, 2 do
		local mine = shown[i + 1]
		local list = mine and own or others
		for _, rg in ipairs(shown[i]) do
			list[#list + 1] = {
				c = rg.c, wx = rg.wx, wy = rg.wy, hull = rg.hull, areaOnly = true,
				color = mine and { ar, ag, ab, rg.alt and 0.6 or 1 } or { pr, pg, pb, rg.alt and 0.35 or 0.6 },
			}
		end
	end
	if #own > 0 then
		Pins.SetLayer(AREAS, own, { world = world, minimap = minimap, minimapAreas = true })
	else
		Pins.ClearLayer(AREAS)
	end
	if world and #others > 0 then
		Pins.SetLayer(GOAL_AREAS, others, { world = true, minimap = false })
	else
		Pins.ClearLayer(GOAL_AREAS)
	end
end

-- The trail's runs: the player, then from the current leg on each leg's start
-- (unless it walks there) and end; a Hearthstone starts a new run at the inn.
-- Route lines, when they draw, show the way instead; Shortest Path Forever's
-- own line does while the target is handed to it (Nav/Handoff.lua).
local function updateTrail(world, minimap)
	local target = Nav.GetTarget()
	local lines = ns.RouteLines and ns.RouteLines.Active()
	if lines or Nav.HandedOff() or not (target and ns.Get("nav.trailDots") and (world or minimap)) then
		Pins.ClearTrail()
		return
	end
	local run = { live = true }
	local runs = { run }
	local legs, ci
	if Nav.GetRoute then legs, ci = Nav.GetRoute() end
	if legs and ci and legs[ci] then
		for i = ci, #legs do
			local leg = legs[i]
			if leg.kind == "hearth" then
				run = { leg.to }
				runs[#runs + 1] = run
			else
				if leg.kind ~= "walk" then run[#run + 1] = leg.from end
				run[#run + 1] = leg.to
			end
		end
	else
		local c, wx, wy = Nav.GetTargetWorld()
		if not c then
			Pins.ClearTrail()
			return
		end
		run[1] = { c = c, wx = wx, wy = wy }
	end
	Pins.SetTrail(runs, { world = world, minimap = minimap, color = color("arrow") })
end

local function surfaces()
	return ns.Get("nav.worldPins") and true or false, ns.Get("nav.minimapPins") and true or false
end

function Layers.Update()
	local world, minimap = surfaces()
	updateTarget(world, minimap)
	updateRoute(world)
	updateGoals(world)
	updateSpots(world)
	updateAreas(world, minimap)
	updateTrail(world, minimap)
end

-- The route moved on to its next leg: its stops and trail start there.
local function onAdvanced()
	local world, minimap = surfaces()
	updateRoute(world)
	updateTrail(world, minimap)
end

Layers.OnTarget = Layers.Update
Layers.OnSettings = Layers.Update
Layers.OnTheme = Layers.Update

ns.On("STEP_UPDATED", Layers.Update)
ns.On("ROUTE_CHANGED", Layers.Update)
ns.On("ROUTE_ADVANCED", onAdvanced)
ns.On("NAV_ROUTE_GEOMETRY", function()
	local world, minimap = surfaces()
	updateTrail(world, minimap)
end)

Nav.RegisterModule(Layers)
