local _, Free = ...
local Planner = {}
Free.Planner = Planner

local WORK = { kill = true, collect = true, interact = true, talk = true, use = true, complete = true }
local RUN_SPEED = 7
local NEAR_SECONDS = 150 / RUN_SPEED
local function noInsideLocation() return nil end
local LOOKUP_OPTIONS = { direct = true, inside = noInsideLocation }

local function located(p)
	return p and type(p.map) == "number" and p.map > 0
		and type(p.x) == "number" and p.x >= 0 and p.x <= 100
		and type(p.y) == "number" and p.y >= 0 and p.y <= 100
end

local function addGoals(index, step)
	for _, goal in ipairs(step.goals or {}) do
		local id = goal.quest
		if type(id) == "number" and (goal.t == "turnin" or WORK[goal.t]) then
			local list = index[id]
			if not list then list = {}; index[id] = list end
			list[#list + 1] = { goal = goal, group = goal.group or step.group, note = goal.note }
		end
	end
end

local function resetSources(state, guide, zone, codexLoaded)
	if state.guide == guide and state.zone == zone and state.codexLoaded == codexLoaded then return end
	state.guide, state.zone, state.codexLoaded = guide, zone, codexLoaded
	state.guideGoals, state.lookup = {}, {}
	for _, step in ipairs(guide and guide.steps or {}) do addGoals(state.guideGoals, step) end
end

local function cachedLookup(ps, state, id, record, from)
	local list = state.lookup[id]
	if list then return list end
	local index = {}
	if record then
		local step = ps.Lookup.QuestStep(record, from, LOOKUP_OPTIONS)
		if step then addGoals(index, step) end
	end
	list = index[id] or {}
	state.lookup[id] = list
	return list
end

local function pickPoint(ps, from, zone, entry)
	local g = entry.goal
	local best, score
	local function offer(p, alt, spotIndex)
		if not located(p) then return end
		local travel = ps.DirectTravelCost(from, p)
		if not travel then return end
		local cost = travel + (p.map ~= zone and 25 or 0) + (alt and 14 or 0)
		if not score or cost < score then
			best, score = { point = p, travel = travel, group = entry.group, hint = entry.note, goal = g, spotIndex = spotIndex }, cost
		end
	end
	offer(g)
	for i, spot in ipairs(g.spots or {}) do
		local p = { map = spot.map or g.map, f = spot.f or g.f, x = spot.x, y = spot.y, z = spot.z }
		offer(p, spot.alt, i)
		if best and not best.spotIndex and p.map == g.map and p.x == g.x and p.y == g.y and p.f == g.f and p.z == g.z then
			best.spotIndex = i
		end
	end
	return best
end

local function questTitle(C, id, record)
	return C.GetQuestTitle(id) or (record and record.title) or ("#" .. id)
end

local function candidateTier(c, zone, cross)
	local tier = c.point.map == zone and 0 or 1
	if c.group or c.hard then tier = tier + 2 end
	if c.travel >= cross then tier = tier + 4 end
	return tier
end

local function targetName(ps, goal)
	if goal.npc then return ps.Codex.Name("npc", goal.npc) or goal.npcName or goal.target end
	if goal.object then return ps.Codex.Name("object", goal.object) or goal.objName end
	if goal.item then return ps.Codex.Name("item", goal.item) or goal.itemName end
	return goal.target or goal.text
end

-- A localized name can identify a line when the data and client list the
-- same quest's objectives in different orders. Otherwise use its data index.
local function objectiveLine(ps, goal, lines)
	if not lines then return nil end
	if goal.t == "complete" and not goal.oi then return nil end
	local name = targetName(ps, goal)
	if name and name ~= "" and not ps.Compat.Placeholder(name) then
		local match
		for i, line in ipairs(lines) do
			local label = ps.Compat.ObjectiveLabel(line.text)
			if label == name or (label ~= "" and label:find(name, 1, true)) then
				if match then return goal.oi end
				match = i
			end
		end
		if match then return match end
	end
	return goal.oi
end

local function workPoints(ps, from, zone, points, lines, list, fallback, state)
	local cross = ps.TRAVEL_CROSS_CONTINENT or 3600
	for _, entry in ipairs(list or {}) do
		local g = entry.goal
		if WORK[g.t] and located(g) then
			local i = objectiveLine(ps, g, lines)
			if i and lines[i] and not lines[i].finished and not (fallback and state[i]) then
				local c = pickPoint(ps, from, zone, entry)
				local old = points[i]
				if c then
					c.line, c.key = lines[i].text, i
					c.tier = candidateTier(c, zone, cross)
					if not old or c.tier < old.tier or (c.tier == old.tier and
						(g.t == "use" and old.goal.t ~= "use" or (g.t == "use") == (old.goal.t == "use") and c.travel < old.travel)) then
						points[i] = c
					end
				end
			elseif g.t == "complete" and not i and not points.event then
				local c = pickPoint(ps, from, zone, entry)
				if c then c.key = "event"; points.event = c end
			end
		end
	end
end

local function unfinished(ps, state, id, record, lines, from, zone)
	local points = {}
	workPoints(ps, from, zone, points, lines, state.guideGoals[id])
	local missing = false
	for i, line in ipairs(lines or {}) do
		if not line.finished and not points[i] then missing = true; break end
	end
	if missing or not lines then
		local covered = {}
		for i in pairs(points) do covered[i] = true end
		workPoints(ps, from, zone, points, lines, cachedLookup(ps, state, id, record, from), true, covered)
	end
	local best
	for i = 1, #(lines or {}) do
		local c = points[i]
		if c and (not best or c.tier < best.tier or (c.tier == best.tier and c.travel < best.travel)) then best = c end
	end
	return best or (missing or not lines) and points.event or nil
end

local function handIn(ps, state, id, record, from, zone)
	local ender = record and ps.Lookup.QuestEnd(record["end"], from, nil, true)
	if ender and ender.hostile then return nil end
	if ender and located(ender.spawn) then
		local c = pickPoint(ps, from, zone, { goal = ender.spawn })
		if c then
			local kind, entity = ender.npc and "npc" or "object", ender.npc or ender.object
			c.line = entity and ps.Codex.Name(kind, entity) or ender.name
			c.key = "turnin"
			c.targetGoal = { t = "turnin", npc = ender.npc, npcName = ender.npc and ender.name, object = ender.object }
			return c
		end
	end
	for _, entry in ipairs(state.guideGoals[id] or {}) do
		if entry.goal.t == "turnin" and located(entry.goal) then
			local c = pickPoint(ps, from, zone, entry)
			if c then
				c.line, c.key = targetName(ps, entry.goal), "turnin"
				return c
			end
		end
	end
end

-- Target selection can also use objectives and NPCs without waypoints.
function Planner.TargetGoals(ps, state, row, from)
	if row.failed then return {} end
	local rec = state.codexLoaded and ps.Codex.Quest(row.id)
	if row.ready then
		if row.goal then return { { goal = row.targetGoal or row.goal } } end
		local ender = rec and ps.Lookup.QuestEnd(rec["end"], from, nil, true)
		if ender then
			if ender.hostile or not ender.npc then return {} end
			return { { goal = { t = "turnin", npc = ender.npc, npcName = ender.name } } }
		end
		for _, list in ipairs({ state.guideGoals[row.id] or {}, cachedLookup(ps, state, row.id, rec, from) }) do
			for _, entry in ipairs(list) do
				if entry.goal.t == "turnin" then return { entry } end
			end
		end
		return {}
	end

	local lines = ps.Compat.GetQuestObjectives(row.id)
	local out, seen, covered = {}, {}, {}
	local function append(g, spot, skip)
		if not g or not WORK[g.t] or seen[g] then return end
		local i = objectiveLine(ps, g, lines)
		if not (i and lines and lines[i] and not lines[i].finished) or (skip and skip[i]) then return end
		out[#out + 1] = { goal = g, spotIndex = spot, line = lines[i] }
		seen[g], covered[i] = true, true
	end
	append(row.goal, row.spotIndex)
	for _, entry in ipairs(state.guideGoals[row.id] or {}) do append(entry.goal) end

	local function missing()
		for i, line in ipairs(lines or {}) do
			if not line.finished and not covered[i] then return true end
		end
	end
	if not missing() then return out end
	local authored = {}
	for i in pairs(covered) do authored[i] = true end
	for _, entry in ipairs(cachedLookup(ps, state, row.id, rec, from)) do append(entry.goal, nil, authored) end

	if missing() then
		for i, o in ipairs(rec and rec.objectives or {}) do
			if o.id and (o.type == "kill" or o.type == "talk") then
				append({ t = o.type, npc = o.id, oi = i }, nil, covered)
			elseif o.id and o.type == "item" then
				append({ t = "collect", item = o.id, oi = i }, nil, covered)
			end
		end
	end
	return out
end

local function remainingEffort(lines)
	local seconds = 15
	for _, line in ipairs(lines or {}) do
		if not line.finished then
			local left = math.max(1, (line.numRequired or 1) - (line.numFulfilled or 0))
			seconds = seconds + left * (line.type == "monster" and 27 or line.type == "item" and 22 or 12)
		end
	end
	return seconds
end

local function reward(ps, record, level, qlvl)
	if not (record and record.xp) then return nil end
	local share = ps.Levels and ps.Levels.Share
	return math.floor(record.xp * (share and qlvl and share(level, qlvl) or 1) + 0.5)
end

-- Keep previously read quests when their section collapses. IsOnQuest also
-- removes abandoned or handed-in quests even if a log refresh still lists them.
local function heldQuests(C, state, excluded)
	for _, id in ipairs(C.GetLogQuests()) do state.held[id] = true end
	local ids, total = {}, 0
	for id in pairs(state.held) do
		if C.IsOnQuest(id) then
			total = total + 1
			if not (excluded and excluded[id]) then ids[#ids + 1] = id end
		else
			state.held[id] = nil
		end
	end
	table.sort(ids)
	return ids, total
end

function Planner.Choices(ps, state)
	local C, X = ps.Compat, ps.Codex
	local loaded = X.Load()
	local choices = {}
	for _, id in ipairs(heldQuests(C, state)) do
		choices[#choices + 1] = { id = id, title = questTitle(C, id, loaded and X.Quest(id) or nil) }
	end
	return choices
end

local function rank(ps, rows, zone, order, level)
	local cross = ps.TRAVEL_CROSS_CONTINENT or 3600
	local navigable = 0
	for i, row in ipairs(rows) do
		if row.point then
			navigable = navigable + 1
			row.nearby = 0
			for j, other in ipairs(rows) do
				if i ~= j and other.point and row.point.map == other.point.map then
					local d = ps.DirectTravelCost(row.point, other.point)
					if d and d <= NEAR_SECONDS then row.nearby = row.nearby + 1 end
				end
			end
			row.tier = candidateTier(row, zone, cross)
			row.distance = row.travel < cross and math.floor(row.travel * RUN_SPEED + 0.5) or nil
			local bonus = math.min(row.nearby, 3) * 4 + (row.ready and 6 or 0)
			row.score = math.max(5, row.travel - bonus)
			if order == "xp" then
				local baseline = math.max(300, level * 55)
				local xp = row.xp or baseline
				row.score = (row.score + row.effort) * baseline / math.max(xp, baseline / 8)
			end
		end
	end
	table.sort(rows, function(a, b)
		if a.tier ~= b.tier then return (a.tier or math.huge) < (b.tier or math.huge) end
		if a.score ~= b.score then return (a.score or math.huge) < (b.score or math.huge) end
		return a.id < b.id
	end)
	return navigable
end

function Planner.New()
	return { held = {}, guideGoals = {}, lookup = {} }
end

function Planner.Build(ps, state, from, zone, level, order, excluded)
	local C, X = ps.Compat, ps.Codex
	local guide = ps.Engine.GetGuide()
	local loaded = X.Load()
	resetSources(state, guide, zone, loaded)
	local rows = {}
	local ids, total = heldQuests(C, state, excluded)
	for _, id in ipairs(ids) do
		local rec = loaded and X.Quest(id)
		local qlvl = C.GetQuestLevel(id) or (rec and rec.level)
		local failed = C.IsQuestFailed(id)
		local ready = not failed and C.IsQuestReadyForTurnIn(id)
		local lines = not ready and not failed and C.GetQuestObjectives(id) or nil
		local row = from and not failed and (ready and handIn(ps, state, id, rec, from, zone)
			or not ready and unfinished(ps, state, id, rec, lines, from, zone)) or {}
		row = row or {}
		row.id, row.title, row.qlvl = id, questTitle(C, id, rec), qlvl
		row.ready, row.failed, row.xp = ready, failed, reward(ps, rec, level, qlvl)
		row.hard = not ready and qlvl and qlvl > level + 2
		row.effort = ready and 6 or remainingEffort(lines)
		if not row.line then
			for _, line in ipairs(lines or {}) do
				if not line.finished and line.text ~= "" then row.line = line.text; break end
			end
		end
		rows[#rows + 1] = row
	end
	local navigable = rank(ps, rows, zone, order, level)
	return rows, navigable, loaded, total
end

function Planner.Choose(rows, pinned, previous)
	local best = rows[1]
	if not (best and best.point) then return nil end
	local prior
	for _, row in ipairs(rows) do
		if not row.point then break end
		if row.id == pinned then return row end
		if previous and row.id == previous.id and row.key == previous.key then prior = row end
	end
	-- A small change of position should not flip the arrow back and forth.
	if prior and prior.tier == best.tier and prior.score <= best.score * 1.20 + 6 then return prior end
	return best
end
