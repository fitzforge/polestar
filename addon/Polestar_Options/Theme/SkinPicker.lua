-- The skin picker's side of the Skin API (docs/skins), loaded with the
-- settings window: the picture cards of the skins and schemes (the Theme
-- page's picker, UI/Looks/Theme.lua) and a skin's preset, applied and undone
-- on the player's word. Registration, the palettes and the hooks stay in
-- Polestar itself (Theme/SkinApi.lua, Theme/Theme.lua), whose internals this
-- reads through Polestar.ThemeInternal.

local ns = Polestar
local Theme = ns.Theme
local I = ns.ThemeInternal
if not (Theme and I) then return end
local RIVALS, SCHEMES, SKINS = I.RIVALS, I.SCHEMES, I.SKINS
local batch, previewing, resolve, variantOf = I.batch, I.previewing, I.resolve, I.variantOf
local ipairs, pairs, type = ipairs, pairs, type

---------------------------------------------------------------------------
-- Presets
---------------------------------------------------------------------------

-- A skin's preset (spec.preset): the settings it recommends, as a copy, or
-- nil. Never applied by itself: the player applies it (the Theme page's
-- "Apply <skin>'s layout") and may undo it.
local function copyValue(v)
	if type(v) ~= "table" then return v end
	local c = {}
	for k, x in pairs(v) do c[k] = x end
	return c
end

-- A registered skin's preset with its variant's over it (spec.variants[i].preset).
local function presetOf(s)
	local v = s.variants and s.variantBy[variantOf(s)]
	if not (v and v.preset) then return s.preset end
	local out = {}
	for path, x in pairs(s.preset or {}) do out[path] = x end
	for path, x in pairs(v.preset) do out[path] = x end
	return out
end

function Theme.SkinPreset(id)
	local s = SKINS[id]
	local preset = s and presetOf(s)
	if not preset then return nil end
	local out = {}
	for path, v in pairs(preset) do out[path] = copyValue(v) end
	return out
end

-- The settings an applied preset changed, as they were before: one level of
-- undo for the session (a reload forgets it; the profiles keep a copy).
local presetUndo -- { id = skin id, values = { [path] = value before } }

-- Apply skin `id`'s preset through ns.Set (so each setting fires its own
-- change and a value equal to its default is not stored), remembering what
-- each setting (and the colour sources it turns off) was. Applying another
-- preset before undoing keeps the oldest values, so Undo goes back to before
-- the first. -> ok, why
function Theme.ApplySkinPreset(id)
	local s = SKINS[id]
	if not s then return false, "no such skin" end
	local preset = presetOf(s)
	if not preset then return false, "this skin has no preset" end
	local undo = presetUndo or { values = {} }
	local function remember(path)
		if undo.values[path] == nil then
			local v = ns.Get(path)
			undo.values[path] = v == nil and false or copyValue(v)
		end
	end
	for path in pairs(preset) do
		remember(path)
		for _, rival in ipairs(RIVALS[path] or {}) do remember(rival) end
	end
	undo.id = id
	presetUndo = undo
	local ok, err = batch(function()
		for path, v in pairs(preset) do ns.Set(path, copyValue(v)) end
	end)
	if not ok then
		if ns.NoteError then ns.NoteError(err) end
		return false, tostring(err)
	end
	return true
end

-- The skin whose preset Undo would take back, or nil.
function Theme.SkinPresetApplied()
	return presetUndo and presetUndo.id or nil
end

-- Put back every setting the last applied preset(s) changed. -> ok
function Theme.UndoSkinPreset()
	local undo = presetUndo
	if not undo then return false end
	presetUndo = nil
	local ok, err = batch(function()
		for path, v in pairs(undo.values) do ns.Set(path, copyValue(v)) end
	end)
	if not ok and ns.NoteError then ns.NoteError(err) end
	return ok
end

