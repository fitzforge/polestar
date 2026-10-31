-- Fights and loot (docs/RECORDING.md, "Fights and loot"): the creatures the
-- player sees (`unit` census, `rare`), treasures behind vignettes, kills with
-- the XP they paid and the objective they ticked, loot windows per source
-- with the open item objectives (the drop-chance denominator), instance
-- entrances and encounters.
--
-- Kills: Forever's combat log is closed to addons (COMBAT_LOG_EVENT_* are
-- callback events; C_CombatLog has no GetCurrentEventInfo), so deaths come
-- from PARTY_KILL and UNIT_DIED, which carry only GUIDs, and from the XP
-- line in chat. A death waits LINK_WINDOW seconds for its XP line and the
-- objective it ticked, then is written at the time it happened. Recorded:
-- the player's or pet's kills, deaths of creatures the player targeted (or
-- the client flags as quest-related), deaths that ticked an objective, an
-- XP line naming a creature the player saw, and every corpse looted.
--
-- APIs, verified against .ref/wow-ui-source-forever: UnitClassification,
-- UnitIsTapDenied, UnitReaction (UnitDocumentation), NAME_PLATE_UNIT_ADDED,
-- C_VignetteInfo and VIGNETTE_MINIMAP_UPDATED / VIGNETTES_UPDATED,
-- CanLootUnit, ENCOUNTER_START / ENCOUNTER_END, UNIT_SPELLCAST_SUCCEEDED,
-- PLAYER_LEAVING_WORLD, GetInstanceInfo (8th return: the instance map id),
-- the loot globals GetNumLootItems / GetLootSlotInfo / GetLootSlotLink /
-- GetLootSourceInfo / IsFishingLoot (LootFrame.lua), and the XP lines'
-- COMBATLOG_XPGAIN_* global strings. Unit identity is secret in combat and
-- in instances on this client: every read goes through ns.Usable, and a
-- secret reads as unknown.

local ADDON, ns = ...

local type, GetTime, tonumber, ipairs, pairs, wipe, concat = type, GetTime, tonumber, ipairs, pairs, wipe, table.concat
local usable, Str, Num = ns.Usable, ns.Str, ns.Num

local SIGHT_YARDS = 50 -- one rare / treasure sighting per npc (object) per this many yards per session
local UNIT_YARDS = 100 -- one `unit` per npc per this many yards per session (and per new level)
local CACHE_SIZE = 128 -- units remembered by GUID
local DONE_SIZE = 128 -- GUIDs already handled as dead / looted
local LOOT_CHECK = 1 -- seconds after a death to ask CanLootUnit whose loot it is
local LINK_WINDOW = 3 -- seconds a death waits for its objective tick and XP line
local XP_WINDOW = 1.5 -- seconds between a death and its XP line, either order
local GATHER_WINDOW = 3 -- seconds between a gathering cast and its loot window

local RARE = { rare = true, rareelite = true, worldboss = true }

-- Gathering casts whose loot window is not a kill's or a chest's (Classic
-- spell ids, every rank).
local GATHER = {}
for _, id in ipairs({ 2366, 2368, 3570, 11993 }) do GATHER[id] = "h" end
for _, id in ipairs({ 2575, 2576, 3564, 10248 }) do GATHER[id] = "m" end
for _, id in ipairs({ 8613, 8617, 8618, 10768 }) do GATHER[id] = "s" end
function ns.IsGatherSpell(spell) return GATHER[spell] ~= nil end

local function creature(kind) return kind == "Creature" or kind == "Vehicle" end

local function call(fn, ...)
	if type(fn) ~= "function" then return nil end
	local ok, v = pcall(fn, ...)
	if ok and usable(v) then return v end
	return nil
end

-- instance map id, difficulty, type while in a dungeon or raid.
local function instance()
	if not GetInstanceInfo then return nil end
	local _, kind, diff, _, _, _, _, id = GetInstanceInfo()
	kind = Str(kind)
	if kind ~= "party" and kind ~= "raid" then return nil end
	id = Num(id)
	if not id or id <= 0 then return nil end
	return id, Num(diff), kind
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
-- Units seen: GUID -> { npc, name, cls, lvl, tapped, targeted, related }.
-- Names stay in memory (to read XP lines and objective texts), never in a
-- record.
---------------------------------------------------------------------------

local units, unitKeys, unitPos = {}, {}, 0
local byName = {} -- name -> GUID last seen with it

