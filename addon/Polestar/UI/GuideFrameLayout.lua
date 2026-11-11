-- The guide window's layout: where each part goes and how tall the window is
-- (UI/GuideFrame.lua).

local ADDON, ns = ...
local UI, Theme, W, Anim, floor, max, min = ns.UI, ns.Theme, ns.Widgets, ns.Anim, math.floor, math.max, math.min
local GF = UI.GuideFrame
local Engine, compact, CARD, area, fit = GF.Engine, GF.Compact, GF.CARD, GF.area, GF.fit
local twoLines, contentHeight, fitGoals, sizeWindow, measureRow = GF.TwoLines, GF.ContentHeight, GF.FitGoals, GF.SizeWindow, GF.MeasureRow
local upcomingOpen, upRows, alongRows, tabButtons, bannerNotice = GF.UpcomingOpen, GF.upRows, GF.alongRows, GF.tabs, GF.BannerNotice
local barsBottom = GF.BarsBottom

-- The window's parts and sizes, handed over by the core (GF.Bind).
local F, strip, nav, body, card, person, after, along, upnext, empty
local band, banner, foot, goals
local PAD, TAB_H, NAV_H, PROG_H, ICON, TEXT_X, UP_ROW, UP_TOGGLE, PICTURE_MAX_H, PICTURE_ASPECT
GF.Bind(function(p, m)
	F, strip, nav, body, card, person, after, along = p.F, p.strip, p.nav, p.body, p.card, p.person, p.after, p.along
	upnext, empty, band, banner, foot, goals = p.upnext, p.empty, p.band, p.banner, p.foot, p.goals
	PAD, TAB_H, NAV_H, PROG_H, ICON, TEXT_X, UP_ROW, UP_TOGGLE = m.PAD, m.TAB_H, m.NAV_H, m.PROG_H, m.ICON, m.TEXT_X, m.UP_ROW, m.UP_TOGGLE
	PICTURE_MAX_H, PICTURE_ASPECT = m.PICTURE_MAX_H, m.PICTURE_ASPECT
end)

---------------------------------------------------------------------------
-- Layout: positions and heights from the current content and width. Called
-- on render and on every step of a drag-resize, so it only measures and
-- anchors; it never fetches views or builds strings.
---------------------------------------------------------------------------

local function stripShown()
	return strip.psHasTabs and not compact() and GF.On("tabs")
end

