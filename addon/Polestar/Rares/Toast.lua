-- The rare alert (PolestarRareToast): a small card in Polestar's world with
-- the welcome's chrome, read in three steps. On top, under the gold rim
-- (W.Rim), a compact night band (the band, and in the house style a
-- scrim-to-ground gradient and the haze) carrying what it is: the rare's
-- glyph in a ring in its kind's colour, its name in Title and one line of
-- what it is (level and kind, zone). Under a hairline, how far: the
-- distance in Heading after the dart ("85 yd", "In sight" or "Known spawn
-- 120 yd"), then what to do, on the right: "Target" (a rare, not a
-- treasure: see below), "Show rare" or "Show treasure" (the Rares section at
-- it: its drop, places and history) and "Set waypoint" (primary; Nav to the
-- vignette's live position, else where it was seen, else its nearest known
-- spawn). It slides in from above, drains a hairline while it waits, holds
-- while the cursor is on it, and closes itself after rares.toastSeconds.
-- Drag to move (saved in rares.toastPoint). One alert at a time: a newer one
-- replaces it.
--
-- Target: the card's own buttons cannot target (a protected action), so a
-- secure button (PolestarRareCardTarget, parented to UIParent) lies over the
-- card's Target button and runs QoL.Buttons.RareCardMacro: /targetexact the
-- rare, /ping it for the group, and its mark while "Mark what they target"
-- is on. Its macro is set, and it is anchored to the card, only out of
-- combat, when the card appears: a protected frame anchored to the card
-- would stop the card moving or closing in a fight, so PLAYER_REGEN_DISABLED
-- (before the lockdown starts) lets go of it. In a fight, or when the card
-- appeared in one, the Target button is disabled, its tooltip pointing at
-- the rare button and its key; the fight's end arms it again.
--
-- The founder's alert (alert.kind "founder", Rares.FounderSighting) has the
-- same card: his crest alone (founder-emblem, 40 px, untinted, no ring, where
-- the others have their tinted glyph in the ring), "The Polestar founder is nearby!", his name and the
-- zone, and in the row a nudge to wave; its Target button targets him and
-- waves (QoL.Buttons.FounderMacro, as the rare button does).
--
--   Rares.Toast.Show(alert)   alert as Rares.AlertOf builds it
--   Rares.Toast.Hide()
--   Rares.Toast.Facts(alert)  "Level 11 Rare  ·  Elwynn Forest"
--   Rares.Toast.Distance(alert) "85 yd" | "In sight" | "Known spawn 120 yd" | the founder's nudge | nil
--   Rares.Toast.TargetMacro(alert) the Target button's macro, nil: no button
--   Rares.Toast.frame         the frame, once shown
--   Rares.Toast.secure        PolestarRareCardTarget, once shown

local ADDON, ns = ...
local Rares, Theme, W, Anim = ns.Rares, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local floor, max, min, ceil, format, concat = math.floor, math.max, math.min, math.ceil, string.format, table.concat

local T = {}
Rares.Toast = T

-- WIDTH at least; wider, up to MAX_W, when a longer name, facts line or the
-- distance and buttons need it (a translation, a long zone name).
local WIDTH, MAX_W, BAND_H, ROW_H = 368, 520, 56, 48
local PAD = 16
local RING = 32
local GLYPH, FOUNDER_CREST = 16, 40
local TEXT_X = PAD + RING + 12
local DOT = "  \194\183  "
local DEFAULT = { "TOP", 0, -132 }

local f, current

local function house()
	return Theme.SkinKey() == "polestar"
end

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

local function lockdown()
	return InCombatLockdown and InCombatLockdown() and true or false
end

