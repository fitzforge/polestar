-- Read-only hand-in planning over the selected guide chain. Inspecting another
-- step must never change this answer or the player's progress.
local ADDON, ns = ...
local L = ns.L
local Plan = {}
ns.RoutePlan = Plan
local cached

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
	local index = {}
	for chapter, g in ipairs(route) do
		for si, step in ipairs(g.steps or {}) do
			if G.Matches(step.only, player) then
				for gi, goal in ipairs(step.goals or {}) do
					if goal.t == "turnin" and goal.quest and G.Matches(goal.only, player) then
						local entries = index[goal.quest] or {}
						index[goal.quest] = entries
						entries[#entries + 1] = { guide = g.id, title = g.title, step = si, goal = gi,
							chapter = chapter, optional = goal.optional or step.optional or false }
					end
				end
			end
		end
	end
	return { active = active, chapter = seen[active.id], index = index, pending = pending, missing = missing }
end

function Plan.Invalidate() cached = nil end

function Plan.GetTurnIn(questId)
	local E = ns.Engine
	local active = E and E.GetGuide and E.GetGuide()
	if not active then return { status = "noGuide" } end
	if not cached or cached.active ~= active then cached = build(active) end
	local step
	if E.GetLiveStep then step = E.GetLiveStep() else step = E.GetStepIndex() end
	step = step or math.huge -- nil live step means the chapter is complete
	local past, skipped
	local flags = ns.CharState().skipped or {}
	for _, entry in ipairs(cached.index[questId] or {}) do
		local s = flags[entry.guide] or {}
		local isSkipped = s[entry.step] or s[entry.step .. ":" .. entry.goal]
		local behind = entry.chapter < cached.chapter or (entry.chapter == cached.chapter and entry.step < step)
		if isSkipped then skipped = entry
		elseif behind then past = entry
		else
			local out = {}
			for k, v in pairs(entry) do out[k] = v end
			out.status = entry.chapter > cached.chapter and "later" or (entry.step == step and "now" or "future")
			return out
		end
	end
	local entry = past or skipped
	if entry then
		local out = {}
		for k, v in pairs(entry) do out[k] = v end
		out.status = past and "missed" or "skipped"
		return out
	end
	return { status = cached.pending and "choice" or cached.missing and "unloaded" or "unplanned" }
end

function Plan.Describe(result)
	local r = result or { status = "noGuide" }
	local where = r.step and L["step %d"]:format(r.step) or ""
	local active = ns.Engine and ns.Engine.GetGuide and ns.Engine.GetGuide()
	if r.guide and (not active or active.id ~= r.guide) then where = L["%s · %s"]:format(r.title or r.guide, where) end
	local text
	-- A numbered step can visit several NPCs. Being on that step does not
	-- mean this hand-in is the current interaction or that we should navigate.
	if r.status == "now" then text = L["Turn in at this step · %s"]:format(where)
	elseif r.status == "future" or r.status == "later" then text = L["Turn in at %s"]:format(where)
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

-- The quests in the log the route never hands in: { { quest, title, status
-- = "missed" | "skipped" | "unplanned" }, ... } in log order; nil while the
-- plan cannot say (no guide, a route choice to make, a guide not loaded).
function Plan.Unneeded()
	local C, out = ns.Compat, {}
	for _, q in ipairs(C.GetLogQuests() or {}) do
		local r = Plan.GetTurnIn(q)
		if r.status == "noGuide" or r.status == "choice" or r.status == "unloaded" then return nil end
		if NEVER[r.status] then out[#out + 1] = { quest = q, title = C.GetQuestTitle(q), status = r.status } end
	end
	return out
end

-- The live step's open accepts would not fit in the log: { take = accepts
-- open, free = room left, drop = { { quest, title }, ... } }, else nil. drop
-- names enough quests to make room: the ones the route never hands in, then
-- the ones it hands in last, never one the live step needs.
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
	for _, u in ipairs(Plan.Unneeded() or {}) do
		if #drop < want and not here[u.quest] then drop[#drop + 1] = { quest = u.quest, title = u.title } end
	end
	if #drop < want then
		local later = {}
		for _, q in ipairs(log) do
			local r = Plan.GetTurnIn(q)
			if not here[q] and (r.status == "future" or r.status == "later") then
				later[#later + 1] = { quest = q, title = C.GetQuestTitle(q), chapter = r.chapter, step = r.step }
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

for _, event in ipairs({ "GUIDES_REGISTERED", "PACKS_CHANGED", "GUIDE_CHANGED", "ROUTE_CHOSEN", "TABS_CHANGED" }) do
	ns.On(event, Plan.Invalidate)
end
