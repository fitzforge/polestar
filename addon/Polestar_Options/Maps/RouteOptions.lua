-- The Route lines page of Polestar's settings window (Look, key "routelines";
-- docs/ARCHITECTURE.md, "Maps"): every setting of the route lines'
-- look (Maps/RouteLines.lua) over a live preview of them. The gear beside
-- Guide > Arrow & routes > "Route lines" opens it (UI.ShowOptions("routelines")).
--
-- One tab, Route: Route lines (on/off in the header; the style as picture
-- cards, the world map's and the minimap's opacity each with its on/off
-- switch, the minimap size, the draw-in, later legs, the outline); then the
-- drawn style's own section, the only one shown (Line: walk and route
-- colour, thickness, walked fade, direction marks, dashed flights; Dots:
-- walk and route colour, dot size and spacing; Sparkles: presets as picture
-- cards and the sparkle settings, Maps/RouteSparkle.lua); Flights & rides
-- (each one's colour).
-- The preview's walk, flight, boat and minimap jump to their rows on a click.
--
-- The preview pinned above each tab is a band (UI.Preview.Band) over the
-- map hero (UI.Preview.MapHero): a Horde route in the Barrens (up the road
-- to the Crossroads with the player on it, the flight to Ratchet, the walk
-- to the dock and the boat out to sea, later legs fainter) on a 1:1 crop of
-- the zone's own world map and on the game's minimap, each at its real
-- size, drawn by the maps' own strokes (Maps/RouteStrokes.lua) and painters
-- (RouteLines.Paint, Look, MapSparkles, MinimapSparkles); the rides'
-- colours in a legend line under the map. It is built when the tab first
-- shows, repaints on its own settings only while shown, and runs an
-- OnUpdate only while it shows sparkles (never under Reduce motion).

local ns = Polestar
local R, Strokes = ns.RouteLines, ns.RouteStrokes
-- Without the route lines (no Nav) there is nothing to set.
if not (R and Strokes and R.Look) then return end

local Theme, W, L = ns.Theme, ns.Widgets, ns.L
local floor, max, min = math.floor, math.max, math.min

local NEW = "0.3.8"
local PAGE, KEY, ORDER, ICON = L["Route lines"], "routelines", 24, "icon-goto"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function px(v) return string.format(L["%d px"], floor(v + 0.5)) end

-- What each control waits for.
local function off() return not ns.Get("nav.routeLines") end
local function style() return ns.Get("nav.lineStyle") end
-- The colours show in the line and the dots, and in sparkles of the route colours.
local function uncoloured()
	return off() or (style() == "sparkle" and not ns.Get("ui.reduceMotion") and ns.Get("nav.sparkleColor") ~= "route")
end
local function ownWalk() return type(ns.Get("nav.walkColor")) == "table" end

-- The minimap size setting of the style chosen.
local function sizeKey()
	return "nav." .. (R.SIZE_KEYS[style()] or R.SIZE_KEYS.dots)
end

-- A colour row for a way of travel: its own colour, or the default shown;
-- more: its cog's settings.
local function colour(kind, key, label, help, search, more)
	return { kind = "color", key = "nav." .. key, label = label, help = help, new = NEW, search = search, more = more,
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

-- The style cards' own continent: its yards are map fractions x 1000 (fx =
-- wy / 1000, fy = wx / 1000).
local C, YARDS = -1, 1000

local function at(fx, fy) return { C, fy * YARDS, fx * YARDS } end

-- The preview's scene on the map hero (UI.Preview.MapHero): the Barrens
-- (uiMap 1413, on Kalimdor) in its map's pixels, the player on the road
-- south of the Crossroads, facing north.
local BARRENS = {
	zone = 1413, c = 1, frame = { left = 2622.917, right = -7510.417, top = 1612.5, bottom = -5143.75 },
	crop = { 400, 150, 488, 186 }, -- whole map labels only: the Crossroads, the Wailing Caverns, Ratchet, Durotar
	player = { 508, 297 }, ahead = { 507, 282 },
	-- Kalimdor's minimap tiles round the player (its WDT, builds 70374 and 70450).
	tiles = { { 36, 34, 208162 }, { 37, 34, 208206 }, { 36, 35, 208163 }, { 37, 35, 208207 } },
}
-- A Horde route, every leg drawn by the maps' own strokes: up the road to
-- the Crossroads (the player on it, the stretch behind them walked), the
-- flight to Ratchet (taxi nodes 25 and 80), then the walk to the dock and
-- the boat out to sea: later legs, fainter.
local LEGS = {
	{ kind = "walk", pts = { { 509.5, 312 }, { 507, 282 }, { 504, 262 }, { 506, 247 }, { 513, 236 }, { 519, 222 }, { 516, 203 } } },
	{ kind = "flight", pts = { { 516, 203 }, { 574, 211 }, { 632.5, 247.9 } } },
	{ kind = "walk", pts = { { 632.5, 247.9 }, { 634.8, 256.8 } }, later = true },
	{ kind = "boat", pts = { { 634.8, 256.8 }, { 662, 271 }, { 724, 300 }, { 804, 326 }, { 900, 344 } }, later = true },
}
-- The stops' marks, as the maps leave a gap round them (RouteLines' STOP_MARK).
local STOPS = { { 516, 203 }, { 632.5, 247.9 } }
-- The click targets: the walk, the flight and the boat by the box their leg
-- spans on the map (HOT_PAD past it), and the row each jumps to.
local HOTSPOTS = { { key = "nav.walkColor", leg = 1 }, { key = "nav.flightColor", leg = 2 }, { key = "nav.boatColor", leg = 4 } }
local HOT_PAD = 8
-- The rides' colours, a legend line under the map: the flight and the boat
-- are on the route, the zeppelin and the tram are not.
local RIDES = { { "flight", L["Flights"] }, { "boat", L["Boats"] }, { "zeppelin", L["Zeppelins"] }, { "tram", L["Trams & lifts"] } }

