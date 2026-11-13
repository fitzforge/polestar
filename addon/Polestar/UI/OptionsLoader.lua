-- The settings window's door in core. The window itself (UI/Options.lua),
-- its Look pages, their previews and the Profiles page are their own addon,
-- Polestar_Options (load on demand, like the walking routes): nothing of it
-- is in memory until the player first opens the settings. This file is what
-- stays resident:
--
--   UI.ShowOptions(section, ask)   opens the window (with a question
--                             `ask` in its search box: /polestar ask), loading
--                             Polestar_Options the first time
--                             (Polestar_Options/UI/Options.lua then puts the
--                             real UI.ShowOptions in its place)
--   UI.LoadOptions() -> true when the window's addon is loaded (loads it now
--                       if it can; profiles need its pages' controls)
--   the ui.optionsSize default (a saved setting before the window exists)
--   the Blizzard Settings category ("Polestar" under AddOns) and its button
--
-- Addons load nowhere near a fight (ns.Data.Pack refuses in combat): asked
-- then, it says so in chat once and opens the window when the fight ends.

local _, ns = ...
local UI, W = ns.UI, ns.Widgets
local L = ns.L

local PACK = "Polestar_Options"

ns.RegisterDefaults("ui", { optionsSize = false })

local stub -- this file's UI.ShowOptions, until the window's addon replaces it

function UI.LoadOptions()
	if UI.Options then return true end
	local Data = ns.Data
	if not (Data and Data.Pack) then return false, "unavailable" end
	local ok, why = Data.Pack(PACK)
	if not ok then return false, why end
	return UI.Options ~= nil, UI.Options == nil and "error" or nil
end

-- A request made in combat: the section to open when it ends (false: none)
-- and the question asked with it.
local waiting, waitingAsk = false, nil
local afterCombat

function afterCombat()
	ns.UnregisterEvent("PLAYER_REGEN_ENABLED", afterCombat)
	local section, ask = waiting, waitingAsk
	waiting, waitingAsk = false, nil
	UI.ShowOptions(section ~= true and section or nil, ask)
end

stub = function(section, ask)
	local ok, why = UI.LoadOptions()
	if ok and UI.ShowOptions ~= stub then return UI.ShowOptions(section, ask) end
	if why == "combat" then
		if not waiting then
			ns.Print(L["Polestar's settings open when combat ends."])
			ns.RegisterEvent("PLAYER_REGEN_ENABLED", afterCombat)
		end
		waiting, waitingAsk = section or true, ask
		return
	end
	ns.Print(string.format(L["Polestar's settings could not be loaded (%s): is the Polestar_Options folder installed and enabled?"], tostring(why or "error")))
end
UI.ShowOptions = stub

---------------------------------------------------------------------------
-- Blizzard Settings: a "Polestar" entry under AddOns that opens our window.
---------------------------------------------------------------------------

local function registerSettingsCategory()
	if not (Settings and Settings.RegisterCanvasLayoutCategory and Settings.RegisterAddOnCategory) then return end
	local canvas = CreateFrame("Frame")
	canvas:Hide()
	-- The About lockup at 48: the emblem's ink on the canvas's 16 edge, the
	-- wordmark (1:1) and the tagline centred on it, then the pitch.
	local emblem = W.Tex(canvas, "ARTWORK", "emblem", "accent")
	emblem:SetSize(48, 48)
	emblem:SetPoint("TOPLEFT", canvas, "TOPLEFT", 16 - 7, -16)
	local word = W.Tex(canvas, "ARTWORK", "wordmark", "text")
	word:SetSize(256, 32)
	word:SetPoint("TOPLEFT", canvas, "TOPLEFT", 66 - 3, -14)
	local tag = W.Text(canvas, "note", "textDim")
	tag:SetText(L["A community project"])
	tag:SetPoint("TOPLEFT", canvas, "TOPLEFT", 66, -48)
	local stage = W.Chip(canvas)
	stage:SetPoint("LEFT", tag, "RIGHT", 8, 0)
	W.SetStageChip(stage)
	local sub = W.Text(canvas, "note", "textDim")
	sub:SetText(L["Leveling guides for World of Warcraft: Forever."])
	sub:SetPoint("TOPLEFT", canvas, "TOPLEFT", 16, -80)
	local open = W.Button(canvas, L["Open Polestar settings"], function()
		-- Closing the game's Settings panel is protected in combat: from addon
		-- code it would fail and blame Polestar. Leave it open then, and with
		-- the gamepad interface, whose focus a panel closed from addon code
		-- leaves blocked (ns.GamepadUI): B closes it.
		local panel = SettingsPanel
		if panel and panel.IsShown and panel:IsShown() and HideUIPanel then
			if ns.GamepadUI() then
				ns.Print(L["Close the game menu to see Polestar's settings."])
			elseif InCombatLockdown and InCombatLockdown() then
				ns.Print(L["Close the game menu to see Polestar's settings (it cannot be closed for you in combat)."])
			else
				HideUIPanel(panel)
			end
		end
		UI.ShowOptions()
	end, { primary = true })
	open:SetPoint("TOPLEFT", sub, "BOTTOMLEFT", 0, -16)
	local ok, category = pcall(Settings.RegisterCanvasLayoutCategory, canvas, "Polestar")
	if ok and category then
		pcall(Settings.RegisterAddOnCategory, category)
		UI.settingsCategory = category
	end
end

ns.OnInit(registerSettingsCategory)
