-- env: world
-- The Buttons page's floating and minimap buttons and its presets (Polestar_Options/QoL/ButtonsOptions.lua;
-- UI/Launcher.lua, Maps/MinimapButton.lua, QoL/Buttons.lua) on the whole addon: the live floating button (turned
-- on for its looks), the minimap button and the action button set.
local function rgba(t) local r, g, b, a = t:GetVertexColor(); return { r, g, b, a } end
local function pt(b) local p, _, rp, x, y = b:GetPoint(1); return { p, rp, x, y } end
local function icon(b) return { b.Icon:GetTexture(), rgba(b.Icon) } end
local LAUNCHER = { ["ui.launcher"] = true }
return {
	probes = {
		["ui.launcherSize"] = { with = LAUNCHER, probe = function() return PolestarLauncher:GetWidth() end },
		["ui.launcherAlpha"] = { with = LAUNCHER, probe = function() return PolestarLauncher:GetAlpha() end },
		["ui.launcherIcon"] = { with = LAUNCHER, probe = function() return icon(PolestarLauncher) end },
		["ui.launcherBack"] = { with = LAUNCHER, probe = function() return PolestarLauncher.Back:IsShown() and true or false end },
		["maps.minimapButtonSize"] = function() return PolestarMinimapButton:GetWidth() end,
		["maps.minimapButtonIcon"] = function() return icon(PolestarMinimapButton) end,
		-- A preset card: the set's scale, its line-up and its opacity out of combat.
		["Buttons:Presets"] = function()
			local B = Polestar.QoL.Buttons
			return { B.Holder():GetScale(), pt(PolestarHearthButton), PolestarQuestItemButton:GetAlpha() }
		end,
	},
}
