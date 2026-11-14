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
-- Each tab pins the same live preview over its rows, a band: the guide
-- window itself, a copy the window's own code draws (UI.GuideFrame.Copy:
-- every part the live window has, in the look, style and settings in use),
-- fed a fixed sample step (SAMPLE) instead of the Engine, at its real size on
-- the settings window's plain ground; taller than the band's room, cut there,
-- faded into the ground and scrolled to the part the last changed setting
-- edits. A click on a part jumps to its row, and the pointer on a row lights
-- the parts it changes; the copy itself takes no click. It is built the first
-- time a tab shows, and drawn again only while shown.

local ns = Polestar
local UI, Theme, W = ns.UI, ns.Theme, ns.Widgets
local L = ns.L
local floor, max, min, ipairs = math.floor, math.max, math.min, ipairs

local PAGE = L["Guide window"]
local NEW = "0.3.8"

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

local PREVIEW_H = 250 -- the drawing's height until its band lays it out

-- The part of the window a setting edits, which the cropped preview
-- scrolls to when it changes (anything else leaves the scroll as it is): a
-- part as the window names it (GF.Placed).
local PART_OF = {}
for part, keys in pairs({
	bars = { "tabs", "tabHeight", "navHeight", "barTextSize", "stepCount", "guideTitle", "skipButton", "reportButton" },
	person = { "titleSize", "glyphSize" },
	goals = { "goalSize", "detailSize", "rowSpacing", "lineSpacing", "checkSize", "targetBar", "targetBarWidth", "targetBarColor" },
	tip = { "noteSize" },
	upnext = { "upSize" },
	foot = { "progress", "progressHeight", "progressColor", "progressPct" },
}) do
	for _, k in ipairs(keys) do PART_OF["guideWindow." .. k] = part end
end
PART_OF["ui.showNotes"], PART_OF["ui.upcoming"], PART_OF["ui.upcomingOpen"] = "tip", "upnext", "upnext"

