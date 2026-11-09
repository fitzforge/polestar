-- Umbra: a dark mode for Polestar through its Skin API (docs/SKINS-API.md
-- in the Polestar repository). Neutral charcoal with no blue in it, a cool
-- grey ladder, a muted steel accent, the subject colours a quarter of the
-- way toward grey so nothing glows, the band's stars dimmed, the haze off.
-- The frames, sizes, font, arrow and pins stay Polestar's own.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * a scheme and a skin from ONE table of colours and nothing else: no
--     painters, no fonts, no media. The scheme serves the players who keep
--     Polestar's skin; the skin adds the quieter subject colours a scheme
--     may not carry (subject colours belong to skins).
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

local ACCENT = "#9fb4c7"

check("scheme umbra", Theme.RegisterScheme("umbra", {
	api = 1, name = "Umbra", addon = ADDON, author = "Polestar", version = "1.0",
	desc = "Dark mode: neutral charcoal, a cool grey ladder, a steel accent.",
	tokens = {
		bg = "#141516f7", panel = "#1a1b1dfa", panelAlt = "#232426", sidebar = "#0f1011", footer = "#111213", sky = "#1c1d20",
		text = "#ececec", textDim = "#b8b9bc", textMuted = "#8d8f93",
		ink = "#ffffff", star = "#ffffff59", shade = "#000000", scrim = "#0a0a0b", onAccent = "#141516", shadow = "#000000a6",
	},
	accent = ACCENT,
	washes = { border = 0.1, divider = 0.1, selected = 0.12, hover = 0.07 },
}))

local spec = {
	api = 1,
	name = "Umbra",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = "Dark mode: neutral charcoal, muted colours, Polestar's own frames.",
	base = "polestar",
	scheme = "umbra",
	tokens = {
		accent = ACCENT,
		-- Polestar's subjects, each a quarter of the way to grey.
		success = "#86cf9f", warning = "#e6b86b", danger = "#e08484", quest = "#e8cf8a", npc = "#9fc3e8", item = "#c3b3e6",
		place = "#e2ad8d", object = "#d2c7b2", level = "#eef0f4", skill = "#a8d089", spell = "#8ed0dc", faction = "#e3a6c6",
		area = "#dcbda4", achievement = "#e6a872", dungeon = "#ab98e6", rare = "#e6916f",
		haze = "#00000000",
	},
	arrow = "3d",
	mapIcons = "polestar",
}
local PRESET = {
	["ui.style"] = "standard", ["ui.band"] = true, ["ui.starAlpha"] = 0.35, ["ui.haze"] = false,
	["ui.shadow"] = true, ["ui.shadowStrength"] = 1.2, ["ui.textShadow"] = "soft",
}
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin umbra", Theme.RegisterSkin("umbra", spec))
