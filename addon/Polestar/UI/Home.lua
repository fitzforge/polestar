-- Home, the hub's first section (UI.RegisterSection, order 5; the hub opens
-- here from the key binding until the player picks a section): your journey
-- at a glance, from data the other modules already keep. It sits in the
-- shell like every section: the sidebar keeps the lockup, the version and
-- the Discord link, with the character panel between them.
--
-- Header: "Home" at 32/32, what the page is for under it. The sidebar is the character's: their
-- name, level, race and class, the way to the next level, and their talent
-- plan, zone and gold.
--
-- Body, scrolling, in blocks: each a heading and its hairline (the heading
-- opens where the block leads): a tile, the thing's name, its facts and a
-- button, as one row of the page. The
-- guide to continue across the top (the active tab's guide, else the
-- suggestion): its zone painting with the title and level range on it,
-- Continue, the guide's progress along the painting's foot, then what is
-- left (the next step, the quests and kills, where it leads,
-- Levels.ForGuide's estimate). Then two to a
-- line:
--   Leveling build     the talent plan the player picked: class, spec, picks
--                      taken, the next picks' spell icons, the next pick;
--                      before level 10, when the first point comes. None
--                      picked yet: the class's plans, a button each to pick
--   Dungeons           the first of Dungeons.ForYou, a button to its page
--   Up next            where the guide leads (`next`, route choices)
--   Class training     the guide's own class training step when one comes in
--                      the next 15 steps, at the trainer it picked; else new
--                      skills since CharState().classTrainLevel (even levels)
--                      and the nearest trainer; Guide me points the arrow
--   Quest reward       the first turn-in ahead in the active guide (40 steps)
--   upgrade            whose reward pick is an upgrade (UI.GearPick.PickFor:
--                      ItemDB's reward choices ranked by the spec's weights)
--   Rares nearby       the rares the Codex places in the player's zone
-- A block with nothing to say is left out and the rest close up.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, ipairs, pairs, format, type, tonumber = math.floor, math.max, math.min, ipairs, pairs, string.format, type, tonumber
local ZoneArt = UI.ZoneArt

if not (W and W.SHELL and ZoneArt) then return end

local SH = W.SHELL
local DOT = "  \194\183  "
-- The Dungeons section's grid: card grounds 12px outside the 32 text edge,
-- 16px apart, two to a line.
local EDGE = SH.pad - 12 -- a block's left edge in the page
local GAP = 16 -- between blocks
local IN = 12 -- a block's text edge, inside it (the page's 32 edge)
local HEAD_H = 44 -- a block's heading row (W.SectionHeader's)
local TOP = HEAD_H + 12 -- a block's content, under its heading
local ART_H = 132 -- the hero's painting
local PER = 2 -- blocks to a line under the hero
local ICON = 32 -- a talent or spell icon
local SIDE_LETTER = { Alliance = "A", Horde = "H" }
local GEAR_AHEAD = 40 -- steps searched for a reward upgrade
local TRAIN_AHEAD = 15 -- steps searched for the guide's class training

local HV = {}
UI.HomeSection = HV

local root, hub, page
local cards = {}
local shown = {}

---------------------------------------------------------------------------
-- Data
---------------------------------------------------------------------------

local function playerInfo()
	local C = ns.Compat
	if not (C and C.GetPlayerInfo) then return {} end
	local ok, info = pcall(C.GetPlayerInfo)
	return ok and type(info) == "table" and info or {}
end

local function E() return ns.Engine end

local function tabsInfo()
	local Eng = E()
	if not (Eng and Eng.GetTabs) then return {}, nil end
	local ok, tabs, active = pcall(Eng.GetTabs)
	if not ok or type(tabs) ~= "table" then return {}, nil end
	return tabs, active
end

local function headers()
	local G = ns.Guides
	local byId = {}
	for _, g in ipairs(G and G.List and G.List() or {}) do byId[g.id] = g end
	return byId
end

-- The guide Home is about: the active tab's, else the suggestion.
-- -> header, tab entry, tab index
local function featuredGuide(byId, tabs, active)
	local t = active and tabs[active]
	if t and byId[t.guideId] then return byId[t.guideId], t, active end
	local G = ns.Guides
	local id = G and G.Suggest and G.Suggest()
	return id and byId[id] or nil, nil, nil
end

local function rangeText(lo, hi)
	local r = UI.LevelRange(lo, hi)
	return r and ("(" .. r .. ")") or ""
end

local function thousands(n)
	local s = tostring(floor(n or 0))
	return (s:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""))
end

-- The quests a guide picks up, for this character (steps' and goals' `only`).
local function guideQuests(g)
	local G = ns.Guides
	local full = G and G.Get and G.Get(g.id)
	local info = playerInfo()
	local fits = G and G.Matches
	local function applies(only) return type(only) ~= "table" or not fits or fits(only, info) end
	local n, seen = 0, {}
	for _, step in ipairs(full and type(full.steps) == "table" and full.steps or {}) do
		if applies(step.only) and type(step.goals) == "table" then
			for _, goal in ipairs(step.goals) do
				if goal.t == "accept" and goal.quest and not seen[goal.quest] and applies(goal.only) then
					seen[goal.quest] = true
					n = n + 1
				end
			end
		end
	end
	return n
end

-- Where a guide leads now: its `next`, or the first route choice offered.
-- -> header, whether it is one of several choices
local function nextGuide(g, byId)
	local Eng = E()
	local function offered(id) return not (Eng and Eng.RouteOffered) or Eng.RouteOffered(g.id, id) end
	if type(g.nextChoices) == "table" then
		for _, id in ipairs(g.nextChoices) do
			if byId[id] and offered(id) then return byId[id], #g.nextChoices > 1 end
		end
	end
	return g.next and byId[g.next] or nil, false
end

-- The title of the step the guide is on.
local function nextStepTitle(g, t, index)
	local Eng = E()
	local _, active = tabsInfo()
	if t and index == active and Eng and Eng.GetStepView and Eng.GetStepIndex then
		local v = Eng.GetStepView(Eng.GetStepIndex())
		if v and v.title then return v.title end
	end
	local full = ns.Guides and ns.Guides.Get and ns.Guides.Get(g.id)
	local step = full and full.steps and full.steps[t and t.stepIndex or 1]
	return step and step.title or nil
end

local function guideXP(id)
	local Lv = ns.Levels
	if not (Lv and Lv.ForGuide) then return nil end
	local ok, s = pcall(Lv.ForGuide, id)
	return ok and s or nil
end

local function load(g, t, index)
	if not g then return end
	local Eng = E()
	if t and index and Eng and Eng.SelectTab then
		Eng.SelectTab(index)
		ns.Set("ui.shown", true)
		if hub then hub:Hide() end
		return
	end
	if UI.Picker and UI.Picker.Load then UI.Picker.Load(g.id) end
end

local function showGuide(id)
	local P = UI.Picker
	if not P then return end
	P.ShowSection("Guides")
	if id then P.Select(id) end
end

