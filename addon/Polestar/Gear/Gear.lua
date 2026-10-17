-- Polestar.Gear: upgrade advice for the character being levelled.
--
--   Gear.ScoreItem(link) -> score | nil
--       Weighted value of an item for this character's spec (Weights.lua).
--       nil: not equippable, not usable by this class, or stats unknown.
--   Gear.CompareToEquipped(link) -> result | nil
--       result = { score, old, new, delta, pct (nil for an empty slot), slot,
--                  usable, reason ("class"|"armor"|"weapon"|"skill"|"dualwield"|nil),
--                  minLevel (level it can be worn), equipped (this very item
--                  is worn), empty (the slot is empty) }
--       Rings and trinkets replace the weaker of the two (a unique item only
--       its own copy); a two-hander is weighed against main hand + off hand;
--       a one-hander or off-hand piece against an equipped two-hander is
--       paired with the best matching piece in the bags; dual wielders also
--       try a one-hander in the off hand. Results are cached per link and
--       must be treated as read-only.
--   Gear.IsUpgrade(link) -> bool, delta, pct
--       Wearable now (level and proficiency) and at least gear.minUpgrade
--       percent better (any gain fills an empty slot).
--   Gear.GetSpec() -> key, label, source ("setting" | "talents" | "default")
--   Gear.GetWeights() -> weights (read-only): the spec's band for this level
--       (Gear.WEIGHT_BANDS, generated SpecData.lua), else the authored table
--   Gear.GetWeightsInfo() -> { source, note, upTo, level } of the weights in use
--   Gear.GetPlayer() -> { class, classID, level, race, raceID, faction } (read-only)
--   Gear.GetRacial() -> the racial gear traits in use (Gear.RACIALS by raceID) | nil
--   Gear.IsEnabled() -> bool
--
-- Item stats: the client's C_Item.GetItemStats (Forever's own numbers,
-- including random "of the Bear" suffixes) when it answers; equip bonuses it
-- does not list and everything for uncached items come from Polestar.ItemDB.
-- Every client call is in Gear.Client so tests can replace it.
--
-- Race and class are independent: Forever's new pairs (Undead Paladin,
-- Dwarf Shaman, Skyborne of every class) score with their class's weights
-- and proficiencies, plus their race's gear traits (weapon crit, stat
-- multipliers) from Gear.RACIALS.

local ADDON, ns = ...

local Gear = ns.Gear or {}
ns.Gear = Gear
local L = ns.L

local type, tonumber, tostring, pairs, pcall, next = type, tonumber, tostring, pairs, pcall, next
local floor = math.floor

local CLASSES, WEIGHTS, PROFICIENCY = Gear.CLASSES, Gear.WEIGHTS, Gear.PROFICIENCY
local BANDS = Gear.WEIGHT_BANDS or {}
local RACIALS = Gear.RACIALS or {}

---------------------------------------------------------------------------
-- Settings
---------------------------------------------------------------------------

do
	local spec = {}
	for class in pairs(CLASSES) do spec[class] = "auto" end
	ns.RegisterDefaults("gear", {
		enabled = true,
		tooltip = true,
		rewards = true,
		pickTooltip = true, -- "Best pick" on quest reward items' tooltips
		useBags = true,
		minUpgrade = 1, -- percent
		spec = spec, -- per class: "auto" or a spec key
	})
end

function Gear.IsEnabled()
	return ns.Get("gear.enabled") and true or false
end

---------------------------------------------------------------------------
-- Client access (Forever 1.60.1 API, checked against
-- Blizzard_APIDocumentationGenerated and FrameXML). Secret values read as nil.
---------------------------------------------------------------------------

local Client = {}
Gear.Client = Client

local readable = ns.Compat.Readable

function Client.PlayerClass()
	if not UnitClass then return nil end
	local _, class, classID = UnitClass("player")
	return readable(class), readable(classID)
end

function Client.PlayerLevel()
	return (UnitLevel and readable(UnitLevel("player"))) or 1
end

-- -> race file ("Scourge"), race ID (ChrRaces), faction ("Alliance" | "Horde" | nil)
function Client.PlayerRace()
	if not UnitRace then return nil end
	local _, race, raceID = UnitRace("player")
	local faction = UnitFactionGroup and readable((UnitFactionGroup("player")))
	if faction ~= "Alliance" and faction ~= "Horde" then faction = nil end
	return readable(race), readable(raceID), faction
