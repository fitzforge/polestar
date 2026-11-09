-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/06-silithus (forever/alliance/50-60/06-silithus.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1451} Silithus · {zone:1448} Felwood · {zone:1452} Winterspring
	["{zone:1451}, {zone:1448}, {zone:1452} & the Plaguelands"] = "{zone:1451}, {zone:1448}, {zone:1452} e as Terras Pestilentas",

	-- Step 1: To Ratchet
	-- {area:392} Ratchet
	["To {area:392}"] = "Para {area:392}",

	-- Step 2: Fly to Talrendis Point
	-- {area:3137} Talrendis Point
	["Fly to {area:3137}"] = "Voe para {area:3137}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 3: Felwood
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 4: The Emerald Sanctuary
	-- {area:3137} Talrendis Point · {zone:1448} Felwood · {area:2479} Emerald Sanctuary · {zone:1440} Ashenvale
	["From {area:3137} ride into {zone:1448}: the {area:2479} is the druids' camp on the road just past the {zone:1440} border."] = "De {area:3137}, siga para {zone:1448}: {area:2479} é o acampamento dos druidas na estrada, logo depois da divisa com {zone:1440}.",
	["Inside"] = "Lá dentro",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Espere um pouco por {npc:9116}",

	-- Step 5: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Braseiros de {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:11172} Silvery Claws · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "{area:1770} é a caverna no fundo de {area:1763}, a oeste da estrada. Use {item:12906} nos quatro braseiros lá dentro. Mate os ursos Garraivosos e os lobos Patavil que encontrar pelo caminho para pegar {item:11172}.\nCuidado: monstros do Conselho das Sombras de nível 53-55 enchem a caverna e costumam vir em grandes grupos ligados, muitos com atordoamentos. Recomenda-se um grupo de 2-3 jogadores.\nOs Tecetrevas, Bruxos e Impositores de Jaedenar daqui soltam {item:13140}, cerca de uma morte em trinta: continue matando-os até soltar. Ela abre a cela de {npc:11018}, o elfo da noite preso na caverna.",
	["Angerclaw bears and Felpaw wolves"] = "Ursos Garraivosos e Lobos Patavil",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "{object:176159}, no subterrâneo",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}, no subterrâneo",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}, no subterrâneo",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}, no subterrâneo",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}, na cela dela; no subterrâneo",

	-- Step 6: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "Leve-a para fora de {area:1770} e mantenha-a viva até ela estar fora da caverna: limpe antes o caminho de volta.",

	-- Step 8: Irontree Woods
	-- {area:1767} Irontree Woods
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper · Felpaw Ravagers = {npc:8961} Felpaw Ravager
	["Follow the road north to {area:1767}. The Irontree Stompers carry the heart; finish the claws on the Angerclaw Grizzlies and Felpaw Ravagers of the north."] = "Siga a estrada para o norte até {area:1767}. Os Pisoteadores de Ferrárbol carregam o coração; termine as garras nos Ursos-cinzentos Garraivosos e nos Assoladores Patavil do norte.",
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["Irontree Stompers"] = "Pisoteadores de Ferrárbol",

	-- Step 9: Arei
	-- {npc:9598} Arei · {area:1767} Irontree Woods · {quest:5086} Toxic Horrors
	["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive.\nCareful: Three {quest:5086} ambush you soon after the escort starts."] = "{npc:9598} espera em {area:1767}. Escolte-a para fora da mata e mantenha-a viva.\nCuidado: três {quest:5086} emboscam vocês logo depois que a escolta começa.",

	-- Step 10: Felpaw Village
	-- {area:1769} Timbermaw Hold
	["Ride north to the Deadwood furbolgs' village by the {area:1769} cave mouth."] = "Siga para o norte até a aldeia dos furbolgs de Lenha Morta, perto da entrada da caverna de {area:1769}.",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298} in {zone:1452}, keep it"] = "{quest:5085}: {npc:9298} em {zone:1452}, guarde-a",

	-- Step 11: A Final Blow
	-- {area:1770} Shadow Hold · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {npc:9518} Rakaiah
	["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber. The succubus {npc:9518} waits on the way, with Trey Lightforge's remains beside her.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "De volta a {area:1770}: {npc:9861} e {npc:9860} guardam {npc:9517} na câmara mais funda. A súcubo {npc:9518} espera no caminho, com os restos mortais de Trey Forjaleve ao lado dela.\nCuidado: os três chefes lutam juntos. Mate os monstros por perto antes para não puxar inimigo a mais.",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}, no subterrâneo",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}, no subterrâneo",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}, no subterrâneo",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}, no subterrâneo",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517}; no subterrâneo",

	-- Step 12: The Emerald Sanctuary
	["Ride back south along the road to the Sanctuary."] = "Volte para o sul pela estrada até o Santuário.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, lá dentro",
	-- {item:11169} Book of Aquor
	["Keep the {item:11169}, the claws and the heart he hands back"] = "Guarde o {item:11169}, as garras e o coração que ele devolve",

	-- Step 14: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Voar para {area:976}",
	-- {area:3137} Talrendis Point
	["{area:3137} flight master"] = "Mestre de voo de {area:3137}",

	-- Step 15: Gadgetzan
	-- {area:976} Gadgetzan · {quest:5801} Fire Plume Forged
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar
	["Fly to {area:976}. Buy two Thorium Bars at the Auction House here for {quest:5801}."] = "Voe para {area:976}. Compre duas Barras de Tório na Casa de Leilões daqui para {quest:5801}.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, lá dentro",

	-- Step 16: Aquementas
	-- {item:11169} Book of Aquor · {quest:4005} Aquementas
	["Ride east into the hills. Use the {item:11169} to summon {quest:4005}, then defeat him for the totem."] = "Siga para o leste até as colinas. Use o {item:11169} para invocar {quest:4005} e derrote-o para obter o totem.",

	-- Step 17: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Siga para o sudoeste até o acampamento de {npc:7771} em {area:1938}.",

	-- Step 19: The Slithering Scar
	-- {area:540} The Slithering Scar · {npc:10041} Gorishi Hive Queen
	["Take the road west down into the crater and ride to the {area:540}, the silithid cave in the south. The {npc:10041} waits in its deepest chamber."] = "Pegue a estrada para o oeste, desça até a cratera e siga até a {area:540}, a caverna dos silitídeos no sul. {npc:10041} espera na câmara mais profunda.",

	-- Step 20: Fire Plume Ridge
	-- {area:537} Fire Plume Ridge · {item:14644} Skeleton Key Mold · {npc:9616} Laris Geardawdle
	-- plural, as words: Thorium Bars = {item:12359} Thorium Bar · Empty Pure Sample Jars = {item:11953} Empty Pure Sample Jar · Primal Oozes = {npc:6557} Primal Ooze
	["Climb {area:537} in the middle of the crater and use the {item:14644} by the lava lake at the top, with two Thorium Bars in your bags. Fill {npc:9616}'s Empty Pure Sample Jars on the Primal Oozes in the pools around the ridge."] = "Suba {area:537}, no meio da cratera, e use o {item:14644} junto ao lago de lava no topo, com duas Barras de Tório nas bolsas. Encha as Jarras de Amostra Pura Vazias de {npc:9616} nas Gosmas Primevas das poças ao redor da serra.",
	["Use the jars on slain oozes"] = "Use as jarras nas gosmas mortas",

	-- Step 21: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {npc:10980} Umi's Mechanical Yeti · {npc:10977} Quixxil
	["Ride north to {area:541}. Use {npc:10980} beside {npc:10977}."] = "Siga para o norte até {area:541}. Use {npc:10980} ao lado de {npc:10977}.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, no subterrâneo",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, no fundo do refúgio",
	-- {npc:10977} Quixxil · {npc:10980} Umi's Mechanical Yeti
	["Scare {npc:10977} with {npc:10980}"] = "",

	-- Step 22: Fly to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Fly to {area:3425}"] = "Voe para {area:3425}",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Mestre de voo de {area:541}",

	-- Step 23: Cenarion Hold
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- {npc:15190} Noggle Ficklespragg · {npc:15189} Beetix Ficklespragg
	["{npc:15190}, upstairs beside {npc:15189}"] = "{npc:15190}, no andar de cima, ao lado de {npc:15189}",

	-- Step 24: Hive'Ashi: kill these as you meet them
	-- {area:2742} Hive'Ashi
	["{area:2742}: kill these as you meet them"] = "{area:2742}: vá matando estes pelo caminho",
	-- {item:20404} Encrypted Twilight Text · {npc:15306} Bor Wildmane · {npc:15194} Hermit Ortell
	-- plural, as words: Dust Stormers = {npc:11744} Dust Stormer · Desert Rumblers = {npc:11746} Desert Rumbler
	["The Twilight's Hammer dig fills the north-west corner: tablet fragments lie on the ground and the Dust Stormers and Desert Rumblers carry them too. Every cultist can drop an {item:20404}: keep twenty, ten for {npc:15306} and ten for {npc:15194} later."] = "A escavação do Martelo do Crepúsculo ocupa o canto noroeste: há fragmentos de tábua no chão, e as Tempestades de Poeira e os Estrondores do Deserto também os carregam. Todo sectário pode deixar cair um {item:20404}: guarde vinte, dez para {npc:15306} e dez para {npc:15194} depois.",
	["Twilight's Hammer cultists"] = "Sectários do Martelo do Crepúsculo",
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["Twilight Tablet Fragments"] = "Fragmentos de Tabuleta do Crepúsculo",
	-- {quest:8323} True Believers
	["Ten more for {quest:8323}"] = "Mais dez para {quest:8323}",

	-- Step 25: Hive'Zora
	-- {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {spell:642} Divine Shield · {spell:5384} Feign Death · {spell:17} Power Word: Shield
	["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp.\nCareful: You lose the Silithyst if you mount, stealth, use {spell:642}, {spell:5384} or Vanish. Blink and {spell:17} do not drop it."] = "{npc:17080} acampa do lado de fora de {area:2743}, a colmeia do oeste. Pegue um Silitista num dos gêiseres vermelhos ali perto e leve até o extrator da Aliança no acampamento dele.\nCuidado: você perde o Silitista se montar, ficar furtivo, usar {spell:642}, {spell:5384} ou Sumir. Lampejo e {spell:17} não derrubam.",

	-- Step 28: Southwind Village
	-- {area:2738} Southwind Village · {object:179565} Dusty Reliquary
	-- plural, as words: Tortured Sentinels = {npc:12179} Tortured Sentinel
	["Ride east to the ruins of {area:2738}. The {object:179565} lies among the ruined buildings, watched by Tortured Sentinels."] = "Siga para o leste até as ruínas de {area:2738}. {object:179565} está entre os edifícios em ruínas, vigiado por Sentinelas Torturadas.",
	-- {object:179565} Dusty Reliquary
	["{object:179565}; inside"] = "{object:179565}; lá dentro",

	-- Step 29: Hermit Ortell
	-- {area:2738} Southwind Village
	["The hermit hides among the rocks south-east of {area:2738}."] = "O eremita se esconde entre as rochas a sudeste de {area:2738}.",
	["Below ground"] = "No subterrâneo",

	-- Step 30: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Acampamento Barbabronze",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {npc:15190} Noggle Ficklespragg
	["Ride south-west to the dwarves' camp near the southern mountains and question {npc:15171} and {npc:15170}. {npc:15190}'s satchel lies in the sand just south-east of the camp."] = "Siga para o sudoeste até o acampamento dos anões perto das montanhas do sul e interrogue {npc:15171} e {npc:15170}. A Algibeira do {npc:15190} está na areia, logo a sudeste do acampamento.",

	-- Step 31: The Twilight Post
	-- {area:3098} Twilight Post
	["The {area:3098}"] = "{area:3098}",
	-- {npc:11803} Twilight Keeper Exeter
	["{npc:11803} holds the cultists' camp in the far south-west."] = "{npc:11803} comanda o acampamento dos sectários no extremo sudoeste.",

	-- Step 32: Twilight Keeper Mayna
	["Ride north along the west side to Mayna's small camp."] = "Siga para o norte pelo lado oeste até o pequeno acampamento da Tutora do Crepúsculo Mayna.",

	-- Step 33: Twilight Keeper Havunth
	-- {area:3425} Cenarion Hold
	["Havunth's camp sits just west of {area:3425}."] = "O acampamento do Guardião do Crepúsculo Havunth fica logo a oeste de {area:3425}.",

	-- Step 34: Hermit Ortell
	["Ride back south-east to the hermit."] = "Volte para o sudeste até o eremita.",
	["Hand him the ten texts you kept"] = "Entregue a ele os dez textos que você guardou",

	-- Step 35: Cenarion Hold
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",

	-- Step 36: Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}."] = "Voe para {area:976}.",
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus
	["{npc:7740} in {zone:1457}: keep it"] = "{npc:7740} em {zone:1457}: guarde-a",

	-- Step 37: Forest Song
	-- {area:3137} Talrendis Point · {zone:1447} Azshara · {area:2358} Forest Song · {zone:1440} Ashenvale
	["Fly to {area:3137} in {zone:1447} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Voe para {area:3137} em {zone:1447} e siga para o oeste pela estrada até {area:2358}, logo depois da fronteira de {zone:1440}.",

	-- Step 38: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Voe para {area:2255}",

	-- Step 41: Starfall Village
	-- {area:2253} Starfall Village
	["Ride north-west up the road to {area:2253}."] = "Siga para noroeste pela estrada até {area:2253}.",

	-- Step 43: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "Acampamento de {npc:10301}",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	["Ride back east past {area:2255} and south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Volte para leste, passando por {area:2255}, e desça o vale para sudeste até o caixote danificado de {npc:10301} na neve, em {area:2245}, com a carroça destruída dele logo a leste.",

	-- Step 44: Jaron Stoneshaper's supplies
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s supplies"] = "Suprimentos de {npc:10301}",
	-- {npc:10301} Jaron Stoneshaper
	["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Pegue os suprimentos em volta da carroça e tome de volta o amuleto de {npc:10301} dos corujursos próximos.",

	-- Step 45: Ranshalla
	-- {npc:10300} Ranshalla · {area:2250} Owl Wing Thicket · {area:2255} Everlook · {object:177404} Altar of Elune (no name in this language: may be words)
	["{npc:10300} waits at {area:2250}, south of {area:2255}.\nProtect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "{npc:10300} espera em {area:2250}, ao sul de {area:2255}.\nProteja {npc:10300} enquanto ela acende as tochas no caminho até {object:177404}.",

	-- Step 46: Darkwhisper Gorge
	-- {npc:9298} Donova Snowden · {area:2256} Darkwhisper Gorge
	["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Siga as instruções de {npc:9298} até a entrada do {area:2256}, passando pelos gigantes Friomalho: passe por eles um de cada vez.",

	-- Step 47: Starfall Village
	-- {area:2255} Everlook · {area:2253} Starfall Village
	["Ride north up the valley, past {area:2255}, to {area:2253}."] = "Siga para o norte pelo vale, passando por {area:2255}, até {area:2253}.",

	-- Step 49: Dire Maul (optional)
	-- {area:2577} Dire Maul
	["{area:2577} (optional)"] = "{area:2577} (opcional)",
	-- {area:2577} Dire Maul · {zone:1444} Feralas
	["Running {area:2577} in {zone:1444} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Fazer {area:2577} em {zone:1444} em vez de farmar leva você lá mais rápido em grupo. Pule esta etapa para farmar sozinho.",
	-- {area:2577} Dire Maul · {area:2627} Terrordale
	["{area:2577} fits levels 55 to 60; alone, the {area:2627} grind at the end of this guide gets you to 60."] = "{area:2577} serve para os níveis 55 a 60; sozinho, matar monstros em {area:2627} no fim deste guia leva você ao nível 60.",

	-- Step 50: Felwood
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "",

	-- Step 52: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["{npc:11558} stands just inside the {area:1769} cave: she speaks to you from Neutral with the Timbermaw, which the Winterfall furbolgs you ground in {zone:1452} brought you to."] = "{npc:11558} fica logo dentro da caverna de {area:1769}: ela fala com você a partir de Neutro com os Presamatos, nível que os furbolgs Invernosos que você matou em {zone:1452} deram a você.",
	-- {npc:11558} Kernda
	["{npc:11558}, just inside the cave: walks around here: look inside the circle on the map"] = "{npc:11558}, logo dentro da caverna: anda por aqui: procure dentro do círculo no mapa",

	-- Step 53: Kernda
	-- {area:1762} Felpaw Village · {npc:11558} Kernda
	["The Deadwood totem from {area:1762}, if {npc:11558} didn't take it then."] = "O totem de Lenha Morta de {area:1762}, se {npc:11558} não o aceitou antes.",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: anda por aqui: procure dentro do círculo no mapa",

	-- Step 54: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth · {zone:1452} Winterspring
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw: the {zone:1452} top-up on the Winterfall furbolgs gets you both."] = "{npc:11557}, logo dentro da caverna, ao lado de {npc:11558}, recebe trinta {quest:6031} a partir de Amigável com os Presamatos: a rodada para completar o nível em {zone:1452}, nos furbolgs Invernosos, rende as duas coisas.",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557}; no subterrâneo",

	-- Step 58: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452}: vá matando estes pelo caminho",
	-- {spell:5384} Feign Death
	["The western Winterfall furbolgs drop the beads.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest."] = "Os furbolgs Invernosos do oeste deixam cair as contas.\nCuidado: a entrega faz surgir três ou quatro emboscadores Invernosos de nível 56-57 que atacam você; dá para escapar montado, furtivo ou com {spell:5384}, e depois eles se juntam perto do lago, liberando a próxima missão.",

	-- Step 62: Umber
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring · {npc:9298} Donova Snowden · {area:493} Moonglade · {area:2361} Nighthaven · {npc:11939} Umber
	["Take the {area:1769} tunnel from its {zone:1452} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Pegue o túnel de {area:1769} pela entrada de {zone:1452}, a oeste de {npc:9298}, e siga o ramal de {area:493} até {area:2361}. {npc:11939} estuda à beira do lago.",
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} walks around {area:2361}: look inside the circle on the map"] = "{npc:11939} anda por {area:2361}: procure dentro do círculo no mapa",

	-- Step 63: Rabine Saturna
	-- {npc:11801} Rabine Saturna · {area:2361} Nighthaven · {npc:11939} Umber
	["{npc:11801}'s house stands in {area:2361}, east of {npc:11939}."] = "A casa de {npc:11801} fica em {area:2361}, a leste de {npc:11939}.",

	-- Step 65: Nighthaven
	-- {area:2361} Nighthaven
	["Learn the flight path in {area:2361}."] = "Aprenda a rota de voo em {area:2361}.",

	-- Step 66: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Voe para {area:702}",

	-- Step 67: Rut'theran Village
	-- {area:702} Rut'theran Village · {npc:7916} Erelas Ambersky
	["The flight lands in {area:702}. {npc:7916} stands a short walk north-west of the flight master."] = "O voo pousa em {area:702}. {npc:7916} fica a uma curta caminhada a noroeste do mestre de voo.",

	-- Step 69: Darnassus
	-- {zone:1457} Darnassus
	["Take the portal up to {zone:1457}."] = "Pegue o portal para subir até {zone:1457}.",
	-- {npc:7740} Gracina Spiritmight
	["{npc:7740}, in the Temple of the Moon"] = "{npc:7740}, no Templo da Lua",
	-- {npc:4155} Idriana
	["{npc:4155}, in the bank"] = "{npc:4155}, no banco",

	-- Step 71: Darnassus
	-- {npc:3516} Arch Druid Fandral Staghelm · {area:1658} Cenarion Enclave
	["{npc:3516}, atop the {area:1658}"] = "{npc:3516}, no alto de {area:1658}",

	-- Step 72: Portal to Teldrassil
	-- {zone:1438} Teldrassil
	["Portal to {zone:1438}"] = "Portal para {zone:1438}",

	-- Step 73: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Voe para {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Mestre de voo de {area:702}",

	-- Step 74: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",

	-- Step 75: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Mestre de voo de {area:150}",

	-- Step 76: Stormwind
	-- {npc:14722} Clavicus Knavingham · {item:14047} Runecloth
	["{npc:14722} takes sixty Silk, sixty Mageweave and sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "{npc:14722} recebe sessenta Sedas, sessenta Magitramas e sessenta {item:14047}: entregue o que estiver carregando (ou compre na Casa de Leilões) e pule o resto.",
	-- {item:4306} Silk Cloth
	["{item:4306}, from your bags"] = "{item:4306}, das suas bolsas",
	-- {item:4338} Mageweave Cloth
	["{item:4338}, from your bags"] = "{item:4338}, das suas bolsas",
	-- {npc:14722} Clavicus Knavingham · {object:2096} Trade District
	["{npc:14722}, in the {object:2096}"] = "{npc:14722}, em {object:2096}",
	-- {item:2592} Wool Cloth
	["{item:2592}, from your bags"] = "{item:2592}, das suas bolsas",
	-- {item:14047} Runecloth
	["{item:14047}, from your bags"] = "{item:14047}, das suas bolsas",

	-- Step 77: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Metrô para {zone:1455}",

	-- Step 78: Ironforge
	-- {area:2257} Deeprun Tram · {zone:1455} Ironforge · {npc:14724} Bubulo Acerbus · {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each take sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: hand in what you carry (or buy at the Auction House), skip the rest."] = "Pegue o {area:2257} até {zone:1455}. {npc:14724} e {npc:14723} aceitam sessenta de Lã, sessenta de Seda e sessenta de Magitrama cada, depois sessenta {item:14047}: entregue o que você carrega (ou compre na Casa de Leilões) e pule o resto.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} não tem instrutor de xamã",

	-- Step 79: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Voar para {area:271}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",

	-- Step 83: Chillwind Camp
	-- {npc:1852} Araj the Summoner
	["{npc:1852} is a level 61 elite"] = "{npc:1852} é um elite de nível 61",
	-- {quest:6184} Flint Shadowmore · {area:2260} Marris Stead · {zone:1423} Eastern Plaguelands
	["{quest:6184}: the agents' remains lie at the {area:2260} in the {zone:1423}"] = "{quest:6184}: os restos dos agentes ficam em {area:2260}, em {zone:1423}",

	-- Step 84: Andorhal
	["Andorhal"] = "Ruínas de Andorhal",
	-- {npc:10667} Chromie · {npc:1852} Araj the Summoner
	["{npc:10667} waits in the ruined inn on the west side of Andorhal, the ruined city north of the camp. {npc:1852} guards his phylactery in the middle of the town."] = "{npc:10667} espera na estalagem em ruínas no lado oeste das Ruínas de Andorhal, a cidade em ruínas ao norte do acampamento. {npc:1852} protege o filactério dele no meio da cidade.",
	["Araj is elite: grouping up is advised."] = "Araj, o Evocador, é elite: recomenda-se formar um grupo.",
	-- {npc:10667} Chromie
	["{npc:10667}, upstairs"] = "{npc:10667}, no andar de cima",

	-- Step 85: Felstone Field
	-- {npc:10778} Janice Felstone · {area:199} Felstone Field
	-- plural, as words: Jabbering Ghouls = {npc:10801} Jabbering Ghoul
	["{npc:10778}'s ghost wanders by the farmhouse of {area:199}, west of Andorhal. The Jabbering Ghouls in the field carry the other half of the charm: combine the two halves."] = "O fantasma de {npc:10778} vagueia perto da casa da fazenda de {area:199}, a oeste das Ruínas de Andorhal. Os Carniçais Grasnantes do campo carregam a outra metade do amuleto: junte as duas metades.",
	["Upstairs"] = "No andar de cima",

	-- Step 86: Northridge Lumber Camp
	["Ride north up the road to the lumber mill and set the termite barrel down in the middle of it."] = "Siga a estrada para o norte até a serraria e coloque o barril de cupins no meio dela.",

	-- Step 87: Tirion Fordring (optional)
	-- {npc:1855} Tirion Fordring
	["{npc:1855} (optional)"] = "{npc:1855} (opcional)",
	-- {npc:1855} Tirion Fordring · {quest:5781} Of Forgotten Memories
	["{npc:1855} lives in a small hut on the border river, north-east of the lumber camp. Hand in {quest:5781} if you finished it."] = "{npc:1855} Fordring vive numa pequena cabana à beira do rio da fronteira, a nordeste da madeireira. Entregue {quest:5781} se você a concluiu.",

	-- Step 88: Eastern Plaguelands
	-- {quest:5845} Of Lost Honor
	["The lake for {quest:5845}"] = "",

	-- Step 89: Of Lost Honor
	["Underwater"] = "Debaixo d'água",

	-- Step 91: Egan
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {npc:11140} Egan
	["Cross the river east of {npc:1855}'s hut into {area:2627}: {npc:11140} stands by Augustus' ruined hut."] = "Atravesse o rio a leste da cabana de {npc:1855} até {area:2627}: {npc:11140} fica junto à cabana em ruínas de Augustus.",

	-- Step 92: Marris Stead
	-- {area:2260} Marris Stead · {area:2262} Darrowshire · {npc:11878} Nathanos Blightcaller
	["Ride south to the {area:2260}, the farm north-west of {area:2262}. The three agents' remains are bone outlines on the ground: one by the road south of the farm, one on the hill east of the house, one on the mound in front of it. Coming close enough to see the Blightcaller in front of the house completes the scouting.\nCareful: {npc:11878} (level 62 elite) and his elite hounds stand in front of the house: take the remains on the mound from the side and do not pull him. You don't have to fight him."] = "Cavalgue para o sul até {area:2260}, a fazenda a noroeste de {area:2262}. Os restos dos três agentes são contornos de ossos no chão: um junto à estrada ao sul da fazenda, um na colina a leste da casa, um no montículo na frente dela. Chegar perto o bastante para ver o Arauto da Praga na frente da casa completa o reconhecimento.\nCuidado: {npc:11878} (elite de nível 62) e seus cães de elite ficam na frente da casa: pegue os restos do montículo pelo lado e não o puxe. Você não precisa lutar contra ele.",

	-- Step 94: Scholomance (optional)
	-- {area:2057} Scholomance
	["{area:2057} (optional)"] = "{area:2057} (opcional)",
	-- {area:2057} Scholomance · {area:2298} Caer Darrow · {area:28} Western Plaguelands · {area:2279} Stratholme
	["Running {area:2057} ({area:2298}, south-east {area:28}) or {area:2279} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Fazer {area:2057} ({area:2298}, sudeste de {area:28}) ou {area:2279} em vez de farmar leva você lá mais rápido em grupo. Pule esta etapa para farmar sozinho.",
	-- {area:2057} Scholomance · {quest:5505} The Key to Scholomance · {area:3197} Chillwind Camp
	["{area:2057} fits levels 58 to 60; {quest:5505} is handed in at {area:3197} below."] = "{area:2057} é para os níveis 58 a 60; {quest:5505} é entregue em {area:3197}, abaixo.",

	-- Step 95: Level 59.93
	["Level 59.93"] = "Nível 59.93",
	-- {npc:1855} Tirion Fordring · {area:2627} Terrordale · {area:3197} Chillwind Camp · {area:2057} Scholomance · {area:2279} Stratholme
	-- plural, as words: Terrordale Spirits = {npc:14564} Terrordale Spirit
	["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there. Top up here to level 59.93 before the hand-ins at {area:3197}: they take you to level 60. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Atravesse o rio a leste de {npc:1855} até {area:2627}. Os Espíritos da Várzea do Medo assombram a mata ali. Complete aqui até o nível 59.93 antes das entregas em {area:3197}: elas levam você ao nível 60. Ou, com um grupo, faça a masmorra {area:2057} ou a masmorra {area:2279}.",
	-- {npc:14564} Terrordale Spirit · {area:2627} Terrordale · {zone:1423} Eastern Plaguelands
	["grind on {npc:14564} at {area:2627}, {zone:1423}"] = "farme {npc:14564} em {area:2627}, {zone:1423}",

	-- Step 97: Chillwind Camp
	-- {area:3197} Chillwind Camp
	["Ride back south-west to {area:3197}."] = "Volte para o sudoeste até {area:3197}.",
	-- {zone:1453} Stormwind
	["Flint's next task goes to {zone:1453}: you are level 60 now, skip it."] = "A próxima tarefa de Flint vai para {zone:1453}: você já está no nível 60, pule-a.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into {area:1770}: {npc:9861} and {npc:9860} guard {npc:9517} in its deepest chamber."] = "De volta a {area:1770}: {npc:9861} e {npc:9860} protegem {npc:9517} na câmara mais profunda.",
	-- ["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there."] = "Atravesse o rio a leste de {npc:1855} até {area:2627}. Os Espíritos da Várzea do Medo assombram o bosque ali.",
	-- ["Cross the river east of {npc:1855} into {area:2627}. The Terrordale Spirits haunt the woods there. Or, with a group, run the {area:2057} dungeon or the {area:2279} dungeon instead."] = "Atravesse o rio a leste de {npc:1855} até {area:2627}. Os Espíritos da Várzea do Medo assombram os bosques de lá. Ou, com um grupo, faça a masmorra {area:2057} ou a masmorra {area:2279}.",
	-- ["Dredge Crushers roam the dunes between {area:2743} and {area:3425}, on your way back. {npc:15181} only offers {quest:8304} from level 58."] = "Os Dragasmagas vagueiam pelas dunas entre {area:2743} e {area:3425}, no caminho de volta. {npc:15181} só oferece {quest:8304} a partir do nível 58.",
	-- ["Fly to {area:3137} in {area:16} and ride west along the road to {area:2358}, just over the {zone:1440} border."] = "Voe para {area:3137} em {area:16} e siga para o oeste pela estrada até {area:2358}, logo depois da fronteira de {zone:1440}.",
	-- ["Follow the road south-west out of the pass to {area:3425}."] = "Siga a estrada para o sudoeste, saindo do desfiladeiro, até {area:3425}.",
	-- ["Go back down to {area:702}, take the boat to {area:442} and the boat on to {area:17203}. Bring sixty Silk, sixty Mageweave and sixty {item:14047} for {npc:14722}: buy what you lack at the Auction House."] = "Desça de volta até {area:702}, pegue o barco para {area:442} e depois o barco até {area:17203}. Leve sessenta Sedas, sessenta Magitramas e sessenta {item:14047} para {npc:14722}: compre o que faltar na Casa de Leilões.",
	-- ["Grind to 58"] = "Upe até o 58",
	-- ["Grind to 59"] = "Upe até o 59",
	-- ["Grind to 60"] = "Upe até o 60",
	-- ["Hearth to {area:1519} and train your level 60 spells. This is the end of the leveling route: look at the reputation and dungeon guides next."] = "Regresse para {area:1519} e treine seus feitiços de nível 60. Este é o fim da rota de evolução: veja depois os guias de reputação e de masmorras.",
	-- ["Into {zone:1451}"] = "Rumo a {zone:1451}",
	-- ["Keep west on the road to {npc:9298}'s camp beside the hot springs."] = "Continue para o oeste pela estrada até o acampamento de {npc:9298}, ao lado das fontes termais.",
	-- ["Level 60"] = "Nível 60",
	-- ["Ride back north to {area:2255} and west along the road to the night elf village."] = "Volte para o norte até {area:2255} e siga para o oeste pela estrada até a aldeia dos elfos noturnos.",
	-- ["Ride back to {area:3137} and fly to {area:2255}."] = "Volte para {area:3137} e voe para {area:2255}.",
	-- ["Ride north out of {area:415} into {zone:1448} to the druids' camp on the road just past the border."] = "Siga para o norte saindo de {area:415} até {zone:1448}, até o acampamento dos druidas na estrada, logo depois da fronteira.",
	-- ["Ride south to {area:2250}. Protect {npc:10300} while she lights the torches on the way to the {object:177404}."] = "Siga para o sul até {area:2250}. Proteja {npc:10300} enquanto ela acende as tochas a caminho de {object:177404}.",
	-- ["Ride west along the crater's northern wall to the pass in the north-west corner that climbs into {zone:1451}."] = "Siga para o oeste ao longo da parede norte da cratera até o desfiladeiro no canto noroeste, que sobe para {zone:1451}.",
	-- ["Shaman training"] = "Treinamento de xamã",
	-- ["Take the boat from {area:442} to {area:702}."] = "Pegue o barco de {area:442} para {area:702}.",
	-- ["Take the flight path in {area:2361} and fly to {area:442}."] = "Pegue a rota de voo em {area:2361} e voe para {area:442}.",
	-- ["Take the {area:1769} tunnel from its {area:618} mouth, west of {npc:9298}, and follow the {area:493} branch to {area:2361}. {npc:11939} studies by the lake shore."] = "Pegue o túnel de {area:1769} pela entrada de {area:618}, a oeste de {npc:9298}, e siga o ramal de {area:493} até {area:2361}. {npc:11939} estuda à beira do lago.",
	-- ["Take the {area:2257} to {zone:1455}. {npc:14724} and {npc:14723} each want sixty Wool, sixty Silk and sixty Mageweave, then sixty {item:14047}: 120 of each in all, from your bags or the Auction House."] = "Pegue o {area:2257} para {zone:1455}. {npc:14724} e {npc:14723} querem, cada um, sessenta Lãs, sessenta Sedas e sessenta Magitramas, e depois sessenta {item:14047}: 120 de cada no total, das suas bolsas ou da Casa de Leilões.",
	-- ["The {area:2739}"] = "{area:2739}",
	-- ["The {npc:7446} bears roam the snowy valley south of {area:2250}."] = "Os ursos {npc:7446} vagueiam pelo vale nevado ao sul de {area:2250}.",
	-- ["Toward the north-west pass"] = "Rumo ao desfiladeiro noroeste",
	-- ["You start in {area:392}, where the previous guide hearthed you. Fly to {area:415}."] = "Você começa em {area:392}, para onde o guia anterior mandou você regressar. Voe para {area:415}.",
	-- ["grind on {npc:11741} at the dunes east of {area:2743}, {zone:1451}"] = "farme {npc:11741} nas dunas a leste de {area:2743}, {zone:1451}",
	-- ["grind on {npc:14564} at {area:2627}, {area:139}"] = "farme {npc:14564} em {area:2627}, {area:139}",
	-- ["grind on {npc:7446} at the valley south of {area:2250}, {zone:1452}"] = "farme {npc:7446} no vale ao sul de {area:2250}, {zone:1452}",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}."] = "{area:1770} é a caverna no fundo de {area:1763}, a oeste da estrada. Use o {item:12906} nos quatro braseiros lá dentro. Mate os Ursos Garraivosos e os Lobos Patavil pelo caminho para obter {item:11172}.",
	-- ["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside. Kill the Angerclaw bears and Felpaw wolves you pass for the {item:11172}.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns. A group of 2-3 players is recommended."] = "{area:1770} é a caverna no fundo de {area:1763}, a oeste da estrada. Use a {item:12906} nos quatro braseiros lá dentro. Mate os ursos Garraivoso e os lobos Patavil que encontrar pelas {item:11172}.\nCuidado: monstros do Concílio das Sombras de nível 53-55 lotam a caverna e costumam vir em grupos grandes e ligados, muitos com atordoamento. Melhor ir num grupo de 2 ou 3 jogadores.",
	-- ["{area:2577} fits levels 55 to 60; the {npc:7446} grind below gets you to 59 alone."] = "{area:2577} é para os níveis 55 a 60; farmar {npc:7446}, abaixo, leva você ao 59 sozinho.",
	-- ["{npc:10924}: ends in {zone:1452}, keep it"] = "{npc:10924}: termina em {zone:1452}, guarde-a",
	-- ["{npc:11557}, if you have thirty {quest:6031}"] = "{npc:11557}, se você tiver trinta {quest:6031}",
	-- ["{npc:11557}, if you have thirty {quest:6031}; below ground"] = "{npc:11557}, se você tiver trinta {quest:6031}; no subterrâneo",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw"] = "{npc:11558}, logo na entrada da caverna: só a partir de Neutro com os Presamatos",
	-- ["{npc:11558}, just inside the cave: only from Neutral with the Timbermaw; walks around here: look inside the circle on the map"] = "{npc:11558}, logo na entrada da caverna: só a partir de Neutro com os Presamatos; anda por aqui: procure dentro do círculo no mapa",
	-- ["{npc:15174}, the innkeeper"] = "{npc:15174}, o estalajadeiro",
	-- ["{npc:17080} camps outside {area:2743}, the western hive. Pick up a Silithyst at one of the red geysers nearby and carry it to the Alliance extractor at his camp."] = "{npc:17080} acampa fora de {area:2743}, a colmeia do oeste. Pegue um Silitista em um dos gêiseres vermelhos próximos e leve-o ao extrator da Aliança no acampamento dele.",
	-- ["{npc:17082}, at the Alliance tents"] = "{npc:17082}, nas tendas da Aliança",
	-- ["{npc:6791}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6791}: o guia anterior leva você até aqui com a pedra de regresso, então isto costuma ser marcado na hora",
	-- ["{npc:9598} waits in {area:1767}. Escort her out of the woods and keep her alive."] = "{npc:9598} espera em {area:1767}. Escolte-a para fora do bosque e mantenha-a viva.",
	-- ["{object:176091}, if you found the Firewater flask in {area:618}"] = "{object:176091}, se você encontrou o Frasco Vazio de Aguardente em {area:618}",
	-- ["{quest:5085}: {npc:9298} in {area:618}, keep it"] = "{quest:5085}: {npc:9298} em {area:618}, guarde-a",
	-- ["{zone:1451}, {area:361}, {area:618} & the Plaguelands"] = "{zone:1451}, {area:361}, {area:618} e as Terras Pestilentas",
	-- ["{zone:1453} has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455} and train your level 60 spells with {npc:258098}."] = "{zone:1453} não tem instrutor de xamã: pegue o {area:2257} de {object:28027} para {zone:1455} e treine seus feitiços de nível 60 com {npc:258098}.",
}
