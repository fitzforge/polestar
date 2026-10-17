-- French (frFR): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Light's Hope Chapel
	-- {npc:16256} Jessica Chambers
	["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",

	-- Step 2: Chillwind Camp
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616} : les termites viendront plus tard, à {area:2627}",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "La ferme de {npc:10927} se dresse sur la colline à l'est du camp ; le monument de {npc:10936} est juste au nord.",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, au monument",

	-- Step 4: The fields
	["The fields"] = "Les champs",
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Les Écorcheurs squelettes et les Goules écumantes errent dans les champs au nord du camp ; tous les membres du Fléau ici lâchent des Pierres du Fléau.",

	-- Step 5: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} se tient près de la ferme de {area:202}, au nord-est des champs.",

	-- Step 6: Diseased Wolves
	["Diseased Wolves"] = "Loups malades",

	-- Step 8: Diseased Grizzlies
	["Diseased Grizzlies"] = "Grizzlys malades",

	-- Step 9: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Pour les druides de {zone:1457} : gardez-la",

	-- Step 10: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Allez au nord-ouest jusqu'à la ferme des Dalson. Le journal est dans la grange ; un squelette errant porte la clé des latrines, et {npc:10836} attend dans les latrines avec la clé de l'armoire.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse"] = "{object:175924}, dans la ferme",

	-- Step 11: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Le fantôme de {npc:10778} erre près de la ferme de {area:199}, à l'ouest de {area:200} ; son colis est à l'intérieur.",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Pour {zone:1453} : gardez-la",

	-- Step 12: Chillwind Camp
	["Ride back south to the camp."] = "Retournez au camp, au sud.",

	-- Step 13: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Les tours de guet d'Andorhal",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Utilisez la {item:12815} au pied de chacune des quatre tours de guet en bordure d'Andorhal, au nord du camp.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marquer {npc:10902} avec la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marquer {npc:10903} avec la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marquer {npc:10904} avec la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marquer {npc:10905} avec la {item:12815}",

	-- Step 14: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Chaudron de {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} garde le chaudron de {area:199}, à l'ouest d'Andorhal.",

	-- Step 15: Chillwind Camp
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Achetez un {item:13320} à {npc:11056} pour le chaudron de Felstone, juste avant de partir : les catalyseurs disparaissent au bout de 30 minutes.",
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["{item:13320}, from {npc:11056}"] = "{item:13320}, auprès de {npc:11056}",

	-- Step 16: Felstone Field cauldron
	-- plural, as words: Osseous Agitators = {item:13357} Osseous Agitator
	["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Le chaudron propose maintenant sa propre tâche ; les squelettes alentour lâchent des Agitateurs osseux.",

	-- Step 17: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Chaudron de {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "Le chaudron se trouve à {area:200}, au nord-est de Felstone ; son Seigneur du Chaudron se tient à côté.",

	-- Step 19: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Chaudron de {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Le chaudron se trouve à {area:202}, près de la ferme de {npc:10739}.",
	-- {npc:1796} Freezing Ghoul · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands
	["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "tuez des {npc:1796} à {area:202}, {zone:1422}",

	-- Step 20: Chillwind Camp
	-- {area:202} Writhing Haunt
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Achetez deux autres Catalyseurs des arcanes pour les chaudrons de {area:202} et des Dalson, et allez-y directement : ils disparaissent au bout de 30 minutes.",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} est un élite de niveau 61",

	-- Step 21: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	-- plural, as words: Somatic Intensifiers = {item:13356} Somatic Intensifier
	["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Retournez au nord à {area:202} : le chaudron propose maintenant sa propre tâche. Les goules alentour lâchent des Intensificateurs somatiques.",

	-- Step 23: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} attend dans l'auberge en ruine, à l'ouest d'Andorhal.",

	-- Step 24: Andorhal
	["Andorhal"] = "Andorhal",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Utilisez le {item:12627} près des silos à grain pour faire sortir les Parasites temporels. {quest:5154} est l'un des vieux tomes de l'hôtel de ville. Tous les squelettes de la ville lâchent des {quest:5537}.",

	-- Step 25: Araj's Phylactery
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} est un élite : mieux vaut être en groupe. Il garde son phylactère au centre d'Andorhal.",

	-- Step 26: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, à {area:2268} : gardez-la",

	-- Step 27: Andorhal Watches
	["Andorhal Watches"] = "Montres d'Andorhal",
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "De petits coffrets jonchent les décombres dans tout Andorhal ; chacun contient une montre.",

	-- Step 29: More watches
	["More watches"] = "Encore des montres",

	-- Step 31: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Remontez la route vers le nord jusqu'au Camp de bûcherons de la Crête du nord ; {npc:11610} se cache en bordure du camp.",

	-- Step 32: The Scarlet Crusade
	["The Scarlet Crusade"] = "La Croisade écarlate",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Les Médecins, Chasseurs, Chevaliers et Mages écarlates patrouillent dans le camp de bûcherons et sur la route de {area:190}.",

	-- Step 34: Radley and Durgen
	["Radley and Durgen"] = "Radley et Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} arpente le camp de la Crête du nord, à l'est de {npc:11610} ; {npc:11611} garde la tour sur l'accès sud de {area:190}.",

	-- Step 36: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Surplomb de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town."] = "Montez sur la colline à l'ouest de {area:190} pour observer la ville.",

	-- Step 38: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Allez à l'est jusqu'à la rivière frontalière : {npc:1855} vit dans une petite cabane sur la rive.",

	-- Step 39: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Chaudron de {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Allez au sud jusqu'à {area:201}, où {npc:11078} garde le chaudron.",

	-- Step 40: Chillwind Camp
	["Ride south-west to the camp."] = "Retournez au camp, au sud-ouest.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} à {area:976} : gardez-la",

	-- Step 41: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, près des tombes au sud de la chapelle",

	-- Step 42: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Le crâne d'Horgus se trouve à {area:2624} et l'épée de Marduk dans {area:2623}, chacun là où des fantômes se battent ; des Chiens pestiférés adultes chassent dans les plaines entre les deux.",

	-- Step 44: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Allez au nord-ouest jusqu'à {area:2276}, en bordure de {area:2277}.",

	-- Step 45: Terrordale
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Chevauchez vers l'ouest jusqu'à {area:2627}. Chiens pestiférés chétifs ({npc:8596}), Chauves-souris pestiférées ({npc:8600}) et Larves putrides ({npc:8603}) parcourent ses bois ; remplissez {item:15042} aux grandes termitières et tuez les Chiens pestiférés frénétiques ({npc:8598}) plus au nord.",

	-- Step 46: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} se tient près de la cabane d'Augustus à {area:2627}.",

	-- Step 47: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Traversez la rivière vers l'ouest jusqu'à la cabane de {npc:1855}.",
	["Listen to his story"] = "Écouter son histoire",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} est un élite : mieux vaut être en groupe",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} se trouve dans l'hôtel de ville de {area:190}, à l'ouest de {npc:1855} : les gardes écarlates sont très rapprochés.",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} se trouve à l'est de la grange de {area:201}.",

	-- Step 50: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Traversez la rivière vers l'est jusqu'au {area:2261}, la crypte au sud-ouest de la zone. {object:177667} est à l'intérieur : sa clé est sur {npc:12248}, tout au nord-est, à faire dans le guide suivant.",

	-- Step 51: Darnassus
	-- {area:3197} Chillwind Camp · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Retournez à {area:3197} et volez jusqu'à {area:150}, prenez le bateau pour {area:442} et volez jusqu'à {area:702} ; le portail mène à {zone:1457}.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, dans {area:1658}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Dix {item:11040} tirées de la {item:11020}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, où le guide suivant passe chez les maîtres, n'a pas de maître druide",

	-- Step 52: Temple of the Moon
	["Temple of the Moon"] = "Temple de la Lune",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} et {npc:7740} se tiennent près du temple de la Lune ; remplissez {item:11682} au puits de lune à l'intérieur.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740} : gardez-la pour {area:976}",

	-- Step 53: Cenarion Enclave
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} à {zone:1450} : gardez-la",

	-- Step 54: Rut'theran Village
	-- {npc:10300} Ranshalla · {zone:1452} Winterspring
	["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} à {zone:1452} : gardez-la",

	-- Step 55: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Depuis {area:702}, volez jusqu'à {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900} : gardez-la pour {zone:1446}",

	-- Step 56: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Prenez le bateau pour le continent et allez au nord-est jusqu'au camp de {npc:14637}, près de {area:1119}.",

	-- Step 57: Zapped giants and sea elementals
	["Zapped giants and sea elementals"] = "Géants rétrécis et élémentaires des mers",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Les géants rétrécis errent autour de {area:1119} ; les élémentaires des mers longent la côte à l'ouest.",

	-- Step 59: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "Le camp de {npc:7775} est au nord de {area:1119}. Il vend l'{item:11243} une fois qu'il a son appât.",

	-- Step 60: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "Volez jusqu'à {area:392}.",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro"] = "{npc:8496} : gardez-la pour le Cratère d'Un'Goro",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}, sur la côte au nord de la ville",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Pour {zone:1448} : gardez-la",

	-- Step 61: Ranshalla
	-- {area:392} Ratchet · {area:2255} Everlook · {area:2250} Owl Wing Thicket
	["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Depuis {area:392}, volez jusqu'à {area:2255} puis allez au sud jusqu'à {area:2250}.",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "{npc:10300} : son escorte viendra plus tard sur l'itinéraire",

	-- Step 62: Donova Snowden
	["Ride west along the road to the hot springs."] = "Suivez la route vers l'ouest jusqu'aux sources chaudes.",
	-- {area:976} Gadgetzan
	["Gaeriyan in {area:976}: keep it"] = "Gaeriyan à {area:976} : gardez-la",

	-- Step 63: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Entrez dans {area:1769} et prenez la branche du tunnel vers {zone:1450} jusqu'à {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Pour {zone:1451} : gardez-la",

	-- Step 64: Ratchet
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["The next guide starts here in {area:392} and flies on to {area:976}."] = "Le guide suivant commence ici à {area:392} et continue en vol jusqu'à {area:976}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Traversez la rivière vers l'est jusqu'à {area:2261}, la crypte au sud-ouest de la zone. {object:177667} est à l'intérieur : sa clé est sur {npc:12248}, tout au nord-est, à faire dans le guide suivant.",
}