---------------------------------------------------------------------------
-- The picker's cards
---------------------------------------------------------------------------

-- A card is a small picture of a skin as it draws itself: a guide window
-- (its paint and band, a tab, the step bar, the person to talk to, two goals
-- with their tick boxes, the progress) beside the arrow, built here as the
-- window builds its own (UI/GuideFrame*.lua) and painted by that skin's own
-- painters, sizes, palette, fonts and media while the Theme answers for it
-- (I.drawing), whatever skin is in use; the game's looks draw the client's
-- own art there as on the window. Under the arrow the skin's accent, with
-- its own second accent and glow (what tells its variants apart). The live
-- skin is left alone; a skin's hooks are for its live surfaces and stay off
-- the cards. Nothing on a card is kept for the live repaint: the cards
-- paint themselves again after it (Theme.OnChanged).
local L, Nav, UI = ns.L, ns.Nav, ns.UI
local Arrow = Nav and Nav.arrow
local drawing, paint, paintFont = I.drawing, I.paint, I.paintFont
local floor, max, min = math.floor, math.max, math.min
local STATUS_BAR = "Interface\\TargetingFrame\\UI-StatusBar"
-- The window's width in its own units (drawn at the card's scale; its height
-- follows the skin's sizes), its person's header, its step's progress.
local WIN_W, PERSON_H, DONE = 236, 44, 8 / 29
-- The step: the guide window page's demo (UI/Looks/GuideWindow.lua), its
-- first two goals.
local GOALS = {
	{ t = "kill", status = "done", verb = L["Kill"], subject = L["Kobold Vermin"], subjectKind = "npc", progress = { cur = 10, max = 10 } },
	{ t = "kill", status = "active", verb = L["Kill"], subject = L["Kobold Worker"], subjectKind = "npc", progress = { cur = 3, max = 8 },
		current = true },
}

local function text(parent, justify)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	fs:SetWordWrap(false)
	fs:SetJustifyH(justify or "LEFT")
	return fs
end

local function tex(parent, layer, sub, media)
	local t = parent:CreateTexture(nil, layer, nil, sub)
	t:SetTexture(Theme.Media(media or "white"))
	return t
end

-- A string's text, then its role's face in the skin and its colour.
local function say(fs, role, s, token)
	fs:SetText(s)
	paintFont(fs, role)
	fs:SetTextColor(Theme.Color(token))
end

local function gradient(t, top, bottom)
	if t.SetGradient and CreateColor then
		t:SetGradient("VERTICAL", CreateColor(bottom[1], bottom[2], bottom[3], 1), CreateColor(top[1], top[2], top[3], 1))
	else
		t:SetVertexColor(top[1], top[2], top[3], 1)
	end
end

local redraw

