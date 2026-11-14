-- Town services from Polestar's bundled, load-on-demand Codex.
local ADDON, ns = ...
local Maps = ns.Maps
-- Inns and flight masters are the travel layers' (Maps/Services.lua).
local ROLES = { "vendor", "repair", "banker", "auctioneer",
	"battlemaster", "spirithealer", "stablemaster", "transmogrifier", "trainer", "weapon" }

-- The layer keeps its records for filter changes: only friendly ones, and only
-- the fields it draws (a decoded Codex record carries loot, levels and flags
-- too: holding every decoded service record took about twice the memory).
local function friendly(faction)
	local info = ns.Compat and ns.Compat.GetPlayerInfo and ns.Compat.GetPlayerInfo() or {}
	local side = info.faction == "Alliance" and "A" or info.faction == "Horde" and "H" or nil
	return faction == "AH" or side == nil or faction == side
end

local function slim(rec, kind, roles)
	return { id = rec.id, kind = kind, name = rec.name, subName = rec.subName, faction = rec.faction,
		roles = roles or rec.roles, spawns = rec.spawns }
end

function Maps.ServiceSource()
	local X = ns.Codex
	if not (X and X.IsLoaded and X.WithRole and X.Npc) then return nil, "missing" end
	if not X.IsLoaded() then
		if InCombatLockdown and InCombatLockdown() then return nil, "combat" end
		if not X.Load then return nil, "missing" end
		local ok, why = X.Load()
		if not ok then return nil, why end
	end
	local ids, seen = {}, {}
	for _, role in ipairs(ROLES) do
		for _, id in ipairs(X.WithRole(role)) do
			if not seen[id] then ids[#ids + 1], seen[id] = id, true end
		end
	end
	table.sort(ids)
	return { ids = ids, read = function(id)
		local npc = X.Npc(id)
		if not npc or not npc.faction or (npc.instance and npc.instance ~= "") or not friendly(npc.faction) then return nil end
		return slim(npc)
	end }
end

function Maps.ServiceMailboxSource()
	local X = ns.Codex
	if not (X and X.Each and X.Object) then return nil end
	local ids = {}
	X.Each("object", function(id) ids[#ids + 1] = id end)
	table.sort(ids)
	return { ids = ids, read = function(id)
		local object = X.Object(id)
		if not object or not object.mailbox or not object.faction or not friendly(object.faction) then return nil end
		return slim(object, "object", { "mailbox" })
	end }
end
