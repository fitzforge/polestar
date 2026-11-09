-- The settings window's Map pins page (look group, key "mappins"): every
-- mark Polestar draws on the world map and the minimap. The numbered pins of
-- the steps ahead first (a player asked for bigger ones: their size, number,
-- colours, fade and count), the target, the icon pack and the size and
-- opacity of every mark, the spawn areas and the trail, the minimap, and
-- what shows. Every row has real effect: Nav/Pins.lua (its `look`),
-- Nav/Upcoming.lua (Upcoming.Look) and Nav/Layers.lua (Layers.TargetLook)
-- read them and repaint on SETTING_CHANGED.
--
-- Each tab pins a live preview over its rows: sandbox pins built and painted
-- by Pins' own code (Pins.BuildLook, Pins.ApplyLook and its size functions)
-- over a zone painting (UI.ZoneArt; the night band where there is none): the
-- target in its area, a quest giver, the next three steps' numbered pins
-- fading, the trail; beside it a minimap disc with the player's arrow, a mark
-- fading over it and a step. Never the live pins, no Nav hook; it repaints
-- on its settings only while shown, and nothing runs while idle (the
-- target's pulse is the client's animation, as on the maps). Nothing is
-- built until the page first shows.

local ADDON, ns = ...
local Nav = ns.Nav
local Pins = ns.Pins
local Upcoming = Nav and Nav.upcoming
local Layers = Nav and Nav.layers
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
if not (Pins and Pins.BuildLook and Upcoming and Upcoming.Look and Layers and Layers.TargetLook and ns.RegisterOptions and Theme and W) then return end

local floor, min, max = math.floor, math.min, math.max

local PAGE = L["Map pins"]
local NEW = "0.3.7"
local NAV_MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function seconds(v) return string.format(L["%.1f s"], v) end
local function stepsAhead(v)
	if (tonumber(v) or 0) <= 0 then return L["As Up next"] end
	return tostring(floor(v + 0.5))
end
-- Guidance options with no effect while Shortest Path Forever guides (Nav/Handoff.lua).
local function H(c) return Nav.HandoffOption and Nav.HandoffOption(c) or c end
local function upcomingOff() return not ns.Get("nav.upcomingPins") end
local function numbersOff() return not ns.Get("nav.stepNumbers") end
local function glowOff() return ns.Get("nav.targetGlow") == false end

---------------------------------------------------------------------------
-- The preview
---------------------------------------------------------------------------

local STAGE_H, MM, MM_COL, ZONE = 200, 120, 168, 1429 -- Elwynn Forest, as the welcome's demo
-- The window's chrome sits over the stage ("Preview" top left, "Live" top right): the
-- painting starts below it, inset by the body's pad.
local PAD, TOP, BOTTOM = 32, 34, 12
local MAP_H = STAGE_H - TOP - BOTTOM
-- Where things sit on the painting (fractions of its width and height).
local SPOTS = {
	area = { 0.5, 0.52 }, giver = { 0.24, 0.36 },
	steps = { { 0.66, 0.36 }, { 0.78, 0.6 }, { 0.9, 0.4 } },
	trail = { 0.08, 0.86 },
}
-- The minimap sample (px from its centre, y up): a mark over the arrow, a step, the target.
local MM_SPOTS = { giver = { 5, 4 }, step = { 30, -22 }, target = { -34, 28 } }
local MAP_ZOOM, MM_ZOOM = 0, 0.7 -- the default zoom on both: the world map zoomed out, the minimap's widest

-- The keys the preview repaints on (besides the theme).
local KEYS = {
	["nav.mapIcons"] = true, ["nav.minimapIconSize"] = true, ["nav.arrowColor"] = true, ["nav.routeLines"] = true,
	["nav.trailDots"] = true, ["nav.targetPinSize"] = true, ["nav.targetGlow"] = true, ["nav.targetPulse"] = true,
	["ui.reduceMotion"] = true, ["ui.upcoming"] = true, ["nav"] = true, ["ui"] = true, [""] = true,
}
for k in pairs(Pins.LOOK_KEYS) do KEYS[k] = true end
for k in pairs(Upcoming.KEYS) do KEYS[k] = true end

local function rgb(name)
	local r, g, b = Theme.Color(name)
	return { r, g, b, 1 }
end

local function newPin(parent)
	local f = CreateFrame("Frame", nil, parent)
	Pins.BuildLook(f)
	return f
