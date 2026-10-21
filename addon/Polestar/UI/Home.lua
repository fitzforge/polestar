-- Home, the hub's first section (UI.RegisterSection, order 5, `bare`: no
-- sidebar, the page runs from the rail to the window's edge; the hub opens
-- here from the key binding until the player picks a section): your journey
-- at a glance, from data the other modules already keep.
--
-- Header: "Your journey", the character ("Level 18 · Alliance Mage ·
-- Darkshore") beside the faction's crest. Footer: the wordmark and "A
-- community project", the version with its stage chip, the Discord link
-- (what the sidebar holds on the other sections).
--
-- Body, scrolling, on cards: the guide to continue across the top (the
-- active tab's guide, else the suggestion: zone art, step, progress, the
-- next step; then Levels.ForGuide's estimate, the quests and kills left and
-- where it leads, and Continue), then three to a line:
--   Leveling build     the talent plan the player picked: class, spec, picks
--                      taken, the next picks' spell icons, the next pick;
--                      before level 10, when the first point comes. None
--                      picked yet: the class's plans, a button each to pick
--   Dungeons           the first of Dungeons.ForYou with its entrance painted
--   Up next            where the guide leads (`next`, route choices)
--   Class training     the guide's own class training step when one comes in
--                      the next 15 steps, at the trainer it picked; else new
--                      skills since CharState().classTrainLevel (even levels)
--                      and the nearest trainer; Guide me points the arrow
--   Quest reward       the first turn-in ahead in the active guide (40 steps)
--   upgrade            whose reward pick is an upgrade (UI.GearPick.PickFor:
--                      ItemDB's reward choices ranked by the spec's weights)
--   Rares nearby       the rares the Codex places in the player's zone
-- A card with nothing to say is left out and the rest close up.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, ipairs, pairs, format, type, tonumber = math.floor, math.max, math.min, ipairs, pairs, string.format, type, tonumber
local ZoneArt = UI.ZoneArt

if not (W and W.SHELL and ZoneArt) then return end

local SH = W.SHELL
local DOT = "  \194\183  "
local GAP = 12 -- between cards
local EDGE = 16 -- the cards' inset in the page
local CP = 16 -- inside a card
local HEAD_H = 40 -- a card's heading row
local HERO_H = 216
-- Every card under the hero is as tall as the tallest content (the build's
-- last line), so a line stays even when a card drops out and the rest close up.
local CARD_H = 212
local PER = 3 -- cards to a line under the hero
local STATS_W = 340 -- the hero's stats column, right
local ICON = 32 -- a talent icon
local SIDE_LETTER = { Alliance = "A", Horde = "H" }
local GEAR_AHEAD = 40 -- steps searched for a reward upgrade
local TRAIN_AHEAD = 15 -- steps searched for the guide's class training

local HV = {}
UI.HomeSection = HV

local root, hub, page, foot, crest
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

local function cardEnter(self)
	self.Hover:Show()
	W.Color(self.Head.Chevron, "text")
end

local function cardLeave(self)
	self.Hover:Hide()
	W.Color(self.Head.Chevron, "textMuted")
end

local function cardClick(self)
	if self.psOpen then self.psOpen(self) end
end

-- A card: a panel with a heading row (accent glyph, title, chevron); a click
-- anywhere on it but its own buttons opens where it leads (c.psOpen(c)).
local function card(key, icon, title, onOpen)
	local c = CreateFrame("Button", nil, page.Scroll.Child)
	Theme.Skin(c, "panel")
	c.psKey, c.psOpen = key, onOpen
	c.Hover = W.Tex(c, "BORDER")
	c.Hover:SetPoint("TOPLEFT", c, "TOPLEFT", 1, -1)
	c.Hover:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -1, 1)
	W.Painter(c.Hover, function(t) t:SetVertexColor(Theme.Wash("hover")) end)
	c.Hover:Hide()
	c:SetScript("OnEnter", cardEnter)
	c:SetScript("OnLeave", cardLeave)
	c:SetScript("OnClick", cardClick)
	local head = CreateFrame("Frame", nil, c)
	head:SetHeight(HEAD_H)
	head:SetPoint("TOPLEFT", c, "TOPLEFT", 0, 0)
	head:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, 0)
	head.Glyph = W.Tex(head, "ARTWORK", icon, "accent")
	head.Glyph:SetSize(16, 16)
	head.Glyph:SetPoint("LEFT", head, "LEFT", CP, 0)
	head.Text = W.Text(head, "heading", "text")
	head.Text:SetText(title)
	head.Text:SetPoint("LEFT", head.Glyph, "RIGHT", 8, 0)
	head.Chevron = W.Tex(head, "ARTWORK", "chevron-right", "textMuted")
	head.Chevron:SetSize(12, 12)
	head.Chevron:SetPoint("RIGHT", head, "RIGHT", -CP, 0)
	c.Head = head
	c.Rule = W.Divider(c)
	c.Rule:SetPoint("TOPLEFT", c, "TOPLEFT", CP, -HEAD_H)
	c.Rule:SetPoint("TOPRIGHT", c, "TOPRIGHT", -CP, -HEAD_H)
	cards[key] = c
	return c
