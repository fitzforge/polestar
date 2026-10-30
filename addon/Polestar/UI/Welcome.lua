-- The welcome: a Polestar window, 600 wide and centred, that greets a
-- character Polestar has not seen before. Each page opens under its own hero
-- (the night sky: a gradient, the faint haze, the starlit band); the page
-- below on the 32 edge; a footer with Skip (Back on the last page) on the
-- left, the step dots in the middle (not buttons) and Back and Next on the
-- right. The gold rim (W.Rim) runs along the window's top.
--   1. welcome: a 208px hero with the start zone's painting engraved faintly
--      into the night, the Little Dipper leading to the emblem in its glow
--      and beam, the wordmark and tagline centred under it; Hello, <name>,
--      one line on what Polestar does, then three cards, each a miniature
--      of the real thing: a goal row of the suggested guide with its accent
--      bar and progress line (the guide window), the gold dart with the
--      guide's first walk (the arrow), the library's Leveling, Professions
--      and Reputation rows with their counts (every guide);
--   2. setup: quest automation (behavior.autoAccept and autoTurnin as one
--      switch) and the guide at login (behavior.autoSelectGuide), each with
--      its description inline, and the colour scheme (ui.scheme) as preview
--      cards in each scheme's own colours, that apply live; Skip keeps them;
--   3. route: the start zone's painting with the suggested guide's first
--      walk drawn on it and its place named, then the route style
--      (nav.routeStyle, the setting Options' Route style dropdown writes) as
--      three rows, Fastest, Balanced (Recommended) and Roads, each saying
--      what it does, that apply live; a line on what every style keeps you
--      away from. Shown with setup;
--   4. start: the suggested guide on its painting (its level range, who it
--      is for), its pitch; what Start guide does; the beta note while
--      ns.routesBeta is true; the Discord community (its invite as a link
--      to the copy window); community guides (Browse guides opens the guide
--      menu). Start guide (Choose a guide without one).
--
-- Per character: PolestarCharDB.welcomeSeen, the welcome's version (SEEN).
-- A new character (ns.IsNewCharacter: no saved PolestarCharDB when Polestar
-- loaded) gets 0, so the welcome is due; a character with saved data and no
-- flag gets SEEN without seeing it, so nobody who already plays gets it
-- unasked. At login it opens while the character's flag is below SEEN, and
-- opening it sets the flag, so a /reload or a logout with it still up does
-- not bring it back; a due welcome that never opened (a logout in combat or
-- under the route choice) stays due for the next login.
--
-- Per account: PolestarDB.welcomeSeen, the account has had its welcome. Its
-- settings are account-wide, so setup and the route style are in a welcome
-- shown at login only while the account's flag is below SEEN; a later
-- character skips them. The page set is fixed when a showing starts. Any
-- close (Skip, Start guide, Browse guides, the ✕, Escape) sets both flags.
-- The beta notice's old flag (betaNoticeSeen) is dropped.
--
-- It opens a moment after login, never in combat (it waits for the fight to
-- end), never during a cinematic, and never over the route choice: while that
-- window is up the welcome waits for it to close, and if a route choice opens
-- over the welcome it steps aside until it is done, then comes back on the
-- page it left. A new character's first login plays the intro cinematic,
-- whose start closes every special window (CloseAllWindows) and hides the UI:
-- a welcome closed that way is not marked seen and comes back on the page it
-- left once the cinematic stops. About's "Show the welcome again" and
-- /polestar welcome (SHOW_WELCOME) open it with every page.
--
-- The window takes the height of its tallest page, laid out in the current
-- language and font, so it never jumps. Motion: the window fades in and the
-- hero settles 8px up as it fades in (180ms); a page change fades the old
-- page out (120ms) and the new one in, rising 6px (180ms). Reduced motion
-- (Anim) snaps the movement. The night's extras (gradient, haze, engraving,
-- beam) are the house style's; the other skins keep the band. Built on
-- first use; colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, sqrt, cos, sin, rad = math.floor, math.max, math.min, math.sqrt, math.cos, math.sin, math.rad
local atan2 = math.atan2 or math.atan

local WEL = {}
UI.Welcome = WEL

local SEEN = 1 -- the welcome's version; a later welcome raises it
local WIDTH = 600
local PAD = 32
local CW = WIDTH - PAD * 2 -- the page's width
local INNER = WIDTH - 2 -- inside the window's 1px edge
local EDGE = PAD - 1 -- the 32 edge, in hero coordinates
local HELLO_H = 208 -- the first page's hero
local START_H = 184 -- the last page's hero
local BAND_H = 128 -- the band at 1:1
local BAND_SHIFT = 180 / 1024 -- the stretch of the band the welcome shows
local BOTTOM = 24 -- under a page's last line
local FOOT_H = 56
local FOOT_PAD = 24
local DELAY = 2 -- seconds after login, so the world and the other windows settle first
local OUT = 0.11 -- a page leaving fades this long