-- The Target button's macro for alert a: the founder's wave
-- (Buttons.FounderMacro), else a rare's (not a treasure, nor the options'
-- placeholder sample), by its name; nil without QoL's buttons or for a name
-- that cannot be a macro line.
function T.TargetMacro(a)
	local B = ns.QoL and ns.QoL.Buttons
	if type(a) ~= "table" or a.kind == "treasure" or (a.source == "sample" and not a.id) then return nil end
	if a.kind == "founder" then return B and B.FounderMacro and B.FounderMacro(a.name) or nil end
	if not (B and B.RareCardMacro) then return nil end
	return B.RareCardMacro(a.name)
end

-- Let go of the secure button: hidden and anchored nowhere. Out of combat
-- only (PLAYER_REGEN_DISABLED runs before the lockdown).
local function disarm()
	local s = T.secure
	if not s or lockdown() then return end
	s:Hide()
	s:ClearAllPoints()
end

-- The card's Target button: shown for an alert with a macro; enabled once
-- the secure button over it has that macro, else disabled, with a tooltip
-- naming the rare button and its key.
local function paintTarget(shown, armed)
	local b = f.Target
	b:SetShown(shown)
	b:SetEnabled(armed)
	b:SetAlpha(armed and 1 or 0.5)
	if armed or not shown then
		b.psTip, b.psTipLines = nil, nil
		return
	end
	local B = ns.QoL and ns.QoL.Buttons
	local key = GetBindingKey and GetBindingKey("CLICK PolestarRareButton:LeftButton")
	key = key and (B and B.KeyText and B.KeyText(key) or key)
	local r, g, bl = Theme.Color("textDim")
	b.psTip = b.Label:GetText()
	b.psTipLines = { { key and format(L["The card can't target during a fight. Use the rare button or its key (%s)."], key)
		or L["The card can't target during a fight. Use the rare button."], r, g, bl } }
end

-- Give the secure button the current alert's macro and lay it over the
-- card's Target button, out of combat; in combat the button shows disabled.
local function arm()
	local text = current and T.TargetMacro(current)
	if not text then
		disarm()
		paintTarget(false, false)
		return
	end
	if lockdown() then
		paintTarget(true, false)
		return
	end
	local s = T.secure
	s:SetAttribute("useOnKeyDown", false)
	s:SetAttribute("type", "macro")
	s:SetAttribute("macrotext", text)
	s:ClearAllPoints()
	s:SetAllPoints(f.Target)
	s:SetFrameStrata(f:GetFrameStrata())
	s:SetFrameLevel(f.Target:GetFrameLevel() + 2)
	s:Show()
	paintTarget(true, true)
end

local function buildSecure()
	local s = CreateFrame("Button", "PolestarRareCardTarget", UIParent, "SecureActionButtonTemplate")
	-- The client hands an addon's secure button its clicks without saying
	-- they are the mouse's (SecureTemplates.xml), so SecureActionButton_OnClick
	-- acts on the press when useOnKeyDown (nil: the ActionButtonUseKeyDown
	-- CVar, on by default) says so, else on the release. Registered for
	-- the release only, a press-acting button did nothing (0.3.6: Target on
	-- the card never targeted). Both are registered, and arm() sets
	-- useOnKeyDown false: one action, on the release, whatever the CVar.
	s:RegisterForClicks("AnyUp", "AnyDown")
	-- The card's button draws it: hover reaches it from here.
	s:SetScript("OnEnter", function()
		f.Target:LockHighlight()
		local h = f.Target:GetScript("OnEnter")
		if h then h(f.Target) end
	end)
	s:SetScript("OnLeave", function()
		f.Target:UnlockHighlight()
		local h = f.Target:GetScript("OnLeave")
		if h then h(f.Target) end
	end)
	T.secure = s
	-- Made in a fight (a /reload): shown but anchored nowhere until it ends.
	if not lockdown() then s:Hide() end
end

