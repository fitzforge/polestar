-- The Free mode section of the main window (under Guides; its door is
-- Polestar/UI/FreeMode.lua, which loads this folder when the section first
-- shows). Three pages, the sidebar's three entries, the same whether Free
-- mode is on or off (P.Nav, P.Open):
--
--   main     where Free mode is turned on and off: the hero (Hero.lua), the
--            player's own first three quests in Free mode's order as stars
--            on a dotted path. Off: Activate Free mode at its centre and how
--            to turn it off again. On: "Free mode is on · following N
--            quests" over Turn off Free mode (Free.Stop: back to the guide
--            the player came from) and the guide that is, as a plain line.
--            How it works is the About page's.
--   quests   Your quests: whether Free mode is on (off: Activate beside it),
--            which quest first, the hand-in card while quests are finished
--            (their count, the trip's time, Route: UI.GuideCarried), then
--            every quest numbered in Free mode's order (on: the plan the
--            arrow follows, Free.Route; off: the plan it would make), the
--            quest it leads to now marked, each row its title in its
--            difficulty colour, why it is there, its progress, the walk, its
--            XP and zone; the finished ones one NPC takes under that NPC's
--            name; then the quests left out folded under their own header
--            with Bring back, and the quick actions (leave out a zone, the
--            quests that take a group)
--   about    About Free mode (About.lua): how it works in four drawn beats,
--            when to use it, how to get back to a guide
--
-- A row's tick leaves it out, its flag pins it first (Free.Pin); a click on
-- the row pins it too. Hovering a row, or a gamepad's focus on it, shows the
-- game's quest tooltip with Polestar's lines (where, why, the objectives).
--
-- A gamepad: the D-pad moves between rows, A pins the row (a left-out row:
-- brings it back), X leaves it out (UI/Picker.lua hands X to psPadX).
--
--   Free.Page.Build(parent, hub) ; Free.Page.Render() ; Free.Page.Refresh()
--   Free.Page.Nav() -> items, page ; Free.Page.Open(page)   -- the sidebar
--   Free.Page.SetPage(page) ; Free.Page.Current() -> page   -- without a draw
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
local PREVIEW_ROWS = 3 -- the quests the intro shows
local QUIET = 0.55 -- a row's tick and flag at rest
local ZONE_W, XP_W, WALK_W, TRACK_W, CTRL_W = 124, 72, 52, 40, 60
local COUNT_GAP = 8 -- between a row's progress count and its line

