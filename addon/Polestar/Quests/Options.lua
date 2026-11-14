-- The quest settings on the Questing options page (its Quests tab; the page
-- and its tabs are declared in UI/Options.lua), the quest markers' section
-- of the Map page (Polestar.RegisterOptions, defined in Theme/Widgets.lua),
-- and the /polestar questdb command.

local ADDON, ns = ...

local Q = ns.QuestDB
local L = ns.L

local function dbOff() return not ns.Get("qol.questDB") end
local function availableOff() return not ns.Get("qol.questDB") or not ns.Get("qol.availableQuests") end
local function objectivesOff() return not ns.Get("qol.questDB") or not ns.Get("qol.mapObjectives") end
local function areasOff() return objectivesOff() or ns.Get("qol.objectiveSpots") == "icons" end
local function guideOff() return not ns.Get("qol.questDB") or not ns.Get("qol.guideHighlight") end
local function platesOff() return not ns.Get("qol.questDB") or not ns.Get("qol.nameplateIcons") end

-- "Your level", "+5", "Any level" at the top of the slider.
local function levelWindow(v)
	v = math.floor((tonumber(v) or 0) + 0.5)
	if v >= Q.LEVEL_WINDOW_ANY then return L["Any level"] end
	if v == 0 then return L["Your level"] end
	return "+" .. v
end

local function percent(v) return math.floor((tonumber(v) or 0) * 100 + 0.5) .. "%" end

