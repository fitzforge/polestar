-- Atlas: a layout for Polestar's guide window (Skin API 2, Theme.RegisterLayout).
-- The step is a node on a timeline: its title and area, its goals with their
-- action icons and quests, the tip under them; Up next is a rail that fades
-- ahead. Nothing else sits in the window: banner notices, While you're here,
-- Along the way, Optional, Training due and the party line are cards stacked
-- above it, the class quest is a heads-up above them, and the Journey is a
-- card joined below. Compact mode is the same window with the current step
-- alone: the rail's one node, its goals, the tip, the cards above, the XP row
-- and the Journey; no steps before, no Up next.
--
-- A layout is structure only: it has no tokens and no colours. Every colour
-- here is a token of the skin in use (Theme.Color, Theme.Accent), so any skin
-- colours it; the Atlas skin (Polestar_Skins/Skins/Atlas) is the look's own.
--
-- Hooks use only the parts they are handed (the settings' preview calls them
-- on a copy of the window). Every hook is offered only where this Polestar
-- has it (capability "surfaces.<hook>"), so on an older one the part it would
-- change stays Polestar's own.

local ADDON = "Polestar" -- Polestar's own layout: Polestar_Skins/Layouts/Atlas/ (#3507)
local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterLayout and (Theme.API_VERSION or 0) >= 2) then return end

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

-- Whether this Polestar hands hook `name` to a layout.
local function has(name)
	return Theme.HasCapability ~= nil and Theme.HasCapability("surfaces." .. name) == true
end

---------------------------------------------------------------------------
-- Core reads. Everything Atlas needs from Polestar that the Skin API does not
-- hand over yet, each behind one function here and nowhere else. Each answers
-- nil (or does nothing) when the internal it reads is missing, and the part
-- it feeds then stays Polestar's own. Each is a read the Skin API should
-- offer; the names say which.
---------------------------------------------------------------------------

local P = Polestar
local Core = {}
local function ui() return P.UI end
local function frame() local u = P.UI; return u and u.GuideFrame end

