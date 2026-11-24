-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/03-ashenvale (forever/alliance/30-40/03-ashenvale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",

	-- Step 2: Red Jack Flint
	-- {npc:4455} Red Jack Flint · {area:2103} Menethil Keep
	["{npc:4455} stands by {area:2103}'s door, just north of the flight master."] = "{npc:4455} fica junto à porta de {area:2103}, logo ao norte do mestre de voo.",
	-- {quest:1132} Fiora Longears
	["For {quest:1132} in Theramore's inn, where this guide's boat goes"] = "Para {quest:1132} na estalagem de Theramore, para onde vai o barco deste guia",

	-- Step 3: Glorin Steelbrow
	-- {npc:1217} Glorin Steelbrow · {area:2104} Deepwater Tavern · {npc:4963} Mikhail · {npc:5082} Vincent Hyal
	["{npc:1217} stands in the {area:2104}, south of the keep, where {npc:4963} and {npc:5082} wait too."] = "{npc:1217} fica em {area:2104}, ao sul da fortaleza, onde {npc:4963} e {npc:5082} também esperam.",
	["Inside"] = "Lá dentro",

	-- Step 4: Deepwater Tavern
	-- {quest:1248} The Missing Diplomat · {npc:4963} Mikhail
	["Tapoke Jahn (34) slips out of the tavern once you take {quest:1248}: stay close behind him. He turns on you outside, a friend joins him, and he gives up once badly hurt. If you lose him the quest fails: abandon it and take it again from {npc:4963}."] = "Tapoke Jahn (34) sai furtivamente da taverna assim que você aceita {quest:1248}: fique bem atrás dele. Ele se vira contra você do lado de fora, um amigo se junta a ele, e ele desiste quando está muito ferido. Se você o perder, a missão falha: abandone-a e pegue de novo com {npc:4963}.",

	-- Step 5: Waterlogged Chest
	["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "O navio naufragado está nas águas rasas ao sul da fortaleza.",

	-- Step 6: Lightforge Ingots
	-- plural, as words: Lightforge Ingots = {item:2702} Lightforge Ingot
	["Lightforge Ingots"] = "Lingotes da Forja de Luz",
	["The Bluegill murlocs on the beach south-west of Menethil carry the ingots."] = "Os murlocs Guelrazul na praia a sudoeste de Menethil carregam os lingotes.",
	-- {item:2702} Lightforge Ingot
	["{item:2702}; underwater"] = "{item:2702}; debaixo d'água",

	-- Step 7: Glorin Steelbrow
	-- {npc:1416} Grimand Elmore · {zone:1453} Stormwind
	["For {npc:1416} in {zone:1453}, after Stranglethorn"] = "Para {npc:1416} em {zone:1453}, depois da Selva do Espinhaço",

	-- Step 9: Theramore
	["Theramore"] = "Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "O mestre de voo fica junto ao portão de {area:514}; {npc:5083} e {npc:4964} estão dentro da cidadela.",
	-- {npc:5083} Clerk Lendry
	["{npc:5083}, on the top floor"] = "{npc:5083}, no último andar",
	-- {npc:4964} Commander Samaul
	["{npc:4964}, on the top floor"] = "{npc:4964}, no último andar",
	-- {npc:4964} Commander Samaul · {area:503} Sentry Point
	["{npc:4964}: {area:503} is the watchtower on the road west, next"] = "",
	-- {quest:1132} Fiora Longears
	["{quest:1132}, inside the inn in the north of town"] = "{quest:1132}, dentro da estalagem no norte da cidade",
	-- {npc:4456} Fiora Longears · {area:415} Astranaar
	["{npc:4456}'s next errand goes to {area:415}, off this route: leave it."] = "A próxima tarefa de {npc:4456} vai para {area:415}, fora desta rota: deixe-a.",
	-- {quest:1132} Fiora Longears · {zone:1441} Thousand Needles
	["{quest:1132}: the wyverns are in {zone:1441}, later in this guide"] = "{quest:1132}: as serpes ficam em {zone:1441}, mais adiante neste guia",

	-- Step 10: Sentry Point
	-- {area:503} Sentry Point · {area:403} Shady Rest Inn · {npc:4967} Archmage Tervosh
	["Follow the road north-west out of Theramore to the watchtower at {area:503}, where the road to the {area:403} turns west. Look around the tower: {npc:4967} appears at its foot, and you hand the quest in to him there."] = "",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, at the foot of the tower"] = "",
	-- {npc:4967} Archmage Tervosh · {npc:4966} Private Hendel · {area:504} North Point Tower · {zone:1445} Dustwallow Marsh
	["{npc:4967}: {npc:4966} holds {area:504}, for the {zone:1445} visit at 39"] = "",
	-- {npc:4966} Private Hendel · {zone:1445} Dustwallow Marsh
	["Take Tervosh's next errand now: he stands here only right after the hand-in. {npc:4966} waits for the next {zone:1445} visit, at about 39."] = "",

	-- Step 11: The Shady Rest Inn
	-- {zone:1413} Barrens
	["Follow the road west to the burned inn on the road toward the {zone:1413}: the black shield and Reethe's guard badge lie in the ashes and the hoofprints are in the mud beside the inn."] = "",
	-- {object:21042} Theramore Guard Badge
	["{object:21042}: for Captain Vimes, on the way back through Theramore"] = "",

	-- Step 12: Into Barrens
	-- {zone:1413} Barrens
	["Into {zone:1413}"] = "Rumo a {zone:1413}",

	-- Step 13: Takar the Seer
	-- {zone:1413} Barrens · {npc:6244} Takar the Seer · {area:378} Camp Taurajo
	["On the road south through the {zone:1413}, {npc:6244} camps east of the road, north-east of {area:378}; come in from the east and keep clear of the Horde guards."] = "Na estrada para o sul por {zone:1413}, {npc:6244} acampa a leste da estrada, a nordeste de {area:378}; chegue pelo leste e fique longe dos guardas da Horda.",
	-- {quest:1738} Heartswood · {zone:1440} Ashenvale · {zone:1443} Desolace
	["{quest:1738}: in {zone:1440}, on the way to {zone:1443}"] = "{quest:1738}: em {zone:1440}, no caminho para {zone:1443}",
	-- {quest:65602} What Is Love? · {item:190309} Wooden Figurine · {quest:1738} Heartswood
	["{quest:65602}: the incubus, beside the succubus; the {item:190309} is near the {quest:1738}"] = "{quest:65602}: o íncubo, ao lado da súcubo; {item:190309} fica perto de {quest:1738}",

	-- Step 14: Myriam Moonsinger
	-- {npc:12866} Myriam Moonsinger · {area:1316} Razorfen Downs · {area:485} Great Lift
	-- plural, as words: Razorfen Battleguards = {npc:7873} Razorfen Battleguard · Death's Head Cultists = {npc:7872} Death's Head Cultist
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:12866} stands by the entrance of {area:1316}, a few hundred yards north-east of the top of the {area:485}; the Razorfen Battleguards, Thornweavers and Death's Head Cultists (33-34, elite) hold the thorny slopes around her. Skip it if you are alone."] = "",

	-- Step 15: Henrig Lonebrow's Journal
	-- {area:485} Great Lift · {zone:1441} Thousand Needles · {item:5791} Henrig Lonebrow's Journal · {area:2097} Darkcloud Pinnacle
	["Down the {area:485} into {zone:1441}. Careful: wait on the platform until the lift is level with it before you step on, and stay on it until it stops; the drop beside it kills. {item:5791} lies a couple of hundred yards north-east of the lift's foot, in {area:2097}, where the Grimtotems (25-27) camp."] = "",
	-- {item:5791} Henrig Lonebrow's Journal · {npc:4048} Falfindel Waywarder · {area:482} Highperch
	["{item:5791}: for {npc:4048}, just past {area:482}"] = "",

	-- Step 16: Highperch
	-- {area:482} Highperch
	["West to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac."] = "",

	-- Step 17: Falfindel Waywarder
	-- {npc:4048} Falfindel Waywarder · {area:482} Highperch · {zone:1444} Feralas · {area:489} Thalanaar · {area:1717} Razorfen Kraul
	["{npc:4048} camps north of {area:482}, just over the border into {zone:1444} on the path up to {area:489}: hand him the journal. His next quest is inside {area:1717}: leave it."] = "",

	-- Step 18: Thousand Needles
	-- {area:484} Freewind Post
	["East through the canyons. {area:484}, a Horde camp with guards, sits on the mesa here: keep to the canyon floor and give the foot of its lifts a wide berth."] = "Para o leste pelos cânions. {area:484}, um acampamento da Horda com guardas, fica no planalto aqui: mantenha-se no fundo do cânion e passe bem longe da base dos elevadores.",
	-- {area:482} Highperch
	["The canyons east of {area:482}"] = "Os cânions a leste de {area:482}",

	-- Step 20: Mirage Raceway
	-- {area:2240} Mirage Raceway
	["Follow the canyons east to the salt flats. The goblins and gnomes of the {area:2240} are neutral and give quests to both factions."] = "Siga os cânions para o leste até as planícies de sal. Os goblins e gnomos de {area:2240} são neutros e dão missões às duas facções.",
	-- {quest:5762} Hemet Nesingwary
	["For {quest:5762} in Stranglethorn, later"] = "Para {quest:5762}, na Selva do Espinhaço, mais tarde",

	-- Step 21: Mirage Raceway: kill these as you meet them
	-- {area:2240} Mirage Raceway
	["{area:2240}: kill these as you meet them"] = "{area:2240}: vá matando estes pelo caminho",
	-- {object:19868} Rocket Car Rubble · {npc:5935} Ironeye the Invincible
	-- plural, as words: Scorpid Reavers = {npc:4140} Scorpid Reaver · Salt Flats Scavengers = {npc:4154} Salt Flats Scavenger · Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise · Sparkleshell Snappers = {npc:4143} Sparkleshell Snapper · Saltstone Gazers = {npc:4150} Saltstone Gazer · Scorpid Terrors = {npc:4139} Scorpid Terror
	-- was: ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half."] = "{object:19868} estão espalhados por toda a planície. Aniquiladores Escorpídeos e Catadores da Planície Salgada vagam pela metade norte, e as Tartarugas Quelobrilho (30-31) pelo meio da planície: cace-as pelos cascos. Cuidado: Tartaliscas Quelobrilho (34-35) vagam por toda a planície, e os Observadores Sal-gema (34-35) e Terrores Escorpídeos (33-34) dominam o extremo sul: deixe-os e fique na metade norte."
	["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half.\nCareful: {npc:5935} (37, rare) roams the south-east of the flats, around 83-88,71-84: leave it be."] = "",
	-- {item:5795} Hardened Tortoise Shell
	-- plural, as words: Sparkleshell Tortoises = {npc:4142} Sparkleshell Tortoise
	["{item:5795}, from the Sparkleshell Tortoises"] = "{item:5795}, das Tartarugas Quelobrilho",
	-- {npc:4078} Collin Mauren · {zone:1453} Stormwind
	-- plural, as words: Saltstone Basilisks = {npc:4147} Saltstone Basilisk
	["Crystalized Scale, from the Saltstone Basilisks: eight for {npc:4078} in {zone:1453}"] = "Escamas Cristalizadas, dos Basiliscos Sal-gema: oito para {npc:4078} em {zone:1453}",

	-- Step 22: Mirage Raceway
	-- {npc:4452} Kravel Koalbeard · {quest:1111} Wharfmaster Dizzywig · {area:392} Ratchet
	["{npc:4452}: for {quest:1111} on {area:392}'s dock, where this guide ends"] = "",
	-- {npc:4454} Fizzle Brassbolts · {zone:1418} Badlands
	["{npc:4454}: for Martek in the {zone:1418}, at the end of 30-40"] = "{npc:4454}: para Martek em {zone:1418}, no fim do 30-40",
	-- {npc:4630} Pozzik · {npc:3391} Gazlowe · {area:392} Ratchet
	["{npc:4630}: for {npc:3391} in {area:392}, on the way to the boat"] = "",

	-- Step 23: Into Tanaris
	-- {zone:1446} Tanaris
	["Into {zone:1446}"] = "Rumo a {zone:1446}",
	-- {area:439} Shimmering Flats · {zone:1446} Tanaris
	["From the raceway follow the road south out of the {area:439} into {zone:1446}."] = "Da pista de corrida, siga a estrada para o sul, saindo de {area:439}, até {zone:1446}.",

	-- Step 24: Gadgetzan
	-- {area:976} Gadgetzan · {npc:7823} Bera Stonehammer
	["{area:976} is a short walk down the road; keep to it. {npc:7823}, the Alliance flight master, stands inside the walls."] = "{area:976} fica a uma curta caminhada pela estrada; mantenha-se nela. {npc:7823}, o mestre de voo da Aliança, fica dentro das muralhas.",

	-- Step 25: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Mestre de voo de {area:976}",

	-- Step 26: Theramore
	-- {npc:4456} Fiora Longears · {npc:4948} Adjutant Tesoran · {area:514} Foothold Citadel · {npc:4941} Caz Twosprocket
	["{npc:4456} is in the north of town, Captain Vimes and {npc:4948} on the top floor of {area:514}; {npc:4941} stands in the town."] = "",
	-- {zone:1445} Dustwallow Marsh
	["Vimes's next errand, The Deserters, is for the {zone:1445} visit at 39: leave it."] = "",

	-- Step 27: Ratchet
	-- {zone:1413} Barrens · {area:392} Ratchet · {area:35} Booty Bay · {npc:3391} Gazlowe · {quest:1111} Wharfmaster Dizzywig
	["From Theramore follow the road north-west through the marsh into the {zone:1413} and up the coast to {area:392}: Stranglethorn starts at {area:35}, across the sea. {area:392}'s gryphon master stands above the dock; {npc:3391} is upstairs in the house above it; {quest:1111} waits on the dock by the boat."] = "",
	-- {npc:3391} Gazlowe · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["{npc:3391}: for {npc:4631}, on {area:35}'s dock where the boat lands"] = "",
	-- {quest:1111} Wharfmaster Dizzywig · {quest:1039} The Barrens Port · {npc:8026} Thyn'tel Bladeweaver · {zone:1457} Darnassus
	["{quest:1111}: {quest:1039}, from {npc:8026} in {zone:1457}"] = "",
	-- {quest:1111} Wharfmaster Dizzywig · {npc:3945} Caravaneer Ruzzgot · {area:35} Booty Bay
	["{quest:1111}: for {npc:3945} in {area:35}, where the boat lands"] = "",
	-- {area:2240} Mirage Raceway
	["Dizzywig's next errand goes back to the {area:2240}, which the route next visits at 45: leave it."] = "",

	-- Step 28: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco para {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back west along the road to the satyr camps of {area:429}."] = "Volte para oeste pela estrada até os acampamentos de sátiros de {area:429}.",
	-- ["Boat to {area:150}"] = "Navio para {area:150}",
	-- ["Dartol's Rod"] = "Bastão de Transformação de Dartol",
	-- ["Down the {area:485} into {zone:1441}, then west to the wyverns' cliffs at {area:482}. Every wyvern there can drop a venom sac. Careful: wait on the platform until the lift is level with it before you step on, and stay on it until it stops; the drop beside it kills."] = "Desça por {area:485} até {zone:1441}, depois a oeste até os penhascos das serpes em {area:482}. Toda serpe de lá pode soltar uma glândula de veneno. Cuidado: espere na plataforma até o elevador ficar nivelado com ela antes de subir, e fique nele até ele parar; a queda ao lado mata.",
	-- ["Follow the road east to the satyr camps of {area:429}; {npc:3920} hides at their edge."] = "Siga a estrada para leste até os acampamentos de sátiros de {area:429}; {npc:3920} se esconde na borda deles.",
	-- ["Follow the road west out of Theramore to the burned inn on the road toward the {zone:1413}: the black shield lies in the ashes and the hoofprints are in the mud beside the inn."] = "Siga a estrada para oeste, saindo de Theramore, até a estalagem queimada na estrada rumo a {zone:1413}: o escudo negro está nas cinzas e as pegadas de casco estão na lama ao lado da estalagem.",
	-- ["Follow the road west out of {area:415}; {area:413} lies north of it."] = "Siga a estrada para oeste saindo de {area:415}; {area:413} fica ao norte dela.",
	-- ["For {quest:1132} on Theramore's docks, where this guide's boat lands"] = "Para {quest:1132} nas docas de Theramore, onde o barco deste guia atraca",
	-- ["From the raceway follow the road south out of the {area:439} into {zone:1446}; {area:976} is a short walk down it. Keep to the road. {npc:7823}, the Alliance flight master, stands inside the walls."] = "Da pista de corrida, siga a estrada para o sul, saindo de {area:439}, até {zone:1446}; {area:976} fica a uma curta caminhada por ela. Fique na estrada. {npc:7823}, o mestre de voo da Aliança, fica dentro das muralhas.",
	-- ["From {area:608}"] = "De {area:608}",
	-- ["Geltharis"] = "Geltharis",
	-- ["Insane druids"] = "Druidas insanos",
	-- ["Melyria and {npc:3901}"] = "Melyria e {npc:3901}",
	-- ["Rusty chests lie around the Shadethicket furbolg camps west of the Forsaken; open them until one holds the pommel."] = "Baús Enferrujados ficam em volta dos acampamentos furbolgs Umbrárvore a oeste dos Renegados; abra-os até um conter o Castão de Ferro.",
	-- ["Take the boat to {area:150} from {area:442}'s docks."] = "Pegue o barco para {area:150} nas docas de {area:442}.",
	-- ["Take the tunnel into the {area:419}; the tome lies in the ruins at its west end."] = "Pegue o túnel para {area:419}; o tomo está nas ruínas no extremo oeste.",
	-- ["The Crazed and Withered Ancients north of the moonwell carry the {item:5475}; the worn chest it opens stands among them."] = "Os Ancientes Enlouquecidos e Ancientes Fenescidos ao norte do poço lunar carregam a {item:5475}; o baú gasto que ela abre fica entre eles.",
	-- ["The Forsaken's camp lies in the woods south of {area:2358}."] = "O acampamento dos Renegados fica na mata ao sul de {area:2358}.",
	-- ["The moonwell lies in the hills north-east of {area:415}."] = "O poço lunar fica nas colinas a nordeste de {area:415}.",
	-- ["The second {object:19901} lies in the valley of {area:428}, on the way west."] = "O segundo {object:19901} fica no vale de {area:428}, no caminho para oeste.",
	-- ["The shrine sits on the hill just south-east of the moonwell; follow the winding path up."] = "O santuário fica na colina logo a sudeste do poço lunar; suba pela trilha sinuosa.",
	-- ["The three druids stand together at the Forsaken camp south of {area:2358}."] = "Os três druidas ficam juntos no acampamento dos Renegados ao sul de {area:2358}.",
	-- ["The two stand together at the western end of the road."] = "As duas ficam juntas no extremo oeste da estrada.",
	-- ["The wreck of the Flying Osprey lies in the shallows south of the keep."] = "O navio naufragado está nas águas rasas ao sul da fortaleza.",
	-- ["The {npc:3931} walks the shore of {quest:1035}, south-west of the chests; the {object:669176} lies north of the lake, on the way."] = "O {npc:3931} anda pela margem de {quest:1035}, a sudoeste dos baús; o {object:669176} está ao norte do lago, no caminho.",
	-- ["The {object:19901} stands in the satyr camp of {area:430}, further east along the road."] = "{object:19901} fica no acampamento de sátiros de {area:430}, mais a leste pela estrada.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} and {npc:221269} stand there."] = "{area:2358}, o posto avançado dos elfos noturnos no extremo leste da estrada: {npc:3848} e {npc:221269} ficam lá.",
	-- ["{area:2358}, the Night Elf outpost at the eastern end of the road: {npc:3848} stands there."] = "{area:2358}, o posto avançado dos elfos noturnos no extremo leste da estrada: {npc:3848} fica lá.",
	-- ["{area:429} satyrs"] = "Sátiros de {area:429}",
	-- ["{npc:1217} stands on the upper floor of Menethil's keep."] = "{npc:1217} fica no andar de cima da fortaleza de Menethil.",
	-- ["{npc:3696} and his guards camp just east of {npc:3897}."] = "{npc:3696} e seus guardas acampam logo a leste de {npc:3897}.",
	-- ["{npc:3897}, a furbolg untouched by the corruption, sits south of the road below {area:421}."] = "{npc:3897}, um furbolg intocado pela corrupção, fica ao sul da estrada abaixo de {area:421}.",
	-- ["{npc:3970}: for {npc:1480} in Menethil, at the end of this guide"] = "{npc:3970}: para {npc:1480} em Menethil, no fim deste guia",
	-- ["{npc:4455} stands on the dock just north of the flight master."] = "{npc:4455} fica no cais, logo ao norte do mestre de voo.",
	-- ["{npc:4456} is in the north of town, Captain Vimes in {area:514}; {npc:4941} stands in the town."] = "{npc:4456} fica no norte da cidade, o Capitão Vimes em {area:514}; {npc:4941} fica na cidade.",
	-- ["{npc:4619} leads the {area:429} satyrs; he carries the branch."] = "{npc:4619} lidera os sátiros de {area:429}; ele carrega o galho.",
	-- ["{npc:5082}, {npc:4963} and Tapoke Jahn are all at Menethil's inn; {npc:4962} fights you when you talk to {npc:4963}, but gives up once beaten. {npc:1480} stands a short walk north-east of the inn."] = "{npc:5082}, {npc:4963} e {npc:4962} estão todos na estalagem de Menethil; Tapoke luta com você quando você fala com {npc:4963}, mas desiste quando derrotado. {npc:1480} fica a uma curta caminhada a nordeste da estalagem.",
	-- ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Snappers (tortoises) the whole flats. Saltstone Basilisks and Crystalhides hold the middle; the Gazers (34-35) only the far south."] = "Os {object:19868} estão espalhados pela planície. Aniquiladores Escorpídeos e Catadores da Planície Salgada andam pela metade norte; Tartaliscas Quelobrilho (tartarugas), pela planície toda. Basiliscos Sal-gema e Cristaldermes Sal-gema dominam o meio; os Observadores (34-35) ficam só no extremo sul.",
	-- ["{object:19868} lies all over the flats. Scorpid Reavers and Salt Flats Scavengers roam the north half, Sparkleshell Tortoises (30-31) the middle of the flats: hunt them for the shells. Careful: Sparkleshell Snappers (34-35) wander the whole flats, and the Saltstone Gazers (34-35) and Scorpid Terrors (33-34) hold the far south: leave them and keep to the north half."] = "{object:19868} estão espalhados por toda a planície. Aniquiladores Escorpídeos e Catadores da Planície Salgada vagam pela metade norte, e as Tartarugas Quelobrilho (30-31) pelo meio da planície: cace-as pelos cascos. Cuidado: Tartaliscas Quelobrilho (34-35) vagam por toda a planície, e os Observadores Sal-gema (34-35) e Terrores Escorpídeos (33-34) dominam o extremo sul: deixe-os e fique na metade norte.",
	-- ["{object:669176}: for {npc:3961} in {area:415}"] = "{object:669176}: para {npc:3961} em {area:415}",
	-- ["{quest:1132}, on the docks"] = "{quest:1132}, nas docas",
	-- ["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",
}
