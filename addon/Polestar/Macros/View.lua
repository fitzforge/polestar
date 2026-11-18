-- The Macros section of the hub: the class macros of Data.lua for the
-- player's class, put on the game's macro list in one click (Macros.lua).
--
-- The sidebar: the whole class, then each spec with its count, the player's
-- spec marked (Gear's) and picked the first time. The tab row: PvE and PvP;
-- at its right end, where each macro comes from (all, as in Classic, adapted
-- for Forever, new in Forever), as the Dungeons section's faction filter.
-- One card per macro: its icon, title and origin, its level and the name it
-- has in the macro list once made; then what it does, the macro in the
-- client's names (spells and items in their colours), its modifier keys and
-- what it needs. At the card's corner: Create, "On your macro list", or
-- Update when its text changed since (an edit by hand asks a second click);
-- with why it can't be written beside it (in combat, no free slot, too long
-- in this language) or a spell not learned yet. The footer: the source and
-- its licence (the link opens the copy window), and whether Create writes to
-- the character's macros or the account's, with the free slots.
--
-- Registered with UI.RegisterSection; opened by SHOW_MACROS (/pole macros).

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local M = ns.Macros
local L = ns.L
local max, min, floor, ipairs, format, type = math.max, math.min, math.floor, ipairs, string.format, type

if not (UI and W and W.SHELL and M) then return end

local SH = W.SHELL
local PAD = 16
local ICON = 36
local TX = PAD + ICON + 14 -- where a card's text starts
local HEAD_H = PAD + ICON + 10 -- down to the card's rule
local GAP = 8 -- between cards
local ROW_GAP = 8 -- between a card's rows
local ACT_W = 120 -- the room kept for a card's action
local FOOT_PAD = 16
local FOOT_H = 28 + FOOT_PAD * 2
local DOT = "  \194\183  "

local MV = {}
UI.MacrosSection = MV

local ORIGINS = {
	{ key = "all", label = L["All"] },
	{ key = "classic", label = L["As in Classic"] },
	{ key = "adapted", label = L["Adapted"] },
	{ key = "forever", label = L["New in Forever"] },
}
local ORIGIN_TEXT = {
	classic = L["As in Classic"],
	adapted = L["Adapted for Forever"],
	forever = L["New in Forever"],
}
local WHY = {
	off = L["Class macros are turned off"],
	combat = L["Not in combat"],
	full = L["No free macro slot"],
	noapi = L["Macros are not available"],
}

local root, shellRef, scroll, foot, empty, segs, untested
local cards = {}
local query = ""
local shown = {}

---------------------------------------------------------------------------
-- State
---------------------------------------------------------------------------

local function char()
	local s = ns.CharState()
	if type(s.macros) ~= "table" then s.macros = {} end
	return s.macros
end

-- The spec picked in the sidebar: "class" or a spec key; first the player's.
local function spec()
	local c = char()
	local d = M.Data()
	if c.spec ~= "class" and not (d and d.specByKey[c.spec or ""]) then c.spec = M.Spec() or "class" end
	return c.spec
end

local function pvp() return ns.Get("macros.tab") == "pvp" end
local function origin() local o = ns.Get("macros.origin"); return o ~= "all" and o or nil end
local function perChar() return ns.Get("macros.where") ~= "account" end

local function className()
	return UI.ClassName and UI.ClassName((select(2, UnitClass("player")))) or (UnitClass("player")) or ""
end

---------------------------------------------------------------------------
-- Cards
---------------------------------------------------------------------------

-- The rows' label column: its widest label in the client's language and 14
-- more, within 72 and 140; measured once, on a probe of its own (W.TextWidth
-- writes the text it measures).
local labelW
local function labelWidth(fs)
	if labelW then return labelW end
	local probe = W.Text(fs:GetParent(), "small", "textDim")
	probe:Hide()
	local widest = 0
	for _, s in ipairs({ L["Does"], L["Macro"], L["Keys"], L["Needs"] }) do widest = max(widest, W.TextWidth(probe, s)) end
	labelW = min(140, max(72, floor(widest + 0.5) + 14))
	return labelW
