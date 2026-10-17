-- The game world for Core tests: the player, the quest log, bags, NPCs, the
-- quest/gossip/trainer/merchant/taxi frames and C_Map with simple linear
-- bounds. Loaded after wow_stub.lua. Every helper changes state the way the
-- client would and fires the events the client fires.
--
--   local w = stub.world
--   w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
--   w.moveTo(1429, 47.6, 35.1)            -- live map position (0-100)
--   w.accept(7, { 10 })                    -- objectives: counts or { text, type, required }
--   w.progress(7, 1, 4)                    -- objective 1 at 4/10
--   w.turnIn(7)
--   w.repeatable[308] = true               -- a turn-in never flags it completed
--   w.complete({ 783, 7 })                 -- already turned in (no events): alts
--   w.setLevel(4); w.addItem(750, 2); w.bind("Goldshire"); w.setZone("Elwynn Forest", "Goldshire")
--   w.gossip(197, { available = { { questID = 7, title = "..." } }, active = { { questID = 783, isComplete = true } } })
--   w.questDetail(197, 7, { auto = false, pvp = false, objectives = { 10 } })
--   w.questProgress(197, 783); w.questComplete(197, 783, { choices = 2, money = 0 })
--   w.greeting(197, { active = {...}, available = {...} })
--   w.trainer(911); w.merchant(54); w.taxi(352, "Stormwind, Elwynn"); w.close()
--   w.calls                                -- { { "AcceptQuest", q }, { "GetQuestReward", q, choice }, ... }
--   w.learnSkill(171, "Alchemy", 1, 75); w.skillUp(171, 50)    -- SKILL_LINES_CHANGED + CHAT_MSG_SKILL
--   w.learnSpell(2330)                     -- spellbook spell (LEARNED_SPELL_IN_SKILL_LINE, SPELLS_CHANGED)
--   w.learnRecipe(2330)                    -- profession recipe (NEW_RECIPE_LEARNED)
--   w.setRep(72, "Stormwind", 5, 1500, 3000, 9000)  -- standing, value, barMin, barMax (UPDATE_FACTION)
--   w.addArea(1429, 40, 30, 60, 50, 87)    -- explorable rect (percent) -> areaID; w.explore(87)
--   w.addAchievement(9001, "Legacy: ...", { { "Kill 10", 10 }, ... }); w.criteria(9001, 1, 4)
--   w.unsupport("skill"|"spell"|"faction"|"explore"|"achievement")  -- remove that client API
--
-- Client-driven chains work like in game: AcceptQuest() accepts the open
-- quest, Select*Quest opens its detail/progress panel, CompleteQuest() opens
-- the reward panel, GetQuestReward() turns the quest in.

local world = {
	name = "Testchar",
	level = 1, xp = 0, xpMax = 400,
	race = "Human", raceName = "Human", raceID = 1,
	class = "WARRIOR", className = "Warrior", classID = 1,
	faction = "Alliance",
	guid = "Player-1-0000ABCD",
	map = nil, x = nil, y = nil,
	facing = 0,
	onTaxi = false,
	bindLocation = "Northshire Abbey",
	zone = "Elwynn Forest", subzone = "Northshire Valley",
	inInstance = false,
	indoors = false, -- IsIndoors(): in a cave, mine or building
	maps = {},
	log = {},
	completed = {},
	titles = {},
	items = {},
	units = {},
	taxiNodes = {},
	frame = nil,
	calls = {},
	choices = {}, -- questID -> reward choices offered on its reward panel
	repeatable = {}, -- questID -> true: a turn-in never flags it completed
	skills = {}, -- skillLine -> { name, rank, maxRank }
	spells = {}, -- spellbook spells
	recipes = {}, -- learned profession recipes
	factions = {}, -- factionID -> { name, standing, value, barMin, barMax }
	areas = {}, -- { map, x1, y1, x2, y2, id }
	explored = {}, -- areaID -> true
	achievements = {}, -- id -> { name, completed, criteria = { { text, cur, max, completed } } }
}
stub.world = world

