local ADDON_NAME, FDJ = ...
FDJ = FDJ or _G.ForeverDungeonJournal_NS
local DB = FDJ.DB or {}
local routes = {}
for name, route in pairs(routes) do
    if DB[name] then DB[name].routeGuide = route end
end