end

local function rowLabel(c, text)
	local fs = W.Text(c, "small", "textDim")
	fs:SetText(text)
	return fs
end

local function wrapped(c, role, color)
	local fs = W.Text(c, role, color)
	fs:SetWordWrap(true)
	fs:SetJustifyV("TOP")
	return fs
end

local function card(i)
	local c = cards[i]
	if c then return c end
	c = CreateFrame("Frame", nil, scroll.Child)
	Theme.Skin(c, "panel")
	c.Icon = c:CreateTexture(nil, "ARTWORK")
	c.Icon:SetSize(ICON, ICON)
	c.Icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
	c.Icon:SetPoint("TOPLEFT", c, "TOPLEFT", PAD, -PAD)
	c.Title = W.Text(c, "title", "text")
	c.Title:SetPoint("TOPLEFT", c, "TOPLEFT", TX, -PAD - 1)
	c.Meta = W.Text(c, "small", "textMuted")
	c.Meta:SetPoint("TOPLEFT", c, "TOPLEFT", TX, -PAD - 23)
	c.Action = W.Button(c, "", nil, { height = 28 })
	c.Action.psSetText = W.SetButtonText
	c.Action:SetPoint("TOPRIGHT", c, "TOPRIGHT", -PAD, -PAD + 2)
	c.Done = W.Chip(c)
	c.Done:SetPoint("TOPRIGHT", c, "TOPRIGHT", -PAD, -PAD + 2)
	c.State = W.Text(c, "small", "textMuted")
	c.State:SetJustifyH("RIGHT")
	c.Rule = W.Divider(c)
	c.Rule:SetPoint("TOPLEFT", c, "TOPLEFT", TX, -HEAD_H)
	c.Rule:SetPoint("TOPRIGHT", c, "TOPRIGHT", -PAD, -HEAD_H)
	c.DoesLabel = rowLabel(c, L["Does"])
	c.Does = wrapped(c, "note", "text")
	c.MacroLabel = rowLabel(c, L["Macro"])
	c.Well = CreateFrame("Frame", nil, c)
	Theme.Skin(c.Well, "editbox")
	c.Code = wrapped(c.Well, "note", "textDim")
	c.Code:SetPoint("TOPLEFT", c.Well, "TOPLEFT", 10, -7)
	c.KeysLabel = rowLabel(c, L["Keys"])
	c.Keys = wrapped(c, "note", "text")
	c.NeedsLabel = rowLabel(c, L["Needs"])
	c.Needs = wrapped(c, "note", "textDim")
	c.Action:SetScript("OnClick", function(self) MV.Act(self:GetParent()) end)
	cards[i] = c
	return c
end

-- One row of a card: its label at the text edge, its value after the label
-- column. -> the row's height
local function placeRow(c, label, value, y, valueW, valueH)
	label:ClearAllPoints()
	label:SetPoint("TOPLEFT", c, "TOPLEFT", TX, -y - 1)
	label:Show()
	value:ClearAllPoints()
	value:SetPoint("TOPLEFT", c, "TOPLEFT", TX + labelWidth(label), -y)
	value:SetWidth(valueW)
	value:Show()
	return valueH or floor(value:GetStringHeight() + 0.5)
end

local function keysText(m)
	local out = {}
	for i, k in ipairs(m.keys or {}) do
		out[i] = "|c" .. Theme.Hex("text") .. (k[1] or L["Press"]) .. "|r  " .. k[2]
	end
	return table.concat(out, DOT)
end

