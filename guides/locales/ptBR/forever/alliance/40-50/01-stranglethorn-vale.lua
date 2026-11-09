-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/01-stranglethorn-vale (forever/alliance/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Theramore
	["Theramore"] = "Theramore",
	-- {quest:1260} Morgan Stern · {npc:4897} Helenia Olden
	["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} fica perto da estalagem; {npc:4897}, um fornecedor de comércio alguns passos ao sul, vende os temperos que Zé quer.",
	-- {quest:1260} Morgan Stern
	["{quest:1260}, inside"] = "{quest:1260}, lá dentro",
	-- {npc:4964} Commander Samaul · {area:514} Foothold Citadel
	["{npc:4964}, on the top floor of {area:514}"] = "{npc:4964}, no último andar de {area:514}",
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, para Zé \"Olho de Lama\"",

	-- Step 2: Sentry Point
	-- {area:503} Sentry Point
	-- plural, as words: Mudrock Burrowers = {npc:4398} Mudrock Burrower
	["Follow the road north-west out of Theramore to the watchtower at {area:503}. Mudrock Burrowers roam the marsh around it."] = "Siga a estrada para noroeste, saindo de Theramore, até a torre de vigia em {area:503}. Toqueiras Pedralama vagam pelo brejo ao redor.",

	-- Step 3: Archmage Tervosh
	-- {area:514} Foothold Citadel
	["Back in Theramore: Tervosh waits with Lady Jaina in the tower of {area:514}."] = "De volta a Theramore: Tervosh espera com a Grã-senhora Jaina na torre de {area:514}.",
	["Upstairs"] = "No andar de cima",

	-- Step 4: Theramore
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, lá dentro",
	-- {npc:4794} Morgan Stern · {zone:1435} Swamp of Sorrows
	["{npc:4794}: the crawlers are on the {zone:1435} shore, keep it"] = "{npc:4794}: os caranguejos ficam na costa de {zone:1435}, guarde-o",

	-- Step 5: Swamplight Manor
	-- {quest:1218} Soothing Spices · {npc:4897} Helenia Olden
	["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house. Jarl wants three {quest:1218}: if you passed {npc:4897}, buy them from her in Theramore first."] = "Siga a estrada para o norte até a mansão em ruínas; Zé mora no casebre ao lado dela e a terra solta fica no canto da casa. Zé quer três {quest:1218}: se você passou por {npc:4897}, compre-as dela em Theramore antes.",
	["with the spices from Theramore"] = "com os temperos de Theramore",

	-- Step 6: "Stinky" Ignatz
	["\"Stinky\" Ignatz"] = "Inácio \"Cascão\"",
	-- {area:504} North Point Tower
	["Stinky waits west of the manor, in the marsh below {area:504}. Lead him to his Bogbean leaves and keep the swamp creatures off him."] = "Cascão espera a oeste do casarão, no brejo abaixo de {area:504}. Leve-o até as folhas de trevo aquático e afaste as criaturas do pântano dele.",

	-- Step 7: North Point Tower
	-- {npc:4966} Private Hendel
	["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields.\nCareful: Hendel has two guards who join the fight when he turns hostile. The guards flee once he surrenders."] = "{npc:4966} ocupa a torre com alguns desertores. Ele se vira contra você: bata até ele se render.\nCuidado: o Remos tem dois guardas que entram na briga quando ele fica hostil. Os guardas fogem quando ele se rende.",

	-- Step 8: Darkmist Cavern
	-- plural, as words: Darkmist Lurkers = {npc:4377} Darkmist Lurker
	["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes.\nCareful: Darkmist Lurkers move about stealthed and use poison once in combat. The spiders stand close together, so adds are common; pulling single targets from the outer edge cuts down on them."] = "As aranhas Névoa Negra fazem ninho em volta da caverna no noroeste do pântano; toda aranha deixa cair olhos.\nCuidado: as Tocaieiras Névoa Negra andam furtivas e usam veneno no combate. As aranhas ficam bem juntas, então é comum vir monstro a mais; puxar um alvo de cada vez pela borda ajuda.",

	-- Step 9: Mudcrush Durtfeet
	["Ride south to the giant's hut in the middle of the marsh."] = "Siga para o sul até a cabana do gigante, no meio do pântano.",

	-- Step 10: The Shady Rest Inn
	-- {area:17} Barrens
	["The burned inn stands on the road west, toward the {area:17}; the guard's badge lies in the ashes."] = "A estalagem queimada fica na estrada a oeste, em direção a {area:17}; o distintivo do guarda está nas cinzas.",

	-- Step 11: Theramore
	-- {area:514} Foothold Citadel
	["Follow the road east back to Theramore. Tervosh, Lady Jaina and the officers are in the tower and {area:514}."] = "Siga a estrada para o leste de volta a Theramore. Tervosh, a Grã-senhora Jaina e os oficiais estão na torre e em {area:514}.",
	-- {npc:4967} Archmage Tervosh
	["{npc:4967}, upstairs"] = "{npc:4967}, no andar de cima",
	-- {npc:4968} Lady Jaina Proudmoore
	["{npc:4968}, on the top floor"] = "{npc:4968}, no último andar",
	["On the top floor"] = "No último andar",
	-- {npc:4948} Adjutant Tesoran
	["{npc:4948}, on the top floor"] = "{npc:4948}, no último andar",

	-- Step 12: Mirefin murlocs
	["Mirefin murlocs"] = "Murlocs Lamapina",
	-- {area:497} Swamplight Manor
	["The Mirefin murlocs crowd the north coast past {area:497}; finish the tongues on the tortoises beside them."] = "Os murlocs Lamapina lotam a costa norte depois de {area:497}; complete as línguas nos quelônios ao lado deles.",

	-- Step 13: Swamplight Manor
	-- {item:3853} Moonsteel Broadsword
	["only if you carry a {item:3853} (a blacksmith's craft)"] = "só se você tiver uma {item:3853} (criação de ferreiro)",

	-- Step 15: Balos Jacken
	-- {npc:4503} Mudcrush Durtfeet
	["The deserters camp south of the road, west of {npc:4503}'s hut."] = "Os desertores acampam ao sul da estrada, a oeste da cabana de {npc:4503}.",

	-- Step 17: The Affray
	-- {area:392} Ratchet · {area:720} Fray Island · {area:391} Merchant Coast · {npc:6236} Klannoc Macleod · {npc:6238} Big Will
	["On the ride north to {area:392}, {area:720} lies off the {area:391} south of the town: wade over the sand bar shallows. {npc:6236} sends four challengers and then {npc:6238} (level 33) at you, one at a time."] = "No caminho para o norte até {area:392}, {area:720} fica perto de {area:391}, ao sul da cidade: atravesse a pé o banco de areia. {npc:6236} manda quatro desafiantes e depois {npc:6238} (nível 33) contra você, um de cada vez.",
	-- {npc:6238} Big Will
	["Defeat the challengers and {npc:6238}"] = "Derrote os desafiantes e {npc:6238}",
	-- {npc:6236} Klannoc Macleod
	["{npc:6236} offers The Windwatcher next (1791): the Whirlwind weapon chain, with an elite at the end, is in the Warrior class guide Whirlwind Weapon."] = "Em seguida, {npc:6236} oferece O vigia dos ventos (1791): a série da arma de Redemoinho, com um elite no fim, está no guia de classe de Guerreiro Arma do redemoinho.",

	-- Step 18: Foothold Citadel
	-- {npc:4944} Captain Garran Vimes · {area:514} Foothold Citadel
	["The boat leaves from Theramore: report to {npc:4944} on the top floor of {area:514} on the way to the docks."] = "O barco sai de Theramore: apresente-se a {npc:4944} no último andar de {area:514}, no caminho até as docas.",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}, no último andar",

	-- Step 19: Boat to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Boat to {area:150}"] = "Navio para {area:150}",

	-- Step 20: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Mestre de voo de {area:150}",

	-- Step 22: Riding at 40
	["Riding at 40"] = "Montaria no nível 40",
	-- {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {npc:384} Katie Hunter
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {zone:1429}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "No nível 40, com 100 de ouro, você pode aprender a montar, e aprender lhe dá uma montaria. {npc:4732} ensina Humanos em {area:88}, no leste de {zone:1429}, ao lado dos cavalos de {npc:384}. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado). Colecionáveis, Montarias · Nível 40 lista todas as cores.",
	-- {npc:384} Katie Hunter
	["{npc:384}: other colours, 20g"] = "{npc:384}: outras cores, 20g",

	-- Step 23: Riding at 40
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {area:279} Dalaran
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. Skyborne learn it from {npc:265756}, the stablemaster and riding trainer at the {area:17684} in {area:16638} on Zephras Isle, who also sells the Galestriders: the skyboat to the isle leaves the north side of {area:279} about every five minutes. Collectibles, Mounts · Level 40 lists the Galestriders."] = "No nível 40, por 100 ouros, você aprende Equitação e já ganha uma montaria. Celonatos aprendem com {npc:265756}, o cavalariço e instrutor de equitação de {area:17684}, em {area:16638}, na Ilha de Zefras, que também vende os Vagaventos: o barco celeste para a ilha sai do lado norte de {area:279} mais ou menos a cada cinco minutos. Colecionáveis, Montarias · Nível 40 lista os Vagaventos.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["Riding and Galestriders: {npc:265756}, at the {area:17684} in {area:16638} on Zephras Isle."] = "Montaria e Vagaventos: {npc:265756}, em {area:17684}, {area:16638}, na Ilha de Zefras.",
	-- {area:279} Dalaran
	["Skyboat to Zephras Isle: the north side of {area:279}, about every five minutes."] = "Barco celeste para a Ilha de Zefras: lado norte de {area:279}, mais ou menos a cada cinco minutos.",

	-- Step 24: Boat to Booty Bay
	-- {area:35} Booty Bay
	["Boat to {area:35}"] = "Barco para {area:35}",

	-- Step 45: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Voe até {area:35}",
	-- {area:42} Darkshire
	["{area:42} flight master"] = "Mestre de voo de {area:42}",

	-- Step 46: Booty Bay
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, no andar de cima",
	-- {npc:770} Corporal Kaleb · {area:99} Rebel Camp
	["for {npc:770} at the {area:99}, on the northern loop"] = "para {npc:770}, em {area:99}, no circuito norte",
	-- {npc:2487} Fleet Master Seahorn
	["{npc:2487}, top floor"] = "{npc:2487}, último andar",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the Skullsplitter trolls, on the northern loop"] = "{npc:737}, no andar de cima: os trolls Rachacrânio, no circuito do norte",
	["Inside"] = "Lá dentro",
	["Seahorn's next errand goes back to Arathi: skip it."] = "A próxima tarefa de Chifre do Mar volta para Arathi: pule-a.",
	-- {npc:2542} Catelyn the Blade
	["{npc:2542}, upstairs"] = "{npc:2542}, no andar de cima",

	-- Step 47: Bloodsail camp
	["Bloodsail camp"] = "Acampamento da Vela Sangrenta",
	["Leave town by the tunnel and follow the coast north; the letter lies in the Bloodsail camp on the beach, where \"Pretty Boy\" Duncan walks."] = "Saia da cidade pelo túnel e siga a costa para o norte; a carta está no acampamento da Vela Sangrenta, na praia, onde anda Duncan \"Bonitão\".",

	-- Step 48: Booty Bay
	-- {npc:2488} Deeg
	["{npc:2488}, on the top floor"] = "{npc:2488}, no último andar",
	-- {npc:2624} Gazban
	["{npc:2624} swims off the north-west coast, on the northern loop"] = "{npc:2624} nada perto da costa noroeste, no circuito norte",

	-- Step 49: Wild Shore: kill these as you meet them
	-- {area:43} Wild Shore
	["{area:43}: kill these as you meet them"] = "{area:43}: vá matando estes pelo caminho",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore · {area:35} Booty Bay
	["Every Bloodsail drops Snuff and one of them carries {npc:2493}'s eye; the Swashbucklers walk the shore just north of town. The charts and orders lie in the pirate camp on the {area:43}, south of {area:35}."] = "Todo pirata da Vela Sangrenta deixa cair Rapé, e um deles leva o olho de {npc:2493}; os Espadachins andam pela praia logo ao norte da cidade. As cartas náuticas e as ordens estão no acampamento pirata em {area:43}, ao sul de {area:35}.",

	-- Step 50: Booty Bay
	-- {quest:604} The Bloodsail Buccaneers
	["Seahorn now offers {quest:604}: leave it. Its three captains are level 45-48 with crews around them, and the route brings you back to Seahorn at 48 for it."] = "Chifre do Mar agora oferece {quest:604}: deixe-a. Os três capitães dela são de nível 45-48, com tripulações ao redor, e a rota traz você de volta a Chifre do Mar no nível 48 para ela.",

	-- Step 51: Gorilla hills
	["Gorilla hills"] = "Colinas dos gorilas",
	-- {npc:1449} Witch Doctor Unbagwa
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["Ride inland to the Mistvale gorilla hills. Elder Mistvale Gorillas drop the giblets; {npc:1449} sits among them."] = "Siga para o interior até as colinas dos gorilas do Vale da Névoa. Gorilas Anciões do Vale da Névoa deixam cair os miúdos; {npc:1449} fica entre eles.",
	-- {npc:1449} Witch Doctor Unbagwa · {area:1742} Spirit Den
	["{npc:1449}, inside {area:1742}"] = "{npc:1449}, dentro de {area:1742}",

	-- Step 52: Unbagwa's ritual
	["Unbagwa's ritual"] = "O ritual de Unbagwa",
	-- {npc:1514} Mokk the Savage
	["Hand in the fangs and stay: three waves of gorillas come, {npc:1514} last. Fight at full health."] = "Entregue as presas e fique: vêm três ondas de gorilas, {npc:1514} por último. Lute com a vida cheia.",

	-- Step 53: Naga Explorers
	-- plural, as words: Naga Explorers = {npc:1907} Naga Explorer
	["Naga Explorers"] = "Exploradores Nagas",
	["The naga comb the beaches north of the Bloodsail camp; they drop the reeds."] = "Os nagas vasculham as praias ao norte do acampamento da Vela Sangrenta; eles deixam cair os juncos.",

	-- Step 54: Booty Bay
	["Ride back down to town; Shaky stands at the tunnel mouth."] = "Volte para a cidade; Sacode fica na entrada do túnel.",
	-- {npc:2616} Privateer Groy
	["for {npc:2616} in Theramore: keep it"] = "para {npc:2616}, em Theramore: guarde",
	-- {zone:1446} Tanaris
	["for Stoley in {zone:1446}: keep it; on the top floor"] = "para Esmirno em {zone:1446}: guarde; no último andar",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley \"Lobo do Mar\", no último andar",

	-- Step 55: The Bloodsail captains
	["The Bloodsail captains"] = "Os capitães da Vela Sangrenta",
	-- {area:43} Wild Shore · {npc:2546} Fleet Master Firallon
	["The captains stand on the ships anchored off the {area:43}, each with a crew of 42-45 pirates: Stillwater (45) and Keelhaul (46) on the nearer decks, {npc:2546} (48) on the flagship. At 42 this is a fight for a group or for the end of the guide; clear each deck first if you go. Cortello's scroll lies on the wreck by the shore."] = "Os capitães ficam nos navios ancorados perto de {area:43}, cada um com uma tripulação de piratas de nível 42-45: Tranquiláguas (45) e Querena (46) nos conveses mais próximos, {npc:2546} (48) na nau capitânia. No nível 42 é luta para grupo ou para o fim do guia; se for, limpe cada convés antes. O pergaminho de Cortello está no naufrágio junto à praia.",
	-- {zone:1435} Swamp of Sorrows
	["for the {zone:1435} later"] = "para {zone:1435}, mais tarde",

	-- Step 56: Zanzil's village
	["Zanzil's village"] = "Aldeia de Zanzil",
	-- {npc:2537} Chucky "Ten Thumbs"
	["Every Zanzil follower can drop the mixture; {npc:2537} walks the south of the camp."] = "Qualquer seguidor de Zanzil pode deixar cair o preparado; {npc:2537} anda pelo sul do acampamento.",

	-- Step 57: Maury "Club Foot" Wilkins and Jon-Jon the Crow
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["{npc:2535} and {npc:2536}"] = "{npc:2535} e {npc:2536}",
	-- {npc:2535} Maury "Club Foot" Wilkins · {npc:2536} Jon-Jon the Crow
	["Ride north to the hills west of the road. {npc:2535} and {npc:2536} stand together just north of Zanzil's village."] = "Siga para o norte até as colinas a oeste da estrada. {npc:2535} e {npc:2536} ficam juntos, logo ao norte da aldeia de Zanzil.",

	-- Step 58: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Espreitadores da Selva",
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers roam the slopes west of the mine."] = "Os Espreitadores da Selva vagam pelas encostas a oeste da mina.",

	-- Step 59: The north-west coast
	["The north-west coast"] = "A costa noroeste",
	-- {npc:2624} Gazban · {item:4034} Stone of the Tides
	-- plural, as words: Giant Clams = {object:2744} Giant Clam
	["Ride north-west from the mine to the bay on the north-west coast. The Giant Clams lie on its floor and hold the pearls; {npc:2624} swims among them and drops the {item:4034}."] = "Siga para noroeste a partir da mina até a baía na costa noroeste. Os Mariscos Gigantes ficam no fundo dela e guardam as pérolas; {npc:2624} nada entre eles e deixa cair {item:4034}.",
	-- {item:4611} Blue Pearl
	["{item:4611}; underwater"] = "{item:4611}; debaixo d'água",

	-- Step 62: Arbor Tarantula
	-- {npc:217588} Arbor Tarantula · {area:99} Rebel Camp · {npc:217412} Amaryllis Webb
	["An {npc:217588} crawls in the jungle south-east of Nesingwary's camp, on the way to the {area:99}: catch one with the tool from {npc:217412}'s Entomology Starter Kit."] = "{npc:217588} rasteja na selva a sudeste do acampamento de Rosarães, a caminho de {area:99}: pegue um exemplar com a ferramenta do kit de entomologia de {npc:217412}.",

	-- Step 63: Rebel Camp
	["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale."] = "Cavalgue para nordeste, passando pelo acampamento de Rosarães, e siga a estrada para o norte até o acampamento no alto do vale.",

	-- Step 65: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:728} é elite de nível 40: a maioria das classes encara sozinha no nível 42, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 66: Level 42.16 at Zul'Mamwe
	["Level 42.16 at Zul'Mamwe"] = "Nível 42.16 em Zul'Mamwe",
	-- {npc:737} Kebok · {area:1517} Uldaman
	["Alone, you skip Nesingwary's three elite hunts: take their experience from the Skullsplitter trolls of Zul'Mamwe instead, just east of the mine, so every kill also counts for {npc:737}'s tusks. Or, with a group, run the {area:1517} dungeon instead."] = "Sozinho, você pula as três caçadas de elite de Rosarães: tire a experiência dos trolls Rachacrânio de Zul'Mamwe, logo a leste da mina, de modo que cada morte também conte para as presas de {npc:737}. Ou, com um grupo, faça a masmorra {area:1517}.",
	-- {npc:667} Skullsplitter Warrior
	["grind on {npc:667}"] = "mate {npc:667} até subir",

	-- Step 67: Ruins of Zul'Mamwe: kill these as you meet them
	-- {area:103} Ruins of Zul'Mamwe
	["{area:103}: kill these as you meet them"] = "{area:103}: vá matando estes pelo caminho",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do.\nFollow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Os trolls Rachacrânio ocupam as ruínas logo a leste da mina; qualquer um pode deixar cair presas, e as panteras deles sempre deixam.\nSiga a estrada para nordeste até o acampamento da Empreendimentos S.A. em {area:310}; os mineradores, topógrafos e encarregados deixam cair os cristais.\nCuidado: Panteras Umbragorja furtivas e Tigresas-do-espinhaço andam em volta do acampamento.",

	-- Step 68: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:730} é elite de nível 43: a maioria das classes encara sozinha no nível 45, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",

	-- Step 72: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:731} é elite de nível 43: a maioria das classes encara sozinha no nível 45, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.\nCuidado: tigres e panteras umbragorja furtivas andam perto dele. Limpe tudo antes de puxá-lo. Quando é puxado, {npc:731} chama ajuda de qualquer bicho num raio de 20 metros.",

	-- Step 74: Level 42.16
	["Level 42.16"] = "Nível 42.16",
	-- {area:310} Crystalvein Mine · {area:35} Booty Bay · {area:1517} Uldaman
	-- plural, as words: Cold Eye Basilisks = {npc:690} Cold Eye Basilisk
	["Still short of level 42.16 after the hunts you did? Make up the rest on the Cold Eye Basilisks by the {area:310}, on your way south to {area:35}. Or, with a group, run the {area:1517} dungeon instead."] = "Ainda abaixo do nível 42.16 depois das caçadas que fez? Complete o resto nos Basiliscos Olho Frio perto de {area:310}, no caminho para o sul até {area:35}. Ou, com um grupo, faça a masmorra {area:1517}.",
	-- {npc:690} Cold Eye Basilisk
	["grind on {npc:690}"] = "mate {npc:690} até subir",

	-- Step 75: Booty Bay
	-- {area:35} Booty Bay
	["Ride south down the road to {area:35}."] = "Siga para o sul pela estrada até {area:35}.",
	-- {npc:2498} Crank Fizzlebub · {zone:1441} Thousand Needles
	["{npc:2498}'s next Zanzil errand starts in {zone:1441}: skip it."] = "A próxima tarefa de {npc:2498} sobre Zanzil começa em {zone:1441}: pule-a.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, no andar de cima",
	["MacKinley's next task sends you after elite ogres: skip it."] = "A próxima tarefa de MacKinley manda você atrás de ogros elite: pule-a.",
	-- {npc:773} Krazek · {quest:2864} Tran'rek · {zone:1446} Tanaris
	["{npc:773}: for {quest:2864} in {zone:1446}, keep it"] = "{npc:773}: para {quest:2864}, em {zone:1446}, guarde",

	-- Step 76: Fly to Stormwind
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 77: Stormwind
	-- {npc:1141} Angus Stern · {object:2169} Blue Recluse · {npc:5384} Brohann Caskbelly · {object:28027} Dwarven District
	["{npc:1141} cooks in the {object:2169}; {npc:5384} is in the {object:28027}."] = "{npc:1141} cozinha em {object:2169}; {npc:5384} fica em {object:28027}.",
	-- {npc:5694} High Sorcerer Andromath · {npc:5464} Watchmaster Sorigal · {area:42} Darkshire
	["{npc:5694}: for {npc:5464} in {area:42}, on the way to the swamp"] = "{npc:5694}: para {npc:5464} em {area:42}, no caminho para o pântano",

	-- Step 78: Stormwind
	-- {npc:1440} Milton Sheaf · {object:2117} Stormwind Keep
	["{npc:1440}, the Royal Library in {object:2117}"] = "{npc:1440}, na Biblioteca Real, em {object:2117}",

	-- Step 80: Paladin: The Tome of Nobility
	-- {quest:1661} The Tome of Nobility
	["Paladin: {quest:1661}"] = "Paladino: {quest:1661}",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}, in the Cathedral of Light"] = "{npc:6171}, na Catedral da Luz",

	-- Step 81: Stormwind City
	["Stormwind City"] = "Ventobravo",

	-- Step 82: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Bruxo: {quest:3631}",
	-- {npc:461} Demisette Cloyce · {object:2164} Slaughtered Lamb · {npc:6251} Strahad Farsan · {area:392} Ratchet
	["{npc:461}, in the {object:2164}: {npc:6251} in {area:392} takes it at the end of the next guide"] = "{npc:461}, em {object:2164}: {npc:6251}, em {area:392}, recebe no fim do próximo guia",

	-- Step 84: Fly to Rut'theran Village
	-- {area:702} Rut'theran Village
	["Fly to {area:702}"] = "Voe para {area:702}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Mestre de voo de {area:442}",

	-- Step 87: Riding at 40
	-- {npc:4753} Jartsam · {zone:1457} Darnassus · {npc:4730} Lelanai · {area:17203} Stormwind Harbor · {area:442} Auberdine · {area:702} Rut'theran Village · {npc:4732} Randal Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {zone:1429}. Collectibles, Mounts · Level 40 lists every colour."] = "No nível 40, com 100 de ouro, você pode aprender a montar, e aprender lhe dá uma montaria. {npc:4753} ensina Elfos Noturnos em {zone:1457}, ao lado dos sabres de {npc:4730}: o barco de {area:17203} para {area:442}, depois o voo até {area:702}. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado), como {npc:4732}, em {area:88}, {zone:1429}. Colecionáveis, Montarias · Nível 40 lista todas as cores.",
	-- {npc:4730} Lelanai
	["{npc:4730}: other colours, 20g"] = "{npc:4730}: outras cores, 20g",

	-- Step 89: Fly to Auberdine
	-- {area:442} Auberdine
	["Fly to {area:442}"] = "Voe para {area:442}",
	-- {area:702} Rut'theran Village
	["{area:702} flight master"] = "Mestre de voo de {area:702}",

	-- Step 90: Boat to Stormwind Harbor
	-- {area:17203} Stormwind Harbor
	["Boat to {area:17203}"] = "Barco para {area:17203}",

	-- Step 91: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Voar para {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",

	-- Step 92: Darkshire
	-- {npc:5464} Watchmaster Sorigal
	["{npc:5464}, by the flight master"] = "{npc:5464}, junto ao mestre de voo",

	-- Step 94: Misty Valley
	["The scroll lies in the marsh north of Biggs. The Swampwalkers north of it can drop Khadgar's essays."] = "O pergaminho fica no brejo ao norte de Biggs. Os Errantes do Pântano ao norte dele podem deixar cair os ensaios de Hadggar.",

	-- Step 96: Level 42.46
	["Level 42.46"] = "Nível 42.46",
	-- {quest:543} The Perenolde Tiara · {area:1517} Uldaman
	["If you skipped {quest:543}, grind here to level 42.46 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Se você pulou {quest:543}, mate monstros aqui até o nível 42.46 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:1517}.",
	-- {npc:766} Tangled Horror
	["grind on {npc:766}"] = "mate {npc:766} até subir",

	-- Step 97: Cortello's Riddle
	-- {npc:217412} Amaryllis Webb · {quest:93176} My Little Friends
	["{npc:217412}: {quest:93176}, from 30-40/05-arathi-highlands"] = "{npc:217412}: {quest:93176}, de 30-40/05-arathi-highlands",

	-- Step 98: Watcher Biggs
	-- {npc:5476} Watcher Biggs
	["{npc:5476} stands by the road junction in the west of the swamp."] = "{npc:5476} fica junto ao entroncamento no oeste do pântano.",

	-- Step 99: The sunken temple
	["The sunken temple"] = "O templo submerso",
	-- {area:74} Pool of Tears
	-- plural, as words: Tangled Horrors = {npc:766} Tangled Horror
	["Ride east; the Tangled Horrors along the way also drop the essays. Search the edge of the {area:74}, where the temple's ruins break the water."] = "Siga para o leste; os Horrores Emaranhados no caminho também deixam cair os ensaios. Procure na borda de {area:74}, onde as ruínas do templo saem da água.",

	-- Step 100: Misty Reed Strand
	["The driftwood washes up along the eastern shore."] = "A madeira flutuante chega à praia ao longo da margem leste.",
	-- {item:5938} Pristine Crawler Leg
	-- plural, as words: Silt Crawlers = {npc:922} Silt Crawler
	["{item:5938}, from the Silt Crawlers on the same shore"] = "{item:5938}, dos Guajás do Lodo na mesma praia",

	-- Step 101: Watcher Biggs
	-- {area:1438} Nethergarde Keep
	["for {area:1438}: keep it"] = "para {area:1438}: guarde",

	-- Step 104: Stormwind
	-- {npc:5635} Falstad Wildhammer · {area:348} Aerie Peak
	["for {npc:5635} at {area:348}: keep it"] = "para {npc:5635}, em {area:348}: guarde",

	-- Step 105: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Metrô para {zone:1455}",

	-- Step 108: Ironforge
	-- {npc:5637} Roetten Stonehammer · {object:32356} Hall of Explorers (no name in this language: may be words) · {npc:2786} Gerrig Bonegrip · {object:32383} Forlorn Cavern
	["{npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:2786} in the {object:32383}."] = "{npc:5637} fica no salão da Recuperação Ilimitada, junto ao {object:32356}, e {npc:2786}, na {object:32383}.",
	-- {zone:1453} Stormwind
	["{zone:1453} has no shaman trainer"] = "{zone:1453} não tem instrutor de xamã",

	-- Step 110: Riding at 40
	-- {npc:4772} Ultham Ironhorn · {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:1261} Veron Amberstill
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4772} teaches Dwarves at {area:803}, east of {area:131} on the road to {zone:1432}, beside {npc:1261}'s rams. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "No nível 40, com 100 de ouro, você pode aprender a montar, e aprender lhe dá uma montaria. {npc:4772} ensina Anões em {area:803}, a leste de {area:131}, na estrada para {zone:1432}, ao lado dos carneiros de {npc:1261}. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado). Colecionáveis, Montarias · Nível 40 lista todas as cores.",
	-- {npc:1261} Veron Amberstill
	["{npc:1261}: other colours, 20g"] = "{npc:1261}: outras cores, 20g",

	-- Step 112: Riding at 40
	-- {npc:7954} Binjy Featherwhistle · {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7955} Milli Featherwhistle
	["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:7954} teaches Gnomes at {area:189}, just east of {area:131}, beside {npc:7955}'s mechanostriders. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "No nível 40, com 100 de ouro, você pode aprender a montar, e aprender lhe dá uma montaria. {npc:7954} ensina Gnomos em {area:189}, logo a leste de {area:131}, ao lado dos mecanostriders de {npc:7955}. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado). Colecionáveis, Montarias · Nível 40 lista todas as cores.",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955}: other colours, 20g"] = "{npc:7955}: outras cores, 20g",

	-- Step 113: Fly to Thelsamar
	-- {area:144} Thelsamar
	["Fly to {area:144}"] = "Voe para {area:144}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",

	-- Step 114: Loch Modan
	-- {zone:1426} Dun Morogh · {zone:1432} Loch Modan · {area:144} Thelsamar
	["Ride east out of {zone:1426} through the tunnel into {zone:1432} and on along the road to {area:144}."] = "Cavalgue para leste, saindo de {zone:1426}, pelo túnel até {zone:1432} e siga a estrada até {area:144}.",

	-- Step 115: Thelsamar
	-- {npc:1470} Ghak Healtouch · {area:144} Thelsamar · {area:1517} Uldaman · {zone:1418} Badlands
	["{npc:1470} is below ground in {area:144}, by the inn. His mushrooms grow in the {area:1517} dig in the {zone:1418}; the next guide takes you there and back through {area:144}."] = "{npc:1470} fica no subterrâneo em {area:144}, junto à estalagem. Os cogumelos dele crescem na escavação de {area:1517}, em {zone:1418}; o próximo guia leva você até lá e de volta por {area:144}.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, no subterrâneo",

	-- Step 117: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Cavalgue para o sul, saindo de {zone:1432} pelo desfiladeiro até {zone:1418}; {npc:2860} acampa na escavação.",

	-- Step 118: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} acampa sozinho em {area:1898}, a sudeste da escavação.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. No Skyborne riding trainer is known; the Forever client files {spell:1285849} under the one Riding skill, so {npc:4732} at {area:88} in eastern {zone:1429}, the nearest trainer to {zone:1453}, should teach it (unconfirmed). The Galestriders are sold by {npc:265756} in {area:16638} on Zephras Isle; Collectibles, Mounts · Level 40 lists them."] = "No nível 40, com 100 de ouro, você pode aprender a montar, e aprender lhe dá uma montaria. Não se conhece instrutor de montaria celonato; o cliente Forever coloca {spell:1285849} sob a mesma perícia de Montaria, então {npc:4732}, em {area:88} no leste de {zone:1429}, o instrutor mais perto de {zone:1453}, deve ensiná-la (não confirmado). Os Vagaventos são vendidos por {npc:265756} em {area:16638}, na Ilha de Zefras; Colecionáveis, Montarias · Nível 40 lista todos.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4732} teaches Humans at {area:88} in eastern {area:12}, beside {npc:384}'s horses. Forever may let any race learn from any riding trainer (unconfirmed). Collectibles, Mounts · Level 40 lists every colour."] = "No nível 40, com 100 de ouro, você pode aprender a montar, e aprender lhe dá uma montaria. {npc:4732} ensina Humanos em {area:88}, no leste de {area:12}, ao lado dos cavalos de {npc:384}. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado). Colecionáveis, Montarias · Nível 40 lista todas as cores.",
	-- ["At 40 with 100 gold you can learn to ride, and learning it gives you a mount. {npc:4753} teaches Night Elves in {zone:1457}, beside {npc:4730}'s sabers: the boat from {area:17203} to {area:442}, then the flight to {area:702}. Forever may let any race learn from any riding trainer (unconfirmed), such as {npc:4732} at {area:88} in {area:12}. Collectibles, Mounts · Level 40 lists every colour."] = "No nível 40, com 100 de ouro, você pode aprender a montar, e aprender lhe dá uma montaria. {npc:4753} ensina Elfos Noturnos em {zone:1457}, ao lado dos sabres de {npc:4730}: o barco de {area:17203} para {area:442}, depois o voo até {area:702}. O Forever talvez deixe qualquer raça aprender com qualquer instrutor de montaria (não confirmado), como {npc:4732}, em {area:88}, {area:12}. Colecionáveis, Montarias · Nível 40 lista todas as cores.",
	-- ["Bloodsail pirates"] = "Piratas da Vela Sangrenta",
	-- ["Cold Eye Basilisks"] = "Basiliscos Olho Frio",
	-- ["Fly to {area:42} and ride east through {zone:1430} into the {zone:1435}; {npc:5476} stands by the road just past the border."] = "Voe para {area:42} e siga para o leste por {zone:1430} até {zone:1435}; {npc:5476} fica junto à estrada, logo depois da fronteira.",
	-- ["Follow the road north-east to the Venture Co. camp at the {area:310}; the miners, surveyors and foremen drop the crystals."] = "Siga a estrada para nordeste até o acampamento da Empreendimentos S.A. em {area:310}; os mineradores, topógrafos e encarregados deixam cair os cristais.",
	-- ["Galestriders: {npc:265756}, in {area:16638} on Zephras Isle."] = "Vagaventos: {npc:265756}, em {area:16638}, na Ilha de Zefras.",
	-- ["If you skipped {quest:193}, grind here to level 42.06 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Se você pulou {quest:193}, mate monstros aqui até o nível 42.06 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:1517}.",
	-- ["If you skipped {quest:196}, grind here to level 42.1 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Se você pulou {quest:196}, mate monstros aqui até o nível 42.1 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:1517}.",
	-- ["If you skipped {quest:208}, grind here to level 42.16 to stay on the route's plan. Or, with a group, run the {area:1517} dungeon instead."] = "Se você pulou {quest:208}, mate monstros aqui até o nível 42.16 para seguir o plano da rota. Ou, com um grupo, faça a masmorra {area:1517}.",
	-- ["Level 42.06"] = "Nível 42.06",
	-- ["Level 42.1"] = "Nível 42.1",
	-- ["Mudrock tortoises"] = "Quelônios Pedralama",
	-- ["Ride back west along the road; {npc:217412} stands a short way north of Biggs."] = "Volte para o oeste pela estrada; {npc:217412} fica um pouco ao norte de Biggs.",
	-- ["Ride from Theramore west along the Dustwallow road into the {zone:1413} and north to {area:392} on the coast. Learn the flight path from {npc:16227}, then take the boat to {area:35} from the dock."] = "Siga de Theramore para o oeste pela estrada do Pântano Vadeoso até {zone:1413} e depois para o norte até {area:392}, na costa. Aprenda a rota de voo com {npc:16227} e pegue o barco para {area:35} no cais.",
	-- ["Ride north-east past Nesingwary's camp and follow the road north to the camp at the top of the vale. On the way, an {npc:217588} crawls in the jungle south-east of Nesingwary's camp: catch one with the Entomology Starter Kit, then tick it off."] = "Siga para nordeste, passando o acampamento de Rosarães, e pegue a estrada para o norte até o acampamento no alto do vale. No caminho, uma {npc:217588} rasteja na selva a sudeste do acampamento de Rosarães: capture uma com o Entomology Starter Kit e marque-a.",
	-- ["Ride south out of {zone:1432} through the pass into the {area:3}; {npc:2860} camps at the dig."] = "Cavalgue para o sul, saindo de {zone:1432} pelo desfiladeiro até {area:3}; {npc:2860} acampa na escavação.",
	-- ["Skullsplitter ruins"] = "Ruínas Rachacrânio",
	-- ["Take the road north to the ruined manor; Jarl lives in the shack beside it and the loose dirt is at the corner of the house."] = "Pegue a estrada para o norte até o casarão em ruínas; Zé mora no barraco ao lado, e a terra solta fica no canto da casa.",
	-- ["Take the {area:2257} from the {object:28027}. {npc:5637} is in the Reclaimers' hall by the {object:32356}, {npc:1356} in the hall itself, {npc:2786} in the {object:32383}. The next guide flies on to {area:144}."] = "Pegue o {area:2257} no {object:28027}. {npc:5637} fica no salão da Recuperação Ilimitada, junto a {object:32356}; {npc:1356}, no próprio salão; {npc:2786}, em {object:32383}. O próximo guia voa até {area:144}.",
	-- ["The Cold Eye Basilisks lie on the rocks west of the mine."] = "Os Basiliscos Olho Frio ficam nas rochas a oeste da mina.",
	-- ["The Darkmist spiders nest around the cavern in the north-west of the marsh; every spider drops eyes."] = "As aranhas Névoa Negra fazem ninho ao redor da caverna no noroeste do pântano; toda aranha deixa cair olhos.",
	-- ["The Mudrock Tortoises and Spikeshells sun themselves on the shore north-east of the manor."] = "Os Quelônios Pedralama e as Espicascas tomam sol na praia a nordeste do casarão.",
	-- ["The Skullsplitter trolls hold the ruins just east of the mine; any of them can drop tusks, their panthers always do."] = "Os trolls Rachacrânio dominam as ruínas logo a leste da mina; qualquer um deles pode deixar cair presas, e suas panteras sempre deixam.",
	-- ["The burned inn stands on the road west, toward the {zone:1413}; the guard's badge lies in the ashes and the hoofprints are in the mud beside the inn."] = "A estalagem queimada fica na estrada para o oeste, rumo a {zone:1413}; a insígnia do guarda está nas cinzas, e as pegadas de casco, na lama ao lado da estalagem.",
	-- ["The riddle's next scroll lies in western Dustwallow: skip it."] = "O próximo pergaminho da charada fica no oeste do Pântano Vadeoso: pule-o.",
	-- ["for Stoley in {zone:1446}: keep it"] = "para Esmirno, em {zone:1446}: guarde",
	-- ["for the {area:8} later"] = "para {area:8}, mais tarde",
	-- ["{npc:1356}: for {npc:1344} in {zone:1432}, keep it"] = "{npc:1356}: para {npc:1344}, em {zone:1432}, guarde",
	-- ["{npc:217588}: catch it, for {quest:93176}"] = "{npc:217588}: capture-a, para {quest:93176}",
	-- ["{npc:4966} holds the tower with a few deserters. He turns on you: beat him until he yields."] = "{npc:4966} ocupa a torre com alguns desertores. Ele se volta contra você: bata nele até ele se render.",
	-- ["{npc:5694}: for {area:1438}, keep it"] = "{npc:5694}: para {area:1438}, guarde",
	-- ["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "{object:56910} é o prédio alto sobre o porto; a maioria dos recrutadores de missões fica nos andares dele ou nas docas abaixo.",
	-- ["{quest:1218}, for \"Swamp Eye\" Jarl"] = "{quest:1218}, para Zé \"Olho de Lama\"",
	-- ["{quest:1260} stands near the inn; {npc:4897}, a trade supplier a few steps south, sells the spices Jarl wants."] = "{quest:1260} fica perto da estalagem; {npc:4897}, um fornecedor de comércio alguns passos ao sul, vende os temperos que Zé quer.",
}
