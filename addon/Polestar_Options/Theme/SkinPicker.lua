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
-- The looks' miniatures
---------------------------------------------------------------------------

-- A look's miniature: its guide window cut down to what tells one look from
-- another, drawn whole at a size where its text still reads (never the full
-- window shrunk to a third of itself, where the client drops the text and
-- only the frame's lines are left): the window's frame and ground, its
-- header band with the guide's tab, the person to talk to, the goal the
-- arrow is on (lit as the window lights it, with its tick box) and a foot
-- with the step's progress, the palette's accents as dots and an accent
-- button. Built here as the window builds its parts (UI/GuideFrame*.lua) and
-- painted by that skin's own painters, sizes, palette, fonts and media while
-- the Theme answers for it (I.drawing), whatever skin is in use; the game's
-- looks draw the client's own art there, over the look's ground and gold
-- edge. On a card it sits in the middle at one scale with even margins, on
-- the same dusk on every card. The live skin is left alone; a skin's hooks
-- are for its live surfaces and stay off the miniatures. Nothing on one is
-- kept for the live repaint: they paint themselves again after it
-- (Theme.OnChanged). One component for every picture of a look: the Theme
-- page's skin, variant and scheme cards, Install's look page (UI/Welcome.lua)
-- and the Profiles page's cards (alone: filling its frame, no margin).
local L, UI = ns.L, ns.UI
local drawing, paint, paintFont = I.drawing, I.paint, I.paintFont
local floor, max, min = math.floor, math.max, math.min
local STATUS_BAR = "Interface\\TargetingFrame\\UI-StatusBar"
-- The miniature's width in its own units (its height follows the skin's
-- sizes), its person's line and its foot; the margin round it on a card, the
-- least scale its text is drawn at (smaller art crops it, never shrinks the
-- text past legibility); the step's progress.
local MINI_W, PERSON_H, FOOT_H, MARGIN, LEAST, DONE = 248, 34, 34, 10, 0.72, 11 / 29
-- The goal the arrow is on: the guide window page's demo step's
-- (UI/Looks/GuideWindow.lua).
local GOAL = { t = "kill", status = "active", verb = L["Kill"], subject = ns.Names.Or("npc", 257, "Kobold Worker"), subjectKind = "npc",
	progress = { cur = 3, max = 8 }, current = true }

-- A string with its role's face on it from the start: the client refuses a
-- string's text before it has a font ("Font not set"), which stopped every
-- miniature after its frame.
local function text(parent, role, justify)
	local fs = parent:CreateFontString(nil, "OVERLAY")
	paintFont(fs, role)
	fs:SetWordWrap(false)
	fs:SetJustifyH(justify or "LEFT")
	return fs
end

local function tex(parent, layer, sub, media)
	local t = parent:CreateTexture(nil, layer, nil, sub)
	t:SetTexture(Theme.Media(media or "white"))
	return t
end

-- A string's text, then its role's face in the skin (a script font follows
-- the text) and its colour.
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

