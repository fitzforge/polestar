-- The rare alert (PolestarRareToast): a small card in Polestar's world, the
-- night band carrying the rare's glyph, name and one line of facts (level and
-- kind, distance, "in sight" or "known spawn 120 yd", zone), then two
-- actions: "Set waypoint" (Nav to the vignette's live position, else where it
-- was seen, else its nearest known spawn) and "Show rare" or
-- "Show treasure" (the Rares section at it: its drop, places and history). It slides in
-- from above, drains a hairline while it waits, holds while the cursor is on
-- it, and closes itself after rares.toastSeconds. Drag to move (saved in
-- rares.toastPoint). One alert at a time: a newer one replaces it.
--
--   Rares.Toast.Show(alert)   alert as Rares.AlertOf builds it
--   Rares.Toast.Hide()
--   Rares.Toast.frame         the frame, once shown

local ADDON, ns = ...
local Rares, Theme, W, Anim = ns.Rares, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local floor, max, format, concat = math.floor, math.max, string.format, table.concat

local T = {}
Rares.Toast = T

-- WIDTH at least; wider, up to MAX_W, when a longer name, facts line or
-- pair of buttons needs it (a translation, a long zone name).
local WIDTH, MAX_W, BAND_H, ROW_H = 368, 520, 64, 48
local PAD = 16
local DOT = "  \194\183  "
local DEFAULT = { "TOP", 0, -132 }

local f, current

local function place()
	local p = Rares.Get("toastPoint")
	if type(p) ~= "table" or type(p[1]) ~= "string" then p = DEFAULT end
	Anim.Anchor(f, p[1], UIParent, p[1], tonumber(p[2]) or 0, tonumber(p[3]) or 0)
end

local function waypoint()
	local a = current
	if not a then return end
	-- A vignette still on the minimap has a fresher place than the alert's.
	local live = a.vignette and Rares.Detect and Rares.Detect.VignetteWhere and Rares.Detect.VignetteWhere(a.vignette)
	local map, x, y, fr = a.map, a.x, a.y, a.f
	if live then map, x, y, fr = live.map, live.x, live.y, nil end
	if not (map and x and y) then return end
	local N = ns.Nav
	if N and N.SetTarget then N.SetTarget(map, x, y, a.name, fr) end
	T.Hide()
end

local function showRare()
	local a = current
	if not a then return end
	Rares.Show(a.kind, a.id)
	T.Hide()
end

-- "Level 11 Rare  ·  85 yd  ·  Elwynn Forest"
function T.Facts(a)
	local parts = {}
	local lv = Rares.LevelText(a.level, a.levelMax)
	local kind = Rares.KindText(a.kind, a.elite)
	parts[1] = lv and (format(L["Level %s"], lv) .. " " .. kind) or kind
	if a.yards then
		parts[#parts + 1] = Rares.YardsText(a.yards)
	elseif a.inSight then
		parts[#parts + 1] = L["in sight"]
	elseif a.spawnYards then
		-- Not its own position: say the waypoint is a spawn, and how far.
		parts[#parts + 1] = format(L["known spawn %s"], Rares.YardsText(a.spawnYards))
	end
	if a.zone then parts[#parts + 1] = a.zone end
	return concat(parts, DOT)
end

local function build()
	f = CreateFrame("Frame", "PolestarRareToast", UIParent)
	f:SetSize(WIDTH, BAND_H + ROW_H)
	f:SetFrameStrata("HIGH")
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:RegisterForDrag("LeftButton")
	Theme.Skin(f, "window")

	f.Band = Theme.Band(f, "BACKGROUND", -5)
	f.Band:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
	f.Band:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -1)
	f.Band:SetHeight(BAND_H)
	f.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, BAND_H))
	f.BandRule = W.Divider(f)
	f.BandRule:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -(BAND_H + 1))
	f.BandRule:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -(BAND_H + 1))

	-- The glyph in a ring, in its kind's colour (Theme "rare", "object").
	f.Ring = W.Tex(f, "ARTWORK", "qol-ring", "rare")
	f.Ring:SetSize(36, 36)
	f.Ring:SetPoint("LEFT", f, "TOPLEFT", PAD, -(BAND_H / 2 + 1))
	f.Glyph = W.Tex(f, "OVERLAY", "qol-target", "rare")
	f.Glyph:SetSize(18, 18)
	f.Glyph:SetPoint("CENTER", f.Ring, "CENTER", 0, 0)

	f.Name = W.Text(f, "title", "text")
	f.Name:SetPoint("BOTTOMLEFT", f.Ring, "RIGHT", 12, 1)
	f.Name:SetPoint("RIGHT", f, "RIGHT", -40, 0)
	f.Facts = W.Text(f, "small", "textDim")
	f.Facts:SetPoint("TOPLEFT", f.Ring, "RIGHT", 12, -3)
	f.Facts:SetPoint("RIGHT", f, "RIGHT", -PAD, 0)
	for _, fs in ipairs({ f.Name, f.Facts }) do
		W.Painter(fs, function(t)
			local r, g, b = Theme.Color("shade")
			t:SetShadowOffset(0, -1)
			t:SetShadowColor(r, g, b, 0.85)
		end)
	end

	f.Close = W.IconButton(f, "close", 22, L["Dismiss"], function() T.Hide() end)
	f.Close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -8, -8)

	f.Waypoint = W.Button(f, L["Set waypoint"], waypoint, { primary = true, height = 28, icon = "icon-goto" })
	f.Waypoint:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PAD, 10)
	f.Open = W.Button(f, L["Show rare"], showRare, { height = 28, icon = "search" })
	f.Open:SetPoint("LEFT", f.Waypoint, "RIGHT", 8, 0)

	f.Timer = W.ProgressLine(f, 2)
	f.Timer:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
	f.Timer:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)

	f:SetScript("OnDragStart", function(self) self:StartMoving() end)
	f:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		if point then ns.Set("rares.toastPoint", { point, floor(x + 0.5), floor(y + 0.5) }) end
	end)
	f:SetScript("OnUpdate", function(self, elapsed)
		if self:IsMouseOver() then return end
		self.psLeft = (self.psLeft or 0) - elapsed
		local total = self.psTotal or 1
		W.SetProgress(self.Timer, max(0, self.psLeft) / total, self:GetWidth() - 2)
		if self.psLeft <= 0 then T.Hide() end
	end)
	f:Hide()
	T.frame = f