-- A part a skin places itself (Skin API 2, hooks.guidePlace(name, frame,
-- width, height)): laid out and shown, it is handed to the skin before the
-- window places it; the answer true keeps it out of the window (a card of
-- the skin's own above it). A part the skin moved under a frame of its own
-- goes back under its own once no skin claims it.
local function claimed(name, frame, width, h)
	local home = frame.psHome
	if not home then
		home = frame:GetParent()
		frame.psHome = home
	end
	local ran, mine = Theme.SkinHookValue("guidePlace", name, frame, width, h)
	if ran and mine == true then return true end
	if frame:GetParent() ~= home then frame:SetParent(home) end
	return false
end

-- Measure and place the card's parts; the goals area's own height is left
-- to fitGoals (its contents, within the cap). -> the card's height without
-- the goals area
local function layoutCard(width)
	local tipOpen = GF.TipOpen()
	local y = 0
	local cw = width - PAD * 2
	-- The class-quest card (UI/ClassCard.lua) above the person and the goals.
	local CC = UI.ClassCard
	if CC then y = CC.Layout(width) end
	if person:IsShown() then
		local nameW = cw - ICON - 10
		person.Name:SetWidth(nameW)
		person.Where:SetWidth(nameW)
		person.Why:SetWidth(nameW)
		person.Level:SetWidth(nameW)
		local h = 10 + person.Name:GetStringHeight()
		local above = person.Where:IsShown() and person.Where or person.Name
		if person.Where:IsShown() then h = h + 3 + person.Where:GetStringHeight() end
		if person.Why:IsShown() then
			person.Why:ClearAllPoints()
			person.Why:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, -3)
			h = h + 3 + person.Why:GetStringHeight()
			above = person.Why
		end
		if person.Level:IsShown() then
			person.Level:ClearAllPoints()
			person.Level:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, -3)
			h = h + 3 + person.Level:GetStringHeight()
		end
		h = floor(h + 8 + 0.5)
		person:SetHeight(h)
		person:ClearAllPoints()
		person:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -y)
		person:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, -y)
		y = y + h
	end
	-- The goals area: its rows and lines, each under the one before.
	goals:ClearAllPoints()
	goals:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -y)
	goals:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, -y)
	goals.Child:SetWidth(width)
	local prev = goals.Child
	for i = 1, area.n do
		local f = area.items[i]
		local h
		if f.psLine then
			f.Text:SetWidth(max(40, width - TEXT_X - PAD - 18))
			local inset
			inset, h = twoLines(f.Text, CARD.lineH)
			f.Text:SetPoint("TOPLEFT", f, "TOPLEFT", TEXT_X, -inset)
		else
			h = measureRow(f, width)
		end
		area.h[i] = h
		f:SetHeight(max(0.01, h * (f.psK or 1)))
		f:ClearAllPoints()
		local edge = prev == goals.Child and "TOP" or "BOTTOM"
		f:SetPoint("TOPLEFT", prev, edge .. "LEFT", 0, 0)
		f:SetPoint("TOPRIGHT", prev, edge .. "RIGHT", 0, 0)
		prev = f
	end
	local tip = card.Tip
	if tip:IsShown() then
		tip.Text:SetWidth(cw - 18)
		tip.Text:SetWordWrap(tipOpen)
		tip.psOpen = tipOpen
		local th = tipOpen and tip.Text:GetStringHeight() or min(tip.Text:GetStringHeight(), tip.Text:GetLineHeight())
		local h = floor(6 + th + 6 + 0.5)
		-- The step's picture, under the opened tip: as wide as the text
		-- column, its aspect kept, no taller than PICTURE_MAX_H.
		local pic = tipOpen and tip.psImage or nil
		if pic then
			local aspect = (pic.w and pic.h) and pic.w / pic.h or PICTURE_ASPECT
			local iw = max(1, width - TEXT_X - PAD)
			local ih = iw / aspect
			if ih > PICTURE_MAX_H then ih, iw = PICTURE_MAX_H, PICTURE_MAX_H * aspect end
			iw, ih = floor(iw + 0.5), floor(ih + 0.5)
			tip.Image:SetSize(iw, ih)
			tip.Image:ClearAllPoints()
			tip.Image:SetPoint("TOPLEFT", tip, "TOPLEFT", TEXT_X, -h)
			tip.Image:Show()
			h = h + ih + 6
		else
			tip.Image:Hide()
		end
		tip:SetHeight(h)
		if not claimed("tip", tip, width, h) then
			tip:ClearAllPoints()
			tip:SetPoint("TOPLEFT", goals, "BOTTOMLEFT", 0, -2)
			tip:SetPoint("TOPRIGHT", goals, "BOTTOMRIGHT", 0, -2)
			y = y + 2 + h
		end
	end
	return y + 6
end

-- "Then: <next step's person>": a long name wraps to a second line, the
-- line growing by it (twoLines), its text and count kept in the middle.
local function layoutAfter(width)
	after.Text:SetWidth(width - PAD * 2 - after.Count:GetStringWidth() - 12)
	local _, h = twoLines(after.Text, 28)
	after:SetHeight(h)
	return h
end

local layoutUpnext, layoutAlong
do
	-- An Up next or Along the way row at y in its frame, `width` wide: its
	-- number (Up next) and glyph on the first line, the text wrapping. -> its height
	local function placeRow(r, parent, y, width)
		if parent == upnext then r.Num:SetPoint("LEFT", r, "TOPLEFT", PAD - 10, -UP_ROW / 2) end
		r.Icon:SetPoint("LEFT", r, "TOPLEFT", TEXT_X - 2, -UP_ROW / 2)
		r.Text:SetWidth(width - TEXT_X - 14 - PAD)
		local inset, h = twoLines(r.Text, UP_ROW)
		r.Text:SetPoint("TOPLEFT", r, "TOPLEFT", TEXT_X - 2 + 13 + 9, -inset)
		r:SetHeight(h)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, y)
		r:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, y)
		return h
	end

	function layoutUpnext(width)
		upnext.Toggle:ClearAllPoints()
		upnext.Toggle:SetPoint("TOPLEFT", upnext, "TOPLEFT", 0, 0)
		upnext.Toggle:SetPoint("TOPRIGHT", upnext, "TOPRIGHT", 0, 0)
		local y = -UP_TOGGLE
		if upcomingOpen() then
			for i = 1, #upRows do
				local r = upRows[i]
				if r:IsShown() then y = y - placeRow(r, upnext, y, width) end
			end
			y = y - 6
		end
		upnext:SetHeight(-y)
		return -y
	end

	function layoutAlong(width)
		local y = -UP_TOGGLE
		for i = 1, #alongRows do
			local r = alongRows[i]
			if r:IsShown() then y = y - placeRow(r, along, y, width) end
		end
		y = y - 6
		along:SetHeight(-y)
		return -y
	end