-- What the card's corner shows: { action = text | nil, done = bool, note, noteColor, confirm }
local function cornerOf(m)
	local status = M.Status(m)
	local update = status == "outdated" or status == "edited"
	local ok, why = M.CanWrite(m, perChar(), update)
	local note, color
	if not ok then
		if why == "long" then note = format(L["Too long in your language (%d/%d)"], #(M.Body(m)), M.MAX_BODY)
		else note = WHY[why] or WHY.noapi end
		color = "warning"
	end
	if status == "ok" then return { done = true, note = note, noteColor = color } end
	if update then
		return { action = L["Update"], enabled = ok, confirm = status == "edited",
			note = note or (status == "edited" and L["Edited by hand"] or L["Changed since you made it"]), noteColor = color or "warning" }
	end
	if not note then
		local known, missing = M.Known(m)
		if not known then
			local name = M.SpellName(missing) or "?"
			note = m.level and format(L["%s at level %d"], name, m.level) or format(L["Not learned yet: %s"], name)
		elseif m.fill then
			note = L["Put your item's name in it"]
		elseif status == "deleted" then
			note = L["Deleted from your macros"]
		end
		color = "textMuted"
	end
	return { action = L["Create"], enabled = ok, note = note, noteColor = color }
end

local function paint(c, m, width)
	c.psMacro = m
	c:SetWidth(width)
	c.Icon:SetTexture("Interface\\Icons\\" .. m.icon)
	local corner = cornerOf(m)
	c.psCorner = corner
	c.Done:Hide()
	c.Action:Hide()
	local actW = 0
	if corner.done then
		actW = W.SetChip(c.Done, L["On your macro list"], "success")
	elseif corner.action then
		c.Action.psArmed = nil
		W.SetButtonText(c.Action, corner.action)
		c.Action.psConfirmText = corner.action
		c.Action:SetEnabled(corner.enabled and true or false)
		c.Action:Show()
		actW = c.Action:GetWidth()
	end
	local cornerEdge = c.Done:IsShown() and c.Done or c.Action
	c.State:ClearAllPoints()
	c.State:SetPoint("RIGHT", cornerEdge, "LEFT", -10, 0)
	c.State:SetText(corner.note or "")
	W.Color(c.State, corner.noteColor or "textMuted")

	local titleW = max(80, width - TX - PAD - max(ACT_W, actW) - 12)
	c.Title:SetWidth(titleW)
	c.Title:SetText(m.title)
	local meta = { ORIGIN_TEXT[m.origin] or ORIGIN_TEXT.classic }
	if m.level then meta[#meta + 1] = format(L["Level %d"], m.level) end
	local rec = M.Made()[m.id]
	if rec and corner.done then meta[#meta + 1] = format(L["Saved as %s in your macros"], ns.Quoted(rec.name)) end
	c.Meta:SetText(table.concat(meta, DOT))
	c.Meta:SetWidth(titleW)

	local valueW = width - TX - labelWidth(c.DoesLabel) - PAD
	local y = HEAD_H + 12
	c.Does:SetText(m.use)
	y = y + placeRow(c, c.DoesLabel, c.Does, y, valueW) + ROW_GAP
	c.Code:SetWidth(valueW - 20)
	c.Code:SetText(M.Highlight(m, Theme.Hex("spell"), Theme.Hex("item")))
	local codeH = floor(c.Code:GetStringHeight() + 0.5) + 14
	c.Well:SetHeight(codeH)
	y = y + placeRow(c, c.MacroLabel, c.Well, y - 4, valueW, codeH) - 4 + ROW_GAP + 2
	local keys = keysText(m)
	if keys ~= "" then
		c.Keys:SetText(keys)
		y = y + placeRow(c, c.KeysLabel, c.Keys, y, valueW) + ROW_GAP
	else
		c.Keys:Hide()
		c.KeysLabel:Hide()
	end
	if m.needs then
		c.Needs:SetText(m.needs)
		y = y + placeRow(c, c.NeedsLabel, c.Needs, y, valueW) + ROW_GAP
	else
		c.Needs:Hide()
		c.NeedsLabel:Hide()
	end
	local h = y - ROW_GAP + PAD
	c:SetHeight(h)
	c:Show()
	return h
end

---------------------------------------------------------------------------
-- The section
---------------------------------------------------------------------------

local function segPaint()
	local o = ns.Get("macros.origin")
	for _, b in ipairs(segs) do
		local on = b.psKey == o
		b.Selected:SetShown(on)
		W.Color(b.Label, on and "text" or "textMuted")
	end
end

local function whereButton(parent, key, text)
	local b = CreateFrame("Button", nil, parent)
	b:SetHeight(24)
	b.psKey = key
	W.Hover(b)
	b.Selected = W.Fill(b, "panelAlt", "BACKGROUND", 0)
	b.Label = W.Text(b, "small", "textMuted")
	b.Label:SetPoint("CENTER", b, "CENTER", 0, 0)
	b.Label:SetText(text)
	b:SetWidth(floor(b.Label:GetStringWidth() + 20 + 0.5))
	b:SetScript("OnClick", function(self) MV.SetWhere(self.psKey) end)
	return b
end

function MV.Build(parent, shell)
	if root then return root end
	shellRef = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)

	foot = CreateFrame("Frame", nil, root)
	foot:SetPoint("BOTTOMLEFT", root, "BOTTOMLEFT", 0, 0)
	foot:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", 0, 0)
	foot:SetHeight(FOOT_H)
	foot.Rule = W.Divider(foot)
	foot.Rule:SetPoint("TOPLEFT", foot, "TOPLEFT", 0, 0)
	foot.Rule:SetPoint("TOPRIGHT", foot, "TOPRIGHT", 0, 0)
	foot.From = W.Text(foot, "small", "textDim")
	foot.From:SetPoint("LEFT", foot, "LEFT", SH.pad, 0)
	foot.From:SetText(L["Macros from"])
	foot.Link = W.Link(foot, "classicwowforever.com", function()
		local d = M.Data()
		UI.ShowCopy(L["Class macros"], d and d.url or "https://classicwowforever.com/macros/")
	end, { role = "small" })
	foot.Link:SetPoint("LEFT", foot.From, "RIGHT", 4, 0)
	foot.Licence = W.Text(foot, "small", "textDim")
	foot.Licence:SetPoint("LEFT", foot.Link, "RIGHT", 4, 0)
	foot.Licence:SetText(DOT .. "CC BY 4.0" .. DOT .. L["names from your game"])
	foot.Slots = W.Text(foot, "small", "textMuted")
	foot.Slots:SetPoint("RIGHT", foot, "RIGHT", -SH.pad, 0)
	foot.Account = whereButton(foot, "account", L["Account"])
	foot.Account:SetPoint("RIGHT", foot.Slots, "LEFT", -12, 0)
	foot.Char = whereButton(foot, "char", L["Character"])
	foot.Char:SetPoint("RIGHT", foot.Account, "LEFT", -2, 0)
	foot.In = W.Text(foot, "small", "textDim")
	foot.In:SetPoint("RIGHT", foot.Char, "LEFT", -10, 0)
	foot.In:SetText(L["Create in"])

	scroll = W.Scroll(root)
	scroll:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
	scroll:SetPoint("BOTTOMRIGHT", foot, "TOPRIGHT", 0, 0)
	empty = W.Text(scroll.Child, "note", "textMuted")
	empty:SetWordWrap(true)
	empty:SetPoint("TOPLEFT", scroll.Child, "TOPLEFT", SH.pad, -12)

	-- Where each macro comes from, at the right of the tab row.
	segs = {}
	local x = -(SH.pad - 12)
	for i = #ORIGINS, 1, -1 do
		local o = ORIGINS[i]
		local b = CreateFrame("Button", nil, shell.TabRow)
		b:SetHeight(24)
		b.psKey = o.key
		W.Hover(b)
		b.Selected = W.Fill(b, "panelAlt", "BACKGROUND", 0)
		b.Label = W.Text(b, "small", "textMuted")
		b.Label:SetPoint("CENTER", b, "CENTER", 0, 0)
		b.Label:SetText(o.label)
		b:SetWidth(floor(b.Label:GetStringWidth() + 20 + 0.5))
		b:SetPoint("RIGHT", shell.TabRow, "RIGHT", x, 0)
		b:SetScript("OnClick", function(self) MV.SetOrigin(self.psKey) end)
		b:Hide()
		x = x - b:GetWidth() - 2
		segs[i] = b
	end
	-- The site's own warning, beside the section's title.
	untested = W.Chip(shell.Title:GetParent())
	untested:Hide()
	untested:SetScript("OnEnter", function(self) W.Tip(self, L["Not yet tested on Forever"], { L["The site says its macros are not tested in the Forever client yet."] }) end)
	untested:SetScript("OnLeave", W.HideTip)
	untested:EnableMouse(true)

	-- The picker hides the section parent when leaving Macros: the filter and
	-- the chip on the shell's own frames go with it.
	root:SetScript("OnHide", function()
		for _, b in ipairs(segs) do b:Hide() end
		untested:Hide()
		shellRef.psTabRoom = nil
	end)
	return root
end

local function bodyWidth()
	local full = shellRef and (shellRef:GetWidth() - (shellRef.psRail or 0) - (shellRef.psSidebar or SH.sidebar) - 2) or 0
	if full <= 0 then full = 878 end
	return full - SH.pad * 2
end

local function matches(m, q)
	if q == "" then return true end
	local hay = (m.title .. "\n" .. m.use .. "\n" .. (M.Body(m))):lower()
	return hay:find(q, 1, true) ~= nil
end

function MV.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	local d = M.Data()
	local side = pvp()
	local counts = M.Counts(side)
	local total = counts.pve + counts.pvp
	if shellRef then
		W.ShellTitle(shellRef, format(L["%s macros"], className()),
			d and (format(L["%d macros"], total) .. DOT .. L["spell and item names from your game"]) or nil)
		W.ShellTabs(shellRef, d and {
			{ key = "pve", label = format("%s  |c%s%d|r", L["PvE"], Theme.Hex("textMuted"), counts.pve) },
			{ key = "pvp", label = format("%s  |c%s%d|r", L["PvP"], Theme.Hex("textMuted"), counts.pvp) },
		} or nil, side and "pvp" or "pve", function(k) MV.SetTab(k) end)
		local room = 0
		for _, b in ipairs(segs) do
			b:SetShown(d ~= nil)
			room = room + b:GetWidth() + 2
		end
		shellRef.psTabRoom = function() return bodyWidth() + SH.pad * 2 - room - 24 end
		segPaint()
		W.SetChip(untested, L["Not yet tested on Forever"], "warning")
		untested:ClearAllPoints()
		untested:SetPoint("LEFT", shellRef.Title, "LEFT", floor(W.TextWidth(shellRef.Title) + 0.5) + 12, 0)
		untested:SetShown(d ~= nil)
	end

	local width = bodyWidth()
	local on = M.Enabled()
	local list = (d and on) and M.List({ pvp = side, spec = spec(), origin = origin() }) or {}
	local y = 8
	local n = 0
	shown.ids = {}
	for _, m in ipairs(list) do
		if matches(m, query) then
			n = n + 1
			local c = card(n)
			c:ClearAllPoints()
			c:SetPoint("TOPLEFT", scroll.Child, "TOPLEFT", SH.pad, -y)
			y = y + paint(c, m, width) + GAP
			shown.ids[n] = m.id
		end
	end
	for i = n + 1, #cards do cards[i]:Hide() end
	empty:SetWidth(width)
	empty:SetText((not on and L["Class macros are turned off. Turn them on under Options > Discovery > Lookup."])
		or (not d and L["No macros for your class yet."]) or (query ~= "" and L["No macro matches your search."]) or L["No macro for this filter."])
	empty:SetShown(n == 0)
	scroll.Child:SetWidth(width + SH.pad * 2)
	W.SetScrollContent(scroll, max(y, 40) + 8)

	local acc, accMax, ch, chMax = M.Slots()
	local where = perChar() and "char" or "account"
	for _, b in ipairs({ foot.Char, foot.Account }) do
		local on = b.psKey == where
		b.Selected:SetShown(on)
		W.Color(b.Label, on and "text" or "textMuted")
	end
	foot.Slots:SetText(format(L["%d/%d · %d/%d used"], ch, chMax, acc, accMax))
	shown.rows, shown.spec, shown.pvp, shown.where, shown.off = n, spec(), side, where, not on
end

local function repaint()
	local P = UI.Picker
	if root and root:IsVisible() and P and P.Render then P.Render() else MV.Render() end
end

-- The sidebar: the whole class, then each spec; the player's marked (icon-learn, the accent).
function MV.Nav()
	local d = M.Data()
	if not d then return {}, nil end
	local counts = M.Counts(pvp())
	local mine = M.Spec()
	local out = { { key = "class", label = L["Whole class"], count = counts.class } }
	for _, s in ipairs(d.specs) do
		local label = s.name
		-- The player's spec as the Talents section marks the followed plan: its glyph, here its name in the accent
		-- too (a "your spec" note beside it took a second line for the longer names).
		if s.key == mine then label = "|c" .. Theme.Hex("accent") .. label .. "|r" end
		out[#out + 1] = { key = s.key, label = label, icon = s.key == mine and "icon-learn" or nil, count = counts[s.key] }
	end
	return out, spec()
end

local function toTop()
	if scroll then W.ScrollTo(scroll, 0) end
end

function MV.OnNav(key)
	char().spec = key
	toTop()
	repaint()
end

function MV.SetTab(key)
	ns.Set("macros.tab", key == "pvp" and "pvp" or "pve")
	toTop()
	repaint()
end

function MV.SetOrigin(key)
	ns.Set("macros.origin", key)
	toTop()
	repaint()
end

function MV.SetWhere(key)
	ns.Set("macros.where", key == "account" and "account" or "char")
	repaint()
end

function MV.Search(text)
	query = (text or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
	toTop()
	MV.Render()
end

-- The card's button: Create, or Update (a second click within 3 s when the
-- macro was edited by hand, as W.Confirm).
function MV.Act(c)
	local m, corner = c.psMacro, c.psCorner
	if not (m and corner and corner.action) then return end
	if corner.confirm then
		local now = GetTime()
		if not (c.Action.psArmed and now - c.Action.psArmed < 3) then
			c.Action.psArmed = now
			W.SetButtonText(c.Action, L["Click again to replace your edit"])
			ns.After(3, function()
				if c.Action.psArmed and GetTime() - c.Action.psArmed >= 2.9 then
					c.Action.psArmed = nil
					W.SetButtonText(c.Action, c.Action.psConfirmText)
				end
			end)
			return
		end
		c.Action.psArmed = nil
	end
	local ok, why
	if corner.action == L["Update"] then ok, why = M.Update(m) else ok, why = M.Create(m, perChar()) end
	if not ok and why == "failed" then ns.Print(L["The game refused the macro."]) end
	repaint()
end

function MV.Shown() return shown end
MV.cards = cards

function MV.Show()
	local P = UI.Picker
	if UI.ShowPicker then UI.ShowPicker() end
	if P and P.ShowSection then P.ShowSection("Macros") end
	MV.Render()
end

ns.On("SHOW_MACROS", MV.Show)
ns.On("MACROS_UPDATED", function() if root and root:IsVisible() then MV.Render() end end)
ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and path:find("^macros%.") and root and root:IsVisible() then repaint() end
end)
ns.RegisterCommand("macros", function() ns.Fire("SHOW_MACROS") end, L["Show your class macros"])

if UI.RegisterSection then
	UI.RegisterSection({
		key = "Macros", label = L["Macros"], icon = "bolt", order = 45,
		build = MV.Build, render = MV.Render,
		nav = MV.Nav, onNav = MV.OnNav,
		search = MV.Search, searchPlaceholder = L["Search macros"],
	})
end
