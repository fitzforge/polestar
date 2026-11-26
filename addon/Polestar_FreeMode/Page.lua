-- The Free mode page of the main window (the section under Guides; its door is
-- Polestar/UI/FreeMode.lua, which loads this folder when the page first
-- shows). One page, laid out for who arrives:
--
--   intro    never started on this account (Free.Used): what Free mode is
--            (three points, when it suits, how to go back) beside a preview of
--            the player's own log in Free mode's order, and one Start
--   ready    started before, off now: Start with the order beside it, the
--            quests it would take first, "What is Free mode?" folded
--   on       "Free mode is on · following N quests" with Back to <guide>, the
--            order, then the whole route: numbered in Free mode's order (the
--            plan the arrow follows, Free.Route), the quest it leads to now
--            marked, each row its title in its difficulty colour, why it is
--            there, its progress, the walk, its XP and zone; the finished ones
--            one NPC takes under that NPC's name
--
-- In every layout: the hand-in card while quests are finished (their count,
-- the trip's time, Route: UI.GuideCarried), the quests left out folded under
-- their own header with Bring back, and the quick actions (leave out a zone,
-- the quests that take a group). A row's tick leaves it out, its flag pins it
-- first (Free.Pin); a click on the row pins it too. Hovering a row, or a
-- gamepad's focus on it, shows the game's quest tooltip with Polestar's lines
-- (where, why, the objectives).
--
-- The sidebar lists the page's sections (P.Nav: Your route, Hand-ins, Left
-- out, About Free mode); a click scrolls to one.
--
-- A gamepad: the D-pad moves between rows, A pins the row (a left-out row:
-- brings it back), X leaves it out (UI/Picker.lua hands X to psPadX).
--
--   Free.Page.Build(parent, hub) ; Free.Page.Render() ; Free.Page.Refresh()
--   Free.Page.Nav() -> items, activeKey ; Free.Page.Jump(key)
--   Free.Page.Shown() -> what the page shows (the tests read it)

