-- Moonlit: an example of a Polestar skin in an addon of its own, through
-- Polestar's Skin API (docs/skins in the Polestar repository). It adds two
-- things a player picks under Polestar's settings, Look > Theme:
--   * the colour scheme "Moonlit": cool indigo grounds under a silver text
--     ladder, usable with Polestar's own skin;
--   * the skin "Moonlit": Polestar's own look in that scheme, set in Fira
--     Sans, in two variants (a full moon in silver, a new moon in blue),
--     with a line of moonlight on every surface a skin can reach: the
--     windows, the guide window, the arrow, the map pins, the cards on the
--     guide window, the toasts and the buttons Polestar puts on the screen.
-- Nothing here touches Polestar's own files. Copy this folder, rename it and
-- its .toc (keep the X-Polestar-Skin line, with your own ids), and change
-- the ids, names and colours to make your own skin.
-- This example is CC0-1.0 (public domain; LICENSE in this folder): copy any
-- of it into your own skin without conditions.

local ADDON = ...

-- Polestar loads first (## Dependencies: Polestar in the .toc). This file
-- is written for Skin API 2 (Polestar 0.3.8 and later): on an older
-- Polestar, without the API or its hooks, it does nothing.
local Theme = Polestar and Polestar.Theme
if not (Theme and Theme.RegisterSkin and (Theme.API_VERSION or 0) >= 2) then return end
local kit = Theme.SkinKit

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
	api = 2, -- the Skin API version this was written for
	name = "Moonlit", -- shown in the picker as it is (yours to translate)
	addon = ADDON, -- shown beside the name
	author = "Polestar",
	version = "2.0",
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

-- A line of moonlight one pixel high along the top of `frame` (or its
-- bottom), kept in this skin's own store on that frame: kit.store(frame).
-- Polestar hides what is in the store when another skin takes over, and the
-- hooks below show it again each time they run. `token` names the colour
-- (the player's own accent wins over the scheme's moonlight).
local function moonline(frame, key, token, alpha, bottom)
	local own = kit.store(frame)
	local t = own[key]
	if not t then
		t = frame:CreateTexture(nil, "OVERLAY", nil, 7)
		t:SetTexture(Theme.Media("white"))
		own[key] = t
	end
	local edge = bottom and "BOTTOM" or "TOP"
	t:ClearAllPoints()
	t:SetPoint(edge .. "LEFT", frame, edge .. "LEFT", 0, 0)
	t:SetPoint(edge .. "RIGHT", frame, edge .. "RIGHT", 0, 0)
	t:SetHeight(Theme.Pixel(frame))
	local r, g, b = Theme.Color(token or "accent")
	t:SetVertexColor(r, g, b, alpha or 0.55)
	t:Show()
	return t
end

-- The skin: Polestar's own look (base = "polestar") in the scheme above. A
-- skin may also extend "halo", "hearth" or the game's looks ("forever",
-- "blizzard", "classic"); then it gives tokens over that look's palette
-- instead of a scheme.
check("skin moonlit", Theme.RegisterSkin("moonlit", {
	api = 2,
	name = "Moonlit",
	addon = ADDON,
	author = "Polestar",
	version = "2.0",
	desc = "Polestar in moonlight: Moonlit's colours, Fira Sans, a line of moonlight on every window, card and button.",
	base = "polestar",
	scheme = "moonlit",
	-- Tokens over the scheme: the second accent (the arrow's moonlight), the
	-- arrow's glow, and the pins' rim and fill (where the player has not set
	-- a colour of their own).
	tokens = { accent2 = "#d8e0ff", glow = "#c8d4ff", pinRing = "#dfe4f7", pinFill = "#8fa3ff" },
	-- One design in two versions: the player picks under the skin's card.
	-- A variant changes what it names (tokens over the skin's, base,
	-- scheme, media, arrow, preset, artTint, shadow) and keeps the rest.
	variants = {
		{ id = "full", name = "Full moon", desc = "Silver moonlight." },
		{ id = "new", name = "New moon", desc = "A darker night, the moonlight blue.",
			tokens = { accent2 = "#7f9cff", glow = "#6f8dff", pinRing = "#9fb4ff" } },
	},
	defaultVariant = "full",
	-- The face every Polestar string takes while the player keeps the font
	-- on "The skin's font": "game", "inter", "fira", "opensans", or your own
	-- files: { regular = "Interface\\AddOns\\<you>\\Fonts\\X.ttf", ... }.
	font = "fira",
	fontSizes = { hero = 24 },
	-- A softer, wider drop shadow under the windows than the house's.
	shadow = { size = 18, alpha = 0.5 },
	-- The arrow and the map icons a player on "Skin" gets.
	arrow = "halo",
	mapIcons = "halo",
	-- Painters: one per kind of frame Polestar skins. Each gets the frame,
	-- `base` (the look this skin extends, for that kind) and `kit` (fills,
	-- borders and a store for your own textures). An error here turns this
	-- skin off for the session and Polestar's own look stands in, so a
	-- mistake never breaks the UI.
	paint = {
		window = function(frame, base, k)
			base(frame)
			-- A transparent window (frame.psBare) shows no ground at all.
			if frame.psBare then
				local own = k.store(frame)
				if own.moon then own.moon:Hide() end
				return
			end
			moonline(frame, "moon")
		end,
	},
	-- Hooks: each surface's own art, handed over after Polestar painted it.
	-- They run under the same guard as the painters.
	hooks = {
		-- The arrow: its frame, its style ("3d", "flat", "halo", "hearth")
		-- and its parts (dial, body, glow, dart, dartEdge, ring, halo,
		-- distance, label, eta, timer, travel). Moonlight behind the dial.
		arrow = function(frame, style, parts)
			kit.glow(parts.dial, { key = "moon", size = 110, color = "accent2", layer = "BACKGROUND", sub = -8 })
		end,
		-- A pin on the world map or the minimap: "mark" (a map mark on its
		-- medallion) or "pin" (the Polestar pin, an icon pin, a numbered step
		-- pin). The numbered pins' digits get a moonlit shadow.
		pin = function(pin, parts, kind)
			if kind == "pin" and parts.text:IsShown() then
				parts.text:SetShadowColor(0.05, 0.06, 0.16, 0.9)
				parts.text:SetShadowOffset(1, -1)
			end
		end,
		-- The guide window's step bar: its title parts (bar, close, rule,
		-- band, menuRight). A line of moonlight over it.
		guideTitle = function(nav, parts)
			moonline(nav, "moon")
		end,
		-- A goal row, once painted; info says whether it is the current goal,
		-- done or skipped. The current one gets a moonlit bar on its left.
		guideRow = function(row, goal, info)
			local own = kit.store(row)
			local bar = own.bar
			if not bar then
				bar = row:CreateTexture(nil, "ARTWORK")
				bar:SetTexture(Theme.Media("white"))
				bar:SetPoint("TOPLEFT", row, "TOPLEFT", 0, -2)
				bar:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", 0, 2)
				bar:SetWidth(2)
				own.bar = bar
			end
			bar:SetVertexColor(Theme.Color("accent2"))
			bar:SetShown(info.current and not info.done)
		end,
		-- The window's layout: room of the skin's own under the window's
		-- parts, from `y` down the body; the answer is the height it takes.
		guideLayout = function(parts, width, y)
			local rule = moonline(parts.body, "rule", "accent2", 0.4)
			rule:ClearAllPoints()
			rule:SetPoint("TOPLEFT", parts.body, "TOPLEFT", 12, -(y + 3))
			rule:SetWidth(math.max(1, width - 24))
			return 6
		end,
		-- Every render: the step on screen (nil when the window shows no
		-- step). The rule above only under a step.
		guideRender = function(view, parts)
			local own = kit.store(parts.body)
			if own.rule then own.rule:SetShown(view ~= nil) end
		end,
		-- The progress (the window's foot) and how much of the guide is done.
		-- A moonlit line as long as the part done.
		guideProgress = function(foot, frac)
			local line = moonline(foot, "done", "accent2", 0.8, true)
			line:ClearAllPoints()
			line:SetPoint("BOTTOMLEFT", foot, "BOTTOMLEFT", 0, 0)
			line:SetWidth(math.max(1, (foot:GetWidth() or 0) * frac))
		end,
		-- The frame the heads-up card sits on: nil keeps the window's own
		-- edge (a skin that draws its own cards above the window gives their
		-- frame, so the card sits on them).
		guideAnchor = function()
			return nil
		end,
		-- Each tab of the window's strip, after Polestar painted it; parts:
		-- selected (the active tab's wash), bar (its line), label, range,
		-- icon, close. A moonlit line along the top of the tab in view.
		guideTab = function(button, parts, active)
			moonline(button, "moon", "accent2", 0.7):SetShown(active)
		end,
		-- A part of the window about to be placed ("tip", "banner", "here",
		-- "after", "along", "upnext", "party", "xp"), laid out and shown:
		-- true takes it out of the window for the skin to place (a card of
		-- its own above the window). Moonlit keeps every part where it is.
		guidePlace = function(name, frame, width, height)
			return false
		end,
		-- The window's menu, made anew at each opening: entries may be
		-- added, removed or reordered. Moonlit names itself at the end.
		guideMenu = function(items, button)
			items[#items + 1] = { separator = true }
			items[#items + 1] = { text = "Moonlit", icon = "star", disabled = true }
		end,
		-- The cards on the guide window: "headsup" (a class quest or dungeon
		-- heads-up) and "classcard" (the class quest card in the window);
		-- parts: titles, bodies (the strings Polestar sizes), accents.
		card = function(card, kind, parts)
			moonline(card, "moon", "accent2", 0.7)
		end,
		-- The toasts: "rare", "transport", "whilehere"; parts as the cards'.
		toast = function(toast, kind, parts)
			moonline(toast, "moon")
		end,
		-- The buttons Polestar puts on the screen: "item", "hearth",
		-- "target", "rare", "bag" (the action buttons), "targetRow" and
		-- "targetMark" (the target list's rows and its Polestar mark),
		-- "travel" (the arrow's travel button), "launcher" (the floating
		-- button); parts:
		-- ground, icon, highlight (and cooldown, count, hotkey, label,
		-- badge, glow where it has them); hover: the mouse is on it.
		actionButton = function(button, kind, parts, hover)
			moonline(button, "moon", hover and "accent" or "accent2", hover and 1 or 0.45, true)
		end,
	},
}))
