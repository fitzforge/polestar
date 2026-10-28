-- Rares detection: what the Forever client tells an addon about rares and
-- treasures near the player, fed to Rares.Sighting. Every API below is
-- verified against .ref/wow-ui-source-forever (1.60.1.70338):
--   * Vignettes (VignetteInfoDocumentation.lua): VIGNETTE_MINIMAP_UPDATED
--     (vignetteGUID, onMinimap), VIGNETTES_UPDATED, C_VignetteInfo.GetVignettes,
--     GetVignetteInfo (objectGUID, name, isDead, onMinimap) and
--     GetVignettePosition(vignetteGUID, uiMapID) -> Vector2D. Forever's world
--     map adds VignetteDataProvider (Blizzard_WorldMap.lua), so the system is
--     live; a creature behind a vignette is a rare, a game object a treasure.
--   * Nameplates (NamePlateManagerDocumentation.lua): NAME_PLATE_UNIT_ADDED
--     (unitToken), with UnitClassification "rare" | "rareelite"
--     (UnitDocumentation.lua).
--   * Target and mouseover: PLAYER_TARGET_CHANGED, UPDATE_MOUSEOVER_UNIT.
--   * Unit reads may be secret values (SecretWhenUnitIdentityRestricted on
--     UnitGUID, UnitName, UnitCreatureType): a secret reads as unknown and the
--     unit is passed over.
--
-- Cost: event payloads only. A unit is looked at once per GUID per few
-- seconds (DEBOUNCE); the full vignette scan runs at most every SCAN_EVERY
-- seconds and never in combat (it waits for PLAYER_REGEN_ENABLED). Nothing
-- here loads the Codex. Each path is its own setting; a path that is off has
-- no event registered.

local ADDON, ns = ...
local Rares = ns.Rares

local type, pcall, tonumber, pairs = type, pcall, tonumber, pairs

local D = {}
Rares.Detect = D

local DEBOUNCE = 3
local SCAN_EVERY = 2
local CLASS_RARE = { rare = true, rareelite = true }

local readable = ns.Compat.Readable

local function clock() return GetTime and GetTime() or 0 end

-- guid -> time last looked at
local recent, recentCount = {}, 0

local function fresh(guid)
	local now = clock()
	local t = recent[guid]
	if t and now - t < DEBOUNCE then return false end
	if not t then
		recentCount = recentCount + 1
		if recentCount > 200 then
			for g, at in pairs(recent) do
				if now - at >= DEBOUNCE then
					recent[g] = nil
					recentCount = recentCount - 1
				end
			end
		end
	end
	recent[guid] = now
	return true
end

-- "Creature-0-4372-0-17-61-0000123456" -> "Creature", 61
local function guidId(guid)
	if type(guid) ~= "string" then return nil end
	local kind, _, _, _, _, id = strsplit("-", guid)
	return kind, tonumber(id)
end
D.GuidId = guidId

---------------------------------------------------------------------------
-- Units: nameplates, target, mouseover
---------------------------------------------------------------------------

function D.Unit(unit, source)
	if not (UnitExists and readable(UnitExists(unit))) then return nil end
	local guid = readable(UnitGUID and UnitGUID(unit))
	if not guid then return nil end
	local kind, id = guidId(guid)
	if kind ~= "Creature" and kind ~= "Vehicle" then return nil end
	if not fresh(guid) then return nil end
	if readable(UnitIsPlayer(unit)) or readable(UnitPlayerControlled and UnitPlayerControlled(unit)) then return nil end
	local class = readable(UnitClassification and UnitClassification(unit))
	if not CLASS_RARE[class or ""] and not Rares.Known("rare", id) then return nil end
	local level = readable(UnitLevel(unit))
	return Rares.Sighting({
		source = source, kind = "rare", id = id, guid = guid,
		name = readable(UnitName(unit)), classification = class,
		level = type(level) == "number" and level or nil,
		dead = readable(UnitIsDead and UnitIsDead(unit)) and true or false,
	})
end

local function onNameplate(_, unit) D.Unit(unit, "nameplate") end
local function onTarget() D.Unit("target", "target") end
local function onMouseover() D.Unit("mouseover", "mouseover") end

---------------------------------------------------------------------------
-- Vignettes
---------------------------------------------------------------------------

local function positionOn(vguid, map)
	local ok, pos = pcall(C_VignetteInfo.GetVignettePosition, vguid, map)
	if not ok or not pos then return nil end
	local x, y
	if pos.GetXY then x, y = pos:GetXY() else x, y = pos.x, pos.y end
	if not (x and y) or (x == 0 and y == 0) then return nil end
	return { map = map, x = x * 100, y = y * 100 }
