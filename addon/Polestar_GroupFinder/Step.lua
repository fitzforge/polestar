-- Polestar Group Finder: the guide's live step.
--
-- The quests of the live step come first in a search and in the list
-- (Quests.Relevant, Matcher), and open the panel near their objective
-- (Nearby.lua). Read from the Engine (Engine.GetGuide / GetLiveStep, the
-- step's goals' `quest`) and the Compat layer, kept until the step, the guide
-- or the tabs change, or the quest log does.

local _, ns = ...
local P = ns.P

local stepCache, stepDirty = {}, true

-- The quests of the live step that are in the log and not ready to hand in
-- (ids, in the step's order).
function ns.PolestarStepQuests()
	if not stepDirty then return stepCache end
	stepDirty = false
	local out = {}
	local E, C = P.Engine, P.Compat
	local g = E.GetGuide()
	local i = g and E.GetLiveStep()
	local step = i and type(g.steps) == "table" and g.steps[i]
	if type(step) == "table" and type(step.goals) == "table" then
		local seen = {}
		for _, goal in ipairs(step.goals) do
			local id = type(goal) == "table" and tonumber(goal.quest)
			if id and not seen[id] and C.IsOnQuest(id) and not C.IsQuestReadyForTurnIn(id) then
				seen[id] = true
				out[#out + 1] = id
			end
		end
	end
	stepCache = out
	return stepCache
end

local function dirty()
	stepDirty = true
	ns.Fire("POLESTAR_STEP")
end
for _, msg in ipairs({ "STEP_CHANGED", "GUIDE_CHANGED", "TABS_CHANGED" }) do P.On(msg, dirty) end
ns.RegisterEvent("QUEST_LOG_UPDATE", function() stepDirty = true end)
ns.On("POLESTAR_STEP", function() if ns.UI then ns.UI.Refresh() end end)
