-- The floating button (setting ui.launcher, off by default): a small
-- Polestar button the player puts anywhere on the screen, for hiding and
-- showing Polestar without typing. It works as the minimap button does
-- (Maps/MinimapButton.lua): click hides or shows everything Polestar shows
-- (Polestar.ToggleHidden), right-click opens Polestar's menu
-- (Maps.ShowMenu), drag moves it (with ui.lockHud on, only a Shift-drag:
-- ns.DragLocked). Where it stands is ui.launcherPos, its centre from the
-- screen's bottom-left corner.
--
-- It follows the window's own rules (GuideFrame.RulesHide): it hides in a
-- fight when the window does (ui.combat "hide") and in a dungeon or
-- battleground the window waits out (ui.instance "hide"), and comes back
-- with the window there. It stays when the player hides the window or
-- Polestar (its logo greyed and dimmed then, Maps.PaintHidden): it is the
-- way back.
--
-- Its look (the Buttons page, QoL/ButtonsOptions.lua): ui.launcherSize,
-- ui.launcherAlpha, ui.launcherIcon (the logo, or the emblem in the accent or
-- white) and ui.launcherBack (the disc behind it). Launcher.Face and
-- Launcher.Paint draw the live button and the settings preview's alike.
--
-- Cost: nothing until the setting is first turned on (no frame exists).

local ADDON, ns = ...
local UI = ns.UI
local L = ns.L

local floor = math.floor

ns.RegisterDefaults("ui", {
	launcher = false,
	-- launcherPos = { x, y } once it has been moved
	launcherSize = 32,
	launcherAlpha = 1,
	launcherIcon = "logo", -- logo | accent | white
	launcherBack = true,
})

local Launcher = {}
UI.Launcher = Launcher

-- Out of the box: beside the guide window's top-left corner in its default
-- place (UI/GuideFrame.lua: top right, 64 in, 240 down, 340 wide).
local DEFAULT_X, DEFAULT_Y = -440, -256

local button

-- A Polestar mark in `mode`: "accent" or "white" the one-colour emblem,
-- else the full-colour logo. Also the minimap button's (MinimapButton.lua).
function Launcher.PaintIcon(tex, mode)
	local W = ns.Widgets
	if mode == "accent" or mode == "white" then
		tex:SetTexture(ns.Theme.Media("emblem"))
		if mode == "accent" then
			W.Color(tex, "accent")
			return
		end
	else
		tex:SetTexture(ns.Theme.Media("logo"))
	end
	W.Uncolor(tex)
	tex:SetVertexColor(1, 1, 1, 1)
end

-- The disc, the mark and the hover on a plain Button: the live one and the
-- settings preview's.
function Launcher.Face(b)
	local W = ns.Widgets
	local back = W.Tex(b, "BACKGROUND", "circle", "panel")
	back:SetAllPoints(b)
	b.Back = back
	local logo = b:CreateTexture(nil, "ARTWORK")
	logo:SetPoint("CENTER", b, "CENTER", 0, 0)
	b.Icon = logo
	-- The hover's 25 % in its colour, held through a SetAlpha, as the minimap
	-- button's (MinimapButton.lua).
	local hover = W.HoldColorAlpha(W.Color(W.Tex(b, "HIGHLIGHT", "circle"), "accent", 0.25))
	hover:SetAllPoints(b)
	b.Hover = hover
	Launcher.Paint(b)
	return b
end

-- The look settings on a face: size (the mark 22/32 of it), opacity, mark,
-- disc; then the skin in use's own touch (its actionButton hook, kind
-- "launcher"). Not protected: at any time.
function Launcher.Paint(b)
	local size = tonumber(ns.Get("ui.launcherSize")) or 32
	size = math.max(16, math.min(96, size))
	b:SetSize(size, size)
	local mark = floor(size * 22 / 32 + 0.5)
	b.Icon:SetSize(mark, mark)
	Launcher.PaintIcon(b.Icon, ns.Get("ui.launcherIcon"))
	b:SetAlpha(math.max(0.1, math.min(1, tonumber(ns.Get("ui.launcherAlpha")) or 1)))
	b.Back:SetShown(ns.Get("ui.launcherBack") and true or false)
	local T = ns.Theme
	if T and T.SkinHooks and T.SkinHooks("actionButton") then
		local p = b.psSkinParts
		if not p then
			p = { ground = b.Back, icon = b.Icon, highlight = b.Hover }
			b.psSkinParts = p
		end
		T.SkinHook("actionButton", b, "launcher", p, false)
	end
end

local function place()
	button:ClearAllPoints()
	local pos = ns.Get("ui.launcherPos")
	if type(pos) == "table" and type(pos[1]) == "number" and type(pos[2]) == "number" then
		button:SetPoint("CENTER", UIParent, "BOTTOMLEFT", pos[1], pos[2])
	else
		button:SetPoint("CENTER", UIParent, "TOPRIGHT", DEFAULT_X, DEFAULT_Y)
	end
end

-- The minimap button's tooltip and dimmed look (Maps/MinimapButton.lua), shared.
local function showTip(self)
	local M = ns.Maps
	if M and M.ButtonTip then M.ButtonTip(self, ns.Get("ui.lockHud") and L["Shift-drag: move it"] or L["Drag: move it"]) end
end

local function paintHidden()
	local M = ns.Maps
	if button and M and M.PaintHidden then M.PaintHidden(button) end
end

local function build()
	if button then return button end
	local W = ns.Widgets
	if not (W and W.Tex and UIParent) then return nil end
	button = CreateFrame("Button", "PolestarLauncher", UIParent)
	button:SetFrameStrata("MEDIUM")
	button:SetMovable(true)
	button:SetClampedToScreen(true)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:RegisterForDrag("LeftButton")
	Launcher.Face(button)
	button:SetScript("OnClick", function(self, which)
		if which == "RightButton" then
			W.HideTooltip(self)
			ns.Maps.ShowMenu(self)
		else
			ns.ToggleHidden()
			if GameTooltip and GameTooltip:GetOwner() == self then showTip(self) end
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
		paintHidden()
		button:Show()
	elseif button then
		button:Hide()
	end
end

ns.On("GUIDE_VISIBILITY", function()
	if ns.IsLoggedIn() and (button or ns.Get("ui.launcher")) then Launcher.Refresh() end
end)

ns.On("POLESTAR_HIDDEN", paintHidden)

ns.On("SETTING_CHANGED", function(path)
	if not ns.IsLoggedIn() then return end
	if path == "ui.launcher" or path == "ui.launcherPos" or path == "ui" or path == "" then Launcher.Refresh() end
	if button and (path == "ui.launcherSize" or path == "ui.launcherAlpha" or path == "ui.launcherIcon" or path == "ui.launcherBack" or path == "ui" or path == "") then
		Launcher.Paint(button)
	end
end)

ns.OnLogin(Launcher.Refresh)

-- A new skin: its hook (or none) on the button again.
if ns.Theme and ns.Theme.OnChanged then
	ns.Theme.OnChanged(function() if button then Launcher.Paint(button) end end)
end
