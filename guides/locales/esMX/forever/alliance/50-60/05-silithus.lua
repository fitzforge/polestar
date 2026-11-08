-- Spanish (Latin America) (esMX): the guide forever/alliance/50-60/05-silithus (forever/alliance/50-60/05-silithus.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Ratchet
	-- {area:541} Marshal's Refuge · {area:392} Ratchet
	["Fly from {area:541} to {area:392}."] = "",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "",

	-- Step 2: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco a {area:35}",

	-- Step 3: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Vuela a {zone:1453}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "",

	-- Step 4: Stormwind
	-- {area:392} Ratchet · {area:35} Booty Bay · {zone:1453} Stormwind
	["Take the boat from {area:392} to {area:35} and fly to {zone:1453}."] = "Toma el barco de {area:392} a {area:35} y vuela a {zone:1453}.",
	-- {npc:3520} Ol' Emma
	["{npc:3520}, who walks the canals"] = "{npc:3520}, que recorre los canales",
	-- {npc:10778} Janice Felstone
	["For {npc:10778}: keep it"] = "Para {npc:10778}: guárdala",

	-- Step 5: Stormwind Keep
	-- {npc:332} Master Mathias Shaw
	["{npc:332}, in SI:7"] = "{npc:332}, en el IV:7",
	-- {quest:6184} Flint Shadowmore · {area:3197} Chillwind Camp
	["{quest:6184} at {area:3197}: keep it"] = "{quest:6184} en {area:3197}: guárdala",

	-- Step 6: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "",

	-- Step 7: Ironforge
	["Its jars are filled on the next Un'Goro visit"] = "Sus tarros se llenan en la próxima visita a Un'Goro",
	-- {npc:14724} Bubulo Acerbus
	["{npc:14724}, by the tram"] = "{npc:14724}, junto al tranvía",

	-- Step 8: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Vuela a {area:2268}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "",

	-- Step 9: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen · {area:2627} Terrordale
	["{npc:11038}, by the graves south of the chapel: Egan is in {area:2627}, keep it"] = "",

	-- Step 10: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Campeones de la Plaga ({npc:8529})",
	-- {area:2270} Noxious Glade · {area:2268} Light's Hope Chapel · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions (59) roam the {area:2270}, north of {area:2268}. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants. Pull them one at a time."] = "Los campeones de la Plaga (59) deambulan por {area:2270}, al norte de {area:2268}. Pasa el {item:13156} de {npc:11063} sobre cada uno que mates: los cráneos que resuenan son los que quiere. Atráelos de uno en uno.",
	-- {item:13155} Resonating Skull
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["{item:13155}, from the Scourge Champions"] = "{item:13155}, de los campeones de la Plaga",

	-- Step 11: Light's Hope Chapel
	["Chromie in Andorhal: keep it"] = "Cromi en Andorhal: guárdala",

	-- Step 12: Infiltrator Hameya
	-- {area:2277} Plaguewood · {area:2273} Zul'Mashar
	["Ride north to the {area:2277}'s north-eastern edge.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 13: The Undercroft
	-- {area:2261} The Undercroft · {npc:11886} Mercutio Filthgorger
	["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",
	-- {item:14613} Taelan's Hammer · {npc:11886} Mercutio Filthgorger
	["{item:14613}, from {npc:11886}"] = "{item:14613}, de {npc:11886}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Chromie in Andorhal: keep it"] = "Cromi en Andorhal: guárdala",
	-- ["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Los trituradores deslizantes excavan más al oeste; los tenazarios y despellejadores Latipiedra y los acecharrocas cazan en las mismas arenas.",
	-- ["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Los asediadores deslizantes excavan en las dunas al noroeste del fuerte; los escórpidos Latipiedra y los arácnidos de arena deambulan por todas partes.",
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
	-- ["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Cabalga al este hasta la torre de {area:2742} en {area:2738}; súbela y mata a los emboscadores que surgen por el objeto incrustado.",
	-- ["Ride east to {npc:13220}."] = "Cabalga al este hasta {npc:13220}.",
	-- ["Ride north to the {area:2277}'s north-eastern edge."] = "Cabalga al norte hasta el borde noreste de {area:2277}.",
	-- ["Ride on north to {area:3197} and fly to {area:2268}."] = "Sigue cabalgando al norte hasta {area:3197} y vuela a {area:2268}.",
	-- ["Ride out of the crater's north-western pass into {zone:1451} and on to {area:3425}."] = "Sal del cráter por el paso del noroeste hacia {zone:1451} y sigue hasta {area:3425}.",
	-- ["Ride south-west to the {area:2261}. The mound of dirt lies inside. {npc:11886} is elite: grouping up is advised."] = "Cabalga al suroeste hasta {area:2261}. El montón de tierra está dentro. {npc:11886} es élite: se recomienda ir en grupo.",
	-- ["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Cabalga al suroeste hasta el campamento de {npc:7771} en {area:1938}.",
	-- ["Scourge Champions"] = "Campeones de la Plaga",
	-- ["Sixty {item:2592}, if you carry them"] = "Sesenta de {item:2592}, si los llevas",
	-- ["Take the {area:2257} to {zone:1455}."] = "Toma el {area:2257} a {zone:1455}.",
	-- ["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}."] = "Las bestias de alquitrán se revuelcan en {area:538}; los elementales de fuego de {area:537}, en el centro, llevan la ceniza; las avispas Gorishi de {area:540}, en el sur, llevan la glándula. Cualquier criatura del cráter puede soltar {item:11018}.",
	-- ["The crater"] = "El cráter",
	-- ["The next guide starts here in {area:392}."] = "La siguiente guía empieza aquí, en {area:392}.",
	-- ["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Los druidas y centinelas torturados rondan la aldea en ruinas al suroeste de {npc:13220}.",
	-- ["The western dunes"] = "Las dunas del oeste",
	-- ["The {area:2742} tower"] = "La torre de {area:2742}",
	-- ["Umber in {zone:1450}: keep it"] = "Umber en {zone:1450}: guárdala",
	-- ["grind on {npc:8532} at the {area:2258}, {zone:1423}"] = "farmea {npc:8532} en {area:2258}, {zone:1423}",
	-- ["{item:13155}, from the Scourge Champions"] = "{item:13155}, de los campeones de la Plaga",
	-- ["{item:14613}, from {npc:11886}"] = "{item:14613}, de {npc:11886}",
	-- ["{npc:14724}, by the tram"] = "{npc:14724}, junto al tranvía",
	-- ["{npc:332}, in SI:7"] = "{npc:332}, en el IV:7",
	-- ["{npc:3520}, who walks the canals"] = "{npc:3520}, que recorre los canales",
	-- ["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} espera en el cementerio justo al este del pueblo; la lápida está cerca.",
	-- ["{quest:3444} is in {area:392}"] = "{quest:3444} está en {area:392}",
}
