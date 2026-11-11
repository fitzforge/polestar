-- How the guide window looks: the transparent style and the skins
-- (UI/GuideFrame.lua).

local ADDON, ns = ...
local UI, Theme, W, Anim, max, min = ns.UI, ns.Theme, ns.Widgets, ns.Anim, math.max, math.min
local GF = UI.GuideFrame
local transparent, placeCheck, CARD, twoLines, rows = GF.Transparent, GF.PlaceCheck, GF.CARD, GF.TwoLines, GF.rows
local tabButtons, lines, texts, chrome = GF.tabs, GF.lines, GF.texts, GF.chrome

-- The window's parts and sizes, handed over by the core (GF.Bind).
local F, strip, nav, card, person, after, upnext, grip, band, banner
local foot
local PAD, TAB_H, NAV_H, PROG_H, ICON, TEXT_X, CHECK, ROW_PAD, UP_TOGGLE
GF.Bind(function(p, m)
	F, strip, nav, card, person, after, upnext, grip = p.F, p.strip, p.nav, p.card, p.person, p.after, p.upnext, p.grip
	band, banner, foot = p.band, p.banner, p.foot
	PAD, TAB_H, NAV_H, PROG_H, ICON, TEXT_X, CHECK, ROW_PAD = m.PAD, m.TAB_H, m.NAV_H, m.PROG_H, m.ICON, m.TEXT_X, m.CHECK, m.ROW_PAD
	UP_TOGGLE = m.UP_TOGGLE
end)

---------------------------------------------------------------------------
-- Transparent mode: chrome on hover
---------------------------------------------------------------------------

local watcher = CreateFrame("Frame")
local hovering = false

-- ui.barShown keeps a transparent window's tabs and step bar on screen (not the grip).
local function chromeAlpha(c)
	if not transparent() or hovering then return 1 end
	return (ns.Get("ui.barShown") and c ~= grip) and 1 or 0
end

local function fadeChrome(to)
	for i = 1, #chrome do
		local c = chrome[i]
		if to == 1 then
			Anim.To(c, "alpha", c:GetAlpha(), 1, Anim.FAST, "out")
		else
			Anim.To(c, "alpha", c:GetAlpha(), chromeAlpha(c), Anim.BASE, "out")
		end
	end
end

local function watch()
	if F:IsMouseOver(4, -4, -4, 4) then return end
	hovering = false
	watcher:SetScript("OnUpdate", nil)
	if transparent() then fadeChrome(0) end
end

-- The cursor reached the window (or one of its parts).
function GF.HoverIn()
	if not F or hovering then return end
	hovering = true
	if transparent() then
		fadeChrome(1)
		watcher:SetScript("OnUpdate", ns.Safe(watch))
	end
end

function GF.IsHovering() return hovering end

-- The guide's progress track: the house wash on the night ground; over the
-- world (transparent) a stronger ink line, so the fill still reads as a
-- share of a whole.
local function paintTrack(t)
	local r, g, b, a = Theme.Wash("progress")
	t:SetVertexColor(r, g, b, transparent() and 0.15 or a)
end

-- The transparent style's backing (ui.backing). "dark": a scrim with no edge
-- behind the body (GF.veil) and one behind the tabs and the navigator
-- (band.Veil) that comes and goes with them, at GF.VEIL; both feather over
-- GF.VEIL_FEATHER and cross-fade where they meet (placeBars), so the shown
-- bar never leaves a seam. "soft" (the default): no box, only a light shade
-- behind each string on screen (GF.PaintShades), the world showing between
-- and around the lines. "none": the outlined text alone on the world.
GF.VEIL = { dark = 0.68 }
GF.VEIL_FEATHER = 20
function GF.Backing()
	return transparent() and GF.VEIL[ns.Get("ui.backing")] or nil
end
function GF.PaintVeil(s)
	Theme.PaintScrim(s, GF.Backing() or 0)
end

