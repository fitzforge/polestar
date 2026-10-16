-- Polestar.Lookup.Sources: where an item, mount or pet comes from (and where
-- an NPC, quest, dungeon or treasure is), ranked for this character.
-- Contract: docs/ARCHITECTURE.md, "Lookup".
--
--   Lookup.Sources(kind, id) -> list, entity
--     kind: "item" | "mount" | "pet" | "recipe" | "tabard" (item IDs), "npc" | "rare",
--           "quest", "instance" (key), "object" | "treasure", "zone" (no rows)
--     list[i] = { type, src, label, detail, zone, map, x, y, f, travel, effort, cost,
--                 available, why, whyText, chance, price, standing, guideable }
--
-- Ranking: available rows first (faction, race, class, level, professions,
-- reputation), then cost = travel + effort in seconds. Travel is
-- ns.TravelCost from the player (Nav's planner when present) to the nearest
-- spawn of the source's NPC, object or quest giver, or the dungeon entrance.
-- Effort is a rough estimate of the time the source itself takes:
--   vendor   ~0 (a limited supply waits for the restock); an item the vendor
--            sells only at a standing (item.repFaction/repStanding) or skill
--            rank (item.reqSkill/reqSkillRank) adds that grind and is
--            unavailable ("reputation" / "profession") until it is reached
--   drop     expected kills (100 / chance) x seconds per kill (mob level vs
--            player, as the Engine's farm spots), elites x3; a rare waits for
--            its respawn; an instance boss costs one run per kill
--   object   expected loots x the time to find the next spawn
--   quest    a fixed amount + its objectives + unfinished prerequisites
--   craft    reagents, plus learning the recipe, the missing skill points
--            and the profession itself when needed
--   rep/pvp  large: hours of reputation or honour
-- A missing profession only blocks a craft when both primary professions
-- are taken by others (or it is not a profession the client knows).

local ADDON, ns = ...

local Lookup = ns.Lookup or {}
ns.Lookup = Lookup

local L = ns.L
local type, pairs, ipairs, tostring, tonumber = type, pairs, ipairs, tostring, tonumber
local floor = math.floor

local ITEM_KINDS = { item = true, mount = true, pet = true, recipe = true, tabard = true }
Lookup.ITEM_KINDS = ITEM_KINDS

local SEP = " \194\183 " -- " · "

-- Effort constants, in seconds.
local DEFAULT_DROP_CHANCE = 10 -- percent, when the source gives none
local DEFAULT_OBJECT_CHANCE = 50
local RARE_RESPAWN = 1800
local DUNGEON_RUN, RAID_RUN = 2400, 7200
local OBJECT_SEARCH = 120
local LIMITED_RESTOCK = 600
local QUEST_BASE, QUEST_PRE = 300, 600
local QUEST_ITEM, QUEST_OBJECT, QUEST_EVENT = 60, 30, 120
local CRAFT_BASE, CRAFT_LEARN, SKILL_POINT, PROFESSION_LEARN = 300, 120, 45, 600
local REP_STANDING = 14400
local PVP_EFFORT = 72000
local CONTAINER_EFFORT = 1800
local WORLD_DROP_EFFORT = 36000
local MOB_LEVEL_GAP = 5 -- mobs more than this many levels above are out of reach
local CACHE_SECONDS = 5

-- Profession skill lines (SkillLine.db2; same IDs as Compat.SKILL_LINES).
local PROFESSIONS = {
	[171] = "Alchemy", [164] = "Blacksmithing", [333] = "Enchanting", [202] = "Engineering",
	[182] = "Herbalism", [165] = "Leatherworking", [186] = "Mining", [393] = "Skinning",
	[197] = "Tailoring", [185] = "Cooking", [356] = "Fishing", [129] = "First Aid",
}
local SECONDARY = { [185] = true, [356] = true, [129] = true }
Lookup.PROFESSIONS = PROFESSIONS

-- A skill line's profession name: Classic's own, else the Codex's skill table.
function Lookup.ProfessionName(line)
	if not line then return nil end
	if PROFESSIONS[line] then return PROFESSIONS[line] end
	local C = ns.Codex
	return C and C.IsLoaded() and C.Name("skill", line) or nil
end

-- Era quest masks (ChrRaces / ChrClasses bits). A race or class missing
-- here (a race Forever adds) is never excluded by a mask.
local RACE_BIT = { Human = 1, Orc = 2, Dwarf = 4, NightElf = 8, Scourge = 16, Undead = 16, Tauren = 32, Gnome = 64, Troll = 128 }
local CLASS_BIT = {
	WARRIOR = 1, PALADIN = 2, HUNTER = 4, ROGUE = 8, PRIEST = 16,
	SHAMAN = 64, MAGE = 128, WARLOCK = 256, DRUID = 1024,
}

local function hasBit(mask, b)
	return floor(mask / b) % 2 == 1
end

local function Codex() return ns.Codex end

---------------------------------------------------------------------------
-- The character
---------------------------------------------------------------------------

-- Compat.GetPlayerInfo() plus `code` ("A" | "H" | nil) for faction codes.
local function playerInfo()
	local p = ns.Compat.GetPlayerInfo()
	p.code = p.faction == "Alliance" and "A" or p.faction == "Horde" and "H" or nil
	p.level = p.level or 1
	return p
end
Lookup.PlayerInfo = playerInfo

local function sideOK(code, p)
	if not code or code == "AH" or not p.code then return true end
	return code:find(p.code, 1, true) ~= nil
end

local function sideText(code)
	if code == "A" then return L["Alliance only"] end
	if code == "H" then return L["Horde only"] end
	return nil
end

-- Era masks; nil/0 = anyone.
local function maskBlocks(mask, bits, key)
	if type(mask) ~= "number" or mask <= 0 or not key then return false end
	local b = bits[key]
	if not b then return false end
	return not hasBit(mask, b)
end

---------------------------------------------------------------------------
-- Places
---------------------------------------------------------------------------

local zoneName = ns.Compat.MapName

-- Travel seconds between two points, nil when either cannot be placed (or
-- the core's travel estimate is absent).
local function travel(from, to)
	if not (from and to and ns.TravelCost) then return nil end
	return ns.TravelCost(from, to)
end
Lookup.Travel = travel

-- The spawn the player reaches soonest -> spawn, travel | nil. Without a
-- player position (instances, loading) the first spawn, travel nil.
local function nearest(spawns, from)
	if type(spawns) ~= "table" or #spawns == 0 then return nil end
	if not from then return spawns[1], nil end
	local best, bestT
	for i = 1, #spawns do
		local s = spawns[i]
		if s.map and s.x and s.y then
			local t = travel(from, s)
			if t and (not bestT or t < bestT) then best, bestT = s, t end
		end
	end
	if best then return best, bestT end
	return spawns[1], nil
end
Lookup.Nearest = nearest

local function npcSpawn(npcId, from)
	local C = Codex()
	local npc = npcId and C.Npc(npcId)
	if not npc then return nil end
	local s, t = nearest(npc.spawns, from)
	return npc, s, t
end

local function objectSpawn(objectId, from)
	local C = Codex()
	local obj = objectId and C.Object(objectId)
	if not obj then return nil end
	local s, t = nearest(obj.spawns, from)
	return obj, s, t
end

-- The quest giver (or turn-in) nearest to the player, of the character's side
-- (an NPC of the other faction only when no other is known, then marked
-- `hostile` with its `faction`: Tabetha's Task is given by the mage trainers
-- of both sides): -> { npc|object, name, spawn, travel, hostile, faction }
-- | nil. p: Lookup.PlayerInfo() (default: read now).
local function closer(best, c)
	if not best or (c.travel and (not best.travel or c.travel < best.travel)) then return c end
	return best
end

local function questEnd(ends, from, p)
	if type(ends) ~= "table" then return nil end
	p = p or playerInfo()
	local best, other
	for _, id in ipairs(ends.npc or {}) do
		local npc, s, t = npcSpawn(id, from)
		if npc and s then
			local c = { npc = npc.id, name = npc.name, spawn = s, travel = t }
			if sideOK(npc.faction, p) then best = closer(best, c) else c.faction = npc.faction; other = closer(other, c) end
		end
	end
	for _, id in ipairs(ends.object or {}) do
		local obj, s, t = objectSpawn(id, from)
		if obj and s then best = closer(best, { object = obj.id, name = obj.name, spawn = s, travel = t }) end
	end
	if best then return best end
	if other then other.hostile = true end
	return other
end
Lookup.QuestEnd = questEnd
Lookup.SideOK = sideOK

---------------------------------------------------------------------------
-- Effort
---------------------------------------------------------------------------

-- Seconds per kill from the mob's level against the player's, as the
-- Engine's farm spots count kills per minute.
local function killSeconds(npcLevel, level, elite)
	local kpm
	local diff = (npcLevel or level) - level
	if diff >= 1 then kpm = 1.0
	elseif diff >= -4 then kpm = 1.5
	elseif diff >= -9 then kpm = 2.0
	else kpm = 2.5 end
	local s = 60 / kpm
	if elite then s = s * 3 end
	return s
end
Lookup.KillSeconds = killSeconds

---------------------------------------------------------------------------
-- Rows
---------------------------------------------------------------------------

local function newRow(src, kind)
	return { type = kind, src = src, available = true, guideable = false, effort = 0 }
end

local function place(r, spawn, travel)
	if not spawn then return end
	r.map, r.x, r.y, r.f = spawn.map, spawn.x, spawn.y, spawn.f
	r.zone = zoneName(spawn.map)
	r.travel = travel
end

local function block(r, why, text)
	if not r.available then return end
	r.available, r.why, r.whyText = false, why, text
end

local function located(r)
	return r.map ~= nil and r.x ~= nil and r.y ~= nil
end

local function detail(kindLabel, where)
	if where then return kindLabel .. SEP .. where end
	return kindLabel
end

local function levelText(n) return L["Requires level"] .. " " .. n end

-- A standing the row needs (a vendor's or a quest's): unmet, the row is
-- unavailable and costs the grind.
local function repGate(r, faction, need)
	local have = tonumber((ns.Compat.GetFactionStanding(faction))) or 4
	if have >= need then return end
	local f = Codex().Faction(faction)
	local name = f and f.name or (L["Faction"] .. " " .. faction)
	r.effort = (r.effort or 0) + (need - have) * REP_STANDING
	block(r, "reputation", L["Requires"] .. " " .. (ns.StandingName(need) or "") .. " (" .. name .. ")")
end

-- Quest availability for this character: why, text | nil
local function questBlock(q, p)
	if q.faction and not sideOK(q.faction, p) then return "faction", sideText(q.faction) end
	if maskBlocks(q.races, RACE_BIT, p.race) then return "race", L["Not for your race"] end
	if maskBlocks(q.classes, CLASS_BIT, p.class) then return "class", L["Not for your class"] end
	if q.minLevel and q.minLevel > p.level then return "level", levelText(q.minLevel) end
	if ns.Compat.IsQuestCompleted(q.id) then return "done", L["Already done"] end
	return nil
end
Lookup.QuestBlock = questBlock

-- Unfinished prerequisites: all of `pre` plus one of `preAny` unless one is done.
local function openPrereqs(q)
	local C = Codex()
	local n = 0
	for _, id in ipairs(q.pre or {}) do
		if not ns.Compat.IsQuestCompleted(id) and C.Quest(id) then n = n + 1 end
	end
	local any = q.preAny or {}
	if #any > 0 then
		local done = false
		for _, id in ipairs(any) do
			if ns.Compat.IsQuestCompleted(id) then done = true; break end
		end
		if not done then n = n + 1 end
	end
	return n
end

local function questEffort(q, p)
	local C = Codex()
	local e = QUEST_BASE + openPrereqs(q) * QUEST_PRE
	for _, o in ipairs(q.objectives or {}) do
		local count = o.count or 1
		if o.type == "kill" then
			local npc = o.id and C.Npc(o.id)
			e = e + count * killSeconds(npc and npc.level, p.level, npc and npc.elite)
		elseif o.type == "item" then
			e = e + count * QUEST_ITEM
		elseif o.type == "object" then
			e = e + count * QUEST_OBJECT
		else
			e = e + QUEST_EVENT
		end
	end
	return e
end

local builders = {}

builders.vendor = function(src, p, from)
	local r = newRow(src, "vendor")
	local npc, s, t = npcSpawn(src.npc, from)
	r.label = npc and npc.name or L["Vendor"]
	place(r, s, t)
	r.detail = detail(L["Vendor"], r.zone)
	r.price = src.cost
	if src.limited then r.effort = LIMITED_RESTOCK end
	if npc and not sideOK(npc.faction, p) then block(r, "faction", sideText(npc.faction)) end
	r.guideable = npc ~= nil and located(r)
	return r
end

-- An NPC hands it out (casts the spell that creates it: Duke Hydraxis's Aqual Quintessence).
builders.gift = function(src, p, from)
	local r = newRow(src, "gift")
	local npc, s, t = npcSpawn(src.npc, from)
	r.label = npc and npc.name or L["Given by an NPC"]
	place(r, s, t)
	r.detail = detail(L["Given by an NPC"], r.zone)
	if npc and not sideOK(npc.faction, p) then block(r, "faction", sideText(npc.faction)) end
	r.guideable = npc ~= nil and located(r)
	return r
end

builders.drop = function(src, p, from)
	local C = Codex()
	local r = newRow(src, "drop")
	local npc = src.npc and C.Npc(src.npc)
	local key = src.instance or (npc and npc.instance)
	local inst = key and C.Instance(key)
	r.label = npc and npc.name or L["Drop"]
	local chance = src.chance
	r.chance = chance
	if not chance or chance <= 0 then chance = DEFAULT_DROP_CHANCE end
	if chance > 100 then chance = 100 end
	local kills = 100 / chance
	if inst then
		if inst.entrance then
			local t = travel(from, inst.entrance)
			place(r, inst.entrance, t)
		end
		r.instance = inst.key
		r.detail = detail(L["Drop"], inst.name)
		r.effort = kills * (inst.kind == "raid" and RAID_RUN or DUNGEON_RUN)
		local need = inst.levels and inst.levels[1]
		if need and need > p.level then block(r, "level", levelText(need)) end
		r.guideable = npc ~= nil
	else
		local s, t
		if npc then s, t = nearest(npc.spawns, from) end
		place(r, s, t)
		r.detail = detail(L["Drop"], r.zone)
		local per = killSeconds(npc and npc.level, p.level, npc and npc.elite)
		if npc and npc.rare then per = per + RARE_RESPAWN end
		r.effort = kills * per
		r.guideable = npc ~= nil and located(r)
	end
	if npc and npc.level and npc.level - p.level > MOB_LEVEL_GAP and r.available then
		block(r, "level", L["Level"] .. " " .. npc.level)
	end
	return r
end

builders.object = function(src, p, from)
	local r = newRow(src, "object")
	local obj, s, t = objectSpawn(src.object, from)
	r.label = obj and obj.name or L["Object"]
	place(r, s, t)
	r.detail = detail(obj and obj.treasure and L["Treasure"] or L["Object"], r.zone)
	r.chance = src.chance
	local chance = src.chance
	if not chance or chance <= 0 then chance = DEFAULT_OBJECT_CHANCE end
	if chance > 100 then chance = 100 end
	r.effort = 100 / chance * OBJECT_SEARCH
	r.guideable = obj ~= nil and located(r)
	return r
end

builders.quest = function(src, p, from)
	local C = Codex()
	local r = newRow(src, "quest")
	local q = src.quest and C.Quest(src.quest)
	r.label = q and q.title or L["Quest"]
	if not q then
		r.detail = L["Quest"]
		return r
	end
	local giver = questEnd(q.start, from, p)
	local finish = questEnd(q["end"], nil, p)
	if giver then place(r, giver.spawn, giver.travel) end
	r.detail = detail(src.choice and L["Quest reward choice"] or L["Quest reward"], r.zone)
	r.effort = questEffort(q, p)
	local why, text = questBlock(q, p)
	if why then block(r, why, text) end
	if giver and giver.hostile then block(r, "faction", sideText(giver.faction)) end
	if q.repFaction and q.repStanding then repGate(r, q.repFaction, q.repStanding) end
	local startsFromItem = q.start and q.start.item and #q.start.item > 0
	r.guideable = (giver ~= nil or startsFromItem) and finish ~= nil
	return r
end

-- Primary professions the character has, by skill line.
local function primaryCount()
	local n = 0
	for line in pairs(PROFESSIONS) do
		if not SECONDARY[line] and ns.Compat.GetSkillRank(line) then n = n + 1 end
	end
	return n
end

builders.craft = function(src, p, from)
	local r = newRow(src, "craft")
	local line = src.skillLine
	local name = Lookup.ProfessionName(line)
	r.profession = name
	r.label = name and L[name] or L["Crafted"]
	if src.skill and src.skill > 0 then r.label = r.label .. " " .. src.skill end
	r.detail = L["Crafted"]
	local effort = CRAFT_BASE
	if src.spell and not ns.Compat.IsSpellKnown(src.spell) then effort = effort + CRAFT_LEARN end
	local rank = line and ns.Compat.GetSkillRank(line)
	if rank then
		if src.skill and rank < src.skill then effort = effort + (src.skill - rank) * SKILL_POINT end
	elseif not name then
		block(r, "profession", L["Requires a profession"])
	elseif SECONDARY[line] or primaryCount() < 2 then
		effort = effort + PROFESSION_LEARN + (src.skill or 1) * SKILL_POINT
	else
		block(r, "profession", L["Requires"] .. " " .. L[name])
	end
	r.effort = effort
	-- The nearest trainer of the profession, when the Codex lists them.
	local C = Codex()
	if line and C.WithRole then
		local best, bestT, bestNpc
		for _, id in ipairs(C.WithRole("trainer:" .. line) or {}) do
			local npc, s, t = npcSpawn(id, from)
			if npc and s and sideOK(npc.faction, p) and (not best or (t and (not bestT or t < bestT))) then
				best, bestT, bestNpc = s, t, npc
			end
		end
		if best then
			place(r, best, bestT)
			r.trainer = bestNpc.id
			r.detail = detail(L["Crafted"], r.zone)
		end
	end
	r.guideable = line ~= nil and src.spell ~= nil
	return r
end

builders.rep = function(src, p, from)
	local C = Codex()
	local r = newRow(src, "rep")
	local f = src.faction and C.Faction(src.faction)
	r.label = f and f.name or L["Reputation"]
	r.standing = src.standing
	r.detail = detail(L["Reputation"], src.standing and (ns.StandingName(src.standing) or "") or nil)
	local npc, s, t
	if src.npc then npc, s, t = npcSpawn(src.npc, from) end
	place(r, s, t)
	local code = f and (f.side == "Alliance" and "A" or f.side == "Horde" and "H" or nil)
	if code and not sideOK(code, p) then block(r, "faction", sideText(code)) end
	if npc and not sideOK(npc.faction, p) then block(r, "faction", sideText(npc.faction)) end
	local have = src.faction and ns.Compat.GetFactionStanding(src.faction)
	have = tonumber(have) or 4
	local need = src.standing or 1
	if have < need then
		r.effort = (need - have) * REP_STANDING
		block(r, "reputation", L["Requires"] .. " " .. (ns.StandingName(need) or "") .. " (" .. (ns.StandingName(have) or "") .. ")")
	end
	r.guideable = src.faction ~= nil and src.standing ~= nil and f ~= nil
	return r
end

builders.pvp = function(src, p, from)
	local r = newRow(src, "pvp")
	local npc, s, t
	if src.npc then npc, s, t = npcSpawn(src.npc, from) end
	r.label = npc and npc.name or L["PvP"]
	place(r, s, t)
	r.detail = detail(src.rank and (L["PvP rank"] .. " " .. src.rank) or L["PvP"], r.zone)
	r.effort = PVP_EFFORT
	if npc and not sideOK(npc.faction, p) then block(r, "faction", sideText(npc.faction)) end
	r.guideable = npc ~= nil and located(r)
	return r
end

builders.container = function(src)
	local C = Codex()
	local r = newRow(src, "container")
	r.label = (src.item and C.Name("item", src.item)) or L["Container"]
	r.detail = L["Container"]
	r.chance = src.chance
	r.effort = CONTAINER_EFFORT
	return r
end

builders.world = function(src, p)
	local r = newRow(src, "world")
	r.label = L["World drop"]
	if src.minLevel and src.maxLevel then
		r.detail = L["World drop"] .. SEP .. L["Level"] .. " " .. src.minLevel .. "-" .. src.maxLevel
	else
		r.detail = L["World drop"]
	end
	r.effort = WORLD_DROP_EFFORT
	if src.minLevel and src.minLevel - p.level > MOB_LEVEL_GAP then block(r, "level", L["Level"] .. " " .. src.minLevel) end
	return r
end

local function rank(list)
	for _, r in ipairs(list) do
		r.cost = (r.travel or 0) + (r.effort or 0)
	end
	table.sort(list, function(a, b)
		if a.available ~= b.available then return a.available end
		if a.cost ~= b.cost then return a.cost < b.cost end
		local la, lb = a.label or "", b.label or ""
		if la ~= lb then return la < lb end
		return a.type < b.type
	end)
	return list
end

---------------------------------------------------------------------------
-- Entities
---------------------------------------------------------------------------

-- What a vendor asks before selling the item, or an NPC before handing it
-- out: a standing with a faction (purchaseRep) and, to buy it, a skill rank
-- (item.reqSkill / reqSkillRank). Unmet: the row is unavailable and costs
-- the grind.
local PURCHASE = { vendor = true, pvp = true }

local function factionSide(id)
	local f = Codex().Faction(id)
	return f and (f.side == "Alliance" and "A" or f.side == "Horde" and "H") or nil
end

-- The standing a row at npcId asks -> faction, standing | nil: a reputation
-- source standing at that npc (the Codex's cited gate table, a guide's
-- gate), else, to buy it, the item's own (item.repFaction / repStanding)
-- unless that is the other side's faction and a gate of the npc's side
-- exists (Alterac Valley wares both sides' supply officers sell).
local function purchaseRep(item, npcId, purchase)
	if type(item) ~= "table" then return nil end
	local npc = npcId and Codex().Npc(npcId)
	local side = npc and npc.faction
	local ofSide
	for _, s in ipairs(item.sources or {}) do
		if s.type == "rep" and s.faction and s.standing and s.npc then
			if s.npc == npcId then return s.faction, s.standing end
			if side and not ofSide and factionSide(s.faction) == side then ofSide = s end
		end
	end
	if not (purchase and item.repFaction and item.repStanding) then return nil end
	local own = factionSide(item.repFaction)
	if ofSide and own and own ~= side then return ofSide.faction, ofSide.standing end
	return item.repFaction, item.repStanding
end
Lookup.PurchaseRep = purchaseRep

local function purchaseGates(item, r)
	local purchase = PURCHASE[r.type] or false
	local faction, standing = purchaseRep(item, r.src and r.src.npc, purchase)
	if faction then repGate(r, faction, standing) end
	if not purchase then return end
	if item.reqSkill and item.reqSkillRank then
		local rank = ns.Compat.GetSkillRank(item.reqSkill)
		if not rank or rank < item.reqSkillRank then
			local name = Lookup.ProfessionName(item.reqSkill)
			r.effort = (r.effort or 0) + (item.reqSkillRank - (rank or 0)) * SKILL_POINT
			block(r, "profession", L["Requires"] .. " " .. (name and L[name] or L["Profession"]) .. " " .. item.reqSkillRank)
		end
	end
end

local function itemSources(id, p, from)
	local C = Codex()
	local item = C.Item(id)
	if not item then return {}, nil end
	local list = {}
	for _, src in ipairs(item.sources or {}) do
		local build = builders[src.type]
		if build then
			local r = build(src, p, from)
			if r then list[#list + 1] = r end
		end
	end
	-- Item-wide gates: class mounts, required level, what a vendor asks.
	local spell = item.spell and C.Spell(item.spell)
	local class = spell and spell.class
	for _, r in ipairs(list) do
		if class and p.class and class ~= p.class then
			r.available, r.why, r.whyText = false, "class", L["Class mount"]
		elseif item.reqLevel and item.reqLevel > p.level then
			block(r, "level", levelText(item.reqLevel))
		end
		if PURCHASE[r.type] or r.type == "gift" then purchaseGates(item, r) end
		-- Retired stock (item.status, from codex build): listed by the Era
		-- databases, no longer handed out. Shown for the record, never guided.
		if item.status == "retired" then
			r.available, r.why, r.whyText, r.guideable = false, "retired", L["No longer obtainable"], false
		end
	end
	return list, item
end

local function spawnRows(entity, kind, p, from, levelGate)
	local list = {}
	for _, s in ipairs(entity.spawns or {}) do
		local r = newRow(nil, kind)
		r.label = entity.name
		place(r, s, travel(from, s))
		r.detail = r.zone
		if entity.level then r.detail = detail(r.zone or "", L["Level"] .. " " .. entity.level) end
		if levelGate and entity.level and entity.level - p.level > MOB_LEVEL_GAP then
			block(r, "level", L["Level"] .. " " .. entity.level)
		end
		if entity.faction and not sideOK(entity.faction, p) then r.hostile = true end
		r.guideable = located(r)
		list[#list + 1] = r
	end
	return list
end

local function questRows(q, p, from)
	local list = {}
	local why, text = questBlock(q, p)
	local giver = questEnd(q.start, from, p)
	local finish = questEnd(q["end"], from, p)
	if giver then
		local r = newRow(nil, "start")
		r.label = giver.name
		place(r, giver.spawn, giver.travel)
		r.detail = detail(L["Starts the quest"], r.zone)
		r.effort = questEffort(q, p)
		if why then block(r, why, text) end
		if giver.hostile then block(r, "faction", sideText(giver.faction)) end
		r.guideable = finish ~= nil
		list[#list + 1] = r
	end
	if finish then
		local r = newRow(nil, "end")
		r.label = finish.name
		place(r, finish.spawn, finish.travel)
		r.detail = detail(L["Ends the quest"], r.zone)
		r.effort = questEffort(q, p)
		if why then block(r, why, text) end
		-- Ranked after the giver: the turn-in only helps once the quest is taken.
		r.effort = r.effort + QUEST_BASE
		r.guideable = giver ~= nil or (q.start and q.start.item and #q.start.item > 0) or false
		list[#list + 1] = r
	end
	return list
end

local cache = {} -- "kind:id" -> { at, level, list, entity }

local function now() return GetTime and GetTime() or 0 end

function Lookup.Sources(kind, id)
	local C = Codex()
	if not (C and kind and id ~= nil) then return {}, nil end
	if not C.IsLoaded() and not C.Load() then return {}, nil end
	local p = playerInfo()
	local key = kind .. ":" .. tostring(id)
	local hit = cache[key]
	if hit and now() - hit.at < CACHE_SECONDS and hit.level == p.level then return hit.list, hit.entity end
	local from = ns.PlayerPoint()
	local list, entity = {}, nil
	if ITEM_KINDS[kind] then
		list, entity = itemSources(tonumber(id), p, from)
	elseif kind == "npc" or kind == "rare" then
		entity = C.Npc(id)
		if entity then list = spawnRows(entity, "spawn", p, from, true) end
	elseif kind == "object" or kind == "treasure" then
		entity = C.Object(id)
		if entity then list = spawnRows(entity, "spawn", p, from, false) end
	elseif kind == "quest" then
		entity = C.Quest(id)
		if entity then list = questRows(entity, p, from) end
	elseif kind == "instance" then
		entity = C.Instance(id)
		if entity and entity.entrance then
			local r = newRow(nil, "entrance")
			r.label = entity.name
			place(r, entity.entrance, travel(from, entity.entrance))
			r.detail = detail(L["Entrance"], r.zone)
			local need = entity.levels and entity.levels[1]
			if need and need > p.level then block(r, "level", levelText(need)) end
			r.guideable = true
			list = { r }
		end
	elseif kind == "zone" then
		entity = C.Zone(id)
	end
	rank(list)
	cache[key] = { at = now(), level = p.level, list = list, entity = entity }
	return list, entity
end

-- A short line under a search result, from the record alone (no ranking):
-- items their first source ("Vendor · Darnassus"), quests "Level 12 ·
-- Westfall", NPCs and treasures their zone, dungeons "Dungeon · 45-60".
local function firstZone(spawns)
	return type(spawns) == "table" and spawns[1] and zoneName(spawns[1].map) or nil
end

local function sourceLine(src)
	local C = Codex()
	local t = src.type
	if t == "vendor" or t == "drop" then
		local npc = src.npc and C.Npc(src.npc)
		local key = src.instance or (npc and npc.instance)
		local inst = key and C.Instance(key)
		local where = inst and inst.name or (npc and firstZone(npc.spawns))
		return detail(t == "vendor" and L["Vendor"] or L["Drop"], where)
	elseif t == "object" then
		local obj = src.object and C.Object(src.object)
		return detail(obj and obj.treasure and L["Treasure"] or L["Object"], obj and firstZone(obj.spawns))
	elseif t == "quest" then
		local q = src.quest and C.Quest(src.quest)
		return detail(L["Quest reward"], q and q.zone and zoneName(q.zone))
	elseif t == "gift" then
		local npc = src.npc and C.Npc(src.npc)
		return detail(L["Given by an NPC"], npc and firstZone(npc.spawns))
	elseif t == "craft" then
		local name = Lookup.ProfessionName(src.skillLine)
		return name and detail(L["Crafted"], L[name]) or L["Crafted"]
	elseif t == "rep" then
		local f = src.faction and C.Faction(src.faction)
		return detail(L["Reputation"], f and f.name)
	elseif t == "pvp" then
		return L["PvP"]
	elseif t == "container" then
		return L["Container"]
	elseif t == "world" then
		return L["World drop"]
	end
	return nil
end

function Lookup.Subtitle(kind, id)
	local C = Codex()
	if not (C and C.IsLoaded and C.IsLoaded()) then return nil end
	if ITEM_KINDS[kind] then
		local item = C.Item(id)
		local src = item and item.sources and item.sources[1]
		return src and sourceLine(src) or nil
	elseif kind == "quest" then
		local q = C.Quest(id)
		if not q then return nil end
		local zone = q.zone and zoneName(q.zone)
		if q.level then return detail(L["Level"] .. " " .. q.level, zone) end
		return zone
	elseif kind == "npc" or kind == "rare" then
		local npc = C.Npc(id)
		if not npc then return nil end
		local zone = firstZone(npc.spawns) or (npc.instance and C.Instance(npc.instance) or {}).name
		if npc.level and zone then return detail(zone, L["Level"] .. " " .. npc.level) end
		return zone
	elseif kind == "treasure" or kind == "object" then
		local obj = C.Object(id)
		return obj and firstZone(obj.spawns) or nil
	elseif kind == "instance" then
		local inst = C.Instance(id)
		if not inst then return nil end
		local label = inst.kind == "raid" and L["Raid"] or L["Dungeon"]
		local lv = inst.levels
		if lv and lv[1] and lv[#lv] then return detail(label, lv[1] .. "-" .. lv[#lv]) end
		return label
	end
	return nil
end

-- Forget cached rankings (a quest turned in, a profession learned...).
function Lookup.ResetSources()
	cache = {}
end

if ns.RegisterEvent then
	ns.RegisterEvent("QUEST_TURNED_IN", Lookup.ResetSources)
	ns.RegisterEvent("SKILL_LINES_CHANGED", Lookup.ResetSources)
	ns.RegisterEvent("ZONE_CHANGED_NEW_AREA", Lookup.ResetSources)
end

-- Rows carry NPC, object, quest and zone names as read: drop them when the
-- names pack lands late or a learned name changes.
if ns.On then
	ns.On("NAMES_LOADED", Lookup.ResetSources)
	ns.On("NAME_LEARNED", Lookup.ResetSources)
end

-- The best row for a guide: index given, else the first available guideable
-- row, else the first guideable one.
function Lookup.BestSource(list, index)
	if index then return list[index] end
	for _, r in ipairs(list) do
		if r.available and r.guideable then return r end
	end
	for _, r in ipairs(list) do
		if r.guideable then return r end
	end
	return nil
end
