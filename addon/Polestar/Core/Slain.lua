-- Boss deaths for `boss` goals (guide format 10): a creature's death in the
-- combat log fires ns.Fire("SLAIN", npcId); the Engine latches the step in
-- play's boss goal for it as checked off (Own.latchBoss), so a reload keeps
-- it done. Contract: docs/ARCHITECTURE.md, "Core".
--
-- The combat log is read only while the step in play has a boss goal
-- (Slain.Watch, from the Engine's evaluation): it fires on every hit near
-- the player, and nothing else of Polestar needs it.
--
--   Slain.Watch(on)      -- read the combat log, or stop
--   Slain.Watching() -> bool

local ADDON, ns = ...

local type, tonumber = type, tonumber

local Slain = {}
ns.Slain = Slain

-- "Creature-0-<server>-<instance>-<zone>-<npcId>-<spawn>" -> npcId
local function npcIdFromGUID(guid)
	if type(guid) ~= "string" then return nil end
	local id = guid:match("^Creature%-0%-%d+%-%d+%-%d+%-(%d+)%-")
	return id and tonumber(id) or nil
end

local function onCombatLog()
	local _, subevent, _, _, _, _, _, destGUID = CombatLogGetCurrentEventInfo()
	if subevent ~= "UNIT_DIED" and subevent ~= "PARTY_KILL" then return end
	local npc = npcIdFromGUID(destGUID)
	if npc then ns.Fire("SLAIN", npc) end
end

local watching = false

function Slain.Watch(on)
	on = on and true or false
	if on == watching then return end
	watching = on
	if on then
		ns.RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED", onCombatLog)
	else
		ns.UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED", onCombatLog)
	end
end

function Slain.Watching() return watching end