-- The soft backing: Theme.TextShade behind each string (on its parent, under
-- it), its solid middle the text's own size at GF.SHADE and feathering out
-- over GF.SHADE_FEATHER: wide to the sides, short above and below (inside
-- the gap to the next line, clear of the scrolling goals' clipped edges).
-- Sized again on a layout and, a frame
-- later (GF.QueueShades: one OnUpdate, then none), when a string's text,
-- width or shown state changes; a string's own alpha (the chrome's fade, a
-- dimmed label) carries to its shade. GF.shades: string -> its shade.
-- The string's alpha goes into the shade's vertex colour (GF.SHADE * alpha),
-- never through SetAlpha: in the client a texture's alpha IS its vertex
-- colour's alpha, so SetAlpha(1) on the parts drew them at full strength,
-- a black box behind every line (#1684).
GF.SHADE = 0.2
GF.SHADE_FEATHER = { x = 30, y = 12 }
GF.SHADE_INSET = { x = 10, y = 6 }
GF.shades, GF.shadeHooked = {}, {}
GF.shadeFrame = CreateFrame("Frame")
function GF.SoftShade() return transparent() and ns.Get("ui.backing") == "soft" end

function GF.ShadeText(fs, on)
	local s = GF.shades[fs]
	local text = fs:GetText()
	if not (on and fs:IsShown() and text and text ~= "") then
		if s and s.shown then
			s.shown = false
			for _, p in ipairs(s.parts) do p:Hide() end
		end
		return
	end
	if not s then
		s = Theme.TextShade(fs:GetParent(), GF.SHADE_FEATHER.x, GF.SHADE_FEATHER.y)
		GF.shades[fs] = s
	end
	-- The solid middle is the text less GF.SHADE_INSET on each side: the rise
	-- begins inside the text, so no edge of the shade shows as a line.
	local w, fw = fs:GetStringWidth(), fs:GetWidth()
	if fw and fw > 0 then w = min(w, fw) end
	local ix, iy = GF.SHADE_INSET.x, GF.SHADE_INSET.y
	local m = s.parts[1]
	m:ClearAllPoints()
	m:SetSize(max(1, w - 2 * ix), max(1, fs:GetStringHeight() - 2 * iy))
	local jh = fs.GetJustifyH and fs:GetJustifyH()
	local jv = fs.GetJustifyV and fs:GetJustifyV()
	local x = (jh == "RIGHT" and "RIGHT") or (jh == "CENTER" and "") or "LEFT"
	local y = (jv == "TOP" and "TOP") or (jv == "BOTTOM" and "BOTTOM") or ""
	local point = (y .. x ~= "") and (y .. x) or "CENTER"
	m:SetPoint(point, fs, point, x == "LEFT" and ix or x == "RIGHT" and -ix or 0, y == "TOP" and -iy or y == "BOTTOM" and iy or 0)
	local a = fs:GetAlpha() or 1
	Theme.PaintScrim(s, GF.SHADE * a)
	s.shown = true
	for _, p in ipairs(s.parts) do p:Show() end
end

function GF.QueueShades()
	if GF.shadesQueued or not (GF.shadesOn or GF.SoftShade()) then return end
	GF.shadesQueued = true
	GF.shadeFrame:SetScript("OnUpdate", function(self)
		self:SetScript("OnUpdate", nil)
		GF.shadesQueued = nil
		GF.PaintShades()
	end)
end

function GF.ShadeAlpha(fs, a)
	local s = GF.shades[fs]
	if s and s.shown then Theme.PaintScrim(s, GF.SHADE * (a or 1)) end
end

function GF.PaintShades()
	local on = GF.SoftShade()
	if not (on or GF.shadesOn) then return end
	GF.shadesOn = on
	for i = 1, #texts do
		local fs = texts[i]
		if on and not GF.shadeHooked[fs] then
			GF.shadeHooked[fs] = true
			for _, m in ipairs({ "SetText", "SetFormattedText", "SetWidth", "Show", "Hide", "SetShown" }) do
				if fs[m] then hooksecurefunc(fs, m, GF.QueueShades) end
			end
			hooksecurefunc(fs, "SetAlpha", GF.ShadeAlpha)
		end
		GF.ShadeText(fs, on)
	end
end

-- The ground's opacity is Theme.GroundAlpha (ui.bgOpacity), read by the
-- window skin itself; ui.bgOpacity changes land here to repaint it.
function GF.ApplyStyle()
	if not F then return end
	local clear = transparent()
	F.psBare = clear
	Theme.Repaint(F)
	local skin = Theme.SkinKey()
	band:SetShown(not clear and skin == "polestar")
	local backing = GF.Backing() and true or false
	GF.veil:SetShown(backing)
	band.Veil:SetShown(backing)
	W.Painter(GF.veil, GF.PaintVeil)
	W.Painter(band.Veil, GF.PaintVeil)
	nav.TitleBar:SetShown(not clear and skin == "hearth")
	-- Blizzard's damage meter header bar under the tabs.
	Theme.KitStrip(strip, not clear)
	-- The quest tracker's header behind the focus (Forever, Blizzard).
	Theme.KitHeader(person, not clear)
	strip.Rule:SetShown(not clear)
	nav.Rule:SetShown(not clear)
	W.Painter(foot.Line.Track, paintTrack)
	if GF.here then W.Painter(GF.here.Panel, GF.PaintHerePanel) end
	for i = 1, #texts do Theme.SetOutline(texts[i], clear) end
	-- Tick boxes on the world: a scrim inside and an ink edge.
	for _, r in ipairs(rows) do
		r.Check.psOnWorld = clear
		Theme.Repaint(r.Check)
	end
	if not clear then
		watcher:SetScript("OnUpdate", nil)
		hovering = false
	end
	for i = 1, #chrome do
		Anim.Stop(chrome[i], "alpha")
		chrome[i]:SetAlpha(chromeAlpha(chrome[i]))
	end
	GF.Layout()
end

---------------------------------------------------------------------------
-- Skins (Polestar.Theme, "Skins"): Halo and Blizzard take the handoff's
-- sizes (DIRECTION_B_HALO.md §3) and their own parts: Halo's gold rule under
-- the navigator, Blizzard's title bar, framed tabs and the game's status bar.
---------------------------------------------------------------------------

local skinShown

-- Hearth's tab: framed, gold on the active one (DIRECTION_A_BLIZZARD.md §3);
-- the game's looks: their kit's tab art.
function GF.PaintTab(b)
	local kit = Theme.KitTab(b, b.psActive, nil, true)
	local bliz = Theme.SkinKey() == "hearth"
	local f = rawget(b, "psFrameTex")
	if bliz and not f then
		f = b:CreateTexture(nil, "BACKGROUND", nil, -7)
		f:SetTexture(Theme.Media("white"))
		b.psFrameTex = f
	end
	if f then
		f:SetShown(bliz)
		f:ClearAllPoints()
		f:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 0)
		f:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", 0, 0)
		f:SetHeight(b.psActive and 24 or 21)
		local top = b.psActive and { 0.231, 0.176, 0.078 } or { 0.122, 0.094, 0.047 }
		local bottom = b.psActive and { 0.09, 0.067, 0.039 } or { 0.051, 0.039, 0.02 }
		if f.SetGradient and CreateColor then
			f:SetGradient("VERTICAL", CreateColor(bottom[1], bottom[2], bottom[3], 1), CreateColor(top[1], top[2], top[3], 1))
		else
			f:SetVertexColor(top[1], top[2], top[3], 1)
		end
	end
	if bliz or kit then
		b.Selected:Hide()
		b.Bar:Hide()
		W.Color(b.Label, b.psActive and "title" or "tabRest")
	end
