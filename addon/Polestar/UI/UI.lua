-- Polestar.UI: the guide window, the guide picker and the options window.
-- This file holds what they share: the ui.* defaults, the goal text
-- formatting, and the routing of commands (TOGGLE_FRAME, SHOW_PICKER, ...).
--
-- The UI never re-derives guide state: it renders the Engine's step views
-- (docs/ARCHITECTURE.md, "Engine") and calls Engine/Nav for actions. Both are
-- looked up on the namespace at call time, never cached, so a missing module
-- degrades to an empty state instead of an error.

local ADDON, ns = ...
local UI = {}
ns.UI = UI

local Theme = ns.Theme
local L = ns.L
local format, type = string.format, type

ns.RegisterDefaults("ui", {
	shown = true,
	locked = false,
	growUp = false, -- pin the guide window by its bottom edge, so it grows upward
	compact = false,
	style = "standard", -- "standard" | "transparent"
	scale = 1,
	opacity = 1,
	bgOpacity = 0.94, -- the ground of every Polestar window
	width = 340,
	upcoming = 0, -- Up next is off by default (the reading flow names the next person instead)
	upcomingOpen = false, -- when on, upcoming steps start listed instead of collapsed
	showNotes = true,
	notesOpen = true, -- a step's tip starts in full; off, it starts on one line (players asked for it open)
	combat = "show", -- "show" | "fade" | "hide"; steady by default, a fade on every pull distracts
	reduceMotion = false,
	font = "game", -- "game" (the client's own font, the default) | "inter" (EllesmereUI's while matchFont is on)
	scheme = "dusk", -- "dusk" | "night" | "graphite" | "ellesmere" (Polestar.Theme.SCHEMES)
	accent = false, -- false: the scheme's (or EllesmereUI's) accent; { r, g, b }: your own
	bgColor = false, -- false: the scheme's ground; { r, g, b }: your own
	brightness = 0, -- -1..1: lifts or lowers every ground together
	matchAccent = true, -- with EllesmereUI: follow its accent
	classAccent = false, -- the accent follows the player's class colour
	matchFont = false, -- with EllesmereUI: follow its font (off: the game font stays the default)
	menuScale = 1, -- options and picker windows
	-- Every window's frame (Theme.WindowBorder, the "windowBorder" token):
	border = true, -- the window border
	borderColor = false, -- false: the scheme's hairline (or the accent); { r, g, b }: your own
	borderAccent = false, -- the border takes the accent
	borderSize = 1, -- 1..4 physical pixels, growing outward
	band = true, -- the starlit header band
	shadow = true, -- the window drop shadow
	pickerFaction = "auto", -- "auto" | "Alliance" | "Horde" | "All"
	-- pos = { left, top } once the window has been moved
})

UI.MIN_WIDTH, UI.MAX_WIDTH = 260, 560

-- The player's faction through Compat, when Compat is there.
function UI.PlayerFaction()
	local C = ns.Compat
	if C and C.GetPlayerInfo then
		local ok, info = pcall(C.GetPlayerInfo)
		if ok and type(info) == "table" and (info.faction == "Alliance" or info.faction == "Horde") then return info.faction end
	end
	return nil
end

-- A map's name, or "Map <id>" when nothing knows it.
local mapName = ns.Compat.MapName
function UI.MapName(map)
	return mapName(map) or (map and format(L["Map %d"], map)) or nil
end

function UI.QuestTitle(quest)
	local C = ns.Compat
	if quest and C and C.GetQuestTitle then
		local ok, title = pcall(C.GetQuestTitle, quest)
		if ok and title and title ~= "" then return title end
	end
	return nil
end

-- "1–6" / "12" / nil
function UI.LevelRange(lo, hi)
	if not lo and not hi then return nil end
	lo, hi = lo or hi, hi or lo
	if lo == hi then return tostring(lo) end
	return lo .. "\226\128\147" .. hi
end

