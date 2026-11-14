-- Portuguese (Brazil) (ptBR): the guide forever/horde/02-the-barrens (forever/horde/02-the-barrens.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {area:379} Far Watch Post · {zone:1413} The Barrens · {npc:3337} Kargal Battlescar · {quest:809} Ak'Zeloth · {npc:5810} Uzzek
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {area:379} sits just above it on the {zone:1413} side. {npc:3337}, {quest:809} and {npc:5810} stand together."] = "Saia de {zone:1454} pelo portão principal e siga a estrada para o sul por {zone:1411}, depois para oeste pela ponte de {area:814}: {area:379} fica logo acima dela, do lado de {zone:1413}. {npc:3337}, {quest:809} e {npc:5810} ficam juntos.",
	-- {npc:3337} Kargal Battlescar · {quest:840} Conscript of the Horde · {zone:1411} Durotar
	["{npc:3337}: {quest:840}, from {zone:1411}"] = "{npc:3337}: {quest:840}, de {zone:1411}",
	-- {quest:809} Ak'Zeloth · {npc:3337} Kargal Battlescar · {npc:3216} Neeru Fireblade · {zone:1454} Orgrimmar
	["{quest:809}, beside {npc:3337}: from {npc:3216} in {zone:1454}"] = "{quest:809}, ao lado de {npc:3337}: de {npc:3216} em {zone:1454}",

	-- Step 3: Far Watch Post
	-- {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:814} Southfury River · {npc:5810} Uzzek · {area:379} Far Watch Post
	["Leave {zone:1454} by the main gate and follow the road south through {zone:1411}, then west over the {area:814} bridge: {npc:5810} stands at {area:379} just above it, on the road to the Crossroads."] = "Saia de {zone:1454} pelo portão principal e siga a estrada para o sul por {zone:1411}, depois para oeste pela ponte de {area:814}: {npc:5810} fica em {area:379}, logo acima dela, na estrada para a Encruzilhada.",

	-- Step 4: The Crossroads
	-- {area:379} Far Watch Post · {npc:3489} Zargh · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger
	["You arrive from {area:379}. {npc:3489} and {npc:3338} stand by the inn, Helbrim and {npc:3464} by the north gate; {npc:3615}, {npc:3429} and {npc:3449} on the tower platform."] = "Você chega vindo de {area:379}. {npc:3489} e {npc:3338} ficam perto da estalagem, Helbrim e {npc:3464} no portão norte; {npc:3615}, {npc:3429} e {npc:3449} na plataforma da torre.",
	-- {npc:3390} Apothecary Helbrim · {quest:1358} Sample for Helbrim
	["{npc:3390}: {quest:1358}, from Zinge"] = "{npc:3390}: {quest:1358}, com Zilda",
	-- {npc:3615} Devrak
	["{npc:3615}, on the tower"] = "{npc:3615}, na torre",
	-- {npc:3449} Darsok Swiftdagger · {area:383} Dry Hills
	["{npc:3449}: the harpies come later, in the {area:383}"] = "{npc:3449}: as harpias vêm depois, em {area:383}",

	-- Step 5: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze · {area:392} Ratchet
	["{npc:5878} camps beside the road east toward {area:392}."] = "{npc:5878} acampa ao lado da estrada para o leste, rumo a {area:392}.",

	-- Step 6: Razormane camp
	["Razormane camp"] = "Acampamento Crinavalha",
	-- {object:58369} Stolen Iron Chest · {item:5026} Fire Tar
	["The Razormane camp lies east of the Crossroads. Warriors: the {object:58369} stands in the camp. Shamans: the quilboar drop the {item:5026}.\nCareful: The chest stands next to a broken wagon, guarded by a pair of Razormanes, including hunters that can pull more quilboar into the fight."] = "O acampamento Crinavalha fica a leste da Encruzilhada. Guerreiros: o {object:58369} fica no acampamento. Xamãs: os javatuscos soltam o {item:5026}.\nCuidado: o baú fica ao lado de uma carroça quebrada, guardado por dois Crinavalhas, incluindo caçadores que podem puxar mais javatuscos para a luta.",

	-- Step 7: Razormane camp: Thork's quilboar
	-- {npc:3429} Thork
	["Razormane camp: {npc:3429}'s quilboar"] = "Acampamento Crinavalha: os javatuscos de {npc:3429}",
	-- {npc:3429} Thork
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "Já que está no acampamento: os Rabdomantes e os Tecespinhos de {npc:3429} ficam na metade oeste, os Caçadores Crinavalha no meio e as caixas de suprimentos na ponta leste.\nCuidado: os Come-carnes e os Berserkers Crinavalha (18-19) são elites; eles ficam no nordeste do acampamento, ao lado das caixas de suprimentos: puxe os javatuscos para longe deles, um de cada vez.",

	-- Step 9: Telf Joolam
	-- {npc:5900} Telf Joolam · {item:6636} Fire Sapta · {npc:5893} Minor Manifestation of Fire · {item:6655} Glowing Ember
	["Back east over the bridge and up the trail to {npc:5900}'s shrine again. {npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "Volte para leste pela ponte e suba a trilha até o santuário de {npc:5900} de novo. {npc:5900} faz {item:6636} com o piche e o bornal. Use junto ao braseiro ao lado dele para revelar {npc:5893}, mate-a para pegar {item:6655} e depois ponha a brasa no braseiro.",

	-- Step 11: Kranal Fiss
	-- {npc:5907} Kranal Fiss · {npc:2523} Searing Totem · {item:5176} Fire Totem · {item:263412} Totem of Charged Flames
	["{npc:5907}: {npc:2523}, your {item:5176} and the {item:263412}"] = "{npc:5907}: {npc:2523}, seu {item:5176} e o {item:263412}",

	-- Step 13: The Crossroads
	-- {area:380} The Crossroads · {npc:3338} Sergra Darkthorn · {npc:3464} Gazrog · {npc:3615} Devrak · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn: {npc:3338} by the inn, Helbrim and {npc:3464} by the north gate, then up the tower to {npc:3615}, the wind rider master, {npc:3429} and {npc:3449}, and {npc:3448} at the south gate on the way out."] = "{area:380} é a sua base neste guia. Todo mundo de que você precisa fica a poucos passos da estalagem: {npc:3338} junto à estalagem, Helbrim e {npc:3464} no portão norte, depois a torre, para {npc:3615}, o mestre de mantícoras, {npc:3429} e {npc:3449}, e {npc:3448} no portão sul, na saída.",
	-- {npc:3429} Thork
	["{npc:3429}, at the top of the tower"] = "{npc:3429}, no alto da torre",

	-- Step 14: Raptor Heads as you go
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Raptor Heads as you go"] = "Cabeças de Raptor pelo caminho",
	-- plural, as words: Sunscale Screechers = {npc:3255} Sunscale Screecher
	["Sunscale raptors roam the plains north and east of the Crossroads, and about three in four drop a head: kill the ones you pass on the way. Careful: Sunscale Screechers call nearby allies within 30 yd once below 30% health."] = "Os raptores Helióscamo andam pelas planícies ao norte e a leste da Encruzilhada, e uns três em cada quatro soltam uma cabeça: vá matando os que encontrar pelo caminho. Cuidado: os Uivadores Helióscamo chamam aliados num raio de 30 metros quando caem abaixo de 30% de vida.",

	-- Step 15: Plainstrider Beaks as you go
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Plainstrider Beaks as you go"] = "Bicos de Pinote pelo caminho",
	-- {zone:1413} The Barrens
	["Plainstriders roam the plains all over the {zone:1413}, and about one in four drops a beak: kill the ones you pass on the way."] = "Pinotes vagam por todas as planícies de {zone:1413}, e cerca de um em cada quatro solta um bico: vá matando os que encontrar pelo caminho.",

	-- Step 16: Razormane camp
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks.\nCareful: Razormane Flesheaters and Berserkers (18-19) are elites; they stand in the camp's north-east, beside the supply crates: pull the quilboar away from them one at a time."] = "No acampamento, os Rabdomantes e os Tecespinhos ficam na metade oeste e os Caçadores Crinavalha no meio; as caixas de suprimentos ficam na ponta leste.\nOs Pinotes daqui também contam para os bicos.\nCuidado: os Come-carnes e os Berserkers Crinavalha (18-19) são elites; eles ficam no nordeste do acampamento, ao lado das caixas de suprimentos: puxe os javatuscos para longe deles, um de cada vez.",

	-- Step 17: Finish the Plainstrider Beaks
	-- plural, as words: Plainstrider Beaks = {item:5087} Plainstrider Beak
	["Finish the Plainstrider Beaks"] = "Complete os Bicos de Pinote",
	["Still short of seven? Plainstriders are thickest on the plains north of the Crossroads, along the road north."] = "Ainda não chegou a sete? Os Pinotes são mais numerosos nas planícies ao norte da Encruzilhada, ao longo da estrada para o norte.",

	-- Step 19: The Zhevra
	-- {area:392} Ratchet
	-- plural, as words: Zhevra Runners = {npc:3242} Zhevra Runner
	["Zhevra Runners graze along the road east toward {area:392}: take their hooves on the way out."] = "Zevras Corredoras pastam ao longo da estrada a leste, rumo a {area:392}: pegue os cascos delas na saída.",

	-- Step 20: Ratchet
	-- {area:392} Ratchet
	["Follow the road south-east to {area:392} on the coast."] = "Siga a estrada para sudeste até {area:392}, no litoral.",
	-- {npc:3391} Gazlowe
	["{npc:3391}, upstairs"] = "{npc:3391}, no andar de cima",
	-- {npc:3442} Sputtervalve · {area:382} Sludge Fen
	["{npc:3442}: the console is in the {area:382}, later"] = "{npc:3442}: o console fica em {area:382}, depois",
	-- {npc:16227} Bragok · {npc:3442} Sputtervalve
	["{npc:16227}, beside {npc:3442}"] = "{npc:16227}, ao lado de {npc:3442}",
	-- {object:3972} WANTED
	["{object:3972} poster"] = "cartaz {object:3972}",
	-- {quest:1492} Wharfmaster Dizzywig
	["{quest:1492}, on the dock"] = "{quest:1492}, no cais",
	-- {quest:1492} Wharfmaster Dizzywig · {area:381} Boulder Lode Mine
	["{quest:1492}: the emerald comes from the {area:381}, later"] = "{quest:1492}: a esmeralda vem de {area:381}, mais tarde",

	-- Step 21: The Barrens: kill these as you meet them
	-- {zone:1413} The Barrens
	["{zone:1413}: kill these as you meet them"] = "{zone:1413}: vá matando estes pelo caminho",
	-- {area:392} Ratchet · {npc:3467} Baron Longshore
	["The pirates camp on the beach south of {area:392}: the piles of complicated parts lie in the sand among them, and {npc:3467} stands at the camp's southern end."] = "Os piratas acampam na praia ao sul de {area:392}: as pilhas de peças complicadas ficam na areia entre eles, e {npc:3467} fica na ponta sul do acampamento.",

	-- Step 22: Ratchet
	-- {npc:3391} Gazlowe · {area:385} Northwatch Hold
	["{npc:3391}: the crates lie at the south end of the beach camp, on the walk to {area:385} at 18"] = "{npc:3391}: as caixas ficam na ponta sul do acampamento da praia, no caminho para {area:385}, no nível 18",

	-- Step 23: Fly to Crossroads
	["Fly to Crossroads"] = "Voe para a Encruzilhada",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 25: Gur'ak
	-- {npc:267310} Gur'ak · {quest:97003} Chol'aruk the Ravener · {npc:267307} Chol'aruk · {area:1699} Thorn Hill · {npc:3438} Kreenig Snarlsnout
	["{npc:267310} stands on the north-east side of the Crossroads. {quest:97003} is a group quest: {npc:267307} is a level 20 elite boar in the Razormane's {area:1699} cave, east of the town, where the route goes back for {npc:3438} later."] = "{npc:267310} fica no lado nordeste da Encruzilhada. {quest:97003} é uma missão de grupo: {npc:267307} é um javali elite de nível 20 na caverna Crinavalha de {area:1699}, a leste da cidade, aonde a rota volta mais tarde por causa de {npc:3438}.",

	-- Step 26: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["West to {npc:3389}'s watch post on the Kolkar border."] = "A oeste, até o posto de vigia de {npc:3389}, na fronteira com os Kolkar.",

	-- Step 27: The Barrens: kill these as you meet them
	-- {npc:3389} Regthar Deathgate · {npc:3394} Barak Kodobane
	-- plural, as words: Laden Mushrooms = {object:3640} Laden Mushroom
	["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers. {npc:3394} stands in the Kolkar camp west of the pools."] = "As poças ficam logo ao norte de {npc:3389}. Entre na água para explorá-las; os Cogumelos Carregados para Hermógenes crescem em volta delas. Mate todo Kolkar que encontrar, por causa das braçadeiras. {npc:3394} fica no acampamento Kolkar a oeste das poças.",

	-- Step 28: Regthar Deathgate
	-- {npc:3389} Regthar Deathgate · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis
	["{npc:3389}: {npc:3395} walks with the Kolkar at the {area:388}, later"] = "{npc:3389}: {npc:3395} anda com os Kolkar em {area:388}, mais tarde",

	-- Step 29: Dry Hills
	-- {area:383} Dry Hills · {quest:819} Chen's Empty Keg · {npc:3389} Regthar Deathgate
	-- plural, as words: Savannah Prowlers = {npc:3425} Savannah Prowler · Witchwing Ambushers = {npc:3279} Witchwing Ambusher
	["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills. Savannah Prowlers hunt the plains between {npc:3389} and the hills: take their claws on the way.\nCareful: There are 2 Witchwing Ambushers (level 17-18). They stay stealthed with Sneak while out of combat."] = "Para o oeste, até {area:383}. As harpias Asabruxa fazem ninho por toda parte; qualquer uma pode deixar cair uma garra. {quest:819} fica nas colinas delas. Predadores da Savana caçam nas planícies entre {npc:3389} e as colinas: pegue as garras deles pelo caminho.\nCuidado: há 2 Asabruxas Emboscadoras (nível 17-18). Elas ficam em Furtividade enquanto estão fora de combate.",

	-- Step 30: Samophlange
	-- {object:4141} Control Console · {area:382} Sludge Fen · {item:5089} Console Key · {npc:3471} Tinkerer Sniggles
	["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it.\nCareful: Several guards stand within aggro range of the valves, respawn in under about 3 minutes, and run at low health to bring back help; nearby mobs also join if you use a valve while they are close."] = "{object:4141} fica no posto de pesquisa da Empreendimentos S.A. a oeste de {area:382}. Feche as três válvulas em volta da perfuratriz, use o painel de novo e pegue {item:5089} com {npc:3471}, ali do lado.\nCuidado: vários guardas ficam ao alcance das válvulas, renascem em menos de uns 3 minutos e fogem com pouca vida para chamar reforço; monstros por perto também entram na briga se você mexer numa válvula com eles ali.",
	["Inside"] = "Lá dentro",
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["{npc:3442} in {area:392}: on the next {area:392} stop"] = "{npc:3442} em {area:392}: na próxima parada em {area:392}",

	-- Step 31: The Disruption Ends
	-- {npc:3438} Kreenig Snarlsnout · {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them. Careful: Razormane Flesheaters and Berserkers (18-19) are elites in the camp's north-east, near {npc:3438} and the supply crates, and {npc:267307} (20, elite) lies in the cave under {area:1699} beside them: pull {npc:3438} and the quilboar away from them one at a time, and leave the cave alone unless you are in a group."] = "De volta ao acampamento Crinavalha. Geomantes e Defensores ocupam a metade leste; {npc:3438} anda entre eles. Cuidado: os Come-carnes e os Berserkers Crinavalha (18-19) são elites no nordeste do acampamento, perto de {npc:3438} e dos caixotes de suprimentos, e {npc:267307} (20, elite) fica na caverna sob {area:1699}, ao lado deles: puxe {npc:3438} e os javatuscos para longe deles, um de cada vez, e deixe a caverna em paz, a menos que esteja em grupo.",

	-- Step 32: Chol'aruk
	-- {npc:267307} Chol'aruk · {area:1699} Thorn Hill
	-- plural, as words: Razormane Flesheaters = {npc:267308} Razormane Flesheater
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:267307} (level 20 elite) needs a group of 3 and sits deep in the cave under {area:1699}, past the Razormane Flesheaters and Berserkers (18-19, elite). Skip it if you are alone."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:267307} (elite de nível 20) precisa de um grupo de 3 e fica no fundo da caverna sob {area:1699}, depois dos Come-carnes e Berserkers Crinavalha (18-19, elite). Se estiver sozinho, pule.",

	-- Step 33: The Crossroads
	-- {npc:3338} Sergra Darkthorn · {npc:3429} Thork · {npc:3449} Darsok Swiftdagger · {npc:3432} Mankrik · {npc:3448} Tonga Runetotem · {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {area:383} Dry Hills · {quest:853} Apothecary Zamah · {zone:1456} Thunder Bluff
	["{npc:3338} by the inn first, then Helbrim by the north gate, {npc:3429} and {npc:3449} on the tower platform, {npc:3432} by the inn, and {npc:3448} at the south gate last. His seed test waits for the {npc:3395} pass at the {area:388}: go straight on north-west to the {area:383}. After the spores Helbrim offers {quest:853}, a delivery to {zone:1456} within 45 minutes: this route doesn't go there, so leave it (Druids take it on the next Crossroads stop, right before their flight to {zone:1456})."] = "{npc:3338} junto à estalagem primeiro, depois Hermógenes junto ao portão norte, {npc:3429} e {npc:3449} na plataforma da torre, {npc:3432} junto à estalagem e {npc:3448} no portão sul por último. O teste das sementes dele espera a passagem por {npc:3395}, em {area:388}: siga direto para noroeste até {area:383}. Depois dos esporos, Hermógenes oferece {quest:853}, uma entrega em {zone:1456} em até 45 minutos: esta rota não vai lá, então deixe-a (os Druidas a pegam na próxima parada na Encruzilhada, logo antes do voo para {zone:1456}).",
	-- {npc:3432} Mankrik
	["{npc:3432}: his wife lies at the north edge of the Bristleback camps, later"] = "{npc:3432}: a esposa dele fica na borda norte dos acampamentos Costagulha, mais adiante",
	-- {npc:3448} Tonga Runetotem · {area:388} Stagnant Oasis · {npc:3395} Verog the Dervish
	["{npc:3448}: the bubbling fissure at the {area:388}, on the {npc:3395} pass"] = "{npc:3448}: a fenda borbulhante em {area:388}, na passagem por {npc:3395}",

	-- Step 35: Harpy Lieutenants
	-- {area:383} Dry Hills
	-- plural, as words: Witchwing Slayers = {npc:3278} Witchwing Slayer
	["North-west to the {area:383}: the Witchwing Slayers hold their western end; they wear the rings.\nCareful: Some stealthed harpy ambushers wait in the area and stay hidden until you get close. A level 19 elite harpy also patrols there."] = "Para o noroeste, até {area:383}: as Asabruxas Matadoras ocupam a ponta oeste; elas carregam os anéis.\nCuidado: algumas harpias emboscadoras furtivas esperam na área e ficam escondidas até você chegar perto. Uma harpia elite de nível 19 também patrulha por lá.",

	-- Step 37: Raptor Horns
	-- {quest:881} Echeyakee · {area:383} Dry Hills · {item:5055} Intact Raptor Horn · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["On the way east to {quest:881}: Sunscale Scytheclaws prowl the plains east of the {area:383}; any of them can drop an {item:5055} for {npc:3446} in {area:392}."] = "No caminho para o leste, rumo a {quest:881}: Garrafoices Helióscamo rondam as planícies a leste de {area:383}; qualquer um pode deixar cair um {item:5055} para {npc:3446} em {area:392}.",

	-- Step 38: Echeyakee
	-- {quest:881} Echeyakee
	["South-east on the way back to the Crossroads: {quest:881}, a white lion, prowls the plains north of the Razormane camp.\nCareful: Savannah Huntresses roam around the lair. They respawn quickly and often join the fight alongside {quest:881}, so clear them out before you blow the horn.\nSunscale raptors here count toward the heads."] = "Ao sudeste, na volta para a Encruzilhada: {quest:881}, um leão branco, ronda as planícies ao norte do acampamento Crinavalha.\nCuidado: as Caçadoras da Savana andam em volta do covil. Elas reaparecem rápido e muitas vezes entram na luta junto com {quest:881}, então limpe a área antes de soprar a trombeta.\nOs raptores Helióscamo daqui também contam para as cabeças.",

	-- Step 39: Finish the Raptor Heads
	-- plural, as words: Raptor Heads = {item:5062} Raptor Head
	["Finish the Raptor Heads"] = "Complete as Cabeças de Raptor",
	-- {quest:881} Echeyakee
	-- plural, as words: Sunscale Lashtails = {npc:3254} Sunscale Lashtail
	["Still short of twelve? Sunscale Lashtails and Screechers roam the plains north-east of the Crossroads, on the way back south from {quest:881}'s lair."] = "Ainda não chegou a doze? Batecaudas e Uivadores Helióscamo andam pelas planícies a nordeste da Encruzilhada, na volta para o sul, vindo da toca de {quest:881}.",

	-- Step 40: The Crossroads
	-- {npc:3464} Gazrog · {npc:3338} Sergra Darkthorn · {npc:3449} Darsok Swiftdagger · {npc:3429} Thork
	["In from the north gate: {npc:3464} first, {npc:3338} by the inn, then up to {npc:3449} and {npc:3429} on the tower platform, where the flight master stands."] = "Entrando pelo portão norte: {npc:3464} primeiro, {npc:3338} junto à estalagem; depois suba até {npc:3449} e {npc:3429}, na plataforma da torre, onde fica o mestre de voo.",
	-- {npc:3464} Gazrog · {quest:3281} Stolen Silver · {area:385} Northwatch Hold
	["{npc:3464}: the {quest:3281}, in a raptor nest north-west of {area:385}"] = "{npc:3464}: {quest:3281}, num ninho de raptores a noroeste de {area:385}",
	-- {npc:3390} Apothecary Helbrim · {zone:1456} Thunder Bluff
	["{npc:3390}: 45 minutes, for Zamah on the {zone:1456} step next"] = "{npc:3390}: 45 minutos, para Zaqueu na próxima etapa, em {zone:1456}",
	-- {npc:3338} Sergra Darkthorn
	["{npc:3338}: the raptor nests south of the Crossroads"] = "{npc:3338}: os ninhos de raptores ao sul da Encruzilhada",
	-- {npc:3449} Darsok Swiftdagger · {quest:876} Serena Bloodfeather · {area:383} Dry Hills
	["{npc:3449}, on the tower: {quest:876} leads the harpies in the {area:383}"] = "{npc:3449}, na torre: {quest:876} lidera as harpias em {area:383}",
	-- {npc:3429} Thork · {area:1703} Mor'shan Rampart
	["{npc:3429}, on the tower, from level 17. Keep it: Kadrak at the {area:1703}, next guide"] = "{npc:3429}, na torre, a partir do nível 17. Guarde: Kadrak em {area:1703}, no próximo guia",

	-- Step 41: Thunder Bluff
	-- {area:1638} Thunder Bluff · {quest:853} Apothecary Zamah · {area:2197} Pools of Vision · {area:1640} Spirit Rise · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from the Crossroads to {area:1638}. {quest:853} waits in the {area:2197}, the cave under {area:1640}: hand in the spores there first, while their time runs. Then {npc:3033} trains you on {area:1639}."] = "Voe da Encruzilhada para {area:1638}. {quest:853} espera em {area:2197}, a caverna embaixo de {area:1640}: entregue os esporos lá primeiro, enquanto o tempo deles corre. Depois {npc:3033} treina você em {area:1639}.",
	-- {quest:853} Apothecary Zamah · {area:2197} Pools of Vision
	["{quest:853}, in the {area:2197}"] = "{quest:853}, em {area:2197}",

	-- Step 42: Moonglade
	-- {spell:18960} Teleport: Moonglade
	["Cast {spell:18960}"] = "Use {spell:18960}",

	-- Step 43: Trial of the Lake
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven · {area:656} Lake Elune'ara · {area:2362} Shrine of Remulos · {npc:11799} Tajarri · {quest:28} Trial of the Lake
	-- plural, as words: Shrine Baubles = {item:15877} Shrine Bauble
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart. The Shrine Baubles lie on the bed of {area:656} and fade within minutes: swim one straight to the {area:2362} on the north-west shore, use it there and speak to {npc:11799}. {quest:28} runs on a timer: no teleport or Hearthstone until {npc:11799} has it."] = "{npc:11802} fica no andar de cima do prédio dele em {area:2361}: suba por dentro, a seta não distingue os andares. Os Adornos de Altar ficam no fundo de {area:656} e somem em poucos minutos: nade com um direto até {area:2362}, na margem noroeste, use-o lá e fale com {npc:11799}. {quest:28} tem cronômetro: nada de teleporte nem de Pedra de Regresso até {npc:11799} ficar com ele.",
	-- {quest:6127} The Principal Source · {area:384} Dreadmist Peak
	["{quest:6127}: {area:384}, next guide"] = "{quest:6127}: {area:384}, próximo guia",
	-- {item:15877} Shrine Bauble · {object:177785} Bauble Container
	["{item:15877}, from a {object:177785} in the lake"] = "{item:15877}, de um {object:177785} no lago",
	-- {area:2362} Shrine of Remulos
	["At the {area:2362}"] = "Em {area:2362}",
	-- {npc:11799} Tajarri · {area:2362} Shrine of Remulos
	["{npc:11799}, at the {area:2362}"] = "{npc:11799}, no {area:2362}",
	-- {quest:30} Trial of the Sea Lion · {area:382} Sludge Fen · {area:287} Hillsbrad
	["{quest:30}, carried: one half pendant in the {area:382} in this guide, the other underwater off Silverpine on the way to {area:287} at 21; the pendant is handed in after {area:287}"] = "{quest:30}, com você: uma metade do pingente no {area:382} deste guia, a outra debaixo d'água, na costa de Pinhaprata, a caminho de {area:287} no nível 21; o pingente é entregue depois de {area:287}",
	-- {npc:11798} Bunthen Plainswind · {area:2361} Nighthaven
	["{npc:11798} in {area:2361} flies druids there"] = "{npc:11798}, em {area:2361}, leva druidas voando até lá",

	-- Step 44: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "Voe para {area:392}",
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} straight on to {area:392}."] = "Voe de {zone:1456} direto para {area:392}.",

	-- Step 45: Fly to Ratchet
	["Crossroads flight master"] = "Mestre de voo da Encruzilhada",

	-- Step 47: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {area:392} Ratchet
	["{npc:3446}, beside the {object:3972} poster: take it now if he did not offer it on the first {area:392} stop"] = "{npc:3446}, junto ao cartaz {object:3972}: pegue agora, se ele não a ofereceu na primeira parada em {area:392}",

	-- Step 48: Ratchet
	-- {npc:3446} Mebok Mizzyrix · {object:3972} WANTED
	["{npc:3446}, beside the {object:3972} poster"] = "{npc:3446}, ao lado do cartaz {object:3972}",

	-- Step 49: Mebok Mizzyrix
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {quest:1491} Smart Drinks
	["For your {area:718} run: {npc:3446}'s next errand, {quest:1491}."] = "Para a masmorra {area:718}: a próxima tarefa de {npc:3446}, {quest:1491}.",

	-- Step 51: Ratchet
	-- {npc:3442} Sputtervalve · {quest:1483} Ziz Fizziks · {area:1076} Webwinder Path
	["{npc:3442}: keep it, {quest:1483} is on the {area:1076} in Stonetalon, at the end of this guide"] = "{npc:3442}: guarde, {quest:1483} fica em {area:1076}, em Torres de Pedra, no fim deste guia",
	-- {npc:3442} Sputtervalve · {npc:9316} Wenikee Boltbucket · {area:382} Sludge Fen
	["{npc:3442}: {npc:9316} stands on the road north of the Crossroads, on the way to the {area:382}"] = "{npc:3442}: {npc:9316} fica na estrada ao norte da Encruzilhada, a caminho de {area:382}",

	-- Step 52: Bruuz
	-- {npc:209797} Bruuz
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:209797} (level 20 elite) needs a group of 2. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:209797} (elite nível 20) pede um grupo de 2. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 53: Ratchet
	-- {npc:3391} Gazlowe
	["{npc:3391} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:3391} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",

	-- Step 54: Raptor nests
	["Raptor nests"] = "Ninhos de raptor",
	-- {area:392} Ratchet · {area:1697} Raptor Grounds · {item:5165} Sunscale Feather
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["South-west from {area:392} across the plains to the {area:1697}: the three nests sit together south-west of the oasis, and Sunscale Scytheclaws guard them. Each nest needs a {item:5165}: kill Sunscale raptors (most drop one) until you have three, then use a feather at each nest."] = "Para o sudoeste a partir de {area:392}, atravessando as planícies até {area:1697}: os três ninhos ficam juntos a sudoeste do oásis, e Garrafoices Helióscamo os guardam. Cada ninho precisa de uma {item:5165}: mate raptores Helióscamo (a maioria solta uma) até ter três, depois use uma pena em cada ninho.",

	-- Step 55: Raptor Grounds: kill these as you meet them
	-- {area:1697} Raptor Grounds
	["{area:1697}: kill these as you meet them"] = "{area:1697}: vá matando estes pelo caminho",
	-- {area:1697} Raptor Grounds · {npc:3446} Mebok Mizzyrix · {area:392} Ratchet · {area:385} Northwatch Hold
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["Sunscale Scytheclaws hunt the plains around the {area:1697}; they drop the horns. {npc:3446} takes them when the escort brings you back to {area:392}.\nSouth-east toward the coast: the stolen silver lies in a raptor nest north-west of {area:385}."] = "Garrafoices Helióscamo caçam nas planícies em volta de {area:1697}; eles deixam cair os chifres. {npc:3446} os recebe quando a escolta traz você de volta a {area:392}.\nPara o sudeste, rumo à costa: a prata roubada está num ninho de raptores a noroeste de {area:385}.",

	-- Step 56: Stolen Booty
	-- {area:385} Northwatch Hold
	["East to the beach, at the south end of the pirate camp: the crate of boots and the fragile crate with the lens sit there, a short walk north of {area:385}."] = "Para leste, até a praia, na ponta sul do acampamento dos piratas: a caixa de botas e a caixa frágil com a lente ficam lá, a uma curta caminhada ao norte de {area:385}.",

	-- Step 57: Northwatch Hold: kill these as you meet them
	-- {area:385} Northwatch Hold
	["{area:385}: kill these as you meet them"] = "{area:385}: vá matando estes pelo caminho",
	-- {area:385} Northwatch Hold · {npc:3393} Captain Fairmount
	-- plural, as words: Theramore Marines = {npc:3385} Theramore Marine
	["{area:385}, on the coast just south of the pirate camp. The Theramore Marines and Preservers (15-16) drop the medals; {npc:3393} (20) and the two cannoneers (19) stand in the keep and on its walls, and they are why the hold waits until now.\nCareful: Each named target is linked to a healer and guards, and Fairmount has three extra marines with her. Killing the healer first makes the fight easier."] = "{area:385}, na costa, logo ao sul do acampamento dos piratas. Os Fuzileiros e as Preservadoras de Theramore (15-16) deixam cair as medalhas; {npc:3393} (20) e os dois canhoneiros (19) ficam na fortaleza e nas muralhas, e é por isso que a fortaleza espera até agora.\nCuidado: cada alvo nomeado está ligado a um curandeiro e a guardas, e Fairmount tem três fuzileiros extras com ela. Matar o curandeiro primeiro deixa a luta mais fácil.",
	["On the top floor"] = "No último andar",
	["Upstairs"] = "No andar de cima",

	-- Step 58: Free From the Hold
	-- {npc:3465} Gilthares Firebough · {area:392} Ratchet
	["{npc:3465} is chained inside the hold. Talk to him to start the escort and stay close: Theramore soldiers attack on the way out. He walks you back to {area:392}."] = "{npc:3465} está acorrentado dentro do forte. Fale com ele para iniciar a escolta e fique perto: soldados de Theramore atacam na saída. Ele leva você de volta a {area:392}.",

	-- Step 66: Dreadmist Peak
	-- {area:384} Dreadmist Peak · {item:15842} Empty Dreadmist Peak Sampler · {object:19464} Dreadmist Peak Pool (no name in this language: may be words) · {npc:3448} Tonga Runetotem · {skill:182} Herbalism · {npc:3490} Hula'mahi · {item:2449} Earthroot
	["Head north from the Crossroads to {area:384} and fill the {item:15842} at the {object:19464}, then back to {npc:3448} in the Crossroads. No {skill:182}? {npc:3490} beside him sells {item:2449}, three at a time until he restocks."] = "Siga para o norte da Encruzilhada até {area:384} e encha o {item:15842} em {object:19464}, depois volte a {npc:3448} na Encruzilhada. Sem {skill:182}? {npc:3490}, ao lado dele, vende {item:2449}, três por vez até repor o estoque.",
	-- {item:2449} Earthroot · {npc:3490} Hula'mahi
	["{item:2449} from {npc:3490}; herbalists pick it on the plains"] = "{item:2449} de {npc:3490}; herbalistas colhem nas planícies",

	-- Step 67: Kolkar camp
	["Kolkar camp"] = "Acampamento Kolkar",
	-- {npc:3389} Regthar Deathgate · {item:2449} Earthroot
	-- plural, as words: Lost Barrens Kodos = {npc:3234} Lost Barrens Kodo
	["Lost Barrens Kodos roam the plains around the Kolkar camp north-west of {npc:3389}; herbalists pick {item:2449} there too."] = "Os Kodos Perdidos dos Sertões andam pelas planícies em volta do acampamento Kolkar, a noroeste de {npc:3389}; os herbalistas também colhem {item:2449} ali.",

	-- Step 68: Vrang Wildgore
	-- {area:383} Dry Hills · {npc:3682} Vrang Wildgore · {npc:261366} Walton
	["North to the {area:383}. {npc:3682} camps below the hills; {npc:261366}, the hermit on the ridge behind him, has work for you only once {npc:3682} sends you up."] = "Para o norte, até {area:383}. {npc:3682} acampa abaixo das colinas; {npc:261366}, o eremita na serra atrás dele, só tem trabalho para você depois que {npc:3682} mandar você subir.",

	-- Step 69: The Barrens: kill these as you meet them
	-- {quest:876} Serena Bloodfeather
	-- plural, as words: Savannah Patriarchs = {npc:3241} Savannah Patriarch · Sprung Traps = {object:640104} Sprung Trap
	["Savannah Patriarchs roam the plains east of the hills, and the Sprung Traps lie among them. {quest:876} leads the Witchwing harpies in the hills to the west.\nCareful: The route in passes stealthed Harpy Ambushers and an elite harpy that patrols."] = "Patriarcas da Savana vagam pelas planícies a leste das colinas, e as Armadilhas Disparadas estão no meio deles. {quest:876} lidera as harpias Asabruxa nas colinas a oeste.\nCuidado: o caminho até lá passa por harpias emboscadoras furtivas e por uma harpia elite que patrulha.",
	-- {quest:865} Raptor Horns
	-- plural, as words: Sunscale Scytheclaws = {npc:3256} Sunscale Scytheclaw
	["{quest:865}, if still open: Sunscale Scytheclaws prowl among the lions"] = "{quest:865}, se ainda estiver aberta: Garrafoices Helióscamo rondam no meio dos leões",

	-- Step 72: Trouble in the Valley
	-- {npc:262119} Corporal Adamore · {npc:261366} Walton
	["{npc:262119} and his marines hold the wrecked caravan south of {npc:261366}. The marines are linked: pulling one calls the rest. Pull from the edge and run; they leash short, so you can thin the camp one at a time before tackling the Corporal."] = "{npc:262119} e os fuzileiros dele ocupam a caravana destruída ao sul de {npc:261366}. Os fuzileiros andam juntos: puxou um, vêm todos. Puxe pela borda e corra; eles desistem logo, então dá para ir esvaziando o acampamento um por um antes de encarar o Cabo.",

	-- Step 73: Walton
	-- {npc:261366} Walton · {npc:261367} Terry Longdrink · {area:21} Kul Tiras
	["Assist {npc:261366}: stay by him when {npc:261367} and the {area:21} marines come up the ridge"] = "Ajude {npc:261366}: fique ao lado dele quando {npc:261367} e os fuzileiros de {area:21} subirem a serra",

	-- Step 74: Wenikee Boltbucket
	-- {npc:261366} Walton · {area:382} Sludge Fen · {npc:9316} Wenikee Boltbucket
	["East from {npc:261366} toward the {area:382}: {npc:9316} stands at the camp on the road north of the Crossroads."] = "Para o leste a partir de {npc:261366}, rumo a {area:382}: {npc:9316} fica no acampamento da estrada ao norte da Encruzilhada.",

	-- Step 75: Ignition
	-- {npc:3439} Wizzlecrank's Shredder · {area:382} Sludge Fen · {npc:3445} Supervisor Lugwizzle
	["{npc:3439} stands inside the Venture Co. camp in the {area:382}; {npc:3445} carries the key."] = "{npc:3439} fica dentro do acampamento da Empreendimentos S.A. em {area:382}; {npc:3445} carrega a chave.",

	-- Step 76: Strange Lockbox
	-- {object:177794} Strange Lockbox · {area:382} Sludge Fen · {item:15883} Half Pendant of Aquatic Agility · {quest:30} Trial of the Sea Lion
	["The {object:177794} lies at the north edge of the {area:382}, by the Venture Co. tower. It holds the {item:15883} for {quest:30}."] = "{object:177794} fica na borda norte de {area:382}, junto à torre da Empreendimentos S.A. Contém {item:15883} para {quest:30}.",

	-- Step 77: The Escape
	-- {npc:3442} Sputtervalve · {area:392} Ratchet
	["Wizzlecrank drives his shredder out of the camp: stay with him and kill whatever attacks him. {npc:3442} takes it in {area:392}.\nCareful: The route leads west and climbs a ramp. Once you reach the top, two Venture Company mobs ambush you."] = "Manivela tira o retalhador do acampamento: fique com ele e mate o que atacar. Quem recebe é {npc:3442}, em {area:392}.\nCuidado: o caminho vai para oeste e sobe uma rampa. Lá em cima, dois capangas da Empreendimentos S.A. emboscam você.",

	-- Step 78: Nugget Slugs
	-- {area:382} Sludge Fen
	["The tool buckets with the slugs lie around the Venture Co. drill site in the {area:382}."] = "Os baldes de ferramentas com as lesmas ficam em volta da perfuração da Empreendimentos S.A. em {area:382}.",

	-- Step 79: Boulder Lode Mine
	-- {item:5097} Cats Eye Emerald
	-- plural, as words: Venture Co. Overseers = {npc:3286} Venture Co. Overseer
	["The Venture Co. Overseers and Enforcers at the mine in the north-east corner of the zone drop the {item:5097}."] = "Os Feitores e Seguranças da Empreendimentos S.A. na mina do canto nordeste da zona deixam cair {item:5097}.",

	-- Step 80: Wenikee Boltbucket
	-- {npc:9316} Wenikee Boltbucket
	["West from the mine to {npc:9316}'s camp, then south down the road to the Crossroads."] = "A oeste da mina até o acampamento de {npc:9316}; depois desça a estrada para o sul até a Encruzilhada.",
	-- {quest:3923} Rilli Greasygob · {zone:1454} Orgrimmar · {object:172958} Valley of Honor (no name in this language: may be words)
	["Keep it: {quest:3923} is in {zone:1454}'s {object:172958}, on the {zone:1454} trip at 20"] = "Guarde: {quest:3923} fica em {object:172958}, em {zone:1454}, na ida a {zone:1454} no nível 20",

	-- Step 81: the Crossroads
	["the Crossroads"] = "a Encruzilhada",
	-- {npc:3449} Darsok Swiftdagger · {npc:3448} Tonga Runetotem
	["South down the road to the Crossroads: {npc:3449} stands on the tower platform, {npc:3448} at the south gate."] = "Desça a estrada para o sul até a Encruzilhada: {npc:3449} fica na plataforma da torre e {npc:3448}, no portão sul.",
	-- {item:15826} Curative Animal Salve
	["He gives you the {item:15826}"] = "Ele dá a você {item:15826}",

	-- Step 82: Verog the Dervish
	-- {npc:3395} Verog the Dervish · {area:388} Stagnant Oasis · {npc:3448} Tonga Runetotem
	["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Test {npc:3448}'s seeds at the bubbling fissure on the oasis' east bank while you are there."] = "{npc:3395} anda entre os Kolkar em {area:388}, a sudeste da Encruzilhada. Teste as sementes de {npc:3448} na fenda borbulhante da margem leste do oásis enquanto estiver lá.",
	["Underwater"] = "Debaixo d'água",
	-- {npc:12296} Sickly Gazelle · {item:15826} Curative Animal Salve
	["{npc:12296}: use the {item:15826} on them; they roam the plains all around the Crossroads"] = "{npc:12296}: use o {item:15826} neles; eles andam pelas planícies em volta da Encruzilhada",
	-- {npc:12296} Sickly Gazelle
	["Cure {npc:12296}"] = "Cure {npc:12296}",

	-- Step 83: Bristleback camps
	["Bristleback camps"] = "Acampamentos Costagulha",
	-- {area:378} Camp Taurajo · {area:458} Gold Road · {npc:3432} Mankrik · {npc:3430} Mangletooth · {quest:883} Lakota'mani
	["The Bristleback quilboar camps spread over the plains north of {area:378}, either side of the {area:458}. {npc:3432}'s wife lies at their north edge, on your way south. Leave the quilboar for now: {npc:3430} in {area:378} wants the same camps cleared. {quest:883}, a grey kodo, sometimes wanders here: his hoof starts a quest."] = "Os acampamentos dos javatuscos Costagulha se espalham pelas planícies ao norte de {area:378}, dos dois lados de {area:458}. A esposa de {npc:3432} está caída na borda norte deles, no seu caminho para o sul. Deixe os javatuscos para depois: {npc:3430}, em {area:378}, quer esses mesmos acampamentos limpos. {quest:883}, um kodo cinza, às vezes passeia por aqui: o casco dele inicia uma missão.",

	-- Step 84: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Follow the {area:458} south to {area:378}."] = "Siga {area:458} para o sul até {area:378}.",
	-- {npc:3430} Mangletooth
	["{npc:3430}, in the cage"] = "{npc:3430}, na jaula",

	-- Step 85: Bramblescar
	-- {npc:3432} Mankrik · {npc:3430} Mangletooth · {item:5075} Blood Shard
	["Back north into the Bristleback camps. Any Bristleback can drop a tusk for {npc:3432}, so collect them while you kill these for {npc:3430}. Keep one {item:5075}."] = "De volta ao norte, para os acampamentos Costagulha. Qualquer Costagulha pode deixar cair uma presa para {npc:3432}, então junte enquanto mata estes para {npc:3430}. Guarde um {item:5075}.",

	-- Step 88: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran · {item:5075} Blood Shard · {npc:3430} Mangletooth · {area:378} Camp Taurajo
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate. Keep the {item:5075}: {npc:3430} takes it on the next stop in {area:378}."] = "Suba pela {area:458} até a Encruzilhada: {npc:3448} no portão sul, {npc:3432} perto da estalagem, {npc:3428} a oeste do portão norte. Guarde o {item:5075}: {npc:3430} o recebe na próxima parada em {area:378}.",
	-- {npc:3448} Tonga Runetotem · {area:387} Lushwater Oasis · {npc:3396} Hezrul Bloodmark · {zone:1454} Orgrimmar
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3448}: the Oasis Snapjaws at {area:387}, with {npc:3396} after the {zone:1454} trip"] = "{npc:3448}: as Mordeliscas do Oásis em {area:387}, com {npc:3396} depois da viagem a {zone:1454}",
	-- {npc:3432} Mankrik · {quest:95774} Her Name Is Olgra · {quest:4921} Lost in Battle
	["{npc:3432} offers {quest:95774} once {quest:4921} is handed in"] = "{npc:3432} oferece {quest:95774} depois que {quest:4921} for entregue",
	-- {npc:3428} Korran · {area:390} Field of Giants · {area:378} Camp Taurajo · {zone:1454} Orgrimmar
	["{npc:3428}: the eggs are in the {area:390}, south of {area:378}, after the {zone:1454} trip"] = "{npc:3428}: os ovos ficam em {area:390}, ao sul de {area:378}, depois da ida a {zone:1454}",

	-- Step 89: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:1637} Orgrimmar · {npc:3615} Devrak
	["Train your level 20 ranks in {area:1637} now: fly from {npc:3615} on the Crossroads' tower."] = "Treine agora as habilidades de nível 20 em {area:1637}: voe com {npc:3615}, na torre da Encruzilhada.",

	-- Step 90: Orgrimmar
	-- {npc:3354} Sorek · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:5892} Searn Firewarder · {object:172957} Valley of Wisdom (no name in this language: may be words)
	["{npc:3354} is in the {object:172958}, {npc:5892} in the {object:172957}."] = "{npc:3354} fica em {object:172958}, {npc:5892} em {object:172957}.",

	-- Step 91: Valley of Honor
	-- {quest:3923} Rilli Greasygob · {object:172958} Valley of Honor (no name in this language: may be words)
	["{quest:3923} stands by the {object:172958}'s water, east of the Drag."] = "{quest:3923} fica junto à água de {object:172958}, a leste do Drag.",

	-- Step 92: Shenthul
	-- {quest:2458} Deep Cover · {npc:7233} Taskmaster Fizzule · {area:382} Sludge Fen
	["{quest:2458}: {npc:7233}, by the {area:382} on the next guide's walk north"] = "{quest:2458}: {npc:7233}, junto a {area:382}, na caminhada para o norte do próximo guia",

	-- Step 93: Orgrimmar class quests
	-- {zone:1454} Orgrimmar
	["{zone:1454} class quests"] = "Missões de classe em {zone:1454}",
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits (no name in this language: may be words)
	["{npc:6018} stands in the {object:172961} on the city's west side."] = "{npc:6018} fica no {object:172961}, no lado oeste da cidade.",

	-- Step 94: Gan'rul Bloodeye
	-- {object:172960} Cleft of Shadow (no name in this language: may be words) · {object:172982} Valley of Strength (no name in this language: may be words)
	["The {object:172960} is the canyon under the {object:172982}."] = "O {object:172960} é o cânion sob o {object:172982}.",
	-- {npc:5909} Cazul
	["{npc:5909}, a few steps away"] = "{npc:5909}, a poucos passos",

	-- Step 95: Ur'kyo
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits (no name in this language: may be words)
	["{npc:6018} stands in the {object:172961}, on the city's west side."] = "{npc:6018} fica em {object:172961}, no lado oeste da cidade.",
	-- {npc:6018} Ur'kyo · {npc:4606} Aelthalyste · {zone:1458} Undercity
	["{npc:6018}: {npc:4606} in the {zone:1458}, two guides on"] = "{npc:6018}: {npc:4606} em {zone:1458}, daqui a dois guias",

	-- Step 97: Thunder Bluff
	-- {npc:246344} Alodan the Hopeful · {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {area:378} Camp Taurajo · {zone:1412} Mulgore · {npc:2995} Tal
	["Train your level 20 ranks: {npc:246344} teaches Paladins in {area:1638}; {zone:1454} has no Paladin trainer. You have no flight path there yet: fly to {area:378}, head west through {zone:1412} and up a lift, and take the flight path from {npc:2995} on the central rise."] = "Treine as habilidades de nível 20: {npc:246344} ensina Paladinos em {area:1638}; {zone:1454} não tem instrutor de Paladino. Você ainda não tem a rota de voo de lá: voe para {area:378}, siga para oeste por {zone:1412}, suba um elevador e pegue a rota de voo com {npc:2995} no platô central.",

	-- Step 99: The Great Cat Spirit
	-- {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {spell:499} Cat Form · {spell:526} Cure Poison · {zone:1450} Moonglade · {npc:11798} Bunthen Plainswind · {area:392} Ratchet
	["Fly from the Crossroads to {area:1638} and train your level 20 ranks: {npc:3033} is on {area:1639}. {spell:499} and {spell:526} follow in {zone:1450} on the same trip, then {npc:11798} flies you back here and on to {area:392}."] = "Voe da Encruzilhada para {area:1638} e treine as habilidades de nível 20: {npc:3033} fica em {area:1639}. {spell:499} e {spell:526} vêm em seguida em {zone:1450}, na mesma viagem; depois {npc:11798} leva você de volta para cá e segue até {area:392}.",

	-- Step 100: Moonglade
	-- {spell:18960} Teleport: Moonglade · {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["Cast {spell:18960}. {npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "Use {spell:18960}. {npc:11802} fica no andar de cima do prédio dele em {area:2361}: suba por dentro, a seta não diferencia os andares.",

	-- Step 102: Moonglade
	-- {npc:11802} Dendrite Starblaze · {area:2361} Nighthaven
	["{npc:11802} stands upstairs in his building in {area:2361}: go up inside, the arrow cannot tell the floors apart."] = "{npc:11802} fica no andar de cima do prédio dele em {area:2361}: suba por dentro, a seta não diferencia os andares.",

	-- Step 103: Moonglade
	-- {npc:11802} Dendrite Starblaze · {npc:3033} Turak Runetotem
	["{npc:11802}: the welcome from {npc:3033}"] = "{npc:11802}: as boas-vindas de {npc:3033}",

	-- Step 104: The Stormrage Barrow Dens
	-- {area:2363} Stormrage Barrow Dens
	["The {area:2363}"] = "Os {area:2363}",
	-- {npc:11957} Great Cat Spirit · {npc:272054} Avatar of Saeyleenan · {item:280680} Relic of the Silent Shadow
	-- plural, as words: Territorial Terrans = {npc:230558} Territorial Terran
	["Tauren: the {npc:11957} waits on the southern hill above the bridge. Skyborne: the {npc:272054} stands south of the twin bridges. Then the dens east of the lake: leave your form, click the statue at the entrance for five minutes of stealth, keep clear of the spirits inside and take one of each relic; the {item:280680} lies at the foot of the white cat statue. Careful: the spirits are Territorial Terrans (level 60) that kill whoever they see: stay off their paths, and click the statue again before the stealth runs out."] = "Taurens: {npc:11957} espera na colina ao sul, acima da ponte. Celonatos: {npc:272054} fica ao sul das pontes gêmeas. Depois, as tocas a leste do lago: saia da forma, clique na estátua da entrada para ganhar cinco minutos de furtividade, evite os espíritos lá dentro e pegue uma de cada relíquia; {item:280680} fica ao pé da estátua do gato branco. Cuidado: os espíritos são Terranos Territoriais (nível 60) que matam quem estiver à vista: fique fora do caminho deles e clique na estátua de novo antes que a furtividade acabe.",

	-- Step 107: Fly to Ratchet
	-- {zone:1456} Thunder Bluff · {area:392} Ratchet
	["Fly from {zone:1456} on to {area:392}."] = "Siga voando de {zone:1456} para {area:392}.",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 108: Fly to Ratchet
	-- {area:392} Ratchet · {object:172982} Valley of Strength (no name in this language: may be words)
	["Fly on to {area:392} from Doras on the tower in the {object:172982}."] = "Siga voando para {area:392} com Doras, na torre de {object:172982}.",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 110: Ratchet: Wailing Caverns quests
	-- {area:392} Ratchet · {area:718} Wailing Caverns
	["{area:392}: {area:718} quests"] = "{area:392}: missões de {area:718}",
	-- {area:718} Wailing Caverns · {npc:3446} Mebok Mizzyrix · {object:3972} WANTED · {npc:3665} Crane Operator Bigglefuzz · {npc:3396} Hezrul Bloodmark
	["Your {area:718} quests, if you have not taken them yet: {npc:3446} beside the {object:3972} poster, {npc:3665} on the dock by the flight master. The run is later in this guide, after {npc:3396}."] = "Suas missões de {area:718}, se ainda não as pegou: {npc:3446}, ao lado do cartaz {object:3972}, e {npc:3665}, na doca junto ao mestre de voo. A ida à masmorra fica para mais adiante neste guia, depois de {npc:3396}.",

	-- Step 111: Islen Waterseer
	-- {npc:5901} Islen Waterseer · {area:392} Ratchet
	["{npc:5901} waits on the hill south of {area:392}, on your way north."] = "{npc:5901} espera na colina ao sul de {area:392}, no caminho para o norte.",

	-- Step 112: Ishamuhale
	-- {quest:882} Ishamuhale · {item:10338} Fresh Zhevra Carcass · {object:147538} Dead Tree (no name in this language: may be words) · {area:392} Ratchet
	["{quest:882}, a big Sunscale raptor, only comes to a fresh kill: loot a {item:10338} from a zhevra, then use it at the {object:147538} north-west of {area:392}, north of the road to the Crossroads, and be ready when he arrives."] = "{quest:882}, um grande raptor Helióscamo, só aparece para uma caça fresca: saqueie uma {item:10338} de uma zevra, use-a em {object:147538}, a noroeste de {area:392}, ao norte da estrada para a Encruzilhada, e fique pronto para quando ele chegar.",
	-- {item:10338} Fresh Zhevra Carcass
	-- plural, as words: Zhevra Chargers = {npc:3426} Zhevra Charger
	["{item:10338}, from any zhevra; Zhevra Chargers graze around the tree"] = "{item:10338}, de qualquer zevra; Corcéis Zevra pastam em volta da árvore",
	-- {object:147538} Dead Tree (no name in this language: may be words) · {quest:882} Ishamuhale
	["At the {object:147538}: summons {quest:882}"] = "Em {object:147538}: invoca {quest:882}",

	-- Step 113: Gazrog
	-- {npc:3464} Gazrog
	["{npc:3464}, by the Crossroads' north gate"] = "{npc:3464}, junto ao portão norte da Encruzilhada",

	-- Step 116: Ken'zigla
	-- {npc:4197} Ken'zigla · {area:2539} Malaka'jin · {npc:3389} Regthar Deathgate
	["{npc:4197} lives in {area:2539}, the troll village just inside Stonetalon at the end of the road west from {npc:3389}."] = "{npc:4197} vive em {area:2539}, a aldeia troll logo na entrada da Cordilheira das Torres de Pedra, no fim da estrada a oeste de {npc:3389}.",

	-- Step 117: To Regthar Deathgate
	-- {npc:3389} Regthar Deathgate
	["To {npc:3389}"] = "Até {npc:3389}",

	-- Step 119: Hezrul Bloodmark
	-- {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:3389} Regthar Deathgate · {npc:3448} Tonga Runetotem
	-- plural, as words: Oasis Snapjaws = {npc:3461} Oasis Snapjaw
	["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. He walks that shore, from about 46,36 in the north to 46,42 in the south: if he isn't at the arrow, follow the shore until you meet him. Hand his head to {npc:3389} on your last Crossroads stop. Oasis Snapjaws crawl in the oasis' water there: their shells are for {npc:3448}."] = "{npc:3396} lidera os Kolkar na margem oeste de {area:387}, ao sul de {npc:3389}. Ele anda por essa margem, de cerca de 46,36 no norte a 46,42 no sul: se ele não estiver na seta, siga a margem até encontrá-lo. Entregue a cabeça dele a {npc:3389} na sua última parada na Encruzilhada. As Mordeliscas do Oásis rastejam ali na água do oásis: as carapaças delas são para {npc:3448}.",

	-- Step 120: Nalpak and Ebru
	-- {npc:5767} Nalpak · {npc:5768} Ebru
	["{npc:5767} and {npc:5768}"] = "{npc:5767} e {npc:5768}",
	-- {area:718} Wailing Caverns · {npc:5767} Nalpak · {npc:5768} Ebru
	["For your {area:718} run: {npc:5767} and {npc:5768} stand in a hidden cave in the rocks above the entrance, at the north end of the oasis' west shore: climb up from the west side. Follow the arrow up."] = "Para a masmorra {area:718}: {npc:5767} e {npc:5768} ficam numa caverna escondida nas rochas acima da entrada, no extremo norte da margem oeste do oásis: suba pelo lado oeste. Siga a seta para cima.",

	-- Step 121: Wailing Caverns
	-- {area:718} Wailing Caverns · {npc:3396} Hezrul Bloodmark · {area:387} Lushwater Oasis · {npc:5767} Nalpak · {npc:3655} Mad Magglish · {item:5334} 99-Year-Old Port · {npc:5768} Ebru · {item:6464} Wailing Essence · {npc:3678} Disciple of Naralex · {npc:3654} Mutanus the Devourer · {item:10441} Glowing Shard · {area:392} Ratchet · {npc:8418} Falla Sagewind
	["{area:718} is a dungeon for a group of five, about levels 17 to 24, and a full run takes about an hour. Its mouth is just north of {npc:3396}'s shore, at the north end of {area:387}, under {npc:5767}'s cave.\nIn the caves before the portal: {npc:3655}, stealthed, with the {item:5334} (he moves between a few spots and comes back slowly: leave him if he's gone). Inside: the Deviates for {npc:5768}, and their hides for {npc:5767} (they drop rarely: one run may not be enough, so leave the rest for another run), {item:6464} from the Ectoplasms. After the four Fanglords, the {npc:3678} at the entrance leads you to Naralex: {npc:3654} drops the {item:10441}: its quest (someone in {area:392}, then {npc:8418} above the caverns) is not on this route; the Dungeons page's hand-in guide takes it."] = "{area:718} é uma masmorra para um grupo de cinco, por volta dos níveis 17 a 24, e percorrê-la inteira leva cerca de uma hora. A boca fica logo ao norte da margem de {npc:3396}, no extremo norte de {area:387}, abaixo da caverna de {npc:5767}.\nNas cavernas antes do portal: {npc:3655}, furtivo, com o {item:5334} (ele se move entre alguns pontos e demora a voltar: deixe-o se ele tiver sumido). Lá dentro: os Deviates para {npc:5768}, e os couros deles para {npc:5767} (caem raramente: uma ida pode não bastar, então deixe o resto para outra ida), {item:6464} dos Ectoplasmas. Depois dos quatro Fanglords, o {npc:3678} na entrada leva você até Naralex: {npc:3654} deixa cair o {item:10441}: a missão dele (alguém em {area:392}, depois {npc:8418} acima das cavernas) não está nesta rota; o guia de entregas da página de Masmorras cuida dela.",
	-- {item:6464} Wailing Essence
	["{item:6464}: the Ectoplasms"] = "{item:6464}: os Ectoplasmas",

	-- Step 122: Nalpak
	["Back out of the caverns and up to the cave above the entrance."] = "Saia das cavernas e suba até a caverna acima da entrada.",

	-- Step 124: Olgra's Adornments
	-- {area:458} Gold Road · {area:378} Camp Taurajo · {item:277277} Olgra's Adornments · {npc:3432} Mankrik
	-- plural, as words: Razormane Raiders = {npc:268624} Razormane Raider
	["On the way back down the {area:458} to {area:378}: the Razormane Raiders among the Bristleback camps, either side of the road north of the camp, carry {item:277277}. Hand them to {npc:3432} on your last Crossroads stop."] = "Na volta por {area:458} até {area:378}: os Saqueadores Crinavalha entre os acampamentos Costagulha, dos dois lados da estrada ao norte do acampamento, carregam {item:277277}. Entregue-os a {npc:3432} na última parada na Encruzilhada.",

	-- Step 125: Camp Taurajo
	-- {area:458} Gold Road · {area:378} Camp Taurajo
	["Down the {area:458} to {area:378} again."] = "Desça {area:458} até {area:378} de novo.",
	-- {npc:12696} Senani Thunderheart · {zone:1440} Ashenvale
	["Keep it: {npc:12696} in {zone:1440}, next guide"] = "Guarde-a: {npc:12696} em {zone:1440}, próximo guia",
	-- {npc:6394} Ruga Ragetotem
	["{npc:6394}, inside"] = "{npc:6394}, lá dentro",

	-- Step 127: Grunt Dogran
	["Dogran is chained up in the quilboar camp west of the road."] = "Dogran está acorrentado no acampamento de javatuscos a oeste da estrada.",
	-- {npc:5875} Gan'rul Bloodeye · {zone:1454} Orgrimmar
	["Keep it: {npc:5875} in {zone:1454}, on the next guide's {zone:1454} stop"] = "Guarde: {npc:5875} em {zone:1454}, na parada em {zone:1454} do próximo guia",

	-- Step 128: Enraged Thunder Lizards
	-- {area:378} Camp Taurajo · {quest:884} Owatanka
	-- plural, as words: Thunderheads = {npc:3239} Thunderhead
	["Thunderheads graze on the plains just south of {area:378}. {quest:884}, a blue thunder lizard, roams among them: his Tailspike starts a quest."] = "Cabeças-de-trovão pastam nas planícies logo ao sul de {area:378}. {quest:884}, um lagarto-trovão azul, vaga entre eles: a Ponta da Cauda dele inicia uma missão.",

	-- Step 129: Jorn Skyseer
	-- {quest:1824} Trial at the Field of Giants · {npc:6394} Ruga Ragetotem
	["Warriors: take {quest:1824} from {npc:6394} now: it runs for 30 minutes from the accept. The eggs and the antennae come first, at the same mounds, then straight back to {npc:6394}; the thunderhawks after."] = "Guerreiros: pegue {quest:1824} com {npc:6394} agora: são 30 minutos de prazo a partir da aceitação. Os ovos e as antenas vêm primeiro, nos mesmos montes, depois direto de volta a {npc:6394}; os falcotrons ficam para depois.",

	-- Step 130: Field of Giants
	-- {area:390} Field of Giants
	-- plural, as words: Silithid Mounds = {object:3685} Silithid Mound · Silithid Swarmers = {npc:3252} Silithid Swarmer
	["South of Camp Taurajo, the Silithid Mounds dot the {area:390}; the eggs lie in them, and Silithid Swarmers come out to defend them.\nCareful: Silithid Swarmers in the area release many tiny adds that interrupt spells; damage shields such as Thorns kill them in one hit."] = "Ao sul do Acampamento Taurajo, os Montes de Terra Silitídeos se espalham por {area:390}; os ovos ficam neles, e Enxameadores Silitídeos saem para defendê-los.\nCuidado: os Enxameadores Silitídeos da região soltam muitos bichinhos que interrompem feitiços; escudos de dano como Espinhos matam cada um com um golpe.",

	-- Step 131: Twitching Antennae
	["Twitching Antennae"] = "Antenas Agitadas",
	-- {npc:6394} Ruga Ragetotem · {area:378} Camp Taurajo · {npc:4196} Silithid Swarm · {npc:5781} Silithid Creeper Egg · {npc:3253} Silithid Harvester
	-- plural, as words: Silithid Swarmers = {npc:3252} Silithid Swarmer · Silithid Creepers = {npc:3250} Silithid Creeper
	["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the same mounds until you have five, then take them straight to {npc:6394} in {area:378}, before the thunderhawks. Careful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds; Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds. A {npc:3253} (24, rare) also wanders the mounds: leave it."] = "As antenas somem quinze minutos depois de caírem: mate os Enxameadores e Rastejantes Silitídeos nos mesmos montes até ter cinco, depois leve-as direto a {npc:6394} em {area:378}, antes dos falcotrons. Cuidado: Enxameadores Silitídeos (nível 21-22) soltam {npc:4196} dentro e fora de combate, o que traz vários bichinhos; Rastejantes Silitídeos (nível 20-21) soltam {npc:5781} de tempos em tempos em combate, o que gera bichinhos extras. Um {npc:3253} (24, raro) também anda pelos montes: deixe-o em paz.",
	["Twitching Antennae from the silithid"] = "Antenas Agitadas dos silitídeos",

	-- Step 132: Ruga Ragetotem
	-- {area:378} Camp Taurajo · {npc:6394} Ruga Ragetotem
	["Back north into {area:378} before the antennae fade: {npc:6394} is inside."] = "De volta ao norte até {area:378} antes que as antenas sumam: {npc:6394} está lá dentro.",

	-- Step 133: Cry of the Thunderhawk
	-- plural, as words: Thunderhawk Cloudscrapers = {npc:3424} Thunderhawk Cloudscraper
	["Thunderhawk Cloudscrapers circle over the plains south of the camp."] = "Falcotrons Raspa-nuvens voam em círculos sobre as planícies ao sul do acampamento.",

	-- Step 134: Brine
	-- {npc:5899} Brine · {area:378} Camp Taurajo · {item:7766} Empty Brown Waterskin
	["{npc:5899}'s hut stands on the ridge above the quilboar watering hole, south of {area:378}: fill the {item:7766} at the watering hole below it."] = "A cabana de {npc:5899} fica na crista acima do bebedouro dos javatuscos, ao sul de {area:378}: encha o {item:7766} no bebedouro abaixo dela.",
	-- {item:7766} Empty Brown Waterskin
	["Fill the {item:7766} at the quilboar watering hole"] = "Encha o {item:7766} no bebedouro dos javaligs",
	-- {object:107045} Spring Well (no name in this language: may be words) · {area:272} Tarren Mill · {area:287} Hillsbrad
	["Keep it: the {object:107045} is beside {area:272}, on the {area:287} guide"] = "Guarde: {object:107045} fica ao lado de {area:272}, no guia de {area:287}",

	-- Step 135: Camp Taurajo
	-- {area:378} Camp Taurajo
	["Back north into {area:378} on the way to the Crossroads: Jorn takes the thunderhawk wings."] = "De volta ao norte, para {area:378}, no caminho para a Encruzilhada: Jorn recebe as asas de falcotron.",

	-- Step 136: The Crossroads
	-- {area:458} Gold Road · {npc:3448} Tonga Runetotem · {npc:3432} Mankrik · {npc:3428} Korran
	["North up the {area:458} to the Crossroads: {npc:3448} at the south gate, {npc:3432} by the inn, {npc:3428} west of the north gate."] = "Suba pela {area:458} até a Encruzilhada: {npc:3448} no portão sul, {npc:3432} perto da estalagem, {npc:3428} a oeste do portão norte.",

	-- Step 137: Thun'grim Firegaze
	-- {npc:5878} Thun'grim Firegaze
	["{npc:5878} camps beside the road east of the Crossroads."] = "{npc:5878} acampa ao lado da estrada a leste da Encruzilhada.",
	-- {quest:1838} Brutal Armor · {area:1717} Razorfen Kraul
	["He offers {quest:1838} next (1838, level 30): it needs {area:1717} and sends you all over Kalimdor and the Eastern Kingdoms. The Warrior class guide {quest:1838} covers it."] = "Em seguida ele oferece {quest:1838} (1838, nível 30): ela exige {area:1717} e manda você por toda Kalimdor e pelos Reinos do Leste. O guia da classe Guerreiro {quest:1838} cobre essa missão.",

	-- Step 139: Counterattack!
	-- {npc:3389} Regthar Deathgate · {npc:9456} Warlord Krom'zar
	["Speak to {npc:3389} again to start the attack: the Kolkar charge the bunkers just west of him in waves. Fight beside the grunts until {npc:9456} (elite, 20) arrives with two bodyguards, usually from the south, then click the banner over his body."] = "Fale de novo com {npc:3389} para começar o ataque: os Kolkar atacam os bunkers logo a oeste dele em ondas. Lute ao lado dos soldados até {npc:9456} (elite, 20) chegar com dois guarda-costas, geralmente pelo sul; depois clique no estandarte sobre o corpo dele.",

	-- Step 140: Seereth Stonebreak's camp
	-- {npc:4049} Seereth Stonebreak
	["{npc:4049}'s camp"] = "O acampamento de {npc:4049}",

	-- Step 141: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["{npc:4049} and {npc:11857} share the camp on the road west to Stonetalon."] = "{npc:4049} e {npc:11857} dividem o acampamento na estrada que vai para o oeste, rumo a Torres de Pedra.",
	-- {npc:4049} Seereth Stonebreak · {area:461} Windshear Crag
	["{npc:4049}: the Venture loggers at {area:461}"] = "{npc:4049}: os madeireiros da Empreendimentos S.A. em {area:461}",

	-- Step 142: Grimtotem camp
	["Grimtotem camp"] = "Acampamento Temível Totem",
	-- {npc:11857} Makaba Flathoof
	["The Grimtotem camp is just north of {npc:11857}, a short walk off the road: Ruffians and Mercenaries stand among the tents."] = "O acampamento Temível Totem fica logo ao norte de {npc:11857}, a uma curta caminhada fora da estrada: Rufiões e Mercenários ficam no meio das tendas.",

	-- Step 143: Makaba Flathoof
	-- {npc:11857} Makaba Flathoof
	["Back down to {npc:11857}."] = "De volta a {npc:11857}.",
	-- {npc:11858} Grundig Darkcloud · {area:1076} Webwinder Path
	["{npc:11858} waits up the {area:1076}"] = "{npc:11858} espera no alto de {area:1076}",

	-- Step 144: To Malaka'jin
	-- {area:2539} Malaka'jin
	["To {area:2539}"] = "Para {area:2539}",

	-- Step 145: Malaka'jin
	-- {npc:4049} Seereth Stonebreak · {area:2539} Malaka'jin
	["Follow the road on west from {npc:4049} into Stonetalon. The troll village of {area:2539} sits at the entrance of the canyon."] = "Siga a estrada para oeste a partir de {npc:4049}, rumo a Torres de Pedra. A vila troll de {area:2539} fica na entrada do desfiladeiro.",
	-- {npc:12816} Xen'Zilla · {area:1076} Webwinder Path
	["{npc:12816}: the spiders along the {area:1076}"] = "{npc:12816}: as aranhas ao longo de {area:1076}",

	-- Step 146: Webwinder Path: kill these as you meet them
	-- {area:1076} Webwinder Path
	["{area:1076}: kill these as you meet them"] = "{area:1076}: vá matando estes pelo caminho",
	-- {area:2539} Malaka'jin · {npc:11858} Grundig Darkcloud
	-- plural, as words: Grimtotem Brutes = {npc:11912} Grimtotem Brute · Deepmoss Creepers = {npc:4005} Deepmoss Creeper
	["North up the road from {area:2539}: {npc:11858} and his Grimtotem Brutes hold the bend in the road, and the Deepmoss Creepers and Venomspitters lurk in the webs on both sides of the path all the way up."] = "Subindo a estrada a partir de {area:2539}: {npc:11858} e os Brutos Temível Totem dele dominam a curva da estrada, e os Rastejantes e Cospeçonhas de Fundolimo espreitam nas teias dos dois lados da trilha, até lá em cima.",

	-- Step 147: Ziz Fizziks
	-- {area:1076} Webwinder Path · {quest:1483} Ziz Fizziks · {area:461} Windshear Crag
	["The road climbs north as the {area:1076}. {quest:1483} has a hut where the road forks east to {area:461}."] = "A estrada sobe para o norte como {area:1076}. {quest:1483} tem uma cabana onde a estrada se divide para leste rumo a {area:461}.",
	-- {quest:1483} Ziz Fizziks
	["{quest:1483}, inside"] = "{quest:1483}, lá dentro",

	-- Step 148: Windshear Crag
	-- {area:461} Windshear Crag
	["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints."] = "A leste de Zé Fízzica, a Empreendimentos S.A. está desmatando {area:461}; um dos Operadores leva as plantas.",
	-- plural, as words: Venture Co. Loggers = {npc:3989} Venture Co. Logger
	["Venture Co. Loggers, all over the clear-cut"] = "Madeireiros da Empreendimentos S.A., por toda a área desmatada",

	-- Step 149: Piznik
	-- {npc:4276} Piznik · {area:2160} Windshear Mine
	["{npc:4276}'s defence is hard alone at this level: grouping up is encouraged, look for people to do it with. Skip it if you are alone.\n{npc:4276} mines at the bottom of the {area:2160} on the east side of the crag, past its kobolds (levels 19-23). Talk to him, then keep him alive for five minutes while he mines: a dozen or more kobolds come at him in waves, melee fighters first, then casters, and the mine's own kobolds respawn into the fight. If he dies, the quest fails."] = "A defesa de {npc:4276} é difícil sozinho neste nível: recomenda-se formar grupo, procure gente para fazer com você. Pule se estiver sozinho.\n{npc:4276} minera no fundo de {area:2160}, no lado leste do penhasco, depois dos kobolds de lá (níveis 19-23). Fale com ele e depois mantenha-o vivo por cinco minutos enquanto ele minera: uma dúzia ou mais de kobolds vem para cima dele em ondas, primeiro os combatentes corpo a corpo, depois os conjuradores, e os kobolds da própria mina renascem no meio da luta. Se ele morrer, a missão falha.",
	-- {npc:4276} Piznik
	["{npc:4276}, below ground"] = "{npc:4276}, no subterrâneo",

	-- Step 150: Ziz Fizziks: Gerenzo's Orders
	-- {npc:4201} Ziz Fizziks
	["{npc:4201}, inside"] = "{npc:4201}, lá dentro",

	-- Step 151: Ziz Fizziks
	-- {npc:4201} Ziz Fizziks · {npc:3442} Sputtervalve · {area:392} Ratchet · {zone:1413} The Barrens
	["{npc:4201}: for {npc:3442}, beside {area:392}'s flight master at the end of the {zone:1413} & Stonetalon guide"] = "{npc:4201}: para {npc:3442}, ao lado do mestre de voo de {area:392}, no fim do guia de {zone:1413} e Torres de Pedra",

	-- Step 152: Kaya Flathoof
	-- {area:1076} Webwinder Path · {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud · {area:2538} Camp Aparaje
	["On the way back down the {area:1076}, {npc:11856} is held in {npc:11858}'s hut at the bend in the road. Once you take her quest she walks straight off south-east to {area:2538}, the burned village, without waiting: stay close, or the quest fails.\nCareful: Three Grimtotems ambush her at the burned village and go for her, not you: pull them off her and kill their caster quickly."] = "Na descida de volta por {area:1076}, {npc:11856} está presa na cabana de {npc:11858}, na curva da estrada. Assim que você aceitar a missão dela, ela segue direto para sudeste até {area:2538}, a aldeia queimada, sem esperar: fique perto, ou a missão falha.\nCuidado: três Temível Totem a emboscam na aldeia queimada e vão para cima dela, não de você: tire-os de cima dela e mate o conjurador deles rápido.",
	-- {npc:11856} Kaya Flathoof · {npc:11858} Grundig Darkcloud
	["{npc:11856}, inside {npc:11858}'s hut"] = "{npc:11856}, dentro da cabana de {npc:11858}",

	-- Step 153: Malaka'jin
	-- {area:2539} Malaka'jin · {npc:12816} Xen'Zilla
	["West from the burned village to {area:2539}: {npc:12816} stands just outside it, before the village."] = "A oeste da aldeia queimada até {area:2539}: {npc:12816} fica logo fora dela, antes da vila.",

	-- Step 155: Seereth Stonebreak
	-- {npc:4049} Seereth Stonebreak · {npc:11857} Makaba Flathoof
	["East along the road to {npc:4049} and {npc:11857}'s camp, on the way back out of Stonetalon."] = "A leste pela estrada até o acampamento de {npc:4049} e {npc:11857}, na volta de Torres de Pedra.",
	-- {npc:11857} Makaba Flathoof · {npc:11864} Tammra Windfield · {area:460} Sun Rock Retreat · {zone:1413} The Barrens
	["{npc:11857}: keep it, {npc:11864} at {area:460} in the {zone:1413} & Stonetalon guide"] = "{npc:11857}: guarde, {npc:11864} em {area:460}, no guia de {zone:1413} e Torres de Pedra",
	-- {zone:1413} The Barrens · {area:1703} Mor'shan Rampart · {zone:1440} Ashenvale
	["The next guide goes north-east across the {zone:1413} to the {area:1703} and {zone:1440}."] = "O próximo guia segue para nordeste por {zone:1413} até {area:1703} e {zone:1440}.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back down the beach, past the pirate camp: the crate of boots and the fragile crate with the lens sit at its south end."] = "Volte pela praia, depois do acampamento pirata: o caixote de botas e o caixote frágil com a lente ficam na ponta sul.",
	-- ["Back down the {area:1076}: {npc:12816} stands just outside {area:2539}, before the village."] = "De volta por {area:1076}: {npc:12816} fica logo fora de {area:2539}, antes da vila.",
	-- ["Back north into {area:378} on the way to the Crossroads: {npc:3387} takes the thunderhawk wings. Warriors: {npc:6394} first, before the antennae fade."] = "De volta ao norte, em {area:378}, a caminho da Encruzilhada: {npc:3387} recebe as asas de falcotrom. Guerreiros: {npc:6394} primeiro, antes que as antenas sumam.",
	-- ["Back to the Razormane camp. Geomancers and Defenders hold its eastern half; {npc:3438} walks among them."] = "De volta ao acampamento Crinavalha. Geomantes e Defensores ocupam a metade leste; {npc:3438} anda entre eles.",
	-- ["Back west along the road."] = "Volte para oeste pela estrada.",
	-- ["Burning Blade Cultists hold {area:1898} in northern {area:14}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Sectários da Lâmina Ardente ocupam {area:1898}, no norte de {area:14}; eles deixam cair o {item:6652}. O {item:5026} vem dos Crinavalha na sua próxima visita ao acampamento deles.",
	-- ["Burning Blade Cultists hold {area:1898} in northern {zone:1411}; they drop the {item:6652}. The {item:5026} comes from the Razormane on your next visit to their camp."] = "Sectários da Lâmina Ardente ocupam {area:1898}, no norte de {zone:1411}; eles deixam cair o {item:6652}. O {item:5026} vem dos Crinavalha na sua próxima visita ao acampamento deles.",
	-- ["Cast {spell:18960}. Tauren: join the two pendant halves at the {area:2362}, on the north-west shore of the lake, before you see {npc:11802} in {area:2361}. {npc:11802} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Use {spell:18960}. Taurens: juntem as duas metades do pingente em {area:2362}, na margem noroeste do lago, antes de ver {npc:11802} em {area:2361}. {npc:11802} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- ["East of Ziz, the Venture Company is clear-cutting {area:461}; one of the Operators carries the blueprints. {npc:4276} mines in the small mine on the east side: stay with him while he mines, Venture Co. thugs come for him.\nCareful: The kobolds arrive in waves. The first wave is melee fighters, and the second adds casters to the mix. Regular mobs in the mine respawn quickly and can join the fight while the waves are coming. A group is recommended."] = "A leste do Zé, a Empreendimentos S.A. está desmatando {area:461}; um dos Operadores está com as plantas. {npc:4276} trabalha na minazinha do lado leste: fique com ele enquanto minera, porque os capangas da Empreendimentos S.A. vêm atrás dele.\nCuidado: os kobolds chegam em ondas. A primeira é de corpo a corpo, a segunda mistura lançadores de feitiço. Os monstros comuns da mina renascem rápido e podem entrar na briga durante as ondas. Melhor ir em grupo.",
	-- ["East to the {area:1703}; {npc:9316} stands at the camp just south of it."] = "Para leste até {area:1703}; {npc:9316} fica no acampamento logo ao sul.",
	-- ["East to {area:392}, on the coast."] = "Para leste até {area:392}, no litoral.",
	-- ["Fly back to the Crossroads; the road west to Stonetalon starts at {npc:3389}'s bunkers."] = "Voe de volta para a Encruzilhada; a estrada para o oeste, rumo a Torres de Pedra, começa nos bunkers de {npc:3389}.",
	-- ["Fly from the Crossroads to {area:1638}: {npc:3033} trains you on {area:1639}."] = "Voe da Encruzilhada para {area:1638}: {npc:3033} treina você em {area:1639}.",
	-- ["Fly to {area:1638} to train: {npc:3033} is on {area:1639}."] = "Voe para {area:1638} para treinar: {npc:3033} fica em {area:1639}.",
	-- ["Follow the road east to the outpost above the {area:814}."] = "Siga a estrada para leste até o posto acima de {area:814}.",
	-- ["In from the north gate: {npc:3464} first, {npc:3338} by the inn, {npc:3448} at the south gate, then up to {npc:3449} and {npc:3429} on the tower platform, where the flight master stands."] = "Entrando pelo portão norte: {npc:3464} primeiro, {npc:3338} junto à estalagem, {npc:3448} no portão sul; depois suba até {npc:3449} e {npc:3429}, na plataforma da torre, onde fica o mestre de voo.",
	-- ["In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end.\nPlainstriders here count toward the beaks."] = "No acampamento, os Rabdomantes e os Tecespinhos ficam na metade oeste e os Caçadores Crinavalha no meio; as caixas de suprimentos ficam na ponta leste.\nOs Pinotes daqui também contam para os bicos.",
	-- ["Keep it: {quest:3923} stands outside {zone:1454}; a later guide hands it in"] = "Guarde-o: {quest:3923} fica do lado de fora de {zone:1454}; um guia posterior o entrega",
	-- ["Kolkar Wranglers and Stormers hold the camps south of {npc:3389}."] = "Cavalgantes e Tempestários Kolkar ocupam os acampamentos ao sul de {npc:3389}.",
	-- ["Kolkar camps"] = "Acampamentos kolkar",
	-- ["North up the {area:458} to the Crossroads: {npc:3432} stands by the inn, {npc:3428} west of the north gate."] = "Suba pela {area:458} até a Encruzilhada: {npc:3432} fica perto da estalagem, {npc:3428} a oeste do portão norte.",
	-- ["North up the {area:458} to the Crossroads: {npc:3432} stands by the inn, {npc:3428} west of the north gate. Keep the {item:5075}: {npc:3430} takes it on the next stop in {area:378}."] = "Suba pela {area:458} até a Encruzilhada: {npc:3432} fica perto da estalagem, {npc:3428} a oeste do portão norte. Guarde o {item:5075}: {npc:3430} o recebe na próxima parada em {area:378}.",
	-- ["Oasis Snapjaws crawl around {area:387}, south-west of the Crossroads, and around the {area:388}."] = "Mordeliscas do Oásis rastejam em volta de {area:387}, a sudoeste da Encruzilhada, e em volta de {area:388}.",
	-- ["Over the {area:814} bridge below {area:379} and south along the {zone:1411} bank to where a narrow trail climbs the mountain: {npc:5900} keeps the shrine at the top. Mind the edges on the way up, and come back down the same trail."] = "Atravesse a ponte de {area:814} abaixo de {area:379} e siga para o sul pela margem de {zone:1411} até onde uma trilha estreita sobe a montanha: {npc:5900} cuida do santuário no topo. Cuidado com as beiradas na subida e desça pela mesma trilha.",
	-- ["Plainstriders and Sunscale raptors roam the plains all around the {area:380}, thickest to the north."] = "Pinotes e raptores Helióscamo vagam pelas planícies em volta da {area:380}, mais densos ao norte.",
	-- ["Plainstriders and raptors"] = "Pinotes e raptores",
	-- ["Raptor nests"] = "Ninhos de raptor",
	-- ["South to {npc:3389}'s watch post on the Kolkar border."] = "Para o sul até o posto de vigia de {npc:3389}, na fronteira kolkar.",
	-- ["South-east of the Crossroads. Test the seeds at the bubbling fissure on the oasis' east bank."] = "A sudeste da Encruzilhada. Teste as sementes na fenda borbulhante da margem leste do oásis.",
	-- ["South-east of the Crossroads. Test the seeds at the bubbling fissure on the oasis' east bank; {npc:3448} takes the result on the next Crossroads stop, so carry on north-west to the {area:383} from here."] = "A sudeste da Encruzilhada. Teste as sementes na fenda borbulhante da margem leste do oásis; {npc:3448} recebe o resultado na próxima parada na Encruzilhada, então siga daqui para o noroeste até {area:383}.",
	-- ["South-east of the {area:380}. Test the seeds at the bubbling fissure on the oasis' east bank."] = "A sudeste da {area:380}. Teste as sementes na fenda borbulhante da margem leste do oásis.",
	-- ["South-west from {area:392} across the plains to the {area:1697}: the three nests sit together south-west of the oasis, and Sunscale Scytheclaws guard them."] = "Para o sudoeste a partir de {area:392}, atravessando as planícies até {area:1697}: os três ninhos ficam juntos a sudoeste do oásis, e Garrafoices Helióscamo os guardam.",
	-- ["Southsea beach"] = "Praia dos Mares do Sul",
	-- ["Still short of twelve? The Sunscale Screechers are thickest on the plains around {quest:881}'s lair, north of the Razormane camp."] = "Ainda não chegou a doze? Os Uivadores Helióscamo são mais numerosos nas planícies em volta do covil de {quest:881}, ao norte do acampamento Crinavalha.",
	-- ["Sunscale raptors here count toward the heads."] = "Os raptores Helióscamo daqui também contam para as cabeças.",
	-- ["The Savannah Prowlers hunt the plains between town and the Razormane camp to the east. In the camp, Water Seekers and Thornweavers hold the western half, Hunters the middle; the supply crates sit at its eastern end."] = "Os Predadores da Savana caçam nas planícies entre a cidade e o acampamento Crinavalha a leste. No acampamento, Rabdomantes e Tecespinhos ocupam a metade oeste, Caçadores o meio; os caixotes de suprimentos ficam na ponta leste.",
	-- ["The Witchwing Slayers hold the western {area:383}; they wear the rings."] = "As Asabruxas Matadoras ocupam o oeste de {area:383}; elas usam os anéis.",
	-- ["The antennae vanish fifteen minutes after they drop: kill the Silithid Swarmers and Creepers at the {area:390}' mounds, just south of {npc:3387}'s thunderhawks, until you have five, then take them straight to {npc:6394} in {area:378}.\nCareful: Silithid Swarmers (level 21-22) cast {npc:4196} both in and out of combat, which brings several small adds. Silithid Creepers (level 20-21) periodically cast {npc:5781} in combat, which spawns extra adds."] = "As antenas somem quinze minutos depois de caírem: mate os Enxameadores e Rastejantes Silitídeos nos montes de {area:390}, logo ao sul dos falcotrons de {npc:3387}, até ter cinco, depois leve-as direto a {npc:6394} em {area:378}.\nCuidado: Enxameadores Silitídeos (nível 21-22) soltam {npc:4196} dentro e fora de combate, o que traz vários bichinhos. Rastejantes Silitídeos (nível 20-21) soltam {npc:5781} de tempos em tempos em combate, o que gera bichinhos extras.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them."] = "Os piratas acampam na praia ao sul de {area:392}. As pilhas de peças complicadas ficam na areia entre eles.",
	-- ["The pirates camp on the beach south of {area:392}. The piles of complicated parts lie in the sand among them.\nThe pirates camp on the beach south of {area:392}; {npc:3467} stands at its southern end."] = "Os piratas acampam na praia ao sul de {area:392}. Os montes de peças complicadas estão na areia, no meio deles.\nOs piratas acampam na praia ao sul de {area:392}; {npc:3467} fica na ponta sul.",
	-- ["The pools lie just north of {npc:3389}. Walk into the water to explore them; the Laden Mushrooms for Helbrim grow around them. Kill every Kolkar you pass for bracers."] = "Os poços ficam logo ao norte de {npc:3389}. Entre na água para explorá-los; os Cogumelos Carregados para Hermógenes crescem em volta deles. Mate todo kolkar que encontrar pelas braçadeiras.",
	-- ["The three nests sit together in the {area:1697} south-west of the oasis; Sunscale Scytheclaws guard them."] = "Os três ninhos ficam juntos em {area:1697}, a sudoeste do oásis; Garrafoices Helióscamo os guardam.",
	-- ["The thunder lizards across the river"] = "Os lagartos trovejantes do outro lado do rio",
	-- ["The {area:383}"] = "{area:383}",
	-- ["The {object:4141} stands at the Venture Co. research site west of the {area:382}. Close the three valves around the drill, use the console again, then take the {item:5089} from {npc:3471} beside it."] = "A {object:4141} fica no sítio de pesquisa da Empreendimentos S.A. a oeste de {area:382}. Feche as três válvulas em volta da perfuratriz, use o console de novo e pegue o {item:5089} de {npc:3471}, ao lado.",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam logo depois da ponte, abaixo de {area:379}.",
	-- ["Thunder Lizards and Lightning Hides graze just across the bridge below {area:379}.\nCareful: Halikor, a level 12 elite, roams {area:369} among the lizards: watch for him before you pull."] = "Lagartos Trovejantes e Pelegos de Relâmpago pastam logo depois da ponte, abaixo de {area:379}.\nCuidado: Halikor, um elite de nível 12, vagueia por {area:369} entre os lagartos: fique de olho nele antes de puxar.",
	-- ["Thunder lizards across the river"] = "Lagartos trovejantes do outro lado do rio",
	-- ["Walk back south to the {area:380}. The next guide starts here and takes you to {zone:1454} and the zeppelin to {zone:1420}."] = "Volte para o sul até a {area:380}. O próximo guia começa aqui e leva você a {zone:1454} e ao zepelim para {zone:1420}.",
	-- ["Walk back west along the road to the {area:380}."] = "Volte para oeste pela estrada até a {area:380}.",
	-- ["West to the {area:383}. The Witchwing harpies nest all over them; any of them can drop a talon. {quest:819} lies in their hills."] = "Para oeste até {area:383}. As harpias Asabruxa fazem ninho por toda parte; qualquer uma pode deixar cair uma garra. {quest:819} fica nas colinas delas.",
	-- ["While you are in the camp: {npc:3429}'s Water Seekers and Thornweavers in its western half, the Hunters in the middle, the supply crates at its eastern end."] = "Já que está no acampamento: os Rabdomantes e os Tecespinhos de {npc:3429} ficam na metade oeste, os Caçadores Crinavalha no meio e as caixas de suprimentos na ponta leste.",
	-- ["Zhevra"] = "Zevras",
	-- ["Zhevra Runners graze north and east of town."] = "Zevras Corredoras pastam ao norte e a leste da cidade.",
	-- ["{area:1898} cultists"] = "Sectários de {area:1898}",
	-- ["{area:380} is your base for this guide. Everyone you need stands within a few steps of the inn."] = "{area:380} é sua base neste guia. Todos de quem você precisa ficam a poucos passos da estalagem.",
	-- ["{item:15885}: use a half at the {area:2362}"] = "{item:15885}: use uma metade em {area:2362}",
	-- ["{npc:3338} by the inn first, then the innkeeper, Helbrim by the north gate, {npc:3429} and {npc:3449} on the tower platform, {npc:3432} by the inn, and {npc:3448} at the south gate on the way out."] = "{npc:3338} junto à estalagem primeiro, depois o estalajadeiro, Hermógenes junto ao portão norte, {npc:3429} e {npc:3449} na plataforma da torre, {npc:3432} junto à estalagem e {npc:3448} no portão sul, na saída.",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads."] = "{npc:3395} anda entre os Kolkar em {area:388}, a sudeste da Encruzilhada.",
	-- ["{npc:3395} walks among the Kolkar at the {area:388} south-east of the Crossroads. Oasis Snapjaws crawl in the water around it: their shells are for {npc:3448}."] = "{npc:3395} anda entre os Kolkar em {area:388}, a sudeste da Encruzilhada. Mordeliscas do Oásis rastejam na água em volta dele: as carapaças delas são para {npc:3448}.",
	-- ["{npc:3396} leads the Kolkar on the west shore of {area:387}, south of {npc:3389}. He walks that shore, from about 46,36 in the north to 46,42 in the south: if he isn't at the arrow, follow the shore until you meet him. Hand his head to {npc:3389} on your last Crossroads stop."] = "{npc:3396} lidera os Kolkar na margem oeste de {area:387}, ao sul de {npc:3389}. Ele anda por essa margem, de cerca de 46,36 no norte a 46,42 no sul: se ele não estiver na seta, siga a margem até encontrá-lo. Entregue a cabeça dele a {npc:3389} na sua última parada na Encruzilhada.",
	-- ["{npc:3442} in {area:392}: later, on the way"] = "{npc:3442} em {area:392}: depois, no caminho",
	-- ["{npc:3448}: the Oasis Snapjaws at the {area:388}, with {npc:3395}"] = "{npc:3448}: as Mordeliscas do Oásis em {area:388}, com {npc:3395}",
	-- ["{npc:3615}, the wind rider master"] = "{npc:3615}, o mestre dos mantícoras",
	-- ["{npc:5878} camps beside the road from the Crossroads to {area:392}. The {object:58369} sits in the south of the Razormane camp just north of him."] = "{npc:5878} acampa junto à estrada da Encruzilhada para {area:392}. O {object:58369} fica no sul do acampamento Crinavalha, logo ao norte dele.",
	-- ["{npc:5900} makes {item:6636} from the tar and pouch. Use it by the brazier next to him to reveal the {npc:5893}, kill it for the {item:6655}, then place the ember in the brazier."] = "{npc:5900} faz {item:6636} com o piche e o bornal. Use-o junto ao braseiro ao lado dele para revelar o {npc:5893}, mate-o pela {item:6655} e depois coloque a brasa no braseiro.",
	-- ["{npc:5900} waits on the riverbank south of {area:379}, across the bridge."] = "{npc:5900} espera na margem do rio ao sul de {area:379}, do outro lado da ponte.",
	-- ["{npc:5907} stands on the ridge north of the Razormane camp."] = "{npc:5907} fica na serra ao norte do acampamento Crinavalha.",
	-- ["{quest:3301}: the {area:228} in {zone:1421}, next guide"] = "{quest:3301}: {area:228} em {zone:1421}, no próximo guia",
	-- ["{quest:881}, a white lion, prowls the plains north of the Razormane camp."] = "{quest:881}, um leão branco, ronda as planícies ao norte do acampamento Crinavalha.",
}