end

function Client.InventoryLink(slot)
	return GetInventoryItemLink and readable(GetInventoryItemLink("player", slot)) or nil
end

-- C_Item.GetItemStats(link) -> { ITEM_MOD_STRENGTH_SHORT = 5, ... } | nil
function Client.ItemStats(link)
	local f = C_Item and C_Item.GetItemStats
	if not f then return nil end
	local ok, t = pcall(f, link)
	if ok and type(t) == "table" then return t end
	return nil
end

-- -> equipLoc, classID, subclassID, minLevel, quality (nil when unknown)
function Client.ItemInfo(link)
	if not C_Item then return nil end
	if C_Item.GetItemInfo then
		local ok, name, _, quality, _, minLevel, _, _, _, equipLoc, _, _, classID, subclassID = pcall(C_Item.GetItemInfo, link)
		if ok and name then return equipLoc, classID, subclassID, minLevel, quality end
	end
	if C_Item.GetItemInfoInstant then
		local ok, id, _, _, equipLoc, _, classID, subclassID = pcall(C_Item.GetItemInfoInstant, link)
		if ok and id then return equipLoc, classID, subclassID end
	end
	return nil
end

function Client.BagSlots(bag)
	local f = C_Container and C_Container.GetContainerNumSlots
	return f and f(bag) or 0
end

function Client.BagLink(bag, slot)
	local f = C_Container and C_Container.GetContainerItemLink
	return f and readable(f(bag, slot)) or nil
end

function Client.NumSpecs(classID)
	local S = C_SpecializationInfo
	if classID and S and S.GetNumSpecializationsForClassID then
		local ok, n = pcall(S.GetNumSpecializationsForClassID, classID)
		if ok and type(n) == "number" and n > 0 then return n end
	end
	return nil
end

-- -> tab name, points spent in it
function Client.SpecInfo(index)
	local S = C_SpecializationInfo
	if not (S and S.GetSpecializationInfo) then return nil end
	local ok, _, name, _, _, _, _, points = pcall(S.GetSpecializationInfo, index)
	if not ok then return nil end
	return readable(name), readable(points)
end

function Client.KnowsSpell(spellID)
	local C = ns.Compat
	return C and C.IsSpellKnown and C.IsSpellKnown(spellID) or false
end

-- The chosen primary tree on clients with spec selection (Forever's
-- PaperDollFrame reads it this way); nil otherwise.
function Client.PrimarySpec(classID)
	local S = C_SpecializationInfo
	if not (classID and S and S.IsSpecSelectionEnabled and S.GetSpecialization) then return nil end
	local ok, enabled = pcall(S.IsSpecSelectionEnabled, classID)
	if not (ok and readable(enabled)) then return nil end
	local ok2, index = pcall(S.GetSpecialization)
	index = ok2 and readable(index)
	if type(index) == "number" and index > 0 then return index end
	return nil
end

---------------------------------------------------------------------------
-- Item facts
---------------------------------------------------------------------------

local EQUIP_LOC = {
	INVTYPE_HEAD = 1, INVTYPE_NECK = 2, INVTYPE_SHOULDER = 3, INVTYPE_BODY = 4, INVTYPE_CHEST = 5,
	INVTYPE_WAIST = 6, INVTYPE_LEGS = 7, INVTYPE_FEET = 8, INVTYPE_WRIST = 9, INVTYPE_HAND = 10,
	INVTYPE_FINGER = 11, INVTYPE_TRINKET = 12, INVTYPE_WEAPON = 13, INVTYPE_SHIELD = 14, INVTYPE_RANGED = 15,
	INVTYPE_CLOAK = 16, INVTYPE_2HWEAPON = 17, INVTYPE_BAG = 18, INVTYPE_TABARD = 19, INVTYPE_ROBE = 20,
	INVTYPE_WEAPONMAINHAND = 21, INVTYPE_WEAPONOFFHAND = 22, INVTYPE_HOLDABLE = 23, INVTYPE_AMMO = 24,
	INVTYPE_THROWN = 25, INVTYPE_RANGEDRIGHT = 26, INVTYPE_QUIVER = 27, INVTYPE_RELIC = 28,
}
Gear.EQUIP_LOC = EQUIP_LOC

