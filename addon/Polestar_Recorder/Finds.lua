-- Finds: what the Codex needs and the client tables cannot give, recorded
-- the way RareScanner and AtlasLoot gather it in play. Schema in
-- docs/ARCHITECTURE.md ("Recordings"); `data build` turns these events into
-- npc ranks and spawns, drop chances, treasures and instance facts.
--
--   rare       a rare (UnitClassification rare | rareelite | worldboss) seen on
--              a nameplate, as target or mouseover, or behind a vignette;
--              once per npc per SIGHT_YARDS per session
--   treasure   a game object behind a vignette (a treasure), same de-duplication
--   slain      a creature the player or pet killed, or looted (a party kill),
--              with its classification and level when the unit was seen;
--              `denied` when its corpse turned out to be someone else's loot
--   drop       one loot window per source (GetLootSourceInfo: the corpse or
--              game object): the items in it with counts, and `gather` when a
--              gathering cast (herb, mine, skin) opened it
--   enter      zoning into a dungeon or raid, with the last outdoor position
--              before it (the entrance)
--   encounter  ENCOUNTER_END: the encounter, its result and the bosses the
--              client lists for it (or the creatures that died during it)
--
-- APIs, verified against .ref/wow-ui-source-forever: UnitClassification
-- (UnitDocumentation), NAME_PLATE_UNIT_ADDED, C_VignetteInfo and
-- VIGNETTE_MINIMAP_UPDATED / VIGNETTES_UPDATED (VignetteInfoDocumentation),
-- CanLootUnit (PlayerScriptDocumentation), ENCOUNTER_START / ENCOUNTER_END
-- (EncounterInfoDocumentation), UNIT_SPELLCAST_SUCCEEDED, PLAYER_LEAVING_WORLD,
-- GetInstanceInfo (8th return: the instance map id), and the loot globals
-- GetNumLootItems / GetLootSlotInfo / GetLootSlotLink / GetLootSourceInfo /
-- IsFishingLoot (LootFrame.lua). Every read may be a secret value; a secret
-- reads as unknown.

local ADDON, ns = ...

local type, GetTime, tonumber, ipairs, pairs, wipe = type, GetTime, tonumber, ipairs, pairs, wipe
local usable = ns.Usable

local SIGHT_YARDS = 50 -- one sighting per npc (or treasure) per this many yards per session
local CACHE_SIZE = 128 -- units remembered (classification, level, name) by GUID
local DONE_SIZE = 128 -- GUIDs already recorded as slain / looted
local LOOT_CHECK = 1 -- seconds after a kill to ask CanLootUnit whose loot it is
local GATHER_WINDOW = 3 -- seconds between a gathering cast and its loot window
local ENCOUNTER_NPCS = 16

local RARE = { rare = true, rareelite = true, worldboss = true }

-- Gathering casts whose loot window is not a kill's or a chest's drop
-- (Classic spell ids, every rank).
local GATHER = {}
for _, id in ipairs({ 2366, 2368, 3570, 11993 }) do GATHER[id] = "herb" end
for _, id in ipairs({ 2575, 2576, 3564, 10248 }) do GATHER[id] = "mine" end
for _, id in ipairs({ 8613, 8617, 8618, 10768 }) do GATHER[id] = "skin" end

local function value(v)
	if usable(v) then return v end
	return nil
end

local function str(v)
	v = value(v)
	if type(v) == "string" and v ~= "" then return v end
	return nil
end

local function num(v)
	v = value(v)
	if type(v) == "number" then return v end
	return nil
end

local function creature(kind) return kind == "Creature" or kind == "Vehicle" end

-- instance map id, difficulty, name, type while in a dungeon or raid.
local function instance()
	if not GetInstanceInfo then return nil end
	local name, kind, diff, _, _, _, _, id = GetInstanceInfo()
	kind = str(kind)
	if kind ~= "party" and kind ~= "raid" then return nil end
	id = num(id)
	if not id or id <= 0 then return nil end
	return id, num(diff), str(name), kind
end