local function remember(guid, u)
	if not units[guid] then
		unitPos = unitPos % CACHE_SIZE + 1
		local old = unitKeys[unitPos]
		if old then
			local o = units[old]
			if o and o.name and byName[o.name] == old then byName[o.name] = nil end
			units[old] = nil
		end
		unitKeys[unitPos] = guid
	end
	units[guid] = u
	if u.name then byName[u.name] = guid end
end

local function react(unit)
	local r = call(UnitReaction, unit, "player")
	if type(r) ~= "number" then return nil end
	if r <= 3 then return "h" end
	if r == 4 then return "n" end
	return "f"
end

---------------------------------------------------------------------------
-- Sightings: the unit census, rares and treasures
---------------------------------------------------------------------------

local levelSeen = {} -- "npc:level" seen this session
local placesSeen = {} -- "u<npc>" | "r<npc>" | "t<object>" -> { { map, x, y } }

local function near(key, map, x, y, yards)
	local list = placesSeen[key]
	if not list then return false end
	for _, p in ipairs(list) do
		if p.map == map and ns.Yards(map, p.x - x, p.y - y) <= yards then return true end
	end
	return false
end

local function remember_place(key, map, x, y)
	local list = placesSeen[key]
	if not list then
		list = {}
		placesSeen[key] = list
	end
	list[#list + 1] = { map = map, x = x, y = y }
end

local UNIT_SRC = { nameplate = "p", target = "t", mouseover = "m" }

local function census(npc, lvl, cls, reaction, src)
	local map, x, y = ns.Position()
	local lkey = npc .. ":" .. (lvl or "")
	local key = "u" .. npc
	local newLevel = not levelSeen[lkey]
	local newPlace = x and not near(key, map, x, y, UNIT_YARDS)
	if not (newLevel or newPlace) then return end
	if ns.Rec("unit", npc, lvl, ns.Cls(cls), reaction, ns.PAt(map, x, y), UNIT_SRC[src]) then
		levelSeen[lkey] = true
		if x then remember_place(key, map, x, y) end
	end
end

local function sighting(kind, key, id, rest, map, x, y)
	if not (map and x and y) or near(key, map, x, y, SIGHT_YARDS) then return end
	local ok
	if kind == "rare" then
		ok = ns.Rec("rare", id, rest.lvl, ns.Cls(rest.cls), ns.PAt(map, x, y), rest.src)
	else
		ok = ns.Rec("treasure", id, ns.PAt(map, x, y))
	end
	if ok then remember_place(key, map, x, y) end
end

local RARE_SRC = { nameplate = "p", target = "t", mouseover = "m" }

local function seeUnit(unit, src)
	if not ns.Recording() or not call(UnitExists, unit) then return end
	local guid = Str(UnitGUID(unit))
	local kind, npc = ns.ParseGUID(guid)
	if not creature(kind) or not npc then return end
	if call(UnitIsPlayer, unit) or call(UnitPlayerControlled, unit) then return end
	local cls = Str(call(UnitClassification, unit))
	local lvl = Num(call(UnitLevel, unit))
	local e = units[guid]
	if not e then
		e = { npc = npc }
	end
	e.name = Str(call(UnitName, unit)) or e.name
	e.cls, e.lvl = cls or e.cls, lvl or e.lvl
	local denied = call(UnitIsTapDenied, unit)
	if denied ~= nil then e.tapped = denied and true or false end
	if src == "target" then e.targeted = true end
	if not e.related and C_QuestLog.UnitIsRelatedToActiveQuest and call(C_QuestLog.UnitIsRelatedToActiveQuest, unit) then e.related = true end
	remember(guid, e)
	census(npc, lvl, cls, react(unit), src)
	if cls and RARE[cls] then
		local map, x, y = ns.Position()
		sighting("rare", "r" .. npc, npc, { lvl = lvl, cls = cls, src = RARE_SRC[src] }, map, x, y)
	end
end

ns.On("NAME_PLATE_UNIT_ADDED", function(_, unit) if Str(unit) then seeUnit(unit, "nameplate") end end)
ns.On("PLAYER_TARGET_CHANGED", function() seeUnit("target", "target") end)
ns.On("UPDATE_MOUSEOVER_UNIT", function() seeUnit("mouseover", "mouseover") end)

local function vignette(vguid)
	local V = C_VignetteInfo
	if not (ns.Recording() and Str(vguid) and V and V.GetVignetteInfo and V.GetVignettePosition and C_Map and C_Map.GetBestMapForUnit) then return end
	local ok, info = pcall(V.GetVignetteInfo, vguid)
	if not ok or type(info) ~= "table" then return end
	local guid = Str(info.objectGUID)
	local kind, id = ns.ParseGUID(guid)
	if not id then return end
	local map = C_Map.GetBestMapForUnit("player")
	if not map then return end
	local okPos, pos = pcall(V.GetVignettePosition, vguid, map)
	if not okPos or type(pos) ~= "table" then return end
	local x, y
	if pos.GetXY then x, y = pos:GetXY() else x, y = pos.x, pos.y end
	x, y = Num(x), Num(y)
	if not (x and y) or (x == 0 and y == 0) then return end
	x, y = x * 100, y * 100
	if creature(kind) then
		local u = units[guid]
		sighting("rare", "r" .. id, id, { lvl = u and u.lvl, cls = u and u.cls, src = "v" }, map, x, y)
	elseif kind == "GameObject" then
		sighting("treasure", "t" .. id, id, nil, map, x, y)
	end
end

ns.On("VIGNETTE_MINIMAP_UPDATED", function(_, vguid, onMinimap)
	if ns.Value(onMinimap) then vignette(vguid) end
end)
ns.On("VIGNETTES_UPDATED", function()
	local V = C_VignetteInfo
	if not (ns.Recording() and V and V.GetVignettes) then return end
	local ok, list = pcall(V.GetVignettes)
	if not ok or type(list) ~= "table" then return end
	for _, vguid in ipairs(list) do vignette(vguid) end
end)

---------------------------------------------------------------------------
-- XP lines: the client's COMBATLOG_XPGAIN_* format strings as Lua patterns,
-- so every client language reads. Captures come back in argument order
-- (positional %1$s forms included).
---------------------------------------------------------------------------

-- fmt -> pattern, { argIndex per capture }
local function formatPattern(fmt)
	if type(fmt) ~= "string" or fmt == "" then return nil end
	local out, args, n, i = {}, {}, 0, 1
	while i <= #fmt do
		local s, e, pos, conv = fmt:find("^%%(%d*)%$?([sd])", i)
		if s then
			n = n + 1
			args[#args + 1] = pos ~= "" and tonumber(pos) or n
			out[#out + 1] = conv == "s" and "(.-)" or "([%-%+]?%d+)"
			i = e + 1
		elseif fmt:sub(i, i + 1) == "%%" then
			out[#out + 1] = "%%"
			i = i + 2
		else
			local c = fmt:sub(i, i)
			out[#out + 1] = c:find("[%^%$%(%)%%%.%[%]%*%+%-%?]") and "%" .. c or c
			i = i + 1
		end
	end
	return "^" .. concat(out) .. "$", args
end
ns.FormatPattern = formatPattern

-- Global string names, most specific first: { name, rested (arg 3 is the bonus) }.
local XP_FORMATS = {
	{ "COMBATLOG_XPGAIN_EXHAUSTION1_GROUP", true }, { "COMBATLOG_XPGAIN_EXHAUSTION1_RAID", true },
	{ "COMBATLOG_XPGAIN_EXHAUSTION2_GROUP", false }, { "COMBATLOG_XPGAIN_EXHAUSTION2_RAID", false },
	{ "COMBATLOG_XPGAIN_EXHAUSTION1", true }, { "COMBATLOG_XPGAIN_EXHAUSTION2", false },
	{ "COMBATLOG_XPGAIN_FIRSTPERSON_GROUP", false }, { "COMBATLOG_XPGAIN_FIRSTPERSON_RAID", false },
	{ "COMBATLOG_XPGAIN_FIRSTPERSON", false },
}
local xpPatterns -- built on first use (global strings load late)

-- name, xp, rested of a kill's XP line, or nil.
function ns.ParseKillXP(text)
	if not (usable(text) and type(text) == "string") then return nil end
	if not xpPatterns then
		xpPatterns = {}
		for _, f in ipairs(XP_FORMATS) do
			local p, args = formatPattern(_G[f[1]])
			if p then xpPatterns[#xpPatterns + 1] = { p = p, args = args, rested = f[2] } end
		end
	end
	for _, x in ipairs(xpPatterns) do
		local caps = { text:match(x.p) }
		if caps[1] then
			local v = {}
			for i, a in ipairs(x.args) do v[a] = caps[i] end
			local xp = tonumber(v[2])
			if v[1] and xp then
				local rested = x.rested and v[3] and tonumber((v[3]:match("%d+"))) or nil
				return v[1], xp, rested
			end
		end
	end
	return nil
end

---------------------------------------------------------------------------
-- Kills
---------------------------------------------------------------------------

local dead, markDead = ring(DONE_SIZE)
local pending = {} -- deaths waiting for their XP line and objective
local recent = { at = -math.huge, q = nil, oi = nil, text = nil, left = 0 } -- progress no death claimed yet
local xpLine = nil -- { name, xp, rested, at } no death claimed yet

local function nameMatches(name, text)
	return not name or not text or text:find(name, 1, true) ~= nil
end

local function finish(k)
	for i = #pending, 1, -1 do
		if pending[i] == k then table.remove(pending, i) end
	end
	if not (k.keep or k.q[1] or k.xp) then return end
	local tapped
	if k.denied ~= nil then tapped = k.denied elseif k.tapped ~= nil then tapped = k.tapped end
	ns.RecAt(k.t, "kill", k.npc, k.lvl, ns.Cls(k.cls), k.p, k.xp, k.rested, tapped, k.q[1] and concat(k.q, ";") or nil)
end

-- A creature seen with this name that is not dead (the XP line may be its).
local function seenAlive(name)
	local guid = byName[name]
	return guid ~= nil and not dead[guid]
end

local function takeXP(k)
	local x = xpLine
	if x and not k.xp and GetTime() - x.at <= XP_WINDOW and (k.name == x.name or (not k.name and not seenAlive(x.name))) then
		k.xp, k.rested = x.xp, x.rested
		xpLine = nil
	end
end

local function onDeath(guid, byPlayer, keep)
	if not (ns.Recording() and Str(guid)) or dead[guid] then return end
	local kind, npc = ns.ParseGUID(guid)
	if not creature(kind) or not npc then return end
	markDead(guid)
	local e = units[guid]
	local now = GetTime()
	local k = {
		guid = guid, npc = npc, name = e and e.name, lvl = e and e.lvl, cls = e and e.cls, tapped = e and e.tapped,
		t = now, p = ns.P(), q = {},
		keep = keep or byPlayer or (e and (e.targeted or e.related)) or false,
	}
	-- The objective may have ticked just before the death was reported.
	if recent.left > 0 and now - recent.at <= LINK_WINDOW and nameMatches(k.name, recent.text) then
		recent.left = recent.left - 1
		k.q[1] = ("%d:%d"):format(recent.q, recent.oi)
	end
	takeXP(k)
	pending[#pending + 1] = k
	if CanLootUnit then
		C_Timer.After(LOOT_CHECK, function()
			-- A tapped or round-robin corpse is someone else's loot.
			local ok, hasLoot, canLoot = pcall(CanLootUnit, guid)
			if ok and ns.Value(hasLoot) == true and ns.Value(canLoot) == false then k.denied = true end
		end)
	end
	C_Timer.After(LINK_WINDOW, function() finish(k) end)
end
ns.KillSeen = onDeath

ns.On("UNIT_DIED", function(_, guid) onDeath(guid, false) end)
ns.On("PARTY_KILL", function(_, attacker, target)
	attacker = Str(attacker)
	if not attacker then return end
	local pet = UnitGUID("pet")
	onDeath(target, attacker == UnitGUID("player") or (pet ~= nil and attacker == pet))
end)

ns.OnProgress(function(q, oi, o, delta)
	if o.type ~= "monster" then return end
	local now = GetTime()
	local text = Str(o.text)
	for i = #pending, 1, -1 do
		if delta <= 0 then break end
		local k = pending[i]
		if not k.q[1] and now - k.t <= LINK_WINDOW and nameMatches(k.name, text) then
			k.q[1] = ("%d:%d"):format(q, oi)
			delta = delta - 1
		end
	end
	recent.at, recent.q, recent.oi, recent.text, recent.left = now, q, oi, text, delta
end)

-- A kill's XP line: to the waiting death it names, else kept for the death
-- about to be reported, else (no death at all) a kill of the creature seen
-- with that name. A death whose name is unknown takes it only when no
-- living creature the player saw carries that name.
ns.On("CHAT_MSG_COMBAT_XP_GAIN", function(_, text)
	if not ns.Recording() then return end
	local name, xp, rested = ns.ParseKillXP(text)
	if not name then return end
	local now = GetTime()
	local unnamedOk = not seenAlive(name)
	for pass = 1, 2 do
		for i = #pending, 1, -1 do
			local k = pending[i]
			if not k.xp and now - k.t <= XP_WINDOW and (k.name == name or (pass == 2 and unnamedOk and not k.name)) then
				k.xp, k.rested = xp, rested
				return
			end
		end
	end
	local x = { name = name, xp = xp, rested = rested, at = now }
	xpLine = x
	C_Timer.After(XP_WINDOW, function()
		if xpLine ~= x then return end
		xpLine = nil
		local guid = byName[name]
		if guid and not dead[guid] then
			onDeath(guid, true)
			local k = pending[#pending]
			if k and k.guid == guid then
				k.t, k.xp, k.rested = x.at, xp, rested
			end
		end
	end)
end)

---------------------------------------------------------------------------
-- Encounters
---------------------------------------------------------------------------

local encounter -- { enc, diff, size }

ns.On("ENCOUNTER_START", function(_, id, _, diff, size)
	id = Num(id)
	if not id then return end
	encounter = { enc = id, diff = Num(diff), size = Num(size) }
end)

ns.On("ENCOUNTER_END", function(_, id, _, diff, size, success)
	id = Num(id)
	if not id then return end
	local e = encounter
	encounter = nil
	if not (e and e.enc == id) then e = {} end
	ns.Rec("encounter", id, Num(success) == 1, Num(diff) or e.diff, Num(size) or e.size)
end)

---------------------------------------------------------------------------
-- Loot windows, per source
---------------------------------------------------------------------------

local looted, markLooted = ring(DONE_SIZE)
local lastCast, lastCastAt = nil, -math.huge

ns.On("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spell)
	if ns.Value(unit) ~= "player" then return end
	spell = Num(spell)
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
	local target = Str(UnitGUID("target"))
	if target and call(UnitIsDead, "target") then return { target } end
	return {}
end

local function slotItem(slot)
	local link = Str(GetLootSlotLink and GetLootSlotLink(slot))
	return link and tonumber(link:match("item:(%d+)"))
end

local function itemList(items)
	if #items == 0 then return nil end
	local out = {}
	for i, it in ipairs(items) do out[i] = ("%d:%d"):format(it[1], it[2]) end
	return concat(out, ";")
end

ns.On("LOOT_OPENED", function()
	if not (GetNumLootItems and GetLootSlotInfo) or not ns.Recording() then return end
	local p = ns.P()
	if IsFishingLoot and ns.Value(IsFishingLoot()) then
		local items = {}
		for slot = 1, GetNumLootItems() do
			local item = slotItem(slot)
			if item then items[#items + 1] = { item, Num(select(3, GetLootSlotInfo(slot))) or 1 } end
		end
		ns.Rec("loot", nil, nil, p, "f", itemList(items), ns.Wanted())
		return
	end
	local gather = gathering()
	local bySource, order = {}, {}
	for slot = 1, GetNumLootItems() do
		local quantity = select(3, GetLootSlotInfo(slot))
		local item = slotItem(slot)
		local list = sources(slot)
		for i = 1, #list, 2 do
			local guid = Str(list[i])
			local key = guid and (gather and guid .. "#" .. gather or guid)
			if key and not looted[key] then
				local s = bySource[key]
				if not s then
					s = { guid = guid, items = {} }
					bySource[key] = s
					order[#order + 1] = key
				end
				if item then s.items[#s.items + 1] = { item, Num(list[i + 1]) or Num(quantity) or 1 } end
			end
		end
	end
	local wanted = ns.Wanted()
	for _, key in ipairs(order) do
		local s = bySource[key]
		local kind, id = ns.RefOfGUID(s.guid)
		if kind == "c" or kind == "o" or kind == "i" then
			-- a corpse looted is a kill counted, so loots never outnumber kills
			if kind == "c" and not gather then onDeath(s.guid, false, true) end
			markLooted(key)
			ns.Rec("loot", kind, id, p, gather, itemList(s.items), wanted)
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

local function checkInstance()
	local id, diff, kind = instance()
	if id == inInstance then
		if not id then noteOutdoor() end
		return
	end
	inInstance = id
	if not id then
		noteOutdoor()
		return
	end
	local o = outdoor
	ns.Rec("enter", id, kind, diff, o and ns.PAt(o.map, o.x, o.y) or ns.NO_P)
end

-- The loading screen into an instance starts here, still at the portal.
ns.On("PLAYER_LEAVING_WORLD", noteOutdoor)
ns.On("PLAYER_ENTERING_WORLD", checkInstance)
ns.On("ZONE_CHANGED_NEW_AREA", checkInstance)
ns.On("ZONE_CHANGED", noteOutdoor)

---------------------------------------------------------------------------
-- Session start: dedupe sets start empty
---------------------------------------------------------------------------

ns.OnSession(function()
	wipe(levelSeen)
	wipe(placesSeen)
	pending = {}
	recent.left, xpLine = 0, nil
	inInstance = nil
	checkInstance()
end)
