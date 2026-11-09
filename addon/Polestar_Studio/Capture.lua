-- Auto-capture (spec 4.3): while on, what the author does in play becomes
-- goals in the selected step: quest accepts and turn-ins, flight paths
-- learned, hearth binds, trainer visits, and kills and loot that advance a
-- quest objective. Recorder-style event handlers; off by default
-- (PolestarStudioDB.capture). Each goal comes from S.Resolve, as the tools'.
--
--   S.Capture.Enabled() / S.Capture.SetEnabled(on)
-- Fires STUDIO_CAPTURED(i, j).

local ADDON, S = ...
local L = S.L

local Capture = {}
S.Capture = Capture

local type, ipairs, pairs, tonumber, pcall = type, ipairs, pairs, tonumber, pcall

function Capture.Enabled()
	return S.DB().capture and true or false
end

local counts -- quest -> { [objective] = numFulfilled }; nil until the first scan

local function scan()
	local C = S.P() and S.P().Compat
	if not (C and C.GetQuestObjectives) then return {} end
	local out = {}
	for _, q in ipairs(S.Resolve.QuestLog()) do
		local list = C.GetQuestObjectives(q)
		if list then
			local t = {}
			for i, o in ipairs(list) do t[i] = { n = o.numFulfilled or 0, type = o.type, text = o.text } end
			out[q] = t
		end
	end
	return out
end

function Capture.SetEnabled(on)
	S.DB().capture = on and true or false
	counts = on and scan() or nil
end

-- The step goals go to: the selected one, else the last (made when none).
local function target()
	local doc = S.Model.Current()
	if not doc then return nil end
	local i = S.Model.Selected()
	if i then return doc, i end
	if #doc.steps == 0 then return doc, S.Model.AddStep("") end
	return doc, #doc.steps
end

-- Whether the step already has a goal like this one.
local function has(step, out)
	for _, g in ipairs(step.goals) do
		local o = g.out
		if o and o.t == out.t then
			if out.quest and o.quest == out.quest and (out.oi == nil or o.oi == out.oi) then return true end
			if not out.quest and out.npc and o.npc == out.npc then return true end
			if not out.quest and out.location and o.location == out.location then return true end
		end
	end
	return false
end

local function add(src, out)
	if not (src and out) then return end
	local doc, i = target()
	if not (doc and i and doc.steps[i]) then return end
	if has(doc.steps[i], out) then return end
	local j = S.Model.AddGoal(i, src, out)
	if j then S.Fire("STUDIO_CAPTURED", i, j) end
end

local function when(fn)
	return function(...)
		if not Capture.Enabled() or not S.Model.Current() then return end
		local ok, err = pcall(fn, ...)
		if not ok and geterrorhandler then geterrorhandler()(err) end
	end
end

S.RegisterEvent("QUEST_ACCEPTED", when(function(_, a, b)
	local q = tonumber(b) or tonumber(a)
	if q then add(S.Resolve.Accept(q)) end
end))

S.RegisterEvent("QUEST_TURNED_IN", when(function(_, q)
	q = tonumber(q)
	if q then add(S.Resolve.Turnin(q, S.Resolve.ChosenReward(q))) end
	if counts then counts[q] = nil end
end))

S.RegisterEvent("UI_INFO_MESSAGE", when(function(_, a, b)
	local msg = type(b) == "string" and b or a
	if ERR_NEWTAXIPATH and msg == ERR_NEWTAXIPATH then
		-- the flight master's map opens with it: give it a moment
		C_Timer.After(0.5, function() add(S.Resolve.GetFP()) end)
	end
end))

S.RegisterEvent("HEARTHSTONE_BOUND", when(function()
	add(S.Resolve.SetHome())
end))

S.RegisterEvent("TRAINER_SHOW", when(function()
	add(S.Resolve.Train())
end))

-- Objective progress: a kill objective that went up becomes a kill goal, an
-- item objective a collect, for the creature/item the Codex names for it
-- (else the creature targeted).
local function codexObjective(q, oi)
	local X = S.Resolve.Codex()
	if not (X and X.Quest) then return nil end
	local ok, rec = pcall(X.Quest, q)
	return ok and rec and rec.objectives and rec.objectives[oi] or nil
end

local function progress()
	local now = scan()
	local before = counts
	counts = now
	if not before then return end
	for q, list in pairs(now) do
		local old = before[q]
		if old then
			for oi, o in ipairs(list) do
				local prev = old[oi]
				if prev and o.n > prev.n then
					local co = codexObjective(q, oi)
					if (co and co.type == "kill") or (not co and o.type == "monster") then
						local npc = co and co.id
						if not npc then
							local kind, id = S.Resolve.Entity("target")
							npc = kind == "npc" and id or nil
						end
						if npc then add(S.Resolve.Kill(npc, nil, q, oi)) end
					elseif (co and co.type == "item") or (not co and o.type == "item") then
						if co and co.id then add(S.Resolve.Collect(co.id, nil, q, oi)) end
					elseif co and co.type == "object" and co.id then
						add(S.Resolve.Interact(co.id))
					end
				end
			end
		end
	end
end

local function queue()
	S.Debounce("capture-scan", 0.3, when(progress))
end
S.RegisterEvent("QUEST_LOG_UPDATE", when(queue))
S.RegisterEvent("UNIT_QUEST_LOG_CHANGED", when(function(_, unit)
	if unit == "player" then queue() end
end))

S.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	if Capture.Enabled() then C_Timer.After(2, function() counts = scan() end) end
end)
