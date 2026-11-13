-- Forever Leveling BiS's public API (the global ForeverLevelingBiS_API): gear
-- scores from Forever Leveling BiS by Timearc when it is installed, through
-- its public API. Nothing of that addon is copied into Polestar: every answer
-- is asked of the copy the player runs, while gear advice and gear.useFlbis
-- are on (Settings > Questing > Rewards & gear > Gear advice); Gear.lua uses
-- the answers only while Stat weights is Automatic (Gear.UsesFLB). Every call
-- is guarded (pcall, a type check of each answer), so an API that changes or
-- errors leaves Polestar's own advice, and a value it does not know (a spec,
-- a weapon setup, a stat, a weights source) is left aside, as its terms ask.
--
-- The API (its reference: https://github.com/thunder426/ForeverLevelingBiS-API,
-- also its API.md), by its `version` field (none: 1):
--   1 (Forever Leveling BiS 1.2.1 and later)
--     IsUpgrade(link) -> true when its bag arrow marks the item (false while
--         its Bag upgrades switch is off, or while the item loads)
--     OnChanged(func): func() runs whenever its answers may have changed (gear,
--         level, spec, weapon setup, stat weights, item data loading)
--   2 (1.2.9 and later), also
--     GetSpec() -> spec, setup, classFile: the main spec the player picked in
--         it, its weapon setup ("fury", "dualwield", "WARRIOR"); with none
--         picked, the class's first spec
--     GetWeights(classFile, spec, level, setup) -> weights, info: its stat
--         weights by its short stat names (a missing one is 0); info.source,
--         .profile, .fromLevel, .toLevel
--     ScoreItem(link, offHand) -> the item's score (nil: not gear), and true
--         while it loads
--     GetGain(link) -> the item's gain over the gear it is compared with, in
--         its score points, as its tooltip's green or red number: 0 for an
--         item worn, nil when it cannot be worn now, is not gear, or is
--         lighter armor while its Armor type is Class type; and true while
--         that cannot be told yet (the item, or the worn gear, loading)
-- An item link is passed wherever there is one (an item ID loses a random
-- suffix).
--
--   Gear.FLB.Installed() -> bool: the API is there (whatever the settings say)
--   Gear.FLB.HasGain() -> bool: it has version 2's GetGain
--   Gear.FLB.Version() -> n | nil: its version while Polestar may use it
--   Gear.FLB.BagUpgrade(link) -> bool | nil (nil: no answer, Polestar's own)
--   Gear.FLB.Gain(link) -> points | nil, pending, answered (link: an item
--       link, else an item ID)
--   Gear.FLB.Score(link, offHand) -> score | nil, pending, answered
--   Gear.FLB.Spec(class) -> key, its key, setup, label | nil: key one of
--       Gear.CLASSES[class]'s specs (its Bear is Feral, its melee Survival
--       Survival, each with a label of its own)
--   Gear.FLB.Weights(class, spec, level, setup) -> weights in Polestar's keys,
--       info { source = "flbis", note, profile, from, upTo } | nil
-- Its OnChanged gets one listener per API table, the first time the API is
-- asked while it may be used; the listener redoes gear advice (once a frame
-- however many changes arrive together) while Polestar still uses it, which
-- is also when an answer pending on loading item data is asked again.

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

-- t[name](...) when it is a function, guarded: ok, then its first three answers.
local function ask(name, ...)
	local t = api()
	local f = t and t[name]
	if type(f) ~= "function" then return false end
	local ok, a, b, c = pcall(f, ...)
	if not ok then return false end
	return true, a, b, c
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
	local v = t.version == nil and 1 or num(t.version)
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

-- Its answer: a number; nil, and whether that is pending (its second answer
-- true: the item, or the worn gear, loading); and whether it answered at
-- all (false: no such function, an error, or a value of another kind).
local function answer(ok, v, loading)
	if not ok then return nil, false, false end
	if v == nil then return nil, loading == true, true end
	v = num(v)
	return v, false, v ~= nil
end