local function fire(...) stub.fire(...) end
local function call(...) table.insert(world.calls, { ... }) end

local function npcGUID(id)
	return ("Creature-0-4372-0-17-%d-0000%06d"):format(id, id)
end
world.npcGUID = npcGUID

---------------------------------------------------------------------------
-- World helpers
---------------------------------------------------------------------------

-- b: { name, c, left, right, top, bottom, parent, mapType }. Bounds may be
-- omitted (a map the client cannot place); mapType defaults to 3 (Zone).
function world.addMap(id, b)
	world.maps[id] = {
		id = id, name = b.name, c = b.c, left = b.left, right = b.right, top = b.top, bottom = b.bottom,
		parent = b.parent, mapType = b.mapType,
	}
end

function world.moveTo(map, x, y)
	world.map, world.x, world.y = map, x, y
end

function world.setZone(zone, subzone)
	local newArea = zone ~= world.zone
	world.zone, world.subzone = zone, subzone or ""
	if newArea then fire("ZONE_CHANGED_NEW_AREA") end
	fire("ZONE_CHANGED")
end

function world.setLevel(level)
	world.level = level
	fire("PLAYER_LEVEL_UP", level, 0, 0, 0, 0, 0, 0, 0, 0)
	fire("PLAYER_XP_UPDATE", "player")
end

function world.addItem(id, n)
	world.items[id] = (world.items[id] or 0) + (n or 1)
	fire("BAG_UPDATE", 0)
	fire("BAG_UPDATE_DELAYED")
end

function world.bind(location)
	world.bindLocation = location
	fire("HEARTHSTONE_BOUND")
end

local function logChanged(q)
	fire("QUEST_LOG_UPDATE")
	fire("UNIT_QUEST_LOG_CHANGED", "player")
	if q then fire("QUEST_WATCH_UPDATE", q) end
end

local function normalize(objectives)
	local out = {}
	for i, o in ipairs(objectives or {}) do
		if type(o) == "number" then o = { required = o } end
		out[i] = {
			text = o.text or ("Objective " .. i),
			type = o.type or "monster",
			numRequired = o.required or 1,
			numFulfilled = o.fulfilled or 0,
		}
		out[i].finished = out[i].numFulfilled >= out[i].numRequired
	end
	return out
end

function world.accept(q, objectives, title)
	world.log[q] = { title = title or world.titles[q] or ("Quest " .. q), objectives = normalize(objectives) }
	fire("QUEST_ACCEPTED", q)
	logChanged()
end

function world.progress(q, i, n)
	local o = world.log[q].objectives[i]
	o.numFulfilled = n
	o.finished = n >= o.numRequired
	logChanged(q)
end

function world.finish(q)
	for _, o in ipairs(world.log[q].objectives) do
		o.numFulfilled, o.finished = o.numRequired, true
	end
	logChanged(q)
end

function world.turnIn(q, xp, money)
	world.log[q] = nil
	if not world.repeatable[q] then world.completed[q] = true end
	fire("QUEST_TURNED_IN", q, xp or 0, money or 0)
	fire("QUEST_REMOVED", q, false)
	logChanged()
end

function world.abandon(q)
	world.log[q] = nil
	fire("QUEST_REMOVED", q, false)
	logChanged()
end

-- Already turned in before this session (no events).
function world.complete(list)
	for _, q in ipairs(list) do world.completed[q] = true end
end

-- Already in the log before this session (no events).
function world.onQuest(q, objectives, title)
	world.log[q] = { title = title or world.titles[q] or ("Quest " .. q), objectives = normalize(objectives) }
end

local function questReady(q)
	local e = world.log[q]
	if not e then return false end
	for _, o in ipairs(e.objectives) do
		if not o.finished then return false end
	end
	return true
end

---------------------------------------------------------------------------
-- NPC frames
---------------------------------------------------------------------------