local function classIcon(t, class)
	local c = CLASS_ICON_TCOORDS and class and CLASS_ICON_TCOORDS[class]
	if not c then return false end
	t:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	t:SetTexCoord(c[1], c[2], c[3], c[4])
	t:SetVertexColor(1, 1, 1, 1)
	return true
end

local function itemName(id)
	local DB = ns.ItemDB
	local name = DB and DB.ItemName and DB.ItemName(id)
	if not name and C_Item and C_Item.GetItemNameByID then
		local ok, n = pcall(C_Item.GetItemNameByID, id)
		if ok and type(n) == "string" then name = n end
	end
	return name
end

---------------------------------------------------------------------------
-- Cards
---------------------------------------------------------------------------

local function spellTip(self)
	if not self.psSpell then return end
	if GameTooltip and GameTooltip.SetSpellByID then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetSpellByID(self.psSpell)
		GameTooltip:Show()
	else
		W.SimpleTip(self)
	end
end

local function itemTip(self)
	if not self.psItem then return end
	if GameTooltip and GameTooltip.SetItemByID then
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		GameTooltip:SetItemByID(self.psItem)
		GameTooltip:Show()
	else
		W.SimpleTip(self)
	end
end

local function hideTip()
	if GameTooltip then GameTooltip:Hide() end
end

-- An icon tile (a spell, an item) lights its border in the accent while
-- hovered, over the skin's faint wash, which a busy icon hides.
local function iconEnter(tip)
	return function(self)
		Theme.Border(self, Theme.Accent())
		tip(self)
	end
end

local function iconLeave(self)
	Theme.Border(self, Theme.Color("border"))
	hideTip()
end

local function headEnter(self)
	self.Hover:Show()
	W.Color(self.Chevron, "text")
end

local function headLeave(self)
	self.Hover:Hide()
	W.Color(self.Chevron, "textMuted")
end

local function headClick(self)
	local c = self:GetParent()
	if c.psOpen then c.psOpen(c) end
end

-- A block: a heading and its hairline (W.SectionHeader's make) with a
-- chevron at its end, then what the block holds on the window ground. The
-- heading is the block's link: only it lights up under the cursor, and a
-- click on it opens where the block leads (c.psOpen(c)). The block's own
-- cards, buttons and icons answer on their own; the rest of it is still.
local function block(key, title, onOpen)
	local c = CreateFrame("Frame", nil, page.Scroll.Child)
	c.psKey, c.psOpen = key, onOpen
	local head = CreateFrame("Button", nil, c)
	head:SetHeight(HEAD_H)
	head:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	head:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, 0)
	head.Hover = W.Tex(head, "BACKGROUND")
	head.Hover:SetPoint("TOPLEFT", head, "TOPLEFT", 0, -6)
	head.Hover:SetPoint("BOTTOMRIGHT", head, "BOTTOMRIGHT", 0, 2)
	W.Painter(head.Hover, function(t) t:SetVertexColor(Theme.Wash("hover")) end)
	head.Hover:Hide()
	head.Text = W.Text(head, "heading", "text")
	head.Text:SetText(title)
	head.Text:SetPoint("BOTTOMLEFT", head, "BOTTOMLEFT", IN, 10)
	head.Chevron = W.Tex(head, "ARTWORK", "chevron-right", "textMuted")
	head.Chevron:SetSize(12, 12)
	head.Chevron:SetPoint("BOTTOMRIGHT", head, "BOTTOMRIGHT", -IN, 11)
	head.Rule = W.Divider(head)
	head.Rule:SetPoint("LEFT", head.Text, "RIGHT", 12, 0)
	head.Rule:SetPoint("RIGHT", head.Chevron, "LEFT", -8, 0)
	head:SetScript("OnEnter", headEnter)
	head:SetScript("OnLeave", headLeave)
	head:SetScript("OnClick", headClick)
	c.Head = head
	cards[key] = c
	return c
end

local function line(c, role, color, y, x, right)
	local fs = W.Text(c, role, color)
	fs:SetJustifyH("LEFT")
	fs:SetWordWrap(false)
	fs:SetPoint("TOPLEFT", c, "TOPLEFT", x or IN, -y)
	fs:SetPoint("RIGHT", c, "RIGHT", -(right or IN), 0)
	return fs
end

-- A button on the block's text edge, as wide as its label.
local function action(c, text, y, onClick)
	local b = W.Button(c, text, onClick)
	b:SetPoint("TOPLEFT", c, "TOPLEFT", IN, -y)
	return b
end

local function iconTile(parent, size, tip)
	local b = CreateFrame("Button", nil, parent)
	b:SetSize(size, size)
	Theme.Skin(b, "button")
	b.Icon = b:CreateTexture(nil, "ARTWORK")
	b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1)
	b.Icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1)
	b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	b:SetScript("OnEnter", iconEnter(tip))
	b:SetScript("OnLeave", iconLeave)
	return b
end

-- Names on a painting take the text-on-art shadow.
local function onArt(fs)
	W.Painter(fs, function(t)
		local r, g, b = Theme.Color("shade")
		t:SetShadowOffset(0, -1)
		t:SetShadowColor(r, g, b, 0.85)
	end)
	return fs
end

-- One of the hero's facts: a glyph, a label over a value (placed by
-- placeStats, the shown ones left to right).
local function stat(c, icon, label)
	local s = {}
	s.Glyph = W.Tex(c, "ARTWORK", icon, "textDim")
	s.Glyph:SetSize(16, 16)
	s.Label = W.Text(c, "small", "textMuted")
	s.Label:SetText(label)
	s.Value = W.Text(c, "body", "text")
	s.Value:SetWordWrap(false)
	s.Value:SetJustifyH("LEFT")
	s.Split = W.Divider(c, true)
	return s
end

