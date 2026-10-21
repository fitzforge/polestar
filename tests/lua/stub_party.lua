-- The group and the hidden addon channel, for Quests/Party.lua. Load after
-- stub_world.lua (it owns C_QuestLog). Shapes follow the Forever client's
-- Blizzard_APIDocumentationGenerated (ChatInfoDocumentation.lua,
-- QuestLogDocumentation.lua IsUnitOnQuest, ChatConstantsDocumentation.lua
-- SendAddonMessageResult).
--
--   local p = stub.party
--   p.join("Ana"[, "OtherRealm"])     -- a party member (party1..4), GROUP_ROSTER_UPDATE
--   p.leave("Ana"); p.disband()       -- GROUP_ROSTER_UPDATE (and GROUP_LEFT when empty)
--   p.raid(true)                      -- the group is a raid
--   p.receive("Ana-TestRealm", "1|33:5/8"[, channel[, prefix]])  -- CHAT_MSG_ADDON
--   p.sent                            -- { { prefix, text, chatType }, ... } every send attempt
--   p.result = 3                      -- what SendAddonMessage returns (0 = Success)
--   p.onQuest.Ana = { [33] = true }   -- C_QuestLog.IsUnitOnQuest answers
--   p.noUnitQuestAPI()                -- a client without C_QuestLog.IsUnitOnQuest
--   p.connect("Ana", false)          -- UNIT_CONNECTION: offline / back online
--   p.questLogChanged("Ana")          -- UNIT_QUEST_LOG_CHANGED for her unit
--   p.secretNames = true              -- UnitName gives party units' names as secret values
--   p.lead("Ana")                     -- she leads the party (PARTY_LEADER_CHANGED); p.lead() the player

local party = { members = {}, sent = {}, result = 0, onQuest = {}, inRaid = false, prefixes = {} }
stub.party = party

local function memberOf(unit)
	local i = type(unit) == "string" and tonumber(unit:match("^party(%d)$"))
	return i and party.members[i]
end

function party.join(name, realm)
	table.insert(party.members, { name = name, realm = realm, online = true })
	stub.fire("GROUP_ROSTER_UPDATE")
end

function party.leave(name)
	for i, m in ipairs(party.members) do
		if m.name == name then table.remove(party.members, i) break end
	end
	if #party.members == 0 then stub.fire("GROUP_LEFT") end
	stub.fire("GROUP_ROSTER_UPDATE")
end

function party.disband()
	party.members = {}
	party.inRaid = false
	stub.fire("GROUP_LEFT")
	stub.fire("GROUP_ROSTER_UPDATE")
end

function party.raid(on)
	party.inRaid = on and true or false
	stub.fire("GROUP_ROSTER_UPDATE")
end

function party.receive(sender, text, channel, prefix)
	stub.fire("CHAT_MSG_ADDON", prefix or "Polestar", text, channel or "PARTY", sender, "", 0, 0, "", 0)
end

function party.noUnitQuestAPI() C_QuestLog.IsUnitOnQuest = nil end

-- UNIT_CONNECTION(unit, isConnected) for a member going offline or back online.
function party.connect(name, online)
	for i, m in ipairs(party.members) do
		if m.name == name then
			m.online = online
			stub.fire("UNIT_CONNECTION", "party" .. i, online)
		end
	end
end

-- UNIT_QUEST_LOG_CHANGED(unit) for a member's quest log.
function party.questLogChanged(name)
	for i, m in ipairs(party.members) do
		if m.name == name then stub.fire("UNIT_QUEST_LOG_CHANGED", "party" .. i) end
	end
end

UNKNOWNOBJECT = "Unknown"

-- Who leads: a member's name, or nil for the player.
function party.lead(name)
	party.leader = name
	stub.fire("PARTY_LEADER_CHANGED")
end

function UnitIsGroupLeader(unit)
	if #party.members == 0 then return false end
	if unit == "player" then return party.leader == nil end
	local m = memberOf(unit)
	return m ~= nil and party.leader == m.name
end

function IsInGroup() return #party.members > 0 end
function IsInRaid() return party.inRaid end
function GetNumSubgroupMembers() return #party.members end
function GetNumGroupMembers() return #party.members > 0 and #party.members + 1 or 0 end
function UnitExists(unit) return unit == "player" or memberOf(unit) ~= nil end
function UnitIsConnected(unit)
	if unit == "player" then return true end
	local m = memberOf(unit)
	return m and m.online or false
end

-- UnitDocumentation.lua UnitName: SecretWhenUnitNameIdentityRestricted.
-- A userdata, so concatenating or ordering it fails as a secret would.
party.SECRET = newproxy(true)
function issecretvalue(v) return v == party.SECRET end

local playerName = UnitName
function UnitName(unit)
	local m = memberOf(unit)
	if m and party.secretNames then return party.SECRET, m.realm and party.SECRET end
	if m then return m.name, m.realm end
	return playerName(unit)
end

-- PlayerScriptDocumentation.lua Ambiguate: "none" drops the realm only when
-- it is the player's own.
function Ambiguate(name, context)
	local n, realm = name:match("^([^-]+)-(.+)$")
	if n and realm == GetNormalizedRealmName() then return n end
	return name
end

C_ChatInfo = C_ChatInfo or {}
function C_ChatInfo.RegisterAddonMessagePrefix(prefix)
	party.prefixes[prefix] = true
	return 0
end
function C_ChatInfo.SendAddonMessage(prefix, text, chatType, target)
	table.insert(party.sent, { prefix = prefix, text = text, chatType = chatType })
	return party.result
end

function C_QuestLog.IsUnitOnQuest(unit, questID)
	local m = memberOf(unit)
	if not m then return false end
	local known = party.onQuest[m.name]
	return (known and known[questID]) == true
end

Enum.SendAddonMessageResult = { Success = 0, InvalidPrefix = 1, InvalidMessage = 2, AddonMessageThrottle = 3, NotInGroup = 5, ChannelThrottle = 8, AddOnMessageLockdown = 11 }
