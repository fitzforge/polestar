-- A "Polestar" button in the game menu (Esc), setting ui.gameMenuButton (on
-- by default, under Appearance > Windows > Menus): it closes the menu and
-- opens the guide menu (SHOW_PICKER). It works in combat too.
--
-- Where: in the addon section near the top (Fitz, 2026-11-09: not under
-- "Return to Game"). Forever's menu (Blizzard_GameMenu) builds its buttons
-- in InitButtons from a pool, then a vertical layout stacks every shown
-- child by layoutIndex, a button's topPadding opening a section (Options,
-- Shop | AddOns, Edit Mode, Support, Macros | Log Out, Exit Game | Return to
-- Game). Ours is our own child of the menu with a layoutIndex between Shop's
-- (Options' without a shop) and the next button's and a section's padding:
-- a small section of its own after Shop. With EllesmereUI's button shown
-- there (EllesmereUI anchors its buttons below Shop and moves the menu's
-- buttons down to make room), ours goes right under EllesmereUI's last
-- button, and a spacer of ours in the layout keeps the room for it.
--
-- Taint: nothing of Blizzard's is written or moved. Our frames are made
-- under UIParent and then set under the menu; the hook after InitButtons
-- only reads the pool's buttons (their text, layoutIndex and size) and sets
-- fields on our own frames; the menu's own Layout places them. A client
-- with no InitButtons (the older menu of fixed buttons) gets the button
-- below the menu's bottom edge. Esc keeps closing the menu as before.
--
-- With the gamepad interface (ns.GamepadUI) there is no button: its focus
-- owns the game menu, and a frame of ours in it would be one more to walk.
--
-- Cost: two frames, made the first time the menu opens with the setting on.

local ADDON, ns = ...
local UI = ns.UI

ns.RegisterDefaults("ui", {
	gameMenuButton = true,
})

local GameMenu = {}
UI.GameMenu = GameMenu

local SECTION = 20 -- the menu's own section gap (MainMenuFrameMixin.AddSection)
local GAP = 4 -- under EllesmereUI's last button, as its two buttons are apart

local button, spacer

function GameMenu.Open()
	local menu = _G.GameMenuFrame
	if menu and menu:IsShown() and not ns.GamepadUI() then
		if HideUIPanel then HideUIPanel(menu) else menu:Hide() end
	end
	ns.Fire("SHOW_PICKER")
end

local function wanted() return ns.Get("ui.gameMenuButton") and not ns.GamepadUI() end

local function build(menu, template)
	if button then return button end
	button = CreateFrame("Button", "PolestarGameMenuButton", UIParent, template)
	button:SetParent(menu)
	button:SetSize(144, 21)
	button:SetText("Polestar")
	button:SetScript("OnClick", function()
		if PlaySound and SOUNDKIT and SOUNDKIT.IG_MAINMENU_OPTION then PlaySound(SOUNDKIT.IG_MAINMENU_OPTION) end
		GameMenu.Open()
	end)
	button:Hide()
	return button
end

-- The pooled button ours follows: Shop, else Options; and the next layout
-- index after it (the next button's, or one more).
local function anchorButton(menu)
	local pool = menu.buttonPool
	if not (pool and pool.EnumerateActive) then return nil end
	local shop, options, indexes = nil, nil, {}
	for b in pool:EnumerateActive() do
		local text = b.GetText and b:GetText()
		if text ~= nil and text == _G.BLIZZARD_STORE then shop = b end
		if text ~= nil and text == _G.GAMEMENU_OPTIONS then options = b end
		if type(b.layoutIndex) == "number" then indexes[#indexes + 1] = b.layoutIndex end
	end
	local after = shop or options
	if not (after and type(after.layoutIndex) == "number") then return nil end
	local nextIndex = after.layoutIndex + 1
	for _, i in ipairs(indexes) do
		if i > after.layoutIndex and i < nextIndex then nextIndex = i end
	end
	return after, after.layoutIndex, nextIndex
end

-- EllesmereUI's last button shown under Shop this time, or nil: it shows them
-- out of combat unless its settings hide them (EllesmereUIDB, read only).
local function ellesmereLast()
	local main, unlock = _G.EllesmereUI_GameMenuButton, _G.EllesmereUI_UnlockMenuButton
	if not main or (InCombatLockdown and InCombatLockdown()) then return nil end
	local db = _G.EllesmereUIDB
	local showMain = not (type(db) == "table" and db.hideGameMenuButton)
	local showUnlock = unlock ~= nil and type(db) == "table" and db.hideUnlockMenuButton == false
	if showUnlock then return unlock end
	if showMain then return main end
	return nil
end

-- After the menu's InitButtons, before its Layout: place ours for this opening.
local function place(menu)
	local b = button
	if not wanted() then
		if b then b:Hide() end
		if spacer then spacer:Hide() end
		return
	end
	local after, index, nextIndex = anchorButton(menu)
	if not after then
		if b then b:Hide() end
		if spacer then spacer:Hide() end
		return
	end
	b = build(menu, "MainMenuFrameButtonTemplate")
	local w, h = after:GetWidth(), after:GetHeight()
	if w and w > 0 and h and h > 0 then b:SetSize(w, h) end
	local mid = index + (nextIndex - index) / 2
	local eui = ellesmereLast()
	b:ClearAllPoints()
	if eui then
		-- Under EllesmereUI's buttons; our spacer holds our room in the layout.
		if not spacer then
			spacer = CreateFrame("Frame", nil, UIParent)
			spacer:SetParent(menu)
		end
		spacer:SetSize(1, b:GetHeight() + GAP)
		spacer.layoutIndex, spacer.topPadding = mid, nil
		spacer:Show()
		b.layoutIndex, b.topPadding = nil, nil
		b:SetPoint("TOP", eui, "BOTTOM", 0, -GAP)
	else
		if spacer then spacer:Hide() end
		b.layoutIndex, b.topPadding = mid, SECTION
	end
	b:Show()
end

-- The older menu (no InitButtons): our button below the menu's bottom edge.
function GameMenu.Refresh()
	local menu = _G.GameMenuFrame
	if not menu or GameMenu.managed then return end
	if wanted() then
		build(menu, "UIPanelButtonTemplate")
		local ref = _G.GameMenuButtonContinue
		local w, h = ref and ref:GetWidth() or 0, ref and ref:GetHeight() or 0
		button:SetSize(w > 0 and w or 144, h > 0 and h or 21)
		button:ClearAllPoints()
		button:SetPoint("TOP", menu, "BOTTOM", 0, -4)
		button:Show()
	elseif button then
		button:Hide()
	end
end

-- The button, once made (nil before the menu first opened with it on).
function GameMenu.Button() return button end
function GameMenu.Spacer() return spacer end

local function hook()
	local menu = _G.GameMenuFrame
	if not menu or GameMenu.hooked then return end
	GameMenu.hooked = true
	-- The menu's own layout methods are its mixin's, copied into its table.
	if type(rawget(menu, "InitButtons")) == "function" then
		GameMenu.managed = true
		hooksecurefunc(menu, "InitButtons", place)
		return
	end
	menu:HookScript("OnShow", GameMenu.Refresh)
end

-- Turned off with the menu open: ours go now (the menu closes its gap when
-- it opens next); turned on, they come with the next opening.
ns.On("SETTING_CHANGED", function(path)
	if path ~= "ui.gameMenuButton" and path ~= "ui" and path ~= "" then return end
	if not GameMenu.managed then return GameMenu.Refresh() end
	if not wanted() then
		if button then button:Hide() end
		if spacer then spacer:Hide() end
	end
end)

ns.OnLogin(hook)
