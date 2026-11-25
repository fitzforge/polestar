-- The Skin API: other addons' colour schemes and skins (docs/skins), split from
-- Theme/Theme.lua, whose locals it reads through ns.ThemeInternal. What
-- Polestar needs at login lives here: the version and the capabilities, the
-- built-in schemes and skins, the hooks' dispatch and the facts a picker
-- shows. The checks a scheme or skin from another addon goes through (its
-- fields, colours, legibility, variants, preset) are Theme/SkinCheck.lua,
-- loaded right after this file (their own folder before 0.4.3, #3507), and
-- the settings window's side of the API (the picker's cards, a preset
-- applied and undone) loads with the settings
-- (Polestar_Options/Theme/SkinPicker.lua).

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
--   Theme.RegisterLayout(id, spec) -> ok, message (the guide window's
--   structure alone, under any skin: "Layouts" below)
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
--   places itself (guidePlace), its menu (guideMenu), a goal the skin
--   shows on a card of its own, out of the window's list (guideTakes),
--   the step's header, laid out the skin's way (guidePerson), a part set
--   in from the window's left edge (guideInset), each Up next row
--   (guideUpRow), whether a part shows the skin's way (guideShows) and a
--   gap or height of its layout (guideSpace);
--   the arrow (arrow), the map and minimap pins (pin), the cards on the
--   guide window (card: the heads-up card, the class quest card), the
--   toasts (toast: the rare alert, the transport banner, While you're here)
--   and the buttons Polestar puts on the screen (actionButton).
local HOOKS = { arrow = true, pin = true, guideTitle = true, guideRow = true, guideLayout = true, guideRender = true,
	guideProgress = true, guideAnchor = true, guideTab = true, guidePlace = true, guideMenu = true, guideTakes = true, guidePerson = true,
	guideInset = true, guideUpRow = true, guideShows = true, guideSpace = true, card = true, toast = true,
	actionButton = true }
-- The hooks a layout may set: the guide window's structure (where its parts
-- sit, which show, how tall the step's header is, how the title bar and a
-- goal row are laid out, where the progress shows, its gaps), never its colours: a
-- layout's hook colours what it touches with the skin's tokens.
local LAYOUT_HOOKS = { guideLayout = true, guideRender = true, guidePlace = true, guideAnchor = true, guideTakes = true,
	guidePerson = true, guideInset = true, guideUpRow = true, guideShows = true, guideTitle = true, guideRow = true,
	guideProgress = true, guideSpace = true }
-- The registered layouts (Theme.RegisterLayout): id -> { id, name, addon,
-- author, version, desc, api, hooks, onApply, onLeave, defaults, preset }.
local LAYOUTS, LAYOUT_FAILED = {}, {}
-- The checks read them too (Theme/SkinCheck.lua).
I.PAINT_KINDS, I.HOOKS, I.LAYOUT_HOOKS, I.LAYOUTS = PAINT_KINDS, HOOKS, LAYOUT_HOOKS, LAYOUTS

local CAPABILITIES = {}
for _, c in ipairs({ "schemes", "skins", "tokens", "legibility", "fonts", "fontSizes", "textShadow", "icons", "media.band",
	"media.bandStars", "media.medallion", "arrow.style", "mapIcons", "events", "preview", "preset", "lightSchemes", "guideParts",
	-- Skin API 2
	"variants", "resolve", "shadow", "artTint", "media.dart", "tokens.accent2", "tokens.glow", "tokens.pins",
	"kit.glow", "kit.gameArt", "kit.crossfade", "kit.tintArt", "kit.gradient.horizontal", "kit.color",
	"media.pins", "arrow.parts", "pin.parts", "skins.installed", "theme.functions", "layouts", "layouts.preset", "guideReach" }) do CAPABILITIES[c] = true end
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

-- The checks a scheme, skin or layout goes through: Theme/SkinCheck.lua
-- registers them as I.register as it loads, right after this file.

-- Register colour scheme `id` (spec: docs/skins/reference.md, "RegisterScheme").
function Theme.RegisterScheme(id, spec)
	local ok, msg = I.register.scheme(id, spec)
	if not ok then report("scheme", id, spec, "refused: " .. tostring(msg)) end
	return ok, msg
