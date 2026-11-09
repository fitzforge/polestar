-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/04-tanaris (forever/horde/40-50/04-tanaris.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Voar para {area:976}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Mestre de voo de {area:1099}",

	-- Step 3: Gadgetzan
	-- {npc:7876} Tran'rek · {area:979} Sandsorrow Watch
	["The flight lands beside {npc:7876}. Take the town's quests before riding west to {area:979}."] = "O voo pousa ao lado de {npc:7876}. Pegue as missões da cidade antes de cavalgar para oeste até {area:979}.",
	-- {npc:7876} Tran'rek
	["{npc:7876}, beside the wind rider master"] = "{npc:7876}, ao lado do mestre de mantícoras",

	-- Step 5: Sandsorrow Watch
	-- {item:8584} Untapped Dowsing Widget
	["West of Gadgetzan, use the {item:8584} beside the water hole in the troll camp."] = "A oeste de Geringontzan, use o {item:8584} junto ao poço d'água no acampamento troll.",

	-- Step 6: Senior Surveyor Fizzledowser
	-- {area:976} Gadgetzan · {npc:7771} Marvon Rivetseeker
	["Back east to Fizzledowser on the west side of {area:976}; {npc:7771} is south from there."] = "De volta a leste, até Secamolha, no lado oeste de {area:976}; {npc:7771} fica ao sul dali.",

	-- Step 7: Marvon Rivetseeker
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar · {item:9978} Gahz'ridian Detector · {area:983} Dunemaul Compound
	["West along the road south; {npc:7771} camps by the ruins at the {area:1938}. Put on his {item:9978}: it shows the buried ornaments, here and around the {area:983}."] = "Para oeste pela estrada do sul; {npc:7771} acampa junto às ruínas no {area:1938}. Equipe o {item:9978} dele: ele mostra os ornamentos enterrados, aqui e em volta do {area:983}.",

	-- Step 8: Broken Pillar: kill these as you meet them
	-- {area:1938} Broken Pillar
	["{area:1938}: kill these as you meet them"] = "{area:1938}: vá matando estes pelo caminho",
	-- {area:982} Noxious Lair · {npc:12046} Gor'marok the Ravager · {quest:3161} Gahz'ridian
	["South of the {area:982} the Dunemaul ogres hold their compound, with {npc:12046} at its eastern end. Dig up {quest:3161} ornaments between the fights."] = "Ao sul do {area:982}, os ogros Dunamalho ocupam o complexo, com {npc:12046} no extremo leste. Desenterre ornamentos de {quest:3161} entre as lutas.",
	["Below ground"] = "No subterrâneo",

	-- Step 9: Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["West, the Centipaar insects swarm around their hives; any of them drops the parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "A oeste, os insetos Centiparte enxameiam em volta das colmeias; qualquer um deixa cair os pedaços.\nCuidado: os Enxameadores Centiparte soltam {npc:4196} dentro e fora de combate, o que traz bichinhos que interrompem você.",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}: vá matando estes pelo caminho",
	-- {zone:1446} Tanaris
	["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one.\nCareful: The other thistleshrub mobs in the area are level 49-50 and wander a lot, so you can easily pull extra mobs."] = "A oeste do complexo, as criaturas-cacto lotam o vale; só os Coletores de Orvalho têm a glândula de orvalho. A maioria dos monstros de {zone:1446} pode deixar cair, raramente, o sinalizador de socorro do OOX-17/TN: guarde se aparecer um.\nCuidado: os outros Moitagulhas da área são nível 49-50 e andam muito, então é fácil puxar monstro a mais.",
	-- {item:8623} OOX-17/TN Distress Beacon
	["{item:8623}, a rare drop"] = "{item:8623}, item raro",

	-- Step 11: Tooga's escort
	-- {npc:5955} Tooga
	["{npc:5955}'s escort"] = "Escolta de {npc:5955}",
	-- {npc:5955} Tooga · {npc:6015} Torta · {area:977} Steamwheedle Port · {npc:8579} Yeh'kinya
	["{npc:5955} waits in the valley. Walk him all the way to his wife {npc:6015} in {area:977}, north-east across the desert: stay close, slow down for him and fight off what attacks him. Do not mount or hearth out of his reach. {npc:8579} stands in the port too."] = "{npc:5955} espera no vale. Leve-o a pé até a esposa dele, {npc:6015}, no {area:977}, a nordeste atravessando o deserto: fique perto, diminua o passo por ele e afaste o que o atacar. Não monte nem use a Pedra de Regresso longe dele. {npc:8579} também fica no porto.",

	-- Step 13: Slake That Thirst
	-- {spell:686} Shadow Bolt
	["Careful: Shadow Mages (level 42-43) call a Voidwalker while out of combat and attack with Immolate and {spell:686}. Thieves can Disarm you, Rogues move around in Sneak, and Assassins use Execute once you are at 20% health or less."] = "Cuidado: os Magos das Sombras (nível 42-43) invocam um Emissário do Caos fora de combate e atacam com Imolar e {spell:686}. Os Ladrões podem desarmar você, os Ladinos andam furtivos e os Assassinos usam Executar quando você está com 20% de vida ou menos.",

	-- Step 14: Gadgetzan
	["Use the Model 4711-FTZ Power Source Bilgewhizzle gave you: a two-hour timer starts"] = "Use a Modelo 4711-KTC Fonte de Energia que Silvadágua deu a você: um cronômetro de duas horas começa",

	-- Step 15: Gadgetzan
	-- {item:8526} Violet Tragan · {zone:1425} Hinterlands
	["the {item:8526} grows in the {zone:1425}, around level 48"] = "a {item:8526} cresce em {zone:1425}, por volta do nível 48",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, lá dentro",

	-- Step 16: Tanaris Field Sampling
	-- {area:976} Gadgetzan
	-- plural, as words: Blisterpaw Hyenas = {npc:5426} Blisterpaw Hyena · Glasshide Basilisks = {npc:5419} Glasshide Basilisk · Scorpid Hunters = {npc:5422} Scorpid Hunter
	["Just south of {area:976} the Blisterpaw Hyenas, Glasshide Basilisks and Scorpid Hunters share the dunes. Each can drop an untested sample: use it, and it either passes as an acceptable one or is lost. Keep killing until you have eight of each."] = "Logo ao sul de {area:976}, as Hienas Patapústula, os Basiliscos Silicouro e os Caçadores Escorpídeos dividem as dunas. Cada um pode deixar cair uma amostra não testada: use-a, e ela passa como amostra aceitável ou se perde. Continue matando até ter oito de cada.",

	-- Step 18: Scrimshank's gear
	["Scrimshank's gear"] = "O equipamento de Anilhacido",
	["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Mais ao sul, o aparelho do Topógrafo Júnior Anilhacido está na boca de uma colmeia Centiparte.\nCuidado: um inseto guarda o aparelho. Muitos insetos patrulham os túneis, alguns de nível 50, então as lutas costumam trazer bicho a mais.",

	-- Step 19: OOX-17/TN
	["OOX-17/TN"] = "OOX-17/TN",
	-- {area:977} Steamwheedle Port · {area:35} Booty Bay
	["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}.\nCareful: The escort has two ambushes. Three level 47 scorpids attack near the start. Near the end, by the beach, three Wastewander humans attack: one mage and two assassins, around level 44."] = "Só com o sinalizador de socorro: o OOX-17/TN fica a sudeste da colmeia do Anilhacido. Escolte-o para o norte até {area:977}; a recompensa fica com Olhatorto, em {area:35}.\nCuidado: a escolta tem duas emboscadas. Três escorpídeos de nível 47 atacam perto do começo. Perto do fim, junto à praia, três humanos Errantes atacam: um mago e dois assassinos, por volta do nível 44.",

	-- Step 20: Gadgetzan
	-- {npc:5204} Apothecary Zinge · {zone:1458} Undercity
	["for {npc:5204} in the {zone:1458}, around level 52"] = "para {npc:5204} na {zone:1458}, por volta do nível 52",
	-- {npc:7010} Zilzibin Drumlore · {zone:1454} Orgrimmar
	["for {npc:7010} in {zone:1454}, around level 50"] = "para {npc:7010} em {zone:1454}, por volta do nível 50",

	-- Step 21: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Barco para {area:16727}",

	-- Step 22: Into Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into {zone:1427}"] = "Rumo a {zone:1427}",

	-- Step 23: Searing Gorge
	-- {area:247} Grimesilt Dig Site
	["The {area:247}"] = "O {area:247}",

	-- Step 24: The Grimesilt Dig Site
	-- {area:16727} Powderfuse Port · {zone:1427} Searing Gorge · {object:173265} Wooden Outhouse · {item:4306} Silk Cloth
	-- plural, as words: Dark Iron Geologists = {npc:5839} Dark Iron Geologist
	["From {area:16727}, ride into the {zone:1427} by its eastern pass, then west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "De {area:16727}, cavalgue para dentro de {zone:1427} pela passagem leste, depois para oeste até o sítio de escavação. {object:173265} fica na ponta sul dele; os Geólogos Ferro Negro escavam logo ao norte. Leve 15 {item:4306} (vende na casa de leilões).",
	-- {object:173265} Wooden Outhouse
	["the {object:173265}"] = "a {object:173265}",

	-- Step 26: Thorium Point
	-- {area:1446} Thorium Point
	["Ride north-west across the gorge; {area:1446} is the scaffolded camp in the north-west."] = "Cavalgue para noroeste atravessando a garganta; {area:1446} é o acampamento com andaimes no noroeste.",
	-- {object:179827} Wanted/Missing/Lost & Found
	["The {object:179827} board"] = "O quadro {object:179827}",

	-- Step 27: The Cauldron's slavers and golems
	-- {area:246} The Cauldron
	["{area:246}'s slavers and golems"] = "Feitores e golens de {area:246}",
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	-- plural, as words: Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Heavy War Golems = {npc:5854} Heavy War Golem
	["Ride south from {area:1446} into the Cauldron: the Dark Iron Taskmasters and Slavers drive the slaves on the paths, and the Heavy War Golems patrol the floor below {npc:8479}."] = "Cavalgue para o sul, saindo de {area:1446}, para dentro d'O Caldeirão: os Capatazes e Feitores Ferro Negro tocam os escravos pelas trilhas, e os Golens de Guerra Pesados patrulham o piso abaixo de {npc:8479}.",

	-- Step 28: Velarok Windblade
	-- {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["{npc:8479} stands alone south of {area:1446}, at the edge of the Cauldron. Listen to his story."] = "{npc:8479} fica sozinho ao sul de {area:1446}, na borda d'O Caldeirão. Ouça a história dele.",

	-- Step 31: Searing Gorge: kill these as you meet them
	-- {zone:1427} Searing Gorge
	["{zone:1427}: kill these as you meet them"] = "{zone:1427}: vá matando estes pelo caminho",
	-- {npc:8479} Velarok Windblade · {item:11818} Grimesilt Outhouse Key · {area:1443} The Slag Pit
	-- plural, as words: Heavy War Golems = {npc:5854} Heavy War Golem · Blazing Elementals = {npc:5850} Blazing Elemental · Dark Iron Taskmasters = {npc:5846} Dark Iron Taskmaster · Greater Lava Spiders = {npc:5858} Greater Lava Spider · Incendosaurs = {npc:9318} Incendosaur · Dark Iron Slavers = {npc:5844} Dark Iron Slaver
	["Heavy War Golems patrol the Cauldron below {npc:8479} and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it.\nThe Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge.\n{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge.\nCareful: Dark Iron Slavers (level 45-46) call for help from allies within 15 yd when pulled, cast Net from up to 15 yd, and use Rend in melee."] = "Golens de Guerra Pesados patrulham o Caldeirão abaixo de {npc:8479} e deixam cair o óleo; os Elementais de Magma e Fulgurantes que flutuam entre eles deixam cair os corações. Os Capatazes e Feitores Ferro Negro tocam os escravos pelas trilhas; um Feitor pode deixar cair a {item:11818}: guarde.\nAs Aranhas de Lava Abrasadoras andam pelos platôs e poças de lava no sudoeste da garganta.\n{area:1443} se abre no norte do Caldeirão. Incendossauros nadam nas poças de lava de lá: puxe-os até a borda. Os planos secretos estão na plataforma de cima do fosso.\nCuidado: os Feitores Ferro Negro (nível 45-46) chamam ajuda de aliados num raio de 15 m quando são puxados, jogam Rede de até 15 m e usam Dilacerar no corpo a corpo.",
	-- {item:11818} Grimesilt Outhouse Key
	["{item:11818}, a rare drop"] = "{item:11818}, item raro",

	-- Step 33: Thorium Point
	-- {area:1446} Thorium Point · {npc:8479} Velarok Windblade
	["Ride back north to {area:1446}, just past {npc:8479}."] = "Cavalgue de volta para o norte até {area:1446}, logo depois de {npc:8479}.",

	-- Step 34: The Steamsmiths' furnaces
	["The Steamsmiths' furnaces"] = "As fornalhas dos Vaporistas",
	-- {item:10551} Thorium Plated Dagger · {item:18959} Smithing Tuyere
	-- plural, as words: Dark Iron Steamsmiths = {npc:5840} Dark Iron Steamsmith
	["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Os Vaporistas Ferro Negro trabalham nas fornalhas no meio d'O Caldeirão; metade deles leva um {item:10551}, um em dez o {item:18959}. Escravos, Feitores e Capatazes também levam punhais.",

	-- Step 35: Velarok Windblade
	-- {item:10552} Symbol of Ragnaros
	["His next request needs the {item:10552} from elite cultists: leave it."] = "O próximo pedido dele requer o {item:10552} de sectários de elite: deixe-o.",

	-- Step 37: Dark Iron Lookouts
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["Dark Iron Lookouts"] = "Atalaias Ferro Negro",
	-- {item:18960} Lookout's Spyglass
	-- plural, as words: Dark Iron Lookouts = {npc:8566} Dark Iron Lookout
	["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Os Atalaias Ferro Negro ficam nas cristas em volta das torres de vigia ao sul d'O Caldeirão; cerca de um em dez leva a {item:18960}.",

	-- Step 38: The Key to Freedom
	-- {item:11818} Grimesilt Outhouse Key · {object:173265} Wooden Outhouse
	["Only with the {item:11818}: back east to the {object:173265} at the dig site."] = "Só com a {item:11818}: de volta a leste até a {object:173265} no sítio de escavação.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Navio para {area:35}",
	-- ["Dark Iron Lookouts"] = "Atalaias Ferro Negro",
	-- ["Fly to {area:1637} and train: the next guide's training stop is the {zone:1458}, which has no Hunter or Shaman trainer. Then fly to {area:392}."] = "Voe até {area:1637} e treine: a parada de treino do próximo guia é {zone:1458}, que não tem instrutor de Caçador nem de Xamã. Depois voe até {area:392}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:392}."] = "Voe até {area:1638} e treine com {npc:3033} no {area:1639}, depois voe até {area:392}.",
	-- ["Fly to {area:340}"] = "Voar para {area:340}",
	-- ["Fly to {area:392}"] = "Voar para {area:392}",
	-- ["From the {area:35} flight master, above the harbour."] = "Do mestre de voo de {area:35}, acima do porto.",
	-- ["From {area:1099}'s flight master."] = "Do mestre de voo do {area:1099}.",
	-- ["Further south, Junior Surveyor Scrimshank's gear lies at the mouth of a Centipaar hive."] = "Mais ao sul, o equipamento do Inspetor Júnior Anilhacido está na entrada de uma colmeia Centiparte.",
	-- ["Greater Lava Spiders"] = "Aranhas de Lava Abrasadoras",
	-- ["Heavy War Golems patrol the Cauldron below Kalaran and drop the oil; the Magma and Blazing Elementals drifting among them drop the hearts. The Dark Iron Taskmasters and Slavers drive the slaves on the paths; a Slaver may drop the {item:11818}: keep it."] = "Golens de Guerra Pesados patrulham O Caldeirão abaixo de Kalaran e deixam cair o óleo; os Elementais de Magma e Fulgurantes que flutuam entre eles deixam cair os corações. Os Capatazes e Feitores Ferro Negro tocam os escravos pelas trilhas; um Feitor pode deixar cair a {item:11818}: guarde-a.",
	-- ["Kalaran Windblade"] = "Kalaran Finalâmina",
	-- ["Only with the distress beacon: OOX-17/TN sits south-east of Scrimshank's hive. Escort it north to {area:977}; its reward waits with Oglethorpe in {area:35}."] = "Só com o transmissor de emergência: OOX-17/TN fica a sudeste da colmeia de Anilhacido. Escolte-o para o norte até o {area:977}; a recompensa espera com Olhatorto em {area:35}.",
	-- ["Ride back north to {area:1446}."] = "Cavalgue de volta ao norte até {area:1446}.",
	-- ["Ride back north to {area:1446}. Stay here: the next guide starts with the flight to {area:75}."] = "Cavalgue de volta para o norte até {area:1446}. Fique aqui: o próximo guia começa com o voo para {area:75}.",
	-- ["Ride south-west to {area:976}."] = "Cavalgue para sudoeste até {area:976}.",
	-- ["South down the road again."] = "Para o sul pela estrada de novo.",
	-- ["South-east of Gadgetzan the Wastewander bandits camp in the dunes; {npc:7847} stands in the eastern camp."] = "A sudeste de Geringontzan, os bandidos Errantes acampam nas dunas; {npc:7847} fica no acampamento leste.",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south-west to the dig site. The {object:173265} stands at its southern end; the Dark Iron Geologists dig just north of it. Bring 15 {item:4306} (the Auction House sells it)."] = "Pegue o desfiladeiro do lado oeste de {area:340} até {zone:1427} e cavalgue para sudoeste até o sítio de escavação. {object:173265} fica no extremo sul; os Geólogos Ferro Negro cavam logo ao norte. Leve 15 {item:4306} (a Casa de Leilões vende).",
	-- ["The Dark Iron Lookouts stand on the ridges around the sentry towers south of the Cauldron; about one in ten carries the {item:18960}."] = "Os Atalaias Ferro Negro ficam nas cristas em volta das torres de vigia ao sul d'O Caldeirão; cerca de um em dez leva a {item:18960}.",
	-- ["The Dark Iron Steamsmiths work the furnaces in the middle of the Cauldron; half of them carry a {item:10551}, one in ten the {item:18959}. Slaves, Slavers and Taskmasters carry daggers too."] = "Os Vaporistas Ferro Negro trabalham nas fornalhas no meio d'O Caldeirão; metade deles leva um {item:10551}, um em dez o {item:18959}. Escravos, Feitores e Capatazes também levam punhais.",
	-- ["The Greater Lava Spiders roam the plateaus and lava pools in the south-west of the gorge."] = "As Aranhas de Lava Abrasadoras vagam pelos platôs e poças de lava no sudoeste da garganta.",
	-- ["The Steamsmiths' furnaces"] = "As fornalhas dos Vaporistas",
	-- ["The boat to {area:35} docks at {area:392}'s pier, below the flight master's hill."] = "O navio para {area:35} atraca no píer de {area:392}, abaixo do morro do mestre de voo.",
	-- ["West of the compound the cactus creatures fill the valley; only the Dew Collectors carry a dew gland. Most mobs in {zone:1446} can drop OOX-17/TN's distress beacon, rarely: keep it if you see one."] = "A oeste do complexo, as criaturas-cacto enchem o vale; só os Coletores de Orvalho levam uma glândula de orvalho. A maioria das criaturas de {zone:1446} pode deixar cair o transmissor de emergência de OOX-17/TN, raramente: guarde-o se aparecer.",
	-- ["West, the Centipaar insects swarm around their hives; any of them drops the parts."] = "A oeste, os insetos Centiparte enxameiam em volta das colmeias; qualquer um deles deixa cair as peças.",
	-- ["the {object:150075} in the square"] = "o {object:150075} na praça",
	-- ["{area:1443} opens in the north of the Cauldron. Incendosaurs swim in its lava pools: pull them to the edge. The secret plans lie on the pit's upper ledge."] = "{area:1443} se abre no norte d'O Caldeirão. Incendossauros nadam nas poças de lava: atraia-os para a borda. Os planos secretos ficam na saliência superior do fosso.",
	-- ["{area:392} pier"] = "Píer de {area:392}",
}
