-- The guide window's tab strip: one tab per open guide (UI/GuideFrame.lua).

local ADDON, ns = ...
ns.UI.GuideFrame.Part(function(GF)
	local UI, Theme, W, L, floor, max, min = ns.UI, ns.Theme, ns.Widgets, ns.L, math.floor, math.max, math.min
	local Engine, T, tabButtons = GF.Engine, GF.Text, GF.tabs

	-- The window's parts and sizes, handed over by the core (GF.Bind).
	local F, strip
	local TAB_H, TAB_MAX_W
	GF.Bind(function(p, m)
		F, strip = p.F, p.strip
		TAB_H, TAB_MAX_W = m.TAB_H, m.TAB_MAX_W
	end)

	---------------------------------------------------------------------------
	-- Tab strip
	---------------------------------------------------------------------------

	-- counts: with each tab's done and total (Engine.GetTabs), which only a tab's
	-- tooltip shows: the strip leaves them out on its every repaint.
	local function tabsOf(E, counts)
		if not (E and E.GetTabs) then return nil, nil end
		local ok, tabs, active = pcall(E.GetTabs, counts)
		if not ok or type(tabs) ~= "table" then return nil, nil end
		return tabs, active
	end

	local function tabMenu(self)
		local E = Engine()
		local i = self.psIndex
		local tabs = tabsOf(E) or {}
		local items = {
			-- The picker loads into the active tab, so this tab becomes the active one first.
			{ text = L["Choose guide"], icon = "search", onClick = function()
				if E.SelectTab and not self.psActive then E.SelectTab(i) end
				UI.ShowPicker()
			end },
			{ text = L["Close tab"], icon = "close", onClick = function() E.CloseTab(i) end },
			{ text = L["Move left"], icon = "chevron-left", disabled = i <= 1, onClick = function() E.MoveTab(i, i - 1) end },
			{ text = L["Move right"], icon = "chevron-right", disabled = i >= #tabs, onClick = function() E.MoveTab(i, i + 1) end },
		}
		local reopen = GF.ReopenItem()
		if reopen then table.insert(items, 3, reopen) end
		W.ShowMenu(self, items, { point = "TOPLEFT", relPoint = "BOTTOMLEFT", x = 0, y = -2 })
	end

	-- A tab's label: the title, then its level range in a dimmer string. The
	-- range tells same-named guides apart, so it keeps its width and the title
	-- truncates, clear of the close button at the right (TAB_CLOSE_PAD; a skin's
	-- guideTabClosePad).
	-- Too narrow for even the range, the tab is its glyph alone.
	local TAB_TEXT_X = 27 -- the label's left edge: the glyph's inset, width and gap
	local TAB_RANGE_GAP = 4
	local TAB_CLOSE_PAD = 20
	-- The close button at rest: faint, so players find it; in full under the
	-- pointer (a skin's guideTabCloseRest).
	local TAB_CLOSE_REST = 0.35
	local function closeRest() return Theme.Metric("guideTabCloseRest", TAB_CLOSE_REST) end
	GF.TabCloseRest = closeRest
	local function layoutTab(b)
		-- A skin whose tab outline stands in from the tab's sides (WoW Forever's,
		-- metric guideTabInset) keeps the close button and the text inside it.
		local room = b:GetWidth() - TAB_TEXT_X - Theme.Metric("guideTabClosePad", TAB_CLOSE_PAD) - Theme.Metric("guideTabInset", 0)
		local rangeW = b.psRange and (floor(b.Range:GetStringWidth() + 1) + TAB_RANGE_GAP) or 0
		local fits = rangeW <= room
		local titleW = fits and min(b.psTitleW, room - rangeW) or 0
		b.Label:SetShown(titleW >= 1)
		if titleW >= 1 then b.Label:SetWidth(titleW) end
		b.Range:SetShown(b.psRange and fits or false)
		b.Range:ClearAllPoints()
		b.Range:SetPoint("LEFT", b.Icon, "RIGHT", 6 + (titleW >= 1 and titleW + TAB_RANGE_GAP or 0), 0)
	end

	-- With ui.growUp and ui.barsBottom the tab strip and navigator sit at the
	-- bottom, by the edge the window is pinned to, with the progress foot above
	-- the navigator. Otherwise the order runs strip, navigator, body, foot.
	local function barsBottom()
		return ns.Get("ui.growUp") and ns.Get("ui.barsBottom") and true or false
	end

	local function tabButton(i)
		local b = tabButtons[i]
		if b then return b end
		b = CreateFrame("Button", nil, strip)
		b:SetHeight(TAB_H)
		b:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
		b.Selected = b:CreateTexture(nil, "BACKGROUND")
		b.Selected:SetTexture(Theme.Media("white"))
		b.Selected:SetAllPoints(b)
		W.Painter(b.Selected, function(t) t:SetVertexColor(Theme.Wash("hover")) end)
		W.Hover(b, 0.7)
		b.Bar = b:CreateTexture(nil, "OVERLAY")
		b.Bar:SetTexture(Theme.Media("white"))
		b.Bar:SetHeight(2)
		local edge = barsBottom() and "TOP" or "BOTTOM"
		b.Bar:SetPoint(edge .. "LEFT", b, edge .. "LEFT", 0, 0)
		b.Bar:SetPoint(edge .. "RIGHT", b, edge .. "RIGHT", 0, 0)
		W.Color(b.Bar, "accent")
		b.Icon = b:CreateTexture(nil, "ARTWORK")
		b.Icon:SetSize(12, 12)
		b.Icon:SetPoint("LEFT", b, "LEFT", 9, 0)
		b.Label = GF.SizeAs(T(b, "small", "textDim"), "bar")
		b.Label:SetPoint("LEFT", b.Icon, "RIGHT", 6, 0)
		b.Range = GF.SizeAs(T(b, "small", "textMuted"), "bar")
		b.Close = W.IconButton(b, "close", 16, L["Close tab"], function(self)
			local E = Engine()
			if E and E.CloseTab then E.CloseTab(self:GetParent().psIndex) end
		end, 9)
		b.Close:SetPoint("RIGHT", b, "RIGHT", -3, 0)
		-- The game's looks draw a tab's close art at one size (Theme.KitIconButton).
		b.Close.psTabClose = true
		Theme.KitIconButton(b.Close)
		b.Close:SetAlpha(closeRest())
		b.Close.psOnEnter = function(c) c:SetAlpha(1) end
		b.Close.psOnLeave = function(c) if not c:GetParent():IsMouseOver() then c:SetAlpha(closeRest()) end end
		-- Its parts for a skin's hooks.guideTab (Skin API 2), made once.
		b.psParts = { selected = b.Selected, bar = b.Bar, label = b.Label, range = b.Range, icon = b.Icon, close = b.Close }
		b:SetScript("OnClick", function(self, button)
			local E = Engine()
			if not E then return end
			if button == "RightButton" then return tabMenu(self) end
			if button == "MiddleButton" and E.CloseTab then return E.CloseTab(self.psIndex) end
			if E.SelectTab and not self.psActive then E.SelectTab(self.psIndex) end
		end)
		b:SetScript("OnEnter", function(self)
			self.Close:SetAlpha(1)
			local lines = {}
			if self.psMeta and self.psMeta ~= "" then lines[#lines + 1] = self.psMeta end
			local t = (tabsOf(Engine(), true) or {})[self.psIndex]
			local total = t and (t.total or t.stepCount)
			if t and t.done and total and total > 0 then lines[#lines + 1] = string.format(L["%d of %d steps done"], t.done, total) end
			lines[#lines + 1] = { L["Right-click for tab options"], Theme.Accent() }
			W.Tooltip(self, "ANCHOR_TOP", self.psTitle or "", lines)
			GF.HoverIn()
		end)
		b:SetScript("OnLeave", function(self)
			if not self.Close:IsMouseOver() then self.Close:SetAlpha(closeRest()) end
			W.HideTooltip(self)
		end)
		tabButtons[i] = b
		return b
	end

	local CATEGORY_ICON = {
		Leveling = "icon-level", Class = "icon-train", Professions = "icon-craft", Reputation = "icon-rep", Legacy = "icon-achieve",
		Exploration = "icon-explore", Collectibles = "star", Miscellaneous = "icon-treasure", Dungeons = "icon-kill",
	}
	GF.CATEGORY_ICON = CATEGORY_ICON

	function GF.RenderTabs()
		if not F then return end
		local tabs, active = tabsOf(Engine())
		local n = tabs and #tabs or 0
		strip.psCount = n
		local avail = F:GetWidth() - 2 - 30
		-- The active tab gets the room to read its title; the rest share the remainder.
		local share = n > 0 and floor(avail / n) or 0
		local activeW, otherW = share, share
		if n >= 2 and active then
			activeW = min(TAB_MAX_W, max(share, floor(avail * (n == 2 and 0.55 or 0.42))))
			otherW = floor((avail - activeW) / (n - 1))
		end
		activeW, otherW = min(TAB_MAX_W, activeW), min(TAB_MAX_W, otherW)
		local G = ns.Guides
		local x = 1
		for i = 1, n do
			local t = tabs[i]
			local b = tabButton(i)
			b.psIndex = i
			b.psActive = i == active
			b.psTitle = t.title or t.guideId
			-- The tab's guide as the registry knows it, else as the tab gives it
			-- (a copy's sample tab, which no registry holds).
			local guide = G and G.Get and G.Get(t.guideId) or (t.minLevel and t) or nil
			b.psMeta = guide and UI.GuideMeta(guide) or nil
			b.Label:SetText(b.psTitle)
			b.Label:SetWidth(0) -- unbound, to measure the whole title
			b.psTitleW = floor(b.Label:GetStringWidth() + 1)
			local lv = guide and UI.LevelRange(guide.minLevel, guide.maxLevel)
			b.psRange = lv and ("(" .. lv .. ")") or nil
			b.Range:SetText(b.psRange or "")
			b.Icon:SetTexture(Theme.Media(CATEGORY_ICON[t.category] or "icon-level"))
			W.Color(b.Label, b.psActive and "text" or "textMuted")
			W.Color(b.Range, b.psActive and "textDim" or "textMuted")
			W.Color(b.Icon, b.psActive and "accent" or "textMuted")
			b.Selected:SetShown(b.psActive)
			b.Bar:SetShown(b.psActive)
			GF.PaintTab(b)
			local w = b.psActive and activeW or otherW
			-- A lone tab in the house look takes the room its title and range need,
			-- up to the strip (Theme.House "loneTab"), never "The Barre…" beside an
			-- empty strip.
			if n == 1 and Theme.House("loneTab") then
				local need = TAB_TEXT_X + b.psTitleW + (b.psRange and floor(b.Range:GetStringWidth() + 1) + TAB_RANGE_GAP or 0) + TAB_CLOSE_PAD
				w = min(avail, max(w, need))
			end
			b:SetWidth(w)
			layoutTab(b)
			b:ClearAllPoints()
			b:SetPoint("BOTTOMLEFT", strip, "BOTTOMLEFT", x, 0)
			x = x + w
			b:Show()
		end
		for i = n + 1, #tabButtons do tabButtons[i]:Hide() end
		strip.Add:ClearAllPoints()
		strip.Add:SetPoint("LEFT", strip, "BOTTOMLEFT", x + 2, TAB_H / 2)
		local full = n >= 6
		W.SetIconState(strip.Add, false, not full)
		strip.Add.psTip = full and L["Six tabs is the limit"] or L["Open a guide in a new tab"]
	end

	function GF.TabsOf(E) return tabsOf(E) end

	GF.BarsBottom = barsBottom
end)
