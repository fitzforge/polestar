-- Death helper: as a ghost, compare running back to the corpse with
-- resurrecting at the nearest Spirit Healer (spawns from Data.lua), point
-- the arrow at the faster choice and say why in one line. A point picked
-- before dying (a map click, /way, another addon's) comes back once alive,
-- if the guide is still on the same step. The arrow's route to either is
-- planned like any target (Nav/Travel.lua walks a ghost there on foot).
--
-- Cost of each choice in seconds: the run (ghost run speed) and, for the
-- Spirit Healer, resurrection sickness (none through level 10, then one
-- minute per level above 10, at most ten minutes). A choice only flips when
-- the other one is clearly better, so the arrow does not flicker.
--
--   Polestar.QoL.GetDeathAdvice() -> { choice = "corpse"|"healer", corpseYards, healerYards,
--                                      corpseSeconds, healerSeconds, sickness, note } | nil
--
-- Client: UnitIsGhost, C_DeathInfo.GetCorpseMapPosition, GetUnitSpeed (Forever API docs).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL
local readable = ns.Compat.Readable

local type, sqrt, floor, min, format = type, math.sqrt, math.floor, math.min, string.format

local Death = {}
QoL.Death = Death

local RUN_SPEED = 7
local HYSTERESIS = 5      -- seconds the other choice must win by to flip
local INTERVAL = 1
local LAYER = "qol.death"

-- Resurrection sickness in seconds at a level.
function Death.Sickness(level)
	level = level or 1
	if level <= 10 then return 0 end
	return min(level - 10, 10) * 60
end

-- Nearest Spirit Healer on continent c: c, wx, wy, map, x, y, yards.
local liveCache = {}
function Death.NearestHealer(c, px, py)
	local best, bestD
	local list = QoL.data.spiritHealers
	local C = ns.Compat
	for i = 1, #list do
		local h = list[i]
		local hc, hx, hy = h[1], h[2], h[3]
		if not hc then
			-- Live-frame point: placed through the client once.
			local w = liveCache[h]
			if w == nil then
				local cc, wx, wy = C.MapToWorld(h[4], h[5], h[6])
				w = cc and { cc, wx, wy } or false
				liveCache[h] = w
			end
			if w then hc, hx, hy = w[1], w[2], w[3] end
		end
		if hc == c then
			local dx, dy = hx - px, hy - py
			local d = dx * dx + dy * dy
			if not bestD or d < bestD then best, bestD = h, d end
		end
	end
	if not best then return nil end
	local hc, hx, hy = best[1], best[2], best[3]
	if not hc then
		local w = liveCache[best]
		hc, hx, hy = w[1], w[2], w[3]
	end
	return hc, hx, hy, best[4], best[5], best[6], sqrt(bestD)
end

local function isGhost()
	return readable(UnitIsGhost and UnitIsGhost("player")) and true or false
end

local function runSpeed()
	if GetUnitSpeed then
		local _, run = GetUnitSpeed("player")
		run = readable(run)
		if run and run > 0 then return run end
	end
	return RUN_SPEED
end

-- Corpse in world yards: c, wx, wy, map, x, y (live percent on the player's map).
local function corpse()
	local C = ns.Compat
	local map = C.GetPlayerMapPosition and C.GetPlayerMapPosition()
	if not (map and C_DeathInfo and C_DeathInfo.GetCorpseMapPosition) then return nil end
	local pos = C_DeathInfo.GetCorpseMapPosition(map)
	if not pos then return nil end
	local x, y
	if pos.GetXY then x, y = pos:GetXY() else x, y = pos.x, pos.y end
	x, y = readable(x), readable(y)
	if not (x and y) or (x == 0 and y == 0) then return nil end
	local c, wx, wy = C.MapToWorld(map, x * 100, y * 100)
	if not c then return nil end
	return c, wx, wy, map, x * 100, y * 100
end

---------------------------------------------------------------------------
-- Advice
---------------------------------------------------------------------------

local advice = {}
local current          -- "corpse" | "healer" | nil
local mine             -- the Nav target we set
local ticker
local noted = false
local previous -- the picked target (Nav override) the death helper replaced

-- Pure decision, for tests and the tick: choice, corpseSeconds, healerSeconds, sickness.
function Death.Decide(corpseYards, healerYards, speed, level, previous)
	speed = speed and speed > 0 and speed or RUN_SPEED
	local sickness = Death.Sickness(level)
	local cs = corpseYards and corpseYards / speed or nil
	local hs = healerYards and (healerYards / speed + sickness) or nil
	if not cs and not hs then return nil end
	if not hs then return "corpse", cs, hs, sickness end
	if not cs then return "healer", cs, hs, sickness end
	local choice = cs <= hs and "corpse" or "healer"
	if previous and previous ~= choice and math.abs(cs - hs) < HYSTERESIS then choice = previous end
	return choice, cs, hs, sickness
end

local function noteFor(a)
	local D = ns.FormatDistance
	if a.choice == "corpse" then
		if a.healerYards and a.sickness > 0 then
			return format(L["Run back to your corpse: %s (~%s). The Spirit Healer costs %s of resurrection sickness."],
				D(a.corpseYards), QoL.Duration(a.corpseSeconds), QoL.Duration(a.sickness))
		end
		return format(L["Run back to your corpse: %s (~%s)."], D(a.corpseYards), QoL.Duration(a.corpseSeconds))
	end
	if a.sickness == 0 then
		return format(L["Resurrect at the Spirit Healer (%s): no resurrection sickness at your level."], D(a.healerYards))
	end
	if a.corpseYards then
		return format(L["Resurrect at the Spirit Healer (%s): your corpse is %s away, longer than %s of sickness."],
			D(a.healerYards), D(a.corpseYards), QoL.Duration(a.sickness))
	end
	return format(L["Resurrect at the Spirit Healer (%s)."], D(a.healerYards))
end

local function point(a)
	local Nav = ns.Nav
	if not (Nav and Nav.SetTarget) then return end
	if Nav.GetTarget and mine and Nav.GetTarget() == mine and a.choice == current then return end
	-- A point picked before dying (a map click, /way, another addon's) is
	-- handed back after resurrecting.
	if not mine and Nav.IsOverride and Nav.IsOverride() then previous = Nav.GetTarget() end
	local C = ns.Compat
	local ok
	if a.choice == "corpse" then
		ok = Nav.SetTarget(a.corpseMap, a.corpseX, a.corpseY, L["Your corpse"])
	else
		-- Live percent on the healer's own map; Era frame if the client cannot convert.
		local x, y = C.WorldToMap(a.healerC, a.healerWX, a.healerWY, a.healerMap)
		if x then
			ok = Nav.SetTarget(a.healerMap, x, y, L["Spirit Healer"])
		else
			ok = Nav.SetTarget(a.healerMap, a.healerEX, a.healerEY, L["Spirit Healer"], "e")
		end
	end
	current = a.choice
	mine = ok and Nav.GetTarget and Nav.GetTarget() or nil
end

local pinned = {}
local function pins(a)
	local P = ns.Pins
	if not (P and P.SetLayer) then return end
	if pinned.choice == a.choice and pinned.hx == a.healerWX and pinned.cx == a.corpseWX then return end
	pinned.choice, pinned.hx, pinned.cx = a.choice, a.healerWX, a.corpseWX
	local list = {}
	if a.healerC then
		list[#list + 1] = { c = a.healerC, wx = a.healerWX, wy = a.healerWY, icon = "qol-spirit", size = 18,
			tooltip = L["Spirit Healer"], priority = a.choice == "healer" and 2 or 1 }
	end
	if a.corpseC then
		list[#list + 1] = { c = a.corpseC, wx = a.corpseWX, wy = a.corpseWY, icon = "qol-corpse", size = 18,
			tooltip = L["Your corpse"], priority = a.choice == "corpse" and 2 or 1 }
	end
	P.SetLayer(LAYER, list, { world = true, minimap = true, edge = true })
end

function Death.Update()
	if not (QoL.On("deathHelper") and isGhost()) then return nil end
	local C = ns.Compat
	local pc, px, py = C.GetPlayerWorldPosition()
	if not pc then return nil end
	local cc, cwx, cwy, cmap, cx, cy = corpse()
	local corpseYards
	if cc == pc then corpseYards = sqrt((cwx - px) ^ 2 + (cwy - py) ^ 2) end
	local hc, hwx, hwy, hmap, hx, hy, healerYards = Death.NearestHealer(pc, px, py)
	local info = C.GetPlayerInfo and C.GetPlayerInfo()
	local choice, cs, hs, sickness = Death.Decide(corpseYards, healerYards, runSpeed(), info and info.level, current)
	if not choice then return nil end
	advice.choice, advice.sickness = choice, sickness
	advice.corpseYards, advice.corpseSeconds = corpseYards, cs
	advice.healerYards, advice.healerSeconds = healerYards, hs
	advice.corpseC, advice.corpseWX, advice.corpseWY = corpseYards and cc, cwx, cwy
	advice.corpseMap, advice.corpseX, advice.corpseY = cmap, cx, cy
	advice.healerC, advice.healerWX, advice.healerWY = hc, hwx, hwy
	advice.healerMap, advice.healerEX, advice.healerEY = hmap, hx, hy
	advice.note = noteFor(advice)
	local changed = choice ~= current
	point(advice)
	pins(advice)
	if not noted or changed then
		noted = true
		ns.Print(advice.note)
	end
	return advice
end

function QoL.GetDeathAdvice()
	if not (QoL.On("deathHelper") and isGhost() and current) then return nil end
	return advice
end

local function release()
	if ticker then
		ticker:Cancel()
		ticker = nil
	end
	local Nav = ns.Nav
	if mine and Nav and Nav.GetTarget and Nav.GetTarget() == mine then
		local E = ns.Engine
		local step = E and E.GetStepIndex and E.GetStepIndex() or nil
		if previous and previous.stepIndex == step then
			-- Picked before dying, on the same guide step: hand it back.
			Nav.SetTarget(previous.map, previous.x, previous.y, previous.label, previous.f, previous.stop, previous.z)
		elseif Nav.ReleaseTarget then
			Nav.ReleaseTarget()
		else
			local wp = E and E.GetWaypoint and E.GetWaypoint()
			if wp then Nav.SetTarget(wp.map, wp.x, wp.y, wp.label, wp.f, nil, wp.z) elseif Nav.ClearTarget then Nav.ClearTarget() end
		end
	end
	mine, current, noted, previous = nil, nil, false, nil
	if ns.Pins and ns.Pins.ClearLayer then ns.Pins.ClearLayer(LAYER) end
	pinned.choice, pinned.hx, pinned.cx = nil, nil, nil
end

local function check()
	if QoL.On("deathHelper") and isGhost() then
		if not ticker and C_Timer and C_Timer.NewTicker then ticker = C_Timer.NewTicker(INTERVAL, Death.Update) end
		Death.Update()
	elseif ticker or mine then
		release()
	end
end
Death.Check = check

ns.RegisterEvent("PLAYER_DEAD", check)
ns.RegisterEvent("PLAYER_ALIVE", check)
ns.RegisterEvent("PLAYER_UNGHOST", check)
ns.RegisterEvent("PLAYER_ENTERING_WORLD", check)
ns.On("SETTING_CHANGED", function(path)
	if path == "qol.deathHelper" or path == "qol" or path == "" then check() end
end)