-- The facts in a row under the painting, each as wide as its label or value
-- and 24px apart with a hairline between; the last takes what is left.
local STAT_Y = ART_H + 3 + 16
local STAT_H = 36
local function placeStats(c, list, cardW)
	local x, width = IN, cardW - IN * 2
	local on = {}
	for _, s in ipairs(list) do
		s.Split:Hide()
		if s.Value:IsShown() then on[#on + 1] = s end
	end
	for i, s in ipairs(on) do
		local w = max(s.Label:GetStringWidth(), s.Value:GetStringWidth()) + 24
		if i == #on then w = max(40, IN + width - x) end
		s.Glyph:ClearAllPoints()
		s.Glyph:SetPoint("TOPLEFT", c, "TOPLEFT", x, -(STAT_Y + 1))
		s.Label:ClearAllPoints()
		s.Label:SetPoint("TOPLEFT", c, "TOPLEFT", x + 24, -STAT_Y)
		s.Value:ClearAllPoints()
		s.Value:SetPoint("TOPLEFT", c, "TOPLEFT", x + 24, -(STAT_Y + 17))
		s.Value:SetWidth(max(16, w - 24))
		x = x + w + 24
		if i < #on then
			s.Split:ClearAllPoints()
			s.Split:SetPoint("TOPLEFT", c, "TOPLEFT", x - 12, -STAT_Y)
			s.Split:SetHeight(STAT_H)
			s.Split:Show()
		end
	end
end

-- A painted block: the zone's painting with the name in Display and a Small
-- line on its fade and the block's button at its right, then a row of facts
-- (stat) under it. On a card (the control ground with a hairline, the
-- painting inset 1px), or with `bare` straight on the window ground, fading
-- into it. The caller paints it (paintArt) and fills it.
local function artCard(c, label, onClick, primary, bare)
	local inset = bare and 0 or 1
	local k = CreateFrame("Frame", nil, c)
	k:SetHeight(STAT_Y + STAT_H + (bare and 4 or 14))
	k:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -TOP)
	k:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, -TOP)
	if not bare then Theme.Skin(k, "button") end
	c.Card, c.psInset = k, inset
	c.Art = ZoneArt.Create(k, 100, ART_H, bare and "bg" or "panelAlt")
	c.Art:SetPoint("TOPLEFT", k, "TOPLEFT", inset, -inset)
	if bare then c.Art.Rule:Hide() end
	local over = c.Art.Over
	c.Name = onArt(W.Text(over, "display", "text"))
	c.Name:SetJustifyH("LEFT")
	c.Name:SetWordWrap(false)
	c.Name:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", IN - inset, 36)
	c.Range = W.Chip(over)
	c.Range:SetPoint("LEFT", c.Name, "RIGHT", 10, 0)
	c.Range:Hide()
	c.Step = onArt(W.Text(over, "small", "textDim"))
	c.Step:SetJustifyH("LEFT")
	c.Step:SetWordWrap(false)
	c.Step:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", IN - inset, 16)
	c.Go = W.Button(over, label, onClick, { primary = primary })
	c.Go:SetPoint("BOTTOMRIGHT", c.Art, "BOTTOMRIGHT", -(IN - inset), 14)
	c.Step:SetPoint("RIGHT", c.Go, "LEFT", -16, 0)
	c.psH = TOP + k:GetHeight()
	return k
end