end

local function layoutEmpty(width)
	local cw = width - PAD * 4
	local y = -26
	empty.Glyph:ClearAllPoints()
	empty.Glyph:SetPoint("TOP", empty, "TOP", 0, y)
	y = y - 36 - 14
	empty.Title:SetWidth(cw)
	empty.Title:ClearAllPoints()
	empty.Title:SetPoint("TOP", empty, "TOP", 0, y)
	y = y - empty.Title:GetStringHeight() - 8
	empty.Text:SetWidth(cw)
	empty.Text:ClearAllPoints()
	empty.Text:SetPoint("TOP", empty, "TOP", 0, y)
	y = y - empty.Text:GetStringHeight() - 18
	if empty.Primary:IsShown() then
		empty.Primary:ClearAllPoints()
		empty.Primary:SetPoint("TOP", empty, "TOP", 0, y)
		y = y - empty.Primary:GetHeight() - 8
	end
	if empty.Secondary:IsShown() then
		empty.Secondary:ClearAllPoints()
		empty.Secondary:SetPoint("TOP", empty, "TOP", 0, y)
		y = y - empty.Secondary:GetHeight()
	end
	y = y - 24
	empty:SetHeight(-y)
	return -y
end

-- Place `frame` in the body at y; returns the new y. Under the card (while
-- Layout sets fit.from) the frame is kept for fitGoals to move.
local function stack(frame, y, h)
	frame:ClearAllPoints()
	frame:SetPoint("TOPLEFT", body, "TOPLEFT", 0, -y)
	frame:SetPoint("TOPRIGHT", body, "TOPRIGHT", 0, -y)
	if fit.from then
		fit.n = fit.n + 1
		fit.below[fit.n], fit.rel[fit.n] = frame, y - fit.from
	end
	return y + h
end

-- `frame` stacked at y, unless the skin places it itself (claimed): it is
-- part `name` of hooks.guidePlace. -> the new y
local function place(name, frame, y, h, width)
	if claimed(name, frame, width, h) then return y end
	return stack(frame, y, h)
end

-- The tallest the window may be: ui.maxHeight of the screen's height, in
-- the window's own units (its scale and the game's UI scale applied).
local function capHeight()
	local share = tonumber(ns.Get("ui.maxHeight")) or 0.5
	local screen = UIParent:GetHeight() * UIParent:GetEffectiveScale()
	return screen * share / max(0.01, F:GetEffectiveScale())
end
GF.CapHeight = function() return F and capHeight() or nil end

-- The journey (UI/JourneyPanel.lua) right under the focus it leads to;
-- never in compact mode. Returns the new y.
local function stackJourney(y, width)
	local J = UI.JourneyPanel
	local jf = J and J.frame
	if not jf then return y end
	if jf.psHas and not compact() then
		jf:Show()
		return stack(jf, y, J.Layout(width))
	end
	jf:Hide()
	return y
end

