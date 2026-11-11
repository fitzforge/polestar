-- The Skin API: other addons' colour schemes and skins (docs/skins), split from
-- Theme/Theme.lua, whose locals it reads through ns.ThemeInternal.

local ADDON, ns = ...
local Theme = ns.Theme
local I = ns.ThemeInternal
local ART, BRAND, DEFAULT_ACCENT, FAILED, FAMILIES, GAME_SKINS = I.ART, I.BRAND, I.DEFAULT_ACCENT, I.FAILED, I.FAMILIES, I.GAME_SKINS
local HOUSE_EXTRA, METRICS, RIVALS, ROLES, SCHEMES, SCHEME_INFO = I.HOUSE_EXTRA, I.METRICS, I.RIVALS, I.ROLES, I.SCHEMES, I.SCHEME_INFO
local SCHEME_WASH, SHARED, SKINS, SKIN_FONT, SKIN_ICON, SKIN_PALETTES = I.SCHEME_WASH, I.SHARED, I.SKINS, I.SKIN_FONT, I.SKIN_ICON, I.SKIN_PALETTES
local SKIN_ROLES, SKIN_SHADOW, WASH, copy, failSkin, floor = I.SKIN_ROLES, I.SKIN_SHADOW, I.WASH, I.copy, I.failSkin, I.floor
local format, gameFont, get, ipairs, isColor, isLight = I.format, I.gameFont, I.get, I.ipairs, I.isColor, I.isLight
local pairs, pcall, resolve, shifted, switchSkin, type = I.pairs, I.pcall, I.resolve, I.shifted, I.switchSkin, I.type
local batch = I.batch

---------------------------------------------------------------------------
-- The Skin API (docs/SKINS-API.md): other addons add colour schemes and
-- skins without touching Polestar, and the built-in ones register through
-- the same two functions.
--   Theme.RegisterScheme(id, spec) -> ok, message
--   Theme.RegisterSkin(id, spec)   -> ok, message
-- ok false: refused, message says why. ok true: message is nil, or says
-- what was corrected (grounds darkened until the text reads). A skin's
-- painters and hooks run under pcall: the first error is noted, the skin
-- is off for the session and the house style stands in (failSkin above).
---------------------------------------------------------------------------

Theme.API_VERSION = 1

-- The surfaces a skin may paint: the kinds of Theme.Skin (a window marked
-- psGuide is the guide window, psLight a toast), and the art modules paint
-- themselves and hand to a skin's hook (Theme.SkinHook).
local PAINT_KINDS = { window = true, guide = true, toast = true, panel = true, sidebar = true, inset = true, button = true,
	dropdown = true, tile = true, editbox = true, checkbox = true, tab = true, close = true, scrollbar = true }
local HOOKS = { arrow = true, pin = true, guideTitle = true }
local SKIN_MEDIA = { band = true, bandStars = true, medallion = true }
local ARROW_STYLES = { ["3d"] = true, flat = true, halo = true, hearth = true }
local MAP_ICONS = { polestar = true, halo = true, hearth = true }
local FONT_KEYS = { game = true, inter = true, fira = true, opensans = true }
-- The scheme tokens a scheme must give (the grounds and the text ladder),
-- and those it may (Dusk's stand in).
local SCHEME_NEEDS = { "bg", "panel", "panelAlt", "sidebar", "footer", "sky", "text", "textDim", "textMuted" }
local SCHEME_MAY = { "ink", "star", "shade", "scrim", "onAccent", "shadow" }

local CAPABILITIES = {}
for _, c in ipairs({ "schemes", "skins", "tokens", "legibility", "fonts", "fontSizes", "textShadow", "icons", "media.band",
	"media.bandStars", "media.medallion", "arrow.style", "mapIcons", "events", "preview", "preset", "lightSchemes" }) do CAPABILITIES[c] = true end
for kind in pairs(PAINT_KINDS) do CAPABILITIES["surfaces." .. kind] = true end
for name in pairs(HOOKS) do CAPABILITIES["surfaces." .. name] = true end

-- Whether this Polestar's Skin API has capability `name` ("skins",
-- "surfaces.arrow", ...): a skin can use a newer feature only where it is.
function Theme.HasCapability(name)
	return CAPABILITIES[name] == true
