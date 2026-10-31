-- World records (docs/RECORDING.md, "Context", "Movement", "Services"):
-- breadcrumbs (`pos`), rides on boats, zeppelins, lifts and trams (`ride`),
-- zone changes, level-ups and the 5-minute `xp`, deaths with their killer,
-- flight masters and flights (`flightmaster`, `taxi`, `land`), hearth binds,
-- trainers' services and vendors' items, item and quest-spell casts
-- (`cast`), and eating/drinking (`rest`).

local ADDON, ns = ...

local type, GetTime, tonumber, ipairs, pairs, floor, concat = type, GetTime, tonumber, ipairs, pairs, math.floor, table.concat
local usable, Num, Str = ns.Usable, ns.Num, ns.Str

local function call(fn, ...)
	if type(fn) ~= "function" then return nil end
	local ok, v = pcall(fn, ...)
	if ok and usable(v) then return v end
	return nil
end

---------------------------------------------------------------------------
-- Breadcrumbs and rides: a 1 s ticker reads the player's position. A point
-- is recorded while the player moves (or rides) far enough from the last.
---------------------------------------------------------------------------

local POS_TICK = 1 -- seconds between movement checks
local POS_MIN_YARDS = 25 -- record after moving this far ...
local POS_MIN_GAP = 2 -- ... but not more often than this (seconds)
local POS_SLOW_YARDS = 4 -- or after moving this far ...
local POS_SLOW_GAP = 20 -- ... once this long has passed since the last point
local RIDE_MIN_YARDS = 2 -- moved this far in one tick with no speed of one's own: a ride
local RIDE_STILL_YARDS = 0.5 -- a tick moving less than this is still ...
local RIDE_STILL_TICKS = 5 -- ... and this many still ticks end the ride

-- pos flags
ns.POS_MOUNTED, ns.POS_SWIMMING, ns.POS_INDOORS, ns.POS_FLYING, ns.POS_FALLING, ns.POS_DEAD, ns.POS_TRAIL = 1, 2, 4, 8, 16, 32, 64

-- The `pos` flags of the player now (without the trail bit).
function ns.PosFlags()
	local f = 0
	if call(IsMounted) then f = f + 1 end
	if call(IsSwimming) then f = f + 2 end
	if call(IsIndoors) then f = f + 4 end
	if call(IsFlying) then f = f + 8 end
	if call(IsFalling) then f = f + 16 end
	if call(UnitIsDeadOrGhost, "player") then f = f + 32 end
	return f
end

-- The player's own speed (yards/s), nil when unreadable.
local function ownSpeed()
	local v = call(GetUnitSpeed, "player")
	return type(v) == "number" and v or nil
end

-- The `pos` speed field: yards/s x 10.
function ns.SpeedField()
	local v = ownSpeed()
	return v and floor(v * 10 + 0.5) or nil
end

-- The last `pos` written: { map, x, y, at }.
ns.lastPos = { map = nil, x = nil, y = nil, at = -math.huge }

-- Writes a `pos` record for (map, x, y) with extra flag bits.
function ns.RecPos(map, x, y, extra)
	if not ns.Rec("pos", ns.PAt(map, x, y), ns.PosFlags() + (extra or 0), ns.SpeedField()) then return false end
	local last = ns.lastPos
	last.map, last.x, last.y, last.at = map, x, y, GetTime()
	return true
end

local function onTaxi() return call(UnitOnTaxi, "player") and true or false end

local function isMoving()
	if IsPlayerMoving then return IsPlayerMoving() and true or false end
	return (ownSpeed() or 0) > 0
end

local ride = { on = false, still = 0, map = nil, x = nil, y = nil }

local function breadcrumb(map, x, y)
	if not x then
		map, x, y = ns.Position()
		if not x then return end
	end
	local last = ns.lastPos
	if last.map == map and last.x then
		local d = ns.Yards(map, x - last.x, y - last.y)
		local dt = GetTime() - last.at
		if not ((d >= POS_MIN_YARDS and dt >= POS_MIN_GAP) or (d >= POS_SLOW_YARDS and dt >= POS_SLOW_GAP)) then return end
	end
	ns.RecPos(map, x, y)
end

local land -- forward: flight landing check

