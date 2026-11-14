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
	lockHud = false, -- the arrow, the action buttons and the timers move only on a Shift-drag (ns.DragLocked)
	growUp = false, -- pin the guide window by its bottom edge, so it grows upward
	barsBottom = false, -- with growUp: tabs and navigator at the bottom, by the pinned edge
	compact = false,
	style = "standard", -- "standard" | "transparent"
	backing = "soft", -- transparent: "soft" (a light shade behind each line) | "dark" (a dark backing) | "none" (GuideFrame GF.SHADE, GF.VEIL)
	barShown = false, -- transparent: the tabs and the step bar stay shown instead of only under the cursor
	scale = 1,
	opacity = 1,
	bgOpacity = 0.94, -- the ground of every Polestar window
	width = 340,
	maxHeight = 0.5, -- the guide window's tallest, as a share of the screen's height; a longer step scrolls (#843)
	wholeStep = false, -- the card lists every goal of the step, finished ones kept, instead of one person at a time (#843)
	upcoming = 0, -- Up next is off by default (the reading flow names the next person instead)
	upcomingOpen = false, -- when on, upcoming steps start listed instead of collapsed
	showNotes = true,
	notesOpen = false, -- a step's tip starts on one line until clicked; on, it starts in full (Fitz, 2026-11-07: the full tip was a wall of text)
	combat = "show", -- "show" | "fade" | "hide"; steady by default, a fade on every pull distracts
	instance = "hide", -- "show" | "hide": in dungeons, raids, battlegrounds and arenas, until the player opens it there; hidden by default, a healer asked for it out of the way
	reduceMotion = false,
	classCardSound = true, -- the class-quest card's and the class quest heads-up's chime (UI/ClassCard.lua, UI/ClassToast.lua)
	skin = "polestar", -- "polestar" (the house style, the default) | "halo" | "hearth" | "forever" | "blizzard" | "classic" (Polestar.Theme, "Skins")
	font = "skin", -- "skin" (the game's in Polestar) | "opensans" | "game" | "inter" | "fira"
	textSize = 1, -- 0.8..1.4: every text role's size against its own (Theme.FontSpec), apart from the window scale
	scheme = "dusk", -- "dusk" | "night" | "graphite" | "ellesmere" (Polestar.Theme.SCHEMES)
	accent = false, -- false: the scheme's (or EllesmereUI's) accent; { r, g, b }: your own
	bgColor = false, -- false: the scheme's ground; { r, g, b }: your own
	brightness = 0, -- -1..1: lifts or lowers every ground together
	matchAccent = true, -- with EllesmereUI: follow its accent
	classAccent = false, -- the accent follows the player's class colour
	matchFont = false, -- with EllesmereUI: follow its font
	menuScale = 1, -- options and picker windows
	-- Every window's frame (Theme.WindowBorder, the "windowBorder" token):
	border = true, -- the window border
	borderColor = false, -- false: the scheme's hairline (or the accent); { r, g, b }: your own
	borderAccent = false, -- the border takes the accent
	borderSize = 1, -- 1..4 physical pixels, growing outward
	band = true, -- the starlit header band
	shadow = true, -- the window drop shadow
	pickerFaction = "auto", -- "auto" | "Alliance" | "Horde" | "All"
	-- pickerCollapsed = { [folder id] = true }: the guide menu's Browse folders folded away (UI.Picker.IsCollapsed)
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

-- "Human", "Dwarf and Gnome", "Orc, Troll, Tauren"; nil for none.
function UI.RaceList(list)
	if type(list) ~= "table" or #list == 0 then return nil end
	local out = {}
	for i, r in ipairs(list) do out[i] = UI.RaceName(r) end
	if #out == 2 then return format(L["%s and %s"], out[1], out[2]) end
	return table.concat(out, ", ")
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
-- zone (the client's name of its map, else the guide's English); for other
-- categories (professions, reputation, ...) the guide's zone is only a
-- meaningful place when the guide belongs to one faction (its capital); a
-- both-faction guide's zone is an authoring detail and reads as nothing here.
function UI.GuidePlace(guide)
	if not guide then return nil end
	local z = type(guide.zone) == "number" and mapName(guide.zone) or guide.zoneName
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

-- A `complete` goal reads as its quest's objectives (#942: "Complete Plagued
-- Lands" said nothing; the Engine's `objectiveLines`): one line each in the
-- game's words, with `counters` its count after it as other goals show one
-- ("Rabid Thistle Bear Captured  0/1"), else the lines joined by commas;
-- "Use Tharnariun's Hope:" first while the item the quest hands over is in
-- the bags (`useItem`). nil for any other goal, or one with no objective
-- text (it keeps "Complete <quest>").
local function objectiveText(goal, counters)
	local lines = goal.t == "complete" and goal.objectiveLines
	if type(lines) ~= "table" or #lines == 0 then return nil end
	local out = {}
	for i, o in ipairs(lines) do
		local s = o.text
		if counters and type(o.max) == "number" and o.max > 0 then
			local cur = o.cur or 0
			local full = goal.status == "done" or cur >= o.max
			s = s .. "  |c" .. Theme.Hex(full and "success" or "text") .. format("%d/%d", cur, o.max) .. "|r"
		end
		out[i] = s
	end
	local text = table.concat(out, counters and "\n" or ", ")
	if goal.useItem then text = format(L["Use %s:"], goal.useItem) .. " " .. text end
	return text
end

-- The quote mark closing a quest name in running text (ns.Quoted, in any
-- client language), with the space some languages put before it.
local CLOSE_QUOTES = { '"', "\226\128\157", "\226\128\156", "\194\187", "\194\171", "\227\128\141", "\227\128\143" }
local QUOTE_GAPS = { "", " ", "\194\160", "\226\128\175" }
local function pastQuote(text, b)
	for _, gap in ipairs(QUOTE_GAPS) do
		for _, q in ipairs(CLOSE_QUOTES) do
			local s = gap .. q
			if text:sub(b + 1, b + #s) == s then return b + #s end
		end
	end
	return b
end

-- The marks after quest q's name: the "New in Forever" one (NewQuests.Mark:
-- a quest Forever added, while ui.newInForever is on) and, with `dungeon`,
-- the dungeon one (Dungeons.MarkAfter: a dungeon's quest or one of the
-- nearest prerequisites before one). "" for none.
local function questMarks(q, dungeon)
	local NQ, Dg = ns.NewQuests, ns.Dungeons
	local mark = NQ and NQ.Mark(q) or ""
	if dungeon and Dg and Dg.MarkAfter then mark = mark .. Dg.MarkAfter(q) end
	return mark
end

-- The goal's quest name in `text` coloured `hex` (nil: left as it is) and
-- its marks after it, past its closing quote mark (questMarks; `dungeon`:
-- the dungeon mark too).
local function paintSubject(goal, text, hex, dungeon)
	local subject = goal.subject
	if type(subject) ~= "string" or subject == "" then return text end
	local mark = goal.subjectKind == "quest" and goal.quest and questMarks(goal.quest, dungeon) or ""
	if not hex and mark == "" then return text end
	local a, b = text:find(subject, 1, true)
	if not a then return text end
	local name = hex and ("|c" .. hex .. subject .. "|r") or subject
	if mark == "" then return text:sub(1, a - 1) .. name .. text:sub(b + 1) end
	local e = pastQuote(text, b)
	return text:sub(1, a - 1) .. name .. text:sub(b + 1, e) .. mark .. text:sub(e + 1)
end

-- `text` (a goal's line without colours) with its quest's marks after its
-- name, when it has any (`dungeon`: the dungeon mark too).
function UI.MarkQuestName(goal, text, dungeon)
	return paintSubject(goal, text, nil, dungeon)
end

-- A "While you're here" line's text (Engine's `hereText`), a turn-in's or a
-- quest to take's name with its marks after it (questMarks, the dungeon
-- mark too).
function UI.HereText(v)
	local text = v.hereText or ""
	local title = v.hereTitle
	if (v.here == "turnin" or v.here == "take") and type(title) == "string" and title ~= "" then
		local mark = questMarks(v.quest, true)
		local _, b
		if mark ~= "" then _, b = text:find(title, 1, true) end
		if b then text = text:sub(1, b) .. mark .. text:sub(b + 1) end
	end
	-- A timed quest's hand-in: its time left (Quests/Timed.lua).
	local timer = ns.Timed and ns.Timed.Badge(v)
	return timer and (text .. "  " .. timer) or text
end

-- A "While you're here" line's line under it ("Step 14", "Step 14, later in
-- this guide"), or with `tip` its tooltip's sentence on why doing it now
-- pays: the Engine's own words when it gives them (`hereSub`, `hereTip`: a
-- flight path line's), else its step's (`firstStep`: the earliest step that
-- holds the objective).
function UI.HereStep(v, tip)
	if tip then
		return v.hereTip or format(L["Step %d does this later; done now, that step is shorter or skipped when you get there."], UI.StepNo(v.firstStep or v.step))
	end
	return v.hereSub or format(v.later and L["Step %d, later in this guide"] or L["Step %d"], UI.StepNo(v.firstStep or v.step))
end

-- The goal's main line. The Engine's `text` is the truth (it carries author
-- overrides and counts such as "Kill 5 Young Wolf"); the subject is coloured
-- by its kind wherever it appears in that text (a quest's in `questHex`, an
-- "ffrrggbb", when given: the class-quest card's class colour), its marks
-- after its name (paintSubject; `dungeon`: the dungeon mark too, the guide
-- window's goal rows). Done goals render plain (the row colours them
-- muted). A `complete` goal: its objectives (objectiveText).
function UI.GoalText(goal, questHex, dungeon)
	local objectives = objectiveText(goal, false)
	if objectives then return objectives end
	local text = goal.text
	local verb, subject = goal.verb, goal.subject
	if type(text) ~= "string" or text == "" then
		if verb and verb ~= "" and subject and subject ~= "" then
			text = verb .. " " .. subject
		else
			text = (subject ~= "" and subject) or verb or ""
		end
	end
	local kind = goal.status ~= "done" and KIND_COLOR[goal.subjectKind]
	if not kind then return paintSubject(goal, text, nil, dungeon) end
	return paintSubject(goal, text, (kind == "quest" and questHex) or Theme.Hex(kind), dungeon)
end

-- The goal's main line without colour codes (skipped goals).
function UI.PlainGoalText(goal)
	local objectives = objectiveText(goal, false)
	if objectives then return objectives end
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
	return ns.MoneyText(copper)
end

-- An item name in its quality colour: the client's quality when the item is
-- cached, else the compiled one; the item token without either.
local function rewardItem(it)
	local C = ns.Compat
	local q = (C and C.GetItemQuality and C.GetItemQuality(it.item)) or it.quality
	local hex = q and C and C.ItemQualityHex and C.ItemQualityHex(q) or Theme.Hex("item")
	return "|c" .. hex .. (ns.Names.Item(it.item) or it.itemName or ("#" .. it.item)) .. "|r"
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

-- What doing a quest opens up (Unlocks.For), as tooltip lines appended to
-- `lines`: "Leads to" with up to UNLOCKS_SHOWN follow-ups ("The Defias
-- Brotherhood (part 2 of 7)", "Solomon's Law, from Magistrate Solomon"),
-- "+N more", then the chain's last quest and its reward. Nothing when the
-- quest opens nothing known.
local UNLOCKS_SHOWN = 4
local function unlockLabel(e)
	local label = ns.Quoted(e.title)
	if e.part then label = format(L["%s (part %d of %d)"], label, e.part, e.of) end
	if e.giver then label = format(L["%s, from %s"], label, e.giver) end
	return label
end
function UI.UnlockLines(quest, lines)
	local U = ns.Unlocks
	local u = U and U.For(quest)
	if not u then return lines end
	for i, e in ipairs(u.next) do
		if i > UNLOCKS_SHOWN then
			lines[#lines + 1] = { left = "", right = format(L["+%d more"], #u.next - UNLOCKS_SHOWN) }
			break
		end
		lines[#lines + 1] = { left = i == 1 and L["Leads to"] or "", right = unlockLabel(e) }
	end
	local last = u.last
	if last then
		lines[#lines + 1] = { left = L["Chain ends with"], right = format(L["%s (part %d)"], ns.Quoted(last.title), last.part) }
		local rewards = last.rewards and UI.GoalRewards({ rewards = last.rewards })
		if rewards then lines[#lines + 1] = { left = L["Final reward"], right = rewards } end
	end
	return lines
end

-- Engine.SkipLoses' list as one line: "Skipping also skips: A, B, C, D and 2
-- more", the parts of a series under one title ("The People's Militia (2
-- parts)"); nil for none.
function UI.SkipLosesText(list)
	if type(list) ~= "table" or #list == 0 then return nil end
	local titles, count = {}, {}
	for _, e in ipairs(list) do
		if not count[e.title] then titles[#titles + 1] = e.title end
		count[e.title] = (count[e.title] or 0) + 1
	end
	local names = {}
	for i = 1, math.min(#titles, UNLOCKS_SHOWN) do
		local t = titles[i]
		names[i] = count[t] > 1 and format(L["%s (%d parts)"], ns.Quoted(t), count[t]) or ns.Quoted(t)
	end
	local text = table.concat(names, ", ")
	if #titles > UNLOCKS_SHOWN then text = format(L["%s and %d more"], text, #titles - UNLOCKS_SHOWN) end
	return format(L["Skipping also skips: %s"], text)
end

-- An area objective (mobs spread over a wide area, `spread` with its spot
-- count): "Bristleback Geomancers all over this area: 12 spots". Kill goals
-- name their mobs; collect goals say what is found there. A goal of exact
-- points (`exact`: an object's spawns, a mob at a few fixed places, #1944)
-- says how many and that the arrow leads to each.
function UI.AreaLine(goal)
	if not (type(goal.spots) == "number" and goal.spots > 0 and (goal.spread or goal.exact)) then return nil end
	if goal.status == "done" or goal.status == "skipped" then return nil end
	if goal.exact then
		return goal.spots > 1 and format(L["%d known places: the arrow leads to each in turn"], goal.spots) or nil
	end
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
		text = format(p.kind == "raid" and L["Raid: %s"] or L["Dungeon: %s"], (type(p.map) == "number" and ns.Names.Instance(p.map)) or p.name)
	elseif p.kind == "group" then
		text = type(p.size) == "number" and format(L["Group of %d advised"], p.size) or L["Group advised"]
	end
	return text and ("|c" .. Theme.Hex("dungeon") .. text .. "|r") or nil
end

-- An escort quest (the goal's compiled `escort`): its NPC walks off with
-- whoever took it last and is gone until it respawns, so a player who finds
-- the spot empty knows to wait. In the dungeon colour, as the group line.
-- Nil once the goal is done or skipped.
function UI.EscortLine(goal)
	if goal.escort ~= true or goal.status == "done" or goal.status == "skipped" then return nil end
	return "|c" .. Theme.Hex("dungeon") .. L["Escort: if the NPC is not there, wait for it to respawn"] .. "|r"
end

-- A dungeon's way in (the goal view's `entrance`: a dungeon guide's "Enter
-- <dungeon>" step, a leveling guide's `when dungeon` run): where to find a
-- group, with the player's key for the client's group finder
-- (TOGGLEGROUPFINDER, named as the client names it: "I"), else without a
-- key. Nil once done or skipped, inside an instance, or in a full party.
function UI.FinderLine(goal)
	if goal.entrance ~= true or goal.status == "done" or goal.status == "skipped" then return nil end
	if IsInInstance and IsInInstance() then return nil end
	if (GetNumSubgroupMembers and GetNumSubgroupMembers() or 0) >= 4 then return nil end
	local key = GetBindingKey and GetBindingKey("TOGGLEGROUPFINDER")
	if key == "" then key = nil end
	local named = key and GetBindingText and GetBindingText(key)
	if type(named) == "string" and named ~= "" then key = named end
	local text = key and format(L["Need a group? Press %s for the group finder."], key) or L["Need a group? Open the group finder."]
	return "|c" .. Theme.Hex("dungeon") .. text .. "|r"
end

-- A guide as the guide list names it, with its levels: "Badlands &
-- Desolace (37–38)"; just the title (or id) when it has none.
function UI.GuideLabel(g)
	local title = g.title or g.id
	local lv = UI.LevelRange(g.minLevel, g.maxLevel)
	return lv and (title .. " (" .. lv .. ")") or title
end

-- Quest work a later guide hands in (the goal's `carriedTo`, Engine
-- Own.carriedTo: once per step): "Keep this: you hand it in later in
-- Badlands & Desolace (37–38)", the guide with its levels so it reads as a
-- later guide ("Keep this: a later guide hands it in" when that guide is not
-- installed). Nil once the goal is skipped. UI.GoalSubline puts it on a line
-- of its own, after the goal's other subline.
function UI.CarriedLine(goal)
	local to = goal.carriedTo
	if type(to) ~= "string" or goal.status == "skipped" then return nil end
	local G = ns.Guides
	local later = G and G.Get and G.Get(to)
	if later then return format(L["Keep this: you hand it in later in %s"], UI.GuideLabel(later)) end
	return L["Keep this: a later guide hands it in"]
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
		escort = a.escort or false,
		keptGreyText = a.keptGreyText,
	}, { __index = goal })
end

-- A material goal's line (the Engine's `materials`; Core/Materials.lua): what
-- the bank, the mail and the other characters hold, and on an Auction House
-- goal what is still to buy, priced for that many: "40 in your bank  ·  47 to
-- buy  ·  ≈ 87s". A price older than 3 days says so; one for fewer than that
-- count says how many are listed.
function UI.MaterialsLine(goal)
	local m = goal.materials
	if type(m) ~= "table" then return nil end
	local parts = {}
	if m.bank > 0 then parts[#parts + 1] = format(L["%s in your bank"], thousands(m.bank)) end
	if m.mail > 0 then parts[#parts + 1] = format(L["%s in your mail"], thousands(m.mail)) end
	for i = 1, math.min(2, #m.alts) do
		parts[#parts + 1] = format(L["%s has %s"], m.alts[i].name, thousands(m.alts[i].count))
	end
	if goal.t == "auction" and m.toGet > 0 then
		parts[#parts + 1] = format(L["%s to buy"], thousands(m.toGet))
		if m.price then
			local price = format(L["≈ %s"], money(m.price))
			if m.listed then price = price .. " " .. format(L["(only %s listed)"], thousands(m.listed)) end
			if m.age and m.age > 3 * 86400 then price = price .. " " .. L["(old price)"] end
			parts[#parts + 1] = price
		end
	end
	if #parts == 0 then return nil end
	return table.concat(parts, "  \194\183  ")
end

-- The one line under a goal in the reading flow, only when it changes what
-- the player does: why a quest is unavailable, that the goal needs a group,
-- that it is an escort, how to get the item a quest starts from, which later
-- quest a grey accept "Skip grey quests" keeps opens, whom an item is got
-- from, that an area objective's mobs are all over its area, which mobs a
-- farm spot is, where a chosen trainer/vendor is, what a travel step's
-- flight or walk leads to, a material's counts out of the bags and what is
-- still to buy (UI.MaterialsLine), the goal's own note (a
-- `complete` goal's objectives are its main line), and an open turn-in's
-- rewards; then, on a line of its own, that a later guide hands the quest
-- in (UI.CarriedLine: keep it). The rest of the detail ("for Kobold Camp
-- Cleanup") lives in the tooltip.
-- `shownMap`: a zone the window already names above (the person's), not repeated.
-- `noParty`: the group line already shows on a goal above (said once per card).
-- `noMissing`: so do the party members who lack this goal's quest.
-- `noEscort`: the escort line already shows on a goal above (once per card).
-- `noFinder`: so does the group finder line (UI.FinderLine).
function UI.GoalSubline(goal, shownMap, noParty, noMissing, noEscort, noFinder)
	if goal.unavailable then return UI.GoalDetail(goal) end
	local parts = {}
	-- An accept the game does not confirm says so first (not in the quest
	-- log; not offered by its giver: report it).
	if goal.noticeText then parts[#parts + 1] = goal.noticeText end
	-- A timed quest: before it is taken, how long it allows; while its clock
	-- runs, when the way to its hand-in takes longer than the time left
	-- (Quests/Timed.lua).
	local T = ns.Timed
	local timed = T and (T.LimitText(goal) or T.Hint(goal))
	if timed then parts[#parts + 1] = timed end
	local party = not noParty and UI.GroupLine(goal)
	if party then parts[#parts + 1] = party end
	local escort = not noEscort and UI.EscortLine(goal)
	if escort then parts[#parts + 1] = escort end
	local finder = not noFinder and UI.FinderLine(goal)
	if finder then parts[#parts + 1] = finder end
	local starter = UI.StarterLine(goal)
	if starter then parts[#parts + 1] = starter end
	-- A `direct` hand-in: its giver offers it and takes it back in one talk.
	if goal.directText then parts[#parts + 1] = goal.directText end
	-- A hearth goal while the Hearthstone waits, or while travelling there
	-- is about as fast: what to do (#576).
	if goal.hearthText then parts[#parts + 1] = goal.hearthText end
	-- A travel step's flight or walk: the work it leads to (#1588).
	if goal.purposeText then parts[#parts + 1] = goal.purposeText end
	-- A level goal: the XP still to earn.
	if goal.xpLeft then parts[#parts + 1] = format(L["%s XP to go"], thousands(goal.xpLeft)) end
	-- Finished quests the guide hands in before the level is needed (#1431):
	-- what they give, or that they cover it ("hand in first").
	if goal.xpLeft and (goal.readyXp or 0) > 0 then
		parts[#parts + 1] = format(L["your finished quests give %s: hand them in first"], thousands(goal.readyXp))
	elseif goal.handInFirst then
		parts[#parts + 1] = L["Hand in first: your finished quests cover it"]
	end
	-- A material: the bank's, the mail's and the other characters' counts, what is still to buy.
	local mats = UI.MaterialsLine(goal)
	if mats then parts[#parts + 1] = mats end
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
	-- A note that only names the source or the item says nothing new.
	local note = goal.note
	if note and source and (note == goal.source.name or note == goal.subject) then note = nil end
	if note then parts[#parts + 1] = note end
	-- Party members' counts on this quest (Quests/Party.lua).
	local together = ns.Party and ns.Party.Line(goal, noMissing)
	if together then parts[#parts + 1] = together end
	local rewards = goal.t == "turnin" and goal.status ~= "done" and goal.status ~= "skipped" and UI.GoalRewards(goal) or nil
	local line
	if #parts > 0 then
		line = table.concat(parts, "  \194\183  ")
		if rewards then line = line .. "  \194\183  " .. rewards end
	else
		line = rewards
	end
	-- To keep the quest: a line of its own, after the rest.
	local carried = UI.CarriedLine(goal)
	if carried then line = line and (line .. "\n" .. carried) or carried end
	return line
end

-- A goal's line in the reading flow: the text with its counter right after it
-- ("Kill Zhevra Chargers 3/8"). The counter reads in the text colour while
-- open and in success once complete (done, or every count in); the accent is
-- kept for what you act on. Done goals' text renders plain (the row mutes
-- it); skipped goals drop the counter. Ranks and reputation carry their
-- numbers on their bar instead. (A counter cannot switch weight inside one
-- font string; it keeps the line's role.) An open optional goal ends in
-- "optional" in warning, so an extra is unmistakable and never reads as the
-- route; one the player skipped ends in "skipped" in textMuted. questHex:
-- the quest name's colour instead of the theme's (UI.GoalText); `dungeon`:
-- the dungeon mark after the quest's name too (Dungeons/Mark.lua: the goal
-- rows and While you're here rows, not the "Then:" lines, along-the-way rows
-- or step list). A `complete` goal: a line per objective, each with its own
-- counter (objectiveText).
function UI.GoalLine(goal, questHex, dungeon)
	local plain = goal.status == "done" or goal.status == "skipped"
	local text = objectiveText(goal, goal.status ~= "skipped")
	if not text then
		text = plain and UI.MarkQuestName(goal, UI.PlainGoalText(goal), dungeon) or UI.GoalText(goal, questHex, dungeon)
		local count = UI.GoalProgress(goal)
		if count and goal.status ~= "skipped" then
			local p = goal.progress
			local full = goal.status == "done" or (p.cur or 0) >= p.max
			text = text .. "  |c" .. Theme.Hex(full and "success" or "text") .. count .. "|r"
		end
	end
	-- A timed quest's open goal: its time left (Quests/Timed.lua).
	local timer = not plain and ns.Timed and ns.Timed.Badge(goal)
	if timer then text = text .. "  " .. timer end
	if goal.dismissed then
		text = text .. "  |c" .. Theme.Hex("textMuted") .. L["skipped"] .. "|r"
	elseif goal.optional and not plain and goal.t ~= "note" then
		text = text .. "  |c" .. Theme.Hex("warning") .. L["optional"] .. "|r"
	end
	return text
end

-- A count ("0/6", "3/10", a party member's "2/6") never splits across lines:
-- the client breaks a wrapped string after "/", which left "0/" at a line's
-- end and the "6" under it (#1684). UI.SetCounted(fs, text) sets a string's
-- text and keeps it; UI.FitCounts(fs), once the string's width is set, moves
-- a count that would start on one line and end on the next whole onto the
-- next: the spaces before it (and its colour code) become a line break. The
-- test is the string's own height through the count's first character and
-- through its last, so it holds whatever the client's break rules are. A
-- string whose text was set otherwise since is left alone.
function UI.SetCounted(fs, text)
	fs.psCounted, fs.psFitted = text, text
	fs:SetText(text)
end

function UI.FitCounts(fs)
	local text = fs.psCounted
	if type(text) ~= "string" or fs:GetText() ~= fs.psFitted then return end
	if not text:find("%d/%d") then return end
	fs:SetText(text)
	local lh = fs:GetLineHeight()
	local out = text
	if lh and lh > 0 and fs:GetStringHeight() > lh * 1.5 then
		local from = 1
		while true do
			local s, e = out:find("%d+/%d+", from)
			if not s then break end
			fs:SetText(out:sub(1, s))
			local before = fs:GetStringHeight()
			fs:SetText(out:sub(1, e))
			if fs:GetStringHeight() > before + 0.5 then
				local b = s
				if b > 10 and out:sub(b - 10, b - 1):find("^|c%x%x%x%x%x%x%x%x$") then b = b - 10 end
				local a = b
				while a > 1 and out:sub(a - 1, a - 1) == " " do a = a - 1 end
				if a > 1 and a < b and out:sub(a - 1, a - 1) ~= "\n" then
					out = out:sub(1, a - 1) .. "\n" .. out:sub(b)
					e = e - (b - a) + 1
				end
			end
			from = e + 1
		end
		fs:SetText(out)
	end
	fs.psFitted = out
end

-- Step i of the active guide as the player counts it: steps that do not
-- exist for the character (another class's or race's, Engine.StepNumber)
-- left out (#942); whether it is such a step; how many the player sees. `E`:
-- what to ask instead of the Engine (a guide window's content, which answers
-- as the Engine does).
function UI.StepNo(i, E)
	E = E or ns.Engine
	if E and E.StepNumber and type(i) == "number" then return (E.StepNumber(i)) end
	return i
end
function UI.StepHidden(i, E)
	E = E or ns.Engine
	if not (E and E.StepNumber and type(i) == "number") then return false end
	local _, hidden = E.StepNumber(i)
	return hidden == true
end
function UI.StepTotal(E)
	E = E or ns.Engine
	if E and E.StepTotal then return E.StepTotal() end
	return E and E.GetStepCount and E.GetStepCount() or 0
end

-- The groups of a step view (docs/ARCHITECTURE.md, "Focus: one person at a
-- time"). A step without goals is one empty group.
-- -> groups, focusIndex
function UI.StepGroups(view)
	if #view.groups > 0 then return view.groups, view.focus end
	return { { kind = "here", goals = {} } }, 1
end

-- An object named after one of the quests it starts while it starts another
-- too (Auberdine's poster, which Forever names "WANTED: Murkdeep!", gives
-- WANTED: Jai'vhanel as well, #942) would head the other quest with a title
-- not its own: the first of its goals' notes that names the object (shares
-- a word of four letters or more with its name: "The WANTED poster outside
-- the inn") stands for it, else a neutral label. -> name
local function objectName(view, group)
	local name, titled, quests = group.name, nil, {}
	for _, gi in ipairs(group.goals or {}) do
		local g = view.goals[gi]
		if g and g.status ~= "na" and g.quest then
			quests[g.quest] = true
			if g.subjectKind == "quest" and g.subject == name then titled = g.quest end
		end
	end
	quests[titled or false] = nil
	if not titled or next(quests) == nil then return name end
	local words = {}
	for w in name:lower():gmatch("%w+") do
		if #w >= 4 then words[w] = true end
	end
	for _, gi in ipairs(group.goals) do
		local g = view.goals[gi]
		if g and g.status ~= "na" and type(g.note) == "string" then
			for w in g.note:lower():gmatch("%w+") do
				if words[w] then return g.note end
			end
		end
	end
	return L["The object here"]
end

-- How a group is named: a person or object by name (objectName); a field
-- group by the step title, else its first open goal.
function UI.GroupName(view, group)
	if group.kind ~= "here" and type(group.name) == "string" and group.name ~= "" then
		return group.kind == "object" and objectName(view, group) or group.name
	end
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
	if p.kind == "skill" or p.kind == "rep" or p.kind == "wait" then return p.kind end
	if goal.subjectKind == "achievement" then return "count" end
	return nil
end

-- "7/10" at the row's right edge, or nil. A lone 0/1 says nothing a
-- checkmark does not; ranks and reputation carry their numbers on the bar.
function UI.GoalProgress(goal)
	local p = goal.progress
	if type(p) == "table" and type(p.max) == "number" and p.max > 1 then
		local kind = barKind(goal)
		if kind == "skill" or kind == "rep" or kind == "wait" then return nil end
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
	-- A `wait`: the time left, draining from full.
	if kind == "wait" then
		local left = math.max(0, p.cur or 0)
		return frac, format(L["%d:%02d left"], math.floor(left / 60), left % 60)
	end
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

-- The window's toggle (its key, /polestar, the menu's Guide window) asks to
-- see the guide: from hidden it brings Polestar back, turning the window on
-- when it was off. A window that is on but that another addon keeps out of
-- sight (ns.OutOfSight) stays on: turning it off would take away only the
-- action buttons, the one part still seen. The toggle says why the window is
-- not seen instead, as it and /polestar show do after showing one that stays
-- out of sight. Paused, Polestar resumes (Core/Init.lua) and shows the
-- window: inside, a ui.shown set again opens it for the visit (GuideFrame.lua's
-- APPLY), as /polestar show does.
local function windowOutOfSight()
	local GF = UI.GuideFrame
	return GF ~= nil and ns.OutOfSight(GF.frame)
end
local function resumeForWindow()
	if not ns.PauseHides("window") then return false end
	ns.SetHidden(false)
	ns.SetPaused(false, "window")
	ns.Set("ui.shown", true)
	return true
end
ns.On("TOGGLE_FRAME", function()
	if resumeForWindow() then return end
	if ns.Hidden() then
		ns.SetHidden(false)
		if not ns.Get("ui.shown") then ns.Set("ui.shown", true) end
	else
		local GF = UI.GuideFrame
		if GF and GF.ToggleInside and GF.ToggleInside() then return end
		if not (ns.Get("ui.shown") and windowOutOfSight()) then
			ns.Set("ui.shown", not ns.Get("ui.shown"))
			if not ns.Get("ui.shown") then return end
		end
	end
	if windowOutOfSight() then ns.SayOutOfSight() end
end)
ns.On("SHOW_FRAME", function()
	if resumeForWindow() then return end
	ns.SetHidden(false)
	ns.Set("ui.shown", true)
	if windowOutOfSight() then ns.SayOutOfSight() end
end)
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
