-- The whole route played by one simulated character, for the dungeons-in-the-route checks
-- (rust/crates/forge-addontest/tests/addontest/dungeons-e2e.rs): the start guide and every guide the
-- engine hands over to (behavior.guideEnd "continue", the recommended route), with "Dungeons in my route"
-- (behavior.dungeons) set by E2E.mode and changed on the way (E2E.switches), and the character's level
-- following the calibrated level model (E2E.levels: per guide, the level at its start and after each of
-- its hand-ins; without it, only a goal waiting for a level raises it, as in simulate.lua). At each step
-- the simulated player does the first open goal the way simulate.lua's does; at a dungeon's run it does
-- the whole run, its optional goals too (a group runs it whole). A question from the route (Ask me) is
-- answered by E2E.ask. A goal that does not get done is a stuck step: recorded, then skipped, so one
-- finding does not hide the rest of the route. Emits one table:
--   { trace = { event, ... }, done = { ... }, ended = { guide, level, log = { { q, title, ready } } }, maxLog }
-- Events (short keys, the trace is long): { e = "live", g, s, n, h, t, k, ti, l, q, d, m } the live step
-- changed (guide, index, number, hidden, total, step key, title, level, log size, dungeon role, map);
-- { e = "acc" | "tin", g, s, q, l, m } an accept or hand-in (m: the dungeon of a `when dungeon` step);
-- { e = "ask", g, s, m, name, a, l } a dungeon question answered; { e = "sw", set, l, g0, s0, g1, s1 } a
-- switch, with the live step before and after; { e = "door", g, s, m, from, to, l } a run step reached
-- (the player's place before it and the door); { e = "stuck", g, s, ti, why } and { e = "lvl", l, why }.
--
-- E2E = {
--   start = "<guide id>", mode = "skip" | "run" | "ask",
--   ask = "alternate" | { [map] = true | false },  -- the answer to each dungeon question
--   switches = { { level = 34, set = "run" | "skip" | "ask", ask = ..., offAtRun = true }, ... },
--   levels = { ["<guide id>"] = { s = 12.3, q = { [quest] = 13.1 } } } | nil,
--   objs = { [quest] = { { n, kind }, ... } },     -- each objective's count and kind (all guides')
--   maxIter = 150000,
-- }

