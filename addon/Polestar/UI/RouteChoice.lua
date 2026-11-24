-- "Choose your path": the route choice window. Where a guide's `next` names
-- several guides, the Engine asks (ROUTE_CHOICE) instead of deciding, and this
-- window shows one card per zone the character can level in next. The window
-- wears the welcome's chrome: the gold rim on top (W.Rim), a night header
-- (the band, and in the house style a gradient and the haze) with the emblem
-- in its glow, the question and where the routes go on: "Both routes meet
-- again in Feralas & Tanaris." when every route goes on to one guide,
-- "Shen'dralas brings you back to Feralas." when one route rejoins another.
-- Each card is a panel with its hairline and reads top-down, the same rows on
-- every card at the same heights:
-- - the zone's painting (UI.ZoneArt) inset in its own hairline, darker at its
--   foot, the zone's name on it; the Forever mark right after the name for a
--   zone whose quests are mostly Forever's own (ui.newInForever, which shows
--   the mark beside quests, shows it);
-- - one line of facts: "40–44  ·  ≈12 min away  ·  21 quests", the numbers
--   lit, the words dim (cut where a language's do not fit; the tooltip has
--   them whole);
-- - the chips: the state ("Recommended", "Your current route",
--   "Experimental" for one of Polestar's experimental guides, "Outlevelled")
--   and "New in Forever" with the mark;
-- - the author's pitch, one short sentence (two lines at most);
-- - a rule, then 3 pros (a check) and 1 con (a cross), a short phrase each
--   on one line;
-- - the button, "Level in <zone>" ("Keep this route" for the one open), at
--   the foot of every card at the same height.
-- The card's tooltip has the facts, the pitch, every pro and con (a detour
-- through another zone first) and, where the routes do not meet again, the
-- guide the route goes on to. The recommended zone (never an experimental
-- guide) carries a 1px accent outline and the primary button. Choosing calls
-- Engine.ChooseRoute; "Decide later" and the header ✕ close it, and the
-- guide window keeps offering the choice.
--
-- Colours are Theme tokens only (the name's shadow and the painting's foot
-- in shade), repainted on a scheme or skin change.
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
local CARD_W = 312 -- a 38-character pro on one line, with room for the client's wider fonts
local CARD_PAD = 16
local INNER = CARD_W - CARD_PAD * 2
local GAP = 14
local HEAD_H = 112
local FOOT_H = 56
local ART_INSET = 8 -- the painting's margin inside the card (sides and top)
local ART_W = CARD_W - ART_INSET * 2
local ART_H = 128
local SCRIM = 0.6 -- the darker foot of the painting, as a share of its height, under the name
local MARK_W, MARK_H = 26, 13 -- the Forever mark after the zone's name
local FACTS_H = 16
local CHIP_GAP = 6
local STEP = 18 -- one pro or con
local GO_H = 32
local MAX_PROS, MAX_CONS = 3, 1
local FIT_MARGIN = 16 -- the least room left above and below a window shrunk to fit the screen
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
-- whatever order the language puts them ("41 quests", "≈12 min away").
local function numbered(fmt, n)
	local dim, txt = "|c" .. Theme.Hex("textDim"), "|c" .. Theme.Hex("text")
	local s = dim .. fmt:gsub("%%[ds]", "|r" .. txt .. n .. "|r" .. dim) .. "|r"
	return (s:gsub("|c%x%x%x%x%x%x%x%x|r", ""))
end

-- The trip on a card: "≈12 min away" (the sign from Theme.Approx, lit with
-- the number), "Right here", "Far away" past an hour and a half (the tooltip
-- says "A long trip from here"); nil when unknown.
local function tripText(seconds)
	if type(seconds) ~= "number" then return nil end
	local dim = "|c" .. Theme.Hex("textDim")
	if seconds < 60 then return dim .. L["Right here"] .. "|r" end
	local m = floor(seconds / 60 + 0.5)
	if m >= 90 then return dim .. L["Far away"] .. "|r" end
	return numbered(L["%s min away"], Theme.Approx() .. m)
