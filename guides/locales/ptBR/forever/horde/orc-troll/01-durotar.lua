-- Portuguese (Brazil) (ptBR): the guide forever/horde/orc-troll/01-durotar (forever/horde/orc-troll/01-durotar.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kaltunk
	-- {npc:10176} Kaltunk
	["{npc:10176}, where you start"] = "{npc:10176}, onde você começa",

	-- Step 2: Gornek
	-- {npc:3143} Gornek · {npc:10176} Kaltunk
	["{npc:3143} waits inside the Den, the building just west of {npc:10176}."] = "{npc:3143} espera dentro d'O Covil, a construção logo a oeste de {npc:10176}.",

	-- Step 3: Training weapons and boars
	["Training weapons and boars"] = "Armas de treino e javalis",
	-- plural, as words: Mottled Boars = {npc:3098} Mottled Boar
	["The weapons lie around the Den and the training grounds; the Mottled Boars roam the whole valley floor."] = "As armas ficam em volta d'O Covil e do campo de treino; os Mosquetuscos vagam por todo o fundo do vale.",

	-- Step 4: The Den
	-- {npc:3143} Gornek · {npc:3159} Kzan Thornslash
	["{npc:3143} stands just inside the cave mouth; {npc:3159} at the back of the cave behind him."] = "{npc:3143} fica logo na entrada da caverna; {npc:3159}, no fundo da caverna, atrás dele.",
	-- {npc:3159} Kzan Thornslash
	["{npc:3159}, at the back of the cave"] = "{npc:3159}, no fundo da caverna",
	-- {npc:3156} Nartok
	["{npc:3156}, the warlock trainer at the back of the cave"] = "{npc:3156}, o instrutor de bruxo no fundo da caverna",
	-- {npc:3155} Rwag
	["{npc:3155}, the rogue trainer in the Den"] = "{npc:3155}, o instrutor de ladino n'O Covil",
	-- {npc:3153} Frang
	["{npc:3153}, the warrior trainer beside the Den"] = "{npc:3153}, o instrutor de guerreiro ao lado d'O Covil",
	-- {npc:3154} Jen'shan
	["{npc:3154}, the hunter trainer beside the Den"] = "{npc:3154}, o instrutor de caçador ao lado d'O Covil",
	-- {npc:3707} Ken'jai
	["{npc:3707}, the priest trainer at the Den"] = "{npc:3707}, o instrutor de sacerdote n'O Covil",
	-- {npc:3157} Shikrik
	["{npc:3157}, the shaman trainer beside the Den"] = "{npc:3157}, o instrutor de xamã ao lado d'O Covil",
	-- {npc:5884} Mai'ah
	["{npc:5884}, the mage trainer, at the entrance to the Den"] = "{npc:5884}, a instrutora de mago, na entrada d'O Covil",
	-- {npc:9796} Galgar
	["{npc:9796}, by the cooking fire"] = "{npc:9796}, junto à fogueira de cozinhar",

	-- Step 5: Hana'zua
	-- {npc:3287} Hana'zua
	["{npc:3287} lies wounded at the foot of the hills north-west of the Den."] = "{npc:3287} está ferido no sopé das colinas a noroeste d'O Covil.",

	-- Step 6: Sarkoth
	-- {quest:790} Sarkoth · {npc:3287} Hana'zua
	-- plural, as words: Scorpid Workers = {npc:3124} Scorpid Worker · Cactus Apples = {item:11583} Cactus Apple
	["{quest:790}, a large scorpid, prowls the slope south of {npc:3287} among the Scorpid Workers; pick the Cactus Apples by the cactuses on the way."] = "{quest:790}, um escorpídeo grande, ronda a encosta ao sul de {npc:3287} entre os Escorpídeos Operários; colha as Sabras dos cactos no caminho.",

	-- Step 8: Back to the Den
	["Back to the Den"] = "De volta ao Covil",

	-- Step 9: Foreman Thazz'ril
	["The foreman stands at the lumber pile east of the Den."] = "O capataz fica na pilha de madeira a leste d'O Covil.",

	-- Step 10: Lazy Peons
	-- {item:16114} Foreman's Blackjack
	["Hit the sleeping peons north of the Den with the {item:16114}."] = "Bata nos peões que dormem ao norte d'O Covil com o {item:16114}.",
	-- {quest:5441} Lazy Peons · {item:16114} Foreman's Blackjack
	["Wake {quest:5441} with the {item:16114}"] = "Acorde os {quest:5441} com o {item:16114}",

	-- Step 12: North end of the valley
	["North end of the valley"] = "Extremo norte do vale",
	-- {quest:792} Vile Familiars · {area:365} Burning Blade Coven
	["The {quest:792} swarm the slope below the {area:365}, the cave on the valley's north side."] = "Os {quest:792} infestam a encosta abaixo do {area:365}, a caverna no lado norte do vale.",

	-- Step 13: Thazz'ril's Pick
	["Inside the cave, go straight on at the first split, then right and follow the stream on your left to the waterfall: the pick glows by the water, behind a column of rock."] = "Dentro da caverna, siga reto na primeira bifurcação, depois à direita, e acompanhe o riacho à sua esquerda até a cachoeira: a picareta brilha junto à água, atrás de uma coluna de pedra.",

	-- Step 14: Back at the Den
	["Back at the Den"] = "De volta ao Covil",

	-- Step 15: Canaga Earthcaller
	-- {npc:5887} Canaga Earthcaller
	["{npc:5887} stands just outside the Den."] = "{npc:5887} fica logo do lado de fora d'O Covil.",

	-- Step 17: Yarrog Baneshadow
	-- {npc:3183} Yarrog Baneshadow
	["Inside the cave, keep to the right wall all the way round, over the stream: {npc:3183} waits at the end."] = "Dentro da caverna, mantenha-se rente à parede da direita a volta toda, passando o riacho: {npc:3183} espera no fim.",

	-- Step 18: Felstalker hooves
	-- {npc:3102} Felstalker
	["{npc:3102} hooves"] = "Cascos de {npc:3102}",
	-- plural, as words: Felstalkers = {npc:3102} Felstalker
	["Felstalkers roam the slope below the cave, on the valley's north side."] = "Os Espreitadores Vis vagam pela encosta abaixo da caverna, no lado norte do vale.",

	-- Step 19: Zureetha Fargaze
	-- {object:654925} Lost Journal
	["the {object:654925} on the ground beside her"] = "o {object:654925} no chão ao lado dela",

	-- Step 20: Call of Earth
	-- {npc:5887} Canaga Earthcaller · {area:639} Spirit Rock · {item:6635} Earth Sapta · {npc:5891} Minor Manifestation of Earth · {item:6656} Rough Quartz
	["{npc:5887} stands outside the Den. {area:639} is the hill just south of it: drink the {item:6635} there to see the {npc:5891}, then take the {item:6656} back to {npc:5887}."] = "{npc:5887} fica do lado de fora d'O Covil. {area:639} é a colina logo ao sul: beba a {item:6635} lá para ver a {npc:5891}, depois leve o {item:6656} de volta para {npc:5887}.",
	-- {npc:5891} Minor Manifestation of Earth · {area:639} Spirit Rock
	["{npc:5891}, on {area:639}"] = "{npc:5891}, na {area:639}",
	-- {npc:5887} Canaga Earthcaller · {npc:5873} Stoneskin Totem · {item:5175} Earth Totem
	["{npc:5887}: {npc:5873} and your {item:5175}"] = "{npc:5887}: {npc:5873} e o seu {item:5175}",

	-- Step 21: Ukor
	-- {npc:6786} Ukor
	["{npc:6786} stands on the road at the valley's eastern exit."] = "{npc:6786} fica na estrada, na saída leste do vale.",

	-- Step 22: Sen'jin Village
	-- {area:367} Sen'jin Village
	["Follow the road east out of the valley to {area:367} on the coast."] = "Siga a estrada para leste saindo do vale até a {area:367}, na costa.",

	-- Step 23: Ridgeshade spiders
	["Ridgeshade spiders"] = "Aranhas Crista-sombra",
	-- {area:362} Razor Hill
	["The spiders lurk in the hills along the road north toward {area:362}."] = "As aranhas espreitam nas colinas ao longo da estrada para o norte, rumo a {area:362}.",

	-- Step 24: Brakk's campfire
	-- {npc:265809} Brakk
	["{npc:265809}'s campfire"] = "A fogueira de {npc:265809}",
	-- {npc:265809} Brakk · {area:362} Razor Hill · {spell:1229451} Boosted Rest
	["{npc:265809} camps just south of {area:362}. Sit by his campfire (/sit) until the {spell:1229451} buff appears."] = "{npc:265809} acampa logo ao sul de {area:362}. Sente-se junto à fogueira dele (/sit) até aparecer o bônus {spell:1229451}.",

	-- Step 25: Razor Hill
	-- {npc:266940} Turroc
	["{npc:266940}, on the east side of town"] = "{npc:266940}, no lado leste da cidade",
	-- {npc:3191} Cook Torka
	["Talk to {npc:3191}"] = "Fale com {npc:3191}",
	-- {npc:3147} Furl Scornbrow
	["{npc:3147}, in the watchtower"] = "{npc:3147}, na torre de vigia",

	-- Step 26: Prickly pears
	["Prickly pears"] = "Figos-da-índia",
	["The prickly pears grow among the quilboar huts just west of town."] = "Os figos-da-índia crescem entre as cabanas dos javatuscos logo a oeste da cidade.",

	-- Step 28: Razormane Grounds
	["Quilboars and scouts hold the huts west of town; dustrunners and battleguards hold the camps farther west."] = "Javatuscos e batedores ocupam as cabanas a oeste da cidade; levanta-poeiras e guardas de batalha ocupam os acampamentos mais a oeste.",

	-- Step 30: Tiragarde Keep
	-- {area:362} Razor Hill · {item:4870} Canvas Scraps · {npc:3192} Lieutenant Benedict · {item:4881} Aged Envelope
	["The keep stands on the coast south-east of {area:362}. The raiders' axe, bow and shield lie on its outskirts. Sailors and marines drop the {item:4870}. {npc:3192} waits at the top of the keep; his key opens the chest beside him, which holds the {item:4881}."] = "A fortaleza fica na costa a sudeste de {area:362}. O machado, o arco e o escudo dos saqueadores estão nos arredores dela. Marinheiros e fuzileiros derrubam os {item:4870}. {npc:3192} espera no alto da fortaleza; a chave dele abre o baú ao seu lado, que guarda o {item:4881}.",

	-- Step 32: Rezlak
	-- {zone:1454} Orgrimmar · {npc:3293} Rezlak
	["Follow the road north toward {zone:1454}. {npc:3293} camps beside it; the stolen sacks lie along the road south of him."] = "Siga a estrada para o norte rumo a {zone:1454}. {npc:3293} acampa ao lado dela; os sacos roubados estão ao longo da estrada ao sul dele.",

	-- Step 33: Drygulch Ravine
	-- {area:370} Drygulch Ravine · {npc:3293} Rezlak · {item:277661} Dull Storm Orb
	["Savages and Storm Witches nest in {area:370}, east of {npc:3293}. A Storm Witch drops the {item:277661}."] = "Selvagens e Bruxas da Tempestade se abrigam na {area:370}, a leste de {npc:3293}. Uma Bruxa da Tempestade derruba o {item:277661}.",

	-- Step 35: Thunder lizards
	["Thunder lizards"] = "Lagartos trovejantes",
	-- {area:369} Thunder Ridge · {npc:3293} Rezlak
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369}, just west and south-west of {npc:3293}."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam no {area:369}, logo a oeste e sudoeste de {npc:3293}.",

	-- Step 37: Misha Tor'kren
	-- {area:814} Southfury River · {item:4891} Kron's Amulet
	["Misha's hut stands south of the lizards. The crocolisks along the {area:814} to the west carry {item:4891}."] = "A cabana de Misha fica ao sul dos lagartos. Os crocoliscos ao longo do {area:814}, a oeste, carregam o {item:4891}.",

	-- Step 38: The wreckage
	["The wreckage"] = "Os destroços",
	-- {area:362} Razor Hill
	["The gnomish toolboxes lie in the wreckage along the shore east and south-east of {area:362}. Follow the shore south to Sen'jin."] = "As caixas de ferramentas gnômicas estão nos destroços ao longo da praia a leste e sudeste de {area:362}. Siga a praia para o sul até Sen'jin.",

	-- Step 39: Sen'jin Village
	-- {npc:266881} Pa'zula
	-- plural, as words: Hexed Pendants = {item:275724} Hexed Pendant
	["{npc:266881}: enchanters only, the residue is disenchanted from Hexed Pendants"] = "{npc:266881}: só encantadores, o resíduo vem do desencantamento de Pingentes Bagateados",

	-- Step 40: Makrura and crawlers
	["Makrura and crawlers"] = "Makruras e surfatiscos",
	["Makrura and surf crawlers line the beaches north-east of Sen'jin."] = "Makruras e surfatiscos ocupam as praias a nordeste de Sen'jin.",

	-- Step 41: Bloodtalon Matriarch
	["Wade across to the northern Echo Isle. The Matriarch prowls among the raptors there."] = "Atravesse a água até a ilha mais ao norte das Ilhas do Eco. A Matriarca ronda entre os raptores de lá.",

	-- Step 42: Echo Isles
	-- {quest:826} Zalazane
	-- plural, as words: Hexed Trolls = {npc:3207} Hexed Troll · Hexed Pendants = {item:275724} Hexed Pendant
	["Head south through the isles. The Loa idols lie all over the southern isles; Voodoo and Hexed Trolls hold them and drop the Hexed Pendants. {quest:826} and Minshina's cage are on the southernmost isle."] = "Siga para o sul pelas ilhas. Os ídolos Loa estão espalhados pelas ilhas do sul; Trolls Vodu e Trolls Bagateados os guardam e derrubam os Pingentes Bagateados. {quest:826} e a jaula de Minshina ficam na ilha mais ao sul.",

	-- Step 43: South-east shore
	["South-east shore"] = "Costa sudeste",
	-- plural, as words: Durotar Tigers = {npc:3121} Durotar Tiger
	["Wade back west to the shore south of Sen'jin. Durotar Tigers roam it and the Taillasher eggs sit in nests along the beach."] = "Volte pela água para oeste até a praia ao sul da Aldeia Sen'jin. Tigres de Durotar vagam por lá, e os ovos de Açoitacauda ficam em ninhos ao longo da praia.",

	-- Step 45: Kolkar Crag
	-- {area:366} Kolkar Crag · {npc:275811} Pal'juh
	["{area:366} lies west of Sen'jin. The three attack plans sit on the ground among the centaur tents. {npc:275811} is held at the crag as well."] = "O {area:366} fica a oeste de Sen'jin. Os três planos de ataque estão no chão entre as tendas dos centauros. {npc:275811} também está presa no penedo.",
	-- {npc:275811} Pal'juh
	["Free {npc:275811} and see her safely out of the crag"] = "Liberte {npc:275811} e leve-a em segurança para fora do penedo",

	-- Step 47: Razor Hill
	-- {area:362} Razor Hill
	["Follow the road north to {area:362}."] = "Siga a estrada para o norte até {area:362}.",
	-- {npc:3294} Ophek
	["{npc:3294}, by the inn"] = "{npc:3294}, junto à estalagem",
	-- {npc:3706} Tai'jin · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar
	["{npc:3706}, for {npc:6018} in {zone:1454}: keep it"] = "{npc:3706}, para {npc:6018} em {zone:1454}: guarde-a",

	-- Step 48: Fizzle Darkstorm
	-- {area:369} Thunder Ridge · {area:362} Razor Hill · {npc:3099} Dire Mottled Boar · {item:15908} Taming Rod
	["Fizzle holds the Burning Blade camp on {area:369}, north-west of {area:362}. Hunters: tame a {npc:3099} with the {item:15908} on the way."] = "Bulho ocupa o acampamento de Lâmina Ardente em {area:369}, a noroeste de {area:362}. Caçadores: domestiquem um {npc:3099} com o {item:15908} no caminho.",
	-- {item:15908} Taming Rod
	["Tame it with the {item:15908}"] = "Domestique-o com a {item:15908}",

	-- Step 50: Heglan Shadeeye
	-- {npc:275657} Heglan Shadeeye · {area:362} Razor Hill
	["{npc:275657} stands on the shore east of {area:362}. The trident, banner and dagger lie on the beach around him."] = "{npc:275657} fica na praia a leste de {area:362}. O tridente, o estandarte e a adaga estão na areia em volta dele.",

	-- Step 51: Margoz
	-- {quest:828} Margoz · {quest:827} Skull Rock
	["{quest:828} camps on the hill west of the naga beach, south of {quest:827}."] = "{quest:828} acampa na colina a oeste da praia dos nagas, ao sul da {quest:827}.",

	-- Step 52: Gan'rul Bloodeye
	-- {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words)
	["{zone:1454}'s main gate is just west of {area:817}. {npc:5875} stands in the {object:172960}, the canyon under the {object:172982}."] = "O portão principal de {zone:1454} fica logo a oeste da {area:817}. {npc:5875} fica na {object:172960}, o cânion abaixo do {object:172982}.",

	-- Step 53: Skull Rock's mouth
	-- {area:817} Skull Rock
	["{area:817}'s mouth"] = "Entrada da {area:817}",

	-- Step 54: Skull Rock
	-- {quest:827} Skull Rock · {item:4871} Searing Collar · {npc:3204} Gazz'uz · {item:4903} Eye of Burning Shadow
	["Burning Blade cultists hold the caves of {quest:827}; any of them drops a {item:4871}. {npc:3204}, a level 14 warlock, stands deep inside and drops the {item:4903}."] = "Sectários de Lâmina Ardente ocupam as cavernas de {quest:827}; qualquer um deles deixa cair um {item:4871}. {npc:3204}, um bruxo de nível 14, fica no fundo e deixa cair o {item:4903}.",

	-- Step 55: Tablet of Verga
	-- {object:58595} Burning Blade Stash · {area:817} Skull Rock
	["The {object:58595} stands in {area:817}, among the cultists you just fought."] = "O {object:58595} fica na {area:817}, entre os sectários que você acabou de enfrentar.",

	-- Step 56: The Binding
	-- {npc:5875} Gan'rul Bloodeye · {object:172960} Cleft of Shadow (no name in this language: may be words) · {item:7464} Glyphs of Summoning
	["Back to {npc:5875} in the {object:172960}. Use the {item:7464} on the summoning circle there and defeat the voidwalker to bind it."] = "Volte até {npc:5875} na {object:172960}. Use os {item:7464} no círculo de evocação de lá e derrote o emissário do caos para prendê-lo.",

	-- Step 58: Razor Hill
	-- {area:362} Razor Hill
	["Back south to {area:362}."] = "Volte para o sul até {area:362}.",

	-- Step 59: Spitelash naga
	["Spitelash naga"] = "Nagas Iralisca",
	-- {npc:275657} Heglan Shadeeye · {area:370} Drygulch Ravine · {npc:3107} Surf Crawler
	-- plural, as words: Spitelash Scouts = {npc:275662} Spitelash Scout
	["Back east to the shore north of {npc:275657}. Spitelash Scouts and Attendants hold the beach below {area:370}. Hunters: tame a {npc:3107} on the beach."] = "Volte para leste até a praia ao norte de {npc:275657}. Batedores Iralisca e Serviçais Iralisca ocupam a praia abaixo da {area:370}. Caçadores: domestiquem um {npc:3107} na praia.",

	-- Step 60: Razor Hill
	-- {area:362} Razor Hill
	["Back to {area:362}."] = "De volta a {area:362}.",
	-- {npc:3142} Orgnil Soulscar · {npc:275666} Aggor the Young
	["{npc:3142}: {npc:275666}, an elite sea giant"] = "{npc:3142}: {npc:275666}, um gigante do mar elite",

	-- Step 61: Aggor the Young
	-- {npc:275666} Aggor the Young · {zone:1411} Durotar
	["{npc:275666}, a young sea giant, walks {zone:1411}'s north coast, north of the naga beach. {npc:275666} is elite: grouping up is advised."] = "{npc:275666}, um jovem gigante do mar, anda pela costa norte de {zone:1411}, ao norte da praia dos nagas. {npc:275666} é elite: é recomendável formar grupo.",
	-- {npc:3142} Orgnil Soulscar · {area:362} Razor Hill
	["{npc:3142}, back in {area:362}"] = "{npc:3142}, de volta em {area:362}",

	-- Step 62: Armored Scorpid
	-- {area:362} Razor Hill · {npc:3171} Thotar
	-- plural, as words: Armored Scorpids = {npc:3126} Armored Scorpid
	["Armored Scorpids crawl over the plains west of {area:362}. Tame one, then return to {npc:3171}."] = "Escorpídeos Encouraçados rastejam pelas planícies a oeste de {area:362}. Domestique um e volte até {npc:3171}.",
	-- {npc:3171} Thotar · {npc:3352} Ormak Grimshot · {zone:1454} Orgrimmar · {spell:5149} Beast Training
	["{npc:3171}: {npc:3352} in {zone:1454} teaches {spell:5149}"] = "{npc:3171}: {npc:3352}, em {zone:1454}, ensina {spell:5149}",

	-- Step 63: Ormak Grimshot
	-- {area:362} Razor Hill · {zone:1454} Orgrimmar · {area:817} Skull Rock · {npc:3352} Ormak Grimshot · {object:172958} Valley of Honor (no name in this language: may be words)
	["Follow the road north from {area:362} to {zone:1454}'s main gate, just west of {area:817}. {npc:3352} stands with the hunter trainers in the {object:172958}."] = "Siga a estrada para o norte de {area:362} até o portão principal de {zone:1454}, logo a oeste da {area:817}. {npc:3352} fica com os instrutores de caçador no {object:172958}.",

	-- Step 64: Far Watch Post
	-- {area:362} Razor Hill · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} Barrens
	["Follow the road west from {area:362} over the {area:814} bridge; {area:379} sits just above it on the {zone:1413} side."] = "Siga a estrada para oeste de {area:362} pela ponte do {area:814}; o {area:379} fica logo acima, do lado de {zone:1413}.",

	-- Step 65: Thunder lizards across the river
	["Thunder lizards across the river"] = "Lagartos trovejantes do outro lado do rio",
	-- {area:369} Thunder Ridge · {item:6486} Singed Scale
	-- plural, as words: Thunder Lizards = {npc:3130} Thunder Lizard · Lightning Hides = {npc:3131} Lightning Hide
	["Thunder Lizards and Lightning Hides graze on {area:369} across the bridge; any of them can drop a {item:6486}."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam no {area:369}, do outro lado da ponte; qualquer um deles pode derrubar uma {item:6486}.",

	-- Step 67: The Crossroads
	-- {area:379} Far Watch Post · {area:380} The Crossroads · {zone:1413} Barrens
	["Follow the road south-west from {area:379} to the {area:380}. {zone:1413} guide starts here."] = "Siga a estrada para sudoeste do {area:379} até a {area:380}. O guia de {zone:1413} começa aqui.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{area:364}'s cave mouth"] = "Entrada da caverna de {area:364}",
}
