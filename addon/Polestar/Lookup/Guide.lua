-- Polestar.Lookup guides: open the curated guide that collects an item, or
-- build one on the spot from a ranked source, in the same guide table shape
-- the Engine runs for compiled guides (docs/ARCHITECTURE.md, "Guide data").
--
--   Lookup.CuratedGuide(kind, id) -> guideId | nil
--       a registered guide whose `collects` holds the item (kind "spell": the
--       spell's item, else a guide with the spell's name among its
--       `keywords`, as the class mount guides have); one that fits the
--       character first
--   Lookup.BuildGuide(kind, id, ranked) -> def | nil, reason
--       ranked: a row of Lookup.Sources(kind, id), its index, or nil (best)
--   Lookup.Guide(kind, id, index) -> guideId | nil, reason
--       curated when one collects it (index nil), else built from source
--       `index` (default: the best available guideable one), registered
--       unsaved (pack "lookup", category "Lookup", id "lookup/<kind>/<id>")
--       and opened in a tab. A mount (Lookup.IsMount) without a curated guide
--       is not built from its best source (index nil): nil, "mount"
--   Lookup.Show(query, kind, id)   -- fires SHOW_LOOKUP(query, kind, id) for the UI
--   Lookup.RegisterPlanner(kind, build)
--       another module's guide kind: build(id) -> def | nil, reason, where def
--       holds title and steps (the rest as above); Lookup.BuildGuide and
--       Lookup.Guide then build `kind` with it, whatever lookup.enabled says
--       (the module gates itself), and its saved tabs come back after /reload.
--       Dungeons' "pickup", "handin" and "attune" kinds are three (Dungeons/Pickup.lua, Handin.lua, Attune.lua).
--   Lookup.QuestChain(questId, player) -> { quest, ... }
--       the quest after all its open prerequisites, in the order they are done
--   Lookup.QuestStep(quest, from, opts) -> step   -- accept, objectives, turn-in
--       opts.inside(kind, id): where an NPC or object without a known spawn
--       is; with it the step is always whole (see questStep)
--   Lookup.AcceptPre(goal, quest) -> goal
--       an accept goal with the Codex quest's prerequisites as a compiled
--       guide's accept carries them (all of `pre` as preAll, one of `preAny`
--       as pre, without those of another faction, race or class while one
--       is left; their titles as preTitles), so the Engine tells "Requires X
--       first" when the route no longer brings X, and a giver's window that
--       does not list the quest for that reason passes it (#1406: Gryan
--       Stoutmantle's The Defias Brotherhood after The Defias Traitor's step
--       was skipped)
--   Lookup.SpawnZ(kind, id, point) -> z | nil
--       the height of NPC or object `id`'s Codex spawn at point { map, x, y, f }
--       (kind "npc" | "object"): its spawn on that map and frame nearest the
--       point, within SPAWN_Z_YARDS. A goal at an NPC or object carries its
--       spawn's height as `z`, so the arrow walks to its floor (#1024: Apothecary
--       Zamah in the Pools of Vision, under Spirit Rise)
--
-- Generated guides are not saved. A tab holding one survives /reload: at
-- ADDON_LOADED (before the Engine reopens saved tabs at login) every saved
-- "lookup/..." tab id is rebuilt from the Codex and registered again.
--
-- Alt-click on an item link, bag item or loot item (Hooks.ItemClick) opens
-- its guide, or the Lookup window when no source can be guided (a mount
-- without a curated guide among them).

local ADDON, ns = ...

local Lookup = ns.Lookup
local L = ns.L

local type, pairs, ipairs, tostring, tonumber = type, pairs, ipairs, tostring, tonumber
local lower, find, format, concat = string.lower, string.find, string.format, table.concat

local planners = {} -- kind -> build(id): guide kinds other modules build

local ITEM_KINDS = Lookup.ITEM_KINDS
local PREFIX = "lookup/"
local INSIDE_CHANCE = 10 -- percent: an inside source rarer than this is no place to send the player (itemSpot)

local function Codex() return ns.Codex end

local function enabled() return ns.Get("lookup.enabled") and true or false end

function Lookup.GuideId(kind, id)
	return PREFIX .. tostring(kind) .. "/" .. tostring(id)
end

function Lookup.RegisterPlanner(kind, build)
	if type(kind) == "string" and kind:match("^%a+$") and type(build) == "function" then planners[kind] = build end
end

-- "lookup/<kind>/<id>" -> kind, id (number when numeric) | nil
function Lookup.ParseGuideId(guideId)
	if type(guideId) ~= "string" then return nil end
	local kind, id = guideId:match("^lookup/([%a]+)/(.+)$")
	if not kind then return nil end
	return kind, tonumber(id) or id
end

