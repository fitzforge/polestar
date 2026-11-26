-- The finished-quest guide's door. Checking the menu costs only a log read;
-- routing, refresh handlers and guide construction load on first open.
local ADDON, ns = ...
local L, Lookup = ns.L, ns.Lookup
local Handins = {}
ns.Handins = Handins

function Handins.Ready()
	local ids = ns.RoutePlan.Ready()
	table.sort(ids)
	return ids
end

local build, start
local function load()
	local ok, why = ns.Data.Pack("Polestar_FreeMode")
	if not ok then return nil, why end
	if Handins.BuildGuide == build or Handins.Start == start then return nil, "error" end
	return true
end

build = function()
	local ok, why = load()
	if not ok then return nil, why end
	return Handins.BuildGuide()
end
Handins.BuildGuide = build

start = function()
	if #Handins.Ready() == 0 then
		ns.Print(L["No quests in your log are ready to hand in."])
		return nil, "nothing"
	end
	local ok, why = load()
	if ok then return Handins.Start() end
	if why == "combat" then
		ns.Print(L["Wait until combat ends to load the quest data."])
	else
		ns.Print(L["The hand-in guide could not load. Check that the Polestar_FreeMode addon is installed and enabled."])
	end
	return nil, why
end
Handins.Start = start

-- Lookup restores saved tabs before login, so this registration stays in core.
Lookup.RegisterPlanner("carried", function(id)
	if id ~= "log" then return nil, "unknown" end
	return Handins.BuildGuide()
end)
