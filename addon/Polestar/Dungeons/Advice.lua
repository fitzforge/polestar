-- Polestar.Dungeons, the dungeon offer: when this character reaches the level
-- the simulator runs a dungeon at, and that dungeon gets a party of their size
-- to 60 sooner (Dungeons/AdviceData.lua, written by `sim advice` from the
-- weaves: docs/SIMULATION.md, "Dungeon advice"), the guide window offers it:
-- what it saves and how sure that is, and a pick-up guide for its quests
-- (Dungeons.PickUp) that ends at the entrance. Taking it also turns the
-- dungeon on for leveling guides with `when dungeon` steps
-- (Engine.ChooseDungeon). One dungeon at a time; taking or dismissing it
-- lets the next through.
--
-- Options, Discovery, Dungeons, "Suggest dungeons" (dungeons.advice):
--   "ask"   the guide window offers it (default)
--   "open"  the pick-up guide opens in a tab by itself
--   "off"   never
-- and "Which dungeons" (dungeons.adviceWhich):
--   "pays"  only those (default)
--   "all"   also, after those, every other dungeon in the character's level
--           range (Dungeons.List: minLevel to maxLevel), in level order, as a
--           fork in the road: its pick-up guide, or keep levelling; always
--           asked, even with "open"
--
-- Per-character state in CharState().flags.dungeonOffered (key ->):
--   true    taken or dismissed: never again
--   <level> "Later" at that level: again at a higher level
--
--   Dungeons.RegisterAdvice(t)                  AdviceData.lua
--   Dungeons.Advice(faction, size) -> { { key, level, minutes, pays }, ... } (most minutes first)
--   Dungeons.PartySize() -> 1..5                the player's party, 1 alone (a raid: 5)
--   Dungeons.AdviceDue() -> notice | nil        the dungeon to offer now
--       notice = { key, name, map, size, minutes, pays } ; "all": { key, name, map, size, any = true, minLevel, maxLevel }
--   Dungeons.CheckAdvice()                      offer it (level-up, party change, login)
--   Dungeons.ResolveAdvice(key, take, later)    GuideFrame, on take, Later or dismiss

local ADDON, ns = ...
local Dungeons = ns.Dungeons
if not Dungeons then return end

-- A dungeon is offered when it saves at least this many minutes to 60 at
-- the simulator's mean parameters, in at least this share of its draws.
local MIN_MINUTES = 5
local MIN_PAYS = 0.5

local advice = {}

function Dungeons.RegisterAdvice(t)
	if type(t) == "table" then advice = t end
end

function Dungeons.Advice(faction, size)
	local f = advice[faction]
	return f and f[size] or {}
end

function Dungeons.PartySize()
	if IsInRaid and IsInRaid() then return 5 end
	local n = GetNumGroupMembers and GetNumGroupMembers() or 0
	if n < 1 then return 1 end
	return math.min(n, 5)
end

local function offered()
	local flags = ns.CharState().flags
	if type(flags.dungeonOffered) ~= "table" then flags.dungeonOffered = {} end
	return flags.dungeonOffered
end

local pending

function Dungeons.AdviceDue()
	local mode = ns.Get("dungeons.advice")
	if mode == "off" or not Dungeons.IsEnabled() then return nil end
	local ok, player = pcall(ns.Compat.GetPlayerInfo)
	if not (ok and type(player) == "table" and player.faction) then return nil end
	local level, size = player.level or 1, Dungeons.PartySize()
	local seen = offered()
	for _, a in ipairs(Dungeons.Advice(player.faction, size)) do
		local key, at, minutes, pays = a[1], a[2], a[3], a[4]
		local v = seen[key]
		local due = v == nil or (type(v) == "number" and level > v)
		if due and minutes >= MIN_MINUTES and pays >= MIN_PAYS and level >= math.floor(at) then
			local d = Dungeons.Get(key)
			if d and level <= (d.maxLevel or 60) then
				return { key = key, name = d.name or key, map = d.map, size = size, minutes = minutes, pays = pays }
			end
		end
	end
	if ns.Get("dungeons.adviceWhich") ~= "all" then return nil end
	for _, d in ipairs(Dungeons.List()) do
		local v = seen[d.key]
		local due = v == nil or (type(v) == "number" and level > v)
		if due and d.kind == "dungeon" and d.minLevel and level >= d.minLevel and level <= (d.maxLevel or 60) then
			return { key = d.key, name = d.name or d.key, map = d.map, size = size, any = true, minLevel = d.minLevel, maxLevel = d.maxLevel }
		end
	end
	return nil
end

local function take(n)
	local E = ns.Engine
	if n.map and E and E.ChooseDungeon then E.ChooseDungeon(n.map, true) end
	return Dungeons.PickUp(n.key)
end

function Dungeons.CheckAdvice()
	if pending then return end
	local n = Dungeons.AdviceDue()
	if not n then return end
	-- "Open the pick-up guide" opens only a dungeon that pays; one merely in
	-- range is always a question.
	if ns.Get("dungeons.advice") == "open" and not n.any then
		offered()[n.key] = true
		take(n)
		return
	end
	pending = n.key
	ns.Fire("DUNGEON_ADVICE", n)
end

-- take: pick up its quests; later: "Later" (again at a higher level);
-- neither: dismissed for good. Then the next dungeon due, if any.
function Dungeons.ResolveAdvice(n, took, later)
	if n and n.key then
		local ok, player = pcall(ns.Compat.GetPlayerInfo)
		local level = ok and type(player) == "table" and player.level or 1
		offered()[n.key] = (later and not took) and level or true
		if took then take(n) end
	end
	pending = nil
	Dungeons.CheckAdvice()
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

local function soon(delay)
	C_Timer.After(delay, function() ns.SafeCall(Dungeons.CheckAdvice) end)
end

ns.RegisterEvent("PLAYER_LEVEL_UP", function() soon(1) end)
ns.RegisterEvent("GROUP_ROSTER_UPDATE", function() soon(2) end)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", function() soon(4) end)
