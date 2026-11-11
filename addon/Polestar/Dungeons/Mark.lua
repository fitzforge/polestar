-- Polestar.Dungeons, the dungeon mark: the Dungeons window's glyph after a
-- quest's name when the quest is one of a dungeon's quests, or one of the
-- three nearest prerequisites before one in its chain (Fitz, 0.3.8: so a
-- player knows what a long chain is for, A Recipe For Death before the Ruins
-- of Lordaeron's The New Plague). The guide window's goal rows and While
-- you're here rows carry it after the name, beside the "New in Forever"
-- mark, and their tooltips say why ("Needed for “The New Plague” in Ruins of
-- Lordaeron", "Part of the Ruins of Lordaeron quests"). Not the "Then:"
-- lines, the along-the-way rows or the step list.
--
--   Dungeons.QuestMark(id) -> { key, quest = id | nil, breadcrumb = true | nil } | nil
--       key: the dungeon; quest: the dungeon quest it is needed for (nil:
--       it is one); breadcrumb: it only leads there (the pick-up guide's
--       "Leads to"), the tooltip says so instead of "Needed for"
--   Dungeons.MarkAfter(id) -> " <glyph>" | ""     -- to put after quest id's name
--   Dungeons.MarkTooltip(id) -> text | nil         -- the tooltip line, glyph first
--
-- Which quests is decided at build time: the Codex build writes them per side
-- into Dungeons1.lua (forge-data codex/journal.rs `marks_of`: a dungeon's own
-- quest keeps its own mark, a prerequisite of several dungeons the lowest
-- one's), Dungeons.Register("marks") keeps that, and the character's side's
-- string is read into a table once, the first time a mark is asked for
-- (nothing is loaded for it: without the Codex there are no marks).

local ADDON, ns = ...
local Dungeons = ns.Dungeons
local L = ns.L

local format, floor, tonumber, gmatch = string.format, math.floor, tonumber, string.gmatch

local marks -- quest id -> { key, quest, breadcrumb }; nil until read

local function read()
	local all = Dungeons.marks
	if type(all) ~= "table" or not Dungeons.IsEnabled() then return nil end
	local s = all[UnitFactionGroup("player") == "Horde" and "H" or "A"]
	local out = {}
	-- "id:key", "id:key:quest" or "id:key:quest:b" (a breadcrumb), ";"-separated.
	for id, key, quest, crumb in gmatch(type(s) == "string" and s or "", "(%d+):([^:;]+):?(%d*):?(b?)") do
		out[tonumber(id)] = { key = key, quest = tonumber(quest), breadcrumb = crumb == "b" or nil }
	end
	return out
end

function Dungeons.MarksChanged() marks = nil end

function Dungeons.QuestMark(id)
	if type(id) ~= "number" then return nil end
	if not marks then
		marks = read()
		if not marks then return nil end
	end
	return marks[id]
end

-- The glyph as an inline texture at the line's height, in the dungeon
-- colour (the Dungeons window's and the heads-up's), made again when the
-- colour changes (a new scheme).
local glyph, glyphFor
local function mark()
	local Theme = ns.Theme
	local r, g, b = Theme.Color("dungeon")
	local key = r .. "," .. g .. "," .. b
	if glyphFor ~= key then
		glyph = format("|T%s:0:0:0:0:32:32:0:32:0:32:%d:%d:%d|t", Theme.Media("icon-dungeon"), floor(r * 255 + 0.5), floor(g * 255 + 0.5), floor(b * 255 + 0.5))
		glyphFor = key
	end
	return glyph
end

function Dungeons.MarkAfter(id)
	return Dungeons.QuestMark(id) and (" " .. mark()) or ""
end

function Dungeons.MarkTooltip(id)
	local m = Dungeons.QuestMark(id)
	if not m then return nil end
	local d = Dungeons.Get(m.key)
	local name = d and d.name or m.key
	local text
	if m.quest then
		local UI, N, C = ns.UI, ns.Names, ns.Codex
		local title = (UI and UI.QuestTitle and UI.QuestTitle(m.quest)) or (N and N.Quest and N.Quest(m.quest))
		if not title and C and C.IsLoaded and C.IsLoaded() then
			local rec = C.Quest(m.quest)
			title = rec and rec.title
		end
		title = title or ("#" .. m.quest)
		text = m.breadcrumb and format(L["Leads to %s."], ns.Quoted(title)) or format(L["Needed for %s in %s"], ns.Quoted(title), name)
	else
		text = format(L["Part of the %s quests"], name)
	end
	return mark() .. " " .. text
end
