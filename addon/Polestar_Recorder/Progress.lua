-- Character progress (docs/RECORDING.md, "Services"): `rep`, `skill`,
-- `explore`, `craft` (only what the trade skill window makes), `learn`,
-- `achieve`.
--
-- Collapsed headers hide rows from C_Reputation / C_SkillInfo index scans.
-- The baseline scan expands every collapsed header (and shows legacy
-- reputations), reads every row, then puts the UI state back exactly as it
-- was. Changes between scans are diffed by ID (GetFactionDataByID /
-- GetSkillLineInfoByID), which works whatever is collapsed.

local ADDON, ns = ...

local type, pairs, ipairs, pcall, tostring, tonumber, GetTime = type, pairs, ipairs, pcall, tostring, tonumber, GetTime
local Num = ns.Num

local DIFF_DELAY = 0.2 -- coalesces bursts of UPDATE_FACTION / SKILL_LINES_CHANGED
local EXPLORE_WINDOW = 1 -- seconds to collect the discovery message and XP
local CRAFT_WINDOW = 1 -- seconds between a recipe cast and its crafted-item result

-- Per-session sets (explored areas, learned spells), empty at every session.
local sets = {}
local function sessionSet(name)
	if not ns.Recording() then return nil end
	local t = sets[name]
	if not t then
		t = {}
		sets[name] = t
	end
	return t
end

---------------------------------------------------------------------------
-- Full scans with expand-and-restore
---------------------------------------------------------------------------

-- Visits every row of an index-based, collapsible list. `api` provides
-- count(), row(i), expand(i), collapse(i), key(row). Collapsed headers are
-- expanded for the visit and collapsed again afterwards (bottom-up, so the
-- indices of earlier rows stay valid). Returns false when the visit errored.
local function visitAll(api, visit)
	local expanded = {}
	local i = 1
	while i <= api.count() do
		local row = api.row(i)
		if row and row.isHeader and row.isCollapsed then
			expanded[api.key(row)] = true
			api.expand(i)
		end
		i = i + 1
	end
	local ok, err = pcall(function()
		for j = 1, api.count() do
			local row = api.row(j)
			if row then visit(row, j) end
		end
	end)
	if next(expanded) then
		for j = api.count(), 1, -1 do
			local row = api.row(j)
			if row and row.isHeader and expanded[api.key(row)] then api.collapse(j) end
		end
	end
	if not ok then geterrorhandler()(err) end
	return ok
end

local factionAPI = {
	count = function() return C_Reputation.GetNumFactions() or 0 end,
	row = function(i) return C_Reputation.GetFactionDataByIndex(i) end,
	expand = function(i) C_Reputation.ExpandFactionHeader(i) end,
	collapse = function(i) C_Reputation.CollapseFactionHeader(i) end,
	key = function(row)
		if row.factionID and row.factionID ~= 0 then return row.factionID end
		return "name:" .. tostring(row.name)
	end,
}

local skillAPI = {
	count = function() return C_SkillInfo.GetNumSkillLines() or 0 end,
	row = function(i) return C_SkillInfo.GetSkillLineInfo(i) end,
	expand = function(i) C_SkillInfo.ExpandSkillHeader(i) end,
	collapse = function(i) C_SkillInfo.CollapseSkillHeader(i) end,
	key = function(row) return "name:" .. tostring(row.name) end,
}

local function hasFactionAPI()
	local R = C_Reputation
	return R and R.GetNumFactions and R.GetFactionDataByIndex and R.ExpandFactionHeader and R.CollapseFactionHeader and true or false
end

local function hasSkillAPI()
	local S = C_SkillInfo
	return S and S.GetNumSkillLines and S.GetSkillLineInfo and S.ExpandSkillHeader and S.CollapseSkillHeader and true or false
end