local E, w = Polestar.Engine, stub.world
local OPT = E2E
local trace, ev = {}, nil
local function push(e) trace[#trace + 1] = e end

-- Every move puts the player in its map's zone, as the zone text says (guides-end-early.rs).
do
	local move = w.moveTo
	w.moveTo = function(map, x, y)
		move(map, x, y)
		local m = w.maps[map]
		if m and m.name and m.name ~= "" and m.name ~= w.zone then w.setZone(m.name, "") end
	end
end

local function level() return w.level + ((w.level < 60 and (w.xpMax or 0) > 0) and (w.xp or 0) / w.xpMax or 0) end
local function round2(v) return math.floor(v * 100 + 0.5) / 100 end

-- Raise the level to L (never lower): the whole level and the share of it as XP.
local function raise(L, why)
	if not L or L <= level() + 1e-6 then return end
	if L >= 60 then
		if w.level < 60 then w.setLevel(60) end
		w.setXP(0)
	else
		local whole = math.floor(L)
		if whole > w.level then w.setLevel(whole) end
		w.setXP(math.floor((L - whole) * (w.xpMax or 400) + 0.5))
	end
	if why then push({ e = "lvl", l = round2(level()), why = why }) end
end

local function logSize()
	local n = 0
	for _ in pairs(w.log) do n = n + 1 end
	return n
end
local maxLog = 0
local function noteLog()
	local n = logSize()
	if n > maxLog then maxLog = n end
	return n
end

local function objectivesFor(q)
	local list = {}
	for i, o in ipairs(OPT.objs[q] or {}) do list[i] = { required = o[1] or 1, type = o[2] or "event" } end
	return list
end

-- A step's dungeon role: "pickup" (an accept), "run" (an enter), "handin", "other" for a `when dungeon`
-- step; "solo" for a `when !dungeon` one; and the dungeon's map. nil for any other step.
local function roleOf(step)
	for _, p in ipairs(step and step.when or {}) do
		if p.k == "dungeon" then
			if p.neg then return "solo", p.map, p.name end
			local r = "other"
			for _, g in ipairs(step.goals) do
				if g.t == "enter" then r = "run" break end
				if g.t == "accept" then r = "pickup" elseif g.t == "turnin" and r == "other" then r = "handin" end
			end
			return r, p.map, p.name
		end
	end
	return nil
end

local G, gid, live
local function where() return gid, live end
local dungeonQuests = {} -- quest -> the map of the `when dungeon` step that accepted it

local function stepKey(g, i)
	local P = Polestar.Party
	return P and P.StepKey and P.StepKey(g, i) or tostring(i)
end

local function bumpGuide()
	local g = E.GetGuide()
	if g ~= G then
		G, gid = g, g and g.id or nil
		if gid and OPT.levels and OPT.levels[gid] then raise(OPT.levels[gid].s, "start " .. gid) end
	end
end

local function noteLive()
	bumpGuide()
	local i = E.GetStepIndex()
	if not G or not i then return end
	if gid == ev.g and i == ev.s then return end
	ev.g, ev.s = gid, i
	live = i
	local n, h = E.StepNumber(i)
	local step = G.steps[i]
	local role, map = roleOf(step)
	push({ e = "live", g = gid, s = i, n = n, h = h and true or nil, t = E.StepTotal(), k = stepKey(G, i), ti = step and step.title or "",
		l = round2(level()), q = noteLog(), d = role, m = map })
end

local function act(i, g, r, role, map)
	local t, q = g.t, g.quest
	if t == "accept" then
		if not w.log[q] and not w.completed[q] then
			w.accept(q, objectivesFor(q), g.subject)
			local m = role and role ~= "solo" and map or nil
			if m then dungeonQuests[q] = m end
			push({ e = "acc", g = gid, s = i, q = q, l = round2(level()), m = m })
		end
	elseif t == "turnin" then
		local had = w.log[q] ~= nil
		if had then w.finish(q) end
		w.turnIn(q)
		if had then
			push({ e = "tin", g = gid, s = i, q = q, l = round2(level()), m = role and role ~= "solo" and map or nil })
			local L = OPT.levels and OPT.levels[gid]
			if L and L.q[q] then raise(L.q[q]) end
		end
	elseif t == "complete" then
		if w.log[q] then w.finish(q) end
	elseif t == "abandon" then
		if w.log[q] then
			w.abandon(q)
			push({ e = "abn", g = gid, s = i, q = q })
		end
	elseif t == "destroy" then
		if g.item then w.removeItem(g.item) end
	elseif q and g.oi and (t == "kill" or t == "collect" or t == "use" or t == "interact" or t == "talk") then
		if w.log[q] then
			local o = w.log[q].objectives[g.oi]
			if o then w.progress(q, g.oi, o.numRequired) else w.finish(q) end
		end
	elseif q and (t == "kill" or t == "collect" or t == "use" or t == "interact" or t == "talk") then
		if w.log[q] then w.finish(q) end
	elseif (t == "collect" or t == "buy") and g.item then
		w.addItem(g.item, (g.progress and g.progress.max) or 1)
	elseif t == "goto" then
		w.moveTo(g.map, g.x, g.y)
	elseif t == "talk" then
		w.gossip(g.npc); w.close()
	elseif t == "train" then
		if r.skillLine and r.rank then
			local cap = r.rankMax or ({ 75, 150, 225, 300 })[r.rank]
			local s = w.skills[r.skillLine]
			if s then w.skillUp(r.skillLine, s.rank, math.max(cap, s.maxRank or 0)) else w.learnSkill(r.skillLine, r.skill or tostring(r.skillLine), 1, cap) end
		end
		w.trainer(g.npc or 1); w.close()
	elseif t == "vendor" then
		w.merchant(g.npc or 1); w.close()
	elseif t == "sethome" then
		w.bind(g.subject or g.npcName or "Inn")
	elseif t == "hearth" or t == "fly" or t == "enter" then
		-- In the place the goal names, as the Engine reads it (inPlace: its area's name, else its location): a
		-- dungeon's `enter` by the instance's name, not the goal's display text.
		if g.map and g.x and g.y then w.moveTo(g.map, g.x, g.y) end
		local C = Polestar.Compat
		local place = t == "enter" and r and ((C and C.GetAreaName and C.GetAreaName(r.area)) or r.location) or g.subject
		w.setZone(place, place)
	elseif t == "die" then
		w.moveTo(g.map, g.x, g.y)
		stub.fire("PLAYER_UNGHOST")
	elseif t == "level" then
		local want = (r and tonumber(r.level)) or tonumber((g.subject or ""):match("%d+")) or (w.level + 1)
		if r and r.frac then want = want + r.frac end
		raise(math.max(want, w.level), "level goal")
	elseif t == "money" then
		if w.money < (r.money or 0) then w.setMoney(r.money) end
	elseif t == "skill" then
		local line = r.skillLine or r.skill
		if not w.skills[line] then w.learnSkill(line, r.skill or tostring(line), 1, 300) end
		w.skillUp(line, r.level, math.max(r.level, w.skills[line].maxRank or 0))
	elseif t == "cast" then
		w.cast(r.spell)
	elseif t == "learn" then
		w.learnSpell(r.spell)
		w.learnRecipe(r.spell)
	elseif t == "craft" then
		if r.untilSkill then
			local line = r.skillLine or r.skill
			if not w.skills[line] then w.learnSkill(line, r.skill or tostring(line), 1, 300) end
			w.skillUp(line, r.untilSkill, math.max(r.untilSkill, w.skills[line].maxRank or 0))
		elseif r.item then
			w.addItem(r.item, r.count or 1)
		end
	elseif t == "rep" then
		w.setRep(r.faction, r.factionName or tostring(r.faction), r.standing, 0, 0, 3000)
	elseif t == "explore" then
		local id = 900000 + i * 100 + g.index
		w.addArea(r.map, r.x - 1, r.y - 1, r.x + 1, r.y + 1, id)
		w.moveTo(r.map, r.x, r.y)
		w.explore(id)
	elseif t == "achieve" then
		local a = w.achievements[r.achievement]
		if not a then
			w.addAchievement(r.achievement, r.achievementName, { { "criterion", 1 } })
			a = w.achievements[r.achievement]
		end
		for ci, c in ipairs(a.criteria) do
			if not r.criteria or r.criteria == ci then w.criteria(r.achievement, ci, c.max) end
		end
	end
	-- At the goal's point after it (a place goal already put the character there: moving again would read the
	-- map's zone, out of the place it entered).
	if g.map and g.x and g.y and t ~= "goto" and t ~= "die" and t ~= "explore" and t ~= "hearth" and t ~= "fly" and t ~= "enter" then w.moveTo(g.map, g.x, g.y) end
	stub.advance(0.6)
	noteLog()
end

-- "Dungeons in my route" and a per-dungeon answer policy.
local askPolicy, asked, askOrder = OPT.ask or "alternate", {}, 0
local function answerFor(map)
	if type(askPolicy) == "table" then
		local a = askPolicy[map]
		if a == nil then a = askPolicy[tostring(map)] end
		return a == true
	end
	askOrder = askOrder + 1
	return askOrder % 2 == 1 -- the first asked runs, the next is skipped, and so on
end
local function setMode(m, ask)
	Polestar.Set("behavior.dungeons", m)
	if ask ~= nil then askPolicy = ask end
	stub.advance(0.6)
end

-- The quests a `when dungeon` step accepted that are still in the log, each with what the route plan
-- says of it (Core/RoutePlan.lua: its hand-in status, and whether the quest room lists it as room to
-- make, Plan.Unneeded: the advice to drop it). While another quest keeps Plan.Unneeded from saying (a
-- route choice ahead), the quest's own status says it: Plan.Unneeded lists "missed", "skipped" and
-- "unplanned"; "unknown" only while its own hand-in waits on a choice or an unloaded guide.
local ROOM = { missed = true, skipped = true, unplanned = true }
local UNSURE = { noGuide = true, choice = true, unloaded = true }
local function kept()
	local RP = Polestar.RoutePlan
	local list = RP and RP.Unneeded and RP.Unneeded()
	local un = {}
	for _, u in ipairs(list or {}) do un[u.quest] = u.status or true end
	local out = {}
	for q, map in pairs(dungeonQuests) do
		local e = w.log[q]
		if e then
			local ready = true
			for _, o in ipairs(e.objectives) do if not o.finished then ready = false end end
			local r = RP and RP.GetTurnIn and RP.GetTurnIn(q) or {}
			local u
			if list then u = un[q] or false
			elseif UNSURE[r.status] then u = "unknown"
			else u = ROOM[r.status] and r.status or false end
			out[#out + 1] = { q = q, m = map, ready = ready, st = r.status or false, un = u }
		end
	end
	table.sort(out, function(a, b) return a.q < b.q end)
	return out
end

local function swAt(sw)
	local g0, s0 = where()
	if sw.set then setMode(sw.set, sw.ask) end
	noteLive()
	push({ e = "sw", set = sw.set, l = round2(level()), g0 = g0, s0 = s0, g1 = gid, s1 = E.GetStepIndex() or false, why = sw.why,
		kept = sw.set == "skip" and kept() or nil })
end

-- Prepare: login, the settings a playtest takes, the start guide.
stub.login()
stub.fire("QUEST_LOG_UPDATE")
Polestar.Set("behavior.guideEnd", "continue")
Polestar.Set("behavior.routeChoice", "recommended")
Polestar.Set("behavior.groupQuests", "skip")
Polestar.Set("behavior.dungeons", OPT.mode or "skip")
E.SetGuide(OPT.start)
stub.advance(3)
ev = { g = false, s = false }
noteLive()

local switches = OPT.switches or {}
local nextSwitch = 1
local offAtRun -- a switch's run step to turn dungeons off at, mid-run
local guard, stalls = 0, 0
local maxIter = OPT.maxIter or 150000
local doneRuns = {}
while guard < maxIter do
	guard = guard + 1
	noteLive()
	local i = E.GetStepIndex()
	if not G or not i then
		-- The guide ended: the engine hands over during the evaluation; give it a moment.
		stub.advance(1)
		noteLive()
		if not E.GetStepIndex() then break end
		i = E.GetStepIndex()
	end
	-- Switches by level, at the live step.
	local sw = switches[nextSwitch]
	if sw and sw.level and level() >= sw.level then
		nextSwitch = nextSwitch + 1
		swAt(sw)
		if sw.offAtRun then offAtRun = true end
	else
		local step = G.steps[i]
		local role, map, dname = roleOf(step)
		-- A question from the route (Ask me): answered.
		local dq = E.DungeonQuestion and E.DungeonQuestion()
		if dq then
			local a = answerFor(dq.map)
			asked[dq.map] = (asked[dq.map] or 0) + 1
			push({ e = "ask", g = gid, s = i, m = dq.map, name = dq.name, a = a, l = round2(level()), n = asked[dq.map] })
			if asked[dq.map] > 3 then
				-- The answer did not take: the route would ask for ever.
				push({ e = "stuck", g = gid, s = i, ti = step and step.title or "", why = "the dungeon question comes back after its answer" })
				E.Skip()
			else
				E.ChooseDungeon(dq.map, a)
			end
			stub.advance(0.6)
		else
			local view = E.GetStepView(i)
			local need = 0
			for _, g in ipairs(view.goals) do
				if g.unavailable == "level" then need = math.max(need, tonumber((g.unavailableText or ""):match("(%d+)")) or w.level + 1) end
				if g.waitsLevel then need = math.max(need, g.waitsLevel) end
			end
			local fullRun = role == "run" and E.DungeonChosen and E.DungeonChosen(map)
			if fullRun and not doneRuns[gid .. "#" .. i] then
				doneRuns[gid .. "#" .. i] = true
				local door
				for _, g in ipairs(G.steps[i].goals) do if g.t == "enter" then door = g break end end
				push({ e = "door", g = gid, s = i, m = map, name = dname, l = round2(level()),
					from = { w.map or false, w.x or false, w.y or false }, to = door and { door.map or false, door.x or false, door.y or false } or false,
					run = E.DungeonRun and E.DungeonRun() and true or false })
			end
			local open
			-- A run is a full clear: its optional quest goals (a rare drop, a roaming boss) first, as the step
			-- moves on once its other goals are done.
			for _, g in ipairs(fullRun and not offAtRun and view.goals or {}) do
				if g.status ~= "done" and g.status ~= "na" and g.optional and g.quest and w.log[g.quest] and g.t ~= "enter" then open = g break end
			end
			for _, g in ipairs(open and {} or view.goals) do
				if g.status ~= "done" and g.status ~= "na" and g.t ~= "note" and not g.side and (not g.optional or (fullRun and g.quest)) then open = g break end
			end
			if offAtRun and fullRun then
				-- Turn dungeons off mid-run: the door reached and one of the run's quests done.
				local did = false
				for _, g in ipairs(view.goals) do
					if g.status ~= "done" and g.status ~= "na" and g.quest and (g.t == "complete" or g.oi) then
						act(i, g, G.steps[i].goals[g.index], role, map)
						did = true
						break
					end
				end
				offAtRun = nil
				swAt({ set = "skip", why = "off mid-run" })
				push({ e = "offrun", g = gid, s = i, m = map, did = did })
			elseif need > w.level then
				w.setLevel(need)
				push({ e = "lvl", l = round2(level()), why = "waits " .. need })
				stub.advance(0.6)
			elseif not open then
				local g0 = G
				stub.advance(0.6)
				noteLive()
				if E.GetGuide() == g0 and E.GetStepIndex() == i then
					push({ e = "stuck", g = gid, s = i, ti = view.title, why = "no open goal but the step did not advance" })
					E.Skip()
					stub.advance(0.6)
				end
			else
				act(i, open, G.steps[i].goals[open.index], role, map)
				if E.GetGuide() == G and E.GetStepIndex() == i then
					local after = E.GetStepView(i)
					local still = after.goals[open.index] and after.goals[open.index].status ~= "done"
					if still and open.manual then
						E.ToggleGoal(i, open.index)
						stub.advance(0.6)
						still = E.GetGuide() == G and E.GetStepIndex() == i and E.GetStepView(i).goals[open.index].status ~= "done"
					end
					if still then
						stalls = stalls + 1
						local r, C = G.steps[i].goals[open.index], Polestar.Compat
						local zone, sub = C.GetZoneText()
						-- For a goal done by a place: what the Engine compares (the goal's area or location, the zone
						-- and subzone texts, the taxi).
						local at = r and (r.t == "enter" or r.t == "hearth" or r.t == "fly") and { loc = r.location or false, area = r.area or false,
							areaName = C.GetAreaName and r.area and C.GetAreaName(r.area) or false, zone = zone or false, sub = sub or false, taxi = C.IsOnTaxi() and true or false } or nil
						push({ e = "stuck", g = gid, s = i, ti = view.title, at = at, why = ("goal %d (%s%s) stays %s"):format(open.index, open.t, open.text and (' "' .. open.text .. '"') or "", tostring(after.goals[open.index] and after.goals[open.index].status)) })
						E.Skip()
						stub.advance(0.6)
					end
				end
			end
		end
	end
end

local ended = { guide = gid or false, level = round2(level()), iter = guard, log = {}, kept = kept() }
for q, e in pairs(w.log) do
	local ready = true
	for _, o in ipairs(e.objectives) do if not o.finished then ready = false end end
	ended.log[#ended.log + 1] = { q = q, title = e.title, ready = ready, m = dungeonQuests[q] }
end
table.sort(ended.log, function(a, b) return a.q < b.q end)
emit({ trace = trace, ended = ended, maxLog = maxLog, stalls = stalls })
