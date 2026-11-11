-- Polestar.Dungeons, the dungeon mark: the Dungeons window's glyph after a
-- quest's name when the quest is one of a dungeon's quests, or one of the
-- NEAREST open prerequisites before one (Fitz, 0.3.8: so a player knows what
-- a long chain is for, A Recipe For Death before the Ruins of Lordaeron's
-- The New Plague). The guide window's goal rows and While you're here rows
-- carry it after the name, beside the "New in Forever" mark, and their
-- tooltips say why ("Needed for “The New Plague” in Ruins of Lordaeron",
-- "Part of the Ruins of Lordaeron quests"). Not the "Then:" lines, the
-- along-the-way rows or the step list.
--
--   Dungeons.QuestMark(id) -> { dungeon = name, quest = title | nil } | nil
--       quest: the dungeon quest it is needed for; nil when it is one
--   Dungeons.MarkAfter(id) -> " <glyph>" | ""     -- to put after quest id's name
--   Dungeons.MarkTooltip(id) -> text | nil         -- the tooltip line, glyph first
--
-- The set is built once per character, the first time a mark is asked for
-- with the Codex loaded (never loading it for this): every dungeon's quests
-- for the character's faction (Dungeons.Quests), and for each the last
-- NEAREST of its open prerequisites (Lookup.QuestChain, the pick-up guide's
-- source). A dungeon quest keeps its own mark over a prerequisite's; a
-- prerequisite of several keeps the first dungeon's, by the Dungeons list's
-- order (lowest level first). Built again when the Codex loads.

local ADDON, ns = ...
local Dungeons = ns.Dungeons
local L = ns.L

local format, floor = string.format, math.floor

local NEAREST = 3

local marks -- quest id -> mark; nil until built

local function build()
	local C, Lk = ns.Codex, ns.Lookup
	if not (C and C.IsLoaded and C.IsLoaded() and Lk and Lk.QuestChain and Dungeons.IsEnabled()) then return nil end
	if not Dungeons.Load() then return nil end
	local faction = UnitFactionGroup("player") == "Horde" and "H" or "A"
	local player = Lk.PlayerInfo and Lk.PlayerInfo()
	local out = {}
	local list = Dungeons.List()
	for _, d in ipairs(list) do
		for _, pq in ipairs(Dungeons.Quests(d.key, faction) or {}) do
			out[pq.id] = { dungeon = d.name }
		end
	end
	for _, d in ipairs(list) do
		for _, pq in ipairs(Dungeons.Quests(d.key, faction) or {}) do
			local chain = Lk.QuestChain(pq.id, player) or {}
			-- The chain ends with the quest itself: the NEAREST before it.
			local last = #chain
			if chain[last] and chain[last].id == pq.id then last = last - 1 end
			for i = last, math.max(1, last - NEAREST + 1), -1 do
				local r = chain[i]
				if r and not out[r.id] then out[r.id] = { dungeon = d.name, quest = pq.title } end
			end
		end
	end
	return out
end

function Dungeons.QuestMark(id)
	if type(id) ~= "number" then return nil end
	if not marks then
		marks = build()
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
	local text = m.quest and format(L["Needed for %s in %s"], ns.Quoted(m.quest), m.dungeon) or format(L["Part of the %s quests"], m.dungeon)
	return mark() .. " " .. text
end

ns.On("CODEX_LOADED", function() marks = nil end)
