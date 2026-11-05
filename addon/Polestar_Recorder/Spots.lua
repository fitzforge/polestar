-- The spots to walk with /psrec trail for Polestar's navigation checks
-- (level 30 or lower; the ones waiting for a higher level cap are left out),
-- in each faction's tour order (Panel.lua). Generated once from the
-- maintainers' trail list (data/local/research/RecordSpots.md, not shipped);
-- English only: a tool for the people recording.
--
-- { id, name, zone, fac = "A" | "H" | "N" | "Both", min = level, why, todo, label }
-- A trail whose label is the spot's label, or starts with "#<id>", ticks it.

local _, ns = ...

ns.SPOTS = {
	{ id = 1, name = "Thunder Bluff Spirit Rise → rope bridge → Hunter Rise → Elder Rise", zone = "Thunder Bluff", fac = "H", min = 1, why = "Rope bridge. Leffe's graph breaks at a 5 yd step (-1268,-111,173)→(-1264,-107,168); our grid prices a climb at 384,208 s", todo = "Walk every bridge one way, then back. Stop for a second on the sagging middle and at the mesa ends", label = "#1 Thunder Bluff Spirit Rise" },
	{ id = 2, name = "Thunder Bluff: Mulgore ground → Mesa Elevator → Elder Rise", zone = "TB / Mulgore", fac = "H", min = 1, why = "Lift. 0.2.6 finds no way; Leffe has no lift links", todo = "Ride both lifts (objects 4170/4171 and 47296/47297) up and down. Mark where you wait and where you step off", label = "#2 Thunder Bluff: Mulgore ground" },
	{ id = 3, name = "Ban'ethil Hollow 44.92,55.02 → barrow entrance → Oben 44.94,61.59, then upper ↔ lower floors", zone = "Teldrassil", fac = "A", min = 8, why = "Cave plus multiple floors. No engine finds Oben; the maps don't go inside the barrow", todo = "Go south into the hollow and in by the mouth, down to Oben, then walk the lower floor back up", label = "#3 Ban'ethil Hollow" },
	{ id = 4, name = "42.10,56.59 → Sleeping Druid (same hill)", zone = "Teldrassil", fac = "A", min = 8, why = "Steep faces: the map splits the hill into separate regions", todo = "Same visit as #3. Walk the real way up the hill and note where it gets too steep", label = "#4 Teldrassil" },
	{ id = 5, name = "Stormwind Trade District → Jennea (upper floor)", zone = "Stormwind", fac = "A", min = 1, why = "Multi-floor. Our current walk ends 75.8 yd off her height", todo = "Climb the stairs to her. Keep the trail going on every landing", label = "#5 Stormwind Trade District" },
	{ id = 6, name = "Stormwind Dwarven District → Leland → Gilbert Gray 26.30,47.10 → harbour boat 22.71,56.69", zone = "Stormwind", fac = "A", min = 1, why = "Harbour under the Trade District. Leffe's way is 20,685 yd against our grid's 1,631", todo = "Walk to the end of the pier and board. Ride the Auberdine boat afterwards (Alliance tour)", label = "#6 Stormwind Dwarven District" },
	{ id = 7, name = "Cathedral Square → Farthing", zone = "Stormwind", fac = "A", min = 1, why = "Building interior: the walk leaves the graph 44 yd from him", todo = "Walk in through the door to him", label = "#7 Cathedral Square" },
	{ id = 8, name = "Orgrimmar gate tunnel → Valley of Honor; Cleft of Shadow → Valley of Spirits", zone = "Orgrimmar", fac = "H", min = 1, why = "Tunnel/gate, lower levels. 0.2.6 has no way to Spirits; Leffe doesn't join Honor or Spirits", todo = "From the Durotar gate, through the tunnel to Honor. Then go down into the Cleft (Neeru) and out to Spirits", label = "#8 Orgrimmar gate tunnel" },
	{ id = 9, name = "Ironforge Firebrew → Military Ward (Xiggs)", zone = "Ironforge", fac = "A", min = 1, why = "Area not joined. 0.2.6 has no way; Leffe's checks abort", todo = "Gate → Great Forge ring → Military Ward", label = "#9 Ironforge Firebrew" },
	{ id = 10, name = "Brill → Undervator → Magic Quarter; Undercity zeppelin tower ground → top", zone = "Tirisfal / UC", fac = "H", min = 1, why = "Lift and tower ramp. Leffe can't reach the tower top; 0.2.6 is 1.5–1.7x longer", todo = "Ride all 3 Undervators both ways, then walk the tower ramp up to the top platform", label = "#10 Brill" },
	{ id = 11, name = "Teldrassil Darnassus gate ↔ Dolanaar; Rut'theran dock → portal → Darnassus tiers", zone = "Teldrassil", fac = "A", min = 5, why = "Portal and tiers. The plan wants to walk down to Rut'theran; Leffe doesn't join the temple tiers", todo = "Dock → portal → Darnassus. Walk the Temple of the Moon top and lower floor and both Temple Garden bridges, then out the gate to Dolanaar", label = "#11 Teldrassil Darnassus gate ↔ Dolanaar" },
	{ id = 12, name = "Darkcloud Pinnacle canyon → entrance → Arnak, over the mesa bridges", zone = "Thousand Needles", fac = "H", min = 30, why = "Rope bridges and a narrow ramp. Our walk is 2,431 yd against a 2,260 yd limit, and the bridge is missed", todo = "From the canyon floor (-5307,-3199), up the ramp at the 38_41/38_42 tile border. Cross every bridge", label = "#12 Darkcloud Pinnacle canyon" },
	{ id = 13, name = "Freewind Post canyon ↔ top by lift; Great Lift up/down", zone = "Thousand Needles", fac = "H", min = 25, why = "Lifts. 0.2.6 is 2.67x longer; Leffe takes 3,591 yd against 1,167", todo = "Ride both Freewind lifts and both Great Lift cars, in both directions", label = "#13 Freewind Post canyon ↔ top by lift" },
	{ id = 14, name = "Redridge ledge 32.42,43.39 → lake murlocs 35.9,48.0", zone = "Redridge", fac = "A", min = 18, why = "One-way drop the maps don't route", todo = "Record the jump. Say whether you land in water and whether you take fall damage", label = "#14 Redridge ledge" },
	{ id = 15, name = "Wetlands 48.26,43.54 → Dragonmaw camp 45.70,44.80", zone = "Wetlands", fac = "A", min = 25, why = "Slope you can't walk", todo = "Walk the real way round, then try the slope straight on and note where you slide", label = "#15 Wetlands" },
	{ id = 16, name = "Orgrimmar zeppelin tower ground → top", zone = "Durotar 50.8,13.5", fac = "H", min = 1, why = "Tower ramp", todo = "From Doras to the top and onto the zeppelin", label = "#16 Orgrimmar zeppelin tower ground" },
	{ id = 17, name = "Grom'gol tower top → ground", zone = "STV", fac = "H", min = 30, why = "Tower", todo = "Stay inside the camp", label = "#17 Grom'gol tower top" },
	{ id = 18, name = "Booty Bay dock → inn (upper floor)", zone = "STV", fac = "N", min = 1, why = "Multi-floor / dock", todo = "Arrive by the Ratchet boat. Don't go out through the tunnel", label = "#18 Booty Bay dock" },
	{ id = 19, name = "Menethil dock → town over the bridge", zone = "Wetlands", fac = "A", min = 20, why = "Dock / bridge", todo = "Boat end → keep", label = "#19 Menethil dock" },
	{ id = 20, name = "Auberdine dock; Rut'theran dock", zone = "Darkshore / Teldrassil", fac = "A", min = 1, why = "Dock", todo = "Walk off and back on", label = "#20 Auberdine dock" },
	{ id = 21, name = "Deeprun Tram, Stormwind side", zone = "Stormwind", fac = "A", min = 1, why = "Tunnel", todo = "Dwarven District → platform", label = "#21 Deeprun Tram, Stormwind side" },
	{ id = 22, name = "Gnomeregan Vator top ↔ bottom", zone = "Dun Morogh", fac = "A", min = 20, why = "Lift", todo = "Ride both ways. Don't enter the instance", label = "#22 Gnomeregan Vator top ↔ bottom" },
	{ id = 23, name = "Echo Ridge Mine deep → Neals", zone = "Northshire", fac = "A", min = 3, why = "Cave", todo = "Mouth → back of the mine → out", label = "#23 Echo Ridge Mine deep" },
	{ id = 24, name = "Jasperlode Mine → geomancer", zone = "Elwynn", fac = "A", min = 8, why = "Cave", todo = "Mouth → lower floor", label = "#24 Jasperlode Mine" },
	{ id = 25, name = "Fargodeep Mine mouth → Goldtooth", zone = "Elwynn", fac = "A", min = 8, why = "Cave", todo = "Into the lower mine", label = "#25 Fargodeep Mine mouth" },
	{ id = 26, name = "Fel Rock mouth → Melenas' ledge", zone = "Teldrassil", fac = "A", min = 7, why = "Cave ledge", todo = "Keep right and go up by the north side", label = "#26 Fel Rock mouth" },
	{ id = 27, name = "Burning Blade Coven → Yarrog; Coven pick", zone = "Durotar (VoT)", fac = "H", min = 4, why = "Cave", todo = "In at the mouth (45,56)", label = "#27 Burning Blade Coven" },
	{ id = 28, name = "Dustwind Cave; Skull Rock", zone = "Durotar", fac = "H", min = 10, why = "Cave", todo = "The deepest cultist", label = "#28 Dustwind Cave" },
	{ id = 29, name = "Frostmane Hold inside; Grizzled Den → Frosthowl", zone = "Dun Morogh", fac = "A", min = 9, why = "Cave", todo = "North loop", label = "#29 Frostmane Hold inside" },
	{ id = 30, name = "Coldridge troll cave → Grik'nir", zone = "Dun Morogh", fac = "A", min = 3, why = "Tunnel", todo = "Along the tunnel", label = "#30 Coldridge troll cave" },
	{ id = 31, name = "Wailing Caverns mouth → Ebru → deep", zone = "Barrens", fac = "H", min = 17, why = "Cave", todo = "Outside the instance only", label = "#31 Wailing Caverns mouth" },
	{ id = 32, name = "Gold Coast Quarry; Jangolode", zone = "Westfall", fac = "A", min = 12, why = "Cave", todo = "", label = "#32 Gold Coast Quarry" },
	{ id = 33, name = "Undercity: Trade Quarter → Mage Quarter (upper and lower), Sylvanas, canals", zone = "UC", fac = "H", min = 1, why = "Multi-floor", todo = "Upper ring and lower canal", label = "#33 Undercity: Trade Quarter" },
	{ id = 34, name = "Brill town hall upstairs", zone = "Tirisfal", fac = "H", min = 1, why = "Multi-floor", todo = "", label = "#34 Brill town hall upstairs" },
	{ id = 35, name = "Stormwind mage tower floors (Andromath → Mazen → Dellis)", zone = "Stormwind", fac = "A", min = 1, why = "Multi-floor", todo = "Every landing", label = "#35 Stormwind mage tower floors" },
	{ id = 36, name = "Lakeshire inn and town hall", zone = "Redridge", fac = "A", min = 15, why = "Multi-floor", todo = "", label = "#36 Lakeshire inn and town hall" },
	{ id = 37, name = "Sun Rock Retreat bridge", zone = "Stonetalon", fac = "H", min = 20, why = "Rope bridge", todo = "Cross both ways", label = "#37 Sun Rock Retreat bridge" },
	{ id = 38, name = "Astranaar bridges", zone = "Ashenvale", fac = "A", min = 20, why = "Bridge", todo = "", label = "#38 Astranaar bridges" },
	{ id = 39, name = "Forest's Edge (Elwynn → Westfall); Westfall → Duskwood bridge → Darkshire", zone = "Elwynn / Duskwood", fac = "A", min = 18, why = "Bridge / pass", todo = "", label = "#39 Forest's Edge" },
	{ id = 40, name = "Thandol Span", zone = "Wetlands", fac = "A", min = 28, why = "Bridge", todo = "Stay on the deck", label = "#40 Thandol Span" },
	{ id = 41, name = "Thoradin's Wall gate", zone = "Hillsbrad / Arathi", fac = "Both", min = 28, why = "Gate", todo = "Through and back", label = "#41 Thoradin's Wall gate" },
	{ id = 42, name = "Southfury River gate", zone = "Durotar / Barrens", fac = "H", min = 10, why = "Gate", todo = "", label = "#42 Southfury River gate" },
	{ id = 43, name = "Tarren Mill → Silverpine pass → Brill", zone = "Hillsbrad", fac = "H", min = 24, why = "Long walk; our grid climbs twice (26 yd)", todo = "Keep out of Alterac", label = "#43 Tarren Mill" },
	{ id = 44, name = "Thistlefur Hold charm → Ruul", zone = "Ashenvale", fac = "H", min = 22, why = "Cave", todo = "", label = "#44 Thistlefur Hold charm" },
	{ id = 45, name = "Shadowthread Cave → egg", zone = "Teldrassil", fac = "A", min = 6, why = "Cave", todo = "", label = "#45 Shadowthread Cave" },
}

-- Tour order per faction (spot ids); spots not in a tour follow by id.
ns.SPOT_TOURS = {
	Horde = { 43, 34, 10, 33, 17, 16, 8, 27, 28, 42, 31, 18, 1, 2, 37, 44, 13, 12, 41 },
	Alliance = { 11, 20, 26, 3, 4, 45, 6, 5, 7, 35, 21, 9, 22, 29, 30, 23, 24, 25, 39, 32, 14, 36, 19, 15, 40, 38 },
}