-- The miniature's frames on `art` (a card's picture area, or a frame it
-- fills alone), made on its first draw.
local function build(art)
	local p = {}
	-- The same dusk behind every card's window (a miniature drawn alone
	-- has none).
	p.world = tex(art, "BACKGROUND", -8)
	p.world:SetAllPoints(art)
	p.world:SetVertexColor(0.055, 0.065, 0.085, 1)
	local win = CreateFrame("Frame", nil, art)
	win.psGuide = true
	p.win = win
	-- Under a game look's window, on the card itself (so under all of the
	-- window's art): its ground and its gold edge, which the client's frame
	-- art covers and which still say the look where that art is not drawn.
	p.hint = tex(art, "BACKGROUND", -7)
	p.hint:SetAllPoints(win)
	p.hintEdge = {}
	for i, at in ipairs({ { "TOPLEFT", "TOPRIGHT" }, { "BOTTOMLEFT", "BOTTOMRIGHT" }, { "TOPLEFT", "BOTTOMLEFT" }, { "TOPRIGHT", "BOTTOMRIGHT" } }) do
		local t = tex(art, "BACKGROUND", -6)
		t:SetPoint(at[1], win, at[1], 0, 0)
		t:SetPoint(at[2], win, at[2], 0, 0)
		if i <= 2 then t:SetHeight(1) else t:SetWidth(1) end
		p.hintEdge[i] = t
	end
	-- The band behind the tab strip.
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
	tab.Label = text(tab, "small")
	tab.Label:SetPoint("LEFT", tab.Icon, "RIGHT", 6, 0)
	tab.Range = text(tab, "small")
	tab.Range:SetPoint("LEFT", tab.Label, "RIGHT", 4, 0)
	-- Hearth's framed tab.
	tab.Frame = tex(tab, "BACKGROUND", -7)
	tab.Frame:SetPoint("BOTTOMLEFT", tab, "BOTTOMLEFT", 0, 0)
	tab.Frame:SetPoint("BOTTOMRIGHT", tab, "BOTTOMRIGHT", 0, 0)
	tab.Frame:SetHeight(24)
	p.strip, p.tab = strip, tab
	-- The person to talk to.
	local person = CreateFrame("Frame", nil, win)
	person:SetPoint("TOPLEFT", strip, "BOTTOMLEFT", 0, 0)
	person:SetPoint("TOPRIGHT", strip, "BOTTOMRIGHT", 0, 0)
	person:SetHeight(PERSON_H)
	person.Icon = person:CreateTexture(nil, "ARTWORK")
	person.Icon:SetTexture(Theme.VerbIcon("talk"))
	person.Name = text(person, "name")
	person.Rule = tex(person, "ARTWORK", 0)
	person.Rule:SetHeight(1)
	p.person = person
	-- The goal the arrow is on.
	local r = CreateFrame("Frame", nil, win)
	r:SetPoint("TOPLEFT", person, "BOTTOMLEFT", 0, 0)
	r:SetPoint("TOPRIGHT", person, "BOTTOMRIGHT", 0, 0)
	r.Mark = tex(r, "ARTWORK", 0)
	r.Mark:SetWidth(2)
	r.Mark:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -3)
	r.Mark:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 3)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Text = text(r, "goal")
	r.Check = CreateFrame("CheckButton", nil, r)
	r.Check:EnableMouse(false)
	r.psGoal = GOAL
	p.rows = { r }
	-- The foot: the step's progress (the house's line, the game's status
	-- bar), the palette's accents as dots, and an accent button.
	local foot = CreateFrame("Frame", nil, win)
	foot:SetPoint("BOTTOMLEFT", win, "BOTTOMLEFT", 0, 0)
	foot:SetPoint("BOTTOMRIGHT", win, "BOTTOMRIGHT", 0, 0)
	foot.Track = tex(foot, "BACKGROUND", 0)
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
	local button = CreateFrame("Button", nil, foot)
	button:EnableMouse(false)
	button.psTextButton, button.psPrimary = true, true
	button.Label = text(button, "label", "CENTER")
	button.Label:SetPoint("CENTER", button, "CENTER", 0, 0)
	foot.Button = button
	p.foot = foot
	-- The accent, then the skin's own second accent and glow (what tells
	-- its variants apart).
	p.accent, p.accent2, p.glow = tex(foot, "ARTWORK", 0, "circle"), tex(foot, "ARTWORK", 0, "circle"), tex(foot, "ARTWORK", 0, "circle")
	art.psSkinCard = p
	return p
end

-- A card repaints at a new size, and on showing after a live repaint it
-- missed.
local function hookCard(art, p)
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

-- The foot's accent button as the window's own primary buttons are dressed
-- (W.Button): the skin's button paint, then the accent fill and onAccent
-- text, the house's lit line inside its top; the game's looks and Hearth
-- draw their own primary (the game's red button, Hearth's plank).
local function paintButton(b, h)
	b:SetHeight(h)
	say(b.Label, "label", L["Accept"], "buttonText")
	b:SetWidth(max(56, floor(b.Label:GetStringWidth() + 2 * min(14, Theme.Metric("buttonPad", 16)) + 0.5)))
	paint(b, "button")
	local d = b.psSkin
	if Theme.GameSkin() or Theme.SkinKey() == "hearth" then
		if b.psBorder then for i = 1, 4 do b.psBorder[i]:Hide() end end
		if b.psTopHi then b.psTopHi:Hide() end
		return
	end
	local r, g, bb = Theme.Accent()
	if d and d.bg then d.bg:SetVertexColor(r, g, bb, 1) end
	if b.psBorder then for i = 1, 4 do b.psBorder[i]:SetVertexColor(r, g, bb, 1) end end
	b.Label:SetTextColor(Theme.Color("onAccent"))
	local hi = b.psTopHi
	if Theme.SkinKey() == "polestar" then
		if not hi then
			hi = tex(b, "ARTWORK", 7)
			hi:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1)
			hi:SetPoint("TOPRIGHT", b, "TOPRIGHT", -1, -1)
			b.psTopHi = hi
		end
		hi:SetHeight(Theme.Pixel(b))
		hi:SetVertexColor(1, 1, 1, 0.55)
		hi:Show()
	elseif hi then
		hi:Hide()
	end
