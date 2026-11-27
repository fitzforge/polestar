-- The profession and reputation kinds' region models (docs/ARCHITECTURE.md, "Guide kind regions"): pure data for
-- the guide window's regions (UI/GuideFrameKindCraft.lua), the tests and the preview, through
-- Engine.KindModel(region, view). Built from the Engine's own view of the guide (Engine.KindAccess), the client's
-- skill and standing, and the materials' counts, ways and prices (Core/Materials.lua).
--
-- Profession: "meter" (the skill, the stretch to its move-on, the next trainer rank), "trainer" (that rank or the
-- recipes the step learns), "stretch" (the `craft … until` recipe levelled now: its colour now, crafts made of
-- about how many, how many the bags make now), "supplies" (each material still needed to the move-on, counted from
-- bags, bank, mail and the intermediates already made, with its way and the Buy / Farm split), "buyList" (what is
-- set to Buy). Reputation: "meter" (the standing), "turnin" (the step's turn-in), "supplies" (its items), "more"
-- (the guide's other quests for the faction).
--
-- The stretch: the first `craft … until` goal from the step in view on that the skill is under. Its colours
-- (Classic's): orange below `yellow`, yellow below green ((yellow + grey) / 2), green below `grey`, grey from
-- there. Crafts left (Engine's craftsFrom, the skill-up chance) from the skill now to the move-on, whatever made
-- the points so far; made = the casts of the recipe counted (UNIT_SPELLCAST_SUCCEEDED, per character), never a
-- guess from the skill (points since the stretch's start may come from other recipes or trainers).
--
-- Engine.FarmMinutes(item): the minutes farming what is still needed takes, for Materials.Way's "long" (Mix buys
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

-- The next profession rank the guide trains from step `index` on, above `cap`: { s, g, goal, cap, level, rank }.
local function nextTrain(index, cap)
	local a = access()
	local G = a.guide()
	for s = index or 1, #G.steps do
		local step = G.steps[s]
		if a.stepApplies(step) then
			for g, goal in ipairs(step.goals or {}) do
				local top = goal.t == "train" and (goal.rankMax or a.rankCap(goal))
				if top and top > (cap or 0) and a.goalApplies(goal) and not a.goalDone(s, g, goal) then
					local r = tonumber(goal.rank)
					return { s = s, g = g, goal = goal, cap = top, rank = r, level = (r and r >= 2) and max(1, top - 100) or 0 }
				end
			end
		end
	end
	return nil
end

-- A profession rank's title, a literal key each (the translations' check finds only those).
local function rankTitle(rank)
	local L = ns.L
	if rank == 1 then return L["Apprentice"] end
	if rank == 2 then return L["Journeyman"] end
	if rank == 3 then return L["Expert"] end
	if rank == 4 then return L["Artisan"] end
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

-- The step's goals of types `types` (a set), as covers for a region.
local function coverTypes(view, types, out)
	out = out or {}
	for gi, gv in ipairs(view and view.goals or {}) do
		if types[gv.t] then out[#out + 1] = gi end
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

-- Where goal `goal` sits in the guide: step, goal index.
local function locate(goal)
	local G = access().guide()
	for s, step in ipairs(G and G.steps or {}) do
		for g, o in ipairs(step.goals or {}) do
			if o == goal then return s, g end
		end
	end
	return nil
end
KC.Locate = locate

-- The split's Buy and Farm columns for `count` of `item`, gather goal `gg` (nil: no farm).
local function split(item, count, gg)
	local buy = false
	if not Materials.SelfFound() then
		local copper, info = Materials.Price(item, count)
		buy = { count = count, copper = copper, each = info and info.each, age = info and info.age, source = info and info.source,
			short = info and info.short }
	end
	local farm = false
	if gg then
		local a = access()
		local fv = a.farm(gg)
		if fv and not fv.loop then
			local missing = max(1, a.needOf(gg) - bags(item))
			local k = count / missing
			local npc, map = placeOf(gg)
			local c = a.chosen(gg)
			local s, gi = locate(gg)
			farm = { count = count, minutes = fv.minutes and max(1, ceil(fv.minutes * k)), kills = fv.kills and max(1, ceil(fv.kills * k)),
				npc = npc, map = map, lvl = c and c.lvl, second = fv.second, above = fv.above, step = s, index = gi }
		elseif gg.candidates then
			local npc, map = placeOf(gg)
			local s, gi = locate(gg)
			farm = { count = count, npc = npc, map = map, step = s, index = gi }
		end
	end
	return buy, farm
end

-- A material's way in guide G: "buy" | "gather" | "vendor" | "make", whether the player may choose, the reason
-- (Materials.Way's) and its gather goal.
local function wayOf(G, item, player)
	local e = Materials.Index(G)[item]
	local gg = e and e.gather and e.gather[1] and e.gather[1].goal
	local canBuy = e and e.auction and e.auction[1] ~= nil
	if gg and canBuy then
		local way, why = Materials.Way(G, item, player, function() return Engine.FarmMinutes(item) end)
		return way, true, why, gg
	end
	if canBuy then return "buy", false, Materials.SelfFound() and "selfFound" or "noGather", nil end
	for _, step in ipairs(G.steps) do
		for _, goal in ipairs(step.goals or {}) do
			if goal.t == "buy" and goal.item == item then return "vendor", false, nil, nil end
		end
	end
	if maker(G, item) then return "make", false, nil, nil end
	-- A collect goal of the guide with farm spots: farmed; a reputation guide's item.
	for _, step in ipairs(G.steps) do
		for _, goal in ipairs(step.goals or {}) do
			if goal.t == "collect" and goal.item == item and not goal.quest then return "gather", false, nil, goal.candidates and goal or nil end
		end
	end
	return "gather", false, nil, nil
end

-- The verdict over a split: "selfFound" | "pick" | "buy" | "farm" and whether Mix bought it for a long farm.
local function verdict(G, item, way, why)
	if why == "selfFound" then return "selfFound", false end
	local _, _, pick = Materials.Mode(G.id, item)
	if pick or why == "picked" then return "pick", false end
	return way == "buy" and "buy" or "farm", why == "long"
end

-- Rows for the supplies model from needs { { item, name, need, have, parts } }.
local function supplyRows(G, needs)
	local a = access()
	local player = a.player()
	local rows, focus = {}, nil
	for _, n in ipairs(needs) do
		local way, choosable, why, gg = wayOf(G, n.item, player)
		local row = { item = n.item, name = n.name, quality = quality(n.item), have = n.have, need = n.need, parts = n.parts,
			madeItem = n.madeItem, madeName = n.madeName, madeCount = n.madeCount, way = way, choosable = choosable, reason = why }
		-- Cloth or meat the character still loots on the way (its mobs' levels not passed yet) counts too.
		local w = gg and type(gg.gather) == "table" and gg.gather
		row.routeCloth = w and not (w.skill or w.skillLine) and w.max and player and (player.level or 0) <= w.max and way == "buy" or nil
		local toGet = max(0, n.need - n.have)
		row.toGet = toGet
		if toGet > 0 and (choosable or way == "buy" or way == "gather") then
			local b, f = split(n.item, toGet, gg)
			local v, long = verdict(G, n.item, way, why)
			if way == "buy" and not choosable then f = false end
			row.split = { buy = b, farm = f, verdict = v, long = long }
			if not focus and choosable then focus = #rows + 1 end
		end
		rows[#rows + 1] = row
	end
	return rows, focus
end

local function buyListOf(rows)
	local count, copper, known = 0, 0, true
	for _, r in ipairs(rows) do
		if r.way == "buy" and r.toGet > 0 and r.split and r.split.buy then
			count = count + r.toGet
			if r.split.buy.copper then copper = copper + r.split.buy.copper else known = false end
		end
	end
	if count == 0 then return nil end
	return { count = count, copper = copper > 0 and copper or nil, partial = not known or nil }
end

---------------------------------------------------------------------------
-- Profession models
---------------------------------------------------------------------------

local M = Engine.KindModels

local function professionMeter(view)
	local b, rank, cap = skill()
	if not b then return nil end
	local name = KC.SkillName(b.line)
	local covers = coverTypes(view, { skill = true })
	if not rank then
		return { kind = "skill", name = name, nameKind = "skill", value = 0, max = cap or 0, frac = 0, seg = { 0, 0 }, ticks = {}, line = {},
			learned = false, skillLine = b.line, covers = covers }
	end
	cap = (type(cap) == "number" and cap > 0) and cap or max(rank, 1)
	local st, k = KC.Stretch(view and view.index, rank)
	local moveOn = st and st.goal.untilSkill
	local tr = nextTrain(view and view.index or 1, cap)
	local ticks = {}
	if moveOn and moveOn < cap then ticks[#ticks + 1] = { at = moveOn, what = "moveOn" } end
	if tr and tr.level > rank and tr.level <= cap and tr.level ~= moveOn then ticks[#ticks + 1] = { at = tr.level, what = "train" } end
	local line = {}
	if st then
		line[1] = { name = craftName(st.goal), to = moveOn, item = st.goal.item }
		local nx = KC.Stretches()[k + 1]
		if nx then line[2] = { name = craftName(nx.goal), to = nx.goal.untilSkill, item = nx.goal.item } end
	end
	return { kind = "skill", name = name, nameKind = "skill", value = rank, max = cap, frac = min(1, rank / cap),
		seg = { min(1, rank / cap), moveOn and min(1, moveOn / cap) or min(1, rank / cap) }, ticks = ticks, line = line, learned = true,
		skillLine = b.line, covers = covers }
end

M.meter = function(view, kind)
	if kind == "profession" then return professionMeter(view) end
	if kind == "reputation" then return KC.RepMeter(view) end
	return nil
end

M.trainer = function(view, kind)
	if kind ~= "profession" then return nil end
	local b, rank, cap = skill()
	if not b then return nil end
	local a = access()
	local G = a.guide()
	-- Recipes the step in view learns: due now.
	local step = view and G.steps[view.index]
	local learns, lg, lgi = {}, nil, nil
	for g, goal in ipairs(step and step.goals or {}) do
		if goal.t == "learn" and a.goalApplies(goal) and not a.goalDone(view.index, g, goal) then
			learns[#learns + 1] = goal.spellName or goal.itemName or ""
			if not lg then lg, lgi = goal, g end
		end
	end
	local covers = coverTypes(view, { train = true, learn = true, level = true })
	if lg then
		local npc, map = placeOf(lg)
		return { title = table.concat(learns, ", "), learn = true, level = rank or 0, npc = npc, map = map, due = true, toGo = 0,
			step = view.index, goalIndex = lgi, covers = covers }
	end
	local tr = nextTrain(view and view.index or 1, rank and cap or 0)
	if not tr then return nil end
	local npc, map = placeOf(tr.goal)
	local due = not rank or (rank or 0) >= tr.level or (rank and cap and rank >= cap) or false
	local gate = b.gate
	return { title = rankTitle(tr.rank) or tostring(tr.goal.rank or ""), rank = tr.rank, level = tr.level,
		npc = npc, map = map, due = due, toGo = max(0, tr.level - (rank or 0)), step = tr.s, goalIndex = tr.g,
		needsLevel = gate and gate.step == tr.s and gate.level or nil, covers = covers }
end

M.stretch = function(view, kind)
	if kind ~= "profession" then return nil end
	local b, rank = skill()
	if not (b and rank) then return nil end
	local st = KC.Stretch(view and view.index, rank)
	if not st then return nil end
	local a = access()
	local G = a.guide()
	local goal = st.goal
	local colour, green = KC.Colour(goal, rank)
	colour = KC.WindowColour(goal) or colour
	local expected = goal.yellow and a.craftsFrom(goal, st.from, st.from) or nil
	local left = goal.yellow and ceil(a.craftsFrom(goal, st.from, max(rank, st.from)) - 0.001) or nil
	local made = 0
	local rec = madeState()[madeKey(G, goal)]
	if type(rec) == "table" and type(rec.n) == "number" then made = rec.n end
	local canMake
	local reagents = {}
	for _, r in ipairs(goal.reagents or {}) do
		reagents[#reagents + 1] = { item = r.item, count = r.count or 1, name = itemName(r.item, r.itemName) }
		local n = floor(bags(r.item) / (r.count or 1))
		canMake = canMake and min(canMake, n) or n
	end
	-- An intermediate the bags lack for one craft: make it first.
	local makeFirst
	for _, r in ipairs(goal.reagents or {}) do
		local mk = maker(G, r.item)
		if mk and bags(r.item) < (r.count or 1) then
			makeFirst = { item = r.item, name = itemName(r.item, r.itemName), count = (r.count or 1) - bags(r.item) }
			break
		end
	end
	local covers = coverTypes(view, { craft = true })
	return { item = goal.item, recipe = goal.spell, name = craftName(goal), quality = goal.item and quality(goal.item), colour = colour,
		yellow = goal.yellow, green = green, grey = goal.grey, reagents = reagents, made = made, left = left,
		expected = expected and floor(expected + 0.5) or nil, moveOn = goal.untilSkill, from = st.from, rank = rank,
		canMake = canMake or 0, makeFirst = makeFirst, spell = KC.SkillName(b.line), step = st.s, covers = covers }
end

local function professionSupplies(view)
	local b, rank = skill()
	if not (b and rank) then return nil end
	local st = KC.Stretch(view and view.index, rank)
	local a = access()
	local G = a.guide()
	local needs = st and KC.StretchNeeds(st, rank) or {}
	-- The step's own materials (Get Silk Cloth) that the stretch does not use yet: their own counts.
	local step = view and G.steps[view.index]
	local seen = {}
	for _, n in ipairs(needs) do seen[n.item] = true end
	for _, goal in ipairs(step and step.goals or {}) do
		if (goal.t == "collect" or goal.t == "auction" or goal.t == "buy") and goal.item and not goal.quest and not seen[goal.item] then
			seen[goal.item] = true
			local total, p = Materials.Have(goal.item)
			local need = a.needOf(goal)
			needs[#needs + 1] = { item = goal.item, name = itemName(goal.item, goal.itemName), need = need, have = min(need, total),
				parts = { bags = p.bags, bank = p.bank, mail = p.mail, coming = p.coming, made = 0 } }
		end
	end
	if #needs == 0 then return nil end
	local rows, focus = supplyRows(G, needs)
	local mode = Materials.Mode(G.id)
	local covers = {}
	for gi, gv in ipairs(view and view.goals or {}) do
		if (gv.t == "collect" or gv.t == "auction" or gv.t == "buy") and seen[gv.item] then covers[#covers + 1] = gi end
	end
	return { title = st and st.goal.untilSkill, titleKind = "skill", way = mode == "gather" and "gather" or mode, rows = rows, focus = focus,
		buyList = buyListOf(rows), selfFound = Materials.SelfFound(), choosable = Materials.Choosable(G), covers = covers }
end

M.supplies = function(view, kind)
	-- A standing at its end needs no more items.
	if kind == "reputation" then
		local meter = KC.RepMeter(view)
		if meter and meter.done then return nil end
	end
	if kind == "profession" then return professionSupplies(view) end
	if kind == "reputation" then return KC.RepSupplies(view) end
	return nil
end

M.buyList = function(view, kind)
	if kind ~= "profession" then return nil end
	local s = M.supplies(view, kind)
	return s and s.buyList or nil
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

function KC.RepSupplies(view)
	local goal = repGoal(view)
	local t = stepTurnin(view, goal and goal.faction)
	if not t then return nil end
	local a = access()
	local G = a.guide()
	local meter = KC.RepMeter(view)
	-- Enough for the next standing when a turn-in's reputation is known, else the step's own counts.
	local turnins = meter and meter.line and meter.line.turnins
	local needs = {}
	for _, it in ipairs(t.items) do
		local need = turnins and turnins * it.count or (it.goal and a.needOf(it.goal)) or it.count
		local total, p = Materials.Have(it.item)
		needs[#needs + 1] = { item = it.item, name = it.name, need = need, have = min(need, total),
			parts = { bags = p.bags, bank = p.bank, mail = p.mail, coming = p.coming, made = 0 } }
	end
	local rows, focus = supplyRows(G, needs)
	-- A reputation guide's item has a farm and, unless Self-Found, an Auction House: the player picks the way.
	for i, r in ipairs(rows) do
		if r.split and r.split.farm and r.split.buy and not r.choosable then
			r.choosable = true
			local _, _, pick = Materials.Mode(G.id, r.item)
			r.way = pick or "gather"
			r.split.verdict = pick and "pick" or "farm"
			focus = focus or i
		end
	end
	local mode = Materials.Mode(G.id)
	return { title = meter and meter.line and (meter.line.reached and meter.line.next or meter.line.target), titleKind = "standing",
		items = t.items, way = mode, rows = rows, focus = focus, buyList = buyListOf(rows), selfFound = Materials.SelfFound(), covers = {} }
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
