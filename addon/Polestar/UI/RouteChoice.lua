-- "Choose your path": the route choice window. Where a guide's `next` names
-- several guides, the Engine asks (ROUTE_CHOICE) instead of deciding, and this
-- window shows one card per zone the character can level in next. The window
-- wears the welcome's chrome: the gold rim on top (W.Rim), a night header
-- (the band, and in the house style a gradient and the haze) with the emblem
-- in its glow. Each card is a panel with its hairline and reads top-down on
-- one grid shared by every card:
-- - the zone's painting edge to edge inside the hairline (UI.ZoneArt), the
--   zone's name on its fade. On the painting: the state chip on a dark plate
--   ("Recommended", "Your current route", "Experimental" for one of
--   Polestar's experimental guides, "Outlevelled"), the route's start as the
--   world map marks the waypoint (Polestar.Pins' target mark, so each look
--   and skin draws it its own way), and for a zone whose quests are mostly
--   Forever's own the ∞ pennant hanging from its top edge (ui.newInForever,
--   which shows the mark beside quests, shows it; its tooltip says what it
--   means);
-- - the facts a leveller decides on, a glyph and its number each, spread
--   across the card: the levels, the trip there, the quests (where they do
--   not fit, the widest gives way);
-- - the author's pitch, then at most 3 pros and 2 cons, one line each (a
--   detour through another zone is the first con);
-- - where the route goes on ("Then: Feralas & Tanaris" and the level it
--   takes the character to), unless every route meets again in one guide:
--   the header says so then;
-- - the button: "Level in <zone>", "Try <zone>" for an experimental guide,
--   "Keep this route" for the one open.
-- Stat rows, rules, the first con and the "Then" lines line up across cards.
-- The card's tooltip has the facts, the pitch, every pro and con and the
-- next guide whole. The recommended zone (never an experimental guide)
-- carries a 1px accent outline and the primary button. Choosing calls
-- Engine.ChooseRoute; "Decide later" and the header ✕ close it, and the
-- guide window keeps offering the choice.
--
-- Colours are Theme tokens only (the name's shadow in shade), repainted on a
-- scheme or skin change: the pennant is the look's night (sky at its top,
-- sidebar at its foot) edged in its accent, the chips on the painting sit on
-- its scrim, the stat glyphs wear its idle glyph colour.
--
-- Built on first use; nothing runs while it is hidden. In combat the window
-- waits for the fight to end before it opens.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, ceil, min, max, ipairs, format = math.floor, math.ceil, math.min, math.max, ipairs, string.format
local ZoneArt = UI.ZoneArt

local RC = {}
UI.RouteChoice = RC

local PAD = 24
local CARD_W = 288
local CARD_PAD = 16
local INNER = CARD_W - CARD_PAD * 2
local GAP = 12
local HEAD_H = 112
local FOOT_H = 56
local ART_H = 168 -- the zone's painting across the top of each card (UI.ZoneArt), inside the hairline
local ART_FADE = 0.5 -- its fade into the panel: half its height, so more of the zone shows than in the guide menu
local STAT_H = 16
local STAT_GLYPH = 13
local STAT_GAP = 16 -- at least this between two facts, a hairline in its middle
local STEP = 18 -- one pro or con
local THEN_H = 18
local GO_H = 32
local PIN = 16 -- the start's mark (its medallion 22, as on the world map)
local PENNANT_W, PENNANT_H = 26, 39
local MAX_PROS, MAX_CONS = 3, 2
local SEP = "  \194\183  "

