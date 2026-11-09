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

-- A mood's scheme tokens: every ground tinted a little toward its first colour.
local function moodTokens(a)
	return {
		bg = tint("#0b0c12", a, 0.1, 0.97), panel = tint("#10121a", a, 0.1, 0.98), panelAlt = tint("#161925", a, 0.1),
		sidebar = tint("#07080c", a, 0.08), footer = tint("#090a10", a, 0.08), sky = tint("#141626", a, 0.16),
		text = tint("#f6f6fa", a, 0.04), textDim = tint("#c4c6d4", a, 0.06), textMuted = tint("#979aac", a, 0.08),
		ink = tint("#ffffff", a, 0.15), star = tint("#ffffff", a, 0.3), shade = "#000004", scrim = tint("#04050a", a, 0.1),
		onAccent = "#0b0c12", shadow = "#00000499",
	}
end

for _, m in ipairs(MOODS) do
	check("scheme lantern-" .. m[1], Theme.RegisterScheme("lantern-" .. m[1], {
		api = 1, name = m[2], addon = ADDON, author = "Polestar", version = "1.0", desc = m[5],
		tokens = moodTokens(m[3]), accent = m[3],
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

-- The pair in use: on Skin API 2 the variant's accent and accent2 tokens;
-- on 1 the accent in use matched against the moods.
local function pairInUse()
	local r, g, b = Theme.Accent()
	if V2 then
		local r2, g2, b2, a2 = Theme.Color("accent2")
		if a2 and a2 > 0 then return r, g, b, r2, g2, b2 end
		return r, g, b, nil
	end
	local a, second = pairFor(r, g, b)
	if a and not second then return r, g, b, nil end
	if second then
		local r2, g2, b2 = rgb(second)
		return r, g, b, r2, g2, b2
	end
	return r, g, b, r, g, b
end

local function lights(frame, kit)
	local w, h = frame:GetWidth() or 300, frame:GetHeight() or 300
	local size = math.max(120, math.min(300, math.min(w, h) * 0.9))
	local r, g, b, r2, g2, b2 = pairInUse()
	local first = lantern(frame, kit, "first", "TOPLEFT")
	local far = lantern(frame, kit, "second", "BOTTOMRIGHT")
	if not r2 then
		first:Hide()
		far:Hide()
		return
	end
	first:SetSize(size, size * 0.7)
	first:SetVertexColor(r, g, b, 0.22)
	first:Show()
	far:SetSize(size, size * 0.7)
	far:SetVertexColor(r2, g2, b2, 0.18)
	far:Show()
end

-- The duotone rule under the title and the progress line: the first
-- colour running into the second (Skin API 2's horizontal gradient).
local function duotone(frame, part, base, kit)
	base(frame, part)
	if not (part and part.SetGradient and CreateColor) then return end
	local r, g, b, r2, g2, b2 = pairInUse()
	if not r2 then return end
	part:SetVertexColor(1, 1, 1, 1)
	part:SetGradient("HORIZONTAL", CreateColor(r, g, b, 1), CreateColor(r2, g2, b2, 1))
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
	["ui.band"] = true, ["ui.haze"] = false, ["ui.shadow"] = true,
}
if not V2 then PRESET["ui.scheme"] = "lantern-forge" end -- the first mood; pick another under Colour scheme

local spec = {
	api = V2 and 2 or 1,
	name = "Lanterns",
	addon = ADDON,
	author = "Polestar",
	version = "1.0",
	desc = V2 and "Ten moods, each a pair of colours: tinted grounds, two soft lights in opposite corners, a two-tone rule and dart."
		or "Two soft lights in opposite corners, in the colours of the Lanterns mood you pick under Colour scheme.",
	base = "polestar",
	paint = PAINT,
	arrow = "3d",
	mapIcons = "polestar",
}
if V2 then
	-- The moods as variants of one skin: each wears its scheme, carries
	-- its second colour as accent2 (the far lantern, the rule's far end,
	-- the dart's second stop) and the first on the pins' rims.
	spec.variants = {}
	for _, m in ipairs(MOODS) do
		local v = { id = m[1], name = m[2]:gsub("^Lanterns: ", ""), desc = m[5], scheme = "lantern-" .. m[1],
			tokens = { accent = m[3], pinRing = m[3] } }
		if m[4] then
			v.tokens.accent2 = m[4]
			v.arrow = { fill = "accent", gradient = { m[3], m[4] } }
		else
			v.arrow = { fill = "accent" }
		end
		spec.variants[#spec.variants + 1] = v
	end
	spec.defaultVariant = "forge"
	spec.hooks = { progress = duotone, titleRule = duotone }
end
if Theme.HasCapability("preset") then spec.preset = PRESET end

check("skin lanterns", Theme.RegisterSkin("lanterns", spec))
