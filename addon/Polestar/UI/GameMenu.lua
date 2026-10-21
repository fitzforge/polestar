-- A "Polestar" button in the game menu (Escape), its own block right under
-- Options (where EllesmereUI puts its own): opens the hub at Home.
--
-- The game menu builds its buttons each time it shows
-- (Blizzard_GameMenu/Shared/GameMenuFrame.lua, GameMenuFrameMixin:InitButtons:
-- Options, the shop, a section, AddOns ...). MainMenuFrameMixin:AddButton
-- (Blizzard_SharedXML/Shared/Frame/MainMenuFrameTemplates.lua) gives each
-- button the next layoutIndex and the pending section's topPadding (20 after
-- AddSection), and the menu lays its buttons out by layoutIndex. The button
-- is added in a post-hook (hooksecurefunc, which never taints the caller) of
-- AddCloseButton, the last button InitButtons adds, so it is there while
-- InitButtons still runs: an addon that restyles the menu's buttons after
-- InitButtons (EllesmereUI) finds it with the others, the first time the
-- menu opens too. Then it is moved just past Options (a quarter step, so it
-- comes before another addon's button there) with a section's space above. The
-- name is coloured in its text: the menu's buttons are pooled, and a tint on
-- the font would stay on whichever button the pool hands out next. A client
-- without that menu (no InitButtons or AddButton) gets no button rather than
-- a guess, and the gamepad interface (its own menus) none at all.

local ADDON, ns = ...
local UI, Theme = ns.UI, ns.Theme
local L = ns.L

local GM = {}
UI.GameMenu = GM

local SECTION = 20 -- MainMenuFrameMixin:AddSection's default spacing

function GM.Open()
	if GameMenuFrame and HideUIPanel then HideUIPanel(GameMenuFrame) end
	if UI.ShowPicker then UI.ShowPicker({ section = "Home" }) end
end

local function optionsButton(menu)
	for _, b in ipairs(menu.buttons or {}) do
		if b.GetText and b:GetText() == GAMEMENU_OPTIONS then return b end
	end
end

local function addButton(menu)
	if menu ~= GameMenuFrame then return end
	local b = menu:AddButton("|c" .. Theme.Hex("accent") .. L["Polestar"] .. "|r", GM.Open)
	local options = optionsButton(menu)
	if not (b and options and type(options.layoutIndex) == "number") then return end
	b.layoutIndex = options.layoutIndex + 0.25
	b.topPadding = SECTION
	if menu.MarkDirty then menu:MarkDirty() end
end

function GM.Install()
	local menu = GameMenuFrame
	if GM.installed or ns.GamepadUI() or not (menu and hooksecurefunc and type(menu.InitButtons) == "function" and type(menu.AddButton) == "function") then
		return false
	end
	-- Without AddCloseButton, after InitButtons.
	hooksecurefunc(menu, type(menu.AddCloseButton) == "function" and "AddCloseButton" or "InitButtons", addButton)
	GM.installed = true
	return true
end

ns.OnLogin(GM.Install)
