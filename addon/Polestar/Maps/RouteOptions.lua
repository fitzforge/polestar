-- The Route lines page of Polestar's settings window (Look, key "routelines";
-- docs/ARCHITECTURE.md, "Maps"): every setting of the route lines'
-- look (Maps/RouteLines.lua) over a live preview of them. The gear beside
-- Guide > Arrow & routes > "Route lines" opens it (UI.ShowOptions("routelines")).
--
--   Line      the style, the line's thickness and outline, dashed flights,
--             chevrons, each way of travel's colour, the world map's opacity,
--             the legs after this one, the walked stretch, the draw-in;
--   Minimap   the line on the minimap, its opacity and its size;
--   Dots & sparkles  the dots' size and spacing; the sparkles' presets and
--             settings (Maps/RouteSparkle.lua).
--
-- The preview pinned above each tab draws a route of its own (a walk with two
-- bends from the player, a flight, a later boat leg, fainter) with the maps'
-- own strokes (Maps/RouteStrokes.lua) and painters (RouteLines.NewCanvas,
-- Paint, Look, MapSparkles, MinimapSparkles), over the player's zone painting
-- (UI/ZoneArt.lua; the night band without one), and the same route on a
-- minimap's disc around the player. It is built when the tab first shows,
-- repaints on its own settings only while shown, and runs an OnUpdate only
-- while it shows sparkles (never under Reduce motion).

local ADDON, ns = ...
local R, Strokes = ns.RouteLines, ns.RouteStrokes
-- Without the route lines (no Nav) there is nothing to set.
if not (R and Strokes and R.Look) then return end

local Theme, W, L = ns.Theme, ns.Widgets, ns.L
local floor, max, min, atan2 = math.floor, math.max, math.min, math.atan2 or math.atan

local NEW = "0.3.7"
local PAGE, KEY, ORDER, ICON = L["Route lines"], "routelines", 24, "icon-goto"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function px(v) return string.format(L["%d px"], floor(v + 0.5)) end

-- What each control waits for.
local function off() return not ns.Get("nav.routeLines") end
local function style() return ns.Get("nav.lineStyle") end
local function notLine() return off() or style() ~= "line" end
local function plain() return off() or style() ~= "sparkle" end
-- The dots draw: their style, or the sparkles' under Reduce motion.
local function notDots()
	if off() then return true end
	local s = style()
	return not (s == "dots" or (s == "sparkle" and ns.Get("ui.reduceMotion")))
end
-- The colours show in the line and the dots, and in sparkles of the route colours.
local function uncoloured()
	return off() or (style() == "sparkle" and not ns.Get("ui.reduceMotion") and ns.Get("nav.sparkleColor") ~= "route")
end
local function ownWalk() return type(ns.Get("nav.walkColor")) == "table" end

-- The minimap size setting of the style chosen.
local function sizeKey()
	return "nav." .. (R.SIZE_KEYS[style()] or R.SIZE_KEYS.dots)
end

-- A colour row for a way of travel: its own colour, or the default shown.
local function colour(kind, key, label, help, search)
	return { kind = "color", key = "nav." .. key, label = label, help = help, new = NEW, search = search,
		shown = function() return R.DefaultColor(kind) end,
		source = function()
			if kind == "walk" and R.DOT_COLORS[ns.Get("nav.dotColor")] then return L["Route colour"] end
			return L["Theme"]
		end,
		disabled = uncoloured }
end

local DOT_CHOICES = {
	{ value = "route", label = L["Route colours"] }, { value = "cyan", label = L["Cyan"] },
	{ value = "magenta", label = L["Magenta"] }, { value = "white", label = L["White"] },
}

local SPARKLE_COLORS = {
	{ value = "gold", label = L["Loot gold"] }, { value = "arcane", label = L["Arcane blue"] },
	{ value = "fel", label = L["Fel green"] }, { value = "rose", label = L["Rose"] },
	{ value = "white", label = L["Starlight"] }, { value = "route", label = L["Route colours"] },
}

---------------------------------------------------------------------------
-- The preview
---------------------------------------------------------------------------

