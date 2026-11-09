-- In-game checks (spec 9.3), the cheap ones: a goal not filled in, fields
-- its verb needs, ids Polestar does not know, turn-ins and completes with no
-- earlier accept, accepts never turned in, objective numbers out of range,
-- elite kills that are not optional, empty steps, header problems, plus
-- Polestar's own (Polestar.Studio.Checks: Guides.Validate and the import
-- checks), mapped back to the draft's steps and goals.
--
--   S.Checks.Run(doc) -> { { step = i, goal = j | nil, message, severity = "error" | "warning" } }
--   S.Checks.Last() -> the last automatic run's problems (current draft)
-- Runs by itself 0.3 s after an edit (never in combat) and fires STUDIO_CHECKS(problems).

local ADDON, S = ...
local L = S.L

local Checks = {}
S.Checks = Checks

local type, ipairs, pairs, tostring, pcall = type, ipairs, pairs, tostring, pcall

local last = {}

local function add(list, step, goal, message, severity)
	list[#list + 1] = { step = step, goal = goal, message = message, severity = severity or "warning" }
end

local function codex()
	return S.Resolve and S.Resolve.Codex and S.Resolve.Codex() or nil
end

local function exists(X, fn, id)
	if not (X and X[fn] and id) then return true end
	local ok, rec = pcall(X[fn], id)
	return ok and rec ~= nil
end

local function header(doc, out)
	local h = doc.header
	if type(h.title) ~= "string" or S.OneLine(h.title) == "" then add(out, nil, nil, L["The guide needs a title."], "error") end
	if type(h.id) ~= "string" or not h.id:match("^[a-z0-9][a-z0-9%-]*/[a-z0-9][a-z0-9%-]*$") then
		add(out, nil, nil, L["The guide id must be your handle, a slash and a name: yendi/cozy-bag."], "error")
	end
	local lo, hi = tonumber(h.minLevel), tonumber(h.maxLevel)
	if not (lo and hi) or lo < 1 or lo > hi then add(out, nil, nil, L["Set the guide's levels: lowest first."], "error") end
	if h.zone == nil then add(out, nil, nil, L["Set the guide's zone."], "warning") end
	if #doc.steps == 0 then add(out, nil, nil, L["The guide has no steps."], "error") end
end

-- The fields a goal's verb needs (Polestar's Guides.VERBS).
local function required(goal, i, j, out)
	local P = S.P()
	local rules = P and P.Guides and P.Guides.VERBS
	if not rules then return end
	local r = rules[goal.t]
	if not r then
		add(out, i, j, (L["Polestar does not know the goal kind %s."]):format(tostring(goal.t)), "error")
		return
	end
	local fields = {}
	for f in pairs(r) do fields[#fields + 1] = f end
	table.sort(fields)
	for _, f in ipairs(fields) do
		local ok, good = pcall(r[f], goal[f])
		if not (ok and good) then add(out, i, j, (L["This goal needs %s."]):format(f), "error") end
	end
	if goal.x ~= nil and (goal.x < 0 or goal.x > 100 or goal.y == nil or goal.y < 0 or goal.y > 100) then
		add(out, i, j, L["Its coordinates are outside the map."], "error")
	end
end

function Checks.Run(doc)
	doc = doc or (S.Model and S.Model.Current())
	local out = {}
	if not doc then return out end
	header(doc, out)
	local X = codex()
	local accepted, turned, acceptAt = {}, {}, {}
	local ids = {}
	for i, step in ipairs(doc.steps) do
		if ids[step.id] then add(out, i, nil, L["Two steps share this id."], "error") end
		ids[step.id or i] = true
		if #step.goals == 0 then add(out, i, nil, L["This step has no goals: it is left out of the guide."], "warning") end
		for _, w in ipairs(type(step.when) == "table" and step.when or {}) do
			local ok, why = S.Serialize.ParseWhen(w)
			if not ok then add(out, i, nil, (L["Condition \"%s\": %s"]):format(tostring(w), tostring(why)), "error") end
		end
		for j, goal in ipairs(step.goals) do
			local g = goal.out
			if type(g) ~= "table" then
				add(out, i, j, L["Not filled in: this goal is left out of the guide. Fill it in again."], "error")
			else
				required(g, i, j, out)
				-- ids Polestar does not know
				if not exists(X, "Quest", g.quest) then add(out, i, j, (L["Quest %s is unknown to Polestar."]):format(tostring(g.quest))) end
				if not exists(X, "Npc", g.npc) then add(out, i, j, (L["NPC %s is unknown to Polestar."]):format(tostring(g.npc))) end
				if not exists(X, "Object", g.object) then add(out, i, j, (L["Object %s is unknown to Polestar."]):format(tostring(g.object))) end
				if not exists(X, "Item", g.item) then add(out, i, j, (L["Item %s is unknown to Polestar."]):format(tostring(g.item))) end
				local q = g.quest
				if g.t == "accept" and q then
					accepted[q] = true
					acceptAt[q] = acceptAt[q] or { i, j }
				elseif (g.t == "turnin" or g.t == "complete") and q then
					if not accepted[q] and not g.direct then
						add(out, i, j, (L["%s is turned in or completed here, but no earlier step accepts it."]):format(g.title or tostring(q)))
					end
					if g.t == "turnin" then turned[q] = true end
				elseif (g.t == "kill" or g.t == "collect" or g.t == "interact" or g.t == "use") and q and not accepted[q] then
					add(out, i, j, (L["This works on %s, but no earlier step accepts it."]):format(g.title or tostring(q)))
				end
				-- objective number in range
				if q and g.oi and X and X.Quest then
					local ok, rec = pcall(X.Quest, q)
					local n = ok and rec and rec.objectives and #rec.objectives
					if n and g.oi > n then
						add(out, i, j, (L["Quest %s has %d objectives, not %d."]):format(g.title or tostring(q), n, g.oi), "error")
					end
				end
				-- elite work that every character is asked to do
				if g.t == "kill" and g.npc and not g.optional and not g.group and X and X.Npc then
					local ok, rec = pcall(X.Npc, g.npc)
					if ok and rec and rec.elite then
						add(out, i, j, (L["%s is elite: make the goal optional or say it needs a group."]):format(g.target or tostring(g.npc)))
					end
				end
			end
		end
	end
	for q in pairs(accepted) do
		if not turned[q] then
			local at = acceptAt[q]
			local goal = doc.steps[at[1]].goals[at[2]].out
			add(out, at[1], at[2], (L["%s is accepted but never turned in."]):format(goal.title or tostring(q)))
		end
	end
	-- Polestar's own checks on the payload
	local P = S.P()
	if P and P.Studio and P.Studio.Checks then
		local payload, map = S.Model.ToPayload(doc)
		if payload and #payload.guide.steps > 0 then
			local ok, list = pcall(P.Studio.Checks, payload)
			if ok and type(list) == "table" then
				for _, p in ipairs(list) do
					local m = p.step and map[p.step]
					add(out, m and m.step or nil, m and p.goal and m.goals[p.goal] or nil, tostring(p.message or p[1] or ""), "error")
				end
			end
		end
	end
	table.sort(out, function(a, b)
		local sa, sb = a.step or 0, b.step or 0
		if sa ~= sb then return sa < sb end
		return (a.goal or 0) < (b.goal or 0)
	end)
	return out
end

function Checks.Last() return last end

-- Problems of one step (from the last run).
function Checks.ForStep(i)
	local out = {}
	for _, p in ipairs(last) do
		if p.step == i then out[#out + 1] = p end
	end
	return out
end

local function runNow()
	if S.InCombat() then
		Checks.pending = true
		return
	end
	Checks.pending = false
	last = Checks.Run()
	S.Fire("STUDIO_CHECKS", last)
end
Checks.Refresh = runNow

S.On("STUDIO_CHANGED", function(kind)
	if kind == "select" then return end
	S.Debounce("checks", 0.3, runNow)
end)

S.RegisterEvent("PLAYER_REGEN_ENABLED", function()
	if Checks.pending then runNow() end
end)
