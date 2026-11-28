-- What an item breaks into when an Enchanter disenchants it: an uncommon
-- (green) or rare (blue) weapon or armour's tooltip says so for a character
-- with Enchanting, "Disenchants into: 1-2 Strange Dust (or 1-2 Lesser
-- Magic Essence)": the likeliest result with its count range, and the next
-- one when it comes up often enough to count on (QoL.DISENCHANT_ALSO percent
-- or more; a 5% shard is left out). Armour gives mostly dust, weapons mostly
-- essence, rare items a shard. No Enchanting, another quality or class, or an
-- item level no band covers: no line.
--
-- The table is the client's ItemDisenchantLoot (item class, quality and item
-- level band) with each band's loot from the server's templates: data/disenchant.json
-- is its source and a test keeps this copy equal to it.
--
--   QoL.DisenchantLoot(classID, quality, itemLevel) -> { { item, chance, min, max }, ... } | nil   -- best first
--   QoL.DisenchantText(classID, quality, itemLevel) -> text | nil   -- the line's words, without the Enchanting check
--   QoL.DisenchantLine(itemID, link?) -> text | nil   -- the line for this character
--
-- Client: C_Item.GetItemInfo's quality and item level, C_Item.GetItemInfoInstant's class, the Enchanting
-- skill line (Compat.GetSkillRank).

local ADDON, ns = ...
local L = ns.L
local QoL = ns.QoL

local format = string.format

local ENCHANTING = 333
QoL.DISENCHANT_ALSO = 15

-- The English names, for a result the client has not cached yet.
local NAMES = {
	[10938] = "Lesser Magic Essence",
	[10939] = "Greater Magic Essence",
	[10940] = "Strange Dust",
	[10978] = "Small Glimmering Shard",
	[10998] = "Lesser Astral Essence",
	[11082] = "Greater Astral Essence",
	[11083] = "Soul Dust",
	[11084] = "Large Glimmering Shard",
	[11134] = "Lesser Mystic Essence",
	[11135] = "Greater Mystic Essence",
	[11137] = "Vision Dust",
	[11138] = "Small Glowing Shard",
	[11139] = "Large Glowing Shard",
	[11174] = "Lesser Nether Essence",
	[11175] = "Greater Nether Essence",
	[11176] = "Dream Dust",
	[11177] = "Small Radiant Shard",
	[11178] = "Large Radiant Shard",
	[14343] = "Small Brilliant Shard",
	[14344] = "Large Brilliant Shard",
	[16202] = "Lesser Eternal Essence",
	[16203] = "Greater Eternal Essence",
	[16204] = "Illusion Dust",
	[20725] = "Nexus Crystal",
	[22448] = "Small Prismatic Shard",
}

-- Class (2 weapon, 4 armour), quality (2 uncommon, 3 rare), item level from, to; the loot best first:
-- { item, chance in percent, fewest, most }.
local BANDS = {
	{ 2, 2, 5, 15, { {10938, 80, 1, 2}, {10940, 20, 1, 2} } },
	{ 2, 2, 16, 20, { {10939, 75, 1, 2}, {10940, 20, 2, 3}, {10978, 5, 1, 1} } },
	{ 2, 2, 21, 25, { {10998, 75, 1, 2}, {10940, 15, 4, 6}, {10978, 10, 1, 1} } },
	{ 2, 2, 26, 30, { {11082, 75, 1, 2}, {11083, 20, 1, 2}, {11084, 5, 1, 1} } },
	{ 2, 2, 31, 35, { {11134, 75, 1, 2}, {11083, 20, 2, 5}, {11138, 5, 1, 1} } },
	{ 2, 2, 36, 40, { {11135, 75, 1, 2}, {11137, 20, 1, 2}, {11139, 5, 1, 1} } },
	{ 2, 2, 41, 45, { {11174, 75, 1, 2}, {11137, 20, 2, 5}, {11177, 5, 1, 1} } },
	{ 2, 2, 46, 50, { {11175, 75, 1, 2}, {11176, 20, 1, 2}, {11178, 5, 1, 1} } },
	{ 2, 2, 51, 55, { {16202, 75, 1, 2}, {11176, 22, 2, 5}, {14343, 3, 1, 1} } },
	{ 2, 2, 56, 60, { {16203, 75, 1, 2}, {16204, 22, 1, 2}, {14344, 3, 1, 1} } },
	{ 2, 2, 61, 99, { {16203, 75, 2, 3}, {16204, 22, 2, 5}, {14344, 3, 1, 1} } },
	{ 2, 3, 5, 15, { {10978, 100, 1, 1} } },
	{ 2, 3, 16, 20, { {10978, 100, 1, 1} } },
	{ 2, 3, 21, 25, { {10978, 100, 1, 1} } },
	{ 2, 3, 26, 30, { {11084, 100, 1, 1} } },
	{ 2, 3, 31, 35, { {11138, 100, 1, 1} } },
	{ 2, 3, 36, 40, { {11139, 100, 1, 1} } },
	{ 2, 3, 41, 45, { {11177, 100, 1, 1} } },
	{ 2, 3, 46, 50, { {11178, 100, 1, 1} } },
	{ 2, 3, 51, 55, { {14343, 100, 1, 1} } },
	{ 2, 3, 56, 60, { {14344, 99.5, 1, 1}, {20725, 0.5, 1, 1} } },
	{ 2, 3, 61, 99, { {22448, 99.5, 1, 1}, {20725, 0.5, 1, 1} } },
	{ 4, 2, 5, 15, { {10940, 80, 1, 2}, {10938, 20, 1, 2} } },
	{ 4, 2, 16, 20, { {10940, 75, 2, 3}, {10939, 20, 1, 2}, {10978, 5, 1, 1} } },
	{ 4, 2, 21, 25, { {10940, 75, 4, 6}, {10998, 15, 1, 2}, {10978, 10, 1, 1} } },
	{ 4, 2, 26, 30, { {11083, 75, 1, 2}, {11082, 20, 1, 2}, {11084, 5, 1, 1} } },
	{ 4, 2, 31, 35, { {11083, 75, 2, 5}, {11134, 20, 1, 2}, {11138, 5, 1, 1} } },
	{ 4, 2, 36, 40, { {11137, 75, 1, 2}, {11135, 20, 1, 2}, {11139, 5, 1, 1} } },
	{ 4, 2, 41, 45, { {11137, 75, 2, 5}, {11174, 20, 1, 2}, {11177, 5, 1, 1} } },
	{ 4, 2, 46, 50, { {11176, 75, 1, 2}, {11175, 20, 1, 2}, {11178, 5, 1, 1} } },
	{ 4, 2, 51, 55, { {11176, 75, 2, 5}, {16202, 20, 1, 2}, {14343, 5, 1, 1} } },
	{ 4, 2, 56, 60, { {16204, 75, 1, 2}, {16203, 20, 1, 2}, {14344, 5, 1, 1} } },
	{ 4, 2, 61, 99, { {16204, 75, 2, 5}, {16203, 20, 2, 3}, {14344, 5, 1, 1} } },
	{ 4, 3, 5, 15, { {10978, 100, 1, 1} } },
	{ 4, 3, 16, 20, { {10978, 100, 1, 1} } },
	{ 4, 3, 21, 25, { {10978, 100, 1, 1} } },
	{ 4, 3, 26, 30, { {11084, 100, 1, 1} } },
	{ 4, 3, 31, 35, { {11138, 100, 1, 1} } },
	{ 4, 3, 36, 40, { {11139, 100, 1, 1} } },
	{ 4, 3, 41, 45, { {11177, 100, 1, 1} } },
	{ 4, 3, 46, 50, { {11178, 100, 1, 1} } },
	{ 4, 3, 51, 55, { {14343, 100, 1, 1} } },
	{ 4, 3, 56, 60, { {14344, 99.5, 1, 1}, {20725, 0.5, 1, 1} } },
	{ 4, 3, 61, 99, { {22448, 99.5, 1, 1}, {20725, 0.5, 1, 1} } },
}
QoL.DISENCHANT_BANDS, QoL.DISENCHANT_NAMES = BANDS, NAMES

