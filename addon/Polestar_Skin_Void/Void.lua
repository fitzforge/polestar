-- Void: Polestar's night sky gone violet, through its Skin API
-- (docs/SKINS-API.md in the Polestar repository). Violet-black grounds, a
-- lilac ladder, a violet accent, the starfield's stars in lilac over a
-- magenta nebula haze. The frames, sizes, font, arrow and pins stay
-- Polestar's own. The smallest complete skin in the repository: a scheme
-- and a skin, forty lines.
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 1) then return end

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

local ACCENT = "#b48cff"

check("scheme void", Theme.RegisterScheme("void", {
	api = 1, name = "Void", addon = ADDON, author = "Polestar", version = "1.0",
	desc = "Violet-black grounds under a lilac ladder.",
	tokens = {
		bg = "#120b1ff7", panel = "#170f28fa", panelAlt = "#221738", sidebar = "#0c0716", footer = "#0f0919", sky = "#2a1a4e",
		text = "#f4eeff", textDim = "#c9bbe6", textMuted = "#9f90c2",
		ink = "#e6d8ff", star = "#dcc8ff", shade = "#05020c", scrim = "#09051a", onAccent = "#120b1f", shadow = "#05020cb3",
	},
	accent = ACCENT,
}))

local spec = {
	api = 1, name = "Void", addon = ADDON, author = "Polestar", version = "1.0",
	desc = "The night sky gone violet: lilac stars over a nebula, a violet accent.",
	base = "polestar", scheme = "void",
	tokens = { accent = ACCENT, haze = "#ff5ad666" },
	arrow = "3d", mapIcons = "polestar",
}
local PRESET = { ["ui.band"] = true, ["ui.haze"] = true, ["ui.starAlpha"] = 1, ["nav.lineStyle"] = "sparkle" }
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin void", Theme.RegisterSkin("void", spec))