-- A fixed ring of recently used keys; evicted keys leave `set`.
local function ring(size)
	local set, keys, pos = {}, {}, 0
	return set, function(key)
		pos = pos % size + 1
		local old = keys[pos]
		if old ~= nil then set[old] = nil end
		keys[pos] = key
		set[key] = true
	end
end

---------------------------------------------------------------------------
-- Units seen: GUID -> { npc, name, cls, lvl }
---------------------------------------------------------------------------

local units, unitKeys, unitPos = {}, {}, 0

local function remember(guid, u)
	if not units[guid] then
		unitPos = unitPos % CACHE_SIZE + 1
		local old = unitKeys[unitPos]
		if old then units[old] = nil end
		unitKeys[unitPos] = guid
	end
	units[guid] = u
end

---------------------------------------------------------------------------
-- Sightings: rares and treasures
---------------------------------------------------------------------------

local sighted = {} -- "npc:<id>" | "object:<id>" -> { { map, x, y } }

ns.OnSession(function() wipe(sighted) end)

local function near(key, map, x, y)
	local list = sighted[key]
	if not list then return false end
	for _, p in ipairs(list) do
		if p.map == map and ns.Yards(map, p.x - x, p.y - y) <= SIGHT_YARDS then return true end
	end
	return false
end

local function sighting(kind, key, ev)
	if not (ev.map and ev.x and ev.y) or near(key, ev.map, ev.x, ev.y) then return end
	ev.inst = instance()
	local map, x, y = ev.map, ev.x, ev.y
	if ns.Record(kind, ev) then
		local list = sighted[key] or {}
		sighted[key] = list
		list[#list + 1] = { map = map, x = x, y = y }
	end
end

local function seeUnit(unit, src)
	if not (UnitExists and value(UnitExists(unit))) then return end
	local guid = str(UnitGUID(unit))
	local kind, npc = ns.ParseGUID(guid)
	if not creature(kind) or not npc then return end
	if value(UnitIsPlayer and UnitIsPlayer(unit)) or value(UnitPlayerControlled and UnitPlayerControlled(unit)) then return end
	local cls = str(UnitClassification and UnitClassification(unit))
	local lvl = num(UnitLevel and UnitLevel(unit))
	local name = str(UnitName(unit))
	remember(guid, { npc = npc, name = name, cls = cls, lvl = lvl })
	if not (cls and RARE[cls]) then return end
	local map, x, y = ns.Position()
	sighting("rare", "npc:" .. npc, { npc = npc, npcName = name, cls = cls, npcLvl = lvl, src = src, map = map, x = x, y = y })
end

ns.On("NAME_PLATE_UNIT_ADDED", function(_, unit) if str(unit) then seeUnit(unit, "nameplate") end end)
ns.On("PLAYER_TARGET_CHANGED", function() seeUnit("target", "target") end)
ns.On("UPDATE_MOUSEOVER_UNIT", function() seeUnit("mouseover", "mouseover") end)

local function vignette(vguid)
	local V = C_VignetteInfo
	if not (str(vguid) and V and V.GetVignetteInfo and V.GetVignettePosition and C_Map and C_Map.GetBestMapForUnit) then return end
	local ok, info = pcall(V.GetVignetteInfo, vguid)
	if not ok or type(info) ~= "table" then return end
	local guid = str(info.objectGUID)
	local kind, id = ns.ParseGUID(guid)
	if not id then return end
	local map = C_Map.GetBestMapForUnit("player")
	if not map then return end
	local okPos, pos = pcall(V.GetVignettePosition, vguid, map)
	if not okPos or type(pos) ~= "table" then return end
	local x, y
	if pos.GetXY then x, y = pos:GetXY() else x, y = pos.x, pos.y end
	x, y = num(x), num(y)
	if not (x and y) or (x == 0 and y == 0) then return end
	x, y = ns.Round2(x * 100), ns.Round2(y * 100)
	local name = str(info.name)
	if creature(kind) then
		local u = units[guid]
		sighting("rare", "npc:" .. id, { npc = id, npcName = name or (u and u.name), cls = u and u.cls, npcLvl = u and u.lvl, src = "vignette", map = map, x = x, y = y })
	elseif kind == "GameObject" then
		sighting("treasure", "object:" .. id, { object = id, objName = name, src = "vignette", map = map, x = x, y = y })
	end
end

ns.On("VIGNETTE_MINIMAP_UPDATED", function(_, vguid, onMinimap)
	if value(onMinimap) then vignette(vguid) end
end)
ns.On("VIGNETTES_UPDATED", function()
	local V = C_VignetteInfo
	if not (V and V.GetVignettes) then return end
	local ok, list = pcall(V.GetVignettes)
	if not ok or type(list) ~= "table" then return end
	for _, vguid in ipairs(list) do vignette(vguid) end
end)

---------------------------------------------------------------------------
-- Kills, and the encounter they belong to
---------------------------------------------------------------------------

local slain, markSlain = ring(DONE_SIZE)
local encounter -- { enc, encName, diff, size, inst, npcs = { ids }, has = { [id] = true } }

local function recordSlain(guid, npc)
	if slain[guid] then return end
	markSlain(guid)
	local u = units[guid]
	local inst, diff = instance()
	local ev = ns.Here({ npc = npc, npcName = u and u.name, cls = u and u.cls, npcLvl = u and u.lvl, inst = inst, diff = diff })
	if not ns.Record("slain", ev) or not CanLootUnit then return end
	-- A tapped or round-robin corpse is someone else's loot: its kill tells
	-- nothing about this npc's drops. The stored event is updated in place.
	C_Timer.After(LOOT_CHECK, function()
		local ok, hasLoot, canLoot = pcall(CanLootUnit, guid)
		if ok and value(hasLoot) == true and value(canLoot) == false then ev.denied = true end
	end)
end

ns.On("PARTY_KILL", function(_, attacker, target)
	attacker, target = str(attacker), str(target)
	if not (attacker and target) then return end
	local pet = UnitGUID("pet")
	if attacker ~= UnitGUID("player") and not (pet and attacker == pet) then return end
	local kind, npc = ns.ParseGUID(target)
	if creature(kind) and npc then recordSlain(target, npc) end
end)

ns.On("UNIT_DIED", function(_, guid)
	local e = encounter
	if not e or #e.npcs >= ENCOUNTER_NPCS then return end
	local kind, npc = ns.ParseGUID(str(guid))
	if creature(kind) and npc and not e.has[npc] then
		e.has[npc] = true
		e.npcs[#e.npcs + 1] = npc
	end
end)

ns.On("ENCOUNTER_START", function(_, id, name, diff, size)
	id = num(id)
	if not id then return end
	encounter = { enc = id, encName = str(name), diff = num(diff), size = num(size), inst = instance(), npcs = {}, has = {} }
end)

ns.On("ENCOUNTER_END", function(_, id, name, diff, size, success, status)
	id = num(id)
	if not id then return end
	local e = encounter
	encounter = nil
	if not (e and e.enc == id) then e = { npcs = {}, inst = instance() } end
	-- The bosses the client lists for the encounter; else whatever died in it.
	local bosses = {}
	if type(value(status)) == "table" then
		for _, u in ipairs(status) do
			local npc = type(u) == "table" and num(u.creatureID)
			if npc and npc > 0 then bosses[#bosses + 1] = npc end
		end
	end
	if #bosses == 0 then bosses = e.npcs end
	ns.Record("encounter", ns.Here({
		enc = id, encName = str(name) or e.encName, diff = num(diff) or e.diff, size = num(size) or e.size,
		ok = num(success) == 1, inst = e.inst, npcs = #bosses > 0 and bosses or nil,
	}))
end)

---------------------------------------------------------------------------
-- Loot windows, per source
---------------------------------------------------------------------------

local looted, markLooted = ring(DONE_SIZE)
local lastCast, lastCastAt = nil, -math.huge

ns.On("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spell)
	if value(unit) ~= "player" then return end
	spell = num(spell)
	if spell then lastCast, lastCastAt = spell, GetTime() end
end)

local function gathering()
	local spell = lastCast
	lastCast = nil -- one cast opens one loot window
	if spell and GetTime() - lastCastAt <= GATHER_WINDOW then return GATHER[spell] end
	return nil
end

-- { guid, count, guid, count, ... } for a slot; the dead target when the
-- client does not say.
local function sources(slot)
	if GetLootSourceInfo then
		local list = { GetLootSourceInfo(slot) }
		if #list > 0 then return list end
	end
	local target = str(UnitGUID("target"))
	if target and value(UnitIsDead and UnitIsDead("target")) then return { target } end
	return {}
end

ns.On("LOOT_OPENED", function()
	if not (GetNumLootItems and GetLootSlotInfo) or not ns.Session() then return end
	if IsFishingLoot and value(IsFishingLoot()) then return end
	local gather = gathering()
	local bySource, order = {}, {}
	for slot = 1, GetNumLootItems() do
		local _, _, quantity, _, _, _, isQuestItem = GetLootSlotInfo(slot)
		local link = str(GetLootSlotLink and GetLootSlotLink(slot))
		local item = link and tonumber(link:match("item:(%d+)"))
		local list = sources(slot)
		for i = 1, #list, 2 do
			local guid = str(list[i])
			local key = guid and (gather and guid .. "#" .. gather or guid)
			if key and not looted[key] then
				local s = bySource[key]
				if not s then
					s = { guid = guid, items = {} }
					bySource[key] = s
					order[#order + 1] = key
				end
				if item then
					local n = num(list[i + 1]) or num(quantity) or 1
					s.items[#s.items + 1] = { item = item, n = n, q = value(isQuestItem) == true or nil }
				end
			end
		end
	end
	local inst, diff = instance()
	for _, key in ipairs(order) do
		local s = bySource[key]
		local kind, id = ns.ParseGUID(s.guid)
		local ev = { items = #s.items > 0 and s.items or nil, gather = gather, inst = inst, diff = diff }
		if creature(kind) and id then
			ev.npc = id
			local u = units[s.guid]
			ev.npcName = u and u.name
			-- a corpse looted is a kill counted, so loots never outnumber kills
			if not gather then recordSlain(s.guid, id) end
		elseif kind == "GameObject" and id then
			ev.object = id
		end
		if ev.npc or ev.object then
			markLooted(key)
			ns.Record("drop", ns.Here(ev))
		end
	end
end)

---------------------------------------------------------------------------
-- Instance entrances
---------------------------------------------------------------------------

local inInstance -- instance map id while inside one
local outdoor -- { map, x, y }: the last position outside any instance

local function noteOutdoor()
	if instance() then return end
	local map, x, y = ns.Position()
	if map and x and y then outdoor = { map = map, x = x, y = y } end
end

-- The players in the group (1 alone), for how long a party takes to clear
-- (the simulator's calibration: docs/SIMULATION.md, "Calibration").
local function partySize()
	local n = GetNumGroupMembers and GetNumGroupMembers() or 0
	return n > 0 and n or 1
end

local function checkInstance()
	local id, diff, name, kind = instance()
	if id == inInstance then
		if not id then noteOutdoor() end
		return
	end
	-- Out of one (or straight into another): its run ends here.
	if inInstance then ns.Record("leave", { inst = inInstance, party = partySize() }) end
	inInstance = id
	if not id then
		noteOutdoor()
		return
	end
	local ev = { inst = id, instName = name, instType = kind, diff = diff, party = partySize(), lvl = UnitLevel and num(UnitLevel("player")) or nil }
	if outdoor then ev.map, ev.x, ev.y = outdoor.map, outdoor.x, outdoor.y end
	ns.Record("enter", ev)
end

ns.OnSession(function()
	inInstance = nil
	checkInstance()
end)
-- The loading screen into an instance starts here, still at the portal.
ns.On("PLAYER_LEAVING_WORLD", noteOutdoor)
ns.On("PLAYER_ENTERING_WORLD", checkInstance)
ns.On("ZONE_CHANGED_NEW_AREA", checkInstance)
ns.On("ZONE_CHANGED", noteOutdoor)
