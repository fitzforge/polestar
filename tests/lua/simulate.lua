-- The simulated player (tools/lib/playtest.js SIMULATE): plays the open guide on the stub world
-- (stub_world.lua), step by step, and emits how far it got. forge_addontest::playtest::SIMULATE.
local E, w = Polestar.Engine, stub.world
-- SIM_GUIDE (playGuide): the guide that was set, which the engine may already
-- have left for the next one; else the open guide.
local G = SIM_GUIDE or E.GetGuide()
-- Each line gets the type of the first goal pointing at it, as the game gives
-- every line one: the engine reads a quest collect with no item line from the
-- bags, which the simulator does not fill.
local objs, kinds = {}, {}
local KIND = { kill = "monster", collect = "item", interact = "object" }
for _, s in ipairs(G.steps) do
	for _, g in ipairs(s.goals) do
		if g.quest and g.oi then
			objs[g.quest] = objs[g.quest] or {}
			objs[g.quest][g.oi] = math.max(objs[g.quest][g.oi] or 1, g.count or 1)
			kinds[g.quest] = kinds[g.quest] or {}
			kinds[g.quest][g.oi] = kinds[g.quest][g.oi] or KIND[g.t]
		end
	end
end
local function objectivesFor(q)
	local list, o, n = {}, objs[q], 0
	if o then for i in pairs(o) do if i > n then n = i end end end
	for i = 1, n do list[i] = { required = o[i] or 1, type = kinds[q][i] or "event" } end
	return list
end
local function ensureSkill(r, line)
	if not w.skills[line] then w.learnSkill(line, r.skill or tostring(line), 1, 300) end