-- What to ask it about: an item link as it is (its random suffix counts); an
-- item ID, or a bare "item:<id>", as the ID; other item strings as they are.
local function item(link)
	if type(link) == "number" then return link > 0 and link or nil end
	if type(link) ~= "string" or link == "" then return nil end
	return tonumber(link:match("^item:(%d+)$")) or link
end

function FLB.Gain(link)
	link = item(link)
	if not link or (FLB.Version() or 0) < 2 then return nil, false, false end
	return answer(ask("GetGain", link))
end

function FLB.Score(link, offHand)
	link = item(link)
	if not link or (FLB.Version() or 0) < 2 then return nil, false, false end
	return answer(ask("ScoreItem", link, offHand and true or false))
end

-- Its specs that are not Polestar's: Bear is part of Feral, melee Survival of
-- Survival; each keeps its own label.
local SPEC_OF = { bear = { "feral", "Bear" }, survivalmelee = { "survival", "Survival (melee)" } }
-- Its weapon setups (GetSpec's second answer, GetWeights' fourth argument).
local SETUPS = { twohand = true, dualwield = true, shield = true, held = true, onehand = true }

function FLB.Spec(class)
	if type(class) ~= "string" or (FLB.Version() or 0) < 2 then return nil end
	local ok, spec, setup, classFile = ask("GetSpec")
	if not ok or type(spec) ~= "string" then return nil end
	if classFile ~= nil and classFile ~= class then return nil end -- another class's: no answer
	local own = SPEC_OF[spec]
	local key = own and own[1] or spec
	local meta = Gear.CLASSES and Gear.CLASSES[class]
	for _, s in ipairs(meta and meta.specs or {}) do
		if s.key == key then
			return key, spec, (type(setup) == "string" and SETUPS[setup]) and setup or nil, own and own[2] or nil
		end
	end
	return nil -- a spec Polestar does not know: its own pick
end

-- Its stat names -> Polestar's. Its crit and hit per 1% (critPct, hitPct;
-- Forever pools them) go to spell crit and spell hit for casters and healers,
-- to crit and hit for the rest; spell power splits into damage (sp) and
-- healing (heal); expertise is per point of rating, which Polestar counts per
-- 1% (Gear.RATING_RATE: 10 points, gametables/combatratings.txt). Feral
-- attack power, spell penetration, bonus armor and the weapon speed weights
-- are not read from items by Polestar (it scores weapons by their DPS), and a
-- stat it adds later is not known here: those stay its own.
local NAMES = {
	str = "str", agi = "agi", sta = "sta", int = "int", spi = "spi", armor = "armor",
	atkpwr = "ap", rgdatkpwr = "rap",
	arcsplpwr = "spArcane", firsplpwr = "spFire", frosplpwr = "spFrost", holsplpwr = "spHoly", natsplpwr = "spNature", shasplpwr = "spShadow",
	manargn = "mp5", healthrgn = "hp5", dps = "dps", ohDps = "ohDps", rangedDps = "rdps",
	defrtng = "defense", dodgePct = "dodge", parryPct = "parry", blockPct = "block", block = "blockValue",
}

-- The specs whose crit and hit are spells': casters and healers.
local SPELLS = {
	PALADIN = { holy = true },
	PRIEST = { discipline = true, holy = true, shadow = true },
	SHAMAN = { elemental = true, restoration = true },
	MAGE = { arcane = true, fire = true, frost = true },
	WARLOCK = { affliction = true, demonology = true, destruction = true },
	DRUID = { balance = true, restoration = true },
}

function FLB.Weights(class, spec, level, setup)
	if (FLB.Version() or 0) < 2 then return nil end
	local ok, t, info = ask("GetWeights", class, spec, level, setup)
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
			elseif k == "exprtng" then
				put("expertise", v * (Gear.RATING_RATE and Gear.RATING_RATE.expertise or 10))
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
	if n == 0 then return nil end
	local out = { source = "flbis" }
	if type(info) == "table" then
		out.profile = info.profile == true or nil
		if out.profile and type(info.source) == "string" then out.note = info.source end
		out.from, out.upTo = num(info.fromLevel), num(info.toLevel)
	end
	return w, out
end
