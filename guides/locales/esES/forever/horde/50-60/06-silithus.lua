-- Spanish (Spain) (esES): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 2: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Los Artilleros de arrastre, los Escórpidos Latigosólido y los Arácnidos de arena comparten la arena justo al norte del fuerte.",

	-- Step 3: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Los fragmentos de tablilla brillantes están alrededor del campamento Crepuscular del extremo noroeste; los Sirocosos y Estruendores del desierto de allí también los sueltan.",

	-- Step 4: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 5: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Vuelve a Viento del Sur y sube a la torre. Al remover la colmena de la cima salen Emboscadores Colmen'Ashi; uno lleva el {item:17346}.",

	-- Step 6: The Spirits of Southwind
	["The Spirits of Southwind"] = "",
	["Inside"] = "",

	-- Step 7: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Cabalga al sureste hasta {area:3447}, bajo los acantilados de Un'Goro.",
	["Below ground"] = "",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "",

	-- Step 8: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Trituradores y Tenazarios",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Ve al norte por las dunas del oeste; los Trituradores de arrastre y los Tnazarios Latigosólido se extienden desde aquí hasta el fuerte.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "",

	-- Step 9: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Cabalga al oeste hasta el campamento de la Horda al norte de {area:2744}.",

	-- Step 10: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Los Géiseres de silitista brotan por todo el desierto del sur. Pisa el silitista que deja uno y llévalo al extractor de silitista de la Horda, en el campamento de la General Kirika; si luchas o montas, lo sueltas.",

	-- Step 11: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Cazadores y Acechadores de piedra",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Los Cazadores Latigosólido y los Acechadores de piedra recorren las dunas al suroeste del campamento de Kirika.",

	-- Step 12: Twilight Vanguard
	["Twilight Vanguard"] = "Vanguardia Crepuscular",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "",

	-- Step 14: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} ocupa el campamento del oeste.",

	-- Step 15: Twilight Outpost
	-- {npc:11804} Twilight Keeper Havunth · {area:3425} Cenarion Hold
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["{npc:11804} stands in the outpost west of {area:3425}. Keep any Encrypted Twilight Texts that drop here too."] = "",

	-- Step 16: Level 58
	["Level 58"] = "",
	-- {npc:15181} Commander Mar'alith · {quest:8304} Dearest Natalia · {area:3425} Cenarion Hold · {area:1583} Blackrock Spire · {quest:838} Scholomance
	-- plural, as words: Twilight Avengers = {npc:11880} Twilight Avenger
	["{npc:15181}'s {quest:8304}, at {area:3425}, needs level 58: top up on the Twilight Avengers, Geolords and Stonecallers west of the outpost. Or, with a group, run the {area:1583} dungeon (Lower) or the {quest:838} dungeon instead."] = "",
	-- {npc:11880} Twilight Avenger
	["grind on {npc:11880}"] = "",

	-- Step 17: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, en el lado oeste del Fuerte",

	-- Step 18: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Cabalga al noreste hasta {area:3447}.",

	-- Step 19: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "La bolsa está en las montañas del extremo sur, pasado el Campamento Barbabronce. Pinzamorten, un escórpido élite, patrulla cerca: cógela cuando se aleje.",

	-- Step 20: Dearest Natalia
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170} camp at Bronzebeard's Encampment, just north of the satchel's mountains. Question them: go through each one's whole conversation; there is no need to fight them."] = "",

	-- Step 21: Twilight Base Camp
	-- {npc:15306} Bor Wildmane
	-- plural, as words: Encrypted Twilight Texts = {item:20404} Encrypted Twilight Text
	["Collect twenty Encrypted Twilight Texts from the cultists here, ten for {npc:15306} and ten for Ortell."] = "",
	-- {npc:15306} Bor Wildmane
	["ten for each quest: {npc:15306} takes his ten before Ortell"] = "",

	-- Step 22: Twilight Base Camp
	["The spare texts from the cultists"] = "Los textos sobrantes de los fieles",

	-- Step 23: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Vuelve a {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "",

	-- Step 25: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Cabalga al noreste hasta {area:3077}; sales de {zone:1451} por el paso que hay al lado.",

	-- Step 27: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 28: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "El goblin {npc:10302} está en {area:543}, justo al este del pilón.",

	-- Step 29: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Cabalga hacia el este hasta {area:537}, súbelo y usa {npc:10541} en la grieta de lava cerca de la cima; después vuelve al oeste con {npc:10302}.",

	-- Step 30: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} te envía con {npc:9298} en {zone:1452}: guárdala.",

	-- Step 31: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "",

	-- Step 32: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarda el cebo: {npc:9684} es de nivel 56 y la segunda vuelta pasa por su guarida.",

	-- Step 33: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "La guarida de {npc:9684} está justo al sur del pilón. Usa allí el cebo de {npc:9619}; {npc:9684} es de nivel 56 y pega fuerte, así que empieza con la salud al máximo.",

	-- Step 34: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "",
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "",

	-- Step 35: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117} is inside the cave."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Guarda {quest:3942}: {npc:9116} está en {area:2479}, de camino por {zone:1448} en la siguiente guía.",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "Usa {npc:10980} con {npc:10977}",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 36: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} está sentado en la cresta, perdido y agotado.",

	-- Step 37: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolta a {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "",

	-- Step 39: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Ahora {npc:9619} pide la piel de {npc:9622}, en la cueva del noreste: omítela.",

	-- Step 41: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Vuela a {area:976}. El {object:142071} está en el centro del pueblo.",

	-- Step 42: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Vuela a {area:1637}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "",

	-- Step 43: Class trainer
	["Class trainer"] = "",

	-- Step 44: Paladin trainer
	["Paladin trainer"] = "",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "",

	-- Step 47: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "",

	-- Step 50: Radley and Durgen
	["Radley and Durgen"] = "Radley y Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "",

	-- Step 51: Northridge Lumber Camp
	-- {npc:11615} Mickey Levine
	["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "",

	-- Step 53: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "El libram está más al norte, de camino a {area:190}.",

	-- Step 54: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "",

	-- Step 56: Andorhal watchtowers and silos
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

	-- Step 57: Chromie
	["Upstairs"] = "",

	-- Step 58: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 63: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Al este por el camino, {npc:11077} vigila la caldera de {area:200}.",

	-- Step 65: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "El escudo está en {area:201}, al sur de la cabaña de {npc:1855}.",

	-- Step 66: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Cabalga al este hasta la cabaña de {npc:1855} junto al {area:2619} y escúchalo.",

	-- Step 69: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Campeones de la Plaga",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Los Campeones de la Plaga recorren {area:2270}, al norte de la capilla. Pasa el {item:13156} de {npc:11063} sobre cada uno que mates: las calaveras que resuenan son las que quiere.",

	-- Step 71: Hameya's scroll
	["Hameya's scroll"] = "El pergamino de Hameya",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Hay un pergamino roto en la entrada de {area:2261}, la cripta al sur de {area:2260}.",

	-- Step 72: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "",

	-- Step 74: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Cabalga al noroeste hasta la cabaña de {npc:1855}.",

	-- Step 77: Level 59.14
	["Level 59.14"] = "",
	-- {quest:6135} Duskwing, Oh How I Hate Thee... · {quest:838} Scholomance · {area:2279} Stratholme
	["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:10717} Temporal Parasite
	["grind on {npc:10717}"] = "",

	-- Step 78: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Cabalga al suroeste hasta {npc:10667}, en Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "La Batalla de Villa Darrow, de {npc:10667}, termina contra élites. Sáltatela.",

	-- Step 79: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "",

	-- Step 80: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "",

	-- Step 81: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 82: Of Lost Honor
	["Underwater"] = "",

	-- Step 83: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "",

	-- Step 85: Hameya's mound
	["Hameya's mound"] = "El montículo de Hameya",
	-- {npc:1855} Tirion Fordring · {area:2261} Undercroft · {object:177675} Mound of Dirt
	["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "",

	-- Step 86: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "",

	-- Step 89: Target: Writhing Haunt
	-- {npc:11055} Shadow Priestess Vandis · {area:152} The Bulwark
	["from the cauldron, for {npc:11055} at the {area:152}"] = "",

	-- Step 91: Target: Gahrron's Withering
	-- {area:202} Writhing Haunt · {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Back east past the {area:202} to {area:201}, the farm under the eastern hills: {npc:11078} guards its cauldron. Kill him for the key, then use the cauldron."] = "",

	-- Step 92: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152} one last time."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "El Boticario Dithers ofrece {item:14619} ({quest:838}). Sáltatela.",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Los Artilleros de arrastre, los Escórpidos Latigosólido y los Arácnidos de arena comparten la arena justo al norte del fuerte.",
	-- ["Dredge and scorpids"] = "Arrastres y escórpidos",
	-- ["Fly to {area:1637} and train."] = "Vuela a {area:1637} y entrena.",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Queridísima Natalia, de Mar'alith, requiere nivel 58 y te lleva a {area:2744} entre élites. Sáltatela.",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Al norte, hasta el campamento maderero; deja el barril de termitas en el centro del aserradero.",
	-- ["Ride east across the plaguelands to the chapel."] = "Cabalga al este cruzando las Tierras de la Peste hasta la capilla.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Cabalga al este por el camino hasta {area:152}, en la frontera.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Cabalga al suroeste hasta las ruinas de {area:2738}. El {object:179565} para {npc:11801} está dentro de una de las casas en ruinas.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Cabalga hasta {area:2262}, al suroeste; {npc:10926} juega entre las casas. {npc:11886} acecha en {area:2261}, la cripta justo al oeste del pueblo.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Cabalga al oeste hasta el fuerte amurallado del centro del desierto.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Toma el zepelín de la torre de las afueras de {area:1637} a {zone:1420} y cabalga hasta {zone:1458}. Lady Sylvanas Brisaveloz está en el {object:36126}.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Los fragmentos de tablilla brillantes están alrededor del campamento Crepuscular del extremo noroeste; los Sirocosos y Estruendores del desierto de allí también los sueltan.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "El paso desde Un'Goro sale en {area:3077}, el cementerio del noreste de {zone:1451}. {npc:13220} está entre las tumbas.",
	-- ["The wooden sign beside {npc:9997}"] = "El cartel de madera junto a {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "{object:177675} está justo detrás de {area:2261}.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Cruza el paso y ve al este por los acantilados del norte hasta {area:541}. {npc:8737} está junto a la cueva; {npc:9117} está dentro.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Al oeste, hasta {area:152}. La siguiente guía empieza en {zone:1458}, a poca distancia al oeste.",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "La granja de {npc:10778} es la primera al este de {area:152}. Los Necrófagos farfullantes de la granja llevan la otra mitad de su amuleto; {npc:11075} vigila la caldera del campo.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} y {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "El encargo propio de {npc:10926} no está en esta ruta. Sáltatelo.",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} recorre el campamento de la Vanguardia del extremo suroeste. Todos los fieles de aquí sueltan Textos crepusculares codificados, tengas la misión o no: reúne veinte, diez para {npc:15306} y diez para el Ermitaño Ortell.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} está en el puesto al oeste de {area:3425}. Completa hasta veinte Textos crepusculares codificados con los fieles de aquí.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Los encargos de {npc:11878} no están en esta ruta. Sáltatelos.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "El campeón de {npc:15193} ocupa la granja de {area:2260}, al norte de {area:2261}.",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, en el lado oeste del Fuerte",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "La siguiente tarea de {npc:1855}, Del honor perdido, no está en esta ruta. Sáltatela.",
}
