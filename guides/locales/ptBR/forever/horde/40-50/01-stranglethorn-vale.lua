-- Portuguese (Brazil) (ptBR): the guide forever/horde/40-50/01-stranglethorn-vale (forever/horde/40-50/01-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to the Undercity
	-- {area:1497} Undercity
	["Fly to the {area:1497}"] = "Voe para a {area:1497}",
	-- {area:1497} Undercity · {area:340} Kargath · {object:3202} Grom'gol (no name in this language: may be words) · {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {area:16743} Rog'mar · {npc:258570} Da'grosh
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}.\nThe {zone:2548} route starts after Stranglethorn and the Swamp, at about 41. Heading south through {area:16685} now? Load the {zone:2548} guide and keep east to {area:16743}. {npc:258570}'s camps below the pass are 43-46, with elite Twilight Enforcers (45), Kilgar and Morg (46)."] = "",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Mestre de voo de {area:340}",

	-- Step 2: Undercity trainers
	-- {area:1497} Undercity
	["{area:1497} trainers"] = "Instrutores da {area:1497}",

	-- Step 3: Riding at 40
	["Riding at 40"] = "Montaria no nível 40",
	-- {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {object:3202} Grom'gol (no name in this language: may be words)
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount. Each race learns it from its own race's trainer: yours is {npc:4773} in {area:159}, a short ride north of the zeppelin towers, with {npc:4731}'s skeletal horses (20 gold each) beside her. Ride back to the towers for the {object:3202} zeppelin."] = "Montaria exige nível 40 e custa 100 de ouro; aprender lhe dá uma montaria. Cada raça aprende com o instrutor da própria raça: o seu é {npc:4773}, em {area:159}, a uma cavalgada curta ao norte das torres de zepelim, com os cavalos esqueléticos de {npc:4731} (20 de ouro cada) ao lado dela. Cavalgue de volta até as torres para pegar o zepelim de {object:3202}.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, instrutora de montaria",
	-- {npc:4731} Zachariah Post · {npc:4773} Velma Warnam · {area:159} Brill
	["Skeletal horses: {npc:4731}, beside {npc:4773} in {area:159}."] = "Cavalos esqueléticos: {npc:4731}, ao lado de {npc:4773}, em {area:159}.",

	-- Step 4: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelim para {object:3202}",

	-- Step 5: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe para {object:3202}",
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {area:16743} Rog'mar · {npc:258570} Da'grosh
	-- plural, as words: Twilight Enforcers = {npc:256800} Twilight Enforcer
	["The {zone:2548} route starts after Stranglethorn and the Swamp, at about 41. Heading south through {area:16685} now? Load the {zone:2548} guide and keep east to {area:16743}. {npc:258570}'s camps below the pass are 43-46, with elite Twilight Enforcers (45), Kilgar and Morg (46)."] = "",

	-- Step 6: Grom'gol Base Camp
	-- {npc:2519} Kin'weelay · {npc:1061} Gan'zulah
	["{npc:2519}: the legend lies in Zul'Kunda, where this guide goes for {npc:1061}"] = "{npc:2519}: a lenda está em Zul'Kanda, onde este guia vai atrás de {npc:1061}",

	-- Step 7: Jungle Stalkers
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["Jungle Stalkers"] = "Espreitadores da Selva",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:730} Tethis · {quest:195} Raptor Mastery
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights.\nCareful: {npc:730}, a level 43 elite raptor, roams among the stalkers: leave him for {quest:195}'s group step."] = "Os Espreitadores da Selva (40-41) caçam no litoral ao sul de {object:3202}. Eles estão bem acima de você: puxe um de cada vez e descanse entre as lutas.\nCuidado: {npc:730}, um raptor elite de nível 43, anda entre os espreitadores: deixe-o para a etapa em grupo de {quest:195}.",

	-- Step 9: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Voe até {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["{object:3202} flight master"] = "Mestre de voo de {object:3202}",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay
	["Gringer, the flight master, waits on {area:35}'s upper deck. The quest givers stand on the boardwalks around the harbour and in the inn."] = "Gringer, o mestre de voo, espera no convés superior de {area:35}. As pessoas que dão missões ficam nos passadiços ao redor do porto e na estalagem.",
	-- {npc:2495} Drizzlik
	["{npc:2495}: the Snapjaw skins gathered earlier; inside"] = "{npc:2495}: as peles de Crocolisco Arapuca que você juntou antes; lá dentro",
	-- {npc:2495} Drizzlik · {npc:2635} Elder Saltwater Crocolisk · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2495}: the {npc:2635} suns on the coast between Zul'Kunda and {object:3202}, later on this loop"] = "{npc:2495}: o {npc:2635} toma sol na costa entre Zul'Kanda e {object:3202}, mais adiante neste circuito",

	-- Step 11: Kebok
	-- {npc:737} Kebok
	["{npc:737}, upstairs, has his next errand now: the Skullsplitter tusks come from the trolls of Zul'Mamwe, later on this loop."] = "{npc:737}, no andar de cima, já tem o próximo serviço: as presas Rachacrânio vêm dos trolls de Zul'Mamwe, mais adiante neste circuito.",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, no andar de cima",

	-- Step 12: Booty Bay docks
	-- {area:35} Booty Bay
	["{area:35} docks"] = "",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks: Gazlowe's letter, if you carry it"] = "{npc:4631}, no cais: a carta de Gazlowe, se você estiver com ela",
	-- {npc:4631} Wharfmaster Lozgil · {quest:97332} Twice Misplaced Trust · {npc:259961} Wharfmaster Whizzbuzz · {area:16727} Powderfuse Port · {zone:2548} Riverglades
	["{npc:4631}: {quest:97332}, after Zimmix's rescue; the package goes to {npc:259961} at {area:16727}, in the {zone:2548} guide"] = "{npc:4631}: {quest:97332}, depois do resgate de Zimmix; o pacote vai para {npc:259961} em {area:16727}, no guia de {zone:2548}",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley \"Lobo do Mar\", no último andar",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, on the balcony beside MacKinley"] = "{npc:2496}, na sacada ao lado de MacKinley",
	["Inside"] = "Lá dentro",

	-- Step 13: Bloodsail Correspondence
	-- {area:35} Booty Bay
	["Leave town by the tunnel; the note lies in the pirates' cove just north of {area:35}."] = "Saia da cidade pelo túnel; o bilhete fica na enseada dos piratas, logo ao norte de {area:35}.",

	-- Step 15: Mistvale gorillas
	["Mistvale gorillas"] = "Gorilas do Vale da Névoa",
	-- plural, as words: Elder Mistvale Gorillas = {npc:1557} Elder Mistvale Gorilla
	["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang: keep ten for Unbagwa, whose Mokk (44) waits for your Stranglethorn stop at about 45.\nCareful: the Elder Mistvale Gorillas (40-41) stand close together in the valley: pull one at a time."] = "Os gorilas andam pelo vale em volta de Unbagwa. Os anciões deixam cair os miúdos; qualquer um deles pode deixar cair uma presa: guarde dez para Unbagwa, cujo Mokk (44) espera sua parada em Selva do Espinhaço por volta do 45.\nCuidado: os Gorilas Anciões do Vale da Névoa (40-41) ficam bem juntos no vale: puxe um de cada vez.",

	-- Step 17: Venture Co. mine
	["Venture Co. mine"] = "Mina da Empreendimentos S.A.",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals.\nCareful: Stealthed Shadowmaw Panthers and Stranglethorn Tigresses roam the area around the camp."] = "Mais ao norte, os goblins da Empreendimentos S.A. cavam na mina a leste da estrada; mineradores, encarregados, topógrafos e engenhoqueiros deixam cair os cristais.\nCuidado: Panteras Umbragorja furtivas e Tigresas-do-espinhaço andam em volta do acampamento.",

	-- Step 18: Shadowmaw Panthers
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["Shadowmaw Panthers"] = "",
	-- {quest:192} Panther Mastery
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["{quest:192} is still open: the Shadowmaw Panthers (37-38) stalk the jungle north of the mine, towards the Mosh'Ogg hills. They use Sneak, so they show only when you are close: pull them one at a time, and leave the Elder Shadowmaw Panthers (42-43) alone."] = "",

	-- Step 20: Lashtail Raptors
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "Raptores Batecauda",
	-- {quest:195} Raptor Mastery · {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{quest:195} is still open: the Lashtail Raptors (35-36) hunt the jungle between {object:3202} and Nesingwary's camp, on your way north."] = "",

	-- Step 21: Nesingwary's camp
	["Nesingwary's camp"] = "Acampamento de Rosarães Guima",
	["Head north up the road; the hunters camp on the hill above the river."] = "Siga a estrada para o norte; os caçadores acampam no morro acima do rio.",

	-- Step 22: Sin'Dall
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["{npc:729}, the tiger {npc:717} sent you after on your last visit, prowls the hilltop just south-west of the camp."] = "{npc:729}, o tigre atrás do qual {npc:717} mandou você na última visita, ronda o topo do morro logo a sudoeste do acampamento.",

	-- Step 25: Nesingwary's camp
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Você perdeu isto na visita anterior da rota a esta região: vem primeiro agora. É rápido e abre as missões seguintes.",

	-- Step 26: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot · {quest:338} The Green Hills of Stranglethorn
	["{npc:716} collects the pages of {quest:338}: the trolls of the vale drop them now and then. Take his quest; each chapter he takes once you have all its pages."] = "{npc:716} coleciona as páginas de {quest:338}: os trolls do vale as deixam cair de vez em quando. Pegue a missão dele; ele recebe cada capítulo assim que você tiver todas as páginas dele.",

	-- Step 27: Chapter I
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter I is in your bags"] = "{npc:716}: todas as páginas do capítulo I estão nas suas bolsas",

	-- Step 28: Chapter II
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter II is in your bags"] = "{npc:716}: todas as páginas do capítulo II estão nas suas bolsas",

	-- Step 29: Chapter III
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter III is in your bags"] = "{npc:716}: todas as páginas do capítulo III estão nas suas bolsas",

	-- Step 30: Chapter IV
	-- {npc:716} Barnil Stonepot
	["{npc:716}: every page of chapter IV is in your bags"] = "{npc:716}: todas as páginas do capítulo IV estão nas suas bolsas",

	-- Step 31: The Green Hills of Stranglethorn
	-- {npc:716} Barnil Stonepot
	["{npc:716}: the four chapters"] = "{npc:716}: os quatro capítulos",

	-- Step 32: Zul'Kunda
	["Zul'Kunda"] = "Ruínas de Zul'Kanda",
	-- {npc:1061} Gan'zulah · {npc:1062} Nezzliok the Dire · {object:3202} Grom'gol (no name in this language: may be words) · {npc:2635} Elder Saltwater Crocolisk · {npc:2495} Drizzlik
	["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "A oeste da expedição, os chefes Sanguescalpo {npc:1061} e {npc:1062} ficam juntos nas ruínas de Zul'Kunda. Limpe os guardas primeiro, depois puxe-os.\nNa costa entre Zul'Kunda e {object:3202}, um {npc:2635} (elite de nível 38) compartilha os pontos de surgimento dos crocoliscos comuns: mate-o se ele estiver lá e pegue a pele dele para {npc:2495}.",
	-- {object:52} Fall of Gurubashi
	["from the {object:52}, in the ruins"] = "de {object:52}, nas ruínas",

	-- Step 33: Grom'gol
	-- {object:2076} Bubbling Cauldron · {npc:2497} Nimboya
	["the {object:2076}, beside {npc:2497}"] = "o {object:2076}, ao lado de {npc:2497}",
	-- {npc:2497} Nimboya · {zone:1425} Hinterlands
	["{npc:2497}: for the {zone:1425}, around level 48"] = "{npc:2497}: para {zone:1425}, por volta do nível 48",
	-- {npc:2519} Kin'weelay
	["{npc:2519}: the trophy skulls stand in the Skullsplitter ruins, later on this loop"] = "{npc:2519}: os crânios troféu ficam nas ruínas dos Rachacrânio, mais adiante neste circuito",
	-- {npc:2519} Kin'weelay · {area:104} Vile Reef
	["{npc:2519}: the cavern entrance under the {area:104}, west of the camp"] = "{npc:2519}: a entrada da caverna sob {area:104}, a oeste do acampamento",

	-- Step 34: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {npc:4752} Kildar · {object:172958} Valley of Honor (no name in this language: may be words) · {npc:3362} Ogunaro Wolfrunner · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}: {npc:4752} teaches Orcs in the {object:172958}, by {npc:3362}'s kennel (wolves 20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria, e {zone:2548} depois de Selva do Espinhaço é uma longa caminhada sem ela. Pegue o zepelim na torre de {object:3202} para {zone:1454}: {npc:4752} ensina Orcs no {object:172958}, junto ao canil de {npc:3362} (lobos a 20 de ouro cada). Depois, o zepelim de volta a {object:3202}. Sem ouro? Pule esta etapa: o guia de {zone:1444} passa de novo por {zone:1454} por volta do 45.",
	-- {npc:4752} Kildar
	["{npc:4752}, riding trainer"] = "{npc:4752}, instrutor de montaria",

	-- Step 35: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1411} Durotar · {area:367} Sen'jin Village · {npc:7953} Xar'Ti · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and go south down the {zone:1411} road to {area:367}: {npc:7953} teaches Trolls there, with Zjolnir's raptors (20 gold each). Then back to the zeppelin for {object:3202}. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria, e {zone:2548} depois de Selva do Espinhaço é uma longa caminhada sem ela. Pegue o zepelim na torre de {object:3202} para {zone:1454} e siga para o sul pela estrada de {zone:1411} até {area:367}: {npc:7953} ensina Trolls lá, com os raptores de Zjolnir (20 de ouro cada). Depois, volte ao zepelim para {object:3202}. Sem ouro? Pule esta etapa: o guia de {zone:1444} passa de novo por {zone:1454} por volta do 45.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, instrutor de montaria",

	-- Step 36: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {area:222} Bloodhoof Village · {npc:3690} Kar Stormsinger · {npc:3685} Harb Clawhoof · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454}, fly to {zone:1456} and ride down to {area:222}: {npc:3690} teaches Tauren there, with {npc:3685}'s kodos (20 gold each). Then fly back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1456} again at about 45."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria, e {zone:2548} depois de Selva do Espinhaço é uma longa caminhada sem ela. Pegue o zepelim na torre de {object:3202} para {zone:1454}, voe para {zone:1456} e desça até {area:222}: {npc:3690} ensina Taurens lá, com os kodos de {npc:3685} (20 de ouro cada). Depois, voe de volta a {zone:1454} para o zepelim de {object:3202}. Sem ouro? Pule esta etapa: o guia de {zone:1444} passa de novo por {zone:1456} por volta do 45.",
	-- {npc:3690} Kar Stormsinger
	["{npc:3690}, riding trainer"] = "{npc:3690}, instrutor de montaria",

	-- Step 37: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1456} Thunder Bluff · {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar · {zone:1444} Feralas
	["Riding needs level 40 and costs 100 gold; learning it gives you a Galestrider, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to {zone:1454} and fly to {zone:1456}: the skyboat to {zone:2521} leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes, and {npc:265756} teaches Skyborne at the {area:17684} in {area:16638}. Then back to {zone:1454} for the {object:3202} zeppelin. Short of gold? Skip this step: the {zone:1444} guide passes {zone:1454} again at about 45."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá um Galopavento, e {zone:2548} depois de Selva do Espinhaço é uma longa caminhada sem ele. Pegue o zepelim na torre de {object:3202} para {zone:1454} e voe para {zone:1456}: o barco aéreo para {zone:2521} sai dos penhascos ao sul de {area:17045}, ao norte de {zone:1456}, mais ou menos a cada cinco minutos, e {npc:265756} ensina os Celestes em {area:17684}, em {area:16638}. Depois, volte a {zone:1454} para o zepelim de {object:3202}. Sem ouro? Pule esta etapa: o guia de {zone:1444} passa de novo por {zone:1454} por volta do 45.",
	-- {npc:265756} Genn Fairweather · {area:17684} Fairweather Stables · {area:16638} Valanaar
	["{npc:265756}, riding trainer, at the {area:17684} in {area:16638}"] = "{npc:265756}, Instrutor de montaria, em {area:17684}, em {area:16638}",

	-- Step 38: Riding at 40
	-- {zone:2548} Riverglades · {object:3202} Grom'gol (no name in this language: may be words) · {area:1497} Undercity · {npc:4773} Velma Warnam · {area:159} Brill · {npc:4731} Zachariah Post · {zone:1435} Swamp of Sorrows
	["Riding needs level 40 and costs 100 gold; learning it gives you a mount, and the {zone:2548} after Stranglethorn are a long walk without one. Take the zeppelin from {object:3202}'s tower to the {area:1497}'s towers: {npc:4773} teaches the Forsaken in {area:159}, a short ride north, with {npc:4731}'s skeletal horses (20 gold each). Then the zeppelin back to {object:3202}. Short of gold? Skip this step: the {zone:1435} guide passes the {area:1497} again at about 47."] = "Montaria exige nível 40 e custa 100 de ouro; aprender dá uma montaria, e {zone:2548} depois de Selva do Espinhaço é uma longa caminhada sem ela. Pegue o zepelim na torre de {object:3202} para as torres de {area:1497}: {npc:4773} ensina os Renegados em {area:159}, a uma curta cavalgada ao norte, com os cavalos esqueléticos de {npc:4731} (20 de ouro cada). Depois, o zepelim de volta a {object:3202}. Sem ouro? Pule esta etapa: o guia de {zone:1435} passa de novo por {area:1497} por volta do 47.",

	-- Step 39: Your mount at 40
	["Your mount at 40"] = "Sua montaria no nível 40",
	-- {zone:1454} Orgrimmar · {object:172960} Cleft of Shadow (no name in this language: may be words) · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Warlocks don't buy riding: your mount is the Felsteed, from your class quest. Zevrost in {zone:1454}'s {object:172960} starts it and {npc:6251} in {area:392} teaches it, both on the {zone:1444} guide's {zone:1454} stop at about 45."] = "Bruxos não compram montaria: a sua é o Corcel Vil, da missão de classe. Zevrost, no {object:172960} de {zone:1454}, a inicia, e {npc:6251}, em {area:392}, a ensina, ambos na parada em {zone:1454} do guia de {zone:1444}, por volta do nível 45.",
	-- {zone:1454} Orgrimmar · {npc:6251} Strahad Farsan · {area:392} Ratchet · {zone:1444} Feralas
	["Felsteed: Zevrost in {zone:1454}, then {npc:6251} in {area:392}, on the {zone:1444} guide's {zone:1454} stop."] = "Corcel Vil: Zevrost em {zone:1454}, depois {npc:6251} em {area:392}, na parada em {zone:1454} do guia de {zone:1444}.",

	-- Step 40: The Vile Reef
	-- {quest:95770} Locating the Lost City · {object:3202} Grom'gol (no name in this language: may be words) · {area:104} Vile Reef
	["{quest:95770}: west of {object:3202}, swim out over the {area:104} and dive to the cavern entrance in the reef; the quest completes as you find it. Leave the cavern for now: the jungle stalkers are south along the coast."] = "{quest:95770}: a oeste de {object:3202}, nade sobre {area:104} e mergulhe até a entrada da caverna no recife; a missão é concluída quando você a encontra. Deixe a caverna para depois: os espreitadores da selva estão ao sul, ao longo da costa.",
	-- {area:16550} Drowned City
	["the {area:16550}'s entrance, underwater"] = "a entrada de {area:16550}, debaixo d'água",

	-- Step 41: Jungle stalkers
	["Jungle stalkers"] = "Espreitadores da selva",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast.\nCareful: the Jungle Stalkers (40-41) are thick here: pull one at a time and rest between fights."] = "Os raptores espreitadores caçam na selva ao sul de {object:3202}, rumo à costa oeste.\nCuidado: há muitos Espreitadores da Selva (40-41) aqui: puxe um de cada vez e descanse entre as lutas.",
	["The naga explorers on the coast south of here (43-44) are for Bloads and Mok'thardin: keep both quests for your Stranglethorn stop at about 45."] = "Os exploradores nagas na costa ao sul daqui (43-44) são para Bloads e Mok'thardin: guarde as duas missões para sua parada em Selva do Espinhaço, por volta do nível 45.",

	-- Step 42: Booty Bay
	-- {area:35} Booty Bay
	["Head south to {area:35}. Shaky Phillipe waits on the docks."] = "Siga para o sul até {area:35}. Shaky Phillipe espera no cais.",
	-- {npc:2491} Whiskey Slim · {zone:1425} Hinterlands
	["{npc:2491}, in the inn: his bottles wash up on the {zone:1425} coast, around level 48"] = "{npc:2491}, na estalagem: as garrafas dele dão na costa de {zone:1425}, por volta do nível 48",
	-- {npc:2486} Fin Fizracket · {quest:348} Stranglethorn Fever · {zone:1444} Feralas · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2486}: {quest:348} (offered from 40), Unbagwa's part on the {zone:1444} guide's {object:3202} stop"] = "{npc:2486}: {quest:348} (disponível a partir do 40), a parte de Unbagwa fica na parada em {object:3202} do guia de {zone:1444}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs: the tusks come from the Skullsplitters, later on this loop"] = "{npc:737}, no andar de cima: as presas vêm dos Rachacrânio, mais adiante neste circuito",
	-- {zone:1446} Tanaris
	["MacKinley, on the top floor: for Stoley in {zone:1446}"] = "MacKinley, no último andar: para Esmirno, em {zone:1446}",
	["MacKinley: keep it, the ghost pirates (43-44) wait for your Stranglethorn stop at about 45"] = "MacKinley: guarde-a, os piratas fantasmas (43-44) esperam sua parada em Selva do Espinhaço, por volta do nível 45",
	-- {npc:2495} Drizzlik · {item:4105} Elder Crocolisk Skin
	["{npc:2495}, inside: the {item:4105}"] = "{npc:2495}, lá dentro: a {item:4105}",
	-- {npc:2493} Dizzy One-Eye · {area:43} Wild Shore
	["{npc:2493}: keep it for the {area:43} at about 45"] = "{npc:2493}: guarde-a para {area:43}, por volta do nível 45",
	-- {npc:2487} Fleet Master Seahorn · {area:43} Wild Shore
	["{npc:2487}: keep it for the {area:43} at about 45"] = "{npc:2487}: guarde-a para {area:43}, por volta do nível 45",
	-- {npc:2488} Deeg · {area:43} Wild Shore
	["{npc:2488}, on the top floor: keep it for the {area:43} at about 45"] = "{npc:2488}, no último andar: guarde-a para {area:43}, por volta do nível 45",

	-- Step 43: Dudd Fizzlescroll
	-- {quest:95384} Partial Mystical Notes · {npc:260873} Dudd Fizzlescroll · {area:35} Booty Bay
	["If you already have the {quest:95384}, give them to {npc:260873} here in {area:35}."] = "",

	-- Step 44: The Bloodsail ships
	["The Bloodsail ships"] = "Os navios da Vela Sangrenta",
	-- {quest:624} Cortello's Riddle · {area:43} Wild Shore · {zone:1435} Swamp of Sorrows · {zone:1445} Dustwallow Marsh · {zone:1425} Hinterlands
	["The scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs, with captains of 45-48: take it with a group. Its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "O pergaminho, {quest:624}, fica nos conveses dos três navios ao largo de {area:43}, tripulados por piratas de nível 42-45 que vêm em pares, com capitães de 45-48: vá em grupo. A cadeia dele segue por {zone:1435}, {zone:1445} e {zone:1425}.",
	-- {zone:1435} Swamp of Sorrows
	["for a later stop in the {zone:1435}"] = "para uma parada posterior em {zone:1435}",

	-- Step 45: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly back to {object:3202}: Zul'Mamwe's Skullsplitters are just east of it."] = "Voe de volta para {object:3202}: os Racha-crânios de Zul'Mamwe ficam logo a leste.",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 46: Zul'Mamwe
	["Zul'Mamwe"] = "Ruínas de Zul'Mamwe",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {npc:1059} Ana'thek the Cruel · {npc:1061} Gan'zulah
	["From {object:3202} head east to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. One pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all. Careful: {npc:1059} (45) walks the south-western ruins with two guards; Speaking with {npc:1061}'s last piece, his Broken Armor, waits for your Stranglethorn stop at about 45."] = "De {object:3202}, siga para leste até as ruínas dos Racha-crânios, a leste da mina da Empreendimentos S.A.; puxe os caçadores de cabeças e os berserkers um de cada vez. Uma pilha de crânios-troféu fica no lado norte das ruínas. Todo Racha-crânio pode deixar cair uma presa ou um colar: os colares são a parte lenta, então continue matando no acampamento dos guerreiros ao norte das ruínas até ter todos. Cuidado: {npc:1059} (45) anda pelas ruínas a sudoeste com dois guardas; a última parte de Falando com {npc:1061}, a Armadura Quebrada dele, espera sua parada em Selva do Espinhaço, por volta do nível 45.",
	["Skullsplitter warriors"] = "Guerreiros Rachacrânio",

	-- Step 47: Balia'mah Ruins: kill these as you meet them
	-- {area:127} Balia'mah Ruins
	["{area:127}: kill these as you meet them"] = "{area:127}: vá matando estes pelo caminho",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The next trophy skulls stand in the small ruins just north of the warriors' camp.\nThe last skulls are in the ruins a short walk west, on the way back to {object:3202}."] = "Os próximos crânios-troféu ficam nas ruínas pequenas logo ao norte do acampamento dos guerreiros.\nOs últimos crânios ficam nas ruínas a uma curta caminhada a oeste, no caminho de volta a {object:3202}.",

	-- Step 48: Grom'gol Base Camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Head west to {object:3202}."] = "Siga para oeste até {object:3202}.",
	-- {npc:2464} Commander Aggro'gosh · {npc:256418} Krom'rosh · {area:16743} Rog'mar · {zone:2548} Riverglades
	["{npc:2464}: for {npc:256418} in {area:16743}, the {zone:2548}' Horde fort, in the next guide"] = "{npc:2464}: para {npc:256418} em {area:16743}, o forte da Horda em {zone:2548}, no próximo guia",
	-- {quest:571} Mok'thardin's Enchantment · {quest:621} Zanzil's Secret · {npc:737} Kebok · {area:35} Booty Bay · {zone:2548} Riverglades
	["Keep {quest:571}, {quest:621} and {npc:737}'s tusks: the Skullsplitter chief, Zanzil's camps, the naga coast and {area:35} come on your Stranglethorn stop at about 45, after the {zone:2548}."] = "Guarde {quest:571}, {quest:621} e as presas de {npc:737}: o chefe Racha-crânio, os acampamentos de Zanzil, a costa dos nagas e {area:35} ficam para sua parada em Selva do Espinhaço, por volta do nível 45, depois de {zone:2548}.",

	-- Step 50: Nesingwary's Expedition
	["Head north up the road to the hunters' camp."] = "Siga a estrada para o norte até o acampamento dos caçadores.",

	-- Step 52: Raptor Mastery
	-- {npc:730} Tethis
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:730} é elite de nível 43: a maioria das classes encara sozinha no nível 45, mas talvez você precise de ajuda. Se estiver sozinho, pule.",

	-- Step 53: Panther Mastery
	-- {npc:728} Bhag'thera
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:728} é elite de nível 40: a maioria das classes encara sozinha no nível 42, mas talvez você precise de ajuda. Se estiver sozinho, pule.",

	-- Step 57: Big Game Hunter
	-- {npc:731} King Bangalash
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:731} é elite de nível 43: a maioria das classes encara sozinha no nível 45, mas talvez você precise de ajuda. Se estiver sozinho, pule.\nCuidado: tigres e panteras umbragorja furtivas andam perto dele. Limpe tudo antes de puxá-lo. Quando é puxado, {npc:731} chama ajuda de qualquer bicho num raio de 20 metros.",

	-- Step 62: Into the Swamp of Sorrows
	-- {zone:1435} Swamp of Sorrows
	["Into the {zone:1435}"] = "Rumo a {zone:1435}",
	-- {zone:1431} Duskwood · {zone:1430} Deadwind Pass · {npc:1776} Magtoor · {area:657} Harborage
	["Follow the road east from {zone:1431} through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp just off the road where it comes in from {zone:1430}."] = "Siga a estrada para leste a partir de {zone:1431}, por {zone:1430}, até o pântano. {npc:1776} espera em {area:657}, o acampamento dos draeneis logo fora da estrada, onde ela chega de {zone:1430}.",

	-- Step 63: Stonard
	-- {area:75} Stonard
	["Head east to {area:75}, in the reeds south of the road."] = "Siga para o leste até {area:75}, nos juncos ao sul da estrada.",
	-- {npc:5591} Dar
	["{npc:5591}, inside"] = "{npc:5591}, lá dentro",
	-- {npc:1442} Helgrum the Swift
	["{npc:1442}, upstairs"] = "{npc:1442}, no andar de cima",
	-- {npc:1443} Fel'zerul
	["{npc:1443}, on the top floor"] = "{npc:1443}, no último andar",

	-- Step 64: Sawtooth crocolisks
	["Sawtooth crocolisks"] = "Crocoliscos Dentesserra",
	-- {npc:5391} Galen Goodward · {area:75} Stonard
	["The crocolisks wallow in the pools around {npc:5391}'s camp and south towards {area:75}; about one in four drops a flank."] = "Os crocoliscos chafurdam nas poças em volta do acampamento de {npc:5391} e ao sul rumo a {area:75}; cerca de um em quatro deixa cair uma anca.",

	-- Step 65: Noboru the Cudgel
	-- {area:76} Fallow Sanctuary
	["Noboru wanders the clearing south-west of the {area:76}; his cudgel starts a quest."] = "Noboru vaga pela clareira a sudoeste de {area:76}; a clava dele inicia uma missão.",

	-- Step 66: Draenethyst crystals
	["Draenethyst crystals"] = "Cristais de draenetista",
	-- {area:76} Fallow Sanctuary · {npc:5391} Galen Goodward
	["Head north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Siga para nordeste até {area:76}. Os cristais ficam ao longo da subida até a jaula de {npc:5391}.",

	-- Step 67: Galen's Escape
	-- {npc:5391} Galen Goodward · {area:76} Fallow Sanctuary
	["{npc:5391} is held in the {area:76} in the swamp's north-east. Free him and follow him out, fighting off the swamp creatures that chase him."] = "{npc:5391} está preso em {area:76}, no nordeste do pântano. Liberte-o e siga-o para fora, enfrentando as criaturas do pântano que o perseguem.",

	-- Step 68: Galen's Strongbox
	-- {area:75} Stonard
	["His strongbox waits at his old camp north of {area:75}, on the way back west."] = "O cofre dele espera no antigo acampamento dele, ao norte de {area:75}, no caminho de volta a oeste.",

	-- Step 69: Harborage
	-- {area:657} Harborage · {zone:1430} Deadwind Pass · {quest:698} Lack of Surplus · {npc:5592} Tok'Kar · {area:1978} Misty Reed Post
	["Head west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Siga para oeste pela estrada até o acampamento dos draeneis em {area:657}, perto da entrada vinda de {zone:1430}. {quest:698} vai para {npc:5592} em {area:1978} na próxima visita ao pântano: guarde os flancos.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Below ground"] = "No subterrâneo",
	-- ["Boat to {area:35}"] = "Barco para {area:35}",
	-- ["Fly to {area:392}"] = "Voe para {area:392}",
	-- ["Follow the coast south. The naga explorers wade along the shore and carry the reed bundles; the {object:759} bubbles in the hills just east of them."] = "Siga a costa para o sul. As nagas exploradoras andam pela água ao longo da costa e levam os feixes de junco; {object:759} borbulha nas colinas logo a leste delas.",
	-- ["From {area:2408} fly to {area:392}."] = "De {area:2408}, voe para {area:392}.",
	-- ["Further north, the goblins of the Venture Co. dig at the mine east of the road; miners, foremen, surveyors and tinkerers all drop the crystals."] = "Mais ao norte, os goblins da Empreendimentos S.A. cavam na mina a leste da estrada; mineradores, encarregados, topógrafos e engenhoqueiros deixam cair os cristais.",
	-- ["Hand Unbagwa the fangs and stay by him: he calls three waves of gorillas, then {npc:1514}. Fight them one at a time."] = "Entregue as presas a Unbagwa e fique perto dele: ele chama três ondas de gorilas, depois {npc:1514}. Enfrente-os um de cada vez.",
	-- ["Head north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Siga para o norte até as ruínas dos Rachacrânio, a leste da mina da Empreendimentos S.A.; puxe os caçadores de cabeças e os berserkers um de cada vez. {npc:1059} guarda as ruínas do sudoeste, e uma pilha de crânios-troféu fica no lado norte das ruínas. Qualquer Rachacrânio pode deixar cair uma presa ou um colar: os colares são a parte demorada, então continue matando no acampamento dos guerreiros ao norte das ruínas até completar.",
	-- ["Hearth to {area:35}"] = "Regresse para {area:35}",
	-- ["Hearth to {object:3202}"] = "Regresse para {object:3202}",
	-- ["His strongbox waits at his old camp north of {area:75}."] = "O cofre dele está no antigo acampamento, ao norte de {area:75}.",
	-- ["If you skipped {quest:192} or {quest:195}, grind here to level 42.68 to stay on the route's plan."] = "Se você pulou {quest:192} ou {quest:195}, mate monstros aqui até o nível 42.68 para seguir o plano da rota.",
	-- ["If you skipped {quest:208}, grind here to level 42.74 to stay on the route's plan."] = "Se você pulou {quest:208}, mate monstros aqui até o nível 42.74 para seguir o plano da rota.",
	-- ["Inside {area:1742}"] = "Dentro de {area:1742}",
	-- ["Into the {area:8}"] = "Rumo a {area:8}",
	-- ["Ironjaw Basilisks"] = "Basiliscos Ferroqueixo",
	-- ["Keep riding north into {zone:1431}, then east along the road through {zone:1430} into the swamp. {npc:1776} waits at the {area:657}, the draenei camp near the way in from {zone:1430}."] = "Continue cavalgando para o norte até {zone:1431}, depois para o leste pela estrada através de {zone:1430} até o pântano. {npc:1776} espera em {area:657}, o acampamento draenei perto da entrada vinda de {zone:1430}.",
	-- ["Level 42.68"] = "Nível 42.68",
	-- ["Level 42.74"] = "Nível 42.74",
	-- ["Naga shore and the {object:759}"] = "Costa das nagas e {object:759}",
	-- ["North-east of Mistvale, Zanzil's followers camp in the jungle; every one of them can carry the mixture."] = "A nordeste do Vale da Névoa, os seguidores de Zanzil acampam na selva; todos eles podem levar o preparado.",
	-- ["Optional, and tough at 42: the scroll, {quest:624}, lies on the decks of the three ships off the {area:43}, crewed by pirates of 42-45 who come in pairs. Take it only if you can pull the crew to the rail one at a time, or with a friend; its chain runs on through the {zone:1435}, {zone:1445} and the {zone:1425}."] = "Opcional, e difícil no nível 42: o pergaminho, {quest:624}, fica nos conveses dos três navios ao largo de {area:43}, tripulados por piratas de nível 42-45 que vêm em pares. Pegue só se conseguir puxar a tripulação até a amurada um de cada vez, ou com um amigo; a cadeia dele segue por {zone:1435}, {zone:1445} e {zone:1425}.",
	-- ["Pirate ghosts"] = "Fantasmas piratas",
	-- ["Ride back east past {area:75} and follow the road south-east to the small Horde post on the shore."] = "Cavalgue de volta para o leste, passando por {area:75}, e siga a estrada para sudeste até o pequeno posto da Horda na costa.",
	-- ["Ride north out of {area:35} along the road; the basilisks bask on the rocks east of it in the middle of the jungle, on the way back to {object:3202}. Their shards drop often."] = "Siga a cavalo para o norte, saindo de {area:35}, pela estrada; os basiliscos tomam sol nas rochas a leste dela, no meio da selva, no caminho de volta a {object:3202}. Os estilhaços deles caem com frequência.",
	-- ["Ride north to the Skullsplitter ruins east of the Venture Co. mine; pull the headhunters and berserkers one at a time. {npc:1059} guards the south-western ruins, and one pile of trophy skulls stands on the ruins' north side. Every Skullsplitter can drop a tusk or a necklace: the necklaces are the slow part, so keep killing in the warriors' camp north of the ruins until you have them all."] = "Cavalgue para o norte até as ruínas Rachacrânio, a leste da mina da Empreendimentos S.A.; puxe os caçadores de cabeças e os berserkers um de cada vez. {npc:1059} guarda as ruínas do sudoeste, e uma pilha de crânios-troféu fica no lado norte das ruínas. Todo Rachacrânio pode deixar cair uma presa ou um colar: os colares são a parte demorada, então continue matando no acampamento dos guerreiros ao norte das ruínas até ter todos.",
	-- ["Ride north up the road to the hunters' camp."] = "Cavalgue para o norte pela estrada até o acampamento dos caçadores.",
	-- ["Ride north up the road; the hunters camp on the hill above the river."] = "Cavalgue para o norte pela estrada; os caçadores acampam na colina acima do rio.",
	-- ["Ride north-east to the {area:76}. The crystals stand along the way up to {npc:5391}'s cage."] = "Cavalgue para nordeste até {area:76}. Os cristais ficam ao longo da subida até a jaula de {npc:5391}.",
	-- ["Ride north-west to {object:3202}."] = "Cavalgue para noroeste até {object:3202}.",
	-- ["Ride on north to {object:3202}."] = "Siga a cavalo para o norte até {object:3202}.",
	-- ["Ride south to {area:35}. Shaky Phillipe waits on the docks."] = "Cavalgue para o sul até {area:35}. Phillipe \"Sacode\" espera nas docas.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}."] = "Cavalgue para o oeste pela estrada até o acampamento draenei em {area:657}, perto da entrada vinda de {zone:1430}.",
	-- ["Ride west along the road to the draenei camp at the {area:657}, near the way in from {zone:1430}. {quest:698} goes to {npc:5592} at {area:1978} on the next swamp visit: keep the flanks."] = "Cavalgue para oeste pela estrada até o acampamento dos draeneis em {area:657}, perto da entrada vinda de {zone:1430}. {quest:698} vai para {npc:5592} em {area:1978} na próxima visita ao pântano: guarde os flancos.",
	-- ["Ride west to {object:3202}."] = "Cavalgue para o oeste até {object:3202}.",
	-- ["Sawtooth snappers"] = "Tartaliscas Dentesserra",
	-- ["South of Booty Bay the Bloodsail swashbucklers camp on the {area:43}; the charts and the orders lie in their tents and in the rowboat beside the larger camp. Any Bloodsail can carry snuff and {npc:2493}'s eye, so keep killing until you have both."] = "Ao sul de Angra do Butim, os Espadachins da Vela Sangrenta acampam em {area:43}; os mapas e as ordens ficam nas barracas deles e no bote ao lado do acampamento maior. Qualquer pirata da Vela Sangrenta pode levar rapé e o olho do {npc:2493}, então continue matando até ter os dois.",
	-- ["Take the road north out of {area:35}; Unbagwa sits on a hill in {area:1737}, east of the road."] = "Pegue a estrada para o norte saindo de {area:35}; Unbagwa fica numa colina em {area:1737}, a leste da estrada.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Os Espreitadores da Selva (40-41) caçam no litoral ao sul de {object:3202}. Eles estão bem acima de você: puxe um de cada vez e descanse entre as lutas.",
	-- ["The boat lands in {area:35}'s harbour. The quest givers stand on the boardwalks around the harbour and in the inn."] = "O barco chega ao porto de {area:35}. Os recrutadores de missões ficam nos passadiços em volta do porto e na estalagem.",
	-- ["The boat to {area:35} docks at the end of {area:392}'s pier."] = "O barco para {area:35} atraca no fim do píer de {area:392}.",
	-- ["The gorillas roam the valley around Unbagwa. The elders drop the giblets; any of them can drop a fang."] = "Os gorilas vagam pelo vale em volta de Unbagwa. Os anciões deixam cair os miúdos; qualquer um deles pode deixar cair uma presa.",
	-- ["The last skulls are in the ruins a short ride west, on the way back to {object:3202}."] = "Os últimos crânios ficam nas ruínas um pouco a oeste, no caminho de volta para {object:3202}.",
	-- ["The next guide starts here and takes you to {zone:1446}."] = "O próximo guia começa aqui e leva você até {zone:1446}.",
	-- ["The next trophy skulls stand in the small ruins just north of the warriors' camp."] = "Os próximos crânios-troféu ficam nas pequenas ruínas logo ao norte do acampamento dos guerreiros.",
	-- ["The snappers line the strand south of the post."] = "As tartaliscas ocupam a praia ao sul do posto.",
	-- ["The stalker raptors hunt the jungle south of {object:3202}, out towards the west coast."] = "Os raptores espreitadores caçam na selva ao sul de {object:3202}, rumo à costa oeste.",
	-- ["The three ghostly pirates haunt the jungle north of {area:35}, near Zanzil's camps: {npc:2535} and {npc:2536} stand together, {npc:2537} further east."] = "Os três piratas fantasmagóricos assombram a selva ao norte de {area:35}, perto dos acampamentos de Zanzil: {npc:2535} e {npc:2536} ficam juntos, {npc:2537} mais a leste.",
	-- ["The three ships lie off the {area:43}. The crews are 42-45, Stillwater 45, Keelhaul 46 and {npc:2546} 48: at 41 this is a fight for a group, or for the end of the guide. If you go, swim out and pull the crew to the rail one at a time. A scroll, {quest:624}, lies on the ships' decks: take it."] = "Os três navios ficam ao largo de {area:43}. As tripulações são 42-45, Tranquiláguas 45, Querena 46 e {npc:2546} 48: no nível 41, isso é luta para grupo ou para o fim do guia. Se for, nade até lá e puxe a tripulação até a amurada, um de cada vez. Um pergaminho, {quest:624}, fica no convés dos navios: pegue-o.",
	-- ["The {area:43}"] = "{area:43}",
	-- ["The {area:657}"] = "{area:657}",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:728} is a level 40 elite: most classes solo it at level 42, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:728} é elite de nível 40: a maioria das classes encara sozinha no nível 42, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:730} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:730} é elite de nível 43: a maioria das classes encara sozinha no nível 45, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.",
	-- ["These are elite mobs: grouping up is encouraged, look for people to do it with. {npc:731} is a level 43 elite: most classes solo it at level 45, but you may need help. Skip it if you are alone: the route has you grind the XP back.\nCareful: Tigers and stealthed shadowmaw panthers roam close to him. Clear them before you pull him. When he is pulled, {npc:731} calls for help from creatures within 20 yd."] = "São monstros elite: vale a pena formar grupo, procure gente para ir junto. {npc:731} é elite de nível 43: a maioria das classes encara sozinha no nível 45, mas talvez você precise de ajuda. Se estiver sozinho, pule: a rota faz você recuperar a XP matando monstros.\nCuidado: tigres e panteras umbragorja furtivas andam perto dele. Limpe tudo antes de puxá-lo. Quando é puxado, {npc:731} chama ajuda de qualquer bicho num raio de 20 metros.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them."] = "A oeste da expedição, os chefes Sanguescalpo {npc:1061} e {npc:1062} ficam juntos nas Ruínas de Zul'Kanda. Elimine os guardas primeiro, depois puxe os dois.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43.\nOn the coast between Zul'Kunda and {object:3202} an {npc:2635} (level 38 elite) shares the spawns of the ordinary crocolisks: kill it if it is up and take its skin for {npc:2495}."] = "A oeste da expedição, os chefes Sanguescalpo {npc:1061} e {npc:1062} ficam juntos nas ruínas de Zul'Kanda. Limpe os guardas primeiro, depois puxe-os. Continue com os Sanguescalpo aqui até o nível 41: {quest:586}, no caldeirão logo adiante, manda você aos Rachacrânio de nível 41-43.\nNa costa entre Zul'Kanda e {object:3202}, um {npc:2635} (elite de nível 38) compartilha os pontos de surgimento dos crocoliscos comuns: mate-o se ele estiver lá e pegue a pele dele para {npc:2495}.",
	-- ["West of the expedition, the Bloodscalp chiefs {npc:1061} and {npc:1062} stand together in the ruins of Zul'Kunda. Clear their guards first, then pull them. Stay on the Bloodscalps here until level 41: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43. Or, with a group, run the {area:1517} dungeon instead."] = "A oeste da expedição, os chefes Sanguescalpo {npc:1061} e {npc:1062} ficam juntos nas ruínas de Zul'Kunda. Limpe os guardas primeiro, depois puxe-os. Continue com os Sanguescalpo aqui até o nível 41: {quest:586}, no caldeirão, a seguir, manda você aos Rachacrânio de nível 41-43. Ou, em grupo, faça a masmorra {area:1517}.",
	-- ["Your level 40 training is in the {area:1497}: fly there from {area:340}, train, and take the zeppelin from the towers outside the city to {object:3202}."] = "Seu treinamento do nível 40 é na {area:1497}: voe para lá a partir de {area:340}, treine e pegue o zepelim nas torres do lado de fora da cidade até {object:3202}.",
	-- ["Zanzil's camps"] = "Acampamentos de Zanzil",
	-- ["for Stoley in {zone:1446}"] = "para Esmirno, em {zone:1446}",
	-- ["for a later stop in the {area:8}"] = "para uma parada posterior em {area:8}",
	-- ["for later: the {zone:1425}, around level 48"] = "para depois: {zone:1425}, por volta do nível 48",
	-- ["grind on the Bloodscalps here: {quest:586}, at the cauldron next, sends you to Skullsplitters of 41-43"] = "mate os Sanguescalpos daqui até subir: {quest:586}, no caldeirão logo adiante, manda você para os Rachacrânios de nível 41-43",
	-- ["grind on {npc:667}"] = "mate {npc:667} até subir",
	-- ["the {object:2076}"] = "o {object:2076}",
	-- ["the {object:2076} again: Yenniku's fate"] = "{object:2076} de novo: o destino de Yennikan",
	-- ["the {object:2076}, beside {npc:2497}"] = "o {object:2076}, ao lado de {npc:2497}",
	-- ["{area:1577}: kill these as you meet them"] = "{area:1577}: vá matando estes pelo caminho",
	-- ["{area:35} flight master"] = "Mestre de voo de {area:35}",
	-- ["{area:392} pier"] = "Píer de {area:392}",
	-- ["{npc:2488}, on the top floor"] = "{npc:2488}, no último andar",
	-- ["{npc:2496}, on the balcony beside MacKinley, has one more errand: the fuel regulator blueprints from Cozzle's footlocker go to Pozzik at the {area:2240}, on the way to {zone:1446} around level 43."] = "{npc:2496}, na sacada ao lado de MacKinley, tem mais uma tarefa: as plantas do regulador de combustível do baú de Cozzle vão para Pozzik em {area:2240}, a caminho de {zone:1446} por volta do nível 43.",
	-- ["{npc:2498}, inside"] = "{npc:2498}, lá dentro",
	-- ["{npc:2519}: the basilisks graze beside the road back from {area:35}"] = "{npc:2519}: os basiliscos pastam ao lado da estrada na volta de {area:35}",
	-- ["{npc:669} walks around here: look inside the circle on the map"] = "{npc:669} anda por aqui: procure dentro do círculo no mapa",
	-- ["{npc:6807}, upstairs"] = "{npc:6807}, no andar de cima",
	-- ["{npc:6930}, upstairs"] = "{npc:6930}, no andar de cima",
	-- ["{npc:773}, upstairs: for {quest:2864} in {area:976}"] = "{npc:773}, no andar de cima: para {quest:2864} em {area:976}",
	-- ["{npc:773}: for {quest:2864} in {area:976}"] = "{npc:773}: para {quest:2864}, em {area:976}",
	-- ["{zone:1434} and the {zone:1435} at 40-43: {object:3202}, {area:35}'s pirates, Nesingwary's hunts and {area:75}."] = "{zone:1434} e {zone:1435} no nível 40-43: {object:3202}, os piratas de {area:35}, as caçadas de Nesingwary e {area:75}.",
}