end

local function line(c, role, color, y, x, right)
	local fs = W.Text(c, role, color)
	fs:SetJustifyH("LEFT")
	fs:SetWordWrap(false)
	fs:SetPoint("TOPLEFT", c, "TOPLEFT", x or CP, -y)
	fs:SetPoint("RIGHT", c, "RIGHT", -(right or CP), 0)
	return fs
end

local function footButton(c, text, onClick)
	local b = W.Button(c, text, onClick, { height = 26 })
	b:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", CP, CP)
	b:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", -CP, CP)
	return b
end

-- One of the hero's stats: a glyph, a label over a value, and with `bar` a
-- progress line under it (placed by placeStats, the shown ones from the top).
local function stat(c, icon, label, bar)
	local s = {}
	if bar then s.Bar = W.ProgressLine(c, 2) end
	s.Glyph = W.Tex(c, "ARTWORK", icon, "accent")
	s.Glyph:SetSize(16, 16)
	s.Label = W.Text(c, "small", "textDim")
	s.Label:SetText(label)
	s.Value = W.Text(c, "body", "text")
	s.Value:SetWordWrap(false)
	s.Value:SetJustifyH("LEFT")
	return s
end

local function placeStats(c, list)
	local y = HEAD_H + 12
	for _, s in ipairs(list) do
		if s.Value:IsShown() then
			s.Glyph:ClearAllPoints()
			s.Glyph:SetPoint("TOPLEFT", c, "TOPRIGHT", -STATS_W, -(y + 6))
			s.Label:ClearAllPoints()
			s.Label:SetPoint("TOPLEFT", c, "TOPRIGHT", -STATS_W + 28, -y)
			s.Value:ClearAllPoints()
			s.Value:SetPoint("TOPLEFT", c, "TOPRIGHT", -STATS_W + 28, -(y + 16))
			s.Value:SetPoint("RIGHT", c, "RIGHT", -CP, 0)
			if s.Bar then
				s.Bar:ClearAllPoints()
				s.Bar:SetPoint("TOPLEFT", c, "TOPRIGHT", -STATS_W + 28, -(y + 34))
				s.Bar:SetPoint("RIGHT", c, "RIGHT", -CP, 0)
				y = y + 6
			end
			y = y + 38
		end
	end
end

