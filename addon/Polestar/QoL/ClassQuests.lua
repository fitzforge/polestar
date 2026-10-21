-- Class quests: when one of the character's Class guides opens (its level
-- reached and its first quest offered: Engine.StartGate has nothing to wait
-- on) and nothing of it is under way, fires CLASS_QUEST_READY so the guide
-- window's banner offers to open it in a tab. One guide at a time; taking or
-- dismissing it lets the next through. Off with Options, Guide, Automation,
-- Route extras, "Offer class quests" (behavior.offerClassQuests).
--
-- Per-character state in CharState().flags.classOffered (guide id ->):
--   true    offered and taken, or dismissed: never again
--   <level> "Later" at that level: again at a higher level
--
-- Public API:
--   ClassQuests.Ready()        the guides that can be offered now, in list order
--   ClassQuests.Check()        offer the first of them (PLAYER_LEVEL_UP,
--                              QUEST_TURNED_IN, login)
--   ClassQuests.Resolve(id, later)  called by GuideFrame on take, Later or dismiss

local ADDON, ns = ...
local QoL = ns.QoL

local ClassQuests = {}
QoL.ClassQuests = ClassQuests

local function offered()
	local flags = ns.CharState().flags
	if type(flags.classOffered) ~= "table" then flags.classOffered = {} end
	return flags.classOffered
end

-- Whether a quest of guide g is in the log or turned in: the guide is under way.
local function underWay(g)
	local C = ns.Compat
	for _, step in ipairs(g.steps or {}) do
		for _, goal in ipairs(step.goals or {}) do
			local q = goal.quest
			if q and (C.IsOnQuest(q) or C.IsQuestCompleted(q)) then return true end
		end
	end
	return false
end

-- The pending notice: its guide id, so a level-up does not offer it twice.
local pending

function ClassQuests.Ready()
	local G, E, C = ns.Guides, ns.Engine, ns.Compat
	if not (G and G.List and G.Get and G.GuideMatches and E and E.StartGate and E.GetGuideState) then return {} end
	local ok, player = pcall(C.GetPlayerInfo)
	if not (ok and type(player) == "table") then return {} end
	local level = player.level or 1
	local seen = offered()
	local out = {}
	for _, h in ipairs(G.List()) do
		local v = seen[h.id]
		local due = v == nil or (type(v) == "number" and level > v)
		if h.category == "Class" and due and G.GuideMatches(h, player) and E.GetGuideState(h.id) == "new" then
			local g = G.Get(h.id)
			if g and not E.StartGate(h.id) and not underWay(g) then out[#out + 1] = g end
		end
	end
	return out
end

function ClassQuests.Check()
	if not ns.Get("behavior.offerClassQuests") or pending then return end
	local g = ClassQuests.Ready()[1]
	if not g then return end
	pending = g.id
	ns.Fire("CLASS_QUEST_READY", { guideId = g.id, title = g.title or g.id, why = g.why })
end

-- take: opened in a tab; later: "Later" (again at a higher level); neither:
-- dismissed for good. Then the next ready guide, if any.
function ClassQuests.Resolve(id, later)
	if id then
		local level = 1
		local ok, player = pcall(ns.Compat.GetPlayerInfo)
		if ok and type(player) == "table" then level = player.level or 1 end
		offered()[id] = later and level or true
	end
	pending = nil
	ClassQuests.Check()
end

---------------------------------------------------------------------------
-- Events
---------------------------------------------------------------------------

-- After the level-up has reached the player info and the engine's gates.
ns.RegisterEvent("PLAYER_LEVEL_UP", function()
	C_Timer.After(1, function() ns.SafeCall(ClassQuests.Check) end)
end)

-- A prerequisite turned in may open a guide.
ns.RegisterEvent("QUEST_TURNED_IN", function()
	C_Timer.After(1, function() ns.SafeCall(ClassQuests.Check) end)
end)

ns.RegisterEvent("PLAYER_ENTERING_WORLD", function()
	C_Timer.After(3, function() ns.SafeCall(ClassQuests.Check) end)
end)
