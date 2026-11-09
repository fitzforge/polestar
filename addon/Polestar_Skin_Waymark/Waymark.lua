-- Waymark: the land you're levelling in, through Polestar's Skin API
-- (docs/SKINS-API.md in the Polestar repository). The guide window's header
-- and the settings' sidebar carry the client's own loading screen for the
-- continent the character stands on, desaturated, tinted toward a regional
-- colour and faded into the ground; the accent, the band's light and the
-- map pins' rims take that colour too: Eastern Kingdoms moss, Kalimdor
-- ochre, Outland fel, Northrend ice. It crossfades when the continent
-- changes (at once with Reduce motion). No art ships: the files are the
-- game's, named, never copied.
--
-- What this example shows (Skin API 2; on an older Polestar the skin loads
-- as a plain dark skin without the art and the regional colours):
--   * `resolve(ctx)`: tokens chosen at paint time from where the character
--     is, with `repaintOn = { "continent" }`;
--   * `kit.gameArt` and `kit.crossfade`: a client texture behind a frame,
--     cropped, desaturated, tinted and faded, swapped with a fade;
--   * the `pinRing` token for the step pins' rims.
-- Nothing here touches Polestar's own files.

local ADDON = ...

local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 1) then return end
local V2 = Theme.API_VERSION >= 2

local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

---------------------------------------------------------------------------
-- The regions: by the continent's name (Theme's ctx.continentName) with
-- its uiMapID as a second key, each with its colour and the client's
-- loading screen. Anywhere else: Polestar gold and no art.
---------------------------------------------------------------------------

local SCREENS = "Interface\\Glues\\LoadingScreens\\"
local REGIONS = {
	{ names = { ["Eastern Kingdoms"] = true, [1415] = true }, accent = "#9bb35a", art = SCREENS .. "LoadScreenEasternKingdom", desc = "moss" },
	{ names = { ["Kalimdor"] = true, [1414] = true }, accent = "#d9a441", art = SCREENS .. "LoadScreenKalimdor", desc = "ochre" },
	{ names = { ["Outland"] = true, [1945] = true }, accent = "#7fd43a", art = SCREENS .. "LoadScreenOutland", desc = "fel" },
	{ names = { ["Northrend"] = true, [113] = true }, accent = "#8fd3ff", art = SCREENS .. "LoadScreenNorthrend", desc = "ice" },
}
local ELSEWHERE = { accent = "#e6ba66", art = nil, desc = "gold" }

local function regionFor(ctx)
	if type(ctx) ~= "table" then return ELSEWHERE end
	for _, r in ipairs(REGIONS) do
		if (ctx.continentName and r.names[ctx.continentName]) or (ctx.continent and r.names[ctx.continent]) then return r end
	end
	return ELSEWHERE
end

-- The region in use, kept for the painters (resolve runs before any paint).
local current = ELSEWHERE

---------------------------------------------------------------------------
-- Grounds: a dark, slightly warm neutral the art can sit on in any
-- region; the text ladder white. The regional colour comes from resolve.
---------------------------------------------------------------------------

local TOKENS = {
	bg = "#101211f5", panel = "#151816fa", panelAlt = "#1e2320", sidebar = "#0b0d0c", footer = "#0d0f0e", sky = "#1a1f1c",
	text = "#f4f6f2", textDim = "#c3c9c0", textMuted = "#949b92",
	ink = "#f4f6f2", star = "#ffffff80", shade = "#000000", scrim = "#070807", onAccent = "#101211", shadow = "#000000a6",
	accent = ELSEWHERE.accent,
}

local function rgb(hex)
	return tonumber(hex:sub(2, 3), 16) / 255, tonumber(hex:sub(4, 5), 16) / 255, tonumber(hex:sub(6, 7), 16) / 255
end

---------------------------------------------------------------------------
-- The art: behind the header of every window (where the band is) and down
-- the settings' sidebar, desaturated and tinted a little toward the
-- region, faded into the ground below it.
---------------------------------------------------------------------------

local function artOn(frame, kit, height, alpha, fade)
	local own = kit.store(frame)
	local r = current
	if not (V2 and kit.gameArt) or not r.art then
		if own.art then own.art:Hide() end
		return
	end
	local ar, ag, ab = rgb(r.accent)
	if not own.art then
		own.art = kit.gameArt(frame, { file = r.art, anchors = "top", height = height, crop = "cover", desaturate = 0.7,
			tint = { 0.7 + ar * 0.3, 0.7 + ag * 0.3, 0.7 + ab * 0.3, 1 }, alpha = alpha, fade = fade, layer = "BACKGROUND", sub = -6, key = "art" })
		own.artFile = r.art
	elseif own.artFile ~= r.art then
		kit.crossfade(own.art, r.art, Theme.ReduceMotion and Theme.ReduceMotion() and 0 or 0.5)
		own.artFile = r.art
	end
	own.art:SetVertexColor(0.7 + ar * 0.3, 0.7 + ag * 0.3, 0.7 + ab * 0.3, alpha)
	own.art:SetShown(Theme.ShowsBand())
end

local PAINT = {
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		artOn(frame, kit, 128, 0.38, "bottom")
	end,
	sidebar = function(frame, base, kit)
		base(frame)
		artOn(frame, kit, 220, 0.28, "bottom")
	end,
}

local PRESET = {
	["ui.band"] = true, ["ui.haze"] = true, ["ui.starAlpha"] = 0.5, ["ui.shadow"] = true,
	["nav.lineStyle"] = "dots",
}

local spec = {
	api = V2 and 2 or 1,
	name = "Waymark",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = "The land you're levelling in: the continent's own loading screen behind the header, its colour on the accent and the pins.",
	base = "polestar",
	tokens = TOKENS,
	arrow = "3d",
	mapIcons = "polestar",
	paint = PAINT,
}
if V2 then
	-- The regional colour on the accent (under the player's own), the
	-- band's haze and the pins' rims; repainted when the continent changes.
	spec.resolve = function(ctx)
		current = regionFor(ctx)
		local a = current.accent
		return { accent = a, pinRing = a, haze = a .. "40" }
	end
	spec.repaintOn = { "continent" }
	spec.arrow = { fill = "accent" }
end
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin waymark", Theme.RegisterSkin("waymark", spec))
