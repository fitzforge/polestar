-- The Stats settings on the Discovery options page's Stats tab
-- (docs/ARCHITECTURE.md, "Options registry"), there while the Stats addon
-- (Polestar_Stats) is installed. stats.enabled switches it off: nothing more
-- is counted, the addon is not loaded at the next login, and the Stats page
-- says so. Under it a switch for each part of what is counted
-- (ns.StatsPack.PARTS): a part that is off listens to nothing and writes
-- nothing. What was counted earlier is still shown until it is cleared.
-- Part of the settings' addon: nothing of it is in memory before the settings open.

local ns = Polestar
local L = ns.L

if not (ns.StatsPack and ns.StatsPack.Installed() and ns.RegisterOptions) then return end

local function off() return not ns.Get("stats.enabled") end

local function part(key, label, help)
	return { kind = "toggle", key = "stats." .. key, label = label, help = help, child = true, disabled = off }
end

local ok, err = ns.RegisterOptions({
	page = L["Discovery"], tab = L["Stats"], section = L["Stats"],
	controls = {
		{ kind = "toggle", key = "stats.enabled", label = L["Stats"], search = "stats, statistics, dashboard, progress, play time, gold, heat map",
			help = L["Count what this character does (quests, experience, time, gold, where you play) for the Stats page (/pole stats). Kept on this computer only."] },
		part("activity", L["Time played"], L["Time played, in combat, mounted, away and resting, by day, hour and weekday."]),
		part("xp", L["Experience and levels"], L["Experience from quests, kills and exploring, and when you reached each level."]),
		part("quests", L["Quests"], L["Quests accepted, handed in and abandoned, and how long each took."]),
		part("fights", L["Kills and deaths"], L["Kills, deaths, what killed you, fights and bosses."]),
		part("money", L["Gold"], L["Gold looted, from quests and vendors, spent on repairs, training and flights, and your purse over time."]),
		part("heat", L["Heat map"], L["Where you spend your time, on the Stats page's map."]),
		part("path", L["Walked path"], L["The path you walked, on the Stats page's map."]),
		part("travel", L["Flights, rides and portals"], L["The flights, boat and zeppelin rides, portals and hearths you took, and their routes on the map."]),
		part("character", L["Professions, gear and dungeons"], L["Profession ranks, item level and dungeon runs."]),
	},
})
if not ok and geterrorhandler then geterrorhandler()(err) end
