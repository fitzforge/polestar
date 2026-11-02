-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Silithus
	-- {area:1377} Silithus
	["Into {area:1377}"] = "",

	-- Step 3: Cenarion Hold
	-- {area:1377} Silithus · {area:3425} Cenarion Hold
	["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "",

	-- Step 4: Silithus: kill these as you meet them
	-- {area:1377} Silithus
	["{area:1377}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Los asediadores deslizantes excavan en las dunas al noroeste del fuerte; los escórpidos Latipiedra y los arácnidos de arena deambulan por todas partes.",

	-- Step 6: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Los trituradores deslizantes excavan más al oeste; los tenazarios y despellejadores Latipiedra y los acecharrocas cazan en las mismas arenas.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "",
	-- {npc:11736} Stonelash Pincer
	["grind on {npc:11736}"] = "",

	-- Step 7: Layo Starstrike
	-- {npc:13220} Layo Starstrike
	["Ride east to {npc:13220}."] = "Cabalga al este hasta {npc:13220}.",

	-- Step 8: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Los druidas y centinelas torturados rondan la aldea en ruinas al suroeste de {npc:13220}.",

	-- Step 10: Level 57.86
	["Level 57.86"] = "",
	-- {area:3077} Valor's Rest
	["Top up here to level 57.86 before the hand-ins at {area:3077}: they take you to level 58."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "",

	-- Step 11: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "La torre de {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Cabalga al este hasta la torre de {area:2742} en {area:2738}; súbela y mata a los emboscadores que surgen por el objeto incrustado.",

	-- Step 12: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Umber en {zone:1450}: guárdala",

	-- Step 13: Level 57.92
	["Level 57.92"] = "",
	-- {area:3425} Cenarion Hold
	["Top up here to level 57.92 before the hand-ins at {area:3425}: they take you to level 58."] = "",

	-- Step 15: Cenarion Hold
	-- {npc:15174} Calandrath
	["{npc:15174}, the innkeeper"] = "",

	-- Step 16: Level 58
	["Level 58"] = "",
	-- {area:3425} Cenarion Hold
	["Top up here to level 58: Dearest Natalia, at {area:3425}, needs level 58."] = "",
	-- {npc:12178} Tortured Druid
	["grind on {npc:12178}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Chromie in Andorhal: keep it"] = "Cromi en Andorhal: guárdala",
	-- ["Dredge and scorpids"] = "Deslizantes y escórpidos",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it."] = "Vuela de {area:976} a {area:541}. La choza de {npc:8737} está en {area:538}, al oeste del refugio; {npc:9117} está colina arriba detrás de ella.",
	-- ["Fly to {area:271} and ride north up the road toward Alterac: Haggerdin camps at {area:1056} beside it."] = "Vuela a {area:271} y cabalga al norte por el camino hacia Alterac: Haggerdin acampa en {area:1056}, a su lado.",
	-- ["For {area:3197}: keep it"] = "Para {area:3197}: guárdala",
	-- ["For {npc:10778}: keep it"] = "Para {npc:10778}: guárdala",
	-- ["For {zone:1448}: keep it"] = "Para {zone:1448}: guárdala",
	-- ["From {area:392}, fly to {area:976}."] = "Desde {area:392}, vuela a {area:976}.",
	-- ["Its jars are filled on the next Un'Goro visit"] = "Sus tarros se llenan en la próxima visita a Un'Goro",
	-- ["On {npc:7583}"] = "En {npc:7583}",
	-- ["Ride back to {area:3425} and fly to {area:392}."] = "Cabalga de vuelta a {area:3425} y vuela a {area:392}.",
	-- ["Ride north to the {area:2277}'s north-eastern edge."] = "Cabalga al norte hasta el borde noreste de {area:2277}.",
	-- ["Ride on north to {area:3197} and fly to {area:2268}."] = "Sigue cabalgando al norte hasta {area:3197} y vuela a {area:2268}.",
	-- ["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "Sal del cráter por el paso del noroeste hacia {zone:1451} y sigue hasta {area:3425}.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Cabalga al suroeste hasta {area:2261}. El montón de tierra está dentro. {npc:11886} es élite: se recomienda ir en grupo.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Cabalga al suroeste hasta el campamento de {npc:7771} en {area:1938}.",
	-- ["Scourge Champions"] = "Campeones de la Plaga",
	-- ["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Los campeones de la Plaga (59) deambulan por {area:2270}, al norte de {area:2268}. Pasa el {item:13156} de {npc:11063} sobre cada uno que mates: los cráneos que resuenan son los que quiere. Atráelos de uno en uno.",
	-- ["Sixty {item:2592}, if you carry them"] = "Sesenta de {item:2592}, si los llevas",
	-- ["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Toma el barco de {area:392} a {area:35} y vuela a {zone:1453}.",
	-- ["Take the {area:2257} to {zone:1455}."] = "Toma el {area:2257} a {zone:1455}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "Las bestias de alquitrán se revuelcan en {area:538}; los elementales de fuego de {area:537}, en el centro, llevan la ceniza; las avispas Gorishi de {area:540}, en el sur, llevan la glándula. Cualquier criatura del cráter puede soltar {item:11018}.",
	-- ["The crater"] = "El cráter",
	-- ["The next guide starts here in {area:392}."] = "La siguiente guía empieza aquí, en {area:392}.",
	-- ["The western dunes"] = "Las dunas del oeste",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "farmea {npc:8532} en {area:2258}, {zone:1423}",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}, de los campeones de la Plaga",
	-- ["{item:14613}, from {npc:11886}"] = "{item:14613}, de {npc:11886}",
	-- ["{npc:14724}, by the tram"] = "{npc:14724}, junto al tranvía",
	-- ["{npc:332}, in SI:7"] = "{npc:332}, en el IV:7",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}, que recorre los canales",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} espera en el cementerio justo al este del pueblo; la lápida está cerca.",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} está en {area:392}",
	-- ["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} en {area:3197}: guárdala",
}