local F -- the window
local current = "welcome" -- the page shown (its key)
local pending -- nil | "login" (due at login) | "asked" (opened on request, or coming back), waiting for combat or the route choice
local stepping -- hidden to make way for the route choice, not closed
local full = true -- this showing has every page (false: setup left out); fixed when it starts
local unasked = false -- this showing came by itself (open's deferred): a gamepad waits to be asked
local hookedRC

local function inCombat()
	return InCombatLockdown and InCombatLockdown() or false
end

-- The intro cinematic or a cinematic scene is playing.
local function inCinematic()
	return (InCinematic and InCinematic()) or (IsInCinematicScene and IsInCinematicScene()) or false
end

-- This character has had its welcome.
local function seen()
	return (tonumber(ns.CharState().welcomeSeen) or 0) >= SEEN
end

-- This account has had its welcome.
local function accountSeen()
	return (tonumber(ns.DB().welcomeSeen) or 0) >= SEEN
end

local function routeChoiceUp()
	local RC = UI.RouteChoice
	return RC and RC.IsShown and RC.IsShown() or false
end

-- The house style draws the night's extras; the other skins keep the band.
local function house()
	return Theme.SkinKey() == "polestar"
end

local function colored(name, text)
	return "|c" .. Theme.Hex(name) .. text .. "|r"
end

local function cmd(text)
	return colored("text", text)
end

local function known(s)
	return type(s) == "string" and s ~= "" and s or nil
end

-- A wrapped block of text, `width` wide.
local function para(parent, role, color, width, spacing)
	local fs = W.Text(parent, role, color)
	fs:SetWidth(width)
	fs:SetWordWrap(true)
	fs:SetSpacing(spacing or 3)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	return fs
end

local function place(region, x, y)
	region:ClearAllPoints()
	region:SetPoint("TOPLEFT", region:GetParent(), "TOPLEFT", x, -y)
end

local function solid(parent, layer, sub)
	local t = parent:CreateTexture(nil, layer or "BACKGROUND", nil, sub or 0)
	t:SetTexture(Theme.Media("white"))
	return t
end

-- A vertical gradient, top colour then bottom colour.
local function vgrad(t, r1, g1, b1, a1, r2, g2, b2, a2)
	if t.SetGradient and CreateColor then
		t:SetVertexColor(1, 1, 1, 1)
		t:SetGradient("VERTICAL", CreateColor(r2, g2, b2, a2), CreateColor(r1, g1, b1, a1))
	else
		t:SetVertexColor(r1, g1, b1, (a1 + a2) / 2)
	end
end

-- A horizontal gradient, left colour then right colour.
local function hgrad(t, r1, g1, b1, a1, r2, g2, b2, a2)
	if W.Gradient then return W.Gradient(t, r1, g1, b1, a1, r2, g2, b2, a2) end
	if t.SetGradient and CreateColor then
		t:SetVertexColor(1, 1, 1, 1)
		t:SetGradient("HORIZONTAL", CreateColor(r1, g1, b1, a1), CreateColor(r2, g2, b2, a2))
	else
		t:SetVertexColor(r2, g2, b2, (a1 + a2) / 2)
	end
end

local function accentHi()
	if W.AccentHi then return W.AccentHi() end
	return Theme.Accent()
end

-- A frame's 1px outline in a wash (or the accent while `on`).
local function outline(c)
	c.psEdge = {}
	for i, pts in ipairs({ { "TOPLEFT", "TOPRIGHT" }, { "BOTTOMLEFT", "BOTTOMRIGHT" }, { "TOPLEFT", "BOTTOMLEFT" }, { "TOPRIGHT", "BOTTOMRIGHT" } }) do
		local e = solid(c, "BORDER", 2)
		e:SetPoint(pts[1], c, pts[1], 0, 0)
		e:SetPoint(pts[2], c, pts[2], 0, 0)
		c.psEdge[i] = e
	end
end

local function paintOutline(c, r, g, b, a)
	local px = Theme.Pixel(c)
	for i = 1, 4 do
		local e = c.psEdge[i]
		if i <= 2 then e:SetHeight(px) else e:SetWidth(px) end
		e:SetVertexColor(r, g, b, a)
	end
end

-- A line from (ax, ay) to (bx, by) in `parent`'s top-left coordinates.
local function segment(t, parent, ax, ay, bx, by, thick)
	local dx, dy = bx - ax, by - ay
	t:SetTexCoord(0, 1, 0, 1) -- drawn as an image, so it turns
	t:SetSize(max(1, sqrt(dx * dx + dy * dy)), thick)
	t:ClearAllPoints()
	t:SetPoint("CENTER", parent, "TOPLEFT", (ax + bx) / 2, -(ay + by) / 2)
	t:SetRotation(-atan2(dy, dx))
end

-- A footer button's chevron after its label (Next, Start guide).
local function chevron(b)
	local c = b:CreateTexture(nil, "ARTWORK")
	c:SetTexture(Theme.Media("chevron-right"))
	c:SetSize(11, 11)
	b.psChevron = c
	W.Painter(c, function(t)
		if b.Label.GetTextColor then t:SetVertexColor(b.Label:GetTextColor()) end
	end)
end

local function setChevronText(b, text)
	W.SetButtonText(b, text)
	b:SetWidth(b:GetWidth() + 16)
	b.psLabelX = -8
	b.Label:SetPoint("CENTER", b, "CENTER", -8, 0)
	b.psChevron:ClearAllPoints()
	b.psChevron:SetPoint("LEFT", b.Label, "RIGHT", 5, 0)
	if b.Label.GetTextColor then b.psChevron:SetVertexColor(b.Label:GetTextColor()) end
end

local function close()
	if F then F:Hide() end
end

---------------------------------------------------------------------------
-- The night: gradient, haze, band; the emblem; the Little Dipper
---------------------------------------------------------------------------

-- The night ground of a hero `height` tall: the gradient (house style), the
-- haze and the starlit band. opts: { haze = alpha, band = alpha, bottom =
-- the palette colour the gradient ends in }. Textures on `h` (under every
-- child frame) and on `sky` (above the painting, if any).
local function night(h, sky, height, opts)
	local n = {}
	n.Ground = solid(h, "BACKGROUND", -8)
	n.Ground:SetAllPoints(h)
	n.Band = Theme.Band(sky, "BACKGROUND", -5)
	n.Band:SetPoint("TOPLEFT", sky, "TOPLEFT", 0, 0)
	n.Band:SetPoint("TOPRIGHT", sky, "TOPRIGHT", 0, 0)
	n.Band:SetHeight(min(BAND_H, height))
	local x0, x1, y0, y1 = Theme.BandCoords(INNER, min(BAND_H, height))
	n.Band:SetTexCoord(x0 + BAND_SHIFT, x1 + BAND_SHIFT, y0, y1)
	n.Band:SetAlpha(opts.band or 0.7)
	if W.Haze then
		n.Haze = W.Haze(sky, { width = floor(INNER * 1.2), height = floor(height * 0.75), sub = -6 })
		n.Haze:SetAlpha(opts.haze or 1)
	end
	W.Painter(n.Ground, function(t)
		t:SetShown(house())
		local tr, tg, tb = Theme.Color("scrim")
		local br, bg, bb = Theme.Color(opts.bottom or "bg")
		vgrad(t, tr, tg, tb, 1, br, bg, bb, 1)
	end)
	return n
end

-- The emblem, `size` px, centred on (x, y) of `parent`, in its glow, a
-- 1px beam rising from it (house style). bloom: the glow's size.
local function emblem(parent, size, x, y, bloom, beamH)
	local e = W.Tex(parent, "ARTWORK", "emblem", "accent")
	e:SetSize(size, size)
	e:SetPoint("CENTER", parent, "TOPLEFT", x, -y)
	local glow = W.Tex(parent, "BORDER", "glow", nil, 3)
	glow:SetSize(bloom, bloom)
	glow:SetPoint("CENTER", e, "CENTER", 0, 0)
	local beam = solid(parent, "BORDER", 4)
	beam:SetSize(1, beamH)
	beam:SetPoint("BOTTOM", e, "TOP", 0, -4)
	W.Painter(glow, function(t)
		local r, g, b = Theme.Accent()
		t:SetVertexColor(r, g, b, house() and 0.3 or 0.12)
		local hr, hg, hb = accentHi()
		beam:SetShown(house())
		vgrad(beam, r, g, b, 0, hr, hg, hb, 0.7)
	end)
	return e
end

-- The Little Dipper as the mock draws it, in px from the end of its handle
-- (x right, y down): { x, y, radius }. The handle's end has no star of its
-- own (Polaris: the emblem beside it, or the sky).
local DIPPER = {
	{ 0, 0, 0 }, { 62, -24, 1.6 }, { 114, -34, 1.5 }, { 162, -27, 1.5 },
	{ 236, -52, 2.2 }, { 262, -10, 1.9 }, { 196, 13, 1.3 },
}
local LINKS = { { 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 }, { 5, 6 }, { 6, 7 }, { 7, 4 } }

-- Draws the Dipper on `parent`, its handle's end at (ox, oy), scaled and
-- turned `deg` degrees clockwise, in the neutral star colour.
local function dipper(parent, ox, oy, scale, deg)
	local a = rad(deg or 0)
	local c, s = cos(a), sin(a)
	local pts = {}
	for i, st in ipairs(DIPPER) do
		local x, y = st[1], st[2]
		pts[i] = { ox + (x * c - y * s) * scale, oy + (x * s + y * c) * scale }
		if st[3] > 0 then
			local halo = W.Tex(parent, "BORDER", "glow", nil, 1)
			halo:SetSize(st[3] * 6, st[3] * 6)
			halo:SetPoint("CENTER", parent, "TOPLEFT", pts[i][1], -pts[i][2])
			local core = W.Tex(parent, "BORDER", "circle", nil, 2)
			core:SetSize(max(2, st[3] * 2), max(2, st[3] * 2))
			core:SetPoint("CENTER", halo, "CENTER", 0, 0)
			W.Painter(halo, function(t)
				local r, g, b = Theme.Color("star")
				t:SetVertexColor(r, g, b, 0.3)
				core:SetVertexColor(r, g, b, 1)
			end)
		end
	end
	for _, link in ipairs(LINKS) do
		local p, q = pts[link[1]], pts[link[2]]
		local t = solid(parent, "BORDER", 0)
		segment(t, parent, p[1], p[2], q[1], q[2], 1)
		W.Painter(t, function(tex)
			tex:SetHeight(Theme.Pixel(parent))
			local r, g, b = Theme.Color("star")
			tex:SetVertexColor(r, g, b, 0.28)
		end)
	end
end

---------------------------------------------------------------------------
-- What the pages show of the suggested guide
---------------------------------------------------------------------------

-- The player as Polestar reads them; a field is nil when the client cannot say.
local function playerInfo()
	local C = ns.Compat
	local ok, info = pcall(C.GetPlayerInfo)
	return ok and type(info) == "table" and info or {}
end

-- The guide Polestar suggests, or nil.
local function suggested()
	local G = ns.Guides
	local id = G and G.Suggest and G.Suggest()
	local g = id and G.Get and G.Get(id)
	if g and known(g.title) then return id, g end
	return nil
end

-- A name a guide gives (its tokens filled), or nil.
local function nameOf(...)
	for i = 1, select("#", ...) do
		local s = known((select(i, ...)))
		if s and not s:find("{", 1, true) then return s end
	end
	return nil
end

-- A goal's place on the guide's zone map (live-frame percent, as the
-- Engine's GuideFocus reads it), or nil: elsewhere, or for some only.
local function zonePoint(g, goal)
	if goal.only or not (g.zone and goal.map == g.zone and goal.x and goal.y) then return nil end
	local x, y = goal.x, goal.y
	local C = ns.Compat
	if goal.f and C.MapToWorld and C.WorldToMap then
		local c, wx, wy = C.MapToWorld(goal.map, goal.x, goal.y, goal.f)
		if c then x, y = C.WorldToMap(c, wx, wy, goal.map) end
	end
	if x and y then return x, y end
	return nil
end

local WALK_MIN = 12 -- a walk is at least this far (percent of the map)
local SCAN = 40 -- steps read from the guide's start

-- The guide's first walk: the first stretch between two of its places on
-- its zone map at least WALK_MIN apart, ending at a named place.
-- -> { x0, y0, x1, y1, name } | nil (cached per guide)
local walks = setmetatable({}, { __mode = "k" })
local function firstWalk(g)
	local w = walks[g]
	if w == nil then
		w = false
		local ok, found = pcall(function()
			local lx, ly
			for si, step in ipairs(g.steps or {}) do
				if si > SCAN then break end
				if not step.only then
					for _, goal in ipairs(step.goals or {}) do
						local x, y = zonePoint(g, goal)
						if x then
							local name = goal.t == "goto" and nameOf(goal.text, goal.subject)
							if lx and name and (x - lx) ^ 2 + (y - ly) ^ 2 >= WALK_MIN ^ 2 then
								return { lx, ly, x, y, name }
							end
							lx, ly = x, y
						end
					end
				end
			end
		end)
		if ok and found then w = found end
		walks[g] = w
	end
	return w or nil
end

-- A goal of the guide to show as a goal row: a collect or a kill with a
-- count. -> kind, name, count | nil
local function sampleGoal(g)
	for si, step in ipairs(g and g.steps or {}) do
		if si > SCAN then break end
		for _, goal in ipairs(step.goals or {}) do
			if (goal.t == "collect" or goal.t == "kill") and not goal.only then
				local name = nameOf(goal.itemName, goal.target, goal.subject)
				local n = tonumber(goal.count) or (type(goal.progress) == "table" and tonumber(goal.progress.max))
				if name and n and n > 1 then return goal.t, name, n end
			end
		end
	end
	return nil
end

-- The library's guides of a category.
local function countOf(category)
	local G = ns.Guides
	local list = G and G.List and G.List() or {}
	local n = 0
	for _, h in ipairs(list) do if h.category == category then n = n + 1 end end
	return n
end

-- "Your first guide, for your level 1 Human Warrior in Elwynn Forest",
-- leaving out what is unknown.
local function forWhom(g)
	local info = playerInfo()
	local race, class = known(UI.RaceName(info.race)), known(UI.ClassName(info.class))
	local level = tonumber(info.level)
	local who
	if race or class then
		who = race and class and (race .. " " .. class) or race or class
		if level then who = (L["level %d %s"]):format(level, who) end
	elseif level then
		who = (L["level %d character"]):format(level)
	end
	local zone = known((ns.Compat.GetZoneText()))
	-- A guide named for the zone already says where.
	if zone and g.title:lower():find(zone:lower(), 1, true) then zone = nil end
	if who and zone then return (L["Your first guide, for your %s in %s"]):format(who, zone) end
	if who then return (L["Your first guide, for your %s"]):format(who) end
	if zone then return (L["Your first guide, in %s"]):format(zone) end
	return L["Your first guide"]
end

---------------------------------------------------------------------------
-- Pages: build(P) once; layout(P) -> the hero's height, the page's height,
-- on every show. P.Hero is the hero, P.Body the page under it.
---------------------------------------------------------------------------

local PAGES = {}

-- The compact hero (setup, route): the night, the emblem on the right, the
-- title and its line on the 32 edge.
local SIDE_X, SIDE_Y = INNER - 64 - 20, 64
local CHERO_TEXT_W = 440

local function compactHero(h, title, sub, withDipper)
	h.Sky = CreateFrame("Frame", nil, h)
	h.Sky:SetAllPoints(h)
	h.Night = night(h, h.Sky, 160, { haze = 0.8, band = 0.6, bottom = "bg" })
	if withDipper then dipper(h.Sky, 400, 52, 0.62, -8) end
	emblem(h.Sky, 40, SIDE_X, SIDE_Y, 120, 44)
	h.Title = para(h.Sky, "hero", "text", CHERO_TEXT_W, 2)
	h.Title:SetText(title)
	h.Sub = para(h.Sky, "body", "textDim", CHERO_TEXT_W, 3)
	h.Sub:SetText(sub)
end

local function layoutCompactHero(h)
	place(h.Title, EDGE, 40)
	local y = 40 + h.Title:GetStringHeight() + 8
	place(h.Sub, EDGE, y)
	return y + h.Sub:GetStringHeight() + 22
end

-- 1. Welcome --------------------------------------------------------------

local CARD_GAP = 16
local CARD_W = floor((CW - CARD_GAP * 2) / 3)
local MEDIA_H = 72

-- A card: the panel, a hairline, an inset night for its miniature, its
-- title and line.
local function card(p, title, desc)
	local c = CreateFrame("Frame", nil, p)
	c:SetWidth(CARD_W)
	W.Fill(c, "panel", "BACKGROUND", -6)
	outline(c)
	c.Media = CreateFrame("Frame", nil, c)
	c.Media:SetPoint("TOPLEFT", c, "TOPLEFT", 6, -6)
	c.Media:SetPoint("TOPRIGHT", c, "TOPRIGHT", -6, -6)
	c.Media:SetHeight(MEDIA_H)
	if c.Media.SetClipsChildren then c.Media:SetClipsChildren(true) end
	local m = c.Media
	m.Ground = solid(m, "BACKGROUND", -7)
	m.Ground:SetAllPoints(m)
	m.Stars = m:CreateTexture(nil, "BACKGROUND", nil, -6)
	m.Stars:SetTexture(Theme.Media("band-stars"))
	m.Stars:SetAllPoints(m)
	m.Stars:SetTexCoord(0.4, 0.4 + (CARD_W - 12) / Theme.BAND_W, 0.2, 0.2 + MEDIA_H / Theme.BAND_H)
	outline(m)
	W.Painter(c, function(self)
		paintOutline(self, Theme.Wash("divider"))
		local sr, sg, sb = Theme.Color("shade")
		paintOutline(self.Media, sr, sg, sb, 0.6)
		local r, g, b = Theme.Color("scrim")
		self.Media.Ground:SetVertexColor(r, g, b, 1)
		local tr, tg, tb = Theme.Color("star")
		self.Media.Stars:SetVertexColor(tr, tg, tb, 0.5)
	end)
	c.Title = para(c, "heading", "text", CARD_W - 24, 2)
	c.Title:SetText(title)
	c.Desc = para(c, "note", "textMuted", CARD_W - 24, 3)
	c.Desc:SetText(desc)
	return c
end

-- The guide window's miniature: a goal row with the accent bar, its count
-- and the progress line under it.
local function goalMini(m)
	local box = CreateFrame("Frame", nil, m)
	box:SetPoint("TOPLEFT", m, "TOPLEFT", 10, -14)
	box:SetPoint("TOPRIGHT", m, "TOPRIGHT", -10, -14)
	box:SetHeight(34)
	W.Fill(box, "bg", "BACKGROUND", -5)
	outline(box)
	W.Painter(box, function(self) paintOutline(self, Theme.Wash("border")) end)
	box.Bar = solid(box, "ARTWORK", 1)
	box.Bar:SetSize(2, 15)
	box.Bar:SetPoint("TOPLEFT", box, "TOPLEFT", 0, -6)
	W.Color(box.Bar, "accent")
	box.Glyph = W.Tex(box, "ARTWORK", "icon-collect", "text")
	box.Glyph:SetSize(11, 11)
	box.Glyph:SetPoint("CENTER", box, "TOPLEFT", 12 + 5.5, -13)
	box.Count = W.Text(box, "caption", "success")
	box.Count:SetPoint("RIGHT", box, "TOPRIGHT", -8, -13)
	box.Name = W.Text(box, "small", "item")
	box.Name:SetPoint("LEFT", box.Glyph, "RIGHT", 6, 0)
	box.Name:SetPoint("RIGHT", box.Count, "LEFT", -6, 0)
	box.Name:SetJustifyH("LEFT")
	box.Name:SetWordWrap(false)
	box.Line = CreateFrame("Frame", nil, box)
	box.Line:SetPoint("TOPLEFT", box, "TOPLEFT", 12, -24)
	box.Line:SetPoint("TOPRIGHT", box, "TOPRIGHT", -8, -24)
	box.Line:SetHeight(3)
	box.Line.Track = solid(box.Line, "BACKGROUND", 0)
	box.Line.Track:SetAllPoints(box.Line)
	W.Painter(box.Line.Track, function(t) t:SetVertexColor(Theme.Wash("track")) end)
	box.Line.Fill = solid(box.Line, "ARTWORK", 0)
	box.Line.Fill:SetPoint("TOPLEFT", box.Line, "TOPLEFT", 0, 0)
	box.Line.Fill:SetPoint("BOTTOMLEFT", box.Line, "BOTTOMLEFT", 0, 0)
	W.Color(box.Line.Fill, "success")
	return box
end

local function paintGoalMini(box, g)
	local kind, name, n = sampleGoal(g)
	if not kind then kind, name, n = "collect", L["Supplies"], 5 end
	local cur = max(1, floor(n * 0.6))
	box.Glyph:SetTexture(Theme.Media(kind == "kill" and "icon-kill" or "icon-collect"))
	box.Name:SetText(name)
	W.Color(box.Name, kind == "kill" and "npc" or "item")
	box.Count:SetText(cur .. "/" .. n)
	box.Line.Fill:SetWidth(max(1, (CARD_W - 12 - 20 - 20) * cur / n))
end

-- The arrow's miniature: the gold dart, a distance and where it leads.
local function arrowMini(m)
	local a = CreateFrame("Frame", nil, m)
	a:SetAllPoints(m)
	a.Dart = W.Tex(a, "ARTWORK", "dart-gold")
	a.Dart:SetSize(40, 40)
	a.Dart:SetTexCoord(0, 1, 0, 1)
	a.Dart:SetRotation(rad(30))
	a.Yd = W.Text(a, "display", "text")
	a.Yd:SetText((L["%d yd"]):format(412)) -- an illustration of the arrow's readout
	a.To = W.Text(a, "small", "textDim")
	a.To:SetWordWrap(false)
	return a
end

local function paintArrowMini(a, g)
	local walk = g and firstWalk(g)
	local to = walk and walk[5] or L["your next stop"]
	a.To:SetText(L["Go to"] .. " " .. colored("place", to))
	local room = CARD_W - 12 - 16 - 40 - 10
	local textW = min(room, max(W.TextWidth(a.Yd), W.TextWidth(a.To)))
	a.To:SetWidth(textW)
	local total = 40 + 10 + textW
	local x = floor((CARD_W - 12 - total) / 2)
	a.Dart:ClearAllPoints()
	a.Dart:SetPoint("CENTER", a, "LEFT", x + 20, 0)
	local h = a.Yd:GetStringHeight() + 3 + a.To:GetStringHeight()
	a.Yd:ClearAllPoints()
	a.Yd:SetPoint("TOPLEFT", a, "LEFT", x + 50, h / 2)
	a.To:ClearAllPoints()
	a.To:SetPoint("TOPLEFT", a.Yd, "BOTTOMLEFT", 0, -3)
end

-- The library's miniature: three rows with their counts, the first chosen.
local LIBRARY = {
	{ "Leveling", "icon-level" },
	{ "Professions", "icon-craft" },
	{ "Reputation", "icon-rep" },
}

local function libraryMini(m)
	local rows = {}
	for i, it in ipairs(LIBRARY) do
		local r = CreateFrame("Frame", nil, m)
		r:SetPoint("TOPLEFT", m, "TOPLEFT", 10, -(9 + (i - 1) * 20))
		r:SetPoint("TOPRIGHT", m, "TOPRIGHT", -10, -(9 + (i - 1) * 20))
		r:SetHeight(17)
		local sel = i == 1
		r.Fill = solid(r, "BACKGROUND", -4)
		r.Fill:SetAllPoints(r)
		W.Painter(r.Fill, function(t) t:SetVertexColor(Theme.Wash(sel and "selected" or "hover")) end)
		if sel then
			r.Bar = solid(r, "ARTWORK", 1)
			r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
			r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
			r.Bar:SetWidth(2)
			W.Color(r.Bar, "accent")
		end
		r.Glyph = W.Tex(r, "ARTWORK", it[2], sel and "accent" or "textMuted")
		r.Glyph:SetSize(11, 11)
		r.Glyph:SetPoint("LEFT", r, "LEFT", 6, 0)
		r.Count = W.Text(r, "caption", "textMuted")
		r.Count:SetPoint("RIGHT", r, "RIGHT", -6, 0)
		r.Name = W.Text(r, "small", sel and "text" or "textDim")
		r.Name:SetPoint("LEFT", r.Glyph, "RIGHT", 7, 0)
		r.Name:SetPoint("RIGHT", r.Count, "LEFT", -6, 0)
		r.Name:SetJustifyH("LEFT")
		r.Name:SetWordWrap(false)
		r.Name:SetText(L[it[1]])
		r.psCategory = it[1]
		rows[i] = r
	end
	return rows
end

PAGES[#PAGES + 1] = {
	key = "welcome",
	build = function(P)
		local h = P.Hero
		h:SetHeight(HELLO_H)
		-- The start zone's painting, engraved: no colour, multiplied into
		-- the night's blue, faint.
		h.Art = UI.ZoneArt.Create(h, INNER, HELLO_H, "bg")
		h.Art:SetPoint("TOPLEFT", h, "TOPLEFT", 0, 0)
		h.Art.psZoom = 1.2
		h.Art.psDesat = 1
		h.Art.Fade:Hide()
		h.Art.Top:Hide()
		h.Art.Rule:Hide()
		h.Sky = CreateFrame("Frame", nil, h)
		h.Sky:SetAllPoints(h)
		h.Sky:SetFrameLevel(h.Art.Over:GetFrameLevel() + 1)
		h.Night = night(h, h.Sky, HELLO_H, {})
		-- Over the painting, the night again from the top; under it all, the
		-- fade into the page's ground.
		h.Dark = solid(h.Sky, "BACKGROUND", -7)
		h.Dark:SetPoint("TOPLEFT", h.Sky, "TOPLEFT", 0, 0)
		h.Dark:SetPoint("TOPRIGHT", h.Sky, "TOPRIGHT", 0, 0)
		h.Dark:SetHeight(floor(HELLO_H * 0.55))
		h.Under = solid(h.Sky, "BORDER", -2)
		h.Under:SetPoint("BOTTOMLEFT", h.Sky, "BOTTOMLEFT", 0, 0)
		h.Under:SetPoint("BOTTOMRIGHT", h.Sky, "BOTTOMRIGHT", 0, 0)
		h.Under:SetHeight(120)
		W.Painter(h.Under, function(t)
			local r, g, b = Theme.Color("bg")
			vgrad(t, r, g, b, 0, r, g, b, 1)
			local sr, sg, sb = Theme.Color("scrim")
			vgrad(h.Dark, sr, sg, sb, 0.85, sr, sg, sb, 0)
			local kr, kg, kb = Theme.Color("sky")
			h.Art.psTint = { min(1, kr * 1.5), min(1, kg * 1.5), min(1, kb * 1.5) }
		end)
		-- The lockup: the emblem (Polaris) with the Dipper's handle leading
		-- to it, the wordmark and tagline centred under it.
		local cx = floor(INNER / 2)
		dipper(h.Sky, cx + 30, 70, 1, 0)
		emblem(h.Sky, 60, cx, 70, 170, 70)
		h.Word = W.Tex(h.Sky, "ARTWORK", "wordmark", "text")
		h.Word:SetSize(144, 18)
		h.Word:SetPoint("CENTER", h.Sky, "TOPLEFT", cx, -130)
		h.Tagline = W.Text(h.Sky, "note", "textDim")
		h.Tagline:SetWidth(CW)
		h.Tagline:SetJustifyH("CENTER")
		h.Tagline:SetText(L["Leveling guides for World of Warcraft: Forever"])
		h.Tagline:SetPoint("TOP", h.Sky, "TOPLEFT", cx, -151)

		local p = P.Body
		p.Title = para(p, "hero", "text", CW, 2)
		p.Line = para(p, "body", "textDim", CW)
		p.Line:SetText(L["Polestar guides you step by step: who to talk to, what to kill or collect, and where to go."])
		p.Cards = {
			card(p, L["The guide window"], L["Goals tick off as you play."]),
			card(p, L["The arrow"], L["Points the way. The map marks each place."]),
			card(p, L["Every guide"], L["Leveling, professions, reputations, mounts and pets."]),
		}
		p.Goal = goalMini(p.Cards[1].Media)
		p.Arrow = arrowMini(p.Cards[2].Media)
		p.Library = libraryMini(p.Cards[3].Media)
	end,
	layout = function(P)
		local h, p = P.Hero, P.Body
		local id, g = suggested()
		local painted = false
		if g and house() then
			local fx, fy
			local E = ns.Engine
			if E and E.GuideFocus then fx, fy = E.GuideFocus(id) end
			painted = UI.ZoneArt.Paint(h.Art, g.zone, fx, fy, 1) and true or false
		end
		h.Art:SetShown(painted)
		h.Art:SetAlpha(0.55)
		h.Dark:SetShown(painted)

		local name = known(playerInfo().name)
		p.Title:SetText(name and (L["Hello, %s"]):format(name) or L["Welcome to Polestar"])
		place(p.Title, 0, 4)
		local y = 4 + p.Title:GetStringHeight() + 8
		place(p.Line, 0, y)
		y = y + p.Line:GetStringHeight() + 22
		paintGoalMini(p.Goal, g)
		paintArrowMini(p.Arrow, g)
		for _, r in ipairs(p.Library) do
			local n = countOf(r.psCategory)
			r.Count:SetText(n > 0 and tostring(n) or "")
		end
		-- Every card as tall as the tallest.
		local textH = 0
		for _, c in ipairs(p.Cards) do
			textH = max(textH, c.Title:GetStringHeight() + 4 + c.Desc:GetStringHeight())
		end
		for i, c in ipairs(p.Cards) do
			place(c, (i - 1) * (CARD_W + CARD_GAP), y)
			c:SetHeight(6 + MEDIA_H + 10 + textH + 12)
			c.Title:ClearAllPoints()
			c.Title:SetPoint("TOPLEFT", c, "TOPLEFT", 12, -(6 + MEDIA_H + 10))
			c.Desc:ClearAllPoints()
			c.Desc:SetPoint("TOPLEFT", c.Title, "BOTTOMLEFT", 0, -4)
		end
		return HELLO_H, y + 6 + MEDIA_H + 10 + textH + 12
	end,
	title = function(P) return P.Body.Title:GetText() end,
}

-- 2. Setup ------------------------------------------------------------------

-- Quest automation is one switch for two settings: on while both are.
local function autoQuestGet()
	return ns.Get("behavior.autoAccept") and ns.Get("behavior.autoTurnin")
end

local function autoQuestSet(v)
	ns.Set("behavior.autoAccept", v)
	ns.Set("behavior.autoTurnin", v)
end

-- A toggle row with its description under the label, not only in the
-- tooltip, a hairline under it: the row reaches 12px past the 32 edge on
-- both sides, so the label and the switch sit on the page's edges.
local ROW_PAD = 11
local TEXT_W = CW - 30 - 24

local function toggleRow(p, label, path, desc, opts)
	local row = W.Toggle(p, label, path, desc, nil, opts)
	row:SetWidth(CW + 24)
	row.Desc = para(row, "note", "textMuted", TEXT_W, 3)
	row.Desc:SetText(desc)
	row.Track:ClearAllPoints()
	row.Track:SetPoint("RIGHT", row, "RIGHT", -12, 0)
	row.Label:ClearAllPoints()
	row.Label:SetPoint("TOPLEFT", row, "TOPLEFT", 12, -ROW_PAD)
	row.Label:SetWidth(TEXT_W)
	row.Label:SetWordWrap(true)
	row.Desc:SetPoint("TOPLEFT", row.Label, "BOTTOMLEFT", 0, -3)
	row.Rule:ClearAllPoints() -- the row's own hairline, on the page's edges
	row.Rule:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 12, 0)
	row.Rule:SetPoint("BOTTOMRIGHT", row, "BOTTOMRIGHT", -12, 0)
	return row
end

local function toggleRowHeight(row)
	return ROW_PAD + row.Label:GetStringHeight() + 3 + row.Desc:GetStringHeight() + ROW_PAD
end

-- Scheme cards: a small window in that scheme's colours (the sidebar strip,
-- the ground, the sky along its top, a title and a line, the selection bar
-- and the primary button), the name under it; the chosen one in a 1px
-- accent outline. The scheme's own colours come from Theme.SCHEMES;
-- EllesmereUI derives its grounds from its panel, shown as they are while
-- it is in use.
local SCHEME_GAP, PREVIEW_H, SCHEME_NAME_H = 12, 54, 28

