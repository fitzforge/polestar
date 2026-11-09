-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/03-feralas (forever/horde/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 2: Apothecary Zinge
	-- {item:8523} Field Testing Kit · {area:976} Gadgetzan
	["the {item:8523} from these errands: keep it, Tanaris Field Sampling hands it back in {area:976}"] = "{item:8523} dessas tarefas: guarde-o, a missão Amostras de campo de Tanaris o devolve em {area:976}",

	-- Step 3: Undercity
	-- {npc:7825} Oran Snakewrithe · {object:36126} Royal Quarter (no name in this language: may be words)
	["{npc:7825}, the {object:36126}"] = "{npc:7825}, {object:36126}",

	-- Step 4: Riding at 40
	["Riding at 40"] = "Montaria no nível 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Equitação exige nível 40 e custa 100 ouros; aprendê-la dá a você uma montaria. Cada raça aprende com o instrutor da própria raça: o seu é {npc:4773} em {area:159}, a uma curta cavalgada ao norte das torres dos zepelins, com os cavalos esqueléticos de {npc:4731} (20 ouros cada) ao lado dela. Volte a cavalo até as torres para o zepelim de {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instrutora de montaria",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Cavalos esqueléticos: {npc:4731}, ao lado de {npc:4773} em {area:159}.",

	-- Step 5: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelim para {object:3202}",

	-- Step 6: Fly to Stonard
	-- {area:75} Stonard
	["Fly to {area:75}"] = "Voe para {area:75}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Mestre de voo de {object:3202}",

	-- Step 7: Stonard
	-- {npc:5591} Dar · {area:75} Stonard · {npc:1443} Fel'zerul
	["Coming from Stranglethorn, you carry these already. Starting here: {npc:5591} stands inside {area:75}'s great hall and {npc:1443} on its top floor."] = "Se você vem da Selva do Espinhaço, já tem estas. Começando aqui: {npc:5591} fica dentro do grande salão de {area:75} e {npc:1443}, no último andar.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, lá dentro",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, no último andar",

	-- Step 8: A Soggy Scroll
	["Ride west along the road; the scroll lies at the water's edge in the swamp's far west."] = "Siga a estrada para o oeste; o pergaminho fica à beira da água, no extremo oeste do pântano.",
	-- {object:2555} Musty Scroll · {zone:1445} Dustwallow Marsh
	["for the {object:2555} in {zone:1445}, later in this guide"] = "para {object:2555} em {zone:1445}, mais adiante neste guia",

	-- Step 9: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Dentesserra",
	-- {area:75} Stonard
	["The crocolisks wallow in the pools around Galen's old camp, just north of {area:75}, on the way back east; about one in four drops a flank."] = "Os crocoliscos chafurdam nas poças em volta do antigo acampamento de Galen, logo ao norte de {area:75}, na volta para o leste; cerca de um em quatro deixa cair um flanco.",

	-- Step 10: Pool of Tears
	-- {area:75} Stonard · {quest:1424} Pool of Tears
	["Back east past {area:75}: the Atal'ai artifacts lie in the water and on the banks of the {quest:1424}."] = "De volta ao leste, passando por {area:75}: os Artefatos Atal'ai ficam na água e nas margens de {quest:1424}.",

	-- Step 11: Misty Reed Post
	-- {npc:5592} Tok'Kar
	["Follow the road south-east to the small Horde post on the shore. {npc:5592} takes the crocolisk flanks from the last swamp visit."] = "Siga a estrada para o sudeste até o pequeno posto da Horda na margem. {npc:5592} pega os flancos de crocolisco da última visita ao pântano.",

	-- Step 12: The Forbidding Sea: kill these as you meet them
	-- {area:2403} The Forbidding Sea
	["{area:2403}: kill these as you meet them"] = "{area:2403}: vá matando estes pelo caminho",
	-- plural, as words: Monstrous Crawlers = {npc:1088} Monstrous Crawler
	["The snappers line the strand south of the post.\nThe Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see, the ones on the ride down from the pool too."] = "As tartaliscas tomam a praia ao sul do posto.\nOs Rastejantes Monstruosos andam pelas praias da costa leste, poucos e espalhados: mate todos que vir, inclusive os da descida desde o poço.",
	["Underwater"] = "Debaixo d'água",

	-- Step 14: Murlocs of the Misty Reed
	["Murlocs of the Misty Reed"] = "Murlocs de Brumalga",
	-- plural, as words: Marsh Murlocs = {npc:747} Marsh Murloc
	["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Os Murlocs do Pântano vivem na praia ao sul do posto; os Jogatintas ficam pela margem a leste dele e os Comecarnes mais a oeste, em volta das cabanas na margem oeste.",
	["Below ground"] = "No subterrâneo",

	-- Step 16: Continued Threat
	["The same murloc shore again: Inkspewers east of the post, Flesheaters around the western huts, and the Oracles among both."] = "A mesma costa de murlocs de novo: os Jogatintas a leste do posto, os Comecarnes em volta das cabanas do oeste, e os Oráculos entre os dois.",

	-- Step 18: Stonard
	-- {npc:5598} Atal'ai Exile · {zone:1425} Hinterlands
	["for the {npc:5598} in the {zone:1425}, around level 48"] = "para {npc:5598} em {zone:1425}, por volta do nível 48",

	-- Step 19: To Camp Mojache
	-- {area:1099} Camp Mojache
	["To {area:1099}"] = "Para {area:1099}",

	-- Step 20: Camp Mojache
	-- {zone:1425} Hinterlands
	["for the {zone:1425} owlbeasts, around level 48"] = "para os corujaursos de {zone:1425}, por volta do nível 48",

	-- Step 21: Fly to Brackenwall Village
	-- {area:496} Brackenwall Village
	["Fly to {area:496}"] = "Voe para {area:496}",
	-- {area:1099} Camp Mojache
	["{area:1099} flight master"] = "Mestre de voo de {area:1099}",

	-- Step 22: Brackenwall Village
	-- {npc:4500} Overlord Mok'Morokk · {npc:4502} Tharg · {npc:4501} Draz'Zilb · {area:511} Wyrmbog
	["{npc:4500}, {npc:4502} and {npc:4501} (below ground) are in the village; their quests are for the {area:511} on this trip."] = "{npc:4500}, {npc:4502} e {npc:4501} (no subterrâneo) ficam na vila; as missões deles são para {area:511}, nesta ida.",
	-- {npc:4501} Draz'Zilb
	["{npc:4501}, below ground"] = "{npc:4501}, no subterrâneo",

	-- Step 23: Dustwallow Marsh
	-- {object:2555} Musty Scroll
	["The {object:2555}"] = "O {object:2555}",

	-- Step 24: The Musty Scroll
	-- {object:2555} Musty Scroll
	["Ride south-west to the {object:2555}."] = "Cavalgue para o sudoeste até o {object:2555}.",
	-- {object:2555} Musty Scroll
	["the {object:2555}"] = "{object:2555}",
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "Dentro de {area:498}",

	-- Step 25: The Dragonmurk: kill these as you meet them
	-- {area:510} The Dragonmurk
	["{area:510}: kill these as you meet them"] = "{area:510}: vá matando estes pelo caminho",
	-- {area:511} Wyrmbog
	["East through the {area:511}: the Firemane scouts and ash tails roam its northern edge with the Searing hatchlings and whelps; the scalebanes guard the dragon caves further south-east. Mok'Morokk's snuff, grog and strongbox lie in the dragonkin camps."] = "Para o leste por {area:511}: os Batedores e Caudas Cinza Flamigrenha vagam pela borda norte com os Dragonetes Calcinantes e Carbonizantes; os Escamortes guardam as cavernas dos dragões mais a sudeste. O rapé, o grogue e o cofre de Mok'Morokk ficam nos acampamentos dos dracônicos.",
	-- {npc:4329} Firemane Scout · {area:510} The Dragonmurk
	["{npc:4329} walks around {area:510}: look inside the circle on the map"] = "{npc:4329} anda por {area:510}: procure dentro do círculo no mapa",

	-- Step 26: Brackenwall Village
	["Ride back north to Brackenwall."] = "Volte para o norte até Muralha Verde.",

	-- Step 27: Onyxia's eggs
	["Onyxia's eggs"] = "Ovos de Onyxia",
	-- {area:511} Wyrmbog
	["The Eggs of Onyxia lie in the dragon caves in the {area:511}'s south-east, guarded by the scalebanes; smash five."] = "Os Ovos de Onyxia ficam nas cavernas dos dragões no sudeste de {area:511}, guardados pelos Escamortes; esmague cinco.",
	["Dragon caves"] = "Cavernas dos dragões",

	-- Step 29: Challenge Overlord Mok'Morokk
	-- {quest:1173} Challenge Overlord Mok'Morokk · {npc:4500} Overlord Mok'Morokk · {npc:4501} Draz'Zilb
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:1173} needs a group of 3. Skip it if you are alone: the route has you grind the XP back.\n{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {quest:1173} pede um grupo de 3. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.\n{npc:4500} é elite: melhor ir em grupo. Bata nele até ele pedir arrego e depois fale com {npc:4501}.",

	-- Step 30: Level 45.41
	["Level 45.41"] = "Nível 45.41",
	-- {quest:1173} Challenge Overlord Mok'Morokk · {area:978} Zul'Farrak · {area:1517} Uldaman
	["If you skipped {quest:1173}, grind here to level 45.41 to stay on the route's plan. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "Se você pulou {quest:1173}, mate monstros aqui até o nível 45.41 para seguir o plano da rota. Ou, em grupo, faça a masmorra {area:978} ou a masmorra {area:1517}.",
	-- {npc:4329} Firemane Scout
	["grind on {npc:4329}"] = "mate {npc:4329} até subir",

	-- Step 31: Fly to Camp Mojache
	-- {area:1099} Camp Mojache
	["Fly to {area:1099}"] = "Voe para {area:1099}",
	-- {area:496} Brackenwall Village
	["{area:496} flight master"] = "Mestre de voo de {area:496}",

	-- Step 32: Sprite darters and forest walkers
	["Sprite darters and forest walkers"] = "Dardejantes e Andarilhos da Floresta",
	-- {item:9589} Encrusted Minerals
	-- plural, as words: Wandering Forest Walkers = {npc:7584} Wandering Forest Walker · Splintered Logs = {item:9590} Splintered Log
	["The sprite darters flit over the grove just west of the camp and carry the {item:9589}; the Wandering Forest Walkers, a little further west, carry the Splintered Logs."] = "Os Dardejantes voejam sobre o bosque logo a oeste do acampamento e carregam {item:9589}; os Andarilhos Errantes da Floresta, um pouco mais a oeste, carregam os Pedaços de Lenha.",

	-- Step 33: Frayfeather hippogryphs
	["Frayfeather hippogryphs"] = "Hipogrifos Esfiapluma",
	["South of the vale the Frayfeather hippogryphs roost on the slopes; nearly every one drops sinew and metallic fragments."] = "Ao sul do vale, os Hipogrifos Esfiapluma pousam nas encostas; quase todos deixam cair tendões e fragmentos metálicos.",

	-- Step 34: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast · {npc:14637} Zorbin Fandazzle
	["Ride north-west to the {area:1108}; {npc:14637} waits on the dock."] = "Siga para o noroeste até {area:1108}; {npc:14637} espera no cais.",

	-- Step 35: Rogue Vale screechers
	["Rogue Vale screechers"] = "Guinchadores Errantes do Vale",
	-- {npc:14637} Zorbin Fandazzle · {npc:5308} Rogue Vale Screecher · {item:10699} Yeh'kinya's Bramble
	["Rogue Vale opens just north of {npc:14637}'s dock. Kill a {npc:5308}, use {item:10699} on its body and kill the spirit that rises."] = "O Vale Errante abre logo ao norte do cais de {npc:14637}. Mate um {npc:5308}, use {item:10699} no corpo dele e mate o espírito que se levantar.",

	-- Step 36: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: vá matando estes pelo caminho",
	-- {item:18904} Zorbin's Ultra-Shrinker
	["Sea elementals and sea sprays wash along the shore around the dock. Zap the giants with {item:18904} first: shrunken, they lose their elite strength. Shore striders wade in the water; the land walkers and cliff giants roam the hills further north."] = "Elementais do Mar e Borrifos do Mar percorrem a margem em volta do cais. Primeiro atinja os gigantes com {item:18904}: encolhidos, eles perdem a força de elite. Costívagos andam na água; os Terrâmbulos e Gigantes do Penhasco vagam pelas colinas mais ao norte.",

	-- Step 37: Northspring harpies
	["Northspring harpies"] = "Harpias da Nascente Norte",
	["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "As Harpias da Nascente Norte fazem ninho nas serras do extremo noroeste. São 48-50, alguns níveis acima de você: os Arautos do Vento curam, então mate-os primeiro e puxe uma por vez.",

	-- Step 38: Rage Scar yetis
	["Rage Scar yetis"] = "Yetis Cortifúria",
	-- {quest:7738} Perfect Yeti Hide
	["On the way back south-east from the harpies, the Rage Scar yetis live around the caves in the hills by the road. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "No caminho de volta para o sudeste, saindo das harpias, os yetis Cicatriz da Fúria vivem em volta das cavernas nas colinas junto à estrada. Qualquer um deles também pode soltar um {quest:7738}, que inicia uma missão própria.",
	-- {quest:7738} Perfect Yeti Hide
	["{quest:7738}, a rare drop"] = "{quest:7738}, um saque raro",

	-- Step 39: Camp Mojache
	-- {npc:7854} Jangdor Swiftstrider
	["{npc:7854}, inside"] = "{npc:7854}, lá dentro",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Fly to {object:3202}"] = "Voe para {object:3202}",
	-- ["Forest walkers"] = "Andarilhos da Floresta",
	-- ["Monstrous Crawlers"] = "Rastejantes Monstruosos",
	-- ["Murlocs of the Misty Reed"] = "Murlocs de Brumalga",
	-- ["North-west along the road, the Rage Scar yetis live around the caves in the hills. Any of them can also drop a {quest:7738}, which starts a quest of its own."] = "A noroeste pela estrada, os Yetis Cortifúria vivem em volta das cavernas nas colinas. Qualquer um deles também pode deixar cair {quest:7738}, que inicia uma missão própria.",
	-- ["Northspring harpies"] = "Harpias da Nascente Norte",
	-- ["Ride back east to the camp. Stay here: the next guide starts with the flight to {area:976}."] = "Volte para o leste até o acampamento. Fique aqui: o próximo guia começa com o voo para {area:976}.",
	-- ["South-west, the yetis den in {area:1105}; every yeti there can drop a thick hide."] = "A sudoeste, os yetis vivem em {area:1105}; todo yeti ali pode deixar cair um couro grosso.",
	-- ["The Marsh Murlocs live on the strand south of the post; the Inkspewers are along the shore east of it and the Flesheaters further west, around the huts on the western shore."] = "Os Murlocs do Pântano vivem na praia ao sul do posto; os Jogatintas ficam pela margem a leste dele e os Comecarnes mais a oeste, em volta das cabanas na margem oeste.",
	-- ["The Monstrous Crawlers walk the beaches of the east coast, few and far between: kill every one you see on the way south."] = "Os Rastejantes Monstruosos andam pelas praias da costa leste, poucos e espalhados: mate cada um que vir no caminho para o sul.",
	-- ["The Northspring harpies nest on the ridges in the far north-west. They are 48-50, a few levels above you: the Windcallers heal, so kill them first and pull one at a time."] = "As Harpias da Nascente Norte fazem ninho nas serras do extremo noroeste. São 48-50, alguns níveis acima de você: os Arautos do Vento curam, então mate-os primeiro e puxe uma por vez.",
	-- ["The same murlocs again, plus the Oracles, who stay near the huts on the western shore."] = "Os mesmos murlocs de novo, mais os Oráculos, que ficam perto das cabanas na margem oeste.",
	-- ["The small Horde post on the southern shore."] = "O pequeno posto da Horda na margem sul.",
	-- ["The zeppelin to {zone:1454} leaves from the tower beside {object:3202}; it lands just north-east of {zone:1454}'s main gate."] = "O zepelim para {zone:1454} sai da torre ao lado de {object:3202}; ele pousa logo a nordeste do portão principal de {zone:1454}.",
	-- ["The {area:1108}"] = "{area:1108}",
	-- ["The {area:511}"] = "{area:511}",
	-- ["You start in {area:75}. Bind here: you hearth back after the coast."] = "Você começa em {area:75}. Vincule sua Pedra de Regresso aqui: você regressa depois da costa.",
	-- ["Your trainer is in {area:1638}: fly there (no flight path there yet? fly to {area:378} and ride west through {zone:1412}), then on to {area:496}."] = "Seu instrutor fica em {area:1638}: voe para lá (ainda sem rota de voo lá? voe para {area:378} e siga para o oeste por {zone:1412}), depois siga para {area:496}.",
	-- ["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",
	-- ["Zeppelin tower"] = "Torre do zepelim",
	-- ["for the {object:2555} in {area:15}, later in this guide"] = "para {object:2555} em {area:15}, mais adiante neste guia",
	-- ["{npc:4500} is elite: grouping up is advised. Beat him down until he gives up, then report to {npc:4501}."] = "{npc:4500} é elite: é recomendado formar um grupo. Bata nele até ele se render e depois fale com {npc:4501}.",
	-- ["{npc:7875}: for {npc:7010} in {zone:1454}, around level 50"] = "{npc:7875}: para {npc:7010} em {zone:1454}, por volta do nível 50",
	-- ["{object:172958}, then the {object:172960} and the {object:172961}."] = "{object:172958}, depois {object:172960} e {object:172961}.",
}