-- What it is: "Level 11 Rare  ·  Elwynn Forest".
function T.Facts(a)
	if a.kind == "founder" then
		return a.zone and (a.name .. DOT .. a.zone) or a.name
	end
	local parts = {}
	local lv = Rares.LevelText(a.level, a.levelMax)
	local kind = Rares.KindText(a.kind, a.elite)
	parts[1] = lv and (format(L["Level %s"], lv) .. " " .. kind) or kind
	if a.zone then parts[#parts + 1] = a.zone end
	return concat(parts, DOT)
end

-- How far: its distance, in sight, or (not its own position: the waypoint
-- is a spawn) the known spawn's; nil when unknown.
local function capital(s)
	return (s:gsub("^%l", string.upper))
end

function T.Distance(a)
	if a.kind == "founder" then
		if a.enemy then return L["Other faction: wave from a safe distance"] end
		return a.button and L["Say hi with the rare button"] or L["Go say hi"]
	end
	if a.yards then return Rares.YardsText(a.yards) end
	if a.inSight then return capital(L["in sight"]) end
	if a.spawnYards then return capital(format(L["known spawn %s"], Rares.YardsText(a.spawnYards))) end
	return nil
end

-- A texture's vertical gradient, top colour then bottom colour.
local function vgrad(t, r1, g1, b1, a1, r2, g2, b2, a2)
	if t.SetGradient and CreateColor then
		t:SetVertexColor(1, 1, 1, 1)
		t:SetGradient("VERTICAL", CreateColor(r2, g2, b2, a2), CreateColor(r1, g1, b1, a1))
	else
		t:SetVertexColor(r2, g2, b2, (a1 + a2) / 2)
	end
end

local function build()
	f = CreateFrame("Frame", "PolestarRareToast", ns.UIParent)
	f:SetSize(WIDTH, BAND_H + ROW_H)
	f:SetFrameStrata("HIGH")
	f:SetClampedToScreen(true)
	f:SetMovable(true)
	f:EnableMouse(true)
	f:RegisterForDrag("LeftButton")
	-- A toast: the game's looks give it the guide window's light frame.
	f.psLight = true
	Theme.Skin(f, "window")

	-- The night band: what it is.
	local head = CreateFrame("Frame", nil, f)
	head:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
	head:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -1)
	head:SetHeight(BAND_H)
	f.Head = head
	f.Night = head:CreateTexture(nil, "BACKGROUND", nil, -8)
	f.Night:SetTexture(Theme.Media("white"))
	f.Night:SetAllPoints(head)
	W.Painter(f.Night, function(t)
		t:SetShown(house())
		local tr, tg, tb = Theme.Color("scrim")
		local br, bg, bb = Theme.Color("bg")
		vgrad(t, tr, tg, tb, 1, br, bg, bb, 1)
	end)
	if W.Haze then f.Haze = W.Haze(head, { height = BAND_H, sub = -6 }) end
	f.Band = Theme.Band(head, "BACKGROUND", -5)
	f.Band:SetAllPoints(head)
	f.Band:SetTexCoord(Theme.BandCoords(WIDTH - 2, BAND_H))
	f.BandRule = W.Divider(f)
	f.BandRule:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -(BAND_H + 1))
	f.BandRule:SetPoint("TOPRIGHT", f, "TOPRIGHT", -1, -(BAND_H + 1))

	-- The glyph in a ring, in its kind's colour (Theme "rare", "object").
	f.Ring = W.Tex(head, "ARTWORK", "qol-ring", "rare")
	f.Ring:SetSize(RING, RING)
	f.Ring:SetPoint("LEFT", head, "LEFT", PAD - 1, 0)
	f.Glyph = W.Tex(head, "OVERLAY", "qol-target", "rare")
	f.Glyph:SetSize(GLYPH, GLYPH)
	f.Glyph:SetPoint("CENTER", f.Ring, "CENTER", 0, 0)

	f.Name = W.Text(head, "title", "title") -- the transport banner's title colour too (gold in the game's looks)
	f.Name:SetPoint("BOTTOMLEFT", f.Ring, "RIGHT", 12, 1)
	f.Name:SetPoint("RIGHT", head, "RIGHT", -40, 0)
	f.Name:SetJustifyH("LEFT")
	f.Name:SetWordWrap(false)
	f.Facts = W.Text(head, "small", "textDim")
	f.Facts:SetPoint("TOPLEFT", f.Ring, "RIGHT", 12, -3)
	f.Facts:SetPoint("RIGHT", head, "RIGHT", -PAD, 0)
	f.Facts:SetJustifyH("LEFT")
	f.Facts:SetWordWrap(false)
	for _, fs in ipairs({ f.Name, f.Facts }) do
		W.Painter(fs, function(t)
			local r, g, b = Theme.Color("shade")
			t:SetShadowOffset(0, -1)
			t:SetShadowColor(r, g, b, 0.85)
		end)
	end

	f.Close = W.IconButton(head, "close", 22, L["Dismiss"], function() T.Hide() end, 12)
	f.Close:SetPoint("TOPRIGHT", head, "TOPRIGHT", -8, -8)

	-- The row: how far, then what to do (the primary action rightmost).
	local rowY = BAND_H + 1 + ROW_H / 2
	f.Dart = W.Tex(f, "ARTWORK", "dart-gold")
	f.Dart:SetSize(14, 14)
	f.Dart:SetPoint("LEFT", f, "TOPLEFT", PAD, -rowY)
	f.Distance = W.Text(f, "heading", "text")
	f.Distance:SetPoint("LEFT", f.Dart, "RIGHT", 8, 0)
	f.Distance:SetWordWrap(false)

	f.Waypoint = W.Button(f, L["Set waypoint"], waypoint, { primary = true, height = 28, icon = "icon-goto" })
	f.Waypoint:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -rowY)
	f.Open = W.Button(f, L["Show rare"], showRare, { height = 28, icon = "search" })
	-- Drawn here; the secure button over it does the click (see arm).
	-- The plain button only gets a click the secure one missed (not laid
	-- over it yet): lay it over now, and say so.
	f.Target = W.Button(f, L["Target"], function()
		if lockdown() then return end
		arm()
		ns.Print(L["Click Target again to target the rare, or use the rare button."])
	end, { height = 28, icon = "qol-target" })
	buildSecure()

	f.Timer = W.ProgressLine(f, 2)
	f.Timer:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
	f.Timer:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -1, 1)

	f:SetScript("OnDragStart", function(self) self:StartMoving() end)
	f:SetScript("OnDragStop", function(self)
		self:StopMovingOrSizing()
		local point, _, _, x, y = self:GetPoint(1)
		if point then ns.Set("rares.toastPoint", { point, floor(x + 0.5), floor(y + 0.5) }) end
	end)
	f:SetScript("OnUpdate", ns.Safe(function(self, elapsed)
		if self:IsMouseOver() then return end
		self.psLeft = (self.psLeft or 0) - elapsed
		local total = self.psTotal or 1
		W.SetProgress(self.Timer, max(0, self.psLeft) / total, self:GetWidth() - 2)
		if self.psLeft <= 0 then T.Hide() end
	end))
	-- The rim's light kept inside the band.
	if W.Rim then W.Rim(f, { height = BAND_H }) end
	f:Hide()
	T.frame = f
