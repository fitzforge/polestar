-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/04-stranglethorn-vale (forever/alliance/30-40/04-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Voar para {area:42}",
	-- {area:150} Menethil Harbor
	["{area:150} flight master"] = "Mestre de voo de {area:150}",

	-- Step 3: Nesingwary's Expedition
	-- {zone:1431} Duskwood · {area:99} Rebel Camp
	["From {zone:1431} take the road south into Stranglethorn; the hunters' tents stand just west of the road past the {area:99} turn-off."] = "De {zone:1431}, pegue a estrada para o sul até a Selva do Espinhaço; as barracas dos caçadores ficam logo a oeste da estrada, depois do desvio para {area:99}.",
	-- {npc:715} Hemet Nesingwary · {zone:1441} Thousand Needles
	["{npc:715}, from {zone:1441}"] = "{npc:715}, de {zone:1441}",

	-- Step 4: Young tigers and panthers
	["Young tigers and panthers"] = "Tigres e panteras jovens",
	["Both roam the grass around the camp and along the road north."] = "Os dois vagam pelo capim ao redor do acampamento e ao longo da estrada para o norte.",

	-- Step 8: Stranglethorn Tigers
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["Stranglethorn Tigers"] = "Tigres-do-espinhaço",
	["The adult tigers prowl the hills just south and west of the camp."] = "Os tigres adultos rondam as colinas logo ao sul e a oeste do acampamento.",

	-- Step 9: Level 33.2
	["Level 33.2"] = "Nível 33.2",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Stranglethorn Tigers = {npc:682} Stranglethorn Tiger
	["The jungle's quests climb to 37 from here: short of 33.2? Keep on the Stranglethorn Tigers in the hills just south and west of the camp until level 33.2. Or, with a group, run the {area:796} dungeon (Library) instead."] = "As missões da selva sobem para 37 a partir daqui: abaixo de 33.2? Continue nos Tigres-do-espinhaço nas colinas logo ao sul e a oeste do acampamento até o nível 33.2. Ou, com um grupo, faça a masmorra {area:796} (Biblioteca).",
	-- {npc:682} Stranglethorn Tiger
	["grind on {npc:682}"] = "mate {npc:682} até subir",

	-- Step 10: Ajeck Rouack
	-- {area:99} Rebel Camp
	["The elder tigers come later, on the way back from the {area:99}"] = "Os tigres anciões ficam para depois, na volta de {area:99}",

	-- Step 11: Panthers, raptors and elder tigers
	["Panthers, raptors and elder tigers"] = "Panteras, raptores e tigres anciões",
	-- plural, as words: Stranglethorn Raptors = {npc:685} Stranglethorn Raptor
	["Back south past Nesingwary: Panthers and Stranglethorn Raptors run in the clearings west of the camp toward the coast; the elder tigers hold the hills south-west."] = "De volta ao sul, passando Rosarães: Panteras e Raptores-do-espinhaço correm nas clareiras a oeste do acampamento, rumo à costa; os tigres anciões dominam as colinas a sudoeste.",
	-- {item:4614} Pendant of Myzrael
	["Gluggle, a rare murloc on the coast west of camp, drops the {item:4614}: take it if you meet him"] = "Glubglub, um murloc raro na costa a oeste do acampamento, deixa cair {item:4614}: pegue se encontrá-lo",

	-- Step 12: Sir S. J. Erlgadin
	-- {area:99} Rebel Camp
	["Back east to Nesingwary's camp on the way north to the {area:99}."] = "De volta a leste, até o acampamento de Rosarães, a caminho do norte, para {area:99}.",

	-- Step 13: Rebel Camp
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["Take the road north; the camp sits in the hills to the west.\n{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "Siga a estrada para o norte; o acampamento fica nas colinas a oeste.\n{npc:738} passa a maior parte do tempo no alto do caminho de {area:99}, junto às cabanas, e de vez em quando desce por ele até a estrada e volta (cerca de oito minutos). Se ele não estiver na seta, procure ao longo desse caminho.",
	-- {npc:469} Lieutenant Doren
	["{npc:469}, in the hut"] = "{npc:469}, na cabana",
	-- {npc:469} Lieutenant Doren · {quest:200} Bookie Herod · {area:101} Kurzen's Compound
	["{npc:469}: {quest:200}'s records lie at the edge of {area:101}, next"] = "{npc:469}: os registros de {quest:200} ficam na beira de {area:101}, a seguir",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}: for {npc:773} in {area:35}, later in this guide"] = "{npc:770}: para {npc:773} em {area:35}, mais adiante neste guia",

	-- Step 14: Kurzen's Compound: kill these as you meet them
	-- {area:101} Kurzen's Compound
	["{area:101}: kill these as you meet them"] = "{area:101}: vá matando estes pelo caminho",
	-- {area:99} Rebel Camp · {quest:200} Bookie Herod
	["The Kurzen rebels hold the camp east of the {area:99}; work its outer edge, where Jungle Fighters and Medicine Men stand, and loot the supply crates by the tents. {quest:200}'s records lie in a hut on the compound's west side."] = "Os rebeldes de Kurzen dominam o complexo a leste de {area:99}; trabalhe pela borda externa, onde ficam os Guerrilheiros da Selva e os Curandeiros, e saqueie os caixotes de suprimentos junto às barracas. Os registros de {quest:200} ficam numa cabana no lado oeste do complexo.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, in the hut"] = "{object:287}, na cabana",
	["The strongbox is deeper in, by the cave: on the northern loop (04b)"] = "O cofre fica mais para dentro, junto à caverna: no circuito do norte (04b)",
	-- {item:2634} Venom Fern Extract · {object:263} Kurzen Supplies
	["{item:2634}, from a {object:263} crate"] = "{item:2634}, de um caixote de {object:263}",

	-- Step 15: Level 33.6
	["Level 33.6"] = "Nível 33.6",
	-- {area:796} Scarlet Monastery
	-- plural, as words: Kurzen Jungle Fighters = {npc:937} Kurzen Jungle Fighter
	["Short of 33.6? Keep on the Kurzen Jungle Fighters and Medicine Men around the compound's outer edge until level 33.6. Or, with a group, run the {area:796} dungeon (Library) instead."] = "Abaixo de 33.6? Continue nos Guerrilheiros da Selva e Curandeiros de Kurzen na borda externa do complexo até o nível 33.6. Ou, com um grupo, faça a masmorra {area:796} (Biblioteca).",
	-- {npc:937} Kurzen Jungle Fighter
	["grind on {npc:937}"] = "mate {npc:937} até subir",

	-- Step 17: Stranglethorn Vale: kill these as you meet them
	-- {zone:1434} Stranglethorn Vale
	["{zone:1434}: kill these as you meet them"] = "{zone:1434}: vá matando estes pelo caminho",
	["Careful: Troll camps are close to the tiger area, and trolls can join a fight if you pull carelessly.\nCareful: The raptor nest has young raptors that join the fight when you attack the adults."] = "Cuidado: há acampamentos troll perto da área dos tigres, e os trolls podem entrar na briga se você puxar sem cuidado.\nCuidado: o ninho de raptores tem filhotes que entram na briga quando você ataca os adultos.",

	-- Step 18: Level 34
	["Level 34"] = "Nível 34",
	-- {area:796} Scarlet Monastery
	["The quests from here on are 37: if you are short of 34, keep on the elder tigers in the hills south-west of Nesingwary's camp until level 34. Or, with a group, run the {area:796} dungeon (Library or Armory) instead."] = "As missões daqui em diante são de nível 37: se estiver abaixo do 34, continue nos tigres anciãos das colinas a sudoeste do acampamento de Nesingwary até o nível 34. Ou, com um grupo, faça a masmorra {area:796} (Biblioteca ou Arsenal).",
	-- {npc:1085} Elder Stranglethorn Tiger
	["grind on {npc:1085}"] = "mate {npc:1085} até subir",

	-- Step 19: Nesingwary's Expedition
	-- {npc:716} Barnil Stonepot · {item:2755} Green Hills of Stranglethorn
	["{npc:716} collects the {item:2755}: the pages drop from almost every humanoid in the jungle. Turn the pages into chapters as you go."] = "{npc:716} coleciona {item:2755}: as páginas caem de quase todo humanoide da selva. Transforme as páginas em capítulos pelo caminho.",

	-- Step 20: Sin'Dall and the Lashtail raptors
	-- {npc:729} Sin'Dall
	["{npc:729} and the Lashtail raptors"] = "{npc:729} e os raptores Batecauda",
	-- {npc:729} Sin'Dall · {area:35} Booty Bay
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:729}, the great tiger, lairs on the hilltop south-west of the camp; Lashtail Raptors run south of it, along the way to {area:35}."] = "{npc:729}, o grande tigre, tem seu covil no alto da colina a sudoeste do acampamento; Raptores Batecauda correm ao sul dele, no caminho para {area:35}.",

	-- Step 21: Down to Booty Bay
	-- {area:35} Booty Bay
	["Down to {area:35}"] = "Descendo até {area:35}",
	-- {object:3202} Grom'gol (no name in this language: may be words) · {area:35} Booty Bay
	["Follow the main road south the length of the jungle, past the {object:3202} turn-off, to {area:35} on the southern cape."] = "Siga a estrada principal para o sul por toda a selva, passando o desvio para {object:3202}, até {area:35}, no cabo ao sul.",
	-- {npc:2495} Drizzlik
	["{npc:2495}, by the bank; inside"] = "{npc:2495}, junto ao banco; lá dentro",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, lá dentro",
	-- {npc:6807} Innkeeper Skindle · {object:56910} The Salty Sailor Tavern (no name in this language: may be words)
	["{npc:6807}, {object:56910}; upstairs"] = "{npc:6807}, {object:56910}; no andar de cima",
	-- {npc:2832} Nixxrax Fillamug · {object:56910} The Salty Sailor Tavern (no name in this language: may be words)
	["{npc:2832}, in the {object:56910}; upstairs"] = "{npc:2832}, na {object:56910}; no andar de cima",
	-- {npc:773} Krazek
	["{npc:773}, in the tavern; upstairs"] = "{npc:773}, na taberna; no andar de cima",
	-- {npc:773} Krazek · {npc:770} Corporal Kaleb
	["{npc:773}, from {npc:770}"] = "{npc:773}, de {npc:770}",
	-- {npc:737} Kebok
	["{npc:737}, in the tavern"] = "{npc:737}, na taberna",
	-- {npc:737} Kebok
	-- plural, as words: Tumbled Crystals = {item:4106} Tumbled Crystal
	["{npc:737}: the Tumbled Crystals, on the northern loop"] = "{npc:737}: os Cristais Rolados, no circuito do norte",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, no andar de cima da taberna",

	-- Step 22: Fly to Sentinel Hill
	-- {area:108} Sentinel Hill
	["Fly to {area:108}"] = "Voe para {area:108}",
	-- {area:35} Booty Bay
	["{area:35} flight master"] = "Mestre de voo de {area:35}",

	-- Step 24: The Savage Coast: kill these as you meet them
	-- {area:301} The Savage Coast
	["{area:301}: kill these as you meet them"] = "{area:301}: vá matando estes pelo caminho",
	-- {area:108} Sentinel Hill · {zone:1436} Westfall · {area:310} Crystalvein Mine
	-- plural, as words: Crystal Spine Basilisks = {npc:689} Crystal Spine Basilisk
	["From {area:108} the way leads south out of {zone:1436} into Stranglethorn's north-west, to the {area:310} near the coast; the Crystal Spine Basilisks around it drop the shards.\nThe haunted island lies just off the coast south-west of the mine: just reach it. The Bloodscalp trolls hold the ruins on the coast to the north."] = "De {area:108}, o caminho segue para o sul, saindo de {zone:1436}, até o noroeste da Selva do Espinhaço, até {area:310}, perto da costa; os Basiliscos da Serra dos Cristais em volta dela soltam os cristais.\nA ilha mal-assombrada fica logo ao largo da costa, a sudoeste da mina: basta chegar lá. Os trolls Sanguescalpo dominam as ruínas na costa, ao norte.",
	["The haunted island"] = "A ilha assombrada",

	-- Step 25: River crocolisks
	["River crocolisks"] = "Crocoliscos do Rio",
	-- {area:99} Rebel Camp
	-- plural, as words: River Crocolisks = {npc:1150} River Crocolisk
	["River Crocolisks swim the river by the {area:99}."] = "Crocoliscos do Rio nadam no rio junto a {area:99}.",

	-- Step 26: Private Thorsen
	-- {npc:738} Private Thorsen · {area:99} Rebel Camp
	["{npc:738} spends most of his time at the top of the {area:99}'s path, by the huts, and now and then walks down it to the road and back (about eight minutes). If he isn't at the arrow, look along that path."] = "{npc:738} passa a maior parte do tempo no alto do caminho de {area:99}, junto às cabanas, e de vez em quando desce por ele até a estrada e volta (cerca de oito minutos). Se ele não estiver na seta, procure ao longo desse caminho.",

	-- Step 27: Nesingwary's Expedition
	-- {quest:201} Investigate the Camp
	["{quest:201}: just look around the hunters' camp"] = "{quest:201}: basta olhar em volta do acampamento dos caçadores",

	-- Step 28: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, lá dentro",
	-- {npc:2495} Drizzlik
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["{npc:2495}: the Snapjaw Crocolisks, on the northern loop"] = "{npc:2495}: os Crocolíscos Arapuca, no circuito do norte",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, no andar de cima",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, no andar de cima",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}: the water elementals rise around the haunted island, on the northern loop"] = "{npc:2496}: os elementais da água surgem em volta da ilha assombrada, no circuito do norte",

	-- Step 29: Fly to Stormwind
	-- {zone:1453} Stormwind
	["Fly to {zone:1453}"] = "Voe para {zone:1453}",

	-- Step 31: Collin Mauren
	-- {npc:4078} Collin Mauren · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["{npc:4078} is in the {object:2164}, in the {object:2101}."] = "{npc:4078} fica em {object:2164}, em {object:2101}.",

	-- Step 32: Druid training
	["Druid training"] = "Treinamento de druida",
	-- {npc:5504} Sheldras Moontree · {zone:1453} Stormwind · {object:2101} Mage Quarter
	["{npc:5504}, the druid trainer, stands in {zone:1453}, north-west of the {object:2101}."] = "{npc:5504}, a instrutora de druida, fica em {zone:1453}, a noroeste do {object:2101}.",

	-- Step 34: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Voe para {area:415}",
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Mestre de voo de {area:442}",

	-- Step 35: Heartswood
	-- {area:415} Astranaar · {quest:1738} Heartswood · {area:413} Maestra's Post · {quest:65602} What Is Love? · {item:190309} Wooden Figurine
	["From {area:415} head north-west into the hills: the {quest:1738} is a glowing tree north of the road to {area:413}. If you took {quest:65602}, the {item:190309} lies in a house among the trees north of {area:413} (26.6,22.0). Then take the road west to Stonetalon."] = "De {area:415}, siga para noroeste, pelas colinas: {quest:1738} é uma árvore brilhante ao norte da estrada para {area:413}. Se você pegou {quest:65602}, {item:190309} está numa casa entre as árvores ao norte de {area:413} (26.6,22.0). Depois siga a estrada para oeste até a Cordilheira das Torres de Pedra.",
	-- {item:190309} Wooden Figurine · {area:413} Maestra's Post
	["{item:190309}, north of {area:413}"] = "{item:190309}, ao norte de {area:413}",

	-- Step 36: Stonetalon Mountains
	-- {area:608} Nijel's Point
	["The road to {area:608}"] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Bloodscalp trolls"] = "Trolls Sanguescalpo",
	-- ["Fly from {area:150} to {area:1537} and train."] = "Voe de {area:150} para {area:1537} e treine.",
	-- ["Fly to {area:42}: {npc:1573} in {area:1537}'s {object:32372}, or {npc:352} in {zone:1453}'s {object:2096}."] = "Voe para {area:42}: {npc:1573}, em {object:32372} de {area:1537}, ou {npc:352}, em {object:2096} de {zone:1453}.",
	-- ["Follow the west coast north; the haunted island lies off the shore west of Nesingwary's camp. Just reach it."] = "Siga a costa oeste para o norte; a ilha assombrada fica perto da praia, a oeste do acampamento de Rosarães. Basta chegar lá.",
	-- ["For Archmage Ansirem in {zone:1416}"] = "Para o Arquimago Ansirem, em {zone:1416}",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave. Pick up Green Hills pages as they drop."] = "Os Encolhedores de Cabeças ficam mais para dentro do complexo; as Tropas de Choque espreitam furtivas ao redor dele e na caverna. Pegue as páginas de Grande Espinhaço: Veredas que caírem.",
	-- ["Herod's records lie in a hut on the compound's west side; his strongbox sits farther east, by the cave mouth."] = "Os registros de Herodes ficam numa cabana no lado oeste do complexo; o cofre dele fica mais a leste, junto à entrada da caverna.",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Percorra as ruínas trolls do norte e do centro: cada uma guarda uma tabuleta de pedra das lendas trolls. Panteras Umbragorja rondam furtivas na selva ao redor; o acampamento da Empreendimentos S.A. em {area:37} carrega os Cristais Rolados.",
	-- ["Skullsplitter trolls"] = "Trolls Rachacrânio",
	-- ["Snapjaw Crocolisks"] = "Crocoliscos Arapuca",
	-- ["Snapjaw Crocolisks bask on the shore and islands along the coast north of {area:35}."] = "Crocoliscos Arapuca tomam sol na praia e nas ilhas ao longo da costa ao norte de {area:35}.",
	-- ["Take the road north; {npc:738} patrols it, the camp sits in the hills to the west."] = "Pegue a estrada para o norte; {npc:738} patrulha nela, e o acampamento fica nas colinas a oeste.",
	-- ["Take the road north; {npc:738} stands on it, the camp sits in the hills to the west."] = "Pegue a estrada para o norte; {npc:738} está nela, e o acampamento fica nas colinas a oeste.",
	-- ["The Bloodscalp trolls hold the ruins on the coast west of Nesingwary's camp."] = "Os trolls Sanguescalpo dominam as ruínas na costa a oeste do acampamento de Rosarães.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Os trolls Rachacrânio dominam as ruínas a leste da estrada, entre Rosarães e {object:3202}.",
	-- ["The jungle ruins"] = "As ruínas da selva",
	-- ["The ore drops from Drywhisker kobolds in {zone:1417}"] = "O minério cai dos kobolds Bigodesseco em {zone:1417}",
	-- ["Thorsen patrols the road north of camp, toward the {area:99}."] = "Turgo patrulha a estrada ao norte do acampamento, rumo a {area:99}.",
	-- ["Walk back north; the {area:310} lies west of the road in the middle of the jungle. The Crystal Spine Basilisks there drop the shards."] = "Volte para o norte; {area:310} fica a oeste da estrada, no meio da selva. Os Basiliscos da Serra dos Cristais de lá deixam cair os fragmentos.",
	-- ["{area:1537} has no druid trainer: take the {area:2257} from {object:171524} to {zone:1453} and train with {npc:5504}."] = "{area:1537} não tem instrutor de druida: pegue o {area:2257} em {object:171524} até {zone:1453} e treine com {npc:5504}.",
	-- ["{area:33}: kill these as you meet them"] = "{area:33}: vá matando estes pelo caminho",
	-- ["{npc:2495}, by the bank"] = "{npc:2495}, junto ao banco",
	-- ["{npc:2859}, on the top floor by the docks"] = "{npc:2859}, no último andar, junto às docas",
	-- ["{npc:469}: {quest:200}'s records, on the northern loop (04b)"] = "{npc:469}: os registros do {quest:200}, no circuito do norte (04b)",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: para {npc:773}, em {area:35}",
	-- ["{npc:773}, in the tavern"] = "{npc:773}, na taberna",
	-- ["{quest:207}: four troll legends"] = "{quest:207}: quatro lendas trolls",
}