-- Inventory type -> equipment slot(s). Missing types (shirt, tabard, bag,
-- ammo, quiver) are not scored.
local SLOTS_OF = {
	[1] = { 1 }, [2] = { 2 }, [3] = { 3 }, [5] = { 5 }, [20] = { 5 }, [6] = { 6 }, [7] = { 7 }, [8] = { 8 },
	[9] = { 9 }, [10] = { 10 }, [11] = { 11, 12 }, [12] = { 13, 14 }, [16] = { 15 },
	[13] = { 16, 17 }, [21] = { 16 }, [17] = { 16 }, [22] = { 17 }, [14] = { 17 }, [23] = { 17 },
	[15] = { 18 }, [25] = { 18 }, [26] = { 18 }, [28] = { 18 },
}
Gear.SLOTS_OF = SLOTS_OF

local EQUIPPED_SLOTS = { 1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18 }
local MAIN, OFF = 16, 17

local RANGED_INV = { [15] = true, [25] = true, [26] = true }
local MELEE_INV = { [13] = true, [17] = true, [21] = true, [22] = true }
local OFFHAND_INV = { [14] = true, [22] = true, [23] = true }
-- Armor-class items every class wears whatever their subclass says.
local ANY_ARMOR_INV = { [2] = true, [11] = true, [12] = true, [16] = true, [23] = true }
local OFFHAND_DPS = 0.5 -- off-hand weapons hit for half damage
local DUAL_WIELD_SPELL = 674

-- C_Item.GetItemStats keys -> canonical stat keys. Unknown keys are ignored.
local CLIENT_STATS = {
	ITEM_MOD_STRENGTH_SHORT = "str", ITEM_MOD_AGILITY_SHORT = "agi", ITEM_MOD_STAMINA_SHORT = "sta",
	ITEM_MOD_INTELLECT_SHORT = "int", ITEM_MOD_SPIRIT_SHORT = "spi", RESISTANCE0_NAME = "armor",
	ITEM_MOD_HEALTH_SHORT = "health", ITEM_MOD_MANA_SHORT = "mana",
	ITEM_MOD_DAMAGE_PER_SECOND_SHORT = "dps",
	ITEM_MOD_ATTACK_POWER_SHORT = "ap", ITEM_MOD_RANGED_ATTACK_POWER_SHORT = "rap",
	ITEM_MOD_SPELL_DAMAGE_DONE_SHORT = "sp", ITEM_MOD_SPELL_POWER_SHORT = "sp",
	ITEM_MOD_SPELL_HEALING_DONE_SHORT = "heal",
	ITEM_MOD_MANA_REGENERATION_SHORT = "mp5", ITEM_MOD_POWER_REGEN0_SHORT = "mp5",
	ITEM_MOD_HEALTH_REGEN_SHORT = "hp5", ITEM_MOD_HEALTH_REGENERATION_SHORT = "hp5",
	ITEM_MOD_CRIT_RATING_SHORT = "crit", ITEM_MOD_CRIT_MELEE_RATING_SHORT = "crit",
	ITEM_MOD_HIT_RATING_SHORT = "hit", ITEM_MOD_HIT_MELEE_RATING_SHORT = "hit",
	ITEM_MOD_CRIT_SPELL_RATING_SHORT = "spellCrit", ITEM_MOD_HIT_SPELL_RATING_SHORT = "spellHit",
	ITEM_MOD_DEFENSE_SKILL_RATING_SHORT = "defense", ITEM_MOD_DODGE_RATING_SHORT = "dodge",
	ITEM_MOD_PARRY_RATING_SHORT = "parry", ITEM_MOD_BLOCK_RATING_SHORT = "block",
	ITEM_MOD_BLOCK_VALUE_SHORT = "blockValue",
}
Gear.CLIENT_STATS = CLIENT_STATS

-- Stats the client always reports when it reports an item at all; for the
-- rest (equip bonuses) ItemDB fills what the client left out.
local BASE_STATS = { str = true, agi = true, sta = true, int = true, spi = true, armor = true, dps = true, health = true, mana = true }

