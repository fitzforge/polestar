-- Path (spec 5.1): a `path` goal, recorded while walking (a point every 8
-- yards, Position HUD) or clicked point by point on the world map.

local ADDON, S = ...
local L = S.L
local UI = S.UI

S.Tools.Register({
	key = "path", label = "Record a path", icon = "record", kit = "core",
	tip = "Start recording as you walk; again to finish (or Finish on the position HUD).",
	run = function() UI.Recorder.Toggle(UI.Recorder.cycle) end,
})

S.Tools.Register({
	key = "pathmap", label = "Draw a path on the map", icon = "icon-goto", kit = "core", belt = false,
	tip = "Click the points of a path on the world map, then Finish.",
	run = function()
		if not UI.Ready() then return end
		UI.Arm({ label = L["Path"], min = 2, onFinish = function(pts)
			UI.Prompt({ title = L["Path"], label = L["A label for the path (optional)."], onAccept = function(text)
				UI.Resolve("Path", pts, false, text ~= "" and text or nil)
			end })
		end })
	end,
})
