-- The settings window's own widgets beside core's kit, loaded with it
-- (Polestar_Options), never at login: a setting's compact control
-- (W.PinControl), the header's "Search first" (W.SearchFirst) and its ···
-- menu (W.HeaderMenu). They join core's kit (Polestar/Theme/Widgets.lua) under the
-- same names.

local ns = Polestar
local Theme, W = ns.Theme, ns.Widgets
local L = ns.L
local type, pairs, ipairs, floor, max, min = type, pairs, ipairs, math.floor, math.max, math.min

local SHELL = W.SHELL
local P = W.RowParts
local simpleTip, hideTip, hoverTexture = P.simpleTip, P.hideTip, P.hoverTexture
local choicesOf, choiceText, openChoices = P.choicesOf, P.choiceText, P.openChoices
local sliderParts, sliderPaint, roundTo, SLIDER_W = P.sliderParts, P.sliderPaint, P.roundTo, P.SLIDER_W
local textWidth = W.TextWidth

---------------------------------------------------------------------------
-- A setting's own compact control (the ··· menu's slider row): its label,
-- then a switch at its right (toggle, one 36px line), a slider under it with
-- its value at the label's right (slider), or a face under it that opens its
-- choices (dropdown, font). It acts on c.key (c.get / c.set where the
-- setting has them), as its home row does, and repaints when the setting
-- changes. Off (W.SetDisabledWhen: its home row's state) it dims and sets
-- nothing. A click on its label calls f.psOnClick. Any other kind is its
-- label alone ("link").
--   W.PinControl(parent, c) -> f (f.psKind, f:Refresh())
---------------------------------------------------------------------------

do
	local PIN_H = { toggle = 36, slider = 52, dropdown = 60, font = 60, link = 36 }

	local function pinGet(f)
		local c = f.psSpec
		if c.get then return c.get() end
		return ns.Get(c.key)
	end

	local function pinSet(f, v)
		if not W.Enabled(f) then
			f:Refresh()
			return
		end
		local c = f.psSpec
		if c.set then
			c.set(v)
			f:Refresh()
		else
			ns.Set(c.key, v)
		end
	end

	-- Its choices as a dropdown row takes them ({ value, text, font, ... }):
	-- the owner's (f.psChoices: the settings window's own, as its home row
	-- has them), else c.choices with each one's label as its text.
	local function pinChoices(c)
		local list = c.choices
		if type(list) == "function" then
			local ok, got = pcall(list)
			list = ok and got or nil
		end
		local out = {}
		for i, ch in ipairs(type(list) == "table" and list or {}) do
			out[i] = { value = ch.value, text = ch.text or ch.label or tostring(ch.value), font = ch.font, preview = ch.preview, disabled = ch.disabled }
		end
		return out
	end

	local function pinRefresh(f)
		local on = W.Enabled(f)
		f.Label:SetText(f.psLabel or "")
		f.Label:SetAlpha(on and 1 or 0.45)
		local kind = f.psKind
		if kind == "toggle" then
			f.Sw.psDisabledFn = f.psDisabledFn
			f.Sw:Refresh()
		elseif kind == "slider" then
			local v = pinGet(f)
			if type(v) ~= "number" then v = f.psMin end
			f.psRefreshing = true
			f.Slider:SetValue(v)
			f.psRefreshing = false
			local tw = f.Slider:GetWidth()
			if tw and tw > 0 then f.psTrackW = tw end
			W.SkinSlider(f)
			sliderPaint(f, v)
			f.Slider:SetAlpha(on and 1 or 0.45)
			f.Value:SetAlpha(on and 1 or 0.45)
			f.Slider:EnableMouse(on)
		elseif kind == "dropdown" or kind == "font" then
			f.Face.Label:SetText(choiceText(choicesOf(f), pinGet(f)))
			f.Face:SetAlpha(on and 1 or 0.45)
			if on then f.Face:Enable() else f.Face:Disable() end
		end
	end

	-- The home row's own menu (openChoices), on the pin's get and set.
	local function pinMenu(face)
		if not W.Enabled(face.psRow) then return end
		openChoices(face)
	end

	function W.PinControl(parent, c)
		local kind = c.kind
		if not PIN_H[kind] or not c.key then kind = "link" end
		local f = CreateFrame("Button", nil, parent)
		f.psSpec, f.psKind = c, kind
		f:SetHeight(PIN_H[kind])
		f.Label = W.Text(f, "body", "textDim")
		f.Label:SetJustifyH("LEFT")
		f.Label:SetWordWrap(false)
		f:SetScript("OnClick", function(self) if self.psOnClick then self.psOnClick() end end)
		if kind == "toggle" then
			f.Sw = W.Switch(f, function() return pinGet(f) end, function(v) pinSet(f, v) end)
			f.Sw:SetPoint("RIGHT", f, "RIGHT", 0, 0)
			f.Label:SetPoint("LEFT", f, "LEFT", 0, 0)
			f.Label:SetPoint("RIGHT", f.Sw, "LEFT", -8, 0)
		elseif kind == "slider" then
			f.psMin, f.psMax, f.psStep, f.psFormat = c.min or 0, c.max or 1, c.step or 0.1, c.format
			f.Value = W.Text(f, "number", "textDim")
			f.Value:SetJustifyH("RIGHT")
			f.Value:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -6)
			f.Label:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -6)
			f.Label:SetPoint("RIGHT", f.Value, "LEFT", -8, 0)
			local s = sliderParts(f, f, SLIDER_W)
			s:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 8)
			s:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 8)
			s:SetMinMaxValues(f.psMin, f.psMax)
			s:SetValueStep(f.psStep)
			-- As a row's slider: a drag lands on its sensible points
			-- (W.SliderSnap); c.release writes when the drag ends.
			s:SetScript("OnValueChanged", function(_, value, userInput)
				value = roundTo(value, f.psStep)
				if userInput and f.psDragging and not f.psSnapping then
					local v = W.SliderSnap(f, value)
					if v ~= value then
						value = v
						f.psSnapping = true
						s:SetValue(v)
						f.psSnapping = false
					end
				end
				sliderPaint(f, value)
				if not userInput or f.psRefreshing then return end
				if pinGet(f) == value then return end
				if c.release then
					if W.Enabled(f) then f.psPending = value else f:Refresh() end
				elseif f.psDragging and W.Enabled(f) and not c.set then
					-- Each value of a drag is written live (as a row's slider).
					f.psLive = true
					ns.Live(pinSet, f, value)
				else
					pinSet(f, value)
				end
			end)
			local function dragEnd()
				f.psDragging = nil
				if f.psLive then
					f.psLive = nil
					ns.SettleLive()
				end
			end
			s:HookScript("OnMouseDown", function() f.psDragging = true end)
			s:HookScript("OnHide", dragEnd)
			s:SetScript("OnMouseUp", function()
				dragEnd()
				if f.psPending ~= nil then
					local v = f.psPending
					f.psPending = nil
					pinSet(f, v)
				end
			end)
			s:SetScript("OnMouseWheel", function(_, delta)
				local v = pinGet(f)
				if type(v) ~= "number" then v = f.psMin end
				pinSet(f, min(f.psMax, max(f.psMin, roundTo(v + delta * f.psStep, f.psStep))))
			end)
		elseif kind == "dropdown" or kind == "font" then
			f.Label:SetPoint("TOPLEFT", f, "TOPLEFT", 0, -6)
			f.Label:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, -6)
			local face = CreateFrame("Button", nil, f)
			face:SetHeight(28)
			face:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 4)
			face:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 4)
			face.Label = W.Text(face, "label", "text")
			face.Label:SetJustifyH("LEFT")
			face.Label:SetWordWrap(false)
			face.Label:SetPoint("LEFT", face, "LEFT", 10, 0)
			face.Label:SetPoint("RIGHT", face, "RIGHT", -26, 0)
			face.Arrow = face:CreateTexture(nil, "ARTWORK")
			face.Arrow:SetTexture(Theme.Media("chevron-down"))
			face.Arrow:SetSize(12, 12)
			face.Arrow:SetPoint("RIGHT", face, "RIGHT", -9, 0)
			W.Color(face.Arrow, "textDim")
			Theme.Skin(face, "dropdown")
			face.psRow = f
			face:SetScript("OnClick", pinMenu)
			f.Face = face
			f.psFaces = kind == "font" or nil
			f.psChoices = function() return pinChoices(c) end
			f.psGet = function() return pinGet(f) end
			f.psSet = function(v) pinSet(f, v) end
		else
			f.Label:SetPoint("LEFT", f, "LEFT", 0, 0)
			f.Label:SetPoint("RIGHT", f, "RIGHT", 0, 0)
		end
		f.psLabel = type(c.label) == "function" and c.label() or c.label
		f.Refresh = pinRefresh
		if kind == "link" then
			pinRefresh(f)
			return f
		end
		return W.Bind(f, c.key)
	end
