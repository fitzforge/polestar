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

-- Tints laid on the game's own art (the world map), not on a Polestar
-- ground: the same in every scheme and outside the legibility guard.
local ART = {
	mapUnexplored = { 0.6, 0.66, 0.9, 1 }, -- multiplied onto unexplored map overlays
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
SKIN_PALETTES.blizzard = gamePalette({
	bg = hex("000000", 0.96), bgBottom = hex("000000", 0.96), sidebar = hex("000000", 0.25),
	icon = hex("E8E8E8"), iconHover = hex("FFFFFF"), tabRest = hex("FFD100"), rowLabel = hex("FFD100"), navRest = hex("FFD100"),
	separator = hex("FFD100", 0.35), divider = hex("FFFFFF", 0.15), accentLine = hex("FFD100", 0.45),
	border = hex("404040"), windowEdge = hex("404040"), hover = hex("FFFFFF", 0.08), selected = hex("FFD100", 0.14),
})
SKIN_PALETTES.classic = gamePalette({
	bg = hex("101010", 0.85), bgBottom = hex("101010", 0.85), sidebar = hex("000000", 0),
	icon = hex("FFD100"), iconHover = hex("FFFFFF"), tabRest = hex("FFD100"), rowLabel = hex("FFD100"), navRest = hex("FFD100"),
	separator = hex("969696", 0.45), divider = hex("969696", 0.45), accentLine = hex("969696", 0.6),
	border = hex("696969"), windowEdge = hex("696969"), hover = hex("FFFFFF", 0.08), selected = hex("FFD100", 0.14),
})
Theme.SKIN_PALETTES = SKIN_PALETTES
Theme.SKIN_ORDER = { "polestar", "halo", "hearth", "forever", "blizzard", "classic" }
-- The skins drawn in game colours and controls (the client's check boxes,
-- sliders, red buttons, the game font with its hard shadow).
local GAME_SKINS = { hearth = true, forever = true, blizzard = true, classic = true }
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

-- Darken every ground together, by the least lightness that makes all text
-- legible again.
local function keepLegible(P)
	if legibility(P) >= 1 then return P end
	local base = {}
	for _, gname in ipairs(Theme.GROUNDS) do base[gname] = P[gname] end
	local lo, hi = -1, 0 -- lightness shift: lo is legible, hi is not
	for _ = 1, 14 do
		local mid = (lo + hi) / 2
		for _, gname in ipairs(Theme.GROUNDS) do P[gname] = shifted(base[gname], mid) end
		if legibility(P) >= 1 then lo = mid else hi = mid end
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

-- The scheme choices for the options dropdown.
function Theme.SchemeChoices()
	local out = {
		{ value = "dusk", text = ns.L["Dusk"] },
		{ value = "night", text = ns.L["Night"] },
		{ value = "graphite", text = ns.L["Graphite"] },
	}
	if S then out[#out + 1] = { value = "ellesmere", text = "EllesmereUI" } end
	return out
end

-- The player's class colour, from the client (class colour addons may change
-- it). -> r, g, b | nil
local function classColor()
	if not UnitClass then return nil end
	local _, file = UnitClass("player")
	if not file then return nil end
	local c = C_ClassColor and C_ClassColor.GetClassColor and C_ClassColor.GetClassColor(file)
	if not (c and type(c.r) == "number") then c = RAID_CLASS_COLORS and RAID_CLASS_COLORS[file] end
	if not (c and type(c.r) == "number") then return nil end
	return c.r, c.g, c.b
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

local P -- the resolved palette; rebuilt on the next read after a change

-- The skin in use (ui.skin); an unknown value (an older or newer build) is
-- the house style.
function Theme.SkinKey()
	local k = get("ui.skin")
	return SKIN_PALETTES[k] and k or "polestar"
end

-- Whether the skin in use (or `key`) is drawn in the game's colours and
-- controls: Hearth and the game's own looks.
function Theme.GameSkin(key)
	return GAME_SKINS[key or Theme.SkinKey()] or false
end

function Theme.SkinChoices()
	return {
		{ value = "polestar", text = ns.L["Polestar"] },
		{ value = "halo", text = ns.L["Halo"] },
		{ value = "hearth", text = ns.L["Hearth"] },
		{ value = "forever", text = ns.L["WoW Forever"] },
		{ value = "blizzard", text = ns.L["Blizzard"] },
		{ value = "classic", text = ns.L["Classic"] },
	}
end

-- The tokens the skins added, in the house style: what each one stands for
-- there, so a module may read them in any skin.
local HOUSE_EXTRA = {
	textOff = "textMuted", title = "text", link = "npc", todo = "accent", later = "warning", arrive = "success",
	manual = "item", skipped = "spell", separator = "divider", rowLine = "divider", veil = "bg", veilWindow = "bg",
	menuBg = "panel", control = "panelAlt", icon = "textDim", iconHover = "text", buttonText = "text",
	personName = "npc", tabRest = "textDim", rowLabel = "text", navRest = "textDim",
}

-- A skin's palette, with the player's own accent, window border and arrow
-- colours over it.
local function resolveSkin(skin)
	local out = {}
	for name, c in pairs(SHARED) do out[name] = copy(c) end
	for name, c in pairs(ART) do out[name] = copy(c) end
	for name, c in pairs(BRAND) do out[name] = copy(c) end
	for name, c in pairs(SKIN_PALETTES[skin]) do out[name] = copy(c) end
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
	out.scheme, out.skin = skin, skin
	local edge = get("ui.borderColor")
	if isColor(edge) then
		out.windowBorder = { edge[1], edge[2], edge[3], 1 }
	elseif get("ui.borderAccent") then
		out.windowBorder = { r, g, b, 0.8 }
	else
		out.windowBorder = copy(out.windowEdge or out.border)
	end
	local far, near = get("nav.arrowColor"), get("nav.arrowNearColor")
	out.arrow = isColor(far) and { far[1], far[2], far[3], 1 } or copy(out.accent)
	out.arrowNear = isColor(near) and { near[1], near[2], near[3], 1 } or copy(out.arrive)
	out.arrowText = copy(out.arrow)
	out.arrowNearText = copy(out.arrowNear)
	return out
end

local function resolve()
	local skin = Theme.SkinKey()
	if skin ~= "polestar" then return resolveSkin(skin) end
	local key = Theme.SchemeKey()
	local src = SCHEMES[key == "ellesmere" and "graphite" or key]
	local out = {}
	for name, c in pairs(SHARED) do out[name] = copy(c) end
	for name, c in pairs(ART) do out[name] = copy(c) end
	for name, c in pairs(BRAND) do out[name] = copy(c) end
	for name, c in pairs(src) do out[name] = copy(c) end
	if key == "ellesmere" then
		local panel = euiPanel()
		if panel then
			deriveGrounds(out, panel)
			out.bg[4] = panel[4]
		end
	end
	local custom = get("ui.bgColor")
	if isColor(custom) then deriveGrounds(out, custom) end
	local bright = get("ui.brightness")
	if type(bright) == "number" and bright ~= 0 then
		for _, gname in ipairs(Theme.GROUNDS) do out[gname] = shifted(out[gname], bright * 0.2) end
	end
	keepLegible(out)
	local r, g, b
	local own = get("ui.accent")
	if isColor(own) then
		r, g, b = own[1], own[2], own[3]
	elseif Theme.FollowsClassAccent() then
		r, g, b = legibleOn(out, classColor())
	elseif Theme.FollowsEllesmereAccent() then
		r, g, b = euiAccent()
	end
	if not r then r, g, b = DEFAULT_ACCENT[1], DEFAULT_ACCENT[2], DEFAULT_ACCENT[3] end
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
	-- The window border: the player's own colour > the accent
	-- (ui.borderAccent, at the focus ring's 80%) > the scheme's hairline.
	local edge = get("ui.borderColor")
	if isColor(edge) then
		out.windowBorder = { edge[1], edge[2], edge[3], 1 }
	elseif get("ui.borderAccent") then
		out.windowBorder = { r, g, b, 0.8 }
	else
		out.windowBorder = copy(out.border)
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
	out.accentLine = { r, g, b, 0.35 }
	out.padSelect = { r, g, b, 0.12 }
	out.chipAccent = { r, g, b, 0.16 }
	out.inputBg = { out.shade[1], out.shade[2], out.shade[3], 0.35 }
	out.skin = "polestar"
	return out
end

-- The whole resolved palette (read-only), e.g. for tests and the options.
function Theme.Palette()
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

-- The window ground's opacity (ui.bgOpacity, every Polestar window).
function Theme.GroundAlpha()
	local a = get("ui.bgOpacity")
	if type(a) ~= "number" then a = 0.94 end
	return a
end

---------------------------------------------------------------------------
-- Media
---------------------------------------------------------------------------

function Theme.Media(name)
	if name == "icon-skull" then return "Interface\\TargetingFrame\\UI-RaidTargetingIcon_8" end
	return MEDIA .. "UI\\" .. name
end

-- Glyphs a skin draws its own way (DIRECTION_B_HALO.md §7: the report flag
-- and the Nearby services house).
local GAME_ICON = { bug = "flag", ["icon-goto"] = "house" }
local SKIN_ICON = { halo = GAME_ICON, hearth = GAME_ICON, forever = GAME_ICON, blizzard = GAME_ICON, classic = GAME_ICON }

-- A glyph's name in the skin in use.
function Theme.Icon(name)
	local own = SKIN_ICON[Theme.SkinKey()]
	return own and own[name] or name
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
local FAMILIES = { inter = FACES, fira = FIRA }

-- The font a skin starts with (ui.font "skin", the default): the house
-- style and Blizzard the game's own, Halo Fira Sans.
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
-- The game's looks take Hearth's sizes and type.
for _, k in ipairs({ "forever", "blizzard", "classic" }) do
	METRICS[k] = METRICS.hearth
	SKIN_ROLES[k] = SKIN_ROLES.hearth
end
Theme.METRICS = METRICS

function Theme.Metric(key, house)
	local m = METRICS[Theme.SkinKey()]
	local v = m and m[key]
	if v == nil then return house end
	return v
end

-- Inter and Fira Sans cover Latin, Greek and Cyrillic; these locales need
-- the client font.
local CJK = { zhCN = true, zhTW = true, koKR = true }

-- The face in use: "game", "inter" or "fira" (ui.font; "skin" follows the skin).
function Theme.FontKey()
	local f = get("ui.font")
	local skin = Theme.SkinKey()
	-- No setting at all (a Nav-only load, before UI registers its defaults):
	-- Inter in the house style, as before skins.
	if f == nil and skin == "polestar" then return "inter" end
	if f == nil or f == "skin" or not (f == "game" or FAMILIES[f]) then f = SKIN_FONT[skin] end
	return f
end

function Theme.FontSpec(role)
	local own = SKIN_ROLES[Theme.SkinKey()]
	local spec = (own and own[role]) or ROLES[role] or ROLES.body
	local size = spec[2]
	if Theme.FollowsEllesmereFont() and S.GetFont then
		local ok, path, flag = pcall(S.GetFont)
		if ok and type(path) == "string" then return path, size, flag or "" end
	end
	local locale = GetLocale and GetLocale()
	local face = Theme.FontKey()
	-- The ruRU client font (FRIZQT___CYR) has no middle dot, which the UI and
	-- guide text use as a separator; Fira Sans has it and covers Cyrillic.
	-- Only when the skin picks the face: choosing "the game's" font keeps it.
	local f = get("ui.font")
	if face == "game" and locale == "ruRU" and (f == nil or f == "skin") then face = "fira" end
	if face == "game" or CJK[locale] then
		return STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", size, ""
	end
	return FAMILIES[face][spec[1]], size, ""
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

local fonted = setmetatable({}, { __mode = "k" }) -- fontString -> role
local outlined = setmetatable({}, { __mode = "k" }) -- fontString -> true
local flat = setmetatable({}, { __mode = "k" }) -- fontString -> true: no drop shadow
local scripted = setmetatable({}, { __mode = "k" }) -- fontString -> its text's script font, or false

-- Text shadows: the house style's soft 1, -1; Halo's 1 down at 90 % black
-- (DIRECTION_B_HALO.md §2); Blizzard's hard 1, -1 black, as the game's.
local HARD = { 1, -1, 1 }
local SKIN_SHADOW = { halo = { 0, -1, 0.9 }, hearth = HARD, forever = HARD, blizzard = HARD, classic = HARD }

local function paintShadow(fs)
	if not fs.SetShadowOffset then return end
	local r, g, b = Theme.Color("shade")
	local own = SKIN_SHADOW[Theme.SkinKey()]
	if own then
		fs:SetShadowOffset(own[1], own[2])
		fs:SetShadowColor(0, 0, 0, flat[fs] and 0 or own[3])
		return
	end
	fs:SetShadowOffset(1, -1)
	fs:SetShadowColor(r, g, b, flat[fs] and 0 or (outlined[fs] and 1 or 0.6))
end

-- Forever leaves a string blank after a new font until its text changes
-- (the options' values and tiles after a skin change): set it again.
local function textAgain(fs)
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
	if outlined[fs] then flags = "OUTLINE" end
	if not fs:SetFont(path, size, flags) then
		fs:SetFont(STANDARD_TEXT_FONT or "Fonts\\FRIZQT__.TTF", size, flags)
	end
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
-- window's transparent mode). Survives theme changes.
function Theme.SetOutline(fs, on)
	outlined[fs] = on and true or nil
	if fonted[fs] then paintFont(fs, fonted[fs]) end
end

-- Dark ink on an accent fill (a primary button's label) takes no drop
-- shadow: under dark glyphs on a light ground it reads as a smear.
function Theme.SetShadow(fs, on)
	flat[fs] = (not on) or nil
	paintShadow(fs)
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

-- A soft drop shadow around a window: nine slices of Media/UI/shadow, offset
-- down a little so it reads as depth, not a halo.
local SHADOW_OUT = 16
local SHADOW_DROP = 4
local SLICE = 20 / 64
local function shadowFor(frame)
	local s = frame.psShadow
	if s then return s end
	s = CreateFrame("Frame", nil, frame)
	s:SetFrameLevel(math.max(0, frame:GetFrameLevel() - 1))
	s:SetPoint("TOPLEFT", frame, "TOPLEFT", -SHADOW_OUT, SHADOW_OUT - SHADOW_DROP)
	s:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", SHADOW_OUT, -SHADOW_OUT - SHADOW_DROP)
	local tex = Theme.Media("shadow")
	local parts = {}
	local spec = {
		{ "TOPLEFT", 0, 0, SLICE, SLICE },
		{ "TOPRIGHT", 1 - SLICE, 0, 1, SLICE },
		{ "BOTTOMLEFT", 0, 1 - SLICE, SLICE, 1 },
		{ "BOTTOMRIGHT", 1 - SLICE, 1 - SLICE, 1, 1 },
	}
	local C = SHADOW_OUT + 6
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
	edge({ "TOPLEFT", parts[1], "TOPRIGHT" }, { "BOTTOMRIGHT", parts[2], "BOTTOMLEFT" }, SLICE, 1 - SLICE, 0, SLICE)
	edge({ "TOPLEFT", parts[3], "TOPRIGHT" }, { "BOTTOMRIGHT", parts[4], "BOTTOMLEFT" }, SLICE, 1 - SLICE, 1 - SLICE, 1)
	edge({ "TOPLEFT", parts[1], "BOTTOMLEFT" }, { "BOTTOMRIGHT", parts[3], "TOPRIGHT" }, 0, SLICE, SLICE, 1 - SLICE)
	edge({ "TOPLEFT", parts[2], "BOTTOMLEFT" }, { "BOTTOMRIGHT", parts[4], "TOPRIGHT" }, 1 - SLICE, 1, SLICE, 1 - SLICE)
	s.parts = parts
	frame.psShadow = s
	return s
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
	-- drop shadow unless the player turned it off.
	window = function(f)
		if f.psBare then return bare(f) end
		local r, g, b = Theme.Color("bg")
		local alpha = f.psBgAlpha or Theme.GroundAlpha()
		fill(f):SetVertexColor(r, g, b, alpha)
		local shown, size = Theme.WindowBorder()
		if shown then
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
		local r, g, b = Theme.Color("shade")
		fill(d.box):SetVertexColor(r, g, b, 0.35)
		Theme.Border(d.box, Theme.Wash("box"))
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

local function showVeil(frame, token, alpha)
	local v = veilFor(frame)
	local r, g, b, a = Theme.Color(token)
	a = alpha or a
	for i = 1, #v.parts do v.parts[i]:SetVertexColor(r, g, b, a) end
	v:Show()
	return v
end

-- A vertical two-colour fill (top, bottom), the gradients of Blizzard's
-- frames and buttons where the client has no texture of the exact tint.
local function gradientFill(frame, top, bottom, layer, sub)
	local t = fill(frame, layer, sub)
	t:SetVertexColor(1, 1, 1, 1)
	if t.SetGradient and CreateColor then
		t:SetGradient("VERTICAL", CreateColor(bottom[1], bottom[2], bottom[3], bottom[4] or 1), CreateColor(top[1], top[2], top[3], top[4] or 1))
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

local function clearSkin(f)
	local d = f.psSkin
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
			showVeil(f, token, veilAlpha(f, token))
			local shown, size = Theme.WindowBorder()
			if shown and (isColor(get("ui.borderColor")) or get("ui.borderAccent")) then
				Theme.Border(f, Theme.Color("windowBorder"))
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
			top[4], bottom[4] = a, a
			gradientFill(f, top, bottom)
			local shown, size = Theme.WindowBorder()
			if shown then
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

local function paint(frame, kind)
	frame.psSkin = frame.psSkin or {}
	local skin = Theme.SkinKey()
	if frame.psSkin.skin ~= skin then
		if frame.psSkin.skin then clearSkin(frame) end
		frame.psSkin.skin = skin
	end
	local own = SKIN_PAINT[skin]
	local fn = (own and own[kind]) or HOUSE_PAINT[kind] or HOUSE_PAINT.panel
	fn(frame)
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

-- Repaint everything we skinned or fonted, then tell the listeners.
function Theme.Refresh()
	P = nil
	for sky in pairs(bands) do paintBand(sky) end
	for frame, kind in pairs(skinned) do paint(frame, kind) end
	for fs, role in pairs(fonted) do paintFont(fs, role) end
	-- EllesmereUI's font is handed over at login, in the frame the window is
	-- first drawn: a string set again in that frame can stay blank, so once more
	-- a frame later.
	if Theme.FollowsEllesmereFont() and C_Timer and C_Timer.After and not retextQueued then
		retextQueued = true
		C_Timer.After(0, function()
			retextQueued = false
			for fs in pairs(fonted) do textAgain(fs) end
		end)
	end
	for i = 1, #handlers do
		local ok, err = pcall(handlers[i])
		if not ok and geterrorhandler then geterrorhandler()(err) end
	end
end

local LOOKS = {
	["ui.accent"] = true, ["ui.font"] = true, ["ui.skin"] = true, ["ui.scheme"] = true, ["ui.bgColor"] = true, ["ui.bgOpacity"] = true,
	["ui.brightness"] = true, ["ui.matchAccent"] = true, ["ui.classAccent"] = true, ["ui.matchFont"] = true,
	["ui.border"] = true, ["ui.borderColor"] = true, ["ui.borderAccent"] = true, ["ui.borderSize"] = true,
	["ui.band"] = true, ["ui.shadow"] = true, ["nav.arrowColor"] = true, ["nav.arrowNearColor"] = true,
	["ui"] = true, ["nav"] = true, [""] = true,
}

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

if ns.On then
	ns.On("SETTING_CHANGED", function(path, value)
		local rivals = RIVALS[path]
		if rivals and (COLOURS[path] and isColor(value) or not COLOURS[path] and value) then
			local changed = false
			for _, rival in ipairs(rivals) do changed = sourceOff(rival) or changed end
			-- Each change above already repainted through its own event.
			if changed then return end
		end
		if LOOKS[path] then Theme.Refresh() end
	end)
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
