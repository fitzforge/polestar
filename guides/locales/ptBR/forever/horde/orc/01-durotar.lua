-- Portuguese (Brazil) (ptBR): the guide forever/horde/orc/01-durotar (forever/horde/orc/01-durotar.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} espera dentro d'O Covil, a construção logo a oeste de {npc:10176}.",
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, onde você começa",
	["Inside"] = "Lá dentro",

	-- Step 2: Training weapons and boars
	["Training weapons and boars"] = "Armas de treino e javalis",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "As armas ficam em volta d'O Covil e do campo de treino; os Mosquetuscos vagam por todo o fundo do vale.",

	-- Step 3: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} fica logo na entrada da caverna; {npc:3159}, no fundo da caverna, atrás dele.",
	-- {npc:3143} Gornek
	["{npc:3143}, inside"] = "{npc:3143}, lá dentro",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}, o instrutor de bruxo no fundo da caverna",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}, o instrutor de ladino n'O Covil",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}, o instrutor de guerreiro ao lado d'O Covil",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}, o instrutor de caçador ao lado d'O Covil",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}, o instrutor de xamã ao lado d'O Covil",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}, a instrutora de mago, na entrada d'O Covil",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave; below ground"] = "{npc:3159}, no fundo da caverna; no subterrâneo",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, junto à fogueira de cozinhar",

	-- Step 4: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} está ferido no sopé das colinas a noroeste d'O Covil.",

	-- Step 5: Valley of Trials: kill these as you meet them
	-- {area:363} Valley of Trials
	["{area:363}: kill these as you meet them"] = "{area:363}: vá matando estes pelo caminho",
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua · {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way.\nThe {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "{quest:790}, um escorpídeo graúdo, ronda a encosta ao sul de {npc:3287} no meio dos Escorpídeos Operários; colha as Sabras nos cactos pelo caminho.\nOs {quest:792} infestam a encosta abaixo de {area:365}, a caverna no lado norte do vale.",

	-- Step 6: Class trainer
	["Class trainer"] = "Instrutor de classe",

	-- Step 7: Paladin trainer
	["Paladin trainer"] = "Instrutor de paladino",
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:363} Valley of Trials
	["{npc:246344} in {zone:1456}; {area:363} has no paladin trainer"] = "{npc:246344} em {zone:1456}; {area:363} não tem instrutor de paladino",

	-- Step 8: Druid trainer
	["Druid trainer"] = "Instrutor de druida",
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:363} Valley of Trials
	["{npc:3034} in {zone:1412}; {area:363} has no druid trainer"] = "{npc:3034} em {zone:1412}; {area:363} não tem instrutor de druida",

	-- Step 9: Back to the Den
	["Back to the Den"] = "De volta ao Covil",
	-- {npc:11378} Foreman Thazz'ril
	["{npc:11378}, at the lumber pile east of the Den"] = "{npc:11378}, na pilha de madeira a leste do Covil",

	-- Step 10: Lazy Peons
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Acorde os {quest:5441} com o {item:16114}",

	-- Step 13: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "Dentro da caverna, siga reto na primeira bifurcação, depois à direita, e acompanhe o riacho à sua esquerda até a cachoeira: a picareta brilha junto à água, atrás de uma coluna de pedra.",

	-- Step 14: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "Dentro da caverna, mantenha-se rente à parede da direita a volta toda, passando o riacho: {npc:3183} espera no fim.",
	["Below ground"] = "No subterrâneo",

	-- Step 15: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Cascos de {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Os Espreitadores Vis vagam pela encosta abaixo da caverna, no lado norte do vale.",

	-- Step 16: Back to the Den
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "o {object:654925} no chão ao lado dela",

	-- Step 17: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} fica do lado de fora d'O Covil. {area:639} é a colina logo ao sul: beba a {item:6635} lá para ver a {npc:5891}, depois leve o {item:6656} de volta para {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, na {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} e o seu {item:5175}",

	-- Step 18: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} fica na estrada, na saída leste do vale.",

	-- Step 19: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: só encantadores, o resíduo vem do desencantamento de Pingentes Bagateados",
	-- {npc:5880} Un'Thuwa
	["{npc:5880}, the mage trainer in Sen'jin"] = "{npc:5880}, o instrutor de mago em Sen'jin",

	-- Step 20: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "A fogueira de {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "{npc:265809} acampa logo ao sul de {area:362}. Sente na fogueira dele (/sit) até aparecer o bônus {spell:1229451}.",

	-- Step 21: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town; inside"] = "{npc:266940}, no lado leste da cidade; lá dentro",

	-- Step 22: Razor Hill
	-- {npc:3191} Cook Torka
	["{npc:3191}: Camping 101 asks you to learn it"] = "{npc:3191}: Introdução ao acampamento pede que você aprenda",
	-- {npc:6928} Innkeeper Grosk
	["{npc:6928}, inside"] = "{npc:6928}, lá dentro",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, na torre de vigia",

	-- Step 23: Prickly pears
	["Prickly pears"] = "Figos-da-índia",
	["The prickly pears grow among the quilboar huts just west of town."] = "Os figos-da-índia crescem entre as cabanas dos javatuscos logo a oeste da cidade.",

	-- Step 25: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "A fortaleza fica na costa a sudeste de {area:362}. O machado, o arco e o escudo dos saqueadores estão nos arredores dela. Marinheiros e fuzileiros derrubam os {item:4870}. {npc:3192} espera no alto da fortaleza; a chave dele abre o baú ao seu lado, que guarda o {item:4881}.",
	["Upstairs"] = "No andar de cima",

	-- Step 26: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3147} Furl Scornbrow · {npc:3142} Orgnil Soulscar · {npc:266940} Turroc
	["Back north-west to {area:362}: {npc:3139} first, then {npc:3147} in the watchtower, then {npc:3142} and {npc:266940} on the way out east to the shore."] = "De volta ao noroeste até {area:362}: {npc:3139} primeiro, depois {npc:3147} na torre de vigia, depois {npc:3142} e {npc:266940} na saída para leste, rumo à costa.",
	-- {npc:266940} Turroc
	["{npc:266940}, inside"] = "{npc:266940}, lá dentro",

	-- Step 27: Scuttle Coast: kill these as you meet them
	-- {area:373} Scuttle Coast
	["{area:373}: kill these as you meet them"] = "{area:373}: vá matando estes pelo caminho",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin.\nMakrura and surf crawlers line the beaches north-east of Sen'jin."] = "As caixas de ferramentas gnômicas ficam nos destroços ao longo da costa a leste e sudeste de {area:362}. Siga a costa para o sul até Sen'jin.\nMakruras e surfatiscos enchem as praias a nordeste de Sen'jin.",
	["Underwater"] = "Debaixo d'água",

	-- Step 28: Echo Isles: kill these as you meet them
	-- {area:368} Echo Isles
	["{area:368}: kill these as you meet them"] = "{area:368}: vá matando estes pelo caminho",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there.\nWade back west to the shore south of Sen'jin. Durotar Tigers roam it and the Taillasher eggs sit in nests along the beach."] = "Atravesse a água até a ilha mais ao norte das Ilhas do Eco. A Matriarca ronda entre os raptores de lá.\nVolte pela água para oeste até a praia ao sul de Sen'jin. Tigres de Durotar rondam por lá, e os ovos de Açoitacauda ficam em ninhos ao longo da praia.",

	-- Step 29: Echo Isles: kill these as you meet them
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "Siga para o sul pelas ilhas. Os ídolos Loa estão espalhados pelas ilhas do sul; Trolls Vodu e Trolls Bagateados os guardam e derrubam os Pingentes Bagateados. {quest:826} e a jaula de Minshina ficam na ilha mais ao sul.",

	-- Step 30: Deathskip to Sen'jin Village
	-- {area:367} Sen'jin Village
	["Deathskip to {area:367}"] = "Atalho fantasma até {area:367}",
	-- {npc:3206} Voodoo Troll · {npc:6491} Spirit Healer
	["Die to the mobs at 66.9,87.2 ({npc:3206}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "Morra para os monstros em 66.9,87.2 ({npc:3206}): morrendo ali, você vai parar neste cemitério. Libere o espírito e aceite a ressurreição do {npc:6491}.",

	-- Step 32: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "O {area:366} fica a oeste de Sen'jin. Os três planos de ataque estão no chão entre as tendas dos centauros. {npc:275811} também está presa no penedo.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Liberte {npc:275811} e leve-a em segurança para fora do penedo",

	-- Step 35: Level 10
	["Level 10"] = "Nível 10",
	-- {quest:840} Conscript of the Horde · {area:362} Razor Hill
	["Top up here to level 10: {quest:840}, at {area:362}, needs level 10."] = "Complete aqui até o nível 10: {quest:840}, em {area:362}, pede nível 10.",
	-- {npc:3111} Razormane Quilboar
	["grind on {npc:3111}"] = "mate {npc:3111} até subir",

	-- Step 36: Razor Hill
	-- {npc:3169} Tarshaw Jaggedscar
	["{npc:3169}, inside"] = "{npc:3169}, lá dentro",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, junto à estalagem",

	-- Step 37: Far Watch Post
	-- {area:814} Southfury River · {npc:3337} Kargal Battlescar · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge: {npc:3337} stands at {area:379} above it, on your way to {npc:5907}."] = "Para o oeste pela ponte de {area:814}: {npc:3337} fica em {area:379}, acima dela, no seu caminho até {npc:5907}.",

	-- Step 42: Kranal Fiss
	-- {area:814} Southfury River · {area:379} Far Watch Post · {npc:5907} Kranal Fiss
	["West over the {area:814} bridge, past {area:379} and on along the ridge: {npc:5907} stands alone above the Razormane camp."] = "Para oeste pela ponte de {area:814}, passando por {area:379} e seguindo pela crista: {npc:5907} fica sozinho acima do acampamento dos Crinavalha.",

	-- Step 43: Telf Joolam
	-- {zone:1411} Durotar · {npc:5900} Telf Joolam
	["Back over the bridge and south along the {zone:1411} bank of the river to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "De volta pela ponte e ao sul pela margem de {zone:1411} do rio, até onde uma trilha estreita sobe a montanha: {npc:5900} guarda o santuário no topo. Cuidado com as bordas na subida e desça pela mesma trilha.",

	-- Step 44: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Javatuscos e batedores ocupam as cabanas a oeste da cidade; levanta-poeiras e guardas de batalha ocupam os acampamentos mais a oeste.",

	-- Step 45: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Head north-east to the road toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "Siga para nordeste até a estrada que leva a {zone:1454}. {npc:3293} acampa ao lado dela; os sacos roubados estão ao longo da estrada, ao sul dele.",

	-- Step 46: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb · {area:371} Dustwind Cave · {item:6652} Reagent Pouch
	-- plural, as words: Burning Blade Cultists = {npc:3199} Burning Blade Cultist
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}. Shamans: the Burning Blade Cultists by {area:371}, at the ravine's south end, drop the {item:6652}."] = "Selvagens e Bruxas da Tempestade fazem ninho em {area:370}, a leste de {npc:3293}. Uma Bruxa da Tempestade deixa cair {item:277661}. Xamãs: os Sectários da Lâmina Ardente perto de {area:371}, na ponta sul da ravina, deixam cair {item:6652}.",

	-- Step 47: Deathskip to Northern Durotar
	["Deathskip to Northern Durotar"] = "Atalho fantasma até o norte de Durotar",
	-- {npc:3118} Dustwind Storm Witch · {npc:6491} Spirit Healer
	["Die to the mobs at 52.0,21.4 ({npc:3118}): a death there sends you to this graveyard. Release your spirit and take the {npc:6491}'s resurrection."] = "Morra para os monstros em 52.0,21.4 ({npc:3118}): morrendo ali, você vai parar neste cemitério. Libere o espírito e aceite a ressurreição do {npc:6491}.",

	-- Step 49: Thunder Ridge: kill these as you meet them
	-- {area:369} Thunder Ridge
	["{area:369}: kill these as you meet them"] = "{area:369}: vá matando estes pelo caminho",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}.\nFizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way.\nCareful: Burning Blade cultists surround Fizzle, some linked so they aggro in pairs, and they respawn quickly."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam em {area:369}, logo a oeste e sudoeste de {npc:3293}.\nBulho manda no acampamento da Lâmina Ardente em {area:369}, a noroeste de {area:362}. Caçadores: domem um {npc:3099} com o {item:15908} pelo caminho.\nCuidado: sectários da Lâmina Ardente cercam Bulho, alguns andam em dupla e puxam juntos, e eles renascem rápido.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestique-o com a {item:15908}",

	-- Step 50: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "A cabana de Misha fica ao sul dos lagartos. Os crocoliscos ao longo do {area:814}, a oeste, carregam o {item:4891}.",

	-- Step 52: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} fica na praia a leste de {area:362}. O tridente, o estandarte e a adaga estão na areia em volta dele.",

	-- Step 54: Paladin trainer
	-- {npc:246344} Alodan the Hopeful · {zone:1456} Thunder Bluff · {area:362} Razor Hill
	["{npc:246344} in {zone:1456}; {area:362} has no paladin trainer"] = "{npc:246344} em {zone:1456}; {area:362} não tem instrutor de paladino",

	-- Step 55: Mage trainer
	["Mage trainer"] = "Instrutor de mago",
	-- {npc:5884} Mai'ah · {zone:1411} Durotar · {area:362} Razor Hill
	["{npc:5884} in {zone:1411}; {area:362} has no mage trainer"] = "{npc:5884} em {zone:1411}; {area:362} não tem instrutor de mago",

	-- Step 56: Druid trainer
	-- {npc:3034} Sheal Runetotem · {zone:1412} Mulgore · {area:362} Razor Hill
	["{npc:3034} in {zone:1412}; {area:362} has no druid trainer"] = "{npc:3034} em {zone:1412}; {area:362} não tem instrutor de druida",

	-- Step 57: Razor Hill
	-- {area:362} Razor Hill · {npc:3139} Gar'Thok · {npc:3142} Orgnil Soulscar
	["Back to {area:362}: {npc:3139}, then {npc:3142}."] = "De volta a {area:362}: {npc:3139} e depois {npc:3142}.",

	-- Step 58: Spitelash naga
	["Spitelash naga"] = "Nagas Iralisca",
	-- {area:370} Drygulch Ravine · {npc:275657} Heglan Shadeeye · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["North-east to the beach below {area:370}, north of {npc:275657}: Spitelash Scouts and Attendants hold it. Hunters: tame a {npc:3107} on the beach."] = "A nordeste, até a praia abaixo de {area:370}, ao norte de {npc:275657}: Batedores Iralisca e Serviçais Iralisca a ocupam. Caçadores: domestiquem um {npc:3107} na praia.",

	-- Step 59: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} acampa na colina a oeste da praia dos nagas, ao sul da {quest:827}.",

	-- Step 61: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words)
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "O portão principal de {zone:1454} fica logo a oeste da {area:817}. {npc:5875} fica na {object:172960}, o cânion abaixo do {object:172982}.",

	-- Step 62: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor (no name in this language: may be words)
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Já que está aqui: aprenda Cajados com {npc:2704} ({object:172958}, 10 pratas); enquanto você sobe de nível, um cajado traz mais atributos de feitiço que uma arma de uma mão.",

	-- Step 63: Back to Durotar
	-- {zone:1411} Durotar
	["Back to {zone:1411}"] = "De volta a {zone:1411}",

	-- Step 64: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Entrada da {area:817}",

	-- Step 65: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Sectários de Lâmina Ardente ocupam as cavernas de {quest:827}; qualquer um deles deixa cair um {item:4871}. {npc:3204}, um bruxo de nível 14, fica no fundo e deixa cair o {item:4903}.",

	-- Step 66: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "O {object:58595} fica na {area:817}, entre os sectários que você acabou de enfrentar.",

	-- Step 67: Into Orgrimmar
	-- {zone:1454} Orgrimmar
	["Into {zone:1454}"] = "Rumo a {zone:1454}",

	-- Step 69: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "Volte até {npc:5875} na {object:172960}. Use os {item:7464} no círculo de evocação de lá e derrote o emissário do caos para prendê-lo.",

	-- Step 72: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "De volta a {area:362}.",

	-- Step 73: Razor Hill
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, um gigante do mar elite",

	-- Step 74: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "{npc:275666}, um jovem gigante do mar, anda pela costa norte de {zone:1411}, ao norte da praia dos nagas. {npc:275666} é elite: melhor chamar um grupo.",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, de volta em {area:362}",

	-- Step 75: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Escorpídeos Encouraçados rastejam pelas planícies a oeste de {area:362}. Domestique um e volte até {npc:3171}.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "{npc:3171}: {npc:3352}, em {zone:1454}, ensina {spell:5149}",

	-- Step 76: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {npc:3337} Kargal Battlescar · {npc:5810} Uzzek · {area:379} Far Watch Post · {zone:1411} Durotar · {zone:1454} Orgrimmar
	["West from {area:362} over the {area:814} bridge: {npc:3337} and {npc:5810} stand together at {area:379} above it. From there the road north through {zone:1411} leads to {zone:1454}."] = "Para oeste de {area:362} pela ponte de {area:814}: {npc:3337} e {npc:5810} ficam juntos em {area:379}, acima dela. De lá, a estrada para o norte por {zone:1411} leva a {zone:1454}.",

	-- Step 77: Thunder lizards on the way north
	["Thunder lizards on the way north"] = "Lagartos-trovão no caminho para o norte",
	-- {area:369} Thunder Ridge · {zone:1454} Orgrimmar · {item:6486} Singed Scale · {npc:5810} Uzzek · {area:379} Far Watch Post
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, beside the road north to {zone:1454}; any of them can drop a {item:6486}. {npc:5810} takes it when the next guide passes {area:379}."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam em {area:369}, ao lado da estrada ao norte para {zone:1454}; qualquer um pode deixar cair {item:6486}. {npc:5810} o recebe quando o próximo guia passar por {area:379}.",

	-- Step 79: Ormak Grimshot
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor (no name in this language: may be words)
	["Follow the road north from {area:379} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Siga a estrada para o norte de {area:379} até o portão principal de {zone:1454}, logo a oeste da {area:817}. {npc:3352} fica com os instrutores de caçador no {object:172958}.",

	-- Step 80: Hanashi
	-- {npc:2704} Hanashi · {object:172958} Valley of Honor (no name in this language: may be words)
	["While you're here: learn Staves from {npc:2704} ({object:172958}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Cajados com {npc:2704} ({object:172958}, 10 pratas); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 81: To Orgrimmar
	-- {zone:1454} Orgrimmar
	["To {zone:1454}"] = "Até {zone:1454}",
	-- {area:379} Far Watch Post · {zone:1454} Orgrimmar · {quest:829} Neeru Fireblade · {zone:1420} Tirisfal Glades · {zone:1421} Silverpine Forest · {zone:1413} The Barrens
	["Follow the road north from {area:379} to {zone:1454}'s main gate. The next guide starts in {zone:1454}: {quest:829} takes the cultists' quest, the trainers teach your new ranks, and the zeppelin leaves from the towers outside the gate for {zone:1420} and {zone:1421}. {zone:1413} come after Silverpine."] = "Siga a estrada para o norte de {area:379} até o portão principal de {zone:1454}. O próximo guia começa em {zone:1454}: em {quest:829} você pega a missão dos sectários, os instrutores ensinam suas novas habilidades, e o zepelim parte das torres fora do portão para {zone:1420} e {zone:1421}. {zone:1413} vem depois de Pinhaprata.",
	-- {zone:1454} Orgrimmar · {object:172982} Valley of Strength (no name in this language: may be words)
	["{zone:1454}'s {object:172982}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back south to {area:362}."] = "Volte para o sul até {area:362}.",
	-- ["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam no {area:369}, do outro lado da ponte; qualquer um deles pode derrubar uma {item:6486}.",
	-- ["Thunder lizards across the river"] = "Lagartos trovejantes do outro lado do rio",
}
