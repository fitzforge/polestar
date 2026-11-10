-- How far a route takes this character: the XP of its quests and, for a
-- guide, of the kills it asks for, in route order, with the client's
-- reduction for quests far below and nothing for grey mobs, and the level
-- that leaves them at. The dungeon page (Dungeons.QuestXP: quests only) and
-- the guide menu (Levels.ForGuide) read it; UI/LevelTip.lua draws it.
--
--   Levels.Run(entries[, p[, start]]) -> summary
--     entries, in route order:
--       { kind = "quest" (or nil), id, level, xp (full reward | nil: not known), classes = { CLASS } | nil }
--       { kind = "kill", n (kills), mob (level), elite }
--       { kind = "kill" } with no n: a kill or loot goal that could not be estimated
--     p: { level, xp, xpMax, class, faction } (default: this character)
--     start: the level the route starts at; below it the sums run from there,
--       at none of that level's XP (summary.below = start)
--     summary = { quests (counted, with XP known), unknown (no XP known),
--       done (left out: done), other (left out: another class), reduced (quests
--       giving less than full XP), questXP, kills (estimated kills), killXP,
--       killsUnknown (goals not estimated), xp (questXP + killXP), maxed
--       (level 60: none counts), below (the start level | nil), now = { level,
--       xp, need } (the character), from (where the sums start: now, or the
--       start level), to = { level, xp, need }, levels (the gain, fractional) }
--   Levels.ForGuide(id[, p[, from[, to]]]) -> summary | nil   -- a guide for this character
--       (its race, class and faction: the steps' and goals' `only`), from its
--       minLevel when below it: each turn-in once, its XP from the Codex; each
--       kill goal's kills, and each loot goal's from its drop chance
--       (count / chance, the goal's own mob else the item's likeliest), at the
--       mob's level; an objective split over steps once, nothing for quests
--       done. from/to: only steps from..to-1, from where the character is
--       (no minLevel start). nil: no guide, or no Codex to read (the Codex is
--       loaded for it only while lookup.enabled, as Lookup owns it)
--   Levels.Pace([p]) -> pace | nil  -- where the character stands against the
--       active guide, from the live step: its next level target
--       (Engine.LevelTarget, kind "goal": the guide holds you at that step
--       until you have it) or, with none ahead, a leveling guide's own end
--       level (its `levels` top, kind "end", at its last step) against what
--       the steps up to there give. pace = { target, step, reach (the level
--       they leave you at, fractional), bars (the XP bar's 20 per level
--       short; 0: on pace), short (levels short, 0 on pace), xp (XP short),
--       kind, live, hard }. hard: the first open quest before the target that
--       is 3 or more levels above where the route has you when you get there,
--       { quest, title, level, step, reach, need (its level - 2: no longer
--       hard), xp (XP from reach to need) } | nil. nil at 60, without a live
--       step or the Codex, and with no target (no `level` goal ahead in a
--       guide that is not a leveling one)
--   Levels.StepHint(i[, p]) -> { quest, title, level, you } | nil  -- step i
--       of the active guide holds work (not an accept, a hand-in or a talk)
--       on an open quest 3 or more levels above the character (you: their
--       level and share of it, 19.75)
--   Levels.QuestLevel(qid[, g]) -> level | nil  -- guide g's own (an accept's
--       qlvl), else the Codex's while loaded, else the client's
--   Levels.Player() -> p ; Levels.LEVEL_XP[L] -> XP from L to L + 1 ; Levels.MAX_LEVEL
--   Levels.Share(playerLevel, questLevel) -> 1, 0.8, 0.6, 0.4, 0.2 or 0.1
--   Levels.MobXP(playerLevel, mobLevel, elite) -> XP for one kill
--
-- The rules are the tools' (tools/lib/game/xp.js; tests/levels.test.js keeps
-- them the same): the 1.12 level table, where the client's own XP to level
-- (UnitXPMax) is taken for the level the character is at; a quest's full
-- reward reduced by how far the player is above it; 45 + 5 x level for an
-- equal-level mob, more above, less below, none when grey, elites x2.

