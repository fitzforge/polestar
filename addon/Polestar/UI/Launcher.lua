-- The floating button (setting ui.launcher, off by default): a small
-- Polestar button the player puts anywhere on the screen, for showing and
-- hiding the guide window without typing /polestar. It works as the minimap
-- button does (Maps/MinimapButton.lua): click shows or hides the window,
-- right-click opens Polestar's menu (Maps.ShowMenu), drag moves it (with
-- ui.lockHud on, only a Shift-drag: ns.DragLocked). Where it stands is
-- ui.launcherPos, its centre from the screen's bottom-left corner.
--
-- It follows the window's own rules (GuideFrame.RulesHide): it hides in a
-- fight when the window does (ui.combat "hide") and in a dungeon or
-- battleground the window waits out (ui.instance "hide"), and comes back
-- with the window there. It stays when the player hides the window: it is
-- the way to bring it back.
--
-- Cost: nothing until the setting is first turned on (no frame exists).

local ADDON, ns = ...
local UI = ns.UI
local L = ns.L

local floor = math.floor

ns.RegisterDefaults("ui", {
	launcher = false,
	-- launcherPos = { x, y } once it has been moved
})

local Launcher = {}
UI.Launcher = Launcher

local SIZE = 32
-- Out of the box: beside the guide window's top-left corner in its default
-- place (UI/GuideFrame.lua: top right, 64 in, 240 down, 340 wide).
local DEFAULT_X, DEFAULT_Y = -440, -256

local button

local function place()
	button:ClearAllPoints()
	local pos = ns.Get("ui.launcherPos")
	if type(pos) == "table" and type(pos[1]) == "number" and type(pos[2]) == "number" then
		button:SetPoint("CENTER", UIParent, "BOTTOMLEFT", pos[1], pos[2])
	else
		button:SetPoint("CENTER", UIParent, "TOPRIGHT", DEFAULT_X, DEFAULT_Y)
	end
end

local function showTip(self)
	ns.Widgets.Tooltip(self, "ANCHOR_LEFT", "Polestar", {
		L["Click: show or hide the guide"],
		L["Right-click: menu"],
		ns.Get("ui.lockHud") and L["Shift-drag: move it"] or L["Drag: move it"],
	})
end

local function build()
	if button then return button end
	local W = ns.Widgets
	if not (W and W.Tex and UIParent) then return nil end
	button = CreateFrame("Button", "PolestarLauncher", UIParent)
	button:SetSize(SIZE, SIZE)
	button:SetFrameStrata("MEDIUM")
	button:SetMovable(true)
	button:SetClampedToScreen(true)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:RegisterForDrag("LeftButton")
	local back = W.Tex(button, "BACKGROUND", "circle", "panel")
	back:SetAllPoints(button)
	local logo = W.Tex(button, "ARTWORK", "logo")
	logo:SetSize(SIZE - 10, SIZE - 10)
	logo:SetPoint("CENTER", button, "CENTER", 0, 0)
	button.Icon = logo
	-- The hover's 25 % in its colour, held through a SetAlpha, as the minimap
	-- button's (MinimapButton.lua).
	local hover = W.HoldColorAlpha(W.Color(W.Tex(button, "HIGHLIGHT", "circle"), "accent", 0.25))
	hover:SetAllPoints(button)
	button.Hover = hover
	button:SetScript("OnClick", function(self, which)
		if which == "RightButton" then
			W.HideTooltip(self)
			ns.Maps.ShowMenu(self)
		else
			ns.Fire("TOGGLE_FRAME")
		end
	end)
	button:SetScript("OnEnter", showTip)
	button:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	button:SetScript("OnDragStart", function(self)
		if ns.DragLocked() then return end
		W.HideTooltip(self)
		self.psMoving = true
		self:StartMoving()
	end)
	button:SetScript("OnDragStop", function(self)
		if not self.psMoving then return end
		self.psMoving = nil
		self:StopMovingOrSizing()
		local x, y = self:GetCenter()
		if x and y then ns.Set("ui.launcherPos", { floor(x + 0.5), floor(y + 0.5) }) end
	end)
	button:Hide()
	return button
end

-- Shown with the setting on, unless the window's rules hide the window now.
function Launcher.Wanted()
	if not ns.Get("ui.launcher") then return false end
	local GF = UI.GuideFrame
	return not (GF and GF.RulesHide and GF.RulesHide())
end

function Launcher.Refresh()
	if Launcher.Wanted() then
		if not build() then return end
		place()
		button:Show()
	elseif button then
		button:Hide()
	end
end

ns.On("GUIDE_VISIBILITY", function()
	if ns.IsLoggedIn() and (button or ns.Get("ui.launcher")) then Launcher.Refresh() end
end)

ns.On("SETTING_CHANGED", function(path)
	if not ns.IsLoggedIn() then return end
	if path == "ui.launcher" or path == "ui.launcherPos" or path == "ui" or path == "" then Launcher.Refresh() end
end)

ns.OnLogin(Launcher.Refresh)
