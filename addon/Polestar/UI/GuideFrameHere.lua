-- The guide window's "While you're here" panel (UI/GuideFrame.lua).

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local UI, Theme, W, Anim, L, floor, max = ns.UI, ns.Theme, ns.Widgets, ns.Anim, ns.L, math.floor, math.max
	local Engine, compact, transparent, T, tooltipAnchor = GF.Engine, GF.Compact, GF.Transparent, GF.Text, GF.TooltipAnchor
	local whenReady = GF.WhenReady

	-- The window's parts and sizes, handed over by the core (GF.Bind).
	local F, body
	local PAD, ICON, TEXT_X, ROW_PAD
	GF.Bind(function(p, m)
		F, body = p.F, p.body
		PAD, ICON, TEXT_X, ROW_PAD = m.PAD, m.ICON, m.TEXT_X, m.ROW_PAD
	end)

	-- The "While you're here" panel (GF.BuildHere), `width` wide: its label,
	-- then its rows (GF.HereRow) as the step's goal rows lay out (the glyph on
	-- the first line, the text from TEXT_X, wrapping, never cut), each row's step
	-- under its text, its distance and close button on its first line's right.
	-- -> its height.
	GF.HERE_H = 28
	-- The panel's ground: in the house look a raised card (the control ground at
	-- the house's `raised` share under a hairline, Theme.House), its rows a size
	-- under the step's goals (body), so the step leads; in the other looks
	-- HERE_TINT of the accent in the window ground (Theme.AccentGround) with the
	-- accent edge. In the transparent style, which has no ground: the house
	-- look's light scrim shade (`clearShade`), else the accent alone at
	-- HERE_CLEAR, a light tint over the world (the text there is outlined,
	-- GF.ApplyStyle). Painted again on a look or style change, and on the panel's
	-- first showing: the hairline's frame is made then, not at login.
	GF.HERE_TINT = 0.22
	GF.HERE_CLEAR = 0.18
	function GF.PaintHerePanel(t)
		local raised, clear = Theme.House("raised"), transparent()
		if clear and raised then
			local r, g, b = Theme.Color("scrim")
			t:SetVertexColor(r, g, b, Theme.House("clearShade"))
		elseif clear then
			local r, g, b = Theme.Accent()
			t:SetVertexColor(r, g, b, GF.HERE_CLEAR)
		elseif raised then
			local r, g, b = Theme.Color("panelAlt")
			t:SetVertexColor(r, g, b, raised)
		else
			t:SetVertexColor(Theme.AccentGround(GF.HERE_TINT))
		end
		local here = GF.here
		local edge = here.psHairline
		if raised and not clear and not edge and here.psKey then
			edge = CreateFrame("Frame", nil, here.Body)
			edge:SetPoint("TOPLEFT", t, "TOPLEFT", 0, 0)
			edge:SetPoint("BOTTOMRIGHT", t, "BOTTOMRIGHT", 0, 0)
			here.psHairline = edge
		end
		if edge and raised and not clear then
			Theme.Border(edge, Theme.Color("border"))
		elseif edge then
			for _, e in ipairs(edge.psBorder or {}) do e:Hide() end
		end
		here.Edge:SetShown(not raised)
		for _, r in ipairs(here.Rows) do Theme.Font(r.Text, raised and "body" or "goal") end
	end
	function GF.LayoutHere(width)
		local here = GF.here
		local hb = here.Body
		local top = 3 + 6
		here.Label:ClearAllPoints()
		here.Label:SetPoint("TOPLEFT", hb, "TOPLEFT", PAD, -top)
		local y = top + floor(here.Label:GetStringHeight() + 0.5) + ROW_PAD
		for _, r in ipairs(here.Rows) do
			if r:IsShown() then
				local closeW = r.Close:GetWidth()
				local right = PAD - 4 + closeW + 4 + floor(r.Dist:GetStringWidth() + 1) + 8
				r.Icon:ClearAllPoints()
				r.Icon:SetPoint("CENTER", r, "TOPLEFT", PAD + ICON / 2, -16)
				r.Close:ClearAllPoints()
				r.Close:SetPoint("CENTER", r, "TOPRIGHT", -(PAD - 4 + closeW / 2), -16)
				r.Dist:ClearAllPoints()
				r.Dist:SetPoint("RIGHT", r.Close, "LEFT", -4, 0)
				r.Text:ClearAllPoints()
				r.Text:SetPoint("TOPLEFT", r, "TOPLEFT", TEXT_X, -8)
				local tw = max(40, width - TEXT_X - right)
				r.Text:SetWidth(tw)
				UI.FitCounts(r.Text)
				r.Sub:ClearAllPoints()
				r.Sub:SetPoint("TOPLEFT", r.Text, "BOTTOMLEFT", 0, -2)
				r.Sub:SetWidth(tw)
				local h = 8 + max(16, floor(r.Text:GetStringHeight() + 0.5)) + 4
				if r.Sub:IsShown() then h = h + 2 + floor(r.Sub:GetStringHeight() + 0.5) end
				r:ClearAllPoints()
				r:SetPoint("TOPLEFT", hb, "TOPLEFT", 0, -y)
				r:SetSize(width, h)
				y = y + h
			end
		end
		local h = max(GF.HERE_H, y + 3 + 3)
		hb:SetSize(width, h)
		here:SetHeight(h)
		return h
	end
	-- "While you're here" (Engine.GetWhileHereList): quick objectives of later
	-- steps close by, in their own panel under the step's goals (GF.BuildHere),
	-- in every window mode and style; the toast (UI/WhileHere.lua) says them only
	-- while the window is hidden. One row each, read as the step's goal rows
	-- ("Collect Fungal Spores 0/1", the target in its colour; a hand-in as the
	-- game words it), its step under it (not in the compact window). The panel
	-- slides in from the left as it fades in (Anim.BASE, strong ease-out) and
	-- slides back out faster (Anim.FAST) before the window closes the gap. Under
	-- ui.reduceMotion it only fades (Anim). psKey: the rows' "<step>:<goal>" on
	-- screen, nil while none is.
	GF.HERE_DIST = { round = 5 }

	-- Above the While-here rows, one row per running timer whose hand-in this
	-- guide's route does not make (Quests/Timed.lua, Timed.OffRoute): "Apothecary
	-- Zamah  42:00 left", under it "Thunder Bluff ~6 min · this guide doesn't go
	-- there" (in the compact window too: it is the line's point). A click points
	-- the arrow at the ender (Timed.AimOff), a right-click or its close button
	-- hides it until the timer ends (Timed.MuteOff). In combat these rows never
	-- come or go (GF.offs holds the list from before; the countdowns still run);
	-- PLAYER_REGEN_ENABLED catches up. With only these rows the panel's label
	-- reads "Timed quest". GF.offs: the off-route quests on screen. The live
	-- window's alone: the timers are the session's, not a copy's content.
	GF.offs = {}

	function GF.FillHere(E)
		local list = E.GetWhileHereList()
		local Timed = GF.live and ns.Timed or nil
		if Timed and Timed.OffRoute and not GF.InCombat() then GF.offs = Timed.OffRoute(GF.offs) end
		local offs = Timed and GF.offs or {}
		local nOff = #offs
		local tight = compact()
		local here = GF.here
		local body = here.Body
		if not ((list and list[1]) or nOff > 0) then
			local was = here.psKey
			here.psKey = nil
			for _, r in ipairs(here.Rows) do r.psView, r.psOff = nil, nil end
			if was and here:IsShown() and F:IsVisible() and not GF.catchingUp then
				Anim.To(body, "offsetX", 0, -6, Anim.FAST, "out")
				Anim.To(body, "alpha", body:GetAlpha(), 0, Anim.FAST, "out", function()
					if not here.psKey then
						here:Hide()
						GF.Layout()
					end
				end)
			elseif not Anim.IsRunning(body, "alpha") then
				here:Hide()
			end
			return
		end
		local keys = {}
		for k = 1, nOff do
			local q = offs[k]
			local r = GF.HereRow(k)
			r.psView, r.psOff, r.psAt = nil, q, nil
			keys[k] = "t" .. q
			r.Icon:SetTexture(Theme.VerbIcon("turnin"))
			-- A line gone in combat (handed in, failed) keeps its last words until
			-- the fight ends.
			local text, sub = Timed.OffText(q)
			if text then
				r.Text:SetText(text)
				r.Sub:SetText(sub)
			end
			r.Sub:SetShown(true)
			r.Dist:SetText("")
			r:Show()
		end
		for i, v in ipairs(list) do
			local r = GF.HereRow(nOff + i)
			r.psView, r.psOff, r.psAt = v, nil, i
			keys[nOff + i] = v.step .. ":" .. v.index
			r.Icon:SetTexture(Theme.VerbIcon(v.here == "turnin" and "turnin" or v.t))
			UI.SetCounted(r.Text, v.here ~= "work" and UI.HereText(v) or UI.GoalLine(v, nil, true))
			r.Sub:SetText(UI.HereStep(v))
			r.Sub:SetShown(not tight)
			r.Dist:SetText(v.yards and ns.FormatDistance(v.yards, GF.HERE_DIST) or "")
			r:Show()
		end
		for i = nOff + #list + 1, #here.Rows do
			here.Rows[i].psView, here.Rows[i].psOff = nil, nil
			here.Rows[i]:Hide()
		end
		here.Label:SetText(list[1] and L["While you're here"] or L["Timed quest"])
		-- The panel slides in when it comes; rows coming and going inside it do not.
		local fresh = here.psKey == nil
		local wasShown = here:IsShown()
		here.psKey = table.concat(keys, " ")
		here:Show()
		-- The house card's hairline is made on its first showing (GF.PaintHerePanel).
		if not wasShown and not here.psHairline and Theme.House("raised") then GF.PaintHerePanel(here.Panel) end
		if fresh and F:IsVisible() and not GF.catchingUp then
			Anim.To(body, "alpha", wasShown and body:GetAlpha() or 0, 1, Anim.BASE, "out")
			Anim.To(body, "offsetX", -8, 0, Anim.BASE, "out")
		elseif not Anim.IsRunning(body, "alpha") then
			body:SetAlpha(1)
			Anim.Anchor(body, "TOPLEFT", here, "TOPLEFT", 0, 0)
		end
	end

	-- WHILE_HERE_CHANGED: the line came, changed or went. A panel shown before
	-- and after at the same height lays out only itself and repaints the
	-- strings' shades (the Transparent look's); nothing else in the window reads
	-- the list. A panel that came, went or changed height lays out the window.
	function GF.HereChanged()
		if not F or GF.State() ~= "steps" or not GF.View() then return end
		local here = GF.here
		local was = here:IsShown() and not Anim.IsRunning(here.Body, "alpha") and here:GetHeight()
		GF.FillHere(Engine())
		if was and here:IsShown() and not Anim.IsRunning(here.Body, "alpha") and GF.LayoutHere(F:GetWidth()) == was then
			GF.PaintShades()
			return
		end
		GF.Layout()
	end

	-- WHILE_HERE_MOVED (yards, i): only row i's distance changed.
	function GF.HereMoved(yards, i)
		local here = GF.here
		local r = here and here.Rows[i or 1]
		if not (F and r and r.psView and type(yards) == "number") then return end
		r.Dist:SetText(ns.FormatDistance(yards, GF.HERE_DIST))
		-- A wider distance can wrap the text onto another line: lay the window out.
		if here:IsShown() then
			local was = here:GetHeight()
			if GF.LayoutHere(F:GetWidth()) ~= was then GF.Layout() end
		end
	end
	-- A row of the While you're here panel (GF.BuildHere), one per suggestion:
	-- the verb's glyph, the goal's line with its coloured target and count,
	-- wrapping like the step's own rows; its step under it; the distance and a
	-- close button on the right. Left-click leads the arrow there; right-click
	-- opens a menu: the game's quest log at its quest (ns.QuestLogMenuItem) and
	-- "Not now", which dismisses it around here (Engine.DismissWhileHere:
	-- twice, for the rest of the zone), as the close button does. A quest not in
	-- the log (a "take" row), or a client where the quest log can't open:
	-- right-click dismisses it straight away. psAt: its place in
	-- Engine.GetWhileHereList; psOff instead: an off-route timer's quest (GF.HereOff).
	function GF.HereRow(i)
		local here = GF.here
		local r = here.Rows[i]
		if r then return r end
		r = CreateFrame("Button", nil, here.Body)
		r.psAt = i
		r:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		W.Hover(r)
		r.Icon = r:CreateTexture(nil, "ARTWORK")
		r.Icon:SetSize(ICON, ICON)
		W.Color(r.Icon, "accent")
		r.Close = W.IconButton(r, "close", 18, L["Not now (right-click)"], function()
			if r.psOff then return GF.HereOff(r.psOff, "RightButton") end
			local E = Engine()
			if E and r.psAt then E.DismissWhileHere(r.psAt) end
		end)
		r.Dist = T(r, "small", "textMuted")
		r.Dist:SetJustifyH("RIGHT")
		r.Text = GF.SizeAs(T(r, Theme.House("raised") and "body" or "goal", "text"), "goal", 0)
		r.Text:SetWordWrap(true)
		r.Text:SetJustifyV("TOP")
		r.Sub = GF.SizeAs(T(r, "small", "textMuted"), "detail")
		r:SetScript("OnClick", function(self, button)
			if self.psOff then return GF.HereOff(self.psOff, button) end
			local E = Engine()
			if not (E and self.psAt) then return end
			if button ~= "RightButton" then return E.AimWhileHere(self.psAt) end
			local v = self.psView
			local show = v and ns.QuestLogMenuItem and ns.QuestLogMenuItem(v.quest)
			if not show or show.disabled then return E.DismissWhileHere(self.psAt) end
			W.ShowMenu(self, { show, { text = L["Not now"], icon = "close", onClick = function() E.DismissWhileHere(self.psAt) end } })
		end)
		r:SetScript("OnEnter", function(self)
			if self.psOff then
				W.Tooltip(self, tooltipAnchor(), self.Text:GetText() or "", {
					L["This guide's route doesn't hand this quest in: go there yourself before the time runs out, or let it go."],
					{ L["Click to point the arrow here"], Theme.Accent() },
					{ L["Right-click: hide this until the timer ends."], Theme.Color("textDim") },
				})
				GF.HoverIn()
				return
			end
			local v = self.psView
			if not v then return end
			local lines = { UI.HereStep(v, true) }
			local new = (v.here == "turnin" or v.here == "take") and ns.NewQuests and ns.NewQuests.TooltipText(v.quest)
			if new then lines[#lines + 1] = { new, Theme.Accent() } end
			local dungeon = v.quest and ns.Dungeons and ns.Dungeons.MarkTooltip and ns.Dungeons.MarkTooltip(v.quest)
			if dungeon then lines[#lines + 1] = { dungeon, Theme.Accent() } end
			lines[#lines + 1] = { L["Click to point the arrow here"], Theme.Accent() }
			local menu = ns.QuestLogMenuItem and ns.QuestLogMenuItem(v.quest)
			lines[#lines + 1] = { menu and not menu.disabled and L["Right-click: show in quest log, or not now around here (twice: for the rest of this zone)."]
				or L["Right-click: not now, around here (twice: for the rest of this zone)."], Theme.Color("textDim") }
			W.Tooltip(self, tooltipAnchor(), L["While you're here:"] .. " " .. UI.HereText(v), lines)
			GF.HoverIn()
		end)
		r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
		here.Rows[i] = r
		return r
	end

	-- An off-route timer's row clicked (GF.FillHere): the arrow to its ender, or
	-- (right button) the row hidden until the timer ends, at once, in combat too.
	function GF.HereOff(q, button)
		local Timed = ns.Timed
		if not Timed then return end
		if button ~= "RightButton" then
			Timed.AimOff(q)
			return
		end
		Timed.MuteOff(q)
		for k = #GF.offs, 1, -1 do
			if GF.offs[k] == q then table.remove(GF.offs, k) end
		end
		GF.HereChanged()
	end

	function GF.BuildHere()
		-- While you're here (fillHere): its own section under the step's goals,
		-- a panel (GF.PaintHerePanel: painted again when the look, the accent or
		-- the window style changes) with a small "While you're here" label, then
		-- one row per suggestion (GF.HereRow). `Body` carries what moves.
		local here = CreateFrame("Frame", nil, body)
		GF.here = here
		here.Rows = {}
		here:SetHeight(GF.HERE_H)
		local hb = CreateFrame("Frame", nil, here)
		hb:SetSize(300, GF.HERE_H)
		Anim.Anchor(hb, "TOPLEFT", here, "TOPLEFT", 0, 0)
		here.Body = hb
		here.Panel = hb:CreateTexture(nil, "BACKGROUND", nil, -6)
		here.Panel:SetTexture(Theme.Media("white"))
		here.Panel:SetPoint("TOPLEFT", hb, "TOPLEFT", PAD - 6, -3)
		here.Panel:SetPoint("BOTTOMRIGHT", hb, "BOTTOMRIGHT", -(PAD - 6), 3)
		-- The other looks' accent edge. The house card's hairline: GF.PaintHerePanel.
		here.Edge = hb:CreateTexture(nil, "ARTWORK")
		here.Edge:SetTexture(Theme.Media("white"))
		W.Color(here.Edge, "accent", 0.9)
		here.Edge:SetPoint("TOPLEFT", here.Panel, "TOPLEFT", 0, 0)
		here.Edge:SetPoint("BOTTOMLEFT", here.Panel, "BOTTOMLEFT", 0, 0)
		here.Edge:SetWidth(2)
		W.Painter(here.Panel, GF.PaintHerePanel)
		here.Label = T(hb, "small", "accent")
		here.Label:SetText(L["While you're here"])
		here:Hide()
	end
	if GF.live then
		ns.On("WHILE_HERE_CHANGED", whenReady(GF.HereChanged))
		ns.On("WHILE_HERE_MOVED", whenReady(GF.HereMoved))
	end
end)
