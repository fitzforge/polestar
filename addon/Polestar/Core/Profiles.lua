-- Profiles: named sets of Polestar's settings, a migration registry for
-- settings keys, and profile strings to share a profile as one line of text.
-- The Profiles page (UI/Profiles.lua) and `/polestar profile` use it.
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
--   P.Export(name?, opts) -> string, count | nil, why   -- opts.areas = { look, guiding, positions } (all when nil); opts.look: the look alone
--   P.Import(text) -> preview | nil, why   -- nothing changes yet
--   P.Apply(preview, name, areas?)  -> true | nil, why: into the profile in use (name = P.Active()) or as a new one
--   P.RegisterPosition(path, shape) -- a position setting a string may carry (shape "xy" | "pxy" | "ppxy" | "anchor")
--   ns.RegisterMigration(id, fn(settings))
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

local type, pairs, ipairs, next, tostring, tonumber, pcall, select = type, pairs, ipairs, next, tostring, tonumber, pcall, select
local byte, char, format, sub, gsub, find, lower = string.byte, string.char, string.format, string.sub, string.gsub, string.find, string.lower
local concat, sort, floor, huge, abs = table.concat, table.sort, math.floor, math.huge, math.abs

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

local function finite(v) return type(v) == "number" and v == v and v ~= huge and v ~= -huge end

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
	changed(false)
	return true
end

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
-- What a setting may hold
---------------------------------------------------------------------------

local ANCHORS = { TOPLEFT = true, TOP = true, TOPRIGHT = true, LEFT = true, CENTER = true, RIGHT = true, BOTTOMLEFT = true, BOTTOM = true, BOTTOMRIGHT = true }
local COORD = 20000

local function coord(v) return finite(v) and v >= -COORD and v <= COORD end

-- Exactly n entries, all of them 1..n.
local function isList(t, n)
	local c = 0
	for _ in pairs(t) do c = c + 1 end
	if c ~= n then return false end
	for i = 1, n do
		if t[i] == nil then return false end
	end
	return true
end

-- Position shapes -> a fresh copy, or nil.
local SHAPES = {
	-- { x, y } (the guide window, the floating button)
	xy = function(v) if isList(v, 2) and coord(v[1]) and coord(v[2]) then return { v[1], v[2] } end end,
	-- { point, x, y } (the rare alert, the flight timer, the party panel)
	pxy = function(v) if isList(v, 3) and ANCHORS[v[1]] and coord(v[2]) and coord(v[3]) then return { v[1], v[2], v[3] } end end,
	-- { point, relPoint, x, y }
	ppxy = function(v)
		if isList(v, 4) and ANCHORS[v[1]] and ANCHORS[v[2]] and coord(v[3]) and coord(v[4]) then return { v[1], v[2], v[3], v[4] } end
	end,
	-- { point =, relPoint =, x =, y = } (the arrow)
	anchor = function(v)
		for k in pairs(v) do
			if k ~= "point" and k ~= "relPoint" and k ~= "x" and k ~= "y" then return nil end
		end
		if not (ANCHORS[v.point] and (v.relPoint == nil or ANCHORS[v.relPoint]) and coord(v.x) and coord(v.y)) then return nil end
		return { point = v.point, relPoint = v.relPoint, x = v.x, y = v.y }
	end,
}

-- The position settings and their shapes (more with P.RegisterPosition).
local positions = {
	["ui.pos"] = SHAPES.xy, ["ui.launcherPos"] = SHAPES.xy, ["nav.arrowPos"] = SHAPES.anchor,
	["rares.toastPoint"] = SHAPES.pxy, ["maps.timerPos"] = SHAPES.pxy, ["maps.trackerPos"] = SHAPES.pxy, ["party.panelPos"] = SHAPES.pxy,
}

-- shape: "xy" | "pxy" | "ppxy" | "anchor", or fn(value) -> a fresh copy or nil.
function P.RegisterPosition(path, shape)
	local fn = type(shape) == "function" and shape or SHAPES[shape]
	if type(path) ~= "string" or not fn then return false end
	positions[path] = fn
	return true
