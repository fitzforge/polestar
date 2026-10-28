-- Breath warning (qol.breathWarning, off by default): while the game's breath
-- timer runs down under water, a red pulse round the screen's edge, the
-- raid-warning sound and the taskbar flash when WARN_AT seconds are left, and
-- again at LAST_AT. Nothing while breath fills back up; the edge goes the
-- moment the timer stops or turns.
--
-- Client: MIRROR_TIMER_START(timer, value, maxValue, scale, paused, label) and
-- MIRROR_TIMER_STOP(timer), GetMirrorTimerProgress("BREATH") (milliseconds
-- left), PlaySound(SOUNDKIT.RAID_WARNING), FlashClientIcon.

local ADDON, ns = ...
local QoL = ns.QoL

local Breath = {}
QoL.Breath = Breath

local WARN_AT, LAST_AT = 10, 4 -- seconds of breath left
local POLL = 0.25

local edge, ticker
local warned -- the last mark said: WARN_AT or LAST_AT

-- A soft red frame round the screen, pulsing; made on first use.
local function edgeFrame()
	if edge then return edge end
	edge = CreateFrame("Frame", nil, UIParent)
	edge:SetAllPoints(UIParent)
	edge:SetFrameStrata("FULLSCREEN_DIALOG")
	edge:EnableMouse(false)
	local function side(p1, p2, w, h)
		local t = edge:CreateTexture(nil, "OVERLAY")
		t:SetColorTexture(0.85, 0.1, 0.1, 0.45)
		t:SetPoint(p1)
		t:SetPoint(p2)
		if w then t:SetWidth(w) end
		if h then t:SetHeight(h) end
	end
	side("TOPLEFT", "BOTTOMLEFT", 18, nil)
	side("TOPRIGHT", "BOTTOMRIGHT", 18, nil)
	side("TOPLEFT", "TOPRIGHT", nil, 18)
	side("BOTTOMLEFT", "BOTTOMRIGHT", nil, 18)
	local pulse = edge:CreateAnimationGroup()
	pulse:SetLooping("BOUNCE")
	local fade = pulse:CreateAnimation("Alpha")
	fade:SetFromAlpha(1)
	fade:SetToAlpha(0.3)
	fade:SetDuration(0.5)
	edge.Pulse = pulse
	edge:Hide()
	return edge
end

local function alarm()
	if PlaySound and SOUNDKIT and SOUNDKIT.RAID_WARNING then PlaySound(SOUNDKIT.RAID_WARNING, "Master") end
	if FlashClientIcon then FlashClientIcon() end
	local f = edgeFrame()
	f:Show()
	if not (ns.Get("ui.reduceMotion")) then f.Pulse:Play() end
end

local function stop()
	if ticker then
		ticker:Cancel()
		ticker = nil
	end
	warned = nil
	if edge then
		edge.Pulse:Stop()
		edge:Hide()
	end
end

-- Seconds of breath left, or nil when the timer is not running down.
function Breath.Left()
	local ms = GetMirrorTimerProgress and GetMirrorTimerProgress("BREATH")
	return type(ms) == "number" and ms / 1000 or nil
end

local function check()
	local left = Breath.Left()
	if not left then return stop() end
	if left <= LAST_AT and warned ~= LAST_AT then
		warned = LAST_AT
		alarm()
	elseif left <= WARN_AT and not warned then
		warned = WARN_AT
		alarm()
	end
end

local function onStart(_, timer, _, _, scale)
	if timer ~= "BREATH" then return end
	-- Breath filling back up (scale above 0) needs no warning.
	if type(scale) == "number" and scale >= 0 then return stop() end
	if not ticker then ticker = ns.NewTicker(POLL, check) end
	check()
end

local function onStop(_, timer)
	if timer == "BREATH" then stop() end
end

QoL.WhileOn({ "breathWarning" }, "MIRROR_TIMER_START", onStart)
QoL.WhileOn({ "breathWarning" }, "MIRROR_TIMER_STOP", onStop)
ns.On("SETTING_CHANGED", function(path)
	if (path == "qol.breathWarning" or path == "qol" or path == "") and not QoL.On("breathWarning") then stop() end
end)
