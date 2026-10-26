-- The recorder's slice of the game world, on top of wow_stub.lua: the player,
-- maps and positions, the quest log, the quest/gossip frames' NPC, units and
-- deaths, loot windows, flight masters and talents.
--
--   stub.world                 mutable state (see W below)
--   stub.moveTo(x, y, map)     teleport the player (x, y in 0-100)
--   stub.creature(id, name)    -> a fresh creature GUID
--   stub.setUnit(token, guid, name, related)  e.g. "npc", "target"
--   stub.offerQuest(q, npcGuid, npcName)      open the quest detail frame
--   stub.acceptQuest(q, def)   def = { title, level, objectives = { { text, type, numRequired } } }
--   stub.setProgress(q, oi, n[, text])        set numFulfilled, fire quest log events
--   stub.turnIn(q, npcGuid, npcName, xp, money)
--   stub.abandon(q)
--   stub.unitDied(guid) / stub.partyKill(guid)
--   stub.serialize(value)      -> Lua source for a SavedVariables round trip

local W = {
	map = 1429,
	x = 0.5,
	y = 0.5,
	zone = "Elwynn Forest",
	subzone = "Northshire Valley",
	level = 1,
	xp = 0,
	moving = false,
	onTaxi = false,
	player = { name = "Testchar", race = "Human", class = "WARRIOR", faction = "Alliance", guid = "Player-1-00000001" },
	maps = {
		[947] = { name = "Azeroth", mapType = 1, parentMapID = 946 },
		[1415] = { name = "Eastern Kingdoms", mapType = 2, parentMapID = 947, c = 0, top = 4000, left = 4000, bottom = -16000, right = -4000, w = 8000, h = 20000 },
		[1429] = { name = "Elwynn Forest", mapType = 3, parentMapID = 1415, c = 0, top = 1800, left = 1100, bottom = -1666.67, right = -4100, w = 5200, h = 3466.67 },
		[1453] = { name = "Stormwind City", mapType = 3, parentMapID = 1429, c = 0, top = 1722.17, left = -7997.7, bottom = 564.11, right = -9733.2, w = 1735.5, h = 1158.06 },
	},
	quests = {}, -- questID -> { title, level, objectives = { ... } }
	log = {}, -- questIDs in log order
	completed = {},
	units = {}, -- token -> { guid, name, related }
	questID = 0, -- GetQuestID()
	gossip = { available = {}, active = {} },
	bind = "Northshire Abbey",
	loot = {}, -- slots: { name, count, item, quest, questID }
	rewards = {}, -- questID -> { total, base }; absent = not cached yet (0, 0)
	taxi = {}, -- { { nodeID, name, state, slotIndex } }
	talents = nil, -- { configID, treeIDs, groups = {...}, nodes = { [nodeID] = info }, entries = {...}, defs = {...} }
}
stub.world = W

local guidSerial = 0
function stub.creature(id, name)
	guidSerial = guidSerial + 1
	return ("Creature-0-4372-0-12-%d-%010X"):format(id, guidSerial), name
end

function stub.gameObject(id, name)
	guidSerial = guidSerial + 1
	return ("GameObject-0-4372-0-12-%d-%010X"):format(id, guidSerial), name
end

function stub.setUnit(token, guid, name, related)
	if guid == nil then
		W.units[token] = nil
	else
		W.units[token] = { guid = guid, name = name, related = related or false }
	end
end

function stub.moveTo(x, y, map)
	W.x, W.y = x / 100, y / 100
	if map then W.map = map end
end

---------------------------------------------------------------------------
-- Units and player
---------------------------------------------------------------------------

function UnitGUID(unit)
	if unit == "player" then return W.player.guid end
	local u = W.units[unit]
	return u and u.guid or nil
end
function UnitName(unit)
	if unit == "player" then return W.player.name end
	local u = W.units[unit]
	return u and u.name or nil
end
-- Game objects (quest boxes, wanted posters) are not units: UnitExists is
-- false for them even while UnitGUID/UnitName("npc") describe them.
function UnitExists(unit)
	if unit == "player" then return true end
	local u = W.units[unit]
	return u ~= nil and not u.guid:find("^GameObject%-")