local function schemeColours(key)
	if key == "ellesmere" then
		if Theme.SchemeKey() == "ellesmere" then return Theme.Palette() end
		return Theme.SCHEMES.graphite
	end
	return Theme.SCHEMES[key] or Theme.SCHEMES.dusk
end

local function paintScheme(c)
	local pal = schemeColours(c.psValue)
	local function rgb(name) local v = pal[name]; return v[1], v[2], v[3] end
	c.Ground:SetVertexColor(rgb("bg"))
	c.Side:SetVertexColor(rgb("sidebar"))
	c.Sky:SetVertexColor(rgb("sky"))
	c.Line1:SetVertexColor(rgb("text"))
	c.Line2:SetVertexColor(rgb("textMuted"))
	local ar, ag, ab = Theme.Accent()
	c.Button:SetVertexColor(ar, ag, ab, 1)
	c.Bar:SetVertexColor(ar, ag, ab, 1)
	local on = Theme.SchemeKey() == c.psValue
	c.psSelected = on
	if on then paintOutline(c, ar, ag, ab, 1) else paintOutline(c, Theme.Wash("border")) end
	W.Color(c.Name, on and "text" or "textDim")
end

local function schemeCard(p)
	local c = CreateFrame("Button", nil, p)
	W.Hover(c)
	outline(c)
	c.Side = solid(c, "BORDER", 0)
	c.Side:SetPoint("TOPLEFT", c, "TOPLEFT", 5, -5)
	c.Side:SetSize(22, PREVIEW_H)
	c.Ground = solid(c, "BORDER", 0)
	c.Ground:SetPoint("TOPLEFT", c.Side, "TOPRIGHT", 0, 0)
	c.Ground:SetPoint("TOPRIGHT", c, "TOPRIGHT", -5, -5)
	c.Ground:SetHeight(PREVIEW_H)
	c.Sky = solid(c, "BORDER", 1)
	c.Sky:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 0, 0)
	c.Sky:SetPoint("TOPRIGHT", c.Ground, "TOPRIGHT", 0, 0)
	c.Sky:SetHeight(14)
	c.Line1 = solid(c, "ARTWORK", 0)
	c.Line1:SetSize(52, 4)
	c.Line1:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 8, -20)
	c.Line2 = solid(c, "ARTWORK", 0)
	c.Line2:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 8, -29)
	c.Line2:SetHeight(3)
	c.Bar = solid(c, "ARTWORK", 1)
	c.Bar:SetSize(2, 15)
	c.Bar:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 0, -18)
	c.Button = solid(c, "ARTWORK", 0)
	c.Button:SetSize(22, 7)
	c.Button:SetPoint("BOTTOMRIGHT", c.Ground, "BOTTOMRIGHT", -6, 6)
	c.Name = W.Text(c, "label", "textDim")
	c.Name:SetPoint("TOPLEFT", c.Side, "BOTTOMLEFT", 3, 0)
	c.Name:SetPoint("TOPRIGHT", c.Ground, "BOTTOMRIGHT", -3, 0)
	c.Name:SetHeight(SCHEME_NAME_H)
	c.Name:SetJustifyH("LEFT")
	c.Name:SetWordWrap(false)
	-- Click applies it live; right-click puts the default back.
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", function(self, button)
		if button == "RightButton" then ns.Set("ui.scheme", nil) else ns.Set("ui.scheme", self.psValue) end
	end)
	return c
