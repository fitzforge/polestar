-- The Free mode page of the main window (the section under Guides; its door is
-- Polestar/UI/FreeMode.lua, which loads this folder when the page first
-- shows). Everything on it is Free mode's own state and functions, placed:
--
--   Start (Return to <guide> while it is on): Free.Start, Free.Stop
--   Which quest first: nearest first | most XP a minute first | balanced (free.pick)
--   Hand in finished quests (N) . Route: UI.GuideCarried, the shortest-trip
--     hand-in guide (Handins.lua, Route.lua)
--   Your quests: every quest in the log, one row each (Free.Quests): a tick
--     (ticked = in the loop; unticked = left out, Free.LeaveOut), a pin
--     (Free.Pin), the quest's zone and level and "Ready to hand in". Quick
--     actions: leave out every quest of a zone, leave out the quests that take
--     a group, bring every quest back. The choices are Free mode's saved state
--     (CharState().free), so they are per character and survive /reload.
--
-- A gamepad: the D-pad moves between rows, A ticks the row or unticks it, X
-- pins it (UI/Picker.lua hands X to a widget's psPadX).
--
--   Free.Page.Build(parent, hub) ; Free.Page.Render()
--   Free.Page.Shown() -> what the page shows (the tests read it)

local ns = Polestar
local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L
local Free = ns.Free
-- The folder also loads where there is no interface (the hand-in guide's tests): no page then.
if not (UI and Theme and W and W.SHELL and Free) then return end
local SH = W.SHELL
local max, min, floor, ipairs, format, tostring = math.max, math.min, math.floor, ipairs, string.format, tostring

local P = {}
Free.Page = P

local PAD = SH.pad
local TOP_H = 32 -- the Start button
local ROW_H = 40
local TILE_H = 40
local ZONE_W, LEVEL_W, PIN_W = 150, 30, 28

local root, hub, scroll, body
local parts = {}
local rows = {}
local shown = {}

local function mainWidth()
	local w = hub and (hub:GetWidth() - (hub.psRail or 0) - (hub.psSidebar or SH.sidebar) - 2) or 0
	if w <= 0 then w = 878 end
	return w
end

local function wrapped(fs)
	fs:SetWordWrap(true)
	fs:SetJustifyH("LEFT")
	fs:SetJustifyV("TOP")
	return fs
end

local function oneLine(fs)
	fs:SetWordWrap(false)
	fs:SetJustifyH("LEFT")
	return fs
end

---------------------------------------------------------------------------
-- What the buttons do
---------------------------------------------------------------------------

function P.StartOrReturn()
	if Free.IsOn() then
		Free.Stop()
	else
		local ok, why = Free.Start()
		if not ok then Free.Say(why) end
	end
	P.Refresh()
end

-- A quest ticked is in the loop; unticked, left out. Pinning a quest left out
-- brings it back (Free.Pin).
function P.Toggle(q, out)
	Free.LeaveOut(q, not out)
end

function P.TogglePin(q, pinned)
	Free.Pin(q, not pinned)
end

local function zoneMenu(anchor)
	local items = {}
	for _, z in ipairs(Free.Zones()) do
		items[#items + 1] = { text = format("%s (%d)", z.name, #z.quests), icon = "icon-goto", onClick = function() Free.LeaveOutZone(z.zone) end }
	end
	if #items > 0 then W.ShowMenu(anchor, items, { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -4, short = true }) end
end

---------------------------------------------------------------------------
-- Building
---------------------------------------------------------------------------

-- Two buttons side by side for a choice: the chosen one reads in the text
-- colour over a 2px accent line, the other in textDim.
local function segment(label, key)
	local b = W.Button(body, label, function() Free.SetPick(key) end, { height = 28 })
	b.psKey = key
	b.Bar = W.Fill(b, "accent", "OVERLAY")
	b.Bar:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 1, 1)
	b.Bar:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1)
	b.Bar:SetHeight(2)
	return b
end

local function newRow(i)
	local r = CreateFrame("Button", nil, body)
	r:SetHeight(ROW_H)
	W.Hover(r, 0.7)
	r.Rule = W.Divider(r, false, 0.6)
	r.Rule:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
	r.Rule:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", 0, 0)
	r.Check = W.Checkbox(r, function() P.Toggle(r.psQuest, r.psOut) end)
	r.Check:SetPoint("LEFT", r, "LEFT", 12, 0)
	r.Title = oneLine(W.Text(r, "body", "quest"))
	r.Title:SetPoint("LEFT", r, "LEFT", 44, 0)
	r.Chip = W.Chip(r)
	r.Zone = oneLine(W.Text(r, "small", "place"))
	r.Zone:SetWidth(ZONE_W)
	r.Level = W.Text(r, "number", "textDim")
	r.Level:SetWidth(LEVEL_W)
	r.Level:SetJustifyH("RIGHT")
	r.Pin = W.IconButton(r, "flag", PIN_W, nil, function() P.TogglePin(r.psQuest, r.psPinned) end)
	r.Pin:SetPoint("RIGHT", r, "RIGHT", -12, 0)
	r:SetScript("OnClick", function() P.Toggle(r.psQuest, r.psOut) end)
	r:SetScript("OnEnter", W.SimpleTip)
	r:SetScript("OnLeave", W.HideTip)
	-- A gamepad: A ticks it (the row's own click), X pins it.
	r.psPadX = function() P.TogglePin(r.psQuest, r.psPinned) end
	r.psPadXLabel = function() return r.psPinned and L["Unpin"] or L["Pin to the top"] end
	rows[i] = r
	return r
end

function P.Build(parent, shell)
	if root then return root end
	hub = shell
	root = CreateFrame("Frame", nil, parent)
	root:SetAllPoints(parent)
	scroll = W.Scroll(root)
	scroll:SetPoint("TOPLEFT", root, "TOPLEFT", 0, 0)
	scroll:SetPoint("BOTTOMRIGHT", root, "BOTTOMRIGHT", -4, 4)
	body = scroll.Child
	body:SetWidth(mainWidth())

	parts.Start = W.Button(body, L["Start"], function() P.StartOrReturn() end, { primary = true, height = TOP_H, icon = "icon-ownpath" })
	parts.State = wrapped(W.Text(body, "note", "textDim"))
	parts.PickLabel = oneLine(W.Text(body, "label", "textDim"))
	parts.PickLabel:SetText(L["Which quest first"])
	parts.Near = segment(L["Nearest first"], "near")
	parts.XP = segment(L["Most XP a minute first"], "xp")
	parts.Balanced = segment(L["Balanced"], "balanced")

	-- The hand-in route: a tile, the finished quests' count and "Route".
	local h = CreateFrame("Button", nil, body)
	h:SetHeight(TILE_H)
	Theme.Skin(h, "button")
	W.Hover(h)
	h.Icon = W.Tex(h, "ARTWORK", "icon-turnin", "success")
	h.Icon:SetSize(16, 16)
	h.Icon:SetPoint("LEFT", h, "LEFT", 14, 0)
	h.Text = oneLine(W.Text(h, "label", "text"))
	h.Text:SetPoint("LEFT", h.Icon, "RIGHT", 10, 0)
	h.Chevron = W.Tex(h, "ARTWORK", "chevron-right", "accent")
	h.Chevron:SetSize(12, 12)
	h.Chevron:SetPoint("RIGHT", h, "RIGHT", -14, 0)
	h.Route = oneLine(W.Text(h, "label", "accent"))
	h.Route:SetPoint("RIGHT", h.Chevron, "LEFT", -6, 0)
	h.Route:SetText(L["Route"])
	h:SetScript("OnClick", function() if UI.GuideCarried then UI.GuideCarried() end end)
	h:SetScript("OnEnter", W.SimpleTip)
	h:SetScript("OnLeave", W.HideTip)
	h.psTip = L["Hand in finished quests"]
	h.psTipLines = { L["The shortest trip through the hand-ins of every finished quest in your log, in a guide of its own."] }
	parts.Handin = h

	parts.QuestsH = W.SectionHeader(body)
	parts.Zone = W.Button(body, L["Leave out a zone"], function(self) zoneMenu(self) end, { height = 28 })
	parts.Zone.psTip = L["Leave out a zone"]
	parts.Zone.psTipLines = { L["Every quest of a zone at once. Tick one again to bring it back."] }
	parts.Group = W.Button(body, L["Leave out group quests"], function() Free.LeaveOutGroup() end, { height = 28 })
	parts.Group.psTip = L["Leave out group quests"]
	parts.Group.psTipLines = { L["Quests that take a group: an elite, a boss or an instance."] }
	parts.Back = W.Button(body, "", function() Free.BringBack() end, { height = 28 })

	parts.EmptyTitle = W.Text(body, "display", "text")
	parts.EmptyNote = wrapped(W.Text(body, "note", "textDim"))
	return root
end

---------------------------------------------------------------------------
-- Painting
---------------------------------------------------------------------------

local function enable(b, on)
	b:SetEnabled(on and true or false)
	b:SetAlpha(on and 1 or 0.5)
end

local function paintSegment(b, on)
	b.Bar:SetShown(on)
	W.Color(b.Label, on and "text" or "textDim")
end

local function paintRow(r, e, width)
	r.psQuest, r.psOut, r.psPinned = e.quest, e.out, e.pinned
	r:SetWidth(width)
	r.Check:SetChecked(not e.out)
	r.Title:SetText(e.title)
	W.Color(r.Title, e.out and "textMuted" or "quest")
	local left = width - 12 - PIN_W - 8
	r.Level:ClearAllPoints()
	r.Level:SetPoint("RIGHT", r, "LEFT", left, 0)
	r.Level:SetText(e.level or "")
	left = left - LEVEL_W - 12
	r.Zone:ClearAllPoints()
	r.Zone:SetPoint("RIGHT", r, "LEFT", left, 0)
	r.Zone:SetText(e.zoneName or "")
	W.Color(r.Zone, e.out and "textMuted" or "place")
	left = left - ZONE_W - 12
	if e.ready then
		local cw = W.SetChip(r.Chip, L["Ready to hand in"], "success")
		r.Chip:ClearAllPoints()
		r.Chip:SetPoint("RIGHT", r, "LEFT", left, 0)
		left = left - cw - 12
	else
		r.Chip:Hide()
	end
	r.Title:SetWidth(max(80, left - 44))
	r.Pin:SetEnabled(true)
	W.SetIconState(r.Pin, e.pinned, true)
	r.Pin.psTip = e.pinned and L["Unpin"] or L["Pin to the top"]
	r.Pin.psTipLines = { L["Free mode takes this quest first, whatever the order."] }
	r.psTip = e.title
	r.psTipLines = { e.out and L["Left out of Free mode. Click to bring it back."] or L["In Free mode. Click to leave it out."] }
	r.psPadLabel = e.out and L["Bring back"] or L["Leave out"]
	r:SetAlpha(e.out and 0.75 or 1)
	r:Show()
end

function P.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	W.ShellTitle(hub, L["Free mode"], L["Your own quests as a guide: the arrow leads to the nearest one, then the next."])
	local MW = mainWidth()
	body:SetWidth(MW)
	local width = MW - PAD * 2
	local on = Free.IsOn()
	local pick = ns.Get("free.pick")
	if pick ~= "xp" and pick ~= "near" then pick = "balanced" end
	local list = Free.Quests()

	-- Start, or Return to the guide it came from.
	local back = on and Free.ReturnTitle() or nil
	local label = on and (back and format(L["Return to %s"], back) or L["Stop"]) or L["Start"]
	local y = 20
	W.SetButtonText(parts.Start, label)
	parts.Start:ClearAllPoints()
	parts.Start:SetPoint("TOPLEFT", body, "TOPLEFT", PAD, -y)
	-- What is on, once it is (the header already says what it is while off).
	local stateText = on and (pick == "xp" and L["Free mode: the arrow takes your own quests, the most XP a minute first."]
		or pick == "near" and L["Free mode: the arrow takes your own quests, nearest first."]) or ""
	parts.State:SetText(stateText)
	parts.State:SetWidth(max(120, width - parts.Start:GetWidth() - 16))
	parts.State:ClearAllPoints()
	parts.State:SetPoint("LEFT", parts.Start, "RIGHT", 16, 0)
	shown.start, shown.on, shown.state = label, on, stateText
	y = y + TOP_H + 20

	-- Which quest first.
	parts.PickLabel:ClearAllPoints()
	parts.PickLabel:SetPoint("LEFT", body, "TOPLEFT", PAD, -(y + 14))
	local lw = math.ceil(W.TextWidth(parts.PickLabel)) + 16
	local sx = PAD + lw
	for _, b in ipairs({ parts.Near, parts.XP, parts.Balanced }) do
		paintSegment(b, b.psKey == pick)
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", body, "TOPLEFT", sx, -y)
		sx = sx + b:GetWidth() + 4
	end
	shown.pick = pick
	y = y + 28 + 12

	-- The hand-in route.
	local ready = ns.Handins and ns.Handins.Ready() or {}
	local h = parts.Handin
	h:ClearAllPoints()
	h:SetPoint("TOPLEFT", body, "TOPLEFT", PAD, -y)
	h:SetWidth(width)
	local text = #ready > 0 and format(L["Hand in finished quests (%d)"], #ready) or L["None to hand in"]
	h.Text:SetText(text)
	h.Route:SetShown(#ready > 0)
	h.Chevron:SetShown(#ready > 0)
	enable(h, #ready > 0)
	shown.handin = { text = text, count = #ready, enabled = #ready > 0 }
	y = y + TILE_H + 8

	-- Your quests.
	local H = parts.QuestsH
	H:ClearAllPoints()
	H:SetPoint("TOPLEFT", body, "TOPLEFT", PAD, -y)
	H:SetWidth(width)
	W.SetSection(H, L["Your quests"], #list)
	y = y + 44
	if #list == 0 then
		for _, b in ipairs({ parts.Zone, parts.Group, parts.Back }) do b:Hide() end
		parts.EmptyTitle:SetText(L["No quests to lead to"])
		parts.EmptyNote:SetText(L["Pick up quests and Free mode leads you to them."])
		parts.EmptyNote:SetWidth(width)
		parts.EmptyTitle:ClearAllPoints()
		parts.EmptyTitle:SetPoint("TOPLEFT", body, "TOPLEFT", PAD, -(y + 8))
		parts.EmptyNote:ClearAllPoints()
		parts.EmptyNote:SetPoint("TOPLEFT", parts.EmptyTitle, "BOTTOMLEFT", 0, -10)
		parts.EmptyTitle:Show()
		parts.EmptyNote:Show()
		y = y + 8 + 28 + 10 + parts.EmptyNote:GetStringHeight() + 24
		shown.empty = true
	else
		parts.EmptyTitle:Hide()
		parts.EmptyNote:Hide()
		local zones, group, out = Free.Zones(), 0, 0
		for _, e in ipairs(list) do
			if e.group and not e.out then group = group + 1 end
			if e.out then out = out + 1 end
		end
		local x = PAD
		local function place(b)
			b:ClearAllPoints()
			b:SetPoint("TOPLEFT", body, "TOPLEFT", x, -y)
			b:Show()
			x = x + b:GetWidth() + 8
		end
		enable(parts.Zone, #zones > 0)
		place(parts.Zone)
		enable(parts.Group, group > 0)
		place(parts.Group)
		if out > 0 then
			W.SetButtonText(parts.Back, format(L["Bring back left-out quests (%d)"], out))
			place(parts.Back)
		else
			parts.Back:Hide()
		end
		shown.actions = { zones = #zones, group = group, out = out }
		y = y + 28 + 12
		for i, e in ipairs(list) do
			local r = rows[i] or newRow(i)
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", body, "TOPLEFT", PAD - 12, -y)
			paintRow(r, e, width + 24)
			shown[#shown + 1] = { quest = e.quest, title = e.title, checked = not e.out, pinned = e.pinned, zone = e.zoneName, level = e.level,
				ready = e.ready, group = e.group }
			y = y + ROW_H
		end
	end
	for i = #list + 1, #rows do rows[i]:Hide() end
	W.SetScrollContent(scroll, y + 24)
end

-- What the page shows: its start button, the order, the hand-in tile and the
-- quests (each { quest, title, checked, pinned, zone, level, ready, group }).
function P.Shown() return shown end
P.rows = rows
P.parts = parts

---------------------------------------------------------------------------
-- Refreshing
---------------------------------------------------------------------------

function P.Refresh()
	if root and root:IsVisible() then P.Render() end
end

-- The quest log's bursts make one draw.
local pending = false
local function later()
	if pending or not (root and root:IsVisible()) then return end
	pending = true
	ns.After(0.2, function()
		pending = false
		P.Refresh()
	end)
end

for _, event in ipairs({ "QUEST_LOG_UPDATE", "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN" }) do
	ns.RegisterEvent(event, later)
end
ns.On("TABS_CHANGED", later)
ns.On("FREE_CHANGED", P.Refresh)
ns.On("FREE_MODE", later)
ns.On("CODEX_LOADED", later)
ns.On("SETTING_CHANGED", function(path)
	if type(path) == "string" and path:find("^free") then P.Refresh() end
end)
Theme.OnChanged(P.Refresh)