end

-- The progress bar: the house and Halo's slim line with its percent right of
-- it, or Blizzard's game status bar (Interface\TargetingFrame\UI-StatusBar),
-- 14 high, the percent centred in it.
local STATUS_BAR = "Interface\\TargetingFrame\\UI-StatusBar"
local function footBar()
	local b = rawget(foot, "Status")
	if b then return b end
	b = CreateFrame("StatusBar", nil, foot)
	b:SetStatusBarTexture(STATUS_BAR)
	b:SetMinMaxValues(0, 1)
	b.Bg = b:CreateTexture(nil, "BACKGROUND")
	b.Bg:SetTexture(Theme.Media("white"))
	b.Bg:SetAllPoints(b)
	b.Bg:SetVertexColor(0, 0, 0, 0.75)
	Theme.Border(b, 0.42, 0.329, 0.125, 1)
	b.Pct = b:CreateFontString(nil, "OVERLAY")
	Theme.Font(b.Pct, "small")
	b.Pct:SetPoint("CENTER", b, "CENTER", 0, 0)
	b.Pct:SetTextColor(1, 1, 1, 1)
	foot.Status = b
	return b
end

-- Fill Blizzard's bar (GF.Layout sets the house line; this follows it).
function GF.PaintStatus(frac, pctText)
	local b = rawget(foot, "Status")
	if not b or not b:IsShown() then return end
	b:SetValue(frac or 0)
	local t = b:GetStatusBarTexture()
	if Theme.Kit() then
		-- The game's looks colour their own fill (Theme.KitStatus).
	elseif t and t.SetGradient and CreateColor then
		t:SetGradient("VERTICAL", CreateColor(0.478, 0.345, 0, 1), CreateColor(0.91, 0.722, 0, 1))
	elseif t then
		t:SetVertexColor(0.91, 0.722, 0, 1)
	end
	b.Pct:SetText(pctText or "")