end

-- The facts line of option o: the levels, the trip, the quests that are
-- known, the levels lit, the dots between them dim.
local function factsText(o)
	local parts = {}
	local lv = levelsText(o)
	if lv then parts[#parts + 1] = "|c" .. Theme.Hex("text") .. lv .. "|r" end
	local trip = tripText(o.seconds)
	if trip then parts[#parts + 1] = trip end
	if o.quests and o.quests > 0 then parts[#parts + 1] = numbered(L["%d quests"], o.quests) end
	return table.concat(parts, "|c" .. Theme.Hex("textMuted") .. SEP .. "|r")
end

-- Every con, for the tooltip: a detour through another zone first, then the
-- author's. (The card shows the author's: its pitch says where the zone is.)
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
	if o.experimental then return L["Experimental"], "experimental" end
	if o.outleveled then return L["Outlevelled"], "neutral" end
end

local function zoneOf(o)
	return o.zoneName or o.title or o.id
end

local function goText(o)
	if o.open then return L["Keep this route"] end
	return format(L["Level in %s"], zoneOf(o))
end

-- Whether the Forever mark shows: the zone's quests are mostly Forever's own
-- and the player shows the mark (ui.newInForever, Polestar.NewQuests).
local function markShown(o)
	if not o.newInForever then return false end
	local N = ns.NewQuests
	if N and N.Shown then return N.Shown() end
	return ns.Get("ui.newInForever") ~= false
end

-- The chips a card shows, in order: { text, kind, mark }.
local function chipsOf(o)
	local out = {}
	local tag, kind = stateOf(o)
	if tag then out[#out + 1] = { tag, kind } end
	if markShown(o) then out[#out + 1] = { L["New in Forever"], "neutral", true } end
	return out
end

-- The pros and cons a card shows (at most 3 and 1).
local function prosOf(o)
	local out = {}
	for i, p in ipairs(o.pros or {}) do if i <= MAX_PROS then out[i] = p end end
	return out
end

local function cardConsOf(o)
	local out = {}
	for i, n in ipairs(o.cons or {}) do if i <= MAX_CONS then out[i] = n end end
	return out
end

---------------------------------------------------------------------------
-- Cards
---------------------------------------------------------------------------

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

local function paintEdges(e, frame, r, g, b, a)
	local px = Theme.Pixel(frame)
	for k = 1, 4 do
		e[k]:SetVertexColor(r, g, b, a)
		if k <= 2 then e[k]:SetHeight(px) else e[k]:SetWidth(px) end
	end
end

-- One pro or con line, pooled per card: its glyph and one line of text, cut
-- with an ellipsis should a translation run past the card.
local function bullet(c, list, i, glyph, color, textColor, size)
	local b = list[i]
	if not b then
		b = {}
		b.Glyph = W.Tex(c, "ARTWORK", glyph, color)
		b.Glyph:SetSize(size, size)
		b.Text = W.Text(c, "label", textColor)
		b.Text:SetWidth(INNER - 20)
		list[i] = b
	end
	return b
end

-- A chip (W.Chip), with the Forever mark before its text when `mark`;
-- repainted on a theme change.
local function placeChip(ch)
	W.SetChip(ch, ch.psText, ch.psKind)
	ch.Text:ClearAllPoints()
	if ch.psMark then
		local w = ch:GetWidth() + 16 + 4
		ch:SetWidth(w)
		ch.Bg:SetSize(w, W.CHIP_H)
		ch.Text:SetPoint("CENTER", ch, "CENTER", 10, 0)
		ch.Mark:ClearAllPoints()
		ch.Mark:SetPoint("RIGHT", ch.Text, "LEFT", -4, 0)
	else
		ch.Text:SetPoint("CENTER", ch, "CENTER", 0, 0)
	end
	ch.Mark:SetShown(ch.psMark and true or false)
end

local function chip(c, i)
	local ch = c.Chips[i]
	if ch then return ch end
	ch = W.Chip(c)
	ch.Mark = ch:CreateTexture(nil, "OVERLAY")
	ch.Mark:SetTexture(Theme.Media("icon-forever"))
	ch.Mark:SetSize(16, 8)
	ch.Mark:Hide()
	ch.psText, ch.psKind = "", "neutral"
	W.Painter(ch, placeChip)
	c.Chips[i] = ch
	return ch
end

-- The whole card, for its tooltip: the facts, the pitch, every pro and con,
-- the guide it goes on to (where the routes do not meet again). Its lines are
-- made once per option and palette, not on every hover.
local function tipLines(c, o)
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
	if c.psShowThen and type(o.thenGuideTitle) == "string" and o.thenGuideTitle ~= "" then
		local t = L["Then:"] .. " " .. o.thenGuideTitle
		if o.thenLevel then t = t .. SEP .. format(L["Level %d"], o.thenLevel) end
		lines[#lines + 1] = { t, tr, tg, tb }
	end
	return lines
end

local function cardTip(c)
	local o = c.psOption
	if not o then return end
	local pal, shown = Theme.Palette(), c.psShowThen and true or false
	if c.psTipFor ~= o or c.psTipPal ~= pal or c.psTipThen ~= shown then
		c.psTipLines, c.psTipTitle = tipLines(c, o), zoneOf(o)
		c.psTipFor, c.psTipPal, c.psTipThen = o, pal, shown
	end
	W.Tooltip(c, "ANCHOR_RIGHT", c.psTipTitle, c.psTipLines)
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
	-- The zone's painting inset in its own hairline, darker at its foot,
	-- where the zone's name sits (ZoneArt's own fade and top shade off: the
	-- painting ends in its edge, not in the card).
	c.Art = ZoneArt.Create(c, ART_W, ART_H)
	c.Art:SetPoint("TOPLEFT", c, "TOPLEFT", ART_INSET, -ART_INSET)
	c.Art.Rule:Hide()
	c.Art.Fade:Hide()
	c.Art.Top:Hide()
	c.Art.Scrim = c.Art.Over:CreateTexture(nil, "BACKGROUND")
	c.Art.Scrim:SetTexture(Theme.Media("white"))
	c.Art.Scrim:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", 0, 0)
	c.Art.Scrim:SetPoint("BOTTOMRIGHT", c.Art, "BOTTOMRIGHT", 0, 0)
	c.Art.Scrim:SetHeight(floor(ART_H * SCRIM))
	c.Art.Edges = edges(c.Art.Over, c.Art)
	W.Painter(c.Art, function(a)
		local r, g, b = Theme.Color("shade")
		if a.Scrim.SetGradient and CreateColor then
			a.Scrim:SetVertexColor(1, 1, 1, 1)
			a.Scrim:SetGradient("VERTICAL", CreateColor(r, g, b, 0.8), CreateColor(r, g, b, 0))
		else
			a.Scrim:SetVertexColor(r, g, b, 0.4)
		end
		paintEdges(a.Edges, a, Theme.Wash("divider"))
	end)
	c.Name = artName(c.Art.Over)
	c.Name:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", CARD_PAD - ART_INSET, 10)
	c.Mark = c.Art.Over:CreateTexture(nil, "OVERLAY")
	c.Mark:SetTexture(Theme.Media("icon-forever"))
	c.Mark:SetSize(MARK_W, MARK_H)
	c.Mark:SetPoint("LEFT", c.Name, "RIGHT", 8, 0)
	-- The facts, straight under the painting.
	c.Facts = W.Text(c, "label", "textDim")
	c.Facts:SetSize(INNER, FACTS_H)
	c.Facts:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -(ART_INSET + ART_H + 14))
	W.Painter(c.Facts, function(fs) if fs.psOption then fs:SetText(factsText(fs.psOption)) end end)
	c.Chips = {}
	c.Pitch = W.Text(c, "note", "textDim")
	c.Pitch:SetWordWrap(true)
	c.Pitch:SetSpacing(3)
	c.Pitch:SetJustifyV("TOP")
	c.Pitch:SetWidth(INNER)
	c.Rule = W.Divider(c)
	c.Pros, c.Cons = {}, {}
	c.Go = W.Button(c, "", function(self) RC.Choose(self:GetParent().psId) end, { width = INNER, height = GO_H })
	c.Go:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", CARD_PAD, CARD_PAD)
	c:SetScript("OnClick", function(self) RC.Choose(self.psId) end)
	c:SetScript("OnEnter", cardTip)
	c:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	cards[i] = c
	return c
end

-- Fill a card and lay out its content top-down on the grid every card shares
-- (grid.chips: whether any card has a chip; grid.pitch: the tallest pitch;
-- grid.pros / grid.cons: the most pros and cons any card shows), so every
-- row starts at the same height on every card. Returns the content height.
local function fillCard(c, o, grid)
	c.psId, c.psOption = o.id, o
	c.psArt = ZoneArt.Paint(c.Art, o.zone, o.focusX, o.focusY, c.psIndex)
	-- The name, and the Forever mark right after it (the name cut first
	-- where both do not fit).
	local mark = markShown(o)
	c.Name:SetWidth(0)
	local room = ART_W - (CARD_PAD - ART_INSET) * 2 - (mark and MARK_W + 8 or 0)
	c.Name:SetWidth(min(ceil(W.TextWidth(c.Name, zoneOf(o))) + 1, room))
	c.Mark:SetShown(mark)
	c.Facts.psOption = o
	c.Facts:SetText(factsText(o))
	local y = ART_INSET + ART_H + 14 + FACTS_H + 10
	-- The chips, left to right.
	local list = chipsOf(o)
	local x = 0
	for i, e in ipairs(list) do
		local ch = chip(c, i)
		ch.psText, ch.psKind, ch.psMark = e[1], e[2], e[3]
		placeChip(ch)
		ch:ClearAllPoints()
		ch:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD + x, -y)
		x = x + ch:GetWidth() + CHIP_GAP
	end
	for i = #list + 1, #c.Chips do c.Chips[i]:Hide() end
	if grid.chips then y = y + W.CHIP_H + 10 end
	c.Pitch:SetText(o.pitch or "")
	c.Pitch:ClearAllPoints()
	c.Pitch:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -y)
	c.Pitch:SetShown(o.pitch ~= nil)
	if grid.pitch > 0 then y = y + grid.pitch + 14 end
	-- The rule over the pros and cons; a card with none keeps the room, so
	-- its button lines up, but no rule.
	local pros, cons = prosOf(o), cardConsOf(o)
	c.Rule:ClearAllPoints()
	c.Rule:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -y)
	c.Rule:SetPoint("TOPRIGHT", c, "TOPRIGHT", -CARD_PAD, -y)
	c.Rule:SetShown(#pros + #cons > 0)
	if grid.pros + grid.cons > 0 then y = y + 14 end
	-- One line each; the cons start on the same line on every card.
	local function lines(pool, items, rows, glyph, color, textColor, size)
		for i, text in ipairs(items) do
			local b = bullet(c, pool, i, glyph, color, textColor, size)
			local top = y + (i - 1) * STEP
			b.Text:SetText(text)
			b.Glyph:ClearAllPoints()
			b.Glyph:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD + (12 - size) / 2, -(top + 3 + (12 - size) / 2))
			b.Text:ClearAllPoints()
			b.Text:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD + 20, -top)
			b.Glyph:Show()
			b.Text:Show()
		end
		for i = #items + 1, #pool do
			pool[i].Glyph:Hide()
			pool[i].Text:Hide()
		end
		y = y + rows * STEP
	end
	lines(c.Pros, pros, grid.pros, "check", "success", "text", 12)
	if grid.pros > 0 and grid.cons > 0 then y = y + 4 end
	lines(c.Cons, cons, grid.cons, "cross", "textMuted", "textDim", 9)
	-- The recommended card leads: the accent outline and the primary button.
	local lead = o.recommended and not o.open
	for k = 1, 4 do c.Ring[k]:SetShown(lead and true or false) end
	c.Go.psPrimary = lead
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
	ns.DragWindow(head, F)
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
	F.Subtitle:SetSpacing(3)
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

