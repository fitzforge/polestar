-- Spanish (Spain) (esES): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["From {area:392}, fly to {area:976}."] = "Desde {area:392}, vuela a {area:976}.",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "Para {area:3197}: guárdala",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "Con {npc:7583}",

	-- Step 2: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} espera en el cementerio justo al este del pueblo; la lápida está cerca.",

	-- Step 3: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Cabalga al suroeste hasta el campamento de {npc:7771} en el {area:1938}.",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444} está en {area:392}",

	-- Step 4: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9117} J.D. Collie
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "Vuela desde {area:976} a {area:541}. La choza de {npc:8737} está en {area:538}, al oeste del refugio; {npc:9117} está colina arriba, detrás.",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Para {zone:1448}: guárdala",

	-- Step 5: The crater
	["The crater"] = "El cráter",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "Las bestias Tar se revuelcan en {area:538}; los elementales de fuego de {area:537}, en el centro, llevan la ceniza; las avispas gorishi de {area:540}, en el sur, llevan la glándula. Cualquier criatura del cráter puede soltar {item:11018}.",

	-- Step 6: Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "Sal del cráter por el paso del noroeste hacia {zone:1451} y sigue hasta {area:3425}.",

	-- Step 7: Dredge and scorpids
	["Dredge and scorpids"] = "Arrastres y escórpidos",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Los artilleros de arrastre excavan en las dunas al noroeste del fuerte; los escórpidos Latigosólido y los arácnidos de arena deambulan por todas partes.",

	-- Step 9: The western dunes
	["The western dunes"] = "Las dunas del oeste",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Los trituradores de arrastre excavan más al oeste; los tenazarios Latigosólido, cazadores Latigosólido y acechadores de piedra cazan en las mismas arenas.",

	-- Step 11: Layo Starstrike
	-- {npc:13220} Layo Starstrike
	["Ride east to {npc:13220}."] = "Cabalga al este hasta {npc:13220}.",

	-- Step 12: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Los druidas y centinelas torturados rondan el poblado en ruinas al suroeste de {npc:13220}.",

	-- Step 14: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "La torre de {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Cabalga al este hasta la torre de {area:2742} en {area:2738}; súbela y mata a los emboscadores que surgen por el objeto incrustado.",

	-- Step 15: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Umber en {zone:1450}: guárdala",

	-- Step 16: Ratchet
	-- {area:3425} Cenarion Hold · {area:392} Ratchet
	["Ride back to {area:3425} and fly to {area:392}."] = "Vuelve a {area:3425} y vuela a {area:392}.",

	-- Step 17: Stormwind City
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind City
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Toma el barco de {area:392} a {area:35} y vuela a {zone:1453}.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, que pasea por los canales",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "Para {npc:10778}: guárdala",
	-- {item:2592} Wool Cloth
	["Sixty {item:2592}, if you carry them"] = "Sesenta {item:2592}, si los llevas",

	-- Step 18: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, en IV:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} en {area:3197}: guárdala",

	-- Step 19: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge
	["Take the {area:2257} to {zone:1455}."] = "Toma el {area:2257} hasta {zone:1455}.",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724}, junto al tranvía",
	["Its jars are filled on the next Un'Goro visit"] = "Sus jarras se llenan en la próxima visita a Un'Goro",

	-- Step 20: Lieutenant Haggerdin
	-- {area:271} Southshore · {area:1056} Darrow Hill
	["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "Vuela a {area:271} y cabalga al norte por el camino hacia las Montañas de Alterac: Haggerdin acampa en {area:1056}, junto a él.",

	-- Step 21: Light's Hope Chapel
	-- {area:3197} Chillwind Camp · {area:2268} Light's Hope Chapel
	["Ride on north to {area:3197} and fly to {area:2268}."] = "Sigue al norte hasta {area:3197} y vuela a {area:2268}.",

	-- Step 22: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Campeones de la Plaga",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Los campeones de la Plaga (59) deambulan por {area:2270}, al norte de {area:2268}. Pasa el {item:13156} de {npc:11063} sobre cada uno que mates: las calaveras que resuenan son las que quiere. Atráelos de uno en uno.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}, de los campeones de la Plaga",

	-- Step 23: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "Chromie en Andorhal: guárdala",

	-- Step 24: Infiltrator Hameya
	-- {area:2277} Plaguewood
	["Ride north to the {area:2277}'s north-eastern edge."] = "Cabalga al norte hasta el borde noreste de {area:2277}.",

	-- Step 25: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Cabalga al suroeste hasta {area:2261}. El montón de tierra está dentro. {npc:11886} es élite: se recomienda ir en grupo.",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}, de {npc:11886}",

	-- Step 26: The Fungal Vale
	-- {npc:8532} Diseased Flayer · {area:2258} The Fungal Vale · {zone:1423} Eastern Plaguelands
	["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "sube de nivel con {npc:8532} en {area:2258}, {zone:1423}",

	-- Step 27: Ratchet
	-- {area:392} Ratchet
	["The next guide starts here in {area:392}."] = "La siguiente guía empieza aquí, en {area:392}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Cabalga al suroeste hasta {area:2261}. El montón de tierra está dentro. {npc:11886} es élite: se recomienda ir en grupo.",
	-- ["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Toma el barco de {area:392} a {area:35} y vuela a {zone:1453}.",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "sube de nivel con {npc:8532} en {area:2258}, {zone:1423}",
}
