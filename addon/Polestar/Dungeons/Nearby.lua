-- Polestar.Dungeons, dungeon quests to take on the way: Dynamic Questing's
-- "While you're here" offers the giver of one when the player walks by
-- (behavior.whileHereDungeons, Engine Own.hereDungeons), so a dungeon's
-- quests and the start of their chains are picked up during the normal
-- guide, with no pick-up guide of their own.
--
--   Dungeons.TakeNow(level) -> { { quest, title, key, name, minLevel, maxLevel, giver, forQuest } }
--       quest: a quest the character can take now (level, side, class, its
--       prerequisites done) from a giver out in the world; giver: its point
--       { kind = "npc" | "object", id, name, map, x, y, f }; forQuest: the
--       dungeon quest it leads to when it is a prerequisite (nil: it is one).
--       Of each dungeon whose floor is at most TAKE_AHEAD levels above
--       `level` and that the character has not outgrown (its maxLevel), not a
--       city dungeon of the other faction, by its pick-up plan
--       (Dungeons.PickupPlan): a planned quest itself when nothing comes
--       before it, else the first open quest of its chain. A quest the game
--       gives only from a higher level waits for it: no "!" over the giver.
--       Built once per level and kept until the quest log changes (an
--       accept, a hand-in, an abandon) or the level does: the While you're
--       here poll only reads it.
--   Dungeons.TAKE_AHEAD = 10   -- levels a dungeon's floor may be above the character
--   Dungeons.TAKE_ROOM = 5     -- free quest log slots (Own.logRoom) a dungeon pick-up leaves

local ADDON, ns = ...
local Dungeons = ns.Dungeons

Dungeons.TAKE_AHEAD = 10
Dungeons.TAKE_ROOM = 5

local SIDE = { Alliance = "A", Horde = "H" }
local cache, cacheLevel -- TakeNow's list and the level it was built at

local function dirty() cache = nil end
ns.RegisterEvent("QUEST_ACCEPTED", dirty)
ns.RegisterEvent("QUEST_TURNED_IN", dirty)
ns.RegisterEvent("QUEST_REMOVED", dirty)
ns.RegisterEvent("PLAYER_LEVEL_UP", dirty)

local function open(id)
	local C = ns.Compat
	return not (C.IsOnQuest(id) or C.IsQuestCompleted(id))
end

local function build(level)
	local out, seen = {}, {}
	local side = SIDE[UnitFactionGroup("player") or ""]
	if not (side and Dungeons.IsEnabled() and Dungeons.PickupPlan and Dungeons.PreDone) then return out end
	local from = ns.PlayerPoint()
	for _, d in ipairs(Dungeons.List()) do
		local floor = d.floor or d.minLevel
		if d.kind == "dungeon" and floor and floor <= level + Dungeons.TAKE_AHEAD and not (d.maxLevel and level > d.maxLevel)
			and (d.quests and d.quests[side] or 0) > 0 and not (Dungeons.EnemyCapital and Dungeons.EnemyCapital(d.key, side)) then
			local plan = Dungeons.PickupPlan(d.key)
			for _, t in ipairs(plan and plan.take or {}) do
				-- The first open quest of its chain, else the planned quest itself.
				local id, rec, giver, first
				for _, r in ipairs(t.pre or {}) do
					if open(r.id) then
						first = r
						break
					end
				end
				if first then
					id, rec = first.id, first
					if Dungeons.PreDone(first) then giver = Dungeons.Giver({ id = id }, from, first) end
				else
					id, rec, giver = t.quest.id, t.rec, t.giver
				end
				local lowest = (rec and rec.minLevel) or (not first and t.quest.minLevel) or 1
				if giver and giver.kind ~= "drop" and giver.map and giver.x and giver.y and lowest <= level and not seen[id] and open(id) then
					seen[id] = true
					out[#out + 1] = { quest = id, title = (rec and rec.title) or (not first and t.quest.title) or nil, key = d.key, name = d.name,
						minLevel = d.minLevel, maxLevel = d.maxLevel, giver = giver, forQuest = first and t.quest or nil }
				end
			end
		end
	end
	return out
end

function Dungeons.TakeNow(level)
	if type(level) ~= "number" then return {} end
	if not cache or cacheLevel ~= level then
		local ok, got = pcall(build, level)
		cache, cacheLevel = ok and got or {}, level
	end
	return cache
end
