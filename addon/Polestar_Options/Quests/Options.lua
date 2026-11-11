-- The quest settings' rows (docs/ARCHITECTURE.md, "Options registry"): the
-- Questing page's Quests tab (the page and its tabs are declared in
-- UI/Options.lua), the quest markers' section of the Map page, and the Group
-- section after them (Quests/Party.lua's settings). Part of the settings'
-- addon: none of it is in memory before the settings open.

local ns = Polestar
local Q = ns.QuestDB
local L = ns.L

if not ns.RegisterOptions then return end

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

-- The quest database's settings (Quests/QuestDB.lua) and what builds on it.
if Q then
	for _, spec in ipairs({
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
	}) do
		ns.RegisterOptions(spec)
	end
end

-- The Group section of the Questing page (its Quests tab), after the quest
-- settings. `search`: more words the settings search finds them by (English,
-- as the other controls' `search`).
if ns.Party then
	local SEARCH = "group, party, sync, friends, together"
	local function notShown() return not ns.Get("party.show") end
	local function noChat() return not (ns.Get("party.chat") or ns.Get("party.chatLoot")) end
	ns.RegisterOptions({
		page = L["Questing"], tab = L["Quests"], section = L["Group"],
		controls = {
			{ kind = "toggle", key = "party.share", label = L["Share my quest progress with my party"], search = SEARCH,
				help = L["Party members who run Polestar see your counts under their quest goals, your step and your level. Hidden addon messages to your party only; nothing goes to chat."] },
			{ kind = "toggle", key = "party.show", label = L["Show my party's progress in the guide"], search = SEARCH,
				help = L["Their counts under your quest goals, and who lacks a quest you took, with a Share button."] },
			{ kind = "toggle", key = "party.waitForGroup", label = L["Wait for the group"], search = SEARCH, disabled = notShown,
				help = L["When a party member on your quest still needs an objective you finished, the step and its turn-in wait and the arrow leads to what they need. Members in another zone or offline for 2 minutes don't hold you; the party line offers Go on without them."] },
			{ kind = "toggle", key = "party.lootNeeds", label = L["Say who still needs quest loot"], search = SEARCH, disabled = notShown,
				help = L["On a loot window or roll, a line under a quest item a party member still needs and you don't. Nothing is passed or said for you."] },
			{ kind = "toggle", key = "party.panel", label = L["Party panel"], search = SEARCH,
				help = L["Opens by itself when someone in your party runs Polestar too: each member's level, step and what they still need of yours; click a name to point the arrow at them. Closed, it stays closed; /polestar party opens it again."] },
			{ kind = "toggle", key = "party.chat", label = L["Tell my party about objectives and ready quests"], search = SEARCH .. ", chat, announce, objective, tell",
				help = L["A party chat line with the quest's link when you finish its objectives, and one when the quest is ready to turn in. Everyone in the party sees it, Polestar or not. Never solo or in a raid."] },
			{ kind = "toggle", key = "party.chatLoot", label = L["Tell my party when I loot an item that starts a quest"], search = SEARCH .. ", chat, announce, loot, item, tell",
				help = L["A party chat line with the item's link and the quest it starts."] },
			{ kind = "toggle", key = "party.chatEcho", label = L["Show my own lines in my chat too"], search = SEARCH .. ", chat, announce", disabled = noChat,
				help = L["Off: your party sees the lines Polestar says for you, and your chat stays clear of them."] },
			{ kind = "toggle", key = "party.chatHideOthers", label = L["Hide other players' Polestar lines"], search = SEARCH .. ", chat, announce, hide",
				help = L["Party members' Polestar lines leave your chat. Shown, they carry Polestar's star."] },
			{ kind = "toggle", key = "party.chatOnlyNeeded", label = L["Only when someone in the party doesn't have Polestar"], search = SEARCH .. ", chat, announce", disabled = noChat,
				help = L["Nothing goes to chat while everyone in your party runs Polestar: they see your progress in their guide."] },
		},
	})
end
