-- Nav's own pins, drawn through Polestar.Pins:
--   nav.target  the point being guided to (world map + minimap, clamped to the rim); an
--               area target that is not a guide goal's also shows its area as a soft disc
--   nav.route   where the travel route changes mode: flight masters, docks, the inn (world map)
--   nav.goals   the current step's other open goals; click one to point the arrow there (world map)
--   nav.spots   the target's other spawn places, small marks (other places it spawns fainter);
--               click one to search there next (world map). A target of exact points
--               (Engine.SpotsExact: an object's spawns, a mob at a few fixed places, #1944)
--               marks every point on the minimap too, those checked lately fainter
--   nav.areas   the regions the target's goal spawns in, in the arrow's colour (world
--               map + minimap)
--   nav.goalAreas  the regions the step's other open goals spawn in, fainter, in the
--               goals' colour (world map); a goal of exact points marks each point instead
-- and the trail (Pins.SetTrail): dots from the player along the travel route's lines (each
-- leg's start where the mode changes, and its end), broken at a Hearthstone (a jump, not a
-- path) and across continents; without a route, straight to the target (both surfaces).
-- nav.worldPins / nav.minimapPins switch Nav's layers on each surface; nav.trailDots the trail,
-- which stands in only while Maps/RouteLines.lua draws no route (nav.routeLines off), and
-- nav.minimapRoute keeps it off the minimap.

local ADDON, ns = ...
local Nav = ns.Nav
local Pins = ns.Pins
local L = ns.L

local format = string.format

local Layers = {}
Nav.layers = Layers

local TARGET, ROUTE, GOALS, SPOTS = "nav.target", "nav.route", "nav.goals", "nav.spots"
local AREAS, GOAL_AREAS = "nav.areas", "nav.goalAreas"
local HERE, HERE_AREAS = "nav.here", "nav.hereAreas"

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

-- The target's look (Options > Map pins): nav.targetPinSize scales it (its
-- cap on screen with it), nav.targetGlow its halo, nav.targetPulse makes the
-- halo breathe (Pins' `pulse`).
ns.RegisterDefaults("nav", { targetPinSize = 1, targetGlow = true, targetPulse = false })
Layers.TARGET_SCALE = 1.4

-- The target pin's look: glow, pulse, its size setting (grow) and its layer's scale.
-- Shared with the options' preview (Nav/PinsOptions.lua).
function Layers.TargetLook()
	local k = tonumber(ns.Get("nav.targetPinSize")) or 1
	local glow = ns.Get("nav.targetGlow") ~= false
	return glow, glow and ns.Get("nav.targetPulse") and true or nil, k, Layers.TARGET_SCALE * k
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
	local glow, pulse, grow, scale = Layers.TargetLook()
	-- The target wears the arrow's colour (Theme "arrow": the accent unless
	-- the player picked their own), so map and arrow agree.
	Pins.SetLayer(TARGET, {
		{ map = target.map, x = target.x, y = target.y, f = target.f, color = color("arrow"), glow = glow, icon = "map:target",
			pulse = pulse, grow = grow, area = area, tooltip = targetTooltip, priority = 100 },
	}, { world = world, minimap = minimap, edge = true, scale = scale, minimapAreas = true })
end

