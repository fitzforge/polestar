-- Lanterns: a pack of moods for Polestar through its Skin API (docs/skins
-- in the Polestar repository). Ten moods, each a pair of colours: the
-- first tints every ground a little toward it and is the accent, the
-- second answers it from the far corner. Every window hangs two soft
-- lights in opposite corners in the mood's pair (the "lanterns"), and the
-- progress line runs from one colour into the other.
-- The player picks the mood under the skin's card (Plain has no lights).
--
-- What this skin shows:
--   * `variants`: one skin in ten colourings, each with its tokens;
--   * the `accent2` token (the mood's second colour) and `kit.glow`;
--   * a gradient across the progress line in the `guideProgress` hook.
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
-- The moods: id, name, the first colour (accent, tint), the second (the
-- far lantern; nil for a mood with no lights), a line for the picker.
---------------------------------------------------------------------------

local MOODS = {
	{ "forge", "Forge", "#ff8a3d", "#ffd36b", "Ember and gold: a warm forge glow." },
	{ "tidepool", "Tidepool", "#3fc8c0", "#4f86ff", "Teal and blue: deep, still water." },
	{ "glade", "Glade", "#6fd36a", "#cfe85a", "Leaf and lime: light through a canopy." },
	{ "hoarfrost", "Hoarfrost", "#8fd6ff", "#ffffff", "Ice and white: a clear winter morning." },
	{ "duskrose", "Dusk Rose", "#ff7aa8", "#8a4fd6", "Rose and plum: the last of the sunset." },
	{ "starfall", "Starfall", "#ffd36b", "#5b6cff", "Gold and indigo: a meteor over the sea." },
	{ "ashen", "Ashen", "#b8b2aa", "#6f6a66", "Warm greys: embers gone cold." },
	{ "highsun", "Highsun", "#ffd93d", "#ff8c3d", "Yellow and orange: noon on the plains." },
	{ "gloam", "Gloam", "#9b6cff", "#3fc8c0", "Violet and teal: the hour after dusk." },
	{ "plain", "Plain", "#d9d9e0", nil, "Neutral, no lights: just the grounds." },
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

-- A mood's tokens: every ground tinted a little toward its first colour,
-- the pair as accent and accent2, the first on the pins' rims and the
-- arrow's glow.
local function moodTokens(a, second)
	return {
		bg = tint("#0b0c12", a, 0.1, 0.97), panel = tint("#10121a", a, 0.1, 0.98), panelAlt = tint("#161925", a, 0.1),
		sidebar = tint("#07080c", a, 0.08), footer = tint("#090a10", a, 0.08), sky = tint("#141626", a, 0.16),
		text = tint("#f6f6fa", a, 0.04), textDim = tint("#c4c6d4", a, 0.06), textMuted = tint("#979aac", a, 0.08),
		ink = tint("#ffffff", a, 0.15), star = tint("#ffffff", a, 0.3), shade = "#000004", scrim = tint("#04050a", a, 0.1),
		onAccent = "#0b0c12", shadow = "#00000499",
		accent = a, accent2 = second or a, pinRing = a, glow = a,
	}
end

---------------------------------------------------------------------------
-- The lights: two soft radial glows, the first colour at the top left and
-- the second at the bottom right, added to the ground. None in Plain
-- (accent2 equal to the accent).
---------------------------------------------------------------------------

local function pair()
	local r, g, b = Theme.Accent()
	local r2, g2, b2 = Theme.Color("accent2")
	local same = math.abs(r - r2) + math.abs(g - g2) + math.abs(b - b2) < 0.01
	return { r, g, b, 1 }, not same and { r2, g2, b2, 1 } or nil
end

local function lights(frame, kit)
	local own = kit.store(frame)
	local first, second = pair()
	if not second then
		if own.lit then
			for _, k in ipairs({ "glow:near", "glow:far" }) do if own[k] then own[k]:Hide() end end
			own.lit = nil
		end
		return
	end
	local w, h = frame:GetWidth() or 300, frame:GetHeight() or 300
	local size = math.max(120, math.min(300, math.min(w, h) * 0.9))
	first[4], second[4] = 0.22, 0.18
	kit.glow(frame, { key = "near", point = "TOPLEFT", size = { size, size * 0.7 }, color = first, layer = "BACKGROUND", sub = -6 })
	kit.glow(frame, { key = "far", point = "BOTTOMRIGHT", size = { size, size * 0.7 }, color = second, layer = "BACKGROUND", sub = -6 })
	own.lit = true
end

local function lit(frame, base, kit)
	base(frame)
	if frame.psBare then return kit.bare(frame) end
	lights(frame, kit)
end

-- The progress line's fill: the first colour into the second.
local function duotone(t)
	if not (t and t.SetGradient and CreateColor) then return end
	local first, second = pair()
	if not second then return end
	t:SetVertexColor(1, 1, 1, 1)
	t:SetGradient("HORIZONTAL", CreateColor(first[1], first[2], first[3], 1), CreateColor(second[1], second[2], second[3], 1))
end

local variants = {}
for _, m in ipairs(MOODS) do
	variants[#variants + 1] = { id = m[1], name = m[2], desc = m[5], tokens = moodTokens(m[3], m[4]) }
end

check("skin lanterns", Theme.RegisterSkin("lanterns", {
	api = 2,
	name = "Lanterns",
	addon = ADDON,
	author = "Polestar",
	desc = "Ten moods, each a pair of colours: tinted grounds, two soft lights in opposite corners, a two-tone progress line.",
	base = "polestar",
	tokens = moodTokens(MOODS[1][3], MOODS[1][4]),
	variants = variants,
	defaultVariant = "forge",
	paint = { window = lit, panel = lit },
	hooks = {
		guideProgress = function(foot) duotone(foot.Line and foot.Line.Fill) end,
	},
	arrow = "3d",
	mapIcons = "polestar",
	preset = { ["ui.band"] = true, ["ui.haze"] = false, ["ui.shadow"] = true },
}))
