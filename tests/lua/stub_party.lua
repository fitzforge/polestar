-- The group and the hidden addon channel, for Quests/Party.lua. Load after
-- stub_world.lua (it owns C_QuestLog). Shapes follow the Forever client's
-- Blizzard_APIDocumentationGenerated (ChatInfoDocumentation.lua,
-- QuestLogDocumentation.lua IsUnitOnQuest, ChatConstantsDocumentation.lua
-- SendAddonMessageResult).
--
--   local p = stub.party
--   p.join("Ana"[, "OtherRealm"[, "Smith"]])  -- a party member (party1..4), GROUP_ROSTER_UPDATE; with a
--                                     -- surname, as Forever's characters have: UnitName gives it as
--                                     -- its second return (FrameXML Camelot NameUtil.lua), where other
--                                     -- clients give the realm
--   p.leave("Ana"); p.disband()       -- GROUP_ROSTER_UPDATE (and GROUP_LEFT when empty)
--   p.raid(true)                      -- the group is a raid
--   p.guild(true)                     -- the player is in a guild (IsInGuild), PLAYER_GUILD_UPDATE
--   p.receive("Ana-TestRealm", "1|33:5/8"[, channel[, prefix]])  -- CHAT_MSG_ADDON
--   p.sent                            -- { { prefix, text, chatType }, ... } every send attempt
--   p.result = 3                      -- what SendAddonMessage returns (0 = Success)
--   p.onQuest.Ana = { [33] = true }   -- C_QuestLog.IsUnitOnQuest answers
--   p.noUnitQuestAPI()                -- a client without C_QuestLog.IsUnitOnQuest
--   p.connect("Ana", false)          -- UNIT_CONNECTION: offline / back online
--   p.questLogChanged("Ana")          -- UNIT_QUEST_LOG_CHANGED for her unit
--   p.secretNames = true              -- UnitName gives party units' names as secret values
--   p.set("Ana", { level = 12, class = "MAGE", classID = 8, race = "Human", raceID = 1, sex = 3,
--     dead = true, map = 1429, x = 40, y = 50 })  -- what the client says of her unit (UnitLevel,
--     UnitClass, UnitRace, UnitSex, UnitIsDeadOrGhost; C_Map.GetBestMapForUnit/GetPlayerMapPosition)
--   p.shared                          -- quest ids QuestLogPushQuest shared, in order
--   p.pushable[33] = false            -- C_QuestLog.IsPushableQuest answers
--   p.pushResult("Ana", "ERR_QUEST_PUSH_ALREADY_DONE_S")  -- the game's system line to a share (CHAT_MSG_SYSTEM)
--   p.chat                            -- { { text, chatType, at }, ... } C_ChatInfo.SendChatMessage lines (at: GetTime())
--   p.lockdown = true                 -- C_ChatInfo.InChatMessagingLockdown answers
--   p.instance = true                 -- the group is an instance group (IsInGroup(LE_PARTY_CATEGORY_INSTANCE))
--   p.noLinks = true                  -- GetQuestLink gives nothing (else "|cffffff00|Hquest:<id>:0|h[<title>]|h|r")
--   p.show("CHAT_MSG_PARTY", text, "Ana-TestRealm")  -- a chat line through the registered message
--                                     -- filters: the text the chat frame shows, or nil when dropped
--   p.loot(itemID, name[, count])     -- CHAT_MSG_LOOT for your loot (LOOT_ITEM_SELF[_MULTIPLE] with p.itemLink(id, name))

local party = { members = {}, sent = {}, result = 0, onQuest = {}, inRaid = false, inGuild = false, prefixes = {}, shared = {}, pushable = {}, chat = {}, lockdown = false, instance = false }
stub.party = party

local function memberOf(unit)
	local i = type(unit) == "string" and tonumber(unit:match("^party(%d)$"))
	return i and party.members[i]
end

function party.join(name, realm, surname)
	table.insert(party.members, { name = name, realm = realm, surname = surname, online = true })
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

