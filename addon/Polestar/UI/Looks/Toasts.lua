-- Alerts & toasts: how each of Polestar's toasts looks and moves, and the
-- options page for them (Options > Look > Alerts & toasts, key `alerts`).
--
-- The toasts: the rare alert (Rares/Toast.lua), the transport banner and
-- Polestar's notices in it (Nav/Alerts.lua), the "While you're here" toast
-- (UI/WhileHere.lua), the heads-up card on the guide window for a class
-- quest or a dungeon (UI/ClassToast.lua, UI/DungeonToast.lua), and the class
-- quest card inside the guide window (UI/ClassCard.lua). Each builds its
-- frame and hands it here (TS.Attach) with its title and body strings; from
-- then on its scale, opacity, type sizes, ground, border and entrance follow
-- toasts.<kind>.* live, and a change re-lays it out. The first three can
-- line up (toasts.stack): one under the other (or above, growth "up") from
-- the alert line's place (toasts.stackPoint), `spacing` apart, at most
-- `max` at once (the oldest goes).
--
--   UI.Toasts.Get(kind, prop)              a toasts.<kind>.<prop> setting
--   UI.Toasts.Scale(kind), .Alpha(kind)
--   UI.Toasts.Attach(kind, frame, { titles, bodies, accents, relayout(frame), hide, sandbox, noScale, inline })
--   UI.Toasts.ApplyLook(frame[, relayout])
--   UI.Toasts.Enter(kind, frame, dy, dur[, fromAlpha[, alphaDur]])   its entrance (slide, fade or none)
--   UI.Toasts.Leave(kind, frame, dy, dur, done)
--   UI.Toasts.Place(kind, frame, own) -> true when the alert line placed it
--   UI.Toasts.Stacked(kind), .StackAnchor(), .Line()
--   UI.Toasts.Preview(view, tab)           the options' pinned preview (sandbox toasts)
--   UI.Toasts.PaintGround(frame, get)      a ground, border at get("bgAlpha" | "bg" | "border" | "borderSize")
--   UI.Toasts.NewStage(view), .FitInto(stage, frame, w, h, scale)   a preview's stage (the trackers' too)
--
-- Previews draw the toasts' own builders in a sandbox (Rares.Toast.NewCard,
-- Nav.alerts.NewBanner, WhileHereToast.NewCard, ClassToast.NewCard,
-- ClassCard.NewCard) fed made-up content: no event, no waypoint, no sound
-- unless the player presses Play. Nothing is built before the page shows;
-- nothing runs while it is hidden (a change then is applied when it shows).

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local floor, max, min, format, type, ipairs, pairs, tonumber = math.floor, math.max, math.min, string.format, type, ipairs, pairs, tonumber

local TS = {}
UI.Toasts = TS

local NEW = "0.3.7"
local KINDS = { "rare", "transport", "whilehere", "headsup" }
TS.KINDS = KINDS
-- The toasts near the top of the screen, which may line up.
local STACKED = { rare = true, transport = true, whilehere = true }
local DEFAULT_LINE = { "TOP", "TOP", 0, -72 }

local function look(extra)
	local t = { scale = 1, alpha = 1, enter = "slide", speed = 1, titleSize = 1, bodySize = 1, bgAlpha = 1, bg = false, border = false, borderSize = 0 }
	for k, v in pairs(extra or {}) do t[k] = v end
	return t
end

local DEFAULTS = {
	rare = look(),
	-- The banner fades in (it always did); `linger`: seconds it stays after the arrival.
	transport = look({ enter = "fade", linger = 6, point = false }),
	whilehere = look({ seconds = 8, accent = false, point = false }),
	-- seconds 0: the card stays until answered.
	headsup = look({ seconds = 0 }),
	classcard = { shine = true, glow = 1, stripe = 4, note = true, titleSize = 1, bodySize = 1 },
	stack = false, growth = "down", spacing = 8, max = 3, stackPoint = false,
}
ns.RegisterDefaults("toasts", DEFAULTS)

function TS.Get(kind, prop)
	local v = ns.Get("toasts." .. kind .. "." .. prop)
	if v == nil then
		local d = DEFAULTS[kind]
		v = type(d) == "table" and d[prop] or nil
	end
	return v
end

local function num(kind, prop, lo, hi)
	local d = DEFAULTS[kind]
	local v = tonumber(TS.Get(kind, prop)) or (type(d) == "table" and d[prop]) or 1
	return min(hi, max(lo, v))
end

function TS.Scale(kind) return num(kind, "scale", 0.4, 2.5) end
function TS.Alpha(kind) return num(kind, "alpha", 0.1, 1) end

local function rgba(v)
	if type(v) == "table" and tonumber(v[1]) then return v[1], v[2] or 0, v[3] or 0, tonumber(v[4]) or 1 end
	return nil
end

---------------------------------------------------------------------------
-- The look on a toast
---------------------------------------------------------------------------

local attached = setmetatable({}, { __mode = "k" }) -- frame -> kind
local dirty = setmetatable({}, { __mode = "k" }) -- sandbox frames to repaint when they show