end

-- Paint sandbox pin frame f with pin p at layer scale `scale`, as the world
-- map does at MAP_ZOOM, centred on (x, y) px from parent's top left.
local function worldPin(f, parent, p, scale, x, y)
	Pins.ApplyLook(f, p, Pins.WorldPinSize(p, scale))
	local k = Pins.WorldScale(f, MAP_ZOOM)
	f:SetScale(k)
	f:SetAlpha(Pins.look.worldAlpha)
	f:ClearAllPoints()
	f:SetPoint("CENTER", parent, "TOPLEFT", x / k, -y / k)
	f:Show()
end

-- The same on the minimap sample: its size at MM_ZOOM and the player's
-- minimap icon size, faded over the arrow as there.
local function minimapPin(f, parent, p, scale, x, y)
	local sizeK = tonumber(ns.Get("nav.minimapIconSize")) or 1
	Pins.ApplyLook(f, p, Pins.MinimapPinSize(p, scale, MM_ZOOM, sizeK))
	local fade = Pins.look.arrowFade and Pins.ArrowFade(x, y, f.footPx) or 1
	f:SetAlpha(fade * Pins.look.mmAlpha)
	f:ClearAllPoints()
	f:SetPoint("CENTER", parent, "CENTER", x, y)
	f:Show()
end