local function talkTo(npc)
	world.units.npc = npc and npcGUID(npc) or nil
end

function world.gossip(npc, opts)
	talkTo(npc)
	opts = opts or {}
	world.frame = { kind = "gossip", npc = npc, available = opts.available or {}, active = opts.active or {} }
	fire("GOSSIP_SHOW")
end

function world.greeting(npc, opts)
	talkTo(npc)
	opts = opts or {}
	world.frame = { kind = "greeting", npc = npc, available = opts.available or {}, active = opts.active or {} }
	fire("QUEST_GREETING")
end

function world.questDetail(npc, q, opts)
	talkTo(npc)
	opts = opts or {}
	world.frame = { kind = "detail", npc = npc, questID = q, auto = opts.auto, pvp = opts.pvp, objectives = opts.objectives, title = opts.title }
	fire("QUEST_DETAIL", opts.startItem)
end

-- opts.completable: the window's own word, for a quest handed in without ever
-- being accepted (a give-item quest, which is never in the log). Left out, the
-- quest log decides, as for a quest taken the usual way.
function world.questProgress(npc, q, opts)
	talkTo(npc)
	opts = opts or {}
	world.frame = { kind = "progress", npc = npc, questID = q, completable = opts.completable }
	fire("QUEST_PROGRESS")
end

function world.questComplete(npc, q, opts)
	talkTo(npc)
	opts = opts or {}
	world.frame = { kind = "complete", npc = npc, questID = q, choices = opts.choices or world.choices[q] or 0, money = opts.money or 0 }
	fire("QUEST_COMPLETE")
end

function world.trainer(npc)
	talkTo(npc)
	world.frame = { kind = "trainer", npc = npc }
	fire("TRAINER_SHOW")
end

function world.merchant(npc)
	talkTo(npc)
	world.frame = { kind = "merchant", npc = npc }
	fire("MERCHANT_SHOW")
end

-- Opens the flight map at `current` (a node name); `others` are reachable nodes.
function world.taxi(npc, current, others)
	talkTo(npc)
	world.taxiNodes = { { name = current, type = "CURRENT" } }
	for _, name in ipairs(others or {}) do table.insert(world.taxiNodes, { name = name, type = "REACHABLE" }) end
	world.frame = { kind = "taxi", npc = npc }
	fire("TAXIMAP_OPENED", 0)
end

---------------------------------------------------------------------------
-- Professions, spells, reputation, exploration, achievements
---------------------------------------------------------------------------

function world.learnSkill(line, name, rank, maxRank)
	world.skills[line] = { name = name, rank = rank or 1, maxRank = maxRank or 75 }
	fire("SKILL_LINES_CHANGED")
end

function world.skillUp(line, rank, maxRank)
	local s = world.skills[line]
	s.rank = rank
	if maxRank then s.maxRank = maxRank end
	fire("CHAT_MSG_SKILL", ("Your skill in %s has increased to %d."):format(s.name, rank))
	fire("SKILL_LINES_CHANGED")
end

function world.learnSpell(id)
	world.spells[id] = true
	fire("LEARNED_SPELL_IN_SKILL_LINE", id, 1, false)
	fire("SPELLS_CHANGED")
end

function world.learnRecipe(id)
	world.recipes[id] = true
	fire("NEW_RECIPE_LEARNED", id)
end

function world.setRep(id, name, standing, value, barMin, barMax)
	world.factions[id] = { name = name, standing = standing, value = value or 0, barMin = barMin or 0, barMax = barMax or 3000 }
	fire("CHAT_MSG_COMBAT_FACTION_CHANGE", ("Reputation with %s increased."):format(name))
	fire("UPDATE_FACTION")
end

function world.addArea(map, x1, y1, x2, y2, id)
	table.insert(world.areas, { map = map, x1 = x1, y1 = y1, x2 = x2, y2 = y2, id = id })
end

