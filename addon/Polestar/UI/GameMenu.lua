-- A "Polestar" button in the game menu (Esc), setting ui.gameMenuButton (on
-- by default, under Appearance > Windows > Menus): it closes the menu and
-- opens the guide menu (SHOW_PICKER).
--
-- Taint: the game menu is Blizzard's, and its buttons are secure. A client
-- whose menu lays its buttons out itself (GameMenuFrame:InitButtons and
-- :AddButton) gets ours through that, after the menu's own list. Otherwise
-- the button is our own frame, made under UIParent and then set under the
-- menu (so it shows and hides with it), anchored below the menu's bottom
-- edge: no Blizzard button is moved, resized or re-anchored, the menu's
-- size is left alone, and nothing is written into its tables. Esc keeps
-- closing the menu as before.
--
-- With the gamepad interface (ns.GamepadUI) there is no button: its focus
-- owns the game menu, and a frame of ours in it would be one more to walk.
--
-- Cost: one frame, made the first time the menu opens with the setting on.

local ADDON, ns = ...
local UI = ns.UI
local L = ns.L

ns.RegisterDefaults("ui", {
	gameMenuButton = true,
})

local GameMenu = {}
UI.GameMenu = GameMenu

local button

function GameMenu.Open()
	local menu = _G.GameMenuFrame
	if menu and menu:IsShown() and not ns.GamepadUI() then
		if HideUIPanel then HideUIPanel(menu) else menu:Hide() end
	end
	ns.Fire("SHOW_PICKER")
end

local function build(menu)
	if button then return button end
	button = CreateFrame("Button", "PolestarGameMenuButton", UIParent, "UIPanelButtonTemplate")
	button:SetParent(menu)
	local ref = _G.GameMenuButtonContinue
	local w, h = ref and ref:GetWidth() or 0, ref and ref:GetHeight() or 0
	button:SetSize(w > 0 and w or 144, h > 0 and h or 21)
	button:SetText("Polestar")
	button:SetPoint("TOP", menu, "BOTTOM", 0, -4)
	button:SetScript("OnClick", function()
		if PlaySound and SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION) end
		GameMenu.Open()
	end)
	return button
end

function GameMenu.Refresh()
	local menu = _G.GameMenuFrame
	if not menu or GameMenu.managed then return end
	if ns.Get("ui.gameMenuButton") and not ns.GamepadUI() then
		build(menu):Show()
	elseif button then
		button:Hide()
	end
end

-- The button, when it is our own frame (nil on a client that lays the menu
-- out itself, or before the menu first opened).
function GameMenu.Button() return button end

local function hook()
	local menu = _G.GameMenuFrame
	if not menu or GameMenu.hooked then return end
	GameMenu.hooked = true
	-- The menu's own layout methods are its mixin's, copied into its table.
	if type(rawget(menu, "InitButtons")) == "function" and type(rawget(menu, "AddButton")) == "function" then
		GameMenu.managed = true
		hooksecurefunc(menu, "InitButtons", function(self)
			if ns.Get("ui.gameMenuButton") and not ns.GamepadUI() then self:AddButton("Polestar", GameMenu.Open) end
		end)
		return
	end
	menu:HookScript("OnShow", GameMenu.Refresh)
end

ns.On("SETTING_CHANGED", function(path)
	if path == "ui.gameMenuButton" or path == "ui" or path == "" then GameMenu.Refresh() end
end)

ns.OnLogin(hook)