local ADDON, ns = ...

local Levels = {}
ns.Levels = Levels

local type, ipairs, pairs, floor, ceil, max, min = type, ipairs, pairs, math.floor, math.ceil, math.max, math.min

-- XP to go from level L to L + 1 (index L).
local LEVEL_XP = {
	400, 900, 1400, 2100, 2800, 3600, 4500, 5400, 6500, 7600,
	8800, 10100, 11400, 12900, 14400, 16000, 17700, 19400, 21300, 23200,
	25200, 27300, 29400, 31700, 34000, 36400, 38900, 41400, 44300, 47400,
	50800, 54500, 58600, 62800, 67100, 71600, 76100, 80800, 85700, 90700,
	95800, 101000, 106300, 111800, 117500, 123200, 129100, 135100, 141200, 147500,
	153900, 160400, 167100, 173900, 180800, 187900, 195000, 202300, 209800,
}
local MAX_LEVEL = 60
Levels.LEVEL_XP, Levels.MAX_LEVEL = LEVEL_XP, MAX_LEVEL

-- Share of a quest's reward by player level - quest level: full up to 5
-- levels above it, then 80/60/40/20%, and 10% from 10 above.
local SHARE = { 0.8, 0.6, 0.4, 0.2 }
local function share(plevel, qlevel)
	local d = plevel - (qlevel or plevel)
	if d <= 5 then return 1 end
	if d >= 10 then return 0.1 end
	return SHARE[d - 5]
end
Levels.Share = share

-- Kill XP: the level gap that brings a lower mob's XP to nothing, the
-- highest grey mob level, and one kill.
local function zeroDiff(l)
	if l <= 7 then return 5 elseif l <= 9 then return 6 elseif l <= 11 then return 7
	elseif l <= 15 then return 8 elseif l <= 19 then return 9 elseif l <= 29 then return 11
	elseif l <= 39 then return 12 elseif l <= 44 then return 13 elseif l <= 49 then return 14
	elseif l <= 54 then return 15 elseif l <= 59 then return 16 end
	return 17
end

local function greyLevel(l)
	if l <= 5 then return 0 end
	if l <= 39 then return l - floor(l / 10) - 5 end
	if l <= 59 then return l - floor(l / 5) - 1 end
	return l - 9
end

-- Rounded as the tools round (half up; no value here is negative).
local function mobXP(plevel, mob, elite)
	local base = plevel * 5 + 45
	local v
	if mob >= plevel then
		v = base * (1 + 0.05 * min(mob - plevel, 4))
	elseif mob <= greyLevel(plevel) then
		v = 0
	else
		v = max(0, base * (1 - (plevel - mob) / zeroDiff(plevel)))
	end
	return floor(v + 0.5) * (elite and 2 or 1)
end
Levels.MobXP = mobXP

local function hasClass(list, class)
	if type(list) ~= "table" or #list == 0 or not class then return true end
	for _, c in ipairs(list) do
		if c == class then return true end
	end
	return false
end

function Levels.Player()
	local C = ns.Compat
	local info = C and C.GetPlayerInfo and C.GetPlayerInfo() or {}
	return { level = info.level or 1, xp = info.xp or 0, xpMax = info.xpMax, class = info.class, race = info.race, faction = info.faction }
end

