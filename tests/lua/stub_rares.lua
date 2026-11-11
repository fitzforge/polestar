-- Units and vignettes for Rares tests (after wow_stub.lua and stub_world.lua).
--
--   local R = stub.rares
--   R.unit("nameplate1", { npc = 61, name = "Thuros Lightfingers", level = 11, class = "rare" })
--     -- options: guid (instead of npc), dead, player, controlled, secret (UnitGUID returns a secret),
--     --   surname (UnitName's second return, as Forever gives a player's), faction (UnitFactionGroup)
--   R.me = { "Fitz", "Polestar" }  -- UnitName("player") on a Forever client: first name, surname
--   R.clear("nameplate1")
--   R.vignette("Vignette-1", { npc = 61 | object = 2843, name, dead, onMinimap = true, map, x, y })
--   R.vignetteGone("Vignette-1")
-- issecretvalue(v) is true for values made by R.secretValue().

local R = { units = {}, vignettes = {}, order = {} }
stub.rares = R

local SECRET = {}
function R.secretValue() return setmetatable({}, SECRET) end
function issecretvalue(v) return type(v) == "table" and getmetatable(v) == SECRET end

local function guidOf(o)
	if o.guid then return o.guid end
	if o.npc then return "Creature-0-1-0-1-" .. o.npc .. "-0000ABC" .. o.npc end
	if o.object then return "GameObject-0-1-0-1-" .. o.object .. "-0000DEF" .. o.object end
	return nil
end

function R.unit(token, o)
	o.guid = guidOf(o)
	R.units[token] = o
end

function R.clear(token) R.units[token] = nil end

local prevGUID, prevName, prevLevel = UnitGUID, UnitName, UnitLevel

function UnitExists(unit)
	if unit == "player" then return true end
	return R.units[unit] ~= nil
end

function UnitGUID(unit)
	local u = R.units[unit]
	if u then
		if u.secret then return R.secretValue() end
		return u.guid
	end
	return prevGUID and prevGUID(unit)
end

function UnitName(unit)
	if unit == "player" and R.me then return R.me[1], R.me[2] end
	local u = R.units[unit]
	if u then return u.name, u.surname end
	return prevName and prevName(unit)
end

local prevFaction = UnitFactionGroup
function UnitFactionGroup(unit)
	local u = R.units[unit]
	if u and u.faction then return u.faction, u.faction end
	return prevFaction and prevFaction(unit)
end

-- The same unit: the same token, or both known with one GUID.
function UnitIsUnit(a, b)
	if a == b then return true end
	local ga, gb = UnitGUID(a), UnitGUID(b)
	return ga ~= nil and ga == gb
end

function UnitLevel(unit)
	local u = R.units[unit]
	if u then return u.level or 0 end
	return prevLevel and prevLevel(unit) or 0
end

function UnitClassification(unit)
	local u = R.units[unit]
	return u and u.class or "normal"
end

function UnitIsPlayer(unit)
	if unit == "player" then return true end
	local u = R.units[unit]
	return u and u.player or false
end

function UnitPlayerControlled(unit)
	local u = R.units[unit]
	return u and u.controlled or false
end

function UnitIsDead(unit)
	local u = R.units[unit]
	return u and u.dead or false
end

C_VignetteInfo = {}

function R.vignette(vguid, o)
	if not R.vignettes[vguid] then R.order[#R.order + 1] = vguid end
	o.objectGUID = guidOf(o)
	if o.onMinimap == nil then o.onMinimap = true end
	R.vignettes[vguid] = o
end

function R.vignetteGone(vguid)
	R.vignettes[vguid] = nil
	for i = #R.order, 1, -1 do if R.order[i] == vguid then table.remove(R.order, i) end end
end

function C_VignetteInfo.GetVignettes()
	local out = {}
	for i, g in ipairs(R.order) do out[i] = g end
	return out
end

function C_VignetteInfo.GetVignetteInfo(vguid)
	local v = R.vignettes[vguid]
	if not v then return nil end
	return {
		vignetteGUID = vguid, objectGUID = v.objectGUID, name = v.name, isDead = v.dead or false,
		onWorldMap = true, onMinimap = v.onMinimap, isUnique = false, inFogOfWar = false,
		atlasName = "VignetteKill", hasTooltip = true, vignetteID = 1, zoneInfiniteAOI = false,
	}
end

function C_VignetteInfo.GetVignettePosition(vguid, map)
	local v = R.vignettes[vguid]
	if not v or not v.map or v.map ~= map then return nil end
	return CreateVector2D(v.x / 100, v.y / 100)
end
