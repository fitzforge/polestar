-- The player's own changes to the built-in stat weights (#1529).
--
-- A player who thinks one stat is worth more or less than Polestar says
-- changes just that stat, and keeps everything else, including any later
-- update to the defaults (Gear.WeightsFor). An edit is kept as a multiple of
-- the default it was made against, so "Stamina 0.75" at a default of 0.5 is
-- "Stamina x1.5" and stays half again of whatever Stamina's default becomes;
-- a stat the spec has no weight for (or a weight of 0) is kept as the plain
-- value typed.
--
--   PolestarDB.gearAdjust[CLASS][specKey][stat] = { x = multiple } | { v = value }
--       Outside the settings, like the Pawn scales (Pawn.lua), so a settings
--       reset does not wipe them; Revert does.
--
--   Gear.Adjust.Edits(class, spec) -> { [stat] = edit } | nil (read-only)
--   Gear.Adjust.Count(class, spec) -> how many stats are changed
--   Gear.Adjust.Set(class, spec, key, value[, level]) -> true | false, err
--       The weight the player wants at `level` (default: theirs). A value
--       equal to the default clears the edit. err: "class" (no such spec),
--       "stat" (not a Polestar stat key), "number" (not a finite number).
--   Gear.Adjust.Clear(class, spec, key) -> bool: that stat back to its default
--   Gear.Adjust.Revert(class, spec) -> how many edits it cleared
--   Gear.Adjust.Apply(weights, class, spec) -> weights: the built-in weights
--       with the edits on top (the same table when there are none; a new one,
--       cached until the next change, when there are)
--   Gear.Adjust.Rows(class, spec[, level]) -> { { key, value, default, edited }, ... }
--       Every stat the spec weighs or the player added, in Gear.STAT_KEYS
--       order, at `level`: what the adjust window lists.

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

local function level(lv)
	lv = tonumber(lv)
	if lv then return lv end
	local p = Gear.GetPlayer and Gear.GetPlayer()
	return p and p.level or 1
end

-- The built-in weight of a stat at a level (no edits): 0 when the spec has none.
local function default(class, spec, key, lv)
	local w = Gear.WeightsFor(class, spec, level(lv))
	return w and w[key] or 0
end

-- An edit's weight over a default.
local function value(edit, d)
	if edit.x then return d * edit.x end
	return edit.v or 0
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
-- weights (the level band moved).
local version = 0
local applied = setmetatable({}, { __mode = "k" }) -- base weights -> { version, class, spec, weights }

-- The weights changed: Gear rescores, the windows and options rows look again.
local function changed()
	version = version + 1
	if Gear.Invalidate then Gear.Invalidate("spec") end
	local W = ns.Widgets
	if W and W.RefreshAll then W.RefreshAll() end
end

function Adjust.Set(class, spec, key, v, lv)
	if not isSpec(class, spec) then return false, "class" end
	if not isStat(key) then return false, "stat" end
	if type(v) == "string" then v = Gear.Pawn and Gear.Pawn.Number and Gear.Pawn.Number(v) or tonumber(v) end
	if not finite(v) then return false, "number" end
	local d = default(class, spec, key, lv)
	if abs(v - d) < EPS then
		Adjust.Clear(class, spec, key)
		return true
	end
	local all = store(true)
	all[class] = all[class] or {}
	all[class][spec] = all[class][spec] or {}
	all[class][spec][key] = d ~= 0 and { x = v / d } or { v = v }
	changed()
	return true
end

function Adjust.Clear(class, spec, key)
	local t = Adjust.Edits(class, spec)
	if not (t and t[key]) then return false end
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
	for k, edit in pairs(edits) do
		if type(edit) == "table" then out[k] = value(edit, weights[k] or 0) end
	end
	applied[weights] = { version = version, class = class, spec = spec, weights = out }
	return out
end

function Adjust.Rows(class, spec, lv)
	if not isSpec(class, spec) then return {} end
	local base = Gear.WeightsFor(class, spec, level(lv)) or {}
	local edits = Adjust.Edits(class, spec) or {}
	local rows = {}
	for _, key in ipairs(Gear.STAT_KEYS) do
		local d, edit = base[key], edits[key]
		if d ~= nil or edit then
			d = d or 0
			rows[#rows + 1] = { key = key, default = d, value = edit and value(edit, d) or d, edited = edit ~= nil }
		end
	end
	return rows
end