local function itemID(link)
	if type(link) == "number" then return link end
	if type(link) ~= "string" then return nil end
	return tonumber(link:match("item:(%d+)")) or tonumber(link)
end
Gear.ItemID = itemID

-- Caches, keyed by link (or item ID). Wiped whenever the answer can change;
-- capped so browsing an auction house cannot grow them without bound.
local CACHE_CAP = 400
local infoCache, infoCount = {}, 0
local resultCache, resultCount = {}, 0

local function clientStats(link)
	if type(link) ~= "string" then return nil end
	local t = Client.ItemStats(link)
	if not t or next(t) == nil then return nil end
	local out
	for k, v in pairs(t) do
		local key = CLIENT_STATS[k]
		if key and type(v) == "number" and readable(v) then
			out = out or {}
			out[key] = (out[key] or 0) + v
		end
	end
	return out
end

-- -> info = { id, link, inv, req, quality, class, subclass, allow, unique, stats } | nil
local function buildInfo(link)
	local id = itemID(link)
	if not id then return nil end
	local rec = ns.ItemDB and ns.ItemDB.Get(id)
	local cstats = clientStats(link)
	local inv, class, subclass, req, quality
	if rec then
		inv, class, subclass, req, quality = rec.inv, rec.class, rec.subclass, rec.req, rec.quality
	end
	if not inv or (cstats and not req) then
		local equipLoc, cls, sub, minLevel, q = Client.ItemInfo(type(link) == "number" and ("item:" .. link) or link)
		inv = inv or EQUIP_LOC[equipLoc or ""]
		class, subclass = class or cls, subclass or sub
		req, quality = req or minLevel, quality or q
	end
	if not (inv and SLOTS_OF[inv]) then return nil end
	if not (cstats or rec) then return nil end
	local stats = {}
	if cstats then
		for k, v in pairs(cstats) do stats[k] = v end
		if rec then
			for k, v in pairs(rec.stats) do
				if not BASE_STATS[k] and stats[k] == nil then stats[k] = v end
			end
		end
	else
		for k, v in pairs(rec.stats) do stats[k] = v end
	end
	return {
		id = id, link = link, inv = inv, req = req or 0, quality = quality,
		class = class, subclass = subclass,
		allow = rec and rec.allow or 0, unique = rec and rec.unique or false,
		stats = stats,
	}
end

local function itemInfo(link)
	local hit = infoCache[link]
	if hit ~= nil then return hit or nil end
	if infoCount >= CACHE_CAP then
		for k in pairs(infoCache) do infoCache[k] = nil end
		infoCount = 0
	end
	local info = buildInfo(link)
	infoCache[link] = info or false
	infoCount = infoCount + 1
	return info
end
Gear.GetItemInfo = itemInfo

---------------------------------------------------------------------------
-- The character: class, level, spec, weights
---------------------------------------------------------------------------

local player = { class = nil, classID = nil, level = 1, race = nil, raceID = nil, faction = nil }
local specKey, specSource, weights, weightsInfo
local racial

local function refreshPlayer()
	local class, classID = Client.PlayerClass()
	player.class, player.classID = class, classID
	player.level = Client.PlayerLevel()
	player.race, player.raceID, player.faction = Client.PlayerRace()
	racial = player.raceID and RACIALS[player.raceID] or nil
end

function Gear.GetPlayer()
	if not player.class then refreshPlayer() end
	return player
end

function Gear.GetRacial()
	if not player.class then refreshPlayer() end
	return racial
end

-- Re-read class, level, race and faction (login, and tests).
function Gear.RefreshPlayer()
	refreshPlayer()
	Gear.Invalidate("spec")
end

local function normalized(name)
	if type(name) ~= "string" then return nil end
	return (name:lower():gsub("[^%a]", ""))
end

local function specByKey(class, key)
	local meta = CLASSES[class]
	if not meta then return nil end
	for i = 1, #meta.specs do
		if meta.specs[i].key == key then return meta.specs[i] end
	end
	return nil
end

local function specKeyOf(meta, name, index)
	local n = normalized(name)
	if n then
		for _, spec in ipairs(meta.specs) do
			for _, alias in ipairs(spec.names) do
				if n == alias then return spec.key end
			end
		end
	end
	return meta.specs[index] and meta.specs[index].key
