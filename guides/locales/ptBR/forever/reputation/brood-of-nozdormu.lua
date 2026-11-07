-- Portuguese (Brazil) (ptBR): the guide forever/reputation/brood-of-nozdormu (forever/reputation/brood-of-nozdormu.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Brood of Nozdormu Reputation"] = "Reputação: Prole de Nozdormu",
	["The Bronze Dragonflight's ring, upgraded at every standing; a long climb from Hated, mostly in raids."] = "O anel da Revoada de Bronze, melhorado a cada posição; uma subida longa a partir de Odiado, quase toda em raides.",
	-- {item:21175} The Scepter of the Shifting Sands
	["{item:21175} quest chain"] = "Cadeia de missões de {item:21175}",

	-- Step 1: Baristolth in Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Baristolth in {area:3425}"] = "Baristolth em {area:3425}",
	-- {faction:910} Brood of Nozdormu · {npc:15192} Anachronos · {npc:15180} Baristolth of the Shifting Sands · {area:3425} Cenarion Hold · {area:2677} Blackwing Lair · {area:16076} Temple of Ahn'Qiraj
	["The {faction:910} is not in your reputation list until you meet {npc:15192}. {npc:15180}, in the main building of {area:3425}, sends you to him. Meeting him sets you at Hated, 0 of 36,000: Neutral is 42,000 reputation away, and almost all of it comes from raids. {area:2677} and the {area:16076} are not among the first raids Blizzard has announced for Forever: until one of them opens, the 100 from Baristolth's first quest is all the Brood reputation there is. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{faction:910} não aparece na sua lista de reputação até você conhecer {npc:15192}. {npc:15180}, no prédio principal de {area:3425}, manda você até ele. Conhecê-lo coloca você em Odiado, 0 de 36.000: Neutro está a 42.000 de reputação de distância, e quase tudo vem de raides. {area:2677} e {area:16076} não estão entre as primeiras raides que a Blizzard anunciou para o Forever: até que uma delas abra, os 100 da primeira missão de Baristolth são toda a reputação da Prole que existe. A vantagem do Legado Diplomata soma até 10% a todo ganho; os números deste guia estão sem ela.",

	-- Step 2: Anachronos at the Caverns of Time
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time
	["{npc:15192} at the {area:2300}"] = "{npc:15192} em {area:2300}",
	-- {npc:15192} Anachronos · {area:2300} Caverns of Time · {zone:1446} Tanaris · {area:976} Gadgetzan
	["{npc:15192}, a bronze dragon in elf form, stands at the mouth of the {area:2300} in eastern {zone:1446}, south-east of {area:976}. Walk up to him."] = "{npc:15192}, um dragão de bronze em forma de elfo, fica na entrada de {area:2300}, no leste de {zone:1446}, a sudeste de {area:976}. Vá até ele.",
	-- {npc:15192} Anachronos
	["Meet {npc:15192}"] = "Conheça {npc:15192}",

	-- Step 3: Back to Baristolth
	["Back to Baristolth"] = "De volta a Baristolth",
	-- {quest:8288} Only One May Rise · {npc:12017} Broodlord Lashlayer · {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {quest:8286} What Tomorrow Brings
	["{quest:8288} wants the head of {npc:12017}, the third boss of {area:2677} (a 40-player raid in {area:254}). Everything after it needs the head, the fragment turn-ins included: until you have it, {quest:8286} is all the Brood reputation there is, solo or not."] = "{quest:8288} quer a cabeça de {npc:12017}, o terceiro chefe de {area:2677} (uma raide de 40 jogadores em {area:254}). Tudo depois dela precisa da cabeça, inclusive as entregas de fragmentos: até você a ter, {quest:8286} é toda a reputação da Prole que existe, sozinho ou não.",

	-- Step 4: Broodlord Lashlayer
	-- {area:2677} Blackwing Lair · {area:254} Blackrock Mountain · {npc:12017} Broodlord Lashlayer
	["{area:2677} is a 40-player raid at the top of {area:254}. {npc:12017} always drops his head."] = "{area:2677} é uma raide de 40 jogadores no alto de {area:254}. {npc:12017} sempre solta sua cabeça.",
	-- {item:20383} Head of the Broodlord Lashlayer
	["{item:20383}: raid of 40"] = "{item:20383}: raide de 40",

	-- Step 5: The Path of the Righteous
	-- {quest:8301} The Path of the Righteous · {area:3425} Cenarion Hold · {area:2743} Hive'Zora · {area:2744} Hive'Regal
	-- plural, as words: Silithid Carapace Fragments = {item:20384} Silithid Carapace Fragment · Hive'Ashi Workers = {npc:11721} Hive'Ashi Worker
	["{quest:8301} wants 200 Silithid Carapace Fragments. Every hive silithid drops one to three on most kills: the Hive'Ashi Workers, Stingers, Swarmers and Defenders north and north-west of {area:3425}, and those of {area:2743} in the west and {area:2744} in the south. Almost all of them are elites of level 57 to 60: one at a time solo, faster in a group."] = "{quest:8301} quer 200 Fragmentos de Carapaça Silitídea. Todo silitídeo da colmeia solta de um a três na maioria das mortes: os Trabalhadores, Aguilhantes, Enxameadores e Defensores da Colme'Ashi ao norte e noroeste de {area:3425}, e os de {area:2743} no oeste e de {area:2744} no sul. Quase todos são elites de nível 57 a 60: um de cada vez sozinho, mais rápido em grupo.",

	-- Step 6: Hated to Neutral
	["Hated to Neutral"] = "De Odiado a Neutro",
	-- {quest:8302} The Hand of the Righteous · {area:16076} Temple of Ahn'Qiraj · {item:21230} Ancient Qiraji Artifact · {item:21229} Qiraji Lord's Insignia
	["After The Path, Baristolth takes 200 more fragments for {quest:8302}: 200 reputation, again and again, but only until Neutral. From Hated 500 that is 208 turn-ins, 41,600 fragments, 20,000 to 30,000 elite kills: the only way without the Temple, and a very long one. With the {area:16076} open (a 40-player raid) it is far quicker: every Temple trash mob gives 100 until 2,999 of 3,000 Neutral, about 9,500 a full clear, so four to five clears reach Neutral. Save every {item:21230} and {item:21229} you loot until the trash stops counting: they pay the same later."] = "Depois do Caminho, Baristolth aceita mais 200 fragmentos por {quest:8302}: 200 de reputação, de novo e de novo, mas só até Neutro. A partir de Odiado 500 são 208 entregas, 41.600 fragmentos, de 20.000 a 30.000 mortes de elites: a única forma sem o Templo, e bem longa. Com {area:16076} aberto (uma raide de 40 jogadores) é muito mais rápido: todo monstro comum do Templo dá 100 até 2.999 de 3.000 de Neutro, cerca de 9.500 numa limpeza completa, então quatro a cinco limpezas chegam a Neutro. Guarde todo {item:21230} e {item:21229} que pegar até os monstros comuns pararem de contar: eles pagam o mesmo depois.",
	-- {quest:8302} The Hand of the Righteous
	["{quest:8302}: 200 fragments, 200"] = "{quest:8302}: 200 fragmentos, 200",

	-- Step 7: Anachronos's quests
	-- {quest:8303} Anachronos
	["{quest:8303}'s quests"] = "Missões de {quest:8303}",
	-- {quest:8303} Anachronos
	["Neutral opens the rest of the Scepter of the Shifting Sands chain. Baristolth sends you back to {quest:8303}."] = "Neutro libera o resto da cadeia do Cetro das Areias Cambiantes. Baristolth manda você de volta a {quest:8303}.",

	-- Step 9: The Crystalline Tear
	-- {object:180633} Crystalline Tear
	["The {object:180633}"] = "{object:180633}",
	-- {object:180633} Crystalline Tear · {area:3428} Ahn'Qiraj · {zone:1451} Silithus
	["The {object:180633} is a small red crystal on the ground just outside the gates of {area:3428}, in the far south-west of {zone:1451}. Click it, then stay and watch the vision of the War of the Shifting Sands to its end. If it is cut short, abandon the quest and click the Tear again."] = "{object:180633} é um pequeno cristal vermelho no chão logo fora dos portões de {area:3428}, no extremo sudoeste de {zone:1451}. Clique nele, depois fique e assista à visão da Guerra das Areias Cambiantes até o fim. Se ela for interrompida, abandone a missão e clique na Lágrima de novo.",
	["Watch the vision"] = "Assista à visão",

	-- Step 10: The Charge of the Dragonflights
	-- {npc:15192} Anachronos · {item:21200} Signet Ring of the Bronze Dragonflight · {quest:8555} The Charge of the Dragonflights
	["{npc:15192} now offers the {item:21200} in three kinds: the Path of the Protector (tanks), of the Conqueror (melee fighters) or of the Invoker (casters). Take one: the other two close. Each standing from Friendly to Exalted brings an upgrade of the same ring, 100 reputation each. {quest:8555} sends you after the three shards of the Scepter of the Shifting Sands."] = "{npc:15192} agora oferece {item:21200} em três tipos: o Caminho do protetor (tanques), do conquistador (combatentes corpo a corpo) ou do evocador (conjuradores). Escolha um: os outros dois se fecham. Cada posição de Amigável a Exaltado traz uma melhoria do mesmo anel, 100 de reputação cada. {quest:8555} manda você atrás dos três fragmentos do Cetro das Areias Cambiantes.",
	["Pick one: The Path of the Protector, the Conqueror or the Invoker, 100"] = "Escolha um: Caminho do protetor, do conquistador ou do evocador, 100",

	-- Step 11: The red shard: Vaelastrasz
	["The red shard: Vaelastrasz"] = "O fragmento vermelho: Vaelastrasz",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair · {quest:8730} Nefarius's Corruption · {item:21138} Red Scepter Shard
	["The red shard: {npc:13020}, the second boss of {area:2677}, gives {quest:8730} before his fight; Nefarian, the last boss, drops the {item:21138} for one raider on the quest each kill. The quest lasts five hours."] = "O fragmento vermelho: {npc:13020}, o segundo chefe de {area:2677}, dá {quest:8730} antes da luta; Nefarian, o último chefe, solta {item:21138} para um membro da raide na missão a cada morte. A missão dura cinco horas.",
	-- {npc:13020} Vaelastrasz the Corrupt · {area:2677} Blackwing Lair
	["{npc:13020}, {area:2677}: raid of 40"] = "{npc:13020}, {area:2677}: raide de 40",
	-- {item:21138} Red Scepter Shard
	["{item:21138}, Nefarian"] = "{item:21138}, Nefarian",

	-- Step 12: The blue shard: Azuregos's ledger
	["The blue shard: Azuregos's ledger"] = "O fragmento azul: o livro-razão de Azuregos",
	-- {npc:15481} Spirit of Azuregos · {zone:1447} Azshara · {npc:11811} Narain Soothfancy · {zone:1446} Tanaris
	["The {npc:15481} stands on the south coast of {zone:1447}. His ledger starts {npc:11811}'s long chain in {zone:1446}."] = "{npc:15481} fica na costa sul de {zone:1447}. O livro-razão dele inicia a longa cadeia de {npc:11811} em {zone:1446}.",

	-- Step 13: Narain Soothfancy
	-- {npc:11811} Narain Soothfancy · {area:976} Gadgetzan · {zone:1421} Silverpine Forest · {zone:1446} Tanaris · {npc:8125} Dirge Quikcleave
	["{npc:11811}, a goblin seer, lives in a hut north-east of {area:976}. He sends you three ways at once: to Stewvul's crate in {zone:1421}, to an island off the south coast of {zone:1446}, and to {npc:8125} in {area:976}."] = "{npc:11811}, um vidente goblin, vive numa cabana a nordeste de {area:976}. Ele manda você em três direções ao mesmo tempo: para a caixa de Stewvul em {zone:1421}, para uma ilha na costa sul de {zone:1446} e para {npc:8125} em {area:976}.",

	-- Step 14: Stewvul's crate
	["Stewvul's crate"] = "A caixa de Stewvul",
	-- {object:180642} Inconspicuous Crate · {area:230} Greymane Wall · {zone:1421} Silverpine Forest
	["The {object:180642} leans on the {area:230} at the south end of {zone:1421}, left of the closed gate."] = "{object:180642} fica apoiada em {area:230}, no extremo sul de {zone:1421}, à esquerda do portão fechado.",

	-- Step 15: Meridith the Mermaiden
	-- {object:180652} Freshly Dug Dirt (no name in this language: may be words) · {area:987} Land's End Beach · {npc:15526} Meridith the Mermaiden · {quest:8599} Love Song for Narain
	["The {object:180652} lies on the farther of two islands south of {area:987}, past the fatigue line. {npc:15526}, on the sea floor south of the beach's crashed gyrocopter, gives {quest:8599} and a three-minute swim-speed blessing that gets you across."] = "{object:180652} fica na mais distante de duas ilhas ao sul de {area:987}, depois da linha de exaustão. {npc:15526}, no fundo do mar ao sul do girocóptero caído na praia, dá {quest:8599} e uma bênção de velocidade de natação de três minutos que leva você até lá.",

	-- Step 16: The island off Land's End Beach
	-- {area:987} Land's End Beach
	["The island off {area:987}"] = "A ilha de {area:987}",

	-- Step 17: Back to Narain Soothfancy
	-- {npc:11811} Narain Soothfancy
	["Back to {npc:11811}"] = "De volta a {npc:11811}",
	-- {quest:8606} Decoy! · {npc:11811} Narain Soothfancy · {area:2255} Everlook · {zone:1452} Winterspring · {npc:15554} Number Two
	["{quest:8606} sends you, disguised with {npc:11811}'s turban, to a drop-off point south of {area:2255} in {zone:1452}. Leave the bag of gold there: {npc:15554}, a level 61 elite, comes for it (group of 3 to 5)."] = "{quest:8606} manda você, disfarçado com o turbante de {npc:11811}, a um ponto de entrega ao sul de {area:2255}, em {zone:1452}. Deixe a bolsa de ouro lá: {npc:15554}, um elite de nível 61, vem buscá-la (grupo de 3 a 5).",

	-- Step 18: Decoy!
	-- {npc:15554} Number Two
	["{npc:15554}, elite: group of 3 to 5"] = "{npc:15554}, elite: grupo de 3 a 5",

	-- Step 19: Dirge Quikcleave
	-- {npc:8125} Dirge Quikcleave · {area:976} Gadgetzan · {area:1121} Isle of Dread · {zone:1444} Feralas
	["{npc:8125} cooks in {area:976}. He sends you to the {area:1121} off southern {zone:1444} for a Chimaerok feast."] = "{npc:8125} cozinha em {area:976}. Ele manda você para {area:1121}, ao sul de {zone:1444}, buscar um banquete de Quiméroco.",

	-- Step 20: The Isle of Dread
	-- {area:1121} Isle of Dread
	["The {area:1121}"] = "{area:1121}",
	-- {npc:12803} Lord Lakmaeran · {area:1121} Isle of Dread
	["{npc:12803} and the Chimaerok on the {area:1121} are elites of level 60 to 62 that respawn every ten minutes: a raid's work. The Chimaerok drop a tenderloin about half the time, Lakmaeran two to four now and then."] = "{npc:12803} e os Quiméroco em {area:1121} são elites de nível 60 a 62 que renascem a cada dez minutos: trabalho para uma raide. Os Quiméroco soltam um lombo cerca de metade das vezes, Lakmaeran de duas a quatro de vez em quando.",
	-- {item:21027} Lakmaeran's Carcass · {npc:12803} Lord Lakmaeran
	["{item:21027}, {npc:12803}: raid"] = "{item:21027}, {npc:12803}: raide",

	-- Step 21: Draconic for Dummies, Volume II
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}, Volume II"] = "{quest:8597}, Volume II",
	-- {quest:8620} The Only Prescription · {quest:8597} Draconic for Dummies · {npc:15552} Doctor Weavil · {area:2079} Alcaz Island · {zone:1419} Blasted Lands · {area:2255} Everlook · {zone:1458} Undercity · {npc:11811} Narain Soothfancy
	-- plural, as words: Felguard Elites = {npc:8717} Felguard Elite · Doomguard Commanders = {npc:12396} Doomguard Commander
	["{quest:8620} needs the eight chapters of {quest:8597}, Volume II: from {npc:15552} in his house on {area:2079} (a level 63 elite with guards, raid), the Felguard Elites, Doomguard Commanders and Dreadlords of the {zone:1419}, the Hederine south of {area:2255}, and a book in the {zone:1458}. {npc:11811} hands out the binding when you accept."] = "{quest:8620} precisa dos oito capítulos de {quest:8597}, Volume II: de {npc:15552} em sua casa em {area:2079} (um elite de nível 63 com guardas, raide), dos Guardas Vis de Elite, Comandantes Demonarcas e Senhores do Medo de {zone:1419}, dos Hederine ao sul de {area:2255} e de um livro em {zone:1458}. {npc:11811} entrega a encadernação quando você aceita.",
	-- {quest:8597} Draconic for Dummies
	["{quest:8597}: Volume II"] = "{quest:8597}: Volume II",

	-- Step 22: Dirge Quikcleave's Chops
	-- {npc:8125} Dirge Quikcleave
	["{npc:8125}'s Chops"] = "Costeletas de {npc:8125}",
	-- {npc:8125} Dirge Quikcleave · {item:9061} Goblin Rocket Fuel · {item:8150} Deeprock Salt · {npc:11811} Narain Soothfancy · {item:18562} Elementium Ore · {item:21136} Arcanite Buoy · {object:180669} Swirling Maelstrom (no name in this language: may be words) · {zone:1447} Azshara · {area:1227} Bay of Storms · {npc:15571} Maws · {item:21137} Blue Scepter Shard
	-- plural, as words: Arcanite Bars = {item:12360} Arcanite Bar · Azerothian Diamonds = {item:12800} Azerothian Diamond · Blue Sapphires = {item:12361} Blue Sapphire
	["{npc:8125} wants 20 {item:9061} and 20 {item:8150} with the meat. {npc:11811} then wants 20 Arcanite Bars, 10 {item:18562}, 10 Azerothian Diamonds and 10 Blue Sapphires, and gives you an {item:21136}: placed at the {object:180669} in {zone:1447}'s {area:1227}, it calls up {npc:15571}, a level 63 boss for a raid. {npc:15571} drops the {item:21137} for one raider on the quest each kill."] = "{npc:8125} quer 20 {item:9061} e 20 {item:8150} junto com a carne. {npc:11811} então quer 20 Barras de Arcanita, 10 {item:18562}, 10 Diamantes Azerotianos e 10 Safiras Azuis, e entrega uma {item:21136}: colocado em {object:180669} em {area:1227}, de {zone:1447}, ele invoca {npc:15571}, um chefe de nível 63 para uma raide. {npc:15571} solta {item:21137} para um membro da raide na missão a cada morte.",
	-- {item:12360} Arcanite Bar
	["{item:12360}: Alchemists, or the auction house"] = "{item:12360}: Alquimistas, ou a Casa de Leilões",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}: {area:2677}, or the auction house"] = "{item:18562}: {area:2677}, ou a Casa de Leilões",

	-- Step 23: Maws
	-- {item:21137} Blue Scepter Shard · {npc:15571} Maws
	["{item:21137}, {npc:15571}: raid"] = "{item:21137}, {npc:15571}: raide",

	-- Step 24: The green shard: Eranikus
	["The green shard: Eranikus"] = "O fragmento verde: Erânicos",
	-- {npc:15362} Malfurion Stormrage · {npc:5709} Shade of Eranikus · {area:1477} Temple of Atal'Hakkar · {npc:15624} Forest Wisp · {zone:1457} Darnassus · {npc:11832} Keeper Remulos · {zone:1450} Moonglade
	["{npc:15362} appears beside the {npc:5709} at the bottom of the {area:1477} (a five-player dungeon). He sends you to a {npc:15624} outside {zone:1457} (Horde players walk past the city's guards), then to {npc:11832} in {zone:1450}."] = "{npc:15362} aparece ao lado de {npc:5709} no fundo de {area:1477} (uma masmorra de cinco jogadores). Ele manda você a um {npc:15624} fora de {zone:1457} (jogadores da Horda passam pelos guardas da cidade), depois a {npc:11832} em {zone:1450}.",
	-- {npc:15362} Malfurion Stormrage · {area:1477} Temple of Atal'Hakkar
	["{npc:15362}, inside the {area:1477}"] = "{npc:15362}, dentro de {area:1477}",

	-- Step 25: The Forest Wisp
	-- {npc:15624} Forest Wisp
	["The {npc:15624}"] = "{npc:15624}",
	-- {npc:15624} Forest Wisp
	["{npc:15624}: 25 (and 25 Cenarion Circle)"] = "{npc:15624}: 25 (e 25 com o Círculo Cenariano)",

	-- Step 26: Keeper Remulos
	-- {quest:8735} The Nightmare's Corruption · {zone:1440} Ashenvale · {zone:1444} Feralas · {zone:1425} Hinterlands · {npc:15625} Twilight Corrupter · {zone:1431} Duskwood
	["{quest:8735} wants a fragment from each of the four Dragons of Nightmare portals: elite dragonkin at the {zone:1440}, {zone:1444} and {zone:1425} portals (5% each) and the {npc:15625} in {zone:1431}. Raid content."] = "{quest:8735} quer um fragmento de cada um dos quatro portais dos Dragões do Pesadelo: dragonídeos elite nos portais de {zone:1440}, {zone:1444} e {zone:1425} (5% cada) e {npc:15625} em {zone:1431}. Conteúdo de raide.",
	["10 (and 100 Cenarion Circle)"] = "10 (e 100 com o Círculo Cenariano)",

	-- Step 27: The Ashenvale portal
	-- {zone:1440} Ashenvale
	["The {zone:1440} portal"] = "O portal de {zone:1440}",
	["The four dream portals sit in groves guarded by elite dragonkin of level 60 to 62 that respawn every 30 minutes; each drops the portal's fragment one time in twenty. Raid content."] = "Os quatro portais dos sonhos ficam em bosques guardados por dragonídeos elite de nível 60 a 62 que renascem a cada 30 minutos; cada um solta o fragmento do portal uma vez em vinte. Conteúdo de raide.",

	-- Step 28: The Duskwood portal
	-- {zone:1431} Duskwood
	["The {zone:1431} portal"] = "O portal de {zone:1431}",
	-- {npc:15625} Twilight Corrupter
	["The {npc:15625} (level 63 boss) always drops its fragment."] = "{npc:15625} (chefe de nível 63) sempre solta seu fragmento.",

	-- Step 29: The Feralas portal
	-- {zone:1444} Feralas
	["The {zone:1444} portal"] = "O portal de {zone:1444}",

	-- Step 30: Hinterlands portal
	-- {zone:1425} Hinterlands
	["{zone:1425} portal"] = "Portal de {zone:1425}",

	-- Step 31: The Nightmare Manifests
	-- {npc:11832} Keeper Remulos · {area:2361} Nighthaven
	["A raid event: follow {npc:11832} toward {area:2361} and keep him alive against Eranikus and his nightmare adds until Tyrande arrives and redeems Eranikus. Do not kill Eranikus."] = "Um evento de raide: siga {npc:11832} em direção a {area:2361} e mantenha-o vivo contra Erânicos e seus aliados do pesadelo até Tyrande chegar e redimir Erânicos. Não mate Erânicos.",
	["100 (and 100 Cenarion Circle)"] = "100 (e 100 com o Círculo Cenariano)",
	["The Redemption of Eranikus: raid"] = "A Redenção de Erânicos: raide",
	["200 (and 200 Cenarion Circle)"] = "200 (e 200 com o Círculo Cenariano)",

	-- Step 32: The Scepter of the Shifting Sands
	-- {npc:15192} Anachronos · {object:180717} Scarab Gong (no name in this language: may be words) · {area:3428} Ahn'Qiraj
	["With the three shards, {npc:15192} makes the Scepter of the Shifting Sands. In Classic its first holder rings the {object:180717} once for the whole realm, opening the gates of {area:3428}, and those who finish within ten hours earn the black qiraji crystal mount; whether Forever's realms get that event is not known."] = "Com os três fragmentos, {npc:15192} faz o Cetro das Areias Cambiantes. No Classic, seu primeiro portador toca {object:180717} uma vez para o reino inteiro, abrindo os portões de {area:3428}, e quem terminar em dez horas ganha a montaria de cristal qiraji negro; não se sabe se os reinos do Forever terão esse evento.",

	-- Step 33: Scarab Gong
	-- {object:180717} Scarab Gong (no name in this language: may be words) · {area:3428} Ahn'Qiraj · {npc:15693} Jonathan the Revelator · {quest:8745} Treasure of the Timeless One
	["{object:180717} hangs before the gates of {area:3428}. {npc:15693} appears beside it once the gong has been rung, with {quest:8745}: a weapon and 200 reputation."] = "{object:180717} fica diante dos portões de {area:3428}. {npc:15693} aparece ao lado dele depois que o gongo é tocado, com {quest:8745}: uma arma e 200 de reputação.",

	-- Step 34: Neutral to Friendly in the Temple
	["Neutral to Friendly in the Temple"] = "De Neutro a Amigável no Templo",
	-- {area:16076} Temple of Ahn'Qiraj · {area:2737} Scarab Wall · {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {area:3454} Ruins of Ahn'Qiraj
	["Neutral to Friendly is 3,000 reputation. Every trash mob of the {area:16076} (a 40-player raid behind the {area:2737}) gives 100, and the Twin Emperors 210 each, until 2,999 of 3,000 Neutral, one point short of Friendly; there they stop. Then hand in one saved {item:21230} (1,000, to {npc:15502}) or {item:21229} (500, to {npc:15503}) to tip you over. The shoulder and boot exchanges of the Temple's tier set need no standing: the token, two idols and ten scarabs to {npc:15502} (shoulders) or {npc:15503} (boots) pay 200 each. The {area:3454} (20 players) give a little from bosses: Kurinnaxx, Moam, Buru and Ayamiss 50 each, Rajaxx 34, Ossirian 100, to Exalted."] = "De Neutro a Amigável são 3.000 de reputação. Todo monstro comum de {area:16076} (uma raide de 40 jogadores atrás de {area:2737}) dá 100, e os Imperadores Gêmeos 210 cada, até 2.999 de 3.000 de Neutro, um ponto antes de Amigável; ali eles param. Depois entregue um {item:21230} guardado (1.000, a {npc:15502}) ou {item:21229} (500, a {npc:15503}) para passar. As trocas de ombreiras e botas do set de tier do Templo não exigem posição: o símbolo, dois ídolos e dez escaravelhos para {npc:15502} (ombreiras) ou {npc:15503} (botas) pagam 200 cada. As {area:3454} (20 jogadores) dão um pouco dos chefes: Korinnaxx, Moam, Buru e Ayamiss 50 cada, Rajaxx 34, Ossirian 100, até Exaltado.",
	-- {item:21229} Qiraji Lord's Insignia
	["{item:21229}, Temple bosses"] = "{item:21229}, chefes do Templo",

	-- Step 35: The ring at Friendly
	["The ring at Friendly"] = "O anel em Amigável",
	-- {npc:15192} Anachronos
	["At Friendly, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "Em Amigável, {npc:15192} melhora o anel do caminho que você escolheu: Caminho do protetor, do conquistador ou do evocador. Leve o anel que você usa; 100 de reputação.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Friendly ring quest of your path"] = "{npc:15192}: a missão do anel de Amigável do seu caminho",

	-- Step 36: Friendly to Honored: the turn-ins
	["Friendly to Honored: the turn-ins"] = "De Amigável a Honrado: as entregas",
	-- {item:21230} Ancient Qiraji Artifact · {quest:8784} Secrets of the Qiraji · {npc:15502} Andorgos · {item:21229} Qiraji Lord's Insignia · {npc:15503} Kandrostrasz · {quest:8595} Mortal Champions · {npc:15727} C'Thun
	["Now hand in what you saved. Each {item:21230} (any Temple trash, 1% to 9%) starts {quest:8784}: 1,000 reputation from {npc:15502}, one of the three bronze dragons inside the Temple. Each {item:21229} (nearly every Temple boss) goes to {npc:15503} for {quest:8595}: 500 here and 100 Cenarion Circle. {npc:15727} gives 2,500, to Exalted. Friendly to Honored is 6,000: six artifacts or twelve insignias. Friendly also opens the helm and leg exchanges of the Temple's tier set (200 reputation each) at {npc:15502} and {npc:15503}."] = "Agora entregue o que guardou. Cada {item:21230} (qualquer monstro comum do Templo, 1% a 9%) inicia {quest:8784}: 1.000 de reputação com {npc:15502}, um dos três dragões de bronze dentro do Templo. Cada {item:21229} (quase todo chefe do Templo) vai para {npc:15503} por {quest:8595}: 500 aqui e 100 com o Círculo Cenariano. {npc:15727} dá 2.500, até Exaltado. De Amigável a Honrado são 6.000: seis artefatos ou doze insígnias. Amigável também libera as trocas de elmo e perneiras do set de tier do Templo (200 de reputação cada) com {npc:15502} e {npc:15503}.",
	-- {item:21230} Ancient Qiraji Artifact · {npc:15502} Andorgos
	["{item:21230}: right-click it, then {npc:15502}"] = "{item:21230}: clique com o botão direito e depois {npc:15502}",
	-- {quest:8595} Mortal Champions
	["{quest:8595}: 1 insignia, 500"] = "{quest:8595}: 1 insígnia, 500",

	-- Step 37: The ring at Honored
	["The ring at Honored"] = "O anel em Honrado",
	-- {npc:15192} Anachronos
	["At Honored, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "Em Honrado, {npc:15192} melhora o anel do caminho que você escolheu: Caminho do protetor, do conquistador ou do evocador. Leve o anel que você usa; 100 de reputação.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Honored ring quest of your path"] = "{npc:15192}: a missão do anel de Honrado do seu caminho",

	-- Step 38: Honored to Revered
	["Honored to Revered"] = "De Honrado a Reverenciado",
	-- {npc:15727} C'Thun · {quest:8595} Mortal Champions · {quest:8789} Imperial Qiraji Armaments · {npc:15380} Arygos · {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["Honored to Revered is 12,000: twelve artifacts, 24 insignias, or a mix with {npc:15727} (2,500). After the first, each insignia is the repeatable {quest:8595}. Every Temple boss sometimes drops an {quest:8789} or Regalia (about one time in twenty): {npc:15380} and {npc:15378}, inside the Temple once {npc:15727} is dead, take it with 3 {item:18562} for 200 and a weapon. Honored opens the chest exchange of the tier set (200)."] = "De Honrado a Reverenciado são 12.000: doze artefatos, 24 insígnias, ou uma mistura com {npc:15727} (2.500). Depois da primeira, cada insígnia é a repetível {quest:8595}. Todo chefe do Templo às vezes solta {quest:8789} ou Regalia (cerca de uma vez em vinte): {npc:15380} e {npc:15378}, dentro do Templo depois que {npc:15727} morre, aceitam com 3 {item:18562} por 200 e uma arma. Honrado libera a troca de peitoral do set de tier (200).",
	-- {item:18562} Elementium Ore · {area:2677} Blackwing Lair
	["{item:18562}, {area:2677} or the auction house"] = "{item:18562}, {area:2677} ou a Casa de Leilões",
	-- {npc:15380} Arygos · {item:18562} Elementium Ore
	["{npc:15380}: Armaments and 3 {item:18562}, 200"] = "{npc:15380}: Armamentos e 3 {item:18562}, 200",
	-- {npc:15378} Merithra of the Dream · {item:18562} Elementium Ore
	["{npc:15378}: Regalia and 3 {item:18562}, 200"] = "{npc:15378}: Regalia e 3 {item:18562}, 200",

	-- Step 39: The ring at Revered
	["The ring at Revered"] = "O anel em Reverenciado",
	-- {npc:15192} Anachronos
	["At Revered, {npc:15192} upgrades the ring of the path you chose: The Path of the Protector, Conqueror or Invoker. Bring the ring you wear; 100 reputation."] = "Em Reverenciado, {npc:15192} melhora o anel do caminho que você escolheu: Caminho do protetor, do conquistador ou do evocador. Leve o anel que você usa; 100 de reputação.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Revered ring quest of your path"] = "{npc:15192}: a missão do anel de Reverenciado do seu caminho",

	-- Step 40: Revered to Exalted
	["Revered to Exalted"] = "De Reverenciado a Exaltado",
	-- {npc:15727} C'Thun · {quest:8801} C'Thun's Legacy · {npc:15379} Caelestrasz
	["Revered to Exalted is 21,000: 21 artifacts or 42 insignias, with {npc:15727}'s 2,500 a week. {npc:15727}'s eye starts {quest:8801} for {npc:15379} (200, and 200 Cenarion Circle). At Exalted Anachronos gives the last ring: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker."] = "De Reverenciado a Exaltado são 21.000: 21 artefatos ou 42 insígnias, com os 2.500 semanais de {npc:15727}. O olho de {npc:15727} inicia {quest:8801} para {npc:15379} (200, e 200 com o Círculo Cenariano). Em Exaltado, Anacronos dá o último anel: O protetor de Kalimdor, O conquistador de Qiraji ou O grande evocador.",

	-- Step 41: The Exalted ring
	["The Exalted ring"] = "O anel de Exaltado",
	-- {npc:15192} Anachronos
	["At Exalted, {npc:15192} gives the last ring of your path: The Protector of Kalimdor, The Qiraji Conqueror or The Grand Invoker. Bring the Revered ring; 100 reputation."] = "Em Exaltado, {npc:15192} dá o último anel do seu caminho: O protetor de Kalimdor, O conquistador de Qiraji ou O grande evocador. Leve o anel de Reverenciado; 100 de reputação.",
	-- {npc:15192} Anachronos
	["{npc:15192}: the Exalted ring quest of your path"] = "{npc:15192}: a missão do anel de Exaltado do seu caminho",
}
