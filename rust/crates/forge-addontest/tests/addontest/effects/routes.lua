-- env: routes
-- The Route lines page (Polestar_Options/Maps/RouteOptions.lua; Maps/RouteLines.lua, RouteStrokes.lua,
-- RouteSparkle.lua): every setting on the live route lines of the world map and the minimap. A route with a walk
-- (two bends), a flight, a boat, a zeppelin and a tram; the player halfway along the walk's first stretch.
local N, R, nav, geom
local function target(wx, wy) local m, x, y = nav.mapPoint(wx, wy); N.SetTarget(m, x, y, "Target") end
local function rgb(t) local r, g, b = t:GetVertexColor(); return { r, g, b } end
local function r3(v) return math.floor((v or 0) * 1000 + 0.5) / 1000 end
local function worldPin() local p = R.GetWorldFrame(); if p and p:IsShown() then return p end end
local function shown(owner)
	local n = 0
	for _, line in ipairs(owner and owner.lines or {}) do if line:IsShown() then n = n + 1 end end
	return n
end
-- The world map's strokes as painted (nav-route-look.rs's look()), and each leg kind's colour.
local function look()
	local pin, s = worldPin(), R.GetStrokes("world")
	local r = { n = s.n, soft = 0, dashes = 0, arms = 0, tail = 0, shown = shown(pin), colours = {} }
	for i = 1, s.n do
		local c = s.color[i]
		if c and pin then r.colours[#r.colours + 1] = rgb(pin.lines[i]) end
		if s.soft[i] then
			r.soft = r.soft + 1
			if s.alpha[i] < 1 then r.tail = r.tail + 1 end
			if not r.walk and s.alpha[i] == 1 then
				local line, outline = pin.lines[i], pin.outlines[i]
				r.walk = rgb(line)
				r.width, r.alpha, r.outline = r3(line:GetThickness()), r3(line:GetAlpha()), outline:IsShown()
			end
		elseif s.under[i] > 0 and not s.dot[i] then
			r.dashes = r.dashes + 1
			if not r.flight then r.flight, r.flightAlpha = rgb(pin.lines[i]), r3(s.alpha[i]) end
		elseif s.under[i] == 0 and not s.dot[i] then
			r.arms = r.arms + 1
		end
	end
	return r
end
-- Each leg kind's colour as drawn: the strokes' colour tables by kind.
local function colours()
	local pin, s = worldPin(), R.GetStrokes("world")
	local seen, out = {}, {}
	for i = 1, s.n do
		local c = s.color[i]
		if c and not seen[c] and pin then seen[c] = true; out[#out + 1] = rgb(pin.lines[i]) end
	end
	return out
end
local function dots()
	local s, pin = R.GetStrokes("world"), worldPin()
	local first, second
	for i = 1, s.n do
		if s.dot[i] then if not first then first = i elseif not second then second = i end end
	end
	if not (first and second and pin) then return false end
	local gap = math.sqrt(((s.x1[second] + s.x2[second]) - (s.x1[first] + s.x2[first])) ^ 2 + ((s.y1[second] + s.y2[second]) - (s.y1[first] + s.y2[first])) ^ 2) / 2
	return { width = r3(pin.lines[first]:GetThickness()), gap = r3(gap) }
end
-- Sparkles as drawn with the clock held (their twinkle and flow are the clock's): the count and the first stars'
-- colour, size and alpha.
local function sparkles()
	local real = GetTime
	GetTime = function() return 5000 end
	stub.advance(0.1)
	local n = R.GetSparkles("world")
	local pin = worldPin()
	local stars = {}
	for i = 1, math.min(3, n) do
		local st = pin.stars[i]
		stars[i] = { rgb(st), r3(st:GetWidth()), r3(st:GetAlpha()) }
	end
	GetTime = real
	return { n = n, stars = stars }
end
local SPARKLE = { ["nav.lineStyle"] = "sparkle", ["nav.sparkleFlow"] = 0 }
local function sparkling(probe, extra)
	local with = {}
	for k, v in pairs(SPARKLE) do with[k] = v end
	for k, v in pairs(extra or {}) do with[k] = v end
	return { with = with, probe = probe }
end
return {
	setup = function()
		N, R, nav = Polestar.Nav, Polestar.RouteLines, stub.nav
		WorldMapFrame:GetCanvas():SetSize(1000, 1000)
		geom = { legs = {
			{ kind = "walk", pts = { { 0, 0, 0 }, { 0, 50, -100 }, { 0, 0, -200 }, { 0, 60, -300 } }, current = true },
			{ kind = "flight", pts = { { 0, 60, -300 }, { 0, 60, -500 } } },
			{ kind = "boat", pts = { { 0, 60, -500 }, { 0, 160, -600 } } },
			{ kind = "zeppelin", pts = { { 0, 160, -600 }, { 0, 260, -700 } } },
			{ kind = "tram", pts = { { 0, 260, -700 }, { 0, 300, -760 } } },
		} }
		N.GetRouteGeometry = function() return geom end
		Polestar.Set("nav.travel", false)
		nav.viewRadius = 400
		nav.place(25, -50)
		target(300, -760)
		Polestar.Fire("NAV_ROUTE_GEOMETRY")
		nav.showWorldMap(9000)
		stub.advance(1)
	end,
	settle = 0.5,
	probes = {
		["nav.routeLines"] = function() return { worldPin() ~= nil, R.GetStrokes("world").n > 0 } end,
		["nav.lineStyle"] = { value = "dots", probe = function() return R.Style() end },
		["nav.worldRouteAlpha"] = function() return look().alpha end,
		["nav.worldRoute"] = function() return worldPin() ~= nil end,
		["nav.minimapRouteAlpha"] = function() local m = R.GetMinimapFrame(); return m and r3(m.opacity) or false end,
		["nav.minimapRoute"] = function() local m = R.GetMinimapFrame(); return { m ~= nil and m:IsShown(), R.GetStrokes("minimap").n > 0 } end,
		-- Each style's own minimap size, its row shown while that style is drawn.
		["nav.minimapLineSize"] = { with = { ["nav.lineStyle"] = "line" }, probe = function() return r3(R.MinimapSize()) end },
		["nav.minimapDotsSize"] = { with = { ["nav.lineStyle"] = "dots" }, probe = function() return r3(R.MinimapSize()) end },
		["nav.minimapSparkleSize"] = sparkling(function() return r3(R.MinimapSize()) end),
		-- A new goal: drawn in over a moment (the minimap's strokes a share of them at first), or whole at once.
		["nav.drawIn"] = function()
			local tram = geom.legs[5].pts
			tram[2] = { 0, 300, -780 }
			target(300, -780); Polestar.Fire("NAV_ROUTE_GEOMETRY"); stub.advance(0.1)
			stub.runMapFrame(WorldMapFrame, 0)
			local whole = shown(R.GetMinimapFrame()) == R.GetStrokes("minimap").n and shown(worldPin()) == R.GetStrokes("world").n
			tram[2] = { 0, 300, -760 }
			target(300, -760); Polestar.Fire("NAV_ROUTE_GEOMETRY"); stub.advance(1)
			return whole
		end,
		["nav.laterAlpha"] = function() return look().flightAlpha end,
		["nav.lineOutline"] = { value = 0, probe = function() return look().outline end },
		["nav.walkColor"] = function() return look().walk end,
		["nav.dotColor"] = function() return look().walk end,
		["nav.lineWidth"] = function() return look().width end,
		["nav.walkedFade"] = function() return look().tail end,
		["nav.routeChevrons"] = function() return look().arms end,
		["nav.flightDash"] = function() return look().dashes end,
		["nav.dotSize"] = { with = { ["nav.lineStyle"] = "dots" }, probe = dots },
		["nav.dotSpacing"] = { with = { ["nav.lineStyle"] = "dots" }, probe = dots },
		["nav.flightColor"] = function() return colours() end,
		["nav.boatColor"] = function() return colours() end,
		["nav.zeppelinColor"] = function() return colours() end,
		["nav.tramColor"] = function() return colours() end,
		-- The sparkle presets (cards with no key of their own): the gap between two sparkles (their density), which
		-- their drift does not change.
		["Route lines:Presets"] = { with = { ["nav.lineStyle"] = "sparkle" }, probe = function()
			local real = GetTime
			GetTime = function() return 6000 end
			stub.advance(0.1)
			local pin = worldPin()
			local _, _, _, x1, y1 = pin.stars[1]:GetPoint(1)
			local _, _, _, x2, y2 = pin.stars[2]:GetPoint(1)
			GetTime = real
			return math.floor(math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) / 3 + 0.5) * 3
		end },
		["nav.sparkleColor"] = sparkling(sparkles),
		["nav.sparkleSize"] = sparkling(sparkles),
		["nav.sparkleIntensity"] = sparkling(sparkles),
		["nav.sparkleSubtlety"] = sparkling(sparkles),
		["nav.sparkleDensity"] = sparkling(sparkles),
		-- The cap at its lowest holds fewer than the route shows.
		["nav.sparkleMax"] = { value = 10, with = { ["nav.lineStyle"] = "sparkle", ["nav.sparkleFlow"] = 0, ["nav.sparkleDensity"] = 10 }, probe = sparkles },
		["nav.sparkleLater"] = sparkling(sparkles),
		-- Flowing: how far the first sparkle moves while the clock runs half a second.
		-- Its reads hold the sparkles' clock at two fixed times, so where the first sparkle stands then (and which one is
		-- first) follows every redraw before: no reads over a profile switch beside the runner's three (once), and none
		-- in a fresh session to compare with this one's (reload; nav-route-sparkle.rs holds the flow itself).
		["nav.sparkleFlow"] = { once = true, reload = false, with = { ["nav.lineStyle"] = "sparkle" }, probe = function()
			local real = GetTime
			GetTime = function() return 7000 end
			stub.advance(0.1)
			local pin = worldPin()
			local _, _, _, x1, y1 = pin.stars[1]:GetPoint(1)
			GetTime = function() return 7000.5 end
			stub.advance(0.1)
			local _, _, _, x2, y2 = pin.stars[1]:GetPoint(1)
			GetTime = real
			return r3(math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2))
		end },
	},
}
