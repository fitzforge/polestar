-- The settings window's live previews: one component every page's preview
-- goes through (UI.Preview, Polestar_Options: loaded with the window).
--
-- The pinned preview. A page tab's `preview(host)` -> frame f with
-- f:Layout(width, height) -> height is built the first time the tab shows,
-- into its own host in the shell's preview slot, and laid out across the
-- main column (P.Place). It is never cut off: past its room it is shown
-- whole at the scale that fits, and says how much it shrank.
--
-- The band (P.Band(parent, opts) -> f): a Look tab's preview. The element
-- the tab sets and nothing else, at its real size (f:TrueScale()), centred
-- on the element on the window's plain ground, the band only as tall as it:
-- BAND_PAD over and under, [the picker], the element, [its states' labels],
-- [one hint line]; at most MAX of the body's height. No chrome.
--   f:Content(width) -> w, h, place(left, top, k)[, labels]  the page's: the
--                  element's natural size, what puts it at (left, top) at
--                  scale k, and its labels ({ fontstring, x } at their
--                  centres, in its units)
--   f:Label(text)  a state's label (a 12px Label in textMuted, centred)
--   opts.picker    { choices, get, set }: a centred dropdown over the element
--                  (a tab that sets several elements: the one shown)
--   opts.play      fn: a small Play button beside the element's foot
--   opts.watch     as the stage's (below)
--   An element too wide or too tall for the band is placed at the k that
--   fits, every part alike, never over 1; its hint line says so ("Shown at
--   86% to fit"), else it is the hotspots' one-time hint, else there is none.
--   P.MapHero(f)   the map pins' hero: a sharp 1:1 crop of Elwynn's world map
--                  (P.SharpArt, P.InnerShade) and the game's minimap, side by
--                  side; P.HERO_SCENE the scene in the map's pixels,
--                  P.HeroWorld(x, y) to world yards
--
-- The stage, for the tabs whose band comes later: a stage stands on a
-- backdrop at least HERO of the window's height (`height`, the room the page
-- may lay its scene out in; a smaller scene is centred on it), at most MAX of
-- the body's. Over it the slot's chrome (host.Chrome): "Preview" and the
-- frame's caption (f.caption: a string or a function) at the top left, the
-- Live mark and the backdrop's chip at the top right, and the hotspots'
-- one-time hint in a foot of its own.
--
-- The stage (P.Stage(parent, opts) -> s): the ground those previews draw on.
--   opts.height    its height (s.psHeight); s:Layout(width, height) returns
--                  it unless the page's own Layout says otherwise
--   s.Hero         the backdrop, a frame of its own under the stage (the
--                  hero's size once placed, the stage's before)
--   The backdrop, the player's pick for every preview with the chip at the
--   top right (PolestarDB.optionsBackdrop: not a setting, it moves nothing in
--   the game), the zone you stand in until one is picked:
--                  "world"  the zone you stand in (else your faction's first
--                           zone), painted from your own client's world map
--                           art (UI/ZoneArt.lua: Polestar ships none of it),
--                           dimmed, cooled and half desaturated; the night sky
--                           where the client has no art for it
--                  "sky"    Polestar's night band and its stars over the
--                           deepest ground, a lift of the sky colour
--                  "ground" the window's deepest ground alone
--                  A vignette darkens all four edges of the first two.
--   opts.fixed     its opts.backdrop always: its scene is a painting of its
--                  own (the map pins', the route lines'); no chip
--   opts.watch     setting path prefixes ("nav.", "toasts.rare."; "" every
--                  setting): a change of one repaints the stage at once while
--                  it shows (s:Paint(), the page's own), on its next show else;
--                  a theme change too
--   s:Fit(frame, w, h, k)  frame (w x h in its own units, at its own scale
--                  k) as large as the stage holds below the chrome, never
--                  larger than k, centred on a whole pixel; it says so in the
--                  caption when it had to shrink it. -> the scale it got
--   s:Snap(v)      v on a whole physical pixel of the stage
--   s:TrueScale()  the scale that draws a part of the scene at its true size
--                  on screen (the game's UI scale, whatever the window's Menu
--                  scale); the stage's own scale-to-fit still shrinks it all
--   s:Hot(region, key)  a click on region finds setting `key`'s row
--   s:Light(key, region, ...)  regions lit with key's row (below), no click;
--                  s:LightEdge: an outline alone (a big part, or one outside
--                  the stage: the settings window's own sidebar or header);
--                  s:LightRing: an outline standing off a part drawn in the
--                  accent itself; s:LightEach(key, fn[, ring]): fn() -> the
--                  parts to outline, found as the row is hovered (the
--                  window's own, which come and go)
--   s:Floor(frame[, pad])  a soft shadow on the ground under a surface of
--                  the scene (pad: how far past its sides, 18)
--   s:SideBySide(items, opts)  the scene's surfaces at their true size side
--                  by side in rows, centred on the hero, each on its floor
--                  shadow with its caption, smaller only where they would
--                  not fit (P.SideBySide) -> the scale
--   s:Animate(fn)  fn(elapsed) every frame while the stage shows, until it
--                  returns false
--   s.Content      the frame the page's parts go on (above the backdrop)
--   s:SetCut(cut)  the page's scene runs past the stage's foot (cropped):
--                  it fades out over the last CUT_FADE px while cut is true
--   P.Mob(s, opts) a mob in the world under the scene: its nameplate and its
--                  spot on the ground (the target's ring), m:Stand(x, y, k)
--
-- Preview hotspots: a part of a preview that a click takes to its setting.
--   P.Hotspot(frame, region, key) (O.PreviewHotspot, host:Hotspot or
--   s:Hot while it is built): under the cursor a 1px accent outline goes
--   round the part and the tooltip names the setting; a click opens its row
--   (O.Jump) and lights it. The first preview with hotspots says so once
--   ("Click a part of the preview to find its settings", under its band)
--   until the first click (PolestarDB.optionsPreviewHint).
-- The other way round: the pointer on a setting's row (its extras, its cog)
-- lights every hotspot of that setting and every region a page lights for it
-- (s:Light), the accent outline and a soft accent wash, until it leaves
-- (P.Focus -> P.LightUp(owner, key)).

local ns = Polestar
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
local type, pairs, ipairs, pcall, floor, max, min = type, pairs, ipairs, pcall, math.floor, math.max, math.min

-- Core's UI table (Polestar/UI/UI.lua); a test that loads a page alone, with
-- the module it draws but not core's UI, gets one here.
local UI = ns.UI or {}
ns.UI = UI

local P = {}
UI.Preview = P

-- The preview is the page's hero: its stage at least HERO of the window's
-- height, at most MAX of the body's (past that the page's scene is shown
-- whole, smaller); the chrome's row over its top.
local HERO, MAX, HINT_FOOT, CHROME = 0.40, 0.55, 24, 30
P.HERO, P.MAX, P.CHROME = HERO, MAX, CHROME

local function report(err)
	if geterrorhandler then geterrorhandler()(err) end
end

---------------------------------------------------------------------------
-- The backdrops
---------------------------------------------------------------------------

local BACKDROPS = { "world", "sky", "ground" }
local BACKDROP_LABEL = { world = L["World"], sky = L["Night sky"], ground = L["Plain"] }
-- A faction's first zone, where it has no zone of its own to show.
local HOME = { Alliance = 1429, Horde = 1411 }
-- The painting under a preview: a backdrop, not a picture to read. Dimmed
-- and cooled, half its colour out, so the map's own lettering and bright
-- ground sit back behind the preview's parts and text.
local DIM, DESAT = { 0.44, 0.45, 0.52 }, 0.5
local CUT_FADE = 28 -- px: a scene cropped at the stage's foot fades out over these
-- A floor shadow (s:Floor): the glow's soft cone in black at this opacity,
-- reaching FLOOR_OVER px up behind the surface's foot, FLOOR_H tall.
local FLOOR_ALPHA, FLOOR_OVER, FLOOR_H = 0.95, 10, 32

local stages = setmetatable({}, { __mode = "k" })

local function picked()
	local v = ns.DB().optionsBackdrop
	for _, b in ipairs(BACKDROPS) do if v == b then return v end end
	return nil
end

-- The backdrop a stage shows: the player's pick, else the zone they stand
-- in; a stage whose scene is a painting of its own keeps its page's
-- (opts.fixed).
local function backdropOf(s)
	if s.psFixed then return s.psBackdrop end
	return picked() or "world"
end
P.BackdropOf = backdropOf

-- The zone the world backdrop paints, and where in it: where you stand, else
-- your faction's first zone, its middle.
local function where()
	local C = ns.Compat
	if C and C.GetPlayerMapPosition then
		local ok, map, x, y = pcall(C.GetPlayerMapPosition)
		if ok and map then return map, x, y end
	end
	local faction = C and C.GetPlayerFaction and C.GetPlayerFaction()
	return HOME[faction or "Alliance"] or HOME.Alliance, 50, 45
end

-- The size the backdrop paints: the hero's once the window has placed the
-- stage (P.Place), else the stage's own.
local function heroSize(s)
	local w = rawget(s, "psHeroW") or s.psWidth or 600
	local h = rawget(s, "psHeroH") or s.psHeight
	return max(1, floor(w + 0.5)), max(1, floor(h + 0.5))
end

-- The world backdrop's painting, made on first use: below the stage's own
-- level (the page's parts go above it), its card fade and rule left out.
-- Kept as s.psWorldArt (a page's own painting may be its s.Art: the route
-- lines' world panel).
local function worldArt(s)
	local a = rawget(s, "psWorldArt")
	if a then return a end
	local ZA = UI.ZoneArt
	if not (ZA and ZA.Create) then return nil end
	local w, h = heroSize(s)
	a = ZA.Create(s.Back, w, h, "scrim")
	a.psTint, a.psZoom, a.psDesat = DIM, 1.35, DESAT
	a.Fade:Hide()
	a.Top:Hide()
	a.Rule:Hide()
	-- Between the ground (s.Back) and the vignette (s.Edges).
	local level = s.Back:GetFrameLevel() + 1
	a:SetFrameLevel(level)
	a.Canvas:SetFrameLevel(level)
	a.Over:SetFrameLevel(level)
	a:ClearAllPoints()
	a:SetPoint("TOPLEFT", s.Hero, "TOPLEFT", 0, 0)
	s.psWorldArt = a
	return a
end

-- Paints the stage's backdrop for its size (on a layout, a pick, a theme
-- change); again only when its kind, size or zone changed (force: anyway).
local function paintBackdrop(s, force)
	local kind = backdropOf(s)
	local w, h = heroSize(s)
	local world = kind == "world"
	local map, x, y
	if world then map, x, y = where() end
	local sig = kind .. w .. "x" .. h .. ":" .. tostring(map) .. ":" .. floor(x or 0) .. ":" .. floor(y or 0)
	if sig == s.psBackdropSig and not force then return end
	s.psBackdropSig = sig
	local art = world and worldArt(s) or rawget(s, "psWorldArt")
	local painted = false
	if art then
		art:SetShown(world)
		if world then
			art:SetSize(w, h)
			art.psW, art.psH, art.psFocusY = w, h, h / 2
			local ok, done = pcall(UI.ZoneArt.Paint, art, map, x, y, 1)
			painted = ok and done or false
			if not ok then report(done) end
		end
	end
	-- The night sky: the band across the top, a lift of the sky colour
	-- behind the middle; under a painting that could not be drawn too.
	local sky = kind == "sky" or (world and not painted)
	s.Band:SetShown(sky and not (world and art))
	s.Lift:SetShown(sky)
	if sky then
		s.Band:SetHeight(min(h, Theme.BAND_H))
		s.Band:SetTexCoord(Theme.BandCoords(w, min(h, Theme.BAND_H)))
		s.Lift:ClearAllPoints()
		s.Lift:SetSize(w * 0.7, h * 1.6)
		s.Lift:SetPoint("CENTER", s.Hero, "TOPLEFT", w * 0.45, -h * 0.4)
	end
	-- The vignette: a soft dark edge all round a painting or the sky, deeper
	-- top and bottom, so the scene sits in the middle and its parts read.
	local edged = kind ~= "ground"
	for _, t in ipairs({ s.EdgeTop, s.EdgeBottom, s.EdgeLeft, s.EdgeRight }) do t:SetShown(edged) end
	s.EdgeTop:SetHeight(floor(h * 0.42))
	s.EdgeBottom:SetHeight(floor(h * 0.42))
	s.EdgeLeft:SetWidth(floor(min(w * 0.18, h * 0.9)))
	s.EdgeRight:SetWidth(floor(min(w * 0.18, h * 0.9)))
	s.psPainted = painted
end

-- A gradient from alpha a0 at the texture's start to a1 at its end ("VERTICAL":
-- bottom to top, "HORIZONTAL": left to right).
local function gradient(t, dir, r, g, b, a0, a1)
	if t.SetGradient and CreateColor then
		t:SetGradient(dir, CreateColor(r, g, b, a0), CreateColor(r, g, b, a1))
	else
		t:SetVertexColor(r, g, b, (a0 + a1) / 2)
	end
end

local function paintEdges(s)
	local r, g, b = Theme.Color("scrim")
	gradient(s.EdgeTop, "VERTICAL", r, g, b, 0, 0.62)
	gradient(s.EdgeBottom, "VERTICAL", r, g, b, 0.7, 0)
	gradient(s.EdgeLeft, "HORIZONTAL", r, g, b, 0.5, 0)
	gradient(s.EdgeRight, "HORIZONTAL", r, g, b, 0, 0.5)
	-- A scene cropped at the stage's foot (s:SetCut) fades into the ground
	-- over its last pixels, so the cut reads as the scene going on below.
	gradient(s.Fade, "VERTICAL", r, g, b, 0.92, 0)
	for _, t in pairs(rawget(s, "psFloors") or {}) do
		t:SetVertexColor(0, 0, 0, FLOOR_ALPHA)
	end
	local sr, sg, sb = Theme.Color("sky")
	s.Lift:SetVertexColor(sr, sg, sb, 0.75)
	Theme.Border(s.Hero, Theme.Wash("divider"))
end

-- Every stage's backdrop again (the chip, a theme change).
local function repaintBackdrops()
	for s in pairs(stages) do
		if s:IsVisible() then paintBackdrop(s, true) else s.psBackdropDirty = true end
	end
end
P.RepaintBackdrops = repaintBackdrops

-- The player's next backdrop, for every preview.
function P.NextBackdrop()
	local cur = picked() or "world"
	local at = 1
	for i, b in ipairs(BACKDROPS) do if b == cur then at = i end end
	ns.DB().optionsBackdrop = BACKDROPS[at % #BACKDROPS + 1]
	repaintBackdrops()
	ns.Fire("OPTIONS_PREVIEW_BACKDROP")
	return ns.DB().optionsBackdrop
end

---------------------------------------------------------------------------
-- The stage
---------------------------------------------------------------------------

local function prefixMatch(watch, path)
	if type(path) ~= "string" or path == "" then return true end
	for _, p in ipairs(watch) do
		if p == "" or path == p or path:sub(1, #p) == p then return true end
		-- A whole section reset ("nav") reaches its prefix ("nav.").
		if p:sub(-1) == "." and path == p:sub(1, -2) then return true end
	end
	return false
end

local function repaint(s)
	s.psDirty = nil
	if type(s.Paint) == "function" then
		local ok, err = pcall(s.Paint, s)
		if not ok then report(err) end
	end
end

-- A soft shadow on the ground under a surface of the scene (s:Floor), on
-- the hero's floor layer: under the surface, over the backdrop. The glow's
-- soft cone in black, its middle a little under the surface's foot, so it
-- reads as the shadow the surface casts where it stands.
local function floorOf(s, frame, pad)
	local floors = rawget(s, "psFloors")
	if not floors then
		floors = {}
		s.psFloors = floors
	end
	local t = floors[frame]
	if not t then
		t = s.FloorLayer:CreateTexture(nil, "ARTWORK")
		t:SetTexture(Theme.Media("glow"))
		t:SetVertexColor(0, 0, 0, FLOOR_ALPHA)
		floors[frame] = t
	end
	pad = pad or 18
	t:ClearAllPoints()
	t:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", -pad, FLOOR_OVER)
	t:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", pad, FLOOR_OVER)
	t:SetHeight(FLOOR_H)
	t:Show()
	return t
end
P.Floor = floorOf

-- No floor shadow under frame (a surface cropped at the stage's foot).
function P.NoFloor(s, frame)
	local t = rawget(s, "psFloors") and s.psFloors[frame]
	if t then t:Hide() end
end

function P.Stage(parent, opts)
	opts = opts or {}
	local s = CreateFrame("Frame", nil, parent)
	s.psHeight = opts.height or 168
	s.psWidth = 600
	s.psBackdrop, s.psFixed = opts.backdrop or "world", opts.fixed and true or nil
	s:SetHeight(s.psHeight)
	if s.SetClipsChildren then s:SetClipsChildren(true) end
	-- The hero: the backdrop the scene stands on, a frame of its own under
	-- the stage (not clipped by it), as tall as the window gives the preview
	-- (P.Place); until placed it covers the stage.
	local base = parent:GetFrameLevel()
	s.Hero = CreateFrame("Frame", nil, parent)
	s.Hero:SetFrameLevel(base + 1)
	s.Hero:SetAllPoints(s)
	if s.Hero.SetClipsChildren then s.Hero:SetClipsChildren(true) end
	-- The scene's parts sit above the backdrop.
	s:SetFrameLevel(base + 4)
	s.Back = CreateFrame("Frame", nil, s.Hero)
	s.Back:SetAllPoints(s.Hero)
	s.Back:SetFrameLevel(base + 1)
	W.Fill(s.Back, "scrim", "BACKGROUND", -8)
	s.Lift = W.Tex(s.Back, "BACKGROUND", "glow", nil, -7)
	s.Band = Theme.Band(s.Back, "BACKGROUND", -6)
	s.Band:SetPoint("TOPLEFT", s.Hero, "TOPLEFT", 0, 0)
	s.Band:SetPoint("TOPRIGHT", s.Hero, "TOPRIGHT", 0, 0)
	s.Band:SetHeight(Theme.BAND_H)
	-- The vignette, all four edges.
	s.Edges = CreateFrame("Frame", nil, s.Hero)
	s.Edges:SetAllPoints(s.Hero)
	s.Edges:SetFrameLevel(base + 3)
	local function edge(p1, p2)
		local t = s.Edges:CreateTexture(nil, "ARTWORK")
		t:SetTexture(Theme.Media("white"))
		t:SetPoint(p1, s.Hero, p1, 0, 0)
		t:SetPoint(p2, s.Hero, p2, 0, 0)
		return t
	end
	s.EdgeTop = edge("TOPLEFT", "TOPRIGHT")
	s.EdgeBottom = edge("BOTTOMLEFT", "BOTTOMRIGHT")
	s.EdgeLeft = edge("TOPLEFT", "BOTTOMLEFT")
	s.EdgeRight = edge("TOPRIGHT", "BOTTOMRIGHT")
	-- The floor shadows under the scene's surfaces (s:Floor).
	s.FloorLayer = CreateFrame("Frame", nil, s.Hero)
	s.FloorLayer:SetAllPoints(s.Hero)
	s.FloorLayer:SetFrameLevel(base + 3)
	-- Over the page's parts, under the window's chrome: the fade of a scene
	-- cropped at the stage's foot (s:SetCut(true)), painted with the edges.
	local over = CreateFrame("Frame", nil, s)
	over:SetAllPoints(s)
	over:SetFrameLevel(s:GetFrameLevel() + 20)
	s.Fade = over:CreateTexture(nil, "OVERLAY")
	s.Fade:SetTexture(Theme.Media("white"))
	s.Fade:SetPoint("BOTTOMLEFT", s, "BOTTOMLEFT", 0, 0)
	s.Fade:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", 0, 0)
	s.Fade:SetHeight(CUT_FADE)
	s.Fade:Hide()
	function s:SetCut(cut) self.Fade:SetShown(cut and true or false) end
	function s:Floor(frame, pad) return floorOf(self, frame, pad) end
	function s:NoFloor(frame) return P.NoFloor(self, frame) end
	function s:Light(key, ...) return P.Light(self, key, ...) end
	function s:LightEach(key, fn, ring) return P.LightEach(self, key, fn, ring) end
	function s:LightRing(key, ...) return P.LightRing(self, key, ...) end
	function s:LightEdge(key, ...) return P.LightEdge(self, key, ...) end
	function s:Hot(region, key) return P.Hot(self, region, key) end
	function s:TrueScale() return P.TrueScale(self) end
	function s:SideBySide(items, o) return P.SideBySide(self, items, o) end
	W.Painter(s, paintEdges)
	-- The page's parts.
	s.Content = CreateFrame("Frame", nil, s)
	s.Content:SetAllPoints(s)
	s.Content:SetFrameLevel(s:GetFrameLevel() + 1)
	s.caption = function() return s.psNote end
	s.psWatch = opts.watch
	stages[s] = true
	s:SetScript("OnShow", function(self)
		self.Hero:Show()
		if self.psBackdropDirty then
			self.psBackdropDirty = nil
			paintBackdrop(self, true)
		end
		if self.psDirty then repaint(self) end
		if self.psAnimate then self:SetScript("OnUpdate", self.psTick) end
	end)
	s:SetScript("OnHide", function(self)
		self.Hero:Hide()
		self:SetScript("OnUpdate", nil)
	end)
	-- The page's own layout over the stage's; the stage keeps the backdrop
	-- across the width it is given. height: the hero's (P.Place), the room
	-- the page may lay its scene out in.
	function s:Layout(width, height)
		self:SetWidth(width)
		self.psWidth = width
		paintBackdrop(self)
		local h = self.psHeight
		if type(self.Arrange) == "function" then
			local ok, got = pcall(self.Arrange, self, width, height)
			if not ok then report(got) elseif tonumber(got) then h = tonumber(got) end
		end
		if self.psDirty then repaint(self) end
		return h
	end
	paintBackdrop(s)
	return s
end

-- The settings and theme changes a stage repaints on (its opts.watch).
ns.On("SETTING_CHANGED", function(path)
	for s in pairs(stages) do
		local watch = s.psWatch
		if watch and prefixMatch(watch, path) then
			if s:IsVisible() then repaint(s) else s.psDirty = true end
		end
	end
end)
Theme.OnChanged(function()
	for s in pairs(stages) do
		if s:IsVisible() then
			paintBackdrop(s, true)
			if s.psWatch then repaint(s) end
		else
			s.psBackdropDirty = true
			if s.psWatch then s.psDirty = true end
		end
	end
end)

-- Whether frame f is a stage (P.Stage made it).
function P.IsStage(f) return f ~= nil and stages[f] == true end

-- v on a whole physical pixel of frame f (the stage).
function P.Snap(f, v)
	local px = Theme.Pixel(f)
	if not (px and px > 0) then return v end
	return floor(v / px + 0.5) * px
end

-- The scale that draws a part of stage s at its true size on screen (the
-- game's UI scale, whatever the settings window's Menu scale): against the
-- stage's parent, so the stage's own scale-to-fit (P.Place) still applies.
function P.TrueScale(s)
	local parent = s:GetParent()
	local u = UIParent and UIParent.GetEffectiveScale and UIParent:GetEffectiveScale() or 1
	local e = parent and parent.GetEffectiveScale and parent:GetEffectiveScale() or u
	if not (u and e and e > 0 and u > 0) then return 1 end
	return u / e
end

-- frame (w x h in its own units, at scale k) as large as the stage holds
-- below the chrome, never larger than k, centred on a whole pixel. opts:
-- pad (each side, 32), bottom (room kept under it, 12: a Play button's
-- more), anchor (fn(frame, point, rel, relPoint, x, y), as Anim.Anchor, so
-- an entrance slides from its place). -> the scale it got
function P.Fit(s, frame, w, h, k, opts)
	opts = opts or {}
	local pad, bottom = opts.pad or 32, opts.bottom or 12
	k = k or 1
	local sw = s.psWidth or 600
	local availW, availH = sw - 2 * pad, s.psHeight - CHROME - bottom - 8
	local fit = min(1, availW / max(1, w * k), availH / max(1, h * k))
	local scale = k * fit
	frame.psFit = fit
	frame:SetScale(scale)
	-- Its top-left on a whole pixel at its scale, centred in the room.
	local cx, cy = sw / 2, -(CHROME + (s.psHeight - CHROME - bottom) / 2)
	local ox = P.Snap(frame, cx / scale - w / 2)
	local oy = P.Snap(frame, cy / scale + h / 2)
	if opts.anchor then
		opts.anchor(frame, "TOPLEFT", s, "TOPLEFT", ox, oy)
	else
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", s, "TOPLEFT", ox, oy)
	end
	s.psNote = fit < 0.995 and string.format(L["Shown at %d%% to fit"], floor(fit * 100 + 0.5)) or ""
	return scale
end

-- Surfaces of the scene at their true size side by side, in rows (a row
-- wraps where the next would not fit across), each row's feet on one line,
-- the whole centred in the hero's room under the chrome, each surface on a
-- soft floor shadow with its caption under it; all smaller alike only where
-- they would not fit. items: { w, h (stage units at k = 1), place = fn(k,
-- left, top) (its top-left in stage units), foot (the frame its shadow
-- stands under; nil: none), pad (the shadow's, s:Floor's), caption (a font
-- string, or nil) }. opts: top (under the chrome), bottom (12), pad (32 a
-- side), gap (40 between two), rowGap (24). -> the scale k
local CAPTION_GAP, CAPTION_H = 22, 16
function P.SideBySide(s, items, opts)
	opts = opts or {}
	local width, height = s.psWidth or 0, s.psHeight or 0
	if width <= 0 or #items == 0 then return 1 end
	local top, bottom, pad = opts.top or (CHROME + 4), opts.bottom or 12, opts.pad or 32
	local gap, rowGap = opts.gap or 40, opts.rowGap or 24
	local roomW, roomH = width - 2 * pad, height - top - bottom
	local function rowsAt(k)
		local list, row = {}, nil
		for _, it in ipairs(items) do
			local w = it.w * k
			if row and row.w + gap + w > roomW then row = nil end
			if not row then
				row = { items = {}, w = 0, h = 0, cap = 0 }
				list[#list + 1] = row
			else
				row.w = row.w + gap
			end
			row.items[#row.items + 1] = it
			row.w = row.w + w
			row.h = max(row.h, it.h * k)
			if it.caption then row.cap = CAPTION_GAP + CAPTION_H end
		end
		local total, widest = 0, 0
		for i, r in ipairs(list) do
			total = total + r.h + r.cap + (i > 1 and rowGap or 0)
			widest = max(widest, r.w)
		end
		return list, total, widest
	end
	local k, list, total, widest = 1, nil, 0, 0
	for _ = 1, 6 do
		list, total, widest = rowsAt(k)
		local fit = min(1, roomW / max(1, widest), roomH / max(1, total))
		if fit >= 0.995 then break end
		k = k * fit
	end
	local y = top + max(0, (roomH - total) / 2)
	for _, r in ipairs(list) do
		local x = pad + (roomW - r.w) / 2
		local foot = y + r.h
		for _, it in ipairs(r.items) do
			local w, h = it.w * k, it.h * k
			it.place(k, P.Snap(s, x), P.Snap(s, foot - h))
			if it.foot then floorOf(s, it.foot, it.pad) end
			if it.caption then
				it.caption:ClearAllPoints()
				it.caption:SetPoint("TOP", s, "TOPLEFT", P.Snap(s, x + w / 2), -P.Snap(s, foot + CAPTION_GAP))
			end
			x = x + w + gap
		end
		y = foot + r.cap + rowGap
	end
	s.psNote = k < 0.995 and string.format(L["Shown at %d%% to fit"], floor(k * 100 + 0.5)) or ""
	return k
end

function P.Animate(s, fn)
	s.psAnimate = fn
	s.psTick = function(self, elapsed)
		local ok, more = pcall(fn, elapsed)
		if not ok then report(more) end
		if not ok or more == false then
			self.psAnimate = nil
			self:SetScript("OnUpdate", nil)
		end
	end
	if s:IsVisible() then s:SetScript("OnUpdate", s.psTick) end
end

---------------------------------------------------------------------------
-- A mob in the world under a scene
---------------------------------------------------------------------------

-- A mob as the game shows one, where a scene's surfaces act on it (the
-- target button's name, a rare alert's rare): its nameplate (its name over
-- a health bar, its level beside it, in the game's font, a raid mark over
-- it) and, STAND px under the bar, its spot on the ground: a soft shadow
-- and a ring (the selection ring while it is your target). Plain frames, no
-- unit. opts: name, level, health (0-1), target (the ring red and the
-- plate's white edge), mark (a raid mark, 1-8), ring ({ r, g, b }: a ring
-- of that colour). -> m; m:Stand(x, y, k) puts its ground spot at (x, y) on
-- the stage (y down from its top), drawn at scale k; m.UP, m.HALF: how far
-- it reaches up and to each side of that spot at k = 1.
local PLATE_W, BAR_H, STAND, GROUND = 112, 7, 38, 12
-- The UI's own textures, but for the raid mark (the Buttons page's alone).
local RAID_ICON = "Interface\\TargetingFrame\\UI-RaidTargetingIcon_"
function P.Mob(s, opts)
	local m = CreateFrame("Frame", nil, s)
	local font, white = STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", Theme.Media("white")
	m.Shadow = m:CreateTexture(nil, "BACKGROUND")
	m.Shadow:SetTexture(Theme.Media("glow"))
	m.Shadow:SetVertexColor(0, 0, 0, 0.75)
	m.Shadow:SetSize(90, 32)
	m.Shadow:SetPoint("CENTER", m, "BOTTOM", 0, GROUND)
	local c = opts.ring or (opts.target and { 0.92, 0.16, 0.1 })
	if c then
		-- The ring and a soft glow of its colour inside it, flat on the ground.
		m.Spot = m:CreateTexture(nil, "BORDER")
		m.Spot:SetTexture(Theme.Media("glow"))
		m.Spot:SetSize(70, 24)
		m.Spot:SetPoint("CENTER", m, "BOTTOM", 0, GROUND)
		m.Ring = m:CreateTexture(nil, "ARTWORK")
		m.Ring:SetTexture(Theme.Media("qol-ring"))
		m.Ring:SetSize(72, 25)
		m.Ring:SetPoint("CENTER", m, "BOTTOM", 0, GROUND)
	end
	-- The ring's colour (r, g, b), its glow's with it.
	function m:Tint(r, g, b)
		if not rawget(self, "Ring") then return end
		self.Ring:SetVertexColor(r, g, b, 0.95)
		self.Spot:SetVertexColor(r, g, b, 0.3)
	end
	if c then m:Tint(c[1], c[2], c[3]) end
	local bar = CreateFrame("Frame", nil, m)
	bar:SetSize(PLATE_W, BAR_H)
	bar:SetPoint("BOTTOM", m, "BOTTOM", 0, GROUND + STAND)
	local bg = bar:CreateTexture(nil, "BACKGROUND")
	bg:SetTexture(white)
	bg:SetAllPoints(bar)
	bg:SetVertexColor(0, 0, 0, 0.72)
	m.Fill = bar:CreateTexture(nil, "ARTWORK")
	m.Fill:SetTexture(white)
	m.Fill:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0)
	m.Fill:SetPoint("BOTTOMLEFT", bar, "BOTTOMLEFT", 0, 0)
	m.Fill:SetWidth(max(1, PLATE_W * (opts.health or 1)))
	m.Fill:SetVertexColor(0.82, 0.1, 0.06, 1)
	if opts.target then Theme.Border(bar, 1, 1, 1, 0.9) else Theme.Border(bar, 0, 0, 0, 1) end
	m.Bar = bar
	m.Name = m:CreateFontString(nil, "OVERLAY")
	m.Name:SetFont(font, 10, "OUTLINE")
	m.Name:SetTextColor(1, 1, 1, 1)
	m.Name:SetPoint("BOTTOM", bar, "TOP", 0, 3)
	m.Name:SetText(opts.name or "")
	m.Level = m:CreateFontString(nil, "OVERLAY")
	m.Level:SetFont(font, 9, "OUTLINE")
	m.Level:SetTextColor(1, 0.82, 0, 1)
	m.Level:SetPoint("LEFT", bar, "RIGHT", 4, 0)
	m.Level:SetText(opts.level and tostring(opts.level) or "")
	if opts.mark then
		m.Mark = m:CreateTexture(nil, "OVERLAY")
		m.Mark:SetTexture(RAID_ICON .. opts.mark)
		m.Mark:SetSize(20, 20)
		m.Mark:SetPoint("BOTTOM", m.Name, "TOP", 0, 2)
	end
	m.UP = STAND + BAR_H + 3 + 12 + (opts.mark and 22 or 0)
	m.HALF = PLATE_W / 2 + 18
	m:SetSize(PLATE_W + 36, GROUND + m.UP)
	function m:Stand(x, y, k)
		self:SetScale(k)
		self:ClearAllPoints()
		self:SetPoint("BOTTOM", s, "TOPLEFT", x / k, -(y / k + GROUND))
	end
	return m
end

---------------------------------------------------------------------------
-- Hotspots
---------------------------------------------------------------------------

local hosts = setmetatable({}, { __mode = "k" })

local function hintDismissed() return ns.DB().optionsPreviewHint == true end

local function hostOf(f)
	while f do
		if rawget(f, "psIsHost") then return f end
		f = f:GetParent()
	end
end

-- A hotspot's or a light's outline: on under the cursor, or lit while the
-- pointer is on its setting's row (P.Focus), with a soft wash of the accent
-- (none on a light of a part outside the stage: s:LightEdge).
local function hotspotEdge(b, on)
	local r, g, bb = Theme.Accent()
	local lit = rawget(b, "psLit")
	Theme.Border(b, r, g, bb, (on or lit) and 1 or 0)
	if rawget(b, "psEdgeOnly") then return end
	local wash = rawget(b, "Wash")
	if lit and not wash then
		wash = b:CreateTexture(nil, "BACKGROUND")
		wash:SetTexture(Theme.Media("white"))
		wash:SetAllPoints(b)
		b.Wash = wash
	end
	if wash then
		wash:SetVertexColor(r, g, bb, 0.16)
		wash:SetShown(lit and true or false)
	end
end

-- The host's lit parts by setting (P.Focus): every hotspot of a key and every
-- region a stage lights for it (s:Light).
local function byKey(host, key)
	local map = rawget(host, "psByKey")
	if not map then
		map = {}
		host.psByKey = map
	end
	local list = map[key]
	if not list then
		list = {}
		map[key] = list
	end
	return list
end

local function controlFor(key)
	local O = UI.Options
	return O and O.ControlByKey and O.ControlByKey(key)
end

function P.Hotspot(frame, region, key)
	local b = CreateFrame("Button", nil, frame)
	b:SetAllPoints(region)
	b:SetFrameLevel(frame:GetFrameLevel() + 20)
	b.psKey, b.psPadSkip = key, true
	hotspotEdge(b, false)
	b:SetScript("OnEnter", function(self)
		hotspotEdge(self, true)
		local c = controlFor(self.psKey)
		local O = UI.Options
		if c then W.Tooltip(self, "ANCHOR_TOP", O.LabelOf(c), { L["Click to find its settings."] }) end
	end)
	b:SetScript("OnLeave", function(self)
		hotspotEdge(self, false)
		W.HideTooltip(self)
	end)
	b:SetScript("OnClick", function(self)
		if not hintDismissed() then
			ns.DB().optionsPreviewHint = true
			for h in pairs(hosts) do
				h.Hint:Hide()
				h.Foot:Hide()
			end
			P.HintGone()
		end
		local c = controlFor(self.psKey)
		if c then UI.Options.Jump(c) end
	end)
	local host = hostOf(frame)
	if host then host.psHotspots = (host.psHotspots or 0) + 1 end
	local list = byKey(host or frame, key)
	list[#list + 1] = b
	return b
end

-- A stage's hotspot, kept on it by key (s.Hots).
function P.Hot(s, region, key)
	if not region then return nil end
	local b = P.Hotspot(s, region, key)
	local hots = rawget(s, "Hots")
	if not hots then
		hots = {}
		s.Hots = hots
	end
	hots[key] = b
	return b
end

-- Whether region is on stage s (a part of its scene).
local function onStage(region, s)
	local f = region.GetParent and region:GetParent()
	while f do
		if f == s then return true end
		f = f:GetParent()
	end
	return false
end

-- A light's frame, made the first time it lights: over its region, above
-- the stage's parts; for a part outside the stage (the settings window's
-- own: its sidebar, its header's band), above that part, an outline only.
-- A ring (rec.psOut) stands that far off the part all round.
local function lightFrame(rec)
	local region, s = rec.psRegion, rec.psStage
	local parent = s
	if not onStage(region, s) then
		parent = (region.IsObjectType and region:IsObjectType("Frame")) and region or region:GetParent()
	end
	local l = CreateFrame("Frame", nil, parent)
	local o = rec.psOut or 0
	l:SetPoint("TOPLEFT", region, "TOPLEFT", -o, o)
	l:SetPoint("BOTTOMRIGHT", region, "BOTTOMRIGHT", o, -o)
	-- Over the scene's parts; over a window part's children (its rows).
	l:SetFrameLevel(parent:GetFrameLevel() + (parent == s and 18 or 60))
	l:EnableMouse(false)
	l.psKey, l.psEdgeOnly = rec.psKey, (rec.psEdgeOnly or parent ~= s) or nil
	return l
end

-- Parts of the scene a setting changes, lit (outline and accent wash) while
-- the pointer is on that setting's row, without being a click target of
-- their own: s:Light(key, region, ...); s:LightEdge for an outline alone (a
-- big part, or one outside the stage); s:LightRing for a part drawn in the
-- accent itself, where an outline on it would not show: an outline RING px
-- off it all round. Each light's frame is made the first time it lights
-- (rec.Frame). -> the lights
local RING = 3
local function addLights(s, key, edge, out, ...)
	local list = byKey(hostOf(s) or s, key)
	local made = {}
	for i = 1, select("#", ...) do
		local region = select(i, ...)
		if region then
			local rec = { psRegion = region, psStage = s, psKey = key, psEdgeOnly = edge or nil, psOut = out }
			list[#list + 1] = rec
			made[#made + 1] = rec
		end
	end
	return made
end
function P.Light(s, key, ...) return addLights(s, key, false, nil, ...) end
function P.LightEdge(s, key, ...) return addLights(s, key, true, nil, ...) end
function P.LightRing(s, key, ...) return addLights(s, key, true, RING, ...) end

-- Parts found as the row is hovered, each outlined alone: what comes and
-- goes with the page or tab on screen (the settings window's own controls
-- in the accent). s:LightEach(key, fn[, ring]): fn() -> a list of regions;
-- each one's light is made the first time it lights, a ring off it with
-- `ring` (as s:LightRing). -> the record
function P.LightEach(s, key, fn, ring)
	local list = byKey(hostOf(s) or s, key)
	local rec = { psEach = fn, psStage = s, psKey = key, psOut = ring and RING or nil, psMade = setmetatable({}, { __mode = "k" }) }
	list[#list + 1] = rec
	return rec
end

-- Shown, and not faded out (a part a crop left out has its alpha at 0).
local function showing(region)
	if region.IsVisible and not region:IsVisible() then return false end
	local f = region
	while f do
		if f.GetAlpha and f:GetAlpha() <= 0.001 then return false end
		f = f.GetParent and f:GetParent()
	end
	return true
end

-- The frame that shows a hotspot or a light (a light's made now if need be).
local function shownBy(b, make)
	if not rawget(b, "psRegion") then return b end
	local l = rawget(b, "Frame")
	if not l and make then
		l = lightFrame(b)
		b.Frame = l
	end
	return l
end

-- Lights setting `key`'s parts on the preview `owner` holds (its host, or the
-- stage itself), and puts out the ones lit before; nil puts them all out. A
-- light whose part is not showing (a surface a narrow page leaves out, a
-- tab's underline while another tab is open) stays dark. -> how many it lit
function P.LightUp(owner, key)
	if not owner then return 0 end
	for _, l in ipairs(rawget(owner, "psLitList") or {}) do
		l.psLit = nil
		hotspotEdge(l, false)
	end
	owner.psLitList = nil
	local list = key and rawget(owner, "psByKey") and owner.psByKey[key]
	if not list then return 0 end
	local lit = {}
	for _, b in ipairs(list) do
		local each = rawget(b, "psEach")
		if each then
			local ok, parts = pcall(each)
			if not ok then report(parts) end
			for _, region in ipairs(ok and type(parts) == "table" and parts or {}) do
				if showing(region) then
					local l = b.psMade[region]
					if not l then
						l = lightFrame({ psRegion = region, psStage = b.psStage, psKey = key, psEdgeOnly = true, psOut = b.psOut })
						b.psMade[region] = l
					end
					lit[#lit + 1] = l
				end
			end
		elseif not rawget(b, "psRegion") or showing(b.psRegion) then
			lit[#lit + 1] = shownBy(b, true)
		end
	end
	for _, l in ipairs(lit) do
		l.psLit = true
		hotspotEdge(l, false)
	end
	owner.psLitList = lit
	return #lit
end

---------------------------------------------------------------------------
-- The band
---------------------------------------------------------------------------

-- The band's geometry (UI units at scale 1): the room over and under its
-- content, the dropdown and its gap to the element, a label's or the hint's
-- gap and line, the gap between two states, the room kept each side of the
-- element before it is shrunk, Play's gap to the element and its height.
local BAND_PAD, PICKER_W, PICKER_H, PICKER_GAP = 20, 220, 28, 14
local LINE_GAP, LINE_H, STATE_GAP, BAND_SIDE = 10, 15, 40, 24
local PLAY_GAP, PLAY_H = 16, 22
P.BAND_PAD, P.PICKER_H, P.PICKER_GAP, P.LINE_GAP, P.LINE_H, P.STATE_GAP = BAND_PAD, PICKER_H, PICKER_GAP, LINE_GAP, LINE_H, STATE_GAP

local bands = setmetatable({}, { __mode = "k" })

-- The band laid out again where it is: through the settings window while it
-- holds it (its height may change), else in place; while hidden, on its
-- next show.
local function bandAgain(f)
	if not f:IsVisible() then
		f.psDirty = true
		return
	end
	local O = UI.Options
	if hostOf(f) and O and O.Relayout then
		O.Relayout()
	elseif f.psWidth then
		f:Layout(f.psWidth, f.psRoom)
	end
end

-- Its dropdown: the window's dropdown box, centred, its menu the shared
-- popup menu. pick = { choices = { { value, label }, ... } or fn, get, set }
local function choicesOf(pick)
	local list = pick.choices
	if type(list) == "function" then list = list() end
	return list or {}
end

local function pickerLabel(f)
	local pick, cur = f.psPick, f.psPick.get()
	for _, c in ipairs(choicesOf(pick)) do
		if c.value == cur then return c.label end
	end
	return ""
end

local function newPicker(f)
	local b = CreateFrame("Button", nil, f)
	b:SetSize(PICKER_W, PICKER_H)
	Theme.Skin(b, "dropdown")
	b.Label = W.Text(b, "label", "text")
	b.Label:SetPoint("LEFT", b, "LEFT", 10, 0)
	b.Label:SetPoint("RIGHT", b, "RIGHT", -26, 0)
	b.Arrow = W.Tex(b, "ARTWORK", "chevron-down", "textDim")
	b.Arrow:SetSize(12, 12)
	b.Arrow:SetPoint("RIGHT", b, "RIGHT", -9, 0)
	b:SetScript("OnClick", function(self)
		if W.MenuShown(self) then return W.HideMenu() end
		local pick, items = f.psPick, {}
		local cur = pick.get()
		for i, c in ipairs(choicesOf(pick)) do
			items[i] = { text = c.label, checked = c.value == cur, onClick = function()
				pick.set(c.value)
				bandAgain(f)
			end }
		end
		W.ShowMenu(self, items, { minWidth = PICKER_W, point = "TOP", relPoint = "BOTTOM" })
	end)
	return b
end

-- The tab's preview as a band: the element the
-- tab sets, alone, at its real size (1:1 on the game's UI scale), centred on
-- the window's plain ground, the band only as tall as it. opts:
--   picker  { choices, get, set }: a centred dropdown over the element (a
--           tab that sets several elements: the one shown)
--   play    fn: a small Play button hanging right of the element, its foot
--           on the element's (under its right end on a band too narrow)
--   watch   setting path prefixes ("toasts.", "nav."): a change repaints the
--           band at once while it shows, on its next show else; a theme
--           change too
-- The page sets f:Content(width) -> w, h, place(left, top, k), labels: its
-- element's natural size (band units at k = 1), what puts it there at scale
-- k (every part alike), and its states' labels ({ { fontString, centreX },
-- ... } at k = 1, or nil). Nothing to show (its module is not loaded): nil.
-- An element wider than the band (less BAND_SIDE a side) or taller than the
-- room the window gives it is placed at the k that fits, never over 1, and
-- the one hint line says so; else that line is the hotspots' one-time hint
-- while it stands, else there is none. f:Label(text): a state's label.
-- f:Layout(width, room) -> its height.
function P.Band(parent, opts)
	opts = opts or {}
	local f = CreateFrame("Frame", nil, parent)
	bands[f] = true
	f.Ground = W.Fill(f, "bg", "BACKGROUND", -8)
	if opts.picker then
		f.psPick = opts.picker
		f.Picker = newPicker(f)
	end
	f.Hint = W.Text(f, "label", "textMuted")
	f.Hint:SetJustifyH("CENTER")
	f.Hint:Hide()
	if opts.play then
		f.Play = W.Button(f, L["Play"], opts.play, { height = PLAY_H })
		f.Play:SetWidth(math.ceil(W.TextWidth(f.Play.Label)) + 32)
		f.Play:SetFrameLevel(f:GetFrameLevel() + 30)
	end
	f.psWatch = opts.watch
	function f:Hot(region, key) return P.Hot(self, region, key) end
	function f:Light(key, ...) return P.Light(self, key, ...) end
	function f:LightEdge(key, ...) return P.LightEdge(self, key, ...) end
	function f:LightRing(key, ...) return P.LightRing(self, key, ...) end
	function f:LightEach(key, fn, ring) return P.LightEach(self, key, fn, ring) end
	function f:TrueScale() return P.TrueScale(self) end
	function f:Label(text)
		local fs = W.Text(self, "label", "textMuted")
		fs:SetJustifyH("CENTER")
		fs:SetText(text)
		return fs
	end
	f:SetScript("OnShow", function(self)
		if self.psDirty and self.psWidth then self:Layout(self.psWidth, self.psRoom) end
	end)
	W.Painter(f.Ground, function()
		if f:IsVisible() and f.psWidth then f:Layout(f.psWidth, f.psRoom) else f.psDirty = true end
	end)

	function f:Layout(width, room)
		self.psDirty = nil
		self:SetWidth(width)
		self.psWidth, self.psRoom = width, room
		local pick, play = rawget(self, "Picker"), rawget(self, "Play")
		if pick then pick.Label:SetText(pickerLabel(self)) end
		local w, h, place, labels
		if type(self.Content) == "function" then
			local ok, a, b, c, d = pcall(self.Content, self, width)
			if ok then w, h, place, labels = a, b, c, d else report(a) end
		end
		local y = BAND_PAD
		if pick then
			pick:ClearAllPoints()
			pick:SetPoint("TOP", self, "TOPLEFT", P.Snap(self, width / 2), -y)
			y = y + PICKER_H + PICKER_GAP
		end
		local hint
		if not (w and h and place) then
			-- Its module is not loaded: the band says so.
			if play then play:Hide() end
			hint = L["Not loaded"]
		else
			-- The scale that fits: the band's width less its sides, the room
			-- the window gives it less the parts over and under the element
			-- (the hint line too, as it then says so).
			local below = (labels and (LINE_GAP + LINE_H) or 0) + BAND_PAD
			local k = min(1, (width - 2 * BAND_SIDE) / max(1, w))
			if room then k = min(k, (room - y - below) / max(1, h)) end
			if k < 0.995 and room then k = min(k, (room - y - below - LINE_GAP - LINE_H) / max(1, h)) end
			k = max(0.05, k)
			if k >= 0.995 then k = 1 end
			self.psFit = k
			local left = floor((width - w * k) / 2 + 0.5)
			place(left, y, k)
			local foot = y + h * k
			if play then
				-- Right of the element, its foot on the element's; on a band
				-- too narrow, under the element's right end.
				play:Show()
				play:ClearAllPoints()
				local pw = play:GetWidth()
				if left + w * k + PLAY_GAP + pw <= width - 16 then
					play:SetPoint("BOTTOMLEFT", self, "TOPLEFT", P.Snap(self, left + w * k + PLAY_GAP), -P.Snap(self, foot))
				else
					play:SetPoint("TOPRIGHT", self, "TOPLEFT", P.Snap(self, left + w * k), -P.Snap(self, foot + 8))
					foot = foot + 8 + PLAY_H
				end
			end
			y = foot
			if labels then
				for _, l in ipairs(labels) do
					l[1]:ClearAllPoints()
					l[1]:SetPoint("TOP", self, "TOPLEFT", P.Snap(self, left + l[2] * k), -P.Snap(self, y + LINE_GAP))
				end
				y = y + LINE_GAP + LINE_H
			end
			if k < 1 then
				hint = string.format(L["Shown at %d%% to fit"], floor(k * 100 + 0.5))
			else
				local host = hostOf(self)
				if host and (host.psHotspots or 0) > 0 and not hintDismissed() then hint = L["Click a part of the preview to find its settings."] end
			end
		end
		self.Hint:SetShown(hint ~= nil)
		if hint then
			self.Hint:SetText(hint)
			self.Hint:ClearAllPoints()
			self.Hint:SetPoint("TOP", self, "TOPLEFT", P.Snap(self, width / 2), -P.Snap(self, y + LINE_GAP))
			y = y + LINE_GAP + LINE_H
		end
		y = y + BAND_PAD
		self.psHeight = y
		self:SetHeight(y)
		return y
	end
	return f
end

-- Whether frame f is a band (P.Band made it).
function P.IsBand(f) return f ~= nil and bands[f] == true end

-- The settings a band repaints on (its opts.watch), and the hotspots' hint
-- going for good (a band's hint line with it).
ns.On("SETTING_CHANGED", function(path)
	for f in pairs(bands) do
		local watch = f.psWatch
		if watch and prefixMatch(watch, path) then
			if f:IsVisible() and f.psWidth then f:Layout(f.psWidth, f.psRoom) else f.psDirty = true end
		end
	end
end)
function P.HintGone()
	for f in pairs(bands) do bandAgain(f) end
end

---------------------------------------------------------------------------
-- The map hero (Map pins; Route lines may use it too)
---------------------------------------------------------------------------

-- One small scene on a real world map and a real minimap, side by side in a
-- band, each at its real size: the world map a 1:1 crop of the zone's own
-- map tiles (UI.ZoneArt: never upscaled; the client's art, none shipped), a
-- hairline round it and a soft inner shade so the marks come forward; the
-- minimap the game's own: its ring over the client's minimap tiles (by file
-- id, as ZoneArt ships only file ids) under a round mask, the player's arrow
-- in the middle. The scene: Elwynn Forest (uiMap 1429) in its map's pixels
-- (1002 x 668), the player on the road east of Goldshire.
local HERO_ZONE, HERO_MAP_W, HERO_MAP_H = 1429, 1002, 668
-- Elwynn's map frame in world yards (data/forever/map-frames.json).
local Z_LEFT, Z_RIGHT, Z_TOP, Z_BOTTOM = 1535.417, -1935.417, -7939.583, -10254.166
local HERO_SCENE = {
	crop = { 382, 377, 488, 186 }, -- whole map labels only: Goldshire at the left, Eastvale Logging Camp at the right
	player = { 530, 469 }, ahead = { 548, 471 },
	walk = { { 512, 468 }, { 548, 471 }, { 560, 492 }, { 565, 503 } },
	target = { 565, 503 }, area = 56,
	steps = { { 600, 466 }, { 656, 446 }, { 672, 500 } },
	card = { 605, 480 }, -- the preset cards' view, centred here
}
P.HERO_SCENE = HERO_SCENE
-- The minimap: 140 px, 466.67 yd across at its widest zoom (the default),
-- so a 533.33 yd tile is 160 px; Azeroth's tiles around the player (its WDT,
-- builds 70374 and 70425), placed from the player's grid point.
local MM, MM_YARDS, MM_BLOCK, MAP_GAP, SHADE = 140, 466.6667, 150, 48, 26
local MM_TILE, MM_GRID = 160, { 32.563, 49.934 }
local MM_TILES = { { 32, 49, 204494 }, { 32, 50, 204495 }, { 33, 49, 204534 }, { 33, 50, 204535 } }
local RING, RING_CX, RING_CY, RING_TOP = "Interface\\Minimap\\UI-Minimap-Border", 168.5, 106.5, 30
local MASK = "Interface\\CharacterFrame\\TempPortraitAlphaMask"
P.MM, P.MM_YARDS = MM, MM_YARDS

-- (mx, my) on the zone's map -> its world yards (x north, y west).
function P.HeroWorld(mx, my)
	return Z_TOP + my / HERO_MAP_H * (Z_BOTTOM - Z_TOP), Z_LEFT + mx / HERO_MAP_W * (Z_RIGHT - Z_LEFT)
end

-- A soft shade inside frame's four edges, `reach` px in, so marks near an
-- edge read. -> its frame
function P.InnerShade(frame, reach, strength)
	local over = CreateFrame("Frame", nil, frame)
	over:SetAllPoints(frame)
	local sides = {}
	for _, s in ipairs({ { "TOPLEFT", "TOPRIGHT", "h" }, { "BOTTOMLEFT", "BOTTOMRIGHT", "h" }, { "TOPLEFT", "BOTTOMLEFT", "w" }, { "TOPRIGHT", "BOTTOMRIGHT", "w" } }) do
		local t = over:CreateTexture(nil, "ARTWORK")
		t:SetTexture(Theme.Media("white"))
		t:SetPoint(s[1], over, s[1], 0, 0)
		t:SetPoint(s[2], over, s[2], 0, 0)
		if s[3] == "h" then t:SetHeight(reach) else t:SetWidth(reach) end
		sides[#sides + 1] = t
	end
	W.Painter(over, function()
		local r, g, b = Theme.Color("scrim")
		gradient(sides[1], "VERTICAL", r, g, b, 0, strength)
		gradient(sides[2], "VERTICAL", r, g, b, strength, 0)
		gradient(sides[3], "HORIZONTAL", r, g, b, strength, 0)
		gradient(sides[4], "HORIZONTAL", r, g, b, 0, strength)
	end)
	return over
end

-- A painting of the scene's zone, w x h at its tiles' own size (1:1),
-- centred on (cx, cy) of the zone's map, into parent; nil without ZoneArt.
-- ground: the token under it where the client has no art.
function P.SharpArt(parent, w, h, cx, cy, ground)
	local ZA = UI.ZoneArt
	if not (ZA and ZA.Create) then return nil end
	local art = ZA.Create(parent, w, h, ground or "scrim")
	art:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, 0)
	for _, k in ipairs({ "Fade", "Top", "Rule" }) do
		local r = rawget(art, k)
		if r then r:Hide() end
	end
	art.psZoom = 1 / max(w / HERO_MAP_W, h / HERO_MAP_H)
	art.psDesat, art.psFocusY, art.psW, art.psH = 0.1, h / 2, w, h
	local ok, err = pcall(ZA.Paint, art, HERO_ZONE, cx / HERO_MAP_W * 100, cy / HERO_MAP_H * 100, 1)
	if not ok then report(err) end
	return art
end

-- The hero on band f: h.box (the two, laid out at scale k by h.Place),
-- h.Map (the world map, crop-sized) with h.World (a route canvas, when
-- RouteLines is loaded) and h.Layer (the marks) over its art; h.Minimap (MM
-- across) with h.MmCanvas and h.MmLayer; h.Me, h.MmArrow (the player's
-- arrows). -> h; h.Size() -> w, h, labels (k = 1); h.Place(left, top, k).
function P.MapHero(f)
	local h = {}
	local cx0, cy0, cw, ch = unpack(HERO_SCENE.crop)
	local box = CreateFrame("Frame", nil, f)
	box:SetSize(cw + MAP_GAP + MM_BLOCK, ch)
	h.box = box
	-- The world map.
	local map = CreateFrame("Frame", nil, box)
	map:SetSize(cw, ch)
	map:SetPoint("TOPLEFT", box, "TOPLEFT", 0, 0)
	if map.SetClipsChildren then map:SetClipsChildren(true) end
	h.Art = P.SharpArt(map, cw, ch, cx0 + cw / 2, cy0 + ch / 2)
	if not h.Art then W.Fill(map, "panel", "BACKGROUND", -6) end
	local base = h.Art and h.Art.Over and h.Art.Over:GetFrameLevel() or map:GetFrameLevel() + 3
	P.InnerShade(map, SHADE, 0.6):SetFrameLevel(base + 1)
	local R = ns.RouteLines
	if R and R.NewCanvas then
		h.World = R.NewCanvas(CreateFrame("Frame", nil, map))
		h.World:SetAllPoints(map)
		h.World:SetFrameLevel(base + 2)
	end
	h.Layer = CreateFrame("Frame", nil, map)
	h.Layer:SetAllPoints(map)
	h.Layer:SetFrameLevel(base + 4)
	h.Me = h.Layer:CreateTexture(nil, "OVERLAY")
	h.Me:SetTexture("Interface\\WorldMap\\WorldMapArrow")
	local edge = CreateFrame("Frame", nil, map)
	edge:SetAllPoints(map)
	edge:SetFrameLevel(base + 8)
	W.Painter(edge, function(self)
		local r, g, b, a = Theme.Wash("border")
		Theme.Border(self, r, g, b, min(1, (a or 0.1) * 1.8))
	end)
	h.Map = map
	-- The minimap.
	local mm = CreateFrame("Frame", nil, box)
	mm:SetSize(MM, MM)
	mm:SetPoint("CENTER", box, "TOPLEFT", cw + MAP_GAP + MM_BLOCK / 2, -ch / 2)
	if mm.CreateMaskTexture then
		local mask = mm:CreateMaskTexture()
		mask:SetTexture(MASK, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE")
		mask:SetAllPoints(mm)
		h.Tiles = {}
		for i, t in ipairs(MM_TILES) do
			local tex = mm:CreateTexture(nil, "BACKGROUND")
			tex:SetTexture(t[3])
			tex:SetSize(MM_TILE, MM_TILE)
			tex:SetPoint("TOPLEFT", mm, "CENTER", (t[1] - MM_GRID[1]) * MM_TILE, -(t[2] - MM_GRID[2]) * MM_TILE)
			tex:AddMaskTexture(mask)
			h.Tiles[i] = tex
		end
		h.Mask = mask
	end
	h.MmArrow = mm:CreateTexture(nil, "ARTWORK")
	h.MmArrow:SetTexture("Interface\\Minimap\\MinimapArrow")
	h.MmArrow:SetSize(32, 32)
	h.MmArrow:SetPoint("CENTER", mm, "CENTER", 0, 0)
	if R and R.NewCanvas then
		h.MmCanvas = R.NewCanvas(CreateFrame("Frame", nil, mm))
		h.MmCanvas:SetAllPoints(mm)
		h.MmCanvas:SetFrameLevel(mm:GetFrameLevel() + 2)
	end
	h.MmLayer = CreateFrame("Frame", nil, mm)
	h.MmLayer:SetAllPoints(mm)
	h.MmLayer:SetFrameLevel(mm:GetFrameLevel() + 4)
	local ringFrame = CreateFrame("Frame", nil, mm)
	ringFrame:SetFrameLevel(mm:GetFrameLevel() + 8)
	ringFrame:SetAllPoints(mm)
	-- The game's ring, its zone-name bar (the texture's top) left out.
	h.Ring = ringFrame:CreateTexture(nil, "OVERLAY")
	h.Ring:SetTexture(RING)
	h.Ring:SetTexCoord(0, 1, RING_TOP / 256, 1)
	h.Ring:SetSize(256, 256 - RING_TOP)
	h.Ring:SetPoint("TOPLEFT", mm, "CENTER", -RING_CX, RING_CY - RING_TOP)
	h.Minimap = mm
	local labels = { f:Label(L["World map"]), f:Label(L["Minimap"]) }
	local facing = math.atan2(-(HERO_SCENE.ahead[1] - HERO_SCENE.player[1]), -(HERO_SCENE.ahead[2] - HERO_SCENE.player[2]))
	h.Facing = facing
	function h.Size()
		local t = f:TrueScale()
		h.Me:SetSize(32 * t, 32 * t)
		h.Me:ClearAllPoints()
		h.Me:SetPoint("CENTER", h.Layer, "TOPLEFT", HERO_SCENE.player[1] - cx0, -(HERO_SCENE.player[2] - cy0))
		if h.Me.SetRotation then h.Me:SetRotation(facing) end
		if h.MmArrow.SetRotation then h.MmArrow:SetRotation(facing) end
		return cw + MAP_GAP + MM_BLOCK, ch, { { labels[1], cw / 2 }, { labels[2], cw + MAP_GAP + MM_BLOCK / 2 } }
	end
	function h.Place(left, top, k)
		box:SetScale(k)
		box:ClearAllPoints()
		box:SetPoint("TOPLEFT", f, "TOPLEFT", P.Snap(f, left) / k, -P.Snap(f, top) / k)
	end
	return h
end

---------------------------------------------------------------------------
-- The pinned preview
---------------------------------------------------------------------------

local function backdropText()
	return BACKDROP_LABEL[picked() or "world"] or ""
end

local function paintChip(host)
	host.Backdrop.Label:SetText(backdropText())
	host.Backdrop:SetWidth(math.ceil(W.TextWidth(host.Backdrop.Label)) + 12 + 14)
end

-- The tab's host in the shell's slot, its preview built in it, and the
-- chrome over it. -> host (host.Frame: the preview, nil when it failed)
local function hostFor(win, view, t)
	local host = rawget(view, "PreviewHost")
	if host then return host end
	host = CreateFrame("Frame", nil, W.ShellPreviewSlot(win))
	if host.SetClipsChildren then host:SetClipsChildren(true) end
	host.psIsHost = true
	host.Hotspot = function(self, region, key) return P.Hotspot(self, region, key) end
	view.PreviewHost = host
	hosts[host] = true
	local ok, f = pcall(t.preview, host)
	if not ok then
		report(f)
		f = nil
	end
	host.Frame = f
	if f then
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", host, "TOPLEFT", 0, 0)
		-- A frame's own Hotspot method (a stub's frame answers every name).
		if rawget(f, "Hotspot") == nil then f.Hotspot = function(self, region, key) return P.Hotspot(self, region, key) end end
	end
	-- The chrome, over a stage (a band has none: it is only its element).
	local chrome = CreateFrame("Frame", nil, host)
	chrome:SetAllPoints(host)
	chrome:SetFrameLevel(host:GetFrameLevel() + 30)
	host.Chrome = chrome
	host.Label = W.Text(chrome, "caption", "text")
	host.Label:SetText(L["Preview"])
	host.Label:SetPoint("TOPLEFT", chrome, "TOPLEFT", 16, -12)
	host.Caption = W.Text(chrome, "small", "textDim")
	host.Caption:SetPoint("LEFT", host.Label, "RIGHT", 8, 0)
	-- The backdrop's chip: the ground every preview draws on, a click the next one.
	local chip = CreateFrame("Button", nil, chrome)
	chip:SetHeight(18)
	chip:SetPoint("TOPRIGHT", chrome, "TOPRIGHT", -12, -9)
	W.Fill(chip, "panel", "BACKGROUND", -6)
	W.Painter(chip, function(self) Theme.Border(self, Theme.Wash("border")) end)
	chip.Icon = W.Tex(chip, "ARTWORK", "layers", "textDim")
	chip.Icon:SetSize(10, 10)
	chip.Icon:SetPoint("LEFT", chip, "LEFT", 6, 0)
	chip.Label = W.Text(chip, "small", "textDim")
	chip.Label:SetPoint("LEFT", chip.Icon, "RIGHT", 4, 0)
	chip:SetScript("OnClick", function(self)
		P.NextBackdrop()
		for h in pairs(hosts) do paintChip(h) end
		self:GetScript("OnEnter")(self)
	end)
	chip:SetScript("OnEnter", function(self)
		W.Tooltip(self, "ANCHOR_TOP", L["Backdrop"], { string.format(L["Previews are drawn over %s. Click for the next backdrop."], backdropText()) })
	end)
	chip:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	host.Backdrop = chip
	paintChip(host)
	host.Live = W.Text(chrome, "small", "textMuted")
	host.Live:SetText(L["Live"])
	host.Live:SetPoint("RIGHT", chip, "LEFT", -12, 0)
	local dot = W.Tex(chrome, "ARTWORK", "circle", "success")
	dot:SetSize(6, 6)
	dot:SetPoint("RIGHT", host.Live, "LEFT", -6, 0)
	-- The hotspots' one-time hint: a foot row of its own under the preview,
	-- on the band's ground, clear of the preview's content.
	host.Foot = W.Tex(chrome, "BACKGROUND", nil, "bg")
	host.Foot:SetPoint("BOTTOMLEFT", chrome, "BOTTOMLEFT", 0, 0)
	host.Foot:SetPoint("BOTTOMRIGHT", chrome, "BOTTOMRIGHT", 0, 0)
	host.Foot:SetHeight(HINT_FOOT)
	host.Hint = W.Text(chrome, "small", "textMuted")
	host.Hint:SetText(L["Click a part of the preview to find its settings."])
	host.Hint:SetPoint("LEFT", host.Foot, "LEFT", 16, 0)
	host.Hint:Hide()
	host.Foot:Hide()
	host:Hide()
	return host
end
P.HostFor = hostFor

-- Lay tab t's preview out across the main column (width) and pin it. A
-- stage stands on its hero: at least HERO of the window's height, at most
-- MAX of the body's (`room`); its page lays its scene out for the hero's
-- height (f:Layout(width, height)) and a smaller scene is centred on it.
-- Past MAX the scene is shown whole at the scale that fits.
function P.Place(win, view, t, width, room)
	if not (t and t.preview) or view.empty then
		W.ShellPreview(win, nil)
		return
	end
	local host = hostFor(win, view, t)
	local f = host.Frame
	if not f then
		W.ShellPreview(win, nil)
		return
	end
	local stage = stages[f] or false
	if bands[f] then
		-- A band: as tall as its element and its parts, the element fitted
		-- to the room the window gives it; no chrome, its hint its own line.
		host.Chrome:Hide()
		f:SetScale(1)
		local ok, h = pcall(f.Layout, f, width, max(1, floor(room * MAX)))
		if not ok then
			report(h)
			h = 0
		end
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", host, "TOPLEFT", 0, 0)
		f:Show()
		W.ShellPreview(win, host, P.Snap(host, tonumber(h) or 0))
		return
	end
	host.Chrome:Show()
	local maxH = max(1, floor(room * MAX))
	local heroH = stage and min(maxH, floor((win:GetHeight() or room) * HERO + 0.5)) or nil
	local function layout(w, hh)
		-- A stage's width is known before its page lays the scene out (P.Fit).
		if stage then f.psWidth = w end
		local ok, h = pcall(f.Layout, f, w, hh)
		if not ok then
			report(h)
			h = 0
		end
		return tonumber(h) or 0
	end
	f:SetScale(1)
	local h = layout(width, heroH)
	local scale = 1
	if h > maxH then
		-- Whole, smaller: laid out again for the width that scale gives, so
		-- its parts keep their own proportions.
		scale = maxH / h
		h = layout(width / scale, heroH and heroH / scale)
		scale = min(scale, maxH / max(1, h))
	end
	f:SetScale(scale)
	f:SetWidth(width / scale)
	f:Show()
	local shown = h * scale
	local slotH = shown
	if stage then
		-- The hero across the slot, the scene (the stage as tall as its page
		-- laid it out) centred on it, the backdrop painted at the hero's size.
		f:SetHeight(max(1, h))
		slotH = max(shown, heroH)
		local H = f.Hero
		H:ClearAllPoints()
		H:SetPoint("TOPLEFT", host, "TOPLEFT", 0, 0)
		H:SetSize(width, slotH)
		H:Show()
		f.psHeroW, f.psHeroH = width, slotH
		paintBackdrop(f)
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", host, "TOPLEFT", 0, -P.Snap(host, (slotH - shown) / 2) / scale)
	end
	paintChip(host)
	-- A stage whose scene is a painting of its own (the map pins', the route
	-- lines') keeps its ground: no backdrop to pick there, so no chip.
	local fixed = stage and f.psFixed or false
	host.Backdrop:SetShown(not fixed)
	host.Live:ClearAllPoints()
	if fixed then
		host.Live:SetPoint("RIGHT", host.Backdrop:GetParent(), "TOPRIGHT", -12, -18)
	else
		host.Live:SetPoint("RIGHT", host.Backdrop, "LEFT", -12, 0)
	end
	local cap = f.caption
	if type(cap) == "function" then cap = cap() end
	if scale < 0.995 then
		local shrunk = string.format(L["Shown at %d%% to fit"], floor(scale * 100 + 0.5))
		cap = (cap and cap ~= "") and (cap .. "  \194\183  " .. shrunk) or shrunk
	end
	host.Caption:SetText(cap or "")
	local hint = (host.psHotspots or 0) > 0 and not hintDismissed()
	host.Hint:SetShown(hint)
	host.Foot:SetShown(hint)
	W.ShellPreview(win, host, P.Snap(host, slotH) + (hint and HINT_FOOT or 0))
end

-- The pointer on a row (key), or off it (nil): the preview on screen lights
-- the parts that setting changes (its hotspots and lights, P.LightUp) and
-- may show the part it draws (its frame's optional f:Focus(key)).
function P.Focus(view, key)
	local host = view and rawget(view, "PreviewHost")
	if not host then return end
	P.LightUp(host, host:IsShown() and key or nil)
	local f = host:IsShown() and host.Frame
	if not (key and f and type(f.Focus) == "function") then return end
	local ok, err = pcall(f.Focus, f, key)
	if not ok then report(err) end
end