local PREVIEW_H, PAD, MM = 214, 12, 128
local MM_RADIUS = 230 -- yards the preview's minimap shows from its centre
-- The preview's own continent; its yards are map fractions x 1000 (fx = wy / 1000, fy = wx / 1000).
local C, YARDS = -1, 1000

local function at(fx, fy) return { C, fy * YARDS, fx * YARDS } end

-- A walk with two bends from the player, a flight on (its track rounded), and
-- a boat after it: a later leg, fainter. Map fractions, x right, y down.
local LEGS = {
	{ kind = "walk", pts = { at(0.04, 0.82), at(0.24, 0.46), at(0.38, 0.74), at(0.56, 0.42) } },
	{ kind = "flight", pts = { at(0.56, 0.42), at(0.67, 0.14), at(0.81, 0.30) } },
	{ kind = "boat", pts = { at(0.81, 0.30), at(0.95, 0.80) }, later = true },
}
-- The player stands this far along the walk's first stretch (the walked
-- stretch behind them fades, nav.walkedFade).
local PLAYER_T = 0.45
-- The stops' marks, as the maps leave a gap around (RouteLines' STOP_MARK, GOAL_MARK).
local MARKS = { { 0.56, 0.42, 7 }, { 0.81, 0.30, 7 }, { 0.95, 0.80, 11 } }

-- The settings the preview shows (nav.<key>), and the paths that change it all.
local WATCHED = { ["nav"] = true, [""] = true, ["ui"] = true, ["ui.reduceMotion"] = true }
for _, key in ipairs({ "routeLines", "lineStyle", "lineWidth", "dotColor", "minimapRouteAlpha", "minimapLineSize", "minimapDotsSize",
	"minimapSparkleSize", "worldRouteAlpha", "laterAlpha", "walkedFade", "routeChevrons", "flightDash", "dotSize", "dotSpacing",
	"lineOutline", "worldRoute", "minimapRoute", "minimapPins", "worldPins" }) do WATCHED["nav." .. key] = true end
for _, key in pairs(R.COLOR_KEYS) do WATCHED["nav." .. key] = true end
for key in pairs(ns.RouteSparkle and ns.RouteSparkle.DEFAULTS or {}) do WATCHED["nav." .. key] = true end

local previews = {} -- every preview built (one per tab), for repaints
local SPARKLE_STEP = 1 / 30

local function playerPoint()
	local a, b = LEGS[1].pts[1], LEGS[1].pts[2]
	return a[2] + (b[2] - a[2]) * PLAYER_T, a[3] + (b[3] - a[3]) * PLAYER_T
end

-- The sparkles, both surfaces, while the sparkles are drawn.
local function drawSparkles(f)
	if not f.runs then return end
	R.MapSparkles(f.world, f.runs, f.froms, f.P, f.worldW, f.worldH, 1, f.world.opacity or 1)
	R.MinimapSparkles(f.mm, f.runs, f.froms, C, f.px, f.py, MM_RADIUS, 0, false, MM, MM, R.MinimapSize(), f.mm.opacity or 1)
end

local function tick(f, elapsed)
	f.elapsed = (f.elapsed or 0) + elapsed
	if f.elapsed < SPARKLE_STEP then return end
	f.elapsed = 0
	drawSparkles(f)
end

-- The sparkles' runs and their projection on the world panel, once per paint.
local function sparkleRuns(f)
	f.runs = R.SparkleRuns(f.paths)
	local runs = f.runs
	if not runs then return end
	local P = f.P
	P.perYard = (f.worldW + f.worldH) / 2 / YARDS
	for i = 1, #runs do
		local run, us, vs = runs[i], P.us[i] or {}, P.vs[i] or {}
		P.us[i], P.vs[i] = us, vs
		for j = 1, run.n do us[j], vs[j] = run.ys[j] / YARDS, run.xs[j] / YARDS end
	end
	-- The walk's sparkles start abreast of the player, as on the maps.
	local first = runs[1]
	f.froms[1] = first and not first.later and ns.RouteSparkle.Nearest(first, C, f.px, f.py) or 0
	for i = 2, #runs do f.froms[i] = 0 end
