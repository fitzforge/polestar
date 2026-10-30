-- A Polestar button on the edge of the minimap (setting maps.minimapButton,
-- off by default): click shows or hides the guide window, right-click opens
-- Polestar's menu (the guide window, the guides, Lookup, the settings, a
-- report), drag moves it around the edge. Where it sits is
-- maps.minimapButtonAngle, in degrees (0 = east, counter-clockwise); on a
-- square minimap (GetMinimapShape, set by minimap addons) it rides the
-- square's edge instead of the circle.
--
-- The game's addon compartment (the minimap's addon list, on clients that
-- have one: AddonCompartmentFrame) does the same through the globals the
-- .toc names: Polestar_OnAddonCompartmentClick / OnEnter / OnLeave.
--
-- Cost: nothing until the setting is first turned on (no frame exists).

local ADDON, ns = ...
local Maps = ns.Maps
local L = ns.L

local abs, floor, max = math.abs, math.floor, math.max
local cos, sin, atan2, rad, deg = math.cos, math.sin, math.atan2, math.rad, math.deg

local SIZE = 32
local EDGE = 5 -- pixels past the minimap's edge, so the button sits on its border

local button

local function angle()
	local a = tonumber(ns.Get("maps.minimapButtonAngle"))
	return a and a % 360 or 225
end

local function place(a)
	local x, y = cos(rad(a)), sin(rad(a))
	if GetMinimapShape and GetMinimapShape() == "SQUARE" then
		local m = max(abs(x), abs(y))
		x, y = x / m, y / m
	end
	button:ClearAllPoints()
	button:SetPoint("CENTER", Minimap, "CENTER", x * (Minimap:GetWidth() / 2 + EDGE), y * (Minimap:GetHeight() / 2 + EDGE))
end

-- The cursor's angle around the minimap's centre, in whole degrees.
local function cursorAngle()
	local mx, my = Minimap:GetCenter()
	local scale = Minimap:GetEffectiveScale()
	local cx, cy = GetCursorPosition()
	return floor(deg(atan2(cy / scale - my, cx / scale - mx)) + 0.5) % 360
end

local function showTip(self)
	ns.Widgets.Tooltip(self, "ANCHOR_LEFT", "Polestar", {
		L["Click: show or hide the guide"],
		L["Right-click: menu"],
		self == button and L["Drag: move it around the minimap"] or nil,
	})
end

-- Polestar's menu from the minimap button or the compartment, opening
-- beside `anchor`.
function Maps.ShowMenu(anchor)
	local W = ns.Widgets
	if not (W and W.ShowMenu and anchor) then return end
	if W.MenuShown(anchor) then return W.HideMenu() end
	local shown = ns.Get("ui.shown")
	W.ShowMenu(anchor, {
		{ text = shown and L["Hide window"] or L["Show window"], icon = "window", onClick = function() ns.Fire("TOGGLE_FRAME") end },
		{ text = L["Guides"], icon = "guides", onClick = function() ns.Fire("SHOW_PICKER") end },
		{ text = L["Lookup"], icon = "search", onClick = function() ns.Fire("SHOW_LOOKUP") end },
		{ text = L["Options"], icon = "sliders", onClick = function() ns.Fire("SHOW_OPTIONS") end },
		{ separator = true },
		{ text = L["Report a problem"], icon = "bug", onClick = function() ns.Fire("SHOW_REPORT") end },
	}, { point = "TOPRIGHT", relPoint = "BOTTOMLEFT", x = 4, y = 4 })
end

-- The addon compartment's entry (Polestar.toc). The client passes the
-- addon's name, the mouse button and the compartment's row.
function Polestar_OnAddonCompartmentClick(_, which, row)
	if which == "RightButton" then
		Maps.ShowMenu(row or UIParent)
	else
		ns.Fire("TOGGLE_FRAME")
	end
end

function Polestar_OnAddonCompartmentEnter(_, row)
	if row then showTip(row) end
end

function Polestar_OnAddonCompartmentLeave(_, row)
	if ns.Widgets then ns.Widgets.HideTooltip(row) end
end

local function build()
	if button then return button end
	local W = ns.Widgets
	if not (W and W.Tex and Minimap) then return nil end
	button = ns.CreateFrameUnder("Button", "PolestarMinimapButton", Minimap)
	button:SetSize(SIZE, SIZE)
	button:SetFrameStrata("MEDIUM")
	button:SetFrameLevel((Minimap:GetFrameLevel() or 1) + 8)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:RegisterForDrag("LeftButton")
	local back = W.Tex(button, "BACKGROUND", "circle", "panel")
	back:SetAllPoints(button)
	local logo = W.Tex(button, "ARTWORK", "logo")
	logo:SetSize(SIZE - 10, SIZE - 10)
	logo:SetPoint("CENTER", button, "CENTER", 0, 0)
	button.Icon = logo
	local hover = W.Tex(button, "HIGHLIGHT", "circle", "accent")
	hover:SetAllPoints(button)
	hover:SetAlpha(0.25)
	button:SetScript("OnClick", function(self, which)
		if which == "RightButton" then
			W.HideTooltip(self)
			Maps.ShowMenu(self)
		else
			ns.Fire("TOGGLE_FRAME")
		end
	end)
	button:SetScript("OnEnter", showTip)
	button:SetScript("OnLeave", function(self) W.HideTooltip(self) end)
	button:SetScript("OnDragStart", function(self)
		W.HideTooltip(self)
		self:SetScript("OnUpdate", function() place(cursorAngle()) end)
	end)
	button:SetScript("OnDragStop", function(self)
		self:SetScript("OnUpdate", nil)
		ns.Set("maps.minimapButtonAngle", cursorAngle())
	end)
	-- A resized minimap (Edit Mode, minimap addons) moves its edge.
	Minimap:HookScript("OnSizeChanged", function()
		if button:IsShown() then place(angle()) end
	end)
	button:Hide()
	return button
end

function Maps.RefreshMinimapButton()
	if ns.Get("maps.minimapButton") then
		if not build() then return end
		place(angle())
		button:Show()
	elseif button then
		button:Hide()
	end
end

ns.On("SETTING_CHANGED", function(path)
	if not ns.IsLoggedIn() then return end
	if path == "maps.minimapButton" or path == "maps.minimapButtonAngle" or path == "maps" or path == "" then
		Maps.RefreshMinimapButton()
	end
end)

ns.OnLogin(Maps.RefreshMinimapButton)
