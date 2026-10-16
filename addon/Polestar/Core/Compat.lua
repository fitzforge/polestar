-- Every quest, map and unit client call goes through this table, so Forever
-- specifics live in one file and other modules' tests can swap it for a fake.
-- Contract: docs/ARCHITECTURE.md, "Compat". Each function was checked against
-- the Forever (1.60.1) API declarations and FrameXML; anything that may be
-- missing is guarded and degrades to nil/false.

local ADDON, ns = ...

local Compat = {}
ns.Compat = Compat

-- Era map frames, filled by Polestar.RegisterMapFrames (Core/Guides.lua).
ns.MapFrames = ns.MapFrames or { era = {} }

local type, tonumber = type, tonumber

-- One reusable vector for map/world conversions, so the arrival ticker and
-- the arrow do not allocate on every call. The client only reads .x/.y.
local scratch
local function vec(x, y)
	if not scratch then
		scratch = CreateVector2D and CreateVector2D(0, 0) or {}
	end
	scratch.x, scratch.y = x, y
	return scratch
end

local function xyOf(v)
	if not v then return nil end
	if v.GetXY then return v:GetXY() end
	return v.x, v.y
end

---------------------------------------------------------------------------
-- Player
---------------------------------------------------------------------------

-- Forever has retail-style combat restrictions: unit APIs can return secret
-- values, and comparing, indexing or parsing one throws. Every module checks
-- with these two: IsSecret(v) is true for a secret value, and Readable(v)
-- passes a value through, a secret one reading as unknown (nil).
local function isSecret(v)
	return v ~= nil and issecretvalue ~= nil and issecretvalue(v) and true or false
end
Compat.IsSecret = isSecret

local function readable(v)
	if isSecret(v) then return nil end
	return v
end
Compat.Readable = readable

-- Seconds since the epoch on the server clock (stable across sessions and alts).
function Compat.Now()
	if GetServerTime then return GetServerTime() end
	return time and time() or 0
end

function Compat.GetPlayerInfo()
	local _, race = UnitRace("player")
	local _, class = UnitClass("player")
	local faction = readable(UnitFactionGroup and UnitFactionGroup("player"))
	if faction ~= "Alliance" and faction ~= "Horde" then faction = "Neutral" end
	return {
		name = readable(UnitName("player")),
		realm = GetRealmName and GetRealmName() or nil,
		guid = readable(UnitGUID and UnitGUID("player")),
		level = readable(UnitLevel("player")) or 1,
		xp = readable(UnitXP and UnitXP("player")) or 0,
		xpMax = readable(UnitXPMax and UnitXPMax("player")) or 0,
		race = readable(race),
		class = readable(class),
		faction = faction,
	}
end

function Compat.GetPlayerFacing()
	return GetPlayerFacing and GetPlayerFacing() or nil
end

function Compat.GetZoneText()
	local zone = GetZoneText and GetZoneText() or (GetRealZoneText and GetRealZoneText())
	local sub = GetSubZoneText and GetSubZoneText() or nil
	if zone == "" then zone = nil end
	if sub == "" then sub = nil end
	return zone, sub
end

function Compat.GetBindLocation()
	local loc = GetBindLocation and GetBindLocation() or nil
	if loc == "" then return nil end
	return loc
end

function Compat.IsOnTaxi()
	return readable(UnitOnTaxi and UnitOnTaxi("player")) and true or false
end

-- Inside a building, cave or mine (where the client allows no mount).
function Compat.IsIndoors()
	return readable(IsIndoors and IsIndoors()) and true or false
end

-- The player's world position from UnitPosition: wx (north), wy (west), z
-- (nil when unread) and the instance map id, or nil while the client keeps it
-- secret or hides it. The one place UnitPosition is read. Forever's client
-- has given a height of exactly 0 where the ground is at 12 yd (Ratchet); a
-- real height is never exactly 0, so that one is unread too.
function Compat.GetPlayerUnitPosition()
	if not UnitPosition then return nil end
	local ok, x, y, z, instance = pcall(UnitPosition, "player")
	if not ok then return nil end
	x, y, z, instance = readable(x), readable(y), readable(z), readable(instance)
	if type(x) ~= "number" or type(y) ~= "number" or instance == nil then return nil end
	return x, y, type(z) == "number" and z ~= 0 and z or nil, instance
end

