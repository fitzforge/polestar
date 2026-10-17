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
	local unloaded = false
	for _, id in ipairs(g.nextChoices) do
		local target = G.Get(id)
		if not target then
			unloaded = true
			if id == remembered then return id, false end
		elseif G.GuideMatches(target, player) then
			options[#options + 1] = id
			if id == remembered then return id, false end
		end
	end
	-- A missing option may apply to this character. Do not silently choose
	-- the only loaded branch and promise its hand-ins as the selected route.
	if unloaded then return nil, false, true end
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

for _, event in ipairs({ "GUIDES_REGISTERED", "PACKS_CHANGED", "GUIDE_CHANGED", "ROUTE_CHOSEN", "TABS_CHANGED" }) do
	ns.On(event, Plan.Invalidate)
end