-- The guide window's frames on `art` (a card's picture area, or a frame the
-- window alone is drawn on), made on its first draw.
local function build(art)
	local p = {}
	local win = CreateFrame("Frame", nil, art)
	win.psGuide = true
	p.win = win
	-- The band behind the tabs and the step bar.
	p.sky = tex(win, "BACKGROUND", -5, "band")
	p.sky:SetPoint("TOPLEFT", win, "TOPLEFT", 1, -1)
	p.sky:SetPoint("TOPRIGHT", win, "TOPRIGHT", -1, -1)
	p.stars = tex(win, "BACKGROUND", -4, "band-stars")
	p.stars:SetAllPoints(p.sky)
	-- The tab strip (a game look's border starts at its foot) and its one
	-- tab, the guide in view.
	local strip = CreateFrame("Frame", nil, win)
	strip:SetPoint("TOPLEFT", win, "TOPLEFT", 0, 0)
	strip:SetPoint("TOPRIGHT", win, "TOPRIGHT", 0, 0)
	strip.Rule = tex(strip, "BORDER", 0)
	strip.Rule:SetPoint("BOTTOMLEFT", strip, "BOTTOMLEFT", 0, 0)
	strip.Rule:SetPoint("BOTTOMRIGHT", strip, "BOTTOMRIGHT", 0, 0)
	win.psStrip = strip
	local tab = CreateFrame("Frame", nil, strip)
	tab:SetWidth(150)
	tab:SetPoint("BOTTOMLEFT", strip, "BOTTOMLEFT", 1, 0)
	tab.Selected = tex(tab, "BACKGROUND", 0)
	tab.Selected:SetAllPoints(tab)
	tab.Bar = tex(tab, "OVERLAY", 0)
	tab.Bar:SetHeight(2)
	tab.Bar:SetPoint("BOTTOMLEFT", tab, "BOTTOMLEFT", 0, 0)
	tab.Bar:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT", 0, 0)
	tab.Icon = tex(tab, "ARTWORK", 0, "icon-level")
	tab.Icon:SetSize(12, 12)
	tab.Icon:SetPoint("LEFT", tab, "LEFT", 9, 0)
	tab.Label = text(tab)
	tab.Label:SetPoint("LEFT", tab.Icon, "RIGHT", 6, 0)
	tab.Range = text(tab)
	tab.Range:SetPoint("LEFT", tab.Label, "RIGHT", 4, 0)
	-- Hearth's framed tab.
	tab.Frame = tex(tab, "BACKGROUND", -7)
	tab.Frame:SetPoint("BOTTOMLEFT", tab, "BOTTOMLEFT", 0, 0)
	tab.Frame:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT", 0, 0)
	tab.Frame:SetHeight(24)
	p.strip, p.tab = strip, tab
	-- The step bar: ‹ 8 / 29 › and the guide's title; Hearth's title bar.
	local nav = CreateFrame("Frame", nil, win)
	nav:SetPoint("TOPLEFT", strip, "BOTTOMLEFT", 0, 0)
	nav:SetPoint("TOPRIGHT", strip, "BOTTOMRIGHT", 0, 0)
	nav.TitleBar = tex(nav, "BACKGROUND", -4)
	nav.TitleBar:SetPoint("TOPLEFT", nav, "TOPLEFT", 4, 0)
	nav.TitleBar:SetPoint("BOTTOMRIGHT", nav, "BOTTOMRIGHT", -4, 1)
	nav.Prev = tex(nav, "ARTWORK", 0, "chevron-left")
	nav.Next = tex(nav, "ARTWORK", 0, "chevron-right")
	nav.Count = text(nav, "CENTER")
	nav.Count:SetPoint("LEFT", nav.Prev, "RIGHT", 2, 0)
	nav.Next:SetPoint("LEFT", nav.Count, "RIGHT", 2, 0)
	nav.Title = text(nav)
	nav.Title:SetPoint("LEFT", nav.Next, "RIGHT", 8, 0)
	nav.Rule = tex(nav, "BORDER", 0)
	nav.Rule:SetPoint("BOTTOMLEFT", nav, "BOTTOMLEFT", 0, 0)
	nav.Rule:SetPoint("BOTTOMRIGHT", nav, "BOTTOMRIGHT", 0, 0)
	p.nav = nav
	-- The person to talk to.
	local person = CreateFrame("Frame", nil, win)
	person:SetPoint("TOPLEFT", nav, "BOTTOMLEFT", 0, 0)
	person:SetPoint("TOPRIGHT", nav, "BOTTOMRIGHT", 0, 0)
	person:SetHeight(PERSON_H)
	person.Icon = person:CreateTexture(nil, "ARTWORK")
	person.Icon:SetTexture(Theme.VerbIcon("talk"))
	person.Name = text(person)
	person.Where = text(person)
	person.Where:SetPoint("TOPLEFT", person.Name, "BOTTOMLEFT", 0, -3)
	person.Rule = tex(person, "ARTWORK", 0)
	person.Rule:SetHeight(1)
	p.person = person
	-- The goals: one done, the one the arrow is on.
	p.rows = {}
	local above = person
	for i, goal in ipairs(GOALS) do
		local r = CreateFrame("Frame", nil, win)
		r:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, 0)
		r:SetPoint("TOPRIGHT", above, "BOTTOMRIGHT", 0, 0)
		r.Mark = tex(r, "ARTWORK", 0)
		r.Mark:SetWidth(2)
		r.Mark:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -3)
		r.Mark:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 3)
		r.Icon = r:CreateTexture(nil, "ARTWORK")
		r.Text = text(r)
		r.Check = CreateFrame("CheckButton", nil, r)
		r.Check:EnableMouse(false)
		r.psGoal = goal
		p.rows[i] = r
		above = r
	end
	-- The progress: the house's line and percent, the game's status bar.
	local foot = CreateFrame("Frame", nil, win)
	foot:SetPoint("BOTTOMLEFT", win, "BOTTOMLEFT", 0, 0)
	foot:SetPoint("BOTTOMRIGHT", win, "BOTTOMRIGHT", 0, 0)
	foot.Pct = text(foot, "RIGHT")
	foot.Track = tex(foot, "BACKGROUND", 0)
	foot.Track:SetPoint("RIGHT", foot.Pct, "LEFT", -8, 0)
	foot.Fill = tex(foot, "ARTWORK", 0)
	foot.Fill:SetPoint("TOPLEFT", foot.Track, "TOPLEFT", 0, 0)
	foot.Fill:SetPoint("BOTTOMLEFT", foot.Track, "BOTTOMLEFT", 0, 0)
	local bar = CreateFrame("StatusBar", nil, foot)
	bar:SetStatusBarTexture(STATUS_BAR)
	bar:SetMinMaxValues(0, 1)
	bar.Bg = tex(bar, "BACKGROUND", 0)
	bar.Bg:SetAllPoints(bar)
	bar.Bg:SetVertexColor(0, 0, 0, 0.75)
	Theme.Border(bar, 0.42, 0.329, 0.125, 1)
	foot.Status = bar
	p.foot = foot
	art.psSkinCard = p
	return p
