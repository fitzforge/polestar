-- The settings window's Guide window page (look group, key "guidewindow"):
-- the guide window's style, size, ground, border, opacity and when it shows,
-- then each of its parts on its own: the text of each element, spacing and
-- glyphs, the tab bar and the step bar and what they hold, the target bar on
-- the current goal, the progress line, and motion. Every setting is applied
-- by the window itself (UI/GuideFrame.lua: readMetrics, GF.LOOK,
-- GF.ApplyLook) and shows on it at once.
--
-- Each tab pins the same live preview over its rows: a step card laid out by
-- the window's own sizes (GF.Metrics), its own text roles, size groups
-- (GF.SIZE_KEYS), outline, target bar and progress paint, over the night
-- sky. It is fed a fixed demo step, never the live window or the Engine, is
-- built the first time a tab shows, and repaints only while shown.

local ADDON, ns = ...
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, ipairs = math.floor, math.max, math.min, ipairs

local PAGE = L["Guide window"]
local NEW = "0.3.7"

local function percent(v) return floor(v * 100 + 0.5) .. "%" end
local function px(v) return string.format(L["%d px"], floor(v + 0.5)) end
local function signedPx(v)
	local p = floor(v + 0.5)
	return (p > 0 and "+" or "") .. string.format(L["%d px"], p)
end
local function times(v) return string.format("%.2gx", v) end

local function GF() return UI.GuideFrame end
local function transparent() return ns.Get("ui.style") == "transparent" end
local function notTransparent() return not transparent() end
local function look(key) return ns.Get("guideWindow." .. key) end
local function off(key) return function() return look(key) == false end end

---------------------------------------------------------------------------
-- The preview
---------------------------------------------------------------------------

local PREVIEW_H = 290 -- within the settings window's cap on the pinned slot (45 % of the body)
local TOP = 36 -- under the "Preview" caption

-- The settings that change what the preview draws (besides guideWindow.*
-- and the theme, which W.Painter follows).
local WATCH = {
	[""] = true, ["guideWindow"] = true, ["ui"] = true,
	["ui.style"] = true, ["ui.backing"] = true, ["ui.barShown"] = true, ["ui.scale"] = true, ["ui.width"] = true,
	["ui.opacity"] = true, ["ui.compact"] = true, ["ui.showNotes"] = true, ["nav.nearbyButton"] = true,
}

-- The demo step: the person and three goals as the Engine's step view
-- gives them (UI.GoalLine draws them), one done, one current, one open.
local function demoGoals()
	return {
		{ t = "kill", status = "done", verb = L["Kill"], subject = L["Kobold Vermin"], subjectKind = "npc", progress = { cur = 10, max = 10 } },
		{ t = "kill", status = "active", verb = L["Kill"], subject = L["Kobold Worker"], subjectKind = "npc", progress = { cur = 3, max = 8 },
			sub = L["from Kobold Worker (lvl 6\226\128\1477)"], current = true },
		{ t = "collect", status = "active", verb = L["Collect"], subject = L["Gold Dust"], subjectKind = "item", progress = { cur = 0, max = 10 } },
	}
end