end

-- The talent tree with the most points, else the primary tree chosen on
-- clients with spec selection, else the class's levelling default (before
-- the first point, or when the client cannot tell).
function Gear.DetectSpec(class, classID)
	local meta = CLASSES[class]
	if not meta then return nil, "default" end
	local count = Client.NumSpecs(classID) or #meta.specs
	local best, bestPoints = nil, 0
	for i = 1, count do
		local name, points = Client.SpecInfo(i)
		if type(points) == "number" and points > bestPoints then
			local key = specKeyOf(meta, name, i)
			if key then best, bestPoints = key, points end
		end
	end
	if best then return best, "talents" end
	local primary = Client.PrimarySpec(classID)
	if primary then
		local key = specKeyOf(meta, (Client.SpecInfo(primary)), primary)
		if key then return key, "talents" end
	end
	return meta.default, "default"
end

-- The spec's weights at a level: the first band whose upTo covers it (the
-- last band past the end), else the authored table.
-- -> weights, info { source, note, upTo }
function Gear.WeightsFor(class, key, level)
	local bands = BANDS[class] and BANDS[class][key]
	if bands and #bands > 0 then
		local pick = bands[#bands]
		for i = 1, #bands do
			if level <= bands[i].upTo then
				pick = bands[i]
				break
			end
		end
		return pick.weights, pick
	end
	local w = WEIGHTS[class] and WEIGHTS[class][key]
	return w, w and { source = "polestar", upTo = 60 } or nil
end

local function resolveSpec()
	if not player.class then refreshPlayer() end
	local class = player.class
	if not (class and WEIGHTS[class]) then
		specKey, specSource, weights, weightsInfo = nil, "default", nil, nil
		return
	end
	local chosen = ns.Get("gear.spec." .. class)
	if chosen and chosen ~= "auto" and WEIGHTS[class][chosen] then
		specKey, specSource = chosen, "setting"
	else
		specKey, specSource = Gear.DetectSpec(class, player.classID)
	end
	weights, weightsInfo = Gear.WeightsFor(class, specKey, player.level)
end

function Gear.GetSpec()
	if not specSource then resolveSpec() end
	local spec = specKey and specByKey(player.class, specKey)
	return specKey, spec and spec.label or nil, specSource
end

function Gear.GetWeights()
	if not specSource then resolveSpec() end
	return weights
end

function Gear.GetWeightsInfo()
	if not specSource then resolveSpec() end
	return weightsInfo
end

function Gear.PlayerLevel()
	return player.level
end

---------------------------------------------------------------------------
-- Scoring
---------------------------------------------------------------------------

-- Racial gear traits: `weaponCrit` adds its percent of crit (and spell
-- crit) to a weapon of a listed subclass; `statMult` scales a stat.
local function racialBonus(info, w, asOffhand)
	local r = racial
	if not r then return 0 end
	local s = 0
	local wc = r.weaponCrit
	if wc and info.class == 2 and not asOffhand and wc.subclasses[info.subclass] then
		s = s + ((w.crit or 0) + (w.spellCrit or 0)) * wc.pct
	end
	local m = r.statMult
	if m then
		for k, mult in pairs(m) do
			local v = info.stats[k]
			if v then s = s + (w[k] or 0) * v * (mult - 1) end
		end
	end
	return s
end

local function scoreWith(info, w, asOffhand)
	local s = 0
	for k, v in pairs(info.stats) do
		if k == "dps" then
			if RANGED_INV[info.inv] then
				s = s + (w.rdps or 0) * v
			elseif MELEE_INV[info.inv] then
				s = s + (w.dps or 0) * v * (asOffhand and OFFHAND_DPS or 1)
			end
		else
			s = s + (w[k] or 0) * v
		end
	end
	return s + racialBonus(info, w, asOffhand)
end
Gear.ScoreWith = scoreWith

local function hasBit(mask, b)
	return floor(mask / b) % 2 == 1
end

local function canDualWield()
	local prof = PROFICIENCY[player.class]
	if prof and prof.dualWield and player.level >= prof.dualWield then return true end
	return Client.KnowsSpell(DUAL_WIELD_SPELL) and true or false
end

-- Weapon subclass -> weapon skill line (SkillLine.db2). The class may be able
-- to train a weapon the character has not learned yet (weapon masters).
local WEAPON_SKILL = {
	[0] = 44, [1] = 172, [2] = 45, [3] = 46, [4] = 54, [5] = 160, [6] = 229, [7] = 43,
	[8] = 55, [10] = 136, [13] = 473, [15] = 173, [16] = 176, [18] = 226, [19] = 228,
}
-- line -> known; false when the client can't list weapon skills (then every
-- weapon the class can train counts, as before). Reset by invalidate().
local weaponSkills

