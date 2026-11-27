-- Polestar Group Finder: the door's functions, taken over now that the
-- folder is loaded (Polestar/Quests/GroupFinder.lua lists them).

local _, ns = ...
local L = ns.L
local GroupFinder = ns.P.GroupFinder

GroupFinder.Show = function() ns.UI.Show() end
GroupFinder.Toggle = function() ns.UI.Toggle() end

-- Find a group: with the finder off, the panel says so (Turn on). `questID`:
-- that quest alone.
GroupFinder.Search = function(questID)
	if not ns.Get("enabled") then
		ns.Print(L["The group finder is off. Turn it on in its panel or in Polestar's settings."])
		ns.UI.Show()
		return
	end
	ns.Comm.Search(questID)
end

GroupFinder.Announce = function() ns.Announce.Send() end
-- A goal row's button, a quest menu's row: the panel, and a search for that quest.
GroupFinder.FindFor = function(questID)
	ns.UI.Show()
	GroupFinder.Search(questID)
end
GroupFinder.Hello = function() ns.Hello() end
GroupFinder.Goodbye = function() ns.Goodbye() end

-- /polestar finder [search | stop | announce | on | off | test | reset | debug]
GroupFinder.Command = function(arg)
	local cmd = (arg or ""):lower():match("^%s*(%S*)")
	if cmd == "" then
		ns.UI.Toggle()
	elseif cmd == "search" then
		GroupFinder.Search()
	elseif cmd == "stop" then
		ns.Comm.StopSearch()
	elseif cmd == "announce" then
		ns.Announce.Send()
	elseif cmd == "on" or cmd == "off" then
		ns.SetEnabled(cmd == "on")
	elseif cmd == "test" then
		ns.Channels.Test()
	elseif cmd == "reset" then
		ns.Set("panelPos", false)
		ns.UI.Place()
	elseif cmd == "debug" then
		ns.Set("debug", not ns.Get("debug"))
		ns.Print(ns.Get("debug") and L["Debug on: the finder's traffic and the hidden chat notices show in chat."] or L["Debug off."])
	else
		ns.Print(L["/polestar finder: the panel. Also: search, stop, announce, on, off, test, reset, debug."])
	end
end

-- A message as it would be said now, with your quests (Options' Group Finder page, while loaded).
GroupFinder.PreviewText = function(text) return ns.Messages.Preview(text) end
GroupFinder.HasSampleQuests = function() return #ns.Messages.SampleIds() > 0 end

-- What the effect checks and tests read (rust/crates/forge-addontest effects/groupfinder.lua,
-- tests/group-finder.test.js): the live finder, never its settings.
GroupFinder.Found = function()
	local out = {}
	for _, e in ipairs(ns.Matcher.List()) do out[#out + 1] = e.name end
	return out
end
GroupFinder.Private = ns

GroupFinder.loaded = true
ns.Start()
GroupFinder.Repaint()
