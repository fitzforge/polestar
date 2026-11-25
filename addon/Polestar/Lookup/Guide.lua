-- Polestar.Lookup guides: open the curated guide that collects an item, or
-- build one on the spot from a ranked source, in the same guide table shape
-- the Engine runs for compiled guides (docs/ARCHITECTURE.md, "Guide data").
--
--   Lookup.CuratedGuide(kind, id) -> guideId | nil
--       a registered guide whose `collects` holds the item (kind "spell": the
--       spell's item, else a guide with the spell's name among its
--       `keywords`, as the class mount guides have; kind "quest": a guide
--       with the quest's title as one of its `keywords`, as the class quest
--       guides list their quests); one that fits the character first
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
--       is; with it the step is always whole (see questStep). A kill of an
--       elite, rare elite or boss out in the world, or an item it drops,
--       carries the compiled guides' `group` ({ kind = "elite", rank, lvl }),
--       so the step says "Elite: group advised" (Rear Guard Patrol's Riptear,
--       before the Ruins of Lordaeron's The Wrath of Rath'mael); so does an
--       object's work among hostile elites, as the Codex build marks it
--       (Berard's Bookshelf in Pyrewood Village, #1778). A kill the
--       Codex marks with `useItem` (an item used on that NPC) is a use of
--       that item, at the NPC's spawns; a tame stays a tame (#2468)
--       opts.needed: the guide is there to get the quest done (Dungeons'
--       attunement guides), so an accept or turn-in at an NPC only the dead
--       see stays to do (Lookup.GhostOnly)
--   Lookup.DropQuestSteps(source, player, from, direct?) -> steps | nil, reason, quest
--       obtain every source.requiresQuests quest not held or completed;
--       finish its ordinary prerequisites, then only accept the root.
--       A held root keeps a satisfied accept for recovery if abandoned.
--       Missing or unavailable prerequisites return a failure, never a note.
--   Lookup.AcceptPre(goal, quest) -> goal
--       an accept goal with the Codex quest's prerequisites as a compiled
--       guide's accept carries them (all of `pre` as preAll, one of `preAny`
--       as pre, without those of another faction, race or class while one
--       is left; a child quest's `parent`; their titles as
--       preTitles), so the Engine tells "Requires X first" when the route no
--       longer brings X, and a giver's window that does not list the quest
--       for that reason passes it (#1406: Gryan Stoutmantle's The Defias
--       Brotherhood after The Defias Traitor's step was skipped)
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
		ns.Print(L["Lookup is turned off (Settings > Discovery > Lookup)."])
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

-- A keyword that is the name itself, case aside: quest titles are short and
-- often part of other names, so a quest matches whole keywords only.
local function keywordIs(list, name)
	if type(list) ~= "table" or type(name) ~= "string" or name == "" then return false end
	local want = lower(name)
	for i = 1, #list do
		local k = list[i]
		if type(k) == "string" and lower(k) == want then return true end
	end
	return false
end

function Lookup.CuratedGuide(kind, id)
	local itemId, spellName, questTitle
	if ITEM_KINDS[kind] then
		itemId = tonumber(id)
	elseif kind == "spell" then
		local C = Codex()
		local spell = C and C.Spell(id)
		if not spell then return nil end
		itemId, spellName = spell.item, spell.name
	elseif kind == "quest" then
		-- A quest a class guide walks through (The Test of Righteousness in
		-- Verigan's Fist): that guide, not one built from the quest's data,
		-- which knows nothing of the chain's other quests (#2606). Keywords
		-- are English, so the title is the pack's English in every language.
		local C = Codex()
		questTitle = C and C.EnglishName and C.EnglishName("quest", id)
		if not questTitle then return nil end
	else
		return nil
	end
	local player = ns.Compat.GetPlayerInfo()
	-- The suggestion source's guides first, then ours: one this character can
	-- follow, never another faction's, class's or race's (#2462).
	local source = ns.Guides.SuggestSource()
	local from = source == "guides" and { "guides" } or { source, "guides" }
	local list = ns.Guides.List()
	for _, pack in ipairs(from) do
		for _, h in ipairs(list) do
			if h.pack == pack and type(h.id) == "string" and h.id:sub(1, #PREFIX) ~= PREFIX
				and ((itemId and holds(h.collects, itemId)) or (spellName and keywordMatch(h.keywords, spellName))
					or (questTitle and keywordIs(h.keywords, questTitle)))
				and ns.Guides.GuideMatches(h, player) then
				return h.id
			end
		end
	end
	return nil
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

-- Whether a kill or talk objective's target is one of the game's placeholders
-- (#2614: "PvP Tower Credit Marker", a "[DNT] Kill Credit"). The data build makes
-- such objectives events, so only an older Codex has one; the goal is then read
-- by its quest-log line (Engine, `logLine`) and never names the placeholder.
local function placeholderTarget(npc, o)
	local P = ns.Compat.Placeholder
	return P((npc and npc.name) or (Codex().Name("npc", o.id))) or (not npc and P(o.text))
end

-- The words for such an objective before the quest is in the log: its own
-- text, else its quest's title.
local function objectiveWords(o, q)
	return (not ns.Compat.Placeholder(o.text) and o.text) or q.title
end

local function percent(n)
	return format("%.3g%%", n)
end

-- An item source that needs a group out in the world: an elite, a rare elite
-- or a boss. While anything else with a known spawn gives the item
-- REAL_CHANCE percent of the time or more (or at an unknown chance), a step
-- collects it there instead, as compiled guides do (resolve.rs elite_split):
-- Indurium's flakes come from the Stonevault Bonesnappers and Shamans in the
-- Badlands, not from the elites in Uldaman's cave the data has at 100%
-- (#2236).
local REAL_CHANCE = 1

local function soloSource(kind, rec, chance)
	if kind == "npc" and (rec.elite or rec.boss) then return false end
	return chance == nil or chance >= REAL_CHANCE
end

-- Where to collect a quest item: the nearest spawn of its best drop or object
-- source (of those that need no group, when there are any: soloSource); else,
-- with `inside` (see questStep), where its best source without
-- a known spawn is, unless that source rarely gives it (under INSIDE_CHANCE
-- percent: Razorgore's 1.5% Nexus Crystal is no errand) -> point, its name
-- (an inside source only), the best source's spawns (a placed source only),
-- the best placed source's NPC record (a drop only).
local function itemSpot(itemId, from, inside, direct)
	local C = Codex()
	local item = C.Item(itemId)
	if not item then return nil end
	-- best[1]: the best placed source that needs no group; best[2]: the best of all.
	local best, placed, placedChance, placedName = {}, nil, nil, nil
	for _, src in ipairs(item.sources or {}) do
		local rec, kind, id
		if src.type == "drop" and src.npc then
			rec, kind, id = C.Npc(src.npc), "npc", src.npc
		elseif src.type == "object" and src.object then
			rec, kind, id = C.Object(src.object), "object", src.object
		end
		local chance = src.chance or 0
		if rec and rec.spawns and #rec.spawns > 0 then
			for i = soloSource(kind, rec, src.chance) and 1 or 2, 2 do
				if not best[i] or chance > best[i].chance then best[i] = { rec = rec, kind = kind, chance = chance } end
			end
		elseif kind and inside and not best[2] and (src.chance == nil or chance >= INSIDE_CHANCE) and (not placed or chance > placedChance) then
			local p = inside(kind, id)
			if p then placed, placedChance, placedName = p, chance, (rec and rec.name) or (C.Name(kind, id)) end
		end
	end
	local b = best[1] or best[2]
	if b then return Lookup.Nearest(b.rec.spawns, from, direct), nil, b.rec.spawns, b.kind == "npc" and b.rec or nil end
	return placed, placedName
end

-- Who gives a quest item, on its collect goal (`from`, `fromId`, `fromKind`,
-- `fromRank`, `fromFaction`, `fromAlso`, `fromAlsoId`, as compiled goals
-- carry them: tools/lib/dsl/resolve.js), so the step reads "Kill Burning
-- Blade Fanatic or Burning Blade Apprentice for Lieutenant's Insignia"
-- instead of only the item (#1589, Hidden Enemies: the insignia drops in
-- Skull Rock's cave). Of its NPC and object sources with a known spawn (those
-- that need no group when there are any, as itemSpot), best
-- chance first: named when there are at most two (each one is where it
-- drops), else when the best gives it NAMED_CHANCE percent of the time or
-- more, with a second of the same kind that does too. -> goal
local NAMED_CHANCE = 50

local function itemFrom(goal, itemId)
	local C = Codex()
	local item = C.Item(itemId)
	if not item then return goal end
	local located, solo = {}, {}
	for _, src in ipairs(item.sources or {}) do
		local kind, rec
		if src.type == "drop" and src.npc then
			kind, rec = "npc", C.Npc(src.npc)
		elseif src.type == "object" and src.object then
			kind, rec = "object", C.Object(src.object)
		end
		if rec and rec.name and rec.spawns and #rec.spawns > 0 then
			local s = { kind = kind, id = src.npc or src.object, rec = rec, chance = src.chance or 0 }
			located[#located + 1] = s
			if soloSource(kind, rec, src.chance) then solo[#solo + 1] = s end
		end
	end
	if #solo > 0 then located = solo end
	if #located == 0 then return goal end
	table.sort(located, function(a, b)
		if a.chance ~= b.chance then return a.chance > b.chance end
		return a.id < b.id
	end)
	local few = #located <= 2
	local top, second = located[1], located[2]
	if not (few or top.chance >= NAMED_CHANCE) then return goal end
	goal.from, goal.fromId, goal.fromKind = top.rec.name, top.id, top.kind
	if top.kind == "npc" then
		local r = top.rec
		goal.fromRank = (r.boss and 3) or (r.rare and r.elite and 2) or (r.elite and 1) or (r.rare and 4) or nil
		if r.faction == "A" or r.faction == "H" or r.faction == "AH" then goal.fromFaction = r.faction end
	end
	if second and second.kind == top.kind and (few or second.chance >= NAMED_CHANCE) and second.rec.name ~= goal.from then
		goal.fromAlso, goal.fromAlsoId = second.rec.name, second.id
	end
	return goal
end

-- The step's line for an item no mob or object gives where the data places
-- them, made by a profession (Rough Dynamite, Engineering: A Dynamite Plan,
-- #2363 and #2445): which profession makes it, and that the Auction House
-- sells it. nil when no profession makes it.
local function madeLine(itemId, name)
	local item = Codex().Item(itemId)
	for _, src in ipairs(item and item.sources or {}) do
		if src.type == "craft" and src.skillLine then
			local prof = Lookup.ProfessionName and Lookup.ProfessionName(src.skillLine)
			return format(L["%s: nothing drops it. It is made with %s, or bought at the Auction House."], name, prof and L[prof] or L["Profession"])
		end
	end
	return nil
end

-- A Codex NPC that needs a group out in the world -> the compiled guides'
-- `group` for a goal at it ({ kind = "elite", rank = 1 elite | 2 rare elite
-- | 3 boss, lvl }, UI.GroupLine), else nil. One inside an instance is part
-- of the run, not a warning for the step; one friendly to a side (Tirion
-- Fordring, whose "kill" objective is a talk) or of no real level (9999:
-- Anachronos) is no fight.
local MAX_LEVEL = 63
local function eliteGroup(npc)
	if not (npc and (npc.elite or npc.boss)) or npc.instance or npc.faction then return nil end
	if npc.level and npc.level > MAX_LEVEL then return nil end
	return { kind = "elite", rank = npc.boss and 3 or (npc.rare and 2) or 1, lvl = npc.level }
end

-- An objective's hostile elites for the character's side, as the Codex build
-- marked them (objective.elites[side] = { rank, lvl }: an object to use, or
-- an item only objects give, among elites; forge-data codex/elites.rs) ->
-- the same `group` as an elite target's, else nil. Read, never searched
-- for in game (#1778: Berard's Bookshelf in Pyrewood Village).
local function eliteMark(o)
	local code = o.elites and Lookup.PlayerInfo().code
	local e = code and o.elites[code]
	if not (e and e.rank) then return nil end
	return { kind = "elite", rank = e.rank, lvl = e.lvl }
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
-- spawnSpots for other guides built from the Codex: a hand-in guide's errand
-- from a seller who walks a circuit (#3744: Tawny Grisette's 24 places on
-- the Undercity's Trade Quarter ring, Dungeons/Handin.lua).
Lookup.SpawnSpots = spawnSpots

-- Quests to do in order to get questId, prerequisites first: every one of
-- `pre`, and of `preAny` (unless one is done) the one in the quest log, else
-- the first this character can take, else the first it can take once it has
-- the level (Fury in the Depths waits on The Dark Iron War, level 25: leaving
-- that out sent a level 23 to a giver who refused, #1076). The one in the log
-- first: a Rogue holding Forever's An Earnest Proposition (84152) was sent to
-- take the Classic one (8910) all the same (#3081). Done prerequisites are left out. The chain is
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
				local held
				for _, pid in ipairs(any) do
					if ns.Compat.IsOnQuest(pid) and C.Quest(pid) then held = pid; break end
				end
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
				local pick = held or (avoid and choose(true) or choose(false))
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
	-- The quests whose taking closes it for good (a breadcrumb's target, an
	-- exclusive quest): the Engine passes the accept once one is in the log
	-- or done, "No longer offered: you took X" (#1996: The Greenwarden after
	-- Tramping Paws).
	local closed = q and q.closedBy
	if type(closed) == "table" and #closed > 0 then
		goal.closedBy = closed
		for _, id in ipairs(closed) do title(id) end
	end
	-- A child quest: its giver offers it only while the parent is in the log.
	local parent = q and tonumber(q.parent)
	if parent then
		goal.parent = parent
		title(parent)
	end
	goal.preTitles = titles
	return goal
end

-- An accept or turn-in goal at an NPC only a dead character sees (the Codex's
-- ghostOnly: Franclorn Forgewright of Dark Iron Legacy, at Forgewright's Tomb)
-- gets a note on the goal itself, which compact mode shows (the step's tip is
-- folded away there): #558, the player saw nobody there. It is optional
-- unless `needed`: a pick-up or hand-in guide's quest can be left, an
-- attunement's cannot (the Shadowforge Key's guide passed both Dark Iron
-- Legacy quests by and went straight to Blackrock Depths' entrance).
-- Returns goal.
function Lookup.GhostOnly(goal, needed)
	local C = ns.Codex
	local npc = goal and goal.npc and C and C.Npc and C.Npc(goal.npc)
	if not (npc and npc.ghostOnly) then return goal end
	local text
	if needed then
		text = L["Only visible while dead: die nearby and talk to them as a ghost."]
	else
		goal.optional = true
		text = L["Only visible while dead: die nearby and talk to them as a ghost, or skip this quest."]
	end
	goal.note = goal.note and (text .. " " .. goal.note) or text
	return goal
end

local function endGoal(t, q, e, needed)
	local g = { t = t, quest = q.id, title = q.title }
	if e.npc then
		g.npc, g.npcName = e.npc, e.name
	else
		g.object, g.objName = e.object, e.name
	end
	return Lookup.GhostOnly(at(g, e.spawn), needed)
end

-- Every NPC of `ends` the character may talk to (Lookup.SideOK), each at its
-- spawn nearest `from` -> { { npc, npcName, map, x, y, f, z }, ... } | nil:
-- an accept's `candidates` (the Engine picks the nearest again on step start,
-- zone change and landing), so a quest several NPCs give goes to the one by
-- the player wherever the guide was built. Camp Mojache has a herald in each
-- Horde capital; the pick-up guide kept Warcaller Gorlach, nearest where it
-- was built, and sent a Tauren standing beside Bluff Runner Windstrider in
-- Thunder Bluff to Orgrimmar (#3368, Zack). nil when fewer than two such NPCs
-- have a place, or an object gives it too (an object is no candidate).
function Lookup.GiverCandidates(ends, from, direct)
	if type(ends) ~= "table" or #(ends.object or {}) > 0 then return nil end
	local C, p = Codex(), Lookup.PlayerInfo()
	local list = {}
	for _, id in ipairs(ends.npc or {}) do
		local npc = C.Npc(id)
		if npc and Lookup.SideOK(npc.faction, p) then
			local s = Lookup.Nearest(npc.spawns, from, direct)
			if s and s.map and s.x and s.y then
				list[#list + 1] = { npc = npc.id, npcName = npc.name, map = s.map, x = s.x, y = s.y, f = frame(s.f), z = s.z }
			end
		end
	end
	return #list >= 2 and list or nil
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
	local direct = opts and opts.direct
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
	local giver = Lookup.QuestEnd(q.start, from, nil, direct)
	if not giver then
		giver = insideEnd(q.start, inside)
		if giver then mark(giver.spawn, giver.name) end
	end
	local startItem = q.start and q.start.item and q.start.item[1]
	local finish = Lookup.QuestEnd(q["end"], giver and giver.spawn or from, nil, direct)
	if not finish then
		finish = insideEnd(q["end"], inside)
		if finish then mark(finish.spawn, finish.name) end
	end
	if inside and not (opts and opts.entrances) then
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
		accept = endGoal("accept", q, giver, opts and opts.needed)
		if giver.npc then accept.candidates = Lookup.GiverCandidates(q.start, from, direct) end
	else
		accept = { t = "accept", quest = q.id, title = q.title, item = startItem, itemName = itemName(startItem) }
	end
	accept.minLevel = q.minLevel
	Lookup.AcceptPre(accept, q)
	goals[1] = accept
	local here = giver and giver.spawn or from
	local event, eventAt = nil, nil
	-- Objectives with no target the data names (events) share one `complete`
	-- at the first one's place, in the first one's order among the quest's
	-- objectives (#3054: Brewer's Trade delivers the bottles to Dun Garok
	-- before the hops sack is had, and the page listed the sack first). When
	-- two or more have a place of their own
	-- (#2833: Powering the Pylons' western and eastern pylons), each is a
	-- goal at its place, read by its quest-log line as a placeholder's kill is
	-- (`logLine`): the arrow moves on as each line ticks, where the shared
	-- `complete` held it on the first place until the whole quest was done.
	local placedEvents = 0
	for _, o in ipairs(q.objectives or {}) do
		local named = o.id and (o.type == "kill" or o.type == "item" or o.type == "talk" or o.type == "object")
		if not named and o.map and o.x and o.y then
			placedEvents = placedEvents + 1
		end
	end
	local talks = {} -- the NPCs of talk objectives, for the step's note
	local made = {} -- the lines for items made by a profession, for the step's note
	local summons = {} -- the lines for targets an item calls up (#2326), for the step's note
	for oi, o in ipairs(q.objectives or {}) do
		local count = o.count or 1
		if o.type == "kill" and o.id then
			local npc = C.Npc(o.id)
			local credit = placeholderTarget(npc, o)
			local target = credit and objectiveWords(o, q) or (npc and npc.name) or o.text or npcName(o.id)
			-- No placed NPC (a kill credit, Riverglades' "[DNT] Kill Credit"): the
			-- objective's own place, where players' recordings show it ticking.
			local s = (npc and Lookup.Nearest(npc.spawns, here, direct)) or ((o.map and o.x and o.y) and o or nil)
			if not s and inside then
				s = inside("npc", o.id)
				mark(s, target)
			end
			-- `summonItem`: the item that calls the target up (Codex, from a
			-- summon-by-item mechanic, #2326): its use first, then the target,
			-- spoken to when it is friendly (the Screecher Spirit), else killed.
			-- `summonOn`: the creatures the item is used on (#2578: the Vale
			-- Screechers): the use line targets them and leads to their spawns.
			local summon = type(o.summonItem) == "number" and o.summonItem > 0 and not o.tame and o.summonItem
			if summon then
				local use = { t = "use", item = summon, itemName = itemName(summon), quest = q.id, oi = oi, count = count, title = q.title }
				local useAt, useSpawns = s, npc and npc.spawns
				if type(o.summonOn) == "table" and #o.summonOn > 0 then
					local from, spawns = {}, {}
					for _, id in ipairs(o.summonOn) do
						local on = C.Npc(id)
						from[#from + 1] = { npc = id, npcName = (on and on.name) or npcName(id) }
						for _, sp in ipairs(on and on.spawns or {}) do spawns[#spawns + 1] = sp end
					end
					use.npc, use.target, use.fromNpcs = from[1].npc, from[1].npcName, from
					useAt, useSpawns = Lookup.Nearest(spawns, here) or s, spawns
				end
				goals[#goals + 1] = spawnSpots(at(use, useAt), useSpawns)
				summons[#summons + 1] = format(L["%s: use %s to call it up."], target, use.itemName)
			end
			local friendly = summon and npc and type(npc.faction) == "string" and npc.faction ~= ""
				and Lookup.SideOK(npc.faction, Lookup.PlayerInfo())
			if friendly then
				goals[#goals + 1] = at({ t = "talk", npc = o.id, npcName = target, quest = q.id, oi = oi, title = q.title }, s)
				talks[#talks + 1] = target
			else
				-- `useItem`: the item this kill is really a use of (Codex, from a
				-- use-item-on-mob mechanic). The engine then says Use. A tame
				-- (Taming the Beast) stays a kill the engine words as Tame.
				local goal = { target = target, npc = not credit and o.id or nil, logLine = credit or nil, quest = q.id, oi = oi, count = count, title = q.title, group = eliteGroup(npc) }
				if not summon and type(o.useItem) == "number" and o.useItem > 0 and not o.tame then
					goal.t = "use"
					goal.item = o.useItem
					goal.itemName = itemName(o.useItem)
					goal.logLine = nil -- "Use <item>" says what to do
				else
					goal.t = "kill"
					goal.tame = o.tame
				end
				goals[#goals + 1] = spawnSpots(at(goal, s), npc and npc.spawns)
			end
		elseif o.type == "item" and o.id then
			local name = (C.Name("item", o.id)) or o.text or itemName(o.id)
			local s, source, spawns, dropper = itemSpot(o.id, here, inside, direct)
			if source then mark(s, name) end
			if not s then
				-- Nothing places a source: the objective's own place, where
				-- players' recordings show it collected (A Dynamite Plan's
				-- Rough Dynamite at Stormwind's auctioneers), and how it is had.
				if o.map and o.x and o.y then s = o end
				made[#made + 1] = madeLine(o.id, name)
			end
			goals[#goals + 1] = spawnSpots(at(itemFrom({ t = "collect", item = o.id, itemName = name,
				quest = q.id, oi = oi, count = count, title = q.title, group = eliteGroup(dropper) or eliteMark(o) }, o.id), s), spawns)
		elseif o.type == "talk" and o.id then
			-- Speak to an NPC (Hidden Enemies: Neeru Fireblade): the engine counts it by the
			-- quest's objective line, so it holds the step until done.
			local npc = C.Npc(o.id)
			local credit = placeholderTarget(npc, o)
			local who = credit and objectiveWords(o, q) or (npc and npc.name) or o.text or npcName(o.id)
			local s = (npc and Lookup.Nearest(npc.spawns, here, direct)) or ((o.map and o.x and o.y) and o or nil)
			if not s and inside then
				s = inside("npc", o.id)
				mark(s, who)
			end
			goals[#goals + 1] = at({ t = "talk", npc = not credit and o.id or nil, npcName = who, logLine = credit or nil, quest = q.id, oi = oi, title = q.title }, s)
			if not credit then talks[#talks + 1] = who end
		elseif o.type == "object" and o.id then
			local obj = C.Object(o.id)
			local objName = (obj and obj.name) or o.text or (L["Object"] .. " " .. o.id)
			local s = (obj and Lookup.Nearest(obj.spawns, here, direct)) or ((o.map and o.x and o.y) and o or nil)
			if not s and inside then
				s = inside("object", o.id)
				mark(s, objName)
			end
			goals[#goals + 1] = spawnSpots(at({ t = "interact", object = o.id, objName = objName,
				quest = q.id, oi = oi, count = count, title = q.title, group = eliteMark(o) }, s), obj and obj.spawns)
		elseif placedEvents >= 2 and o.map and o.x and o.y then
			goals[#goals + 1] = at({ t = "kill", logLine = true, target = o.text or q.title, quest = q.id, oi = oi, count = count, title = q.title }, o)
		else
			if not event then event, eventAt = o, #goals + 1 end
		end
	end
	if event then
		table.insert(goals, eventAt, at({ t = "complete", quest = q.id, title = q.title, text = event.text }, event))
	end
	goals[#goals + 1] = endGoal("turnin", q, finish, opts and opts.needed)
	local step = { title = q.title, goals = goals }
	-- How the quest is done beyond its objectives (the Codex's `how`, our
	-- public words: Powering the Pylons' mana from the rifts, #2714), first.
	local how = type(q.how) == "string" and q.how ~= "" and q.how or nil
	if how or #order > 0 or #talks > 0 or #made > 0 or #summons > 0 then
		local lines = {}
		if how then lines[1] = how end
		for _, inst in ipairs(order) do
			lines[#lines + 1] = format(L["%s: inside %s."], concat(within[inst], ", "), inst)
		end
		for _, line in ipairs(summons) do lines[#lines + 1] = line end
		-- A talk objective ticks only once the NPC's dialogue is gone through
		-- (#1590, Neeru Fireblade's several pages for Hidden Enemies).
		for _, who in ipairs(talks) do
			lines[#lines + 1] = format(L["%s: click through what they say until the quest's line is done."], who)
		end
		for _, line in ipairs(made) do lines[#lines + 1] = line end
		step.note = concat(lines, " ")
	end
	return step
end

-- The item quest q starts from, for a character who has neither it nor the
-- quest: a collect goal at the nearest spawn of its best source (itemSpot,
-- itemFrom), so the guide goes where it drops before the accept from it. #2677
-- (Ursangous's Paw, from Ursangous in Ashenvale): the step said only "Accept
-- Ursangous's Paw", with no place and no arrow. nil when nothing places it.
local function startItemGoal(q, from)
	local K = ns.Compat
	local item = q.start and q.start.item and q.start.item[1]
	if not item or K.IsOnQuest(q.id) or (K.GetItemCount(item, true) or 0) > 0 then return nil end
	local s, _, spawns, dropper = itemSpot(item, from)
	if not s then return nil end
	return spawnSpots(at(itemFrom({ t = "collect", item = item, itemName = itemName(item), count = 1, group = eliteGroup(dropper) }, item), s), spawns)
end

-- The quest whose reward is item `itemId`, for an item objective of quest
-- `self` that nothing else gives (no drop with a known chance, no object,
-- vendor, craft or other source): The Videre Elixir's elixir is Gregan
-- Brewspewer's reward for his own The Videre Elixir (4041, the Evoroot),
-- #3837. The first such quest the character can take now; nil when the
-- item has another source, the bags hold enough or none can be taken.
local function rewardQuestFor(itemId, count, player, self)
	local C, K = Codex(), ns.Compat
	if (K.GetItemCount(itemId, true) or 0) >= (count or 1) then return nil end
	local item = C.Item(itemId)
	if not item then return nil end
	local quests = {}
	for _, src in ipairs(item.sources or {}) do
		if src.type == "quest" then
			if src.quest and src.quest ~= self then quests[#quests + 1] = src.quest end
		elseif src.type ~= "drop" or (src.chance or 0) > 0 then
			return nil
		end
	end
	for _, id in ipairs(quests) do
		local q = C.Quest(id)
		if q and (K.IsOnQuest(id) or not (K.IsQuestCompleted(id) or Lookup.QuestBlock(q, player))) then return id end
	end
	return nil
end

-- Steps for a quest and its unfinished prerequisites; a quest started from an
-- item gets that item first (startItemGoal), and an item objective only
-- another quest's reward gives gets that quest's steps first
-- (rewardQuestFor). A giver, target or turn-in the
-- Codex puts inside an instance is at its entrance, the step's note saying
-- what is inside (Dungeons.InsideEntrance, as the attunement guides do:
-- What Comes Around...'s Head of Targorr left the arrow beside Guard Berton,
-- who takes it, #3613); a giver or turn-in with no place at all keeps the
-- "First do the quest" note (opts.entrances). -> steps | nil, reason
local function questSteps(questId, player, from, visiting)
	local C = Codex()
	if not C.Quest(questId) then return nil, "unknown" end
	visiting = visiting or {}
	visiting[questId] = true
	local chain = questChain(questId, player)
	local D = ns.Dungeons
	local opts = D and D.InsideEntrance and { inside = D.InsideEntrance, entrances = true } or nil
	local steps = {}
	for i, q in ipairs(chain) do
		for _, o in ipairs(q.objectives or {}) do
			local reward = o.type == "item" and o.id and rewardQuestFor(o.id, o.count, player, q.id)
			if reward and not visiting[reward] then
				local before = questSteps(reward, player, from, visiting)
				for _, s in ipairs(before or {}) do steps[#steps + 1] = s end
			end
		end
		local step, err = questStep(q, from, q.id == questId, opts)
		if not step then return nil, err end
		local first = step.goals[1]
		local get = first and first.t == "accept" and first.item and startItemGoal(q, from)
		if get then table.insert(step.goals, 1, get) end
		steps[#steps + 1] = step
	end
	return steps
end
Lookup.QuestChain = questChain

-- Who a quest is for decides whether it is on this character's line at all;
-- a level or a profession only makes it wait.
local NOT_FOR = { faction = true, race = true, class = true }
local CHAIN_MAX = 60

-- Whether every prerequisite is done: all of `pre`, one of `preAny`.
local function prereqsDone(q)
	local K = ns.Compat
	for _, id in ipairs(q.pre or {}) do
		if not K.IsQuestCompleted(id) then return false end
	end
	local any = q.preAny or {}
	if #any == 0 then return true end
	for _, id in ipairs(any) do
		if K.IsQuestCompleted(id) then return true end
	end
	return false
end

-- A quest's chain for this character (#2554): the main line through it, back
-- through its prerequisites (all of `pre`; of `preAny`, the one done, else the
-- one questChain would pick) and forward through its follow-ups while there is
-- one for this character. Unlike questChain, done quests stay in it.
--   -> { quests = { { id, title, state, why, skipped } }, step, total, done,
--        branches = { { id, title } } | nil } | nil when the quest stands alone.
-- state: "done", "log" (in the quest log), "open" (can be taken now) or
-- "later" (why: what it waits for). skipped: not done or in the log, though a
-- later quest in the line that needs it (its `pre`, or the `preAny` pick in
-- the line) is done, in the log or skipped itself.
-- step: the first quest neither done nor skipped; done: there is none left
-- (step is then total); skippedCount: how many quests are skipped.
-- The walk is the costly part (it decodes and judges every quest in the line
-- and each one's follow-ups), so its answer is kept per quest until a quest
-- is turned in or taken, a level is gained, or the Codex loads: what decides
-- the walk (a done preAny, a level gate, who a quest is for) moves only then.
local chainLines = {}
function Lookup.ResetChains() chainLines = {} end

-- -> order { quest record, ... }, branches { { id, title } } | nil,
--    needs { [quest id] = { id of a quest in the line it needs, ... } }
local function chainLine(questId, player)
	local C, K = Codex(), ns.Compat
	local order, seen, needs = {}, {}, {}
	local function forMe(q)
		local why = Lookup.QuestBlock(q, player)
		return not NOT_FOR[why]
	end
	local function back(qid)
		if seen[qid] or #order >= CHAIN_MAX then return end
		local q = C.Quest(qid)
		if not q then return end
		seen[qid] = true
		local need = {}
		for _, pid in ipairs(q.pre or {}) do
			back(pid)
			need[#need + 1] = pid
		end
		local any = q.preAny or {}
		if #any > 0 then
			local pick
			for _, pid in ipairs(any) do
				if K.IsQuestCompleted(pid) then pick = pid; break end
			end
			if not pick then
				local later
				for _, pid in ipairs(any) do
					local pq = C.Quest(pid)
					local why = pq and Lookup.QuestBlock(pq, player)
					if pq and not why then pick = pid; break end
					if why == "level" and not later then later = pid end
				end
				pick = pick or later
			end
			if pick then
				back(pick)
				need[#need + 1] = pick
			end
		end
		needs[qid] = need
		order[#order + 1] = q
	end
	back(questId)
	local branches
	local cur = questId
	while #order < CHAIN_MAX do
		local next = {}
		for _, f in ipairs(C.FollowUps and C.FollowUps(cur) or {}) do
			if f.id and not seen[f.id] and forMe(f) then next[#next + 1] = f end
		end
		if #next ~= 1 then
			if #next > 1 then
				branches = {}
				for i, f in ipairs(next) do branches[i] = { id = f.id, title = f.title } end
			end
			break
		end
		local f = next[1]
		local need = { cur }
		for _, pid in ipairs(f.pre or {}) do
			if pid ~= cur and seen[pid] then need[#need + 1] = pid end
		end
		seen[f.id] = true
		needs[f.id] = need
		order[#order + 1] = f
		cur = f.id
	end
	return order, branches, needs
end

function Lookup.ChainProgress(questId, player)
	local C, K = Codex(), ns.Compat
	if not (C and C.Quest and C.Quest(questId)) then return nil end
	player = player or Lookup.PlayerInfo()
	local line = chainLines[questId]
	if not line then
		local order, branches, needs = chainLine(questId, player)
		line = { order = order, branches = branches, needs = needs }
		chainLines[questId] = line
	end
	local order, branches, needs = line.order, line.branches, line.needs
	if #order < 2 and not branches then return nil end
	local quests, at = {}, {}
	for i, q in ipairs(order) do
		local e = { id = q.id, title = q.title }
		at[q.id] = e
		if K.IsQuestCompleted(q.id) then
			e.state = "done"
		elseif K.IsOnQuest and K.IsOnQuest(q.id) then
			e.state = "log"
		else
			local why, text = Lookup.QuestBlock(q, player)
			if why then
				e.state, e.why = "later", text
			elseif not prereqsDone(q) then
				e.state, e.why = "later", L["After an earlier quest"]
			else
				e.state = "open"
			end
		end
		quests[i] = e
	end
	-- A quest needs only quests before it in the line, so one pass from the
	-- end carries a skip back through every quest it passed over.
	for i = #quests, 1, -1 do
		local e = quests[i]
		if e.state == "done" or e.state == "log" or e.skipped then
			for _, pid in ipairs(needs[e.id] or {}) do
				local p = at[pid]
				if p and (p.state == "open" or p.state == "later") then p.skipped = true end
			end
		end
	end
	local step, skippedCount = nil, 0
	for i, e in ipairs(quests) do
		if e.skipped then
			skippedCount = skippedCount + 1
		elseif e.state ~= "done" and not step then
			step = i
		end
	end
	return {
		quests = quests, step = step or #quests, total = #quests, done = step == nil,
		skippedCount = skippedCount, branches = branches,
	}
end

-- The quest tooltip's line (#2554): "Chain: 6 of 11", "Chain: all 11 done",
-- "Chain: finished, 2 skipped" (nothing left but skipped quests), nil for a
-- quest standing alone. Only with Lookup on and the Codex loaded: a hover
-- never loads it, and Dungeons can load it with Lookup off.
function Lookup.ChainTooltipText(questId)
	if not (questId and enabled()) then return nil end
	local C = Codex()
	if not (C and C.IsLoaded and C.IsLoaded()) then return nil end
	local ch = Lookup.ChainProgress(questId)
	if not ch then return nil end
	if ch.done and ch.skippedCount > 0 then
		return format(L["Chain: finished, %d skipped"], ch.skippedCount)
	end
	if ch.done then return format(L["Chain: all %d done"], ch.total) end
	return format(L["Chain: %d of %d"], ch.step, ch.total)
end

if ns.RegisterEvent then
	for _, event in ipairs({ "QUEST_TURNED_IN", "QUEST_ACCEPTED", "PLAYER_LEVEL_UP" }) do
		ns.RegisterEvent(event, Lookup.ResetChains)
	end
end
if ns.On then ns.On("CODEX_LOADED", Lookup.ResetChains) end

Lookup.QuestStep = function(q, from, opts) return questStep(q, from, false, opts) end

-- A loot source can require a quest in the log OR already done (#1923).
-- Finish its ordinary prerequisites, then only accept the required quest:
-- completing it is not a condition for the drop. Unlike the general quest
-- preview, a missing or impossible prerequisite cannot become a note and
-- silently leave the player farming a source that cannot drop the item.
function Lookup.DropQuestSteps(src, player, from, direct)
	local C, K = Codex(), ns.Compat
	local steps, complete, visiting, accepted = {}, {}, {}, {}
	local function copy(map)
		local out = {}
		for k, v in pairs(map) do out[k] = v end
		return out
	end
	local function visit(id, acceptOnly)
		if K.IsQuestCompleted(id) or complete[id] or (acceptOnly and accepted[id]) then return true end
		local q = C.Quest(id)
		if not q then
			if not (acceptOnly and K.IsOnQuest(id)) then return nil, "unknown" end
			q = { id = id, title = L["Quest"] .. " " .. id }
		end
		if visiting[id] then return nil, "noguide", q end
		if not K.IsOnQuest(id) then
			local why = Lookup.QuestBlock(q, player)
			if why then return nil, why, q end
			for _, by in ipairs(q.closedBy or {}) do
				if K.IsOnQuest(by) or K.IsQuestCompleted(by) then return nil, "noguide", q end
			end
			visiting[id] = true
			for _, pre in ipairs(q.pre or {}) do
				local ok, err, blocked = visit(pre, false)
				if not ok then return nil, err, blocked end
			end
			local any, satisfied = q.preAny or {}, false
			for _, pre in ipairs(any) do
				if K.IsQuestCompleted(pre) or complete[pre] then satisfied = true; break end
			end
			if #any > 0 and not satisfied then
				local why, blocked
				for _, pre in ipairs(any) do
					local count, here = #steps, from
					local oldComplete, oldVisiting, oldAccepted = copy(complete), copy(visiting), copy(accepted)
					local ok, err, failed = visit(pre, false)
					if ok then satisfied = true; break end
					while #steps > count do table.remove(steps) end
					complete, visiting, accepted, from = oldComplete, oldVisiting, oldAccepted, here
					why, blocked = why or err, blocked or failed
				end
				if not satisfied then return nil, why or "noguide", blocked or q end
			end
			visiting[id] = nil
		end
		local step, err
		if acceptOnly then
			local giver = Lookup.QuestEnd(q.start, from, player, direct)
			if (not giver or giver.hostile) and not K.IsOnQuest(id) then return nil, "nolocation", q end
			-- Keep an already-satisfied accept in the guide: if the quest is
			-- abandoned later, the Engine can offer its usual return to giver.
			local goal = giver and endGoal("accept", q, giver) or { t = "accept", quest = id, title = q.title }
			goal.minLevel = q.minLevel
			Lookup.AcceptPre(goal, q)
			step = { title = q.title, goals = { goal } }
			accepted[id] = true
		else
			local item = q.start and q.start.item and q.start.item[1]
			if item and not K.IsOnQuest(id) and (K.GetItemCount(item, true) or 0) == 0 then return nil, "nolocation", q end
			step, err = questStep(q, from, true, { direct = direct })
			if not step then return nil, err, q end
			complete[id] = true
		end
		steps[#steps + 1] = step
		local last = step.goals[#step.goals]
		if last and last.map then from = last end
		return true
	end
	for _, id in ipairs(src and src.requiresQuests or {}) do
		local ok, err, q = visit(id, true)
		if not ok then return nil, err, q end
	end
	return steps
end

local function dropSteps(ctx, row)
	if (ns.Compat.GetItemCount(ctx.id, true) or 0) > 0 then return {} end
	return Lookup.DropQuestSteps(row.src, ctx.player, ctx.from)
end

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
	local steps, err = dropSteps(ctx, row)
	if not steps then return nil, err end
	local inst = row.instance and C.Instance(row.instance)
	local kill = { t = "kill", target = npc.name, npc = npc.id, optional = true }
	local collect = { t = "collect", item = ctx.id, itemName = ctx.name, count = 1 }
	local step = { title = npc.name, goals = {} }
	if row.chance then step.note = L["Drop chance"] .. " " .. percent(row.chance) end
	if inst then
		if located(row) then
			steps[#steps + 1] = { title = inst.name, goals = { at({ t = "goto", text = inst.name, entrance = true }, row) } }
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
	local steps, err = dropSteps(ctx, row)
	if not steps then return nil, err end
	local step = { title = obj.name, goals = {
		at({ t = "goto" }, row),
		at({ t = "interact", object = obj.id, objName = obj.name, optional = true }, row),
		at({ t = "collect", item = ctx.id, itemName = ctx.name, count = 1 }, row),
	} }
	if row.chance then step.note = L["Drop chance"] .. " " .. percent(row.chance) end
	steps[#steps + 1] = step
	return steps
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
	-- The trainer's place: the row's own unless the row leads to a recipe (row.trainerAt).
	local trainerAt = row.trainerAt or row
	local steps, goals, note = {}, {}, nil
	local rank, maxRank = ns.Compat.GetSkillRank(line)
	local need = src.skill or 1
	local r = rankFor(need)
	if not maxRank or maxRank < RANK_CAPS[r] then
		local g = { t = "train", skillLine = line, skill = name, rank = r }
		if trainer then
			g.npc, g.npcName = trainer.id, trainer.name
			at(g, trainerAt)
		end
		goals[#goals + 1] = g
	end
	if not rank or rank < need then
		goals[#goals + 1] = { t = "skill", skill = name, skillLine = line, level = need }
	end
	if not ns.Compat.IsSpellKnown(spell) then
		local g = { t = "learn", spell = spell, spellName = ctx.name, skillLine = line }
		local recipe = row.recipe
		if recipe then
			-- A recipe item teaches it (#2505): the steps to the recipe from its own
			-- best source (Sources' recipeRow) unless it is in the bags, then its use.
			local recipeName = itemName(recipe)
			local rrow = row.recipeRow
			local build = rrow and rrow.guideable and builders[rrow.type]
			if build and ns.Compat.GetItemCount(recipe) < 1 then
				local more = build({ kind = "recipe", id = recipe, name = recipeName, entity = C.Item(recipe), player = ctx.player, from = ctx.from }, rrow)
				for _, s in ipairs(more or {}) do steps[#steps + 1] = s end
			end
			note = format(L["Use %s to learn it."], recipeName)
		elseif trainer then
			g.npc, g.npcName = trainer.id, trainer.name
			at(g, trainerAt)
		end
		goals[#goals + 1] = g
	end
	goals[#goals + 1] = { t = "craft", spell = spell, spellName = ctx.name, item = ctx.id, itemName = ctx.name, count = 1, skillLine = line }
	steps[#steps + 1] = { title = L[name], goals = goals, note = note }
	return steps
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
	return { { title = ctx.name, goals = { at({ t = "goto", text = ctx.name, entrance = true }, row) } } }
end

-- A zone's flight master, inn or middle (Sources' zone rows, #1743): one
-- goto, and the arrow's route (flights, boats, portals) leads the way there.
builders.flight = function(ctx, row)
	if not located(row) then return nil, "nolocation" end
	return { { title = ctx.name, goals = { at({ t = "goto", text = row.label }, row) } } }
end
builders.inn, builders.middle = builders.flight, builders.flight

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
			E.CloseTab(i, true)
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