local function knowsWeaponSkill(line)
	if weaponSkills == nil then
		weaponSkills = false
		local known, any = {}, false
		for _, id in pairs(WEAPON_SKILL) do
			if ns.Compat.GetSkillRank(id) then known[id], any = true, true end
		end
		-- Every character knows some weapon skill; none means no usable API.
		if any then weaponSkills = known end
	end
	return not weaponSkills or weaponSkills[line] == true
end

-- -> usable, reason, minLevel (the level it can first be worn)
local function usability(info)
	local class = player.class
	local prof, meta = PROFICIENCY[class], CLASSES[class]
	local minLevel = info.req or 0
	if not (prof and meta) then return true, nil, minLevel end
	if info.allow and info.allow > 0 and not hasBit(info.allow, meta.bit) then return false, "class", minLevel end
	local sub = info.subclass
	if info.class == 4 and sub and not ANY_ARMOR_INV[info.inv] then
		if sub >= 1 and sub <= 4 then
			if sub > prof.armor then
				if not (prof.armorAt40 and sub <= prof.armorAt40) then return false, "armor", minLevel end
				if minLevel < 40 then minLevel = 40 end
			end
		elseif sub == 6 then
			if not prof.shield then return false, "armor", minLevel end
		elseif sub == 7 or sub == 8 or sub == 9 then
			if prof.relic ~= sub then return false, "armor", minLevel end
		end
	elseif info.class == 2 and sub then
		if sub == 20 then return false, "weapon", minLevel end -- fishing poles
		if sub ~= 14 and not prof.weapons[sub] then return false, "weapon", minLevel end
		if WEAPON_SKILL[sub] and not knowsWeaponSkill(WEAPON_SKILL[sub]) then return false, "skill", minLevel end
		if info.inv == 22 and not canDualWield() then return false, "dualwield", minLevel end
	end
	return true, nil, minLevel
end
Gear.Usability = usability

function Gear.ScoreItem(link)
	local info = itemInfo(link)
	if not info then return nil end
	local w = Gear.GetWeights()
	if not w then return nil end
	if not usability(info) then return nil end
	return scoreWith(info, w, info.inv == 22 or info.inv == 14 or info.inv == 23)
end

---------------------------------------------------------------------------
-- What is worn, and what waits in the bags
---------------------------------------------------------------------------

local eqLink, eqInfo, eqScore = {}, {}, {}
local eqDirty = true
-- Per kind: best and second-best score and link ({ s1, l1, s2, l2 }).
local bagMain, bagOff = {}, {}
local bagDirty = true

local function refreshEquipped(w)
	if not eqDirty then return end
	for i = 1, #EQUIPPED_SLOTS do
		local slot = EQUIPPED_SLOTS[i]
		local link = Client.InventoryLink(slot)
		local info = link and itemInfo(link)
		eqLink[slot] = link or false
		eqInfo[slot] = info or false
		eqScore[slot] = info and scoreWith(info, w, slot == OFF) or 0
	end
	eqDirty = false
end

local function keepBest(t, link, s)
	if t[1] == nil or s > t[1] then
		t[3], t[4] = t[1], t[2]
		t[1], t[2] = s, link
	elseif t[3] == nil or s > t[3] then
		t[3], t[4] = s, link
	end
end

