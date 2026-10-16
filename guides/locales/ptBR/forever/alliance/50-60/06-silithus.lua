-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} e as Terras Pestilentas",

	-- Step 1: Astranaar
	-- {area:392} Ratchet · {area:415} Astranaar
	["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Você começa em {area:392}, para onde o guia anterior mandou você regressar. Voe para {area:415}.",

	-- Step 2: The Emerald Sanctuary
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",
	-- {area:415} Astranaar · {zone:1448} Felwood
	["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Siga para o norte saindo de {area:415} até {zone:1448}, até o acampamento dos druidas na estrada, logo depois da fronteira.",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Espere um pouco por {npc:9116}",
	-- {npc:10924} Ivy Leafrunner · {zone:1452} Winterspring
	["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: termina em {zone:1452}, guarde-a",

	-- Step 3: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Braseiros de {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} é a caverna no fundo de {area:1763}, a oeste da estrada. Use o {item:12906} nos quatro braseiros lá dentro. Mate os Ursos Garraivosos e os Lobos Patavil pelo caminho para obter {item:11172}.",
	["Angerclaw bears and Felpaw wolves"] = "Ursos Garraivosos e Lobos Patavil",

	-- Step 5: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "De volta a {area:1770}: {npc:9861} e {npc:9860} protegem {npc:9517} na câmara mais profunda.",

	-- Step 6: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Siga a estrada para o norte até {area:1767}. Os Pisoteadores de Ferrárbol carregam o coração; termine as garras nos Ursos-cinzentos Garraivosos e nos Assoladores Patavil do norte.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Pisoteadores de Ferrárbol",

	-- Step 7: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} espera em {area:1767}. Escolte-a para fora do bosque e mantenha-a viva.",

	-- Step 8: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Siga para o norte até a aldeia dos furbolgs de Lenha Morta, perto da entrada da caverna de {area:1769}.",
	-- {object:176091} Deadwood Cauldron · {zone:1452} Winterspring
	["{object:176091}, if you found the Firewater flask in {zone:1452}"] = "{object:176091}, se você encontrou o Frasco Vazio de Aguardente em {zone:1452}",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} em {zone:1452}, guarde-a",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, logo na entrada da caverna: só a partir de Neutro com os Presamatos",
	-- {npc:11557} Meilosh · {quest:6031} Runecloth
	["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, se você tiver trinta {quest:6031}",

	-- Step 9: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Volte para o sul pela estrada até o Santuário.",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Guarde o {item:11169}, as garras e o coração que ele devolve",

	-- Step 10: Gadgetzan
	-- {area:392} Ratchet · {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Hearth to {area:392} and fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Regresse para {area:392} e voe para {area:976}. Compre duas Barras de Tório na Casa de Leilões daqui para {quest:5801}.",

	-- Step 11: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Siga para o leste até as colinas. Use o {item:11169} para invocar {quest:4005} e derrote-o para obter o totem.",

	-- Step 12: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Siga para o sudoeste até o acampamento de {npc:7771} em {area:1938}.",

	-- Step 13: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Pegue a estrada para o oeste, desça até a cratera e siga até a {area:540}, a caverna dos silitídeos no sul. {npc:10041} espera na câmara mais profunda.",

	-- Step 14: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Suba {area:537}, no meio da cratera, e use o {item:14644} junto ao lago de lava no topo, com duas Barras de Tório nas bolsas. Encha as Jarras de Amostra Pura Vazias de {npc:9616} nas Gosmas Primevas das poças ao redor da serra.",
	["Use the jars on slain oozes"] = "Use as jarras nas gosmas mortas",

	-- Step 15: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Siga para o norte até {area:541}. Use {npc:10980} ao lado de {npc:10977}.",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, no fundo do refúgio",

	-- Step 16: Into Silithus
	-- {zone:1451} Silithus
	["Into {zone:1451}"] = "Rumo a {zone:1451}",
	-- {zone:1451} Silithus
	["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Siga para o oeste ao longo da parede norte da cratera até o desfiladeiro no canto noroeste, que sobe para {zone:1451}.",
	["Toward the north-west pass"] = "Rumo ao desfiladeiro noroeste",

	-- Step 17: Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Follow the road south-west out of the pass to {area:3425}."] = "Siga a estrada para o sudoeste, saindo do desfiladeiro, até {area:3425}.",
	-- {npc:15174} Calandrath
	["{npc:15174}, the innkeeper"] = "{npc:15174}, o estalajadeiro",
	-- {npc:17082} Rifleman Torrig
	["{npc:17082}, at the Alliance tents"] = "{npc:17082}, nas tendas da Aliança",

	-- Step 18: The Twilight Base Camp
	-- {area:2739} Twilight Base Camp
	["The {area:2739}"] = "{area:2739}",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "A escavação do Martelo do Crepúsculo ocupa o canto noroeste: há fragmentos de tábua no chão, e as Tempestades de Poeira e os Estrondores do Deserto também os carregam. Todo sectário pode deixar cair um {item:20404}: guarde vinte, dez para {npc:15306} e dez para {npc:15194} depois.",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Fragmentos de Tabuleta do Crepúsculo",
	["Twilight's Hammer cultists"] = "Sectários do Martelo do Crepúsculo",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Mais dez para {quest:8323}",

	-- Step 19: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} acampa fora de {area:2743}, a colmeia do oeste. Pegue um Silitista em um dos gêiseres vermelhos próximos e leve-o ao extrator da Aliança no acampamento dele.",

	-- Step 20: Grind to 58
	["Grind to 58"] = "Upe até o 58",
	-- {area:2743} Hive'Zora · {area:3425} Cenarion Hold · {npc:15181} Commander Mar'alith · {quest:8304} Dearest Natalia
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Os Dragasmagas vagueiam pelas dunas entre {area:2743} e {area:3425}, no caminho de volta. {npc:15181} só oferece {quest:8304} a partir do nível 58.",
	-- {npc:11741} Dredge Crusher · {area:2743} Hive'Zora · {zone:1451} Silithus
	["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "farme {npc:11741} nas dunas a leste de {area:2743}, {zone:1451}",

	-- Step 22: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Siga para o leste até as ruínas de {area:2738}. {object:179565} está entre os edifícios em ruínas, vigiado por Sentinelas Torturadas.",

	-- Step 23: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "O eremita se esconde entre as rochas a sudeste de {area:2738}.",

	-- Step 24: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Acampamento Barbabronze",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Siga para o sudoeste até o acampamento dos anões perto das montanhas do sul e interrogue {npc:15171} e {npc:15170}. A Algibeira do {npc:15190} está na areia, logo a sudeste do acampamento.",

	-- Step 25: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} comanda o acampamento dos sectários no extremo sudoeste.",

	-- Step 26: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Siga para o norte pelo lado oeste até o pequeno acampamento da Tutora do Crepúsculo Mayna.",

	-- Step 27: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "O acampamento do Guardião do Crepúsculo Havunth fica logo a oeste de {area:3425}.",

	-- Step 29: Hermit Ortell
	["Ride back south-east to the hermit."] = "Volte para o sudeste até o eremita.",
	["Hand him the ten texts you kept"] = "Entregue a ele os dez textos que você guardou",

	-- Step 31: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "Voe para {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} em {zone:1457}: guarde-a",

	-- Step 32: Forest Song
	-- {area:3137} Talrendis Point · {zone:1447} Azshara · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Voe para {area:3137} em {zone:1447} e siga para o oeste pela estrada até {area:2358}, logo depois da fronteira de {zone:1440}.",

	-- Step 33: Everlook
	-- {area:3137} Talrendis Point · {area:2255} Everlook
	["Ride back to {area:3137} and fly to {area:2255}."] = "Volte para {area:3137} e voe para {area:2255}.",

	-- Step 34: Ranshalla
	-- {area:2250} Owl Wing Thicket · {npc:10300} Ranshalla · {object:177404} Altar of Elune (no name in this language: may be words)
	["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Siga para o sul até {area:2250}. Proteja {npc:10300} enquanto ela acende as tochas a caminho de {object:177404}.",

	-- Step 35: Dire Maul (optional)
	-- {area:2577} Dire Maul
	["{area:2577} (optional)"] = "{area:2577} (opcional)",
	-- {area:2577} Dire Maul · {zone:1444} Feralas
	["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Fazer {area:2577} em {zone:1444} em vez de farmar leva você lá mais rápido em grupo. Pule esta etapa para farmar sozinho.",
	-- {area:2577} Dire Maul · {npc:7446} Rabid Shardtooth
	["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} é para os níveis 55 a 60; farmar {npc:7446}, abaixo, leva você ao 59 sozinho.",

	-- Step 36: Grind to 59
	["Grind to 59"] = "Upe até o 59",
	-- {npc:7446} Rabid Shardtooth · {area:2250} Owl Wing Thicket
	["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Os ursos {npc:7446} vagueiam pelo vale nevado ao sul de {area:2250}.",
	-- {npc:7446} Rabid Shardtooth · {area:2250} Owl Wing Thicket · {zone:1452} Winterspring
	["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "farme {npc:7446} no vale ao sul de {area:2250}, {zone:1452}",

	-- Step 37: Starfall Village
	-- {area:2255} Everlook
	["Ride back north to {area:2255} and west along the road to the night elf village."] = "Volte para o norte até {area:2255} e siga para o oeste pela estrada até a aldeia dos elfos noturnos.",

	-- Step 38: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Continue para o oeste pela estrada até o acampamento de {npc:9298}, ao lado das fontes termais.",

	-- Step 39: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Pegue o túnel de {area:1769} pela entrada de {zone:1452}, a oeste de {npc:9298}, e siga o ramal de {area:493} até {area:2361}. {npc:11939} estuda à beira do lago.",

	-- Step 40: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "A casa de {npc:11801} fica em {area:2361}, a leste de {npc:11939}.",

	-- Step 42: Nighthaven
	-- {area:2361} Nighthaven · {area:442} Auberdine
	["Take the flight path in {area:2361} and fly to {area:442}."] = "Pegue a rota de voo em {area:2361} e voe para {area:442}.",

	-- Step 43: Rut'theran Village
	-- {area:442} Auberdine · {area:702} Rut'theran Village
	["Take the boat from {area:442} to {area:702}."] = "Pegue o barco de {area:442} para {area:702}.",

	-- Step 44: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Pegue o portal para subir até {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, no Templo da Lua",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, no banco",
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, no alto de {area:1658}",

	-- Step 45: Stormwind
	-- {area:702} Rut'theran Village · {area:442} Auberdine · {area:17203} Stormwind Harbor · {item:14047} Runecloth · {npc:14722} Clavicus Knavingham
	["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Desça de volta até {area:702}, pegue o barco para {area:442} e depois o barco até {area:17203}. Leve sessenta Sedas, sessenta Magitramas e sessenta {item:14047} para {npc:14722}: compre o que faltar na Casa de Leilões.",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District (no name in this language: may be words)
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, em {object:2096}",

	-- Step 46: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Pegue o {area:2257} para {zone:1455}. {npc:14724} e {npc:14723} querem, cada um, sessenta Lãs, sessenta Sedas e sessenta Magitramas, e depois sessenta {item:14047}: 120 de cada no total, das suas bolsas ou da Casa de Leilões.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} não tem instrutor de xamã",

	-- Step 47: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} é um elite de nível 61",

	-- Step 48: Andorhal
	["Andorhal"] = "Ruínas de Andorhal",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} espera na estalagem em ruínas no lado oeste das Ruínas de Andorhal, a cidade em ruínas ao norte do acampamento. {npc:1852} protege o filactério dele no meio da cidade.",
	["Araj is elite: grouping up is advised."] = "Araj, o Evocador, é elite: recomenda-se formar um grupo.",

	-- Step 49: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "O fantasma de {npc:10778} vagueia perto da casa da fazenda de {area:199}, a oeste das Ruínas de Andorhal. Os Carniçais Grasnantes do campo carregam a outra metade do amuleto: junte as duas metades.",

	-- Step 50: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Siga a estrada para o norte até a serraria e coloque o barril de cupins no meio dela.",

	-- Step 51: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (opcional)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} Fordring vive numa pequena cabana à beira do rio da fronteira, a nordeste da madeireira. Entregue {quest:5781} se você a concluiu.",

	-- Step 52: Scholomance (optional)
	-- {area:2057} Scholomance
	["{area:2057} (optional)"] = "{area:2057} (opcional)",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {zone:1422} Western Plaguelands · {area:2279} Stratholme
	["Running {area:2057} ({area:2298}, south-east {zone:1422}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Fazer {area:2057} ({area:2298}, sudeste de {zone:1422}) ou {area:2279} em vez de farmar leva você lá mais rápido em grupo. Pule esta etapa para farmar sozinho.",
	-- {area:2057} Scholomance · {quest:5505} The Key to Scholomance · {area:3197} Chillwind Camp
	["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} é para os níveis 58 a 60; {quest:5505} é entregue em {area:3197}, abaixo.",

	-- Step 53: Grind to 60
	["Grind to 60"] = "Upe até o 60",
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Atravesse o rio a leste de {npc:1855} até {area:2627}. Os Espíritos da Várzea do Medo assombram o bosque ali.",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "farme {npc:14564} em {area:2627}, {zone:1423}",

	-- Step 54: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Volte para o sudoeste até {area:3197}.",

	-- Step 55: Level 60
	["Level 60"] = "Nível 60",
	-- {area:1519} Stormwind
	["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Regresse para {area:1519} e treine seus feitiços de nível 60. Este é o fim da rota de evolução: veja depois os guias de reputação e de masmorras.",

	-- Step 56: Shaman training
	["Shaman training"] = "Treinamento de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District (no name in this language: may be words) · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} de {object:28027} para {zone:1455} e treine seus feitiços de nível 60 com {npc:258098}.",
}