end

-- The miniature on `w` x `h`, in the skin the Theme answers for: its parts as
-- the window's GF.ApplySkin, GF.ApplyStyle, GF.RenderTabs, GF.PaintTab and
-- paintRow dress them; in the middle of a card with even margins, or
-- (`alone`) filling it.
-- fit: a card too small for the least scale (Install's look thumbnails)
-- shows the whole window shrunk to it, a picture, not a crop.
local function paintMini(p, w, h, alone, fit)
	local M = Theme.Metric
	local pad = max(4, M("guidePad", 14))
	local tabH, rowH = M("guideTabs", 28), M("guideRow", 24)
	local icon, check = 15, M("guideCheck", 18)
	local textX = pad + icon + M("guideIconGap", 10)
	local look, kit = Theme.SkinKey(), Theme.Kit()
	local hearth = look == "hearth"
	local game = Theme.GameSkin() and true or false
	local win = p.win
	-- The goal's row holds two lines, as the guide window's row grows when
	-- its goal wraps ("Töte Kobold Worker" over "3/8"): the count stays whole,
	-- and every miniature is the same height whether its look's font wraps
	-- the line or not.
	local _, goalSize = Theme.FontSpec("goal")
	local goalH = max(rowH, floor((goalSize or 12) * 2.4 + 6.5))
	local winH = tabH + PERSON_H + goalH + FOOT_H
	win:SetSize(MINI_W, winH)
	local margin = alone and 0 or fit and 2 or MARGIN
	local k = min((w - 2 * margin) / MINI_W, (h - 2 * margin) / winH)
	if not (alone or fit) then k = max(LEAST, k) end
	win:SetScale(k)
	win:ClearAllPoints()
	win:SetPoint("TOPLEFT", win:GetParent(), "TOPLEFT", floor((w - MINI_W * k) / 2 + 0.5) / k, -floor((h - winH * k) / 2 + 0.5) / k)
	p.world:SetShown(not alone)
	paint(win, "window")
	p.hint:SetShown(game)
	for _, t in ipairs(p.hintEdge) do t:SetShown(game) end
	if game then
		p.hint:SetVertexColor(Theme.Color("panel"))
		local er, eg, eb = Theme.Color("frameEdge")
		for _, t in ipairs(p.hintEdge) do t:SetVertexColor(er, eg, eb, 1) end
	end
	-- The band: Polestar's own look's, its media the skin's.
	local band = look == "polestar" and Theme.ShowsBand()
	p.sky:SetTexture(Theme.SkinMedia("band") or Theme.Media("band"))
	p.stars:SetTexture(Theme.SkinMedia("bandStars") or Theme.Media("band-stars"))
	p.sky:SetHeight(tabH)
	local x0, x1, y0, y1 = Theme.BandCoords(MINI_W - 2, tabH, 30)
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
	say(tab.Label, "small", ns.Names.Or("area", 12, "Elwynn Forest"), "text")
	say(tab.Range, "small", "(1\226\128\14710)", "textDim")
	local framed = Theme.KitTab(tab, true, nil, true)
	tab.Frame:SetShown(hearth)
	if hearth then gradient(tab.Frame, { 0.231, 0.176, 0.078 }, { 0.09, 0.067, 0.039 }) end
	tab.Selected:SetShown(not (hearth or framed))
	tab.Bar:SetShown(not (hearth or framed))
	if hearth or framed then tab.Label:SetTextColor(Theme.Color("title")) end
	-- The person, over a game look's quest header; Hearth's gold separator.
	local person = p.person
	Theme.KitHeader(person, true)
	person.Icon:SetSize(icon + 1, icon + 1)
	person.Icon:ClearAllPoints()
	person.Icon:SetPoint("LEFT", person, "LEFT", pad - 1, 0)
	person.Icon:SetVertexColor(Theme.Color("textDim"))
	person.Name:ClearAllPoints()
	person.Name:SetPoint("LEFT", person, "LEFT", textX, 0)
	person.Name:SetPoint("RIGHT", person, "RIGHT", -pad, 0)
	say(person.Name, "name", L["Marshal Dughan"], "personName")
	person.Rule:SetShown(hearth)
	person.Rule:ClearAllPoints()
	person.Rule:SetPoint("BOTTOMLEFT", person, "BOTTOMLEFT", pad, 0)
	person.Rule:SetPoint("BOTTOMRIGHT", person, "BOTTOMRIGHT", -pad, 0)
	person.Rule:SetVertexColor(Theme.Color("separator"))
	-- The goal: its glyph, its line as the window writes it, the tick box in
	-- the skin's paint; lit as the window lights the goal to do now.
	local row = p.rows[1]
	row:SetHeight(goalH)
	row.Mark:SetVertexColor(Theme.Color("accent"))
	row.Icon:SetSize(icon, icon)
	row.Icon:ClearAllPoints()
	row.Icon:SetPoint("CENTER", row, "LEFT", pad + icon / 2, 0)
	row.Icon:SetTexture(Theme.VerbIcon(GOAL.t))
	row.Icon:SetVertexColor(Theme.Color("accent"))
	Theme.KitRowLit(row, true, nil, M("guideLitInset", 4))
	row.Check:SetSize(check, check)
	row.Check:ClearAllPoints()
	row.Check:SetPoint("RIGHT", row, "RIGHT", -(pad - 3), 0)
	paint(row.Check, "checkbox")
	row.Check:SetChecked(false)
	row.Text:ClearAllPoints()
	row.Text:SetPoint("LEFT", row, "LEFT", textX, 0)
	-- A width, not a right anchor: a line too long for it breaks before its
	-- count, whatever the client's break rules are, so the count starts the
	-- second line whole ("3/8", never "3/" over "8").
	local textW = MINI_W - textX - (pad - 3) - check - 4
	row.Text:SetWidth(textW)
	local line = UI and UI.GoalLine and UI.GoalLine(GOAL) or (GOAL.verb .. " " .. GOAL.subject)
	row.Text:SetWordWrap(true)
	say(row.Text, "goal", line, "text")
	local fs = row.Text
	if (fs.GetUnboundedStringWidth and fs:GetUnboundedStringWidth() or fs:GetStringWidth()) > textW then
		fs:SetText((line:gsub(" +(|c%x%x%x%x%x%x%x%x%d+/%d+|r)$", "\n%1")))
	end
	-- The foot: the accent button at the right, the accents' dots left of
	-- it, the progress in what is left (the game's status bar in Hearth and
	-- the game's looks, else the house's line).
	local foot, bar, button = p.foot, p.foot.Status, p.foot.Button
	foot:SetHeight(FOOT_H)
	paintButton(button, kit and 22 or 20)
	button:ClearAllPoints()
	button:SetPoint("RIGHT", foot, "RIGHT", -pad, 0)
	local pal = Theme.Palette()
	local dots = { { p.accent, pal.accent } }
	for _, t in ipairs({ { p.accent2, pal.accent2, pal.accent }, { p.glow, pal.arrowGlow, pal.arrowNear } }) do
		if own(t[2], t[3]) then dots[#dots + 1] = { t[1], t[2] } else t[1]:Hide() end
	end
	local x = -(pad + button:GetWidth() + 10)
	for i = #dots, 1, -1 do
		local t, c = dots[i][1], dots[i][2]
		t:SetSize(7, 7)
		t:ClearAllPoints()
		t:SetPoint("RIGHT", foot, "RIGHT", x, 0)
		t:SetVertexColor(c[1], c[2], c[3], 1)
		t:Show()
		x = x - 11
	end
	local right = -x + 6
	foot.Track:SetShown(not game)
	foot.Fill:SetShown(not game)
	bar:SetShown(game)
	if game then
		bar:ClearAllPoints()
		bar:SetPoint("LEFT", foot, "LEFT", pad, 0)
		bar:SetPoint("RIGHT", foot, "RIGHT", -right, 0)
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
		foot.Track:ClearAllPoints()
		foot.Track:SetPoint("LEFT", foot, "LEFT", pad, 0)
		foot.Track:SetPoint("RIGHT", foot, "RIGHT", -right, 0)
		foot.Track:SetHeight(3)
		foot.Track:SetVertexColor(Theme.Wash("progress"))
		foot.Fill:SetWidth(max(0.01, (MINI_W - pad - right) * DONE))
		foot.Fill:SetVertexColor(Theme.Color("accent"))
	end
end

-- Every card drawn (its art -> what it shows), to paint again after the
-- live repaint.
local drawn = setmetatable({}, { __mode = "k" })
-- While the cards on screen are drawn again in one go (the theme's listener
-- below): a resolver's answer for the variant in use is put back once, after
-- the last (repaint.live: the live skin's card was among them).
local repaint

-- The cards' palettes by skin, variant and scheme: resolved once, until the
-- theme next changes (a live repaint too). A look previewed under the pointer
-- (Install's looks) draws without building its palette again. A picture
-- drawn under other values (a profile's card: O.WithSettings answers ns.Get)
-- or alone resolves its own.
local realGet = ns.Get
local palettes = {}
Theme.OnChanged(function()
	for k in pairs(palettes) do palettes[k] = nil end
end)
local function paletteOf(id, scheme)
	local byId = palettes[id]
	if not byId then
		byId = {}
		palettes[id] = byId
	end
	local v = previewing[id]
	if v == nil then v = false end
	local byVariant = byId[v]
	if not byVariant then
		byVariant = {}
		byId[v] = byVariant
	end
	local key = scheme
	if key == nil then key = false end
	local pal = byVariant[key]
	if not pal then
		pal = resolve(id, scheme)
		byVariant[key] = pal
	end
	return pal
end

local function paintCard(art, id, scheme, alone)
	-- The palette: a scheme's card wears it on Polestar's own look.
	drawing.pal = (not alone and ns.Get == realGet) and paletteOf(id, scheme) or resolve(id, scheme)
	local p = art.psSkinCard or build(art)
	local W = ns.Widgets
	local w, h = art:GetWidth() or 0, art:GetHeight() or 0
	if w < 40 or h < 30 then w, h = (W and W.CARD_W or 156) - 2, W and W.CARD_ART or 88 end
	if not alone and not p.card then hookCard(art, p) end
	paintMini(p, w, h, alone, art.psCardFit)
end

-- Draw skin `id` (its `variant`; Polestar's own look in `scheme`) on `art`:
-- a card, drawn again after every live repaint, or (`alone`) the miniature
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
	-- A resolver's answer for the variant in use again.
	if not alone and id == live and SKINS[id].resolve then
		if repaint then repaint.live = id else resolve(id) end
	end
	if not ok then error(err, 0) end
end

function redraw(art)
	local d = drawn[art]
	if d then draw(art, d.id, d.variant, d.scheme) end
end

-- After every live repaint (a setting, the skin, a variant, the UI scale):
-- the cards on screen paint again in their own skins, each on its own (one
-- that fails leaves the others drawn), the others when they next show. A
-- dragged slider's repaints leave them to the refresh its end brings
-- (Theme.OnChanged's full).
Theme.OnChanged(function()
	local failed
	repaint = {}
	for art in pairs(drawn) do
		if art:IsVisible() then
			local ok, err = pcall(redraw, art)
			if not ok then failed = failed or err end
		else
			art.psCardStale = true
		end
	end
	local done = repaint
	repaint = nil
	if done.live and SKINS[done.live].resolve then resolve(done.live) end
	if failed then error(failed, 0) end
end, true)

-- The skin picker's card (UI/Looks/Theme.lua): skin `id` drawn on `card` as
-- it draws itself, the player's own colours over it; the live skin is left
-- alone. `variant`: one of the skin's variants (its variant cards), else the
-- one in use. Drawn again on its own after every live repaint. fit: the
-- whole window shrunk to a small card, never cropped (Install's looks).
function Theme.DrawSkinCard(card, id, variant, fit)
	if not SKINS[id] then return end
	if type(card) == "table" then card.psCardFit = fit and true or nil end
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