-- Where the routes go on, for the header: every route to one guide ("Both
-- routes meet again in Feralas & Tanaris."), or one route back to another
-- route of the choice ("Shen'dralas brings you back to Feralas."); nil when
-- each goes its own way.
local function onwardText(choice)
	local opts = choice.options
	if choice.joinsAt then
		return format(#opts == 2 and L["Both routes meet again in %s."] or L["Every route meets again in %s."], choice.joinsAt)
	end
	for _, o in ipairs(opts) do
		for _, t in ipairs(opts) do
			if o.thenId and t ~= o and t.id == o.thenId then return format(L["%s brings you back to %s."], zoneOf(o), zoneOf(t)) end
		end
	end
end

local function layout(choice)
	local opts = choice.options
	local n = #opts
	local width = PAD * 2 + n * CARD_W + (n - 1) * GAP
	F:SetWidth(width)
	if W.LayoutRim then W.LayoutRim(F) end
	F.Band:SetTexCoord(Theme.BandCoords(width - 2, HEAD_H))
	-- "You finished Badlands. Both routes meet again in Feralas & Tanaris."
	local parts = {}
	if choice.fromTitle and not choice.offeredAgain then parts[#parts + 1] = format(L["You finished %s."], choice.fromTitle) end
	parts[#parts + 1] = onwardText(choice) or L["Pick where you want to level next."]
	F.Subtitle:SetText(table.concat(parts, " "))
	F.Subtitle:SetWidth(width - PAD * 2 - 48 - 40)

	-- The grid every card shares: whether any card has a chip, the tallest
	-- pitch, the most pros and cons any card shows.
	local showThen = choice.joinsAt == nil
	local grid = { chips = false, pitch = 0, pros = 0, cons = 0 }
	for i, o in ipairs(opts) do
		local c = card(i)
		c.psIndex, c.psShowThen = i, showThen
		c.Pitch:SetText(o.pitch or "")
		if o.pitch then grid.pitch = max(grid.pitch, c.Pitch:GetStringHeight()) end
		if #chipsOf(o) > 0 then grid.chips = true end
		grid.pros = max(grid.pros, #prosOf(o))
		grid.cons = max(grid.cons, #cardConsOf(o))
	end
	local tallest = 0
	for i, o in ipairs(opts) do
		local h = fillCard(cards[i], o, grid)
		if h > tallest then tallest = h end
	end
	local cardH = tallest + 22 + GO_H + CARD_PAD
	for i = 1, n do
		local c = cards[i]
		c:SetHeight(cardH)
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", F, "TOPLEFT", PAD + (i - 1) * (CARD_W + GAP), -(HEAD_H + PAD))
		c:Show()
	end
	for i = n + 1, #cards do cards[i]:Hide() end
	local height = HEAD_H + PAD + cardH + PAD + FOOT_H
	F:SetHeight(height)
	-- Taller than the screen (a large UI scale): the whole window shrinks to
	-- fit, so nothing runs off its top or bottom, and sits in the screen's
	-- middle (its usual place, a little above, would push its top off). (Its
	-- layer, Polestar.UIParent, is the screen's size at UIParent's scale.)
	local room = UIParent:GetHeight() or 0
	local fit = room > 0 and min(1, (room - FIT_MARGIN * 2) / height) or 1
	F:SetScale(fit)
	if room > 0 and height * fit + 2 * (FIT_MARGIN + 40) > room then
		F:ClearAllPoints()
		F:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
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

-- The Forever mark follows ui.newInForever while the window is open.
ns.On("SETTING_CHANGED", function(path)
	if (path == "ui.newInForever" or path == "") and current and F and F:IsShown() then layout(current) end
end)

ns.OnLogin(function()
	if waiting then RC.Show(waiting, true) end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if waiting then RC.Show(waiting, true) end
end)
