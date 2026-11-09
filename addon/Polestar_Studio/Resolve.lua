-- Fill-ins for one goal at a time (spec 9.2): each call returns the goal as
-- written (src = { verb, args, mods, note }: tokens as a .guide writes them)
-- and as compiled (out: the fields tools/lib/dsl/resolve.js gives that verb,
-- the keys Core/Import.lua's GOAL reads), or nil and why not.
--
-- Live game state first (target, the NPC window being talked to, position,
-- quest log, the open quest frame), then Polestar's Codex. Coordinates are
-- the author's own position (live frame, written `@x,y map <id> live`) when
-- they stand at the thing; otherwise the Codex spawn nearest to them, which
-- the source leaves out so the compiler picks its own.
--
--   S.Resolve.Here() -> { map, x, y, z, area, areaName, zoneName, instance } | nil
--   S.Resolve.Goto(label)  Path(points, cycle, label)  Area(points | npcId, label)
--   S.Resolve.Kill(unit | npcId, count, questId, objIndex)  Collect(itemId, count, questId, objIndex)
--   S.Resolve.Accept(questId)  Complete(questId)  Turnin(questId, choose)
--   S.Resolve.Talk(unit | npcId)  Interact(objectId)  Use(itemId)  Mark(unit | npcId, icon, note)
--   S.Resolve.Boss(unit | npcId)  Note(text)  Level(n)  Hearth(loc)  SetHome(loc)
--   S.Resolve.GetFP(name)  Fly(name)  Train(arg)  Buy(itemId, count, nearest)
--   S.Resolve.AreaId(name) -> area id | nil   (name -> id index, built over frames)
--   S.Resolve.Interaction() -> { kind, id, name, pos, at } | nil   (the NPC/object last talked to)

local ADDON, S = ...
local L = S.L

local Resolve = {}
S.Resolve = Resolve

local type, pairs, ipairs, tostring, tonumber, select, pcall = type, pairs, ipairs, tostring, tonumber, select, pcall
local floor, sqrt, huge, abs = math.floor, math.sqrt, math.huge, math.abs
local round2, num, quote = S.Round2, S.Num, S.Quote

local NO_POSITION = L["The game gives no position here (inside an instance?)."]
local INTERACTION_SECONDS = 20
local PATH_MAX, AREA_MIN, AREA_MAX = 200, 3, 64
local MARK_WORDS = { "star", "circle", "diamond", "triangle", "moon", "square", "cross", "skull" }
local MARK_ICONS = { star = 1, circle = 2, diamond = 3, triangle = 4, moon = 5, square = 6, cross = 7, skull = 8 }
local QUALITIES = { [0] = "poor", "common", "uncommon", "rare", "epic", "legendary", "artifact", "heirloom" }
local RANK_NAMES = { "Apprentice", "Journeyman", "Expert", "Artisan" }
local RANK_CAPS = { 75, 150, 225, 300 }
local CANDIDATES_MAX = 128

---------------------------------------------------------------------------
-- Polestar access
---------------------------------------------------------------------------

local function compat()
	local P = S.P()
	return P and P.Compat
end

local codexTried = false
local function codex()
	local P = S.P()
	local X = P and P.Codex
	if not X then return nil end
	if X.IsLoaded and X.IsLoaded() then return X end
	if not codexTried and X.Load then
		codexTried = true
		pcall(X.Load)
	end
	return X.IsLoaded and X.IsLoaded() and X or nil
end
Resolve.Codex = codex

local function codexRec(kind, id)
	local X = codex()
	if not (X and id) then return nil end
	local fn = (kind == "npc" and X.Npc) or (kind == "object" and X.Object) or (kind == "item" and X.Item) or (kind == "quest" and X.Quest)
	if not fn then return nil end
	local ok, rec = pcall(fn, id)
	return ok and rec or nil
end

local function codexName(kind, id)
	local X = codex()
	if not (X and X.Name and id) then return nil end
	local ok, name = pcall(X.Name, kind, id)
	return ok and type(name) == "string" and name ~= "" and name or nil
end

local function itemName(id)
	local name = codexName("item", id)
	if name then return name end
	local C = compat()
	if C and C.GetItemName then
		local ok, n = pcall(C.GetItemName, id)
		if ok and type(n) == "string" and n ~= "" then return n end
	end
	if GetItemInfo then
		local n = GetItemInfo(id)
		if type(n) == "string" and n ~= "" then return n end
	end
	return nil
end

local function itemQuality(id)
	local rec = codexRec("item", id)
	if rec and type(rec.quality) == "number" then return rec.quality end
	local C = compat()
	if C and C.GetItemQuality then
		local ok, q = pcall(C.GetItemQuality, id)
		if ok and type(q) == "number" then return q end
	end
	return nil
end

local function questTitle(q)
	local C = compat()
	if C and C.GetQuestTitle then
		local ok, t = pcall(C.GetQuestTitle, q)
		if ok and type(t) == "string" and t ~= "" then return t end
	end
	local rec = codexRec("quest", q)
	if rec and type(rec.title) == "string" and rec.title ~= "" then return rec.title end
	if GetQuestID and GetTitleText and GetQuestID() == q then
		local t = GetTitleText()
		if type(t) == "string" and t ~= "" then return t end
	end
	return nil
end

---------------------------------------------------------------------------
-- Position and places
---------------------------------------------------------------------------

-- Area name (lower case) -> area id, built once over frames from C_Map.GetAreaInfo.
local areaIndex, areaBuilding = nil, false
local AREA_SCAN_MAX, AREA_PER_FRAME = 12000, 300

local function buildAreaIndex()
	if areaIndex or areaBuilding or not (C_Map and C_Map.GetAreaInfo and C_Timer and C_Timer.NewTicker) then return end
	areaBuilding = true
	local index, id = {}, 1
	local ticker
	ticker = C_Timer.NewTicker(0, function()
		local last = id + AREA_PER_FRAME - 1
		for a = id, last do
			local ok, name = pcall(C_Map.GetAreaInfo, a)
			if ok and type(name) == "string" and name ~= "" then
				local key = name:lower()
				if not index[key] then index[key] = a end
			end
		end
		id = last + 1
		if id > AREA_SCAN_MAX then
			ticker:Cancel()
			areaIndex, areaBuilding = index, false
		end
	end)
end

function Resolve.AreaId(name)
	if type(name) ~= "string" or name == "" then return nil end
	if not areaIndex then
		buildAreaIndex()
		return nil
	end
	return areaIndex[name:lower()]
end

local function instanceId()
	if not (IsInInstance and IsInInstance()) then return nil end
	if GetInstanceInfo then
		local id = select(8, GetInstanceInfo())
		if type(id) == "number" then return id end
	end
	return nil
end

function Resolve.Here()
	local C = compat()
	local out = {}
	if C and C.GetPlayerMapPosition then
		local map, x, y = C.GetPlayerMapPosition()
		if map and x and y then out.map, out.x, out.y = map, round2(x), round2(y) end
	end
	if C and C.GetPlayerUnitPosition then
		local _, _, z = C.GetPlayerUnitPosition()
		if type(z) == "number" then out.z = floor(z * 10 + 0.5) / 10 end
	end
	local zone, sub
	if C and C.GetZoneText then zone, sub = C.GetZoneText() end
	out.zoneName, out.areaName = zone, sub
	out.area = Resolve.AreaId(sub) or Resolve.AreaId(zone)
	out.instance = instanceId()
	if not out.map and not out.instance then return nil end
	return out
end
local here = Resolve.Here

-- The mods placing a goal at pos: `@x,y map <id> live`.
local function atMods(mods, pos)
	mods[#mods + 1] = { "at", "@" .. S.XY(pos.x, pos.y) }
	mods[#mods + 1] = { "map", tostring(pos.map) }
	mods[#mods + 1] = { "frame", pos.f == "e" and "era" or "live" }
end

local function place(out, pos)
	out.map, out.x, out.y = pos.map, round2(pos.x), round2(pos.y)
	if pos.f == "e" then out.f = "e" end
	if pos.z then out.z = pos.z end
end

-- Yards between two points on one map, or nil.
local function yards(map, ax, ay, af, bx, by, bf)
	local C = compat()
	if not (C and C.MapToWorld) then return nil end
	local c1, x1, y1 = C.MapToWorld(map, ax, ay, af)
	local c2, x2, y2 = C.MapToWorld(map, bx, by, bf)
	if not (c1 and c2 and c1 == c2) then return nil end
	return sqrt((x1 - x2) ^ 2 + (y1 - y2) ^ 2)
end

-- The spawn of a Codex record nearest to the author (same map first).
local function nearestSpawn(spawns, pos)
	if type(spawns) ~= "table" or #spawns == 0 then return nil end
	local best, bestD
	for _, s in ipairs(spawns) do
		local d
		if pos and pos.map and s.map == pos.map then
			d = yards(s.map, s.x, s.y, s.f, pos.x, pos.y, nil) or sqrt((s.x - pos.x) ^ 2 + (s.y - pos.y) ^ 2)
		else
			d = huge
		end
		if not best or d < bestD then best, bestD = s, d end
	end
	return best
end

-- out placed at the nearest spawn of an npc/object, when the Codex has one.
local function placeAtSpawn(out, kind, id)
	local rec = codexRec(kind, id)
	local s = rec and nearestSpawn(rec.spawns, here())
	if s then place(out, { map = s.map, x = s.x, y = s.y, f = s.f }) end
	return s ~= nil
end

---------------------------------------------------------------------------
-- Units and the NPC window
---------------------------------------------------------------------------

-- unit -> kind ("npc" | "object"), id, name  (nil for players and secrets)
local function entity(unit)
	if not (UnitGUID and UnitExists and UnitExists(unit)) then return nil end
	local guid = S.Readable(UnitGUID(unit))
	if type(guid) ~= "string" then return nil end
	local kind, _, _, _, _, id = strsplit("-", guid)
	id = tonumber(id)
	if not id then return nil end
	local name = UnitName and S.Readable(UnitName(unit)) or nil
	if type(name) ~= "string" or name == "" then name = nil end
	if kind == "Creature" or kind == "Vehicle" then return "npc", id, name end
	if kind == "GameObject" then return "object", id, name end
	return nil
end
Resolve.Entity = entity

local interaction -- { kind, id, name, pos, at, taxi }

local function remember()
	local kind, id, name = entity("npc")
	if not kind then return end
	interaction = { kind = kind, id = id, name = name, pos = here(), at = GetTime() }
end

-- The NPC or object being talked to: live, else the one of the last few seconds.
function Resolve.Interaction()
	local kind, id, name = entity("npc")
	if kind then return { kind = kind, id = id, name = name, pos = here(), at = GetTime() } end
	if interaction and GetTime() - interaction.at <= INTERACTION_SECONDS then return interaction end
	return nil
end

for _, ev in ipairs({ "GOSSIP_SHOW", "QUEST_DETAIL", "QUEST_GREETING", "QUEST_PROGRESS", "MERCHANT_SHOW", "TRAINER_SHOW", "CONFIRM_BINDER" }) do
	S.RegisterEvent(ev, remember)
end

local lastTaxi -- { node, at }
S.RegisterEvent("TAXIMAP_OPENED", function()
	remember()
	local C = compat()
	local node = C and C.GetCurrentTaxiNode and C.GetCurrentTaxiNode()
	if node then lastTaxi = { node = node, at = GetTime() } end
end)

function Resolve.TaxiNode()
	local C = compat()
	local node = C and C.GetCurrentTaxiNode and C.GetCurrentTaxiNode()
	if node then return node end
	if lastTaxi and GetTime() - lastTaxi.at <= INTERACTION_SECONDS then return lastTaxi.node end
	return nil
end

-- The reward frame's items, per quest (read at QUEST_COMPLETE), and the
-- choice the author took (GetQuestReward).
local frameRewards = {} -- quest -> { items = {...}, choices = {...}, xp, money }
local chosen = {} -- quest -> item id

local function linkItem(link)
	return type(link) == "string" and tonumber(link:match("item:(%d+)")) or nil
end

local function readRewards()
	local q = GetQuestID and GetQuestID()
	if not q or q == 0 then return end
	local r = { items = {}, choices = {} }
	local function list(kind, n, into)
		for i = 1, n or 0 do
			local id = GetQuestItemLink and linkItem(GetQuestItemLink(kind, i))
			if id then
				local name, _, _, quality = GetQuestItemInfo(kind, i)
				into[#into + 1] = { item = id, itemName = type(name) == "string" and name ~= "" and name or itemName(id), quality = type(quality) == "number" and quality or itemQuality(id) }
			end
		end
	end
	list("reward", GetNumQuestRewards and GetNumQuestRewards(), r.items)
	list("choice", GetNumQuestChoices and GetNumQuestChoices(), r.choices)
	local xp = GetRewardXP and GetRewardXP()
	if type(xp) == "number" and xp > 0 then r.xp = xp end
	local money = GetRewardMoney and GetRewardMoney()
	if type(money) == "number" and money > 0 then r.money = money end
	frameRewards[q] = r
end
S.RegisterEvent("QUEST_COMPLETE", function()
	remember()
	readRewards()
end)

if type(GetQuestReward) == "function" and hooksecurefunc then
	hooksecurefunc("GetQuestReward", function(choice)
		local q = GetQuestID and GetQuestID()
		local r = q and frameRewards[q]
		local c = r and type(choice) == "number" and r.choices[choice]
		if c then chosen[q] = c.item end
	end)
end

function Resolve.ChosenReward(q) return chosen[q] end

---------------------------------------------------------------------------
-- Quest log and objectives
---------------------------------------------------------------------------

-- The quests in the log, as ids.
local function questLog()
	local out = {}
	if C_QuestLog and C_QuestLog.GetNumQuestLogEntries and C_QuestLog.GetInfo then
		for i = 1, C_QuestLog.GetNumQuestLogEntries() or 0 do
			local info = C_QuestLog.GetInfo(i)
			if info and not info.isHeader and info.questID and info.questID > 0 then out[#out + 1] = info.questID end
		end
	elseif GetNumQuestLogEntries and GetQuestLogTitle then
		for i = 1, GetNumQuestLogEntries() or 0 do
			local _, _, _, isHeader, _, _, _, id = GetQuestLogTitle(i)
			if not isHeader and type(id) == "number" and id > 0 then out[#out + 1] = id end
		end
	end
	return out
end
Resolve.QuestLog = questLog

-- quest, objective kind ("kill" | "item" | "object"), id -> objective index, count
local function objectiveOf(q, kind, id)
	local rec = codexRec("quest", q)
	for i, o in ipairs(rec and rec.objectives or {}) do
		if o.type == kind and o.id == id then return i, o.count end
	end
	return nil
end

-- The live objective's count needed, by index.
local function liveCount(q, oi)
	local C = compat()
	local list = C and C.GetQuestObjectives and C.GetQuestObjectives(q)
	local o = list and list[oi]
	return o and o.numRequired or nil
end

-- A quest objective an npc/item/object serves: the first quest in the log
-- (by its Codex objectives), else the live objective whose label names it.
local LIVE_TYPE = { kill = "monster", item = "item", object = "object" }
local function questFor(kind, id, name)
	for _, q in ipairs(questLog()) do
		local oi = objectiveOf(q, kind, id)
		if oi then return q, oi end
	end
	if not name then return nil end
	local C = compat()
	for _, q in ipairs(questLog()) do
		local list = C and C.GetQuestObjectives and C.GetQuestObjectives(q)
		for i, o in ipairs(list or {}) do
			if (o.type == LIVE_TYPE[kind] or o.type == "") and C.ObjectiveLabel and C.ObjectiveLabel(o.text):lower():find(name:lower(), 1, true) then
				return q, i
			end
		end
	end
	return nil
end

-- Fills quest, title, oi and count for a kill/collect/interact of `kind`/`id`;
-- adds the `quest q.o` (and `xN`) mods. count: the caller's, or nil.
local function questFields(out, mods, kind, id, name, count, q, oi)
	if q == nil then q, oi = questFor(kind, id, name) end
	local fromObjective
	if q then
		if oi == nil then oi = objectiveOf(q, kind, id) end
		out.quest = q
		out.title = questTitle(q)
		mods[#mods + 1] = { "quest", oi and (q .. "." .. oi) or tostring(q) }
		if oi then
			out.oi = oi
			local _, n = objectiveOf(q, kind, id)
			if not n then
				local rec = codexRec("quest", q)
				local o = rec and rec.objectives and rec.objectives[oi]
				n = o and o.count
			end
			fromObjective = n or liveCount(q, oi)
		end
	end
	if count and (kind == "kill" or kind == "item") then
		out.count = count
		if count ~= fromObjective then mods[#mods + 1] = { "count", "x" .. count } end
	elseif fromObjective and (kind == "kill" or kind == "item") then
		out.count = fromObjective
	end
end

-- A quest id from the arg, else the quest frame being shown.
local function frameQuest(q)
	q = tonumber(q)
	if q then return q end
	local id = GetQuestID and GetQuestID()
	if id and id > 0 then return id end
	return nil
end

---------------------------------------------------------------------------
-- Shared builders
---------------------------------------------------------------------------

-- `<id> ["Name"]`: the name written only when the Codex does not know it
-- (the compiler then needs it).
local function idArgs(kind, id, name)
	local args = { tostring(id) }
	if name and not codexName(kind, id) then args[2] = quote(name) end
	return args
end

-- unit or id -> npc id, name, live (true when the unit is there to stand by)
local function npcOf(arg)
	if type(arg) == "string" and not tonumber(arg) then
		local kind, id, name = entity(arg)
		if kind ~= "npc" then return nil end
		return id, codexName("npc", id) or name, true
	end
	local id = tonumber(arg)
	if not id then
		local kind, tid, name = entity("target")
		if kind ~= "npc" then return nil end
		return tid, codexName("npc", tid) or name, true
	end
	return id, codexName("npc", id), false
end

local function src(verb, args, mods, note)
	return { verb = verb, args = args or {}, mods = mods or {}, note = note }
end

-- Places out at the author when `live`, else at the Codex spawn.
local function locate(out, mods, live, kind, id)
	local pos = live and here()
	if pos and pos.map then
		atMods(mods, pos)
		place(out, pos)
		return true
	end
	if kind and id then return placeAtSpawn(out, kind, id) end
	return false
end

local function needName(what, id)
	return nil, (L["%s %s is unknown to Polestar: target it, or give its name."]):format(what, tostring(id))
end

local function mapOf(points)
	if type(points) ~= "table" then return nil end
	if type(points.map) == "number" then return points.map end
	if points[1] and type(points[1].map) == "number" then return points[1].map end
	local pos = here()
	return pos and pos.map
end

-- The convex hull of {x, y} points (Andrew's monotone chain, as the compiler):
-- counter-clockwise from the lowest x, at most `max` corners.
local function hull(points, max)
	local seen, list = {}, {}
	for _, p in ipairs(points) do
		local x, y = round2(p.x or p[1]), round2(p.y or p[2])
		local k = x .. "," .. y
		if not seen[k] then
			seen[k] = true
			list[#list + 1] = { x, y }
		end
	end
	table.sort(list, function(a, b)
		if a[1] ~= b[1] then return a[1] < b[1] end
		return a[2] < b[2]
	end)
	if #list < 3 then return list end
	local function cross(o, a, b) return (a[1] - o[1]) * (b[2] - o[2]) - (a[2] - o[2]) * (b[1] - o[1]) end
	local function half(pts)
		local out = {}
		for _, p in ipairs(pts) do
			while #out >= 2 and cross(out[#out - 1], out[#out], p) <= 0 do out[#out] = nil end
			out[#out + 1] = p
		end
		out[#out] = nil
		return out
	end
	local rev = {}
	for i = #list, 1, -1 do rev[#rev + 1] = list[i] end
	local h = half(list)
	for _, p in ipairs(half(rev)) do h[#h + 1] = p end
	while #h > max do
		local least, leastArea = 1, huge
		for i = 1, #h do
			local a = abs(cross(h[(i - 2) % #h + 1], h[i], h[i % #h + 1]))
			if a < leastArea then least, leastArea = i, a end
		end
		table.remove(h, least)
	end
	return h
end
Resolve.Hull = hull

local function inRange(p) return p.x >= 0 and p.x <= 100 and p.y >= 0 and p.y <= 100 end

-- Codex npc faction tag as a candidate carries it (A, H or AH), or nil.
local function factionTag(f)
	if f == "A" or f == "H" or f == "AH" then return f end
	return nil
end

-- Smart-target candidates from npc ids: each npc at its spawn nearest the author.
local function candidatesOf(ids, classes)
	local out, pos = {}, here()
	for _, id in ipairs(ids) do
		local rec = codexRec("npc", id)
		local s = rec and nearestSpawn(rec.spawns, pos)
		if s then
			local c = { npc = id, npcName = rec.name, map = s.map, x = round2(s.x), y = round2(s.y), faction = factionTag(rec.faction) }
			if s.f == "e" then c.f = "e" end
			if classes then c.classes = classes end
			out[#out + 1] = c
			if #out >= CANDIDATES_MAX then break end
		end
	end
	return out
end

---------------------------------------------------------------------------
-- Places and paths
---------------------------------------------------------------------------

function Resolve.Goto(label)
	local pos = here()
	if not (pos and pos.map) then return nil, NO_POSITION end
	local args = { S.XY(pos.x, pos.y) }
	local out = { t = "goto" }
	place(out, pos)
	if type(label) == "string" and S.OneLine(label) ~= "" then
		label = S.OneLine(label)
		args[2] = quote(label)
		out.text = label
		-- the compiler finds the area its label names (places.js goalArea)
		local area = Resolve.AreaId(label)
		if area then out.area = area end
	end
	return src("goto", args, { { "map", tostring(pos.map) }, { "frame", "live" } }), out
end

-- points: { {x, y}, ... } (map percent, live frame) with points.map or each
-- point's map, else the author's map.
function Resolve.Path(points, cycle, label)
	if type(points) ~= "table" or #points < 2 then return nil, L["A path needs at least 2 points."] end
	if #points > PATH_MAX then return nil, (L["A path takes at most %d points: split it in two."]):format(PATH_MAX) end
	local map = mapOf(points)
	if not map then return nil, NO_POSITION end
	local args, pts = {}, {}
	for i, p in ipairs(points) do
		local x, y = p.x or p[1], p.y or p[2]
		if not (x and y and inRange({ x = x, y = y })) then return nil, L["A path point is outside the map."] end
		args[i] = "@" .. S.XY(x, y)
		pts[i] = { x = round2(x), y = round2(y) }
	end
	local out = { t = "path", map = map, pts = pts }
	if type(label) == "string" and S.OneLine(label) ~= "" then
		args[#args + 1] = quote(label)
		out.text = S.OneLine(label)
	end
	local mods = {}
	if cycle then
		mods[#mods + 1] = { "cycle" }
		out.cycle = true
	end
	mods[#mods + 1] = { "map", tostring(map) }
	mods[#mods + 1] = { "frame", "live" }
	return src("path", args, mods), out
end

-- arg: points (as Path) or an npc id (unit tokens too): the hull of its
-- spawns on the author's map.
function Resolve.Area(arg, label)
	local out = { t = "area" }
	local args, mods = {}, {}
	if type(arg) == "table" then
		if #arg < AREA_MIN then return nil, L["An area needs at least 3 points."] end
		if #arg > AREA_MAX then return nil, (L["An area takes at most %d points."]):format(AREA_MAX) end
		local map = mapOf(arg)
		if not map then return nil, NO_POSITION end
		for i, p in ipairs(arg) do
			local x, y = p.x or p[1], p.y or p[2]
			if not (x and y and inRange({ x = x, y = y })) then return nil, L["An area point is outside the map."] end
			args[i] = "@" .. S.XY(x, y)
		end
		local h = hull(arg, AREA_MAX)
		if #h < 3 then return nil, L["The points lie on one line: they shade no region."] end
		out.map = map
		mods[#mods + 1] = { "map", tostring(map) }
		mods[#mods + 1] = { "frame", "live" }
		out.pts = {}
		for i, p in ipairs(h) do out.pts[i] = { x = p[1], y = p[2] } end
	else
		local id, name = npcOf(arg)
		if not id then return nil, L["Target a creature, or give its id."] end
		local rec = codexRec("npc", id)
		local pos = here()
		local map = pos and pos.map
		if not map then return nil, NO_POSITION end
		local pts, frame = {}, nil
		for _, s in ipairs(rec and rec.spawns or {}) do
			if s.map == map then
				pts[#pts + 1] = { x = s.x, y = s.y }
				frame = frame or s.f
			end
		end
		local h = hull(pts, AREA_MAX)
		if #h < 3 then return nil, L["Polestar knows too few spawns of it on this map: draw the area instead."] end
		args[1] = tostring(id)
		out.npc = id
		out.npcName = name
		out.map = map
		if frame == "e" then out.f = "e" end
		mods[#mods + 1] = { "map", tostring(map) }
		out.pts = {}
		for i, p in ipairs(h) do out.pts[i] = { x = p[1], y = p[2] } end
	end
	if type(label) == "string" and S.OneLine(label) ~= "" then
		args[#args + 1] = quote(label)
		out.text = S.OneLine(label)
	end
	return src("area", args, mods), out
end

---------------------------------------------------------------------------
-- Creatures, objects, items
---------------------------------------------------------------------------

function Resolve.Kill(arg, count, questId, objIndex)
	local id, name, live = npcOf(arg)
	if not id then
		if type(arg) == "string" and arg ~= "" and not tonumber(arg) and not UnitExists(arg) then
			-- a "Target name" without an id
			local out = { t = "kill", target = S.OneLine(arg) }
			local mods = {}
			questFields(out, mods, "kill", nil, out.target, tonumber(count), tonumber(questId), tonumber(objIndex))
			locate(out, mods, true)
			return src("kill", { quote(arg) }, mods), out
		end
		return nil, L["Target a creature, or give its id."]
	end
	if not name then return needName(L["Creature"], id) end
	local out = { t = "kill", target = name, npc = id }
	local mods = {}
	questFields(out, mods, "kill", id, name, tonumber(count), tonumber(questId), tonumber(objIndex))
	locate(out, mods, live, "npc", id)
	return src("kill", idArgs("npc", id, name), mods), out
end

-- The creature the author targets, when it drops item (for `from`).
local function dropper(item)
	local kind, id, name = entity("target")
	if kind ~= "npc" then return nil end
	local rec = codexRec("npc", id)
	for _, it in ipairs(rec and rec.loot or {}) do
		if it == item then return id, rec.name or name, rec end
	end
	return nil
end

-- away: true when the author is not where the item is got (laying out a
-- chain): no coordinates, the compiler places it from the droppers.
function Resolve.Collect(itemId, count, questId, objIndex, away)
	local id = tonumber(itemId)
	if not id then return nil, L["Pick an item."] end
	local name = itemName(id)
	if not name then return needName(L["Item"], id) end
	local out = { t = "collect", item = id, itemName = name }
	local mods = {}
	questFields(out, mods, "item", id, name, tonumber(count), tonumber(questId), tonumber(objIndex))
	local from, fromName, rec = dropper(id)
	if from and fromName then
		out.from, out.fromId, out.fromKind = fromName, from, "npc"
		local f = rec and factionTag(rec.faction)
		if f then out.fromFaction = f end
	end
	if not away then locate(out, mods, true) end
	return src("collect", idArgs("item", id, name), mods), out
end

function Resolve.Talk(arg)
	local id, name, live = npcOf(arg)
	if not id then
		local it = Resolve.Interaction()
		if it and it.kind == "npc" then id, name, live = it.id, codexName("npc", it.id) or it.name, true end
	end
	if not id then return nil, L["Target the NPC, or give its id."] end
	if not name then return needName(L["NPC"], id) end
	local out = { t = "talk", npc = id, npcName = name }
	local mods = {}
	locate(out, mods, live, "npc", id)
	return src("talk", idArgs("npc", id, name), mods), out
end

function Resolve.Interact(objectId)
	local id, name, live = tonumber(objectId), nil, false
	if not id then
		local it = Resolve.Interaction()
		if it and it.kind == "object" then id, name, live = it.id, it.name, true end
		if not id then
			local kind, mid, mname = entity("mouseover")
			if kind == "object" then id, name, live = mid, mname, true end
		end
	end
	if not id then return nil, L["Open the object, or give its id."] end
	name = codexName("object", id) or name
	if not name then return needName(L["Object"], id) end
	local out = { t = "interact", object = id, objName = name }
	local mods = {}
	local q, oi = questFor("object", id, name)
	if q then questFields(out, mods, "object", id, name, nil, q, oi) end
	locate(out, mods, live or objectId == nil, "object", id)
	return src("interact", idArgs("object", id, name), mods), out
end

function Resolve.Use(itemId)
	local id = tonumber(itemId)
	if not id then return nil, L["Pick an item."] end
	local name = itemName(id)
	if not name then return needName(L["Item"], id) end
	local out = { t = "use", item = id, itemName = name }
	local mods = {}
	locate(out, mods, true)
	return src("use", idArgs("item", id, name), mods), out
end

-- icon: 1-8 or a word (skull, cross, ...); default the unit's raid mark, else skull.
function Resolve.Mark(arg, icon, note)
	local id, name = npcOf(arg)
	if not id then return nil, L["Target a creature, or give its id."] end
	local n = tonumber(icon) or MARK_ICONS[tostring(icon or ""):lower()]
	if not n and type(arg) == "string" and GetRaidTargetIndex then n = GetRaidTargetIndex(arg) end
	n = n or 8
	if n < 1 or n > 8 then return nil, L["A mark is one of the eight raid icons."] end
	n = floor(n)
	local out = { t = "mark", npc = id, icon = n, npcName = name }
	local args = { tostring(id), MARK_WORDS[n] }
	if type(note) == "string" and S.OneLine(note) ~= "" then
		out.note = S.OneLine(note)
		args[3] = quote(note)
	end
	return src("mark", args, {}), out
end

function Resolve.Boss(arg)
	local id, name = npcOf(arg)
	if not id then return nil, L["Target the boss, or give its id."] end
	if not name then return needName(L["Boss"], id) end
	local out = { t = "boss", npc = id, npcName = name }
	local instance = instanceId()
	if not instance then
		local rec = codexRec("npc", id)
		local X = codex()
		local inst = rec and rec.instance and X and X.Instance and X.Instance(rec.instance)
		instance = inst and inst.map
	end
	if instance then out.instance = instance end
	return src("boss", idArgs("npc", id, name), {}), out
end

---------------------------------------------------------------------------
-- Quests
---------------------------------------------------------------------------

-- Giver/ender mods and fields: the NPC window's NPC or object (the author is
-- at it), else the Codex's (`ends`: { npc = {...}, object = {...}, item = {...} }).
local function questParty(out, mods, ends, allowItem, codexOnly)
	local it = not codexOnly and Resolve.Interaction() or nil
	if it then
		if it.kind == "npc" then
			out.npc, out.npcName = it.id, codexName("npc", it.id) or it.name
			mods[#mods + 1] = { "npc", tostring(it.id) }
		else
			out.object, out.objName = it.id, codexName("object", it.id) or it.name
			mods[#mods + 1] = { "object", tostring(it.id) }
		end
		if it.pos and it.pos.map then
			atMods(mods, it.pos)
			place(out, it.pos)
		end
		return
	end
	if not ends then return end
	local pos = here()
	local best, bestKind, bestSpawn, bestD
	for _, kind in ipairs({ "npc", "object" }) do
		for _, id in ipairs(ends[kind] or {}) do
			local rec = codexRec(kind, id)
			local s = rec and nearestSpawn(rec.spawns, pos)
			local d = s and pos and pos.map == s.map and sqrt((s.x - pos.x) ^ 2 + (s.y - pos.y) ^ 2) or huge
			if s and (not best or d < bestD) then best, bestKind, bestSpawn, bestD = id, kind, s, d end
		end
	end
	if best then
		if bestKind == "npc" then
			out.npc, out.npcName = best, codexName("npc", best)
		else
			out.object, out.objName = best, codexName("object", best)
		end
		place(out, { map = bestSpawn.map, x = bestSpawn.x, y = bestSpawn.y, f = bestSpawn.f })
	elseif allowItem and ends.item and ends.item[1] then
		out.item = ends.item[1]
		out.itemName = itemName(out.item)
	end
end

-- What an accept waits on (compiler's acceptGate, from the Codex).
local function acceptGate(out, rec)
	local titles
	local function keep(list, key)
		if type(list) ~= "table" or #list == 0 then return end
		out[key] = {}
		for i, q in ipairs(list) do
			out[key][i] = q
			local t = questTitle(q)
			if t then
				titles = titles or {}
				titles[q] = t
			end
		end
	end
	keep(rec.preAny, "pre")
	keep(rec.pre, "preAll")
	if titles then out.preTitles = titles end
end

local function questArgs(q, title)
	local args = { tostring(q) }
	if title and not codexRec("quest", q) then args[2] = quote(title) end
	return args
end

-- codexOnly: giver from the Codex even while an NPC window is open (laying out a chain).
function Resolve.Accept(questId, codexOnly)
	local q = frameQuest(questId)
	if not q then return nil, L["Open the quest, or give its id."] end
	local title = questTitle(q)
	if not title then return nil, (L["Quest %d is unknown to Polestar: open it in game first."]):format(q) end
	local out = { t = "accept", quest = q, title = title }
	local mods = {}
	local rec = codexRec("quest", q)
	questParty(out, mods, rec and rec.start, true, codexOnly)
	if rec then
		if type(rec.minLevel) == "number" and rec.minLevel > 0 then out.minLevel = rec.minLevel end
		if type(rec.level) == "number" and rec.level > 0 then out.qlvl = rec.level end
		acceptGate(out, rec)
	end
	return src("accept", questArgs(q, title), mods), out
end

function Resolve.Complete(questId)
	local q = tonumber(questId)
	if not q then return nil, L["Pick a quest."] end
	local title = questTitle(q)
	if not title then return nil, (L["Quest %d is unknown to Polestar: open it in game first."]):format(q) end
	return src("complete", questArgs(q, title), {}), { t = "complete", quest = q, title = title }
end

-- A reward list's tokens: <itemId> "Name" [quality] ...
local function rewardMod(word, list)
	local mod = { word }
	for _, it in ipairs(list) do
		mod[#mod + 1] = tostring(it.item)
		if it.itemName then mod[#mod + 1] = quote(it.itemName) end
		if it.quality and QUALITIES[it.quality] then mod[#mod + 1] = QUALITIES[it.quality] end
	end
	return mod
end

local function rewardEntry(it)
	local e = { item = it.item, itemName = it.itemName or itemName(it.item) }
	local qual = it.quality or itemQuality(it.item)
	if qual then e.quality = qual end
	return e
end

-- choose: the choice item(s) to name (an id or a list); default the one the
-- author took, else every choice the frame offered.
function Resolve.Turnin(questId, choose, codexOnly)
	local q = frameQuest(questId)
	if not q then return nil, L["Open the quest, or give its id."] end
	local title = questTitle(q)
	if not title then return nil, (L["Quest %d is unknown to Polestar: open it in game first."]):format(q) end
	local out = { t = "turnin", quest = q, title = title }
	local mods = {}
	local rec = codexRec("quest", q)
	questParty(out, mods, rec and rec["end"], false, codexOnly)
	local fr = frameRewards[q]
	if fr then
		local rewards = {}
		if #fr.items > 0 then
			rewards.items = {}
			for i, it in ipairs(fr.items) do rewards.items[i] = rewardEntry(it) end
			mods[#mods + 1] = rewardMod("reward", rewards.items)
		end
		local want = choose or chosen[q]
		local pick = {}
		if type(want) == "number" then want = { want } end
		for _, it in ipairs(fr.choices) do
			local keep = true
			if type(want) == "table" then
				keep = false
				for _, w in ipairs(want) do
					if tonumber(w) == it.item then keep = true end
				end
			end
			if keep then pick[#pick + 1] = rewardEntry(it) end
		end
		if #pick > 0 then
			rewards.choices = pick
			mods[#mods + 1] = rewardMod("choose", pick)
		end
		if fr.xp then
			rewards.xp = fr.xp
			mods[#mods + 1] = { "xp", tostring(fr.xp) }
		end
		if fr.money then
			rewards.money = fr.money
			mods[#mods + 1] = { "money", tostring(fr.money) }
		end
		if next(rewards) then out.rewards = rewards end
	end
	return src("turnin", questArgs(q, title), mods), out
end

---------------------------------------------------------------------------
-- Character and travel
---------------------------------------------------------------------------

function Resolve.Note(text)
	text = S.OneLine(text)
	if text == "" then return nil, L["Write the note first."] end
	return src("note", { quote(text) }, {}), { t = "note", text = text }
end

-- n: 12, 12.5 (halfway through 12)
function Resolve.Level(n)
	n = tonumber(n)
	if not n or n < 1 then return nil, L["A level is a number, such as 12 or 12.5."] end
	local level = floor(n)
	local frac = round2(n - level)
	local out = { t = "level", level = level }
	local token = tostring(level)
	if frac > 0 and frac < 1 then
		out.frac = frac
		token = num(level + frac)
	end
	return src("level", { token }, {}), out
end

local function bindLocation()
	local C = compat()
	return C and C.GetBindLocation and C.GetBindLocation() or nil
end

function Resolve.Hearth(loc)
	loc = loc and S.OneLine(loc) or bindLocation()
	if not loc or loc == "" then return nil, L["Your hearthstone has no home yet."] end
	local out = { t = "hearth", location = loc, area = Resolve.AreaId(loc) }
	return src("hearth", { quote(loc) }, {}), out
end

-- The innkeeper or flight master being talked to: npc mod, fields, position.
local function hostOf(out, mods)
	local it = Resolve.Interaction()
	if not (it and it.kind == "npc") then return false end
	out.npc, out.npcName = it.id, codexName("npc", it.id) or it.name
	mods[#mods + 1] = { "npc", tostring(it.id) }
	if it.pos and it.pos.map then
		atMods(mods, it.pos)
		place(out, it.pos)
	end
	return true
end

function Resolve.SetHome(loc)
	loc = loc and S.OneLine(loc) or bindLocation()
	if not loc or loc == "" then return nil, L["Talk to the innkeeper, or name the inn's place."] end
	local out = { t = "sethome", location = loc }
	local mods = {}
	hostOf(out, mods)
	out.area = Resolve.AreaId(loc)
	return src("sethome", { quote(loc) }, mods), out
end

local function taxiNodeId(name)
	local P = S.P()
	local M = P and P.Maps
	if not (M and M.TaxiNodeByName) then return nil end
	local ok, id = pcall(M.TaxiNodeByName, name, M.Faction and M.Faction() or nil)
	return ok and type(id) == "number" and id or nil
end

function Resolve.GetFP(name)
	name = name and S.OneLine(name) or Resolve.TaxiNode()
	if not name or name == "" then return nil, L["Open the flight master's map, or name the flight path."] end
	local out = { t = "getfp", location = name }
	local mods = {}
	hostOf(out, mods)
	out.area = Resolve.AreaId(name)
	out.node = taxiNodeId(name)
	return src("getfp", { quote(name) }, mods), out
end

function Resolve.Fly(name)
	name = name and S.OneLine(name)
	if not name or name == "" then return nil, L["Name where to fly."] end
	local out = { t = "fly", location = name, area = Resolve.AreaId(name), node = taxiNodeId(name) }
	return src("fly", { quote(name) }, {}), out
end

-- Profession name (any case) -> name as written, skill line.
local function profession(word)
	local C = compat()
	local lines = C and C.SKILL_LINES or {}
	local key = tostring(word or ""):lower()
	local line = lines[key]
	if not line then return nil end
	local name = key:gsub("(%a)(%a*)", function(a, b) return a:upper() .. b end)
	if C.GetSkillLineName then
		local ok, n = pcall(C.GetSkillLineName, line)
		if ok and type(n) == "string" and n ~= "" then name = n end
	end
	return name, line
end

-- arg: an npc id (the trainer), "class", or "<Profession> [Apprentice|Journeyman|Expert|Artisan]".
-- No arg: the trainer whose window is open.
function Resolve.Train(arg)
	local out = { t = "train" }
	local mods = {}
	local word = type(arg) == "string" and S.OneLine(arg) or nil
	if word and word:lower() == "class" then
		local P = S.P()
		local info = P and P.Compat and P.Compat.GetPlayerInfo and P.Compat.GetPlayerInfo()
		local doc = S.Model.Current()
		local classes = doc and #(doc.header.classes or {}) > 0 and doc.header.classes or (info and info.class and { info.class }) or nil
		if not classes then return nil, L["Pick the class first."] end
		local X = codex()
		local ids, classOf = {}, {}
		for _, c in ipairs(classes) do
			for _, id in ipairs(X and X.WithRole and X.WithRole("class:" .. c) or {}) do
				if not classOf[id] then
					ids[#ids + 1] = id
					classOf[id] = {}
				end
				classOf[id][#classOf[id] + 1] = c
			end
		end
		local cands = {}
		for _, c in ipairs(candidatesOf(ids)) do
			c.classes = classOf[c.npc]
			cands[#cands + 1] = c
		end
		if #cands == 0 then return nil, L["Polestar knows no trainer of that class."] end
		out.class = true
		out.candidates = cands
		return src("train", { "class" }, {}), out
	end
	if word and not tonumber(word) then
		local words = {}
		for w in word:gmatch("%S+") do words[#words + 1] = w end
		local rank
		for r, n in ipairs(RANK_NAMES) do
			if #words > 1 and words[#words]:lower() == n:lower() then rank = r end
		end
		if rank then words[#words] = nil end
		local name, line = profession(table.concat(words, " "))
		if not name then return nil, (L["Unknown profession: %s."]):format(word) end
		rank = rank or 1
		out.skill, out.skillLine, out.rank, out.rankMax = name, line, rank, RANK_CAPS[rank]
		local args = { name:find("%s") and quote(name) or name }
		if rank then args[#args + 1] = RANK_NAMES[rank] end
		if not hostOf(out, mods) then
			local X = codex()
			local cands = candidatesOf(X and X.WithRole and X.WithRole("trainer:" .. line) or {})
			if #cands > 0 then out.candidates = cands end
		end
		return src("train", args, mods), out
	end
	local id = tonumber(arg)
	local name, live
	if id then
		name = codexName("npc", id)
	else
		local it = Resolve.Interaction()
		if it and it.kind == "npc" then id, name, live = it.id, codexName("npc", it.id) or it.name, true end
	end
	if not id then return nil, L["Open the trainer's window, or give its id."] end
	if not name then return needName(L["Trainer"], id) end
	out.npc, out.npcName = id, name
	if live then
		local it = Resolve.Interaction()
		if it and it.pos and it.pos.map then
			atMods(mods, it.pos)
			place(out, it.pos)
		end
	else
		placeAtSpawn(out, "npc", id)
	end
	return src("train", idArgs("npc", id, name), mods), out
end

-- The vendors the Codex knows for an item.
local function vendorsOf(item)
	local rec = codexRec("item", item)
	local out = {}
	for _, s in ipairs(rec and rec.sources or {}) do
		if s.type == "vendor" and s.npc then out[#out + 1] = s.npc end
	end
	table.sort(out)
	return out
end

-- nearest: a smart target over every vendor of it (`buy … nearest`).
function Resolve.Buy(itemId, count, nearest)
	local id = tonumber(itemId)
	if not id then return nil, L["Pick an item."] end
	local name = itemName(id)
	if not name then return needName(L["Item"], id) end
	local out = { t = "buy", item = id, itemName = name }
	local mods = {}
	count = tonumber(count)
	if count and count > 0 then
		out.count = floor(count)
		mods[#mods + 1] = { "count", "x" .. out.count }
	end
	if nearest then
		local cands = candidatesOf(vendorsOf(id))
		if #cands == 0 then return nil, L["Polestar knows no vendor of it."] end
		out.candidates = cands
		mods[#mods + 1] = { "nearest" }
		return src("buy", idArgs("item", id, name), mods), out
	end
	if not hostOf(out, mods) then
		local pos = here()
		local best, bestS, bestD
		for _, v in ipairs(vendorsOf(id)) do
			local rec = codexRec("npc", v)
			local s = rec and nearestSpawn(rec.spawns, pos)
			local d = s and pos and pos.map == s.map and sqrt((s.x - pos.x) ^ 2 + (s.y - pos.y) ^ 2) or huge
			if s and (not best or d < bestD) then best, bestS, bestD = v, s, d end
		end
		if best then
			out.npc, out.npcName = best, codexName("npc", best)
			place(out, { map = bestS.map, x = bestS.x, y = bestS.y, f = bestS.f })
		end
	end
	return src("buy", idArgs("item", id, name), mods), out
end

Resolve.Candidates = candidatesOf

-- `vendor` (sell and repair): the merchant whose window is open, an npc id,
-- or "nearest" (every repairer the Codex knows, a smart target).
function Resolve.Vendor(arg)
	local out = { t = "vendor" }
	if arg == "nearest" then
		local X = codex()
		local cands = candidatesOf(X and X.WithRole and X.WithRole("repair") or {})
		if #cands == 0 then cands = candidatesOf(X and X.WithRole and X.WithRole("vendor") or {}) end
		if #cands == 0 then return nil, L["Polestar knows no vendor nearby."] end
		out.candidates = cands
		return src("vendor", { "nearest" }, {}), out
	end
	local mods = {}
	local id = tonumber(arg)
	if id then
		local name = codexName("npc", id)
		if not name then return needName(L["Vendor"], id) end
		out.npc, out.npcName = id, name
		placeAtSpawn(out, "npc", id)
		return src("vendor", idArgs("npc", id, name), mods), out
	end
	local it = Resolve.Interaction()
	if not (it and it.kind == "npc") then return nil, L["Open the vendor's window, or give its id."] end
	local name = codexName("npc", it.id) or it.name
	if not name then return needName(L["Vendor"], it.id) end
	out.npc, out.npcName = it.id, name
	if it.pos and it.pos.map then
		atMods(mods, it.pos)
		place(out, it.pos)
	end
	return src("vendor", idArgs("npc", it.id, name), mods), out
end

-- Start the area index once the world is up.
S.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	C_Timer.After(5, buildAreaIndex)
end)
