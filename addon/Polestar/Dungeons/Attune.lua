-- Polestar.Dungeons, attunements and keys: what lets a character into a raid
-- or opens a dungeon's doors (Dungeons.Attunements, from the Codex journal:
-- tools/lib/codex/attunements.js), this character's progress through it, and
-- a guide that walks the rest. The guide is a Lookup planner kind ("attune",
-- Lookup/Guide.lua): registered as "lookup/attune/<key>:<id>", opened in a new
-- tab, rebuilt after /reload.
--
--   Dungeons.AttunementState(a) -> st
--       st = { done, owned, count, goalDone, steps = { { step, state }, ... }, next, left }
--       state per step: "done" | "ready" (objectives done) | "log" (in the log) | "open"
--       (can be done now) | "locked" (waits on an earlier step) | "level" (level too
--       low) | "rep" (standing too low for the quest) | "na" (not for this
--       character: faction, race, class) | "skip" (another of its alternatives is done,
--       or an alternative this character does not take)
--       drops, chests and gifts are "done" once the item is owned; a standing once reached.
--       done: a key or item owned (bank included); an attunement's goals done (one of
--       them with `any`). goalDone: the goal quests done (a key since lost: goalDone
--       and not done). next: the first step to do; left: steps still to do.
--   Dungeons.AttuneGuide(key, id) -> def | nil, reason   -- "done", "nothing", "unknown"
--   Dungeons.Attune(key, id) -> guideId | nil, reason    -- builds, registers and opens it
--
-- Guide: one stop per quest still to do (Lookup.QuestStep, with the open
-- prerequisites Lookup.QuestChain finds that the list lacks), after the
-- steps it waits on, each whole: its accept, objectives and turn-in, also
-- when the giver, a target or the turn-in is inside an instance (the Codex's
-- NPC instance, else the attunement's cited `inside`): sent to that
-- instance's entrance, the step's note saying what is inside; a quest above
-- the character's level stays, its accept saying from which level (Engine).
-- A drop or chest as a collect step at its NPC or object (inside an
-- instance: at its entrance); a standing as a rep step; a gift as a talk
-- step. The quests are ordered as the cheapest path from where the
-- player stands (Dungeons.OrderStops, kept per character as
-- CharState().dungeonAttune["<key>:<id>"]); the item steps follow the quests
-- they come after. Of `any` alternatives the guide takes the one this
-- character's standing fits best. The other side's attunement builds none.

local ADDON, ns = ...
local L = ns.L
local Dungeons = ns.Dungeons

local type, ipairs, format, tostring = type, ipairs, string.format, tostring

local KIND = "attune"

local function LK() return ns.Lookup end

local function done(id) return ns.Compat.IsQuestCompleted(id) and true or false end
local function inLog(id) return ns.Compat.IsOnQuest(id) and true or false end

local function located(p)
	return type(p) == "table" and p.map ~= nil and p.x ~= nil and p.y ~= nil
end

local function standing(faction)
	return tonumber((ns.Compat.GetFactionStanding(faction))) or 4
end

local function owned(item)
	if not (type(item) == "table" and item.id) then return 0 end
	return ns.Compat.GetItemCount(item.id, true) or 0
end

local NOT_YOURS = { faction = true, race = true, class = true }

local function find(key, id)
	for _, a in ipairs(Dungeons.Attunements(key)) do
		if a.id == id then return a end
	end
	return nil
end

-- One quest step's state before the alternatives are settled.
local function questState(s, p)
	if s.faction and p.code and s.faction ~= p.code then return "na" end
	if done(s.id) then return "done" end
	if ns.Compat.IsQuestReadyForTurnIn(s.id) then return "ready" end
	if inLog(s.id) then return "log" end
	local C, Lk = ns.Codex, LK()
	local rec = C and C.Quest and C.Quest(s.id)
	if rec and Lk and Lk.QuestBlock and NOT_YOURS[Lk.QuestBlock(rec, p)] then return "na" end
	for _, pid in ipairs(s.after or {}) do
		if not done(pid) then return "locked" end
	end
	local any = s.afterAny or {}
	if #any > 0 then
		local ok = false
		for _, pid in ipairs(any) do ok = ok or done(pid) end
		if not ok then return "locked" end
	end
	if (s.minLevel or 0) > (p.level or 1) then return "level" end
	if s.rep and s.rep.faction and standing(s.rep.faction) < (s.rep.standing or 0) then return "rep" end
	return "open"
end

local TODO = { open = true, log = true, ready = true, locked = true, level = true, rep = true }

-- Of `any` goals: the one this character takes (its standing fits, the
-- highest standing first), else the first that is theirs.
local function chosenGoal(a, states)
	local best, bestNeed
	for i, s in ipairs(a.steps) do
		if s.kind == "quest" and s.goal and states[i] ~= "na" then
			local need = s.rep and s.rep.standing or 0
			local fits = not s.rep or standing(s.rep.faction) >= need
			if fits and (not best or need > bestNeed) then best, bestNeed = s.id, need end
		end
	end
	if best then return best end
	for i, s in ipairs(a.steps) do
		if s.kind == "quest" and s.goal and states[i] ~= "na" then return s.id end
	end
	return nil
end

function Dungeons.AttunementState(a)
	local Lk = LK()
	local p = Lk and Lk.PlayerInfo and Lk.PlayerInfo() or { level = 1 }
	local count = owned(a.item)
	local states = {}
	-- The quest an item starts: once taken, the item's own steps are behind.
	local starts = {}
	for _, s in ipairs(a.steps or {}) do
		if s.kind == "quest" and s.startItem then starts[s.startItem.id] = s.id end
	end
	for i, s in ipairs(a.steps or {}) do
		if s.kind == "quest" then
			states[i] = questState(s, p)
		elseif s.kind == "rep" then
			states[i] = standing(s.faction) >= (s.standing or 0) and "done" or "open"
		else
			local q = s.item and starts[s.item.id]
			local have = (s.item and a.item and s.item.id == a.item.id) and count or owned(s.item)
			states[i] = (have > 0 or (q and (done(q) or inLog(q)))) and "done" or "open"
		end
	end
	-- Alternatives: a done one settles the rest of its group.
	local byId = {}
	for i, s in ipairs(a.steps or {}) do
		if s.kind == "quest" then byId[s.id] = i end
	end
	for _, s in ipairs(a.steps or {}) do
		local any = s.kind == "quest" and s.afterAny or {}
		if #any > 1 then
			local hit = false
			for _, pid in ipairs(any) do hit = hit or done(pid) end
			if hit then
				for _, pid in ipairs(any) do
					local j = byId[pid]
					if j and states[j] ~= "done" then states[j] = "skip" end
				end
			end
		end
	end
	local goals, goalsDone, anyDone = 0, 0, false
	for i, s in ipairs(a.steps or {}) do
		if s.kind == "quest" and s.goal and states[i] ~= "na" then
			goals = goals + 1
			if states[i] == "done" then goalsDone, anyDone = goalsDone + 1, true end
		end
	end
	local goalDone = goals > 0 and (a.any and anyDone or goalsDone == goals) or false
	if a.any then
		local pick = anyDone and nil or chosenGoal(a, states)
		for i, s in ipairs(a.steps or {}) do
			if s.kind == "quest" and s.goal and states[i] ~= "done" and states[i] ~= "na" and (anyDone or s.id ~= pick) then states[i] = "skip" end
		end
	end
	local isDone
	if a.item and a.kind ~= "attunement" then
		isDone = count > 0
	else
		isDone = goalDone
	end
	local st = { done = isDone, owned = a.item and count > 0 or nil, count = count, goalDone = goalDone, steps = {}, left = 0 }
	for i, s in ipairs(a.steps or {}) do
		local state = states[i]
		if isDone and TODO[state] then state = "skip" end
		st.steps[i] = { step = s, state = state }
		if TODO[state] then
			st.left = st.left + 1
			if not st.next and state ~= "locked" then st.next = i end
		end
	end
	return st
end

---------------------------------------------------------------------------
-- The guide
---------------------------------------------------------------------------

-- Lookup.QuestEnd's { npc|object, name, spawn } -> a point.
local function endPoint(e)
	if not (e and e.spawn) then return nil end
	local s = e.spawn
	return { kind = e.npc and "npc" or "object", id = e.npc or e.object, name = e.name, map = s.map, x = s.x, y = s.y, f = s.f }
end

-- inside(kind, id) for Lookup.QuestStep: where an NPC or object without a
-- spawn is, the entrance of its instance (the Codex's NPC instance, else the
-- attunement's `inside`) -> { map, x, y, f, name = instance name } | nil.
local function insideOf(a)
	local listed = {}
	for _, e in ipairs(a.inside or {}) do listed[e.kind .. ":" .. tostring(e.id)] = e.instance end
	local C = ns.Codex
	return function(kind, id)
		local key = listed[kind .. ":" .. tostring(id)]
		if not key and kind == "npc" and C and C.Npc then
			local npc = C.Npc(id)
			key = npc and npc.instance
		end
		local inst = key and Dungeons.Get(key)
		local e = inst and inst.entrance
		if not located(e) then return nil end
		return { map = e.map, x = e.x, y = e.y, f = e.f, name = inst.name }
	end
end

-- A quest's giver or turn-in as a point: its nearest spawn, else inside.
local function questPoint(ends, from, inside)
	local p = endPoint(LK().QuestEnd(ends, from))
	if p or type(ends) ~= "table" then return p end
	for _, kind in ipairs({ "npc", "object" }) do
		for _, id in ipairs(ends[kind] or {}) do
			local e = inside(kind, id)
			if e then return { kind = kind, id = id, name = ns.Codex.Name(kind, id), map = e.map, x = e.x, y = e.y, f = e.f } end
		end
	end
	return nil
end

-- Where an item step happens: its NPC's or object's spawn, else (inside an
-- instance) the instance's entrance -> point, the instance's name when inside.
local function itemPoint(s, inside)
	local who = s.npc or s.object
	local inst = s.instance and Dungeons.Get(s.instance)
	if located(who) then return who, inst and inst.name end
	local e = inst and inst.entrance
	if located(e) then return { map = e.map, x = e.x, y = e.y, f = e.f, name = inst.name }, inst.name end
	local p = who and inside(s.npc and "npc" or "object", who.id)
	if p then return p, p.name end
	return nil
end

local function at(goal, p)
	if located(p) then goal.map, goal.x, goal.y, goal.f = p.map, p.x, p.y, p.f == "e" and "e" or nil end
	return goal
end

-- A drop or chest: one collect step at its source.
local function itemStep(s, inside)
	local where = s.npc or s.object
	local p, instName = itemPoint(s, inside)
	local goal = at({ t = "collect", item = s.item.id, itemName = s.item.name, count = 1 }, p)
	if s.npc then goal.npc, goal.npcName = s.npc.id, s.npc.name end
	if s.object then goal.object, goal.objName = s.object.id, s.object.name end
	local step = { title = s.item.name or L["Item"], goals = { goal } }
	if instName then
		local text = s.npc and format(L["%s drops it inside %s."], where and where.name or "?", instName)
			or format(L["%s: inside %s."], where and where.name or "?", instName)
		step.goals[#step.goals + 1] = { t = "note", text = text }
	end
	return step
end

-- The quest stops: every quest step still to do (and the open prerequisites
-- QuestChain adds), each after the quest steps it waits on.
local function questStops(a, st, p, from, inside)
	local Lk, C = LK(), ns.Codex
	local stops, byId = {}, {}
	local function add(rec, deps)
		if byId[rec.id] then return byId[rec.id] end
		local start = questPoint(rec.start, from, inside)
		local finish = questPoint(rec["end"], start or from, inside)
		stops[#stops + 1] = { key = "q" .. rec.id, rec = rec, inP = start, outP = finish or start, deps = deps or {} }
		byId[rec.id] = #stops
		return #stops
	end
	for i, e in ipairs(st.steps) do
		local s = e.step
		if s.kind == "quest" and TODO[e.state] then
			local rec = C.Quest(s.id)
			if rec then
				local deps = {}
				-- Prerequisites our list lacks come before it, in their order.
				local chain = Lk.QuestChain(s.id, p)
				for c = 1, #chain - 1 do
					local r = chain[c]
					if not byId[r.id] then
						local listed = false
						for _, o in ipairs(st.steps) do listed = listed or (o.step.kind == "quest" and o.step.id == r.id) end
						if not listed then deps[#deps + 1] = add(r, { deps[#deps] }) end
					end
				end
				for _, pid in ipairs(s.after or {}) do
					if byId[pid] then deps[#deps + 1] = byId[pid] end
				end
				for _, pid in ipairs(s.afterAny or {}) do
					if byId[pid] then deps[#deps + 1] = byId[pid] end
				end
				local idx = add(rec, deps)
				stops[idx].index = i
			end
		end
	end
	return stops
end

function Dungeons.AttuneGuide(key, id)
	local a = find(key, id)
	if not a then return nil, "unknown" end
	local Lk, C = LK(), ns.Codex
	if not (Lk and Lk.QuestChain and Lk.QuestStep and C) then return nil, "missing" end
	local st = Dungeons.AttunementState(a)
	if st.done then return nil, "done" end
	local p = Lk.PlayerInfo()
	if a.faction and p.code and a.faction ~= p.code then return nil, "nothing" end
	local from = ns.PlayerPoint()
	local inside = insideOf(a)
	local stops = questStops(a, st, p, from, inside)
	local order = Dungeons.OrderStops(stops, from, nil, "dungeonAttune", key .. ":" .. id)
	local steps = {}
	-- Item, standing and gift steps follow the quest step before them in the list.
	local placed = {}
	local function extras(upTo)
		for i = 1, upTo do
			local e = st.steps[i]
			local s = e.step
			if not placed[i] and s.kind ~= "quest" and TODO[e.state] then
				placed[i] = true
				if s.kind == "drop" or s.kind == "object" then
					-- One step per item: its best source; the rest of that item's sources are skipped.
					local dup = false
					for j = 1, i - 1 do
						local o = a.steps[j]
						dup = dup or ((o.kind == "drop" or o.kind == "object") and o.item.id == s.item.id and placed[j])
					end
					if not dup then steps[#steps + 1] = itemStep(s, inside) end
				elseif s.kind == "rep" then
					local N = ns.Names
					local faction = (N and N.Faction(s.faction)) or s.name
					steps[#steps + 1] = { title = faction or L["Reputation"], goals = { { t = "rep", faction = s.faction, factionName = faction, standing = s.standing } } }
				elseif s.kind == "gift" then
					steps[#steps + 1] = { title = s.npc and s.npc.name or L["Talk to"], goals = { at({ t = "talk", npc = s.npc and s.npc.id, npcName = s.npc and s.npc.name }, s.npc) } }
				end
			end
		end
	end
	for _, si in ipairs(order) do
		local stop = stops[si]
		extras((stop.index or 1) - 1)
		steps[#steps + 1] = Lk.QuestStep(stop.rec, stop.inP or from, { inside = inside })
	end
	extras(#st.steps)
	if #steps == 0 then return nil, "nothing" end
	local d = Dungeons.Get(key)
	local last = { title = d and d.name or a.name, goals = {} }
	if a.note then last.goals[#last.goals + 1] = { t = "note", text = L[a.note] } end
	local e = d and d.entrance
	if located(e) then
		last.goals[#last.goals + 1] = { t = "goto", text = L["Enter"] .. " " .. d.name, map = e.map, x = e.x, y = e.y, f = e.f == "e" and "e" or nil }
	end
	if #last.goals > 0 then steps[#steps + 1] = last end
	return { title = format(L["%s: %s"], d and d.name or key, a.name), steps = steps, dungeon = key }
end

function Dungeons.Attune(key, id)
	if not Dungeons.IsEnabled() then return nil, "off" end
	local Lk = LK()
	if not (Lk and Lk.Guide) then return nil, "missing" end
	return Lk.Guide(KIND, tostring(key) .. ":" .. tostring(id))
end

-- The attune kind builds only while Dungeons is on; its id is "<key>:<id>".
if ns.Lookup and ns.Lookup.RegisterPlanner then
	ns.Lookup.RegisterPlanner(KIND, function(ref)
		if not Dungeons.IsEnabled() then return nil, "off" end
		local ok, reason = Dungeons.Load()
		if not ok then return nil, reason end
		local key, id = tostring(ref):match("^([^:]+):(.+)$")
		if not key then return nil, "unknown" end
		return Dungeons.AttuneGuide(key, id)
	end)
end