-- A spell's cooldown as GetTime start and duration; 0, 0 when it is ready
-- or the client keeps it secret.
function Compat.GetSpellCooldown(spellID)
	local start, duration
	if C_Spell and C_Spell.GetSpellCooldown then
		local ok, info = pcall(C_Spell.GetSpellCooldown, spellID)
		if ok and type(info) == "table" then start, duration = info.startTime, info.duration end
	elseif GetSpellCooldown then
		local ok, s, d = pcall(GetSpellCooldown, spellID)
		if ok then start, duration = s, d end
	end
	start, duration = readable(start), readable(duration)
	if type(start) ~= "number" or type(duration) ~= "number" then return 0, 0 end
	return start, duration
end

function Compat.InCombat()
	if InCombatLockdown and InCombatLockdown() then return true end
	return readable(UnitAffectingCombat and UnitAffectingCombat("player")) and true or false
end

function Compat.IsInInstance()
	if not IsInInstance then return false end
	local inside = IsInInstance()
	return inside and true or false
end

function Compat.IsShiftKeyDown()
	return IsShiftKeyDown and IsShiftKeyDown() and true or false
end

-- "Creature-0-4372-0-17-6-0000123456" -> 6. GameObject GUIDs carry their
-- object ID in the same field; players and pets give nil.
function Compat.GetNpcID(unit)
	local guid = UnitGUID and UnitGUID(unit or "npc")
	if type(guid) ~= "string" or (issecretvalue and issecretvalue(guid)) then return nil end
	local kind, _, _, _, _, id = strsplit("-", guid)
	if kind == "Creature" or kind == "Vehicle" or kind == "GameObject" then
		return tonumber(id)
	end
	return nil
end

-- Name of the flight master node the open taxi map is at.
function Compat.GetCurrentTaxiNode()
	if NumTaxiNodes and TaxiNodeGetType and TaxiNodeName then
		for i = 1, NumTaxiNodes() or 0 do
			if TaxiNodeGetType(i) == "CURRENT" then return TaxiNodeName(i) end
		end
	end
	return nil
end

-- Another addon installed and enabled: loaded, or loadable when it loads
-- after Polestar. C_AddOns.IsAddOnLoaded / DoesAddOnExist / GetAddOnInfo
-- (AddOnsDocumentation.lua).
function Compat.AddOnPresent(name)
	local A = C_AddOns
	if not A then return false end
	if A.IsAddOnLoaded and A.IsAddOnLoaded(name) then return true end
	if not (A.DoesAddOnExist and A.GetAddOnInfo) or not A.DoesAddOnExist(name) then return false end
	return select(4, A.GetAddOnInfo(name)) and true or false
end

---------------------------------------------------------------------------
-- Quests
---------------------------------------------------------------------------

function Compat.IsQuestCompleted(questID)
	if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
		return C_QuestLog.IsQuestFlaggedCompleted(questID) and true or false
	end
	return false
end

function Compat.IsOnQuest(questID)
	if C_QuestLog and C_QuestLog.IsOnQuest then
		return C_QuestLog.IsOnQuest(questID) and true or false
	end
	return false
end

function Compat.IsQuestReadyForTurnIn(questID)
	if not (C_QuestLog and C_QuestLog.IsOnQuest and C_QuestLog.IsOnQuest(questID)) then return false end
	if C_QuestLog.ReadyForTurnIn and C_QuestLog.ReadyForTurnIn(questID) then return true end
	if C_QuestLog.IsComplete and C_QuestLog.IsComplete(questID) then return true end
	return false
end

function Compat.GetQuestObjectives(questID)
	if not (C_QuestLog and C_QuestLog.GetQuestObjectives) then return nil end
	local raw = C_QuestLog.GetQuestObjectives(questID)
	if type(raw) ~= "table" or #raw == 0 then return nil end
	local out = {}
	for i = 1, #raw do
		local o = raw[i]
		local finished = o.finished and true or false
		local req = tonumber(o.numRequired) or 0
		local cur = tonumber(o.numFulfilled) or 0
		if req <= 0 then
			-- Event objectives report 0/0; finished is the truth.
			req, cur = 1, finished and 1 or 0
		end
		out[i] = { text = o.text or "", type = o.type or "", finished = finished, numFulfilled = cur, numRequired = req }
	end
	return out
end