end

-- Everything again from the settings: both surfaces' strokes, the marks,
-- the sparkles (and their OnUpdate, only while they show and move).
local function paint(f)
	f.dirty = false
	local w, h = f.worldW, f.worldH
	if not (w and w > 0 and h > 0) then return end
	local shown = ns.Get("nav.routeLines") and true or false
	local sparkling = shown and R.Style() == "sparkle"
	-- The world map panel.
	local v = f.view
	v.width, v.height = w, h
	f.world:SetSize(w, h)
	f.world.opacity = R.Look(v, "world", f.world:GetEffectiveScale())
	-- The minimap disc.
	local mv = f.mmView
	mv.width, mv.height = MM, MM
	f.mm.opacity = R.Look(mv, "minimap", f.mm:GetEffectiveScale())
	mv.phase = R.Style() == "dots" and 0.5 or 0
	-- Off on a surface (nav.worldRoute, nav.minimapRoute): nothing there.
	local onWorld, onMinimap = ns.Get("nav.worldRoute") ~= false, ns.Get("nav.minimapRoute") ~= false
	if not onWorld then f.world.opacity = 0 end
	if not onMinimap then f.mm.opacity = 0 end
	f.strokes.n, f.mmStrokes.n = 0, 0
	if shown and not sparkling then
		if onWorld then Strokes.Map(f.strokes, f.paths, v) end
		if onMinimap then Strokes.Minimap(f.mmStrokes, f.paths, mv) end
	end
	R.Paint(f.world, f.strokes)
	R.Paint(f.mm, f.mmStrokes)
	if sparkling then
		sparkleRuns(f)
		drawSparkles(f)
	else
		f.runs = nil
		R.ClearSparkles(f.world)
		R.ClearSparkles(f.mm)
	end
	f:SetScript("OnUpdate", sparkling and f:IsVisible() and tick or nil)
end

-- A glyph texture in a theme colour.
local function glyph(parent, media, color, size, layer)
	local t = W.Tex(parent, layer or "OVERLAY", media, color)
	t:SetSize(size, size)
	return t
end

---------------------------------------------------------------------------
-- The line style's picture cards: each style drawn by the maps' painters
-- along one gentle walk to the goal's mark, in the colours and sizes in use
-- (sparkles still, as a picture).
---------------------------------------------------------------------------

local CARD_WALK = { at(0.08, 0.74), at(0.34, 0.32), at(0.62, 0.66), at(0.88, 0.30) }
local SPARKLE_TEXTURE = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\sparkle"
local cardArts = {} -- every card picture drawn, for repaints

