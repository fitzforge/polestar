-- Polestar.Dungeons, handing in a dungeon's quests after the run: the page's
-- quests in the log, each routed to where it is turned in once its
-- objectives are done, and the follow-ups those turn-ins open, taken from the
-- same NPC or one close by. The guide is a Lookup planner kind ("handin",
-- Lookup/Guide.lua): registered as "lookup/handin/<key>", opened in a new tab
-- (in the place of the dungeon's pick-up guide once that one is finished or
-- at its last step), rebuilt after /reload.
--
--   Dungeons.HandinPlan(key) -> plan | nil, reason
--       plan = { dungeon, hand = { { quest, rec, ender, talks } }, unfinished = { quest, ... },
--         inside = { quest, ... }, unplaced = { quest, ... }, errands = { { quest, rec } } }
--       the page's quests in the log: hand (objectives done, or only talks
--       left, turned in outside at `ender`, a point { kind, id, name, map,
--       x, y, f }: Dungeons.Ender, the page's own place when it is the
--       character's side's, else the Codex's ender of that side nearest the
--       player; talks: nil, or the open quest-log lines when each is a talk
--       objective at an NPC outside this character may speak to, each a
--       point with its line `oi`: The Glowing Shard's Sputtervalve in
--       Ratchet before Falla Sagewind, #1326), unfinished (other objectives
--       still open), inside (done, turned in inside the dungeon), unplaced
--       (done, nowhere known); errands: those of `unfinished` done outside
--       that are the next part of a chain of the page's quests (an earlier
--       part done) and whose objectives are all errand items (below);
--       HandinGuide places each as HandinFollowUps' `errand`, then its
--       ender (one it cannot place stays a note). No follow-up search and
--       no placing: the Dungeons page asks for the plan on every render.
--   Dungeons.HandinFollowUps(plan) -> { { rec, giver, after = { questId, ... }, ender, errand } }
--       the quests the `hand` quests open (Codex.FollowUps: every `pre`
--       done or handed in here, and one of `preAny` when it has any) that
--       this character can take (Lookup.QuestBlock: faction, race, class,
--       level), not done or in the log, from a giver (NPC or object) that is
--       the one a quest of `after` is turned in to or within NEAR seconds of
--       it (ns.TravelCost); ender: where one among them is turned in when
--       nothing is left to do once it is taken (no objectives: Earthen Echo,
--       #1748; only items the bags hold: Prehistoric Prism, #1817), or once
--       its errand is done, this character's side's, on the giver's
--       continent; errand: for one of this dungeon's own page quests done
--       outside it, the collect goals of its objectives when every one is an
--       errand item, one to be had out in the world: no instance's NPC or
--       object gives it, and an NPC or object spawned outside does at least
--       ERRAND_CHANCE percent of the time (placed at its nearest spawn), or
--       a vendor of the character's side sells it (the nearest): Unending
--       Torment's Toxic Skullcap, Blisterweed and Essence of Agony, #2173.
--       In objective order, each placed from the one before it; nil when an
--       objective is anything else or has no place
--   Dungeons.HandinGuide(key) -> def | nil, reason   -- "nothing" when no quest can be handed in
--   Dungeons.HandIn(key) -> guideId | nil, reason    -- builds, registers and opens it
--   Dungeons.HandinText(plan) -> text                -- why nothing can be handed in, one line
--   Dungeons.HandinStale(key, guide) -> bool         -- a quest the plan hands in now that no
--       turn-in of `guide` does; the hand-in guide in the active tab is rebuilt in its tab then
--       (on QUEST_ACCEPTED, QUEST_LOG_UPDATE and a tab change, half a second later)
--
-- Route: one stop per place a quest is turned in (every quest turned in
-- there, then the follow-ups that place gives once what they wait on is
-- turned in there), one per NPC a quest's talk line is at (before the
-- place it is turned in), one per other giver of follow-ups (after the
-- turn-ins they wait on), one per follow-up's errand (a step of its own,
-- titled with the quest, after the stop that gives it), and one per ender of
-- a follow-up handed in on the way (after its errand, else after the stop
-- that gives it), in the order of Dungeons.OrderStops
-- from where the player stands, with no fixed end (kept per character as
-- CharState().dungeonHandin[key]). Stops at the same NPC in a row are one
-- step. The last step lists the quests not handed in as notes.

