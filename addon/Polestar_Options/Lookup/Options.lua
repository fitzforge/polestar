-- Lookup's rows, on the Discovery page's Lookup tab (docs/ARCHITECTURE.md,
-- "Options registry"); its settings are core's (Lookup/Options.lua).
-- lookup.enabled switches the whole module off: search entities, tooltip
-- lines, Alt-click guides, the mount spotter and commands. Part of the
-- settings' addon: none of it is in memory before the settings open.

local ns = Polestar
local L = ns.L

if not (ns.Lookup and ns.RegisterOptions) then return end

local function disabled() return not ns.Get("lookup.enabled") end

local ok, err = ns.RegisterOptions({
	page = L["Discovery"], tab = L["Lookup"], section = L["How to get anything"],
	controls = {
		{ kind = "toggle", key = "lookup.enabled", label = L["Lookup"], search = "where to get, item source, drop, farm, find item, mount, pet, database",
			help = L["Search every item, mount, pet, NPC and quest, and see where it comes from (/pole lookup)."] },
		{ kind = "toggle", key = "lookup.tooltip", label = L["Sources on item tooltips"], disabled = disabled, search = "drop source, where it drops, tooltip",
			help = L["The best one or two places to get an item, ranked for this character."] },
		{ kind = "toggle", key = "lookup.altClick", label = L["Alt-click an item for a guide"], disabled = disabled,
			help = L["Alt-click an item link, bag item or loot to open a guide that gets it."] },
		{ kind = "toggle", key = "lookup.mounts", label = L["Spot other players' mounts"], disabled = disabled,
			help = L["Name the mount of a player you target or point at, and where it comes from (/pole mount)."] },
	},
})
if not ok and geterrorhandler then geterrorhandler()(err) end