end

PAGES[#PAGES + 1] = {
	key = "setup",
	shown = function() return full end,
	build = function(P)
		compactHero(P.Hero, L["Make it yours"],
			(L["Three choices to start with. Everything else is in %s."]):format(cmd("/polestar options")), true)
		local p = P.Body
		F.AutoQuest = toggleRow(p, L["Accept and turn in guide quests for me"], "behavior.autoAccept",
			L["Only quests in the next steps of your open guides. Never picks between rewards. Hold Shift to skip."],
			{ get = autoQuestGet, set = autoQuestSet })
		F.AutoGuide = toggleRow(p, L["Load a guide for me when I log in"], "behavior.autoSelectGuide",
			L["Opens the suggested guide when no tab is open."])
		p.SchemeTitle = para(p, "body", "text", CW, 2)
		p.SchemeTitle:SetText(L["Colour scheme"])
		p.SchemeNote = para(p, "note", "textMuted", CW, 3)
		p.SchemeNote:SetText(L["The background of every Polestar window. It changes as you pick."])
		p.Keep = para(p, "note", "textMuted", CW, 3)
		p.Keep:SetText(L["Skip keeps these as they are."])
		F.Schemes = {}
	end,
	layout = function(P)
		local heroH = layoutCompactHero(P.Hero)
		local p = P.Body
		local y = 0
		for _, row in ipairs({ F.AutoQuest, F.AutoGuide }) do
			place(row, -12, y)
			row:Refresh()
			local rh = toggleRowHeight(row)
			row:SetHeight(rh)
			y = y + rh
		end
		y = y + 16
		place(p.SchemeTitle, 0, y)
		y = y + p.SchemeTitle:GetStringHeight() + 4
		place(p.SchemeNote, 0, y)
		y = y + p.SchemeNote:GetStringHeight() + 10
		local choices = Theme.SchemeChoices()
		local n = #choices
		local cw = floor((CW - SCHEME_GAP * (n - 1)) / n)
		for i, ch in ipairs(choices) do
			local c = F.Schemes[i] or schemeCard(p)
			F.Schemes[i] = c
			c.psValue = ch.value
			c.Name:SetText(ch.text)
			c:SetSize(cw, 5 + PREVIEW_H + SCHEME_NAME_H)
			c.Line2:SetWidth(floor((cw - 10 - 22) * 0.8))
			place(c, (i - 1) * (cw + SCHEME_GAP), y)
			if not c.psPainted then
				c.psPainted = true
				W.Painter(c, paintScheme)
			else
				paintScheme(c)
			end
			c:Show()
		end
		for i = n + 1, #F.Schemes do F.Schemes[i]:Hide() end
		y = y + 5 + PREVIEW_H + SCHEME_NAME_H + 14
		place(p.Keep, 0, y)
		return heroH, y + p.Keep:GetStringHeight()
	end,
	title = function(P) return P.Hero.Title:GetText() end,
}

