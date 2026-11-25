-- The guide window's layout: where each part goes and how tall the window is
-- (UI/GuideFrame.lua).

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local UI, Theme, W, Anim, floor, max, min = ns.UI, ns.Theme, ns.Widgets, ns.Anim, math.floor, math.max, math.min
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

	-- The tab strip: only in the underline style (GF.TabStyle). In compact
	-- mode, with that style, slim (GF.StripH) and only while two guides or
	-- more are open; one open guide the navigator names. Another style keeps
	-- its own tabs in compact mode, as out of it.
	local function stripShown()
		if not (strip.psHasTabs and GF.On("tabs")) then return false end
		local style = GF.TabStyle()
		if compact() then return style == nil and (strip.psTabN or 0) >= 2 end
		return style == "underline"
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
		local ran, mine = GF.HookValue("guidePlace", name, frame, width, h)
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
		-- The class-quest card (UI/ClassCard.lua) above the person and the goals:
		-- the live window's alone.
		local CC = GF.live and UI.ClassCard or nil
		if CC then
			y = CC.Layout(width)
			-- A skin may place the card itself (guidePlace "classCard").
			local f = CC.Frame and CC.Frame()
			if y > 0 and f and claimed("classCard", f, width, y) then y = 0 end
		end
		-- Another tab's step close by (UI/OtherTab.lua), over the class card,
		-- under the alerts.
		local OT = GF.live and UI.OtherTabCard or nil
		if OT then
			local oh = OT.Layout(width, 0)
			-- A skin may place the card itself (guidePlace "otherTab").
			local OF = OT.Frame and OT.Frame()
			if oh > 0 and OF and claimed("otherTab", OF, width, OF:GetHeight()) then oh = 0 end
			if oh > 0 then
				local CF = CC and CC.Frame and CC.Frame()
				if y > 0 and CF and CF:GetParent() == card then
					local p, rel, rp, x, cy = CF:GetPoint(1)
					CF:SetPoint(p, rel, rp, x, (cy or 0) - oh)
				end
				y = y + oh
			end
		end
		-- A profession guide's skill-range heading over the step (fillCard).
		local sec = card.Section
		if sec:IsShown() then
			sec:SetWidth(cw)
			sec:ClearAllPoints()
			sec:SetPoint("TOPLEFT", card, "TOPLEFT", PAD, -(y + 8))
			y = y + 8 + sec:GetStringHeight()
		end
		-- The steps before (guideWindow.lastSteps), one row each over the
		-- header, the oldest on top, as tall as the look's Up next row
		-- (GF.Space "lastRow" over GF.LookSpace "upRow").
		local last = card.Last
		if last:IsShown() then
			local n, rowH = last.psCount or 0, GF.Space("lastRow", GF.LookSpace("upRow", UP_ROW))
			last:ClearAllPoints()
			last:SetPoint("TOPLEFT", card, "TOPLEFT", 0, -y)
			last:SetPoint("TOPRIGHT", card, "TOPRIGHT", 0, -y)
			last:SetHeight(n * rowH)
			for i = 1, n do
				local r = last.Rows[i]
				r:ClearAllPoints()
				r:SetPoint("TOPLEFT", last, "TOPLEFT", 0, -(i - 1) * rowH)
				r:SetPoint("TOPRIGHT", last, "TOPRIGHT", 0, -(i - 1) * rowH)
				r:SetHeight(rowH)
				r.Num:ClearAllPoints()
				r.Num:SetPoint("LEFT", r, "TOPLEFT", PAD - 10, -rowH / 2)
				r.Icon:ClearAllPoints()
				r.Icon:SetPoint("LEFT", r, "TOPLEFT", TEXT_X - 2, -rowH / 2)
				r.Text:ClearAllPoints()
				r.Text:SetPoint("LEFT", r, "TOPLEFT", TEXT_X - 2 + 13 + 9, -rowH / 2)
				r.Text:SetWidth(max(40, width - TEXT_X - 14 - PAD))
			end
			y = y + n * rowH
		end
		if person:IsShown() then
			local nameW = cw - ICON - 10
			person.Name:SetWidth(nameW)
			person.Where:SetWidth(nameW)
			person.Why:SetWidth(nameW)
			-- The room over the title and under the header (GF.Gap "stepSpace",
			-- "titleSpace"): 10 and 8 by Polestar's own.
			local top = GF.Gap("stepSpace", 10)
			person.Name:SetPoint("TOPLEFT", person, "TOPLEFT", TEXT_X, -top)
			person.Icon:SetPoint("TOPLEFT", person, "TOPLEFT", PAD - 1, -(top + 1 + floor((GF.Num("titleSize") - 1) * 7 + 0.5)))
			local h = top + person.Name:GetStringHeight()
			local above = person.Where:IsShown() and person.Where or person.Name
			if person.Where:IsShown() then h = h + 3 + person.Where:GetStringHeight() end
			if person.Why:IsShown() then
				person.Why:ClearAllPoints()
				person.Why:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, -3)
				h = h + 3 + person.Why:GetStringHeight()
			end
			h = floor(h + GF.Gap("titleSpace", 8) + 0.5)
			-- A skin may lay the step's header out its own way (Skin API 2,
			-- hooks.guidePerson(person, width, height)): its answer is the height.
			local ran, skinH = GF.HookValue("guidePerson", person, cw, h)
			if ran and type(skinH) == "number" and skinH >= 0 then h = floor(skinH + 0.5) end
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
			-- Its room above and below the text, and its gap under the goals
			-- (GF.Space "tipPad", "tipGap").
			local pad, gap = GF.Space("tipPad", 6), GF.Space("tipGap", 2)
			tip.Text:SetPoint("TOPLEFT", tip, "TOPLEFT", TEXT_X, -pad)
			tip.Toggle:SetPoint("TOPLEFT", tip, "TOPLEFT", PAD - 2, 3 - pad)
			tip.psGap = gap
			local h = floor(pad + th + pad + 0.5)
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
				tip:SetPoint("TOPLEFT", goals, "BOTTOMLEFT", 0, -gap)
				tip:SetPoint("TOPRIGHT", goals, "BOTTOMRIGHT", 0, -gap)
				y = y + gap + h
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
		-- An Up next row is GF.Space "upRow" tall for one line.
		local function placeRow(r, parent, y, width)
			local rowH = parent == upnext and GF.Space("upRow", UP_ROW) or UP_ROW
			if parent == upnext then r.Num:SetPoint("LEFT", r, "TOPLEFT", PAD - 10, -rowH / 2) end
			r.Icon:SetPoint("LEFT", r, "TOPLEFT", TEXT_X - 2, -rowH / 2)
			r.Text:SetWidth(width - TEXT_X - 14 - PAD)
			UI.FitCounts(r.Text)
			local inset, h = twoLines(r.Text, rowH)
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
			-- A skin may leave out the "Up next" heading, its rows always open
			-- (GF.Shows "upnextHead").
			local head = GF.Shows("upnextHead", true)
			upnext.Toggle:SetShown(head)
			local y = head and -UP_TOGGLE or 0
			if upcomingOpen() or not head then
				for i = 1, #upRows do
					local r = upRows[i]
					if r:IsShown() then y = y - placeRow(r, upnext, y, width) end
				end
				-- Its room under the rows (GF.Space "upnextFoot").
				y = y - GF.Space("upnextFoot", 6)
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
		-- A finished guide's quest lines (GF.EndQuestLines), 20px each, under the text.
		local lines = empty.Carried:IsShown() or empty.Stray:IsShown()
		if lines then
			y = y + 10
			if empty.Carried:IsShown() then
				empty.Carried:ClearAllPoints()
				empty.Carried:SetPoint("TOP", empty, "TOP", 0, y)
				y = y - 20 - 2
			end
			if empty.Stray:IsShown() then
				empty.Stray:ClearAllPoints()
				empty.Stray:SetPoint("TOP", empty, "TOP", 0, y)
				y = y - 20 - 2
			end
			y = y - 10
		end
		local pn = GF.PlayNext
		if pn then
			local h = pn.Layout(width - PAD * 2)
			if h > 0 then
				local c = pn.card()
				c:ClearAllPoints()
				c:SetPoint("TOP", empty, "TOP", 0, y)
				y = y - h - 12
			end
		end
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
		local skips = pn and pn.skips()
		if skips and skips:IsShown() then
			skips:ClearAllPoints()
			skips:SetPoint("TOP", empty, "TOP", 0, y)
			y = y - 20
		end
		local other = pn and pn.other()
		if other and other:IsShown() then
			other:ClearAllPoints()
			other:SetPoint("TOP", empty, "TOP", 0, y)
			y = y - 20
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
	-- part `name` of hooks.guidePlace. `x`: its inset from the left (inset),
	-- kept for fitGoals. -> the new y
	local function place(name, frame, y, h, width, x)
		if claimed(name, frame, width, h) then return y end
		frame.psInset = x
		y = stack(frame, y, h)
		if x and x > 0 then frame:SetPoint("TOPLEFT", body, "TOPLEFT", x, -(y - h)) end
		return y
	end

	-- A part the skin sets in from the window's left edge (Skin API 2,
	-- hooks.guideInset(name)): "card" (the step's card), "upnext". -> its
	-- inset, 0 without one
	local function inset(name)
		local ran, x = GF.HookValue("guideInset", name)
		return (ran and type(x) == "number" and x > 0) and floor(x + 0.5) or 0
	end

	-- The window's scale on the screen: its own, or a copy's as the live
	-- window's (ui.scale on the game's UI scale), whatever its host draws it at.
	local function screenScale()
		if GF.live then return F:GetEffectiveScale() end
		return (tonumber(ns.Get("ui.scale")) or 1) * UIParent:GetEffectiveScale()
	end

	local roomAbove -- below
	-- The tallest the window may be: ui.maxHeight of the screen's height, in
	-- the window's own units (its scale and the game's UI scale applied), and
	-- never under UI.MIN_HEIGHT, so the cap always leaves a readable window.
	-- ui.heightMode "auto" (the live window): all the room from the pinned
	-- edge to the screen's edge, less a margin, never under 30% of the screen
	-- nor over it; "fixed": its height, but never past that same room.
	local function capHeight()
		-- While the grip is dragged, its height (GF.dragShare): ui.maxHeight is written once, on release.
		local share = GF.dragShare or tonumber(ns.Get("ui.maxHeight")) or 0.5
		local screen = UIParent:GetHeight() * UIParent:GetEffectiveScale()
		local scale = max(0.01, screenScale())
		local mode = ns.Get("ui.heightMode")
		if GF.live and (mode == "auto" or mode == "fixed") then
			local room = ns.Get("ui.growUp") and roomAbove() or F:GetTop()
			if type(room) == "number" then
				local fits = min(screen / scale, max(room - 24, screen * 0.3 / scale))
				return max(UI.MIN_HEIGHT or 0, mode == "auto" and fits or min(fits, screen * share / scale))
			end
		end
		return max(UI.MIN_HEIGHT or 0, screen * share / scale)
	end
	GF.CapHeight = function() return F and capHeight() or nil end

	-- The journey (UI/JourneyPanel.lua) right under the focus it leads to;
	-- not in compact mode unless the skin keeps it (GF.Shows "journey"). A
	-- copy (the settings preview) shows a sample route (JP.Sample) while
	-- nav.journeySteps is on. A skin may place it itself (guidePlace
	-- "journey"). Returns the new y.
	local function stackJourney(y, width)
		local JP = UI.JourneyPanel
		if not GF.live then
			if not (JP and JP.Sample) then return y end
			if not GF.journeySample then GF.journeySample = JP.Sample(body) or false end
			local s = GF.journeySample
			if not s then return y end
			if ns.Get("nav.journeySteps") and GF.Shows("journey", not compact()) then
				s.frame:Show()
				return place("journey", s.frame, y, s.Layout(width), width)
			end
			s.frame:Hide()
			return y
		end
		local jf = JP and JP.frame
		if not jf then return y end
		if jf.psHas and GF.Shows("journey", not compact()) then
			jf:Show()
			return place("journey", jf, y, JP.Layout(width), width)
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
			if fit.follow then
				-- The goals sit on the bar, the free room above them.
				body:SetPoint("BOTTOMLEFT", foot, "TOPLEFT", 0, 0)
				body:SetPoint("BOTTOMRIGHT", foot, "TOPRIGHT", 0, 0)
			else
				body:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
				body:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
			end
			band:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 1, 1)
			band:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -1, 1)
		else
			strip:SetPoint("TOPLEFT", F, "TOPLEFT", 0, 0)
			strip:SetPoint("TOPRIGHT", F, "TOPRIGHT", 0, 0)
			nav:SetPoint("TOPLEFT", strip, "BOTTOMLEFT", 0, 0)
			nav:SetPoint("TOPRIGHT", strip, "BOTTOMRIGHT", 0, 0)
			foot:SetPoint("BOTTOMLEFT", F, "BOTTOMLEFT", 0, 0)
			foot:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", 0, 0)
			if fit.follow and ns.Get("ui.growUp") then
				-- The goals sit on the bar at the pinned bottom edge, the free room above them.
				body:SetPoint("BOTTOMLEFT", foot, "TOPLEFT", 0, 0)
				body:SetPoint("BOTTOMRIGHT", foot, "TOPRIGHT", 0, 0)
			else
				body:SetPoint("TOPLEFT", nav, "BOTTOMLEFT", 0, 0)
				body:SetPoint("TOPRIGHT", nav, "BOTTOMRIGHT", 0, 0)
				if fit.follow then
					-- The bar right under the last goal, the free room below it.
					foot:ClearAllPoints()
					foot:SetPoint("TOPLEFT", body, "BOTTOMLEFT", 0, 0)
					foot:SetPoint("TOPRIGHT", body, "BOTTOMRIGHT", 0, 0)
				end
			end
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
		-- The slim strip's tabs sit closer to the window's edge: the bar's backing
		-- reaches out by the height they lost, so they stay on its solid middle.
		local v, bv = GF.veil, band.Veil
		local o = (GF.VEIL_FEATHER + v.psClear) / 2
		local out = 8 + (strip:IsShown() and max(0, TAB_H - strip:GetHeight()) or 0)
		v:ClearAllPoints()
		bv:ClearAllPoints()
		if flip then
			v:SetPoint("TOPLEFT", F, "TOPLEFT", -14, 8)
			v:SetPoint("BOTTOMRIGHT", nav, "TOPRIGHT", 14, -o)
			bv:SetPoint("TOPLEFT", nav, "TOPLEFT", -14, o)
			bv:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", 14, -out)
		else
			v:SetPoint("TOPLEFT", nav, "BOTTOMLEFT", -14, o)
			v:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", 14, -8)
			bv:SetPoint("TOPLEFT", F, "TOPLEFT", -14, out)
			bv:SetPoint("BOTTOMRIGHT", nav, "BOTTOMRIGHT", 14, -o)
		end
	end

	-- With ui.growUp, the height from the window's pinned bottom edge to the top
	-- of the screen, in the window's scale (nil without Grow upward): the
	-- window is never taller (fit.limit, #666). A copy is pinned nowhere.
	function roomAbove()
		if not (GF.live and ns.Get("ui.growUp")) then return nil end
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

	-- The grip sits on the edge that moves while it drags the height (Fixed or
	-- Automatic): the bottom-right corner, or with Grow upward just over the
	-- top-right one, clear of the header's menu button. Under Follows the step
	-- it sets the width alone and keeps the corner, Grow upward or not: over
	-- the top it was where no one looks for it, and the corner moved the window.
	function GF.PlaceGrip()
		local grip = GF.grip
		if not grip then return end
		local mode = ns.Get("ui.heightMode")
		local up = ns.Get("ui.growUp") and (mode == "fixed" or mode == "auto")
		grip:ClearAllPoints()
		grip:SetPoint("BOTTOMRIGHT", F, up and "TOPRIGHT" or "BOTTOMRIGHT", -1, 1)
		grip.Icon:SetTexCoord(0, 1, up and 1 or 0, up and 0 or 1)
	end

	-- The line at the height limit, with its value in px, while the grip is dragged:
	-- the window may be shorter than its limit, so the limit shows on its own.
	function GF.ShowLimit(on)
		local limitLine = GF.limitLine
		if not limitLine then
			if not on then return end
			limitLine = CreateFrame("Frame", nil, F)
			GF.limitLine = limitLine
			limitLine:SetHeight(2)
			limitLine:SetFrameLevel(F:GetFrameLevel() + 20)
			limitLine.Line = limitLine:CreateTexture(nil, "OVERLAY")
			limitLine.Line:SetAllPoints()
			W.Color(limitLine.Line, "accent")
			limitLine.Text = W.Text(limitLine, "number", "text")
			limitLine.Text:SetPoint("BOTTOMRIGHT", limitLine, "TOPRIGHT", -4, 2)
		end
		limitLine:SetShown(on)
		if not on then return end
		-- What the window can reach: with the class quest card up, the cap less the card's room (as GF.Layout).
		local toast = UI.ClassToast
		local cap = capHeight() - (toast and toast.Reserved and toast.Reserved() or 0)
		local up = ns.Get("ui.growUp")
		limitLine:ClearAllPoints()
		limitLine:SetPoint(up and "BOTTOMLEFT" or "TOPLEFT", F, up and "BOTTOMLEFT" or "TOPLEFT", 0, up and cap or -cap)
		limitLine:SetPoint(up and "BOTTOMRIGHT" or "TOPRIGHT", F, up and "BOTTOMRIGHT" or "TOPRIGHT", 0, up and cap or -cap)
		limitLine.Text:SetText(string.format(ns.L["%d px"], floor(cap * Theme.PixelsPerUnit(F) + 0.5)))
	end

	-- How far a layout's frames reach below the window's bottom edge (Atlas's
	-- folded Journey): the layout sets F.psBelow in its guideLayout hook. A
	-- host showing a copy (the settings preview) leaves that room too. -> height
	function GF.Below()
		local h = F and tonumber(F.psBelow) or 0
		return h > 0 and floor(h + 0.5) or 0
	end

	function GF.Layout()
		local state = GF.State()
		if not F then return end
		local width = F:GetWidth()
		local isCompact = compact()
		local showStrip = stripShown()
		GF.PlaceTabStyle()
		strip:SetShown(showStrip)
		local SH = GF.StripH()
		strip:SetHeight(showStrip and SH or 0.01)
		-- The guide's title sits in the navigator only when no tab names it.
		local steps = nav.Steps:IsShown()

		local skipW = nav.Skip:IsShown() and nav.Skip:GetWidth() + 4 or 0
		local reportW = nav.Report:IsShown() and nav.Report:GetWidth() or 0
		local nearbyW = nav.Nearby:IsShown() and nav.Nearby:GetWidth() or 0
		local lookupW = nav.Lookup:GetWidth()
		local titleW = width - PAD - (steps and nav.Steps:GetWidth() + 12 or 0) - 24 - 8 - 8 - (nav.Close:IsShown() and 18 or 0) - skipW - reportW - nearbyW - lookupW
		-- At the minimum width the controls take the row; the title must not sit
		-- behind Skip (notably in compact mode with one guide, where no strip shows).
		-- A layout that sets the row out itself (nav.psFitTitle) sizes and hides the title.
		nav.Title:SetShown((not showStrip or not steps) and GF.On("guideTitle") and nav.Title:GetText() ~= nil and nav.Title:GetText() ~= "" and (nav.psFitTitle or titleW >= 40))
		if not nav.psFitTitle then nav.Title:SetWidth(max(40, titleW)) end
		card:SetWidth(width)

		local y = 0
		-- With no guide open, only the tab just closed (its Reopen) and a newer
		-- Polestar show.
		local kind, notice = bannerNotice()
		if kind and ((state ~= "noguide" and state ~= "noguides") or kind == "closedTab" or kind == "update") then
			banner:Show()
			y = place("banner", banner, y, GF.LayoutBanner(width, true, kind, notice), width)
		else
			banner:Hide()
			banner.Jump.psDefault = nil
		end
		fit.n = 0
		local content = 0
		-- The step browser (UI/StepList.lua) in place of the card and what
		-- follows it: the live window's alone.
		local list = GF.live and UI.StepList and UI.StepList.Place(body, state == "steps" or state == "complete" or state == "skippedout")
		if list then
			for _, f in ipairs({ card, after, along, GF.here, upnext, empty, UI.JourneyPanel and UI.JourneyPanel.frame }) do f:Hide() end
			local outer = (showStrip and SH or 0) + NAV_H + PROG_H
			local kept = UI.StepList.height or F:GetHeight()
			local limit = max(outer + GF.MIN_BODY_H, roomAbove() or math.huge)
			if isCompact then
				-- The compact window is too short to browse in: the list grows it
				-- to fit its cards, up to the height cap, never below its height.
				y = stack(list, y, UI.StepList.Layout(width, min(capHeight(), limit) - outer - y, kept - outer - y))
			else
				y = stack(list, y, UI.StepList.Layout(width, min(kept, limit) - outer - y))
			end
		elseif state == "steps" then
			local cx = inset("card")
			card:SetWidth(width - cx)
			fit.fixed = layoutCard(width - cx)
			fit.top = y
			-- The card animates its own offset; keep its anchor's base in step.
			if Anim.IsRunning(card, "offset") then
				card.psAnchor[4], card.psAnchor[5] = cx, -y
			else
				Anim.Anchor(card, "TOPLEFT", body, "TOPLEFT", cx, -y)
			end
			content = contentHeight()
			y = y + fit.fixed + content
			fit.from = y
			y = stackJourney(y, width)
			-- "While you're here": between the step's goals and "Then:".
			if GF.here:IsShown() then y = place("here", GF.here, y, GF.LayoutHere(width), width) end
			if after:IsShown() then y = place("after", after, y, layoutAfter(width), width) end
			if along:IsShown() then y = place("along", along, y, layoutAlong(width), width) end
			if upnext:IsShown() then
				local ux = inset("upnext")
				y = place("upnext", upnext, y, layoutUpnext(width - ux), width - ux, ux)
			end
		else
			y = stack(empty, y, layoutEmpty(width))
			y = stackJourney(y, width)
		end
		if GF.party.psText and not isCompact and state == "steps" and not list then
			GF.party:Show()
			y = place("party", GF.party, y, GF.party:GetHeight(), width)
		else
			GF.party:Hide()
		end
		-- Not in compact mode unless the skin keeps it (GF.Shows "xp").
		if GF.xp.psHas and GF.Shows("xp", not isCompact) and state == "steps" and not list then
			GF.xp:Show()
			-- Its line on two when the width can't hold it (GF.XPHeight).
			local xh = GF.XPHeight and GF.XPHeight(width) or GF.xp:GetHeight()
			GF.xp:SetHeight(xh)
			y = place("xp", GF.xp, y, xh, width)
		else
			GF.xp:Hide()
		end
		-- A skin's own room under the window's parts (Skin API 2,
		-- hooks.guideLayout(parts, width, y)): it may place its frames from y
		-- down; its answer is the height they take.
		local ran, extra = GF.HookValue("guideLayout", GF.SkinParts(), width, y)
		if ran and type(extra) == "number" and extra > 0 then y = y + extra end
		local showFoot = (state == "steps" or state == "complete" or state == "skippedout") and GF.On("progress")
			and GF.Shows("progressFoot", true)
		foot:SetShown(showFoot)
		local stripH = showStrip and SH or 0
		fit.outer = stripH + NAV_H + (showFoot and PROG_H or 0)
		fit.limit = roomAbove()
		-- ui.heightMode (the live window): "fixed" keeps the window at
		-- its height; with the progress bar under the last goal (ui.footAt) the
		-- free room goes past the bar (fit.follow).
		fit.fixedH = GF.live and ns.Get("ui.heightMode") == "fixed" or false
		fit.follow = showFoot and fit.fixedH and ns.Get("ui.footAt") ~= "edge" or false
		if fit.from then
			-- Past the cap (or the top of the screen with Grow upward), the goals
			-- area gives up the difference and scrolls.
			fit.h = y - fit.from
			fit.from = nil
			-- A skin may keep the goals area whole, the window as tall as it
			-- takes (GF.Shows "goalScroll" false).
			if GF.Shows("goalScroll", true) then
				-- The class quest card (UI/ClassToast.lua) counts against the cap
				-- while it shows: window and card together stay within ui.maxHeight.
				local toast = UI.ClassToast
				local toastRoom = toast and toast.Reserved and toast.Reserved() or 0
				local cap = capHeight() - toastRoom
				-- Whole items under the cap alone (fitGoals): at the top of the
				-- screen the window ends exactly on it (#666).
				fit.snap = cap <= (fit.limit or math.huge)
				fit.room = min(cap, fit.limit or math.huge) - (fit.outer + y - content)
			else
				fit.room = math.huge
			end
			fitGoals()
		else
			sizeWindow(y)
		end
		placeBars(showFoot)
		GF.PlaceGrip()
		band:SetHeight(stripH + NAV_H)
		local x0, x1, y0, y1 = Theme.BandCoords(width - 2, stripH + NAV_H, 30)
		if barsBottom() then y0, y1 = y1, y0 end
		band:SetTexCoord(x0, x1, y0, y1)
		GF.RenderTabStyle()
		GF.PaintProgress(false)
		if GF.live and UI.NameTargets then UI.NameTargets.Refresh() end
		GF.PaintShades()
	end

	-- Where the window's parts sit, for a host that shows only some of it (the
	-- settings preview cuts a window taller than its room and scrolls to the
	-- part a setting edits): each shown part as the last layout placed it,
	-- { name, frame, top, bottom } down the window in its own units, top down.
	-- Names: "bars" (no frame: the tabs and the navigator), "banner", "person",
	-- "goals" (each row and line of the goals area), "tip", the parts under the
	-- card by their guidePlace names ("here", "after", "along", "upnext",
	-- "party", "xp"), "foot". A part a skin placed itself is left out.
	function GF.Placed()
		local out = {}
		if not F then return out end
		local height = F:GetHeight()
		local barsH = (strip:IsShown() and strip:GetHeight() or 0) + nav:GetHeight()
		local flip = barsBottom()
		local bodyTop = flip and 0 or barsH
		local function add(name, frame, top, h)
			if not frame or frame:IsShown() then out[#out + 1] = { name, frame, top, top + h } end
		end
		-- A part stacked in the body (stack, fitGoals): its top's offset there.
		local function inBody(name, f)
			if not (f and f:IsShown()) then return end
			local _, rel, _, _, y = f:GetPoint(1)
			if rel == body then add(name, f, bodyTop - (y or 0), f:GetHeight()) end
		end
		add("bars", nil, flip and height - barsH or 0, barsH)
		inBody("banner", banner)
		if card:IsShown() then
			local cardTop = bodyTop - (card.psAnchor and card.psAnchor[5] or 0)
			local function inCard(f)
				local _, _, _, _, y = f:GetPoint(1)
				return cardTop - (y or 0)
			end
			if person:IsShown() then add("person", person, inCard(person), person:GetHeight()) end
			local goalsTop, scroll = inCard(goals), goals:GetVerticalScroll() or 0
			for _, f in ipairs(GF.CardItems()) do
				local y = GF.ItemTop(f)
				if y then add("goals", f, goalsTop + y - scroll, f:GetHeight()) end
			end
			local tip = card.Tip
			local _, under = tip:GetPoint(1)
			if under == goals then add("tip", tip, goalsTop + goals:GetHeight() + (tip.psGap or 2), tip:GetHeight()) end
		end
		for _, part in ipairs({ { "here", GF.here }, { "after", after }, { "along", along }, { "upnext", upnext }, { "party", GF.party }, { "xp", GF.xp } }) do
			inBody(part[1], part[2])
		end
		if foot:IsShown() then
			local footH = foot:GetHeight()
			add("foot", foot, flip and height - barsH - footH or height - footH, footH)
		end
		table.sort(out, function(a, b) return a[3] < b[3] end)
		return out
	end

	---------------------------------------------------------------------------
	-- Progress
	---------------------------------------------------------------------------

	-- The bar's count (Engine.ProgressSoon): nil while the Engine counts it over
	-- the next frames, which paint it then (paintLater, animated when any ask
	-- since was).
	local paintLater, laterAnimate
	local function progress(animate)
		local E = Engine()
		if not (E and E.GetProgress and E.GetGuide and E.GetGuide()) then return 0, 0 end
		local done, total
		if E.ProgressSoon then
			done, total = E.ProgressSoon(paintLater)
			if not done then
				laterAnimate = laterAnimate or animate
				return nil
			end
		else
			done, total = E.GetProgress()
		end
		return done or 0, total or 0
	end
	paintLater = function()
		local animate = laterAnimate
		laterAnimate = nil
		if F then GF.PaintProgress(animate) end
	end

	function GF.PaintProgress(animate)
		local done, total = progress(animate)
		-- Counting: the bar laid out at its last count until the count lands.
		if not done then
			if not foot.psTotal then return end
			done, total, animate = foot.psDone, foot.psTotal, false
		end
		local frac = total > 0 and min(1, done / total) or 0
		foot.Pct:SetText(floor(frac * 100 + 0.5) .. "%")
		local w = F:GetWidth() - PAD * 2 - (foot.Pct:IsShown() and 44 or 0)
		foot.Line:SetWidth(max(1, w))
		W.SetProgress(foot.Line, frac, w, animate)
		GF.PaintStatus(frac, foot.Pct:GetText())
		foot.psDone, foot.psTotal = done, total
		-- A skin's own progress (Skin API 2, hooks.guideProgress(foot, frac)).
		GF.Hook("guideProgress", foot, frac)
	end

	GF.StripShown = stripShown
end)