local function placeBars(showFoot)
	local flip = barsBottom()
	strip:ClearAllPoints()
	nav:ClearAllPoints()
	body:ClearAllPoints()
	foot:ClearAllPoints()
	band:ClearAllPoints()
	strip.Rule:ClearAllPoints()
	nav.Rule:ClearAllPoints()
	local edge = flip and "TOP" or "BOTTOM"
	strip.Rule:SetPoint(edge .. "LEFT", strip, edge .. "LEFT", 0, 0)
	strip.Rule:SetPoint(edge .. "RIGHT", strip, edge .. "RIGHT", 0, 0)
	nav.Rule:SetPoint(edge .. "LEFT", nav, edge .. "LEFT", 0, 0)
	nav.Rule:SetPoint(edge .. "RIGHT", nav, edge .. "RIGHT", 0, 0)
	if flip then
		strip:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 0, 0)
		strip:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", 0, 0)
		nav:SetPoint("BOTTOMLEFT", strip, "TOPLEFT", 0, 0)
		nav:SetPoint("BOTTOMRIGHT", strip, "TOPRIGHT", 0, 0)
		foot:SetPoint("BOTTOMLEFT", nav, "TOPLEFT", 0, 0)
		foot:SetPoint("BOTTOMRIGHT", nav, "TOPRIGHT", 0, 0)
		body:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
		body:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
		band:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
		band:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
	else
		strip:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
		strip:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
		nav:SetPoint("TOPLEFT", strip, "BOTTOMLEFT", 0, 0)
		nav:SetPoint("TOPRIGHT", strip, "BOTTOMRIGHT", 0, 0)
		body:SetPoint("TOPLEFT", nav, "BOTTOMLEFT", 0, 0)
		body:SetPoint("TOPRIGHT", nav, "BOTTOMRIGHT", 0, 0)
		foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 0, 0)
		foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", 0, 0)
		band:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
		band:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	end
	for _, b in ipairs(tabButtons) do
		b.Bar:ClearAllPoints()
		b.Bar:SetPoint(edge .. "LEFT", b, edge .. "LEFT", 0, 0)
		b.Bar:SetPoint(edge .. "RIGHT", b, edge .. "RIGHT", 0, 0)
	end
	-- The backing (GF.VEIL): 14 past the window's sides, so it is solid under
	-- text running to the window's padding, and 8 past its top and bottom;
	-- over the navigator's inner edge the two scrims overlap so that one rises
	-- as the other falls over the same band (Theme.Scrim), centred on that edge.
	local v, bv = GF.veil, band.Veil
	local o = (GF.VEIL_FEATHER + v.psClear) / 2
	v:ClearAllPoints()
	bv:ClearAllPoints()
	if flip then
		v:SetPoint("TOPLEFT", F, "TOPLEFT", -14, 8)
		v:SetPoint("BOTTOMRIGHT", nav, "TOPRIGHT", 14, -o)
		bv:SetPoint("TOPLEFT", nav, "TOPLEFT", -14, o)
		bv:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", 14, -8)
	else
		v:SetPoint("TOPLEFT", nav, "BOTTOMLEFT", -14, o)
		v:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", 14, -8)
		bv:SetPoint("TOPLEFT", F, "TOPLEFT", -14, 8)
		bv:SetPoint("BOTTOMRIGHT", nav, "BOTTOMRIGHT", 14, -o)
	end
end