local function buildCards()
	-- The guide to continue.
	local hero = card("hero", "icon-level", L["Continue leveling"], function(c) showGuide(c.psGuide and c.psGuide.id) end)
	hero.Art = ZoneArt.Create(hero, 116, 112, "panel")
	hero.Art:SetPoint("TOPLEFT", hero, "TOPLEFT", CP, -(HEAD_H + 12))
	hero.Art.Rule:Hide()
	local tx, right = CP + 116 + 20, STATS_W + 24
	hero.Name = line(hero, "display", "text", HEAD_H + 16, tx, right)
	hero.Step = line(hero, "small", "textDim", HEAD_H + 46, tx, right)
	hero.Bar = W.ProgressLine(hero, 4)
	hero.Bar:SetPoint("TOPLEFT", hero, "TOPLEFT", tx, -(HEAD_H + 68))
	hero.Bar:SetPoint("RIGHT", hero, "RIGHT", -right, 0)
	hero.Next = line(hero, "label", "text", HEAD_H + 86, tx, right)
	hero.Split = W.Divider(hero, true)
	hero.Split:SetPoint("TOPLEFT", hero, "TOPRIGHT", -(STATS_W + 12), -(HEAD_H + 12))
	hero.Split:SetPoint("BOTTOMLEFT", hero, "BOTTOMRIGHT", -(STATS_W + 12), CP)
	hero.Estimate = stat(hero, "icon-level", L["Estimated to finish"])
	hero.Left = stat(hero, "icon-turnin", L["Remaining"])
	hero.Then = stat(hero, "icon-goto", L["Then"])
	hero.Level = stat(hero, "icon-skill", L["Next level"], true)
	hero.Go = W.Button(hero, L["Continue guide"], function() load(hero.psGuide, hero.psTab, hero.psIndex) end, { primary = true, height = 28 })
	hero.Go:SetPoint("BOTTOMLEFT", hero, "BOTTOMLEFT", tx, CP)
	hero.Go:SetWidth(200)

	-- Leveling build.
	local build = card("build", "icon-learn", L["Leveling build"], function() if UI.TalentsSection then UI.TalentsSection.Show() end end)
	build.Class = build:CreateTexture(nil, "ARTWORK")
	build.Class:SetSize(40, 40)
	build.Class:SetPoint("TOPLEFT", build, "TOPLEFT", CP, -(HEAD_H + 12))
	build.Spec = line(build, "title", "text", HEAD_H + 14, CP + 52)
	build.Picks = line(build, "small", "textDim", HEAD_H + 36, CP + 52)
	build.Label = line(build, "small", "textMuted", HEAD_H + 64)
	build.Label:SetText(L["Next in your plan"])
	build.Icons = {}
	for i = 1, 6 do
		local b = CreateFrame("Button", nil, build)
		b:SetSize(ICON, ICON)
		b:SetPoint("TOPLEFT", build, "TOPLEFT", CP + (i - 1) * (ICON + 6), -(HEAD_H + 82))
		Theme.Skin(b, "button")
		b.Icon = b:CreateTexture(nil, "ARTWORK")
		b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1)
		b.Icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1)
		b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		b:SetScript("OnEnter", spellTip)
		b:SetScript("OnLeave", hideTip)
		build.Icons[i] = b
	end
	build.Next = line(build, "label", "text", HEAD_H + 124)
	build.When = line(build, "small", "textDim", HEAD_H + 142)
	-- No plan picked yet: one button per plan for the class, to follow it.
	build.Ask = line(build, "small", "textDim", HEAD_H + 36, CP + 52)
	build.Ask:SetText(L["Polestar then names each point to spend."])
	build.Choices = {}
	for i = 1, 3 do
		local b = W.Button(build, "", function(self)
			local T = ns.Talents
			if T and T.Choose and self.psKey then T.Choose(self.psKey) end
		end, { height = 26 })
		b:SetPoint("BOTTOMLEFT", build, "BOTTOMLEFT", CP, CP + (3 - i) * 30)
		b:SetPoint("BOTTOMRIGHT", build, "BOTTOMRIGHT", -CP, CP + (3 - i) * 30)
		build.Choices[i] = b
	end

	-- Dungeons for your level.
	local dun = card("dungeons", "icon-dungeon", L["Dungeons for your level"], function()
		local DS = UI.DungeonsSection
		if DS then DS.Show(); DS.SetBand("level") end
	end)
	dun.Art = ZoneArt.Create(dun, 100, 72, "panel")
	dun.Art:SetPoint("TOPLEFT", dun, "TOPLEFT", 1, -(HEAD_H + 1))
	dun.Art:SetPoint("TOPRIGHT", dun, "TOPRIGHT", -1, -(HEAD_H + 1))
	dun.Art.Rule:Hide()
	dun.Name = line(dun, "title", "text", HEAD_H + 84)
	dun.Facts = line(dun, "small", "textDim", HEAD_H + 106)
	dun.Quests = line(dun, "small", "textDim", HEAD_H + 124)
	dun.Count = line(dun, "small", "textMuted", HEAD_H + 142)

	-- Up next.
	local nxt = card("next", "icon-goto", L["Up next"], function(c) showGuide(c.psGuide and c.psGuide.id) end)
	nxt.Art = ZoneArt.Create(nxt, 56, 56, "panel")
	nxt.Art:SetPoint("TOPLEFT", nxt, "TOPLEFT", CP, -(HEAD_H + 12))
	nxt.Art.Rule:Hide()
	nxt.Name = line(nxt, "title", "text", HEAD_H + 18, CP + 68)
	nxt.Levels = line(nxt, "small", "textDim", HEAD_H + 40, CP + 68)
	nxt.Quests = line(nxt, "small", "textDim", HEAD_H + 80)
	nxt.Go = footButton(nxt, L["Preview route"], function() showGuide(nxt.psGuide and nxt.psGuide.id) end)

	-- Class training.
	local tr = card("trainer", "icon-train", L["Class training"], nil)
	tr.Status = line(tr, "body", "text", HEAD_H + 14)
	tr.Place = line(tr, "small", "textDim", HEAD_H + 36)
	-- The spells waiting, as their icons (the game's tooltip on hover), and
	-- their names under them.
	tr.Icons = {}
	for i = 1, 8 do
		local b = CreateFrame("Button", nil, tr)
		b:SetSize(ICON, ICON)
		b:SetPoint("TOPLEFT", tr, "TOPLEFT", CP + (i - 1) * (ICON + 6), -(HEAD_H + 58))
		Theme.Skin(b, "button")
		b.Icon = b:CreateTexture(nil, "ARTWORK")
		b.Icon:SetPoint("TOPLEFT", b, "TOPLEFT", 1, -1)
		b.Icon:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1)
		b.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
		b:SetScript("OnEnter", spellTip)
		b:SetScript("OnLeave", hideTip)
		tr.Icons[i] = b
	end
	tr.Spells = line(tr, "small", "textDim", HEAD_H + 96)
	tr.Last = line(tr, "small", "textMuted", HEAD_H + 114)
	tr.Go = footButton(tr, L["Guide me"], function()
		local t, nav = tr.psTrainer, ns.Nav
		if t and t.map and t.x and nav and nav.SetTarget then
			nav.SetTarget(t.map, t.x, t.y, t.npcName or L["Class trainer"], t.f, "trainer", t.z)
		end
	end)
	tr.psOpen = function() tr.Go:Click() end

	-- The next quest reward that is an upgrade.
	local gear = card("gear", "icon-use", L["Quest reward upgrade"], nil)
	gear.Item = CreateFrame("Button", nil, gear)
	gear.Item:SetSize(40, 40)
	gear.Item:SetPoint("TOPLEFT", gear, "TOPLEFT", CP, -(HEAD_H + 12))
	Theme.Skin(gear.Item, "button")
	gear.Item.Icon = gear.Item:CreateTexture(nil, "ARTWORK")
	gear.Item.Icon:SetPoint("TOPLEFT", gear.Item, "TOPLEFT", 1, -1)
	gear.Item.Icon:SetPoint("BOTTOMRIGHT", gear.Item, "BOTTOMRIGHT", -1, 1)
	gear.Item.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	gear.Item:SetScript("OnEnter", itemTip)
	gear.Item:SetScript("OnLeave", hideTip)
	gear.Name = line(gear, "body", "item", HEAD_H + 14, CP + 52)
	gear.Gain = line(gear, "small", "success", HEAD_H + 34, CP + 52)
	gear.From = line(gear, "small", "textDim", HEAD_H + 64)
	gear.When = line(gear, "small", "textMuted", HEAD_H + 82)
	gear.Go = footButton(gear, L["View in Lookup"], function()
		if gear.psItemId and UI.ShowLookup then UI.ShowLookup({ kind = "item", id = gear.psItemId }) end
	end)
	gear.psOpen = function() gear.Go:Click() end

	-- Rares in this zone.
	local rares = card("rares", "icon-kill", L["Rares nearby"], function()
		if ns.Rares and ns.Rares.Show then ns.Rares.Show() end
	end)
	rares.Name = line(rares, "body", "rare", HEAD_H + 14)
	rares.Facts = line(rares, "small", "textDim", HEAD_H + 34)
	rares.Count = line(rares, "small", "textMuted", HEAD_H + 54)
	rares.Go = footButton(rares, L["Open Rares"], function()
		local R = ns.Rares
		if R and R.Show then R.Show(rares.psRare and "rare", rares.psRare) end
	end)
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
end

