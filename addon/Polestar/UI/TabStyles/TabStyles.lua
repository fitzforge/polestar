-- UI/TabStyles/TabStyles.lua: the guide window's tab styles past
-- the underline strip (guideWindow.tabStyle; UI/GuideFrameTabStyles.lua
-- asks for them). "switcher" turns the navigator's
-- title into a menu of the open guides; "edge" stands small icon tabs on the
-- window's top edge; "strip" runs an icon column down the window's left
-- edge. Every style keeps a tab's clicks, tooltip and menu (GF.TabClick,
-- GF.TabTip, GF.TabMenu) and the limit of six tabs. A part of the window
-- (GF.Part): it joins the live window and every copy.

local ns = Polestar
ns.UI.GuideFrame.Part(function(GF)
	local UI, Theme, W, Anim, L, floor, max, min = ns.UI, ns.Theme, ns.Widgets, ns.Anim, ns.L, math.floor, math.max, math.min
	local Engine, T = GF.Engine, GF.Text
	local MAX_TABS = 6

	-- Sizes: an edge tab, its lit height and the row it stands in; a side
	-- strip's column, its buttons and their gap.
	local EDGE_W, EDGE_H, EDGE_ON_H, EDGE_ROW, EDGE_GAP, EDGE_IN = 30, 22, 25, 25, 3, 8
	local SIDE_W, SIDE_BTN_W, SIDE_BTN_H, SIDE_GAP, SIDE_PAD = 33, 29, 30, 2, 4

	local F, nav
	-- The window's style frames (UI/GuideFrameTabStyles.lua keeps them).
	local own
	GF.Bind(function(p)
		F, nav = p.F, p.nav
		own = GF.TabStyleFrames()
	end)

	local function full(n) return n >= MAX_TABS end
	local function addTip(n) return full(n) and L["Six tabs is the limit"] or L["Open a guide in a new tab"] end
	local function openPicker() UI.ShowPicker({ newTab = true }) end

	-- A 1px edge on the sides of `f` that `sides` names ("TOP", "LEFT",
	-- "RIGHT", "BOTTOM"), in the border wash.
	local function edges(f, sides)
		local out = {}
		for _, side in ipairs(sides) do
			local t = f:CreateTexture(nil, "BORDER")
			t:SetTexture(Theme.Media("white"))
			if side == "TOP" or side == "BOTTOM" then
				t:SetPoint(side .. "LEFT", f, side .. "LEFT", 0, 0)
				t:SetPoint(side .. "RIGHT", f, side .. "RIGHT", 0, 0)
				W.Painter(t, function(x) x:SetHeight(Theme.Pixel(f)) end)
			else
				t:SetPoint("TOP" .. side, f, "TOP" .. side, 0, 0)
				t:SetPoint("BOTTOM" .. side, f, "BOTTOM" .. side, 0, 0)
				W.Painter(t, function(x) x:SetWidth(Theme.Pixel(f)) end)
			end
			W.Color(t, "border")
			out[#out + 1] = t
		end
		return out
	end

	-- A tab frame in the window's own paint (an edge tab, the side strip):
	-- the skin's ground, border and shadow as the window has them (a
	-- guide window's, psGuide), so every look and theme carries over. The
	-- side it stands on (footOf(): psBorder's 1 top, 2 bottom, 3 left, 4
	-- right) is left open, the window's own line there cut under the active
	-- tab (cutUnder, cutBeside). It casts no shadow of its own: one over the
	-- window would darken it, and the window's own shadow is round them both.
	-- The house look's edge lines on that side (psSkin.edge: 1 the light, 2
	-- to 5 the top, bottom, left and right shade) go too: the shade would lie
	-- on the window's own top row as a dark seam under every tab.
	local FOOT_EDGES = { { 1, 2 }, { 3 }, { 4 }, { 5 } }
	local KIT_SIDE = { "TOP", "BOTTOM", "LEFT", "RIGHT" }
	local function windowPaint(f, footOf)
		f.psGuide = true
		f.psFootOf = footOf
		f.psAfterPaint = function(x)
			local side = x.psFootOf()
			local border = rawget(x, "psBorder")
			local foot = border and border[side]
			if foot then foot:SetAlpha(0) end
			local skin = rawget(x, "psSkin")
			local e = skin and skin.edge
			if e then for _, i in ipairs(FOOT_EDGES[side] or {}) do if e[i] then e[i]:SetAlpha(0) end end end
			local sd = rawget(x, "psShadow")
			if sd then sd:Hide() end
			-- A game look's own frame (its chat rim, meter or bronze line) open
			-- on that side too, so the tab runs into the window's frame and
			-- does not stand beside it as a box of its own.
			if Theme.KitOpen then Theme.KitOpen(x, KIT_SIDE[side]) end
		end
		Theme.Skin(f, "window")
	end

	-- An icon tab (edge, strip): its ground, the lit ground of the active
	-- one, the accent mark, the glyph. kind: "tab" or "add".
	local function iconTab(parent, kind, style)
		local b = CreateFrame("Button", nil, parent)
		b.psStyle = style
		b.Ground = W.Fill(b, "sidebar", "BACKGROUND", -6)
		b.Selected = W.Fill(b, "bg", "BACKGROUND", -5)
		b.Selected:Hide()
		b.Hover = W.Hover(b, 0.7)
		b.Bar = b:CreateTexture(nil, "OVERLAY")
		b.Bar:SetTexture(Theme.Media("white"))
		W.Color(b.Bar, "accent")
		b.Bar:Hide()
		b.Icon = b:CreateTexture(nil, "ARTWORK")
		b.Icon:SetSize(13, 13)
		b.Icon:SetPoint("CENTER", b, "CENTER", 0, 0)
		W.Color(b.Icon, "textMuted")
		if style == "edge" and kind == "tab" then
			-- The window's own paint (windowPaint), its foot open on the window.
			windowPaint(b, function() return GF.BarsBottom() and 1 or 2 end)
			b.Ground:Hide()
			b.Bar:SetHeight(2)
		elseif style == "edge" then
			b.Edges = edges(b, { "TOP", "LEFT", "RIGHT" })
			b.Bar:SetHeight(2)
		else
			b.Bar:SetWidth(2)
		end
		b:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
		if kind == "tab" then
			b:SetScript("OnClick", GF.TabClick)
			b:SetScript("OnEnter", function(self)
				if not self.psActive then W.Color(self.Icon, "textDim") end
				GF.TabTip(self, style == "edge" and "ANCHOR_TOP" or "ANCHOR_LEFT")
			end)
			b:SetScript("OnLeave", function(self)
				if not self.psActive then W.Color(self.Icon, "textMuted") end
				W.HideTooltip(self)
			end)
			-- Its parts for a skin's hooks.guideTab, with the style they are drawn in.
			b.psParts = { selected = b.Selected, bar = b.Bar, icon = b.Icon, style = style }
		else
			b.Icon:SetTexture(Theme.Media("plus"))
			b:SetScript("OnClick", function(self, button)
				if button ~= "LeftButton" or not self:IsEnabled() then return end
				openPicker()
			end)
			b:SetScript("OnEnter", function(self)
				if self:IsEnabled() then W.Color(self.Icon, "text") end
				W.Tooltip(self, style == "edge" and "ANCHOR_TOP" or "ANCHOR_LEFT", self.psTip or "")
				GF.HoverIn()
			end)
			b:SetScript("OnLeave", function(self)
				W.Color(self.Icon, "textMuted", self:IsEnabled() and 1 or 0.35)
				W.HideTooltip(self)
			end)
		end
		return b
	end

	-- The switcher: the navigator's title as a button with the tab count and
	-- a chevron; its menu lists the open guides.
	local function switcherMenu(self)
		local E = Engine()
		local tabs, active = GF.TabsOf(E)
		if not tabs then return end
		local n = #tabs
		local items = { { heading = true, text = L["Open guides"], right = string.format(L["%d of %d"], n, MAX_TABS) } }
		local probe = {}
		for i, t in ipairs(tabs) do
			GF.TabFacts(probe, t)
			local num, total = t.stepNumber or t.stepIndex, t.stepTotal or t.stepCount
			items[#items + 1] = {
				text = probe.psTitle, icon = probe.psIcon, sub = probe.psRange, marked = i == active,
				right = (num and total) and (num .. "/" .. total) or nil,
				onClick = function() if i ~= active and E.SelectTab then E.SelectTab(i) end end,
				onRemove = function()
					if E.CloseTab then E.CloseTab(i) end
					-- What is left, in the menu again.
					if own and own.switch and own.switch:IsShown() and #(GF.TabsOf(Engine()) or {}) > 0 then switcherMenu(own.switch) end
				end,
				removeTip = L["Close tab"],
			}
		end
		items[#items + 1] = { separator = true }
		items[#items + 1] = { text = L["Open a guide in a new tab"], icon = "plus", disabled = full(n),
			tip = full(n) and L["Six tabs is the limit"] or nil, onClick = openPicker }
		local reopen = GF.ReopenItem()
		if reopen then
			if reopen.tip and #reopen.tip <= 28 then reopen.sub, reopen.tip = reopen.tip, nil end
			items[#items + 1] = reopen
		end
		W.ShowMenu(self, items, { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -3, minWidth = 260 })
	end

	local function makeSwitch()
		local b = CreateFrame("Button", nil, nav)
		b:SetHeight(30)
		b:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
		b.Hover = W.Hover(b, 0.7)
		b.Icon = b:CreateTexture(nil, "ARTWORK")
		b.Icon:SetSize(14, 14)
		W.Color(b.Icon, "accent")
		b.Label = GF.SizeAs(T(b, "small", "textDim"), "bar")
		b.Badge = CreateFrame("Frame", nil, b)
		b.Badge:SetHeight(15)
		b.Badge.Fill = W.Fill(b.Badge, "accent", "BACKGROUND", -4)
		b.Badge.Text = T(b.Badge, "small", "onAccent")
		b.Badge.Text:SetPoint("CENTER", b.Badge, "CENTER", 0, 0)
		b.Chevron = W.Tex(b, "ARTWORK", "chevron-down", "textMuted")
		b.Chevron:SetSize(10, 10)
		b:SetScript("OnClick", function(self, button)
			local E = Engine()
			if not E then return end
			if button == "RightButton" then return GF.TabMenu(self) end
			if button == "MiddleButton" then
				if E.CloseTab then E.CloseTab(self.psIndex) end
				return
			end
			if W.MenuShown(self) then return W.HideMenu() end
			W.HideTooltip(self)
			switcherMenu(self)
		end)
		b:SetScript("OnEnter", function(self)
			W.Color(self.Label, "text")
			if not W.MenuShown(self) then GF.TabTip(self, "ANCHOR_BOTTOM") end
		end)
		b:SetScript("OnLeave", function(self)
			W.Color(self.Label, "textDim")
			W.HideTooltip(self)
		end)
		b.psMenuAt = { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -3 }
		b:Hide()
		return b
	end

	local function switchOf() return own.switch or GF.AdoptTabFrame("switch", makeSwitch()) end

	-- The edge row: above the top edge, or under the bottom one when the bars sit there.
	local function edgeOf()
		if own.edge then return own.edge end
		local e = CreateFrame("Frame", nil, F)
		e:SetHeight(EDGE_ROW)
		e.tabs = {}
		e.Add = iconTab(e, "add", "edge")
		e.Add.Ground:Hide()
		for _, t in ipairs(e.Add.Edges) do W.Color(t, "border", 0.6) end
		e:Hide()
		return GF.AdoptTabFrame("edge", e)
	end

	-- The side strip: a column outside the window's left edge.
	local function sideOf()
		if own.side then return own.side end
		local s = CreateFrame("Frame", nil, F)
		s:SetWidth(SIDE_W)
		windowPaint(s, function() return 4 end)
		s.tabs = {}
		s.Add = iconTab(s, "add", "strip")
		s.Add.Ground:Hide()
		s:Hide()
		return GF.AdoptTabFrame("side", s)
	end

	-- The window's own ground on a tab (or the side strip): its opacity
	-- (guideWindow.bgOpacity, ui.bgOpacity), none and no edges in the
	-- transparent style. The accent mark and the glyph stay.
	-- A tab in the window's paint takes its ground colour and its border too
	-- (guideWindow.bgColor, guideWindow.border), so the lit tab runs into the
	-- window in one tone.
	local function ground(b)
		local a = F.psBare and 0 or (F.psBgAlpha or Theme.GroundAlpha())
		if rawget(b, "psFootOf") then
			b.psBare, b.psBgAlpha, b.psBgColor, b.psNoBorder = F.psBare, F.psBgAlpha, F.psBgColor, F.psNoBorder
			Theme.Repaint(b)
		end
		if rawget(b, "Ground") then b.Ground:SetAlpha(a) end
		if rawget(b, "Selected") then b.Selected:SetAlpha(a) end
		for _, t in ipairs(rawget(b, "Edges") or {}) do t:SetShown(not F.psBare) end
	end

	local function paintIconTab(b, active)
		b.psActive = active
		-- A tab in the window's paint (an edge tab) or on the strip has the
		-- window's own ground: the lit one is that ground joined to the window.
		local painted = rawget(b, "psFootOf") or b.psStyle == "strip"
		b.Selected:SetShown(active and not painted)
		b.Ground:SetShown(not active and not painted)
		b.Bar:SetShown(active)
		W.Color(b.Icon, active and "accent" or "textMuted")
		Theme.SkinHook("guideTab", b, b.psParts, active)
	end

	local function fillTab(b, i, t, active)
		b.psIndex = i
		GF.TabFacts(b, t)
		b.Icon:SetTexture(Theme.Media(b.psIcon))
		paintIconTab(b, i == active)
	end

	-- The window's lines along the edge the tabs stand on (its border, and
	-- in the house look the inner light and the outer shade) are cut under
	-- the active tab, so the tab and the window read as one shape: each line
	-- is hidden (its alpha, taken again after a repaint) and drawn again
	-- as two pieces that stop at the tab's sides, in the line's own colour.
	local cuts = setmetatable({}, { __mode = "k" }) -- line -> { l, r, on }

	local function edgeLines(bottom)
		local out = {}
		local border = rawget(F, "psBorder")
		if border then out[#out + 1] = border[bottom and 2 or 1] end
		local skin = rawget(F, "psSkin")
		local e = skin and skin.edge
		if e then
			if not bottom then out[#out + 1] = e[1] end
			out[#out + 1] = e[bottom and 3 or 2]
		end
		return out
	end

	local function mirror(t)
		local c = cuts[t]
		if not (c and c.on) then return end
		-- A texture's alpha and its colour's are one value: a repaint gives the
		-- line its alpha back, which the pieces keep and the line gives up.
		local r, g, b, a = t:GetVertexColor()
		if a and a > 0 then
			c.alpha = a
			t:SetAlpha(0)
		end
		for _, piece in ipairs({ c.l, c.r }) do
			piece:SetVertexColor(r, g, b, c.alpha or 1)
			piece:SetShown(t:IsShown())
		end
	end

	local function uncut()
		for t, c in pairs(cuts) do
			if c.on then
				c.on = false
				c.l:Hide(); c.r:Hide()
				t:SetAlpha(c.alpha or 1)
			end
		end
	end

	local function cutUnder(b, bottom)
		local live = {}
		local px = Theme.Pixel(F)
		local bl, br = b:GetLeft(), b:GetRight()
		for _, t in ipairs(bl and br and not F.psBare and edgeLines(bottom) or {}) do
			local tl = t:GetLeft()
			if tl then
				local c = cuts[t]
				if not c then
					local layer, sub = t:GetDrawLayer()
					c = { l = F:CreateTexture(nil, layer, nil, sub), r = F:CreateTexture(nil, layer, nil, sub) }
					c.l:SetTexture(Theme.Media("white")); c.r:SetTexture(Theme.Media("white"))
					cuts[t] = c
					for _, m in ipairs({ "SetVertexColor", "Show", "Hide", "SetShown" }) do
						hooksecurefunc(t, m, function() mirror(t) end)
					end
				end
				local h = t:GetHeight()
				c.l:ClearAllPoints()
				c.l:SetPoint("TOPLEFT", t, "TOPLEFT", 0, 0)
				c.l:SetPoint("TOPRIGHT", t, "TOPLEFT", max(0, bl + px - tl), 0)
				c.l:SetHeight(h)
				c.r:ClearAllPoints()
				c.r:SetPoint("TOPLEFT", t, "TOPLEFT", br - px - tl, 0)
				c.r:SetPoint("TOPRIGHT", t, "TOPRIGHT", 0, 0)
				c.r:SetHeight(h)
				-- The line's own alpha (a layout may have hidden it), given back
				-- when the cut ends.
				if not c.on then c.alpha = select(4, t:GetVertexColor()) end
				c.on = true
				t:SetAlpha(0)
				mirror(t)
				live[t] = true
			end
		end
		for t, c in pairs(cuts) do
			if c.on and not live[t] then c.on = false; c.l:Hide(); c.r:Hide(); t:SetAlpha(c.alpha or 1) end
		end
		-- The tab's own sides and cap in the window border's colour, so the
		-- two outlines meet in one colour.
		local border = rawget(F, "psBorder")
		local line = border and border[bottom and 2 or 1]
		local token = (line and line:IsShown()) and "windowBorder" or "border"
		for _, e in ipairs(rawget(b, "Edges") or {}) do W.Color(e, token) end
	end

	-- The side strip's lit tab: the window's left line cut beside it (the
	-- strip's own right line is open, windowPaint), the two pieces above
	-- and below it in the line's colour.
	local function cutBeside(b)
		local border = rawget(F, "psBorder")
		local t = border and border[3]
		local bt, bb = b:GetTop(), b:GetBottom()
		local tt = t and t:GetTop()
		if F.psBare or not (t and bt and bb and tt) then return uncut() end
		local px = Theme.Pixel(F)
		local c = cuts[t]
		if not c then
			local layer, sub = t:GetDrawLayer()
			c = { l = F:CreateTexture(nil, layer, nil, sub), r = F:CreateTexture(nil, layer, nil, sub) }
			c.l:SetTexture(Theme.Media("white")); c.r:SetTexture(Theme.Media("white"))
			cuts[t] = c
			for _, m in ipairs({ "SetVertexColor", "Show", "Hide", "SetShown" }) do
				hooksecurefunc(t, m, function() mirror(t) end)
			end
		end
		local w = t:GetWidth()
		c.l:ClearAllPoints()
		c.l:SetPoint("TOPLEFT", t, "TOPLEFT", 0, 0)
		c.l:SetPoint("BOTTOMLEFT", t, "TOPLEFT", 0, -max(0, tt - bt + px))
		c.l:SetWidth(w)
		c.r:ClearAllPoints()
		c.r:SetPoint("TOPLEFT", t, "TOPLEFT", 0, -(tt - bb - px))
		c.r:SetPoint("BOTTOMLEFT", t, "BOTTOMLEFT", 0, 0)
		c.r:SetWidth(w)
		c.on = true
		t:SetAlpha(0)
		mirror(t)
		for x, o in pairs(cuts) do
			if x ~= t and o.on then o.on = false; o.l:Hide(); o.r:Hide(); x:SetAlpha(1) end
		end
	end

	-- How far the window's own lines reach past the edge the tabs stand on:
	-- a border thicker than a pixel grows outward, and the house look's
	-- shade lies just outside it. The tabs not lit stand past them, so the
	-- window's edge runs whole under them and they tuck behind it.
	local function outside(bottom)
		if F.psBare then return 0 end
		local px, h = Theme.Pixel(F), 0
		local border = rawget(F, "psBorder")
		local line = border and border[bottom and 2 or 1]
		if line and line:IsShown() then h = px * max(0, (F.psBorderSize or 1) - 1) end
		local skin = rawget(F, "psSkin")
		local shade = skin and skin.edge and skin.edge[bottom and 3 or 2]
		if shade and shade:IsShown() then h = h + px end
		return h
	end

	local function renderEdge(tabs, active)
		local e = edgeOf()
		local bottom = GF.BarsBottom()
		e:ClearAllPoints()
		if bottom then
			e:SetPoint("TOPLEFT", F, "BOTTOMLEFT", EDGE_IN, 0)
			e:SetPoint("TOPRIGHT", F, "BOTTOMRIGHT", -EDGE_IN, 0)
		else
			e:SetPoint("BOTTOMLEFT", F, "TOPLEFT", EDGE_IN, 0)
			e:SetPoint("BOTTOMRIGHT", F, "TOPRIGHT", -EDGE_IN, 0)
		end
		-- The side the tabs stand on: their foot meets the window's edge.
		local foot = bottom and "TOP" or "BOTTOM"
		local cap = bottom and "BOTTOM" or "TOP"
		local x = 0
		local n = #tabs
		local lift = outside(bottom) * (bottom and -1 or 1)
		for i = 1, n do
			local b = e.tabs[i]
			if not b then
				b = iconTab(e, "tab", "edge")
				e.tabs[i] = b
			end
			b.psMenuAt = bottom and { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -2 }
				or { point = "BOTTOMLEFT", relPoint = "TOPLEFT", x = 0, y = 2 }
			fillTab(b, i, tabs[i], active)
			b:SetSize(EDGE_W, b.psActive and EDGE_ON_H or EDGE_H)
			b:ClearAllPoints()
			-- The active tab stands on the window's edge, the window's lines
			-- cut under it (cutUnder); the others just past those lines.
			b:SetPoint(foot .. "LEFT", e, foot .. "LEFT", x, b.psActive and 0 or lift)
			b.Bar:ClearAllPoints()
			b.Bar:SetPoint(cap .. "LEFT", b, cap .. "LEFT", 0, 0)
			b.Bar:SetPoint(cap .. "RIGHT", b, cap .. "RIGHT", 0, 0)
			b:SetFrameLevel(e:GetFrameLevel() + (b.psActive and 3 or 1))
			b:Show()
			x = x + EDGE_W + EDGE_GAP
		end
		for i = n + 1, #e.tabs do e.tabs[i]:Hide() end
		e.Add:SetSize(EDGE_W, EDGE_H)
		e.Add:ClearAllPoints()
		e.Add:SetPoint(foot .. "LEFT", e, foot .. "LEFT", x, lift)
		e.Add.psTip = addTip(n)
		if full(n) then e.Add:Disable() else e.Add:Enable() end
		W.Color(e.Add.Icon, "textMuted", full(n) and 0.35 or 1)
		for _, b in ipairs(e.tabs) do ground(b) end
		ground(e.Add)
		e:Show()
		local on = active and e.tabs[active]
		if on and on:IsShown() then cutUnder(on, bottom) else uncut() end
		for i, b in ipairs(e.tabs) do
			if i ~= active then for _, t in ipairs(rawget(b, "Edges") or {}) do W.Color(t, "border") end end
		end
	end

	local function renderSide(tabs, active)
		local s = sideOf()
		local bottom = GF.BarsBottom()
		local n = #tabs
		s:ClearAllPoints()
		-- Over the window's edge by its kit frame's clear rim (Theme.KitSeam),
		-- so no gap shows between the strip and the window's frame.
		local seam = (not F.psBare and Theme.KitSeam) and Theme.KitSeam(F) or 0
		if bottom then
			s:SetPoint("BOTTOMRIGHT", F, "BOTTOMLEFT", seam, 0)
		else
			s:SetPoint("TOPRIGHT", F, "TOPLEFT", seam, 0)
		end
		local y = SIDE_PAD
		for i = 1, n do
			local b = s.tabs[i]
			if not b then
				b = iconTab(s, "tab", "strip")
				b.Bar:SetPoint("TOPLEFT", b, "TOPLEFT", 0, -5)
				b.Bar:SetPoint("BOTTOMLEFT", b, "BOTTOMLEFT", 0, 5)
				s.tabs[i] = b
			end
			b.psMenuAt = { point = "TOPRIGHT", relPoint = "TOPLEFT", x = -2, y = 0 }
			fillTab(b, i, tabs[i], active)
			b.Ground:Hide()
			b:SetSize(b.psActive and SIDE_BTN_W + 1 or SIDE_BTN_W, SIDE_BTN_H)
			b:ClearAllPoints()
			-- The active one reaches over the window's left edge, one pixel in.
			b:SetPoint("TOPLEFT", s, "TOPLEFT", SIDE_PAD - 1, -y)
			b:Show()
			y = y + SIDE_BTN_H + SIDE_GAP
		end
		for i = n + 1, #s.tabs do s.tabs[i]:Hide() end
		s.Add:SetSize(SIDE_BTN_W, SIDE_BTN_H)
		s.Add:ClearAllPoints()
		s.Add:SetPoint("TOPLEFT", s, "TOPLEFT", SIDE_PAD - 1, -y)
		s.Add.psTip = addTip(n)
		if full(n) then s.Add:Disable() else s.Add:Enable() end
		W.Color(s.Add.Icon, "textMuted", full(n) and 0.35 or 1)
		s:SetHeight(y + SIDE_BTN_H + SIDE_PAD)
		for _, b in ipairs(s.tabs) do ground(b) end
		ground(s.Add)
		ground(s)
		s:Show()
		local on = active and s.tabs[active]
		if on and on:IsShown() then cutBeside(on) else uncut() end
	end

	-- Where the switcher starts: at the title's left anchor. A layout's glyph
	-- before the title (Atlas's emblem) is the switcher's own icon.
	local function renderSwitch(tabs, active)
		local b = switchOf()
		local t = tabs[active] or tabs[1]
		if not t then return b:Hide() end
		b.psIndex = active or 1
		b.psActive = true
		GF.TabFacts(b, t)
		local _, rel, relPoint, ox = nav.Title:GetPoint(1)
		ox = tonumber(ox) or 8
		local glyph = rel and rel ~= nav and rel ~= nav.Steps and rel.GetObjectType and rel:GetObjectType() == "Texture" and rel or nil
		b:ClearAllPoints()
		-- textX: the label's inset; back: how far left of the title the switcher starts.
		local textX, back
		if glyph then
			b:SetPoint("LEFT", glyph, "LEFT", -5, 0)
			b.Icon:Hide()
			textX = 5 + floor((glyph:GetWidth() or 16) + 0.5) + ox
			back = textX
		else
			b:SetPoint("LEFT", rel or nav, relPoint or "LEFT", ox - 7, 0)
			b.Icon:SetTexture(Theme.Media(b.psIcon))
			b.Icon:ClearAllPoints()
			b.Icon:SetPoint("LEFT", b, "LEFT", 7, 0)
			b.Icon:Show()
			textX, back = 7 + 14 + 8, 7
		end
		-- The title's own face (a layout may set it).
		local path, size, flags = nav.Title:GetFont()
		if path then b.Label:SetFont(path, size, flags) end
		b.Label:SetText(b.psTitle or "")
		b.Label:SetWidth(0)
		local natural = floor(b.Label:GetStringWidth() + 1)
		local n = #tabs
		local count = b.Badge.Text
		count:SetText(tostring(n))
		local badgeW = n > 1 and max(15, floor(count:GetStringWidth() + 1) + 10) or 0
		b.Badge:SetWidth(max(1, badgeW))
		b.Badge:SetShown(n > 1)
		if n > (b.psCount or n) and n > 1 then Anim.To(b.Badge, "alpha", 0.25, 1, Anim.BASE, "out") end
		b.psCount = n
		local tail = (badgeW > 0 and badgeW + 6 or 0) + 10 + 8
		-- The room the title had: its width at its anchors, at least 40; on
		-- screen, up to the first control right of it.
		local room = max(40, floor((nav.Title:GetWidth() or 0) + 0.5)) + back
		b:SetWidth(1)
		local left = b:GetLeft()
		if type(left) == "number" and left > 0 then
			local edge
			for _, c in ipairs({ nav.Steps, nav.Skip, nav.Nearby, nav.Report, nav.Lookup, nav.Menu }) do
				local l = c:IsShown() and c:GetLeft()
				if type(l) == "number" and l > left + 10 and (not edge or l < edge) then edge = l end
			end
			if edge then room = max(room, floor(edge - left - 6)) end
		end
		local labelW = max(10, min(natural, room - textX - tail))
		b.Label:SetWidth(labelW)
		b.Label:ClearAllPoints()
		b.Label:SetPoint("LEFT", b, "LEFT", textX, 0)
		b.Badge:ClearAllPoints()
		b.Badge:SetPoint("LEFT", b.Label, "RIGHT", 6, 0)
		b.Chevron:ClearAllPoints()
		b.Chevron:SetPoint("LEFT", badgeW > 0 and b.Badge or b.Label, "RIGHT", badgeW > 0 and 6 or 8, 0)
		b:SetWidth(textX + labelW + tail)
		nav.Title:Hide()
		b:Show()
	end

	local function hide(f) if f then f:Hide() end end

	-- The style's frames, made the first time it is drawn (GF.PlaceTabStyle,
	-- before the layout's hooks).
	function GF.TabStyleBuild(style)
		if not own then return end
		if style == "switcher" then switchOf() elseif style == "edge" then edgeOf() elseif style == "strip" then sideOf() end
	end

	-- Draw `style`'s tabs and hide the others' (GF.RenderTabStyle).
	function GF.TabStyleDraw(style)
		if not own then return end
		local tabs, active
		if style and style ~= "underline" then tabs, active = GF.TabsOf(Engine()) end
		if style and style ~= "underline" and not tabs then style = nil end
		if style == "switcher" then renderSwitch(tabs, active) else hide(own.switch) end
		if style == "edge" then renderEdge(tabs, active) else hide(own.edge); uncut() end
		if style == "strip" then renderSide(tabs, active) else hide(own.side); if style ~= "edge" then uncut() end end
	end

	-- How far `style` reaches past the window's left and top edges (GF.TabsOutside). -> left, top
	function GF.TabStyleReach(style)
		if style == "strip" then return SIDE_W, 0 end
		if style == "edge" then return 0, EDGE_ON_H end
		return 0, 0
	end
end)
