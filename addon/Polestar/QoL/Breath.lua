-- Breath warning (qol.breathWarning, off by default): while the game's breath
-- timer runs down under water, a red pulse round the screen's edge, the
-- raid-warning sound and the taskbar flash when WARN_AT seconds are left, and
-- again at LAST_AT. Nothing while breath fills back up; the edge goes the
-- moment the timer stops or turns.
--
-- Client: MIRROR_TIMER_START(timer, value, maxValue, scale, paused, label)
-- (value and maxValue in milliseconds, scale below 0 while draining),
-- MIRROR_TIMER_PAUSE(timer, paused), MIRROR_TIMER_STOP(timer),
-- PLAYER_LEAVING_WORLD, GetTime, PlaySound(SOUNDKIT.RAID_WARNING),
-- FlashClientIcon. The countdown runs from START's value and scale.

local ADDON, ns = ...
local QoL = ns.QoL

local Breath = {}
QoL.Breath = Breath

local WARN_AT, LAST_AT = 10, 4 -- seconds of breath left
local POLL = 0.25

local edge, ticker
local warned -- the last mark said: WARN_AT or LAST_AT
local secondsLeft, startedAt

-- A soft red frame round the screen, pulsing; made on first use, on
-- Polestar's layer (it hides with Polestar).
local function edgeFrame()
	if edge then return edge end
	edge = CreateFrame("Frame", nil, ns.UIParent)
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

-- Nothing while Polestar is hidden: no sound, flash or edge.
local function alarm()
	if ns.Hidden() then return end
	if SOUNDKIT and SOUNDKIT.RAID_WARNING then ns.PlaySound(SOUNDKIT.RAID_WARNING, "Master") end
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
	secondsLeft, startedAt = nil, nil
	if edge then
		edge.Pulse:Stop()
		edge:Hide()
	end
end

-- Seconds of breath left, or nil when the timer is not running down.
function Breath.Left()
	if startedAt then return math.max(0, secondsLeft - (GetTime() - startedAt)) end
end

local function check()
	local left = Breath.Left()
	if not left then return end
	if left <= LAST_AT and warned ~= LAST_AT then
		warned = LAST_AT
		alarm()
	elseif left <= WARN_AT and not warned then
		warned = WARN_AT
		alarm()
	end
end

local function isPaused(paused)
	return paused == true or (type(paused) == "number" and paused > 0)
end

local function onStart(_, timer, value, cap, scale, paused)
	if timer ~= "BREATH" then return end
	if type(scale) ~= "number" or scale >= 0 or type(value) ~= "number"
		or type(cap) ~= "number" or cap <= 0 or value < 0 or value > cap then return stop() end
	secondsLeft = value / 1000 / -scale
	startedAt = nil
	-- A fresh dive's worth of breath: the marks can be said again.
	if warned and secondsLeft > WARN_AT then
		warned = nil
		if edge then
			edge.Pulse:Stop()
			edge:Hide()
		end
	end
	if not isPaused(paused) then startedAt = GetTime() end
	if not ticker then ticker = ns.NewTicker(POLL, check) end
	check()
end

local function onPause(_, timer, paused)
	if timer ~= "BREATH" or not secondsLeft then return end
	if isPaused(paused) then
		if startedAt then secondsLeft, startedAt = Breath.Left(), nil end
	elseif not startedAt then
		startedAt = GetTime()
		check()
	end
end

local function onStop(_, timer)
	if timer == "BREATH" then stop() end
end

QoL.WhileOn({ "breathWarning" }, "MIRROR_TIMER_START", onStart)
QoL.WhileOn({ "breathWarning" }, "MIRROR_TIMER_PAUSE", onPause)
QoL.WhileOn({ "breathWarning" }, "MIRROR_TIMER_STOP", onStop)
QoL.WhileOn({ "breathWarning" }, "PLAYER_LEAVING_WORLD", stop)
ns.On("SETTING_CHANGED", function(path)
	if (path == "qol.breathWarning" or path == "qol" or path == "") and not QoL.On("breathWarning") then stop() end
end)