-- { [factionID] = { name, order, header, headerRep, parent, standing, value,
-- min, max, atWar, canToggleAtWar, accountWide } } and the row count, or nil.
function ns.ScanFactions()
	if not hasFactionAPI() then return nil end
	local R = C_Reputation
	local showLegacy = R.AreLegacyReputationsShown and R.SetLegacyReputationsShown and not R.AreLegacyReputationsShown()
	if showLegacy then R.SetLegacyReputationsShown(true) end
	local out, n = {}, 0
	local top, sub
	visitAll(factionAPI, function(d, i)
		local id = d.factionID
		local parent
		if d.isHeader and not d.isChild then
			top, sub = id, nil
		elseif d.isHeader then
			parent, sub = top, id
		elseif d.isChild and sub then
			parent = sub
		else
			parent = top
		end
		if not id or id == 0 then return end
		n = n + 1
		local f = { name = d.name, order = i, parent = parent, atWar = d.atWarWith or nil, canToggleAtWar = d.canToggleAtWar or nil, accountWide = d.isAccountWide or nil }
		if d.isHeader then
			f.header = true
			f.headerRep = d.isHeaderWithRep or nil
		end
		if not d.isHeader or d.isHeaderWithRep then
			f.standing, f.value = d.reaction, d.currentStanding
			f.min, f.max = d.currentReactionThreshold, d.nextReactionThreshold
		end
		out[id] = f
	end)
	if showLegacy then R.SetLegacyReputationsShown(false) end
	return out, n
end

-- { [skillLineID] = { name, order, rank, max, modifier, category, categoryID, parent } }
-- and the line count, or nil.
function ns.ScanSkills()
	if not hasSkillAPI() then return nil end
	local out, n = {}, 0
	local category
	visitAll(skillAPI, function(d, i)
		if d.isHeader then
			category = d.name
			return
		end
		if not d.skillID or d.skillID == 0 then return end
		n = n + 1
		out[d.skillID] = {
			name = d.name, order = i, rank = d.rank, max = d.maxRank,
			modifier = (d.modifier and d.modifier ~= 0) and d.modifier or nil,
			category = category,
			categoryID = (d.skillLineCategoryID and d.skillLineCategoryID ~= 0) and d.skillLineCategoryID or nil,
			parent = (d.parentSkillLineID and d.parentSkillLineID ~= 0) and d.parentSkillLineID or nil,
		}
	end)
	return out, n
end

---------------------------------------------------------------------------
-- Reputation changes
---------------------------------------------------------------------------

local repValues = {} -- factionID -> currentStanding
local repReady = false

local function repBaseline()
	local factions, n = ns.ScanFactions()
	if not factions or n == 0 then return end
	for id, f in pairs(factions) do
		if f.value then repValues[id] = f.value end
	end
	repReady = true
end

local function checkFaction(id)
	if not (C_Reputation and C_Reputation.GetFactionDataByID) or type(id) ~= "number" then return end
	local d = C_Reputation.GetFactionDataByID(id)
	if not d or (d.isHeader and not d.isHeaderWithRep) then return end
	local old, new = repValues[id], d.currentStanding
	if type(new) ~= "number" or old == new then return end
	repValues[id] = new
	if old == nil and not repReady then return end
	ns.Rec("rep", id, Num(d.reaction), new, old and new - old or nil)
end

local repQueued = false
local function repDiff()
	repQueued = false
	if not repReady then
		repBaseline()
		return
	end
	for id in pairs(repValues) do checkFaction(id) end
	-- factions met since the baseline show up in the (visible) list
	if hasFactionAPI() then
		for i = 1, C_Reputation.GetNumFactions() or 0 do
			local d = C_Reputation.GetFactionDataByIndex(i)
			if d and d.factionID and d.factionID ~= 0 and repValues[d.factionID] == nil then checkFaction(d.factionID) end
		end
	end
end

ns.On("FACTION_STANDING_CHANGED", function(_, factionID) checkFaction(factionID) end)
ns.On("UPDATE_FACTION", function()
	if repQueued then return end
	repQueued = true
	C_Timer.After(DIFF_DELAY, repDiff)
end)

---------------------------------------------------------------------------
-- Skill rank changes
---------------------------------------------------------------------------

local skillRanks = {} -- skillLineID -> { rank, max }
local skillReady = false

local function skillBaseline()
	local skills, n = ns.ScanSkills()
	if not skills or n == 0 then return end
	for id, s in pairs(skills) do skillRanks[id] = { rank = s.rank, max = s.max } end
	skillReady = true
end

local function checkSkill(id, d)
	d = d or (C_SkillInfo.GetSkillLineInfoByID and C_SkillInfo.GetSkillLineInfoByID(id))
	if not d or d.isHeader then return end
	local known = skillRanks[id]
	if known and known.rank == d.rank and known.max == d.maxRank then return end
	skillRanks[id] = { rank = d.rank, max = d.maxRank }
	if not known and not skillReady then return end
	if Num(d.rank) and Num(d.maxRank) then ns.Rec("skill", id, d.rank, d.maxRank) end
