-- The step browser: every step of the guide as a square card in a scrolling
-- list, in the guide window in place of the step card (docs/DESIGN.md, "The
-- Guide Window"; docs/ARCHITECTURE.md, "Step browser"). A click on the step
-- number opens it; a second click, a click on a card or Escape closes it.
--
--   1 · Deputy Willem                        ✓    a finished step: one muted line
--   2 · Marshal McBride                   LIVE    the live step: accent header and bar
--     [talk]  Talk to Marshal McBride
--     [turn]  Turn in "A Threat Within"
--     [accept] Accept "Kobold Camp Cleanup"
--   3 · Kobold camp
--     [goto]  Go to Kobold camp
--     ...     +2 more                             six lines at most
--
-- A card's lines are the step's people and goals in written order, worded as
-- the step card words them (UI.GoalLine, names in their kind's colour); done
-- goals are ticked and muted, done and skipped steps muted whole, the step on
-- screen on a lifted ground. A click looks at that step (GuideFrame.LookAt)
-- and returns to the card. It opens at the step on screen and is as tall as
-- its cards, up to the window's height cap. Works in every look and in
-- compact mode. A profession guide's skill ranges head their steps ("First
-- Aid 40-75", the range the player's skill is in in the accent colour).
--
-- GuideFrame.Layout asks UI.StepList.Place(body, steps) for the frame and
-- stacks it with UI.StepList.Layout(width, room); the step number's click
-- calls UI.StepList.Toggle().

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, ipairs = math.floor, math.max, math.min, ipairs

local SL = { rows = {}, n = 0, open = false }
UI.StepList = SL

local PAD = 14 -- the guide window's side padding
local IN = PAD - 4 -- a card's inset from the window's edges
local GAP = 4 -- between cards
local PX, PT, PB = 8, 6, 7 -- a card's padding: sides, top, bottom
local TAB_H = 14 -- the "N · title" line
local ONE_H = 20 -- a finished step's one line
local MIN_H = 120 -- the list's least height
local GLYPH = 13
local MAX_LINES = 6 -- goal lines a card shows; the rest is one "+N more" line
local LINE_GAP = 2
local HEAD_H = 16 -- a skill range's heading over its first card
local GROUP_VERB = { npc = "talk", object = "interact", here = "goto" } -- as the step card's

local function GF() return UI.GuideFrame end
local function transparent() return ns.Get("ui.style") == "transparent" end
-- A string that follows the window's style (outlined when transparent).
local function T(parent, role, color) return GF().Text(parent, role, color) end

function SL.On() return SL.open end

-- Open or close the list; the window draws again either way.
function SL.Toggle(on)
	if on == nil then on = not SL.open end
	SL.open = on and true or false
	SL.sig, SL.opened = nil, SL.open
	local G = GF()
	if G and G.Render then G.Render() end
end

local function build(parent)
	local f = CreateFrame("Frame", nil, parent)
	f:SetHeight(MIN_H)
	f:Hide()
	SL.frame = f
	-- Escape closes it: the game hides the frame, and a hide the layout did
	-- not ask for closes the list. A parent's hide (Alt-Z, combat, the window
	-- hidden) runs this too with the list itself still shown: the list hides
	-- its own frame as well, so the next Escape is not spent on a list nobody
	-- sees, and comes back with the window (its OnShow draws it again).
	-- Under the gamepad UI Escape does not reach it: the step number closes it.
	_G.PolestarStepList = f
	ns.CloseOnEscape("PolestarStepList")
	f:SetScript("OnHide", function(self)
		if SL.placing or not SL.wantShown then return end
		if self:IsShown() then
			SL.placing = true
			self:Hide()
			SL.placing = false
		else
			SL.wantShown = false
			SL.Toggle(false)
		end
	end)
	SL.scroll = W.Scroll(f)
	SL.scroll:SetAllPoints(f)
end

-- The list's frame in `parent` (the window's body), shown while it is open
-- and the window shows a guide's steps. -> frame | nil while closed
function SL.Place(parent, steps)
	-- The guide finished or another one opened: the list closes, so the next
	-- guide opens on its step card.
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	local id = guide and guide.id or false
	if SL.open and (not steps or id ~= SL.guide) then SL.open, SL.sig = false, nil end
	SL.guide = id
	local on = SL.open and steps and true or false
	if not SL.frame then
		if not on then return nil end
		build(parent)
	end
	SL.wantShown = on
	-- Drawn while the window is hidden: the frame stays hidden until it shows.
	SL.placing = true
	SL.frame:SetShown(on and parent:IsVisible())
	SL.placing = false
	return on and SL.frame or nil
end