end
-- A goal with candidates must have picked one the character may use: the
-- player's faction (or both) and, when listed, race and class. NPC candidates
-- are matched by npc; farm spots (no npc) by the chosen position.
local wrongPick = {}
local function checkPick(i, g, r)
	if not r.candidates then return end
	local tag = w.faction == "Horde" and "H" or "A"
	local function bad(why) wrongPick[#wrongPick + 1] = ("step %d goal %d (%s): %s"):format(i, g.index, r.t, why) end
	if not (g.npc or g.map) then return bad("no usable candidate for " .. w.faction) end
	local function picked(c)
		if c.npc then return c.npc == g.npc end
		return c.map == g.map and c.x == g.x and c.y == g.y
	end
	for _, c in ipairs(r.candidates) do
		if picked(c) then
			if not (c.faction or "AH"):find(tag, 1, true) then
				bad(("picked %s (%s) for %s"):format(tostring(c.npcName), tostring(c.faction), w.faction))
			end
			return
		end
	end
	bad(("picked %s, which is not a candidate"):format(g.npc and ("npc " .. g.npc) or (tostring(g.map) .. " " .. tostring(g.x) .. "," .. tostring(g.y))))
end
local function act(i, g, r)
	local t, q = g.t, g.quest
	if t == "accept" then
		if not w.log[q] and not w.completed[q] then w.accept(q, objectivesFor(q), g.subject) end
	elseif t == "turnin" then
		if w.log[q] then w.finish(q) end
		w.turnIn(q)
	elseif t == "complete" then
		if w.log[q] then w.finish(q) end
	elseif t == "abandon" then
		if w.log[q] then w.abandon(q) end
	elseif t == "destroy" then
		if g.item then w.removeItem(g.item) end
	elseif q and g.oi and (t == "kill" or t == "collect" or t == "use" or t == "interact") then
		if w.log[q] then
			local o = w.log[q].objectives[g.oi]
			if o then w.progress(q, g.oi, o.numRequired) else w.finish(q) end
		end
	elseif q and (t == "kill" or t == "collect" or t == "use" or t == "interact") then
		if w.log[q] then w.finish(q) end
	elseif (t == "collect" or t == "buy") and g.item then
		w.addItem(g.item, (g.progress and g.progress.max) or 1)
	elseif t == "goto" then
		w.moveTo(g.map, g.x, g.y)
	elseif t == "talk" then
		w.gossip(g.npc); w.close()
	elseif t == "train" then
		if r.skillLine and r.rank then
			-- A profession rank: the trainer raises the skill's cap.
			local cap = r.rankMax or ({ 75, 150, 225, 300 })[r.rank]
			local s = w.skills[r.skillLine]
			if s then
				w.skillUp(r.skillLine, s.rank, math.max(cap, s.maxRank or 0))
			else
				w.learnSkill(r.skillLine, r.skill or tostring(r.skillLine), 1, cap)
			end
		end
		w.trainer(g.npc or 1); w.close()
	elseif t == "vendor" then
		w.merchant(g.npc or 1); w.close()
	elseif t == "sethome" then
		w.bind(g.subject or g.npcName or "Inn")
	elseif t == "hearth" or t == "fly" or t == "enter" then
		w.setZone(g.subject, g.subject)
	elseif t == "die" then
		-- A deathskip: back alive beside the graveyard's Spirit Healer.
		w.moveTo(g.map, g.x, g.y)
		stub.fire("PLAYER_UNGHOST")
	elseif t == "level" then
		w.setLevel(math.max(w.level, tonumber((g.subject or ""):match("%d+")) or (w.level + 1)))
		-- A point inside the level ("level 12.5"): that share of its XP.
		local want = r and r.frac and w.level == r.level and math.ceil(r.frac * w.xpMax)
		if want and w.xp < want then w.setXP(want) end
	elseif t == "money" then
		if w.money < (r.money or 0) then w.setMoney(r.money) end
	elseif t == "skill" then
		local line = r.skillLine or r.skill
		ensureSkill(r, line)
		w.skillUp(line, r.level, math.max(r.level, w.skills[line].maxRank or 0))
	elseif t == "cast" then
		w.cast(r.spell)
	elseif t == "learn" then
		w.learnSpell(r.spell)
		w.learnRecipe(r.spell)
	elseif t == "craft" then
		if r.untilSkill then
			local line = r.skillLine or r.skill
			ensureSkill(r, line)
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
	stub.advance(0.6)
end
local visited, stuck, guard = {}, nil, 0
-- The engine may move on to the next guide (a hand-over) during any advance:
-- from then on nothing here may read or act on G's steps.
local function left() return E.GetGuide() ~= G end
while guard < 4000 do
	guard = guard + 1
	local i = E.GetStepIndex()
	if not i or left() then break end
	visited[i] = true
	local view = E.GetStepView(i)
	local open
	for _, g in ipairs(view.goals) do
		if g.status ~= "done" and g.status ~= "na" and not g.optional and g.t ~= "note" then open = g; break end
	end
	if not open then
		stub.advance(0.6)
		if left() then break end
		if E.GetStepIndex() == i then stuck = { step = i, title = view.title, why = "no open goal but the step did not advance" }; break end
	else
		checkPick(i, open, G.steps[i].goals[open.index])
		act(i, open, G.steps[i].goals[open.index])
		if left() then break end
		local after = E.GetStepView(i)
		local same = E.GetStepIndex() == i and after.goals[open.index].status ~= "done"
		if same and open.manual then
			E.ToggleGoal(i, open.index)
			stub.advance(0.6)
			if left() then break end
			same = E.GetStepIndex() == i and E.GetStepView(i).goals[open.index].status ~= "done"
		end
		if same then
			stuck = { step = i, title = view.title, goal = open.index, t = open.t, text = open.text, status = after.goals[open.index].status }
			break
		end
	end
end
local missing = {}
for si, s in ipairs(G.steps) do
	for gi, g in ipairs(s.goals) do
		if (g.t == "accept" and not g.item or g.t == "turnin") and not (g.map and g.x and g.y) then
			missing[#missing + 1] = ("step %d goal %d: %s %s"):format(si, gi, g.t, tostring(g.title or g.quest))
		end
	end
end
local count = 0
for _ in pairs(visited) do count = count + 1 end
emit({ done = E.GetStepIndex() == nil or E.GetGuide() ~= G, stuck = stuck, visited = count, steps = #G.steps, missing = missing, wrongPick = wrongPick, level = w.level })
