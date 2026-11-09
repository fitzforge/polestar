-- Portuguese (Brazil) (ptBR): the guide forever/alliance/06-ashenvale (forever/alliance/06-ashenvale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Kerlonian Evershade
	-- {area:442} Auberdine · {area:448} Grove of the Ancients · {npc:11218} Kerlonian Evershade · {item:13536} Horn of Awakening · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Back north from the glaive (Druids: south along the road from {area:442}) to the {area:448}, where {npc:11218} sleeps beside Arbal. Take his quest, open his chest for the {item:13536}, use it to wake him and lead him south along the road to his bag at the southern edge of {zone:1439}; blow the horn again whenever he falls asleep. Then go on to {npc:11219} at {area:413}.\nCareful: Scripted ambushes of three mobs each attack along the road."] = "De volta ao norte, a partir da glaive (Druidas: ao sul pela estrada, a partir de {area:442}) até {area:448}, onde {npc:11218} dorme ao lado de Arbal. Pegue a missão dele, abra o baú dele para pegar {item:13536}, use-o para acordá-lo e leve-o ao sul pela estrada até a bolsa dele, no extremo sul de {zone:1439}; toque o chifre de novo sempre que ele adormecer. Depois siga para {npc:11219}, em {area:413}.\nCuidado: emboscadas programadas de três monstros cada atacam ao longo da estrada.",
	-- {object:176634} Kerlonian's Chest
	["{object:176634}, beside him"] = "{object:176634}, ao lado dele",
	-- {npc:11218} Kerlonian Evershade · {zone:1439} Darkshore · {npc:11219} Liladris Moonriver · {area:413} Maestra's Post
	["Escort {npc:11218} south along the road to his bag at the southern edge of {zone:1439}, then go on to {npc:11219} at {area:413}."] = "Escolte {npc:11218} para o sul pela estrada até a bolsa dele, no extremo sul de {zone:1439}, e depois siga para {npc:11219}, em {area:413}.",

	-- Step 4: Bathran's Haunt: kill these as you meet them
	-- {area:411} Bathran's Haunt
	["{area:411}: kill these as you meet them"] = "{area:411}: vá matando estes pelo caminho",
	-- {area:411} Bathran's Haunt · {item:5366} Glowing Soul Gem
	["North of Maestra's Post, plant bundles lie around the ruins of {area:411}. Dark Strand cultists hold the ruins just south of them: any of them can drop the {item:5366}."] = "Ao norte do Entreposto de Maestra, há feixes de plantas em volta das ruínas de {area:411}. Sectários da Linhagem das Trevas ocupam as ruínas logo ao sul deles: qualquer um pode deixar cair a {item:5366}.",
	-- {quest:1010} Bathran's Hair
	["{quest:1010}, from the plant bundles"] = "{quest:1010}, dos feixes de plantas",

	-- Step 6: Astranaar
	-- {area:413} Maestra's Post · {npc:3845} Shindrell Swiftfire · {npc:4079} Sentinel Thenysil · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["The road from {area:413} comes in by the flight master: {npc:3845} and {npc:4079} stand there, {npc:3691} in the inn, {npc:3894} inside the building beyond it."] = "A estrada vinda de {area:413} chega junto ao mestre de voo: {npc:3845} e {npc:4079} ficam lá, {npc:3691} na estalagem, {npc:3894} dentro do prédio depois dela.",
	-- {npc:3691} Raene Wolfrunner
	["{npc:3691}, in the inn"] = "{npc:3691}, na estalagem",
	-- {npc:3691} Raene Wolfrunner · {quest:990} Trek to Ashenvale · {area:442} Auberdine
	["{npc:3691}: {quest:990}, from {area:442}"] = "{npc:3691}: {quest:990}, de {area:442}",
	-- {npc:3894} Pelturas Whitemoon
	["{npc:3894}, inside"] = "{npc:3894}, lá dentro",

	-- Step 7: Teronis' Corpse
	-- {area:441} Lake Falathim · {item:5463} Glowing Gem
	["Head west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Siga para oeste até a margem de {area:441}. Teronis está caído no meio dos murlocs Babassal; qualquer murloc pode deixar cair a {item:5463}.",

	-- Step 8: Shrine of Aessina
	-- {npc:3585} Therysil · {area:416} Shrine of Aessina
	["South of the murlocs, {npc:3585} waits at the {area:416}."] = "Ao sul dos murlocs, {npc:3585} espera no {area:416}.",

	-- Step 9: Elune's Tear
	-- {area:415} Astranaar
	["The tears glow on the small isle east of {area:415}."] = "As lágrimas brilham na ilhota a leste de {area:415}.",

	-- Step 11: Stonetalon Mountains
	-- {area:421} Mystral Lake · {area:1276} Talondeep Path · {area:461} Windshear Crag · {area:2160} Windshear Mine
	["Head south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}, north of the {area:2160}."] = "Siga para o sul, passando por {area:421}, até o túnel de {area:1276}; ele sai em {area:461}, na Cordilheira das Torres de Pedra, ao norte de {area:2160}.",

	-- Step 12: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} at the east end of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "A defesa de {npc:4276} é difícil sozinho neste nível: recomenda-se formar grupo, procure gente para fazer junto. Pule se estiver sozinho.\n{npc:4276} minera no fundo de {area:2160}, no extremo leste do penhasco, depois dos kobolds dali (níveis 19-23). Fale com ele e depois mantenha-o vivo por cinco minutos enquanto ele minera: uma dúzia ou mais de kobolds vêm para cima dele em ondas, primeiro os combatentes corpo a corpo, depois os conjuradores, e os próprios kobolds da mina reaparecem na luta. Se ele morrer, a missão falha.",
	["Below ground"] = "No subterrâneo",
	-- {npc:4276} Piznik
	["Keep {npc:4276} alive while he mines, below ground"] = "Mantenha {npc:4276} vivo enquanto ele minera, no subterrâneo",

	-- Step 13: Windshear Crag
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle · {area:1076} Webwinder Path
	["{npc:4080} and {npc:4077} camp on the {area:1076}, south-west of the mine."] = "{npc:4080} e {npc:4077} acampam em {area:1076}, a sudoeste da mina.",

	-- Step 14: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4080} Kaela Shadowspear · {npc:4077} Gaxim Rustfizzle
	["His hut stands just north of {npc:4080} and {npc:4077}."] = "A cabana dele fica logo ao norte de {npc:4080} e {npc:4077}.",
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}, lá dentro",

	-- Step 16: Windshear Crag: kill these as you meet them
	-- {area:461} Windshear Crag
	["{area:461}: kill these as you meet them"] = "{area:461}: vá matando estes pelo caminho",
	-- {area:461} Windshear Crag
	["The Venture Co. clear the forest of {area:461}. Loggers and Deforesters work all over it; the Operators run the shredders and one carries the blueprints."] = "A Empreendimentos S.A. desmata a floresta do {area:461}. Madeireiros e Desmatadores trabalham por toda parte; os Operadores pilotam os retalhadores e um deles leva as plantas.",

	-- Step 17: Webwinder Path
	["Inside"] = "Lá dentro",

	-- Step 18: The Ruins of Stardust
	-- {area:1276} Talondeep Path · {area:421} Mystral Lake
	["Back north through the {area:1276}: west of {area:421}, the stardust bushes grow among the ruins."] = "De volta ao norte por {area:1276}: a oeste de {area:421}, os arbustos de poeira estelar crescem entre as ruínas.",

	-- Step 19: Alonso
	-- {npc:210995} Alonso · {area:1276} Talondeep Path
	["{npc:210995} may not offer these to every class; if he doesn't, carry on.; walks around {area:1276}: the map marks where to look"] = "{npc:210995} pode não oferecer estas para todas as classes; se não oferecer, siga em frente.; anda por {area:1276}: o mapa marca onde procurar",

	-- Step 20: Mystral Lake
	-- {npc:3885} Sentinel Velene Starstrike · {area:420} Silverwind Refuge · {area:421} Mystral Lake · {npc:210995} Alonso
	-- plural, as words: Befouled Water Elementals = {npc:3917} Befouled Water Elemental
	["{npc:3885} stands at the {area:420} on the east shore of {area:421}; {npc:210995} camps on its west shore. Befouled Water Elementals wade in the lake between them."] = "{npc:3885} fica no {area:420}, na margem leste do {area:421}; {npc:210995} acampa na margem oeste. Elementais da Água Contaminados vagam pelo lago entre eles.",
	["Underwater"] = "Debaixo d'água",
	-- {item:5456} Divining Scroll
	-- plural, as words: Intact Elemental Bracers = {item:12220} Intact Elemental Bracer
	["Kill the elementals for 5 Intact Elemental Bracers, then use the {item:5456}"] = "Mate os elementais por 5 Braçadeiras Elementais Intactas e depois use o {item:5456}",

	-- Step 21: The Foulweald
	["The Foulweald"] = "Os Torpeflora",
	-- {area:415} Astranaar
	["The Foulweald furbolgs live in the woods south of the road, south-east of {area:415}. The Den Watcher and the Ursas guard the den."] = "Os furbolgs Torpeflora vivem na mata ao sul da estrada, a sudeste de {area:415}. O Vigia do Covil Torpeflora e os Ursinos Torpeflora guardam o covil.",

	-- Step 22: Shael'dryn
	-- {area:419} Howling Vale · {npc:3916} Shael'dryn
	["Follow the road east to the {area:419}; {npc:3916} stands by the moonwell."] = "Siga a estrada para leste até o {area:419}; {npc:3916} fica junto ao poço lunar.",

	-- Step 23: Dal Bloodclaw
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar
	["{npc:3987} (25) leads the Thistlefur furbolgs at the camp north of {area:415}. Clear his guards first, one at a time.\nCareful: The furbolgs near him usually join in when he is pulled. Killing the ones along his path first lets you fight him alone."] = "{npc:3987} (25) lidera os furbolgs Pelocardo no acampamento ao norte de {area:415}. Limpe os guardas dele antes, um de cada vez.\nCuidado: os furbolgs perto dele costumam entrar na briga quando ele é puxado. Matando antes os que ficam no caminho dele, você luta com ele sozinho.",

	-- Step 24: Ilkrud Magthrull
	-- {npc:3987} Dal Bloodclaw · {area:415} Astranaar · {area:412} Ruins of Ordil'Aran · {npc:3664} Ilkrud Magthrull
	["From {npc:3987}'s camp head south-west past {area:415} (its hand-ins wait for the way back) to the {area:412} south of the shrine: {npc:3664} and his voidwalkers hold them. Pull his guards first."] = "Do acampamento de {npc:3987}, siga para sudoeste, passando por {area:415} (as entregas de lá esperam a volta), até {area:412}, ao sul do santuário: {npc:3664} e seus emissários do caos as dominam. Puxe os guardas dele primeiro.",

	-- Step 25: The Zoram Strand
	-- {area:414} Zoram Strand · {npc:3846} Talen
	["Follow the coast north to the {area:414}. {npc:3846} camps on the beach; Wrathtail nagas fill the shore."] = "Siga a costa para o norte até a {area:414}. {npc:3846} acampa na praia; nagas Iracauda enchem a margem.",
	-- {item:5424} Ancient Statuette
	["{item:5424}, in the ruins on the shore"] = "{item:5424}, nas ruínas da margem",
	-- {item:5490} Wrathtail Head
	["{item:5490}: any Wrathtail naga on the strand"] = "{item:5490}: qualquer naga Iracauda da praia",

	-- Step 27: Ruuzel
	-- {quest:1009} Ruuzel · {area:414} Zoram Strand
	["{quest:1009} walks the northern tip of the {area:414} with Wrathtail guards."] = "{quest:1009} anda pela ponta norte da {area:414} com guardas Iracauda.",

	-- Step 29: Maestra's Post
	-- {npc:3663} Delgren the Purifier · {zone:1440} Ashenvale
	["{npc:3663}: its circles are for your next {zone:1440} visit, at about 28"] = "{npc:3663}: os círculos dele ficam para a sua próxima visita a {zone:1440}, por volta do nível 28",

	-- Step 30: Astranaar
	-- {area:413} Maestra's Post · {area:415} Astranaar · {npc:3845} Shindrell Swiftfire · {npc:3691} Raene Wolfrunner · {npc:3894} Pelturas Whitemoon
	["Follow the road south-east from {area:413} back to {area:415}: {npc:3845} by the flight master, {npc:3691} in the inn, {npc:3894} inside."] = "Siga a estrada para sudeste, de {area:413} de volta a {area:415}: {npc:3845} junto ao mestre de voo, {npc:3691} na estalagem, {npc:3894} lá dentro.",

	-- Step 31: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Voe para {area:442}",
	-- {area:415} Astranaar
	["{area:415} flight master"] = "Mestre de voo de {area:415}",

	-- Step 32: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",

	-- Step 33: To Menethil Harbor
	-- {area:150} Menethil Harbor
	["To {area:150}"] = "Até {area:150}",

	-- Step 34: Menethil Harbor
	-- {npc:1242} Karl Boran · {npc:2094} James Halloran · {npc:2086} Valstag Ironjaw · {npc:1239} First Mate Fitzsimmons · {npc:1480} Caitlin Grassman · {npc:2111} Sida · {npc:2096} Tarrel Rockweaver
	["Off the boat, walk up the pier: {npc:1242} on the pier, {npc:2094} by the docks to the north, {npc:2086} in the keep, the inn ({npc:1239}) east of it with {npc:1480} and {npc:2111} beside it, {npc:2096} by the north gate on the way out east."] = "Ao descer do barco, suba o cais: {npc:1242} no cais, {npc:2094} junto às docas ao norte, {npc:2086} na bastilha, a estalagem ({npc:1239}) a leste dela, com {npc:1480} e {npc:2111} ao lado, {npc:2096} junto ao portão norte, na saída para o leste.",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier north of the inn"] = "{npc:1242}, no píer ao norte da estalagem",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, by the keep; inside"] = "{npc:2086}, junto à fortaleza; lá dentro",
	-- {npc:1239} First Mate Fitzsimmons
	["{npc:1239}, in the inn"] = "{npc:1239}, na estalagem",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}: he won't offer 305 while you carry it"] = "{npc:2096}: ele não oferece a 305 enquanto você estiver com ela",
	-- {npc:2096} Tarrel Rockweaver
	["{npc:2096}, by the north gate"] = "{npc:2096}, perto do portão norte",

	-- Step 35: Spoils of War
	["Timber and iron piles lie around the keep and along the harbor's walls."] = "Pilhas de madeira e de ferro estão em volta da fortaleza e ao longo das muralhas do porto.",

	-- Step 36: Bluegill Marsh
	-- {npc:1259} Gobbler
	-- plural, as words: Bluegill Murlocs = {npc:1024} Bluegill Murloc
	["Follow the coast north out of Menethil. Bluegill Murlocs fill the marsh; {npc:1259} walks with a pack in the middle of it."] = "Siga a costa para o norte saindo de Menethil. Murlocs Guelrazul enchem o pântano; {npc:1259} anda com um bando no meio dele.",

	-- Step 37: Young crocolisks
	["Young crocolisks"] = "Crocoliscos jovens",
	-- {zone:1437} Wetlands
	-- plural, as words: Young Wetlands Crocolisks = {npc:1417} Young Wetlands Crocolisk
	["From the marsh head east across the {zone:1437}. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Do pântano, siga para leste atravessando {zone:1437}. Crocoliscos do Pantanal Jovens espreitam nas poças ao norte do sítio de escavação.",

	-- Step 38: Whelgar's Excavation Site
	["The excavation site sits on the hill south of the road."] = "O sítio de escavação fica na colina ao sul da estrada.",
	-- {npc:1076} Merrin Rockweaver
	["{npc:1076}, below ground"] = "{npc:1076}, no subterrâneo",

	-- Step 39: The raptor hills
	["The raptor hills"] = "As colinas dos raptores",
	-- {npc:1021} Mottled Screecher
	-- plural, as words: Mottled Raptors = {npc:1020} Mottled Raptor · Mottled Screechers = {npc:1021} Mottled Screecher
	["Mottled Raptors and Screechers roam the hills west of the excavation site.\nCareful: Once a {npc:1021} drops to 30% health, it calls for help from creatures within 20 yd. Mottled Screechers frequently come in packs of three, and raptors summoned by their calls for help may also join the fight."] = "Raptores e Guinchadores Mosqueados andam pelas colinas a oeste da escavação.\nCuidado: quando um {npc:1021} cai para 30% de vida, chama ajuda de bichos num raio de 20 metros. Os Guinchadores Mosqueados costumam andar em trios, e os raptores chamados por eles também podem entrar na briga.",

	-- Step 40: Ormer Ironbraid
	-- {npc:1078} Ormer Ironbraid · {zone:1437} Wetlands
	["{npc:1078}: the bigger raptors in the valley west of the dig are for your next {zone:1437} visit, at about 27"] = "{npc:1078}: os raptors maiores do vale a oeste da escavação ficam para a sua próxima visita a {zone:1437}, por volta do nível 27",

	-- Step 41: The Green Belt
	-- {npc:2093} Einar Stonegrip · {npc:1244} Rethiel the Greenwarden
	["{npc:2093} camps by the road; {npc:1244} stands farther east, by the river."] = "{npc:2093} acampa junto à estrada; {npc:1244} fica mais a leste, junto ao rio.",

	-- Step 42: Thelgen Rock
	-- {area:1021} Thelgen Rock
	-- plural, as words: Cave Stalkers = {npc:4040} Cave Stalker · Leech Stalkers = {npc:1111} Leech Stalker
	["Cave Stalkers and Leech Stalkers fill {area:1021}, the cave south-east of the excavation site."] = "Espreitadoras da Caverna e Espreitadoras Sanguessugas enchem {area:1021}, a caverna a sudeste do sítio de escavação.",

	-- Step 43: The Mosshide gnolls
	["The Mosshide gnolls"] = "Os gnolls Pelemusgo",
	-- {area:1025} The Green Belt
	-- plural, as words: Mosshide Gnolls = {npc:1007} Mosshide Gnoll
	["Mosshide Gnolls and Mongrels hold the hills south-east of the {area:1025}."] = "Gnolls Pelemusgo e Mestiços ocupam as colinas a sudeste da {area:1025}.",

	-- Step 44: Rethiel the Greenwarden
	-- {area:309} Ironbeard's Tomb · {npc:1244} Rethiel the Greenwarden · {zone:1437} Wetlands
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["Its flint comes from the Mosshide Fenrunners on the way to {area:309}; {npc:1244} takes it on your next {zone:1437} visit"] = "O sílex vem dos Corre-charcos Pelemusgo no caminho para {area:309}; {npc:1244} o recebe na sua próxima visita a {zone:1437}",

	-- Step 45: Ironbeard's Tomb
	-- {npc:1244} Rethiel the Greenwarden · {area:309} Ironbeard's Tomb · {area:205} Dun Modr · {npc:2111} Sida
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner · Monstrous Oozes = {npc:1033} Monstrous Ooze
	["North-west from {npc:1244}: Mosshide Fenrunners and Mistweavers roam the riverbanks on the way, and almost every one drops flint. Black, Crimson and Monstrous Oozes fill {area:309}, just west of the road to {area:205} and north of Einar's camp. Any ooze there may hold {npc:2111}'s bag."] = "A noroeste de {npc:1244}: Corre-charcos e Tecebrumas Pelemusgo vagam pelas margens do rio no caminho, e quase todos soltam sílex. Gosmas Pretas, Carmesim e Monstruosas enchem {area:309}, logo a oeste da estrada para {area:205} e ao norte do acampamento de Einar. Qualquer gosma lá pode guardar a bolsa de {npc:2111}.",
	-- {item:2611} Crude Flint
	-- plural, as words: Mosshide Fenrunners = {npc:1010} Mosshide Fenrunner
	["{item:2611}: Mosshide Fenrunners and Mistweavers"] = "{item:2611}: Corre-charcos e Tecebrumas Pelemusgo",

	-- Step 46: Menethil
	["Menethil"] = "Menethil",
	-- {npc:2096} Tarrel Rockweaver · {npc:2111} Sida · {npc:1480} Caitlin Grassman · {npc:2086} Valstag Ironjaw · {npc:2094} James Halloran · {npc:1242} Karl Boran
	["Back west along the road into Menethil: {npc:2096} by the road in, {npc:2111} and {npc:1480} at the inn, {npc:2086} in the keep, {npc:2094} on the west side by the docks, {npc:1242} on the pier north of the inn."] = "De volta para oeste pela estrada até Menethil: {npc:2096} na entrada da estrada, {npc:2111} e {npc:1480} na estalagem, {npc:2086} na bastilha, {npc:2094} no lado oeste, junto às docas, {npc:1242} no cais ao norte da estalagem.",
	-- {npc:1480} Caitlin Grassman
	["{npc:1480}, inside"] = "{npc:1480}, lá dentro",
	-- {npc:2086} Valstag Ironjaw
	["{npc:2086}, in the keep"] = "{npc:2086}, na bastilha",
	-- {npc:1242} Karl Boran
	["{npc:1242}, on the pier"] = "{npc:1242}, no cais",

	-- Step 47: Fly to Ironforge
	-- {area:1537} Ironforge
	["Fly to {area:1537}"] = "Voe para {area:1537}",
	-- {npc:1571} Shellei Brondir
	["{npc:1571} is the flight master by Menethil's inn: you have both flight paths since your first trip east."] = "{npc:1571} é o mestre de voo junto à estalagem de Menethil: você já tem as duas rotas de voo desde a sua primeira viagem ao leste.",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Mestre de voo de {area:150}",

	-- Step 48: Ironforge
	-- {object:32372} Great Forge (no name in this language: may be words) · {npc:4081} Lomac Gearstrip · {object:171524} Tinker Town · {area:2257} Deeprun Tram
	["The gryphons land in the {object:32372}. {npc:4081} stands in {object:171524}, east of it, by the {area:2257}."] = "Os grifos pousam na {object:32372}. {npc:4081} fica em {object:171524}, a leste dela, junto a {area:2257}.",
	-- {item:5352} Book: The Powers Below · {zone:1439} Darkshore · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["Only with {item:5352} from {zone:1439}: {npc:2786}, the {object:32383}"] = "Só com o {item:5352} de {zone:1439}: {npc:2786}, na {object:32383}",

	-- Step 49: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:197} com {npc:11865} ({object:32359}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 50: Buliwyf Stonehand
	-- {spell:199} Two-Handed Maces · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:199} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:199} com {npc:11865} ({object:32359}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 51: Buliwyf Stonehand
	-- {spell:197} Two-Handed Axes · {npc:11865} Buliwyf Stonehand · {object:32359} Military Ward (no name in this language: may be words)
	["While you're here: learn {spell:197} from {npc:11865} ({object:32359}, 10 silver); two-handers level a Paladin fastest."] = "Já que está aqui: aprenda {spell:197} com {npc:11865} ({object:32359}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Paladino.",

	-- Step 52: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Metrô para {zone:1453}",

	-- Step 53: Baros Alexston
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:1646} Baros Alexston
	["The tram comes in at the {object:28027}; walk west to the {object:2098}: {npc:1646} stands at its east side. (The route hands his letter in at the end of 03-loch-modan; this is for a character still carrying it.)"] = "O metrô chega no {object:28027}; siga para oeste até {object:2098}: {npc:1646} fica no lado leste dela. (A rota entrega a carta dele no fim de 03-loch-modan; isto é para um personagem que ainda a leva.)",
	-- {npc:1646} Baros Alexston · {area:442} Auberdine
	["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: a carta de Trovejius de {area:442}",
	-- {npc:3649} Thundris Windweaver · {area:442} Auberdine
	["For {npc:3649}, back in {area:442} (06-wetlands)"] = "Para {npc:3649}, de volta em {area:442} (06-wetlands)",

	-- Step 54: Cathedral Square
	-- {object:28027} Dwarven District · {object:2098} Cathedral Square · {npc:376} High Priestess Laurena
	["The tram comes in at the {object:28027}; walk west to the {object:2098}. {npc:376} is in the Cathedral of Light."] = "O metrô chega no {object:28027}; siga para oeste até {object:2098}. {npc:376} está na Catedral da Luz.",
	-- {npc:376} High Priestess Laurena · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["{npc:376}: {npc:11406} in {zone:1455} takes it, later"] = "{npc:376}: {npc:11406} em {zone:1455} a recebe, mais tarde",
	-- {npc:376} High Priestess Laurena · {npc:258785} High Priestess Mims · {zone:1455} Ironforge
	["{npc:376}: {npc:258785} in {zone:1455} takes it, later"] = "{npc:376}: {npc:258785} em {zone:1455} a recebe, mais tarde",
	-- {npc:376} High Priestess Laurena · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["{npc:376}: {npc:11401} in {zone:1457} takes it, later"] = "{npc:376}: {npc:11401} em {zone:1457} a recebe, mais tarde",

	-- Step 55: Master Mathias Shaw
	-- {object:2100} Old Town
	["Mathias Shaw is at SI:7 in {object:2100}, south of the Keep."] = "Mathias Shaw fica no SI:7 na {object:2100}, ao sul da Fortaleza.",
	-- {npc:332} Master Mathias Shaw · {npc:7024} Agent Kearnen · {zone:1436} Westfall · {zone:1431} Duskwood
	["{npc:332}: {npc:7024} in {zone:1436} takes it, at the end of {zone:1431}'s second loop"] = "{npc:332}: {npc:7024} em {zone:1436} a recebe, no fim do segundo circuito de {zone:1431}",

	-- Step 56: Collin Mauren
	-- {object:2164} The Slaughtered Lamb · {object:2101} Mage Quarter · {npc:6122} Gakin the Darkbinder
	["{object:2164} is in the {object:2101}. Warlocks: {npc:6122} is in its cellar."] = "O {object:2164} fica no {object:2101}. Bruxos: {npc:6122} fica no porão dele.",
	-- {npc:6122} Gakin the Darkbinder · {npc:6244} Takar the Seer · {zone:1413} Barrens
	["{npc:6122}: {npc:6244} in the {zone:1413} takes it, later"] = "{npc:6122}: {npc:6244} em {zone:1413} a recebe, mais tarde",

	-- Step 57: Trade District
	-- {zone:1453} Stormwind · {zone:1431} Duskwood
	["Next: training in {zone:1453}, then the road east through Elwynn and south to {zone:1431}."] = "A seguir: treino em {zone:1453}, depois a estrada para leste por Elwynn e para o sul até {zone:1431}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the Cathedral of Light: {npc:928} stands inside."] = "De volta à Catedral da Luz: {npc:928} fica lá dentro.",
	-- ["Black Oozes"] = "Gosmas Pretas",
	-- ["Black Oozes creep through the marsh north of the {area:1025} road, west of {npc:2093}'s camp. Any ooze may hold {npc:2111}'s bag."] = "Gosmas Pretas rastejam pelo pântano ao norte da estrada da {area:1025}, a oeste do acampamento de {npc:2093}. Qualquer gosma pode ter a bolsa de {npc:2111}.",
	-- ["Cathedral of Light"] = "Catedral da Luz",
	-- ["Dragonmaw camp"] = "Acampamento Presa do Dragão",
	-- ["Escort {npc:11218} to {area:413} in {area:331}."] = "Escolte {npc:11218} até {area:413}, em {area:331}.",
	-- ["Fen Creepers"] = "Rastejantes do Pântano",
	-- ["Fen Creepers hide in the marsh pools north-west of the {area:1025}."] = "Rastejantes do Pântano se escondem nas poças do pântano a noroeste da {area:1025}.",
	-- ["Follow the road east. Young Wetlands Crocolisks lurk in the pools north of the excavation site."] = "Siga a estrada para leste. Crocoliscos do Pantanal Jovens espreitam nas poças ao norte do sítio de escavação.",
	-- ["Follow the road north to {area:205}, at the foot of the {area:881}. {npc:1071} stands in the dwarves' camp."] = "Siga a estrada para o norte até {area:205}, ao pé da {area:881}. {npc:1071} fica no acampamento dos anões.",
	-- ["Follow the road south-east to {area:415}, on the island in the lake."] = "Siga a estrada para sudeste até {area:415}, na ilha do lago.",
	-- ["For Bolvar Fordragon in {object:2117}: keep it"] = "Para Bolvar Fordragon na {object:2117}: guarde-o",
	-- ["For the giant crocolisks of the north coast, on your next visit"] = "Para os crocoliscos gigantes da costa norte, na sua próxima visita",
	-- ["For {npc:2228} in {area:271}: keep it"] = "Para {npc:2228} em {area:271}: guarde-o",
	-- ["From {area:17203} take the boat to {area:442}; {npc:3649} stands at the north end of the village. Then ride south along the road through {zone:1439}."] = "De {area:17203}, pegue o navio até {area:442}; {npc:3649} fica no extremo norte da vila. Depois cavalgue para o sul pela estrada através de {zone:1439}.",
	-- ["Hearth to Menethil"] = "Regressar para Menethil",
	-- ["Hearthstone on cooldown? Ride back north through the {area:1276}."] = "Pedra de Regresso em recarga? Volte para o norte pela {area:1276}.",
	-- ["Mosshide Fenrunners and Mistweavers roam the riverbanks just west and south of {npc:1244}; almost every one drops flint."] = "Corre-charcos Pelemusgo e Tecebrumas vagam pelas margens do rio logo a oeste e ao sul de {npc:1244}; quase todos deixam cair pederneira.",
	-- ["Mottled Raptors and Screechers roam the hills west of the excavation site."] = "Raptores Mosqueados e Guinchadores vagam pelas colinas a oeste do sítio de escavação.",
	-- ["Next: fly to {area:42}."] = "Próximo: voe até {area:42}.",
	-- ["Only if you looted {quest:337} in {zone:1431}"] = "Só se você saqueou {quest:337} em {zone:1431}",
	-- ["Only once {quest:97914} is handed in: for {npc:3649}, back in {area:442} (06-wetlands)"] = "Só depois de entregar {quest:97914}: para {npc:3649}, de volta a {area:442} (06-wetlands)",
	-- ["Raptor valley"] = "Vale dos raptores",
	-- ["Ride east along the {zone:1437} road, south through {area:836} into {zone:1432} and west through the tunnel into {zone:1426} to {area:1537}."] = "Cavalgue para leste pela estrada do {zone:1437}, para o sul por {area:836} até {zone:1432} e para oeste pelo túnel até {zone:1426}, até {area:1537}.",
	-- ["Ride south past {area:421} into the {area:1276} tunnel; it comes out in Stonetalon's {area:461}. {npc:4080} and {npc:4077} camp on the {area:1076} south-west of the crag."] = "Cavalgue para o sul, passando o {area:421}, até o túnel da {area:1276}; ele sai no {area:461}, na Cordilheira das Torres de Pedra. {npc:4080} e {npc:4077} acampam na {area:1076}, a sudoeste do penhasco.",
	-- ["Ride west to the shore of {area:441}. Teronis lies among the Saltspittle murlocs; any murloc can drop the {item:5463}."] = "Cavalgue para oeste até a margem do {area:441}. O cadáver de Teronis está entre os murlocs Babassal; qualquer murloc pode deixar cair a {item:5463}.",
	-- ["Take the boat from {area:17203} to {area:442} and fly to {area:702}; {npc:11401} is in the Temple of the Moon. Then fly back to {area:442}."] = "Pegue o navio de {area:17203} até {area:442} e voe até {area:702}; {npc:11401} está no Templo da Lua. Depois voe de volta a {area:442}.",
	-- ["Take the boat from {area:17203} to {area:442}. Join the two half pendants into the {item:15885} and cast {spell:18960}: {npc:11802} is in {area:2361}. Then fly to {area:702} (by way of {area:442})."] = "Pegue o navio de {area:17203} até {area:442}. Junte as duas metades do pingente no {item:15885} e lance {spell:18960}: {npc:11802} está em {area:2361}. Depois voe até {area:702} (passando por {area:442}).",
	-- ["Take the portal up to the {area:1658}, then fly back to {area:442}."] = "Pegue o portal até o {area:1658} e depois voe de volta a {area:442}.",
	-- ["Take the {area:2257} from {object:171524} to {zone:1453}'s {object:28027}, then walk to the {object:2098}."] = "Pegue o {area:2257} em {object:171524} até o {object:28027} de {zone:1453}, depois ande até a {object:2098}.",
	-- ["The Bluegill hovels"] = "As choças Guelrazul",
	-- ["The Dragonmaw camp lies south of the road, just west of the {area:1025}: Raiders, Swamprunners and Bonewarders. {npc:2092}'s quest in {zone:1426} needs level 28."] = "O acampamento Presa do Dragão fica ao sul da estrada, logo a oeste da {area:1025}: Saqueadores, Corre-brejos e Guarda-ossos. A missão de {npc:2092} em {zone:1426} requer nível 28.",
	-- ["The bigger raptors hunt in the valley just west of the dig."] = "Os raptores maiores caçam no vale logo a oeste da escavação.",
	-- ["The excavation site sits on the hill south of the road."] = "O sítio de escavação fica na colina ao sul da estrada.",
	-- ["The raptor hills"] = "As colinas dos raptores",
	-- ["The tram comes in at the {object:28027}; walk west to the {object:2098}. {npc:1646} stands at its east side, {npc:376} in the Cathedral of Light."] = "O metrô chega no {object:28027}; siga para oeste até a {object:2098}. {npc:1646} fica no lado leste dela, {npc:376} na Catedral da Luz.",
	-- ["The {area:1025}"] = "{area:1025}",
	-- ["Three containers in the murloc hovels, south to north: the {object:261}, then the {object:142151}, then the {object:259} at the north end."] = "Três recipientes nas choças dos murlocs, de sul a norte: o {object:261}, depois o {object:142151}, depois o {object:259} no extremo norte.",
	-- ["Venture Co. loggers"] = "Madeireiros da Empreendimentos S.A.",
	-- ["West of Mystral Lake, the stardust bushes grow among the ruins."] = "A oeste do Lago Mistral, os arbustos de poeira estelar crescem entre as ruínas.",
	-- ["grind on Dragonmaw Raiders and Swamprunners at the Dragonmaw camp, {zone:1437}"] = "farme Saqueadores Presa do Dragão e Corre-brejos no acampamento Presa do Dragão, {zone:1437}",
	-- ["{item:15885}: join the two halves"] = "{item:15885}: junte as duas metades",
	-- ["{npc:11406} and {npc:258785} are in the {object:32386}, in the {object:32362}."] = "{npc:11406} e {npc:258785} estão no {object:32386}, na {object:32362}.",
	-- ["{npc:1242}: for {npc:2104} in the keep"] = "{npc:1242}: para {npc:2104} na fortaleza",
	-- ["{npc:1440}, in the Royal Library"] = "{npc:1440}, na Biblioteca Real",
	-- ["{npc:1444}, in the {object:2098}"] = "{npc:1444}, na {object:2098}",
	-- ["{npc:1573}, in the {object:32372}"] = "{npc:1573}, na {object:32372}",
	-- ["{npc:1646}: Thundris' letter from {area:442}"] = "{npc:1646}: a carta de Trovejius de {area:442}",
	-- ["{npc:2086}, by the keep"] = "{npc:2086}, perto da fortaleza",
	-- ["{npc:2094}, by the north gate"] = "{npc:2094}, perto do portão norte",
	-- ["{npc:2097}, by the north gate"] = "{npc:2097}, perto do portão norte",
	-- ["{npc:2104} stands in {area:2103}, a short walk from {npc:1242}."] = "{npc:2104} fica na {area:2103}, a uma curta caminhada de {npc:1242}.",
	-- ["{npc:3649}: Alexston's reply"] = "{npc:3649}: a resposta de Alexston",
	-- ["{npc:3664} and his voidwalkers hold the {area:412} south of the shrine. Pull his guards first."] = "{npc:3664} e seus emissários do caos ocupam as {area:412} ao sul do santuário. Atraia os guardas dele primeiro.",
	-- ["{npc:3691}: {quest:990}, from {area:442} (others take it on the next {area:331} visit)"] = "{npc:3691}: {quest:990}, de {area:442} (os outros pegam na próxima visita a {area:331})",
	-- ["{npc:3987} (25) leads the Thistlefur gnolls at the camp north of {area:415}. Clear his guards first, one at a time."] = "{npc:3987} (25) lidera os gnolls Pelocardo no acampamento ao norte de {area:415}. Elimine os guardas dele primeiro, um de cada vez.",
	-- ["{npc:4201}, in the hut north of them"] = "{npc:4201}, na cabana ao norte deles",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines."] = "{npc:4276} minera na {area:2160}, no extremo leste do penhasco. Fale com ele e afaste os atacantes da Empreendimentos S.A. enquanto ele minera.",
	-- ["{npc:4276} mines in the {area:2160} at the east end of the crag. Talk to him and fend off the Venture Co. raiders while he mines.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "{npc:4276} trabalha em {area:2160}, na ponta leste do penhasco. Fale com ele e segure os saqueadores da Empreendimentos S.A. enquanto ele minera.\nCuidado: os kobolds chegam em ondas. A primeira é de corpo a corpo, a segunda mistura lançadores de feitiço. Os monstros comuns da mina renascem rápido e podem entrar na briga durante as ondas. Melhor ir em grupo.",
	-- ["{npc:482}, the cheese shop in the {object:2096}"] = "{npc:482}, a loja de queijos no {object:2096}",
	-- ["{npc:4959} and {npc:482}"] = "{npc:4959} e {npc:482}",
	-- ["{npc:4982}, in the Cathedral of Light"] = "{npc:4982}, na Catedral da Luz",
	-- ["{object:2164} is in the {object:2101}."] = "{object:2164} fica no {object:2101}.",
	-- ["{zone:1455} priests"] = "Sacerdotes de {zone:1455}",
}
