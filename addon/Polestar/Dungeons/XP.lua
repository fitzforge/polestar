-- How far a dungeon's quests take this character: every page quest for them
-- still to do, turned in in level order, from the lowest level they open at
-- when the character is below it (Core/Levels.lua does the sums; kills are
-- not counted here). The dungeon page's level chip and its tooltip read it
-- (UI/Dungeons.lua, UI/LevelTip.lua).
--
--   Dungeons.QuestXP(key[, p]) -> summary | nil (unknown dungeon)
--       Levels.Run's summary, each counted quest in a group (summary.groups,
--       Levels.Run): "ready" (in the log, or open to take now), "level" (its
--       minLevel is above the character's; groups.level.need: the highest),
--       "chain" (a quest of the chain before it is still to do). And what was
--       left out besides Levels.Run's done and unknown: summary.left =
--       { class, race (Dungeons.QuestFor), faction (the other side's page
--       quests), closed (closedBy a quest taken or done), alt (another of its
--       exclusive group counts instead: the one worth the most) }; summary.ready
--       = { from, to, levels } | nil: the "ready" quests alone, from where the
--       character is now (Levels.Run's from and to)
--   Dungeons.ChainXP(key, id[, p]) -> summary | nil   -- a page quest with
--       the chain before it: the chain's quests oldest first, then the quest;
--       nil without a chain
--     p and summary: Levels.Run's

local ADDON, ns = ...
local Dungeons = ns.Dungeons

local ipairs, type, min, max = ipairs, type, math.min, math.max

local SIDE = { Alliance = "A", Horde = "H" }

local function completed(C, id)
	return C and C.IsQuestCompleted and C.IsQuestCompleted(id) or false
end

local function inLog(C, id)
	return C and C.IsOnQuest and C.IsOnQuest(id) or false
end

-- Taking or finishing any of ids closes it for good.
local function closedNow(C, q)
	if type(q.closedBy) ~= "table" then return false end
	for _, by in ipairs(q.closedBy) do
		if by ~= q.id and (inLog(C, by) or completed(C, by)) then return true end
	end
	return false
end

local function chainOpen(C, q)
	if type(q.chain) ~= "table" then return false end
	for _, id in ipairs(q.chain) do
		if not completed(C, id) then return true end
	end
	return false
end

local function xpOf(q)
	local x = q.rewards and q.rewards.xp
	return type(x) == "number" and x or 0
end

-- Exclusive groups: quests that close each other (each names the other in
-- closedBy). One a group counts: the one in the log, else the one worth the
-- most, else the first. -> { [id] = true } for the ones left out.
local function alternatives(C, list)
	local byId = {}
	for _, q in ipairs(list) do byId[q.id] = q end
	local function mutual(a, b)
		if type(a.closedBy) ~= "table" or type(b.closedBy) ~= "table" then return false end
		local ab, ba = false, false
		for _, id in ipairs(a.closedBy) do if id == b.id then ab = true end end
		for _, id in ipairs(b.closedBy) do if id == a.id then ba = true end end
		return ab and ba
	end
	local out, seen = {}, {}
	for _, q in ipairs(list) do
		if not seen[q.id] and type(q.closedBy) == "table" then
			local group = { q }
			seen[q.id] = true
			for _, by in ipairs(q.closedBy) do
				local o = byId[by]
				if o and not seen[o.id] and mutual(q, o) then
					group[#group + 1] = o
					seen[o.id] = true
				end
			end
			if #group > 1 then
				local keep = group[1]
				for _, g in ipairs(group) do
					if inLog(C, g.id) then keep = g break end
					if xpOf(g) > xpOf(keep) then keep = g end
				end
				for _, g in ipairs(group) do
					if g ~= keep then out[g.id] = true end
				end
			end
		end
	end
	return out
end

function Dungeons.QuestXP(key, p)
	if not Dungeons.Get(key) then return nil end
	local Levels, C = ns.Levels, ns.Compat
	p = p or Levels.Player()
	local side = SIDE[p.faction or ""]
	local left = { class = 0, race = 0, faction = 0, closed = 0, alt = 0 }
	if side then
		for _, q in ipairs(Dungeons.Quests(key)) do
			if q.faction ~= nil and q.faction ~= side then left.faction = left.faction + 1 end
		end
	end
	local page = Dungeons.Quests(key, side)
	local alt = alternatives(C, page)
	local quests, start = {}, nil
	for _, q in ipairs(page) do
		local done = completed(C, q.id)
		local _, why = Dungeons.QuestFor(q)
		local logged = not done and inLog(C, q.id)
		local skip
		if done then
			skip = nil -- Levels.Run counts it as done
		elseif why then
			left[why] = left[why] + 1
			skip = true
		elseif not logged and closedNow(C, q) then
			left.closed = left.closed + 1
			skip = true
		elseif alt[q.id] then
			left.alt = left.alt + 1
			skip = true
		end
		if not skip then
			local group
			if not done then
				if logged then
					group = "ready"
				elseif chainOpen(C, q) then
					group = "chain"
				elseif q.minLevel and (p.level or 1) < q.minLevel then
					group = "level"
				else
					group = "ready"
				end
				if q.minLevel then start = start and min(start, q.minLevel) or q.minLevel end
			end
			quests[#quests + 1] = { id = q.id, level = q.level, xp = q.rewards and q.rewards.xp, classes = q.classes, group = group, minLevel = q.minLevel }
		end
	end
	local s = Levels.Run(quests, p, start)
	s.left = left
	-- Where the ready ones alone take the character, from where they are now.
	local ready = {}
	for _, e in ipairs(quests) do
		if e.group == "ready" then ready[#ready + 1] = e end
	end
	if #ready > 0 then
		local r = Levels.Run(ready, p)
		s.ready = { from = r.from, to = r.to, levels = r.levels }
	end
	return s
end

function Dungeons.ChainXP(key, id, p)
	local q = Dungeons.Quest(key, id)
	if not (q and type(q.chain) == "table" and #q.chain > 0) then return nil end
	local Levels, C = ns.Levels, ns.Compat
	p = p or Levels.Player()
	local quests, start = {}, nil
	local function add(cq)
		local _, why = Dungeons.QuestFor(cq)
		quests[#quests + 1] = { id = cq.id, level = cq.level, xp = cq.rewards and cq.rewards.xp, classes = cq.classes, blocked = why ~= nil }
		local open = not completed(C, cq.id) and why == nil
		if open and cq.minLevel then start = start and min(start, cq.minLevel) or cq.minLevel end
	end
	for _, cid in ipairs(q.chain) do add(Dungeons.Quest(key, cid) or { id = cid }) end
	add(q)
	return Levels.Run(quests, p, start)
end
