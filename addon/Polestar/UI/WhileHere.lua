-- The "While you're here" toast (PolestarWhileHereToast). The guide window
-- shows Dynamic Questing's suggestions in its "While you're here" panel under
-- the step, in every mode and style (UI/GuideFrame.lua, GF.FillHere;
-- Core/Engine.lua, Engine.GetWhileHereList). While the window is
-- hidden, a new line comes as this one small card near the top of
-- the screen instead: the accent edge and the verb's glyph, "While you're
-- here" in the accent, then what to do and how far. Once per line: it slides
-- down into place as it fades in (Anim.BASE, strong ease-out) and leaves back
-- up, faster (Anim.FAST), after SECONDS (held while the cursor is on it) or as
-- soon as the line goes. Left-click leads the arrow there
-- (Engine.AimWhileHere), right-click dismisses it around here (twice: for the zone)
-- (Engine.DismissWhileHere). Under ui.reduceMotion it only fades (Anim).
--
-- Each new line also plays a soft chime (with behavior.whileHereSound; a
-- line coming back counts as new, one already up never chimes again; at
-- least SOUND_EVERY seconds apart, so several at once chime once, on the game's sound effects channel), as
-- the minimap's mark pings (Nav/Layers.lua, Pins `ping`), so the player knows
-- to glance at it. Media/Sounds/while-here.ogg, "star twinkle", was made for
-- Polestar: synthesized, no third-party source. Three quick rising glass-bell
-- notes, E6, G#6 and B6, 75 ms apart, each with bell partials at 1, 2.76 and
-- 5.4 times its pitch, a light reverb; 0.9 s with a soft fade, mono, peak
-- -12 dB. Regenerate it with tools/sounds/while-here-chime.py.
--
--   UI.WhileHereToast.Show(view), .Hide(), .Chime(), .frame (once built)

local ADDON, ns = ...
local UI, Theme, W, Anim = ns.UI, ns.Theme, ns.Widgets, ns.Anim
local L = ns.L

local T = {}
UI.WhileHereToast = T

local WIDTH, HEIGHT, PAD = 320, 46, 12
local TOP_Y = -150
local SECONDS = 8
local DIST = { round = 5 }

local SOUND = "Interface\\AddOns\\" .. ADDON .. "\\Media\\Sounds\\while-here.ogg"
local SOUND_EVERY = 5
local soundAt = -math.huge

local f
local shownKey -- the `appeared` serial of the line the toast shows (it stays when another step's copy of the objective takes the line over)
local seen = 0 -- the newest line's `appeared` chimed for (Engine serials only grow)
local token = 0 -- the current show; a timer or fade of an older one does nothing

-- The toast's line's place in Engine.GetWhileHereList (its rows change
-- order), else 1.
local function shownIndex()
	local E = ns.Engine
	local list = E and E.GetWhileHereList and E.GetWhileHereList() or {}
	for i, v in ipairs(list) do
		if shownKey and v.appeared == shownKey then return i end
	end
	return 1
end

-- Whether the guide window shows the line itself (compact included).
local function windowShows()
	local GF = UI.GuideFrame
	local F = GF and GF.frame
	return F ~= nil and F:IsVisible()
end

local function text(v)
	local s = UI.HereText(v)
	if v.yards then s = s .. "  \194\183  " .. ns.FormatDistance(v.yards, DIST) end
	return s
end

local function build()
	f = CreateFrame("Button", "PolestarWhileHereToast", ns.UIParent)
	f:SetSize(WIDTH, HEIGHT)
	f:SetFrameStrata("HIGH")
	f:SetClampedToScreen(true)
	f:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	-- A toast: the game's looks give it the guide window's light frame.
	f.psLight = true
	Theme.Skin(f, "window")
	Anim.Anchor(f, "TOP", UIParent, "TOP", 0, TOP_Y)
	f.Edge = W.Tex(f, "ARTWORK", nil, "accent")
	f.Edge:SetPoint("TOPLEFT", f, "TOPLEFT", 1, -1)
	f.Edge:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 1, 1)
	f.Edge:SetWidth(2)
	f.Icon = f:CreateTexture(nil, "ARTWORK")
	f.Icon:SetSize(16, 16)
	W.Color(f.Icon, "accent")
	f.Icon:SetPoint("LEFT", f, "LEFT", PAD + 2, 0)
	f.Head = W.Text(f, "small", "accent")
	f.Head:SetPoint("TOPLEFT", f, "TOPLEFT", PAD + 2 + 16 + 10, -8)
	f.Head:SetText(L["While you're here"])
	f.Text = W.Text(f, "label", "text")
	f.Text:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", PAD + 2 + 16 + 10, 8)
	f.Text:SetWidth(WIDTH - (PAD + 2 + 16 + 10) - PAD)
	f:SetScript("OnClick", function(_, button)
		local E = ns.Engine
		if not E then return end
		if button == "RightButton" then
			if E.DismissWhileHere then E.DismissWhileHere(shownIndex()) end
		elseif E.AimWhileHere then
			E.AimWhileHere(shownIndex())
			T.Hide()
		end
	end)
	f:SetScript("OnEnter", function(self)
		W.Tooltip(self, "ANCHOR_BOTTOM", L["While you're here"], {
			{ L["Click to point the arrow here"], Theme.Accent() },
			{ L["Right-click: not now, around here (twice: for the rest of this zone)."], Theme.Color("textDim") },
		})
	end)
	f:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	f:Hide()
	T.frame = f
end

local function expire(mine)
	if mine ~= token or not (f and f:IsShown()) then return end
	if f:IsMouseOver() then
		ns.After(2, function() expire(mine) end)
		return
	end
	T.Hide()
end

function T.Show(v)
	if not f then build() end
	token = token + 1
	local mine = token
	f.Icon:SetTexture(Theme.VerbIcon(v.here == "turnin" and "turnin" or v.t))
	f.Text:SetText(text(v))
	local was = f:IsShown()
	f:Show()
	Anim.To(f, "alpha", was and f:GetAlpha() or 0, 1, Anim.BASE, "out")
	Anim.To(f, "offset", 8, 0, Anim.BASE, "out")
	ns.After(SECONDS, function() expire(mine) end)
end

function T.Hide()
	if not (f and f:IsShown()) then return end
	token = token + 1
	local mine = token
	Anim.To(f, "offset", 0, 6, Anim.FAST, "out")
	Anim.To(f, "alpha", f:GetAlpha(), 0, Anim.FAST, "out", function()
		if mine == token then f:Hide() end
	end)
end

-- The chime for a new line, unless off, Polestar is hidden or paused, or
-- one played less than SOUND_EVERY seconds ago. True when it played.
function T.Chime()
	if not (ns.Get("behavior.whileHereSound") and PlaySoundFile) or ns.Hidden() or ns.PauseHides("nagging") then return false end
	local now = GetTime()
	if now - soundAt < SOUND_EVERY then return false end
	soundAt = now
	ns.PlaySoundFile(SOUND, "SFX")
	return true
end

-- A line that appears (a new `appeared`, also one coming back after a dismiss,
-- an expiry or a walk away) chimes, wherever it sits among the rows, and is
-- the toast's while the window is hidden. A line the toast shows follows its
-- count; once it goes, so does the toast.
ns.On("WHILE_HERE_CHANGED", function()
	local E = ns.Engine
	local list = E and E.GetWhileHereList and E.GetWhileHereList() or {}
	local new, cur = nil, nil
	for _, v in ipairs(list) do
		if (v.appeared or 0) > seen and (not new or v.appeared > new.appeared) then new = v end
		if shownKey and v.appeared == shownKey then cur = v end
	end
	if not new then
		if cur then
			if f and f:IsShown() then f.Text:SetText(text(cur)) end
		else
			shownKey = nil
			T.Hide()
		end
		return
	end
	seen = new.appeared
	if not ns.IsLoggedIn() then return end
	T.Chime()
	-- Hidden or paused, Polestar keeps no toast for later: the window's panel lists the line when it is back.
	if windowShows() or ns.Hidden() or ns.PauseHides("nagging") then return end
	shownKey = new.appeared
	T.Show(new)
end)

-- Hiding Polestar takes the toast down at once.
ns.On("POLESTAR_HIDDEN", function(hidden)
	if not (hidden and f and f:IsShown()) then return end
	token = token + 1
	shownKey = nil
	f:Hide()
end)

-- So does pausing.
ns.On("POLESTAR_PAUSED", function()
	if not (ns.PauseHides("nagging") and f and f:IsShown()) then return end
	token = token + 1
	shownKey = nil
	f:Hide()
end)