-- The settings the preview shows (nav.<key>), and the paths that change it all.
local WATCHED = { ["nav"] = true, [""] = true, ["ui"] = true, ["ui.reduceMotion"] = true }
for _, key in ipairs({ "routeLines", "lineStyle", "lineWidth", "dotColor", "minimapRouteAlpha", "minimapLineSize", "minimapDotsSize",
	"minimapSparkleSize", "worldRouteAlpha", "laterAlpha", "walkedFade", "routeChevrons", "flightDash", "dotSize", "dotSpacing",
	"lineOutline", "worldRoute", "minimapRoute", "minimapPins", "worldPins" }) do WATCHED["nav." .. key] = true end
for _, key in pairs(R.COLOR_KEYS) do WATCHED["nav." .. key] = true end
for key in pairs(ns.RouteSparkle and ns.RouteSparkle.DEFAULTS or {}) do WATCHED["nav." .. key] = true end

local previews = {} -- every preview built (one per tab), for repaints
local SPARKLE_STEP = 1 / 30

-- The sparkles, both surfaces, while the sparkles are drawn.
local function drawSparkles(f)
	if not f.runs then return end
	R.MapSparkles(f.world, f.runs, f.froms, f.P, f.worldW, f.worldH, 1, f.world.opacity or 1)
	R.MinimapSparkles(f.mm, f.runs, f.froms, BARRENS.c, f.px, f.py, f.radius, 0, false, f.mmSize, f.mmSize, R.MinimapSize(), f.mm.opacity or 1)
end

local function tick(f, elapsed)
	f.elapsed = (f.elapsed or 0) + elapsed
	if f.elapsed < SPARKLE_STEP then return end
	f.elapsed = 0
	drawSparkles(f)
end

-- The sparkles' runs and their projection on the map, once per paint.
local function sparkleRuns(f)
	f.runs = R.SparkleRuns(f.paths)
	local runs = f.runs
	if not runs then return end
	local P = f.P
	for i = 1, #runs do
		local run, us, vs = runs[i], P.us[i] or {}, P.vs[i] or {}
		P.us[i], P.vs[i] = us, vs
		for j = 1, run.n do us[j], vs[j] = P.project(run.c, run.xs[j], run.ys[j]) end
	end
	-- The walk's sparkles start abreast of the player, as on the maps.
	local first = runs[1]
	f.froms[1] = first and not first.later and ns.RouteSparkle.Nearest(first, BARRENS.c, f.px, f.py) or 0
	for i = 2, #runs do f.froms[i] = 0 end