local root, hub, scroll, body
local parts = {}
-- Route and left-out rows, one frame per quest (a pin reorders the route
-- under a gamepad's focus: the focus stays on its quest); every frame made
-- is in rows / outRows too.
local rows, groups, outRows = {}, {}, {}
local rowOf, outRowOf = {}, {}
local shown = {}
local outOpen = false
-- The page shown: "main" (on and off, Hero.lua), "quests" (Your quests), "about" (About.lua).
local PAGES = { main = true, quests = true, about = true }
local page = "main"
local countW = 36 -- the progress count's width: its longest text, measured (measureCount)

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

function P.Stop()
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
		local why = e.whyAll or e.why
		if why then lines[#lines + 1] = { why, Theme.TipColor("textDim") } end
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
	r.Track = W.ProgressLine(r, 2)
	r.Track:SetWidth(TRACK_W)
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

	-- Activate: the hero's centrepiece (Hero.lua), and the one Your quests and
	-- About show while off; Turn off, the hero's centrepiece while on.
	parts.Start = W.Button(body, L["Activate Free mode"], function() P.Start() end, { primary = true, height = START_H, icon = "icon-freemode" })
	parts.Activate = W.Button(body, L["Activate Free mode"], function() P.Start() end, { primary = true, height = START_H, icon = "icon-freemode" })
	parts.Stop = W.Button(body, L["Turn off Free mode"], function() P.Stop() end, { height = START_H, icon = "close" })
	-- Your quests: whether Free mode is on.
	parts.StatusIcon = W.Tex(body, "ARTWORK", "icon-freemode", "accent")
	parts.StatusIcon:SetSize(16, 16)
	parts.Status = oneLine(W.Text(body, "body", "text"))

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
	parts.Measure = W.Text(body, "number", "text")
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

-- A route row from its entry: the number, the title over its why line, the
-- columns and the flag and tick.
local function paintRow(r, e, width)
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
	local right = width - CTRL_W
	r.Zone:ClearAllPoints()
	r.Zone:SetPoint("TOPRIGHT", r, "TOPLEFT", right, -11)
	r.Zone:SetText(e.zone or "")
	r.Zone:Show()
	right = right - ZONE_W - 12
	r.XP:ClearAllPoints()
	r.XP:SetPoint("TOPRIGHT", r, "TOPLEFT", right, -10)
	r.XP:SetText(e.xp and format(L["%s XP"], ns.Thousands(e.xp)) or "")
	right = right - XP_W - 8
	r.Walk:ClearAllPoints()
	r.Walk:SetPoint("TOPRIGHT", r, "TOPLEFT", right, -10)
	r.Walk:SetText(e.travel and minutes(e.travel) or "")
	r.Walk:Show()
	right = right - WALK_W - 12
	r.Track:ClearAllPoints()
	r.Track:SetPoint("TOPRIGHT", r, "TOPLEFT", right, -17)
	r.Count:ClearAllPoints()
	r.Count:SetWidth(countW)
	r.Count:SetPoint("TOPRIGHT", r.Track, "TOPLEFT", -COUNT_GAP, 7)
	if e.ready then
		r.Count:SetText(L["Ready"])
		W.Color(r.Count, "success")
		W.Color(r.Track.Fill, "success")
		W.SetProgress(r.Track, 1, TRACK_W)
	elseif e.total then
		r.Count:SetText(format("%d/%d", e.done, e.total))
		W.Color(r.Count, "text")
		W.Color(r.Track.Fill, "accent")
		W.SetProgress(r.Track, e.done / e.total, TRACK_W)
	end
	r.Count:SetShown(e.ready or e.total ~= nil)
	r.Track:SetShown(e.ready or e.total ~= nil)
	right = right - (countW + COUNT_GAP + TRACK_W)
	r.Title:SetWidth(max(80, right - GUTTER - 12))
	-- The why line runs under the columns too (they sit on the title's line), up to the flag and tick.
	r.Why:SetWidth(max(80, width - GUTTER - CTRL_W))
	r.psPadLabel = e.pinned and L["Unpin"] or L["Pin to the top"]
	r:Show()
end

-- The why lines of the rows shown (the first `visible`): only what tells a
-- row from its neighbours. A reason every shown row has goes (the first row
-- keeps its strongest), "ready to hand in" never stands on a row whose
-- progress already says Ready, and two at most.
local MAX_WHY = 2
local function whyLines(list, visible)
	local per, seen = {}, {}
	for i = 1, visible do
		local l = {}
		for _, r in ipairs(Free.ReasonList(list, i)) do
			if not (r.key == "ready" and list[i].ready) then
				l[#l + 1] = r.text
				seen[r.text] = (seen[r.text] or 0) + 1
			end
		end
		per[i] = l
	end
	local out = {}
	for i = 1, visible do
		local keep = {}
		for k, text in ipairs(per[i]) do
			local everywhere = visible > 1 and seen[text] == visible
			if (not everywhere or (i == 1 and k == 1)) and #keep < MAX_WHY then keep[#keep + 1] = text end
		end
		out[i] = #keep > 0 and table.concat(keep, " \194\183 ") or nil
	end
	return out
end

-- The route's entries: Free mode's order, numbered, with each quest's facts;
-- `visible`: how many of them the page shows (their why lines compare them).
local function entries(list, byQuest, on, info, visible)
	local plevel = ns.Compat.GetPlayerLevel and ns.Compat.GetPlayerLevel() or nil
	local pin = Free.Pinned()
	local why = whyLines(list, min(visible, #list))
	local out = {}
	for i, row in ipairs(list) do
		local q = byQuest[row.quest] or {}
		local done, total, lines = progressOf(row.quest)
		out[i] = {
			n = i, quest = row.quest, title = row.title, level = row.qlvl or q.level, plevel = plevel,
			why = why[i], whyAll = Free.Reasons(list, i), ready = row.ready, done = done, total = total, lines = lines,
			travel = row.travel, xp = row.xp, zone = q.zoneName, pinned = pin == row.quest,
			current = on and i == 1 and not info.hint or false, ender = row.ender, enderName = row.enderName,
			placeZone = row.ready and row.place and row.place.map and ns.Compat.MapName(row.place.map) or nil,
		}
	end
	return out
end

local function hideAll()
	Free.Hero.Hide()
	if Free.About then Free.About.Hide() end
	for _, f in pairs(parts) do
		if type(f) == "table" and f.Hide then f:Hide() end
	end
	for _, r in ipairs(rows) do r:Hide() end
	for _, g in ipairs(groups) do g:Hide() end
	for _, r in ipairs(outRows) do r:Hide() end
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
	shown.handin = { count = #ready, text = h.Text:GetText(), sub = sub, shown = true }
	return y + CARD_H + 24
end

-- The route rows from y (first..last of `list`), the finished quests one NPC
-- takes under its line -> the y under them.
local function layRoute(list, first, last, x, y, width)
	local gi = 0
	shown.groups = {}
	local i = first
	while i <= last do
		local e = list[i]
		-- Two or more finished quests one after another for the same NPC: its line first.
		local j = i
		if e.ready and e.ender then
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
			paintRow(r, list[k], width)
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

-- The progress count's width: the widest of "Ready" and a count at its longest
-- ("888/888"), in the look's own number font, so no look or language cuts it.
local function measureCount()
	local w = 0
	for _, s in ipairs({ L["Ready"], "888/888" }) do w = max(w, W.TextWidth(parts.Measure, s)) end
	countW = ceil(w) + 2
end

local function statusText(n)
	return n == 1 and L["Free mode is on \194\183 following 1 quest"] or format(L["Free mode is on \194\183 following %d quests"], n)
end

-- Main: the hero (Hero.lua), its button Activate off and Turn off on -> the y under it.
local function layMain(on, route, y, width)
	local c = { body = body, x = PAD, y = y, width = width, route = route, on = on, shown = shown }
	if on then
		local back = Free.ReturnTitle()
		c.button, c.label, c.status = parts.Stop, L["Turn off Free mode"], statusText(#route)
		c.note = back and format(L["Takes you back to %s"], back) or L["Leaves you with no guide open: pick one under Guides."]
	else
		c.button, c.label = parts.Start, L["Activate Free mode"]
		c.note = L["Turn it off any time, here or from the guide window's menu."]
	end
	return Free.Hero.Lay(c)
end

-- Your quests: whether Free mode is on (off: Activate beside it), the order,
-- the hand-in card, the route, the quests left out -> the y under them.
local function layQuests(on, route, quests, ready, y, width)
	measureCount()
	at(parts.StatusIcon, PAD, y + 6)
	local room = width - GUTTER
	if not on then
		local b = parts.Activate
		at(b, PAD + width - b:GetWidth(), y - 2)
		room = room - b:GetWidth() - 16
		shown.start = L["Activate Free mode"]
	end
	parts.Status:SetText(on and statusText(#route) or L["Free mode is off \194\183 the order it would take"])
	parts.Status:SetWidth(room)
	parts.Status:ClearAllPoints()
	parts.Status:SetPoint("LEFT", body, "TOPLEFT", PAD + GUTTER, -(y + 14))
	parts.Status:Show()
	shown.status = parts.Status:GetText()
	y = y + SEG_H + 20
	y = layOrder(PAD, y, Free.Pick()) + 24
	y = layHandin(PAD, y, width, ready)
	local H = parts.RouteH
	H:SetWidth(width)
	W.SetSection(H, L["Your quests"], #route > 0 and #route or nil)
	at(H, PAD, y - 18)
	y = y + 34
	if #route == 0 then
		at(parts.EmptyTitle, PAD, y)
		parts.EmptyNote:SetWidth(width)
		at(parts.EmptyNote, PAD, y + 30)
		y = y + 30 + parts.EmptyNote:GetStringHeight() + 20
		shown.empty = true
	else
		y = layRoute(route, 1, #route, PAD - GUTTER, y, width + GUTTER) + 24
	end
	return layOut(PAD - GUTTER, y, width + GUTTER, quests)
end

function P.Render()
	if not root then return end
	for k in pairs(shown) do shown[k] = nil end
	W.ShellTitle(hub, L["Free mode"], L["Your own quests, planned for you."])
	local MW = mainWidth()
	body:SetWidth(MW)
	local width = MW - PAD * 2
	local on = Free.IsOn()
	hideAll()
	shown.page, shown.on = page, on
	local y = 24
	if page == "about" then
		y = Free.About.Lay({ body = body, x = PAD, y = y, width = width, on = on, start = parts.Activate, shown = shown })
		W.SetScrollContent(scroll, y + 24)
		return
	end
	local quests = Free.Quests()
	local byQuest = {}
	for _, q in ipairs(quests) do byQuest[q.quest] = q end
	local list, info = Free.Route()
	list, info = list or {}, info or {}
	local route = entries(list, byQuest, on, info, page == "quests" and #list or PREVIEW_ROWS)
	shown.count = #route
	if page == "main" then
		y = layMain(on, route, y, width)
	else
		y = layQuests(on, route, quests, ns.Handins and ns.Handins.Ready() or {}, y, width)
	end
	W.SetScrollContent(scroll, y + 24)
end

-- What the page shows: which page (page: main | quests | about) and whether
-- Free mode is on; main: the hero's (Hero.lua: start or status, stop and
-- note); quests: the status (and start while off), the order and its line,
-- the hand-in card, the route rows in order (the array part: { n, quest,
-- title, why, current, pinned, ready, progress, travel, xp, zone }), the NPC
-- lines, the quests left out; about: About.lua's.
function P.Shown() return shown end
P.rows, P.groups, P.outRows = rows, groups, outRows
P.parts = parts

---------------------------------------------------------------------------
-- The sidebar: the three pages
---------------------------------------------------------------------------

function P.Nav()
	return {
		{ key = "main", label = L["Main page"], icon = "house" },
		{ key = "quests", label = L["Your quests"], icon = "icon-freemode", count = #(Free.Route() or {}) },
		{ key = "about", label = L["About Free mode"], icon = "info" },
	}, page
end

function P.Current() return page end

-- The page to show next, without drawing (UI.ShowFreeMode before the hub draws).
function P.SetPage(key)
	page = PAGES[key] and key or "main"
	if scroll then W.ScrollTo(scroll, 0) end
end

-- A page of the sidebar: shown from its top.
function P.Open(key)
	P.SetPage(key)
	if UI.Picker and UI.Picker.Render then UI.Picker.Render() else P.Render() end
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