end

-- Known lines are re-read by ID, which works under collapsed headers. New
-- lines are found by the visible-row walk; when something says a skill was
-- learned (a learned spell, a skill chat message) the walk is the full
-- expand-and-restore scan, since a new profession usually lands under a
-- collapsed "Professions" or "Secondary Skills" header.
local skillQueued, skillFull, skillScanning = false, false, false
local function skillDiff()
	skillQueued = false
	local full = skillFull
	skillFull = false
	if not skillReady then
		skillBaseline()
		return
	end
	if not hasSkillAPI() then return end
	for id in pairs(skillRanks) do checkSkill(id) end
	if full then
		skillScanning = true
		local skills = ns.ScanSkills()
		skillScanning = false
		for id, s in pairs(skills or {}) do
			if not skillRanks[id] then checkSkill(id, { name = s.name, rank = s.rank, maxRank = s.max }) end
		end
		return
	end
	for i = 1, C_SkillInfo.GetNumSkillLines() or 0 do
		local d = C_SkillInfo.GetSkillLineInfo(i)
		if d and not d.isHeader and d.skillID and d.skillID ~= 0 and not skillRanks[d.skillID] then checkSkill(d.skillID, d) end
	end
end

local function queueSkills(full)
	if full then skillFull = true end
	if skillQueued then return end
	skillQueued = true
	C_Timer.After(DIFF_DELAY, skillDiff)
end
-- The full scan's own expand/collapse fires SKILL_LINES_CHANGED; ignore it.
ns.On("SKILL_LINES_CHANGED", function()
	if not skillScanning then queueSkills(false) end
end)
ns.On("CHAT_MSG_SKILL", function() queueSkills(true) end)
ns.On("LEARNED_SPELL_IN_SKILL_LINE", function() queueSkills(true) end)

ns.OnSession(function()
	sets = {}
	repValues, repReady = {}, false
	skillRanks, skillReady = {}, false
	repBaseline()
	skillBaseline()
end)

---------------------------------------------------------------------------
-- Exploration: MAP_EXPLORATION_UPDATED names no area, so the areas at the
-- player's position that this session has not recorded are the candidates.
-- A discovery is recorded only when something confirms it: the client's
-- discovery message ("Discovered %s: %d experience gained", which also names
-- the area and carries the XP), or an XP gain within a second that no kill or
-- quest turn-in explains. Unconfirmed updates (e.g. at login) only mark the
-- areas as seen.
---------------------------------------------------------------------------

local exploredXP, exploredPlain -- { pattern, args }, built on first use (global strings load late)
local function discoveryPatterns()
	if exploredXP == nil then
		local p, args = ns.FormatPattern(ERR_ZONE_EXPLORED_XP)
		exploredXP = p and { p = p, args = args } or false
	end
	if exploredPlain == nil then
		local p, args = ns.FormatPattern(ERR_ZONE_EXPLORED)
		exploredPlain = p and { p = p, args = args } or false
	end
	return exploredXP, exploredPlain
end

-- The format's arguments (in argument order) a text matches, or nil.
local function matchFormat(f, text)
	if not f then return nil end
	local caps = { text:match(f.p) }
	if not caps[1] then return nil end
	local v = {}
	for i, a in ipairs(f.args) do v[a] = caps[i] end
	return v
end

local pending -- { at, map, x, y, areas = { ids }, name, xp }
local lastXP, xpGain, xpGainAt, otherXPAt = nil, nil, -math.huge, -math.huge

local function areaName(id)
	if C_Map and C_Map.GetAreaInfo then return C_Map.GetAreaInfo(id) end
	return nil
end

-- Explored area ids at a position, or nil when the client cannot tell.
local function areasAt(map, x, y)
	if not (x and C_MapExplorationInfo and C_MapExplorationInfo.GetExploredAreaIDsAtPosition) then return nil end
	local ids = C_MapExplorationInfo.GetExploredAreaIDsAtPosition(map, CreateVector2D(x / 100, y / 100))
	if type(ids) ~= "table" then return nil end
	local out = {}
	for i = 1, #ids do out[i] = ids[i] end
	return out
end