-- The ground at the player's opacity (a share of the windows' own), their
-- colour over the scheme's, and a border of their colour and thickness.
-- get(prop): the surface's bgAlpha, bg, border and borderSize (the trackers
-- use it too, UI/Looks/Trackers.lua).
function TS.PaintGround(frame, get)
	local k = min(1, max(0, tonumber(get("bgAlpha")) or 1))
	frame.psBgAlpha = k ~= 1 and Theme.GroundAlpha() * k or nil
	Theme.Repaint(frame)
	local d = frame.psSkin
	local r, g, b = rgba(get("bg"))
	if r and d and d.bg and d.bg:IsShown() then d.bg:SetVertexColor(r, g, b, frame.psBgAlpha or Theme.GroundAlpha()) end
	local br, bg, bb, ba = rgba(get("border"))
	local size = floor(min(6, max(0, tonumber(get("borderSize")) or 0)) + 0.5)
	if br or size > 0 then
		if not br then br, bg, bb, ba = Theme.Color("windowBorder") end
		if size < 1 then
			local _, own = Theme.WindowBorder()
			size = own or 1
		end
		Theme.Border(frame, br, bg, bb, ba or 1, nil, size)
		for _, e in ipairs(frame.psBorder or {}) do e:Show() end
	end
end

local function paintGround(frame, kind)
	TS.PaintGround(frame, function(prop) return TS.Get(kind, prop) end)
end

-- Regions in the accent that take the player's colour instead.
local function paintAccents(frame, kind, list)
	if not list then return end
	local r, g, b = rgba(TS.Get(kind, "accent"))
	for _, region in ipairs(list) do
		if r then
			W.Uncolor(region)
			if region.SetTextColor then region:SetTextColor(r, g, b, 1) else region:SetVertexColor(r, g, b, 1) end
		else
			W.Color(region, "accent")
		end
	end
end

function TS.ApplyLook(frame, relayout)
	local t = frame and frame.psToast
	if not t then return end
	local kind = t.kind
	if Theme.SetFontScale then
		local tk, bk = num(kind, "titleSize", 0.6, 2), num(kind, "bodySize", 0.6, 2)
		for _, fs in ipairs(t.titles) do Theme.SetFontScale(fs, tk) end
		for _, fs in ipairs(t.bodies) do Theme.SetFontScale(fs, bk) end
	end
	if not t.inline then
		if not t.noScale or t.sandbox then frame:SetScale(TS.Scale(kind) * (frame.psFit or 1)) end
		paintGround(frame, kind)
		paintAccents(frame, kind, t.accents)
		if frame:IsShown() and not Anim.IsRunning(frame, "alpha") then frame:SetAlpha(TS.Alpha(kind)) end
	end
	if relayout and t.relayout then t.relayout(frame) end
end

local function refresh(frame, relayout)
	local t = frame.psToast
	if t.sandbox and not frame:IsVisible() then
		dirty[frame] = true
		return
	end
	TS.ApplyLook(frame, relayout)
end

---------------------------------------------------------------------------
-- The alert line (toasts.stack)
---------------------------------------------------------------------------

local line, anchor = {}, nil

local function stackOn() return ns.Get("toasts.stack") and true or false end
function TS.Stacked(kind) return STACKED[kind] and stackOn() or false end
function TS.Line() return line end

local function placeAnchor()
	local p = ns.Get("toasts.stackPoint")
	if type(p) ~= "table" or type(p[1]) ~= "string" then p = DEFAULT_LINE end
	anchor:ClearAllPoints()
	anchor:SetPoint(p[1], UIParent, p[2] or p[1], tonumber(p[3]) or 0, tonumber(p[4]) or 0)
end

-- The line's place: an empty frame the toasts hang from (the movers move it).
function TS.StackAnchor()
	if not anchor then
		anchor = CreateFrame("Frame", "PolestarToastLine", UIParent)
		anchor:SetSize(320, 8)
		placeAnchor()
	end
	return anchor
end

local function lineIndex(frame)
	for i, f in ipairs(line) do if f == frame then return i end end
	return nil
end

