-- The dungeons' own art: each instance's loading screen in the client, the
-- picture the game shows on the way in. The files are ArtFiles.lua's
-- (generated: `forge data maps art`, from the Forever client's tables),
-- keyed by the instance's Map id (Dungeons.Get(key).map). The client has no
-- Encounter Journal instances and no LFG dungeon icons for these, so the
-- loading screen is the one picture every dungeon has. A dungeon on a
-- continent's own screen (the Searing Basin, Caverns of Time) has none.
--
-- The list cards, the page header and the dungeon heads-up (UI/DungeonToast.lua,
-- in its ring) wear a crop square on screen around what the picture shows
-- (a boss, the ship, the lava): the crops below (texture coordinates l, r,
-- t, b) were picked by eye. A classic screen is a 4:3 picture stored in a
-- square texture, its painting between the logo band (t 0.17) and the
-- parchment (b 0.80): a square on screen is 4/3 as tall as it is wide there.
-- Forever's are 2992x1684 with the picture in rows 266-1418.
--
-- lift (0-1): a dark picture is drawn lifted, its colour + colour * lift (the
-- card adds the picture over itself), to about the brightness of the others
-- (a mean grey near 85 of 255 at 36 px); a crop was moved first where a
-- brighter part of the same picture still shows the place.
--
--   Dungeons.Art(key) -> { file, l, r, t, b, lift } | nil   -- nil: a dungeon this table doesn't know

local ADDON, ns = ...
local Dungeons = ns.Dungeons

local FILES = Dungeons.ArtFiles
local narrow, wide = FILES.narrow, FILES.wide

local ART = {
	[531] = { l = 0.03, r = 0.41, t = 0.207, b = 0.713, lift = 0.3 }, -- Ahn'Qiraj Temple
	[2994] = { l = 0.4, r = 0.7, t = 0.233, b = 0.767 }, -- Alcaz Prison
	[48] = { l = 0, r = 0.36, t = 0.21, b = 0.69, lift = 0.2 }, -- Blackfathom Deeps
	[2974] = { l = 0.5, r = 0.8, t = 0.233, b = 0.767 }, -- Blackmaw Hold
	[230] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Blackrock Depths
	[229] = { l = 0.15, r = 0.51, t = 0.22, b = 0.7, lift = 1 }, -- Blackrock Spire
	[469] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77, lift = 0.4 }, -- Blackwing Lair
	[2959] = { l = 0.35, r = 0.65, t = 0.233, b = 0.767 }, -- City of Dalaran
	[36] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Deadmines
	[429] = { l = 0.13, r = 0.53, t = 0.233, b = 0.767 }, -- Dire Maul
	[2998] = { l = 0.35, r = 0.65, t = 0.233, b = 0.767 }, -- Excavation Site: Wetlands
	[90] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Gnomeregan
	[3039] = { l = 0.4, r = 0.7, t = 0.233, b = 0.767 }, -- Krol'dok Stronghold
	[349] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Maraudon
	[409] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77, lift = 0.25 }, -- Molten Core
	[533] = { l = 0.01, r = 0.39, t = 0.247, b = 0.753, lift = 0.55 }, -- Naxxramas
	[249] = { l = 0.4, r = 0.8, t = 0.267, b = 0.8, lift = 0.25 }, -- Onyxia's Lair
	[389] = { l = 0.3, r = 0.7, t = 0.267, b = 0.8, lift = 0.7 }, -- Ragefire Chasm
	[129] = { l = 0.42, r = 0.7, t = 0.29, b = 0.663, lift = 0.25 }, -- Razorfen Downs
	[47] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Razorfen Kraul
	[509] = { l = 0.02, r = 0.38, t = 0.28, b = 0.76, lift = 0.55 }, -- Ruins of Ahn'Qiraj
	[2999] = { l = 0.35, r = 0.65, t = 0.233, b = 0.767 }, -- Ruins of Lordaeron
	[189] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Scarlet Monastery
	[289] = { l = 0.6, r = 0.88, t = 0.32, b = 0.693 }, -- Scholomance
	[33] = { l = 0.16, r = 0.5, t = 0.323, b = 0.777, lift = 0.45 }, -- Shadowfang Keep
	[34] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77, lift = 1 }, -- Stormwind Stockade
	[329] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77, lift = 1 }, -- Stratholme
	[109] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Sunken Temple
	[2970] = { l = 0.25, r = 0.55, t = 0.233, b = 0.767 }, -- The Drowned City
	[3065] = { l = 0.35, r = 0.65, t = 0.233, b = 0.767 }, -- The Hall of Thanes
	[3001] = { l = 0.4, r = 0.7, t = 0.233, b = 0.767, lift = 0.3 }, -- The Shaper's Terrace
	[70] = { l = 0.27, r = 0.63, t = 0.23, b = 0.71, lift = 0.95 }, -- Uldaman
	[43] = { l = 0.35, r = 0.75, t = 0.233, b = 0.767, lift = 0.35 }, -- Wailing Caverns
	[209] = { l = 0.36, r = 0.7, t = 0.34, b = 0.793, lift = 0.25 }, -- Zul'Farrak
	[309] = { l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Zul'Gurub
}
-- A crop wears its map's file; one the files lack (a client table without that
-- screen) is no art.
for map, e in pairs(ART) do
	e.file = narrow[map] or wide[map]
	if not e.file then ART[map] = nil end
end

function Dungeons.Art(key)
	local d = Dungeons.Get(key)
	return d and d.map and ART[d.map] or nil
end
