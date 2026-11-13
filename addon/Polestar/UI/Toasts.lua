-- Alerts & toasts: how each of Polestar's toasts looks and moves. The
-- options page and its previews are in the settings window's addon
-- (Polestar_Options, UI/Looks/Toasts.lua: Options > Look > Alerts & toasts).
--
-- The toasts: the rare alert (Rares/Toast.lua), the transport banner and
-- Polestar's notices in it (Nav/Alerts.lua), the "While you're here" toast
-- (UI/WhileHere.lua), the heads-up card on the guide window for a class
-- quest or a dungeon (UI/ClassToast.lua, UI/DungeonToast.lua), and the class
-- quest card inside the guide window (UI/ClassCard.lua). Each builds its
-- frame and hands it here (TS.Attach) with its title and body strings; from
-- then on its scale, opacity, type sizes, ground, border and entrance follow
-- toasts.<kind>.* live, and a change re-lays it out. While you're here has
-- no look of its own (`shared`): it wears the theme and the shared toast
-- style, its settings only how long it stays and its place. The first three can
-- line up (toasts.stack): one under the other (or above, growth "up") from
-- the alert line's place (toasts.stackPoint), `spacing` apart, at most
-- `max` at once (the oldest goes). Once a look is applied, the skin in use
-- has its say: its card hook (the two cards) or its toast hook (the rest),
-- Skin API 2 (docs/skins/reference.md).
--
--   UI.Toasts.Get(kind, prop)              a toasts.<kind>.<prop> setting
--   UI.Toasts.Scale(kind), .Alpha(kind)
--   UI.Toasts.Attach(kind, frame, { titles, bodies, accents, relayout(frame), hide, sandbox, noScale, inline, shared })
--   UI.Toasts.ApplyLook(frame[, relayout])
--   UI.Toasts.Enter(kind, frame, dy, dur[, fromAlpha[, alphaDur]])   its entrance (slide, fade or none)
--   UI.Toasts.Leave(kind, frame, dy, dur, done)
--   UI.Toasts.Place(kind, frame, own) -> true when the alert line placed it
--   UI.Toasts.Stacked(kind), .StackAnchor(), .Line()
--   UI.Toasts.PaintGround(frame, get)      a ground, border at get("bgAlpha" | "bg" | "border" | "borderSize")
--
-- The previews (Polestar_Options) draw the toasts' own builders in a sandbox
-- (TS.Attach with `sandbox`): a sandbox toast is repainted when it shows.

local _, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local floor, max, min, type, ipairs, pairs, tonumber = math.floor, math.max, math.min, type, ipairs, pairs, tonumber

local TS = {}
UI.Toasts = TS

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
	whilehere = { seconds = 8, point = false },
	-- seconds 0: the card stays until answered. place: "above" the guide
	-- window, "below" it or "free" (its own spot, pos { point, x, y }, Move
	-- frames); compact: one line (UI/ClassToast.lua).
	headsup = look({ seconds = 0, place = "above", compact = false, pos = false }),
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

-- The cards on the guide window (the heads-up card, the class quest card)
-- go to a skin's card hook, the rest to its toast hook (Skin API 2).
local CARDS = { headsup = true, classcard = true }

-- What a skin's hook gets of a toast (made the first time one hooks it):
-- the strings Polestar sizes as titles and bodies, and the regions it
-- colours in the accent.
local function skinParts(t)
	local p = t.parts
	if not p then
		p = { titles = t.titles, bodies = t.bodies, accents = t.accents or {} }
		t.parts = p
	end
	return p
end

function TS.ApplyLook(frame, relayout)
	local t = frame and frame.psToast
	if not t then return end
	local kind = t.kind
	if Theme.SetFontScale and not t.shared then
		local tk, bk = num(kind, "titleSize", 0.6, 2), num(kind, "bodySize", 0.6, 2)
		for _, fs in ipairs(t.titles) do Theme.SetFontScale(fs, tk) end
		for _, fs in ipairs(t.bodies) do Theme.SetFontScale(fs, bk) end
	end
	if t.shared then
		-- The theme's look and the shared toast style: nothing of its kind's.
		frame:SetScale(frame.psFit or 1)
		frame.psBgAlpha = nil
		Theme.Repaint(frame)
		if frame:IsShown() and not Anim.IsRunning(frame, "alpha") then frame:SetAlpha(1) end
	elseif not t.inline then
		-- A sandbox copy a settings preview places keeps the scale it gave it
		-- (psBandScale): a repaint (a new UI scale) leaves it where it stands.
		if not t.noScale or t.sandbox then frame:SetScale(frame.psBandScale or TS.Scale(kind) * (frame.psFit or 1)) end
		paintGround(frame, kind)
		paintAccents(frame, kind, t.accents)
		if frame:IsShown() and not Anim.IsRunning(frame, "alpha") then frame:SetAlpha(TS.Alpha(kind)) end
	end
	if relayout and t.relayout then t.relayout(frame) end
	-- The skin in use's own touch, over Polestar's look (its card or toast hook).
	local hook = CARDS[kind] and "card" or "toast"
	if Theme.SkinHooks and Theme.SkinHooks(hook) then Theme.SkinHook(hook, frame, kind, skinParts(t)) end
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
		anchor = CreateFrame("Frame", "PolestarToastLine", ns.UIParent)
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
		noScale = opts.noScale, inline = opts.inline, shared = opts.shared,
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
-- A shared toast's motion is the shared style's: slide, at speed 1, to full.
local function sharedLook(frame) return frame.psToast and frame.psToast.shared end

-- Its entrance: slide (dy UI units from above, below when the line grows up)
-- while it fades in, fade only, or none; at the player's speed, to the
-- player's opacity.
function TS.Enter(kind, frame, dy, dur, fromAlpha, alphaDur)
	local shared = sharedLook(frame)
	local style = not shared and TS.Get(kind, "enter") or "slide"
	local speed = shared and 1 or speedOf(kind)
	local a = shared and 1 or TS.Alpha(kind)
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
	local shared = sharedLook(frame)
	local style = not shared and TS.Get(kind, "enter") or "slide"
	dur = (dur or Anim.FAST) / (shared and 1 or speedOf(kind))
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
		keys = { "toasts.stackPoint" },
		settings = "toasts.stack",
	}
end

ns.OnLogin(function()
	local M = ns.Movers
	if M and M.Register then M.Register(TS.MoverSpec()) end
end)