-- Toasts in `list` hung one from the other from `from`, growing down or up,
-- `gap` UI units apart (whatever each one's scale).
local function hang(list, from, up, gap)
	local prev
	for _, f in ipairs(list) do
		f.psGrowUp = up or nil
		local s = f:GetScale()
		if s <= 0 then s = 1 end
		if up then
			if prev then Anim.Anchor(f, "BOTTOM", prev, "TOP", 0, gap / s) else Anim.Anchor(f, "BOTTOM", from, "BOTTOM", 0, 0) end
		else
			if prev then Anim.Anchor(f, "TOP", prev, "BOTTOM", 0, -gap / s) else Anim.Anchor(f, "TOP", from, "TOP", 0, 0) end
		end
		prev = f
	end
end

local function spacing() return min(60, max(0, tonumber(ns.Get("toasts.spacing")) or 8)) end
local function growsUp() return ns.Get("toasts.growth") == "up" end

local function layoutLine()
	if not stackOn() or #line == 0 then return end
	hang(line, TS.StackAnchor(), growsUp(), spacing())
end

-- At most `max` at once: the oldest goes the way it goes by itself.
local function trim()
	local most = floor(min(5, max(1, tonumber(ns.Get("toasts.max")) or 3)))
	while #line > most do
		local oldest = table.remove(line, 1)
		local t = oldest.psToast
		if t and t.hide then t.hide(oldest) else oldest:Hide() end
	end
end

local function join(frame)
	if not TS.Stacked(frame.psToast.kind) or lineIndex(frame) then return end
	line[#line + 1] = frame
	trim()
	layoutLine()
end

local function leave(frame)
	local i = lineIndex(frame)
	if not i then return end
	table.remove(line, i)
	frame.psGrowUp = nil
	layoutLine()
end

-- Stacking turned on or off: the toasts on screen join the line in the order
-- they came, or go back to their own places.
local function restack()
	if stackOn() then
		if anchor then placeAnchor() end
		for frame, kind in pairs(attached) do
			if STACKED[kind] and not frame.psToast.sandbox and frame:IsShown() and not lineIndex(frame) then line[#line + 1] = frame end
		end
		trim()
		layoutLine()
		return
	end
	local was = line
	line = {}
	for _, f in ipairs(was) do
		f.psGrowUp = nil
		if f.psOwnPlace then f.psOwnPlace() end
	end
end

-- Where a toast goes as it shows: its place in the line while they stack
-- (-> true), else nothing here (-> false: its own place, own()).
function TS.Place(kind, frame, own)
	frame.psOwnPlace = own
	if not TS.Stacked(kind) or not frame.psToast then
		frame.psGrowUp = nil
		return false
	end
	if not lineIndex(frame) then
		line[#line + 1] = frame
		trim()
	end
	layoutLine()
	return true
end

function TS.Attach(kind, frame, opts)
	opts = opts or {}
	frame.psToast = {
		kind = kind, titles = opts.titles or {}, bodies = opts.bodies or {}, accents = opts.accents,
		relayout = opts.relayout, hide = opts.hide, sandbox = opts.sandbox and true or false,
		noScale = opts.noScale, inline = opts.inline,
	}
	attached[frame] = kind
	if opts.sandbox then
		frame:HookScript("OnShow", function(self)
			if dirty[self] then
				dirty[self] = nil
				TS.ApplyLook(self, true)
			end
		end)
	elseif STACKED[kind] then
		frame:HookScript("OnShow", join)
		frame:HookScript("OnHide", leave)
	end
	TS.ApplyLook(frame)
end

---------------------------------------------------------------------------
-- Entrances
---------------------------------------------------------------------------

local function speedOf(kind) return num(kind, "speed", 0.25, 4) end

-- Its entrance: slide (dy UI units from above, below when the line grows up)
-- while it fades in, fade only, or none; at the player's speed, to the
-- player's opacity.
function TS.Enter(kind, frame, dy, dur, fromAlpha, alphaDur)
	local style = TS.Get(kind, "enter")
	local speed = speedOf(kind)
	local a = TS.Alpha(kind)
	dur = (dur or Anim.BASE) / speed
	alphaDur = (alphaDur or dur * speed) / speed
	if frame.psGrowUp then dy = -dy end
	if style == "none" then
		if frame.psAnchor then Anim.To(frame, "offset", 0, 0, 0) end
		Anim.To(frame, "alpha", a, a, 0)
	elseif style == "fade" then
		if frame.psAnchor then Anim.To(frame, "offset", 0, 0, 0) end
		Anim.To(frame, "alpha", fromAlpha or 0, a, alphaDur, "out")
	else
		Anim.To(frame, "alpha", fromAlpha or 0, a, alphaDur, "out")
		if frame.psAnchor then Anim.To(frame, "offset", dy, 0, dur, "out") end
	end
end

-- Its way out, the entrance's kind; done(frame) at the end.
function TS.Leave(kind, frame, dy, dur, done)
	local style = TS.Get(kind, "enter")
	dur = (dur or Anim.FAST) / speedOf(kind)
	if frame.psGrowUp then dy = -dy end
	if style == "none" then
		Anim.To(frame, "alpha", 0, 0, 0, nil, done)
		return
	end
	if style ~= "fade" and frame.psAnchor then Anim.To(frame, "offset", 0, dy, dur, "out") end
	Anim.To(frame, "alpha", frame:GetAlpha(), 0, dur, "out", done)
end

---------------------------------------------------------------------------
-- Live changes
---------------------------------------------------------------------------

local stages = setmetatable({}, { __mode = "k" }) -- preview stages -> true
local markStages

ns.On("SETTING_CHANGED", function(path)
	if path ~= "" and path ~= "toasts" and path:sub(1, 7) ~= "toasts." then return end
	local kind, prop = path:match("^toasts%.([^.]+)%.?(.*)$")
	if kind and type(DEFAULTS[kind]) == "table" then
		if prop == "point" then return end
		for frame, k in pairs(attached) do
			if k == kind then refresh(frame, true) end
		end
		layoutLine()
	elseif kind == "stackPoint" then
		if anchor then placeAnchor() end
	elseif kind then
		restack()
	else
		for frame in pairs(attached) do refresh(frame, true) end
		if anchor then placeAnchor() end
		restack()
	end
	markStages()
end)

-- A theme change repaints the windows' grounds: the toasts' own go back on.
Theme.OnChanged(function()
	for frame in pairs(attached) do refresh(frame, false) end
end)

---------------------------------------------------------------------------
-- The movers (positions are theirs: UI/Movers.lua registers each toast's own
-- place); the alert line's place is registered here, shown while it is on.
---------------------------------------------------------------------------

function TS.MoverSpec()
	return {
		key = "toastLine", label = L["Alert line"],
		frame = function() return stackOn() and TS.StackAnchor() or nil end,
		enabled = stackOn,
		size = function() return 320, 60 end,
		get = function()
			local p = ns.Get("toasts.stackPoint")
			if type(p) ~= "table" or type(p[1]) ~= "string" then p = DEFAULT_LINE end
			return p[1], p[2] or p[1], tonumber(p[3]) or 0, tonumber(p[4]) or 0
		end,
		set = function(point, rel, x, y) ns.Set("toasts.stackPoint", { point, rel or point, floor((x or 0) + 0.5), floor((y or 0) + 0.5) }) end,
		reset = function() ns.Set("toasts.stackPoint", nil) end,
	}
end

ns.OnLogin(function()
	local M = ns.Movers
	if M and M.Register then M.Register(TS.MoverSpec()) end
end)

---------------------------------------------------------------------------
-- Previews
---------------------------------------------------------------------------

local STAGE_H = 210
local SOUND_HERE = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Sounds\\while-here.ogg"

local function classChime()
	local CC = UI.ClassCard
	if ns.Get("ui.classCardSound") and CC and CC.GameSoundOn() and PlaySound then
		pcall(PlaySound, (SOUNDKIT and SOUNDKIT.IG_QUEST_LIST_COMPLETE) or 878, "SFX")
	end
end

-- Play: each toast's own sound, when it is on.
local SOUNDS = {
	rare = function()
		local R = ns.Rares
		if R and R.PlaySound then R.PlaySound() end
	end,
	transport = function()
		local A = ns.Nav and ns.Nav.alerts
		if ns.Get("nav.alertSound") and A and A.SOUND and PlaySoundFile then PlaySoundFile(A.SOUND.boat, "Master") end
	end,
	whilehere = function()
		if ns.Get("behavior.whileHereSound") and PlaySoundFile then PlaySoundFile(SOUND_HERE, "SFX") end
	end,
	headsup = classChime,
	classcard = classChime,
}

-- The made-up content each preview shows.
local function demoRare()
	local Lv = ns.Levels
	local p = Lv and Lv.Player and Lv.Player() or {}
	return { kind = "rare", id = 61, name = L["Thuros Lightfingers"], level = max(1, p.level or 10), elite = false, yards = 85,
		zone = L["Elwynn Forest"], map = 1429, x = 50, y = 50, source = "preview" }
end

local function demoHeadsUp()
	local LT = UI.LevelTip
	local m = { icon = Theme.Media("icon-dungeon"), iconColor = "dungeon", titleColor = "text" }
	m.head = format(L["LEVEL %d · DUNGEON"], 18)
	m.title = format(L["%s is open to you"], L["The Deadmines"])
	m.giver = format(L["%d quests to pick up"], 4) .. "  \194\183  " .. L["Westfall"]
	if LT and LT.Text then m.badge = LT.Text(1.4):upper() end
	m.act = { label = L["Pick up the quests"] }
	m.more = { label = L["Open in Dungeons"] }
	m.off = { label = L["Turn these off"] }
	return m
end

local function demoClassCard()
	local p = ns.Levels and ns.Levels.Player and ns.Levels.Player() or {}
	local class = p.class or "WARLOCK"
	local name = UI.ClassName and UI.ClassName(class) or class
	return { class = class, head = format(L["%s · LEVEL %d"], name:upper(), 10), title = L["The Binding"],
		learn = format(L["Learn %s"], L["Summon Voidwalker"]), badge = L["NEW PET"], icon = Theme.Media("icon-learn"),
		trip = L["Durotar"] .. "  \226\128\186  " .. L["Orgrimmar"] .. "  \194\183  " .. format(L["%d steps"], 4) }
end

-- The sandbox toast of each kind, built into `parent` and painted. -> frame
-- (nil: its module is not loaded), its own width and height.
local BUILD = {
	rare = function(parent)
		local T = ns.Rares and ns.Rares.Toast
		if not (T and T.NewCard) then return nil end
		local c = T.NewCard(parent)
		T.FillCard(c, demoRare())
		return c
	end,
	transport = function(parent)
		local A = ns.Nav and ns.Nav.alerts
		if not (A and A.NewBanner) then return nil end
		local c = A.NewBanner(parent)
		A.FillBanner(c, false, format(L["Boat to %s"], L["Menethil Harbor"]), format(L["Arrives in %s"], "0:24"), 0.8)
		return c
	end,
	whilehere = function(parent)
		local T = UI.WhileHereToast
		if not (T and T.NewCard) then return nil end
		local c = T.NewCard(parent)
		T.FillCard(c, { t = "kill", hereText = format(L["Kill %s"], L["Kobold Vermin"]) .. "  8/10", yards = 50 })
		return c
	end,
	headsup = function(parent)
		local T = UI.ClassToast
		if not (T and T.NewCard) then return nil end
		local c = T.NewCard(parent)
		T.FillCard(c, demoHeadsUp(), 340)
		return c
	end,
}

-- The relayout the toast's own look does after a change of type size, then
-- the card's paint for its demo again (a sandbox heads-up keeps its width).
local REFILL = {
	headsup = function(c) local T = UI.ClassToast; if T and c.psModel then T.FillCard(c, c.psModel, 340) end end,
}

local function newStage(view)
	local s = CreateFrame("Frame", nil, view)
	s:SetHeight(STAGE_H)
	if s.SetClipsChildren then s:SetClipsChildren(true) end
	-- The world under the toast: the deepest ground and the night's lift.
	W.Fill(s, "scrim", "BACKGROUND", -8)
	W.Painter(s, function(self) Theme.Border(self, Theme.Wash("divider")) end)
	-- The options window draws "Preview" and "Live" over it, with this
	-- caption: how much it had to shrink the toast to fit, or why it is empty.
	s.caption = function() return s.psNote end
	s.psWidth = 600
	stages[s] = true
	s:SetScript("OnShow", function(self)
		if self.psDirty then
			self.psDirty = nil
			self:Refresh()
		end
	end)
	return s
end

function markStages()
	for s in pairs(stages) do
		if s:IsVisible() then s:Refresh() else s.psDirty = true end
	end
end

-- Fit a toast of size w x h (its own units) at its scale into the stage's
-- area under the label; says so when it had to shrink it.
local function fitInto(s, card, kind, w, h, scale)
	local availW, availH = s.psWidth - 64, STAGE_H - 84
	local k = scale or TS.Scale(kind)
	local fit = min(1, availW / max(1, w * k), availH / max(1, h * k))
	card.psFit = fit
	card:SetScale(k * fit)
	Anim.Anchor(card, "CENTER", s, "CENTER", 0, 0)
	s.psNote = (fit < 0.995 and format(L["Shown at %d%% to fit"], floor(fit * 100 + 0.5)) or "")
end

TS.NewStage = newStage
TS.STAGE_H = STAGE_H
function TS.FitInto(s, frame, w, h, k) fitInto(s, frame, nil, w, h, k) end

-- One toast kind's stage: its sandbox toast, Play (the entrance again, and
-- the sound when it is on).
local function toastStage(view, kind)
	local s = newStage(view)
	local card = BUILD[kind](s)
	s.Card = card
	if not card then
		s.psNote = (L["Not loaded"])
		function s:Refresh() end
		function s:Layout(width)
			self:SetWidth(width)
			self.psWidth = width
			return STAGE_H
		end
		return s
	end
	card:Show()
	card:SetAlpha(TS.Alpha(kind))
	function s:Refresh()
		local fill = REFILL[kind]
		TS.ApplyLook(card, true)
		if fill then fill(card) end
		fitInto(self, card, kind, card:GetWidth(), card:GetHeight())
		if not Anim.IsRunning(card, "alpha") then card:SetAlpha(TS.Alpha(kind)) end
	end
	s.Play = W.Button(s, L["Play"], function()
		TS.Enter(kind, card, kind == "headsup" and card:GetHeight() or 18, kind == "transport" and Anim.FAST or Anim.SLOW * 1.5)
		local play = SOUNDS[kind]
		if play then play() end
	end, { height = 22 })
	s.Play:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", -12, 10)
	function s:Layout(width)
		self:SetWidth(width)
		self.psWidth = width
		self:Refresh()
		return STAGE_H
	end
	return s
end

-- The class quest card on a guide window's ground, as the guide window draws it.
local CARD_W = 360
local function classCardStage(view)
	local s = newStage(view)
	local CC = UI.ClassCard
	if not (CC and CC.NewCard) then
		s.psNote = (L["Not loaded"])
		function s:Refresh() end
		function s:Layout(width) self:SetWidth(width) self.psWidth = width return STAGE_H end
		return s
	end
	local ground = CreateFrame("Frame", nil, s)
	ground.psGuide = true
	Theme.Skin(ground, "window")
	local card = CC.NewCard(ground)
	s.Card, s.Ground = card, ground
	local demo = demoClassCard()
	-- Its type sizes, as the guide window's card has them.
	TS.Attach("classcard", card, { titles = { card.Title }, bodies = { card.Head, card.Learn, card.Trip, card.Only }, inline = true, sandbox = true })
	function s:Refresh()
		TS.ApplyLook(card)
		local h = CC.FillDemo(card, demo, CARD_W)
		ground:SetSize(CARD_W, h)
		local fit = min(1, (self.psWidth - 64) / CARD_W, (STAGE_H - 84) / max(1, h))
		ground:SetScale(fit)
		ground:ClearAllPoints()
		ground:SetPoint("CENTER", self, "CENTER", 0, 0)
		self.psNote = (fit < 0.995 and format(L["Shown at %d%% to fit"], floor(fit * 100 + 0.5)) or "")
	end
	s.Play = W.Button(s, L["Play"], function()
		if CC.Shine then CC.Shine(card) end
		classChime()
	end, { height = 22 })
	s.Play:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", -12, 10)
	function s:Layout(width)
		self:SetWidth(width)
		self.psWidth = width
		self:Refresh()
		return STAGE_H
	end
	return s
end

-- The alert line: the three toasts near the top of the screen, lined up as
-- the stacking settings line them (or apart, each at its own size, when off).
local function lineStage(view)
	local s = newStage(view)
	local box = CreateFrame("Frame", nil, s)
	local top = CreateFrame("Frame", nil, box)
	top:SetSize(1, 1)
	local cards = {}
	for _, kind in ipairs({ "rare", "transport", "whilehere" }) do
		local c = BUILD[kind](box)
		if c then
			c:Show()
			c.psKind = kind
			cards[#cards + 1] = c
		end
	end
	s.Cards = cards
	function s:Refresh()
		local up, gap = growsUp(), spacing()
		local most = floor(min(5, max(1, tonumber(ns.Get("toasts.max")) or 3)))
		local list, wMax, hSum = {}, 1, 0
		for i, c in ipairs(cards) do
			c.psFit = nil
			TS.ApplyLook(c, true)
			local fill = REFILL[c.psKind]
			if fill then fill(c) end
			c:SetShown(i <= most)
			if i <= most then
				list[#list + 1] = c
				local k = c:GetScale()
				wMax = max(wMax, c:GetWidth() * k)
				hSum = hSum + c:GetHeight() * k
			end
		end
		hSum = hSum + gap * max(0, #list - 1)
		box:SetSize(wMax, hSum)
		top:ClearAllPoints()
		top:SetPoint(up and "BOTTOM" or "TOP", box, up and "BOTTOM" or "TOP", 0, 0)
		hang(list, top, up, gap)
		local fit = min(1, (self.psWidth - 64) / wMax, (STAGE_H - 84) / max(1, hSum))
		box:SetScale(fit)
		box:ClearAllPoints()
		box:SetPoint("CENTER", self, "CENTER", 0, 0)
		self.psNote = ((stackOn() and "" or L["Off: each alert keeps its own place."] .. "  ")
			.. (fit < 0.995 and format(L["Shown at %d%% to fit"], floor(fit * 100 + 0.5)) or ""))
	end
	s.Play = W.Button(s, L["Play"], function()
		for i, c in ipairs(cards) do
			if c:IsShown() then
				c:SetAlpha(0)
				ns.After((i - 1) * 0.25, function() TS.Enter(c.psKind, c, 18, Anim.SLOW * 1.5) end)
			end
		end
	end, { height = 22 })
	s.Play:SetPoint("BOTTOMRIGHT", s, "BOTTOMRIGHT", -12, 10)
	function s:Layout(width)
		self:SetWidth(width)
		self.psWidth = width
		self:Refresh()
		return STAGE_H
	end
	return s
end

-- tab: "rare" | "transport" | "whilehere" | "headsup" | "classcard" | "line"
function TS.Preview(view, tab)
	if tab == "classcard" then return classCardStage(view) end
	if tab == "line" then return lineStage(view) end
	return toastStage(view, tab)
end

---------------------------------------------------------------------------
-- The options page
---------------------------------------------------------------------------

if not ns.RegisterOptions then return end

local PAGE = L["Alerts & toasts"]
local function pct(v) return floor(v * 100 + 0.5) .. "%" end
local function secs(v) return format(L["%d s"], floor(v + 0.5)) end
local function px(v) return format(L["%d px"], floor(v + 0.5)) end

local function register(spec)
	spec.page, spec.key, spec.icon, spec.order, spec.group = PAGE, "alerts", "info", 26, "look"
	local ok, err = ns.RegisterOptions(spec)
	if not ok and geterrorhandler then geterrorhandler()(err) end
end

-- The look rows every toast has: size, opacity, type, ground, border, motion.
local function lookSections(tab, kind, what, opts)
	opts = opts or {}
	local k = "toasts." .. kind .. "."
	local sections = {}
	sections[#sections + 1] = { section = L["Size and opacity"], controls = {
		{ kind = "slider", key = k .. "scale", label = L["Scale"], min = 0.5, max = 2, step = 0.05, format = pct, new = NEW,
			help = format(L["The whole %s, larger or smaller. Right-click to reset."], what) .. (opts.scaleNote or ""),
			search = "size, bigger, larger, smaller, scale, huge, tiny, zoom, " .. what },
		{ kind = "slider", key = k .. "alpha", label = L["Opacity"], min = 0.2, max = 1, step = 0.05, format = pct, new = NEW,
			help = format(L["How solid the %s is, text and all."], what),
			search = "opacity, transparency, alpha, see through, faint, fade, " .. what },
	} }
	sections[#sections + 1] = { section = L["Text"], controls = {
		{ kind = "slider", key = k .. "titleSize", label = L["Title size"], min = 0.7, max = 1.6, step = 0.05, format = pct, new = NEW,
			help = L["The size of its title against Polestar's text size."],
			search = "font size, title, heading, bigger text, smaller text, readability, " .. what },
		{ kind = "slider", key = k .. "bodySize", label = L["Text size"], min = 0.7, max = 1.6, step = 0.05, format = pct, new = NEW,
			help = L["The size of its other lines against Polestar's text size."],
			search = "font size, body, lines, bigger text, smaller text, readability, " .. what },
	} }
	if not opts.inline then
		local ground = {
			{ kind = "slider", key = k .. "bgAlpha", label = L["Background opacity"], min = 0, max = 1, step = 0.05, format = pct, new = NEW,
				help = L["Its background against every Polestar window's (Theme). 0 leaves the text on the world."],
				search = "background, backing, ground, transparent, see through, opacity, " .. what },
			{ kind = "color", key = k .. "bg", label = L["Background colour"], new = NEW,
				help = L["Its own background colour. Right-click to go back to the theme's."],
				search = "background colour, backing, ground, tint, " .. what,
				shown = function() return Theme.Color("bg") end, source = function() return L["Theme"] end },
			{ kind = "color", key = k .. "border", label = L["Border colour"], new = NEW,
				help = L["A border of its own colour, even with the windows' border off. Right-click to go back to the theme's."],
				search = "border, outline, edge, frame colour, " .. what,
				shown = function() return Theme.Color("windowBorder") end, source = function() return L["Theme"] end },
			{ kind = "slider", key = k .. "borderSize", label = L["Border thickness"], min = 0, max = 4, step = 1, new = NEW,
				format = function(v) return v < 0.5 and L["The theme's"] or px(v) end,
				help = L["In screen pixels; 0 follows the windows' border."],
				search = "border, thickness, width, outline, edge, " .. what },
		}
		if opts.accent then
			ground[#ground + 1] = { kind = "color", key = k .. "accent", label = L["Accent colour"], new = NEW,
				help = L["Its edge, glyph and heading. Right-click to go back to the accent."],
				search = "accent, colour, highlight, edge, " .. what,
				shown = function() return Theme.Accent() end, source = function() return L["Accent"] end }
		end
		sections[#sections + 1] = { section = L["Background and border"], controls = ground }
		sections[#sections + 1] = { section = L["Motion"], controls = {
			{ kind = "dropdown", key = k .. "enter", label = L["Entrance"], new = NEW,
				help = L["How it comes in: slides into place as it fades in, only fades in, or simply appears. Reduce motion (Theme) keeps slides to a fade."],
				search = "animation, slide, fade, pop, motion, appear, entrance, " .. what,
				choices = { { value = "slide", label = L["Slide in"] }, { value = "fade", label = L["Fade in"] }, { value = "none", label = L["Appear"] } } },
			{ kind = "slider", key = k .. "speed", label = L["Animation speed"], min = 0.25, max = 3, step = 0.25, format = pct, new = NEW,
				help = L["Faster or slower than Polestar's own pace."],
				search = "animation speed, slow, fast, quick, motion, " .. what,
				disabled = function() return TS.Get(kind, "enter") == "none" end },
		} }
	end
	for i, sec in ipairs(sections) do
		sec.tab = tab
		register(sec)
	end
end

local function raresOff() return not (ns.Get("rares.enabled") and ns.Get("rares.alerts")) end
local function rareSounds()
	local out = {}
	for i, s in ipairs(ns.Rares and ns.Rares.SOUNDS or {}) do out[i] = { value = s.value, label = s.label } end
	return out
end

-- Rare alert
local RARE = L["Rare alert"]
register({ tab = RARE, section = L["Rare alert"], preview = function(view) return TS.Preview(view, "rare") end,
	subtitle = L["How Polestar's alerts and cards look, move and sound: the rare alert, the transport banner, While you're here, the heads-ups and the class quest card. Press Play to see one come in."],
	controls = {
		{ kind = "toggle", key = "rares.alerts", label = L["Alert for rares"], disabled = function() return not ns.Get("rares.enabled") end,
			search = "rare alert, rare spawn, notification, warning, popup",
			help = L["A card with its name, level and distance, and a waypoint to it."], needs = function() return ns.Rares end },
		{ kind = "toggle", key = "rares.treasureAlerts", label = L["Alert for treasures"], disabled = raresOff, child = true,
			help = L["Treasures the client marks on the minimap."], needs = function() return ns.Rares end },
		{ kind = "slider", key = "rares.toastSeconds", label = L["Alert stays for"], min = 5, max = 60, step = 1, format = secs, disabled = raresOff,
			search = "duration, how long, seconds, time on screen, stays, timeout",
			help = L["Hovering the alert holds it."], needs = function() return ns.Rares end },
		{ kind = "toggle", key = "rares.combatAlerts", label = L["Alert during combat"], disabled = raresOff,
			search = "combat, fight, in combat, visibility",
			help = L["Off: an alert waits for the fight to end, if the rare was seen in the last minute."], needs = function() return ns.Rares end },
	} })
register({ tab = RARE, section = L["Sound"], controls = {
	{ kind = "toggle", key = "rares.sound", label = L["Play a sound"], disabled = raresOff, search = "sound, audio, chime, ding, alert sound",
		help = L["One sound with each alert."], needs = function() return ns.Rares end },
	{ kind = "dropdown", key = "rares.soundKit", label = L["Sound"], choices = rareSounds, child = true, search = "sound, audio, which sound",
		disabled = function() return raresOff() or not ns.Get("rares.sound") end,
		help = L["Played through the Master channel."], needs = function() return ns.Rares end },
} })
lookSections(RARE, "rare", L["rare alert"])

-- Transport alert
local TRANSPORT = L["Transport alert"]
local function transportOff() return not ns.Get("nav.alerts") end
register({ tab = TRANSPORT, section = L["Transport alert"], preview = function(view) return TS.Preview(view, "transport") end, controls = {
	{ kind = "toggle", key = "nav.alerts", label = L["Transport alerts"],
		search = "boat, ship, zeppelin, tram, transport, departure, arrival, warning",
		help = L["Before your boat, zeppelin or tram comes in: 30 seconds ahead at the dock, 20 before the next stop on board. Never for lifts or in combat."] },
	{ kind = "toggle", key = "nav.alertBanner", label = L["Show a banner"], disabled = transportOff, child = true,
		help = L["A small card near the top of the screen with a countdown. Click it to dismiss."] },
	{ kind = "slider", key = "toasts.transport.linger", label = L["Stays after the arrival"], min = 0, max = 30, step = 1, format = secs, new = NEW,
		disabled = function() return transportOff() or not ns.Get("nav.alertBanner") end, child = true,
		help = L["How long the banner stays once the boat, zeppelin or tram is in. Click it to dismiss it sooner."],
		search = "duration, how long, seconds, time on screen, linger, stays, banner" },
	{ kind = "toggle", key = "nav.alertSound", label = L["Play the transport's sound"], disabled = transportOff,
		search = "sound, audio, bell, horn",
		help = L["The ship's bell, the zeppelin's horn or the tram, on the Master channel so you hear it with the game in the background."] },
	{ kind = "toggle", key = "nav.alertFlash", label = L["Flash the taskbar icon"], disabled = transportOff,
		search = "flash, taskbar, background, alt tab",
		help = L["The game's icon flashes while the game is in the background."] },
} })
lookSections(TRANSPORT, "transport", L["transport banner"])

-- While you're here
local HERE = L["While you're here"]
register({ tab = HERE, section = L["While you're here"], preview = function(view) return TS.Preview(view, "whilehere") end, controls = {
	{ kind = "slider", key = "toasts.whilehere.seconds", label = L["Stays for"], min = 3, max = 30, step = 1, format = secs, new = NEW,
		help = L["How long the toast stays while the guide window is hidden. Hovering it holds it."],
		search = "duration, how long, seconds, time on screen, stays, timeout, while you're here, dynamic questing",
		disabled = function() return not ns.Get("behavior.whileHere") end },
	{ kind = "toggle", key = "behavior.whileHereSound", label = L["Sound for a new suggestion"],
		help = L["A soft chime for each new suggestion (once when several come together), at the game's sound effects volume."],
		search = "chime, sound, audio, ding, alert",
		disabled = function() return not ns.Get("behavior.whileHere") end },
} })
lookSections(HERE, "whilehere", L["While you're here toast"], { accent = true })

-- Heads-up card
local HEADS = L["Heads-up card"]
register({ tab = HEADS, section = L["Heads-up card"], preview = function(view) return TS.Preview(view, "headsup") end, controls = {
	{ kind = "slider", key = "toasts.headsup.seconds", label = L["Goes by itself after"], min = 0, max = 120, step = 5, new = NEW,
		format = function(v) return v < 1 and L["Never"] or secs(v) end,
		help = L["The card for a class quest or a dungeon that opened up stays on the guide window until you answer it; set a time and it goes by itself, as Later does."],
		search = "duration, how long, seconds, dismiss, timeout, class quest, dungeon, heads up" },
	{ kind = "toggle", key = "dungeons.headsUp", label = L["Tell me when a dungeon opens up"],
		help = L["A card on the guide window when a dungeon's quests open to you."],
		search = "dungeon, heads up, notification, card", disabled = function() return not ns.Get("dungeons.enabled") end },
	{ kind = "toggle", key = "ui.classCardSound", label = L["Class quest chime"],
		disabled = function() return not (UI.ClassCard and UI.ClassCard.GameSoundOn()) end,
		search = "sound, chime, audio, class quest",
		help = L["A short chime the first time a class quest chain's card shows. Off while the game's sound effects are off."] },
} })
lookSections(HEADS, "headsup", L["heads-up card"], { scaleNote = " " .. L["It sits on the guide window, at the window's scale times this."] })

-- Class quest card
local CARD = L["Class quest card"]
register({ tab = CARD, section = L["Class quest card"], preview = function(view) return TS.Preview(view, "classcard") end, controls = {
	{ kind = "slider", key = "toasts.classcard.glow", label = L["Glow"], min = 0, max = 2, step = 0.1, format = pct, new = NEW,
		help = L["The class colour's soft glow across the card."],
		search = "glow, class colour, brightness, highlight, class quest card" },
	{ kind = "slider", key = "toasts.classcard.stripe", label = L["Stripe"], min = 0, max = 10, step = 1, new = NEW,
		format = function(v) return v < 0.5 and L["Off"] or px(v) end,
		help = L["The class colour's stripe down its left edge."],
		search = "stripe, edge, bar, class colour, thickness, class quest card" },
	{ kind = "toggle", key = "toasts.classcard.shine", label = L["Shine the first time"], new = NEW,
		help = L["A band of light crosses the card the first time a chain's card shows."],
		search = "shine, animation, flash, sparkle, motion, class quest card" },
	{ kind = "toggle", key = "toasts.classcard.note", label = L["Say it's your class's quest"], new = NEW,
		help = L["The line under the trip: only you see the card, and the guide carries the quest."],
		search = "note, only you see this, text, line, hint, class quest card" },
	{ kind = "toggle", key = "ui.classCardSound", label = L["Class quest chime"],
		disabled = function() return not (UI.ClassCard and UI.ClassCard.GameSoundOn()) end,
		search = "sound, chime, audio, class quest",
		help = L["A short chime the first time a class quest chain's card shows. Off while the game's sound effects are off."] },
} })
lookSections(CARD, "classcard", L["class quest card"], { inline = true })

-- Stacking
local LINE = L["Stacking"]
register({ tab = LINE, section = L["The alert line"], preview = function(view) return TS.Preview(view, "line") end, controls = {
	{ kind = "toggle", key = "toasts.stack", label = L["Line up the alerts"], new = NEW,
		help = L["The rare alert, the transport banner and While you're here line up one under the other from one place, instead of each at its own place where they can overlap. Move the line in unlock mode (/polestar unlock)."],
		search = "stack, stacking, line up, overlap, column, list, grow, anchor, position" },
	{ kind = "dropdown", key = "toasts.growth", label = L["New alerts go"], new = NEW, child = true,
		disabled = function() return not stackOn() end,
		help = L["Down: the line hangs from its top and grows down. Up: it stands on its bottom and grows up."],
		search = "growth, direction, grow up, grow down, stack direction",
		choices = { { value = "down", label = L["Below"] }, { value = "up", label = L["Above"] } } },
	{ kind = "slider", key = "toasts.spacing", label = L["Spacing"], min = 0, max = 40, step = 1, format = px, new = NEW, child = true,
		disabled = function() return not stackOn() end,
		help = L["The gap between two alerts in the line."],
		search = "spacing, gap, padding, distance, stack" },
	{ kind = "slider", key = "toasts.max", label = L["At most"], min = 1, max = 3, step = 1, new = NEW, child = true,
		format = function(v) return format(L["%d at once"], floor(v + 0.5)) end,
		disabled = function() return not stackOn() end,
		help = L["How many alerts the line shows at once; a new one sends the oldest away."],
		search = "maximum, max shown, how many, limit, stack" },
} })
