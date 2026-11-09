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
--         inside = { quest, ... }, unplaced = { quest, ... } }
--       the page's quests in the log: hand (objectives done, or only talks
--       left, turned in outside at `ender`, a point { kind, id, name, map,
--       x, y, f }: Dungeons.Ender, the page's own place when it is the
--       character's side's, else the Codex's ender of that side nearest the
--       player; talks: nil, or the open quest-log lines when each is a talk
--       objective at an NPC outside this character may speak to, each a
--       point with its line `oi`: The Glowing Shard's Sputtervalve in
--       Ratchet before Falla Sagewind, #1326), unfinished (other objectives
--       still open), inside (done, turned in inside the dungeon), unplaced
--       (done, nowhere known). No follow-up search: the Dungeons page asks
--       for the plan on every render.
--   Dungeons.HandinFollowUps(plan) -> { { rec, giver, after = { questId, ... } } }
--       the quests the `hand` quests open (Codex.FollowUps: every `pre`
--       done or handed in here, and one of `preAny` when it has any) that
--       this character can take (Lookup.QuestBlock: faction, race, class,
--       level), not done or in the log, from a giver (NPC or object) that is
--       the one a quest of `after` is turned in to or within NEAR seconds of
--       it (ns.TravelCost)
--   Dungeons.HandinGuide(key) -> def | nil, reason   -- "nothing" when no quest can be handed in
--   Dungeons.HandIn(key) -> guideId | nil, reason    -- builds, registers and opens it
--   Dungeons.HandinText(plan) -> text                -- why nothing can be handed in, one line
--
-- Route: one stop per place a quest is turned in (every quest turned in
-- there, then the follow-ups that place gives once what they wait on is
-- turned in there), one per NPC a quest's talk line is at (before the
-- place it is turned in), and one per other giver of follow-ups (after the
-- turn-ins they wait on), in the order of Dungeons.OrderStops from where the
-- player stands, with no fixed end (kept per character as
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

-- Its objectives done: the client says so, or the quest has none (a
-- delivery), which some clients never flag complete.
local function finished(id, rec)
	local C = ns.Compat
	if C.IsQuestReadyForTurnIn(id) then return true end
	return rec ~= nil and #(rec.objectives or {}) == 0 and C.GetQuestObjectives(id) == nil
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

function Dungeons.HandinPlan(key)
	local d = Dungeons.Get(key)
	if not d then return nil, "unknown" end
	local Lk, C = LK(), ns.Codex
	if not (Lk and Lk.QuestEnd and C) then return nil, "missing" end
	local from = ns.PlayerPoint()
	local p = Lk.PlayerInfo()
	local plan = { dungeon = d, hand = {}, unfinished = {}, inside = {}, unplaced = {} }
	for _, pq in ipairs(Dungeons.Quests(key)) do
		if inLog(pq.id) and not done(pq.id) then
			local rec = C.Quest(pq.id)
			local ready = finished(pq.id, rec)
			local talks = not ready and talksLeft(pq.id, rec, from, p) or nil
			if not (ready or talks) then
				plan.unfinished[#plan.unfinished + 1] = pq
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
				if near then out[#out + 1] = { rec = f, giver = giver, after = after } end
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
-- and set of turn-ins its follow-ups wait on.
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
	end
	return stops
end

-- The other dungeon a quest is turned in inside (its finish's `instance`,
-- Lokhtos Darkbargainer in Blackrock Depths for Molten Core), by name | nil.
local function elsewhere(pq)
	local key = pq.finish and pq.finish.instance
	local d = key and Dungeons.Get(key)
	return d and d.name or nil
end

function Dungeons.HandinGuide(key)
	local plan, err = Dungeons.HandinPlan(key)
	if not plan then return nil, err end
	if #plan.hand == 0 then return nil, "nothing" end
	local d = plan.dungeon
	local from = ns.PlayerPoint()
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
	local function note(pattern, list)
		for _, pq in ipairs(list) do
			last.goals[#last.goals + 1] = { t = "note", text = format(pattern, ns.Quoted(pq.title) or "") }
		end
	end
	note(L["Not finished yet: %s"], plan.unfinished)
	for _, pq in ipairs(plan.inside) do
		local other = elsewhere(pq)
		local text = other and format(L["Turned in inside %s: %s"], other, ns.Quoted(pq.title) or "")
			or format(L["Turned in inside the dungeon: %s"], ns.Quoted(pq.title) or "")
		last.goals[#last.goals + 1] = { t = "note", text = text }
	end
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
	-- Inside this dungeon, then inside each other one, by name.
	local here, others, names = {}, {}, {}
	for _, pq in ipairs(plan.inside) do
		local other = elsewhere(pq)
		if other then
			if not others[other] then
				others[other] = {}
				names[#names + 1] = other
			end
			local list = others[other]
			list[#list + 1] = pq
		else
			here[#here + 1] = pq
		end
	end
	if #here > 0 then parts[#parts + 1] = format(L["Turned in inside the dungeon: %s."], titles(here)) end
	for _, name in ipairs(names) do parts[#parts + 1] = format(L["Turned in inside %s: %s."], name, titles(others[name])) end
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

-- The handin kind builds only while Dungeons is on.
if ns.Lookup and ns.Lookup.RegisterPlanner then
	ns.Lookup.RegisterPlanner(KIND, function(key)
		if not Dungeons.IsEnabled() then return nil, "off" end
		local ok, reason = Dungeons.Load()
		if not ok then return nil, reason end
		return Dungeons.HandinGuide(key)
	end)
end
