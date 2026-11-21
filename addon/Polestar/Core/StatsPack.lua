-- The Stats page's door in core. What counts and what draws it are an addon
-- of their own, Polestar_Stats (load on demand), with the character's
-- counts in its own saved table: nothing of it is in memory while
-- stats.enabled is off and the page is not opened, and a player who does
-- not want it leaves the folder out or unticks it in the AddOns list. This
-- file is what stays resident:
--
--   ns.StatsPack.Installed() -> the addon is there and enabled
--   ns.StatsPack.Load() -> loaded, reason (Data.Pack's; never in combat)
--   the stats.* defaults (saved settings before the addon exists)
--   SHOW_STATS and /polestar stats, which load it and open the page
--
-- At login it loads while stats.enabled is on (after a fight, when the
-- login was in one), and when the setting is turned on later.

local _, ns = ...
local L = ns.L

local PACK = "Polestar_Stats"

local SP = {}
ns.StatsPack = SP

-- The parts of what is counted, each with a switch of its own (stats.<part>).
SP.PARTS = { "activity", "xp", "quests", "fights", "money", "heat", "path", "travel", "character" }

do
	local d = { enabled = true, page = "activity", layer = "p", completion = "Q" }
	for _, part in ipairs(SP.PARTS) do d[part] = true end
	ns.RegisterDefaults("stats", d)
end

-- An addon that loads on demand, not loaded yet, reads as not loadable with
-- the reason "DEMAND_LOADED" (Maps/Arcade.lua reads it the same way).
local ON_DEMAND = { DEMAND_LOADED = true, DEP_DEMAND_LOADED = true }
local installed
function SP.Installed()
	if installed ~= nil then return installed end
	local A = C_AddOns
	if ns.Compat.AddOnPresent(PACK) then
		installed = true
	elseif A and A.GetAddOnInfo then
		local ok, _, _, _, loadable, reason = pcall(A.GetAddOnInfo, PACK)
		installed = ok and (loadable or ON_DEMAND[reason]) and true or false
	else
		installed = false
	end
	return installed
end

function SP.Load()
	if ns.Stats then return true end
	if not SP.Installed() then return false, "missing" end
	local ok, why = ns.Data.Pack(PACK)
	if not ok then return false, why end
	return ns.Stats ~= nil, ns.Stats == nil and "error" or nil
end

-- A load asked for in a fight waits for its end; `open` then shows the page.
local waiting, open = false, false
local function afterCombat()
	ns.UnregisterEvent("PLAYER_REGEN_ENABLED", afterCombat)
	waiting = false
	local show = open
	open = false
	if SP.Load() and show then ns.Stats.Show() end
end

local function load(show)
	local ok, why = SP.Load()
	if ok then return true end
	if why == "combat" then
		open = open or show
		if not waiting then
			waiting = true
			ns.RegisterEvent("PLAYER_REGEN_ENABLED", afterCombat)
		end
	end
	return false, why
end

ns.OnLogin(function()
	if ns.Get("stats.enabled") then load(false) end
end)

ns.On("SETTING_CHANGED", function(path)
	if ns.Stats or not ns.IsLoggedIn() then return end
	if (path == "stats.enabled" or path == "stats" or path == "") and ns.Get("stats.enabled") then load(false) end
end)

ns.On("SHOW_STATS", function()
	local ok, why = load(true)
	if ok then
		ns.Stats.Show()
	elseif why == "combat" then
		ns.Print(L["Stats opens when combat ends."])
	end
end)

if SP.Installed() then
	ns.RegisterCommand("stats", function() ns.Fire("SHOW_STATS") end, L["Show your stats"])
end