local ADDON, ns = ...
local L = ns.L
local Dungeons = ns.Dungeons

local type, ipairs, format, concat, sort = type, ipairs, string.format, table.concat, table.sort

local KIND = "handin"
local NEAR = 60 -- seconds of travel from a turn-in to a follow-up's giver

local function LK() return ns.Lookup end

local function done(id) return ns.Compat.IsQuestCompleted(id) and true or false end
local function inLog(id) return ns.Compat.IsOnQuest(id) and true or false end

-- Lookup.QuestEnd's { npc|object, name, spawn } -> a point.
local function endPoint(e)
	if not (e and e.spawn) then return nil end
	local s = e.spawn
	return { kind = e.npc and "npc" or "object", id = e.npc or e.object, name = e.name, map = s.map, x = s.x, y = s.y, f = s.f }
end

local function pointKey(p) return p.kind .. p.id end

local function continentOf(pt)
	return pt and pt.map and (ns.Compat.MapToWorld(pt.map, pt.x, pt.y, pt.f)) or nil
end

-- Its objectives done: the client says so, or the quest has none (a
-- delivery), which some clients never flag complete.
local function finished(id, rec)
	local C = ns.Compat
	if C.IsQuestReadyForTurnIn(id) then return true end
	return rec ~= nil and #(rec.objectives or {}) == 0 and C.GetQuestObjectives(id) == nil
end