-- PLAYER_GUILD_UPDATE(unit) as the client fires it when the player's guild changes.
function party.guild(on)
	party.inGuild = on and true or false
	stub.fire("PLAYER_GUILD_UPDATE", "player")
end
function IsInGuild() return party.inGuild end

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

-- ChatInfo LE_PARTY_CATEGORY_*: no category means either group.
LE_PARTY_CATEGORY_HOME, LE_PARTY_CATEGORY_INSTANCE = 1, 2
function IsInGroup(category)
	if #party.members == 0 then return false end
	if category == LE_PARTY_CATEGORY_INSTANCE then return party.instance end
	if category == LE_PARTY_CATEGORY_HOME then return not party.instance end
	return true
end
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
	if m and party.secretNames then return party.SECRET, (m.surname or m.realm) and party.SECRET end
	if m then return m.name, m.surname or m.realm end
	return playerName(unit)
end

-- PlayerScriptDocumentation.lua Ambiguate: "none" drops the realm only when
-- it is the player's own.
function Ambiguate(name, context)
	local n, realm = name:match("^([^-]+)-(.+)$")
	if n and realm == GetNormalizedRealmName() then return n end
	return name
end

-- UnitIsUnit with a group member's name as a unit id, as the client takes
-- it: "Ana Smith" (Forever, a surname) or "Ana"/"Ana-OtherRealm", with
-- "-<this realm>" too. party.secretIsUnit = true: the answer is secret.
local function unitOfName(x)
	if x == "player" or memberOf(x) then return x end
	local n, realm = x:match("^([^-]+)-(.+)$")
	if n and realm == GetNormalizedRealmName() then x = n end
	for i, m in ipairs(party.members) do
		local full = m.surname and (m.name .. " " .. m.surname) or m.name
		if x == full or (m.realm and not m.surname and x == m.name .. "-" .. m.realm:gsub("[%s%-]", "")) then return "party" .. i end
	end
	local me, second = UnitName("player")
	if x == ((second and second ~= "") and (me .. " " .. second) or me) then return "player" end
	return nil
end
function UnitIsUnit(a, b)
	if party.secretIsUnit then return party.SECRET end
	local ua, ub = unitOfName(a), unitOfName(b)
	return ua ~= nil and ua == ub
end

C_ChatInfo = C_ChatInfo or {}
function C_ChatInfo.RegisterAddonMessagePrefix(prefix)
	party.prefixes[prefix] = true
	return 0
end
function C_ChatInfo.IsAddonMessagePrefixRegistered(prefix) return party.prefixes[prefix] == true end
function C_ChatInfo.SendAddonMessage(prefix, text, chatType, target)
	table.insert(party.sent, { prefix = prefix, text = text, chatType = chatType })
	return party.result
end
-- ChatInfoDocumentation.lua SendChatMessage (no returns), InChatMessagingLockdown.
function C_ChatInfo.SendChatMessage(text, chatType, languageID, target)
	table.insert(party.chat, { text = text, chatType = chatType, at = GetTime() })
end
function C_ChatInfo.InChatMessagingLockdown() return party.lockdown end

-- ChatFrameFilters.lua (Blizzard_ChatFrameBase): a callback returns true to
-- drop the line, or false and the arguments to show it with them.
party.filters = {}
ChatFrameUtil = ChatFrameUtil or {}
function ChatFrameUtil.AddMessageEventFilter(event, callback)
	party.filters[event] = party.filters[event] or {}
	table.insert(party.filters[event], callback)
end
function party.show(event, text, author)
	local args = { text, author }
	for _, f in ipairs(party.filters[event] or {}) do
		local r = { f(nil, event, args[1], args[2]) }
		if r[1] then return nil end
		if r[2] then args = { r[2], r[3] } end
	end
	return args[1]
end

