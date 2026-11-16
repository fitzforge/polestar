-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/01-hillsbrad-foothills (forever/horde/30-40/01-hillsbrad-foothills.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:527} Battle of Hillsbrad · {area:272} Tarren Mill
	["For characters of 29 to 31: the {quest:527}, {area:272}'s errands and the gnolls of the foothills, all at or under your level."] = "Para personagens de 29 a 31: {quest:527}, as tarefas de {area:272} e os gnolls do sopé, tudo no seu nível ou abaixo.",

	-- Step 1: Freewind Post flight master
	-- {area:484} Freewind Post
	["{area:484} flight master"] = "Mestre de voo de {area:484}",

	-- Step 2: Thunder Bluff
	-- {area:484} Freewind Post · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise
	["Fly from {area:484} to {area:1638} and train with {npc:3033} on {area:1639}; fly on to the Crossroads from there."] = "Voe de {area:484} para {area:1638} e treine com {npc:3033} em {area:1639}; de lá, siga voando até a Encruzilhada.",

	-- Step 3: Ratchet
	-- {area:484} Freewind Post · {area:392} Ratchet · {npc:5901} Islen Waterseer
	["Fly from {area:484} to {area:392}. {npc:5901} camps on the coast a short walk south of the town; fly on to the Crossroads from {area:392}."] = "Voe de {area:484} para {area:392}. {npc:5901} acampa na costa, a uma curta caminhada ao sul da cidade; de {area:392}, siga voando até a Encruzilhada.",
	-- {npc:5901} Islen Waterseer · {item:6637} Water Sapta
	["{npc:5901}: your {item:6637}, for the brazier"] = "{npc:5901}: {item:6637}, para o braseiro",

	-- Step 4: Fly to the Crossroads
	["Fly to the Crossroads"] = "Voe para a Encruzilhada",
	-- {zone:1456} Thunder Bluff
	["{zone:1456} flight master"] = "Mestre de voo de {zone:1456}",

	-- Step 5: Fly to the Crossroads
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 7: Korran
	-- {npc:3428} Korran · {quest:1145} The Swarm Grows · {zone:1454} Orgrimmar
	["{npc:3428} stands beside the Crossroads flight master. {quest:1145} is offered from level 29; below it, the next guide's {zone:1454} stop takes it."] = "{npc:3428} fica ao lado do mestre de voo da Encruzilhada. {quest:1145} está disponível a partir do nível 29; abaixo disso, pegue-a na parada em {zone:1454} do próximo guia.",
	-- {npc:3428} Korran · {npc:4485} Belgrom Rockmaul · {zone:1454} Orgrimmar
	["{npc:3428}: for {npc:4485} in {zone:1454}"] = "{npc:3428}: para {npc:4485} em {zone:1454}",

	-- Step 8: Fly to Orgrimmar
	-- {area:1637} Orgrimmar
	["Fly to {area:1637}"] = "Voe para {area:1637}",
	["Crossroads flight master"] = "Mestre de voo da Encruzilhada",

	-- Step 9: Thrall
	-- {npc:4949} Thrall · {object:172957} Valley of Wisdom (no name in this language: may be words)
	["{npc:4949} waits in Grommash Hold, in the {object:172957}."] = "{npc:4949} espera na Fortaleza Grommash, em {object:172957}.",
	-- {npc:4949} Thrall
	["{npc:4949}, Grommash Hold, if you carry it"] = "{npc:4949}, Fortaleza Grommash, se você a tiver",

	-- Step 10: Train
	["Train"] = "Treinar",
	["Train your new spells."] = "Treine seus novos feitiços.",

	-- Step 11: Belgrom Rockmaul
	-- {npc:4485} Belgrom Rockmaul · {object:172958} Valley of Honor (no name in this language: may be words)
	["{npc:4485} stands in the {object:172958}, on the way out to the main gate."] = "{npc:4485} fica em {object:172958}, no caminho para o portão principal.",
	-- {npc:4483} Moktar Krin · {area:439} Shimmering Flats
	["for {npc:4483} in the {area:439}, next guide"] = "para {npc:4483} em {area:439}, no próximo guia",

	-- Step 12: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 13: Garen Largo
	-- {npc:260093} Garen Largo · {zone:1458} Undercity
	["{npc:260093} trains Paladins in the {zone:1458}."] = "{npc:260093} treina Paladinos em {zone:1458}.",

	-- Step 14: Undercity flight master
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Mestre de voo de {zone:1458}",

	-- Step 15: Brazier of Everfount
	-- {area:228} Sepulcher · {object:113791} Brazier of Everfount · {npc:5895} Minor Manifestation of Water · {item:7813} Shard of Water · {npc:5901} Islen Waterseer · {area:272} Tarren Mill
	["Fly to the {area:228}. The {object:113791} stands on the hill just south-west of it: beat the Corrupt Manifestation of Water beside it, place its bracers in the brazier, speak to the {npc:5895} and keep the {item:7813} for {npc:5901}. Fly on to {area:272} from the {area:228}."] = "Voe para {area:228}. {object:113791} fica no morro logo a sudoeste dela: derrote a Manifestação Corrompida da Água ao lado, coloque as braçadeiras dela no braseiro, fale com {npc:5895} e guarde o {item:7813} para {npc:5901}. Siga voando para {area:272} a partir de {area:228}.",
	-- {item:6637} Water Sapta
	["{item:6637}: drink it by the standing stone to see the elemental"] = "{item:6637}: beba junto à pedra erguida para ver o elemental",
	-- {npc:5901} Islen Waterseer
	["for {npc:5901}, next guide"] = "para {npc:5901}, próximo guia",

	-- Step 16: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Voe para {area:272}",
	-- {area:228} Sepulcher
	["{area:228} flight master"] = "Mestre de voo de {area:228}",

	-- Step 18: Tarren Mill
	-- {quest:567} Dangerous! · {npc:2216} Apothecary Lydon · {npc:2393} Christoph Jeffcoat
	["The {quest:567} poster hangs by the inn; {npc:2216} stands inside it. {npc:2393}, the cook by the inn, wants turtle meat and sells the spices for it."] = "O cartaz de {quest:567} fica perto da estalagem; {npc:2216} fica lá dentro. {npc:2393}, o cozinheiro perto da estalagem, quer carne de tartaruga e vende os temperos para ela.",
	-- {quest:567} Dangerous!
	["{quest:567}, the poster by the inn"] = "{quest:567}, o cartaz perto da estalagem",
	-- {npc:2216} Apothecary Lydon
	["{npc:2216}, inside"] = "{npc:2216}, lá dentro",
	-- {npc:2393} Christoph Jeffcoat · {quest:7321} Soothing Turtle Bisque
	["{npc:2393}: {quest:7321}, the Snapjaws of the river south of town"] = "{npc:2393}: {quest:7321}, as Mordedoras do rio ao sul da cidade",
	-- {item:3713} Soothing Spices · {npc:2393} Christoph Jeffcoat
	["{item:3713}, from {npc:2393}"] = "{item:3713}, de {npc:2393}",

	-- Step 19: High Executor Darthalia
	-- {area:287} Hillsbrad · {quest:527} Battle of Hillsbrad
	["You missed Darthalia's first errands, from the 22-25 {area:287} guide: they come first now. They are a few levels below you and quick, and they open the rest of the {quest:527} in this guide."] = "Você perdeu as primeiras tarefas de Darthalia, do guia {area:287} 22-25: elas vêm primeiro agora. Estão alguns níveis abaixo de você e são rápidas, e abrem o resto de {quest:527} neste guia.",

	-- Step 20: Krusk
	-- {npc:2229} Krusk · {area:275} Durnholde Keep
	["{npc:2229} wants his two scouts freed from {area:275}."] = "{npc:2229} quer os dois batedores dele libertados de {area:275}.",
	-- {npc:2229} Krusk
	["{npc:2229}, inside"] = "{npc:2229}, lá dentro",

	-- Step 21: Hillsbrad Fields
	-- {area:287} Hillsbrad · {npc:232} Farmer Ray · {npc:2403} Farmer Getz
	-- plural, as words: Kirin Tor Guards = {npc:246848} Kirin Tor Guard
	["West past the hills to the farms east of {area:287} town. {npc:232} works the field by the northern farmhouse, {npc:2403} the one further south-east; Farmhands and Farmers are everywhere.\nCareful: Kirin Tor Guards (55) patrol {area:287}'s fields and roads and attack the Horde: keep an eye out for them and stay out of their way."] = "Para oeste, passando as colinas, até as fazendas a leste da cidade de {area:287}. {npc:232} cuida do campo junto à casa de fazenda do norte, {npc:2403} do que fica mais a sudeste; Lavradores e Fazendeiros estão por toda parte.\nCuidado: Guardas do Kirin Tor (55) patrulham os campos e estradas de {area:287} e atacam a Horda: fique de olho neles e saia do caminho deles.",

	-- Step 22: Tarren Mill
	-- {area:272} Tarren Mill
	["Back east to {area:272}."] = "Volte para leste até {area:272}.",

	-- Step 23: Hillsbrad Peasants
	-- plural, as words: Hillsbrad Peasants = {npc:2267} Hillsbrad Peasant
	["Hillsbrad Peasants"] = "Camponeses de Eira dos Montes",
	["Back to the fields: the Peasants work south of the farmhouses. Careful: A fleeing peasant that reaches the town hall can bring back adds; snares or roots keep them from escaping."] = "De volta aos campos: os Camponeses trabalham ao sul das casas de fazenda. Cuidado: um camponês em fuga que chega à prefeitura pode trazer reforços; lentidões ou enraizamentos impedem que eles escapem.",

	-- Step 26: Durnholde Keep
	-- {npc:2238} Tog'thar · {npc:2427} Jailor Eston · {item:3467} Dull Iron Key · {npc:2428} Jailor Marlgen · {item:3499} Burnished Gold Key
	["South-east of Tarren Mill. Drull and {npc:2238} are chained in the keep's courtyard buildings: {npc:2427} carries the {item:3467} and {npc:2428} the {item:3499}, both in the keep. Kill them, then open both locks."] = "A sudeste da Serraria Tarren. Drull e {npc:2238} estão acorrentados nos prédios do pátio da fortaleza: {npc:2427} carrega {item:3467} e {npc:2428}, {item:3499}, ambos na fortaleza. Mate-os e depois abra as duas fechaduras.",
	["Drull's ball and chain"] = "Bola e corrente de Drull",
	-- {npc:2238} Tog'thar
	["{npc:2238}'s ball and chain"] = "Bola e corrente de {npc:2238}",

	-- Step 27: Krusk
	-- {area:272} Tarren Mill
	["Back to {area:272}."] = "De volta a {area:272}.",

	-- Step 28: The river south of Tarren Mill: kill these as you meet them
	-- {area:272} Tarren Mill
	["The river south of {area:272}: kill these as you meet them"] = "O rio ao sul de {area:272}: vá matando estes pelo caminho",
	-- {area:272} Tarren Mill · {area:271} Southshore · {item:3712} Turtle Meat
	["South from {area:272} along the river: Snapjaws (29) sun themselves on its banks all the way down to the hills above {area:271}. Some of them carry {item:3712}."] = "Ao sul de {area:272}, ao longo do rio: Mordedoras (29) tomam sol nas margens até as colinas acima de {area:271}. Algumas delas carregam {item:3712}.",
	-- {item:3712} Turtle Meat
	["{item:3712}, from the Snapjaws"] = "{item:3712}, das Mordedoras",

	-- Step 29: Mudsnout Blossoms
	-- {area:290} Dun Garok
	["South of the river's bend, the Mudsnout gnolls (26-28) camp in the hills above {area:290}; the blossoms grow among their tents. The Shamans heal and call their friends: pull them first."] = "Ao sul da curva do rio, os gnolls Focinho-de-lama (26-28) acampam nas colinas acima de {area:290}; as flores crescem entre as tendas deles. Os Xamãs curam e chamam os companheiros: puxe-os primeiro.",

	-- Step 30: North of Southshore
	["North of Southshore"] = "Ao norte da Costa Sul",
	-- {area:287} Hillsbrad · {area:271} Southshore
	["From the blossoms, back north along the river and then west to {area:287} town, well north of {area:271} (its guards are 55)."] = "Das flores, volte ao norte ao longo do rio e depois a oeste até a cidade de {area:287}, bem ao norte de {area:271} (os guardas de lá são nível 55).",

	-- Step 31: The smithy
	["The smithy"] = "A ferraria",
	-- {area:287} Hillsbrad · {npc:2404} Blacksmith Verringtan · {object:1736} Shipment of Iron · {npc:2449} Citizen Wilkes · {npc:2451} Farmer Kalaba
	["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it. {npc:2449} walks by the smithy; {npc:2451} works the field south-east of the town."] = "Para oeste pelo sopé até a cidade de {area:287}: a ferraria fica no meio dela. {npc:2404} e os aprendizes dele trabalham na forja; {object:1736} está empilhado ao lado. {npc:2449} anda perto da ferraria; {npc:2451} cuida do campo a sudeste da cidade.",
	["Inside"] = "Lá dentro",

	-- Step 32: Tarren Mill
	-- {npc:2055} Master Apothecary Faranell · {zone:1458} Undercity
	["for {npc:2055}, on the {zone:1458} stop at the end of this guide"] = "para {npc:2055}, na parada em {zone:1458} no fim deste guia",
	-- {npc:2429} Novice Thaivand · {item:3708} Helcular's Rod
	["{npc:2429}, in the town: {item:3708}, from the yetis on the way to the town hall"] = "{npc:2429}, na vila: {item:3708}, dos yetis no caminho para a prefeitura",

	-- Step 33: Helcular's Rod
	-- {area:277} Foothill Caverns
	-- plural, as words: Ferocious Yetis = {npc:2249} Ferocious Yeti · Giant Yetis = {npc:2251} Giant Yeti
	["West of Tarren Mill, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but they hit hard and come in pairs."] = "A oeste da Serraria Tarren, os Yetis das Cavernas e Yetis Ferozes (30-32) enchem {area:277}, nas colinas; cerca de um em cada dezesseis carrega o bastão. Fique nessas cavernas: os Yetis das Montanhas e Yetis Gigantes (32-34) da caverna mais ao norte também o carregam, mas eles batem forte e vêm em pares.",

	-- Step 34: Town hall
	["Town hall"] = "Prefeitura",
	-- {area:287} Hillsbrad · {npc:2335} Magistrate Burnside · {npc:2448} Clerk Horrace Whitesteed
	["On to {area:287} town, south-west of the yeti caves. The town hall is on the town's west side: {npc:2335} (30) and {npc:2448} are inside with the Town Registry; the Proclamation is pinned up beside it. Councilmen walk the town."] = "Siga para a vila de {area:287}, a sudoeste das cavernas dos yetis. A prefeitura fica no lado oeste da vila: {npc:2335} (30) e {npc:2448} estão lá dentro com o Cartório; a Proclamação está afixada ao lado. Conselheiros andam pela vila.",
	-- {object:1761} Hillsbrad Proclamation
	["{object:1761}, inside"] = "{object:1761}, lá dentro",

	-- Step 35: Tarren Mill
	-- {area:271} Southshore
	-- plural, as words: Giant Yetis = {npc:2251} Giant Yeti
	["Thaivand's next errand, the flames, sends you among the Mountain and Giant Yetis (32-34) and to Helcular's grave inside {area:271}: leave it."] = "A próxima tarefa de Trevando, as chamas, manda você para o meio dos Yetis das Montanhas e Yetis Gigantes (32-34) e até o túmulo de Helcolar dentro de {area:271}: deixe essa de lado.",

	-- Step 36: Melisara
	-- {npc:2278} Melisara · {area:272} Tarren Mill · {npc:2410} Magus Wordeen Voidglare
	["For your City of Dalaran run, later in this guide: {npc:2278} stands in {area:272}, a short walk east of {npc:2410}."] = "Para a masmorra Cidade de Dalaran, mais adiante neste guia: {npc:2278} fica em {area:272}, a uma curta caminhada a leste de {npc:2410}.",

	-- Step 37: City of Dalaran
	["City of Dalaran"] = "Cidade de Dalaran",
	-- {item:277507} Dalaran Sewer Key · {npc:247126} Atrexis the Grave Knight · {npc:2278} Melisara · {npc:268743} Rexxie Copperclutch
	["The City of Dalaran is a dungeon for a group of five, about levels 28 to 33, under the violet dome. Without the {item:277507}, go in through the sewer pipe north-west of the crater: the arrow leads there.\nInside: {npc:247126} is {npc:2278}'s. {npc:268743}, in the sewer, gives Opportunistic Education and takes it back there."] = "A Cidade de Dalaran é uma masmorra para um grupo de cinco, por volta dos níveis 28 a 33, sob a cúpula violeta. Sem a {item:277507}, entre pelo cano de esgoto a noroeste da cratera: a seta leva até lá.\nLá dentro: {npc:247126} é de {npc:2278}. {npc:268743}, no esgoto, dá Opportunistic Education e a recebe de volta ali mesmo.",
	-- {quest:96986} The Grave Knight · {npc:247126} Atrexis the Grave Knight
	["{quest:96986}: {npc:247126}, inside"] = "{quest:96986}: {npc:247126}, lá dentro",

	-- Step 39: Azurelode Mine
	-- {area:287} Hillsbrad · {area:288} Azurelode Mine · {npc:2305} Foreman Bonds · {npc:2450} Miner Hackett
	["Head south-west past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Siga a sudoeste, passando pela vila de {area:287}, até {area:288}. Mineiros trabalham nos túneis; {npc:2305} (30) e {npc:2450} (29) estão bem lá no fundo.",
	-- {area:288} Azurelode Mine
	["Inside {area:288}"] = "Dentro de {area:288}",

	-- Step 40: Level 30
	["Level 30"] = "Nível 30",
	-- {npc:2410} Magus Wordeen Voidglare · {area:272} Tarren Mill · {zone:1454} Orgrimmar · {area:288} Azurelode Mine · {zone:1437} Wetlands
	-- plural, as words: Torn Fin Muckdwellers = {npc:2374} Torn Fin Muckdweller
	["{npc:2410}'s quests on the next {area:272} stop and Alliance Relations in {zone:1454}, the next guide's first stop, are offered from level 30. Short of 30? The Torn Fin Muckdwellers and Coastrunners (28-30) crowd the coast south of the {area:288}, a short walk: kill them until level 30. Their Oracles (30-31) cast from the shore further east. Or, with a group, run the Excavation Site dungeon (in the {zone:1437}) instead."] = "As missões de {npc:2410} na próxima parada em {area:272} e Alliance Relations em {zone:1454}, a primeira parada do próximo guia, são oferecidas a partir do nível 30. Ainda não tem 30? Os Moralodos Rancapina e Correcostas Rancapina (28-30) lotam a costa ao sul de {area:288}, a uma curta caminhada: mate-os até o nível 30. Os Oráculos deles (30-31) lançam feitiços da praia mais a leste. Ou, com um grupo, faça a masmorra Excavation Site (em {zone:1437}).",
	["Torn Fin murlocs"] = "Murlocs Rancapina",
	-- {npc:2375} Torn Fin Coastrunner
	["grind on {npc:2375}"] = "mate {npc:2375} até subir",

	-- Step 41: Finish the Turtle Meat
	-- {item:3712} Turtle Meat
	["Finish the {item:3712}"] = "Termine a {item:3712}",
	-- {item:3712} Turtle Meat · {area:272} Tarren Mill
	["Still short of ten {item:3712}? The Snapjaws line the river east of {area:272}, on your way back from the mine."] = "Ainda não tem dez {item:3712}? As tartarugas Snapjaw ficam ao longo do rio a leste de {area:272}, no caminho de volta da mina.",

	-- Step 42: Tarren Mill
	-- {area:272} Tarren Mill · {area:271} Southshore
	["North-east back to {area:272}, passing well north of {area:271} (its guards are 55)."] = "Volte a nordeste até {area:272}, passando bem ao norte de {area:271} (os guardas de lá são 55).",
	-- {npc:2215} High Executor Darthalia · {quest:539} Battle of Hillsbrad · {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2215}: her next {quest:539}, and {npc:2419}'s sword, are elite group quests at {area:290}: take them only with a group"] = "{npc:2215}: a próxima dela, {quest:539}, e a espada de {npc:2419} são missões de grupo elite em {area:290}: pegue-as só com um grupo",
	-- {npc:2229} Krusk
	["{npc:2229}, inside: Infiltration, worked on the 38-39 visit (its Syndicate are 32-35)"] = "{npc:2229}, lá dentro: Infiltration, feita na visita do 38-39 (o Sindicato dela é 32-35)",
	-- {area:272} Tarren Mill
	["Keep Infiltration in your log: its Syndicate (32-35) are over you now, and the 38-39 guide (Alterac and Arathi) works it on its first {area:272} loop."] = "Mantenha Infiltration no seu Registro de Missões: o Sindicato dela (32-35) está acima de você agora, e o guia 38-39 (Alterac e Arathi) a faz na primeira volta por {area:272}.",

	-- Step 43: Voidglare, Bel'varil and Tallow
	-- {npc:2770} Tallow
	["Voidglare, Bel'varil and {npc:2770}"] = "Olharvazio, Bel'varão e {npc:2770}",
	-- {npc:2410} Magus Wordeen Voidglare · {npc:2437} Keeper Bel'varil · {npc:2770} Tallow · {area:272} Tarren Mill
	["{npc:2410} and {npc:2437} are inside the inn, {npc:2770} just outside it. Their quests are offered from level 30; below it, the 38-39 guide's first {area:272} stop takes them."] = "{npc:2410} e {npc:2437} estão dentro da estalagem, {npc:2770} logo do lado de fora. As missões deles são oferecidas a partir do nível 30; abaixo disso, a primeira parada do guia 38-39 em {area:272} as pega.",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:544} Prison Break In · {area:279} Dalaran
	["{npc:2410}, inside: {quest:544}, for the 38-39 visit (the {area:279} crater's traitors are 33-35)"] = "{npc:2410}, lá dentro: {quest:544}, para a visita do 38-39 (os traidores da cratera de {area:279} são 33-35)",
	-- {npc:2410} Magus Wordeen Voidglare · {quest:93680} Key to the City · {quest:544} Prison Break In
	["{npc:2410}: {quest:93680}, with {quest:544} on the 38-39 visit"] = "{npc:2410}: {quest:93680}, junto com {quest:544} na visita do 38-39",
	-- {npc:2437} Keeper Bel'varil · {quest:556} Stone Tokens
	["{npc:2437}, inside: {quest:556}, with the crater on the 38-39 visit"] = "{npc:2437}, lá dentro: {quest:556}, junto com a cratera na visita do 38-39",
	-- {npc:2770} Tallow
	["{npc:2770}, outside the inn: the Boulderfist ogres (32-34) on the 38-39 Arathi visit"] = "{npc:2770}, fora da estalagem: os ogros Boulderfist (32-34) na visita a Arathi do 38-39",
	-- {area:272} Tarren Mill · {area:321} Hammerfall
	["Keep these in your log: their camps are two to four levels over you now, and the 38-39 guide works them on its first {area:272} loop and in {area:321}."] = "Mantenha estas no seu Registro de Missões: os acampamentos delas estão dois a quatro níveis acima de você agora, e o guia 38-39 as faz na primeira volta por {area:272} e em {area:321}.",

	-- Step 44: Melisara
	-- {quest:96986} The Grave Knight · {npc:2278} Melisara · {npc:2410} Magus Wordeen Voidglare
	["{quest:96986} from your City of Dalaran run: {npc:2278}, a short walk east of {npc:2410}."] = "{quest:96986}, da sua ida à masmorra Cidade de Dalaran: {npc:2278}, a uma curta caminhada a leste de {npc:2410}.",

	-- Step 45: Battle of Hillsbrad with a group
	-- {quest:539} Battle of Hillsbrad
	["{quest:539} with a group"] = "{quest:539} com um grupo",
	-- {area:290} Dun Garok · {area:271} Southshore · {npc:2304} Captain Ironhill
	["Darthalia's last battle is at {area:290}, the dwarven keep south-east of {area:271}: every dwarf there is elite (28-32), {npc:2304} too. Great XP if you have a group for it."] = "A última batalha de Darthalia é em {area:290}, a fortaleza anã a sudeste de {area:271}: todo anão de lá é elite (28-32), {npc:2304} também. Ótima XP se você tiver um grupo.",

	-- Step 46: Humbert's Sword with a group
	-- {quest:547} Humbert's Sword
	["{quest:547} with a group"] = "{quest:547} com um grupo",
	-- {npc:2419} Deathguard Humbert · {area:290} Dun Garok
	["{npc:2419}'s sword drops from the same {area:290} dwarves (about one in twelve)."] = "A espada de {npc:2419} cai dos mesmos anões de {area:290} (cerca de um em doze).",

	-- Step 47: Dun Garok
	-- {area:290} Dun Garok
	["Clear {area:290} from the gate in; the dwarves run for help at 30% health."] = "Limpe {area:290} do portão para dentro; os anões correm para pedir ajuda com 30% de vida.",

	-- Step 48: Tarren Mill
	-- {npc:2425} Varimathras · {zone:1458} Undercity
	["for {npc:2425} in the {zone:1458}, at the end of this guide"] = "para {npc:2425}, em {zone:1458}, no fim deste guia",

	-- Step 50: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Voe para {area:1497}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Mestre de voo de {area:272}",

	-- Step 51: Master Apothecary Faranell
	-- {npc:2055} Master Apothecary Faranell · {object:36126} Royal Quarter (no name in this language: may be words)
	["{npc:2055} stands in the Apothecarium, in the {object:36126}."] = "{npc:2055} fica no Apothecarium, em {object:36126}.",
	-- {quest:513} Elixir of Agony · {item:3388} Lesser Troll's Blood Elixir · {skill:171} Alchemy · {area:287} Hillsbrad
	["Faranell's next {quest:513} needs a {item:3388} ({skill:171}) and the {area:287} coast: leave it."] = "A próxima missão de Faranello, {quest:513}, exige um {item:3388} ({skill:171}) e a costa de {area:287}: deixe-a.",

	-- Step 52: Varimathras
	-- {npc:2425} Varimathras · {object:36126} Royal Quarter (no name in this language: may be words)
	["{npc:2425} stands beside Sylvanas in the {object:36126}."] = "{npc:2425} fica ao lado de Sylvana em {object:36126}.",
	-- {npc:2425} Varimathras
	["{npc:2425}: Darthalia's commendation"] = "{npc:2425}: a recomendação de Darthalia",

	-- Step 53: Calder Gray
	-- {npc:270038} Calder Gray · {quest:97985} Thundering Hearts · {area:484} Freewind Post · {area:439} Shimmering Flats
	["{npc:270038} stands in the Apothecarium. His {quest:97985} is for Stormheart, a level 30 elite who walks the canyon east of {area:484}, on the next guide's way to the {area:439}."] = "{npc:270038} fica no Apothecarium. A {quest:97985} dele é para Stormheart, um elite de nível 30 que anda pelo cânion a leste de {area:484}, no caminho do próximo guia até {area:439}.",
	-- {npc:270038} Calder Gray · {zone:1458} Undercity
	["{npc:270038}: back to him on the next {zone:1458} stop, at about 38"] = "{npc:270038}: de volta a ele na próxima parada em {zone:1458}, por volta do nível 38",

	-- Step 54: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instrutores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {object:36073} Rogues' Quarter (no name in this language: may be words) · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Treine enquanto estiver em {zone:1458}: os instrutores ficam no {object:36070}, no {object:36073} e no {object:36082} (paladinos: {npc:260093}).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back into the yeti caves west of {area:272} with the {item:3710}. The path splits just inside: the {object:1768} burns on the upper level to the right, the {object:1769} on the lower level to the left, past more yetis."] = "De volta às cavernas dos yetis a oeste de {area:272} com o {item:3710}. O caminho se divide logo na entrada: {object:1768} queima no nível de cima, à direita, e {object:1769} no nível de baixo, à esquerda, depois de mais yetis.",
	-- ["Back north to {area:321}."] = "Volte ao norte até {area:321}.",
	-- ["Back to {area:272}"] = "De volta a {area:272}",
	-- ["Below ground"] = "No subterrâneo",
	-- ["Boulderfist camp"] = "Acampamento Punho de Pedra",
	-- ["Daggerspine naga"] = "Nagas Espinhadaga",
	-- ["Daggerspine shore"] = "Margem dos Espinhadaga",
	-- ["Follow the road north out of {area:272} into the Alterac foothills. {quest:535} waits by the Syndicate camp; hand him the stout."] = "Siga a estrada para o norte saindo de {area:272} até o sopé de Alterac. {quest:535} espera perto do acampamento da Camarilha; entregue-lhe a cerveja.",
	-- ["For characters of 29 to 33, but most quests here are level 32-34, a few up to 36: on purpose, for their experience. The Syndicate, {area:279}'s guards and the Boulderfist ogres are 31-35, so pull them one at a time."] = "Para personagens de nível 29 a 33, mas a maioria das missões aqui é de nível 32-34, algumas até 36: de propósito, pela experiência. A Camarilha, os guardas de {area:279} e os ogros Punho de Pedra são de nível 31-35, então puxe um de cada vez.",
	-- ["From {area:271} head north past {area:272} and follow the road on into the Alterac foothills. {quest:535} waits by the Syndicate camp. He offers his errand only while you carry {npc:2229}'s Infiltration: hand him the stout at once, and his reward is the Syndicate Missive Krusk wants. A missive from the Syndicate here does the same: with one in your bags the guide passes {quest:535}."] = "De {area:271}, siga para o norte passando por {area:272} e continue pela estrada até o sopé de Alterac. {quest:535} espera junto ao acampamento da Camarilha. Ele só oferece a tarefa enquanto você tiver Infiltração, de {npc:2229}: entregue logo a cerveja a ele, e a recompensa é a Missiva da Camarilha que o Krusk quer. Uma missiva da Camarilha daqui faz o mesmo: com uma nas bolsas, o guia pula {quest:535}.",
	-- ["Head back north to {area:272}, east of {area:271}."] = "Volte ao norte até {area:272}, a leste de {area:271}.",
	-- ["Head back north to {area:272}."] = "Volte para o norte até {area:272}.",
	-- ["Head back south down the road to {area:272}."] = "Volte pela estrada para o sul até {area:272}.",
	-- ["Head east out of {area:272} through {area:1057} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south of {area:313}; the Enforcers stay in the cave there."] = "Saia de {area:272} para leste, passando por {area:1057}, e siga a estrada para leste. Os Ogros e Impositores Punho de Pedra (32-34) acampam ao sul da estrada, ao sul de {area:313}; os Impositores ficam na caverna de lá.",
	-- ["Head east to {area:271}'s graveyard, on the north-east edge of the town: Helcular's grave lies among the others. Come at it from the north, down the slope above the town. Southshore Guards (55) stand at the graveyard's north-west corner and south-east of the grave: walk in between them, hand the quest in and leave the way you came."] = "Siga para leste até o cemitério de {area:271}, na ponta nordeste da vila: o túmulo de Helcular fica entre os outros. Chegue pelo norte, descendo a encosta acima da vila. Guardas da Costa Sul (55) ficam no canto noroeste do cemitério e a sudeste do túmulo: passe entre eles, entregue a missão e saia por onde veio.",
	-- ["Head south past {area:287} town to the {area:288}. Miners work the tunnels; {npc:2305} (30) and {npc:2450} (29) are deep inside."] = "Siga ao sul, passando pela vila de {area:287}, até {area:288}. Mineiros trabalham nos túneis; {npc:2305} (30) e {npc:2450} (29) estão bem lá no fundo.",
	-- ["Head west along the foot of the mountains to the violet dome of {area:279}. {npc:2411}, {npc:2412} and {npc:2413} (33-34) stand together inside the crater's eastern rim, {npc:2414} (35) a little west of them; each carries one Bloodstone piece. The Shield Guards and Theurgists (31-33) around them drop the Worn Stone Tokens. Careful: Many guards stand in linked pairs and others patrol alone around the camp. Arcane Sentries (55, elite) and Kirin Tor Guards (55) stand around the violet dome itself: keep to the camp below the rim."] = "Siga para oeste pelo pé das montanhas até a cúpula violeta de {area:279}. {npc:2411}, {npc:2412} e {npc:2413} (33-34) ficam juntos na borda leste da cratera, {npc:2414} (35) um pouco a oeste deles; cada um carrega uma peça de Pedra-sangrenta. Os Escudeiros e Teurgos (31-33) em volta deles deixam cair as Fichas de Pedra Gastas. Cuidado: muitos guardas andam em duplas ligadas, e outros patrulham sozinhos em volta do acampamento. Sentinelas Arcanas (55, elite) e Guardas do Kirin Tor (55) ficam em volta da própria cúpula violeta: fique no acampamento abaixo da borda.",
	-- ["Highland raptors and Plains Creepers"] = "Raptores do Planalto e Rastejantes das Planícies",
	-- ["Level 31"] = "Nível 31",
	-- ["Lydon's next errand is a keg of Shindigger Stout from the cellar of {area:290}, the elite dwarven keep south-east of {area:271}: take it only if you go there with a group."] = "A próxima tarefa de Lindolfo é um barril de Stout do Festeiro da adega de {area:290}, a fortaleza anã de elite a sudeste de {area:271}: só pegue se for lá em grupo.",
	-- ["North of Southshore's graveyard"] = "Ao norte do cemitério da Costa Sul",
	-- ["On the way back north, Highland Striders roam the hills all around {area:321} and drop the eyes, and south of it the Plains Creepers (32-33) spin their webs in the grass; they carry the spidersilk."] = "No caminho de volta ao norte, Andarilhos do Planalto vagam pelas colinas em volta de {area:321} e deixam cair os olhos, e ao sul dela os Rastejantes das Planícies (32-33) tecem suas teias no capim; eles carregam a seda de aranha.",
	-- ["Only if {quest:535}'s missive didn't come your way: the Syndicate Footpads and Thieves (32-34) around the camps west of the road carry missives too; about one in three drops one. Careful: at 31-32 they are still above you and stand close together, with Wizards (34-35) among them: pull one at a time from the camp's edge."] = "Só se a missiva de {quest:535} não veio para você: os Salteadores e Ladrões da Camarilha (32-34) em volta dos acampamentos a oeste da estrada também levam missivas; cerca de um em três deixa cair uma. Cuidado: no nível 31-32 eles ainda estão acima de você e ficam bem juntos, com Teurgos (34-35) no meio: puxe um de cada vez da borda do acampamento.",
	-- ["Place the {object:1729} on the {object:1728} beside the inn; upstairs"] = "Coloque {object:1729} em {object:1728} ao lado da estalagem; no andar de cima",
	-- ["Shindigger keg"] = "Barril do Festeiro",
	-- ["South of Hammerfall, the Witherbark trolls hold the village in the hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village. Careful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Ao sul de Ruína do Martelo, os trolls Cascasseca ocupam a aldeia nas colinas. Arremessadores de Machado guardam as cabanas de fora; os Mandingueiros e Caçadores de Cabeças ficam no coração da aldeia. Cuidado: os três tipos de troll fogem atrás de ajuda com 15% de vida, o que pode trazer mais trolls dos acampamentos vizinhos.",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod."] = "A sudoeste, os Yetis das Cavernas e Yetis Ferozes (30-32) enchem {area:277}, nas colinas a oeste de {area:272}; cerca de um em cada dezesseis carrega o bastão.",
	-- ["South-west, the Cave and Ferocious Yetis (30-32) fill the {area:277} in the hills west of {area:272}; about one in sixteen carries the rod. Stay in these caverns: the Mountain and Giant Yetis (32-34) of the cave further north carry it too, but at 29-30 they hit hard and come in pairs."] = "A sudoeste, os Yetis das Cavernas e Yetis Ferozes (30-32) enchem {area:277}, nas colinas a oeste de {area:272}; cerca de um em cada dezesseis carrega o bastão. Fique nessas cavernas: os Yetis das Montanhas e Yetis Gigantes (32-34) da caverna mais ao norte também o carregam, mas no nível 29-30 eles batem forte e vêm em pares.",
	-- ["Syndicate missives"] = "Missivas da Camarilha",
	-- ["The Daggerspine naga line the shore south-east of the town."] = "As nagas Espinhadaga se enfileiram pela costa a sudeste da cidade.",
	-- ["The Kegs of Shindigger Stout stand in the cellar of {area:290}, the dwarven keep south-east of {area:271}, beside {npc:2304} (32); every dwarf there is elite (28-32)."] = "Os Barris de Stout do Festeiro ficam na adega de {area:290}, a fortaleza anã a sudeste de {area:271}, ao lado de {npc:2304} (32); todo anão de lá é elite (28-32).",
	-- ["The Syndicate Footpads and Thieves (32-34) around the camps west of the road carry the missives; about one in three drops one."] = "Os Salteadores e Ladrões da Camarilha (32-34) em volta dos acampamentos a oeste da estrada levam as missivas; cerca de um em três deixa cair uma.",
	-- ["The Torn Fin murlocs camp on the beaches south-west of {area:271}'s bay, below the mine."] = "Os murlocs Rancapina acampam nas praias a sudoeste da baía de {area:271}, abaixo da mina.",
	-- ["The keg stands with a few others at the Syndicate camp on the south-east coast of {area:287}."] = "O barril fica com alguns outros no acampamento da Camarilha na costa sudeste de {area:287}.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "A fortaleza orc no extremo leste da estrada. {npc:2851}, a mestre dos mantícoras, fica junto ao portão.",
	-- ["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate.\n{npc:15126} offers the {quest:8263} only once you are Friendly with the Defilers ({zone:1461}): skip it if he doesn't offer it."] = "A fortaleza orc na ponta leste da estrada. {npc:2851}, o mestre de mantícoras, fica junto ao portão.\n{npc:15126} só oferece {quest:8263} quando você está Amigável com os Profanadores ({zone:1461}): pule se ele não oferecer.",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns."] = "A terceira chama queima na caverna menor, no alto das colinas ao norte das cavernas.",
	-- ["The third flame burns in the smaller cave up in the hills north of the caverns.\nCareful: Giant and Mountain Yetis (32-34) stand around the flame, often in pairs, and Frostmaw, a rare yeti (37), roams nearby. At 30-31 they are over your level: pull the yetis one at a time from the cave mouth before you use the Rod, and watch for Frostmaw before you go in."] = "A terceira chama queima na caverna menor, no alto das colinas ao norte das cavernas.\nCuidado: Yetis Gigantes e Yetis das Montanhas (32-34) ficam em volta da chama, muitas vezes em pares, e Bocarragelo, um yeti raro (37), anda por perto. No nível 30-31 eles estão acima do seu nível: puxe os yetis um de cada vez da entrada da caverna antes de usar o Bastão, e fique de olho em Bocarragelo antes de entrar.",
	-- ["The {area:279} crater"] = "A cratera de {area:279}",
	-- ["The {area:279} crater's eastern rim"] = "A borda leste da cratera de {area:279}",
	-- ["Torn Fin beach"] = "Praia dos Rancapina",
	-- ["West across the foothills to {area:287} town: the smithy stands in the middle of it. {npc:2404} and his apprentices work at the forge; the {object:1736} is stacked beside it."] = "Para oeste pelo sopé até a cidade de {area:287}: a ferraria fica no meio dela. {npc:2404} e os aprendizes dele trabalham na forja; {object:1736} está empilhado ao lado.",
	-- ["With a {item:3388} in your bags, {npc:2055} offers {quest:513} in the Apothecarium; {npc:2216} takes the elixir in {area:272}."] = "Com um {item:3388} nas bolsas, {npc:2055} oferece {quest:513} no Apothecarium; {npc:2216} recebe o elixir em {area:272}.",
	-- ["grind on {npc:2248}"] = "mate {npc:2248} até subir",
	-- ["grind on {npc:2562}"] = "mate {npc:2562} até subir",
	-- ["{area:272}'s {quest:544}, {quest:556} and {quest:676} are offered from level 30. Below it? Keep killing the yetis in these caves until level 30. Or, with a group, run the City of Dalaran dungeon instead."] = "As missões {quest:544}, {quest:556} e {quest:676} de {area:272} são oferecidas a partir do nível 30. Abaixo disso? Continue matando os yetis nestas cavernas até o nível 30. Ou, em grupo, faça a masmorra Cidade de Dalaran.",
	-- ["{area:321} flight master"] = "Mestre de voo de {area:321}",
	-- ["{area:321}'s quests are 32-36. Below 31? Keep killing the Boulderfist Ogres and Enforcers at this camp until level 31. Or, with a group, run the City of Dalaran dungeon instead."] = "As missões de {area:321} são de nível 32-36. Abaixo de 31? Continue matando os Ogros e Impositores Punho de Pedra neste acampamento até o nível 31. Ou, em grupo, faça a masmorra Cidade de Dalaran.",
	-- ["{item:278225}, from Plains Creepers"] = "{item:278225}, dos Rastejantes das Planícies",
	-- ["{item:279469}: an object to loot, by the traitors"] = "{item:279469}: um objeto para saquear, perto dos traidores",
	-- ["{item:3388}: auction house or an alchemist, for {quest:513}."] = "{item:3388}: casa de leilões ou um alquimista, para {quest:513}.",
	-- ["{item:3703}, for {npc:2333}"] = "{item:3703}, para {npc:2333}",
	-- ["{npc:12920}, at the south gate"] = "{npc:12920}, no portão sul",
	-- ["{npc:2229} now offers {npc:2316} (level 36), Bel'varil Bracers of Binding and Voidglare Dalaran Patrols: leave them for the 38-39 visit, which takes them on its first {area:272} stop."] = "{npc:2229} agora oferece {npc:2316} (nível 36), “Bel'varil Bracers of Binding” e “Voidglare Dalaran Patrols”: deixe-as para a visita dos níveis 38-39, que as pega na primeira parada em {area:272}.",
	-- ["{npc:2229} wants his two scouts freed from {area:275} before he trusts you with Infiltration."] = "{npc:2229} quer os dois batedores dele libertados de {area:275} antes de confiar Infiltração a você.",
	-- ["{npc:2410}, inside"] = "{npc:2410}, lá dentro",
	-- ["{npc:2410}, inside: offered from level 30"] = "{npc:2410}, lá dentro: oferecida a partir do nível 30",
	-- ["{npc:2410}: for the 38-39 visit to Alterac"] = "{npc:2410}: para a visita aos níveis 38-39 em Alterac",
	-- ["{npc:2410}: he offers {quest:545} after it"] = "{npc:2410}: ele oferece {quest:545} depois disso",
	-- ["{npc:2410}: {quest:93680}, the {item:279469} is by the traitors"] = "{npc:2410}: {quest:93680}; {item:279469} fica perto dos traidores",
	-- ["{npc:2437}, inside"] = "{npc:2437}, lá dentro",
	-- ["{npc:2437}, inside: offered from level 30"] = "{npc:2437}, lá dentro: oferecida a partir do nível 30",
	-- ["{npc:2437}: for the 38-39 visit to Alterac"] = "{npc:2437}: para a visita aos níveis 38-39 em Alterac",
	-- ["{npc:2706}'s Guile of the Raptor, {npc:2771}'s next {quest:677} and the doctor's Ward Restocking wait for the 38-39 visit."] = "A astúcia dos raptores de {npc:2706}, a próxima {quest:677} de {npc:2771} e o Reabastecimento de Proteção do doutor ficam para a visita dos níveis 38-39.",
	-- ["{npc:2706}: its Syndicate are by the road in from {area:272}, on the 38-39 visit"] = "{npc:2706}: a Camarilha de lá fica junto à estrada que vem de {area:272}, na visita dos níveis 38-39",
	-- ["{npc:2770}: for {npc:2771} in {area:321}, later in this guide (from level 30)"] = "{npc:2770}: para {npc:2771} em {area:321}, mais adiante neste guia (a partir do nível 30)",
	-- ["{npc:2792}, by the gate"] = "{npc:2792}, junto ao portão",
	-- ["{npc:3428} stands beside the Crossroads flight master."] = "{npc:3428} fica ao lado do mestre de voo da Encruzilhada.",
	-- ["{quest:513} needs a {item:3388}, an {skill:171} item: buy one at the auction house if you can (or ask an alchemist). The quest text says Strong, but it takes a {item:3388}. No elixir: skip the Elixir steps in {area:287}."] = "{quest:513} precisa de um {item:3388}, um item de {skill:171}: compre um na casa de leilões se puder (ou peça a um alquimista). O texto da missão diz Forte, mas ela pede um {item:3388}. Sem elixir: pule as etapas de Elixir em {area:287}.",
	-- ["{quest:515} with a group"] = "{quest:515} com um grupo",
}
