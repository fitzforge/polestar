-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Light's Hope Chapel
	-- {npc:16256} Jessica Chambers
	["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",

	-- Step 2: Chillwind Camp
	-- {npc:11616} Nathaniel Dumah · {area:2627} Terrordale
	["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: os cupins vêm depois, em {area:2627}",

	-- Step 3: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "A casa de fazenda de {npc:10927} fica na colina a leste do acampamento; o monumento de {npc:10936} fica logo ao norte dela.",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, no monumento",

	-- Step 4: The fields
	["The fields"] = "Os campos",
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Esfoladores Descarnados e Carniçais Salivantes vagam pelos campos ao norte do acampamento; todo o Flagelo daqui deixa cair Pedras do Flagelo.",

	-- Step 5: Mulgris Deepriver
	-- {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} fica junto à fazenda em {area:202}, a nordeste dos campos.",

	-- Step 6: Diseased Wolves
	["Diseased Wolves"] = "Lobos Doentes",

	-- Step 8: Diseased Grizzlies
	["Diseased Grizzlies"] = "Ursos-cinzentos Doentes",

	-- Step 9: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Para os druidas de {zone:1457}: guarde",

	-- Step 10: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Cavalgue para o noroeste até a fazenda dos Dalson. O diário está no celeiro; um esqueleto errante carrega a chave da casinha, e {npc:10836} espera na casinha com a chave do armário.",
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse"] = "{object:175924}, na casa da fazenda",

	-- Step 11: Janice Felstone
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field · {area:200} Dalson's Tears
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "O fantasma de {npc:10778} vaga junto à casa da fazenda de {area:199}, a oeste de {area:200}; o embrulho dela está lá dentro.",
	-- {zone:1453} Stormwind
	["For {zone:1453}: keep it"] = "Para {zone:1453}: guarde",

	-- Step 12: Chillwind Camp
	["Ride back south to the camp."] = "Cavalgue de volta para o sul até o acampamento.",

	-- Step 13: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "As torres de vigia de Andorhal",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Use a {item:12815} ao pé de cada uma das quatro torres de vigia na periferia de Andorhal, ao norte do acampamento.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marque a {npc:10902} com a {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marque a {npc:10903} com a {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marque a {npc:10904} com a {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marque a {npc:10905} com a {item:12815}",

	-- Step 14: Felstone Field cauldron
	-- {area:199} Felstone Field
	["{area:199} cauldron"] = "Caldeirão de {area:199}",
	-- {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field
	["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} guarda o caldeirão em {area:199}, a oeste de Andorhal.",

	-- Step 15: Chillwind Camp
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Compre um {item:13320} de {npc:11056} para o caldeirão do Campo Pedravil, logo antes de ir: os aceleradores somem após 30 minutos.",
	-- {item:13320} Arcane Quickener · {npc:11056} Alchemist Arbington
	["{item:13320}, from {npc:11056}"] = "{item:13320}, de {npc:11056}",

	-- Step 16: Felstone Field cauldron
	-- plural, as words: Osseous Agitators = {item:13357} Osseous Agitator
	["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "O caldeirão agora oferece a própria tarefa; os esqueletos ao redor deixam cair Agitadores Ósseos.",

	-- Step 17: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Caldeirão de {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "O caldeirão fica em {area:200}, a nordeste do Campo Pedravil; o Mestre da Caldeira dele fica ao lado.",

	-- Step 19: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	["{area:202} cauldron"] = "Caldeirão de {area:202}",
	-- {area:202} Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "O caldeirão fica em {area:202}, junto à fazenda de {npc:10739}.",
	-- {npc:1796} Freezing Ghoul · {area:202} Writhing Haunt · {zone:1422} Western Plaguelands
	["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "mate {npc:1796} em {area:202}, {zone:1422}",

	-- Step 20: Chillwind Camp
	-- {area:202} Writhing Haunt
	-- plural, as words: Arcane Quickeners = {item:13320} Arcane Quickener
	["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Compre mais dois Aceleradores Arcanos para os caldeirões de {area:202} e das Lágrimas de Dalson, e vá direto para lá: eles somem após 30 minutos.",
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} é elite de nível 61",

	-- Step 21: Writhing Haunt cauldron
	-- {area:202} Writhing Haunt
	-- plural, as words: Somatic Intensifiers = {item:13356} Somatic Intensifier
	["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Volte para o norte até {area:202}: o caldeirão agora oferece a própria tarefa. Os carniçais por perto deixam cair Intensificadores Somáticos.",

	-- Step 23: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} espera na estalagem em ruínas no lado oeste de Andorhal.",

	-- Step 24: Andorhal
	["Andorhal"] = "Andorhal",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Use o {item:12627} junto aos silos de grãos para atrair Parasitas Temporais. {quest:5154} é um dos Tomos Mofados na prefeitura. Todo esqueleto da cidade deixa cair {quest:5537}.",

	-- Step 25: Araj's Phylactery
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} é elite: recomenda-se ir em grupo. Ele guarda o filactério no meio de Andorhal.",

	-- Step 26: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, em {area:2268}: guarde",

	-- Step 27: Andorhal Watches
	["Andorhal Watches"] = "Relógios de Andorhal",
	["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Pequenos cofres estão nos escombros por toda Andorhal; cada um guarda um relógio.",

	-- Step 29: More watches
	["More watches"] = "Mais relógios",

	-- Step 31: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Cavalgue para o norte pela estrada até a Madeireira Beiranorte; {npc:11610} se esconde na borda do acampamento.",

	-- Step 32: The Scarlet Crusade
	["The Scarlet Crusade"] = "A Cruzada Escarlate",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Socorristas Escarlates, Caçadores Escarlates, Cavaleiros Escarlates e Magos Escarlates patrulham a madeireira e a estrada rumo a {area:190}.",

	-- Step 34: Radley and Durgen
	["Radley and Durgen"] = "Eiras e Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} anda pela Madeireira Beiranorte a leste de {npc:11610}; {npc:11611} guarda a torre na entrada sul de {area:190}.",

	-- Step 36: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Mirante de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town."] = "Suba a colina a oeste de {area:190} para observar a cidade lá de cima.",

	-- Step 38: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Cavalgue para o leste até o rio da fronteira: {npc:1855} mora numa pequena cabana na margem.",

	-- Step 39: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Caldeirão de {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Cavalgue para o sul até {area:201}, onde {npc:11078} guarda o caldeirão.",

	-- Step 40: Chillwind Camp
	["Ride south-west to the camp."] = "Cavalgue para o sudoeste até o acampamento.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} em {area:976}: guarde",

	-- Step 41: Light's Hope Chapel
	-- {npc:11038} Caretaker Alen
	["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, junto aos túmulos ao sul da capela",

	-- Step 42: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "O Crânio de Horgus está em {area:2624} e a espada de Marduque em {area:2623}, ambos onde fantasmas lutam; Cães Pestilentos adultos caçam nas planícies entre eles.",

	-- Step 44: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Cavalgue para o noroeste até {area:2276}, na borda de {area:2277}.",

	-- Step 45: Terrordale
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Cavalgue para o oeste até {area:2627}. Cães Pestilentos Miúdos, Quirópragos e Vermes Carniceiros vagam pelos bosques; encha a {item:15042} nos grandes cupinzeiros e mate os Cães Pestilentos Frenéticos mais ao norte.",

	-- Step 46: Egan
	-- {npc:11140} Egan · {area:2627} Terrordale
	["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} fica junto à cabana de Augustus em {area:2627}.",

	-- Step 47: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Atravesse o rio para o oeste até a cabana de {npc:1855}.",
	["Listen to his story"] = "Ouça a história dele",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} é elite: recomenda-se ir em grupo",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} está na prefeitura de {area:190}, a oeste de {npc:1855}: os guardas escarlates ficam bem juntos.",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} está a leste do celeiro em {area:201}.",

	-- Step 50: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Atravesse o rio para o leste até a {area:2261}, a cripta no sudoeste da zona. O {object:177667} está lá dentro: a chave está com {npc:12248}, no extremo nordeste, no próximo guia.",

	-- Step 51: Darnassus
	-- {area:3197} Chillwind Camp · {area:150} Menethil Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {zone:1457} Darnassus
	["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Volte para {area:3197} e voe para {area:150}, pegue o barco para {area:442} e voe para {area:702}; o portal leva até {zone:1457}.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, em {area:1658}",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Dez {item:11040} da {item:11020}",
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, onde o próximo guia treina, não tem instrutor de druida",

	-- Step 52: Temple of the Moon
	["Temple of the Moon"] = "Templo da Lua",
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} e {npc:7740} ficam junto ao Templo da Lua; encha o {item:11682} no poço lunar lá dentro.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: guarde para {area:976}",

	-- Step 53: Cenarion Enclave
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} em {zone:1450}: guarde",

	-- Step 54: Rut'theran Village
	-- {npc:10300} Ranshalla · {zone:1452} Winterspring
	["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} em {zone:1452}: guarde",

	-- Step 55: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "De {area:702}, voe para {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: guarde para {zone:1446}",

	-- Step 56: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Pegue o barco para o continente e cavalgue para o nordeste até o acampamento de {npc:14637}, junto a {area:1119}.",

	-- Step 57: Zapped giants and sea elementals
	["Zapped giants and sea elementals"] = "Gigantes irradiados e Elementais do Mar",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Os gigantes encolhidos vagam por {area:1119}; os Elementais do Mar andam pela costa a oeste.",

	-- Step 59: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "O acampamento de {npc:7775} fica ao norte de {area:1119}. Ele vende o {item:11243} quando recebe a isca.",

	-- Step 60: Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}."] = "Voe para {area:392}.",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: guarde para a Cratera Un'Goro",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}, na costa ao norte da cidade",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Para {zone:1448}: guarde",

	-- Step 61: Ranshalla
	-- {area:392} Ratchet · {area:2255} Everlook · {area:2250} Owl Wing Thicket
	["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "De {area:392}, voe para {area:2255} e cavalgue para o sul até {area:2250}.",
	-- {npc:10300} Ranshalla
	["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: a escolta dela vem mais tarde na rota",

	-- Step 62: Donova Snowden
	["Ride west along the road to the hot springs."] = "Cavalgue para o oeste pela estrada até as fontes termais.",
	-- {area:976} Gadgetzan
	["Gaeriyan in {area:976}: keep it"] = "Gaeriyan em {area:976}: guarde",

	-- Step 63: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Entre em {area:1769} e pegue o ramo do túnel para {zone:1450} até {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Para {zone:1451}: guarde",

	-- Step 64: Ratchet
	-- {area:392} Ratchet · {area:976} Gadgetzan
	["The next guide starts here in {area:392} and flies on to {area:976}."] = "O próximo guia começa aqui em {area:392} e voa para {area:976}.",
}