-- GlobalStrings (the Forever client's enUS), and your loot as the client says it.
LOOT_ITEM_SELF = "You receive loot: %s"
LOOT_ITEM_SELF_MULTIPLE = "You receive loot: %sx%d"
function party.itemLink(id, name) return "|cffffffff|Hitem:" .. id .. "::::::::1:::::::|h[" .. name .. "]|h|r" end
function party.loot(id, name, count)
	local link = party.itemLink(id, name)
	local text = count and LOOT_ITEM_SELF_MULTIPLE:format(link, count) or LOOT_ITEM_SELF:format(link)
	stub.fire("CHAT_MSG_LOOT", text, "Testchar", "", "", "Testchar", "", 0, 0, "", 0, 1, "Player-1-0001")
end

-- The client's quest link (Blizzard_UIPanels_Game Mainline QuestMapFrame's
-- shift-click: GetQuestLink(questID)), for a quest in the log.
function GetQuestLink(q)
	local title = C_QuestLog.GetTitleForQuestID(q)
	if party.noLinks or not (title and C_QuestLog.IsOnQuest(q)) then return nil end
	return "|cffffff00|Hquest:" .. q .. ":0|h[" .. title .. "]|h|r"
end

function C_QuestLog.IsUnitOnQuest(unit, questID)
	local m = memberOf(unit)
	if not m then return false end
	local known = party.onQuest[m.name]
	return (known and known[questID]) == true
end

Enum.SendAddonMessageResult = { Success = 0, InvalidPrefix = 1, InvalidMessage = 2, AddonMessageThrottle = 3, NotInGroup = 5, ChannelThrottle = 8, AddOnMessageLockdown = 11 }

-- What the client says of a member's unit.
function party.set(name, facts)
	for _, m in ipairs(party.members) do
		if m.name == name then
			for k, v in pairs(facts) do m[k] = v end
		end
	end
end

local baseLevel, baseClass, baseRace = UnitLevel, UnitClass, UnitRace
function UnitLevel(unit)
	local m = memberOf(unit)
	if m then return m.level or 0 end
	return baseLevel(unit)
end
function UnitClass(unit)
	local m = memberOf(unit)
	if m then return m.class, m.class, m.classID end
	return baseClass(unit)
end
function UnitRace(unit)
	local m = memberOf(unit)
	if m then return m.race, m.race, m.raceID end
	return baseRace(unit)
end
function UnitSex(unit)
	local m = memberOf(unit)
	return m and m.sex or 1
end
function UnitIsDeadOrGhost(unit)
	local m = memberOf(unit)
	return m and m.dead or false
end

local baseBest, basePos = C_Map.GetBestMapForUnit, C_Map.GetPlayerMapPosition
function C_Map.GetBestMapForUnit(unit)
	local m = memberOf(unit)
	if m then return m.map end
	return baseBest(unit)
end
function C_Map.GetPlayerMapPosition(map, unit)
	local m = memberOf(unit)
	if m then
		if m.map and map == m.map and m.x then return CreateVector2D(m.x / 100, m.y / 100) end
		return nil
	end
	return basePos(map, unit)
end

-- Sharing a quest (QuestLogFrame's Share button: C_QuestLog.SetSelectedQuest, QuestLogPushQuest).
local selected
function C_QuestLog.SetSelectedQuest(q) selected = q end
function C_QuestLog.IsPushableQuest(q) return party.pushable[q] ~= false end
function QuestLogPushQuest() table.insert(party.shared, selected) end

-- GlobalStrings' answers to a share, as the client words them.
ERR_QUEST_PUSH_ALREADY_DONE_S = "%s has completed that quest."
ERR_QUEST_PUSH_LOG_FULL_S = "%s's quest log is full."
ERR_QUEST_PUSH_INVALID_S = "%s is not eligible for that quest."
ERR_QUEST_PUSH_TOO_FAR_S = "%s is too far away to receive your quest."
ERR_QUEST_PUSH_ONQUEST_S = "%s is already on that quest."
function party.pushResult(name, global)
	stub.fire("CHAT_MSG_SYSTEM", _G[global]:format(name))
end
