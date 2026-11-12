-- Umbra: a dark mode for Polestar through its Skin API (docs/skins in the
-- Polestar repository). Neutral charcoal with no blue in it, a cool grey
-- ladder, a muted steel accent, the subject colours a quarter of the way
-- toward grey so nothing glows, the band's stars dimmed, the haze off.
-- Every window sinks into a soft vignette, lit by a thin steel glow along
-- its edge, over a deep, wide shadow. Two kinds: Flat (Polestar's own
-- frames in charcoal) and the game's looks dimmed (WoW Forever, Blizzard or
-- Classic with their art darkened and drained of colour, the vignette over
-- it).
--
-- What this skin shows:
--   * a scheme and a skin from ONE table of colours: the scheme serves the
--     players who keep Polestar's skin, the skin adds the quieter subject
--     colours a scheme may not carry;
--   * `variants` that change the base look, and `artTint` darkening and
--     desaturating a game look's own art;
--   * painters adding depth with gradients on Polestar's white texture
--     (edge strips), and `shadow` for a deeper drop shadow.
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

local ACCENT = "#9fb4c7"

check("scheme umbra", Theme.RegisterScheme("umbra", {
	api = 2, name = "Umbra", addon = ADDON, author = "Polestar",
	desc = "Dark mode: neutral charcoal, a cool grey ladder, a steel accent.",
	tokens = {
		bg = "#141516f7", panel = "#1a1b1dfa", panelAlt = "#232426", sidebar = "#0f1011", footer = "#111213", sky = "#1c1d20",
		text = "#ececec", textDim = "#b8b9bc", textMuted = "#8d8f93",
		ink = "#ffffff", star = "#ffffff59", shade = "#000000", scrim = "#0a0a0b", onAccent = "#141516", shadow = "#000000a6",
	},
	accent = ACCENT,
	washes = { border = 0.1, divider = 0.1, selected = 0.12, hover = 0.07 },
}))

-- Polestar's subjects, each a quarter of the way to grey.
local SUBJECTS = {
	success = "#86cf9f", warning = "#e6b86b", danger = "#e08484", quest = "#e8cf8a", npc = "#9fc3e8", item = "#c3b3e6",
	place = "#e2ad8d", object = "#d2c7b2", level = "#eef0f4", skill = "#a8d089", spell = "#8ed0dc", faction = "#e3a6c6",
	area = "#dcbda4", achievement = "#e6a872", dungeon = "#ab98e6", rare = "#e6916f",
}
local FLAT = { accent = ACCENT, haze = "#00000000", glow = ACCENT }
for k, v in pairs(SUBJECTS) do FLAT[k] = v end

---------------------------------------------------------------------------
-- The depth: every window sinks into a soft vignette (its edges shaded
-- toward black, the middle left clear), lit by a thin steel glow along its
-- edge and from the middle of its top, and stands on a deep, wide shadow
-- (spec.shadow). On the game's
-- looks the vignette alone, over their dimmed art.
---------------------------------------------------------------------------

local WHITE = Theme.Media("white")
local SIDES = {
	-- its two corners, which way it is thick, its gradient's orientation,
	-- and whether the edge is the gradient's min end (bottom or left)
	top = { "TOPLEFT", "TOPRIGHT", "h", "VERTICAL", false },
	bottom = { "BOTTOMLEFT", "BOTTOMRIGHT", "h", "VERTICAL", true },
	left = { "TOPLEFT", "BOTTOMLEFT", "w", "HORIZONTAL", true },
	right = { "TOPRIGHT", "BOTTOMRIGHT", "w", "HORIZONTAL", false },
}

-- Four strips along the frame's edges, `size` deep, each running from `a`
-- at the edge to nothing inward, in colour r, g, b; kept under `key`.
local function edges(frame, kit, key, size, r, g, b, a, layer, sub)
	local own = kit.store(frame)
	own[key] = own[key] or {}
	local set = own[key]
	for side, d in pairs(SIDES) do
		local t = set[side]
		if not t then
			t = frame:CreateTexture(nil, layer, nil, sub)
			t:SetTexture(WHITE)
			set[side] = t
		end
		t:ClearAllPoints()
		t:SetPoint(d[1], frame, d[1], 0, 0)
		t:SetPoint(d[2], frame, d[2], 0, 0)
		if d[3] == "h" then t:SetHeight(size) else t:SetWidth(size) end
		local on, off = CreateColor(r, g, b, a), CreateColor(r, g, b, 0)
		if d[5] then t:SetGradient(d[4], on, off) else t:SetGradient(d[4], off, on) end
		t:Show()
	end