function Levels.Run(entries, p, start)
	p = p or Levels.Player()
	local C = ns.Compat
	local below = start and (p.level or 1) < start and start or nil
	local level = below or p.level or 1
	-- The client's XP to level for the level the character is at; the table past it.
	local function need(l)
		if l == p.level and (p.xpMax or 0) > 0 then return p.xpMax end
		return LEVEL_XP[l] or 0
	end
	local s = {
		quests = 0, unknown = 0, done = 0, other = 0, reduced = 0, questXP = 0,
		kills = 0, killXP = 0, killsUnknown = 0, xp = 0,
		maxed = level >= MAX_LEVEL, below = below,
		now = { level = p.level or 1, xp = p.xp or 0, need = need(p.level or 1) },
	}
	s.from = below and { level = below, xp = 0, need = need(below) } or s.now
	local xp = s.from.xp
	local function gain(n)
		s.xp = s.xp + n
		xp = xp + n
		while level < MAX_LEVEL and xp >= need(level) do
			xp = xp - need(level)
			level = level + 1
		end
		if level >= MAX_LEVEL then xp = 0 end
	end
	for _, e in ipairs(entries) do
		if e.kind == "kill" then
			if not e.n then
				s.killsUnknown = s.killsUnknown + 1
			elseif level < MAX_LEVEL then
				-- One kill at a time: a level gained on the way lowers the rest.
				for _ = 1, e.n do
					local one = mobXP(level, e.mob or level, e.elite)
					s.kills, s.killXP = s.kills + 1, s.killXP + one
					gain(one)
				end
			end
		elseif C and C.IsQuestCompleted and e.id and C.IsQuestCompleted(e.id) then
			s.done = s.done + 1
		elseif not hasClass(e.classes, p.class) then
			s.other = s.other + 1
		else
			local full = e.xp
			if type(full) ~= "number" or full <= 0 then
				s.unknown = s.unknown + 1
			elseif level < MAX_LEVEL then
				local part = share(level, e.level)
				local one = floor(full * part + 0.5)
				if part < 1 then s.reduced = s.reduced + 1 end
				s.quests, s.questXP = s.quests + 1, s.questXP + one
				gain(one)
			end
		end
	end
	s.to = { level = level, xp = xp, need = need(level) }
	local function at(t) return t.level + (t.need > 0 and t.xp / t.need or 0) end
	s.levels = at(s.to) - at(s.from)
	return s
end

-- A mob's level for the sums: the middle of its range.
local function mobOf(Cx, npc)
	local rec = npc and Cx.Npc and Cx.Npc(npc)
	if not (rec and rec.level) then return nil end
	return floor((rec.level + (rec.levelMax or rec.level)) / 2), rec.elite
end

-- The kills a loot goal takes: count over its drop chance from the goal's own
-- mob, else the item's likeliest dropper. -> n, mob level, elite | nil (no
-- drop to estimate from: an object, a vendor, a chance not known)
local function lootKills(Cx, goal)
	local item = goal.item and Cx.Item and Cx.Item(goal.item)
	if not (item and type(item.sources) == "table") then return nil end
	local own = goal.fromKind == "npc" and goal.fromId or nil
	local best
	for _, src in pairs(item.sources) do
		-- Also picked up from an object, and no mob named: gathered, no kills.
		if src.type == "object" and not own then return nil end
	end
	for _, src in pairs(item.sources) do
		if src.type == "drop" and src.npc and (src.chance or 0) > 0 then
			if src.npc == own then
				best = src
				break
			end
			if not best or src.chance > best.chance then best = src end
		end
	end
	if not best then return nil end
	local mob, elite = mobOf(Cx, best.npc)
	if not mob then return nil end
	return ceil((goal.count or 1) / (min(best.chance, 100) / 100)), mob, elite
end

-- A span's entries depend on the guide (its table: an updated import is a new one), the span, who the character is (level, class, race, faction:
-- the steps' `only`) and which quests are turned in; not on the XP inside a level, which moves on every
-- kill. The guide window's pace line asks on every PLAYER_XP_UPDATE (GF.UpdateXP > Levels.Pace, up to
-- five spans through hardQuest), and each scan walked every step left, building a table per goal: a
-- 5-25 ms frame per kill on a long guide, then its garbage. Kept until one of those changes.
local spans, spanCount = {}, 0
local SPAN_MAX = 32
function Levels.Invalidate()
	spans, spanCount = {}, 0
