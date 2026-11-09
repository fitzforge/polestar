-- French (frFR): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission · {spell:437801} Light's Hope · {zone:1452} Winterspring
	["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "",

	-- Step 4: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197} : tuez-les au passage",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Des Écorcheurs squelettes et des Goules écumantes parcourent les champs au nord du camp ; tout le Fléau ici laisse tomber des Pierres du Fléau.\nAttention : ces morts-vivants vous repèrent de loin, et les autres morts-vivants proches se joignent au combat quand vous en attirez un.\nAttention : l'{npc:10411} (3 apparitions, réapparition en 15 min) devient invisible hors combat et appelle des Gargouilles Aile-de-roc dès qu'un combat commence.",

	-- Step 5: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "La ferme de {npc:10927} se dresse sur la colline à l'est du camp ; le monument de {npc:10936} est juste au nord.",
	["Upstairs"] = "À l'étage",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, au monument",

	-- Step 6: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Allez au nord-ouest jusqu'à la ferme des Dalson. Le journal est dans la grange ; un squelette errant porte la clé des latrines, et {npc:10836} attend dans les latrines avec la clé de l'armoire.",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "{quest:5058}, à l'intérieur",
	["Inside"] = "À l'intérieur",

	-- Step 7: The Writhing Haunt: kill these as you meet them
	-- {area:202} The Writhing Haunt
	["{area:202}: kill these as you meet them"] = "{area:202} : tuez-les au passage",

	-- Step 8: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924}, dans la ferme ; à l'intérieur",

	-- Step 9: Chillwind Camp
	["Ride back south to the camp."] = "Retournez au camp, au sud.",

	-- Step 10: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Les tours de guet d'Andorhal",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Utilisez la {item:12815} au pied de chacune des quatre tours de guet en bordure d'Andorhal, au nord du camp.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marquer {npc:10902} avec la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marquer {npc:10903} avec la {item:12815}",

	-- Step 11: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} attend dans l'auberge en ruine, à l'ouest d'Andorhal.",

	-- Step 12: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marquer {npc:10904} avec la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marquer {npc:10905} avec la {item:12815}",

	-- Step 13: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} est un élite de niveau 61",

	-- Step 14: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Chaudron de {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "Le chaudron se trouve à {area:200}, au nord-est de Felstone ; son Seigneur du Chaudron se tient à côté.",

	-- Step 15: Andorhal
	["Andorhal"] = "Andorhal",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Utilisez le {item:12627} près des silos à grain pour faire sortir les Parasites temporels. {quest:5154} est l'un des vieux tomes de l'hôtel de ville. Tous les squelettes de la ville lâchent des {quest:5537}.",

	-- Step 17: The Writhing Haunt cauldron
	-- {area:202} The Writhing Haunt
	["{area:202} cauldron"] = "Chaudron de {area:202}",
	-- {area:202} The Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "Le chaudron se trouve à {area:202}, près de la ferme de {npc:10739}.",

	-- Step 19: Diseased Grizzlies
	["Diseased Grizzlies"] = "Grizzlys malades",

	-- Step 20: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Pour les druides de {zone:1457} : gardez-la",

	-- Step 22: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, à {area:2268} : gardez-la",

	-- Step 23: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "{npc:1852} est élite : mieux vaut être en groupe. Il garde son phylactère au milieu d'Andorhal.\nDe petits coffrets reposent dans les décombres partout dans Andorhal ; chacun contient une montre.\nAttention : des goules et des squelettes se tiennent souvent près des coffrets et attaquent quand vous approchez. Les goules brûlantes blessent aussi tout ce qui est à proximité et rompent le camouflage.",

	-- Step 25: More watches
	["More watches"] = "Encore des montres",

	-- Step 27: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Remontez la route vers le nord jusqu'au Camp de bûcherons de la Crête du nord ; {npc:11610} se cache en bordure du camp.",

	-- Step 28: The Scarlet Crusade
	["The Scarlet Crusade"] = "La Croisade écarlate",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Les Médecins, Chasseurs, Chevaliers et Mages écarlates patrouillent dans le camp de bûcherons et sur la route de {area:190}.",

	-- Step 30: Radley and Durgen
	["Radley and Durgen"] = "Radley et Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} parcourt le camp de Crête-du-Nord à l'est de {npc:11610} ; {npc:11611} garde la tour à l'approche sud de {area:190}.\nAttention : des gardes se tiennent au pied de la tour et un autre en fait le tour en patrouille. Éliminez-les avant d'engager Durgen pour qu'ils ne se joignent pas au combat.",

	-- Step 32: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Surplomb de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Montez sur la colline à l'ouest de {area:190} pour dominer la ville.\nAttention : les sentinelles postées à la porte peuvent détecter les joueurs camouflés. D'autres sentinelles se trouvent dans la ville, et un élite patrouille à proximité.",

	-- Step 34: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Allez à l'est jusqu'à la rivière frontalière : {npc:1855} vit dans une petite cabane sur la rive.",

	-- Step 35: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Chaudron de {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Allez au sud jusqu'à {area:201}, où {npc:11078} garde le chaudron.",

	-- Step 36: Chillwind Camp
	["Ride south-west to the camp."] = "Retournez au camp, au sud-ouest.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} à {area:976} : gardez-la",

	-- Step 37: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Prendre un vol pour {area:2268}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Maître de vol de {area:3197}",

	-- Step 39: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Allez au nord-ouest jusqu'à {area:2276}, en bordure de {area:2277}.",

	-- Step 40: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "Le crâne d'Horgus se trouve à {area:2624} et l'épée de Marduk dans {area:2623}, chacun là où des fantômes se battent ; des Chiens pestiférés adultes chassent dans les plaines entre les deux.",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "{item:12956} ; sous l'eau",

	-- Step 41: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423} : tuez-les au passage",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Chevauchez vers l'ouest jusqu'à {area:2627}. Chiens pestiférés chétifs ({npc:8596}), Chauves-souris pestiférées ({npc:8600}) et Larves putrides ({npc:8603}) parcourent ses bois ; remplissez {item:15042} aux grandes termitières et tuez les Chiens pestiférés frénétiques ({npc:8598}) plus au nord.",

	-- Step 42: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Chevauchez vers le nord jusqu'à {area:2627}. {npc:12384} vit dans la cabane en ruine, et son livre de reçus est dans l'auberge en ruine voisine.",

	-- Step 43: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277} : tuez-les au passage",

	-- Step 45: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Traversez la rivière vers l'ouest jusqu'à la cabane de {npc:1855}.",

	-- Step 47: Tirion Fordring
	["Listen to his story"] = "Écouter son histoire",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} est un élite : mieux vaut être en groupe",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} se trouve dans l'hôtel de ville de {area:190}, à l'ouest de {npc:1855} : les gardes écarlates sont très rapprochés.",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "{item:12954} ; à l'intérieur",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} se trouve à l'est de la grange de {area:201}.",

	-- Step 51: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Traversez la rivière vers l'est jusqu'au {area:2261}, la crypte au sud-ouest de la zone. {object:177667} est à l'intérieur : sa clé est sur {npc:12248}, tout au nord-est, à faire dans le guide suivant.",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "{object:177667}, sous terre",

	-- Step 53: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Prendre un vol pour {area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Maître de vol de {area:348}",

	-- Step 55: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Prendre un vol pour {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Maître de vol d'{area:442}",

	-- Step 56: Rut'theran Village
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "Ranshalla au {zone:1452} : gardez-la",

	-- Step 58: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} et {npc:7740} se tiennent près du temple de la Lune ; remplissez {item:11682} au puits de lune à l'intérieur.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740} : gardez-la pour {area:976}",

	-- Step 59: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["The portal in {area:702} leads up to {zone:1457}."] = "Le portail du {area:702} mène à {zone:1457}.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, dans {area:1658}",

	-- Step 63: Darnassus
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, où le guide suivant passe chez les maîtres, n'a pas de maître druide",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Dix {item:11040} tirées de la {item:11020}",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} à {zone:1450} : gardez-la",

	-- Step 64: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portail vers {zone:1438}",

	-- Step 65: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Maître de vol du {area:702}",

	-- Step 66: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Depuis {area:702}, volez jusqu'à {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900} : gardez-la pour {zone:1446}",

	-- Step 68: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "Bateau pour {area:1108}",

	-- Step 69: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Prenez le bateau pour le continent et allez au nord-est jusqu'au camp de {npc:14637}, près de {area:1119}.",

	-- Step 70: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108} : tuez-les au passage",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Les géants rétrécis errent autour de {area:1119} ; les élémentaires des mers longent la côte à l'ouest.",

	-- Step 72: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "Le camp de {npc:7775} est au nord de {area:1119}. Il vend l'{item:11243} une fois qu'il a son appât.",

	-- Step 73: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "",

	-- Step 74: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride north into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "",

	-- Step 75: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "",

	-- Step 77: Fly to Theramore
	["Fly to Theramore"] = "Volez jusqu'à Theramore",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "Maître de vol de {area:489}",

	-- Step 79: Ratchet
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}, sur la côte au nord de la ville",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Pour {zone:1448} : gardez-la",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496} : gardez-la pour Un'Goro ; à l'intérieur",

	-- Step 80: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Prendre un vol pour {area:2255}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Maître de vol de {area:392}",

	-- Step 82: Donova Snowden
	["Ride west along the road to the hot springs."] = "Suivez la route vers l'ouest jusqu'aux sources chaudes.",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "{npc:9299} à {area:976} : gardez-la",

	-- Step 84: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Entrez dans {area:1769} et prenez la branche du tunnel vers {zone:1450} jusqu'à {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Pour {zone:1451} : gardez-la",

	-- Step 85: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Prendre un vol pour {area:976}",

	-- Step 86: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, à l'intérieur",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "Sur {npc:7583}",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "Pour {area:3197} : gardez-la",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "",

	-- Step 87: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} attend au cimetière juste à l'est de la ville ; la pierre tombale se trouve à proximité.",

	-- Step 88: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Chevauchez vers le sud-ouest jusqu'au camp de {npc:7771}, à {area:1938}.",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444} se trouve à {area:392}",

	-- Step 90: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Prendre un vol pour {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Maître de vol de {area:976}",

	-- Step 91: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, sous terre",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "Le panneau en bois à côté de {npc:9997}",

	-- Step 92: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "Vers {zone:1451}",

	-- Step 93: Layo Starstrike
	-- {zone:1451} Silithus · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "",

	-- Step 95: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082}, aux tentes de l'Alliance",

	-- Step 96: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451} : tuez-les au passage",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Les Frappeurs térébrants creusent les dunes au nord-ouest du fort ; les Scorpides Cinglepierre et les Glisseuses du sable rôdent tout autour.",

	-- Step 97: Level 56.89
	["Level 56.89"] = "Niveau 56.89",
	-- {item:9328} Super Snapper FX · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "tuez en boucle : {npc:11740}",

	-- Step 98: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "",

	-- Step 99: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Les Écraseurs térébrants creusent plus à l'ouest ; les Pinceurs Cinglepierre, Écorcheurs Cinglepierre et Traqueuses des rochers chassent sur les mêmes sables.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741} se promène par ici : cherchez dans le cercle sur la carte",

	-- Step 100: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Les Druides torturés et les Sentinelles torturées hantent le village en ruine au sud-ouest de {npc:13220}.",

	-- Step 102: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "La tour de {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Chevauchez vers l'est jusqu'à la tour de {area:2742} à {area:2738} ; gravissez-la et tuez les embusqués qui surgissent pour l'objet incrusté.",

	-- Step 103: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Umber à {zone:1450} : gardez-la",

	-- Step 105: Krakle
	-- {zone:1451} Silithus · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "",

	-- Step 106: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449} : tuez-les au passage",

	-- Step 107: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Chevauchez vers l'est jusqu'à {area:537}, gravissez-la et utilisez {npc:10541} sur les évents de lave près du sommet.",

	-- Step 108: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Se termine auprès de {npc:9298} au {zone:1452} : gardez-la",

	-- Step 109: Northern Pylon
	["Northern Pylon"] = "Le Pylône nord",

	-- Step 111: The crater
	["The crater"] = "Le cratère",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Les Bêtes du goudron se vautrent dans les {area:538} ; les élémentaires de feu de la {area:537}, au centre, portent la cendre ; les guêpes Gorishi de la {area:540}, au sud, portent la glande. Toutes les créatures du cratère peuvent laisser tomber de la {item:11018}.\nAttention : les Ouvriers Gorishi qui passent sous 45 % de vie ont 50 % de chances d'appeler à l'aide leurs alliés à moins de 25 m.",

	-- Step 112: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "",

	-- Step 113: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538} : tuez-les au passage",
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Les gorilles vivent sur le {area:1943}, à l'est de {area:541}. Gardez leurs peaux pour {npc:9619}. Évitez la grotte la plus profonde : {npc:9622} est de niveau 55.\nAttention : les Gorilles d'Un'Goro (niveau 50-51) appellent à l'aide leurs alliés à moins de 20 m dès qu'ils tombent à 25 % de vie. Il y a dans la zone une grotte pleine de singes, et y combattre attire beaucoup de renforts.",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478} ; sous terre",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479} ; sous terre",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480} ; sous terre",

	-- Step 115: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Chevauchez vers le nord par le côté est jusqu'au plateau des gorilles. {npc:9622}, un gorille de niveau 55, se tient dans sa grotte la plus profonde : éliminez d'abord les gorilles de l'entrée.",
	["Below ground"] = "Sous terre",

	-- Step 116: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "Le repaire de {npc:9684} se trouve dans la jungle au nord de {npc:9619}, sous les falaises est : utilisez-y la {item:11568}. {npc:9684} est de niveau 56 : commencez avec toute votre vie.",

	-- Step 117: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Traversez le sud du cratère jusqu'à {npc:9619}, près de la rampe.",

	-- Step 118: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942} : tuez-les au passage",

	-- Step 119: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} est assis sur la pente sud-est de {area:537}, au milieu du cratère.",

	-- Step 120: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escorter {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Menez {npc:9999} vers le nord jusqu'à {area:541}. Quand il s'évanouit, utilisez la {item:11804} sur lui pour le réveiller.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "Montres d'Andorhal",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Retournez au nord à {area:202} : le chaudron propose maintenant sa propre tâche. Les goules alentour lâchent des Intensificateurs somatiques.",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Achetez un {item:13320} à {npc:11056} pour le chaudron de Felstone, juste avant de partir : les catalyseurs disparaissent au bout de 30 minutes.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Achetez deux autres Catalyseurs des arcanes pour les chaudrons de {area:202} et des Dalson, et allez-y directement : ils disparaissent au bout de 30 minutes.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Montez sur la colline à l'ouest de {area:190} pour observer la ville.",
	-- ["Collie is up the hill behind it."] = "Collie est en haut de la colline derrière.",
	-- ["Diseased Wolves"] = "Loups malades",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Se termine auprès de {npc:9298} au {area:618} : gardez-la",
	-- ["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; J.D.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "Prenez un vol de {area:976} pour {area:541}. La hutte de {npc:8737} se trouve aux {area:538}, à l'ouest du refuge ; J.D.\nL'ami de {npc:9997}, {npc:9999}, a disparu.",
	-- ["Fly to {area:392}."] = "Volez jusqu'à {area:392}.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Suivez la route vers le sud-ouest à la sortie du col jusqu'à {area:3425}.",
	-- ["For {area:1377}: keep it"] = "Pour {area:1377} : gardez-la",
	-- ["For {zone:1453}: keep it"] = "Pour {zone:1453} : gardez-la",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Depuis {area:392}, volez jusqu'à {area:2255} puis allez au sud jusqu'à {area:2250}.",
	-- ["Gaeriyan in {area:976}: keep it"] = "Gaeriyan à {area:976} : gardez-la",
	-- ["Hearth to {area:392}"] = "Pierre de foyer vers {area:392}",
	-- ["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan."] = "Si vous avez sauté la quête du {item:9328}, tuez des monstres ici jusqu'au niveau 56.89 pour rester dans le plan de la route.",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Retournez à {area:3197} et volez jusqu'à {area:150}, prenez le bateau pour {area:442} et volez jusqu'à {area:702} ; le portail mène à {zone:1457}.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Descendez la rampe dans le cratère : {npc:9619} campe à son pied.",
	-- ["Ride east to {npc:13220}."] = "Chevauchez vers l'est jusqu'à {npc:13220}.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby.\n{npc:11140} stands by {npc:12384}' hut in {area:2627}."] = "Chevauchez vers le nord jusqu'à {area:2627}. {npc:12384} vit dans la hutte en ruine, et son livre de reçus se trouve dans l'auberge en ruine voisine.\n{npc:11140} se tient près de la hutte de {npc:12384}, à {area:2627}.",
	-- ["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}."] = "Sortez du cratère par le col nord-ouest jusqu'en {area:1377}, puis continuez jusqu'à {area:3425}.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Chevauchez vers l'ouest après {area:541}, puis vers le sud par le côté ouest jusqu'à {area:543} : {npc:10302}, le gobelin, est assis au bord de l'eau.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Les Écorcheurs squelettes et les Goules écumantes errent dans les champs au nord du camp ; tous les membres du Fléau ici lâchent des Pierres du Fléau.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "De petits coffrets jonchent les décombres dans tout Andorhal ; chacun contient une montre.",
	-- ["Temple of the Moon"] = "Temple de la Lune",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Le chaudron propose maintenant sa propre tâche ; les squelettes alentour lâchent des Agitateurs osseux.",
	-- ["The fields"] = "Les champs",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "Le guide suivant commence ici à {area:392} et continue en vol jusqu'à {area:976}.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "Les peaux viennent après la boucle 2, sur le plateau des gorilles",
	-- ["Umber in {area:493}: keep it"] = "Umber à {area:493} : gardez-la",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Entrez dans {area:1769} et prenez la branche du tunnel vers {area:493} jusqu'à {area:2361}.",
	-- ["Zapped giants and sea elementals"] = "Géants rétrécis et élémentaires des mers",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "tuez des {npc:1796} à {area:202}, {zone:1422}",
	-- ["{area:1377}: kill these as you meet them"] = "{area:1377} : tuez-les au passage",
	-- ["{area:139}: kill these as you meet them"] = "{area:139} : tuez-les au passage",
	-- ["{area:199} cauldron"] = "Chaudron de {area:199}",
	-- ["{item:11834} on the way"] = "{item:11834} en chemin",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}, auprès de {npc:11056}",
	-- ["{item:13853} on the way"] = "{item:13853} en chemin",
	-- ["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} à {zone:1452} : gardez-la",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300} : son escorte viendra plus tard sur l'itinéraire",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} se tient près de la ferme de {area:202}, au nord-est des champs.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "Le fantôme de {npc:10778} erre près de la ferme de {area:199}, à l'ouest de {area:200} ; son colis est à l'intérieur.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, près des tombes au sud de la chapelle",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} garde le chaudron de {area:199}, à l'ouest d'Andorhal.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} se tient près de la cabane d'Augustus à {area:2627}.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} arpente le camp de la Crête du nord, à l'est de {npc:11610} ; {npc:11611} garde la tour sur l'accès sud de {area:190}.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616} : les termites viendront plus tard, à {area:2627}",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256} : le guide précédent vous lie ici, cette étape se coche donc généralement aussitôt",
	-- ["{npc:1833} along the way to {npc:11610}"] = "{npc:1833} sur le chemin de {npc:11610}",
	-- ["{npc:1833} on the way"] = "{npc:1833} en chemin",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} est un élite : mieux vaut être en groupe. Il garde son phylactère au centre d'Andorhal.",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900} : gardez-la pour {area:440}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496} : gardez-la pour le Cratère d'Un'Goro",
	-- ["{npc:8598} on the way"] = "{npc:8598} en chemin",
	-- ["{object:175894}, inside"] = "{object:175894}, à l'intérieur",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}, dans la ferme",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} à {area:493} : gardez-la",
}
