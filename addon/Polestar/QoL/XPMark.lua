-- The guide's level on the game's XP bar (qol.xpTargetMark): a thin accent
-- tick and the level the guide expects you to reach before it moves on
-- (Engine.LevelTarget: its first `level N` goal for this character from the
-- step shown, N above your level, or a point inside your level not reached
-- yet). A whole level's tick sits at the right end of this level's bar:
-- "Guide: 12" when the target is the next level, "Guide: 14 (4 levels)"
-- when it lies further on. A point inside this level (`level 12.4`) puts the
-- tick at that share of the bar ("Guide: 40% of this level"); one inside a
-- later level stays at the end ("Guide: 14 (40%)").
--
--   Polestar.QoL.XPMark.Label(level, target[, frac]) -> text | nil   -- pure; nil: no mark
--   Polestar.QoL.XPMark.Refresh()                            -- show, move or hide the mark now
--   Polestar.QoL.XPMark.frame                                -- the mark, once made
--
-- The game's XP bar (Blizzard_StatusTrackingBar: the experience bar of
-- StatusTrackingBarManager's containers) is only read, never changed: the
-- mark is a frame of Polestar's made under the bar shown (CreateFrameUnder,
-- docs/ARCHITECTURE.md, "Frames under the game's UI"), so it fades, hides and
-- resizes with it, and takes no mouse (the bar's own tooltip stays). No XP
-- bar shown (another addon replaced or hid it, the maximum level), no guide
-- or no target: no mark.

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local readable = ns.Compat.Readable

local type, max, format = type, math.max, string.format

local Mark = {}
QoL.XPMark = Mark

local TICK = 2        -- tick width
local OVERHANG = 2    -- the tick stands this far above and below the bar
local GAP = 3         -- between the label and the tick

function Mark.Label(level, target, frac)
	if type(level) ~= "number" or type(target) ~= "number" or target < level then return nil end
	local pct = type(frac) == "number" and frac > 0 and frac < 1 and math.floor(frac * 100 + 0.5) or nil
	if target == level then return pct and format(L["Guide: %d%% of this level"], pct) or nil end
	if pct then return format(L["Guide: %d (%d%%)"], target, pct) end
	if target == level + 1 then return format(L["Guide: %d"], target) end
	return format(L["Guide: %d (%d levels)"], target, target - level)
end

-- The experience bar the game shows, or nil.
local function xpBar()
	local info = StatusTrackingBarInfo
	local exp = type(info) == "table" and type(info.BarsEnum) == "table" and info.BarsEnum.Experience
	local manager = StatusTrackingBarManager
	local containers = exp and type(manager) == "table" and manager.barContainers
	if type(containers) ~= "table" then return nil end
	for i = 1, #containers do
		local bars = containers[i].bars
		local bar = type(bars) == "table" and bars[exp]
		if type(bar) == "table" and bar.StatusBar and bar.IsShown and bar:IsShown() then return bar end
	end
	return nil
end

-- PLAYER_LEVEL_UP's level: UnitLevel can lag the event.
local levelSeen = 0

local function playerLevel()
	return max(readable(UnitLevel and UnitLevel("player")) or 0, levelSeen)
end

local frame

local function paint()
	local T = ns.Theme
	if not (frame and T and T.Accent) then return end
	local r, g, b = T.Accent()
	frame.Tick:SetVertexColor(r, g, b, 1)
	frame.Label:SetTextColor(r, g, b, 1)
end

-- The tick at `share` of the bar from its left (nil: the right end).
local function place(share)
	local tick = frame.Tick
	local x = share and -(1 - share) * (frame:GetWidth() or 0) or 0
	tick:ClearAllPoints()
	tick:SetPoint("TOPRIGHT", frame, "TOPRIGHT", x, OVERHANG)
	tick:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", x, -OVERHANG)
end

local function build(bar)
	local T = ns.Theme
	frame = ns.CreateFrameUnder("Frame", nil, bar)
	local tick = frame:CreateTexture(nil, "OVERLAY")
	tick:SetTexture(T and T.Media and T.Media("white") or nil)
	tick:SetWidth(TICK)
	local label = frame:CreateFontString(nil, "OVERLAY")
	if T and T.Font then T.Font(label, "small") end
	if T and T.SetOutline then T.SetOutline(label, true) end
	label:SetJustifyH("RIGHT")
	label:SetPoint("RIGHT", tick, "LEFT", -GAP, 0)
	frame.Tick, frame.Label = tick, label
	place(nil)
	-- The bar resized (a new layout, a scale change): the share's tick follows.
	frame:SetScript("OnSizeChanged", function() place(frame.share) end)
	Mark.frame = frame
	paint()
	return frame
end

-- Over the bar's fill and frame art, as its own text is (OverlayFrame).
local function attach(bar)
	if not frame then build(bar) end
	if frame.bar ~= bar then
		frame.bar = bar
		frame:SetParent(bar)
		frame:ClearAllPoints()
		frame:SetAllPoints(bar.StatusBar)
	end
	frame:SetFrameStrata("MEDIUM")
	local over = bar.OverlayFrame
	frame:SetFrameLevel(((over and over:GetFrameLevel()) or bar:GetFrameLevel() or 1) + 1)
	return frame
end

function Mark.Refresh()
	local text, share
	if QoL.On("xpTargetMark") then
		local level = playerLevel()
		local cap = readable(GetMaxPlayerLevel and GetMaxPlayerLevel())
		local E = ns.Engine
		if level > 0 and not (cap and level >= cap) and E and E.LevelTarget then
			local target, _, frac = E.LevelTarget(level)
			text = Mark.Label(level, target, frac)
			if text and target == level then share = frac end
		end
	end
	local bar = text and xpBar()
	if not bar then
		if frame then frame:Hide() end
		return
	end
	attach(bar).Label:SetText(text)
	if frame.share ~= share then
		frame.share = share
		place(share)
	end
	frame:Show()
end

-- Next frame, after the game's bar and the engine took the same events.
local schedule = QoL.Coalesce(Mark.Refresh)

ns.RegisterEvent("PLAYER_LEVEL_UP", function(_, level)
	levelSeen = readable(level) or levelSeen
	schedule()
end)
QoL.WhileOn("xpTargetMark", "PLAYER_XP_UPDATE", schedule)
QoL.WhileOn("xpTargetMark", "PLAYER_ENTERING_WORLD", schedule)
QoL.OnStep(schedule)
ns.OnLogin(schedule)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.xpTargetMark" or path == "qol" or path == "" then schedule() end
end)
if ns.Theme and ns.Theme.OnChanged then ns.Theme.OnChanged(paint) end
