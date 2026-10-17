-- Questing toggles. Each does nothing at all while its setting is off.
--
--   instantQuestText  Forever's own CVar "instantQuestText" (Mainline
--                     QuestFrame.lua reads it; the Camelot interface options
--                     offer it as a checkbox). Turning the setting on stores
--                     the player's value and sets "1"; turning it off restores
--                     that value. A client without the CVar is left alone.
--   skipGossip        an NPC with no quests and a single gossip option: pick
--                     it (Shift suppresses). Blizzard already does this for
--                     options flagged selectOptionWhenOnlyOption.
--   fastLoot          when auto-loot applies (autoLootDefault, inverted by the
--                     AUTOLOOTTOGGLE modifier), take every slot at once.
--   hideErrors        turns the combat spam types ("Not enough rage", "Out of
--                     range", cooldowns) off through UIErrorsFrame's own
--                     SetMessageTypeEnabled (Blizzard_UIErrorsFrame); turning
--                     the setting off turns back on exactly the types it hid.
--                     Forever's Camelot override blacklists none of these.
--   autoReleasePvP    in a battleground (C_PvP.IsBattleground), release at
--                     PLAYER_DEAD unless a self-resurrection or a resurrection
--                     offer is there, or Hardcore is on. Shift: stay.
--
-- One GOSSIP_SHOW handler serves the flight master helper first, then skipGossip.
-- Duels live in Social.lua with the other requests.

local ADDON, ns = ...
local QoL = ns.QoL

local Toggles = {}
QoL.Toggles = Toggles

---------------------------------------------------------------------------
-- Instant quest text
---------------------------------------------------------------------------

local CVAR = "instantQuestText"

local function getCVar(name)
	if C_CVar and C_CVar.GetCVar then return C_CVar.GetCVar(name) end
	return GetCVar and GetCVar(name) or nil
end

local function setCVar(name, value)
	if C_CVar and C_CVar.SetCVar then return C_CVar.SetCVar(name, value) end
	if SetCVar then return SetCVar(name, value) end
end

function Toggles.InstantTextSupported()
	return getCVar(CVAR) ~= nil
end

function Toggles.ApplyInstantText()
	local value = getCVar(CVAR)
	if value == nil then return end
	local q = QoL.State()
	if QoL.On("instantQuestText") then
		if value ~= "1" then
			if q.instantPrev == nil then q.instantPrev = value end
			setCVar(CVAR, "1")
		end
	elseif q.instantPrev ~= nil then
		setCVar(CVAR, q.instantPrev)
		q.instantPrev = nil
	end
end

ns.OnLogin(Toggles.ApplyInstantText)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.instantQuestText" or path == "qol" or path == "" then Toggles.ApplyInstantText() end
end)

---------------------------------------------------------------------------
-- Gossip
---------------------------------------------------------------------------

function Toggles.SkipGossip()
	if not QoL.On("skipGossip") or QoL.Shift() then return false end
	local G = C_GossipInfo
	if not (G and G.GetOptions and G.SelectOptionByIndex) then return false end
	if (G.GetNumAvailableQuests and G.GetNumAvailableQuests() or 0) > 0 then return false end
	if (G.GetNumActiveQuests and G.GetNumActiveQuests() or 0) > 0 then return false end
	if G.ForceGossip and G.ForceGossip() then return false end
	local options = G.GetOptions() or {}
	if #options ~= 1 then return false end
	local o = options[1]
	if o.selectOptionWhenOnlyOption then return false end -- Blizzard selects it itself
	if o.status and o.status ~= 0 then return false end   -- unavailable / locked
	G.SelectOptionByIndex(o.orderIndex)
	return true
end

ns.RegisterEvent("GOSSIP_SHOW", function()
	if QoL.Flight and QoL.Flight.OnGossip() then return end
	Toggles.SkipGossip()
end)

---------------------------------------------------------------------------
-- Faster auto-loot
---------------------------------------------------------------------------

local lastLoot = -1

local function autoLootOn()
	local on = getCVar("autoLootDefault") == "1"
	if IsModifiedClick and IsModifiedClick("AUTOLOOTTOGGLE") then on = not on end
	return on
end

function Toggles.OnLootReady(autoloot)
	if not QoL.On("fastLoot") then return end
	if autoloot == nil then autoloot = autoLootOn() end
	if not autoloot then return end
	local t = GetTime()
	if t - lastLoot < 0.3 then return end -- LOOT_READY can repeat for one corpse
	lastLoot = t
	if not (GetNumLootItems and LootSlot) then return end
	for slot = GetNumLootItems(), 1, -1 do LootSlot(slot) end
end

ns.RegisterEvent("LOOT_READY", function(_, autoloot) Toggles.OnLootReady(autoloot) end)

---------------------------------------------------------------------------
-- Combat error spam
---------------------------------------------------------------------------

-- LE_GAME_ERR_* names every one of which Blizzard's Mainline UIErrorsFrame.lua
-- (the family file Forever loads) references; a client without one skips it.
local SPAM = {
	"ABILITY_COOLDOWN", "SPELL_COOLDOWN", "ITEM_COOLDOWN", "SPELL_FAILED_ANOTHER_IN_PROGRESS",
	"OUT_OF_RAGE", "OUT_OF_ENERGY", "OUT_OF_MANA", "OUT_OF_FOCUS", "OUT_OF_COMBO_POINTS", "OUT_OF_POWER_DISPLAY",
	"OUT_OF_RANGE", "SPELL_OUT_OF_RANGE", "GENERIC_NO_VALID_TARGETS",
}
Toggles.ERROR_TYPES = SPAM

local hidden = {} -- message type -> true: the types this setting turned off

-- Not with the gamepad interface (ns.GamepadUI): the setting writes the
-- game's BLACK_LISTED_MESSAGE_TYPES, which UIErrorsFrame reads as the
-- gamepad's own bindings and focus code show their errors.
function Toggles.ApplyErrors()
	local f = UIErrorsFrame
	if ns.GamepadUI() or not (f and f.SetMessageTypeEnabled) then return end
	if QoL.On("hideErrors") then
		local blacklisted = BLACK_LISTED_MESSAGE_TYPES
		for i = 1, #SPAM do
			local t = _G["LE_GAME_ERR_" .. SPAM[i]]
			if t ~= nil and not hidden[t] and not (blacklisted and blacklisted[t]) then
				f:SetMessageTypeEnabled(t, false)
				hidden[t] = true
			end
		end
	else
		for t in pairs(hidden) do
			f:SetMessageTypeEnabled(t, true)
			hidden[t] = nil
		end
	end
end

ns.OnLogin(Toggles.ApplyErrors)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.hideErrors" or path == "qol" or path == "" then Toggles.ApplyErrors() end
end)

---------------------------------------------------------------------------
-- Release in battlegrounds
---------------------------------------------------------------------------

function Toggles.ReleaseInPvP()
	if not QoL.On("autoReleasePvP") or QoL.Shift() then return false end
	if not (C_PvP and C_PvP.IsBattleground and C_PvP.IsBattleground()) then return false end
	if C_GameRules and C_GameRules.IsHardcoreActive and C_GameRules.IsHardcoreActive() then return false end
	local own = C_DeathInfo and C_DeathInfo.GetSelfResurrectOptions and C_DeathInfo.GetSelfResurrectOptions()
	if own and #own > 0 then return false end
	if ResurrectGetOfferer and ResurrectGetOfferer() then return false end
	return true
end

QoL.WhileOn("autoReleasePvP", "PLAYER_DEAD", function()
	if Toggles.ReleaseInPvP() and RepopMe then RepopMe() end
end)
