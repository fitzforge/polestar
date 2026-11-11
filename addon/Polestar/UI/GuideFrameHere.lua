-- The guide window's "While you're here" panel (UI/GuideFrame.lua).

local ADDON, ns = ...
local UI, Theme, W, Anim, L, floor, max = ns.UI, ns.Theme, ns.Widgets, ns.Anim, ns.L, math.floor, math.max
local GF = UI.GuideFrame
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
-- The panel's ground: HERE_TINT of the accent in the window ground
-- (Theme.AccentGround); in the transparent style, which has no ground, the
-- accent alone at HERE_CLEAR, a light tint over the world (the text there is
-- outlined, GF.ApplyStyle). Painted again on a look or style change.
GF.HERE_TINT = 0.22
GF.HERE_CLEAR = 0.18
function GF.PaintHerePanel(t)
	if transparent() then
		local r, g, b = Theme.Accent()
		t:SetVertexColor(r, g, b, GF.HERE_CLEAR)
	else
		t:SetVertexColor(Theme.AccentGround(GF.HERE_TINT))
	end
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

function GF.FillHere(E)
	local list = E.GetWhileHereList()
	local tight = compact()
	local here = GF.here
	local body = here.Body
	if not (list and list[1]) then
		local was = here.psKey
		here.psKey = nil
		for _, r in ipairs(here.Rows) do r.psView = nil end
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
	for i, v in ipairs(list) do
		local r = GF.HereRow(i)
		r.psView = v
		keys[i] = v.step .. ":" .. v.index
		r.Icon:SetTexture(Theme.VerbIcon(v.here == "turnin" and "turnin" or v.t))
		r.Text:SetText((v.here == "turnin" or v.here == "take") and UI.HereText(v) or UI.GoalLine(v))
		r.Sub:SetText(string.format(v.later and L["Step %d, later in this guide"] or L["Step %d"], UI.StepNo(v.step)))
		r.Sub:SetShown(not tight)
		r.Dist:SetText(v.yards and ns.FormatDistance(v.yards, GF.HERE_DIST) or "")
		r:Show()
	end
	for i = #list + 1, #here.Rows do
		here.Rows[i].psView = nil
		here.Rows[i]:Hide()
	end
	-- The panel slides in when it comes; rows coming and going inside it do not.
	local fresh = here.psKey == nil
	local wasShown = here:IsShown()
	here.psKey = table.concat(keys, " ")
	here:Show()
	if fresh and F:IsVisible() and not GF.catchingUp then
		Anim.To(body, "alpha", wasShown and body:GetAlpha() or 0, 1, Anim.BASE, "out")
		Anim.To(body, "offsetX", -8, 0, Anim.BASE, "out")
	elseif not Anim.IsRunning(body, "alpha") then
		body:SetAlpha(1)
		Anim.Anchor(body, "TOPLEFT", here, "TOPLEFT", 0, 0)
	end
end

-- WHILE_HERE_CHANGED: the line came, changed or went.
function GF.HereChanged()
	if not F or GF.State() ~= "steps" or not GF.View() then return end
	GF.FillHere(Engine())
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
-- close button on the right. Left-click leads the arrow there, right-click
-- (or the close button) dismisses it around here (Engine.DismissWhileHere:
-- twice, for the rest of the zone). psAt: its place in
-- Engine.GetWhileHereList.
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
		local E = Engine()
		if E then E.DismissWhileHere(r.psAt) end
	end)
	r.Dist = T(r, "small", "textMuted")
	r.Dist:SetJustifyH("RIGHT")
	r.Text = T(r, "goal", "text")
	r.Text:SetWordWrap(true)
	r.Text:SetJustifyV("TOP")
	r.Sub = T(r, "small", "textMuted")
	r:SetScript("OnClick", function(self, button)
		local E = Engine()
		if not E then return end
		if button == "RightButton" then E.DismissWhileHere(self.psAt) else E.AimWhileHere(self.psAt) end
	end)
	r:SetScript("OnEnter", function(self)
		local v = self.psView
		if not v then return end
		local lines = {
			string.format(L["Step %d does this later; done now, that step is shorter or skipped when you get there."], UI.StepNo(v.step)),
		}
		local new = (v.here == "turnin" or v.here == "take") and ns.NewQuests and ns.NewQuests.TooltipText(v.quest)
		if new then lines[#lines + 1] = { new, Theme.Accent() } end
		lines[#lines + 1] = { L["Click to point the arrow here"], Theme.Accent() }
		lines[#lines + 1] = { L["Right-click: not now, around here (twice: for the rest of this zone)."], Theme.Color("textDim") }
		W.Tooltip(self, tooltipAnchor(), L["While you're here:"] .. " " .. UI.HereText(v), lines)
		GF.HoverIn()
	end)
	r:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	here.Rows[i] = r
	return r
end

function GF.BuildHere()
	-- While you're here (fillHere): its own section under the step's goals,
	-- a panel in the player's accent, dulled (GF.PaintHerePanel: painted
	-- again when the accent or the window style changes), with the accent edge
	-- and a small "While you're here" label, then one row per suggestion
	-- (GF.HereRow). `Body` carries what moves.
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
	W.Painter(here.Panel, GF.PaintHerePanel)
	here.Panel:SetPoint("TOPLEFT", hb, "TOPLEFT", PAD - 6, -3)
	here.Panel:SetPoint("BOTTOMRIGHT", hb, "BOTTOMRIGHT", -(PAD - 6), 3)
	here.Edge = hb:CreateTexture(nil, "ARTWORK")
	here.Edge:SetTexture(Theme.Media("white"))
	W.Color(here.Edge, "accent", 0.9)
	here.Edge:SetPoint("TOPLEFT", here.Panel, "TOPLEFT", 0, 0)
	here.Edge:SetPoint("BOTTOMLEFT", here.Panel, "BOTTOMLEFT", 0, 0)
	here.Edge:SetWidth(2)
	here.Label = T(hb, "small", "accent")
	here.Label:SetText(L["While you're here"])
	here:Hide()
end
ns.On("WHILE_HERE_CHANGED", whenReady(GF.HereChanged))
ns.On("WHILE_HERE_MOVED", whenReady(GF.HereMoved))
