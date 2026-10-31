-- Custom stat weights from Pawn scale strings.
--
--   Gear.Pawn.Parse(text) -> parsed | nil, err
--       parsed = { name (nil without one), version, stats = { [pawn name as
--                  written] = number }, order = { names in the string },
--                  meta = { [key as written] = value } }
--       err: "empty" | "notpawn" | "version" | "nostats" | "toolong"
--       ( Pawn: v1: "Name": Class=Warrior, Spec=1, Strength=2.0, ... ) with
--       optional parentheses and spaces, a quoted name that may be missing,
--       and Key=Number pairs, numbers like 1, 1.5, .5, -2.
--   Gear.Pawn.Weights(parsed) -> weights, mapped, ignored
--       Polestar weights (PawnStats.lua), how many Pawn stats mapped, and the
--       names of the ones that did not.
--
--   Gear.Scales: the player's imported scales, kept per class in
--   PolestarDB.gearScales[CLASS] = { { id, name, weights, source (the string
--   Export gives), original (the string as imported; an older scale has only
--   source), date (time()), ignored (the Pawn stats left out), edited }, ... }. Outside the settings so that a
--   settings reset does not wipe them. The chosen scale is the setting
--   gear.spec.<CLASS> = "custom:<id>".
--   Gear.Scales.List(class) -> list (read-only)
--   Gear.Scales.All(first) -> { { class, scale }, ... }: every class's scales,
--       the class `first` before the rest, each class by name
--   Gear.Scales.Get(class, id) -> scale | nil
--   Gear.Scales.Chosen(class) -> scale | nil (the setting's, when it exists)
--   Gear.Scales.Import(text[, class]) -> true, result | false, err
--       result = { scale, class, mapped, ignored, updated }; a string that
--       names its class is kept for that class, else for `class` (default
--       the player's). Same name again updates that scale. More errors:
--       "class" (a class with no weights), "full".
--   Gear.Scales.Rename(class, id, name) -> true | false, err ("name"|"gone")
--   Gear.Scales.SetWeight(class, id, key, value) -> true | false, err
--       ("gone" | "stat" (not a Polestar stat key) | "number"): change or add
--       one weight. An edit marks the scale `edited` and rebuilds its string,
--       so Export matches what the window shows; the string as imported stays
--       in `original`.
--   Gear.Scales.RemoveWeight(class, id, key) -> true | false
--   Gear.Scales.Reset(class, id) -> true | false: back to the original string
--   Gear.Scales.CopyBuiltin(class, specKey) -> true, result | false, err: a new
--       scale from the built-in weights of that spec at the player's level
--   Gear.Pawn.Build(name, class, weights) -> a Pawn string for the weights
--   Gear.Pawn.NameOf(key) -> the Pawn name of a Polestar stat key
--   Gear.Pawn.Number(text) -> number | nil: the numbers a string may hold
--   Gear.Scales.Delete(class, id) -> true | false; back to Automatic when it
--       was the chosen one
--   Gear.Scales.Export(class, id) -> the original string | nil
--   Gear.Scales.ErrorText(err) -> a sentence for the player
--
-- Scale: an imported scale is used as it is, not rescaled. Upgrade
-- percentages are ratios of two scores of the same scale, so they do not
-- depend on its size; only the absolute numbers of /polestar gear differ from
-- the built-in specs (whose main stat is about 1).

local ADDON, ns = ...

local Gear = ns.Gear or {}
ns.Gear = Gear
local L = ns.L

local type, tonumber, tostring, pairs, ipairs = type, tonumber, tostring, pairs, ipairs
local lower = string.lower

local Pawn = {}
Gear.Pawn = Pawn

local MAX_LENGTH = 6000
local MAX_NAME = 40
local MAX_SCALES = 20

-- lowercased Pawn name -> entry
local byName = {}
for _, e in ipairs(Gear.PAWN_STATS or {}) do
	byName[lower(e.pawn)] = e
	for _, a in ipairs(e.alias or {}) do byName[lower(a)] = e end
end

-- Linear: a "%s+$" pattern retries from every space of a long gap, which takes
-- seconds on a few thousand spaces.
local function trim(s)
	local first = s:find("%S")
	return first and s:match(".*%S", first) or ""
end

local HUGE = math.huge

local function finite(n)
	return type(n) == "number" and n == n and n > -HUGE and n < HUGE
end

-- A plain decimal: 1, 1.5, .5, 1., -2, +3. Not hex, not an exponent, and
-- not so many digits that it reads as infinity.
local function number(s)
	if type(s) ~= "string" then return nil end
	s = trim(s)
	if not s:find("%d") or not s:find("^[+-]?%d*%.?%d*$") then return nil end
	local n = tonumber(s)
	return finite(n) and n or nil
end
Pawn.Number = number

function Pawn.Parse(text)
	if type(text) ~= "string" then return nil, "empty" end
	if #text > MAX_LENGTH then return nil, "toolong" end
	local s = trim(text)
	if s == "" then return nil, "empty" end
	-- The outer parentheses are optional.
	s = trim((s:gsub("^%(", ""):gsub("%)$", "")))
	local rest = s:match("^[Pp][Aa][Ww][Nn]%s*:%s*(.*)$")
	if not rest then return nil, "notpawn" end
	local version = 1
	local v, after = rest:match("^[vV](%d+)%s*:%s*(.*)$")
	if v then
		version, rest = tonumber(v), after
		if version ~= 1 then return nil, "version" end
	end
	local name
	local q, quoted, tail = rest:match("^([\"'])(.-)%1%s*:?%s*(.*)$")
	if q then
		name, rest = trim(quoted), tail
		if name == "" then name = nil end
	end
	local parsed = { name = name, version = version, stats = {}, order = {}, meta = {}, skipped = {} }
	for part in (rest .. ","):gmatch("([^,]*),") do
		local key, value = trim(part):match("^([%a_][%w_]*)%s*=%s*(.-)$")
		if key then
			local n = number(value)
			if n and not Gear.PAWN_META[lower(key)] then
				if parsed.stats[key] == nil then parsed.order[#parsed.order + 1] = key end
				parsed.stats[key] = n
			elseif value:lower() == "x" and not Gear.PAWN_META[lower(key)] then
				-- Pawn's "ignore this stat" marker.
				parsed.skipped[#parsed.skipped + 1] = key
			else
				parsed.meta[key] = n or value
			end
		end
	end
	if #parsed.order == 0 and #parsed.skipped == 0 then return nil, "nostats" end
	return parsed
end

-- Polestar stat key -> the Pawn name for it: the entry that names it alone
-- (MeleeDps for dps), else any.
local nameOfKey
function Pawn.NameOf(key)
	if not nameOfKey then
		nameOfKey = {}
		for pass = 1, 2 do
			for _, e in ipairs(Gear.PAWN_STATS or {}) do
				if (pass == 1) == (not e.generic and #e.to == 1) then
					for _, to in ipairs(e.to) do
						if not nameOfKey[to] then nameOfKey[to] = e.pawn end
					end
				end
			end
		end
	end
	return nameOfKey[key] or key
end

local function number3(v)
	local rounded = math.floor(math.abs(v) * 1000 + 0.5) / 1000
	if v < 0 and rounded ~= 0 then rounded = -rounded end
	return tostring(rounded)
end

-- The Pawn string for a scale: "( Pawn: v1: "Name": Class=Warrior, Strength=1, ... )".
function Pawn.Build(name, class, weights)
	local list = {}
	for key, value in pairs(weights) do list[#list + 1] = { Pawn.NameOf(key), value } end
	table.sort(list, function(a, b) return a[1] < b[1] end)
	local out = { "Class=" .. class:sub(1, 1) .. class:sub(2):lower() }
	for _, w in ipairs(list) do out[#out + 1] = w[1] .. "=" .. number3(w[2]) end
	return ('( Pawn: v1: "%s": %s )'):format((name or ""):gsub('"', "'"), table.concat(out, ", "))
end

-- -> weights, mapped, ignored
function Pawn.Weights(parsed)
	local weights, mapped, ignored = {}, 0, {}
	local specific = {}
	-- Specific entries first; generic ones only fill what those left.
	for _, key in ipairs(parsed.order) do
		local e = byName[lower(key)]
		if not e then
			ignored[#ignored + 1] = key
		else
			mapped = mapped + 1
			if not e.generic then
				for _, to in ipairs(e.to) do
					weights[to], specific[to] = parsed.stats[key], true
				end
			end
		end
	end
	for _, key in ipairs(parsed.order) do
		local e = byName[lower(key)]
		if e and e.generic then
			for _, to in ipairs(e.to) do
				if not specific[to] then weights[to] = parsed.stats[key] end
			end
		end
	end
	for _, key in ipairs(parsed.skipped) do ignored[#ignored + 1] = key end
	return weights, mapped, ignored
end

---------------------------------------------------------------------------
-- The player's scales
---------------------------------------------------------------------------

local Scales = {}
Gear.Scales = Scales

local EMPTY = {}

local function store(make)
	local db = ns.DB()
	if type(db.gearScales) ~= "table" then
		if not make then return nil end
		db.gearScales = {}
	end
	return db.gearScales
end

function Scales.List(class)
	local all = store(false)
	return all and all[class] or EMPTY
end

function Scales.All(first)
	local out, classes = {}, {}
	for class in pairs(store(false) or EMPTY) do
		if #Scales.List(class) > 0 then classes[#classes + 1] = class end
	end
	table.sort(classes, function(a, b)
		if (a == first) ~= (b == first) then return a == first end
		return a < b
	end)
	for _, class in ipairs(classes) do
		for _, scale in ipairs(Scales.List(class)) do out[#out + 1] = { class = class, scale = scale } end
	end
	return out
end

function Scales.Get(class, id)
	for _, s in ipairs(Scales.List(class)) do
		if s.id == id then return s end
	end
	return nil
end

local function chosenId(setting)
	return type(setting) == "string" and setting:match("^custom:(.+)$") or nil
end

-- The scale a gear.spec setting value names, if it still exists.
function Scales.FromSetting(class, setting)
	local id = chosenId(setting)
	return id and Scales.Get(class, id) or nil
end

function Scales.Chosen(class)
	return Scales.FromSetting(class, ns.Get("gear.spec." .. class))
end

local CLASS_OF_ID = {
	[1] = "WARRIOR", [2] = "PALADIN", [3] = "HUNTER", [4] = "ROGUE", [5] = "PRIEST",
	[7] = "SHAMAN", [8] = "MAGE", [9] = "WARLOCK", [11] = "DRUID",
}

local function classOf(name)
	if type(name) ~= "string" then return nil end
	local n = lower(name:gsub("[^%a]", ""))
	for class in pairs(Gear.CLASSES) do
		if lower(class) == n then return class end
	end
	-- Pawn also writes the class as its number (Class=1).
	local id = tonumber(name)
	return id and CLASS_OF_ID[id] or nil
end

-- A name that is safe in chat and the options window, and short.
local function cleanName(name)
	if type(name) ~= "string" then return nil end
	name = trim((name:gsub("|", ""):gsub("%c", " "):gsub("%s+", " ")))
	if #name > MAX_NAME then name = trim(name:sub(1, MAX_NAME)) end
	return name ~= "" and name or nil
end

local function sameName(a, b)
	return lower(a) == lower(b)
end

local function findByName(list, name, exceptId)
	for _, s in ipairs(list) do
		if s.id ~= exceptId and sameName(s.name, name) then return s end
	end
	return nil
end

local function nextDefaultName(list)
	local base = L["Pawn scale"]
	local name, n = base, 1
	while findByName(list, name) do
		n = n + 1
		name = base .. " " .. n
	end
	return name
end

-- The scales are no setting, so the options rows (the dropdown's shown name,
-- the buttons that need a scale) are told to look again.
local function changed()
	Gear.Invalidate("spec")
	local W = ns.Widgets
	if W and W.RefreshAll then W.RefreshAll() end
end

function Scales.Import(text, class)
	local parsed, err = Pawn.Parse(text)
	if not parsed then return false, err end
	local target = class
	for key, value in pairs(parsed.meta) do
		if lower(key) == "class" then
			target = classOf(tostring(value))
			if not target then return false, "class" end
		end
	end
	if not (target and Gear.CLASSES[target]) then return false, "class" end
	local weights, mapped, ignored = Pawn.Weights(parsed)
	if mapped == 0 then return false, "nostats" end
	local all = store(true)
	local list = all[target]
	if not list then
		list = {}
		all[target] = list
	end
	local name = cleanName(parsed.name)
	local existing = name and findByName(list, name)
	if not existing and #list >= MAX_SCALES then return false, "full" end
	local scale = existing
	local chosenName = name or nextDefaultName(list)
	if not scale then
		local db = ns.DB()
		db.gearScaleSeq = (db.gearScaleSeq or 0) + 1
		scale = { id = "c" .. db.gearScaleSeq }
		list[#list + 1] = scale
	end
	scale.name = chosenName
	scale.weights, scale.source, scale.ignored = weights, trim(text), ignored
	scale.original, scale.edited = scale.source, nil
	scale.date = time and time() or 0
	changed()
	return true, { scale = scale, class = target, mapped = mapped, ignored = ignored, updated = existing and true or false }
end

function Scales.Rename(class, id, name)
	local scale = Scales.Get(class, id)
	if not scale then return false, "gone" end
	name = cleanName(name)
	if not name then return false, "name" end
	if findByName(Scales.List(class), name, id) then return false, "taken" end
	scale.name = name
	changed()
	return true
end

function Scales.Delete(class, id)
	local list = Scales.List(class)
	for i, s in ipairs(list) do
		if s.id == id then
			table.remove(list, i)
			if chosenId(ns.Get("gear.spec." .. class)) == id then ns.Set("gear.spec." .. class, nil) end
			changed()
			return true
		end
	end
	return false
end

local function isStat(key)
	for _, k in ipairs(Gear.STAT_KEYS) do
		if k == key then return true end
	end
	return false
end

local function rebuild(class, scale)
	scale.source = Pawn.Build(scale.name, class, scale.weights)
	scale.edited = true
end

function Scales.SetWeight(class, id, key, value)
	local scale = Scales.Get(class, id)
	if not scale then return false, "gone" end
	if not isStat(key) then return false, "stat" end
	if type(value) == "string" then value = number(value) end
	if not finite(value) then return false, "number" end
	scale.weights[key] = value
	rebuild(class, scale)
	changed()
	return true
end

function Scales.RemoveWeight(class, id, key)
	local scale = Scales.Get(class, id)
	if not (scale and scale.weights[key] ~= nil) then return false end
	scale.weights[key] = nil
	rebuild(class, scale)
	changed()
	return true
end

function Scales.Reset(class, id)
	local scale = Scales.Get(class, id)
	local original = scale and (scale.original or scale.source)
	local parsed = original and Pawn.Parse(original)
	if not parsed then return false end
	local weights, _, ignored = Pawn.Weights(parsed)
	scale.weights, scale.ignored = weights, ignored
	scale.source, scale.edited = original, nil
	changed()
	return true
end

function Scales.CopyBuiltin(class, specKey)
	local meta = Gear.CLASSES[class]
	if not meta then return false, "class" end
	local list = Gear.Scales.List(class)
	if #list >= MAX_SCALES then return false, "full" end
	local weights = Gear.WeightsFor(class, specKey, Gear.GetPlayer().level)
	if not weights then return false, "class" end
	local label
	for _, spec in ipairs(meta.specs) do
		if spec.key == specKey then label = L[spec.label] end
	end
	local base = (L["%s (copy)"]):format(label or specKey)
	local name, n = base, 1
	while findByName(list, name) do
		n = n + 1
		name = base .. " " .. n
	end
	local all = store(true)
	all[class] = all[class] or {}
	local copy = {}
	for k, v in pairs(weights) do copy[k] = v end
	local db = ns.DB()
	db.gearScaleSeq = (db.gearScaleSeq or 0) + 1
	local scale = { id = "c" .. db.gearScaleSeq, name = name, weights = copy, ignored = {}, date = time and time() or 0 }
	scale.source = Pawn.Build(name, class, copy)
	scale.original = scale.source
	all[class][#all[class] + 1] = scale
	changed()
	return true, { scale = scale, class = class, mapped = 0, ignored = {}, updated = false }
end

function Scales.Export(class, id)
	local scale = Scales.Get(class, id)
	return scale and scale.source or nil
end

local ERRORS = {
	empty = L["Paste a Pawn scale string first."],
	toolong = L["That text is too long for a Pawn string."],
	notpawn = L["That is not a Pawn string. It starts with ( Pawn: v1: \"Name\": ..."],
	version = L["Only Pawn string version 1 is supported."],
	nostats = L["That Pawn string has no stat Polestar scores."],
	class = L["That scale is for a class Polestar has no weights for."],
	full = L["Too many custom scales for this class. Delete one first."],
	name = L["Give the scale a name."],
	taken = L["Another scale already has that name."],
	gone = L["That scale no longer exists."],
	stat = L["That is not a stat Polestar scores."],
	number = L["A weight is a number, like 1, 0.5 or -2."],
}

function Scales.ErrorText(err)
	return ERRORS[err] or tostring(err)
end

-- "Imported 'X': 9 stats, 2 ignored: A, B" (the ignored part when any).
function Scales.Summary(result)
	local head = (result.updated and L["Updated '%s': %d stats"] or L["Imported '%s': %d stats"]):format(result.scale.name, result.mapped)
	if #result.ignored > 0 then
		head = head .. (L[", %d ignored: %s"]):format(#result.ignored, table.concat(result.ignored, ", "))
	end
	return head
end