end
for _, ev in ipairs({ "QUEST_TURNED_IN", "PLAYER_LEVEL_UP" }) do
	if ns.RegisterEvent then ns.RegisterEvent(ev, Levels.Invalidate) end
end
for _, msg in ipairs({ "GUIDES_REGISTERED", "PACKS_CHANGED", "CODEX_LOADED", "GUIDE_CHANGED" }) do
	if ns.On then ns.On(msg, Levels.Invalidate) end
end

function Levels.ForGuide(id, p, from, to)
	local G, Cx = ns.Guides, ns.Codex
	local g = G and G.Get and G.Get(id)
	if not (g and type(g.steps) == "table" and Cx and Cx.Quest) then return nil end
	-- The Codex is Lookup's: loaded here only while Lookup is on.
	if not (Cx.IsLoaded and Cx.IsLoaded()) then
		if not (ns.Get("lookup.enabled") and Cx.Load and Cx.Load()) then return nil end
	end
	p = p or Levels.Player()
	local key = table.concat({ tostring(g), tostring(from), tostring(to), tostring(p.level), tostring(p.class), tostring(p.race), tostring(p.faction) }, "|")
	local cached = spans[key]
	if cached then return Levels.Run(cached, p, not from and g.minLevel or nil) end
	local C = ns.Compat
	local fits = G.Matches
	local function applies(only)
		return type(only) ~= "table" or not fits or fits(only, p)
	end
	local function done(qid)
		return qid and C and C.IsQuestCompleted and C.IsQuestCompleted(qid) or false
	end
	local entries, turnedIn, counted = {}, {}, {}
	for si, step in ipairs(g.steps) do
		if (not from or si >= from) and (not to or si < to) and applies(step.only) and type(step.goals) == "table" then
			for _, goal in ipairs(step.goals) do
				if applies(goal.only) then
					local t, qid = goal.t, goal.quest
					if t == "turnin" and qid and not turnedIn[qid] then
						turnedIn[qid] = true
						local rec = Cx.Quest(qid)
						entries[#entries + 1] = { id = qid, level = rec and rec.level, xp = rec and rec.xp }
					elseif (t == "kill" or (t == "collect" and goal.fromKind ~= "object")) and not done(qid) then
						-- An objective split over steps is counted once.
						local key = qid and (qid .. ":" .. (goal.oi or 0)) or nil
						if not (key and counted[key]) then
							if key then counted[key] = true end
							if t == "kill" then
								local mob, elite = mobOf(Cx, goal.npc)
								entries[#entries + 1] = { kind = "kill", n = mob and (goal.count or 1) or nil, mob = mob, elite = elite }
							else
								local n, mob, elite = lootKills(Cx, goal)
								-- Loot with no drop behind it (gathered, bought) needs no kills.
								if n or goal.fromKind == "npc" then
									entries[#entries + 1] = { kind = "kill", n = n, mob = mob, elite = elite }
								end
							end
						end
					end
				end
			end
		end
	end
	if spanCount >= SPAN_MAX then spans, spanCount = {}, 0 end
	spans[key], spanCount = entries, spanCount + 1
	return Levels.Run(entries, p, not from and g.minLevel or nil)
end

-- A quest 3 or more levels above the character: the quest log's orange and
-- red, hard to do alone.
local HARD = 3

local function at(t) return t.level + (t.need > 0 and t.xp / t.need or 0) end

-- XP from where t stands ({ level, xp, need }, as Levels.Run's `to`) to
-- level `target` (12.4: 40% into level 12); 0 when there already.
local function xpTo(t, target)
	local n = floor(target)
	local f = target - n
	if t.level > n or (t.level == n and t.xp >= f * t.need) then return 0 end
	if t.level == n then return ceil(f * t.need - t.xp) end
	local sum = t.need - t.xp
	for l = t.level + 1, n - 1 do sum = sum + (LEVEL_XP[l] or 0) end
	return ceil(sum + f * (LEVEL_XP[n] or 0))
end

local qlvls = setmetatable({}, { __mode = "k" })
function Levels.QuestLevel(qid, g)
	if not qid then return nil end
	if type(g) == "table" and type(g.steps) == "table" then
		local map = qlvls[g]
		if not map then
			map = {}
			for _, step in ipairs(g.steps) do
				for _, goal in ipairs(type(step.goals) == "table" and step.goals or {}) do
					local l = goal.quest and tonumber(goal.qlvl)
					if l and l > 0 and not map[goal.quest] then map[goal.quest] = l end
				end
			end
			qlvls[g] = map
		end
		if map[qid] then return map[qid] end
	end
	local Cx = ns.Codex
	local rec = Cx and Cx.IsLoaded and Cx.IsLoaded() and Cx.Quest and Cx.Quest(qid)
	if type(rec) == "table" and type(rec.level) == "number" and rec.level > 0 then return rec.level end
	local C = ns.Compat
	return C and C.GetQuestLevel and C.GetQuestLevel(qid) or nil
end

-- Whether quest q asks for work in guide g: a goal of its own objectives in
-- the guide (kill, collect, use, interact, complete, or one naming its
-- objective), or objectives in the Codex (work done in another guide). A
-- delivery (Calling in the Reserves: taken at Sun Rock, handed in at the
-- Great Lift) has none: its level asks nothing of the character.
local worked = setmetatable({}, { __mode = "k" })
local WORK = { kill = true, collect = true, use = true, interact = true, complete = true }
local function asksWork(g, q)
	local map = worked[g]
	if not map then
		map = {}
		for _, step in ipairs(g.steps) do
			for _, goal in ipairs(type(step.goals) == "table" and step.goals or {}) do
				local t = goal.t
				if goal.quest and t ~= "accept" and t ~= "turnin" and t ~= "note" and (WORK[t] or goal.oi ~= nil) then map[goal.quest] = true end
			end
		end
		worked[g] = map
	end
	if map[q] then return true end
	local Cx = ns.Codex
	local rec = Cx and Cx.IsLoaded and Cx.IsLoaded() and Cx.Quest and Cx.Quest(q)
	return type(rec) == "table" and type(rec.objectives) == "table" and #rec.objectives > 0
end

-- The highest open quest on step s of guide g for this character: a goal of
-- a quest neither done nor ready to hand in, other than its turn-in or a
-- talk (never hard), of a quest that asks for work (asksWork: never a
-- delivery); with `work`, not its accept either (taking a quest is not
-- doing it: the pace line points at the step that does). The active guide
-- asks the Engine what applies (`when`, quests the route leaves out);
-- another, the steps' and goals' `only`. -> quest, level, title (the
-- client's, Polestar.Names, else the guide's) | nil
local function stepQuest(g, s, p, work)
	local step = g.steps[s]
	if not (step and type(step.goals) == "table") then return nil end
	local E, G, C = ns.Engine, ns.Guides, ns.Compat
	local active = E and E.GetGuide and E.GetGuide() == g and E.Applies
	local fits = G and G.Matches
	if not active and fits and type(step.only) == "table" and not fits(step.only, p) then return nil end
	local best, lvl, title
	for gi, goal in ipairs(step.goals) do
		local q, t = goal.quest, goal.t
		local open = q and t ~= "turnin" and t ~= "talk" and not (work and t == "accept") and asksWork(g, q)
			and not (C and C.IsQuestCompleted and C.IsQuestCompleted(q))
			and not (C and C.IsQuestReadyForTurnIn and C.IsQuestReadyForTurnIn(q))
		if open then
			if active then
				open = E.Applies(s, gi)
			else
				open = not (fits and type(goal.only) == "table") or fits(goal.only, p)
			end
		end
		local l = open and Levels.QuestLevel(q, g)
		if l and (not lvl or l > lvl) then best, lvl, title = q, l, goal.title end
	end
	return best, lvl, best and ns.Names and ns.Names.Quest(best) or title
end

function Levels.StepHint(i, p)
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	if not (type(g) == "table" and type(g.steps) == "table" and type(i) == "number") then return nil end
	p = p or Levels.Player()
	local lvl = p.level or 1
	if lvl >= MAX_LEVEL then return nil end
	-- Only work on the step counts (kills, objectives): taking a quest above
	-- your level early is normal, and an accept-only step says nothing.
	local q, l, title = stepQuest(g, i, p, true)
	if not (l and l - lvl >= HARD) then return nil end
	return { quest = q, title = title, level = l, you = lvl + ((p.xpMax or 0) > 0 and (p.xp or 0) / p.xpMax or 0) }
end

-- The first open quest on steps from..to that is HARD levels above where the
-- route has the character when they get there (Levels.ForGuide up to its
-- step). Only quests HARD above the character now can be; at most four are
-- looked into.
local function hardQuest(g, p, from, to)
	local lvl, tries, seen = p.level or 1, 0, {}
	for s = from, min(to, #g.steps) do
		local q, l, title = stepQuest(g, s, p, true)
		if q and l - lvl >= HARD and not seen[q] then
			seen[q] = true
			local t
			if s == from then
				t = { level = lvl, xp = p.xp or 0, need = (p.xpMax or 0) > 0 and p.xpMax or LEVEL_XP[lvl] or 0 }
			else
				local run = Levels.ForGuide(g.id, p, from, s)
				if not run then return nil end
				t = run.to
			end
			if l - t.level >= HARD then
				return { quest = q, title = title, level = l, step = s, reach = at(t), need = l - (HARD - 1), xp = xpTo(t, l - (HARD - 1)) }
			end
			tries = tries + 1
			if tries >= 4 then return nil end
		end
	end
	return nil
end

-- The last step of the active guide g at or after `live` the player gets to
-- see (applies, not hidden).
local function lastStep(E, g, live)
	for s = #g.steps, live, -1 do
		local hidden = E.StepNumber and select(2, E.StepNumber(s))
		if not hidden and (not E.Applies or E.Applies(s)) then return s end
	end
	return nil
end

function Levels.Pace(p)
	local E, G = ns.Engine, ns.Guides
	local active = E and E.GetGuide and E.GetGuide()
	local live = active and E.GetLiveStep and E.GetLiveStep()
	local g = live and (G and G.Get and G.Get(active.id) or active)
	if not (g and type(g.steps) == "table") then return nil end
	p = p or Levels.Player()
	if (p.level or 1) >= MAX_LEVEL then return nil end
	local kind, n, step, frac = "goal", nil, nil, nil
	if E.LevelTarget then n, step, frac = E.LevelTarget(p.level) end
	if not (n and step and step >= live) then
		-- No `level` goal ahead: a leveling guide's end, where the next one
		-- starts (its `levels` top).
		if (g.category or "Leveling") ~= "Leveling" or type(g.maxLevel) ~= "number" then return nil end
		kind, n, frac, step = "end", g.maxLevel, nil, lastStep(E, g, live)
		if not step then return nil end
	end
	local target = n + (frac or 0)
	-- Up to a level goal's step (it holds you there); to the end, every step.
	local s = Levels.ForGuide(g.id, p, live, kind == "goal" and step or nil)
	if not s then return nil end
	local reach = at(s.to)
	local short = max(0, target - reach)
	return {
		target = target, step = step, reach = reach, bars = short > 0 and ceil(short * 20) or 0,
		short = short, xp = xpTo(s.to, target), kind = kind, live = live,
		hard = hardQuest(g, p, live, kind == "goal" and step - 1 or step),
	}
end