function world.explore(id)
	world.explored[id] = true
	fire("MAP_EXPLORATION_UPDATED")
end

-- criteria: { { text, max }, ... }
function world.addAchievement(id, name, criteria)
	local list = {}
	for i, c in ipairs(criteria or {}) do
		list[i] = { text = c[1], cur = 0, max = c[2] or 1, completed = false }
	end
	world.achievements[id] = { name = name, completed = false, criteria = list }
end

function world.criteria(id, i, cur)
	local a = world.achievements[id]
	local c = a.criteria[i]
	c.cur = cur
	c.completed = cur >= c.max
	fire("CRITERIA_UPDATE")
	local all = true
	for _, x in ipairs(a.criteria) do
		if not x.completed then all = false end
	end
	if all and not a.completed then
		a.completed = true
		fire("ACHIEVEMENT_EARNED", id, false)
	end
end

-- Simulate a client build without one feature's API.
function world.unsupport(feature)
	if feature == "skill" then C_SkillInfo, GetProfessions, GetProfessionInfo = nil, nil, nil
	elseif feature == "spell" then C_SpellBook, IsPlayerSpell, IsSpellKnown, C_TradeSkillUI = nil, nil, nil, nil
	elseif feature == "faction" then C_Reputation, GetFactionInfoByID = nil, nil
	elseif feature == "explore" then C_MapExplorationInfo = nil
	elseif feature == "achievement" then GetAchievementInfo, GetAchievementNumCriteria, GetAchievementCriteriaInfo = nil, nil, nil
	end
end

function world.close()
	local f = world.frame
	world.frame = nil
	world.units.npc = nil
	if not f then return end
	if f.kind == "gossip" then fire("GOSSIP_CLOSED", false)
	elseif f.kind == "trainer" then fire("TRAINER_CLOSED")
	elseif f.kind == "merchant" then fire("MERCHANT_CLOSED")
	elseif f.kind == "taxi" then fire("TAXIMAP_CLOSED")
	else fire("QUEST_FINISHED") end
end

---------------------------------------------------------------------------
-- Client API: player
---------------------------------------------------------------------------

function UnitLevel(unit) if unit == "player" then return world.level end return 0 end
function UnitXP(unit) if unit == "player" then return world.xp end return 0 end
function UnitXPMax(unit) if unit == "player" then return world.xpMax end return 0 end
function UnitRace(unit) if unit == "player" then return world.raceName, world.race, world.raceID end end
function UnitClass(unit) if unit == "player" then return world.className, world.class, world.classID end end
function UnitFactionGroup(unit) if unit == "player" then return world.faction, world.faction end end
function UnitGUID(unit)
	if unit == "player" then return world.guid end
	return world.units[unit]
end
function UnitOnTaxi(unit) return unit == "player" and world.onTaxi or false end
function IsIndoors() return world.indoors end
function UnitAffectingCombat(unit) return unit == "player" and stub.inCombat or false end
function GetZoneText() return world.zone or "" end
function GetRealZoneText() return world.zone or "" end
function GetSubZoneText() return world.subzone or "" end
function GetMinimapZoneText() return (world.subzone ~= "" and world.subzone) or world.zone or "" end
function GetBindLocation() return world.bindLocation or "" end
function GetPlayerFacing() if world.inInstance then return nil end return world.facing end
function IsInInstance() return world.inInstance, world.inInstance and "party" or "none" end

---------------------------------------------------------------------------
-- Client API: quest log, items
---------------------------------------------------------------------------

C_QuestLog = {}
function C_QuestLog.IsQuestFlaggedCompleted(q) return world.completed[q] == true end
function C_QuestLog.IsOnQuest(q) return world.log[q] ~= nil end
function C_QuestLog.IsComplete(q) return questReady(q) end
function C_QuestLog.ReadyForTurnIn(q) return questReady(q) end
function C_QuestLog.GetTitleForQuestID(q)
	local e = world.log[q]
	return (e and e.title) or world.titles[q]
