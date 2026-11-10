-- The dungeons' own art: each instance's loading screen in the client, the
-- picture the game shows on the way in, cropped to a square around what it
-- shows (a boss, the ship, the lava). The dungeon heads-up wears it in its
-- ring (UI/DungeonToast.lua).
--
-- From the Forever client's tables (1.60.1): Map.LoadingScreenID, then
-- LoadingScreens.NarrowScreenFileDataID (the classic 4:3 screens) or, for
-- Forever's own dungeons, its MainImageFileDataID. Keyed by the instance's Map
-- id (Dungeons.Get(key).map). The client has no Encounter Journal instances
-- and no LFG dungeon icons for these, so the loading screen is the one
-- picture every dungeon has.
--
-- The crops (texture coordinates l, r, t, b) were picked by eye. A classic
-- screen is a 4:3 picture stored in a square texture, its painting between
-- the logo band (t 0.17) and the parchment (b 0.80): a square on screen is 4/3
-- as tall as it is wide there. Forever's are 2992x1684 with the picture in
-- rows 266-1418.
--
-- lift (0-1): a dark picture is drawn lifted, its colour + colour * lift (the
-- card adds the picture over itself), to about the brightness of the others
-- (a mean grey near 85 of 255 at 36 px); a crop was moved first where a
-- brighter part of the same picture still shows the place.
--
--   Dungeons.Art(key) -> { file, l, r, t, b, lift } | nil   -- nil: a dungeon this table doesn't know

local ADDON, ns = ...
local Dungeons = ns.Dungeons

local ART = {
	[531] = { file = 131819, l = 0.03, r = 0.41, t = 0.207, b = 0.713, lift = 0.3 }, -- Ahn'Qiraj Temple
	[48] = { file = 131823, l = 0, r = 0.36, t = 0.21, b = 0.69, lift = 0.2 }, -- Blackfathom Deeps
	[230] = { file = 131824, l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Blackrock Depths
	[229] = { file = 131825, l = 0.15, r = 0.51, t = 0.22, b = 0.7, lift = 1 }, -- Blackrock Spire
	[469] = { file = 131827, l = 0.29, r = 0.71, t = 0.21, b = 0.77, lift = 0.4 }, -- Blackwing Lair
	[2959] = { file = 7963775, l = 0.35, r = 0.65, t = 0.233, b = 0.767 }, -- City of Dalaran
	[36] = { file = 131833, l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Deadmines
	[429] = { file = 131835, l = 0.13, r = 0.53, t = 0.233, b = 0.767 }, -- Dire Maul
	[2998] = { file = 7963777, l = 0.35, r = 0.65, t = 0.233, b = 0.767 }, -- Excavation Site: Wetlands
	[90] = { file = 131841, l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Gnomeregan
	[349] = { file = 131850, l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Maraudon
	[409] = { file = 131851, l = 0.29, r = 0.71, t = 0.21, b = 0.77, lift = 0.25 }, -- Molten Core
	[533] = { file = 131854, l = 0.01, r = 0.39, t = 0.247, b = 0.753, lift = 0.55 }, -- Naxxramas
	[249] = { file = 131863, l = 0.4, r = 0.8, t = 0.267, b = 0.8, lift = 0.25 }, -- Onyxia's Lair
	[389] = { file = 131862, l = 0.3, r = 0.7, t = 0.267, b = 0.8, lift = 0.7 }, -- Ragefire Chasm
	[129] = { file = 131864, l = 0.42, r = 0.7, t = 0.29, b = 0.663, lift = 0.25 }, -- Razorfen Downs
	[47] = { file = 131865, l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Razorfen Kraul
	[509] = { file = 131818, l = 0.02, r = 0.38, t = 0.28, b = 0.76, lift = 0.55 }, -- Ruins of Ahn'Qiraj
	[2999] = { file = 7963782, l = 0.35, r = 0.65, t = 0.233, b = 0.767 }, -- Ruins of Lordaeron
	[189] = { file = 131852, l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Scarlet Monastery
	[289] = { file = 131868, l = 0.6, r = 0.88, t = 0.32, b = 0.693 }, -- Scholomance
	[33] = { file = 131869, l = 0.16, r = 0.5, t = 0.323, b = 0.777, lift = 0.45 }, -- Shadowfang Keep
	[34] = { file = 131870, l = 0.29, r = 0.71, t = 0.21, b = 0.77, lift = 1 }, -- Stormwind Stockade
	[329] = { file = 131871, l = 0.29, r = 0.71, t = 0.21, b = 0.77, lift = 1 }, -- Stratholme
	[109] = { file = 131872, l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Sunken Temple
	[3065] = { file = 7963781, l = 0.35, r = 0.65, t = 0.233, b = 0.767 }, -- The Hall of Thanes
	[70] = { file = 131876, l = 0.27, r = 0.63, t = 0.23, b = 0.71, lift = 0.95 }, -- Uldaman
	[43] = { file = 131882, l = 0.35, r = 0.75, t = 0.233, b = 0.767, lift = 0.35 }, -- Wailing Caverns
	[209] = { file = 131885, l = 0.36, r = 0.7, t = 0.34, b = 0.793, lift = 0.25 }, -- Zul'Farrak
	[309] = { file = 131886, l = 0.29, r = 0.71, t = 0.21, b = 0.77 }, -- Zul'Gurub
}

function Dungeons.Art(key)
	local d = Dungeons.Get(key)
	return d and d.map and ART[d.map] or nil
end
