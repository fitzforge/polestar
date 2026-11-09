-- Lumen: a head-up skin for Polestar through its Skin API
-- (docs/SKINS-API.md in the Polestar repository). The guide as part of the
-- game's own HUD: no frame and no band, a cool white ladder in Fira Sans a
-- size down, one cyan line along the top of every window and a short tick
-- at each corner marking its extent, the flat arrow and Halo's map icons.
-- Its layout preset puts the guide window into transparent mode, compact,
-- with the ticks staying as faint marks of where the window is.
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
if not (Theme and Theme.RegisterSkin and Theme.API_VERSION and Theme.API_VERSION >= 1) then return end

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
-- unit thick, in the accent (so the player's own accent colours them too).
---------------------------------------------------------------------------

local TICK = 10

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
			local h = white(frame)
			h:SetPoint(corner, frame, corner, 0, 0)
			h:SetSize(TICK, 1)
			local v = white(frame)
			v:SetPoint(corner, frame, corner, 0, 0)
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

-- Show the frame at `alpha` (the ticks at full, the top line a little less).
local function showHud(frame, kit, alpha)
	local own = hudFrame(frame, kit)
	local r, g, b = Theme.Accent()
	for i = 1, #own.ticks do
		own.ticks[i]:SetVertexColor(r, g, b, alpha)
		own.ticks[i]:Show()
	end
	own.line:SetVertexColor(r, g, b, alpha * 0.55)
	own.line:Show()
end

local function hideHud(frame, kit)
	local own = kit.store(frame)
	if not own.ticks then return end
	for i = 1, #own.ticks do own.ticks[i]:Hide() end
	own.line:Hide()
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
	-- faint marks of the window's extent and the line goes.
	guide = function(frame, base, kit)
		base(frame)
		if frame.psBare then
			kit.bare(frame)
			local own = hudFrame(frame, kit)
			local r, g, b = Theme.Accent()
			for i = 1, #own.ticks do
				own.ticks[i]:SetVertexColor(r, g, b, 0.4)
				own.ticks[i]:Show()
			end
			own.line:Hide()
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
-- presets (capability "preset").
---------------------------------------------------------------------------

local PRESET = {
	["ui.style"] = "transparent", ["ui.backing"] = "soft", ["ui.compact"] = true,
	["ui.bgOpacity"] = 0.8,                           -- the other windows: dark glass
	["ui.band"] = false, ["ui.shadow"] = false, ["ui.border"] = false, -- the ticks are the frame
	["guideWindow.outline"] = "outline", ["guideWindow.progressHeight"] = 2, ["guideWindow.rules"] = false,
	["nav.arrowBacking"] = false, ["nav.arrowGlow"] = true,
	["nav.lineStyle"] = "line", ["nav.lineWidth"] = 3, ["nav.routeChevrons"] = true,
}

local spec = {
	api = 1,
	name = "Lumen",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = "Head-up: no frame, a cyan line and corner ticks, compact Fira Sans over the world.",
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
}
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin lumen", Theme.RegisterSkin("lumen", spec))
