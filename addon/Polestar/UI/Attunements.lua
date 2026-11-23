-- The Attunements section of the hub (#3695): every attunement and key of
-- the character's faction in one list, raids and dungeons, each as a card:
-- its name, what it opens, its facts, a progress bar of the steps done
-- (Dungeons.AttunementState: the steps this character takes, alternatives it
-- skips left out), the next step in words, and "Guide me" (the Lookup attune
-- guide, Dungeons.Attune, in a new tab, as the dungeon page's Attunement tab
-- opens it). A raid Forever has not opened yet (the attunement's `open =
-- false`, data/codex/attunements.json) says "Not open on Forever yet"
-- instead of its bar. Order: the ones still to do by level, then the raids
-- not open yet, then the done ones, ticked. The other faction's are left
-- out. A click on a card opens the dungeon page's Attunement tab, where
-- every step is listed with its arrow pin.
--
-- Data: Polestar.Dungeons over the Codex pack, loaded on first show as the
-- Dungeons section loads it; only dungeons whose summary counts an
-- attunement for this side are decoded, one page at a time.
--
--   UI.Attunements.List() -> { entry, ... } | nil, reason   -- entry = { key, dungeon, a, st, did, total, open, done }
--   UI.Attunements.Shown() -> what the cards show (the tests read it)
--   UI.Attunements.Show()                                    -- the hub on this section

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local SH = W.SHELL
local max, ipairs, pairs, format, concat, sort, tostring = math.max, ipairs, pairs, string.format, table.concat, table.sort, tostring

local AT = {}
UI.Attunements = AT

local KEY = "Attunements"
local PAD = SH.pad
local CARD_X = PAD - 12
local CARD_GAP = 12
local BAR_W = 220
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
		return format(L["%s from %s"], s.item and s.item.name or L["Item"], s.object.name)
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

-- The order: still to do by level, then not open yet, then done; by name within.
local function rank(e)
	if e.done then return 3 end
	if not e.open then return 2 end
	return 1
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
				out[#out + 1] = { key = d.key, dungeon = d.name, a = a, st = st, did = did, total = total, open = a.open ~= false,
					done = st.done and true or false, level = a.level or d.minLevel or 0 }
			end
		end
	end
	sort(out, function(x, y)
		local rx, ry = rank(x), rank(y)
		if rx ~= ry then return rx < ry end
		if x.level ~= y.level then return x.level < y.level end
		return tostring(x.a.name) < tostring(y.a.name)
	end)
	return out
end

---------------------------------------------------------------------------
-- The cards
---------------------------------------------------------------------------

local KIND = { attunement = L["Attunement"], key = L["Key"], item = L["Item"] }

local function card(i)
	local c = cards[i]
	if c then return c end
	c = CreateFrame("Button", nil, body)
	Theme.Skin(c, "button")
	W.Hover(c)
	local x = PAD - CARD_X
	c.Glyph = W.Tex(c, "ARTWORK", "lock", "textMuted")
	c.Glyph:SetSize(14, 14)
	c.Glyph:SetPoint("CENTER", c, "TOPLEFT", x / 2 + 2, -24)
	c.Title = W.Text(c, "title", "quest")
	c.Title:SetPoint("LEFT", c, "TOPLEFT", x, -24)
	c.State = W.Chip(c)
	c.State:SetPoint("LEFT", c.Title, "RIGHT", 10, 0)
	c.Meta = W.Text(c, "small", "textMuted")
	c.Meta:SetPoint("TOPLEFT", c, "TOPLEFT", x, -42)
	c.Bar = W.ProgressLine(c, 4)
	c.Bar:SetWidth(BAR_W)
	c.Bar:SetPoint("LEFT", c, "TOPLEFT", x, -70)
	c.Count = W.Text(c, "small", "textDim")
	c.Count:SetPoint("LEFT", c.Bar, "RIGHT", 10, 0)
	c.Closed = W.Text(c, "label", "warning")
	c.Closed:SetPoint("LEFT", c, "TOPLEFT", x, -70)
	c.Next = W.Text(c, "label", "text")
	c.Next:SetPoint("LEFT", c, "TOPLEFT", x, -94)
	c.Next:SetWordWrap(false)
	c.Guide = W.Button(c, L["Guide me"], function(self)
		local DS = UI.DungeonsSection
		if DS and DS.Attune then DS.Attune(self.psId, self.psKey) end
	end, { height = 28, icon = "icon-goto" })
	c.Guide:SetPoint("RIGHT", c, "TOPRIGHT", -12, -24)
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

local function paint(c, e, width)
	local a, st = e.a, e.st
	c.psKey, c.psId = e.key, a.id
	c:SetWidth(width)
	c.Title:SetText(a.name or "")
	W.Color(c.Title, a.kind == "attunement" and "quest" or "item")
	local glyph = e.done and { "check", "success" } or (not e.open and { "lock", "textMuted" }) or { "icon-dungeon", "dungeon" }
	c.Glyph:SetTexture(Theme.Media(glyph[1]))
	W.Color(c.Glyph, glyph[2])
	if e.done then
		W.SetChip(c.State, L["Done"], "success")
	elseif st.goalDone and a.item then
		W.SetChip(c.State, L["Not in your bags"], "warning")
	else
		c.State:Hide()
	end
	local facts = { format(L["Opens %s"], e.dungeon or e.key), KIND[a.kind] or KIND.attunement }
	facts[#facts + 1] = a.need == "one" and L["One in the group is enough"] or L["Everyone entering needs it"]
	if a.level then facts[#facts + 1] = format(L["From level %d"], a.level) end
	c.Meta:SetText(concat(facts, DOT))
	c.Meta:SetWidth(width - (PAD - CARD_X) * 2)
	-- Progress, or why there is none yet.
	local y = 82
	c.Closed:SetShown(not e.open and not e.done)
	c.Bar:SetShown(e.open or e.done)
	-- Done: the bar full, the chip says it (its steps left over read "skip" once it is done).
	c.Count:SetShown(e.open and not e.done)
	if not e.open and not e.done then
		c.Closed:SetText(L["Not open on Forever yet"])
	elseif e.done then
		W.SetProgress(c.Bar, 1, BAR_W)
	else
		W.SetProgress(c.Bar, e.total > 0 and e.did / e.total or 0, BAR_W)
		c.Count:SetText(format(L["%d of %d steps"], e.did, e.total))
	end
	-- The next step, while one is left.
	local nextStep = not e.done and st.next and st.steps[st.next]
	if nextStep then
		c.Next:SetText(format(L["Next: %s"], stepWords(nextStep.step, nextStep.state)))
		c.Next:SetWidth(width - (PAD - CARD_X) * 2)
		c.Next:Show()
		y = 106
	else
		c.Next:Hide()
	end
	local can = not e.done and st.left > 0
	c.Guide:SetShown(can)
	c.Guide.psId, c.Guide.psKey = a.id, e.key
	c.Guide.psTip = L["Guide me"]
	c.Guide.psTipLines = { st.left == 1 and L["A guide through the 1 step left, from where you stand."]
		or format(L["A guide through the %d steps left, from where you stand."], st.left), L["It opens in a new tab."] }
	c:SetHeight(y + 14)
	c:Show()
	return { key = e.key, id = a.id, name = a.name, opens = e.dungeon, done = e.done, open = e.open,
		progress = e.done or (e.open and { e.did, e.total }) or false, closed = c.Closed:IsShown() and c.Closed:GetText() or false,
		nextStep = nextStep and c.Next:GetText() or false, guide = can, chip = c.State:IsShown() and c.State.Text:GetText() or false }
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
	local width = MW - CARD_X * 2
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
		for i, e in ipairs(list) do
			local c = card(i)
			c:ClearAllPoints()
			c:SetPoint("TOPLEFT", body, "TOPLEFT", CARD_X, -y)
			shown[i] = paint(c, e, width)
			y = y + c:GetHeight() + CARD_GAP
			n = i
		end
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
		key = KEY, label = L["Attunements"], icon = "lock", order = 31,
		build = AT.Build,
		render = AT.Render,
	})
end
