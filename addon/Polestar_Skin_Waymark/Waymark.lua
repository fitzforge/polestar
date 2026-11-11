-- Waymark: the land you're levelling in, through Polestar's Skin API
-- (docs/skins in the Polestar repository). The guide window's header and
-- the settings' sidebar carry the client's own loading screen for the
-- continent the character stands on, desaturated, tinted toward the
-- continent's colour and faded into the ground; the accent, the band's
-- light, the arrow's glow and the map pins' rims take that colour too:
-- Eastern Kingdoms moss, Kalimdor ochre. Polestar crossfades it when the
-- continent changes (at once with Reduce motion). No art ships: the
-- pictures are the game's own files, named here, never copied.
--
-- What this skin shows:
--   * `resolve(ctx)`: tokens chosen from where the character is, asked
--     again by Polestar whenever that changes;
--   * `kit.gameArt` and `kit.crossfade`: a client picture behind a frame,
--     cropped to cover it, desaturated, tinted, faded, swapped with a fade;
--   * the `pinRing` and `glow` tokens for the step pins' rims and the
--     arrow's glow.
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
-- The continents: by name (ctx.continentName) or uiMapID (ctx.continent),
-- each with its colour and its loading screens, Forever's own first, the
-- older one where the client has no Forever picture. Anywhere else (an
-- instance, a map with no continent): Polestar gold and no picture.
---------------------------------------------------------------------------

local SCREENS = "Interface\\Glues\\LoadingScreens\\"
local REGIONS = {
	{ keys = { ["Eastern Kingdoms"] = true, [1415] = true }, accent = "#9bb35a",
		art = { SCREENS .. "Camelot160\\Main\\LoadScreen_Camelot_EasternKingdom", SCREENS .. "LoadScreenEasternKingdom" } },
	{ keys = { ["Kalimdor"] = true, [1414] = true }, accent = "#d9a441",
		art = { SCREENS .. "Camelot160\\Main\\LoadScreen_Camelot_Kalimdor", SCREENS .. "LoadScreenKalimdor" } },
}
local ELSEWHERE = { accent = "#e6ba66" }

-- The first picture of a region the client has (GetFileIDFromPath answers
-- nil for a path it does not know); the last one where it cannot tell.
local function pictureOf(r)
	if not r.art then return nil end
	if r.file == nil then
		r.file = r.art[#r.art]
		if GetFileIDFromPath then
			for _, p in ipairs(r.art) do
				if GetFileIDFromPath(p) then
					r.file = p
					break
				end
			end
		end
	end
	return r.file
end

local function regionFor(ctx)
	if type(ctx) ~= "table" then return ELSEWHERE end
	for _, r in ipairs(REGIONS) do
		if (ctx.continentName and r.keys[ctx.continentName]) or (ctx.continent and r.keys[ctx.continent]) then return r end
	end
	return ELSEWHERE
end

-- The region in use: resolve runs before every paint, the painters read it.
local current = ELSEWHERE

---------------------------------------------------------------------------
-- Grounds: a dark, slightly green-grey neutral the art can sit on in any
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
-- The picture: behind the head of a window (where the band is) and down
-- the settings' sidebar, tinted a little toward the region and faded into
-- the ground below it. Held under Polestar's art ceiling (alpha 0.35), so
-- the text over it keeps its contrast.
---------------------------------------------------------------------------

local function artOn(frame, kit, height, alpha)
	local own = kit.store(frame)
	local file = pictureOf(current)
	if not file or not Theme.ShowsBand() then
		if own.art then own.art:Hide() end
		return
	end
	local ar, ag, ab = rgb(current.accent)
	local opts = { file = own.artFile or file, height = height, crop = "cover", focus = 0.4, desaturate = 0.7,
		tint = { 0.7 + ar * 0.3, 0.7 + ag * 0.3, 0.7 + ab * 0.3, 1 }, alpha = alpha, fade = "bottom",
		layer = "BACKGROUND", sub = -6, key = "waymark" }
	own.art = kit.gameArt(frame, opts)
	if own.artFile ~= file then
		if own.artFile then kit.crossfade(own.art, file, 0.6) end
		own.artFile = file
	end
end

local PAINT = {
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		artOn(frame, kit, 128, 0.32)
	end,
	sidebar = function(frame, base, kit)
		base(frame)
		artOn(frame, kit, 220, 0.24)
	end,
}

local PRESET = {
	["ui.band"] = true, ["ui.haze"] = true, ["ui.starAlpha"] = 0.5, ["ui.shadow"] = true,
	["nav.lineStyle"] = "dots",
}

check("skin waymark", Theme.RegisterSkin("waymark", {
	api = 2,
	name = "Waymark",
	addon = ADDON,
	author = "Polestar",
	desc = "The land you're levelling in: the continent's own loading screen behind the header, its colour on the accent, the arrow and the pins.",
	base = "polestar",
	tokens = TOKENS,
	arrow = "3d",
	mapIcons = "polestar",
	paint = PAINT,
	preset = PRESET,
	-- The continent's colour on the accent (under the player's own), the
	-- band's haze, the arrow's glow and the pins' rims.
	resolve = function(ctx)
		current = regionFor(ctx)
		local a = current.accent
		return { accent = a, pinRing = a, glow = a, haze = a .. "40" }
	end,
}))
