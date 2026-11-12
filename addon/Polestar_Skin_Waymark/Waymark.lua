-- Waymark: the land you're levelling in, through Polestar's Skin API
-- (docs/skins in the Polestar repository). Every window is a dark chart:
-- the skin's own map paper with a faint graticule, ruled in brass, a
-- compass rose in its corner, the step bar underlined by a dashed route,
-- the arrow a compass needle and the map marks brass-ringed discs. The
-- guide window's header and
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
--     arrow's glow;
--   * a tiled texture of the skin's own, `media.dart` / `dartEdge` /
--     `medallion`, and the `guideTitle` hook drawing over a part (the rule).
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
-- Forever's screens are 16:9 with clear bands above and below the picture
-- (rows 266-1417 of 1684): cropped to the picture, 2.6 wide to 1 high. The
-- older ones fill their square texture and show at 4:3 (the kit's default).
local FOREVER = { coords = { 0, 1, 0.165, 0.835 }, aspect = 2.6 }
local function forever(name) return { path = SCREENS .. "Camelot160\\Main\\LoadScreen_Camelot_" .. name, coords = FOREVER.coords, aspect = FOREVER.aspect } end
local function older(name) return { path = SCREENS .. "LoadScreen" .. name } end
local REGIONS = {
	{ keys = { ["Eastern Kingdoms"] = true, [1415] = true }, accent = "#9bb35a", art = { forever("EasternKingdom"), older("EasternKingdom") } },
	{ keys = { ["Kalimdor"] = true, [1414] = true }, accent = "#d9a441", art = { forever("Kalimdor"), older("Kalimdor") } },
}
local ELSEWHERE = { accent = "#e6ba66" }

-- The first picture of a region the client has (GetFileIDFromPath answers
-- nil for a path it does not know); the last one where it cannot tell.
local function pictureOf(r)
	if not r.art then return nil end
	if r.picture == nil then
		r.picture = r.art[#r.art]
		if GetFileIDFromPath then
			for _, p in ipairs(r.art) do
				if GetFileIDFromPath(p.path) then
					r.picture = p
					break
				end
			end
		end
	end
	return r.picture
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
-- Grounds: an old chart gone dark, warm umber the art can sit on in any
-- region, ruled in brass; the text ladder a warm white. The regional colour
-- comes from resolve.
---------------------------------------------------------------------------

local TOKENS = {
	bg = "#15110cf5", panel = "#1a150ffa", panelAlt = "#251e15", sidebar = "#0f0c08", footer = "#110e0a", sky = "#1c1711",
	text = "#f5f0e5", textDim = "#d1c7b3", textMuted = "#a59a83",
	ink = "#f5f0e5", star = "#ffffff80", shade = "#000000", scrim = "#080604", onAccent = "#15110c", shadow = "#000000b3",
	border = "#c9a66a47", windowBorder = "#c9a66a66", divider = "#c9a66a26", separator = "#c9a66a26", rowLine = "#c9a66a17",
	accent = ELSEWHERE.accent,
}

local function rgb(hex)
	return tonumber(hex:sub(2, 3), 16) / 255, tonumber(hex:sub(4, 5), 16) / 255, tonumber(hex:sub(6, 7), 16) / 255
end

---------------------------------------------------------------------------
-- The picture: behind the head of a window (over the band's sky and its
-- stars, Theme.Band's BACKGROUND -5 and -4, under everything else) and down
-- the settings' sidebar, tinted a little toward the region and faded into
-- the ground below it. Held under Polestar's art ceiling (alpha 0.35), so
-- the text over it keeps its contrast.
---------------------------------------------------------------------------

local function artOn(frame, kit, height, alpha)
	local own = kit.store(frame)
	local pic = pictureOf(current)
	if not pic or not Theme.ShowsBand() then
		if own.art then own.art:Hide() end
		return
	end
	local file = pic.path
	-- Half the colour drained and the rest pulled toward the region's, the
	-- sky and the skyline in view (focus a third of the way down).
	local ar, ag, ab = rgb(current.accent)
	local opts = { file = own.artFile or file, coords = pic.coords, aspect = pic.aspect, height = height, crop = "cover",
		focus = 0.32, desaturate = 0.5, tint = { 0.6 + ar * 0.4, 0.6 + ag * 0.4, 0.6 + ab * 0.4, 1 }, alpha = alpha,
		fade = "bottom", layer = "BACKGROUND", sub = -3, key = "waymark" }
	own.art = kit.gameArt(frame, opts)
	if own.artFile ~= file then
		if own.artFile then kit.crossfade(own.art, file, 0.6) end
		own.artFile = file
	end
end

---------------------------------------------------------------------------
-- The chart: the skin's own map paper (Media/paper: grain and a faint
-- graticule) tiled over every window's ground in a warm sepia, a compass
-- rose (Media/compass) in the window's top right corner in the region's
-- colour, and the rule under the step bar drawn as a dashed route
-- (Media/dash). All the skin's own art.
---------------------------------------------------------------------------

local MEDIA = "Interface\\AddOns\\" .. ADDON .. "\\Media\\"

local function chart(frame, kit, roseSize)
	local own = kit.store(frame)
	local paper = own.paper
	if not paper then
		paper = frame:CreateTexture(nil, "BACKGROUND", nil, -6)
		paper:SetTexture(MEDIA .. "paper", "REPEAT", "REPEAT")
		paper:SetHorizTile(true)
		paper:SetVertTile(true)
		paper:SetAllPoints(frame)
		own.paper = paper
	end
	paper:SetVertexColor(0.62, 0.5, 0.34, 0.14)
	paper:Show()
	if roseSize then
		local rose = own.rose
		if not rose then
			rose = frame:CreateTexture(nil, "BACKGROUND", nil, -2)
			rose:SetTexture(MEDIA .. "compass")
			own.rose = rose
		end
		rose:ClearAllPoints()
		rose:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -6, -6)
		rose:SetSize(roseSize, roseSize)
		local r, g, b = rgb(current.accent)
		rose:SetVertexColor(r, g, b, 0.38)
		rose:Show()
	elseif own.rose then
		own.rose:Hide()
	end
end

-- The neatline: a map's inner border, a brass rule three units inside the
-- frame's edge (the edge itself is the window border, brass too).
local function neatline(on, own, alpha)
	local r, g, b = Theme.Color("windowBorder")
	local lines = own.neat
	if not lines then
		lines = {}
		for i = 1, 4 do
			local t = on:CreateTexture(nil, "OVERLAY")
			t:SetTexture(Theme.Media("white"))
			lines[i] = t
		end
		own.neat = lines
	end
	local I = 3
	local spec = {
		{ "TOPLEFT", I, -I, "TOPRIGHT", -I, -I, "h" }, { "BOTTOMLEFT", I, I, "BOTTOMRIGHT", -I, I, "h" },
		{ "TOPLEFT", I, -I, "BOTTOMLEFT", I, I, "w" }, { "TOPRIGHT", -I, -I, "BOTTOMRIGHT", -I, I, "w" },
	}
	for i, d in ipairs(spec) do
		local t = lines[i]
		t:ClearAllPoints()
		t:SetPoint(d[1], on, d[1], d[2], d[3])
		t:SetPoint(d[4], on, d[4], d[5], d[6])
		if d[7] == "h" then t:SetHeight(1) else t:SetWidth(1) end
		t:SetVertexColor(r, g, b, alpha)
		t:Show()
	end
end

-- The picture goes behind the head of the guide window, the settings and
-- the other windows; never behind a toast (a small card over the world:
-- the picture would sit under its text), which keeps the paper only. A
-- heads-up card (drawn as the guide window, psGuide, and docked on it)
-- leaves the corner rose to its card hook's small one at the foot, clear of
-- its badge and close box.
local PAINT = {
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		if frame.psLight then
			chart(frame, kit, nil)
			local own = kit.store(frame)
			if own.art then own.art:Hide() end
			return
		end
		local card = frame.psGuide and frame:GetName() ~= "PolestarGuideFrame"
		chart(frame, kit, not card and 70 or nil)
		neatline(frame, kit.store(frame), 0.55)
		artOn(frame, kit, 128, 0.35)
	end,
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		chart(frame, kit, nil)
	end,
	sidebar = function(frame, base, kit)
		base(frame)
		chart(frame, kit, nil)
		artOn(frame, kit, 220, 0.24)
	end,
}

-- A frame of the skin's own over a card or a toast, above its parts (their
-- grounds would hide what the skin draws on the frame itself), never taking
-- the mouse; kept in the frame's store so another skin hides it.
local function overlay(frame)
	local kit = Theme.SkinKit
	local own = kit.store(frame)
	local o = own.overlay
	if not o then
		o = CreateFrame("Frame", nil, frame)
		o:SetAllPoints(frame)
		if o.EnableMouse then o:EnableMouse(false) end
		own.overlay = o
	end
	o:SetFrameLevel((frame:GetFrameLevel() or 0) + 20)
	o:Show()
	return o, kit.store(o)
