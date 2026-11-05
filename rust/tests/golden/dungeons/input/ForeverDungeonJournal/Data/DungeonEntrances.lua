local ADDON_NAME, FDJ = ...
FDJ = FDJ or _G.ForeverDungeonJournal_NS
local DB = FDJ.DB or {}
local entrances = {
    ["Ragefire Chasm"] = { mapID = 1454, x = 0.524, y = 0.498, label = "Ragefire Chasm Entrance", markerType = "dungeon" },
    ["The Test Mine"] = { mapID = 1429, x = 0.500, y = 0.500, label = "The Test Mine Entrance", markerType = "dungeon" },
}
for name, entrance in pairs(entrances) do
    if DB[name] then DB[name].entrance = entrance end
end