local function paintCard(d)
	local w, h = W.CARD_W - 2, W.CARD_ART
	local v = d.view
	v.width, v.height = w, h
	d.canvas:SetSize(w, h)
	R.Look(v, "world", d.canvas:GetEffectiveScale())
	-- This card's style, whatever the setting holds; no tail or chevrons on a picture.
	v.style, v.chevrons, v.tail = d.value == "line" and "line" or nil, false, false
	d.strokes.n = 0
	if d.value ~= "sparkle" then Strokes.Map(d.strokes, d.paths, v) end
	R.Paint(d.canvas, d.strokes)
	local Sp, used = ns.RouteSparkle, 0
	if d.value == "sparkle" and Sp and d.run then
		local st = Sp.Style(function(key) return ns.Get("nav." .. key) end)
		local c = st.color or v.colors.walk
		local count = 9
		for k = 1, count - 1 do
			local x, y = Sp.PointAt(d.run, d.run.total * k / count)
			local t = d.stars[k]
			if not t then
				t = d.canvas:CreateTexture(nil, "ARTWORK", nil, 2)
				t:SetTexture(SPARKLE_TEXTURE)
				t:SetBlendMode("ADD")
				d.stars[k] = t
			end
			local s = st.size * (0.75 + 0.45 * Sp.Hash(k, 1))
			t:SetSize(s, s)
			t:ClearAllPoints()
			t:SetPoint("CENTER", d.canvas, "TOPLEFT", y / YARDS * w, -x / YARDS * h)
			t:SetVertexColor(c[1], c[2], c[3])
			t:SetAlpha(max(0.35, st.alpha))
			t:Show()
			used = k
		end
	end
	for k = used + 1, #d.stars do d.stars[k]:Hide() end
	local last = CARD_WALK[#CARD_WALK]
	d.goal:ClearAllPoints()
	d.goal:SetPoint("CENTER", d.canvas, "TOPLEFT", last[3] / YARDS * w, -last[2] / YARDS * h)
end

local function drawCard(art, value)
	local d = { art = art, value = value, stars = {}, strokes = Strokes.New(200) }
	d.canvas = R.NewCanvas(CreateFrame("Frame", nil, art))
	d.canvas:SetPoint("TOPLEFT", art, "TOPLEFT", 0, 0)
	d.paths = { Strokes.Path("walk", CARD_WALK) }
	d.run = ns.RouteSparkle and ns.RouteSparkle.Paths(d.paths, true)[1]
	local last = CARD_WALK[#CARD_WALK]
	d.view = { c = C, left = 0, top = 0, kx = 1 / YARDS, ky = 1 / YARDS, small = false,
		marks = { last[3] / YARDS, last[2] / YARDS, 8 }, markCount = 1 }
	d.goal = glyph(d.canvas, "circle", "accent", 14)
	d.canvas:SetScript("OnShow", function() paintCard(d) end)
	cardArts[d] = true
	paintCard(d)
end

local STYLE_CARDS = {}
for i, c in ipairs(R.STYLE_CHOICES) do STYLE_CARDS[i] = { value = c.value, label = c.label, draw = drawCard } end

local function repaintShown()
	for f in pairs(previews) do
		if f:IsVisible() then paint(f) else f.dirty = true end
	end
	for d in pairs(cardArts) do
		if d.canvas:IsVisible() then paintCard(d) end
	end
end

-- The window's chrome ("Preview", f.caption, "Live") sits over the top
-- TOP px; the body's own pad is INSET at either side.
local TOP, INSET = 34, 32

local function buildPreview(host)
	local f = CreateFrame("Frame", nil, host)
	f:SetHeight(PREVIEW_H)
	if f.SetClipsChildren then f:SetClipsChildren(true) end
	-- The window's caption beside "Preview": the style drawn.
	f.caption = function()
		local drawn = R.Style()
		for _, c in ipairs(R.STYLE_CHOICES) do
			if c.value == drawn then return c.label end
		end
	end

	-- The world map: the player's zone painting, or the night band.
	local panel = CreateFrame("Frame", nil, f)
	panel:SetPoint("TOPLEFT", f, "TOPLEFT", INSET, -TOP)
	panel:SetHeight(PREVIEW_H - TOP - PAD)
	if panel.SetClipsChildren then panel:SetClipsChildren(true) end
	W.Fill(panel, "scrim", "BACKGROUND", -8)
	W.Painter(panel, function(self) Theme.Border(self, Theme.Wash("divider")) end)
	f.Panel = panel
	local ZA = ns.UI and ns.UI.ZoneArt
	if ZA and ZA.Create then
		local art = ZA.Create(panel, 400, PREVIEW_H - TOP - PAD, "scrim")
		art:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, 0)
		-- The whole painting, no fade into a name below it.
		if art.Fade then art.Fade:Hide() end
		if art.Top then art.Top:Hide() end
		f.Art = art
	else
		f.Night = Theme.Band(panel, "BACKGROUND", -6)
		f.Night:SetAllPoints(panel)
	end
	f.world = R.NewCanvas(CreateFrame("Frame", nil, panel))
	f.world:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, 0)
	f.world:SetFrameLevel(panel:GetFrameLevel() + 5)
	local cap = W.Text(f.world, "caption", "textMuted")
	cap:SetText(L["World map"])
	cap:SetPoint("BOTTOMLEFT", panel, "BOTTOMLEFT", 8, 6)

	-- The stops' marks and the player, as the maps' pins show them.
	f.marks = {}
	for i, m in ipairs(MARKS) do
		f.marks[i] = glyph(f.world, "circle", i == #MARKS and "accent" or "text", m[3] * 2 - 2)
	end
	f.player = glyph(f.world, "dart", "arrow", 18)

	-- The minimap: a disc around the player.
	local mmFrame = CreateFrame("Frame", nil, f)
	mmFrame:SetSize(MM, MM)
	f.MinimapFrame = mmFrame
	local disc = mmFrame:CreateTexture(nil, "BACKGROUND")
	disc:SetTexture("Interface\\AddOns\\" .. ADDON .. "\\Media\\Nav\\pin-fill")
	-- pin-fill's disc covers 42 of its 64 pixels.
	disc:SetSize(MM * 64 / 42, MM * 64 / 42)
	disc:SetPoint("CENTER", mmFrame, "CENTER", 0, 0)
	W.Painter(disc, function(t) t:SetVertexColor(Theme.Color("panelAlt")) end)
	f.mm = R.NewCanvas(CreateFrame("Frame", nil, mmFrame))
	f.mm:SetAllPoints(mmFrame)
	f.mm:SetFrameLevel(mmFrame:GetFrameLevel() + 2)
	local me = glyph(f.mm, "dart", "arrow", 14)
	me:SetPoint("CENTER", mmFrame, "CENTER", 0, 0)
	local mmCap = W.Text(f, "caption", "textMuted")
	mmCap:SetText(L["Minimap"])
	mmCap:SetPoint("TOP", mmFrame, "BOTTOM", 0, -6)

	-- The route, its views and buffers: the maps' own geometry.
	f.paths = {}
	for i, leg in ipairs(LEGS) do f.paths[i] = Strokes.Path(leg.kind, leg.pts, leg.later) end
	f.px, f.py = playerPoint()
	local marks = {}
	for _, m in ipairs(MARKS) do
		marks[#marks + 1], marks[#marks + 2], marks[#marks + 3] = m[1], m[2], m[3]
	end
	f.view = { c = C, left = 0, top = 0, kx = 1 / YARDS, ky = 1 / YARDS, small = false, marks = marks, markCount = #MARKS,
		from = true, fromIndex = 2, fromC = C, fromX = f.px, fromY = f.py }
	f.mmView = { c = C, x = f.px, y = f.py, radius = MM_RADIUS, facing = 0, square = false,
		from = true, fromIndex = 2, fromC = C, fromX = f.px, fromY = f.py }
	f.strokes, f.mmStrokes = Strokes.New(1200), Strokes.New(600)
	f.P, f.froms = { us = {}, vs = {}, lo = 0, hi = 1, project = function(c, wx, wy)
		if c == C then return wy / YARDS, wx / YARDS end
	end }, {}

	-- -> the preview's height, its parts placed across `width` (the whole
	-- main column); repainted when the width changes (settings repaint it
	-- on their own).
	function f:Layout(width)
		self:SetWidth(width)
		local ww = max(120, floor(width - INSET * 2 - MM - 24))
		local wh = PREVIEW_H - TOP - PAD
		if ww == self.worldW and not self.dirty then return PREVIEW_H end
		panel:SetWidth(ww)
		self.worldW, self.worldH = ww, wh
		if self.Art and self.Art.psW ~= ww then
			self.Art:SetSize(ww, wh)
			self.Art.psW, self.Art.psH = ww, wh
			local C2 = ns.Compat
			local map, mx, my
			if C2 and C2.GetPlayerMapPosition then map, mx, my = C2.GetPlayerMapPosition() end
			ns.UI.ZoneArt.Paint(self.Art, map, mx, my, 3)
		end
		mmFrame:ClearAllPoints()
		mmFrame:SetPoint("TOPRIGHT", self, "TOPRIGHT", -INSET, -TOP - 4)
		for i, m in ipairs(MARKS) do
			self.marks[i]:ClearAllPoints()
			self.marks[i]:SetPoint("CENTER", self.world, "TOPLEFT", m[1] * ww, -m[2] * wh)
		end
		-- The player's dart, along the walk.
		local a, b = LEGS[1].pts[1], LEGS[1].pts[2]
		local dx, dy = (b[3] - a[3]) / YARDS * ww, -(b[2] - a[2]) / YARDS * wh
		self.player:ClearAllPoints()
		self.player:SetPoint("CENTER", self.world, "TOPLEFT", self.py / YARDS * ww, -self.px / YARDS * wh)
		if self.player.SetRotation then self.player:SetRotation(atan2(-dx, dy)) end
		paint(self)
		return PREVIEW_H
	end

	f:SetScript("OnShow", function(self) if self.worldW then paint(self) end end)
	f:SetScript("OnHide", function(self) self:SetScript("OnUpdate", nil) end)
	previews[f] = true
	return f
end

-- The preview's settings: repainted while shown (else on show).
ns.On("SETTING_CHANGED", function(path)
	if (next(previews) or next(cardArts)) and WATCHED[path or ""] then repaintShown() end
end)
-- A theme change: after RouteLines takes the new colours (its handler is
-- added at login, before this one).
ns.OnLogin(function()
	if Theme and Theme.OnChanged then
		Theme.OnChanged(function() if next(previews) or next(cardArts) then repaintShown() end end)
	end
end)

-- The preview's frame on a tab (tests): nil before it is built.
function R.Previews()
	return previews
end

---------------------------------------------------------------------------
-- The page
---------------------------------------------------------------------------

local function preview(host) return buildPreview(host) end
local SUBTITLE = L["How the way to your goal is drawn on the world map and the minimap. Everything shows in the preview as you change it; right-click a setting to reset it."]

local function register(tab, section, controls)
	ns.RegisterOptions({ page = PAGE, key = KEY, icon = ICON, order = ORDER, group = "look", subtitle = SUBTITLE,
		tab = tab, section = section, preview = preview, controls = controls })
end

local LINE, MINIMAP, DOTS = L["Line"], L["Minimap"], L["Dots & sparkles"]

register(LINE, L["Style"], {
	{ kind = "toggle", key = "nav.routeLines", label = L["Route lines"],
		help = L["The way to the goal on the world map and the minimap: a line or dots where you walk, lines where you fly, sail or ride, the legs after this one fainter."],
		search = "path line, route on map, show route, hide route, sparkles, dots, trail" },
	{ kind = "toggle", key = "nav.worldRoute", label = L["On the world map"], child = true, new = NEW,
		disabled = function() return off() or not ns.Get("nav.worldPins") end,
		help = L["The route lines on the world map. Off leaves them on the minimap only."],
		search = "world map route, hide on world map, map line, visibility, where" },
	{ kind = "cards", key = "nav.lineStyle", label = L["Line style"], child = true, disabled = off,
		help = L["How the route lines are drawn: one solid line, Polestar's dots, or sparkles that drift along the way to the goal (dots while Reduce motion is on)."],
		search = "route style, solid line, path line, dots, sparkles, breadcrumbs, look",
		choices = STYLE_CARDS },
	{ kind = "slider", key = "nav.lineWidth", label = L["Line thickness"], min = 2, max = 12, step = 1, format = px, disabled = notLine,
		help = L["How thick the solid line is on the world map; the minimap's follows it at its own size (Minimap tab). Right-click to reset."],
		search = "bigger, thicker, thinner, width, bold, size, wide, line width, huge, tiny" },
	{ kind = "slider", key = "nav.lineOutline", label = L["Outline"], min = 0, max = 2, step = 0.05, format = percent, new = NEW, disabled = off,
		help = L["The dark edge under the line and dots (the line's soft shadow), so they stand out on bright ground. 0% takes it away."],
		search = "shadow, outline, border, contrast, edge, stroke, readability, dark edge, halo" },
	{ kind = "toggle", key = "nav.flightDash", label = L["Dashed flights"], new = NEW, disabled = notLine,
		help = L["Flights drawn as a dashed line, so a walk and a flight never read as one. Off: a solid line in the flight's colour."],
		search = "dash, dashes, dotted, flight path, taxi, gryphon, wyvern, solid" },
	{ kind = "toggle", key = "nav.routeChevrons", label = L["Direction marks"], new = NEW, disabled = notLine,
		help = L["Small chevrons along the line on the world map pointing the way to the goal."],
		search = "chevrons, arrows, direction, which way, heading, marks, ticks" },
})

register(LINE, L["Colours"], {
	{ kind = "dropdown", key = "nav.dotColor", label = L["Route colour"],
		disabled = function() return off() or (style() == "sparkle" and not ns.Get("ui.reduceMotion")) or ownWalk() end,
		help = L["Route colours tint each leg by how you travel it. Cyan, magenta and white stand apart from the minimap's yellow herb and ore dots and its gold quest marks. A walk colour of your own below wins. Right-click to reset."],
		search = "colour, color, tint, cyan, magenta, white, walk colour, preset",
		choices = DOT_CHOICES },
	colour("walk", "walkColor", L["Walk colour"], L["The walks' colour: the line, the dots, and route-coloured sparkles. Right-click for the route colour again."],
		"walking colour, color, tint, path colour, foot, on foot, custom colour"),
	colour("flight", "flightColor", L["Flight colour"], L["Flights' colour. Right-click for the theme's."],
		"flying colour, color, taxi, gryphon, wyvern, bat, flight path"),
	colour("boat", "boatColor", L["Boat colour"], L["Boats' colour. Right-click for the theme's."],
		"ship colour, color, ferry, sea, sail"),
	colour("zeppelin", "zeppelinColor", L["Zeppelin colour"], L["Zeppelins' colour. Right-click for the theme's."],
		"zeppelin colour, color, airship, blimp"),
	colour("tram", "tramColor", L["Tram & lift colour"], L["The Deeprun Tram's and lifts' colour. Right-click for the theme's."],
		"tram colour, color, deeprun, lift, elevator, underground"),
})

register(LINE, L["Fading"], {
	{ kind = "slider", key = "nav.worldRouteAlpha", label = L["World map opacity"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW, disabled = off,
		help = L["How strongly the route shows on the world map, line, dots or sparkles; the minimap keeps its own."],
		search = "opacity, transparency, alpha, faint, see through, strength, world map, fade" },
	{ kind = "slider", key = "nav.laterAlpha", label = L["Later legs"], min = 0, max = 1, step = 0.05, format = percent, new = NEW, disabled = off,
		help = L["How strongly the legs after this one show, so the way ahead reads first. 0%: only the leg you are on; 100%: as strong as this leg."],
		search = "later legs, next legs, fade, fainter, dim, opacity, rest of the route, upcoming" },
	{ kind = "toggle", key = "nav.walkedFade", label = L["Fade the walked stretch"], new = NEW, disabled = notLine,
		help = L["A short stretch of the line stays behind you, fading out. Off: the line starts where you stand."],
		search = "tail, trail behind, walked, behind me, fade out, history" },
	{ kind = "toggle", key = "nav.drawIn", label = L["Draw-in animation"], new = NEW,
		disabled = function() return off() or ns.Get("ui.reduceMotion") end,
		help = L["A new goal's route grows from you to the goal over a moment. Never with Reduce motion on."],
		search = "animation, animate, grow, draw in, motion, reveal, effect" },
})

register(MINIMAP, L["Minimap"], {
	{ kind = "toggle", key = "nav.minimapRoute", label = L["Route on the minimap"],
		help = L["The route line (or the trail) on the minimap. Off keeps the guide pin there."],
		search = "minimap route, minimap line, hide on minimap, radar",
		disabled = function() return off() or not ns.Get("nav.minimapPins") end },
	{ kind = "slider", key = "nav.minimapRouteAlpha", label = L["Minimap opacity"], min = 0.2, max = 1, step = 0.05, format = percent,
		disabled = function() return off() or ns.Get("nav.minimapRoute") == false end,
		help = L["How strongly the route shows on the minimap, line, dots or sparkles; the world map keeps its own. Right-click to reset."],
		search = "opacity, transparency, alpha, faint, minimap, see through" },
	{ kind = "slider", key = "nav.minimapRouteSize", label = L["Minimap size"], min = 0.5, max = 1.5, step = 0.05, format = percent,
		get = function() return ns.Get(sizeKey()) end, set = function(v) ns.Set(sizeKey(), v) end,
		disabled = function() return off() or ns.Get("nav.minimapRoute") == false end,
		help = L["The route's line, dots or sparkles on the minimap, each style its own size; the world map keeps its own. Right-click to reset."],
		search = "bigger, smaller, size, scale, thickness, minimap line, huge, tiny" },
})

register(DOTS, L["Dots"], {
	{ kind = "slider", key = "nav.dotSize", label = L["Dot size"], min = Strokes.DOTS[1], max = Strokes.DOTS[2], step = 1, format = px, new = NEW, disabled = notDots,
		help = L["How big each of the dots is, on both maps (smaller on continent maps)."],
		search = "bigger, smaller, dot size, breadcrumbs, size, huge, tiny" },
	{ kind = "slider", key = "nav.dotSpacing", label = L["Dot spacing"], min = Strokes.SPACINGS[1], max = Strokes.SPACINGS[2], step = 1, format = px, new = NEW, disabled = notDots,
		help = L["How far apart the dots sit along the way."],
		search = "gap, distance, spacing, density, closer, further, breadcrumbs" },
})

local function preset(name, label, help)
	return { kind = "button", label = label, button = L["Apply"], help = help, disabled = plain, new = NEW,
		search = "sparkle preset, look, " .. name,
		onClick = function() R.ApplySparklePreset(name) end }
end

register(DOTS, L["Sparkles"], {
	preset("subtle", L["Subtle sparkles"], L["Fewer, smaller, calmer sparkles that drift slowly."]),
	preset("default", L["Default sparkles"], L["The sparkles as they come."]),
	preset("dazzling", L["Dazzling sparkles"], L["Many bright sparkles flowing quickly toward the goal."]),
	{ kind = "slider", key = "nav.sparkleIntensity", label = L["Intensity"], min = 0, max = 1, step = 0.05, format = percent, disabled = plain,
		help = L["How bright each sparkle and its glow are."], search = "brightness, glow, bright, strength" },
	{ kind = "slider", key = "nav.sparkleDensity", label = L["Density"], min = 1, max = 10, step = 1, format = "%d", disabled = plain,
		help = L["How close together the sparkles sit, the same at any zoom."], search = "how many, spacing, amount, more, fewer" },
	{ kind = "slider", key = "nav.sparkleSubtlety", label = L["Subtlety"], min = 0, max = 1, step = 0.05, format = percent, disabled = plain,
		help = L["Smaller, dimmer, calmer twinkles that drift less; no glow at 100%."], search = "calm, quiet, twinkle, subtle" },
	{ kind = "slider", key = "nav.sparkleSize", label = L["Sparkle size"], min = 6, max = 28, step = 1, format = px, disabled = plain,
		help = L["Each sparkle's size before subtlety."], search = "bigger, smaller, size, huge, tiny" },
	{ kind = "slider", key = "nav.sparkleFlow", label = L["Flow toward goal"], min = 0, max = 1, step = 0.05, format = percent, disabled = plain,
		help = L["How fast the sparkles drift toward the goal; 0 holds them still."], search = "speed, drift, movement, animation, still" },
	{ kind = "slider", key = "nav.sparkleMax", label = L["Most sparkles shown"], min = 10, max = 400, step = 10, format = "%d", disabled = plain,
		help = L["A ceiling on each map, whatever the density."], search = "limit, maximum, cap, performance, fps" },
	{ kind = "dropdown", key = "nav.sparkleColor", label = L["Sparkle colour"], disabled = plain,
		help = L["Loot gold is the colour of the game's own loot sparkle. Route colours tint each leg as the dots are."],
		search = "colour, color, gold, tint", choices = SPARKLE_COLORS },
	{ kind = "toggle", key = "nav.sparkleLater", label = L["Whole route"], disabled = plain,
		help = L["Sparkle the legs after this one too, fainter. Off: only the leg you are on."], search = "all legs, later legs, whole way" },
})