local function row(i)
	local r = SL.rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, SL.scroll.Child)
	r:RegisterForClicks("LeftButtonUp")
	-- The card's ground and, over it, the lift of the step on screen.
	r.Card = r:CreateTexture(nil, "BACKGROUND", nil, -1)
	r.Card:SetTexture(Theme.Media("white"))
	r.Card:SetAllPoints(r)
	W.Painter(r.Card, function(t) t:SetVertexColor(Theme.Wash("chip")) end)
	r.View = r:CreateTexture(nil, "BACKGROUND", nil, 0)
	r.View:SetTexture(Theme.Media("white"))
	r.View:SetAllPoints(r)
	W.Painter(r.View, function(t) t:SetVertexColor(Theme.Wash("hover")) end)
	r.View:Hide()
	W.Hover(r)
	-- The live step's 2px selection bar.
	r.Mark = W.Tex(r, "ARTWORK", nil, "accent")
	r.Mark:SetWidth(2)
	r.Mark:SetPoint("TOPLEFT", r, "TOPLEFT", 0, 0)
	r.Mark:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 0)
	r.Mark:Hide()
	r.Tab = T(r, "caption", "textMuted")
	r.Tab:SetJustifyH("LEFT")
	r.Tab:SetWordWrap(false)
	r.Tab:SetMaxLines(1)
	r.Live = T(r, "caption", "accent")
	r.Live:SetText(string.upper(L["Live"]))
	r.Live:Hide()
	r.G = {} -- the goal lines, made as a step needs them
	-- A skill range's heading, over the card (outside it).
	r.Head = T(r, "caption", "textMuted")
	r.Head:SetJustifyH("LEFT")
	r.Head:SetWordWrap(false)
	r.Head:SetMaxLines(1)
	r.Head:Hide()
	r.More = T(r, "small", "textMuted")
	r.More:SetJustifyH("LEFT")
	r.More:Hide()
	r.Tick = W.Tex(r, "ARTWORK", "check", "success")
	r.Tick:SetSize(12, 12)
	r.Tick:Hide()
	r:SetScript("OnClick", function(self)
		if not self.psIndex then return end
		GF().LookAt(self.psIndex)
		SL.Toggle(false)
	end)
	r:SetScript("OnEnter", function(self)
		local G = GF()
		W.Tooltip(self, G.TooltipAnchor(), self.psSummary or "", { { L["Click to jump to this step"], Theme.Accent() } })
		G.HoverIn()
	end)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	SL.rows[i] = r
	return r
end

-- Card r's goal line j: the kind glyph and its line, wrapping.
local function line(r, j)
	local g = r.G[j]
	if g then return g end
	g = {}
	g.Icon = r:CreateTexture(nil, "ARTWORK")
	g.Icon:SetSize(GLYPH, GLYPH)
	g.Text = T(r, "label", "text")
	g.Text:SetWordWrap(true)
	g.Text:SetMaxLines(3)
	g.Text:SetJustifyH("LEFT")
	g.Text:SetJustifyV("TOP")
	r.G[j] = g
	return g
end