end

-- A card's own parts round the window, made on its first draw as a card: the
-- world behind it (the same dusk on every card), the arrow's dial
-- (Nav/Arrow.lua; its texts left out) and the swatches; and its repaints at
-- a new size and on showing after a live repaint it missed.
local function cardParts(art, p)
	p.world = tex(art, "BACKGROUND", -8)
	p.world:SetAllPoints(art)
	p.world:SetVertexColor(0.055, 0.065, 0.085, 1)
	if Arrow and Arrow.BuildDial then
		local holder = CreateFrame("Frame", nil, art)
		holder:SetSize(Arrow.WIDTH, Arrow.HEIGHT)
		p.holder, p.dial = holder, Arrow.BuildDial(holder)
	end
	p.accent, p.accent2, p.glow = tex(art, "ARTWORK", 0), tex(art, "ARTWORK", 0), tex(art, "ARTWORK", 0)
	for _, t in ipairs({ p.accent, p.accent2, p.glow }) do t:SetHeight(3) end
	art:HookScript("OnSizeChanged", function(self)
		if self:IsVisible() then redraw(self) end
	end)
	art:HookScript("OnShow", function(self)
		if self.psCardStale then
			self.psCardStale = nil
			redraw(self)
		end
	end)
	p.card = true
end

-- Whether colour `c` is there and not `like` (a token the palette derived
-- from another, as a skin without its own second accent or glow has).
local function own(c, like)
	if type(c) ~= "table" or type(like) ~= "table" then return type(c) == "table" end
	for i = 1, 3 do
		if math.abs((c[i] or 0) - (like[i] or 0)) > 0.002 then return true end
	end
	return false
end

