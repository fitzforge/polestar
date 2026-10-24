-- Synthetic DungeonJournal data for tests/dungeons.test.js (same shapes as 1.6.0).
local ADDON_NAME, FDJ = ...
FDJ = FDJ or _G.ForeverDungeonJournal_NS
local ALBA = FDJ.Constants.ALBA_FAIRMOON_LOCATION

FDJ.DB = {
    ["The Test Mine"] = {
        level = "5-10",
        location = "Elwynn Forest",
        quests = {{
            id = 7,
            name = "Kobold Camp Cleanup",
            faction = "Alliance",
            level = 3,
            requires = 1,
            pickup = "Marshal McBride, Northshire Abbey",
            turnin = "Marshal McBride, Northshire Abbey",
            rewardItems = {{159, "Refreshing Spring Water", 1}, {750, "Tough Wolf Meat", 2}},
            rewardChoice = true,
            rewardSummary = "1s 50c",
            liveXPFallback = 400,
        }, {
            id = 990001,
            name = "A Ghostly Errand",
            faction = "Both",
            level = 7,
            requires = 5,
            objective = "Put Foreman Grub to rest.",
            pickup = "Ghostly Miner, inside The Test Mine",
            turnin = "Ghostly Miner, inside the dungeon",
            rewardItems = {{990010, "Miner's Lantern", 3}},
            rewardSummary = "7s  •  Stormwind +100",
            liveXPFallback = 1050,
        }, {
            id = 990002,
            name = "Lost Pick",
            faction = "Alliance",
            level = 8,
            requires = 5,
            startItem = {990020, "Rusty Pick", 1, "Dropped by: Foreman Grub"},
            pickup = "Item start: Rusty Pick, inside The Test Mine",
            turnin = "Old Miner, Goldshire",
            rewardItems = {},
        }, {
            id = 990003,
            name = "Miner's Request",
            faction = "Alliance",
            level = 6,
            requires = 1,
            pickup = "Old Miner, Goldshire",
            turnin = "Old Miner, Goldshire",
            rewardItems = {},
            rewardSummary = "",
        }, {
            id = 990004,
            name = "Grub's End",
            faction = "Horde",
            level = 9,
            requires = 5,
            objective = "Slay Foreman Grub.",
            pickup = "Ghostly Miner, inside The Test Mine",
            turnin = "Ghostly Miner, inside the dungeon",
            rewardItems = {},
            liveXPFallback = 800,
        }, {
            id = 990005,
            name = "Hidden Side Errand",
            faction = "Horde",
            hideFromMainList = true,
            level = 9,
            requires = 5,
            pickup = "Ghostly Miner, inside The Test Mine",
            turnin = "Ghostly Miner, inside the dungeon",
            rewardItems = {},
        }},
        bosses = {
            { name = "Gnasher", npcID = 990100, aliases = { "Gnasher" }, loot = { {990030, "Gnasher's Tooth", "Neck", 2} } },
            { name = "Tunnel Rat", rare = true, loot = {} },
            { name = "Foreman Grub", npcID = 990101, aliases = { "Foreman Grub", "Grub" }, loot = { {990020, "Rusty Pick", "Quest Item", 1} } },
            { name = "Rubble Pile", trash = true, loot = {} },
        },
    },
}

FDJ.ORDER = { "The Test Mine" }
