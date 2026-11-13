-- The Skin API: other addons' colour schemes and skins (docs/skins), split from
-- Theme/Theme.lua, whose locals it reads through ns.ThemeInternal. What
-- Polestar needs at login lives here: the version and the capabilities, the
-- built-in schemes and skins, the hooks' dispatch and the facts a picker
-- shows. The checks a scheme or skin from another addon goes through (its
-- fields, colours, legibility, variants, preset) load on demand with the
-- first one registered (Polestar_SkinAPI/SkinCheck.lua), and the settings
-- window's side of the API (the picker's cards, a preset applied and undone)
-- loads with the settings (Polestar_Options/Theme/SkinPicker.lua): a player
-- who uses no other addon's skin loads neither.

local _, ns = ...
local Theme = ns.Theme
local I = ns.ThemeInternal
local FAILED, SCHEME_INFO, SKINS = I.FAILED, I.SCHEME_INFO, I.SKINS
local failSkin, field, format, get, ipairs, pairs, pcall = I.failSkin, I.field, I.format, I.get, I.ipairs, I.pairs, I.pcall
local resolve, switchSkin, type, variantOf = I.resolve, I.switchSkin, I.type, I.variantOf

---------------------------------------------------------------------------
-- The Skin API (docs/skins/reference.md): other addons add colour schemes
-- and skins without touching Polestar.
--   Theme.RegisterScheme(id, spec) -> ok, message
--   Theme.RegisterSkin(id, spec)   -> ok, message
-- ok false: refused, message says why. ok true: message is nil, or says
-- what was corrected (grounds darkened until the text reads). A skin's
-- painters and hooks run under pcall: the first error is noted, the skin
-- is off for the session and the house style stands in (failSkin).
---------------------------------------------------------------------------

Theme.API_VERSION = 2

-- The surfaces a skin may paint: the kinds of Theme.Skin (a window marked
-- psGuide is the guide window, psLight a toast).
local PAINT_KINDS = { window = true, guide = true, toast = true, panel = true, sidebar = true, inset = true, button = true,
	dropdown = true, tile = true, editbox = true, checkbox = true, tab = true, close = true, scrollbar = true }
