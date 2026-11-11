-- Aurora: Polestar's own night sky, a step further, through its Skin API
-- (docs/skins in the Polestar repository). Deep indigo grounds that
-- fall away toward the foot of every window, a violet sky in the band with
-- the header haze turned teal over it (an aurora under the stars), a cooler
-- ink for the hairlines, pale gold stars, champagne gold for the accent,
-- Inter. Everything else is the house style: Aurora keeps Polestar's
-- frames, sizes, arrow and map pins, and its layout preset only asks for
-- sparkles on the route.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * a scheme and a skin that EXTEND the house style rather than replace
--     it: the skin changes the ground's depth and the band's light and
--     leaves the rest to Polestar;
--   * kit.gradient for a window ground that keeps the player's own ground
--     colour and opacity;
--   * the `haze` token (the night header's glow) as a skin's colour: two
--     colours in the band, the sky's and the haze's, with no texture of
--     the skin's own.
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

---------------------------------------------------------------------------
-- The scheme: Night's depth with Dusk's legibility, a blue-black sky for
-- the band, a cool ink, pale gold stars.
---------------------------------------------------------------------------

local ACCENT = "#ead27f"

check("scheme aurora", Theme.RegisterScheme("aurora", {
	api = 2, name = "Aurora", addon = ADDON, author = "Polestar",
	desc = "Deep indigo grounds under a teal and violet sky.",
	tokens = {
		bg = "#0a0e1df7", panel = "#0f1428fa", panelAlt = "#161d38", sidebar = "#060914", footer = "#080b18", sky = "#1f2458",
		text = "#f3f6ff", textDim = "#c2cbe8", textMuted = "#98a3c9",
		ink = "#dfe6ff", star = "#f6ecc8", shade = "#000010", scrim = "#04060f", onAccent = "#0a0e1d", shadow = "#000010b3",
	},
	accent = ACCENT,
	washes = { border = 0.12, divider = 0.1, selected = 0.12, hover = 0.07 },
}))

---------------------------------------------------------------------------
-- The skin's own colours over the scheme: the house haze in teal over the
-- violet sky, so the band runs teal at its heart and violet at its edges.
---------------------------------------------------------------------------

local TOKENS = {
	accent = ACCENT,
	haze = "#2ad3a870",
}

---------------------------------------------------------------------------
-- Paint: the ground as a vertical gradient, a little light at the top,
-- falling toward black at the foot.
---------------------------------------------------------------------------

local function clamp(x) return x < 0 and 0 or x > 1 and 1 or x end

-- The ground's colour: the window's own or the palette's.
local function ground(frame)
	local c = frame.psBgColor
	if type(c) == "table" and type(c[1]) == "number" then return c[1], c[2], c[3] end
	return Theme.Color("bg")
end

local function depth(frame, kit, alpha)
	local r, g, b = ground(frame)
	kit.gradient(frame, { clamp(r * 1.35 + 0.01), clamp(g * 1.3 + 0.01), clamp(b * 1.25 + 0.02), alpha },
		{ r * 0.6, g * 0.6, b * 0.65, alpha })
end

local PAINT = {
	-- Every window, the guide window and the toasts included: the house
	-- ground, border and shadow, then the ground given its depth.
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		depth(frame, kit, frame.psBgAlpha or Theme.GroundAlpha())
	end,
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		local r, g, b, a = Theme.Color("panel")
		kit.gradient(frame, { clamp(r * 1.25), clamp(g * 1.22), clamp(b * 1.2), a }, { r * 0.75, g * 0.75, b * 0.8, a })
	end,
}

---------------------------------------------------------------------------
-- The layout: the house's, with sparkles on the route and the band's light
-- on. Offered on the Theme page where this Polestar has presets.
---------------------------------------------------------------------------

local PRESET = {
	["ui.style"] = "standard", ["ui.band"] = true, ["ui.shadow"] = true, ["ui.haze"] = true, ["ui.rim"] = true,
	["ui.starAlpha"] = 1, ["ui.shadowStrength"] = 1.3,
	["nav.lineStyle"] = "sparkle",
}

check("skin aurora", Theme.RegisterSkin("aurora", {
	api = 2,
	name = "Aurora",
	addon = ADDON,
	author = "Polestar",
	desc = "The night sky a step further: an aurora in the band, grounds that deepen toward the foot, champagne gold, Inter.",
	base = "polestar",
	scheme = "aurora",
	tokens = TOKENS,
	font = "inter",
	arrow = "3d",
	mapIcons = "polestar",
	paint = PAINT,
	preset = PRESET,
}))
