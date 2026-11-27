-- Polestar Group Finder: opening the panel near a quest's objective.
--
-- With the option `openNear` (off by default), the panel opens when
-- Polestar's arrow has brought you within NEAR yards of the live step's
-- objective, for a step whose quest is worth a group (kill, named, loot,
-- group), once per step: Find a group is then one click away. It only opens
-- the panel; nothing is sent, the search stays a click. Never in combat or
-- in an instance, and not while the panel (or the quest panel) is already
-- on screen.
-- Polestar.Nav.GetDistance (yards to the arrow's target, 0 inside an area
-- objective) is INTERNAL: read under pcall; without it nothing happens.

local _, ns = ...
local L = ns.L

local Nearby = {}
ns.Nearby = Nearby

local NEAR = 120   -- yards
local EVERY = 2    -- seconds between two looks
local opened = {}  -- step key -> true: already opened for that step

-- The live step's quests worth a group, and a key naming that step.
local function stepQuests()
	local ids, out = ns.PolestarStepQuests and ns.PolestarStepQuests() or {}, {}
	for _, id in ipairs(ids) do
		if ns.Quests.Kind(id) then out[#out + 1] = id end
	end
	return out, table.concat(out, ",")
end

local function distance()
	local N = Polestar and Polestar.Nav
	if not (N and type(N.GetDistance) == "function") then return nil end
	local ok, d = pcall(N.GetDistance)
	return ok and tonumber(d) or nil
end

-- One look: opens the panel when it should; returns true when it did.
function Nearby.Check()
	if not (ns.Get("enabled") and ns.Get("openNear")) then return false end
	if (InCombatLockdown and InCombatLockdown()) or (IsInInstance and IsInInstance()) then return false end
	if ns.UI.IsShown() or (ns.QuestUI and ns.QuestUI.IsShown()) then return false end
	local quests, key = stepQuests()
	if #quests == 0 or opened[key] then return false end
	local d = distance()
	if not (d and d <= NEAR) then return false end
	opened[key] = true
	ns.UI.Show()
	ns.Debug(L["Near %s: the finder is open, Find a group is one click away."], ns.Quests.Title(quests[1]))
	return true
end

-- The demo: every step may open the panel again.
function Nearby.Reset() wipe(opened) end

ns.On("POLESTAR", function()
	local function tick()
		pcall(Nearby.Check)
		ns.After(EVERY, tick)
	end
	ns.After(EVERY, tick)
end)