-- Best one-handed main hand and best off-hand piece in the bags (wearable
-- now), to pair with a one-hand candidate when a two-hander is worn.
local function refreshBags(w)
	if not bagDirty then return end
	bagDirty = false
	for i = 1, 4 do bagMain[i], bagOff[i] = nil, nil end
	if not ns.Get("gear.useBags") then return end
	local dw = canDualWield()
	for b = 0, 4 do
		for s = 1, Client.BagSlots(b) do
			local link = Client.BagLink(b, s)
			local info = link and itemInfo(link)
			if info then
				local ok, _, minLevel = usability(info)
				local inv = info.inv
				if ok and minLevel <= player.level then
					if inv == 13 or inv == 21 then keepBest(bagMain, link, scoreWith(info, w, false)) end
					if (OFFHAND_INV[inv] and (inv ~= 22 or dw)) or (inv == 13 and dw) then
						keepBest(bagOff, link, scoreWith(info, w, true))
					end
				end
			end
		end
	end
end

-- Best bag piece of a kind that is not the candidate itself.
local function bagBest(t, exceptLink)
	if t[1] and t[2] ~= exceptLink then return t[1] end
	return t[3] or 0
end

---------------------------------------------------------------------------
-- Comparison
---------------------------------------------------------------------------

local function option(r, slot, old, new, empty)
	local delta = new - old
	if r.delta == nil or delta > r.delta then
		r.slot, r.old, r.new, r.delta, r.empty = slot, old, new, delta, empty and true or false
	end
end

local function compare(link)
	local info = itemInfo(link)
	if not info then return nil end
	local w = Gear.GetWeights()
	if not w then return nil end
	local usable, reason, minLevel = usability(info)
	local r = { usable = usable, reason = reason, minLevel = minLevel, equipped = false }
	if not usable then return r end
	refreshEquipped(w)
	local inv = info.inv
	local slots = SLOTS_OF[inv]
	for i = 1, #slots do
		if eqLink[slots[i]] == link then
			r.equipped, r.slot = true, slots[i]
		end
	end
	local asOff = OFFHAND_INV[inv] or false
	r.score = scoreWith(info, w, asOff)
	if r.equipped then
		r.old, r.new, r.delta = eqScore[r.slot], eqScore[r.slot], 0
	elseif inv == 11 or inv == 12 then
		local a, b = slots[1], slots[2]
		local ia, ib = eqInfo[a], eqInfo[b]
		if info.unique and ia and ia.id == info.id then
			option(r, a, eqScore[a], r.score, false)
		elseif info.unique and ib and ib.id == info.id then
			option(r, b, eqScore[b], r.score, false)
		else
			-- the weaker ring/trinket goes; an empty slot is the weakest
			local slot = (not eqLink[a] and a) or (not eqLink[b] and b) or (eqScore[b] < eqScore[a] and b or a)
			option(r, slot, eqScore[slot], r.score, not eqLink[slot])
		end
	elseif inv == 17 then
		option(r, MAIN, eqScore[MAIN] + eqScore[OFF], r.score, not eqLink[MAIN] and not eqLink[OFF])
	elseif inv == 13 or inv == 21 or OFFHAND_INV[inv] then
		local main = eqInfo[MAIN]
		local twoHander = main and main.inv == 17
		if twoHander then refreshBags(w) end
		if inv == 13 or inv == 21 then
			if twoHander then
				option(r, MAIN, eqScore[MAIN], r.score + bagBest(bagOff, link), false)
			else
				option(r, MAIN, eqScore[MAIN], r.score, not eqLink[MAIN])
			end
		end
		if OFFHAND_INV[inv] or (inv == 13 and canDualWield()) then
			local asOffScore = OFFHAND_INV[inv] and r.score or scoreWith(info, w, true)
			if twoHander then
				option(r, OFF, eqScore[MAIN], asOffScore + bagBest(bagMain, link), false)
			else
				option(r, OFF, eqScore[OFF], asOffScore, not eqLink[OFF])
			end
		end
	else
		local slot = slots[1]
		option(r, slot, eqScore[slot], r.score, not eqLink[slot])
	end
	if r.old and r.old > 0 and not r.empty then r.pct = r.delta / r.old * 100 end
	return r
end

function Gear.CompareToEquipped(link)
	if link == nil then return nil end
	local hit = resultCache[link]
	if hit ~= nil then return hit or nil end
	if resultCount >= CACHE_CAP then
		for k in pairs(resultCache) do resultCache[k] = nil end
		resultCount = 0
	end
	local r = compare(link)
	resultCache[link] = r or false
	resultCount = resultCount + 1
	return r