end
-- Units may carry cls (UnitClassification), lvl and dead: stub.world.units.target.cls = "rare".
function UnitLevel(unit)
	if unit == "player" then return W.level end
	local u = W.units[unit]
	return u and u.lvl or 1
end
function UnitClassification(unit)
	local u = W.units[unit]
	return u and u.cls or "normal"
end
function UnitIsDead(unit)
	local u = W.units[unit]
	return u ~= nil and u.dead == true
end
function UnitXP() return W.xp end
function UnitXPMax() return W.xpMax or 400 end
function GetXPExhaustion() return W.rested end -- nil when not rested, as in the client
function GetMoney() return W.money or 0 end
function UnitAffectingCombat(unit) return unit == "player" and W.combat == true end
function UnitIsAFK(unit) return unit == "player" and W.afk == true end
function UnitIsDeadOrGhost(unit) return unit == "player" and W.dead == true end
function UnitRace() return W.player.race, W.player.race, 1 end
function UnitClass() return W.player.class:sub(1, 1) .. W.player.class:sub(2):lower(), W.player.class, 1 end
function UnitFactionGroup() return W.player.faction, W.player.faction end
function UnitOnTaxi() return W.onTaxi end
function IsPlayerMoving() return W.moving end
function GetRealZoneText() return W.zone end
function GetZoneText() return W.zone end
function GetSubZoneText() return W.subzone end
function GetBindLocation() return W.bind end
function issecretvalue() return false end
-- What a /psrec trail sample reads: world position with height (UnitPosition
-- from the map's world bounds and W.z; W.noUnitPosition for a client that
-- answers nil), facing, speed and movement flags.
function UnitPosition(unit)
	if unit ~= "player" or W.noUnitPosition or W.x == nil then return nil end
	local c, pos = C_Map.GetWorldPosFromMapPos(W.map, CreateVector2D(W.x, W.y))
	if not pos then return nil end
	return pos.x, pos.y, W.z or 0, c
end
function GetPlayerFacing() return W.facing end
function GetUnitSpeed(unit) if unit == "player" then return W.speed or 0, 7, 4.72, 4.72 end end
function IsMounted() return W.mounted == true end
function IsSwimming() return W.swimming == true end
function IsFalling() return W.falling == true end
function IsIndoors() return W.indoors == true end

---------------------------------------------------------------------------
-- Maps
---------------------------------------------------------------------------

C_Map = {}
function C_Map.GetBestMapForUnit(unit)
	if unit == "player" then return W.map end
end
function C_Map.GetPlayerMapPosition(map, unit)
	if unit ~= "player" or map ~= W.map or W.x == nil then return nil end
	return CreateVector2D(W.x, W.y)
end
function C_Map.GetMapInfo(map)
	local m = W.maps[map]
	if not m then return nil end
	return { mapID = map, name = m.name, mapType = m.mapType, parentMapID = m.parentMapID, flags = 0 }
end
function C_Map.GetMapWorldSize(map)
	local m = W.maps[map]
	if m and m.w then return m.w, m.h end
	return 0, 0
end
function C_Map.GetWorldPosFromMapPos(map, pos)
	local m = W.maps[map]
	if not m or not m.top then return nil end
	return m.c, CreateVector2D(m.top + (m.bottom - m.top) * pos.y, m.left + (m.right - m.left) * pos.x)
