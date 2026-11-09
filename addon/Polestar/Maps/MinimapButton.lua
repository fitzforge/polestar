-- A Polestar button on the edge of the minimap (setting maps.minimapButton,
-- on by default): click shows or hides the guide window, right-click opens
-- Polestar's menu (the guide window, the guides, Lookup, the settings, a
-- report), drag moves it around the edge. Where it sits is
-- maps.minimapButtonAngle, in degrees (0 = east, counter-clockwise); on a
-- square minimap (GetMinimapShape, set by minimap addons) it rides the
-- square's edge instead of the circle.
--
-- Minimap button collectors (a flyout or a row of buttons gathered from
-- the minimap's named children) take it as they take any addon's button:
-- it is a Button named PolestarMinimapButton, a child of Minimap, with its
-- icon at button.Icon. Once one has moved it (into its own panel, or onto
-- its own row), the button is theirs to place: a drag or a resized
-- minimap no longer pulls it back to the edge, and click and right-click
-- work as before.
--
-- The game's addon compartment (the minimap's addon list, on clients that
-- have one: AddonCompartmentFrame) does the same through the globals the
-- .toc names: Polestar_OnAddonCompartmentClick / OnEnter / OnLeave.
--
-- Its size and mark (the logo, or the emblem in the accent or white) are
-- maps.minimapButtonSize and maps.minimapButtonIcon, on the Buttons page;
-- Maps.MinimapButtonFace draws the live button and the settings preview's.
--
-- Cost: nothing for a player who turned it off (no frame exists until the
-- setting is first on).

local ADDON, ns = ...
local Maps = ns.Maps
local L = ns.L

local abs, floor, max, min = math.abs, math.floor, math.max, math.min
local cos, sin, atan2, rad, deg = math.cos, math.sin, math.atan2, math.rad, math.deg

local EDGE = 5 -- pixels past the minimap's edge, so the button sits on its border

-- Its look (the Buttons page, QoL/ButtonsOptions.lua).
ns.RegisterDefaults("maps", {
	minimapButtonSize = 32,
	minimapButtonIcon = "logo", -- logo | accent | white
})

local button
-- Where place() last put the button: "CENTER" of Minimap at these offsets.
local placedX, placedY

-- Whether the button still sits where place() put it (or nowhere yet). A
-- collector that reparented it or anchored it elsewhere owns its place.
local function ours()
	if button:GetParent() ~= Minimap then return false end
	if placedX == nil then return true end
	local point, rel, relPoint, x, y = button:GetPoint(1)
	if point == nil then return true end
	return point == "CENTER" and rel == Minimap and relPoint == "CENTER"
		and abs((x or 0) - placedX) < 0.5 and abs((y or 0) - placedY) < 0.5
end

local function angle()
	local a = tonumber(ns.Get("maps.minimapButtonAngle"))
	return a and a % 360 or 225
end

local function place(a)
	if not ours() then return end
	local x, y = cos(rad(a)), sin(rad(a))
	if GetMinimapShape and GetMinimapShape() == "SQUARE" then
		local m = max(abs(x), abs(y))
		x, y = x / m, y / m
	end
	placedX, placedY = x * (Minimap:GetWidth() / 2 + EDGE), y * (Minimap:GetHeight() / 2 + EDGE)
	button:ClearAllPoints()
	button:SetPoint("CENTER", Minimap, "CENTER", placedX, placedY)
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
	local shown = ns.GuideShown()
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

-- The mark in maps.minimapButtonIcon: "accent" or "white" the one-colour
-- emblem, else the full-colour logo (as the floating button's,
-- UI/Launcher.lua).
local function paintIcon(tex, mode)
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

-- The look settings on a face: its size (maps.minimapButtonSize, the mark
-- 22/32 of it) and mark. A collector that sizes the button its own way does
-- so again after it.
function Maps.PaintMinimapButton(b)
	local size = max(20, min(64, tonumber(ns.Get("maps.minimapButtonSize")) or 32))
	b:SetSize(size, size)
	local mark = floor(size * 22 / 32 + 0.5)
	b.Icon:SetSize(mark, mark)
	paintIcon(b.Icon, ns.Get("maps.minimapButtonIcon"))
end

-- The disc, the mark and the hover on a plain Button: the live one (its
-- mark named iconName) and the settings preview's.
function Maps.MinimapButtonFace(b, iconName)
	local W = ns.Widgets
	local back = W.Tex(b, "BACKGROUND", "circle", "panel")
	back:SetAllPoints(b)
	local logo = b:CreateTexture(iconName, "ARTWORK")
	logo:SetPoint("CENTER", b, "CENTER", 0, 0)
	b.Icon = logo
	-- The hover: the accent at 25 %, the strength in its colour (W.Color's
	-- alpha, kept through theme repaints), not in the region's own alpha, so a
	-- button bar that shows our regions again at full alpha cannot turn it into
	-- an opaque disc over the logo.
	local hover = W.Tex(b, "HIGHLIGHT", "circle")
	W.Color(hover, "accent", 0.25)
	hover:SetAllPoints(b)
	b.Hover = hover
	Maps.PaintMinimapButton(b)
	return b
end

local function build()
	if button then return button end
	local W = ns.Widgets
	if not (W and W.Tex and Minimap) then return nil end
	button = ns.CreateFrameUnder("Button", "PolestarMinimapButton", Minimap)
	button:SetFrameStrata("MEDIUM")
	button:SetFrameLevel((Minimap:GetFrameLevel() or 1) + 8)
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp")
	button:RegisterForDrag("LeftButton")
	-- Named PolestarMinimapButtonIcon: minimap tidiers that stand a proxy in
	-- for the button (Leatrix Plus's Enhance minimap) take its icon from
	-- _G[name .. "Icon"]; without it they took the last small region, the
	-- hover's plain circle, and showed that as Polestar's icon.
	Maps.MinimapButtonFace(button, "PolestarMinimapButtonIcon")
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
		if not ours() then return end
		self:SetScript("OnUpdate", ns.Safe(function() place(cursorAngle()) end))
	end)
	button:SetScript("OnDragStop", function(self)
		if not self:GetScript("OnUpdate") then return end
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
	if button and (path == "maps.minimapButtonSize" or path == "maps.minimapButtonIcon" or path == "maps" or path == "") then
		Maps.PaintMinimapButton(button)
	end
end)

ns.OnLogin(Maps.RefreshMinimapButton)
