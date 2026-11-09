-- Leveling toolkit (spec 5.2): level goals (`level 12.5`), class/race
-- branches, the quest log panel, auto-capture, breadcrumb/closedBy warnings.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local P = _G.Polestar
local format, ipairs, pairs, tostring, tonumber, floor = string.format, ipairs, pairs, tostring, tonumber, math.floor

S.Tools.Register({
	key = "level", label = "Level goal", icon = "icon-level", kit = "leveling",
	tip = "Reach a level: 12, or 12.5 for halfway through 12.",
	run = function()
		if not UI.Ready() then return end
		local lvl = UnitLevel and UnitLevel("player") or 1
		local xp, top = UnitXP and UnitXP("player") or 0, UnitXPMax and UnitXPMax("player") or 1
		local now = lvl + (top > 0 and floor(xp / top * 100) / 100 or 0)
		UI.Prompt({ title = L["Level"], label = L["Level to reach: 12, or 12.5 for halfway through level 12."], default = now, onAccept = function(text)
			UI.Resolve("Level", tonumber(text))
		end })
	end,
})

S.Tools.Register({
	key = "branch", label = "Class or race branch", icon = "lock", kit = "leveling",
	tip = "A new step only for some classes or races (\"this step only for Mages\").",
	run = function()
		local d = S.Model.Current()
		if not d then return UI.Say(L["Start or open a guide first."], "warning") end
		local i = S.Model.Selected()
		local items = {}
		local function add(kind, list)
			for _, v in ipairs(list) do
				items[#items + 1] = { text = L[v], onClick = function()
					local k = S.Model.AddStep(format(L["%s only"], L[v]), i and i + 1 or nil)
					if k then
						S.Model.SetStep(k, "only", { [kind] = { v } })
						S.Model.Select(k, nil)
					end
				end }
			end
		end
		add("classes", UI.CLASSES)
		items[#items + 1] = { separator = true }
		add("races", UI.RACES)
		UI.Menu(UI.CursorAnchor(), items)
	end,
})

S.Tools.Register({
	key = "questlog", label = "Quest log panel", icon = "icon-accept", kit = "leveling",
	tip = "Every quest in your log with Accept, Complete, Turn in and objective buttons.",
	run = function() UI.ToggleWidget("QuestPanel") end,
})

S.Tools.Register({
	key = "capture", label = "Auto-capture", icon = "record", kit = "leveling",
	tip = "While on, accepts, turn-ins, flight paths, binds and kills add goals as you play.",
	run = function()
		local C = S.Capture
		if not (C and C.SetEnabled) then return end
		C.SetEnabled(not C.Enabled())
		UI.Say(C.Enabled() and L["Auto-capture on."] or L["Auto-capture off."], "success")
		if UI.Refresh then UI.Refresh() end
	end,
})

-- Breadcrumbs: an accept whose quest closes (or is closed by) another quest
-- the guide also accepts: the player can only do one of them.
S.Tools.Register({
	key = "breadcrumbs", label = "Breadcrumb check", icon = "info", kit = "leveling",
	tip = "Warns about accepted quests that shut each other out (breadcrumbs, closedBy).",
	run = function()
		local d = S.Model.Current()
		if not d then return end
		local accepted = {}
		for i, st in ipairs(d.steps) do
			for j, g in ipairs(st.goals or {}) do
				local o = g.out or {}
				if o.t == "accept" and o.quest then accepted[o.quest] = { i = i, j = j, closedBy = o.closedBy } end
			end
		end
		local found = 0
		for q, a in pairs(accepted) do
			for _, other in ipairs(a.closedBy or {}) do
				if accepted[other] then
					found = found + 1
					UI.Say(format(L["Step %d: quest %d is closed by quest %d, which step %d accepts: a player can only take one."], a.i, q, other, accepted[other].i), "warning")
				end
			end
		end
		if found == 0 then UI.Say(L["No breadcrumb conflicts among the accepted quests."], "success") end
	end,
})