local function buildPreview(view)
	local f = CreateFrame("Frame", nil, view)
	f:SetHeight(STAGE_H)
	if f.SetClipsChildren then f:SetClipsChildren(true) end
	W.Fill(f, "scrim", "BACKGROUND", -8)
	W.Painter(f, function(self) Theme.Border(self, Theme.Wash("divider")) end)

	-- The world map: the zone's painting (or the night band), the pins above it.
	f.caption = L["At the default zoom"]
	local map = CreateFrame("Frame", nil, f)
	map:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -TOP)
	map:SetHeight(MAP_H)
	if map.SetClipsChildren then map:SetClipsChildren(true) end
	local ZA = ns.UI and ns.UI.ZoneArt
	local art
	if ZA then
		art = ZA.Create(map, 400, MAP_H, "scrim")
		art:SetPoint("TOPLEFT", map, "TOPLEFT", 0, 0)
	else
		local band = Theme.Band(map, "BACKGROUND", -7)
		band:SetAllPoints(map)
		f.Band = band
	end
	local layer = CreateFrame("Frame", nil, map)
	layer:SetAllPoints(map)
	layer:SetFrameLevel((art and art.Over or map):GetFrameLevel() + 2)
	local mapLabel = W.Text(layer, "caption", "textMuted")
	mapLabel:SetText(L["World map"])
	mapLabel:SetPoint("BOTTOMLEFT", map, "BOTTOMLEFT", 10, 8)

	local area = layer:CreateTexture(nil, "BACKGROUND")
	area:SetTexture(NAV_MEDIA .. "area")
	local dots = {}
	for i = 1, 7 do
		local t = layer:CreateTexture(nil, "BORDER")
		t:SetTexture(NAV_MEDIA .. "pin-fill")
		dots[i] = t
	end
	local giver, target = newPin(layer), newPin(layer)
	local steps = { newPin(layer), newPin(layer), newPin(layer) }
	target:SetFrameLevel(layer:GetFrameLevel() + 3)

	-- The minimap: a disc of ground, its rim, the player's arrow, the marks.
	local mm = CreateFrame("Frame", nil, f)
	mm:SetSize(MM, MM)
	local ground = mm:CreateTexture(nil, "BACKGROUND")
	ground:SetTexture(NAV_MEDIA .. "pin-fill")
	ground:SetPoint("CENTER")
	ground:SetSize(MM * 64 / 42, MM * 64 / 42) -- pin-fill's disc covers 42 of its 64 pixels
	ground:SetVertexColor(0.16, 0.2, 0.13, 1)
	local rim = mm:CreateTexture(nil, "BORDER")
	rim:SetTexture("Interface\\AddOns\\" .. ADDON .. "\\Media\\Map\\ring")
	rim:SetAllPoints(mm)
	local player = mm:CreateTexture(nil, "OVERLAY", nil, 7)
	player:SetTexture("Interface\\Minimap\\MinimapArrow")
	player:SetSize(28, 28)
	player:SetPoint("CENTER")
	local mmLabel = W.Text(f, "caption", "textMuted")
	mmLabel:SetText(L["Minimap"])
	mmLabel:SetPoint("TOP", mm, "BOTTOM", 0, -4)
	local mmGiver, mmStep, mmTarget = newPin(mm), newPin(mm), newPin(mm)
	f.Map, f.Minimap = { area = area, giver = giver, target = target, steps = steps, dots = dots }, { giver = mmGiver, step = mmStep, target = mmTarget }

	local width, mapW, paintedW, dirty = 0, 0, nil, true
	local function paint()
		if mapW <= 0 then return end -- not laid out yet: Layout paints
		dirty = false
		local h = MAP_H
		if art and paintedW ~= mapW then
			paintedW = mapW
			art.psW = mapW
			art:SetWidth(mapW)
			ZA.Paint(art, ZONE, 42, 64, 2)
		end
		local function at(spot) return spot[1] * mapW, spot[2] * h end
		local arrow = rgb("arrow")
		-- The target in its spawn area, as Nav's own layer (Layers.TargetLook).
		local glow, pulse, grow, scale = Layers.TargetLook()
		local tp = { icon = "map:target", color = arrow, glow = glow, pulse = pulse, grow = grow }
		local ax, ay = at(SPOTS.area)
		local d = h * 0.46
		area:SetSize(d, d)
		area:ClearAllPoints()
		area:SetPoint("CENTER", layer, "TOPLEFT", ax, -ay)
		area:SetVertexColor(Pins.AreaColor({ color = arrow }))
		worldPin(target, layer, tp, scale, ax, ay)
		-- A quest giver, in the quest colour.
		local gp = { icon = "map:quest-available", color = rgb("quest") }
		local gx, gy = at(SPOTS.giver)
		worldPin(giver, layer, gp, 1, gx, gy)
		-- The next three steps, numbered, fading (Upcoming.Look).
		for i, s in ipairs(steps) do
			local p, numbered = Upcoming.Look(i, #steps)
			p.text = numbered and tostring(i) or nil
			local x, y = at(SPOTS.steps[i])
			worldPin(s, layer, p, 1, x, y)
		end
		-- The trail toward the target, while it stands in for route lines.
		local trailOn = ns.Get("nav.trailDots") and not ns.Get("nav.routeLines")
		local sx, sy = at(SPOTS.trail)
		local size = 6 * Pins.look.dotSize
		for i, t in ipairs(dots) do
			local u = i / (#dots + 1)
			t:SetSize(size, size)
			t:SetVertexColor(arrow[1], arrow[2], arrow[3], Pins.look.dotAlpha)
			t:ClearAllPoints()
			t:SetPoint("CENTER", layer, "TOPLEFT", sx + (ax - sx) * u, -(sy + (ay - sy) * u))
			t:SetShown(trailOn and true or false)
		end
		-- The minimap sample.
		minimapPin(mmGiver, mm, gp, 1, MM_SPOTS.giver[1], MM_SPOTS.giver[2])
		local sp, numbered = Upcoming.Look(1, 3)
		sp.text = numbered and "1" or nil
		minimapPin(mmStep, mm, sp, 1, MM_SPOTS.step[1], MM_SPOTS.step[2])
		mmStep:SetShown(ns.Get("nav.upcomingMinimap") ~= false)
		minimapPin(mmTarget, mm, tp, scale, MM_SPOTS.target[1], MM_SPOTS.target[2])
		local rr, rg, rb = Theme.Color("textDim")
		rim:SetVertexColor(rr, rg, rb, 0.6)
	end
	f.Paint = paint
	-- Settings and theme changes repaint only while shown; else on the next show.
	ns.On("SETTING_CHANGED", function(path)
		if not KEYS[path] then return end
		if f:IsVisible() then paint() else dirty = true end
	end)
	W.Painter(f.Map, function()
		if f:IsVisible() then paint() else dirty = true end
	end)
	f:SetScript("OnShow", function() if dirty then paint() end end)

	function f:Layout(w)
		self:SetWidth(w)
		local resized = w ~= width
		width = w
		mapW = max(120, width - 2 * PAD - MM_COL)
		map:SetWidth(mapW)
		mm:ClearAllPoints()
		mm:SetPoint("CENTER", f, "TOPLEFT", PAD + mapW + MM_COL / 2, -(TOP + (MAP_H - 18) / 2))
		local band = rawget(f, "Band")
		if band then band:SetTexCoord(Theme.BandCoords(mapW, MAP_H)) end
		-- The window lays the stage out again after every setting: its own repaint has run.
		if dirty or resized then paint() end
		return STAGE_H
	end
	return f
end
-- The preview, for the tests: PinsPreview(parent) -> f.
Nav.PinsPreview = buildPreview

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
	local path = Pins.MedalPath(value)
	medal:SetSize(size, size)
	medal:SetTexture(path)
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

local SPECS = {
	-- The steps ahead: the numbered pins (Silverina's request: bigger ones).
	{ page = PAGE, key = "mappins", icon = "icon-goto", order = 23, group = "look", tab = L["Steps ahead"], section = L["Numbered pins"],
		preview = buildPreview,
		subtitle = L["Every mark Polestar draws on the world map and the minimap: the steps ahead, the target, icons, areas and the trail. The preview repaints as you change them; right-click a setting to reset it."],
		controls = {
		{ kind = "toggle", key = "nav.upcomingPins", label = L["Numbered pins for the steps ahead"],
			search = "upcoming, next steps, numbers, numbered, step pins, ahead, preview, plan",
			help = L["A small pin with its step number where each of the next steps takes you, fainter the further ahead."] },
		{ kind = "slider", key = "nav.stepPinSize", label = L["Pin size"], min = 0.6, max = 3, step = 0.05, format = percent, new = NEW,
			search = "bigger, larger, size, scale, huge, tiny, smaller, numbered pins, step pins, readable, see",
			help = L["The numbered pins on the world map and the minimap. Bigger pins also grow past the usual limit on screen. Right-click to reset."] },
		{ kind = "slider", key = "nav.upcomingCount", label = L["Steps ahead"], min = 0, max = 15, step = 1, format = stepsAhead, new = NEW,
			search = "how many, count, number of steps, next steps, more, fewer, up next",
			help = L["How many of the next steps get a pin. As Up next: as many as the guide window's Up next shows, else five."] },
		{ kind = "slider", key = "nav.stepAlpha", label = L["Next step's opacity"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW,
			search = "opacity, transparency, alpha, faint, see through, nearest",
			help = L["The pin of the very next step. Right-click to reset."] },
		{ kind = "slider", key = "nav.stepFadeTo", label = L["Farthest step's opacity"], min = 0.05, max = 1, step = 0.05, format = percent, new = NEW,
			search = "fade, fading, opacity, transparency, alpha, faint, how fast, last step",
			help = L["The steps fade from the next one's opacity down to this; the same as the next step's: no fading. Right-click to reset."] },
		{ kind = "toggle", key = "nav.upcomingMinimap", label = L["On the minimap too"], new = NEW, child = true, disabled = upcomingOff,
			search = "minimap, radar, numbered pins, steps ahead, clutter",
			help = L["Off: the numbered pins show on the world map only."] },
	} },
	{ page = PAGE, tab = L["Steps ahead"], section = L["Colours"], controls = {
		{ kind = "dropdown", key = "nav.stepColorMode", label = L["Pin colour"], new = NEW,
			search = "colour, color, tint, accent, by step, rainbow, different colours, own colour",
			help = L["The accent, a colour for each step ahead so they tell apart, or a colour of your own."],
			choices = { { value = "accent", label = L["Accent"] }, { value = "steps", label = L["A colour for each step"] }, { value = "own", label = L["My own colour"] } } },
		{ kind = "color", key = "nav.stepColor", label = L["Own colour"], new = NEW, child = true,
			disabled = function() return ns.Get("nav.stepColorMode") ~= "own" end,
			search = "colour, color, tint, custom, pick, step pins",
			help = L["The numbered pins' colour with My own colour. Right-click to go back to the accent."],
			shown = function() return Upcoming.Color(1) end, source = function() return L["Accent"] end },
		{ kind = "color", key = "nav.stepRingColor", label = L["Rim colour"], new = NEW,
			search = "rim, ring, border, outline, edge, colour, color",
			help = L["The thin ring around each numbered pin. Right-click to go back to the medallion tint, else white."],
			shown = function()
				local c = ns.Get("nav.medalColor")
				if type(c) == "table" then return c[1], c[2], c[3] end
				return 1, 1, 1
			end,
			source = function() return L["White"] end },
	} },
	{ page = PAGE, tab = L["Steps ahead"], section = L["Numbers"], controls = {
		{ kind = "toggle", key = "nav.stepNumbers", label = L["Show the step numbers"], new = NEW,
			search = "numbers, numbered, digits, labels, text, step number",
			help = L["Off: plain pins without their number."] },
		{ kind = "slider", key = "nav.stepNumberSize", label = L["Number size"], min = 0.6, max = 2, step = 0.05, format = percent, new = NEW, child = true,
			disabled = numbersOff, search = "font size, number size, bigger numbers, text size, readable, larger",
			help = L["The number on each pin, with the pin's own size. Right-click to reset."] },
		{ kind = "color", key = "nav.stepNumberColor", label = L["Number colour"], new = NEW, child = true, disabled = numbersOff,
			search = "number colour, text colour, font colour, color, white, contrast",
			help = L["Right-click to go back to white."],
			shown = function() return 1, 1, 1 end, source = function() return L["White"] end },
		{ kind = "dropdown", key = "nav.stepNumberOutline", label = L["Number outline"], new = NEW, child = true, disabled = numbersOff,
			search = "outline, shadow, border, thick, contrast, readable, font",
			help = L["The dark edge around each number, so it reads on any map."],
			choices = { { value = "OUTLINE", label = L["Thin"] }, { value = "THICKOUTLINE", label = L["Thick"] }, { value = "NONE", label = L["None"] } } },
	} },

	-- The target and every other mark.
	{ page = PAGE, tab = L["Pins & icons"], section = L["Target"], preview = buildPreview, controls = {
		{ kind = "slider", key = "nav.targetPinSize", label = L["Target pin size"], min = 0.6, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "target, waypoint, goal, destination, bigger, size, scale, huge, tiny",
			help = L["The pin the arrow points to, on the world map and the minimap. Right-click to reset."] },
		{ kind = "toggle", key = "nav.targetGlow", label = L["Glow around the target"], new = NEW,
			search = "glow, halo, light, shine, highlight, target",
			help = L["The soft halo in the arrow's colour under the target's pin."] },
		{ kind = "toggle", key = "nav.targetPulse", label = L["Pulse"], new = NEW, child = true, disabled = glowOff,
			search = "pulse, breathe, animation, blink, flash, motion, attention",
			help = L["The glow breathes slowly so the target catches the eye. Still with Reduce motion."] },
		{ kind = "slider", key = "nav.pulseSeconds", label = L["Pulse speed"], min = 0.4, max = 2, step = 0.1, format = seconds, new = NEW, child = true,
			disabled = function() return glowOff() or not ns.Get("nav.targetPulse") end,
			search = "pulse speed, faster, slower, animation, breathe, tempo",
			help = L["One breath of the pulse: shorter is faster. Right-click to reset."] },
	} },
	{ page = PAGE, tab = L["Pins & icons"], section = L["Icons"], controls = {
		{ kind = "cards", key = "nav.mapIcons", label = L["Icon pack"], search = "icon pack, medallion, icons, marks, style, halo, hearth, glyphs, bare",
			help = L["The medallion under every mark on the world map and the minimap. The skin's: Polestar's, Halo's, or Hearth's for Hearth and the game's own looks. Glyphs only: no medallion."],
			choices = packChoices },
		{ kind = "slider", key = "nav.worldIconSize", label = L["World map icon size"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW,
			search = "bigger, larger, size, scale, huge, tiny, smaller, world map, icons, marks, pins, readable",
			help = L["Every Polestar mark on the world map, the numbered pins too; they also grow past the usual limit on screen. Right-click to reset."] },
		{ kind = "slider", key = "nav.worldPinAlpha", label = L["World map icon opacity"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW,
			search = "opacity, transparency, alpha, faint, see through, world map, icons",
			help = L["Every Polestar mark on the world map. Right-click to reset."] },
		{ kind = "color", key = "nav.medalColor", label = L["Medallion tint"], new = NEW,
			search = "medallion, border, backing, frame, ring, tint, colour, color",
			help = L["A colour laid over every medallion and the numbered pins' rims. Right-click for none."],
			shown = function() return 1, 1, 1 end, source = function() return L["None"] end },
		{ kind = "color", key = "nav.pinBacking", label = L["Icon backing"], new = NEW,
			search = "backing, background, disc, dark, behind, contrast, colour, color",
			help = L["The dark disc under the other skins' icons and the rare and death marks. Right-click to go back to the scheme's."],
			shown = function() return Theme.Color("scrim") end, source = function() return L["Scheme"] end },
		{ kind = "slider", key = "nav.badgeSize", label = L["Count badge size"], min = 0.7, max = 2, step = 0.05, format = percent, new = NEW,
			search = "badge, count, capsule, number, cluster, services, bigger, font",
			help = L["The small count on a group of services and the ? on an unknown flight master. Right-click to reset."] },
	} },

	-- Spawn areas and the trail.
	{ page = PAGE, tab = L["Areas & trail"], section = L["Spawn areas"], preview = buildPreview, controls = {
		{ kind = "slider", key = "nav.areaAlpha", label = L["Area opacity"], min = 0, max = 1, step = 0.02, format = percent, new = NEW,
			search = "area, region, spawn, tint, opacity, transparency, alpha, blob, circle, zone, quest area",
			help = L["The soft tint over the places mobs and objects spawn, on the world map and the minimap; their outlines with it. Right-click to reset."] },
		{ kind = "color", key = "nav.areaColor", label = L["Area colour"], new = NEW,
			search = "area colour, region, spawn, tint, colour, color, blob",
			help = L["Every area in one colour. Right-click to go back to each in its own pin's colour."],
			shown = function() return Theme.Color("arrow") end, source = function() return L["The pin's colour"] end },
	} },
	{ page = PAGE, tab = L["Areas & trail"], section = L["Trail dots"], controls = {
		H({ kind = "toggle", key = "nav.trailDots", label = L["Trail dots along the travel route"],
			help = L["Moving dots from you to the target on the world map and the minimap, along the travel route, while route lines are off."],
			search = "trail, dots, path, route, breadcrumbs",
			disabled = function() return ns.Get("nav.routeLines") end }),
		{ kind = "slider", key = "nav.trailDotSize", label = L["Dot size"], min = 0.5, max = 2.5, step = 0.05, format = percent, new = NEW, child = true,
			disabled = function() return ns.Get("nav.routeLines") or not ns.Get("nav.trailDots") end,
			search = "trail, dots, size, bigger, smaller, path",
			help = L["Right-click to reset."] },
		{ kind = "slider", key = "nav.trailDotAlpha", label = L["Dot opacity"], min = 0.1, max = 1, step = 0.05, format = percent, new = NEW, child = true,
			disabled = function() return ns.Get("nav.routeLines") or not ns.Get("nav.trailDots") end,
			search = "trail, dots, opacity, transparency, alpha, faint",
			help = L["Right-click to reset."] },
	} },

	-- The minimap.
	{ page = PAGE, tab = L["Minimap"], section = L["Minimap marks"], preview = buildPreview, controls = {
		{ kind = "slider", key = "nav.minimapIconSize", label = L["Minimap icon size"], min = 0.5, max = 1.5, step = 0.05, format = percent,
			search = "minimap, radar, icons, marks, bigger, smaller, size, scale",
			help = L["Polestar's marks on the minimap; the world map keeps its own. Right-click to reset."] },
		{ kind = "slider", key = "nav.minimapPinAlpha", label = L["Minimap icon opacity"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW,
			search = "minimap, radar, opacity, transparency, alpha, faint, see through",
			help = L["Every Polestar mark on the minimap. Right-click to reset."] },
		{ kind = "toggle", key = "nav.minimapArrowFade", label = L["Fade over my arrow"], new = NEW,
			search = "minimap, player arrow, fade, cover, hide, see my arrow, center",
			help = L["A mark over your arrow at the minimap's centre fades so the arrow shows through it. The game draws the arrow under every addon's marks."] },
	} },

	-- What shows (the Map page has these too); the steps ahead's own switch is on their tab.
	{ page = PAGE, tab = L["Pins & icons"], section = L["What shows"], controls = {
		{ kind = "toggle", key = "nav.worldPins", label = L["Guide pins on the world map"], search = "map pins, icons, markers, waypoint, world map, show, hide",
			help = L["The arrow's target, the stops of its travel route, the step's other goals, the areas their mobs and objects spawn in, and the route lines."] },
		{ kind = "toggle", key = "nav.minimapPins", label = L["Guide pin on the minimap"], search = "map pins, icons, markers, waypoint, minimap, show, hide",
			help = L["The arrow's target, the areas it spawns in, and the route line."] },
	} },
}

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
