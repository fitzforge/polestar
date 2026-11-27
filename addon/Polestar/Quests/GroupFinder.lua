-- The Group Finder's door: players on the same quests, found through a
-- hidden channel of the players who run it, then grouped with by a click
-- (docs/ARCHITECTURE.md, "Group Finder"). The finder itself is the folder
-- Polestar_GroupFinder, loaded on demand: at login while it is on, the first
-- time the player turns it on, opens its panel or presses one of its keys.
-- Here: its settings (off by default), the guide menu's row, its key
-- bindings' entry points and its command; its own functions take these
-- places as it loads.
--
--   GroupFinder.ADDON
--   GroupFinder.Load() -> true | nil, reason     -- Data.Pack(GroupFinder.ADDON)
--   GroupFinder.Show() / Toggle()                -- its panel
--   GroupFinder.Search() / Announce()            -- Find a group, Announce (keys)
--   GroupFinder.Hello() / Goodbye()              -- the message box's keys
--   GroupFinder.Command(arg)                     -- /polestar finder ...
--   GroupFinder.MenuItems() -> { item }          -- the guide window menu's row
--   GroupFinder.RowWanted(goal) -> bool          -- a goal row's "players on this quest" button shows
--   GroupFinder.FindFor(questID)                 -- that button: the panel, and a search for that quest
--   GroupFinder.QuestMenuWanted(questID) -> bool -- a quest menu's "Find a group for this quest" row

local _, ns = ...

local L = ns.L
local GroupFinder = {}
ns.GroupFinder = GroupFinder

GroupFinder.ADDON = "Polestar_GroupFinder"

-- Everything that acts or speaks for the player is off, or only ever runs
-- on a click; the messages are on, each said only from its button or key.
-- The game's languages, by the one letter a search carries for its sender's (GetLocale), in their order on the
-- page: your own ticked by default.
local LOCALE_LETTER = { enUS = "e", enGB = "e", frFR = "f", deDE = "d", esES = "s", esMX = "s", itIT = "i", ptBR = "p", ptPT = "p",
	ruRU = "r", koKR = "k", zhCN = "c", zhTW = "t" }
local OWN_LANGS = { e = false, f = false, d = false, s = false, i = false, p = false, r = false, k = false, c = false, t = false }
OWN_LANGS[LOCALE_LETTER[GetLocale and GetLocale() or "enUS"] or "e"] = true

ns.RegisterDefaults("groupFinder", {
	enabled = false,        -- the whole finder: joins its channel, listens, can search
	autoReply = false,      -- answer other players' searches for quests you have, without a click
	autoGroup = false,      -- invite / accept a player who shares a quest, after a search, both sides on
	autoRetry = false,      -- ask the search again every 10 s while nobody is found, 5 minutes at most
	shareCoords = true,     -- your map position with your searches (distance in their list)
	openNear = false,       -- open the panel near the live step's objective, once per step
	-- The players listed, by their game's language: those ticked (one letter each, as the finder's messages
	-- carry it: GroupFinder.LANGUAGES; your own by default), or every language.
	langs = OWN_LANGS,
	acceptAll = false,
	partyBox = true,        -- the message box: hello when a finder group forms, goodbye when its quests are done
	partyBoxStyle = "polestar", -- "polestar" (quests and objectives) or "compact"
	announceTo = "GENERAL", -- where Announce speaks: GENERAL, LFG, SAY, YELL
	-- The messages: each one's switch and text ("": never sent). In English for every client, as the other
	-- players may read any language; {quests} and {progress} are filled when said (Polestar_GroupFinder/Messages.lua).
	announceOn = true, inviteOn = true, askOn = true, helloOn = true, goodbyeOn = true,
	announceMsg = "LFG {quests}, whisper me!",
	inviteMsg = "Hi! I'm on {quests} too, I've sent you an invite.",
	askMsg = "Hi! I'm on {quests} too, could you invite me to your group?",
	helloMsg = "Hi all! I'm on {progress}.",
	leaveMsg = "Thanks for the group, have fun!",
	panelPos = false,       -- { point, x, y } of the panel, where the player left it
	panelWidth = false,     -- the panel's width, set by its grip
	partyBoxPos = false,    -- { point, x, y } of the message box
	debug = false,          -- /polestar finder debug: its traffic in chat
})