function QoL.DisenchantLoot(classID, quality, itemLevel)
	if not (classID and quality and itemLevel) then return nil end
	for i = 1, #BANDS do
		local b = BANDS[i]
		if b[1] == classID and b[2] == quality and itemLevel >= b[3] and itemLevel <= b[4] then return b[5] end
	end
	return nil
end

-- The client's name for it (its language), else Polestar's name pack's, else the English one; an item the
-- client has not cached is asked for, so the next tooltip has it.
local function itemName(id)
	local C, N = ns.Compat, ns.Names
	local name = C and C.GetItemName(id)
	if not name then
		if C then C.RequestItem(id) end
		name = N and N.Item and N.Item(id)
	end
	return name or NAMES[id] or ("item:" .. id)
end

-- "1-2 Strange Dust" (an en dash), "1 Small Glimmering Shard".
local function resultText(r)
	local count = r[3] == r[4] and format("%d", r[3]) or (r[3] .. "\226\128\147" .. r[4])
	return count .. " " .. itemName(r[1])
end

function QoL.DisenchantText(classID, quality, itemLevel)
	local loot = QoL.DisenchantLoot(classID, quality, itemLevel)
	if not loot then return nil end
	local text = resultText(loot[1])
	local also = loot[2]
	if also and also[2] >= QoL.DISENCHANT_ALSO then
		text = format(L["%s (or %s)"], text, resultText(also))
	end
	return format(L["Disenchants into: %s"], text)
end

-- The line for this character, or nil.
function QoL.DisenchantLine(itemID, link)
	local C = ns.Compat
	if not (itemID and C and C.GetSkillRank and C.GetSkillRank(ENCHANTING)) then return nil end
	local classID = C.ItemKind(itemID)
	if classID ~= 2 and classID ~= 4 then return nil end
	local quality = C.GetItemQuality(itemID)
	if quality ~= 2 and quality ~= 3 then return nil end
	return QoL.DisenchantText(classID, quality, C.ItemLevel(link or itemID))
end

-- A palette colour as it reads on the game's tooltip, a dark ground in every look (Theme.TipColor: a light look's
-- ink lifted toward its paper), as Polestar's other tooltip lines take it.
local function color(name, r, g, b)
	local T = ns.Theme
	local cr, cg, cb
	if T and T.TipColor then cr, cg, cb = T.TipColor(name) end
	if cr then return cr, cg, cb end
	return r, g, b
end

-- Hooks (Core/Hooks.lua) owns the tooltips; a partial load without it has none.
local H = ns.Hooks
if H and H.ItemLines then
	H.ItemLines("disenchant", function(tooltip, link, itemID)
		local text = QoL.DisenchantLine(itemID, link)
		if not text then return end
		local r, g, b = color("textDim", 0.8, 0.8, 0.8)
		H.AddLine(tooltip, text, nil, r, g, b)
	end)
end