local function finishExplore()
	local p = pending
	pending = nil
	if not p then return end
	local seen = sessionSet("explored")
	if not seen then return end
	-- The discovery message can come before the client has added the area,
	-- so read the explored areas again now that the window closes.
	local areas = areasAt(p.map, p.x, p.y) or p.areas
	local fresh = {}
	for _, id in ipairs(areas) do
		if not seen[id] then fresh[#fresh + 1] = id end
	end
	local xp = p.xp
	if not xp and xpGain and math.abs(xpGainAt - p.at) <= EXPLORE_WINDOW and math.abs(otherXPAt - xpGainAt) > EXPLORE_WINDOW then
		xp = xpGain
	end
	if not p.name and not xp then
		for _, id in ipairs(fresh) do seen[id] = true end
		return
	end
	if #fresh == 0 and not p.name then return end
	if p.name and seen["name:" .. p.name] then return end
	-- The area the message names (never another one, e.g. the parent zone);
	-- without a name, the last (innermost) new one.
	local areaID
	if p.name then
		for _, id in ipairs(fresh) do
			if areaName(id) == p.name then areaID = id end
		end
	else
		areaID = fresh[#fresh]
	end
	local name = p.name or (areaID and areaName(areaID)) or nil
	-- The record needs the area id; a name alone only marks it as seen.
	if not areaID or ns.Rec("explore", areaID, xp, ns.PAt(p.map, p.x, p.y)) then
		if p.name and areaID then
			-- other new ids here may belong to a second discovery in this window
			seen[areaID] = true
		else
			for _, id in ipairs(fresh) do seen[id] = true end
		end
		if name then seen["name:" .. name] = true end
	end
end

local function startExplore()
	if pending then return pending end
	local map, x, y = ns.Position()
	local p = { at = GetTime(), map = map, x = x, y = y, areas = areasAt(map, x, y) or {} }
	pending = p
	C_Timer.After(EXPLORE_WINDOW, function()
		if pending == p then finishExplore() end
	end)
	return p
end

ns.On("MAP_EXPLORATION_UPDATED", startExplore)

local function onMessage(text)
	if type(text) ~= "string" or not ns.Usable(text) then return end
	local withXP, plainMsg = discoveryPatterns()
	local v = matchFormat(withXP, text) or matchFormat(plainMsg, text)
	if not (v and v[1]) then return end
	local a, b = v[1], v[2]
	-- A second discovery inside the window is its own event.
	if pending and pending.name and pending.name ~= a then finishExplore() end
	local p = startExplore()
	p.name = a
	p.xp = tonumber(b)
end

ns.On("UI_INFO_MESSAGE", function(_, _, message) onMessage(message) end)
ns.On("CHAT_MSG_SYSTEM", function(_, text) onMessage(text) end)

ns.On("PLAYER_XP_UPDATE", function(_, unit)
	if unit ~= "player" then return end
	local xp = UnitXP("player")
	if lastXP and xp > lastXP then
		xpGain, xpGainAt = xp - lastXP, GetTime()
	end
	lastXP = xp
end)
local function otherXP() otherXPAt = GetTime() end
ns.On("CHAT_MSG_COMBAT_XP_GAIN", otherXP)
ns.On("QUEST_TURNED_IN", otherXP)

ns.OnSession(function()
	pending = nil
	lastXP = UnitXP and UnitXP("player") or nil
end)

---------------------------------------------------------------------------
-- Crafting: only what the player makes from the trade skill window. The
-- window must be open on the player's own profession (not a linked or guild
-- view, not an NPC's), the cast a recipe of that profession, and asked for
-- through C_TradeSkillUI.CraftRecipe / CraftEnchant (hooked). Combat
-- spells and forms, which GetRecipeInfo also answers for, never count. The
-- item and count come from TRADE_SKILL_ITEM_CRAFTED_RESULT, else the
-- recipe's schematic.
---------------------------------------------------------------------------

local crafts = {} -- casts waiting for their result: { spell, at, item, count }
local lastResult -- crafted-item result that arrived before its cast
local tradeOpen = false
local queued = {} -- recipeSpellID -> casts asked for and not yet made

local function professionID()
	local T = C_TradeSkillUI
	if not T then return nil end
	local info = T.GetChildProfessionInfo and T.GetChildProfessionInfo()
	if info and Num(info.professionID) and info.professionID ~= 0 then return info.professionID end
	info = T.GetBaseProfessionInfo and T.GetBaseProfessionInfo()
	if info and Num(info.professionID) and info.professionID ~= 0 then return info.professionID end
	return nil
end

local function ownWindow()
	local T = C_TradeSkillUI
	if not (tradeOpen and T) then return false end
	for _, name in ipairs({ "IsTradeSkillLinked", "IsTradeSkillGuild", "IsNPCCrafting" }) do
		if T[name] and T[name]() then return false end
	end
	return true
end

-- A recipe of the open profession (the profession check rules out the
-- combat spells and forms GetRecipeInfo answers for).
local function isRecipe(spell)
	local T = C_TradeSkillUI
	if not (T and T.GetRecipeInfo) then return false end
	local ok, recipe = pcall(T.GetRecipeInfo, spell)
	if not (ok and type(recipe) == "table") then return false end
	if T.GetProfessionInfoByRecipeID then
		local open = professionID()
		local okP, info = pcall(T.GetProfessionInfoByRecipeID, spell)
		local prof = okP and type(info) == "table" and Num(info.professionID) or nil
		if not (open and prof and (prof == open or (info.parentProfessionID and info.parentProfessionID == open))) then return false end
	end
	return true
end

-- Whether a cast is a craft from the trade skill window (World.lua leaves
-- those out of `cast`).
function ns.IsCraftSpell(spell)
	return ownWindow() and (queued[spell] or 0) > 0 and isRecipe(spell)
end

-- Whether a spell is some profession's recipe (never a `cast`, crafted from
-- the window or not).
function ns.IsRecipeSpell(spell)
	local T = C_TradeSkillUI
	if not (T and T.GetProfessionInfoByRecipeID) then return false end
	local ok, info = pcall(T.GetProfessionInfoByRecipeID, spell)
	return ok and type(info) == "table" and (Num(info.professionID) or 0) ~= 0
end

local function finishCraft()
	local now = GetTime()
	while crafts[1] and (crafts[1].item or now - crafts[1].at >= CRAFT_WINDOW - 1e-6) do
		local c = table.remove(crafts, 1)
		if not c.item and C_TradeSkillUI.GetRecipeSchematic then
			local ok, schematic = pcall(C_TradeSkillUI.GetRecipeSchematic, c.spell, false)
			if ok and schematic and schematic.outputItemID then
				c.item, c.count = schematic.outputItemID, schematic.quantityMin
			end
		end
		ns.Rec("craft", c.spell, c.item, c.count)
	end
end

local function ask(spell, n)
	spell = Num(spell)
	if spell then queued[spell] = (queued[spell] or 0) + (Num(n) or 1) end
end

if C_TradeSkillUI then
	for _, name in ipairs({ "CraftRecipe", "CraftEnchant" }) do
		if type(C_TradeSkillUI[name]) == "function" then hooksecurefunc(C_TradeSkillUI, name, ask) end
	end
end

ns.On("TRADE_SKILL_SHOW", function() tradeOpen = true end)
ns.On("TRADE_SKILL_CLOSE", function()
	tradeOpen = false
	queued = {}
end)

ns.On("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spellID)
	if unit ~= "player" or not Num(spellID) or not ns.Recording() then return end
	if not ns.IsCraftSpell(spellID) then return end
	queued[spellID] = queued[spellID] - 1
	local c = { spell = spellID, at = GetTime() }
	if lastResult and GetTime() - lastResult.at <= CRAFT_WINDOW then
		c.item, c.count = lastResult.item, lastResult.count
		lastResult = nil
	end
	crafts[#crafts + 1] = c
	if c.item then finishCraft() else C_Timer.After(CRAFT_WINDOW, finishCraft) end
end)

ns.On("TRADE_SKILL_ITEM_CRAFTED_RESULT", function(_, data)
	if type(data) ~= "table" or not Num(data.itemID) then return end
	for _, c in ipairs(crafts) do
		if not c.item then
			c.item, c.count = data.itemID, data.quantity
			finishCraft()
			return
		end
	end
	lastResult = { item = data.itemID, count = data.quantity, at = GetTime() }
end)

---------------------------------------------------------------------------
-- New spells and recipes, achievements
---------------------------------------------------------------------------

local function learned(spellID)
	if not Num(spellID) then return end
	local seen = sessionSet("learned")
	if not seen or seen[spellID] then return end
	if ns.Rec("learn", spellID) then seen[spellID] = true end
end

ns.On("LEARNED_SPELL_IN_SKILL_LINE", function(_, spellID) learned(spellID) end)
ns.On("NEW_RECIPE_LEARNED", function(_, recipeID) learned(recipeID) end)

ns.On("ACHIEVEMENT_EARNED", function(_, id)
	if Num(id) then ns.Rec("achieve", id) end
end)
