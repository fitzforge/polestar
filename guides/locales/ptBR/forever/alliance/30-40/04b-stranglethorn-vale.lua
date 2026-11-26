-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/04b-stranglethorn-vale (forever/alliance/30-40/04b-stranglethorn-vale.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 35 to 36, but several quests here are level 37-38: on purpose, for their experience. The water elementals are 36-37: pull them one at a time."] = "Para personagens de nível 35 a 36, mas várias missões aqui são de nível 37-38: de propósito, pela experiência. Os elementais da água são de nível 36-37: puxe um de cada vez.",

	-- Step 1: Collin Mauren
	-- {object:2164} Slaughtered Lamb
	["In the {object:2164}, if you still carry it"] = "Em {object:2164}, se você ainda estiver com isso",

	-- Step 2: Fly to Darkshire
	-- {area:42} Darkshire
	["Fly to {area:42}"] = "Voar para {area:42}",
	-- {zone:1453} Stormwind
	["{zone:1453} flight master"] = "Mestre de voo de {zone:1453}",

	-- Step 3: Clerk Daltry
	-- {npc:267} Clerk Daltry · {area:42} Darkshire · {npc:661} Jonathan Carevin
	["{npc:267} works in {area:42}'s town hall, a short walk from the flight master; {npc:661} stands just east of it."] = "",
	-- {npc:661} Jonathan Carevin · {area:121} Tranquil Gardens Cemetery · {zone:1435} Swamp of Sorrows
	["{npc:661}: the evidence lies in the {area:121}, on the next guide's way to the {zone:1435}: keep it"] = "",

	-- Step 4: Clerk Daltry
	-- {npc:267} Clerk Daltry · {area:42} Darkshire · {npc:661} Jonathan Carevin
	["{npc:267} works in {area:42}'s town hall; {npc:661} stands just east of it."] = "{npc:267} trabalha na prefeitura de {area:42}; {npc:661} fica logo a leste.",

	-- Step 5: Stranglethorn Vale
	-- {zone:1434} Stranglethorn Vale
	["Into {zone:1434}"] = "Rumo a {zone:1434}",

	-- Step 6: Rebel Camp
	-- {zone:1431} Duskwood
	["From {zone:1431} take the road south; the camp sits in the hills west of the road."] = "De {zone:1431}, siga a estrada para o sul; o acampamento fica nas colinas a oeste da estrada.",
	-- {npc:770} Corporal Kaleb · {npc:773} Krazek · {area:35} Booty Bay
	["{npc:770}, if the first Stranglethorn loop didn't give it: for {npc:773} in {area:35}"] = "",

	-- Step 7: Nesingwary's Expedition
	-- {npc:717} Ajeck Rouack
	["South along the road: the hunters' tents stand just west of it. {npc:717} and Hemet gave you these on the first loop: take them now only if you didn't."] = "Para o sul pela estrada: as barracas dos caçadores ficam logo a oeste dela. {npc:717} e Rosarães deram estas no primeiro circuito: aceite agora só se não as pegou.",
	-- {npc:717} Ajeck Rouack · {npc:729} Sin'Dall
	["{npc:717}. Keep it for the later visit if you skip {npc:729} on the raptor hill."] = "",
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["{npc:715}, if the first Stranglethorn loop didn't give it: the Lashtail Raptors, after the jungle ruins"] = "",

	-- Step 8: Bookie Herod
	-- {area:101} Kurzen's Compound
	["East to {area:101}: Herod's records lie in a hut on its west side."] = "Para o leste até {area:101}: os registros de Herodes ficam numa cabana no lado oeste.",
	-- {object:287} Bookie Herod's Records
	["{object:287}, upstairs"] = "{object:287}, no andar de cima",

	-- Step 9: Bookie Herod
	-- {area:101} Kurzen's Compound · {quest:328} The Hidden Key
	["Herod's records lie in a hut on the west side of {area:101}: take {quest:328} there."] = "Os registros de Herod ficam numa cabana no lado oeste de {area:101}: pegue {quest:328} lá.",

	-- Step 10: Kurzen's Compound
	-- {npc:218230} Wendel Mathers · {spell:7964} Smoke Bomb · {npc:813} Colonel Kurzen
	-- plural, as words: Kurzen Commandos = {npc:938} Kurzen Commando
	["{npc:218230}, a cook, is caged at the compound's western edge: take his quest now and keep it, his cage key and the fighter's uniform come on the 40-50 Stranglethorn guide, when the Subchiefs and Elites are your level. Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}. {npc:813}, an elite of 39-40, stands at the compound's north end: leave him be."] = "{npc:218230}, um cozinheiro, está engaiolado na borda oeste do complexo: pegue a missão dele agora e guarde-a; a chave da gaiola e o uniforme de lutador ficam para o Guia de Selva do Espinhaço 40-50, quando os Subchefes e os Elites estiverem no seu nível. Encolhedores de Cabeças ficam mais fundo no complexo; as Tropas de Choque ficam à espreita, furtivas, em volta dele e na caverna, e o cofre de Herodes fica na boca da caverna. Pegue as páginas de Grande Espinhaço: Veredas conforme caírem.\nCuidado: as Tropas de Choque de Kurzen são de nível 34-35, não elite, e costumam aparecer furtivas; perto da morte, elas usam {spell:7964}. {npc:813}, um elite de nível 39-40, fica na ponta norte do complexo: deixe-o em paz.",
	-- {npc:218230} Wendel Mathers
	["{npc:218230}, in his cage"] = "{npc:218230}, na gaiola",
	-- {npc:941} Kurzen Headshrinker
	["{npc:941}, below ground"] = "{npc:941}, no subterrâneo",
	-- {object:288} Bookie Herod's Strongbox
	["{object:288}, below ground"] = "{object:288}, no subterrâneo",

	-- Step 11: The jungle ruins
	["The jungle ruins"] = "As ruínas da selva",
	["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west.\nCareful: the Saltscale murlocs on the shore near the second tablet are elite (35-37): swim to the tablet from the water and keep clear of them."] = "Para o oeste pela selva até as ruínas trolls: cada uma guarda uma tabuleta de pedra das lendas trolls, as duas primeiras nas ruínas a sudoeste do acampamento do Rosarães, as duas últimas na colina a noroeste.\nCuidado: os murlocs Salescama na costa perto da segunda tabuleta são elite (35-37): nade até a tabuleta pela água e mantenha distância deles.",
	-- {item:2006} The Second Troll Legend · {object:58} Gri'lek the Wanderer
	["{item:2006}: {object:58}; underwater"] = "{item:2006}: {object:58}; debaixo d'água",

	-- Step 12: Water Elementals
	-- plural, as words: Lesser Water Elementals = {npc:691} Lesser Water Elemental
	["The haunted island lies just off the shore west of the second tablet: the Lesser Water Elementals rise from the water around it."] = "A ilha assombrada fica logo ao largo da costa, a oeste da segunda tabuleta: os Elementais Inferiores da Água surgem da água em volta dela.",

	-- Step 13: The Ruins of Zul'Kunda
	-- {area:102} Ruins of Zul'Kunda
	["The {area:102}"] = "{area:102}",
	-- {npc:268992} Zimmix Sputterspark · {item:277957} Primitive Key
	-- plural, as words: Stolen Shipments = {item:277953} Stolen Shipment · Bloodscalp Berserkers = {npc:597} Bloodscalp Berserker
	["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "Para o norte pela costa até as ruínas na colina: as duas últimas tábuas estão lá. {npc:268992}, um goblin, está numa jaula ao lado da terceira tábua: qualquer Escalpo Sangrento pode soltar a {item:277957} dele. As cargas roubadas ficam na borda leste das ruínas. Pegue as páginas das Colinas Verdes quando caírem.\nCuidado: os berserkers, caçadores de cabeças e mandingueiros Escalpo Sangrento (36-37) ocupam o centro das ruínas: puxe um de cada vez.",
	-- {npc:268992} Zimmix Sputterspark
	["{npc:268992}, in his cage beside the third tablet"] = "{npc:268992}, na gaiola ao lado da terceira tabuleta",
	-- {item:277957} Primitive Key
	["{item:277957}, from the Bloodscalp trolls"] = "{item:277957}, dos trolls Sanguescalpo",

	-- Step 14: Escort Zimmix Sputterspark
	-- {npc:268992} Zimmix Sputterspark
	["Escort {npc:268992}"] = "Escolte {npc:268992}",
	-- {npc:268992} Zimmix Sputterspark · {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["Lead {npc:268992} out of the ruins and keep him alive: {npc:4631} in {area:35} takes the news at the end of this loop."] = "Leve {npc:268992} para fora das ruínas e mantenha-o vivo: {npc:4631} em {area:35} recebe a notícia no fim desta volta.",
	-- {npc:4631} Wharfmaster Lozgil · {area:35} Booty Bay
	["For {npc:4631} in {area:35}, at the end of this loop"] = "Para o {npc:4631}, em {area:35}, no fim deste circuito",

	-- Step 15: Sin'Dall on the raptor hill
	-- {npc:729} Sin'Dall
	["{npc:729} on the raptor hill"] = "",
	-- {npc:729} Sin'Dall · {npc:717} Ajeck Rouack
	["Check the hilltop on your way to the raptors. If {npc:729} isn't here or you can't pull her alone, keep moving; {npc:717} can take the paw on the later visit."] = "",
	-- {npc:729} Sin'Dall
	["{npc:729}'s hill"] = "",
	-- {npc:729} Sin'Dall
	["{npc:729} (37) prowls the hilltop."] = "",

	-- Step 16: The Lashtail raptors
	["The Lashtail raptors"] = "Os raptores Batecauda",
	-- {quest:187} Tiger Mastery · {npc:729} Sin'Dall
	-- plural, as words: Lashtail Raptors = {npc:686} Lashtail Raptor
	["East from the ruins, hunt Lashtail Raptors around the hill south-west of Nesingwary's camp. If you have {quest:187}, are at least 36 and see {npc:729} (37) alone, you can take her paw here or leave the hunt for your next visit."] = "",

	-- Step 17: Ajeck Rouack
	-- {npc:717} Ajeck Rouack
	["Hand the paw to {npc:717} beside Hemet."] = "",

	-- Step 18: Nesingwary's Expedition
	-- {npc:715} Hemet Nesingwary
	-- plural, as words: Jungle Stalkers = {npc:687} Jungle Stalker
	["{npc:715}: the Jungle Stalkers come in 40-50"] = "{npc:715}: os Espreitadores da Selva ficam para o 40-50",

	-- Step 19: Rebel Camp
	-- {area:99} Rebel Camp
	["North-east up the road to the {area:99}, then back south through the jungle."] = "Siga a estrada para o nordeste até {area:99} e depois volte para o sul pela selva.",
	-- {npc:733} Sergeant Yohwa
	["{npc:733}: the Commandos and Headshrinkers fell in the compound"] = "{npc:733}: as Tropas de Choque e os Encolhedores de Cabeças são abatidos no complexo",
	-- plural, as words: Skullsplitter Witch Doctors = {npc:670} Skullsplitter Witch Doctor
	["keep it: the Skullsplitter Witch Doctors (41-42) wait for the 40-50 Stranglethorn guide"] = "guarde-a: os Mandingueiros Rachacrânio (41-42) ficam para o Guia de Selva do Espinhaço 40-50",

	-- Step 20: Snapjaw Crocolisks
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks"] = "Crocoliscos Arapuca",
	-- {area:35} Booty Bay
	-- plural, as words: Snapjaw Crocolisks = {npc:1152} Snapjaw Crocolisk
	["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to {area:35}."] = "Crocoliscos Arapuca tomam sol ao longo do rio no meio da selva, no caminho para o sul até {area:35}.",

	-- Step 21: Tokal
	-- {npc:215643} Tokal · {object:56910} Salty Sailor Tavern (no name in this language: may be words) · {item:4600} Cherry Grog · {npc:2832} Nixxrax Fillamug
	["{npc:215643}, whom Bibbly sent you to find, waits by the {object:56910}. He asks for a {item:4600}: {npc:2832} sells it in the tavern, a few steps away."] = "",
	-- {item:4600} Cherry Grog · {npc:2832} Nixxrax Fillamug
	["{item:4600}, from {npc:2832}"] = "",

	-- Step 22: Booty Bay
	-- {npc:2495} Drizzlik
	["{npc:2495}, inside"] = "{npc:2495}, lá dentro",
	-- {npc:2496} Baron Revilgaz
	["{npc:2496}, upstairs in the tavern"] = "{npc:2496}, no andar de cima da taberna",
	-- {zone:1416} Alterac Mountains
	["For Archmage Ansirem in {zone:1416}"] = "Para o Arquimago Ansirem, em {zone:1416}",
	-- {npc:737} Kebok
	["{npc:737}, upstairs"] = "{npc:737}, no andar de cima",
	-- {npc:773} Krazek
	["{npc:773}, upstairs"] = "{npc:773}, no andar de cima",
	-- {npc:773} Krazek · {item:4278} Lesser Bloodstone Ore · {zone:1417} Arathi Highlands · {skill:186} Mining
	-- plural, as words: Lesser Bloodstone Deposits = {object:2653} Lesser Bloodstone Deposit
	["{npc:773}, upstairs: this optional quest needs four {item:4278}. Mine Lesser Bloodstone Deposits in {zone:1417} with {skill:186} 75, or buy the ore at the Auction House or ask a miner friend. The kobolds do not drop it; skip this quest if you cannot get the ore."] = "{npc:773}, no andar de cima: esta missão opcional pede quatro {item:4278}. Minere Depósitos de Pedra-sangrenta Menor em {zone:1417} com {skill:186} 75, ou compre o minério na Casa de Leilões ou peça a um amigo minerador. Os kobolds não o deixam cair; pule esta missão se não conseguir o minério.",
	-- {npc:2498} Crank Fizzlebub
	["{npc:2498}, inside"] = "{npc:2498}, lá dentro",
	["\"Sea Wolf\" MacKinley, on the top floor"] = "MacKinley \"Lobo do Mar\", no último andar",
	-- {npc:4631} Wharfmaster Lozgil
	["{npc:4631}, on the docks"] = "{npc:4631}, nas docas",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["East from the ruins to the hilltop south-west of Nesingwary's camp: the Lashtail Raptors run in the jungle around it. Leave {npc:729}, the great tiger (37) on the hilltop, to the 40-50 Stranglethorn guide: you're about 35 here. Then on to the hunters' tents."] = "Das ruínas, siga para o leste até o topo da colina a sudoeste do acampamento do Rosarães: os Raptores Batecauda correm pela selva em volta dela. Deixe {npc:729}, o grande tigre (37) no topo da colina, para o Guia de Selva do Espinhaço 40-50: você está por volta do nível 35 aqui. Depois, siga para as tendas dos caçadores.",
	-- ["East to the {area:99}, on the way back to Nesingwary's camp."] = "Para o leste até {area:99}, no caminho de volta ao acampamento do Rosarães.",
	-- ["Follow the west coast north to the haunted island off the shore west of Nesingwary's camp: the Lesser Water Elementals rise from the water around it."] = "Siga a costa oeste para o norte até a ilha assombrada, ao largo da costa a oeste do acampamento do Rosarães: os Elementais Inferiores da Água surgem da água em volta dela.",
	-- ["For characters of 35 to 36, but several quests here are level 37-41: on purpose, for their experience. {quest:205}'s Skullsplitter trolls are 39-42, so pull them one at a time."] = "Para personagens de nível 35 a 36, mas várias missões aqui são de nível 37-41: de propósito, pela experiência. Os trolls Rachacrânio de {quest:205} são de nível 39-42, então puxe um de cada vez.",
	-- ["Headshrinkers stand deeper in the compound; the Commandos lurk stealthed around it and in the cave, and Herod's strongbox sits by the cave mouth. Pick up Green Hills pages as they drop.\nCareful: Kurzen Commandos are level 34-35, not elite, and often spawn stealthed; near death they use {spell:7964}."] = "Encolhedores de Cabeças ficam mais fundo no complexo; as Tropas de Choque ficam à espreita, furtivas, em volta dele e na caverna, e o cofre de Herodes fica na boca da caverna. Pegue as páginas de Grande Espinhaço: Veredas conforme caírem.\nCuidado: as Tropas de Choque de Kurzen são de nível 34-35, não elite, e costumam aparecer furtivas; perto da morte, elas usam {spell:7964}.",
	-- ["Herod's records lie in a hut on the west side of {area:101}, east of the {area:99}."] = "Os registros de Herodes ficam numa cabana no lado oeste de {area:101}, a leste de {area:99}.",
	-- ["Level 36"] = "Nível 36",
	-- ["Loop through the troll ruins of the north and centre: each holds one stone tablet of the troll legends. Shadowmaw Panthers prowl stealthed in the jungle around them; the Venture Co. camp on {area:37} carries the Tumbled Crystals."] = "Percorra as ruínas trolls do norte e do centro: cada uma guarda uma tabuleta de pedra das lendas trolls. Panteras Umbragorja rondam furtivas na selva ao redor; o acampamento da Empreendimentos S.A. em {area:37} carrega os Cristais Rolados.",
	-- ["Mauren, from Stonetalon"] = "Mauren, da Cordilheira das Torres de Pedra",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. Pick up Green Hills pages as they drop."] = "Para o norte pela costa até as ruínas na colina: as duas últimas tabuletas ficam lá. Pegue as páginas de Grande Espinhaço: Veredas conforme caírem.",
	-- ["North along the coast to the ruins on the hill: the last two tablets lie there. {npc:268992}, a goblin, is caged beside the third tablet: any Bloodscalp can drop his {item:277957}, then lead him out of the ruins. The Stolen Shipments lie at the ruins' east edge. Pick up Green Hills pages as they drop.\nCareful: the Bloodscalp Berserkers, Headhunters and Witch Doctors (36-37) hold the ruins' core: pull them one at a time."] = "Para o norte pela costa até as ruínas na colina: as duas últimas tabuletas ficam lá. {npc:268992}, um goblin, está engaiolado ao lado da terceira tabuleta: qualquer Sanguescalpo pode deixar cair a {item:277957}; depois, guie-o para fora das ruínas. Os Carregamentos Roubados ficam na borda leste das ruínas. Pegue as páginas de Grande Espinhaço: Veredas conforme caírem.\nCuidado: os Berserkers, Caçadores de Cabeças e Mandingueiros Sanguescalpo (36-37) dominam o centro das ruínas: puxe-os um de cada vez.",
	-- ["Skullsplitter trolls"] = "Trolls Rachacrânio",
	-- ["Snapjaw Crocolisks bask along the river in the middle of the jungle, on the way south to the Skullsplitter ruins."] = "Crocolíscos Arapuca tomam sol ao longo do rio no meio da selva, no caminho para o sul até as ruínas Rachacrânio.",
	-- ["South along the road: the hunters' tents stand just west of it."] = "Para o sul pela estrada: as barracas dos caçadores ficam logo a oeste dela.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals, and the Shadowmaw Panthers prowl stealthed in the jungle south and east of it."] = "Do complexo, siga para o sul até {area:37}: os Geólogos da Empreendimentos S.A. nos acampamentos da margem carregam os Cristais Rolados, e as Panteras Umbragorja rondam furtivas na selva ao sul e a leste dele.",
	-- ["South from the compound to {area:37}: the Venture Co. Geologists in the camps on its shore carry the Tumbled Crystals. Careful: Venture Co. Agents (39) walk among them: take the Geologists on the camps' edges, one at a time. Shadowmaw Panthers (37-38) prowl stealthed in the jungle south and east of the lake: keep to the shore camps."] = "Do complexo, siga para o sul até {area:37}: os Geólogos da Empreendimentos S.A. nos acampamentos da margem carregam os Cristais Rolados. Cuidado: Agentes da Empreendimentos S.A. (39) andam entre eles: ataque os Geólogos nas bordas dos acampamentos, um de cada vez. Panteras Umbragorja (37-38) rondam furtivas na selva ao sul e a leste do lago: fique nos acampamentos da margem.",
	-- ["The Skullsplitter trolls hold the ruins east of the road between Nesingwary and {object:3202}."] = "Os trolls Rachacrânio dominam as ruínas a leste da estrada, entre Rosarães e {object:3202}.",
	-- ["West across the jungle to the troll ruins: each holds one stone tablet of the troll legends, the first two in the ruins south-west of Nesingwary's camp, the last two on the hill in the north-west."] = "Para o oeste pela selva até as ruínas trolls: cada uma guarda uma tabuleta de pedra das lendas trolls, as duas primeiras nas ruínas a sudoeste do acampamento do Rosarães, as duas últimas na colina a noroeste.",
	-- ["grind on {npc:1152}"] = "mate {npc:1152} até subir",
	-- ["{npc:715}, if 30-40/04 didn't give it: the Lashtail Raptors, after the jungle ruins"] = "{npc:715}, se o 30-40/04 não a deu: os Raptores Batecauda, depois das ruínas da selva",
	-- ["{npc:717}, if 30-40/04 didn't give it: {npc:729}, in the 40-50 Stranglethorn guide"] = "{npc:717}, se o 30-40/04 não a deu: {npc:729}, no guia 40-50 da Selva do Espinhaço",
	-- ["{npc:718}: the Shadowmaw Panthers prowl around {area:37}, after {area:101}"] = "{npc:718}: as Panteras Umbragorja rondam {area:37}, depois de {area:101}",
	-- ["{npc:770}, if 30-40/04 didn't give it: for {npc:773} in {area:35}"] = "{npc:770}, se o 30-40/04 não a deu: para {npc:773}, em {area:35}",
	-- ["{npc:770}: for {npc:773} in {area:35}"] = "{npc:770}: para {npc:773}, em {area:35}",
	-- ["{npc:773}: the ore drops from Drywhisker kobolds in {zone:1417}, next"] = "{npc:773}: o minério cai dos kobolds Bigodesseco em {zone:1417}, a seguir",
	-- ["{quest:205}'s Skullsplitter trolls are 39-42. Below 36? Keep killing the Snapjaw Crocolisks along the river until level 36. Or, with a group, run the {area:796} dungeon (Armory) or the {area:1316} dungeon instead."] = "Os trolls Rachacrânio de {quest:205} são de nível 39-42. Abaixo do 36? Continue matando os Crocoliscos Arapuca ao longo do rio até o nível 36. Ou, com um grupo, faça a masmorra {area:796} (Arsenal) ou a masmorra {area:1316}.",
	-- ["{zone:1434}: kill these as you meet them"] = "{zone:1434}: vá matando estes pelo caminho",
}