function Lookup.Show(query, kind, id)
	if not enabled() then
		ns.Print(L["Lookup is turned off (Options > Discovery > Lookup)."])
		return
	end
	ns.Fire("SHOW_LOOKUP", query, kind, id)
end

---------------------------------------------------------------------------
-- Curated guides
---------------------------------------------------------------------------

local function holds(list, value)
	if type(list) ~= "table" then return false end
	for i = 1, #list do
		if list[i] == value then return true end
	end
	return false
end

local function keywordMatch(list, name)
	if type(list) ~= "table" or type(name) ~= "string" or name == "" then return false end
	local want = lower(name)
	for i = 1, #list do
		local k = list[i]
		if type(k) == "string" and find(lower(k), want, 1, true) then return true end
	end
	return false
end

function Lookup.CuratedGuide(kind, id)
	local itemId, spellName
	if ITEM_KINDS[kind] then
		itemId = tonumber(id)
	elseif kind == "spell" then
		local C = Codex()
		local spell = C and C.Spell(id)
		if not spell then return nil end
		itemId, spellName = spell.item, spell.name
	else
		return nil
	end
	local player = ns.Compat.GetPlayerInfo()
	-- The suggestion source's guides first, then ours: one for this character,
	-- else one for anyone.
	local source = ns.Guides.SuggestSource()
	local from = source == "guides" and { "guides" } or { source, "guides" }
	local list = ns.Guides.List()
	local fallback
	for _, pack in ipairs(from) do
		for _, h in ipairs(list) do
			if h.pack == pack and type(h.id) == "string" and h.id:sub(1, #PREFIX) ~= PREFIX
				and ((itemId and holds(h.collects, itemId)) or (spellName and keywordMatch(h.keywords, spellName))) then
				if ns.Guides.GuideMatches(h, player) then return h.id end
				fallback = fallback or h.id
			end
		end
	end
	return fallback
end

---------------------------------------------------------------------------
-- Building
---------------------------------------------------------------------------

-- A guide goal's frame: "e" (Era) or nothing (live). The Codex marks live
-- points "l" (#785: the Alliance Drakefire Amulet's guide failed to build).
local function frame(f)
	return f == "e" and "e" or nil
end

-- A goal at point p: its map, x, y, f, and z, the height of the spawn p is
-- (Codex spawns carry it, #1024).
local function at(goal, p)
	if p and p.map and p.x and p.y then
		goal.map, goal.x, goal.y, goal.f, goal.z = p.map, p.x, p.y, frame(p.f), p.z
	end
	return goal
end

local SPAWN_Z_YARDS = 15

function Lookup.SpawnZ(kind, id, p)
	local C = Codex()
	if not (C and p and p.map and p.x and p.y) then return nil end
	local rec = (kind == "npc" and C.Npc(id)) or (kind == "object" and C.Object(id)) or nil
	if not (rec and rec.spawns) then return nil end
	local toWorld, f = ns.Compat.MapToWorld, frame(p.f)
	local c0, px, py = toWorld(p.map, p.x, p.y, f)
	if not c0 then return nil end
	local best, bestD
	for _, s in ipairs(rec.spawns) do
		if s.z and s.map == p.map and frame(s.f) == f then
			local c, wx, wy = toWorld(s.map, s.x, s.y, f)
			local d = c == c0 and ((wx - px) ^ 2 + (wy - py) ^ 2) ^ 0.5 or nil
			if d and d <= SPAWN_Z_YARDS and (not bestD or d < bestD) then best, bestD = s.z, d end
		end
	end
	return best
end

local function located(p)
	return p ~= nil and p.map ~= nil and p.x ~= nil and p.y ~= nil
end

local function itemName(id)
	local C = Codex()
	return (C.Name("item", id)) or (L["Item"] .. " " .. id)
end

local function npcName(id)
	local C = Codex()
	return (C.Name("npc", id)) or (L["NPC"] .. " " .. id)
end

local function percent(n)
	return format("%.3g%%", n)
end

-- Where to collect a quest item: the nearest spawn of its best drop or object
-- source; else, with `inside` (see questStep), where its best source without
-- a known spawn is, unless that source rarely gives it (under INSIDE_CHANCE
-- percent: Razorgore's 1.5% Nexus Crystal is no errand) -> point, its name
-- (an inside source only), the best source's spawns (a placed source only).
local function itemSpot(itemId, from, inside)
	local C = Codex()
	local item = C.Item(itemId)
	if not item then return nil end
	local best, bestChance, bestSpawns, placed, placedChance, placedName
	for _, src in ipairs(item.sources or {}) do
		local rec, kind, id
		if src.type == "drop" and src.npc then
			rec, kind, id = C.Npc(src.npc), "npc", src.npc
		elseif src.type == "object" and src.object then
			rec, kind, id = C.Object(src.object), "object", src.object
		end
		local chance = src.chance or 0
		if rec and rec.spawns and #rec.spawns > 0 then
			if not best or chance > bestChance then
				best, bestChance, bestSpawns = Lookup.Nearest(rec.spawns, from), chance, rec.spawns
			end
		elseif kind and inside and not best and (src.chance == nil or chance >= INSIDE_CHANCE) and (not placed or chance > placedChance) then
			local p = inside(kind, id)
			if p then placed, placedChance, placedName = p, chance, (rec and rec.name) or (C.Name(kind, id)) end
		end
	end
	if best then return best, nil, bestSpawns end
	return placed, placedName
end

-- Spawn areas (docs/GUIDE_FORMAT.md, "Spawn areas"), as compiled goals get
-- them (tools/lib/dsl/resolve.js, spawnSpots), for a kill, collect or interact
-- goal placed at one of its target's spawns: every Codex spawn of the target
-- on the goal's map and frame is a spot, so the arrow goes to the place
-- nearest the player, or searches them one after another, instead of only the
-- one nearest the giver (#610). The Codex keeps a target's spawns as a few
-- clusters per map (tools/lib/codex/build.js, SPAWN: CODEX_CLUSTER map percent
-- wide), each one place, its radius that width in yards. Places whose 90%
-- extent reaches past SPREAD_YARDS from their centre are an area objective
-- (`spread`): searched as a walk from the goal's point, each spot SPREAD_R
-- wide; closer ones are camps (CAMP_R), nearest to the goal's point first.
-- Past the caps the rest are alternatives (`alt`). Fewer than two places, or
-- a map without world bounds: none (the point stays).
local SPOTS = { CODEX_CLUSTER = 3, SPREAD_YARDS = 250, CAMP_R = { 15, 70 }, SPREAD_R = { 40, 150 }, CAMP_CAP = 6, SPREAD_CAP = 12 }

local function spawnSpots(goal, spawns)
	local map, f = goal.map, goal.f
	if not (map and goal.x and type(spawns) == "table") then return goal end
	local toWorld = ns.Compat.MapToWorld
	local c0, gx, gy = toWorld(map, goal.x, goal.y, f)
	if not c0 then return goal end
	local pts, sx, sy = {}, 0, 0
	for _, s in ipairs(spawns) do
		if s.map == map and frame(s.f) == f and s.x and s.y then
			local c, wx, wy = toWorld(map, s.x, s.y, f)
			if c ~= c0 then return goal end
			pts[#pts + 1] = { x = s.x, y = s.y, wx = wx, wy = wy }
			sx, sy = sx + s.x, sy + s.y
		end
	end
	local n = #pts
	if n < 2 then return goal end
	local function yards(ax, ay, bx, by) return ((ax - bx) ^ 2 + (ay - by) ^ 2) ^ 0.5 end
	-- 90% extent from the centre.
	local _, cx, cy = toWorld(map, sx / n, sy / n, f)
	local ds = {}
	for i, p in ipairs(pts) do ds[i] = yards(p.wx, p.wy, cx, cy) end
	table.sort(ds)
	local spread = ds[math.min(n, math.floor(n * 0.9) + 1)] > SPOTS.SPREAD_YARDS
	-- The Codex cluster's width in yards, clamped for camps or searched areas.
	local _, ex, ey = toWorld(map, goal.x + SPOTS.CODEX_CLUSTER, goal.y + SPOTS.CODEX_CLUSTER, f)
	local bounds = spread and SPOTS.SPREAD_R or SPOTS.CAMP_R
	local r = math.floor(math.min(bounds[2], math.max(bounds[1], yards(ex, ey, gx, gy) / 2 ^ 0.5)) + 0.5)
	-- Order: a walk from the goal's point (spread), else nearest to it first.
	local order, at = {}, { wx = gx, wy = gy }
	local function before(a, b, from)
		local da, db = yards(a.wx, a.wy, from.wx, from.wy), yards(b.wx, b.wy, from.wx, from.wy)
		if da ~= db then return da < db end
		if a.x ~= b.x then return a.x < b.x end
		return a.y < b.y
	end
	if spread then
		local left = {}
		for i, p in ipairs(pts) do left[i] = p end
		while #left > 0 do
			local bi = 1
			for i = 2, #left do
				if before(left[i], left[bi], at) then bi = i end
			end
			at = table.remove(left, bi)
			order[#order + 1] = at
		end
	else
		for i, p in ipairs(pts) do order[i] = p end
		table.sort(order, function(a, b) return before(a, b, at) end)
	end
	local cap = spread and SPOTS.SPREAD_CAP or SPOTS.CAMP_CAP
	local spots = {}
	for i, p in ipairs(order) do
		spots[i] = { x = p.x, y = p.y, r = r, n = 1, alt = i > cap or nil }
	end
	goal.spots = spots
	if spread then goal.spread = true end
	return goal
end

-- Quests to do in order to get questId, prerequisites first: every one of
-- `pre`, and of `preAny` (unless one is done) the first this character can
-- take, else the first it can take once it has the level (Fury in the Depths
-- waits on The Dark Iron War, level 25: leaving that out sent a level 23 to
-- a giver who refused, #1076). Done prerequisites are left out. The chain is
-- whole however long (Alba Fairmoon's to The State of the Mines is ten
-- quests): a cut would drop the first quests to do. Each quest is visited
-- once, so the walk ends. avoid(id), optional: a `preAny` alternative it
-- names is passed over while another can be taken (a dungeon pick-up keeps
-- to one alternative of an exclusive group).
local function questChain(questId, player, avoid)
	local C = Codex()
	local order, seen = {}, {}
	local function visit(qid, depth)
		if seen[qid] then return end
		seen[qid] = true
		local q = C.Quest(qid)
		if not q then return end
		if depth > 0 and ns.Compat.IsQuestCompleted(qid) then return end
		for _, pid in ipairs(q.pre or {}) do visit(pid, depth + 1) end
		local any = q.preAny or {}
		if #any > 0 then
			local done = false
			for _, pid in ipairs(any) do
				if ns.Compat.IsQuestCompleted(pid) then done = true; break end
			end
			if not done then
				local function choose(skip)
					local pick, later
					for _, pid in ipairs(any) do
						local pq = not (skip and avoid(pid)) and C.Quest(pid) or nil
						local why = pq and Lookup.QuestBlock(pq, player)
						if pq and not why then pick = pid; break end
						if why == "level" and not later then later = pid end
					end
					return pick or later
				end
				local pick = avoid and choose(true) or choose(false)
				if pick then visit(pick, depth + 1) end
			end
		end
		order[#order + 1] = q
	end
	visit(questId, 0)
	return order
end

function Lookup.AcceptPre(goal, q)
	local all, any = q and q.pre or nil, q and q.preAny or nil
	local titles
	local function title(id)
		local r = Codex().Quest(id)
		if r and r.title then
			titles = titles or {}
			titles[id] = r.title
		end
	end
	if type(all) == "table" and #all > 0 then
		goal.preAll = all
		for _, id in ipairs(all) do title(id) end
	end
	if type(any) == "table" and #any > 0 then
		-- One of them: the character's own (The Dalaran Inquiry's Word from
		-- Dalaran is the Alliance's, Orders from the Undercity the Horde's).
		local p, own = Lookup.PlayerInfo(), {}
		for _, id in ipairs(any) do
			local r = Codex().Quest(id)
			local why = r and Lookup.QuestBlock(r, p)
			if not (why == "faction" or why == "race" or why == "class") then own[#own + 1] = id end
		end
		goal.pre = #own > 0 and own or any
		for _, id in ipairs(goal.pre) do title(id) end
	end
	goal.preTitles = titles
	return goal
end

local function endGoal(t, q, e)
	local g = { t = t, quest = q.id, title = q.title }
	if e.npc then
		g.npc, g.npcName = e.npc, e.name
	else
		g.object, g.objName = e.object, e.name
	end
	return at(g, e.spawn)
end

-- The first NPC or object of `ends` that inside(kind, id) places (see
-- questStep) -> { npc|object, name, spawn } | nil.
local function insideEnd(ends, inside)
	if not (inside and type(ends) == "table") then return nil end
	local C = Codex()
	for _, id in ipairs(ends.npc or {}) do
		local p = inside("npc", id)
		if p then return { npc = id, name = (C.Name("npc", id)) or npcName(id), spawn = p } end
	end
	for _, id in ipairs(ends.object or {}) do
		local p = inside("object", id)
		if p then return { object = id, name = (C.Name("object", id)) or (L["Object"] .. " " .. id), spawn = p } end
	end
	return nil
end

-- The first NPC or object of `ends`, with no place -> { npc|object, name } | nil.
local function bareEnd(ends)
	if type(ends) ~= "table" then return nil end
	local C = Codex()
	local id = (ends.npc or {})[1]
	if id then return { npc = id, name = (C.Name("npc", id)) or npcName(id) } end
	id = (ends.object or {})[1]
	if id then return { object = id, name = (C.Name("object", id)) or (L["Object"] .. " " .. id) } end
	return nil
end

-- One step per quest: accept, objectives, turn-in. -> step | nil, reason
-- opts.inside(kind, id) -> point { map, x, y, f, name } | nil: where an NPC
-- or object without a known spawn is (Dungeons' attunement guides: the
-- entrance of the instance it is inside, `name` the instance's). With it the
-- step is always whole, its giver, targets and turn-in at those points (or
-- unplaced) and step.note saying what is inside where; without it a quest
-- whose giver or turn-in has no place is a "First do the quest" note.
local function questStep(q, from, isTarget, opts)
	local C = Codex()
	local inside = opts and opts.inside
	local within, order = {}, {}
	local function mark(p, name)
		if not (p and p.name and name) then return end
		local list = within[p.name]
		if not list then
			list = {}
			within[p.name] = list
			order[#order + 1] = p.name
		end
		for _, n in ipairs(list) do
			if n == name then return end
		end
		list[#list + 1] = name
	end
	local giver = Lookup.QuestEnd(q.start, from)
	if not giver then
		giver = insideEnd(q.start, inside)
		if giver then mark(giver.spawn, giver.name) end
	end
	local startItem = q.start and q.start.item and q.start.item[1]
	local finish = Lookup.QuestEnd(q["end"], giver and giver.spawn or from)
	if not finish then
		finish = insideEnd(q["end"], inside)
		if finish then mark(finish.spawn, finish.name) end
	end
	if inside then
		giver = giver or (not startItem and bareEnd(q.start)) or nil
		finish = finish or bareEnd(q["end"])
	end
	if not finish or not (giver or startItem) then
		if isTarget then return nil, "nolocation" end
		return { title = q.title, goals = { { t = "note", text = L["First do the quest"] .. " " .. ns.Quoted(q.title) } } }
	end
	local goals = {}
	local accept
	if giver then
		accept = endGoal("accept", q, giver)
	else
		accept = { t = "accept", quest = q.id, title = q.title, item = startItem, itemName = itemName(startItem) }
	end
	accept.minLevel = q.minLevel
	Lookup.AcceptPre(accept, q)
	goals[1] = accept
	local here = giver and giver.spawn or from
	local event = nil
	for oi, o in ipairs(q.objectives or {}) do
		local count = o.count or 1
		if o.type == "kill" and o.id then
			local npc = C.Npc(o.id)
			local target = (npc and npc.name) or o.text or npcName(o.id)
			local s = npc and Lookup.Nearest(npc.spawns, here)
			if not s and inside then
				s = inside("npc", o.id)
				mark(s, target)
			end
			goals[#goals + 1] = spawnSpots(at({ t = "kill", target = target, npc = o.id, tame = o.tame,
				quest = q.id, oi = oi, count = count, title = q.title }, s), npc and npc.spawns)
		elseif o.type == "item" and o.id then
			local name = (C.Name("item", o.id)) or o.text or itemName(o.id)
			local s, source, spawns = itemSpot(o.id, here, inside)
			if source then mark(s, name) end
			goals[#goals + 1] = spawnSpots(at({ t = "collect", item = o.id, itemName = name,
				quest = q.id, oi = oi, count = count, title = q.title }, s), spawns)
		elseif o.type == "talk" and o.id then
			-- Speak to an NPC (Hidden Enemies: Neeru Fireblade): the engine counts it by the
			-- quest's objective line, so it holds the step until done.
			local npc = C.Npc(o.id)
			local who = (npc and npc.name) or o.text or npcName(o.id)
			local s = npc and Lookup.Nearest(npc.spawns, here)
			if not s and inside then
				s = inside("npc", o.id)
				mark(s, who)
			end
			goals[#goals + 1] = at({ t = "talk", npc = o.id, npcName = who, quest = q.id, oi = oi, title = q.title }, s)
		elseif o.type == "object" and o.id then
			local obj = C.Object(o.id)
			local objName = (obj and obj.name) or o.text or (L["Object"] .. " " .. o.id)
			local s = obj and Lookup.Nearest(obj.spawns, here)
			if not s and inside then
				s = inside("object", o.id)
				mark(s, objName)
			end
			goals[#goals + 1] = spawnSpots(at({ t = "interact", object = o.id, objName = objName,
				quest = q.id, oi = oi, count = count, title = q.title }, s), obj and obj.spawns)
		else
			event = event or o
		end
	end
	if event then
		goals[#goals + 1] = at({ t = "complete", quest = q.id, title = q.title, text = event.text }, event)
	end
	goals[#goals + 1] = endGoal("turnin", q, finish)
	local step = { title = q.title, goals = goals }
	if #order > 0 then
		local lines = {}
		for i, inst in ipairs(order) do
			lines[i] = format(L["%s: inside %s."], concat(within[inst], ", "), inst)
		end
		step.note = concat(lines, " ")
	end
	return step
end

-- Steps for a quest and its unfinished prerequisites. -> steps | nil, reason
local function questSteps(questId, player, from)
	local C = Codex()
	if not C.Quest(questId) then return nil, "unknown" end
	local chain = questChain(questId, player)
	local steps = {}
	for i, q in ipairs(chain) do
		local step, err = questStep(q, from, q.id == questId)
		if not step then return nil, err end
		steps[#steps + 1] = step
	end
	return steps
end
Lookup.QuestChain = questChain
Lookup.QuestStep = function(q, from, opts) return questStep(q, from, false, opts) end

local RANK_CAPS = { 75, 150, 225, 300 }

local function rankFor(skill)
	for i = 1, #RANK_CAPS do
		if (skill or 1) <= RANK_CAPS[i] then return i end
	end
	return #RANK_CAPS
end

local builders = {}

-- What the vendor asks before selling, or the NPC before handing it out
-- (Sources' purchase gates), comes first: the standing (Lookup.PurchaseRep,
-- the one at that npc), then, to buy it, the skill rank.
local function purchaseSteps(item, npcId, purchase)
	local steps = {}
	if type(item) ~= "table" then return steps end
	local faction, standing = Lookup.PurchaseRep(item, npcId, purchase)
	if faction then
		local f = Codex().Faction(faction)
		local name = f and f.name or (L["Faction"] .. " " .. faction)
		steps[#steps + 1] = { title = name, goals = {
			{ t = "rep", faction = faction, factionName = name, standing = standing },
		} }
	end
	if not purchase then return steps end
	if item.reqSkill and item.reqSkillRank then
		local name = Lookup.ProfessionName(item.reqSkill) or L["Profession"]
		steps[#steps + 1] = { title = L[name], goals = {
			{ t = "skill", skill = name, skillLine = item.reqSkill, level = item.reqSkillRank },
		} }
	end
	return steps
end

builders.vendor = function(ctx, row)
	local npc = Codex().Npc(row.src.npc)
	if not (npc and located(row)) then return nil, "nolocation" end
	local steps = purchaseSteps(ctx.entity, npc.id, true)
	steps[#steps + 1] = { title = npc.name, goals = {
		at({ t = "goto" }, row),
		at({ t = "buy", item = ctx.id, itemName = ctx.name, count = 1, npc = npc.id, npcName = npc.name }, row),
	} }
	return steps
end

-- An NPC hands it out: go, talk, have it.
builders.gift = function(ctx, row)
	local npc = Codex().Npc(row.src.npc)
	if not (npc and located(row)) then return nil, "nolocation" end
	local steps = purchaseSteps(ctx.entity, npc.id, false)
	steps[#steps + 1] = { title = npc.name, goals = {
		at({ t = "goto" }, row),
		at({ t = "talk", npc = npc.id, npcName = npc.name, optional = true }, row),
		{ t = "collect", item = ctx.id, itemName = ctx.name, count = 1 },
	} }
	return steps
end

builders.drop = function(ctx, row)
	local C = Codex()
	local npc = C.Npc(row.src.npc)
	if not npc then return nil, "unknown" end
	local steps = {}
	local inst = row.instance and C.Instance(row.instance)
	local kill = { t = "kill", target = npc.name, npc = npc.id, optional = true }
	local collect = { t = "collect", item = ctx.id, itemName = ctx.name, count = 1 }
	local step = { title = npc.name, goals = {} }
	if row.chance then step.note = L["Drop chance"] .. " " .. percent(row.chance) end
	if inst then
		if located(row) then
			steps[#steps + 1] = { title = inst.name, goals = { at({ t = "goto", text = L["Enter"] .. " " .. inst.name }, row) } }
		end
		step.goals[1], step.goals[2] = kill, collect
	else
		if not located(row) then return nil, "nolocation" end
		step.goals[1] = at({ t = "goto" }, row)
		step.goals[2] = at(kill, row)
		step.goals[3] = at(collect, row)
	end
	steps[#steps + 1] = step
	return steps
end

builders.object = function(ctx, row)
	local obj = Codex().Object(row.src.object)
	if not (obj and located(row)) then return nil, "nolocation" end
	local step = { title = obj.name, goals = {
		at({ t = "goto" }, row),
		at({ t = "interact", object = obj.id, objName = obj.name, optional = true }, row),
		at({ t = "collect", item = ctx.id, itemName = ctx.name, count = 1 }, row),
	} }
	if row.chance then step.note = L["Drop chance"] .. " " .. percent(row.chance) end
	return { step }
end

builders.quest = function(ctx, row)
	local steps, err = questSteps(row.src.quest, ctx.player, ctx.from)
	if not steps then return nil, err end
	local last = steps[#steps]
	last.goals[#last.goals + 1] = { t = "collect", item = ctx.id, itemName = ctx.name, count = 1 }
	if row.src.choice then
		last.note = L["Choose this reward:"] .. " " .. ctx.name
	end
	return steps
end

builders.craft = function(ctx, row)
	local src = row.src
	local line, spell = src.skillLine, src.spell
	local name = Lookup.ProfessionName(line) or L["Profession"]
	local C = Codex()
	local trainer = row.trainer and C.Npc(row.trainer)
	local goals = {}
	local rank, maxRank = ns.Compat.GetSkillRank(line)
	local need = src.skill or 1
	local r = rankFor(need)
	if not maxRank or maxRank < RANK_CAPS[r] then
		local g = { t = "train", skillLine = line, skill = name, rank = r }
		if trainer then
			g.npc, g.npcName = trainer.id, trainer.name
			at(g, row)
		end
		goals[#goals + 1] = g
	end
	if not rank or rank < need then
		goals[#goals + 1] = { t = "skill", skill = name, skillLine = line, level = need }
	end
	if not ns.Compat.IsSpellKnown(spell) then
		local g = { t = "learn", spell = spell, spellName = ctx.name, skillLine = line }
		if trainer then
			g.npc, g.npcName = trainer.id, trainer.name
			at(g, row)
		end
		goals[#goals + 1] = g
	end
	goals[#goals + 1] = { t = "craft", spell = spell, spellName = ctx.name, item = ctx.id, itemName = ctx.name, count = 1, skillLine = line }
	return { { title = L[name], goals = goals } }
end

builders.rep = function(ctx, row)
	local C = Codex()
	local src = row.src
	local f = C.Faction(src.faction)
	if not f then return nil, "unknown" end
	local steps = {
		{ title = f.name, goals = { { t = "rep", faction = f.id, factionName = f.name, standing = src.standing } } },
	}
	local npc = src.npc and C.Npc(src.npc)
	if npc and located(row) then
		steps[2] = { title = npc.name, goals = {
			at({ t = "goto" }, row),
			at({ t = "buy", item = ctx.id, itemName = ctx.name, count = 1, npc = npc.id, npcName = npc.name }, row),
		} }
	else
		steps[1].goals[2] = { t = "collect", item = ctx.id, itemName = ctx.name, count = 1 }
	end
	return steps
end

builders.pvp = function(ctx, row)
	local steps, err = builders.vendor(ctx, { src = { npc = row.src.npc }, map = row.map, x = row.x, y = row.y, f = row.f })
	if not steps then return nil, err end
	if row.src.rank then steps[#steps].note = L["PvP rank"] .. " " .. row.src.rank end
	return steps
end

-- Rows of the non-item kinds.
builders.spawn = function(ctx, row)
	if not located(row) then return nil, "nolocation" end
	local goals = { at({ t = "goto", text = ctx.name }, row) }
	local e = ctx.entity
	if ctx.kind == "rare" or (e and e.rare) then
		goals[2] = at({ t = "kill", target = e.name, npc = e.id, optional = true }, row)
	elseif ctx.kind == "object" or ctx.kind == "treasure" then
		goals[2] = at({ t = "interact", object = e.id, objName = e.name, optional = true }, row)
	end
	return { { title = ctx.name, goals = goals } }
end

builders.start = function(ctx)
	return questSteps(ctx.id, ctx.player, ctx.from)
end
builders["end"] = builders.start

builders.entrance = function(ctx, row)
	if not located(row) then return nil, "nolocation" end
	return { { title = ctx.name, goals = { at({ t = "goto", text = L["Enter"] .. " " .. ctx.name }, row) } } }
end

local function entityName(kind, entity)
	if not entity then return nil end
	if kind == "quest" then return entity.title end
	return entity.name
end

-- Where a guide opens on the map: the first goal that has a place.
local function placeGuide(def)
	for _, s in ipairs(def.steps) do
		for _, g in ipairs(s.goals) do
			if g.map then
				def.zone, def.zoneName = g.map, ns.Compat.MapName(g.map)
				return def
			end
		end
	end
	return def
end

-- A planner kind's guide, in the shape the rest of Lookup's guides take.
local function plannedGuide(kind, id)
	local def, err = planners[kind](id)
	if not def then return nil, err end
	if type(def.steps) ~= "table" or #def.steps == 0 then return nil, "noguide" end
	def.id = Lookup.GuideId(kind, id)
	def.pack, def.tier = "lookup", "free"
	def.category = def.category or "Lookup"
	def.author, def.version = "Polestar", 1
	def.lookup = { kind = kind, id = id }
	return placeGuide(def)
end

function Lookup.BuildGuide(kind, id, ranked)
	if planners[kind] then
		if id == nil then return nil, "unknown" end
		return plannedGuide(kind, id)
	end
	local C = Codex()
	if not (C and kind and id ~= nil) then return nil, "unknown" end
	local list, entity = Lookup.Sources(kind, id)
	if not entity then return nil, "unknown" end
	local row = ranked
	if type(row) ~= "table" then row = Lookup.BestSource(list, tonumber(row)) end
	if not row then return nil, #list == 0 and "nosource" or "noguide" end
	local build = builders[row.type]
	if not build or not row.guideable then return nil, "noguide" end
	local name = entityName(kind, entity) or tostring(id)
	local ctx = {
		kind = kind, id = ITEM_KINDS[kind] and tonumber(id) or id, name = name, entity = entity,
		player = Lookup.PlayerInfo(), from = ns.PlayerPoint(),
	}
	local steps, err = build(ctx, row)
	if not steps then return nil, err end
	if #steps == 0 then return nil, "noguide" end
	return placeGuide({
		id = Lookup.GuideId(kind, id),
		pack = "lookup",
		title = name,
		category = "Lookup",
		author = "Polestar", version = 1,
		steps = steps,
		lookup = { kind = kind, id = id, source = row.type },
	})
end

---------------------------------------------------------------------------
-- Registering and opening
---------------------------------------------------------------------------

-- Polestar's own internal pack, held from the moment Polestar's files load:
-- packs load after Polestar (their Dependencies), so a later claim on
-- `lookup` is refused like any other and listed on the Community guides page.
ns.RegisterPack({ id = "lookup", title = L["Lookup"], internal = true })

local function register(def)
	return ns.RegisterGuide(def)
end

-- Opens guideId in a tab. A generated guide already open is reloaded in its
-- own tab (the tab holds the guide table it was opened with). Six tabs open:
-- nil, "tabs" (its callers say "Six tabs is the limit"), as the guide menu
-- and the class heads-up do; the active tab, often the leveling guide, is
-- never replaced (#1328).
local function openTab(guideId, rebuilt)
	local E = ns.Engine
	if not (E and ns.IsLoggedIn()) then return nil, "login" end
	local tabs = E.GetTabs()
	for i, t in ipairs(tabs) do
		if t.guideId == guideId then
			if not rebuilt then
				E.SelectTab(i)
				return guideId
			end
			E.CloseTab(i)
			local index = E.OpenTab(guideId, true)
			if index and index ~= i then E.MoveTab(index, i) end
			return index and guideId or nil, index == nil and "tabs" or nil
		end
	end
	if E.OpenTab(guideId, true) then return guideId end
	return nil, "tabs"
end

function Lookup.Guide(kind, id, index)
	local planned = planners[kind] ~= nil
	if not (planned or enabled()) then return nil, "disabled" end
	local C = Codex()
	if not C then return nil, "missing" end
	local loaded, reason = C.Load()
	if not loaded then return nil, reason end
	if index == nil and not planned then
		local curated = Lookup.CuratedGuide(kind, id)
		if curated then return openTab(curated, false) end
		-- A guide built from a mount's best source would leave out level 40,
		-- riding and the gold: the Lookup page says what it takes instead.
		local record = (kind == "spell" and C.Spell(id)) or (ITEM_KINDS[kind] and C.Item(id)) or nil
		if Lookup.IsMount(record) then return nil, "mount" end
	end
	if kind == "spell" then
		local spell = C.Spell(id)
		if not (spell and spell.item) then return nil, "noguide" end
		kind, id = (C.Item(spell.item) or {}).kind or "item", spell.item
	end
	local def, err = Lookup.BuildGuide(kind, id, index)
	if not def then return nil, err end
	local ok, regErr = register(def)
	if not ok then return nil, regErr end
	return openTab(def.id, true)
end

-- Saved tabs of generated guides come back after /reload: rebuild them
-- before the Engine reopens the saved tabs at login.
ns.OnInit(function()
	local s = ns.CharState()
	local ids = {}
	if type(s.tabs) == "table" then
		for _, gid in pairs(s.tabs) do ids[#ids + 1] = gid end
	end
	ids[#ids + 1] = s.guide
	local C = Codex()
	for _, gid in ipairs(ids) do
		local kind, id = Lookup.ParseGuideId(gid)
		if kind and (planners[kind] or enabled()) and C and not ns.Guides.Get(gid) and C.Load() then
			local def = Lookup.BuildGuide(kind, id)
			if def and def.id == gid then register(def) end
		end
	end
end)

---------------------------------------------------------------------------
-- Alt-click
---------------------------------------------------------------------------

local function altOnly()
	if not (IsAltKeyDown and IsAltKeyDown()) then return false end
	if IsShiftKeyDown and IsShiftKeyDown() then return false end
	if IsControlKeyDown and IsControlKeyDown() then return false end
	if GetMouseButtonClicked then
		local button = GetMouseButtonClicked()
		if button and button ~= "" and button ~= "LeftButton" then return false end
	end
	return true
end

function Lookup.OnItemClick(link, itemID)
	if not (enabled() and ns.Get("lookup.altClick") and altOnly()) then return end
	local C = Codex()
	if C and not C.IsLoaded() then C.Load() end
	local item = C and C.IsLoaded() and C.Item(itemID)
	local kind = item and item.kind or "item"
	local guideId = Lookup.Guide(kind, itemID)
	if not guideId then Lookup.Show(nil, kind, itemID) end
end

ns.Hooks.ItemClick("lookup", Lookup.OnItemClick)