-- The window on `w` x `h`, in the skin the Theme answers for: its parts as
-- the window's GF.ApplySkin, GF.ApplyStyle, GF.RenderTabs, GF.PaintTab and
-- paintRow dress them. On a card it takes the left two thirds; `alone`, the
-- whole of it. -> where the room right of it starts
local function paintWindow(p, w, h, alone)
	local M = Theme.Metric
	local pad = max(4, M("guidePad", 14))
	local tabH, navH, footH, rowH = M("guideTabs", 28), M("guideNav", 34), M("guideFoot", 26), M("guideRow", 24)
	local icon, check = 15, M("guideCheck", 18)
	local textX = pad + icon + M("guideIconGap", 10)
	local look, kit = Theme.SkinKey(), Theme.Kit()
	local hearth = look == "hearth"
	local win = p.win
	local winH = tabH + navH + PERSON_H + #p.rows * rowH + 4 + footH
	win:SetSize(WIN_W, winH)
	local inset = alone and 0 or 4
	local k = alone and min(w / WIN_W, h / winH) or min((w * 0.66 - 6) / WIN_W, (h - 8) / winH)
	win:SetScale(k)
	win:ClearAllPoints()
	win:SetPoint("TOPLEFT", win:GetParent(), "TOPLEFT", inset / k, -inset / k)
	paint(win, "window")
	-- The band: Polestar's own look's, its media the skin's.
	local head = tabH + navH
	local band = look == "polestar" and Theme.ShowsBand()
	p.sky:SetTexture(Theme.SkinMedia("band") or Theme.Media("band"))
	p.stars:SetTexture(Theme.SkinMedia("bandStars") or Theme.Media("band-stars"))
	p.sky:SetHeight(head)
	local x0, x1, y0, y1 = Theme.BandCoords(WIN_W - 2, head, 30)
	p.sky:SetTexCoord(x0, x1, y0, y1)
	p.stars:SetTexCoord(x0, x1, y0, y1)
	local r, g, b = Theme.Color("sky")
	p.sky:SetVertexColor(r, g, b, 1)
	local sr, sg, sb, sa = Theme.Color("star")
	p.stars:SetVertexColor(sr, sg, sb, sa or 1)
	p.sky:SetShown(band)
	p.stars:SetShown(band)
	-- The strip and its tab.
	local strip, tab = p.strip, p.tab
	strip:SetHeight(tabH)
	Theme.KitStrip(strip, true)
	strip.Rule:SetVertexColor(Theme.Wash("divider"))
	strip.Rule:SetHeight(Theme.Pixel(strip))
	tab:SetHeight(tabH)
	tab.Selected:SetVertexColor(Theme.Wash("hover"))
	tab.Bar:SetVertexColor(Theme.Color("accent"))
	tab.Icon:SetVertexColor(Theme.Color("accent"))
	say(tab.Label, "small", L["Elwynn Forest"], "text")
	say(tab.Range, "small", "(1\226\128\14710)", "textDim")
	local framed = Theme.KitTab(tab, true, nil, true)
	tab.Frame:SetShown(hearth)
	if hearth then gradient(tab.Frame, { 0.231, 0.176, 0.078 }, { 0.09, 0.067, 0.039 }) end
	tab.Selected:SetShown(not (hearth or framed))
	tab.Bar:SetShown(not (hearth or framed))
	if hearth or framed then tab.Label:SetTextColor(Theme.Color("title")) end
	-- The step bar.
	local nav = p.nav
	nav:SetHeight(navH)
	nav.TitleBar:SetShown(hearth)
	if hearth then gradient(nav.TitleBar, { Theme.Color("sky") }, { Theme.Color("skyBottom") }) end
	local ni = M("guideNavIcon", 14)
	nav.Prev:SetSize(ni, ni)
	nav.Next:SetSize(ni, ni)
	nav.Prev:ClearAllPoints()
	nav.Prev:SetPoint("LEFT", nav, "LEFT", pad - 1, 0)
	nav.Prev:SetVertexColor(Theme.Color("textDim"))
	nav.Next:SetVertexColor(Theme.Color("textDim"))
	say(nav.Count, "number", "8 / 29", "text")
	say(nav.Title, "small", L["Elwynn Forest"], "textDim")
	if look == "halo" then
		nav.Rule:SetVertexColor(Theme.Color("accentLine"))
	elseif hearth then
		nav.Rule:SetVertexColor(Theme.Color("titleLine"))
	elseif kit then
		nav.Rule:SetVertexColor(Theme.Color("separator"))
	else
		nav.Rule:SetVertexColor(Theme.Wash("divider"))
	end
	nav.Rule:SetHeight(Theme.Pixel(nav))
	-- The person, over a game look's quest header; Hearth's gold separator.
	local person = p.person
	Theme.KitHeader(person, true)
	person.Icon:SetSize(icon + 1, icon + 1)
	person.Icon:ClearAllPoints()
	person.Icon:SetPoint("TOPLEFT", person, "TOPLEFT", pad - 1, -11)
	person.Icon:SetVertexColor(Theme.Color("textDim"))
	person.Name:ClearAllPoints()
	person.Name:SetPoint("TOPLEFT", person, "TOPLEFT", textX, -10)
	say(person.Name, "name", L["Marshal Dughan"], "personName")
	say(person.Where, "small", L["Goldshire"], "textDim")
	person.Rule:SetShown(hearth)
	person.Rule:ClearAllPoints()
	person.Rule:SetPoint("BOTTOMLEFT", person, "BOTTOMLEFT", pad, 0)
	person.Rule:SetPoint("BOTTOMRIGHT", person, "BOTTOMRIGHT", -pad, 0)
	person.Rule:SetVertexColor(Theme.Color("separator"))
	-- The goals: the glyph, the line as the window writes it, the tick box
	-- in the skin's paint; the game's looks light the one to do now.
	for _, row in ipairs(p.rows) do
		local goal = row.psGoal
		local done, current = goal.status == "done", goal.current and true or false
		row:SetHeight(rowH)
		row.Mark:SetShown(current)
		row.Mark:SetVertexColor(Theme.Color("accent"))
		row.Icon:SetSize(icon, icon)
		row.Icon:ClearAllPoints()
		row.Icon:SetPoint("CENTER", row, "LEFT", pad + icon / 2, 0)
		row.Icon:SetTexture(done and Theme.Media("check") or Theme.VerbIcon(goal.t))
		row.Icon:SetVertexColor(Theme.Color(done and "success" or (current and "accent" or "textDim")))
		Theme.KitRowLit(row, current and not done, nil, M("guideLitInset", 4))
		row.Check:SetSize(check, check)
		row.Check:ClearAllPoints()
		row.Check:SetPoint("RIGHT", row, "RIGHT", -(pad - 3), 0)
		paint(row.Check, "checkbox")
		row.Check:SetChecked(done)
		row.Check:SetAlpha(done and 0.45 or 1)
		row.Text:ClearAllPoints()
		row.Text:SetPoint("LEFT", row, "LEFT", textX, 0)
		row.Text:SetPoint("RIGHT", row.Check, "LEFT", -4, 0)
		local line = UI and UI.GoalLine and UI.GoalLine(goal) or (goal.verb .. " " .. goal.subject)
		say(row.Text, "goal", line, done and "textMuted" or "text")
	end
	-- The progress: the game's status bar in Hearth and the game's looks,
	-- else the house's line.
	local foot, bar = p.foot, p.foot.Status
	foot:SetHeight(footH)
	local game = Theme.GameSkin()
	foot.Track:SetShown(not game)
	foot.Fill:SetShown(not game)
	foot.Pct:SetShown(not game)
	bar:SetShown(game and true or false)
	if game then
		local inset = kit and 10 or 0
		bar:ClearAllPoints()
		bar:SetPoint("LEFT", foot, "LEFT", pad + inset, 0)
		bar:SetPoint("RIGHT", foot, "RIGHT", -pad - inset, 0)
		bar:SetHeight(kit and 12 or 14)
		bar:SetValue(DONE)
		if Theme.KitStatus(bar) then
			bar.psKitDrawn = true
		else
			if bar.psKitDrawn then
				-- Back from a game look: Hearth's bar as the window makes it.
				bar:SetStatusBarTexture(STATUS_BAR)
				bar:GetStatusBarTexture():SetTexCoord(0, 1, 0, 1)
				bar.Bg:SetTexture(Theme.Media("white"))
				bar.Bg:SetTexCoord(0, 1, 0, 1)
				bar.Bg:SetVertexColor(0, 0, 0, 0.75)
				Theme.Border(bar, 0.42, 0.329, 0.125, 1)
				bar.psKitDrawn = nil
			end
			gradient(bar:GetStatusBarTexture(), { 0.91, 0.722, 0 }, { 0.478, 0.345, 0 })
		end
	else
		foot.Pct:ClearAllPoints()
		foot.Pct:SetPoint("RIGHT", foot, "RIGHT", -pad, 0)
		say(foot.Pct, "number", floor(DONE * 100 + 0.5) .. "%", "textDim")
		foot.Track:ClearAllPoints()
		foot.Track:SetPoint("LEFT", foot, "LEFT", pad, 0)
		foot.Track:SetPoint("RIGHT", foot.Pct, "LEFT", -8, 0)
		foot.Track:SetHeight(3)
		foot.Track:SetVertexColor(Theme.Wash("progress"))
		foot.Fill:SetWidth(max(0.01, (WIN_W - pad * 2 - 36) * DONE))
		foot.Fill:SetVertexColor(Theme.Color("accent"))
	end
	return 4 + WIN_W * k + 4
