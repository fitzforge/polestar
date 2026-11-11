-- Umbra: a dark mode for Polestar through its Skin API (docs/skins in the
-- Polestar repository). Neutral charcoal with no blue in it, a cool grey
-- ladder, a muted steel accent, the subject colours a quarter of the way
-- toward grey so nothing glows, the band's stars dimmed, the haze off.
-- Two kinds: Flat (Polestar's own frames in charcoal) and the game's looks
-- dimmed (WoW Forever, Blizzard or Classic with their art darkened and
-- drained of colour).
--
-- What this skin shows:
--   * a scheme and a skin from ONE table of colours: the scheme serves the
--     players who keep Polestar's skin, the skin adds the quieter subject
--     colours a scheme may not carry;
--   * `variants` that change the base look, and `artTint` darkening and
--     desaturating a game look's own art.
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

local ACCENT = "#9fb4c7"

check("scheme umbra", Theme.RegisterScheme("umbra", {
	api = 2, name = "Umbra", addon = ADDON, author = "Polestar",
	desc = "Dark mode: neutral charcoal, a cool grey ladder, a steel accent.",
	tokens = {
		bg = "#141516f7", panel = "#1a1b1dfa", panelAlt = "#232426", sidebar = "#0f1011", footer = "#111213", sky = "#1c1d20",
		text = "#ececec", textDim = "#b8b9bc", textMuted = "#8d8f93",
		ink = "#ffffff", star = "#ffffff59", shade = "#000000", scrim = "#0a0a0b", onAccent = "#141516", shadow = "#000000a6",
	},
	accent = ACCENT,
	washes = { border = 0.1, divider = 0.1, selected = 0.12, hover = 0.07 },
}))

-- Polestar's subjects, each a quarter of the way to grey.
local SUBJECTS = {
	success = "#86cf9f", warning = "#e6b86b", danger = "#e08484", quest = "#e8cf8a", npc = "#9fc3e8", item = "#c3b3e6",
	place = "#e2ad8d", object = "#d2c7b2", level = "#eef0f4", skill = "#a8d089", spell = "#8ed0dc", faction = "#e3a6c6",
	area = "#dcbda4", achievement = "#e6a872", dungeon = "#ab98e6", rare = "#e6916f",
}
local FLAT = { accent = ACCENT, haze = "#00000000", glow = ACCENT }
for k, v in pairs(SUBJECTS) do FLAT[k] = v end

-- The game's looks dimmed: their metal, stone and parchment at 55 % and
-- mostly grey, their own colours kept for text.
local DIM = { tint = { 0.82, 0.84, 0.88, 1 }, brightness = -0.45, desaturate = 0.85 }

check("skin umbra", Theme.RegisterSkin("umbra", {
	api = 2,
	name = "Umbra",
	addon = ADDON,
	author = "Polestar",
	desc = "Dark mode: charcoal and muted colours, on Polestar's frames or on the game's own art, dimmed.",
	base = "polestar",
	scheme = "umbra",
	tokens = FLAT,
	arrow = "3d",
	mapIcons = "polestar",
	variants = {
		{ id = "flat", name = "Flat", desc = "Polestar's own frames in charcoal." },
		{ id = "forever", name = "WoW Forever, dimmed", desc = "The WoW Forever look with its art darkened and greyed.", base = "forever", artTint = DIM },
		{ id = "blizzard", name = "Blizzard, dimmed", desc = "The Blizzard look with its art darkened and greyed.", base = "blizzard", artTint = DIM },
		{ id = "classic", name = "Classic, dimmed", desc = "The Classic look with its art darkened and greyed.", base = "classic", artTint = DIM },
	},
	defaultVariant = "flat",
	preset = {
		["ui.style"] = "standard", ["ui.band"] = true, ["ui.starAlpha"] = 0.35, ["ui.haze"] = false,
		["ui.shadow"] = true, ["ui.shadowStrength"] = 1.2, ["ui.textShadow"] = "soft",
	},
}))
