-- The dungeon tracker (docs/DESIGN.md, "The Dungeon Tracker"): inside a
-- dungeon or raid where the character holds quests for it, what is left for
-- those quests, the bosses in kill order with the ones dead checked off, and
-- "Loot <item> from <boss>" when a boss that died dropped something a quest
-- still needs. Its model: Dungeons.Run.Model() (Dungeons/Run.lua).
--
-- It floats (PolestarDungeonTracker, one of UI/Trackers.lua's panels, kind
-- "dungeon": trackers.dungeon.enabled, scale, width, opacity, type sizes,
-- ground, combat show/fade/hide, bossesAlone, its place) whatever guide is
-- open, and even while the guide window waits out the dungeon (ui.instance
-- "hide"). With the guide window shown there, it docks into the window
-- instead (the region "tracker", GF.RegionOverride, every guide kind): never
-- two copies. In a fight its counts keep updating; a change of its height
-- waits for the fight's end, so it never jumps mid-pull.
--
-- Its three parts (loot, quests, bosses) are each a frame a layout may place
-- itself (Skin API 2, trackerPlace(name, frame, width, height); Atlas's cards:
-- Polestar_Skins/Layouts/Atlas/AtlasDungeon.lua), floating and docked alike.
--
--   UI.DungeonTracker.Refresh()
--   UI.DungeonTracker.ShowSample([docked]) / HideSample()   a made-up run (the skins sweep, the preview), floating or docked
--   UI.DungeonTracker.Build(parent, pad[, frame]) -> view ; Paint(view, model, compact) ; Layout(view, width, compact) -> height
--   UI.DungeonTracker.NewSandbox(parent) -> frame   the options' preview (frame:Fill() draws the sample)
--   UI.DungeonTracker.Model() -> model | nil         the run's (or the sample's) model on screen
--   UI.DungeonTracker.UseItem() -> itemID | nil      the run's quest item, for the quest item button
--   UI.DungeonTracker.SAMPLE                        the sample's model

local ADDON, ns = ...
local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L
local floor, ceil, max, min, format, concat = math.floor, math.ceil, math.max, math.min, string.format, table.concat

local DT = {}
UI.DungeonTracker = DT

local DOT = " \194\183 "
local LINE, TITLE, BOSS, HEAD = 18, 21, 20, 30
local BOSS_ROWS = 10 -- a raid's list: this many rows round the next boss

local function TR() return UI.Trackers end
local function col(token, text) return "|c" .. Theme.Hex(token) .. tostring(text) .. "|r" end
local function inCombat() local C = ns.Compat; return C and C.InCombat and C.InCombat() or false end
local function hook(row, item, info) Theme.SkinHook("guideKindRow", row, item, info) end
-- The run's time ("18:42"), as the instance tracker writes it; "" without Maps.
local function clock(s) local M = ns.Maps; return M and M.FormatTime and M.FormatTime(s) or "" end
-- "2 / 8 bosses · 18:42"
local function bossLine(m, fmt)
	return format(fmt, m.bossesDone or 0, m.bossesTotal or 0) .. (m.elapsed and (DOT .. clock(m.elapsed)) or "")
end

-- Whether the tracker's own head (the dungeon's name, its count and time) shows. Floating, always; docked in
-- the guide window, unless the guide open is this very dungeon's (its pick-up guide, a dungeon guide): the
-- window's tab names it then. With any other guide open (a leveling guide, a profession) the list is the
-- run's and the head says which dungeon it is.
local function headShown(v, m)
	if not v.docked then return true end
	local KD, En = ns.KindDungeon, ns.Engine
	local key = KD and En and En.GetGuide and KD.KeyOf(En.GetGuide())
	return not (key ~= nil and key == m.key)
end

---------------------------------------------------------------------------
-- The parts (one set per place it shows: floating, docked)
---------------------------------------------------------------------------

local function section(parent)
	local s = CreateFrame("Frame", nil, parent)
	s.Lines, s.n = {}, 0
	return s
end