function Compat.GetQuestTitle(questID)
	if C_QuestLog and C_QuestLog.GetTitleForQuestID then
		local t = C_QuestLog.GetTitleForQuestID(questID)
		if t and t ~= "" then return t end
	end
	return nil
end

-- Quests the open NPC window offers, as a list of quest IDs, or nil when the
-- client cannot say. source: "gossip" (C_GossipInfo.GetAvailableQuests, as
-- GossipFrameShared.lua reads it), "greeting" (GetNumAvailableQuests /
-- GetAvailableQuestInfo's 5th return, as QuestFrame.lua's greeting panel
-- does) or "detail" (GetQuestID of the quest being offered).
function Compat.GetOfferedQuests(source)
	local out = {}
	if source == "gossip" then
		local G = C_GossipInfo
		if not (G and G.GetAvailableQuests) then return nil end
		local list = G.GetAvailableQuests() or {}
		for i = 1, #list do
			local q = list[i].questID
			if q then out[#out + 1] = q end
		end
	elseif source == "greeting" then
		if not (GetNumAvailableQuests and GetAvailableQuestInfo) then return nil end
		for i = 1, GetNumAvailableQuests() or 0 do
			local q = select(5, GetAvailableQuestInfo(i))
			if q then out[#out + 1] = q end
		end
	elseif source == "detail" then
		local q = GetQuestID and GetQuestID()
		if not q or q == 0 then return nil end
		out[1] = q
	else
		return nil
	end
	return out
end

-- Quests the open gossip or greeting window lists as active (in the log, or
-- just accepted: the window refreshes a moment before the quest log does), as
-- a list of quest IDs, or nil when the client cannot say. source: "gossip"
-- (C_GossipInfo.GetActiveQuests) or "greeting" (GetNumActiveQuests /
-- GetActiveQuestID, as QuestFrame.lua's greeting panel reads them).
function Compat.GetActiveQuests(source)
	local out = {}
	if source == "gossip" then
		local G = C_GossipInfo
		if not (G and G.GetActiveQuests) then return nil end
		local list = G.GetActiveQuests() or {}
		for i = 1, #list do
			local q = list[i].questID
			if q then out[#out + 1] = q end
		end
	elseif source == "greeting" then
		if not (GetNumActiveQuests and GetActiveQuestID) then return nil end
		for i = 1, GetNumActiveQuests() or 0 do
			local q = GetActiveQuestID(i)
			if q then out[#out + 1] = q end
		end
	else
		return nil
	end
	return out
end

-- Classic grey level (no XP from quests at or below it), used when the
-- client gives no trivial range.
local function greyLevel(level)
	if level <= 5 then return 0 end
	if level <= 39 then return level - 5 - math.floor(level / 10) end
	if level <= 59 then return level - 1 - math.floor(level / 5) end
	return level - 9
end

-- Whether a quest of level qlvl is grey (trivial) for a character of the
-- given level. Forever's nameplates use C_QuestLog.GetTrivialRange() the
-- same way: trivial when more than that many levels below.
function Compat.IsQuestTrivial(qlvl, level)
	if not (qlvl and level) then return false end
	if C_QuestLog and C_QuestLog.GetTrivialRange then
		local range = C_QuestLog.GetTrivialRange()
		if type(range) == "number" then return level - qlvl > range end
	end
	return qlvl <= greyLevel(level)
end

-- includeBank: the bank's too (a key left there still counts as owned).
function Compat.GetItemCount(itemID, includeBank)
	local fn = (C_Item and C_Item.GetItemCount) or GetItemCount
	if not fn then return 0 end
	return fn(itemID, includeBank and true or nil) or 0
end

-- The client's quality for an item (0 poor .. 7 heirloom), or nil while the
-- item is not cached.
function Compat.GetItemQuality(itemID)
	if type(itemID) ~= "number" then return nil end
	local byId = C_Item and C_Item.GetItemQualityByID
	if byId then
		local ok, q = pcall(byId, itemID)
		if ok and type(q) == "number" then return q end
	end
	local info = (C_Item and C_Item.GetItemInfo) or GetItemInfo
	if info then
		local ok, _, _, q = pcall(info, itemID)
		if ok and type(q) == "number" then return q end
	end
	return nil
end

-- The client's colour for an item quality as "ffrrggbb" (|c escapes), or nil.
function Compat.ItemQualityHex(quality)
	local colors = type(quality) == "number" and ITEM_QUALITY_COLORS
	local c = type(colors) == "table" and colors[quality]
	if type(c) ~= "table" or type(c.r) ~= "number" then return nil end
	return string.format("ff%02x%02x%02x", math.floor(c.r * 255 + 0.5), math.floor(c.g * 255 + 0.5), math.floor(c.b * 255 + 0.5))
end

-- An item's icon (file id or path) from its id; the client knows it without
-- the item being cached. nil when unknown.
function Compat.ItemIcon(itemID)
	local fn = type(itemID) == "number" and ((C_Item and C_Item.GetItemIconByID) or GetItemIcon)
	if not fn then return nil end
	local ok, icon = pcall(fn, itemID)
	if ok and icon and not isSecret(icon) then return icon end
	return nil
end

-- A spell's icon from its id, or nil.
function Compat.SpellIcon(spellID)
	local fn = type(spellID) == "number" and ((C_Spell and C_Spell.GetSpellTexture) or GetSpellTexture)
	if not fn then return nil end
	local ok, icon = pcall(fn, spellID)
	if ok and icon and not isSecret(icon) then return icon end
	return nil
end

-- An item's link ("|cff...|Hitem:...|h[Name]|h|r"), or nil while the item
-- is not cached (C_Item.GetItemInfo answers only from the cache).
function Compat.ItemLink(itemID)
	local fn = type(itemID) == "number" and ((C_Item and C_Item.GetItemInfo) or GetItemInfo)
	if not fn then return nil end
	local ok, _, link = pcall(fn, itemID)
	if ok and type(link) == "string" and not isSecret(link) then return link end
	return nil
end

-- true when the item is in the client's cache; otherwise asks the server for
-- it (GET_ITEM_INFO_RECEIVED fires with the item ID when it arrives) and
-- returns false.
function Compat.RequestItem(itemID)
	if type(itemID) ~= "number" or not C_Item then return false end
	local cached = C_Item.IsItemDataCachedByID
	if cached then
		local ok, yes = pcall(cached, itemID)
		if ok and yes == true then return true end
	end
	if C_Item.RequestLoadItemDataByID then pcall(C_Item.RequestLoadItemDataByID, itemID) end
	return false
end

-- An item's name from its id in the client's language, or nil while the item
-- is not cached (RequestItem asks for it).
function Compat.GetItemName(itemID)
	local fn = type(itemID) == "number" and C_Item and C_Item.GetItemNameByID
	if not fn then return nil end
	local ok, name = pcall(fn, itemID)
	if ok and type(name) == "string" and name ~= "" and not isSecret(name) then return name end
	return nil
end

-- Asks the server for a quest's data (QUEST_DATA_LOAD_RESULT fires with the
-- quest ID when it arrives); GetQuestTitle answers for it from then on.
function Compat.RequestQuest(questID)
	local fn = type(questID) == "number" and C_QuestLog and C_QuestLog.RequestLoadQuestByID
	if fn then pcall(fn, questID) end
end

-- A spell's chat link, or nil.
function Compat.SpellLink(spellID)
	local fn = type(spellID) == "number" and ((C_Spell and C_Spell.GetSpellLink) or GetSpellLink)
	if not fn then return nil end
	local ok, link = pcall(fn, spellID)
	if ok and type(link) == "string" and not isSecret(link) then return link end
	return nil
end

-- The spell twin of RequestItem: true when cached, else asks for it
-- (SPELL_DATA_LOAD_RESULT fires with the spell ID) and returns false.
function Compat.RequestSpell(spellID)
	if type(spellID) ~= "number" or not C_Spell then return false end
	local cached = C_Spell.IsSpellDataCached
	if cached then
		local ok, yes = pcall(cached, spellID)
		if ok and yes == true then return true end
	end
	if C_Spell.RequestLoadSpellData then pcall(C_Spell.RequestLoadSpellData, spellID) end
	return false
end

---------------------------------------------------------------------------
-- Maps and world coordinates
---------------------------------------------------------------------------

function Compat.GetMapName(uiMapID)
	if not (uiMapID and C_Map and C_Map.GetMapInfo) then return nil end
	local info = C_Map.GetMapInfo(uiMapID)
	return info and info.name or nil
end

-- An AreaTable area's name in the client's language (C_Map.GetAreaInfo),
-- as GetZoneText, GetSubZoneText and GetBindLocation name it there; nil
-- without the API, for an unknown area or while the value is secret.
function Compat.GetAreaName(areaID)
	if type(areaID) ~= "number" or not (C_Map and C_Map.GetAreaInfo) then return nil end
	local ok, name = pcall(C_Map.GetAreaInfo, areaID)
	if not ok or isSecret(name) or type(name) ~= "string" or name == "" then return nil end
	return name
end

-- A map's name to show: the client's, else the Codex zone's; nil when
-- neither knows the map. Asks ns.Compat, so a stand-in Compat answers too.
function Compat.MapName(uiMapID)
	if not uiMapID then return nil end
	local C = ns.Compat
	local ok, name = pcall(C.GetMapName, uiMapID)
	if ok and type(name) == "string" and name ~= "" and not isSecret(name) then return name end
	local X = ns.Codex
	local z = X and X.IsLoaded and X.IsLoaded() and X.Zone and X.Zone(uiMapID)
	return z and z.name or nil
end

-- Opening the world map at a map: C_Map.OpenWorldMap, the client's own
-- opener, when it has one. The global OpenWorldMap called from addon code
-- leaves the map frame tainted, so every later open in combat is blocked and
-- the quest pins are lost until a reload (Shortest Path Forever 1.8.0, #92;
-- docs/NAV_QA.md C3); it is only the
-- fallback on a client without C_Map.OpenWorldMap. Never in combat, and
-- never with the gamepad interface (ns.GamepadUI): the map opened from
-- addon code joins the gamepad's focus in Polestar's name, and its close
-- is blocked. The button that would open it is not shown then.
--   Compat.CanOpenWorldMap() -> bool ; Compat.OpenWorldMap(uiMapID) -> opened
local function worldMapOpener()
	if ns.GamepadUI() then return nil end
	if C_Map and C_Map.OpenWorldMap then return C_Map.OpenWorldMap end
	return OpenWorldMap
end

function Compat.CanOpenWorldMap()
	return worldMapOpener() ~= nil
end

function Compat.OpenWorldMap(uiMapID)
	local open = worldMapOpener()
	if not open or Compat.InCombat() then return false end
	return pcall(open, uiMapID) and true or false
end

-- The continent-type uiMap (Enum.UIMapType.Continent = 2) a map belongs to,
-- found through C_Map.GetMapInfo's parentMapID chain; nil when unknown.
-- Works for maps with no world bounds (no registered Era frame).
local CONTINENT_TYPE = 2
local continentCache = {}
function Compat.GetContinentMap(uiMapID)
	if not (uiMapID and C_Map and C_Map.GetMapInfo) then return nil end
	local cached = continentCache[uiMapID]
	if cached ~= nil then return cached or nil end
	local result = false
	local map = uiMapID
	for _ = 1, 12 do
		local info = C_Map.GetMapInfo(map)
		if not info then break end
		if info.mapType == CONTINENT_TYPE then
			result = info.mapID or map
			break
		end
		if not info.parentMapID or info.parentMapID == 0 or info.parentMapID == map then break end
		map = info.parentMapID
	end
	continentCache[uiMapID] = result
	return result or nil
end

function Compat.GetPlayerMapPosition()
	if not (C_Map and C_Map.GetBestMapForUnit and C_Map.GetPlayerMapPosition) then return nil end
	local map = C_Map.GetBestMapForUnit("player")
	if not map then return nil end
	local pos = C_Map.GetPlayerMapPosition(map, "player")
	local x, y = xyOf(pos)
	if not x or not y or (x == 0 and y == 0) then return nil end
	return map, x * 100, y * 100
end

local function liveToWorld(map, x, y)
	if not (C_Map and C_Map.GetWorldPosFromMapPos) then return nil end
	local c, pos = C_Map.GetWorldPosFromMapPos(map, vec(x / 100, y / 100))
	local wx, wy = xyOf(pos)
	if not c or not wx then return nil end
	return c, wx, wy
end

function Compat.MapToWorld(uiMapID, x, y, frame)
	if not (uiMapID and x and y) then return nil end
	if frame == "e" then
		local b = ns.MapFrames.era[uiMapID]
		if not b then return nil end
		return b.c, b.top + (b.bottom - b.top) * y / 100, b.left + (b.right - b.left) * x / 100
	end
	return liveToWorld(uiMapID, x, y)
end

function Compat.GetPlayerWorldPosition()
	local map, x, y = Compat.GetPlayerMapPosition()
	if not map then return nil end
	return Compat.MapToWorld(map, x, y)
end

-- Live bounds per map from two corner world positions, computed once.
local liveBounds = {}
local function boundsOf(map)
	local b = liveBounds[map]
	if b == nil then
		b = false
		local c1, top, left = liveToWorld(map, 0, 0)
		local c2, bottom, right = liveToWorld(map, 100, 100)
		if c1 and c1 == c2 and top ~= bottom and left ~= right then
			b = { c = c1, top = top, bottom = bottom, left = left, right = right }
		end
		liveBounds[map] = b
	end
	return b or nil
end

function Compat.WorldToMap(continentID, wx, wy, uiMapID)
	if not (continentID and wx and wy and uiMapID) then return nil end
	if C_Map and C_Map.GetMapPosFromWorldPos then
		local map, pos = C_Map.GetMapPosFromWorldPos(continentID, vec(wx, wy), uiMapID)
		local x, y = xyOf(pos)
		if map == uiMapID and x then return x * 100, y * 100 end
	end
	local b = boundsOf(uiMapID)
	if not b or b.c ~= continentID then return nil end
	return (wy - b.left) / (b.right - b.left) * 100, (wx - b.top) / (b.bottom - b.top) * 100
end

---------------------------------------------------------------------------
-- Professions, spells, reputation, exploration, achievements
--
-- Each returns nil when the client cannot answer. Compat.Supports(feature)
-- tells "this client lacks the API" apart from "no data yet", so the Engine
-- can fall back to a manual check-off instead of a goal that never finishes.
---------------------------------------------------------------------------

-- Classic profession skill lines (SkillLine.db2), so a guide's skill name
-- works on any client locale and on collapsed skill headers. Riding (762) is
-- Forever's single riding skill.
local SKILL_LINES = {
	alchemy = 171, blacksmithing = 164, enchanting = 333, engineering = 202,
	herbalism = 182, leatherworking = 165, mining = 186, skinning = 393,
	tailoring = 197, cooking = 185, fishing = 356, ["first aid"] = 129,
	riding = 762,
}
Compat.SKILL_LINES = SKILL_LINES

function Compat.Supports(feature)
	if feature == "skill" then
		return (C_SkillInfo and (C_SkillInfo.GetSkillLineInfoByID or C_SkillInfo.GetSkillLineInfo)
			or (GetProfessions and GetProfessionInfo)) and true or false
	elseif feature == "spell" then
		return ((C_SpellBook and C_SpellBook.IsSpellKnown) or IsPlayerSpell or IsSpellKnown
			or (C_TradeSkillUI and C_TradeSkillUI.GetRecipeInfo)) and true or false
	elseif feature == "faction" then
		return ((C_Reputation and C_Reputation.GetFactionDataByID) or GetFactionInfoByID) and true or false
	elseif feature == "explore" then
		return (C_MapExplorationInfo and C_MapExplorationInfo.GetExploredAreaIDsAtPosition) and true or false
	elseif feature == "achievement" then
		return GetAchievementInfo and true or false
	end
	return false
end

local function learnedRank(info)
	if not info or info.isHeader then return nil end
	local rank, maxRank = tonumber(info.rank) or 0, tonumber(info.maxRank) or 0
	if rank == 0 and maxRank == 0 then return nil end -- not learned
	return rank, maxRank
end

-- skillLineOrName: a skill line ID or a profession name ("Alchemy", "First Aid").
function Compat.GetSkillRank(skillLineOrName)
	local id, name = nil, nil
	if type(skillLineOrName) == "number" then
		id = skillLineOrName
	elseif type(skillLineOrName) == "string" then
		name = skillLineOrName:lower()
		id = SKILL_LINES[name]
	else
		return nil
	end
	local S = C_SkillInfo
	if id and S and S.GetSkillLineInfoByID then
		local rank, maxRank = learnedRank(S.GetSkillLineInfoByID(id))
		if rank then return rank, maxRank end
	end
	if GetProfessions and GetProfessionInfo then
		local profs = { GetProfessions() }
		for i = 1, 5 do
			local index = profs[i]
			if index then
				local pname, _, rank, maxRank, _, _, skillLine = GetProfessionInfo(index)
				if (id and skillLine == id) or (name and pname and pname:lower() == name) then
					return rank or 0, maxRank or 0
				end
			end
		end
	end
	if S and S.GetNumSkillLines and S.GetSkillLineInfo then
		for i = 1, S.GetNumSkillLines() or 0 do
			local info = S.GetSkillLineInfo(i)
			if info and ((id and info.skillID == id) or (name and info.name and info.name:lower() == name)) then
				local rank, maxRank = learnedRank(info)
				if rank then return rank, maxRank end
			end
		end
	end
	return nil
end

-- Spells in the spellbook, and profession recipes (which are not).
function Compat.IsSpellKnown(spellID)
	if not spellID then return false end
	if C_SpellBook and C_SpellBook.IsSpellKnown then
		if C_SpellBook.IsSpellKnown(spellID) then return true end
	elseif IsPlayerSpell then
		if IsPlayerSpell(spellID) then return true end
	elseif IsSpellKnown and IsSpellKnown(spellID) then
		return true
	end
	if C_TradeSkillUI and C_TradeSkillUI.GetRecipeInfo then
		local recipe = C_TradeSkillUI.GetRecipeInfo(spellID)
		if recipe and recipe.learned then return true end
	end
	return false
end

-- A skill line's name in the client's language (C_SkillInfo by ID, else the
-- character's professions), or nil when the client does not say.
function Compat.GetSkillLineName(skillLine)
	if type(skillLine) ~= "number" then return nil end
	local S = C_SkillInfo
	if S and S.GetSkillLineInfoByID then
		local ok, info = pcall(S.GetSkillLineInfoByID, skillLine)
		local name = ok and type(info) == "table" and readable(info.name)
		if type(name) == "string" and name ~= "" then return name end
	end
	if GetProfessions and GetProfessionInfo then
		local profs = { GetProfessions() }
		for i = 1, 5 do
			if profs[i] then
				local pname, _, _, _, _, _, line = GetProfessionInfo(profs[i])
				if line == skillLine and type(pname) == "string" and pname ~= "" then return pname end
			end
		end
	end
	return nil
end

-- standingID (1 Hated .. 8 Exalted), value, barMin, barMax, name; nil for a
-- faction the character has no data for.
function Compat.GetFactionStanding(factionID)
	if not factionID then return nil end
	if C_Reputation and C_Reputation.GetFactionDataByID then
		local d = C_Reputation.GetFactionDataByID(factionID)
		if not (d and d.reaction) then return nil end
		return d.reaction, d.currentStanding or 0, d.currentReactionThreshold or 0, d.nextReactionThreshold or 0, d.name
	end
	if GetFactionInfoByID then
		local name, _, standingID, barMin, barMax, barValue = GetFactionInfoByID(factionID)
		if not standingID then return nil end
		return standingID, barValue or 0, barMin or 0, barMax or 0, name
	end
	return nil
end

-- Whether the map area at (x, y) in live-frame percent is discovered.
function Compat.IsAreaExploredAt(uiMapID, x, y)
	local M = C_MapExplorationInfo
	if not (M and M.GetExploredAreaIDsAtPosition and uiMapID and x and y) then return nil end
	local ids = M.GetExploredAreaIDsAtPosition(uiMapID, vec(x / 100, y / 100))
	return type(ids) == "table" and #ids > 0
end

-- Achievements, including Forever's Legacy Challenges (achievements under
-- the hood, read the same way by Blizzard_LegacySystem).
function Compat.GetAchievement(id)
	if not (id and GetAchievementInfo) then return nil end
	-- Completed counts only when this character earned it (the 13th return),
	-- as Forever's Legacy UI does; account-wide completion is not enough.
	local aid, name, _, completed, _, _, _, _, _, _, _, _, earnedByMe = GetAchievementInfo(id)
	if earnedByMe ~= nil then completed = completed and earnedByMe end
	if not aid then return nil end
	local criteria = {}
	local n = GetAchievementNumCriteria and GetAchievementNumCriteria(id) or 0
	if GetAchievementCriteriaInfo then
		for i = 1, n do
			local text, _, done, cur, max = GetAchievementCriteriaInfo(id, i)
			done = done and true or false
			cur, max = tonumber(cur) or 0, tonumber(max) or 0
			if max <= 0 then cur, max = done and 1 or 0, 1 end
			criteria[i] = { text = text or "", completed = done, cur = cur, max = max }
		end
	end
	return { completed = completed and true or false, name = name, criteria = criteria }
end
