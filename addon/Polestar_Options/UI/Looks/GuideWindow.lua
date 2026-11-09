-- The settings window's Guide window page (look group, key "guidewindow"),
-- two tabs. Window: the frame (style, with what only Transparent uses in its
-- cog; size), its ground (background, opacity, fading when away, border),
-- how it behaves (combat, dungeons, flights, growing up, motion). Parts, as
-- the window stacks them: the bars, the step card (text sizes, glyphs,
-- spacing, tick boxes, the target bar), then the tip, Up next and the
-- progress bar. Every setting is applied by the window itself
-- (UI/GuideFrame.lua: readMetrics, GF.LOOK, GF.ApplyLook) and shows on it at
-- once.
--
-- Each tab pins the same live preview over its rows: a step card laid out by
-- the window's own sizes (GF.Metrics), its own text roles, size groups
-- (GF.SIZE_KEYS), outline, target bar and progress paint, over the night
-- sky, at its real size, cropped to the band and scrolled to the part the
-- last changed setting edits; a click on a part jumps to its row. It is fed
-- a fixed demo step, never the live window or the Engine, is built the first
-- time a tab shows, and repaints only while shown.

local ns = Polestar
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

---------------------------------------------------------------------------
-- The preview
---------------------------------------------------------------------------

local PREVIEW_H = 250 -- short enough to leave the sections most of the page
local TOP = 36 -- under the "Preview" caption

-- The settings that change what the preview draws (besides guideWindow.*
-- and the theme, which W.Painter follows).
local WATCH = {
	[""] = true, ["guideWindow"] = true, ["ui"] = true,
	["ui.style"] = true, ["ui.backing"] = true, ["ui.barShown"] = true, ["ui.scale"] = true, ["ui.width"] = true,
	["ui.opacity"] = true, ["ui.compact"] = true, ["ui.showNotes"] = true, ["ui.upcoming"] = true, ["nav.nearbyButton"] = true,
}

-- The part of the window a setting edits, which the cropped preview
-- scrolls to when it changes (anything else leaves the scroll as it is).
local PART_OF = {}
for part, keys in pairs({
	bars = { "tabs", "tabHeight", "navHeight", "barTextSize", "stepCount", "guideTitle", "skipButton", "reportButton" },
	person = { "titleSize", "glyphSize" },
	goals = { "goalSize", "detailSize", "rowSpacing", "lineSpacing", "checkSize", "targetBar", "targetBarWidth", "targetBarColor" },
	tip = { "noteSize", "upSize" },
	foot = { "progress", "progressHeight", "progressColor", "progressPct" },
}) do
	for _, k in ipairs(keys) do PART_OF["guideWindow." .. k] = part end
