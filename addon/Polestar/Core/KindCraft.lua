-- The profession and reputation kinds' region models (docs/ARCHITECTURE.md, "Guide kind regions"): pure data for
-- the guide window's regions (UI/GuideFrameKindCraft.lua), the tests and the preview, through
-- Engine.KindModel(region, view). Built from the Engine's own view of the guide (Engine.KindAccess), the client's
-- skill and standing, and the materials' counts, ways and prices (Core/Materials.lua).
--
-- Profession: the window draws its steps as the leveling view's rows (UI/GuideFrameRegions.lua, "step"): "meter"
-- (the slim skill line), "stretch" (the craft step's row: its `craft … until` recipe, the colour now, about how many
-- crafts still to go, the casts counted), "get" (a get step: "Get 42 Rough Stone" and its ways, each a choice:
-- gather it, the Auction House, a vendor), "shopping" (the section's materials, have / need, what is set to Buy).
-- Reputation: "meter" (the standing), "turnin" (the step's turn-in), "more" (the guide's other quests for the
-- faction).
--
-- The stretch: the first `craft … until` goal from the step in view on that the skill is under. Its colours
-- (Classic's): orange below `yellow`, yellow below green ((yellow + grey) / 2), green below `grey`, grey from
-- there. Crafts left (Engine's craftsFrom, the skill-up chance) from the skill now to the move-on, whatever made
-- the points so far; made = the casts of the recipe counted (UNIT_SPELLCAST_SUCCEEDED, per character), never a
-- guess from the skill (points since the stretch's start may come from other recipes or trainers).
--
-- Engine.FarmMinutes(item): the minutes farming what is still needed takes, for Materials.Way's "long" (bought
-- past Materials.LONG): what the stretch still needs of it, else what its gather goal still needs.

local _, ns = ...
local Engine, Materials = ns.Engine, ns.Materials
local floor, ceil, max, min = math.floor, math.ceil, math.max, math.min
local pairs, ipairs, type = pairs, ipairs, type

local KC = {}
ns.KindCraft = KC

local function access() return Engine.KindAccess end
local function C() return ns.Compat end

local function bags(item) return C().GetItemCount and C().GetItemCount(item) or 0 end

local function itemName(item, fallback)
	return (C().GetItemName and C().GetItemName(item)) or fallback or ("#" .. tostring(item))
end

local function quality(item)
	return C().GetItemQuality and C().GetItemQuality(item) or nil
end

-- A profession's name in the client's language.
function KC.SkillName(line)
	local Nearby = ns.Nav and ns.Nav.nearby
	return (Nearby and Nearby.ProfessionName and Nearby.ProfessionName(line)) or (C().GetSkillLineName and C().GetSkillLineName(line)) or nil
end

---------------------------------------------------------------------------
-- State: the crafts made per stretch, per character
---------------------------------------------------------------------------

local function madeState()
	local s = ns.CharState()
	local k = s.kindCraft
	if type(k) ~= "table" then
		k = {}
		s.kindCraft = k
	end
	if type(k.made) ~= "table" then k.made = {} end
	return k.made
end

local function madeKey(guide, goal) return tostring(guide.id) .. ":" .. tostring(goal.spell or goal.item) end

---------------------------------------------------------------------------
-- Stretches
---------------------------------------------------------------------------

-- The guide's `craft … until` goals that apply, in order: { { s, g, goal, from } }; `from` the skill the stretch
-- starts at (the one before's end on the same skill line, else its section's start). Kept per evaluation.
local cache = {}
function KC.Stretches()
	local a = access()
	local G = a and a.guide()
	if not (G and G.steps) then return {} end
	local gen = a.generation()
	if cache.guide == G and cache.gen == gen then return cache.list end
	local list, last = {}, {}
	for s, step in ipairs(G.steps) do
		if a.stepApplies(step) then
			local sec = a.sectionOf(s)
			for g, goal in ipairs(step.goals or {}) do
				if goal.t == "craft" and type(goal.untilSkill) == "number" and a.goalApplies(goal) then
					local line = goal.skillLine or 0
					local from = last[line] or (sec and sec.from) or 1
					list[#list + 1] = { s = s, g = g, goal = goal, from = from }
					last[line] = goal.untilSkill
				end
			end
		end
	end
	cache.guide, cache.gen, cache.list = G, gen, list
	return list
end

-- The stretch the skill is in from step `index` on: the entry and its place in the list; nil without one.
function KC.Stretch(index, rank)
	local list = KC.Stretches()
	rank = rank or 0
	for k, st in ipairs(list) do
		if st.s >= (index or 1) and st.goal.untilSkill > rank then return st, k end
	end
	for k, st in ipairs(list) do
		if st.goal.untilSkill > rank then return st, k end
	end
	return nil
end

-- The skill the guide levels: line, rank (nil: not learned), cap.
local function skill()
	local b = Engine.SkillBar and Engine.SkillBar()
	if not b then return nil end
	local rank, cap = C().GetSkillRank(b.line)
	if type(rank) ~= "number" or rank <= 0 then rank = nil end
	return b, rank, cap
end

local function craftName(goal)
	return goal.item and itemName(goal.item, goal.itemName) or goal.spellName or ""
end

-- The colour a recipe is at skill k: "orange" | "yellow" | "green" | "grey"; green from (yellow + grey) / 2.
function KC.Colour(goal, k)
	local y, grey = goal.yellow, goal.grey
	if not (y and grey) then return nil end
	local green = floor((y + grey) / 2)
	if k < y then return "orange", green end
	if k < green then return "yellow", green end
	if k < grey then return "green", green end
	return "grey", green
end

-- While the game's trade skill window is open it knows the recipe's colour (Forever's numbers, a recipe that
-- turned grey early): "orange" | "yellow" | "green" | "grey", or nil when it is shut or does not list it.
local DIFFICULTY = { optimal = "orange", medium = "yellow", easy = "green", trivial = "grey" }
function KC.WindowColour(goal)
	if not (goal.spell and GetNumTradeSkills and GetTradeSkillInfo) then return nil end
	local spellName = (C_Spell and C_Spell.GetSpellName) or (GetSpellInfo and function(id) return (GetSpellInfo(id)) end)
	local ok, name = pcall(spellName or function() return nil end, goal.spell)
	if not ok or type(name) ~= "string" then return nil end
	local okN, n = pcall(GetNumTradeSkills)
	if not okN or type(n) ~= "number" then return nil end
	for i = 1, n do
		local okI, label, kind = pcall(GetTradeSkillInfo, i)
		if okI and label == name then return DIFFICULTY[kind] end
	end
	return nil
end

-- The guide's craft goal that makes `item` (a bolt of cloth), with reagents: the intermediate's recipe.
local function maker(G, item)
	for _, step in ipairs(G.steps) do
		for _, goal in ipairs(step.goals or {}) do
			if goal.t == "craft" and goal.item == item and type(goal.reagents) == "table" and goal.reagents[1] then return goal end
		end
	end
	return nil
end

-- Where a goal is done: its chosen candidate's NPC and map, else the goal's own.
local function placeOf(goal)
	local c = access().chosen(goal)
	local npc = c and (c.npcName or c.name) or goal.npcName
	local id = c and c.npc or goal.npc
	if id and ns.Names and ns.Names.Npc then npc = ns.Names.Npc(id) or npc end
	return npc, c and c.map or goal.map, id
end

-- The step's goals of types `types` (a set), as covers for a region; with `done`, its done goals too.
local function coverTypes(view, types, out, done)
	out = out or {}
	for gi, gv in ipairs(view and view.goals or {}) do
		if types[gv.t] or (done and gv.status == "done") then out[#out + 1] = gi end
	end
	return out
end

---------------------------------------------------------------------------
-- Materials per stretch
---------------------------------------------------------------------------

-- What the stretch `st` still takes from skill `rank`: { { item, need, have, parts, viaMade } } in the order the
-- recipe lists them, an intermediate (a reagent the guide crafts) counted as its own reagents, the intermediates
-- held counting toward them (10 bolts = 30 cloth). need: for every craft still to make.
function KC.StretchNeeds(st, rank)
	local a = access()
	local G = a.guide()
	local goal = st.goal
	local left = ceil(a.craftsFrom(goal, st.from, max(rank or 0, st.from)) - 0.001)
	local rows, at = {}, {}
	local function add(item, name, need, have, parts)
		local r = at[item]
		if not r then
			r = { item = item, name = name, need = 0, have = 0, parts = { bags = 0, bank = 0, mail = 0, coming = 0, made = 0 } }
			at[item] = r
			rows[#rows + 1] = r
			local total, p = Materials.Have(item)
			r.own = total
			r.parts.bags, r.parts.bank, r.parts.mail, r.parts.coming = p.bags, p.bank, p.mail, p.coming
		end
		r.need = r.need + need
		if parts then
			r.parts.made = r.parts.made + parts.made
			r.madeItem, r.madeName, r.madeCount = parts.item, parts.name, (r.madeCount or 0) + parts.count
		end
	end
	for _, rg in ipairs(goal.reagents or {}) do
		local per = rg.count or 1
		local need = left * per
		local mk = maker(G, rg.item)
		if mk then
			local held = Materials.Have(rg.item)
			local use = min(held, need)
			for _, raw in ipairs(mk.reagents) do
				local k = raw.count or 1
				add(raw.item, itemName(raw.item, raw.itemName), need * k, nil, { made = use * k, item = rg.item, name = itemName(rg.item, rg.itemName), count = use })
			end
		else
			add(rg.item, itemName(rg.item, rg.itemName), need)
		end
	end
	for _, r in ipairs(rows) do
		r.have = min(r.need, r.own + r.parts.made)
	end
	return rows, left
end

-- Engine.FarmMinutes (Materials.Way's "long"): the minutes farming what is still needed of `item` takes at its
-- gather goal's farm spot: the current stretch's need when it uses it, else the gather goal's. nil: not known.
local busy = false
function Engine.FarmMinutes(item)
	if busy then return nil end
	local a = access()
	local G = a and a.guide()
	if not (G and Materials) then return nil end
	local e = Materials.Index(G)[item]
	local gg = e and e.gather and e.gather[1] and e.gather[1].goal
	if not gg then return nil end
	busy = true
	local ok, minutes = pcall(function()
		local fv = a.farm(gg)
		if not (fv and fv.minutes) or fv.loop then return nil end
		local missing = a.needOf(gg) - bags(item)
		local b, rank = skill()
		local st = b and KC.Stretch(a.current(), rank)
		if st and missing > 0 then
			for _, r in ipairs(KC.StretchNeeds(st, rank)) do
				if r.item == item then return ceil(fv.minutes * max(0, r.need - r.have) / missing) end
			end
		end
		return fv.minutes
	end)
	busy = false
	return ok and minutes or nil
end

---------------------------------------------------------------------------
-- Profession models
---------------------------------------------------------------------------

local M = Engine.KindModels

-- The slim skill line: the skill and its cap; not learned yet: learned = false.
local function professionMeter(view)
	local b, rank, cap = skill()
	if not b then return nil end
	local name = KC.SkillName(b.line)
	local covers = coverTypes(view, { skill = true })
	if not rank then
		return { kind = "skill", name = name, nameKind = "skill", value = 0, max = 0, frac = 0, learned = false, skillLine = b.line, covers = covers }
	end
	cap = (type(cap) == "number" and cap > 0) and cap or max(rank, 1)
	return { kind = "skill", name = name, nameKind = "skill", value = rank, max = cap, frac = min(1, rank / cap), learned = true,
		skillLine = b.line, covers = covers }
end

M.meter = function(view, kind)
	if kind == "profession" then return professionMeter(view) end
	if kind == "reputation" then return KC.RepMeter(view) end
	return nil
end

-- The craft step's row: its `craft … until` goal ("Craft Woolen Cape until 100"), the recipe's colour now, about how
-- many crafts the skill still takes and the casts counted. Shown on the step that holds the goal, standing for it
-- and for what is done of the step; the step's other crafts (the bolts first) stay its own rows.
M.stretch = function(view, kind)
	if kind ~= "profession" then return nil end
	local b, rank = skill()
	if not b then return nil end
	local learned = rank ~= nil
	rank = rank or 0
	local st = KC.Stretch(view and view.index, rank)
	if not (st and view and st.s == view.index) then return nil end
	local a = access()
	local G = a.guide()
	local goal = st.goal
	local colour, green = KC.Colour(goal, rank)
	colour = learned and (KC.WindowColour(goal) or colour) or nil
	local left = goal.yellow and ceil(a.craftsFrom(goal, st.from, max(rank, st.from)) - 0.001) or nil
	local made = 0
	local rec = madeState()[madeKey(G, goal)]
	if type(rec) == "table" and type(rec.n) == "number" then made = rec.n end
	local gv = view.goals and view.goals[st.g]
	local covers = coverTypes(view, {}, { st.g }, true)
	return { item = goal.item, recipe = goal.spell, name = craftName(goal), quality = goal.item and quality(goal.item), colour = colour,
		yellow = goal.yellow, green = green, grey = goal.grey, made = made, left = left, moveOn = goal.untilSkill, rank = rank,
		learned = learned, spell = KC.SkillName(b.line), step = st.s, goalIndex = st.g, done = gv and gv.status == "done" or false,
		covers = covers }
end

-- The gathering verb of a material's `gather` goal: the profession it takes ("mine", "skin", "herb", "fish",
-- "disenchant"; another profession makes it: "make"), else "farm" (mobs drop it).
local GATHER_LINE = { [186] = "mine", [393] = "skin", [182] = "herb", [356] = "fish", [333] = "disenchant" }
local GATHER_SKILL = { mining = "mine", skinning = "skin", herbalism = "herb", fishing = "fish", enchanting = "disenchant" }
function KC.GatherVerb(goal)
	local w = type(goal.gather) == "table" and goal.gather or nil
	if not w then return "farm" end
	local v = (w.skillLine and GATHER_LINE[w.skillLine]) or (type(w.skill) == "string" and GATHER_SKILL[w.skill:lower()])
	if v then return v end
	if w.skill or w.skillLine then return "make" end
	return "farm"
end

-- A material goal of a profession step: a gather goal, an Auction House goal or a vendor's (not a quest's).
local function materialGoal(goal)
	if not goal.item or goal.quest then return false end
	return (goal.t == "collect" and goal.gather ~= nil) or goal.t == "auction" or goal.t == "buy"
end

-- A get step: per item of the step's material goals, "Get 42 Rough Stone" with the bags' count, and the ways the
-- item's goals in the step allow, each a choice: { way = "gather", verb, npc, map, loop, minutes (for the rest at
-- the chosen spot), rate (an hour there), levels (a disenchant's green items: { min, max } Requires Level),
-- safeFrom (farming loops with none safe at the character's level yet: the level the first opens at; no map) } |
-- { way = "buy", toGet (what the bags, bank and mail still lack), copper } | { way = "vendor", npc, map };
-- `current` the way the guide takes now (the goal that applies: the player's pick, else the guide's way). The
-- Auction House is no way for a Self-Found character.
M.get = function(view, kind)
	if kind ~= "profession" then return nil end
	local a = access()
	local G = a.guide()
	local step = view and G and G.steps[view.index]
	if not step then return nil end
	local list, byItem, covers = {}, {}, {}
	local selfFound = Materials.SelfFound()
	for gi, goal in ipairs(step.goals or {}) do
		local gv = view.goals and view.goals[gi]
		if gv and materialGoal(goal) then
			covers[#covers + 1] = gi
			local e = byItem[goal.item]
			if not e then
				e = { item = goal.item, name = itemName(goal.item, goal.itemName), quality = quality(goal.item), ways = {} }
				byItem[goal.item] = e
				list[#list + 1] = e
			end
			local applies = gv.status ~= "na"
			if applies and not e.goalIndex then
				e.goalIndex, e.status = gi, gv.status
				local p = type(gv.progress) == "table" and gv.progress or nil
				e.need = p and p.max or a.needOf(goal)
				e.have = min(p and p.cur or bags(goal.item), e.need)
			end
			local w
			if goal.t == "collect" then
				local npc, map = placeOf(goal)
				w = { way = "gather", verb = KC.GatherVerb(goal), npc = npc, map = map }
				local fv = a.farm(goal)
				local missing = a.needOf(goal) - bags(goal.item)
				if fv and fv.safeFrom then
					-- No loop safe at the character's level yet: no place to lead to, and the level one opens at.
					w.map, w.safeFrom = nil, fv.safeFrom
				elseif fv and fv.minutes and fv.minutes > 0 and missing > 0 then
					w.minutes, w.loop = fv.minutes, fv.loop or nil
					w.rate = max(1, floor(missing * 60 / fv.minutes + 0.5))
				end
				local gw = type(goal.gather) == "table" and goal.gather or nil
				if w.verb == "disenchant" and gw and gw.min and gw.max then w.levels = { gw.min, gw.max } end
			elseif goal.t == "auction" then
				if not selfFound then
					local toGet = max(0, a.needOf(goal) - Materials.Have(goal.item))
					w = { way = "buy", toGet = toGet }
					if toGet > 0 then w.copper = Materials.Price(goal.item, toGet) end
				end
			else
				local npc, map = placeOf(goal)
				w = { way = "vendor", npc = npc, map = map }
			end
			if w then
				w.goalIndex, w.current = gi, applies
				e.ways[#e.ways + 1] = w
			end
		end
	end
	if #list == 0 then return nil end
	for _, e in ipairs(list) do
		e.need = e.need or 0
		e.have = e.have or 0
		e.done = e.status == "done"
	end
	return { items = list, covers = covers }
end

-- The shopping list: the materials of the section (the bracket) the step is in, each with what the character holds
-- (bags, bank, mail) of what the section's goals ask, and the way the guide takes for it ("gather" | "buy" |
-- "vendor"); `buy`: the items set to Buy still to get, for "Buy the whole list".
M.shopping = function(view, kind)
	if kind ~= "profession" then return nil end
	local a = access()
	local G = a.guide()
	if not (G and view) then return nil end
	local sec = a.sectionOf(view.index)
	local rows, at = {}, {}
	for s, step in ipairs(G.steps) do
		if a.sectionOf(s) == sec and a.stepApplies(step) then
			for _, goal in ipairs(step.goals or {}) do
				if materialGoal(goal) and a.goalApplies(goal) then
					local r = at[goal.item]
					if not r then
						r = { item = goal.item, name = itemName(goal.item, goal.itemName), quality = quality(goal.item), need = 0, way = "vendor" }
						at[goal.item] = r
						rows[#rows + 1] = r
					end
					r.need = max(r.need, a.needOf(goal))
					local way = a.materialWay(goal)
					if way then r.way = way end
				end
			end
		end
	end
	if #rows == 0 then return nil end
	local buy, met = {}, 0
	for _, r in ipairs(rows) do
		r.have = min(r.need, (Materials.Have(r.item)))
		r.toGet = r.need - r.have
		if r.toGet == 0 then met = met + 1 end
		if r.way == "buy" and r.toGet > 0 then buy[#buy + 1] = { item = r.item, name = r.name, count = r.toGet } end
	end
	return { rows = rows, met = met, buy = buy }
end

-- The trade skill window's colours come and go with it.
if ns.RegisterEvent then
	for _, e in ipairs({ "TRADE_SKILL_SHOW", "TRADE_SKILL_UPDATE", "TRADE_SKILL_CLOSE" }) do
		ns.RegisterEvent(e, function() ns.Fire("KIND_CRAFT_MADE") end)
	end
end

-- The casts of the stretch's recipe, counted per character (stretch.made).
if ns.RegisterEvent then
	ns.RegisterEvent("UNIT_SPELLCAST_SUCCEEDED", function(_, unit, _, spellID)
		if unit ~= "player" or type(spellID) ~= "number" then return end
		local a = access()
		local G = a and a.guide()
		if not G then return end
		for _, st in ipairs(KC.Stretches()) do
			if st.goal.spell == spellID then
				local made = madeState()
				local key = madeKey(G, st.goal)
				local rec = made[key]
				if type(rec) ~= "table" then
					rec = { n = 0 }
					made[key] = rec
				end
				rec.n = rec.n + 1
				ns.Fire("KIND_CRAFT_MADE", spellID)
				return
			end
		end
	end, "player")
end

---------------------------------------------------------------------------
-- Reputation models
---------------------------------------------------------------------------

-- The faction the step in view raises: its `rep` goal, else the next one ahead, else the guide's first.
local function repGoal(view)
	local a = access()
	local G = a.guide()
	if not (G and G.steps) then return nil end
	local from = view and view.index or 1
	for pass = 1, 2 do
		for s = pass == 1 and from or 1, #G.steps do
			local step = G.steps[s]
			if a.stepApplies(step) then
				for g, goal in ipairs(step.goals or {}) do
					if goal.t == "rep" and goal.faction and a.goalApplies(goal) then return goal, s, g end
				end
			end
		end
	end
	return nil
end

-- A quest's reputation for `faction` from the guide's compiled rewards or the Codex: a number, or nil (never a guess).
local function repValue(goal, quest, faction)
	local r = goal and type(goal.rewards) == "table" and goal.rewards.rep
	if type(r) ~= "table" and ns.Codex and ns.Codex.Quest then
		local rec = ns.Codex.Quest(quest)
		r = rec and rec.rewards and type(rec.rewards) == "table" and rec.rewards.rep or (rec and rec.rep)
	end
	if type(r) ~= "table" then return nil end
	for _, e in ipairs(r) do
		if type(e) == "table" and (e.faction == faction or not faction) and type(e.value) == "number" then return e.value end
	end
	return nil
end

-- The step's turn-in: its first turn-in goal whose quest takes items (the step's collect goals, else the
-- quest's item objectives). -> the model's fields and the goal indexes it stands for.
local function stepTurnin(view, faction)
	local a = access()
	local G = a.guide()
	local step = view and G.steps[view.index]
	if not step then return nil end
	for g, goal in ipairs(step.goals or {}) do
		if goal.t == "turnin" and goal.quest and a.goalApplies(goal) then
			local items, covers = {}, { g }
			for gi, o in ipairs(step.goals) do
				if o.t == "collect" and o.item and (not o.quest or o.quest == goal.quest) then
					items[#items + 1] = { item = o.item, count = o.count or 1, name = itemName(o.item, o.itemName), goal = o }
					covers[#covers + 1] = gi
				elseif o.t == "accept" and o.quest == goal.quest then
					covers[#covers + 1] = gi
				end
			end
			local rec = ns.Codex and ns.Codex.Quest and ns.Codex.Quest(goal.quest)
			if #items == 0 and rec then
				for _, ob in ipairs(rec.objectives or {}) do
					if ob.type == "item" and ob.id then items[#items + 1] = { item = ob.id, count = ob.count or 1, name = itemName(ob.id, ob.text) } end
				end
			end
			if #items > 0 then
				local ready
				for _, it in ipairs(items) do
					local n = floor(bags(it.item) / it.count)
					ready = ready and min(ready, n) or n
				end
				local npc, map = placeOf(goal)
				return { quest = goal.quest, title = goal.title or (rec and rec.title) or ("#" .. goal.quest), repeatable = goal.repeatable or (rec and rec.repeatable) or nil,
					items = items, rep = repValue(goal, goal.quest, faction), npc = npc, map = map, ready = ready or 0, covers = covers, goalIndex = g, step = view.index }
			end
		end
	end
	return nil
end

local STANDING_TOP = 8

function KC.RepMeter(view)
	local goal = repGoal(view)
	if not goal then return nil end
	local standing, value, lo, hi, name = C().GetFactionStanding(goal.faction)
	name = name or goal.factionName or ""
	local covers = coverTypes(view, { rep = true })
	if not standing then
		return { kind = "rep", name = name, nameKind = "faction", value = 0, max = 0, frac = 0, seg = { 0, 0 }, ticks = {}, line = {}, faction = goal.faction,
			known = false, covers = covers }
	end
	local span = max(1, hi - lo)
	local into = value - lo
	local t = stepTurnin(view, goal.faction)
	local gain = t and t.rep and t.ready > 0 and t.rep * t.ready or 0
	local toNext = max(0, hi - value)
	local reached = type(goal.standing) == "number" and standing >= goal.standing
	local line = { toNext = toNext, next = standing < STANDING_TOP and ns.StandingName(standing + 1) or nil,
		turnins = t and t.rep and t.rep > 0 and toNext > 0 and ceil(toNext / t.rep) or nil, target = ns.StandingName(goal.standing), reached = reached }
	return { kind = "rep", name = name, nameKind = "faction", value = into, max = span, rank = ns.StandingName(standing), standing = standing,
		frac = min(1, into / span), seg = { min(1, into / span), min(1, (into + gain) / span) }, ticks = {}, line = line, faction = goal.faction,
		known = true, done = standing >= STANDING_TOP, covers = covers }
end

M.turnin = function(view, kind)
	if kind ~= "reputation" then return nil end
	local goal = repGoal(view)
	local t = stepTurnin(view, goal and goal.faction)
	if not t then return nil end
	-- The next turn-in's shortfall: the first item the bags lack.
	for _, it in ipairs(t.items) do
		local short = it.count - (bags(it.item) % it.count)
		if t.ready == 0 then
			short = it.count - min(it.count, bags(it.item))
			if short > 0 then
				t.short = { item = it.item, name = it.name, count = short }
				break
			end
		end
	end
	return t
end

-- "More reputation": the step's own other quests that pay this faction (beside the turn-in card: each with its
-- progress; their goal rows, and with them the step's header, leave the card), then the quests of the steps
-- ahead. `covers`: the step's goals the rows stand for.
M.more = function(view, kind)
	if kind ~= "reputation" then return nil end
	local goal = repGoal(view)
	if not goal then return nil end
	local a = access()
	local G = a.guide()
	local here = view and view.index or 1
	local out, seen, covers = {}, {}, {}
	local function finish()
		if #out == 0 then return nil end
		out.covers = covers
		return out
	end
	local step = G.steps[here]
	local t = step and stepTurnin(view, goal.faction)
	if t then
		local taken = {}
		for _, gi in ipairs(t.covers) do taken[gi] = true end
		for _, gi in ipairs(coverTypes(view, { rep = true })) do taken[gi] = true end
		for gi, o in ipairs(step.goals or {}) do
			if #out < 4 and not taken[gi] and o.quest and not seen[o.quest] and a.goalApplies(o) then
				-- Every goal of the quest in this step (its accept, its objectives, its turn-in): the reputation is
				-- on whichever the guide or the Codex gives it to.
				local mine, rep, progress, open = {}, nil, nil, false
				for gj, p in ipairs(step.goals) do
					if p.quest == o.quest and not taken[gj] and a.goalApplies(p) then
						mine[#mine + 1] = gj
						rep = rep or repValue(p, o.quest, goal.faction)
						local gv = view.goals and view.goals[gj]
						local st = gv and gv.status
						if st ~= "done" and st ~= "skipped" and st ~= "na" then open = true end
						if gv and type(gv.progress) == "table" and p.t ~= "accept" and p.t ~= "turnin" and not progress then
							progress = { cur = gv.progress.cur, max = gv.progress.max }
						end
					end
				end
				if rep and open then
					seen[o.quest] = true
					local rec = ns.Codex and ns.Codex.Quest and ns.Codex.Quest(o.quest)
					out[#out + 1] = { quest = o.quest, title = o.title or (rec and rec.title) or ("#" .. o.quest), rep = rep,
						once = not (o.repeatable or (rec and rec.repeatable)), progress = progress, current = true, step = here, goalIndex = gi }
					for _, gj in ipairs(mine) do covers[#covers + 1] = gj end
				end
			end
		end
	end
	for s = here + 1, #G.steps do
		local ahead = G.steps[s]
		if a.stepApplies(ahead) then
			for g, o in ipairs(ahead.goals or {}) do
				if o.t == "turnin" and o.quest and not seen[o.quest] and a.goalApplies(o) and not a.goalDone(s, g, o) then
					seen[o.quest] = true
					local rec = ns.Codex and ns.Codex.Quest and ns.Codex.Quest(o.quest)
					local from = rec and rec.repFaction == goal.faction and rec.repStanding and ns.StandingName(rec.repStanding) or nil
					local standing = C().GetFactionStanding(goal.faction)
					if from and standing and rec.repStanding <= standing then from = nil end
					out[#out + 1] = { quest = o.quest, title = o.title or (rec and rec.title) or ("#" .. o.quest), rep = repValue(o, o.quest, goal.faction),
						once = not (o.repeatable or (rec and rec.repeatable)), from = from, step = s }
					if #out >= 4 then return finish() end
				end
			end
		end
	end
	return finish()
end

return KC
