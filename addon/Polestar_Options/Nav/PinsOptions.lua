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
-- by Pins' own code (Pins.BuildLook, Pins.ApplyLook and its size functions)
-- over a zone painting (UI.ZoneArt; the night band where there is none):
--   Pins   the target in its spawn area, the trail toward it, a dotted route
--          through the numbered pins at their true on-map size (shown as a
--          sample while the numbered pins are off), a "Pin size" inset (100%
--          against yours), the zoom (zoomed out / in) and a minimap disc;
--   Icons  a row of map marks in the icon pack at full size, one a group with
--          its count badge, and a minimap disc.
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

local STAGE_H, ZONE = 196, 1429 -- Elwynn Forest, as the welcome's demo
-- The window's chrome sits over the stage ("Preview" top left, "Live" top right): the
-- painting starts below it, inset by the body's pad.
-- BOTTOM leaves room for the window's one-time hint under the band.
local PAD, TOP, BOTTOM = 32, 34, 28
local MAP_H = STAGE_H - TOP - BOTTOM
local MM, MM_COL = 104, 136 -- the minimap disc and its column
local ZOOM_OUT, ZOOM_IN = 0, 1 -- the world map's zoom (Pins.WorldScale)
local MM_ZOOM = 0.7 -- the minimap's widest zoom, its default
local STEPS = 5 -- numbered pins in the preview, at most

-- Where things sit on the Pins painting (fractions of its width and height):
-- the player, the target in its area, the numbered pins after it.
local SPOTS = {
	player = { 0.05, 0.84 }, target = { 0.2, 0.5 },
	steps = { { 0.34, 0.34 }, { 0.45, 0.68 }, { 0.56, 0.36 }, { 0.67, 0.7 }, { 0.78, 0.5 } },
}
-- The Icons painting: the marks in a row (map mark, subject colour), one a group with a badge.
local MARKS = {
	{ "map:quest-available", "quest" }, { "map:quest-turnin", "quest" }, { "map:kill", "danger" },
	{ "map:flightmaster", "place" }, { "map:inn", "place", 3 }, { "map:dungeon", "dungeon" },
}
-- The minimap samples (px from the centre, y up): a mark over the player's arrow, then others.
local MM_PINS = { { 4, 3 }, { 24, -18 }, { -26, 20 } }

-- The keys the previews repaint on (besides the theme).
local KEYS = {
	["nav.mapIcons"] = true, ["nav.minimapIconSize"] = true, ["nav.arrowColor"] = true, ["nav.routeLines"] = true,
	["nav.trailDots"] = true, ["nav.targetPinSize"] = true, ["nav.targetGlow"] = true, ["nav.targetPulse"] = true,
	["nav.minimapPins"] = true, ["nav.worldPins"] = true,
	["ui.reduceMotion"] = true, ["ui.upcoming"] = true, ["nav"] = true, ["ui"] = true, [""] = true,
}
for k in pairs(Pins.LOOK_KEYS) do KEYS[k] = true end
for k in pairs(Upcoming.KEYS) do KEYS[k] = true end

local zoomedIn = true -- the Pins preview's zoom, kept for the session

local function rgb(name)
	local r, g, b = Theme.Color(name)
	return { r, g, b, 1 }
end

local function newPin(parent)
	local f = CreateFrame("Frame", nil, parent)
	Pins.BuildLook(f)
	return f
end