-- Player-facing race names for the client's race files: the client's own
-- name (ChrRaces, through C_CreatureInfo.GetRaceInfo) for the Era races, by
-- their ChrRaces ID (the file alone is ambiguous: 23, Gilnean, is "Human" too).
-- Skyborne has a name per side ("High Order Skyborne", "Windshaper Skyborne")
-- and none for the race, so it and races the client lacks read L[name].
local RACE_ID = { Human = 1, Orc = 2, Dwarf = 3, NightElf = 4, Scourge = 5, Tauren = 6, Gnome = 7, Troll = 8 }
local RACE_NAMES = {
	Scourge = "Undead", NightElf = "Night Elf", BloodElf = "Blood Elf", HighmountainTauren = "Highmountain Tauren",
	LightforgedDraenei = "Lightforged Draenei", VoidElf = "Void Elf", DarkIronDwarf = "Dark Iron Dwarf",
	MagharOrc = "Mag'har Orc", KulTiran = "Kul Tiran", ZandalariTroll = "Zandalari Troll",
}
function UI.RaceName(file)
	if type(file) ~= "string" then return "" end
	local id = RACE_ID[file]
	local get = id and C_CreatureInfo and C_CreatureInfo.GetRaceInfo
	local info = get and get(id)
	if type(info) == "table" and type(info.raceName) == "string" and info.raceName ~= "" then return info.raceName end
	local name = RACE_NAMES[file] or file:gsub("(%l)(%u)", "%1 %2")
	return L[name]
end

function UI.ClassName(file)
	if type(file) ~= "string" then return "" end
	local names = LOCALIZED_CLASS_NAMES_MALE
	if type(names) == "table" and type(names[file]) == "string" then return names[file] end
	return L[file:sub(1, 1) .. file:sub(2):lower()]
end

function UI.ClassList(list)
	if type(list) ~= "table" then return nil end
	local out = {}
	for i, c in ipairs(list) do out[i] = UI.ClassName(c) end
	return #out > 0 and table.concat(out, ", ") or nil
end

-- The player's class, as the client names it ("Warrior").
function UI.PlayerClass()
	local C = ns.Compat
	if C and C.GetPlayerInfo then
		local ok, info = pcall(C.GetPlayerInfo)
		if ok and type(info) == "table" and type(info.class) == "string" then return UI.ClassName(info.class) end
	end
	return nil
end

function UI.Category(guide)
	local c = guide and guide.category
	if type(c) ~= "string" or c == "" then return "Leveling" end
	return c
end

-- Where a guide happens, as the player should read it: a leveling guide's
-- zone; for other categories (professions, reputation, ...) the guide's
-- zone is only a meaningful place when the guide belongs to one faction
-- (its capital); a both-faction guide's zone is an authoring detail and
-- reads as nothing here.
function UI.GuidePlace(guide)
	if not guide then return nil end
	local z = guide.zoneName
	if type(z) ~= "string" or z == "" then return nil end
	if UI.Category(guide) == "Leveling" or guide.faction then return z end
	return nil
end

