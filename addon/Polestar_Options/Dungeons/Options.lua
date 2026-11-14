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

-- The dungeons a leveling guide's `when dungeon` steps can be for, an
-- answer each: Run it, Skip it, or As for all dungeons (none: "Dungeons in
-- my route", behavior.dungeons, answers; Skip by default, the solo route).
-- The Classic dungeons of the Codex's instances (data/codex/entrances.json)
-- and Forever's new ones, by level, as Map id and English name; the name
-- shows in the client's language when it has one (Names.Instance). The
-- answer is per character (Engine.ChooseDungeon), the one the guide
-- window's question gives. Only the dungeons this character's guides have
-- steps for get a row (Engine.GuideDungeons, read once logged in and again
-- when more guides load; none: no section); an answer saved for one without
-- a row is kept.
local ROUTE = {
	{ 389, "Ragefire Chasm" }, { 3065, "The Hall of Thanes" }, { 2999, "Ruins of Lordaeron" }, { 36, "The Deadmines" },
	{ 43, "Wailing Caverns" }, { 33, "Shadowfang Keep" }, { 48, "Blackfathom Deeps" }, { 34, "The Stockade" },
	{ 90, "Gnomeregan" }, { 47, "Razorfen Kraul" }, { 2998, "Excavation Site: Wetlands" }, { 2959, "City of Dalaran" },
	{ 189, "Scarlet Monastery" }, { 2970, "The Drowned City" }, { 129, "Razorfen Downs" }, { 70, "Uldaman" },
	{ 3039, "Krol'dok Stronghold" }, { 209, "Zul'Farrak" }, { 349, "Maraudon" }, { 109, "Sunken Temple" },
	{ 2994, "Alcaz Prison" }, { 230, "Blackrock Depths" }, { 229, "Blackrock Spire" }, { 429, "Dire Maul" },
	{ 2974, "Blackmaw Hold" }, { 329, "Stratholme" }, { 289, "Scholomance" }, { 3001, "The Shaper's Terrace" },
}
Dungeons.ROUTE = ROUTE
local ANSWER = { run = true, skip = false }
local CHOICES = { { value = "all", label = L["As for all dungeons"] }, { value = "run", label = L["Run it"] }, { value = "skip", label = L["Skip it"] } }
local HELP = L["Run it: the leveling guide picks up its quests on the way and takes you to the door. Skip it: the guide keeps to the solo route. As for all dungeons: Guide, Automation, Dungeons in my route answers."]
local rowFor = {} -- map -> true once its row is registered
local function routeRows()
	local E = ns.Engine
	local have = E and E.GuideDungeons and E.GuideDungeons() or {}
	local controls = {}
	for _, d in ipairs(ROUTE) do
		local map, name = d[1], d[2]
		if have[map] and not rowFor[map] then
			rowFor[map] = true
			controls[#controls + 1] = { kind = "dropdown", help = HELP, choices = CHOICES,
				label = function() return ns.Names and ns.Names.Instance and ns.Names.Instance(map) or name end,
				get = function()
					local a = ns.CharState().dungeons[map]
					return a == true and "run" or (a == false and "skip") or "all"
				end,
				set = function(v) E.ChooseDungeon(map, ANSWER[v]) end }
		end
	end
	if #controls == 0 then return end
	local done, why = ns.RegisterOptions({ page = L["Discovery"], tab = L["Dungeons"], section = L["Dungeons in leveling guides"], controls = controls })
	if not done and geterrorhandler then geterrorhandler()(why) end
end
ns.OnLogin(routeRows)
ns.On("GUIDES_REGISTERED", function() if ns.IsLoggedIn() then routeRows() end end)

-- The group quests of this character's guides (`when group`), one toggle
-- each: on, do it with a group; off, skip it. Per character
-- (Engine.AnswerGroup). A quest not answered shows what Guide, Automation,
-- Group quests answers for it, and reads nil while that asks, so a reset's
-- Undo puts back an answer, or none, as it was. A reset (right-click, the
-- section's or the page's) forgets the answer; a write answers only what
-- the quest does not do already. Read once logged in; none: no tab.
ns.OnLogin(function()
	local E = ns.Engine
	local list = E and E.GroupQuests and E.GroupQuests() or {}
	if #list == 0 then return end
	local quests = {}
	for _, gq in ipairs(list) do
		local q = gq.quest
		quests[#quests + 1] = { kind = "toggle",
			label = function() return ns.Names and ns.Names.Quest and ns.Names.Quest(q) or gq.title or ("#" .. q) end,
			help = L["Off: the guide skips this group quest and keeps to the solo route. Until you choose, Guide, Automation, Group quests answers for it; by default the guide asks when it gets there."],
			get = function()
				local a = E.GroupAnswer(q)
				if a == nil then return nil end
				return a == "do"
			end,
			set = function(on)
				if on == nil then E.AnswerGroup(q, nil) return end
				local want = on and "do" or "skip"
				if E.GroupAnswer(q) ~= want then E.AnswerGroup(q, want) end
			end }
	end
	local done, why = ns.RegisterOptions({ page = L["Discovery"], tab = L["Group quests"], section = L["Group quests in leveling guides"], controls = quests })
	if not done and geterrorhandler then geterrorhandler()(why) end
end)