-- Nothing left to do once quest record `rec` is taken: it has no objectives
-- (a delivery), or only items the bags hold enough of (Prehistoric Prism
-- asks for the Titan Relic that Lost Relic Carry was, #1817).
local function carried(rec)
	local C = ns.Compat
	for _, o in ipairs(rec.objectives or {}) do
		if not (o.type == "item" and o.id and C.GetItemCount(o.id) >= (o.count or 1)) then return false end
	end
	return true
end

-- The talks left before quest `id` can be handed in: its open quest-log
-- lines when each is a talk objective of the Codex quest at an NPC with a
-- place this character may speak to (Lookup.QuestEnd), as points with the
-- line's `oi`; nil when a line is anything else (a kill, an item, an event,
-- one the Codex does not know) or none is open. The client's lines decide
-- which are open; without them, every line of the Codex quest is.
local function talksLeft(id, rec, from, p)
	local objs = rec and rec.objectives
	if type(objs) ~= "table" or #objs == 0 then return nil end
	local lines = ns.Compat.GetQuestObjectives(id)
	local Lk, out = LK(), {}
	for oi = 1, math.max(#objs, lines and #lines or 0) do
		local line = lines and lines[oi]
		if not (line and line.finished) then
			local o = objs[oi]
			if not (o and o.type == "talk" and o.id) then return nil end
			local e = Lk.QuestEnd({ npc = { o.id } }, from, p)
			local at = e and not e.hostile and endPoint(e)
			if not at then return nil end
			at.oi = oi
			out[#out + 1] = at
		end
	end
	return #out > 0 and out or nil
end

local function titleOf(pq, rec) return pq.title or (rec and rec.title) or "" end

-- An errand's item sources (#2173): a vendor, or an NPC that drops it or an
-- object it lies in, spawned outside any instance, that gives it at least
-- ERRAND_CHANCE percent of the time (or of no known chance: an object to
-- pick). An item any instance's NPC or object gives is the run's, never an
-- errand's; so is one only rare chests or drops give (Silver Bars).
local ERRAND_CHANCE = 25

-- source -> record, kind ("npc" | "object"), "inside" | "world" | nil
local function sourceOf(src)
	local C = ns.Codex
	local r, k
	if src.type == "drop" and src.npc then
		r, k = C.Npc(src.npc), "npc"
	elseif src.type == "object" and src.object then
		r, k = C.Object(src.object), "object"
	end
	if not r then return nil end
	if src.instance or r.instance then return r, k, "inside" end
	local ok = type(r.spawns) == "table" and #r.spawns > 0 and (src.chance == nil or src.chance >= ERRAND_CHANCE)
	return r, k, ok and "world" or nil
end

-- Whether `item` can be had for an errand, placing nothing (cheap).
local function errandItem(item)
	if not item then return false end
	local ok = false
	for _, src in ipairs(item.sources or {}) do
		local _, _, where = sourceOf(src)
		if where == "inside" then return false end
		ok = ok or where == "world" or (src.type == "vendor" and src.npc ~= nil)
	end
	return ok
end

-- Where errand item `item` is had, from `at`: the nearest spawn of its best
-- source out in the world, else the nearest vendor of the character's side
-- who sells it. -> spot, source record, source kind, sold (a vendor) | nil
local function itemSource(item, at, p)
	local C, Lk = ns.Codex, LK()
	if not errandItem(item) then return nil end
	local spot, chance, rec, kind
	for _, src in ipairs(item.sources or {}) do
		local r, k, where = sourceOf(src)
		if where == "world" then
			local c = src.chance or 100
			if not spot or c > chance then
				spot, chance, rec, kind = Lk.Nearest(r.spawns, at), c, r, k
			end
		end
	end
	if spot then return spot, rec, kind end
	local sellers = {}
	for _, src in ipairs(item.sources or {}) do
		if src.type == "vendor" and src.npc then sellers[#sellers + 1] = src.npc end
	end
	local e = #sellers > 0 and Lk.QuestEnd({ npc = sellers }, at, p) or nil
	if not (e and e.spawn and not e.hostile) then return nil end
	return e.spawn, C.Npc(e.npc), "npc", true
end

-- Whether page quest record `rec` can be an errand (errandGoals) for a
-- quest in the log, placing nothing (the Dungeons page asks for the plan on
-- every render): done outside the dungeon, the next part of a chain of its
-- page quests (a `pre` or `preAny` of it on the page and done: a quest the
-- character took before the run is the run's), every objective an errand
-- item.
local function errandable(key, rec)
	local pq = rec and Dungeons.Quest(key, rec.id)
	if not pq or pq.inside or (pq.finish and pq.finish.inside) then return false end
	local after = false
	for _, list in ipairs({ rec.pre or {}, rec.preAny or {} }) do
		for _, id in ipairs(list) do after = after or (Dungeons.Quest(key, id) ~= nil and done(id)) end
	end
	local objs = rec.objectives or {}
	if not after or #objs == 0 then return false end
	local C = ns.Codex
	for _, o in ipairs(objs) do
		if not (o.type == "item" and o.id and errandItem(C.Item(o.id))) then return false end
	end
	return true
end

-- A follow-up's errand (HandinFollowUps' `errand`): one collect goal per
-- objective, each saying where the item comes from ("Collect Toxic Skullcap
-- from Tawny Grisette"), or nil.
local function errandGoals(key, rec, from, p)
	local pq = Dungeons.Quest(key, rec.id)
	if not pq or pq.inside or (pq.finish and pq.finish.inside) then return nil end
	local objs = rec.objectives or {}
	if #objs == 0 then return nil end
	local C = ns.Codex
	local goals, at = {}, from
	for oi, o in ipairs(objs) do
		local item = o.type == "item" and o.id and C.Item(o.id)
		local spot, src, kind, sold
		if item then spot, src, kind, sold = itemSource(item, at, p) end
		if not spot then return nil end
		local goal = { t = "collect", quest = rec.id, oi = oi, title = rec.title, item = o.id, itemName = item.name or o.text,
			count = o.count or 1, map = spot.map, x = spot.x, y = spot.y, f = spot.f == "e" and "e" or nil }
		if src and src.name then
			goal.from, goal.fromId, goal.fromKind = src.name, src.id, kind
			-- A seller (one of the character's side, Lookup.QuestEnd) is no kill.
			local fac = src.faction
			if fac == "A" or fac == "H" or fac == "AH" then
				goal.fromFaction = fac
			elseif sold then
				goal.fromFaction = "AH"
			end
		end
		goals[#goals + 1] = goal
		at = spot
	end
	return goals
end

function Dungeons.HandinPlan(key)
	local d = Dungeons.Get(key)
	if not d then return nil, "unknown" end
	local Lk, C = LK(), ns.Codex
	if not (Lk and Lk.QuestEnd and C) then return nil, "missing" end
	local from = ns.PlayerPoint()
	local p = Lk.PlayerInfo()
	local plan = { dungeon = d, hand = {}, unfinished = {}, inside = {}, unplaced = {}, errands = {} }
	for _, pq in ipairs(Dungeons.Quests(key)) do
		if inLog(pq.id) and not done(pq.id) then
			local rec = C.Quest(pq.id)
			local ready = finished(pq.id, rec)
			local talks = not ready and talksLeft(pq.id, rec, from, p) or nil
			if not (ready or talks) then
				plan.unfinished[#plan.unfinished + 1] = pq
				-- One whose objectives are items to be had out in the world
				-- (Unending Torment's in the Undercity, #2173): HandinGuide
				-- leads its errand, then its turn-in.
				if errandable(key, rec) then plan.errands[#plan.errands + 1] = { quest = pq, rec = rec } end
			elseif pq.finish and pq.finish.inside then
				plan.inside[#plan.inside + 1] = pq
			else
				local ender = Dungeons.Ender(pq, from, rec)
				if ender then
					plan.hand[#plan.hand + 1] = { quest = pq, rec = rec, ender = ender, talks = talks }
				else
					plan.unplaced[#plan.unplaced + 1] = pq
				end
			end
		end
	end
	return plan
end

function Dungeons.HandinFollowUps(plan)
	local Lk, C = LK(), ns.Codex
	local out = {}
	if not (Lk and C and C.FollowUps and #plan.hand > 0) then return out end
	local p = Lk.PlayerInfo()
	local handed = {}
	for _, h in ipairs(plan.hand) do handed[h.quest.id] = h end
	local function behind(id) return done(id) or handed[id] ~= nil end
	local seen = {}
	for _, h in ipairs(plan.hand) do
		for _, f in ipairs(C.FollowUps(h.quest.id)) do
			if not seen[f.id] then
				seen[f.id] = true
				local open = not (done(f.id) or inLog(f.id) or Lk.QuestBlock(f, p))
				local after = {}
				for _, id in ipairs(f.pre or {}) do
					open = open and behind(id)
					if handed[id] then after[#after + 1] = id end
				end
				local any = f.preAny or {}
				if #any > 0 then
					local one = false
					for _, id in ipairs(any) do
						one = one or behind(id)
						if handed[id] then after[#after + 1] = id end
					end
					open = open and one
				end
				local giver = open and endPoint(Lk.QuestEnd(f.start, h.ender)) or nil
				local near = false
				if giver then
					for _, id in ipairs(after) do
						local e = handed[id].ender
						local t = pointKey(e) ~= pointKey(giver) and Lk.Travel(e, giver) or 0
						near = near or (t ~= nil and t <= NEAR)
					end
				end
				if near then
					-- Handed in on the same route when nothing is left to do
					-- once it is taken (Earthen Echo, from Bashana to Muln
					-- Earthfury, #1748; Prehistoric Prism, the Titan Relic from
					-- Prospector Whelgar to High Explorer Magellas, #1817), or
					-- once its errand out in the world is done (Unending
					-- Torment's three Undercity items, #2173), and its ender is
					-- on the giver's continent (no trip across the sea).
					local errand = not carried(f) and errandGoals(plan.dungeon.key, f, giver, p) or nil
					local last = errand and errand[#errand]
					local e = (carried(f) or errand) and Lk.QuestEnd(f["end"], last or giver, p) or nil
					local ender = e and not e.hostile and endPoint(e) or nil
					if ender and continentOf(ender) ~= continentOf(giver) then ender = nil end
					-- An errand stays on the giver's continent and ends where
					-- its quest is handed in.
					for _, g in ipairs(errand or {}) do
						if continentOf(g) ~= continentOf(giver) then errand = nil break end
					end
					if errand and not ender then errand = nil end
					out[#out + 1] = { rec = f, giver = giver, after = after, ender = ender, errand = errand }
				end
			end
		end
	end
	return out
end

-- A turn-in or accept goal at point `at`, with the height of its NPC's or
-- object's spawn there (Lookup.SpawnZ: the arrow walks to its floor, #1024).
local function questGoal(t, id, title, at)
	local goal = { t = t, quest = id, title = title, map = at.map, x = at.x, y = at.y, f = at.f == "e" and "e" or nil }
	if at.kind == "object" then
		goal.object, goal.objName = at.id, at.name
	else
		goal.npc, goal.npcName = at.id, at.name
	end
	goal.z = LK().SpawnZ(at.kind == "object" and "object" or "npc", at.id, at)
	return goal
end

-- plan, follow-ups -> stops: one per place a quest is turned in, the
-- follow-ups its NPC gives once what they wait on is turned in there, after
-- the stops at the NPCs its quests' talk lines are at; one per other giver
-- and set of turn-ins its follow-ups wait on; one per follow-up's errand,
-- after the stop that gives it; one per ender of a follow-up handed in on
-- the way, after its errand, else after the stop that gives it.
local function stopsOf(plan, follow)
	local stops, byKey = {}, {}
	local function add(s)
		stops[#stops + 1] = s
		byKey[s.key] = #stops
		return s
	end
	local enderStop = {}
	for _, h in ipairs(plan.hand) do
		local before = {}
		for _, t in ipairs(h.talks or {}) do
			local k = "t" .. pointKey(t)
			local s = stops[byKey[k] or 0] or add({ key = k, npcKey = pointKey(t), at = t, inP = t, outP = t,
				deps = {}, talks = {}, turnins = {}, accepts = {} })
			s.talks[#s.talks + 1] = { quest = h.quest, rec = h.rec, at = t }
			before[#before + 1] = byKey[k]
		end
		local k = "e" .. pointKey(h.ender)
		local s = stops[byKey[k] or 0] or add({ key = k, npcKey = pointKey(h.ender), at = h.ender, inP = h.ender, outP = h.ender,
			deps = {}, talks = {}, turnins = {}, accepts = {} })
		s.turnins[#s.turnins + 1] = h
		enderStop[h.quest.id] = byKey[k]
		for _, i in ipairs(before) do
			local dup = false
			for _, d in ipairs(s.deps) do dup = dup or d == i end
			if not dup then s.deps[#s.deps + 1] = i end
		end
	end
	-- A quest in the log with an errand: the errand, then its ender.
	for _, x in ipairs(plan.errands or {}) do
		local k = "r" .. x.quest.id
		local r = stops[byKey[k] or 0] or add({ key = k, npcKey = k, at = { name = titleOf(x.quest, x.rec) }, inP = x.errand[1],
			outP = x.errand[#x.errand], deps = {}, talks = {}, turnins = {}, accepts = {}, errand = { rec = x.rec, errand = x.errand } })
		local ek = "d" .. pointKey(x.ender) .. "<" .. k
		local d = stops[byKey[ek] or 0] or add({ key = ek, npcKey = pointKey(x.ender), at = x.ender, inP = x.ender, outP = x.ender,
			deps = { byKey[r.key] }, talks = {}, turnins = {}, accepts = {} })
		d.turnins[#d.turnins + 1] = { quest = x.quest, rec = x.rec }
	end
	for _, f in ipairs(follow) do
		local deps, set = {}, {}
		for _, id in ipairs(f.after) do
			local i = enderStop[id]
			if not set[i] then
				set[i] = true
				deps[#deps + 1] = i
			end
		end
		sort(deps)
		local gk = pointKey(f.giver)
		local s
		if #deps == 1 and stops[deps[1]].npcKey == gk then
			s = stops[deps[1]]
		else
			local keys = {}
			for i, d in ipairs(deps) do keys[i] = stops[d].key end
			local k = "g" .. gk .. "<" .. concat(keys, ",")
			s = stops[byKey[k] or 0] or add({ key = k, npcKey = gk, at = f.giver, inP = f.giver, outP = f.giver,
				deps = deps, talks = {}, turnins = {}, accepts = {} })
		end
		s.accepts[#s.accepts + 1] = f
		-- Its errand, a stop of its own (`errand`), from its first goal's
		-- place to its last.
		local before = s
		if f.errand then
			local first, last = f.errand[1], f.errand[#f.errand]
			local k = "r" .. f.rec.id .. "<" .. s.key
			before = stops[byKey[k] or 0] or add({ key = k, npcKey = k, at = { name = f.rec.title }, inP = first, outP = last,
				deps = { byKey[s.key] }, talks = {}, turnins = {}, accepts = {}, errand = f })
		end
		-- A follow-up handed in on the way: after it, at its ender.
		if f.ender then
			local k = "d" .. pointKey(f.ender) .. "<" .. before.key
			local d = stops[byKey[k] or 0] or add({ key = k, npcKey = pointKey(f.ender), at = f.ender, inP = f.ender, outP = f.ender,
				deps = { byKey[before.key] }, talks = {}, turnins = {}, accepts = {} })
			d.turnins[#d.turnins + 1] = { quest = f.rec, rec = f.rec }
		end
	end
	return stops
end

function Dungeons.HandinGuide(key)
	local plan, err = Dungeons.HandinPlan(key)
	if not plan then return nil, err end
	if #plan.hand == 0 and #plan.errands == 0 then return nil, "nothing" end
	local d = plan.dungeon
	local from = ns.PlayerPoint()
	-- The errands of quests in the log, placed from where the player stands;
	-- one that cannot be placed after all stays a "Not finished yet" note.
	local p, placed = LK().PlayerInfo(), {}
	for _, x in ipairs(plan.errands) do
		local errand = errandGoals(key, x.rec, from, p)
		local ender = errand and Dungeons.Ender(x.quest, errand[#errand], x.rec)
		if ender then placed[#placed + 1] = { quest = x.quest, rec = x.rec, errand = errand, ender = ender } end
	end
	plan.errands = placed
	if #plan.hand == 0 and #plan.errands == 0 then return nil, "nothing" end
	local stops = stopsOf(plan, Dungeons.HandinFollowUps(plan))
	local order = Dungeons.OrderStops(stops, from, nil, "dungeonHandin", key)
	local steps, lastKey = {}, nil
	for _, i in ipairs(order) do
		local s = stops[i]
		-- Stops at the same NPC in a row are one step.
		local step = lastKey == s.npcKey and steps[#steps] or nil
		if not step then
			step = { title = s.at.name or L["Quest giver"], goals = {} }
			steps[#steps + 1] = step
		end
		-- A talk line: the engine ticks it by the quest's objective line (Lookup.QuestStep's talk goal).
		for _, t in ipairs(s.talks) do
			local goal = questGoal("talk", t.quest.id, titleOf(t.quest, t.rec), t.at)
			goal.oi = t.at.oi
			step.goals[#step.goals + 1] = goal
		end
		-- An errand (a follow-up's, or a quest's in the log): its collect goals, in its own step (titled with the quest).
		for _, g in ipairs(s.errand and s.errand.errand or {}) do
			local goal = {}
			for k, v in pairs(g) do goal[k] = v end
			step.goals[#step.goals + 1] = goal
		end
		for _, h in ipairs(s.turnins) do
			step.goals[#step.goals + 1] = questGoal("turnin", h.quest.id, titleOf(h.quest, h.rec), s.at)
		end
		for _, f in ipairs(s.accepts) do
			-- Its prerequisites (Lookup.AcceptPre): a turn-in skipped here
			-- leaves it "Requires ... first", not a giver who refuses it.
			local goal = LK().AcceptPre(questGoal("accept", f.rec.id, f.rec.title, s.at), f.rec)
			goal.minLevel = f.rec.minLevel
			step.goals[#step.goals + 1] = goal
		end
		lastKey = s.npcKey
	end
	if #steps == 0 then return nil, "nothing" end
	local last = steps[#steps]
	local led = {}
	for _, x in ipairs(plan.errands) do led[x.quest.id] = true end
	local function note(pattern, list)
		for _, pq in ipairs(list) do
			if not led[pq.id] then last.goals[#last.goals + 1] = { t = "note", text = format(pattern, ns.Quoted(pq.title) or "") } end
		end
	end
	note(L["Not finished yet: %s"], plan.unfinished)
	note(L["Turned in inside the dungeon: %s"], plan.inside)
	note(L["Where it is turned in is not known: %s"], plan.unplaced)
	return { title = format(L["%s: hand in the quests"], d.name), steps = steps, dungeon = key }
end

-- Why a plan has nothing to hand in, in one line.
function Dungeons.HandinText(plan)
	if not plan then return L["None of this dungeon's quests is in your log."] end
	local function titles(list)
		local out = {}
		for i, pq in ipairs(list) do out[i] = ns.Quoted(pq.title) or "" end
		return concat(out, ", ")
	end
	local parts = {}
	if #plan.unfinished > 0 then parts[#parts + 1] = format(L["Not finished yet: %s."], titles(plan.unfinished)) end
	if #plan.inside > 0 then parts[#parts + 1] = format(L["Turned in inside the dungeon: %s."], titles(plan.inside)) end
	if #plan.unplaced > 0 then parts[#parts + 1] = format(L["Where it is turned in is not known: %s."], titles(plan.unplaced)) end
	if #parts == 0 then return L["None of this dungeon's quests is in your log."] end
	return concat(parts, " ")
end

-- The dungeon's pick-up guide in a tab: its index once it is finished or at
-- its last step (its job ends at the entrance), else nil.
local function pickupDone(key)
	local E, Lk = ns.Engine, LK()
	if not (E and E.GetTabs and Lk.GuideId) then return nil end
	local id = Lk.GuideId("pickup", key)
	for i, t in ipairs(E.GetTabs()) do
		if t.guideId == id and (t.complete or t.stepIndex == t.stepCount) then return i, id end
	end
	return nil
end

function Dungeons.HandIn(key)
	if not Dungeons.IsEnabled() then return nil, "off" end
	local Lk = LK()
	if not (Lk and Lk.Guide) then return nil, "missing" end
	local E = ns.Engine
	local done, pickupId = pickupDone(key)
	local gid, reason = Lk.Guide(KIND, key)
	if not gid and reason == "tabs" and done then
		-- Six tabs: the finished pick-up guide gives up its tab first.
		E.CloseTab(done, true)
		gid, reason = Lk.Guide(KIND, key)
		if not gid then return gid, reason end
		for i, t in ipairs(E.GetTabs()) do
			if t.guideId == gid and i ~= done then E.MoveTab(i, done) end
		end
		return gid
	end
	if not (gid and pickupId) then return gid, reason end
	-- The hand-in takes the finished pick-up guide's place.
	local at, from
	for i, t in ipairs(E.GetTabs()) do
		if t.guideId == pickupId then at = i end
		if t.guideId == gid then from = i end
	end
	if at and from then
		E.CloseTab(at, true)
		if at < from then from = from - 1 end
		E.MoveTab(from, at)
	end
	return gid
end

-- The hand-in guide in the active tab keeps up with the log (#1748): a page
-- quest that becomes ready to hand in after the guide was built (Earthen
-- Echo, taken from Bashana in Thunder Bluff once the guide was open; one
-- finished later that the guide listed as not finished yet) and that none of
-- its turn-ins hands in rebuilds it in its tab, so the guide is not "complete"
-- with a quest still to hand in.
local function openKey()
	local E = ns.Engine
	local g = E and E.GetGuide and E.GetGuide()
	local id = g and g.id
	return type(id) == "string" and id:match("^lookup/" .. KIND .. "/(.+)$") or nil, g
end

function Dungeons.HandinStale(key, guide)
	local have = {}
	for _, s in ipairs(type(guide) == "table" and guide.steps or {}) do
		for _, g in ipairs(s.goals or {}) do
			if g.t == "turnin" and g.quest then have[g.quest] = true end
		end
	end
	local plan = Dungeons.HandinPlan(key)
	for _, h in ipairs(plan and plan.hand or {}) do
		if not have[h.quest.id] then return true end
	end
	return false
end

local pending = false
local function keepUp()
	pending = false
	local key, guide = openKey()
	if key and Dungeons.IsEnabled() and Dungeons.HandinStale(key, guide) then LK().Guide(KIND, key) end
end
local function soon()
	if pending then return end
	pending = true
	ns.After(0.5, keepUp)
end
ns.RegisterEvent("QUEST_ACCEPTED", soon)
ns.RegisterEvent("QUEST_LOG_UPDATE", soon)
ns.On("GUIDE_CHANGED", soon)

-- The handin kind builds only while Dungeons is on.
if ns.Lookup and ns.Lookup.RegisterPlanner then
	ns.Lookup.RegisterPlanner(KIND, function(key)
		if not Dungeons.IsEnabled() then return nil, "off" end
		local ok, reason = Dungeons.Load()
		if not ok then return nil, reason end
		return Dungeons.HandinGuide(key)
	end)
end
