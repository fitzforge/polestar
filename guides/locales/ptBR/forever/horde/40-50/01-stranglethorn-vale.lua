-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe para {object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Mestre de voo de {area:340}",

	-- Step 2: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "{npc:2519}: a lenda está em Zul'Kanda, onde este guia vai atrás de {npc:1061}",

	-- Step 3: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Espreitadores da Selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Os Espreitadores da Selva (40-41) caçam no litoral ao sul de {object:3202}. Eles estão bem acima de você: puxe um de cada vez e descanse entre as lutas.",

	-- Step 5: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Voe até {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Mestre de voo de {object:3202}",

	-- Step 6: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Gringer, o mestre de voo, espera no convés superior de {area:35}. As pessoas que dão missões ficam nos passadiços ao redor do porto e na estalagem.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495}: as peles de Crocolisco Arapuca que você juntou antes; lá dentro",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley \"Lobo do Mar\", no último andar",
	["Inside"] = "Lá dentro",

	-- Step 7: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Saia da cidade pelo túnel; o bilhete fica na enseada dos piratas, logo ao norte de {area:35}.",

	-- Step 8: Booty Bay
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}, no último andar",

	-- Step 9: The Wild Shore
	-- {area:43} Wild Shore
	["The {area:43}"] = "{area:43}",
	-- {area:43} Wild Shore · {npc:2493} Dizzy One-Eye
	["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Ao sul de Angra do Butim, os Espadachins da Vela Sangrenta acampam em {area:43}; os mapas e as ordens ficam nas barracas deles. Qualquer pirata da Vela Sangrenta pode levar rapé e o olho do {npc:2493}, então continue matando até ter os dois.",

	-- Step 11: The Bloodsail ships
	["The Bloodsail ships"] = "Os navios da Vela Sangrenta",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["Optional, and tough at 41: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Opcional, e difícil no nível 41: o pergaminho, {quest:624}, fica nos conveses dos três navios ao largo de {area:43}, tripulados por piratas de nível 42-45 que vêm em pares. Pegue só se conseguir puxar a tripulação até a amurada um de cada vez, ou com um amigo; a cadeia dele segue por {zone:1435}, {zone:1445} e {zone:1425}.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "para uma parada posterior em {zone:1435}",

	-- Step 12: Witch Doctor Unbagwa
	-- {area:35} Booty Bay · {area:1737} Mistvale Valley
	["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Pegue a estrada para o norte saindo de {area:35}; Unbagwa fica numa colina em {area:1737}, a leste da estrada.",
	-- {area:1742} Spirit Den
	["Inside {area:1742}"] = "Dentro de {area:1742}",

	-- Step 13: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas do Vale da Névoa",
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Os gorilas vagam pelo vale em volta de Unbagwa. Os anciões deixam cair os miúdos; qualquer um deles pode deixar cair uma presa.",

	-- Step 14: Witch Doctor Unbagwa
	-- {npc:1514} Mokk the Savage
	["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Entregue as presas a Unbagwa e fique perto dele: ele chama três ondas de gorilas, depois {npc:1514}. Enfrente-os um de cada vez.",

	-- Step 16: Venture Co. mine
	["Venture Co. mine"] = "Mina da Empreendimentos S.A.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Mais ao norte, os goblins da Empreendimentos S.A. cavam na mina a leste da estrada; mineradores, encarregados, topógrafos e engenhoqueiros deixam cair os cristais.\nCuidado: Panteras Umbragorja furtivas e Tigresas-do-espinhaço andam em volta do acampamento.",

	-- Step 18: Nesingwary's camp
	["Nesingwary's camp"] = "Acampamento de Rosarães Guima",
	["Head north up the road; the hunters camp on the hill above the river."] = "Siga a estrada para o norte; os caçadores acampam no morro acima do rio.",

	-- Step 20: Zul'Kunda
	["Zul'Kunda"] = "Ruínas de Zul'Kanda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {quest:586} Speaking with Gan'zulah · {area:1517} Uldaman
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43. Or, with a group, run the {area:1517} dungeon instead."] = "A oeste da expedição, os chefes Sanguescalpo {npc:1061} e {npc:1062} ficam juntos nas ruínas de Zul'Kunda. Limpe os guardas primeiro, depois puxe-os. Continue com os Sanguescalpo aqui até o nível 41: {quest:586}, no caldeirão, a seguir, manda você aos Rachacrânio de nível 41-43. Ou, em grupo, faça a masmorra {area:1517}.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "de {object:52}, nas ruínas",
	-- {quest:586} Speaking with Gan'zulah
	["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "mate os Sanguescalpos daqui até subir: {quest:586}, no caldeirão logo adiante, manda você para os Rachacrânios de nível 41-43",

	-- Step 21: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "o {object:2076}, ao lado de {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: para {zone:1425}, por volta do nível 48",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}: os crânios troféu ficam nas ruínas dos Rachacrânio, mais adiante neste circuito",

	-- Step 22: Jungle stalkers
	["Jungle stalkers"] = "Espreitadores da selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Os raptores espreitadores caçam na selva ao sul de {object:3202}, rumo à costa oeste.",

	-- Step 23: The Cape of Stranglethorn: kill these as you meet them
	-- {area:1577} The Cape of Stranglethorn
	["{area:1577}: kill these as you meet them"] = "{area:1577}: vá matando estes pelo caminho",
	-- {object:759} Holy Spring
	["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Siga a costa para o sul. As nagas exploradoras andam pela água ao longo da costa e levam os feixes de junco; {object:759} borbulha nas colinas logo a leste delas.",

	-- Step 24: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Siga para o sul até {area:35}. Shaky Phillipe espera no cais.",
	-- {npc:6807} Innkeeper Skindle
	["{npc:6807}, upstairs"] = "{npc:6807}, no andar de cima",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, na estalagem: as garrafas dele dão na costa de {zone:1425}, por volta do nível 48",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "{npc:737}, no andar de cima: as presas vêm dos Rachacrânio, mais adiante neste circuito",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "MacKinley, no último andar: para Esmirno, em {zone:1446}",

	-- Step 25: Zanzil's camps
	["Zanzil's camps"] = "Acampamentos de Zanzil",
	["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "A nordeste do Vale da Névoa, os seguidores de Zanzil acampam na selva; todos eles podem levar o preparado.",

	-- Step 26: Pirate ghosts
	["Pirate ghosts"] = "Fantasmas piratas",
	-- {area:35} Booty Bay · {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow · {npc:2537} Chucky "Ten Thumbs"
	["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Os três piratas fantasmagóricos assombram a selva ao norte de {area:35}, perto dos acampamentos de Zanzil: {npc:2535} e {npc:2536} ficam juntos, {npc:2537} mais a leste.",

	-- Step 27: Zul'Mamwe
	["Zul'Mamwe"] = "Ruínas de Zul'Mamwe",
	-- {npc:1059} Ana'thek the Cruel
	["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Siga para o norte até as ruínas dos Rachacrânio, a leste da mina da Empreendimentos S.A.; puxe os caçadores de cabeças e os berserkers um de cada vez. {npc:1059} guarda as ruínas do sudoeste, e uma pilha de crânios-troféu fica no lado norte das ruínas. Qualquer Rachacrânio pode deixar cair uma presa ou um colar: os colares são a parte demorada, então continue matando no acampamento dos guerreiros ao norte das ruínas até completar.",
	["Skullsplitter warriors"] = "Guerreiros Rachacrânio",
	-- {npc:669} Skullsplitter Hunter
	["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} anda por aqui: procure dentro do círculo no mapa",
	["Below ground"] = "No subterrâneo",

	-- Step 28: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "{area:127}: vá matando estes pelo caminho",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Os próximos crânios-troféu ficam nas ruínas pequenas logo ao norte do acampamento dos guerreiros.\nOs últimos crânios ficam nas ruínas a uma curta caminhada a oeste, no caminho de volta a {object:3202}.",

	-- Step 29: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "Siga para oeste até {object:3202}.",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076}"] = "o {object:2076}",
	-- {object:2076} Bubbling Cauldron
	["the {object:2076} again: Yenniku's fate"] = "{object:2076} de novo: o destino de Yennikan",
	-- {npc:2519} Kin'weelay · {area:35} Booty Bay
	["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "{npc:2519}: os basiliscos pastam ao lado da estrada na volta de {area:35}",

	-- Step 31: Booty Bay
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, lá dentro",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, no andar de cima",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {area:976} Gadgetzan
	["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, no andar de cima: para {quest:2864} em {area:976}",

	-- Step 32: Ironjaw Basilisks
	-- plural, as words: Ironjaw Basilisks = {npc:1551} Ironjaw Basilisk
	["Ironjaw Basilisks"] = "Basiliscos Ferroqueixo",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words)
	["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "Siga a cavalo para o norte, saindo de {area:35}, pela estrada; os basiliscos tomam sol nas rochas a leste dela, no meio da selva, no caminho de volta a {object:3202}. Os estilhaços deles caem com frequência.",

	-- Step 33: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Ride on north to {object:3202}."] = "Siga a cavalo para o norte até {object:3202}.",

	-- Step 35: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Siga a estrada para o norte até o acampamento dos caçadores.",

	-- Step 37: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:730} é elite de nível 43: a maioria das classes encara sozinha no nível 45, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 38: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:728} é elite de nível 40: a maioria das classes encara sozinha no nível 42, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 42: Level 42.68
	["Level 42.68"] = "Nível 42.68",
	-- {quest:192} Panther Mastery · {quest:195} Raptor Mastery · {area:1517} Uldaman
	["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Se você pulou {quest:192} ou {quest:195}, mate monstros aqui até o nível 42.68 para seguir o plano da rota. Ou, em grupo, faça a masmorra {area:1517}.",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "mate {npc:667} até subir",

	-- Step 43: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:731} é elite de nível 43: a maioria das classes encara sozinha no nível 45, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.\nCuidado: tigres e panteras umbragorja furtivas andam perto dele. Limpe tudo antes de puxá-lo. Quando é puxado, {npc:731} chama ajuda de qualquer bicho num raio de 20 metros.",

	-- Step 45: Level 42.74
	["Level 42.74"] = "Nível 42.74",
	-- {quest:208} Big Game Hunter · {area:1517} Uldaman
	["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Se você pulou {quest:208}, mate monstros aqui até o nível 42.74 para seguir o plano da rota. Ou, em grupo, faça a masmorra {area:1517}.",

	-- Step 49: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "Rumo a {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Siga a estrada para leste a partir de {zone:1431}, por {zone:1430}, até o pântano. {npc:1776} espera em {area:657}, o acampamento dos draeneis logo fora da estrada, onde ela chega de {zone:1430}.",

	-- Step 50: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road. Bind here."] = "Siga para o leste até {area:75}, nos juncos ao sul da estrada. Fixe sua Pedra de Regresso aqui.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, lá dentro",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}, no andar de cima",
	-- {npc:6930} Innkeeper Karakul
	["{npc:6930}, upstairs"] = "{npc:6930}, no andar de cima",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, no último andar",

	-- Step 51: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Dentesserra",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Os crocoliscos chafurdam nas poças em volta do acampamento de {npc:5391} e ao sul rumo a {area:75}; cerca de um em quatro deixa cair uma anca.",

	-- Step 52: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru vaga pela clareira a sudoeste de {area:76}; a clava dele inicia uma missão.",

	-- Step 53: Draenethyst crystals
	["Draenethyst crystals"] = "Cristais de draenetista",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Cavalgue para nordeste até {area:76}. Os cristais ficam ao longo da subida até a jaula de {npc:5391}.",

	-- Step 54: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} está preso em {area:76}, no nordeste do pântano. Liberte-o e siga-o para fora, enfrentando as criaturas do pântano que o perseguem.",

	-- Step 55: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "O cofre dele espera no antigo acampamento dele, ao norte de {area:75}, no caminho de volta a oeste.",

	-- Step 56: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Cavalgue para oeste pela estrada até o acampamento dos draeneis em {area:657}, perto da entrada vinda de {zone:1430}. {quest:698} vai para {npc:5592} em {area:1978} na próxima visita ao pântano: guarde os flancos.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to {area:35}"] = "Barco para {area:35}",
	-- ["Fly to {area:392}"] = "Voe para {area:392}",
	-- ["From {area:2408} fly to {area:392}."] = "De {area:2408}, voe para {area:392}.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Mais ao norte, os goblins da Empreendimentos S.A. cavam na mina a leste da estrada; mineradores, encarregados, topógrafos e engenhoqueiros deixam cair os cristais.",
	-- ["Hearth to {area:35}"] = "Regresse para {area:35}",
	-- ["Hearth to {object:3202}"] = "Regresse para {object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "O cofre dele está no antigo acampamento, ao norte de {area:75}.",
	-- ["Into the {area:8}"] = "Rumo a {area:8}",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Continue cavalgando para o norte até {zone:1431}, depois para o leste pela estrada através de {zone:1430} até o pântano. {npc:1776} espera em {area:657}, o acampamento draenei perto da entrada vinda de {zone:1430}.",
	-- ["Naga shore and the {object:759}"] = "Costa das nagas e {object:759}",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Cavalgue de volta para o leste, passando por {area:75}, e siga a estrada para sudeste até o pequeno posto da Horda na costa.",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Cavalgue para o norte até as ruínas Rachacrânio, a leste da mina da Empreendimentos S.A.; puxe os caçadores de cabeças e os berserkers um de cada vez. {npc:1059} guarda as ruínas do sudoeste, e uma pilha de crânios-troféu fica no lado norte das ruínas. Todo Rachacrânio pode deixar cair uma presa ou um colar: os colares são a parte demorada, então continue matando no acampamento dos guerreiros ao norte das ruínas até ter todos.",
	-- ["Ride north up the road to the hunters' camp."] = "Cavalgue para o norte pela estrada até o acampamento dos caçadores.",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Cavalgue para o norte pela estrada; os caçadores acampam na colina acima do rio.",
	-- ["Ride north-west to {object:3202}."] = "Cavalgue para noroeste até {object:3202}.",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Cavalgue para o sul até {area:35}. Phillipe \"Sacode\" espera nas docas.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Cavalgue para o oeste pela estrada até o acampamento draenei em {area:657}, perto da entrada vinda de {zone:1430}.",
	-- ["Ride west to {object:3202}."] = "Cavalgue para o oeste até {object:3202}.",
	-- ["Sawtooth snappers"] = "Tartaliscas Dentesserra",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "O barco chega ao porto de {area:35}. Os recrutadores de missões ficam nos passadiços em volta do porto e na estalagem.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "O barco para {area:35} atraca no fim do píer de {area:392}.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Os últimos crânios ficam nas ruínas um pouco a oeste, no caminho de volta para {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "O próximo guia começa aqui e leva você até {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Os próximos crânios-troféu ficam nas pequenas ruínas logo ao norte do acampamento dos guerreiros.",
	-- ["The snappers line the strand south of the post."] = "As tartaliscas ocupam a praia ao sul do posto.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Os três navios ficam ao largo de {area:43}. As tripulações são 42-45, Tranquiláguas 45, Querena 46 e {npc:2546} 48: no nível 41, isso é luta para grupo ou para o fim do guia. Se for, nade até lá e puxe a tripulação até a amurada, um de cada vez. Um pergaminho, {quest:624}, fica no convés dos navios: pegue-o.",
	-- ["The {area:657}"] = "{area:657}",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "A oeste da expedição, os chefes Sanguescalpo {npc:1061} e {npc:1062} ficam juntos nas Ruínas de Zul'Kanda. Elimine os guardas primeiro, depois puxe os dois.",
	-- ["for Stoley in {zone:1446}"] = "para Esmirno, em {zone:1446}",
	-- ["for a later stop in the {area:8}"] = "para uma parada posterior em {area:8}",
	-- ["for later: the {zone:1425}, around level 48"] = "para depois: {zone:1425}, por volta do nível 48",
	-- ["the {object:2076}, beside {npc:2497}"] = "o {object:2076}, ao lado de {npc:2497}",
	-- ["{area:35} flight master"] = "Mestre de voo de {area:35}",
	-- ["{area:392} pier"] = "Píer de {area:392}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: para {quest:2864}, em {area:976}",
}
