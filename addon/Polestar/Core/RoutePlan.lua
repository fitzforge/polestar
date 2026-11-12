-- Read-only hand-in planning over the guide chains open in tabs: the active
-- tab's first, then the others' and the dungeons open in a tab. Inspecting
-- another step must never change this answer or the player's progress.
local ADDON, ns = ...
local L = ns.L
local Plan = {}
ns.RoutePlan = Plan
local plans = {} -- guide -> its route (build), until Plan.Invalidate
local others -- the other tabs' routes and the open dungeons' quests (elsewhere), until Plan.Invalidate

local function nextGuide(g, player)
	local G = ns.Guides
	if not g.nextChoices then
		local target = g.next and G.Get(g.next)
		if target and not G.GuideMatches(target, player) then return nil, false end
		return g.next, false
	end
	local options, remembered = {}, (ns.CharState().routes or {})[g.id]
	local unloaded, conditional = false, false
	for _, id in ipairs(g.nextChoices) do
		local target = G.Get(id)
		-- An option with `when` (nextWhen) is decided at the hand-off, on the
		-- character as they are then: not yet known here.
		local cond = g.nextWhen ~= nil and g.nextWhen[id] ~= nil
		if not target then
			unloaded = true
			if id == remembered and not cond then return id, false end
		elseif G.GuideMatches(target, player) then
			options[#options + 1] = id
			if cond then conditional = true end
			if id == remembered and not cond then return id, false end
		end
	end
	-- A missing option may apply to this character. Do not silently choose
	-- the only loaded branch and promise its hand-ins as the selected route.
	if unloaded then return nil, false, true end
	if conditional then return nil, true end
	if #options == 1 then return options[1], false end
	-- A recommendation can depend on where the player stands. Do not promise
	-- a hand-in in a branch that has not actually been chosen yet.
	return nil, #options > 1
end

local function build(active)
	local G, player = ns.Guides, ns.Compat.GetPlayerInfo() or {}
	local route, seen, before = {}, {}, {}
	local first = active
	-- Include unambiguous predecessors to identify an already-passed hand-in.
	-- Unrelated open tabs and unchosen branches do not count as this route.
	while first and not before[first.id] do
		before[first.id] = true
		local predecessor, ambiguous
		for _, h in ipairs(G.List()) do
			local g = G.Get(h.id)
			if g and g.id ~= first.id and G.GuideMatches(g, player) and nextGuide(g, player) == first.id then
				if predecessor then ambiguous = true; break end
				predecessor = g
			end
		end
		if ambiguous or not predecessor or before[predecessor.id] then break end
		first = predecessor
	end
	local current, pending, missing = first, false, false
	while current and not seen[current.id] do
		seen[current.id] = #route + 1
		route[#route + 1] = current
		local id, unloaded
		id, pending, unloaded = nextGuide(current, player)
		current = id and G.Get(id) or nil
		if unloaded or (id and not current) then missing = true end
	end
	-- carried: quest -> the later guide that hands it in, from the compiled
	-- `carriedTo` on the route's quest work: known even where the plan
	-- cannot reach that guide (not loaded, a choice to make, another race's).
	local index, carried = {}, {}
	for chapter, g in ipairs(route) do
		for si, step in ipairs(g.steps or {}) do
			if G.Matches(step.only, player) then
				for gi, goal in ipairs(step.goals or {}) do
					if goal.t == "turnin" and goal.quest and G.Matches(goal.only, player) then
						local entries = index[goal.quest] or {}
						index[goal.quest] = entries
						entries[#entries + 1] = { guide = g.id, title = g.title, step = si, goal = gi,
							chapter = chapter, optional = goal.optional or step.optional or false }
					elseif goal.carriedTo and goal.quest and not carried[goal.quest] and G.Matches(goal.only, player) then
						carried[goal.quest] = goal.carriedTo
					end
				end
			end
		end
	end
	return { active = active, chapter = seen[active.id], index = index, carried = carried, pending = pending, missing = missing }
end

local function planOf(g)
	local p = plans[g]
	if not p then
		p = build(g)
		plans[g] = p
	end
	return p
end

function Plan.Invalidate() plans, others = {}, nil end

local function copy(entry, status)
	local out = {}
	for k, v in pairs(entry) do out[k] = v end
	out.status = status
	return out
end

-- One route's answer for questId, its guide's live step `step` (nil: that
-- chapter is complete).
local function turnIn(plan, questId, step)
	step = step or math.huge
	local past, skipped
	local flags = ns.CharState().skipped or {}
	for _, entry in ipairs(plan.index[questId] or {}) do
		local s = flags[entry.guide] or {}
		local isSkipped = s[entry.step] or s[entry.step .. ":" .. entry.goal]
		local behind = entry.chapter < plan.chapter or (entry.chapter == plan.chapter and entry.step < step)
		if isSkipped then skipped = entry
		elseif behind then past = entry
		else
			return copy(entry, entry.chapter > plan.chapter and "later" or (entry.step == step and "now" or "future"))
		end
	end
	local entry = past or skipped
	if entry then return copy(entry, past and "missed" or "skipped") end
	-- Handed in by a later guide the plan does not reach: said as such, never
	-- as "no turn-in" (prefer keeping a quest to calling it unneeded).
	local to = plan.carried[questId]
	if to then
		local later = ns.Guides.Get(to)
		return { status = "later", guide = to, title = later and later.title or nil, carried = true }
	end
	return { status = plan.pending and "choice" or plan.missing and "unloaded" or "unplanned" }
end

local function leveling(g) return (g.category or "Leveling") == "Leveling" end

-- The open tabs but the active one, the leveling ones first: routes = { {
-- plan, live, leveling } }; and dungeons = quest -> { key, title }: the page
-- quests of each dungeon whose pick-up or hand-in guide is open in a tab
-- (the active one too), the quests its hand-in plan (Dungeons.HandinPlan)
-- takes from the log and turns in after the run. Read only while the
-- dungeon data is loaded already (a dungeon's guide in a tab loaded it):
-- this never loads the Codex.
local function elsewhere(active)
	if others then return others end
	local E, D = ns.Engine, ns.Dungeons
	local tabs = E.TabLiveSteps and E.TabLiveSteps() or {}
	local routes, keys, quests = {}, {}, {}
	for pass = 1, 2 do
		for _, t in ipairs(tabs) do
			local g = t.guide
			if g and leveling(g) == (pass == 1) then
				if g.id ~= active.id then routes[#routes + 1] = { plan = planOf(g), live = t.live, leveling = pass == 1 } end
				local lk = g.lookup
				if lk and (lk.kind == "pickup" or lk.kind == "handin") and lk.id ~= nil then keys[#keys + 1] = lk.id end
			end
		end
	end
	if #keys > 0 and D and D.Meta and D.Meta() then
		for _, key in ipairs(keys) do
			local d = D.Get(key)
			if d then
				local title = L["%s: hand in the quests"]:format(d.name)
				for _, pq in ipairs(D.Quests(key)) do
					if not quests[pq.id] then quests[pq.id] = { key = key, title = title } end
				end
			end
		end
	end
	others = { routes = routes, dungeons = quests }
	return others
end

local AHEAD = { now = true, future = true, later = true }
local OPEN = { choice = true, unloaded = true }

-- The active tab's route answers first. A quest it doesn't hand in ahead is
-- "other" (via: that route's status) when another open tab's route or a
-- dungeon open in a tab still hands it in: a dungeon's pick-up guide never
-- hands in what the leveling guide or the dungeon's hand-in guide does
-- (#1830). Else a route still to settle can't say ("choice", "unloaded");
-- else a passed or skipped hand-in, the leveling routes' word first.
function Plan.GetTurnIn(questId)
	local E = ns.Engine
	local active = E and E.GetGuide and E.GetGuide()
	if not active then return { status = "noGuide" } end
	local step
	if E.GetLiveStep then step = E.GetLiveStep() else step = E.GetStepIndex() end
	local r = turnIn(planOf(active), questId, step)
	if AHEAD[r.status] then return r end
	local o, seen = elsewhere(active), {}
	for i, route in ipairs(o.routes) do
		local x = turnIn(route.plan, questId, route.live)
		if AHEAD[x.status] then
			local out = copy(x, "other")
			out.via = x.status
			return out
		end
		seen[i] = x
	end
	local dg = o.dungeons[questId]
	if dg then return { status = "other", title = dg.title, dungeon = dg.key } end
	local order = {}
	if leveling(active) then order[1] = r end
	for i, route in ipairs(o.routes) do
		if route.leveling then order[#order + 1] = seen[i] end
	end
	if not leveling(active) then order[#order + 1] = r end
	for i, route in ipairs(o.routes) do
		if not route.leveling then order[#order + 1] = seen[i] end
	end
	for _, x in ipairs(order) do
		if OPEN[x.status] then return x end
	end
	for _, x in ipairs(order) do
		if x.status ~= "unplanned" then return x end
	end
	return r
end

function Plan.Describe(result)
	local r = result or { status = "noGuide" }
	local E = ns.Engine
	local active = E and E.GetGuide and E.GetGuide()
	-- The step as the player counts it in its guide (#942: steps not theirs left out).
	local g = r.guide and ns.Guides and ns.Guides.Get and ns.Guides.Get(r.guide) or active
	local n = r.step and E and E.StepNumberOf and g and (E.StepNumberOf(g, r.step)) or r.step
	local where = n and L["step %d"]:format(n) or nil
	-- A hand-in a later guide makes beyond the plan (`carried`) has no step: the guide alone;
	-- one a dungeon open in a tab makes after the run (`dungeon`): its hand-in guide's title.
	if (r.guide and (not active or active.id ~= r.guide)) or (r.dungeon and r.title) then
		where = where and L["%s · %s"]:format(r.title or r.guide, where) or (r.title or r.guide)
	end
	where = where or ""
	local text
	-- A numbered step can visit several NPCs. Being on that step does not
	-- mean this hand-in is the current interaction or that we should navigate.
	if r.status == "now" then text = L["Turn in at this step · %s"]:format(where)
	elseif r.status == "future" or r.status == "later" or r.status == "other" then text = L["Turn in at %s"]:format(where)
	elseif r.status == "missed" then text = L["Earlier turn-in · %s — check"]:format(where)
	elseif r.status == "skipped" then text = L["Skipped turn-in · %s — check"]:format(where)
	elseif r.status == "choice" then text = L["Turn-in plan depends on your next route choice"]
	elseif r.status == "unloaded" then text = L["Next guide is not loaded; turn-in plan unavailable"]
	elseif r.status == "unplanned" then text = L["No turn-in in this route"]
	else text = L["Select a guide to see its turn-in plan"] end
	if r.optional then text = L["%s (optional)"]:format(text) end
	return text
end

---------------------------------------------------------------------------
-- Room in the quest log: what the route never hands in, and what an accept
-- step would push past the log's cap. Nothing here abandons anything.
---------------------------------------------------------------------------

local NEVER = { missed = true, skipped = true, unplanned = true }

-- Grey for the character now: no experience any more (Compat.IsQuestTrivial,
-- as Skip grey quests reads it).
local function grey(C, q, level)
	local qlvl = level and C.GetQuestLevel and C.GetQuestLevel(q)
	return qlvl and C.IsQuestTrivial(qlvl, level) or false
end

-- The quests in the log no open route needs: { { quest, title, status
-- = "missed" | "skipped" | "unplanned" | "grey" }, ... } in log order; nil
-- while the plan cannot say (no guide, a route choice to make, a guide not
-- loaded). Those it never hands in, and the grey ones it doesn't hand in
-- in this chapter (one it does is still worth its reward or its chain);
-- "grey" wins over the other three. A grey quest a later guide hands in
-- is listed only when that guide leaves it out too (Skip grey quests on and
-- nothing on its chain needs it: Engine.GreyLeftOut); a quest a later guide
-- hands in beyond the plan's reach (`carriedTo`) is "later", not unplanned.
-- A quest another open tab's route or a dungeon open in a tab hands in
-- ("other", GetTurnIn) is never listed, but for a grey one that route hands
-- in in a later chapter which leaves it out too, as above.
function Plan.Unneeded()
	local C, E, out = ns.Compat, ns.Engine, {}
	local level = (C.GetPlayerInfo() or {}).level
	for _, q in ipairs(C.GetLogQuests() or {}) do
		local r = Plan.GetTurnIn(q)
		if r.status == "noGuide" or r.status == "choice" or r.status == "unloaded" then return nil end
		local status = r.status
		if NEVER[status] and grey(C, q, level) then
			status = "grey"
		elseif (status == "later" or (status == "other" and r.via == "later")) and grey(C, q, level) and E and E.GreyLeftOut and E.GreyLeftOut(r.guide, q, level) then
			status = "grey"
		end
		if NEVER[status] or status == "grey" then out[#out + 1] = { quest = q, title = C.GetQuestTitle(q), status = status } end
	end
	return out
end

-- The live step's open accepts would not fit in the log: { take = accepts
-- open, free = room left, drop = { { quest, title }, ... } }, else nil. drop
-- names enough quests to make room: the ones no open route needs
-- (Unneeded), then the ones this route hands in last, never one the live
-- step needs nor one only another tab's route or a dungeon hands in.
function Plan.LogOverflow()
	local E, C = ns.Engine, ns.Compat
	local live = E and E.GetLiveStep and E.GetLiveStep()
	local view = live and E.GetStepView(live)
	if not view then return nil end
	local take, here = 0, {}
	for _, g in ipairs(view.goals or {}) do
		if g.quest then here[g.quest] = true end
		if g.t == "accept" and g.quest and (g.status == "active" or g.status == "pending") and not C.IsOnQuest(g.quest) then take = take + 1 end
	end
	if take == 0 then return nil end
	local log = C.GetLogQuests() or {}
	local free = (C.GetLogCap() or 40) - #log
	if take <= free then return nil end
	local drop, want = {}, take - math.max(free, 0)
	-- here: the live step's quests, then each one named, so a grey quest
	-- handed in later (Unneeded lists it) is not named twice.
	for _, u in ipairs(Plan.Unneeded() or {}) do
		if #drop < want and not here[u.quest] then
			drop[#drop + 1] = { quest = u.quest, title = u.title }
			here[u.quest] = true
		end
	end
	if #drop < want then
		local later = {}
		for _, q in ipairs(log) do
			local r = Plan.GetTurnIn(q)
			if not here[q] and (r.status == "future" or r.status == "later") then
				-- A hand-in beyond the plan (`carried`) comes after every planned one.
				later[#later + 1] = { quest = q, title = C.GetQuestTitle(q), chapter = r.chapter or math.huge, step = r.step or 0 }
			end
		end
		table.sort(later, function(a, b)
			if a.chapter ~= b.chapter then return a.chapter > b.chapter end
			return a.step > b.step
		end)
		for i = 1, #later do
			if #drop >= want then break end
			drop[#drop + 1] = { quest = later[i].quest, title = later[i].title }
		end
	end
	return { take = take, free = math.max(free, 0), drop = drop }
end

for _, event in ipairs({ "GUIDES_REGISTERED", "PACKS_CHANGED", "GUIDE_CHANGED", "ROUTE_CHOSEN", "TABS_CHANGED", "CODEX_LOADED" }) do
	ns.On(event, Plan.Invalidate)
end
