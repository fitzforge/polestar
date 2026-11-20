-- Spanish (Latin America) (esMX): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1446} Tanaris · {zone:1451} Silithus
	["{zone:1446}, {zone:1451} & the Plaguelands"] = "",
	-- {zone:1446} Tanaris · {zone:1451} Silithus
	["{zone:1446}, {zone:1451} and the Plaguelands."] = "",
	["Takes you all the way to 60"] = "Te lleva hasta el nivel 60",
	["Stays on the main route"] = "Se mantiene en la ruta principal",
	["Finishes the Plaguelands chains"] = "",
	["Lots of flying between zones"] = "Muchos vuelos entre zonas",

	-- Step 1: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "Maestro de vuelo de {area:2255}",

	-- Step 2: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Bebe el {item:11243} en el cementerio justo al este de {area:976}: te mata, y solo como fantasma puedes ver a {npc:9299}, en una grieta rocosa en las colinas justo al norte de allí. Habla con él allí, luego corre de vuelta a tu cuerpo y resucita: la Lápida llamativa a la que te envía está en ese cementerio.",

	-- Step 3: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Usa {item:12928} en {npc:7583}, la niña goblin de {area:976}. {npc:10977} y {npc:10978} se asustan más adelante en la ruta.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Asusta a {npc:7583} con {item:12928}",

	-- Step 4: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1413} guide"] = "",

	-- Step 5: Alchemist Pestlezugg
	["Inside"] = "Adentro",

	-- Step 6: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} regresa con {npc:8737} en Un'Goro: guárdala.",

	-- Step 7: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto al camino de {area:1336}, al sur de {area:976}.",

	-- Step 8: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Vuela a {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maestro de vuelo de {area:976}",

	-- Step 9: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken · {area:537} Fire Plume Ridge
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. Take her errand before climbing {area:537}."] = "",
	-- {npc:8737} Linken
	["Hold {npc:8737}'s errand for your return to the refuge."] = "",

	-- Step 10: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "El goblin {npc:10302} está en {area:543}, justo al este de la torre de cristal.",

	-- Step 11: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Cabalga al este hasta {area:537}, súbelo y usa {npc:10541} en la grieta de lava cerca de la cima; luego regresa al oeste con {npc:10302}.",

	-- Step 12: Volcanic Activity
	-- plural, as words: Scorching Elementals = {npc:6520} Scorching Elemental · Living Blazes = {npc:6521} Living Blaze
	["Collect ash from the Scorching Elementals and Living Blazes on the ridge. Stay outside Blazerunner's cave: he is elite."] = "",

	-- Step 13: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} está sentado en la cresta, perdido y agotado.",
	["Below ground"] = "Bajo tierra",

	-- Step 14: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolta a {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Lleva a {npc:9999} al norte hasta {area:541}. Cuando se desmaye, usa {item:11804} en él para despertarlo.",

	-- Step 16: Quixxil
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	-- was: ["Scare {npc:10977} with {npc:10980}"] = "Asusta a {npc:10977} con {npc:10980}"
	["Scare {npc:10977} with {item:12928}"] = "",

	-- Step 17: J.D. Collie
	-- {npc:9117} J.D. Collie
	["{npc:9117} is at the back of the refuge cave."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, bajo tierra",

	-- Step 18: Linken's Memory
	-- {quest:3942} Linken's Memory · {area:2479} Emerald Sanctuary
	["Keep {quest:3942} for Eridan at the {area:2479}."] = "",

	-- Step 19: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} te envía con {npc:9298} en {zone:1452}: guárdala.",

	-- Step 20: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "Solo si aceptaste {quest:4496} en {area:976} de camino aquí: los Gorishi de {area:540}, al sur de {area:537}, sueltan la Glándula de olor, y la mayoría de las bestias y plantas del cráter sueltan {item:11018}.",

	-- Step 21: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "Usa {item:11833} donde marca la flecha, dentro de la colmena Gorishi de {area:540}, para llamar a {npc:10041} (nivel 56).",

	-- Step 22: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56 and his lair lies on the way to the north-east plateau."] = "",

	-- Step 24: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "La guarida de {npc:9684} está justo al sur de la torre de cristal. Usa allí el cebo de {npc:9619}; {npc:9684} es de nivel 56 y pega fuerte, así que empieza con la salud llena.",

	-- Step 25: The Mighty U'cha
	-- {npc:9684} Lar'korwi · {npc:9622} U'cha
	["Ride north from {npc:9684} to the gorilla cave on the plateau. {npc:9622} is level 55. Clear a path in one gorilla at a time."] = "",

	-- Step 27: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["Ride around the crater to the north-western pass. It leads up to {area:3077} in {zone:1451}; {npc:13220} stands among the graves."] = "",

	-- Step 28: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	-- was: ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cabalga al suroeste hasta las ruinas de {area:2738}. {object:179565} para {npc:11801} está dentro de una de las casas en ruinas."
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cabalga al suroeste hasta las ruinas de {area:2738}. {object:179565} para {npc:11801} está dentro de una de las casas en ruinas.",

	-- Step 30: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Ride back to the Southwind tower and climb it. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "",

	-- Step 32: Layo Starstrike
	-- {area:3077} Valor's Rest · {npc:13220} Layo Starstrike
	["Ride north-east from Southwind to {area:3077}. Give {npc:13220} the object from the tower before heading for the southern dunes."] = "",

	-- Step 33: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Ve al oeste hasta el bastión amurallado en el centro del desierto. {npc:15189} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",

	-- Step 34: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: mata a estos según te los encuentres",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Los Asediadores deslizantes ({npc:11740}), los Escórpidos Latipiedra ({npc:11735}) y los Arácnidos de arena ({npc:11738}) comparten las arenas justo al norte del fuerte.",

	-- Step 35: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Los fragmentos de tablilla brillantes están alrededor del campamento Crepuscular del extremo noroeste; los Agitadores sirocosos y los Estruendores del desierto de allí también los sueltan. Cuidado: los Estruendores más grandes y los Invasores giratorios son de nivel 58: atráelos de uno en uno.",

	-- Step 36: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",

	-- Step 37: Level 57
	["Level 57"] = "Nivel 57",
	-- {area:3425} Cenarion Hold · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Dredge Strikers = {npc:11740} Dredge Striker · Sand Skitterers = {npc:11738} Sand Skitterer · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Silithid Darters = {npc:231984} Silithid Darter
	["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Los Trituradores deslizantes (57-58) del sureste te superan por dos niveles si estás por debajo de 57. Primero sube a 57 con los Asediadores deslizantes (55-56) en las arenas al este de {area:3425}, donde rondan entre ellos Arácnidos de arena y Escórpidos Latipiedra (54-56), lejos de los Dardos silítidos de las arenas del norte. O, con un grupo, haz el calabozo {area:1583} (inferior) o el calabozo {quest:838} en su lugar.",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker
	["Dredge Strikers"] = "Asediadores deslizantes",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "farmea {npc:11740}",

	-- Step 38: Bor Wildmane
	-- {area:3425} Cenarion Hold
	["Pick up Bor's request on the way past {area:3425}. The western Twilight camp has his texts on the return from Kirika."] = "",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, en el lado oeste del fuerte",

	-- Step 39: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Ride south-east to {area:3447} under the Un'Goro cliffs.\nAt 57, take level 57-58 Rock Stalkers; leave the 59s."] = "",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "{item:20377} de {npc:11739}, a 130 m al suroeste",

	-- Step 41: The Twilight Lexicon
	["All three Twilight Keepers are level 60. Bring help below 59 or leave the lexicon with Ortell."] = "",

	-- Step 42: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Trituradores deslizantes ({npc:11741}) y Tenazarios",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Ve al norte por las dunas del oeste; los Trituradores deslizantes ({npc:11741}) y los Tenazarios Latipiedra ({npc:11736}) están desde aquí hasta el fuerte.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741} da vueltas por {area:2738}: búscalo dentro del círculo del mapa",

	-- Step 43: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Cabalga al oeste hasta el campamento de la Horda al norte de {area:2744}.",

	-- Step 44: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Los géiseres de silitista hacen erupción por el desierto del sur. Camina hacia el silitista que deja uno y llévalo al extractor de silitista de la Horda en el campamento de Kirika; si peleas o montas, lo sueltas.",

	-- Step 45: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Despellejadores y Acecharrocas ({npc:11739})",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers (57-58) and Rock Stalkers roam the dunes south-west of Kirika's camp. Below 58, leave the level 59 Stalkers alone."] = "",

	-- Step 46: Twilight Vanguard
	["Twilight Vanguard"] = "Vanguardia Crepuscular",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803} recorre el campamento de la Vanguardia en el extremo suroeste. Guarda cada {item:20404} que suelten los sectarios: {npc:15306} y Ortell quieren diez cada uno más adelante.",

	-- Step 49: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} ocupa el campamento del oeste.",

	-- Step 51: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804} está en el puesto al oeste de {area:3425}. Guarda también los Textos crepusculares cifrados que caigan aquí.",

	-- Step 53: Bor's texts
	["Bor's texts"] = "",
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["On the west side of the hold, take ten Encrypted Twilight Texts from Twilight Avengers or Geolords no more than one level above you. Pull them out from the edge; leave the named Keepers, Stonecallers and Flamereavers alone."] = "",

	-- Step 54: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} y {npc:15190} están en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",

	-- Step 55: Level 58
	["Level 58"] = "Nivel 58",
	-- {npc:15181} Commander Mar'alith · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["After the hand-ins, top up only if you still need 58 for {npc:15181}. Hunt Dredge Crushers (57-58) south of the hold, away from the Twilight camps. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers"] = "",

	-- Step 57: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Cabalga al noreste hasta {area:3447}.",

	-- Step 58: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "La cartera está en las montañas del extremo sur, pasando el campamento de Barbabronce. Pinzamorten, un escórpido élite, patrulla cerca: tómala mientras esté lejos.",

	-- Step 59: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "{npc:15171} y {npc:15170} acampan en el Campamento de Barbabronce, justo al norte de las montañas de la cartera. Interrógalos: pasa por toda la conversación de cada uno; no hace falta pelear con ellos.",

	-- Step 60: Twilight Base Camp
	-- {quest:8323} True Believers
	["Only if Ortell gave you {quest:8323}: bring him ten more texts on the return trip."] = "",

	-- Step 61: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "De vuelta a {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} está en el piso de arriba de su edificio: sube por dentro, la flecha no distingue los pisos.",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "El siguiente encargo de Mar'alith, A las fauces de la locura, lleva a {area:2744} entre élites. Omítelo.",

	-- Step 63: Fly to Gadgetzan
	-- {area:3425} Cenarion Hold · {area:976} Gadgetzan
	["Ride from Ortell to {area:3425} and fly to {area:976} for the hive hand-ins."] = "",

	-- Step 65: Gadgetzan
	-- {area:976} Gadgetzan · {quest:2741} The Super Egg-O-Matic
	["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "Vuela a {area:976}. ¿Todavía llevas {quest:2741}? La máquina está en el centro del pueblo.",

	-- Step 68: Ratchet
	["Liv takes the ash at her workshop on the north end of the docks."] = "",

	-- Step 69: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",

	-- Step 70: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 71: Paladin trainer
	["Paladin trainer"] = "Instructor de paladines",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} en {zone:1456}; {zone:1454} no tiene instructor de paladines",

	-- Step 74: Tai'tasi
	-- {quest:96999} Wrap Return · {zone:2482} Mount Hyjal · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {npc:3187} Tai'tasi
	["Only with {quest:96999} from {zone:2482} in your log: {area:367} is a short ride south of {zone:1454}, by the coast road; {npc:3187} stands in the village."] = "",

	-- Step 75: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 76: The Bulwark
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "Desde la torre del zepelín, cabalga al este por el camino hasta {area:152}, de camino a {zone:1422}.",

	-- Step 78: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {area:192} Northridge Lumber Camp
	["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610} se esconde en la colina al noreste de {area:192}.",

	-- Step 79: Scarlet Crusade
	["Scarlet Crusade"] = "Cruzada Escarlata",
	-- {area:192} Northridge Lumber Camp · {npc:11615} Mickey Levine · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "Caballeros y magos trabajan en {area:192}; los médicos y cazadores acampan al sur. Coloca el barril de termitas de {npc:11615} en medio del aserradero mientras estás ahí.\nCuidado: un {npc:10996}, un élite de nivel 58-59, puede estar en el campamento maderero, como en muchos otros puntos de {zone:1422}: dale espacio.",

	-- Step 81: Radley and Durgen
	["Radley and Durgen"] = "Radley y Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} está al este del campamento maderero; {npc:11611} custodia el camino al noreste de {npc:11610}, hacia {area:190}.\nCuidado: Hay guardias en la base de la torre y otro más la rodea patrullando. Despéjalos antes de enfrentar a Durgen para que no se unan a la pelea.",

	-- Step 83: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "El libram está más al norte, de camino a {area:190}.",

	-- Step 84: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Los Escarlata de {area:190} son de nivel 58-60. Entra hasta el punto alto marcado en tu mapa, observa el pueblo y sal.\nCuidado: Los centinelas apostados en la puerta pueden detectar a jugadores en sigilo. Hay más centinelas dentro del pueblo, y un élite patrulla cerca.",

	-- Step 86: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Torres de vigilancia y silos de Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Cabalga al sur hacia Andorhal. {npc:10667} espera en la posada en ruinas del lado oeste del pueblo. Párate en la entrada de cada una de las cuatro torres con {item:12815} para marcarla; no te alejes de las orillas del pueblo. Usa {item:12627} junto a los silos del centro del pueblo para hacer salir a los Parásitos temporales ({npc:10717}).",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, en el piso de arriba",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca {npc:10903} con {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca {npc:10904} con {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca {npc:10905} con {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca {npc:10902} con {item:12815}",

	-- Step 87: Chromie
	["Upstairs"] = "Arriba",

	-- Step 88: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "Las cajas fuertes están en las casas en ruinas de Andorhal alrededor de la posada de {npc:10667}. Cuidado: Suele haber necrófagos y esqueletos junto a las cajas que atacan cuando te acercas. Los necrófagos abrasadores también dañan a todo el que esté cerca y rompen el sigilo.",

	-- Step 92: High Executor Derrington
	-- {quest:105} Alas, Andorhal · {npc:1852} Araj the Summoner
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord
	["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "El fragmento de {quest:105} está a los pies de {npc:1852}, en el centro de Andorhal: es un élite de nivel 61 con señores de la guerra esqueléticos élite a su alrededor, una pelea para grupo.",

	-- Step 94: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Al este por el camino, {npc:11077} custodia el caldero de {area:200}.",

	-- Step 95: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Granja de {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse beside the cauldron, the cabinet stands inside and the outhouse is behind it. A {npc:10816} (55) carries the outhouse key; {npc:10836} (56) comes out when you open the outhouse and carries the cabinet key."] = "",

	-- Step 97: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "El escudo está en {area:201}, al sur de la choza de {npc:1855}.",

	-- Step 98: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Cabalga al este hasta la choza de {npc:1855} junto a {area:2619} y escúchalo.",

	-- Step 101: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Campeones de la Plaga ({npc:8529})",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Los Campeones de la Plaga ({npc:8529}) recorren {area:2270}, al norte de la capilla. Pasa {item:13156} de {npc:11063} sobre cada uno que mates: los cráneos que resuenan son los que él quiere.",

	-- Step 103: Hameya's scroll
	["Hameya's scroll"] = "El pergamino de Hameya",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Un pergamino roto está en la entrada de {area:2261}, la cripta al sur de {area:2260}.",

	-- Step 104: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "Pamela y {area:2261}",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Ve a {area:2262}, en el suroeste; Pamela juega entre las casas. {npc:11886} acecha en {area:2261}, la cripta justo al oeste del pueblo.\nCuidado: Con Mercutio vienen unos cuatro refuerzos no élite. Caminan hacia la tumba en vez de aparecer en el lugar.",

	-- Step 105: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Cabalga al noroeste hasta la choza de {npc:1855}.",

	-- Step 107: Alas, Andorhal
	-- {npc:1852} Araj the Summoner · {object:177241} Araj's Phylactery
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord
	["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852} (61, élite) está en el centro de Andorhal entre señores de la guerra esqueléticos (56-57, élite): mátalo con tu grupo y luego toma el fragmento de {object:177241} ahí.",

	-- Step 108: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Cabalga al suroeste hasta {npc:10667}, en Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "La Batalla de Villa Darrow de {npc:10667} termina contra élites. Omítela.",

	-- Step 109: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "Al oeste, hasta {area:152}.",

	-- Step 111: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Hacia {zone:1423}",

	-- Step 112: Pathstrider
	-- {area:2276} Quel'Lithien Lodge · {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider
	["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "Cabalga al noreste hasta {area:2276}, junto a {area:2275}: los Forestales, Zancaminos y Leñadores altos elfos la custodian y el Registro está adentro. Cuidado: los Zancaminos son de nivel 57-58 pero los Forestales llegan a 60: atráelos de uno en uno y deja a los Forestales para el final.",
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "{npc:8565} da vueltas por {area:2276}: búscalo dentro del círculo del mapa",

	-- Step 113: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "El lago para {quest:5845}",

	-- Step 114: Of Lost Honor
	["Underwater"] = "Bajo el agua",

	-- Step 115: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Hameya se esconde entre los trols Desuellamusgo de {area:2273}, en la esquina noreste.\nCuidado: Los trols del camino a {area:2273} son de nivel 57-59. Huyen con poca salud y piden ayuda, así que suelen traer refuerzos.",

	-- Step 117: Nathanos Blightcaller
	-- {npc:1855} Tirion Fordring · {area:2260} Marris Stead
	["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "Ve al sureste desde {npc:1855} hasta la granja de {area:2260}.",

	-- Step 119: Hameya's mound
	["Hameya's mound"] = "El montículo de Hameya",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just south, behind the {area:2261}."] = "{object:177675} está justo al sur, detrás de {area:2261}.",

	-- Step 120: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "Son enemigos élite: se recomienda formar un grupo, busca gente para hacerlo. {npc:11897} es un élite de nivel 60: omítelo si estás solo.",

	-- Step 122: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "Hacia {zone:1422}",

	-- Step 125: Target: Writhing Haunt
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark
	["from the cauldron, for {npc:11055} at the {area:152}"] = "del caldero, para {npc:11055} en {area:152}",

	-- Step 126: Mulgris Deepriver
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "No hiciste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.",

	-- Step 129: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} The Writhing Haunt · {area:201} Gahrron's Withering
	["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739} acampa junto a {area:202}, al lado del caldero; sus osos recorren las colinas al norte y al este, de camino a {area:201}.",

	-- Step 130: Diseased Grizzlies
	["Diseased Grizzlies"] = "Osos pardos malsanos",

	-- Step 133: Target: Gahrron's Withering
	-- {area:202} The Writhing Haunt · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "De vuelta al este pasando {area:202} hasta {area:201}, la granja bajo las colinas del este: {npc:11078} custodia su caldero. Mátalo para conseguir la llave y luego usa el caldero.",

	-- Step 134: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "Al oeste, hasta {area:152}, por última vez.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Regresa a Aldea Viento del Sur y sube a la torre. Al remover la colmena de la cima salen Emboscadores Colmen'Ashi ({npc:13301}); uno lleva {item:17346}.",
	-- ["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Cuidado: Los gorilas de Un'Goro (nivel 50-51) piden ayuda a los aliados en 20 m cuando bajan al 25 % de salud. Hay una cueva llena de simios en la zona, y pelear ahí trae muchos refuerzos.",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "Junta veinte Textos crepusculares cifrados de los sectarios de aquí, diez para {npc:15306} y diez para Ortell.",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "Junta veinte Textos Crepusculares codificados de los sectarios de aquí, diez para {npc:15306} y diez para Ortell. Consíguelos de los Vengadores Crepusculares y Geoseñores; deja a los Atracallamas y Clamapiedras (59-60).",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Dithers ofrece {item:14619} ({quest:838}). Omítela.",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Los Asediadores deslizantes ({npc:11740}), los Escórpidos Latipiedra ({npc:11735}) y los Arácnidos de arena ({npc:11738}) comparten las arenas justo al norte del fuerte.",
	-- ["Dredge and scorpids"] = "Deslizantes y escórpidos",
	-- ["Fly to {area:1637} and train."] = "Vuela a {area:1637} y entrena.",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Vuela a {area:976}. {object:142071} está en el centro del pueblo.",
	-- ["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "Si omitiste {quest:6135}, sube de nivel aquí hasta 59.14 para seguir el plan de la ruta. O, en grupo, haz la mazmorra {quest:838} o la mazmorra {area:2279}.",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarda el cebo: {npc:9684} es de nivel 56 y la segunda vuelta pasa por su guarida.",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Guarda {quest:3942}: {npc:9116} está en {area:2479}, de camino por {zone:1448} en la siguiente guía.",
	-- ["Level 59.14"] = "Nivel 59.14",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Queridísima Natalia, de Mar'alith, necesita nivel 58 y lleva a {area:2744} entre élites. Omítela.",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Al norte hasta el aserradero; coloca el barril de termitas en medio del aserradero.",
	-- ["Ride east across the plaguelands to the chapel."] = "Cabalga al este cruzando las Tierras de la Peste hasta la capilla.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Cabalga al este por el camino hasta {area:152}, en la frontera.",
	-- ["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Cabalga al noreste hasta {area:3077}; sales de {zone:1451} por el paso a su lado.",
	-- ["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "Ve al sureste desde {npc:1855} hasta {area:2261}; {object:177675} está justo detrás.",
	-- ["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Cabalga al sureste hasta {area:3447}, bajo los acantilados de Un'Goro.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cabalga al suroeste hasta las ruinas de {area:2738}. {object:179565} para {npc:11801} está dentro de una de las casas en ruinas.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Cabalga hasta {area:2262}, en el suroeste; {npc:10926} juega entre las casas. {npc:11886} acecha en {area:2261}, la cripta justo al oeste del pueblo.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Cabalga al oeste hasta el fuerte amurallado en medio del desierto.",
	-- ["Scare {npc:10977} with {npc:10980}"] = "Asusta a {npc:10977} con {npc:10980}",
	-- ["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Los Despellejadores Latipiedra ({npc:11737}) y los Acecharrocas ({npc:11739}) recorren las dunas al suroeste del campamento de Kirika.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Toma el zepelín desde la torre afuera de {area:1637} hasta {zone:1420} y cabalga hacia {zone:1458}. Lady Sylvanas ocupa {object:36126}.",
	-- ["The Spirits of Southwind"] = "Los espíritus de Viento Sur",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Los fragmentos de tablilla brillantes están alrededor del campamento Crepuscular del extremo noroeste; los Agitadores sirocosos ({npc:11744}) y los Estruendores del desierto ({npc:11746}) de allí también los sueltan.",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "El aserradero está justo al lado de Radley: deja el barril de termitas de {npc:11615} en el centro.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "El paso desde Un'Goro sale en {area:3077}, el cementerio del noreste de {zone:1451}. {npc:13220} está entre las tumbas.",
	-- ["The spare texts from the cultists"] = "Los textos sobrantes de los sectarios",
	-- ["The wooden sign beside {npc:9997}"] = "El letrero de madera junto a {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} está justo detrás de {area:2261}.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Cruza el paso y ve al este por los acantilados del norte hasta {area:541}. {npc:8737} está junto a la cueva; {npc:9117} está adentro.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Cruza el paso y ve al este por los acantilados del norte hasta {area:541}. {npc:9997} está junto al maestro de vuelo.",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Sube aquí hasta el nivel 58 antes de los Acecharrocas (57-59) de Ortell y del sur; {quest:8304} de {npc:15181}, de vuelta en {area:3425}, también requiere nivel 58. Los Trituradores deslizantes (57-58) del camino al sureste son los que quiere {npc:15191}: deja en paz a los sectarios Crepusculares que los rodean. O, con un grupo, haz el calabozo {area:1583} (Inferior) o el calabozo {quest:838} en su lugar.",
	-- ["Use {npc:10980} on {npc:10977}"] = "Usa {npc:10980} en {npc:10977}",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Al oeste hasta {area:152}. La siguiente guía empieza en {zone:1458}, a poca distancia al oeste.",
	-- ["grind on {npc:10717}"] = "sube de nivel con {npc:10717}",
	-- ["grind on {npc:11741}"] = "sube de nivel con {npc:11741}",
	-- ["ten for each quest: {npc:15306} takes his ten before Ortell"] = "diez para cada misión: {npc:15306} recibe sus diez antes que Ortell",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "La granja de {npc:10778} es la primera al este de {area:152}. Los Necrófagos farfullantes ({npc:10801}) de la granja llevan la otra mitad de su amuleto; {npc:11075} custodia el caldero del campo.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} y {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "El encargo de {npc:10926} no está en esta ruta. Omítelo.",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} recorre el campamento de la Vanguardia en el extremo suroeste. Todos los sectarios de aquí sueltan Textos Crepusculares codificados ({item:20404}), tengas la misión o no: junta veinte, diez para {npc:15306} y diez para Ortell.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} está en la avanzada al oeste de {area:3425}. Completa tus Textos Crepusculares codificados ({item:20404}) hasta veinte con los sectarios de aquí.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Los encargos de {npc:11878} no están en esta ruta. Omítelos.",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{quest:8304} de {npc:15181}, en {area:3425}, necesita nivel 58: complétalo con los Trituradores deslizantes (57-58) al oeste del puesto, y deja en paz a los vengadores, geoseñores y clamapiedras del Crepúsculo (57-61) que los rodean. O, en grupo, haz la mazmorra {area:1583} (Inferior) o la mazmorra {quest:838}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}.",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, en el lado oeste del fuerte",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "La siguiente tarea de {npc:1855}, Del honor perdido, no está en esta ruta. Omítela.",
	-- ["{npc:9117} is inside the cave."] = "{npc:9117} está dentro de la cueva.",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Ahora {npc:9619} pide la piel de {npc:9622}, en la cueva del noreste: omítela.",
	-- ["{zone:1449}: kill these as you meet them"] = "{zone:1449}: mata a estos según te los encuentres",
}
