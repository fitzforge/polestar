-- Profiles: named sets of Polestar's settings, a migration registry for
-- settings keys, and profile strings to share a profile as one line of text.
-- The Profiles page (Polestar_Options/UI/Profiles.lua) and `/polestar profile` use it.
-- Contract: docs/ARCHITECTURE.md, "Core" -> "Profiles".
--
-- The profile in use lives where the settings always have:
-- PolestarDB.settings, so ns.Get / ns.Set and every module stay as they were.
-- The others wait in PolestarDB.profiles[name], each its own table (one
-- table under two saved keys would be written twice). A switch moves the
-- tables round and fires SETTING_CHANGED("") as ns.ResetSettings does, so
-- everything paints itself again.
--
--   PolestarDB.profileActive   the name of the profile in PolestarDB.settings
--   PolestarDB.profile         the account's profile: every character with no choice of its own or its class's
--   PolestarDB.classProfiles   class token -> profile: every character of that class (unless it has its own)
--   PolestarDB.profileRenamed  old name -> new name, so another character's own choice follows a rename
--   PolestarDB.migrations      migration id -> true once it has run
--   PolestarCharDB.profile     this character's own profile, nil while it follows its class's or the account's
--
-- At ADDON_LOADED, before any OnInit handler (Init.lua calls P.Load), the
-- character's profile is swapped into PolestarDB.settings and the registered
-- migrations run. Settings saved before profiles become the profile "Default"
-- just where they are, so nothing moves and nothing is lost.
--
--   P.List() -> { name, ... }       "Default" first, then by name
--   P.Active() -> name              the profile in use
--   P.Exists(name), P.Label(name)   the name as shown ("Default" translated, `|` escaped)
--   P.Source() -> "character" | "class" | "account"   whose choice the character follows
--   P.ForCharacter(), P.ClassProfile(), P.ClassName(), P.AccountProfile()
--   P.Switch(name)                  -> true | nil, why (changes the choice the character follows)
--   P.New(name, copyFrom?)          -> name | nil, why (copyFrom nil: every setting at its default)
--   P.Copy(from, to)                -> true | nil, why (to made, or replaced with a copy of from)
--   P.Rename(old, new), P.Delete(name) -> true | nil, why
--   P.UseForCharacter(on), P.UseForClass(on)
--   P.Key(name) -> key | nil, P.SetKey(name, key | nil) -> true | nil, why
--                                   a key (or gamepad button) that switches to the profile
--                                   (PolestarDB.profileKeys, the account's; out of combat)
--   P.Export(name?, opts) -> string, count | nil, why   -- opts.areas = { look, guiding, positions } (all when nil); opts.look: the look alone
--   P.Import(text) -> preview | nil, why   -- nothing changes yet
--   P.Apply(preview, name, areas?)  -> true | nil, why: into the profile in use (name = P.Active()) or as a new one
--   P.RegisterPosition(path, shape) -- a position setting a string may carry (shape "xy" | "pxy" | "ppxy" | "anchor")
--   ns.RegisterMigration(id, fn(settings))
-- The string functions (Export, Import, Apply, Portable, FreeName, Pack,
-- AreaOf, Same) are the settings' addon's (Polestar_Options/Core/
-- ProfileStrings.lua): the first call loads it.
--
-- A profile string is data, never code:
--   !PSS1!<Adler-32 of the JSON, 8 hex digits>!<base64 of zlib of the JSON>
--   { "format": 1, "name": "Raid", "scope": "look" (the look alone), "areas": ["look", ...],
--     "screen": { w, h, scale }, "migrations": [ids], "settings": { "ui.scale": 0.9 } }
-- (the envelope of guide import strings, Core/Import.lua, whose JSON reader
-- and checksum it reuses). Read back, each setting must have a registered
-- default and a value of its type (a colour {r, g, b[, a]} in 0-1, a
-- position of its registered shape; a slider's range, a dropdown's choices
-- when a control on the Options pages says so); anything else is dropped
-- and named. Messages: PROFILES_CHANGED (the list, the profile in use or
-- this character's choice changed).

local ADDON, ns = ...
local L = ns.L

local type, pairs, ipairs, next, tostring, pcall = type, pairs, ipairs, next, tostring, pcall
local format, gsub, lower = string.format, string.gsub, string.lower
local concat, sort = table.concat, table.sort

local P = {}
ns.Profiles = P

local DEFAULT = "Default"
P.DEFAULT = DEFAULT

local PREFIX = "!PSS1!"
local FORMAT = 1
-- Caps: characters in a string, bytes of its JSON, settings in it, bytes of a
-- settings path or a text value, a profile name's bytes, profiles kept, and
-- migration ids a string may list.
local LIMITS = { length = 100000, payload = 131072, settings = 2000, path = 128, text = 512, name = 48, profiles = 64, migrations = 256 }
P.LIMITS = LIMITS

-- Never in a string: whether the guide window is shown (a friend's string
-- must not hide yours).
local NOT_SHARED = { ["ui.shown"] = true }

---------------------------------------------------------------------------
-- Storage
---------------------------------------------------------------------------

local function store()
	local db = ns.DB()
	if type(db.profiles) ~= "table" then db.profiles = {} end
	return db.profiles
end

function P.Active()
	local name = ns.DB().profileActive
	return type(name) == "string" and name or DEFAULT
end

function P.Exists(name)
	return type(name) == "string" and (name == P.Active() or type(store()[name]) == "table")
end

-- The table holding a profile's settings: the live settings for the one in use.
local function data(name)
	if name == P.Active() then return ns.DB().settings end
	local t = store()[name]
	return type(t) == "table" and t or nil
end

local function deepCopy(v, depth)
	if type(v) ~= "table" then return v end
	depth = (depth or 0) + 1
	if depth > 16 then return nil end
	local out = {}
	for k, x in pairs(v) do out[k] = deepCopy(x, depth) end
	return out
end

-- A profile's name as the page and chat show it.
function P.Label(name)
	if name == DEFAULT then return L["Default"] end
	return ns.EscapeText(tostring(name))
end

function P.List()
	local out, seen = { DEFAULT }, { [DEFAULT] = true }
	local function add(name)
		if not seen[name] then
			seen[name] = true
			out[#out + 1] = name
		end
	end
	add(P.Active())
	for name, t in pairs(store()) do
		if type(name) == "string" and type(t) == "table" then add(name) end
	end
	local first = table.remove(out, 1)
	sort(out, function(a, b)
		local la, lb = lower(a), lower(b)
		if la ~= lb then return la < lb end
		return a < b
	end)
	table.insert(out, 1, first)
	return out
end

function P.ForCharacter()
	return type(ns.CharState().profile) == "string"
end

-- The account's profile: the one a character without its own (or its
-- class's) uses.
function P.AccountProfile()
	local name = ns.DB().profile
	return type(name) == "string" and name or DEFAULT
end

-- The character's class token ("WARRIOR"), nil when the client does not say.
local function classToken()
	if type(UnitClass) ~= "function" then return nil end
	local ok, _, class = pcall(UnitClass, "player")
	return ok and type(class) == "string" and class or nil
end

local function classProfiles()
	local t = ns.DB().classProfiles
	return type(t) == "table" and t or nil
end

-- The profile every character of this class uses (unless it has its own), or nil.
function P.ClassProfile()
	local class, t = classToken(), classProfiles()
	local name = class and t and t[class]
	return type(name) == "string" and name or nil
end

-- The class's name as the game writes it ("Warrior"), for the page.
function P.ClassName()
	if type(UnitClass) ~= "function" then return nil end
	local ok, name = pcall(UnitClass, "player")
	return ok and type(name) == "string" and name or nil
end

-- Where this character's profile comes from: "character" | "class" | "account".
function P.Source()
	if P.ForCharacter() then return "character" end
	if P.ClassProfile() then return "class" end
	return "account"
end

-- A name as typed, trimmed, without control characters or `|`. -> name | nil, why
local function cleanName(s)
	if type(s) ~= "string" then return nil, L["Give the profile a name."] end
	s = gsub(s, "[%z\1-\31|]", "")
	s = s:match("^%s*(.-)%s*$")
	if s == "" then return nil, L["Give the profile a name."] end
	if #s > LIMITS.name then return nil, L["That name is too long."] end
	return s
end
P.CleanName = cleanName

local function taken(name)
	return (L["A profile called %s already exists."]):format(P.Label(name))
end

local function missing(name)
	return (L["There is no profile called %s."]):format(P.Label(tostring(name)))
end

-- Make `name` the profile in PolestarDB.settings. -> true when it moved
local function swapTo(name)
	local db = ns.DB()
	local cur = P.Active()
	if name == cur then return false end
	local profiles = store()
	local incoming = profiles[name]
	profiles[name] = nil
	profiles[cur] = db.settings
	db.settings = type(incoming) == "table" and incoming or {}
	db.profileActive = name
	return true
end

local function changed(moved)
	if moved then ns.Fire("SETTING_CHANGED", "", nil) end
	ns.Fire("PROFILES_CHANGED")
end

-- Follow renames from another character's session (a short chain at most).
local function resolve(name)
	local renamed = ns.DB().profileRenamed
	if type(renamed) ~= "table" then return name end
	for _ = 1, 16 do
		local to = renamed[name]
		if type(to) ~= "string" then break end
		name = to
	end
	return name
end

local function forgetRenames(name)
	local renamed = ns.DB().profileRenamed
	if type(renamed) ~= "table" then return end
	renamed[name] = nil
	for from, to in pairs(renamed) do
		if to == name then renamed[from] = nil end
	end
	if next(renamed) == nil then ns.DB().profileRenamed = nil end
end

-- The profile a character with no choice of its own falls to.
local function fallback()
	local name = P.ClassProfile()
	if name and P.Exists(name) then return name end
	name = P.AccountProfile()
	if not P.Exists(name) then
		name = DEFAULT
		ns.DB().profile = DEFAULT
	end
	return name
end

-- Switching changes the choice the character follows: its own, its
-- class's, or the account's.
function P.Switch(name)
	if not P.Exists(name) then return nil, missing(name) end
	local source = P.Source()
	if source == "character" then
		ns.CharState().profile = name
	elseif source == "class" then
		classProfiles()[classToken()] = name
	else
		ns.DB().profile = name
	end
	changed(swapTo(name))
	return true
end

function P.UseForCharacter(on)
	local char = ns.CharState()
	if on then
		char.profile = P.Active()
		changed(false)
		return true
	end
	char.profile = nil
	changed(swapTo(fallback()))
	return true
end

-- on: every character of this class uses the profile in use (unless one
-- has its own); off: they follow the account's again.
function P.UseForClass(on)
	local class = classToken()
	if not class then return nil end
	local db = ns.DB()
	if on then
		if type(db.classProfiles) ~= "table" then db.classProfiles = {} end
		db.classProfiles[class] = P.Active()
		changed(false)
		return true
	end
	if type(db.classProfiles) == "table" then
		db.classProfiles[class] = nil
		if next(db.classProfiles) == nil then db.classProfiles = nil end
	end
	changed(not P.ForCharacter() and swapTo(fallback()))
	return true
end

local function count()
	local n = 0
	for _, t in pairs(store()) do if type(t) == "table" then n = n + 1 end end
	return n + 1
end

function P.New(name, copyFrom)
	local clean, why = cleanName(name)
	if not clean then return nil, why end
	if P.Exists(clean) then return nil, taken(clean) end
	if count() >= LIMITS.profiles then return nil, (L["Polestar keeps up to %d profiles. Delete one first."]):format(LIMITS.profiles) end
	local t = {}
	if copyFrom ~= nil then
		local src = data(copyFrom)
		if not src then return nil, missing(copyFrom) end
		t = deepCopy(src)
	end
	forgetRenames(clean)
	store()[clean] = t
	changed(false)
	return clean
end

function P.Copy(from, to)
	local src = data(from)
	if not src then return nil, missing(from) end
	if not P.Exists(to) then
		local made, why = P.New(to, from)
		if not made then return nil, why end
		return true
	end
	if to == from then return true end
	local t = deepCopy(src)
	if to == P.Active() then
		ns.DB().settings = t
		changed(true)
	else
		store()[to] = t
		changed(false)
	end
	return true
end

function P.Rename(old, new)
	if not P.Exists(old) then return nil, missing(old) end
	if old == DEFAULT then return nil, L["Default stays: it is the profile every character falls back to."] end
	local clean, why = cleanName(new)
	if not clean then return nil, why end
	if clean == old then return true end
	if P.Exists(clean) then return nil, taken(clean) end
	local db = ns.DB()
	if old == P.Active() then
		db.profileActive = clean
	else
		local profiles = store()
		profiles[clean], profiles[old] = profiles[old], nil
	end
	if db.profile == old then db.profile = clean end
	for class, name in pairs(classProfiles() or {}) do
		if name == old then db.classProfiles[class] = clean end
	end
	local char = ns.CharState()
	if char.profile == old then char.profile = clean end
	forgetRenames(clean)
	local renamed = type(db.profileRenamed) == "table" and db.profileRenamed or {}
	for from, to in pairs(renamed) do
		if to == old then renamed[from] = clean end
	end
	renamed[old] = clean
	db.profileRenamed = renamed
	-- Its key goes with it.
	local keys = db.profileKeys
	if type(keys) == "table" and keys[old] then
		keys[clean], keys[old] = keys[old], nil
		P.ApplyKeys()
	end
	changed(false)
	return true
end

function P.Delete(name)
	if not P.Exists(name) then return nil, missing(name) end
	if name == DEFAULT then return nil, L["Default stays: it is the profile every character falls back to."] end
	if name == P.Active() then return nil, L["This profile is in use. Switch to another one first."] end
	store()[name] = nil
	local db = ns.DB()
	if db.profile == name then db.profile = DEFAULT end
	for class, n in pairs(classProfiles() or {}) do
		if n == name then db.classProfiles[class] = nil end
	end
	forgetRenames(name)
	if type(db.profileKeys) == "table" and db.profileKeys[name] then
		db.profileKeys[name] = nil
		if next(db.profileKeys) == nil then db.profileKeys = nil end
		P.ApplyKeys()
	end
	changed(false)
	return true
end

---------------------------------------------------------------------------
-- A profile's key: pressed, it switches to that profile, out of combat (a
-- word in chat says which, or why not). The keys are the account's
-- (PolestarDB.profileKeys[name] = "CTRL-F5"), one profile a key; each is an
-- override binding of Polestar's own on a button no one sees, set at login
-- and when the keys change, never in a fight (it waits for the fight's end).
---------------------------------------------------------------------------

local keyButton, keyFor = nil, {}

local function keyStore()
	local db = ns.DB()
	if type(db.profileKeys) ~= "table" then db.profileKeys = {} end
	return db.profileKeys
end

function P.Key(name)
	local keys = ns.DB().profileKeys
	return type(keys) == "table" and keys[name] or nil
end

local function onKey(_, mouse, down)
	if down == false then return end
	local name = keyFor[mouse]
	if not (name and P.Exists(name)) then return end
	if InCombatLockdown and InCombatLockdown() then
		ns.Print(L["Profiles switch out of combat."])
		return
	end
	local ok, why = true, nil
	if name ~= P.Active() then ok, why = P.Switch(name) end
	ns.Print(ok and (L["Profile: %s"]):format(P.Label(name)) or why)
end

local waitingKeys = false
function P.ApplyKeys()
	if InCombatLockdown and InCombatLockdown() then
		if not waitingKeys then
			waitingKeys = true
			ns.RegisterEvent("PLAYER_REGEN_ENABLED", P.ApplyKeys)
		end
		return false
	end
	if waitingKeys then
		waitingKeys = false
		ns.UnregisterEvent("PLAYER_REGEN_ENABLED", P.ApplyKeys)
	end
	local keys = ns.DB().profileKeys
	if not keyButton then
		if type(keys) ~= "table" or next(keys) == nil then return true end
		keyButton = CreateFrame("Button", "PolestarProfileKey", UIParent)
		keyButton:SetSize(1, 1)
		keyButton:RegisterForClicks("AnyDown", "AnyUp")
		keyButton:SetScript("OnClick", onKey)
	end
	local clear, bind = _G.ClearOverrideBindings, _G.SetOverrideBindingClick
	if not (clear and bind) then return false end
	clear(keyButton)
	for k in pairs(keyFor) do keyFor[k] = nil end
	local i = 0
	for name, key in pairs(type(keys) == "table" and keys or {}) do
		if type(key) == "string" and P.Exists(name) then
			i = i + 1
			keyFor["p" .. i] = name
			bind(keyButton, false, key, "PolestarProfileKey", "p" .. i)
		end
	end
	return true
end

-- key nil: the profile's key goes. A key another profile had moves here.
function P.SetKey(name, key)
	if not P.Exists(name) then return nil, missing(name) end
	if key ~= nil and (type(key) ~= "string" or key == "") then return nil, L["That is no key."] end
	local keys = keyStore()
	if key then
		for other, k in pairs(keys) do if k == key then keys[other] = nil end end
	end
	keys[name] = key
	if next(keys) == nil then ns.DB().profileKeys = nil end
	P.ApplyKeys()
	changed(false)
	return true
end

ns.OnLogin(function() P.ApplyKeys() end)

---------------------------------------------------------------------------
-- Migrations: a settings key moved or changed meaning, once per id, over
-- the settings in use and every stored profile (and over a profile string
-- from before it).
---------------------------------------------------------------------------

local migrations, migrationOrder = {}, {}
local loaded = false

local function runMigration(id)
	local db = ns.DB()
	if type(db.migrations) ~= "table" then db.migrations = {} end
	if db.migrations[id] then return false end
	db.migrations[id] = true
	local fn = migrations[id]
	ns.SafeCall(fn, db.settings)
	for _, t in pairs(store()) do
		if type(t) == "table" then ns.SafeCall(fn, t) end
	end
	return true
end

-- fn(settings) gets one profile's settings table ({ ui = { ... }, nav = { ... } })
-- and changes it in place. Register at file load; one registered later runs
-- at once. -> true | false, why
function ns.RegisterMigration(id, fn)
	if type(id) ~= "string" or id == "" then return false, "RegisterMigration: id must be a string" end
	if type(fn) ~= "function" then return false, "RegisterMigration: fn must be a function" end
	if migrations[id] then return false, "RegisterMigration: " .. id .. " is registered already" end
	migrations[id] = fn
	migrationOrder[#migrationOrder + 1] = id
	if loaded and runMigration(id) then ns.Fire("SETTING_CHANGED", "", nil) end
	return true
end

-- Called by Init.lua at ADDON_LOADED, before the OnInit handlers.
function P.Load()
	local db = ns.DB()
	local profiles = store()
	for name, t in pairs(profiles) do
		if type(name) ~= "string" or type(t) ~= "table" or cleanName(name) ~= name then profiles[name] = nil end
	end
	-- Settings from before profiles are the profile Default, where they are.
	if type(db.profileActive) ~= "string" or cleanName(db.profileActive) ~= db.profileActive then db.profileActive = DEFAULT end
	profiles[db.profileActive] = nil
	if not P.Exists(DEFAULT) then profiles[DEFAULT] = {} end
	local account = type(db.profile) == "string" and resolve(db.profile) or DEFAULT
	if not P.Exists(account) then account = DEFAULT end
	db.profile = account
	local classes = classProfiles()
	if classes then
		for class, name in pairs(classes) do
			local to = type(name) == "string" and resolve(name)
			classes[class] = (to and P.Exists(to)) and to or nil
		end
		if next(classes) == nil then db.classProfiles = nil end
	end
	local char = ns.CharState()
	if char.profile ~= nil then
		local own = type(char.profile) == "string" and resolve(char.profile) or nil
		char.profile = (own and P.Exists(own)) and own or nil
	end
	swapTo(char.profile or fallback())
	loaded = true
	for _, id in ipairs(migrationOrder) do runMigration(id) end
end

---------------------------------------------------------------------------
-- Profile strings (export, import, apply) are the settings' addon's
-- (Polestar_Options/Core/ProfileStrings.lua), never in memory at login:
-- the functions below load it first and it takes their place. In a fight
-- nothing loads: they answer nil, "combat".
---------------------------------------------------------------------------

P.Parts = { PREFIX = PREFIX, FORMAT = FORMAT, NOT_SHARED = NOT_SHARED, store = store, data = data,
	deepCopy = deepCopy, missing = missing, migrations = migrations, migrationOrder = migrationOrder }

-- Position shapes given before the strings' file loads, for it to take.
P.pendingPositions = {}
function P.RegisterPosition(path, shape)
	if type(path) ~= "string" then return false end
	P.pendingPositions[#P.pendingPositions + 1] = { path, shape }
	return true
end

for _, name in ipairs({ "Same", "AreaOf", "Pack", "Portable", "Export", "Import", "FreeName", "Apply" }) do
	local stub
	stub = function(...)
		local UI, ok, why = ns.UI, false, "unavailable"
		if UI and UI.LoadOptions then ok, why = UI.LoadOptions() end
		if not ok or P[name] == stub then return nil, why end
		return P[name](...)
	end
	P[name] = stub
end

---------------------------------------------------------------------------
-- /polestar profile [name]
---------------------------------------------------------------------------

ns.RegisterCommand("profile", function(rest)
	local name = rest and rest:match("^%s*(.-)%s*$") or ""
	if name == "" then
		local names = {}
		for i, n in ipairs(P.List()) do names[i] = P.Label(n) end
		ns.Print((L["Profile in use: %s."]):format(P.Label(P.Active())), (L["Profiles: %s."]):format(concat(names, ", ")))
		return
	end
	-- Typed names match whatever their case; "default" is Default in any language.
	local found
	for _, n in ipairs(P.List()) do
		if lower(n) == lower(name) or lower(P.Label(n)) == lower(name) then
			found = n
			break
		end
	end
	if not found then
		ns.Print(missing(name))
		return
	end
	P.Switch(found)
	ns.Print((L["Profile in use: %s."]):format(P.Label(found)))
end, L["Switch to a settings profile: /polestar profile <name>"])