-- Every other spot of the target's spawn places, so the player sees where
-- else it may be and can pick where to look next; the other places it spawns
-- (`alt`, never picked by the arrow on its own) are marked fainter. Exact
-- points (the waypoint's `exact`, #1944) are where the target stands: each
-- is marked on the minimap too, in place of its regions (updateAreas), those
-- the player checked lately (Engine.SpotChecked) faintest, saying so.
local function updateSpots(world, minimap)
	local target = Nav.GetTarget()
	local spots = target and target.spots
	minimap = minimap and spots and target.exact or false
	if not (spots and (world or minimap)) then
		Pins.ClearLayer(SPOTS)
		return
	end
	local Engine = ns.Engine
	local checkedOf = target.exact and Engine and Engine.SpotChecked
	local pins, n, label = {}, #spots, target.label
	local r, g, b = Nav.RGB("arrow")
	for i, s in ipairs(spots) do
		if i ~= target.spot then
			local alt, checked = s.alt, checkedOf and checkedOf(s)
			pins[#pins + 1] = {
				map = target.map, x = s.x, y = s.y, f = target.f, color = { r, g, b, checked and 0.35 or alt and 0.5 or 0.8 },
				icon = "map:pin-small", medal = false, size = alt and 7 or 9, priority = alt and 15 or 20,
				tooltip = function(tip)
					tip:SetText(label or "")
					tip:AddLine(format(L["Spot %d of %d"], i, n), 0.7, 0.7, 0.7)
					if alt then tip:AddLine(L["It also spawns here"], 0.7, 0.7, 0.7) end
					if checked then tip:AddLine(L["Checked recently"], 0.7, 0.7, 0.7) end
					tip:AddLine(L["Click to search here next"], 0.7, 0.7, 0.7)
				end,
				onClick = function(button)
					if button == "LeftButton" then Nav.NextSpot(i) end
				end,
			}
		end
	end
	Pins.SetLayer(SPOTS, pins, { world = world, minimap = minimap })
end

-- A leg that ends at a chokepoint (leg.choke = { kind, name }, Travel.lua)
-- marks it with its passage glyph; other stops with the stop glyph.
local CHOKE_ICON = {
	lift = "map:elevator", gate = "map:portal", building = "map:portal", bridge = "map:bridge",
	cave = "map:cave", tunnel = "map:cave", pass = "map:pass",
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
			icon = icon or "map:stop", size = not icon and 15 or nil,
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

-- A goal of step `index` (the step the guide is on), clicked on the map: the
-- Engine leads the arrow there as a click on its line in the guide window
-- does (Engine.AimGoal), so the arrow moves on through its spots (#1653);
-- one whose quest waits for its accept leaves the arrow on the accept and
-- says so (#1385). False when the Engine can't lead there.
local function aimAt(index, goal)
	local Engine = ns.Engine
	if not (goal.index and Engine and Engine.AimGoal) then return false end
	local aimed, why, title = Engine.AimGoal(index, goal.index)
	if not (aimed or why == "accept") then return false end
	Nav.ReleaseTarget()
	if why == "accept" then
		local message = format(L["Take %s first"], ns.Quoted(title) or "")
		if UIErrorsFrame and UIErrorsFrame.AddMessage then UIErrorsFrame:AddMessage(message, 1, 0.82, 0) else ns.Print(message) end
	end
	return true
end

-- view: the current step's Engine.GetStepView (index), fetched once per
-- Layers.Update for this and the areas.
local function updateGoals(world, index, view)
	local Engine = ns.Engine
	if not world then view = nil end
	if not (view and view.goals) then
		Pins.ClearLayer(GOALS)
		return
	end
	local target = Nav.GetTarget()
	local pins = {}
	-- The step's goals, then the Along the way list's (Engine.GetAlong: along
	-- steps and pinned quests, #644). The While you're here line has its own
	-- layer (updateHere).
	local list, own = view.goals, #view.goals
	if Engine.GetAlong then
		list = {}
		for _, goal in ipairs(view.goals) do list[#list + 1] = goal end
		for _, s in ipairs(Engine.GetAlong()) do
			for _, goal in ipairs(s.goals) do list[#list + 1] = goal end
		end
	end
	for i, goal in ipairs(list) do
		if goal.map and goal.x and goal.y and (goal.status == "active" or goal.status == "pending")
			and not (target and target.map == goal.map and target.x == goal.x and target.y == goal.y) then
			local text = goal.text
			pins[#pins + 1] = {
				map = goal.map, x = goal.x, y = goal.y, f = goal.f, color = color("place"), priority = 10, icon = "map:pin",
				label = text,
				tooltip = function(tip)
					tip:SetText(text or "")
					tip:AddLine(L["Click to point the arrow here"], 0.7, 0.7, 0.7)
				end,
				-- The step's own goals (the list's first `own`) through the
				-- Engine; an Along the way goal, a plain point.
				onClick = function(button)
					if button ~= "LeftButton" or (i <= own and aimAt(index, goal)) then return end
					Nav.SetTarget(goal.map, goal.x, goal.y, text, goal.f, nil, goal.z)
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
-- regions by Polestar.Regions (Nav/Regions.lua). Built once per goal (the
-- compiled guide never changes):
-- regions = { { c, wx, wy (its centre), hull = { wx1, wy1, ... }, members, n (spawns), alt (only
-- places the arrow does not pick by itself) }, ... }, nil without spots or a map frame.
-- A goal with too many spots to group (Regions.WORK; only a crafted guide,
-- an import string) draws no regions.
local regionCache = setmetatable({}, { __mode = "k" })

local function regionsOf(goal)
	local cached = regionCache[goal]
	if cached ~= nil then return cached or nil end
	local C = ns.Compat
	local spots = goal.spots
	if not (C and C.MapToWorld and ns.Regions and type(spots) == "table" and goal.map) then return nil end
	local cs, xs, ys, rs = {}, {}, {}, {}
	for i, s in ipairs(spots) do
		local c, wx, wy = C.MapToWorld(goal.map, s.x, s.y, goal.f)
		if not c then return nil end -- not resolvable yet: try again later
		cs[i], xs[i], ys[i], rs[i] = c, wx, wy, tonumber(s.r) or 0
	end
	local regions = ns.Regions.Of(cs, xs, ys, rs)
	if not regions then
		regionCache[goal] = false
		ns.Debug("spawn regions: a goal's", #spots, "spots are too many to group; no regions drawn")
		return nil
	end
	for _, rg in ipairs(regions) do
		local n, alt = 0, true
		for _, i in ipairs(rg.members) do
			n = n + (tonumber(spots[i].n) or 0)
			if not spots[i].alt then alt = false end
		end
		rg.n, rg.alt = n, alt
	end
	regionCache[goal] = regions
	return regions
end
Layers.Regions = regionsOf

-- What the maps draw for a goal's spots: its regions (regionsOf), or for
-- exact points (Engine.SpotsExact, #1944: where the target stands) the goal
-- itself, marked point by point (pointMarks), with no shading. Nil without
-- spots.
local function placesOf(goal)
	if not (goal and goal.map and goal.spots) then return nil end
	local Engine = ns.Engine
	if Engine and Engine.SpotsExact and Engine.SpotsExact(goal) then return goal end
	return regionsOf(goal)
end

-- An exact goal's points onto `list`: small marks in (r, g, b) at alpha a,
-- the other places it spawns (`alt`) smaller at aAlt, saying `label`.
local function pointMarks(list, goal, r, g, b, a, aAlt, label)
	for _, s in ipairs(goal.spots) do
		list[#list + 1] = { map = goal.map, x = s.x, y = s.y, f = goal.f, icon = "map:pin-small", medal = false,
			size = s.alt and 6 or 8, color = { r, g, b, s.alt and aAlt or a }, priority = 12, tooltip = label }
	end
end

-- The spawn regions of the step's open goals. The target's goal's wear the
-- arrow's colour on both surfaces; the other goals', fainter in their pins'
-- colour, show only on the world map, so the minimap stays about where the
-- arrow leads. Regions of only the other places a target spawns (`alt`) are
-- fainter still. A goal of exact points marks each point instead (the
-- target's goal's are nav.spots', updateSpots). The layers are set again only
-- when what they show changed (another step, goal opened or closed, the arrow
-- on another goal, colours, surfaces), so a route or progress update redraws
-- nothing.
local shownSig = {}

local function sameSig(sig)
	if #sig ~= #shownSig then return false end
	for i = 1, #sig do
		if sig[i] ~= shownSig[i] then return false end
	end
	return true
end

local function updateAreas(world, minimap, index, view)
	local Engine = ns.Engine
	if not (world or minimap) then view = nil end
	local guide = view and view.goals and Engine.GetGuide and Engine.GetGuide()
	local step = guide and guide.steps and guide.steps[index]
	local ar, ag, ab = Nav.RGB("arrow")
	local pr, pg, pb = Nav.RGB("place")
	local sig = { world, minimap, ar, ag, ab, pr, pg, pb }
	local shown = {} -- goal places (placesOf), each with whether they are the target's goal's
	if step then
		local target = Nav.GetTarget()
		local tg = target and target.stepIndex == index and target.goalIndex or nil
		for _, v in ipairs(view.goals) do
			local goal = (v.status == "active" or v.status == "pending") and step.goals and step.goals[v.index]
			local places = placesOf(goal)
			local mine = v.index == tg
			if places and not (mine and places == goal) then
				shown[#shown + 1], shown[#shown + 2], shown[#shown + 3] = places, mine, v.text or false
				sig[#sig + 1], sig[#sig + 2] = places, mine
			end
		end
		-- The Along the way list's goals (along steps, pinned quests: #644), and
		-- the While you're here line's once the arrow leads there (before, its
		-- own layer draws it: updateHere).
		if Engine.GetAlong and Engine.AlongGoal then
			for _, s in ipairs(Engine.GetAlong()) do
				for _, v in ipairs(s.goals) do
					local goal = Engine.AlongGoal(v.step, v.index)
					local places = placesOf(goal)
					local mine = target and target.stepIndex == v.step and target.goalIndex == v.index or false
					if places and not (mine and places == goal) then
						shown[#shown + 1], shown[#shown + 2], shown[#shown + 3] = places, mine, v.text or false
						sig[#sig + 1], sig[#sig + 2] = places, mine
					end
				end
			end
			local nearby = Engine.GetWhileHere and Engine.GetWhileHere()
			local goal = nearby and Engine.AlongGoal(nearby.step, nearby.index)
			local places = placesOf(goal)
			local mine = places and target and target.stepIndex == nearby.step and target.goalIndex == nearby.index
			if mine and places ~= goal then
				shown[#shown + 1], shown[#shown + 2], shown[#shown + 3] = places, mine, false
				sig[#sig + 1], sig[#sig + 2] = places, mine
			end
		end
	end
	if sameSig(sig) then return end
	shownSig = sig
	local own, others = {}, {}
	for i = 1, #shown, 3 do
		local places, mine = shown[i], shown[i + 1]
		local list = mine and own or others
		if places.spots then
			pointMarks(list, places, pr, pg, pb, 0.6, 0.35, shown[i + 2] or nil)
		else
			for _, rg in ipairs(places) do
				list[#list + 1] = {
					c = rg.c, wx = rg.wx, wy = rg.wy, hull = rg.hull, areaOnly = true,
					color = mine and { ar, ag, ab, rg.alt and 0.6 or 1 } or { pr, pg, pb, rg.alt and 0.35 or 0.6 },
				}
			end
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

-- The While you're here lines (Engine.GetWhileHereList) on both surfaces
-- until the arrow leads to one: each one's mark in the accent with a soft
-- glow, clamped to the minimap's rim with the edge pointer when it is off it
-- (an edge layer), and their spawn areas (a goal of exact points: its points)
-- in the accent on the minimap too, so the minimap shows what the lines and
-- their chime point at. A mark pings once as its line appears (Pins `ping`:
-- the line's `appeared`; a line coming back has a new one). Set again only
-- when the lines, their colour or the surfaces changed.
local hereSig = {}
local function updateHere(world, minimap)
	local Engine = ns.Engine
	local all = Engine and Engine.GetWhileHereList and Engine.GetWhileHereList() or {}
	local target = Nav.GetTarget()
	local lines = {}
	for i, v in ipairs(all) do
		if v.map and v.x and v.y and not (target and target.stepIndex == v.step and target.goalIndex == v.index) then
			lines[#lines + 1] = { v = v, i = i }
		end
	end
	local r, g, b = Nav.RGB("accent")
	local s = hereSig
	local same = s.n == #lines and s.r == r and s.g == g and s.b == b and s.world == world and s.minimap == minimap
	for k, e in ipairs(lines) do
		if same and (s[k] ~= e.v.appeared or s["i" .. k] ~= e.i) then same = false end
	end
	if same then return end
	s.n, s.r, s.g, s.b, s.world, s.minimap = #lines, r, g, b, world, minimap
	for k, e in ipairs(lines) do s[k], s["i" .. k] = e.v.appeared, e.i end
	if #lines == 0 or not (world or minimap) then
		Pins.ClearLayer(HERE)
		Pins.ClearLayer(HERE_AREAS)
		return
	end
	local pins, areas = {}, {}
	for _, e in ipairs(lines) do
		local v, i = e.v, e.i
		local text = v.hereText
		pins[#pins + 1] = {
			map = v.map, x = v.x, y = v.y, f = v.f, icon = "map:pin", color = { r, g, b, 1 }, glow = true, priority = 40,
			ping = v.appeared, label = text,
			tooltip = function(tip)
				tip:SetText(L["While you're here:"] .. " " .. (text or ""))
				tip:AddLine(L["Click to point the arrow here"], 0.7, 0.7, 0.7)
			end,
			onClick = function(button)
				if button == "LeftButton" and Engine.AimWhileHere then Engine.AimWhileHere(i) end
			end,
		}
		local goal = Engine.AlongGoal and Engine.AlongGoal(v.step, v.index)
		local places = placesOf(goal)
		if places and places == goal then
			pointMarks(areas, goal, r, g, b, 0.75, 0.4, text)
		else
			for _, rg in ipairs(places or {}) do
				areas[#areas + 1] = { c = rg.c, wx = rg.wx, wy = rg.wy, hull = rg.hull, areaOnly = true, color = { r, g, b, rg.alt and 0.4 or 0.75 } }
			end
		end
	end
	Pins.SetLayer(HERE, pins, { world = world, minimap = minimap, edge = true })
	if #areas > 0 then
		Pins.SetLayer(HERE_AREAS, areas, { world = world, minimap = minimap, minimapAreas = true })
	else
		Pins.ClearLayer(HERE_AREAS)
	end
end

-- The trail's runs: the player, then from the current leg on each leg's start
-- (unless it walks there) and end; a Hearthstone starts a new run at the inn.
-- Route lines, when they draw, show the way instead; Shortest Path Forever's
-- own line does while the target is handed to it (Nav/Handoff.lua).
local function updateTrail(world, minimap)
	local target = Nav.GetTarget()
	local lines = ns.RouteLines and ns.RouteLines.Active()
	-- "Route line on the minimap" off takes the trail off it too; the pin stays.
	minimap = minimap and ns.Get("nav.minimapRoute") ~= false
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
	-- The step's view, read once for the goals and the areas (shared with
	-- the other readers of this moment: Engine.GetStepView).
	local Engine = ns.Engine
	local index = (world or minimap) and Engine and Engine.GetStepIndex and Engine.GetStepIndex()
	local view = index and Engine.GetStepView and Engine.GetStepView(index, true)
	updateTarget(world, minimap)
	updateRoute(world)
	updateGoals(world, index, view)
	updateSpots(world, minimap)
	updateAreas(world, minimap, index, view)
	updateHere(world, minimap)
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
ns.On("WHILE_HERE_CHANGED", Layers.Update)
ns.On("ROUTE_ADVANCED", onAdvanced)
ns.On("NAV_ROUTE_GEOMETRY", function()
	local world, minimap = surfaces()
	updateTrail(world, minimap)
end)

Nav.RegisterModule(Layers)