local function tick()
	if not ns.Recording() then return end
	if land() or onTaxi() then
		ride.map, ride.moving = nil, 0
		return
	end
	local map, x, y = ns.Position()
	if not x then
		ride.map = nil
		return
	end
	-- Rides: the position moves while the player's own speed is 0, two ticks
	-- running (a teleport, a charge or a knockback moves once).
	local moved
	local pmap, px, py = ride.map, ride.x, ride.y
	if pmap == map and px then moved = ns.Yards(map, x - px, y - py) end
	ride.map, ride.x, ride.y = map, x, y
	local speed = ownSpeed()
	if moved then
		if not ride.on then
			if moved >= RIDE_MIN_YARDS and speed == 0 and not call(IsFalling) then
				ride.moving = (ride.moving or 0) + 1
				if ride.moving == 1 then ride.fromMap, ride.fromX, ride.fromY = pmap, px, py end
				if ride.moving >= 2 then
					ride.on, ride.still, ride.moving = true, 0, 0
					ns.Rec("ride", true, ns.PAt(ride.fromMap, ride.fromX, ride.fromY))
				end
			else
				ride.moving = 0
			end
		elseif moved < RIDE_STILL_YARDS then
			ride.still = ride.still + 1
			if ride.still >= RIDE_STILL_TICKS then
				ride.on = false
				ns.Rec("ride", false, ns.PAt(map, x, y))
			end
		else
			ride.still = 0
		end
	else
		ride.moving = 0
	end
	if ride.on or isMoving() then breadcrumb(map, x, y) end
end

C_Timer.NewTicker(POS_TICK, tick)

-- The point where the player stops is worth keeping when it is far enough.
ns.On("PLAYER_STOPPED_MOVING", function()
	if ns.Recording() and not onTaxi() then breadcrumb() end
end)

---------------------------------------------------------------------------
-- Zone, level, XP
---------------------------------------------------------------------------

local XP_EVERY = 300 -- seconds between `xp` records

local lastZoneMap, lastZone

local function checkZone()
	if not ns.Recording() then return end
	local map = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")
	local zone = Str(GetRealZoneText and GetRealZoneText()) or Str(GetZoneText and GetZoneText())
	if map == lastZoneMap and zone == lastZone then return end
	lastZoneMap, lastZone = map, zone
	ns.Rec("zone", ns.P(), zone, Str(GetSubZoneText and GetSubZoneText()))
end
ns.On("ZONE_CHANGED_NEW_AREA", checkZone)
ns.On("ZONE_CHANGED", checkZone)
ns.On("ZONE_CHANGED_INDOORS", checkZone)
ns.On("PLAYER_ENTERING_WORLD", checkZone)

local function recordXP()
	local xp, max = Num(UnitXP and UnitXP("player")), Num(UnitXPMax and UnitXPMax("player"))
	if not (xp and max) then return end
	ns.Rec("xp", xp, max, Num(GetXPExhaustion and GetXPExhaustion()))
end

local xpTicker
local played -- { total, at }: the last /played answer the client gave

ns.On("TIME_PLAYED_MSG", function(_, total)
	if Num(total) then played = { total = total, at = GetTime() } end
end)

ns.On("PLAYER_LEVEL_UP", function(_, level)
	local secs = played and floor(played.total + GetTime() - played.at) or nil
	ns.Rec("level", Num(level), ns.P(), secs)
	-- UnitXP still has the old level's value now; read it a moment later.
	C_Timer.After(1, recordXP)
end)

---------------------------------------------------------------------------
-- Deaths: the killer is the last hostile creature that targeted the player
-- within KILLER_WINDOW seconds (UNIT_TARGET of plates, target, mouseover).
---------------------------------------------------------------------------

local KILLER_WINDOW = 10
local hostile = { npc = nil, level = nil, at = -math.huge }

local function checkAttacker(unit)
	if not (Str(unit) and call(UnitExists, unit)) then return end
	if not call(UnitIsUnit, unit .. "target", "player") then return end
	if not call(UnitCanAttack, "player", unit) then return end
	local kind, npc = ns.ParseGUID(UnitGUID(unit))
	if not (npc and (kind == "Creature" or kind == "Vehicle")) then return end
	hostile.npc, hostile.level, hostile.at = npc, Num(UnitLevel(unit)), GetTime()
end

ns.On("UNIT_TARGET", function(_, unit) checkAttacker(unit) end)
ns.On("NAME_PLATE_UNIT_ADDED", function(_, unit) checkAttacker(unit) end)
ns.On("PLAYER_TARGET_CHANGED", function() checkAttacker("target") end)

ns.On("PLAYER_DEAD", function()
	local h = GetTime() - hostile.at <= KILLER_WINDOW and hostile or nil
	ns.Rec("death", ns.P(), h and h.npc, h and h.level)
end)

---------------------------------------------------------------------------
-- Flight masters and flights
---------------------------------------------------------------------------