-- The languages the page lists. Only those played in the game's region are offered (GetCurrentRegion:
-- 1 Americas, 2 Korea, 3 Europe, 4 Taiwan, 5 China; all of them when it can't say), and your own.
GroupFinder.LANGUAGES = {
	{ code = "e", tag = "EN", name = L["English"], locales = { enUS = true, enGB = true } },
	{ code = "f", tag = "FR", name = L["French"], locales = { frFR = true } },
	{ code = "d", tag = "DE", name = L["German"], locales = { deDE = true } },
	{ code = "s", tag = "ES", name = L["Spanish"], locales = { esES = true, esMX = true } },
	{ code = "i", tag = "IT", name = L["Italian"], locales = { itIT = true } },
	{ code = "p", tag = "PT", name = L["Portuguese"], locales = { ptBR = true, ptPT = true } },
	{ code = "r", tag = "RU", name = L["Russian"], locales = { ruRU = true } },
	{ code = "k", tag = "KO", name = L["Korean"], locales = { koKR = true } },
	{ code = "c", tag = "ZH", name = L["Chinese (Simplified)"], locales = { zhCN = true } },
	{ code = "t", tag = "ZHT", name = L["Chinese (Traditional)"], locales = { zhTW = true } },
}
local REGION_LANGS = {
	[1] = { e = true, s = true, p = true },
	[2] = { k = true, e = true },
	[3] = { e = true, f = true, d = true, s = true, i = true, p = true, r = true },
	[4] = { t = true, e = true },
	[5] = { c = true, e = true },
}

-- Your game's language's letter.
function GroupFinder.OwnLanguage()
	local loc = GetLocale and GetLocale() or "enUS"
	for _, row in ipairs(GroupFinder.LANGUAGES) do
		if row.locales[loc] then return row.code end
	end
	return "e"
end

-- The rows the page offers: the region's languages and your own.
function GroupFinder.LanguagesOffered()
	local region = GetCurrentRegion and GetCurrentRegion()
	local allowed = REGION_LANGS[region]
	local own, out = GroupFinder.OwnLanguage(), {}
	for _, row in ipairs(GroupFinder.LANGUAGES) do
		if row.code == own or not allowed or allowed[row.code] then out[#out + 1] = row end
	end
	return out
end

-- The door's own functions: once the folder is loaded, its take their place.
local door = {}

function GroupFinder.Load()
	if GroupFinder.loaded then return true end
	local _, why = ns.Data.Pack(GroupFinder.ADDON)
	if not GroupFinder.loaded then return nil, why or "missing" end
	return true
end

local function say(why)
	ns.Print(why == "combat" and L["The group finder opens after combat."]
		or L["The group finder can't load: its folder Polestar_GroupFinder is missing or turned off."])
end

-- Loads the folder, then runs its function `name`.
local function via(name, ...)
	local ok, why = GroupFinder.Load()
	if not ok then
		say(why)
		return nil, why
	end
	if GroupFinder[name] ~= door[name] then return GroupFinder[name](...) end
	return nil, "missing"
end

for _, name in ipairs({ "Show", "Toggle", "Search", "Announce", "Hello", "Goodbye", "Command", "FindFor" }) do
	door[name] = function(...) return via(name, ...) end
end
for k, fn in pairs(door) do GroupFinder[k] = fn end

-- The guide window menu's row: the panel, where Find a group is; only while the finder is on.
function GroupFinder.MenuItems()
	if not ns.Get("groupFinder.enabled") then return {} end
	return { { text = L["Group Finder"], icon = "icon-group", tip = L["Players on your quests: find a group, the players found and their progress."],
		onClick = function() GroupFinder.Show() end } }
end

-- A goal row's "players on this quest" button (UI/GuideFrame.lua): on an open goal of a quest to kill, collect
-- or complete, only while the finder is loaded and on; gone otherwise.
local ROW_VERBS = { kill = true, collect = true, complete = true }
function GroupFinder.RowWanted(goal)
	if not (GroupFinder.loaded and ns.Get("groupFinder.enabled")) then return false end
	if type(goal) ~= "table" or not goal.quest or goal.status == "done" or goal.status == "skipped" then return false end
	return ROW_VERBS[goal.t] == true
end

-- A quest menu's row (UI/QuestLinks.lua: the quest log's and the tracker's right-click, the quest details'
-- Polestar button): a quest in the log, whatever the route, while the finder is on.
function GroupFinder.QuestMenuWanted(questID)
	return ns.Get("groupFinder.enabled") and type(questID) == "number" and ns.Compat.IsOnQuest(questID) and true or false
end

-- The guide window again, as the finder comes or goes (its rows' buttons).
function GroupFinder.Repaint()
	local G = ns.UI and ns.UI.GuideFrame
	if G and G.Render then G.Render() end
end

BINDING_NAME_POLESTAR_GF_SEARCH = L["Find a group"]
BINDING_NAME_POLESTAR_GF_PANEL = L["Group Finder panel"]
BINDING_NAME_POLESTAR_GF_ANNOUNCE = L["Announce my search"]
BINDING_NAME_POLESTAR_GF_HELLO = L["Say hello to the group"]
BINDING_NAME_POLESTAR_GF_GOODBYE = L["Goodbye and leave"]

ns.RegisterCommand("finder", function(arg) GroupFinder.Command(arg) end,
	L["Group Finder: the panel; search, stop, announce, test, debug"])

-- On at login: load it, so it listens and answers as the player asked.
ns.OnLogin(function()
	if ns.Get("groupFinder.enabled") then GroupFinder.Load() end
end)
ns.On("SETTING_CHANGED", function(path)
	if path ~= "groupFinder.enabled" and path ~= "" then return end
	if ns.Get("groupFinder.enabled") then GroupFinder.Load() end
	GroupFinder.Repaint()
end)