-- A pooled line of section s: glyph, order number, text, right text with its
-- glyph, the amber dot, the next boss's bar and wash, a chip.
local function line(v, s)
	s.n = s.n + 1
	local r = s.Lines[s.n]
	if not r then
		r = CreateFrame("Frame", nil, s)
		r.Wash = W.Tex(r, "BACKGROUND")
		r.Wash:SetAllPoints(r)
		r.Bar = W.Tex(r, "ARTWORK", nil, "accent")
		r.Bar:SetWidth(2)
		r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
		r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
		r.Icon = W.Tex(r, "ARTWORK")
		r.Num = W.Text(r, "small", "textMuted")
		r.Num:SetJustifyH("RIGHT")
		r.Text = W.Text(r, "label", "text")
		r.Right = W.Text(r, "small", "textDim")
		r.Right:SetJustifyH("RIGHT")
		r.RightIcon = W.Tex(r, "ARTWORK")
		-- The item a boss row stands for, named on hover (the glyph alone shows it).
		r.Hit = CreateFrame("Frame", nil, r)
		r.Hit:SetScript("OnEnter", W.SimpleTip)
		r.Hit:SetScript("OnLeave", W.HideTip)
		r.Hit:Hide()
		r.Dot = W.Tex(r, "ARTWORK", "disc-16", "warning")
		r.Dot:SetSize(5, 5)
		r.Chip = W.Chip(r)
		s.Lines[s.n] = r
		if v.frame and TR() then TR().AddText(v.frame, {}, { r.Text, r.Right, r.Num }) end
	end
	r.Wash:Hide(); r.Bar:Hide(); r.Icon:Hide(); r.Num:Hide(); r.RightIcon:Hide(); r.Dot:Hide(); r.Chip:Hide(); r.Hit:Hide()
	r.psTip = nil
	r.Num:SetText(""); r.Right:SetText("")
	Theme.Font(r.Text, "label")
	r.psH, r.psIndent, r.psGutter, r.psIcon = LINE, 0, false, false
	return r
end

local function finish(s)
	for i = s.n + 1, #s.Lines do s.Lines[i]:Hide() end
end

function DT.Build(parent, pad, frame)
	local v = { parent = parent, pad = pad or 10, frame = frame }
	local h = CreateFrame("Frame", nil, parent)
	h.Icon = W.Tex(h, "ARTWORK", "icon-dungeon", "dungeon")
	h.Icon:SetSize(15, 15)
	h.Name = W.Text(h, "heading", "text")
	h.Right = W.Text(h, "small", "textDim")
	h.Right:SetJustifyH("RIGHT")
	v.Head = h
	v.Loot = section(parent)
	v.Loot.Cards = {}
	v.Quests = section(parent)
	v.Quests.Label = W.Text(v.Quests, "heading", "text")
	v.Quests.Right = W.Text(v.Quests, "small", "textDim")
	v.Quests.Right:SetJustifyH("RIGHT")
	v.Bosses = section(parent)
	v.Bosses.Label = W.Text(v.Bosses, "heading", "text")
	v.Bosses.Right = W.Text(v.Bosses, "small", "textDim")
	v.Bosses.Right:SetJustifyH("RIGHT")
	v.Bosses.Rule = W.Divider(v.Bosses)
	v.Bosses.Rule:SetPoint("TOPLEFT", v.Bosses, "TOPLEFT", 0, 0)
	v.Bosses.Rule:SetPoint("TOPRIGHT", v.Bosses, "TOPRIGHT", 0, 0)
	v.titles = { h.Name, v.Quests.Label, v.Bosses.Label }
	v.bodies = { h.Right, v.Quests.Right, v.Bosses.Right }
	return v
end

