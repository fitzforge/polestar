-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Tram to Stormwind
	-- {zone:1453} Stormwind
	["Tram to {zone:1453}"] = "Metrô para {zone:1453}",

	-- Step 3: Druid training
	["Druid training"] = "Treinamento de druida",
	-- {zone:1455} Ironforge · {area:2257} Deeprun Tram · {object:171524} Tinker Town · {zone:1453} Stormwind · {npc:5504} Sheldras Moontree
	["{zone:1455} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{zone:1455} não tem instrutor de druida: pegue {area:2257} em {object:171524} até {zone:1453} e treine com {npc:5504}.",

	-- Step 4: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voe para {zone:1453}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Mestre de voo de {area:150}",

	-- Step 6: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "De {zone:1431}, pegue a estrada para o sul até a Selva do Espinhaço; as barracas dos caçadores ficam logo a oeste da estrada, depois do desvio para {area:99}.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, de {zone:1441}",

	-- Step 7: Young tigers and panthers
	["Young tigers and panthers"] = "Tigres e panteras jovens",
	["Both roam the grass around the camp and along the road north."] = "Os dois vagam pelo capim ao redor do acampamento e ao longo da estrada para o norte.",

	-- Step 11: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Tigres-do-espinhaço",
	["The adult tigers prowl the hills just south and west of the camp."] = "Os tigres adultos rondam as colinas logo ao sul e a oeste do acampamento.",

	-- Step 12: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Os tigres anciões ficam para depois, na volta de {area:99}",

	-- Step 13: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panteras, raptores e tigres anciões",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "De volta ao sul, passando Rosarães: Panteras e Raptores-do-espinhaço correm nas clareiras a oeste do acampamento, rumo à costa; os tigres anciões dominam as colinas a sudoeste.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Glubglub, um murloc raro na costa a oeste do acampamento, deixa cair {item:4614}: pegue se encontrá-lo",

	-- Step 14: Rebel Camp
	-- {npc:738} Private Thorsen
	["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Pegue a estrada para o norte; {npc:738} patrulha nela, e o acampamento fica nas colinas a oeste.",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, na cabana",

	-- Step 15: Bookie Herod
	["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Os registros de Herodes ficam numa cabana no lado oeste do complexo; o cofre dele fica mais a leste, junto à entrada da caverna.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}, no andar de cima",

	-- Step 16: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "{area:101}: vá matando estes pelo caminho",
	-- {area:99} Rebel Camp
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents."] = "Os rebeldes de Kurzen dominam o complexo a leste de {area:99}; trabalhe pela borda externa, onde ficam os Guerrilheiros da Selva e os Curandeiros, e saqueie os caixotes de suprimentos junto às barracas.",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, de um caixote de {object:263}",

	-- Step 17: Bookie Herod
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}, no subterrâneo",

	-- Step 19: Stranglethorn Vale: kill these as you meet them
	-- {area:33} Stranglethorn Vale
	["{area:33}: kill these as you meet them"] = "{area:33}: vá matando estes pelo caminho",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Cuidado: há acampamentos troll perto da área dos tigres, e os trolls podem entrar na briga se você puxar sem cuidado.\nCuidado: o ninho de raptores tem filhotes que entram na briga quando você ataca os adultos.",

	-- Step 20: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} coleciona {item:2755}: as páginas caem de quase todo humanoide da selva. Transforme as páginas em capítulos pelo caminho.",

	-- Step 21: Shadowmaw Panther on the way
	-- {npc:684} Shadowmaw Panther
	["{npc:684} on the way"] = "{npc:684} no caminho",

	-- Step 22: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} e os raptores Batecauda",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, o grande tigre, tem seu covil no alto da colina a sudoeste do acampamento; Raptores Batecauda correm ao sul dele, no caminho para {area:35}.",

	-- Step 23: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Descendo até {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Siga a estrada principal para o sul por toda a selva, passando o desvio para {object:3202}, até {area:35}, no cabo ao sul.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "{npc:2495}, junto ao banco; lá dentro",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, lá dentro",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern (no name in this language: may be words)
	["{npc:6807}, {object:56910}; upstairs"] = "{npc:6807}, Taberna do Marujo Salgado; no andar de cima",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern (no name in this language: may be words)
	["{npc:2832}, in the {object:56910}; upstairs"] = "{npc:2832}, na Taberna do Marujo Salgado; no andar de cima",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern; upstairs"] = "{npc:773}, na taberna; no andar de cima",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, no andar de cima",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, na taberna",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, no andar de cima da taberna",

	-- Step 24: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "Voe para {area:108}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 26: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}: vá matando estes pelo caminho",
	-- {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards.\nThe Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Volte a pé para o norte; {area:310} fica a oeste da estrada, no meio da selva. Os Basiliscos da Serra dos Cristais de lá deixam cair os estilhaços.\nOs trolls Sanguescalpo ocupam as ruínas da costa a oeste do acampamento do Rosarães Guima.",

	-- Step 27: River crocolisks
	["River crocolisks"] = "Crocoliscos do Rio",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Crocoliscos do Rio nadam no rio junto a {area:99}.",

	-- Step 28: Private Thorsen
	-- {area:99} Rebel Camp
	["Thorsen patrols the road north of camp, toward the {area:99}."] = "Turgo patrulha a estrada ao norte do acampamento, rumo a {area:99}.",

	-- Step 29: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: basta olhar em volta do acampamento dos caçadores",

	-- Step 30: Hearth to Booty Bay
	-- {area:35} Booty Bay
	["Hearth to {area:35}"] = "Pedra de Regresso para {area:35}",

	-- Step 31: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, lá dentro",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, no andar de cima",

	-- Step 32: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Crocoliscos Arapuca",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Crocoliscos Arapuca tomam sol na praia e nas ilhas ao longo da costa ao norte de {area:35}.",

	-- Step 34: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Voe para {area:42}",

	-- Step 35: Into Stranglethorn Vale
	-- {area:33} Stranglethorn Vale
	["Into {area:33}"] = "Rumo a {area:33}",

	-- Step 37: Kurzen's Compound
	-- {spell:7964} Smoke Bomb
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "Os Encolhedores de Cabeças ficam mais para dentro do complexo; as Tropas de Choque espreitam furtivas em volta e na caverna. Pegue as páginas de Grande Espinhaço conforme caírem.\nCuidado: as Tropas de Choque de Kurzen são nível 34-35, não elite, e costumam surgir furtivas; quase mortas, usam {spell:7964}.",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}, no subterrâneo",

	-- Step 38: The jungle ruins
	["The jungle ruins"] = "As ruínas da selva",
	-- {area:37} Lake Nazferiti
	-- plural, as words: Shadowmaw Panthers = {npc:684} Shadowmaw Panther · Tumbled Crystals = {item:4106} Tumbled Crystal
	["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Percorra as ruínas trolls do norte e do centro: cada uma guarda uma tabuleta de pedra das lendas trolls. Panteras Umbragorja rondam furtivas na selva ao redor; o acampamento da Empreendimentos S.A. em {area:37} carrega os Cristais Rolados.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006}: {object:58}; debaixo d'água",

	-- Step 39: The haunted island
	["The haunted island"] = "A ilha assombrada",
	["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Siga a costa oeste para o norte; a ilha assombrada fica perto da praia, a oeste do acampamento de Rosarães. Basta chegar lá.",

	-- Step 40: Stranglethorn Vale: kill these as you meet them
	-- {npc:1096} Venture Co. Geologist
	["grind on {npc:1096}"] = "mate {npc:1096} até subir",

	-- Step 41: Rebel Camp
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: para {npc:773}, em {area:35}",

	-- Step 44: Jungle Stalker on the way
	-- {npc:687} Jungle Stalker
	["{npc:687} on the way"] = "{npc:687} no caminho",

	-- Step 45: Skullsplitter trolls
	["Skullsplitter trolls"] = "Trolls Rachacrânio",
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Os trolls Rachacrânio dominam as ruínas a leste da estrada, entre Rosarães e {object:3202}.",

	-- Step 48: Booty Bay
	-- {object:56910} The Salty Sailor Tavern (no name in this language: may be words)
	["{object:56910} is the tall building over the harbour; most of the quest givers are on its floors or the docks below."] = "A Taberna do Marujo Salgado é o prédio alto sobre o porto; a maioria de quem dá missões está nos andares dela ou no cais lá embaixo.",
	-- {zone:1417} Arathi Highlands
	["The ore drops from Drywhisker kobolds in {zone:1417}"] = "O minério cai dos kobolds Bigodesseco em {zone:1417}",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley \"Lobo do Mar\", no último andar",

	-- Step 50: Into Westfall
	-- {area:40} Westfall
	["Into {area:40}"] = "Rumo a {area:40}",

	-- Step 52: Fly to Booty Bay
	-- {area:35} Booty Bay
	["Fly to {area:35}"] = "Voe até {area:35}",
	-- {area:108} Sentinel Hill
	["{area:108} flight master"] = "Mestre de voo de {area:108}",

	-- Step 53: Baron Revilgaz
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Para o Arquimago Ansirem, em {zone:1416}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "Trolls Sanguescalpo",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Voe de {area:150} para {area:1537} e treine.",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Voe para {area:42}: {npc:1573}, em {object:32372} de {area:1537}, ou {npc:352}, em {object:2096} de {zone:1453}.",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Os Encolhedores de Cabeças ficam mais para dentro do complexo; as Tropas de Choque espreitam furtivas ao redor dele e na caverna. Pegue as páginas de Grande Espinhaço: Veredas que caírem.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Pegue a estrada para o norte; {npc:738} está nela, e o acampamento fica nas colinas a oeste.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Os trolls Sanguescalpo dominam as ruínas na costa a oeste do acampamento de Rosarães.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Volte para o norte; {area:310} fica a oeste da estrada, no meio da selva. Os Basiliscos da Serra dos Cristais de lá deixam cair os fragmentos.",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} não tem instrutor de druida: pegue o {area:2257} em {object:171524} até {zone:1453} e treine com {npc:5504}.",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, junto ao banco",
	-- ["{npc:2832}, in the {object:56910}"] = "{npc:2832}, na {object:56910}",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, no último andar, junto às docas",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, na taberna",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: quatro lendas trolls",
}
