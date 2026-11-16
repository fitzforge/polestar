-- What a route is worth in levels, as a chip and its tooltip: the chip says
-- it ("+1.3 levels", "+25% of a level"; "Recommended: level 12" below where the
-- route starts); hovering it opens a panel of the house's own (not the game
-- tooltip: it draws a bar) with the XP, a bar of the levels it spans (one
-- cell a level: what is earned already, what the route adds), where the
-- character is now (or starts) and after, and what was counted: quests, the
-- kills estimated for a guide. Below the start level the panel says so first
-- and sums from there. The summary is Levels.Run's (Core/Levels.lua). Used by
-- the dungeon page (UI/Dungeons.lua) and the guide menu's details
-- (UI/Picker.lua).
--
--   LevelTip.Chip(parent, host) -> chip   -- host: the window the panel opens on
--   LevelTip.Set(chip, summary, texts) -> width | nil   -- nil (hidden): nothing to show
--       texts = { head = "If you finish this guide", need = "You are level %d. Level %d is recommended ...; from there:",
--         chip = words of its own for the chip (a quest chain's "1,640 XP with its chain"), else the levels }
--   LevelTip.Show(chip) ; LevelTip.Hide() ; LevelTip.Frame() -> the panel | nil
--   LevelTip.Text(levels) -> "+1.3 levels" | "+25% of a level"
--
-- Every text and colour is the theme's (W.Text roles, palette names): a
-- change of font, skin, scheme or accent repaints them, and the chips and an
-- open panel are laid out again for the new metrics.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, format, tostring, ipairs, concat = math.floor, math.max, math.min, string.format, tostring, ipairs, table.concat

local LevelTip = {}
UI.LevelTip = LevelTip

local TIP_W, TIP_PAD, BAR_H, BAR_GAP, BAR_CELLS = 300, 14, 10, 3, 6

local chips = {} -- every chip made, to repaint on a theme change
local tip -- the panel, built on first hover
local owner -- the chip the panel is open for

local thousands = ns.Thousands

function LevelTip.Text(levels)
	if levels >= 0.995 then return format(L["+%s levels"], ns.Decimal(levels, 1)) end
	return format(L["+%d%% of a level"], max(1, floor(levels * 100 + 0.5)))
end

-- The breakdown's rows, in this order (Dungeons.QuestXP's groups).
local GROUPS = { "ready", "level", "chain" }

-- What each group adds, in the headline's own unit (1% of a level, or 0.1
-- level from +1.0 levels on), split by its share of the quest XP so the rows
-- add up to the headline exactly (largest remainder). -> { { group, n, need,
-- text }, ... } in GROUPS order, groups with no quest left out; nil without groups.
function LevelTip.Shares(s)
	local g = s and s.groups
	if not g or (s.questXP or 0) <= 0 then return nil end
	local whole = s.levels >= 0.995
	local units = whole and floor(s.levels * 10 + 0.5) or max(1, floor(s.levels * 100 + 0.5))
	local rows, given = {}, 0
	for _, name in ipairs(GROUPS) do
		local x = g[name]
		if x and x.n > 0 then
			local exact = units * x.xp / s.questXP
			local r = { group = name, n = x.n, need = x.need, units = floor(exact), rest = exact - floor(exact) }
			given = given + r.units
			rows[#rows + 1] = r
		end
	end
	if #rows == 0 then return nil end
	local order = {}
	for i = 1, #rows do order[i] = i end
	table.sort(order, function(a, b)
		if rows[a].rest ~= rows[b].rest then return rows[a].rest > rows[b].rest end
		return a < b
	end)
	for k = 1, units - given do
		local r = rows[order[(k - 1) % #rows + 1]]
		r.units = r.units + 1
	end
	for _, r in ipairs(rows) do
		if whole then
			r.text = format(L["+%s levels"], ns.Decimal(r.units / 10, 1))
		elseif r.units < 1 then
			r.text = L["<1%"]
		else
			r.text = format(L["+%d%%"], r.units)
		end
	end
	return rows
end

local function percentOf(t)
	return t.need > 0 and floor(t.xp / t.need * 100) or 0
end

-- "Now: 82% into level 30" over "After: 47% into level 31": the ready quests alone (summary.ready).
local function readyLine(s)
	local r = s.ready
	if not r then return nil end
	local now = format(L["Now: %d%% into level %d"], percentOf(r.from), r.from.level)
	local after
	if r.to.level >= ns.Levels.MAX_LEVEL then
		after = format(L["After: level %d"], r.to.level)
	else
		after = format(L["After: %d%% into level %d"], percentOf(r.to), r.to.level)
	end
	return now, after
end

local function rowLabel(r)
	local label
	if r.group == "level" then
		label = format(L["Need level %d first"], r.need or 0)
	elseif r.group == "chain" then
		label = L["Need a quest chain first"]
	else
		label = L["Ready to take and hand in"]
	end
	return format(L["%s · %s"], label, r.n == 1 and L["1 quest"] or format(L["%d quests"], r.n))
end

-- "Not counted: 2 not for your class, 1 other faction, ...": what a dungeon's sum left out.
local function leftOut(s)
	local lf, parts = s.left or {}, {}
	local function add(n, one, many)
		if (n or 0) > 0 then parts[#parts + 1] = n == 1 and one or format(many, n) end
	end
	add(lf.class, L["1 not for your class"], L["%d not for your class"])
	add(lf.race, L["1 not for your race"], L["%d not for your race"])
	add(lf.faction, L["1 for the other faction"], L["%d for the other faction"])
	add(lf.closed, L["1 closed by a quest you took"], L["%d closed by a quest you took"])
	add(lf.alt, L["1 alternative to another quest"], L["%d alternatives to other quests"])
	add(s.done, L["1 already done"], L["%d already done"])
	add(s.unknown, L["1 with no XP known"], L["%d with no XP known"])
	if #parts == 0 then return nil end
	return format(L["Not counted: %s"], concat(parts, ", "))
end


local function build()
	local t = CreateFrame("Frame", nil, ns.UIParent)
	t:SetFrameStrata("TOOLTIP")
	t:SetClampedToScreen(true)
	t:SetWidth(TIP_W)
	-- Opaque, unlike the window's ground: what it opens over stays under it.
	local function solid(color, sub)
		local tex = W.Tex(t, "BACKGROUND", nil, nil, sub)
		W.Painter(tex, function(x)
			local r, g, b = Theme.Color(color)
			x:SetVertexColor(r, g, b, 1)
		end)
		return tex
	end
	t.Edge = solid("windowBorder", -8)
	t.Edge:SetAllPoints(t)
	t.Ground = solid("panel", -7)
	t.Ground:SetPoint("TOPLEFT", t, "TOPLEFT", 1, -1)
	t.Ground:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", -1, 1)
	t.Head = W.Text(t, "small", "textMuted")
	t.Head:SetPoint("TOPLEFT", t, "TOPLEFT", TIP_PAD, -TIP_PAD)
	-- Below the start level: what to reach first (layout places it and the levels).
	t.Need = W.Text(t, "note", "warning")
	t.Need:SetWordWrap(true)
	t.Need:SetJustifyV("TOP")
	t.Levels = W.Text(t, "display", "accent")
	t.XP = W.Text(t, "number", "textDim")
	t.XP:SetJustifyH("RIGHT")
	t.XP:SetPoint("BOTTOM", t.Levels, "BOTTOM", 0, 0)
	t.XP:SetPoint("RIGHT", t, "RIGHT", -TIP_PAD, 0)
	t.Bar = CreateFrame("Frame", nil, t)
	t.Bar:SetHeight(BAR_H)
	t.Bar:SetPoint("TOPLEFT", t.Levels, "BOTTOMLEFT", 0, -12)
	t.Cells, t.Marks = {}, {}
	for i = 1, BAR_CELLS do
		local c = CreateFrame("Frame", nil, t.Bar)
		c:SetHeight(BAR_H)
		c.Track = W.Tex(c, "BACKGROUND")
		c.Track:SetAllPoints(c)
		W.Painter(c.Track, function(tex) tex:SetVertexColor(Theme.Wash("progress")) end)
		c.Earned = W.Tex(c, "BORDER", nil, "textMuted")
		c.Earned:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
		c.Earned:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
		c.Gain = W.Tex(c, "ARTWORK", nil, "accent")
		t.Cells[i] = c
	end
	for i = 1, BAR_CELLS + 1 do t.Marks[i] = W.Text(t, "small", "textMuted") end
	-- The legend: a swatch and a line for where you are, then where the quests leave you.
	-- The swatch sits on its line's middle, whatever the font's height.
	local function legend(color)
		local fs = W.Text(t, "small", "textDim")
		local sw = W.Tex(t, "ARTWORK", nil, color)
		sw:SetSize(8, 8)
		sw:SetPoint("RIGHT", fs, "LEFT", -6, 0)
		return sw, fs
	end
	t.NowSw, t.Now = legend("textMuted")
	t.ThenSw, t.Then = legend("accent")
	t.Rule = W.Divider(t)
	t.Rule:SetPoint("RIGHT", t, "RIGHT", -TIP_PAD, 0)
	-- The breakdown (a dungeon's: summary.groups): a label on the left, its share on the right.
	t.RowL, t.RowR = {}, {}
	for i = 1, #GROUPS do
		t.RowL[i] = W.Text(t, "small", "textDim")
		t.RowR[i] = W.Text(t, "number", "accent")
		t.RowR[i]:SetJustifyH("RIGHT")
	end
	-- Under the ready row: where those quests alone take you, from now.
	t.ReadyNow = W.Text(t, "small", "textMuted")
	t.ReadyThen = W.Text(t, "small", "textMuted")
	t.Notes = W.Text(t, "note", "textDim")
	t.Notes:SetWordWrap(true)
	t.Notes:SetJustifyV("TOP")
	t.Notes:SetSpacing(3)
	t:Hide()
	return t
end

-- The cells of the bar: one per level from where you are to where the
-- quests leave you (the last level before 60 at most, BAR_CELLS at most).
local function paintBar(t, s, barW)
	local first = s.from.level
	local last = min(s.to.level, ns.Levels.MAX_LEVEL - 1, first + BAR_CELLS - 1)
	local n = max(1, last - first + 1)
	local cw = (barW - BAR_GAP * (n - 1)) / n
	for i = 1, BAR_CELLS do
		local c = t.Cells[i]
		if i > n then
			c:Hide()
		else
			local level = first + i - 1
			local from = i == 1 and (s.from.need > 0 and s.from.xp / s.from.need or 0) or 0
			local to = 1
			if level == s.to.level then to = s.to.need > 0 and s.to.xp / s.to.need or 0 end
			c:ClearAllPoints()
			c:SetPoint("TOPLEFT", t.Bar, "TOPLEFT", (i - 1) * (cw + BAR_GAP), 0)
			c:SetWidth(cw)
			c.Earned:SetWidth(max(0.01, cw * from))
			c.Earned:SetShown(from > 0)
			c.Gain:ClearAllPoints()
			c.Gain:SetPoint("TOPLEFT", c, "TOPLEFT", cw * from, 0)
			c.Gain:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", cw * from, 0)
			c.Gain:SetWidth(max(0.01, cw * (to - from)))
			c.Gain:SetShown(to > from)
			c:Show()
		end
	end
	-- The level at each cell's start, and the next one at the bar's end.
	for i = 1, BAR_CELLS + 1 do
		local m = t.Marks[i]
		if i > n + 1 then
			m:Hide()
		else
			m:ClearAllPoints()
			m:SetText(tostring(first + i - 1))
			if i == n + 1 then
				m:SetPoint("TOPRIGHT", t.Bar, "BOTTOMRIGHT", 0, -5)
			else
				m:SetPoint("TOPLEFT", t.Bar, "BOTTOMLEFT", (i - 1) * (cw + BAR_GAP), -5)
			end
			W.Color(m, (i == 1 or i == n + 1) and "textDim" or "textMuted")
			m:Show()
		end
	end
	return t.Marks[1]:GetStringHeight()
end

local function notesOf(s, rows)
	if rows then
		-- The rows say how many count; the notes, what gives less and what was left out.
		local notes = {}
		if s.reduced > 0 then
			notes[#notes + 1] = s.reduced == 1 and L["1 gives less XP: by then you are 6 or more levels above it."]
				or format(L["%d give less XP: by then you are 6 or more levels above them."], s.reduced)
		end
		notes[#notes + 1] = leftOut(s)
		return concat(notes, "\n")
	end
	local notes = { s.quests == 1 and L["1 quest for you, not done yet."] or format(L["%d quests for you, not done yet."], s.quests) }
	if s.kills > 0 then
		notes[#notes + 1] = format(L["%s XP from quests, about %s from %d kills the guide asks for."], thousands(s.questXP), thousands(s.killXP), s.kills)
	end
	if s.killsUnknown > 0 then
		notes[#notes + 1] = s.killsUnknown == 1 and L["1 kill or loot goal could not be estimated."]
			or format(L["%d kill or loot goals could not be estimated."], s.killsUnknown)
	end
	if s.reduced > 0 then
		notes[#notes + 1] = s.reduced == 1 and L["1 gives less XP: by then you are 6 or more levels above it."]
			or format(L["%d give less XP: by then you are 6 or more levels above them."], s.reduced)
	end
	if s.unknown > 0 then
		notes[#notes + 1] = s.unknown == 1 and L["1 more has no XP known and is not counted."]
			or format(L["%d more have no XP known and are not counted."], s.unknown)
	end
	if s.done > 0 then notes[#notes + 1] = L["Quests you have done are left out."] end
	return concat(notes, "\n")
end

-- The panel for a chip, laid out for the theme's current metrics: as wide as
-- its widest line needs (TIP_W at least), as tall as its texts.
local function layout(t, chip)
	local s = chip.psXP
	local texts = chip.psTexts or {}
	t.Head:SetText(texts.head or "")
	t.Levels:SetText(LevelTip.Text(s.levels))
	t.XP:SetText(format(L["%s XP"], thousands(s.xp)))
	if s.below then
		t.Now:SetText(format(L["Start: level %d"], s.below))
	else
		t.Now:SetText(format(L["Now: %d%% into level %d"], percentOf(s.from), s.from.level))
	end
	if s.to.level >= ns.Levels.MAX_LEVEL then
		t.Then:SetText(format(L["After: level %d"], s.to.level))
	else
		t.Then:SetText(format(L["After: %d%% into level %d"], percentOf(s.to), s.to.level))
	end
	-- The breakdown's texts first: its widest row widens the panel.
	local rows = LevelTip.Shares(s)
	local rowW = 0
	for i = 1, #GROUPS do
		local row = rows and rows[i]
		if row then
			t.RowL[i]:SetText(rowLabel(row))
			t.RowR[i]:SetText(row.text)
			rowW = max(rowW, t.RowL[i]:GetStringWidth() + 24 + t.RowR[i]:GetStringWidth())
		end
	end
	local subNow, subThen
	-- Only beside other rows: alone, the ready quests' Now and After are the legend's own.
	if rows and #rows > 1 and rows[1].group == "ready" then subNow, subThen = readyLine(s) end
	local sub = subNow ~= nil
	t.ReadyNow:SetText(subNow or "")
	t.ReadyThen:SetText(subThen or "")
	t.ReadyNow:SetShown(sub)
	t.ReadyThen:SetShown(sub)
	if sub then rowW = max(rowW, t.ReadyNow:GetStringWidth(), t.ReadyThen:GetStringWidth()) end
	local width = max(TIP_W,
		rowW + TIP_PAD * 2,
		t.Levels:GetStringWidth() + 24 + t.XP:GetStringWidth() + TIP_PAD * 2,
		t.Head:GetStringWidth() + TIP_PAD * 2,
		max(t.Now:GetStringWidth(), t.Then:GetStringWidth()) + 14 + TIP_PAD * 2)
	width = floor(width + 0.5)
	local inner = width - TIP_PAD * 2
	t:SetWidth(width)
	-- The need line, when below the start level, between the head and the levels.
	local needH = 0
	t.Need:SetShown(s.below ~= nil)
	t.Levels:ClearAllPoints()
	if s.below then
		t.Need:SetWidth(inner)
		t.Need:SetText(format(texts.need or "%d %d", s.now.level, s.below))
		t.Need:ClearAllPoints()
		t.Need:SetPoint("TOPLEFT", t.Head, "BOTTOMLEFT", 0, -6)
		t.Levels:SetPoint("TOPLEFT", t.Need, "BOTTOMLEFT", 0, -8)
		needH = t.Need:GetStringHeight() + 8
	else
		t.Levels:SetPoint("TOPLEFT", t.Head, "BOTTOMLEFT", 0, -6)
	end
	t.Bar:SetWidth(inner)
	local markH = paintBar(t, s, inner)
	-- The legend's lines under the marks, the swatches left of them.
	local lineH = max(8, t.Now:GetStringHeight())
	t.Now:ClearAllPoints()
	t.Now:SetPoint("TOPLEFT", t.Bar, "BOTTOMLEFT", 14, -(5 + markH + 10))
	t.Then:ClearAllPoints()
	t.Then:SetPoint("TOPLEFT", t.Now, "BOTTOMLEFT", 0, -2)
	t.Rule:ClearAllPoints()
	t.Rule:SetPoint("TOPLEFT", t.Then, "BOTTOMLEFT", -14, -12)
	t.Rule:SetPoint("RIGHT", t, "RIGHT", -TIP_PAD, 0)
	-- The breakdown rows under the rule, each a label and its share.
	local rowsH, above = 0, t.Rule
	for i = 1, #GROUPS do
		local l, r = t.RowL[i], t.RowR[i]
		local row = rows and rows[i]
		l:SetShown(row ~= nil)
		r:SetShown(row ~= nil)
		if row then
			l:ClearAllPoints()
			l:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, i == 1 and -10 or -6)
			r:ClearAllPoints()
			r:SetPoint("TOP", l, "TOP", 0, 0)
			r:SetPoint("RIGHT", t, "RIGHT", -TIP_PAD, 0)
			local rh = max(l:GetStringHeight(), r:GetStringHeight())
			rowsH = rowsH + (i == 1 and 10 or 6) + rh
			above = l
			if i == 1 and sub then
				t.ReadyNow:ClearAllPoints()
				t.ReadyNow:SetPoint("TOPLEFT", l, "BOTTOMLEFT", 0, -3)
				t.ReadyThen:ClearAllPoints()
				t.ReadyThen:SetPoint("TOPLEFT", t.ReadyNow, "BOTTOMLEFT", 0, -2)
				rowsH = rowsH + 3 + t.ReadyNow:GetStringHeight() + 2 + t.ReadyThen:GetStringHeight()
				above = t.ReadyThen
			end
		end
	end
	local notes = notesOf(s, rows)
	t.Notes:SetWidth(inner)
	t.Notes:SetText(notes)
	t.Notes:SetShown(notes ~= "")
	t.Notes:ClearAllPoints()
	t.Notes:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, rows and -12 or -10)
	local notesH = notes ~= "" and ((rows and 12 or 10) + t.Notes:GetStringHeight()) or 0
	-- Top to bottom: the head, the levels, the bar, its marks, the legend's
	-- two lines, the rule, the breakdown, the notes.
	local h = TIP_PAD + t.Head:GetStringHeight() + 6 + needH + t.Levels:GetStringHeight() + 12 + BAR_H
		+ 5 + markH + 10 + lineH + 2 + lineH + 12 + 1 + rowsH + notesH + TIP_PAD
	t:SetHeight(floor(h + 0.5))
end

-- Where the panel starts, left of the chip's own left edge: the chip's
-- psTipX (its window's choice: the guide menu lines it up with the details'
-- text), then far enough left to end inside its window, 8 in from the edge.
local function offset(chip)
	local x = chip.psTipX or 0
	local host = chip.psHost
	local left, right = chip:GetLeft(), host and host.GetRight and host:GetRight()
	if not (left and right) then return x end
	return x - max(0, floor(left + x + tip:GetWidth() - (right - 8) + 0.5))
end

-- Laid out and placed under its chip.
local function present(chip)
	layout(tip, chip)
	tip:ClearAllPoints()
	tip:SetPoint("TOPLEFT", chip, "BOTTOMLEFT", offset(chip), -8)
end

function LevelTip.Show(chip)
	if not (chip and chip.psXP) then return end
	tip = tip or build()
	owner = chip
	-- On the chip's window, so it takes the window's scale; over everything.
	tip:SetParent(chip.psHost or UIParent)
	tip:SetFrameStrata("TOOLTIP")
	present(chip)
	tip:Show()
end

function LevelTip.Hide()
	owner = nil
	if tip then tip:Hide() end
end

function LevelTip.Frame() return tip end

function LevelTip.Chip(parent, host)
	local c = W.Chip(parent)
	c.psHost = host
	c:EnableMouse(true)
	c:SetScript("OnEnter", function(self) LevelTip.Show(self) end)
	c:SetScript("OnLeave", function() LevelTip.Hide() end)
	c:Hide()
	chips[#chips + 1] = c
	return c
end

-- A chip's words and kind: the levels in the accent, or the recommended
-- level in the warning colour.
local function paintChip(c)
	local s = c.psXP
	local own = c.psTexts and c.psTexts.chip
	if own then return W.SetChip(c, own, s.below and "warning" or "accent") end
	if s.below then return W.SetChip(c, format(L["Recommended: level %d"], s.below), "warning") end
	return W.SetChip(c, LevelTip.Text(s.levels), "accent")
end

-- A chip for a summary: shown while there is XP to gain (not at 60),
-- hidden otherwise. -> its width | nil
function LevelTip.Set(c, s, texts)
	if not (s and not s.maxed and s.xp > 0) then
		if owner == c then LevelTip.Hide() end
		c.psXP = nil
		c:Hide()
		return nil
	end
	c.psXP, c.psTexts = s, texts
	local w = paintChip(c)
	-- Open for this chip (still hovered as its window renders again): the new numbers.
	if owner == c and tip and tip:IsShown() then present(c) end
	return w
end

-- A new font, skin, scheme or accent: the chips take the new accent and
-- their new widths; an open panel is laid out again.
Theme.OnChanged(function()
	for _, c in ipairs(chips) do
		if c.psXP and c:IsShown() then paintChip(c) end
	end
	if owner and tip and tip:IsShown() then present(owner) end
end)
