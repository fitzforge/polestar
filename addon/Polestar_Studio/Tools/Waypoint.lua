-- Waypoint (spec 5.1): `goto x,y "label"` from the live position, with the
-- subzone as its label (the compiler then finds its area id); or a point
-- clicked on the world map. Place: move the selected goal to a map click.

local ADDON, S = ...
local L = S.L
local UI = S.UI
local format, floor = string.format, math.floor

S.Tools.Register({
	key = "waypoint", label = "Waypoint here", icon = "icon-goto", kit = "core",
	tip = "A goto at your position, labelled with the subzone you stand in.",
	run = function()
		if not UI.Ready() then return end
		local sub = GetSubZoneText and GetSubZoneText()
		UI.Resolve("Goto", sub ~= "" and sub or nil)
	end,
})

S.Tools.Register({
	key = "waypointmap", label = "Waypoint on the map", icon = "flag", kit = "core", belt = false,
	tip = "Click a point on the world map: a goto there.",
	run = function()
		if not UI.Ready() then return end
		UI.Arm({ label = L["Click the map where the waypoint goes (right-click cancels)."], single = true, onFinish = function(pts)
			local p = pts[1]
			if not p then return end
			UI.Prompt({ title = L["Waypoint"], label = L["A label for the waypoint (optional): a place name as the game spells it."], onAccept = function(text)
				UI.Add(UI.GotoAt(p.map, p.x, p.y, text ~= "" and text or nil))
			end })
		end })
	end,
})

-- Put the selected goal's coordinates where the author clicks.
S.Tools.Register({
	key = "place", label = "Place the selected goal on the map", icon = "plus", kit = "core", belt = false,
	tip = "Click the world map: the selected goal's coordinates move there.",
	run = function()
		if not UI.Ready() then return end
		local i, j = S.Model.Selected()
		local d = S.Model.Current()
		local g = d and i and j and d.steps[i] and d.steps[i].goals[j]
		if not g then
			UI.Say(L["Select a goal first."], "warning")
			return
		end
		UI.Arm({ label = format(L["Click where %s goes."], UI.GoalText(g)), single = true, onFinish = function(pts)
			local p = pts[1]
			if not p then return end
			local src, out = UI.Copy(g.src), UI.Copy(g.out or {})
			local xy = format("%.2f,%.2f", p.x, p.y)
			if src.verb == "goto" or src.verb == "explore" then
				src.args = src.args or {}
				src.args[1] = xy
			elseif src.verb == "path" or src.verb == "area" then
				UI.Say(L["Paths and areas are drawn: use their own tools."], "warning")
				return
			else
				UI.SetMod(src, "at", { "@" .. xy })
			end
			UI.SetMod(src, "map", { p.map })
			UI.SetMod(src, "frame", { "live" })
			out.map, out.x, out.y, out.f = p.map, floor(p.x * 100 + 0.5) / 100, floor(p.y * 100 + 0.5) / 100, nil
			out.z = nil
			S.Model.UpdateGoal(i, j, src, out)
			UI.Say(format(L["Placed at %s."], UI.Where(out) or xy), "success")
		end })
	end,
})
