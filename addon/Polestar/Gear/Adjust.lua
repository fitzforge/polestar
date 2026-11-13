-- The player's own changes to the built-in stat weights (#1529).
--
-- A player who thinks one stat is worth more or less than Polestar says
-- changes just that stat, and keeps everything else, including any later
-- update to the defaults (Gear.WeightsFor). An edit is kept as the number
-- typed: "Stamina 0.75" stays 0.75 whatever Stamina's default becomes, and
-- every stat not edited follows the defaults.
--
--   PolestarDB.gearAdjust[CLASS][specKey][stat] = number
--       Outside the settings, like the Pawn scales (Pawn.lua), so a settings
--       reset does not wipe them; Revert does.
--
--   Gear.Adjust.Edits(class, spec) -> { [stat] = number } | nil (read-only)
--   Gear.Adjust.Count(class, spec) -> how many stats are changed
--   Gear.Adjust.Set(class, spec, key, value) -> true | false, err
--       The weight the player wants. A value equal to the default clears the
--       edit. err: "class" (no such spec), "stat" (not a Polestar stat key),
--       "number" (not a finite number).
--   Gear.Adjust.Clear(class, spec, key) -> bool: that stat back to its default
--   Gear.Adjust.Revert(class, spec) -> how many edits it cleared
--   Gear.Adjust.Apply(weights, class, spec) -> weights: the built-in weights
--       with the edits on top (the same table when there are none; a new one,
--       cached until the next change, when there are)
--   Gear.Adjust.Rows(class, spec) -> { { key, value, default, edited }, ... }
--       Every stat the spec weighs or the player added, in Gear.STAT_KEYS
--       order: what the adjust window lists.

local ADDON, ns = ...

local Gear = ns.Gear or {}
ns.Gear = Gear

local type, tonumber, pairs, ipairs, next = type, tonumber, pairs, ipairs, next
local abs = math.abs

local Adjust = {}
Gear.Adjust = Adjust

local EPS = 1e-9

local function store(make)
	local db = ns.DB()
	if type(db.gearAdjust) ~= "table" then
		if not make then return nil end
		db.gearAdjust = {}
	end
	return db.gearAdjust
end

local function finite(n)
	return type(n) == "number" and n == n and n ~= math.huge and n ~= -math.huge
end

local function isStat(key)
	for _, k in ipairs(Gear.STAT_KEYS) do
		if k == key then return true end
	end
	return false
end

local function isSpec(class, spec)
	return type(class) == "string" and type(spec) == "string" and Gear.WEIGHTS[class] ~= nil and Gear.WEIGHTS[class][spec] ~= nil
end

-- The built-in weights of a spec (no edits).
local function defaults(class, spec)
	local p = Gear.GetPlayer and Gear.GetPlayer()
	return Gear.WeightsFor(class, spec, p and p.level or 1) or {}
end

function Adjust.Edits(class, spec)
	local all = store(false)
	local t = all and all[class] and all[class][spec]
	if type(t) ~= "table" or next(t) == nil then return nil end
	return t
end

function Adjust.Count(class, spec)
	local t = Adjust.Edits(class, spec)
	local n = 0
	if t then
		for _ in pairs(t) do n = n + 1 end
	end
	return n
end

-- Applied tables, rebuilt after a change (version) or for other built-in
-- weights (an update to the defaults).
local version = 0
local applied = setmetatable({}, { __mode = "k" }) -- base weights -> { version, class, spec, weights }

-- The weights changed: Gear rescores, the windows and options rows look again.
local function changed()
	version = version + 1
	if Gear.Invalidate then Gear.Invalidate("spec") end
	local W = ns.Widgets
	if W and W.RefreshAll then W.RefreshAll() end
end

function Adjust.Set(class, spec, key, v)
	if not isSpec(class, spec) then return false, "class" end
	if not isStat(key) then return false, "stat" end
	if type(v) == "string" then v = Gear.Pawn and Gear.Pawn.Number and Gear.Pawn.Number(v) or tonumber(v) end
	if not finite(v) then return false, "number" end
	if abs(v - (defaults(class, spec)[key] or 0)) < EPS then
		Adjust.Clear(class, spec, key)
		return true
	end
	local all = store(true)
	all[class] = all[class] or {}
	all[class][spec] = all[class][spec] or {}
	all[class][spec][key] = v
	changed()
	return true
end

function Adjust.Clear(class, spec, key)
	local t = Adjust.Edits(class, spec)
	if not (t and t[key] ~= nil) then return false end
	t[key] = nil
	if next(t) == nil then store(false)[class][spec] = nil end
	changed()
	return true
end

function Adjust.Revert(class, spec)
	local n = Adjust.Count(class, spec)
	if n == 0 then return 0 end
	store(false)[class][spec] = nil
	changed()
	return n
end

function Adjust.Apply(weights, class, spec)
	local edits = weights and Adjust.Edits(class, spec)
	if not edits then return weights end
	local c = applied[weights]
	if c and c.version == version and c.class == class and c.spec == spec then return c.weights end
	local out = {}
	for k, w in pairs(weights) do out[k] = w end
	for k, v in pairs(edits) do
		if finite(v) then out[k] = v end
	end
	applied[weights] = { version = version, class = class, spec = spec, weights = out }
	return out
end

function Adjust.Rows(class, spec)
	if not isSpec(class, spec) then return {} end
	local base = defaults(class, spec)
	local edits = Adjust.Edits(class, spec) or {}
	local rows = {}
	for _, key in ipairs(Gear.STAT_KEYS) do
		local d, v = base[key], edits[key]
		if not finite(v) then v = nil end
		if d ~= nil or v ~= nil then
			d = d or 0
			rows[#rows + 1] = { key = key, default = d, value = v or d, edited = v ~= nil }
		end
	end
	return rows
end
