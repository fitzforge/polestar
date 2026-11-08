-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/03-stranglethorn-vale (forever/horde/30-40/03-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:2408} Shadowprey Village
	["{area:2408} flight master"] = "Mestre de voo da {area:2408}",

	-- Step 2: Thunder Bluff
	-- {area:2408} Shadowprey Village · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar
	["Fly from {area:2408} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to {zone:1454} from there."] = "Voe de {area:2408} para {area:1638} e treine com {npc:3033} em {area:1639}; de lá, siga voando até {zone:1454}.",

	-- Step 3: Back to Orgrimmar
	-- {area:1637} Orgrimmar
	["Back to {area:1637}"] = "De volta a {area:1637}",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 4: Keldran
	-- {npc:5640} Keldran · {object:172961} Valley of Spirits (no name in this language: may be words)
	["{npc:5640} stands in the {object:172961} on the west side of the city."] = "{npc:5640} fica em {object:172961}, no lado oeste da cidade.",

	-- Step 5: Orgrimmar trainers
	-- {zone:1454} Orgrimmar
	["{zone:1454} trainers"] = "Instrutores de {zone:1454}",
	["Train while you are in the city."] = "Treine enquanto estiver na cidade.",

	-- Step 6: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelim para {object:3202}",

	-- Step 7: Grom'gol
	["The zeppelin lands at the tower on the west side of the camp."] = "O zepelim pousa na torre do lado oeste do acampamento.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: para o Planalto Arathi, mais adiante na rota",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "Acampamento de Rosarães Guima",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Siga a estrada para o norte saindo de {object:3202}; o acampamento de caça de Rosarães Guima fica na colina a nordeste do rio. Daqui em diante, guarde toda página de {quest:338} que saquear: {npc:716} vai pedi-las depois.",

	-- Step 9: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100}: vá matando estes pelo caminho",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Tigres-do-espinhaço Jovens rondam a oeste do acampamento, Panteras Jovens ao sul e a leste.\nSiga para oeste, passando pelo acampamento. Raptores-do-espinhaço (33-34) caçam nas clareiras, e os trolls Sanguescalpo ocupam as ruínas da costa: qualquer Sanguescalpo pode deixar cair uma presa. {item:4614} cai muito raramente deles: se cair, leia.\nCuidado: os acampamentos troll têm muita patrulha, então outros trolls costumam entrar na briga.",

	-- Step 10: Booty Bay
	-- {area:35} Booty Bay · {npc:2858} Gringer
	["Follow the road south to {area:35} at the southern tip of the vale and enter through the tunnel in the cliffs. Stay on the road: the jungle beside it is well above your level. {npc:2858}, the Horde flight master, waits on the upper deck."] = "Siga a estrada para o sul até {area:35}, na ponta sul do vale, e entre pelo túnel nos penhascos. Fique na estrada: a selva ao lado está bem acima do seu nível. {npc:2858}, o mestre de voo da Horda, espera no deque superior.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, lá dentro",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, lá dentro",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, no andar de cima",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, no andar de cima",
	["Upstairs"] = "No andar de cima",

	-- Step 11: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe até {object:3202}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 12: Grom'gol
	-- {npc:2497} Nimboya · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:2497} waits in {object:3202}, near the zeppelin tower."] = "{npc:2497} espera em {object:3202}, perto da torre do zepelim.",

	-- Step 14: The camp by the river
	["The camp by the river"] = "O acampamento à beira do rio",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "O acampamento dos caçadores desaparecidos de {npc:773} é o acampamento de Rosarães Guima: ande entre as tendas e a investigação é concluída. Crocoliscos do Rio ficam ao longo do rio, abaixo do acampamento.",

	-- Step 16: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}: vá matando estes pelo caminho",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger · Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Stranglethorn Tigers (32) roam the hills around the camp and south of it, Panthers (32) the clearings west and south-west of it. The Venture Co. Geologists, who carry the Tumbled Crystals, work the camps by {area:37}, south-east of the camp."] = "Tigres-do-espinhaço (32) vagam pelas colinas em volta do acampamento e ao sul dele, Panteras (32) pelas clareiras a oeste e sudoeste. Os Geólogos da Empreendimentos S.A., que carregam os Cristais Rolados, trabalham nos acampamentos perto de {area:37}, a sudeste do acampamento.",

	-- Step 17: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "As Panteras Umbragorja vêm bem mais tarde, perto de {object:3202}",

	-- Step 18: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Tigres anciãos e Raptores Batecauda",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "Os Tigres-do-espinhaço Anciões (34-35) vagam pelas colinas a sudoeste do acampamento; os Raptores Batecauda (35-36) caçam mais ao sul, rumo a {object:3202}.\nCuidado: acampamentos de trolls ficam perto da área dos tigres, e os trolls podem entrar na briga se você puxar sem cuidado.",

	-- Step 19: Nesingwary's camp
	["Back north to the camp."] = "De volta ao norte, até o acampamento.",

	-- Step 20: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}: vá matando estes pelo caminho",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "A oeste do acampamento, Basiliscos da Serra dos Cristais (34-35) ficam nas pedras; qualquer Sanguescalpo da aldeia mais adiante pode deixar cair uma orelha.\n{npc:729}, um tigre de nível 37, ronda o alto do morro a sudoeste do acampamento.\nCuidado: o ninho de raptores tem filhotes que entram na briga quando você ataca os adultos.",

	-- Step 22: Level 35
	["Level 35"] = "Nível 35",
	-- {area:35} Booty Bay · {object:3202} Grom'gol (no name in this language: may be words) · {area:796} Scarlet Monastery
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{area:35}'s and {object:3202}'s next quests are 35-38. Below 35? The Lashtail Raptors (35) hunt the slopes south of the camp, on your way back to {object:3202}: kill them until level 35. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "As próximas missões de {area:35} e {object:3202} são de nível 35-38. Abaixo de 35? Os Raptores Batecauda (35) caçam nas encostas ao sul do acampamento, no seu caminho de volta a {object:3202}: mate-os até o nível 35. Ou, em grupo, faça a masmorra {area:796} (Biblioteca ou Arsenal).",
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["Lashtail Raptors"] = "Raptores Batecauda",
	-- {npc:686} Lashtail Raptor
	["grind on {npc:686}"] = "mate {npc:686} até subir",

	-- Step 23: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Voe até {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Head south down the coast to {object:3202} and fly to {area:35}."] = "Siga a costa para o sul até {object:3202} e voe para {area:35}.",

	-- Step 24: Fly to Grom'gol
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}, beside the flight master: the Shadowmaw and tigress parts come after the trolls"] = "{npc:2465}, ao lado do mestre de voo: as partes de Bocassombra e da tigresa vêm depois dos trolls",

	-- Step 25: Stranglethorn Vale: kill these as you meet them
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Os Raptores Batecauda (35-36) caçam na selva logo a nordeste de {object:3202}.",

	-- Step 26: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "A noroeste do Acampamento Grom'gol, {area:104} fica sob a água, perto do litoral. O {item:4094} está no fundo do mar, junto às ruínas submersas; cuidado com o fôlego e com os murlocs.",
	["Underwater"] = "Debaixo d'água",

	-- Step 27: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102}: vá matando estes pelo caminho",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Os Caçadores de Cabeças Sanguescalpo (36-37) da aldeia da costa carregam as cabeças encolhidas.\nOs trolls Sanguescalpo ocupam as ruínas costa acima, ao norte do recife, e a aldeia mais adiante; qualquer um pode deixar cair um {item:3915}. Continue saqueando as páginas de {quest:338}.",

	-- Step 29: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "A leste dos ogros, as Panteras Umbragorja (37-38) espreitam invisíveis até dar o bote; as Tigresas-do-espinhaço andam pela mesma área e de vez em quando deixam cair uma presa imaculada. Crocoliscos Arapuca tomam o rio logo a oeste da selva; guarde as peles para {npc:2495}.\nCuidado: as Panteras Umbragorja (nível 37-38) e as Panteras Umbragorja Anciãs (nível 42-43) ficam furtivas fora de combate, então só aparecem quando você chega perto.",

	-- Step 30: Green Hills pages
	["Green Hills pages"] = "Páginas de Grande Espinhaço: Veredas",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "As páginas de {item:2755} caem com cerca de 1% cada dos trolls Sanguescalpo e Rachacrânio; guarde toda página que saquear e procure o resto na casa de leilões. {npc:716} recebe os capítulos mais adiante neste guia.",

	-- Step 31: Shadowmaw panthers
	["Shadowmaw panthers"] = "Panteras Umbragorja",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "As Panteras Umbragorja (37-38) espreitam na selva a leste das colinas Mosh'Ogg e a nordeste, em direção ao lago; atacam da furtividade. Saqueie toda página de Grande Espinhaço: Veredas que encontrar pelo caminho.",

	-- Step 32: Venture Co. camp
	["Venture Co. camp"] = "Acampamento da Empreendimentos S.A.",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north to {area:37}, south-east of Nesingwary's camp: the Venture Co. Geologists (34-36) work the camps by the lake and carry the Tumbled Crystals."] = "Siga para o norte até {area:37}, a sudeste do acampamento do Rosarães: os Geólogos da Empreendimentos S.A. (34-36) trabalham nos acampamentos junto ao lago e carregam os Cristais Rolados.",

	-- Step 33: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Acampamento Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Os ogros Mosh'Ogg acampam nas colinas logo a leste de {object:3202}. Mate um Brutamontes e um Mandingueiro (36-37); puxe um de cada vez.",

	-- Step 34: Level 36
	["Level 36"] = "Nível 36",
	-- {area:796} Scarlet Monastery · {area:1316} Razorfen Downs
	-- plural, as words: Mosh'Ogg Brutes = {npc:1142} Mosh'Ogg Brute
	["Dustwallow's quests are 35-38. Below 36? Keep killing the Mosh'Ogg Brutes and Witch Doctors here until level 36; pull one at a time. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "As missões do Pântano Vadeoso são de nível 35-38. Abaixo de 36? Continue matando os Brutamontes e Mandingueiros Mosh'Ogg aqui até o nível 36; puxe um de cada vez. Ou, em grupo, faça a masmorra {area:796} (Arsenal) ou a masmorra {area:1316}.",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "mate {npc:1142} até subir",

	-- Step 35: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "De volta a {object:3202}.",
	-- {npc:2465} Far Seer Mok'thardin
	["{npc:2465}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2465}: para forever/horde/40-50/01-stranglethorn-vale",
	-- {npc:2497} Nimboya
	["{npc:2497}: for forever/horde/40-50/01-stranglethorn-vale"] = "{npc:2497}: para forever/horde/40-50/01-stranglethorn-vale",
	-- {zone:1454} Orgrimmar
	["The next guide takes the zeppelin to {zone:1454} from the tower on the west side of the camp."] = "O próximo guia pega o zepelim para {zone:1454} na torre do lado oeste do acampamento.",
}