-- A click target on a part of preview f (the window's hotspots, on its
-- host `view`): hover outlines it, a click jumps to the setting's row.
-- f.psHotspots lists them: { { key, button }, ... }. (Fields on frames are
-- lower case: a frame answers capitalised names with its methods.)
local function hotspot(f, view, region, key)
	if not (view and view.Hotspot) then return end
	local b = view:Hotspot(region, key)
	f.psHotspots = f.psHotspots or {}
	f.psHotspots[#f.psHotspots + 1] = { key, b }
end

-- The scale that draws a child of `parent` at its true size on screen (the
-- game's UI scale), whatever the settings window's own scale.
local function trueScale(parent)
	local u = UIParent and UIParent.GetEffectiveScale and UIParent:GetEffectiveScale() or 1
	local e = parent.GetEffectiveScale and parent:GetEffectiveScale() or u
	if not (u and e and e > 0) then return 1 end
	return u / e
end

-- Paint sandbox pin frame f with pin p at layer scale `scale`, as the world
-- map does at `zoom` and at its true size on screen, centred on (x, y) px
-- from parent's top left. -> its medallion across, in parent's units
local function worldPin(f, parent, p, scale, x, y, zoom)
	Pins.ApplyLook(f, p, Pins.WorldPinSize(p, scale))
	local k = Pins.WorldScale(f, zoom) * trueScale(parent)
	f:SetScale(k)
	f:SetAlpha(Pins.look.worldAlpha)
	f:ClearAllPoints()
	f:SetPoint("CENTER", parent, "TOPLEFT", x / k, -y / k)
	f:Show()
	return f.footPx * k
end

-- The same on a minimap disc: its size at its widest zoom and the player's
-- minimap icon size, faded over the arrow as there.
local function minimapPin(f, parent, p, scale, x, y)
	local sizeK = tonumber(ns.Get("nav.minimapIconSize")) or 1
	Pins.ApplyLook(f, p, Pins.MinimapPinSize(p, scale, MM_ZOOM, sizeK))
	local fade = Pins.look.arrowFade and Pins.ArrowFade(x, y, f.footPx) or 1
	local k = trueScale(parent)
	f:SetScale(k)
	f:SetAlpha(fade * Pins.look.mmAlpha)
	f:ClearAllPoints()
	f:SetPoint("CENTER", parent, "CENTER", x / k, y / k)
	f:Show()
end

-- The stage (the settings window's, UI.Preview.Stage, on its plain ground:
-- the painting is the scene), a painting `art` of the zone in `map` (the
-- night band without art), a layer over it for the marks, and a minimap
-- disc at the right with the player's arrow.
local function stage(view, mapLabel)
	local f = ns.UI.Preview.Stage(view, { height = STAGE_H, backdrop = "ground", fixed = true })

	local map = CreateFrame("Frame", nil, f)
	map:SetPoint("TOPLEFT", f, "TOPLEFT", PAD, -TOP)
	map:SetHeight(MAP_H)
	if map.SetClipsChildren then map:SetClipsChildren(true) end
	local ZA = ns.UI and ns.UI.ZoneArt
	if ZA then
		f.psArt = ZA.Create(map, 400, MAP_H, "scrim")
		f.psArt:SetPoint("TOPLEFT", map, "TOPLEFT", 0, 0)
	else
		f.psBand = Theme.Band(map, "BACKGROUND", -7)
		f.psBand:SetAllPoints(map)
	end
	local layer = CreateFrame("Frame", nil, map)
	layer:SetAllPoints(map)
	layer:SetFrameLevel((f.psArt and f.psArt.Over or map):GetFrameLevel() + 2)
	local label = W.Text(layer, "caption", "textMuted")
	label:SetText(mapLabel)
	label:SetPoint("TOPLEFT", map, "TOPLEFT", 10, -8)

	local mm = CreateFrame("Frame", nil, f)
	mm:SetSize(MM, MM)
	local ground = mm:CreateTexture(nil, "BACKGROUND")
	ground:SetTexture(NAV_MEDIA .. "pin-fill")
	ground:SetPoint("CENTER")
	ground:SetSize(MM * 64 / 42, MM * 64 / 42) -- pin-fill's disc covers 42 of its 64 pixels
	ground:SetVertexColor(0.16, 0.2, 0.13, 1)
	local rim = mm:CreateTexture(nil, "BORDER")
	rim:SetTexture(MAP_MEDIA .. "ring")
	rim:SetAllPoints(mm)
	W.Painter(rim, function(t)
		local r, g, b = Theme.Color("textDim")
		t:SetVertexColor(r, g, b, 0.6)
	end)
	local player = mm:CreateTexture(nil, "OVERLAY", nil, 7)
	player:SetTexture("Interface\\Minimap\\MinimapArrow")
	player:SetSize(26, 26)
	player:SetPoint("CENTER")
	local mmLabel = W.Text(f, "caption", "textMuted")
	mmLabel:SetText(L["Minimap"])
	mmLabel:SetPoint("TOP", mm, "BOTTOM", 0, -4)

	f.MapFrame, f.Layer, f.MinimapFrame = map, layer, mm
	f.psWidth, f.mapW, f.dirty = 0, 0, true
	-- -> the painting's width for the stage's width, and lays it out.
	function f:Place(w)
		local resized = w ~= self.psWidth
		self:SetWidth(w)
		self.psWidth = w
		self.mapW = max(160, w - 2 * PAD - MM_COL)
		map:SetWidth(self.mapW)
		mm:ClearAllPoints()
		mm:SetPoint("CENTER", self, "TOPLEFT", PAD + self.mapW + MM_COL / 2, -(TOP + (MAP_H - 16) / 2))
		if self.psBand then self.psBand:SetTexCoord(Theme.BandCoords(self.mapW, MAP_H)) end
		if self.psArt and self.paintedW ~= self.mapW then
			self.paintedW = self.mapW
			self.psArt.psW = self.mapW
			self.psArt:SetWidth(self.mapW)
			ZA.Paint(self.psArt, ZONE, 42, 64, 2)
		end
		return resized
	end
	-- Repaints on its settings and the theme only while shown; else on the next show.
	function f:Watch(paint)
		ns.On("SETTING_CHANGED", function(path)
			if not KEYS[path] then return end
			if self:IsVisible() then paint() else self.dirty = true end
		end)
		W.Painter(layer, function()
			if self:IsVisible() then paint() else self.dirty = true end
		end)
		self:SetScript("OnShow", function() if self.dirty then paint() end end)
		function self:Layout(w)
			local resized = self:Place(w)
			-- The window lays the stage out again after every setting: its own repaint has run.
			if self.dirty or resized then paint() end
			return STAGE_H
		end
	end
	return f
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

-- The zoom switch at the painting's bottom right: "Zoomed out | Zoomed in".
local function zoomSwitch(f, onChange)
	local box = CreateFrame("Frame", nil, f.Layer)
	box:SetSize(1, 20)
	box:SetPoint("BOTTOMRIGHT", f.MapFrame, "BOTTOMRIGHT", -8, 6)
	W.Fill(box, "scrim", "BACKGROUND", -1)
	local buttons = {}
	local function paint()
		for _, b in ipairs(buttons) do
			local on = b.psIn == zoomedIn
			W.Color(b.Text, on and "text" or "textMuted")
			b.Wash:SetShown(on)
		end
	end
	local x = 0
	for i, spec in ipairs({ { false, L["Zoomed out"] }, { true, L["Zoomed in"] } }) do
		local b = CreateFrame("Button", nil, box)
		b.psIn = spec[1]
		b.Text = W.Text(b, "caption", "textMuted")
		b.Text:SetText(spec[2])
		b.Text:SetPoint("CENTER")
		b.Wash = W.Fill(b, "selected", "BACKGROUND", 0)
		local w = math.ceil(b.Text:GetStringWidth() or 60) + 16
		b:SetSize(w, 20)
		b:SetPoint("LEFT", box, "LEFT", x, 0)
		x = x + w
		b:SetScript("OnClick", function(self)
			if zoomedIn == self.psIn then return end
			zoomedIn = self.psIn
			paint()
			onChange()
		end)
		buttons[i] = b
	end
	box:SetWidth(x)
	paint()
	return box, buttons
end

-- The Pins tab: the target in its area and the trail toward it, the numbered
-- pins on a dotted route, the "Pin size" inset, the minimap.
local function buildPinsPreview(view)
	local f = stage(view, L["World map"])
	local layer, mm = f.Layer, f.MinimapFrame
	f.caption = function()
		local where = zoomedIn and L["Elwynn Forest, zoomed in"] or L["Elwynn Forest, zoomed out"]
		if not ns.Get("nav.upcomingPins") then return where .. " · " .. L["numbered pins as a sample"] end
		return where
	end

	local area = layer:CreateTexture(nil, "BACKGROUND")
	area:SetTexture(NAV_MEDIA .. "area")
	local player = layer:CreateTexture(nil, "OVERLAY")
	player:SetTexture("Interface\\Minimap\\MinimapArrow")
	player:SetSize(22, 22)
	local dots = {}
	local target = newPin(layer)
	target:SetFrameLevel(layer:GetFrameLevel() + 3)
	local steps = {}
	for i = 1, STEPS do steps[i] = newPin(layer) end

	-- "Pin size": the numbered pin at 100% beside yours, at the map's zoom.
	local inset = CreateFrame("Frame", nil, layer)
	inset:SetPoint("TOPRIGHT", f.MapFrame, "TOPRIGHT", -8, -8)
	inset:SetFrameLevel(layer:GetFrameLevel() + 5)
	W.Fill(inset, "scrim", "BACKGROUND", -1)
	W.Painter(inset, function(self) Theme.Border(self, Theme.Wash("divider")) end)
	local insetTitle = W.Text(inset, "caption", "text")
	insetTitle:SetText(L["Pin size"])
	insetTitle:SetPoint("TOPLEFT", inset, "TOPLEFT", 10, -8)
	local base, yours = newPin(inset), newPin(inset)
	local baseText, yoursText = W.Text(inset, "small", "textMuted"), W.Text(inset, "small", "text")

	local zoom = zoomSwitch(f, function() f.Paint() end)
	local mmTarget, mmStep, mmGiver = newPin(mm), newPin(mm), newPin(mm)
	f.Map = { area = area, target = target, steps = steps, dots = dots, inset = { base = base, yours = yours } }
	f.Minimap = { target = mmTarget, step = mmStep, giver = mmGiver }
	f.Zoom = zoom

	local function paint()
		if f.mapW <= 0 then return end -- not laid out yet: Layout paints
		f.dirty = false
		local w, h = f.mapW, MAP_H
		local z = zoomedIn and ZOOM_IN or ZOOM_OUT
		local function at(spot) return spot[1] * w, spot[2] * h end
		local arrow = rgb("arrow")
		-- The target in its spawn area, as Nav's own layer (Layers.TargetLook).
		local glow, pulse, grow, scale = Layers.TargetLook()
		local tp = { icon = "map:target", color = arrow, glow = glow, pulse = pulse, grow = grow }
		local tx, ty = at(SPOTS.target)
		local d = h * (zoomedIn and 0.62 or 0.4)
		area:SetSize(d, d)
		area:ClearAllPoints()
		area:SetPoint("CENTER", layer, "TOPLEFT", tx, -ty)
		area:SetVertexColor(Pins.AreaColor({ color = arrow }))
		worldPin(target, layer, tp, scale, tx, ty, z)
		-- The trail from the player to the target, while it stands in for route lines.
		local px, py = at(SPOTS.player)
		local c = trueScale(layer)
		player:SetSize(22 * c, 22 * c)
		player:ClearAllPoints()
		player:SetPoint("CENTER", layer, "TOPLEFT", px, -py)
		local n = 0
		if trailShown() then
			n = dotLine(dots, layer, n, { { px, py }, { tx, ty } }, 12 * c, 6 * c * Pins.look.dotSize, arrow[1], arrow[2], arrow[3], Pins.look.dotAlpha)
		end
		-- The numbered pins (Upcoming.Look), as many as the steps ahead, on a dotted route.
		local count = min(STEPS, Upcoming.Count())
		local route = { { tx, ty } }
		for i, s in ipairs(steps) do
			if i <= count then
				local p, numbered = Upcoming.Look(i, count)
				p.text = numbered and tostring(i + 1) or nil
				local x, y = at(SPOTS.steps[i])
				worldPin(s, layer, p, 1, x, y, z)
				route[#route + 1] = { x, y }
			else
				s:Hide()
			end
		end
		local mr, mg, mb = Theme.Color("textDim")
		n = dotLine(dots, layer, n, route, 7, 2.5, mr, mg, mb, 0.55)
		for i = n + 1, #dots do dots[i]:Hide() end
		-- The inset: 100% beside yours.
		local mine = tonumber(ns.Get("nav.stepPinSize")) or 1
		local bp, bn = Upcoming.Look(1, 1, 1)
		local yp, yn = Upcoming.Look(1, 1)
		bp.text, yp.text = bn and "2" or nil, yn and "2" or nil
		baseText:SetText(percent(1))
		yoursText:SetText(string.format(L["%s, yours"], percent(mine)))
		base:SetScale(1)
		yours:SetScale(1)
		local s1 = max(16, worldPin(base, inset, bp, 1, 0, 0, z))
		local s2 = max(16, worldPin(yours, inset, yp, 1, 0, 0, z))
		local col = max(s1, s2)
		local y1 = 26 + s1 / 2
		local y2 = 26 + s1 + 6 + s2 / 2
		worldPin(base, inset, bp, 1, 10 + col / 2, y1, z)
		worldPin(yours, inset, yp, 1, 10 + col / 2, y2, z)
		baseText:ClearAllPoints()
		baseText:SetPoint("LEFT", inset, "TOPLEFT", 18 + col, -y1)
		yoursText:ClearAllPoints()
		yoursText:SetPoint("LEFT", inset, "TOPLEFT", 18 + col, -y2)
		local textW = max(insetTitle:GetStringWidth() or 0, (yoursText:GetStringWidth() or 0) + 8 + col)
		inset:SetSize(20 + math.ceil(textW), math.ceil(26 + s1 + 6 + s2 + 10))
		-- The minimap: the target, the next step, a quest giver over the arrow.
		minimapPin(mmTarget, mm, tp, scale, MM_PINS[3][1], MM_PINS[3][2])
		mmTarget:SetShown(ns.Get("nav.minimapPins") and true or false)
		local sp, numbered = Upcoming.Look(1, count)
		sp.text = numbered and "2" or nil
		minimapPin(mmStep, mm, sp, 1, MM_PINS[2][1], MM_PINS[2][2])
		mmStep:SetShown(ns.Get("nav.upcomingMinimap") ~= false)
		minimapPin(mmGiver, mm, { icon = "map:quest-available", color = rgb("quest") }, 1, MM_PINS[1][1], MM_PINS[1][2])
	end
	f.Paint = paint
	f:Watch(paint)

	-- Click a part to find its setting.
	hotspot(f, view, area, "nav.areaAlpha")
	hotspot(f, view, target, "nav.targetPinSize")
	for _, s in ipairs(steps) do hotspot(f, view, s, "nav.stepPinSize") end
	hotspot(f, view, inset, "nav.stepPinSize")
	hotspot(f, view, mm, "nav.stepMinimapSize")
	return f
end

-- The Icons tab: the map marks in the icon pack at full size (the world map
-- zoomed in), one a group with its count badge, and the minimap.
local function buildIconsPreview(view)
	local f = stage(view, L["World map"])
	local layer, mm = f.Layer, f.MinimapFrame
	f.caption = L["Every mark at full size, the minimap at its widest"]
	local marks = {}
	for i = 1, #MARKS do marks[i] = newPin(layer) end
	local mmPins = { newPin(mm), newPin(mm), newPin(mm) }
	f.Marks, f.Minimap = marks, mmPins

	local function paint()
		if f.mapW <= 0 then return end
		f.dirty = false
		local w, h = f.mapW, MAP_H
		local step = w / (#MARKS + 1)
		for i, m in ipairs(MARKS) do
			local p = { icon = m[1], color = rgb(m[2]), badge = m[3] }
			worldPin(marks[i], layer, p, 1, step * i, h * (i % 2 == 0 and 0.58 or 0.4), ZOOM_IN)
		end
		for i, at in ipairs(MM_PINS) do
			local m = MARKS[i]
			minimapPin(mmPins[i], mm, { icon = m[1], color = rgb(m[2]) }, 1, at[1], at[2])
		end
	end
	f.Paint = paint
	f:Watch(paint)

	for i, m in ipairs(marks) do hotspot(f, view, m, MARKS[i][3] and "nav.badgeSize" or "nav.worldIconSize") end
	hotspot(f, view, mm, "nav.minimapIconSize")
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
	-- Where a card's pins sit (fractions of its art): the target, three steps.
	local CARD_SPOTS = { target = { 0.2, 0.56 }, steps = { { 0.44, 0.3 }, { 0.64, 0.66 }, { 0.84, 0.34 } } }
	-- A preset's card: a corner of Elwynn with the target and three numbered
	-- pins on their route, drawn by Pins' own look code with the preset's
	-- values (Pins' look is read again after, for the live pins).
	local function drawPreset(art, _, values)
		local w, h = art:GetWidth(), art:GetHeight()
		if not (w and w > 0) then w = W.CARD_W - 2 end
		if not (h and h > 0) then h = W.CARD_ART end
		local ZA = ns.UI and ns.UI.ZoneArt
		if not art.psLayer then
			local ground = art
			if ZA then
				art.psZone = ZA.Create(art, w, h, "panelAlt")
				art.psZone:SetPoint("TOPLEFT", art, "TOPLEFT", 0, 0)
				ZA.Paint(art.psZone, ZONE, 42, 64, 3)
				ground = art.psZone.Over or art.psZone
			end
			local layer = CreateFrame("Frame", nil, art)
			layer:SetAllPoints(art)
			layer:SetFrameLevel(ground:GetFrameLevel() + 2)
			art.psLayer, art.psTarget, art.psDots = layer, newPin(layer), {}
			art.psSteps = { newPin(layer), newPin(layer), newPin(layer) }
		end
		local layer = art.psLayer
		O.WithSettings(values, function()
			Pins.ReadLook()
			local arrow = rgb("arrow")
			local glow, _, grow, scale = Layers.TargetLook()
			local tx, ty = CARD_SPOTS.target[1] * w, CARD_SPOTS.target[2] * h
			worldPin(art.psTarget, layer, { icon = "map:target", color = arrow, glow = glow, grow = grow }, scale, tx, ty, ZOOM_OUT)
			local route = { { tx, ty } }
			for i, s in ipairs(art.psSteps) do
				local p, numbered = Upcoming.Look(i, #art.psSteps)
				p.text = numbered and tostring(i + 1) or nil
				local x, y = CARD_SPOTS.steps[i][1] * w, CARD_SPOTS.steps[i][2] * h
				worldPin(s, layer, p, 1, x, y, ZOOM_OUT)
				route[#route + 1] = { x, y }
			end
			local mr, mg, mb = Theme.Color("textDim")
			local n = dotLine(art.psDots, layer, 0, route, 7, 2, mr, mg, mb, 0.55)
			for i = n + 1, #art.psDots do art.psDots[i]:Hide() end
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
