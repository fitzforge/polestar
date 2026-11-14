-- env: dungeonroute
-- The Discovery page's answers for the dungeons in leveling guides (Polestar_Options/Dungeons/Options.lua;
-- Core/Engine.lua) on the whole addon, with the environment's guide open: one `when dungeon` step per dungeon of
-- Dungeons.ROUTE, all ahead of the live step. A dungeon's step has no number while the character skips it (As for
-- all dungeons, with "Dungeons in my route" at Skip: the solo route's numbers), its own once it is run
-- (Own.dungeonHidden). The environment turns dungeons in the route on (Core/Init.lua's switch, off as it ships)
-- before the settings window's addon loads. The list as Dungeons.ROUTE and the environment's guide have it (the setup checks it): the
-- checks' ids are read without the addon.
local ROUTE = {
	{ 389, "Ragefire Chasm" }, { 3065, "The Hall of Thanes" }, { 2999, "Ruins of Lordaeron" }, { 36, "The Deadmines" },
	{ 43, "Wailing Caverns" }, { 33, "Shadowfang Keep" }, { 48, "Blackfathom Deeps" }, { 34, "The Stockade" },
	{ 90, "Gnomeregan" }, { 47, "Razorfen Kraul" }, { 2998, "Excavation Site: Wetlands" }, { 2959, "City of Dalaran" },
	{ 189, "Scarlet Monastery" }, { 2970, "The Drowned City" }, { 129, "Razorfen Downs" }, { 70, "Uldaman" },
	{ 3039, "Krol'dok Stronghold" }, { 209, "Zul'Farrak" }, { 349, "Maraudon" }, { 109, "Sunken Temple" },
	{ 2994, "Alcaz Prison" }, { 230, "Blackrock Depths" }, { 229, "Blackrock Spire" }, { 429, "Dire Maul" },
	{ 2974, "Blackmaw Hold" }, { 329, "Stratholme" }, { 289, "Scholomance" }, { 3001, "The Shaper's Terrace" },
}
-- The Horde's city dungeons are never this Human's (Engine.EnemyCityDungeon): no row, so no probe.
local HORDE_CITY = { [389] = true, [2999] = true }
local E
local probes = {}
for i, d in ipairs(ROUTE) do
	local step = i + 1
	-- Whether the dungeon's step is left out of the numbers the player sees.
	if not HORDE_CITY[d[1]] then probes["Discovery:" .. d[2]] = function() return select(2, E.StepNumber(step)) end end
end
return {
	setup = function()
		E = Polestar.Engine
		local route = Polestar.Dungeons.ROUTE
		assert(#route == #ROUTE, "Dungeons.ROUTE has " .. #route .. " dungeons, this list " .. #ROUTE)
		for i, d in ipairs(route) do assert(d[1] == ROUTE[i][1] and d[2] == ROUTE[i][2], "Dungeons.ROUTE changed at " .. i .. ": " .. tostring(d[2])) end
		local g = E.GetGuide()
		assert(g and g.id == "test/dungeons" and #g.steps == #ROUTE + 2, "the environment's guide is open")
		local listed = E.GuideDungeons()
		assert(listed[36] and not listed[389] and not listed[2999], "the Horde's city dungeons are never listed for this Human")
	end,
	probes = probes,
}
