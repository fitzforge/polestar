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
local function guideOff() return not ns.Get("qol.questDB") or not ns.Get("qol.guideHighlight") end

-- "Your level", "+5", "Any level" at the top of the slider.
local function levelWindow(v)
	v = math.floor((tonumber(v) or 0) + 0.5)
	if v >= Q.LEVEL_WINDOW_ANY then return L["Any level"] end
	if v == 0 then return L["Your level"] end
	return "+" .. v
end

Q.OPTIONS = {
	{
		page = L["Questing"], tab = L["Quests"], section = L["Quest database"],
		controls = {
			{ kind = "toggle", key = "qol.questDB", label = L["Quest database"],
				help = L["Quest, NPC and item data for markers and tooltips, loaded when one of them is on (about 5 MB of memory)."] },
		},
	},
	-- The markers live with every other map icon, on the Map page.
	{
		page = L["Map"], tab = L["Guide & quests"], section = L["Quest markers"],
		controls = {
			{ kind = "toggle", key = "qol.availableQuests", label = L["Available quests"], disabled = dbOff,
				help = L["Mark quest givers with quests you can accept now."] },
			{ kind = "slider", key = "qol.questLevelWindow", label = L["Quests above your level"], disabled = availableOff,
				min = 0, max = Q.LEVEL_WINDOW_ANY, step = 1, format = levelWindow,
				help = L["Mark quests up to this many levels above yours."] },
			{ kind = "toggle", key = "qol.lowLevelQuests", label = L["Low-level quests"], disabled = availableOff,
				help = L["Also mark grey quests that are far below your level."] },
			{ kind = "toggle", key = "qol.mapObjectives", label = L["World map objectives"], disabled = dbOff,
				help = L["Mark mob areas, item sources and objects for quests in your log."] },
			{ kind = "toggle", key = "qol.objectiveAreas", label = L["Objective areas"], disabled = objectivesOff,
				help = L["Shade the area each group of mobs or objects spreads over on the world map."] },
			{ kind = "toggle", key = "qol.turnInMarkers", label = L["Turn-ins"], disabled = dbOff,
				help = L["Mark who to return to once a quest is ready."] },
			{ kind = "toggle", key = "qol.minimapObjectives", label = L["Minimap markers"], disabled = dbOff,
				help = L["Show the same quest markers on the minimap."] },
			{ kind = "toggle", key = "qol.guideHighlight", label = L["Highlight step quests"], disabled = dbOff,
				help = L["Enlarge and light up the markers of the quests in your guide's current step."] },
			{ kind = "toggle", key = "qol.guideDim", label = L["Dim other quests"], disabled = guideOff,
				help = L["While a guide runs, fade every quest marker that is not part of its current step."] },
		},
	},
	{
		page = L["Questing"], tab = L["Quests"], section = L["Tooltips and quest log"],
		controls = {
			{ kind = "toggle", key = "qol.questTooltips", label = L["Quest tooltips"], disabled = dbOff,
				help = L["Name the quests a mob, item or object is for, with your progress."] },
			{ kind = "toggle", key = "qol.nameplateIcons", label = L["Nameplate icons"], disabled = dbOff,
				help = L["Show a quest icon and your progress, like 3/10, on nameplates of mobs you still need."] },
			{ kind = "toggle", key = "qol.questLevels", label = L["Quest levels"],
				help = L["Show quest levels, like [12], wherever the game lists quests without them."] },
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
end, L["Quest database status"])
