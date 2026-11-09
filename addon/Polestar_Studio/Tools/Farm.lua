-- Farm / gold loop toolkit (spec 5.2): record a loop path, turn the
-- selected path into a loop, collect N of an item here, sell and repair at
-- the nearest vendor, and buy at the nearest vendor. (`collect … nearest`
-- farm spots need the checker's compile: Studio does not offer it.)

local ADDON, S = ...
local L = S.L
local UI = S.UI
local ipairs, tostring, tonumber = ipairs, tostring, tonumber

local function itemPicker(title, onPick)
	UI.Pick({ title = title, hint = L["Type part of its name."], items = function(q)
		local out = {}
		for _, r in ipairs(UI.SearchCodex("item", q, 60)) do out[#out + 1] = { text = r.name, sub = tostring(r.id), value = r.id } end
		return out
	end, onPick = onPick })
end

S.Tools.Register({
	key = "looppath", label = "Record a loop", icon = "record", kit = "farm",
	tip = "Walk the loop: a path that starts over at its end.",
	run = function()
		if not UI.Ready() then return end
		if UI.Recorder and UI.Recorder.Start then
			UI.Recorder.Start(true)
		else
			UI.Say(L["The path recorder is not available."], "warning")
		end
	end,
})

S.Tools.Register({
	key = "makeloop", label = "Make the path a loop", icon = "hourglass", kit = "farm", belt = false,
	tip = "The selected path goal starts over at its end (or stops doing so).",
	run = function()
		local doc = S.Model.Current()
		local i, j = S.Model.Selected()
		local goal = doc and i and j and doc.steps[i].goals[j]
		if not (goal and goal.src and goal.src.verb == "path") then
			UI.Say(L["Select a path goal first."], "warning")
			return
		end
		local src, out = S.Copy(goal.src), S.Copy(goal.out or {})
		local on = not out.cycle
		UI.SetMod(src, "cycle", on and {} or nil)
		out.cycle = on or nil
		S.Model.UpdateGoal(i, j, src, out)
		UI.Say(on and L["The path is a loop."] or L["The path is no longer a loop."], "success")
	end,
})

S.Tools.Register({
	key = "farmcollect", label = "Collect N here", icon = "icon-collect", kit = "farm",
	tip = "Farm an item where you stand until the bags hold N.",
	run = function()
		if not UI.Ready() then return end
		itemPicker(L["Which item?"], function(it)
			UI.Prompt({ title = it.text, label = L["How many?"], default = "20", onAccept = function(text)
				UI.Resolve("Collect", it.value, math.floor(tonumber(text) or 1))
			end })
		end)
	end,
})

S.Tools.Register({
	key = "vendornearest", label = "Sell and repair (nearest)", icon = "icon-vendor", kit = "farm",
	tip = "Polestar leads to the nearest vendor who repairs.",
	run = function()
		if not UI.Ready() then return end
		UI.Resolve("Vendor", "nearest")
	end,
})

S.Tools.Register({
	key = "vendorhere", label = "Sell and repair here", icon = "icon-vendor", kit = "farm", belt = false,
	tip = "The vendor whose window is open.",
	run = function()
		if not UI.Ready() then return end
		UI.Resolve("Vendor")
	end,
})

S.Tools.Register({
	key = "lap", label = "Count a lap", icon = "check", kit = "farm", belt = false,
	tip = "Mark the end of one loop in the Session widget, for the yield per loop.",
	run = function()
		if UI.Session and UI.Session.Lap then UI.Session.Lap() else UI.Say(L["The Session widget is not available."], "warning") end
	end,
})
