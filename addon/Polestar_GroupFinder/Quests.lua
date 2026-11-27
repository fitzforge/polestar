-- Polestar Group Finder: which of your quests are worth a group, and where
-- you stand.
--
-- A quest counts when it is in the log, not ready to turn in, and is one of:
--   g  a group quest (the log's suggested group size > 1, or an elite tag)
--   n  a named mob to kill (a "monster" objective that wants exactly 1)
--   k  mobs to kill (a "monster" objective)
--   l  items to loot (an "item" objective; the client does not say whether
--      they drop from mobs or lie on the ground, so all item objectives count)
-- The quests of Polestar's live step come first (ns.PolestarStepQuests,
-- Polestar.lua) when Polestar runs; then the rest of the log.

local _, ns = ...

local Quests = {}
ns.Quests = Quests

local MAX_SENT = 12 -- quests in one search (keeps the message under 255 bytes)
local KIND_ORDER = { g = 1, n = 2, k = 3, l = 4 }
local GROUP_TAGS = { "(Elite)", "(Élite)", "(Group)", "(Groupe)", "[Elite]", "[Élite]" }

-- Reads the log through whichever API this client has.
-- Returns { [questID] = { id, title, group, objectives = { {type, done, need, have, text} } } }.
local function readLog()
	local out = {}
	if C_QuestLog and C_QuestLog.GetNumQuestLogEntries and C_QuestLog.GetInfo then
		local n = C_QuestLog.GetNumQuestLogEntries() or 0
		for i = 1, n do
			local info = C_QuestLog.GetInfo(i)
			if info and not info.isHeader and info.questID and info.questID > 0 then
				out[info.questID] = { id = info.questID, title = info.title, group = (info.suggestedGroup or 0) > 1,
					complete = info.isComplete == 1 or info.isComplete == true, logIndex = i }
			end
		end
	elseif GetNumQuestLogEntries and GetQuestLogTitle then
		local n = GetNumQuestLogEntries() or 0
		for i = 1, n do
			local title, _, suggestedGroup, isHeader, _, isComplete, _, questID = GetQuestLogTitle(i)
			if not isHeader and questID and questID > 0 then
				out[questID] = { id = questID, title = title, group = (tonumber(suggestedGroup) or 0) > 1,
					complete = isComplete == 1 or isComplete == true, logIndex = i }
			end
		end
	end
	for id, q in pairs(out) do
		local objectives = {}
		if C_QuestLog and C_QuestLog.GetQuestObjectives then
			for _, o in ipairs(C_QuestLog.GetQuestObjectives(id) or {}) do
				objectives[#objectives + 1] = { type = o.type, done = o.finished, need = o.numRequired, have = o.numFulfilled, text = o.text }
			end
		elseif GetNumQuestLeaderBoards and GetQuestLogLeaderBoard then
			for j = 1, GetNumQuestLeaderBoards(q.logIndex) or 0 do
				local text, kind, finished = GetQuestLogLeaderBoard(j, q.logIndex)
				local have, need = (text or ""):match("(%d+)%s*/%s*(%d+)")
				objectives[#objectives + 1] = { type = kind, done = finished, need = tonumber(need), have = tonumber(have), text = text }
			end
		end
		q.objectives = objectives
		if not q.group and type(q.title) == "string" then
			for _, tag in ipairs(GROUP_TAGS) do
				if q.title:find(tag, 1, true) then q.group = true break end
			end
		end
	end
	return out
end

-- The kind of a quest, or nil when it is not worth a group.
local function kindOf(q)
	if q.complete then return nil end
	local kill, named, loot, open = false, false, false, false
	for _, o in ipairs(q.objectives or {}) do
		if not o.done then
			open = true
			if o.type == "monster" then
				kill = true
				if o.need == 1 then named = true end
			elseif o.type == "item" then
				loot = true
			end
		end
	end
	if #(q.objectives or {}) > 0 and not open then return nil end
	if q.group then return "g" end
	if named then return "n" end
	if kill then return "k" end
	if loot then return "l" end
	return nil
end

-- The log, read once per QUEST_LOG_UPDATE burst.
local cache, dirty = nil, true
ns.RegisterEvent("QUEST_LOG_UPDATE", function() dirty = true end)
ns.RegisterEvent("QUEST_ACCEPTED", function() dirty = true end)
ns.RegisterEvent("QUEST_REMOVED", function() dirty = true end)

function Quests.Log()
	if dirty or not cache then
		cache = readLog()
		dirty = false
	end
	return cache
end

function Quests.Has(id) return Quests.Log()[id] ~= nil end

-- The kind of quest `id` while it is worth a group ("g", "n", "k", "l"), nil
-- when it is gone from the log, complete, or has no open objective left.
function Quests.Kind(id)
	local q = Quests.Log()[id]
	if not q then return nil end
	return kindOf(q)
end

-- True while there is still something to do for `id`: in the log, not
-- complete (nor ready to hand in, as Polestar sees it), at least one
-- objective open. This is what keeps a quest in a search.
function Quests.Pending(id)
	local q = Quests.Log()[id]
	if not q or q.complete then return false end
	local C = Polestar and Polestar.Compat
	if C and C.IsQuestReadyForTurnIn then
		local ok, ready = pcall(C.IsQuestReadyForTurnIn, id)
		if ok and ready then return false end
	end
	local objs = q.objectives or {}
	if #objs == 0 then return true end
	for _, o in ipairs(objs) do if not o.done then return true end end
	return false
end

-- 0-100: how far along `id` is (100 once complete or ready to hand in),
-- nil when it is not in the log.
function Quests.Progress(id)
	local q = Quests.Log()[id]
	if not q then return nil end
	if not Quests.Pending(id) then return 100 end
	local sum, n = 0, 0
	for _, o in ipairs(q.objectives or {}) do
		n = n + 1
		if o.done then
			sum = sum + 1
		elseif (o.need or 0) > 0 and o.have then
			sum = sum + math.min(1, o.have / o.need)
		end
	end
	if n == 0 then return 0 end
	return math.min(99, math.floor(sum / n * 100))
end

-- "open" (something left to do), "done" (objectives complete, ready to hand in
-- or handed in), "gone" (not in the log and not turned in: abandoned).
function Quests.State(id)
	local q = Quests.Log()[id]
	if not q then
		local flagged = false
		if C_QuestLog and C_QuestLog.IsQuestFlaggedCompleted then
			local ok, r = pcall(C_QuestLog.IsQuestFlaggedCompleted, id)
			flagged = ok and r and true or false
		elseif IsQuestFlaggedCompleted then
			local ok, r = pcall(IsQuestFlaggedCompleted, id)
			flagged = ok and r and true or false
		end
		return flagged and "done" or "gone"
	end
	return Quests.Pending(id) and "open" or "done"
end

function Quests.Title(id)
	local q = Quests.Log()[id]
	if q and q.title then return q.title end
	if C_QuestLog and C_QuestLog.GetTitleForQuestID then
		local t = C_QuestLog.GetTitleForQuestID(id)
		if t then return t end
	end
	return "#" .. tostring(id)
end

-- The quests to search for: { { id, kind, step = bool } }, Polestar's live
-- step first, then group, named, kill, loot; at most MAX_SENT.
function Quests.Relevant()
	local log = Quests.Log()
	local list, seen = {}, {}
	local step = ns.PolestarStepQuests and ns.PolestarStepQuests() or {}
	for _, id in ipairs(step) do
		local q = log[id]
		local kind = q and kindOf(q)
		if q and not seen[id] and (kind or not q.complete) then
			list[#list + 1] = { id = id, kind = kind or "k", step = true }
			seen[id] = true
		end
	end
	local rest = {}
	for id, q in pairs(log) do
		local kind = not seen[id] and kindOf(q)
		if kind then rest[#rest + 1] = { id = id, kind = kind } end
	end
	table.sort(rest, function(a, b)
		if KIND_ORDER[a.kind] ~= KIND_ORDER[b.kind] then return KIND_ORDER[a.kind] < KIND_ORDER[b.kind] end
		return a.id < b.id
	end)
	for _, e in ipairs(rest) do list[#list + 1] = e end
	while #list > MAX_SENT do table.remove(list) end
	return list
end

-- Where the player stands: map id, x, y (0-1), or nil.
function Quests.Position()
	local P = Polestar and Polestar.Compat
	if P and P.GetPlayerMapPosition then
		local ok, map, x, y = pcall(P.GetPlayerMapPosition)
		if ok and map and x and y then return map, x / 100, y / 100 end
	end
	if not (C_Map and C_Map.GetBestMapForUnit) then return nil end
	local map = ns.Readable(C_Map.GetBestMapForUnit("player"))
	if not map then return nil end
	local pos = C_Map.GetPlayerMapPosition and C_Map.GetPlayerMapPosition(map, "player")
	if not pos then return map end
	local x, y = pos:GetXY()
	x, y = ns.Readable(x), ns.Readable(y)
	if not x or (x == 0 and y == 0) then return map end
	return map, x, y
end

-- Yards between two map positions, or nil when the client cannot say
-- (another continent, no map data).
function Quests.Yards(mapA, xA, yA, mapB, xB, yB)
	if not (mapA and xA and mapB and xB) then return nil end
	if C_Map and C_Map.GetWorldPosFromMapPos and CreateVector2D then
		local okA, contA, posA = pcall(C_Map.GetWorldPosFromMapPos, mapA, CreateVector2D(xA, yA))
		local okB, contB, posB = pcall(C_Map.GetWorldPosFromMapPos, mapB, CreateVector2D(xB, yB))
		if okA and okB and posA and posB and contA == contB then
			local ax, ay = posA:GetXY()
			local bx, by = posB:GetXY()
			return math.sqrt((ax - bx) ^ 2 + (ay - by) ^ 2)
		end
		return nil
	end
	return nil
end