-- The preview's content: a provider of the window's content interface
-- (UI.GuideFrame.CONTENT, what the live window asks the Engine), answering
-- with one step. Elwynn Forest (1-10), its one tab, on step 8 of 29, 11 done:
-- the work at Goldshire (a kill done, folded into "1 done"; the kill the arrow
-- points at, the current goal; a collect, its mobs and their levels under
-- it), then Marshal Dughan's turn-in, the step's other person ("Then:"); the
-- author's tip; six steps after it for Up next; the XP line (on pace, and the
-- XP tracker's rate and time to level while it is on). Its places are the
-- zone's; the numbers are a sample's.
local SAMPLE
do
	local MAP = 1429 -- Elwynn Forest
	local GUIDE = { id = "polestar:sample", title = L["Elwynn Forest"], category = "Leveling", minLevel = 1, maxLevel = 10, stepCount = 29 }
	local TABS = { { guideId = GUIDE.id, title = GUIDE.title, category = GUIDE.category, minLevel = 1, maxLevel = 10,
		stepIndex = 8, stepCount = 29, done = 11, total = 29 } }
	-- A goal as the Engine's step view gives one (UI.GoalLine draws it).
	local function goal(index, group, t, verb, subject, kind, status, extra)
		local g = { index = index, group = group, t = t, verb = verb, subject = subject, subjectKind = kind, status = status,
			text = verb and (verb .. " " .. subject) or subject, tickable = true, map = MAP }
		for k, v in pairs(extra or {}) do g[k] = v end
		return g
	end
	local work = {
		goal(1, 1, "kill", L["Kill"], L["Kobold Vermin"], "npc", "done", { progress = { cur = 10, max = 10 }, x = 41, y = 79 }),
		goal(2, 1, "kill", L["Kill"], L["Kobold Worker"], "npc", "active", { progress = { cur = 3, max = 8 }, x = 40, y = 80 }),
		goal(3, 1, "collect", L["Collect"], L["Gold Dust"], "item", "active",
			{ progress = { cur = 0, max = 10 }, npcName = L["Kobold Worker"], lvl = { 6, 7 }, x = 40, y = 80 }),
		goal(4, 2, "turnin", nil, L["Kobold Camp Cleanup"], "quest", "pending",
			{ text = string.format(L["Turn in %s"], ns.Quoted(L["Kobold Camp Cleanup"])), x = 42, y = 66 }),
	}
	local STEPS = {
		[8] = { index = 8, title = L["Goldshire"], note = L["Kobolds drop Gold Dust too: keep what you loot on the way."],
			status = "current", skipped = false, goals = work, focus = 1, current = 2,
			groups = {
				{ kind = "here", goals = { 1, 2, 3 }, done = false, map = MAP, x = 40, y = 80 },
				{ kind = "npc", name = L["Marshal Dughan"], goals = { 4 }, done = false, map = MAP, x = 42, y = 66 },
			} },
	}
	-- Up next: the steps after it, by their titles.
	for i, title in ipairs({ L["Fargodeep Mine"], L["Lion's Pride Inn"], L["Stonefield Farm"], L["Jasperlode Mine"],
		L["Eastvale Logging Camp"], L["Westfall"] }) do
		local s = 8 + i
		STEPS[s] = { index = s, title = title, status = "upcoming", skipped = false, focus = 1,
			goals = { goal(1, 1, "goto", nil, title, "place", "pending") }, groups = { { kind = "here", goals = { 1 }, done = false } } }
	end
	local PACE = { target = 6, step = 12, reach = 6.2, short = 0, kind = "goal", live = 8 }
	local XP = { level = 5, xp = 1200, xpMax = 2800, remaining = 1600, rate = 3400, timeToLevel = 1700, maxed = false }
	local TARGET = { map = MAP, x = 40, y = 80 }
	SAMPLE = {
		GetGuide = function() return GUIDE end,
		GetTabs = function() return TABS, 1 end,
		GetStepIndex = function() return 8 end,
		GetLiveStep = function() return 8 end,
		GetStepCount = function() return 29 end,
		GetStepView = function(i) return STEPS[i] end,
		StepNumber = function(i) return i, false end,
		StepTotal = function() return 29 end,
		GetProgress = function() return 11, 29 end,
		GetAlong = function() return {} end,
		GetWhileHereList = function() return {} end,
		StepHint = function() return nil end,
		Pace = function() return PACE end,
		-- The XP tracker's numbers while it is on, as the live window gets them.
		XPStats = function()
			local Q = ns.QoL
			return Q and Q.On and Q.On("xpTracker") and XP or nil
		end,
		RestParts = function() return nil end,
		Target = function() return TARGET end,
	}
end