end

function T.Show(a)
	if type(a) ~= "table" then return end
	if not f then build() end
	current = a
	local founder = a.kind == "founder"
	-- The founder: his crest alone, untinted, a little over the ring's size
	-- (the ring stays the hidden anchor, so the text doesn't move).
	if founder then
		f.Glyph:SetTexture(Theme.Media("founder-emblem"))
		f.Glyph:SetSize(FOUNDER_CREST, FOUNDER_CREST)
		W.Uncolor(f.Glyph)
		f.Glyph:SetVertexColor(1, 1, 1, 1)
	else
		f.Glyph:SetTexture(Theme.Media(a.kind == "treasure" and "icon-treasure" or "qol-target"))
		f.Glyph:SetSize(GLYPH, GLYPH)
		W.Color(f.Glyph, Rares.ColorName(a.kind))
	end
	f.Ring:SetShown(not founder)
	W.Color(f.Ring, Rares.ColorName(a.kind))
	f.Name:SetText(founder and L["The Polestar founder is nearby!"] or a.name or "")
	f.Facts:SetText(T.Facts(a))
	local dist = T.Distance(a)
	f.Distance:SetText(dist or "")
	f.Distance:SetShown(dist ~= nil)
	f.Dart:SetShown(dist ~= nil)
	f.Waypoint:SetShown(a.map ~= nil and a.x ~= nil)
	-- The button names what it opens; its width follows the label.
	W.SetButtonText(f.Open, a.kind == "treasure" and L["Show treasure"] or L["Show rare"])
	f.Open:SetShown(a.id ~= nil)
	f.Target:SetShown(T.TargetMacro(a) ~= nil)
	W.SetButtonText(f.Target, founder and L["Wave"] or L["Target"])
	-- The shown buttons right to left, the primary rightmost, 8px apart.
	local buttons, last = 0, nil
	for _, b in ipairs({ f.Waypoint, f.Open, f.Target }) do
		if b:IsShown() then
			b:ClearAllPoints()
			if last then
				b:SetPoint("RIGHT", last, "LEFT", -8, 0)
				buttons = buttons + 8
			else
				b:SetPoint("RIGHT", f, "TOPRIGHT", -PAD, -(BAND_H + 1 + ROW_H / 2))
			end
			buttons = buttons + b:GetWidth()
			last = b
		end
	end
	local distW = dist and (14 + 8 + ceil(W.TextWidth(f.Distance)) + 16) or 0
	local need = max(WIDTH,
		TEXT_X + ceil(W.TextWidth(f.Name)) + 40,
		TEXT_X + ceil(W.TextWidth(f.Facts)) + PAD,
		PAD + distW + buttons + PAD)
	local width = min(MAX_W, need)
	f:SetWidth(width)
	if W.LayoutRim then W.LayoutRim(f) end
	f.Distance:SetWidth(max(1, width - PAD * 2 - 22 - buttons - 16))
	f.Band:SetTexCoord(Theme.BandCoords(width - 2, BAND_H))
	local secs = tonumber(Rares.Get("toastSeconds")) or 20
	f.psTotal, f.psLeft = secs, secs
	W.SetProgress(f.Timer, 1, width - 2)
	local wasShown = f:IsShown()
	place()
	f:Show()
	arm()
	if not wasShown then
		-- One authored moment: it settles in from above while it fades up.
		local p = f.psAnchor
		Anim.To(f, "alpha", 0, 1, Anim.SLOW, "out")
		Anim.To(f, "offset", p[5] + 18, p[5], Anim.SLOW * 1.5, "out")
	end
end

function T.Hide()
	current = nil
	disarm()
	if f then f:Hide() end
end

-- A fight starts: before the lockdown, let go of the secure button so the
-- card may still move and close; the Target button shows disabled. The
-- fight's end arms it again for the card still showing.
ns.RegisterEvent("PLAYER_REGEN_DISABLED", function()
	if not (f and current) then return end
	disarm()
	paintTarget(T.TargetMacro(current) ~= nil, false)
end)

ns.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if f and current and f:IsShown() then arm() else disarm() end
end)

function T.Current() return current end

-- Not while Polestar is hidden (Rares.lua sends none then either): a
-- sighting is news, not something to show after.
ns.On("RARE_SPOTTED", function(a)
	if not ns.Hidden() then T.Show(a) end
end)

-- Hiding Polestar ends the alert (and lets go of the secure button, out of
-- combat; in a fight it was let go of as it began).
ns.On("POLESTAR_HIDDEN", function(hidden)
	if hidden and f and f:IsShown() then T.Hide() end
end)
