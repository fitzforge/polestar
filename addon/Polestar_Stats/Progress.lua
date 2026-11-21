-- How much of each zone this character has done: its quests handed in, of
-- those the character can take, and its rares killed, of those that spawn
-- there. What there is to do is the Codex's (Polestar_Codex: each quest's
-- zone, side, races and classes, each rare's spawns), loaded when a progress
-- tab is first opened, never in combat. What is done: the client's
-- completed-quest flags, and the rares Collect.lua saw this character kill
-- (store.rares). Nothing here is saved; the lists are let go with the map
-- (Stats.DropCaches).
--
--   Progress.Ready() -> true | false, "combat" | "missing"
--   Progress.Quests() -> { [uiMapID] = { done, total } }, done, total
--   Progress.Rares() -> { [uiMapID] = { done, total, spots = { { x, y, done }, ... } } }, done, total
--     (a rare counts in the zone of its first spawn; spots: its spawns there, in percent)
--   Progress.Drop()

local ns = Polestar
local Stats = ns.Stats
local ipairs, type = ipairs, type

local P = {}
Stats.Progress = P

-- A quest another character takes is none of this zone's for this one.
local NOT_MINE = { faction = true, race = true, class = true, profession = true }

local questsOf -- { [map] = { questID, ... } }
local raresOf -- { [map] = { { id, x, y, x, y, ... }, ... } }

function P.Ready()
	local C = ns.Codex
	if not C then return false, "missing" end
	if C.IsLoaded() then return true end
	if ns.Compat.InCombat() then return false, "combat" end
	if C.Load() then return true end
	return false, "missing"
end

local function readQuests()
	local C, Lk = ns.Codex, ns.Lookup
	local who = Lk and Lk.PlayerInfo and Lk.QuestBlock and Lk.PlayerInfo() or nil
	questsOf = {}
	C.Each("quest", function(id)
		local q = C.Quest(id)
		local map = q and q.zone
		if type(map) == "number" and not (who and NOT_MINE[Lk.QuestBlock(q, who)]) then
			local list = questsOf[map]
			if not list then
				list = {}
				questsOf[map] = list
			end
			list[#list + 1] = id
		end
	end)
end

local function readRares()
	local C = ns.Codex
	raresOf = {}
	C.Each("rare", function(id)
		local n = C.Npc(id)
		local spawns = n and n.spawns
		local first = spawns and spawns[1]
		local map = first and first.map
		if type(map) == "number" then
			local r = { id }
			for _, s in ipairs(spawns) do
				if s.map == map and s.x and s.y then r[#r + 1], r[#r + 2] = s.x, s.y end
			end
			local list = raresOf[map]
			if not list then
				list = {}
				raresOf[map] = list
			end
			list[#list + 1] = r
		end
	end)
end

function P.Quests()
	local out, done, total = {}, 0, 0
	if not P.Ready() then return out, 0, 0 end
	if not questsOf then readQuests() end
	local completed = ns.Compat.IsQuestCompleted
	for map, list in pairs(questsOf) do
		local n = 0
		for i = 1, #list do if completed(list[i]) then n = n + 1 end end
		out[map] = { done = n, total = #list }
		done, total = done + n, total + #list
	end
	return out, done, total
end

function P.Rares()
	local out, done, total = {}, 0, 0
	if not P.Ready() then return out, 0, 0 end
	if not raresOf then readRares() end
	local killed = Stats.Store().rares
	for map, list in pairs(raresOf) do
		local n, spots = 0, {}
		for _, r in ipairs(list) do
			local dead = killed[r[1]] ~= nil
			if dead then n = n + 1 end
			for i = 2, #r, 2 do spots[#spots + 1] = { r[i], r[i + 1], dead } end
		end
		out[map] = { done = n, total = #list, spots = spots }
		done, total = done + n, total + #list
	end
	return out, done, total
end

function P.Drop() questsOf, raresOf = nil, nil end