-- One amber card a reminder: warning wash and bar on the skin's inset. Its ground is a frame of its own
-- (Face, under the card's text) so a layout that stands the reminder on a card (Atlas) can take the ground off.
local function card(v, i)
	local c = v.Loot.Cards[i]
	if not c then
		c = CreateFrame("Frame", nil, v.Loot)
		c.Face = CreateFrame("Frame", nil, c)
		c.Face:SetAllPoints(c)
		c.Face:SetFrameLevel(max(0, c:GetFrameLevel() - 1))
		Theme.Skin(c.Face, "inset")
		c.Wash = W.Tex(c.Face, "BORDER")
		c.Wash:SetAllPoints(c.Face)
		W.Painter(c.Wash, function(t) local r, g, b = Theme.Color("warning"); t:SetVertexColor(r, g, b, 0.13) end)
		c.Bar = W.Tex(c.Face, "ARTWORK", nil, "warning")
		c.Bar:SetWidth(2)
		c.Bar:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
		c.Bar:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
		c.Icon = W.Tex(c, "ARTWORK", "icon-collect", "item")
		c.Icon:SetSize(13, 13)
		c.Text = W.Text(c, "label", "text")
		c.Sub = W.Text(c, "small", "textDim")
		v.Loot.Cards[i] = c
		if v.frame and TR() then TR().AddText(v.frame, {}, { c.Text, c.Sub }) end
	end
	return c
end

---------------------------------------------------------------------------
-- Paint: the strings and colours
---------------------------------------------------------------------------

local function objectiveText(o)
	local count = (o.max and o.max > 1 or o.cur) and format(" %d/%d", o.cur or 0, o.max or 1) or ""
	return (o.text or "") .. col(o.done and "success" or "text", count)
end

function DT.Paint(v, m, compact)
	v.model, v.compact = m, compact
	local h = v.Head
	h.Name:SetText(m.name or "")
	local right = bossLine(m, L["%d / %d bosses"])
	h.Right:SetText(right)
	-- Loot now: newest first.
	local loot = m.loot or {}
	for i, e in ipairs(loot) do
		local c = card(v, i)
		local item = col("item", e.itemName or "?")
		if e.how == "starts" then
			c.Text:SetText(format(L["Loot %s"], item))
			c.Sub:SetText(format(L["from %s: it starts a quest"], col("npc", e.boss or "")))
		elseif compact then
			c.Text:SetText(format(L["Loot %s"], item) .. DOT .. col("npc", e.boss or ""))
			c.Sub:SetText("")
		else
			c.Text:SetText(format(L["Loot %s"], item))
			c.Sub:SetText(format(L["from %s"], col("npc", e.boss or "")) .. DOT .. format(L["for %s"], e.questTitle or ""))
		end
	end
	v.Loot.cards = #loot
	for i = #loot + 1, #v.Loot.Cards do v.Loot.Cards[i]:Hide() end
	-- Quests here.
	local q = v.Quests
	q.n = 0
	local done, total = 0, #(m.quests or {})
	for _, quest in ipairs(m.quests or {}) do if quest.done then done = done + 1 end end
	q.Label:SetText(L["Quests here"])
	q.Right:SetText(format(L["%d of %d done"], done, total))
	if compact then
		-- Only what is left: one line an open objective, its boss at the right.
		for _, quest in ipairs(m.quests or {}) do
			for _, o in ipairs(quest.done and {} or quest.objectives) do
				if not o.done then
					local r = line(v, q)
					r.Text:SetText(objectiveText(o))
					if o.boss then r.Right:SetText(col(o.pending and "warning" or "npc", o.boss)) end
					r.Dot:SetShown(o.pending and true or false)
					hook(r, o, { kind = "objective", done = false })
				end
			end
		end
	elseif total > 0 and done == total then
		local r = line(v, q)
		r.psIcon = true
		r.Icon:SetTexture(Theme.Media("check")); W.Color(r.Icon, "success"); r.Icon:Show()
		r.Text:SetText(total == 1 and L["Its quest is ready to turn in: hand it in after the run"]
			or format(L["All %d quests ready to turn in: hand them in after the run"], total))
		r.psH = LINE + 4
		hook(r, m, { kind = "objective", done = true })
	else
		for _, quest in ipairs(m.quests or {}) do
			local r = line(v, q)
			r.psH = TITLE
			if quest.done then
				r.psIcon = true
				r.Icon:SetTexture(Theme.Media("check")); W.Color(r.Icon, "success"); r.Icon:Show()
				r.Text:SetText(col("textDim", quest.title or ""))
				W.SetChip(r.Chip, L["Ready to turn in"], "success")
				hook(r, quest, { kind = "objective", done = true })
			else
				Theme.Font(r.Text, "label")
				r.Text:SetText(col("quest", quest.title or ""))
				hook(r, quest, { kind = "objective", done = false })
				for _, o in ipairs(quest.objectives or {}) do
					local ro = line(v, q)
					ro.psIndent = 12
					ro.Text:SetText(objectiveText(o))
					if o.boss then ro.Right:SetText(col(o.pending and "warning" or "npc", o.boss)) end
					ro.Dot:SetShown(o.pending and true or false)
					hook(ro, o, { kind = "objective", done = o.done })
				end
			end
		end
	end
	finish(q)
	-- Bosses in kill order.
	local b = v.Bosses
	b.n = 0
	b.Label:SetText(L["Bosses"])
	-- Docked with no head of the tracker's (the window's own guide is this dungeon's): its count and time sit here.
	local docked = bossLine(m, "%d / %d")
	v.showHead = headShown(v, m)
	b.Right:SetText(compact and "" or ((v.docked and not v.showHead) and docked or L["in kill order"]))
	local list = m.bosses or {}
	if compact then
		local names = {}
		for _, boss in ipairs(list) do
			if boss.state ~= "dead" and not boss.role and #names < 2 then names[#names + 1] = col("npc", boss.name or "") end
		end
		local r = line(v, b)
		if #names > 0 then
			r.Text:SetText(#names == 1 and format(L["Next: %s"], names[1]) or format(L["Next: %s · then %s"], names[1], names[2]))
		else
			r.Text:SetText(col("success", L["Every boss is down"]))
		end
		hook(r, m, { kind = "boss" })
	else
		-- A long list (a raid): BOSS_ROWS rows from two before the next one.
		local first, nxt = 1, nil
		for i, boss in ipairs(list) do if boss.state == "next" then nxt = i; break end end
		if #list > BOSS_ROWS and nxt then first = max(1, min(nxt - 2, #list - BOSS_ROWS + 1)) end
		for i = first, min(#list, first + BOSS_ROWS - 1) do
			local boss = list[i]
			local r = line(v, b)
			r.psH, r.psGutter = BOSS, true
			local dead, isNext = boss.state == "dead", boss.state == "next"
			if dead then
				r.Icon:SetTexture(Theme.Media("check")); W.Color(r.Icon, "success"); r.Icon:Show()
				r.Text:SetText(col("textMuted", boss.name or ""))
			else
				r.Num:SetText(boss.role and "" or tostring(boss.order or i)); r.Num:Show()
				r.Text:SetText(col(isNext and "text" or "npc", boss.name or ""))
			end
			if isNext then
				r.Bar:Show()
				r.Wash:Show()
				r.Wash:SetTexture(Theme.Media("white"))
				r.Wash:SetVertexColor(Theme.Wash("selected"))
			end
			local tie = boss.ties and boss.ties[1]
			if boss.role then
				r.Right:SetText(col("textMuted", L["optional"]))
			elseif tie then
				-- The item's glyph alone, its name in the tooltip (the quests above name it); "loot it" while
				-- it waits, and what the boss starts.
				local what
				if tie.how == "starts" then
					what = L["starts a quest"]
				elseif tie.how == "kill" then
					what = L["for your quest"]
				elseif tie.pending then
					what = L["loot it"]
				else
					r.psTip = tie.itemName
				end
				r.Right:SetText(what and col(tie.pending and "warning" or "textDim", what) or "")
				r.RightIcon:SetTexture(Theme.Media(tie.how == "kill" and "icon-kill" or "icon-collect"))
				W.Color(r.RightIcon, tie.pending and "warning" or "item")
				r.RightIcon:Show()
			end
			hook(r, boss, { kind = "boss", done = dead, current = isNext })
		end
	end
	finish(b)
end

---------------------------------------------------------------------------
-- Layout: sizes and anchors only
---------------------------------------------------------------------------

-- k: the player's larger type (frame.psTextK, Options > Trackers): rows grow with it.
local function layoutLines(s, width, pad, y, k)
	for i = 1, s.n do
		local r = s.Lines[i]
		local h = r.psH
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", s, "TOPLEFT", 0, -y)
		r:SetPoint("TOPRIGHT", s, "TOPRIGHT", 0, -y)
		h = floor(h * k + 0.5)
		r:SetHeight(h)
		local x = pad + r.psIndent
		if r.psGutter then
			r.Num:ClearAllPoints()
			r.Num:SetPoint("RIGHT", r, "LEFT", x + 12, 0)
			r.Icon:SetSize(12, 12)
			r.Icon:ClearAllPoints()
			r.Icon:SetPoint("CENTER", r, "LEFT", x + 6, 0)
			x = x + 20
		elseif r.psIcon then
			r.Icon:SetSize(13, 13)
			r.Icon:ClearAllPoints()
			r.Icon:SetPoint("LEFT", r, "LEFT", x, 0)
			x = x + 19
		end
		r.Dot:ClearAllPoints()
		r.Dot:SetPoint("RIGHT", r, "LEFT", x - 4, 0)
		local right = 0
		if r.Chip:IsShown() then
			r.Chip:ClearAllPoints()
			r.Chip:SetPoint("RIGHT", r, "RIGHT", -pad, 0)
			right = r.Chip:GetWidth() + 8
		else
			local text = r.Right:GetText() or ""
			local glyph = r.RightIcon:IsShown()
			local rw = 0
			if text ~= "" then
				r.Right:ClearAllPoints()
				r.Right:SetPoint("RIGHT", r, "RIGHT", -pad, 0)
				-- The column keeps what the name leaves, and never less than its 45%: the name is cut before
				-- the label is (a pooled row's earlier width would cap the measure, so it is taken unbound).
				local want = ceil(W.TextWidth(r.Right))
				local nameW = ceil(W.TextWidth(r.Text))
				local room = width - x - pad - 8 - (glyph and 15 or 0)
				rw = min(want, max(floor(width * 0.45), room - nameW))
				r.Right:SetWidth(rw)
				right = rw + 8
			end
			if glyph then
				r.RightIcon:SetSize(11, 11)
				r.RightIcon:ClearAllPoints()
				if rw > 0 then
					r.RightIcon:SetPoint("RIGHT", r.Right, "LEFT", -4, 0)
				else
					r.RightIcon:SetPoint("RIGHT", r, "RIGHT", -pad, 0)
				end
				right = right + 15
			end
			-- The glyph's hover, where a row names its item.
			r.Hit:SetShown(r.psTip ~= nil)
			if r.psTip then
				r.Hit.psTip = r.psTip
				r.Hit:EnableMouse(true)
				r.Hit:SetSize(22, h)
				r.Hit:ClearAllPoints()
				r.Hit:SetPoint("RIGHT", r, "RIGHT", -(pad - 6), 0)
			end
		end
		r.Text:ClearAllPoints()
		r.Text:SetPoint("LEFT", r, "LEFT", x, 0)
		r.Text:SetWidth(max(20, width - x - pad - right))
		r:Show()
		y = y + h
	end
	return y
end

-- A section a layout places (trackerPlace) takes no room here.
local function claimed(name, f, width, h)
	local ran, mine = Theme.SkinHookValue("trackerPlace", name, f, width, h)
	return ran and mine == true
end

function DT.Layout(v, width, compact)
	local pad, m = v.pad, v.model
	if not m then return 0 end
	local k = max(1, v.frame and v.frame.psTextK or 1)
	local function s(n) return floor(n * k + 0.5) end
	local h = v.Head
	h:ClearAllPoints()
	h:SetPoint("TOPLEFT", v.parent, "TOPLEFT", 0, 0)
	h:SetPoint("TOPRIGHT", v.parent, "TOPRIGHT", 0, 0)
	h:SetHeight(s(HEAD))
	h.Icon:ClearAllPoints()
	h.Icon:SetPoint("LEFT", h, "LEFT", pad, 0)
	h.Right:ClearAllPoints()
	h.Right:SetPoint("RIGHT", h, "RIGHT", -pad, 0)
	h.Name:ClearAllPoints()
	h.Name:SetPoint("LEFT", h.Icon, "RIGHT", 8, 0)
	h.Name:SetPoint("RIGHT", h.Right, "LEFT", -8, 0)
	-- The parts, each its height first; where they stand once the head is known (a layout that puts the
	-- quests on a card has cards that say what the head says: the head goes, and the cards start at the top).
	local pending, y, onCards = {}, 0, false
	local function put(name, sec, ph)
		sec:SetHeight(max(1, ph))
		if ph <= 0 then sec:Hide(); return end
		sec:Show()
		if claimed(name, sec, width, ph) then
			if name == "quests" then onCards = true end
			return
		end
		pending[#pending + 1] = { sec, y }
		y = y + ph
	end
	-- Loot cards.
	local ly = 0
	for i = 1, v.Loot.cards or 0 do
		local c = v.Loot.Cards[i]
		local two = c.Sub:GetText() ~= ""
		local ch = s(two and 38 or 24)
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", v.Loot, "TOPLEFT", pad, -ly)
		c:SetPoint("TOPRIGHT", v.Loot, "TOPRIGHT", -pad, -ly)
		c:SetHeight(ch)
		c.Icon:ClearAllPoints()
		c.Icon:SetPoint("TOPLEFT", c, "TOPLEFT", 10, -6)
		c.Text:ClearAllPoints()
		c.Text:SetPoint("TOPLEFT", c, "TOPLEFT", 29, -5)
		c.Text:SetPoint("RIGHT", c, "RIGHT", -8, 0)
		c.Sub:ClearAllPoints()
		c.Sub:SetPoint("TOPLEFT", c, "TOPLEFT", 29, -s(21))
		c.Sub:SetPoint("RIGHT", c, "RIGHT", -8, 0)
		c.Sub:SetShown(two)
		c:Show()
		ly = ly + ch + 4
	end
	put("loot", v.Loot, ly > 0 and ly + 4 or 0)
	-- Quests.
	local q = v.Quests
	local qy = 0
	if not compact then
		q.Label:ClearAllPoints()
		q.Label:SetPoint("TOPLEFT", q, "TOPLEFT", pad, -4)
		q.Right:ClearAllPoints()
		q.Right:SetPoint("TOPRIGHT", q, "TOPRIGHT", -pad, -5)
		qy = s(24)
	end
	q.Label:SetShown(not compact)
	q.Right:SetShown(not compact)
	qy = layoutLines(q, width, pad, qy, k)
	put("quests", q, qy > 0 and qy + 4 or 0)
	-- Bosses.
	local b = v.Bosses
	local by = 0
	b.Rule:SetShown(not compact)
	if not compact then
		b.Label:ClearAllPoints()
		b.Label:SetPoint("TOPLEFT", b, "TOPLEFT", pad, -8)
		b.Right:ClearAllPoints()
		b.Right:SetPoint("TOPRIGHT", b, "TOPRIGHT", -pad, -9)
		by = s(28)
	end
	b.Label:SetShown(not compact)
	b.Right:SetShown(not compact)
	by = layoutLines(b, width, pad, by, k)
	put("bosses", b, by + 6)
	-- The head: the window has none of its own (docked), and a guide of this dungeon's names it already.
	local shown = not onCards and v.showHead ~= false
	h:SetShown(shown)
	if v.frame then v.frame.psHeadless = onCards or nil end
	local base = shown and s(HEAD) or (onCards and 0 or 4)
	for _, p in ipairs(pending) do
		p[1]:ClearAllPoints()
		p[1]:SetPoint("TOPLEFT", v.parent, "TOPLEFT", 0, -(base + p[2]))
		p[1]:SetPoint("TOPRIGHT", v.parent, "TOPRIGHT", 0, -(base + p[2]))
	end
	return base + y
end

---------------------------------------------------------------------------
-- The floating tracker
---------------------------------------------------------------------------

local frame, fv, ticker, sample
local deferred = false

-- Whether the guide window is shown now (then the tracker docks there).
local function windowShown()
	local F = rawget(_G, "PolestarGuideFrame")
	return F and F:IsShown() and true or false
end

local function enabled() return TR() == nil or TR().Get("dungeon", "enabled") ~= false end

local function wanted(m)
	if sample then return sample == "float" end
	if not m or windowShown() then return false end
	if not enabled() or ns.Hidden() then return false end
	return TR() == nil or TR().Allowed("dungeon") ~= false
end

local function compactSetting() return TR() ~= nil and TR().Get("dungeon", "compact") == true end

local function paint(m, force)
	if not frame then return end
	DT.Paint(fv, m, compactSetting())
	local width = frame.psWidth or frame:GetWidth()
	-- In a fight the height waits for its end (deferred), so the frame never jumps.
	local cur = frame:GetHeight()
	local h = DT.Layout(fv, width, compactSetting())
	if not force and inCombat() and cur and cur > 1 and math.abs(cur - h) > 0.5 then
		deferred = true
		return
	end
	-- Its parts on cards of a layout's own (Atlas): the cards carry the dungeon, the frame is only their anchor.
	frame:SetHeight(frame.psHeadless and 1 or max(HEAD, h))
end

local function buildFrame()
	if frame or not (ns.Maps and ns.Maps.CompactFrame) then return end
	frame = ns.Maps.CompactFrame("PolestarDungeonTracker", "trackers.dungeon.pos", "TOPRIGHT", -220, -290)
	frame:SetSize(300, HEAD)
	frame:SetScript("OnHide", function() if ticker then ticker:Cancel(); ticker = nil end end)
	fv = DT.Build(frame, 10, frame)
	if TR() then
		TR().Attach("dungeon", frame, { titles = fv.titles, bodies = fv.bodies,
			refresh = function() DT.Refresh() end,
			relayout = function() if frame:IsShown() and fv.model then paint(fv.model, true) end end })
	end
	frame:Hide()
end

-- A sandbox tracker for the options' preview (UI.Trackers.Preview): the
-- sample run, at the player's settings.
function DT.NewSandbox(parent)
	local f = CreateFrame("Frame", nil, parent)
	f.psLight = true
	Theme.Skin(f, "window")
	f:SetSize(300, HEAD)
	local v = DT.Build(f, 10, f)
	local function fill(self)
		DT.Paint(v, DT.SHORT, compactSetting())
		self:SetHeight(max(HEAD, DT.Layout(v, self.psWidth or self:GetWidth(), compactSetting())))
	end
	f.Fill = fill
	if TR() then TR().Attach("dungeon", f, { titles = v.titles, bodies = v.bodies, sandbox = true, relayout = fill }) end
	return f
end

-- Its own switches (on, Only what's left, Without quests too): UI.Trackers redraws the look; whether it shows
-- and what it lists is its own.
local OWN = { ["trackers.dungeon.enabled"] = true, ["trackers.dungeon.compact"] = true, ["trackers.dungeon.bossesAlone"] = true }
ns.On("SETTING_CHANGED", function(path)
	if path == "trackers.dungeon.pos" and frame then frame.Place() end
	if OWN[path] then DT.Refresh() end
end)

local function current()
	if sample then return DT.SAMPLE end
	local Dg = ns.Dungeons
	return Dg and Dg.Run and Dg.Run.Model() or nil
end
-- The model on screen now (the run's, or the sample's): a layout's cards read it.
DT.Model = current

-- The quest item the run's quests use (Dungeons.Run's `use`), while the
-- tracker shows (floating or docked): the quest item button offers it
-- (QoL/Buttons.lua). nil without one, or for the sample.
function DT.UseItem()
	if sample or not enabled() then return nil end
	local Dg = ns.Dungeons
	local m = Dg and Dg.Run and Dg.Run.Key() and Dg.Run.Model()
	local u = m and m.use and m.use[1]
	return u and u.item or nil
end

function DT.Refresh()
	local m = current()
	if not wanted(m) then
		if frame then frame:Hide() end
	else
		buildFrame()
	end
	if frame and wanted(m) then
		paint(m)
		frame:Show()
		if not ticker and not sample and m.elapsed then
			-- The run's clock: the head's figure only, no layout.
			ticker = ns.NewTicker(1, function()
				local mm = current()
				if not (mm and fv.model) then return end
				fv.model.elapsed = mm.elapsed
				fv.Head.Right:SetText(bossLine(mm, L["%d / %d bosses"]))
			end)
		end
	end
	-- The docked copy: the guide window draws it again.
	local GF = UI.GuideFrame
	if windowShown() and GF and GF.Render and (m or (GF.RegionShown and GF.RegionShown("tracker"))) then GF.Render() end
end

-- Many events in one frame (a quest log update after each kill) draw once.
local pending = false
local function soon()
	if pending then return end
	pending = true
	ns.After(0.1, function()
		pending = false
		DT.Refresh()
	end)
end

ns.On("DUNGEON_RUN_CHANGED", soon)
ns.On("GUIDE_VISIBILITY", soon)
ns.On("GUIDE_SHOWN", soon)
ns.On("POLESTAR_HIDDEN", soon)
ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if deferred then
		deferred = false
		if frame and frame:IsShown() and fv.model then paint(fv.model, true) end
	end
end)

-- The parts' headings where a layout puts each on a card of its own
-- (trackerPlace; Atlas): quests's takes the dungeon's name.
DT.CARD_HEADS = { loot = L["Loot now"], quests = L["%s · quests"], bosses = L["Bosses"] }

---------------------------------------------------------------------------
-- The sample (a made-up run: the skins sweep, previews, Options)
---------------------------------------------------------------------------

DT.SAMPLE = {
	key = "wailing-caverns", name = "Wailing Caverns", bossesDone = 2, bossesTotal = 8, elapsed = 1122,
	loot = { { item = 9738, itemName = "Gem of Cobrahn", boss = "Lord Cobrahn", quest = 914, questTitle = "Leaders of the Fang", how = "item" } },
	quests = {
		{ id = 914, title = "Leaders of the Fang", done = false, objectives = {
			{ text = "Gem of Anacondra", cur = 1, max = 1, done = true, boss = "Lady Anacondra" },
			{ text = "Gem of Cobrahn", cur = 0, max = 1, done = false, boss = "Lord Cobrahn", pending = true },
			{ text = "Gem of Pythas", cur = 0, max = 1, done = false, boss = "Lord Pythas" },
			{ text = "Gem of Serpentis", cur = 0, max = 1, done = false, boss = "Lord Serpentis" } } },
		{ id = 1486, title = "Deviate Hides", done = false, objectives = { { text = "Deviate Hide", cur = 14, max = 20, done = false } } },
		{ id = 1491, title = "Smart Drinks", done = true, objectives = {} },
	},
	bosses = {
		{ order = 1, name = "Lady Anacondra", state = "dead", ties = { { how = "item", itemName = "Gem of Anacondra" } } },
		{ order = 2, name = "Lord Cobrahn", state = "dead", ties = { { how = "item", itemName = "Gem of Cobrahn", pending = true } } },
		{ order = 3, name = "Kresh", state = "next", ties = {} },
		{ order = 4, name = "Lord Pythas", state = "ahead", ties = { { how = "item", itemName = "Gem of Pythas" } } },
		{ order = 5, name = "Skum", state = "ahead", ties = {} },
		{ order = 6, name = "Lord Serpentis", state = "ahead", ties = { { how = "item", itemName = "Gem of Serpentis" } } },
		{ order = 7, name = "Verdan the Everliving", state = "ahead", ties = {} },
		{ order = 8, name = "Mutanus the Devourer", state = "ahead", ties = { { how = "starts", itemName = "Glowing Shard" } } },
	},
	use = {},
}
-- The options' preview (a band at most 55% of the settings' body): the same
-- run, one quest and its loot, the done one, the first five bosses.
DT.SHORT = {
	key = DT.SAMPLE.key, name = DT.SAMPLE.name, bossesDone = 2, bossesTotal = 8, elapsed = DT.SAMPLE.elapsed, loot = DT.SAMPLE.loot,
	quests = { DT.SAMPLE.quests[1], DT.SAMPLE.quests[3] },
	bosses = { DT.SAMPLE.bosses[1], DT.SAMPLE.bosses[2], DT.SAMPLE.bosses[3], DT.SAMPLE.bosses[4], DT.SAMPLE.bosses[5] },
	use = {},
}

-- docked: in the guide window (its region) instead of floating, whether or
-- not the window is shown.
function DT.ShowSample(docked)
	sample = docked and "dock" or "float"
	DT.Refresh()
	return frame
end

function DT.HideSample()
	sample = nil
	DT.Refresh()
end

---------------------------------------------------------------------------
-- Docked: the guide window's region "tracker", for every guide kind
---------------------------------------------------------------------------

UI.GuideFrame.Part(function(GF)
	local PAD = 14
	GF.Bind(function(_, m) PAD = m.PAD end)
	-- Inside the run, with quests here: the card is the tracker (every goal
	-- of the step it covers, so its header goes too).
	function GF.RegionOverride()
		if not (GF.live and enabled()) or sample == "float" then return nil end
		return current() and { "tracker" } or nil
	end
	GF.RegisterRegion("tracker", {
		build = function(parent)
			local f = CreateFrame("Frame", nil, parent)
			f.psView = DT.Build(f, PAD)
			f.psView.docked = true
			return f
		end,
		model = function(view)
			local m = current()
			if not m then return nil end
			local covers = {}
			for gi in ipairs(view and view.goals or {}) do covers[gi] = gi end
			m.covers = covers
			return m
		end,
		paint = function(f, m, mode) DT.Paint(f.psView, m, mode == "compact") end,
		layout = function(f, m, width, mode)
			f.psView.pad = PAD
			return DT.Layout(f.psView, width, mode == "compact")
		end,
	})
end)
