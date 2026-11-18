-- The floor an NPC beside the player tells (BV Addon Suite - Routing's idea: an NPC's spawn height says which floor
-- the player stands on, so the walk never starts underground). Forever's client gives no player height, and in the
-- capitals the walking floor (Nav/Walk.lua) often has none: after a loading screen, or where a street's cells hold
-- the ground under it, a bridge or the mountain over it. The NPC the player last talked to (a gossip, quest, vendor,
-- trainer, flight master, bank or innkeeper window: its spawns within TALK yards of the player, who stood within
-- interact range of it), else the one targeted, else the newest one moused over or whose nameplate appeared (spawns
-- within REACH yards), within SECONDS, gives its spawn's height (the Codex's spawns, read only once it is loaded:
-- nothing here loads it). An NPC with spawns on more than one level there (more than LEVEL yards apart in height)
-- tells nothing: an Undercity Guardian at the bank also stands on the Ruins 98 yd over it, 24 yd away. Walk.lua takes the read surface nearest that height (or the
-- trail floor on that level) inside the capitals; outside them only the NPC talked to (NpcFloor.Talked), whose window
-- puts the player within interact range of it (a mob's nameplate on the cliff over a camp says nothing there).
--
--   NpcFloor.Near(c, x, y) -> z | nil: that height for the player at world (x, y) on continent c
--   NpcFloor.Talked(c, x, y) -> z, at | nil: the same from the NPC whose window the player opened only, and when
--     (GetTime: Nav/Walk.lua corrects a followed floor once per window, as it opens)
--
-- The events only note the NPC's id and the time (allocation-light: a nameplate shows for every unit in a city);
-- the Codex is read when a floor is asked for, and each NPC's spawns' world points are kept (WORLD_KEEP NPCs).

local ADDON, ns = ...
local Nav = ns.Nav

local type, tonumber, ipairs, huge = type, tonumber, ipairs, math.huge

local NpcFloor = {}
Nav.npcFloor = NpcFloor

local SECONDS = 15    -- a sighting this old still tells the floor
local REACH = 30      -- yards between the player and the NPC's spawn
local TALK = 10       -- the same, for an NPC whose window the player opened
local LEVEL = 10      -- Routing/PathGrid.lua's ZTOL: spawns this close in height stand on one level
local RING = 8        -- nameplates kept
local WORLD_KEEP = 64 -- NPCs whose spawns' world points are kept
NpcFloor.SECONDS, NpcFloor.REACH, NpcFloor.TALK = SECONDS, REACH, TALK

local talkId, talkAt = nil, -huge          -- talked to (its window opened)
local aimId, aimAt = nil, -huge            -- targeted
local ringId, ringAt, head = {}, {}, 0      -- nameplates, newest at head
local worlds, worldsN = {}, 0               -- [npc id] = { c, wx, wy, z, ... } | false (no spawn with a height)

-- A creature's NPC id (objects, players and pets: nil).
local function creature(unit)
	local guid = UnitGUID and UnitGUID(unit)
	if type(guid) ~= "string" or (issecretvalue and issecretvalue(guid)) then return nil end
	local kind, _, _, _, _, id = strsplit("-", guid)
	if kind ~= "Creature" then return nil end
	return tonumber(id)
end

local function talked(unit)
	local id = creature(unit)
	if id then talkId, talkAt = id, GetTime() end
end

local function targeted(unit)
	local id = creature(unit)
	if id then aimId, aimAt = id, GetTime() end
end

local function plate(unit)
	local id = creature(unit)
	if not id then return end
	local now = GetTime()
	for i = 1, RING do
		if ringId[i] == id then
			ringAt[i] = now
			return
		end
	end
	head = head % RING + 1
	ringId[head], ringAt[head] = id, now
end

-- The NPC's spawns with a height as world points (flat: c, wx, wy, z, ...), false when it has none, nil while the
-- Codex is not loaded.
local function spawnsOf(id)
	local w = worlds[id]
	if w ~= nil then return w end
	local X, C = ns.Codex, ns.Compat
	if not (X and X.IsLoaded and X.IsLoaded() and C and C.MapToWorld) then return nil end
	local rec = X.Npc(id)
	w = false
	if rec and type(rec.spawns) == "table" then
		local list, n = {}, 0
		for _, s in ipairs(rec.spawns) do
			if type(s) == "table" and type(s.z) == "number" and s.map and s.x and s.y then
				local c, wx, wy = C.MapToWorld(s.map, s.x, s.y, s.f == "e" and "e" or nil)
				if c then
					list[n + 1], list[n + 2], list[n + 3], list[n + 4] = c, wx, wy, s.z
					n = n + 4
				end
			end
		end
		if n > 0 then w = list end
	end
	if worldsN >= WORLD_KEEP then worlds, worldsN = {}, 0 end
	worlds[id], worldsN = w, worldsN + 1
	return w
end

-- The height of NPC id's spawn nearest (x, y) on c within reach yards, nil when none is or its spawns there stand
-- on more than one level.
local function levelOf(id, c, x, y, reach)
	local w = spawnsOf(id)
	if not w then return nil end
	local lo, hi, best, bestD = huge, -huge, nil, huge
	for i = 1, #w, 4 do
		if w[i] == c then
			local dx, dy = w[i + 1] - x, w[i + 2] - y
			local d = dx * dx + dy * dy
			if d <= reach * reach then
				local z = w[i + 3]
				if z < lo then lo = z end
				if z > hi then hi = z end
				if d < bestD then best, bestD = z, d end
			end
		end
	end
	if best == nil or hi - lo > LEVEL then return nil end
	return best
end

function NpcFloor.Near(c, x, y)
	if not (c and x and y) then return nil end
	local now = GetTime()
	if talkId and now - talkAt <= SECONDS then
		local z = levelOf(talkId, c, x, y, TALK)
		if z then return z end
	end
	if aimId and now - aimAt <= SECONDS then
		local z = levelOf(aimId, c, x, y, REACH)
		if z then return z end
	end
	local bestAt, bestZ = -huge, nil
	for i = 1, RING do
		local id, at = ringId[i], ringAt[i]
		if id and now - at <= SECONDS and at > bestAt then
			local z = levelOf(id, c, x, y, REACH)
			if z then bestAt, bestZ = at, z end
		end
	end
	return bestZ
end

function NpcFloor.Talked(c, x, y)
	if not (c and x and y and talkId) or GetTime() - talkAt > SECONDS then return nil end
	local z = levelOf(talkId, c, x, y, TALK)
	if z == nil then return nil end
	return z, talkAt
end

-- Forget every sighting (a loading screen: the NPCs seen are elsewhere now).
function NpcFloor.Clear()
	talkId, talkAt, aimId, aimAt = nil, -huge, nil, -huge
	for i = 1, RING do ringId[i], ringAt[i] = nil, nil end
	head = 0
end

ns.RegisterEvent("PLAYER_TARGET_CHANGED", function() targeted("target") end)
ns.RegisterEvent("UPDATE_MOUSEOVER_UNIT", function() plate("mouseover") end)
ns.RegisterEvent("NAME_PLATE_UNIT_ADDED", function(_, unit) plate(unit) end)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function() NpcFloor.Clear() end)
for _, event in ipairs({ "GOSSIP_SHOW", "QUEST_GREETING", "QUEST_DETAIL", "QUEST_PROGRESS", "QUEST_COMPLETE",
	"MERCHANT_SHOW", "TRAINER_SHOW", "TAXIMAP_OPENED", "BANKFRAME_OPENED", "CONFIRM_BINDER" }) do
	ns.RegisterEvent(event, function() talked("npc") end)
end