local F -- the window
local cards = {}
local fromId -- the guide whose choice is shown
local current -- the choice on screen (laid out again when ui.newInForever changes)
local waiting -- a choice to show once combat ends
local unasked = false -- the choice on screen came by itself (the engine's offer), not for the player

local function Engine() return ns.Engine end

local function inCombat()
	return InCombatLockdown and InCombatLockdown() or false
end

-- "≈3 min away" from travel seconds, for the tooltip ("~" in a face without
-- "≈": Theme.Approx); nil when unknown.
local function awayText(seconds)
	if type(seconds) ~= "number" then return nil end
	if seconds < 60 then return L["Right here"] end
	local m = floor(seconds / 60 + 0.5)
	if m >= 90 then return L["A long trip from here"] end
	return format(L["%s min away"], Theme.Approx() .. m)
end

local function levelsText(o)
	if o.minLevel and o.maxLevel then return format("%d\226\128\147%d", o.minLevel, o.maxLevel) end
	return o.minLevel and tostring(o.minLevel) or nil
end

-- A count's text, its number in text and the words round it dim, in
-- whatever order the language puts them ("41 quests").
local function numbered(fmt, n)
	local dim, txt = "|c" .. Theme.Hex("textDim"), "|c" .. Theme.Hex("text")
	local s = dim .. fmt:gsub("%%d", "|r" .. txt .. n .. "|r" .. dim) .. "|r"
	return (s:gsub("|c%x%x%x%x%x%x%x%x|r", ""))
end

-- The trip on a card: "≈12 min" (the sign from Theme.Approx, lit with the
-- number), "Right here", "Far away" past an hour and a half (the tooltip says
-- "A long trip from here"); nil when unknown.
local function tripText(seconds)
	if type(seconds) ~= "number" then return nil end
	if seconds < 60 then return L["Right here"] end
	local m = floor(seconds / 60 + 0.5)
	if m >= 90 then return L["Far away"] end
	return numbered(L["%d min"], Theme.Approx() .. m)
end

-- The facts of option o a card shows: { glyph, its colour, text } for the
-- levels, the trip and the quests that are known.
local function facts(o)
	local out = {}
	local lv = levelsText(o)
	if lv then out[#out + 1] = { "icon-level", "icon", lv } end
	local trip = tripText(o.seconds)
	if trip then out[#out + 1] = { "icon-clock", "icon", trip } end
	if o.quests and o.quests > 0 then out[#out + 1] = { "icon-accept", "quest", numbered(L["%d quests"], o.quests) } end
	return out
end

-- The cons a card shows: a detour through another zone first (it decides),
-- then the author's.
local function consOf(o)
	local out = {}
	if type(o.detour) == "string" and o.detour ~= "" then out[1] = format(L["A detour through %s"], o.detour) end
	for _, n in ipairs(o.cons or {}) do out[#out + 1] = n end
	return out
end

-- The state chip's text and kind: the route open now, the recommended one,
-- one of Polestar's experimental guides, one the character outlevelled.
local function stateOf(o)
	if o.open then return L["Your current route"], "success" end
	if o.recommended then return L["Recommended"], "accent" end
	if o.experimental then return L["Experimental"], "warning" end
	if o.outleveled then return L["Outlevelled"], "neutral" end
end

local function zoneOf(o)
	return o.zoneName or o.title or o.id
end

local function goText(o)
	if o.open then return L["Keep this route"] end
	return format(o.experimental and L["Try %s"] or L["Level in %s"], zoneOf(o))
end

-- Whether the ∞ pennant shows: the zone's quests are mostly Forever's own and
-- the player shows the mark (ui.newInForever, Polestar.NewQuests).
local function pennantShown(o)
	if not o.newInForever then return false end
	local N = ns.NewQuests
	if N and N.Shown then return N.Shown() end
	return ns.Get("ui.newInForever") ~= false
end

---------------------------------------------------------------------------
-- Cards
---------------------------------------------------------------------------

-- One bullet line (a pro or a con), pooled per card: a single line,
-- truncated with an ellipsis at the card's width (the tooltip has it whole).
local function bullet(c, list, i, glyph, color, textColor)
	local b = list[i]
	if not b then
		b = {}
		b.Glyph = W.Tex(c, "ARTWORK", glyph, color)
		b.Text = W.Text(c, "label", textColor)
		list[i] = b
	end
	return b
end

-- The four 1px edges of `frame`, textures of `owner`.
local function edges(owner, frame)
	local e = {}
	for k = 1, 4 do
		e[k] = owner:CreateTexture(nil, "OVERLAY")
		e[k]:SetTexture(Theme.Media("white"))
	end
	e[1]:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	e[1]:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	e[2]:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
	e[2]:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
	e[3]:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
	e[3]:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", 0, 0)
	e[4]:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
	e[4]:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", 0, 0)
	return e
end

-- Three textures of `f` as one capsule its height (two half circles and a
-- middle), so `f`'s own text draws over them.
local function capsule(f, layer, sub)
	local h = f:GetHeight()
	local l = f:CreateTexture(nil, layer, nil, sub)
	l:SetTexture(Theme.Media("circle"))
	l:SetTexCoord(0, 0.5, 0, 1)
	l:SetSize(h / 2, h)
	l:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	local r = f:CreateTexture(nil, layer, nil, sub)
	r:SetTexture(Theme.Media("circle"))
	r:SetTexCoord(0.5, 1, 0, 1)
	r:SetSize(h / 2, h)
	r:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
	local m = f:CreateTexture(nil, layer, nil, sub)
	m:SetTexture(Theme.Media("white"))
	m:SetPoint("TOPLEFT", l, "TOPRIGHT", 0, 0)
	m:SetPoint("BOTTOMRIGHT", r, "BOTTOMLEFT", 0, 0)
	return { l, m, r }
end

local function tint(parts, r, g, b, a)
	for i = 1, #parts do parts[i]:SetVertexColor(r, g, b, a) end
end

-- The state chip on the painting: a chip (W.SetChip's colours) on a plate of
-- the look's scrim, so it reads on any painting.
local function paintTag(t)
	local kind = t.psKind
	local sr, sg, sb = Theme.Color("scrim")
	tint(t.Plate, sr, sg, sb, 0.82)
	if kind == "accent" then
		local r, g, b = Theme.Accent()
		tint(t.Tint, r, g, b, 0.16)
	elseif kind == "success" or kind == "warning" then
		local r, g, b = Theme.Color(kind)
		tint(t.Tint, r, g, b, 0.14)
	else
		tint(t.Tint, Theme.Wash("chip"))
	end
end

local function artTag(parent)
	local t = CreateFrame("Frame", nil, parent)
	t:SetHeight(W.CHIP_H)
	t.Plate = capsule(t, "BACKGROUND", 1)
	t.Tint = capsule(t, "BORDER", 1)
	t.Text = W.Text(t, "caption", "textDim")
	t.Text:SetPoint("CENTER", t, "CENTER", 0, 0)
	W.Painter(t, paintTag)
	return t
end

local function setTag(t, text, kind)
	t.psKind = kind
	t.Text:SetText(text)
	t:SetWidth(floor(W.TextWidth(t.Text) + 18 + 0.5))
	W.Color(t.Text, kind == "neutral" and "textDim" or kind)
	paintTag(t)
	t:Show()
end

-- The ∞ pennant: the cloth in the look's night, its sky at the top falling
-- to its sidebar at the foot, edged in the accent; the ∞ mark on it in its
-- own colours, as beside a quest's name.
local function paintPennant(p)
	local tr, tg, tb = Theme.Color("sky")
	local br, bg, bb = Theme.Color("sidebar")
	if p.Cloth.SetGradient and CreateColor then
		p.Cloth:SetVertexColor(1, 1, 1, 1)
		p.Cloth:SetGradient("VERTICAL", CreateColor(br, bg, bb, 0.97), CreateColor(tr, tg, tb, 0.97))
	else
		p.Cloth:SetVertexColor(tr, tg, tb, 0.97)
	end
	local r, g, b = Theme.Accent()
	p.Edge:SetVertexColor(r, g, b, 1)
end

local function pennantTip(p)
	W.Tooltip(p, "ANCHOR_RIGHT", L["New in Forever"], { L["Most of its quests are new in Forever."] })
end

local function pennant(c)
	local p = CreateFrame("Button", nil, c.Art.Over)
	p:SetSize(PENNANT_W, PENNANT_H)
	p:SetPoint("TOPRIGHT", c.Art, "TOPRIGHT", -12, 0)
	p.Cloth = p:CreateTexture(nil, "BORDER")
	p.Cloth:SetTexture(Theme.Media("pennant"))
	p.Cloth:SetTexCoord(0, 1, 0, 0.75)
	p.Cloth:SetAllPoints(p)
	p.Edge = p:CreateTexture(nil, "ARTWORK")
	p.Edge:SetTexture(Theme.Media("pennant-edge"))
	p.Edge:SetTexCoord(0, 1, 0, 0.75)
	p.Edge:SetAllPoints(p)
	p.Mark = p:CreateTexture(nil, "OVERLAY")
	p.Mark:SetTexture(Theme.Media("icon-forever"))
	p.Mark:SetSize(18, 9)
	p.Mark:SetPoint("TOP", p, "TOP", 0, -11)
	W.Painter(p, paintPennant)
	p:SetScript("OnEnter", pennantTip)
	p:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	-- A click on it chooses the card, as a click anywhere else on the card.
	p:SetScript("OnClick", function() RC.Choose(c.psId) end)
	return p
end

-- The route's start: the world map's waypoint mark (the target glyph in the
-- arrow's colour, on the look's medallion, in its glow), drawn by
-- Polestar.Pins so every look and skin draws it as on its map. Without the
-- pins (the window on its own in tests) there is none.
local function paintPin(f)
	local P = ns.Pins
	if not (P and P.ApplyLook) then return end
	local r, g, b = Theme.Color("arrow")
	P.ApplyLook(f, { icon = "map:target", color = { r, g, b, 1 }, glow = true }, PIN)
end

local function startPin(parent)
	local P = ns.Pins
	if not (P and P.BuildLook and P.ApplyLook) then return nil end
	local f = CreateFrame("Frame", nil, parent)
	P.BuildLook(f)
	W.Painter(f, paintPin)
	return f
end

local function placePin(c, o)
	local pin, cv = rawget(c, "Pin"), c.Art.psCanvas
	if not pin then return end
	if not (cv and o.focusX and o.focusY) then return pin:Hide() end
	pin:ClearAllPoints()
	pin:SetPoint("CENTER", c.Art, "TOPLEFT", floor(cv[1] + cv[3] * o.focusX / 100 + 0.5), -floor(cv[2] + cv[4] * o.focusY / 100 + 0.5))
	pin:Show()
end

-- The facts spread across the card: each a glyph, 5 apart its text, a
-- hairline midway between two. Where they do not fit, the widest give way
-- first (cut with an ellipsis; the tooltip has them whole). Rebuilt on a
-- theme change, since the numbers' colours are escapes.
local function paintStats(s)
	local o = s.psOption
	if not o then return end
	local list = facts(o)
	local n = #list
	local natural, total = {}, 0
	for i = 1, 3 do
		local cell, e = s.Cells[i], list[i]
		cell.Glyph:SetShown(e ~= nil)
		cell.Text:SetShown(e ~= nil)
		if e then
			cell.Glyph:SetTexture(Theme.Media(e[1]))
			W.Color(cell.Glyph, e[2])
			natural[i] = STAT_GLYPH + 5 + ceil(W.TextWidth(cell.Text, e[3]))
			total = total + natural[i]
		end
	end
	local room, cap = INNER - max(0, n - 1) * STAT_GAP, math.huge
	if total > room then
		local sorted = {}
		for i = 1, n do sorted[i] = natural[i] end
		table.sort(sorted)
		local left = room
		for i = 1, n do
			local share = left / (n - i + 1)
			if sorted[i] > share then
				cap = floor(share)
				break
			end
			left = left - sorted[i]
		end
	end
	local used, sum = {}, 0
	for i = 1, n do
		used[i] = min(natural[i], cap)
		sum = sum + used[i]
	end
	local gap = n > 1 and (INNER - sum) / (n - 1) or 0
	local x = 0
	for i = 1, n do
		local cell = s.Cells[i]
		cell.Glyph:ClearAllPoints()
		cell.Glyph:SetPoint("LEFT", s, "LEFT", floor(x + 0.5), 0)
		cell.Text:ClearAllPoints()
		cell.Text:SetPoint("LEFT", s, "LEFT", floor(x + STAT_GLYPH + 5 + 0.5), 0)
		cell.Text:SetWidth(max(1, used[i] - STAT_GLYPH - 5))
		x = x + used[i]
		if i < n then
			local d = s.Divs[i]
			d:ClearAllPoints()
			d:SetPoint("CENTER", s, "LEFT", floor(x + gap / 2 + 0.5), 0)
			d:SetHeight(12)
			d:Show()
		end
		x = x + gap
	end
	for i = max(1, n), 2 do s.Divs[i]:Hide() end
end

local function statRow(c)
	local s = CreateFrame("Frame", nil, c)
	s:SetSize(INNER, STAT_H)
	s.Cells, s.Divs = {}, {}
	for i = 1, 3 do
		local g = s:CreateTexture(nil, "ARTWORK")
		g:SetSize(STAT_GLYPH, STAT_GLYPH)
		s.Cells[i] = { Glyph = g, Text = W.Text(s, "number", "text") }
	end
	for i = 1, 2 do s.Divs[i] = W.Divider(s, true) end
	W.Painter(s, paintStats)
	return s
end

-- The whole card, for its tooltip: the facts, the pitch, every pro and con,
-- the guide it goes on to.
local function cardTip(c)
	local o = c.psOption
	if not o then return end
	local lines, parts = {}, {}
	local lv = levelsText(o)
	if lv then parts[#parts + 1] = lv end
	local away = awayText(o.seconds)
	if away then parts[#parts + 1] = away end
	if o.quests and o.quests > 0 then parts[#parts + 1] = format(L["%d quests"], o.quests) end
	if #parts > 0 then lines[#lines + 1] = table.concat(parts, SEP) end
	if o.pitch then lines[#lines + 1] = o.pitch end
	local tr, tg, tb = Theme.Color("text")
	for _, p in ipairs(o.pros or {}) do lines[#lines + 1] = { "+  " .. p, tr, tg, tb } end
	for _, n in ipairs(consOf(o)) do lines[#lines + 1] = "\226\128\147  " .. n end
	if c.Then:IsShown() then
		local t = L["Then:"] .. " " .. o.thenGuideTitle
		if o.thenLevel then t = t .. SEP .. format(L["Level %d"], o.thenLevel) end
		lines[#lines + 1] = { t, tr, tg, tb }
	end
	W.Tooltip(c, "ANCHOR_RIGHT", zoneOf(o), lines)
end

local function artName(parent)
	local fs = W.Text(parent, "display", "text")
	W.Painter(fs, function(t)
		local r, g, b = Theme.Color("shade")
		t:SetShadowOffset(0, -1)
		t:SetShadowColor(r, g, b, 0.85)
	end)
	return fs
end

-- The ground the painting fades into: the card's own. The game's looks paint
-- a card inside a window with their own art over the window's ground (not
-- the panel colour, Classic's tooltip blue), so there the fade runs into that.
local function cardGround()
	return Theme.GameSkin() and "bg" or "panel"
end

local function card(i)
	local c = cards[i]
	if c then return c end
	c = CreateFrame("Button", nil, F)
	c:SetWidth(CARD_W)
	-- A panel card with its hairline, the hover wash over it.
	Theme.Skin(c, "panel")
	W.Hover(c)
	-- The recommended card: a 1px accent outline round it, stronger on top.
	c.Ring = edges(c, c)
	W.Painter(c, function(self)
		local r, g, b = Theme.Accent()
		local px = Theme.Pixel(self)
		for k = 1, 4 do
			local t = self.Ring[k]
			t:SetVertexColor(r, g, b, k == 1 and 0.9 or 0.45)
			if k <= 2 then t:SetHeight(px) else t:SetWidth(px) end
		end
	end)
	-- The zone's painting edge to edge inside the hairline, its name on the fade.
	c.Art = ZoneArt.Create(c, CARD_W - 2, ART_H, cardGround, ART_FADE)
	c.Art:SetPoint("TOPLEFT", c, "TOPLEFT", 1, -1)
	c.Art.Rule:Hide()
	c.Name = artName(c.Art.Over)
	c.Name:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", CARD_PAD - 1, 12)
	c.Name:SetWidth(INNER)
	c.Tag = artTag(c.Art.Over)
	c.Tag:SetPoint("TOPLEFT", c.Art, "TOPLEFT", 10, -10)
	c.Pin = startPin(c.Art.Over)
	c.Pennant = pennant(c)
	-- The facts, straight under the painting at the same y on every card.
	c.Stats = statRow(c)
	c.Stats:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -(1 + ART_H + 14))
	c.Pitch = W.Text(c, "note", "textDim")
	c.Pitch:SetWordWrap(true)
	c.Pitch:SetSpacing(3)
	c.Pitch:SetJustifyV("TOP")
	c.Pitch:SetWidth(INNER)
	c.Rule = W.Divider(c)
	c.Pros, c.Cons = {}, {}
	c.Go = W.Button(c, "", function(self) RC.Choose(self:GetParent().psId) end, { width = INNER, height = GO_H })
	c.Go:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", CARD_PAD, CARD_PAD)
	-- Where the route goes on, over the button: "Then:", the guide's title
	-- (cut to fit; the tooltip has it whole), the level it starts at.
	c.Then = CreateFrame("Frame", nil, c)
	c.Then:SetSize(INNER, THEN_H)
	c.Then:SetPoint("BOTTOMLEFT", c.Go, "TOPLEFT", 0, 12)
	c.Then.Label = W.Text(c.Then, "small", "textMuted")
	c.Then.Label:SetPoint("LEFT", c.Then, "LEFT", 0, 0)
	c.Then.Title = W.Text(c.Then, "label", "text")
	c.Then.Title:SetPoint("LEFT", c.Then.Label, "RIGHT", 6, 0)
	c.Then.Level = W.Text(c.Then, "number", "textDim")
	c.Then.Level:SetPoint("RIGHT", c.Then, "RIGHT", 0, 0)
	c.Then.Glyph = W.Tex(c.Then, "ARTWORK", "icon-level", "icon")
	c.Then.Glyph:SetSize(12, 12)
	c.Then.Glyph:SetPoint("RIGHT", c.Then.Level, "LEFT", -3, 0)
	c.ThenRule = W.Divider(c)
	c.ThenRule:SetPoint("BOTTOMLEFT", c.Then, "TOPLEFT", 0, 11)
	c.ThenRule:SetPoint("BOTTOMRIGHT", c.Then, "TOPRIGHT", 0, 11)
	c:SetScript("OnClick", function(self) RC.Choose(self.psId) end)
	c:SetScript("OnEnter", cardTip)
	c:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	cards[i] = c
	return c
end

-- The "Then" line: shown where the route goes on to a guide of its own.
local function fillThen(c, o, showThen)
	local T = c.Then
	local on = showThen and type(o.thenGuideTitle) == "string" and o.thenGuideTitle ~= ""
	T:SetShown(on and true or false)
	c.ThenRule:SetShown(on and true or false)
	if not on then return end
	T.Label:SetText(L["Then:"])
	T.Title:SetText(o.thenGuideTitle)
	local level = 0
	if o.thenLevel then
		T.Level:SetText(tostring(o.thenLevel))
		level = W.TextWidth(T.Level) + 3 + 12 + 10
	end
	T.Level:SetShown(o.thenLevel ~= nil)
	T.Glyph:SetShown(o.thenLevel ~= nil)
	T.Title:SetWidth(max(24, floor(INNER - W.TextWidth(T.Label) - 6 - level)))
end

-- Fill a card and lay out its content top-down on the grid every card shares
-- (grid.pitch: the tallest pitch; grid.pros / grid.cons: the most bullet
-- rows any card shows), so stat rows, rules and the first con line up across
-- cards. Returns the content height (the "Then" line and the button sit at
-- the bottom once every card's is known).
local function fillCard(c, o, grid, showThen)
	c.psId, c.psOption = o.id, o
	c.psArt = ZoneArt.Paint(c.Art, o.zone, o.focusX, o.focusY, c.psIndex)
	placePin(c, o)
	c.Name:SetText(zoneOf(o))
	local tag, kind = stateOf(o)
	if tag then setTag(c.Tag, tag, kind) else c.Tag:Hide() end
	c.Pennant:SetShown(pennantShown(o))
	c.Stats.psOption = o
	paintStats(c.Stats)
	local y = 1 + ART_H + 14 + STAT_H + 12
	c.Pitch:SetText(o.pitch or "")
	c.Pitch:ClearAllPoints()
	c.Pitch:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -y)
	c.Pitch:SetShown(o.pitch ~= nil)
	if grid.pitch > 0 then y = y + grid.pitch + 14 end
	-- The rule over the pros and cons; a card with none (most of our guides
	-- write a pitch only) keeps the room, so its button lines up, but no rule.
	c.Rule:ClearAllPoints()
	c.Rule:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -y)
	c.Rule:SetPoint("TOPRIGHT", c, "TOPRIGHT", -CARD_PAD, -y)
	c.Rule:SetShown(#(o.pros or {}) + #consOf(o) > 0)
	y = y + 14
	-- One line per bullet; rows = the grid's share, so the next block aligns
	-- across cards.
	local function lines(list, items, cap, rows, glyph, color, textColor, size)
		local n, top = 0, y
		for i, text in ipairs(items) do
			if i > cap then break end
			local b = bullet(c, list, i, glyph, color, textColor)
			b.Glyph:SetSize(size, size)
			b.Glyph:ClearAllPoints()
			b.Glyph:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD + (12 - size) / 2, -(y + 3 + (12 - size) / 2))
			b.Text:SetText(text)
			b.Text:SetWidth(INNER - 20)
			b.Text:ClearAllPoints()
			b.Text:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD + 20, -y)
			b.Glyph:Show()
			b.Text:Show()
			y = y + STEP
			n = i
		end
		for i = n + 1, #list do
			list[i].Glyph:Hide()
			list[i].Text:Hide()
		end
		if rows > n then y = top + rows * STEP end
	end
	lines(c.Pros, o.pros or {}, MAX_PROS, grid.pros, "check", "success", "text", 12)
	if grid.pros > 0 and grid.cons > 0 then y = y + 4 end
	lines(c.Cons, consOf(o), MAX_CONS, 0, "cross", "textMuted", "textDim", 9)
	fillThen(c, o, showThen)
	-- The recommended card leads: the accent outline and the primary button.
	local lead = o.recommended and not o.open
	for k = 1, 4 do c.Ring[k]:SetShown(lead and true or false) end
	c.Go.psPrimary = lead
	Theme.Repaint(c.Go)
	W.RepaintButton(c.Go)
	W.SetButtonText(c.Go, goText(o))
	-- A label longer than the button (a long zone name, a translation) is cut,
	-- centred in the room it has.
	c.Go.Label:SetWidth(INNER - 16)
	c.Go.Label:SetJustifyH("CENTER")
	return y
end

---------------------------------------------------------------------------
-- Window
---------------------------------------------------------------------------

local function build()
	F = CreateFrame("Frame", "PolestarRouteChoice", ns.UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
	F:Hide()
	Theme.Skin(F, "window")

	-- Header: the night sky (in the house style a scrim-to-ground gradient
	-- and the haze under the band), the emblem in its glow, the question.
	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	F.Header = head
	F.Night, F.Haze, F.Band = W.Night(head, { height = HEAD_H, sub = -6 })
	F.HeadRule = W.Divider(head)
	F.HeadRule:SetPoint("BOTTOMLEFT", head, "BOTTOMLEFT", 0, 0)
	F.HeadRule:SetPoint("BOTTOMRIGHT", head, "BOTTOMRIGHT", 0, 0)
	F.Emblem = W.Tex(head, "ARTWORK", "emblem", "accent")
	F.Emblem:SetSize(34, 34)
	F.Emblem:SetPoint("TOPLEFT", head, "TOPLEFT", PAD, -30)
	F.Glow = W.Tex(head, "BORDER", "glow")
	F.Glow:SetSize(84, 84)
	F.Glow:SetPoint("CENTER", F.Emblem, "CENTER", 0, 0)
	W.Painter(F.Glow, function(t)
		local r, g, b = Theme.Accent()
		t:SetVertexColor(r, g, b, 0.3)
		t:SetShown(Theme.SkinKey() == "polestar")
	end)
	F.Title = W.Text(head, "hero", "text")
	F.Title:SetPoint("TOPLEFT", F.Emblem, "TOPRIGHT", 14, 4)
	F.Title:SetText(L["Choose your path"])
	F.Subtitle = W.Text(head, "body", "textDim")
	F.Subtitle:SetPoint("TOPLEFT", F.Title, "BOTTOMLEFT", 0, -8)
	F.Subtitle:SetWordWrap(true)
	F.Subtitle:SetJustifyV("TOP")
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() RC.Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -12)
	W.FrameClose(F, F.Close)

	-- Footer: always take the recommendation; decide later.
	local foot = CreateFrame("Frame", nil, F)
	foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
	foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	foot:SetHeight(FOOT_H)
	W.Fill(foot, "footer")
	F.FootRule = W.Divider(foot)
	F.FootRule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	F.FootRule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	F.Footer = foot
	F.Always = W.Checkbox(foot, function(self)
		ns.Set("behavior.routeChoice", self:GetChecked() and "recommended" or "ask")
	end)
	F.Always:SetPoint("LEFT", foot, "LEFT", PAD, 8)
	-- Two lines beside the checkbox: the setting, and how to choose again.
	F.AlwaysLabel = W.Text(foot, "label", "textDim")
	F.AlwaysLabel:SetPoint("LEFT", F.Always, "RIGHT", 10, 0)
	F.AlwaysLabel:SetText(L["From now on, take the recommended zone"])
	F.Hint = W.Text(foot, "small", "textMuted")
	F.Hint:SetPoint("LEFT", F.Always, "RIGHT", 10, -17)
	F.Hint:SetText(L["Change your mind any time with /polestar path"])
	F.Later = W.Button(foot, L["Decide later"], function() RC.Hide() end, { ghost = true })
	F.Later:SetPoint("RIGHT", foot, "RIGHT", -PAD + 8, 0)
	F.Later.psTip = L["The guide window keeps offering the choice; /polestar path opens it again."]

	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.BASE, "out") end)
	ns.CloseOnEscape("PolestarRouteChoice")
	-- A gamepad (UI/Gamepad.lua) starts on the recommended route. Offered by
	-- itself, the window waits for the player before it takes the gamepad.
	if ns.Gamepad and ns.Gamepad.Register then
		ns.Gamepad.Register(F, {
			initial = function(rows)
				for i, w in ipairs(rows) do if w.psOption and w.psOption.recommended then return i end end
			end,
			back = function() RC.Hide() end,
			unasked = function() return unasked end,
		})
	end
	if W.Rim then W.Rim(F) end
	RC.frame = F
end

local function layout(choice)
	local opts = choice.options
	local n = #opts
	local width = PAD * 2 + n * CARD_W + (n - 1) * GAP
	F:SetWidth(width)
	if W.LayoutRim then W.LayoutRim(F) end
	F.Band:SetTexCoord(Theme.BandCoords(width - 2, HEAD_H))
	-- "You finished Durotar. Both routes meet again in Stonetalon Mountains."
	-- Routes that go on to guides of their own say where on their cards.
	local parts = {}
	if choice.fromTitle and not choice.offeredAgain then parts[#parts + 1] = format(L["You finished %s."], choice.fromTitle) end
	if choice.joinsAt then
		parts[#parts + 1] = format(n == 2 and L["Both routes meet again in %s."] or L["Every route meets again in %s."], choice.joinsAt)
	else
		parts[#parts + 1] = L["Pick where you want to level next."]
	end
	F.Subtitle:SetText(table.concat(parts, " "))
	F.Subtitle:SetWidth(width - PAD * 2 - 48 - 40)

	-- The grid every card shares: the tallest pitch, the most pro and con
	-- rows shown, a "Then" line when any card has one.
	local showThen = choice.joinsAt == nil
	local grid = { pitch = 0, pros = 0, cons = 0, thenLine = false }
	for i, o in ipairs(opts) do
		local c = card(i)
		c.psIndex = i
		c.Pitch:SetText(o.pitch or "")
		if o.pitch then grid.pitch = max(grid.pitch, c.Pitch:GetStringHeight()) end
		grid.pros = max(grid.pros, min(#(o.pros or {}), MAX_PROS))
		grid.cons = max(grid.cons, min(#consOf(o), MAX_CONS))
		if showThen and type(o.thenGuideTitle) == "string" and o.thenGuideTitle ~= "" then grid.thenLine = true end
	end
	local tallest = 0
	for i, o in ipairs(opts) do
		local h = fillCard(cards[i], o, grid, showThen)
		if h > tallest then tallest = h end
	end
	local cardH = tallest + 14 + (grid.thenLine and (1 + 11 + THEN_H + 12) or 0) + GO_H + CARD_PAD
	for i = 1, n do
		local c = cards[i]
		c:SetHeight(cardH)
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", F, "TOPLEFT", PAD + (i - 1) * (CARD_W + GAP), -(HEAD_H + PAD))
		c:Show()
	end
	for i = n + 1, #cards do cards[i]:Hide() end
	F:SetHeight(HEAD_H + PAD + cardH + PAD + FOOT_H)
	F.Always:SetChecked(ns.Get("behavior.routeChoice") == "recommended")
end

-- Show the choice after `id` (a guide whose `next` lists several guides).
-- Returns true when the window opened (or will, after combat). byItself:
-- the engine offered it, the player did not ask (so does a choice put off
-- until a fight ends).
function RC.Show(id, byItself)
	local E = Engine()
	local choice = id and E and E.GetRouteChoice and E.GetRouteChoice(id)
	if not choice or #choice.options < 2 then return false end
	if inCombat() then
		waiting = id
		return true
	end
	waiting = nil
	if not F then build() end
	fromId = id
	choice.offeredAgain = E.PendingRouteChoice and E.PendingRouteChoice() ~= id or false
	current = choice
	layout(choice)
	unasked = byItself and true or false
	F:Show()
	F:Raise()
	return true
end
UI.ShowRouteChoice = function(id) return RC.Show(id) end

function RC.Hide()
	waiting = nil
	if F then F:Hide() end
end

-- An experimental route whose guides could not load says why in chat
-- (Engine.ChooseRoute's reason: the game's AddOns list turned it off, ...).
function RC.Choose(id)
	local E = Engine()
	if not (fromId and id and E and E.ChooseRoute) then return end
	local from = fromId
	RC.Hide()
	local ok, why = E.ChooseRoute(from, id)
	if not ok and why then ns.Print(string.format(L["The experimental guides could not load (%s)."], why)) end
	ns.Set("ui.shown", true)
end

function RC.IsShown()
	return F ~= nil and F:IsShown()
end

ns.On("ROUTE_CHOICE", function(id)
	if ns.IsLoggedIn() then RC.Show(id, true) else waiting = id end
end)

ns.On("ROUTE_CHOSEN", function()
	if F and F:IsShown() then F:Hide() end
end)

-- The ∞ pennant follows ui.newInForever while the window is open.
ns.On("SETTING_CHANGED", function(path)
	if (path == "ui.newInForever" or path == "") and current and F and F:IsShown() then layout(current) end
end)

ns.OnLogin(function()
	if waiting then RC.Show(waiting, true) end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if waiting then RC.Show(waiting, true) end
end)
