-- The layer hop window (QoL/Layer.lua; opt in, qol.layerHop): the layer you
-- are on, the hop and the world refresh in progress, the buttons that drive
-- them, the three layer hop settings, and the layers of your zone that
-- Polestar players reported, each with an Ask button.
--
--   UI.LayerHop.Toggle()   open or close it (TOGGLE_LAYER_HOP: /polestar layer, the options' button)
--   UI.LayerHop.Open()     open it; false while the opt-in is off (a chat line says where to turn it on)
--   UI.LayerHop.view       what it shows, for the tests: { frame, rows }
--
-- Drag the head band to move it and the grip in the bottom-right corner to
-- resize it (MIN_W x MIN_H to MAX_W x MAX_H), neither while the windows are
-- locked (ui.locked). Position and size are kept in
-- PolestarDB.layerHopWindow = { x, y, w, h } (x, y: the top-left corner).
--
-- Built on first open; hidden when the opt-in turns off. Colours are Theme
-- tokens only.

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L
local readable = ns.Compat.Readable

local format, floor, max, min, concat = string.format, math.floor, math.max, math.min, table.concat
local type, tonumber, ipairs = type, tonumber, ipairs

local WIDTH, HEIGHT = 340, 440 -- the size it opens at the first time
local MIN_W, MIN_H, MAX_W, MAX_H = 280, 220, 560, 640
local PAD = 16
local HEAD_H = 48
local GRIP = 18
local GAP = 8
local BUTTON_H = 26
local ROW_H = 26
local ASK_W = 56
local SCROLL_W = 12 -- room for the scroll bar
local PENDING = 120 -- s: how long QoL/Layer.lua's request waits for an invite

local LayerHop = {}
UI.LayerHop = LayerHop

local F
local rows = {}
local ticker
local moving, sizing = false, false
local paint

local function layer() return ns.QoL and ns.QoL.Layer end
local function on() return layer() ~= nil and ns.Get("qol.layerHop") and true or false end
local function locked() return ns.Get("ui.locked") and true or false end
local function inGroup() return IsInGroup and readable(IsInGroup()) and true or false end
local function inCombat() return UnitAffectingCombat and readable(UnitAffectingCombat("player")) and true or false end

local function clamp(v, lo, hi)
	if v < lo then return lo elseif v > hi then return hi end
	return v
end

local function cancel(t)
	if t then t:Cancel() end
	return nil
end

local function mmss(s)
	s = floor(s + 0.5)
	return format("%d:%02d", floor(s / 60), s % 60)
end

---------------------------------------------------------------------------
-- Position and size
---------------------------------------------------------------------------

-- The size and top-left corner it opens at: as it was left, else the default
-- size in the middle of the screen; inside the limits and the screen.
local function restored()
	local saved = ns.DB().layerHopWindow
	if type(saved) ~= "table" then saved = {} end
	local w, h = tonumber(saved.w) or WIDTH, tonumber(saved.h) or HEIGHT
	local sw, sh = UIParent:GetWidth(), UIParent:GetHeight()
	local screen = sw and sw > 0 and sh and sh > 0
	local maxW, maxH = MAX_W, MAX_H
	if screen then maxW, maxH = min(maxW, floor(sw - 20)), min(maxH, floor(sh - 20)) end
	w, h = clamp(floor(w), MIN_W, max(MIN_W, maxW)), clamp(floor(h), MIN_H, max(MIN_H, maxH))
	local x, y = tonumber(saved.x), tonumber(saved.y)
	if not (x and y and screen) then return w, h end
	return w, h, clamp(floor(x), 0, max(0, floor(sw - w))), clamp(floor(y), min(h, floor(sh)), floor(sh))
end

local function place()
	local w, h, x, y = restored()
	F:SetSize(w, h)
	F:ClearAllPoints()
	if x then
		F:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
	else
		F:SetPoint("CENTER", UIParent, "CENTER", 0, 40)
	end
end

local function save()
	if not F then return end
	local left, top = F:GetLeft(), F:GetTop()
	ns.DB().layerHopWindow = { x = left and floor(left + 0.5) or nil, y = top and floor(top + 0.5) or nil,
		w = floor(F:GetWidth() + 0.5), h = floor(F:GetHeight() + 0.5) }
end

-- Ends a drag or a resize in progress and keeps where it ended.
local function stop()
	if not (moving or sizing) then return end
	moving, sizing = false, false
	F:StopMovingOrSizing()
	save()
end

local function applyLock()
	if not F then return end
	F.Grip:SetShown(not locked())
	if locked() then stop() end
end

---------------------------------------------------------------------------
-- Contents
---------------------------------------------------------------------------

-- A button's answer: the reason in chat when it was refused.
local function act(ok, why)
	if not ok and why then ns.Print(why) end
	if paint then paint() end
end

local function zoneName(map)
	local info = map and C_Map and C_Map.GetMapInfo and C_Map.GetMapInfo(map)
	local name = type(info) == "table" and readable(info.name)
	return type(name) == "string" and name ~= "" and name or nil
end

-- The status line, and whether it counts down (then it repaints each second).
local function statusText(s)
	if s.transfer == "offered" then
		if s.secondsLeft then return format(L["World refresh in %s"], mmss(s.secondsLeft)), true end
		return L["A world refresh is offered."], false
	elseif s.transfer == "refreshing" then
		return L["Refreshing the world."], false
	elseif s.transfer == "done" then
		return L["The world refreshed."], false
	elseif s.hopGroup then
		return L["In the host's group, waiting for the offer."], false
	elseif s.asked then
		local left = max(0, PENDING - (GetTime() - (s.asked.at or 0)))
		return format(L["Asked for a hop: %d s left."], floor(left + 0.5)), true
	end
	return L["No hop in progress."], false
end

local function rowWidth() return max(1, F:GetWidth() - 2 * PAD - SCROLL_W) end

local function newRow(i)
	local r = CreateFrame("Frame", nil, F.Scroll.Child)
	r:SetHeight(ROW_H)
	r:SetPoint("TOPLEFT", F.Scroll.Child, "TOPLEFT", 0, -(i - 1) * ROW_H)
	r:SetPoint("TOPRIGHT", F.Scroll.Child, "TOPRIGHT", 0, -(i - 1) * ROW_H)
	r.Ask = W.Button(r, L["Ask"], function()
		local Ly = layer()
		if Ly and r.psId then act(Ly.Request(r.psId)) end
	end, { height = 22, width = ASK_W })
	r.Ask:SetPoint("RIGHT", r, "RIGHT", 0, 0)
	r.Info = W.Text(r, "note", "textDim")
	r.Info:SetWordWrap(false)
	-- The label gives way: the counts and the button keep their size.
	r.Label = W.Text(r, "label", "text")
	r.Label:SetPoint("LEFT", r, "LEFT", 0, 0)
	r.Label:SetPoint("RIGHT", r.Info, "LEFT", -8, 0)
	r.Label:SetJustifyH("LEFT")
	r.Label:SetWordWrap(false)
	rows[i] = r
	return r
end

local function paintRows(list, free)
	F.Scroll.Child:SetWidth(rowWidth())
	for i, e in ipairs(list) do
		local r = rows[i] or newRow(i)
		r.psId = e.id
		r.Label:SetText(format(L["Layer %d"], e.n))
		local bits = { format(e.peers == 1 and L["%d peer"] or L["%d peers"], e.peers) }
		if e.hosts > 0 then bits[#bits + 1] = L["host"] end
		if e.mine then bits[#bits + 1] = L["you"] end
		r.Info:SetText(concat(bits, " · "))
		r.Info:ClearAllPoints()
		if e.mine then
			r.Ask:Hide()
			r.Info:SetPoint("RIGHT", r, "RIGHT", 0, 0)
		else
			r.Ask:Show()
			r.Ask:SetEnabled(free)
			r.Info:SetPoint("RIGHT", r.Ask, "LEFT", -8, 0)
		end
		r:Show()
	end
	for i = #list + 1, #rows do rows[i]:Hide() end
	F.None:SetShown(#list == 0)
	W.SetScrollContent(F.Scroll, #list * ROW_H)
end

function paint()
	if not F then return end
	local Ly = layer()
	local s = Ly and Ly.Status() or { on = false, transfer = "none", peers = {} }
	if s.label then
		local zone = zoneName(s.map)
		F.Current:SetText(zone and format("%s · %s", zone, s.label) or s.label)
	else
		F.Current:SetText(L["Layer unknown: target or mouse over a creature."])
	end
	F.CurrentHit.psId = s.id
	local text, countdown = statusText(s)
	F.Status:SetText(text)
	local free = s.on and not s.asked and not s.hopGroup and not inGroup() and true or false
	F.Hop:SetEnabled(free)
	F.Now:SetEnabled(s.on and s.transfer == "offered" and not inCombat() and true or false)
	F.Leave:SetEnabled(s.hopGroup and true or false)
	F.List:SetEnabled(s.on and true or false)
	for _, c in ipairs(F.Checks) do c:SetChecked(ns.Get(c.psKey) and true or false) end
	paintRows(s.peers or {}, free)
	if countdown and F:IsShown() and not ticker then
		ticker = ns.NewTimer(1, function()
			ticker = nil
			if F:IsShown() then paint() end
		end)
	end
end

-- The four buttons share the width two by two.
local function layout()
	local half = max(1, floor((F:GetWidth() - 2 * PAD - GAP) / 2))
	for _, b in ipairs({ F.Hop, F.Now, F.Leave, F.List }) do
		b.psFixedWidth = half
		b:SetWidth(half)
	end
	F.Band:SetTexCoord(Theme.BandCoords(F:GetWidth() - 2, HEAD_H))
	paint()
end

local function check(key, text, above, y)
	local c = W.Checkbox(F, function(self) ns.Set(self.psKey, self:GetChecked() and true or false) end)
	c.psKey = key
	c:SetPoint("TOPLEFT", above, "BOTTOMLEFT", 0, y)
	c.Label = W.Text(F, "label", "text")
	c.Label:SetPoint("LEFT", c, "RIGHT", 8, 0)
	c.Label:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	c.Label:SetJustifyH("LEFT")
	c.Label:SetWordWrap(false)
	c.Label:SetText(text)
	F.Checks[#F.Checks + 1] = c
	return c
end

local function build()
	F = CreateFrame("Frame", "PolestarLayerHop", UIParent)
	F:SetFrameStrata("DIALOG")
	F:SetToplevel(true)
	F:SetClampedToScreen(true)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetResizable(true)
	if F.SetResizeBounds then F:SetResizeBounds(MIN_W, MIN_H, MAX_W, MAX_H) end
	place()
	F:Hide()
	Theme.Skin(F, "window")

	local head = CreateFrame("Frame", nil, F)
	head:SetPoint("TOPLEFT", F, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", F, "TOPRIGHT", -1, -1)
	head:SetHeight(HEAD_H)
	head:EnableMouse(true)
	head:RegisterForDrag("LeftButton")
	head:SetScript("OnDragStart", function()
		if locked() then return end
		moving = true
		F:StartMoving()
	end)
	head:SetScript("OnDragStop", stop)
	F.Head = head
	F.Band = Theme.Band(head, "BACKGROUND", -5)
	F.Band:SetAllPoints(head)
	F.Close = W.IconButton(head, "close", 28, L["Close"], function() F:Hide() end, 14)
	F.Close:SetPoint("RIGHT", head, "RIGHT", -10, 0)
	F.Title = W.Text(head, "title", "text")
	F.Title:SetPoint("LEFT", head, "LEFT", PAD, 0)
	F.Title:SetPoint("RIGHT", F.Close, "LEFT", -8, 0)
	F.Title:SetJustifyH("LEFT")
	F.Title:SetWordWrap(false)
	F.Title:SetText(L["Layer hop"])

	F.Current = W.Text(F, "label", "text")
	F.Current:SetPoint("TOPLEFT", F, "TOPLEFT", PAD, -(HEAD_H + 10))
	F.Current:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.Current:SetJustifyH("LEFT")
	F.Current:SetWordWrap(false)
	-- The raw layer id, in a tooltip over the current line.
	F.CurrentHit = CreateFrame("Frame", nil, F)
	F.CurrentHit:SetAllPoints(F.Current)
	F.CurrentHit:EnableMouse(true)
	F.CurrentHit:SetScript("OnEnter", function(self)
		if self.psId then W.Tooltip(self, "ANCHOR_BOTTOM", L["Layer id"], { self.psId }) end
	end)
	F.CurrentHit:SetScript("OnLeave", function() if GameTooltip then GameTooltip:Hide() end end)

	F.Status = W.Text(F, "note", "textDim")
	F.Status:SetPoint("TOPLEFT", F.Current, "BOTTOMLEFT", 0, -6)
	F.Status:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.Status:SetJustifyH("LEFT")
	F.Status:SetWordWrap(false)

	local function call(name, ...)
		local Ly = layer()
		if Ly then act(Ly[name](...)) end
	end
	F.Hop = W.Button(F, L["Hop to another layer"], function() call("Request", "*") end, { primary = true, height = BUTTON_H })
	F.Now = W.Button(F, L["Refresh now"], function() call("RefreshNow") end, { height = BUTTON_H })
	F.Leave = W.Button(F, L["Leave group"], function() call("LeaveGroup") end, { height = BUTTON_H })
	F.List = W.Button(F, L["Refresh list"], function() call("Ask") end, { height = BUTTON_H })
	F.Hop:SetPoint("TOPLEFT", F.Status, "BOTTOMLEFT", 0, -10)
	F.Now:SetPoint("LEFT", F.Hop, "RIGHT", GAP, 0)
	F.Leave:SetPoint("TOPLEFT", F.Hop, "BOTTOMLEFT", 0, -GAP)
	F.List:SetPoint("LEFT", F.Leave, "RIGHT", GAP, 0)

	F.Checks = {}
	local c = check("qol.layerHost", L["Invite players who ask"], F.Leave, -10)
	c = check("qol.layerAutoRefresh", L["Refresh the world by itself"], c, -4)
	c = check("qol.layerLeaveAfter", L["Leave the group after the hop"], c, -4)

	F.Scroll = W.Scroll(F)
	F.Scroll:SetPoint("TOPLEFT", c, "BOTTOMLEFT", 0, -10)
	F.Scroll:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -PAD, GRIP + 4)
	F.None = W.Text(F, "note", "textMuted")
	F.None:SetPoint("TOPLEFT", F.Scroll, "TOPLEFT", 0, 0)
	F.None:SetPoint("RIGHT", F, "RIGHT", -PAD, 0)
	F.None:SetJustifyH("LEFT")
	F.None:SetWordWrap(true)
	F.None:SetText(L["No layers seen yet: target or mouse over a creature, or press Refresh list."])

	-- The grip: drag to resize (UI/GearScales.lua's). The window is re-anchored
	-- by its top-left corner first, so the corner opposite the grip stays put.
	local grip = CreateFrame("Button", nil, F)
	grip:SetSize(GRIP, GRIP)
	grip:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -4, 4)
	local gr, gg, gb = Theme.Color("textMuted")
	for i = 1, 3 do
		local dot = grip:CreateTexture(nil, "OVERLAY")
		dot:SetSize(3, 3)
		dot:SetColorTexture(gr or 0.6, gg or 0.6, gb or 0.6, 0.9)
		dot:SetPoint("BOTTOMRIGHT", grip, "BOTTOMRIGHT", -2, 2 + (i - 1) * 5)
		if i > 1 then
			local dot2 = grip:CreateTexture(nil, "OVERLAY")
			dot2:SetSize(3, 3)
			dot2:SetColorTexture(gr or 0.6, gg or 0.6, gb or 0.6, 0.9)
			dot2:SetPoint("BOTTOMRIGHT", grip, "BOTTOMRIGHT", -2 - (i - 1) * 5, 2)
		end
	end
	grip:SetScript("OnMouseDown", function()
		if locked() then return end
		local left, top = F:GetLeft(), F:GetTop()
		if left and top and top > 0 then
			F:ClearAllPoints()
			F:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top)
		end
		sizing = true
		F:StartSizing("BOTTOMRIGHT")
	end)
	grip:SetScript("OnMouseUp", stop)
	F.Grip = grip

	F:SetScript("OnSizeChanged", layout)
	F:SetScript("OnShow", function(self) Anim.To(self, "alpha", 0, 1, Anim.FAST, "out") end)
	F:SetScript("OnHide", function()
		stop()
		ticker = cancel(ticker)
	end)
	ns.CloseOnEscape("PolestarLayerHop")
	if ns.Gamepad and ns.Gamepad.Register then ns.Gamepad.Register(F, {}) end
	applyLock()
	layout()
end

---------------------------------------------------------------------------
-- Opening
---------------------------------------------------------------------------

function LayerHop.Open()
	if not on() then
		ns.Print(L["Layer hop is off: turn it on in the options, Quality of Life, Layers."])
		return false
	end
	if not F then build() end
	F:Show()
	F:Raise()
	layer().Ask() -- who else is on this map (at most once a minute)
	paint()
	return true
end

function LayerHop.Toggle()
	if F and F:IsShown() then
		F:Hide()
		return false
	end
	return LayerHop.Open()
end

LayerHop.view = setmetatable({ rows = rows }, { __index = function(_, k) if k == "frame" then return F end end })

ns.On("TOGGLE_LAYER_HOP", function() LayerHop.Toggle() end)
ns.On("LAYER_CHANGED", function() if F and F:IsShown() then paint() end end)
ns.On("SETTING_CHANGED", function(path)
	if not F or type(path) ~= "string" then return end
	local all = path == "" or path == "qol" or path == "ui"
	if (all or path == "qol.layerHop") and not on() then
		F:Hide()
		return
	end
	if all or path == "ui.locked" then applyLock() end
	if F:IsShown() and (all or path:sub(1, 9) == "qol.layer") then paint() end
end)