end

---------------------------------------------------------------------------
-- The header's "Search first" (core's W.HeaderScale calls it while the window
-- has f.psSearchFirst): placed here, with the settings only, not at login.
---------------------------------------------------------------------------

do
	local fitLines, SUBTITLE_H, SUBTITLE_LINES, SEARCH_LEAST = P.fitLines, P.SUBTITLE_H, P.SUBTITLE_LINES, P.SEARCH_LEAST
	-- The new settings page's header, "Search first" (f.psSearchFirst): line one
	-- the breadcrumb (f.Title, small and grey; the Undo chip beside it while it
	-- shows) with the description (f.Subtitle, one line) after it; line two the
	-- search across what the tools leave, then the tools right to left from the
	-- close button (f.psHeadTools, the search last). The scale is in the page's
	-- ··· menu. CRUMB: line one's top. ROW: line two's middle, a share of the
	-- header. GAP: between any two tools, one rhythm along the line (the current
	-- page's psHeadGap pairs are not kept here). SEARCH: the search's gap to the
	-- first tool. DESC: the description's gap.
	local SF = { CRUMB = 16, ROW = 0.6, GAP = 8, SEARCH = 16, DESC = 18, LINE = 16 }

	function SF.place(f, t)
		local head = f.Header
		t:Hide()
		if not rawget(f, "psSFLaid") then
			f.psSFLaid = true
			Theme.Font(f.Title, "small")
			W.Color(f.Title, "textMuted")
			f.Subtitle:SetHeight(SF.LINE)
			f.Subtitle:SetJustifyV("MIDDLE")
			f.Subtitle:SetWordWrap(false)
		end
		Theme.SetFontScale(f.Title, nil)
		local mainW = tonumber(rawget(f, "psMainW")) or head:GetWidth()
		local mid = -floor(SHELL.header * SF.ROW + 0.5)
		local inHeader = f.Close:GetParent() == head
		if inHeader then
			f.Close:ClearAllPoints()
			f.Close:SetPoint("RIGHT", head, "TOPRIGHT", -12, mid)
		end
		local prev = (inHeader and f.Close:IsShown()) and f.Close or nil
		local edge = prev and (12 + f.Close:GetWidth()) or SHELL.pad
		local search = rawget(f, "Search")
		for _, w in ipairs(rawget(f, "psHeadTools") or {}) do
			if w ~= search and w:IsShown() then
				local gap = SF.GAP
				w:ClearAllPoints()
				if prev then
					w:SetPoint("RIGHT", prev, "LEFT", -gap, 0)
					edge = edge + gap
				else
					w:SetPoint("RIGHT", head, "TOPRIGHT", -SHELL.pad, mid)
				end
				edge = edge + w:GetWidth()
				prev = w
			end
		end
		if search and search:IsShown() then
			search:ClearAllPoints()
			if prev then
				search:SetPoint("RIGHT", prev, "LEFT", -SF.SEARCH, 0)
				edge = edge + SF.SEARCH
			else
				search:SetPoint("RIGHT", head, "TOPRIGHT", -SHELL.pad, mid)
			end
			search:SetWidth(max(SEARCH_LEAST, floor(mainW - SHELL.pad - edge)))
		end
		-- Line one: the crumb its own width, then the chip, then the description.
		local room = mainW - SHELL.pad * 2
		f.Title:ClearAllPoints()
		f.Title:SetPoint("TOPLEFT", head, "TOPLEFT", SHELL.pad, -SF.CRUMB)
		local tw = min(room, math.ceil(textWidth(f.Title)))
		f.Title:SetWidth(max(1, tw))
		local after, used = f.Title, tw
		local chip = rawget(f, "UndoChip")
		if chip and chip:IsShown() and chip:GetParent() == head then
			after, used = chip, used + 16 + chip:GetWidth()
		end
		f.Subtitle:ClearAllPoints()
		f.Subtitle:SetPoint("LEFT", after, "RIGHT", SF.DESC, 0)
		f.Subtitle:SetWidth(max(1, room - used - SF.DESC))
		fitLines(f.Subtitle, f.psSubtitle or "", 1)
	end

	-- Back from "Search first": the title, the description and close where the
	-- shell puts them.
	function SF.back(f)
		local head = f.Header
		f.psSFLaid = nil
		Theme.Font(f.Title, "hero")
		W.Color(f.Title, "text")
		f.Title:ClearAllPoints()
		f.Title:SetWidth(0)
		f.Title:SetPoint("TOPLEFT", head, "TOPLEFT", SHELL.pad, -32)
		f.Title:SetPoint("TOPRIGHT", head, "TOPRIGHT", -(12 + 28 + 12), -32)
		f.Subtitle:ClearAllPoints()
		f.Subtitle:SetPoint("TOPLEFT", f.Title, "BOTTOMLEFT", 0, -8)
		f.Subtitle:SetHeight(SUBTITLE_H)
		f.Subtitle:SetJustifyV("TOP")
		f.Subtitle:SetWordWrap(true)
		f.Subtitle:SetWidth(f.BodyWidth)
		fitLines(f.Subtitle, f.psSubtitle or "", SUBTITLE_LINES)
		if f.Close:GetParent() == head then
			f.Close:ClearAllPoints()
			f.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -12, -12)
		end
	end

	W.SearchFirst = { place = SF.place, back = SF.back }