end

-- Register skin `id` (spec: docs/skins/reference.md, "RegisterSkin").
local refusedSaid = {} -- skin id -> the player was told it could not come
function Theme.RegisterSkin(id, spec)
	local ok, msg = I.register.skin(id, spec)
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

-- Register layout `id` (spec: docs/skins/reference.md, "RegisterLayout").
function Theme.RegisterLayout(id, spec)
	local ok, msg = I.register.layout(id, spec)
	if not ok then report("layout", id, spec, "refused: " .. tostring(msg)) end
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

-- The hooks of the layout in use (a registered layout's spec.hooks), set as
-- the saved layout (ui.layout) changes: nil is Polestar's own layout.
local layoutId, layoutHooks

-- The layout's defaults for the guide window's settings (spec.defaults) in
-- place of Polestar's, under the player's own: each setting whose value
-- changes with them is announced (SETTING_CHANGED), so the window and the
-- settings show it. A setting the player set keeps its value.
local liveDefaults
local function applyDefaults(defs)
	if not ns.SetLayoutDefaults then return end
	local paths, old = {}, {}
	for p in pairs(liveDefaults or {}) do paths[p] = true end
	for p in pairs(defs or {}) do paths[p] = true end
	for p in pairs(paths) do old[p] = ns.Get(p) end
	ns.SetLayoutDefaults(defs)
	liveDefaults = defs
	for p in pairs(paths) do
		local v = ns.Get(p)
		if v ~= old[p] and ns.Fire then ns.Fire("SETTING_CHANGED", p, v) end
	end
end

-- A layout's hook or its onApply or onLeave failed: noted, and the layout is
-- off for the session (Polestar's own layout, or the skin's hooks, stand in
-- from the next draw).
local function failLayout(id, err)
	if LAYOUT_FAILED[id] then return end
	LAYOUT_FAILED[id] = tostring(err)
	local l = LAYOUTS[id]
	if ns.NoteError then ns.NoteError(format("layout %s (%s): %s", tostring(id), l and tostring(l.addon) or "?", tostring(err))) end
	if layoutId == id then
		layoutId, layoutHooks = nil, nil
		applyDefaults(nil)
		if ns.After then ns.After(0, function() Theme.Refresh() end) end
	end
end

-- The hooks where a skin styles what the layout lays out: the layout's hook
-- runs first, then the skin's, with the same parts. The layout's answer wins
-- when it is not nil; the skin's counts when the layout's is nil, except for
-- guidePlace, where the layout alone decides the placement. Every other hook
-- is the layout's where it has one, else the skin's.
local BOTH = { guideTitle = true, guideRow = true, guideRender = true, guidePlace = true, guideProgress = true }
local LAYOUT_DECIDES = { guidePlace = true }

-- The layout a window draws with: `choice` nil is the layout in use (the
-- live window, the settings' preview), false Polestar's own (no layout's
-- hooks), an id that layout's, while it is registered and has not failed
-- (Polestar's own until then). -> id, hooks | nil
local function layoutOf(choice)
	if choice == nil then return layoutId, layoutHooks end
	local l = choice and not LAYOUT_FAILED[choice] and LAYOUTS[choice]
	if l then return choice, l.hooks end
	return nil, nil
end

-- The hook that answers for `surface` under layout hooks `lhooks`: the
-- layout's, else the skin's. -> fn, whose (true: the layout's) | nil
local function hookFor(surface, lhooks)
	local fn = lhooks and lhooks[surface]
	if fn then return fn, true end
	fn = liveHooks and liveHooks[surface]
	if fn and not FAILED[liveId] then return fn, false end
	return nil
end

-- Run the hooks for `surface` under layout `lid` (its hooks `lhooks`). ->
-- ran, the answer. A failing layout hook turns the layout off, a failing
-- skin hook the skin; neither touches the other.
local function runHooks(lid, lhooks, surface, ...)
	local lfn = BOTH[surface] and lhooks and lhooks[surface]
	if not lfn then
		local fn, byLayout = hookFor(surface, lhooks)
		if not fn then return false end
		local ok, v = pcall(fn, ...)
		if ok then return true, v end
		if byLayout then failLayout(lid, v) else failSkin(liveId, v) end
		return false
	end
	local ran, v = false, nil
	local ok, r = pcall(lfn, ...)
	if ok then ran, v = true, r else failLayout(lid, r) end
	local sfn = liveHooks and liveHooks[surface]
	if sfn and not FAILED[liveId] then
		local sid = liveId
		local sok, sr = pcall(sfn, ...)
		if not sok then
			failSkin(sid, sr)
		else
			if not ran or (v == nil and not LAYOUT_DECIDES[surface]) then v = sr end
			ran = true
		end
	end
	return ran, v
end

-- A module's own art handed to the layout and the skin in use, after the
-- module painted it (the hooks above: Nav/Arrow.lua "arrow", Nav/Pins.lua
-- "pin", UI/Toasts.lua "card" and "toast", QoL/Buttons.lua "actionButton",
-- the guide window's). The layout's hook runs where it has one, else the
-- skin's; for BOTH's hooks the layout's, then the skin's. -> true when a
-- hook ran
function Theme.SkinHook(surface, ...)
	return (runHooks(layoutId, layoutHooks, surface, ...))
end

-- The hook for `surface` with its answer: -> true, its first result when a
-- hook ran (false and nothing when there is none or it failed, the layout or
-- skin then off as with Theme.SkinHook). For BOTH's hooks the layout's
-- answer unless it is nil, then the skin's (guidePlace: the layout's alone).
function Theme.SkinHookValue(surface, ...)
	local ran, v = runHooks(layoutId, layoutHooks, surface, ...)
	if not ran then return false end
	return true, v
end

-- Theme.SkinHook and Theme.SkinHookValue for a guide window that draws with
-- a layout of its own (a copy's GF.layoutChoice: a preset card drawn with
-- the layout it picks, or with Polestar's own while another is in use):
-- `choice` as layoutOf's. The skin's hooks are the skin in use's.
function Theme.SkinHookFor(choice, surface, ...)
	local id, hooks = layoutOf(choice)
	return (runHooks(id, hooks, surface, ...))
end

function Theme.SkinHookValueFor(choice, surface, ...)
	local id, hooks = layoutOf(choice)
	local ran, v = runHooks(id, hooks, surface, ...)
	if not ran then return false end
	return true, v
end

-- Whether the layout or the skin in use hooks `surface` (a module may skip
-- the work of handing over its parts when none does).
function Theme.SkinHooks(surface)
	return hookFor(surface, layoutHooks) ~= nil
end

-- The guide window's parts for a skin's hooks and its own frames (Skin API 2,
-- capability "guideParts"): window, strip (tabs), nav (the step bar), body,
-- card (the step), last (the steps before, over the header: Rows), person (its header), goals (the scroll of goal rows), rows
-- (the goal rows, pooled), tip, after ("Then:"), along, upnext, empty, banner,
-- foot (the progress), here (While you're here). Frames to place things by
-- and to restyle; nil before the window is built. One table, made once. The
-- live window's: the guide hooks run for every guide window (the settings
-- preview's copy too, and a preset card's drawn with the layout it picks),
-- each handing its own parts or frames, so a hook reads the window it
-- dresses from what it is given.
function Theme.GuideParts()
	local G = ns.UI and ns.UI.GuideFrame
	return G and G.SkinParts and G.SkinParts() or nil
end

-- How far guide window `window`'s own parts stand past its top and bottom
-- edges, in its units (capability "guideReach"): the On the top edge tab
-- style's tabs, on the top edge (or the bottom one with the bars there); 0
-- otherwise. Set before the layout's hooks run, so a guideLayout hook places
-- its cards above the window clear of them. -> top, bottom
function Theme.GuideReach(window)
	if type(window) ~= "table" then return 0, 0 end
	return tonumber(rawget(window, "psTopReach")) or 0, tonumber(rawget(window, "psBottomReach")) or 0
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
-- The client gives an addon that loads on demand, not loaded yet, as not
-- loadable with reason "DEMAND_LOADED" ("DEP_DEMAND_LOADED" when one it
-- depends on loads on demand): LoadAddOn loads it, as Blizzard_AddOnList
-- reads it too.
local ON_DEMAND = { DEMAND_LOADED = true, DEP_DEMAND_LOADED = true }
local function installed(key)
	local A = C_AddOns
	local out = {}
	if not (A and A.GetNumAddOns and A.GetAddOnInfo and A.GetAddOnMetadata) then return out end
	for i = 1, A.GetNumAddOns() do
		local name, title, notes, loadable, reason = A.GetAddOnInfo(i)
		-- A skin folder 0.4.3 folded into Polestar_Skins, left installed, never comes.
		local declared = type(name) == "string" and not ns.Data.Folded(name) and A.GetAddOnMetadata(name, key) or nil
		if type(declared) == "string" then
			local ids = {}
			for id in declared:gmatch("[^,%s]+") do ids[#ids + 1] = id end
			if #ids > 0 then
				local loaded = A.IsAddOnLoaded and A.IsAddOnLoaded(name) and true or false
				out[#out + 1] = { addon = name, title = title or name, notes = notes, ids = ids, loaded = loaded,
					reason = not loaded and not loadable and not ON_DEMAND[reason] and (reason or "DISABLED") or nil }
			end
		end
	end
	return out
end
function Theme.InstalledSkins() return installed("X-Polestar-Skin") end

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

-- A skin built when it is first wanted (#3881): a folder that holds several
-- skins (Polestar_Skins: ten) registers each with Theme.SkinBuilder(id,
-- build), and `build` (the skin's own file: its tables, textures and
-- Theme.RegisterSkin) runs the first time that skin is applied, or when the
-- settings list every skin. Loading the folder builds none of them: applying
-- Atlas builds Atlas alone. -> nothing
local BUILDERS = {} -- skin id -> its build, until it has run
function Theme.SkinBuilder(id, build)
	if type(id) ~= "string" or type(build) ~= "function" or SKINS[id] then return end
	BUILDERS[id] = build
end

-- Skin `id`'s build, run once. -> registered now
local function build(id)
	local b = BUILDERS[id]
	if not b then return false end
	BUILDERS[id] = nil
	local ok, err = pcall(b)
	if not ok then report("skin", id, nil, "its build failed: " .. tostring(err)) end
	return SKINS[id] ~= nil
end

-- Whether skin `id` waits to be built (the tests read it).
function Theme.SkinWaits(id) return BUILDERS[id] ~= nil end

-- Load the installed addon that declares skin (or scheme) `id`, when it is
-- not loaded and can be, and build that skin alone. -> ok (registered now,
-- or already), why
function Theme.LoadSkinAddon(id)
	if SKINS[id] or SCHEME_INFO[id] then return true end
	if BUILDERS[id] then
		if build(id) then return true end
		return false, "its build did not register it"
	end
	for _, rec in ipairs(Theme.InstalledSkins()) do
		for _, x in ipairs(rec.ids) do
			if x == id then
				if rec.loaded then return false, "its addon " .. rec.addon .. " is loaded but did not register it" end
				if rec.reason then return false, rec.reason end
				local ok, why = loadSkinAddon(rec)
				if not ok then return false, why end
				build(id)
				if SKINS[id] or SCHEME_INFO[id] then return true end
				return false, "its addon " .. rec.addon .. " loaded but did not register it"
			end
		end
	end
	return false, "no installed addon declares it (## X-Polestar-Skin)"
end

-- Every installed skin addon that can load, loaded (once a session, out of
-- combat), and every skin waiting to be built, built: the settings' picker
-- shows all of them. -> how many addons loaded
local loadedAll = false
function Theme.LoadInstalledSkins()
	if InCombatLockdown and InCombatLockdown() then return 0 end
	local n = 0
	if not loadedAll then
		loadedAll = true
		for _, rec in ipairs(Theme.InstalledSkins()) do
			if not rec.loaded and not rec.reason and loadSkinAddon(rec) then n = n + 1 end
		end
	end
	local ids = {}
	for id in pairs(BUILDERS) do ids[#ids + 1] = id end
	table.sort(ids)
	for _, id in ipairs(ids) do build(id) end
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

---------------------------------------------------------------------------
-- Layouts (capability "layouts"): the guide window's structure, apart from
-- its look. A layout sets only the structure hooks (LAYOUT_HOOKS) and sits
-- under any skin: its hook answers where it has one, else the skin's, else
-- Polestar's own. The player's choice is ui.layout (nil: Polestar's own
-- layout); Theme.SetLayout(id) sets it, Theme.SetLayout() goes back. A
-- layout addon names its layouts in its TOC, as a skin addon does:
--   ## X-Polestar-Layout: ledger        (several: "ledger, ledger-wide")
-- and may load on demand: Polestar loads it at login when the saved layout
-- is one of its own, and when the player picks one.
---------------------------------------------------------------------------

-- Every installed addon that declares layouts (as Theme.InstalledSkins).
function Theme.InstalledLayouts() return installed("X-Polestar-Layout") end

-- Load the installed addon that declares layout `id`, when it is not loaded
-- and can be. -> ok (registered now, or already), why
function Theme.LoadLayoutAddon(id)
	if LAYOUTS[id] then return true end
	for _, rec in ipairs(Theme.InstalledLayouts()) do
		for _, x in ipairs(rec.ids) do
			if x == id then
				if rec.loaded then return false, "its addon " .. rec.addon .. " is loaded but did not register it" end
				if rec.reason then return false, rec.reason end
				local ok, why = loadSkinAddon(rec)
				if not ok then return false, why end
				if LAYOUTS[id] then return true end
				return false, "its addon " .. rec.addon .. " loaded but did not register it"
			end
		end
	end
	return false, "no installed addon declares it (## X-Polestar-Layout)"
end

-- The layout in use follows ui.layout: the one leaving runs its onLeave, the
-- one coming its onApply. -> true when the layout in use changed
local function switchLayout()
	local want = get("ui.layout")
	local l = type(want) == "string" and not LAYOUT_FAILED[want] and LAYOUTS[want] or nil
	local id = l and want or nil
	if id == layoutId then return false end
	local was = layoutId and LAYOUTS[layoutId]
	layoutId, layoutHooks = id, l and l.hooks or nil
	applyDefaults(l and l.defaults or nil)
	-- The layout leaving: onLeave(id, parts, live) once per guide window it
	-- dressed, the live window's parts first, then each copy's that draws
	-- with the layout in use (UI.GuideFrame.copies); once with no parts
	-- before the window is built.
	if was and type(was.onLeave) == "function" then
		local G = ns.UI and ns.UI.GuideFrame
		local windows = {}
		local live = Theme.GuideParts()
		if live then windows[1] = { live, true } end
		for copy in pairs(G and G.copies or {}) do
			local p = copy.SkinParts and copy.SkinParts()
			if p then windows[#windows + 1] = { p, false } end
		end
		if #windows == 0 then windows[1] = { nil, true } end
		for _, w in ipairs(windows) do
			local ok, err = pcall(was.onLeave, was.id, w[1], w[2])
			if not ok then
				failLayout(was.id, err)
				break
			end
		end
	end
	if l and type(l.onApply) == "function" then
		local ok, err = pcall(l.onApply, l.id)
		if not ok then failLayout(l.id, err) end
	end
	return true
end
-- The checks call it when the saved layout registers (its addon loaded late).
I.layoutRegistered = function(id)
	if get("ui.layout") == id and not (ns.IsLoggedIn and not ns.IsLoggedIn()) and switchLayout() then Theme.Refresh() end
end

-- The saved layout: its addon loaded when it is not yet, and put in use.
local function wantLayout()
	local id = get("ui.layout")
	if type(id) == "string" and not LAYOUTS[id] then Theme.LoadLayoutAddon(id) end
	if switchLayout() then Theme.Refresh() end
end
if ns.OnLogin then ns.OnLogin(wantLayout) end
if ns.On then
	ns.On("SETTING_CHANGED", function(path)
		if path == "ui.layout" or path == "ui" or path == "" then
			if not (ns.IsLoggedIn and not ns.IsLoggedIn()) then wantLayout() end
		end
	end)
end

-- Choose layout `id` (nil: Polestar's own layout), loading its addon when
-- it is installed and not loaded. -> ok, why
function Theme.SetLayout(id)
	if id ~= nil and id ~= false then
		local ok, why = Theme.LoadLayoutAddon(id)
		if not ok then return false, why end
	end
	ns.Set("ui.layout", id or nil)
	return true
end

-- The layout in use (nil: Polestar's own).
function Theme.LayoutId() return layoutId end

-- The registered layouts' ids, sorted.
function Theme.Layouts()
	local out = {}
	for id in pairs(LAYOUTS) do out[#out + 1] = id end
	table.sort(out)
	return out
end

-- A registered layout's public facts (name, addon, author, version, desc,
-- api, hooks: the surfaces it hooks, sorted; defaults: its settings'
-- defaults, a copy; preset: its card in the guide window's Presets, { label,
-- help, set } with set a copy, or nil), or nil.
function Theme.LayoutInfo(id)
	local l = LAYOUTS[id]
	if not l then return nil end
	local hooks = {}
	for k in pairs(l.hooks or {}) do hooks[#hooks + 1] = k end
	table.sort(hooks)
	local defaults = {}
	for k, v in pairs(l.defaults or {}) do defaults[k] = v end
	local preset = l.preset
	if preset then
		local set = {}
		for k, v in pairs(preset.set) do set[k] = v end
		preset = { label = preset.label, help = preset.help, set = set }
	end
	return { id = id, name = l.name, addon = l.addon, author = l.author, version = l.version, desc = l.desc, api = l.api,
		hooks = hooks, defaults = defaults, preset = preset, failed = LAYOUT_FAILED[id] }
end

-- The installed layouts with a card in the guide window's Presets, in the
-- order of the addons, then of their ids: a registered layout's when its
-- spec has a preset; a layout not registered yet (its addon not loaded, or
-- loading on demand) when its TOC names it in
--   ## X-Polestar-Layout-Preset: ledger = Ledger; ledger-wide = Ledger wide
-- (a bare id takes the id as its label), its help the TOC's Notes. A layout
-- whose addon cannot load, or loaded without registering it, has none.
-- The addon's stage, for a tag on its cards:
--   ## X-Polestar-Layout-Stage: beta   (alpha or beta)
-- -> { { id, label, help, set (a registered layout's, a copy; {} else), loaded, addon, stage }, ... }
function Theme.LayoutPresets()
	local out = {}
	for _, rec in ipairs(Theme.InstalledLayouts()) do
		local named = {}
		local stage = C_AddOns.GetAddOnMetadata(rec.addon, "X-Polestar-Layout-Stage")
		stage = type(stage) == "string" and stage:lower():match("^%s*(%a+)%s*$") or nil
		if stage ~= "alpha" and stage ~= "beta" then stage = nil end
		local declared = C_AddOns.GetAddOnMetadata(rec.addon, "X-Polestar-Layout-Preset")
		if type(declared) == "string" then
			for item in declared:gmatch("[^;]+") do
				local id, label = item:match("^%s*([^=%s]+)%s*=%s*(.-)%s*$")
				if not id then id = item:match("^%s*([^=%s]+)%s*$") end
				if id then named[id] = label ~= "" and label or id end
			end
		end
		for _, id in ipairs(rec.ids) do
			local info = LAYOUTS[id] and Theme.LayoutInfo(id)
			if info then
				local p = info.preset
				if p then
					out[#out + 1] = { id = id, label = p.label or info.name, help = p.help, set = p.set, loaded = true, addon = rec.addon, stage = stage }
				end
			elseif named[id] and not rec.loaded and not rec.reason then
				out[#out + 1] = { id = id, label = named[id], help = rec.notes, set = {}, loaded = false, addon = rec.addon, stage = stage }
			end
		end
	end
	return out
end

-- The built-in schemes and skins (their tokens are Theme.lua's tables;
-- Theme/Looks/GameSkins.lua adds the game looks' painters), taken as they are:
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
