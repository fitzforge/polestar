-- Spanish (Spain) (esES): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Chillwind Camp
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: las termitas vienen más tarde, en {area:2627}",

	-- Step 2: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "La granja de {npc:10927} está en la colina al este del campamento; el monumento de {npc:10936} está justo al norte.",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, en el monumento",

	-- Step 3: The fields
	["The fields"] = "Los campos",
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Los despellejadores esqueléticos y los necrófagos esclavizantes rondan los campos al norte del campamento; toda la Plaga de aquí suelta piedras de la Plaga.",

	-- Step 4: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} está junto a la granja de {area:202}, al noreste de los campos.",

	-- Step 5: Diseased Wolves
	["Diseased Wolves"] = "Lobos malsanos",

	-- Step 7: Diseased Grizzlies
	["Diseased Grizzlies"] = "Griseznos malsanos",

	-- Step 8: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Para los druidas de {zone:1457}: guárdala",

	-- Step 9: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Cabalga al noroeste hasta la granja de Dalson. El diario está en el granero; un esqueleto errante lleva la llave del retrete, y {npc:10836} espera en el retrete con la llave del armario.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse"] = "{object:175924}, en la casa de la granja",

	-- Step 10: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "El fantasma de {npc:10778} vaga junto a la casa de {area:199}, al oeste de {area:200}; su paquete está dentro.",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Para {zone:1453}: guárdala",

	-- Step 11: Chillwind Camp
	["Ride back south to the camp."] = "Vuelve al sur hasta el campamento.",

	-- Step 12: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "Las atalayas de Andorhal",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Usa la {item:12815} al pie de cada una de las cuatro atalayas del borde de Andorhal, al norte del campamento.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marca la {npc:10902} con la {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marca la {npc:10903} con la {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marca la {npc:10904} con la {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marca la {npc:10905} con la {item:12815}",

	-- Step 13: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Caldera de {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} protege la caldera de {area:199}, al oeste de Andorhal.",

	-- Step 14: Chillwind Camp
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Compra un {item:13320} a {npc:11056} para la caldera de Piedramácula justo antes de ir: los aceleradores desaparecen a los 30 minutos.",
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["{item:13320}, from {npc:11056}"] = "{item:13320}, de {npc:11056}",

	-- Step 15: Felstone Field cauldron
	-- plural, as words: Osseous Agitators = {item:13357} Osseous Agitator
	["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "Ahora la caldera ofrece su propia tarea; los esqueletos de alrededor sueltan agitadores óseos.",

	-- Step 16: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Caldera de {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "La caldera está en {area:200}, al noreste de Piedramácula; su señor de la caldera está a su lado.",

	-- Step 18: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Caldera de {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "La caldera está en {area:202}, junto a la granja de {npc:10739}.",
	-- {npc:1796} Freezing Ghoul · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands
	["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "mata a {npc:1796} en {area:202}, {zone:1422}",

	-- Step 19: Chillwind Camp
	-- {area:202} Writhing Haunt
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Compra dos aceleradores arcanos más para las calderas de {area:202} y de Dalson, y ve directo: desaparecen a los 30 minutos.",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} es élite de nivel 61",

	-- Step 20: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	-- plural, as words: Somatic Intensifiers = {item:13356} Somatic Intensifier
	["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Vuelve al norte a {area:202}: ahora la caldera ofrece su propia tarea. Los necrófagos cercanos sueltan intensificadores somáticos.",

	-- Step 22: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} espera en la posada en ruinas del lado oeste de Andorhal.",

	-- Step 23: Andorhal
	["Andorhal"] = "Andorhal",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Usa el {item:12627} junto a los silos de grano para hacer salir parásitos temporales. {quest:5154} es uno de los tomos mohosos del ayuntamiento. Todos los esqueletos del pueblo sueltan {quest:5537}.",

	-- Step 24: Araj's Phylactery
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} es élite: conviene ir en grupo. Protege su filacteria en el centro de Andorhal.",

	-- Step 25: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, en {area:2268}: guárdala",

	-- Step 26: Andorhal Watches
	["Andorhal Watches"] = "Relojes de Andorhal",
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Hay pequeñas cajas fuertes entre los escombros de todo Andorhal; cada una tiene un reloj.",

	-- Step 28: More watches
	["More watches"] = "Más relojes",

	-- Step 30: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Cabalga al norte por el camino hasta el Aserradero Crestanorte; {npc:11610} se esconde en el borde del campamento.",

	-- Step 31: The Scarlet Crusade
	["The Scarlet Crusade"] = "La Cruzada Escarlata",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Los médicos, cazadores, caballeros y magos escarlata patrullan el aserradero y el camino hacia {area:190}.",

	-- Step 33: Radley and Durgen
	["Radley and Durgen"] = "Radley y Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} recorre el aserradero Crestanorte al este de {npc:11610}; {npc:11611} protege la torre del acceso sur de {area:190}.",

	-- Step 35: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Mirador de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town."] = "Sube a la colina al oeste de {area:190} para ver el pueblo desde arriba.",

	-- Step 37: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Cabalga al este hasta el río de la frontera: {npc:1855} vive en una cabaña pequeña en la orilla.",

	-- Step 38: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Caldera de {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Cabalga al sur hasta {area:201}, donde {npc:11078} protege la caldera.",

	-- Step 39: Chillwind Camp
	["Ride south-west to the camp."] = "Cabalga al suroeste hasta el campamento.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} en {area:976}: guárdala",

	-- Step 40: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, junto a las tumbas al sur de la capilla",

	-- Step 41: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "El cráneo de Horgus está en {area:2624} y la espada de Marduk en {area:2623}, cada uno donde luchan fantasmas; los canes de la Peste adultos cazan en las llanuras de en medio.",

	-- Step 43: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Cabalga al noroeste hasta {area:2276}, en el borde de {area:2277}.",

	-- Step 44: Terrordale
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Cabalga al oeste hasta {area:2627}. Los cachorros de can de la Peste ({npc:8596}), los murcipestes ({npc:8600}) y las larvas carroñeras ({npc:8603}) rondan sus bosques; llena la {item:15042} en los grandes termiteros y mata a los canes de la Peste demenciados ({npc:8598}) más al norte.",

	-- Step 45: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} está junto a la cabaña de Augustus en {area:2627}.",

	-- Step 46: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Cruza el río hacia el oeste hasta la cabaña de {npc:1855}.",
	["Listen to his story"] = "Escucha su historia",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} es élite: conviene ir en grupo",

	-- Step 47: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "El {item:12954} está en el ayuntamiento de {area:190}, al oeste de {npc:1855}: los guardias escarlata están muy juntos.",

	-- Step 48: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "El {item:12955} está al este del granero de {area:201}.",

	-- Step 49: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Cruza el río hacia el este hasta {area:2261}, la cripta del suroeste de la zona. El {object:177667} está dentro: la llave la lleva {npc:12248}, en el extremo noreste, que se hace en la siguiente guía.",

	-- Step 50: Darnassus
	-- {area:3197} Chillwind Camp · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Vuelve a {area:3197} y vuela a {area:150}, toma el barco a {area:442} y vuela a {area:702}; el portal sube a {zone:1457}.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, en {area:1658}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Diez {item:11040} de la {item:11020}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, donde se entrena en la siguiente guía, no tiene instructor de druidas",

	-- Step 51: Temple of the Moon
	["Temple of the Moon"] = "Templo de la Luna",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} y {npc:7740} están junto al Templo de la Luna; llena el {item:11682} en el pozo de la luna de dentro.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: guárdala para {area:976}",

	-- Step 52: Cenarion Enclave
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} en {zone:1450}: guárdala",

	-- Step 53: Rut'theran Village
	-- {npc:10300} Ranshalla · {zone:1452} Winterspring
	["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} en {zone:1452}: guárdala",

	-- Step 54: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "Desde {area:702}, vuela a {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: guárdala para {zone:1446}",

	-- Step 55: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Toma el barco al continente y cabalga al noreste hasta el campamento de {npc:14637} junto a {area:1119}.",

	-- Step 56: Zapped giants and sea elementals
	["Zapped giants and sea elementals"] = "Gigantes machacados y elementales marinos",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Los gigantes encogidos rondan {area:1119}; los elementales marinos vadean la costa al oeste.",

	-- Step 58: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "El campamento de {npc:7775} está al norte de {area:1119}. Vende el {item:11243} cuando tiene su cebo.",

	-- Step 59: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "Vuela a {area:392}.",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: guárdala para Un'Goro",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}, en la costa al norte del pueblo",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Para {zone:1448}: guárdala",

	-- Step 60: Ranshalla
	-- {area:392} Ratchet · {area:2255} Everlook · {area:2250} Owl Wing Thicket
	["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "Desde {area:392}, vuela a {area:2255} y cabalga al sur hasta {area:2250}.",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: su escolta llega más adelante en la ruta",

	-- Step 61: Donova Snowden
	["Ride west along the road to the hot springs."] = "Cabalga al oeste por el camino hasta las fuentes termales.",
	-- {area:976} Gadgetzan
	["Gaeriyan in {area:976}: keep it"] = "Gaeriyan en {area:976}: guárdala",

	-- Step 62: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Entra en {area:1769} y toma el ramal del túnel de {zone:1450} hasta {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Para {zone:1451}: guárdala",

	-- Step 63: Ratchet
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["The next guide starts here in {area:392} and flies on to {area:976}."] = "La siguiente guía empieza aquí, en {area:392}, y vuela a {area:976}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Cruza el río hacia el este hasta {area:2261}, la cripta del suroeste de la zona. El {object:177667} está dentro: la llave la lleva {npc:12248}, en el extremo noreste, que se hace en la siguiente guía.",
}
