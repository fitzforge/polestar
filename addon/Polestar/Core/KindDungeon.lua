-- The dungeon kind's models for the guide window (docs/ARCHITECTURE.md, "Guide
-- kinds"): pure data, no frames, what the window's regions
-- (UI/GuideFrameKindDungeon.lua), the tests and the preview read through
-- Engine.KindModel(region, view). Outside the instance: the dungeon's picture and
-- name, then the step (the way in is the pick-up guide's last step); inside: the run
-- (Dungeons/Run.lua).
--
--   brief    = { key, name, art }
--   ready    = { level, floor }                    nil unless the character is below the
--       dungeon's floor (the region is left out then): come back at `floor`
--   skipped  = { key, count, items = { { quest, title, by, byTitle } } }   nil without one: the dungeon's quests left out
--       of the plan because the player skipped them (Dungeons.PickupPlan's `skipped`); by: the quest id to
--       unskip (the quest itself, or the start of its chain: byTitle names it)
--   tracker  = Dungeons.Run.Model()
--
--   KindDungeon.KeyOf(def) -> key | nil   -- the dungeon a guide is for: its `dungeon`, a
--       Dungeons pick-up or hand-in guide's, else the dungeon its title names

local ADDON, ns = ...

local type = type

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
	return { key = key, name = d.name, art = Dg.Art and Dg.Art(key) or nil }
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

-- The plan behind `skipped`, kept STALE seconds (the plan is the costly part) or until the log or the
-- player's skips change.
local STALE = 30
local cached
local function forget() cached = nil end
for _, e in ipairs({ "QUEST_ACCEPTED", "QUEST_REMOVED", "QUEST_TURNED_IN" }) do ns.RegisterEvent(e, forget) end
ns.On("PLAYER_SKIPPED_QUEST", forget)
ns.On("PLAYER_UNSKIPPED_QUEST", forget)
KD.Forget = forget

-- The dungeon's quests the plan left out because the player skipped them (Dungeons.PickupPlan's `skipped`):
-- nil, so no region, without a skip (the character's skips are read first: no plan is built then).
function M.skipped(view)
	local key = keyOf(view)
	if not key then return nil end
	local list = ns.CharState().skippedQuests
	if type(list) ~= "table" or not next(list) then return nil end
	local Dg = D()
	local t = GetTime and GetTime() or 0
	if not (cached and cached.key == key and t - cached.at < STALE) then
		cached = { key = key, at = t, plan = Dg.PickupPlan(key) or false }
	end
	local plan = cached.plan
	if not (plan and plan.skipped and #plan.skipped > 0) then return nil end
	local C, Cx = ns.Compat, ns.Codex
	local items = {}
	for i, s in ipairs(plan.skipped) do
		local id = s.quest.id
		local rec = s.by ~= id and Cx and Cx.Quest and Cx.Quest(s.by) or nil
		items[i] = { quest = id, title = C.GetQuestTitle(id) or s.quest.title, by = s.by,
			byTitle = s.by ~= id and (C.GetQuestTitle(s.by) or ns.Names.Quest(s.by) or (rec and rec.title)) or nil }
	end
	return { key = key, count = #items, items = items }
end

function M.tracker()
	local Dg = D()
	return Dg and Dg.Run and Dg.Run.Model() or nil
end
