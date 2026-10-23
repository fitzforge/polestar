-- The welcome: a Polestar window, centred, that greets a character Polestar
-- has not seen before. Every page opens under a 176px hero (the starlit band
-- with the Little Dipper drawn faintly in code, its handle leading to the
-- page's emblem, or the suggested guide's zone painting); the page below on
-- the 32 edge; a footer bar with the step dots, Skip, Back and Next.
--   1. welcome: the lockup (emblem, wordmark, tagline) in the hero; Hello,
--      <name>, one line on what Polestar does, then the guide window, the
--      arrow and every guide (/polestar guides) as three columns;
--   2. setup: quest automation (behavior.autoAccept and autoTurnin as one
--      switch) and the guide at login (behavior.autoSelectGuide), each with
--      its description inline, and the colour scheme (ui.scheme) as swatch
--      cards that apply live;
--   3. route: the route style (nav.routeStyle, the setting Options' Route
--      style dropdown writes) as three cards, Fastest, Balanced (Recommended)
--      and Roads, each saying what it does, that apply live; a line on what
--      every style keeps you away from. Shown with setup;
--   4. start: the suggested guide on its painting (its level range, who it
--      is for), its pitch; the beta callout while ns.routesBeta is true; the
--      Discord community (its invite as a link to the copy window); what
--      guide packs are.
--      Start guide (Choose a guide without one) or Browse guides.
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
-- close (Skip, Start guide, Browse guides, the hero's ✕, Escape) sets both
-- flags. The beta notice's old flag (betaNoticeSeen) is dropped.
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
-- The window takes the height of its tallest page, so it never jumps; a
-- shorter page sits a little above the middle of the room left. Motion: the
-- window fades in, the hero settles 8px up as it fades in (180ms); a page
-- change cross-fades the hero and the page (120ms). Built on first use;
-- colours are Theme tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, max, min, sqrt, cos, sin = math.floor, math.max, math.min, math.sqrt, math.cos, math.sin
local atan2 = math.atan2 or math.atan

local WEL = {}
UI.Welcome = WEL

local SEEN = 1 -- the welcome's version; a later welcome raises it
local WIDTH = 560
local PAD = 32
local CW = WIDTH - PAD * 2
local HERO_W = WIDTH - 2 -- inside the window's 1px edge
local HERO_H = 176
local BAND_H = 128 -- the band at 1:1; its sky fades into the ground below
local EDGE = PAD - 1 -- the 32 edge, in hero coordinates
local BODY_Y = HERO_H + 24 -- the page's top, under the hero
local FOOT_H = 56
local DELAY = 2 -- seconds after login, so the world and the other windows settle first

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

local function cmd(text)
	return "|c" .. Theme.Hex("text") .. text .. "|r"
end

-- A wrapped block of text, `width` wide.
local function para(parent, role, color, width, spacing)
	local fs = W.Text(parent, role, color)
	fs:SetWidth(width)
	fs:SetWordWrap(true)
	fs:SetSpacing(spacing or 4)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	return fs
end

local function place(region, x, y)
	region:ClearAllPoints()
	region:SetPoint("TOPLEFT", region:GetParent(), "TOPLEFT", x, -y)
end

-- Text on a painting: the deeper shade under it.
local function onArt(fs)
	W.Painter(fs, function(t)
		local r, g, b = Theme.Color("shade")
		t:SetShadowOffset(0, -1)
		t:SetShadowColor(r, g, b, 0.85)
	end)
	return fs
end

local function close()
	if F then F:Hide() end
end

---------------------------------------------------------------------------
-- The hero's art: the emblem in its glow, and the Little Dipper
---------------------------------------------------------------------------

-- The emblem (or `glyph`, a media key in the emblem's place), `size` px,
-- centred on (x, y) in hero coordinates, in its glow.
local function emblem(parent, size, x, y, glyph)
	local e = W.Tex(parent, "ARTWORK", glyph or "emblem", "accent")
	e:SetSize(size, size)
	e:SetPoint("CENTER", parent, "TOPLEFT", x, -y)
	local glow = W.Tex(parent, "BACKGROUND", "glow", nil, 2)
	glow:SetSize(floor(size * 2.35 + 0.5), floor(size * 2.35 + 0.5))
	glow:SetPoint("CENTER", e, "CENTER", 0, 0)
	W.Painter(glow, function(t) local r, g, b = Theme.Accent(); t:SetVertexColor(r, g, b, 0.12) end)
	return e
end

-- The Little Dipper, stylised, in px with Polaris at the origin (x right,
-- y down): { x, y, size, ink }. Polaris first; the emblem stands on it.
local DIPPER = {
	{ 0, 0, 9, 0.8 }, -- Polaris
	{ 70, 14, 4, 0.35 }, -- Yildun
	{ 128, 38, 5, 0.45 }, -- Epsilon
	{ 176, 70, 5, 0.45 }, -- Zeta
	{ 236, 64, 4, 0.3 }, -- Eta
	{ 250, 112, 7, 0.65 }, -- Pherkad
	{ 190, 118, 9, 0.8 }, -- Kochab
}
-- Polaris-Yildun-Epsilon-Zeta-Eta-Pherkad-Kochab-Zeta.
local LINKS = { { 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 }, { 5, 6 }, { 6, 7 }, { 7, 4 } }
local DIPPER_SCALE = 0.68
local DIPPER_TURN = math.pi -- the sky turned half a night: the handle leads down-right to Polaris

-- Draws the Dipper with Polaris at (px, py) in hero coordinates. polarisR:
-- the emblem's radius when the emblem is Polaris (its own star then hides).
local function dipper(parent, px, py, polarisR)
	local c, s = cos(DIPPER_TURN), sin(DIPPER_TURN)
	local pts = {}
	for i, st in ipairs(DIPPER) do
		local x, y = st[1] * DIPPER_SCALE, st[2] * DIPPER_SCALE
		pts[i] = { px + x * c - y * s, py + x * s + y * c }
		if not (i == 1 and polarisR) then
			-- A star: a soft halo round a small bright core.
			local ink, size = st[4], st[3]
			local halo = W.Tex(parent, "BORDER", "glow", nil, 1)
			halo:SetSize(size * 2.4, size * 2.4)
			halo:SetPoint("CENTER", parent, "TOPLEFT", pts[i][1], -pts[i][2])
			local core = W.Tex(parent, "BORDER", "circle", nil, 2)
			core:SetSize(max(2, size * 0.45), max(2, size * 0.45))
			core:SetPoint("CENTER", halo, "CENTER", 0, 0)
			W.Painter(halo, function(t)
				local r, g, b = Theme.Color("star")
				t:SetVertexColor(r, g, b, ink * 0.55)
				core:SetVertexColor(r, g, b, ink)
			end)
		end
	end
	-- Hairlines between the stars, stopping short of each so every star
	-- stands clear, as on a star chart.
	local function gap(i) return (i == 1 and polarisR) and (polarisR + 4) or (DIPPER[i][3] * 0.8 + 3) end
	for _, link in ipairs(LINKS) do
		local a, b = pts[link[1]], pts[link[2]]
		local dx, dy = b[1] - a[1], b[2] - a[2]
		local len = sqrt(dx * dx + dy * dy)
		local ga, gb = gap(link[1]), gap(link[2])
		local seg = len - ga - gb
		if seg > 2 then
			local mid = (ga + seg / 2) / len
			local t = W.Tex(parent, "BORDER", "white", nil, 0)
			t:SetTexCoord(0, 1, 0, 1) -- drawn as an image, so it turns
			t:SetSize(seg, Theme.Pixel(parent))
			t:SetPoint("CENTER", parent, "TOPLEFT", a[1] + dx * mid, -(a[2] + dy * mid))
			t:SetRotation(-atan2(dy, dx))
			W.Painter(t, function(tex) local r, g, bb = Theme.Color("ink"); tex:SetVertexColor(r, g, bb, 0.16) end)
		end
	end
end

-- Where the emblem stands when it sits at the hero's right (setup, route,
-- start without a painting): Polaris low on the right, the Dipper above it.
local SIDE_X, SIDE_Y, SIDE_EMBLEM = HERO_W - 64, 112, 36
local SIDE_TEXT_W = 300 -- text beside it stays clear of the stars

---------------------------------------------------------------------------
-- Pages: build(p, hero) once; layout(p, hero) -> the page's height, on every
-- show. p is the page under the hero, hero the page's content in the hero.
---------------------------------------------------------------------------

local PAGES = {}

-- The player as Polestar reads them; a field is nil when the client cannot say.
local function playerInfo()
	local C = ns.Compat
	local ok, info = pcall(C.GetPlayerInfo)
	return ok and type(info) == "table" and info or {}
end

local function known(s)
	return type(s) == "string" and s ~= "" and s or nil
end

-- The guide Polestar suggests, or nil.
local function suggested()
	local G = ns.Guides
	local id = G and G.Suggest and G.Suggest()
	local g = id and G.Get and G.Get(id)
	if g and known(g.title) then return id, g end
	return nil
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

-- 1. Welcome --------------------------------------------------------------

-- Glyph, title, first line (a slash command, shown as one, is not
-- translated), second line.
local FEATURES = {
	{ "window", L["The guide window"], L["The step you are on."], L["Goals tick off as you play."] },
	{ "icon-goto", L["The arrow"], L["Points the way."], L["The map marks each place."] },
	{ "guides", L["Every guide"], "/polestar guides", L["Leveling, professions, reputations, mounts and pets."] },
}
local COL_GAP = 24
local COL_W = floor((CW - COL_GAP * (#FEATURES - 1)) / #FEATURES)

local LOCKUP_X, LOCKUP_Y, LOCKUP_EMBLEM = 204, 100, 56

PAGES[#PAGES + 1] = {
	key = "welcome",
	build = function(p, h)
		-- The lockup: the emblem (Polaris), the wordmark and tagline stacked
		-- and centred on it, 20px after its ink.
		emblem(h, LOCKUP_EMBLEM, LOCKUP_X, LOCKUP_Y)
		dipper(h, LOCKUP_X, LOCKUP_Y, LOCKUP_EMBLEM / 2 - 8)
		local textX = LOCKUP_X + LOCKUP_EMBLEM / 2 - 8 + 20
		h.Word = W.Tex(h, "ARTWORK", "wordmark", "text")
		h.Word:SetSize(256, 32)
		h.Word:SetPoint("TOPLEFT", h, "TOPLEFT", textX - 3, -(LOCKUP_Y - 28))
		h.Tagline = para(h, "note", "textDim", HERO_W - EDGE - textX, 2)
		h.Tagline:SetText(L["Leveling guides for World of Warcraft: Forever"])
		h.Tagline:SetPoint("TOPLEFT", h, "TOPLEFT", textX, -(LOCKUP_Y + 8))

		p.Title = para(p, "hero", "text", CW, 2)
		p.Line = para(p, "body", "textDim", CW)
		p.Cols = {}
		for i, f in ipairs(FEATURES) do
			local col = {}
			col.Glyph = W.Tex(p, "ARTWORK", f[1], "accent")
			col.Glyph:SetSize(20, 20)
			col.Title = para(p, "title", "text", COL_W, 2)
			col.Title:SetText(f[2])
			col.Text = para(p, "small", "textMuted", COL_W, 3)
			local first = f[3]:sub(1, 1) == "/" and cmd(f[3]) or f[3]
			col.Text:SetText(first .. "\n" .. f[4])
			if i > 1 then col.Rule = W.Divider(p, true) end
			p.Cols[i] = col
		end
	end,
	layout = function(p)
		local name = known(playerInfo().name)
		p.Title:SetText(name and (L["Hello, %s"]):format(name) or L["Welcome to Polestar"])
		p.Line:SetText(L["Polestar guides you step by step: who to talk to, what to kill or collect, and where to go."])
		place(p.Title, 0, 0)
		local y = p.Title:GetStringHeight() + 10
		place(p.Line, 0, y)
		y = y + p.Line:GetStringHeight() + 28
		local colH = 0
		for i, col in ipairs(p.Cols) do
			local x = (i - 1) * (COL_W + COL_GAP)
			place(col.Glyph, x, y)
			place(col.Title, x, y + 32)
			local ty = y + 32 + col.Title:GetStringHeight() + 8
			place(col.Text, x, ty)
			colH = max(colH, ty + col.Text:GetStringHeight() - y)
		end
		for _, col in ipairs(p.Cols) do
			if col.Rule then
				col.Rule:ClearAllPoints()
				col.Rule:SetPoint("TOPRIGHT", col.Glyph, "TOPLEFT", -COL_GAP / 2, 0)
				col.Rule:SetHeight(colH)
			end
		end
		return y + colH
	end,
	title = function(p) return p.Title:GetText() end,
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
-- tooltip: the row reaches 12px past the 32 edge on both sides, so the
-- label and the switch sit on the page's edges.
local function toggleRow(p, label, path, desc, opts)
	local row = W.Toggle(p, label, path, desc, nil, opts)
	row:SetWidth(CW + 24)
	row.Desc = para(row, "small", "textMuted", CW - 30 - 16, 3)
	row.Desc:SetText(desc)
	row.Track:ClearAllPoints()
	row.Track:SetPoint("TOPRIGHT", row, "TOPRIGHT", -12, -14)
	row.Label:ClearAllPoints()
	row.Label:SetPoint("TOPLEFT", row, "TOPLEFT", 12, -14)
	row.Label:SetPoint("RIGHT", row.Track, "LEFT", -16, 0)
	row.Label:SetWidth(CW - 30 - 16) -- what the anchors give it, for its height when it wraps
	row.Desc:SetPoint("TOPLEFT", row.Label, "BOTTOMLEFT", 0, -5)
	return row
end

local function toggleRowHeight(row)
	return 14 + row.Label:GetStringHeight() + 5 + row.Desc:GetStringHeight() + 14
end

-- The hero's title and line beside the emblem sit low, the line's foot 24
-- above the hero's edge (setup, route).
local function lowHeroText(h)
	local subH = h.Sub:GetStringHeight()
	local subY = HERO_H - 24 - subH
	h.Sub:ClearAllPoints()
	h.Sub:SetPoint("TOPLEFT", h, "TOPLEFT", EDGE, -subY)
	h.Title:ClearAllPoints()
	h.Title:SetPoint("TOPLEFT", h, "TOPLEFT", EDGE, -(subY - 8 - h.Title:GetStringHeight()))
end

-- A card's 1px outline: the accent while it is the one chosen, the border
-- wash otherwise.
local function outline(c)
	local px = Theme.Pixel(c)
	c.psEdge = {}
	for i, pts in ipairs({ { "TOPLEFT", "TOPRIGHT" }, { "BOTTOMLEFT", "BOTTOMRIGHT" }, { "TOPLEFT", "BOTTOMLEFT" }, { "TOPRIGHT", "BOTTOMRIGHT" } }) do
		local e = c:CreateTexture(nil, "OVERLAY")
		e:SetTexture(Theme.Media("white"))
		e:SetPoint(pts[1], c, pts[1], 0, 0)
		e:SetPoint(pts[2], c, pts[2], 0, 0)
		if i <= 2 then e:SetHeight(px) else e:SetWidth(px) end
		c.psEdge[i] = e
	end
end

local function paintOutline(c, on)
	c.psSelected = on
	local r, g, b, a
	if on then
		r, g, b = Theme.Accent()
		a = 1
	else
		r, g, b, a = Theme.Wash("border")
	end
	for i = 1, 4 do c.psEdge[i]:SetVertexColor(r, g, b, a) end
	W.Color(c.Name, on and "text" or "textDim")
end

-- Scheme cards: a small window in that scheme's grounds with the accent, the
-- name under it. The scheme's own colours come from Theme.SCHEMES; EllesmereUI
-- derives its grounds from its panel, shown as they are while it is in use.
local CARD_GAP, PREVIEW_H, CARD_NAME_H = 12, 56, 30

local function schemeColours(key)
	if key == "ellesmere" then
		if Theme.SchemeKey() == "ellesmere" then return Theme.Palette() end
		return Theme.SCHEMES.graphite
	end
	return Theme.SCHEMES[key] or Theme.SCHEMES.dusk
end

local function paintCard(c)
	local pal = schemeColours(c.psValue)
	local function rgb(name) local v = pal[name]; return v[1], v[2], v[3] end
	c.Ground:SetVertexColor(rgb("bg"))
	c.Side:SetVertexColor(rgb("sidebar"))
	local sr, sg, sb = rgb("sky")
	local br, bg, bb = rgb("bg")
	if c.Sky.SetGradient and CreateColor then
		c.Sky:SetGradient("VERTICAL", CreateColor(br, bg, bb, 1), CreateColor(sr, sg, sb, 1))
	else
		c.Sky:SetVertexColor(sr, sg, sb)
	end
	c.Line1:SetVertexColor(rgb("text"))
	c.Line2:SetVertexColor(rgb("textMuted"))
	c.Control:SetVertexColor(rgb("panelAlt"))
	local ar, ag, ab = Theme.Accent()
	c.Button:SetVertexColor(ar, ag, ab, 1)
	c.Bar:SetVertexColor(ar, ag, ab, 1)
	paintOutline(c, Theme.SchemeKey() == c.psValue)
end

local function schemeCard(p)
	local c = CreateFrame("Button", nil, p)
	W.Fill(c, "panelAlt", "BACKGROUND", -6)
	W.Hover(c)
	outline(c)
	local function tex(layer, sub)
		local t = c:CreateTexture(nil, layer, nil, sub)
		t:SetTexture(Theme.Media("white"))
		return t
	end
	-- The preview, inset 1px: the window ground, the sky along its top, the
	-- sidebar with its selection bar, two lines of text, a control and the
	-- primary button.
	c.Ground = tex("BORDER", 0)
	c.Ground:SetPoint("TOPLEFT", c, "TOPLEFT", 1, -1)
	c.Ground:SetPoint("TOPRIGHT", c, "TOPRIGHT", -1, -1)
	c.Ground:SetHeight(PREVIEW_H)
	c.Sky = tex("BORDER", 1)
	c.Sky:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 0, 0)
	c.Sky:SetPoint("TOPRIGHT", c.Ground, "TOPRIGHT", 0, 0)
	c.Sky:SetHeight(24)
	c.Side = tex("BORDER", 2)
	c.Side:SetPoint("TOPLEFT", c.Ground, "TOPLEFT", 0, 0)
	c.Side:SetPoint("BOTTOMLEFT", c.Ground, "BOTTOMLEFT", 0, 0)
	c.Side:SetWidth(20)
	c.Bar = tex("ARTWORK", 0)
	c.Bar:SetSize(2, 8)
	c.Bar:SetPoint("TOPLEFT", c.Side, "TOPLEFT", 0, -16)
	c.Line1 = tex("ARTWORK", 0)
	c.Line1:SetSize(44, 3)
	c.Line1:SetPoint("TOPLEFT", c.Side, "TOPRIGHT", 10, -14)
	c.Line2 = tex("ARTWORK", 0)
	c.Line2:SetSize(30, 3)
	c.Line2:SetPoint("TOPLEFT", c.Line1, "BOTTOMLEFT", 0, -5)
	c.Control = tex("ARTWORK", 0)
	c.Control:SetSize(22, 8)
	c.Control:SetPoint("BOTTOMRIGHT", c.Ground, "BOTTOMRIGHT", -36, 8)
	c.Button = tex("ARTWORK", 0)
	c.Button:SetSize(22, 8)
	c.Button:SetPoint("LEFT", c.Control, "RIGHT", 4, 0)
	c.Name = W.Text(c, "label", "textDim")
	c.Name:SetPoint("TOPLEFT", c.Ground, "BOTTOMLEFT", 10, 0)
	c.Name:SetPoint("TOPRIGHT", c.Ground, "BOTTOMRIGHT", -10, 0)
	c.Name:SetHeight(CARD_NAME_H)
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
	build = function(p, h)
		emblem(h, SIDE_EMBLEM, SIDE_X, SIDE_Y)
		dipper(h, SIDE_X, SIDE_Y, SIDE_EMBLEM / 2 - 5)
		h.Title = para(h, "hero", "text", SIDE_TEXT_W, 2)
		h.Title:SetText(L["Make it yours"])
		h.Sub = para(h, "note", "textDim", SIDE_TEXT_W + 120, 3)
		h.Sub:SetText((L["Start with these choices. Everything else is in %s."]):format(cmd("/polestar options")))

		F.AutoQuest = toggleRow(p, L["Accept and turn in guide quests for me"], "behavior.autoAccept",
			L["Only quests in the next steps of your open guides. Never picks between rewards. Hold Shift to skip."],
			{ get = autoQuestGet, set = autoQuestSet })
		F.AutoGuide = toggleRow(p, L["Load a guide for me when I log in"], "behavior.autoSelectGuide",
			L["Opens the suggested guide when no tab is open."])
		F.SetupRows = { F.AutoQuest, F.AutoGuide }
		if ns.GetDefault("nav.worldTrail") ~= nil then
			F.WorldTrail = toggleRow(p, L["Show a ground trail"], "nav.worldTrail",
				L["Optional sparkles ahead of you along the route. Camera and terrain placement are estimates; off by default. Tune the look in Options, Appearance, Ground trail."])
			F.SetupRows[#F.SetupRows + 1] = F.WorldTrail
		end
		p.SchemeTitle = W.Text(p, "heading", "text")
		p.SchemeTitle:SetText(L["Colour scheme"])
		p.SchemeNote = para(p, "small", "textMuted", CW, 3)
		p.SchemeNote:SetText(L["How deep the night runs. Dusk is the default, Night the darkest, Graphite a neutral grey; EllesmereUI takes its panel colour and accent."])
		F.Schemes = {}
	end,
	layout = function(p, h)
		lowHeroText(h)

		local y = 0
		for _, row in ipairs(F.SetupRows) do
			place(row, -12, y)
			row:Refresh()
			local rh = toggleRowHeight(row)
			row:SetHeight(rh)
			y = y + rh
		end
		y = y + 24
		place(p.SchemeTitle, 0, y)
		y = y + 20
		place(p.SchemeNote, 0, y)
		y = y + p.SchemeNote:GetStringHeight() + 12
		local choices = Theme.SchemeChoices()
		local n = #choices
		local cw = floor((CW - CARD_GAP * (n - 1)) / n)
		for i, ch in ipairs(choices) do
			local c = F.Schemes[i] or schemeCard(p)
			F.Schemes[i] = c
			c.psValue = ch.value
			c.Name:SetText(ch.text)
			c:SetSize(cw, 1 + PREVIEW_H + CARD_NAME_H)
			place(c, (i - 1) * (cw + CARD_GAP), y)
			if not c.psPainted then
				c.psPainted = true
				W.Painter(c, paintCard)
			else
				paintCard(c)
			end
			c:Show()
		end
		for i = n + 1, #F.Schemes do F.Schemes[i]:Hide() end
		return y + 1 + PREVIEW_H + CARD_NAME_H
	end,
	title = function(_, h) return h.Title:GetText() end,
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
local STYLE_PAD = 12
local STYLE_W = floor((CW - CARD_GAP * (#STYLES - 1)) / #STYLES)

-- The style in use: the router reads anything but Fastest or Roads as
-- Balanced, the default.
local function routeStyle()
	local s = ns.Get("nav.routeStyle")
	if s == "fastest" or s == "roads" then return s end
	return "balanced"
end

local function paintStyle(c)
	paintOutline(c, routeStyle() == c.psStyle)
	if c.psChip then W.SetChip(c.psChip, L["Recommended"], "accent") end
end

-- A style's card: its name, what it does under it; the tag rides the top
-- edge. Click sets the style live; right-click puts Balanced back.
local function styleCard(p, st)
	local c = CreateFrame("Button", nil, p)
	W.Fill(c, "panelAlt", "BACKGROUND", -6)
	W.Hover(c)
	outline(c)
	c.psStyle = st[1]
	c.Name = para(c, "label", "textDim", STYLE_W - STYLE_PAD * 2, 2)
	c.Name:SetText(st[2])
	c.Name:SetPoint("TOPLEFT", c, "TOPLEFT", STYLE_PAD, -STYLE_PAD)
	c.Desc = para(c, "note", "textMuted", STYLE_W - STYLE_PAD * 2, 3)
	c.Desc:SetText(st[3])
	c.Desc:SetPoint("TOPLEFT", c.Name, "BOTTOMLEFT", 0, -6)
	if st[4] then
		c.psChip = W.Chip(c)
		c.psChip:SetPoint("BOTTOMRIGHT", c, "TOPRIGHT", -STYLE_PAD, -W.CHIP_H / 2)
	end
	c:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	c:SetScript("OnClick", function(self, button)
		if button == "RightButton" then ns.Set("nav.routeStyle", nil) else ns.Set("nav.routeStyle", self.psStyle) end
	end)
	W.Painter(c, paintStyle)
	return c
end

PAGES[#PAGES + 1] = {
	key = "route",
	shown = function() return full end,
	build = function(p, h)
		emblem(h, SIDE_EMBLEM, SIDE_X, SIDE_Y, "icon-goto")
		dipper(h, SIDE_X, SIDE_Y, SIDE_EMBLEM / 2 - 5)
		h.Title = para(h, "hero", "text", SIDE_TEXT_W, 2)
		h.Title:SetText(L["Route style"])
		h.Sub = para(h, "note", "textDim", SIDE_TEXT_W + 120, 3)
		h.Sub:SetText(L["How the arrow walks you. You can change it any time in Options."])

		F.Styles = {}
		for i, st in ipairs(STYLES) do F.Styles[i] = styleCard(p, st) end
		p.Foot = para(p, "note", "textDim", CW, 3)
		p.Foot:SetText(L["Every style keeps you out of the other faction's towns and away from zones far above your level."])
	end,
	layout = function(p, h)
		lowHeroText(h)
		-- Every card as tall as the tallest; the tag's upper half sits above
		-- the cards.
		local nameH, descH = 0, 0
		for _, c in ipairs(F.Styles) do
			nameH = max(nameH, c.Name:GetStringHeight())
			descH = max(descH, c.Desc:GetStringHeight())
		end
		local y = W.CHIP_H / 2
		local ch = STYLE_PAD + nameH + 6 + descH + STYLE_PAD
		for i, c in ipairs(F.Styles) do
			c:SetSize(STYLE_W, ch)
			place(c, (i - 1) * (STYLE_W + CARD_GAP), y)
			paintStyle(c)
		end
		y = y + ch + 20
		place(p.Foot, 0, y)
		return y + p.Foot:GetStringHeight()
	end,
	title = function(_, h) return h.Title:GetText() end,
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

-- A note under a hairline: a heading, then its lines.
local function note(p, heading, width)
	local n = {}
	n.Rule = W.Divider(p)
	n.Head = W.Text(p, "heading", "text")
	n.Head:SetText(heading)
	n.Text = para(p, "note", "textDim", width or CW)
	return n
end

local LINK_ROOM = 200 -- kept right of the Discord row's text for its link

PAGES[#PAGES + 1] = {
	key = "start",
	build = function(p, h)
		-- The suggested guide's painting fills the hero; without one the
		-- band stands in and the emblem keeps its place on the right.
		h.Art = UI.ZoneArt.Create(h, HERO_W, HERO_H, "bg")
		h.Art.psZoom = 1.5 -- the wide hero shows more of the zone
		h.Art:SetPoint("TOPLEFT", h, "TOPLEFT", 0, 0)
		h.Art.Band:ClearAllPoints() -- the stand-in at its own 1:1 height
		h.Art.Band:SetPoint("TOPLEFT", h.Art, "TOPLEFT", 0, 0)
		h.Art.Band:SetPoint("TOPRIGHT", h.Art, "TOPRIGHT", 0, 0)
		h.Art.Band:SetHeight(BAND_H)
		h.Art.Rule:Hide()
		h.Sky = CreateFrame("Frame", nil, h)
		h.Sky:SetAllPoints(h)
		h.Sky:SetFrameLevel(h.Art.Over:GetFrameLevel() + 1)
		emblem(h.Sky, SIDE_EMBLEM, SIDE_X, SIDE_Y)
		dipper(h.Sky, SIDE_X, SIDE_Y, SIDE_EMBLEM / 2 - 5)
		h.Text = CreateFrame("Frame", nil, h)
		h.Text:SetAllPoints(h)
		h.Text:SetFrameLevel(h.Art.Over:GetFrameLevel() + 2)
		h.Title = onArt(para(h.Text, "hero", "text", CW, 2))
		h.Chip = W.Chip(h.Text)
		h.For = onArt(W.Text(h.Text, "note", "textDim"))
		h.For:SetWordWrap(true) -- a second line where the chip leaves too little room

		p.Pitch = para(p, "body", "textDim", CW)
		p.Beta = note(p, L["Our routes are still in beta"])
		p.Beta.Chip = W.Chip(p)
		p.Beta.Chip:SetPoint("LEFT", p.Beta.Head, "RIGHT", 8, 0)
		p.Discord = note(p, L["Join us on Discord"], CW - 24 - LINK_ROOM)
		p.Discord.Mark = W.Tex(p, "ARTWORK", "discord", "discord")
		p.Discord.Mark:SetSize(16, 16)
		p.Discord.Text:SetSpacing(3)
		Theme.Font(p.Discord.Text, "small")
		W.Color(p.Discord.Text, "textMuted")
		-- The invite as a link (the scheme left off); a click opens the copy
		-- window holding it, since the game cannot open links.
		F.Discord = W.Link(p, (ns.DiscordURL:gsub("^%a+://", "")), function() UI.ShowDiscord() end)
		p.Packs = note(p, L["Community guides"])

		F.Start = W.Button(F.Foot, L["Start guide"], startSuggested, { primary = true })
		F.Browse = W.Button(F.Foot, L["Browse guides"], function()
			close()
			UI.ShowPicker()
		end)
	end,
	layout = function(p, h)
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
		F.CloseScrim:SetShown(painted and current == "start")
		local textW = painted and CW or SIDE_TEXT_W
		h.Title:SetWidth(textW)
		h.Title:SetText(g and g.title or L["Choose your first guide"])
		local lv = g and UI.LevelRange(g.minLevel, g.maxLevel)
		local chipW = 0
		if lv then
			chipW = W.SetChip(h.Chip, L["Levels"] .. " " .. lv, "accent") + 8
		else
			h.Chip:Hide()
		end
		h.For:SetText(g and forWhom(g) or L["Polestar has no guide to suggest for where you are."])
		h.For:SetWidth(min(W.TextWidth(h.For) + 1, (painted and CW or SIDE_TEXT_W + 120) - chipW))
		local factY = HERO_H - 20 - W.CHIP_H
		h.Chip:ClearAllPoints()
		h.Chip:SetPoint("TOPLEFT", h.Text, "TOPLEFT", EDGE, -factY)
		h.For:ClearAllPoints()
		h.For:SetPoint("LEFT", h.Text, "TOPLEFT", EDGE + chipW, -(factY + W.CHIP_H / 2))
		-- Centred on the chip, a wrapped line reaches above it: the title
		-- keeps its 10px over whichever is higher.
		local lift = max(0, (h.For:GetStringHeight() - W.CHIP_H) / 2)
		h.Title:ClearAllPoints()
		h.Title:SetPoint("TOPLEFT", h.Text, "TOPLEFT", EDGE, -(factY - lift - 10 - h.Title:GetStringHeight()))

		-- The page: the pitch, then notes under hairlines.
		local y = 0
		local pitch = g and known(g.pitch)
		p.Pitch:SetShown(pitch ~= nil)
		if pitch then
			p.Pitch:SetText(pitch)
			place(p.Pitch, 0, 0)
			y = p.Pitch:GetStringHeight() + 20
		end
		local function lay(n, shown, extra)
			n.Rule:SetShown(shown)
			n.Head:SetShown(shown)
			n.Text:SetShown(shown)
			if not shown then return end
			if y > 0 then
				n.Rule:ClearAllPoints()
				n.Rule:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -y)
				n.Rule:SetPoint("TOPRIGHT", p, "TOPRIGHT", 0, -y)
				y = y + 16
			else
				n.Rule:Hide()
			end
			-- A mark leads its heading: 8px before it, centred on its line.
			local x = n.Mark and 24 or 0
			place(n.Head, x, y)
			if n.Mark then
				n.Mark:ClearAllPoints()
				n.Mark:SetPoint("RIGHT", n.Head, "LEFT", -8, 0)
			end
			place(n.Text, x, y + 22)
			local hgt = max(22 + n.Text:GetStringHeight(), extra or 0)
			n.psY, n.psH = y, hgt
			y = y + hgt + 16
		end
		local beta = ns.routesBeta and true or false
		p.Beta.Text:SetText((L["Planned in a simulator and played to the end in tests, but nobody has followed them through the live game yet. Skip a wrong step with %s and tell us on Discord."]):format(cmd("/polestar skip")))
		lay(p.Beta, beta)
		if beta then W.SetChip(p.Beta.Chip, string.upper(L["Beta"]), "warning") else p.Beta.Chip:Hide() end
		p.Discord.Text:SetText(L["Feedback, bug reports and news"])
		lay(p.Discord, true)
		F.Discord:ClearAllPoints()
		F.Discord:SetPoint("RIGHT", p, "TOPRIGHT", 0, -(p.Discord.psY + p.Discord.psH / 2))
		p.Packs.Text:SetText((L["Guides made by other players for Polestar, not our own routes: each community addon is installed like any other addon. Its guides appear in %s under Community guides, credited to their author, who supports them. More in Options > Community guides."]):format(cmd("/polestar guides")))
		lay(p.Packs, true)
		W.SetButtonText(F.Start, g and L["Start guide"] or L["Choose a guide"])
		return y - 16
	end,
	title = function(_, h) return h.Title:GetText() end,
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
local function settle(h)
	Anim.Anchor(h, "TOPLEFT", F.HeroArea, "TOPLEFT", 0, 0)
	Anim.To(h, "alpha", 0, 1, Anim.BASE, "out")
	Anim.To(h, "offset", -8, 0, Anim.BASE, "out")
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

	-- The hero: the night sky, each page's content over it, the ✕; dragged
	-- by it.
	local hero = CreateFrame("Frame", nil, F)
	hero:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	hero:SetSize(HERO_W, HERO_H)
	if hero.SetClipsChildren then hero:SetClipsChildren(true) end
	hero:EnableMouse(true)
	hero:RegisterForDrag("LeftButton")
	hero:SetScript("OnDragStart", function() F:StartMoving() end)
	hero:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	F.HeroArea = hero
	F.Band = Theme.Band(hero, "BACKGROUND", -5)
	F.Band:SetPoint("TOPLEFT", hero, "TOPLEFT", 0, 0)
	F.Band:SetPoint("TOPRIGHT", hero, "TOPRIGHT", 0, 0)
	F.Band:SetHeight(BAND_H)
	F.Band:SetTexCoord(Theme.BandCoords(HERO_W, BAND_H))
	local top = CreateFrame("Frame", nil, hero)
	top:SetAllPoints(hero)
	top:SetFrameLevel(hero:GetFrameLevel() + 20)
	F.Close = W.IconButton(top, "close", 28, L["Close"], close, 14)
	F.Close:SetPoint("TOPRIGHT", hero, "TOPRIGHT", -12, -12)
	-- On a bright painting the ✕ needs a dark ground of its own.
	F.CloseScrim = W.Pill(top, 32, 32)
	F.CloseScrim:SetPoint("CENTER", F.Close, "CENTER", 0, 0)
	W.Painter(F.CloseScrim, function(s) local r, g, b = Theme.Color("scrim"); s:SetColor(r, g, b, 0.6) end)
	F.CloseScrim:SetFrameLevel(top:GetFrameLevel())
	F.Close:SetFrameLevel(top:GetFrameLevel() + 2)
	F.CloseScrim:Hide()

	-- The footer: Skip (or Back on the last page) left, the step dots in the
	-- middle, Back and Next (Browse guides and Start guide on the last page)
	-- on the right.
	local foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(FOOT_H)
	W.Fill(foot, "footer")
	local rule = W.Divider(foot)
	rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	F.Foot = foot
	F.Skip = W.Button(foot, L["Skip"], close, { ghost = true })
	F.Skip:SetPoint("LEFT", foot, "LEFT", PAD - 1, 0)
	F.Next = W.Button(foot, L["Next"], function() go(1) end, { primary = true })
	F.Next:SetPoint("RIGHT", foot, "RIGHT", -(PAD - 1), 0)
	F.Back = W.Button(foot, L["Back"], function() go(-1) end)
	F.Dots = CreateFrame("Frame", nil, foot)
	F.Dots:SetHeight(DOT)
	F.Dots:SetPoint("CENTER", foot, "CENTER", 0, 0)
	F.Dots.list = {}

	-- The pages: under the hero on the 32 edge, and their hero content.
	F.Body = CreateFrame("Frame", nil, F)
	F.Body:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -BODY_Y)
	F.Body:SetWidth(CW)
	F.pages = {}
	for _, pg in ipairs(PAGES) do
		local p = CreateFrame("Frame", nil, F.Body)
		p:SetPoint("TOPLEFT", F.Body, "TOPLEFT", 0, 0)
		p:SetWidth(CW)
		p:Hide()
		local h = CreateFrame("Frame", nil, hero)
		h:SetSize(HERO_W, HERO_H)
		Anim.Anchor(h, "TOPLEFT", hero, "TOPLEFT", 0, 0)
		h:SetFrameLevel(hero:GetFrameLevel() + 2)
		h:Hide()
		p.Hero, p.psKey, h.psKey = h, pg.key, pg.key
		pg.build(p, h)
		F.pages[pg.key] = p
	end
	F.Start:SetPoint("RIGHT", foot, "RIGHT", -(PAD - 1), 0)
	F.Browse:SetPoint("RIGHT", F.Start, "LEFT", -8, 0)

	F:SetScript("OnShow", function(self)
		Anim.To(self, "alpha", 0, 1, Anim.BASE, "out")
		settle(F.pages[current].Hero)
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
				for i, w in ipairs(rows) do if w == F.Next then return i end end
			end,
			prevTab = function() go(-1) end,
			nextTab = function()
				local _, at, count = WEL.Page()
				if at and count and at < count then go(1) end
			end,
			tabsLabel = L["Pages"],
			-- A colour scheme's or a route style's card: Y puts the default
			-- (Dusk, Balanced) back.
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

-- The step dots: the current one a 16x4 accent capsule, the others 4px dots.
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
			if on then d:SetColor(Theme.Accent()) else d:SetColor(Theme.Color("textMuted")) end
			local w = on and DOT_ON or DOT
			if animate and d.psW and d.psW ~= w then
				Anim.To(d, "width", d.psW, w, Anim.FAST, "out")
			else
				d:SetWidth(w)
			end
			d.psW, d.psOn = w, on
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
-- current one; `from`: the page left, cross-faded out.
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
		local p = F.pages[pg.key]
		local h = pg.layout(p, p.Hero)
		p:SetHeight(h)
		tallest = max(tallest, h)
	end
	F.Body:SetHeight(tallest)
	-- A shorter page sits in the middle of the room the tallest makes, a
	-- little above centre, so it reads composed rather than cut short.
	for _, pg in ipairs(list) do
		local p = F.pages[pg.key]
		p:ClearAllPoints()
		p:SetPoint("TOPLEFT", F.Body, "TOPLEFT", 0, -floor((tallest - p:GetHeight()) * 0.45))
	end
	F:SetHeight(1 + BODY_Y + tallest + 32 + FOOT_H + 1)

	local animate = from ~= nil and F:IsShown()
	for key, p in pairs(F.pages) do
		local h = p.Hero
		if key == current then
			p:Show()
			h:Show()
			if animate then
				Anim.To(p, "alpha", 0, 1, Anim.FAST, "out")
				Anim.To(h, "alpha", 0, 1, Anim.FAST, "out")
			else
				p:SetAlpha(1)
				h:SetAlpha(1)
			end
		elseif animate and key == from then
			local function gone(o) if o.psKey ~= current then o:Hide() end end
			Anim.To(p, "alpha", p:GetAlpha(), 0, Anim.FAST, "out", gone)
			Anim.To(h, "alpha", h:GetAlpha(), 0, Anim.FAST, "out", gone)
		else
			p:Hide()
			h:Hide()
		end
	end
	F.CloseScrim:SetShown(current == "start" and F.pages.start.Hero.psPainted or false)

	local last = at == #list
	paintDots(at, #list, animate)
	F.Skip:SetShown(not last)
	F.Next:SetShown(not last)
	F.Start:SetShown(last)
	F.Browse:SetShown(last)
	-- Back sits beside Next; on the last page it takes Skip's place, so the
	-- two guide buttons keep the right.
	F.Back:SetShown(at > 1)
	F.Back:ClearAllPoints()
	if last then
		F.Back:SetPoint("LEFT", F.Foot, "LEFT", PAD - 1, 0)
	else
		F.Back:SetPoint("RIGHT", F.Next, "LEFT", -8, 0)
	end
	-- The dots stay centred unless the buttons come within 16px; then they
	-- centre in the room between them.
	local inset = PAD - 1
	local leftW = (last and F.Back or F.Skip):GetWidth()
	local rightW = last and (F.Start:GetWidth() + 8 + F.Browse:GetWidth())
		or (F.Next:GetWidth() + (at > 1 and (8 + F.Back:GetWidth()) or 0))
	local lo, hi = inset + leftW + 16, HERO_W - inset - rightW - 16
	local dw, mid = F.Dots:GetWidth(), HERO_W / 2
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
		if pg.key == current then
			local p = F.pages[current]
			title = pg.title(p, p.Hero)
		end
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
-- style set anywhere (the cards, Options) moves the cards' pick. A scheme
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