-- The guide window as a part of a band: a copy of it, drawn by the window's
-- own code (UI.GuideFrame.Copy) into a frame on `band` (its parts click and
-- light through that band) and fed SAMPLE, at the top of its box.
-- c:Layout(width, height) draws it and places it for that box; c:Draw() draws
-- it alone (its natural size, c.Window's), c:Resize(width, height) places it
-- as drawn: cropped at its foot when taller and faded over CUT_FADE px into
-- the band's ground, never scrolled (the Guide window page's own preview
-- scrolls it: psNoScroll off). c.psRowsFoot: the foot of its goals (and the
-- lines among them), in window units, once placed. -> c (c.Copy: the copy,
-- with its parts, rows, lines and tabs as the live window's; c.Window: its
-- frame)
local CUT_FADE = 28
function UI.GuideWindowScene(band)
	local c = CreateFrame("Frame", nil, band)
	if c.SetClipsChildren then c:SetClipsChildren(true) end
	c.psHeight, c.psTopAligned, c.psNoHot, c.psNoScroll = PREVIEW_H, true, true, true
	-- The crop's fade, over the window, into the band's ground.
	local over = CreateFrame("Frame", nil, c)
	over:SetAllPoints(c)
	over:SetFrameLevel(c:GetFrameLevel() + 30)
	c.Fade = over:CreateTexture(nil, "OVERLAY")
	c.Fade:SetTexture(Theme.Media("white"))
	c.Fade:SetPoint("BOTTOMLEFT", c, "BOTTOMLEFT", 0, 0)
	c.Fade:SetPoint("BOTTOMRIGHT", c, "BOTTOMRIGHT", 0, 0)
	c.Fade:SetHeight(CUT_FADE)
	c.Fade:Hide()
	W.Painter(c.Fade, function(t)
		local r, g, b = Theme.Color("bg")
		if t.SetGradient and CreateColor then
			t:SetGradient("VERTICAL", CreateColor(r, g, b, 1), CreateColor(r, g, b, 0))
		else
			t:SetVertexColor(r, g, b, 0.6)
		end
	end)
	local G = UI.GuideFrame.Copy(c, SAMPLE)
	c.Copy, c.Window = G, G.frame

	-- Every setting applied to the copy anew and its sample drawn; the parts
	-- it made since take their hotspots and lights.
	function c:Draw()
		G.Draw()
		self.psDrawn = true
		self:Hotspots()
	end

	-- The window at its true size (its Scale on the game's UI scale; smaller
	-- only when the box is too narrow for its width), in the middle of its box
	-- when it fits; taller, cropped at the box's foot and scrolled to the part
	-- the last setting changed edits. A part the crop would cut through is left
	-- out: no text cut in two at the box's foot (or its top, scrolled), the
	-- window's ground running on under the fade.
	function c:Resize(width, height)
		self:SetSize(width, height or PREVIEW_H)
		self.psW, self.psHeight = width, height or PREVIEW_H
		if not self.psDrawn then return end
		local F = G.frame
		local w, y = F:GetWidth(), F:GetHeight()
		local s = (tonumber(ns.Get("ui.scale")) or 1) * band:TrueScale()
		local k = s * min(1, (width - 32) / (w * s))
		local room = (self.psHeight - 8) / k
		local placed = G.Placed()
		local at, rowsFoot = {}, 0
		for _, p in ipairs(placed) do
			at[p[1]] = at[p[1]] or p[3]
			if p[1] == "person" or p[1] == "goals" then rowsFoot = max(rowsFoot, p[4]) end
		end
		self.psRowsFoot = rowsFoot
		local scroll, drop = 0, 0
		if y > room then
			local part = rawget(self, "psNoScroll") and 0 or at[self.psFocus or "bars"]
			scroll = max(0, min(y - room, part and part - 12 or self.psScroll or 0))
		else
			drop = rawget(self, "psTopAligned") and 0 or (room - y) / 2
		end
		local snap = ns.UI.Preview.Snap
		F:SetScale(k)
		F:ClearAllPoints()
		F:SetPoint("TOPLEFT", self, "TOPLEFT", snap(F, (width / k - w) / 2), snap(F, scroll - drop))
		self.psScale, self.psScroll = k, scroll
		local seen = scroll + self.psHeight / k
		for _, p in ipairs(placed) do
			if p[2] then p[2]:SetAlpha((p[3] >= scroll - 0.5 and p[4] <= seen + 0.5) and 1 or 0) end
		end
		-- A window running past its box's foot fades out there.
		self.Fade:SetShown(y - scroll > room + 0.5)
	end

	-- -> the box's height (PREVIEW_H laid out alone), the window centred
	-- across `width`.
	function c:Layout(width, height)
		self:Draw()
		self:Resize(width, height)
		return self.psHeight
	end

	-- Clicks on the window's parts jump to their rows, and the pointer on a
	-- setting's row lights the parts it changes (in another page's scene that
	-- page sets its own: psNoHot): each part's the first time it is drawn.
	local spotted, lit = setmetatable({}, { __mode = "k" }), {}
	local function hot(region, key)
		if region and not spotted[region] then
			spotted[region] = true
			band:Hot(region, key)
		end
	end
	local function light(key, regions)
		local done = lit[key]
		if not done then
			done = setmetatable({}, { __mode = "k" })
			lit[key] = done
		end
		for _, r in ipairs(regions) do
			if not done[r] then
				done[r] = true
				band:Light(key, r)
			end
		end
	end
	function c:Hotspots()
		if rawget(self, "psNoHot") then return end
		local P, F = G.parts, G.frame
		local nav, person, foot, up = P.nav, P.person, P.foot, P.upnext
		hot(P.strip, "guideWindow.tabHeight")
		hot(nav, "guideWindow.navHeight")
		hot(person, "guideWindow.titleSize")
		for _, r in ipairs(G.rows) do hot(r, "guideWindow.goalSize") end
		for _, l in ipairs(G.lines) do hot(l, "guideWindow.detailSize") end
		hot(P.tip, "guideWindow.noteSize")
		hot(up, "guideWindow.upSize")
		hot(foot, "guideWindow.progressHeight")
		local rows, texts, subs, icons, checks, marks = {}, {}, { person.Where }, { person.Icon }, {}, {}
		for i, r in ipairs(G.rows) do
			rows[i], texts[i], checks[i], marks[i] = r, r.Text, r.Check, r.Mark
			subs[#subs + 1], icons[#icons + 1] = r.Sub, r.Icon
		end
		local lineTexts = {}
		for i, l in ipairs(G.lines) do lineTexts[i] = l.Text end
		local bars = { nav.Steps.Count, nav.Title, nav.Skip.Label, foot.Pct }
		for _, b in ipairs(G.tabs) do
			bars[#bars + 1] = b.Label
			bars[#bars + 1] = b.Range
		end
		local window, moving = { F }, { person }
		for _, r in ipairs(rows) do moving[#moving + 1] = r end
		local details = { P.after.Text }
		for _, s in ipairs(subs) do details[#details + 1] = s end
		for _, t in ipairs(lineTexts) do details[#details + 1] = t end
		local spacing = { P.tip.Text }
		for _, t in ipairs(texts) do spacing[#spacing + 1] = t end
		for _, s in ipairs(subs) do spacing[#spacing + 1] = s end
		for key, parts in pairs({
			["ui.style"] = window, ["ui.backing"] = window, ["guideWindow.veil"] = window, ["guideWindow.shade"] = window,
			["guideWindow.outline"] = window, ["ui.barShown"] = { P.strip, nav }, ["ui.scale"] = window, ["ui.guideTextSize"] = window, ["ui.width"] = window,
			["ui.maxHeight"] = window, ["guideWindow.padding"] = rows, ["ui.compact"] = window, ["guideWindow.bgOpacity"] = window,
			["guideWindow.bgColor"] = window, ["ui.opacity"] = window, ["guideWindow.idleAlpha"] = window, ["guideWindow.border"] = window,
			["guideWindow.rules"] = { P.strip.Rule, nav.Rule, up.Toggle.Rule, G.xp.Rule }, ["ui.combat"] = window,
			["guideWindow.combatAlpha"] = window, ["ui.instance"] = window, ["guideWindow.hideTaxi"] = window, ["ui.growUp"] = window,
			["ui.barsBottom"] = { P.strip, nav }, ["guideWindow.stepAnim"] = moving, ["guideWindow.animSpeed"] = moving,
			-- A goal done shuts into the done line.
			["guideWindow.foldAnim"] = { G.lines[1] or person },
			["guideWindow.tabs"] = { P.strip }, ["guideWindow.tabHeight"] = { P.strip }, ["guideWindow.navHeight"] = { nav },
			["guideWindow.barTextSize"] = bars, ["guideWindow.stepCount"] = { nav.Steps }, ["guideWindow.guideTitle"] = { nav.Title },
			["guideWindow.skipButton"] = { nav.Skip }, ["guideWindow.reportButton"] = { nav.Report },
			["guideWindow.titleSize"] = { person.Name }, ["guideWindow.goalSize"] = texts, ["guideWindow.detailSize"] = details,
			["guideWindow.glyphSize"] = icons, ["guideWindow.rowSpacing"] = rows, ["guideWindow.lineSpacing"] = spacing,
			["guideWindow.checkSize"] = checks, ["guideWindow.targetBar"] = marks, ["guideWindow.targetBarWidth"] = marks,
			["guideWindow.targetBarColor"] = marks, ["guideWindow.noteSize"] = { P.tip }, ["ui.showNotes"] = { P.tip },
			["ui.upcoming"] = { up }, ["guideWindow.upSize"] = { up }, ["guideWindow.progress"] = { foot },
			["guideWindow.progressHeight"] = { foot }, ["guideWindow.progressColor"] = { foot.Line }, ["guideWindow.progressPct"] = { foot.Pct },
		}) do
			light(key, parts)
		end
	end

	-- A tab opening starts at the bars, the top of the window.
	c:SetScript("OnShow", function(self)
		local moved = self.psFocus ~= nil and self.psFocus ~= "bars"
		self.psFocus = "bars"
		if self.psDirty and self.psW then
			self.psDirty = nil
			self:Layout(self.psW, self.psHeight)
		elseif moved then
			self:Resize(self.psW, self.psHeight)
		end
	end)

	-- The settings window, on hovering a row: the crop scrolls to the part
	-- that setting edits (a setting of the window as a whole leaves it).
	function c:Focus(key)
		local part = key and PART_OF[key]
		if not part or part == self.psFocus then return end
		self.psFocus = part
		if self:IsVisible() then self:Resize(self.psW, self.psHeight) else self.psDirty = true end
	end
	-- A setting changed: its band draws the window again (opts.watch); the crop
	-- then scrolls to the part the setting edits.
	ns.On("SETTING_CHANGED", function(path)
		local part = PART_OF[path]
		if not part or part == c.psFocus then return end
		c.psFocus = part
		if c:IsVisible() and c.psW then c:Resize(c.psW, c.psHeight) end
	end)
	-- Drawn once as it is made: its rows, lines and tabs are there for the
	-- parts a page lights (Theme's scene).
	c:Draw()
	return c
end

-- The page's preview, a band (UI.Preview.Band): the window alone at its real
-- size, centred; taller than the band's room, cut there and faded into the
-- band's ground, scrolled to the part the last setting changed or the
-- hovered row edits (f:Focus). The window's own room a side; the band keeps
-- its pads and its hint line out of the element's room.
local SIDE = 16
local function buildPreview(view)
	local P = ns.UI.Preview
	local f = P.Band(view, { watch = { "ui.", "guideWindow.", "nav.nearbyButton", "qol.xpTracker" } })
	local G = UI.GuideWindowScene(f)
	-- Its own page: the window's parts click and light, the crop scrolls.
	G.psNoHot, G.psNoScroll = nil, nil
	f.Scene, f.Guide = G, G.Window
	function f:Focus(key) G:Focus(key) end
	function f:Content()
		local s = (tonumber(ns.Get("ui.scale")) or 1) * self:TrueScale()
		-- Drawn first: its natural size at its own scale.
		G:Draw()
		local winW, winH = G.Window:GetWidth() * s, G.Window:GetHeight() * s
		local room = self.psRoom and max(60, self.psRoom - 2 * P.BAND_PAD - P.LINE_GAP - P.LINE_H) or winH + 8
		-- Whole: its height and the 8 its crop keeps under it; else the room, cut.
		local h = min(winH + 8, room)
		return winW, h, function(left, top, k)
			G:ClearAllPoints()
			G:SetPoint("TOPLEFT", self, "TOPLEFT", P.Snap(self, left - SIDE), -P.Snap(self, top))
			G:Resize(winW * k + 2 * SIDE, h * k)
		end
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
		{ kind = "slider", key = "ui.guideTextSize", label = L["Text size"], min = 0.8, max = 1.4, step = 0.05, format = percent, new = NEW,
			help = L["The size of the guide window's text, apart from its scale and the rest of Polestar's text (Theme > Text). Changes at once. Right-click to reset."],
			search = "text size, font size, bigger text, smaller text, readability, larger, huge, tiny, guide text" },
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
			help = L["What the window, its buttons and alerts do in dungeons, raids, battlegrounds and arenas. Guide window in the minimap button's menu, the key binding or /polestar opens it there until you leave."],
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

---------------------------------------------------------------------------
-- Essentials (the page's lead tab): four looks as picture cards, then the
-- ten settings players change most, each a reference to its row on Window
-- or Parts.
---------------------------------------------------------------------------

local O = UI.Options
if O and O.PresetCards and O.Ref then
	local R = O.Ref
	-- A string of the miniature at its role's size times its group's setting
	-- (and the transparent style's outline), not following the theme's text
	-- size changes: the card is drawn once, with the preset's values.
	local function sized(fs, role, k, outline)
		local path, size, flags = Theme.FontSpec(role)
		if outline then flags = GF().Outline() == "thick" and "THICKOUTLINE" or "OUTLINE" end
		fs:SetFont(path, (size or 13) * (k or 1), flags or "")
	end
	-- A preset's card: the guide window in miniature with the preset's values
	-- (its width, style, padding, the person's name, three goals with their
	-- tick boxes and spacing, the progress bar), from the window's own metrics
	-- (GF.Metrics, read again after for the live window), scaled to the card.
	local function drawWindowCard(art, _, values)
		local cw, ch = art:GetWidth(), art:GetHeight()
		if not (cw and cw > 0) then cw = W.CARD_W - 2 end
		if not (ch and ch > 0) then ch = W.CARD_ART end
		local m = art.psMini
		if not m then
			local sky = Theme.Band(art, "BACKGROUND", -6)
			sky:SetAllPoints(art)
			m = CreateFrame("Frame", nil, art)
			m.Ground = CreateFrame("Frame", nil, m)
			m.Ground:SetAllPoints(m)
			-- The guide window's paint, not a big window's (title bar, drag
			-- strip and metal over the card, #1802).
			m.Ground.psGuide = true
			Theme.Skin(m.Ground, "window")
			-- The text, ticks and bar over the window's ground (a child frame
			-- draws over its parent's own regions).
			local top = CreateFrame("Frame", nil, m)
			top:SetAllPoints(m)
			top:SetFrameLevel(m.Ground:GetFrameLevel() + 2)
			m.Name = top:CreateFontString(nil, "OVERLAY")
			m.Goals, m.Ticks = {}, {}
			for i = 1, 3 do
				m.Goals[i] = top:CreateFontString(nil, "OVERLAY")
				m.Ticks[i] = W.Tex(top, "ARTWORK", i == 1 and "check" or "circle", i == 1 and "success" or "textMuted")
			end
			m.Bar = W.Tex(top, "ARTWORK", nil, "accent")
			art.psMini = m
		end
		local G = GF()
		O.WithSettings(values, function()
			local mt = G and G.Metrics and G.Metrics() or { pad = 14, check = 18, rowMin = 24 }
			local width = tonumber(ns.Get("ui.width")) or 340
			local clear = ns.Get("ui.style") == "transparent"
			local pad = mt.pad or 14
			local gap = tonumber(ns.Get("guideWindow.rowSpacing")) or 0
			m.Ground:SetShown(not clear)
			local y = pad
			sized(m.Name, "title", G and G.Num("titleSize") or 1, clear)
			W.Color(m.Name, "text")
			m.Name:SetText(L["Marshal Dughan"])
			m.Name:ClearAllPoints()
			m.Name:SetPoint("TOPLEFT", m, "TOPLEFT", pad, -y)
			y = y + (m.Name:GetStringHeight() or 16) + 8
			local goalK = G and G.Num("goalSize") or 1
			local check = (mt.check or 18) * (G and G.Num("checkSize") or 1)
			local lines = { L["Kill"] .. " " .. L["Kobold Vermin"], L["Kill"] .. " " .. L["Kobold Worker"], L["Collect"] .. " " .. L["Gold Dust"] }
			for i, fs in ipairs(m.Goals) do
				sized(fs, "goal", goalK, clear)
				W.Color(fs, i == 1 and "textMuted" or "text")
				fs:SetText(lines[i])
				local tick = m.Ticks[i]
				tick:SetSize(check * 0.7, check * 0.7)
				tick:ClearAllPoints()
				tick:SetPoint("TOPLEFT", m, "TOPLEFT", pad, -(y + 1))
				fs:ClearAllPoints()
				fs:SetPoint("TOPLEFT", m, "TOPLEFT", pad + check + 4, -y)
				y = y + max(check, fs:GetStringHeight() or 14) + 4 + gap
			end
			local bar = G and G.On("progress") and (tonumber(ns.Get("guideWindow.progressHeight")) or 3) or 0
			m.Bar:SetShown(bar > 0)
			y = y + 4
			m.Bar:ClearAllPoints()
			m.Bar:SetPoint("TOPLEFT", m, "TOPLEFT", 1, -y)
			m.Bar:SetSize(max(1, (width - 2) * 0.62), max(1, bar))
			local height = y + bar + (clear and 0 or 2)
			m:SetSize(width, height)
			local k = min((cw - 16) / width, (ch - 12) / height)
			m:SetScale(max(0.05, k))
			m:ClearAllPoints()
			m:SetPoint("CENTER", art, "CENTER", 0, 0)
		end)
		if G and G.Metrics then G.Metrics() end
	end
	local LARGE = 1.2
	local PRESETS = {
		{ value = "standard", label = L["Standard"], set = {}, draw = drawWindowCard },
		{ value = "compact", label = L["Compact"], draw = drawWindowCard,
			help = L["Only the header and the step's goals, narrower and closer together."],
			set = { ["ui.compact"] = true, ["ui.width"] = 300, ["guideWindow.padding"] = 8, ["guideWindow.rowSpacing"] = 2 } },
		{ value = "transparent", label = L["Transparent"], draw = drawWindowCard,
			help = L["No background or border: outlined text over the world, a soft shade behind each line."],
			set = { ["ui.style"] = "transparent", ["ui.backing"] = "soft" } },
		{ value = "large", label = L["Large text"], draw = drawWindowCard,
			help = L["Every text of the window bigger, the window wider to hold it."],
			set = { ["guideWindow.titleSize"] = 1.25, ["guideWindow.goalSize"] = 1.25, ["guideWindow.detailSize"] = LARGE, ["guideWindow.noteSize"] = LARGE,
				["guideWindow.upSize"] = LARGE, ["guideWindow.glyphSize"] = LARGE, ["guideWindow.checkSize"] = LARGE, ["guideWindow.barTextSize"] = 1.15,
				["ui.width"] = 400 } },
	}
	local ESSENTIALS = L["Essentials"]
	local list = {
		{ page = PAGE, tab = ESSENTIALS, lead = true, section = L["Presets"], preview = buildPreview,
			controls = { O.PresetCards({ presets = PRESETS }) } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Window"], jump = { tab = L["Window"], section = L["Window"] },
			controls = { R("slider", "ui.scale"), R("slider", "ui.width"), R("slider", "guideWindow.bgOpacity"), R("slider", "guideWindow.idleAlpha"),
				R("dropdown", "ui.combat"), R("dropdown", "ui.instance") } },
		{ page = PAGE, tab = ESSENTIALS, section = L["Step"], jump = { tab = L["Parts"], section = L["Step card"] },
			controls = { R("slider", "guideWindow.goalSize"), R("slider", "ui.upcoming"), R("toggle", "ui.showNotes", { label = L["Step tips"] }),
				R("toggle", "guideWindow.progress", { label = L["Progress bar"] }) } },
	}
	for _, spec in ipairs(list) do SPECS[#SPECS + 1] = spec end
end

for _, spec in ipairs(SPECS) do
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end
