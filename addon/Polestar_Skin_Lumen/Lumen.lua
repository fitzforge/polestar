-- Lumen: a head-up skin for Polestar through its Skin API
-- (docs/skins in the Polestar repository). The guide as part of the
-- game's own HUD: no border and no band, dark glass, a cool white ladder in
-- Fira Sans a size down, one cyan line along the top of every window and a
-- lit tick at each corner, just outside it, marking its extent; the flat
-- arrow and Halo's map icons. Its layout preset makes every window dark
-- glass with the ticks for its frame; a transparent guide window keeps the
-- ticks as marks of where the window is.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * a skin that is mostly a FRAME TREATMENT: its own pieces (lines and
--     ticks) built from Polestar's white texture, over the house ground;
--   * a `guide` painter beside `window`: the guide window keeps its corner
--     ticks while transparent (frame.psBare), where everything else goes;
--   * fontSizes for the whole ladder, a hard text shadow for text over the
--     world, and a preset that turns the house chrome off.
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
-- The palette: near-black cool grounds (the window ground translucent, so a
-- standard-style window is dark glass), a cool white ladder, a cool ink for
-- the hairlines, cyan for the accent, the subjects a touch brighter than
-- Polestar's so they hold over the world.
---------------------------------------------------------------------------

local TOKENS = {
	bg = "#070a10a6", panel = "#0b0f17f2", panelAlt = "#ffffff14", sidebar = "#05070c", footer = "#05070c", sky = "#070a10",
	text = "#f3f7fb", textDim = "#c6d2de", textMuted = "#92a3b4",
	ink = "#dfefff", star = "#ffffff00", shade = "#000000", scrim = "#04070c", onAccent = "#06111a", shadow = "#00000000",
	accent = "#6fe3ff",
	border = "#dfefff1a", divider = "#dfefff14", hover = "#dfefff12", selected = "#dfefff1f",
	success = "#5ee6a4", warning = "#ffc157", danger = "#ff7b7b", quest = "#ffd977", npc = "#8fd0ff", item = "#c9b1ff",
	place = "#f8b48c", object = "#d8cdb6", level = "#f5f9ff", skill = "#9fe87a", spell = "#7ee7f5", faction = "#f79fd0",
	area = "#ecc4a0", achievement = "#ffaa5c", dungeon = "#ad93ff", rare = "#ff8a62",
}

---------------------------------------------------------------------------
-- The HUD frame: a line along the top edge and a tick at each corner, 1
-- unit thick, in the accent (so the player's own accent colours them too),
-- the ticks OUT units outside the frame like a sight's corners, clear of
-- whatever sits on the frame's edge (a card's class bar).
---------------------------------------------------------------------------

local TICK, OUT = 10, 3

local CORNERS = { "TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT" }

local function white(frame, layer, sub)
	local t = frame:CreateTexture(nil, layer or "BORDER", nil, sub or 3)
	t:SetTexture(Theme.Media("white"))
	return t
end

