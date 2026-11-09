-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/04-western-plaguelands (forever/alliance/50-60/04-western-plaguelands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Argent Officer Pureheart
	-- {quest:5401} Argent Dawn Commission · {spell:437801} Light's Hope · {zone:1452} Winterspring
	["No {quest:5401} yet ({spell:437801} gives it on the {zone:1452} guide's way through)? Pureheart gives you one here: the scourgestone quests need it."] = "Ainda sem {quest:5401} ({spell:437801} dá uma na passagem do guia de {zone:1452})? Cândida dá uma a você aqui: as missões da Pedra do Flagelo precisam disso.",

	-- Step 4: Sorrow Hill: kill these as you meet them
	-- {area:197} Sorrow Hill
	["{area:197}: kill these as you meet them"] = "{area:197}: vá matando estes pelo caminho",
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul · Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones.\nCareful: These undead notice you from far away, and other undead nearby join the fight when one is pulled.\nCareful: The {npc:10411} (3 spawns, 15 min respawn) turns invisible when out of combat and calls in Rockwing Gargoyles once a fight starts."] = "Esfoladores Descarnados e Carniçais Salivantes andam pelos campos ao norte do acampamento; todo o Flagelo daqui deixa cair Pedras do Flagelo.\nCuidado: esses mortos-vivos percebem você de longe, e outros por perto entram na briga quando um é puxado.\nCuidado: o {npc:10411} (3 no mapa, renascem em 15 min) fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa.",

	-- Step 5: Marlene Redpath
	-- {npc:10927} Marlene Redpath · {npc:10936} Joseph Redpath
	["{npc:10927}'s farmhouse stands on the hill east of the camp; {npc:10936}'s monument is just north of it."] = "A casa de fazenda de {npc:10927} fica na colina a leste do acampamento; o monumento de {npc:10936} fica logo ao norte dela.",
	["Upstairs"] = "No andar de cima",
	-- {item:12894} Joseph's Wedding Ring
	["{item:12894}, at the monument"] = "{item:12894}, no monumento",

	-- Step 6: Dalson's Tears
	-- {npc:10836} Farmer Dalson
	["Ride north-west to the Dalson farm. The diary lies in the barn; a wandering skeleton carries the outhouse key, and {npc:10836} waits in the outhouse with the cabinet key."] = "Cavalgue para o noroeste até a fazenda dos Dalson. O diário está no celeiro; um esqueleto errante carrega a chave da casinha, e {npc:10836} espera na casinha com a chave do armário.",
	-- {quest:5058} Mrs. Dalson's Diary
	["{quest:5058}, inside"] = "{quest:5058}, lá dentro",
	["Inside"] = "Lá dentro",

	-- Step 7: The Writhing Haunt: kill these as you meet them
	-- {area:202} The Writhing Haunt
	["{area:202}: kill these as you meet them"] = "{area:202}: vá matando estes pelo caminho",

	-- Step 8: Dalson's Tears
	-- {object:175924} Locked Cabinet
	["{object:175924}, in the farmhouse; inside"] = "{object:175924}, na casa da fazenda; lá dentro",

	-- Step 9: Chillwind Camp
	["Ride back south to the camp."] = "Cavalgue de volta para o sul até o acampamento.",

	-- Step 10: The Andorhal watchtowers
	["The Andorhal watchtowers"] = "As torres de vigia de Andorhal",
	-- {item:12815} Beacon Torch
	["Use the {item:12815} at the foot of each of the four watchtowers around the edge of Andorhal, north of the camp."] = "Use a {item:12815} ao pé de cada uma das quatro torres de vigia na periferia de Andorhal, ao norte do acampamento.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marque a {npc:10902} com a {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marque a {npc:10903} com a {item:12815}",

	-- Step 11: Chromie
	-- {npc:10667} Chromie
	["{npc:10667} waits in the ruined inn on the west side of Andorhal."] = "{npc:10667} espera na estalagem em ruínas no lado oeste de Andorhal.",

	-- Step 12: The Andorhal watchtowers
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marque a {npc:10904} com a {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marque a {npc:10905} com a {item:12815}",

	-- Step 13: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} é elite de nível 61",

	-- Step 14: Dalson's Tears cauldron
	-- {area:200} Dalson's Tears
	["{area:200} cauldron"] = "Caldeirão de {area:200}",
	-- {area:200} Dalson's Tears
	["The cauldron sits at {area:200}, north-east of Felstone; its Cauldron Lord stands beside it."] = "O caldeirão fica em {area:200}, a nordeste do Campo Pedravil; o Mestre da Caldeira dele fica ao lado.",

	-- Step 15: Andorhal
	["Andorhal"] = "Andorhal",
	-- {item:12627} Temporal Displacer · {quest:5154} The Annals of Darrowshire · {quest:5537} Skeletal Fragments
	-- plural, as words: Temporal Parasites = {npc:10717} Temporal Parasite
	["Use the {item:12627} by the grain silos to draw out Temporal Parasites. {quest:5154} is one of the musty tomes in the town hall. Every skeleton in town drops {quest:5537}."] = "Use o {item:12627} junto aos silos de grãos para atrair Parasitas Temporais. {quest:5154} é um dos Tomos Mofados na prefeitura. Todo esqueleto da cidade deixa cair {quest:5537}.",

	-- Step 17: The Writhing Haunt cauldron
	-- {area:202} The Writhing Haunt
	["{area:202} cauldron"] = "Caldeirão de {area:202}",
	-- {area:202} The Writhing Haunt · {npc:10739} Mulgris Deepriver
	["The cauldron sits at the {area:202}, by {npc:10739}' farm."] = "O caldeirão fica em {area:202}, junto à fazenda de {npc:10739}.",

	-- Step 19: Diseased Grizzlies
	["Diseased Grizzlies"] = "Ursos-cinzentos Doentes",

	-- Step 20: Mulgris Deepriver
	-- {zone:1457} Darnassus
	["For the druids of {zone:1457}: keep it"] = "Para os druidas de {zone:1457}: guarde",

	-- Step 22: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel
	["{quest:5210}, at {area:2268}: keep it"] = "{quest:5210}, em {area:2268}: guarde",

	-- Step 23: Sorrow Hill: kill these as you meet them
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal.\nSmall lockboxes lie in the rubble all over Andorhal; each holds a watch.\nCareful: Ghouls and skeletons usually stand next to the boxes and attack when you come close. Searing ghouls also hurt anyone nearby and will break stealth."] = "{npc:1852} é elite: melhor ir em grupo. Ele guarda a filactéria dele no meio de Andorhal.\nCaixinhas trancadas estão nos escombros por toda Andorhal; cada uma guarda um relógio.\nCuidado: carniçais e esqueletos costumam ficar ao lado das caixas e atacam quando você chega perto. Os Carniçais Ardentes também ferem quem estiver por perto e quebram a furtividade.",

	-- Step 25: More watches
	["More watches"] = "Mais relógios",

	-- Step 27: Kirsta Deepshadow
	-- {npc:11610} Kirsta Deepshadow
	["Ride north up the road to the Northridge lumber mill; {npc:11610} hides at the camp's edge."] = "Cavalgue para o norte pela estrada até a Madeireira Beiranorte; {npc:11610} se esconde na borda do acampamento.",

	-- Step 28: The Scarlet Crusade
	["The Scarlet Crusade"] = "A Cruzada Escarlate",
	-- {area:190} Hearthglen
	-- plural, as words: Scarlet Medics = {npc:10605} Scarlet Medic
	["The Scarlet Medics, Hunters, Knights and Mages patrol the lumber camp and the road toward {area:190}."] = "Socorristas Escarlates, Caçadores Escarlates, Cavaleiros Escarlates e Magos Escarlates patrulham a madeireira e a estrada rumo a {area:190}.",

	-- Step 30: Radley and Durgen
	["Radley and Durgen"] = "Eiras e Durgen",
	-- {npc:11613} Huntsman Radley · {npc:11610} Kirsta Deepshadow · {npc:11611} Cavalier Durgen · {area:190} Hearthglen
	["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach.\nCareful: Guards stand at the tower's base and one more circles it on patrol. Clear them before you engage Durgen so they don't join the fight."] = "{npc:11613} anda pelo acampamento de Beiranorte, a leste de {npc:11610}; {npc:11611} guarda a torre na entrada sul de {area:190}.\nCuidado: há guardas na base da torre e mais um patrulhando em volta dela. Limpe-os antes de encarar o Durgen, para eles não entrarem na briga.",

	-- Step 32: Hearthglen overlook
	-- {area:190} Hearthglen
	["{area:190} overlook"] = "Mirante de {area:190}",
	-- {area:190} Hearthglen
	["Climb the hill west of {area:190} to look down on the town.\nCareful: Sentinels posted at the gate can detect stealthed players. Additional sentinels are found within the town, and an elite walks a patrol route nearby."] = "Suba o morro a oeste de {area:190} para olhar a cidade lá de cima.\nCuidado: as sentinelas do portão detectam jogadores furtivos. Há mais sentinelas dentro da cidade, e um elite faz patrulha ali perto.",

	-- Step 34: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Ride east to the border river: {npc:1855} lives in a small hut on the bank."] = "Cavalgue para o leste até o rio da fronteira: {npc:1855} mora numa pequena cabana na margem.",

	-- Step 35: Gahrron's Withering cauldron
	-- {area:201} Gahrron's Withering
	["{area:201} cauldron"] = "Caldeirão de {area:201}",
	-- {area:201} Gahrron's Withering · {npc:11078} Cauldron Lord Soulwrath
	["Ride south to {area:201}, where {npc:11078} guards the cauldron."] = "Cavalgue para o sul até {area:201}, onde {npc:11078} guarda o caldeirão.",

	-- Step 36: Chillwind Camp
	["Ride south-west to the camp."] = "Cavalgue para o sudoeste até o acampamento.",
	-- {npc:5411} Krinkle Goodsteel · {area:976} Gadgetzan
	["{npc:5411} in {area:976}: keep it"] = "{npc:5411} em {area:976}: guarde",

	-- Step 37: Fly to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Fly to {area:2268}"] = "Voe para a {area:2268}",
	-- {area:3197} Chillwind Camp
	["{area:3197} flight master"] = "Mestre de voo de {area:3197}",

	-- Step 39: Aurora Skycaller
	-- {area:2276} Quel'Lithien Lodge · {area:2277} Plaguewood
	["Ride north-west to {area:2276}, at the edge of the {area:2277}."] = "Cavalgue para o noroeste até {area:2276}, na borda de {area:2277}.",

	-- Step 40: Villains of Darrowshire
	-- {area:2624} Blackwood Lake · {area:2623} Infectis Scar
	-- plural, as words: Plaguehounds = {npc:8597} Plaguehound
	["Horgus' skull lies at {area:2624} and Marduk's sword in the {area:2623}, each where ghosts fight; grown Plaguehounds hunt the plains between."] = "O Crânio de Horgus está em {area:2624} e a espada de Marduque em {area:2623}, ambos onde fantasmas lutam; Cães Pestilentos adultos caçam nas planícies entre eles.",
	-- {item:12956} Skull of Horgus
	["{item:12956}; underwater"] = "{item:12956}; debaixo d'água",

	-- Step 41: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: vá matando estes pelo caminho",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Plaguehound Runts = {npc:8596} Plaguehound Runt · Plaguebats = {npc:8600} Plaguebat · Carrion Grubs = {npc:8603} Carrion Grub · Frenzied Plaguehounds = {npc:8598} Frenzied Plaguehound
	["Ride west to {area:2627}. Plaguehound Runts, Plaguebats and Carrion Grubs roam its woods; fill the {item:15042} at the big termite mounds and kill the Frenzied Plaguehounds further north."] = "Cavalgue para o oeste até {area:2627}. Cães Pestilentos Miúdos, Quirópragos e Vermes Carniceiros vagam pelos bosques; encha a {item:15042} nos grandes cupinzeiros e mate os Cães Pestilentos Frenéticos mais ao norte.",

	-- Step 42: Augustus the Touched
	-- {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cavalgue para o norte até {area:2627}. {npc:12384} mora na cabana em ruínas, e o livro de recibos dele está na estalagem em ruínas ali perto.",

	-- Step 43: Augustus the Touched
	-- {npc:8598} Frenzied Plaguehound
	["{npc:8598}, 170 yd north-east"] = "{npc:8598}, 170 metros a nordeste",

	-- Step 44: Plaguewood: kill these as you meet them
	-- {area:2277} Plaguewood
	["{area:2277}: kill these as you meet them"] = "{area:2277}: vá matando estes pelo caminho",

	-- Step 45: Tirion Fordring
	-- {npc:1855} Tirion Fordring
	["Cross the river west to {npc:1855}'s hut."] = "Atravesse o rio para o oeste até a cabana de {npc:1855}.",

	-- Step 47: Tirion Fordring
	["Listen to his story"] = "Ouça a história dele",
	-- {npc:11886} Mercutio Filthgorger
	["{npc:11886} is elite: grouping up is advised"] = "{npc:11886} é elite: recomenda-se ir em grupo",

	-- Step 48: Davil's Libram
	-- {item:12954} Davil's Libram · {area:190} Hearthglen · {npc:1855} Tirion Fordring
	["{item:12954} lies in the town hall of {area:190}, west of {npc:1855}: the Scarlet guards stand close together."] = "{item:12954} está na prefeitura de {area:190}, a oeste de {npc:1855}: os guardas escarlates ficam bem juntos.",
	-- {item:12954} Davil's Libram
	["{item:12954}; inside"] = "{item:12954}; lá dentro",

	-- Step 49: Redpath's Shield
	-- {item:12955} Redpath's Shield · {area:201} Gahrron's Withering
	["{item:12955} lies east of the barn at {area:201}."] = "{item:12955} está a leste do celeiro em {area:201}.",

	-- Step 51: The Undercroft
	-- {area:2261} The Undercroft · {object:177667} Torn Scroll · {npc:12248} Infiltrator Hameya
	["Cross the river east to the {area:2261}, the crypt in the south-west of the zone. The {object:177667} lies inside: its key is on {npc:12248} in the far north-east, done in the next guide."] = "Atravesse o rio para o leste até a {area:2261}, a cripta no sudoeste da zona. O {object:177667} está lá dentro: a chave está com {npc:12248}, no extremo nordeste, no próximo guia.",
	-- {object:177667} Torn Scroll
	["{object:177667}, below ground"] = "{object:177667}, no subterrâneo",

	-- Step 53: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Voar para {area:271}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Mestre de voo de {area:348}",

	-- Step 55: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Voe para {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Mestre de voo de {area:442}",

	-- Step 56: Rut'theran Village
	-- {zone:1452} Winterspring
	["Ranshalla in {zone:1452}: keep it"] = "Ranshalla em {zone:1452}: guarde",

	-- Step 58: The Temple Gardens
	-- {npc:10878} Herald Moonstalker · {npc:7740} Gracina Spiritmight · {item:11682} Eridan's Vial
	["{npc:10878} and {npc:7740} stand by the Temple of the Moon; fill {item:11682} at the moonwell inside."] = "{npc:10878} e {npc:7740} ficam junto ao Templo da Lua; encha o {item:11682} no poço lunar lá dentro.",
	-- {npc:7740} Gracina Spiritmight · {area:976} Gadgetzan
	["{npc:7740}: keep it for {area:976}"] = "{npc:7740}: guarde para {area:976}",

	-- Step 59: Darnassus
	-- {area:702} Rut'theran Village · {zone:1457} Darnassus
	["The portal in {area:702} leads up to {zone:1457}."] = "O portal de {area:702} sobe para {zone:1457}.",
	-- {npc:9047} Jenal · {area:1658} Cenarion Enclave
	["{npc:9047}, in the {area:1658}"] = "{npc:9047}, em {area:1658}",

	-- Step 63: Darnassus
	-- {zone:1455} Ironforge
	["{zone:1455}, where the next guide trains, has no druid trainer"] = "{zone:1455}, onde o próximo guia treina, não tem instrutor de druida",
	-- {item:11040} Morrowgrain · {item:11020} Evergreen Pouch
	["Ten {item:11040} from the {item:11020}"] = "Dez {item:11040} da {item:11020}",
	-- {quest:6762} Rabine Saturna · {zone:1450} Moonglade
	["{quest:6762} in {zone:1450}: keep it"] = "{quest:6762} em {zone:1450}: guarde",

	-- Step 64: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal para {zone:1438}",

	-- Step 65: Rut'theran Village flight master
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Mestre de voo de {area:702}",

	-- Step 66: Feathermoon Stronghold
	-- {area:702} Rut'theran Village · {area:1116} Feathermoon Stronghold
	["From {area:702}, fly to {area:1116}."] = "De {area:702}, voe para {area:1116}.",
	-- {npc:7900} Angelas Moonbreeze · {zone:1446} Tanaris
	["{npc:7900}: keep it for {zone:1446}"] = "{npc:7900}: guarde para {zone:1446}",

	-- Step 68: Boat to The Forgotten Coast
	-- {area:1108} The Forgotten Coast
	["Boat to {area:1108}"] = "Barco para {area:1108}",

	-- Step 69: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle · {area:1119} Twin Colossals
	["Take the boat to the mainland and ride north-east to {npc:14637}'s camp by the {area:1119}."] = "Pegue o barco para o continente e cavalgue para o nordeste até o acampamento de {npc:14637}, junto a {area:1119}.",

	-- Step 70: The Forgotten Coast: kill these as you meet them
	-- {area:1108} The Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: vá matando estes pelo caminho",
	-- {area:1119} Twin Colossals
	["The shrunken giants roam the {area:1119}; the sea elementals wade along the coast to the west."] = "Os gigantes encolhidos vagam por {area:1119}; os Elementais do Mar andam pela costa a oeste.",

	-- Step 72: Gregan Brewspewer
	-- {npc:7775} Gregan Brewspewer · {area:1119} Twin Colossals · {item:11243} Videre Elixir
	["{npc:7775}'s camp lies north of the {area:1119}. He sells the {item:11243} once he has his bait."] = "O acampamento de {npc:7775} fica ao norte de {area:1119}. Ele vende o {item:11243} quando recebe a isca.",

	-- Step 73: Rockbiter
	-- {npc:7765} Rockbiter · {npc:7775} Gregan Brewspewer
	["The giant {npc:7765} sits just north-west of {npc:7775}'s camp."] = "O gigante {npc:7765} fica logo a noroeste do acampamento de {npc:7775}.",

	-- Step 74: Shay Leafrunner
	-- {npc:7774} Shay Leafrunner · {item:9189} Shay's Bell
	["Ride north into the Ravenwind Ruins: {npc:7774} hides in the small round building at the back. Open the chest beside her for {item:9189}: it lasts 15 minutes, like the quest."] = "Cavalgue para o norte, até as Ruínas dos Ventos Corvejantes: {npc:7774} se esconde na pequena construção redonda dos fundos. Abra o baú ao lado dela para pegar {item:9189}: dura 15 minutos, como a missão.",

	-- Step 75: Wandering Shay
	-- {npc:7774} Shay Leafrunner · {npc:7765} Rockbiter
	["Lead {npc:7774} back to {npc:7765} at walking pace: she wanders off, so ring the bell to call her back (not in combat), and clear the harpies on the way before she reaches them."] = "Leve {npc:7774} de volta até {npc:7765} em ritmo de caminhada: ela se afasta, então toque o sino para chamá-la de volta (fora de combate) e limpe as harpias do caminho antes que ela chegue a elas.",

	-- Step 77: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "Mestre de voo de {area:489}",

	-- Step 79: Ratchet
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "De Theramore, siga para oeste até {zone:1413} e para o norte pela costa até {area:392}.",
	-- {npc:5901} Islen Waterseer
	["{npc:5901}, on the coast north of town"] = "{npc:5901}, na costa ao norte da cidade",
	-- {zone:1448} Felwood
	["For {zone:1448}: keep it"] = "Para {zone:1448}: guarde",
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: keep it for Un'Goro; inside"] = "{npc:8496}: guarde para Un'Goro; lá dentro",

	-- Step 80: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Voe para {area:2255}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 82: Donova Snowden
	["Ride west along the road to the hot springs."] = "Cavalgue para o oeste pela estrada até as fontes termais.",
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299} in {area:976}: keep it"] = "{npc:9299} em {area:976}: guarde",

	-- Step 84: Rabine Saturna
	-- {area:1769} Timbermaw Hold · {zone:1450} Moonglade · {area:2361} Nighthaven
	["Walk into {area:1769} and take the {zone:1450} branch of the tunnel to {area:2361}."] = "Entre em {area:1769} e pegue o ramo do túnel para {zone:1450} até {area:2361}.",
	-- {zone:1451} Silithus
	["For {zone:1451}: keep it"] = "Para {zone:1451}: guarde",

	-- Step 85: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Voar para {area:976}",

	-- Step 86: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, lá dentro",
	-- {npc:7583} Sprinkle
	["On {npc:7583}"] = "Em {npc:7583}",
	-- {area:3197} Chillwind Camp
	["For {area:3197}: keep it"] = "Para {area:3197}: guarde-a",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro, keep it"] = "{npc:7876}, no lado norte da cidade: o piche está em Un'Goro, guarde",

	-- Step 87: Gaeriyan
	-- {npc:9299} Gaeriyan
	["{npc:9299} waits at the graveyard just east of town; the gravestone stands nearby."] = "{npc:9299} espera no cemitério logo a leste da cidade; a lápide fica perto.",

	-- Step 88: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Siga para o sudoeste até o acampamento de {npc:7771} em {area:1938}.",
	-- {quest:3444} The Stone Circle · {area:392} Ratchet
	["{quest:3444} is in {area:392}"] = "{quest:3444} fica em {area:392}",

	-- Step 90: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Voe para {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Mestre de voo de {area:976}",

	-- Step 91: Linken
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:8737} Linken · {area:538} Lakkari Tar Pits · {npc:9117} J.D. Collie · {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["Fly from {area:976} to {area:541}. {npc:8737}'s hut stands at the {area:538}, west of the refuge; {npc:9117} is up the hill behind it.\n{npc:9997}'s friend {npc:9999} has gone missing."] = "Voe de {area:976} para {area:541}. A cabana de {npc:8737} fica em {area:538}, a oeste do refúgio; {npc:9117} está no alto da colina atrás dela.\nO amigo de {npc:9997}, {npc:9999}, desapareceu.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, no subterrâneo",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",

	-- Step 92: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "Rumo a {zone:1451}",

	-- Step 93: Layo Starstrike
	-- {zone:1451} Silithus · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest
	["Ride out of the crater's north-western pass into {zone:1451}: {npc:13220} stands at {area:3077}, where the pass comes out."] = "Cavalgue saindo pela passagem noroeste da cratera até {zone:1451}: {npc:13220} fica em {area:3077}, onde a passagem sai.",

	-- Step 95: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride on west to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Siga adiante para oeste até {area:3425}. {npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082}, nas tendas da Aliança",

	-- Step 96: Silithus: kill these as you meet them
	-- {zone:1451} Silithus
	["{zone:1451}: kill these as you meet them"] = "{zone:1451}: vá matando estes pelo caminho",
	-- plural, as words: Dredge Strikers = {npc:11740} Dredge Striker · Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer
	["Dredge Strikers dig in the dunes north-west of the hold; Stonelash Scorpids and Sand Skitterers roam all around."] = "Os Dragatacas cavam nas dunas a noroeste do forte; Escorpídeos Petraçoite e Rastejantes da Areia vagueiam por toda parte.",

	-- Step 97: Level 56.89
	["Level 56.89"] = "Nível 56.89",
	-- {item:9328} Super Snapper FX · {area:1584} Blackrock Depths · {area:1583} Blackrock Spire
	["If you skipped The {item:9328}, grind here to level 56.89 to stay on the route's plan. Or, with a group, run the {area:1584} dungeon or the {area:1583} dungeon (Lower) instead."] = "Se você pulou {item:9328}, mate monstros aqui até o nível 56.89 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:1584} ou a masmorra {area:1583} (Inferior).",
	-- {npc:11740} Dredge Striker
	["grind on {npc:11740}"] = "mate {npc:11740} até subir",

	-- Step 98: Cenarion Hold
	-- {area:3425} Cenarion Hold · {npc:15189} Beetix Ficklespragg
	["Ride back to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Cavalgue de volta a {area:3425}. {npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",

	-- Step 99: Silithus: kill these as you meet them
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher · Stonelash Pincers = {npc:11736} Stonelash Pincer · Rock Stalkers = {npc:11739} Rock Stalker
	["Dredge Crushers dig further west; Stonelash Pincers, Flayers and Rock Stalkers hunt the same sands."] = "Os Dragasmagas cavam mais a oeste; Tenazes Petraçoite, Esfoladores Petraçoite e Espreitadoras de Rocha caçam nas mesmas areias.",
	-- {npc:11741} Dredge Crusher
	["{npc:11741} walks around here: look inside the circle on the map"] = "{npc:11741} anda por aqui: procure dentro do círculo no mapa",

	-- Step 100: Southwind Village
	-- {npc:13220} Layo Starstrike
	["The tortured druids and sentinels haunt the ruined village south-west of {npc:13220}."] = "Os Druidas Torturados e as Sentinelas Torturadas assombram a aldeia em ruínas a sudoeste de {npc:13220}.",

	-- Step 102: The Hive'Ashi tower
	-- {area:2742} Hive'Ashi
	["The {area:2742} tower"] = "A torre de {area:2742}",
	-- {area:2742} Hive'Ashi · {area:2738} Southwind Village
	["Ride east to the {area:2742} tower in {area:2738}; climb it and kill the ambushers that rise for the encrusted object."] = "Siga para o leste até a torre de {area:2742} em {area:2738}; suba nela e mate os emboscadores que surgem pelo objeto incrustado.",

	-- Step 103: Layo Starstrike
	-- {zone:1450} Moonglade
	["Umber in {zone:1450}: keep it"] = "Umbero em {zone:1450}: guarde-a",

	-- Step 105: Krakle
	-- {zone:1451} Silithus · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Coming in from {zone:1451}, {area:543} is just inside the crater: {npc:10302} the goblin sits by the water."] = "Vindo de {zone:1451}, {area:543} fica logo dentro da cratera: {npc:10302}, o goblin, fica junto à água.",

	-- Step 106: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}: vá matando estes pelo caminho",

	-- Step 107: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Siga para o leste até {area:537}, suba e use {npc:10541} nas aberturas de lava perto do topo.",

	-- Step 108: Krakle
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Termina com {npc:9298}, em {zone:1452}: guarde",

	-- Step 109: Northern Pylon
	["Northern Pylon"] = "Torre de Cristal Norte",

	-- Step 111: The crater
	["The crater"] = "A cratera",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Monstros de Piche chafurdam em {area:538}; os elementais do fogo de {area:537}, no meio, carregam a cinza; as vespas Gorishi de {area:540}, no sul, carregam a glândula. Qualquer criatura da cratera pode deixar cair {item:11018}.\nCuidado: as Gorishi Trabalhadoras que caem abaixo de 45% de vida têm 50% de chance de chamar ajuda de aliados num raio de 25 m.",

	-- Step 112: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619} acampa ao pé da rampa que leva à cratera.",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "As peles vêm dos gorilas em {area:1943}",

	-- Step 113: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: vá matando estes pelo caminho",
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Os gorilas vivem em {area:1943}, a leste de {area:541}. Guarde os pelegos para {npc:9619}. Não entre na caverna mais funda: {npc:9622} é nível 55.\nCuidado: os Gorilas de Un'Goro (nível 50-51) chamam ajuda de aliados num raio de 20 m quando caem para 25% de vida. Tem uma caverna lotada de macacos na área, e lutar lá traz monstro a mais de montão.",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478}; no subterrâneo",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479}; no subterrâneo",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480}; no subterrâneo",

	-- Step 115: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Siga para o norte pelo lado leste até o planalto dos gorilas. {npc:9622}, um gorila de nível 55, fica na caverna mais funda: limpe os gorilas da entrada antes.",
	["Below ground"] = "No subterrâneo",

	-- Step 116: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "O covil de {npc:9684} fica na selva ao norte de {npc:9619}, abaixo dos penhascos leste: use {item:11568} ali. {npc:9684} é nível 56: comece com a vida cheia.",

	-- Step 117: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Atravesse o sul da cratera até {npc:9619}, junto à rampa.",

	-- Step 118: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}: vá matando estes pelo caminho",

	-- Step 119: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado na encosta sudeste de {area:537}, no meio da cratera.",

	-- Step 120: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Andorhal Watches"] = "Relógios de Andorhal",
	-- ["Back north to the {area:202}: the cauldron offers its own task now. The ghouls nearby drop Somatic Intensifiers."] = "Volte para o norte até {area:202}: o caldeirão agora oferece a própria tarefa. Os carniçais por perto deixam cair Intensificadores Somáticos.",
	-- ["Buy one {item:13320} from {npc:11056} for Felstone's cauldron, right before you go: the quickeners vanish after 30 minutes."] = "Compre um {item:13320} de {npc:11056} para o caldeirão do Campo Pedravil, logo antes de ir: os aceleradores somem após 30 minutos.",
	-- ["Buy two more Arcane Quickeners for the {area:202}'s and Dalson's cauldrons, and ride straight there: they vanish after 30 minutes."] = "Compre mais dois Aceleradores Arcanos para os caldeirões de {area:202} e das Lágrimas de Dalson, e vá direto para lá: eles somem após 30 minutos.",
	-- ["Climb the hill west of {area:190} to look down on the town."] = "Suba a colina a oeste de {area:190} para observar a cidade lá de cima.",
	-- ["Diseased Wolves"] = "Lobos Doentes",
	-- ["Ends with {npc:9298} in {area:618}: keep it"] = "Termina com {npc:9298}, em {area:618}: guarde",
	-- ["Fly to {area:392}."] = "Voe para {area:392}.",
	-- ["Follow the road south-west out of the pass to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Siga a estrada para sudoeste, saindo da passagem, até {area:3425}. {npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- ["For {area:1377}: keep it"] = "Para {area:1377}: guarde",
	-- ["For {zone:1453}: keep it"] = "Para {zone:1453}: guarde",
	-- ["From {area:392}, fly to {area:2255} and ride south to {area:2250}."] = "De {area:392}, voe para {area:2255} e cavalgue para o sul até {area:2250}.",
	-- ["Gaeriyan in {area:976}: keep it"] = "Gaeriyan em {area:976}: guarde",
	-- ["Into {area:1377}"] = "Rumo a {area:1377}",
	-- ["Ride back to {area:3197} and fly to {area:150}, take the boat to {area:442} and fly to {area:702}; the portal leads up to {zone:1457}."] = "Volte para {area:3197} e voe para {area:150}, pegue o barco para {area:442} e voe para {area:702}; o portal leva até {zone:1457}.",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Desça a rampa para a cratera: {npc:9619} acampa ao pé dela.",
	-- ["Ride east to {npc:13220}."] = "Siga para o leste até {npc:13220}.",
	-- ["Ride out of the crater's north-western pass into {area:1377} and on to {area:3425}. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Siga para fora da passagem noroeste da cratera até {area:1377} e continue até {area:3425}. {npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Siga para o oeste, passando {area:541}, e desça para o sul pelo lado oeste até {area:543}: {npc:10302}, o goblin, fica junto à água.",
	-- ["Skeletal Flayers and Slavering Ghouls roam the fields north of the camp; all the Scourge here drop Scourgestones."] = "Esfoladores Descarnados e Carniçais Salivantes vagam pelos campos ao norte do acampamento; todo o Flagelo daqui deixa cair Pedras do Flagelo.",
	-- ["Small lockboxes lie in the rubble all over Andorhal; each holds a watch."] = "Pequenos cofres estão nos escombros por toda Andorhal; cada um guarda um relógio.",
	-- ["Temple of the Moon"] = "Templo da Lua",
	-- ["The cauldron now offers its own task; the skeletons around it drop Osseous Agitators."] = "O caldeirão agora oferece a própria tarefa; os esqueletos ao redor deixam cair Agitadores Ósseos.",
	-- ["The fields"] = "Os campos",
	-- ["The next guide starts here in {area:392} and flies on to {area:976}."] = "O próximo guia começa aqui em {area:392} e voa para {area:976}.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "As peles vêm depois do circuito 2, no planalto dos gorilas",
	-- ["Umber in {area:493}: keep it"] = "Umbero em {area:493}: guarde-a",
	-- ["Walk into {area:1769} and take the {area:493} branch of the tunnel to {area:2361}."] = "Entre em {area:1769} e pegue o ramo do túnel para {area:493} até {area:2361}.",
	-- ["Zapped giants and sea elementals"] = "Gigantes irradiados e Elementais do Mar",
	-- ["grind on {npc:1796} at the {area:202}, {zone:1422}"] = "mate {npc:1796} em {area:202}, {zone:1422}",
	-- ["{area:1377}: kill these as you meet them"] = "{area:1377}: vá matando estes pelo caminho",
	-- ["{area:139}: kill these as you meet them"] = "{area:139}: vá matando estes pelo caminho",
	-- ["{area:199} cauldron"] = "Caldeirão de {area:199}",
	-- ["{item:13320}, from {npc:11056}"] = "{item:13320}, de {npc:11056}",
	-- ["{npc:10300} in {zone:1452}: keep it"] = "{npc:10300} em {zone:1452}: guarde",
	-- ["{npc:10300}: her escort comes later on the route"] = "{npc:10300}: a escolta dela vem mais tarde na rota",
	-- ["{npc:10739} stands by the farm at the {area:202}, north-east of the fields."] = "{npc:10739} fica junto à fazenda em {area:202}, a nordeste dos campos.",
	-- ["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of {area:200}; her parcel lies inside."] = "O fantasma de {npc:10778} vaga junto à casa da fazenda de {area:199}, a oeste de {area:200}; o embrulho dela está lá dentro.",
	-- ["{npc:11038}, by the graves south of the chapel"] = "{npc:11038}, junto aos túmulos ao sul da capela",
	-- ["{npc:11075} guards the cauldron in {area:199}, west of Andorhal."] = "{npc:11075} guarda o caldeirão em {area:199}, a oeste de Andorhal.",
	-- ["{npc:11140} stands by Augustus' hut in {area:2627}."] = "{npc:11140} fica junto à cabana de Augustus em {area:2627}.",
	-- ["{npc:11613} walks the Northridge camp east of {npc:11610}; {npc:11611} guards the tower at {area:190}'s southern approach."] = "{npc:11613} anda pela Madeireira Beiranorte a leste de {npc:11610}; {npc:11611} guarda a torre na entrada sul de {area:190}.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: os cupins vêm depois, em {area:2627}",
	-- ["{npc:16256}: the last guide binds here, so this usually ticks at once"] = "{npc:16256}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{npc:1852} is elite: grouping up is advised. He guards his phylactery in the middle of Andorhal."] = "{npc:1852} é elite: recomenda-se ir em grupo. Ele guarda o filactério no meio de Andorhal.",
	-- ["{npc:7900}: keep it for {area:440}"] = "{npc:7900}: guarde para {area:440}",
	-- ["{npc:8496}: keep it for Un'Goro"] = "{npc:8496}: guarde para a Cratera Un'Goro",
	-- ["{object:175924}, in the farmhouse"] = "{object:175924}, na casa da fazenda",
	-- ["{quest:6762} in {area:493}: keep it"] = "{quest:6762} em {area:493}: guarde",
}
