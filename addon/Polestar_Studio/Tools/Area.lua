-- Area (spec 5.1): an `area` goal, the hull of the target's spawns (Codex)
-- or of points clicked on the world map.

local ADDON, S = ...
local L = S.L
local UI = S.UI

S.Tools.Register({
	key = "area", label = "Area of the target's spawns", icon = "layers", kit = "core",
	tip = "Shade where the targeted creature lives (its spawns on this map).",
	run = function()
		if not UI.Ready() then return end
		if not UnitExists("target") then
			UI.Say(L["Target a creature first, or draw the area on the map."], "warning")
			return
		end
		UI.Resolve("Area", "target")
	end,
})

S.Tools.Register({
	key = "areamap", label = "Draw an area on the map", icon = "layers", kit = "core", belt = false,
	tip = "Click 3 or more points around the hunting ground, then Finish.",
	run = function()
		if not UI.Ready() then return end
		UI.Arm({ label = L["Area"], min = 3, onFinish = function(pts)
			UI.Prompt({ title = L["Area"], label = L["A label for the area (optional)."], onAccept = function(text)
				UI.Resolve("Area", pts, text ~= "" and text or nil)
			end })
		end })
	end,
})