end

local function colour(v)
	if type(v) ~= "table" then return nil end
	local n = #v
	if (n ~= 3 and n ~= 4) or not isList(v, n) then return nil end
	local out = {}
	for i = 1, n do
		if not finite(v[i]) or v[i] < 0 or v[i] > 1 then return nil end
		out[i] = v[i]
	end
	return out
end

local function isColour(d) return type(d) == "table" and colour(d) ~= nil end

local function same(a, b)
	if type(a) == "table" and type(b) == "table" then
		for k, v in pairs(a) do if not same(v, b[k]) then return false end end
		for k in pairs(b) do if a[k] == nil then return false end end
		return true
	end
	return a == b
end
P.Same = same

-- The controls on the Options pages: key -> control, and the keys on the
-- Look pages (a page's `group = "look"`, or its order 20-29).
local function controls()
	local index, look = {}, {}
	local W = ns.Widgets
	local registry = W and W.OptionsRegistry or {}
	local group = {}
	for _, spec in ipairs(registry) do
		if type(spec) == "table" and spec.page and group[spec.page] == nil then
			if spec.group then
				group[spec.page] = spec.group
			elseif type(spec.order) == "number" then
				group[spec.page] = (spec.order >= 20 and spec.order < 30) and "look" or "other"
			end
		end
	end
	local function add(c, isLook)
		if type(c) ~= "table" or type(c.key) ~= "string" or c.kind == "button" or c.kind == "binding" then return end
		if index[c.key] == nil then index[c.key] = c end
		if isLook then look[c.key] = true end
	end
	for _, spec in ipairs(registry) do
		if type(spec) == "table" and type(spec.controls) == "table" then
			local isLook = group[spec.page] == "look"
			for _, c in ipairs(spec.controls) do add(c, isLook) end
		end
	end
	local O = ns.UI and ns.UI.Options
	if O and type(O.AllControls) == "function" then
		local ok, list = pcall(O.AllControls)
		if ok and type(list) == "table" then
			-- Built-in pages too; each control knows its page (its group, or its order).
			for _, c in ipairs(list) do
				local pg = type(c) == "table" and type(c.page) == "table" and c.page or nil
				local isLook = pg ~= nil and (pg.group == "look"
					or (pg.group == nil and type(pg.order) == "number" and pg.order >= 20 and pg.order < 30))
				add(c, isLook)
			end
		end
	end
	return index, look
end

local function choicesOf(c)
	local list = c.choices
	if type(list) == "function" then
		local ok, r = pcall(list)
		list = ok and r or nil
	end
	return type(list) == "table" and list or nil
end

-- A key that holds a table when it is set (a colour, a place): never `true`.
local function slotName(path)
	local key = path:match("([^.]+)$") or path
	return key:find("Pos$") or key:find("Point$") or key:find("Colou?r$") or key == "accent"
end

-- v as setting `path` may hold it (a fresh copy for a table), or nil.
local function fit(path, v, c)
	if NOT_SHARED[path] then return nil end
	local shape = positions[path]
	local d = ns.GetDefault(path)
	if shape then
		if v == false and d == false then return false end
		if type(v) == "table" then return shape(v) end
		return nil
	end
	if d == nil then return nil end
	local td = type(d)
	if td == "boolean" then
		if type(v) == "boolean" then
			if v and not d and ((c and c.kind == "color") or slotName(path)) then return nil end
			return v
		end
		if d == false and type(v) == "table" then return colour(v) end
		return nil
	elseif td == "table" then
		if isColour(d) then return colour(v) end
		return nil
	end
	if type(v) ~= td then return nil end
	if td == "number" then
		if not finite(v) or abs(v) > 1e9 then return nil end
		if c and c.kind == "slider" and type(c.min) == "number" and type(c.max) == "number" then
			-- In range, not snapped: some defaults sit between steps.
			if v < c.min - 1e-9 or v > c.max + 1e-9 then return nil end
		end
	elseif td == "string" then
		if #v > LIMITS.text or find(v, "[%z\1-\31]") then return nil end
	else
		return nil
	end
	local choices = c and (c.kind == "dropdown" or c.kind == "cards" or c.kind == "font") and choicesOf(c)
	if choices and #choices > 0 then
		for _, ch in ipairs(choices) do
			if type(ch) == "table" and ch.value == v then return v end
		end
		return nil
	end
	return v
end

-- Every leaf of a profile's settings: path -> value. A record default
-- ({ inn = true, bank = true }) is walked into; a colour or a position is
-- one value.
local function leaves(settings, out)
	out = out or {}
	local function walk(prefix, t, depth)
		for k, v in pairs(t) do
			if type(k) == "string" or type(k) == "number" then
				local path = prefix and (prefix .. "." .. k) or tostring(k)
				if not prefix then
					if type(v) == "table" then walk(path, v, depth + 1) end
				else
					local d = ns.GetDefault(path)
					if type(v) == "table" and type(d) == "table" and not isColour(d) and not positions[path] and depth < 4 then
						walk(path, v, depth + 1)
					else
						out[path] = v
					end
				end
			end
		end
	end
	walk(nil, settings, 0)
	return out
end

---------------------------------------------------------------------------
-- Writing a string: JSON, then zlib and base64 by the client's encoder, or a
-- stored (uncompressed) zlib stream and base64 in plain Lua where it has
-- none. Any zlib reader takes stored blocks.
---------------------------------------------------------------------------

local ESC = { ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\t"] = "\\t" }

local function jstr(s)
	-- Other control characters: the reader refuses them, so they are left out.
	return '"' .. gsub(s, '[%c"\\]', function(ch) return ESC[ch] or "" end) .. '"'
end

local function jnum(v)
	if v == floor(v) and v > -1e15 and v < 1e15 then return format("%d", v) end
	return format("%.17g", v)
end

local function jvalue(v)
	local t = type(v)
	if t == "boolean" then return v and "true" or "false" end
	if t == "number" then return jnum(v) end
	if t == "string" then return jstr(v) end
	local n = #v
	if n > 0 and isList(v, n) then
		local out = {}
		for i = 1, n do out[i] = jvalue(v[i]) end
		return "[" .. concat(out, ",") .. "]"
	end
	local keys = {}
	for k in pairs(v) do keys[#keys + 1] = tostring(k) end
	sort(keys)
	local out = {}
	for i, k in ipairs(keys) do out[i] = jstr(k) .. ":" .. jvalue(v[k]) end
	return "{" .. concat(out, ",") .. "}"
end

local function zlibStored(s)
	local out = { "\120\1" }
	local n, at = #s, 1
	repeat
		local len = n - at + 1
		if len > 65535 then len = 65535 end
		local last = at + len > n
		local nlen = 65535 - len
		out[#out + 1] = char(last and 1 or 0, len % 256, floor(len / 256), nlen % 256, floor(nlen / 256))
		out[#out + 1] = sub(s, at, at + len - 1)
		at = at + len
	until at > n
	local sum = ns.Import.Adler32(s)
	for i = 1, 8, 2 do out[#out + 1] = char(tonumber(sub(sum, i, i + 1), 16)) end
	return concat(out)
end

local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function base64(s)
	local out = {}
	for i = 1, #s, 3 do
		local a, b, c = byte(s, i, i + 2)
		local v = a * 65536 + (b or 0) * 256 + (c or 0)
		local q = {}
		for j = 4, 1, -1 do
			q[j] = v % 64 + 1
			v = floor(v / 64)
		end
		out[#out + 1] = sub(B64, q[1], q[1]) .. sub(B64, q[2], q[2])
			.. (b and sub(B64, q[3], q[3]) or "=") .. (c and sub(B64, q[4], q[4]) or "=")
	end
	return concat(out)
end

local function zlibMethod()
	return Enum and Enum.CompressionMethod and Enum.CompressionMethod.Zlib
end

-- The client's own encoding, used only when it reads back to the same text.
local function clientBody(json)
	local enc = C_EncodingUtil
	if not (type(enc) == "table" and type(enc.CompressString) == "function" and type(enc.EncodeBase64) == "function"
		and type(enc.DecodeBase64) == "function" and type(enc.DecompressString) == "function") then
		return nil
	end
	local ok, z = pcall(enc.CompressString, json, zlibMethod())
	if not ok or type(z) ~= "string" then return nil end
	local body
	ok, body = pcall(enc.EncodeBase64, z)
	if not ok or type(body) ~= "string" or not find(body, "^[A-Za-z0-9+/]+=?=?$") or #body % 4 ~= 0 then return nil end
	local ok2, back = pcall(enc.DecodeBase64, body)
	if not ok2 or type(back) ~= "string" then return nil end
	ok2, back = pcall(enc.DecompressString, back, zlibMethod())
	if not ok2 or back ~= json then return nil end
	return body
end

-- A JSON payload in the envelope.
function P.Pack(json)
	return PREFIX .. ns.Import.Adler32(json) .. "!" .. (clientBody(json) or base64(zlibStored(json)))
end

local function migrationIds()
	local ids = {}
	local done = ns.DB().migrations
	for _, id in ipairs(migrationOrder) do
		if type(done) == "table" and done[id] then ids[#ids + 1] = id end
	end
	sort(ids)
	return ids
end

-- The parts of a profile a string may carry on its own: "look" (the
-- settings on the Look pages), "positions" (where things were dragged to),
-- "guiding" (everything else: what Polestar does and shows).
P.AREAS = { "look", "guiding", "positions" }

local function areaOf(path, look)
	if positions[path] then return "positions" end
	if look[path] then return "look" end
	return "guiding"
end
P.AreaOf = function(path) return areaOf(path, select(2, controls())) end

-- opts.areas = { look = true, ... } (every area when nil); opts.look: the look alone.
local function areasOf(opts)
	if opts and opts.look then return { look = true } end
	return opts and opts.areas or nil
end

-- The settings of profile `name` (the one in use when nil) that a string
-- carries: path -> value, only those off their default and valid. -> settings, count
function P.Portable(name, opts)
	name = name or P.Active()
	local src = data(name)
	if not src then return nil, missing(name) end
	local index, look = controls()
	local areas = areasOf(opts)
	local out, n = {}, 0
	for path, v in pairs(leaves(src)) do
		if not areas or areas[areaOf(path, look)] then
			local fitted = fit(path, v, index[path])
			if fitted ~= nil and not same(fitted, ns.GetDefault(path)) then
				out[path] = fitted
				n = n + 1
			end
		end
	end
	return out, n
end

-- The screen positions are measured on: its pixels and the UI's scale.
local function screen()
	local w, h = 0, 0
	if GetPhysicalScreenSize then w, h = GetPhysicalScreenSize() end
	local scale = UIParent and UIParent.GetEffectiveScale and UIParent:GetEffectiveScale() or 1
	return { w = tonumber(w) or 0, h = tonumber(h) or 0, scale = floor((tonumber(scale) or 1) * 1000 + 0.5) / 1000 }
end

-- -> string, the number of settings in it | nil, why
function P.Export(name, opts)
	name = name or P.Active()
	local settings, n = P.Portable(name, opts)
	if not settings then return nil, n end
	local keys = {}
	for path in pairs(settings) do keys[#keys + 1] = path end
	sort(keys)
	local parts = {}
	for i, path in ipairs(keys) do parts[i] = jstr(path) .. ":" .. jvalue(settings[path]) end
	local ids = {}
	for i, id in ipairs(migrationIds()) do ids[i] = jstr(id) end
	local areas = areasOf(opts)
	local list = {}
	for _, a in ipairs(P.AREAS) do
		if not areas or areas[a] then list[#list + 1] = jstr(a) end
	end
	local only = areas and areas.look and not areas.guiding and not areas.positions
	local json = format('{"format":%d,"name":%s,%s"areas":[%s],"screen":%s,"migrations":[%s],"settings":{%s}}', FORMAT, jstr(name),
		only and '"scope":"look",' or "", concat(list, ","), jvalue(screen()), concat(ids, ","), concat(parts, ","))
	return P.Pack(json), n
end

---------------------------------------------------------------------------
-- Reading a string
---------------------------------------------------------------------------

local function damaged() return L["This profile string is damaged or incomplete. Copy the whole string again."] end

-- The JSON in a string. -> text | nil, why
local function unpack(s)
	local sum, body = s:match("^!PSS1!(%x%x%x%x%x%x%x%x)!([A-Za-z0-9+/]+=?=?)$")
	if not sum or #body % 4 ~= 0 then return nil, damaged() end
	local enc = C_EncodingUtil
	if not (type(enc) == "table" and type(enc.DecodeBase64) == "function" and type(enc.DecompressString) == "function") then
		return nil, L["This game client cannot read import strings."]
	end
	local ok, packed = pcall(enc.DecodeBase64, body)
	if not ok or type(packed) ~= "string" then return nil, damaged() end
	local raw
	ok, raw = pcall(enc.DecompressString, packed, zlibMethod())
	if not ok or type(raw) ~= "string" then return nil, damaged() end
	if #raw > LIMITS.payload then return nil, L["This profile string holds too much to be a Polestar profile."] end
	if ns.Import.Adler32(raw) ~= lower(sum) then return nil, damaged() end
	return raw
end

-- A setting's label on the Options pages, else its path.
local function labelOf(path, c)
	local l = c and c.label
	if type(l) == "function" then
		local ok, s = pcall(l)
		l = ok and s or nil
	end
	return type(l) == "string" and l or path
end

-- Text pasted on the Profiles page. -> preview | nil, why
--   preview = { name, look, count, settings = { path -> value }, keys = { path, ... },
--               labels = { path -> label }, changes = { path, ... } (differ from the profile in use),
--               dropped = { path, ... } }
function P.Import(text)
	if type(text) ~= "string" then return nil, L["Paste a profile string."] end
	local s = gsub(text, "%s+", "")
	if s == "" then return nil, L["Paste a profile string."] end
	if #s > LIMITS.length then return nil, L["This profile string holds too much to be a Polestar profile."] end
	local version = s:match("^!PSS(%d+)!")
	if not version then
		if s:match("^!PS%d+!") then return nil, L["This is a guide import string: paste it on the Import page."] end
		return nil, L["This is not a Polestar profile string."]
	end
	if version ~= "1" then return nil, L["This profile string needs a newer Polestar."] end
	local raw, why = unpack(s)
	if not raw then return nil, why end
	local tree = ns.Import.ParseJSON(raw)
	if type(tree) ~= "table" or not finite(tree.format) or type(tree.settings) ~= "table" then return nil, damaged() end
	if tree.format > FORMAT then return nil, L["This profile string needs a newer Polestar."] end
	-- The settings as a profile table, so the migrations the string is from
	-- before can run over it first.
	local nested, n, dropped = {}, 0, {}
	for path, v in pairs(tree.settings) do
		n = n + 1
		if n > LIMITS.settings then return nil, L["This profile string holds too much to be a Polestar profile."] end
		local ok = type(path) == "string" and #path <= LIMITS.path and find(path, "^[%w_]+%.[%w_]+") ~= nil
			and not find(path, "%.%.") and not find(path, "%.$")
		local keys = {}
		if ok then
			for k in path:gmatch("[^.]+") do keys[#keys + 1] = k end
			ok = #keys <= 4
		end
		local node = nested
		for i = 1, ok and #keys - 1 or 0 do
			local k = keys[i]
			if node[k] == nil then node[k] = {} end
			if type(node[k]) ~= "table" then
				ok = false
				break
			end
			node = node[k]
		end
		if ok and node[keys[#keys]] == nil then
			node[keys[#keys]] = v
		else
			dropped[#dropped + 1] = ns.EscapeText(tostring(path))
		end
	end
	local applied = {}
	if type(tree.migrations) == "table" then
		for i, id in ipairs(tree.migrations) do
			if i > LIMITS.migrations then break end
			if type(id) == "string" then applied[id] = true end
		end
	end
	for _, id in ipairs(migrationOrder) do
		if not applied[id] then ns.SafeCall(migrations[id], nested) end
	end
	local index, look = controls()
	local preview = { settings = {}, keys = {}, labels = {}, area = {}, areas = { look = 0, guiding = 0, positions = 0 },
		changes = {}, dropped = dropped, look = tree.scope == "look" }
	for path, v in pairs(leaves(nested)) do
		local fitted = fit(path, v, index[path])
		if fitted == nil then
			dropped[#dropped + 1] = ns.EscapeText(path)
		else
			local area = areaOf(path, look)
			preview.settings[path] = fitted
			preview.keys[#preview.keys + 1] = path
			preview.labels[path] = labelOf(path, index[path])
			preview.area[path] = area
			preview.areas[area] = preview.areas[area] + 1
			if not same(fitted, ns.Get(path)) then preview.changes[#preview.changes + 1] = path end
		end
	end
	preview.count = #preview.keys
	local byLabel = function(a, b)
		local la, lb = preview.labels[a], preview.labels[b]
		if la ~= lb then return la < lb end
		return a < b
	end
	sort(preview.keys, byLabel)
	sort(preview.changes, byLabel)
	sort(dropped)
	preview.name = type(tree.name) == "string" and cleanName(tree.name) or nil
	-- Positions made on another screen or at another UI scale may sit off.
	local from, here = tree.screen, screen()
	if preview.areas.positions > 0 and type(from) == "table" and finite(from.w) and finite(from.h) and finite(from.scale) then
		preview.otherScreen = from.w ~= here.w or from.h ~= here.h or abs(from.scale - here.scale) > 0.01
	end
	return preview
end

-- A name for an imported profile that is not taken: the string's, else
-- "Imported", with " 2", " 3", ... after it.
function P.FreeName(base)
	base = base and cleanName(base) or L["Imported"]
	if not P.Exists(base) then return base end
	for i = 2, LIMITS.profiles + 1 do
		local suffix = " " .. i
		local name = sub(base, 1, LIMITS.name - #suffix) .. suffix
		if not P.Exists(name) then return name end
	end
	return nil
end

-- The preview's settings into the profile in use (name = P.Active(): each
-- through ns.Set, the rest kept) or as the new profile `name` (every other
-- setting at its default). areas: { look = true, ... } to take only those
-- (all when nil). -> true | nil, why
function P.Apply(preview, name, areas)
	if type(preview) ~= "table" or type(preview.settings) ~= "table" or type(preview.keys) ~= "table" then return nil, damaged() end
	local keys = {}
	for _, path in ipairs(preview.keys) do
		if not areas or areas[preview.area and preview.area[path] or "guiding"] then keys[#keys + 1] = path end
	end
	if #keys == 0 then return nil, L["Nothing to apply: every part of the string is unticked."] end
	if name == nil or name == P.Active() then
		for _, path in ipairs(keys) do ns.Set(path, deepCopy(preview.settings[path])) end
		ns.Fire("PROFILES_CHANGED")
		return true
	end
	local made, why = P.New(name)
	if not made then return nil, why end
	local t = store()[made]
	for _, path in ipairs(keys) do
		local v = preview.settings[path]
		if not same(v, ns.GetDefault(path)) then
			local node = t
			local keys = {}
			for k in path:gmatch("[^.]+") do keys[#keys + 1] = k end
			for i = 1, #keys - 1 do
				if type(node[keys[i]]) ~= "table" then node[keys[i]] = {} end
				node = node[keys[i]]
			end
			node[keys[#keys]] = deepCopy(v)
		end
	end
	return true
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