-- 3. Route style -------------------------------------------------------------

-- The styles: the setting's value, the name, what it does, the
-- Recommended tag. Options' Route style dropdown writes the same setting;
-- Nav/Walk.lua searches its walks again when it changes.
local STYLES = {
	{ "fastest", L["Fastest"], L["The shortest walk. Cuts across fields and goes straight over hills."] },
	{ "balanced", L["Balanced"], L["Takes roads when they aren't much longer, and goes round steep hills."], true },
	{ "roads", L["Roads"], L["Stays on roads, even when it's longer. Slower, but easy to follow."] },
}
local MAP_H = 150
local OPT_L, OPT_R, OPT_T, OPT_B = 12, 14, 8, 9
local OPT_TEXT_X = OPT_L + 16 + 12
local OPT_TEXT_W = CW - OPT_TEXT_X - OPT_R

-- The style in use: the router reads anything but Fastest or Roads as
-- Balanced, the default.
local function routeStyle()
	local s = ns.Get("nav.routeStyle")
	if s == "fastest" or s == "roads" then return s end
	return "balanced"
end

local function paintStyle(c)
	local on = routeStyle() == c.psStyle
	c.psSelected = on
	c.Fill:SetShown(on)
	c.Bar:SetShown(on)
	c.Dot:SetShown(on)
	paintOutline(c, Theme.Wash("divider"))
	if on then c.Ring:SetVertexColor(Theme.Accent()) else c.Ring:SetVertexColor(Theme.Color("textMuted")) end
	W.Color(c.Name, "text")
	if c.psChip then W.SetChip(c.psChip, L["Recommended"], "accent") end
end

-- A style's row: the radio, its name (and tag), what it does. Click sets
-- the style live; right-click puts Balanced back.
local function styleRow(p, st)
	local c = CreateFrame("Button", nil, p)
	c:SetWidth(CW)
	c.Fill = W.Fill(c, "panelAlt", "BACKGROUND", -6)
	W.Hover(c)
	outline(c)
	c.Bar = solid(c, "ARTWORK", 2)
	c.Bar:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	c.Bar:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
	c.Bar:SetWidth(2)
	W.Color(c.Bar, "accent")
	c.psStyle = st[1]
	-- The radio: a ring, the accent dot in it while chosen.
	c.Ring = W.Tex(c, "ARTWORK", "skin-ring", nil, 0)
	c.Ring:SetSize(19, 19) -- the ring's ink is 14px of it
	c.Ring:SetPoint("CENTER", c, "LEFT", OPT_L + 8, 0)
	c.Dot = W.Tex(c, "ARTWORK", "circle", "accent", 2)
	c.Dot:SetSize(7, 7)
	c.Dot:SetPoint("CENTER", c.Ring, "CENTER", 0, 0)
	c.Name = W.Text(c, "heading", "text")
	c.Name:SetText(st[2])
	c.Desc = para(c, "note", "textMuted", OPT_TEXT_W, 3)
	c.Desc:SetText(st[3])
	if st[4] then c.psChip = W.Chip(c) end
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", function(self, button)
		if button == "RightButton" then ns.Set("nav.routeStyle", nil) else ns.Set("nav.routeStyle", self.psStyle) end
	end)
	W.Painter(c, paintStyle)
	return c
end

local function layoutStyleRow(c)
	paintStyle(c)
	local chipH = c.psChip and W.CHIP_H or 0
	local nameH = max(c.Name:GetStringHeight(), chipH)
	c.Name:ClearAllPoints()
	c.Name:SetPoint("LEFT", c, "TOPLEFT", OPT_TEXT_X, -(OPT_T + nameH / 2))
	if c.psChip then
		c.psChip:ClearAllPoints()
		c.psChip:SetPoint("LEFT", c.Name, "RIGHT", 8, 0)
	end
	place(c.Desc, OPT_TEXT_X, OPT_T + nameH + 2)
	local h = OPT_T + nameH + 2 + c.Desc:GetStringHeight() + OPT_B
	c:SetHeight(h)
	return h
end

-- The map: the start zone's painting, darkened on the left for the
-- readout, the guide's first walk drawn on it.
local function routeMap(p)
	local m = CreateFrame("Frame", nil, p)
	m:SetSize(CW, MAP_H)
	m.Art = UI.ZoneArt.Create(m, CW, MAP_H, "bg")
	m.Art:SetPoint("TOPLEFT", m, "TOPLEFT", 0, 0)
	m.Art.psZoom = 1.5
	m.Art.psFocusY = MAP_H / 2
	m.Art.Fade:Hide()
	m.Art.Rule:Hide()
	m.Draw = CreateFrame("Frame", nil, m)
	m.Draw:SetAllPoints(m)
	m.Draw:SetFrameLevel(m.Art.Over:GetFrameLevel() + 1)
	local d = m.Draw
	-- The readout's ground: dark on the left, clear by 60 %.
	m.Vig1 = solid(d, "BACKGROUND", -4)
	m.Vig1:SetPoint("TOPLEFT", d, "TOPLEFT", 0, 0)
	m.Vig1:SetPoint("BOTTOMLEFT", d, "BOTTOMLEFT", 0, 0)
	m.Vig1:SetWidth(floor(CW * 0.38))
	m.Vig2 = solid(d, "BACKGROUND", -4)
	m.Vig2:SetPoint("TOPLEFT", m.Vig1, "TOPRIGHT", 0, 0)
	m.Vig2:SetPoint("BOTTOMLEFT", m.Vig1, "BOTTOMRIGHT", 0, 0)
	m.Vig2:SetWidth(floor(CW * 0.22))
	m.Under = solid(d, "ARTWORK", 0)
	m.Line = solid(d, "ARTWORK", 1)
	m.Start = W.Tex(d, "OVERLAY", "circle", nil, 0)
	m.Start:SetSize(9, 9)
	m.StartHole = W.Tex(d, "OVERLAY", "circle", nil, 1)
	m.StartHole:SetSize(7, 7)
	m.StartHole:SetPoint("CENTER", m.Start, "CENTER", 0, 0)
	m.End = W.Tex(d, "OVERLAY", "circle", nil, 0)
	m.End:SetSize(13, 13)
	m.EndDot = W.Tex(d, "OVERLAY", "circle", nil, 1)
	m.EndDot:SetSize(10, 10)
	m.EndDot:SetPoint("CENTER", m.End, "CENTER", 0, 0)
	m.Place = W.Text(d, "display", "text")
	m.Place:SetPoint("TOPLEFT", d, "TOPLEFT", 14, -12)
	m.Place:SetWidth(floor(CW * 0.45))
	m.Place:SetJustifyH("LEFT")
	m.Place:SetWordWrap(false)
	m.Note = para(d, "note", "textDim", floor(CW * 0.45), 2)
	m.Note:SetPoint("TOPLEFT", m.Place, "BOTTOMLEFT", 0, -4)
	outline(m)
	W.Painter(m, function(self)
		local s1, s2, s3 = Theme.Color("scrim")
		hgrad(self.Vig1, s1, s2, s3, 0.85, s1, s2, s3, 0.35)
		hgrad(self.Vig2, s1, s2, s3, 0.35, s1, s2, s3, 0)
		local sr, sg, sb = Theme.Color("shade")
		self.Under:SetVertexColor(sr, sg, sb, 0.85)
		self.Line:SetVertexColor(Theme.Accent())
		self.Start:SetVertexColor(Theme.Color("text"))
		self.StartHole:SetVertexColor(Theme.Color("sidebar"))
		self.End:SetVertexColor(Theme.Color("onAccent"))
		self.EndDot:SetVertexColor(Theme.Accent())
		paintOutline(self, Theme.Wash("border"))
	end)
	return m
