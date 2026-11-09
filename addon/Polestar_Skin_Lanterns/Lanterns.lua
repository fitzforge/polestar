-- Lanterns: a pack of mood colours for Polestar through its Skin API
-- (docs/SKINS-API.md in the Polestar repository). Ten moods, each a pair
-- of colours: the first tints every ground a little toward it and is the
-- accent, the second answers it from the far corner. The skin hangs two
-- soft lights in opposite corners of every window in the mood's pair (the
-- "lanterns"); the moods themselves are colour schemes, so a player can
-- wear one with Polestar's own skin too, and the Lanterns skin wears
-- whichever scheme the player picks: a mood's pair where it knows the
-- scheme, the accent alone elsewhere.
--
-- What this example shows, beyond Moonlit (addon/Polestar_Skin_Example):
--   * MANY schemes from one addon, computed from a short table (a pair of
--     colours and a name each) rather than written out;
--   * a skin WITHOUT a scheme of its own: it wears the player's, and reads
--     the accent in use through Theme.Accent() to know which mood it is;
--   * radial lights from Polestar's own glow texture with ADD blending,
--     the one piece of art every mood shares.
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
-- The moods: id, name, the first colour (accent, tint), the second (the
-- far lantern; nil for a mood with no lights), a line for the picker.
---------------------------------------------------------------------------

local MOODS = {
	{ "forge", "Lanterns: Forge", "#ff8a3d", "#ffd36b", "Ember and gold: a warm forge glow." },
	{ "tidepool", "Lanterns: Tidepool", "#3fc8c0", "#4f86ff", "Teal and blue: deep, still water." },
	{ "glade", "Lanterns: Glade", "#6fd36a", "#cfe85a", "Leaf and lime: light through a canopy." },
	{ "hoarfrost", "Lanterns: Hoarfrost", "#8fd6ff", "#ffffff", "Ice and white: a clear winter morning." },
	{ "duskrose", "Lanterns: Dusk Rose", "#ff7aa8", "#8a4fd6", "Rose and plum: the last of the sunset." },
	{ "starfall", "Lanterns: Starfall", "#ffd36b", "#5b6cff", "Gold and indigo: a meteor over the sea." },
	{ "ashen", "Lanterns: Ashen", "#b8b2aa", "#6f6a66", "Warm greys: embers gone cold." },
	{ "highsun", "Lanterns: Highsun", "#ffd93d", "#ff8c3d", "Yellow and orange: noon in the Barrens." },
	{ "gloam", "Lanterns: Gloam", "#9b6cff", "#3fc8c0", "Violet and teal: the hour after dusk." },
	{ "plain", "Lanterns: Plain", "#d9d9e0", nil, "Neutral, no lights: just the grounds." },
}

-- "#rrggbb" -> r, g, b in 0-1.
local function rgb(hex)
	return tonumber(hex:sub(2, 3), 16) / 255, tonumber(hex:sub(4, 5), 16) / 255, tonumber(hex:sub(6, 7), 16) / 255
end

-- `base` moved `k` of the way toward `toward`, as a colour table.
local function tint(base, toward, k, alpha)
	local r, g, b = rgb(base)
	local tr, tg, tb = rgb(toward)
	return { r + (tr - r) * k, g + (tg - g) * k, b + (tb - b) * k, alpha or 1 }
end

-- The lantern pair by the accent in use (the first colour, within a hair),
-- so the skin knows its mood through the one value the API gives it.
local function pairFor(r, g, b)
	for _, m in ipairs(MOODS) do
		local ar, ag, ab = rgb(m[3])
		if math.abs(ar - r) < 0.02 and math.abs(ag - g) < 0.02 and math.abs(ab - b) < 0.02 then
			return m[3], m[4]
		end
	end
	return nil
end

for _, m in ipairs(MOODS) do
	local a = m[3]
	check("scheme lantern-" .. m[1], Theme.RegisterScheme("lantern-" .. m[1], {
		api = 1, name = m[2], addon = ADDON, author = "Polestar", version = "1.0", desc = m[5],
		tokens = {
			bg = tint("#0b0c12", a, 0.1, 0.97), panel = tint("#10121a", a, 0.1, 0.98), panelAlt = tint("#161925", a, 0.1),
			sidebar = tint("#07080c", a, 0.08), footer = tint("#090a10", a, 0.08), sky = tint("#141626", a, 0.16),
			text = tint("#f6f6fa", a, 0.04), textDim = tint("#c4c6d4", a, 0.06), textMuted = tint("#979aac", a, 0.08),
			ink = tint("#ffffff", a, 0.15), star = tint("#ffffff", a, 0.3), shade = "#000004", scrim = tint("#04050a", a, 0.1),
			onAccent = "#0b0c12", shadow = "#00000499",
		},
		accent = a,
	}))
end

---------------------------------------------------------------------------
-- The lights: two soft radial glows, the first colour at the top left and
-- the second at the bottom right, added to the ground.
---------------------------------------------------------------------------

local function lantern(frame, kit, key, corner)
	local own = kit.store(frame)
	local t = own[key]
	if not t then
		t = frame:CreateTexture(nil, "BACKGROUND", nil, -6)
		t:SetTexture(Theme.Media("glow"))
		t:SetBlendMode("ADD")
		t:SetPoint(corner, frame, corner, 0, 0)
		own[key] = t
	end
	return t
end

local function lights(frame, kit)
	local w, h = frame:GetWidth() or 300, frame:GetHeight() or 300
	local size = math.max(120, math.min(300, math.min(w, h) * 0.9))
	local r, g, b = Theme.Accent()
	local a, second = pairFor(r, g, b)
	local first = lantern(frame, kit, "first", "TOPLEFT")
	local far = lantern(frame, kit, "second", "BOTTOMRIGHT")
	if a and not second then
		first:Hide()
		far:Hide()
		return
	end
	first:SetSize(size, size * 0.7)
	first:SetVertexColor(r, g, b, 0.22)
	first:Show()
	if second then r, g, b = rgb(second) end
	far:SetSize(size, size * 0.7)
	far:SetVertexColor(r, g, b, 0.18)
	far:Show()
end

local PAINT = {
	window = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		lights(frame, kit)
	end,
	panel = function(frame, base, kit)
		base(frame)
		if frame.psBare then return kit.bare(frame) end
		lights(frame, kit)
	end,
}

local PRESET = {
	["ui.scheme"] = "lantern-forge", -- the first mood; pick another under Colour scheme
	["ui.band"] = true, ["ui.haze"] = false, ["ui.shadow"] = true,
}

local spec = {
	api = 1,
	name = "Lanterns",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = "Two soft lights in opposite corners, in the colours of the Lanterns mood you pick under Colour scheme.",
	base = "polestar",
	paint = PAINT,
	arrow = "3d",
	mapIcons = "polestar",
}
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin lanterns", Theme.RegisterSkin("lanterns", spec))