end

-- The settings window's header icon tools (Peek, Fold, Move frames, Reload
-- UI, ···): one glyph size in their 24 box.
W.HEAD_GLYPH = 16

-- The header's ··· menu (the new settings page): an icon button whose click
-- opens `items` as a menu. items: { { text, onClick, danger, disabled, icon } }
-- or a function that returns them (asked at each click). An item { slider =
-- c } (c a slider's spec: label, key, min, max, step, format,
-- release) is a live slider row at the menu's top, its glyph (c.icon) and
-- label on the rows' icon and text edges; it is a part of the menu itself
-- (W.ShowMenu's frame, over the menu's own click-catcher), so a drag stays
-- in the menu and leaves it open. -> the button
do
	-- The rows' icon and text edges in the menu (W.ShowMenu: a row 1 in, its
	-- glyph 10 into it, its text 32, or 12 in a menu of no glyphs), and the
	-- menu's inner pad.
	local ICON_X, TEXT_X, TEXT_BARE, PAD, SLIDER_MENU_W = 11, 33, 13, 4, 232

	-- The slider row on `menu` for spec c (made once a key), shown at its top;
	-- the menu's rows and lines move down under it.
	local function menuSlider(menu, c, list)
		local pool = rawget(menu, "psSliders")
		if not pool then
			pool = {}
			menu.psSliders = pool
		end
		local f = pool[c.key]
		if not f then
			f = W.PinControl(menu, c)
			f.Glyph = W.Tex(f, "ARTWORK", c.icon or "sliders", "textDim")
			f.Glyph:SetSize(14, 14)
			f.Glyph:SetPoint("LEFT", f.Label, "LEFT", ICON_X - TEXT_X, 0)
			-- The menu is every dropdown's: another list in it leaves the slider out.
			f:SetScript("OnUpdate", function(self)
				if menu.psItems ~= self.psList or not menu:IsShown() then self:Hide() end
			end)
			pool[c.key] = f
		end
		for _, o in pairs(pool) do if o ~= f then o:Hide() end end
		f.psList = list
		local textX = TEXT_BARE
		for _, it in ipairs(list) do if it.icon then textX = TEXT_X end end
		f.Glyph:SetShown(textX == TEXT_X)
		local h = f:GetHeight()
		local function down(r)
			if not r:IsShown() then return end
			local pts = {}
			for i = 1, r:GetNumPoints() do pts[i] = { r:GetPoint(i) } end
			r:ClearAllPoints()
			for _, pt in ipairs(pts) do r:SetPoint(pt[1], pt[2], pt[3], pt[4], (pt[5] or 0) - h) end
		end
		for _, r in ipairs(menu.rows or {}) do down(r) end
		for _, r in ipairs(menu.seps or {}) do down(r) end
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", menu, "TOPLEFT", textX, -PAD)
		f:SetPoint("TOPRIGHT", menu, "TOPRIGHT", -10, -PAD)
		menu:SetHeight(menu:GetHeight() + h)
		f:Show()
		f:Refresh()
		return f
	end

	function W.HeaderMenu(parent, items)
		local b = W.IconButton(parent, "menu", 24, L["More"], nil, W.HEAD_GLYPH)
		b:SetScript("OnClick", function(self)
			local list, slider = {}, nil
			for _, it in ipairs((type(items) == "function" and items() or items) or {}) do
				if it.slider then
					slider = it.slider
				else
					list[#list + 1] = { text = it.text, icon = it.icon, disabled = it.disabled, onClick = it.onClick,
						color = it.danger and "danger" or nil }
				end
			end
			local menu = W.ShowMenu(self, list, slider and { minWidth = SLIDER_MENU_W, short = true } or nil)
			if slider and menu then
				self.psSlider = menuSlider(menu, slider, list)
			elseif rawget(menu or {}, "psSliders") then
				for _, o in pairs(menu.psSliders) do o:Hide() end
			end
		end)
		return b
	end
end