-- Settings: a value by path (Polestar.Get).
function Core.setting(path) return P.Get and P.Get(path) end
-- A guide-window toggle (guideWindow.<key>, on unless set false) and a
-- size scale (guideWindow.<key>, 1 when unset).
function Core.on(key) return Core.setting("guideWindow." .. key) ~= false end
function Core.scale(key) return tonumber(Core.setting("guideWindow." .. key)) or 1 end
function Core.compact() return Core.setting("ui.compact") and true or false end
-- A gap of the step card the player sizes (guideWindow.<key>, its whole size
-- in px; Atlas's own in spec.defaults), else px.
function Core.gap(key, px)
	local v = tonumber(Core.setting("guideWindow." .. key))
	if v and v >= 0 then return math.floor(v + 0.5) end
	return px
end
-- Polestar's own strings (its locale table), English when it has none.
function Core.tr(s) local L = P.L; return (L and L[s]) or s end
-- Capitals as the client's language writes them (Polestar.Upper): Lua's
-- upper() knows ASCII alone, so "Fällig" would read "FäLLIG".
function Core.upper(s) return (P.Upper and P.Upper(s)) or string.upper(s or "") end

-- Goal and quest words (UI.GoalText and its kin).
function Core.goalText(goal)
	local u = ui()
	return (u and u.GoalText and u.GoalText(goal)) or goal.text or ""
end
function Core.plainGoalText(goal)
	local u = ui()
	return (u and u.PlainGoalText and u.PlainGoalText(goal)) or goal.text or ""
end
function Core.goalProgress(goal)
	local u = ui()
	if u and u.GoalProgress then return u.GoalProgress(goal) end
	local p = goal.progress
	return p and p.max and (p.cur or 0) .. "/" .. p.max or nil
end
function Core.questTitle(quest) local u = ui(); return u and u.QuestTitle and u.QuestTitle(quest) or nil end
function Core.mapName(map) local u = ui(); return u and u.MapName and u.MapName(map) or nil end
function Core.stepSummary(view) local u = ui(); return u and u.StepSummary and u.StepSummary(view) or nil end
-- An area objective's spots line (UI.AreaLine: "Rockjaw Troggs all over
-- this area: 12 spots"), the line Polestar puts under such a goal.
function Core.areaLine(goal) local u = ui(); return u and u.AreaLine and u.AreaLine(goal) or nil end
function Core.distanceText(yards) return P.FormatDistance and P.FormatDistance(yards, { round = 5 }) or nil end

-- The arrow: what it points at, how far, and pointing it at a goal.
function Core.target() local N = P.Nav; return N and N.GetTarget and N.GetTarget() or nil end
function Core.distance() local N = P.Nav; return N and N.GetDistance and N.GetDistance() or nil end
function Core.yardsTo(goal)
	local C = P.Compat
	if not (C and C.MapToWorld and C.GetPlayerWorldPosition and goal.map and goal.x and goal.y) then return nil end
	local gc, gx, gy = C.MapToWorld(goal.map, goal.x, goal.y, goal.f)
	local pc, px, py = C.GetPlayerWorldPosition()
	if gc and gc == pc and px and py then return math.sqrt((gx - px) ^ 2 + (gy - py) ^ 2) end
end
-- -> the arrow's target once it points at the goal, or nil.
function Core.aim(goal)
	local G = frame()
	if not G then return nil end
	if G.AimGoal and G.AimGoal(goal) then return nil end
	if G.PointAt and goal.map and goal.x and goal.y then
		G.PointAt(goal, goal.text)
		return Core.target()
	end
end
function Core.canSkip() local E = P.Engine; return E ~= nil and E.SkipGoal ~= nil end
function Core.skipGoal(step, index) local E = P.Engine; if E and E.SkipGoal and step then E.SkipGoal(step, index) end end
-- The window laid out again (a card of Atlas's own changed its content).
function Core.relayout() local G = frame(); if G and G.Layout then G.Layout() end end

-- Banner and class notice read: the notice the window's banner carries
-- (-> kind, its record), taking it up and putting it off; the heads-up card
-- above the window that carries the class quest.
function Core.notice() local G = frame(); if G and G.BannerNotice then return G.BannerNotice() end end
function Core.takeNotice() local G = frame(); if G and G.TakeBanner then G.TakeBanner() end end
function Core.laterNotice() local G = frame(); if G and G.LaterBanner then G.LaterBanner() end end
function Core.showHeadsUp(card)
	local u = ui()
	local CT = u and u.ClassToast
	return CT and CT.ShowCard and CT.ShowCard(card) or false
end
function Core.hideHeadsUp() local u = ui(); local CT = u and u.ClassToast; if CT and CT.Hide then CT.Hide() end end
-- The class quest card's chain on screen (its key), for its ×.
function Core.classCardKey()
	local u = ui()
	local CC = u and u.ClassCard
	return CC and CC.shown and CC.shown.key or nil
end

-- Training-due read: where to train (Engine.TrainingAdvice):
-- -> { trainer = { npcName, map }, title, guide } or an empty table.
function Core.training()
	local E = P.Engine
	return E and E.TrainingAdvice and E.TrainingAdvice() or {}
end

-- Along the way read: the open goals the window lists under the step
-- (Engine.GetAlong), each by its row's step and goal (-> goal view or nil).
function Core.alongGoals()
	local E, out = P.Engine, {}
	for _, s in ipairs(E and E.GetAlong and E.GetAlong() or {}) do
		for _, g in ipairs(s.goals or {}) do
			if g.step and g.index then out[g.step .. ":" .. g.index] = g end
		end
	end
	return out
end

-- XP-to-next read: Polestar's own line on the XP row ("about 9 min to 5").
function Core.xpLine(xp) return xp and xp.psLine or nil end

-- Tip pager read: the step's tips, one per page (a list of strings), and
-- whether the tip is opened; nil while this Polestar keeps one tip.
function Core.tipPages(tip)
	local list = tip and tip.psTips
	return type(list) == "table" and #list > 1 and list or nil
end
function Core.tipOpen(tip)
	local G = frame()
	if G and G.TipOpen then return G.TipOpen() and true or false end
	return tip and tip.psOpen and true or false
end

---------------------------------------------------------------------------
-- Atlas's own pieces on a frame: one table per frame, hidden all at once
-- when the layout leaves (onLeave). A key starting with "_" holds what is
-- not Atlas's own (Polestar's frames, a part's look before Atlas changed it)
-- and is never hidden.
---------------------------------------------------------------------------

local stores = setmetatable({}, { __mode = "k" })
local function store(f)
	local s = stores[f]
	if not s then
		s = {}
		stores[f] = s
	end
	return s
end

local function hideAll(t, seen)
	seen = seen or {}
	if seen[t] then return end
	seen[t] = true
	for k, v in pairs(t) do
		if type(v) == "table" and not (type(k) == "string" and k:sub(1, 1) == "_") then
			if type(v.Hide) == "function" then v:Hide() else hideAll(v, seen) end
		end
	end
end

-- The guide window `f` sits in (a frame marked psGuideWindow), or nil.
local function windowOf(f)
	local p = f
	for _ = 1, 16 do
		if not p then return nil end
		if type(p) == "table" and rawget(p, "psGuideWindow") then return p end
		p = p.GetParent and p:GetParent() or nil
	end
	return nil
end

-- Whether the layout leaving the window of `parts` takes back what it did
-- to `f`: `f` sits in that window, or in none and the window is the live one.
function Core.leaves(f, parts, live)
	local w = windowOf(f)
	if w then return parts ~= nil and w == parts.window end
	return live == true
end

-- Whether `f` sits in `window` (a part of the window a hook handed over).
local function isUnder(f, window)
	local p = f
	for _ = 1, 12 do
		if not p then return false end
		if p == window then return true end
		p = p.GetParent and p:GetParent() or nil
	end
	return false
end

---------------------------------------------------------------------------
-- Hooks: each part of the look adds its handlers; registration joins them
-- (guidePlace and the other questions take the first answer, guideShows
-- passes the answer along, guideLayout adds up the room asked).
---------------------------------------------------------------------------

local chains, order = {}, {}
local function on(name, fn)
	local c = chains[name]
	if not c then
		c = {}
		chains[name] = c
		order[#order + 1] = name
	end
	c[#c + 1] = fn
end

local leaving = {}
local function onLeave(fn) leaving[#leaving + 1] = fn end

local tr, compact = Core.tr, Core.compact

-- A role's face, size and flags, read off a probe of Atlas's own.
local probeFs
local function probe(role)
	if not probeFs then
		probeFs = UIParent:CreateFontString(nil, "OVERLAY")
		probeFs:Hide()
	end
	Theme.Font(probeFs, role)
	local path, size, flags = probeFs:GetFont()
	return path, size or 12, flags
end

-- The semibold face: the "number" role's.
local function semibold() return (probe("number")) end

-- Atlas's small caps labels, over its cards.
local function capsLabel(fs)
	Theme.Font(fs, "small")
	local path, size, flags = fs:GetFont()
	local bold = semibold()
	if (bold or path) and size then fs:SetFont(bold or path, size, flags) end
	fs:SetTextColor(Theme.Color("textMuted"))
end

-- The cards' rows: in the face and size of While you're here's (the window's
-- goal rows', as the player sizes them), seen at its last layout; the icon on
-- the label's left edge, in the accent.
local hereFont
local function rowFont(fs)
	if hereFont and hereFont[1] then fs:SetFont(hereFont[1], hereFont[2], hereFont[3]) else Theme.Font(fs, "goal") end
end

local function pixel(f) return Theme.Pixel and Theme.Pixel(f) or 1 end

---------------------------------------------------------------------------
-- The header: no backdrop and no rule; the guide's emblem and title on the
-- left, then the step count with its arrows, Skip as its glyph alone, and
-- the menu on the right. The player's own switches (guideWindow.skipButton,
-- .reportButton, .rules, nav.nearbyButton) say what shows; Atlas only sets
-- it out. Lookup is in the menu.
---------------------------------------------------------------------------

on("guideTitle", function(nav, parts)
	if parts.band then parts.band:Hide() end
	if parts.bar then parts.bar:Hide() end
end)

local function stepsMode(nav, own, mode)
	local count = nav.Steps.Count
	if not own.countPts then own.countPts = { count:GetPoint(1) } end
	local arrows = mode == 0
	nav.Prev:SetShown(arrows)
	nav.Next:SetShown(arrows)
	count:ClearAllPoints()
	if arrows then
		count:SetPoint(unpack(own.countPts))
	else
		count:SetPoint("LEFT", nav.Steps, "LEFT", 0, 0)
	end
	local full = own.countFull
	if full then count:SetText(mode >= 2 and (full:match("^%s*(%S+)") or full) or full) end
end

local function navBack(nav)
	local own = nav and stores[nav]
	if not (own and own.atlas) then return end
	own.atlas = nil
	if own.emblem then own.emblem:Hide() end
	nav.psFitTitle = nil
	stepsMode(nav, own, 0)
	own.titleHid = nil
	Theme.Font(nav.Steps.Count, "number")
	nav.Steps:ClearAllPoints()
	nav.Steps:SetPoint("LEFT", nav, "LEFT", 8, 0)
	-- Polestar's own order right of the count: Skip, Nearby, Report, Lookup.
	nav.Report:ClearAllPoints()
	nav.Report:SetPoint("RIGHT", nav.Lookup, "LEFT", 0, 0)
	nav.Nearby:ClearAllPoints()
	nav.Nearby:SetPoint("RIGHT", nav.Report, "LEFT", 0, 0)
	nav.Skip:ClearAllPoints()
	nav.Skip:SetPoint("RIGHT", (nav.Nearby:IsShown() and nav.Nearby) or (nav.Report:IsShown() and nav.Report) or nav.Menu, "LEFT", -2, 0)
	if nav.Skip.Label then
		nav.Skip.Label:Show()
		nav.Skip:SetWidth(math.floor(7 + 11 + 5 + nav.Skip.Label:GetStringWidth() + 8 + 0.5))
	end
	nav.Lookup:Show()
	Theme.Font(nav.Title, "small")
end
onLeave(function(parts) navBack(parts.nav) end)
-- Where the Journey's card joins the window's foot (layoutBottom). A
-- texture's alpha is its vertex colour's (the window border at 10 %, the
-- house look's shade), so a line hidden here gets the alpha it had back, not
-- 1: a solid line along the window's foot otherwise.
local seamWas = setmetatable({}, { __mode = "k" }) -- line -> its alpha before Atlas hid it
local function seam(window, b, joined)
	local function edge(f, set, i) local e = rawget(f, set); return e and e[i] end
	local function skinEdge(f, i)
		local sk = rawget(f, "psSkin")
		return type(sk) == "table" and type(sk.edge) == "table" and sk.edge[i] or nil
	end
	for _, t in pairs({ edge(window, "psBorder", 2), skinEdge(window, 3) }) do
		if joined then
			local _, _, _, a = t:GetVertexColor()
			if type(a) == "number" and a > 0 then seamWas[t] = a end
			t:SetAlpha(0)
		elseif seamWas[t] then
			t:SetAlpha(seamWas[t])
			seamWas[t] = nil
		end
	end
	if b then
		for _, t in pairs({ edge(b, "psBorder", 1), skinEdge(b, 1), skinEdge(b, 2) }) do t:SetAlpha(0) end
	end
end

onLeave(function(parts)
	if not parts.window then return end
	parts.window.psBelow = nil
	seam(parts.window, nil, false)
end)

-- Right to left from the menu: Report and Nearby where the player shows
-- them, Skip (its glyph alone), then the step count.
local SKIP_W = 7 + 11 + 7
-- The room the row has, shrinking in this order: the title is cut short
-- ("...") down to TITLE_MIN, then the step count loses its arrows, then it
-- shows the number alone, and only then does the title go.
local TITLE_MIN = 80
local function fitRow(nav, own, prev)
	local title, steps, count = nav.Title, nav.Steps, nav.Steps.Count
	local text = count:GetText()
	if type(text) == "string" and text:find("/", 1, true) then own.countFull = text end
	local full = own.countFull
	local navW = nav:GetWidth() or 0
	if not steps:IsShown() or navW <= 0 then return end
	local _, _, _, menuX = nav.Menu:GetPoint(1)
	local right = -(tonumber(menuX) or -8) + 2
	for _, b in ipairs({ nav.Menu, nav.Report, nav.Nearby, nav.AllSteps, nav.Skip }) do
		if b:IsShown() then right = right + b:GetWidth() end
	end
	local room = navW - (10 + 16 + 8) - right - 8
	local base = math.floor(40 * Core.scale("stepNumberSize") + 0.5)
	local function width(t)
		count:SetText(t)
		return math.max(base, math.ceil(count:GetUnboundedStringWidth()) + 1)
	end
	local keep = text
	local fullW = width(full or keep or "")
	local shortW = full and width(full:match("^%s*(%S+)") or full) or fullW
	count:SetText(keep)
	local mode = 3
	if full then
		local need = { fullW + 48, fullW, shortW }
		for m = 0, 2 do
			if room - need[m + 1] >= TITLE_MIN then mode = m break end
		end
	else
		mode = 0
	end
	local shown = math.min(mode, 2)
	stepsMode(nav, own, shown)
	local cw = shown == 2 and shortW or fullW
	count:SetWidth(cw)
	local sw = shown == 0 and cw + 48 or cw
	steps:SetWidth(sw)
	if mode >= 3 then
		if title:IsShown() then own.titleHid = true end
		title:Hide()
	elseif own.titleHid then
		own.titleHid = nil
		title:Show()
	end
	title:SetWidth(math.max(TITLE_MIN, room - sw))
end

local function navRow(nav)
	local prev = nav.Menu
	for _, b in ipairs({ nav.Report, nav.Nearby, nav.AllSteps, nav.Skip }) do
		if b == nav.Skip then
			if b.Label then b.Label:Hide() end
			b:SetWidth(SKIP_W)
		end
		b:ClearAllPoints()
		b:SetPoint("RIGHT", prev, "LEFT", b == nav.Skip and -2 or 0, 0)
		if b:IsShown() then prev = b end
	end
	nav.Steps:ClearAllPoints()
	nav.Steps:SetPoint("RIGHT", prev, "LEFT", -2, 0)
	-- The title runs up to the step count, or with it off to the buttons.
	local own = stores[nav]
	if own and own.emblem and nav.Title then
		nav.Title:ClearAllPoints()
		nav.Title:SetPoint("LEFT", own.emblem, "RIGHT", 8, 0)
		nav.Title:SetPoint("RIGHT", nav.Steps:IsShown() and nav.Steps or prev, "LEFT", -8, 0)
		nav.psFitTitle = true
		fitRow(nav, own, prev)
	end
end

local function header(parts)
	local nav = parts.nav
	if not (nav and nav.Steps and nav.Steps.Count and nav.Menu and nav.Title) then return end
	local own = store(nav)
	own.atlas = true
	if not own.emblem then
		-- On the menu button, so it fades with the bars (a transparent
		-- window's chrome shows only under the pointer; ui.barShown keeps it).
		own.emblem = nav.Menu:CreateTexture(nil, "ARTWORK")
		own.emblem:SetTexture(Theme.Media("emblem"))
		own.emblem:SetSize(16, 16)
	end
	own.emblem:ClearAllPoints()
	own.emblem:SetPoint("LEFT", nav, "LEFT", 10, 0)
	own.emblem:Show()
	nav.Lookup:Hide()
	-- The step count at the title's size, beside it, at the player's size
	-- for it (guideWindow.stepNumberSize, Atlas's default 75%); at least 40
	-- wide at that size, so the arrows hold still as the number changes.
	local path, size, flags = probe("goal")
	local k = Core.scale("stepNumberSize")
	nav.Steps.Count:SetFont(path, math.floor(size * Core.scale("barTextSize") * k + 0.5), flags)
	local cw = math.max(math.floor(40 * k + 0.5), math.ceil(nav.Steps.Count:GetUnboundedStringWidth()) + 1)
	nav.Steps.Count:SetWidth(cw)
	nav.Steps:SetWidth(24 + cw + 24)
	navRow(nav)
	Theme.Font(nav.Title, "goal")
	nav.Title:SetTextColor(Theme.Color("textDim"))
	nav.Title:SetJustifyH("LEFT")
	nav.Title:SetWordWrap(false)
	local text = nav.Title:GetText()
	if text == nil or text == "" then nav.Title:Hide() end
end
on("guideLayout", function(parts) header(parts) end)
-- The render shows or hides Skip, Report, Nearby and All steps again and puts Skip
-- back by them: set the row out again.
on("guideRender", function(view, parts)
	local nav = parts.nav
	local own = nav and stores[nav]
	if own and own.atlas and nav.Skip and nav.Steps and nav.Menu then navRow(nav) end
end)

-- With the foot bar off, room under the window's last part.
on("guideLayout", function() return 8 end)

---------------------------------------------------------------------------
-- The cards above the window, top down, by how far each is from the step
-- on screen: a banner notice (it asks for an answer: the way back, a tab to
-- reopen), the class quest card, While you're here (later steps' work, to
-- get ahead), Along the way (earlier steps' work still owed while the route
-- moves on), Optional (this step's extras), Training due, the party line
-- (the group on this very step, its wait). 5 apart, each on the window's own
-- ground (a frame painted as the guide window, so the skin in use colours
-- it), each with a close ×. The class quest heads-up sits on top of them
-- (guideAnchor). The Journey is a card joined to the window's foot.
---------------------------------------------------------------------------

local GAP = 5

-- How far in a frame's kit draws from its edge (Classic's clear rim,
-- Theme.KitSeam; 0 elsewhere). Two frames GAP apart then show GAP plus both
-- rims, so the space between them is set that much closer: GAP shows.
local function seamOf(window)
	return (window and not window.psBare and Theme.KitSeam) and Theme.KitSeam(window) or 0
end
local function gapOf(window) return GAP - 2 * seamOf(window) end
local OPT_ROW, OPT_PAD = 23, 14
-- Optional's heading this far under its card's top; the card's foot this far under its last row.
local OPT_TOP, OPT_FOOT = 9, 6
local CARD_UNDER = 0 -- a card's first row this far under its heading (the row's own air above its text is the gap)

-- Every card Atlas stacks above the window wears Optional's measures: these
-- three place its heading, its rows' first line and its foot.
-- The heading at its place on the card: -> the y its first row starts at.
local function cardHead(card, label)
	label:ClearAllPoints()
	label:SetPoint("TOPLEFT", card, "TOPLEFT", OPT_PAD, -OPT_TOP)
	if not label:IsShown() then return -OPT_TOP end
	return -(OPT_TOP + math.ceil(label:GetStringHeight() or 10) + CARD_UNDER)
end
-- A row holding `textH` of text in lines `lineH` tall: OPT_ROW on one
-- line; wrapped, its text with the same air under it as over (rowLine).
local function rowHeight(textH, lineH)
	if textH < lineH * 1.5 then return OPT_ROW end
	local inset = math.max(2, math.floor((OPT_ROW - lineH) / 2))
	return textH + inset * 2
end
-- The card's height, its last row ending at y.
local function cardFoot(y) return math.floor(-y + OPT_FOOT + 0.5) end
-- A row's text: how far under the row's top it starts, and its first
-- line's middle there (the icon's and the right column's), for a row
-- OPT_ROW tall per line. -> inset, mid, line height
local function rowLine(fs)
	local lineH = fs:GetLineHeight() or 12
	-- One line: the string's own height (a pixel over the line's in some
	-- faces), so the air under it is never less than over it.
	local th = fs:GetStringHeight() or lineH
	if th < lineH * 1.5 then lineH = math.max(lineH, math.ceil(th)) end
	local inset = math.max(2, math.floor((OPT_ROW - lineH) / 2))
	return inset, -(inset + math.floor(lineH / 2 + 0.5)), lineH
end

---------------------------------------------------------------------------
-- The Journey's styles (guideWindow.journeyStyle; Atlas's default "folded", open):
-- "inside" (Polestar's own, under the step), "joined" (a card joined under
-- the window's foot), "folded" (joined, its header the leg you are on with
-- a progress bar while collapsed), "rail" (inside, its legs as nodes on the
-- timeline) and "foot" (one chip per leg in the XP line's place, or in a
-- strip under the window without one). The legs and times are the Journey
-- panel's own (UI/JourneyPanel.lua: JP.Route, JP.Compute, JP.plan).
---------------------------------------------------------------------------

local JOURNEY_STYLES = { inside = true, joined = true, folded = true, rail = true, foot = true }
local function journeyStyle()
	local s = Core.setting("guideWindow.journeyStyle")
	return JOURNEY_STYLES[s] and s or "folded"
end
-- The panel behind journey frame `f`: a settings preview's sample
-- (JP.Sample, f.psPanel) or the live one (JP). Every journey frame a layout
-- placed is kept, to give each its look back on leaving.
local journeyFrames = setmetatable({}, { __mode = "k" })
local function journeyPanel(f)
	if f and f.psPanel then return f.psPanel end
	local u = P.UI
	return u and u.JourneyPanel
end

-- The XP row's own text and star, faded out while the chips stand in it.
local function xpUnder(xp, on)
	if not xp then return end
	if xp.Text then xp.Text:SetAlpha(on and 0 or 1) end
	if xp.Icon then xp.Icon:SetAlpha(on and 0 or 1) end
	if xp.Rest then xp.Rest:SetAlpha(on and 0 or 1) end
end

-- The panel's leg numbers: hidden on the rail (the nodes stand for them).
local function journeyRowsLook(onRail, f)
	local JP = journeyPanel(f)
	for _, r in ipairs(JP and JP.rows or {}) do
		if r.Num then r.Num:SetAlpha(onRail and 0 or 1) end
	end
end

-- The leg you are on, its place among the route's rows and how many there
-- are: leg, k, n; nil without a journey.
local function currentLeg(f)
	local JP = journeyPanel(f)
	if not (JP and JP.Route and JP.plan) then return nil end
	local legs, ci = JP.Route()
	if not legs then return nil end
	JP.Rows(legs, ci)
	local p = JP.plan
	local k = p.num[1] or 1
	return legs[ci], k, k - 1 + p.n, legs, ci
end

-- "folded": the collapsed header names the leg you are on, with its glyph,
-- and a thin bar of how far along the route is; open, "Journey" as ever.
local function foldedHead(on, f)
	local JP = journeyPanel(f)
	local head = JP and JP.head
	if not head then return end
	local own = store(head)
	local leg, k, n = currentLeg(f)
	local show = on and leg and not P.Get("nav.journeyOpen")
	if not show then
		if own.folded then
			own.folded = nil
			head.Label:ClearAllPoints()
			head.Label:SetPoint("LEFT", head, "LEFT", 14, 0)
			head.Label:SetText(tr("Journey"))
			head.Label:SetWidth(0)
			if own.icon then own.icon:Hide() end
			if own.bar then own.bar:Hide(); own.fill:Hide() end
			if own.count then own.count:Hide() end
		end
		return
	end
	own.folded = true
	if not own.icon then
		own.icon = head:CreateTexture(nil, "ARTWORK")
		own.icon:SetSize(13, 13)
		own.icon:SetPoint("LEFT", head, "LEFT", 14, 0)
		own.bar = head:CreateTexture(nil, "ARTWORK")
		own.bar:SetTexture(Theme.Media("white"))
		own.bar:SetPoint("BOTTOMLEFT", head, "BOTTOMLEFT", 14, 2)
		own.bar:SetPoint("BOTTOMRIGHT", head, "BOTTOMRIGHT", -14, 2)
		own.bar:SetHeight(2)
		own.fill = head:CreateTexture(nil, "OVERLAY")
		own.fill:SetTexture(Theme.Media("white"))
		own.fill:SetPoint("TOPLEFT", own.bar, "TOPLEFT", 0, 0)
		own.fill:SetPoint("BOTTOMLEFT", own.bar, "BOTTOMLEFT", 0, 0)
		own.count = head:CreateFontString(nil, "OVERLAY")
		own.count:SetFontObject(head.Label:GetFontObject() or GameFontNormalSmall)
	end
	own.icon:SetTexture(Theme.Media(JP.Glyph and JP.Glyph(leg) or "icon-note"))
	own.icon:SetVertexColor(Theme.Accent())
	own.icon:Show()
	head.Label:ClearAllPoints()
	head.Label:SetPoint("LEFT", own.icon, "RIGHT", 8, 0)
	head.Label:SetText(JP.StepText(leg))
	head.Label:SetWordWrap(false)
	local right = head.Time:IsShown() and head.Time or head.Icon
	head.Label:SetPoint("RIGHT", right, "LEFT", -34, 0)
	own.count:SetText(k .. "/" .. n)
	own.count:SetTextColor(Theme.Color("textMuted"))
	own.count:ClearAllPoints()
	own.count:SetPoint("RIGHT", right, "LEFT", -8, 0)
	own.count:Show()
	local r, g, b = Theme.Color("textMuted")
	own.bar:SetVertexColor(r, g, b, 0.25)
	own.bar:Show()
	local w = own.bar:GetWidth() or 0
	own.fill:SetVertexColor(Theme.Accent())
	own.fill:SetWidth(math.max(1, w * (k - 0.5) / math.max(1, n)))
	own.fill:SetShown(w > 0)
end

-- "foot": one chip per leg from the one you are on (its glyph and time, the
-- current one in the accent), the route's total on the right.
local CHIPS_MAX = 5
local function chipsFill(f)
	local JP = journeyPanel(f.psJourney)
	local leg, _, _, legs, ci = currentLeg(f.psJourney)
	if not leg then return false end
	local v = JP.Compute(legs, ci)
	local p = JP.plan
	local x = 14
	local tip = {}
	for i = 1, math.max(CHIPS_MAX, #f.chips) do
		local c = f.chips[i]
		if i <= math.min(p.n, CHIPS_MAX) then
			if not c then
				c = {}
				c.sep = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
				c.sep:SetText("\226\128\186")
				c.icon = f:CreateTexture(nil, "ARTWORK")
				c.icon:SetSize(11, 11)
				c.time = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
				f.chips[i] = c
			end
			local lg = legs[p.first[i]]
			local cur = i == 1
			c.sep:SetShown(i > 1)
			if i > 1 then
				c.sep:ClearAllPoints()
				c.sep:SetPoint("LEFT", f, "LEFT", x, 0)
				c.sep:SetTextColor(Theme.Color("textMuted"))
				x = x + 12
			end
			c.icon:SetTexture(Theme.Media(JP.Glyph and JP.Glyph(lg) or "icon-note"))
			if cur then c.icon:SetVertexColor(Theme.Accent()) else c.icon:SetVertexColor(Theme.Color("textMuted")) end
			c.icon:ClearAllPoints()
			c.icon:SetPoint("LEFT", f, "LEFT", x, 0)
			c.icon:Show()
			c.time:SetFontObject(semibold() or GameFontNormalSmall)
			c.time:SetText(JP.FormatTime(v.secs[i] or 0))
			c.time:SetTextColor(Theme.Color(cur and "text" or "textDim"))
			c.time:ClearAllPoints()
			c.time:SetPoint("LEFT", c.icon, "RIGHT", 5, 0)
			c.time:Show()
			x = x + 11 + 5 + math.ceil(c.time:GetStringWidth()) + 8
			tip[#tip + 1] = { JP.StepText(lg), JP.FormatTime(v.secs[i] or 0) }
		elseif c then
			c.sep:Hide(); c.icon:Hide(); c.time:Hide()
		end
	end
	f.more:SetShown(p.n > CHIPS_MAX)
	if p.n > CHIPS_MAX then
		f.more:ClearAllPoints()
		f.more:SetPoint("LEFT", f, "LEFT", x, 0)
		f.more:SetText("+" .. (p.n - CHIPS_MAX))
		f.more:SetTextColor(Theme.Color("textMuted"))
	end
	f.total:SetText(JP.FormatTime(v.total or 0))
	f.total:SetTextColor(Theme.Color("text"))
	f.psTip = tip
	return true
end

local function chipsFrame(owner)
	local own = store(owner)
	local f = own.chips
	if f then return f end
	f = CreateFrame("Frame", nil, owner)
	f.chips = {}
	f.more = f:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	f.total = f:CreateFontString(nil, "OVERLAY")
	f.total:SetFontObject(semibold() or GameFontNormalSmall)
	f.total:SetPoint("RIGHT", f, "RIGHT", -OPT_PAD, 0)
	f:EnableMouse(true)
	f:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(self, "ANCHOR_TOP")
		GameTooltip:AddLine(tr("Journey"))
		for _, t in ipairs(self.psTip or {}) do GameTooltip:AddDoubleLine(t[1], t[2], 0.85, 0.87, 0.93, 1, 1, 1) end
		GameTooltip:Show()
	end)
	f:SetScript("OnLeave", function() GameTooltip:Hide() end)
	-- The times count down once a second while the chips are on screen.
	local wait = 0
	f:SetScript("OnUpdate", function(self, dt)
		wait = wait - dt
		if wait > 0 then return end
		wait = 1
		if not pcall(chipsFill, self) then self:Hide() end
	end)
	own.chips = f
	return f
end

-- The step on screen (guideRender), per window: a card closed with its ×
-- stays closed on that step.
local stepOf = setmetatable({}, { __mode = "k" })
local closedOn = {} -- card -> the step it was closed on

-- The parts the window handed over at this layout (guidePlace), taken up by
-- the cards at guideLayout.
local slots = {}

-- The window's own ground on a card of Atlas's, transparent with it.
local function dress(card, window)
	if card.psBare ~= window.psBare or card.psBgAlpha ~= window.psBgAlpha or card.psBgColor ~= window.psBgColor
		or card.psNoBorder ~= window.psNoBorder then
		card.psBare, card.psBgAlpha, card.psBgColor = window.psBare, window.psBgAlpha, window.psBgColor
		card.psNoBorder = window.psNoBorder
		Theme.Repaint(card)
	end
end

local function stackFrame(window)
	local own = store(window)
	if not own.stack then
		-- A window of its own for what stands above the guide window (as the
		-- heads-up card is): the live window's is PolestarGuideFrameCards, so
		-- the cards are measured against their own edges, not the window's.
		local name = window.GetName and window:GetName()
		own.stack = CreateFrame("Frame", name and not _G[name .. "Cards"] and name .. "Cards" or nil, window)
		own.stack:SetHeight(1)
		own.stack.cards = {}
	end
	-- Above the window's own parts past its top edge (the On the top edge
	-- tabs: Theme.GuideReach, set before this layout), its gap over them.
	local reach = Theme.GuideReach and Theme.GuideReach(window) or 0
	local at = gapOf(window) + reach
	if own.stackAt ~= at then
		own.stackAt = at
		own.stack:ClearAllPoints()
		own.stack:SetPoint("BOTTOMLEFT", window, "TOPLEFT", 0, at)
		own.stack:SetPoint("BOTTOMRIGHT", window, "TOPRIGHT", 0, at)
	end
	return own.stack
end

local function closeButton(parent)
	local x = CreateFrame("Button", nil, parent)
	x:SetSize(18, 18)
	x.Icon = x:CreateTexture(nil, "ARTWORK")
	x.Icon:SetTexture(Theme.Media("close"))
	x.Icon:SetSize(10, 10)
	x.Icon:SetPoint("CENTER")
	x:SetScript("OnEnter", function(self) self.Icon:SetVertexColor(Theme.Color("text")) end)
	x:SetScript("OnLeave", function(self) self.Icon:SetVertexColor(Theme.Color("textMuted")) end)
	return x
end

-- Card i's backing, with its ×.
local function backing(stack, i)
	local b = stack.cards[i]
	if not b then
		b = CreateFrame("Frame", nil, stack)
		-- Painted as the guide window is (a window flagged psGuide): a game
		-- look's GUIDE frame, a skin's own guide painter. "guide" is no paint
		-- kind, so it fell to the house panel in every look.
		b.psGuide, b.psNoShadow = true, true
		Theme.Skin(b, "window")
		b:SetFrameLevel(stack:GetFrameLevel())
		b.Close = closeButton(b)
		b.Close:SetPoint("TOPRIGHT", b, "TOPRIGHT", -4, -4)
		b.Close:SetScript("OnClick", function(self) if self.psClose then self.psClose() end end)
		-- The × shows while the pointer is on the card.
		b.Close:SetAlpha(0)
		b:SetScript("OnUpdate", function(self)
			local over = self:IsMouseOver() and true or false
			if over == self.psOver then return end
			self.psOver = over
			self.Close:SetAlpha(over and 1 or 0)
		end)
		stack.cards[i] = b
	end
	return b
end

-- A card's label tells what the card holds on hover: no mark of its own.
local function infoIcon(owner, label, tip)
	local own = store(owner)
	local b = own.info
	if not b then
		b = CreateFrame("Frame", nil, owner)
		b:EnableMouse(true)
		b:SetScript("OnEnter", function(self)
			label:SetTextColor(Theme.Color("textDim"))
			if GameTooltip then
				-- Above the card, clear of its edge (on the label it covered the border).
				GameTooltip:SetOwner(self, "ANCHOR_NONE")
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("BOTTOMLEFT", owner, "TOPLEFT", 0, 4)
				GameTooltip:SetText(self.psTip or "", 1, 1, 1, 1, true)
				GameTooltip:Show()
			end
		end)
		b:SetScript("OnLeave", function(self)
			label:SetTextColor(Theme.Color("textMuted"))
			if GameTooltip then GameTooltip:Hide() end
		end)
		own.info = b
	end
	b.psTip = tip
	b:ClearAllPoints()
	b:SetPoint("TOPLEFT", label, "TOPLEFT", -2, 2)
	b:SetPoint("BOTTOMRIGHT", label, "BOTTOMRIGHT", 2, -2)
	b:SetShown(label:IsShown())
	return b
end

-- Whether two colours read as one: close in RGB, or the same hue when both
-- are colourful (a warm accent and the quest yellow).
local function alike(a, b)
	local dr, dg, db = a[1] - b[1], a[2] - b[2], a[3] - b[3]
	if math.sqrt(dr * dr + dg * dg + db * db) < 0.25 then return true end
	local function hs(c)
		local mx, mn = math.max(c[1], c[2], c[3]), math.min(c[1], c[2], c[3])
		local d = mx - mn
		if mx <= 0 or d / mx < 0.25 then return nil end
		local h
		if mx == c[1] then h = ((c[2] - c[3]) / d) % 6
		elseif mx == c[2] then h = (c[3] - c[1]) / d + 2
		else h = (c[1] - c[2]) / d + 4 end
		return h * 60
	end
	local ha, hb = hs(a), hs(b)
	if not (ha and hb) then return false end
	local diff = math.abs(ha - hb) % 360
	return math.min(diff, 360 - diff) < 40
end

local function dist3(a, b)
	local dr, dg, db = a[1] - b[1], a[2] - b[2], a[3] - b[3]
	return math.sqrt(dr * dr + dg * dg + db * db)
end

-- The first colour of `list` that does not read as `ref`; none does: the one
-- furthest from it.
local function apartFrom(list, ref)
	local best, far
	for _, c in ipairs(list) do
		if not alike(c, ref) then return c end
		local d = dist3(c, ref)
		if not far or d > far then best, far = c, d end
	end
	return best
end

local function palColor(name)
	local r, g, b = Theme.Color(name)
	return { r, g, b }
end

-- The colour of the arrow's mark on the node: the player's target bar colour,
-- else the quest yellow; when that reads as the accent, the NPC blue or the
-- text colour, whichever is further from it.
local function aimColor()
	local G = frame()
	local pr, pg, pb = G and G.Rgb and G.Rgb("targetBarColor")
	if pr then return { pr, pg, pb } end
	local ar, ag, ab = Theme.Accent()
	local ref = { ar, ag, ab }
	local q = palColor("quest")
	if not alike(q, ref) then return q end
	local c = apartFrom({ palColor("npc"), palColor("text") }, ref)
	return dist3(c, ref) >= dist3(q, ref) and c or q
end

-- The arrow's target on a card row: the goal rows' mark (GuideFrame.MarkRow),
-- lit by guideShows "markWash"; the rows marked are kept to clear on leaving.
local markedRows = setmetatable({}, { __mode = "k" })
local function markRow(r, on)
	local G = frame()
	if not (G and G.MarkRow) then return end
	if on then markedRows[r] = true end
	if on or rawget(r, "Mark") then G.MarkRow(r, on) end
end
onLeave(function()
	for r in pairs(markedRows) do markRow(r, false) end
	markedRows = setmetatable({}, { __mode = "k" })
end)

-- Whether the arrow points at step s's goal g, or at the place `at` (map, x, y).
local function aimedAt(t, s, g, at)
	if not t then return false end
	if s and g and t.stepIndex == s and t.goalIndex == g then return true end
	return at ~= nil and at.map ~= nil and t.map == at.map and at.x and at.y
		and math.abs((t.x or -1) - at.x) < 0.002 and math.abs((t.y or -1) - at.y) < 0.002 or false
end

-- While you're here: on its card, its label in caps as the other cards'.
-- Its panel, edge and the house look's hairline are Polestar's own (no hook
-- hands them over), out of sight while Atlas holds the part: the hairline,
-- inset in the card, drew a second box inside it.
local function hereLook(here, on)
	local own = store(here)
	for _, t in ipairs({ here.Panel, here.Edge, rawget(here, "psHairline") }) do
		if t and t.SetAlpha then t:SetAlpha(on and 0 or 1) end
	end
	if not here.Label then return end
	if on then
		hereFont = nil
		own._label = own._label or here.Label:GetText()
		capsLabel(here.Label)
		here.Label:SetText(Core.upper(own._label or ""))
		infoIcon(here, here.Label, tr("Get ahead, if possible"))
	elseif own._label then
		Theme.Font(here.Label, "small")
		here.Label:SetText(own._label)
		here.Label:SetTextColor(Theme.Accent())
		own._label = nil
		if own.info then own.info:Hide() end
	end
end

-- Its rows as the target's line: no step line under it and no × of its own
-- (the card's × stays), the count beside the distance ("2/12 · 80 yd").
-- An off-route timer's row keeps its line and its × (they are its point).
-- Each row as tall as its text wraps to at the width left it (the count
-- takes some), the rows one under the other, the card's foot as far under
-- the last line as its label stands under the top. -> the card's height
local HERE_COUNT = "|c%x%x%x%x%x%x%x%x(%d+/%d+)|r"
local function hereRows(here, height)
	local y
	for _, r in ipairs(rawget(here, "Rows") or {}) do
		local own = store(r)
		if own.count then own.count:Hide() end
		if r.Text and not hereFont then
			local path, size, flags = r.Text:GetFont()
			if path then hereFont = { path, size, flags } end
		end
		local p, rel, rp, rx, ry = r:GetPoint(1)
		if r:IsShown() and not y then
			local label = here.Label
			y = (label and label:IsShown() and rel) and cardHead(rel, label) or ry or 0
		end
		-- An off-route timer's row keeps its line.
		if r.psOff and own._sub then
			r.Sub:SetAlpha(1)
			own._sub = nil
		end
		if r:IsShown() and r.Text and r.Sub and r.Close and r.Dist and not r.psOff then
			-- Unseen rather than hidden: Polestar shows the line again at each
			-- refresh of the distances, between two layouts.
			r.Sub:SetAlpha(0)
			own._sub = true
			if r.Close:IsShown() then
				r.Close:Hide()
				own._close = true
			end
			-- The text, its icon and the distance on its first line as every
			-- card's rows (rowLine); the distance on the card's right edge,
			-- where the × was.
			local inset, mid, lineH = rowLine(r.Text)
			local tp, trel, trp, tx = r.Text:GetPoint(1)
			if tp then
				r.Text:ClearAllPoints()
				r.Text:SetPoint(tp, trel, trp, tx, -inset)
			end
			local ip, irel, irp, ix = r.Icon:GetPoint(1)
			if ip then
				r.Icon:ClearAllPoints()
				r.Icon:SetPoint(ip, irel, irp, ix, mid)
			end
			r.Dist:ClearAllPoints()
			r.Dist:SetPoint("RIGHT", r, "TOPRIGHT", -OPT_PAD, mid)
			-- From Polestar's own line (UI.SetCounted keeps it), so a second
			-- layout finds the count it took out at the first.
			local text = type(r.Text.psCounted) == "string" and r.Text.psCounted or r.Text:GetText() or ""
			local count = text:match(HERE_COUNT) or text:match("%s(%d+/%d+)%s*$")
			if count then
				local left = text:gsub("%s*" .. HERE_COUNT, "", 1)
				if left == text then left = text:gsub("%s+%d+/%d+%s*$", "", 1) end
				r.Text:SetText(left)
				own._text = true
				if not own.count then
					own.count = r:CreateFontString(nil, "OVERLAY")
					own.count:SetJustifyH("RIGHT")
					own.count:SetWordWrap(false)
				end
				local c = own.count
				c:SetFont(r.Dist:GetFont())
				c:SetTextColor(Theme.Color("textMuted"))
				local dist = r.Dist:GetText()
				c:SetText(count .. ((dist and dist ~= "") and "  \194\183  " or ""))
				c:ClearAllPoints()
				c:SetPoint("RIGHT", r.Dist, "LEFT", 0, 0)
				c:Show()
				local w = r.Text:GetWidth() or 0
				if w > 0 then r.Text:SetWidth(math.max(40, w - math.ceil(c:GetStringWidth()) - 4)) end
			end
			-- As tall as its text wraps to, a line a row (OPT_ROW).
			local h = rowHeight(math.floor(r.Text:GetStringHeight() + 0.5), lineH)
			local chip = rawget(r, "psChip")
			if type(chip) == "table" and chip.IsShown and chip:IsShown() then
				chip:ClearAllPoints()
				chip:SetPoint("TOPLEFT", r.Text, "BOTTOMLEFT", 0, -4)
				h = h + 4 + math.floor((chip:GetHeight() or 0) + 0.5)
			end
			r:SetHeight(h)
		end
		if r:IsShown() and p then
			r:ClearAllPoints()
			r:SetPoint(p, rel, rp, rx, y)
			y = y - (r:GetHeight() or 0)
		end
	end
	if not y then return height end
	return cardFoot(y)
end

-- Its rows back as Polestar laid them out.
local function hereRowsBack(here)
	for _, r in ipairs(rawget(here, "Rows") or {}) do
		local own = stores[r]
		if own then
			if own._sub then r.Sub:SetAlpha(1) end
			if own._close then r.Close:Show() end
			if own._text and type(r.Text.psCounted) == "string" then r.Text:SetText(r.Text.psCounted) end
			own._sub, own._close, own._text = nil, nil, nil
			if own.count then own.count:Hide() end
		end
	end
end

onLeave(function(parts)
	if parts.here then
		hereLook(parts.here, false)
		hereRowsBack(parts.here)
	end
end)

-- Along the way: the open goals of along steps the route has passed (and
-- pinned quests'), Polestar's own part on a card of its own, its heading in
-- caps as the other cards' ("ALONG THE WAY", "ALONG THE WAY, UNTIL STEP 30",
-- "STILL TO DO"), no rule over it. Its rows as While you're here's: the
-- count beside the distance ("6/10  ·  80 yd"), the "optional" tag kept in
-- the line; a click points the arrow (Polestar's own row does it).
local ALONG_EVERY = 0.25
local alongViews -- step:goal -> goal view, read once a render (guideRender)

local function alongLook(along, on)
	local own = store(along)
	if along.Rule and along.Rule.SetAlpha then along.Rule:SetAlpha(on and 0 or 1) end
	local label = along.Label
	if not label then return end
	if on then
		-- Polestar sets the heading at each render; a layout again finds it upper.
		local text = label:GetText() or ""
		if text ~= own._upper then own._label = text end
		capsLabel(label)
		own._upper = Core.upper(own._label or "")
		label:SetText(own._upper)
		infoIcon(along, label, tr("Still open from steps you have passed"))
		-- Where every card's heading stands (cardHead, at the rows' layout).
		if not own._labelAt then own._labelAt = { label:GetPoint(1) } end
	elseif own._label then
		Theme.Font(label, "small")
		label:SetText(own._label)
		label:SetTextColor(Theme.Color("textMuted"))
		own._label, own._upper = nil, nil
		if own.info then own.info:Hide() end
	end
	if not on and own._labelAt then
		label:ClearAllPoints()
		label:SetPoint(unpack(own._labelAt))
		own._labelAt = nil
	end
end

local function alongRowList(along)
	local list = {}
	for _, r in ipairs({ along:GetChildren() }) do
		if rawget(r, "Text") and rawget(r, "Icon") and r:IsShown() then list[#list + 1] = r end
	end
	table.sort(list, function(a, b)
		local _, _, _, _, ya = a:GetPoint(1)
		local _, _, _, _, yb = b:GetPoint(1)
		return (ya or 0) > (yb or 0)
	end)
	return list
end

-- A row's right side: its count and the distance to its goal, kept fresh.
-- A Still to do row's View (a click lists the carried quests): shown while
-- the pointer is on the card, as Optional's Skip is, the meta stepping left
-- of it; brighter with the pointer on the row.
local function alongView(m)
	local card = m.psView
	local over = card and card:IsMouseOver() and true or false
	local lit = over and m:GetParent():IsMouseOver() and true or false
	if m.psOver == over and m.psLit == lit then return end
	m.psOver, m.psLit = over, lit
	local right = OPT_PAD
	if rawget(m, "ViewLabel") then
		m.ViewLabel:SetShown(over)
		if over then
			m.ViewLabel:ClearAllPoints()
			m.ViewLabel:SetPoint("RIGHT", m:GetParent(), "TOPRIGHT", -OPT_PAD, m.psMid or 0)
			m.ViewLabel:SetTextColor(Theme.Color(lit and "text" or "textDim"))
			right = right + (m.psViewW or 0)
		end
	end
	m.Text:ClearAllPoints()
	m.Text:SetPoint("RIGHT", m:GetParent(), "TOPRIGHT", -right, m.psMid or 0)
end

local function alongMeta(r)
	local own = store(r)
	local m = own.meta
	if not m then
		m = CreateFrame("Frame", nil, r)
		m:SetAllPoints(r)
		m.Text = m:CreateFontString(nil, "OVERLAY")
		m.Text:SetJustifyH("RIGHT")
		m.Text:SetWordWrap(false)
		m:SetScript("OnUpdate", function(self, elapsed)
			if self.psView then alongView(self) end
			self.psElapsed = (self.psElapsed or 0) + elapsed
			if self.psElapsed < ALONG_EVERY then return end
			self.psElapsed = 0
			if self.psPaint then self.psPaint() end
		end)
		own.meta = m
	end
	return m
end

-- Each row as tall as its text wraps to (the "optional" tag a line of its
-- own, a long goal two) in the cards' face, its icon and meta on the first
-- line, the same air over and under its text; the rows one under the other,
-- the card's foot as far under the last line as its heading stands under
-- the top. -> the card's height
-- Optional's measures (layoutOptional): its rows, and the room under its
-- heading and at its foot.
local ALONG_ROW = OPT_ROW
local function alongRows(along, height)
	local y, inset
	local label = along.Label
	local labelShown = label and label:IsShown()
	for _, r in ipairs(alongRowList(along)) do
		local own = store(r)
		local m = alongMeta(r)
		local _, rel, _, rx, ry = r:GetPoint(1)
		if not y then y = labelShown and cardHead(along, label) or ry or 0 end
		-- From Polestar's own line (UI.SetCounted keeps it), so a second
		-- layout finds the count it took out at the first.
		local text = type(r.Text.psCounted) == "string" and r.Text.psCounted or r.Text:GetText() or ""
		local count = text:match(HERE_COUNT)
		if count then
			r.Text:SetText((text:gsub("%s*" .. HERE_COUNT, "", 1)))
			own._text = true
		end
		-- Still to do, under its own heading: the quest alone, where it is (or
		-- the XP) in the right column like the other rows' distance.
		local facts, factsMeta = r.psFacts, nil
		if type(facts) == "table" and (facts.quest or facts.text) then
			own._orig = own._orig or text
			-- The finished quests carried: the card's heading says they are still to do.
			local carried = facts.count and (facts.count == 1 and Core.tr("1 quest off-guide") or string.format(Core.tr("%d quests off-guide"), facts.count))
			-- A click lists them (QuestRoom "carried"): one line, as Optional's
			-- rows are, its View on the right while the pointer is on the card.
			own.view = carried and not facts.quest and true or nil
			r.Text:SetText(facts.quest or carried or facts.text)
			if facts.zone then
				factsMeta = facts.yards and (facts.zone .. "  \194\183  " .. (Core.distanceText(facts.yards) or "")) or facts.zone
			elseif facts.xp and P.Thousands then
				factsMeta = P.Thousands(facts.xp) .. " XP"
			end
		end
		r.Text:SetTextColor(Theme.Color("text"))
		own._color = true
		-- The icon on the label's left edge, the text after it, in the cards' face.
		if not own._font then own._font = { r.Text:GetFont() } end
		rowFont(r.Text)
		r.Icon:SetVertexColor(Theme.Accent())
		own._icon = true
		local _, _, _, tx = r.Text:GetPoint(1)
		local ox = OPT_PAD + 13 + 8
		if tx then
			local tw = r.Text:GetWidth() or 0
			if tw > 0 then r.Text:SetWidth(tw + (tx - ox)) end
		end
		local view = alongViews and r.psStep and r.psGoal and alongViews[r.psStep .. ":" .. r.psGoal] or nil
		local function paint()
			local yards = view and Core.yardsTo(view)
			local dist = yards and Core.distanceText(yards)
			local meta = count and dist and (count .. "  \194\183  " .. dist) or count or dist or factsMeta
			m.Text:SetText(meta or "")
			return meta
		end
		Theme.Font(m.Text, "small")
		m.Text:SetTextColor(Theme.Color("textMuted"))
		m.psPaint = view and paint or nil
		local meta = paint()
		m:SetShown(meta ~= nil)
		local w = r.Text:GetWidth() or 0
		local viewW = 0
		if own.view then
			if not rawget(m, "ViewLabel") then
				m.ViewLabel = m:CreateFontString(nil, "OVERLAY")
				m.ViewLabel:SetJustifyH("RIGHT")
			end
			Theme.Font(m.ViewLabel, "small")
			m.ViewLabel:SetText(Core.tr("View"))
			viewW = math.ceil(m.ViewLabel:GetStringWidth()) + 6
		elseif rawget(m, "ViewLabel") then
			m.ViewLabel:Hide()
		end
		m.psView = own.view and along or nil
		if (meta or own.view) and w > 0 then
			-- Room for the widest the meta grows to as the distance changes, and
			-- for View beside it.
			r.Text:SetWidth(math.max(40, w - (meta and math.ceil(m.Text:GetStringWidth()) + 18 or 0) - viewW))
		end
		-- Its height from its text at the width now left it.
		local i, mid, lineH = rowLine(r.Text)
		inset = i
		local th = math.floor((r.Text:GetStringHeight() or lineH) + 0.5)
		r.Text:ClearAllPoints()
		r.Text:SetPoint("TOPLEFT", r, "TOPLEFT", ox, -inset)
		r.Icon:ClearAllPoints()
		r.Icon:SetPoint("LEFT", r, "TOPLEFT", OPT_PAD, mid)
		m.psMid, m.psViewW, m.psOver = mid, viewW, nil
		alongView(m)
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", rel, "TOPLEFT", rx or 0, y)
		r:SetPoint("TOPRIGHT", rel, "TOPRIGHT", 0, y)
		r:SetHeight(rowHeight(th, lineH))
		y = y - r:GetHeight()
	end
	if not y then return height end
	return cardFoot(y)
end

local function alongRowsBack(along)
	for _, r in ipairs({ along:GetChildren() }) do
		local own = stores[r]
		if own then
			if own._orig then r.Text:SetText(own._orig)
			elseif own._text and type(r.Text.psCounted) == "string" then r.Text:SetText(r.Text.psCounted) end
			own._orig = nil
			if own._color then r.Text:SetTextColor(Theme.Color("textDim")) end
			if own._font and own._font[1] then r.Text:SetFont(own._font[1], own._font[2], own._font[3]) end
			if own._icon then r.Icon:SetVertexColor(Theme.Color("textMuted")) end
			own._text, own._color, own._font, own._icon = nil, nil, nil, nil
			if own.meta then
				own.meta.psPaint, own.meta.psView = nil, nil
				if rawget(own.meta, "ViewLabel") then own.meta.ViewLabel:Hide() end
				own.meta:Hide()
			end
			own.view = nil
		end
	end
end

on("guideRender", function() alongViews = nil end)

onLeave(function(parts)
	if parts.along then
		alongLook(parts.along, false)
		alongRowsBack(parts.along)
	end
end)

-- A banner notice (Looking ahead, the tab just closed and its Reopen, a quest
-- left, a step skipped, the bags, a newer Polestar...) as a heads-up card on
-- top of the stack ("card"): Polestar's own banner, its text, its action link,
-- Later and its × as they are; the card's ground in place of its tint and
-- rule. One kept in the window ("strip", the bags and Looking back or ahead) reads as a dark strip
-- tinted by its kind (no tint in a transparent window), with a 3px edge and icon in that colour; its action
-- sits by the × (guideWindow.bannerLinks "right"). nil: Polestar's own look.
-- Shown or hidden, never SetAlpha: a texture's alpha is its colour's.
local BANNER_ROLE = { bags = "warning", away = "npc", train = "npc", riding = "npc", skipped = "textMuted", questSkip = "textMuted" }
local function bannerLook(banner, mode)
	local W = P.Widgets
	if banner.Fill then banner.Fill:SetShown(mode == nil) end
	if banner.Rule then
		local G = P.UI and P.UI.GuideFrame
		banner.Rule:SetShown(mode ~= "card" and (not G or not G.On or G.On("rules")))
	end
	local strip = mode == "strip"
	if strip and not banner.psTint then
		banner.psTint = banner:CreateTexture(nil, "BACKGROUND", nil, 1)
		banner.psTint:SetTexture(Theme.Media("white"))
		banner.psTint:SetAllPoints(banner)
		banner.psEdge = banner:CreateTexture(nil, "BORDER")
		banner.psEdge:SetTexture(Theme.Media("white"))
		banner.psEdge:SetPoint("TOPLEFT", banner, "TOPLEFT", 0, 0)
		banner.psEdge:SetPoint("BOTTOMLEFT", banner, "BOTTOMLEFT", 0, 0)
		banner.psEdge:SetWidth(3)
	end
	if banner.psTint then
		-- A transparent window (psBare: the one holding this banner, live or
		-- a settings copy) has no ground: the strip keeps its edge and icon,
		-- not its tint.
		local w = windowOf(banner)
		local bare = w and w.psBare
		banner.psTint:SetShown(strip and not bare)
		banner.psEdge:SetShown(strip)
	end
	local role = strip and BANNER_ROLE[banner.psKind] or "accent"
	if W and W.Color then
		if strip then
			W.Color(banner.psTint, role, 0.11)
			W.Color(banner.psEdge, role)
		end
		if banner.Icon then W.Color(banner.Icon, role) end
	end
end

onLeave(function(parts) if parts.banner then bannerLook(parts.banner, nil) end end)
onLeave(function()
	journeyRowsLook(false)
	foldedHead(false)
	for f in pairs(journeyFrames) do journeyRowsLook(false, f); foldedHead(false, f) end
	local G = P.UI and P.UI.GuideFrame
	xpUnder(G and G.xp, false)
end)

-- The party's place on this guide (and "Go on without them") on a card:
-- Polestar's own line under a "PARTY" label, no rule over it.
local seenParty = setmetatable({}, { __mode = "k" })
local function partyLook(party, on)
	if on then seenParty[party] = true end
	if party.Rule and party.Rule.SetAlpha then party.Rule:SetAlpha(on and 0 or 1) end
end

-- The card that holds the party line: its label, the line under it.
local function partyCard(stack, party)
	local c = stack.party
	if not c then
		c = CreateFrame("Frame", nil, stack)
		c.Label = c:CreateFontString(nil, "OVERLAY")
		stack.party = c
	end
	capsLabel(c.Label)
	c.Label:SetText(Core.upper(tr("Party")))
	c.Label:Show()
	local y = cardHead(c, c.Label)
	-- The party line's own frame (28, its text in the middle) as one row:
	-- its text's middle where a row's would be.
	local h = party:GetHeight() or 28
	local lift = math.floor((h - OPT_ROW) / 2 + 0.5)
	party:SetParent(c)
	party:ClearAllPoints()
	party:SetPoint("TOPLEFT", c, "TOPLEFT", 0, y + lift)
	party:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, y + lift)
	party:Show()
	c:SetHeight(cardFoot(y - OPT_ROW))
	return c
end

-- The party line is not among the parts handed over: the layout leaving a
-- window gives the ones it saw in that window their rule back.
onLeave(function(parts, live)
	for party in pairs(seenParty) do
		if Core.leaves(party, parts, live) then partyLook(party, false) end
	end
end)

-- The training reminder as a card: "TRAINING DUE", the trainer line and the
-- place on its right; × puts it off (Later), a click takes it up.
local function trainCard(stack)
	if stack.train then return stack.train end
	local f = CreateFrame("Button", nil, stack)
	f.Label = f:CreateFontString(nil, "OVERLAY")
	f.Icon = f:CreateTexture(nil, "ARTWORK")
	f.Icon:SetSize(13, 13)
	f.Text = f:CreateFontString(nil, "OVERLAY")
	f.Text:SetWordWrap(false)
	f.Text:SetJustifyH("LEFT")
	f.Place = f:CreateFontString(nil, "OVERLAY")
	f.Place:SetJustifyH("RIGHT")
	f.Place:SetWordWrap(false)
	f:SetScript("OnClick", function(self) if self.psTrainer then Core.takeNotice() end end)
	stack.train = f
	return f
end

local function fillTrain(f, width)
	local advice = Core.training()
	local trainer = not advice.guide and advice.trainer or nil
	local place = (advice.title and advice.title ~= "" and advice.title)
		or (trainer and (trainer.npcName or (trainer.map and Core.mapName(trainer.map)))) or nil
	f.psTrainer = trainer
	capsLabel(f.Label)
	f.Label:SetText(Core.upper(tr("Training due")))
	f.Label:Show()
	local rowY = cardHead(f, f.Label)
	rowFont(f.Text)
	f.Text:SetTextColor(Theme.Color("text"))
	f.Text:SetText(tr("New spells at your class trainer"))
	Theme.Font(f.Place, "small")
	f.Place:SetTextColor(Theme.Color("textMuted"))
	f.Place:SetText(place or "")
	f.Place:SetShown(place ~= nil)
	f.Icon:SetTexture(Theme.VerbIcon("talk"))
	f.Icon:SetVertexColor(Theme.Accent())
	local mid = rowY - math.floor(OPT_ROW / 2 + 0.5)
	f.Icon:ClearAllPoints()
	f.Icon:SetPoint("LEFT", f, "TOPLEFT", OPT_PAD, mid)
	f.Place:ClearAllPoints()
	f.Place:SetPoint("RIGHT", f, "TOPRIGHT", -OPT_PAD, mid)
	f.Place:SetWidth(math.min(f.Place:GetStringWidth() + 1, 120))
	f.Text:ClearAllPoints()
	f.Text:SetPoint("LEFT", f, "TOPLEFT", OPT_PAD + 13 + 8, mid)
	f.Text:SetPoint("RIGHT", f.Place, "LEFT", -8, 0)
	f:SetSize(width, cardFoot(rowY - OPT_ROW))
	return f
end

-- Optional: the step's optional goals and its notes, taken out of the goal
-- list (guideTakes) onto a card of their own. A row aims the arrow, Skip
-- puts the goal by, and the count and the distance sit on its right.
local opt = setmetatable({}, { __mode = "k" }) -- window -> { step, goals, notes, sig }

local function takesOut(goal)
	return (goal.optional or goal.t == "note") and true or false
end
on("guideTakes", function(goal) return takesOut(goal) or nil end)

local function optCard(stack)
	if stack.opt then return stack.opt end
	local c = CreateFrame("Frame", nil, stack)
	c.Label = c:CreateFontString(nil, "OVERLAY")
	c.Rows, c.Notes = {}, {}
	stack.opt = c
	return c
end

local function optMeta(r)
	local goal = r._goal
	local target = Core.target()
	local active = not goal.previewOnly and not goal.dismissed and goal.status ~= "done" and goal.status ~= "skipped"
	local aimed = active and target and (aimedAt(target, r.psStep, goal.index, goal) or r._point == target)
	local yards
	if active then
		if aimed then yards = Core.distance() end
		yards = yards or Core.yardsTo(goal)
	end
	local count = Core.goalProgress(goal)
	local dist = yards and Core.distanceText(yards)
	local meta = count and dist and (count .. "  \194\183  " .. dist) or count or dist
	r.Meta:SetText(meta or "")
	r.Meta:SetShown(meta ~= nil)
	local right = r.psMetaRight + (meta and math.ceil(r.Meta:GetUnboundedStringWidth()) + 6 or 0)
	r.Text:SetWidth(math.max(40, r.psWidth - (OPT_PAD + 13 + 8) - right - 2))
	markRow(r, aimed)
end

-- Skip shows while the pointer is on the card; the count and distance keep the right edge without it.
local function optRight(r)
	local right = OPT_PAD
	local show = r.psCanSkip and (r.psHover or r.psDismissed)
	r.Skip:SetShown(show and true or false)
	if show then
		r.Skip:SetSize(math.floor(r.Skip.Label:GetStringWidth() + 8 + 0.5), 14)
		r.Skip:ClearAllPoints()
		r.Skip:SetPoint("RIGHT", r, "RIGHT", -right, 0)
		right = right + r.Skip:GetWidth() + 6
	end
	r.Meta:ClearAllPoints()
	r.Meta:SetPoint("RIGHT", r, "RIGHT", -right, 0)
	r.psMetaRight = right
end

local function optRow(c, i)
	local r = c.Rows[i]
	if r then return r end
	r = CreateFrame("Button", nil, c)
	r:EnableMouse(true)
	r:RegisterForClicks("LeftButtonUp")
	r:SetScript("OnClick", function(self)
		local goal = self._goal
		if not goal or goal.previewOnly or goal.dismissed or goal.status == "done" or goal.status == "skipped" then return end
		self._point = Core.aim(goal)
		optMeta(self)
	end)
	r:SetScript("OnUpdate", function(self, elapsed)
		local over = c:IsMouseOver() and true or false
		if over ~= self.psHover and self._goal then
			self.psHover = over
			optRight(self)
			optMeta(self)
		end
		self.psElapsed = (self.psElapsed or 0) + elapsed
		if self.psElapsed < 0.25 or not self._goal then return end
		self.psElapsed = 0
		optMeta(self)
	end)
	r.Icon = r:CreateTexture(nil, "ARTWORK")
	r.Icon:SetSize(13, 13)
	r.Icon:SetPoint("LEFT", r, "LEFT", OPT_PAD, 0)
	r.Text = r:CreateFontString(nil, "OVERLAY")
	rowFont(r.Text)
	r.Text:SetJustifyH("LEFT")
	r.Text:SetWordWrap(false)
	r.Meta = r:CreateFontString(nil, "OVERLAY")
	Theme.Font(r.Meta, "small")
	r.Meta:SetJustifyH("RIGHT")
	r.Skip = CreateFrame("Button", nil, r)
	r.Skip.Label = r.Skip:CreateFontString(nil, "OVERLAY")
	Theme.Font(r.Skip.Label, "small")
	r.Skip.Label:SetPoint("CENTER")
	r.Skip:SetScript("OnClick", function() if r._goal then Core.skipGoal(r.psStep, r._goal.index) end end)
	r.Skip:SetScript("OnEnter", function(b) b.Label:SetTextColor(Theme.Color("text")) end)
	r.Skip:SetScript("OnLeave", function(b) b.Label:SetTextColor(Theme.Color("textDim")) end)
	c.Rows[i] = r
	return r
end

-- Filled from the step on screen (guideRender), laid out with the stack.
local function fillOptional(view, parts)
	local window = parts and parts.window
	if not window then return end
	local o = opt[window] or {}
	opt[window] = o
	o.goals, o.notes, o.step = {}, {}, view and view.index or nil
	local sig = {}
	for _, goal in ipairs(view and view.goals or {}) do
		if goal.status ~= "na" and not goal.folded and takesOut(goal) then
			local list = goal.t == "note" and o.notes or o.goals
			list[#list + 1] = goal
			sig[#sig + 1] = goal.index .. (goal.status or "") .. (goal.dismissed and "d" or "")
		end
	end
	-- The render comes after the layout: lay out again when the card's content changed.
	local now = (o.step or 0) .. ":" .. table.concat(sig, ",")
	if now ~= o.sig then
		o.sig = now
		local live = Theme.GuideParts and Theme.GuideParts()
		if live and live.window == window then Core.relayout() end
	end
end

local function layoutOptional(stack, window, step)
	local c = optCard(stack)
	local o = opt[window]
	local n, m = o and #o.goals or 0, o and #o.notes or 0
	if n + m == 0 or closedOn.opt == step then
		c:Hide()
		return nil
	end
	local width = window:GetWidth() or 0
	local lh = OPT_TOP
	for i = 1, m do
		local fs = c.Notes[i]
		if not fs then
			fs = c:CreateFontString(nil, "OVERLAY")
			Theme.Font(fs, "label")
			fs:SetJustifyH("LEFT")
			fs:SetJustifyV("TOP")
			fs:SetWordWrap(true)
			c.Notes[i] = fs
		end
		fs:SetTextColor(Theme.Color("quest"))
		fs:SetText(Core.goalText(o.notes[i]))
		fs:SetWidth(math.max(40, width - OPT_PAD * 2 - 18))
		fs:ClearAllPoints()
		fs:SetPoint("TOPLEFT", c, "TOPLEFT", OPT_PAD, -lh)
		fs:Show()
		lh = lh + math.floor(fs:GetStringHeight() + 0.5) + 3
	end
	for i = m + 1, #c.Notes do c.Notes[i]:Hide() end
	c.Label:ClearAllPoints()
	c.Label:SetPoint("TOPLEFT", c, "TOPLEFT", OPT_PAD, -lh)
	capsLabel(c.Label)
	c.Label:SetText(Core.upper(tr("Optional")))
	c.Label:SetShown(n > 0)
	infoIcon(c, c.Label, tr("Optional objectives during this step"))
	if n > 0 then lh = lh + math.ceil(c.Label:GetStringHeight()) + CARD_UNDER end
	for i = 1, n do
		local goal = o.goals[i]
		local r = optRow(c, i)
		local done, dismissed = goal.status == "done", goal.dismissed
		if not r._goal or r._goal.index ~= goal.index or r.psStep ~= o.step then r._point = nil end
		r._goal, r.psStep = goal, o.step
		r:ClearAllPoints()
		r:SetPoint("TOPLEFT", c, "TOPLEFT", 0, -lh)
		r:SetPoint("TOPRIGHT", c, "TOPRIGHT", 0, -lh)
		r:SetHeight(OPT_ROW)
		r.Icon:SetTexture(done and Theme.Media("check") or (dismissed and Theme.Media("skip")) or Theme.VerbIcon(goal.t))
		if done then r.Icon:SetVertexColor(Theme.Color("success"))
		elseif dismissed then r.Icon:SetVertexColor(Theme.Color("textMuted"))
		else r.Icon:SetVertexColor(Theme.Accent()) end
		rowFont(r.Text)
		r.Text:SetText((done or dismissed) and Core.plainGoalText(goal) or Core.goalText(goal))
		r.Text:SetTextColor(Theme.Color((done or dismissed) and "textMuted" or "text"))
		r.Meta:SetTextColor(Theme.Color("textMuted"))
		r.Skip.Label:SetText(dismissed and tr("Undo") or tr("Skip"))
		r.Skip.Label:SetTextColor(Theme.Color("textDim"))
		-- An undo stays in view: the goal put by says how to bring it back.
		r.psCanSkip = (not done and not goal.previewOnly and Core.canSkip()) and true or false
		r.psHover, r.psDismissed = c:IsMouseOver() and true or false, dismissed and true or false
		r.psWidth = width
		optRight(r)
		r.Text:ClearAllPoints()
		r.Text:SetPoint("LEFT", r.Icon, "RIGHT", 8, 0)
		optMeta(r)
		r:Show()
		lh = lh + OPT_ROW
	end
	for i = n + 1, #c.Rows do
		c.Rows[i]:Hide()
		c.Rows[i]._goal = nil
	end
	c:SetHeight(lh + OPT_FOOT)
	return c
end

if has("guideTakes") then
	on("guideRender", function(view, parts) fillOptional(view, parts) end)
end
on("guideRender", function(view, parts) if parts.window then stepOf[parts.window] = view and view.index or nil end end)

-- The class guide on offer: the heads-up card above the window (×, Later),
-- not a banner in it. Shown once per notice; its buttons are the banner's
-- own (open the guide in a tab, Later).
local headsUpFor
local function classHeadsUp(n)
	if headsUpFor == n then return true end
	local shown = Core.showHeadsUp({
		head = Core.upper(tr("Class quest")),
		title = n.title or "",
		giver = n.heads, route = n.why,
		icon = Theme.Media("icon-train"), iconColor = "accent",
		act = { label = tr("Open in a tab"), run = function() Core.takeNotice(); Core.hideHeadsUp() end },
		later = { label = tr("Later"), run = function() Core.laterNotice() end },
	})
	if shown then headsUpFor = n end
	return shown
end

-- The class quest card (in the window under Polestar's own layout) as a
-- card above it, its × putting the chain away for the session.
local classShut = {}

-- Another tab's step close by (UI/OtherTab.lua) as a card above the window:
-- on the window's ground in Optional's measures, without the card's own
-- wash, stripe and border (psPlain); its heading, icon and chevron keep
-- their sky. -> its height
local OT_ICON, OT_GO = 14, 16
local function otherTabLook(part, width)
	part.psPlain = true
	for _, t in ipairs({ rawget(part, "Wash"), rawget(part, "Stripe") }) do if t then t:Hide() end end
	for _, t in ipairs(rawget(part, "psBorder") or {}) do t:Hide() end
	local head, title, icon = part.Head, part.Title, part.Icon
	local r, g, b = icon:GetVertexColor()
	capsLabel(head)
	head:SetTextColor(r, g, b, 1)
	head:SetWidth(math.max(40, width - OPT_PAD * 2 - OT_GO))
	local y = cardHead(part, head)
	rowFont(title)
	local tx = OPT_PAD + OT_ICON + 6
	title:SetWidth(math.max(40, width - tx - OPT_PAD - OT_GO))
	local inset, mid, lineH = rowLine(title)
	title:ClearAllPoints()
	title:SetPoint("TOPLEFT", part, "TOPLEFT", tx, y - inset)
	icon:ClearAllPoints()
	icon:SetPoint("LEFT", part, "TOPLEFT", OPT_PAD, y + mid)
	y = y - rowHeight(title:GetStringHeight() or lineH, lineH)
	return cardFoot(y)
end

on("guidePlace", function(name, part, width, height)
	if name == "here" then
		hereLook(part, true)
		local h = math.max(1, hereRows(part, height))
		part:SetHeight(h)
		local body = rawget(part, "Body")
		if type(body) == "table" and body.SetHeight then body:SetHeight(h) end
		slots.here = part
		return true
	end
	if name == "banner" and part.psKind == "classQuest" then
		local _, n = Core.notice()
		if n and classHeadsUp(n) then
			part:Hide()
			return true
		end
	elseif name == "banner" and part.psKind == "train" then
		slots.train = part
		part:Hide()
		return true
	end
	if name == "otherTab" then
		part:SetHeight(otherTabLook(part, width or 300))
		slots.otherTab = part
		return true
	end
	if name == "classCard" then
		local key = Core.classCardKey()
		if key and classShut[key] then
			part:Hide()
			return true
		end
		part:SetHeight(height)
		slots.class, slots.classKey = part, key
		return true
	end
	if name == "journey" then
		local style = journeyStyle()
		journeyFrames[part] = true
		journeyRowsLook(style == "rail", part)
		-- Inside and on the rail: Polestar stacks it under the step.
		if style == "inside" or style == "rail" then return nil end
		-- In the foot: the chips stand for it (layoutBottom); the panel waits hidden.
		if style == "foot" then
			part:Hide()
			slots.journey, slots.journeyFoot = part, true
			return true
		end
		part:SetHeight(height)
		slots.journey = part
		return true
	end
	-- Full bags stay in the window, as a tinted strip.
	if name == "banner" and part.psKind == "bags" then
		bannerLook(part, "strip")
		return false
	end
	-- Looking back or ahead: the same strip, an eye for its icon; no × (the
	-- guideShows "bannerClose" below), paging back or its link ends it.
	if name == "banner" and part.psKind == "away" then
		bannerLook(part, "strip")
		local _, n = Core.notice()
		if not (n and n.skipped) and part.Icon then part.Icon:SetTexture(Theme.Media("eye")) end
		return false
	end
	-- Every other banner notice: a heads-up card on top of the stack.
	if name == "banner" then
		bannerLook(part, "card")
		part:SetHeight(height)
		slots.banner = part
		return true
	end
	if name == "along" then
		alongViews = alongViews or Core.alongGoals()
		alongLook(part, true)
		part:SetHeight(alongRows(part, height))
		slots.along = part
		return true
	end
	if name == "party" then
		partyLook(part, true)
		part:SetHeight(height)
		slots.party = part
		return true
	end
end)

-- The arrow's target on While you're here's and Along the way's rows (their
-- clicks are Polestar's own), looked at a few times a second while shown.
local MARK_EVERY = 0.2
local function markRows(stack)
	local t = Core.target()
	local here = stack.psHere
	if here and here:IsShown() then
		for _, r in ipairs(rawget(here, "Rows") or {}) do
			local v = rawget(r, "psView")
			markRow(r, r:IsShown() and not r.psOff and type(v) == "table" and aimedAt(t, v.step, v.index, v))
		end
	end
	local along = stack.psAlong
	if along and along:IsShown() then
		alongViews = alongViews or Core.alongGoals()
		for _, r in ipairs(alongRowList(along)) do
			local view = alongViews and r.psStep and r.psGoal and alongViews[r.psStep .. ":" .. r.psGoal] or nil
			markRow(r, aimedAt(t, r.psStep, r.psGoal, view))
		end
	end
end

local function layoutStack(parts)
	local window = parts.window
	local stack = stackFrame(window)
	if not stack.psMarks then
		stack.psMarks = 0
		stack:SetScript("OnUpdate", function(self, elapsed)
			self.psMarks = self.psMarks + elapsed
			if self.psMarks < MARK_EVERY then return end
			self.psMarks = 0
			markRows(self)
		end)
	end
	local step = stepOf[window]
	if closedOn.here and closedOn.here ~= step then closedOn.here = nil end
	if closedOn.opt and closedOn.opt ~= step then closedOn.opt = nil end
	if closedOn.along and closedOn.along ~= step then closedOn.along = nil end
	if closedOn.party and closedOn.party ~= step then closedOn.party = nil end
	local list = {}
	local function add(f, close) list[#list + 1] = { f = f, close = close } end
	local function relay() Core.relayout() end
	local s = slots
	-- A banner notice keeps its own × (and Later): none of the card's.
	if s.banner and isUnder(s.banner, window) then add(s.banner, nil) end
	-- Another tab's step close by: its × puts it away until out of range.
	if s.otherTab and isUnder(s.otherTab, window) then
		add(s.otherTab, function()
			local OT = P.UI and P.UI.OtherTabCard
			if OT and OT.Dismiss then OT.Dismiss() end
		end)
	end
	if s.class and isUnder(s.class, window) then
		local key = s.classKey
		add(s.class, function() if key then classShut[key] = true end relay() end)
	end
	if s.here and isUnder(s.here, window) then
		if closedOn.here == step then s.here:Hide() else add(s.here, function() closedOn.here = step relay() end) end
	end
	if s.along and isUnder(s.along, window) then
		if closedOn.along == step then s.along:Hide() else add(s.along, function() closedOn.along = step relay() end) end
	end
	local optional = layoutOptional(stack, window, step)
	if optional then add(optional, function() closedOn.opt = step relay() end) end
	if s.train and isUnder(s.train, window) then
		add(fillTrain(trainCard(stack), window:GetWidth() or 300), Core.laterNotice)
	elseif stack.train then
		stack.train:Hide()
	end
	if s.party and isUnder(s.party, window) and closedOn.party ~= step then
		add(partyCard(stack, s.party), function() closedOn.party = step relay() end)
	elseif s.party then
		s.party:Hide()
	end
	if not (s.party and stack.party and s.party:GetParent() == stack.party) and stack.party then stack.party:Hide() end
	stack.psHere = s.here and isUnder(s.here, window) and s.here or nil
	stack.psAlong = s.along and isUnder(s.along, window) and s.along or nil
	slots = {}
	local width = window:GetWidth() or 300
	local y, gap = 0, gapOf(window)
	for i = #list, 1, -1 do
		local f = list[i].f
		local h = f:GetHeight() or 0
		local b = backing(stack, i)
		b:ClearAllPoints()
		b:SetPoint("BOTTOMLEFT", stack, "BOTTOMLEFT", 0, y)
		b:SetSize(width, h)
		dress(b, window)
		b:Show()
		b.Close.psClose = list[i].close
		b.Close.Icon:SetVertexColor(Theme.Color("textMuted"))
		b.Close:SetFrameLevel(b:GetFrameLevel() + 5)
		b.Close:SetShown(list[i].close ~= nil)
		f:SetParent(b)
		f:SetFrameLevel(b:GetFrameLevel() + 1)
		f:ClearAllPoints()
		f:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
		f:SetPoint("TOPRIGHT", b, "TOPRIGHT", 0, 0)
		f:Show()
		-- A badge on the class card steps left of the ×.
		local badge = rawget(f, "Badge")
		if type(badge) == "table" and badge:IsShown() then
			badge:ClearAllPoints()
			badge:SetPoint("TOPRIGHT", f, "TOPRIGHT", -26, -10)
		end
		y = y + h + gap
	end
	for i = #list + 1, #stack.cards do stack.cards[i]:Hide() end
	if #list > 0 then
		stack:SetHeight(y - gap)
		stack:Show()
		markRows(stack)
	else
		stack:Hide()
	end
end

-- The Journey: collapsed on a card joined to the window's foot.
-- "foot": the chips in the XP row's place, or in the strip under the window
-- without one. -> whether the strip holds them
local function layoutFoot(parts, b, on, journey)
	local window = parts.window
	local G = P.UI and P.UI.GuideFrame
	local xp = G and G.xp
	local inXp = on and xp and isUnder(xp, window) and xp:IsShown()
	if xp then
		local c = stores[xp] and stores[xp].chips
		if c and not inXp then c:Hide() end
		xpUnder(xp, inXp)
	end
	local strip = stores[b] and stores[b].chips
	if strip and (inXp or not on) then strip:Hide() end
	if not on then return false end
	local f = chipsFrame(inXp and xp or b)
	f.psJourney = journey
	f:ClearAllPoints()
	f:SetAllPoints(inXp and xp or b)
	f:SetFrameLevel((inXp and xp or b):GetFrameLevel() + 3)
	f:Show()
	local ok, filled = pcall(chipsFill, f)
	if not (ok and filled) then f:Hide() return false end
	return not inXp
end

local function layoutBottom(parts, journey, foot)
	local window = parts.window
	local own = store(window)
	if not journey and not own.bottom then return end
	if not own.bottom then
		local b = CreateFrame("Frame", nil, window)
		b:SetHeight(1)
		-- The window's own kit (and its psGuide ground), so the Journey
		-- reads as the window going on, not a panel under it.
		b.psGuide = true
		Theme.Skin(b, "window")
		own.bottom = b
	end
	local b = own.bottom
	-- Joined to the window's foot; under a kit with a clear rim (Classic) the
	-- two frames show their rims, so it stands GAP below as the cards above do.
	local under = seamOf(window) > 0 and -gapOf(window) or 0
	if own.bottomAt ~= under then
		own.bottomAt = under
		b:ClearAllPoints()
		b:SetPoint("TOPLEFT", window, "BOTTOMLEFT", 0, under)
		b:SetPoint("TOPRIGHT", window, "BOTTOMRIGHT", 0, under)
	end
	if journey then foldedHead(not foot and journeyStyle() == "folded", journey) end
	if layoutFoot(parts, b, journey and foot, journey) then
		dress(b, window)
		b:SetHeight(28)
		b:Show()
	elseif journey and not foot and isUnder(journey, window) then
		journey:SetParent(b)
		journey:ClearAllPoints()
		journey:SetPoint("TOPLEFT", b, "TOPLEFT", 0, 0)
		journey:SetPoint("TOPRIGHT", b, "TOPRIGHT", 0, 0)
		dress(b, window)
		b:SetHeight((journey:GetHeight() or 0) + 2)
		b:Show()
	else
		b:Hide()
	end
	-- One surface: no line where the window meets it. Theme.Border's edges
	-- (1 top, 2 bottom) and the house look's (psSkin.edge: 1 the light line
	-- inside the top, 2 the shade over it, 3 the shade under the bottom).
	local joined = b:IsShown()
	seam(window, b, joined)
	-- Its height for a host that shows the window whole (GF.Below).
	window.psBelow = joined and (b:GetHeight() - (own.bottomAt or 0)) or 0
end

-- The window's resize grip (16 a side, 1 in from the bottom right corner)
-- over the last part's foot: Atlas leaves 14 under it, not Polestar's
-- progress bar, so the grip takes the mouse over the corner 13 a side (its
-- glyph, 10, is drawn as it was); back to its own when Atlas leaves.
local GRIP_IN = 3
local gripWas
local function gripFits(on)
	local G = P.UI and P.UI.GuideFrame
	local grip = G and G.grip
	if not (grip and grip.SetHitRectInsets) then return end
	if on then
		if not gripWas then gripWas = { grip:GetHitRectInsets() } end
		grip:SetHitRectInsets(GRIP_IN, 0, GRIP_IN, 0)
	elseif gripWas then
		grip:SetHitRectInsets(unpack(gripWas))
		gripWas = nil
	end
end
onLeave(function() gripFits(false) end)

on("guideLayout", function(parts)
	if not parts.window then return end
	gripFits(true)
	local journey, foot = slots.journey, slots.journeyFoot
	layoutStack(parts)
	layoutBottom(parts, journey, foot)
end)

-- The folded header follows the leg you are on, once a second with the panel.
do
	local JP = journeyPanel()
	if JP and JP.Refresh and hooksecurefunc then
		hooksecurefunc(JP, "Refresh", function()
			if journeyStyle() == "folded" and Theme.LayoutId and Theme.LayoutId() == "atlas" then foldedHead(true) end
		end)
	end
end

-- The heads-up card stands on the stack, over the cards.
on("guideAnchor", function()
	local parts = Theme.GuideParts and Theme.GuideParts()
	local own = parts and parts.window and stores[parts.window]
	if own and own.stack and own.stack:IsShown() then return own.stack end
end)

-- The class quest card's own "Later" row: the × does it.
on("guideShows", function(what, shown, ...)
	if what == "classCardLater" then return false end
	if what == "bannerClose" and select(1, ...) == "away" then return false end
	return shown
end)

---------------------------------------------------------------------------
-- The step as a node on the timeline: its title in semibold with its area on
-- the right, one line per goal with its action icon, the live goal in
-- semibold with its count in the accent, each quest's level after it, an
-- objective's quest on the line under it, the counts in a column on the
-- right. The window's top bar fills as the guide goes.
---------------------------------------------------------------------------

local TITLE_PAD = 10
local TITLE_UP = 1 -- the step title over the goal lines, in px
-- Out of compact mode, air round the step's title: above it (AIR_TOP, under
-- the bars or the steps before) and between its line and the goals; the line
-- close under the title (AIR_UNDER). Compact mode keeps none of it. The room
-- over the title and between the title and its line are the player's out of
-- compact mode (guideWindow.stepSpace, titleSpace; Atlas's defaults AIR_TOP
-- and AIR_UNDER, spec.defaults).
local AIR_TOP, AIR_UNDER, AIR_LINE = 9, 4, 7
local LAST_DOWN = 3 -- the steps before, into the room over the title (see lastLines)

local function plainText(s) return ((s or ""):gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", "")) end

-- The step's title (guidePerson): the heading's state before Atlas changed
-- it is kept under _header, and given back when the layout leaves.
local function headerBack(person)
	local own = person and stores[person]
	local was = own and own._header
	if not was then return end
	own._header = nil
	person.Name:SetFont(was.font[1], was.font[2], was.font[3])
	person.Name:SetWordWrap(was.wrap)
	person.Name:ClearAllPoints()
	person.Name:SetPoint(unpack(was.name))
	person.Where:ClearAllPoints()
	person.Where:SetPoint(unpack(was.where))
	person.Where:SetJustifyH(was.justify)
	-- Polestar's own role for it (UI/GuideFrame.lua), so a later repaint
	-- keeps it: Theme.Font above gave the string the goal role.
	Theme.Font(person.Where, "small")
	person.Where:SetTextColor(Theme.Color("textDim"))
	if person.Icon then person.Icon:SetAlpha(1) end
end
onLeave(function(parts) headerBack(parts.person) end)

local function stepHeader(person, width)
	if not (person.Name and person.Where and person.Why) then return nil end
	local own = store(person)
	if not own._header then
		own._header = {
			font = { person.Name:GetFont() },
			wrap = person.Name:CanWordWrap(),
			name = { person.Name:GetPoint(1) },
			where = { person.Where:GetPoint(1) },
			justify = person.Where:GetJustifyH(),
		}
	end
	local _, goalSize, flags = probe("goal")
	local path = semibold() or own._header.font[1]
	person.Name:SetFont(path, math.floor((goalSize + TITLE_UP) * Core.scale("titleSize") + 0.5), flags)
	Theme.Font(person.Where, "goal")
	person.Where:SetTextColor(Theme.Color("textMuted"))
	person.Name:SetWordWrap(false)
	if person.Icon then person.Icon:SetAlpha(0) end
	-- The level line (gone from next since #3438) only where the window has one
	-- (rawget: the test client answers an unknown capitalised name with a method).
	local level = rawget(person, "Level")
	if level then level:Hide() end
	local pad = has("guideInset") and 11 or 14
	local full = not compact()
	local top = full and Core.gap("stepSpace", AIR_TOP) or TITLE_PAD
	local under = full and Core.gap("titleSpace", AIR_UNDER) + AIR_LINE or 8
	own.titleTop, own.lift = top, full and AIR_LINE or 0
	local whereW = 0
	if person.Where:IsShown() then
		whereW = math.min(person.Where:GetUnboundedStringWidth() + 1, math.floor(width * 0.45))
		person.Where:SetWidth(whereW)
		person.Where:SetJustifyH("RIGHT")
	end
	person.Name:ClearAllPoints()
	person.Name:SetPoint("TOPLEFT", person, "TOPLEFT", pad, -top)
	person.Name:SetWidth(width - (whereW > 0 and whereW + 10 or 0))
	-- The area sits on the title's row, at the right edge.
	if whereW > 0 then
		person.Where:ClearAllPoints()
		person.Where:SetPoint("TOP", person.Name, "TOP", 0, 0)
		person.Where:SetPoint("RIGHT", person, "RIGHT", -pad, 0)
		person.Where:SetPoint("BOTTOM", person.Name, "BOTTOM", 0, 0)
	end
	local h = top + person.Name:GetStringHeight()
	if person.Why:IsShown() then
		person.Why:SetWidth(width)
		person.Why:ClearAllPoints()
		person.Why:SetPoint("TOPLEFT", person.Name, "BOTTOMLEFT", 0, -3)
		h = h + 3 + person.Why:GetStringHeight()
	end
	if own.under then own.under:SetPoint("BOTTOMLEFT", person, "BOTTOMLEFT", 12, own.lift) end
	if own.under then own.under:SetPoint("BOTTOMRIGHT", person, "BOTTOMRIGHT", -12, own.lift) end
	return h + under
end
on("guidePerson", function(person, width) return stepHeader(person, width) end)

-- A line under the step's title.
local function underline(person)
	if not person then return end
	local own = store(person)
	if not own.under then
		own.under = person:CreateTexture(nil, "ARTWORK")
		own.under:SetTexture(Theme.Media("white"))
	end
	local r, g, b = Theme.Color("textMuted")
	own.under:ClearAllPoints()
	own.under:SetPoint("BOTTOMLEFT", person, "BOTTOMLEFT", 12, own.lift or 0)
	own.under:SetPoint("BOTTOMRIGHT", person, "BOTTOMRIGHT", -12, own.lift or 0)
	own.under:SetHeight(pixel(person))
	own.under:SetVertexColor(r, g, b, 0.35)
	own.under:SetShown(Core.on("rules"))
end
on("guideRender", function(view, parts) underline(parts.person) end)

-- A goal row (guideRow; Polestar paints the row again at every fill, so a
-- row keeps Atlas's look only while Atlas is the layout). The row's font
-- before Atlas is kept under _font, and the one Atlas gave it under _set: it
-- goes back only while the row still wears Atlas's (a font Polestar gave it
-- since, a text size changed, stays).
local function rowBack(row)
	local own = stores[row]
	if not own then return end
	if own._font then
		local set = own._set
		local path, size = row.Text:GetFont()
		if set and path == set[1] and size and math.abs(size - set[2]) < 0.05 then
			row.Text:SetFont(own._font[1], own._font[2], own._font[3])
		end
		own._font, own._set = nil, nil
	end
	if own.count then own.count:Hide() end
	row.psLevelWidth, row.psRightMin = nil, nil
	if own._single then
		row.Text:SetWordWrap(true)
		row.Text:SetMaxLines(2)
		own._single = nil
	end
	if row.Check then
		row.Check:SetAlpha(1)
		row.Check:Enable()
	end
end
onLeave(function(parts)
	for _, row in ipairs(parts.rows or {}) do
		rowBack(row)
		local own = stores[row]
		if own and own._alt then
			own._alt = nil
			if row.Alt then row.Alt:Show() end
		end
	end
end)

-- Sub-text `sub` without its line `line` (both as shown, colours aside):
-- nil when nothing is left.
local function dropLine(sub, line)
	local want, out = plainText(line), {}
	for l in (sub .. "\n"):gmatch("(.-)\n") do
		if plainText(l) ~= want then out[#out + 1] = l end
	end
	return #out > 0 and table.concat(out, "\n") or nil
end

-- The goal's spots line goes (the arrow leads through the spots); on the
-- rail the next-spot button goes too (a click on the arrow moves on).
local function spotsOff(row, goal, own)
	local area = Core.areaLine(goal)
	local sub = area and row.Sub and row.Sub:IsShown() and row.Sub:GetText() or nil
	if sub then
		local left = dropLine(sub, area)
		row.Sub:SetText(left or "")
		row.Sub:SetShown(left ~= nil)
	end
	own._alt = nil
	if row.Alt and row.Alt:IsShown() and has("guideInset") then
		row.Alt:Hide()
		own._alt = true
	end
end

local function goalRow(row, goal, info)
	local own = store(row)
	rowBack(row)
	spotsOff(row, goal, own)
	local text = row.Text:GetText() or ""
	local live = info.current and not info.done and not info.skipped
	-- Full size, up to two lines (a cut line hid the goal's end).
	local path, size, flags = row.Text:GetFont()
	if live and path and size then
		own._font = { path, size, flags }
		own._set = { semibold() or path, size }
		row.Text:SetFont(own._set[1], size, flags)
	end
	if live and goal.progress then
		text = text:gsub("|c%x%x%x%x%x%x%x%x(%d+/%d+)|r", "|c" .. Theme.Hex("accent") .. "%1|r")
	end
	if info.skipped or not goal.quest then
		row.Text:SetText(text)
		return
	end
	row.Text:SetText(text)
	-- An accept or a turn-in names its quest already. An objective: its quest
	-- on the line under it, with no level (#3438, #3876: the guide window
	-- shows no quest level anywhere).
	if goal.t == "accept" or goal.t == "turnin" then return end
	local title = Core.questTitle(goal.quest)
	if not (title and row.Sub) then return end
	local sub = row.Sub:IsShown() and row.Sub:GetText() or nil
	if sub and plainText(sub):find(title, 1, true) then return end
	row.Sub:SetText((sub and sub ~= "") and (title .. "\n" .. sub) or title)
	row.Sub:Show()
end

-- The count in a column on the right. The tick stays laid out (its room
-- keeps the column clear) but unseen and off.
local COUNT = "|c%x%x%x%x%x%x%x%x(%d+/%d+)|r"
-- Core leaves a lone 0/1 to the tick; with the tick gone it goes in the
-- column too ("Kill X for X's Skull" would show nothing).
local function oneCount(goal, info)
	local p = goal and goal.progress
	if info.skipped or type(p) ~= "table" or p.max ~= 1 then return nil end
	if p.kind == "skill" or p.kind == "rep" or p.kind == "wait" then return nil end
	local cur = (goal.status == "done" or (p.cur or 0) >= 1) and 1 or 0
	return cur .. "/1"
end

local function countColumn(row, goal, info)
	local own = store(row)
	if row.Check and row.Check:IsShown() then
		row.Check:SetAlpha(0)
		row.Check:Disable()
	end
	local text = row.Text:GetText() or ""
	local count = text:match(COUNT) or text:match("%s(%d+/%d+)%s*$")
	if count then
		text = text:gsub("%s*" .. COUNT, "", 1)
		if text == row.Text:GetText() then text = text:gsub("%s+%d+/%d+%s*$", "", 1) end
		row.Text:SetText(text)
	else
		count = oneCount(goal, info)
		if not count then return end
	end
	if not own.count then
		own.count = row:CreateFontString(nil, "OVERLAY")
		own.count:SetJustifyH("RIGHT")
	end
	local path, size, flags = row.Text:GetFont()
	own.count:SetFont(path, size, flags)
	own.count:SetText(count)
	if info.current and not info.done and not info.skipped then
		own.count:SetTextColor(Theme.Accent())
	else
		own.count:SetTextColor(Theme.Color(info.done and "textMuted" or "textDim"))
	end
	-- On the text's first line.
	local right = 14
	own.count:ClearAllPoints()
	own.count:SetPoint("TOP", row.Text, "TOP", 0, 0)
	own.count:SetPoint("RIGHT", row, "RIGHT", -right, 0)
	own.count:Show()
	-- The text wraps clear of the count.
	row.psRightMin = right + math.ceil(own.count:GetUnboundedStringWidth()) + 8
end

on("guideRow", function(row, goal, info)
	if not (row.Text and goal and info) then return end
	goalRow(row, goal, info)
	countColumn(row, goal, info)
end)

-- After the rows are laid out: "Other" (the next spot) in the count's
-- column, on the line under the count.
on("guideLayout", function(parts)
	for _, row in ipairs(parts.rows or {}) do
		local own = stores[row]
		local count = own and own.count
		local alt = row.Alt
		if row:IsShown() and alt and alt:IsShown() and alt.Icon then
			local inset = (alt:GetWidth() - alt.Icon:GetWidth()) / 2
			alt:ClearAllPoints()
			if count and count:IsShown() then
				alt:SetPoint("TOPRIGHT", count, "BOTTOMRIGHT", inset, -1)
			else
				alt:SetPoint("TOPRIGHT", row, "TOPRIGHT", -14 + inset, -2)
			end
		end
	end
end)

-- The top bar fills as the guide goes: a soft wash in the accent, a 2px
-- accent edge along its foot, in place of Polestar's bar under the window
-- (GF.Shows "progressFoot"); the progress bar setting turns it off. The
-- transparent window has no bar to fill.
on("guideProgress", function(foot, frac)
	local parts = Theme.GuideParts and Theme.GuideParts()
	local nav = parts and parts.nav
	if not (nav and parts.window and isUnder(foot, parts.window)) then return end
	local own = store(nav)
	if parts.window.psBare or not Core.on("progress") then
		if own.fill then own.fill:Hide(); own.edge:Hide() end
		return
	end
	if not own.fill then
		own.fill = nav:CreateTexture(nil, "BACKGROUND", nil, 2)
		own.fill:SetTexture(Theme.Media("white"))
		own.edge = nav:CreateTexture(nil, "ARTWORK")
		own.edge:SetTexture(Theme.Media("white"))
	end
	-- Inside the window's drawn frame: a kit's clear rim (Classic) left out
	-- where the bar meets the window's sides.
	local seam = seamOf(parts.window)
	local nl, wl = nav:GetLeft(), parts.window:GetLeft()
	local nr, wr = nav:GetRight(), parts.window:GetRight()
	local l = (nl and wl) and math.max(0, seam - (nl - wl)) or 0
	local rt = (nr and wr) and math.max(0, seam - (wr - nr)) or 0
	local w = math.max(0.01, ((nav:GetWidth() or 0) - l - rt) * math.min(1, math.max(0, tonumber(frac) or 0)))
	local r, g, b = Theme.Accent()
	own.fill:ClearAllPoints()
	local nt, wt = nav:GetTop(), parts.window:GetTop()
	local top = (nt and wt) and math.max(0, seam - (wt - nt)) or 0
	own.fill:SetPoint("TOPLEFT", nav, "TOPLEFT", l, -top)
	own.fill:SetPoint("BOTTOMLEFT", nav, "BOTTOMLEFT", l, 0)
	own.fill:SetWidth(w)
	own.fill:SetVertexColor(r, g, b, 0.10)
	own.edge:ClearAllPoints()
	own.edge:SetPoint("BOTTOMLEFT", nav, "BOTTOMLEFT", l, 0)
	own.edge:SetSize(w, 2 * pixel(nav))
	own.edge:SetVertexColor(r, g, b, 1)
	own.fill:Show()
	own.edge:Show()
end)

---------------------------------------------------------------------------
-- The rail: a line down the window's left from the steps before's nodes
-- (each a disc in the success colour once done, hollow when skipped; the
-- player's guideWindow.lastSteps, 1 by Atlas's default) through the current step's
-- (a disc in the accent) to the steps in Up next (hollow nodes, fainter
-- ahead).
-- The card and Up next are set in from it (guideInset); each Up next row is
-- its first goal on one line with its zone on the right (guideUpRow). The
-- "after" line is not shown: the rail shows the next step already. Only
-- where Polestar sets parts in (guideInset). In compact mode Polestar leaves
-- out the steps before and Up next, so the rail is the current step's node.
---------------------------------------------------------------------------

local CARD_X, UP_X, RAIL = 22, 13, 15 -- the card's and Up next's insets, the rail's x
local FADE = { 0.9, 0.65, 0.4 } -- the steps ahead, fainter further on

local function onRail() return has("guideInset") end

on("guideInset", function(name)
	if not onRail() then return nil end
	if name == "card" then return CARD_X end
	if name == "upnext" then return UP_X end
end)

-- Done goals stay in place. On the rail Up next shows its heading only while
-- folded (ui.upcomingOpen off), as the handle that opens it; open, its rows
-- stand on the rail without one.
on("guideShows", function(what, shown)
	if what == "done" then return true end
	if what == "progressFoot" then return false end
	if what == "markWash" then return true end
	-- The game looks' quest tracker band behind the title: Atlas's title has
	-- its own line under it (underline), the band's rods ran across the rail.
	if what == "kitHeader" then return false end
	-- A look's ornament in the window's top right corner (Waymark's compass
	-- rose): the step's place stands there, its muted text over the art.
	if what == "ornament" then return false end
	if what == "upnextHead" then return not onRail() or not Core.setting("ui.upcomingOpen") end
	return shown
end)

-- Up next's rows, in order.
local function upRows(frame)
	local rows = {}
	if not (frame and frame:IsShown()) then return rows end
	for _, r in ipairs({ frame:GetChildren() }) do
		if type(rawget(r, "Num")) == "table" and rawget(r, "psIndex") and r:IsShown() then rows[#rows + 1] = r end
	end
	table.sort(rows, function(a, b) return a.psIndex < b.psIndex end)
	return rows
end

-- A step's line on the rail: its first goal that is not a walk, in the
-- goal's words, and the zone it is in.
local function stepLine(v)
	local first, place
	for _, g in ipairs(v.goals or {}) do
		if g.status ~= "na" then
			if not place and g.map then place = Core.mapName(g.map) end
			if not first and g.t ~= "goto" then first = g end
		end
	end
	first = first or (v.goals and v.goals[1])
	return first and Core.goalText(first) or Core.stepSummary(v) or "", place
end

-- An Up next row (guideUpRow; Polestar sets the row again at every fill).
on("guideUpRow", function(row, v)
	if type(rawget(row, "Text")) ~= "table" then return end
	local own = store(row)
	if not onRail() then
		if own.zone then own.zone:Hide() end
		return
	end
	local text, place = stepLine(v or {})
	row.Text:SetText(text)
	row.Text:SetTextColor(Theme.Color("textDim"))
	row.Text:SetMaxLines(1)
	if not own.zone then
		own.zone = row:CreateFontString(nil, "OVERLAY")
		Theme.Font(own.zone, "label")
		own.zone:SetJustifyH("RIGHT")
		own.zone:SetWordWrap(false)
	end
	own.zone:SetText(place or "")
	own.zone:SetTextColor(Theme.Color("textMuted"))
	own.zone:ClearAllPoints()
	own.zone:SetPoint("RIGHT", row, "RIGHT", -14, 0) -- on its one line's middle
	own.zone:SetShown(place ~= nil)
	-- Shown or not as Polestar left it: hidden while Up next is folded.
end)

-- Up next's rows fade ahead; each text stops short of its zone. A row not
-- yet laid out (no width) takes Up next's width (`width`, from guidePlace);
-- with neither, its text keeps Polestar's width.
local function upFit(frame, width)
	local rows = upRows(frame)
	for i, r in ipairs(rows) do
		r:SetAlpha(onRail() and (FADE[i] or FADE[#FADE]) or 1)
		if onRail() then
			local zone = stores[r] and stores[r].zone
			local zw = (zone and zone:IsShown()) and math.min(zone:GetStringWidth() + 1, 110) or 0
			if zone then zone:SetWidth(zw) end
			local left = 59 -- Polestar's text column in the row
			local rw = r:GetWidth()
			if not (type(rw) == "number" and rw > 0) then rw = tonumber(width) end
			if rw and rw > 0 then r.Text:SetWidth(math.max(40, rw - left - 14 - (zw > 0 and zw + 8 or 0))) end
		end
	end
end
onLeave(function(parts) for _, r in ipairs(upRows(parts.upnext)) do r:SetAlpha(1) end end)

on("guidePlace", function(name, part, width)
	if name == "after" and onRail() then
		part:Hide()
		return true
	end
	if name == "upnext" then upFit(part, width) end
end)

-- A node: a disc, with a ring of the window's ground round it (the current
-- step) or a hollow middle (the steps ahead).
local function node(holder, key, parent)
	local n = holder[key]
	if n then return n end
	n = {}
	for i, part in ipairs({ "ring", "disc", "hole", "halo" }) do
		local t = parent:CreateTexture(nil, "OVERLAY", nil, part == "halo" and 0 or i)
		t:SetTexture(Theme.Media("circle"))
		n[part] = t
	end
	holder[key] = n
	return n
end

local function paintNode(n, current, alpha)
	local br, bg, bb = Theme.Color("bg")
	local size = current and 10 or 8
	n.ring:SetSize(size + 6, size + 6)
	n.ring:SetVertexColor(br, bg, bb, current and 1 or 0)
	n.halo:Hide()
	n.disc:SetSize(size, size)
	n.hole:SetSize(size - 2, size - 2)
	if current then
		local r, g, b = Theme.Accent()
		n.disc:SetVertexColor(r, g, b, 1)
		n.hole:SetVertexColor(0, 0, 0, 0)
	else
		local r, g, b = Theme.Color("textDim")
		n.disc:SetVertexColor(r, g, b, 0.42 * alpha)
		n.hole:SetVertexColor(br, bg, bb, 1)
	end
end

local function placeNode(n, rel, point, x, y)
	for _, part in ipairs({ "ring", "disc", "hole", "halo" }) do
		local t = n[part]
		t:ClearAllPoints()
		t:SetPoint("CENTER", rel, point, x, y)
		t:SetShown(part ~= "halo" or n.psAimed == true)
	end
end

local function hideNode(n)
	if n then n.ring:Hide(); n.disc:Hide(); n.hole:Hide(); n.halo:Hide() end
end

-- A step before's node: a filled disc in the success colour once done; a
-- skipped step's hollow, as a step not done.
local function paintPast(n, status)
	local br, bg, bb = Theme.Color("bg")
	n.ring:SetSize(14, 14)
	n.ring:SetVertexColor(br, bg, bb, 0)
	n.disc:SetSize(8, 8)
	n.hole:SetSize(6, 6)
	if status == "done" then
		local r, g, b = Theme.Color("success")
		n.disc:SetVertexColor(r, g, b, 0.85)
		n.hole:SetVertexColor(0, 0, 0, 0)
	else
		local r, g, b = Theme.Color("textMuted")
		n.disc:SetVertexColor(r, g, b, 0.6)
		n.hole:SetVertexColor(br, bg, bb, 1)
	end
end

-- The steps before (parts.last, guideWindow.lastSteps: Polestar fills its
-- Rows, oldest first, from the window's own step, and leaves them out in
-- compact mode and where no step comes before): on the rail, each row's
-- number, icon and text in Up next's columns, its first goal in the goal's
-- words, "skipped" after a skipped step. Polestar places them again at
-- every layout. -> the rows shown
local function lastLines(last, person)
	local rows = {}
	local n = tonumber(rawget(last, "psCount")) or 0
	local pool = rawget(last, "Rows")
	if type(pool) ~= "table" then return rows end
	for i = 1, n do
		local r = pool[i]
		if r and rawget(r, "psView") and rawget(r, "Text") and rawget(r, "Num") then rows[#rows + 1] = r end
	end
	if #rows == 0 then return rows end
	-- Up next's columns: the rows stand out of the card by the card's inset
	-- over Up next's.
	last:ClearAllPoints()
	-- Out of compact mode they stand LAST_DOWN lower, into the room over the
	-- title: their text as clear of the bars as of the title.
	local up = compact() and 0 or -LAST_DOWN
	last:SetPoint("BOTTOMLEFT", person, "TOPLEFT", -(CARD_X - UP_X), up)
	last:SetPoint("BOTTOMRIGHT", person, "TOPRIGHT", 0, up)
	local w = last:GetWidth()
	for _, r in ipairs(rows) do
		local text = stepLine(r.psView)
		if rawget(r, "psStatus") == "skipped" then
			text = text .. "  |c" .. Theme.Hex("textMuted") .. tr("skipped") .. "|r"
		end
		r.Text:SetText(text)
		r.Text:SetTextColor(Theme.Color("textDim"))
		if type(w) == "number" and w > 0 then r.Text:SetWidth(math.max(40, w - 59 - 14)) end
	end
	return rows
end

-- The arrow on the step's title: on the rail, a yellow edge round the
-- current node (the target bar's colour when the player set one) in place
-- of the target bar, whose texture is taken off; off the rail, the bar back.
local railNode = setmetatable({}, { __mode = "k" }) -- person -> current node
local railRows = setmetatable({}, { __mode = "k" }) -- person -> the window's goal rows
local rowPerson = setmetatable({}, { __mode = "k" }) -- goal row -> its window's person

-- Whether the arrow is on the step's title: on its person (the core's mark),
-- or on a step of "Go to" alone, where the core marks the goto row instead.
local function titleAimed(person)
	local mark = rawget(person, "Mark")
	if mark and mark:IsShown() then return true end
	if rawget(person, "psPerson") or rawget(person, "psHeaderGoal") then return false end
	local group = rawget(person, "psGroup")
	if group and (group.kind or "here") ~= "here" then return false end
	for _, r in ipairs(railRows[person] or {}) do
		local rm = rawget(r, "Mark")
		local goal = rawget(r, "psGoal")
		if rm and r:IsShown() and rm:IsShown() and goal and (goal.header or goal.t == "goto") then return true end
	end
	return false
end

local function edgeNode(person)
	local n = railNode[person]
	if not (n and rawget(person, "Mark") and n.ring:IsShown()) then return end
	-- Aimed: a ring of the arrow's colour round a gap of the window's ground
	-- round the disc, whatever the accent's hue; else the plain halo.
	local br, bg, bb = Theme.Color("bg")
	if titleAimed(person) then
		local c = aimColor()
		n.psAimed = true
		n.halo:SetSize(18, 18)
		n.halo:SetVertexColor(c[1], c[2], c[3], 1)
		n.halo:Show()
		n.ring:SetSize(14, 14)
	else
		n.psAimed = false
		n.halo:Hide()
		n.ring:SetSize(16, 16)
	end
	n.ring:SetVertexColor(br, bg, bb, 1)
end

-- On the rail the ring marks the step's title, not the core's light on the
-- person (GuideFrame.ShowMark makes it after the mark shows, so it is put out
-- after ShowMark); back with the mark when Atlas leaves.
local function personLit(person)
	local mark = rawget(person, "Mark")
	local lit = mark and rawget(mark, "psLit")
	if lit then lit:SetShown(not railNode[person] and mark:IsShown()) end
end
local litHooked

local function railMark(person, node)
	local mark = person and rawget(person, "Mark")
	if not mark then return end
	railNode[person] = node
	local G = frame()
	if not litHooked and G and G.ShowMark then
		litHooked = true
		hooksecurefunc(G, "ShowMark", function(r) if railNode[r] then personLit(r) end end)
	end
	personLit(person)
	if node then
		mark:SetTexture(nil)
		local own = store(person)
		if not own._edgeHooked then
			own._edgeHooked = true
			for _, m in ipairs({ "Show", "Hide", "SetShown" }) do
				hooksecurefunc(mark, m, function() if railNode[person] then edgeNode(person) end end)
			end
		end
		edgeNode(person)
	else
		mark:SetTexture(Theme.Media("white"))
	end
end
onLeave(function(parts) railMark(parts.person, nil) end)

-- The arrow on a goal row of the step is the core's mark (its light, guideShows
-- "markWash"); the title's ring follows it on a step of "Go to" alone, kept by
-- hooks on the row's mark.
local function rowAim(row)
	local person = rowPerson[row]
	if person and railNode[person] then edgeNode(person) end
end

on("guideLayout", function(parts)
	local person = parts.person
	local rows = {}
	for _, row in ipairs(parts.rows or {}) do
		local mark = rawget(row, "Mark")
		if mark and rawget(row, "Text") and not rawget(row, "_goal") then
			rows[#rows + 1] = row
			rowPerson[row] = person
			local own = store(row)
			if not own._aimHooked then
				own._aimHooked = true
				for _, m in ipairs({ "Show", "Hide", "SetShown" }) do
					hooksecurefunc(mark, m, function() rowAim(row) end)
				end
			end
			rowAim(row)
		end
	end
	if person then railRows[person] = rows end
end)
onLeave(function(parts)
	for _, row in ipairs(parts.rows or {}) do
		if rawget(row, "Text") and not rawget(row, "_goal") then
			rowPerson[row] = nil
		end
	end
	if parts.person then railRows[parts.person] = nil end
end)

-- The rail and its nodes, on a layer of Atlas's own over the window.
-- A row's step number on the rail: its column ends 2 px short of the node's
-- disc (8 wide, RAIL - UP_X from the row's left), the number right-aligned in
-- it, so a three-digit step shrinks (GuideFrame.FitNum) instead of reaching
-- the dot. Off the rail the column is Polestar's own again.
local function numColumn(r, on)
	local num, G = rawget(r, "Num"), frame()
	if not (num and G and G.FitNum) then return end
	-- The number is anchored by its left edge (Polestar's: PAD - 10 in, a
	-- 22 px column): on the rail that edge moves clear of the disc and the
	-- column keeps its 22 px, its right edge moving into the gap before the
	-- row's glyph (kept 3 px clear of it). A narrower column cut two digits
	-- to "...".
	local p, rel, rp, x, y = num:GetPoint(1)
	if not p then return end
	local clear = RAIL - UP_X + 4 + 2
	local col
	if on then
		if x < clear then
			num.psRailX = x
			num:SetPoint(p, rel, rp, clear, y)
			x = clear
		end
		col = 22
		local icon = rawget(r, "Icon")
		local ip, irel, _, ix = icon and icon:GetPoint(1)
		if ip == "LEFT" and irel == rel and ix then col = math.max(14, math.min(22, ix - 3 - x)) end
	elseif num.psRailX then
		num:SetPoint(p, rel, rp, num.psRailX, y)
		num.psRailX = nil
	end
	if num.psColumn ~= col then
		num.psColumn = col
		G.FitNum(r)
	end
end

local function rail(parts)
	local window, person = parts.window, parts.person
	local own = store(window)
	if not own.rail then
		own.rail = CreateFrame("Frame", nil, window)
		own.rail:SetAllPoints(window)
		own.rail.dots = {}
	end
	local layer = own.rail
	layer:SetFrameLevel(window:GetFrameLevel() + 8)
	local parent = person and person:GetParent()
	if not (onRail() and person and person:IsShown() and parent and parent:IsShown() and person.Name) then
		layer:Hide()
		railMark(person, nil)
		for _, r in ipairs(upRows(parts.upnext)) do numColumn(r, false) end
		for _, r in ipairs(rawget(parts.last or {}, "Rows") or {}) do numColumn(r, false) end
		return
	end
	layer:Show()
	local last = parts.last
	local past = (last and last:IsShown()) and lastLines(last, person) or {}
	if not layer.pasts then layer.pasts = {} end
	local top
	for i = 1, math.max(#past, #layer.pasts) do
		local pn = node(layer.pasts, i, layer)
		local r = past[i]
		if r then
			paintPast(pn, rawget(r, "psStatus"))
			numColumn(r, true)
			placeNode(pn, r, "LEFT", RAIL - UP_X, 0)
			top = top or pn.disc
		else
			hideNode(pn)
		end
	end
	local cn = node(layer, "cur", layer)
	paintNode(cn, true, 1)
	local titleTop = stores[person] and stores[person].titleTop or TITLE_PAD
	placeNode(cn, person, "TOPLEFT", RAIL - CARD_X, -(titleTop + person.Name:GetStringHeight() / 2))
	railMark(person, cn)
	local bottom = cn.disc
	-- "rail": the Journey's legs as nodes between the step and Up next.
	local jf
	if journeyStyle() == "rail" then
		for f in pairs(journeyFrames) do
			if f:IsShown() and isUnder(f, window) then jf = f end
		end
	end
	local JP = jf and journeyPanel(jf)
	local legRows = {}
	if jf and jf:IsShown() and isUnder(jf, window) and P.Get("nav.journeyOpen") then
		for _, r in ipairs(JP.rows) do
			if r:IsShown() then legRows[#legRows + 1] = r end
		end
	end
	if not layer.legs then layer.legs = {} end
	for i = 1, math.max(#legRows, #layer.legs) do
		local d = node(layer.legs, i, layer)
		local r = legRows[i]
		if r then
			paintNode(d, false, i == 1 and 1 or 0.7)
			placeNode(d, r, "TOPLEFT", RAIL, -12)
			bottom = d.disc
		else
			hideNode(d)
		end
	end
	local rows = upRows(parts.upnext)
	for i = 1, math.max(#rows, #layer.dots) do
		local d = node(layer.dots, i, layer)
		local r = rows[i]
		if r then
			paintNode(d, false, FADE[i] or FADE[#FADE])
			numColumn(r, true)
			placeNode(d, r, "LEFT", RAIL - UP_X, 0)
			bottom = d.disc
		else
			hideNode(d)
		end
	end
	if not layer.line then
		layer.line = layer:CreateTexture(nil, "ARTWORK")
		layer.line:SetTexture(Theme.Media("white"))
	end
	layer.line:SetWidth(pixel(layer))
	layer.line:ClearAllPoints()
	top = top or cn.disc
	layer.line:SetPoint("TOP", top, "CENTER", 0, 0)
	layer.line:SetPoint("BOTTOM", bottom, "CENTER", 0, 0)
	local r, g, b = Theme.Color("textMuted")
	layer.line:SetVertexColor(r, g, b, 0.35)
	layer.line:SetShown(bottom ~= top)
end
on("guideLayout", function(parts) if parts.window then rail(parts) end end)

---------------------------------------------------------------------------
-- The tip: a faint line over it and an "i" for its toggle, its text on one
-- line until opened. A step with more than one tip gets a pager on the
-- right ("1/2 ›"), where Polestar hands the tips over (Core.tipPages).
---------------------------------------------------------------------------

local tipPage = setmetatable({}, { __mode = "k" }) -- tip -> { list, at }

local function pager(tip)
	local own = store(tip)
	local pages = Core.tipPages(tip)
	-- Polestar's own pager, where it has one, stays.
	if not pages or rawget(tip, "Pager") then
		if own.pager then own.pager:Hide() end
		tipPage[tip] = nil
		return
	end
	local state = tipPage[tip]
	if not state or state.list ~= pages then
		state = { list = pages, at = 1 }
		tipPage[tip] = state
	end
	if not own.pager then
		local b = CreateFrame("Button", nil, tip)
		b:SetSize(36, 16)
		b.Label = b:CreateFontString(nil, "OVERLAY")
		b.Label:SetPoint("RIGHT", b, "RIGHT", 0, 0)
		b.Label:SetJustifyH("RIGHT")
		b:SetScript("OnClick", function()
			local s = tipPage[tip]
			if not s then return end
			s.at = s.at % #s.list + 1
			tip.Text:SetText(s.list[s.at])
			Core.relayout()
		end)
		b:SetScript("OnEnter", function(self) self.Label:SetTextColor(Theme.Color("text")) end)
		b:SetScript("OnLeave", function(self) self.Label:SetTextColor(Theme.Color("textMuted")) end)
		own.pager = b
	end
	local b = own.pager
	Theme.Font(b.Label, "small")
	b.Label:SetTextColor(Theme.Color("textMuted"))
	b.Label:SetText(state.at .. "/" .. #pages .. " \226\128\186")
	b:ClearAllPoints()
	b:SetPoint("TOPRIGHT", tip, "TOPRIGHT", -12, -4)
	b:Show()
end

local function tipLook(tip, on)
	local own = store(tip)
	if not own.rule then
		own.rule = tip:CreateTexture(nil, "ARTWORK")
		own.rule:SetTexture(Theme.Media("white"))
	end
	own.rule:SetShown(on and Core.on("rules"))
	local icon = tip.Toggle and tip.Toggle.Icon
	if not on then
		if own.pager then own.pager:Hide() end
		if icon then icon:SetTexture(Theme.Media(Core.tipOpen(tip) and "chevron-up" or "chevron-down")) end
		return
	end
	if icon then icon:SetTexture(Theme.Media(Theme.Icon and Theme.Icon("info") or "info")) end
	own.rule:ClearAllPoints()
	own.rule:SetPoint("TOPLEFT", tip, "TOPLEFT", 11, 0)
	own.rule:SetPoint("TOPRIGHT", tip, "TOPRIGHT", -12, 0)
	own.rule:SetHeight(pixel(tip))
	local r, g, b = Theme.Color("textMuted")
	own.rule:SetVertexColor(r, g, b, 0.35)
	pager(tip)
end
onLeave(function(parts) if parts.tip then tipLook(parts.tip, false) end end)

on("guidePlace", function(name, part)
	if name == "tip" then tipLook(part, true) end
end)

---------------------------------------------------------------------------
-- The XP row: "Level 4 · 62% · " before Polestar's own line (its pace and
-- the time to the next level), a star in the accent for its icon.
---------------------------------------------------------------------------

local function xpBack(xp)
	local own = xp and stores[xp]
	if not (own and own.atlas) then return end
	own.atlas = nil
	local line = Core.xpLine(xp)
	if line then xp.Text:SetText(line) end
	xp.Icon:SetTexture(Theme.Media("icon-level"))
	xp.Icon:SetVertexColor(Theme.Color("textMuted"))
	local pts = own.points
	if pts then
		xp.Icon:ClearAllPoints()
		xp.Icon:SetPoint(unpack(pts.icon))
		xp.Text:ClearAllPoints()
		for _, p in ipairs(pts.text) do xp.Text:SetPoint(unpack(p)) end
		own.points = nil
	end
end

local function xpLook(xp)
	if not (xp.Text and xp.Icon) then return end
	store(xp).atlas = true
	local head = {}
	-- The level and its percent are the XP tracker's: not while it is off,
	-- nor while the XP line is (guideWindow.xpLine, #3304).
	local Q = Polestar.QoL
	if Core.on("xpLine") and Q and Q.GetXPStats and Q.GetXPStats() then
		local level = UnitLevel and UnitLevel("player")
		local cur, max = UnitXP and UnitXP("player"), UnitXPMax and UnitXPMax("player")
		if type(level) == "number" and level > 0 then head[#head + 1] = string.format(tr("Level %d"), level) end
		if type(cur) == "number" and type(max) == "number" and max > 0 then head[#head + 1] = math.floor(cur / max * 100) .. "%" end
	end
	local line = Core.xpLine(xp)
	if line then head[#head + 1] = line end
	xp.Text:SetText(table.concat(head, "  \194\183  "))
	xp.Icon:SetTexture(Theme.Media("star"))
	xp.Icon:SetVertexColor(Theme.Accent())
	-- On the timeline's columns: the star on the rail, the text under the
	-- step's title (stepHeader's inset in the card).
	if has("guideInset") then
		local own = store(xp)
		if not own.points then
			local text = {}
			for i = 1, xp.Text:GetNumPoints() do text[i] = { xp.Text:GetPoint(i) } end
			own.points = { icon = { xp.Icon:GetPoint(1) }, text = text }
		end
		-- 2px under the row's middle: with the row's 2px more height
		-- (xpRowHeight) the line clears the rule over it. Boosted Rest's line
		-- under it (the row grows by XPROW.restH, GF.XPHeight) lifts the text
		-- by half that, so the two stand where one would and Rest stays in
		-- the row. Worked out each layout: a point kept from a row with Rest
		-- shown held the lift after Rest went, and the other way round.
		local G = frame()
		local lift = xp.psRest and G and G.XPROW and G.XPROW.restH / 2 or 0
		local iy = -2 + lift
		xp.Icon:ClearAllPoints()
		xp.Icon:SetPoint("CENTER", xp, "LEFT", RAIL, iy)
		xp.Text:ClearAllPoints()
		xp.Text:SetPoint("LEFT", xp, "LEFT", CARD_X + 11, iy)
		xp.Text:SetPoint("RIGHT", xp, "RIGHT", -OPT_PAD, iy)
	end
end

-- The XP row is handed over by name only (guidePlace): the layout leaving a
-- window gives the ones it saw in that window their own look back.
local seenXp = setmetatable({}, { __mode = "k" })
on("guidePlace", function(name, part)
	if name == "xp" then
		seenXp[part] = true
		xpLook(part)
	end
end)
onLeave(function(parts, live)
	for xp in pairs(seenXp) do
		if Core.leaves(xp, parts, live) then xpBack(xp) end
	end
end)

---------------------------------------------------------------------------
-- Air: out of compact mode the current step stands clear (a taller tip
-- further under the goals; the title's air is the step header's) and the XP
-- row holds its lines with no room to spare: Atlas's defaults for the
-- player's gaps (spec.defaults: guideWindow.tipSpace, tipPadding,
-- xpRowHeight), which Polestar takes out of compact mode only. The rail
-- rows, the gap under Up next and the Journey keep Polestar's own.
---------------------------------------------------------------------------

-- The XP line's room on the rail (xpLook: from the card's text column to the
-- row's right padding), so the row takes its second line when the whole of
-- it wraps.
on("guideSpace", function(name, px, width)
	-- A look's lit card on the goal to do now (Theme.KitRowLit) fills the
	-- row as Atlas's own wash does: the layout sets where it stands.
	if name == "litInset" then return 0 end
	if name ~= "xpRoom" or not (has("guideInset") and type(width) == "number" and width > 0) then return nil end
	return math.max(1, width - (CARD_X + 11) - OPT_PAD)
end)

---------------------------------------------------------------------------
-- Compact mode: the current step only. Polestar's own compact mode drops Up
-- next, the steps before, the tip, Along the way (Still to do with it), the
-- XP row and the Journey; Atlas keeps the rail's one node, the tip (its strip
-- at the card's foot), the cards above the window, the XP row and the
-- Journey (in its style, as out of compact mode).
---------------------------------------------------------------------------

local KEEP = { tip = true, along = true, xp = true, journey = true }

on("guideShows", function(what, shown)
	if KEEP[what] and compact() then return true end
	return shown
end)

on("guidePlace", function(name, part)
	if compact() and name == "upnext" then
		part:Hide()
		return true
	end
end)

---------------------------------------------------------------------------
-- Registration
---------------------------------------------------------------------------

local FIRST = { guidePlace = true, guideTakes = true, guideInset = true, guidePerson = true, guideAnchor = true, guideSpace = true }

local function join(name, list)
	if name == "guideShows" then
		return function(what, shown, ...)
			for i = 1, #list do shown = list[i](what, shown, ...) end
			return shown
		end
	elseif name == "guideLayout" then
		return function(...)
			local room = 0
			for i = 1, #list do
				local v = list[i](...)
				if type(v) == "number" then room = room + v end
			end
			return room
		end
	elseif FIRST[name] then
		return function(...)
			for i = 1, #list do
				local v = list[i](...)
				if v ~= nil and v ~= false then return v end
			end
			return nil
		end
	end
	return function(...)
		for i = 1, #list do list[i](...) end
	end
end

-- The hooks a layout may set (docs/skins/reference.md, "Layouts"). The
-- title bar, the goal rows and the progress came later: a Polestar that
-- refuses them gets the layout without them.
local LAYOUT_HOOKS = { guideLayout = true, guideRender = true, guidePlace = true, guideAnchor = true, guideTakes = true,
	guidePerson = true, guideInset = true, guideUpRow = true, guideShows = true }
local LATER_HOOKS = { guideTitle = true, guideRow = true, guideProgress = true }
-- The gaps came later still: a Polestar without them keeps its own.
local SPACE = Theme.HasCapability("surfaces.guideSpace")

local function hooksOf(withLater)
	local hooks = {}
	for _, name in ipairs(order) do
		if (LAYOUT_HOOKS[name] or (withLater and LATER_HOOKS[name]) or (name == "guideSpace" and SPACE)) and has(name) then
			hooks[name] = join(name, chains[name])
		end
	end
	return hooks
end

local function spec(hooks)
	return {
		api = 2,
		name = "Atlas",
		addon = ADDON,
		author = "TTik3r",
		desc = "The step on a timeline, Up next on a rail that fades ahead, cards above the window.",
		hooks = hooks,
		-- The J2 look's starting point. The player's own choices win; a
		-- reset returns to these.
		defaults = {
			["guideWindow.tabs"] = true,
			["guideWindow.tabStyle"] = "strip",
			["guideWindow.reportButton"] = false,
			-- Up next starts open on the rail; folded, the rail shows its heading.
			["ui.upcomingOpen"] = true,
			["guideWindow.allStepsButton"] = true,
			["guideWindow.lastSteps"] = 1,
			["guideWindow.stepNumberSize"] = 0.75,
			["guideWindow.journeyStyle"] = "folded",
			["guideWindow.bannerLinks"] = "right",
			-- The step card's air out of compact mode, each gap's whole size in
			-- px: over the title, between it and its line, over the tip, round
			-- the tip's text, the XP row's line.
			["guideWindow.stepSpace"] = AIR_TOP,
			["guideWindow.titleSpace"] = AIR_UNDER,
			["guideWindow.tipSpace"] = 9,
			["guideWindow.tipPadding"] = 8,
			["guideWindow.xpRowHeight"] = 26,
		},
		-- Its card in the guide window's Presets, beside Polestar's own:
		-- picking it chooses this layout only; the skin stays the player's.
		-- A Polestar without layout presets gets the layout without it.
		preset = Theme.HasCapability("layouts.preset") and {
			label = "Atlas",
			help = "The step on a timeline, Up next on a rail, cards above the window.",
			set = {},
		} or nil,
		-- Under another layout: Polestar's own parts get their look back; the
		-- pieces Atlas made itself hide.
		-- Called once for each guide window Atlas dressed (the live one, then
		-- each copy drawing with the layout in use), with that window's
		-- parts: its parts get their look back and the pieces Atlas made in
		-- it hide. The live window's call also hides the pieces outside any
		-- guide window (the cards above it).
		onLeave = function(_, parts, live)
			if parts == nil and live ~= false then
				parts, live = Theme.GuideParts and Theme.GuideParts(), true
			end
			if parts then
				for _, fn in ipairs(leaving) do fn(parts, live) end
			end
			for f, s in pairs(stores) do
				if Core.leaves(f, parts, live) then hideAll(s) end
			end
		end,
	}
end

local ok, message = Theme.RegisterLayout("atlas", spec(hooksOf(true)))
if not ok and tostring(message):find("is a skin's", 1, true) then
	ok, message = Theme.RegisterLayout("atlas", spec(hooksOf(false)))
end
check("layout atlas", ok, message)
