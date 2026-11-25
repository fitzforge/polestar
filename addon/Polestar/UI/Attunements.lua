-- The Attunements section of the hub (#3695, #3877): every attunement and
-- key of the character's faction, raids and dungeons, as cards laid out like
-- the Dungeons page's, two to a row: the instance's own loading-screen
-- picture (Dungeons.Art, read from the client's files at runtime, never
-- shipped; the zone's painting where it has none) with the key glyph and the
-- name over it, what it opens and its facts, a progress bar of the steps done
-- (Dungeons.AttunementState: the steps this character takes, alternatives it
-- skips left out), the next step in words, and "Guide me" (the Lookup attune
-- guide, Dungeons.Attune, in a new tab, as the dungeon page's Attunement tab
-- opens it). A raid Forever has not opened yet (the attunement's `open =
-- false`, data/codex/attunements.json) says "Not open on Forever yet"
-- instead of its bar. Order: the raids first (open ones by level, then the
-- ones not open yet), then the dungeons' keys the same way, then the done
-- ones, ticked and dimmed. The other faction's are left out. A click on a
-- card opens the dungeon page's Attunement tab, where every step is listed
-- with its arrow pin. The rail's icon and the cards' glyph are a key.
--
-- Data: Polestar.Dungeons over the Codex pack, loaded on first show as the
-- Dungeons section loads it; only dungeons whose summary counts an
-- attunement for this side are decoded, one page at a time.
--
--   UI.Attunements.List() -> { entry, ... } | nil, reason   -- entry = { key, dungeon, raid, a, st, did, total, open, done }
--   UI.Attunements.Shown() -> what the cards show (the tests read it)
--   UI.Attunements.Show()                                    -- the hub on this section

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local SH = W.SHELL
local max, min, floor, ipairs, pairs, format, concat, sort, tostring = math.max, math.min, math.floor, ipairs, pairs, string.format, table.concat, table.sort, tostring

local AT = {}
UI.Attunements = AT

local KEY = "Attunements"
local PAD = SH.pad
local CARD_X = PAD - 12
local CARD_GAP = 16
local ART_H = 96 -- the picture band, as the Dungeons page's cards are painted
local BAR_W = 200
local DONE_ALPHA = 0.6
local DOT = "  \194\183  "
local SIDE = { Alliance = "A", Horde = "H" }

local root, hub, scroll, body
local cards = {}
local shown = {}

local function D() return ns.Dungeons end

local function mainWidth()
	local w = hub and (hub:GetWidth() - (hub.psRail or 0) - (hub.psSidebar or SH.sidebar) - 2) or 0
	if w <= 0 then w = 878 end
	return w
end

---------------------------------------------------------------------------
-- The list
---------------------------------------------------------------------------

-- The client's word for a standing; a faction by its id in the client's language.
local function standingName(n) return ns.StandingName(n) or ns.StandingName(4) end
local function factionName(id, english)
	local N = ns.Names
	return (N and N.Faction and N.Faction(id)) or english or L["Not known"]
end

-- A step and its state -> the next step in words.
local function stepWords(s, state)
	if s.kind == "quest" then
		local title = s.title or ""
		if state == "ready" then return format(L["Hand in %s"], title) end
		if state == "log" then return format(L["Finish %s"], title) end
		if state == "level" then return format(L["%s, from level %d"], title, s.minLevel or 0) end
		if state == "rep" and s.rep then
			return format(L["Reach %s with %s"], standingName(s.rep.standing), factionName(s.rep.faction, s.rep.name))
		end
		if s.start and s.start.name then return format(L["Pick up %s from %s"], title, s.start.name) end
		return format(L["Pick up %s"], title)
	elseif s.kind == "drop" then
		return format(L["%s from %s"], s.item and s.item.name or L["Item"], s.npc and s.npc.name or L["Not known"])
	elseif s.kind == "object" then
		if not (s.object and s.object.name) then return s.item and s.item.name or L["Item"] end
		local N = ns.Names
		return format(L["%s from %s"], s.item and s.item.name or L["Item"], N and N.Object and N.Object(s.object.id) or s.object.name)
	elseif s.kind == "rep" then
		return format(L["Reach %s with %s"], standingName(s.standing), factionName(s.faction, s.name))
	elseif s.kind == "gift" then
		return format(L["%s gives you %s"], s.npc and s.npc.name or L["Not known"], s.item and s.item.name or L["Item"])
	elseif s.kind == "use" then
		return format(L["Use %s beside %s"], s.from and s.from.name or L["Item"], s.at and s.at.name or L["Not known"])
	end
	return ""
end
AT.StepWords = stepWords

-- The order: the raids, then the dungeons, each still to do by level and
-- then not open yet; the done ones last; by name within.
local function rank(e)
	if e.done then return 5 end
	return (e.raid and 1 or 3) + (e.open and 0 or 1)
end

function AT.List()
	local Dg = D()
	if not Dg then return nil, "missing" end
	local ok, reason = Dg.Load()
	if not ok then return nil, reason end
	local side = SIDE[UI.PlayerFaction() or ""]
	local out = {}
	for _, d in ipairs(Dg.List()) do
		local n = d.attune and (side and d.attune[side] or max(d.attune.A or 0, d.attune.H or 0)) or 0
		if n > 0 then
			for _, a in ipairs(Dg.Attunements(d.key, side)) do
				local st = Dg.AttunementState(a)
				local total, did = 0, 0
				for _, e in ipairs(st.steps) do
					if e.state ~= "na" and e.state ~= "skip" then
						total = total + 1
						if e.state == "done" then did = did + 1 end
					end
				end
				out[#out + 1] = { key = d.key, dungeon = d.name, raid = d.kind == "raid", a = a, st = st, did = did, total = total,
					open = a.open ~= false, done = st.done and true or false, level = a.level or d.minLevel or 0 }
			end
		end
	end
	sort(out, function(x, y)
		local rx, ry = rank(x), rank(y)
		if rx ~= ry then return rx < ry end
		if x.level ~= y.level then return x.level < y.level end
		local dx, dy = tostring(x.dungeon or x.a.name), tostring(y.dungeon or y.a.name)
		if dx ~= dy then return dx < dy end
		return tostring(x.a.name) < tostring(y.a.name)
	end)
	return out
end

---------------------------------------------------------------------------
-- The cards
---------------------------------------------------------------------------

local KIND = { attunement = L["Attunement"], key = L["Key"], item = L["Item"] }

-- A name over the picture: the shade's shadow under it, as the Dungeons page's.
local function shadowed(fs)
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
	c = CreateFrame("Button", nil, body)
	Theme.Skin(c, "button")
	W.Hover(c)
	local x = PAD - CARD_X
	c.Art = UI.ZoneArt.Create(c, 100, ART_H, "panel")
	c.Art:SetPoint("TOPLEFT", c, "TOPLEFT", 1, -1)
	c.Art.psZoom = 1.6
	-- The key and the name on the picture's foot; the state at its top right.
	c.Glyph = W.Tex(c.Art.Over, "OVERLAY", "key", "accent")
	c.Glyph:SetSize(16, 16)
	c.Glyph:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", x - 1, 12)
	c.Title = shadowed(W.Text(c.Art.Over, "title", "text"))
	c.Title:SetPoint("BOTTOMLEFT", c.Art, "BOTTOMLEFT", x + 22, 10)
	c.Title:SetWordWrap(false)
	c.State = W.Chip(c.Art.Over)
	c.State:SetPoint("TOPRIGHT", c.Art, "TOPRIGHT", -10, -10)
	c.Meta = W.Text(c, "small", "textMuted")
	c.Meta:SetWordWrap(true)
	c.Meta:SetSpacing(2)
	c.Meta:SetJustifyH("LEFT")
	c.Bar = W.ProgressLine(c, 4)
	c.Count = W.Text(c, "small", "textDim")
	c.Count:SetPoint("LEFT", c.Bar, "RIGHT", 10, 0)
	c.Closed = W.Text(c, "label", "warning")
	c.Next = W.Text(c, "label", "text")
	c.Next:SetWordWrap(false)
	c.Next:SetJustifyH("LEFT")
	c.Guide = W.Button(c, L["Guide me"], function(self)
		local DS = UI.DungeonsSection
		if DS and DS.Attune then DS.Attune(self.psId, self.psKey) end
	end, { height = 28, icon = "icon-goto" })
	c:SetScript("OnClick", function(self)
		local DS = UI.DungeonsSection
		if DS and DS.Show then DS.Show(self.psKey, "attune") end
	end)
	c:SetScript("OnEnter", W.SimpleTip)
	c:SetScript("OnLeave", W.HideTip)
	c.psTip = L["Every step, on the dungeon's page"]
	cards[i] = c
	return c
end

-- The instance's own picture: its loading screen (Dungeons.Art), else its
-- zone framed on the entrance, else the night band. -> "picture" | "zone" | nil
local function paintArt(art, key, index)
	local Dg, ZA = D(), UI.ZoneArt
	local pic = Dg.Art and Dg.Art(key)
	if pic and ZA.Picture and ZA.Picture(art, pic) then return "picture" end
	local d = Dg.Get and Dg.Get(key)
	local e = d and d.entrance
	if d and ZA.Paint(art, e and e.map or d.zone, e and e.x, e and e.y, index) then return "zone" end
	return nil
end

local function paint(c, e, width, index)
	local a, st = e.a, e.st
	local x = PAD - CARD_X
	local inner = width - x * 2
	c.psKey, c.psId = e.key, a.id
	c:SetWidth(width)
	if c.psArtFor ~= e.key or c.psArtW ~= width then
		c.Art:SetSize(width - 2, ART_H)
		c.Art.psW, c.Art.psH = width - 2, ART_H
		c.psArtKind = paintArt(c.Art, e.key, index)
		c.psArtFor, c.psArtW = e.key, width
	end
	c.Title:SetText(e.dungeon or a.name or "")
	c.Title:SetWidth(inner - 22)
	-- The key, in the colour of where it stands: done, not open yet, to do.
	c.Glyph:SetTexture(Theme.Media(e.done and "check" or "key"))
	W.Color(c.Glyph, e.done and "success" or (not e.open and "textMuted") or "accent")
	if e.done then
		W.SetChip(c.State, L["Done"], "success")
	elseif st.goalDone and a.item then
		W.SetChip(c.State, L["Not in your bags"], "warning")
	else
		c.State:Hide()
	end
	local can = not e.done and st.left > 0
	c.Guide:SetShown(can)
	c.Guide:ClearAllPoints()
	c.Guide:SetPoint("TOPRIGHT", c, "TOPRIGHT", -12, -(ART_H + 12))
	local facts = { a.name or "", KIND[a.kind] or KIND.attunement }
	facts[#facts + 1] = a.need == "one" and L["One in the group is enough"] or L["Everyone entering needs it"]
	if a.level then facts[#facts + 1] = format(L["From level %d"], a.level) end
	c.Meta:SetText(concat(facts, DOT))
	c.Meta:SetWidth(inner - (can and (c.Guide:GetWidth() + 12) or 0))
	c.Meta:ClearAllPoints()
	c.Meta:SetPoint("TOPLEFT", c, "TOPLEFT", x, -(ART_H + 14))
	local y = ART_H + 14 + max(28, floor(c.Meta:GetStringHeight() + 0.5)) + 14
	-- Progress, or why there is none yet.
	local barW = min(BAR_W, inner - 90)
	c.Bar:SetWidth(barW)
	c.Bar:ClearAllPoints()
	c.Bar:SetPoint("LEFT", c, "TOPLEFT", x, -y)
	c.Closed:ClearAllPoints()
	c.Closed:SetPoint("LEFT", c, "TOPLEFT", x, -y)
	c.Closed:SetShown(not e.open and not e.done)
	c.Bar:SetShown(e.open or e.done)
	-- Done: the bar full, the chip says it (its steps left over read "skip" once it is done).
	c.Count:SetShown(e.open and not e.done)
	if not e.open and not e.done then
		c.Closed:SetText(L["Not open on Forever yet"])
	elseif e.done then
		W.SetProgress(c.Bar, 1, barW)
	else
		W.SetProgress(c.Bar, e.total > 0 and e.did / e.total or 0, barW)
		c.Count:SetText(format(L["%d of %d steps"], e.did, e.total))
	end
	-- The next step, while one is left.
	local nextStep = not e.done and st.next and st.steps[st.next]
	if nextStep then
		y = y + 24
		c.Next:SetText(format(L["Next: %s"], stepWords(nextStep.step, nextStep.state)))
		c.Next:SetWidth(inner)
		c.Next:ClearAllPoints()
		c.Next:SetPoint("LEFT", c, "TOPLEFT", x, -y)
		c.Next:Show()
	else
		c.Next:Hide()
	end
	c.Guide.psId, c.Guide.psKey = a.id, e.key
	c.Guide.psTip = L["Guide me"]
	c.Guide.psTipLines = { st.left == 1 and L["A guide through the 1 step left, from where you stand."]
		or format(L["A guide through the %d steps left, from where you stand."], st.left), L["It opens in a new tab."] }
	c.psH = y + 18
	-- Done ones sit at the end, dimmed.
	c:SetAlpha(e.done and DONE_ALPHA or 1)
	c:Show()
	return { key = e.key, id = a.id, name = a.name, opens = e.dungeon, done = e.done, open = e.open,
		progress = e.done or (e.open and { e.did, e.total }) or false, closed = c.Closed:IsShown() and c.Closed:GetText() or false,
		nextStep = nextStep and c.Next:GetText() or false, guide = can, chip = c.State:IsShown() and c.State.Text:GetText() or false,
		raid = e.raid, art = c.psArtKind or false, glyph = e.done and "check" or "key" }
end

---------------------------------------------------------------------------
-- The section
---------------------------------------------------------------------------

function AT.Build(parent, shell)
	if root then return root end
	hub = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)
	scroll = W.Scroll(root)
	scroll:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
	scroll:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", -4, 4)
	body = scroll.Child
	body:SetWidth(mainWidth())
	root.EmptyTitle = W.Text(body, "display", "text")
	root.EmptyTitle:SetPoint("TOPLEFT", body, "TOPLEFT", PAD, -28)
	root.EmptyNote = W.Text(body, "note", "textDim")
	root.EmptyNote:SetWordWrap(true)
	root.EmptyNote:SetJustifyH("LEFT")
	root.EmptyNote:SetPoint("TOPLEFT", root.EmptyTitle, "BOTTOMLEFT", 0, -10)
	return root
end

function AT.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	W.ShellTitle(hub, L["Attunements"], L["What lets you into each raid and opens a dungeon's doors, and how far you are"])
	local MW = mainWidth()
	body:SetWidth(MW)
	local list, reason = AT.List()
	-- Two cards to a row, as the Dungeons page lays its own out; each row as
	-- tall as its taller card.
	local width = floor((MW - CARD_X * 2 - CARD_GAP) / 2)
	local y, n = 16, 0
	root.EmptyTitle:Hide()
	root.EmptyNote:Hide()
	if not list or #list == 0 then
		root.EmptyTitle:SetText(reason == "off" and L["Dungeons are off"] or (list and L["Nothing to unlock"]) or L["Dungeons need the Codex"])
		root.EmptyNote:SetText(reason == "off" and L["The Dungeons section is turned off. Turn it on under Settings > Discovery > Lookup."]
			or (list and L["No attunement or key is known for your faction."]) or tostring(reason))
		root.EmptyNote:SetWidth(MW - PAD * 2)
		root.EmptyTitle:Show()
		root.EmptyNote:Show()
		shown.empty = root.EmptyTitle:GetText()
		y = 28 + 24 + 10 + root.EmptyNote:GetStringHeight() + 24
	else
		local rowH = 0
		for i, e in ipairs(list) do
			local c = card(i)
			local col = (i - 1) % 2
			if col == 0 and i > 1 then
				y = y + rowH + CARD_GAP
				rowH = 0
			end
			c:ClearAllPoints()
			c:SetPoint("TOPLEFT", body, "TOPLEFT", CARD_X + col * (width + CARD_GAP), -y)
			shown[i] = paint(c, e, width, i)
			rowH = max(rowH, c.psH)
			-- Both cards of a row as tall as the taller.
			if col == 1 or i == #list then
				for k = i - col, i do cards[k]:SetHeight(rowH) end
			end
			n = i
		end
		y = y + rowH + CARD_GAP
	end
	for i = n + 1, #cards do cards[i]:Hide() end
	W.SetScrollContent(scroll, y + 16)
end

function AT.Shown() return shown end
AT.cards = cards

function AT.Show()
	local P = UI.Picker
	local win = PolestarPicker
	local was = win and win:IsShown()
	if P and P.ShowSection then P.ShowSection(KEY) end
	if not was and UI.ShowPicker then UI.ShowPicker() end
	if scroll then W.ScrollTo(scroll, 0) end
end

-- What changes a card: quests, bags (a key), standings, levels, the Codex, the language.
local function changed()
	if root and root:IsVisible() then AT.Render() end
end
for _, ev in ipairs({ "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "PLAYER_LEVEL_UP", "BAG_UPDATE_DELAYED", "UPDATE_FACTION" }) do
	ns.RegisterEvent(ev, changed)
end
ns.On("CODEX_LOADED", changed)
ns.On("NAMES_LOADED", changed)
Theme.OnChanged(changed)

if UI.RegisterSection then
	UI.RegisterSection({
		key = KEY, label = L["Attunements"], icon = "key", order = 31,
		build = AT.Build,
		render = AT.Render,
	})
end