-- The step's people (npc and object groups) each before their goals, in
-- written order; without groups its goals.
local function entries(v)
	local list = {}
	if #v.groups > 0 then
		for _, grp in ipairs(v.groups) do
			local any, open = false, false
			for _, gi in ipairs(grp.goals or {}) do
				local goal = v.goals[gi]
				if goal and goal.status ~= "na" and not goal.folded then
					if not any and (grp.kind == "npc" or grp.kind == "object") then
						any = { psPerson = grp }
						list[#list + 1] = any
					end
					any = any or true
					list[#list + 1] = goal
					if goal.status ~= "done" and goal.status ~= "skipped" then open = true end
				end
			end
			if type(any) == "table" then any.psDone = not open end
		end
	else
		for _, goal in ipairs(v.goals) do
			if goal.status ~= "na" and not goal.folded then list[#list + 1] = goal end
		end
	end
	return list
end

-- Paint card r from step i's view v. -> a key of what it says
local function fillRow(r, v, i, live, at)
	local gone = v.status == "done" or v.status == "skipped" or v.skipped == true
	r.psIndex = i
	r.psSummary = UI.StepSummary(v)
	-- A finished step (not the one on screen) is one muted line.
	local one = gone and i ~= at
	r.psOne = one
	local no = UI.StepNo(i)
	local title = (v.title and v.title ~= "") and v.title or string.format(L["Step %d"], no)
	r.Tab:SetText(no .. " \194\183 " .. title)
	W.Color(r.Tab, gone and "textMuted" or (i == live and "accent" or "textMuted"))
	r.Live:SetShown(i == live and not one)
	local n, more, key = 0, 0, {}
	-- A first goal that says the title draws no line, as on the step card.
	local said = false
	for _, goal in ipairs(entries(v)) do
		if n >= MAX_LINES then
			more = more + 1
		elseif goal.psPerson then
			n = n + 1
			local g, grp = line(r, n), goal.psPerson
			local name = UI.GroupName(v, grp)
			g.Icon:SetTexture(goal.psDone and Theme.Media("check") or Theme.VerbIcon(GROUP_VERB[grp.kind]))
			W.Color(g.Icon, goal.psDone and "success" or (gone and "textMuted" or "textDim"), (goal.psDone and gone) and 0.6 or 1)
			local text = (gone or goal.psDone) and name or ("|c" .. Theme.Hex(grp.kind) .. name .. "|r")
			if grp.kind == "npc" then text = L["Talk to"] .. " " .. text end
			g.Text:SetText(text)
			W.Color(g.Text, (gone or goal.psDone) and "textMuted" or "text")
			key[n] = text
		elseif n == 0 and not said and v.title and v.title ~= "" and not UI.GoalProgress(goal) and not UI.GoalBar(goal)
			and UI.PlainGoalText(UI.ReadingGoal(v, goal)) == v.title then
			said = true
		else
			n = n + 1
			goal = UI.ReadingGoal(v, goal)
			local g = line(r, n)
			local done = goal.status == "done"
			local off = gone or done or goal.status == "skipped" or goal.dismissed
			g.Icon:SetTexture(done and Theme.Media("check") or (goal.dismissed and Theme.Media("skip")) or Theme.VerbIcon(goal.t))
			W.Color(g.Icon, done and "success" or (off and "textMuted" or "textDim"), (done and gone) and 0.6 or 1)
			local text = (gone and not done) and UI.PlainGoalText(goal) or UI.GoalLine(goal)
			g.Text:SetText(text)
			W.Color(g.Text, off and "textMuted" or "text")
			key[n] = text
		end
	end
	-- A step without goals: its summary under its first verb (none when the
	-- title already says its one goal).
	if n == 0 and not said then
		n = 1
		local g = line(r, 1)
		g.Icon:SetTexture(Theme.VerbIcon(UI.FirstVerb(v)))
		W.Color(g.Icon, gone and "textMuted" or "textDim")
		g.Text:SetText(r.psSummary)
		W.Color(g.Text, gone and "textMuted" or "text")
		key[1] = r.psSummary
	end
	if one then n, more, key = 0, 0, { "one" } end
	for j = 1, #r.G do
		r.G[j].Icon:SetShown(j <= n)
		r.G[j].Text:SetShown(j <= n)
	end
	r.psN = n
	r.More:SetText(more > 0 and string.format(L["+%d more"], more) or "")
	r.More:SetShown(more > 0)
	r.Tick:SetShown(v.status == "done")
	r.Mark:SetShown(i == live)
	r.View:SetShown(i == at)
	r:Show()
	-- The skill range this card starts (Fill sets psHead: the step's section
	-- when the card before it is under another one).
	local head = r.psHead
	r.Head:SetShown(head ~= nil)
	if head then
		r.Head:SetText(head.title)
		W.Color(r.Head, head.state == "current" and "accent" or "textMuted")
		key[#key + 1] = head.title .. "|" .. head.state
	end
	key[#key + 1] = more
	key[#key + 1] = r.Tab:GetText() .. (i == live and "|live" or "")
	return table.concat(key, "\n")
end

-- The cards, in step order. Every step is read again only when the guide,
-- the step on screen, the live step or the progress moved; between those (a
-- kill, a loot) only the live and the viewed step's cards are, and the cards
-- are measured again only when what one says changed.
function SL.Fill()
	local E = ns.Engine
	local guide = E and E.GetGuide and E.GetGuide()
	if not (SL.scroll and guide and E.GetStepCount and E.GetStepView) then return end
	local count, at, live = E.GetStepCount(), E.GetStepIndex and E.GetStepIndex(), E.GetLiveStep and E.GetLiveStep()
	local done = E.GetProgress and (E.GetProgress()) or 0
	local sig = table.concat({ guide.id or "", count, at or 0, live or 0, done }, "|")
	if sig == SL.sig then
		for k = 1, 2 do
			local i = k == 1 and live or (at ~= live and at)
			local r = i and SL.rowOf and SL.rowOf[i]
			local v = r and E.GetStepView(i)
			if v then
				local key = fillRow(r, v, i, live, at)
				if key ~= r.psKey then r.psKey, SL.lsig = key, nil end
			end
		end
		return
	end
	SL.sig, SL.at, SL.live, SL.lsig = sig, at, live, nil
	SL.rowOf = {}
	local n, last = 0, nil
	for i = 1, count do
		local v = not UI.StepHidden(i) and E.GetStepView(i)
		if v and v.status ~= "na" then
			n = n + 1
			local r = row(n)
			local sec = v.section
			r.psHead = sec and sec.index ~= last and sec or nil
			last = sec and sec.index or nil
			r.psKey = fillRow(r, v, i, live, at)
			SL.rowOf[i] = r
		end
	end
	for i = n + 1, #SL.rows do SL.rows[i]:Hide() end
	SL.n = n
end

-- Fill the cards and lay them out `width` wide, each as tall as its wrapped
-- lines; the list is as tall as its cards up to `room`. -> height
function SL.Layout(width, room)
	SL.Fill()
	local sc = SL.scroll
	local first = SL.n > 0 and SL.rows[1].G[1]
	local lsig = table.concat({ width, transparent() and 1 or 0, first and first.Text:GetLineHeight() or 0 }, "|")
	if lsig ~= SL.lsig then
		SL.lsig = lsig
		sc.Child:SetWidth(width)
		local textX = PX + GLYPH + 6
		local tw = max(40, width - IN * 2 - textX - PX)
		local y, top = GAP, {}
		for i = 1, SL.n do
			local r = SL.rows[i]
			if r.psHead then
				r.Head:SetWidth(max(40, width - IN * 2 - PX))
				r.Head:ClearAllPoints()
				r.Head:SetPoint("BOTTOMLEFT", r, "TOPLEFT", 2, 3)
				y = y + HEAD_H
			end
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", sc.Child, "TOPLEFT", IN, -y)
			r:SetPoint("TOPRIGHT", sc.Child, "TOPRIGHT", -IN, -y)
			r.Tab:SetWidth(max(40, width - IN * 2 - PX * 2 - 34))
			r.Tab:ClearAllPoints()
			r.Tab:SetPoint("TOPLEFT", r, "TOPLEFT", PX, -(r.psOne and PT - 3 or PT))
			r.Live:ClearAllPoints()
			r.Live:SetPoint("TOPRIGHT", r, "TOPRIGHT", -PX, -PT)
			r.Tick:ClearAllPoints()
			r.Tick:SetPoint("TOPRIGHT", r, "TOPRIGHT", -PX, -(r.psOne and PT - 2 or PT))
			local ly = PT + TAB_H + 3
			for j = 1, r.psN do
				local g = r.G[j]
				g.Text:SetWidth(tw)
				g.Text:ClearAllPoints()
				g.Text:SetPoint("TOPLEFT", r, "TOPLEFT", textX, -ly)
				local lh = g.Text:GetLineHeight()
				g.Icon:ClearAllPoints()
				g.Icon:SetPoint("TOPLEFT", r, "TOPLEFT", PX, -(ly + floor(max(0, (lh - GLYPH) / 2) + 0.5)))
				ly = ly + max(lh, floor(g.Text:GetStringHeight() + 0.5)) + LINE_GAP
			end
			if r.More:IsShown() then
				r.More:ClearAllPoints()
				r.More:SetPoint("TOPLEFT", r, "TOPLEFT", textX, -ly)
				ly = ly + floor(r.More:GetStringHeight() + 0.5) + LINE_GAP
			end
			local h = r.psOne and ONE_H or (r.psN == 0 and PT + TAB_H + PB or (ly - LINE_GAP + PB))
			r:SetHeight(h)
			r.Card:SetShown(not transparent())
			top[r.psIndex] = y - (r.psHead and HEAD_H or 0)
			y = y + h + GAP
		end
		SL.top, SL.H = top, y
	end
	local y = SL.H or GAP
	local view = min(y, max(MIN_H, room or y))
	SL.frame:SetHeight(view)
	W.SetScrollContent(sc, y, view)
	-- Opened: the step on screen (else the live one) at the top, the steps
	-- before it above, reached by scrolling up.
	if SL.opened then
		local want = SL.top and (SL.top[SL.at or 0] or SL.top[SL.live or 0])
		if want then
			SL.wantScroll, SL.scrollTries = max(0, min(y - view, want - GAP)), 0
			SL.opened = false
		end
	end
	-- The scroll frame learns its new size a frame later and clamps to the old
	-- range until then: try again until it holds (a few times at most).
	if SL.wantScroll then
		W.ScrollTo(sc, SL.wantScroll)
		SL.scrollTries = SL.scrollTries + 1
		if sc:GetVerticalScroll() >= SL.wantScroll - 1 or SL.scrollTries > 8 then
			SL.wantScroll = nil
		else
			ns.After(0.05, function()
				local G = GF()
				if SL.frame:IsShown() and G and G.Layout then G.Layout() end
			end)
		end
	end
	return view
end