local function buildCards()
	-- The guide to continue.
	local hero = block("hero", L["Continue leveling"], function(c) showGuide(c.psGuide and c.psGuide.id) end)
	local k = artCard(hero, L["Continue guide"], function() load(hero.psGuide, hero.psTab, hero.psIndex) end, true)
	hero.Art.Rule:Hide()
	-- The guide's progress, edge to edge along the painting's foot.
	hero.Bar = W.ProgressLine(k, 3)
	hero.Bar:SetPoint("TOPLEFT", k, "TOPLEFT", 1, -(ART_H + 1))
	hero.Bar:SetPoint("TOPRIGHT", k, "TOPRIGHT", -1, -(ART_H + 1))
	hero.Next = stat(k, "icon-note", L["Next step"])
	hero.Left = stat(k, "icon-turnin", L["Remaining"])
	hero.Then = stat(k, "icon-goto", L["Then"])
	hero.Estimate = stat(k, "icon-level", L["Estimated to finish"])

	-- Leveling build.
	local build = block("build", L["Leveling build"], function() if UI.TalentsSection then UI.TalentsSection.Show() end end)
	build.Class = build:CreateTexture(nil, "ARTWORK")
	build.Class:SetSize(36, 36)
	build.Class:SetPoint("TOPLEFT", build, "TOPLEFT", IN, -TOP)
	build.Spec = line(build, "title", "text", TOP + 1, IN + 48)
	build.Picks = line(build, "small", "textDim", TOP + 21, IN + 48)
	build.Label = line(build, "small", "textMuted", TOP + 52)
	build.Label:SetText(L["Next in your plan"])
	build.Icons = {}
	for i = 1, 6 do
		local b = iconTile(build, ICON, spellTip)
		b:SetPoint("TOPLEFT", build, "TOPLEFT", IN + (i - 1) * (ICON + 8), -(TOP + 70))
		build.Icons[i] = b
	end
	build.Next = line(build, "label", "text", TOP + 114)
	build.When = line(build, "small", "textDim", TOP + 132)
	-- No plan picked yet: a button per plan for the class, to follow it.
	build.Ask = line(build, "small", "textDim", TOP + 21, IN + 48)
	build.Ask:SetText(L["Polestar then names each point to spend."])
	build.Choices = {}
	for i = 1, 3 do
		build.Choices[i] = W.Button(build, "", function(self)
			local T = ns.Talents
			if T and T.Choose and self.psKey then T.Choose(self.psKey) end
		end)
	end
	build.psH = TOP + 150

	-- Dungeons for your level: the first, its entrance painted bare on the
	-- page, a button to its page.
	local dun = block("dungeons", L["Dungeons for your level"], function()
		local DS = UI.DungeonsSection
		if DS then DS.Show(); DS.SetBand("level") end
	end)
	local dk = artCard(dun, L["Open dungeon"], function()
		local DS = UI.DungeonsSection
		if DS and DS.Open and dun.psDungeon then DS.Show(); DS.Open(dun.psDungeon) end
	end, false, true)
	dun.Count = dun.Step
	dun.Levels = stat(dk, "icon-level", L["Levels"])
	dun.Zone = stat(dk, "icon-goto", L["Zone"])
	dun.Quests = stat(dk, "icon-turnin", L["Quests"])

	-- Up next: where the guide leads, its painting bare on the page, a button
	-- that shows it in the guide list.
	local nxt = block("next", L["Up next"], function(c) showGuide(c.psGuide and c.psGuide.id) end)
	local nk = artCard(nxt, L["Preview route"], function() showGuide(nxt.psGuide and nxt.psGuide.id) end, false, true)
	nxt.Levels = stat(nk, "icon-level", L["Levels"])
	nxt.Quests = stat(nk, "icon-turnin", L["Quests"])

	-- Class training.
	local tr = block("trainer", L["Class training"], nil)
	tr.Status = line(tr, "body", "text", TOP)
	tr.Place = line(tr, "small", "textDim", TOP + 20)
	-- The spells waiting, as their icons (the game's tooltip on hover), and
	-- their names under them.
	tr.Icons = {}
	for i = 1, 8 do
		local b = iconTile(tr, ICON, spellTip)
		b:SetPoint("TOPLEFT", tr, "TOPLEFT", IN + (i - 1) * (ICON + 8), -(TOP + 44))
		tr.Icons[i] = b
	end
	tr.Spells = line(tr, "small", "textDim", TOP + 86)
	tr.Last = line(tr, "small", "textMuted", TOP + 104)
	tr.Go = action(tr, L["Guide me"], TOP + 126, function()
		local t, nav = tr.psTrainer, ns.Nav
		if t and t.map and t.x and nav and nav.SetTarget then
			nav.SetTarget(t.map, t.x, t.y, t.npcName or L["Class trainer"], t.f, "trainer", t.z)
		end
	end)
	tr.psOpen = function() tr.Go:Click() end
	tr.psH = TOP + 154

	-- The next quest reward that is an upgrade.
	local gear = block("gear", L["Quest reward upgrade"], nil)
	gear.Item = iconTile(gear, 36, itemTip)
	gear.Item:SetPoint("TOPLEFT", gear, "TOPLEFT", IN, -TOP)
	gear.Name = line(gear, "body", "item", TOP + 1, IN + 48)
	gear.Gain = line(gear, "small", "success", TOP + 21, IN + 48)
	gear.From = line(gear, "small", "textDim", TOP + 52)
	gear.When = line(gear, "small", "textMuted", TOP + 70)
	gear.Go = action(gear, L["View in Lookup"], TOP + 94, function()
		if gear.psItemId and UI.ShowLookup then UI.ShowLookup({ kind = "item", id = gear.psItemId }) end
	end)
	gear.psOpen = function() gear.Go:Click() end
	gear.psH = TOP + 122

	-- Rares in this zone.
	local rares = block("rares", L["Rares nearby"], function()
		if ns.Rares and ns.Rares.Show then ns.Rares.Show() end
	end)
	rares.Name = line(rares, "body", "rare", TOP)
	rares.Facts = line(rares, "small", "textDim", TOP + 20)
	rares.Count = line(rares, "small", "textMuted", TOP + 38)
	rares.Go = action(rares, L["Open Rares"], TOP + 62, function()
		local R = ns.Rares
		if R and R.Show then R.Show(rares.psRare and "rare", rares.psRare) end
	end)
	rares.psH = TOP + 90
end

---------------------------------------------------------------------------
-- Filling the cards (each -> true when it has something to show)
---------------------------------------------------------------------------

local function setStat(s, value, color)
	s.Value:SetText(value or "")
	W.Color(s.Value, color or "text")
	local on = value ~= nil
	s.Glyph:SetShown(on)
	s.Label:SetShown(on)
	s.Value:SetShown(on)
	if s.Bar then s.Bar:SetShown(on) end
	if s.Split and not on then s.Split:Hide() end
end

-- The character's way to the next level: share of the level done, about how
-- many of the guide's quests are left to it (its average quest XP, from
-- Levels.ForGuide), and rested XP. -> share text, the rest, fraction | nil
-- at the level cap.
local function levelText(xp)
	local info = playerInfo()
	local cur, need = tonumber(info.xp) or 0, tonumber(info.xpMax) or 0
	if need <= 0 or not info.level then return nil end
	local frac = min(1, cur / need)
	local share = format(L["%d%% to %d"], floor(frac * 100), info.level + 1)
	local parts = {}
	if xp and (xp.quests or 0) > 0 and (xp.questXP or 0) > 0 then
		local n = math.ceil((need - cur) / (xp.questXP / xp.quests))
		parts[#parts + 1] = n == 1 and L["about 1 quest"] or format(L["about %d quests"], n)
	end
	local rested = GetXPExhaustion and tonumber(GetXPExhaustion())
	if rested and rested > 0 then parts[#parts + 1] = format(L["%s rested"], thousands(rested)) end
	return share, table.concat(parts, DOT), frac
end

-- A painting as wide as its card, painted again when the place or the width
-- changes.
local function paintArt(c, art, key, uiMapID, x, y, index)
	local w = c:GetWidth() - (c.psInset or 1) * 2
	local mark = tostring(key) .. "@" .. w
	if c.psPainted == mark then return end
	art:SetWidth(w)
	art.psW = w
	c.psArt = ZoneArt.Paint(art, uiMapID, x, y, index)
	c.psPainted = mark
end

local function fillHero(c, g, t, index, byId)
	c.psGuide, c.psTab, c.psIndex = g, t, index
	if not g then
		c.Name:SetText(L["No guide yet"])
		c.Range:Hide()
		c.Step:SetText(L["Pick a guide to start your journey."])
		W.SetProgress(c.Bar, 0)
		for _, s in ipairs({ c.Next, c.Left, c.Then, c.Estimate }) do setStat(s, nil) end
		placeStats(c.Card, { c.Next, c.Left, c.Then, c.Estimate }, c:GetWidth())
		paintArt(c, c.Art, "none", nil, nil, nil, 1)
		W.SetButtonText(c.Go, L["Choose a guide"])
		c.Go:SetScript("OnClick", function() showGuide(nil) end)
		return true
	end
	c.Go:SetScript("OnClick", function() load(c.psGuide, c.psTab, c.psIndex) end)
	c.Name:SetText(g.title or g.id)
	-- The level range: the fact that decides the guide, on an accent chip.
	local range = UI.LevelRange(g.minLevel, g.maxLevel)
	if range then
		W.SetChip(c.Range, range, "accent")
		c.Range:Show()
	else
		c.Range:Hide()
	end
	local total = t and (t.total or t.stepCount) or 0
	local frac = (t and total > 0) and (t.done or 0) / total or 0
	if t and t.complete then
		c.Step:SetText(L["Finished"])
	elseif t and t.stepIndex then
		c.Step:SetText(format(L["Step %d of %d"], t.stepIndex, t.stepCount or 0) .. DOT .. format(L["%d%% complete"], floor(frac * 100 + 0.5)))
	else
		c.Step:SetText(L["Not started"])
	end
	W.SetProgress(c.Bar, frac, c:GetWidth() - 2)
	W.SetButtonText(c.Go, t and L["Continue guide"] or L["Load guide"])
	paintArt(c, c.Art, g.id, g.zone, nil, nil, 1)
	-- The facts: what is left of the guide for this character.
	setStat(c.Next, t and nextStepTitle(g, t, index) or nil)
	local xp = guideXP(g.id)
	c.psXP = xp
	if xp then
		-- Quests with no XP known still have to be done.
		local q = (xp.quests or 0) + (xp.unknown or 0)
		local parts = { q == 1 and L["1 quest"] or format(L["%d quests"], q) }
		if (xp.kills or 0) > 0 then parts[#parts + 1] = format(L["%s kills/loot"], thousands(xp.kills)) end
		setStat(c.Left, table.concat(parts, DOT))
	else
		local q = guideQuests(g)
		setStat(c.Left, q == 1 and L["1 quest"] or format(L["%d quests"], q))
	end
	local n = nextGuide(g, byId)
	setStat(c.Then, n and ((n.title or n.id) .. " " .. rangeText(n.minLevel, n.maxLevel)) or nil)
	if xp and not xp.maxed and (xp.xp or 0) > 0 then
		setStat(c.Estimate, format(L["+%.1f levels (%s XP)"], xp.levels or 0, thousands(xp.xp)))
	else
		setStat(c.Estimate, nil)
	end
	placeStats(c.Card, { c.Next, c.Left, c.Then, c.Estimate }, c:GetWidth())
	return true
end

-- The talent plan the player picked ("Follow this plan" on Talents): where
-- they stand on it. None picked yet: the class's plans, one button each, to
-- pick one here.
local function showPicked(c, on)
	for _, k in ipairs({ "Picks", "Label", "Next", "When" }) do c[k]:SetShown(on) end
	c.Ask:SetShown(not on)
	if on then
		for _, b in ipairs(c.Choices) do b:Hide() end
	else
		for _, b in ipairs(c.Icons) do b:Hide() end
	end
end

local function fillChoice(c, T)
	local data = T.Data and T.Data()
	if not (data and type(data.builds) == "table" and #data.builds > 0) then return false end
	showPicked(c, false)
	c.Class:SetShown(classIcon(c.Class, playerInfo().class))
	c.Spec:SetText(L["Pick a leveling build"])
	-- The buttons in a row on the text edge, under the ask.
	local x = IN
	for i, b in ipairs(c.Choices) do
		local plan = data.builds[i]
		if plan then
			b.psKey = plan.key
			W.SetButtonText(b, plan.specName or plan.key)
			b.psTip = plan.split and format(L["%s plan (%s)"], plan.specName or plan.key, plan.split) or nil
			b:ClearAllPoints()
			b:SetPoint("TOPLEFT", c, "TOPLEFT", x, -(TOP + 52))
			x = x + b:GetWidth() + 8
			b:Show()
		else
			b:Hide()
		end
	end
	return true
end

local function fillBuild(c)
	local T = ns.Talents
	if not (T and T.Current and T.Choice) then return false end
	if T.Choice() == "auto" then return fillChoice(c, T) end
	local cur = T.Current()
	local s = cur and cur.state
	if not (s and cur.build) then return false end
	showPicked(c, true)
	local info = playerInfo()
	c.Class:SetShown(classIcon(c.Class, info.class))
	c.Spec:SetText(cur.build.specName or "")
	c.Picks:SetText(format(L["%d of %d picks taken"], s.done, s.total))
	-- The next distinct talents of the plan, from the first not met.
	local picks, seen, n, first = cur.build.picks or {}, {}, 0, nil
	local room = floor((c:GetWidth() - IN * 2 + 8) / (ICON + 8))
	for i, p in ipairs(picks) do
		if n >= min(room, #c.Icons) then break end
		if i > s.done and not seen[p.node] then
			seen[p.node] = true
			first = first or i
			n = n + 1
			local node = cur.data.nodes and cur.data.nodes[p.node]
			local b = c.Icons[n]
			b.psSpell = node and node.spell
			b.psTip = T.NodeName and T.NodeName(cur.data, p.node, cur.valid) or nil
			local icon = node and node.spell and ns.Compat.SpellIcon and ns.Compat.SpellIcon(node.spell)
			b.Icon:SetTexture(icon or Theme.Media("icon-learn"))
			if icon then b.Icon:SetVertexColor(1, 1, 1, 1) else W.Color(b.Icon, "textDim") end
			b:Show()
		end
	end
	for i = n + 1, #c.Icons do c.Icons[i]:Hide() end
	c.Label:SetShown(n > 0)
	c.When:SetText("")
	W.Color(c.When, "textDim")
	if s.status == "complete" then
		c.Next:SetText(L["Talent plan complete"])
	elseif s.next then
		c.Next:SetText("|c" .. Theme.Hex("textDim") .. L["Next talent:"] .. "|r  " .. T.PickText(cur.data, s.next, cur.valid))
		if s.status == "early" then
			-- No point yet: say when the first one comes.
			c.When:SetText(format(L["Your first talent point comes at level %d"], T.FIRST_LEVEL or 10))
		elseif s.status == "behind" then
			c.When:SetText(s.unspent == 1 and L["1 point to spend"] or format(L["%d points to spend"], s.unspent))
			W.Color(c.When, "warning")
		elseif s.status == "offplan" then
			c.When:SetText(L["Some points are off the plan"])
			W.Color(c.When, "warning")
		elseif first then
			c.When:SetText(format(L["Around level %d"], (T.FIRST_LEVEL or 10) + first - 1))
		end
	end
	return true
end

-- The name sits over the Small line on a painting, or in its place when
-- there is none.
local function placeName(c)
	local sub = (c.Step:GetText() or "") ~= ""
	c.Name:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", IN - c.psInset, sub and 36 or 20)
end

local function fillDungeons(c)
	local DS = UI.DungeonsSection
	local list = DS and DS.ForYou and DS.ForYou() or {}
	local d = list[1]
	if not d then return false end
	c.psDungeon = d.key
	c.Name:SetText(d.name)
	c.Count:SetText(#list == 1 and L["1 dungeon for your level"] or format(L["%d dungeons for your level"], #list))
	placeName(c)
	setStat(c.Levels, UI.LevelRange(d.minLevel, d.maxLevel))
	setStat(c.Zone, d.zoneName)
	local q = d.quests or {}
	local nq = q[SIDE_LETTER[UI.PlayerFaction() or ""] or ""] or max(q.A or 0, q.H or 0)
	setStat(c.Quests, nq == 1 and L["1 quest"] or format(L["%d quests"], nq))
	placeStats(c.Card, { c.Levels, c.Zone, c.Quests }, c:GetWidth())
	local e = d.entrance
	paintArt(c, c.Art, d.key, e and e.map or d.zone, e and e.x, e and e.y, 2)
	return true
end

local function fillNext(c, g, byId)
	if not g then return false end
	local n, choice = nextGuide(g, byId)
	if not n then return false end
	c.psGuide = n
	c.Name:SetText(n.title or n.id)
	c.Step:SetText(choice and L["One of the routes on from here"] or "")
	placeName(c)
	setStat(c.Levels, UI.LevelRange(n.minLevel, n.maxLevel))
	local q = guideQuests(n)
	setStat(c.Quests, q > 0 and (q == 1 and L["1 quest planned"] or format(L["%d quests planned"], q)) or nil)
	placeStats(c.Card, { c.Levels, c.Quests }, c:GetWidth())
	paintArt(c, c.Art, n.id, n.zone, nil, nil, 3)
	return true
end

-- The guide's own class training first: a `train` goal at a class trainer of
-- the character's class in the active guide's next steps (the trainer the
-- engine picked for it, the one the guide window shows). -> goal view, steps
-- ahead | nil
local function guideTraining(Eng)
	if not (Eng.GetStepView and Eng.GetStepIndex and Eng.IsClassTrainer) then return nil end
	local from, count = Eng.GetStepIndex() or 1, Eng.GetStepCount and Eng.GetStepCount() or 0
	for i = from, min(count, from + TRAIN_AHEAD) do
		local v = Eng.GetStepView(i)
		for _, g in ipairs(v and v.goals or {}) do
			if g.t == "train" and g.npc and g.status ~= "done" and g.status ~= "skipped" and g.status ~= "na" and Eng.IsClassTrainer(g.npc) then
				return g, i - from
			end
		end
	end
	return nil
end

local function knows(id)
	if IsPlayerSpell and IsPlayerSpell(id) then return true end
	return IsSpellKnown and IsSpellKnown(id) or false
end

local function spellName(id)
	local name = C_Spell and C_Spell.GetSpellName and C_Spell.GetSpellName(id)
	if not name and GetSpellInfo then name = GetSpellInfo(id) end
	return name
end

-- The class's trainer spells (Engine.ClassSpells) the character can learn
-- now: at or under their level, for their race, not known yet, the rank
-- before known, and not a talent (the talent plan's spells). nil without the
-- list.
local function spellsToTrain(Eng, info)
	local list = Eng.ClassSpells and info.class and Eng.ClassSpells(info.class)
	if not (list and info.level) then return nil end
	local talent = {}
	local T = ns.Talents
	local data = T and T.Data and T.Data(info.class)
	for _, n in pairs(data and data.nodes or {}) do
		if type(n) == "table" and n.spell then talent[n.spell] = true end
	end
	local raceBit
	if UnitRace and bit and bit.lshift then
		local _, _, id = UnitRace("player")
		if type(id) == "number" and id > 0 then raceBit = bit.lshift(1, id - 1) end
	end
	-- Now: the spells it can learn. Then: those of the next level that has
	-- any, whose rank before is known or learnable by then. -> now, then, its level
	local out, soon, soonLevel, open = {}, {}, nil, {}
	for _, r in ipairs(list) do
		local id, lv, prev, races = r[1], r[2], r[3], r[4]
		if soonLevel and lv > soonLevel then break end
		local forRace = races == 0 or races == -1 or not raceBit or bit.band(races, raceBit) ~= 0
		if forRace and not talent[id] and not knows(id) and (prev == 0 or knows(prev) or open[prev]) then
			if lv <= info.level then
				out[#out + 1] = id
				open[id] = true
			else
				soonLevel = lv
				soon[#soon + 1] = id
			end
		end
	end
	return out, soon, soonLevel
end

-- Class training: the spells waiting at the trainer, and where to go: the
-- guide's training step when one is coming (its trainer), else the nearest
-- trainer. Without the spell list (an older client table), new skills wait
-- once an even level has passed since the last visit.
local function fillTrainer(c)
	local Eng = E()
	if not Eng then return false end
	local info = playerInfo()
	local level = info.level
	local last = tonumber(ns.CharState().classTrainLevel)
	local spells, soon, soonLevel = spellsToTrain(Eng, info)
	local goal, ahead = guideTraining(Eng)
	local t
	if goal then
		t = { npcName = goal.npcName, map = goal.map, x = goal.x, y = goal.y, f = goal.f, z = goal.z }
	else
		t = Eng.NearestClassTrainer and Eng.NearestClassTrainer()
		if not t then return false end
	end
	local due
	if spells then
		due = #spells > 0
	elseif goal then
		due = true
	elseif level and last then
		due = floor(level / 2) > floor(last / 2)
	else
		return false
	end
	local status
	if goal then
		status = ahead == 0 and L["Your guide trains you now"]
			or ahead == 1 and L["Your guide trains you next step"]
			or format(L["Your guide trains you in %d steps"], ahead)
	elseif spells then
		status = #spells == 0 and L["Class skills up to date"]
			or #spells == 1 and L["1 spell to train"] or format(L["%d spells to train"], #spells)
	else
		status = due and L["New abilities available"] or L["Class skills up to date"]
	end
	c.psTrainer = t
	c.Status:SetText(status)
	W.Color(c.Status, due and "warning" or "text")
	local zone = t.map and UI.MapName(t.map) or nil
	c.Place:SetText(t.npcName and zone and (t.npcName .. ", " .. zone) or t.npcName or zone or "")
	-- The spells: as many icons as fit, the names of the first few.
	local room = min(#c.Icons, floor((c:GetWidth() - IN * 2 + 8) / (ICON + 8)))
	local names = {}
	for i, b in ipairs(c.Icons) do
		local id = spells and spells[i]
		if id and i <= room then
			b.psSpell = id
			b.psTip = spellName(id)
			local icon = ns.Compat.SpellIcon and ns.Compat.SpellIcon(id)
			b.Icon:SetTexture(icon or Theme.Media("icon-learn"))
			if icon then b.Icon:SetVertexColor(1, 1, 1, 1) else W.Color(b.Icon, "textDim") end
			b:Show()
			if #names < 3 then names[#names + 1] = spellName(id) end
		else
			b:Hide()
		end
	end
	local more = spells and #spells - #names or 0
	local text = table.concat(names, ", ")
	if more > 0 and text ~= "" then text = format(L["%s and %d more"], text, more) end
	c.Spells:SetText(text)
	-- What the next level with new spells brings; without the spell list,
	-- when the character last trained.
	if soonLevel then
		local next = {}
		for i = 1, min(3, #soon) do next[#next + 1] = spellName(soon[i]) end
		local list = table.concat(next, ", ")
		if #soon > #next then list = format(L["%s and %d more"], list, #soon - #next) end
		c.Last:SetText(format(L["At level %d: %s"], soonLevel, list))
	else
		c.Last:SetText(last and not spells and format(L["Last trained at level %d"], last) or "")
	end
	return true
end

-- The first turn-in ahead in the active guide whose reward pick (the one
-- the guide window marks on that goal) is an upgrade.
local function fillGear(c)
	local Eng, GP = E(), UI.GearPick
	if not (Eng and Eng.GetStepView and Eng.GetStepIndex and GP and GP.PickFor) then return false end
	local from, count = Eng.GetStepIndex() or 1, Eng.GetStepCount and Eng.GetStepCount() or 0
	local found, quest, at
	for i = from, min(count, from + GEAR_AHEAD) do
		local v = Eng.GetStepView(i)
		for _, goal in ipairs(v and v.goals or {}) do
			local pick = GP.PickFor(goal)
			if pick and pick.upgrade and pick.entry then
				found, quest, at = pick, goal.subject or goal.title, i
				break
			end
		end
		if found then break end
	end
	if not found then return false end
	local id = found.entry.id
	c.psItemId = id
	c.Item.psItem = id
	local icon = ns.Compat.ItemIcon and ns.Compat.ItemIcon(id)
	c.Item.Icon:SetTexture(icon or Theme.Media("icon-use"))
	c.Name:SetText(itemName(id) or (L["Item"] .. " " .. id))
	local gain = found.entry.pct and ns.Gear and ns.Gear.GainText and ns.Gear.GainText(found.entry.pct)
	c.Gain:SetText(gain and format(L["Upgrade, %s"], gain) or L["Upgrade"])
	c.From:SetText(quest and format(L["Reward from %s"], quest) or "")
	local ahead = at - from
	c.When:SetText(ahead == 0 and L["Turned in at this step"] or ahead == 1 and L["Turned in 1 step ahead"] or format(L["Turned in %d steps ahead"], ahead))
	return true
end

local function fillRares(c)
	local R = ns.Rares
	local here = ns.PlayerPoint and ns.PlayerPoint()
	if not (R and R.ListOf and here) then return false end
	local ok, list = pcall(R.ListOf, "rare")
	if not ok or type(list) ~= "table" then return false end
	local inZone = {}
	for _, rec in ipairs(list) do
		for _, sp in ipairs(rec.spawns or {}) do
			if sp.map == here.map then inZone[#inZone + 1] = rec break end
		end
	end
	local rec = inZone[1]
	if not rec then return false end
	c.psRare = rec.id
	c.Name:SetText(rec.name or "")
	local facts = {}
	local lv = R.LevelText(rec.level, rec.levelMax)
	if lv then facts[#facts + 1] = format(L["Level %s"], lv) end
	facts[#facts + 1] = R.KindText("rare", rec.elite)
	c.Facts:SetText(table.concat(facts, DOT))
	local zone = UI.MapName(here.map) or ""
	c.Count:SetText(#inZone == 1 and format(L["1 rare in %s"], zone) or format(L["%d rares in %s"], #inZone, zone))
	return true
end

---------------------------------------------------------------------------
-- Header and the character panel
---------------------------------------------------------------------------

-- The sidebar on Home is the character's, not an index: under the lockup,
-- from where the navigation starts on other sections (level with the rail's
-- first section), their name and who they are, the way to the next level,
-- then a few facts as rows (the talent plan, where they are, their gold),
-- and under "Time" the XP tracker's clock (QoL.GetXPStats: this session,
-- this level, the pace and the time to level; gone while the tracker is
-- off), kept current every 15 seconds while it shows. Nothing in it is a
-- control.
local NAME_Y = 8 -- the name, a little under that line
local FACT_H = 32
local TICK = 15 -- seconds between the clock's updates while Home shows

local panel

local tick
local function showPanel(on)
	if panel then panel:SetShown(on) end
	tick(on)
end

local function fact(y, label)
	local r = {}
	r.Label = W.Text(panel, "small", "textDim")
	r.Label:SetText(label)
	r.Label:SetPoint("LEFT", panel, "TOPLEFT", 0, -(y + FACT_H / 2))
	r.Value = W.Text(panel, "label", "text")
	r.Value:SetJustifyH("RIGHT")
	r.Value:SetWordWrap(false)
	r.Value:SetPoint("RIGHT", panel, "TOPRIGHT", 0, -(y + FACT_H / 2))
	r.Value:SetPoint("LEFT", r.Label, "RIGHT", 12, 0)
	r.Rule = W.Divider(panel)
	r.Rule:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -(y + FACT_H))
	r.Rule:SetPoint("TOPRIGHT", panel, "TOPRIGHT", 0, -(y + FACT_H))
	return r
end

local function buildPanel()
	local side = hub.Sidebar
	panel = CreateFrame("Frame", nil, side)
	panel:SetPoint("TOPLEFT", side, "TOPLEFT", SH.side, -(hub.psNavTop or SH.header + 12))
	panel:SetPoint("BOTTOMRIGHT", side, "BOTTOMRIGHT", -SH.side, SH.footer)
	local y = NAME_Y
	panel.Name = W.Text(panel, "title", "text")
	panel.Name:SetJustifyH("LEFT")
	panel.Name:SetWordWrap(false)
	panel.Name:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -y)
	panel.Name:SetPoint("RIGHT", panel, "RIGHT", 0, 0)
	panel.Who = W.Text(panel, "small", "textDim")
	panel.Who:SetJustifyH("LEFT")
	panel.Who:SetWordWrap(false)
	panel.Who:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -(y + 22))
	panel.Who:SetPoint("RIGHT", panel, "RIGHT", 0, 0)
	-- The way to the next level: its share over a progress line, the rest
	-- (quests to it, rested XP) under it.
	y = y + 52
	local lv = {}
	lv.Label = W.Text(panel, "small", "textMuted")
	lv.Label:SetText(L["Next level"])
	lv.Label:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -y)
	lv.Value = W.Text(panel, "number", "text")
	lv.Value:SetJustifyH("RIGHT")
	lv.Value:SetPoint("TOPRIGHT", panel, "TOPRIGHT", 0, -y)
	lv.Bar = W.ProgressLine(panel, 2)
	lv.Bar:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -(y + 20))
	lv.Bar:SetPoint("TOPRIGHT", panel, "TOPRIGHT", 0, -(y + 20))
	lv.Note = W.Text(panel, "small", "textDim")
	lv.Note:SetJustifyH("LEFT")
	lv.Note:SetWordWrap(false)
	lv.Note:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -(y + 30))
	lv.Note:SetPoint("RIGHT", panel, "RIGHT", 0, 0)
	panel.Level = lv
	y = y + 56
	panel.Plan = fact(y, L["Talent plan"])
	panel.Zone = fact(y + FACT_H, L["Zone"])
	W.Color(panel.Zone.Value, "place")
	panel.Gold = fact(y + FACT_H * 2, L["Gold"])
	panel.TimeHead = W.Text(panel, "small", "textMuted")
	panel.TimeHead:SetText(L["Time"])
	panel.Session = fact(0, L["This session"])
	panel.ThisLevel = fact(0, L["This level"])
	panel.Rate = fact(0, L["XP per hour"])
	panel.ToLevel = fact(0, L["Time to level"])
	panel.Times = { panel.Session, panel.ThisLevel, panel.Rate, panel.ToLevel }
end

-- Facts in rows from y down; one with nothing to say is left out and the
-- rest close up. -> the line under the last
local function placeFacts(list, y)
	for _, r in ipairs(list) do
		local on = (r.Value:GetText() or "") ~= ""
		r.Label:SetShown(on)
		r.Value:SetShown(on)
		r.Rule:SetShown(on)
		r.Label:SetPoint("LEFT", panel, "TOPLEFT", 0, -(y + FACT_H / 2))
		r.Value:SetPoint("RIGHT", panel, "TOPRIGHT", 0, -(y + FACT_H / 2))
		r.Rule:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -(y + FACT_H))
		r.Rule:SetPoint("TOPRIGHT", panel, "TOPRIGHT", 0, -(y + FACT_H))
		if on then y = y + FACT_H end
	end
	return y
end

-- The clock, from the XP tracker: this session and this level, then the
-- pace and the time to level once there is one. Nothing at the level cap
-- but the session.
local function fillTime()
	for _, r in ipairs(panel.Times) do r.Value:SetText("") end
	local QoL = ns.QoL
	local st = QoL and QoL.GetXPStats and QoL.GetXPStats()
	if not (st and QoL.Duration) then return end
	panel.Session.Value:SetText(QoL.Duration(st.sessionSeconds))
	if st.maxed then return end
	panel.ThisLevel.Value:SetText(QoL.Duration(st.levelSeconds))
	if (st.rate or 0) > 0 and st.timeToLevel then
		local short = QoL.XP and QoL.XP.Short
		panel.Rate.Value:SetText(format(L["%s XP/h"], short and short(st.rate) or thousands(st.rate)))
		panel.ToLevel.Value:SetText(QoL.Duration(st.timeToLevel))
	end
end

local function layoutPanel()
	local y = placeFacts({ panel.Plan, panel.Zone, panel.Gold }, panel.psFactsY or 0)
	fillTime()
	local any = false
	for _, r in ipairs(panel.Times) do
		if (r.Value:GetText() or "") ~= "" then any = true end
	end
	panel.TimeHead:SetShown(any)
	panel.TimeHead:ClearAllPoints()
	panel.TimeHead:SetPoint("TOPLEFT", panel, "TOPLEFT", 0, -(y + 20))
	placeFacts(panel.Times, any and y + 34 or y)
end

-- The clock ticks only while Home shows.
local ticker
function tick(on)
	if ticker then ticker:Cancel() ticker = nil end
	if on and C_Timer and C_Timer.NewTicker then
		ticker = C_Timer.NewTicker(TICK, function() if panel and panel:IsVisible() then layoutPanel() end end)
	end
end

local function renderPanel(xp)
	if not panel then buildPanel() end
	local info = playerInfo()
	panel.Name:SetText(type(info.name) == "string" and info.name or "")
	local who = {}
	if info.level then who[#who + 1] = format(L["Level %d"], info.level) end
	local race = UnitRace and UnitRace("player") -- its name, as the game shows it
	if type(race) == "string" and race ~= "" then who[#who + 1] = race end
	if info.class then who[#who + 1] = UI.ClassName(info.class) end
	panel.Who:SetText(table.concat(who, " "))
	-- At the level cap the next level's lines go and the facts move up.
	local lv = panel.Level
	local share, rest, frac = levelText(xp)
	for _, r in ipairs({ lv.Label, lv.Value, lv.Bar, lv.Note }) do r:SetShown(share ~= nil) end
	if share then
		lv.Value:SetText(share)
		lv.Note:SetText(rest)
		W.SetProgress(lv.Bar, frac, (hub.psSidebar or SH.sidebar) - SH.side * 2)
	end
	-- The facts: the talent plan followed, where the character is, their gold.
	local T = ns.Talents
	local plan
	if T and T.Choice and T.Choice() ~= "auto" and T.Current then
		local ok, cur = pcall(T.Current)
		plan = ok and cur and cur.build and cur.build.specName or nil
	end
	panel.Plan.Value:SetText(plan or L["None yet"])
	W.Color(panel.Plan.Value, plan and "text" or "textMuted")
	local here = ns.PlayerPoint and ns.PlayerPoint()
	panel.Zone.Value:SetText(here and UI.MapName(here.map) or "")
	local copper = GetMoney and tonumber(GetMoney())
	panel.Gold.Value:SetText(copper and ns.MoneyText and ns.MoneyText(copper) or "")
	panel.psFactsY = NAME_Y + (share and 108 or 52)
	layoutPanel()
	showPanel(true)
end

-- The title at 32/32: "Home", and what the page is for under it.
local function renderHeader()
	W.ShellTitle(hub, L["Home"], L["Your journey at a glance, and what comes next."])
end

---------------------------------------------------------------------------
-- The section
---------------------------------------------------------------------------

local ORDER = { "build", "dungeons", "next", "trainer", "gear", "rares" }

-- The page's width: the main column (anchored frames have no width before
-- the first layout).
local function pageWidth()
	return hub:GetWidth() - (hub.psRail or SH.rail) - (hub.psSidebar or SH.sidebar) - 2
end

function HV.Build(parent, shell)
	if root then return root end
	hub = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)
	page = CreateFrame("Frame", nil, root)
	page:SetAllPoints(root)
	page.Scroll = W.Scroll(page)
	page.Scroll:SetPoint("TOPLEFT", page, "TOPLEFT", 0, 0)
	page.Scroll:SetPoint("BOTTOMRIGHT", page, "BOTTOMRIGHT", 0, 0)
	buildCards()
	-- The section's own frame, which the hub shows and hides: the character
	-- panel in the sidebar follows it.
	parent:HookScript("OnShow", function() showPanel(true) end)
	parent:HookScript("OnHide", function() showPanel(false) end)
	return root
end

function HV.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	local byId = headers()
	local tabs, active = tabsInfo()
	local g, t, index = featuredGuide(byId, tabs, active)
	renderHeader()
	local width = pageWidth()
	page.Scroll.Child:SetWidth(width)
	local full = width - EDGE * 2
	local each = floor((full - GAP * (PER - 1)) / PER)
	local y = 4
	local hero = cards.hero
	hero:SetSize(full, hero.psH)
	hero:ClearAllPoints()
	hero:SetPoint("TOPLEFT", page.Scroll.Child, "TOPLEFT", EDGE, -y)
	fillHero(hero, g, t, index, byId)
	renderPanel(g and hero.psXP or nil)
	shown.hero = true
	y = y + hero.psH + 8
	local FILL = {
		build = fillBuild, dungeons = fillDungeons, next = function(c) return fillNext(c, g, byId) end,
		trainer = fillTrainer, gear = fillGear, rares = fillRares,
	}
	-- Which blocks have something to show, then PER to a line in order, the
	-- line as tall as its tallest; a last line with fewer widens them to the
	-- page's width (filled again at that width: icons and art fit to it).
	local list = {}
	for _, key in ipairs(ORDER) do
		local c = cards[key]
		c:SetSize(each, c.psH)
		local ok, has = pcall(FILL[key], c)
		if ok and has then list[#list + 1] = key else c:Hide() end
	end
	local lastLine = #list - (#list - 1) % PER
	local lineH = 0
	for i, key in ipairs(list) do
		local c = cards[key]
		local col = (i - 1) % PER
		local w = each
		if i >= lastLine then
			local k = #list - lastLine + 1
			w = floor((full - GAP * (k - 1)) / k)
		end
		if w ~= each then
			c:SetSize(w, c.psH)
			pcall(FILL[key], c)
		end
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", page.Scroll.Child, "TOPLEFT", EDGE + col * (w + GAP), -y)
		c:Show()
		shown[key] = true
		lineH = max(lineH, c.psH)
		if col == PER - 1 or i == #list then
			y = y + lineH + 8
			lineH = 0
		end
	end
	W.SetScrollContent(page.Scroll, y + 16)
	shown.guide = g and g.id or nil
end

function HV.Shown() return shown end
function HV.Panel() return panel end
function HV.Cards() return cards end

function HV.Show()
	local P = UI.Picker
	if P and P.ShowSection then P.ShowSection("Home") end
	if UI.ShowPicker then UI.ShowPicker() end
end

local function refresh()
	local P = UI.Picker
	if root and root:IsVisible() and P and P.Render then P.Render() end
end
for _, ev in ipairs({ "TALENTS_UPDATED", "TABS_CHANGED", "CLASS_TRAINED", "RARE_NEARBY" }) do ns.On(ev, refresh) end
-- XP gained: the clock's pace and time to level move with it.
ns.On("QOL_XP_UPDATED", function() if panel and panel:IsVisible() then layoutPanel() end end)
ns.RegisterEvent("PLAYER_LEVEL_UP", refresh)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", refresh)
Theme.OnChanged(function() if root and root:IsVisible() then HV.Render() end end)

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Home", label = L["Home"], icon = "home", order = 5,
		home = true,
		-- No index: the sidebar holds the character panel.
		nav = function() return {}, nil end,
		build = HV.Build, render = HV.Render,
	})
end
