-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/02-stranglethorn-vale (forever/horde/30-40/02-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Voe para {area:1497}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Mestre de voo de {area:272}",

	-- Step 2: Zeppelin to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Zeppelin to {object:3202}"] = "Zepelim para {object:3202}",

	-- Step 3: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe até {object:3202}",
	["The zeppelin lands at the tower on the west side of the camp."] = "O zepelim pousa na torre do lado oeste do acampamento.",
	-- {npc:2497} Nimboya
	["{npc:2497}: for Arathi, later on the route"] = "{npc:2497}: para o Planalto Arathi, mais adiante na rota",

	-- Step 4: Bloody Bone Necklace on the way
	-- {item:3915} Bloody Bone Necklace
	["{item:3915} on the way"] = "{item:3915} no caminho",

	-- Step 5: Islen Waterseer
	-- {area:1637} Orgrimmar · {object:3202} Grom'gol (no name in this language: may be words) · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Take the {area:1637} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short walk south of it."] = "Pegue o zepelim para {area:1637} na torre do lado oeste de Grom'gol e voe para {area:392}. {npc:5901} acampa na costa, a uma curta caminhada ao sul.",
	-- {npc:5901} Islen Waterseer · {npc:3527} Healing Stream Totem · {item:5177} Water Totem
	["{npc:5901}: {npc:3527} and your {item:5177}"] = "{npc:5901}: {npc:3527} e seu {item:5177}",

	-- Step 6: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 8: Nesingwary's camp
	["Nesingwary's camp"] = "Acampamento de Rosarães Guima",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {quest:338} The Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Follow the road north out of {object:3202}; Nesingwary's hunting camp sits on the hill north-east of the river. From here on, keep every page of {quest:338} you loot: {npc:716} asks for them later."] = "Siga a estrada para o norte saindo de {object:3202}; o acampamento de caça de Rosarães Guima fica na colina a nordeste do rio. Daqui em diante, guarde toda página de {quest:338} que saquear: {npc:716} vai pedi-las depois.",

	-- Step 9: Young Panther on the way
	-- {npc:683} Young Panther
	["{npc:683} on the way"] = "{npc:683} no caminho",

	-- Step 10: Nesingwary's Expedition: kill these as you meet them
	-- {area:100} Nesingwary's Expedition
	["{area:100}: kill these as you meet them"] = "{area:100}: vá matando estes pelo caminho",
	-- {item:4614} Pendant of Myzrael
	-- plural, as words: Young Stranglethorn Tigers = {npc:681} Young Stranglethorn Tiger · Young Panthers = {npc:683} Young Panther · Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it.\nHead west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it.\nCareful: The troll camps have many patrolling mobs, so other trolls often join a fight."] = "Tigres-do-espinhaço Jovens rondam a oeste do acampamento, Panteras Jovens ao sul e a leste.\nSiga para oeste, passando pelo acampamento. Raptores-do-espinhaço (33-34) caçam nas clareiras, e os trolls Sanguescalpo ocupam as ruínas da costa: qualquer Sanguescalpo pode deixar cair uma presa. {item:4614} cai muito raramente deles: se cair, leia.\nCuidado: os acampamentos troll têm muita patrulha, então outros trolls costumam entrar na briga.",

	-- Step 11: Booty Bay
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

	-- Step 12: Bloodscalp Ear on the way
	-- {item:1519} Bloodscalp Ear
	["{item:1519} on the way"] = "{item:1519} no caminho",

	-- Step 13: Tumbled Crystal on the way
	-- {item:4106} Tumbled Crystal
	["{item:4106} on the way"] = "{item:4106} no caminho",

	-- Step 14: Fly to Grom'gol
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 15: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Follow the road south to {object:3202}."] = "Siga a estrada para o sul até {object:3202}.",

	-- Step 17: The camp by the river
	["The camp by the river"] = "O acampamento à beira do rio",
	-- {npc:773} Krazek
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["{npc:773}'s missing hunters' camp is Nesingwary's: walk among its tents and the investigation completes. River Crocolisks lie along the river below the camp."] = "O acampamento dos caçadores desaparecidos de {npc:773} é o acampamento de Rosarães Guima: ande entre as tendas e a investigação é concluída. Crocoliscos do Rio ficam ao longo do rio, abaixo do acampamento.",

	-- Step 19: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}: vá matando estes pelo caminho",
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers and Panthers (32-33) roam the hills east of the camp, along the lake shore."] = "Tigres-do-espinhaço e Panteras (32-33) vagam pelas colinas a leste do acampamento, ao longo da margem do lago.",

	-- Step 20: Nesingwary's camp
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers come much later, by {object:3202}"] = "As Panteras Umbragorja vêm bem mais tarde, perto de {object:3202}",

	-- Step 21: Shadowmaw Panther on the way
	-- {npc:684} Shadowmaw Panther
	["{npc:684} on the way"] = "{npc:684} no caminho",

	-- Step 22: Elder tigers and Lashtail raptors
	["Elder tigers and Lashtail raptors"] = "Tigres anciãos e Raptores Batecauda",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Elder Stranglethorn Tigers = {npc:1085} Elder Stranglethorn Tiger · Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}.\nCareful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly."] = "Os Tigres-do-espinhaço Anciãos (34-35) andam pelas colinas a sudoeste do acampamento; os Raptores Batecauda (35-36) caçam mais ao sul, rumo a Grom'gol.\nCuidado: há acampamentos troll perto da área dos tigres, e os trolls podem entrar na briga se você puxar sem cuidado.",

	-- Step 23: Nesingwary's camp
	["Back north to the camp."] = "De volta ao norte, até o acampamento.",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}: vá matando estes pelo caminho",
	-- {npc:729} Sin'Dall
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear.\n{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "A oeste do acampamento, Basiliscos da Serra dos Cristais (34-35) ficam nas pedras; qualquer Sanguescalpo da aldeia mais adiante pode deixar cair uma orelha.\n{npc:729}, um tigre de nível 37, ronda o alto do morro a sudoeste do acampamento.\nCuidado: o ninho de raptores tem filhotes que entram na briga quando você ataca os adultos.",

	-- Step 26: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Pedra de Regresso para {area:35}",

	-- Step 27: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Voe até {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Head south down the coast to {object:3202} and fly to {area:35}."] = "Desça a costa para o sul até Grom'gol e voe para {area:35}.",

	-- Step 29: Lashtail Raptor on the way
	-- {npc:686} Lashtail Raptor
	["{npc:686} on the way"] = "{npc:686} no caminho",
	-- {npc:686} Lashtail Raptor · {object:3202} Grom'gol (no name in this language: may be words)
	["{npc:686} along the way to {object:3202}"] = "{npc:686} no caminho até Grom'gol",

	-- Step 30: Stranglethorn Vale: kill these as you meet them
	-- {object:3202} Grom'gol (no name in this language: may be words)
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["The Lashtail Raptors (35-36) hunt the jungle just north-east of {object:3202}."] = "Os Raptores Batecauda (35-36) caçam na selva logo a nordeste de {object:3202}.",

	-- Step 31: The Vile Reef
	-- {area:104} Vile Reef · {item:4094} Tablet Shard
	["North-west of Grom'gol the {area:104} lies under the water off the coast. The {item:4094} rests on the sea floor by the sunken ruins; watch your breath and the murlocs."] = "A noroeste do Acampamento Grom'gol, {area:104} fica sob a água, perto do litoral. O {item:4094} está no fundo do mar, junto às ruínas submersas; cuidado com o fôlego e com os murlocs.",
	["Underwater"] = "Debaixo d'água",

	-- Step 32: Ruins of Zul'Kunda: kill these as you meet them
	-- {area:102} Ruins of Zul'Kunda
	["{area:102}: kill these as you meet them"] = "{area:102}: vá matando estes pelo caminho",
	-- {item:3915} Bloody Bone Necklace · {quest:338} The Green Hills of Stranglethorn
	-- plural, as words: Bloodscalp Headhunters = {npc:671} Bloodscalp Headhunter
	["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads.\nThe Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Os Caçadores de Cabeças Sanguescalpo (36-37) da aldeia da costa carregam as cabeças encolhidas.\nOs trolls Sanguescalpo ocupam as ruínas costa acima, ao norte do recife, e a aldeia mais adiante; qualquer um pode deixar cair um {item:3915}. Continue saqueando as páginas de {quest:338}.",

	-- Step 33: Grom'gol
	-- {zone:1425} Hinterlands
	["for later: the {zone:1425}, around level 48"] = "para depois: {zone:1425}, lá pelo nível 48",

	-- Step 34: Mosh'Ogg Brute on the way
	-- {npc:1142} Mosh'Ogg Brute
	["{npc:1142} on the way"] = "{npc:1142} no caminho",

	-- Step 35: Mosh'Ogg Witch Doctor on the way
	-- {npc:1144} Mosh'Ogg Witch Doctor
	["{npc:1144} on the way"] = "{npc:1144} no caminho",

	-- Step 36: Stranglethorn Vale: kill these as you meet them
	-- {npc:2495} Drizzlik
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk · Elder Shadowmaw Panthers = {npc:1713} Elder Shadowmaw Panther
	["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}.\nCareful: Shadowmaw Panthers (level 37-38) and Elder Shadowmaw Panthers (level 42-43) use Sneak while out of combat, so they remain hidden until you get near them."] = "A leste dos ogros, as Panteras Umbragorja (37-38) espreitam invisíveis até dar o bote; as Tigresas-do-espinhaço andam pela mesma área e de vez em quando deixam cair uma presa imaculada. Crocoliscos Arapuca tomam o rio logo a oeste da selva; guarde as peles para {npc:2495}.\nCuidado: as Panteras Umbragorja (nível 37-38) e as Panteras Umbragorja Anciãs (nível 42-43) ficam furtivas fora de combate, então só aparecem quando você chega perto.",

	-- Step 37: Green Hills pages
	["Green Hills pages"] = "Páginas de Grande Espinhaço: Veredas",
	-- {item:2755} Green Hills of Stranglethorn · {npc:716} Barnil Stonepot
	["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; keep every page you loot and look on the auction house for the rest. {npc:716} takes the chapters later in this guide."] = "As páginas de {item:2755} caem com cerca de 1% cada dos trolls Sanguescalpo e Rachacrânio; guarde toda página que saquear e procure o resto na Casa de Leilões. {npc:716} recebe os capítulos mais adiante neste guia.",

	-- Step 38: Shadowmaw panthers
	["Shadowmaw panthers"] = "Panteras Umbragorja",
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther
	["The Shadowmaw Panthers (37-38) stalk the jungle east of the Mosh'Ogg hills and north-east towards the lake; they strike from stealth. Loot every Green Hills page you find on the way."] = "As Panteras Umbragorja (37-38) espreitam na selva a leste das colinas Mosh'Ogg e a nordeste, em direção ao lago; atacam da furtividade. Saqueie toda página de Grande Espinhaço: Veredas que encontrar pelo caminho.",
	-- {npc:684} Shadowmaw Panther
	["grind on {npc:684}"] = "mate {npc:684} até subir",

	-- Step 39: Venture Co. camp
	["Venture Co. camp"] = "Acampamento da Empreendimentos S.A.",
	-- plural, as words: Venture Co. Geologists = {npc:1096} Venture Co. Geologist · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Head north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "Siga para o norte, passando pelo acampamento do Rosarães Guima, até o lago. Os Geólogos da Empreendimentos S.A. (34-36) trabalham nos acampamentos da margem oeste; são eles que carregam os Cristais Rolados.",

	-- Step 40: Mosh'Ogg camp
	["Mosh'Ogg camp"] = "Acampamento Mosh'Ogg",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Os ogros Mosh'Ogg acampam nas colinas logo a leste de Grom'gol. Mate um Brutamontes e um Mandingueiro (36-37); puxe um de cada vez.",

	-- Step 41: Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Back to {object:3202}."] = "De volta a {object:3202}.",

	-- Step 42: Level 36
	["Level 36"] = "Nível 36",
	-- {area:321} Hammerfall
	["Top up here to level 36 before the hand-ins at {area:321}: they take you to level 37."] = "Complete aqui até o nível 36 antes das entregas em {area:321}: elas levam você ao nível 37.",
	-- {npc:1142} Mosh'Ogg Brute
	["grind on {npc:1142}"] = "mate {npc:1142} até subir",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {object:3202}"] = "De volta a {object:3202}",
	-- ["Basilisks and the Bloodscalp village"] = "Basiliscos e a aldeia Sanguescalpo",
	-- ["Bloodscalp headhunters"] = "Caçadores de Cabeças Sanguescalpo",
	-- ["Bloodscalp ruins"] = "Ruínas Sanguescalpo",
	-- ["East of the ogres, Shadowmaw Panthers (37-38) stalk unseen until they strike; the Stranglethorn Tigresses roam the same ground and now and then drop a pristine fang. Snapjaw Crocolisks line the river just west of the jungle; keep their skins for {npc:2495}."] = "A leste dos ogros, Panteras Umbragorja (37-38) espreitam invisíveis até atacar; as Tigresas-do-espinhaço vagam pela mesma área e às vezes derrubam uma presa imaculada. Crocoliscos Arapuca ocupam o rio logo a oeste da selva; guarde as peles para {npc:2495}.",
	-- ["Follow the road north to the camp."] = "Siga a estrada para o norte até o acampamento.",
	-- ["Follow the road on south into {area:35}."] = "Siga a estrada para o sul até {area:35}.",
	-- ["Head west past the camp. Stranglethorn Raptors (33-34) hunt the clearings, and the Bloodscalp trolls hold the ruins on the coast: every Bloodscalp can drop a tusk. A {item:4614} is a very rare drop from them: if one drops, read it."] = "Vá para oeste passando pelo acampamento. Raptores-do-espinhaço (33-34) caçam nas clareiras, e os trolls Sanguescalpo ocupam as ruínas no litoral: todo Sanguescalpo pode derrubar uma presa. Um {item:4614} é um saque muito raro deles: se cair um, leia-o.",
	-- ["Hearth to {object:3202}"] = "Pedra de Regresso para {object:3202}",
	-- ["Jungle Stalkers"] = "Espreitadores da Selva",
	-- ["Lashtail raptors"] = "Raptores Batecauda",
	-- ["Leave the {zone:1458} by the lift and walk up through the ruins to the zeppelin towers; the {object:3202} zeppelin is the one on the south-west tower."] = "Saia de {zone:1458} pelo elevador e suba pelas ruínas até as torres de zepelim; o zepelim de {object:3202} é o da torre sudoeste.",
	-- ["Mistvale gorillas"] = "Gorilas do Vale da Névoa",
	-- ["Mosh'Ogg camp"] = "Acampamento Mosh'Ogg",
	-- ["Pages of The {item:2755} drop at about 1% each from the Bloodscalp and Skullsplitter trolls; take what drops and check the Auction House for the rest."] = "As páginas de {item:2755} caem com cerca de 1% cada dos trolls Sanguescalpo e Rachacrânio; pegue o que cair e procure o resto na casa de leilões.",
	-- ["Raptors and the Bloodscalp trolls"] = "Raptores e os trolls Sanguescalpo",
	-- ["Ride back south to {object:3202}."] = "Volte para o sul até {object:3202}.",
	-- ["Ride north past Nesingwary's camp to the lake. The Venture Co. Geologists (34-36) work the camps along its western shore; they carry the Tumbled Crystals."] = "Siga para o norte passando pelo acampamento de Rosarães Guima até o lago. Os Geólogos da Empreendimentos S.A. (34-36) trabalham nos acampamentos ao longo da margem oeste; eles carregam os Cristais Rolados.",
	-- ["Ride south down the coast to {object:3202} and fly to {area:35}."] = "Siga para o sul pelo litoral até {object:3202} e voe até {area:35}.",
	-- ["Shadowmaw jungle and the Snapjaw river"] = "Selva das Panteras Umbragorja e rio dos Crocoliscos Arapuca",
	-- ["Take the road south towards {area:35}. The Elder Mistvale Gorillas (40-41) live in {area:1737}, east of the road; about one in twenty carries an aged sinew."] = "Pegue a estrada para o sul em direção a {area:35}. Os Gorilas Anciões do Vale da Névoa (40-41) vivem no {area:1737}, a leste da estrada; cerca de um em cada vinte carrega um tendão velho.",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and fly to {area:392}. {npc:5901} camps on the coast a short ride south of it."] = "Pegue o zepelim de {zone:1454} na torre do lado oeste de {object:3202} e voe até {area:392}. {npc:5901} acampa no litoral, um pouco ao sul de lá.",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202} and train in the city before you fly on."] = "Pegue o zepelim de {zone:1454} na torre do lado oeste de {object:3202} e treine na cidade antes de seguir voando.",
	-- ["The Bloodscalp Headhunters (36-37) in the village on the coast carry the shrunken heads."] = "Os Caçadores de Cabeças Sanguescalpo (36-37) na aldeia do litoral carregam as cabeças encolhidas.",
	-- ["The Bloodscalp trolls hold the ruins up the coast north of the reef and the village beyond; every one can drop a {item:3915}. Keep looting pages of {quest:338}."] = "Os trolls Sanguescalpo ocupam as ruínas subindo o litoral ao norte do recife e a aldeia mais adiante; todos podem derrubar um {item:3915}. Continue saqueando páginas de {quest:338}.",
	-- ["The Elder Stranglethorn Tigers (34-35) roam the hills south-west of the camp; the Lashtail Raptors (35-36) hunt further south, towards {object:3202}."] = "Os Tigres-do-espinhaço Anciões (34-35) vagam pelas colinas a sudoeste do acampamento; os Raptores Batecauda (35-36) caçam mais ao sul, em direção a {object:3202}.",
	-- ["The Jungle Stalkers (40-41) hunt the coast south of {object:3202}. They are well above you: pull one at a time and rest between fights."] = "Os Espreitadores da Selva (40-41) caçam no litoral ao sul de {object:3202}. Eles estão bem acima de você: puxe um de cada vez e descanse entre as lutas.",
	-- ["The Mosh'Ogg ogres camp in the hills just east of {object:3202}. Kill one Brute and one Witch Doctor (36-37); pull them one at a time."] = "Os ogros Mosh'Ogg acampam nas colinas logo a leste de {object:3202}. Mate um Brutamontes e um Mandingueiro (36-37); puxe um de cada vez.",
	-- ["The next guide flies you north to {area:272} and into the {zone:1417}."] = "O próximo guia leva você voando para o norte até {area:272} e para {zone:1417}.",
	-- ["Tigers and panthers"] = "Tigres e panteras",
	-- ["West past the camp, Crystal Spine Basilisks (34-35) sit on the rocks; every Bloodscalp in the village beyond can drop an ear."] = "A oeste do acampamento, Basiliscos da Serra dos Cristais (34-35) ficam sobre as pedras; todo Sanguescalpo na aldeia mais adiante pode derrubar uma orelha.",
	-- ["Young Stranglethorn Tigers prowl west of the camp, Young Panthers south and east of it."] = "Tigres-do-espinhaço Jovens rondam a oeste do acampamento, e Panteras Jovens ao sul e a leste dele.",
	-- ["Young tigers and panthers"] = "Tigres jovens e panteras",
	-- ["Zeppelin towers"] = "Torres de zepelim",
	-- ["{npc:2495}: the Snapjaw skins gathered earlier"] = "{npc:2495}: as peles de Crocolisco Arapuca coletadas antes",
	-- ["{npc:729}, a level 37 tiger, prowls the hilltop south-west of the camp."] = "{npc:729}, um tigre de nível 37, ronda o topo da colina a sudoeste do acampamento.",
}
