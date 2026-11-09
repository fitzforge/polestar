-- Talk / Interact / Use (spec 5.1): the target or the NPC being talked to,
-- the object last clicked or under the mouse, an item from the bags.

local ADDON, S = ...
local L = S.L
local UI = S.UI

S.Tools.Register({
	key = "talk", label = "Talk to the NPC", icon = "icon-talk", kit = "core",
	tip = "Your target, or the NPC whose window is (or was just) open.",
	run = function()
		if not UI.Ready() then return end
		UI.Resolve("Talk", UnitExists("target") and "target" or nil)
	end,
})

S.Tools.Register({
	key = "interact", label = "Click an object", icon = "icon-interact", kit = "core",
	tip = "The object you just opened, or the one under the mouse.",
	run = function()
		if not UI.Ready() then return end
		UI.Resolve("Interact")
	end,
})

S.Tools.Register({
	key = "use", label = "Use an item", icon = "icon-use", kit = "core",
	tip = "Pick an item from your bags (or any item by name).",
	run = function()
		if not UI.Ready() then return end
		UI.PickItem(L["Use"], function(o) UI.Resolve("Use", o.id) end, { noQuests = true })
	end,
})
