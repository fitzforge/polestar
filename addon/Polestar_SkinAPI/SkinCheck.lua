-- The Skin API's checks (docs/skins/reference.md): what a colour scheme or a
-- skin from another addon goes through as it registers (its fields, colours
-- and fonts, its text's legibility, its variants, shadow, art tint and
-- preset). Polestar loads this part (Polestar_SkinAPI, load on demand) with
-- the first scheme or skin another addon registers (Theme/SkinApi.lua), so a
-- player who uses none never loads it. Polestar's own internals come through
-- Polestar.ThemeInternal; the checks go back to it as I.register, and the
-- resolver (Theme.lua) reads a resolver's tokens and font with readTokens and
-- readFont below.

local ns = Polestar
local Theme = ns and ns.Theme
local I = ns and ns.ThemeInternal
if not (Theme and I) or I.register then return end
local ART, BRAND, FAMILIES, HOUSE_EXTRA, ROLES, SCHEMES = I.ART, I.BRAND, I.FAMILIES, I.HOUSE_EXTRA, I.ROLES, I.SCHEMES
local SCHEME_INFO, SCHEME_WASH, SHARED, SKINS, SKIN_FONT, SKIN_ICON = I.SCHEME_INFO, I.SCHEME_WASH, I.SHARED, I.SKINS, I.SKIN_FONT, I.SKIN_ICON
local SKIN_PALETTES, SKIN_ROLES, SKIN_SHADOW, WASH = I.SKIN_PALETTES, I.SKIN_ROLES, I.SKIN_SHADOW, I.WASH
local copy, floor, format, get, ipairs, isLight = I.copy, I.floor, I.format, I.get, I.ipairs, I.isLight
local pairs, shifted, type, report = I.pairs, I.shifted, I.type, I.report

