-- Spanish (Spain) (esES): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1446} Tanaris · {zone:1451} Silithus
	["{zone:1446}, {zone:1451} & the Plaguelands"] = "",
	-- {zone:1446} Tanaris · {zone:1451} Silithus
	["{zone:1446}, {zone:1451} and the Plaguelands."] = "",
	["Takes you all the way to 60"] = "Te lleva hasta el nivel 60",
	["Stays on the main route"] = "Sigue en la ruta principal",
	["Finishes the Plaguelands chains"] = "",
	["Lots of flying between zones"] = "Muchos vuelos entre zonas",

	-- Step 1: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Vuela a {area:976}",
	-- {area:2255} Everlook
	["{area:2255} flight master"] = "",

	-- Step 2: Gaeriyan
	-- {item:11243} Videre Elixir · {area:976} Gadgetzan · {npc:9299} Gaeriyan
	["Drink the {item:11243} at the graveyard just east of {area:976}: it kills you, and only as a ghost can you see {npc:9299}, in a rocky crevice in the hills due north of it. Talk to him there, then run back to your body and resurrect: the Conspicuous Gravestone he sends you to stands in that graveyard."] = "Bebe el {item:11243} en el cementerio justo al este de {area:976}: te mata, y solo como fantasma puedes ver a {npc:9299}, en una grieta rocosa de las colinas justo al norte. Habla con él allí, luego corre de vuelta a tu cuerpo y resucita: la Lápida llamativa a la que te envía está en ese cementerio.",

	-- Step 3: Sprinkle
	-- {item:12928} Umi's Mechanical Yeti · {npc:7583} Sprinkle · {area:976} Gadgetzan · {npc:10977} Quixxil · {npc:10978} Legacki
	["Use {item:12928} on {npc:7583}, the goblin girl in {area:976}. {npc:10977} and {npc:10978} are scared later in the route."] = "Usa {item:12928} con {npc:7583}, la niña goblin de {area:976}. A {npc:10977} y {npc:10978} se les asusta más adelante en la ruta.",
	-- {npc:7583} Sprinkle · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:7583} with {item:12928}"] = "Asusta a {npc:7583} con {item:12928}",

	-- Step 4: Alchemist Pestlezugg
	-- {quest:4493} March of the Silithid · {zone:1454} Orgrimmar · {zone:1413} Barrens
	["Inside: {quest:4493}, if you took it in {zone:1454} on the {zone:1413} guide"] = "",

	-- Step 5: Alchemist Pestlezugg
	["Inside"] = "",

	-- Step 6: Gaeriyan
	-- {quest:3914} Linken's Sword · {npc:8737} Linken
	["{quest:3914} goes back to {npc:8737} in Un'Goro: keep it."] = "{quest:3914} se entrega a {npc:8737} en el Cráter de Un'Goro: guárdala.",

	-- Step 7: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1336} Lost Rigger Cove · {area:976} Gadgetzan
	["{npc:7771} camps by the {area:1336} road, south of {area:976}."] = "{npc:7771} acampa junto al camino de {area:1336}, al sur de {area:976}.",

	-- Step 8: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maestro de vuelo de {area:976}",

	-- Step 9: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:8737} Linken · {area:537} Fire Plume Ridge
	["The flight lands at {area:541}: {npc:9997} stands beside the flight master, and {npc:8737} by the cave a few steps away. Take her errand before climbing {area:537}."] = "",
	-- {npc:8737} Linken
	["Hold {npc:8737}'s errand for your return to the refuge."] = "",

	-- Step 10: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "El goblin {npc:10302} está en {area:543}, justo al este del pilón.",

	-- Step 11: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Cabalga hacia el este hasta {area:537}, súbelo y usa {npc:10541} en la grieta de lava cerca de la cima; después vuelve al oeste con {npc:10302}.",

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
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 16: Quixxil
	-- {npc:10977} Quixxil · {item:12928} Umi's Mechanical Yeti
	["Scare {npc:10977} with {item:12928}"] = "",

	-- Step 17: J.D. Collie
	-- {npc:9117} J.D. Collie
	["{npc:9117} is at the back of the refuge cave."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",

	-- Step 18: Linken's Memory
	-- {quest:3942} Linken's Memory · {area:2479} Emerald Sanctuary
	["Keep {quest:3942} for Eridan at the {area:2479}."] = "",

	-- Step 19: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} te envía con {npc:9298} en {zone:1452}: guárdala.",

	-- Step 20: Bungle in the Jungle
	-- {quest:4496} Bungle in the Jungle · {area:976} Gadgetzan · {area:540} Slithering Scar · {area:537} Fire Plume Ridge · {item:11018} Un'Goro Soil
	["Only if you took {quest:4496} in {area:976} on the way here: the Gorishi of the {area:540}, south of {area:537}, drop the Scent Gland, and most of the crater's beasts and plants drop {item:11018}."] = "Solo si aceptaste {quest:4496} en {area:976} de camino aquí: los Gorishi de {area:540}, al sur de {area:537}, sueltan la Glándula de olor, y la mayoría de bestias y plantas del cráter sueltan {item:11018}.",

	-- Step 21: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "",

	-- Step 22: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56 and his lair lies on the way to the north-east plateau."] = "",

	-- Step 24: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "La guarida de {npc:9684} está justo al sur del pilón. Usa allí el cebo de {npc:9619}; {npc:9684} es de nivel 56 y pega fuerte, así que empieza con la salud al máximo.",

	-- Step 25: The Mighty U'cha
	-- {npc:9684} Lar'korwi · {npc:9622} U'cha
	["Ride north from {npc:9684} to the gorilla cave on the plateau. {npc:9622} is level 55. Clear a path in one gorilla at a time."] = "",

	-- Step 27: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus · {npc:13220} Layo Starstrike
	["Ride around the crater to the north-western pass. It leads up to {area:3077} in {zone:1451}; {npc:13220} stands among the graves."] = "",

	-- Step 28: The Spirits of Southwind
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary · {npc:11801} Rabine Saturna
	-- was: ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cabalga al suroeste hasta las ruinas de {area:2738}. El {object:179565} para {npc:11801} está dentro de una de las casas en ruinas."
	["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cabalga al suroeste hasta las ruinas de {area:2738}. El {object:179565} para {npc:11801} está dentro de una de las casas en ruinas.",

	-- Step 30: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Ride back to the Southwind tower and climb it. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "",

	-- Step 32: Layo Starstrike
	-- {area:3077} Valor's Rest · {npc:13220} Layo Starstrike
	["Ride north-east from Southwind to {area:3077}. Give {npc:13220} the object from the tower before heading for the southern dunes."] = "",

	-- Step 33: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 34: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Los Artilleros de arrastre, los Escórpidos Latigosólido y los Arácnidos de arena comparten la arena justo al norte del fuerte.",

	-- Step 35: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler · Whirling Invaders = {npc:14455} Whirling Invader
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too. Careful: the biggest Rumblers and the Whirling Invaders are 58: pull them one at a time."] = "Los fragmentos de tablilla brillantes están alrededor del campamento Crepuscular del extremo noroeste; los sirocosos y estruendores del desierto de allí también los sueltan. Cuidado: los estruendores más grandes y los invasores giratorios son de nivel 58: atráelos de uno en uno.",

	-- Step 36: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 37: Level 57
	["Level 57"] = "Nivel 57",
	-- {area:3425} Cenarion Hold · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Dredge Strikers = {npc:11740} Dredge Striker · Sand Skitterers = {npc:11738} Sand Skitterer · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Silithid Darters = {npc:231984} Silithid Darter
	["The Dredge Crushers (57-58) of the south-east are two over you below 57. First top up to 57 on the Dredge Strikers (55-56) on the sands east of {area:3425}, where Sand Skitterers and Stonelash Scorpids (54-56) roam among them, away from the Silithid Darters of the northern sands. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Los Trituradores de arrastre (57-58) del sureste te sacan dos niveles si eres de nivel inferior a 57. Primero sube a 57 con los Artilleros de arrastre (55-56) en las arenas al este de {area:3425}, donde rondan entre ellos Arácnidos de arena y Escórpidos Latigosólido (54-56), lejos de los Dardos silítidos de las arenas del norte. O, con un grupo, haz la mazmorra {area:1583} (Inferior) o la mazmorra {quest:838}.",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker
	["Dredge Strikers"] = "Artilleros de arrastre",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "",

	-- Step 38: Bor Wildmane
	-- {area:3425} Cenarion Hold
	["Pick up Bor's request on the way past {area:3425}. The western Twilight camp has his texts on the return from Kirika."] = "",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, en el lado oeste del Fuerte",

	-- Step 39: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Ride south-east to {area:3447} under the Un'Goro cliffs.\nAt 57, take level 57-58 Rock Stalkers; leave the 59s."] = "",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "",

	-- Step 41: The Twilight Lexicon
	["All three Twilight Keepers are level 60. Bring help below 59 or leave the lexicon with Ortell."] = "",

	-- Step 42: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Trituradores y Tenazarios",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Ve al norte por las dunas del oeste; los Trituradores de arrastre y los Tnazarios Latigosólido se extienden desde aquí hasta el fuerte.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "",

	-- Step 43: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Cabalga al oeste hasta el campamento de la Horda al norte de {area:2744}.",

	-- Step 44: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Los Géiseres de silitista brotan por todo el desierto del sur. Pisa el silitista que deja uno y llévalo al extractor de silitista de la Horda, en el campamento de la General Kirika; si luchas o montas, lo sueltas.",

	-- Step 45: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Cazadores y Acechadores de piedra",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers (57-58) and Rock Stalkers roam the dunes south-west of Kirika's camp. Below 58, leave the level 59 Stalkers alone."] = "",

	-- Step 46: Twilight Vanguard
	["Twilight Vanguard"] = "Vanguardia Crepuscular",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "{npc:11803} recorre el campamento de la Vanguardia del extremo suroeste. Guarda todos los {item:20404} que suelten los fieles: {npc:15306} y Ortell quieren diez cada uno más adelante.",

	-- Step 49: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} ocupa el campamento del oeste.",

	-- Step 51: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "{npc:11804} está en el puesto al oeste de {area:3425}. Guarda también los Textos crepusculares codificados que caigan aquí.",

	-- Step 53: Bor's texts
	["Bor's texts"] = "",
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text · Twilight Avengers = {npc:11880} Twilight Avenger
	["On the west side of the hold, take ten Encrypted Twilight Texts from Twilight Avengers or Geolords no more than one level above you. Pull them out from the edge; leave the named Keepers, Stonecallers and Flamereavers alone."] = "",

	-- Step 54: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 55: Level 58
	["Level 58"] = "",
	-- {npc:15181} Commander Mar'alith · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["After the hand-ins, top up only if you still need 58 for {npc:15181}. Hunt Dredge Crushers (57-58) south of the hold, away from the Twilight camps. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers"] = "",

	-- Step 57: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Cabalga al noreste hasta {area:3447}.",

	-- Step 58: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "La bolsa está en las montañas del extremo sur, pasado el Campamento Barbabronce. Pinzamorten, un escórpido élite, patrulla cerca: cógela cuando se aleje.",

	-- Step 59: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "",

	-- Step 60: Twilight Base Camp
	-- {quest:8323} True Believers
	["Only if Ortell gave you {quest:8323}: bring him ten more texts on the return trip."] = "",

	-- Step 61: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Vuelve a {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "El siguiente encargo de Mar'alith, Into the Maw of Madness, te lleva a {area:2744} entre élites. Sáltatelo.",

	-- Step 63: Fly to Gadgetzan
	-- {area:3425} Cenarion Hold · {area:976} Gadgetzan
	["Ride from Ortell to {area:3425} and fly to {area:976} for the hive hand-ins."] = "",

	-- Step 65: Gadgetzan
	-- {area:976} Gadgetzan · {quest:2741} The Super Egg-O-Matic
	["Fly to {area:976}. Still carrying {quest:2741}? The machine stands in the middle of town."] = "Vuela a {area:976}. ¿Aún llevas {quest:2741}? La máquina está en el centro del pueblo.",

	-- Step 68: Ratchet
	["Liv takes the ash at her workshop on the north end of the docks."] = "",

	-- Step 69: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",

	-- Step 70: Class trainer
	["Class trainer"] = "Instructor de clase",

	-- Step 71: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 74: Tai'tasi
	-- {quest:96999} Wrap Return · {zone:2482} Mount Hyjal · {area:367} Sen'jin Village · {zone:1454} Orgrimmar · {npc:3187} Tai'tasi
	["Only with {quest:96999} from {zone:2482} in your log: {area:367} is a short ride south of {zone:1454}, by the coast road; {npc:3187} stands in the village."] = "",

	-- Step 75: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelín a {zone:1458}",

	-- Step 76: The Bulwark
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands
	["From the zeppelin tower ride east along the road to the {area:152}, on the way into the {zone:1422}."] = "Desde la torre del zepelín, cabalga al este por el camino hasta {area:152}, a la entrada de {zone:1422}.",

	-- Step 78: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow · {area:192} Northridge Lumber Camp
	["{npc:11610} hides on the hill north-east of the {area:192}."] = "{npc:11610} se esconde en la colina al noreste de {area:192}.",

	-- Step 79: Scarlet Crusade
	["Scarlet Crusade"] = "Cruzada Escarlata",
	-- {area:192} Northridge Lumber Camp · {npc:11615} Mickey Levine · {npc:10996} Fallen Hero · {zone:1422} Western Plaguelands
	["Knights and magi work the {area:192}; the medics and hunters camp south of it. Set {npc:11615}'s termite barrel down in the middle of the lumber mill while you are there.\nCareful: a {npc:10996}, a level 58-59 elite, can stand at the lumber camp, as at many other spots of the {zone:1422}: give it room."] = "Caballeros y magos trabajan en {area:192}; los médicos y cazadores acampan al sur. Coloca el barril de termitas de {npc:11615} en el centro del aserradero mientras estás allí.\nCuidado: puede haber un {npc:10996}, un élite de nivel 58-59, en el campamento, como en muchos otros puntos de {zone:1422}: guarda las distancias.",

	-- Step 81: Radley and Durgen
	["Radley and Durgen"] = "Radley y Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 83: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "El libram está más al norte, de camino a {area:190}.",

	-- Step 84: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 86: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Atalayas y silos de Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Cabalga al sur hasta Andorhal. {npc:10667} espera en la posada en ruinas del oeste del pueblo. Ponte en la entrada de cada una de las cuatro torres con la {item:12815} para marcarla; ve por los bordes del pueblo. Usa el {item:12627} junto a los silos del centro del pueblo para hacer salir a los Parásitos temporales.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca {npc:10903} con la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca {npc:10904} con la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca {npc:10905} con la {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca {npc:10902} con la {item:12815}",

	-- Step 87: Chromie
	["Upstairs"] = "",

	-- Step 88: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 92: High Executor Derrington
	-- {quest:105} Alas, Andorhal · {npc:1852} Araj the Summoner
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord
	["{quest:105}'s shard lies at {npc:1852}'s feet, in the middle of Andorhal: he is a level 61 elite with elite Skeletal Warlords about him, a fight for a group."] = "El fragmento de {quest:105} está a los pies de {npc:1852}, en el centro de Andorhal: es un élite de nivel 61 rodeado de Señores de la guerra esqueléticos élite, un combate para grupo.",

	-- Step 94: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Al este por el camino, {npc:11077} vigila la caldera de {area:200}.",

	-- Step 95: Dalson's Tears farmhouse
	-- {area:200} Dalson's Tears
	["{area:200} farmhouse"] = "Granja de {area:200}",
	-- {npc:10816} Wandering Skeleton · {npc:10836} Farmer Dalson
	["The diary lies in the farmhouse beside the cauldron, the cabinet stands inside and the outhouse is behind it. A {npc:10816} (55) carries the outhouse key; {npc:10836} (56) comes out when you open the outhouse and carries the cabinet key."] = "",

	-- Step 97: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "El escudo está en {area:201}, al sur de la cabaña de {npc:1855}.",

	-- Step 98: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Cabalga al este hasta la cabaña de {npc:1855} junto al {area:2619} y escúchalo.",

	-- Step 101: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Campeones de la Plaga",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Los Campeones de la Plaga recorren {area:2270}, al norte de la capilla. Pasa el {item:13156} de {npc:11063} sobre cada uno que mates: las calaveras que resuenan son las que quiere.",

	-- Step 103: Hameya's scroll
	["Hameya's scroll"] = "El pergamino de Hameya",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Hay un pergamino roto en la entrada de {area:2261}, la cripta al sur de {area:2260}.",

	-- Step 104: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "Pamela y {area:2261}",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Cabalga hasta {area:2262}, al suroeste; Pamela juega entre las casas. {npc:11886} acecha en {area:2261}, la cripta justo al oeste del pueblo.\nCuidado: con Mercutio llegan unos cuatro enemigos no élite. Caminan hasta la tumba en vez de aparecer allí mismo.",

	-- Step 105: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Cabalga al noroeste hasta la cabaña de {npc:1855}.",

	-- Step 107: Alas, Andorhal
	-- {npc:1852} Araj the Summoner · {object:177241} Araj's Phylactery
	-- plural, as words: Skeletal Warlords = {npc:1788} Skeletal Warlord
	["{npc:1852} (61, elite) stands in the middle of Andorhal among Skeletal Warlords (56-57, elite): kill him with your group, then take the shard from {object:177241} there."] = "{npc:1852} (61, élite) está en el centro de Andorhal entre Señores de la guerra esqueléticos (56-57, élite): mátalo con tu grupo y luego coge el fragmento de {object:177241} allí.",

	-- Step 108: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Cabalga al suroeste hasta {npc:10667}, en Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "La Batalla de Villa Darrow, de {npc:10667}, termina contra élites. Sáltatela.",

	-- Step 109: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "",

	-- Step 111: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",

	-- Step 112: Pathstrider
	-- {area:2276} Quel'Lithien Lodge · {area:2275} Northpass Tower
	-- plural, as words: Rangers = {npc:8564} Ranger · Pathstriders = {npc:8565} Pathstrider
	["Ride north-east to {area:2276} by {area:2275}: the high elf Rangers, Pathstriders and Woodsmen guard it and the Registry lies inside. Careful: the Pathstriders are 57-58 but the Rangers reach 60: pull one at a time and take the Rangers last."] = "Cabalga al noreste hasta {area:2276}, junto a {area:2275}: los Especialistas, Zancaminos y Leñadores altos elfos la vigilan y el Registro está dentro. Cuidado: los Zancaminos son de 57-58, pero los Especialistas llegan a 60: atráelos de uno en uno y deja a los Especialistas para el final.",
	-- {npc:8565} Pathstrider · {area:2276} Quel'Lithien Lodge
	["{npc:8565} walks around {area:2276}: look inside the circle on the map"] = "",

	-- Step 113: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 114: Of Lost Honor
	["Underwater"] = "Bajo el agua",

	-- Step 115: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 117: Nathanos Blightcaller
	-- {npc:1855} Tirion Fordring · {area:2260} Marris Stead
	["Ride south-east from {npc:1855} to the {area:2260} farmhouse."] = "Cabalga al sureste desde {npc:1855} hasta la granja de {area:2260}.",

	-- Step 119: Hameya's mound
	["Hameya's mound"] = "El montículo de Hameya",
	-- {object:177675} Mound of Dirt · {area:2261} Undercroft
	["The {object:177675} is just south, behind the {area:2261}."] = "{object:177675} está justo al sur, detrás de {area:2261}.",

	-- Step 120: Duskwing, Oh How I Hate Thee...
	-- {npc:11897} Duskwing
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:11897} is a level 60 elite: skip it if you are alone."] = "Son enemigos élite: conviene ir en grupo, busca gente con quien hacerlo. {npc:11897} es un élite de nivel 60: sáltalo si vas solo.",

	-- Step 122: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "",

	-- Step 125: Target: Writhing Haunt
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark
	["from the cauldron, for {npc:11055} at the {area:152}"] = "",

	-- Step 126: Mulgris Deepriver
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Te perdiste esto en la visita anterior de la ruta a esta zona: ahora va primero. Es rápido y abre las misiones que le siguen.",

	-- Step 129: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} The Writhing Haunt · {area:201} Gahrron's Withering
	["{npc:10739} camps by the {area:202}, beside the cauldron; his bears roam the hills north and east of it, on the way to {area:201}."] = "{npc:10739} acampa junto a {area:202}, al lado del caldero; sus osos recorren las colinas al norte y al este, de camino a {area:201}.",

	-- Step 130: Diseased Grizzlies
	["Diseased Grizzlies"] = "Griseznos malsanos",

	-- Step 133: Target: Gahrron's Withering
	-- {area:202} The Writhing Haunt · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "",

	-- Step 134: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Vuelve a Viento del Sur y sube a la torre. Al remover la colmena de la cima salen Emboscadores Colmen'Ashi; uno lleva el {item:17346}.",
	-- ["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell. Take them from the Twilight Avengers and Geolords; leave the Flamereavers and Stonecallers (59-60)."] = "Consigue veinte Textos crepusculares codificados de los fieles de aquí, diez para {npc:15306} y diez para Ortell. Cógelos de los Vengadores Crepusculares y los Geoseñores; deja a los Atracallamas y los Clamapiedras (59-60).",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "El Boticario Dithers ofrece {item:14619} ({quest:838}). Sáltatela.",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Los Artilleros de arrastre, los Escórpidos Latigosólido y los Arácnidos de arena comparten la arena justo al norte del fuerte.",
	-- ["Dredge and scorpids"] = "Arrastres y escórpidos",
	-- ["Fly to {area:1637} and train."] = "Vuela a {area:1637} y entrena.",
	-- ["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Vuela a {area:976}. El {object:142071} está en el centro del pueblo.",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarda el cebo: {npc:9684} es de nivel 56 y la segunda vuelta pasa por su guarida.",
	-- ["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Guarda {quest:3942}: {npc:9116} está en {area:2479}, de camino por {zone:1448} en la siguiente guía.",
	-- ["Ride east across the plaguelands to the chapel."] = "Cabalga al este cruzando las Tierras de la Peste hasta la capilla.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Cabalga al este por el camino hasta {area:152}, en la frontera.",
	-- ["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Cabalga al noreste hasta {area:3077}; sales de {zone:1451} por el paso que hay al lado.",
	-- ["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Cabalga al sureste hasta {area:3447}, bajo los acantilados de Un'Goro.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cabalga al suroeste hasta las ruinas de {area:2738}. El {object:179565} para {npc:11801} está dentro de una de las casas en ruinas.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Cabalga al oeste hasta el fuerte amurallado del centro del desierto.",
	-- ["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Los Cazadores Latigosólido y los Acechadores de piedra recorren las dunas al suroeste del campamento de Kirika.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Toma el zepelín de la torre de las afueras de {area:1637} a {zone:1420} y cabalga hasta {zone:1458}. Lady Sylvanas Brisaveloz está en el {object:36126}.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Los fragmentos de tablilla brillantes están alrededor del campamento Crepuscular del extremo noroeste; los Sirocosos y Estruendores del desierto de allí también los sueltan.",
	-- ["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "El aserradero está justo al lado de Radley: deja el barril de termitas de {npc:11615} en el centro.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "El paso desde Un'Goro sale en {area:3077}, el cementerio del noreste de {zone:1451}. {npc:13220} está entre las tumbas.",
	-- ["The spare texts from the cultists"] = "Los textos sobrantes de los fieles",
	-- ["The wooden sign beside {npc:9997}"] = "El cartel de madera junto a {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} está justo detrás de {area:2261}.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "Cruza el paso y ve al este por los acantilados del norte hasta {area:541}. {npc:9997} está junto al maestro de vuelo.",
	-- ["Top up here to level 58 before Ortell's Rock Stalkers (57-59) and the south; {npc:15181}'s {quest:8304}, back at {area:3425}, needs level 58 too. The Dredge Crushers (57-58) on the way south-east are the ones {npc:15191} wants: leave the Twilight cultists around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "Sube aquí a nivel 58 antes de los Acechadores de piedra (57-59) de Ortell y del sur; {quest:8304} de {npc:15181}, de vuelta en {area:3425}, también requiere nivel 58. Los Trituradores de arrastre (57-58) de camino al sureste son los que quiere {npc:15191}: deja en paz a los fieles Crepusculares que los rodean. O, con un grupo, haz la mazmorra {area:1583} (Inferior) o la mazmorra {quest:838}.",
	-- ["Use {npc:10980} on {npc:10977}"] = "Usa {npc:10980} con {npc:10977}",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Al oeste, hasta {area:152}. La siguiente guía empieza en {zone:1458}, a poca distancia al oeste.",
	-- ["grind on {npc:11741}"] = "sube nivel con {npc:11741}",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "La granja de {npc:10778} es la primera al este de {area:152}. Los Necrófagos farfullantes de la granja llevan la otra mitad de su amuleto; {npc:11075} vigila la caldera del campo.",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "El encargo propio de {npc:10926} no está en esta ruta. Sáltatelo.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Los encargos de {npc:11878} no están en esta ruta. Sáltatelos.",
	-- ["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Dredge Crushers (57-58) west of the outpost, and leave the Twilight Avengers, Geolords and Stonecallers (57-61) around them be. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "{quest:8304} de {npc:15181}, en {area:3425}, requiere nivel 58: sube con los Trituradores (57-58) al oeste del puesto y deja en paz a los vengadores, geoseñores y clamapiedras del Crepúsculo (57-61) que los rodean. O, con un grupo, haz en su lugar la mazmorra {area:1583} (inferior) o la mazmorra {quest:838}.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}.",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, en el lado oeste del Fuerte",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "La siguiente tarea de {npc:1855}, Del honor perdido, no está en esta ruta. Sáltatela.",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Ahora {npc:9619} pide la piel de {npc:9622}, en la cueva del noreste: omítela.",
}