end

-- The vignette's position on the player's map, else on the first parent map
-- that has it (a subzone or cave map can lack it while the zone has it).
local function vignetteWhere(vguid)
	local V, M = C_VignetteInfo, C_Map
	if not (vguid and V and V.GetVignettePosition and M and M.GetBestMapForUnit) then return nil end
	local map = M.GetBestMapForUnit("player")
	for _ = 1, 4 do
		if not map or map == 0 then return nil end
		local where = positionOn(vguid, map)
		if where then return where end
		local info = M.GetMapInfo and M.GetMapInfo(map)
		map = info and info.parentMapID
	end
	return nil
end
D.VignetteWhere = vignetteWhere

function D.Vignette(vguid)
	local V = C_VignetteInfo
	if not (vguid and V and V.GetVignetteInfo) then return nil end
	local ok, info = pcall(V.GetVignetteInfo, vguid)
	if not ok or type(info) ~= "table" then return nil end
	local object = readable(info.objectGUID)
	local kind, id = guidId(object)
	local what
	if kind == "Creature" or kind == "Vehicle" then
		what = "rare"
	elseif kind == "GameObject" then
		what = "treasure"
	else
		return nil
	end
	if not fresh(vguid) then return nil end
	return Rares.Sighting({
		source = "vignette", kind = what, id = id, guid = object, vignette = vguid,
		name = readable(info.name), dead = readable(info.isDead) and true or false,
	}, vignetteWhere(vguid))
end

local function onVignette(_, vguid, onMinimap)
	if onMinimap then D.Vignette(vguid) end
end

local scanPending, scanQueued = false, false

function D.Scan()
	scanQueued = false
	if ns.Compat.InCombat() then
		scanPending = true
		return 0
	end
	scanPending = false
	local V = C_VignetteInfo
	if not (V and V.GetVignettes and V.GetVignetteInfo) then return 0 end
	local ok, list = pcall(V.GetVignettes)
	if not ok or type(list) ~= "table" then return 0 end
	local n = 0
	for i = 1, #list do
		local g = list[i]
		local got, info = pcall(V.GetVignetteInfo, g)
		if got and type(info) == "table" and readable(info.onMinimap) then
			n = n + 1
			D.Vignette(g)
		end
	end
	return n
end

local function queueScan()
	if scanQueued then return end
	scanQueued = true
	if C_Timer and C_Timer.After then ns.After(SCAN_EVERY, D.Scan) else D.Scan() end
end

local function onRegen()
	Rares.Release()
	if scanPending then queueScan() end
end

---------------------------------------------------------------------------
-- Wiring: one event set per enabled path
---------------------------------------------------------------------------

local PATHS = {
	{ key = "vignettes", events = { VIGNETTE_MINIMAP_UPDATED = onVignette, VIGNETTES_UPDATED = queueScan } },
	{ key = "nameplates", events = { NAME_PLATE_UNIT_ADDED = onNameplate } },
	{ key = "target", events = { PLAYER_TARGET_CHANGED = onTarget } },
	{ key = "mouseover", events = { UPDATE_MOUSEOVER_UNIT = onMouseover } },
}

local wired = {} -- path key -> true
local supported = {} -- path key -> bool (the client knows its events)

function D.Wire()
	local on = Rares.Get("enabled")
	for _, p in ipairs(PATHS) do
		local want = on and Rares.Get(p.key) and true or false
		if want and not wired[p.key] then
			local ok = true
			for ev, fn in pairs(p.events) do
				if not ns.RegisterEvent(ev, fn) then ok = false end
			end
			supported[p.key] = ok
			wired[p.key] = true
		elseif not want and wired[p.key] then
			for ev, fn in pairs(p.events) do ns.UnregisterEvent(ev, fn) end
			wired[p.key] = nil
		end
	end
	if on then
		ns.RegisterEvent("PLAYER_REGEN_ENABLED", onRegen)
		if wired.vignettes then queueScan() end
	else
		ns.UnregisterEvent("PLAYER_REGEN_ENABLED", onRegen)
	end
end

-- path key -> true (wired, its events known) | false (the client lacks them) | nil (off)
function D.Paths()
	local out = {}
	for _, p in ipairs(PATHS) do
		if wired[p.key] then out[p.key] = supported[p.key] ~= false end
	end
	return out
end

ns.On("SETTING_CHANGED", function(path)
	if not ns.IsLoggedIn() then return end
	if path == "" or path == "rares" or (type(path) == "string" and path:find("^rares%.")) then D.Wire() end
end)

ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	if wired.vignettes then queueScan() end
end)

ns.OnLogin(D.Wire)