end

-- Where the walk shows when the band stands in for the painting: its shape
-- kept, fitted into the map's right part.
local function fitWalk(walk)
	local x0, y0, x1, y1 = walk[1], walk[2], walk[3], walk[4]
	local dx, dy = (x1 - x0) * 1.5, y1 - y0 -- a zone map is about 3:2
	local len = max(1, sqrt(dx * dx + dy * dy))
	local want = min(CW * 0.4, MAP_H * 0.75 * len / max(1, math.abs(dy)))
	local k = min(want / len, CW * 0.4 / max(1, math.abs(dx)), MAP_H * 0.7 / max(1, math.abs(dy)))
	local cx, cy = CW * 0.7, MAP_H * 0.5
	return cx - dx * k / 2, cy - dy * k / 2, cx + dx * k / 2, cy + dy * k / 2
end

local function paintMap(m, id, g)
	local walk = g and firstWalk(g)
	local painted = false
	if g then
		local fx, fy
		if walk then
			fx, fy = (walk[1] + walk[3]) / 2, (walk[2] + walk[4]) / 2
		else
			local E = ns.Engine
			if E and E.GuideFocus then fx, fy = E.GuideFocus(id) end
		end
		painted = UI.ZoneArt.Paint(m.Art, g.zone, fx, fy, 3) and true or false
		-- The walk's middle a little right of centre, clear of the readout.
		local cv = painted and m.Art.psCanvas
		if cv and walk and fx then
			painted = UI.ZoneArt.Paint(m.Art, g.zone, fx - (CW * 0.15) / cv[3] * 100, fy, 3) and true or false
		end
	else
		UI.ZoneArt.Paint(m.Art, nil, nil, nil, 3)
	end
	local ax, ay, bx, by
	local cv = painted and m.Art.psCanvas
	if walk and cv then
		ax, ay = cv[1] + walk[1] / 100 * cv[3], cv[2] + walk[2] / 100 * cv[4]
		bx, by = cv[1] + walk[3] / 100 * cv[3], cv[2] + walk[4] / 100 * cv[4]
	elseif walk then
		ax, ay, bx, by = fitWalk(walk)
	else
		-- No walk to show: a neutral line, the shape of a walk.
		ax, ay, bx, by = CW * 0.56, MAP_H * 0.85, CW * 0.91, MAP_H * 0.27
	end
	segment(m.Under, m.Draw, ax, ay, bx, by, 5)
	segment(m.Line, m.Draw, ax, ay, bx, by, 2)
	m.Start:ClearAllPoints()
	m.Start:SetPoint("CENTER", m.Draw, "TOPLEFT", ax, -ay)
	m.End:ClearAllPoints()
	m.End:SetPoint("CENTER", m.Draw, "TOPLEFT", bx, -by)
	m.Place:SetShown(walk ~= nil)
	m.Note:SetShown(walk ~= nil)
	if walk then
		m.Place:SetText(colored("place", walk[5]))
		m.Note:SetText((L["The first walk of %s"]):format(g.title))
	end
end

PAGES[#PAGES + 1] = {
	key = "route",
	shown = function() return full end,
	build = function(P)
		compactHero(P.Hero, L["Route style"], L["How the arrow walks you. Change it any time in Options."])
		local p = P.Body
		p.Map = routeMap(p)
		F.Styles = {}
		for i, st in ipairs(STYLES) do F.Styles[i] = styleRow(p, st) end
		p.Foot = para(p, "note", "textMuted", CW, 3)
		p.Foot:SetText(L["Every style keeps you out of the other faction's towns and away from zones far above your level."])
	end,
	layout = function(P)
		local heroH = layoutCompactHero(P.Hero)
		local p = P.Body
		local id, g = suggested()
		place(p.Map, 0, 0)
		paintMap(p.Map, id, g)
		local y = MAP_H + 10
		for _, c in ipairs(F.Styles) do
			place(c, 0, y)
			y = y + layoutStyleRow(c) + 6
		end
		y = y - 6 + 14
		place(p.Foot, 0, y)
		return heroH, y + p.Foot:GetStringHeight()
	end,
	title = function(P) return P.Hero.Title:GetText() end,
}

-- 4. Start ------------------------------------------------------------------

local function startSuggested()
	local G, E = ns.Guides, ns.Engine
	local id = E and E.StartingGuide and E.StartingGuide() or (G and G.Suggest and G.Suggest())
	close()
	if id and E and E.StartGuide then
		E.StartGuide()
	elseif id and E and E.OpenTab then
		E.OpenTab(id)
	elseif id and E and E.SetGuide then
		E.SetGuide(id)
	else
		UI.ShowPicker()
		return
	end
	ns.Fire("SHOW_FRAME")
end

-- A note under a hairline: its glyph, a heading, its line, a link on the
-- right if any.
local NOTE_X = 18 + 10

local function noteRow(p, glyph, color, heading)
	local n = {}
	n.Rule = W.Divider(p)
	n.Glyph = W.Tex(p, "ARTWORK", glyph, color)
	n.Glyph:SetSize(14, 14)
	n.Head = W.Text(p, "heading", "text")
	n.Head:SetText(heading)
	n.Text = para(p, "note", "textMuted", CW - NOTE_X, 3)
	return n
end

