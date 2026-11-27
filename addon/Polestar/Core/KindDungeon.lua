-- The dungeon kind's models for the guide window (docs/ARCHITECTURE.md, "Guide
-- kinds"): pure data, no frames, what the window's regions
-- (UI/GuideFrameKindDungeon.lua), the tests and the preview read through
-- Engine.KindModel(region, view). Outside the instance: the dungeon and the
-- way there; inside: the run (Dungeons/Run.lua).
--
--   brief    = { key, name, zone, art }
--   ready    = { level, floor }                    nil unless the character is below the
--       dungeon's floor (the region is left out then): come back at `floor`
--   entrance = { map, x, y, eta, zone, cap = { used, max }, needs, go }
--       eta: seconds of travel from here (nil: unknown); cap: new instances this hour and the
--       cap (Maps/Instances.lua); needs: the key or attunement this character still lacks;
--       go: nothing is left before the door (no pick-up missing, no work out in the world
--       open: KD.Pending): the region offers "Guide me to the entrance" only then
--   tracker  = Dungeons.Run.Model()
--
--   KindDungeon.KeyOf(def) -> key | nil   -- the dungeon a guide is for: its `dungeon`, a
--       Dungeons pick-up or hand-in guide's, else the dungeon its title names
--   KindDungeon.Pending(key) -> { held, total, missing, work } | nil
--       what is left before the way in, from the plan (Dungeons.PickupPlan): held/total: the
--       page's quests in the log of those this character may take now; missing: the takes still
--       to pick up (counted); work: the quests with work out in the world still open (a chain's
--       quest open now, a page quest's objectives done only outside: Dungeons.OutsideWork)

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
	return { key = key, name = d.name, zone = d.zoneName or (d.zone and ns.Compat.MapName(d.zone)) or nil,
		art = Dg.Art and Dg.Art(key) or nil }
end

function M.ready(view)
	local key = keyOf(view)
	if not key then return nil end
	local d = D().Get(key)
	local level = player().level or 1
	local fl = d.floor or d.minLevel or 1
	if level >= fl then return nil end
	return { level = level, floor = fl }
end

-- The plan behind what is left before the way in and the entrance's needs, kept STALE seconds
-- (the plan is the costly part) or until the log or the zone changes.
local STALE = 30
local cache = {}
local function forget() cache = {} end
for _, e in ipairs({ "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN", "ZONE_CHANGED_NEW_AREA" }) do ns.RegisterEvent(e, forget) end

local function cached(key, what, build)
	local t = GetTime and GetTime() or 0
	local c = cache[what]
	if c and c.key == key and t - c.at < STALE then return c.value end
	local v = build()
	cache[what] = { key = key, at = t, value = v }
	return v
end
KD.Forget = forget

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

function KD.Pending(key)
	local Dg = D()
	local plan = Dg and Dg.PickupPlan and cached(key, "plan", function() return Dg.PickupPlan(key) or false end)
	if not plan then return nil end
	local m = { held = #plan.carried, total = #plan.carried + #plan.take, missing = #plan.take, work = 0 }
	-- The work out in the world (Dungeons.OutsideWork, kept with the plan).
	local work = cached(key, "outside", function() return Dg.OutsideWork and Dg.OutsideWork(plan) or {} end) or {}
	for _, w in ipairs(work) do
		for _, g in ipairs(w.goals) do
			if not goalDone(g) then m.work = m.work + 1; break end
		end
	end
	return m
end

function M.entrance(view)
	local key = keyOf(view)
	if not key then return nil end
	local Dg = D()
	local map, x, y, f = Dg.Entrance(key)
	if not map then return nil end
	local d = Dg.Get(key)
	local m = { map = map, x = x, y = y, f = f, zone = ns.Compat.MapName(map) or d.zoneName, covers = {} }
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
	local p = KD.Pending(key)
	m.go = not (p and (p.missing > 0 or p.work > 0))
	return m
end

function M.tracker()
	local Dg = D()
	return Dg and Dg.Run and Dg.Run.Model() or nil
end
