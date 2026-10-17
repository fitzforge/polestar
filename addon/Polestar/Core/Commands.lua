-- Slash commands and key binding labels. Init.lua owns the /polestar
-- dispatcher; every command registers here or in its module, after the
-- locale file, so its help line is read in the client's language.
-- Bindings.xml (addon root) calls into the functions below.

local ADDON, ns = ...

local L = ns.L
local Engine = ns.Engine

BINDING_HEADER_POLESTAR = "Polestar"
BINDING_NAME_POLESTAR_TOGGLE = L["Toggle guide window"]
BINDING_NAME_POLESTAR_NEXT = L["Next step"]
BINDING_NAME_POLESTAR_PREV = L["Previous step"]
BINDING_NAME_POLESTAR_FOCUS = L["Browse the guide with the gamepad"]
BINDING_NAME_POLESTAR_MENU = L["Open the guide menu"]
BINDING_NAME_POLESTAR_OPTIONS = L["Open Polestar options"]
BINDING_NAME_POLESTAR_REPORT = L["Report a problem"]
-- Labels for the QoL secure buttons' CLICK bindings (QoL/Buttons.lua). The
-- client looks these names up as globals; they contain spaces and a colon,
-- so they can only be set through _G.
_G["BINDING_NAME_CLICK PolestarQuestItemButton:LeftButton"] = L["Use quest item"]
_G["BINDING_NAME_CLICK PolestarTargetButton:LeftButton"] = L["Target quest mob"]
_G["BINDING_NAME_CLICK PolestarHearthButton:LeftButton"] = L["Use Hearthstone"]
_G["BINDING_NAME_CLICK PolestarStepButton:LeftButton"] = L["Step action: NPC, quest item, mob or Hearthstone"]
_G["BINDING_NAME_CLICK PolestarTravelButton:LeftButton"] = L["Use the route's Hearthstone or teleport"]

