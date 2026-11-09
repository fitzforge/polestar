-- Conditions (spec 5.1): `only` (who a step is for, from pickers), `when`
-- (a predicate checked during play), and the selected goal's `optional`
-- and `group N`.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local format, tonumber = string.format, tonumber

local anchor
local function cursorAnchor()
	if not anchor then
		anchor = CreateFrame("Frame", nil, UIParent)
		anchor:SetSize(1, 1)
	end
	local x, y = GetCursorPosition()
	local s = UIParent:GetEffectiveScale()
	anchor:ClearAllPoints()
	anchor:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", x / s, y / s)
	return anchor
end
UI.CursorAnchor = cursorAnchor

local function selectedGoal()
	local i, j = S.Model.Selected()
	local d = S.Model.Current()
	local g = d and i and j and d.steps[i] and d.steps[i].goals[j]
	if not g then UI.Say(L["Select a goal first."], "warning") end
	return g and i, j, g
end

S.Tools.Register({
	key = "only", label = "Step only for…", icon = "lock", kit = "core",
	tip = "This step only for some classes, races or a faction (picked).",
	run = function()
		local i = UI.TargetStep()
		if not i then return end
		UI.OnlyMenu(cursorAnchor(), function() return S.Model.Current().steps[i].only end, function(only)
			S.Model.SetStep(i, "only", only)
			UI.Say(format(L["Step %d is for: %s"], i, UI.OnlySummary(only)), "success")
		end)
	end,
})

S.Tools.Register({
	key = "when", label = "Step when…", icon = "hourglass", kit = "core", belt = false,
	tip = "The step applies only while a predicate holds: level<12, onquest 783, has 2589 x10…",
	run = function()
		local i = UI.TargetStep()
		if not i then return end
		local st = S.Model.Current().steps[i]
		UI.Prompt({ title = L["When"], label = L["Predicates, separated by ;  (level<12; onquest 783; turnedin 54; has 2589 x10; zone \"Duskwood\")"],
			default = type(st.when) == "table" and table.concat(st.when, "; ") or nil, onAccept = function(text)
				local list = {}
				for raw in text:gmatch("[^;]+") do
					local part = raw:match("^%s*(.-)%s*$")
					if part ~= "" then
						if S.Serialize and S.Serialize.ParseWhen then
							local pred, why = S.Serialize.ParseWhen(part)
							if not pred then UI.Say(format(L["\"%s\": %s"], part, tostring(why)), "warning") end
						end
						list[#list + 1] = part
					end
				end
				S.Model.SetStep(i, "when", #list > 0 and list or nil)
			end })
	end,
})

S.Tools.Register({
	key = "optional", label = "Goal optional", icon = "skip", kit = "core", belt = false,
	tip = "The selected goal never holds the step (again: required).",
	run = function()
		local i, j, g = selectedGoal()
		if not g then return end
		local on = not UI.Mod(g.src, "optional")
		UI.SetGoalMod(i, j, "optional", on and {} or nil)
		UI.Say(on and L["Optional."] or L["Required."], "success")
	end,
})

S.Tools.Register({
	key = "group", label = "Goal needs a group", icon = "plug", kit = "core", belt = false,
	tip = "The selected goal needs a group (of N players).",
	run = function()
		local i, j, g = selectedGoal()
		if not g then return end
		local m = UI.Mod(g.src, "group")
		UI.Prompt({ title = L["Group"], label = L["Group size, 2 to 40 (blank: a group; 0: no group)."], default = m and m[2] or "", onAccept = function(text)
			local n = tonumber(text)
			if n == 0 then UI.SetGoalMod(i, j, "group", nil)
			elseif n and n >= 2 and n <= 40 then UI.SetGoalMod(i, j, "group", { n })
			else UI.SetGoalMod(i, j, "group", {}) end
		end })
	end,
})
