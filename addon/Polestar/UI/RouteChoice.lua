-- "Choose your path": the route choice window. Where a guide's `next` names
-- several guides, the Engine asks (ROUTE_CHOICE) instead of deciding, and this
-- window shows one card per zone the character can level in next. Each card
-- reads top-down on one grid shared by every card: the zone painting with its
-- name on it; the stat row that decides it for a leveller ("10–14 · ~2 min
-- away · 28 quests", the levels in text, the rest dim) at the same y on every
-- card; the state chip; the author's pitch; then at most 3 pros and 2 cons, one
-- line each. The full pitch, pros and cons are in the card's tooltip. The
-- recommended zone (one the character has not outlevelled, the quickest to
-- reach) carries an accent hairline and the primary button. Choosing calls
-- Engine.ChooseRoute; "Decide later" and the header ✕ close it, and the guide
-- window keeps offering the choice.
--
-- Colours are Theme tokens only (the name's shadow in shade), repainted on a
-- scheme change.
--
-- Built on first use; nothing runs while it is hidden. In combat the window
-- waits for the fight to end before it opens.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local floor, min, max, ipairs = math.floor, math.min, math.max, ipairs
local ZoneArt = UI.ZoneArt

local RC = {}
UI.RouteChoice = RC

local PAD = 24
local CARD_W = 272
local CARD_PAD = 18
local GAP = 12
local HEAD_H = 112
local FOOT_H = 56
local LINE_GAP = 6
local ART_H = 116 -- the zone art band at the top of each card (UI.ZoneArt)
local MAX_PROS, MAX_CONS = 3, 2 -- the rest wait in the card's tooltip
local SEP = "  \194\183  "

local F -- the window
local cards = {}
local fromId -- the guide whose choice is shown
local waiting -- a choice to show once combat ends
local unasked = false -- the choice on screen came by itself (the engine's offer), not for the player

local function Engine() return ns.Engine end

local function inCombat()
	return InCombatLockdown and InCombatLockdown() or false
end

-- "~3 min away" from travel seconds; nil when unknown.
local function awayText(seconds)
	if type(seconds) ~= "number" then return nil end
	if seconds < 60 then return L["Right here"] end
	local m = floor(seconds / 60 + 0.5)
	if m >= 90 then return L["A long trip from here"] end
	return string.format(L["~%d min away"], m)
end

local function levelsText(o)
	if o.minLevel and o.maxLevel then return string.format("%d\226\128\147%d", o.minLevel, o.maxLevel) end
	return o.minLevel and tostring(o.minLevel) or nil
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
		b.Text = W.Text(c, "small", textColor)
		list[i] = b
	end
	return b
end

-- The stat row: the levels in text, travel and quests dim. Rebuilt from the
-- card's facts on a theme change, since the levels' colour is an escape.
local function paintStats(fs)
	local c = fs:GetParent()
	local parts = {}
	if c.psLevels then parts[1] = "|c" .. Theme.Hex("text") .. c.psLevels .. "|r" end
	for _, f in ipairs(c.psFacts or {}) do parts[#parts + 1] = f end
	fs:SetText(table.concat(parts, SEP))
end

-- The whole card, for its tooltip: stats, pitch, every pro and con.
local function cardTip(c)
	local o = c.psOption
	if not o then return end
	local lines = {}
	local stats = c.Stats:GetText()
	if stats and stats ~= "" then lines[#lines + 1] = stats end
	if o.pitch then lines[#lines + 1] = o.pitch end
	local tr, tg, tb = Theme.Color("text")
	for _, p in ipairs(o.pros or {}) do lines[#lines + 1] = { "+  " .. p, tr, tg, tb } end
	for _, n in ipairs(o.cons or {}) do lines[#lines + 1] = "\226\128\147  " .. n end
	W.Tooltip(c, "ANCHOR_RIGHT", o.zoneName or o.title or o.id, lines)
end

local function card(i)
	local c = cards[i]
	if c then return c end
	c = CreateFrame("Button", nil, F)
	c:SetWidth(CARD_W)
	Theme.Skin(c, "button")
	-- The recommended card: a 1px accent hairline around it, brighter on top.
	c.Ring = {}
	for k = 1, 4 do
		local t = c:CreateTexture(nil, "OVERLAY")
		t:SetTexture(Theme.Media("white"))
		c.Ring[k] = t
	end
	c.Ring[1]:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	c.Ring[1]:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, 0)
	c.Ring[2]:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
	c.Ring[2]:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", 0, 0)
	c.Ring[3]:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	c.Ring[3]:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
	c.Ring[4]:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, 0)
	c.Ring[4]:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", 0, 0)
	W.Painter(c, function(self)
		local r, g, b = Theme.Accent()
		local px = Theme.Pixel(self)
		for k = 1, 4 do
			local t = self.Ring[k]
			t:SetVertexColor(r, g, b, k == 1 and 0.9 or 0.45)
			if k <= 2 then t:SetHeight(px) else t:SetWidth(px) end
		end
	end)
	-- The zone art, with the zone's name over its fade.
	c.Art = ZoneArt.Create(c, CARD_W - 2, ART_H)
	c.Art:SetPoint("TOPLEFT", c, "TOPLEFT", 1, -1)
	c.Name = W.Text(c.Art.Over, "display", "text")
	c.Name:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", CARD_PAD - 1, 12)
	W.Painter(c.Name, function(fs)
		local r, g, b = Theme.Color("shade")
		fs:SetShadowOffset(0, -1)
		fs:SetShadowColor(r, g, b, 0.85)
	end)
	-- The stat row, straight under the painting at the same y on every card.
	c.Stats = W.Text(c, "small", "textDim")
	c.Stats:SetWidth(CARD_W - CARD_PAD * 2)
	c.Stats:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -(ART_H + 12))
	W.Painter(c.Stats, paintStats)
	c.Tag = W.Chip(c)
	c.Pitch = W.Text(c, "note", "textDim")
	c.Pitch:SetWordWrap(true)
	c.Pitch:SetJustifyV("TOP")
	c.Rule = W.Divider(c)
	c.Pros, c.Cons = {}, {}
	c.Go = W.Button(c, "", function(self) RC.Choose(self:GetParent().psId) end, { width = CARD_W - CARD_PAD * 2, height = 32 })
	c.Go:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", CARD_PAD, CARD_PAD)
	c:SetScript("OnClick", function(self) RC.Choose(self.psId) end)
	c:SetScript("OnEnter", cardTip)
	c:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	cards[i] = c
	return c
end

-- Fill a card and lay out its content top-down on the grid every card shares
-- (grid.tag: some card has a state chip; grid.pitch: the tallest pitch;
-- grid.pros / grid.cons: the most bullet rows any card shows), so stat rows,
-- chips, rules and the first con line up across cards. Returns the content
-- height (the button is placed at the bottom once every card's is known).
local function fillCard(c, o, grid)
	c.psId, c.psOption = o.id, o
	local inner = CARD_W - CARD_PAD * 2
	c.psArt = ZoneArt.Paint(c.Art, o.zone, o.focusX, o.focusY, c.psIndex)
	c.Name:SetText(o.zoneName or o.title or o.id)
	c.Name:SetWidth(inner)
	-- "10–14 · ~2 min away · 28 quests"
	local facts = {}
	local away = awayText(o.seconds)
	if away then facts[#facts + 1] = away end
	if o.quests and o.quests > 0 then facts[#facts + 1] = string.format(L["%d quests"], o.quests) end
	c.psLevels, c.psFacts = levelsText(o), facts
	paintStats(c.Stats)
	local y = ART_H + 12 + c.Stats:GetLineHeight() + 12
	local tag, kind
	if o.open then
		tag, kind = L["Your current route"], "success"
	elseif o.recommended then
		tag, kind = L["Recommended"], "accent"
	elseif o.outleveled then
		tag, kind = L["Outlevelled"], "neutral"
	end
	if tag then
		W.SetChip(c.Tag, tag, kind)
		c.Tag:ClearAllPoints()
		c.Tag:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD - 1, -y)
	else
		c.Tag:Hide()
	end
	if grid.tag then y = y + W.CHIP_H + 10 end
	if o.pitch then
		c.Pitch:ClearAllPoints()
		c.Pitch:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -y)
		c.Pitch:Show()
	else
		c.Pitch:Hide()
	end
	if grid.pitch > 0 then y = y + grid.pitch + 14 end
	c.Rule:ClearAllPoints()
	c.Rule:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD, -y)
	c.Rule:SetPoint("TOPRIGHT", c, "TOPRIGHT", -CARD_PAD, -y)
	y = y + 14
	-- One line per bullet (the stat row's role, so one step); rows = the
	-- grid's share, so the next block aligns across cards.
	local step = c.Stats:GetLineHeight() + LINE_GAP
	local function lines(list, items, cap, rows, glyph, color, textColor, size)
		local n = 0
		local top = y
		for i, text in ipairs(items or {}) do
			if i > cap then break end
			local b = bullet(c, list, i, glyph, color, textColor)
			b.Glyph:SetSize(size, size)
			b.Glyph:ClearAllPoints()
			b.Glyph:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD + (12 - size) / 2, -(y + 2 + (12 - size) / 2))
			b.Text:SetText(text)
			b.Text:SetWidth(inner - 20)
			b.Text:ClearAllPoints()
			b.Text:SetPoint("TOPLEFT", c, "TOPLEFT", CARD_PAD + 20, -y)
			b.Glyph:Show()
			b.Text:Show()
			y = y + step
			n = i
		end
		for i = n + 1, #list do
			list[i].Glyph:Hide()
			list[i].Text:Hide()
		end
		if rows > n then y = top + rows * step end
		return n
	end
	lines(c.Pros, o.pros, MAX_PROS, grid.pros, "check", "success", "text", 12)
	if grid.pros > 0 and grid.cons > 0 then y = y + 4 end
	lines(c.Cons, o.cons, MAX_CONS, 0, "cross", "textMuted", "textDim", 9)
	-- The recommended card leads: accent ring and the primary button.
	for k = 1, 4 do c.Ring[k]:SetShown(o.recommended and not o.open) end
	c.Go.psPrimary = o.recommended and not o.open
	Theme.Repaint(c.Go)
	W.RepaintButton(c.Go)
	W.SetButtonText(c.Go, o.open and L["Keep this route"] or string.format(L["Level in %s"], o.zoneName or o.title or o.id))
	return y
end

---------------------------------------------------------------------------
-- Window
---------------------------------------------------------------------------

local function build()
	F = CreateFrame("Frame", "PolestarRouteChoice", UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
	F:Hide()
	Theme.Skin(F, "window")

	-- Header: the night sky, the emblem, the question.
	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function() F:StartMoving() end)
	head:SetScript("OnDragStop", function() F:StopMovingOrSizing() end)
	F.Header = head
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.HeadRule = W.Divider(head)
	F.HeadRule:SetPoint("BOTTOMLEFT", head, "BOTTOMLEFT", 0, 0)
	F.HeadRule:SetPoint("BOTTOMRIGHT", head, "BOTTOMRIGHT", 0, 0)
	F.Emblem = W.Tex(head, "ARTWORK", "emblem", "accent")
	F.Emblem:SetSize(34, 34)
	F.Emblem:SetPoint("TOPLEFT", head, "TOPLEFT", PAD, -30)
	F.Title = W.Text(head, "hero", "text")
	F.Title:SetPoint("TOPLEFT", F.Emblem, "TOPRIGHT", 14, 4)
	F.Title:SetText(L["Choose your path"])
	F.Subtitle = W.Text(head, "note", "textDim")
	F.Subtitle:SetPoint("TOPLEFT", F.Title, "BOTTOMLEFT", 0, -8)
	F.Subtitle:SetWordWrap(true)
	F.Subtitle:SetJustifyV("TOP")
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() RC.Hide() end, 14)
	F.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -12)

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
	RC.frame = F
end

local function layout(choice)
	local opts = choice.options
	local n = #opts
	local width = PAD * 2 + n * CARD_W + (n - 1) * GAP
	F:SetWidth(width)
	F.Band:SetTexCoord(Theme.BandCoords(width - 2, HEAD_H))
	-- "You finished Durotar. Both routes meet again in Stonetalon Mountains."
	local parts = {}
	if choice.fromTitle and not choice.offeredAgain then parts[#parts + 1] = string.format(L["You finished %s."], choice.fromTitle) end
	if choice.joinsAt then
		parts[#parts + 1] = string.format(n == 2 and L["Both routes meet again in %s."] or L["Every route meets again in %s."], choice.joinsAt)
	else
		parts[#parts + 1] = L["Pick where you want to level next."]
	end
	F.Subtitle:SetText(table.concat(parts, " "))
	F.Subtitle:SetWidth(width - PAD * 2 - 48 - 40)

	-- The grid every card shares: a chip row when any card has a state, the
	-- tallest pitch, the most pro and con rows shown.
	local grid = { tag = false, pitch = 0, pros = 0, cons = 0 }
	local inner = CARD_W - CARD_PAD * 2
	for i, o in ipairs(opts) do
		local c = card(i)
		c.psIndex = i
		if o.open or o.recommended or o.outleveled then grid.tag = true end
		c.Pitch:SetWidth(inner)
		c.Pitch:SetText(o.pitch or "")
		if o.pitch then grid.pitch = max(grid.pitch, c.Pitch:GetStringHeight()) end
		grid.pros = max(grid.pros, min(#(o.pros or {}), MAX_PROS))
		grid.cons = max(grid.cons, min(#(o.cons or {}), MAX_CONS))
	end
	local tallest = 0
	for i, o in ipairs(opts) do
		local h = fillCard(cards[i], o, grid)
		if h > tallest then tallest = h end
	end
	local cardH = tallest + 18 + 32 + CARD_PAD
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

function RC.Choose(id)
	local E = Engine()
	if not (fromId and id and E and E.ChooseRoute) then return end
	local from = fromId
	RC.Hide()
	E.ChooseRoute(from, id)
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

ns.OnLogin(function()
	if waiting then RC.Show(waiting, true) end
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if waiting then RC.Show(waiting, true) end
end)
