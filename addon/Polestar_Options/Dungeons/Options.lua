-- The Dungeons rows on the Discovery page (docs/ARCHITECTURE.md, "Options
-- registry"): the dungeon pages and their heads-up, on the Lookup tab beside
-- the Characters page's switch (Alts/Options.lua); the dungeons a leveling
-- guide's `when dungeon` steps can be for; the group quests of this
-- character's guides. Part of the settings' addon: none of it is in memory
-- before the settings open.

local ns = Polestar
local Dungeons = ns.Dungeons
local L = ns.L

if not (Dungeons and ns.RegisterOptions) then return end

local ok, err = ns.RegisterOptions({
	page = L["Discovery"], tab = L["Lookup"], section = L["Dungeons and characters"],
	controls = {
		{ kind = "toggle", key = "dungeons.enabled", label = ENCOUNTER_JOURNAL or L["Dungeons"],
			help = L["A page per dungeon and raid: every quest with where to get it, its chain and rewards, the bosses and the entrance."] },
		{ kind = "toggle", key = "dungeons.headsUp", label = L["Tell me when a dungeon opens up"], child = true, disabled = function() return not ns.Get("dungeons.enabled") end,
			help = L["When a level-up opens a dungeon's quests to this character, a card on the guide window says so, once per dungeon, with a button that picks up its quests in a new tab."] },
	},
})
if not ok and geterrorhandler then geterrorhandler()(err) end

-- The dungeons a leveling guide's `when dungeon` steps can be for, one
-- toggle each, all off: the solo route is the default. The Classic
-- dungeons of the Codex's instances (data/codex/entrances.json), by
-- level, as Map id and English name; the name shows in the client's
-- language when it has one (Names.Instance). The choice is per character
-- (Engine.ChooseDungeon). Only the ones this character's guides have
-- steps for are offered (Engine.GuideDungeons, read once logged in; none:
-- no section); a choice saved for one not offered is kept.
local ROUTE = {
	{ 389, "Ragefire Chasm" }, { 43, "Wailing Caverns" }, { 36, "The Deadmines" }, { 33, "Shadowfang Keep" },
	{ 48, "Blackfathom Deeps" }, { 34, "The Stockade" }, { 90, "Gnomeregan" }, { 47, "Razorfen Kraul" },
	{ 189, "Scarlet Monastery" }, { 129, "Razorfen Downs" }, { 70, "Uldaman" }, { 209, "Zul'Farrak" },
	{ 349, "Maraudon" }, { 109, "Sunken Temple" }, { 230, "Blackrock Depths" }, { 229, "Blackrock Spire" },
	{ 429, "Dire Maul" }, { 289, "Scholomance" }, { 329, "Stratholme" },
}
Dungeons.ROUTE = ROUTE
ns.OnLogin(function()
	local E = ns.Engine
	local have = E and E.GuideDungeons and E.GuideDungeons() or {}
	local controls = {}
	for _, d in ipairs(ROUTE) do
		local map, name = d[1], d[2]
		if have[map] then
			controls[#controls + 1] = { kind = "toggle",
				label = function() return ns.Names and ns.Names.Instance and ns.Names.Instance(map) or name end,
				help = L["Leveling guides take you through this dungeon where they have steps for it. Off: they keep to the solo route. More dungeons join this list as they are added to the guides' route."],
				get = function() return E.DungeonChosen(map) end,
				set = function(on) E.ChooseDungeon(map, on) end }
		end
	end
	if #controls == 0 then return end
	local done, why = ns.RegisterOptions({ page = L["Discovery"], tab = L["Dungeons"], section = L["Dungeons in leveling guides"], controls = controls })
	if not done and geterrorhandler then geterrorhandler()(why) end
end)

-- The group quests of this character's guides (`when group`), one toggle
-- each: on, do it with a group; off, skip it (or not answered yet: the
-- guide asks when it gets there). Per character (Engine.AnswerGroup). Read
-- once logged in; none: no tab.
ns.OnLogin(function()
	local E = ns.Engine
	local list = E and E.GroupQuests and E.GroupQuests() or {}
	if #list == 0 then return end
	local quests = {}
	for _, gq in ipairs(list) do
		local q = gq.quest
		quests[#quests + 1] = { kind = "toggle",
			label = function() return ns.Names and ns.Names.Quest and ns.Names.Quest(q) or gq.title or ("#" .. q) end,
			help = L["Off: the guide skips this group quest and keeps to the solo route. Until you choose, it asks when it gets there."],
			get = function() return E.GroupAnswer(q) == "do" end,
			set = function(on) E.AnswerGroup(q, on and "do" or "skip") end }
	end
	local done, why = ns.RegisterOptions({ page = L["Discovery"], tab = L["Group quests"], section = L["Group quests in leveling guides"], controls = quests })
	if not done and geterrorhandler then geterrorhandler()(why) end
end)