-- The window's meta line: "Durotar · Levels 1–10" for leveling,
-- "Professions · Levels 5–30" (plus the faction's city when it has one).
function UI.GuideMeta(guide)
	local parts = {}
	local cat = UI.Category(guide)
	if cat ~= "Leveling" then parts[#parts + 1] = L[cat] end
	local place = UI.GuidePlace(guide)
	if place then parts[#parts + 1] = place end
	local lv = UI.LevelRange(guide.minLevel, guide.maxLevel)
	if lv then parts[#parts + 1] = L["Levels"] .. " " .. lv end
	return table.concat(parts, "  \194\183  ")
end

---------------------------------------------------------------------------
-- Goal text
---------------------------------------------------------------------------

local KIND_COLOR = {
	quest = "quest", npc = "npc", item = "item", place = "place", object = "object", level = "level",
	skill = "skill", spell = "spell", faction = "faction", area = "area", achievement = "achievement",
}

-- The goal's main line. The Engine's `text` is the truth (it carries author
-- overrides and counts such as "Kill 5 Young Wolf"); the subject is coloured
-- by its kind wherever it appears in that text. Done goals render plain (the
-- row colours them muted).
function UI.GoalText(goal)
	local text = goal.text
	local verb, subject = goal.verb, goal.subject
	if type(text) ~= "string" or text == "" then
		if verb and verb ~= "" and subject and subject ~= "" then
			text = verb .. " " .. subject
		else
			text = (subject ~= "" and subject) or verb or ""
		end
	end
	if goal.status == "done" then return text end
	local kind = KIND_COLOR[goal.subjectKind]
	if not kind or type(subject) ~= "string" or subject == "" then return text end
	local a, b = text:find(subject, 1, true)
	if not a then return text end
	return text:sub(1, a - 1) .. "|c" .. Theme.Hex(kind) .. subject .. "|r" .. text:sub(b + 1)
end

-- The goal's main line without colour codes (skipped goals).
function UI.PlainGoalText(goal)
	local text = goal.text
	if type(text) ~= "string" or text == "" then
		local verb, subject = goal.verb, goal.subject
		if verb and verb ~= "" and subject and subject ~= "" then
			text = verb .. " " .. subject
		else
			text = (subject ~= "" and subject) or verb or ""
		end
	end
	return text
end

-- "from Kobold Vermin (lvl 5–7)" for a farm spot (a collect goal whose
-- chosen candidate names its mobs and their levels).
local function farmSpot(goal)
	if goal.t ~= "collect" or type(goal.lvl) ~= "table" or type(goal.npcName) ~= "string" then return nil end
	local lo, hi = goal.lvl[1] or goal.lvl.min, goal.lvl[2] or goal.lvl.max
	local lv = UI.LevelRange(lo, hi)
	if lv then return string.format(L["from %s (lvl %s)"], goal.npcName, lv) end
	return string.format(L["from %s"], goal.npcName)
end

-- Secondary line. An unavailable quest says why ("Needs level 14"); a farm
-- spot names its mobs; a chosen candidate (trainer, vendor, inn, farm spot)
-- adds its zone; then the Engine's detail, the quest a kept grey accept
-- opens and the goal's own note.
function UI.GoalDetail(goal)
	if goal.unavailable then
		local why = goal.unavailableText
		if type(why) ~= "string" or why == "" then why = L["Not offered"] end
		return why
	end
	local parts = {}
	local farm = farmSpot(goal)
	if farm then parts[#parts + 1] = farm end
	local d = goal.detail
	if goal.optional then d = d and (d .. " \194\183 " .. L["optional"]) or L["Optional"] end
	if d then parts[#parts + 1] = d end
	local chosen = farm or (type(goal.alternatives) == "number" and goal.alternatives > 0)
	if chosen and goal.map then
		local zone = UI.MapName(goal.map)
		if zone and not (d and d:find(zone, 1, true)) then parts[#parts + 1] = zone end
	end
	if goal.keptGreyText then parts[#parts + 1] = goal.keptGreyText end
	if goal.note then parts[#parts + 1] = goal.note end
	if #parts == 0 then return nil end
	return table.concat(parts, "  \194\183  ")
end

-- "1,050" for XP amounts.
local function thousands(n)
	local s = tostring(math.floor(n + 0.5))
	local out = s:reverse():gsub("(%d%d%d)", "%1,"):reverse()
	return (out:gsub("^,", ""))
end

-- "1g 50s" from copper.
local function money(copper)
	local g, s, c = math.floor(copper / 10000), math.floor(copper / 100) % 100, copper % 100
	local parts = {}
	if g > 0 then parts[#parts + 1] = g .. "g" end
	if s > 0 then parts[#parts + 1] = s .. "s" end
	if c > 0 then parts[#parts + 1] = c .. "c" end
	return table.concat(parts, " ")
end

-- An item name in its quality colour: the client's quality when the item is
-- cached, else the compiled one; the item token without either.
local function rewardItem(it)
	local C = ns.Compat
	local q = (C and C.GetItemQuality and C.GetItemQuality(it.item)) or it.quality
	local hex = q and C and C.ItemQualityHex and C.ItemQualityHex(q) or Theme.Hex("item")
	return "|c" .. hex .. (it.itemName or ("#" .. it.item)) .. "|r"
end

local function itemList(list, joiner)
	local names = {}
	for i = 1, #list do names[i] = rewardItem(list[i]) end
	if #names < 2 then return names[1] end
	return table.concat(names, ", ", 1, #names - 1) .. " " .. joiner .. " " .. names[#names]
end

-- A turn-in's rewards on one line, already escaped: "Choose: Catacomb Cloak or
-- Deepgrave Trousers  ·  1,050 XP  ·  7s", item names in quality colours.
function UI.GoalRewards(goal)
	local r = goal.rewards
	if type(r) ~= "table" then return nil end
	local parts = {}
	if type(r.choices) == "table" and #r.choices > 0 then
		parts[#parts + 1] = format(L["Choose: %s"], itemList(r.choices, L["or"]))
	end
	if type(r.items) == "table" and #r.items > 0 then
		parts[#parts + 1] = format(L["Get: %s"], itemList(r.items, L["and"]))
	end
	if type(r.xp) == "number" and r.xp > 0 then parts[#parts + 1] = format(L["%s XP"], thousands(r.xp)) end
	if type(r.money) == "number" and r.money > 0 then parts[#parts + 1] = money(r.money) end
	if #parts == 0 then return nil end
	return table.concat(parts, "  \194\183  ")
end

-- An area objective (mobs spread over a wide area, `spread` with its spot
-- count): "Bristleback Geomancers all over this area: 12 spots". Kill goals
-- name their mobs; collect goals say what is found there.
function UI.AreaLine(goal)
	if not (goal.spread and type(goal.spots) == "number" and goal.spots > 0) then return nil end
	if goal.status == "done" or goal.status == "skipped" then return nil end
	if goal.t == "kill" and type(goal.subject) == "string" and goal.subject ~= "" then
		return format(L["%s all over this area: %d spots"], goal.subject, goal.spots)
	end
	return format(L["Found all over this area: %d spots"], goal.spots)
end

-- Creature ranks as the client names them.
local RANK = { [1] = L["elite"], [2] = L["rare elite"], [3] = L["boss"], [4] = L["rare"] }

-- "Aean Swiftriver (rare elite)": a source's name with its rank.
local function sourceName(src)
	local rank = RANK[src.rank]
	return rank and (src.name .. " (" .. rank .. ")") or src.name
end

-- Where a collected item comes from, when one source has it (the goal's
-- `source`): "Kill Aean Swiftriver (rare elite)" for an enemy, "From <name>"
-- for a friend or an object. An object named as the item is the item lying
-- there: nothing to add. Nil when the goal's text already names the source
-- ("Kill Grell or Grellkin for Fel Moss"); this line serves author text.
function UI.SourceLine(goal)
	local src = goal.source
	if goal.t ~= "collect" or type(src) ~= "table" or type(src.name) ~= "string" or src.inText then return nil end
	if goal.status == "done" or goal.status == "skipped" then return nil end
	if src.kind == "object" and src.name == goal.subject then return nil end
	local who = sourceName(src)
	if type(src.also) == "string" then who = format(L["%s or %s"], who, src.also) end
	return format(src.enemy and L["Kill %s"] or L["From %s"], who)
end

-- Group content (the goal's `party`, the compiled `group`): "Elite: group
-- advised", "Rare elite: group advised", "Boss: group advised", "Dungeon:
-- Dire Maul", "Raid: Molten Core", "Group of 3 advised" or "Group advised",
-- in the dungeon colour. Nil once the goal is done or skipped.
local ELITE_LINE = { [1] = L["Elite: group advised"], [2] = L["Rare elite: group advised"], [3] = L["Boss: group advised"] }
function UI.GroupLine(goal)
	local p = goal.party
	if type(p) ~= "table" or goal.status == "done" or goal.status == "skipped" then return nil end
	local text
	if p.kind == "elite" then
		text = ELITE_LINE[p.rank] or ELITE_LINE[1]
	elseif (p.kind == "dungeon" or p.kind == "raid") and type(p.name) == "string" then
		text = format(p.kind == "raid" and L["Raid: %s"] or L["Dungeon: %s"], p.name)
	elseif p.kind == "group" then
		text = type(p.size) == "number" and format(L["Group of %d advised"], p.size) or L["Group advised"]
	end
	return text and ("|c" .. Theme.Hex("dungeon") .. text .. "|r") or nil
end

-- How to get the item a quest starts from, on the quest's one line (the
-- goal's `starter`): "Runed Scroll: kill Aean Swiftriver (rare elite)", then
-- "Runed Scroll: in your bags, right-click it". An item lying there as an
-- object of its own name: "Dirt-stained Map: pick it up". Without a known
-- source, the item's own note ("Runed Scroll: Aean Swiftriver").
function UI.StarterLine(goal)
	local s = goal.starter
	if type(s) ~= "table" or goal.status == "done" or goal.status == "skipped" then return nil end
	local item = type(s.item) == "string" and s.item or ""
	if s.held then return format(L["%s: in your bags, right-click it"], item) end
	local src = s.source
	if type(src) == "table" and type(src.name) == "string" then
		if src.kind == "object" and src.name == item then return format(L["%s: pick it up"], item) end
		return format(src.enemy and L["%s: kill %s"] or L["%s: from %s"], item, sourceName(src))
	end
	local note = s.note
	if type(note) == "string" and note ~= "" and note ~= item then
		if note:sub(1, #item) == item then return note end
		return item .. ": " .. note
	end
	return format(L["Starts from %s"], item)
end

-- The goal a row paints. The collect that stands for a quest started by its
-- item (`starterOf`, docs/ARCHITECTURE.md "Tabs", the step view) is worded as that
-- quest's accept: its verb, title and note, no counter; everything else
-- (status, index, waypoint, spots) stays the collect's.
function UI.ReadingGoal(view, goal)
	local a = goal.starterOf and view.goals[goal.starterOf]
	if not a then return goal end
	return setmetatable({
		t = a.t, text = a.text, verb = a.verb, subject = a.subject, subjectKind = a.subjectKind,
		quest = a.quest, note = a.note or false, optional = a.optional, progress = false, source = false, party = a.party,
		keptGreyText = a.keptGreyText,
	}, { __index = goal })
end

-- The one line under a goal in the reading flow, only when it changes what
-- the player does: why a quest is unavailable, that the goal needs a group,
-- how to get the item a quest starts from, which later quest a grey accept
-- "Skip grey quests" keeps opens, whom an item is got from, that an
-- area objective's mobs are all over its area, which mobs a farm spot is,
-- where a chosen trainer/vendor is, the open objectives of a quest to
-- complete that has several, the goal's own note, and an open turn-in's
-- rewards. The rest of the detail ("for Kobold Camp Cleanup")
-- lives in the tooltip.
-- `shownMap`: a zone the window already names above (the person's), not repeated.
-- `noParty`: the group line already shows on a goal above (said once per card).
-- `noMissing`: so do the party members who lack this goal's quest.
function UI.GoalSubline(goal, shownMap, noParty, noMissing)
	if goal.unavailable then return UI.GoalDetail(goal) end
	local parts = {}
	local party = not noParty and UI.GroupLine(goal)
	if party then parts[#parts + 1] = party end
	local starter = UI.StarterLine(goal)
	if starter then parts[#parts + 1] = starter end
	-- A grey accept "Skip grey quests" keeps, and the quest it opens.
	if goal.keptGreyText and goal.status ~= "skipped" then parts[#parts + 1] = goal.keptGreyText end
	local source = UI.SourceLine(goal)
	if source then parts[#parts + 1] = source end
	local area = UI.AreaLine(goal)
	if area then parts[#parts + 1] = area end
	local farm = farmSpot(goal)
	if farm then parts[#parts + 1] = farm end
	local chosen = farm or (type(goal.alternatives) == "number" and goal.alternatives > 0)
	if chosen and goal.map and goal.map ~= shownMap then
		local zone = UI.MapName(goal.map)
		if zone then parts[#parts + 1] = zone end
	end
	if type(goal.objectives) == "table" then
		for i = 1, #goal.objectives do parts[#parts + 1] = goal.objectives[i] end
	end
	-- A note that only names the source or the item says nothing new.
	local note = goal.note
	if note and source and (note == goal.source.name or note == goal.subject) then note = nil end
	if note then parts[#parts + 1] = note end
	-- Party members' counts on this quest (Quests/Party.lua).
	local together = ns.Party and ns.Party.Line(goal, noMissing)
	if together then parts[#parts + 1] = together end
	local rewards = goal.t == "turnin" and goal.status ~= "done" and goal.status ~= "skipped" and UI.GoalRewards(goal) or nil
	if #parts == 0 then return rewards end
	local line = table.concat(parts, "  \194\183  ")
	return rewards and (line .. "  \194\183  " .. rewards) or line
end

-- A goal's line in the reading flow: the text with its counter right after it
-- ("Kill Zhevra Chargers 3/8"). The counter reads in the text colour while
-- open and in success once complete (done, or every count in); the accent is
-- kept for what you act on. Done goals' text renders plain (the row mutes
-- it); skipped goals drop the counter. Ranks and reputation carry their
-- numbers on their bar instead. (A counter cannot switch weight inside one
-- font string; it keeps the line's role.) An open optional goal ends in
-- "optional" in warning, so an extra is unmistakable and never reads as the
-- route; one the player skipped ends in "skipped" in textMuted.
function UI.GoalLine(goal)
	local plain = goal.status == "done" or goal.status == "skipped"
	local text = plain and UI.PlainGoalText(goal) or UI.GoalText(goal)
	local count = UI.GoalProgress(goal)
	if count and goal.status ~= "skipped" then
		local p = goal.progress
		local full = goal.status == "done" or (p.cur or 0) >= p.max
		text = text .. "  |c" .. Theme.Hex(full and "success" or "text") .. count .. "|r"
	end
	if goal.dismissed then
		text = text .. "  |c" .. Theme.Hex("textMuted") .. L["skipped"] .. "|r"
	elseif goal.optional and not plain and goal.t ~= "note" then
		text = text .. "  |c" .. Theme.Hex("warning") .. L["optional"] .. "|r"
	end
	return text
end

-- The groups of a step view (docs/ARCHITECTURE.md, "Focus: one person at a
-- time"). A step without goals is one empty group.
-- -> groups, focusIndex
function UI.StepGroups(view)
	if #view.groups > 0 then return view.groups, view.focus end
	return { { kind = "here", goals = {} } }, 1
end

-- How a group is named: a person or object by name; a field group by the
-- step title, else its first open goal.
function UI.GroupName(view, group)
	if group.kind ~= "here" and type(group.name) == "string" and group.name ~= "" then return group.name end
	if view.title and view.title ~= "" then return view.title end
	for _, gi in ipairs(group.goals or {}) do
		local g = view.goals[gi]
		if g and g.status ~= "na" then return UI.PlainGoalText(g) end
	end
	return ""
end

local function barKind(goal)
	local p = goal.progress
	if type(p) ~= "table" or type(p.max) ~= "number" or p.max <= 0 then return nil end
	if p.kind == "skill" or p.kind == "rep" then return p.kind end
	if goal.subjectKind == "achievement" then return "count" end
	return nil
end

-- "7/10" at the row's right edge, or nil. A lone 0/1 says nothing a
-- checkmark does not; ranks and reputation carry their numbers on the bar.
function UI.GoalProgress(goal)
	local p = goal.progress
	if type(p) == "table" and type(p.max) == "number" and p.max > 1 then
		local kind = barKind(goal)
		if kind == "skill" or kind == "rep" then return nil end
		return format("%d/%d", p.cur or 0, p.max)
	end
	return nil
end

-- Ranks, reputation and achievement criteria read better as a slim bar.
-- -> fraction 0..1, label | nil. Labels: "Alchemy 87/110" (the skill name
-- is dropped when the goal's text already says it), "Friendly 2150/6000";
-- criteria keep their count at the right edge and need no label.
function UI.GoalBar(goal)
	local kind = barKind(goal)
	if not kind then return nil end
	local p = goal.progress
	local frac = (p.cur or 0) / p.max
	if frac < 0 then frac = 0 elseif frac > 1 then frac = 1 end
	if kind == "count" then return frac, nil end
	local name = p.label
	if name and kind == "skill" and goal.text and goal.text:find(name, 1, true) then name = nil end
	local numbers = format("%d/%d", p.cur or 0, p.max)
	return frac, name and (name .. "  " .. numbers) or numbers
end

-- One-line summary for an upcoming step.
function UI.StepSummary(view)
	if view.title and view.title ~= "" then return view.title end
	for i = 1, #view.goals do
		local g = view.goals[i]
		if g.status ~= "na" then return g.text or "" end
	end
	return ""
end

function UI.FirstVerb(view)
	for i = 1, #view.goals do
		local g = view.goals[i]
		if g.status ~= "na" and g.t ~= "goto" then return g.t end
	end
	local g = view.goals[1]
	return g and g.t or "note"
end

---------------------------------------------------------------------------
-- Routing
---------------------------------------------------------------------------

ns.On("TOGGLE_FRAME", function() ns.Set("ui.shown", not ns.Get("ui.shown")) end)
ns.On("SHOW_FRAME", function() ns.Set("ui.shown", true) end)
ns.On("HIDE_FRAME", function() ns.Set("ui.shown", false) end)
ns.On("SHOW_PICKER", function() if UI.ShowPicker then UI.ShowPicker() end end)
ns.On("SHOW_OPTIONS", function(section) if UI.ShowOptions then UI.ShowOptions(section) end end)
-- The guide menu and the options from a key binding or a gamepad chord: open, or close when open.
ns.On("TOGGLE_PICKER", function()
	local P = UI.Picker
	if P and P.frame and P.frame:IsShown() then P.frame:Hide() elseif UI.ShowPicker then UI.ShowPicker() end
end)
ns.On("TOGGLE_OPTIONS", function()
	local O = UI.Options
	if O and O.frame and O.frame:IsShown() then O.frame:Hide() elseif UI.ShowOptions then UI.ShowOptions() end
end)