end
PART_OF["ui.showNotes"], PART_OF["ui.upcoming"] = "tip", "tip"

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
	-- its size setting (GF.SIZE_KEYS), `spacing` its own line spacing.
	local function text(parent, role, color, group, spacing)
		local fs = W.Text(parent, role, color)
		fs.psGroup, fs.psSpacing = group, spacing
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
	f.Nav = nav

	-- The focus: who to talk to.
	local person = CreateFrame("Frame", nil, gw)
	person.Icon = person:CreateTexture(nil, "ARTWORK")
	person.Icon:SetTexture(Theme.VerbIcon("talk"))
	W.Color(person.Icon, "textDim")
	person.Name = text(person, "name", "npc", "title")
	person.Name:SetText(L["Marshal Dughan"])
	person.Where = text(person, "small", "textDim", "detail")
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
		r.Text = text(r, "goal", done and "textMuted" or "text", "goal", 0)
		r.Text:SetWordWrap(true)
		r.Text:SetJustifyH("LEFT")
		r.Text:SetJustifyV("TOP")
		r.Sub = text(r, "small", "textMuted", "detail", 0)
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
	tip.Text = text(tip, "note", "textDim", "note", 3)
	tip.Text:SetJustifyH("LEFT")
	tip.Text:SetWordWrap(false)
	tip.Text:SetText(L["Kobolds drop Gold Dust too: keep what you loot on the way."])
	f.Tip = tip

	-- Up next: its toggle and one row.
	local up = CreateFrame("Frame", nil, gw)
	up.Rule = W.Divider(up)
	up.Label = text(up, "small", "textMuted", "up")
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
	up.Text = text(up, "label", "textDim", "up")
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
		for _, fs in ipairs(self.texts) do
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
		-- Where each part starts (window units), for the scroll to the part a
		-- setting edits (f.psFocus).
		local at = { bars = 0 }
		self.partY = at

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
		local right = 8
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
		at.person = y

		-- The focus.
		local nameW = w - pad * 2 - M.icon - 10
		person.Name:SetWidth(nameW)
		person.Where:SetWidth(nameW)
		person:ClearAllPoints()
		person:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -y)
		person:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -y)
		person.Icon:SetSize(M.icon + 1, M.icon + 1)
		person.Icon:SetPoint("TOPLEFT", person, "TOPLEFT", pad - 1, -(11 + floor((G.Num("titleSize") - 1) * 7 + 0.5)))
		person.Name:SetPoint("TOPLEFT", person, "TOPLEFT", textX, -10)
		person.Where:SetPoint("TOPLEFT", person.Name, "BOTTOMLEFT", 0, -3)
		local ph = floor(10 + person.Name:GetStringHeight() + 3 + person.Where:GetStringHeight() + 8 + 0.5)
		person:SetHeight(ph)
		y = y + ph

		-- The goals (measureRow's sizes).
		at.goals = y
		local tw = max(40, w - textX - (pad + M.check + 4 + M.checkIn))
		for _, r in ipairs(self.Rows) do
			r.Text:SetWidth(tw)
			r.Sub:SetWidth(tw)
			local h = 4 + r.Text:GetStringHeight()
			if r.Sub:IsShown() then h = h + 3 + r.Sub:GetStringHeight() end
			h = max(M.rowMin, floor(h + 6 + M.rowPad * 2 + 0.5))
			r:ClearAllPoints()
			r:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -y)
			r:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -y)
			r:SetHeight(h)
			r.Icon:SetSize(M.icon, M.icon)
			r.Icon:SetPoint("CENTER", r, "TOPLEFT", pad + M.icon / 2, -M.glyphY)
			r.Text:SetPoint("TOPLEFT", r, "TOPLEFT", textX, -4 - M.rowPad)
			r.Sub:SetPoint("TOPLEFT", r.Text, "BOTTOMLEFT", 0, -3)
			r.Check:SetSize(M.check, M.check)
			r.Check:ClearAllPoints()
			r.Check:SetPoint("TOPRIGHT", r, "TOPRIGHT", -(pad - 3 + M.checkIn), -3 - M.rowPad)
			r.Check.psOnWorld = clear
			Theme.Repaint(r.Check)
			G.PaintMark(r.Mark)
			y = y + h
		end

		-- The tip, one line.
		at.tip = y
		local showTip = not isCompact and ns.Get("ui.showNotes") ~= false
		tip:SetShown(showTip)
		if showTip then
			tip.Text:SetWidth(w - pad * 2 - 18)
			local th = min(tip.Text:GetStringHeight(), tip.Text:GetLineHeight())
			local h = floor(6 + th + 6 + 0.5)
			tip:ClearAllPoints()
			tip:SetPoint("TOPLEFT", gw, "TOPLEFT", 0, -(y + 2))
			tip:SetPoint("TOPRIGHT", gw, "TOPRIGHT", 0, -(y + 2))
			tip:SetHeight(h)
			tip.Toggle:SetPoint("TOPLEFT", tip, "TOPLEFT", pad + 2, -7)
			tip.Text:SetPoint("TOPLEFT", tip, "TOPLEFT", textX, -6)
			y = y + 2 + h
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
		at.foot = y
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
			foot.Line:SetHeight(G.Num("progressHeight"))
			foot.Line:SetWidth(max(1, lw))
			foot.Line:SetPoint("LEFT", foot, "LEFT", pad, 0)
			local tr, tg, tb, ta = Theme.Wash("progress")
			foot.Line.Track:SetVertexColor(tr, tg, tb, clear and 0.15 or ta)
			G.PaintProgressFill(foot.Line.Fill)
			W.SetProgress(foot.Line, 0.38, lw)
			y = y + M.progH
		end
		gw:SetHeight(y)

		-- The band behind the bars (Standard, the house skin), the transparent
		-- style's backing, the bars that wait for the cursor.
		gw.Band:SetShown(not clear and Theme.SkinKey() == "polestar")
		gw.Band:SetHeight(barsH)
		gw.Band:SetTexCoord(Theme.BandCoords(w - 2, barsH, 30))
		local veil = G.Backing()
		gw.Veil:SetShown(veil ~= nil)
		if veil then Theme.PaintScrim(gw.Veil, veil) end
		local soft = G.SoftShade()
		for _, fs in ipairs(self.texts) do G.ShadeText(fs, soft and fs:IsVisible()) end
		local bars = (not clear or self.psHover or ns.Get("ui.barShown")) and 1 or 0
		strip:SetAlpha(bars)
		for _, t in ipairs({ nav.Prev, nav.Count, nav.Next, nav.Title, nav.Menu, nav.Report, nav.Nearby, nav.Skip, nav.SkipIcon }) do t:SetAlpha(bars) end
		gw:SetAlpha((ns.Get("ui.opacity") or 1) * (self.psHover and 1 or G.Num("idleAlpha")))

		-- The window at its own size (smaller only when the page is too narrow
		-- for its width), cropped to the band and scrolled to the part the last
		-- setting changed edits.
		local s = tonumber(ns.Get("ui.scale")) or 1
		local k = s * min(1, (width - 32) / (w * s))
		local room = (PREVIEW_H - TOP - 8) / k
		local scroll = 0
		if y > room then
			local part = at[self.psFocus or "bars"] or 0
			scroll = max(0, min(y - room, part - 12))
		end
		gw:SetScale(k)
		gw:ClearAllPoints()
		gw:SetPoint("TOP", self, "TOP", 0, -TOP / k + scroll)
		self.psScale, self.psScroll = k, scroll
		self:Hotspots()
	end

	-- Clicks on the parts of the window jump to their rows (the settings
	-- window's preview hotspots, once it offers them).
	function f:Hotspots()
		if self.psHot then return end
		local O = UI.Options
		local add = (self.Hotspot and function(region, key) self:Hotspot(region, key) end)
			or (O and O.PreviewHotspot and function(region, key) O.PreviewHotspot(self, region, key) end)
		if not add then return end
		self.psHot = true
		add(strip, "guideWindow.tabHeight")
		add(nav, "guideWindow.navHeight")
		add(person, "guideWindow.titleSize")
		for _, r in ipairs(self.Rows) do add(r, "guideWindow.goalSize") end
		add(tip, "guideWindow.noteSize")
		add(up, "guideWindow.upSize")
		add(foot, "guideWindow.progressHeight")
	end

	function f:Refresh()
		if self:IsVisible() then self:Paint() else self.psDirty = true end
	end
	-- A tab opening starts at the bars, the top of the window.
	f:SetScript("OnShow", function(self)
		local moved = self.psFocus ~= nil and self.psFocus ~= "bars"
		self.psFocus = "bars"
		if self.psDirty or moved then self:Paint() end
	end)

	-- The settings window, on hovering a row: the crop scrolls to the part
	-- that setting edits (a setting of the window as a whole leaves it).
	function f:Focus(key)
		local part = key and PART_OF[key]
		if not part or part == self.psFocus then return end
		self.psFocus = part
		if self:IsVisible() then self:Paint() else self.psDirty = true end
	end
	-- The theme (skin, scheme, accent, font): the sky and the window again.
	W.Painter(f, function(self)
		Theme.Border(self, Theme.Wash("divider"))
		local r, g, b = Theme.Color("sky")
		self.Lift:SetVertexColor(r, g, b, 0.75)
		self:Refresh()
	end)
	ns.On("SETTING_CHANGED", function(path)
		if not (WATCH[path] or (type(path) == "string" and path:sub(1, 12) == "guideWindow.")) then return end
		f.psFocus = PART_OF[path] or f.psFocus
		f:Refresh()
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
-- The controls (the settings window's layout v2: one section per element
-- in the window's anatomy order, the element's on/off in the section
-- header, size + colour of one element on one row, secondary knobs behind
-- the row's cog, help in the tooltip)
---------------------------------------------------------------------------

local TEXT_SEARCH = ", text size, font size, bigger, smaller, larger, huge, tiny, readability"
local function textSize(key, label, help, search)
	return { kind = "slider", key = "guideWindow." .. key, label = label, min = 0.7, max = 1.8, step = 0.05, format = percent, new = NEW,
		help = help, search = search .. TEXT_SEARCH }
end

local function accentNow() return Theme.Color("accent") end
local function accentSource() return L["Accent"] end

local function offKey(key) return function() return look(key) == false end end

local SPECS = {
	-- Window: the frame as a whole, its ground, then how it behaves.
	{ page = PAGE, key = "guidewindow", icon = "window", order = 21, group = "look", tab = L["Window"], section = L["Window"],
		preview = buildPreview,
		subtitle = L["The guide window's frame, bars, step card, tips and progress bar."],
		controls = {
		{ kind = "dropdown", key = "ui.style", label = L["Style"], search = "transparent, standard, background, see through, minimal, style",
			help = L["Transparent drops every background and border; text is outlined and the controls appear when you hover the window."],
			choices = { { value = "standard", label = L["Standard"] }, { value = "transparent", label = L["Transparent"] } },
			-- What only the Transparent style uses.
			more = {
				{ kind = "dropdown", key = "ui.backing", label = L["Backing"], disabled = notTransparent,
					help = L["With Transparent: Soft lays a light shade behind each line of text, Dark a dark backing behind the whole window. Off: the outlined text alone on the world."],
					search = "transparent, background, shade, dark, readable, contrast",
					choices = { { value = "soft", label = L["Soft"] }, { value = "dark", label = L["Dark"] }, { value = "none", label = L["Off"] } } },
				{ kind = "slider", key = "guideWindow.veil", label = L["Dark strength"], min = 0.2, max = 1, step = 0.05, format = percent, new = NEW,
					disabled = function() return not transparent() or ns.Get("ui.backing") ~= "dark" end,
					help = L["How dark the Dark backing is behind the transparent window."],
					search = "backing, darker, lighter, scrim, veil, contrast, readable, opacity" },
				{ kind = "slider", key = "guideWindow.shade", label = L["Soft strength"], min = 0.05, max = 0.6, step = 0.05, format = percent, new = NEW,
					disabled = function() return not transparent() or ns.Get("ui.backing") ~= "soft" end,
					help = L["How dark the light shade behind each line of the transparent window is."],
					search = "shade, soft, darker, lighter, contrast, readable" },
				{ kind = "dropdown", key = "guideWindow.outline", label = L["Outline"], new = NEW, disabled = notTransparent,
					help = L["With Transparent, how the text stands out from the world: a thin outline, a thick one, or the drop shadow alone."],
					search = "outline, text outline, thick, stroke, shadow, readable, contrast, legible, border text",
					choices = { { value = "outline", label = L["Outline"] }, { value = "thick", label = L["Thick outline"] }, { value = "shadow", label = L["Shadow only"] } } },
				{ kind = "toggle", key = "ui.barShown", label = L["Keep bars shown"], disabled = notTransparent,
					help = L["With Transparent, the tabs and the step bar stay on screen instead of only under the cursor."],
					search = "transparent, bar, header, readable, always, show" },
			} },
		{ kind = "slider", key = "ui.scale", label = L["Scale"], min = 0.6, max = 1.6, step = 0.05, format = percent,
			help = L["The whole guide window, text and all."],
			search = "size, bigger, smaller, zoom, scale, huge, tiny, window scale" },
		{ kind = "slider", key = "ui.width", label = L["Width"], min = 260, max = 560, step = 10, format = "%d",
			help = L["How wide the guide window is. You can also drag its bottom-right corner."],
			search = "wide, wider, narrow, size, width" },
		{ kind = "slider", key = "ui.maxHeight", label = L["Max height"], min = 0.3, max = 0.9, step = 0.05, format = percent,
			help = L["How tall the window may grow, as a share of the screen. A longer step scrolls."],
			search = "height, tall, taller, shorter, cap, scroll, size, maximum height" },
		{ kind = "slider", key = "guideWindow.padding", label = L["Padding"], min = -6, max = 16, step = 1, format = signedPx, new = NEW,
			help = L["Room between the window's edges and its text, on top of the skin's."],
			search = "padding, margin, inset, edge, room, tight, roomy, inner padding" },
		{ kind = "toggle", key = "ui.compact", label = L["Compact"], help = L["Only the header and the current step's goals."],
			search = "minimal, small, smaller window, simple, mini nav, compact mode" },
	} },
	{ page = PAGE, tab = L["Window"], section = L["Background"], controls = {
		{ kind = "slider", key = "guideWindow.bgOpacity", label = L["Background"], min = 0, max = 1, step = 0.05, format = percent, new = NEW, disabled = transparent,
			help = L["This window's own background opacity: how much of the world shows through. Its own colour is the swatch. Unset, both follow every Polestar window's."],
			search = "transparency, alpha, see through, translucent, background opacity, background colour",
			get = function() return tonumber(look("bgOpacity")) or Theme.GroundAlpha() end,
			set = function(v) ns.Set("guideWindow.bgOpacity", v) end,
			extras = {
				{ kind = "color", key = "guideWindow.bgColor", label = L["Background colour"], new = NEW, disabled = transparent,
					help = L["This window's own background colour. Unset, it follows every Polestar window's."],
					search = "background, ground, colour, color, tint, backdrop, fill",
					shown = function() return Theme.Color("bg") end, source = function() return L["Every window's"] end },
			} },
		{ kind = "slider", key = "ui.opacity", label = L["Opacity"], min = 0.3, max = 1, step = 0.05, format = percent,
			help = L["The whole guide window, text included."],
			search = "transparency, alpha, see through, fade, window opacity" },
		{ kind = "slider", key = "guideWindow.idleAlpha", label = L["When away"], min = 0.1, max = 1, step = 0.05, format = percent, new = NEW, info = true,
			help = L["The window fades to this while the cursor is away from it, and comes back in full when you point at it. 100% keeps it as it is."],
			search = "fade, fade when away, mouseover, hover, mouse out, idle, out of the way, transparency, alpha, ghost, opacity when not hovered" },
		{ kind = "toggle", key = "guideWindow.border", label = L["Border"], new = NEW,
			help = L["The line around this window, while every window has one. Its colour and thickness, and whether windows have one, are on the Theme page."],
			search = "border, edge, outline, frame, line",
			more = {
				{ kind = "toggle", key = "guideWindow.rules", label = L["Dividers"], new = NEW,
					help = L["The thin lines between the tabs, the step bar and the window's sections."],
					search = "divider, dividers, hairline, separator, lines, rules" },
			} },
	} },
	{ page = PAGE, tab = L["Window"], section = L["Behaviour"], controls = {
		{ kind = "dropdown", key = "ui.combat", label = L["In combat"], help = L["What the window does while you fight."],
			search = "hide in combat, fade in combat, fighting, visibility",
			choices = { { value = "show", label = L["Keep visible"] }, { value = "fade", label = L["Fade out"] }, { value = "hide", label = L["Hide"] } },
			more = {
				{ kind = "slider", key = "guideWindow.combatAlpha", label = L["Combat opacity"], min = 0, max = 0.9, step = 0.05, format = percent, new = NEW,
					disabled = function() return ns.Get("ui.combat") ~= "fade" end,
					help = L["How far the window fades in a fight with In combat set to Fade out."],
					search = "combat, fade, fighting, opacity, alpha, transparency, combat fade" },
			} },
		{ kind = "dropdown", key = "ui.instance", label = L["In dungeons"],
			help = L["What the window, its buttons and alerts do in dungeons, raids, battlegrounds and arenas. The minimap button, the key binding or /polestar opens it there until you leave."],
			search = "dungeon, raid, battleground, arena, instance, hide, pvp, healer, visibility",
			choices = { { value = "show", label = L["Keep visible"] }, { value = "hide", label = L["Hide"] } } },
		{ kind = "toggle", key = "guideWindow.hideTaxi", label = L["Hide on flights"], new = NEW,
			help = L["The window hides on a flight path and comes back when you land."],
			search = "taxi, flight, flying, gryphon, wyvern, flight path, hide, visibility, while flying" },
		{ kind = "toggle", key = "ui.growUp", label = L["Grow upward"], help = L["Keep the bottom edge in place, so longer steps extend the window up."],
			search = "grow, upward, bottom, anchor, direction, growth, position",
			more = {
				{ kind = "toggle", key = "ui.barsBottom", label = L["Bars at bottom"], disabled = function() return not ns.Get("ui.growUp") end,
					help = L["With Grow upward, put the tabs and the step bar at the bottom edge, next to where the window is pinned."],
					search = "bar, bottom, tabs, flip, header at bottom" },
			} },
		{ kind = "toggle", key = "guideWindow.stepAnim", label = L["Step slide"], new = NEW,
			help = L["The next person or step slides up into place as it fades in. Off: it is simply there."],
			search = "animation, transition, slide, fade, step change, motion",
			more = {
				{ kind = "slider", key = "guideWindow.animSpeed", label = L["Speed"], min = 0.5, max = 3, step = 0.1, format = times, new = NEW,
					help = L["How fast the step change and finished goals move: 2x takes half the time."],
					search = "animation speed, faster, slower, snappy, transition" },
			} },
		{ kind = "toggle", key = "guideWindow.foldAnim", label = L["Fold done goals"], new = NEW,
			help = L["A goal you finish shuts like a drawer into the done line. Off: it fades and goes."],
			search = "fold, collapse, animation, done goals, finished, motion" },
	} },

	-- Parts, top to bottom as the window stacks them.
	{ page = PAGE, tab = L["Parts"], section = L["Bars"], preview = buildPreview, controls = {
		{ kind = "slider", key = "guideWindow.tabHeight", label = L["Tab height"], min = 0.7, max = 1.6, step = 0.05, format = percent, new = NEW,
			disabled = offKey("tabs"),
			help = L["How tall the tab bar is."], search = "tab height, taller, shorter, header, size, tabs",
			extras = {
				{ kind = "toggle", key = "guideWindow.tabs", label = L["Tabs"], new = NEW,
					help = L["The tabs of the open guides above the step bar. Off: the step bar names the guide, and the guide menu switches guides."],
					search = "tabs, tab bar, header, strip, hide tabs, guides" },
			} },
		{ kind = "slider", key = "guideWindow.navHeight", label = L["Step bar height"], min = 0.7, max = 1.6, step = 0.05, format = percent, new = NEW,
			help = L["How tall the bar with the step number, Skip and the menu is."], search = "bar height, header, navigator, taller, shorter, size, step bar height" },
		textSize("barTextSize", L["Bar text"], L["The tabs, the step number, the guide's title, Skip and the percent."],
			"tabs, step number, counter, bar, header, percent, navigator, bar text size"),
		{ kind = "toggle", key = "guideWindow.stepCount", label = L["Step number"], new = NEW,
			help = L["The step number with its previous and next arrows."], search = "step number, counter, arrows, previous, next, 8 / 29",
			more = {
				{ kind = "toggle", key = "guideWindow.guideTitle", label = L["Guide title"], new = NEW,
					help = L["The guide's name in the step bar, shown when no tab names it."], search = "title, guide name, zone, header" },
			} },
		{ kind = "toggle", key = "guideWindow.skipButton", label = L["Skip"], new = NEW,
			help = L["Skip in the step bar. The guide menu still skips a step."], search = "skip, button, hide skip, skip button" },
		{ kind = "toggle", key = "guideWindow.reportButton", label = L["Report"], new = NEW,
			help = L["The bug button that reports a problem with the step. The guide menu still has it."], search = "bug, report, problem, button, report button" },
	} },
	{ page = PAGE, tab = L["Parts"], section = L["Step card"], controls = {
		textSize("titleSize", L["Name size"], L["The name of the person to talk to now, or the step's place, at the top of the card."],
			"title, step title, name, header, npc name, person"),
		textSize("goalSize", L["Goal size"], L["The goal lines of the step and of While you're here."], "goal, goals, objectives, step text, lines, text size"),
		textSize("detailSize", L["Details"], L["The lines under a goal, where the person is, the summary lines and Then:."],
			"details, secondary, subline, small text, where, then"),
		{ kind = "slider", key = "guideWindow.glyphSize", label = L["Glyphs"], min = 0.6, max = 2, step = 0.05, format = percent, new = NEW,
			help = L["The icons before the person and each goal: talk, kill, collect, the check of a goal done."],
			search = "icon, icons, glyph, glyphs, symbol, bigger, smaller, size, goal glyphs" },
		{ kind = "slider", key = "guideWindow.rowSpacing", label = L["Goal spacing"], min = 0, max = 12, step = 1, format = px, new = NEW,
			help = L["Extra room above and below each goal."],
			search = "row spacing, goal spacing, gap, room, padding, airy, dense, cramped" },
		{ kind = "slider", key = "guideWindow.lineSpacing", label = L["Line spacing"], min = 0, max = 8, step = 1, format = px, new = NEW,
			help = L["Extra room between the wrapped lines of a goal, its details and the tip."],
			search = "line spacing, line height, leading, room, airy, dense, cramped" },
		{ kind = "slider", key = "guideWindow.checkSize", label = L["Tick boxes"], min = 0.6, max = 1.8, step = 0.05, format = percent, new = NEW,
			help = L["The tick box at the right of each goal."],
			search = "tick, checkbox, check box, box, bigger, smaller, size" },
		{ kind = "slider", key = "guideWindow.targetBarWidth", label = L["Target bar"], min = 1, max = 6, step = 1, format = px, new = NEW,
			disabled = offKey("targetBar"),
			help = L["The bar at the left edge of the goal or person the arrow points to: its width."],
			search = "accent bar, marker, current goal, highlight, selection, target, bar width, thicker, thinner",
			extras = {
				{ kind = "toggle", key = "guideWindow.targetBar", label = L["Target bar"], new = NEW,
					help = L["The bar at the left edge of the goal or person the arrow points to."],
					search = "accent bar, marker, current goal, highlight, selection, target" },
				{ kind = "color", key = "guideWindow.targetBarColor", label = L["Target bar colour"], new = NEW,
					help = L["Its own colour; unset, the accent."],
					search = "accent bar colour, marker colour, highlight colour", shown = accentNow, source = accentSource },
			} },
	} },
	{ page = PAGE, tab = L["Parts"], section = L["Below the goals"], controls = {
		{ kind = "slider", key = "guideWindow.noteSize", label = L["Tip size"], min = 0.7, max = 1.8, step = 0.05, format = percent, new = NEW,
			disabled = function() return ns.Get("ui.showNotes") == false end,
			help = L["The author's tip under the goals, one line until clicked: its text size."],
			search = "tip, tips, note, notes, author" .. TEXT_SEARCH,
			extras = {
				{ kind = "toggle", key = "ui.showNotes", label = L["Step tips"], help = L["The author's tip under the goals, one line until clicked."],
					search = "tips, notes, author, hint, step tips" },
			} },
		{ kind = "slider", key = "ui.upcoming", label = L["Up next"], min = 0, max = 6, step = 1, format = "%d",
			help = L["How many steps the Up next list holds; 0 turns it off."], search = "up next, upcoming, later steps, list, preview, upcoming steps" },
		textSize("upSize", L["Up next size"], L["Up next and Along the way: their rows and their headers; the rows grow with the text."],
			"up next, upcoming, along the way, later steps, list, rows"),
		{ kind = "slider", key = "guideWindow.progressHeight", label = L["Progress bar"], min = 1, max = 12, step = 1, format = px, new = NEW,
			disabled = offKey("progress"),
			help = L["The guide's progress at the bottom of the window: its thickness. The game's looks keep their own bar."],
			search = "progress, bar, footer, completion, thickness, height, thicker, thinner, progress line, progress colour",
			extras = {
				{ kind = "toggle", key = "guideWindow.progress", label = L["Progress bar"], new = NEW,
					help = L["The guide's progress at the bottom of the window."], search = "progress, bar, percent, footer, completion" },
				{ kind = "color", key = "guideWindow.progressColor", label = L["Progress colour"], new = NEW,
					help = L["Its own colour; unset, the accent."],
					search = "progress colour, fill colour, bar colour", shown = accentNow, source = accentSource },
			},
			more = {
				{ kind = "toggle", key = "guideWindow.progressPct", label = L["Percent"], new = NEW,
					help = L["The percent beside the progress bar."], search = "percent, number, percentage" },
			} },
	} },
}

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