end

-- Every capability, sorted.
function Theme.Capabilities()
	local out = {}
	for c in pairs(CAPABILITIES) do out[#out + 1] = c end
	table.sort(out)
	return out
end

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
	mapIcons = true, paint = true, hooks = true, onApply = true, onLeave = true, strict = true, preset = true }

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

local function metaCheck(spec, builtin)
	local ok, why = apiCheck(spec)
	if not ok then return false, why end
	if not builtin then
		for _, f in ipairs({ { "name", true, "a name of 1-40 characters" }, { "addon", true, "your addon's folder name" },
			{ "author", false, "a string" }, { "version", false, "a string" }, { "desc", false, "a string of 200 characters at most" } }) do
			ok, why = textField(spec, f[1], f[2], f[3])
			if not ok then return false, why end
		end
	end
	return true
end

local function report(kind, id, spec, msg)
	if ns.Debug then ns.Debug(format("%s %s (%s): %s", kind, tostring(id), type(spec) == "table" and tostring(spec.addon) or "?", msg)) end
end

local BUILTIN_SCHEME_LABEL = {
	dusk = function() return ns.L["Dusk"] end,
	night = function() return ns.L["Night"] end,
	graphite = function() return ns.L["Graphite"] end,
}

local function registerScheme(id, spec, builtin)
	if type(spec) ~= "table" then return false, "the spec must be a table" end
	local ok, why = fieldsCheck(spec, SCHEME_FIELDS)
	if ok then
		local info = SCHEME_INFO[id]
		ok, why = idCheck(id, id == "ellesmere" and "EllesmereUI's" or info and (info.addon or "Polestar"))
	end
	if ok then ok, why = metaCheck(spec, builtin) end
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
	local fixed, note, corrected = legibleGrounds(pal, builtin or spec.strict)
	-- A built-in palette is taken as it is (tests/theme holds it to the rule).
	if not fixed and not builtin then return false, note end
	if corrected then
		for _, g in ipairs(Theme.GROUNDS) do tokens[g] = fixed[g] end
	end
	if builtin then
		SCHEME_INFO[id] = { id = id, builtin = true, label = BUILTIN_SCHEME_LABEL[id] }
	else
		SCHEMES[id] = tokens
		SCHEME_INFO[id] = { id = id, name = spec.name, addon = spec.addon, author = spec.author, version = spec.version,
			desc = spec.desc, accent = accent }
		if washes then SCHEME_WASH[id] = washes end
	end
	local listed = false
	for _, k in ipairs(Theme.SCHEME_ORDER) do if k == id then listed = true end end
	if not listed then Theme.SCHEME_ORDER[#Theme.SCHEME_ORDER + 1] = id end
	if note then report("scheme", id, spec, note) end
	-- A saved choice waiting for this scheme shows now.
	if not builtin and (get("ui.scheme") == id or (SKINS[Theme.SkinId()] or {}).scheme == id) then Theme.Refresh() end
	return true, note
end

-- Register colour scheme `id` (spec: docs/SKINS-API.md, "RegisterScheme").
function Theme.RegisterScheme(id, spec)
	local ok, msg = registerScheme(id, spec, false)
	if not ok then report("scheme", id, spec, "refused: " .. tostring(msg)) end
	return ok, msg
end

local BUILTIN_SKIN_LABEL = {
	polestar = function() return ns.L["Polestar"] end,
	halo = function() return ns.L["Halo"] end,
	hearth = function() return ns.L["Hearth"] end,
	forever = function() return ns.L["WoW Forever"] end,
	blizzard = function() return ns.L["Blizzard"] end,
	classic = function() return ns.L["Classic"] end,
}

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

local function registerSkin(id, spec, builtin)
	if type(spec) ~= "table" then return false, "the spec must be a table" end
	local ok, why = fieldsCheck(spec, SKIN_FIELDS)
	if ok then ok, why = idCheck(id, SKINS[id] and (SKINS[id].addon or "Polestar")) end
	if ok then ok, why = metaCheck(spec, builtin) end
	if not ok then return false, why end
	local base = spec.base or "polestar"
	if builtin then
		base = id
	elseif not (SKINS[base] and SKINS[base].builtin) then
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
	for _, k in ipairs({ "onApply", "onLeave" }) do
		if spec[k] ~= nil and type(spec[k]) ~= "function" then return false, k .. " must be a function" end
	end
	-- What the text sits on: the skin's palette with the house's subject
	-- colours (a skin on the house style: its scheme, else Dusk).
	local pal = {}
	for k, c in pairs(SHARED) do pal[k] = c end
	local under = base == "polestar" and SCHEMES[spec.scheme or "dusk"] or SKIN_PALETTES[base]
	for k, c in pairs(under) do pal[k] = c end
	for k, c in pairs(tokens) do pal[k] = c end
	local fixed, note, corrected = legibleGrounds(pal, builtin or spec.strict)
	if not fixed and not builtin then return false, note end
	if corrected then
		for _, g in ipairs(Theme.GROUNDS) do tokens[g] = fixed[g] end
	end
	local s = { id = id, base = base, builtin = builtin or nil }
	if builtin then
		s.label = BUILTIN_SKIN_LABEL[id]
	else
		s.name, s.addon, s.author, s.version, s.desc = spec.name, spec.addon, spec.author, spec.version, spec.desc
		s.scheme, s.tokens, s.arrow, s.mapIcons = spec.scheme, tokens, spec.arrow, spec.mapIcons
		s.paint, s.hooks, s.onApply, s.onLeave, s.preset = spec.paint, spec.hooks, spec.onApply, spec.onLeave, preset
		if spec.media then
			s.media = {}
			for k, v in pairs(spec.media) do s.media[k] = v end
		end
		-- The look it extends, under its own choices.
		if base ~= "polestar" then
			local merged = {}
			for k, c in pairs(SKIN_PALETTES[base]) do merged[k] = c end
			for k, c in pairs(tokens) do merged[k] = c end
			SKIN_PALETTES[id] = merged
		end
		if family then FAMILIES[fontKey] = family end
		SKIN_FONT[id] = fontKey or SKIN_FONT[base]
		local roles = setmetatable({}, { __index = SKIN_ROLES[base] })
		for role, size in pairs(spec.fontSizes or {}) do roles[role] = { ROLES[role][1], size } end
		SKIN_ROLES[id] = roles
		if spec.textShadow == false then
			SKIN_SHADOW[id] = { 0, 0, 0 }
		else
			SKIN_SHADOW[id] = spec.textShadow and { spec.textShadow[1], spec.textShadow[2], spec.textShadow[3] } or SKIN_SHADOW[base]
		end
		local icons = {}
		for k, v in pairs(SKIN_ICON[base] or {}) do icons[k] = v end
		for k, v in pairs(spec.icons or {}) do icons[k] = v end
		SKIN_ICON[id] = icons
		METRICS[id] = METRICS[base]
		GAME_SKINS[id] = GAME_SKINS[base]
	end
	SKINS[id] = s
	local listed = false
	for _, k in ipairs(Theme.SKIN_ORDER) do if k == id then listed = true end end
	if not listed then Theme.SKIN_ORDER[#Theme.SKIN_ORDER + 1] = id end
	if note then report("skin", id, spec, note) end
	-- A saved choice waiting for this skin (its addon loaded late) shows now.
	if not builtin and get("ui.skin") == id then Theme.Refresh() end
	return true, note
end

-- Register skin `id` (spec: docs/SKINS-API.md, "RegisterSkin").
function Theme.RegisterSkin(id, spec)
	local ok, msg = registerSkin(id, spec, false)
	if not ok then report("skin", id, spec, "refused: " .. tostring(msg)) end
	return ok, msg
end

-- A registered skin's or scheme's public facts (name, addon, author,
-- version, desc, base, scheme), or nil.
function Theme.SkinInfo(id)
	local s = SKINS[id]
	if not s then return nil end
	return { id = id, name = s.builtin and s.label() or s.name, addon = s.addon, author = s.author, version = s.version,
		desc = s.desc, base = s.base, scheme = s.scheme, builtin = s.builtin or false, failed = FAILED[id] }
end

function Theme.SchemeInfo(id)
	local i = SCHEME_INFO[id]
	if not i then return nil end
	return { id = id, name = i.builtin and i.label() or i.name, addon = i.addon, author = i.author, version = i.version,
		desc = i.desc, builtin = i.builtin or false }
end

-- The scheme the skin in use brings (its spec.scheme), or nil: while it is
-- set the player's scheme has no effect.
function Theme.SkinScheme()
	local s = SKINS[Theme.SkinId()]
	return s and s.scheme or nil
end

-- The arrow style ("skin" in nav.arrowStyle) and the map icon pack ("skin"
-- in nav.mapIcons) the skin in use picks, or nil for its base look's.
function Theme.SkinArrowStyle()
	local s = SKINS[Theme.SkinId()]
	return s and s.arrow or nil
end

function Theme.SkinMapIcons()
	local s = SKINS[Theme.SkinId()]
	return s and s.mapIcons or nil
end

-- A skin's preset (spec.preset): the settings it recommends, as a copy, or
-- nil. Never applied by itself: the player applies it (the Theme page's
-- "Apply <skin>'s layout") and may undo it.
local function copyValue(v)
	if type(v) ~= "table" then return v end
	local c = {}
	for k, x in pairs(v) do c[k] = x end
	return c
end

function Theme.SkinPreset(id)
	local s = SKINS[id]
	if not (s and s.preset) then return nil end
	local out = {}
	for path, v in pairs(s.preset) do out[path] = copyValue(v) end
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
	if not s.preset then return false, "this skin has no preset" end
	local undo = presetUndo or { values = {} }
	local function remember(path)
		if undo.values[path] == nil then
			local v = ns.Get(path)
			undo.values[path] = v == nil and false or copyValue(v)
		end
	end
	for path in pairs(s.preset) do
		remember(path)
		for _, rival in ipairs(RIVALS[path] or {}) do remember(rival) end
	end
	undo.id = id
	presetUndo = undo
	local ok, err = batch(function()
		for path, v in pairs(s.preset) do ns.Set(path, copyValue(v)) end
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

-- A module's own art handed to the skin in use (Nav/Arrow.lua: "arrow",
-- Nav/Pins.lua: "pin"), after the module painted it. -> true when a hook ran
function Theme.SkinHook(surface, ...)
	local id = Theme.SkinId()
	local s = SKINS[id]
	local fn = s and s.hooks and s.hooks[surface]
	if not fn then return false end
	local ok, err = pcall(fn, ...)
	if not ok then
		failSkin(id, err)
		return false
	end
	return true
end

-- The palette skin `id` would give, with the player's own colours (a card's
-- preview; the palette in use is Theme.Palette()).
function Theme.PaletteFor(id)
	if not SKINS[id] then return nil end
	return resolve(id)
end

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
-- the live skin is left alone. Call it again on every redraw.
function Theme.DrawSkinCard(card, id)
	local s = SKINS[id]
	if not s then return end
	local media = s.media or {}
	drawCard(card, resolve(id), cardFace(SKIN_FONT[id] or SKIN_FONT[s.base]), media.band or Theme.Media("band"),
		media.bandStars or Theme.Media("band-stars"))
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

-- The built-in schemes and skins, through the same registration (their
-- tokens are the tables above; Theme/GameSkins.lua adds the game looks'
-- painters). Each is held to the legibility rule as it is, never corrected.
for _, id in ipairs({ "dusk", "night", "graphite" }) do
	local ok, why = registerScheme(id, { tokens = SCHEMES[id] }, true)
	if not ok then error("Polestar scheme " .. id .. ": " .. tostring(why)) end
end
for _, id in ipairs({ "polestar", "halo", "hearth", "forever", "blizzard", "classic" }) do
	local ok, why = registerSkin(id, { tokens = id ~= "polestar" and SKIN_PALETTES[id] or nil }, true)
	if not ok then error("Polestar skin " .. id .. ": " .. tostring(why)) end
end
-- A skin chosen before login runs its onApply once settings are read.
if ns.OnLogin then ns.OnLogin(switchSkin) end

-- Theme.lua's resolver reads a resolver's tokens and font with these.
I.provide(readTokens, readFont)