Q.OPTIONS = {
	{
		page = L["Questing"], tab = L["Quests"], section = L["Quest database"],
		controls = {
			{ kind = "toggle", key = "qol.questDB", label = L["Quest database"], search = "memory, ram, quest data",
				help = L["Quest, NPC and item data for markers and tooltips, loaded when one of them is on (about 5 MB of memory)."] },
		},
	},
	-- The markers live with every other map icon, on the Map page.
	{
		page = L["Map"], tab = L["Guide & quests"], section = L["Quest markers"],
		controls = {
			{ kind = "toggle", key = "qol.availableQuests", label = L["Available quests"], disabled = dbOff, search = "exclamation mark, quest givers, map pins, icons, markers",
				help = L["Mark quest givers with quests you can accept now."] },
			{ kind = "slider", key = "qol.questLevelWindow", label = L["Quests above your level"], disabled = availableOff, child = true,
				min = 0, max = Q.LEVEL_WINDOW_ANY, step = 1, format = levelWindow,
				help = L["Mark quests up to this many levels above yours."] },
			{ kind = "toggle", key = "qol.lowLevelQuests", label = L["Low-level quests"], disabled = availableOff, child = true,
				help = L["Also mark grey quests that are far below your level."] },
			{ kind = "toggle", key = "qol.mapObjectives", label = L["World map objectives"], disabled = dbOff, search = "map pins, icons, markers, objectives, quest areas",
				help = L["Mark mob areas, item sources and objects for quests in your log."] },
			{ kind = "dropdown", key = "qol.objectiveSpots", label = L["Objective spots on the map"], disabled = objectivesOff, child = true,
				search = "areas, circles, shaded areas, quest areas, clutter, overlapping icons",
				help = L["A goal's spots close together can draw as one shaded area with one marker in the middle, so the map stays readable."],
				choices = { { value = "groups", label = L["Areas for groups"] }, { value = "icons", label = L["Icons only"] }, { value = "areas", label = L["Areas only"] } } },
			{ kind = "slider", key = "qol.objectiveAreaAlpha", label = L["Area opacity"], disabled = areasOff, child = true,
				min = 0.2, max = 1, step = 0.05, format = percent, release = true,
				help = L["How strongly the objective areas tint the map."] },
			{ kind = "toggle", key = "qol.turnInMarkers", label = L["Turn-ins"], disabled = dbOff, search = "question mark, hand in, turnin, map pins, icons, markers",
				help = L["Mark who to return to once a quest is ready."] },
			{ kind = "toggle", key = "qol.minimapObjectives", label = L["Minimap markers"], disabled = dbOff, search = "minimap icons, minimap pins, objectives",
				help = L["Show the same quest markers on the minimap."] },
			{ kind = "slider", key = "qol.questMarkerSize", label = L["Quest marker size"], disabled = dbOff,
				min = 0.6, max = 1.6, step = 0.05, format = percent, release = true, search = "icon size, bigger icons, smaller icons, map pins",
				help = L["The size of every quest marker on the world map and the minimap."] },
			{ kind = "toggle", key = "qol.guideHighlight", label = L["Highlight step quests"], disabled = dbOff,
				help = L["Enlarge and light up the markers of the quests in your guide's current step."] },
			{ kind = "toggle", key = "qol.guideDim", label = L["Dim other quests"], disabled = guideOff, child = true,
				help = L["While a guide runs, fade every quest marker that is not part of its current step."] },
		},
	},
	{
		page = L["Questing"], tab = L["Quests"], section = L["Tooltips and quest log"],
		controls = {
			{ kind = "toggle", key = "qol.questTooltips", label = L["Quest tooltips"], disabled = dbOff, search = "tooltip, quest progress, mob quests",
				help = L["Name the quests a mob, item or object is for, with your progress."] },
			{ kind = "toggle", key = "qol.questDropChance", label = L["Drop chance"], child = true,
				disabled = function() return dbOff() or not ns.Get("qol.questTooltips") end, search = "drop rate, drop chance, loot chance, percent",
				help = L["On a mob that drops a quest item you still need, show how often it drops it."] },
			{ kind = "toggle", key = "qol.questTooltipsReplace", label = L["Replace the game's quest lines"], child = true,
				disabled = function() return dbOff() or not ns.Get("qol.questTooltips") end, search = "duplicate, twice, double, native, blizzard",
				help = L["On mobs and objects, leave out the game's own lines for the quests these tooltips name, so each quest shows once. In a group the game's lines stay: they show your party's progress."] },
			{ kind = "toggle", key = "qol.questBagMarks", label = L["Quest marks in bags"], disabled = dbOff,
				help = L["Mark bag items a quest still needs, in your log or ahead in your guide, until you hand the quest in."] },
			{ kind = "toggle", key = "qol.questSellWarning", label = L["Offer to buy back quest items"], disabled = dbOff,
				help = L["If you sell an item a quest still needs, ask whether to buy it back from the vendor."] },
			{ kind = "toggle", key = "qol.nameplateIcons", label = L["Nameplate icons"], disabled = dbOff, search = "nameplates, quest mobs, plates, progress",
				help = L["Show a quest icon and your progress, like 3/10, on nameplates of mobs you still need."] },
			{ kind = "dropdown", key = "qol.nameplateIconSide", label = L["Nameplate icon position"], disabled = platesOff, child = true,
				search = "nameplates, move icon, overlap, quest icon, counter",
				help = L["Where the quest icon and your progress sit on a nameplate: left or right of the health bar, or above the name. Move them if another addon's icon covers them."],
				choices = { { value = "left", label = L["Left"] }, { value = "right", label = L["Right"] }, { value = "above", label = L["Above"] } } },
			{ kind = "toggle", key = "qol.questLevels", label = L["Quest levels"], search = "quest log, level numbers, show level",
				help = L["Show quest levels, like [12], wherever the game lists quests without them."] },
			{ kind = "toggle", key = "qol.questTimerAlerts", label = L["Timed quest alerts"], search = "timer, timed quest, countdown, time limit, time left, alarm",
				help = L["A chat line and a sound when a timed quest has 5 minutes left, again at 1 minute, and if it fails. The guide window always shows the time left."] },
		},
	},
}

local registered = false
local function register()
	if registered or not ns.RegisterOptions then return end
	registered = true
	for i = 1, #Q.OPTIONS do ns.RegisterOptions(Q.OPTIONS[i]) end
end

-- Registered once every file has loaded (ADDON_LOADED), and again at login,
-- as Gear's page is: the registry (Theme/Widgets.lua) is there by then
-- whichever files were loaded.
ns.OnInit(register)
ns.OnLogin(register)

ns.RegisterCommand("questdb", function()
	if not Q.IsLoaded() then
		local msg = L["Quest database is off."]
		if Q.IsWanted() then msg = L["Quest database not installed (Polestar_QuestDB)."] end
		ns.Print(msg)
		return
	end
	local m = Q._data.meta
	local tracked = 0
	for _ in pairs(Q._index.npc) do tracked = tracked + 1 end
	local info = ns.Data.Info(Q.ADDON)
	local mem = info.memoryKB and (" (%.1f MB)"):format(info.memoryKB / 1024) or ""
	ns.Print(("%s%s: %d %s, %d %s; %d %s, %d %s"):format(L["Quest database"], mem, m.quests or 0, L["quests"], m.npcs or 0, L["NPCs"],
		#Q.GetAvailableQuests(), L["available now"], tracked, L["mobs tracked"]))
end, L["Quest database status"], true)