-- The art modules paint themselves and hand their frames to a skin's hook
-- (Theme.SkinHook), after Polestar's own look is on:
--   the guide window (Skin API 2): its title (guideTitle), a goal row once
--   painted (guideRow), its layout (guideLayout: room of the skin's own
--   under the window's parts), the step on screen (guideRender), its
--   progress (guideProgress), the frame the heads-up card sits on
--   (guideAnchor), each tab of its strip (guideTab), a part the skin
--   places itself (guidePlace) and its menu (guideMenu);
--   the arrow (arrow), the map and minimap pins (pin), the cards on the
--   guide window (card: the heads-up card, the class quest card), the
--   toasts (toast: the rare alert, the transport banner, While you're here)
--   and the buttons Polestar puts on the screen (actionButton).
local HOOKS = { arrow = true, pin = true, guideTitle = true, guideRow = true, guideLayout = true, guideRender = true,
	guideProgress = true, guideAnchor = true, guideTab = true, guidePlace = true, guideMenu = true, card = true, toast = true,
	actionButton = true }
-- The checks read them too (Polestar_SkinAPI/SkinCheck.lua).
I.PAINT_KINDS, I.HOOKS = PAINT_KINDS, HOOKS

local CAPABILITIES = {}
for _, c in ipairs({ "schemes", "skins", "tokens", "legibility", "fonts", "fontSizes", "textShadow", "icons", "media.band",
	"media.bandStars", "media.medallion", "arrow.style", "mapIcons", "events", "preview", "preset", "lightSchemes", "guideParts",
	-- Skin API 2
	"variants", "resolve", "shadow", "artTint", "media.dart", "tokens.accent2", "tokens.glow", "tokens.pins",
	"kit.glow", "kit.gameArt", "kit.crossfade", "kit.tintArt", "kit.gradient.horizontal", "kit.color",
	"media.pins", "arrow.parts", "pin.parts", "skins.installed", "theme.functions" }) do CAPABILITIES[c] = true end
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

-- The surfaces a skin can reach, sorted: the painter kinds (spec.paint) and
-- the hooks (spec.hooks). -> { paint = { kind, ... }, hooks = { name, ... } }
function Theme.SkinSurfaces()
	local paint, hooks = {}, {}
	for k in pairs(PAINT_KINDS) do paint[#paint + 1] = k end
	for k in pairs(HOOKS) do hooks[#hooks + 1] = k end
	table.sort(paint)
	table.sort(hooks)
	return { paint = paint, hooks = hooks }
end

-- A registration's note or refusal, in the debug log (/polestar debug).
local function report(kind, id, spec, msg)
	if ns.Debug then ns.Debug(format("%s %s (%s): %s", kind, tostring(id), type(spec) == "table" and tostring(spec.addon) or "?", msg)) end
end
I.report = report

-- The checks a scheme or skin from another addon goes through, loaded with
-- the first one registered (it registers them as I.register). -> the checks,
-- or nil when the addon holding them is missing or disabled.
local CHECKS = "Polestar_SkinAPI"
local MISSING = "the Skin API's checks did not load (is the " .. CHECKS .. " folder installed and enabled?)"
local function checks()
	if I.register then return I.register end
	local A = C_AddOns
	local load = A and A.LoadAddOn or LoadAddOn
	if load then pcall(load, CHECKS) end
	return I.register
end

-- Register colour scheme `id` (spec: docs/skins/reference.md, "RegisterScheme").
function Theme.RegisterScheme(id, spec)
	local c = checks()
	local ok, msg
	if c then ok, msg = c.scheme(id, spec) else ok, msg = false, MISSING end
	if not ok then report("scheme", id, spec, "refused: " .. tostring(msg)) end
	return ok, msg
end

-- Register skin `id` (spec: docs/skins/reference.md, "RegisterSkin").
local refusedSaid = {} -- skin id -> the player was told it could not come
function Theme.RegisterSkin(id, spec)
	local c = checks()
	local ok, msg
	if c then ok, msg = c.skin(id, spec) else ok, msg = false, MISSING end
	if not ok then
		report("skin", id, spec, "refused: " .. tostring(msg))
		-- The player chose this skin (it is saved), none came, and this one
		-- cannot: say so once, naming the addon, so it reaches its author.
		if type(id) == "string" and get("ui.skin") == id and not SKINS[id] and not refusedSaid[id] and ns.Print and ns.L then
			refusedSaid[id] = true
			local addon = type(spec) == "table" and type(spec.addon) == "string" and spec.addon or "?"
			ns.Print(format(ns.L["The skin %s (from %s) could not be added: %s. Polestar's own look stands in."], id, addon, tostring(msg)))
		end
	end
	return ok, msg
end

-- A registered skin's or scheme's public facts (name, addon, author,
-- version, desc, base, scheme, the Skin API version it was written for), or
-- nil.
function Theme.SkinInfo(id)
	local s = SKINS[id]
	if not s then return nil end
	return { id = id, name = s.builtin and s.label() or s.name, addon = s.addon, author = s.author, version = s.version,
		desc = s.desc, base = s.base, scheme = s.scheme, builtin = s.builtin or false, failed = FAILED[id],
		api = s.builtin and Theme.API_VERSION or s.api }
end

-- A registered skin's variants (spec.variants, Skin API 2) for its picker:
-- a list of { id, name, desc } in the skin's order, or nil when it has none.
-- The player's pick is ui.skinVariants.<skin id>.
function Theme.SkinVariants(id)
	local s = SKINS[id]
	if not (s and s.variants) then return nil end
	local out = {}
	for i, vid in ipairs(s.variants) do
		local v = s.variantBy[vid]
		out[i] = { id = vid, name = v.name, desc = v.desc }
	end
	return out
end

-- The variant of skin `id` in use: the player's pick while the skin has it,
-- else the skin's default; nil for a skin without variants.
function Theme.SkinVariant(id)
	local s = SKINS[id]
	return s and variantOf(s) or nil
end

function Theme.SchemeInfo(id)
	local i = SCHEME_INFO[id]
	if not i then return nil end
	return { id = id, name = i.builtin and i.label() or i.name, addon = i.addon, author = i.author, version = i.version,
		desc = i.desc, builtin = i.builtin or false, api = i.builtin and Theme.API_VERSION or i.api }
end

-- The scheme the skin in use brings (its spec.scheme), or nil: while it is
-- set the player's scheme has no effect.
function Theme.SkinScheme()
	local s = SKINS[Theme.SkinId()]
	return s and not s.builtin and field(s, "scheme") or nil
end

-- The arrow style ("skin" in nav.arrowStyle) and the map icon pack ("skin"
-- in nav.mapIcons) the skin in use picks, or nil for its base look's.
function Theme.SkinArrowStyle()
	local s = SKINS[Theme.SkinId()]
	return s and not s.builtin and field(s, "arrow") or nil
end

function Theme.SkinMapIcons()
	local s = SKINS[Theme.SkinId()]
	return s and s.mapIcons or nil
end

-- The hooks of the skin in use (a registered skin's spec.hooks), set as the
-- skin in use changes (Theme.lua's switchSkin, at the start of every
-- Theme.Refresh): a point no skin hooks costs one lookup.
local liveId, liveHooks
I.onSwitch = function(id)
	local s = SKINS[id]
	liveId, liveHooks = id, s and not s.builtin and s.hooks or nil
end

-- A module's own art handed to the skin in use, after the module painted it
-- (the hooks above: Nav/Arrow.lua "arrow", Nav/Pins.lua "pin", UI/Toasts.lua
-- "card" and "toast", QoL/Buttons.lua "actionButton", the guide window's).
-- -> true when a hook ran
function Theme.SkinHook(surface, ...)
	local fn = liveHooks and liveHooks[surface]
	if not fn or FAILED[liveId] then return false end
	local ok, err = pcall(fn, ...)
	if not ok then
		failSkin(liveId, err)
		return false
	end
	return true
end

-- The skin's hook for `surface` with its answer: -> true, its first result
-- when the hook ran (false and nothing when there is none or it failed, the
-- skin then off as with Theme.SkinHook).
function Theme.SkinHookValue(surface, ...)
	local fn = liveHooks and liveHooks[surface]
	if not fn or FAILED[liveId] then return false end
	local ok, v = pcall(fn, ...)
	if not ok then
		failSkin(liveId, v)
		return false
	end
	return true, v
end

-- Whether the skin in use hooks `surface` (a module may skip the work of
-- handing over its parts when none does).
function Theme.SkinHooks(surface)
	return liveHooks ~= nil and liveHooks[surface] ~= nil and not FAILED[liveId]
end

-- The guide window's parts for a skin's hooks and its own frames (Skin API 2,
-- capability "guideParts"): window, strip (tabs), nav (the step bar), body,
-- card (the step), person (its header), goals (the scroll of goal rows), rows
-- (the goal rows, pooled), tip, after ("Then:"), along, upnext, empty, banner,
-- foot (the progress), here (While you're here). Frames to place things by
-- and to restyle; nil before the window is built. One table, made once.
local guideParts
function Theme.GuideParts()
	if guideParts then return guideParts end
	local G = ns.UI and ns.UI.GuideFrame
	local p = G and G.parts
	if not (p and G.frame) then return nil end
	guideParts = { window = G.frame, rows = G.rows }
	for k, v in pairs(p) do guideParts[k] = v end
	return guideParts
end

-- The palette skin `id` would give, with the player's own colours (a card's
-- preview; the palette in use is Theme.Palette()).
function Theme.PaletteFor(id)
	if not SKINS[id] then return nil end
	return resolve(id)
end

---------------------------------------------------------------------------
-- Installed skin addons (capability "skins.installed"). A skin addon names
-- the skins and schemes it registers in its TOC, as a guide pack names
-- itself with X-Polestar-Pack:
--   ## X-Polestar-Skin: hairline        (several: "hairline, hairline-dark")
-- With that line it may load on demand (## LoadOnDemand: 1) and cost nothing
-- until one of its skins is wanted: Polestar loads it at login when the
-- saved skin or scheme is one of its own, when the player picks one, and
-- when the settings list the skins (Theme.SkinChoices) so its cards show.
---------------------------------------------------------------------------

-- Every installed addon that declares skins, loaded or not:
-- -> { { addon, title, notes, ids = { id, ... }, loaded, reason }, ... };
-- reason is the client's ("DISABLED", "INTERFACE_VERSION", "DEP_MISSING"...)
-- when it cannot load, nil when it is loaded or can load.
function Theme.InstalledSkins()
	local A = C_AddOns
	local out = {}
	if not (A and A.GetNumAddOns and A.GetAddOnInfo and A.GetAddOnMetadata) then return out end
	for i = 1, A.GetNumAddOns() do
		local name, title, notes, loadable, reason = A.GetAddOnInfo(i)
		local declared = type(name) == "string" and A.GetAddOnMetadata(name, "X-Polestar-Skin") or nil
		if type(declared) == "string" then
			local ids = {}
			for id in declared:gmatch("[^,%s]+") do ids[#ids + 1] = id end
			if #ids > 0 then
				local loaded = A.IsAddOnLoaded and A.IsAddOnLoaded(name) and true or false
				out[#out + 1] = { addon = name, title = title or name, notes = notes, ids = ids, loaded = loaded,
					reason = not loaded and not loadable and (reason or "DISABLED") or nil }
			end
		end
	end
	return out
end

-- Loads (out of combat; in a fight, once it ends) installed skin addon rec,
-- which is not loaded and can load. -> ok, why
local waiting = {} -- addon -> waits for the fight to end
local function afterFight()
	if ns.UnregisterEvent then ns.UnregisterEvent("PLAYER_REGEN_ENABLED", afterFight) end
	local list = waiting
	waiting = {}
	for name in pairs(list) do C_AddOns.LoadAddOn(name) end
end
local function loadSkinAddon(rec)
	if InCombatLockdown and InCombatLockdown() then
		if not next(waiting) and ns.RegisterEvent then ns.RegisterEvent("PLAYER_REGEN_ENABLED", afterFight) end
		waiting[rec.addon] = true
		return false, "in combat: it loads once the fight ends"
	end
	local ok, why = C_AddOns.LoadAddOn(rec.addon)
	if not ok then
		report("skin addon", rec.addon, nil, "did not load: " .. tostring(why))
		return false, tostring(why or "it did not load")
	end
	return true
end

-- Load the installed addon that declares skin (or scheme) `id`, when it is
-- not loaded and can be. -> ok (registered now, or already), why
function Theme.LoadSkinAddon(id)
	if SKINS[id] or SCHEME_INFO[id] then return true end
	for _, rec in ipairs(Theme.InstalledSkins()) do
		for _, x in ipairs(rec.ids) do
			if x == id then
				if rec.loaded then return false, "its addon " .. rec.addon .. " is loaded but did not register it" end
				if rec.reason then return false, rec.reason end
				local ok, why = loadSkinAddon(rec)
				if not ok then return false, why end
				if SKINS[id] or SCHEME_INFO[id] then return true end
				return false, "its addon " .. rec.addon .. " loaded but did not register it"
			end
		end
	end
	return false, "no installed addon declares it (## X-Polestar-Skin)"
end

-- Every installed skin addon that can load, loaded (once a session, out of
-- combat), so the settings' picker shows all of them. -> how many loaded
local loadedAll = false
function Theme.LoadInstalledSkins()
	if loadedAll or (InCombatLockdown and InCombatLockdown()) then return 0 end
	loadedAll = true
	local n = 0
	for _, rec in ipairs(Theme.InstalledSkins()) do
		if not rec.loaded and not rec.reason and loadSkinAddon(rec) then n = n + 1 end
	end
	return n
end

-- The saved skin and scheme, and the player's pick, from an addon not loaded
-- yet: load it (it registers, and the choice shows).
local function wantSaved()
	local skin, scheme = get("ui.skin"), get("ui.scheme")
	if type(skin) == "string" and not SKINS[skin] then Theme.LoadSkinAddon(skin) end
	if type(scheme) == "string" and not SCHEME_INFO[scheme] and scheme ~= "ellesmere" then Theme.LoadSkinAddon(scheme) end
end
if ns.OnLogin then ns.OnLogin(wantSaved) end
if ns.On then
	ns.On("SETTING_CHANGED", function(path)
		if path == "ui.skin" or path == "ui.scheme" or path == "ui" or path == "" then
			if not (ns.IsLoggedIn and not ns.IsLoggedIn()) then wantSaved() end
		end
	end)
end

-- The built-in schemes and skins (their tokens are Theme.lua's tables;
-- Polestar_Looks/GameSkins.lua adds the game looks' painters), taken as they are:
-- tests/theme holds each to the legibility rule, so login checks nothing.
local BUILTIN_SCHEME_LABEL = {
	dusk = function() return ns.L["Dusk"] end,
	night = function() return ns.L["Night"] end,
	graphite = function() return ns.L["Graphite"] end,
}
local BUILTIN_SKIN_LABEL = {
	polestar = function() return ns.L["Polestar"] end,
	halo = function() return ns.L["Halo"] end,
	hearth = function() return ns.L["Hearth"] end,
	forever = function() return ns.L["WoW Forever"] end,
	blizzard = function() return ns.L["Blizzard"] end,
	classic = function() return ns.L["Classic"] end,
}
for id, label in pairs(BUILTIN_SCHEME_LABEL) do SCHEME_INFO[id] = { id = id, builtin = true, label = label } end
for id, label in pairs(BUILTIN_SKIN_LABEL) do SKINS[id] = { id = id, base = id, builtin = true, label = label } end
-- A skin chosen before login runs its onApply once settings are read.
if ns.OnLogin then ns.OnLogin(switchSkin) end
