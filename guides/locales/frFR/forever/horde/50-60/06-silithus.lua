-- French (frFR): the guide forever/horde/50-60/06-silithus (forever/horde/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["Ride west to the walled hold in the middle of the desert. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 2: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451} : tuez-les au passage",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Frappeurs térébrants, Scorpides Cinglepierre et Glisseuses du sable se partagent les sables juste au nord du fort.",

	-- Step 3: Twilight Base Camp
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Les fragments de tablette luisants se trouvent autour du camp du Crépuscule, tout au nord-ouest ; les Tempétueux de poussière et Grondeurs du désert du coin en lâchent aussi.",

	-- Step 4: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 5: Hive in the Tower
	-- {item:17346} Encrusted Silithid Object
	-- plural, as words: Hive'Ashi Ambushers = {npc:13301} Hive'Ashi Ambusher
	["Back to Southwind and climb the tower. Stirring the hive at the top brings out Hive'Ashi Ambushers; one carries the {item:17346}."] = "Retournez à Sudevent et montez dans la tour. Remuer la ruche au sommet fait sortir des Embusquées de la Ruche'Ashi ({npc:13301}) ; l'une porte {item:17346}.",

	-- Step 6: The Spirits of Southwind
	["The Spirits of Southwind"] = "",
	["Inside"] = "À l'intérieur",

	-- Step 7: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride south-east to {area:3447} under the Un'Goro cliffs."] = "Allez vers le sud-est jusqu'à {area:3447}, au pied des falaises d'Un'Goro.",
	["Below ground"] = "Sous terre",
	-- {item:20377} Rock Stalker Fang · {npc:11739} Rock Stalker
	["{item:20377} from {npc:11739}, 130 yd south-west"] = "",

	-- Step 8: Dredge Crushers and Pincers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers and Pincers"] = "Écraseurs térébrants et Pinceurs",
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer
	["Head north along the western dunes; Dredge Crushers and Stonelash Pincers range from here back toward the hold."] = "Remontez vers le nord le long des dunes de l'ouest ; les Ecraseurs térébrants et les Pinceurs Cinglepierre rôdent d'ici jusqu'au fort.",
	-- {npc:11741} Dredge Crusher · {area:2738} Southwind Village
	["{npc:11741} walks around {area:2738}: look inside the circle on the map"] = "{npc:11741} se promène autour de {area:2738} : cherchez dans le cercle sur la carte",

	-- Step 9: General Kirika
	-- {area:2744} Hive'Regal
	["Ride west to the Horde camp north of {area:2744}."] = "Allez vers l'ouest jusqu'au camp de la Horde au nord de la {area:2744}.",

	-- Step 10: Scouring the Desert
	["Silithyst geysers erupt across the southern desert. Walk into the Silithyst one leaves behind and carry it to the Horde's Silithyst Extractor at Kirika's camp; fighting or mounting drops it."] = "Des Geysers de silithyste jaillissent dans le désert du sud. Marchez dans le silithyste qu'ils laissent et portez-le à l'extracteur de silithyste de la Horde, au camp de Kirika ; combattre ou monter en selle vous le fait lâcher.",

	-- Step 11: Flayers and Rock Stalkers
	-- plural, as words: Rock Stalkers = {npc:11739} Rock Stalker
	["Flayers and Rock Stalkers"] = "Écorcheurs et Traqueuses des rochers",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker
	["Stonelash Flayers and Rock Stalkers roam the dunes south-west of Kirika's camp."] = "Les Ecorcheurs Cinglepierre et les Traqueuses des rochers parcourent les dunes au sud-ouest du camp de Kirika.",

	-- Step 12: Twilight Vanguard
	["Twilight Vanguard"] = "Avant-garde du Crépuscule",
	-- {npc:11803} Twilight Keeper Exeter · {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane
	["{npc:11803} walks the Vanguard camp in the far south-west. Keep every {item:20404} the cultists drop: {npc:15306} and Ortell want ten each later."] = "",

	-- Step 14: Twilight Post
	-- {npc:15200} Twilight Keeper Mayna
	["{npc:15200} holds the camp in the west."] = "{npc:15200} tient le camp de l'ouest.",

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
	["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, du côté ouest du fort",

	-- Step 18: Hermit Ortell
	-- {area:3447} Ortell's Hideout
	["Ride north-east to {area:3447}."] = "Allez vers le nord-est jusqu'à {area:3447}.",

	-- Step 19: Noggle's Lost Satchel
	["The satchel lies in the mountains of the far south, past Bronzebeard's Encampment. Deathclasp, an elite scorpid, patrols near it: grab it while he is away."] = "La sacoche se trouve dans les montagnes de l'extrême sud, au-delà du Campement de Bronzebeard. Poigne-de-mort, un scorpide élite, patrouille à proximité : prenez-la pendant qu'il s'éloigne.",

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
	["The spare texts from the cultists"] = "Les textes en trop des cultistes",

	-- Step 23: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "Retour au {area:3425}",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {area:2744} Hive'Regal
	["Mar'alith's next errand, Into the Maw of Madness, leads into {area:2744} among elites. Skip it."] = "",

	-- Step 25: Layo Starstrike
	-- {area:3077} Valor's Rest · {zone:1451} Silithus
	["Ride north-east to {area:3077}; you leave {zone:1451} through the pass beside it."] = "Allez vers le nord-est jusqu'au cimetière ({area:3077}) ; vous quittez {zone:1451} par le col tout proche.",

	-- Step 27: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock
	["Through the pass and east along the northern cliffs to {area:541}. {npc:9997} stands beside the flight master."] = "",

	-- Step 28: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "Le gobelin {npc:10302} est assis à {area:543}, juste à l'est du pylône.",

	-- Step 29: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Chevauchez vers l'est jusqu'à {area:537}, grimpez-y et utilisez {npc:10541} sur la cheminée de lave près du sommet, puis revenez vers l'ouest jusqu'à {npc:10302}.",

	-- Step 30: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} vous envoie voir {npc:9298} au {zone:1452} : gardez-la.",

	-- Step 31: Pawn Captures Queen
	-- {item:11833} Gorishi Queen Lure · {area:540} Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Use the {item:11833} where the arrow points, inside the Gorishi hive of the {area:540}, to call the {npc:10041} (level 56)."] = "",

	-- Step 32: Torwa Pathfinder
	-- {npc:9684} Lar'korwi
	["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Gardez l'appât : {npc:9684} est de niveau 56, et la deuxième boucle passe par son repaire.",

	-- Step 33: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder
	["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "Le repaire de {npc:9684} est juste au sud du pylône. Utilisez-y l'appât de {npc:9619} ; {npc:9684} est de niveau 56 et frappe fort, commencez donc avec toute votre vie.",

	-- Step 34: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449} : tuez-les au passage",
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["Careful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Attention : les Gorilles d'Un'Goro (niveau 50-51) appellent à l'aide leurs alliés à moins de 20 m dès qu'ils tombent à 25 % de vie. Une grotte pleine de singes se trouve dans le coin, et y combattre attire de nombreux renforts.",

	-- Step 35: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117} is inside the cave."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, sous terre",
	-- {quest:3942} Linken's Memory · {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary · {zone:1448} Felwood
	["Keep {quest:3942}: {npc:9116} is at the {area:2479}, on the next guide's way through {zone:1448}."] = "Gardez {quest:3942} : {npc:9116} se trouve au {area:2479}, sur le chemin du guide suivant à travers {zone:1448}.",
	-- {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Use {npc:10980} on {npc:10977}"] = "Utilisez {npc:10980} sur {npc:10977}",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 36: Ringo
	-- {npc:9999} Ringo
	["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} est assis sur la crête, perdu et épuisé.",

	-- Step 37: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escortez {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Menez {npc:9999} vers le nord jusqu'au {area:541}. Quand il s'évanouit, utilisez {item:11804} sur lui pour le réveiller.",

	-- Step 39: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "{npc:9619} demande maintenant la peau d'{npc:9622}, dans la grotte du nord-est : passez-la.",

	-- Step 41: Gadgetzan
	-- {area:976} Gadgetzan · {object:142071} Egg-O-Matic
	["Fly to {area:976}. The {object:142071} stands in the middle of town."] = "Volez jusqu'à {area:976}. L'{object:142071} se dresse au milieu de la ville.",

	-- Step 42: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Prendre un vol pour {area:1637}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maître de vol de {area:976}",

	-- Step 43: Class trainer
	["Class trainer"] = "Maître de classe",

	-- Step 44: Paladin trainer
	["Paladin trainer"] = "Maître des paladins",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {zone:1454} Orgrimmar
	["{npc:246344} in {zone:1456}; {zone:1454} has no paladin trainer"] = "{npc:246344} ({zone:1456}) ; {zone:1454} n'a pas de maître des paladins",

	-- Step 47: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zeppelin pour {zone:1458}",

	-- Step 50: Radley and Durgen
	["Radley and Durgen"] = "Radley et Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11611} Cavalier Durgen · {npc:11610} Kirsta Deepshadow · {area:190} Hearthglen
	["{npc:11613} stands east of the lumber camp; {npc:11611} guards the road north-east of {npc:11610}, toward {area:190}.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} se tient à l'est du camp de bûcherons ; {npc:11611} garde la route au nord-est de {npc:11610}, en direction de {area:190}.\nAttention : des gardes se tiennent au pied de la tour et un autre en fait le tour en patrouille. Éliminez-les avant d'engager Durgen pour qu'ils ne rejoignent pas le combat.",

	-- Step 51: Northridge Lumber Camp
	-- {npc:11615} Mickey Levine
	["The lumber mill is right beside Radley: set {npc:11615}'s termite barrel down in the middle of it."] = "",

	-- Step 53: Davil's Libram
	-- {area:190} Hearthglen
	["The libram lies further north, on the way to {area:190}."] = "Le libram se trouve plus au nord, sur la route de {area:190}.",

	-- Step 54: Hearthglen
	-- {area:190} Hearthglen
	["{area:190}'s Scarlets are level 58-60. Ride in to the high point marked on your map, look over the town, and get out.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Les Écarlates de {area:190} sont de niveau 58-60. Entrez jusqu'au point haut marqué sur votre carte, observez la ville, puis repartez.\nAttention : les sentinelles postées à la porte peuvent détecter les joueurs camouflés. D'autres sentinelles se trouvent dans la ville, et un élite patrouille à proximité.",

	-- Step 56: Andorhal watchtowers and silos
	["Andorhal watchtowers and silos"] = "Tours de guet et silos d'Andorhal",
	-- {npc:10667} Chromie · {item:12815} Beacon Torch · {item:12627} Temporal Displacer
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Ride south into Andorhal. {npc:10667} waits in the ruined inn on the west side of town. Stand in the doorway of each of the four towers with the {item:12815} to mark it; keep to the edges of town. Use the {item:12627} by the silos in the middle of town to bring out Temporal Parasites."] = "Allez vers le sud jusqu'à Andorhal. {npc:10667} attend dans l'auberge en ruine à l'ouest de la ville. Placez-vous sur le seuil de chacune des quatre tours avec {item:12815} pour la marquer ; restez en bordure de la ville. Utilisez {item:12627} près des silos au centre de la ville pour faire apparaître des Parasites temporels.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, à l'étage",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marquez {npc:10903} avec {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marquez {npc:10904} avec {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marquez {npc:10905} avec {item:12815}",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marquez {npc:10902} avec {item:12815}",

	-- Step 57: Chromie
	["Upstairs"] = "À l'étage",

	-- Step 58: Counting Out Time
	-- {npc:10667} Chromie
	["The lockboxes sit in Andorhal's ruined houses around {npc:10667}'s inn. Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "",

	-- Step 63: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears
	["East along the road, {npc:11077} guards the cauldron at {area:200}."] = "Plus à l'est sur la route, {npc:11077} garde le chaudron des {area:200}.",

	-- Step 65: Redpath's Shield
	-- {area:201} Gahrron's Withering · {npc:1855} Tirion Fordring
	["The shield lies at {area:201}, south of {npc:1855}'s hut."] = "Le bouclier se trouve à {area:201}, au sud de la cabane de {npc:1855}.",

	-- Step 66: Tirion Fordring
	-- {npc:1855} Tirion Fordring · {area:2619} Thondroril River
	["Ride east to {npc:1855}'s hut by the {area:2619} and hear him out."] = "Allez vers l'est jusqu'à la cabane de {npc:1855}, au bord de {area:2619}, et écoutez-le.",

	-- Step 69: Scourge Champions
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions"] = "Champions du Fléau",
	-- {area:2270} Noxious Glade · {npc:11063} Carlin Redpath · {item:13156} Mystic Crystal
	-- plural, as words: Scourge Champions = {npc:8529} Scourge Champion
	["Scourge Champions roam the {area:2270}, north of the chapel. Pass {npc:11063}'s {item:13156} over each one you kill: the skulls that resonate are the ones he wants."] = "Les Champions du Fléau parcourent {area:2270}, au nord de la chapelle. Passez {item:13156} de {npc:11063} sur chacun de ceux que vous tuez : les crânes qui résonnent sont ceux qu'il veut.",

	-- Step 71: Hameya's scroll
	["Hameya's scroll"] = "Le parchemin d'Hameya",
	-- {area:2261} Undercroft · {area:2260} Marris Stead
	["A torn scroll lies at the entrance of the {area:2261}, the crypt south of the {area:2260}."] = "Un parchemin déchiré se trouve à l'entrée de {area:2261}, la crypte au sud de {area:2260}.",

	-- Step 72: Pamela and the Undercroft
	-- {area:2261} Undercroft
	["Pamela and the {area:2261}"] = "Pamela et {area:2261}",
	-- {area:2262} Darrowshire · {npc:11886} Mercutio Filthgorger · {area:2261} Undercroft
	["Ride to {area:2262} in the south-west; Pamela plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town.\nCareful: About four non-elite adds come with Mercutio. They walk to the grave instead of appearing on the spot."] = "Chevauchez jusqu'à {area:2262}, au sud-ouest ; Pamela joue entre les maisons. {npc:11886} rôde dans {area:2261}, la crypte juste à l'ouest de la ville.\nAttention : environ quatre renforts non élites arrivent avec Mercutio. Ils marchent jusqu'à la tombe au lieu d'apparaître sur place.",

	-- Step 74: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride north-west to {npc:1855}'s hut."] = "Allez vers le nord-ouest jusqu'à la cabane de {npc:1855}.",

	-- Step 77: Level 59.14
	["Level 59.14"] = "Niveau 59.14",
	-- {quest:6135} Duskwing, Oh How I Hate Thee... · {quest:838} Scholomance · {area:2279} Stratholme
	["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan. Or, with a group, run the {quest:838} dungeon or the {area:2279} dungeon instead."] = "",
	-- {npc:10717} Temporal Parasite
	["grind on {npc:10717}"] = "tuez en boucle : {npc:10717}",

	-- Step 78: Chromie
	-- {npc:10667} Chromie
	["Ride south-west to {npc:10667} in Andorhal."] = "Allez vers le sud-ouest jusqu'à {npc:10667}, à Andorhal.",
	-- {npc:10667} Chromie
	["{npc:10667}'s Battle of Darrowshire ends against elites. Skip it."] = "La bataille de Comté-de-Darrow, quête de {npc:10667}, se termine contre des élites. Passez-la.",

	-- Step 79: The Bulwark
	-- {area:152} The Bulwark
	["West to the {area:152}."] = "",

	-- Step 80: Into Eastern Plaguelands
	-- {zone:1423} Eastern Plaguelands
	["Into {zone:1423}"] = "Vers {zone:1423}",

	-- Step 81: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 82: Of Lost Honor
	["Underwater"] = "Sous l'eau",

	-- Step 83: Infiltrator Hameya
	-- {area:2273} Zul'Mashar
	["Hameya hides among the Mossflayer trolls of {area:2273}, in the north-east corner.\nCareful: The trolls along the path to {area:2273} are level 57-59. They run away at low health and call for help, so they often bring adds with them."] = "Hameya se cache parmi les trolls Mossflayer de {area:2273}, dans le coin nord-est.\nAttention : les trolls le long du chemin vers {area:2273} sont de niveau 57-59. Ils s'enfuient quand leur vie est basse et appellent à l'aide, ils ramènent donc souvent des renforts.",

	-- Step 85: Hameya's mound
	["Hameya's mound"] = "Le monticule d'Hameya",
	-- {npc:1855} Tirion Fordring · {area:2261} Undercroft · {object:177675} Mound of Dirt
	["Ride south-east from {npc:1855} to the {area:2261}; the {object:177675} is just behind it."] = "",

	-- Step 86: Into Western Plaguelands
	-- {zone:1422} Western Plaguelands
	["Into {zone:1422}"] = "Vers {zone:1422}",

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
	-- ["Back to Southwind and climb the tower. Stirring the hive at the top brings out {area:2742} Ambushers; one carries the {item:17346}."] = "Retournez à Sudevent et montez dans la tour. Remuer la ruche au sommet fait sortir des Embusquées de la {area:2742} ; l'une d'elles porte {item:17346}.",
	-- ["Careful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "Attention : des goules et des squelettes se tiennent généralement près des caisses et attaquent quand vous approchez. Les goules brûlantes blessent aussi tout ce qui est à proximité et brisent le camouflage.",
	-- ["Collie is inside it."] = "Collie se trouve à l'intérieur.",
	-- ["Dithers offers {item:14619} ({quest:838}). Skip it."] = "Dithers propose {item:14619} ({quest:838}). Passez-la.",
	-- ["Dithers offers {quest:964} ({quest:838}). Skip it."] = "Dithers propose {quest:964} ({quest:838}). Passez-la.",
	-- ["Dredge Strikers, Stonelash Scorpids and Sand Skitterers share the sands just north of the hold."] = "Les Frappeurs térébrants, les Scorpides Cinglepierre et les Glisseuses du sable se partagent les sables juste au nord du fort.",
	-- ["Dredge and scorpids"] = "Térébrants et scorpides",
	-- ["Fly to {area:1637} and train."] = "Volez jusqu'à {area:1637} et entraînez-vous.",
	-- ["Fly to {area:541}"] = "Prendre un vol pour {area:541}",
	-- ["Fly to {zone:1454}"] = "Prendre un vol pour {zone:1454}",
	-- ["If you skipped {quest:6135}, grind here to level 59.14 to stay on the route's plan."] = "Si vous avez passé {quest:6135}, tuez des monstres ici jusqu'au niveau 59.14 pour rester dans le plan du parcours.",
	-- ["Mar'alith's Dearest Natalia needs level 58 and leads into {area:2744} among elites. Skip it."] = "Chère Natalia, la quête de Mar'alith, demande le niveau 58 et mène dans la {area:2744}, parmi des élites. Passez-la.",
	-- ["Mar'alith's {quest:8304} needs level 58 and leads into {area:2744} among elites. Skip it."] = "{quest:8304}, la quête de Mar'alith, demande le niveau 58 et mène dans {area:2744}, parmi des élites. Passez-la.",
	-- ["North to the lumber camp; set the termite barrel down in the middle of the mill."] = "Au nord, jusqu'au camp de bûcherons ; posez le tonneau de termites au milieu de la scierie.",
	-- ["On the way"] = "En chemin",
	-- ["Ride east across the plaguelands to the chapel."] = "Traversez les maleterres vers l'est jusqu'à la chapelle.",
	-- ["Ride east along the road to the {area:152} on the border."] = "Suivez la route vers l'est jusqu'à la {area:152}, à la frontière.",
	-- ["Ride south-west to the ruins of {area:2738}. The {object:179565} for {npc:11801} sits inside one of the ruined houses."] = "Allez vers le sud-ouest jusqu'aux ruines du {area:2738}. Le {object:179565} pour {npc:11801} se trouve dans l'une des maisons en ruine.",
	-- ["Ride to {area:2262} in the south-west; {npc:10926} plays among the houses. {npc:11886} lurks in the {area:2261}, the crypt just west of the town."] = "Allez jusqu'à {area:2262}, au sud-ouest ; {npc:10926} joue entre les maisons. {npc:11886} rôde dans {area:2261}, la crypte juste à l'ouest du village.",
	-- ["Ride west to the walled hold in the middle of the desert."] = "Allez vers l'ouest jusqu'au fort fortifié au milieu du désert.",
	-- ["Take the zeppelin from the tower outside {area:1637} to {zone:1420} and ride into the {zone:1458}. Lady Sylvanas holds the {object:36126}."] = "Prenez le zeppelin depuis la tour à l'extérieur d'{area:1637} jusqu'à {zone:1420} et entrez dans {zone:1458}. Dame Sylvanas règne sur le {object:36126}.",
	-- ["The glowing tablet fragments lie around the Twilight camp in the far north-west; the Dust Stormers and Desert Rumblers there drop them too."] = "Les fragments de tablette luisants jonchent le Campement du crépuscule, à l'extrême nord-ouest ; les Tempétueux de poussière et les Grondeurs du désert de l'endroit en laissent aussi tomber.",
	-- ["The pass from Un'Goro comes out at {area:3077}, the graveyard in north-east {zone:1451}. {npc:13220} stands among the graves."] = "Le col venant d'Un'Goro débouche sur {area:3077}, le cimetière du nord-est de {zone:1451}. {npc:13220} se tient parmi les tombes.",
	-- ["The wooden sign beside {npc:9997}"] = "Le panneau en bois à côté de {npc:9997}",
	-- ["The {object:177675} is just behind the {area:2261}."] = "Le {object:177675} se trouve juste derrière {area:2261}.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; J.D."] = "Passez le col puis allez vers l'est le long des falaises du nord jusqu'au {area:541}. {npc:8737} se tient près de la grotte ; J.D.",
	-- ["Through the pass and east along the northern cliffs to {area:541}. {npc:8737} stands by the cave; {npc:9117} is inside it."] = "Passez le col puis longez les falaises du nord vers l'est jusqu'au {area:541}. {npc:8737} se tient près de la grotte ; {npc:9117} est à l'intérieur.",
	-- ["West to the {area:152}. The next guide starts in the {zone:1458}, a short ride west."] = "Vers l'ouest jusqu'à la {area:152}. Le prochain guide commence à {zone:1458}, un peu plus à l'ouest.",
	-- ["{area:1099} flight master"] = "Maître de vol du {area:1099}",
	-- ["{npc:10778}'s farm is the first one east of the {area:152}. Jabbering Ghouls on the farm carry the other half of her charm; {npc:11075} guards the cauldron in the field."] = "La ferme de {npc:10778} est la première à l'est de la {area:152}. Les Goules jacassantes de la ferme portent l'autre moitié de son talisman ; {npc:11075} garde le chaudron dans le champ.",
	-- ["{npc:10926} and the {area:2261}"] = "{npc:10926} et {area:2261}",
	-- ["{npc:10926}'s own errand is not on this route. Skip it."] = "La quête propre à {npc:10926} ne fait pas partie de cet itinéraire. Passez-la.",
	-- ["{npc:11803} walks the Vanguard camp in the far south-west. Every cultist here drops Encrypted Twilight Texts, quest or not: collect twenty, ten for {npc:15306} and ten for Ortell."] = "{npc:11803} arpente le camp de l'Avant-garde, à l'extrême sud-ouest. Chaque cultiste ici laisse tomber des Textes du crépuscule cryptés, quête ou non : récupérez-en vingt, dix pour {npc:15306} et dix pour Ortell.",
	-- ["{npc:11804} stands in the outpost west of {area:3425}. Top your Encrypted Twilight Texts up to twenty on the cultists here."] = "{npc:11804} se tient dans l'avant-poste à l'ouest du {area:3425}. Complétez vos Textes du crépuscule cryptés jusqu'à vingt sur les cultistes du coin.",
	-- ["{npc:11878}' errands are not on this route. Skip them."] = "Les quêtes de {npc:11878} ne font pas partie de cet itinéraire. Passez-les.",
	-- ["{npc:15193}'s champion holds the {area:2260} farmhouse, north of the {area:2261}."] = "Le champion de {npc:15193} occupe la maison de {area:2260}, au nord de la crypte ({area:2261}).",
	-- ["{npc:15306}, on the west side of the Hold"] = "{npc:15306}, du côté ouest du fort",
	-- ["{npc:1855}'s next task, Of Lost Honor, is not on this route. Skip it."] = "La tâche suivante de {npc:1855}, De l'honneur perdu, ne fait pas partie de cet itinéraire. Passez-la.",
	-- ["{npc:9167} walks around here: look inside the circle on the map"] = "{npc:9167} se promène par ici : cherchez dans le cercle sur la carte",
}