local FP_CURRENT = (Enum and Enum.FlightPathState and Enum.FlightPathState.Current) or 0
local FP_REACHABLE = (Enum and Enum.FlightPathState and Enum.FlightPathState.Reachable) or 1
local MAP_CONTINENT = (Enum and Enum.UIMapType and Enum.UIMapType.Continent) or 2

-- The continent the player is on (the flight map's map), else the zone.
local function taxiMap()
	local map = C_Map and C_Map.GetBestMapForUnit and C_Map.GetBestMapForUnit("player")
	if not Num(map) then return nil end
	local m, guard = map, 0
	while m and guard < 8 do
		local info = C_Map.GetMapInfo and C_Map.GetMapInfo(m)
		if not info then break end
		if info.mapType == MAP_CONTINENT then return m end
		m, guard = info.parentMapID, guard + 1
	end
	return map
end

local function taxiNodes()
	local map = taxiMap()
	if map and C_TaxiMap and C_TaxiMap.GetAllTaxiNodes then
		local ok, nodes = pcall(C_TaxiMap.GetAllTaxiNodes, map)
		if ok and type(nodes) == "table" then return nodes end
	end
	return nil
end

local taxiFrom -- node id where the taxi map was opened
local fmSeen = {} -- node ids recorded this session

ns.On("TAXIMAP_OPENED", function()
	taxiFrom = nil
	local nodes = taxiNodes()
	if not nodes then return end
	local known = {}
	for _, n in ipairs(nodes) do
		if n.state == FP_CURRENT then taxiFrom = Num(n.nodeID) end
		if (n.state == FP_CURRENT or n.state == FP_REACHABLE) and Num(n.nodeID) then known[#known + 1] = n.nodeID end
	end
	if not taxiFrom or fmSeen[taxiFrom] or not ns.Recording() then return end
	table.sort(known)
	local _, npc = ns.Ref("npc")
	if ns.Rec("flightmaster", npc, ns.P(), taxiFrom, ns.Ids(known)) then fmSeen[taxiFrom] = true end
end)

-- TakeTaxiNode only requests the flight (the server may refuse it: not
-- enough money, in combat). The flight is recorded once the player is
-- actually on the taxi.
local TAXI_CONFIRM = { 0.5, 1.5, 3, 6 } -- seconds after the request to check UnitOnTaxi
local pendingTaxi -- { from, to, at }
local flight -- { to, at }: on the taxi now

local function confirmTaxi()
	local p = pendingTaxi
	if not p then return end
	if onTaxi() then
		pendingTaxi = nil
		flight = { to = p.to, at = GetTime() }
		ns.Rec("taxi", p.from, p.to)
	elseif GetTime() - p.at >= TAXI_CONFIRM[#TAXI_CONFIRM] - 1e-6 then
		pendingTaxi = nil
	end
end

local function onTakeTaxi(slot)
	local to
	for _, n in ipairs(taxiNodes() or {}) do
		if n.slotIndex == slot then to = Num(n.nodeID) end
	end
	pendingTaxi = { from = taxiFrom, to = to, at = GetTime() }
	for _, delay in ipairs(TAXI_CONFIRM) do C_Timer.After(delay, confirmTaxi) end
end
if type(TakeTaxiNode) == "function" then hooksecurefunc("TakeTaxiNode", onTakeTaxi) end
ns.On("PLAYER_CONTROL_LOST", confirmTaxi)

-- Returns true while flying; writes `land` once the flight is over.
land = function()
	local f = flight
	if not f then return false end
	if onTaxi() then return true end
	flight = nil
	ns.Rec("land", f.to, floor(GetTime() - f.at + 0.5), ns.P())
	return false
end
ns.On("PLAYER_CONTROL_GAINED", function() C_Timer.After(0.2, land) end)

---------------------------------------------------------------------------
-- Hearth, trainers, vendors
---------------------------------------------------------------------------

ns.On("HEARTHSTONE_BOUND", function()
	local _, npc = ns.Ref("npc")
	ns.Rec("bind", npc, ns.P())
end)

local trainersSeen, vendorsSeen = {}, {}
local TRAINER_STATE = { available = "a", unavailable = "u", used = "k" }
local TRAINER_FILTERS = { "available", "unavailable", "used" }

-- The trainer's spell for a service: the tooltip data's id.
local function serviceSpell(i)
	local T = C_TooltipInfo
	if not (T and T.GetTrainerService) then return nil end
	local ok, data = pcall(T.GetTrainerService, i)
	if ok and type(data) == "table" then return Num(data.id) end
	return nil
end

-- `spellId:cost:reqLevel:state` per service (`0:...:name` without a spell
-- id), every filter shown while it reads, the player's filters put back.
local function trainerServices()
	if not (GetNumTrainerServices and GetTrainerServiceInfo) then return nil end
	local restore
	if GetTrainerServiceTypeFilter and SetTrainerServiceTypeFilter then
		restore = {}
		for _, f in ipairs(TRAINER_FILTERS) do
			local on = GetTrainerServiceTypeFilter(f) and true or false
			restore[f] = on
			if not on then SetTrainerServiceTypeFilter(f, true) end
		end
	end
	local out = {}
	local ok, err = pcall(function()
		for i = 1, GetNumTrainerServices() or 0 do
			local name, kind, _, reqLevel = GetTrainerServiceInfo(i)
			local state = TRAINER_STATE[kind]
			if state then
				local cost = Num(GetTrainerServiceCost and GetTrainerServiceCost(i)) or 0
				local spell = serviceSpell(i)
				local item = ("%d:%d:%d:%s"):format(spell or 0, cost, Num(reqLevel) or 0, state)
				if not spell then item = item .. ":" .. ns.ListText(name) end
				out[#out + 1] = item
			end
		end
	end)
	if restore then
		for f, on in pairs(restore) do
			if not on then SetTrainerServiceTypeFilter(f, false) end
		end
	end
	if not ok then geterrorhandler()(err) end
	return #out > 0 and concat(out, ";") or nil
end

ns.On("TRAINER_SHOW", function()
	if not ns.Recording() then return end
	local _, npc = ns.Ref("npc")
	if npc and trainersSeen[npc] then return end
	if ns.Rec("trainer", npc, ns.P(), trainerServices()) and npc then trainersSeen[npc] = true end
end)

-- `itemId:price:stack:qty` per item (qty -1 = unlimited).
local function vendorItems()
	if not (GetMerchantNumItems and GetMerchantItemID) then return nil, 0 end
	local n = GetMerchantNumItems() or 0
	local out = {}
	for i = 1, n do
		local id = Num(GetMerchantItemID(i))
		if id then
			local price, stack, qty
			if C_MerchantFrame and C_MerchantFrame.GetItemInfo then
				local ok, info = pcall(C_MerchantFrame.GetItemInfo, i)
				if ok and type(info) == "table" then price, stack, qty = info.price, info.stackCount, info.numAvailable end
			elseif GetMerchantItemInfo then
				local _, _, p, s, q = GetMerchantItemInfo(i)
				price, stack, qty = p, s, q
			end
			out[#out + 1] = ("%d:%d:%d:%d"):format(id, Num(price) or 0, Num(stack) or 1, Num(qty) or -1)
		end
	end
	return #out > 0 and concat(out, ";") or nil, n
end

local vendorWaiting -- the npc whose items had not arrived at MERCHANT_SHOW

local function recordVendor(npc)
	local items, n = vendorItems()
	if n == 0 then
		vendorWaiting = npc or false
		return
	end
	vendorWaiting = nil
	if ns.Rec("vendor", npc, ns.P(), items) and npc then vendorsSeen[npc] = true end
end

ns.On("MERCHANT_SHOW", function()
	if not ns.Recording() then return end
	local _, npc = ns.Ref("npc")
	if npc and vendorsSeen[npc] then return end
	recordVendor(npc)
end)
ns.On("MERCHANT_UPDATE", function()
	if vendorWaiting ~= nil and ns.Recording() then recordVendor(vendorWaiting or nil) end
end)
ns.On("MERCHANT_CLOSED", function() vendorWaiting = nil end)

---------------------------------------------------------------------------
-- Casts: an item used (bags, action bars, the quest log's item button), or
-- a spell out of combat that is not in the spellbook (quest spells,
-- summons); never spellbook or mount spells, never crafts (Progress.lua).
---------------------------------------------------------------------------

local ITEM_WINDOW = 1.5 -- seconds between an item use and its cast
local usedItem, usedAt = nil, -math.huge

local function useItem(id)
	id = Num(id)
	if id then usedItem, usedAt = id, GetTime() end
end

if C_Container and type(C_Container.UseContainerItem) == "function" then
	hooksecurefunc(C_Container, "UseContainerItem", function(bag, slot)
		useItem(C_Container.GetContainerItemID and C_Container.GetContainerItemID(bag, slot))
	end)
end
if type(UseAction) == "function" then
	hooksecurefunc("UseAction", function(slot)
		if not GetActionInfo then return end
		local kind, id = GetActionInfo(slot)
		if kind == "item" then useItem(id) end
	end)
end
if type(UseQuestLogSpecialItem) == "function" then
	hooksecurefunc("UseQuestLogSpecialItem", function(index)
		local link = GetQuestLogSpecialItemInfo and GetQuestLogSpecialItemInfo(index)
		if Str(link) then useItem(tonumber(link:match("item:(%d+)"))) end
	end)
end

local function inSpellbook(spell)
	local B = C_SpellBook
	if B and B.IsSpellInSpellBook then
		local ok, v = pcall(B.IsSpellInSpellBook, spell)
		if ok and v then return true end
	end
	if B and B.IsSpellKnown then
		local ok, v = pcall(B.IsSpellKnown, spell)
		if ok and v then return true end
	end
	return false
end

local function isMount(spell)
	local M = C_MountJournal
	if not (M and M.GetMountFromSpell) then return false end
	local ok, v = pcall(M.GetMountFromSpell, spell)
	return ok and v ~= nil
end

local function inCombat()
	local v = call(UnitAffectingCombat, "player")
	return v and true or false
end

ns.On("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spell)
	if unit ~= "player" or not ns.Recording() then return end
	spell = Num(spell)
	if not spell then return end
	local item = GetTime() - usedAt <= ITEM_WINDOW and usedItem or nil
	if item then
		usedItem = nil
	elseif inCombat() or (ns.IsRecipeSpell and ns.IsRecipeSpell(spell)) or (ns.IsGatherSpell and ns.IsGatherSpell(spell))
		or inSpellbook(spell) or isMount(spell) then
		return
	end
	local tk, tid = ns.Ref("target")
	ns.Rec("cast", spell, item, ns.P(), tk, tid)
end)

---------------------------------------------------------------------------
-- Eating and drinking: a Food / Drink aura, recorded when it ends
---------------------------------------------------------------------------

local FOOD_SPELL, DRINK_SPELL = 433, 430 -- "Food" and "Drink" (their names in the client's language)
local foodName, drinkName
local resting = {} -- auraInstanceID -> { kind, at }

local function restKind(name)
	if not Str(name) then return nil end
	if foodName == nil then
		foodName = ns.SpellName(FOOD_SPELL) or false
		drinkName = ns.SpellName(DRINK_SPELL) or false
	end
	local food = foodName and (name == foodName or name:find(foodName, 1, true))
	local drink = drinkName and (name == drinkName or name:find(drinkName, 1, true))
	if food and drink then return "b" end
	if name == foodName then return "f" end
	if name == drinkName then return "d" end
	return nil
end

local function endRest(id)
	local r = resting[id]
	resting[id] = nil
	if r then ns.Rec("rest", r.kind, floor(GetTime() - r.at + 0.5)) end
end

ns.On("UNIT_AURA", function(_, unit, info)
	if unit ~= "player" or not ns.Recording() then return end
	if type(info) ~= "table" or info.isFullUpdate then
		-- a full update: rescan and end the auras no longer there
		local present = {}
		if C_UnitAuras and C_UnitAuras.GetAuraDataByIndex then
			for i = 1, 40 do
				local a = C_UnitAuras.GetAuraDataByIndex("player", i, "HELPFUL")
				if not a then break end
				local id = Num(a.auraInstanceID)
				if id then
					present[id] = true
					local kind = not resting[id] and restKind(a.name)
					if kind then resting[id] = { kind = kind, at = GetTime() } end
				end
			end
		end
		for id in pairs(resting) do
			if not present[id] then endRest(id) end
		end
		return
	end
	if type(info.addedAuras) == "table" then
		for _, a in ipairs(info.addedAuras) do
			local id = Num(a.auraInstanceID)
			local kind = id and restKind(a.name)
			if kind then resting[id] = { kind = kind, at = GetTime() } end
		end
	end
	if type(info.removedAuraInstanceIDs) == "table" and next(resting) then
		for _, id in ipairs(info.removedAuraInstanceIDs) do
			if resting[id] then endRest(id) end
		end
	end
end)

---------------------------------------------------------------------------
-- Session start
---------------------------------------------------------------------------

ns.OnSession(function()
	lastZoneMap, lastZone = nil, nil
	ns.lastPos.map, ns.lastPos.x, ns.lastPos.y, ns.lastPos.at = nil, nil, nil, -math.huge
	ride.on, ride.still, ride.map = false, 0, nil
	fmSeen, trainersSeen, vendorsSeen = {}, {}, {}
	resting = {}
	flight = onTaxi() and flight or nil
	checkZone()
	recordXP()
	if xpTicker then xpTicker:Cancel() end
	xpTicker = C_Timer.NewTicker(XP_EVERY, recordXP)
end)