local function buildPreview(view)
	local f = CreateFrame("Frame", nil, view)
	f:SetHeight(PREVIEW_H)
	if f.SetClipsChildren then f:SetClipsChildren(true) end
	f.texts = {}
	-- The sky the window floats over (the Theme page's stage).
	W.Fill(f, "scrim", "BACKGROUND", -8)
	f.Lift = W.Tex(f, "BACKGROUND", "glow", nil, -7)
	f.Band = Theme.Band(f, "BACKGROUND", -6)
	f.Band:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
	f.Band:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
	f.Band:SetHeight(Theme.BAND_H)
	-- The settings window draws "Preview" and "Live" over it; the caption
	-- says how large the window is drawn when the stage makes it smaller.
	f.caption = function()
		local k, s = f.psScale or 1, tonumber(ns.Get("ui.scale")) or 1
		if k >= s - 0.001 then return nil end
		return string.format(L["Drawn at %s of its size"], percent(k / s))
	end

	-- A string of the window: its role and colour as the window's, `group`
	-- its size setting (GF.SIZE_KEYS), `spacing` its own line spacing,
	-- `dense` its role in the house look's dense step card.
	local function text(parent, role, color, group, spacing, dense)
		local fs = W.Text(parent, role, color)
		fs.psGroup, fs.psSpacing, fs.psRole, fs.psDense = group, spacing, role, dense
		f.texts[#f.texts + 1] = fs
		return fs
	end

	-- The window, in the window paint of the skin in use (GF.ApplyStyle's fields).
	local gw = CreateFrame("Frame", nil, f)
	gw.psGuide = true
	Theme.Skin(gw, "window")
	gw:EnableMouse(true)
	gw.Band = Theme.Band(gw, "BACKGROUND", -5)
	gw.Band:SetPoint("TOPLEFT", gw, "TOPLEFT", 1, -1)
	gw.Band:SetPoint("TOPRIGHT", gw, "TOPRIGHT", -1, -1)
	gw.Veil = Theme.Scrim(gw, 20)
	gw.Veil:SetPoint("TOPLEFT", gw, "TOPLEFT", -14, 8)
	gw.Veil:SetPoint("BOTTOMRIGHT", gw, "BOTTOMRIGHT", 14, -8)
	f.Window = gw

	-- The step card's dress (the house look) and the hint card above the
	-- window (an outside card, every look): GF.stepList.Dress at the first paint.
	local box = CreateFrame("Frame", nil, gw)
	box:SetFrameLevel(gw:GetFrameLevel())
	f.Card = box
	local hint = CreateFrame("Frame", nil, gw)
	hint.Text = text(hint, "cardGoal", "quest")
	hint.Text:SetWordWrap(true)
	hint.Text:SetJustifyH("LEFT")
	hint.Text:SetJustifyV("TOP")
	hint.Text:SetText(L["Elite: group advised"])
	f.Hint = hint

	-- Tab strip: one active tab.
	local strip = CreateFrame("Frame", nil, gw)
	strip.Rule = W.Divider(strip)
	strip.Rule:SetPoint("BOTTOMLEFT", strip, "BOTTOMLEFT", 0, 0)
	strip.Rule:SetPoint("BOTTOMRIGHT", strip, "BOTTOMRIGHT", 0, 0)
	strip.Icon = W.Tex(strip, "ARTWORK", "icon-level", "accent")
	strip.Icon:SetSize(12, 12)
	strip.Icon:SetPoint("LEFT", strip, "LEFT", 9, 0)
	strip.Label = text(strip, "small", "title", "bar")
	strip.Label:SetText(L["Elwynn Forest"])
	strip.Label:SetPoint("LEFT", strip.Icon, "RIGHT", 6, 0)
	strip.Range = text(strip, "small", "textMuted", "bar")
	strip.Range:SetText("1\226\128\14710")
	strip.Range:SetPoint("LEFT", strip.Label, "RIGHT", 4, 0)
	strip.Bar = W.Tex(strip, "ARTWORK", nil, "accent")
	strip.Bar:SetHeight(2)
	strip.Bar:SetPoint("BOTTOMLEFT", strip, "BOTTOMLEFT", 0, 0)
	f.Strip = strip

	-- Navigator: ‹ 8 / 29 ›, the guide's title, Skip, the services, the bug, the menu.
	local nav = CreateFrame("Frame", nil, gw)
	nav.Rule = W.Divider(nav)
	nav.Rule:SetPoint("BOTTOMLEFT", nav, "BOTTOMLEFT", 0, 0)
	nav.Rule:SetPoint("BOTTOMRIGHT", nav, "BOTTOMRIGHT", 0, 0)
	nav.Prev = W.Tex(nav, "ARTWORK", "chevron-left", "textDim")
	nav.Count = text(nav, "number", "text", "bar")
	nav.Count:SetText("8 / 29")
	nav.Count:SetJustifyH("CENTER")
	nav.Next = W.Tex(nav, "ARTWORK", "chevron-right", "textDim")
	nav.Title = text(nav, "small", "textDim", "bar")
	nav.Title:SetText(L["Elwynn Forest"])
	nav.Menu = W.Tex(nav, "ARTWORK", "menu", "textDim")
	nav.Report = W.Tex(nav, "ARTWORK", "bug", "textDim")
	nav.Nearby = W.Tex(nav, "ARTWORK", "icon-goto", "textDim")
	nav.SkipIcon = W.Tex(nav, "ARTWORK", "skip", "textDim")
	nav.SkipIcon:SetSize(11, 11)
	nav.Skip = text(nav, "small", "textDim", "bar")
	nav.Skip:SetText(L["Skip"])
	-- A skin's title bar and close square (the guideTitle hook shows them).
	nav.TitleBar = W.Tex(nav, "BACKGROUND", nil, "sky", -4)
	nav.TitleBar:SetPoint("TOPLEFT", nav, "TOPLEFT", 4, 0)
	nav.TitleBar:SetPoint("BOTTOMRIGHT", nav, "BOTTOMRIGHT", -4, 1)
	nav.Close = CreateFrame("Frame", nil, nav)
	nav.Close:SetSize(18, 18)
	nav.Close:SetPoint("RIGHT", nav, "RIGHT", -5, 0)
	W.Fill(nav.Close, "closeFill", "BACKGROUND", -3)
	nav.Close.Glyph = W.Tex(nav.Close, "ARTWORK", "close", "closeGlyph")
	nav.Close.Glyph:SetSize(10, 10)
	nav.Close.Glyph:SetPoint("CENTER", nav.Close, "CENTER", 0, 0)
	W.Painter(nav.Close, function(b) Theme.Border(b, Theme.Color("closeEdge")) end)
	f.Nav = nav

	-- The focus: who to talk to.
	local person = CreateFrame("Frame", nil, gw)
	person.Icon = person:CreateTexture(nil, "ARTWORK")
	person.Icon:SetTexture(Theme.VerbIcon("talk"))
	W.Color(person.Icon, "textDim")
	person.Name = text(person, "name", "npc", "title", nil, "cardName")
	person.Name:SetText(L["Marshal Dughan"])
	person.Where = text(person, "small", "textDim", "detail", nil, "cardNote")
	person.Where:SetText(L["Goldshire"])
	f.Person = person

	-- The goal rows, as GuideFrame's paintRow paints them.
	f.Rows = {}
	for i, goal in ipairs(demoGoals()) do
		local r = CreateFrame("Frame", nil, gw)
		local done = goal.status == "done"
		r.Mark = r:CreateTexture(nil, "ARTWORK")
		r.Mark:SetTexture(Theme.Media("white"))
		r.Mark:SetPoint("TOPLEFT", r, "TOPLEFT", 0, -3)
		r.Mark:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", 0, 3)
		r.Mark:SetShown(goal.current and true or false)
		r.Icon = r:CreateTexture(nil, "ARTWORK")
		r.Icon:SetTexture(done and Theme.Media("check") or Theme.VerbIcon(goal.t))
		W.Color(r.Icon, done and "success" or (goal.current and "accent" or "textDim"))
		r.Text = text(r, "goal", done and "textMuted" or "text", "goal", 0, "cardGoal")
		r.Text:SetWordWrap(true)
		r.Text:SetJustifyH("LEFT")
		r.Text:SetJustifyV("TOP")
		r.Sub = text(r, "small", "textMuted", "detail", 0, "cardNote")
		r.Sub:SetWordWrap(true)
		r.Sub:SetJustifyH("LEFT")
		r.Sub:SetJustifyV("TOP")
		r.Sub:SetText(goal.sub or "")
		r.Sub:SetShown(goal.sub ~= nil)
		r.Check = W.Checkbox(r)
		r.Check:EnableMouse(false)
		r.Check:SetChecked(done)
		r.psGoal = goal
		f.Rows[i] = r
	end

	-- The author's tip, one line.
	local tip = CreateFrame("Frame", nil, gw)
	tip.Toggle = W.Tex(tip, "ARTWORK", "chevron-down", "textDim")
	tip.Toggle:SetSize(10, 10)
	tip.Text = text(tip, "note", "textDim", "note", 3, "cardNote")
	tip.Text:SetJustifyH("LEFT")
	tip.Text:SetWordWrap(false)
	tip.Text:SetText(L["Kobolds drop Gold Dust too: keep what you loot on the way."])
	f.Tip = tip

	-- Up next: its toggle and one row.
	local up = CreateFrame("Frame", nil, gw)
	up.Rule = W.Divider(up)
	up.Label = text(up, "small", "textMuted", "up", nil, "cardNote")
	up.Label:SetText(L["Up next"])
	up.Chevron = W.Tex(up, "ARTWORK", "chevron-down", "textMuted")
	up.Chevron:SetSize(12, 12)
	up.Num = text(up, "number", "textMuted", "up")
	up.Num:SetJustifyH("RIGHT")
	up.Num:SetWidth(22)
	up.Num:SetText("9")
	up.Icon = up:CreateTexture(nil, "ARTWORK")
	up.Icon:SetTexture(Theme.VerbIcon("turnin"))
	up.Icon:SetSize(13, 13)
	W.Color(up.Icon, "textMuted")
	up.Text = text(up, "label", "textDim", "up", nil, "cardGoal")
	up.Text:SetJustifyH("LEFT")
	up.Text:SetWordWrap(false)
	f.Up = up

	-- The guide's progress.
	local foot = CreateFrame("Frame", nil, gw)
	foot.Line = W.ProgressLine(foot, 3)
	W.Uncolor(foot.Line.Fill)
	foot.Pct = text(foot, "number", "textDim", "bar")
	foot.Pct:SetJustifyH("RIGHT")
	foot.Pct:SetWidth(40)
	foot.Pct:SetText("38%")
	f.Foot = foot

	-- Over the window it shows as the window does under the cursor: the
	-- transparent bars, full opacity.
	gw:SetScript("OnEnter", function() f.psHover = true; f:Paint() end)
	gw:SetScript("OnLeave", function() f.psHover = nil; f:Paint() end)

	-- Lay the window out by the live window's numbers and paint it.
	function f:Paint()
		local G = GF()
		local width = self.psW
		if not (width and G and G.Metrics) then return end
		self.psDirty = nil
		local M = G.Metrics()
		local clear = transparent()
		local isCompact = ns.Get("ui.compact") and true or false
		local outline = clear and G.Outline()
		local gap = G.Num("lineSpacing")
		local dense = M.card
		for _, fs in ipairs(self.texts) do
			if fs.psDense then Theme.Font(fs, dense and fs.psDense or fs.psRole) end
			if Theme.SetFontScale then Theme.SetFontScale(fs, fs.psGroup and G.Num(G.SIZE_KEYS[fs.psGroup]) or 1) end
			Theme.SetOutline(fs, outline)
			if fs.psSpacing and fs.SetSpacing then fs:SetSpacing(fs.psSpacing + gap) end
		end
		for i, r in ipairs(self.Rows) do r.Text:SetText(UI.GoalLine(r.psGoal)) end
		up.Text:SetText(string.format(L["Turn in %s"], "|c" .. Theme.Hex("quest") .. L["Kobold Camp Cleanup"] .. "|r"))

		local w = min(UI.MAX_WIDTH, max(UI.MIN_WIDTH, tonumber(ns.Get("ui.width")) or 340))
		gw:SetWidth(w)
		gw.psBare = clear
		local cr, cg, cb = G.Rgb("bgColor")
		gw.psBgColor = cr and { cr, cg, cb } or nil
		gw.psBgAlpha = tonumber(ns.Get("guideWindow.bgOpacity"))
		gw.psNoBorder = not G.On("border") or nil
		Theme.Repaint(gw)
		local rules = G.On("rules")
		local pad, textX = M.pad, M.textX
		local y = 0

		-- The tab strip.
		local showStrip = G.On("tabs") and not isCompact
		strip:SetShown(showStrip)
		if showStrip then
			strip:ClearAllPoints()
			strip:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, 0)
			strip:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, 0)
			strip:SetHeight(M.tabH)
			strip.Rule:SetShown(not clear and rules)
			strip.Bar:SetWidth(floor(9 + 12 + 6 + strip.Label:GetStringWidth() + 4 + strip.Range:GetStringWidth() + 10 + 0.5))
			y = y + M.tabH
		end

		-- The navigator.
		nav:ClearAllPoints()
		nav:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -y)
		nav:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -y)
		nav:SetHeight(M.navH)
		nav.Rule:SetShown(not clear and rules)
		local steps = G.On("stepCount")
		local x0 = pad - 6
		local cw = max(40, floor(nav.Count:GetStringWidth() + 0.5))
		for _, t in ipairs({ nav.Prev, nav.Next, nav.Menu, nav.Report, nav.Nearby }) do t:SetSize(14, 14) end
		nav.Prev:SetShown(steps)
		nav.Count:SetShown(steps)
		nav.Next:SetShown(steps)
		nav.Prev:SetPoint("CENTER", nav, "LEFT", x0 + 12, 0)
		nav.Count:SetWidth(cw)
		nav.Count:SetPoint("LEFT", nav, "LEFT", x0 + 24, 0)
		nav.Next:SetPoint("CENTER", nav, "LEFT", x0 + 24 + cw + 12, 0)
		nav.Title:SetShown((not showStrip or not steps) and G.On("guideTitle"))
		nav.Title:ClearAllPoints()
		nav.Title:SetPoint("LEFT", nav, "LEFT", steps and (x0 + 48 + cw + 8) or pad, 0)
		-- The skin's title (GuideFrame's ApplyStyle): the house state, then its hook.
		nav.TitleBar:SetShown(not clear and Theme.SkinKey() == "hearth")
		nav.Close:Hide()
		gw.Band:SetShown(not clear and Theme.SkinKey() == "polestar")
		local title = G.TitleParts(nav.TitleBar, nav.Close, nav.Rule, gw.Band)
		if not clear and Theme.SkinHook then Theme.SkinHook("guideTitle", nav, title) end
		if nav.TitleBar:IsShown() then
			nav.Rule:SetVertexColor(Theme.Color("titleLine"))
		else
			nav.Rule:SetVertexColor(Theme.Wash("divider"))
		end
		local right = tonumber(title.menuRight) or 8
		nav.Menu:SetPoint("CENTER", nav, "RIGHT", -(right + 12), 0)
		right = right + 24
		local report = G.On("reportButton")
		nav.Report:SetShown(report)
		if report then
			nav.Report:SetPoint("CENTER", nav, "RIGHT", -(right + 12), 0)
			right = right + 24
		end
		local nearby = ns.Get("nav.nearbyButton") ~= false
		nav.Nearby:SetShown(nearby)
		if nearby then
			nav.Nearby:SetPoint("CENTER", nav, "RIGHT", -(right + 12), 0)
			right = right + 24
		end
		local skip = G.On("skipButton")
		nav.Skip:SetShown(skip)
		nav.SkipIcon:SetShown(skip)
		nav.Skip:SetPoint("RIGHT", nav, "RIGHT", -(right + 2 + 8), 0)
		nav.SkipIcon:SetPoint("RIGHT", nav.Skip, "LEFT", -5, 0)
		y = y + M.navH
		local barsH = y

		-- The step card: in the house look its own ground and hairline (SL.Dress).
		local dressed = dense and not clear and not isCompact
		if dense then y = y + M.cardTop end
		local cardY = y

		-- The focus (GuideFrame's person layout): in the house look the zone
		-- sits muted at the title's right, on its line.
		local nameW = w - pad * 2 - M.icon - 10
		person:ClearAllPoints()
		person:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -y)
		person:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -y)
		person.Icon:SetSize(M.icon + 1, M.icon + 1)
		person.Icon:SetPoint("TOPLEFT", person, "TOPLEFT", pad - 1, -M.personIconY)
		person.Name:SetPoint("TOPLEFT", person, "TOPLEFT", textX, -M.head)
		person.Where:ClearAllPoints()
		local ph
		if dense then
			local whereW = floor(person.Where:GetStringWidth() + 0.5) + 2
			person.Where:SetWidth(whereW)
			person.Where:SetJustifyH("RIGHT")
			person.Where:SetPoint("TOPRIGHT", person, "TOPRIGHT", -pad, -M.head - 1)
			person.Name:SetWidth(max(40, nameW - whereW - 8))
			ph = floor(M.head + person.Name:GetStringHeight() + M.headB + 0.5)
		else
			person.Name:SetWidth(nameW)
			person.Where:SetWidth(nameW)
			person.Where:SetJustifyH("LEFT")
			person.Where:SetPoint("TOPLEFT", person.Name, "BOTTOMLEFT", 0, -M.subgap)
			ph = floor(M.head + person.Name:GetStringHeight() + M.subgap + 1 + person.Where:GetStringHeight() + M.headB + 0.5)
		end
		person:SetHeight(ph)
		y = y + ph

		-- The goals (measureRow's sizes): one step in under the title in the house look.
		local ind = M.ind
		local tw = max(40, w - textX - ind - (pad + M.check + 4 + M.checkIn))
		local markX = max(0, pad + ind - 2 - M.markGap)
		for _, r in ipairs(self.Rows) do
			r.Text:SetWidth(tw)
			r.Sub:SetWidth(tw)
			local h = M.top + r.Text:GetStringHeight()
			if r.Sub:IsShown() then h = h + M.subgap + r.Sub:GetStringHeight() end
			h = max(M.rowMin, floor(h + M.bot + M.rowPad * 2 + 0.5))
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -y)
			r:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -y)
			r:SetHeight(h)
			r.Mark:ClearAllPoints()
			r.Mark:SetPoint("TOPLEFT", r, "TOPLEFT", markX, -3)
			r.Mark:SetPoint("BOTTOMLEFT", r, "BOTTOMLEFT", markX, 3)
			r.Icon:SetSize(M.icon, M.icon)
			r.Icon:SetPoint("CENTER", r, "TOPLEFT", pad + ind + M.icon / 2, -M.glyphY)
			r.Text:SetPoint("TOPLEFT", r, "TOPLEFT", textX + ind, -M.top - M.rowPad)
			r.Sub:SetPoint("TOPLEFT", r.Text, "BOTTOMLEFT", 0, -M.subgap)
			r.Check:SetSize(M.check, M.check)
			r.Check:ClearAllPoints()
			r.Check:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(pad - 3 + M.checkIn), dense and -(M.ic - M.check / 2) or -3 - M.rowPad)
			r.Check.psOnWorld = clear
			Theme.Repaint(r.Check)
			G.PaintMark(r.Mark)
			y = y + h
		end

		-- The tip, one line, at the bottom of the card.
		local showTip = not isCompact and ns.Get("ui.showNotes") ~= false
		tip:SetShown(showTip)
		if showTip then
			tip.Text:SetWidth(w - textX - pad - 4)
			local th = min(tip.Text:GetStringHeight(), tip.Text:GetLineHeight())
			local h = floor(M.tip + th + M.tip + 0.5)
			tip:ClearAllPoints()
			tip:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -(y + 2))
			tip:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -(y + 2))
			tip:SetHeight(h)
			tip.Toggle:SetPoint("TOPLEFT", tip, "TOPLEFT", pad - 2, -(M.tip - 3))
			tip.Text:SetPoint("TOPLEFT", tip, "TOPLEFT", textX, -M.tip)
			y = y + 2 + h
		end
		if dense then y = y + 3 end
		box:ClearAllPoints()
		box:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -cardY)
		box:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -cardY)
		box:SetHeight(max(1, y - cardY))
		if not rawget(box, "Ground") and G.stepList and G.stepList.Dress then G.stepList.Dress(box, M.edge) end
		if rawget(box, "Ground") then
			box.Ground:SetShown(dressed)
			for i = 1, 4 do box.Lines[i]:SetShown(dressed) end
		end
		y = y + 6

		-- Up next.
		up:SetShown(not isCompact)
		if not isCompact then
			local h = M.upToggle + M.upRow + 6
			up:ClearAllPoints()
			up:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -y)
			up:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -y)
			up:SetHeight(h)
			up.Rule:SetAlpha(rules and 1 or 0)
			up.Rule:ClearAllPoints()
			up.Rule:SetPoint("TOPLEFT", up, "TOPLEFT", pad, 0)
			up.Rule:SetPoint("TOPRIGHT", up, "TOPRIGHT", -pad, 0)
			up.Label:SetPoint("LEFT", up, "TOPLEFT", pad, -M.upToggle / 2)
			up.Chevron:SetPoint("RIGHT", up, "TOPRIGHT", -pad, -M.upToggle / 2)
			local mid = -(M.upToggle + M.upRow / 2)
			up.Num:SetPoint("LEFT", up, "TOPLEFT", pad - 10, mid)
			up.Icon:SetPoint("LEFT", up, "TOPLEFT", textX - 2, mid)
			up.Text:SetWidth(w - textX - 14 - pad)
			up.Text:SetPoint("LEFT", up, "TOPLEFT", textX - 2 + 13 + 9, mid)
			y = y + h
		end

		-- The progress line.
		local showFoot = G.On("progress")
		foot:SetShown(showFoot)
		if showFoot then
			foot:ClearAllPoints()
			foot:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -y)
			foot:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -y)
			foot:SetHeight(M.progH)
			local pct = G.On("progressPct")
			foot.Pct:SetShown(pct)
			foot.Pct:SetPoint("RIGHT", foot, "RIGHT", -pad, 0)
			local lw = w - pad * 2 - (pct and 44 or 0)
			foot.Line:SetHeight(G.ProgressHeight())
			foot.Line:SetWidth(max(1, lw))
			foot.Line:SetPoint("LEFT", foot, "LEFT", pad, 0)
			local tr, tg, tb, ta = Theme.Wash("progress")
			foot.Line.Track:SetVertexColor(tr, tg, tb, clear and 0.15 or ta)
			G.PaintProgressFill(foot.Line.Fill)
			W.SetProgress(foot.Line, 0.38, lw)
			y = y + M.progH
		end
		gw:SetHeight(y)

		-- The hint card above the window (SL.LayoutOut's sizes), as wide as it.
		local hp = M.outPad
		hint.Text:SetWidth(w - hp * 2)
		hint.Text:ClearAllPoints()
		hint.Text:SetPoint("TOPLEFT", hint, "TOPLEFT", hp, -5)
		local hintH = 5 + floor(hint.Text:GetStringHeight() + 0.5) + 5
		hint:ClearAllPoints()
		hint:SetPoint("BOTTOMLEFT", gw, "TOPLEFT", 0, M.outNear)
		hint:SetPoint("BOTTOMRIGHT", gw, "TOPRIGHT", 0, M.outNear)
		hint:SetHeight(hintH)
		if not rawget(hint, "Ground") and G.stepList and G.stepList.Dress then G.stepList.Dress(hint, 0, 0, true) end
		if rawget(hint, "Ground") then
			hint.Ground:SetShown(not clear)
			hint.Base:SetShown(not clear)
			for i = 1, 4 do hint.Lines[i]:SetShown(not clear) end
		end
		local above = hintH + M.outNear

		-- The band behind the bars (Standard, the house skin, unless the skin's
		-- title hides it), the transparent style's backing, the bars that wait
		-- for the cursor.
		gw.Band:SetHeight(barsH)
		gw.Band:SetTexCoord(Theme.BandCoords(w - 2, barsH, 30))
		local veil = G.Backing()
		gw.Veil:SetShown(veil ~= nil)
		if veil then Theme.PaintScrim(gw.Veil, veil) end
		local soft = G.SoftShade()
		for _, fs in ipairs(self.texts) do G.ShadeText(fs, soft and fs:IsVisible()) end
		local bars = (not clear or self.psHover or ns.Get("ui.barShown")) and 1 or 0
		strip:SetAlpha(bars)
		for _, t in ipairs({ nav.Prev, nav.Count, nav.Next, nav.Title, nav.Menu, nav.Report, nav.Nearby, nav.Skip, nav.SkipIcon, nav.TitleBar, nav.Close }) do t:SetAlpha(bars) end
		gw:SetAlpha((ns.Get("ui.opacity") or 1) * (self.psHover and 1 or G.Num("idleAlpha")))

		-- The window at its own scale, smaller only to fit the stage.
		local s = tonumber(ns.Get("ui.scale")) or 1
		local fit = min(1, (width - 32) / (w * s), (PREVIEW_H - TOP - 12) / (max(1, y + above) * s))
		local k = s * fit
		gw:SetScale(k)
		gw:ClearAllPoints()
		gw:SetPoint("TOP", self, "TOP", 0, -TOP / k - above)
		self.psScale = k
	end

	function f:Refresh()
		if self:IsVisible() then self:Paint() else self.psDirty = true end
	end
	f:SetScript("OnShow", function(self) if self.psDirty then self:Paint() end end)
	-- The theme (skin, scheme, accent, font): the sky and the window again.
	W.Painter(f, function(self)
		Theme.Border(self, Theme.Wash("divider"))
		local r, g, b = Theme.Color("sky")
		self.Lift:SetVertexColor(r, g, b, 0.75)
		self:Refresh()
	end)
	ns.On("SETTING_CHANGED", function(path)
		if WATCH[path] or (type(path) == "string" and path:sub(1, 12) == "guideWindow.") then f:Refresh() end
	end)

	-- -> the preview's height, the window centred across `width`.
	function f:Layout(width)
		self:SetWidth(width)
		self.psW = width
		self.Lift:ClearAllPoints()
		self.Lift:SetSize(width * 0.7, PREVIEW_H * 1.6)
		self.Lift:SetPoint("CENTER", self, "TOPLEFT", width * 0.5, -PREVIEW_H * 0.4)
		self.Band:SetTexCoord(Theme.BandCoords(width, Theme.BAND_H))
		self:Paint()
		return PREVIEW_H
	end
	return f
end
-- For the tests: buildPreview(parent) -> f.
UI.GuideWindowPreview = buildPreview

---------------------------------------------------------------------------
-- The controls
---------------------------------------------------------------------------

local function textSize(key, label, help, search)
	return { kind = "slider", key = "guideWindow." .. key, label = label, min = 0.7, max = 1.8, step = 0.05, format = percent, new = NEW,
		help = help, search = search .. ", text size, font size, bigger, smaller, larger, huge, tiny, readability" }
end

local function accentNow() return Theme.Color("accent") end
local function accentSource() return L["Accent"] end

local SPECS = {
	-- The window: style, size, ground and border, opacity, when it shows, where it grows.
	{ page = PAGE, key = "guidewindow", icon = "window", order = 21, group = "look", tab = L["Window"], section = L["Style"],
		preview = buildPreview,
		subtitle = L["The guide window and each of its parts: style, size, text, spacing, bars, colours and motion. Everything shows on the window as you change it; right-click a setting to reset it."],
		controls = {
		{ kind = "dropdown", key = "ui.style", label = L["Style"], search = "transparent, standard, background, see through, minimal, style",
			help = L["Transparent drops every background and border; text is outlined and the controls appear when you hover the window."],
			choices = { { value = "standard", label = L["Standard"] }, { value = "transparent", label = L["Transparent"] } } },
		{ kind = "dropdown", key = "ui.backing", label = L["Backing"], child = true, disabled = notTransparent,
			help = L["With Transparent: Soft lays a light shade behind each line of text, Dark a dark backing behind the whole window. Off: the outlined text alone on the world."],
			search = "transparent, background, shade, dark, readable, contrast",
			choices = { { value = "soft", label = L["Soft"] }, { value = "dark", label = L["Dark"] }, { value = "none", label = L["Off"] } } },
		{ kind = "slider", key = "guideWindow.veil", label = L["Dark backing strength"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW, child = true,
			disabled = function() return not transparent() or ns.Get("ui.backing") ~= "dark" end,
			help = L["How dark the Dark backing is behind the transparent window. Right-click to reset."],
			search = "backing, darker, lighter, scrim, veil, contrast, readable, opacity" },
		{ kind = "slider", key = "guideWindow.shade", label = L["Soft shade strength"], min = 0.05, max = 0.6, step = 0.05, format = percent, new = NEW, child = true,
			disabled = function() return not transparent() or ns.Get("ui.backing") ~= "soft" end,
			help = L["How dark the light shade behind each line of the transparent window is. Right-click to reset."],
			search = "shade, soft, darker, lighter, contrast, readable" },
		{ kind = "dropdown", key = "guideWindow.outline", label = L["Text outline"], new = NEW, child = true, disabled = notTransparent,
			help = L["With Transparent, how the text stands out from the world: a thin outline, a thick one, or the drop shadow alone."],
			search = "outline, thick, stroke, shadow, readable, contrast, legible, border text",
			choices = { { value = "outline", label = L["Outline"] }, { value = "thick", label = L["Thick outline"] }, { value = "shadow", label = L["Shadow only"] } } },
		{ kind = "toggle", key = "ui.barShown", label = L["Keep the bar shown"], child = true, disabled = notTransparent,
			help = L["With Transparent, the tabs and the step bar stay on screen instead of only under the cursor."],
			search = "transparent, bar, header, readable, always, show" },
	} },
	{ page = PAGE, tab = L["Window"], section = L["Size"], controls = {
		{ kind = "slider", key = "ui.scale", label = L["Window scale"], min = 0.6, max = 1.6, step = 0.05, format = percent,
			help = L["The whole guide window, text and all. Right-click to reset."],
			search = "size, bigger, smaller, zoom, scale, huge, tiny" },
		{ kind = "slider", key = "ui.width", label = L["Width"], min = 260, max = 560, step = 10, format = "%d",
			help = L["How wide the guide window is. You can also drag its bottom-right corner."],
			search = "wide, wider, narrow, size, width" },
		{ kind = "slider", key = "ui.maxHeight", label = L["Maximum height"], min = 0.3, max = 0.9, step = 0.05, format = percent,
			help = L["How tall the window may grow, as a share of the screen. A longer step scrolls."],
			search = "height, tall, taller, shorter, cap, scroll, size" },
		{ kind = "toggle", key = "ui.compact", label = L["Compact mode"], help = L["Only the header and the current step's goals."],
			search = "minimal, small, smaller window, simple, mini nav, compact" },
	} },
	{ page = PAGE, tab = L["Window"], section = L["Background & border"], controls = {
		{ kind = "color", key = "guideWindow.bgColor", label = L["Background colour"], new = NEW, disabled = transparent,
			help = L["This window's own background colour. Right-click to go back to the one every Polestar window shares."],
			search = "background, ground, colour, color, tint, backdrop, fill",
			shown = function() return Theme.Color("bg") end, source = function() return L["Every window's"] end },
		{ kind = "slider", key = "guideWindow.bgOpacity", label = L["Background opacity"], min = 0, max = 1, step = 0.05, format = percent, new = NEW, disabled = transparent,
			help = L["This window's own background opacity: how much of the world shows through. Right-click to go back to the one every Polestar window shares."],
			search = "transparency, alpha, see through, translucent, background opacity",
			get = function() return tonumber(look("bgOpacity")) or Theme.GroundAlpha() end,
			set = function(v) ns.Set("guideWindow.bgOpacity", v) end },
		{ kind = "toggle", key = "guideWindow.border", label = L["Border"], new = NEW,
			disabled = function() return transparent() or ns.Get("ui.border") == false end,
			help = L["The line around this window. Its colour and thickness are on the Theme page, with every window's."],
			search = "border, edge, outline, frame, line" },
		{ kind = "toggle", key = "guideWindow.rules", label = L["Dividers"], new = NEW,
			help = L["The thin lines between the tabs, the step bar and the window's sections."],
			search = "divider, dividers, hairline, separator, lines, rules" },
	} },
	{ page = PAGE, tab = L["Window"], section = L["Opacity"], controls = {
		{ kind = "slider", key = "ui.opacity", label = L["Window opacity"], min = 0.3, max = 1, step = 0.05, format = percent,
			help = L["The whole guide window, text included. The background's own opacity is above."],
			search = "transparency, alpha, see through, fade" },
		{ kind = "slider", key = "guideWindow.idleAlpha", label = L["Opacity when not hovered"], min = 0.1, max = 1, step = 0.05, format = percent, new = NEW,
			help = L["The window fades to this while the cursor is away from it, and comes back in full when you point at it. 100% keeps it as it is."],
			search = "fade, mouseover, hover, mouse out, idle, out of the way, transparency, alpha, ghost" },
	} },
	{ page = PAGE, tab = L["Window"], section = L["When it shows"], controls = {
		{ kind = "dropdown", key = "ui.combat", label = L["In combat"], help = L["What the window does while you fight."],
			search = "hide in combat, fade in combat, fighting, visibility",
			choices = { { value = "show", label = L["Keep visible"] }, { value = "fade", label = L["Fade out"] }, { value = "hide", label = L["Hide"] } } },
		{ kind = "slider", key = "guideWindow.combatAlpha", label = L["Combat fade"], min = 0, max = 0.9, step = 0.05, format = percent, new = NEW, child = true,
			disabled = function() return ns.Get("ui.combat") ~= "fade" end,
			help = L["How far the window fades in a fight with In combat set to Fade out. Right-click to reset."],
			search = "combat, fade, fighting, opacity, alpha, transparency" },
		{ kind = "dropdown", key = "ui.instance", label = L["In dungeons and battlegrounds"],
			help = L["What the window, its buttons and alerts do in dungeons, raids, battlegrounds and arenas. The minimap button, the key binding or /polestar opens it there until you leave."],
			search = "dungeon, raid, battleground, arena, instance, hide, pvp, healer, visibility",
			choices = { { value = "show", label = L["Keep visible"] }, { value = "hide", label = L["Hide"] } } },
		{ kind = "toggle", key = "guideWindow.hideTaxi", label = L["Hide while flying"], new = NEW,
			help = L["The window hides on a flight path and comes back when you land."],
			search = "taxi, flight, flying, gryphon, wyvern, flight path, hide, visibility" },
	} },
	{ page = PAGE, tab = L["Window"], section = L["Position"], controls = {
		{ kind = "toggle", key = "ui.growUp", label = L["Grow upward"], help = L["Keep the bottom edge in place, so longer steps extend the window up."],
			search = "grow, upward, bottom, anchor, direction, growth" },
		{ kind = "toggle", key = "ui.barsBottom", label = L["Bar at the bottom"], child = true, disabled = function() return not ns.Get("ui.growUp") end,
			help = L["With Grow upward, put the tabs and the step bar at the bottom edge, next to where the window is pinned."],
			search = "bar, bottom, tabs, flip, header at bottom" },
	} },

	-- Text: each element's size, spacing, glyphs.
	{ page = PAGE, tab = L["Text"], section = L["Text sizes"], preview = buildPreview, controls = {
		textSize("titleSize", L["Person and title"], L["The name of the person to talk to now, or the step's place, at the top of the card."],
			"title, step title, name, header, npc name, person"),
		textSize("goalSize", L["Goals"], L["The goal lines of the step and of While you're here."], "goal, goals, objectives, step text, lines"),
		textSize("detailSize", L["Details"], L["The lines under a goal, where the person is, the summary lines and Then:."],
			"details, secondary, subline, small text, where, then"),
		textSize("noteSize", L["Tips"], L["The author's tip under the goals."], "tip, tips, note, notes, author"),
		textSize("upSize", L["Up next and Along the way"], L["Their rows and their headers; the rows grow with the text."],
			"up next, upcoming, along the way, later steps, list, rows"),
		textSize("barTextSize", L["Tabs and step bar"], L["The tabs, the step number, the guide's title, Skip and the percent."],
			"tabs, step number, counter, bar, header, percent, navigator"),
	} },
	{ page = PAGE, tab = L["Text"], section = L["Spacing"], controls = {
		{ kind = "slider", key = "guideWindow.lineSpacing", label = L["Line spacing"], min = 0, max = 8, step = 1, format = px, new = NEW,
			help = L["Extra room between the wrapped lines of a goal, its details and the tip."],
			search = "line spacing, line height, leading, room, airy, dense, cramped" },
		{ kind = "slider", key = "guideWindow.rowSpacing", label = L["Goal spacing"], min = 0, max = 12, step = 1, format = px, new = NEW,
			help = L["Extra room above and below each goal."],
			search = "row spacing, goal spacing, gap, room, padding, airy, dense, cramped" },
		{ kind = "slider", key = "guideWindow.padding", label = L["Inner padding"], min = -6, max = 16, step = 1, format = signedPx, new = NEW,
			help = L["Room between the window's edges and its text, on top of the skin's."],
			search = "padding, margin, inset, edge, room, tight, roomy" },
	} },
	{ page = PAGE, tab = L["Text"], section = L["Glyphs"], controls = {
		{ kind = "slider", key = "guideWindow.glyphSize", label = L["Goal glyphs"], min = 0.6, max = 2, step = 0.05, format = percent, new = NEW,
			help = L["The icons before each goal and the person: kill, collect, talk, the check of a goal done."],
			search = "icon, icons, glyph, glyphs, symbol, bigger, smaller, size" },
		{ kind = "slider", key = "guideWindow.checkSize", label = L["Tick boxes"], min = 0.6, max = 1.8, step = 0.05, format = percent, new = NEW,
			help = L["The tick box at the right of each goal."],
			search = "tick, checkbox, check box, box, bigger, smaller, size" },
	} },

	-- Parts: the bars, the current goal's mark, the progress line, sections.
	{ page = PAGE, tab = L["Parts"], section = L["Tab bar"], preview = buildPreview, controls = {
		{ kind = "toggle", key = "guideWindow.tabs", label = L["Tabs"], new = NEW,
			help = L["The tabs of the open guides above the step bar. Off: the step bar names the guide, and the guide menu switches guides."],
			search = "tabs, tab bar, header, strip, hide tabs, guides" },
		{ kind = "slider", key = "guideWindow.tabHeight", label = L["Tab height"], min = 0.7, max = 1.6, step = 0.05, format = percent, new = NEW, child = true,
			disabled = off("tabs"), help = L["How tall the tab bar is."], search = "tab height, taller, shorter, header, size" },
	} },
	{ page = PAGE, tab = L["Parts"], section = L["Step bar"], controls = {
		{ kind = "slider", key = "guideWindow.navHeight", label = L["Step bar height"], min = 0.7, max = 1.6, step = 0.05, format = percent, new = NEW,
			help = L["How tall the bar with the step number, Skip and the menu is."], search = "bar height, header, navigator, taller, shorter, size" },
		{ kind = "toggle", key = "guideWindow.stepCount", label = L["Step number"], new = NEW,
			help = L["The step number with its previous and next arrows."], search = "step number, counter, arrows, previous, next, 8 / 29" },
		{ kind = "toggle", key = "guideWindow.guideTitle", label = L["Guide title"], new = NEW,
			help = L["The guide's name in the step bar, shown when no tab names it."], search = "title, guide name, zone, header" },
		{ kind = "toggle", key = "guideWindow.skipButton", label = L["Skip button"], new = NEW,
			help = L["Skip in the step bar. The guide menu still skips a step."], search = "skip, button, hide skip" },
		{ kind = "toggle", key = "guideWindow.reportButton", label = L["Report button"], new = NEW,
			help = L["The bug button that reports a problem with the step. The guide menu still has it."], search = "bug, report, problem, button" },
	} },
	{ page = PAGE, tab = L["Parts"], section = L["Current goal"], controls = {
		{ kind = "toggle", key = "guideWindow.targetBar", label = L["Target bar"], new = NEW,
			help = L["The bar at the left edge of the goal or person the arrow points to."],
			search = "accent bar, marker, current goal, highlight, selection, target" },
		{ kind = "color", key = "guideWindow.targetBarColor", label = L["Target bar colour"], new = NEW, child = true, disabled = off("targetBar"),
			help = L["Click to pick your own, right-click to go back to the accent."],
			search = "accent bar colour, marker colour, highlight colour", shown = accentNow, source = accentSource },
		{ kind = "slider", key = "guideWindow.targetBarWidth", label = L["Target bar width"], min = 1, max = 6, step = 1, format = px, new = NEW, child = true,
			disabled = off("targetBar"), help = L["How wide the target bar is."], search = "bar width, thicker, thinner, marker" },
	} },
	{ page = PAGE, tab = L["Parts"], section = L["Progress"], controls = {
		{ kind = "toggle", key = "guideWindow.progress", label = L["Progress bar"], new = NEW,
			help = L["The guide's progress at the bottom of the window."], search = "progress, bar, percent, footer, completion" },
		{ kind = "slider", key = "guideWindow.progressHeight", label = L["Progress bar thickness"], min = 1, max = 12, step = 1, format = px, new = NEW, child = true,
			disabled = off("progress"), help = L["How thick the progress line is. The game's looks keep their own bar."],
			search = "thickness, height, thicker, thinner, progress line",
			get = function() return GF().ProgressHeight() end },
		{ kind = "color", key = "guideWindow.progressColor", label = L["Progress colour"], new = NEW, child = true, disabled = off("progress"),
			help = L["Click to pick your own, right-click to go back to the accent."],
			search = "progress colour, fill colour, bar colour", shown = accentNow, source = accentSource },
		{ kind = "toggle", key = "guideWindow.progressPct", label = L["Percent"], new = NEW, child = true, disabled = off("progress"),
			help = L["The percent beside the progress bar."], search = "percent, number, percentage" },
	} },
	{ page = PAGE, tab = L["Parts"], section = L["Sections"], controls = {
		{ kind = "toggle", key = "ui.showNotes", label = L["Step tips"], help = L["The author's tip under the goals, one line until clicked."],
			search = "tips, notes, author, hint" },
		{ kind = "slider", key = "ui.upcoming", label = L["Upcoming steps"], min = 0, max = 6, step = 1, format = "%d",
			help = L["How many steps the Up next list holds; 0 turns it off."], search = "up next, upcoming, later steps, list, preview" },
	} },

	-- Motion.
	{ page = PAGE, tab = L["Motion"], section = L["Motion"], preview = buildPreview, controls = {
		{ kind = "toggle", key = "guideWindow.stepAnim", label = L["Step change slide"], new = NEW,
			help = L["The next person or step slides up into place as it fades in. Off: it is simply there."],
			search = "animation, transition, slide, fade, step change, motion" },
		{ kind = "slider", key = "guideWindow.animSpeed", label = L["Step change speed"], min = 0.5, max = 3, step = 0.1, format = times, new = NEW, child = true,
			disabled = off("stepAnim"), help = L["How fast the step change and finished goals move: 2x takes half the time. Right-click to reset."],
			search = "animation speed, faster, slower, snappy, transition" },
		{ kind = "toggle", key = "guideWindow.foldAnim", label = L["Finished goals fold away"], new = NEW,
			help = L["A goal you finish shuts like a drawer into the done line. Off: it fades and goes."],
			search = "fold, collapse, animation, done goals, finished, motion" },
		{ kind = "toggle", key = "ui.reduceMotion", label = L["Reduce motion"], help = L["No sliding or popping; fades stay short. For every Polestar window."],
			search = "animations, motion sickness, fps, frame rate, performance" },
	} },
}

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