-- The surfaces a skin may paint and hook (Theme/SkinApi.lua's lists).
local PAINT_KINDS, HOOKS = I.PAINT_KINDS, I.HOOKS
local SKIN_MEDIA = { band = true, bandStars = true, medallion = true, dart = true, dartEdge = true }
local ARROW_STYLES = { ["3d"] = true, flat = true, halo = true, hearth = true }
local MAP_ICONS = { polestar = true, halo = true, hearth = true }
local FONT_KEYS = { game = true, inter = true, fira = true, opensans = true }
-- The scheme tokens a scheme must give (the grounds and the text ladder),
-- and those it may (Dusk's stand in).
local SCHEME_NEEDS = { "bg", "panel", "panelAlt", "sidebar", "footer", "sky", "text", "textDim", "textMuted" }
local SCHEME_MAY = { "ink", "star", "shade", "scrim", "onAccent", "shadow" }

-- A colour as a spec may give it: { r, g, b[, a] } or { r =, g =, b =[, a =] }
-- in 0-1, or "#rrggbb" / "#rrggbbaa". -> { r, g, b, a } | nil
local function specColor(v)
	if type(v) == "string" then
		local h = v:match("^#?(%x+)$")
		if not h or (#h ~= 6 and #h ~= 8) then return nil end
		local function byte(i) return tonumber(h:sub(i, i + 1), 16) / 255 end
		return { byte(1), byte(3), byte(5), #h == 8 and byte(7) or 1 }
	end
	if type(v) ~= "table" then return nil end
	local r, g, b, a = v[1] or v.r, v[2] or v.g, v[3] or v.b, v[4] or v.a
	if a == nil then a = 1 end
	for _, x in ipairs({ r, g, b, a }) do
		if type(x) ~= "number" or x ~= x or x < 0 or x > 1 then return nil end
	end
	return { r, g, b, a }
end

-- Every token name a palette has (a spec naming another is a typo).
local known
local function knownTokens()
	if known then return known end
	known = { accent = true, windowBorder = true }
	for _, t in ipairs({ SCHEMES.dusk, SHARED, ART, BRAND, WASH, HOUSE_EXTRA }) do
		for k in pairs(t) do known[k] = true end
	end
	for _, pal in pairs(SKIN_PALETTES) do
		for k in pairs(pal) do known[k] = true end
	end
	return known
end

-- `tokens` checked and copied as colours. -> table | nil, why
local function readTokens(tokens, what)
	if tokens == nil then return {} end
	if type(tokens) ~= "table" then return nil, what .. " must be a table" end
	local out, names = {}, knownTokens()
	for k, v in pairs(tokens) do
		if type(k) ~= "string" or not names[k] then return nil, format("unknown token %q in %s", tostring(k), what) end
		local c = specColor(v)
		if not c then return nil, format("token %q is not a colour (give { r, g, b[, a] } in 0-1 or \"#rrggbb\")", k) end
		out[k] = c
	end
	return out
end

-- The grounds as text sees them: the window ground over black, every other
-- ground over the window ground at its own alpha (a skin's translucent
-- washes, Halo's controls).
local function seen(pal)
	local out = {}
	for k, v in pairs(pal) do out[k] = v end
	local bg = pal.bg
	local a = bg[4] or 1
	local under = { bg[1] * a, bg[2] * a, bg[3] * a, 1 }
	out.bg = under
	for _, g in ipairs(Theme.GROUNDS) do
		if g ~= "bg" then
			local c = pal[g]
			local ca = c[4] or 1
			out[g] = { c[1] * ca + under[1] * (1 - ca), c[2] * ca + under[2] * (1 - ca), c[3] * ca + under[3] * (1 - ca), 1 }
		end
	end
	return out
end

-- The text role that reads worst on a ground, against its floor (the rule
-- Theme.Legibility holds the schemes to: the text ladder on every ground,
-- the subject colours on every ground but the band). -> ratio of its floor,
-- role, ground, contrast, floor
local SUBJECT_ORDER = {}
for k in pairs(SHARED) do SUBJECT_ORDER[#SUBJECT_ORDER + 1] = k end
table.sort(SUBJECT_ORDER)
local function weakest(pal)
	local worst, role, ground, ratio, need = math.huge
	local function try(r, g, floorRatio)
		local c = Theme.Contrast(pal[r], pal[g])
		if c / floorRatio < worst then worst, role, ground, ratio, need = c / floorRatio, r, g, c, floorRatio end
	end
	for _, g in ipairs(Theme.GROUNDS) do
		for _, r in ipairs({ "text", "textDim", "textMuted" }) do try(r, g, Theme.LEGIBLE[r]) end
		if g ~= "sky" then
			for _, r in ipairs(SUBJECT_ORDER) do try(r, g, 4.5) end
		end
	end
	return worst, role, ground, ratio, need
end

-- `pal` legible as given, or its grounds moved together (alpha kept) by the
-- least that makes it so: darkened under light text, lifted under dark text
-- (a light palette, Theme.IsLightPalette); nil when even the darkest (or
-- lightest) grounds would not carry the text. -> grounds | nil, why, corrected
local function legibleGrounds(pal, strict)
	local worst, role, ground, ratio, need = weakest(seen(pal))
	if worst >= 1 then return pal, nil, false end
	local why = format("%s on %s reads %.1f:1, needs %g:1", role, ground, ratio, need)
	if strict then return nil, why end
	local light = isLight(pal)
	local far = light and 1 or -1
	local base, trial = {}, {}
	for k, v in pairs(pal) do trial[k] = v end
	for _, g in ipairs(Theme.GROUNDS) do base[g] = pal[g] end
	local function at(dL)
		for _, g in ipairs(Theme.GROUNDS) do trial[g] = shifted(base[g], dL) end
		return weakest(seen(trial)) >= 1
	end
	if not at(far) then return nil, why .. (light and " even with the grounds at their lightest" or " even with the grounds at their darkest") end
	local lo, hi = far, 0
	for _ = 1, 14 do
		local mid = (lo + hi) / 2
		if at(mid) then lo = mid else hi = mid end
	end
	at(lo)
	return trial, why .. format("; the grounds were %s (%.2f) until the text reads", light and "lightened" or "darkened", lo), true
end

local function apiCheck(spec)
	local api = spec.api
	if api == nil then return true end
	if type(api) ~= "number" or api < 1 or api ~= floor(api) then return false, "api must be a whole number from 1" end
	if api > Theme.API_VERSION then
		return false, format("needs Skin API %d; this Polestar has %d (update Polestar)", api, Theme.API_VERSION)
	end
	return true
end

local function idCheck(id, taken)
	if type(id) ~= "string" or not id:match("^[%a][%w_%-]*$") or #id > 32 then
		return false, "the id must be a word of letters, digits, _ or - (32 at most), starting with a letter"
	end
	if taken then return false, format("the id %q is taken (%s)", id, taken) end
	return true
end

local function textField(spec, key, need, what)
	local v = spec[key]
	if v == nil and not need then return true end
	if type(v) ~= "string" or v == "" or #v > (key == "desc" and 200 or 40) then
		return false, format("%s must be %s", key, what)
	end
	return true
end

-- The spec fields each kind of spec may have (any other is a typo).
local SCHEME_FIELDS = { api = true, name = true, addon = true, author = true, version = true, desc = true, tokens = true,
	accent = true, washes = true, strict = true }
local SKIN_FIELDS = { api = true, name = true, addon = true, author = true, version = true, desc = true, base = true,
	scheme = true, tokens = true, font = true, fontSizes = true, textShadow = true, icons = true, media = true, arrow = true,
	mapIcons = true, paint = true, hooks = true, onApply = true, onLeave = true, strict = true, preset = true,
	-- Skin API 2
	variants = true, defaultVariant = true, resolve = true, shadow = true, artTint = true }
-- A variant's own (spec.variants, Skin API 2): what it changes of the skin.
local VARIANT_FIELDS = { id = true, name = true, desc = true, base = true, scheme = true, tokens = true, media = true,
	arrow = true, preset = true, artTint = true, shadow = true }

-- A preset may hold the look's settings, never what Polestar does: these
-- sections are behaviour (automation, gear, talents...), and ui.skin is the
-- choice the preset belongs to.
local PRESET_DENIED_SECTIONS = { behavior = true, gear = true, talents = true, alts = true, party = true, lookup = true,
	routePlan = true, gamepad = true, dungeons = true }
local PRESET_DENIED_KEYS = { ["ui.skin"] = true }

-- A preset value as its setting holds it, checked against the setting's
-- default: the same type; a colour setting (default false) takes a colour.
-- -> value | nil, why
local function presetValue(path, v)
	if type(path) ~= "string" or not path:match("^[%a][%w_]*%.[%w_.]+$") then
		return nil, format("preset key %q is not a setting path (like \"ui.scale\")", tostring(path))
	end
	if PRESET_DENIED_KEYS[path] or PRESET_DENIED_SECTIONS[path:match("^[^.]+")] then
		return nil, format("preset.%s is not a look setting (a preset changes how Polestar looks, never what it does)", path)
	end
	local d = ns.GetDefault and ns.GetDefault(path)
	if d == nil then return nil, format("preset: Polestar has no setting %q", path) end
	if d == false and type(v) ~= "boolean" then
		local c = specColor(v)
		if not c then return nil, format("preset.%s must be false or a colour", path) end
		return c
	end
	if type(v) ~= type(d) then return nil, format("preset.%s must be a %s, like its default", path, type(d)) end
	if type(v) == "number" and (v ~= v or v == math.huge or v == -math.huge) then return nil, format("preset.%s is not a number", path) end
	if type(v) == "table" then
		local c = {}
		for k, x in pairs(v) do
			if type(x) == "table" or type(x) == "function" then return nil, format("preset.%s holds a nested table", path) end
			c[k] = x
		end
		return c
	end
	return v
end

local function readPreset(preset)
	if preset == nil then return true end
	if type(preset) ~= "table" then return false, "preset must be a table of setting = value" end
	local out, any = {}, false
	for path, v in pairs(preset) do
		local value, why = presetValue(path, v)
		if value == nil then return false, why end
		out[path], any = value, true
	end
	if not any then return false, "preset is empty" end
	return true, out
end

local function fieldsCheck(spec, allowed)
	for k in pairs(spec) do
		if not allowed[k] then return false, format("unknown field %q", tostring(k)) end
	end
	return true
end

local function metaCheck(spec)
	local ok, why = apiCheck(spec)
	if not ok then return false, why end
	for _, f in ipairs({ { "name", true, "a name of 1-40 characters" }, { "addon", true, "your addon's folder name" },
		{ "author", false, "a string" }, { "version", false, "a string" }, { "desc", false, "a string of 200 characters at most" } }) do
		ok, why = textField(spec, f[1], f[2], f[3])
		if not ok then return false, why end
	end
	return true
end

local function registerScheme(id, spec)
	if type(spec) ~= "table" then return false, "the spec must be a table" end
	local ok, why = fieldsCheck(spec, SCHEME_FIELDS)
	if ok then
		local info = SCHEME_INFO[id]
		ok, why = idCheck(id, id == "ellesmere" and "EllesmereUI's" or info and (info.addon or "Polestar"))
	end
	if ok then ok, why = metaCheck(spec) end
	if not ok then return false, why end
	local tokens
	tokens, why = readTokens(spec.tokens, "tokens")
	if not tokens then return false, why end
	for _, k in ipairs(SCHEME_NEEDS) do
		if not tokens[k] then return false, format("tokens.%s is missing (a scheme gives %s)", k, table.concat(SCHEME_NEEDS, ", ")) end
	end
	for _, k in ipairs(SCHEME_MAY) do
		if not tokens[k] then tokens[k] = copy(SCHEMES.dusk[k]) end
	end
	-- The status and subject colours (quest gold, NPC blue...) are the same in
	-- every dark scheme; a scheme may give its own (a light one must: they
	-- are drawn for night grounds).
	for k in pairs(tokens) do
		if ART[k] or BRAND[k] or WASH[k] or HOUSE_EXTRA[k] or k == "accent" or k == "windowBorder" then
			return false, format("tokens.%s belongs to a skin, not a scheme (a scheme gives the grounds, the text ladder and the subject colours)", k)
		end
	end
	local accent
	if spec.accent ~= nil then
		accent = specColor(spec.accent)
		if not accent then return false, "accent is not a colour" end
	end
	local washes
	if spec.washes ~= nil then
		if type(spec.washes) ~= "table" then return false, "washes must be a table" end
		washes = {}
		for k, a in pairs(spec.washes) do
			if not WASH[k] then return false, format("unknown wash %q", tostring(k)) end
			if type(a) ~= "number" or a < 0 or a > 1 then return false, format("washes.%s must be an alpha from 0 to 1", k) end
			washes[k] = a
		end
	end
	local pal = {}
	for k, c in pairs(SHARED) do pal[k] = c end
	for k, c in pairs(tokens) do pal[k] = c end
	local fixed, note, corrected = legibleGrounds(pal, spec.strict)
	if not fixed then return false, note end
	if corrected then
		for _, g in ipairs(Theme.GROUNDS) do tokens[g] = fixed[g] end
	end
	SCHEMES[id] = tokens
	SCHEME_INFO[id] = { id = id, name = spec.name, addon = spec.addon, author = spec.author, version = spec.version,
		desc = spec.desc, accent = accent }
	if washes then SCHEME_WASH[id] = washes end
	local listed = false
	for _, k in ipairs(Theme.SCHEME_ORDER) do if k == id then listed = true end end
	if not listed then Theme.SCHEME_ORDER[#Theme.SCHEME_ORDER + 1] = id end
	if note then report("scheme", id, spec, note) end
	-- A saved choice waiting for this scheme shows now.
	if get("ui.scheme") == id or (SKINS[Theme.SkinId()] or {}).scheme == id then Theme.Refresh() end
	return true, note
end

local function readFont(font, id)
	if font == nil then return true end
	if type(font) == "string" then
		if not FONT_KEYS[font] then return false, "font must be \"game\", \"inter\", \"fira\", \"opensans\" or a table of font files" end
		return true, font
	end
	if type(font) ~= "table" or type(font.regular) ~= "string" then
		return false, "a font table needs regular = \"Interface\\\\AddOns\\\\...\\\\file.ttf\" (medium, semibold optional)"
	end
	for _, w in ipairs({ "medium", "semibold" }) do
		if font[w] ~= nil and type(font[w]) ~= "string" then return false, "font." .. w .. " must be a file path" end
	end
	local key = "skin:" .. id
	return true, key, { regular = font.regular, medium = font.medium or font.regular, semibold = font.semibold or font.medium or font.regular }
end

local function readMap(t, what, allowedKeys, check)
	if t == nil then return true end
	if type(t) ~= "table" then return false, what .. " must be a table" end
	for k, v in pairs(t) do
		if allowedKeys and not allowedKeys[k] then return false, format("unknown %s %q", what, tostring(k)) end
		if not check(v) then return false, format("%s.%s has the wrong type", what, tostring(k)) end
	end
	return true
end

local function isFunction(v) return type(v) == "function" end
local function isString(v) return type(v) == "string" and v ~= "" end

-- A colour as a spec may give it, or a token's name (the kit's colours).
local function tokenOrColor(v)
	if type(v) == "string" and knownTokens()[v] then return v end
	return specColor(v)
end

-- spec.shadow (Skin API 2): the window's drop shadow, { size, drop, alpha,
-- color } (each optional: the house's size and drop, alpha 0.6, the shadow
-- token), or false for none. -> true, value | false, why
local function readShadow(v, what)
	if v == nil then return true, nil end
	if v == false then return true, false end
	if type(v) ~= "table" then return false, what .. " must be { size, drop, alpha, color } or false" end
	for k in pairs(v) do
		if k ~= "size" and k ~= "drop" and k ~= "alpha" and k ~= "color" then return false, format("unknown field %q in %s", tostring(k), what) end
	end
	local function num(k, lo, hi) local x = v[k]; return x == nil or (type(x) == "number" and x == x and x >= lo and x <= hi) end
	if not num("size", 0, 64) then return false, what .. ".size must be a number from 0 to 64" end
	if not num("drop", -32, 32) then return false, what .. ".drop must be a number from -32 to 32" end
	if not num("alpha", 0, 1) then return false, what .. ".alpha must be a number from 0 to 1" end
	local color
	if v.color ~= nil then
		color = tokenOrColor(v.color)
		if not color then return false, what .. ".color must be a token's name or a colour" end
	end
	return true, { size = v.size, drop = v.drop, alpha = v.alpha or 0.6, color = color }
end

-- spec.artTint (Skin API 2): a tint over a game look's art, { tint,
-- brightness (-1 to 1), desaturate (0 to 1) } (kit.tintArt). -> true, value | false, why
local function readArtTint(v, what)
	if v == nil then return true, nil end
	if type(v) ~= "table" then return false, what .. " must be { tint, brightness, desaturate }" end
	for k in pairs(v) do
		if k ~= "tint" and k ~= "brightness" and k ~= "desaturate" then return false, format("unknown field %q in %s", tostring(k), what) end
	end
	local tint
	if v.tint ~= nil then
		tint = tokenOrColor(v.tint)
		if not tint then return false, what .. ".tint must be a token's name or a colour" end
	end
	local b, d = v.brightness, v.desaturate
	if b ~= nil and (type(b) ~= "number" or b ~= b or b < -1 or b > 1) then return false, what .. ".brightness must be a number from -1 to 1" end
	if d ~= nil and (type(d) ~= "number" or d ~= d or d < 0 or d > 1) then return false, what .. ".desaturate must be a number from 0 to 1" end
	return true, { tint = tint, brightness = b, desaturate = d }
end


-- spec.variants (Skin API 2): one design in several versions, the player's
-- pick under the skin's card (ui.skinVariants.<id>): a list of { id, name,
-- desc, and what the variant changes: base, scheme, tokens (over the skin's),
-- media, arrow, preset, artTint, shadow }. -> true, ids, byId, default | false, why
local function readVariants(spec)
	local list = spec.variants
	if list == nil then
		if spec.defaultVariant ~= nil then return false, "defaultVariant goes with variants" end
		return true
	end
	if type(list) ~= "table" or #list == 0 then return false, "variants must be a list of { id, name, ... }" end
	local ids, by = {}, {}
	for i, v in ipairs(list) do
		local what = "variants[" .. i .. "]"
		if type(v) ~= "table" then return false, what .. " must be a table" end
		for k in pairs(v) do
			if not VARIANT_FIELDS[k] then return false, format("unknown field %q in %s", tostring(k), what) end
		end
		if type(v.id) ~= "string" or not v.id:match("^[%a][%w_%-]*$") or #v.id > 32 then
			return false, what .. ".id must be a word of letters, digits, _ or - (32 at most), starting with a letter"
		end
		if by[v.id] then return false, format("the variant id %q is given twice", v.id) end
		if type(v.name) ~= "string" or v.name == "" or #v.name > 40 then return false, what .. ".name must be a string of 40 characters at most" end
		if v.desc ~= nil and (type(v.desc) ~= "string" or #v.desc > 200) then return false, what .. ".desc must be a string of 200 characters at most" end
		local rec = { id = v.id, name = v.name, desc = v.desc }
		if v.base ~= nil then
			if not (SKINS[v.base] and SKINS[v.base].builtin) then
				return false, what .. ".base must be one of Polestar's skins: polestar, halo, hearth, forever, blizzard, classic"
			end
			rec.base = v.base
		end
		local base = rec.base or spec.base or "polestar"
		if v.scheme ~= nil then
			if base ~= "polestar" then return false, what .. ".scheme goes with base \"polestar\"" end
			if not (type(v.scheme) == "string" and SCHEMES[v.scheme] and SCHEME_INFO[v.scheme]) then
				return false, format("%s.scheme %q is not registered (register it first)", what, tostring(v.scheme))
			end
			rec.scheme = v.scheme
		end
		if v.tokens ~= nil then
			local t, why = readTokens(v.tokens, what .. ".tokens")
			if not t then return false, why end
			rec.tokens = t
		end
		local ok, why = readMap(v.media, what .. ".media", SKIN_MEDIA, isString)
		if not ok then return false, why end
		if v.media then
			rec.media = {}
			for k, p in pairs(v.media) do rec.media[k] = p end
		end
		if v.arrow ~= nil then
			if not ARROW_STYLES[v.arrow] then return false, what .. ".arrow must be \"3d\", \"flat\", \"halo\" or \"hearth\"" end
			rec.arrow = v.arrow
		end
		if v.preset ~= nil then
			local pok, preset = readPreset(v.preset)
			if not pok then return false, what .. ": " .. tostring(preset) end
			rec.preset = preset
		end
		ok, why = readArtTint(v.artTint, what .. ".artTint")
		if not ok then return false, why end
		rec.artTint = why
		ok, why = readShadow(v.shadow, what .. ".shadow")
		if not ok then return false, why end
		rec.shadow = why
		ids[#ids + 1] = v.id
		by[v.id] = rec
	end
	local default = spec.defaultVariant
	if default == nil then
		default = ids[1]
	elseif not by[default] then
		return false, "defaultVariant must be one of the variants' ids"
	end
	return true, ids, by, default
end

local function registerSkin(id, spec)
	if type(spec) ~= "table" then return false, "the spec must be a table" end
	local ok, why = fieldsCheck(spec, SKIN_FIELDS)
	if ok then ok, why = idCheck(id, SKINS[id] and (SKINS[id].addon or "Polestar")) end
	if ok then ok, why = metaCheck(spec) end
	if not ok then return false, why end
	local base = spec.base or "polestar"
	if not (SKINS[base] and SKINS[base].builtin) then
		return false, "base must be one of Polestar's skins: polestar, halo, hearth, forever, blizzard, classic"
	end
	if spec.scheme ~= nil then
		if base ~= "polestar" then return false, "scheme goes with base \"polestar\" (the other looks bring their own grounds)" end
		if not (type(spec.scheme) == "string" and SCHEMES[spec.scheme] and SCHEME_INFO[spec.scheme]) then
			return false, format("scheme %q is not registered (register it first)", tostring(spec.scheme))
		end
	end
	local tokens
	tokens, why = readTokens(spec.tokens, "tokens")
	if not tokens then return false, why end
	local fontKey, family
	ok, fontKey, family = readFont(spec.font, id)
	if not ok then return false, fontKey end
	ok, why = readMap(spec.fontSizes, "fontSizes", ROLES, function(v) return type(v) == "number" and v >= 6 and v <= 40 end)
	if ok then
		ok, why = readMap(spec.icons, "icons", nil, isString)
	end
	if ok then ok, why = readMap(spec.media, "media", SKIN_MEDIA, isString) end
	if ok then ok, why = readMap(spec.paint, "paint", PAINT_KINDS, isFunction) end
	if ok then ok, why = readMap(spec.hooks, "hooks", HOOKS, isFunction) end
	if not ok then return false, why end
	if spec.textShadow ~= nil and spec.textShadow ~= false then
		local s = spec.textShadow
		if type(s) ~= "table" or type(s[1]) ~= "number" or type(s[2]) ~= "number" or type(s[3]) ~= "number" then
			return false, "textShadow must be { x, y, alpha } or false"
		end
	end
	if spec.arrow ~= nil and not ARROW_STYLES[spec.arrow] then return false, "arrow must be \"3d\", \"flat\", \"halo\" or \"hearth\"" end
	if spec.mapIcons ~= nil and not MAP_ICONS[spec.mapIcons] then return false, "mapIcons must be \"polestar\", \"halo\" or \"hearth\"" end
	local preset
	ok, preset = readPreset(spec.preset)
	if not ok then return false, preset end
	for _, k in ipairs({ "onApply", "onLeave", "resolve" }) do
		if spec[k] ~= nil and type(spec[k]) ~= "function" then return false, k .. " must be a function" end
	end
	local shadow, artTint, variantIds, variantBy, defaultVariant
	ok, shadow = readShadow(spec.shadow, "shadow")
	if not ok then return false, shadow end
	ok, artTint = readArtTint(spec.artTint, "artTint")
	if not ok then return false, artTint end
	ok, variantIds, variantBy, defaultVariant = readVariants(spec)
	if not ok then return false, variantIds end
	-- What the text sits on: the skin's palette with the house's subject
	-- colours (a skin on the house style: its scheme, else Dusk).
	local pal = {}
	for k, c in pairs(SHARED) do pal[k] = c end
	local under = base == "polestar" and SCHEMES[spec.scheme or "dusk"] or SKIN_PALETTES[base]
	for k, c in pairs(under) do pal[k] = c end
	for k, c in pairs(tokens) do pal[k] = c end
	local fixed, note, corrected = legibleGrounds(pal, spec.strict)
	if not fixed then return false, note end
	if corrected then
		for _, g in ipairs(Theme.GROUNDS) do tokens[g] = fixed[g] end
	end
	-- Each variant's grounds held to the same rule, on the look it is drawn
	-- from, with the skin's tokens and its own over it.
	for i, vid in ipairs(variantIds or {}) do
		local v = variantBy[vid]
		if v.base or v.scheme or v.tokens then
			local vbase = v.base or base
			local vpal = {}
			for k, c in pairs(SHARED) do vpal[k] = c end
			for k, c in pairs(vbase == "polestar" and SCHEMES[v.scheme or spec.scheme or "dusk"] or SKIN_PALETTES[vbase]) do vpal[k] = c end
			for k, c in pairs(tokens) do vpal[k] = c end
			for k, c in pairs(v.tokens or {}) do vpal[k] = c end
			local vfixed, vnote, vcorrected = legibleGrounds(vpal, spec.strict)
			if not vfixed then return false, format("variants[%d]: %s", i, vnote) end
			if vcorrected then
				v.tokens = v.tokens or {}
				for _, g in ipairs(Theme.GROUNDS) do v.tokens[g] = vfixed[g] end
				vnote = format("variants[%d]: %s", i, vnote)
				note = note and (note .. "; " .. vnote) or vnote
			end
		end
	end
	local s = { id = id, base = base }
	s.name, s.addon, s.author, s.version, s.desc = spec.name, spec.addon, spec.author, spec.version, spec.desc
	s.scheme, s.tokens, s.arrow, s.mapIcons = spec.scheme, tokens, spec.arrow, spec.mapIcons
	s.paint, s.hooks, s.onApply, s.onLeave, s.preset = spec.paint, spec.hooks, spec.onApply, spec.onLeave, preset
	s.resolve, s.shadow, s.artTint = spec.resolve, shadow, artTint
	s.variants, s.variantBy, s.defaultVariant = variantIds, variantBy, defaultVariant
	if spec.media then
		s.media = {}
		for k, v in pairs(spec.media) do s.media[k] = v end
	end
	-- Only what the skin gives itself: the rest is read from the look it is
	-- drawn from now (Theme.SkinKey: its base, or its variant's).
	if family then FAMILIES[fontKey] = family end
	SKIN_FONT[id] = fontKey
	local roles = {}
	for role, size in pairs(spec.fontSizes or {}) do roles[role] = { ROLES[role][1], size } end
	SKIN_ROLES[id] = roles
	if spec.textShadow == false then
		SKIN_SHADOW[id] = { 0, 0, 0 }
	elseif spec.textShadow then
		SKIN_SHADOW[id] = { spec.textShadow[1], spec.textShadow[2], spec.textShadow[3] }
	end
	local icons = {}
	for k, v in pairs(spec.icons or {}) do icons[k] = v end
	SKIN_ICON[id] = icons
	SKINS[id] = s
	local listed = false
	for _, k in ipairs(Theme.SKIN_ORDER) do if k == id then listed = true end end
	if not listed then Theme.SKIN_ORDER[#Theme.SKIN_ORDER + 1] = id end
	if note then report("skin", id, spec, note) end
	-- A saved choice waiting for this skin (its addon loaded late) shows now.
	if get("ui.skin") == id then Theme.Refresh() end
	return true, note
end

-- The checks, to Theme/SkinApi.lua's RegisterScheme and RegisterSkin; the
-- resolver (Theme.lua) reads a resolver's tokens and font with these.
I.register = { scheme = registerScheme, skin = registerSkin }
I.provide(readTokens, readFont)
