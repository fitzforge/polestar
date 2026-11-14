-- The settings window's Map pins page (look group, key "mappins"): every
-- mark Polestar draws on the world map and the minimap, on two tabs. Pins:
-- the target (its size, glow, where it shows, its spawn areas and the trail
-- toward it), then the numbered pins of the steps ahead (a player asked for
-- bigger ones: their size, colour, numbers, fade, count and minimap size).
-- Icons: every mark's size and opacity on each map, the count badge, then
-- the medallion they sit in. Every row has real effect: Nav/Pins.lua (its
-- `look`), Nav/Upcoming.lua (Upcoming.Look) and Nav/Layers.lua
-- (Layers.TargetLook) read them and repaint on SETTING_CHANGED.
--
-- Each tab pins a live preview over its rows, sandbox pins built and painted
-- by Pins' own code (Pins.BuildLook, Pins.ApplyLook and its size functions):
--   Pins and Essentials  a band (UI.Preview.Band) over the map hero
--          (UI.Preview.MapHero): a sharp 1:1 crop of Elwynn's world map and
--          the game's minimap side by side, the player, the route line to the
--          target in its spawn area, the numbered pins after it (faint while
--          they are off); the preset cards the same scene on a sharp crop;
--   Icons  a band over the same hero: the icon pack's marks at their spots
--          (an inn grouped with its count badge, a kill, a quest to take, one
--          to hand in), on the world map and inside the minimap.
-- Clicking a part of a preview jumps to its setting (the window's hotspots).
-- Never the live pins, no Nav hook; it repaints on its settings only while
-- shown, and nothing runs while idle (the target's pulse is the client's
-- animation, as on the maps). Nothing is built until a tab first shows.

local ns = Polestar
local Nav = ns.Nav
local Pins = ns.Pins
local Upcoming = Nav and Nav.upcoming
local Layers = Nav and Nav.layers
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
if not (Pins and Pins.BuildLook and Upcoming and Upcoming.Look and Layers and Layers.TargetLook and ns.RegisterOptions and Theme and W) then return end

local floor, min, max, sqrt = math.floor, math.min, math.max, math.sqrt

local PAGE = L["Map pins"]
local NEW = "0.3.8"
local NAV_MEDIA = "Interface\\AddOns\\Polestar\\Media\\Nav\\"
local MAP_MEDIA = "Interface\\AddOns\\Polestar\\Media\\Map\\"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function seconds(v) return string.format(L["%.1f s"], v) end
local function stepsAhead(v)
	if (tonumber(v) or 0) <= 0 then return L["Auto"] end
	return tostring(floor(v + 0.5))
end
-- Guidance options with no effect while Shortest Path Forever guides (Nav/Handoff.lua).
local function H(c) return Nav.HandoffOption and Nav.HandoffOption(c) or c end
local function numbersOff() return not ns.Get("nav.stepNumbers") end
local function glowOff() return ns.Get("nav.targetGlow") == false end
local function trailShown() return ns.Get("nav.trailDots") and not ns.Get("nav.routeLines") end

---------------------------------------------------------------------------
-- The previews
---------------------------------------------------------------------------

local ZOOM_OUT = 0 -- the world map's zoom (Pins.WorldScale): zoomed out, as it opens
local MM_ZOOM = 0.7 -- the minimap's widest zoom, its default

local function rgb(name)
	local r, g, b = Theme.Color(name)
	return { r, g, b, 1 }
end

local function newPin(parent)
	local f = CreateFrame("Frame", nil, parent)
	Pins.BuildLook(f)
	return f
end

-- A click target on a part of preview f (the window's hotspots, f:Hot):
-- hover outlines it, a click jumps to the setting's row. f.psHotspots lists
-- them: { { key, button }, ... }.
local function hotspot(f, region, key)
	local b = f:Hot(region, key)
	f.psHotspots = f.psHotspots or {}
	f.psHotspots[#f.psHotspots + 1] = { key, b }
end

-- Marks on the map hero h (UI.Preview.MapHero): -> onWorld(pin, p, x, y, t,
-- alpha), a world map pin at the zoomed-out map's size centred on (x, y) of
-- its crop; onMinimap(pin, p, mx, my, t, alpha), a minimap pin where (mx,
-- my) of the zone's map falls inside the minimap (hidden outside it), faded
-- over the player's arrow as there.
local function heroPins(h)
	local P, Strokes = ns.UI.Preview, ns.RouteStrokes
	local S = P.HERO_SCENE
	local layer, mm = h.Layer, h.Minimap
	local pwx, pwy = P.HeroWorld(S.player[1], S.player[2])
	local function onWorld(pin, p, x, y, t, alpha)
		Pins.ApplyLook(pin, p, Pins.WorldPinSize(p, p.scale))
		local k = Pins.WorldScale(pin, ZOOM_OUT) * t
		pin:SetScale(k)
		pin:SetAlpha(Pins.look.worldAlpha * (alpha or 1))
		pin:ClearAllPoints()
		pin:SetPoint("CENTER", layer, "TOPLEFT", x / k, -y / k)
		pin:Show()
	end
	local function onMinimap(pin, p, mx, my, t, alpha)
		local wx, wy = P.HeroWorld(mx, my)
		local x, y
		if Strokes and Strokes.Project then
			x, y = Strokes.Project(wx, wy, pwx, pwy, P.MM_YARDS / 2, 1, 0)
		else
			x, y = (pwy - wy) / (P.MM_YARDS / 2), (wx - pwx) / (P.MM_YARDS / 2)
		end
		if not (x and y) or x * x + y * y > 0.84 then pin:Hide() return end
		x, y = x * P.MM / 2, y * P.MM / 2
		local sizeK = tonumber(ns.Get("nav.minimapIconSize")) or 1
		Pins.ApplyLook(pin, p, Pins.MinimapPinSize(p, p.scale, MM_ZOOM, sizeK))
		local fade = Pins.look.arrowFade and Pins.ArrowFade and Pins.ArrowFade(x, y, pin.footPx) or 1
		pin:SetScale(t)
		pin:SetAlpha(fade * Pins.look.mmAlpha * (alpha or 1))
		pin:ClearAllPoints()
		pin:SetPoint("CENTER", mm, "CENTER", x / t, y / t)
		pin:Show()
	end
	return onWorld, onMinimap, pwx, pwy
end

-- Dots along the polyline pts (px), `gap` apart, from a pool of textures on
-- parent: the route through the numbered pins, or the trail. -> next free index
local function dotLine(pool, parent, from, pts, gap, size, r, g, b, a)
	local n = from
	for i = 1, #pts - 1 do
		local ax, ay, bx, by = pts[i][1], pts[i][2], pts[i + 1][1], pts[i + 1][2]
		local len = sqrt((bx - ax) ^ 2 + (by - ay) ^ 2)
		local count = floor(len / gap)
		for k = 1, count - 1 do
			n = n + 1
			local t = pool[n]
			if not t then
				t = parent:CreateTexture(nil, "BORDER")
				t:SetTexture(NAV_MEDIA .. "pin-fill")
				pool[n] = t
			end
			local u = k / count
			t:SetSize(size, size)
			t:SetVertexColor(r, g, b, a)
			t:ClearAllPoints()
			t:SetPoint("CENTER", parent, "TOPLEFT", ax + (bx - ax) * u, -(ay + (by - ay) * u))
			t:Show()
		end
	end
	return n
end

-- Map pins v2, a band (UI.Preview.Band) over the map hero (UI.Preview.
-- MapHero): the world map and the minimap side by side, a label under each,
-- one small scene from the current settings on both: the player, the route
-- line from them to the target (the maps' own stroke painters, while route
-- lines show there; the trail dots while they stand in for it), the target
-- in its spawn area, the numbered pins 2-4 after it (at 70% while they are
-- off, the default: Numbered pins turns them on). The game draws no line
-- between numbered pins: neither does the scene. Everything at the zoomed-out
-- world map's real size and the minimap's widest zoom.
local NUMBERED_OFF = 0.7
local function pinLooks(n)
	local glow, pulse, grow, scale = Layers.TargetLook()
	local out = { { icon = "map:target", color = rgb("arrow"), glow = glow, pulse = pulse, grow = grow, scale = scale } }
	for i = 1, n do
		local p, numbered = Upcoming.Look(i, n)
		p.text = numbered and tostring(i + 1) or nil
		p.scale = 1
		out[#out + 1] = p
	end
	return out
end

local function buildPinsPreview(view)
	local P = ns.UI.Preview
	local S = P.HERO_SCENE
	local f = P.Band(view, { watch = { "nav.", "ui." } })
	local h = P.MapHero(f)
	local layer, mm = h.Layer, h.Minimap
	local cx0, cy0, cw, ch = unpack(S.crop)
	local area = layer:CreateTexture(nil, "BACKGROUND")
	area:SetTexture(NAV_MEDIA .. "area")
	local target, steps, dots = newPin(layer), {}, {}
	target:SetFrameLevel(layer:GetFrameLevel() + 3)
	for i = 1, #S.steps do steps[i] = newPin(layer) end
	local mmTarget, mmSteps = newPin(h.MmLayer), {}
	for i = 1, #S.steps do mmSteps[i] = newPin(h.MmLayer) end
	f.Hero, f.Map = h, { area = area, target = target, steps = steps, dots = dots }
	f.Minimap = { target = mmTarget, steps = mmSteps }

	-- The route: one walk in Elwynn's world yards, drawn by the maps' own strokes.
	local R, Strokes = ns.RouteLines, ns.RouteStrokes
	local route = R and Strokes and R.Look and Strokes.Path and h.World and h.MmCanvas
	local paths, v, mv, strokes, mmStrokes
	local onWorld, onMinimap, pwx, pwy = heroPins(h)
	if route then
		local pts = {}
		for i, p in ipairs(S.walk) do
			local wx, wy = P.HeroWorld(p[1], p[2])
			pts[i] = { 0, wx, wy }
		end
		paths = { Strokes.Path("walk", pts) }
		local topWx, leftWy = P.HeroWorld(cx0, cy0)
		local bottomWx, rightWy = P.HeroWorld(cx0 + cw, cy0 + ch)
		v = { c = 0, left = leftWy, top = topWx, kx = 1 / (rightWy - leftWy), ky = 1 / (bottomWx - topWx), small = false,
			marks = { (S.target[1] - cx0) / cw, (S.target[2] - cy0) / ch, 7 }, markCount = 1,
			from = true, fromIndex = 2, fromC = 0, fromX = pwx, fromY = pwy, width = cw, height = ch }
		mv = { c = 0, x = pwx, y = pwy, radius = P.MM_YARDS / 2, facing = 0, square = false,
			from = true, fromIndex = 2, fromC = 0, fromX = pwx, fromY = pwy, width = P.MM, height = P.MM }
		strokes, mmStrokes = Strokes.New(400), Strokes.New(200)
	end

	function f:Content()
		local t = self:TrueScale()
		Pins.ReadLook()
		local list = pinLooks(#S.steps)
		local numbered = ns.Get("nav.upcomingPins") and 1 or NUMBERED_OFF
		local w, hh, labels = h.Size()
		-- The route on both, while route lines show there; else the trail dots.
		if route then
			h.World.opacity = R.Look(v, "world", h.World:GetEffectiveScale())
			h.MmCanvas.opacity = R.Look(mv, "minimap", h.MmCanvas:GetEffectiveScale())
			mv.phase = R.Style() == "dots" and 0.5 or 0
			strokes.n, mmStrokes.n = 0, 0
			if ns.Get("nav.routeLines") and R.Style() ~= "sparkle" then
				if ns.Get("nav.worldRoute") ~= false then Strokes.Map(strokes, paths, v) end
				if ns.Get("nav.minimapRoute") ~= false then Strokes.Minimap(mmStrokes, paths, mv) end
			end
			R.Paint(h.World, strokes)
			R.Paint(h.MmCanvas, mmStrokes)
		end
		local tx, ty = S.target[1] - cx0, S.target[2] - cy0
		local n = 0
		if trailShown() then
			local arrow = rgb("arrow")
			n = dotLine(dots, layer, n, { { S.player[1] - cx0, S.player[2] - cy0 }, { tx, ty } }, 12 * t, 6 * t * Pins.look.dotSize,
				arrow[1], arrow[2], arrow[3], Pins.look.dotAlpha)
		end
		for i = n + 1, #dots do dots[i]:Hide() end
		-- The world map: the spawn area, the target, the numbered pins.
		area:SetSize(S.area, S.area)
		area:ClearAllPoints()
		area:SetPoint("CENTER", layer, "TOPLEFT", tx, -ty)
		area:SetVertexColor(Pins.AreaColor({ color = rgb("arrow") }))
		local worldOn = ns.Get("nav.worldPins") ~= false
		target:SetShown(worldOn)
		if worldOn then onWorld(target, list[1], tx, ty, t) end
		for i, s in ipairs(steps) do onWorld(s, list[i + 1], S.steps[i][1] - cx0, S.steps[i][2] - cy0, t, numbered) end
		-- The minimap: the same marks where they fall inside it.
		if ns.Get("nav.minimapPins") ~= false then onMinimap(mmTarget, list[1], S.target[1], S.target[2], t) else mmTarget:Hide() end
		for i, s in ipairs(mmSteps) do
			if ns.Get("nav.upcomingMinimap") ~= false then onMinimap(s, list[i + 1], S.steps[i][1], S.steps[i][2], t, numbered) else s:Hide() end
		end
		return w, hh, h.Place, labels
	end

	-- Click a part to find its setting; the pointer on a setting's row lights
	-- the parts it changes.
	hotspot(f, area, "nav.areaAlpha")
	hotspot(f, target, "nav.targetPinSize")
	for _, s in ipairs(steps) do hotspot(f, s, "nav.stepPinSize") end
	hotspot(f, mm, "nav.minimapIconSize")
	local all = { target, unpack(steps) }
	for key, parts in pairs({
		["nav.targetPinSize"] = { target, mmTarget }, ["nav.targetGlow"] = { target }, ["nav.targetPulse"] = { target },
		["nav.pulseSeconds"] = { target }, ["nav.worldPins"] = { h.Map }, ["nav.minimapPins"] = { mmTarget },
		["nav.areaAlpha"] = { area }, ["nav.areaColor"] = { area }, ["nav.trailDotSize"] = { h.Me, target },
		["nav.trailDots"] = { h.Me, target }, ["nav.trailDotAlpha"] = { h.Me, target },
		["nav.upcomingPins"] = steps, ["nav.stepPinSize"] = steps, ["nav.stepRingColor"] = steps,
		["nav.stepColorMode"] = steps, ["nav.stepColor"] = steps, ["nav.stepNumberSize"] = steps,
		["nav.stepNumbers"] = steps, ["nav.stepNumberColor"] = steps, ["nav.stepNumberOutline"] = steps,
		["nav.upcomingCount"] = steps, ["nav.stepAlpha"] = { steps[1] }, ["nav.stepFadeTo"] = { steps[#steps] },
		["nav.upcomingMinimap"] = mmSteps, ["nav.stepMinimapSize"] = mmSteps,
		["nav.mapIcons"] = all, ["nav.worldIconSize"] = { h.Map }, ["nav.minimapIconSize"] = { mmTarget, unpack(mmSteps) },
	}) do
		f:Light(key, unpack(parts))
	end
	return f
end

-- The Icons tab, a band over the same map hero: the icon pack's marks at
-- their spots in Elwynn (the spots of NPC spawns): Goldshire's inn grouped
-- with its count badge, a kill at the stream's murlocs beside the player (its
-- minimap mark over the arrow fades), a quest to take at the Tower of Azora,
-- one to hand in at Eastvale; on the world map and where they fall inside
-- the minimap.
local ICONS = {
	{ 438.6, 439.5, "map:inn", "place", 3 }, -- Innkeeper Farley, Goldshire (and the smith and the vendors by him)
	{ 514, 444, "map:kill", "danger" }, -- Murloc Streamrunner, the stream east of Goldshire
	{ 653.5, 465.7, "map:quest-available", "quest" }, -- the Tower of Azora
	{ 815.4, 441.6, "map:quest-turnin", "quest" }, -- Supervisor Raelen, Eastvale Logging Camp
}
local function buildIconsPreview(view)
	local P = ns.UI.Preview
	local cx0, cy0 = unpack(P.HERO_SCENE.crop)
	local f = P.Band(view, { watch = { "nav.", "ui." } })
	local h = P.MapHero(f)
	local onWorld, onMinimap = heroPins(h)
	local marks, mmPins = {}, {}
	for i = 1, #ICONS do
		marks[i], mmPins[i] = newPin(h.Layer), newPin(h.MmLayer)
	end
	f.Hero, f.Marks, f.Minimap = h, marks, mmPins
	function f:Content()
		local t = self:TrueScale()
		Pins.ReadLook()
		local w, hh, labels = h.Size()
		local worldOn, mmOn = ns.Get("nav.worldPins") ~= false, ns.Get("nav.minimapPins") ~= false
		for i, m in ipairs(ICONS) do
			local p = { icon = m[3], color = rgb(m[4]), badge = m[5], scale = 1 }
			if worldOn then onWorld(marks[i], p, m[1] - cx0, m[2] - cy0, t) else marks[i]:Hide() end
			if mmOn then onMinimap(mmPins[i], p, m[1], m[2], t) else mmPins[i]:Hide() end
		end
		return w, hh, h.Place, labels
	end
	for i, m in ipairs(marks) do hotspot(f, m, ICONS[i][5] and "nav.badgeSize" or "nav.worldIconSize") end
	hotspot(f, h.Minimap, "nav.minimapIconSize")
	local all = { unpack(marks) }
	for key, parts in pairs({
		["nav.worldIconSize"] = all, ["nav.worldPinAlpha"] = all, ["nav.mapIcons"] = all, ["nav.medalColor"] = all,
		["nav.pinBacking"] = all, ["nav.badgeSize"] = { marks[1] }, ["nav.minimapIconSize"] = mmPins,
		["nav.minimapPinAlpha"] = mmPins, ["nav.minimapArrowFade"] = { mmPins[2] },
	}) do
		f:Light(key, unpack(parts))
	end
	return f
end
-- The previews, for the tests: PinsPreview(parent) -> f, PinsIconsPreview(parent) -> f.
Nav.PinsPreview = buildPinsPreview
Nav.PinsIconsPreview = buildIconsPreview

---------------------------------------------------------------------------
-- The icon pack's picture cards: each pack's medallion with a quest giver's glyph.
---------------------------------------------------------------------------

local function drawPackCard(card, value)
	local medal, glyph = card.psMedal, card.psGlyph
	if not medal then
		medal = card:CreateTexture(nil, "ARTWORK")
		medal:SetPoint("CENTER", card, "CENTER", 0, 0)
		glyph = card:CreateTexture(nil, "ARTWORK", nil, 1)
		glyph:SetPoint("CENTER", medal, "CENTER")
		card.psMedal, card.psGlyph = medal, glyph
	end
	local h = card.GetHeight and card:GetHeight() or 0
	local size = (h and h > 0) and min(40, max(22, floor(h * 0.42))) or 32
	local path, k = Pins.MedalPath(value)
	medal:SetSize(size * (k or 1), size * (k or 1))
	if path then Theme.SetArt(medal, path) end
	medal:SetShown(path ~= nil)
	local g = size / 1.4 * 27 / 24 -- the mark in its medallion (Pins' MEDAL_SCALE, GLYPH_FRAME)
	glyph:SetSize(g, g)
	glyph:SetTexture((Pins.IconPath("map:quest-available")))
	local r, gg, b = Theme.Color("quest")
	glyph:SetVertexColor(r, gg, b, 1)
end

local function packChoices()
	local list = {
		{ value = "skin", label = L["The skin's icons"] }, { value = "polestar", label = L["Polestar"] },
		{ value = "halo", label = L["Halo"] }, { value = "hearth", label = L["Hearth"] }, { value = "bare", label = L["Glyphs only"] },
	}
	for _, c in ipairs(list) do c.draw = drawPackCard end
	return list
end

---------------------------------------------------------------------------
-- The controls
---------------------------------------------------------------------------

-- Laid out by element (CONTRACT-V2, FIXES-V2): a section per element, its
-- on/off in the header (`toggle`); size, colour and opacity of one part share
-- a row (`extras`: at most one switch and one swatch, the colour of what the
-- label names), its finer knobs sit behind the row's cog (`more`); help shows
-- as the row's tooltip. The first card of each tab is live at defaults.
local SPECS = {
	-- Pins: the target first (live at defaults), then the numbered pins of the steps ahead.
	{ page = PAGE, key = "mappins", icon = "icon-goto", order = 23, group = "look", tab = L["Pins"], section = L["Target pin"],
		preview = buildPinsPreview,
		subtitle = L["The guide's marks on the world map and the minimap: the target, the numbered steps after it, the areas to search, and every icon."],
		controls = {
		{ kind = "slider", key = "nav.targetPinSize", label = L["Target size"], min = 0.6, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "target, waypoint, goal, destination, bigger, size, scale, huge, tiny, target pin",
			help = L["The pin the arrow points to, on the world map and the minimap. It wears the arrow's colour (Arrow page)."] },
		{ kind = "toggle", key = "nav.targetGlow", label = L["Target glow"], new = NEW,
			search = "glow, halo, light, shine, highlight, target, pulse, breathe, animation",
			help = L["The soft halo in the arrow's colour under the target's pin. Its pulse is in the cog."],
			more = {
				{ kind = "toggle", key = "nav.targetPulse", label = L["Pulse"], new = NEW, disabled = glowOff,
					search = "pulse, breathe, animation, blink, flash, motion, attention",
					help = L["The glow breathes slowly so the target catches the eye. Still with Reduce motion."] },
				{ kind = "slider", key = "nav.pulseSeconds", label = L["Pulse speed"], min = 0.4, max = 2, step = 0.1, format = seconds, new = NEW,
					disabled = function() return glowOff() or not ns.Get("nav.targetPulse") end,
					search = "pulse speed, faster, slower, animation, breathe, tempo",
					help = L["One breath of the pulse: shorter is faster."] },
			} },
		{ kind = "toggle", key = "nav.worldPins", label = L["On the world map"], search = "map pins, icons, markers, waypoint, world map, show, hide, guide pins, target",
			help = L["The arrow's target, the stops of its travel route, the step's other goals, the areas their mobs and objects spawn in, and the route lines."] },
		{ kind = "toggle", key = "nav.minimapPins", label = L["On the minimap"], search = "map pins, icons, markers, waypoint, minimap, show, hide, guide pins, target",
			help = L["The arrow's target, the areas it spawns in, and the route line."] },
		{ kind = "slider", key = "nav.areaAlpha", label = L["Spawn areas"], min = 0, max = 1, step = 0.02, format = percent, new = NEW,
			search = "area, region, spawn, tint, opacity, transparency, alpha, blob, circle, zone, quest area, colour, spawn areas",
			help = L["The opacity of the soft tint over the places mobs and objects spawn, on the world map and the minimap, their outlines with it. The swatch gives every area one colour."],
			extras = {
				{ kind = "color", key = "nav.areaColor", label = L["Area colour"], new = NEW,
					search = "area colour, region, spawn, tint, colour, color, blob",
					help = L["Every area in one colour. Right-click to go back to each in its own pin's colour."],
					shown = function() return Theme.Color("arrow") end, source = function() return L["The pin's colour"] end },
			} },
		-- The trail stands in for route lines: shown while route lines are off.
		{ kind = "slider", key = "nav.trailDotSize", label = L["Trail dots"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			needs = function() return not ns.Get("nav.routeLines") end,
			disabled = function() return not ns.Get("nav.trailDots") end,
			search = "trail, dots, path, route, breadcrumbs, size, bigger, smaller",
			help = L["Moving dots from you to the target on both maps while route lines are off; the slider is their size. They wear the arrow's colour; their opacity is in the cog."],
			extras = {
				H({ kind = "toggle", key = "nav.trailDots", label = L["Trail dots"],
					search = "trail, dots, path, route, breadcrumbs, show, hide",
					help = L["Moving dots from you to the target on the world map and the minimap, along the travel route, while route lines are off."] }),
			},
			more = {
				{ kind = "slider", key = "nav.trailDotAlpha", label = L["Opacity"], min = 0.1, max = 1, step = 0.05, format = percent, new = NEW,
					disabled = function() return not ns.Get("nav.trailDots") end,
					search = "trail, dots, opacity, transparency, alpha, faint",
					help = L["The trail's dots on both maps."] },
			} },
	} },
	{ page = PAGE, tab = L["Pins"], section = L["Numbered pins"],
		toggle = { kind = "toggle", key = "nav.upcomingPins", label = L["Numbered pins"],
			search = "upcoming, next steps, numbers, numbered, step pins, ahead, preview, plan, show, hide",
			help = L["A small pin with its step number where each of the next steps takes you, fainter the further ahead."] },
		controls = {
		{ kind = "slider", key = "nav.stepPinSize", label = L["Pin size"], min = 0.6, max = 3, step = 0.05, format = percent, new = NEW,
			search = "bigger, larger, size, scale, huge, tiny, smaller, numbered pins, step pins, pin size, readable, see",
			help = L["The numbered pins on the world map and the minimap. Bigger pins also grow past the usual limit on screen. Their rim colour is in the cog."],
			more = {
				{ kind = "color", key = "nav.stepRingColor", label = L["Rim colour"], new = NEW,
					search = "rim, ring, border, outline, edge, colour, color, numbered pins",
					help = L["The thin ring around each numbered pin. Right-click to go back to the medallion tint, else white."],
					shown = function()
						local c = ns.Get("nav.medalColor")
						if type(c) == "table" then return c[1], c[2], c[3] end
						return 1, 1, 1
					end,
					source = function() return L["White"] end },
			} },
		{ kind = "dropdown", key = "nav.stepColorMode", label = L["Colour"], new = NEW,
			search = "colour, color, tint, accent, by step, rainbow, different colours, own colour, pin colour",
			help = L["The accent, a colour for each step ahead so they tell apart, or your own colour (the swatch)."],
			choices = { { value = "accent", label = L["Accent"] }, { value = "steps", label = L["Per step"] }, { value = "own", label = L["Own colour"] } },
			extras = {
				{ kind = "color", key = "nav.stepColor", label = L["Own colour"], new = NEW,
					disabled = function() return ns.Get("nav.stepColorMode") ~= "own" end,
					search = "colour, color, tint, custom, pick, step pins",
					help = L["The numbered pins' colour when Colour is Own colour. Right-click to go back to the accent."],
					shown = function() return Upcoming.Color(1) end, source = function() return L["Accent"] end },
			} },
		-- The row dims while the numbers are off; its own switch (an extra, never disabled) turns them back on.
		{ kind = "slider", key = "nav.stepNumberSize", label = L["Numbers"], min = 0.6, max = 2, step = 0.05, format = percent, new = NEW, disabled = numbersOff,
			search = "font size, number size, bigger numbers, text size, readable, larger, digits, show numbers",
			help = L["The step number on each pin: its size, with the pin's own. The switch shows or hides the numbers, the swatch is their colour, their outline is in the cog."],
			extras = {
				{ kind = "toggle", key = "nav.stepNumbers", label = L["Show numbers"], new = NEW,
					search = "numbers, numbered, digits, labels, text, step number, hide numbers",
					help = L["Off: plain pins without their number."] },
				{ kind = "color", key = "nav.stepNumberColor", label = L["Number colour"], new = NEW, disabled = numbersOff,
					search = "number colour, text colour, font colour, color, white, contrast",
					help = L["The numbers' colour. Right-click to go back to white."],
					shown = function() return 1, 1, 1 end, source = function() return L["White"] end },
			},
			more = {
				{ kind = "dropdown", key = "nav.stepNumberOutline", label = L["Outline"], new = NEW, disabled = numbersOff,
					search = "outline, shadow, border, thick, contrast, readable, font",
					help = L["The dark edge around each number, so it reads on any map."],
					choices = { { value = "OUTLINE", label = L["Thin"] }, { value = "THICKOUTLINE", label = L["Thick"] }, { value = "NONE", label = L["None"] } } },
			} },
		{ kind = "slider", key = "nav.upcomingCount", label = L["Steps ahead"], min = 0, max = 15, step = 1, format = stepsAhead, new = NEW,
			search = "how many, count, number of steps, next steps, more, fewer, up next",
			help = L["How many of the next steps get a pin. Auto: as many as the guide window's Up next shows, else five."] },
		{ kind = "slider", key = "nav.stepAlpha", label = L["Opacity"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW,
			search = "opacity, transparency, alpha, faint, see through, nearest, next step",
			help = L["The pin of the very next step; the later ones fade from here."] },
		{ kind = "slider", key = "nav.stepFadeTo", label = L["Fade to"], min = 0.05, max = 1, step = 0.05, format = percent, new = NEW, info = true,
			search = "fade, fading, opacity, transparency, alpha, faint, how fast, last step, farthest",
			help = L["The farthest step's opacity: the pins fade from Opacity down to this, step by step. The same as Opacity: no fading."] },
		{ kind = "toggle", key = "nav.upcomingMinimap", label = L["On the minimap"], new = NEW,
			search = "minimap, radar, numbered pins, steps ahead, clutter",
			help = L["Off: the numbered pins show on the world map only."] },
		{ kind = "slider", key = "nav.stepMinimapSize", label = L["Minimap size"], min = 0.5, max = 2, step = 0.05, format = percent, new = NEW,
			disabled = function() return ns.Get("nav.upcomingMinimap") == false end,
			search = "minimap, radar, numbered pins, size, bigger, smaller, scale",
			help = L["The numbered pins on the minimap, against their size on the world map."] },
	} },

	-- Icons: every mark's size and opacity on each map, then the medallion they sit in.
	{ page = PAGE, tab = L["Icons"], section = L["Icons"], preview = buildIconsPreview, controls = {
		{ kind = "slider", key = "nav.worldIconSize", label = L["World map size"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "bigger, larger, size, scale, huge, tiny, smaller, world map, icons, marks, pins, readable",
			help = L["Every Polestar mark on the world map, the numbered pins too; they also grow past the usual limit on screen."] },
		{ kind = "slider", key = "nav.worldPinAlpha", label = L["World map opacity"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW,
			search = "opacity, transparency, alpha, faint, see through, world map, icons",
			help = L["Every Polestar mark on the world map."] },
		{ kind = "slider", key = "nav.minimapIconSize", label = L["Minimap size"], min = 0.5, max = 1.5, step = 0.05, format = percent,
			search = "minimap, radar, icons, marks, bigger, smaller, size, scale",
			help = L["Polestar's marks on the minimap; the world map keeps its own."] },
		{ kind = "slider", key = "nav.minimapPinAlpha", label = L["Minimap opacity"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW,
			search = "minimap, radar, opacity, transparency, alpha, faint, see through",
			help = L["Every Polestar mark on the minimap."] },
		{ kind = "toggle", key = "nav.minimapArrowFade", label = L["Fade over arrow"], new = NEW, info = true,
			search = "minimap, player arrow, fade, cover, hide, see my arrow, center",
			help = L["A mark over your arrow at the minimap's centre fades so the arrow shows through it. The game draws the arrow under every addon's marks."] },
		{ kind = "slider", key = "nav.badgeSize", label = L["Count badge"], min = 0.7, max = 2, step = 0.05, format = percent, new = NEW,
			search = "badge, count, capsule, number, cluster, services, bigger, font, size",
			help = L["The small count on a group of services and the ? on an unknown flight master."] },
	} },
	{ page = PAGE, tab = L["Icons"], section = L["Medallions"], controls = {
		{ kind = "cards", key = "nav.mapIcons", label = L["Icon pack"], wide = true,
			search = "icon pack, medallion, icons, marks, style, halo, hearth, glyphs, bare",
			help = L["The medallion under every mark on the world map and the minimap. The skin's: Polestar's, Halo's, or Hearth's for Hearth and the game's own looks. Glyphs only: no medallion."],
			choices = packChoices },
		{ kind = "color", key = "nav.medalColor", label = L["Tint"], new = NEW,
			search = "medallion, border, backing, frame, ring, tint, colour, color",
			help = L["A colour laid over every medallion and the numbered pins' rims. Right-click for none."],
			shown = function() return 1, 1, 1 end, source = function() return L["None"] end },
		{ kind = "color", key = "nav.pinBacking", label = L["Backing"], new = NEW,
			search = "backing, background, disc, dark, behind, contrast, colour, color, icon backing",
			help = L["The dark disc under the other skins' icons and the rare and death marks. Right-click to go back to the scheme's."],
			shown = function() return Theme.Color("scrim") end, source = function() return L["Scheme"] end },
	} },
}

---------------------------------------------------------------------------
-- Essentials (the page's lead tab): its presets as picture cards, then the
-- ten settings players change most, each a reference to its row on Pins or
-- Icons (same key, same tooltip; More opens that tab at the section).
---------------------------------------------------------------------------

local O = ns.UI and ns.UI.Options
if O and O.PresetCards and O.Ref then
	local R = O.Ref
	-- A preset's card: the hero's scene on a sharp 1:1 crop of the map
	-- (UI.Preview.SharpArt, a soft inner shade), the target in its area and
	-- the three numbered pins, drawn by Pins' own look code with the preset's
	-- values (Pins' look is read again after, for the live pins), each pin at
	-- the zoomed-out world map's size at its true size, as on the band.
	local function cardPin(pin, parent, p, x, y)
		Pins.ApplyLook(pin, p, Pins.WorldPinSize(p, p.scale))
		local k = Pins.WorldScale(pin, ZOOM_OUT) * ns.UI.Preview.TrueScale(parent)
		pin:SetScale(k)
		pin:SetAlpha(Pins.look.worldAlpha)
		pin:ClearAllPoints()
		pin:SetPoint("CENTER", parent, "TOPLEFT", x / k, -y / k)
		pin:Show()
	end
	local function drawPreset(art, _, values)
		local w, h = art:GetWidth(), art:GetHeight()
		if not (w and w > 0) then w = W.CARD_W - 2 end
		if not (h and h > 0) then h = W.CARD_ART end
		local P = ns.UI.Preview
		local S = P.HERO_SCENE
		local d = art.psSharp
		if not d then
			d = {}
			local clip = CreateFrame("Frame", nil, art)
			clip:SetAllPoints(art)
			if clip.SetClipsChildren then clip:SetClipsChildren(true) end
			d.art = P.SharpArt(clip, w, h, S.card[1], S.card[2], "panelAlt")
			local base = d.art and d.art.Over and d.art.Over:GetFrameLevel() or clip:GetFrameLevel() + 3
			P.InnerShade(clip, 16, 0.5):SetFrameLevel(base + 1)
			d.layer = CreateFrame("Frame", nil, clip)
			d.layer:SetAllPoints(clip)
			d.layer:SetFrameLevel(base + 3)
			d.area = d.layer:CreateTexture(nil, "BACKGROUND")
			d.area:SetTexture(NAV_MEDIA .. "area")
			d.target, d.steps = newPin(d.layer), {}
			for i = 1, #S.steps do d.steps[i] = newPin(d.layer) end
			art.psSharp = d
		end
		local x0, y0 = S.card[1] - w / 2, S.card[2] - h / 2
		O.WithSettings(values, function()
			Pins.ReadLook()
			local list = pinLooks(#S.steps)
			local tx, ty = S.target[1] - x0, S.target[2] - y0
			d.area:SetSize(S.area, S.area)
			d.area:ClearAllPoints()
			d.area:SetPoint("CENTER", d.layer, "TOPLEFT", tx, -ty)
			d.area:SetVertexColor(Pins.AreaColor({ color = rgb("arrow") }))
			cardPin(d.target, d.layer, list[1], tx, ty)
			for i, s in ipairs(d.steps) do cardPin(s, d.layer, list[i + 1], S.steps[i][1] - x0, S.steps[i][2] - y0) end
		end)
		Pins.ReadLook()
	end
	local PRESETS = {
		{ value = "polestar", label = L["Polestar"], set = {}, draw = drawPreset },
		{ value = "large", label = L["Large"], draw = drawPreset,
			help = L["Bigger pins and marks, easier to read and to click."],
			set = { ["nav.stepPinSize"] = 1.5, ["nav.stepNumberSize"] = 1.2, ["nav.targetPinSize"] = 1.3, ["nav.worldIconSize"] = 1.3,
				["nav.minimapIconSize"] = 1.2, ["nav.badgeSize"] = 1.2 } },
		{ value = "subtle", label = L["Subtle"], draw = drawPreset,
			help = L["Smaller, fainter pins that leave the map to the map."],
			set = { ["nav.stepPinSize"] = 0.8, ["nav.stepAlpha"] = 0.7, ["nav.stepFadeTo"] = 0.25, ["nav.worldPinAlpha"] = 0.75,
				["nav.minimapPinAlpha"] = 0.75, ["nav.areaAlpha"] = 0.2, ["nav.targetGlow"] = false } },
		{ value = "steps", label = L["Colour per step"], draw = drawPreset,
			help = L["Each step ahead in its own colour, none fainter, so the route reads at a glance."],
			set = { ["nav.stepColorMode"] = "steps", ["nav.stepFadeTo"] = 1 } },
	}
	local ESSENTIALS = L["Essentials"]
	-- The target and icons first (live at defaults), then the numbered pins (off until switched on).
	local list = {
		{ page = PAGE, tab = ESSENTIALS, lead = true, section = L["Presets"], preview = buildPinsPreview,
			controls = { O.PresetCards({ presets = PRESETS }) } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Icons and target"], jump = { tab = L["Icons"], section = L["Icons"] },
			controls = { R("dropdown", "nav.mapIcons", { label = L["Icon pack"], wide = false }), R("slider", "nav.targetPinSize"), R("slider", "nav.worldIconSize"),
				R("slider", "nav.minimapIconSize"), R("slider", "nav.areaAlpha"), R("toggle", "nav.targetGlow") } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Numbered pins"], jump = { tab = L["Pins"], section = L["Numbered pins"] },
			toggle = R("toggle", "nav.upcomingPins"),
			controls = { R("slider", "nav.stepPinSize"), R("slider", "nav.stepNumberSize"), R("dropdown", "nav.stepColorMode"), R("slider", "nav.upcomingCount") } },
	}
	for _, spec in ipairs(list) do SPECS[#SPECS + 1] = spec end
end

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