end

local function hasHooks(...)
	if not Theme.HasCapability then return false end
	for i = 1, select("#", ...) do
		if not Theme.HasCapability("surfaces." .. select(i, ...)) then return false end
	end
	return true
end

-- Cards and toasts: their parts cover the frame's own chart, so the
-- neatline and a small compass rose in the bottom right corner go over
-- them.
local function charted(frame)
	local o, own = overlay(frame)
	neatline(o, own, 0.7)
	local rose = own.rose
	if not rose then
		rose = o:CreateTexture(nil, "OVERLAY")
		rose:SetTexture(MEDIA .. "compass")
		own.rose = rose
	end
	rose:ClearAllPoints()
	rose:SetPoint("BOTTOMRIGHT", o, "BOTTOMRIGHT", -6, 6)
	rose:SetSize(26, 26)
	local r, g, b = rgb(current.accent)
	rose:SetVertexColor(r, g, b, 0.5)
	rose:Show()
end

local HOOKS = {
	-- The rule under the step bar as a dashed route in the region's colour.
	guideTitle = function(nav, parts)
		local rule, kit = parts.rule, Theme.SkinKit
		if not (rule and kit and kit.store) then return end
		local own = kit.store(nav)
		local route = own.route
		if not route then
			route = nav:CreateTexture(nil, "ARTWORK")
			route:SetTexture(MEDIA .. "dash", "REPEAT", "CLAMP")
			route:SetHorizTile(true)
			own.route = route
		end
		route:ClearAllPoints()
		route:SetPoint("LEFT", rule, "LEFT", 0, 0)
		route:SetPoint("RIGHT", rule, "RIGHT", 0, 0)
		route:SetHeight(2)
		local r, g, b = rgb(current.accent)
		route:SetVertexColor(r, g, b, 0.75)
		-- Where Polestar shows the rule, the route stands in for it (the part
		-- comes back in Polestar's state for the next skin).
		route:SetShown(rule:IsShown())
		rule:Hide()
	end,
}

local PRESET = {
	["ui.band"] = true, ["ui.haze"] = true, ["ui.starAlpha"] = 0.5, ["ui.shadow"] = true,
	["nav.lineStyle"] = "dots",
}

if hasHooks("card", "toast") then
	HOOKS.card = function(frame) charted(frame) end
	HOOKS.toast = function(frame) charted(frame) end
end

check("skin waymark", Theme.RegisterSkin("waymark", {
	api = 2,
	name = "Waymark",
	addon = ADDON,
	author = "Polestar",
	desc = "The land you're levelling in: a dark chart with a compass rose and a dashed route, the continent's loading screen behind the header, its colour on the accent, a compass-needle arrow.",
	base = "polestar",
	tokens = TOKENS,
	-- The arrow as a compass needle, the map marks in brass-ringed chart
	-- discs: the skin's own art on the skins' dart style.
	arrow = "halo",
	media = { dart = MEDIA .. "needle", dartEdge = MEDIA .. "needle-edge", medallion = MEDIA .. "medallion" },
	mapIcons = "polestar",
	paint = PAINT,
	hooks = HOOKS,
	preset = PRESET,
	-- The continent's colour on the accent (under the player's own), the
	-- band's haze, the arrow's glow and the pins' rims.
	resolve = function(ctx)
		current = regionFor(ctx)
		local a = current.accent
		return { accent = a, pinRing = a, glow = a, haze = a .. "40" }
	end,
}))
