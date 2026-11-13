-- Forever Leveling BiS's public API (the global ForeverLevelingBiS_API): gear
-- scores from Forever Leveling BiS by Timearc when it is installed, through
-- its public API. Nothing of that addon is copied into Polestar: every answer
-- is asked of the copy the player runs, while gear advice and gear.useFlbis
-- are on (Settings > Questing > Rewards & gear > Gear advice); Gear.lua uses
-- the answers only while Stat weights is Automatic (Gear.UsesFLB). Every call
-- is guarded (pcall, a type check of each answer), so an API that changes,
-- errors or answers in a shape not known here leaves Polestar's own advice.
--
-- The API, by its `version` field:
--   1 (Forever Leveling BiS 1.2.1 and later)
--     IsUpgrade(link) -> true when its bag arrow marks the item (false while
--         its Bag upgrades switch is off, or while the item loads)
--     OnChanged(func): func() runs whenever its answers may have changed (gear,
--         level, spec, stat weights, item data)
--   2 (announced for its next update), also
--     GetGain(link) -> the item's gain over what it would replace, in percent
--     ScoreItem(link) -> the item's score
--     GetWeights(class, spec, level) -> { [stat] = weight }
--     GetSpec() -> the spec the player picked in it; nil on its automatic pick
-- Version 2's answers are read as announced, and tolerantly: a gain or score
-- may come in a table (pct, percent or gain; score); a spec as a key, a table
-- with a spec field, or a class and spec pair; weights under its own stat
-- names or Polestar's.
--
--   Gear.FLB.Installed() -> bool: the API is there (whatever the settings say)
--   Gear.FLB.HasGain() -> bool: it has version 2's GetGain
--   Gear.FLB.Version() -> n | nil: its version while Polestar may use it
--   Gear.FLB.BagUpgrade(link) -> bool | nil (nil: no answer, Polestar's own)
--   Gear.FLB.Gain(link) -> percent | nil
--   Gear.FLB.Score(link) -> score | nil
--   Gear.FLB.Weights(class, spec, level) -> weights in Polestar's keys | nil
--   Gear.FLB.Spec(class) -> a spec key of Gear.CLASSES[class] | nil
-- Its OnChanged gets one listener per API table, the first time the API is
-- asked while it may be used; the listener redoes gear advice (once a frame
-- however many changes arrive together) while Polestar still uses it.

local ADDON, ns = ...

local Gear = ns.Gear or {}
ns.Gear = Gear

local type, pairs, ipairs, pcall, tonumber = type, pairs, ipairs, pcall, tonumber
local huge = math.huge

local FLB = {}
Gear.FLB = FLB

local GLOBAL = "ForeverLevelingBiS_API"

-- A finite number, else nil.
local function num(v)
	v = tonumber(v)
	if v and v == v and v ~= huge and v ~= -huge then return v end
	return nil
end

local function api()
	local t = _G[GLOBAL]
	return type(t) == "table" and t or nil
end

function FLB.Installed()
	return api() ~= nil
end

-- Whether it answers with gains (version 2's GetGain is there).
function FLB.HasGain()
	local t = api()
	return t ~= nil and type(t.GetGain) == "function"
end

-- t[name](...) when it is a function, guarded: ok, then its first two answers.
local function ask(name, ...)
	local t = api()
	local f = t and t[name]
	if type(f) ~= "function" then return false end
	local ok, a, b = pcall(f, ...)
	if not ok then return false end
	return true, a, b
end

-- Its answers changed: gear advice again, once a frame.
local queued = false
local function changed()
	if queued or not FLB.Version() then return end
	queued = true
	ns.After(0, function()
		queued = false
		if Gear.Invalidate then Gear.Invalidate("flbis") end
	end)
end

local listening = setmetatable({}, { __mode = "k" }) -- API tables with our listener

function FLB.Version()
	if not (ns.Get("gear.useFlbis") and Gear.IsEnabled and Gear.IsEnabled()) then return nil end
	local t = api()
	if not t then return nil end
	local v = num(t.version) or (type(t.IsUpgrade) == "function" and 1) or nil
	if not v or v < 1 then return nil end
	if not listening[t] then
		listening[t] = true
		ask("OnChanged", changed)
	end
	return v
end

function FLB.BagUpgrade(link)
	if type(link) ~= "string" or not FLB.Version() then return nil end
	local ok, up = ask("IsUpgrade", link)
	if not ok then return nil end
	return up == true -- its "no" stands, whatever form it takes
end

function FLB.Gain(link)
	if type(link) ~= "string" or (FLB.Version() or 0) < 2 then return nil end
	local ok, g = ask("GetGain", link)
	if not ok then return nil end
	if type(g) == "table" then g = g.pct or g.percent or g.gain end
	return num(g)
end

function FLB.Score(link)
	if type(link) ~= "string" or (FLB.Version() or 0) < 2 then return nil end
	local ok, s = ask("ScoreItem", link)
	if not ok then return nil end
	if type(s) == "table" then s = s.score end
	return num(s)
end

-- Its spec keys where they differ from Polestar's: its melee Survival and
-- Bear weights belong to Polestar's Survival and Feral.
local SPEC_ALIAS = { survivalmelee = "survival", bear = "feral", feralcombat = "feral" }

function FLB.Spec(class)
	if type(class) ~= "string" or (FLB.Version() or 0) < 2 then return nil end
	local ok, a, b = ask("GetSpec")
	if not ok then return nil end
	local spec = a
	if type(a) == "table" then
		spec = a.spec or a.key
	elseif type(b) == "string" then
		-- A class and spec pair: another class's spec is no answer.
		if type(a) == "string" and a:upper() == class:upper() then spec = b elseif type(a) ~= "string" then spec = b end
	end
	if type(spec) ~= "string" then return nil end
	spec = (spec:lower():gsub("[^%a]", ""))
	spec = SPEC_ALIAS[spec] or spec
	local meta = Gear.CLASSES and Gear.CLASSES[class]
	for _, s in ipairs(meta and meta.specs or {}) do
		if s.key == spec then return spec end
	end
	return nil
end

-- Its stat names, as its item data and weights use them, -> Polestar's. A
-- crit or hit per 1% (critPct, hitPct: Forever pools them) goes to spell crit
-- and spell hit for casters and healers, to crit and hit for the rest; spell
-- power splits into damage (sp) and healing (heal); its haste and expertise
-- ratings, per rating point, become per 1% (below). Speed weights and the
-- rating points Forever items do not carry are not Polestar's to weigh.
local NAMES = {
	str = "str", agi = "agi", sta = "sta", int = "int", spi = "spi", armor = "armor", health = "health", mana = "mana",
	atkpwr = "ap", rgdatkpwr = "rap",
	arcsplpwr = "spArcane", firsplpwr = "spFire", frosplpwr = "spFrost", holsplpwr = "spHoly", natsplpwr = "spNature", shasplpwr = "spShadow",
	manargn = "mp5", healthrgn = "hp5", dps = "dps", ohDps = "ohDps", rangedDps = "rdps",
	defrtng = "defense", dodgePct = "dodge", parryPct = "parry", blockPct = "block", block = "blockValue",
}
-- Polestar's own keys an answer may use instead ("block" is its block value).
local OWN = {}
for _, k in ipairs(Gear.STAT_KEYS or {}) do OWN[k] = true end
OWN.block = nil

-- The specs whose crit and hit are spells': casters and healers.
local SPELLS = {
	PALADIN = { holy = true },
	PRIEST = { discipline = true, holy = true, shadow = true },
	SHAMAN = { elemental = true, restoration = true },
	MAGE = { arcane = true, fire = true, frost = true },
	WARLOCK = { affliction = true, demonology = true, destruction = true },
	DRUID = { balance = true, restoration = true },
}

function FLB.Weights(class, spec, level)
	if (FLB.Version() or 0) < 2 then return nil end
	local ok, t = ask("GetWeights", class, spec, level)
	if not (ok and type(t) == "table") then return nil end
	local spells = SPELLS[class] and SPELLS[class][spec] or false
	local w, n = {}, 0
	local function put(k, v)
		w[k] = (w[k] or 0) + v
		n = n + 1
	end
	local r = {}
	for k, v in pairs(t) do
		v = num(v)
		if type(k) == "string" and v then r[k] = v end
	end
	for k, v in pairs(r) do
		if v ~= 0 then
			if NAMES[k] then
				put(NAMES[k], v)
			elseif k == "critPct" then
				put(spells and "spellCrit" or "crit", v)
			elseif k == "hitPct" then
				put(spells and "spellHit" or "hit", v)
			elseif OWN[k] then
				put(k, v)
			end
		end
	end
	-- Spell power: "+spell power" is damage and healing, so each takes its own
	-- number (its spell damage, its healing), or the rest of spell power.
	local splpwr, spldmg, splheal = r.splpwr or 0, r.spldmg, r.splheal
	local sp = spldmg or (splpwr - (splheal or 0))
	local heal = splheal or (splpwr - (spldmg or 0))
	if sp > 0 then put("sp", sp) end
	if heal > 0 then put("heal", heal) end
	-- Haste and expertise per rating point -> per 1%: 10 rating points per 1%
	-- (gametables/combatratings.txt), at the rating per 1% its own numbers
	-- were made with where they say (1% crit against a point of crit rating:
	-- 14 points per 1% in the client's table).
	local per = (r.critPct and (r.critstrkrtng or 0) > 0) and r.critPct / (14 * r.critstrkrtng) or 1
	if (r.hastertng or 0) > 0 then put("haste", r.hastertng * 10 * per) end
	if (r.exprtng or 0) > 0 then put("expertise", r.exprtng * 10 * per) end
	if n == 0 then return nil end
	return w
end
