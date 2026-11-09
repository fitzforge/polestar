-- Chain / attunement toolkit (spec 5.2): pick a quest and Studio lays out
-- its chain as steps, one per quest (accept and turn-in): the quests before
-- it (Codex pre / preAny, the first of the "any" ones), then it, then the
-- quests that follow it (Codex.FollowUps, the first of each).

local ADDON, S = ...
local L = S.L
local UI = S.UI
local ipairs, tostring, format = ipairs, tostring, string.format

local MAX = 60

local function quest(id)
	local X = S.Resolve.Codex()
	if not (X and X.Quest) then return nil end
	local ok, rec = pcall(X.Quest, id)
	return ok and rec or nil
end

-- The chain through q: prerequisites first (depth first), q, follow-ups.
local function chain(q, forward)
	local out, seen = {}, {}
	local function before(id, depth)
		if seen[id] or depth > MAX then return end
		seen[id] = true
		local rec = quest(id)
		if rec then
			for _, p in ipairs(rec.pre or {}) do before(p, depth + 1) end
			if rec.preAny and rec.preAny[1] then before(rec.preAny[1], depth + 1) end
		end
		out[#out + 1] = id
	end
	before(q, 0)
	if forward then
		local X = S.Resolve.Codex()
		local cur = q
		while #out < MAX and X and X.FollowUps do
			local ok, list = pcall(X.FollowUps, cur)
			local nxt = ok and list and list[1] and list[1].id
			if not nxt or seen[nxt] then break end
			seen[nxt] = true
			out[#out + 1] = nxt
			cur = nxt
		end
	end
	return out
end

local function addStep(id)
	local rec = quest(id)
	local title = rec and rec.title or tostring(id)
	local i = S.Model.AddStep(title)
	if not i then return end
	S.Model.Select(i, nil)
	local src, out = S.Resolve.Accept(id, true)
	if src then S.Model.AddGoal(i, src, out) end
	for oi, o in ipairs(rec and rec.objectives or {}) do
		if o.id and o.type == "kill" then
			src, out = S.Resolve.Kill(o.id, nil, id, oi)
		elseif o.id and o.type == "item" then
			src, out = S.Resolve.Collect(o.id, nil, id, oi, true)
		elseif o.id and o.type == "object" then
			src, out = S.Resolve.Interact(o.id)
		else
			src = nil
		end
		if src then S.Model.AddGoal(i, src, out) end
	end
	src, out = S.Resolve.Turnin(id, nil, true)
	if src then S.Model.AddGoal(i, src, out) end
end

local function layout(q, forward)
	if not UI.TargetStep() then return end
	local ids = chain(q, forward)
	for _, id in ipairs(ids) do addStep(id) end
	UI.Say(format(L["Laid out %d quests as steps."], #ids), "success")
end

local function questItems(q)
	local out = {}
	for _, r in ipairs(UI.SearchCodex("quest", q, 60)) do out[#out + 1] = { text = r.name, sub = tostring(r.id), value = r.id } end
	return out
end

S.Tools.Register({
	key = "chain", label = "Lay out a quest chain", icon = "layers", kit = "chain",
	tip = "Pick a quest: its prerequisites, it and its follow-ups become steps.",
	run = function()
		if not UI.Ready() then return end
		UI.Pick({ title = L["Which quest?"], hint = L["Type part of its title, or its id."], items = questItems, onPick = function(it)
			UI.Pick({ title = it.text, items = {
				{ text = L["Up to this quest"], value = false },
				{ text = L["Up to this quest and on through its follow-ups"], value = true },
			}, onPick = function(c) layout(it.value, c.value) end })
		end })
	end,
})

S.Tools.Register({
	key = "followups", label = "Follow-ups of a quest", icon = "plus", kit = "chain", belt = false,
	tip = "The quests that open once a quest is done: add one as a step.",
	run = function()
		if not UI.Ready() then return end
		UI.Pick({ title = L["Which quest?"], items = questItems, onPick = function(it)
			local X = S.Resolve.Codex()
			local list = X and X.FollowUps and X.FollowUps(it.value) or {}
			local items = {}
			for _, r in ipairs(list) do items[#items + 1] = { text = r.title or tostring(r.id), sub = tostring(r.id), value = r.id } end
			if #items == 0 then
				UI.Say(L["Polestar knows no quest that follows it."], "warning")
				return
			end
			UI.Pick({ title = L["Follow-ups"], items = items, onPick = function(f)
				if UI.TargetStep() then addStep(f.value) end
			end })
		end })
	end,
})
