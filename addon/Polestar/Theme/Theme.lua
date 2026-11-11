-- Polestar.Theme: colours, fonts, media and frame skins for the UI and Nav.
-- Contract: docs/ARCHITECTURE.md, "Theme". Direction:
-- docs/DESIGN.md ("The Guiding-Star Instrument").
--
-- One world, always Polestar's own: night grounds under a starlit band, 1px
-- hairlines, a white text ladder, the game's own font for the UI by default
-- (Inter or EllesmereUI's on request) and the engraved wordmark for the
-- identity. The user picks how deep the night runs (a colour
-- scheme: Dusk, Night, Graphite, or EllesmereUI's own panel colour when it
-- is installed) and may set their own accent, ground colour, ground opacity
-- and brightness on top. Every colour resolves in this order:
--   the user's own value > "Match EllesmereUI" (installed and on) > scheme.
-- Whatever they pick, the text ladder stays legible: a ground that would
-- drop text below 7:1 (primary) or 4.5:1 (the rest) is darkened until it
-- reads (tests/theme.test.js holds every scheme to it).
-- EllesmereUI is read only through its documented skinning API (accent,
-- panel colour, font; repainted on S.OnLooksChanged); its frame primitives
-- are deliberately not applied: its shell art would replace Polestar's
-- composition.

local ADDON, ns = ...
local Theme = {}
ns.Theme = Theme

local type, pairs, ipairs, pcall, floor = type, pairs, ipairs, pcall, math.floor
local format = string.format

local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\"

---------------------------------------------------------------------------
-- Palette data
---------------------------------------------------------------------------

-- Polestar gold: the accent of every scheme.
local DEFAULT_ACCENT = { 0.9, 0.73, 0.4 }

-- Status and subject colours: one set for every scheme (all schemes are
-- night grounds), so a quest is the same gold everywhere.
local SHARED = {
	success = { 0.42, 0.85, 0.6, 1 },
	warning = { 0.98, 0.75, 0.3, 1 },
	danger = { 0.96, 0.45, 0.45, 1 },
	quest = { 1, 0.84, 0.45, 1 },
	npc = { 0.58, 0.79, 1, 1 },
	item = { 0.78, 0.68, 1, 1 },
	place = { 0.96, 0.68, 0.52, 1 },
	object = { 0.86, 0.79, 0.66, 1 },
	level = { 0.96, 0.97, 0.99, 1 },
	skill = { 0.6, 0.88, 0.46, 1 },
	spell = { 0.47, 0.86, 0.93, 1 },
	faction = { 0.97, 0.6, 0.79, 1 },
	area = { 0.93, 0.75, 0.6, 1 },
	achievement = { 1, 0.64, 0.32, 1 },
	dungeon = { 0.64, 0.52, 1, 1 }, -- dungeon and raid entrances (portal violet)
	rare = { 1, 0.5, 0.32, 1 }, -- rare NPCs (ember; treasures keep object)
}

-- Tints laid on the game's own art (the world map), and light laid over
-- a Polestar ground (the night header's haze), never under text: the same
-- in every scheme and outside the legibility guard.
local ART = {
	mapUnexplored = { 0.6, 0.66, 0.9, 1 }, -- multiplied onto unexplored map overlays
	haze = { 0.29, 0.376, 0.667, 0.25 }, -- the faint blue haze in a night header (Media glow)
}

-- Another brand's colour, for its mark only: Discord's Blurple, as its
-- brand guidelines give it, on the Discord logo wherever Polestar links its
-- Discord (UI/Report.lua: the report window, the invite's copy window, the
-- sidebars' link). A logo, never text, so it sits outside the legibility
-- guard, the same in every scheme.
local BRAND = {
	discord = { 0.345, 0.396, 0.949, 1 },
}

-- A scheme: the grounds (bg window, panel raised panels and popups, panelAlt
-- controls, sidebar, footer, sky the top of the header band), the text
-- ladder (100/70/50, tinted toward the ground so secondary text stays in the
-- world), ink (the colour of hairlines and washes), shade (wells, text
-- shadows, art fades), scrim (dark grounds for text on zone art), onAccent
-- (text and glyphs on an accent fill) and shadow (window drop shadow).
local SCHEMES = {
	-- The default: Night lifted to dusk, still navy, clearly lighter.
	dusk = {
		bg = { 0.095, 0.115, 0.178, 0.97 },
		panel = { 0.11, 0.133, 0.203, 0.98 },
		panelAlt = { 0.139, 0.166, 0.249, 1 },
		sidebar = { 0.072, 0.088, 0.14, 1 },
		footer = { 0.08, 0.097, 0.151, 1 },
		sky = { 0.156, 0.196, 0.329, 1 },
		text = { 0.967, 0.974, 0.991, 1 },
		textDim = { 0.765, 0.793, 0.868, 1 },
		textMuted = { 0.606, 0.637, 0.726, 1 },
		ink = { 1, 1, 1, 1 },
		star = { 1, 1, 1, 1 },
		shade = { 0, 0, 0.02, 1 },
		scrim = { 0.02, 0.03, 0.06, 1 },
		onAccent = { 0.04, 0.05, 0.08, 1 },
		shadow = { 0, 0, 0.02, 0.6 },
	},
	-- The original deep night navy-black, unchanged.
	night = {
		bg = { 0.039, 0.051, 0.086, 0.97 },
		panel = { 0.051, 0.066, 0.11, 0.98 },
		panelAlt = { 0.075, 0.094, 0.149, 1 },
		sidebar = { 0.027, 0.035, 0.063, 1 },
		footer = { 0.031, 0.04, 0.071, 1 },
		sky = { 0.075, 0.106, 0.2, 1 },
		text = { 0.96, 0.97, 0.99, 1 },
		textDim = { 0.69, 0.72, 0.8, 1 },
		textMuted = { 0.5, 0.54, 0.63, 1 },
		ink = { 1, 1, 1, 1 },
		star = { 1, 1, 1, 1 },
		shade = { 0, 0, 0.02, 1 },
		scrim = { 0.02, 0.03, 0.06, 1 },
		onAccent = { 0.04, 0.05, 0.08, 1 },
		shadow = { 0, 0, 0.02, 0.6 },
	},
	-- Neutral and lighter: slate grey, the faintest cool cast.
	graphite = {
		bg = { 0.131, 0.137, 0.146, 0.97 },
		panel = { 0.15, 0.156, 0.165, 0.98 },
		panelAlt = { 0.182, 0.19, 0.202, 1 },
		sidebar = { 0.104, 0.109, 0.116, 1 },
		footer = { 0.113, 0.118, 0.125, 1 },
		sky = { 0.2, 0.215, 0.239, 1 },
		text = { 0.974, 0.974, 0.974, 1 },
		textDim = { 0.793, 0.801, 0.813, 1 },
		textMuted = { 0.635, 0.646, 0.663, 1 },
		ink = { 1, 1, 1, 1 },
		star = { 1, 1, 1, 1 },
		shade = { 0, 0, 0, 1 },
		scrim = { 0.03, 0.03, 0.035, 1 },
		onAccent = { 0.05, 0.05, 0.06, 1 },
		shadow = { 0, 0, 0, 0.6 },
	},
}
Theme.SCHEMES = SCHEMES
Theme.SCHEME_ORDER = { "dusk", "night", "graphite" }

-- "#rrggbb" and an alpha -> { r, g, b, a }.
local function hex(s, a)
	local r, g, b = s:match("#?(%x%x)(%x%x)(%x%x)")
	return { tonumber(r, 16) / 255, tonumber(g, 16) / 255, tonumber(b, 16) / 255, a or 1 }
end
Theme.HexColor = hex

-- Skins (ui.skin): "polestar", the house style above (the default), the
-- two directions of the design handoff, and the game's own looks
-- (docs/ARCHITECTURE.md, "Skins"):
--   "halo"      Forever · Halo: no frame, a dark veil with soft edges under
--               the text, an off-white ladder, the game's gold, Fira Sans
--   "hearth"    Forever · Hearth: Polestar in warm game colours, a brown
--               gradient window, the client's red buttons, font and text
--               colours
--   "forever", "blizzard", "classic"   the client's own art: WoW Forever's,
--               the retail art (Blizzard Style) and the vanilla files
--               (Theme/GameSkins.lua draws them)
-- A skin brings its whole palette, its fonts, its frame paints and its sizes.
-- The colour scheme, ground colour and brightness belong to the house style;
-- the player's own accent, window border and arrow colours win in every skin.
-- The palettes are the handoff's tokens as given (DIRECTION_B_HALO.md §1,
-- DIRECTION_A_BLIZZARD.md §1); the washes of a skin are its own colours, not
-- the house ink at the house alphas.
local SKIN_PALETTES = {
	halo = {
		bg = hex("080604", 0.84), panel = hex("120E0A", 0.97), panelAlt = hex("FFFFFF", 0.06),
		sidebar = hex("080604", 0), footer = hex("080604", 0), sky = hex("080604", 0),
		text = hex("F4EFE6"), textDim = hex("C2B9A9"), textMuted = hex("8F8778"), textOff = hex("6E675C"),
		title = hex("F4EFE6"), ink = hex("FFFFFF"), star = hex("FFFFFF", 0), shade = hex("000000"),
		scrim = hex("080604"), onAccent = hex("17130E"), shadow = hex("080604", 0.72),
		accent = hex("FFD100"),
		veil = hex("080604", 0.6), veilWindow = hex("080604", 0.84), menuBg = hex("120E0A", 0.97),
		inputBg = hex("000000", 0.35), control = hex("FFFFFF", 0.06),
		accentLine = hex("FFD100", 0.35), padSelect = hex("FFD100", 0.12), chipAccent = hex("FFD100", 0.16),
		separator = hex("FFFFFF", 0.12), rowLine = hex("FFFFFF", 0.08),
		border = hex("FFFFFF", 0.14), divider = hex("FFFFFF", 0.12), hover = hex("FFFFFF", 0.07),
		selected = hex("FFFFFF", 0.08), toggle = hex("FFFFFF", 0.16), track = hex("FFFFFF", 0.18),
		progress = hex("FFFFFF", 0.12), chip = hex("FFFFFF", 0.08), box = hex("FFFFFF", 0.35),
		thumb = hex("F4EFE6"), swatch = hex("FFFFFF", 0.25), watermark = hex("FFFFFF", 0.028), mover = hex("FFFFFF", 0.06),
		success = hex("5FD068"), arrive = hex("5FD068"), todo = hex("FFD100"), warning = hex("FF9A3C"),
		later = hex("FF9A3C"), danger = hex("FF9A3C"), manual = hex("B49CFF"), skipped = hex("5CC8D6"),
		icon = hex("C2B9A9"), iconHover = hex("F4EFE6"), buttonText = hex("F4EFE6"), personName = hex("8CCBFF"), tabRest = hex("C2B9A9"),
		rowLabel = hex("F4EFE6"), navRest = hex("C2B9A9"),
		link = hex("8CCBFF"), npc = hex("8CCBFF"), quest = hex("FFE07A"), place = hex("F5AD85"),
		rare = hex("FF8052"), dungeon = hex("A385FF"), discord = hex("5865F2"),
	},
	hearth = {
		bg = hex("1E170D", 0.95), bgBottom = hex("090704", 0.95), panel = hex("000000", 0.92), panelAlt = hex("000000"),
		sidebar = hex("000000", 0.3), footer = hex("000000", 0), sky = hex("2C200C"), skyBottom = hex("150F06"),
		text = hex("FFFFFF"), textDim = hex("CCCCCC"), textMuted = hex("9D9D9D"), textOff = hex("808080"),
		title = hex("FFD100"), ink = hex("FFFFFF"), star = hex("FFFFFF", 0), shade = hex("000000"),
		scrim = hex("000000"), onAccent = hex("17130E"), shadow = hex("000000", 0.7),
		accent = hex("FFD100"),
		veil = hex("000000", 0), veilWindow = hex("000000", 0), menuBg = hex("000000", 0.92),
		inputBg = hex("000000"), control = hex("000000"),
		accentLine = hex("9A7A34", 0.6), padSelect = hex("FFD100", 0.14), chipAccent = hex("FFD100", 0.16),
		separator = hex("9A7A34", 0.45), rowLine = hex("FFFFFF", 0.06),
		border = hex("6B6B6B"), windowEdge = hex("5C4518"), divider = hex("9A7A34", 0.45), hover = hex("FFD100", 0.12),
		selected = hex("6E96FF", 0.28), toggle = hex("000000"), track = hex("000000"),
		progress = hex("000000", 0.75), chip = hex("000000", 0.6), box = hex("8A7A5A"),
		thumb = hex("FFE27A"), swatch = hex("FFFFFF", 0.25), watermark = hex("FFFFFF", 0.028), mover = hex("FFD100", 0.12),
		frameEdge = hex("9A7A34"), frameEdgeDark = hex("5C4518"), titleLine = hex("6B5420"),
		success = hex("1EFF00"), arrive = hex("58C04A"), todo = hex("FFD100"), warning = hex("FF8040"),
		later = hex("FF8040"), danger = hex("FF8040"), manual = hex("C77DFF"), skipped = hex("71D5FF"),
		icon = hex("FFD100"), iconHover = hex("FFD100"), buttonText = hex("FFD100"), personName = hex("FFD100"), tabRest = hex("A38D58"),
		rowLabel = hex("FFFFFF"), navRest = hex("CCCCCC"),
		link = hex("FFD100"), npc = hex("FFFFFF"), discord = hex("5865F2"),
	},
}

-- The game's looks start from Hearth's game colours (white text, gold
-- titles, the client's quality greens and oranges) with their own grounds,
-- glyph tints and rules.
local function gamePalette(over)
	local p = {}
	for k, v in pairs(SKIN_PALETTES.hearth) do p[k] = v end
	for k, v in pairs(over) do p[k] = v end
	return p
end
SKIN_PALETTES.forever = gamePalette({
	bg = hex("000000", 0.96), bgBottom = hex("000000", 0.96), sidebar = hex("000000", 0.25),
	textDim = hex("AE9D81"), tabRest = hex("FFD100"), icon = hex("CEB282"), iconHover = hex("F2D199"),
	-- The Settings panel's labels and its list's rows: GameFontNormal, gold.
	rowLabel = hex("FFD100"), navRest = hex("FFD100"),
	separator = hex("AE9D81", 0.35), divider = hex("AE9D81", 0.35), accentLine = hex("AE9D81", 0.5),
	border = hex("5C4A30"), windowEdge = hex("5C4A30"), hover = hex("FFD100", 0.1), selected = hex("FFD100", 0.14),
})
-- Blizzard Style: the meter header's and the tracker header's own gold lines
-- draw the window's rules, so the hairlines stay faint and white; resting
-- tabs in the Settings panel's tan, the active one gold on its lit row.
SKIN_PALETTES.blizzard = gamePalette({
	bg = hex("000000", 0.96), bgBottom = hex("000000", 0.96), sidebar = hex("000000", 0.25),
	icon = hex("E8E8E8"), iconHover = hex("FFFFFF"), tabRest = hex("C9B37A"), rowLabel = hex("FFD100"), navRest = hex("FFD100"),
	separator = hex("FFFFFF", 0.1), divider = hex("FFFFFF", 0.1), accentLine = hex("FFD100", 0.45),
	border = hex("404040"), windowEdge = hex("404040"), hover = hex("FFFFFF", 0.08), selected = hex("FFD100", 0.14),
})
-- Classic: the game's tooltip colour (TOOLTIP_DEFAULT_BACKGROUND_COLOR,
-- 0.09 0.09 0.19, as its grey tile draws it) under the guide window and the
-- toasts, the dialog box's black over it on the big windows; gold labels
-- (GameFontNormal), the quest log's gold title highlight for selection and
-- its silver one under the cursor; the resting chat tab's muted gold.
SKIN_PALETTES.classic = gamePalette({
	bg = hex("0D0D1C", 0.92), bgBottom = hex("0D0D1C", 0.92), panel = hex("171730", 0.95), menuBg = hex("171730", 0.95), sidebar = hex("000000", 0),
	icon = hex("FFD100"), iconHover = hex("FFFFFF"), tabRest = hex("B8A14F"), rowLabel = hex("FFD100"), navRest = hex("FFD100"),
	separator = hex("969696", 0.35), divider = hex("969696", 0.25), accentLine = hex("969696", 0.6),
	border = hex("696969"), windowEdge = hex("696969"), hover = hex("FFD100", 0.1), selected = hex("FFD100", 0.14),
	control = hex("000000", 0.4), inputBg = hex("000000", 0.6), chip = hex("000000", 0.5),
})
Theme.SKIN_PALETTES = SKIN_PALETTES
Theme.SKIN_ORDER = { "polestar", "halo", "hearth", "forever", "blizzard", "classic" }
-- Skins hidden from the picker while their issues are fixed. A saved value
-- naming a hidden skin resolves to the house style at load; the raw saved
-- value is left alone so the player's choice restores when the skin returns.
-- See issue #306.
-- Each entry holds the skin's label so its translations survive in every locale
-- until the skin returns (the i18n scanner would otherwise flag it as stale).
local HIDDEN_SKINS = {}
-- Tests may set Theme._testShowHidden = true to render hidden skins directly.
Theme._testShowHidden = false
-- The skins drawn in game colours and controls (the client's check boxes,
-- sliders, red buttons, the game font with its hard shadow).
local GAME_SKINS = { hearth = true, forever = true, blizzard = true, classic = true }
-- The Skin API's registries (Theme.RegisterSkin / Theme.RegisterScheme at the
-- end of this file, docs/SKINS-API.md): skin id -> its spec as registered
-- (the built-in six too), scheme id -> its name, addon and accent, and the
-- skins whose painters failed this session (id -> error).
local SKINS, SCHEME_INFO, FAILED = {}, {}, {}
-- The player's context a registered skin's resolver is asked with
-- (spec.resolve, Skin API 2): faction ("Alliance" | "Horde"), class (the
-- client's class file), the continent and the zone (uiMapIDs, with the
-- continent's name); kept current by the events at the end of this file.
local CTX = {}
-- Families a skin's resolver handed over (font files): looked up after the
-- bundled ones (FAMILIES below).
local EXTRA_FAMILIES = {}
-- Defined in the Skin API section at the end of this file.
local readTokens, readFont, failSkin
Theme.GROUNDS = { "bg", "panel", "panelAlt", "sidebar", "footer", "sky" }

-- Alphas of the ink washes, by role.
local WASH = {
	border = 0.08, divider = 0.08, hover = 0.06, selected = 0.09, progress = 0.08, track = 0.12,
	toggle = 0.14, box = 0.22, thumb = 0.22, swatch = 0.25, chip = 0.07, watermark = 0.028, mover = 0.06,
}
Theme.WASH = WASH
-- On the lighter schemes white hairlines and selections read weaker, so they
-- carry a little more ink.
local SCHEME_WASH = {
	dusk = { border = 0.1, divider = 0.1, selected = 0.12, hover = 0.07 },
	graphite = { border = 0.1, divider = 0.1, selected = 0.12, hover = 0.07 },
	ellesmere = { border = 0.1, divider = 0.1, selected = 0.12, hover = 0.07 },
}

-- Text roles held to the legibility floor, and their minimum contrast.
Theme.LEGIBLE = { text = 7, textDim = 4.5, textMuted = 4.5 }

---------------------------------------------------------------------------
-- Colour maths (sRGB, OKLab for perceptual lightness)
---------------------------------------------------------------------------

local function toLinear(c)
	if c <= 0.04045 then return c / 12.92 end
	return ((c + 0.055) / 1.055) ^ 2.4
end

local function toGamma(c)
	if c <= 0 then return 0 end
	c = c <= 0.0031308 and 12.92 * c or 1.055 * c ^ (1 / 2.4) - 0.055
	return c > 1 and 1 or c
end

local function cbrt(x)
	if x < 0 then return -((-x) ^ (1 / 3)) end
	return x ^ (1 / 3)
end

local function toLab(r, g, b)
	r, g, b = toLinear(r), toLinear(g), toLinear(b)
	local l = cbrt(0.4122214708 * r + 0.5363151677 * g + 0.0514459929 * b)
	local m = cbrt(0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b)
	local s = cbrt(0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b)
	return 0.2104542553 * l + 0.793617785 * m - 0.0040720468 * s,
		1.9779984951 * l - 2.428592205 * m + 0.4505937099 * s,
		0.0259040371 * l + 0.7827717662 * m - 0.808675766 * s
end

local function fromLab(L, a, b)
	local l = (L + 0.3963377774 * a + 0.2158037573 * b) ^ 3
	local m = (L - 0.1055613458 * a - 0.0638541728 * b) ^ 3
	local s = (L - 0.0894841775 * a - 1.291485548 * b) ^ 3
	return toGamma(4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s),
		toGamma(-1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s),
		toGamma(-0.0041960863 * l - 0.7034186147 * m + 1.707614701 * s)
end

-- WCAG relative luminance and contrast ratio.
function Theme.Luminance(r, g, b)
	return 0.2126 * toLinear(r) + 0.7152 * toLinear(g) + 0.0722 * toLinear(b)
end

function Theme.Contrast(c1, c2)
	local a, b = Theme.Luminance(c1[1], c1[2], c1[3]), Theme.Luminance(c2[1], c2[2], c2[3])
	if a < b then a, b = b, a end
	return (a + 0.05) / (b + 0.05)
end

-- c with its OKLab lightness moved by dL (chroma scaled by k), alpha kept.
local function shifted(c, dL, k)
	local L, a, b = toLab(c[1], c[2], c[3])
	k = k or 1
	L = L + dL
	if L < 0 then L = 0 elseif L > 1 then L = 1 end
	local r, g, bb = fromLab(L, a * k, b * k)
	return { r, g, bb, c[4] or 1 }
end

-- Grounds around one colour (a custom ground, EllesmereUI's panel colour):
-- the same lightness steps Dusk takes around its window ground.
local DERIVE = { sidebar = -0.03, footer = -0.02, bg = 0, panel = 0.02, panelAlt = 0.055, sky = 0.09 }

local function deriveGrounds(P, c)
	for name, dL in pairs(DERIVE) do
		local g = shifted(c, dL, name == "sky" and 1.6 or 1)
		g[4] = P[name][4]
		P[name] = g
	end
end

-- The lowest contrast any held role reaches, as a ratio of its floor (>= 1
-- is legible): the text ladder on every ground, the subject and status
-- colours on every ground but the sky (only titles sit on the band).
local function legibility(P)
	local worst = math.huge
	for _, gname in ipairs(Theme.GROUNDS) do
		for role, floorRatio in pairs(Theme.LEGIBLE) do
			local q = Theme.Contrast(P[role], P[gname]) / floorRatio
			if q < worst then worst = q end
		end
		if gname ~= "sky" then
			for role in pairs(SHARED) do
				local q = Theme.Contrast(P[role], P[gname]) / 4.5
				if q < worst then worst = q end
			end
		end
	end
	return worst
end
Theme.Legibility = legibility

-- Whether a palette is a light one: its text darker than its window ground
-- (a parchment scheme or skin), so the guard below lifts its grounds instead.
local function isLight(P)
	local t, g = P.text, P.bg
	return Theme.Luminance(t[1], t[2], t[3]) < Theme.Luminance(g[1], g[2], g[3])
end
Theme.IsLightPalette = isLight

-- Move every ground together, by the least lightness that makes all text
-- legible again: darker under light text, lighter under dark text (a light
-- palette), so the player's brightness or ground colour can never take a
-- light palette's grounds down to its text, nor a dark one's up to it.
-- `light` says which way (default: as P stands now); `need`, the legibility
-- to reach (default 1: the floor; a registered skin's, the look it extends
-- where that look sits under the floor, so its own tokens are held to it).
local function keepLegible(P, light, need)
	need = need or 1
	if legibility(P) >= need then return P end
	local base = {}
	for _, gname in ipairs(Theme.GROUNDS) do base[gname] = P[gname] end
	if light == nil then light = isLight(P) end
	local far = light and 1 or -1
	local lo, hi = far, 0 -- lightness shift: lo is legible, hi is not
	for _ = 1, 14 do
		local mid = (lo + hi) / 2
		for _, gname in ipairs(Theme.GROUNDS) do P[gname] = shifted(base[gname], mid) end
		if legibility(P) >= need then lo = mid else hi = mid end
	end
	for _, gname in ipairs(Theme.GROUNDS) do P[gname] = shifted(base[gname], lo) end
	return P
end

---------------------------------------------------------------------------
-- Resolution: the user's own value > Match EllesmereUI > scheme
---------------------------------------------------------------------------

local S -- EllesmereUI's primitive table, once its callback ran

function Theme.IsEllesmere()
	return S ~= nil
end

local function get(path)
	if ns.Get then return ns.Get(path) end
end

local function isColor(c)
	return type(c) == "table" and type(c[1]) == "number" and type(c[2]) == "number" and type(c[3]) == "number"
end

local function euiAccent()
	if S and S.GetAccentColor then
		local ok, r, g, b = pcall(S.GetAccentColor)
		if ok and type(r) == "number" then return r, g, b end
	end
end

local function euiPanel()
	if S and S.GetPanelColor then
		local ok, r, g, b, a = pcall(S.GetPanelColor)
		if ok and type(r) == "number" then return { r, g, b, type(a) == "number" and a or 1 } end
	end
end

-- The scheme in use: "ellesmere" only while EllesmereUI is there, and an
-- unknown value (an older or newer build) falls back to Dusk.
function Theme.SchemeKey()
	local k = get("ui.scheme")
	if k == "ellesmere" then return S and "ellesmere" or "dusk" end
	return SCHEMES[k] and k or "dusk"
end

-- The scheme choices for the options: the built-in schemes, EllesmereUI's
-- while it is there, then the schemes other addons registered (Skin API,
-- docs/SKINS-API.md), each with its addon. -> { { value, text, addon? } }
function Theme.SchemeChoices()
	local out = {}
	for _, id in ipairs(Theme.SCHEME_ORDER) do
		local info = SCHEME_INFO[id]
		if info and info.builtin then out[#out + 1] = { value = id, text = info.label() } end
	end
	if S then out[#out + 1] = { value = "ellesmere", text = "EllesmereUI" } end
	for _, id in ipairs(Theme.SCHEME_ORDER) do
		local info = SCHEME_INFO[id]
		if info and not info.builtin then out[#out + 1] = { value = id, text = info.name, addon = info.addon, desc = info.desc, author = info.author } end
	end
	return out
end

-- The game's class colours, for a client that has no table of them.
local CLASS_COLORS = {
	WARRIOR = { 0.78, 0.61, 0.43 }, PALADIN = { 0.96, 0.55, 0.73 }, HUNTER = { 0.67, 0.83, 0.45 },
	ROGUE = { 1, 0.96, 0.41 }, PRIEST = { 1, 1, 1 }, SHAMAN = { 0, 0.44, 0.87 },
	MAGE = { 0.25, 0.78, 0.92 }, WARLOCK = { 0.53, 0.53, 0.93 }, DRUID = { 1, 0.49, 0.04 },
}

-- A class's colour (the player's when `file` is nil), from the client (class
-- colour addons may change it). -> r, g, b | nil
local function classColor(file)
	if not file then
		if not UnitClass then return nil end
		local _
		_, file = UnitClass("player")
		if not file then return nil end
	end
	local c = C_ClassColor and C_ClassColor.GetClassColor and C_ClassColor.GetClassColor(file)
	if not (c and type(c.r) == "number") then c = RAID_CLASS_COLORS and RAID_CLASS_COLORS[file] end
	if c and type(c.r) == "number" then return c.r, c.g, c.b end
	return nil
end

-- The colour of class `file` (a client class file such as "DRUID"; the
-- player's when nil), raw for fills and rules: the client's, else the
-- game's own. -> r, g, b | nil
function Theme.ClassColor(file)
	local r, g, b = classColor(file)
	if r then return r, g, b end
	local own = CLASS_COLORS[file or ""]
	if own then return own[1], own[2], own[3] end
	return nil
end

-- One accent source at a time: your own colour, your class's (ui.classAccent)
-- or EllesmereUI's. Whether the accent currently comes from the class:
function Theme.FollowsClassAccent()
	if isColor(get("ui.accent")) or not get("ui.classAccent") then return false end
	return classColor() ~= nil
end

-- Whether the accent / font currently come from EllesmereUI.
function Theme.FollowsEllesmereAccent()
	if not S or isColor(get("ui.accent")) or Theme.FollowsClassAccent() then return false end
	return get("ui.matchAccent") and true or Theme.SchemeKey() == "ellesmere"
end

function Theme.FollowsEllesmereFont()
	return S ~= nil and get("ui.matchFont") and true or false
end

local function copy(c) return { c[1], c[2], c[3], c[4] or 1 } end

-- c moved toward the text colour t until it reads at 4.5:1 on ground (the
-- subject colours' floor). -> r, g, b
local function liftTo(ground, t, c)
	local r, g, b = c[1], c[2], c[3]
	for _ = 1, 24 do
		if Theme.Contrast({ r, g, b }, ground) >= 4.5 then break end
		r, g, b = r + (t[1] - r) * 0.15, g + (t[2] - g) * 0.15, b + (t[3] - b) * 0.15
	end
	return r, g, b
end

-- A class colour carries text like any accent: lifted until it reads on
-- the panel ground of the palette being built. -> r, g, b
local function legibleOn(out, r, g, b)
	return liftTo(out.panel, out.text, { r, g, b })
end

-- The lightest place a name sits in a palette: the panel ground under the
-- selected wash (a selected row). -> { r, g, b }
local function lightestOf(pal)
	local p, w = pal.panel, pal.selected
	local a = w[4] or 0
	return { p[1] + (w[1] - p[1]) * a, p[2] + (w[2] - p[2]) * a, p[3] + (w[3] - p[3]) * a }
end

-- The subject and status colours a player may set their own of
-- (ui.colors.<name>), in the order the options list them.
Theme.SUBJECTS = { "npc", "quest", "item", "place", "object", "area", "dungeon", "rare", "skill", "spell", "faction",
	"achievement", "level", "success", "warning", "danger" }

-- The text ladder's own colours, each held to its floor (Theme.LEGIBLE).
local OWN_TEXT = { { "text", "ui.textColor" }, { "textDim", "ui.textDimColor" }, { "textMuted", "ui.textMutedColor" } }

-- c moved toward t until it reads at `floorRatio` on every ground (a nearly
-- clear one, such as Halo's white wash over its window, is no ground).
-- -> { r, g, b, 1 }
local function liftAll(out, t, c, floorRatio)
	local r, g, b = c[1], c[2], c[3]
	for _ = 1, 24 do
		local ok = true
		for _, gname in ipairs(Theme.GROUNDS) do
			local gc = out[gname]
			if gc and (gc[4] or 1) >= 0.5 and Theme.Contrast({ r, g, b }, gc) < floorRatio then
				ok = false
				break
			end
		end
		if ok then break end
		r, g, b = r + (t[1] - r) * 0.15, g + (t[2] - g) * 0.15, b + (t[3] - b) * 0.15
	end
	return { r, g, b, 1 }
end

-- The player's own text and subject colours over a palette (any skin), the
-- legibility guard kept: a pick too dark for its floor is moved toward the
-- text colour until it reads (the ladder on every ground, a subject at
-- 4.5:1 on the lightest place a name sits, as Theme.Legible).
local function ownColours(out)
	local base = copy(out.text)
	for _, own in ipairs(OWN_TEXT) do
		local c = get(own[2])
		if isColor(c) then out[own[1]] = liftAll(out, own[1] == "text" and base or out.text, c, Theme.LEGIBLE[own[1]]) end
	end
	local lightest = lightestOf(out)
	for _, name in ipairs(Theme.SUBJECTS) do
		local c = get("ui.colors." .. name)
		if isColor(c) then
			out[name] = { liftTo(lightest, out.text, c) }
			out[name][4] = 1
		end
	end
	-- A skin's name of the person to talk to is its NPC colour.
	if out.personName and isColor(get("ui.colors.npc")) then out.personName = copy(out.npc) end
end

-- Depth and light, in any skin: hairlines' opacity (ui.hairlineOpacity, a
-- multiple of the skin's), the window shadow's strength (ui.shadowStrength),
-- the band's stars (ui.starAlpha) and the header haze (ui.haze).
local HAIRLINES = { "border", "divider", "separator", "rowLine" }
local function ownDepth(out)
	local k = tonumber(get("ui.hairlineOpacity")) or 1
	if k ~= 1 then
		for _, name in ipairs(HAIRLINES) do
			local c = out[name]
			if c then c[4] = math.max(0, math.min(1, (c[4] or 1) * k)) end
		end
	end
	local s = tonumber(get("ui.shadowStrength")) or 1
	if s ~= 1 and out.shadow then out.shadow[4] = math.max(0, math.min(1, out.shadow[4] * s)) end
	local st = tonumber(get("ui.starAlpha")) or 1
	if st ~= 1 and out.star then out.star[4] = math.max(0, math.min(1, (out.star[4] or 1) * st)) end
	if get("ui.haze") == false and out.haze then out.haze[4] = 0 end
end

local P -- the resolved palette; rebuilt on the next read after a change
-- A skin drawn on a picker card while another is in use (the settings'
-- Polestar_Options/Theme/SkinPicker.lua): its id and palette answer for the
-- live ones while the card is painted; nothing is switched, saved or
-- repainted.
local drawing = {}

-- The skin chosen (ui.skin) as it is drawn: a registered skin (built in or
-- added by another addon through the Skin API, docs/SKINS-API.md) that has
-- not failed this session. An unknown value (an older or newer build, a
-- skin whose addon is gone or not loaded yet) or a hidden skin is the house
-- style; the raw saved value is kept, so the choice comes back when the skin
-- returns or its addon registers it later in the session.
function Theme.SkinId()
	if drawing.id then return drawing.id end
	local k = get("ui.skin")
	if SKINS[k] and not FAILED[k] and (Theme._testShowHidden or not HIDDEN_SKINS[k]) then return k end
	return "polestar"
end

-- The skin choices for the options: the built-in skins, then the skins other
-- addons registered, each with its addon. Installed skin addons that load
-- on demand load first (Theme.LoadInstalledSkins, Theme/SkinApi.lua), so
-- every skin the player has is listed. -> { { value, text, addon?, desc?, author? } }
function Theme.SkinChoices()
	if Theme.LoadInstalledSkins then Theme.LoadInstalledSkins() end
	local out = {}
	for _, id in ipairs(Theme.SKIN_ORDER) do
		local s = SKINS[id]
		if s and (Theme._testShowHidden or not HIDDEN_SKINS[id]) then
			if s.builtin then
				out[#out + 1] = { value = id, text = s.label() }
			else
				out[#out + 1] = { value = id, text = s.name, addon = s.addon, desc = s.desc, author = s.author }
			end
		end
	end
	return out
end

-- The tokens the skins added, in the house style: what each one stands for
-- there, so a module may read them in any skin.
local HOUSE_EXTRA = {
	textOff = "textMuted", title = "text", link = "npc", todo = "accent", later = "warning", arrive = "success",
	manual = "item", skipped = "spell", separator = "divider", rowLine = "divider", veil = "bg", veilWindow = "bg",
	menuBg = "panel", control = "panelAlt", icon = "textDim", iconHover = "text", buttonText = "text",
	personName = "npc", tabRest = "textDim", rowLabel = "text", navRest = "textDim",
	-- A close square a skin shows on the guide window's title (the guideTitle hook).
	closeFill = "danger", closeEdge = "border", closeGlyph = "text",
}
-- Those a non-house skin falls back on too.
local SKIN_EXTRA = { "closeFill", "closeEdge", "closeGlyph" }

-- The variant of registered skin `s` in use (spec.variants, Skin API 2):
-- the player's pick (ui.skinVariants.<id>) while the skin has it, else the
-- skin's default; nil for a skin without variants.
local previewing = {} -- skin id -> a variant drawn on its card (Theme.DrawSkinCard)
local function variantOf(s)
	if not s.variants then return nil end
	local v = previewing[s.id]
	if v ~= nil and s.variantBy[v] then return v end
	v = get("ui.skinVariants." .. s.id)
	if v ~= nil and s.variantBy[v] then return v end
	return s.defaultVariant
end

-- A field of registered skin `s` with its variant's over it (base, scheme,
-- arrow, preset, artTint, shadow...).
local function field(s, k)
	local v = s.variants and s.variantBy[variantOf(s)]
	if v and v[k] ~= nil then return v[k] end
	return s[k]
end

-- The built-in look skin `s` is drawn from now (its variant may pick another).
local function baseOf(s)
	if s.builtin then return s.base end
	return field(s, "base")
end

-- The built-in look the skin in use is drawn from: the skin itself for the
-- six built in, the look a registered skin extends (its base, or its
-- variant's). Modules that vary their own art by skin key it by this.
function Theme.SkinKey()
	local s = SKINS[Theme.SkinId()]
	return s and baseOf(s) or "polestar"
end

-- Whether the skin in use (or the built-in look `key`) is drawn in the
-- game's colours and controls: Hearth and the game's own looks (and skins
-- built on them).
function Theme.GameSkin(key)
	return GAME_SKINS[key or Theme.SkinKey()] or false
end

-- The player's context (CTX), read when a resolver first asks and again on
-- each new zone (the events at the end of this file).
local ctxRead = false
local function readContext()
	local C = ns.Compat
	ctxRead = true
	if not C then return end
	CTX.faction = C.GetPlayerFaction and C.GetPlayerFaction() or nil
	if UnitClass then
		local _, class = UnitClass("player")
		CTX.class = class
	end
	local zone = C.GetUnitZone and C.GetUnitZone("player") or nil
	local continent = zone and C.GetContinentMap and C.GetContinentMap(zone) or nil
	CTX.zone, CTX.continent = zone, continent
	CTX.continentName = continent and C.GetMapName and C.GetMapName(continent) or nil
end

-- The context a resolver is asked with (spec.resolve).
local function contextFor(s)
	if not ctxRead then readContext() end
	local cr, cg, cb = classColor(CTX.class)
	return { zone = CTX.zone, continent = CTX.continent, continentName = CTX.continentName, faction = CTX.faction,
		class = CTX.class, classColor = cr and { cr, cg, cb } or nil, variant = variantOf(s),
		elvui = type(ElvUI) == "table" and type(ElvUI[1]) == "table" and ElvUI[1] or nil }
end

-- A resolver's font as a font key: one of Polestar's, or the files it gave
-- (kept as the skin's resolved family). -> key | nil
local resolvedFont = {} -- skin id -> font key from its resolver, for this palette

-- A resolver's answer as a string, to tell whether a new zone changed it
-- (the palette is built again only then): its tokens, sorted, and its font.
local answered = {} -- skin id -> the answer the palette was built with
local function flat(v)
	if type(v) ~= "table" then return tostring(v) end
	local keys = {}
	for k in pairs(v) do keys[#keys + 1] = tostring(k) end
	table.sort(keys)
	for i, k in ipairs(keys) do
		local x = v[k]
		if x == nil then x = v[tonumber(k)] end
		keys[i] = k .. "=" .. (type(x) == "table" and flat(x) or tostring(x))
	end
	return "{" .. table.concat(keys, ",") .. "}"
end
local function answerKey(tokens, font)
	return flat(tokens) .. "|" .. flat(font)
end

-- Registered skin `s`'s tokens and media now: its own, its variant's over
-- them, then its resolver's tokens (asked on every palette build). A resolver
-- that raises or answers what a spec could not say fails the skin.
-- -> tokens | nil, media | nil, failed
local function effective(s)
	local v = s.variants and s.variantBy[variantOf(s)]
	local t, m = s.tokens, s.media
	if v and (v.tokens or v.media) then
		t, m = {}, {}
		for k, c in pairs(s.tokens or {}) do t[k] = c end
		for k, p in pairs(s.media or {}) do m[k] = p end
		for k, c in pairs(v.tokens or {}) do t[k] = c end
		for k, p in pairs(v.media or {}) do m[k] = p end
	end
	resolvedFont[s.id] = nil
	if not s.resolve then return t, m end
	local ok, rt, rf = pcall(s.resolve, contextFor(s))
	answered[s.id] = ok and answerKey(rt, rf) or nil
	local why
	if not ok then
		why = tostring(rt)
	else
		if rt ~= nil then
			local own
			own, why = readTokens(rt, "the resolver's tokens")
			if own and next(own) then
				local merged = {}
				for k, c in pairs(t or {}) do merged[k] = c end
				for k, c in pairs(own) do merged[k] = c end
				t = merged
			end
		end
		if not why and rf ~= nil then
			local fok, key, family = readFont(rf, s.id .. ":resolved")
			if not fok then
				why = "the resolver's font: " .. tostring(key)
			else
				if family then EXTRA_FAMILIES[key] = family end
				resolvedFont[s.id] = key
			end
		end
	end
	if why then
		failSkin(s.id, "resolve: " .. why, true)
		return t, m, true
	end
	return t, m
end

-- The tokens a registered skin set (its own, its variant's, its resolver's)
-- for each palette built with it (Theme.SkinToken).
local givenBy = setmetatable({}, { __mode = "k" })

-- A skin's palette, with the player's own accent, window border and arrow
-- colours over it. A registered skin's tokens (with its variant and
-- resolver) lie over the look it extends, and its grounds stay legible
-- however they combine.
local function resolveSkin(skin)
	local s = SKINS[skin]
	local out = {}
	for name, c in pairs(SHARED) do out[name] = copy(c) end
	for name, c in pairs(ART) do out[name] = copy(c) end
	for name, c in pairs(BRAND) do out[name] = copy(c) end
	local stoks
	if s and not s.builtin then
		local _media, failed
		stoks, _media, failed = effective(s)
		if failed then return nil end
		givenBy[out] = stoks
		for name, c in pairs(SKIN_PALETTES[baseOf(s)]) do out[name] = copy(c) end
		local need = math.min(1, legibility(out))
		for name, c in pairs(stoks or {}) do out[name] = copy(c) end
		keepLegible(out, isLight(out), need)
	else
		for name, c in pairs(SKIN_PALETTES[skin]) do out[name] = copy(c) end
	end
	ownColours(out)
	ownDepth(out)
	local r, g, b
	local own = get("ui.accent")
	if isColor(own) then
		r, g, b = own[1], own[2], own[3]
	elseif Theme.FollowsClassAccent() then
		r, g, b = classColor()
	elseif Theme.FollowsEllesmereAccent() then
		r, g, b = euiAccent()
	end
	if r then out.accent = { r, g, b, 1 } end
	r, g, b = out.accent[1], out.accent[2], out.accent[3]
	out.scheme, out.skin, out.skinId = skin, s and baseOf(s) or skin, skin
	-- The window border: the player's own colour > the accent > the skin's
	-- own windowBorder token > the look's edge.
	local edge = get("ui.borderColor")
	if isColor(edge) then
		out.windowBorder = { edge[1], edge[2], edge[3], 1 }
	elseif get("ui.borderAccent") then
		out.windowBorder = { r, g, b, 0.8 }
	else
		out.windowBorder = copy(stoks and stoks.windowBorder or out.windowEdge or out.border)
	end
	for _, name in ipairs(SKIN_EXTRA) do
		if not out[name] then out[name] = copy(out[HOUSE_EXTRA[name]] or out.text) end
	end
	-- The second accent (a duotone skin's; else the accent) and the arrival
	-- glow (its glow token; else the arrival colour).
	if not (stoks and stoks.accent2) then out.accent2 = copy(out.accent) end
	local far, near = get("nav.arrowColor"), get("nav.arrowNearColor")
	out.arrow = isColor(far) and { far[1], far[2], far[3], 1 } or copy(out.accent)
	out.arrowNear = isColor(near) and { near[1], near[2], near[3], 1 } or copy(out.arrive)
	out.arrowText = copy(out.arrow)
	out.arrowNearText = copy(out.arrowNear)
	out.arrowGlow = copy(stoks and stoks.glow or out.arrowNear)
	return out
end

-- The palette of skin `id` (the one in use when nil); `schemeKey` stands for
-- the player's scheme (a scheme card's preview).
local function resolve(id, schemeKey)
	id = id or Theme.SkinId()
	local s = SKINS[id]
	if s and baseOf(s) ~= "polestar" then
		-- A resolver that failed: the house style for the rest of the session.
		return resolveSkin(id) or resolve("polestar", schemeKey)
	end
	-- A skin on the house style may bring its own scheme (spec.scheme).
	local own = s and not s.builtin and field(s, "scheme")
	local key = schemeKey or (own and SCHEMES[own] and own) or Theme.SchemeKey()
	local src = SCHEMES[key == "ellesmere" and "graphite" or key] or SCHEMES.dusk
	local out = {}
	for name, c in pairs(SHARED) do out[name] = copy(c) end
	for name, c in pairs(ART) do out[name] = copy(c) end
	for name, c in pairs(BRAND) do out[name] = copy(c) end
	for name, c in pairs(src) do out[name] = copy(c) end
	-- A registered skin's own tokens (with its variant and resolver) over the
	-- scheme, under the player's own colours; its accent stands in for
	-- Polestar gold.
	local skinAccent, stoks
	if s and not s.builtin then
		local _media, failed
		stoks, _media, failed = effective(s)
		if failed then return resolve("polestar", schemeKey) end
		givenBy[out] = stoks
		for name, c in pairs(stoks or {}) do
			if name == "accent" then skinAccent = c else out[name] = copy(c) end
		end
	end
	-- Light or dark as the scheme (or skin) gives it, before the player's own
	-- ground and brightness: the way the guard moves the grounds.
	local light = isLight(out)
	if key == "ellesmere" then
		local panel = euiPanel()
		if panel then
			deriveGrounds(out, panel)
			out.bg[4] = panel[4]
		end
	end
	local custom = get("ui.bgColor")
	if isColor(custom) then deriveGrounds(out, custom) end
	-- The panels' and the sidebar's own grounds (alpha optional).
	for _, gname in ipairs({ "panel", "sidebar" }) do
		local c = get("ui." .. gname .. "Color")
		if isColor(c) then out[gname] = { c[1], c[2], c[3], type(c[4]) == "number" and c[4] or out[gname][4] } end
	end
	local bright = get("ui.brightness")
	if type(bright) == "number" and bright ~= 0 then
		for _, gname in ipairs(Theme.GROUNDS) do out[gname] = shifted(out[gname], bright * 0.2) end
	end
	keepLegible(out, light)
	local r, g, b
	local own = get("ui.accent")
	if isColor(own) then
		r, g, b = own[1], own[2], own[3]
	elseif Theme.FollowsClassAccent() then
		r, g, b = legibleOn(out, classColor())
	elseif Theme.FollowsEllesmereAccent() then
		r, g, b = euiAccent()
	end
	if not r then
		local a = skinAccent or SCHEME_INFO[key] and SCHEME_INFO[key].accent or DEFAULT_ACCENT
		r, g, b = a[1], a[2], a[3]
	end
	out.accent = { r, g, b, 1 }
	-- Text on an accent fill: the scheme's dark ink, or the light text when
	-- the accent is too dark to carry dark text.
	if Theme.Contrast(out.text, out.accent) > Theme.Contrast(out.onAccent, out.accent) then out.onAccent = copy(out.text) end
	out.scheme = key
	-- The washes as colours too (Theme.Color("border") for 1px borders).
	local own = SCHEME_WASH[key]
	for name, a in pairs(WASH) do
		if not out[name] then out[name] = { out.ink[1], out.ink[2], out.ink[3], (own and own[name]) or a } end
	end
	ownColours(out)
	ownDepth(out)
	-- The window border: the player's own colour > the accent
	-- (ui.borderAccent, at the focus ring's 80%) > a skin's own windowBorder
	-- token > the scheme's hairline.
	local edge = get("ui.borderColor")
	if isColor(edge) then
		out.windowBorder = { edge[1], edge[2], edge[3], 1 }
	elseif get("ui.borderAccent") then
		out.windowBorder = { r, g, b, 0.8 }
	else
		out.windowBorder = copy(stoks and stoks.windowBorder or out.border)
	end
	-- The waypoint arrow, its route stops and the map's target pin: the
	-- player's own colour > the accent while far; the player's own > success
	-- as it closes in and on arrival. Their *Text forms carry the arrow's
	-- distance line, held to the subject colours' floor (Theme.Legible's
	-- rule, on this palette): a dark pick is lifted toward the text colour.
	local far, near = get("nav.arrowColor"), get("nav.arrowNearColor")
	out.arrow = isColor(far) and { far[1], far[2], far[3], 1 } or copy(out.accent)
	out.arrowNear = isColor(near) and { near[1], near[2], near[3], 1 } or copy(out.success)
	local lightest = lightestOf(out)
	out.arrowText = { liftTo(lightest, out.text, out.arrow) }
	out.arrowNearText = { liftTo(lightest, out.text, out.arrowNear) }
	out.arrowText[4], out.arrowNearText[4] = 1, 1
	for name, from in pairs(HOUSE_EXTRA) do
		if not out[name] then out[name] = copy(out[from]) end
	end
	-- Derived from the accent and the shade unless a skin gives its own.
	local function derived(name, c) if not (stoks and stoks[name]) then out[name] = c end end
	derived("accentLine", { r, g, b, 0.35 })
	derived("padSelect", { r, g, b, 0.12 })
	derived("chipAccent", { r, g, b, 0.16 })
	derived("inputBg", { out.shade[1], out.shade[2], out.shade[3], 0.35 })
	derived("accent2", { r, g, b, 1 })
	out.arrowGlow = copy(stoks and stoks.glow or out.arrowNear)
	out.skin, out.skinId = "polestar", id
	return out
end

-- The whole resolved palette (read-only), e.g. for tests and the options.
function Theme.Palette()
	if drawing.pal then return drawing.pal end
	if not P then P = resolve() end
	return P
end

function Theme.Accent()
	local c = Theme.Palette().accent
	return c[1], c[2], c[3]
end

function Theme.Color(name)
	local pal = Theme.Palette()
	local c = pal[name] or pal.text
	return c[1], c[2], c[3], c[4]
end

-- "ffrrggbb" for |c escapes.
function Theme.Hex(name)
	local r, g, b = Theme.Color(name)
	return format("ff%02x%02x%02x", floor(r * 255 + 0.5), floor(g * 255 + 0.5), floor(b * 255 + 0.5))
end

-- An ink wash at one of the house alphas (Theme.WASH), as a colour.
function Theme.Wash(name)
	local pal = Theme.Palette()
	local c = pal[WASH[name] and name or "border"]
	return c[1], c[2], c[3], c[4]
end

-- The lightest place a list or detail name sits: the panel ground under the
-- selected wash (a selected row). -> { r, g, b }
function Theme.LightestGround()
	return lightestOf(Theme.Palette())
end

-- A colour from outside the palette (an item quality, a quest difficulty)
-- moved toward the text colour until it reads at 4.5:1 on the lightest
-- ground (the subject colours' floor). -> r, g, b
function Theme.Legible(r, g, b)
	local pal = Theme.Palette()
	return liftTo(lightestOf(pal), pal.text, { r, g, b })
end

-- A ground tinted by the accent: `share` of the accent mixed into the
-- palette's window ground (bg), less where the text would no longer read at
-- 7:1 on it (a bright accent on a light skin). Follows the accent: call it
-- from a painter. -> r, g, b, a (the ground's alpha)
function Theme.AccentGround(share)
	local pal = Theme.Palette()
	local g, a, t = pal.bg, pal.accent, pal.text
	local k = share
	while true do
		local c = { g[1] + (a[1] - g[1]) * k, g[2] + (a[2] - g[2]) * k, g[3] + (a[3] - g[3]) * k }
		if k <= 0 or Theme.Contrast(t, c) >= 7 then return c[1], c[2], c[3], g[4] or 1 end
		k = math.max(0, k - 0.02)
	end
end

-- The window border: shown (ui.border), and its thickness in physical
-- pixels (ui.borderSize, 1-4). Its colour is the "windowBorder" token.
-- -> shown, size
function Theme.WindowBorder()
	if get("ui.border") == false then return false, 0 end
	local n = get("ui.borderSize")
	if type(n) ~= "number" then n = 1 end
	return true, math.max(1, math.min(4, floor(n + 0.5)))
end

-- Whether the starlit header band is drawn (ui.band).
function Theme.ShowsBand()
	return get("ui.band") ~= false
end

-- Whether the accent rim and its thrown light top Polestar's windows (ui.rim).
function Theme.ShowsRim()
	return get("ui.rim") ~= false
end

-- The window ground's opacity (ui.bgOpacity, every Polestar window).
function Theme.GroundAlpha()
	local a = get("ui.bgOpacity")
	if type(a) ~= "number" then a = 0.94 end
	return a
end

---------------------------------------------------------------------------
-- Media
---------------------------------------------------------------------------

-- A texture under Media/UI by name; a full path (a skin's own glyph, Theme.Icon)
-- is returned as it is.
function Theme.Media(name)
	if name == "icon-skull" then return "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8" end
	if type(name) == "string" and name:find("[\\/]") then return name end
	return MEDIA .. "UI\\" .. name
end

-- A texture the skin in use brings in place of Polestar's (its media, or
-- its variant's: "band", "bandStars", "medallion"), or nil for Polestar's own.
function Theme.SkinMedia(name)
	local s = SKINS[Theme.SkinId()]
	if not s or s.builtin then return nil end
	local v = s.variants and s.variantBy[variantOf(s)]
	local p = v and v.media and v.media[name]
	if p then return p end
	return s.media and s.media[name] or nil
end

-- A colour token the skin in use gives itself (its tokens, its variant's or
-- its resolver's), or nil when it leaves it to Polestar (a module's own
-- default, e.g. the pins' rim: pinRing, pinFill; the arrow's glow). The
-- colour is the palette's, as resolved. -> r, g, b, a | nil
function Theme.SkinToken(name)
	local pal = Theme.Palette()
	local given = givenBy[pal]
	local c = given and given[name] and pal[name] or nil
	if not c then return nil end
	return c[1], c[2], c[3], c[4] or 1
end

-- Glyphs a skin draws its own way (DIRECTION_B_HALO.md §7: the report flag
-- and the Nearby services house).
local GAME_ICON = { bug = "flag", ["icon-goto"] = "house" }
local SKIN_ICON = { halo = GAME_ICON, hearth = GAME_ICON, forever = GAME_ICON, blizzard = GAME_ICON, classic = GAME_ICON }

-- A glyph's name (or a skin's own texture path) in the skin in use: a
-- registered skin's own pick, else the look it is drawn from.
function Theme.Icon(name)
	local own = SKIN_ICON[Theme.SkinId()]
	local v = own and own[name]
	if v == nil then
		local base = SKIN_ICON[Theme.SkinKey()]
		v = base and base[name]
	end
	return v or name
end

-- The night-sky band is drawn 1024x128 at 1:1. A header shows the top-left
-- w x h of it (texcoords), so stars never stretch.
Theme.BAND_W, Theme.BAND_H = 1024, 128
function Theme.BandCoords(w, h, yOffset)
	local x1 = w / Theme.BAND_W
	if x1 > 1 then x1 = 1 end
	local y0 = (yOffset or 0) / Theme.BAND_H
	local y1 = y0 + h / Theme.BAND_H
	if y1 > 1 then y1 = 1 end
	return 0, x1, y0, y1
end

-- The band itself: the sky (a mask tinted with the scheme's sky colour,
-- fading into whatever ground is under it) with the stars over it. Returns
-- the sky texture; position, size, texcoords and visibility set on it carry
-- to the stars. A header band goes when the player turns the band off
-- (ui.band; painted clear, so its callers keep their own show/hide); `art`
-- marks a band standing in for missing zone art, which always stays.
local bands = setmetatable({}, { __mode = "k" }) -- sky texture -> true

local function paintBand(sky)
	local on = sky.psArt or Theme.ShowsBand()
	sky:SetTexture(Theme.SkinMedia("band") or Theme.Media("band"))
	sky.psStars:SetTexture(Theme.SkinMedia("bandStars") or Theme.Media("band-stars"))
	local r, g, b = Theme.Color("sky")
	sky:SetVertexColor(r, g, b, on and 1 or 0)
	local sr, sg, sb, sa = Theme.Color("star")
	sky.psStars:SetVertexColor(sr, sg, sb, on and (sa or 1) or 0)
end

function Theme.Band(parent, layer, sub, art)
	sub = sub or -5
	local sky = parent:CreateTexture(nil, layer or "BACKGROUND", nil, sub)
	sky:SetTexture(Theme.Media("band"))
	local stars = parent:CreateTexture(nil, layer or "BACKGROUND", nil, sub + 1)
	stars:SetTexture(Theme.Media("band-stars"))
	stars:SetAllPoints(sky)
	sky.psStars = stars
	sky.psArt = art and true or nil
	for _, method in ipairs({ "SetTexCoord", "Show", "Hide", "SetShown", "SetAlpha" }) do
		local own, theirs = sky[method], stars[method]
		sky[method] = function(self, ...)
			own(self, ...)
			theirs(stars, ...)
		end
	end
	bands[sky] = true
	paintBand(sky)
	return sky
end

-- Glyph for a goal verb. Every verb in the guide format has one; anything
-- else (a verb newer than this build) gets the note glyph, never a missing
-- texture.
local VERB_ICON = {}
for _, v in ipairs({ "accept", "turnin", "complete", "kill", "collect", "goto", "talk", "interact", "use", "sethome",
	"hearth", "getfp", "fly", "train", "buy", "vendor", "level", "note", "skill", "learn", "craft", "rep", "explore", "achieve" }) do
	VERB_ICON[v] = MEDIA .. "UI\\icon-" .. v
end
VERB_ICON.enter = VERB_ICON.goto
VERB_ICON.cast = VERB_ICON.use
VERB_ICON.wait = MEDIA .. "UI\\hourglass"

function Theme.VerbIcon(t)
	return VERB_ICON[t] or VERB_ICON.note
end

---------------------------------------------------------------------------
-- Fonts
---------------------------------------------------------------------------

local FACES = {
	regular = MEDIA .. "Fonts\\Inter-Regular.ttf",
	medium = MEDIA .. "Fonts\\Inter-Medium.ttf",
	semibold = MEDIA .. "Fonts\\Inter-SemiBold.ttf",
}

-- The size ladder, read at arm's length over a busy game world.
local ROLES = {
	hero = { "semibold", 26 },     -- shell page titles
	display = { "semibold", 18 },  -- the guide's step title, empty-state titles
	title = { "semibold", 15 },    -- window and guide titles
	heading = { "semibold", 13 },  -- section headers
	body = { "medium", 13 },       -- goal lines, row labels
	label = { "medium", 12 },      -- controls
	note = { "regular", 12 },      -- tips and descriptions
	small = { "medium", 11 },      -- secondary lines
	number = { "semibold", 12 },   -- counters
	caption = { "semibold", 11 },  -- pills and chips
	goal = { "medium", 14 },        -- the guide window's goal lines
	name = { "semibold", 15 },     -- the person to talk to now
	mono = { "medium", 12 },
}

-- Fira Sans (SIL OFL 1.1), the Halo skin's face: Latin, Greek and Cyrillic.
local FIRA = {
	regular = MEDIA .. "Fonts\\FiraSans-Regular.ttf",
	medium = MEDIA .. "Fonts\\FiraSans-Medium.ttf",
	semibold = MEDIA .. "Fonts\\FiraSans-SemiBold.ttf",
}
local OPEN_SANS_REGULAR = MEDIA .. "Fonts\\OpenSans-Regular.ttf"
local OPEN_SANS = {
	regular = OPEN_SANS_REGULAR,
	medium = OPEN_SANS_REGULAR,
	semibold = MEDIA .. "Fonts\\OpenSans-Bold.ttf",
}
local FAMILIES = setmetatable({ opensans = OPEN_SANS, inter = FACES, fira = FIRA }, { __index = EXTRA_FAMILIES })

-- The font a skin starts with (ui.font "skin", the default): the house
-- style and the others use the game's, Halo uses Fira Sans.
local SKIN_FONT = { polestar = "game", halo = "fira", hearth = "game", forever = "game", blizzard = "game", classic = "game" }

-- A skin's own sizes, where they differ from the ladder above (the handoff's
-- typography: DIRECTION_B_HALO.md §2, the same in DIRECTION_A_BLIZZARD.md §2).
local SKIN_ROLES = {
	halo = { hero = { "semibold", 24 } },
	hearth = { hero = { "semibold", 24 } },
}

---------------------------------------------------------------------------
-- Sizes (units) that change with the skin. Each module keeps the house
-- style's value as its own constant and asks Theme.Metric(key, house): a
-- skin's value when it has one (DIRECTION_B_HALO.md §3; Blizzard takes
-- Halo's layout, DIRECTION_A_BLIZZARD.md §4, and its own controls, §3).
---------------------------------------------------------------------------

local METRICS = {
	halo = {
		row = 34, menuRow = 26, menuPad = 6, menuWidth = 260, servicesWidth = 290,
		buttonH = 28, buttonPad = 14, dropdownW = 166, dropdownH = 26, chevron = 10, chevronInset = 8,
		sliderW = 112, valueW = 56, checkbox = 16,
		shellW = 930, shellH = 690, shellSidebar = 200, shellTabs = 32, shellPad = 28, shellFooter = 56,
		pickerW = 1100, pickerH = 640, pickerDetail = 380, pickerSidebar = 230,
		guidePad = 12, guideIconGap = 9, guideTabs = 28, guideNav = 32, guideNavBtn = 22, guideNavIcon = 12,
		guideIconBtnW = 24, guideIconBtnH = 22, guideIcon = 13, guideRow = 22, guideCheck = 16,
		guideProgress = 3, guideGrip = 8, guideFoot = 17, guideUpRow = 20, guideUpToggle = 26, guideNavGap = 2,
	},
	hearth = {
		row = 28, menuRow = 22, menuPad = 6, menuWidth = 260, servicesWidth = 290,
		buttonH = 22, buttonPad = 14, dropdownW = 170, dropdownH = 24, chevron = 10, chevronInset = 6,
		sliderW = 120, valueW = 56, checkbox = 18,
		shellW = 930, shellH = 690, shellSidebar = 200, shellTabs = 32, shellPad = 28, shellFooter = 56,
		pickerW = 1100, pickerH = 640, pickerDetail = 380, pickerSidebar = 230,
		guidePad = 12, guideIconGap = 9, guideTabs = 28, guideNav = 32, guideNavBtn = 20, guideNavIcon = 12,
		guideIconBtnW = 20, guideIconBtnH = 20, guideIcon = 11, guideRow = 22, guideCheck = 15,
		guideProgress = 14, guideGrip = 8, guideFoot = 28, guideUpRow = 20, guideUpToggle = 26, guideNavGap = 4,
	},
}
-- The game's looks take Hearth's sizes and type; WoW Forever's guide window
-- keeps its rows and the lit goal clear of its bronze border (#306), and its
-- tab strip is 30 high so the Settings tab outlines stand clear of the
-- window's edge (#312, GameSkins' tabClear).
for _, k in ipairs({ "forever", "blizzard", "classic" }) do
	METRICS[k] = METRICS.hearth
	SKIN_ROLES[k] = SKIN_ROLES.hearth
end
METRICS.forever = setmetatable({ guidePad = 18, guideLitInset = 10, guideRowPad = 4, guideCheckIn = 10, guideCheckMiddle = true, guideTabs = 30 }, { __index = METRICS.hearth })
Theme.METRICS = METRICS

function Theme.Metric(key, house)
	local m = METRICS[Theme.SkinKey()]
	local v = m and m[key]
	if v == nil then return house end
	return v
end

-- The bundled fonts cover Latin, Greek and Cyrillic; these locales need
-- the client font.
local CJK = { zhCN = true, zhTW = true, koKR = true }

local function gameFont()
	return STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF"
end

-- The face the skin in use starts with: a registered skin's resolver's, its
-- own, else the look it is drawn from.
local function skinFace()
	local id = Theme.SkinId()
	if SKINS[id] and not SKINS[id].builtin then Theme.Palette() end -- the resolver's font, asked with the palette
	return resolvedFont[id] or SKIN_FONT[id] or SKIN_FONT[Theme.SkinKey()] or "game"
end

-- The face in use (ui.font; "skin" follows the skin).
function Theme.FontKey()
	local f = get("ui.font")
	if f == nil or f == "skin" or not (f == "game" or FAMILIES[f]) then f = skinFace() end
	return f
end

-- The text size against every role's own (ui.textSize, 0.8 to 1.4): the
-- window scale leaves the text as it is, this only the text.
function Theme.TextScale()
	local v = tonumber(get("ui.textSize")) or 1
	return math.max(0.8, math.min(1.4, v))
end

-- The roles each size nudge moves (ui.headingSize, ui.smallSize, on top of
-- ui.textSize), and the roles drawn in the heading face (ui.headingFont).
local HEADING_ROLES = { hero = true, display = true, title = true, heading = true }
local SMALL_ROLES = { small = true, caption = true, number = true }

local function nudge(key)
	local v = tonumber(get(key)) or 1
	return math.max(0.7, math.min(1.6, v))
end

-- The outline every Polestar string is drawn with (ui.fontOutline: "none",
-- "outline", "thick") as font flags: "" | "OUTLINE" | "THICKOUTLINE".
local OUTLINE_FLAGS = { outline = "OUTLINE", thick = "THICKOUTLINE" }
function Theme.OutlineFlags()
	return OUTLINE_FLAGS[get("ui.fontOutline")] or ""
end

-- A face key as a setting holds it ("skin" or unknown: the skin's own).
local function resolveFace(v)
	if v == nil or v == "skin" or not (v == "game" or FAMILIES[v]) then return skinFace() end
	return v
end

-- A family's file at a weight ("regular", "medium", "semibold"); the game's
-- font for "game" and on clients the bundled faces cannot draw.
local function facePath(face, weight)
	local locale = GetLocale and GetLocale()
	local fam = FAMILIES[face]
	if not fam or CJK[locale] then return gameFont() end
	return fam[weight or "medium"] or fam.medium
end

-- The file of a face as the font settings name it ("skin" resolves).
function Theme.FacePath(family, weight)
	return facePath(resolveFace(family), weight)
end

-- The faces the font settings offer, each with its file so a picker can
-- draw the name in it: { { value, label, font }, ... }.
function Theme.FontChoices()
	local L = ns.L
	return {
		{ value = "skin", label = L["The skin's font"], font = Theme.FacePath("skin") },
		{ value = "opensans", label = "Open Sans", font = facePath("opensans") },
		{ value = "game", label = L["Game font"], font = gameFont() },
		{ value = "inter", label = "Inter", font = facePath("inter") },
		{ value = "fira", label = "Fira Sans", font = facePath("fira") },
	}
end

function Theme.FontSpec(role)
	local own, base = SKIN_ROLES[Theme.SkinId()], SKIN_ROLES[Theme.SkinKey()]
	local spec = (own and own[role]) or (base and base[role]) or ROLES[role] or ROLES.body
	local k = Theme.TextScale()
	if HEADING_ROLES[role] then k = k * nudge("ui.headingSize") elseif SMALL_ROLES[role] then k = k * nudge("ui.smallSize") end
	local size = math.floor(spec[2] * k * 2 + 0.5) / 2
	local outline = Theme.OutlineFlags()
	-- Headings may take a face of their own; "body" (the default) is the
	-- body's, EllesmereUI's included.
	local heading = HEADING_ROLES[role] and get("ui.headingFont")
	if heading == "body" then heading = nil end
	if not heading and Theme.FollowsEllesmereFont() and S.GetFont then
		local ok, path, flag = pcall(S.GetFont)
		if ok and type(path) == "string" then return path, size, outline ~= "" and outline or flag or "" end
	end
	local locale = GetLocale and GetLocale()
	local face = heading and resolveFace(heading) or Theme.FontKey()
	-- The ruRU client font (FRIZQT___CYR) has no middle dot, which the UI and
	-- guide text use as a separator, and Open Sans has no arrow (U+2192), which
	-- the Russian guide texts use; Fira Sans has both and covers Cyrillic.
	-- Only when the skin picks the face: a font the player chose stays.
	local f = heading or get("ui.font")
	if (face == "game" or face == "opensans") and locale == "ruRU" and (f == nil or f == "skin") then face = "fira" end
	return facePath(face, spec[1]), size, outline
end

-- Polestar's faces, and a Latin or Cyrillic client's own font, have no
-- Hangul, kana or Chinese characters, and a font set by its file keeps none
-- of the game's per-script fallback, so a Chinese name came out as boxes
-- (#353). Text with them takes the client's font for that script, as the
-- game's own font families name it (Blizzard_Fonts_Shared/Shared/Fonts.xml),
-- unless the client's own locale already draws that script. -> path | nil
-- UTF-8 lead bytes E3-E9: U+3000-U+9FFF (CJK punctuation, kana, Chinese);
-- EA-ED: U+A000-U+DFFF (Hangul syllables).
local SCRIPT_FONTS = {
	hangul = { path = "Fonts\\2002.TTF", locales = { koKR = true } },
	han = { path = "Fonts\\ARKai_T.ttf", locales = { zhCN = true, zhTW = true } },
}
function Theme.ScriptFont(text)
	if type(text) ~= "string" then return nil end
	local at = text:find("[\227-\237]")
	if not at then return nil end
	local b = text:byte(at)
	local script = SCRIPT_FONTS[b >= 234 and "hangul" or "han"]
	local locale = GetLocale and GetLocale()
	if script.locales[locale] then return nil end
	return script.path
end

-- Keep a widget's typography when the face already matches (e.g. a colour
-- refresh or a reused map pin). A missing font may return false or raise.
function Theme.SetFace(fs, path, size, flags)
	local current, height, outline = fs:GetFont()
	if current == path and height == size and (outline or "") == flags then return end
	local fallback = gameFont()
	if path ~= fallback then
		local ok, loaded = pcall(fs.SetFont, fs, path, size, flags)
		if ok and loaded then return end
	end
	fs:SetFont(fallback, size, flags)
end

local fonted = setmetatable({}, { __mode = "k" }) -- fontString -> role
local outlined = setmetatable({}, { __mode = "k" }) -- fontString -> true | "thick"
local scaled = setmetatable({}, { __mode = "k" }) -- fontString -> its own size against its role's
local flat = setmetatable({}, { __mode = "k" }) -- fontString -> true: no drop shadow
local scripted = setmetatable({}, { __mode = "k" }) -- fontString -> its text's script font, or false

-- Text shadows: the house style's soft 1, -1; Halo's 1 down at 90 % black
-- (DIRECTION_B_HALO.md §2); Blizzard's hard 1, -1 black, as the game's.
local HARD = { 1, -1, 1 }
local SKIN_SHADOW = { halo = { 0, -1, 0.9 }, hearth = HARD, forever = HARD, blizzard = HARD, classic = HARD }

-- ui.textShadow: "skin" (the default: the skin's own), "soft", "hard" or
-- "none" for every Polestar string.
local function paintShadow(fs)
	if not fs.SetShadowOffset then return end
	local mode = get("ui.textShadow")
	if mode == "none" then
		fs:SetShadowColor(0, 0, 0, 0)
		return
	end
	local r, g, b = Theme.Color("shade")
	local own = SKIN_SHADOW[Theme.SkinId()]
	if own == nil then own = SKIN_SHADOW[Theme.SkinKey()] end
	if mode == "hard" then own = HARD elseif mode == "soft" then own = nil end
	if own then
		fs:SetShadowOffset(own[1], own[2])
		fs:SetShadowColor(0, 0, 0, flat[fs] and 0 or own[3])
		return
	end
	fs:SetShadowOffset(1, -1)
	fs:SetShadowColor(r, g, b, flat[fs] and 0 or (outlined[fs] and 1 or 0.6))
end

-- Forever leaves a string blank after a new font until its text changes
-- (the options' values and tiles after a skin change): set it again. Not an
-- edit box the player is in: setting its text again drops their cursor and
-- selection (#1753: the report box selected for Ctrl+C).
local function textAgain(fs)
	if fs.HasFocus and fs:HasFocus() then return end
	local text = fs.GetText and fs:GetText()
	if text and text ~= "" then
		fs:SetText(text .. " ")
		fs:SetText(text)
	end
end

local retextQueued = false

local function paintFont(fs, role)
	local path, size, flags = Theme.FontSpec(role)
	local text = fs.GetText and fs:GetText()
	local script = Theme.ScriptFont(text)
	scripted[fs] = script or false
	if script then path = script end
	if scaled[fs] then size = math.floor(size * scaled[fs] * 2 + 0.5) / 2 end
	if outlined[fs] then flags = (outlined[fs] == "thick" or flags == "THICKOUTLINE") and "THICKOUTLINE" or "OUTLINE" end
	-- Dark ink on an accent fill takes no outline either: a font that follows
	-- EllesmereUI's brings its OUTLINE, and black round dark glyphs on a
	-- bright accent smears them (#521). MONOCHROME and the like stay.
	if flat[fs] and flags then flags = flags:gsub("THICKOUTLINE", ""):gsub("OUTLINE", ""):gsub("^,+", ""):gsub(",+$", ""):gsub(",,+", ",") end
	Theme.SetFace(fs, path, size, flags)
	paintShadow(fs)
	textAgain(fs)
end

-- New text in another script than the font drawn (a name in Chinese, #353):
-- the string is painted again for it.
local function retext(fs)
	local role = fonted[fs]
	if role and (Theme.ScriptFont(fs:GetText()) or false) ~= scripted[fs] then paintFont(fs, role) end
end

function Theme.Font(fs, role)
	if type(fs) ~= "table" or not fs.SetFont then return fs end
	role = ROLES[role] and role or "body"
	if fonted[fs] == nil and hooksecurefunc and fs.GetText then
		hooksecurefunc(fs, "SetText", retext)
		if fs.SetFormattedText then hooksecurefunc(fs, "SetFormattedText", retext) end
	end
	fonted[fs] = role
	paintFont(fs, role)
	return fs
end

-- Outlined text with a hard shadow, legible over any terrain (the guide
-- window's transparent mode); on = "thick" for the thick outline. Survives
-- theme changes.
function Theme.SetOutline(fs, on)
	outlined[fs] = on == "thick" and "thick" or (on and true or nil)
	if fonted[fs] then paintFont(fs, fonted[fs]) end
end

-- One string's own size against its role's (a surface's text size setting),
-- kept through theme changes; nil or 1 for the role's.
function Theme.SetFontScale(fs, k)
	scaled[fs] = (type(k) == "number" and k > 0 and k ~= 1) and k or nil
	if fonted[fs] then paintFont(fs, fonted[fs]) end
end

-- Dark ink on an accent fill (a primary button's label) takes no drop
-- shadow and no outline: under dark glyphs on a light ground they read as a
-- smear.
function Theme.SetShadow(fs, on)
	local was = flat[fs]
	flat[fs] = (not on) or nil
	if fonted[fs] and was ~= flat[fs] then paintFont(fs, fonted[fs]) else paintShadow(fs) end
end

---------------------------------------------------------------------------
-- Pixel-exact lines
---------------------------------------------------------------------------

-- One physical pixel in a region's coordinate space.
function Theme.Pixel(region)
	local scale = region and region.GetEffectiveScale and region:GetEffectiveScale() or 1
	if PixelUtil and PixelUtil.GetNearestPixelSize then
		local ok, v = pcall(PixelUtil.GetNearestPixelSize, 1, scale, 1)
		if ok and v and v > 0 then return v end
	end
	return 1
end

-- A border as four edge textures, kept on frame.psBorder: one physical
-- pixel by default; `size` pixels grow outward from that pixel (a window's
-- chosen thickness), so the frame's own children never cover it.
function Theme.Border(frame, r, g, b, a, layer, size)
	local e = frame.psBorder
	if not e then
		e = {}
		for i = 1, 4 do
			local t = frame:CreateTexture(nil, layer or "BORDER", nil, 7)
			t:SetTexture(Theme.Media("white"))
			e[i] = t
		end
		frame.psBorder = e
	end
	local px = Theme.Pixel(frame)
	local n = (type(size) == "number" and size > 1) and floor(size + 0.5) or 1
	local w, o = px * n, px * (n - 1)
	local top, bottom, left, right = e[1], e[2], e[3], e[4]
	top:ClearAllPoints(); top:SetPoint("TOPLEFT", frame, "TOPLEFT", -o, o); top:SetPoint("TOPRIGHT", frame, "TOPRIGHT", o, o); top:SetHeight(w)
	bottom:ClearAllPoints(); bottom:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -o, -o); bottom:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", o, -o); bottom:SetHeight(w)
	left:ClearAllPoints(); left:SetPoint("TOPLEFT", top, "BOTTOMLEFT", 0, 0); left:SetPoint("BOTTOMLEFT", bottom, "TOPLEFT", 0, 0); left:SetWidth(w)
	right:ClearAllPoints(); right:SetPoint("TOPRIGHT", top, "BOTTOMRIGHT", 0, 0); right:SetPoint("BOTTOMRIGHT", bottom, "TOPRIGHT", 0, 0); right:SetWidth(w)
	for i = 1, 4 do
		e[i]:SetVertexColor(r, g, b, a)
		e[i]:Show()
	end
	frame.psBorderSize = n
	return e
end

local function hideBorder(frame)
	local e = frame.psBorder
	if e then for i = 1, 4 do e[i]:Hide() end end
end

-- A soft box: the eight outer slices of Media/UI/shadow round frame `s`,
-- corners C square, each slice `S` of the texture from its edge. The
-- texture's shape (the middle 24 of its 64 texels) is feathered over 22
-- texels centred on the shape's edge: nothing out to texel 9, half at 20,
-- solid from 31. -> the eight textures (corners first).
local function softBox(s, C, S)
	local tex = Theme.Media("shadow")
	local parts = {}
	local spec = {
		{ "TOPLEFT", 0, 0, S, S },
		{ "TOPRIGHT", 1 - S, 0, 1, S },
		{ "BOTTOMLEFT", 0, 1 - S, S, 1 },
		{ "BOTTOMRIGHT", 1 - S, 1 - S, 1, 1 },
	}
	for i = 1, 4 do
		local t = s:CreateTexture(nil, "BACKGROUND", nil, -8)
		t:SetTexture(tex)
		t:SetTexCoord(spec[i][2], spec[i][4], spec[i][3], spec[i][5])
		t:SetSize(C, C)
		t:SetPoint(spec[i][1], s, spec[i][1], 0, 0)
		parts[i] = t
	end
	local function edge(a, b, ul, ur, vt, vb)
		local t = s:CreateTexture(nil, "BACKGROUND", nil, -8)
		t:SetTexture(tex)
		t:SetTexCoord(ul, ur, vt, vb)
		t:SetPoint(a[1], a[2], a[3], 0, 0)
		t:SetPoint(b[1], b[2], b[3], 0, 0)
		parts[#parts + 1] = t
	end
	edge({ "TOPLEFT", parts[1], "TOPRIGHT" }, { "BOTTOMRIGHT", parts[2], "BOTTOMLEFT" }, S, 1 - S, 0, S)
	edge({ "TOPLEFT", parts[3], "TOPRIGHT" }, { "BOTTOMRIGHT", parts[4], "BOTTOMLEFT" }, S, 1 - S, 1 - S, 1)
	edge({ "TOPLEFT", parts[1], "BOTTOMLEFT" }, { "BOTTOMRIGHT", parts[3], "TOPRIGHT" }, 0, S, S, 1 - S)
	edge({ "TOPLEFT", parts[2], "BOTTOMLEFT" }, { "BOTTOMRIGHT", parts[4], "TOPRIGHT" }, 1 - S, 1, S, 1 - S)
	return parts
end

-- A soft drop shadow around a window: nine slices of Media/UI/shadow, offset
-- down a little so it reads as depth, not a halo. Sliced at the shape's edge
-- (half strength): the window covers the rest.
local SHADOW_OUT = 16
local SHADOW_DROP = 4
local SLICE = 20 / 64
-- `out` and `drop` (a skin's shadow.size and shadow.drop) default to the
-- house's; a frame's shadow takes new ones in place.
local function shadowFor(frame, out, drop)
	out, drop = out or SHADOW_OUT, drop or SHADOW_DROP
	local s = frame.psShadow
	if not s then
		s = CreateFrame("Frame", nil, frame)
		s:SetFrameLevel(math.max(0, frame:GetFrameLevel() - 1))
		s.parts = softBox(s, SHADOW_OUT + 6, SLICE)
		frame.psShadow = s
	end
	if s.psOut ~= out or s.psDrop ~= drop then
		s:ClearAllPoints()
		s:SetPoint("TOPLEFT", frame, "TOPLEFT", -out, out - drop)
		s:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", out, -out - drop)
		for i = 1, 4 do s.parts[i]:SetSize(out + 6, out + 6) end
		s.psOut, s.psDrop = out, drop
	end
	return s
end

-- A scrim with no edge, for text laid straight on the game world (the
-- transparent guide window's backing): a frame at its parent's level, under
-- the parent's children. Its outer `feather` units are the shadow texture
-- sliced to where its shape turns solid (texel 31): clear over the first
-- s.psClear of them (texels 0-9), then a smooth rise to solid, so two scrims
-- whose rises cover the same band cross-fade without a seam. Place it with
-- SetPoint; Theme.PaintScrim colours it.
local SCRIM_SLICE = 31 / 64
function Theme.Scrim(parent, feather)
	local s = CreateFrame("Frame", nil, parent)
	s:SetFrameLevel(parent:GetFrameLevel())
	local parts = softBox(s, feather, SCRIM_SLICE)
	local mid = s:CreateTexture(nil, "BACKGROUND", nil, -8)
	mid:SetTexture(Theme.Media("white"))
	mid:SetPoint("TOPLEFT", parts[1], "BOTTOMRIGHT", 0, 0)
	mid:SetPoint("BOTTOMRIGHT", parts[4], "TOPLEFT", 0, 0)
	parts[#parts + 1] = mid
	s.parts = parts
	s.psClear = math.floor(feather * 9 / 31 + 0.5)
	return s
end

-- A light shade for one string laid on the game world: nine textures on
-- `parent` under its strings, a solid middle (s.parts[1], placed and sized to
-- the text by the caller) and, round it, the shadow texture's rise from clear
-- to solid over `fx` units left and right and `fy` above and below, so it
-- shows no edge. Coloured by Theme.PaintScrim.
function Theme.TextShade(parent, fx, fy)
	local tex, S = Theme.Media("shadow"), SCRIM_SLICE
	local function part(u0, u1, v0, v1)
		local t = parent:CreateTexture(nil, "BACKGROUND", nil, -8)
		t:SetTexture(tex)
		t:SetTexCoord(u0, u1, v0, v1)
		return t
	end
	local mid = parent:CreateTexture(nil, "BACKGROUND", nil, -8)
	mid:SetTexture(Theme.Media("white"))
	local tl, tr, bl, br = part(0, S, 0, S), part(1 - S, 1, 0, S), part(0, S, 1 - S, 1), part(1 - S, 1, 1 - S, 1)
	for _, c in ipairs({ tl, tr, bl, br }) do c:SetSize(fx, fy) end
	tl:SetPoint("BOTTOMRIGHT", mid, "TOPLEFT", 0, 0)
	tr:SetPoint("BOTTOMLEFT", mid, "TOPRIGHT", 0, 0)
	bl:SetPoint("TOPRIGHT", mid, "BOTTOMLEFT", 0, 0)
	br:SetPoint("TOPLEFT", mid, "BOTTOMRIGHT", 0, 0)
	local top, bottom, left, right = part(S, 1 - S, 0, S), part(S, 1 - S, 1 - S, 1), part(0, S, S, 1 - S), part(1 - S, 1, S, 1 - S)
	top:SetPoint("BOTTOMLEFT", mid, "TOPLEFT", 0, 0)
	top:SetPoint("BOTTOMRIGHT", mid, "TOPRIGHT", 0, 0)
	top:SetHeight(fy)
	bottom:SetPoint("TOPLEFT", mid, "BOTTOMLEFT", 0, 0)
	bottom:SetPoint("TOPRIGHT", mid, "BOTTOMRIGHT", 0, 0)
	bottom:SetHeight(fy)
	left:SetPoint("TOPRIGHT", mid, "TOPLEFT", 0, 0)
	left:SetPoint("BOTTOMRIGHT", mid, "BOTTOMLEFT", 0, 0)
	left:SetWidth(fx)
	right:SetPoint("TOPLEFT", mid, "TOPRIGHT", 0, 0)
	right:SetPoint("BOTTOMLEFT", mid, "BOTTOMRIGHT", 0, 0)
	right:SetWidth(fx)
	return { parts = { mid, tl, tr, bl, br, top, bottom, left, right } }
end

-- The scheme's scrim colour at `alpha`. The alpha is the parts' vertex
-- alpha: in the client a texture's SetAlpha sets that same value, so a part
-- is never SetAlpha'd (fold any fade into `alpha`, #1684).
function Theme.PaintScrim(s, alpha)
	local r, g, b = Theme.Color("scrim")
	for i = 1, #s.parts do s.parts[i]:SetVertexColor(r, g, b, alpha) end
end

---------------------------------------------------------------------------
-- Skins (always the house style; see the header comment)
---------------------------------------------------------------------------

local skinned = setmetatable({}, { __mode = "k" }) -- frame -> kind

local function fill(frame, layer, sub)
	local d = frame.psSkin
	if not d.bg then
		d.bg = frame:CreateTexture(nil, layer or "BACKGROUND", nil, sub or -7)
		d.bg:SetTexture(Theme.Media("white"))
		d.bg:SetAllPoints(frame)
	end
	d.bg:Show()
	return d.bg
end

local function hoverWash(frame)
	local d = frame.psSkin
	if not d.hover then
		d.hover = frame:CreateTexture(nil, "HIGHLIGHT")
		d.hover:SetTexture(Theme.Media("white"))
		d.hover:SetAllPoints(frame)
	end
	d.hover:SetVertexColor(Theme.Wash("hover"))
	return d.hover
end

local function glyph(frame, name, size, layer)
	local d = frame.psSkin
	if not d.glyph then
		d.glyph = frame:CreateTexture(nil, layer or "ARTWORK")
		d.glyph:SetPoint("CENTER", frame, "CENTER", 0, 0)
	end
	d.glyph:SetTexture(Theme.Media(name))
	d.glyph:SetSize(size, size)
	d.glyph:Show()
	return d.glyph
end

-- A skin can be turned off on a frame (the transparent guide window):
-- frame.psBare = true hides every fill, border and shadow it painted.
local function bare(f)
	local d = f.psSkin
	if d.bg then d.bg:Hide() end
	hideBorder(f)
	if f.psShadow then f.psShadow:Hide() end
	if d.veil then d.veil:Hide() end
	if d.nine then for _, n in pairs(d.nine) do if n then n:Hide() end end end
end

local HOUSE_PAINT = {
	-- Every window: the ground at the player's opacity, the window border
	-- (Theme.WindowBorder: on or off, its colour and thickness) and the
	-- drop shadow unless the player turned it off. One window may carry its
	-- own ground colour (f.psBgColor, { r, g, b }) and go without the border
	-- (f.psNoBorder): the guide window's own look (UI/GuideFrame.lua).
	window = function(f)
		if f.psBare then return bare(f) end
		local r, g, b = Theme.Color("bg")
		if isColor(f.psBgColor) then r, g, b = f.psBgColor[1], f.psBgColor[2], f.psBgColor[3] end
		local alpha = f.psBgAlpha or Theme.GroundAlpha()
		fill(f):SetVertexColor(r, g, b, alpha)
		local shown, size = Theme.WindowBorder()
		if shown and not f.psNoBorder then
			local br, bg, bb, ba = Theme.Color("windowBorder")
			Theme.Border(f, br, bg, bb, ba, nil, size)
		else
			hideBorder(f)
		end
		if get("ui.shadow") == false then
			if f.psShadow then f.psShadow:Hide() end
			return
		end
		local s = shadowFor(f)
		local sr, sg, sb, sa = Theme.Color("shadow")
		for i = 1, #s.parts do s.parts[i]:SetVertexColor(sr, sg, sb, sa * math.min(1, alpha + 0.1)) end
		s:Show()
	end,
	panel = function(f)
		if f.psBare then return bare(f) end
		fill(f):SetVertexColor(Theme.Color("panel"))
		Theme.Border(f, Theme.Color("border"))
	end,
	sidebar = function(f)
		fill(f):SetVertexColor(Theme.Color("sidebar"))
	end,
	inset = function(f)
		local r, g, b = Theme.Color("shade")
		fill(f):SetVertexColor(r, g, b, 0.25)
		hideBorder(f)
	end,
	button = function(f)
		fill(f):SetVertexColor(Theme.Color("panelAlt"))
		Theme.Border(f, Theme.Color("border"))
		hoverWash(f)
	end,
	dropdown = function(f)
		fill(f):SetVertexColor(Theme.Color("panelAlt"))
		Theme.Border(f, Theme.Color("border"))
		hoverWash(f)
	end,
	-- An action tile (W.ActionTile): a button's ground in the house style.
	tile = function(f)
		fill(f):SetVertexColor(Theme.Color("panelAlt"))
		Theme.Border(f, Theme.Color("border"))
		hoverWash(f)
	end,
	editbox = function(f)
		local r, g, b = Theme.Color("shade")
		fill(f):SetVertexColor(r, g, b, 0.35)
		if f.psFocused then
			local r, g, b = Theme.Accent()
			Theme.Border(f, r, g, b, 0.8)
		else
			Theme.Border(f, Theme.Color("border"))
		end
	end,
	checkbox = function(f)
		local d = f.psSkin
		if not d.box then
			d.box = CreateFrame("Frame", nil, f)
			d.box:SetPoint("CENTER", f, "CENTER", 0, 0)
			d.box:SetSize(14, 14)
			d.box.psSkin = {}
			if f.SetCheckedTexture then
				local check = f:CreateTexture(nil, "OVERLAY")
				check:SetTexture(Theme.Media("check"))
				check:SetSize(12, 12)
				check:SetPoint("CENTER", f, "CENTER", 0, 0)
				f:SetCheckedTexture(check)
				d.check = check
			end
		end
		-- psOnWorld (the transparent guide window's tick boxes): the scrim
		-- inside and an ink edge, so the box holds over bright ground.
		if f.psOnWorld then
			local r, g, b = Theme.Color("scrim")
			fill(d.box):SetVertexColor(r, g, b, 0.6)
			local tr, tg, tb = Theme.Color("textDim")
			Theme.Border(d.box, tr, tg, tb, 0.7)
		else
			local r, g, b = Theme.Color("shade")
			fill(d.box):SetVertexColor(r, g, b, 0.35)
			Theme.Border(d.box, Theme.Wash("box"))
		end
		if d.check then d.check:SetVertexColor(Theme.Accent()) end
		d.box:Show()
		hoverWash(f)
	end,
	tab = function(f)
		local d = f.psSkin
		if not d.bar then
			d.bar = f:CreateTexture(nil, "OVERLAY")
			d.bar:SetTexture(Theme.Media("white"))
			d.bar:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
			d.bar:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
		end
		d.bar:SetHeight(2)
		d.bar:SetVertexColor(Theme.Accent())
		d.bar:SetShown(f.psSelected and true or false)
		hoverWash(f)
		-- Back from a game look's tab, whose label sat on its art.
		local label = rawget(f, "Label")
		if f.psKitLabel and label then
			label:ClearAllPoints()
			label:SetPoint("CENTER", f, "CENTER", 0, 0)
			f.psKitLabel = nil
		end
	end,
	close = function(f)
		glyph(f, "close", 14):SetVertexColor(Theme.Color("textDim"))
		hoverWash(f):SetVertexColor(Theme.Wash("hover"))
	end,
	scrollbar = function(f)
		-- Back from a game look's scroll bar (Theme/GameSkins.lua): the slim
		-- white thumb over the whole bar.
		local thumb = f.thumb or f.psThumb
		if f.psInset then
			f.psInset = nil
			f:SetWidth(6)
			if thumb and thumb.SetTexture then
				thumb:SetTexture(Theme.Media("white"))
				thumb:SetTexCoord(0, 1, 0, 1)
				thumb:SetWidth(2)
			end
		end
		if thumb and thumb.SetVertexColor then thumb:SetVertexColor(Theme.Wash("thumb")) end
	end,
}

---------------------------------------------------------------------------
-- Halo and Blizzard paints (DIRECTION_B_HALO.md §4 and §7,
-- DIRECTION_A_BLIZZARD.md §3 and §6). A kind a skin does not paint falls
-- back to the house paint.
---------------------------------------------------------------------------

-- The soft veil: Media/UI/veil-soft (64 px, its 24 px edge fading to clear)
-- in nine slices, laid 24 units out from the frame so the frame itself sits
-- on the solid middle. Tinted with `token` at `alpha`.
local VEIL_OUT = 24
local VEIL_SLICE = 24 / 64
local function veilFor(frame)
	local v = frame.psSkin.veil
	if v then return v end
	v = CreateFrame("Frame", nil, frame)
	v:SetFrameLevel(math.max(0, frame:GetFrameLevel() - 1))
	v:SetPoint("TOPLEFT", frame, "TOPLEFT", -VEIL_OUT, VEIL_OUT)
	v:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", VEIL_OUT, -VEIL_OUT)
	local tex, a, b = Theme.Media("veil-soft"), VEIL_SLICE, 1 - VEIL_SLICE
	-- { point, relative point x/y in slices, texcoords }
	local cells = {
		{ 0, a, 0, a }, { a, b, 0, a }, { b, 1, 0, a },
		{ 0, a, a, b }, { a, b, a, b }, { b, 1, a, b },
		{ 0, a, b, 1 }, { a, b, b, 1 }, { b, 1, b, 1 },
	}
	v.parts = {}
	for i, c in ipairs(cells) do
		local t = v:CreateTexture(nil, "BACKGROUND", nil, -8)
		t:SetTexture(tex)
		t:SetTexCoord(c[1], c[2], c[3], c[4])
		v.parts[i] = t
	end
	local p, E = v.parts, VEIL_OUT
	p[1]:SetPoint("TOPLEFT", v, "TOPLEFT"); p[1]:SetSize(E, E)
	p[3]:SetPoint("TOPRIGHT", v, "TOPRIGHT"); p[3]:SetSize(E, E)
	p[7]:SetPoint("BOTTOMLEFT", v, "BOTTOMLEFT"); p[7]:SetSize(E, E)
	p[9]:SetPoint("BOTTOMRIGHT", v, "BOTTOMRIGHT"); p[9]:SetSize(E, E)
	p[2]:SetPoint("TOPLEFT", p[1], "TOPRIGHT"); p[2]:SetPoint("BOTTOMRIGHT", p[3], "BOTTOMLEFT")
	p[8]:SetPoint("TOPLEFT", p[7], "TOPRIGHT"); p[8]:SetPoint("BOTTOMRIGHT", p[9], "BOTTOMLEFT")
	p[4]:SetPoint("TOPLEFT", p[1], "BOTTOMLEFT"); p[4]:SetPoint("BOTTOMRIGHT", p[7], "TOPRIGHT")
	p[6]:SetPoint("TOPLEFT", p[3], "BOTTOMLEFT"); p[6]:SetPoint("BOTTOMRIGHT", p[9], "TOPRIGHT")
	p[5]:SetPoint("TOPLEFT", p[1], "BOTTOMRIGHT"); p[5]:SetPoint("BOTTOMRIGHT", p[9], "TOPLEFT")
	frame.psSkin.veil = v
	return v
end

local function showVeil(frame, token, alpha, own)
	local v = veilFor(frame)
	local r, g, b, a = Theme.Color(token)
	if isColor(own) then r, g, b = own[1], own[2], own[3] end
	a = alpha or a
	for i = 1, #v.parts do v.parts[i]:SetVertexColor(r, g, b, a) end
	v:Show()
	return v
end

-- A two-colour fill: vertical (top, bottom), the gradients of Blizzard's
-- frames and buttons where the client has no texture of the exact tint, or
-- horizontal (`orient` "HORIZONTAL": left, right).
local function gradientFill(frame, top, bottom, layer, sub, orient)
	local t = fill(frame, layer, sub)
	t:SetVertexColor(1, 1, 1, 1)
	if t.SetGradient and CreateColor then
		if orient == "HORIZONTAL" then
			t:SetGradient("HORIZONTAL", CreateColor(top[1], top[2], top[3], top[4] or 1), CreateColor(bottom[1], bottom[2], bottom[3], bottom[4] or 1))
		else
			t:SetGradient("VERTICAL", CreateColor(bottom[1], bottom[2], bottom[3], bottom[4] or 1), CreateColor(top[1], top[2], top[3], top[4] or 1))
		end
	else
		t:SetVertexColor(top[1], top[2], top[3], top[4] or 1)
	end
	return t
end

-- The game's red panel button (Interface\Buttons\UI-Panel-Button-*, as
-- UIPanelButtonNoTooltipTemplate lays it: left 12, middle, right 12).
local PANEL_BUTTON = { "Interface\\Buttons\\UI-Panel-Button-Up", "Interface\\Buttons\\UI-Panel-Button-Down",
	"Interface\\Buttons\\UI-Panel-Button-Disabled", "Interface\\Buttons\\UI-Panel-Button-Highlight" }
local function redButton(f)
	local d = f.psSkin
	if not d.red then
		local red = {}
		for i, coords in ipairs({ { 0, 0.09375 }, { 0.09375, 0.53125 }, { 0.53125, 0.625 } }) do
			local t = f:CreateTexture(nil, "BACKGROUND", nil, -6)
			t:SetTexCoord(coords[1], coords[2], 0, 0.6875)
			red[i] = t
		end
		red[1]:SetPoint("TOPLEFT"); red[1]:SetPoint("BOTTOMLEFT"); red[1]:SetWidth(12)
		red[3]:SetPoint("TOPRIGHT"); red[3]:SetPoint("BOTTOMRIGHT"); red[3]:SetWidth(12)
		red[2]:SetPoint("TOPLEFT", red[1], "TOPRIGHT"); red[2]:SetPoint("BOTTOMRIGHT", red[3], "BOTTOMLEFT")
		local hl = f:CreateTexture(nil, "HIGHLIGHT")
		hl:SetTexture(PANEL_BUTTON[4])
		hl:SetTexCoord(0, 0.625, 0, 0.6875)
		hl:SetBlendMode("ADD")
		hl:SetAllPoints(f)
		red.hl = hl
		d.red = red
	end
	local enabled = not (f.IsEnabled and not f:IsEnabled())
	local file = enabled and (f.psPressed and PANEL_BUTTON[2] or PANEL_BUTTON[1]) or PANEL_BUTTON[3]
	for i = 1, 3 do
		d.red[i]:SetTexture(file)
		d.red[i]:SetVertexColor(1, 1, 1, 1)
		d.red[i]:Show()
	end
	d.red.hl:Show()
	return d.red
end

-- Hide whatever another skin painted on a frame before this one paints it.
local function hideAll(v)
	if type(v) ~= "table" then return end
	if v.Hide then v:Hide() return end
	for _, x in pairs(v) do hideAll(x) end
end

-- A texture's own desaturation (0-1), where the client can only switch it.
local function desaturate(t, d)
	if t.SetDesaturation then t:SetDesaturation(d) elseif t.SetDesaturated then t:SetDesaturated(d >= 0.5) end
end

-- Put back the game art a skin's artTint coloured (kit.tintArt).
local function untint(d)
	if not d.tinted then return end
	for t, rec in pairs(d.tinted) do
		local o = rec.orig
		t:SetVertexColor(o[1], o[2], o[3], o[4] or 1)
		desaturate(t, 0)
	end
	d.tinted = nil
end

local function clearSkin(f)
	local d = f.psSkin
	untint(d)
	if d.bg then d.bg:Hide() end
	if d.bg and d.kitFill then
		-- A game look drew its own art in the fill: back to the house fill,
		-- white over the whole frame, untiled.
		d.bg:SetTexture(Theme.Media("white"))
		d.bg:SetTexCoord(0, 1, 0, 1)
		if d.bg.SetHorizTile then d.bg:SetHorizTile(false); d.bg:SetVertTile(false) end
		d.bg:ClearAllPoints()
		d.bg:SetAllPoints(f)
		d.kitFill = nil
	end
	hideBorder(f)
	if f.psShadow then f.psShadow:Hide() end
	if d.veil then d.veil:Hide() end
	if d.nine then for _, n in pairs(d.nine) do if n then n:Hide() end end end
	if d.red then for i = 1, 3 do d.red[i]:Hide() end; d.red.hl:Hide() end
	if d.line then d.line:Hide() end
	if d.hover then d.hover:SetVertexColor(1, 1, 1, 0) end
	-- The game's looks (Theme/GameSkins.lua) keep their pieces here.
	if d.kit then hideAll(d.kit) end
end

-- One 1-unit line along a frame's bottom edge (the dropdowns' accentLine).
local function bottomLine(f, token)
	local d = f.psSkin
	if not d.line then
		d.line = f:CreateTexture(nil, "BORDER")
		d.line:SetTexture(Theme.Media("white"))
		d.line:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 0, 0)
		d.line:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)
		d.line:SetHeight(1)
	end
	d.line:SetVertexColor(Theme.Color(token))
	d.line:Show()
end

-- A window's veil opacity: the skin's (84 %, the guide window's 60 %) scaled
-- by the player's window opacity against its default (ui.bgOpacity, 94 %).
local function veilAlpha(f, token)
	local _, _, _, a = Theme.Color(token)
	local scale = (f.psBgAlpha or Theme.GroundAlpha()) / 0.94
	return math.min(1, a * scale)
end

local SKIN_PAINT = {
	halo = {
		window = function(f)
			if f.psBare then return bare(f) end
			local token = f.psGuide and "veil" or "veilWindow"
			showVeil(f, token, veilAlpha(f, token), f.psBgColor)
			local shown, size = Theme.WindowBorder()
			if shown and not f.psNoBorder and (isColor(get("ui.borderColor")) or get("ui.borderAccent")) then
				Theme.Border(f, Theme.Color("windowBorder"))
			else
				hideBorder(f)
			end
		end,
		panel = function(f)
			if f.psBare then return bare(f) end
			fill(f):SetVertexColor(Theme.Color("menuBg"))
			Theme.Border(f, Theme.Color("separator"))
		end,
		sidebar = function(f) end,
		inset = function(f)
			fill(f):SetVertexColor(1, 1, 1, 0.04)
		end,
		button = function(f)
			fill(f):SetVertexColor(Theme.Color("control"))
			Theme.Border(f, Theme.Color("border"))
			hoverWash(f)
		end,
		dropdown = function(f)
			fill(f):SetVertexColor(Theme.Color("control"))
			Theme.Border(f, Theme.Color("divider"))
			bottomLine(f, "accentLine")
			hoverWash(f)
		end,
		tile = function(f)
			fill(f):SetVertexColor(1, 1, 1, 0.05)
			hideBorder(f)
			hoverWash(f)
		end,
		editbox = function(f)
			fill(f):SetVertexColor(Theme.Color("inputBg"))
			if f.psFocused then
				local r, g, b = Theme.Accent()
				Theme.Border(f, r, g, b, 0.8)
			else
				Theme.Border(f, Theme.Color("border"))
			end
		end,
		checkbox = function(f)
			HOUSE_PAINT.checkbox(f)
			local d = f.psSkin
			d.box:SetSize(16, 16)
			fill(d.box):SetVertexColor(Theme.Color("inputBg"))
			Theme.Border(d.box, Theme.Color("box"))
		end,
	},
	hearth = {
		-- Flat windows (Yendi, after playing it): the handoff's brown gradient
		-- without the game's metal frame, edged by the window border setting
		-- in a brown hairline (#5C4518) unless the player picked their own.
		window = function(f)
			if f.psBare then return bare(f) end
			local a = veilAlpha(f, "bg")
			local top, bottom = { Theme.Color("bg") }, { Theme.Color("bgBottom") }
			if isColor(f.psBgColor) then
				top = { f.psBgColor[1], f.psBgColor[2], f.psBgColor[3] }
				bottom = shifted(top, -0.08)
			end
			top[4], bottom[4] = a, a
			gradientFill(f, top, bottom)
			local shown, size = Theme.WindowBorder()
			if shown and not f.psNoBorder then
				local br, bg, bb, ba = Theme.Color("windowBorder")
				Theme.Border(f, br, bg, bb, ba, nil, size)
			else
				hideBorder(f)
			end
		end,
		panel = function(f)
			if f.psBare then return bare(f) end
			local top, bottom = { Theme.Color("bg") }, { Theme.Color("bgBottom") }
			top[4], bottom[4] = 0.97, 0.97
			gradientFill(f, top, bottom)
			Theme.Border(f, Theme.Color("frameEdgeDark"))
		end,
		tile = function(f)
			fill(f):SetVertexColor(0, 0, 0, 0.4)
			Theme.Border(f, Theme.Color("titleLine"))
			hoverWash(f)
		end,
		sidebar = function(f)
			fill(f):SetVertexColor(Theme.Color("sidebar"))
		end,
		inset = function(f)
			fill(f):SetVertexColor(0, 0, 0, 0.45)
		end,
		-- The game's red button for text buttons (W.Button) alone; anything
		-- else painted as a button (cards, rows, tiles) is a dark well edged
		-- in brown.
		button = function(f)
			if f.psTextButton then return redButton(f) end
			fill(f):SetVertexColor(0, 0, 0, 0.4)
			Theme.Border(f, Theme.Color("titleLine"))
			hoverWash(f)
		end,
		dropdown = function(f)
			fill(f):SetVertexColor(Theme.Color("control"))
			Theme.Border(f, Theme.Color("border"))
			hoverWash(f)
		end,
		editbox = function(f)
			fill(f):SetVertexColor(Theme.Color("inputBg"))
			if f.psFocused then
				local r, g, b = Theme.Accent()
				Theme.Border(f, r, g, b, 0.8)
			else
				Theme.Border(f, Theme.Color("border"))
			end
		end,
		checkbox = function(f)
			HOUSE_PAINT.checkbox(f)
			local d = f.psSkin
			d.box:SetSize(15, 15)
			gradientFill(d.box, { 0, 0, 0, 1 }, { 0.11, 0.11, 0.11, 1 })
			Theme.Border(d.box, Theme.Color("box"))
		end,
	},
}
Theme.SKIN_PAINT = SKIN_PAINT
-- The paint helpers Theme/GameSkins.lua builds the game's looks from.
Theme.Paint = { fill = fill, hoverWash = hoverWash, bare = bare, hideBorder = hideBorder, redButton = redButton, house = HOUSE_PAINT }

-- What a registered skin's painters and hooks may build with
-- (docs/skins/reference.md, "The paint kit"): the house fills, borders and
-- washes, and store(f), a table on the frame for the skin's own pieces, one
-- per skin. A painted frame's are hidden whenever another look paints it; a
-- hooked frame's (the arrow, a pin, a button, a toast's parts...) as the skin
-- in use changes (switchSkin).
local hookKits = setmetatable({}, { __mode = "k" }) -- frame (not painted) -> its kit
local function skinStore(f)
	local kit
	if skinned[f] then
		local d = f.psSkin
		kit = d.kit
		if not kit then kit = {}; d.kit = kit end
	else
		kit = hookKits[f]
		if not kit then kit = {}; hookKits[f] = kit end
	end
	local api = kit.api
	if not api then api = {}; kit.api = api end
	local id = Theme.SkinId()
	local own = api[id]
	if not own then own = {}; api[id] = own end
	return own
end

-- A colour as a kit option gives it: a token name or { r, g, b[, a] }.
-- -> r, g, b, a
local function kitColor(c, default)
	if type(c) == "string" then return Theme.Color(c) end
	if type(c) == "table" and type(c[1]) == "number" then return c[1], c[2], c[3], c[4] or 1 end
	if default then return kitColor(default) end
	return 1, 1, 1, 1
end

-- Whether the player asked for less motion (ui.reduceMotion): a crossfade
-- or a pulse is then instant or still.
function Theme.ReduceMotion()
	return get("ui.reduceMotion") and true or false
end

-- kit.glow: a soft light (Media/UI/glow) at a point of the frame, kept in
-- the frame's skin store under opts.key or the point. -> texture
local function kitGlow(f, o)
	o = o or {}
	local st = skinStore(f)
	local key = "glow:" .. tostring(o.key or o.point or "CENTER")
	local t = st[key]
	if not t then
		t = f:CreateTexture(nil, o.layer or "BACKGROUND", nil, o.sub or -5)
		t:SetTexture(Theme.Media("glow"))
		st[key] = t
	end
	t:SetBlendMode(o.blend or "ADD")
	local w, h = 96, 96
	if type(o.size) == "number" then w, h = o.size, o.size elseif type(o.size) == "table" then w, h = o.size[1] or w, o.size[2] or h end
	t:SetSize(w, h)
	local off = type(o.offset) == "table" and o.offset or {}
	t:ClearAllPoints()
	t:SetPoint("CENTER", f, o.point or "CENTER", off[1] or 0, off[2] or 0)
	t:SetVertexColor(kitColor(o.color, "accent"))
	t:Show()
	return t
end

-- kit.gameArt: one of the client's own pictures (a loading screen, journal
-- art) laid behind the frame's content, under its text, cropped to cover
-- the frame (or stretched), desaturated, tinted and faded. Kept in the
-- frame's skin store under opts.key; laid out again when the frame resizes.
-- -> texture (its .psArt the record kit.crossfade uses)
-- The store holds only the textures (another skin hides them all); the
-- frame and the options each record was laid out for are kept beside it.
local ART_FADES = { bottom = true, top = true, both = true, none = true, left = true, right = true }
local ARTINFO = setmetatable({}, { __mode = "k" }) -- record -> { frame, opts, file, fading }
local function artLayout(tex, twin, info)
	local o, f = info.opts, info.frame
	local w = o.width or f:GetWidth() or 0
	local h = o.height or f:GetHeight() or 0
	local c = type(o.coords) == "table" and o.coords or { 0, 1, 0, 1 }
	local l, r, t, b = c[1] or 0, c[2] or 1, c[3] or 0, c[4] or 1
	if o.crop ~= "stretch" and w > 0 and h > 0 then
		local aspect = tonumber(o.aspect) or 4 / 3
		local fa = w / h
		if fa > aspect then -- wider than the art: crop its top and bottom
			local keep = (b - t) * aspect / fa
			local mid = t + (b - t) * (tonumber(o.focus) or 0.5)
			local top0, bottom0 = t, b
			t, b = mid - keep / 2, mid + keep / 2
			if t < top0 then t, b = top0, top0 + keep elseif b > bottom0 then t, b = bottom0 - keep, bottom0 end
		else -- taller: crop its sides
			local keep = (r - l) * fa / aspect
			local mid = (l + r) / 2
			l, r = mid - keep / 2, mid + keep / 2
		end
	end
	local tr, tg, tb = kitColor(o.tint, { 1, 1, 1, 1 })
	local alpha = math.max(0, math.min(0.35, tonumber(o.alpha) or 0.2))
	local function place(tx, part)
		tx:ClearAllPoints()
		local fade = o.fade or "bottom"
		local tt, bb = t, b
		if part then
			-- Two halves ("both"), each fading to its outer edge.
			local half = h / 2
			tx:SetPoint("TOPLEFT", f, "TOPLEFT", 0, part == "top" and 0 or -half)
			tx:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, part == "top" and 0 or -half)
			tx:SetHeight(half)
			if part == "top" then bb = (t + b) / 2 else tt = (t + b) / 2 end
			fade = part
		else
			local anchors = o.anchors
			if type(anchors) == "table" and #anchors > 0 then
				for _, p in ipairs(anchors) do tx:SetPoint(p[1], p[2] or f, p[3] or p[1], p[4] or 0, p[5] or 0) end
			else
				tx:SetPoint("TOPLEFT", f, "TOPLEFT", 0, 0)
				tx:SetPoint("TOPRIGHT", f, "TOPRIGHT", 0, 0)
				if o.height then tx:SetHeight(o.height) else tx:SetPoint("BOTTOM", f, "BOTTOM", 0, 0) end
			end
		end
		tx:SetTexCoord(l, r, tt, bb)
		desaturate(tx, math.max(0, math.min(1, tonumber(o.desaturate) or 0.7)))
		if fade ~= "none" and tx.SetGradient and CreateColor then
			local on, off = CreateColor(tr, tg, tb, alpha), CreateColor(tr, tg, tb, 0)
			if fade == "bottom" then tx:SetGradient("VERTICAL", off, on)
			elseif fade == "top" then tx:SetGradient("VERTICAL", on, off)
			elseif fade == "left" then tx:SetGradient("HORIZONTAL", off, on)
			else tx:SetGradient("HORIZONTAL", on, off) end
		else
			tx:SetVertexColor(tr, tg, tb, alpha)
		end
	end
	local both = (o.fade == "both")
	place(tex, both and "top" or nil)
	if both then place(twin, "bottom"); twin:Show() else twin:Hide() end
end

local function kitGameArt(f, o)
	if type(o) ~= "table" or (o.file == nil) then error("kit.gameArt needs { file = path or fileID, ... }", 2) end
	if o.fade ~= nil and not ART_FADES[o.fade] then error("kit.gameArt: fade must be bottom, top, both, left, right or none", 2) end
	local st = skinStore(f)
	local key = "gameArt:" .. tostring(o.key or "art")
	local a = st[key]
	if not a then
		local layer, sub = o.layer or "BACKGROUND", o.sub or -6
		a = { tex = f:CreateTexture(nil, layer, nil, sub), twin = f:CreateTexture(nil, layer, nil, sub) }
		a.tex.psArt = a
		st[key] = a
		ARTINFO[a] = { frame = f }
		if f.HookScript then
			f:HookScript("OnSizeChanged", function()
				local info = ARTINFO[a]
				if info and info.opts and a.tex:IsShown() then artLayout(a.tex, a.twin, info) end
			end)
		end
	end
	local info = ARTINFO[a]
	info.opts = o
	if info.file ~= o.file and not info.fading then
		info.file = o.file
		a.tex:SetTexture(o.file)
		a.twin:SetTexture(o.file)
	end
	a.tex:Show()
	artLayout(a.tex, a.twin, info)
	return a.tex
end

-- kit.crossfade: the picture of a kit.gameArt texture changed to `file`,
-- fading over `seconds` (0.6 by default; at once with Reduce motion or while
-- hidden).
local function kitCrossfade(tex, file, seconds)
	local a = type(tex) == "table" and tex.psArt
	local info = a and ARTINFO[a]
	if not info then
		if type(tex) == "table" and tex.SetTexture then tex:SetTexture(file) end
		return
	end
	if info.file == file then return end
	local A = ns.Anim
	if Theme.ReduceMotion() or not (A and A.To) or not a.tex:IsVisible() then
		info.file = file
		a.tex:SetTexture(file)
		a.twin:SetTexture(file)
		return
	end
	local f = info.frame
	if not a.ntex then
		local layer, sub = a.tex:GetDrawLayer()
		a.ntex, a.ntwin = f:CreateTexture(nil, layer, nil, sub), f:CreateTexture(nil, layer, nil, sub)
	end
	a.ntex:SetTexture(file)
	a.ntwin:SetTexture(file)
	artLayout(a.ntex, a.ntwin, info)
	a.ntex:Show()
	local dur = tonumber(seconds) or 0.6
	info.fading = true
	a.ntex:SetAlpha(0); a.ntwin:SetAlpha(0)
	A.To(a.ntex, "alpha", 0, 1, dur, "linear")
	A.To(a.ntwin, "alpha", 0, 1, dur, "linear")
	A.To(a.twin, "alpha", 1, 0, dur, "linear")
	A.To(a.tex, "alpha", 1, 0, dur, "linear", function()
		info.file, info.fading = file, nil
		a.tex:SetTexture(file); a.twin:SetTexture(file)
		a.tex:SetAlpha(1); a.twin:SetAlpha(1)
		a.ntex:Hide(); a.ntwin:Hide()
	end)
end

-- kit.tintArt: the game art a base look drew on the frame (Theme/GameSkins.lua:
-- its nine-slices, plates and the red buttons), desaturated (0-1), brighter
-- or darker (brightness -1..1) and tinted. What the base sets again on its
-- next paint is tinted again from there; another skin puts it all back.
local function kitTintArt(f, o)
	local d = f.psSkin
	if not (d and o) then return end
	d.tinted = d.tinted or {}
	local tr, tg, tb = kitColor(o.tint, { 1, 1, 1, 1 })
	local k = 1 + math.max(-1, math.min(1, tonumber(o.brightness) or 0))
	tr, tg, tb = math.min(1, tr * k), math.min(1, tg * k), math.min(1, tb * k)
	local desat = math.max(0, math.min(1, tonumber(o.desaturate) or 0))
	local function each(t, depth)
		if type(t) ~= "table" or depth > 6 then return end
		if t.GetObjectType then
			-- Art the base drew through Theme.TintArt is tinted already.
			if t.SetVertexColor and t:GetObjectType() == "Texture" and not t.psArtTinted then
				local rec = d.tinted[t]
				local cr, cg, cb, ca = t:GetVertexColor()
				-- What the base set since our last tint is the new original.
				if not rec or not (rec.set and math.abs(cr - rec.set[1]) < 1e-3 and math.abs(cg - rec.set[2]) < 1e-3 and math.abs(cb - rec.set[3]) < 1e-3) then
					rec = { orig = { cr, cg, cb, ca or 1 } }
					d.tinted[t] = rec
				end
				local o0 = rec.orig
				rec.set = { o0[1] * tr, o0[2] * tg, o0[3] * tb }
				t:SetVertexColor(rec.set[1], rec.set[2], rec.set[3], o0[4])
				desaturate(t, desat)
			end
			return
		end
		for key, x in pairs(t) do
			if key ~= "api" then each(x, depth + 1) end
		end
	end
	each(d.kit, 0)
	each(d.red, 0)
	each(d.nine, 0)
	if d.kitFill and d.bg then each(d.bg, 0) end
end

local KIT = {
	fill = fill, hoverWash = hoverWash, hideBorder = hideBorder, store = skinStore,
	-- (frame, from, to, layer, sub, orient): from is the top (vertical) or the left ("HORIZONTAL").
	gradient = gradientFill,
	border = function(f, r, g, b, a, layer, size) return Theme.Border(f, r, g, b, a, layer, size) end,
	bare = function(f)
		bare(f)
		hideAll(skinStore(f))
	end,
	glow = kitGlow, gameArt = kitGameArt, crossfade = kitCrossfade, tintArt = kitTintArt,
	color = kitColor,
}
Theme.SkinKit = KIT

-- A registered skin's own painter for a frame of `kind`: the guide window
-- and the toasts (windows marked psGuide, psLight) may have their own.
local function ownPainter(s, frame, kind)
	local own = s.paint
	if not own then return nil end
	if kind == "window" then
		if frame.psGuide and own.guide then return own.guide end
		if frame.psLight and own.toast then return own.toast end
	end
	return own[kind]
end

-- A registered skin whose painter, hook or resolver raised: noted once, off
-- for the rest of the session (the saved ui.skin stays), everything
-- repainted in the house style. Inside Theme.Refresh's loop the repaint waits
-- for its end; `deferred` (a resolver, asked while the palette is built)
-- waits for the next frame.
local refreshing, refreshAgain = false, false
failSkin = function(id, err, deferred)
	local s = SKINS[id]
	if FAILED[id] or not s or s.builtin then return end
	FAILED[id] = tostring(err)
	local who = s.addon or "?"
	if ns.NoteError then ns.NoteError(format("skin %s (%s): %s", id, who, tostring(err))) end
	if ns.Print and ns.L then
		ns.Print(format(ns.L["The skin %s (from %s) ran into an error, so Polestar's own look stands in until you reload. Its addon may need an update."], s.name or id, who))
	end
	if refreshing then
		refreshAgain = true
	elseif deferred then
		if ns.After then ns.After(0, function() Theme.Refresh() end) end
	elseif Theme.Refresh then
		Theme.Refresh()
	end
end

-- The base look's art a skin built on the game's art may tint.
local ART_BASES = { hearth = true, forever = true, blizzard = true, classic = true }

-- The art tint of the skin in use (its artTint, or its variant's) while it
-- is drawn from a game look's art, else nil.
local function artTintNow()
	local s = SKINS[Theme.SkinId()]
	if not s or s.builtin or not ART_BASES[baseOf(s)] then return nil end
	return field(s, "artTint")
end

-- A piece of the base look's art in colour r, g, b, a (white when nil), with
-- the skin in use's artTint over it (spec.artTint: tinted, brighter or
-- darker, desaturated); without one, as given and fully saturated. The game
-- looks draw every piece of their art through this (Theme/GameSkins.lua), so
-- the tint reaches it all and goes when the skin does.
function Theme.TintArt(t, r, g, b, a)
	r, g, b, a = r or 1, g or 1, b or 1, a or 1
	local o = artTintNow()
	local desat = 0
	if o then
		local tr, tg, tb = kitColor(o.tint, { 1, 1, 1, 1 })
		local k = 1 + math.max(-1, math.min(1, tonumber(o.brightness) or 0))
		r, g, b = math.min(1, r * tr * k), math.min(1, g * tg * k), math.min(1, b * tb * k)
		desat = math.max(0, math.min(1, tonumber(o.desaturate) or 0))
	end
	t:SetVertexColor(r, g, b, a)
	desaturate(t, desat)
	t.psArtTinted = o and true or nil
end

-- After a frame's painter: a registered skin's own window shadow
-- (spec.shadow) and its tint of the base look's art (spec.artTint).
local function finishPaint(s, frame, kind, base)
	if kind == "window" then
		local sh = field(s, "shadow")
		if sh == false or (sh and (frame.psBare or get("ui.shadow") == false)) then
			if frame.psShadow then frame.psShadow:Hide() end
		elseif sh then
			local sd = shadowFor(frame, sh.size, sh.drop)
			local r, g, b = kitColor(sh.color, "shadow")
			local strength = tonumber(get("ui.shadowStrength")) or 1
			local ground = frame.psBgAlpha or Theme.GroundAlpha()
			local a = math.min(1, sh.alpha * strength) * math.min(1, ground + 0.1)
			for i = 1, #sd.parts do sd.parts[i]:SetVertexColor(r, g, b, a) end
			sd:Show()
		end
	end
	local tint = ART_BASES[base] and field(s, "artTint")
	if tint then kitTintArt(frame, tint) end
end

local function paint(frame, kind)
	frame.psSkin = frame.psSkin or {}
	local id = Theme.SkinId()
	local s = SKINS[id]
	local base = s and baseOf(s) or "polestar"
	-- A skin, and the look it is drawn from (a variant may change it).
	local look = id == base and id or (id .. "/" .. base)
	if frame.psSkin.skin ~= look then
		if frame.psSkin.skin then clearSkin(frame) end
		frame.psSkin.skin = look
	end
	local own = SKIN_PAINT[base]
	local fn = (own and own[kind]) or HOUSE_PAINT[kind] or HOUSE_PAINT.panel
	local registered = s and not s.builtin
	local mine = registered and ownPainter(s, frame, kind)
	local ok, err = true, nil
	if mine then
		ok, err = pcall(mine, frame, fn, KIT)
	else
		fn(frame)
	end
	if ok and registered then ok, err = pcall(finishPaint, s, frame, kind, base) end
	if not ok then
		-- On a picker card the skin is only drawn: the base look's paint
		-- stands in there, and the skin is judged where it is in use.
		if drawing.id then return pcall(fn, frame) end
		failSkin(id, err)
		-- Outside a refresh, failSkin's own refresh has repainted the frame.
		if refreshing then paint(frame, kind) end
	end
end

function Theme.Skin(frame, kind)
	if type(frame) ~= "table" then return frame end
	kind = kind or "panel"
	skinned[frame] = kind
	paint(frame, kind)
	return frame
end

-- Repaint one skinned frame (after changing psBare / psBgAlpha).
function Theme.Repaint(frame)
	local kind = skinned[frame]
	if kind then paint(frame, kind) end
end

-- Tabs we switch ourselves.
function Theme.SetTabSelected(tab, selected)
	tab.psSelected = selected and true or false
	if skinned[tab] then paint(tab, "tab") end
end

-- Edit boxes light their border in the accent while focused.
function Theme.SetFocused(box, focused)
	box.psFocused = focused and true or false
	if skinned[box] == "editbox" then paint(box, "editbox") end
end

---------------------------------------------------------------------------
-- Change notification
---------------------------------------------------------------------------

local handlers = {}

function Theme.OnChanged(fn)
	if type(fn) == "function" then handlers[#handlers + 1] = fn end
end

-- A registered skin's onApply / onLeave, as the skin in use changes.
local applied -- the skin id last applied
local function switchSkin()
	local id = Theme.SkinId()
	if id == applied then return end
	local was = applied and SKINS[applied]
	applied = id
	-- The Skin API's hook table follows the skin in use (Theme/SkinApi.lua).
	local internal = ns.ThemeInternal
	if internal and internal.onSwitch then internal.onSwitch(id) end
	-- The skin that leaves takes its own pieces off the frames it was handed.
	for _, kit in pairs(hookKits) do hideAll(kit) end
	for _, step in ipairs({ { was, "onLeave" }, { SKINS[id], "onApply" } }) do
		local s, name = step[1], step[2]
		if s and type(s[name]) == "function" then
			local ok, err = pcall(s[name], s.id)
			if not ok then failSkin(s.id, err) end
		end
	end
end

-- Repaint everything we skinned or fonted, then tell the listeners.
function Theme.Refresh()
	P = nil
	refreshing = true
	switchSkin()
	for sky in pairs(bands) do paintBand(sky) end
	for frame, kind in pairs(skinned) do paint(frame, kind) end
	for fs, role in pairs(fonted) do paintFont(fs, role) end
	refreshing = false
	-- A registered skin failed while painting: everything again in the house style.
	if refreshAgain then
		refreshAgain = false
		return Theme.Refresh()
	end
	-- EllesmereUI's font is handed over at login, in the frame the window is
	-- first drawn: a string set again in that frame can stay blank, so once more
	-- a frame later.
	if Theme.FollowsEllesmereFont() and C_Timer and C_Timer.After and not retextQueued then
		retextQueued = true
		ns.After(0, function()
			retextQueued = false
			for fs in pairs(fonted) do textAgain(fs) end
		end)
	end
	for i = 1, #handlers do
		local ok, err = pcall(handlers[i])
		if not ok and geterrorhandler then geterrorhandler()(err) end
	end
end

-- A window's strings, set again a frame after it shows or changes scale. On a
-- fresh client start (never after /reload) Forever drew some of a window's
-- first strings blank, in a font another addon handed over too (the hub's
-- rail labels and a guide's faction chip in EllesmereUI's font), and kept
-- them blank: setting the same text again changes nothing, so only new text
-- brought them back. The set in a later frame does (as the hand-over's above).
local retextFrames = {}
local function within(region, frame)
	local p = region:GetParent()
	while p do
		if p == frame then return true end
		p = p:GetParent()
	end
	return false
end
function Theme.RetextLater(frame)
	if type(frame) ~= "table" or not (C_Timer and C_Timer.After) then return end
	if retextFrames[frame] then return end
	retextFrames[frame] = true
	ns.After(0, function()
		retextFrames[frame] = nil
		if not frame:IsVisible() then return end
		for fs in pairs(fonted) do
			-- Font strings only: an edit box's text set again would run its search.
			if fs:GetObjectType() == "FontString" and fs:IsVisible() and within(fs, frame) then textAgain(fs) end
		end
	end)
end

local LOOKS = {
	["ui.accent"] = true, ["ui.font"] = true, ["ui.textSize"] = true, ["ui.skin"] = true, ["ui.scheme"] = true, ["ui.bgColor"] = true, ["ui.bgOpacity"] = true,
	["ui.brightness"] = true, ["ui.matchAccent"] = true, ["ui.classAccent"] = true, ["ui.matchFont"] = true,
	["ui.border"] = true, ["ui.borderColor"] = true, ["ui.borderAccent"] = true, ["ui.borderSize"] = true,
	["ui.band"] = true, ["ui.shadow"] = true, ["nav.arrowColor"] = true, ["nav.arrowNearColor"] = true, ["nav.mapIcons"] = true,
	["ui.fontOutline"] = true, ["ui.textShadow"] = true, ["ui.headingFont"] = true, ["ui.headingSize"] = true, ["ui.smallSize"] = true,
	["ui.textColor"] = true, ["ui.textDimColor"] = true, ["ui.textMutedColor"] = true, ["ui.panelColor"] = true, ["ui.sidebarColor"] = true,
	["ui.hairlineOpacity"] = true, ["ui.shadowStrength"] = true, ["ui.starAlpha"] = true, ["ui.haze"] = true, ["ui.rim"] = true,
	["ui.colors"] = true,
	["ui"] = true, ["nav"] = true, [""] = true,
}
for _, name in ipairs(Theme.SUBJECTS) do LOOKS["ui.colors." .. name] = true end

-- The theme-wide look settings (the Theme options page, UI/Looks/Theme.lua);
-- the older ones are UI.lua's.
if ns.RegisterDefaults then
	local colors = {}
	for _, name in ipairs(Theme.SUBJECTS) do colors[name] = false end
	ns.RegisterDefaults("ui", {
		fontOutline = "none", -- "none" | "outline" | "thick": every Polestar string (Theme.OutlineFlags)
		textShadow = "skin", -- "skin" (the skin's own) | "soft" | "hard" | "none"
		headingFont = "body", -- "body" (the body's face) | "skin" | "opensans" | "game" | "inter" | "fira": hero, display, title, heading
		headingSize = 1, -- 0.7..1.6 on top of textSize: the heading roles
		smallSize = 1, -- 0.7..1.6 on top of textSize: small, caption, number
		textColor = false, textDimColor = false, textMutedColor = false, -- false: the skin's; { r, g, b }: your own, held legible
		colors = colors, -- name -> false | { r, g, b }: the subject and status colours (Theme.SUBJECTS), held legible
		panelColor = false, sidebarColor = false, -- house style: false: derived; { r, g, b[, a] }: your own
		hairlineOpacity = 1, -- 0..3: the hairlines' opacity against the skin's
		shadowStrength = 1, -- 0..2: the window drop shadow's opacity against the skin's
		starAlpha = 1, -- 0..1: the starlit band's stars
		haze = true, -- the blue haze under a night header
		rim = true, -- the accent rim and its light on the top edge of windows (Theme.ShowsRim)
		animSpeed = 1, -- 0.5..2: every Polestar.Anim tween runs this much faster
		skinVariants = {}, -- skin id -> the variant picked (Theme.SkinVariants); none: the skin's default
	})
end

-- Settings that hold a colour ({ r, g, b }, or false for none of your own).
local COLOURS = { ["ui.accent"] = true, ["ui.borderColor"] = true }

-- Turn a colour source off; true when it was on.
local function sourceOff(path)
	if COLOURS[path] then
		if not isColor(get(path)) then return false end
		ns.Set(path, nil)
	else
		if not get(path) then return false end
		ns.Set(path, false)
	end
	return true
end

-- Choosing one colour source (your own colour, your class's, EllesmereUI's;
-- for the window border your own or the accent) turns the others off.
local RIVALS = {
	["ui.accent"] = { "ui.matchAccent", "ui.classAccent" },
	["ui.matchAccent"] = { "ui.accent", "ui.classAccent" },
	["ui.classAccent"] = { "ui.accent", "ui.matchAccent" },
	["ui.borderColor"] = { "ui.borderAccent" },
	["ui.borderAccent"] = { "ui.borderColor" },
}

-- A skin's preset applies many settings at once (Theme.ApplySkinPreset):
-- the palette is repainted once at its end, not once per setting.
local batching, batchRefresh = false, false
if ns.On then
	ns.On("SETTING_CHANGED", function(path, value)
		local rivals = RIVALS[path]
		if rivals and (COLOURS[path] and isColor(value) or not COLOURS[path] and value) then
			local changed = false
			for _, rival in ipairs(rivals) do changed = sourceOff(rival) or changed end
			-- Each change above already repainted through its own event.
			if changed then return end
		end
		-- A variant picked for the skin in use (ui.skinVariants.<id>), or all of them reset.
		local look = LOOKS[path] or path == "ui.skinVariants" or path:sub(1, 16) == "ui.skinVariants." and path:sub(17) == Theme.SkinId()
		if look then
			if batching then batchRefresh = true else Theme.Refresh() end
		end
	end)
end

-- A new zone: a skin with a resolver (spec.resolve) is asked again, and the
-- palette built again only when its answer changed (one keyed to the
-- continent repaints on a new continent, not at every zone border).
if ns.RegisterEvent then
	local function moved()
		ctxRead = false
		local s = SKINS[Theme.SkinId()]
		if not (s and s.resolve and not FAILED[s.id]) then return end
		readContext()
		local ok, rt, rf = pcall(s.resolve, contextFor(s))
		if not ok or answerKey(rt, rf) ~= answered[s.id] then Theme.Refresh() end
	end
	ns.RegisterEvent("PLAYER_ENTERING_WORLD", moved)
	ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", moved)
end

-- Settings from before colour schemes: a stored accent equal to Polestar
-- gold was the old default written back, not a choice; any other stored
-- accent is the user's own and stays.
local function migrate()
	local db = ns.DB and ns.DB()
	local ui = db and db.settings and db.settings.ui
	if type(ui) ~= "table" then return end
	local c = ui.accent
	if isColor(c) then
		local same = true
		for i = 1, 3 do
			if math.abs(c[i] - DEFAULT_ACCENT[i]) > 0.002 then same = false end
		end
		if same then ui.accent = nil end
	elseif c ~= nil then
		ui.accent = nil
	end
	P = nil
end
if ns.OnInit then ns.OnInit(migrate) end
-- The class is certain once logged in; a palette read earlier is redone.
if ns.OnLogin then ns.OnLogin(function() if get("ui.classAccent") then Theme.Refresh() end end) end

---------------------------------------------------------------------------
-- EllesmereUI. Registering is free: when the user turned third-party
-- skinning off for us, the callback never runs and Polestar's own accent
-- and font stay.
---------------------------------------------------------------------------

local function onSkin(primitives)
	S = primitives
	if S.OnLooksChanged then
		pcall(S.OnLooksChanged, function() Theme.Refresh() end)
	end
	Theme.Refresh()
end

if EllesmereUI and EllesmereUI.RegisterSkin then
	pcall(EllesmereUI.RegisterSkin, ADDON, onSkin)
end

-- Keep the shadow and border crisp when the pixel grid moves.
if ns.RegisterEvent then
	ns.RegisterEvent("UI_SCALE_CHANGED", function() Theme.Refresh() end)
	ns.RegisterEvent("DISPLAY_SIZE_CHANGED", function() Theme.Refresh() end)
end

-- Settings written together (a skin's preset and its undo, Theme/SkinApi.lua):
-- the palette is repainted once at the end, not once per setting. -> pcall's
-- ok, err
local function batch(fn)
	batching, batchRefresh = true, false
	local ok, err = pcall(fn)
	batching = false
	if batchRefresh then
		batchRefresh = false
		Theme.Refresh()
	end
	return ok, err
end

-- For Theme/SkinApi.lua (the Skin API), which loads right after this file and
-- takes these as its own locals; it hands back the readers the resolver code
-- above calls (readTokens, readFont).
ns.ThemeInternal = {
	ART = ART,
	BRAND = BRAND,
	FAILED = FAILED,
	FAMILIES = FAMILIES,
	HOUSE_EXTRA = HOUSE_EXTRA,
	RIVALS = RIVALS,
	ROLES = ROLES,
	SCHEMES = SCHEMES,
	SCHEME_INFO = SCHEME_INFO,
	SCHEME_WASH = SCHEME_WASH,
	SHARED = SHARED,
	SKINS = SKINS,
	SKIN_FONT = SKIN_FONT,
	SKIN_ICON = SKIN_ICON,
	SKIN_PALETTES = SKIN_PALETTES,
	SKIN_ROLES = SKIN_ROLES,
	SKIN_SHADOW = SKIN_SHADOW,
	WASH = WASH,
	copy = copy,
	failSkin = failSkin,
	floor = floor,
	format = format,
	get = get,
	ipairs = ipairs,
	isColor = isColor,
	isLight = isLight,
	pairs = pairs,
	pcall = pcall,
	resolve = resolve,
	shifted = shifted,
	switchSkin = switchSkin,
	type = type,
	batch = batch,
	field = field,
	variantOf = variantOf,
	previewing = previewing,
	-- A picker card's skin (SkinPicker.lua): drawing.id / .pal answer for the
	-- live ones while the card is painted with these, which keep no frame
	-- or string for the live repaint.
	drawing = drawing,
	paint = paint,
	paintFont = paintFont,
	provide = function(tokens, font) readTokens, readFont = tokens, font end,
}