end

function GF.ApplySkin()
	if not F then return end
	GF.ReadMetrics()
	local skin = Theme.SkinKey()
	skinShown = skin
	F.psGuide = true
	Theme.Repaint(F)
	strip:SetHeight(TAB_H)
	nav:SetHeight(NAV_H)
	foot:SetHeight(PROG_H)
	-- The navigator: ‹ › and the icon buttons at the skin's sizes.
	local nb, ni = Theme.Metric("guideNavBtn", 24), Theme.Metric("guideNavIcon", 14)
	for _, b in ipairs({ nav.Prev, nav.Next }) do
		b:SetSize(nb, nb)
		b.Icon:SetSize(ni, ni)
		W.SetFramed(b, "red")
	end
	-- Room between ‹ › and "28 / 36": Halo's 2, Blizzard's framed squares 4.
	local gap = Theme.Metric("guideNavGap", 0)
	nav.Steps.Count:SetPoint("LEFT", nav.Prev, "RIGHT", gap, 0)
	nav.Next:SetPoint("LEFT", nav.Steps.Count, "RIGHT", gap, 0)
	local iw, ih, ig = Theme.Metric("guideIconBtnW", 24), Theme.Metric("guideIconBtnH", 24), Theme.Metric("guideIcon", 14)
	-- The icon buttons right of Skip share the skin's sizes.
	for _, key in ipairs({ "Menu", "Lookup", "Report", "Nearby" }) do
		local b = rawget(nav, key)
		if b then
			b:SetSize(iw, ih)
			b.Icon:SetSize(ig, ig)
			W.SetFramed(b, "icon")
		end
	end
	nav.Skip:SetHeight(nb)
	nav.Steps:SetHeight(nb)
	nav.Steps:SetPoint("LEFT", nav, "LEFT", PAD - 6, 0)
	-- Rules: Halo's gold one under the navigator; Hearth's title bar line; the
	-- game's looks their separator.
	W.Painter(nav.Rule, function(t)
		local k = Theme.SkinKey()
		if k == "halo" then
			t:SetVertexColor(Theme.Color("accentLine"))
		elseif k == "hearth" then
			t:SetVertexColor(Theme.Color("titleLine"))
		elseif Theme.Kit() then
			t:SetVertexColor(Theme.Color("separator"))
		else
			t:SetVertexColor(Theme.Wash("divider"))
		end
		t:SetHeight(Theme.Pixel(nav))
	end)
	-- Hearth: the person's name over a gold separator.
	person.Rule:SetShown(skin == "hearth")
	-- The focus parts at the skin's paddings.
	person.Icon:SetPoint("TOPLEFT", person, "TOPLEFT", PAD - 1, -11)
	person.Name:SetPoint("TOPLEFT", person, "TOPLEFT", TEXT_X, -10)
	card.Tip.Text:SetPoint("TOPLEFT", card.Tip, "TOPLEFT", TEXT_X, -6)
	card.Tip.Toggle:SetPoint("TOPLEFT", card.Tip, "TOPLEFT", PAD - 2, -3)
	for _, part in ipairs({ after, upnext.Toggle, GF.xp }) do
		part.Rule:SetPoint("TOPLEFT", part, "TOPLEFT", PAD, 0)
		part.Rule:SetPoint("TOPRIGHT", part, "TOPRIGHT", -PAD, 0)
	end
	after.Text:SetPoint("LEFT", after, "LEFT", PAD, 0)
	after.Count:SetPoint("RIGHT", after, "RIGHT", -PAD, 0)
	upnext.Toggle:SetHeight(UP_TOGGLE)
	upnext.Toggle.Label:SetPoint("LEFT", upnext.Toggle, "LEFT", PAD, 0)
	upnext.Toggle.Icon:SetPoint("RIGHT", upnext.Toggle, "RIGHT", -PAD, 0)
	GF.xp.Icon:SetPoint("LEFT", GF.xp, "LEFT", PAD, GF.xp.psRest and GF.XPROW.iconY or -1)
	GF.party.Icon:SetPoint("LEFT", GF.party, "LEFT", PAD, -1)
	banner.Icon:SetPoint("TOPLEFT", banner, "TOPLEFT", PAD, -10)
	banner.Text:SetPoint("TOPLEFT", banner, "TOPLEFT", PAD + 21, -9)
	for _, l in ipairs(lines) do
		local lh = CARD.lineH
		l.Icon:SetPoint("CENTER", l, "TOPLEFT", PAD + ICON / 2, -lh / 2)
		l.Text:SetPoint("TOPLEFT", l, "TOPLEFT", TEXT_X, -twoLines(l.Text, lh))
		l.Chevron:SetPoint("CENTER", l, "TOPRIGHT", -PAD - 5, -lh / 2)
	end
	for _, r in ipairs(rows) do
		r.Icon:SetPoint("CENTER", r, "TOPLEFT", PAD + ICON / 2, -12 - ROW_PAD)
		r.Text:SetPoint("TOPLEFT", r, "TOPLEFT", TEXT_X, -4 - ROW_PAD)
		r.Check:SetSize(CHECK, CHECK)
		placeCheck(r)
		Theme.Repaint(r.Check)
	end
	-- The progress bar: the game's status bar in Hearth and the game's looks.
	local bliz = Theme.GameSkin()
	foot.Line:SetHeight(3)
	foot.Line:SetPoint("LEFT", foot, "LEFT", PAD, 0)
	foot.Pct:SetPoint("RIGHT", foot, "RIGHT", -PAD, 0)
	foot.Line:SetShown(not bliz)
	foot.Pct:SetShown(not bliz)
	if bliz then
		local b = footBar()
		b:ClearAllPoints()
		local inset = Theme.Kit() and 10 or 0
		b:SetPoint("LEFT", foot, "LEFT", PAD + inset, 0)
		b:SetPoint("RIGHT", foot, "RIGHT", -PAD - inset, 0)
		b:SetHeight(Theme.Kit() and 12 or 14)
		b:Show()
		if Theme.KitStatus(b) then
			b.psKitDrawn = true
		elseif b.psKitDrawn then
			-- Back from a game look: Hearth's bar as footBar made it.
			b:SetStatusBarTexture(STATUS_BAR)
			b:GetStatusBarTexture():SetTexCoord(0, 1, 0, 1)
			b.Bg:SetTexture(Theme.Media("white"))
			b.Bg:SetTexCoord(0, 1, 0, 1)
			b.Bg:SetVertexColor(0, 0, 0, 0.75)
			Theme.Border(b, 0.42, 0.329, 0.125, 1)
			b.psKitDrawn = nil
		end
	elseif rawget(foot, "Status") then
		foot.Status:Hide()
	end
	-- The tabs, painted again in the skin.
	for _, b in ipairs(tabButtons) do
		b:SetHeight(TAB_H)
		GF.PaintTab(b)
	end
end

-- A skin chosen while the window shows: its sizes, then a fresh layout.
Theme.OnChanged(function()
	if F and skinShown and skinShown ~= Theme.SkinKey() then
		GF.ApplySkin()
		GF.ApplyStyle()
	end
end)