local ns = Polestar
local UI, Theme, W, L = ns.UI, ns.Theme, ns.Widgets, ns.L
local Free = ns.Free
-- The folder also loads where there is no interface (the hand-in guide's tests): no page then.
if not (UI and Theme and W and W.SHELL and Free) then return end
local SH = W.SHELL
local max, min, floor, ceil, ipairs, pairs, format, tostring = math.max, math.min, math.floor, math.ceil, ipairs, pairs, string.format, tostring

local P = {}
Free.Page = P

local PAD = SH.pad
local START_H = 32 -- the Start button
local SEG_H = 28 -- the order's segments
local ROW_H = 50 -- a route row: its title and why on two lines
local GROUP_H = 30 -- a hand-in NPC's line over its quests
local OUT_H = 32 -- a left-out row
local CARD_H = 60 -- the hand-in card: an action tile (Theme.Skin "tile")
local GUTTER = 28 -- the route number's room left of the text edge
local PREVIEW_ROWS = 3 -- the quests the intro and ready layouts show
local QUIET = 0.55 -- a row's tick and flag at rest
local ZONE_W, XP_W, WALK_W, PROG_W, CTRL_W = 124, 72, 52, 84, 60

local root, hub, scroll, body
local parts = {}
-- Route and left-out rows, one frame per quest (a pin reorders the route
-- under a gamepad's focus: the focus stays on its quest); every frame made
-- is in rows / outRows too.
local rows, groups, outRows = {}, {}, {}
local rowOf, outRowOf = {}, {}
local shown = {}
local anchors = {} -- section key -> its y in the body (P.Jump)
local aboutOpen, outOpen, navKey = false, false, nil

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

local function at(f, x, y)
	f:ClearAllPoints()
	f:SetPoint("TOPLEFT", body, "TOPLEFT", x, -y)
	f:Show()
end

local function minutes(seconds)
	return format(L["%d min"], max(1, ceil((seconds or 0) / 60)))
end

local function hex(name)
	return "|c" .. Theme.Hex(name)
end

---------------------------------------------------------------------------
-- What the buttons do
---------------------------------------------------------------------------

function P.Start()
	local ok, why = Free.Start()
	if not ok then Free.Say(why) end
	P.Refresh()
end

function P.Back()
	Free.Stop()
	P.Refresh()
end

function P.LeaveOut(q) Free.LeaveOut(q, true) end
function P.BringBack(q) Free.LeaveOut(q, false) end
function P.TogglePin(q, pinned) Free.Pin(q, not pinned) end

local function zoneMenu(anchor)
	local items = {}
	for _, z in ipairs(Free.Zones()) do
		items[#items + 1] = { text = format("%s (%d)", z.name, #z.quests), icon = "icon-goto", onClick = function() Free.LeaveOutZone(z.zone) end }
	end
	if #items > 0 then W.ShowMenu(anchor, items, { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -4, short = true }) end
end

---------------------------------------------------------------------------
-- A quest's facts for its row and tooltip
---------------------------------------------------------------------------

-- Its objectives' counts summed -> done, total, lines (nil total: none to count).
local function progressOf(q)
	local lines = ns.Compat.GetQuestObjectives(q) or {}
	local done, total = 0, 0
	for _, l in ipairs(lines) do
		local need = tonumber(l.numRequired) or 0
		if need > 0 then
			total = total + need
			done = done + min(need, tonumber(l.numFulfilled) or 0)
		elseif l.finished ~= nil then
			total = total + 1
			if l.finished then done = done + 1 end
		end
	end
	return done, total > 0 and total or nil, lines
end

-- The tooltip: the game's own for the quest, then where it is, why it is
-- where it is on the route, and its objectives with their counts.
local function questTip(r)
	local e = r.psEntry
	if not e then return end
	W.QuestTip(r, e.quest, function(tip)
		local where = e.zone
		if e.travel then where = where and (where .. "  \194\183  " .. format(L["%s away"], minutes(e.travel))) or format(L["%s away"], minutes(e.travel)) end
		local lines = {}
		if where then lines[#lines + 1] = { where, Theme.TipColor("place") } end
		if e.why then lines[#lines + 1] = { e.why, Theme.TipColor("textDim") } end
		for _, l in ipairs(e.lines or {}) do
			if type(l.text) == "string" and l.text ~= "" then
				lines[#lines + 1] = { l.text, Theme.TipColor(l.finished and "success" or "text") }
			end
		end
		if #lines > 0 then
			tip:AddLine(" ")
			W.TooltipLines(tip, lines)
		end
	end, function(tip)
		tip:SetPoint("BOTTOMLEFT", r.Title, "TOPLEFT", -4, 8)
	end)
	shown.tip = e.quest
end

local function hideTip(r)
	if GameTooltip and GameTooltip.GetOwner and GameTooltip:GetOwner() == r then GameTooltip:Hide() end
	if shown.tip == (r.psEntry and r.psEntry.quest) then shown.tip = nil end
end

---------------------------------------------------------------------------
-- Building
---------------------------------------------------------------------------

-- The order's segments: the chosen one reads in the text colour over a 2px
-- accent line, the others in textDim.
local function segment(label, key)
	local b = W.Button(body, label, function() Free.SetPick(key) end, { height = SEG_H })
	b.psKey = key
	b.psTip = label
	b.psTipLines = { Free.PickRule(key) }
	b:SetScript("OnEnter", W.SimpleTip)
	b:SetScript("OnLeave", W.HideTip)
	b.Bar = W.Fill(b, "accent", "OVERLAY")
	b.Bar:ClearAllPoints()
	b.Bar:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 1, 1)
	b.Bar:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -1, 1)
	b.Bar:SetHeight(2)
	return b
end

-- A route row: the number in the gutter, the title over its why line, then
-- progress, the walk, XP and zone, and the quiet flag and tick at the end.
local function newRow(q)
	local r = CreateFrame("Button", nil, body)
	r:SetHeight(ROW_H)
	W.Hover(r, 0.7)
	r.Sel = W.Tex(r, "BACKGROUND", nil, nil, -5)
	r.Sel:SetAllPoints(r)
	W.Painter(r.Sel, function(t) t:SetVertexColor(Theme.Wash("selected")) end)
	r.Bar = W.Tex(r, "ARTWORK", nil, "accent")
	r.Bar:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
	r.Bar:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
	r.Bar:SetWidth(2)
	r.Rule = W.Divider(r, false, 0.6)
	r.Rule:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", GUTTER, 0)
	r.Rule:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", 0, 0)
	r.Num = W.Text(r, "number", "textMuted")
	r.Num:SetJustifyH("RIGHT")
	r.Num:SetWidth(GUTTER - 8)
	r.Num:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -10)
	r.Title = oneLine(W.Text(r, "body", "quest"))
	r.Title:SetPoint("TOPLEFT", r, "TOPLEFT", GUTTER, -9)
	r.Why = oneLine(W.Text(r, "small", "textDim"))
	r.Why:SetPoint("TOPLEFT", r.Title, "BOTTOMLEFT", 0, -5)
	r.Count = W.Text(r, "number", "text")
	r.Count:SetJustifyH("RIGHT")
	r.Count:SetWidth(36)
	r.Track = W.ProgressLine(r, 2)
	r.Track:SetWidth(PROG_W - 44)
	r.Walk = W.Text(r, "number", "textDim")
	r.Walk:SetJustifyH("RIGHT")
	r.Walk:SetWidth(WALK_W)
	r.XP = W.Text(r, "number", "textDim")
	r.XP:SetJustifyH("RIGHT")
	r.XP:SetWidth(XP_W)
	r.Zone = oneLine(W.Text(r, "small", "place"))
	r.Zone:SetWidth(ZONE_W)
	r.Pin = W.IconButton(r, "flag", 24, nil, function() P.TogglePin(r.psQuest, r.psPinned) end, 13)
	r.Check = W.Checkbox(r, function() P.LeaveOut(r.psQuest) end)
	r:SetScript("OnClick", function() P.TogglePin(r.psQuest, r.psPinned) end)
	r:SetScript("OnEnter", questTip)
	r:SetScript("OnLeave", hideTip)
	-- A gamepad: A pins it (the row's own click), X leaves it out; its focus shows the tooltip.
	r.psPadX = function() P.LeaveOut(r.psQuest) end
	r.psPadXLabel = function() return L["Leave out"] end
	r.psOnPadFocus = function(self, on) if on then questTip(self) else hideTip(self) end end
	rows[#rows + 1] = r
	rowOf[q] = r
	return r
end

-- The line over the finished quests one NPC takes.
local function newGroup(i)
	local g = CreateFrame("Frame", nil, body)
	g:SetHeight(GROUP_H)
	g.Icon = W.Tex(g, "ARTWORK", "icon-turnin", "success")
	g.Icon:SetSize(13, 13)
	g.Icon:SetPoint("LEFT", g, "LEFT", GUTTER, -2)
	g.Text = oneLine(W.Text(g, "small", "textDim"))
	g.Text:SetPoint("LEFT", g.Icon, "RIGHT", 8, 0)
	groups[i] = g
	return g
end

-- A row of the quests left out: its title, its zone and Bring back.
local function newOutRow(q)
	local r = CreateFrame("Button", nil, body)
	r:SetHeight(OUT_H)
	W.Hover(r, 0.7)
	r.Title = oneLine(W.Text(r, "body", "textMuted"))
	r.Title:SetPoint("LEFT", r, "LEFT", GUTTER, 0)
	r.Zone = oneLine(W.Text(r, "small", "textMuted"))
	r.Zone:SetWidth(ZONE_W)
	r.Back = W.Button(r, L["Bring back"], function() P.BringBack(r.psQuest) end, { height = 24 })
	r.Back:SetPoint("RIGHT", r, "RIGHT", -8, 0)
	r.Zone:SetPoint("RIGHT", r.Back, "LEFT", -16, 0)
	r:SetScript("OnClick", function() P.BringBack(r.psQuest) end)
	r:SetScript("OnEnter", questTip)
	r:SetScript("OnLeave", hideTip)
	r.psOnPadFocus = function(self, on) if on then questTip(self) else hideTip(self) end end
	r.psPadLabel = L["Bring back"]
	outRows[#outRows + 1] = r
	outRowOf[q] = r
	return r
end

-- A heading that folds what is under it: a chevron, the heading, a count.
local function foldHeader(label)
	local h = CreateFrame("Button", nil, body)
	h:SetHeight(36)
	W.Hover(h, 0.5)
	h.Chevron = W.Tex(h, "ARTWORK", "chevron-right", "textDim")
	h.Chevron:SetSize(12, 12)
	h.Chevron:SetPoint("LEFT", h, "LEFT", GUTTER - 18, 0)
	h.Text = W.Text(h, "heading", "text")
	h.Text:SetPoint("LEFT", h, "LEFT", GUTTER, 0)
	h.Text:SetText(label)
	h.Count = W.Text(h, "number", "textMuted")
	h.Count:SetPoint("LEFT", h.Text, "RIGHT", 8, 0)
	return h
end

-- One point of the intro: a glyph in the gutter, a title, a line under it.
local function point(icon, title, text)
	local p = CreateFrame("Frame", nil, body)
	p.Icon = W.Tex(p, "ARTWORK", icon, "accent")
	p.Icon:SetSize(16, 16)
	p.Icon:SetPoint("TOPLEFT", p, "TOPLEFT", 0, -1)
	p.Title = oneLine(W.Text(p, "body", "text"))
	p.Title:SetPoint("TOPLEFT", p, "TOPLEFT", GUTTER, 0)
	p.Title:SetText(title)
	p.Text = wrapped(W.Text(p, "note", "textDim"))
	p.Text:SetPoint("TOPLEFT", p.Title, "BOTTOMLEFT", 0, -4)
	p.Text:SetText(text)
	return p
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

	-- What Free mode is.
	parts.IntroTitle = W.Text(body, "display", "text")
	parts.IntroTitle:SetText(L["Quest your own way"])
	parts.IntroLead = wrapped(W.Text(body, "note", "textDim"))
	parts.IntroLead:SetText(L["Pick up whatever quests you like. Free mode puts them in a smart order and the arrow takes you through them, one after another."])
	parts.Points = {
		point("icon-accept", L["You pick up quests"], L["Any quest, anywhere: Free mode follows your quest log, not a guide."]),
		point("sliders", L["Polestar plans the order"], L["The best trip for the walk, planned again whenever your log changes."]),
		point("icon-goto", L["The arrow leads"], L["To each objective and hand-in in turn, as in any guide."]),
	}
	parts.When = wrapped(W.Text(body, "note", "textDim"))
	parts.When:SetText(L["Good for when you're off your guide's route, questing with friends, or doing your own thing."])
	parts.BackNote = wrapped(W.Text(body, "small", "textMuted"))
	parts.BackNote:SetText(L["Back to your guide any time, from the guide window's menu or this page."])
	parts.About = foldHeader(L["What is Free mode?"])
	parts.About:SetScript("OnClick", function()
		aboutOpen = not aboutOpen
		P.Render()
	end)

	-- Start, the state while on, the way back.
	parts.Start = W.Button(body, L["Start Free mode"], function() P.Start() end, { primary = true, height = START_H, icon = "icon-freemode" })
	parts.StatusIcon = W.Tex(body, "ARTWORK", "icon-freemode", "accent")
	parts.StatusIcon:SetSize(16, 16)
	parts.Status = oneLine(W.Text(body, "body", "text"))
	parts.Back = W.Button(body, "", function() P.Back() end, { height = SEG_H, icon = "chevron-left" })

	-- Which quest first, and what the chosen order does.
	parts.PickLabel = oneLine(W.Text(body, "label", "textDim"))
	parts.PickLabel:SetText(L["Which quest first"])
	parts.Balanced = segment(L["Balanced"], "balanced")
	parts.Near = segment(L["Nearest first"], "near")
	parts.XP = segment(L["Most XP a minute first"], "xp")
	parts.Rule = oneLine(W.Text(body, "small", "textDim"))

	-- The hand-in card, an action tile (the Skin API's `tile`): the finished
	-- quests' count, the trip's time, Route.
	local h = CreateFrame("Button", nil, body)
	h:SetHeight(CARD_H)
	Theme.Skin(h, "tile")
	W.Hover(h)
	h.Icon = W.Tex(h, "ARTWORK", "icon-turnin", "accent")
	h.Icon:SetSize(18, 18)
	h.Icon:SetPoint("LEFT", h, "LEFT", 16, 0)
	h.Text = oneLine(W.Text(h, "body", "text"))
	h.Text:SetPoint("TOPLEFT", h, "TOPLEFT", 48, -13)
	h.Sub = oneLine(W.Text(h, "small", "textMuted"))
	h.Sub:SetPoint("TOPLEFT", h.Text, "BOTTOMLEFT", 0, -5)
	h.Chevron = W.Tex(h, "ARTWORK", "chevron-right", "accent")
	h.Chevron:SetSize(12, 12)
	h.Chevron:SetPoint("RIGHT", h, "RIGHT", -16, 0)
	h.Route = oneLine(W.Text(h, "label", "accent"))
	h.Route:SetPoint("RIGHT", h.Chevron, "LEFT", -6, 0)
	h.Route:SetText(L["Route"])
	h:SetScript("OnClick", function() if UI.GuideCarried then UI.GuideCarried() end end)
	h:SetScript("OnEnter", W.SimpleTip)
	h:SetScript("OnLeave", W.HideTip)
	h.psTip = L["Hand in finished quests"]
	h.psTipLines = { L["The shortest trip through the hand-ins of every finished quest in your log, in a guide of its own."] }
	parts.Handin = h

	-- The route.
	parts.RouteH = W.SectionHeader(body)
	parts.Lead = wrapped(W.Text(body, "body", "text"))
	parts.More = oneLine(W.Text(body, "small", "textMuted"))
	parts.EmptyTitle = W.Text(body, "display", "text")
	parts.EmptyTitle:SetText(L["No quests to lead to"])
	parts.EmptyNote = wrapped(W.Text(body, "note", "textDim"))
	parts.EmptyNote:SetText(L["Pick up quests and Free mode leads you to them."])

	-- The quests left out, and the quick actions that leave out many at once.
	parts.OutH = foldHeader(L["Left out"])
	parts.OutH:SetScript("OnClick", function()
		outOpen = not outOpen
		P.Render()
	end)
	parts.Zone = W.Button(body, L["Leave out a zone"], function(self) zoneMenu(self) end, { height = 24 })
	parts.Zone.psTip = L["Leave out a zone"]
	parts.Zone.psTipLines = { L["Every quest of a zone at once. Bring one back from Left out."] }
	parts.Group = W.Button(body, L["Leave out group quests"], function() Free.LeaveOutGroup() end, { height = 24 })
	parts.Group.psTip = L["Leave out group quests"]
	parts.Group.psTipLines = { L["Quests that take a group: an elite, a boss or an instance."] }
	parts.BackAll = W.Button(body, "", function() Free.BringBack() end, { height = 24 })
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

-- A route row from its entry; `full`: the columns and controls (the preview
-- beside the intro shows the title, the why and the XP alone).
local function paintRow(r, e, width, full)
	r.psQuest, r.psPinned, r.psEntry = e.quest, e.pinned, e
	r:SetWidth(width)
	r.Num:SetText(e.n)
	W.Color(r.Num, e.current and "accent" or "textMuted")
	r.Sel:SetShown(e.current)
	r.Bar:SetShown(e.current)
	r.Title:SetText(e.title)
	-- The quest log's difficulty colour, lifted to read (the painter would put the quest colour back).
	W.Uncolor(r.Title)
	local cr, cg, cb = UI.QuestDifficulty(e.level, e.plevel)
	r.Title:SetTextColor(cr, cg, cb, 1)
	r.Why:SetText(e.why or "")
	local right = width - 8
	if full then
		r.Check:ClearAllPoints()
		r.Check:SetPoint("RIGHT", r, "RIGHT", -12, 0)
		r.Check:SetChecked(true)
		r.Check:SetAlpha(QUIET)
		r.Check:Show()
		r.Pin:ClearAllPoints()
		r.Pin:SetPoint("RIGHT", r, "RIGHT", -34, 0)
		W.SetIconState(r.Pin, e.pinned, true)
		r.Pin:SetAlpha(e.pinned and 1 or QUIET)
		r.Pin:Show()
		r.Pin.psTip = e.pinned and L["Unpin"] or L["Pin to the top"]
		r.Pin.psTipLines = { L["Free mode takes this quest first, whatever the order."] }
		r.Check.psTip = L["Leave out"]
		r.Check.psTipLines = { L["In Free mode. Click to leave it out."] }
		right = width - CTRL_W
		r.Zone:ClearAllPoints()
		r.Zone:SetPoint("TOPRIGHT", r, "TOPLEFT", right, -11)
		r.Zone:SetText(e.zone or "")
		r.Zone:Show()
		right = right - ZONE_W - 12
	else
		r.Check:Hide()
		r.Pin:Hide()
		r.Zone:Hide()
	end
	r.XP:ClearAllPoints()
	r.XP:SetPoint("TOPRIGHT", r, "TOPLEFT", right, -10)
	r.XP:SetText(e.xp and format(L["%s XP"], ns.Thousands(e.xp)) or "")
	right = right - XP_W - 8
	if full then
		r.Walk:ClearAllPoints()
		r.Walk:SetPoint("TOPRIGHT", r, "TOPLEFT", right, -10)
		r.Walk:SetText(e.travel and minutes(e.travel) or "")
		r.Walk:Show()
		right = right - WALK_W - 12
		r.Track:ClearAllPoints()
		r.Track:SetPoint("TOPRIGHT", r, "TOPLEFT", right, -17)
		r.Count:ClearAllPoints()
		r.Count:SetPoint("TOPRIGHT", r.Track, "TOPLEFT", -8, 7)
		if e.ready then
			r.Count:SetText(L["Ready"])
			W.Color(r.Count, "success")
			W.Color(r.Track.Fill, "success")
			W.SetProgress(r.Track, 1, PROG_W - 44)
		elseif e.total then
			r.Count:SetText(format("%d/%d", e.done, e.total))
			W.Color(r.Count, "text")
			W.Color(r.Track.Fill, "accent")
			W.SetProgress(r.Track, e.done / e.total, PROG_W - 44)
		end
		r.Count:SetShown(e.ready or e.total ~= nil)
		r.Track:SetShown(e.ready or e.total ~= nil)
		right = right - PROG_W
	else
		r.Walk:Hide()
		r.Count:Hide()
		r.Track:Hide()
	end
	r.Title:SetWidth(max(80, right - GUTTER - 12))
	-- The why line runs under the columns too (they sit on the title's line), up to the flag and tick.
	r.Why:SetWidth(max(80, width - GUTTER - (full and CTRL_W or 8)))
	r.psPadLabel = e.pinned and L["Unpin"] or L["Pin to the top"]
	r:Show()
end

-- The route's entries: Free mode's order, numbered, with each quest's facts.
local function entries(list, byQuest, on, info)
	local plevel = ns.Compat.GetPlayerLevel and ns.Compat.GetPlayerLevel() or nil
	local pin = Free.Pinned()
	local out = {}
	for i, row in ipairs(list) do
		local q = byQuest[row.quest] or {}
		local done, total, lines = progressOf(row.quest)
		out[i] = {
			n = i, quest = row.quest, title = row.title, level = row.qlvl or q.level, plevel = plevel,
			why = Free.Reasons(list, i), ready = row.ready, done = done, total = total, lines = lines,
			travel = row.travel, xp = row.xp, zone = q.zoneName, pinned = pin == row.quest,
			current = on and i == 1 and not info.hint or false, ender = row.ender, enderName = row.enderName,
			placeZone = row.ready and row.place and row.place.map and ns.Compat.MapName(row.place.map) or nil,
		}
	end
	return out
end

local function hideAll()
	for _, f in pairs(parts) do
		if type(f) == "table" and f.Hide then f:Hide() end
	end
	for _, p in ipairs(parts.Points) do p:Hide() end
	for _, r in ipairs(rows) do r:Hide() end
	for _, g in ipairs(groups) do g:Hide() end
	for _, r in ipairs(outRows) do r:Hide() end
end

-- The intro's text, from x at y in `width` -> the y under it.
local function layIntro(x, y, width, title)
	if title then
		at(parts.IntroTitle, x, y)
		y = y + 26
	end
	parts.IntroLead:SetWidth(width)
	at(parts.IntroLead, x, y)
	y = y + parts.IntroLead:GetStringHeight() + 20
	for _, p in ipairs(parts.Points) do
		p.Text:SetWidth(width - GUTTER)
		p:SetSize(width, 18 + p.Text:GetStringHeight())
		at(p, x - GUTTER, y)
		y = y + p:GetHeight() + 14
	end
	parts.When:SetWidth(width)
	at(parts.When, x, y + 2)
	return y + 2 + parts.When:GetStringHeight() + 16
end

-- The order: its label, the segments and the line under them, from x at y -> the y under it.
local function layOrder(x, y, pick)
	parts.PickLabel:ClearAllPoints()
	parts.PickLabel:SetPoint("LEFT", body, "TOPLEFT", x, -(y + SEG_H / 2))
	parts.PickLabel:Show()
	local sx = x + math.ceil(W.TextWidth(parts.PickLabel)) + 14
	for _, b in ipairs({ parts.Balanced, parts.Near, parts.XP }) do
		paintSegment(b, b.psKey == pick)
		at(b, sx, y)
		sx = sx + b:GetWidth() + 4
	end
	parts.Rule:SetText(Free.PickRule(pick))
	at(parts.Rule, x, y + SEG_H + 8)
	shown.pick, shown.rule = pick, parts.Rule:GetText()
	return y + SEG_H + 8 + 14
end

-- The hand-in card at y, while quests are finished -> the y under it.
local function layHandin(x, y, width, ready)
	if #ready == 0 then
		shown.handin = { count = 0, shown = false }
		return y
	end
	local h = parts.Handin
	h:SetWidth(width)
	at(h, x, y)
	h.Text:SetText(format(L["Hand in finished quests (%d)"], #ready))
	local secs, stops = Free.HandinTrip()
	local sub = secs and (stops == 1 and format(L["About %s, 1 stop"], minutes(secs)) or format(L["About %s, %d stops"], minutes(secs), stops)) or ""
	h.Sub:SetText(sub)
	h.Text:ClearAllPoints()
	h.Text:SetPoint(sub ~= "" and "TOPLEFT" or "LEFT", h, sub ~= "" and "TOPLEFT" or "LEFT", 48, sub ~= "" and -13 or 0)
	h.Sub:SetShown(sub ~= "")
	anchors.handins = y
	shown.handin = { count = #ready, text = h.Text:GetText(), sub = sub, shown = true }
	return y + CARD_H + 24
end

-- The route rows from y (first..last of `list`), the finished quests one NPC
-- takes under its line -> the y under them.
local function layRoute(list, first, last, x, y, width, full)
	local gi = 0
	shown.groups = {}
	local i = first
	while i <= last do
		local e = list[i]
		-- Two or more finished quests one after another for the same NPC: its line first.
		local j = i
		if full and e.ready and e.ender then
			while j < last and list[j + 1].ready and list[j + 1].ender == e.ender do j = j + 1 end
		end
		if j > i then
			gi = gi + 1
			local g = groups[gi] or newGroup(gi)
			g:SetWidth(width)
			local name = e.enderName or ""
			g.Text:SetText(format(L["Hand in to %s"], hex("npc") .. name .. "|r") .. (e.placeZone and ("  \194\183  " .. hex("place") .. e.placeZone .. "|r") or ""))
			at(g, x, y)
			y = y + GROUP_H
			local qs = {}
			for k = i, j do qs[#qs + 1] = list[k].quest end
			shown.groups[#shown.groups + 1] = { npc = name, quests = qs }
		end
		for k = i, j do
			local r = rowOf[list[k].quest] or newRow(list[k].quest)
			paintRow(r, list[k], width, full)
			at(r, x, y)
			y = y + ROW_H
			local s = list[k]
			shown[#shown + 1] = { n = s.n, quest = s.quest, title = s.title, why = s.why, current = s.current, pinned = s.pinned, ready = s.ready,
				progress = s.ready and "ready" or (s.total and format("%d/%d", s.done, s.total)) or nil, travel = s.travel, xp = s.xp, zone = s.zone }
		end
		i = j + 1
	end
	return y
end

-- The quests left out: a folding header with the quick actions at its
-- right, then (open) a row each -> the y under it.
local function layOut(x, y, width, quests)
	local out, zones, group = {}, Free.Zones(), 0
	for _, q in ipairs(quests) do
		if q.out then out[#out + 1] = q end
		if q.group and not q.out then group = group + 1 end
	end
	anchors.out = y
	local h = parts.OutH
	h:SetWidth(width)
	h.Count:SetText(#out > 0 and tostring(#out) or "")
	h.Chevron:SetTexture(Theme.Media(#out > 0 and (outOpen and "chevron-down" or "chevron-right") or "chevron-right"))
	h.Chevron:SetShown(#out > 0)
	h:EnableMouse(#out > 0)
	at(h, x, y)
	-- The quick actions, right-aligned on the header's line.
	local rx = x + width
	local function right(b)
		rx = rx - b:GetWidth()
		at(b, rx, y + 6)
		rx = rx - 8
	end
	enable(parts.Group, group > 0)
	right(parts.Group)
	enable(parts.Zone, #zones > 0)
	right(parts.Zone)
	if #out > 0 then
		W.SetButtonText(parts.BackAll, format(L["Bring back left-out quests (%d)"], #out))
		right(parts.BackAll)
	end
	shown.actions = { zones = #zones, group = group, out = #out }
	shown.out, shown.outOpen = {}, outOpen and #out > 0
	y = y + 36 + 4
	local rule = parts.OutRule
	if not rule then
		rule = W.Divider(body)
		parts.OutRule = rule
	end
	rule:ClearAllPoints()
	rule:SetPoint("TOPLEFT", body, "TOPLEFT", x + GUTTER, -y)
	rule:SetWidth(width - GUTTER)
	rule:Show()
	for i, q in ipairs(out) do
		shown.out[i] = q.quest
		if outOpen then
			local r = outRowOf[q.quest] or newOutRow(q.quest)
			r.psQuest, r.psEntry = q.quest, { quest = q.quest, zone = q.zoneName, lines = select(3, progressOf(q.quest)) }
			r:SetWidth(width)
			r.Title:SetText(q.title)
			r.Title:SetWidth(max(80, width - GUTTER - ZONE_W - 140))
			r.Zone:SetText(q.zoneName or "")
			at(r, x, y + 4)
			y = y + OUT_H
		end
	end
	return y + 16
end

-- "What is Free mode?", folded, and the intro under it while open -> the y under it.
local function layAbout(x, y, width)
	anchors.about = y
	local h = parts.About
	h:SetWidth(width + GUTTER)
	h.Chevron:SetTexture(Theme.Media(aboutOpen and "chevron-down" or "chevron-right"))
	at(h, x - GUTTER, y)
	y = y + 40
	if aboutOpen then
		y = layIntro(x, y + 4, width, false)
		parts.BackNote:SetWidth(width)
		at(parts.BackNote, x, y - 6)
		y = y + parts.BackNote:GetStringHeight() + 10
	end
	return y
end

function P.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	for k in pairs(anchors) do anchors[k] = nil end
	W.ShellTitle(hub, L["Free mode"], L["Your own quests, planned for you."])
	local MW = mainWidth()
	body:SetWidth(MW)
	local width = MW - PAD * 2
	local on = Free.IsOn()
	local mode = on and "on" or (Free.Used() and "ready" or "intro")
	local pick = Free.Pick()
	local quests = Free.Quests()
	local byQuest = {}
	for _, q in ipairs(quests) do byQuest[q.quest] = q end
	local list, info = Free.Route()
	info = info or {}
	local route = entries(list or {}, byQuest, on, info)
	local ready = ns.Handins and ns.Handins.Ready() or {}
	hideAll()
	shown.mode, shown.on, shown.count = mode, on, #route
	local y = 24

	if mode == "intro" then
		-- Two columns: what it is and Start on the left, the player's own
		-- quests in Free mode's order on the right.
		local LW = floor(width * 0.5)
		local RX, RW = PAD + LW + 48, width - LW - 48
		anchors.about = 0
		local ly = layIntro(PAD, y, LW, true)
		W.SetButtonText(parts.Start, L["Start Free mode"])
		at(parts.Start, PAD, ly + 4)
		ly = ly + 4 + START_H + 12
		parts.BackNote:SetWidth(LW)
		at(parts.BackNote, PAD, ly)
		ly = ly + parts.BackNote:GetStringHeight()
		local H = parts.RouteH
		H:SetWidth(RW)
		W.SetSection(H, L["Your quests in Free mode"], #route > 0 and #route or nil)
		at(H, RX, y - 18)
		anchors.route = 0
		local ry = y + 34
		if #route == 0 then
			at(parts.EmptyTitle, RX, ry)
			parts.EmptyNote:SetWidth(RW)
			at(parts.EmptyNote, RX, ry + 30)
			ry = ry + 30 + parts.EmptyNote:GetStringHeight()
			shown.empty = true
		else
			local first = route[1]
			parts.Lead:SetWidth(RW)
			parts.Lead:SetText(#route == 1 and format(L["With your quest, Free mode starts with %s."], hex("quest") .. first.title .. "|r")
				or format(L["With your %d quests, Free mode starts with %s."], #route, hex("quest") .. first.title .. "|r"))
			at(parts.Lead, RX, ry)
			ry = ry + parts.Lead:GetStringHeight() + 10
			local last = min(#route, PREVIEW_ROWS)
			ry = layRoute(route, 1, last, RX - GUTTER, ry, RW + GUTTER, false)
			if #route > last then
				parts.More:SetText(format(L["and %d more"], #route - last))
				at(parts.More, RX, ry + 10)
				ry = ry + 10 + 14
				shown.more = #route - last
			end
			shown.lead = parts.Lead:GetText()
		end
		y = max(ly, ry) + 32
		y = layHandin(PAD, y, width, ready)
		shown.start, shown.intro = L["Start Free mode"], true
	else
		if on then
			-- Free mode is on: what it follows, and the way back.
			at(parts.StatusIcon, PAD, y + 6)
			parts.Status:SetText(#route == 1 and L["Free mode is on \194\183 following 1 quest"] or format(L["Free mode is on \194\183 following %d quests"], #route))
			parts.Status:ClearAllPoints()
			parts.Status:SetPoint("LEFT", body, "TOPLEFT", PAD + GUTTER, -(y + 14))
			parts.Status:Show()
			local back = Free.ReturnTitle()
			W.SetButtonText(parts.Back, back and format(L["Back to %s"], back) or L["Stop Free mode"])
			at(parts.Back, PAD + width - parts.Back:GetWidth(), y)
			shown.status, shown.back = parts.Status:GetText(), parts.Back.Label:GetText()
			y = y + SEG_H + 20
			y = layOrder(PAD, y, pick) + 24
		else
			-- Started before: Start, the order beside it.
			W.SetButtonText(parts.Start, L["Start Free mode"])
			at(parts.Start, PAD, y)
			shown.start = L["Start Free mode"]
			y = layOrder(PAD + parts.Start:GetWidth() + 32, y + (START_H - SEG_H) / 2, pick) + 28
		end
		y = layHandin(PAD, y, width, ready)
		local H = parts.RouteH
		H:SetWidth(width)
		W.SetSection(H, on and L["Your route"] or L["First up"], #route > 0 and #route or nil)
		at(H, PAD, y - 18)
		anchors.route = max(0, y - 24)
		y = y + 34
		if #route == 0 then
			at(parts.EmptyTitle, PAD, y)
			parts.EmptyNote:SetWidth(width)
			at(parts.EmptyNote, PAD, y + 30)
			y = y + 30 + parts.EmptyNote:GetStringHeight() + 20
			shown.empty = true
		else
			local last = on and #route or min(#route, PREVIEW_ROWS)
			y = layRoute(route, 1, last, PAD - GUTTER, y, width + GUTTER, true)
			if #route > last then
				parts.More:SetText(format(L["and %d more"], #route - last))
				at(parts.More, PAD, y + 10)
				y = y + 10 + 14
				shown.more = #route - last
			end
			y = y + 24
		end
		y = layOut(PAD - GUTTER, y, width + GUTTER, quests)
		y = layAbout(PAD, y + 8, width)
		shown.about = aboutOpen
	end
	W.SetScrollContent(scroll, y + 24)
end

-- What the page shows: its layout (mode: intro | ready | on), Start or the
-- status and Back, the order and its line, the hand-in card, the route rows
-- in order (the array part: { n, quest, title, why, current, pinned, ready,
-- progress, travel, xp, zone }), the NPC lines, the quests left out.
function P.Shown() return shown end
P.rows, P.groups, P.outRows = rows, groups, outRows
P.parts = parts

---------------------------------------------------------------------------
-- The sidebar: the page's sections
---------------------------------------------------------------------------

function P.Nav()
	local items = {}
	if Free.IsOn() or Free.Used() then
		local list = Free.Route()
		items[#items + 1] = { key = "route", label = Free.IsOn() and L["Your route"] or L["First up"], icon = "icon-freemode", count = #(list or {}) }
		local ready = ns.Handins and ns.Handins.Ready() or {}
		if #ready > 0 then items[#items + 1] = { key = "handins", label = L["Hand-ins"], icon = "icon-turnin", count = #ready } end
		local out = #Free.LeftOut()
		if out > 0 then items[#items + 1] = { key = "out", label = L["Left out"], icon = "close", count = out } end
		items[#items + 1] = { key = "about", label = L["About Free mode"], icon = "info" }
	else
		items[#items + 1] = { key = "about", label = L["About Free mode"], icon = "info" }
		items[#items + 1] = { key = "route", label = L["Your quests"], icon = "icon-freemode", count = #(Free.Route() or {}) }
	end
	local active = navKey
	local found = false
	for _, it in ipairs(items) do if it.key == active then found = true end end
	return items, found and active or items[1].key
end

-- A section of the sidebar: open it if it folds, then scroll to it.
function P.Jump(key)
	navKey = key
	if key == "out" then outOpen = true end
	if key == "about" and (Free.IsOn() or Free.Used()) then aboutOpen = true end
	if UI.Picker and UI.Picker.Render then UI.Picker.Render() else P.Render() end
	if scroll then W.ScrollTo(scroll, anchors[key] or 0) end
end

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