end

function T.Show(a)
	if type(a) ~= "table" then return end
	if not f then build() end
	current = a
	f.Glyph:SetTexture(Theme.Media(a.kind == "treasure" and "icon-treasure" or "qol-target"))
	W.Color(f.Glyph, Rares.ColorName(a.kind))
	W.Color(f.Ring, Rares.ColorName(a.kind))
	f.Name:SetText(a.name or "")
	f.Facts:SetText(T.Facts(a))
	f.Waypoint:SetShown(a.map ~= nil and a.x ~= nil)
	-- The button names what it opens; its width follows the label.
	W.SetButtonText(f.Open, a.kind == "treasure" and L["Show treasure"] or L["Show rare"])
	f.Open:ClearAllPoints()
	if f.Waypoint:IsShown() then
		f.Open:SetPoint("LEFT", f.Waypoint, "RIGHT", 8, 0)
	else
		f.Open:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PAD, 10)
	end
	f.Open:SetShown(a.id ~= nil)
	-- As wide as the name, the facts and the buttons need; the band keeps
	-- its proportions (cropped, never stretched).
	local textX = PAD + 36 + 12
	local need = max(WIDTH,
		textX + math.ceil(W.TextWidth(f.Name)) + 40,
		textX + math.ceil(W.TextWidth(f.Facts)) + PAD,
		PAD + (f.Waypoint:IsShown() and f.Waypoint:GetWidth() + 8 or 0) + (f.Open:IsShown() and f.Open:GetWidth() or 0) + PAD)
	local width = math.min(MAX_W, need)
	f:SetWidth(width)
	f.Band:SetTexCoord(Theme.BandCoords(width - 2, BAND_H))
	local secs = tonumber(Rares.Get("toastSeconds")) or 20
	f.psTotal, f.psLeft = secs, secs
	W.SetProgress(f.Timer, 1, width - 2)
	local wasShown = f:IsShown()
	place()
	f:Show()
	if not wasShown then
		-- One authored moment: it settles in from above while it fades up.
		local p = f.psAnchor
		Anim.To(f, "alpha", 0, 1, Anim.SLOW, "out")
		Anim.To(f, "offset", p[5] + 18, p[5], Anim.SLOW * 1.5, "out")
	end
end

function T.Hide()
	current = nil
	if f then f:Hide() end
end

function T.Current() return current end

ns.On("RARE_SPOTTED", function(a) T.Show(a) end)