-- With ui.growUp, the height from the window's pinned bottom edge to the top
-- of the screen, in the window's scale (nil without Grow upward): the
-- window is never taller (fit.limit, #666).
local function roomAbove()
	if not ns.Get("ui.growUp") then return nil end
	local top = UIParent:GetTop()
	local scale, uiScale = F:GetEffectiveScale(), UIParent:GetEffectiveScale()
	if not (top and scale and uiScale and scale > 0) then return nil end
	-- The pinned corner (GF.ApplyPosition), not where the game may have moved it.
	local point, rel, relPoint, _, bottom = F:GetPoint(1)
	if not (rel == UIParent and type(point) == "string" and point:find("^BOTTOM") and type(relPoint) == "string" and relPoint:find("^BOTTOM")) then
		bottom = F:GetBottom()
	end
	if type(bottom) ~= "number" then return nil end
	return top * uiScale / scale - bottom
end

function GF.Layout()
	local state = GF.State()
	if not F then return end
	local width = F:GetWidth()
	local isCompact = compact()
	local showStrip = stripShown()
	strip:SetShown(showStrip)
	strip:SetHeight(showStrip and TAB_H or 0.01)
	-- The guide's title sits in the navigator only when no tab names it.
	local steps = nav.Steps:IsShown()
	nav.Title:SetShown((not showStrip or not steps) and GF.On("guideTitle") and nav.Title:GetText() ~= nil and nav.Title:GetText() ~= "")
	local skipW = nav.Skip:IsShown() and nav.Skip:GetWidth() + 4 or 0
	local reportW = nav.Report:IsShown() and nav.Report:GetWidth() or 0
	local nearbyW = nav.Nearby:IsShown() and nav.Nearby:GetWidth() or 0
	nav.Title:SetWidth(max(40, width - PAD - (steps and nav.Steps:GetWidth() + 12 or 0) - 24 - 8 - 8 - (nav.Close:IsShown() and 18 or 0) - skipW - reportW - nearbyW))
	card:SetWidth(width)

	local y = 0
	-- With no guide open, only the tab just closed (its Reopen) shows.
	local kind = bannerNotice()
	if kind and ((state ~= "noguide" and state ~= "noguides") or kind == "closedTab") then
		banner:Show()
		y = place("banner", banner, y, GF.LayoutBanner(width), width)
	else
		banner:Hide()
		banner.Jump.psDefault = nil
	end
	fit.n = 0
	local content = 0
	if state == "steps" then
		fit.fixed = layoutCard(width)
		fit.top = y
		-- The card animates its own offset; keep its anchor's base in step.
		if Anim.IsRunning(card, "offset") then
			card.psAnchor[5] = -y
		else
			Anim.Anchor(card, "TOPLEFT", body, "TOPLEFT", 0, -y)
		end
		content = contentHeight()
		y = y + fit.fixed + content
		fit.from = y
		y = stackJourney(y, width)
		-- "While you're here": between the step's goals and "Then:".
		if GF.here:IsShown() then y = place("here", GF.here, y, GF.LayoutHere(width), width) end
		if after:IsShown() then y = place("after", after, y, layoutAfter(width), width) end
		if along:IsShown() then y = place("along", along, y, layoutAlong(width), width) end
		if upnext:IsShown() then y = place("upnext", upnext, y, layoutUpnext(width), width) end
	else
		y = stack(empty, y, layoutEmpty(width))
		y = stackJourney(y, width)
	end
	if GF.party.psText and not isCompact and state == "steps" then
		GF.party:Show()
		y = place("party", GF.party, y, GF.party:GetHeight(), width)
	else
		GF.party:Hide()
	end
	if GF.xp.psHas and not isCompact and state == "steps" then
		GF.xp:Show()
		y = place("xp", GF.xp, y, GF.xp:GetHeight(), width)
	else
		GF.xp:Hide()
	end
	-- A skin's own room under the window's parts (Skin API 2,
	-- hooks.guideLayout(parts, width, y)): it may place its frames from y
	-- down; its answer is the height they take.
	local ran, extra = Theme.SkinHookValue("guideLayout", Theme.GuideParts(), width, y)
	if ran and type(extra) == "number" and extra > 0 then y = y + extra end
	local showFoot = (state == "steps" or state == "complete" or state == "skippedout") and GF.On("progress")
	foot:SetShown(showFoot)
	local stripH = showStrip and TAB_H or 0
	fit.outer = stripH + NAV_H + (showFoot and PROG_H or 0)
	fit.limit = roomAbove()
	if fit.from then
		-- Past the cap (or the top of the screen with Grow upward), the goals
		-- area gives up the difference and scrolls.
		fit.h = y - fit.from
		fit.from = nil
		fit.room = min(capHeight(), fit.limit or math.huge) - (fit.outer + y - content)
		fitGoals()
	else
		sizeWindow(y)
	end
	placeBars(showFoot)
	band:SetHeight(stripH + NAV_H)
	local x0, x1, y0, y1 = Theme.BandCoords(width - 2, stripH + NAV_H, 30)
	if barsBottom() then y0, y1 = y1, y0 end
	band:SetTexCoord(x0, x1, y0, y1)
	if showStrip then GF.RenderTabs() end
	GF.PaintProgress(false)
	if UI.NameTargets then UI.NameTargets.Refresh() end
	GF.PaintShades()
end

---------------------------------------------------------------------------
-- Progress
---------------------------------------------------------------------------

local function progress()
	local E = Engine()
	if not (E and E.GetProgress and E.GetGuide and E.GetGuide()) then return 0, 0 end
	local done, total = E.GetProgress()
	return done or 0, total or 0
end

function GF.PaintProgress(animate)
	local done, total = progress()
	local frac = total > 0 and min(1, done / total) or 0
	foot.Pct:SetText(floor(frac * 100 + 0.5) .. "%")
	local w = F:GetWidth() - PAD * 2 - (foot.Pct:IsShown() and 44 or 0)
	foot.Line:SetWidth(max(1, w))
	W.SetProgress(foot.Line, frac, w, animate)
	GF.PaintStatus(frac, foot.Pct:GetText())
	foot.psDone, foot.psTotal = done, total
	-- A skin's own progress (Skin API 2, hooks.guideProgress(foot, frac)).
	Theme.SkinHook("guideProgress", foot, frac)
end

GF.StripShown = stripShown