end

local function flat()
	return (Theme.SkinVariant and Theme.SkinVariant("umbra") or "flat") == "flat"
end

local function deep(vignette)
	return function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		if not CreateColor then return end
		local w, h = frame:GetWidth() or 300, frame:GetHeight() or 200
		-- The vignette: a quarter of the shorter side, black at the edge.
		edges(frame, kit, "vignette", math.max(20, math.min(72, math.min(w, h) * 0.25)), 0, 0, 0, vignette, "BACKGROUND", -2)
		local own = kit.store(frame)
		if flat() then
			-- The glow: a steel line on the edge, its light ten units in, and a
			-- cold light falling from the top edge's middle.
			local r, g, b = Theme.Accent()
			edges(frame, kit, "glow", 10, r, g, b, 0.26, "BORDER", 1)
			edges(frame, kit, "edge", 1, r, g, b, 0.75, "BORDER", 2)
			local top = kit.glow(frame, { key = "top", color = { r, g, b, 0.22 }, layer = "BACKGROUND", sub = -1 })
			top:ClearAllPoints()
			top:SetPoint("TOP", frame, "TOP", 0, 0)
			top:SetSize(math.min(w, 260), 54)
			top:SetTexCoord(0, 1, 0.5, 1)
		else
			for _, k in ipairs({ "glow", "edge" }) do
				for _, t in pairs(own[k] or {}) do t:Hide() end
			end
			if own["glow:top"] then own["glow:top"]:Hide() end
		end
	end
end

local PAINT = { window = deep(0.75), panel = deep(0.55), toast = deep(0.6) }

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

-- Cards and toasts: their parts cover the frame's own vignette, so the steel
-- edge and the cold light from the top go over them (light only: nothing
-- darkens their text).
local function lit(frame)
	if not (flat() and CreateColor) then
		local own = Theme.SkinKit.store(frame)
		if own.overlay then own.overlay:Hide() end
		return
	end
	local o = overlay(frame)
	local kit = Theme.SkinKit
	local r, g, b = Theme.Accent()
	edges(o, kit, "glow", 8, r, g, b, 0.22, "OVERLAY", 1)
	edges(o, kit, "edge", 1, r, g, b, 0.8, "OVERLAY", 2)
	local top = kit.glow(o, { key = "top", color = { r, g, b, 0.2 }, layer = "OVERLAY", sub = 0 })
	top:ClearAllPoints()
	top:SetPoint("TOP", o, "TOP", 0, 0)
	top:SetSize(math.min(frame:GetWidth() or 200, 220), 40)
	top:SetTexCoord(0, 1, 0.5, 1)
end
local HOOKS = {}
if hasHooks("card", "toast") then
	HOOKS.card = function(frame) lit(frame) end
	HOOKS.toast = function(frame) lit(frame) end
end

-- The game's looks dimmed: their metal, stone and parchment at 55 % and
-- mostly grey, their own colours kept for text.
local DIM = { tint = { 0.82, 0.84, 0.88, 1 }, brightness = -0.45, desaturate = 0.85 }

check("skin umbra", Theme.RegisterSkin("umbra", {
	api = 2,
	name = "Umbra",
	addon = ADDON,
	author = "Polestar",
	desc = "Dark mode: charcoal and muted colours, on Polestar's frames or on the game's own art, dimmed.",
	base = "polestar",
	scheme = "umbra",
	tokens = FLAT,
	arrow = "3d",
	mapIcons = "polestar",
	paint = PAINT,
	hooks = HOOKS,
	-- Deep and wide: the windows sit well above the world.
	shadow = { size = 46, drop = 12, alpha = 0.9 },
	variants = {
		{ id = "flat", name = "Flat", desc = "Polestar's own frames in charcoal." },
		{ id = "forever", name = "WoW Forever, dimmed", desc = "The WoW Forever look with its art darkened and greyed.", base = "forever", artTint = DIM },
		{ id = "blizzard", name = "Blizzard, dimmed", desc = "The Blizzard look with its art darkened and greyed.", base = "blizzard", artTint = DIM },
		{ id = "classic", name = "Classic, dimmed", desc = "The Classic look with its art darkened and greyed.", base = "classic", artTint = DIM },
	},
	defaultVariant = "flat",
	preset = {
		["ui.style"] = "standard", ["ui.band"] = false, ["ui.haze"] = false, ["ui.rim"] = false,
		["ui.shadow"] = true, ["ui.shadowStrength"] = 1.3, ["ui.textShadow"] = "soft",
	},
}))