-- Entry points for Bindings.xml (and Polestar's gamepad chords, UI/Gamepad.lua).
ns.Bindings = {
	Toggle = function() ns.Fire("TOGGLE_FRAME") end,
	Next = function() Engine.Next() end,
	Prev = function() Engine.Prev() end,
	Focus = function() ns.Fire("TOGGLE_FOCUS") end,
	Menu = function() ns.Fire("TOGGLE_PICKER") end,
	Options = function() ns.Fire("TOGGLE_OPTIONS") end,
	Report = function() ns.Fire("SHOW_REPORT") end,
}

local function needGuide()
	if Engine.GetGuide() then return true end
	ns.Print(L["No guide selected. Use /polestar guides to pick one."])
	return false
end

ns.RegisterCommand("show", function() ns.Fire("SHOW_FRAME") end, L["Show the guide window"])
ns.RegisterCommand("hide", function() ns.Fire("HIDE_FRAME") end, L["Hide the guide window"])
ns.RegisterCommand("guides", function() ns.Fire("SHOW_PICKER") end, L["Choose a guide"])
ns.RegisterCommand("options", function(rest) ns.Fire("SHOW_OPTIONS", rest ~= "" and rest or nil) end, L["Open settings"])
ns.RegisterCommand("debug", function()
	ns.debug = not ns.debug
	ns.Print(L["Debug output"], ns.debug and L["on"] or L["off"])
end, L["Toggle debug output"])

ns.RegisterCommand("next", function()
	if needGuide() then Engine.Next() end
end, L["Look at the next step (skips nothing)"])

ns.RegisterCommand("prev", function()
	if needGuide() then Engine.Prev() end
end, L["Look at the step before"])

ns.RegisterCommand("skip", function()
	if needGuide() then Engine.Skip() end
end, L["Skip the step shown, for good (the window offers the undo)"])

ns.RegisterCommand("reset", function()
	if not needGuide() then return end
	Engine.ResetProgress()
	ns.Print(L["Cleared ticks, skips and the step you were looking at for this guide."])
end, L["Clear ticks and skips for the current guide"])

ns.RegisterCommand("guide", function(rest)
	local id = rest and rest:match("^%s*(%S+)")
	if not id then
		local g = Engine.GetGuide()
		ns.Print(g and (L["Current guide: %s (%s)"]):format(g.title, g.id) or L["No guide selected."])
		return
	end
	-- Guide ids are lower-case; an exact match still wins.
	local g = ns.Guides.Get(id) or ns.Guides.Get(id:lower())
	if not g then
		ns.Print((L["Unknown guide '%s'."]):format(id))
		return
	end
	Engine.SetGuide(g.id)
	ns.Print((L["Guide: %s"]):format(g.title))
end, L["Switch to a guide by id"])

ns.RegisterCommand("status", function()
	local g = Engine.GetGuide()
	if not g then
		ns.Print(L["No guide selected."])
		return
	end
	local done, total = Engine.GetProgress()
	local i = Engine.GetStepIndex()
	if not i then
		ns.Print((L["%s: complete (%d/%d steps)."]):format(g.title, done, total))
		return
	end
	local view = Engine.GetStepView(i)
	ns.Print((L["%s: step %d of %d (%d/%d done)"]):format(g.title, i, Engine.GetStepCount(), done, total))
	for _, goal in ipairs(view.goals) do
		if goal.status ~= "na" then
			local mark = goal.status == "done" and "|cff4fd1c5[x]|r " or "[ ] "
			local progress = goal.progress and (" (%d/%d)"):format(goal.progress.cur, goal.progress.max) or ""
			DEFAULT_CHAT_FRAME:AddMessage("  " .. mark .. goal.text .. progress)
		end
	end
end, L["Show the current guide and step"])

ns.RegisterCommand("tabs", function()
	local list, active = Engine.GetTabs()
	if #list == 0 then
		ns.Print(L["No guide selected."])
		return
	end
	ns.Print(L["Open guides:"])
	for i, t in ipairs(list) do
		local mark = i == active and "|cff4fd1c5>|r " or "  "
		local state = t.complete and L["complete"] or (L["step %d of %d"]):format(t.stepIndex or 0, t.stepCount)
		DEFAULT_CHAT_FRAME:AddMessage(("%s%d. %s  |cff8a8f98%s|r"):format(mark, i, t.title, state))
	end
end, L["List the open guide tabs"])

ns.RegisterCommand("tab", function(rest)
	local n = tonumber(rest and rest:match("^%s*(%d+)"))
	local list = Engine.GetTabs()
	if not n or not list[n] then
		ns.Print((L["No tab %s; %d open."]):format(tostring(rest ~= "" and rest or "?"), #list))
		return
	end
	Engine.SelectTab(n)
end, L["Switch to guide tab <n>"])

ns.RegisterCommand("close", function()
	local _, active = Engine.GetTabs()
	if active == 0 then
		ns.Print(L["No guide selected."])
		return
	end
	Engine.CloseTab(active)
end, L["Close the current guide tab"])

ns.RegisterCommand("path", function()
	if not Engine.OfferRouteChoice() then
		ns.Print(L["No choice of route here: this guide has one way on."])
	end
end, L["Choose (or change) where to level next"])

ns.RegisterCommand("welcome", function()
	ns.Fire("SHOW_WELCOME")
end, L["Show the welcome again"])

-- Where the player stands, as guide lines ready to paste into a step: the
-- map (`zone map <uiMapID>`) and a goal there (`goto x,y live`, two decimals
-- like the compiler writes). The client reports live-frame coordinates, and
-- typed coordinates are read in the Era frame unless marked, so the goal
-- modifier `live` goes with them (Forever moved some zones). Printed with a
-- hint for other goals (`@x,y live`), and shown in a box to copy (UI/Copy.lua).
ns.RegisterCommand("where", function()
	local C = ns.Compat
	local map, x, y
	if C and C.GetPlayerMapPosition then map, x, y = C.GetPlayerMapPosition() end
	if not (map and x and y) then
		ns.Print(L["No position here: the game gives none in instances and on some maps."])
		return
	end
	local xy = ("%.2f,%.2f live"):format(x, y)
	local lines = { ("zone map %d"):format(map), "goto " .. xy }
	for i = 1, #lines do ns.Print(lines[i]) end
	ns.Print((L["For another goal, add %s"]):format("@" .. xy))
	ns.Fire("SHOW_COPY", L["Your position"], table.concat(lines, "\n"))
end, L["Print your map and position as guide lines"])

ns.RegisterCommand("report", function() ns.Fire("SHOW_REPORT") end, L["Report a problem with the step on screen"])
ns.RegisterCommand("discord", function() ns.Fire("SHOW_DISCORD") end, L["The invite to the Polestar Discord"])

ns.RegisterCommand("packs", function() ns.Fire("SHOW_OPTIONS", "guidepacks") end, L["Open the Community guides page"])
ns.RegisterCommand("gamepad", function() ns.Fire("SHOW_OPTIONS", "gamepad") end, L["Open the Gamepad page: button names and bindings"])