local function hudFrame(frame, kit)
	local own = kit.store(frame)
	if not own.ticks then
		own.ticks = {}
		-- A texture anchored by its own corner to the frame's grows away
		-- from it, so the same two lines serve every corner.
		for _, corner in ipairs(CORNERS) do
			local dx = corner:find("LEFT") and -OUT or OUT
			local dy = corner:find("TOP") and OUT or -OUT
			local h = white(frame)
			h:SetPoint(corner, frame, corner, dx, dy)
			h:SetSize(TICK, 1)
			local v = white(frame)
			v:SetPoint(corner, frame, corner, dx, dy)
			v:SetSize(1, TICK)
			own.ticks[#own.ticks + 1] = h
			own.ticks[#own.ticks + 1] = v
		end
		own.line = white(frame, "BORDER", 2)
		own.line:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0)
		own.line:SetPoint("TOPRIGHT", frame, "TOPRIGHT", 0, 0)
		own.line:SetHeight(1)
	end
	return own
end

-- The light each corner tick throws: a small glow in the accent, light
-- only (kit.glow, kept in the frame's store with the ticks).
local function cornerGlows(frame, kit, r, g, b, alpha)
	for _, corner in ipairs(CORNERS) do
		local dx = corner:find("LEFT") and -OUT or OUT
		local dy = corner:find("TOP") and OUT or -OUT
		kit.glow(frame, { key = "tick" .. corner, point = corner, offset = { dx, dy }, size = 28, color = { r, g, b, alpha }, layer = "BORDER", sub = 2 })
	end
end

local function hideGlows(frame, kit)
	local own = kit.store(frame)
	for _, corner in ipairs(CORNERS) do
		local t = own["glow:tick" .. corner]
		if t then t:Hide() end
	end
end

-- Show the frame at `alpha` (the ticks at full, the top line a little less,
-- the corners' light softer still).
local function showHud(frame, kit, alpha)
	local own = hudFrame(frame, kit)
	local r, g, b = Theme.Accent()
	for i = 1, #own.ticks do
		own.ticks[i]:SetVertexColor(r, g, b, alpha)
		own.ticks[i]:Show()
	end
	own.line:SetVertexColor(r, g, b, alpha * 0.55)
	own.line:Show()
	cornerGlows(frame, kit, r, g, b, alpha * 0.3)
end

local function hideHud(frame, kit)
	local own = kit.store(frame)
	if not own.ticks then return end
	for i = 1, #own.ticks do own.ticks[i]:Hide() end
	own.line:Hide()
	hideGlows(frame, kit)
end

local PAINT = {
	-- Windows other than the guide: the house ground at the player's
	-- opacity (dark glass with the preset), the HUD frame over it. The
	-- house border and shadow follow the player's settings as they are.
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		showHud(frame, kit, 0.9)
	end,
	-- The guide window: the same, but while transparent the ticks stay as
	-- marks of the window's extent, with their light, and the line goes.
	guide = function(frame, base, kit)
		base(frame)
		if frame.psBare then
			kit.bare(frame)
			local own = hudFrame(frame, kit)
			local r, g, b = Theme.Accent()
			for i = 1, #own.ticks do
				own.ticks[i]:SetVertexColor(r, g, b, 0.65)
				own.ticks[i]:Show()
			end
			own.line:Hide()
			cornerGlows(frame, kit, r, g, b, 0.2)
			return
		end
		showHud(frame, kit, 0.9)
	end,
	-- Toasts carry the line alone.
	toast = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		local own = hudFrame(frame, kit)
		for i = 1, #own.ticks do own.ticks[i]:Hide() end
		hideGlows(frame, kit)
		local r, g, b = Theme.Accent()
		own.line:SetVertexColor(r, g, b, 0.6)
		own.line:Show()
	end,
	-- Menus and popups: the house panel without its border, the line on top.
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		kit.hideBorder(frame)
		local own = hudFrame(frame, kit)
		for i = 1, #own.ticks do own.ticks[i]:Hide() end
		local r, g, b = Theme.Accent()
		own.line:SetVertexColor(r, g, b, 0.5)
		own.line:Show()
	end,
	-- Wells: the faintest lift, no edge.
	inset = function(frame, base, kit)
		base(frame)
		kit.fill(frame):SetVertexColor(1, 1, 1, 0.04)
	end,
}

---------------------------------------------------------------------------
-- The head-up layout, offered on the Theme page where this Polestar has
-- presets (capability "preset"): every window dark glass, the ticks its
-- only frame, every control of the guide window kept.
---------------------------------------------------------------------------

local PRESET = {
	["ui.style"] = "standard", ["ui.bgOpacity"] = 0.78,
	["ui.band"] = false, ["ui.shadow"] = false, ["ui.border"] = false, -- the ticks are the frame
	-- Should the player take the guide window transparent: a soft shade
	-- and an outline under each line over the world.
	["ui.backing"] = "soft", ["guideWindow.outline"] = "outline",
	["guideWindow.progressHeight"] = 2, ["guideWindow.rules"] = false,
	["nav.arrowBacking"] = false, ["nav.arrowGlow"] = true,
	["nav.lineStyle"] = "line", ["nav.lineWidth"] = 3, ["nav.routeChevrons"] = true,
}

check("skin lumen", Theme.RegisterSkin("lumen", {
	api = 2,
	name = "Lumen",
	addon = ADDON,
	author = "Polestar",
	desc = "Head-up: dark glass, no border, a cyan line and lit corner ticks, Fira Sans a size down.",
	base = "polestar",
	tokens = TOKENS,
	font = "fira",
	-- One size down the whole ladder, nothing under 11.
	fontSizes = { hero = 22, display = 16, title = 14, heading = 12, body = 12, label = 11, note = 11, small = 11, number = 11,
		caption = 11, goal = 13, name = 14, mono = 11 },
	-- A hard shadow under every string: text over the world.
	textShadow = { 1, -1, 1 },
	arrow = "flat",
	mapIcons = "halo",
	paint = PAINT,
	preset = PRESET,
}))
