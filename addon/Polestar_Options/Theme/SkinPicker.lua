-- The skin picker's side of the Skin API (docs/skins), loaded with the
-- settings window: the picture cards of the skins and schemes (the Theme
-- page's picker, UI/Looks/Theme.lua) and a skin's preset, applied and undone
-- on the player's word. Registration, the palettes and the hooks stay in
-- Polestar itself (Theme/SkinApi.lua, Theme/Theme.lua), whose internals this
-- reads through Polestar.ThemeInternal.

local ns = Polestar
local Theme = ns.Theme
local I = ns.ThemeInternal
if not (Theme and I) then return end
local DEFAULT_ACCENT, FAMILIES, RIVALS, SCHEMES, SCHEME_INFO = I.DEFAULT_ACCENT, I.FAMILIES, I.RIVALS, I.SCHEMES, I.SCHEME_INFO
local SCHEME_WASH, SKINS, SKIN_FONT, WASH = I.SCHEME_WASH, I.SKINS, I.SKIN_FONT, I.WASH
local batch, field, gameFont, get, isColor = I.batch, I.field, I.gameFont, I.get, I.isColor
local previewing, resolve, variantOf = I.previewing, I.resolve, I.variantOf
local ipairs, pairs, type = ipairs, pairs, type

---------------------------------------------------------------------------
-- Presets
---------------------------------------------------------------------------

-- A skin's preset (spec.preset): the settings it recommends, as a copy, or
-- nil. Never applied by itself: the player applies it (the Theme page's
-- "Apply <skin>'s layout") and may undo it.
local function copyValue(v)
	if type(v) ~= "table" then return v end
	local c = {}
	for k, x in pairs(v) do c[k] = x end
	return c
end

-- A registered skin's preset with its variant's over it (spec.variants[i].preset).
local function presetOf(s)
	local v = s.variants and s.variantBy[variantOf(s)]
	if not (v and v.preset) then return s.preset end
	local out = {}
	for path, x in pairs(s.preset or {}) do out[path] = x end
	for path, x in pairs(v.preset) do out[path] = x end
	return out
end

function Theme.SkinPreset(id)
	local s = SKINS[id]
	local preset = s and presetOf(s)
	if not preset then return nil end
	local out = {}
	for path, v in pairs(preset) do out[path] = copyValue(v) end
	return out
end

-- The settings an applied preset changed, as they were before: one level of
-- undo for the session (a reload forgets it; the profiles keep a copy).
local presetUndo -- { id = skin id, values = { [path] = value before } }

-- Apply skin `id`'s preset through ns.Set (so each setting fires its own
-- change and a value equal to its default is not stored), remembering what
-- each setting (and the colour sources it turns off) was. Applying another
-- preset before undoing keeps the oldest values, so Undo goes back to before
-- the first. -> ok, why
function Theme.ApplySkinPreset(id)
	local s = SKINS[id]
	if not s then return false, "no such skin" end
	local preset = presetOf(s)
	if not preset then return false, "this skin has no preset" end
	local undo = presetUndo or { values = {} }
	local function remember(path)
		if undo.values[path] == nil then
			local v = ns.Get(path)
			undo.values[path] = v == nil and false or copyValue(v)
		end
	end
	for path in pairs(preset) do
		remember(path)
		for _, rival in ipairs(RIVALS[path] or {}) do remember(rival) end
	end
	undo.id = id
	presetUndo = undo
	local ok, err = batch(function()
		for path, v in pairs(preset) do ns.Set(path, copyValue(v)) end
	end)
	if not ok then
		if ns.NoteError then ns.NoteError(err) end
		return false, tostring(err)
	end
	return true
end

-- The skin whose preset Undo would take back, or nil.
function Theme.SkinPresetApplied()
	return presetUndo and presetUndo.id or nil
end

-- Put back every setting the last applied preset(s) changed. -> ok
function Theme.UndoSkinPreset()
	local undo = presetUndo
	if not undo then return false end
	presetUndo = nil
	local ok, err = batch(function()
		for path, v in pairs(undo.values) do ns.Set(path, copyValue(v)) end
	end)
	if not ok and ns.NoteError then ns.NoteError(err) end
	return ok
end

---------------------------------------------------------------------------
-- The picker's cards
---------------------------------------------------------------------------

