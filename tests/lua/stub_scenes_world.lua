-- What the release scenes (rust/crates/forge-addontest/tests/scenes) need on top of stub_world.lua and
-- stub_rares.lua: taking a flight and being on it, and a fight with a kill and its loot.
--
--   local S = stub.scenes
--   stub.world.taxi(npc, "Orgrimmar, Durotar", { "The Crossroads, The Barrens" })   -- the flight map (stub_world.lua)
--   TakeTaxiNode(2)                       the client call: the map closes, the player boards (PLAYER_CONTROL_LOST)
--   S.land()                              off the taxi (PLAYER_CONTROL_GAINED)
--   S.fight(npc, name, level, credit)     target a mob, enter combat, kill it (credit(): the quest progress the kill
--                                         gives, run between the death and leaving combat), leave combat, loot it
--   S.took, S.looted                      the slots TakeTaxiNode was called with; the loot slots taken

local world = stub.world
local S = { took = {}, guid = 0, loot = 0, looted = 0 }
stub.scenes = S

-- The client's flight map: TaxiFrame and a TaxiButton per node, shown while the map is open (Polestar marks the
-- route's node on it, QoL/Flight.lua; without it the route says "Route: fly to ..." in chat instead).
TaxiFrame = TaxiFrame or CreateFrame("Frame", "TaxiFrame", UIParent)
TaxiFrame:Hide()
local openTaxi = world.taxi
function world.taxi(npc, current, others)
	for i = 1, 1 + #(others or {}) do
		local b = _G["TaxiButton" .. i] or CreateFrame("Button", "TaxiButton" .. i, TaxiFrame)
		b:Show()
	end
	TaxiFrame:Show()
	openTaxi(npc, current, others)
end

function TakeTaxiNode(slot)
	S.took[#S.took + 1] = slot
	world.taxiNodes = {}
	TaxiFrame:Hide()
	world.close()
	world.onTaxi = true
	stub.fire("PLAYER_CONTROL_LOST")
end

function S.land()
	world.onTaxi = false
	stub.fire("PLAYER_CONTROL_GAINED")
end

-- The combat log's last event, as CombatLogGetCurrentEventInfo gives it.
local unpack = unpack or table.unpack
local logged = {}
function CombatLogGetCurrentEventInfo() return unpack(logged) end
local function log(...)
	logged = { ... }
	stub.fire("COMBAT_LOG_EVENT_UNFILTERED")
end

-- The loot window of the last kill: one item.
function GetNumLootItems() return S.loot end
function LootSlot(slot)
	if slot <= S.loot then S.looted = S.looted + 1 end
end

function S.fight(npc, name, level, credit)
	S.guid = S.guid + 1
	local guid = ("Creature-0-4372-0-17-%d-%010d"):format(npc, S.guid)
	local R = stub.rares
	local me = world.guid
	if R then
		R.unit("target", { guid = guid, name = name, level = level, class = "normal" })
		stub.fire("PLAYER_TARGET_CHANGED")
	end
	stub.inCombat = true
	stub.fire("PLAYER_REGEN_DISABLED")
	stub.fire("UNIT_COMBAT", "target", "WOUND", "", 120, 1)
	log(GetServerTime(), "SWING_DAMAGE", false, me, world.name, 0x511, 0, guid, name, 0xa48, 0, 120)
	stub.advance(2)
	if R then R.units.target.dead = true end
	log(GetServerTime(), "PARTY_KILL", false, me, world.name, 0x511, 0, guid, name, 0xa48, 0)
	log(GetServerTime(), "UNIT_DIED", false, "", "", 0, 0, guid, name, 0xa48, 0)
	if credit then credit() end
	stub.inCombat = false
	stub.fire("PLAYER_REGEN_ENABLED")
	-- Auto loot on: the client opens the loot window and says so (LOOT_READY(true)).
	S.loot = 1
	stub.fire("LOOT_READY", true)
	stub.fire("LOOT_OPENED", true, false)
	S.loot = 0
	stub.fire("LOOT_CLOSED")
	if R then
		R.clear("target")
		stub.fire("PLAYER_TARGET_CHANGED")
	end
	stub.advance(1)
end
