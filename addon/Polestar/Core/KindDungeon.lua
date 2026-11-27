-- The dungeon kind's models for the guide window (docs/ARCHITECTURE.md, "Guide
-- kinds"): pure data, no frames, what the window's regions
-- (UI/GuideFrameKindDungeon.lua), the tests and the preview read through
-- Engine.KindModel(region, view). Outside the instance: getting ready and
-- getting there; inside: the run (Dungeons/Run.lua).
--
--   brief    = { key, name, lo, hi, best, players, zone, art }
--   ready    = { level, best, floor, under, group = { n, max, names } }
--       under: the character is below the dungeon's floor (come back at `floor`);
--       group.n: 0 alone, else the members with the player; names: the others'
--   pickups  = { held, total, missing = { { quest, title, npc, where, onWay, minutesOff, far, current, after, goal, gv, point } },
--                taken = { { quest, title, held, goal, gv } }, waiting, skipped, far, inGuide, work }
--       held/total: the page's quests in the log of those this character may take now
--       (held + the plan's takes, Dungeons.PickupPlan); missing: the takes, with
--       Dungeons.PickupDetours' minutes off the way; far: over Dungeons.PICKUP_DETOUR
--       (the count: what "Skip the far one" would leave out); current: the quest the open
--       pick-up guide's step accepts; after: its chain's quest open now, when it has open
--       prerequisites ({ title, n, of }: its place in the chain, the page quest not counted,
--       Dungeons.OutsideWork); waiting: quests that open at a later level; skipped:
--       quests the player left out; inGuide: the open guide is this dungeon's pick-up guide;
--       goal, gv: the index of the step's accept of it and that goal's view (the region
--       paints it as the goal row and covers it); point: where a click points the arrow
--       (its giver, the first open prerequisite's while it waits on one: Dungeons.GiverTarget); taken: the page
--       quests the step accepted, in the log now (ticked rows until the step moves on);
--       work: the quests with work out in the world still open before the way in (a
--       chain's quest open now, a page quest's objectives done only outside: Dungeons.OutsideWork)
--   entrance = { map, x, y, eta, zone, cap = { used, max }, needs, go }
--       eta: seconds of travel from here (nil: unknown); cap: new instances this hour and the
--       cap (Maps/Instances.lua); needs: the key or attunement this character still lacks;
--       go: nothing is left before the door (no pick-up missing, no work out in the world
--       open): the region offers "Guide me to the entrance" only then
--   tracker  = Dungeons.Run.Model()
--
--   KindDungeon.KeyOf(def) -> key | nil   -- the dungeon a guide is for: its `dungeon`, a
--       Dungeons pick-up or hand-in guide's, else the dungeon its title names

local ADDON, ns = ...

local type, ipairs, floor, GetTime = type, ipairs, math.floor, GetTime

local KD = {}
ns.KindDungeon = KD

local Engine = ns.Engine
Engine.KindModels = Engine.KindModels or {}
local M = Engine.KindModels

local function D() return ns.Dungeons end
-- The open guide, through the Engine in place now (the preview stands its own in).
local function openGuide() local En = ns.Engine; return En and En.GetGuide and En.GetGuide() end

function KD.KeyOf(def)
	if type(def) ~= "table" then return nil end
	if type(def.dungeon) == "string" then return def.dungeon end
	local lk = def.lookup
	if type(lk) == "table" and (lk.kind == "pickup" or lk.kind == "handin") and type(lk.id) == "string" then return lk.id end
	local Dg = D()
	return Dg and Dg.Find and type(def.title) == "string" and Dg.Find(def.title) or nil
end

-- The view's dungeon: its guide's (view.guide, else the open one).
local function keyOf(view)
	local Dg = D()
	if not (Dg and Dg.IsEnabled() and Dg.Load()) then return nil end
	local key = KD.KeyOf(view and view.guide or openGuide())
	return key and Dg.Get(key) and key or nil
end

local function player()
	local Lk = ns.Lookup
	return Lk and Lk.PlayerInfo and Lk.PlayerInfo() or { level = UnitLevel and UnitLevel("player") or 1 }
end

function M.brief(view)
	local key = keyOf(view)
	if not key then return nil end
	local Dg = D()
	local d = Dg.Get(key)
	return { key = key, name = d.name, lo = d.minLevel, hi = d.maxLevel, best = Dg.BestAt(key),
		players = d.playersMax or d.players or 5, zone = d.zoneName or (d.zone and ns.Compat.MapName(d.zone)) or nil,
		art = Dg.Art and Dg.Art(key) or nil }
end

-- The party's other members' names, the player first counted.
local function group()
	local n = GetNumGroupMembers and GetNumGroupMembers() or 0
	local names = {}
	if n > 0 and not (IsInRaid and IsInRaid()) then
		for i = 1, 4 do
			local name = UnitName and UnitName("party" .. i)
			if type(name) == "string" and name ~= "" then names[#names + 1] = name end
		end
	end
	return n, names
end

function M.ready(view)
	local key = keyOf(view)
	if not key then return nil end
	local Dg = D()
	local d = Dg.Get(key)
	local level = player().level or 1
	local fl = d.floor or d.minLevel or 1
	local n, names = group()
	return { level = level, best = Dg.BestAt(key), floor = fl, under = level < fl,
		group = { n = n, max = d.playersMax or d.players or 5, names = names } }
end

-- The plan behind the pick-ups and the entrance's needs, kept STALE seconds
-- (PlanStops is the costly part) or until the log, the zone or the skips change.
local STALE = 30
local cache = {}
local function forget() cache = {} end
for _, e in ipairs({ "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "ZONE_CHANGED_NEW_AREA" }) do ns.RegisterEvent(e, forget) end
ns.On("DUNGEON_PICKUPS_CHANGED", forget)

local function cached(key, what, build)
	local t = GetTime and GetTime() or 0
	local c = cache[what]
	if c and c.key == key and t - c.at < STALE then return c.value end
	local v = build()
	cache[what] = { key = key, at = t, value = v }
	return v
end
KD.Forget = forget

-- The step's accepts: quest id -> its goal index (the pick-up guide's current stop).
local function stepAccepts(view)
	local out = {}
	for gi, goal in ipairs(view and view.goals or {}) do
		if goal.t == "accept" and goal.quest then out[goal.quest] = gi end
	end
	return out
end

local function planOf(key)
	local Dg = D()
	return cached(key, "plan", function()
		local p = Dg.PickupPlan(key)
		return p and Dg.PickupDetours(p) or false
	end)
end

local function inPickupGuide(key)
	local g = openGuide()
	return type(g) == "table" and type(g.id) == "string" and g.id == "lookup/pickup/" .. key
end

-- Whether a Lookup goal of the work out in the world is done now.
local function goalDone(g)
	local C = ns.Compat
	local q = g.quest
	if g.t == "accept" then return C.IsOnQuest(q) or C.IsQuestCompleted(q) end
	if q and C.IsQuestCompleted(q) then return true end
	if g.t == "turnin" then return false end
	if g.t == "collect" and not q and g.item then return (C.GetItemCount(g.item) or 0) >= (g.count or 1) end
	if q and g.oi and C.IsOnQuest(q) then
		local o = (C.GetQuestObjectives(q) or {})[g.oi]
		return o ~= nil and o.finished
	end
	return false
end

function M.pickups(view)
	local key = keyOf(view)
	if not key then return nil end
	local Dg = D()
	local plan = planOf(key)
	if not plan then return nil end
	local inGuide = inPickupGuide(key)
	local now = inGuide and stepAccepts(view) or {}
	local covers = {}
	local m = { held = #plan.carried, total = #plan.carried + #plan.take, missing = {}, waiting = plan.later or 0,
		skipped = #(plan.skipped or {}), far = 0, inGuide = inGuide, work = 0 }
	-- The work out in the world (Dungeons.OutsideWork, kept with the plan): each take's chain quest open now.
	local work = cached(key, "outside", function() return Dg.OutsideWork and Dg.OutsideWork(plan) or {} end) or {}
	local after = {}
	for _, w in ipairs(work) do
		local open = false
		for _, g in ipairs(w.goals) do
			if not goalDone(g) then open = true; break end
		end
		if open then m.work = m.work + 1 end
		if w.chain and w.opens and not after[w.opens] then after[w.opens] = { title = w.title, n = w.chain.n, of = w.chain.of } end
	end
	-- A page quest the step accepted stays, ticked, until the step moves on (as a done goal row does).
	local held = {}
	for _, pq in ipairs(plan.carried) do held[pq.id] = pq end
	m.taken = {}
	for q, gi in pairs(now) do
		local pq = held[q]
		if pq then
			m.taken[#m.taken + 1] = { quest = q, title = ns.Compat.GetQuestTitle(q) or pq.title, held = true, goal = gi, gv = view.goals[gi] }
			covers[#covers + 1] = gi
		end
	end
	table.sort(m.taken, function(a, b) return a.goal < b.goal end)
	for _, t in ipairs(plan.take) do
		local giver = t.giver or {}
		local far = t.seconds ~= nil and t.seconds > Dg.PICKUP_DETOUR * 60
		if far then m.far = m.far + 1 end
		-- Where a click points the arrow: the first open prerequisite's giver while the quest waits on one.
		local point = after[t.quest.id] and Dg.GiverTarget and cached(key, "target" .. t.quest.id, function() return Dg.GiverTarget(key, t.quest.id) or false end) or nil
		local gi = now[t.quest.id]
		m.missing[#m.missing + 1] = { quest = t.quest.id, title = ns.Compat.GetQuestTitle(t.quest.id) or t.quest.title,
			npc = giver.name, where = giver.map and ns.Compat.MapName(giver.map) or nil,
			onWay = t.onWay or false, minutesOff = t.minutesOff, far = far, current = gi ~= nil,
			after = after[t.quest.id], goal = gi, gv = gi and view.goals[gi] or nil, held = false,
			point = point or (giver.map and { map = giver.map, x = giver.x, y = giver.y, f = giver.f, name = giver.name }) or nil }
		-- The pick-up guide's accept of it reads as this row, not twice.
		if now[t.quest.id] then covers[#covers + 1] = now[t.quest.id] end
	end
	m.plan, m.covers = plan, covers
	return m
end

function M.entrance(view)
	local key = keyOf(view)
	if not key then return nil end
	local Dg = D()
	local map, x, y, f = Dg.Entrance(key)
	if not map then return nil end
	local m = { map = map, x = x, y = y, f = f, zone = ns.Compat.MapName(map), covers = {} }
	-- The step's way in (the pick-up guide's last step) reads as this region.
	for gi, goal in ipairs(view and view.goals or {}) do
		if goal.t == "goto" and goal.entrance then m.covers[#m.covers + 1] = gi end
	end
	m.eta = cached(key, "eta", function()
		local Lk = ns.Lookup
		local from = ns.PlayerPoint()
		return from and Lk and Lk.Travel(from, { map = map, x = x, y = y, f = f }) or false
	end) or nil
	local St = ns.Maps and ns.Maps.GetInstanceStatus and ns.Maps.GetInstanceStatus()
	if St then m.cap = { used = St.inHour, max = St.perHour } end
	m.needs = cached(key, "needs", function()
		local code = player().code
		for _, a in ipairs(Dg.Attunements(key, code)) do
			if (a.kind == "key" or a.kind == "attunement") and not Dg.AttunementState(a).done then
				return a.item and a.item.name or a.name
			end
		end
		return false
	end) or nil
	-- The way in is offered once nothing is left before the door.
	local p = M.pickups(view)
	m.go = not (p and (#p.missing > 0 or p.work > 0))
	return m
end

function M.tracker()
	local Dg = D()
	return Dg and Dg.Run and Dg.Run.Model() or nil
end

-- "17–24" style level text, "6:10" travel, used by the regions and the preview alike.
function KD.Minutes(seconds)
	return seconds and floor(seconds / 60 + 0.5) or nil
end
