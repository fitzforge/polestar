-- Polestar Group Finder: the panel beside the guide window.
--
-- The panel first opens beside Theme.GuideParts().window (the guide
-- window's frame, Skin API 2), then stands on its own, and hides and comes
-- back with the guide window (UI/Panel.lua's SetHost / HostShown). The
-- guide window is built at its first show: tried at start, at each step
-- change and a few times after.

local _, ns = ...
local P = ns.P

local hostWindow

local function guideWindow()
	local T = P.Theme
	local parts = T.GuideParts and T.GuideParts()
	return type(parts) == "table" and parts.window or nil
end

local function attach()
	local window = guideWindow()
	if not window or window == hostWindow then return window ~= nil end
	hostWindow = window
	window:HookScript("OnShow", function() ns.UI.HostShown(true) end)
	window:HookScript("OnHide", function() ns.UI.HostShown(false) end)
	ns.UI.SetHost(window)
	return true
end

ns.On("POLESTAR", function()
	ns.On("POLESTAR_STEP", attach)
	local tries = 0
	local function retry()
		if attach() or tries >= 10 then return end
		tries = tries + 1
		ns.After(3, retry)
	end
	retry()
end)
