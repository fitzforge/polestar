-- Moonlit: an example of a Polestar skin in an addon of its own, through
-- Polestar's Skin API (docs/SKINS-API.md in the Polestar repository). It
-- adds two things a player picks under Polestar's settings, Look > Theme:
--   * the colour scheme "Moonlit": cool indigo grounds under a silver text
--     ladder, usable with Polestar's own skin;
--   * the skin "Moonlit": Polestar's own look in that scheme, set in Fira
--     Sans, with a thin line of moonlight along the top of every window, and
--     Halo's arrow and map icons.
-- Nothing here touches Polestar's own files. Copy this folder, rename it and
-- its .toc, and change the ids, names and colours to make your own skin.
-- This example is CC0-1.0 (public domain; LICENSE in this folder): copy any
-- of it into your own skin without conditions.

local ADDON = ...

-- Polestar loads first (## Dependencies: Polestar in the .toc). A Polestar too
-- old for the Skin API has no Theme.RegisterSkin: then this addon does nothing.
local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 1) then return end

-- Each registration answers ok, message. A refusal says why (a missing
-- token, a colour that is not one, text that would not read); an accepted
-- spec may carry a note of what Polestar corrected. Say it where an author
-- sees it.
local function check(what, ok, message)
	if not ok then
		print(("|cffff8040%s|r: %s refused: %s"):format(ADDON, what, tostring(message)))
	elseif message then
		print(("%s: %s: %s"):format(ADDON, what, message))
	end
end

-- The colour scheme. A scheme is the house style's grounds and text ladder:
--   bg        the window ground          panel     raised panels, popups
--   panelAlt  controls (buttons, fields) sidebar   the settings' sidebar
--   footer    window footers             sky       the top of the starlit band
--   text, textDim, textMuted   the text ladder (100 / 70 / 50)
-- and may add ink (hairlines), star (the band's stars), shade, scrim,
-- onAccent (text on an accent fill) and shadow (the window's drop shadow).
-- Colours are "#rrggbb", "#rrggbbaa" or { r, g, b[, a] } from 0 to 1.
-- Polestar holds the text to 7:1 (primary) and 4.5:1 (the rest) on every
-- ground; a scheme that falls short has its grounds darkened until it reads
-- (or is refused, with strict = true).
check("scheme moonlit", Theme.RegisterScheme("moonlit", {
	api = 1, -- the Skin API version this was written for
	name = "Moonlit", -- shown in the picker as it is (yours to translate)
	addon = ADDON, -- shown beside the name
	author = "Polestar",
	version = "1.0",
	desc = "Cool indigo grounds under a silver text ladder.",
	tokens = {
		bg = "#12142af7", panel = "#161937fa", panelAlt = "#1f2347",
		sidebar = "#0d0f20", footer = "#0f1124", sky = "#2b3060",
		text = "#f2f3fa", textDim = "#c3c7de", textMuted = "#9ca1c0",
		star = "#e8ecff", scrim = "#06071a", onAccent = "#0e1022",
	},
	-- Moonlight where the player has not picked an accent of their own.
	accent = "#afc0ff",
	-- Hairlines and selections a touch stronger than the house's on this
	-- lighter ground (alphas of the white ink).
	washes = { border = 0.1, divider = 0.1, selected = 0.12 },
}))

-- The skin: Polestar's own look (base = "polestar") in the scheme above. A
-- skin may also extend "halo", "hearth" or the game's looks ("forever",
-- "blizzard", "classic"); then it gives tokens over that look's palette
-- instead of a scheme.
check("skin moonlit", Theme.RegisterSkin("moonlit", {
	api = 1,
	name = "Moonlit",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = "Polestar in moonlight: Moonlit's colours, Fira Sans, a silver edge on every window.",
	base = "polestar",
	scheme = "moonlit",
	-- The face every Polestar string takes while the player keeps the font
	-- on "The skin's font": "game", "inter", "fira", "opensans", or your own
	-- files: { regular = "Interface\\AddOns\\<you>\\Fonts\\X.ttf", ... }.
	font = "fira",
	fontSizes = { hero = 24 },
	-- The arrow and the map icons a player on "Skin" gets.
	arrow = "halo",
	mapIcons = "halo",
	-- Painters: one per kind of frame Polestar skins. Each gets the frame,
	-- `base` (the look this skin extends, for that kind) and `kit` (fills,
	-- borders and a store for your own textures, hidden when another skin
	-- takes over). An error here turns this skin off for the session and
	-- Polestar's own look stands in, so a mistake never breaks the UI.
	paint = {
		window = function(frame, base, kit)
			base(frame)
			local own = kit.store(frame)
			-- A transparent window (frame.psBare) shows no ground at all.
			if frame.psBare then
				if own.moon then own.moon:Hide() end
				return
			end
			if not own.moon then
				own.moon = frame:CreateTexture(nil, "BORDER")
				own.moon:SetTexture(Theme.Media("white"))
				own.moon:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
				own.moon:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
				own.moon:SetHeight(1)
			end
			-- Colours come from Polestar's palette, so the player's own
			-- accent still wins.
			local r, g, b = Theme.Color("accent")
			own.moon:SetVertexColor(r, g, b, 0.55)
			own.moon:Show()
		end,
	},
}))