-- The character's way to the next level: share of the level done, about how
-- many of the guide's quests are left to it (its average quest XP, from
-- Levels.ForGuide), and rested XP. -> text, fraction | nil at the level cap.
local function levelText(xp)
	local info = playerInfo()
	local cur, need = tonumber(info.xp) or 0, tonumber(info.xpMax) or 0
	if need <= 0 or not info.level then return nil end
	local frac = min(1, cur / need)
	local parts = { format(L["%d%% to %d"], floor(frac * 100), info.level + 1) }
	if xp and (xp.quests or 0) > 0 and (xp.questXP or 0) > 0 then
		local n = math.ceil((need - cur) / (xp.questXP / xp.quests))
		parts[#parts + 1] = n == 1 and L["about 1 quest"] or format(L["about %d quests"], n)
	end
	local rested = GetXPExhaustion and tonumber(GetXPExhaustion())
	if rested and rested > 0 then parts[#parts + 1] = format(L["%s rested"], thousands(rested)) end
	return table.concat(parts, DOT), frac
end

local function fillHero(c, g, t, index, byId)
	c.psGuide, c.psTab, c.psIndex = g, t, index
	if not g then
		c.Name:SetText(L["No guide yet"])
		c.Step:SetText(L["Pick a guide to start your journey."])
		c.Next:SetText("")
		c.Bar:Hide()
		for _, s in ipairs({ c.Estimate, c.Left, c.Then, c.Level }) do setStat(s, nil) end
		ZoneArt.Paint(c.Art, nil, nil, nil, 1)
		W.SetButtonText(c.Go, L["Choose a guide"])
		c.Go:SetScript("OnClick", function() showGuide(nil) end)
		return true
	end
	c.Go:SetScript("OnClick", function() load(c.psGuide, c.psTab, c.psIndex) end)
	local range = rangeText(g.minLevel, g.maxLevel)
	c.Name:SetText((g.title or g.id) .. (range ~= "" and ("  |c" .. Theme.Hex("textMuted") .. range .. "|r") or ""))
	local total = t and (t.total or t.stepCount) or 0
	local frac = (t and total > 0) and (t.done or 0) / total or 0
	if t and t.complete then
		c.Step:SetText(L["Finished"])
	elseif t and t.stepIndex then
		c.Step:SetText(format(L["Step %d of %d"], t.stepIndex, t.stepCount or 0) .. DOT .. format(L["%d%% complete"], floor(frac * 100 + 0.5)))
	else
		c.Step:SetText(L["Not started"])
	end
	c.Bar:Show()
	W.SetProgress(c.Bar, frac, c:GetWidth() - (CP + 116 + 20) - (STATS_W + 24))
	local nextTitle = t and nextStepTitle(g, t, index)
	c.Next:SetText(nextTitle and ("|c" .. Theme.Hex("accent") .. L["Next:"] .. "|r  " .. nextTitle) or "")
	W.SetButtonText(c.Go, t and L["Continue guide"] or L["Load guide"])
	if c.psPainted ~= g.id then
		c.psArt = ZoneArt.Paint(c.Art, g.zone, nil, nil, 1)
		c.psPainted = g.id
	end
	-- The stats: what is left of the guide for this character.
	local xp = guideXP(g.id)
	if xp and not xp.maxed and (xp.xp or 0) > 0 then
		setStat(c.Estimate, format(L["+%.1f levels (%s XP)"], xp.levels or 0, thousands(xp.xp)), "accent")
	else
		setStat(c.Estimate, nil)
	end
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
	local lv, frac = levelText(xp)
	setStat(c.Level, lv)
	if lv then W.SetProgress(c.Level.Bar, frac, STATS_W - 28 - CP) end
	placeStats(c, { c.Estimate, c.Left, c.Then, c.Level })
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
	local n = min(#data.builds, #c.Choices)
	-- The buttons stand at the card's foot, the first of n at the top.
	for i, b in ipairs(c.Choices) do
		local plan = data.builds[i - (#c.Choices - n)]
		if plan then
			b.psKey = plan.key
			W.SetButtonText(b, plan.specName or plan.key)
			b.psTip = plan.split and format(L["%s plan (%s)"], plan.specName or plan.key, plan.split) or nil
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
	local room = floor((c:GetWidth() - CP * 2 + 6) / (ICON + 6))
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
		c.Next:SetText("|c" .. Theme.Hex("accent") .. L["Next talent:"] .. "|r  " .. T.PickText(cur.data, s.next, cur.valid))
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

local function fillDungeons(c)
	local DS = UI.DungeonsSection
	local list = DS and DS.ForYou and DS.ForYou() or {}
	local d = list[1]
	if not d then return false end
	c.Name:SetText(d.name)
	local facts = {}
	local lv = UI.LevelRange(d.minLevel, d.maxLevel)
	if lv then facts[#facts + 1] = lv end
	if d.zoneName then facts[#facts + 1] = d.zoneName end
	c.Facts:SetText(table.concat(facts, DOT))
	local q = d.quests or {}
	local nq = q[SIDE_LETTER[UI.PlayerFaction() or ""] or ""] or max(q.A or 0, q.H or 0)
	c.Quests:SetText(nq == 1 and L["1 quest"] or format(L["%d quests"], nq))
	c.Count:SetText(#list == 1 and L["1 dungeon for your level"] or format(L["%d dungeons for your level"], #list))
	if c.psPainted ~= d.key then
		local e = d.entrance
		c.Art.psW = c:GetWidth() - 2
		c.psArt = ZoneArt.Paint(c.Art, e and e.map or d.zone, e and e.x, e and e.y, 2)
		c.psPainted = d.key
	end
	return true
end

local function fillNext(c, g, byId)
	if not g then return false end
	local n, choice = nextGuide(g, byId)
	if not n then return false end
	c.psGuide = n
	c.Name:SetText(choice and format(L["%s or another route"], n.title or n.id) or (n.title or n.id))
	local lv = UI.LevelRange(n.minLevel, n.maxLevel)
	c.Levels:SetText(lv and format(L["Levels %s"], lv) or "")
	local q = guideQuests(n)
	c.Quests:SetText(q == 0 and "" or q == 1 and L["1 quest planned"] or format(L["%d quests planned"], q))
	if c.psPainted ~= n.id then
		c.psArt = ZoneArt.Paint(c.Art, n.zone, nil, nil, 3)
		c.psPainted = n.id
	end
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
	local room = min(#c.Icons, floor((c:GetWidth() - CP * 2 + 6) / (ICON + 6)))
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
-- Header and footer
---------------------------------------------------------------------------

local CREST = { Alliance = "Interface\\Timer\\Alliance-Logo", Horde = "Interface\\Timer\\Horde-Logo" }

local function placeHeader(on)
	if not hub then return end
	hub.Title:SetPoint("TOPLEFT", hub.Header, "TOPLEFT", SH.pad + (on and 52 or 0), -32)
	if crest then crest:SetShown(on) end
end

local function renderHeader()
	local info = playerInfo()
	local parts = {}
	if info.level then parts[#parts + 1] = format(L["Level %d"], info.level) end
	local who = {}
	if info.faction and info.faction ~= "Neutral" then who[#who + 1] = ns.FactionName(info.faction) end
	if info.class then who[#who + 1] = UI.ClassName(info.class) end
	if #who > 0 then parts[#parts + 1] = table.concat(who, " ") end
	local here = ns.PlayerPoint and ns.PlayerPoint()
	local zone = here and UI.MapName(here.map)
	if zone then parts[#parts + 1] = zone end
	W.ShellTitle(hub, L["Your journey"], table.concat(parts, DOT))
	if not crest then
		crest = hub.Header:CreateTexture(nil, "ARTWORK")
		crest:SetSize(44, 44)
		crest:SetPoint("TOPLEFT", hub.Header, "TOPLEFT", SH.pad - 4, -26)
	end
	local file = CREST[info.faction or ""]
	if file then
		crest:SetTexture(file)
		crest:SetTexCoord(0, 1, 0, 1)
		crest:SetVertexColor(1, 1, 1, 1)
	else
		crest:SetTexture(Theme.Media("emblem"))
		W.Color(crest, "accent")
	end
	placeHeader(true)
end

-- The footer bar: the brand on the left, version and Discord on the right.
-- The wordmark's ink starts 2px into its box and fills rows 7-24 of its 32
-- (as in the sidebar's lockup).
local function buildFooter()
	foot = CreateFrame("Frame", nil, root)
	foot:SetHeight(SH.footer)
	foot:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT", 0, 0)
	foot:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
	W.Fill(foot, "footer")
	local rule = W.Divider(foot)
	rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	foot.Wordmark = W.Tex(foot, "ARTWORK", "wordmark-small", "text")
	foot.Wordmark:SetSize(256, 32)
	foot.Wordmark:SetPoint("TOPLEFT", foot, "TOPLEFT", SH.pad - 2, -3)
	foot.Tagline = W.Text(foot, "small", "textDim")
	foot.Tagline:SetText(L["A community project"])
	foot.Tagline:SetPoint("TOPLEFT", foot, "TOPLEFT", SH.pad, -32)
	foot.Discord = W.IconButton(foot, "discord", 28, nil, function() if UI.ShowDiscord then UI.ShowDiscord() end end, 20)
	W.Color(foot.Discord.Icon, "discord")
	foot.Discord:SetScript("OnEnter", function(self)
		W.Tooltip(self, "ANCHOR_LEFT", L["Polestar on Discord"], { L["Report problems, ask for help and hear about new guides first."] })
	end)
	foot.Discord:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	foot.Discord:SetPoint("RIGHT", foot, "RIGHT", -(SH.pad - 6), 0)
	foot.Stage = W.Chip(foot)
	foot.Stage:SetPoint("RIGHT", foot.Discord, "LEFT", -12, 0)
	foot.Version = W.Text(foot, "small", "textMuted")
	foot.Version:SetJustifyH("RIGHT")
end

local function renderFooter()
	foot.Version:SetText(L["Version"] .. " " .. tostring(ns.version or "dev"))
	local w = W.SetStageChip(foot.Stage)
	foot.Version:ClearAllPoints()
	if w > 0 then
		foot.Version:SetPoint("RIGHT", foot.Stage, "LEFT", -8, 0)
	else
		foot.Version:SetPoint("RIGHT", foot.Discord, "LEFT", -12, 0)
	end
end

---------------------------------------------------------------------------
-- The section
---------------------------------------------------------------------------

local ORDER = { "build", "dungeons", "next", "trainer", "gear", "rares" }

-- The page's width: the window less the rail (anchored frames have no width
-- before the first layout).
local function pageWidth()
	return hub:GetWidth() - (hub.psRail or SH.rail) - 2
end

function HV.Build(parent, shell)
	if root then return root end
	hub = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)
	buildFooter()
	page = CreateFrame("Frame", nil, root)
	page:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
	page:SetPoint("BOTTOMRIGHT", foot, "TOPRIGHT", 0, 0)
	page.Scroll = W.Scroll(page)
	page.Scroll:SetPoint("TOPLEFT", page, "TOPLEFT", 0, 0)
	page.Scroll:SetPoint("BOTTOMRIGHT", page, "BOTTOMRIGHT", 0, 0)
	buildCards()
	root:SetScript("OnShow", function() placeHeader(true) end)
	root:SetScript("OnHide", function() placeHeader(false) end)
	return root
end

function HV.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	local byId = headers()
	local tabs, active = tabsInfo()
	local g, t, index = featuredGuide(byId, tabs, active)
	renderHeader()
	renderFooter()
	local width = pageWidth()
	page.Scroll.Child:SetWidth(width)
	local full = width - EDGE * 2
	local each = floor((full - GAP * (PER - 1)) / PER)
	local y = 16
	local hero = cards.hero
	hero:SetSize(full, HERO_H)
	hero:ClearAllPoints()
	hero:SetPoint("TOPLEFT", page.Scroll.Child, "TOPLEFT", EDGE, -y)
	fillHero(hero, g, t, index, byId)
	shown.hero = true
	y = y + HERO_H + GAP
	local FILL = {
		build = fillBuild, dungeons = fillDungeons, next = function(c) return fillNext(c, g, byId) end,
		trainer = fillTrainer, gear = fillGear, rares = fillRares,
	}
	-- Which cards have something to show, then PER to a line in order; a
	-- last line with fewer widens them to the page's width (filled again at
	-- that width: icons and art fit to it).
	local list = {}
	for _, key in ipairs(ORDER) do
		local c = cards[key]
		c:SetSize(each, CARD_H)
		local ok, has = pcall(FILL[key], c)
		if ok and has then list[#list + 1] = key else c:Hide() end
	end
	local lastLine = #list - (#list - 1) % PER
	for i, key in ipairs(list) do
		local c = cards[key]
		local col = (i - 1) % PER
		local w = each
		if i >= lastLine then
			local k = #list - lastLine + 1
			w = floor((full - GAP * (k - 1)) / k)
		end
		if w ~= each then
			c:SetSize(w, CARD_H)
			c.psPainted = nil
			pcall(FILL[key], c)
		end
		c:ClearAllPoints()
		c:SetPoint("TOPLEFT", page.Scroll.Child, "TOPLEFT", EDGE + col * (w + GAP), -y)
		c:Show()
		shown[key] = true
		if col == PER - 1 or i == #list then y = y + CARD_H + GAP end
	end
	W.SetScrollContent(page.Scroll, y + 4)
	shown.guide = g and g.id or nil
end

function HV.Shown() return shown end
function HV.Cards() return cards end
function HV.Footer() return foot end

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
ns.RegisterEvent("PLAYER_LEVEL_UP", refresh)
ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", refresh)
Theme.OnChanged(function() if root and root:IsVisible() then HV.Render() end end)

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Home", label = L["Home"], icon = "home", order = 5,
		home = true, bare = true,
		build = HV.Build, render = HV.Render,
	})
end