PAGES[#PAGES + 1] = {
	key = "start",
	build = function(P)
		local h = P.Hero
		h:SetHeight(START_H)
		-- The suggested guide's painting fills the hero; without one the
		-- band stands in and the emblem keeps its place on the right.
		h.Art = UI.ZoneArt.Create(h, INNER, START_H, "bg")
		h.Art.psZoom = 1.3
		h.Art:SetPoint("TOPLEFT", h, "TOPLEFT", 0, 0)
		h.Art.Band:ClearAllPoints() -- the stand-in at its own 1:1 height
		h.Art.Band:SetPoint("TOPLEFT", h.Art, "TOPLEFT", 0, 0)
		h.Art.Band:SetPoint("TOPRIGHT", h.Art, "TOPRIGHT", 0, 0)
		h.Art.Band:SetHeight(BAND_H)
		h.Art.Rule:Hide()
		-- The corner the title sits in, darker.
		h.Corner = W.Tex(h.Art.Over, "BACKGROUND", "glow", nil, 1)
		h.Corner:SetSize(INNER * 1.4, START_H * 1.8)
		h.Corner:SetPoint("CENTER", h.Art.Over, "BOTTOMLEFT", 0, 0)
		W.Painter(h.Corner, function(t)
			local r, g, b = Theme.Color("scrim")
			t:SetVertexColor(r, g, b, 0.8)
		end)
		h.Sky = CreateFrame("Frame", nil, h)
		h.Sky:SetAllPoints(h)
		h.Sky:SetFrameLevel(h.Art.Over:GetFrameLevel() + 1)
		h.SkyGround = night(h, h.Sky, START_H, { haze = 0.8, band = 0, bottom = "bg" })
		h.SkyGround.Band:Hide()
		dipper(h.Sky, 400, 52, 0.62, -8)
		emblem(h.Sky, 40, SIDE_X, SIDE_Y, 120, 44)
		h.Text = CreateFrame("Frame", nil, h)
		h.Text:SetAllPoints(h)
		h.Text:SetFrameLevel(h.Sky:GetFrameLevel() + 1)
		h.Title = para(h.Text, "hero", "text", CW, 2)
		h.Chip = W.Chip(h.Text)
		h.For = W.Text(h.Text, "body", "textDim")
		h.For:SetWordWrap(true) -- a second line where the chip leaves too little room
		h.For:SetJustifyH("LEFT")

		local p = P.Body
		p.Pitch = para(p, "body", "textDim", CW, 5)
		-- What Start guide does.
		p.Next = CreateFrame("Frame", nil, p)
		p.Next:SetWidth(CW)
		W.Fill(p.Next, "panel", "BACKGROUND", -6)
		outline(p.Next)
		W.Painter(p.Next, function(self) paintOutline(self, Theme.Wash("divider")) end)
		p.Next.Glyph = W.Tex(p.Next, "ARTWORK", "dart-gold")
		p.Next.Glyph:SetSize(14, 14)
		p.Next.Glyph:SetPoint("TOPLEFT", p.Next, "TOPLEFT", 12, -11)
		p.Next.Text = para(p.Next, "note", "textDim", CW - 24 - 24, 3)
		p.Next.Text:SetPoint("TOPLEFT", p.Next, "TOPLEFT", 12 + 24, -10)

		p.Beta = noteRow(p, "flag", "warning", L["Our routes are still in beta"])
		p.Beta.Chip = W.Chip(p)
		p.Beta.Chip:SetPoint("LEFT", p.Beta.Head, "RIGHT", 8, 0)
		p.Discord = noteRow(p, "discord", "discord", L["Join us on Discord"])
		-- The invite as a link (the scheme left off); a click opens the copy
		-- window holding it, since the game cannot open links.
		F.Discord = W.Link(p, (ns.DiscordURL:gsub("^%a+://", "")), function() UI.ShowDiscord() end)
		p.Discord.Link = F.Discord
		p.Packs = noteRow(p, "guides", "textMuted", L["Community guides"])
		F.Browse = W.Link(p, L["Browse guides"], function()
			close()
			UI.ShowPicker()
		end)
		F.Browse.psTip = nil -- it opens the guide menu, nothing to copy
		p.Packs.Link = F.Browse
	end,
	layout = function(P)
		local h, p = P.Hero, P.Body
		local id, g = suggested()
		-- The hero: the painting, or the band with the emblem and the Dipper.
		local painted = false
		if g then
			local fx, fy
			local E = ns.Engine
			if E and E.GuideFocus then fx, fy = E.GuideFocus(id) end
			painted = UI.ZoneArt.Paint(h.Art, g.zone, fx, fy, 1) and true or false
		else
			UI.ZoneArt.Paint(h.Art, nil, nil, nil, 1)
		end
		h.psPainted = painted
		h.Sky:SetShown(not painted)
		h.Corner:SetShown(painted)
		h.Title:SetWidth(painted and CW or CW - 120)
		h.Title:SetText(g and g.title or L["Choose your first guide"])
		local lv = g and UI.LevelRange(g.minLevel, g.maxLevel)
		local chipW = 0
		if lv then
			chipW = W.SetChip(h.Chip, L["Levels"] .. " " .. lv, "accent") + 10
		else
			h.Chip:Hide()
		end
		h.For:SetText(g and forWhom(g) or L["Polestar has no guide to suggest for where you are."])
		h.For:SetWidth(min(W.TextWidth(h.For) + 1, CW - chipW))
		local factY = START_H - 12 - W.CHIP_H
		h.Chip:ClearAllPoints()
		h.Chip:SetPoint("TOPLEFT", h.Text, "TOPLEFT", EDGE, -factY)
		h.For:ClearAllPoints()
		h.For:SetPoint("LEFT", h.Text, "TOPLEFT", EDGE + chipW, -(factY + W.CHIP_H / 2))
		-- Centred on the chip, a wrapped line reaches above it: the title
		-- keeps its 8px over whichever is higher.
		local lift = max(0, (h.For:GetStringHeight() - W.CHIP_H) / 2)
		h.Title:ClearAllPoints()
		h.Title:SetPoint("TOPLEFT", h.Text, "TOPLEFT", EDGE, -(factY - lift - 8 - h.Title:GetStringHeight()))

		-- The page: the pitch, what Start guide does, the notes.
		local y = 8
		local pitch = g and known(g.pitch)
		p.Pitch:SetShown(pitch ~= nil)
		if pitch then
			p.Pitch:SetText(pitch)
			place(p.Pitch, 0, y)
			y = y + p.Pitch:GetStringHeight() + 12
		end
		p.Next.Text:SetText((L["%s opens the guide window on the right. The arrow points at your first stop."]):format(cmd(g and L["Start guide"] or L["Choose a guide"])))
		place(p.Next, 0, y)
		p.Next:SetHeight(10 + p.Next.Text:GetStringHeight() + 10)
		y = y + p.Next:GetHeight() + 14

		local function lay(n, shown)
			for _, k in ipairs({ "Rule", "Glyph", "Head", "Text", "Link" }) do
				if n[k] then n[k]:SetShown(shown) end
			end
			if not shown then return end
			n.Rule:ClearAllPoints()
			n.Rule:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -y)
			n.Rule:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -y)
			local top = y + 10
			place(n.Glyph, 0, top + 2)
			place(n.Head, NOTE_X, top)
			local linkW = n.Link and (n.Link:GetWidth() + 16) or 0
			n.Text:SetWidth(CW - NOTE_X - linkW)
			place(n.Text, NOTE_X, top + n.Head:GetStringHeight() + 3)
			if n.Link then
				n.Link:ClearAllPoints()
				n.Link:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -(top - 2))
			end
			y = top + n.Head:GetStringHeight() + 3 + n.Text:GetStringHeight() + 10
		end
		local beta = ns.routesBeta and true or false
		p.Beta.Text:SetText((L["Played to the end in tests, but not yet by players. If a step is wrong, press %s in the guide window and tell us on Discord."]):format(cmd(L["Skip"])))
		lay(p.Beta, beta)
		if beta then W.SetChip(p.Beta.Chip, string.upper(L["Beta"]), "warning") else p.Beta.Chip:Hide() end
		p.Discord.Text:SetText(L["Feedback, bug reports and news."])
		lay(p.Discord, true)
		p.Packs.Text:SetText(L["Guides by other players, installed like any addon. They show under Community guides in the guide list."])
		lay(p.Packs, true)
		setChevronText(F.Start, g and L["Start guide"] or L["Choose a guide"])
		return START_H, y - 10
	end,
	title = function(P) return P.Hero.Title:GetText() end,
}

-- The pages shown now, in order.
local function pageList()
	local out = {}
	for _, pg in ipairs(PAGES) do
		if not pg.shown or pg.shown() then out[#out + 1] = pg end
	end
	return out
end

---------------------------------------------------------------------------
-- The window
---------------------------------------------------------------------------

local render -- forward

-- The hero settles 8px up as it fades in (on open).
local function settle(P)
	Anim.Anchor(P.Hero, "TOPLEFT", P, "TOPLEFT", 0, 0)
	Anim.To(P.Hero, "alpha", 0, 1, Anim.BASE, "out")
	Anim.To(P.Hero, "offset", -8, 0, Anim.BASE, "out")
end

local function go(delta)
	local list = pageList()
	local at = 1
	for i, pg in ipairs(list) do if pg.key == current then at = i end end
	local to = at + delta
	if to > #list then return close() end
	if to < 1 then to = 1 end
	if list[to].key == current then return end
	local from = current
	current = list[to].key
	render(from)
end

local DOT, DOT_ON, DOT_GAP = 4, 16, 6

local function drag(frame)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", function() F:StartMoving() end)
	frame:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
end

local function build()
	F = CreateFrame("Frame", "PolestarWelcome", UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetWidth(WIDTH)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	F:Hide()
	Theme.Skin(F, "window")
	drag(F)

	-- Over the pages: the ✕ (with a dark disc of its own on a painting).
	local top = CreateFrame("Frame", nil, F)
	top:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
	top:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
	top:SetHeight(52)
	top:SetFrameLevel(F:GetFrameLevel() + 40)
	F.Close = W.IconButton(top, "close", 28, L["Close"], close, 12)
	F.Close:SetPoint("TOPRIGHT", F, "TOPRIGHT", -12, -12)
	F.CloseScrim = W.Pill(top, 28, 28)
	F.CloseScrim:SetPoint("CENTER", F.Close, "CENTER", 0, 0)
	W.Painter(F.CloseScrim, function(s) local r, g, b = Theme.Color("scrim"); s:SetColor(r, g, b, 0.6) end)
	F.CloseScrim:SetFrameLevel(top:GetFrameLevel())
	F.Close:SetFrameLevel(top:GetFrameLevel() + 2)
	F.CloseScrim:Hide()

	-- The footer: Skip (Back on the last page) on the left, the step dots
	-- in the middle, Back and Next (Start guide on the last page) on the
	-- right.
	local foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(FOOT_H)
	foot:SetFrameLevel(F:GetFrameLevel() + 30)
	W.Fill(foot, "footer")
	local rule = W.Divider(foot)
	rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	F.Foot = foot
	F.Skip = W.Button(foot, L["Skip"], close, { ghost = true })
	F.Skip:SetPoint("LEFT", foot, "LEFT", FOOT_PAD, 0)
	F.Next = W.Button(foot, L["Next"], function() go(1) end, { primary = true })
	chevron(F.Next)
	setChevronText(F.Next, L["Next"])
	F.Next:SetPoint("RIGHT", foot, "RIGHT", -FOOT_PAD, 0)
	F.Back = W.Button(foot, L["Back"], function() go(-1) end)
	F.Start = W.Button(foot, L["Start guide"], startSuggested, { primary = true })
	chevron(F.Start)
	F.Start:SetPoint("RIGHT", foot, "RIGHT", -FOOT_PAD, 0)
	F.Dots = CreateFrame("Frame", nil, foot)
	F.Dots:SetHeight(DOT)
	F.Dots:SetPoint("CENTER", foot, "CENTER", 0, 0)
	F.Dots.list = {}

	-- The pages: each its hero and the page under it on the 32 edge.
	F.pages = {}
	for _, pg in ipairs(PAGES) do
		local P = CreateFrame("Frame", nil, F)
		P:SetWidth(INNER)
		P:SetHeight(1)
		Anim.Anchor(P, "TOPLEFT", F, "TOPLEFT", 1, -1)
		P:Hide()
		local h = CreateFrame("Frame", nil, P)
		h:SetSize(INNER, HELLO_H)
		Anim.Anchor(h, "TOPLEFT", P, "TOPLEFT", 0, 0)
		if h.SetClipsChildren then h:SetClipsChildren(true) end
		drag(h)
		local b = CreateFrame("Frame", nil, P)
		b:SetWidth(CW)
		b:SetHeight(1)
		P.Hero, P.Body, P.psKey = h, b, pg.key
		pg.build(P)
		F.pages[pg.key] = P
	end
	if W.Rim then F.Rim = W.Rim(F) end

	F:SetScript("OnShow", function(self)
		Anim.To(self, "alpha", 0, 1, Anim.BASE, "out")
		settle(F.pages[current])
	end)
	-- Any close marks it seen, for the character and the account; stepping
	-- aside for the route choice does not, nor does a cinematic closing it
	-- (it comes back after the cinematic, on the same page).
	F:SetScript("OnHide", function()
		if stepping then return end
		if inCinematic() then
			pending = "asked"
			return
		end
		ns.CharState().welcomeSeen = SEEN
		ns.DB().welcomeSeen = SEEN
		pending = nil
	end)
	ns.CloseOnEscape("PolestarWelcome")
	WEL.frame = F
	-- A gamepad (UI/Gamepad.lua): LB / RB turn the pages, A on Next by default.
	-- Shown by itself, it waits for the player before it takes the gamepad.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			unasked = function() return unasked end,
			initial = function(rows)
				for i, w in ipairs(rows) do if w == F.Next or w == F.Start then return i end end
			end,
			prevTab = function() go(-1) end,
			nextTab = function()
				local _, at, count = WEL.Page()
				if at and count and at < count then go(1) end
			end,
			tabsLabel = L["Pages"],
			-- A colour scheme's card or a route style's row: Y puts the
			-- default (Dusk, Balanced) back.
			reset = function(w)
				if w and (w.psValue or w.psStyle) then
					w:Click("RightButton")
					return true
				end
			end,
			resetLabel = function(w) return (w.psValue or w.psStyle) and L["Default"] or nil end,
		})
	end