end
function C_QuestLog.GetQuestObjectives(q)
	local e = world.log[q]
	if not e then return {} end
	local out = {}
	for i, o in ipairs(e.objectives) do
		out[i] = { text = o.text, type = o.type, finished = o.finished, numFulfilled = o.numFulfilled, numRequired = o.numRequired }
	end
	return out
end
-- The log's entries in order (QuestLogDocumentation.lua GetNumQuestLogEntries,
-- GetInfo): quests by id, no headers.
local function logIDs()
	local ids = {}
	for q in pairs(world.log) do ids[#ids + 1] = q end
	table.sort(ids)
	return ids
end
function C_QuestLog.GetNumQuestLogEntries()
	local n = #logIDs()
	return n, n
end
function C_QuestLog.GetInfo(i)
	local q = logIDs()[i]
	if q then return { questID = q, isHeader = false, title = world.log[q].title } end
end

C_Item = {}
function C_Item.GetItemCount(id) return world.items[id] or 0 end
GetItemCount = C_Item.GetItemCount

---------------------------------------------------------------------------
-- Client API: maps
---------------------------------------------------------------------------

C_Map = {}
local function worldOf(map, mx, my)
	local b = world.maps[map]
	if not (b and b.left) then return nil end
	return b.c, b.top + (b.bottom - b.top) * my, b.left + (b.right - b.left) * mx
end

function C_Map.GetBestMapForUnit(unit)
	if unit ~= "player" or world.inInstance then return nil end
	return world.map
end

function C_Map.GetPlayerMapPosition(map, unit)
	if unit ~= "player" or not world.map or world.inInstance then return nil end
	if map == world.map then return CreateVector2D(world.x / 100, world.y / 100) end
	local c, wx, wy = worldOf(world.map, world.x / 100, world.y / 100)
	local b = world.maps[map]
	if not c or not b or not b.left or b.c ~= c then return nil end
	return CreateVector2D((wy - b.left) / (b.right - b.left), (wx - b.top) / (b.bottom - b.top))
end

function C_Map.GetWorldPosFromMapPos(map, pos)
	local c, wx, wy = worldOf(map, pos.x, pos.y)
	if not c then return nil end
	return c, CreateVector2D(wx, wy)
end

function C_Map.GetMapPosFromWorldPos(c, pos, override)
	local b = world.maps[override]
	if not b or not b.left or b.c ~= c then return nil end
	return override, CreateVector2D((pos.y - b.left) / (b.right - b.left), (pos.x - b.top) / (b.bottom - b.top))
end

function C_Map.GetMapInfo(map)
	local b = world.maps[map]
	if not b then return nil end
	return { mapID = map, name = b.name, mapType = b.mapType or 3, parentMapID = b.parent or 0 }
end

---------------------------------------------------------------------------
-- Client API: taxi
---------------------------------------------------------------------------

function NumTaxiNodes() return #world.taxiNodes end
function TaxiNodeGetType(i) local n = world.taxiNodes[i]; return n and n.type or "NONE" end
function TaxiNodeName(i) local n = world.taxiNodes[i]; return n and n.name or "" end

---------------------------------------------------------------------------
-- Client API: quest frame (Mainline-family QuestFrame functions)
---------------------------------------------------------------------------

local function frameOf(kind)
	local f = world.frame
	if f and (not kind or f.kind == kind) then return f end
end

function GetQuestID()
	local f = world.frame
	return f and f.questID or 0
end
function GetTitleText() local f = world.frame; return f and f.title or "" end
function QuestGetAutoAccept() local f = frameOf("detail"); return f and f.auto or false end
function QuestFlagsPVP() local f = frameOf("detail"); return f and f.pvp or false end

local function acceptOpen(name)
	local f = frameOf("detail")
	call(name, f and f.questID)
	if not f then return end
	world.close()
	world.accept(f.questID, f.objectives, f.title)
end
function AcceptQuest() acceptOpen("AcceptQuest") end
function AcknowledgeAutoAcceptQuest() acceptOpen("AcknowledgeAutoAcceptQuest") end
function DeclineQuest() call("DeclineQuest"); world.close() end
function CloseQuest() world.close() end

function IsQuestCompletable()
	local f = frameOf("progress")
	if not f then return false end
	if f.completable ~= nil then return f.completable and true or false end
	return questReady(f.questID)
end
function CompleteQuest()
	local f = frameOf("progress")
	call("CompleteQuest", f and f.questID)
	if f then world.questComplete(f.npc, f.questID) end
end
function GetNumQuestChoices() local f = frameOf("complete"); return f and f.choices or 0 end
function GetQuestMoneyToGet() local f = frameOf("complete"); return f and f.money or 0 end
function GetQuestReward(choice)
	local f = frameOf("complete")
	call("GetQuestReward", f and f.questID, choice)
	if not f then return end
	world.close()
	world.turnIn(f.questID)
end

-- Greeting panel: active quests first, then available ones (1-based each).
function GetNumActiveQuests() local f = frameOf("greeting"); return f and #f.active or 0 end
function GetNumAvailableQuests() local f = frameOf("greeting"); return f and #f.available or 0 end
function GetActiveTitle(i)
	local q = frameOf("greeting").active[i]
	return q.title or ("Quest " .. q.questID), q.isComplete and true or false
end
function GetActiveQuestID(i) return frameOf("greeting").active[i].questID end
function GetAvailableTitle(i)
	local q = frameOf("greeting").available[i]
	return q.title or ("Quest " .. q.questID)
end
function GetAvailableQuestInfo(i)
	local q = frameOf("greeting").available[i]
	-- isTrivial, frequency, isRepeatable, isLegendary, questID, isImportant, isMeta, questInfoID
	return false, 0, false, false, q.questID, false, false, 0
end
local function openFromGreeting(f, q, active)
	if active then world.questProgress(f.npc, q.questID)
	else world.questDetail(f.npc, q.questID, { objectives = q.objectives, title = q.title }) end
end
function SelectActiveQuest(i)
	local f = frameOf("greeting")
	local q = f.active[i]
	call("SelectActiveQuest", q.questID, i)
	openFromGreeting(f, q, true)
end
function SelectAvailableQuest(i)
	local f = frameOf("greeting")
	local q = f.available[i]
	call("SelectAvailableQuest", q.questID, i)
	openFromGreeting(f, q, false)
end

---------------------------------------------------------------------------
-- Client API: gossip
---------------------------------------------------------------------------

C_GossipInfo = {}
local function gossipList(key)
	local f = frameOf("gossip")
	local out = {}
	for i, q in ipairs(f and f[key] or {}) do
		out[i] = {
			title = q.title or ("Quest " .. q.questID), questLevel = q.questLevel or 1, isTrivial = false,
			isComplete = q.isComplete and true or false, isLegendary = false, isIgnored = false,
			questID = q.questID, isImportant = false, isMeta = false, questInfoID = 0,
		}
	end
	return out
end
function C_GossipInfo.GetAvailableQuests() return gossipList("available") end
function C_GossipInfo.GetActiveQuests() return gossipList("active") end
function C_GossipInfo.GetNumAvailableQuests() return #gossipList("available") end
function C_GossipInfo.GetNumActiveQuests() return #gossipList("active") end
local function findIn(list, questID)
	for _, q in ipairs(list) do if q.questID == questID then return q end end
end
function C_GossipInfo.SelectAvailableQuest(questID)
	local f = frameOf("gossip")
	call("C_GossipInfo.SelectAvailableQuest", questID)
	local q = f and findIn(f.available, questID)
	if q then world.questDetail(f.npc, questID, { objectives = q.objectives, title = q.title }) end
end
function C_GossipInfo.SelectActiveQuest(questID)
	local f = frameOf("gossip")
	call("C_GossipInfo.SelectActiveQuest", questID)
	if f and findIn(f.active, questID) then world.questProgress(f.npc, questID) end
end
function C_GossipInfo.CloseGossip() world.close() end

---------------------------------------------------------------------------
-- Client API: skills, spells, reputation, exploration, achievements
-- (Forever: C_SkillInfo, C_SpellBook, C_TradeSkillUI, C_Reputation,
-- C_MapExplorationInfo, GetAchievementInfo/Criteria as Blizzard_LegacySystem uses)
---------------------------------------------------------------------------

C_SkillInfo = {}
local function skillAttributes(line, s)
	return {
		skillID = line, name = s.name, isHeader = false, isCollapsed = false, rank = s.rank, tempPoints = 0,
		modifier = 0, maxRank = s.maxRank, isAbandonable = true, stepCost = 0, rankCost = 0, minLevel = 0,
		costType = 0, parentSkillLineID = 0, skillLineCategoryID = 11, description = "",
	}
end
function C_SkillInfo.GetSkillLineInfoByID(line)
	local s = world.skills[line]
	if not s then
		-- The client answers for unknown lines with zero ranks.
		return skillAttributes(line, { name = "", rank = 0, maxRank = 0 })
	end
	return skillAttributes(line, s)
end
local function sortedLines()
	local ids = {}
	for id in pairs(world.skills) do ids[#ids + 1] = id end
	table.sort(ids)
	return ids
end
function C_SkillInfo.GetNumSkillLines() return #sortedLines() end
function C_SkillInfo.GetSkillLineInfo(i)
	local id = sortedLines()[i]
	return id and skillAttributes(id, world.skills[id]) or nil
end

C_SpellBook = {}
function C_SpellBook.IsSpellKnown(id) return world.spells[id] == true end

C_TradeSkillUI = {}
function C_TradeSkillUI.GetRecipeInfo(id)
	if world.recipes[id] == nil then return nil end
	return { recipeID = id, learned = world.recipes[id] == true }
end

C_Reputation = {}
function C_Reputation.GetFactionDataByID(id)
	local f = world.factions[id]
	if not f then return nil end
	return {
		factionID = id, name = f.name, description = "", reaction = f.standing,
		currentReactionThreshold = f.barMin, nextReactionThreshold = f.barMax, currentStanding = f.value,
		atWarWith = false, canToggleAtWar = false, isChild = false, isHeader = false, isHeaderWithRep = false,
		isCollapsed = false, isWatched = false, hasBonusRepGain = false, canSetInactive = false, isAccountWide = false,
	}
end

C_MapExplorationInfo = {}
function C_MapExplorationInfo.GetExploredAreaIDsAtPosition(map, pos)
	local x, y = pos.x * 100, pos.y * 100
	local out
	for _, a in ipairs(world.areas) do
		if a.map == map and world.explored[a.id] and x >= a.x1 and x <= a.x2 and y >= a.y1 and y <= a.y2 then
			out = out or {}
			out[#out + 1] = a.id
		end
	end
	return out
end

-- id, name, points, completed, month, day, year, description, flags, icon, rewardText, isGuild, wasEarnedByMe, earnedBy
-- a.account: earned by another character on the account only.
function GetAchievementInfo(id)
	local a = world.achievements[id]
	if not a then return nil end
	local completed = a.completed or a.account or false
	return id, a.name, 10, completed, nil, nil, nil, "", 0, 0, "", false, a.completed, ""
end
function GetAchievementNumCriteria(id)
	local a = world.achievements[id]
	return a and #a.criteria or 0
end
-- criteriaString, criteriaType, completed, quantity, reqQuantity, charName, flags, assetID, quantityString
function GetAchievementCriteriaInfo(id, i)
	local c = world.achievements[id].criteria[i]
	return c.text, 0, c.completed, c.cur, c.max, "Testchar", 0, 0, ("%d/%d"):format(c.cur, c.max)
end

return world