end

-- Everything again from the settings: both surfaces' strokes, the legend,
-- the sparkles (and their OnUpdate, only while they show and move).
local function paint(f)
	f.dirty = false
	local w, h = f.worldW, f.worldH
	local shown = ns.Get("nav.routeLines") and true or false
	local sparkling = shown and R.Style() == "sparkle"
	-- The world map.
	local v = f.view
	v.width, v.height = w, h
	f.world.opacity = R.Look(v, "world", f.world:GetEffectiveScale())
	-- The legend's strokes in the rides' colours, as the world map draws them.
	for _, item in ipairs(f.Legend) do
		local c = v.colors and v.colors[item.psKind]
		if c then item.Stroke:SetVertexColor(c[1], c[2], c[3], 1) end
	end
	-- The minimap.
	local mv = f.mmView
	mv.width, mv.height = f.mmSize, f.mmSize
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
local SPARKLE_TEXTURE = "Interface\\AddOns\\Polestar\\Media\\Nav\\sparkle"
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

-- The preview, a band (UI.Preview.Band) over the map hero: the route on the
-- Barrens' world map and on the minimap, each at its real size, the rides'
-- legend under the map and "Minimap" under the minimap.
local function buildPreview(view)
	local P = ns.UI.Preview
	local f = P.Band(view)
	-- The legend: a stroke in each ride's colour and its name.
	local legend = CreateFrame("Frame", nil, f)
	legend:SetHeight(P.LINE_H)
	f.Legend = {}
	local lx = 0
	for i, ride in ipairs(RIDES) do
		local item = CreateFrame("Frame", nil, legend)
		item.Stroke = item:CreateTexture(nil, "ARTWORK")
		item.Stroke:SetTexture(Theme.Media("white"))
		item.Stroke:SetSize(14, 3)
		item.Stroke:SetPoint("LEFT", item, "LEFT", 0, 0)
		item.Label = W.Text(item, "label", "textMuted")
		item.Label:SetText(ride[2])
		item.Label:SetPoint("LEFT", item.Stroke, "RIGHT", 6, 0)
		local iw = 20 + math.ceil(W.TextWidth(item.Label))
		item:SetSize(iw, P.LINE_H)
		item:SetPoint("LEFT", legend, "LEFT", lx, 0)
		lx = lx + iw + 16
		item.psKind = ride[1]
		f.Legend[i] = item
	end
	legend:SetWidth(max(1, lx - 16))
	local h = P.MapHero(f, BARRENS, legend)
	f.Hero, f.world, f.mm = h, h.World, h.MmCanvas
	local cx0, cy0, cw, ch = unpack(BARRENS.crop)

	-- The stops' marks, as the maps' pins show them.
	f.marks = {}
	for i = 1, #STOPS do f.marks[i] = glyph(h.Layer, "circle", "text", 12) end

	-- The route, its views and buffers: the maps' own geometry, in the
	-- Barrens' world yards.
	local function world(list)
		local out = {}
		for i, p in ipairs(list) do
			local wx, wy = P.HeroWorld(p[1], p[2], BARRENS)
			out[i] = { BARRENS.c, wx, wy }
		end
		return out
	end
	f.paths = {}
	for i, leg in ipairs(LEGS) do f.paths[i] = Strokes.Path(leg.kind, world(leg.pts), leg.later) end
	f.px, f.py = P.HeroWorld(BARRENS.player[1], BARRENS.player[2], BARRENS)
	local top, left = P.HeroWorld(cx0, cy0, BARRENS)
	local bottom, right = P.HeroWorld(cx0 + cw, cy0 + ch, BARRENS)
	local kx, ky = 1 / (right - left), 1 / (bottom - top)
	local marks = {}
	for _, s in ipairs(STOPS) do
		marks[#marks + 1], marks[#marks + 2], marks[#marks + 3] = (s[1] - cx0) / cw, (s[2] - cy0) / ch, 7
	end
	f.view = { c = BARRENS.c, left = left, top = top, kx = kx, ky = ky, small = false, marks = marks, markCount = #STOPS,
		from = true, fromIndex = 2, fromC = BARRENS.c, fromX = f.px, fromY = f.py }
	f.worldW, f.worldH, f.mmSize, f.radius = cw, ch, P.MM, P.MM_YARDS / 2
	f.mmView = { c = BARRENS.c, x = f.px, y = f.py, radius = f.radius, facing = 0, square = false,
		from = true, fromIndex = 2, fromC = BARRENS.c, fromX = f.px, fromY = f.py }
	f.strokes, f.mmStrokes = Strokes.New(1200), Strokes.New(600)
	f.P, f.froms = { us = {}, vs = {}, lo = 0, hi = 1, perYard = (cw * math.abs(kx) + ch * math.abs(ky)) / 2,
		project = function(c, wx, wy)
			if c == BARRENS.c then return (wy - left) * kx, (wx - top) * ky end
		end }, {}

	-- Click targets: a part of the preview jumps to its settings. The walk,
	-- the flight and the boat by the box their leg spans on the map, the
	-- minimap by its disc.
	f.hot, f.hotButtons = {}, {}
	for i, spot in ipairs(HOTSPOTS) do
		local x1, y1, x2, y2 = math.huge, math.huge, -math.huge, -math.huge
		for _, p in ipairs(LEGS[spot.leg].pts) do
			x1, y1, x2, y2 = min(x1, p[1]), min(y1, p[2]), max(x2, p[1]), max(y2, p[2])
		end
		x1, y1 = max(0, x1 - cx0 - HOT_PAD), max(0, y1 - cy0 - HOT_PAD)
		x2, y2 = min(cw, x2 - cx0 + HOT_PAD), min(ch, y2 - cy0 + HOT_PAD)
		local region = CreateFrame("Frame", nil, h.Layer)
		region:SetPoint("TOPLEFT", h.Layer, "TOPLEFT", x1, -y1)
		region:SetSize(x2 - x1, y2 - y1)
		f.hot[i] = region
		f.hotButtons[spot.key] = f:Hot(region, spot.key)
	end
	f.hotButtons["nav.minimapRouteSize"] = f:Hot(h.Minimap, "nav.minimapRouteSize")
	-- The pointer on a setting's row lights the parts it changes.
	local walkLeg, flightLeg, boatLeg = f.hot[1], f.hot[2], f.hot[3]
	local map, mm, legendItems = h.Map, h.Minimap, f.Legend
	local both = { map, mm }
	for key, parts in pairs({
		["nav.routeLines"] = both, ["nav.lineStyle"] = both, ["nav.worldRouteAlpha"] = { map }, ["nav.worldRoute"] = { map },
		["nav.minimapRouteAlpha"] = { mm }, ["nav.minimapRoute"] = { mm }, ["nav.minimapRouteSize"] = { mm },
		["nav.drawIn"] = { walkLeg, flightLeg, boatLeg }, ["nav.laterAlpha"] = { boatLeg }, ["nav.lineOutline"] = { walkLeg, flightLeg },
		["nav.walkColor"] = { walkLeg, mm }, ["nav.dotColor"] = { walkLeg, flightLeg, boatLeg }, ["nav.lineWidth"] = { walkLeg, flightLeg },
		["nav.walkedFade"] = { walkLeg }, ["nav.routeChevrons"] = { walkLeg, flightLeg }, ["nav.flightDash"] = { flightLeg },
		["nav.dotSize"] = { walkLeg }, ["nav.dotSpacing"] = { walkLeg },
		["nav.sparkleColor"] = both, ["nav.sparkleSize"] = both, ["nav.sparkleIntensity"] = both, ["nav.sparkleSubtlety"] = both,
		["nav.sparkleDensity"] = both, ["nav.sparkleMax"] = both, ["nav.sparkleFlow"] = both, ["nav.sparkleLater"] = { boatLeg },
		["nav.flightColor"] = { flightLeg, legendItems[1] }, ["nav.boatColor"] = { boatLeg, legendItems[2] },
		["nav.zeppelinColor"] = { legendItems[3] }, ["nav.tramColor"] = { legendItems[4] },
	}) do
		f:Light(key, unpack(parts))
	end

	function f:Content()
		local w, hh, labels = h.Size()
		for i, s in ipairs(STOPS) do
			self.marks[i]:ClearAllPoints()
			self.marks[i]:SetPoint("CENTER", h.Layer, "TOPLEFT", s[1] - cx0, -(s[2] - cy0))
		end
		paint(self)
		return w, hh, h.Place, labels
	end
	f:HookScript("OnShow", function(self) paint(self) end)
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
-- The page: one tab, one section per element of the route in its anatomy
-- order. Route lines (on/off in its header, the style as picture cards, the
-- world map and the minimap); then the chosen style's own section, shown
-- only while that style is drawn (Line, Dots or Sparkles: nothing greyed out
-- for a style not in use); Flights & rides. One element's size,
-- colour and switch share a row (`extras`), secondary knobs sit in the row's
-- cog (`more`), short labels, the help in each row's tooltip.
---------------------------------------------------------------------------

local function preview(host) return buildPreview(host) end
local SUBTITLE = L["How the way to your goal is drawn on the world map and the minimap."]

local ROUTE = L["Route"]

local function register(section, controls, extra)
	local spec = { page = PAGE, key = KEY, icon = ICON, order = ORDER, group = "look", subtitle = SUBTITLE,
		tab = ROUTE, section = section, preview = preview, controls = controls }
	for k, v in pairs(extra or {}) do spec[k] = v end
	ns.RegisterOptions(spec)
end

-- The style drawn (sparkles are drawn as dots under Reduce motion).
local function drawn(s) return function() return R.Style() == s end end

local function minimapOff() return off() or ns.Get("nav.minimapRoute") == false end

register(L["Route lines"], {
	{ kind = "cards", key = "nav.lineStyle", label = L["Style"], wide = true, disabled = off,
		help = L["How the route lines are drawn: one solid line, Polestar's dots, or sparkles that drift along the way to the goal (dots while Reduce motion is on)."],
		search = "route style, line style, solid line, path line, dots, sparkles, breadcrumbs, look", choices = STYLE_CARDS },
	{ kind = "slider", key = "nav.worldRouteAlpha", label = L["World map opacity"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW,
		disabled = function() return off() or ns.Get("nav.worldRoute") == false end,
		help = L["How strongly the route shows on the world map, line, dots or sparkles; the minimap keeps its own. The switch takes the lines off the world map."],
		search = "opacity, transparency, alpha, faint, see through, strength, world map, fade, hide on world map, visibility",
		extras = {
			{ kind = "toggle", key = "nav.worldRoute", label = L["On the world map"], new = NEW,
				disabled = function() return off() or not ns.Get("nav.worldPins") end,
				help = L["The route lines on the world map. Off leaves them on the minimap only."],
				search = "world map route, hide on world map, map line, visibility, where" },
		} },
	{ kind = "slider", key = "nav.minimapRouteAlpha", label = L["Minimap opacity"], min = 0.2, max = 1, step = 0.05, format = percent, disabled = minimapOff,
		help = L["How strongly the route shows on the minimap, line, dots or sparkles; the world map keeps its own. The switch takes the line off the minimap (the guide pin stays)."],
		search = "opacity, transparency, alpha, faint, minimap, see through, hide on minimap, radar",
		extras = {
			{ kind = "toggle", key = "nav.minimapRoute", label = L["Route on the minimap"],
				disabled = function() return off() or not ns.Get("nav.minimapPins") end,
				help = L["The route line (or the trail) on the minimap. Off keeps the guide pin there."],
				search = "minimap route, minimap line, hide on minimap, radar" },
		} },
	{ kind = "slider", key = "nav.minimapRouteSize", label = L["Minimap size"], min = 0.5, max = 1.5, step = 0.05, format = percent,
		get = function() return ns.Get(sizeKey()) end, set = function(v) ns.Set(sizeKey(), v) end, disabled = minimapOff,
		help = L["The route's line, dots or sparkles on the minimap, each style its own size; the world map keeps its own."],
		search = "bigger, smaller, size, scale, thickness, minimap line, huge, tiny" },
	{ kind = "toggle", key = "nav.drawIn", label = L["Draw-in"], new = NEW,
		disabled = function() return off() or ns.Get("ui.reduceMotion") end,
		help = L["A new goal's route grows from you to the goal over a moment. Never with Reduce motion on."],
		search = "animation, animate, grow, draw in, motion, reveal, effect" },
	{ kind = "slider", key = "nav.laterAlpha", label = L["Later legs"], min = 0, max = 1, step = 0.05, format = percent, new = NEW, disabled = off, info = true,
		help = L["How strongly the legs after this one show, so the way ahead reads first. 0%: only the leg you are on; 100%: as strong as this leg."],
		search = "later legs, next legs, fade, fainter, dim, opacity, rest of the route, upcoming, only current leg" },
	{ kind = "slider", key = "nav.lineOutline", label = L["Outline"], min = 0, max = 2, step = 0.05, format = percent, new = NEW, disabled = off,
		help = L["The dark edge under the line and dots (the line's soft shadow), so they stand out on bright ground. 0% takes it away."],
		search = "shadow, outline, border, contrast, edge, stroke, readability, dark edge, halo" },
}, { toggle = { kind = "toggle", key = "nav.routeLines", label = L["Route lines"],
	help = L["The way to the goal on the world map and the minimap: a line or dots where you walk, lines where you fly, sail or ride, the legs after this one fainter."],
	search = "path line, route on map, show route, hide route, sparkles, dots, trail" } })

-- The walks' own colour and the route colour presets (nav.dotColor): the
-- first line of the Line and the Dots sections both.
local function walkColours()
	return colour("walk", "walkColor", L["Walk colour"], L["The walks' colour: the line, the dots, and route-coloured sparkles. Right-click for the route colour again."],
		"walking colour, color, tint, path colour, foot, on foot, custom colour"),
	{ kind = "dropdown", key = "nav.dotColor", label = L["Route colour"],
		disabled = function() return off() or ownWalk() end,
		help = L["Route colours tint each leg by how you travel it. Cyan, magenta and white stand apart from the minimap's yellow herb and ore dots and its gold quest marks. A walk colour of your own wins."],
		search = "colour, color, tint, cyan, magenta, white, walk colour, preset, route colour, dot colour",
		choices = DOT_CHOICES }
end

local walk, presets = walkColours()
register(L["Line"], {
	walk, presets,
	{ kind = "slider", key = "nav.lineWidth", label = L["Thickness"], min = 2, max = 12, step = 1, format = px, disabled = off,
		help = L["How thick the solid line is on the world map; the minimap's follows it at its own size."],
		search = "bigger, thicker, thinner, width, bold, size, wide, line width, huge, tiny" },
	{ kind = "toggle", key = "nav.walkedFade", label = L["Walked fade"], new = NEW, disabled = off,
		help = L["A short stretch of the line stays behind you, fading out. Off: the line starts where you stand."],
		search = "tail, trail behind, walked, behind me, fade out, history" },
	{ kind = "toggle", key = "nav.routeChevrons", label = L["Direction marks"], new = NEW, disabled = off,
		help = L["Small chevrons along the line on the world map pointing the way to the goal."],
		search = "chevrons, arrows, direction, which way, heading, marks, ticks" },
	{ kind = "toggle", key = "nav.flightDash", label = L["Dashed flights"], new = NEW, disabled = off,
		help = L["Flights drawn as a dashed line, so a walk and a flight never read as one. Off: a solid line in the flight's colour."],
		search = "dash, dashes, dotted, flight path, taxi, gryphon, wyvern, solid" },
}, { shown = drawn("line") })

walk, presets = walkColours()
register(L["Dots"], {
	walk, presets,
	{ kind = "slider", key = "nav.dotSize", label = L["Dot size"], min = Strokes.DOTS[1], max = Strokes.DOTS[2], step = 1, format = px, new = NEW, disabled = off,
		help = L["How big each of the dots is, on both maps (smaller on continent maps)."],
		search = "bigger, smaller, dot size, breadcrumbs, size, huge, tiny" },
	{ kind = "slider", key = "nav.dotSpacing", label = L["Dot spacing"], min = Strokes.SPACINGS[1], max = Strokes.SPACINGS[2], step = 1, format = px, new = NEW, disabled = off,
		help = L["How far apart the dots sit along the way."],
		search = "gap, distance, spacing, density, closer, further, breadcrumbs" },
}, { shown = drawn("dots") })

-- The sparkle presets as picture cards: each drawn with its own settings;
-- the chosen one is the preset the sparkle settings match (none after a
-- change of your own); right-click puts the default preset back.
local PRESETS = { "subtle", "default", "dazzling" }
local PRESET_NAMES = { subtle = L["Subtle"], default = L["Default"], dazzling = L["Dazzling"] }
local function presetNow()
	local Sp = ns.RouteSparkle
	for _, name in ipairs(PRESETS) do
		local same = true
		for key, value in pairs(Sp.PRESETS[name]) do
			if math.abs((tonumber(ns.Get("nav." .. key)) or 0) - value) > 1e-6 then same = false break end
		end
		if same then return name end
	end
end

local function drawPreset(art, name)
	local Sp = ns.RouteSparkle
	local look = Sp.PRESETS[name]
	local st = Sp.Style(function(key) if look[key] ~= nil then return look[key] end return ns.Get("nav." .. key) end)
	local w, h = W.CARD_W - 2, W.CARD_ART
	local function place()
		local c = st.color or { R.DefaultColor("walk") }
		art.psStars = art.psStars or {}
		local count = 3 + floor(st.spacing > 0 and (w - 24) / st.spacing or 6)
		for k = 1, count do
			local t = art.psStars[k]
			if not t then
				t = art:CreateTexture(nil, "ARTWORK", nil, 2)
				t:SetTexture(SPARKLE_TEXTURE)
				t:SetBlendMode("ADD")
				art.psStars[k] = t
			end
			local fx = (k - 0.5) / count
			-- Half again as big as on the map, so the card reads at its size; the presets keep their proportions.
			local s = 1.5 * st.size * (0.75 + 0.45 * Sp.Hash(k, 1))
			t:SetSize(s, s)
			t:ClearAllPoints()
			t:SetPoint("CENTER", art, "TOPLEFT", 12 + fx * (w - 24), -h / 2 + (Sp.Hash(k, 4) - 0.5) * st.jitter * s * 2)
			t:SetVertexColor(c[1], c[2], c[3])
			t:SetAlpha(min(1, max(0.35, 1.3 * st.alpha * (1 - 0.5 * st.twinkle * (1 - Sp.Hash(k, 2) ^ 3)))))
			t:Show()
		end
		for k = count + 1, #art.psStars do art.psStars[k]:Hide() end
	end
	place()
	W.Painter(art, function()
		st = Sp.Style(function(key) if look[key] ~= nil then return look[key] end return ns.Get("nav." .. key) end)
		place()
	end)
end

local PRESET_CARDS = {}
for i, name in ipairs(PRESETS) do PRESET_CARDS[i] = { value = name, label = PRESET_NAMES[name], draw = drawPreset } end

register(L["Sparkles"], {
	{ kind = "cards", label = L["Presets"], wide = true, new = NEW, disabled = off, choices = PRESET_CARDS,
		get = presetNow, set = function(v) R.ApplySparklePreset(v or "default") end,
		help = L["Subtle: fewer, smaller, calmer sparkles. Default: as they come. Dazzling: many bright sparkles flowing quickly toward the goal. The settings below fine-tune them."],
		search = "sparkle preset, subtle, default, dazzling, look" },
	{ kind = "dropdown", key = "nav.sparkleColor", label = L["Sparkle colour"], disabled = off,
		help = L["Loot gold is the colour of the game's own loot sparkle. Route colours tint each leg as the dots are."],
		search = "sparkle colour, color, gold, tint", choices = SPARKLE_COLORS },
	{ kind = "slider", key = "nav.sparkleSize", label = L["Sparkle size"], min = 6, max = 28, step = 1, format = px, disabled = off,
		help = L["Each sparkle's size before subtlety."], search = "sparkle size, bigger, smaller, huge, tiny" },
	{ kind = "slider", key = "nav.sparkleIntensity", label = L["Intensity"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
		help = L["How bright each sparkle and its glow are. The cog holds Subtlety: smaller, dimmer, calmer twinkles."],
		search = "sparkle brightness, glow, bright, strength",
		more = {
			{ kind = "slider", key = "nav.sparkleSubtlety", label = L["Sparkle subtlety"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
				help = L["Smaller, dimmer, calmer twinkles that drift less; no glow at 100%."], search = "sparkle calm, quiet, twinkle, subtle" },
		} },
	{ kind = "slider", key = "nav.sparkleDensity", label = L["Density"], min = 1, max = 10, step = 1, format = "%d", disabled = off,
		help = L["How close together the sparkles sit, the same at any zoom. The cog sets a ceiling on how many show."],
		search = "how many sparkles, spacing, amount, more, fewer",
		more = {
			{ kind = "slider", key = "nav.sparkleMax", label = L["Most shown"], min = 10, max = 400, step = 10, format = "%d", disabled = off,
				help = L["A ceiling on each map, whatever the density."], search = "sparkle limit, maximum, cap, performance, fps" },
		} },
	{ kind = "slider", key = "nav.sparkleFlow", label = L["Flow"], min = 0, max = 1, step = 0.05, format = percent, disabled = off,
		help = L["How fast the sparkles drift toward the goal; 0 holds them still."], search = "sparkle speed, drift, movement, animation, still, flow toward goal" },
	{ kind = "toggle", key = "nav.sparkleLater", label = L["Whole route"], disabled = off,
		help = L["Sparkle the legs after this one too, fainter. Off: only the leg you are on."], search = "sparkle all legs, later legs, whole way" },
}, { shown = drawn("sparkle") })

register(L["Flights & rides"], {
	colour("flight", "flightColor", L["Flights"], L["Flights' colour. Right-click for the theme's."],
		"flying colour, color, taxi, gryphon, wyvern, bat, flight path"),
	colour("boat", "boatColor", L["Boats"], L["Boats' colour. Right-click for the theme's."], "ship colour, color, ferry, sea, sail"),
	colour("zeppelin", "zeppelinColor", L["Zeppelins"], L["Zeppelins' colour. Right-click for the theme's."], "zeppelin colour, color, airship, blimp"),
	colour("tram", "tramColor", L["Trams & lifts"], L["The Deeprun Tram's and lifts' colour. Right-click for the theme's."],
		"tram colour, color, deeprun, lift, elevator, underground"),
})

-- Essentials (the page's lead tab): the styles, then the settings players
-- change most, each a reference to its row on Route; the size row is the
-- drawn style's own (line thickness, dot size or sparkle size).
local O = ns.UI and ns.UI.Options
if O and O.Ref then
	local Ref = O.Ref
	local ESSENTIALS = L["Essentials"]
	register(L["Style"], { Ref("cards", "nav.lineStyle") }, { tab = ESSENTIALS, lead = true })
	register(L["Route lines"], {
		Ref("slider", "nav.laterAlpha"), Ref("color", "nav.walkColor"),
		Ref("slider", "nav.worldRouteAlpha"), Ref("slider", "nav.minimapRouteAlpha"),
		Ref("slider", "nav.lineWidth", { needs = drawn("line") }), Ref("slider", "nav.dotSize", { needs = drawn("dots") }),
		Ref("slider", "nav.sparkleSize", { needs = drawn("sparkle") }), Ref("color", "nav.flightColor"),
	}, { tab = ESSENTIALS, jump = { tab = ROUTE, section = L["Route lines"] }, toggle = Ref("toggle", "nav.routeLines") })
end