end

-- The step dots: the current one a 16x4 accent capsule, those done muted,
-- the rest faint. They show where you are; they are not buttons.
local function paintDots(at, n, animate)
	local list = F.Dots.list
	for i = 1, max(n, #list) do
		local d = list[i]
		if i <= n then
			if not d then
				d = W.Pill(F.Dots, DOT, DOT)
				list[i] = d
			end
			local on = i == at
			if on then
				local r, g, b = Theme.Accent()
				d:SetColor(r, g, b, 1)
			elseif i < at then
				local r, g, b = Theme.Color("textMuted")
				d:SetColor(r, g, b, 1)
			else
				local r, g, b = Theme.Color("ink")
				d:SetColor(r, g, b, 0.22)
			end
			local w = on and DOT_ON or DOT
			if animate and d.psW and d.psW ~= w then
				Anim.To(d, "width", d.psW, w, Anim.FAST, "out")
			else
				d:SetWidth(w)
			end
			d.psW = w
			d:Show()
		elseif d then
			d:Hide()
		end
	end
	local total, x = 0, 0
	for i = 1, n do total = total + (i == at and DOT_ON or DOT) + (i > 1 and DOT_GAP or 0) end
	F.Dots:SetWidth(total)
	for i = 1, n do
		list[i]:ClearAllPoints()
		list[i]:SetPoint("LEFT", F.Dots, "LEFT", x, 0)
		x = x + (i == at and DOT_ON or DOT) + DOT_GAP
	end
end

-- Lays every page shown out (the window takes the tallest) and shows the
-- current one; `from`: the page left, faded out.
function render(from)
	local list = pageList()
	local at
	for i, pg in ipairs(list) do if pg.key == current then at = i end end
	if not at then
		at = 1
		current = list[1].key
	end
	local tallest = 0
	for _, pg in ipairs(list) do
		local P = F.pages[pg.key]
		local heroH, bodyH = pg.layout(P)
		P.Hero:SetHeight(heroH)
		P.Body:ClearAllPoints()
		P.Body:SetPoint("TOPLEFT", P, "TOPLEFT", EDGE, -heroH)
		P.Body:SetHeight(max(1, bodyH))
		tallest = max(tallest, heroH + bodyH + BOTTOM)
	end
	tallest = math.ceil(tallest)
	for _, pg in ipairs(list) do F.pages[pg.key]:SetHeight(tallest) end
	F:SetHeight(1 + tallest + FOOT_H + 1)
	if F.Rim and W.LayoutRim then W.LayoutRim(F) end

	local animate = from ~= nil and F:IsShown()
	for key, P in pairs(F.pages) do
		if key == current then
			P:Show()
			P.Hero:SetAlpha(1)
			if animate then
				Anim.To(P, "alpha", 0, 1, Anim.BASE, "out")
				Anim.To(P, "offset", -6, 0, Anim.BASE, "out")
			else
				Anim.Stop(P, "offset")
				P:SetAlpha(1)
			end
		elseif animate and key == from then
			Anim.To(P, "alpha", P:GetAlpha(), 0, OUT, "out", function(o) if o.psKey ~= current then o:Hide() end end)
		else
			P:Hide()
		end
	end
	F.CloseScrim:SetShown(current == "start" and F.pages.start.Hero.psPainted or false)

	local last = at == #list
	paintDots(at, #list, animate)
	F.Skip:SetShown(not last)
	F.Next:SetShown(not last)
	F.Start:SetShown(last)
	-- Back sits beside Next; on the last page it takes Skip's place, so
	-- Start guide keeps the right.
	F.Back:SetShown(at > 1)
	F.Back:ClearAllPoints()
	if last then
		F.Back:SetPoint("LEFT", F.Foot, "LEFT", FOOT_PAD, 0)
	else
		F.Back:SetPoint("RIGHT", F.Next, "LEFT", -8, 0)
	end
	-- The dots stay centred unless the buttons come within 12px; then they
	-- centre in the room between them.
	local leftW = (last and F.Back or F.Skip):GetWidth()
	local rightW = last and F.Start:GetWidth() or (F.Next:GetWidth() + (at > 1 and (8 + F.Back:GetWidth()) or 0))
	local lo, hi = FOOT_PAD + leftW + 12, INNER - FOOT_PAD - rightW - 12
	local dw, mid = F.Dots:GetWidth(), INNER / 2
	if mid - dw / 2 < lo or mid + dw / 2 > hi then mid = (lo + hi) / 2 end
	F.Dots:ClearAllPoints()
	F.Dots:SetPoint("CENTER", F.Foot, "LEFT", mid, 0)
	F.psAt, F.psCount = at, #list
end

local try -- forward; defined below

-- Wait for the route choice to close, then try again.
local function afterRouteChoice()
	local RC = UI.RouteChoice
	if not hookedRC and RC and RC.frame then
		hookedRC = true
		RC.frame:HookScript("OnHide", function() try() end)
	end
end

-- Open now on the current page, or as soon as combat and the route choice
-- allow. A showing at login starts on the first page, with setup and the
-- route style while the account has not had its welcome. deferred: opened by
-- itself (at login, or after the fight or the route choice that held it
-- back), not on request.
local function open(why, deferred)
	if inCombat() or inCinematic() then
		pending = pending == "asked" and "asked" or why
		return
	end
	if routeChoiceUp() then
		pending = pending == "asked" and "asked" or why
		afterRouteChoice()
		return
	end
	pending = nil
	if why == "login" then
		ns.CharState().welcomeSeen = SEEN -- shown: a reload or logout from here does not repeat it
		full = not accountSeen()
		current = PAGES[1].key
	end
	if not F then build() end
	unasked = deferred and true or false
	render()
	F:Show()
	F:Raise()
end

-- Open the welcome at `page` (a page key: "welcome", "setup", "route",
-- "start"; or its number among the pages shown), the first by default, with
-- every page. Opens even when already seen (About, /polestar welcome, the
-- preview).
function WEL.Show(page)
	full = true
	local list = pageList()
	current = list[1].key
	if type(page) == "number" and list[page] then
		current = list[page].key
	elseif type(page) == "string" then
		for _, pg in ipairs(list) do if pg.key == page then current = page end end
	end
	open("asked")
end

function WEL.Hide()
	pending = nil
	if F then F:Hide() end
end

function WEL.IsShown()
	return F ~= nil and F:IsShown()
end

-- The page shown: its key, its place and the number of pages, its title.
function WEL.Page()
	if not F then return nil end
	local title
	for _, pg in ipairs(PAGES) do
		if pg.key == current then title = pg.title(F.pages[current]) end
	end
	return current, F.psAt, F.psCount, title
end

function try()
	if pending == "asked" or (pending and not seen()) then open(pending, true) end
end

-- A route choice opened over the welcome: step aside, come back after it
-- with the same pages.
local function yieldToRouteChoice()
	if not (F and F:IsShown() and routeChoiceUp()) then return end
	stepping = true
	F:Hide()
	stepping = nil
	pending = "asked"
	afterRouteChoice()
end

-- The character's flag, set as the addon loads: due (0) for a new character,
-- seen for one Polestar already knew, so only new characters get it unasked.
ns.OnInit(function()
	local s = ns.CharState()
	if s.welcomeSeen == nil then s.welcomeSeen = ns.IsNewCharacter() and 0 or SEEN end
end)

ns.OnLogin(function()
	local db = ns.DB()
	db.betaNoticeSeen = nil -- the beta notice's flag; the welcome has its own
	if seen() then return end
	pending = "login"
	if C_Timer and C_Timer.After then C_Timer.After(DELAY, try) else try() end
end)

-- RouteChoice.lua registers first, so its window is already up (or still
-- waiting out combat) when these run.
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	yieldToRouteChoice()
	try()
end)
-- After a cinematic, once the UI is back.
ns.RegisterEvent("CINEMATIC_STOP", function()
	if C_Timer and C_Timer.After then C_Timer.After(1, try) else try() end
end)
ns.On("ROUTE_CHOICE", yieldToRouteChoice)
ns.On("SHOW_WELCOME", function(page) WEL.Show(page) end)

-- The quest switch stands for two settings; the widgets refresh it for the
-- one it is bound to (behavior.autoAccept), this for the other. A route
-- style set anywhere (the rows, Options) moves the rows' pick. A theme
-- change repaints the dots (the cards repaint with the theme).
ns.On("SETTING_CHANGED", function(path)
	if path == "behavior.autoTurnin" and F and F.AutoQuest then F.AutoQuest:Refresh() end
	if (path == "nav.routeStyle" or path == "nav" or path == "") and F and F.Styles then
		for _, c in ipairs(F.Styles) do paintStyle(c) end
	end
end)
Theme.OnChanged(function()
	if F and F.psAt then paintDots(F.psAt, F.psCount, false) end
end)