end
function C_Map.GetMapChildrenInfo(root, _, all)
	local out = {}
	local function walk(parent)
		local ids = {}
		for id, m in pairs(W.maps) do
			if m.parentMapID == parent then ids[#ids + 1] = id end
		end
		table.sort(ids)
		for _, id in ipairs(ids) do
			local m = W.maps[id]
			out[#out + 1] = { mapID = id, name = m.name, mapType = m.mapType, parentMapID = m.parentMapID, flags = 0 }
			if all then walk(id) end
		end
	end
	walk(root)
	return out
end
function C_Map.GetFallbackWorldMapID() return 947 end

---------------------------------------------------------------------------
-- Quest log
---------------------------------------------------------------------------

local function logIndex(q)
	for i, id in ipairs(W.log) do
		if id == q then return i end
	end
end

local function ready(q)
	local def = W.quests[q]
	if not def then return false end
	for _, o in ipairs(def.objectives) do
		if o.numFulfilled < o.numRequired then return false end
	end
	return true
end

C_QuestLog = {}
function C_QuestLog.GetNumQuestLogEntries() return #W.log, #W.log end
function C_QuestLog.GetInfo(i)
	local q = W.log[i]
	local def = q and W.quests[q]
	if not def then return nil end
	return { title = def.title, questLogIndex = i, questID = q, level = def.level, difficultyLevel = def.level, isHeader = false }
end
function C_QuestLog.GetLogIndexForQuestID(q) return logIndex(q) end
function C_QuestLog.GetTitleForQuestID(q)
	local def = W.quests[q]
	return def and def.title or nil
end
function C_QuestLog.IsOnQuest(q) return logIndex(q) ~= nil end
function C_QuestLog.GetQuestObjectives(q)
	local def = logIndex(q) and W.quests[q]
	if not def then return nil end
	local out = {}
	for i, o in ipairs(def.objectives) do
		out[i] = {
			text = o.text:gsub("%%d", tostring(o.numFulfilled), 1):gsub("%%d", tostring(o.numRequired), 1),
			type = o.type,
			finished = o.numFulfilled >= o.numRequired,
			numFulfilled = o.numFulfilled,
			numRequired = o.numRequired,
		}
	end
	return out
end
function C_QuestLog.IsComplete(q) return logIndex(q) ~= nil and ready(q) end
function C_QuestLog.ReadyForTurnIn(q) return logIndex(q) ~= nil and ready(q) end
function C_QuestLog.IsQuestFlaggedCompleted(q) return W.completed[q] == true end
function C_QuestLog.UnitIsRelatedToActiveQuest(unit)
	local u = W.units[unit]
	return u ~= nil and u.related == true
end
function GetQuestID() return W.questID end
function GetTitleText()
	local def = W.quests[W.questID]
	return def and def.title or ""
end

-- Objective texts use %d placeholders: "Kobold Vermin slain: %d/%d".
function stub.acceptQuest(q, def)
	def = def or {}
	local objectives = {}
	for i, o in ipairs(def.objectives or {}) do
		objectives[i] = { text = o.text, type = o.type or "monster", numFulfilled = o.numFulfilled or 0, numRequired = o.numRequired or 1 }
	end
	W.quests[q] = { title = def.title or ("Quest " .. q), level = def.level or 1, objectives = objectives }
	W.log[#W.log + 1] = q
	stub.fire("QUEST_ACCEPTED", q)
	stub.fire("QUEST_LOG_UPDATE")
	stub.runTimers()
end

function stub.offerQuest(q, npcGuid, npcName, title)
	W.questID = q
	if title then W.quests[q] = W.quests[q] or { title = title, level = 1, objectives = {} } end
	stub.setUnit("npc", npcGuid, npcName)
	stub.fire("QUEST_DETAIL")
end

-- Forever's UI calls this global (not in the API docs); 0, 0 while the
-- reward is not cached.
function GetQuestLogRewardXP(q)
	local r = W.rewards[q]
	if not r then return 0, 0 end
	return r[1], r[2]
end

function stub.setProgress(q, oi, n)
	W.quests[q].objectives[oi].numFulfilled = n
	stub.fire("QUEST_LOG_UPDATE")
	stub.fire("UNIT_QUEST_LOG_CHANGED", "player")
	stub.advance(0.2)
end

local function removeFromLog(q)
	local i = logIndex(q)
	if i then table.remove(W.log, i) end
end

function stub.turnIn(q, npcGuid, npcName, xp, money)
	W.questID = q
	stub.setUnit("npc", npcGuid, npcName)
	stub.fire("QUEST_PROGRESS")
	stub.fire("QUEST_COMPLETE")
	W.completed[q] = true
	removeFromLog(q)
	stub.fire("QUEST_TURNED_IN", q, xp or 0, money or 0)
	stub.fire("QUEST_REMOVED", q, false)
	stub.fire("QUEST_FINISHED")
	stub.setUnit("npc", nil)
	stub.advance(1.5)
end

function stub.abandon(q)
	removeFromLog(q)
	stub.fire("QUEST_REMOVED", q, false)
	stub.fire("QUEST_LOG_UPDATE")
	stub.advance(1.5)
end

---------------------------------------------------------------------------
-- Deaths
---------------------------------------------------------------------------

function stub.unitDied(guid) stub.fire("UNIT_DIED", guid) end
function stub.partyKill(guid) stub.fire("PARTY_KILL", W.player.guid, guid) end

---------------------------------------------------------------------------
-- Gossip, loot, taxi
---------------------------------------------------------------------------

C_GossipInfo = {}
function C_GossipInfo.GetAvailableQuests()
	local out = {}
	for i, q in ipairs(W.gossip.available) do out[i] = { questID = q, title = "Quest " .. q, questLevel = 1 } end
	return out
end
function C_GossipInfo.GetActiveQuests()
	local out = {}
	for i, q in ipairs(W.gossip.active) do out[i] = { questID = q, title = "Quest " .. q, questLevel = 1 } end
	return out
end

-- Loot slots: { name, count, item, quest, questID, src = { guid, n, guid, n, ... } }.
function GetNumLootItems() return #W.loot end
function GetLootSlotInfo(slot)
	local l = W.loot[slot]
	if not l then return nil end
	return 134400, l.name, l.count or 1, nil, 1, false, l.quest or false, l.questID, true, false
end
function GetLootSlotLink(slot)
	local l = W.loot[slot]
	if not l or not l.item then return nil end
	return ("|cffffffff|Hitem:%d::::::::1:::::|h[%s]|h|r"):format(l.item, l.name)
end
function GetLootSourceInfo(slot)
	local l = W.loot[slot]
	if not (l and l.src) then return end
	return unpack(l.src)
end
-- W.lootable[guid] = { hasLoot, canLoot } (absent: nothing to loot, and free to)
function CanLootUnit(guid)
	local l = W.lootable and W.lootable[guid]
	if not l then return false, true end
	return l[1], l[2]
end

-- W.instance = { id, name, kind = "party" | "raid", diff } while inside one.
function GetInstanceInfo()
	local i = W.instance
	if not i then return W.zone, "none", 0, "", 0, 0, false, 0, 0, nil end
	return i.name, i.kind or "party", i.diff or 1, "Normal", 5, 0, false, i.id, 5, nil
end

C_TaxiMap = {}
function C_TaxiMap.GetAllTaxiNodes()
	local out = {}
	for i, n in ipairs(W.taxi) do
		out[i] = { nodeID = n.nodeID, name = n.name, state = n.state, slotIndex = n.slotIndex or i }
	end
	return out
end
function TaxiNodeName(slot)
	for _, n in ipairs(W.taxi) do
		if (n.slotIndex or 0) == slot then return n.name end
	end
	return ""
end
function TakeTaxiNode(slot) W.tookTaxi = slot end

---------------------------------------------------------------------------
-- Talents (a trait tree, as Forever exposes them)
---------------------------------------------------------------------------

-- Trait trees: W.talents (the class tree) and W.trees[treeID] (Legacy trees:
-- { configID, nodes = { [nodeID] = info }, groups, currency }).
local function treeOf(treeID)
	if W.trees and W.trees[treeID] then return W.trees[treeID] end
	return W.talents
end

C_ClassTalents = {}
function C_ClassTalents.GetActiveConfigID() return W.talents and W.talents.configID or nil end
C_Traits = {}
function C_Traits.GetConfigInfo(id)
	local t = W.talents
	if not t or id ~= t.configID then return nil end
	return { ID = id, type = 1, name = "Active", treeIDs = t.treeIDs, usesSharedActionBars = false }
end
function C_Traits.GetTreeNodes(treeID)
	local t = treeOf(treeID)
	local ids = {}
	if t then
		for id in pairs(t.nodes) do ids[#ids + 1] = id end
	end
	table.sort(ids)
	return ids
end
function C_Traits.GetNodeInfo(_, nodeID)
	if W.talents and W.talents.nodes[nodeID] then return W.talents.nodes[nodeID] end
	for _, t in pairs(W.trees or {}) do
		if t.nodes[nodeID] then return t.nodes[nodeID] end
	end
end
function C_Traits.GetEntryInfo(_, entryID) return W.talents and W.talents.entries[entryID] end
function C_Traits.GetDefinitionInfo(defID) return W.talents and W.talents.defs[defID] end
function C_Traits.GetGroupDisplayInfoByTreeID(treeID)
	local t = treeOf(treeID)
	return t and t.groups or {}
end
function C_Traits.GetConfigIDByTreeID(treeID)
	local t = W.trees and W.trees[treeID]
	return t and t.configID or nil
end
function C_Traits.GetTreeCurrencyInfo(_, treeID)
	local t = W.trees and W.trees[treeID]
	return t and t.currency or {}
end
function C_Traits.GetTraitCurrencyForAchievement(currencyID, achievementID)
	local a = W.achievements and W.achievements.list[achievementID]
	if currencyID ~= 4225 or not a then return 0 end
	return a.legacyPoints or 0
end

C_Spell = {}
W.spells = {}
function C_Spell.GetSpellName(id)
	local spells = W.talents and W.talents.spells
	return (spells and spells[id]) or W.spells[id]
end

---------------------------------------------------------------------------
-- Collapsible lists (reputation, skills). Rows: { depth = 0|1|2, isHeader,
-- isCollapsed, legacy, ... }; a collapsed header hides the deeper rows below
-- it, legacy rows show only while legacy reputations are shown.
---------------------------------------------------------------------------

W.factions = {}
W.showLegacyRep = false
W.skills = {}

local function visible(rows, legacyShown)
	local out, hideBelow = {}, nil
	for _, r in ipairs(rows) do
		if hideBelow and r.depth > hideBelow then
			-- hidden by a collapsed header
		elseif r.legacy and not legacyShown then
			hideBelow = nil
		else
			hideBelow = nil
			out[#out + 1] = r
			if r.isHeader and r.isCollapsed then hideBelow = r.depth end
		end
	end
	return out
end

local function copyRow(r)
	local c = {}
	for k, v in pairs(r) do c[k] = v end
	return c
end

C_Reputation = {}
local function factionRows() return visible(W.factions, W.showLegacyRep) end
function C_Reputation.GetNumFactions() return #factionRows() end
function C_Reputation.GetFactionDataByIndex(i)
	local r = factionRows()[i]
	return r and copyRow(r) or nil
end
function C_Reputation.GetFactionDataByID(id)
	for _, r in ipairs(W.factions) do
		if r.factionID == id then return copyRow(r) end
	end
end
function C_Reputation.ExpandFactionHeader(i) local r = factionRows()[i]; if r then r.isCollapsed = false end end
function C_Reputation.CollapseFactionHeader(i) local r = factionRows()[i]; if r then r.isCollapsed = true end end
function C_Reputation.AreLegacyReputationsShown() return W.showLegacyRep end
function C_Reputation.SetLegacyReputationsShown(v) W.showLegacyRep = v and true or false end

-- Adds a faction row. f = { id, name, depth, header, collapsed, child, headerRep, reaction, value, min, max, legacy, atWar }
function stub.faction(f)
	W.factions[#W.factions + 1] = {
		factionID = f.id, name = f.name, depth = f.depth or 0, isHeader = f.header or false, isCollapsed = f.collapsed or false,
		isChild = f.child or false, isHeaderWithRep = f.headerRep or false, reaction = f.reaction or 4,
		currentStanding = f.value or 0, currentReactionThreshold = f.min or 0, nextReactionThreshold = f.max or 3000,
		atWarWith = f.atWar or false, canToggleAtWar = f.canToggle or false, isAccountWide = false, legacy = f.legacy,
		description = "", isWatched = false, hasBonusRepGain = false, canSetInactive = false,
	}
end
function stub.setRep(id, value, reaction)
	for _, r in ipairs(W.factions) do
		if r.factionID == id then
			r.currentStanding = value
			if reaction then r.reaction = reaction end
		end
	end
end
function stub.collapsedFactions()
	local out = {}
	for _, r in ipairs(W.factions) do
		if r.isHeader and r.isCollapsed then out[#out + 1] = r.name end
	end
	return out
end

C_SkillInfo = {}
local function skillRows() return visible(W.skills, true) end
function C_SkillInfo.GetNumSkillLines() return #skillRows() end
function C_SkillInfo.GetSkillLineInfo(i)
	local r = skillRows()[i]
	return r and copyRow(r) or nil
end
function C_SkillInfo.GetSkillLineInfoByID(id)
	for _, r in ipairs(W.skills) do
		if r.skillID == id and not r.isHeader then return copyRow(r) end
	end
end
-- Like the client, toggling a header fires SKILL_LINES_CHANGED.
W.skillToggles = 0
local function toggleSkill(i, collapsed)
	local r = skillRows()[i]
	if not r then return end
	r.isCollapsed = collapsed
	W.skillToggles = W.skillToggles + 1
	stub.fire("SKILL_LINES_CHANGED")
end
function C_SkillInfo.ExpandSkillHeader(i) toggleSkill(i, false) end
function C_SkillInfo.CollapseSkillHeader(i) toggleSkill(i, true) end

-- s = { id, name, header, collapsed, rank, max, category }; `at` inserts at
-- that position of the full list (default: the end).
function stub.skill(s, at)
	table.insert(W.skills, at or #W.skills + 1, {
		skillID = s.id or 0, name = s.name, depth = s.header and 0 or 1, isHeader = s.header or false,
		isCollapsed = s.collapsed or false, rank = s.rank or 0, maxRank = s.max or 0, modifier = 0, tempPoints = 0,
		skillLineCategoryID = s.category or 0, parentSkillLineID = 0, description = "",
	})
end
function stub.setSkill(id, rank, max)
	for _, r in ipairs(W.skills) do
		if r.skillID == id and not r.isHeader then
			r.rank = rank
			if max then r.maxRank = max end
		end
	end
end

---------------------------------------------------------------------------
-- Exploration
---------------------------------------------------------------------------

W.areas = {} -- areaID -> name
W.explored = {} -- areaIDs explored at the player's position
ERR_ZONE_EXPLORED = "Discovered: %s"
ERR_ZONE_EXPLORED_XP = "Discovered %s: %d experience gained"
C_MapExplorationInfo = {}
function C_MapExplorationInfo.GetExploredAreaIDsAtPosition()
	local out = {}
	for i, id in ipairs(W.explored) do out[i] = id end
	return out
end
function C_Map.GetAreaInfo(id) return W.areas[id] end

---------------------------------------------------------------------------
-- Professions
---------------------------------------------------------------------------

W.recipes = {} -- spellID -> { output, quantity }
W.profession = nil -- professionID of the open tradeskill
C_TradeSkillUI = {}
function C_TradeSkillUI.GetRecipeInfo(spellID)
	local r = W.recipes[spellID]
	if not r then return nil end
	return { recipeID = spellID, name = "Recipe " .. spellID, learned = true, craftable = true }
end
function C_TradeSkillUI.GetRecipeSchematic(spellID)
	local r = W.recipes[spellID]
	return { recipeID = spellID, outputItemID = r and r.output, quantityMin = r and r.quantity or 1, quantityMax = 1, name = "", isRecraft = false }
end
function C_TradeSkillUI.GetChildProfessionInfo()
	return { professionID = W.profession or 0, professionName = "", skillLevel = 0, maxSkillLevel = 0 }
end
function C_TradeSkillUI.GetBaseProfessionInfo()
	return { professionID = W.profession or 0, professionName = "", skillLevel = 0, maxSkillLevel = 0 }
end

---------------------------------------------------------------------------
-- Achievements (Legacy challenges) and major factions
---------------------------------------------------------------------------

-- W.achievements = { categories = { { id, name, parent, achievements = { ids } } },
--   list = { [id] = { name, points, completed, description, flags, reward, legacyPoints, previous,
--   criteria = { { text, type, completed, quantity, required, flags, assetID, id } } } } }
W.achievements = { categories = {}, list = {} }
Constants = { LegacyConsts = {
	LEGACY_REWARD_TRACK_FACTION_ID = 2802, LEGACY_POINTS_TRAIT_CURRENCY_ID = 4225,
	LEGACY_TREE_PROFESSIONS_ID = 1187, LEGACY_TREE_ADVENTURE_ID = 1188, LEGACY_TREE_PROGRESSION_ID = 1189,
} }

local function category(id)
	for _, c in ipairs(W.achievements.categories) do
		if c.id == id then return c end
	end
end
function GetCategoryList()
	local out = {}
	for i, c in ipairs(W.achievements.categories) do out[i] = c.id end
	return out
end
function GetCategoryInfo(id)
	local c = category(id)
	if c then return c.name, c.parent or -1, 0 end
end
function GetCategoryNumAchievements(id)
	local c = category(id)
	if not c then return 0, 0, 0 end
	local done = 0
	for _, a in ipairs(c.achievements) do
		if W.achievements.list[a].completed then done = done + 1 end
	end
	return #c.achievements, done, #c.achievements - done
end
function GetAchievementInfo(a, b)
	local id = a
	if b then
		local c = category(a)
		id = c and c.achievements[b]
	end
	local x = id and W.achievements.list[id]
	if not x then return nil end
	return id, x.name, x.points or 10, x.completed or false, nil, nil, nil, x.description or "", x.flags or 0, 1, x.reward or "", false, x.completed or false, nil
end
function GetAchievementNumCriteria(id)
	local x = W.achievements.list[id]
	return x and #(x.criteria or {}) or 0
end
function GetAchievementCriteriaInfo(id, i)
	local c = W.achievements.list[id].criteria[i]
	return c.text, c.type or 0, c.completed or false, c.quantity or 0, c.required or 0, nil, c.flags or 0, c.assetID or 0, "", c.id or 0, true
end
function GetPreviousAchievement(id)
	local x = W.achievements.list[id]
	return x and x.previous or nil
end

-- W.majorFactions = { [id] = { name, level, maxLevel, earned, threshold, unlocked, levels = { { level, locked, milestone, rewards = { ... } } } } }
W.majorFactions = {}
C_MajorFactions = {}
function C_MajorFactions.GetMajorFactionIDs()
	local out = {}
	for id in pairs(W.majorFactions) do out[#out + 1] = id end
	table.sort(out)
	return out
end
function C_MajorFactions.GetMajorFactionData(id)
	local f = W.majorFactions[id]
	if not f then return nil end
	return { name = f.name, description = "", factionID = id, isUnlocked = f.unlocked or false, renownLevel = f.level or 0,
		maxLevel = f.maxLevel or 0, renownReputationEarned = f.earned or 0, renownLevelThreshold = f.threshold or 0 }
end
function C_MajorFactions.GetCurrentRenownLevel(id)
	local f = W.majorFactions[id]
	return f and f.level or 0
end
function C_MajorFactions.GetRenownLevels(id)
	local out = {}
	for i, l in ipairs(W.majorFactions[id].levels or {}) do
		out[i] = { factionID = id, level = l.level, locked = l.locked or false, isMilestone = l.milestone or false, isCapstone = false }
	end
	return out
end
function C_MajorFactions.GetRenownRewardsForLevel(id, level)
	for _, l in ipairs(W.majorFactions[id].levels or {}) do
		if l.level == level then return l.rewards or {} end
	end
	return {}
end

---------------------------------------------------------------------------
-- SavedVariables round trip
---------------------------------------------------------------------------

local function serialize(v, out)
	local t = type(v)
	if t == "table" then
		out[#out + 1] = "{"
		local keys = {}
		for k in pairs(v) do keys[#keys + 1] = k end
		table.sort(keys, function(a, b)
			if type(a) == type(b) then return a < b end
			return type(a) == "number"
		end)
		for _, k in ipairs(keys) do
			out[#out + 1] = "["
			serialize(k, out)
			out[#out + 1] = "]="
			serialize(v[k], out)
			out[#out + 1] = ","
		end
		out[#out + 1] = "}"
	elseif t == "string" then
		out[#out + 1] = ("%q"):format(v)
	elseif t == "number" then
		out[#out + 1] = ("%.17g"):format(v)
	elseif t == "boolean" then
		out[#out + 1] = tostring(v)
	else
		out[#out + 1] = "nil"
	end
end

function stub.serialize(v)
	local out = {}
	serialize(v, out)
	return table.concat(out)
end

-- Recording is opt-in. Recorder tests record unless they restore their own
-- DB (`saved` replaces this before ADDON_LOADED).
PolestarRecorderDB = { enabled = true }