end

function Gear.IsUpgrade(link)
	local r = Gear.CompareToEquipped(link)
	if not (r and r.usable and r.delta) then return false, nil end
	if r.equipped then return false, 0, 0 end
	local up = r.delta > 0 and (r.minLevel or 0) <= player.level
	if up and r.pct then up = r.pct >= (tonumber(ns.Get("gear.minUpgrade")) or 0) end
	return up and true or false, r.delta, r.pct
end

---------------------------------------------------------------------------
-- Keeping answers fresh
---------------------------------------------------------------------------

local function invalidate(what)
	if what == "spec" or what == "level" then specSource = nil end
	if what == "items" then
		for k in pairs(infoCache) do infoCache[k] = nil end
		infoCount = 0
	end
	weaponSkills = nil
	if what ~= "bags" then eqDirty = true end
	bagDirty = true
	for k in pairs(resultCache) do resultCache[k] = nil end
	resultCount = 0
	ns.Fire("GEAR_UPDATED", what)
end
Gear.Invalidate = invalidate

local function onLevel(_, level)
	player.level = tonumber(readable(level)) or Client.PlayerLevel()
	invalidate("level")
end

ns.RegisterEvent("PLAYER_EQUIPMENT_CHANGED", function() invalidate("equipment") end)
ns.RegisterEvent("BAG_UPDATE_DELAYED", function() invalidate("bags") end)
ns.RegisterEvent("PLAYER_LEVEL_UP", onLevel)
ns.RegisterEvent("SKILL_LINES_CHANGED", function() invalidate("skills") end)
ns.RegisterEvent("GET_ITEM_INFO_RECEIVED", function() invalidate("items") end)
for _, ev in ipairs({ "PLAYER_TALENT_UPDATE", "ACTIVE_TALENT_GROUP_CHANGED", "CHARACTER_POINTS_CHANGED", "TRAIT_CONFIG_UPDATED" }) do
	ns.RegisterEvent(ev, function() invalidate("spec") end)
end

ns.On("SETTING_CHANGED", function(path)
	if path == "" or (type(path) == "string" and path:sub(1, 5) == "gear.") then invalidate("spec") end
end)
ns.On("ITEMDB_LOADED", function() invalidate("items") end)

-- Login only reads class, level and race: no bag or ItemDB work. The item
-- data loads on the first comparison that needs it (ItemDB.Get).
ns.OnLogin(function()
	refreshPlayer()
	invalidate("spec")
end)

---------------------------------------------------------------------------
-- /polestar gear [item link]
---------------------------------------------------------------------------

-- A gain in a few characters: whole percents ("+12%", "-8%", "+<1%"), and
-- words past doubling, where a percent stops meaning much ("big upgrade").
-- -> text, outsized
local BIG = 100
function Gear.GainText(pct)
	if pct >= BIG then return L["big upgrade"], true end
	local n = floor(math.abs(pct) + 0.5)
	if n == 0 then return pct >= 0 and "+<1%" or "-<1%", false end
	return (pct >= 0 and "+" or "-") .. n .. "%", false
end

-- Where the spec in use came from (Gear.GetSpec's source).
local SPEC_SOURCE = { setting = L["setting"], talents = L["talents"], default = L["default"] }

ns.RegisterCommand("gear", function(rest)
	local key, label, source = Gear.GetSpec()
	if not key then
		ns.Print(L["Gear advice: no weights for this class"])
		return
	end
	if label then label = L[label] end
	if rest == nil or rest == "" then
		ns.Print(L["Gear weights"] .. ": " .. tostring(label) .. " (" .. (SPEC_SOURCE[source] or tostring(source)) .. ")")
		return
	end
	local r = Gear.CompareToEquipped(rest)
	if not r then
		ns.Print(L["Not equippable gear, or its stats are not known yet"])
	elseif not r.usable then
		ns.Print(L["Not usable by your class"])
	elseif r.equipped then
		ns.Print(L["Equipped"])
	else
		ns.Print(("%s: %.1f -> %.1f (%s)"):format(tostring(label), r.old or 0, r.new or 0, r.pct and (Gear.GainText(r.pct)) or L["empty slot"]))
	end
end, L["Gear advice: weights in use, or compare an item link"])
