-- Slash commands and key binding labels. Init.lua owns the /polestar
-- dispatcher; every command registers here or in its module, after the
-- locale file, so its help line is read in the client's language.
-- Bindings.xml (addon root) calls into the functions below.

local ADDON, ns = ...

local L = ns.L
local Engine = ns.Engine

-- Options > Keybindings lists them in a "Polestar" section of their own
-- (Bindings.xml's category, the Recorder's too), whose rows are only ~22
-- characters wide: short names. None has searchTags: after login the game
-- builds the Options search's list of bindings and reads each tag's global
-- outside securecallfunction (Blizzard_SettingsDefinitions_Frame/
-- Keybindings.lua, CreateSearchableSettings), so a tag global of ours
-- tainted every search, and the game blocked the Discord sign-in row's
-- C_Discord.IsUserOAuthed() in its results, blaming Polestar or the
-- Recorder (#1996, #2207). The search finds a binding by its name.
BINDING_NAME_POLESTAR_TOGGLE = L["Toggle guide window"]
BINDING_NAME_POLESTAR_HIDE = L["Hide/show Polestar"]
BINDING_NAME_POLESTAR_NEXT = L["Next step"]
BINDING_NAME_POLESTAR_PREV = L["Previous step"]
BINDING_NAME_POLESTAR_FOCUS = L["Browse guide (gamepad)"]
BINDING_NAME_POLESTAR_MENU = L["Open the guide menu"]
BINDING_NAME_POLESTAR_OPTIONS = L["Open Polestar options"]
BINDING_NAME_POLESTAR_REPORT = L["Report a problem"]
BINDING_NAME_POLESTAR_NEXT_WAYPOINT = L["Next waypoint"]
BINDING_NAME_POLESTAR_PREV_WAYPOINT = L["Previous waypoint"]
BINDING_NAME_POLESTAR_REOPEN_TAB = L["Reopen closed tab"]
BINDING_NAME_POLESTAR_PAUSE = L["Pause the guide"]
-- The item under the cursor (QoL/Marks.lua, Marks.Press).
BINDING_NAME_POLESTAR_MARK_JUNK = L["Mark as junk"]
BINDING_NAME_POLESTAR_MARK_KEEP = L["Mark to keep"]
-- Labels for the QoL secure buttons' CLICK bindings (QoL/Buttons.lua). The
-- client looks these names up as globals; they contain spaces and a colon,
-- so they can only be set through _G.
_G["BINDING_NAME_CLICK PolestarQuestItemButton:LeftButton"] = L["Use quest item"]
_G["BINDING_NAME_CLICK PolestarTargetButton:LeftButton"] = L["Target quest mob"]
_G["BINDING_NAME_CLICK PolestarRareButton:LeftButton"] = L["Target rare"]
_G["BINDING_NAME_CLICK PolestarHearthButton:LeftButton"] = L["Use Hearthstone"]
_G["BINDING_NAME_CLICK PolestarStepButton:LeftButton"] = L["Use the step button"]
_G["BINDING_NAME_CLICK PolestarTravelButton:LeftButton"] = L["Use the travel button"]
_G["BINDING_NAME_CLICK PolestarBagButton:LeftButton"] = L["Delete cheapest junk"]

-- Entry points for Bindings.xml (and Polestar's gamepad chords, UI/Gamepad.lua).
-- A key that opens a window brings a hidden Polestar back first (the toggle
-- of the guide window does it in UI/UI.lua's TOGGLE_FRAME). -> true when it did
local function unhide()
	if not ns.Hidden() then return false end
	ns.SetHidden(false)
	return true
end
ns.Bindings = {
	Toggle = function() ns.Fire("TOGGLE_FRAME") end,
	Hide = function() ns.ToggleHidden() end,
	Next = function() Engine.Next() end,
	Prev = function() Engine.Prev() end,
	Focus = function() unhide(); ns.Fire("TOGGLE_FOCUS") end,
	-- A window open out of sight comes back with Polestar: shown, not toggled shut.
	Menu = function() ns.Fire(unhide() and "SHOW_PICKER" or "TOGGLE_PICKER") end,
	Options = function() ns.Fire(unhide() and "SHOW_OPTIONS" or "TOGGLE_OPTIONS") end,
	Report = function() unhide(); ns.Fire("SHOW_REPORT") end,
	-- The arrow to the step's next or previous place: spawn spot, else goal.
	NextWaypoint = function() Engine.CycleWaypoint(1) end,
	PrevWaypoint = function() Engine.CycleWaypoint(-1) end,
	ReopenTab = function() ns.RunCommand("reopen") end,
	-- Pause or resume (Core/Pause.lua); it leaves hiding as it is.
	Pause = function() ns.TogglePaused() end,
	-- Junk or keep mark on the item under the cursor, or off again.
	MarkJunk = function() local M = ns.QoL and ns.QoL.Marks; if M then M.Press("junk") end end,
	MarkKeep = function() local M = ns.QoL and ns.QoL.Marks; if M then M.Press("keep") end end,
}

local function needGuide()
	if Engine.GetGuide() then return true end
	ns.Print(L["No guide selected. Use /polestar guides to pick one."])
	return false
end

ns.RegisterCommand("show", function() ns.Fire("SHOW_FRAME") end, L["Show the guide window"])
-- Quiet: it toggles the hidden state itself (Polestar.SetHidden).
ns.RegisterCommand("hide", function(rest)
	if (rest or ""):lower() == "arrow" then
		ns.SetHideKeepsArrow(not ns.HideKeepsArrow())
		ns.Print(ns.HideKeepsArrow() and L["Hiding Polestar keeps the arrow."] or L["Hiding Polestar hides the arrow too."])
		return
	end
	ns.ToggleHidden()
	if ns.Hidden() then ns.Print(L["Polestar is hidden: /polestar hide or the minimap button shows it again."]) end
end, L["Hide or show everything Polestar shows (hide arrow: keep the arrow when hidden)"], true)
ns.RegisterCommand("guides", function() ns.Fire("SHOW_PICKER") end, L["Choose a guide"])
ns.RegisterCommand("options", function(rest) ns.Fire("SHOW_OPTIONS", rest ~= "" and rest or nil) end, L["Open settings"])
ns.RegisterCommand("debug", function()
	ns.debug = not ns.debug
	ns.Print(L["Debug output"], ns.debug and L["on"] or L["off"])
end, L["Toggle debug output"], true)

ns.RegisterCommand("next", function()
	if needGuide() then Engine.Next() end
end, L["Look at the next step (skips nothing)"])

ns.RegisterCommand("prev", function()
	if needGuide() then Engine.Prev() end
end, L["Look at the step before"])

ns.RegisterCommand("skip", function()
	if needGuide() and not Engine.Skip() then ns.Print(L["Nothing to skip: the guide has no step open."]) end
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
		ns.Print(g and (L["Current guide: %s (%s)"]):format(g.title, ns.EscapeText(g.id)) or L["No guide selected."])
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
	ns.Print((L["%s: step %d of %d (%d/%d done)"]):format(g.title, (Engine.StepNumber(i)), Engine.StepTotal(), done, total))
	for _, goal in ipairs(view.goals) do
		if goal.status ~= "na" then
			local mark = goal.status == "done" and "|cff4fd1c5[x]|r " or "[ ] "
			local progress = goal.progress and (" (%d/%d)"):format(goal.progress.cur, goal.progress.max) or ""
			DEFAULT_CHAT_FRAME:AddMessage("  " .. mark .. goal.text .. progress)
		end
	end
end, L["Show the current guide and step"], true)

ns.RegisterCommand("tabs", function()
	local list, active = Engine.GetTabs()
	if #list == 0 then
		ns.Print(L["No guide selected."])
		return
	end
	ns.Print(L["Open guides:"])
	for i, t in ipairs(list) do
		local mark = i == active and "|cff4fd1c5>|r " or "  "
		local state = t.complete and L["complete"] or (L["step %d of %d"]):format(t.stepNumber or t.stepIndex or 0, t.stepTotal or t.stepCount)
		DEFAULT_CHAT_FRAME:AddMessage(("%s%d. %s  |cff8a8f98%s|r"):format(mark, i, t.title, state))
	end
end, L["List the open guide tabs"], true)

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

-- The last tab closed, back where it was (Engine.ReopenClosedTab).
ns.RegisterCommand("reopen", function()
	if Engine.ReopenClosedTab() then return end
	local closed = Engine.ClosedTabs()
	ns.Print(#closed == 0 and L["No closed tab to reopen."] or L["Six tabs is the limit. Close one to open another."])
end, L["Reopen the last guide tab you closed"])

ns.RegisterCommand("path", function()
	if not Engine.OfferRouteChoice() then
		ns.Print(L["No choice of route here: this guide has one way on."])
	end
end, L["Choose (or change) where to level next"])

-- Install (UI/Welcome.lua): every page, whenever asked; `welcome`, its name
-- before, still opens it.
local function showInstall() ns.Fire("SHOW_WELCOME") end
ns.RegisterCommand("install", showInstall, L["Set Polestar up again, a page at a time (Install)"])
ns.RegisterCommand("welcome", showInstall, L["Opens Install, as /polestar install does"])

ns.RegisterCommand("whatsnew", function()
	ns.Fire("SHOW_WHATSNEW")
end, L["Show what's new in this version"])

-- Where the player stands as guide lines (ns.WhereLines, Core/Compat.lua),
-- printed with a hint for other goals (`@x,y live`), and shown in a box to
-- copy (UI/Copy.lua).
ns.RegisterCommand("where", function()
	local lines, xy = ns.WhereLines()
	if not lines then
		ns.Print(L["No position here: the game gives none in instances and on some maps."])
		return
	end
	for i = 1, #lines do ns.Print(lines[i]) end
	ns.Print((L["For another goal, add %s"]):format("@" .. xy))
	ns.Fire("SHOW_COPY", L["Your position"], table.concat(lines, "\n"))
end, L["Print your map and position as guide lines"])

ns.RegisterCommand("questlog", function() ns.Fire("SHOW_QUEST_ROOM") end, L["List the quests in your log the route never hands in"])

ns.RegisterCommand("report", function() ns.Fire("SHOW_REPORT") end, L["Report a problem with the step on screen"])
ns.RegisterCommand("discord", function() ns.Fire("SHOW_DISCORD") end, L["The invite to the Polestar Discord"])

ns.RegisterCommand("packs", function() ns.Fire("SHOW_OPTIONS", "guidepacks") end, L["Open the Community guides page"])
ns.RegisterCommand("gamepad", function() ns.Fire("SHOW_OPTIONS", "gamepad") end, L["Open the Gamepad page: button names and bindings"])
