-- Note / Tip (spec 5.1): a `note` goal, or the step's tip, typed in the
-- author's language. A task: something Polestar cannot see, ticked by the
-- player.

local ADDON, S = ...
local L = S.L
local UI = S.UI

S.Tools.Register({
	key = "note", label = "Note", icon = "icon-note", kit = "core",
	tip = "An informational line in the step; it never holds the step.",
	run = function()
		if not UI.Ready() then return end
		UI.Prompt({ title = L["Note"], label = L["The note, as the player reads it."], onAccept = function(text)
			UI.Resolve("Note", text)
		end })
	end,
})

S.Tools.Register({
	key = "tip", label = "Step tip", icon = "info", kit = "core", belt = false,
	tip = "Write the selected step's tip.",
	run = function()
		local i = UI.TargetStep()
		if not i then return end
		local st = S.Model.Current().steps[i]
		UI.Prompt({ title = L["Step tip"], label = L["What the player should know on this step."], default = st.note, multi = true, onAccept = function(text)
			S.Model.SetStep(i, "note", text ~= "" and text or nil)
		end })
	end,
})

S.Tools.Register({
	key = "task", label = "Task", icon = "check", kit = "core", belt = false,
	tip = "Something Polestar cannot see (a logout skip, a tame, an emote): the player ticks it.",
	run = function()
		if not UI.Ready() then return end
		UI.Prompt({ title = L["Task"], label = L["What to do, as the player reads it."], onAccept = function(text)
			text = S.OneLine(text)
			if text == "" then return end
			UI.Add({ verb = "task", args = { S.Quote(text) }, mods = {} }, { t = "task", text = text })
		end })
	end,
})