end

-- The arrow right of the window, from `left` to the card's edge, in the
-- skin's own design, dart, glow and colours, pointing ahead-left; the
-- swatches under it.
local cardLook = {}
local function paintArrow(p, w, h, left)
	local art = p.win:GetParent()
	local room = max(8, w - 4 - left)
	local mid = left + room / 2
	local size = min(room * 0.8, h * 0.5)
	local top = (h - size) / 2 - 8
	if p.dial then
		local s = size / Arrow.DIAL
		p.holder:SetScale(s)
		p.holder:ClearAllPoints()
		p.holder:SetPoint("TOP", art, "TOPLEFT", mid / s, -top / s)
		if Nav.ReadPalette then Nav.ReadPalette() end
		Arrow.ReadSkin()
		Arrow.ReadLook(cardLook)
		Arrow.PaintDial(p.dial, cardLook, Arrow.StyleFor("skin"), "travel", 0.5, 400)
		p.dial.distText:Hide()
		p.dial.labelText:Hide()
		p.dial.etaText:Hide()
	end
	-- The accent, then the skin's own second accent and glow (none for a
	-- palette that only derives them: Polestar's own skins, a scheme).
	local pal = Theme.Palette()
	local swatch = max(4, floor(room * 0.2))
	local shown = { { p.accent, pal.accent, nil, swatch * 2 } }
	for _, t in ipairs({ { p.accent2, pal.accent2, pal.accent }, { p.glow, pal.arrowGlow, pal.arrowNear } }) do
		if own(t[2], t[3]) then
			shown[#shown + 1] = { t[1], t[2], nil, swatch }
		else
			t[1]:Hide()
		end
	end
	local width = -2
	for _, s in ipairs(shown) do width = width + s[4] + 2 end
	local x = mid - width / 2
	for _, s in ipairs(shown) do
		local t, c = s[1], s[2]
		t:ClearAllPoints()
		t:SetPoint("TOPLEFT", art, "TOPLEFT", x, -(top + size + 10))
		t:SetWidth(s[4])
		t:SetVertexColor(c[1], c[2], c[3], 1)
		t:Show()
		x = x + s[4] + 2
	end
end

-- Every card drawn (its art -> what it shows), to paint again after the
-- live repaint.
local drawn = setmetatable({}, { __mode = "k" })

local function paintCard(art, id, scheme, alone)
	-- The palette: a scheme's card wears it on Polestar's own look.
	drawing.pal = resolve(id, scheme)
	local p = art.psSkinCard or build(art)
	local W = ns.Widgets
	local w, h = art:GetWidth() or 0, art:GetHeight() or 0
	if w < 40 or h < 30 then w, h = (W and W.CARD_W or 156) - 2, W and W.CARD_ART or 88 end
	if alone then return paintWindow(p, w, h, true) end
	if not p.card then cardParts(art, p) end
	paintArrow(p, w, h, paintWindow(p, w, h))
end

-- Draw skin `id` (its `variant`; Polestar's own look in `scheme`) on `art`:
-- a card, drawn again after every live repaint, or (`alone`) the window
-- alone, filling `art`, drawn once (its caller draws it again).
local function draw(art, id, variant, scheme, alone)
	if type(art) ~= "table" or not art.CreateTexture then return end
	if not alone then
		local d = drawn[art] or {}
		drawn[art] = d
		d.id, d.variant, d.scheme = id, variant, scheme
		-- The live palette, built before the card's stands in.
		Theme.Palette()
	end
	local live = Theme.SkinId()
	local wasId, wasPal, wasVariant = drawing.id, drawing.pal, previewing[id]
	previewing[id], drawing.id, drawing.pal = variant, id, nil
	local ok, err = pcall(paintCard, art, id, scheme, alone)
	drawing.id, drawing.pal, previewing[id] = wasId, wasPal, wasVariant
	if not alone then
		-- The live skin's own again: the arrow's colours, dart and glow, and
		-- a resolver's answer for the variant in use.
		if Nav and Nav.ReadPalette then Nav.ReadPalette() end
		if Arrow and Arrow.ReadSkin then Arrow.ReadSkin() end
		if id == live and SKINS[id].resolve then resolve(id) end
	end
	if not ok then error(err, 0) end
end

function redraw(art)
	local d = drawn[art]
	if d then draw(art, d.id, d.variant, d.scheme) end
end

-- After every live repaint (a setting, the skin, a variant, the UI scale):
-- the cards on screen paint again in their own skins, each on its own (one
-- that fails leaves the others drawn), the others when they next show.
Theme.OnChanged(function()
	local failed
	for art in pairs(drawn) do
		if art:IsVisible() then
			local ok, err = pcall(redraw, art)
			if not ok then failed = failed or err end
		else
			art.psCardStale = true
		end
	end
	if failed then error(failed, 0) end
end)

-- The skin picker's card (UI/Looks/Theme.lua): skin `id` drawn on `card` as
-- it draws itself, the player's own colours over it; the live skin is left
-- alone. `variant`: one of the skin's variants (its variant cards), else the
-- one in use. Drawn again on its own after every live repaint.
function Theme.DrawSkinCard(card, id, variant)
	if not SKINS[id] then return end
	draw(card, id, variant, nil)
end

-- A scheme's card: Polestar's own look in that scheme, the player's own
-- colours over it.
function Theme.DrawSchemeCard(card, id)
	if not (SCHEMES[id] or id == "ellesmere") then return end
	draw(card, "polestar", nil, id)
end

-- The settings' own pictures of a look (the Profiles page's cards, drawn
-- under a profile's values): skin `id`'s guide window alone, filling
-- `frame`, drawn once; its caller draws it again when it needs to.
if UI then
	function UI.SkinWindow(frame, id, variant)
		if not SKINS[id] then return end
		draw(frame, id, variant, nil, true)
	end
end