-- A small picture of a palette on `card`: the window ground with the band
-- across its top, a title and a dimmer line in `face`, an accent bar and a
-- button, edged by the window border. Textures and strings on the card
-- itself, 4 units in from its edges (the card's own border and selection
-- stay the picker's), made on its first draw.
local CARD_IN = 4
local function cardParts(card)
	local p = card.psSkinCard
	if p then return p end
	local function tex(layer, sub)
		local t = card:CreateTexture(nil, layer, nil, sub)
		t:SetTexture(Theme.Media("white"))
		return t
	end
	p = {}
	p.ground = tex("BACKGROUND", -6)
	p.ground:SetPoint("TOPLEFT", card, "TOPLEFT", CARD_IN, -CARD_IN)
	p.ground:SetPoint("BOTTOMRIGHT", card, "BOTTOMRIGHT", -CARD_IN, CARD_IN)
	p.band = card:CreateTexture(nil, "BACKGROUND", nil, -5)
	p.band:SetPoint("TOPLEFT", p.ground, "TOPLEFT", 0, 0)
	p.band:SetPoint("TOPRIGHT", p.ground, "TOPRIGHT", 0, 0)
	p.stars = card:CreateTexture(nil, "BACKGROUND", nil, -4)
	p.stars:SetAllPoints(p.band)
	-- The window border: four 1-unit edges round the ground.
	p.edges = {}
	for i, pts in ipairs({ { "TOPLEFT", "TOPRIGHT" }, { "BOTTOMLEFT", "BOTTOMRIGHT" }, { "TOPLEFT", "BOTTOMLEFT" }, { "TOPRIGHT", "BOTTOMRIGHT" } }) do
		local e = tex("BORDER", 1)
		e:SetPoint(pts[1], p.ground, pts[1], 0, 0)
		e:SetPoint(pts[2], p.ground, pts[2], 0, 0)
		if i <= 2 then e:SetHeight(1) else e:SetWidth(1) end
		p.edges[i] = e
	end
	p.panel = tex("BORDER", 0)
	p.title = card:CreateFontString(nil, "OVERLAY")
	p.title:SetPoint("TOPLEFT", p.ground, "TOPLEFT", 8, -8)
	p.line = card:CreateFontString(nil, "OVERLAY")
	p.line:SetPoint("TOPLEFT", p.title, "BOTTOMLEFT", 0, -3)
	p.accent = tex("ARTWORK", 0)
	p.accent:SetPoint("BOTTOMLEFT", p.ground, "BOTTOMLEFT", 8, 8)
	p.accent:SetHeight(3)
	p.button = tex("ARTWORK", 0)
	p.button:SetPoint("BOTTOMRIGHT", p.ground, "BOTTOMRIGHT", -8, 6)
	p.panel:SetPoint("TOPLEFT", p.button, "TOPLEFT", -1, 1)
	p.panel:SetPoint("BOTTOMRIGHT", p.button, "BOTTOMRIGHT", 1, -1)
	card.psSkinCard = p
	return p
end

local function drawCard(card, pal, face, band, stars)
	if type(card) ~= "table" or not card.CreateTexture or not pal then return end
	local p = cardParts(card)
	local w, h = (card:GetWidth() or 0) - CARD_IN * 2, (card:GetHeight() or 0) - CARD_IN * 2
	if w < 24 then w = 96 end
	if h < 24 then h = 60 end
	local function tint(t, c, a) t:SetVertexColor(c[1], c[2], c[3], a or c[4] or 1) end
	tint(p.ground, pal.bg, math.max(0.85, pal.bg[4] or 1))
	p.band:SetTexture(band)
	p.stars:SetTexture(stars)
	local bandH = math.floor(h * 0.4)
	p.band:SetHeight(bandH)
	p.band:SetTexCoord(Theme.BandCoords(w, bandH))
	p.stars:SetTexCoord(Theme.BandCoords(w, bandH))
	tint(p.band, pal.sky, 1)
	tint(p.stars, pal.star)
	Theme.SetFace(p.title, face.semibold, 13, "")
	Theme.SetFace(p.line, face.medium, 10, "")
	p.title:SetText("Aa")
	p.line:SetText("Polestar")
	local t, d = pal.title or pal.text, pal.textDim
	p.title:SetTextColor(t[1], t[2], t[3], 1)
	p.line:SetTextColor(d[1], d[2], d[3], 1)
	p.accent:SetWidth(math.max(8, math.floor(w * 0.35)))
	tint(p.accent, pal.accent, 1)
	p.button:SetSize(math.max(10, math.floor(w * 0.25)), 10)
	tint(p.button, pal.control or pal.panelAlt)
	tint(p.panel, pal.border)
	for i = 1, 4 do tint(p.edges[i], pal.windowBorder) end
end

-- The faces of a font key at the card's weights.
local function cardFace(key)
	local fam = FAMILIES[key]
	if not fam then
		local g = gameFont()
		return { semibold = g, medium = g }
	end
	return { semibold = fam.semibold or fam.regular, medium = fam.medium or fam.regular }
end

-- The skin picker's card (UI/Looks/Theme.lua): skin `id` drawn on `card`
-- with its own palette, face and band, the player's own colours over it;
-- the live skin is left alone. `variant`: one of the skin's variants (its
-- variant cards), else the one in use. Call it again on every redraw.
function Theme.DrawSkinCard(card, id, variant)
	local s = SKINS[id]
	if not s then return end
	previewing[id] = variant
	local pal = resolve(id)
	local v = s.variants and s.variantBy[variantOf(s)]
	local base = s.builtin and id or field(s, "base") or "polestar"
	previewing[id] = nil
	local own, media = v and v.media or {}, s.media or {}
	drawCard(card, pal, cardFace(SKIN_FONT[id] or SKIN_FONT[base]), own.band or media.band or Theme.Media("band"),
		own.bandStars or media.bandStars or Theme.Media("band-stars"))
end

-- A scheme's card: its own grounds and text in the house style, with the
-- accent in use.
function Theme.DrawSchemeCard(card, id)
	local src = id == "ellesmere" and Theme.SchemeKey() == "ellesmere" and Theme.Palette() or SCHEMES[id]
	if not src then return end
	local pal = {}
	for k, c in pairs(src) do pal[k] = c end
	local info = SCHEME_INFO[id]
	local own = get("ui.accent")
	pal.accent = isColor(own) and { own[1], own[2], own[3], 1 } or (info and info.accent) or { DEFAULT_ACCENT[1], DEFAULT_ACCENT[2], DEFAULT_ACCENT[3], 1 }
	local wash = (SCHEME_WASH[id] and SCHEME_WASH[id].border) or WASH.border
	pal.border = pal.border or { pal.ink[1], pal.ink[2], pal.ink[3], wash }
	pal.windowBorder = pal.windowBorder or pal.border
	drawCard(card, pal, cardFace(SKIN_FONT.polestar), Theme.Media("band"), Theme.Media("band-stars"))
end
