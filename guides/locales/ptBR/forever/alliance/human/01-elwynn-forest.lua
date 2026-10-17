-- Portuguese (Brazil) (ptBR): the guide forever/alliance/human/01-elwynn-forest (forever/alliance/human/01-elwynn-forest.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Northshire Abbey
	-- {npc:823} Deputy Willem · {npc:197} Marshal McBride · {npc:951} Brother Paxton · {npc:247229} Daniel · {npc:196} Eagan Peltskinner
	["You start in front of the Abbey. {npc:823} stands at the foot of the steps, {npc:197} inside the hall, {npc:951} and {npc:247229} in the library to the right, {npc:196} outside the north-west corner."] = "Você começa em frente à Abadia. {npc:823} fica ao pé da escadaria; {npc:197}, dentro do salão; {npc:951} e {npc:247229}, na biblioteca à direita; {npc:196}, do lado de fora, no canto noroeste.",
	-- {npc:459} Drusilla La Salle
	["{npc:459}, outside the Abbey"] = "{npc:459}, do lado de fora da Abadia",

	-- Step 2: Wolves
	["Wolves"] = "Lobos",
	["Young Wolves and Timber Wolves roam the fields right around the Abbey."] = "Lobos Jovens e Lobos Silvestres vagam pelos campos bem ao redor da Abadia.",

	-- Step 3: Eagan Peltskinner
	-- {npc:823} Deputy Willem
	["{npc:823}, back at the Abbey steps"] = "{npc:823}, de volta à escadaria da Abadia",

	-- Step 4: The kobold camp
	["The kobold camp"] = "O acampamento kobold",
	-- {npc:6} Kobold Vermin · {quest:91741} Nibbled-On Book
	["{npc:6} dig in the vineyards north-east of the Abbey. Now and then one drops a {quest:91741}: right-click it."] = "{npc:6} cavam nos vinhedos a nordeste da Abadia. De vez em quando um solta um {quest:91741}: clique nele com o botão direito.",

	-- Step 5: Northshire Abbey
	-- {npc:247229} Daniel
	["{npc:247229}, in the library"] = "{npc:247229}, na biblioteca",

	-- Step 6: Echo Ridge Mine
	-- {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["Follow the path north to the mine. Kobold Workers swarm outside it; every kobold in the valley can drop the {object:83763}."] = "Siga a trilha para o norte até a mina. Trabalhadores Kobold enxameiam do lado de fora; qualquer kobold do vale pode soltar {object:83763}.",

	-- Step 7: Northshire Abbey
	-- {npc:911} Llane Beshere
	["{npc:911}, the warrior trainer"] = "{npc:911}, o instrutor de guerreiros",
	-- {npc:925} Brother Sammuel
	["{npc:925}, the paladin trainer"] = "{npc:925}, o instrutor de paladinos",
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415}, by the Abbey"] = "{npc:248415}, perto da Abadia",
	-- {npc:915} Jorik Kerridan
	["{npc:915}, the rogue trainer"] = "{npc:915}, o instrutor de ladinos",
	-- {npc:375} Priestess Anetta
	["{npc:375}, the priest trainer"] = "{npc:375}, a instrutora de sacerdotes",
	-- {npc:198} Khelden Bremen
	["{npc:198}, the mage trainer, inside the Abbey"] = "{npc:198}, o instrutor de magos, dentro da Abadia",

	-- Step 8: The Defias camp
	["The Defias camp"] = "O acampamento Défias",
	-- plural, as words: Defias Thugs = {npc:38} Defias Thug
	["Defias Thugs camp in the clearing east of the Abbey and along the valley's east side."] = "Capangas Défias acampam na clareira a leste da Abadia e ao longo do lado leste do vale.",
	-- plural, as words: Red Burlap Bandanas = {item:752} Red Burlap Bandana
	["Red Burlap Bandanas"] = "Bandanas de Lona Vermelhas",
	-- {item:6785} Powers of the Void · {object:83763} Stolen Books
	["{item:6785}: the {object:83763} in the Defias camp"] = "{item:6785}: {object:83763} no acampamento Défias",

	-- Step 10: Milly Osworth
	["She stands by her cart at the vineyard east of the Abbey."] = "Ela fica junto à carroça, no vinhedo a leste da Abadia.",

	-- Step 11: The vineyards and Garrick Padfoot
	-- {npc:103} Garrick Padfoot
	["The vineyards and {npc:103}"] = "Os vinhedos e {npc:103}",
	-- {npc:103} Garrick Padfoot
	["The crates of grapes lie in the vineyards behind the Defias. {npc:103} waits by the cabin at the east end of the valley."] = "Os caixotes de uvas estão nos vinhedos, atrás dos Défias. {npc:103} espera junto à cabana no extremo leste do vale.",

	-- Step 13: Kelsey Fargo
	-- {npc:248362} Shinyfinder Narf
	["She stands outside the mine entrance. {npc:248362}, inside, is elite: grouping up is advised."] = "Ela fica do lado de fora da entrada da mina. {npc:248362}, lá dentro, é elite: recomenda-se formar um grupo.",

	-- Step 14: Inside Echo Ridge Mine
	-- {area:34} Echo Ridge Mine
	["Inside {area:34}"] = "Dentro de {area:34}",
	-- {npc:248362} Shinyfinder Narf
	-- plural, as words: Kobold Laborers = {npc:80} Kobold Laborer
	["Kobold Laborers work the tunnels inside the mine. {npc:248362} waits down the second turn on the right."] = "Operários Kobold trabalham nos túneis dentro da mina. {npc:248362} espera depois da segunda curva à direita.",

	-- Step 15: Northshire Abbey
	-- {npc:248415} Tordrin Sternblade
	["{npc:248415} stands behind the Abbey, by the stables."] = "{npc:248415} fica atrás da Abadia, perto dos estábulos.",
	-- {npc:952} Brother Neals
	["{npc:952}, upstairs"] = "{npc:952}, no andar de cima",
	-- {area:87} Goldshire
	["his kobold tracker shows the kobolds to click on the road to {area:87}"] = "o rastreador de kobolds dele mostra os kobolds para clicar na estrada para {area:87}",
	-- {npc:6774} Falkhaan Isenstrider
	["{npc:6774}, by the stables south of the Abbey"] = "{npc:6774}, perto dos estábulos ao sul da Abadia",

	-- Step 16: Goldshire
	-- {area:87} Goldshire · {npc:295} Innkeeper Farley · {npc:240} Marshal Dughan · {npc:253} William Pestle · {npc:241} Remy "Two Times"
	["Follow the road south out of the valley to {area:87}. {npc:295} is in the Lion's Pride Inn; {npc:240} stands outside the smithy across the road, {npc:253} at the inn's front and {npc:241} by the road south of it."] = "Siga a estrada para o sul, saindo do vale, até {area:87}. {npc:295} está na Estalagem do Leão Orgulhoso; {npc:240} fica do lado de fora da ferraria, do outro lado da estrada; {npc:253}, na frente da estalagem; e {npc:241}, junto à estrada ao sul dela.",

	-- Step 17: The lake shore
	["The lake shore"] = "A margem do lago",
	-- {npc:263399} Sam Sarsaparilla · {npc:6306} Helene Peltskinner · {npc:383} Jason Mathers · {npc:1651} Lee Brown · {area:18} Crystal Lake
	["{npc:263399} camps north-east of the inn; {npc:6306}, {npc:383} and {npc:1651} stand on the shore of {area:18} east of town."] = "{npc:263399} acampa a nordeste da estalagem; {npc:6306}, {npc:383} e {npc:1651} ficam na margem de {area:18}, a leste da cidade.",
	-- {spell:1229451} Boosted Rest
	["Sit (/sit) by his campfire until you have {spell:1229451}"] = "Sente-se (/sit) junto à fogueira dele até ganhar {spell:1229451}",
	-- {npc:6306} Helene Peltskinner
	["{npc:6306}: skinners only, the pelts are skinned"] = "{npc:6306}: só para esfoladores; as peles são esfoladas",

	-- Step 18: Crystal Lake
	-- plural, as words: Fishing Traps = {object:694772} Fishing Trap
	["The Fishing Traps sit along the west shore of the lake."] = "As armadilhas ({object:694772}) ficam ao longo da margem oeste do lago.",

	-- Step 20: The murloc camp
	["The murloc camp"] = "O acampamento murloc",
	-- plural, as words: Murloc Streamrunners = {npc:735} Murloc Streamrunner · Junk Piles = {object:694785} Junk Pile
	["Murlocs and Murloc Streamrunners hold the east shore; the Junk Piles lie in their camp."] = "Murlocs e Murlocs Corredores ocupam a margem leste; as Pilhas de Sucata ficam no acampamento deles.",

	-- Step 22: Goldshire
	-- {npc:1430} Tomas
	["{npc:1430} cooks in the inn's kitchen."] = "{npc:1430} cozinha na cozinha da estalagem.",
	-- {npc:1430} Tomas
	["Speak with {npc:1430}"] = "Fale com {npc:1430}",

	-- Step 23: Maybell Maclure
	-- {area:87} Goldshire · {area:64} Maclure Vineyards · {npc:251} Maybell Maclure
	["Follow the road south out of {area:87} to the {area:64}. {npc:251} waits by the house."] = "Siga a estrada para o sul, saindo de {area:87}, até {area:64}. {npc:251} espera junto à casa.",

	-- Step 24: The Fargodeep Mine
	-- {npc:248464} Nimsy
	-- plural, as words: Kobold Miners = {npc:40} Kobold Miner
	["The mine is west of the vineyards. Kobold Miners and Tunnelers fill both levels; {npc:248464}, a named kobold, holds the picture book in the lower tunnels. {npc:248464} is elite: grouping up is advised."] = "A mina fica a oeste dos vinhedos. Mineradores e Tuneleiros Kobold enchem os dois níveis; {npc:248464}, um kobold nomeado, guarda o livro ilustrado nos túneis inferiores. {npc:248464} é elite: recomenda-se formar um grupo.",
	["Walk through the mine"] = "Atravesse a mina",
	-- plural, as words: Large Candles = {item:772} Large Candle
	["Large Candles"] = "Velas Grandes",
	-- plural, as words: Lost Books = {item:248001} Lost Book · Kobold Miners = {npc:40} Kobold Miner
	["Lost Books: Kobold Miners and Tunnelers"] = "Livros Perdidos: Mineradores e Tuneleiros Kobold",
	-- {npc:248464} Nimsy
	["Fun with Elementals: {npc:248464}"] = "Diversão com Elementais: {npc:248464}",

	-- Step 25: Bait ingredients
	["Bait ingredients"] = "Ingredientes da isca",
	-- {object:694855} Overgrown Duskweed
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{object:694855} grows in the fields around the vineyards and the Stonefield farm; Stonetusk Boars around them give the blood."] = "{object:694855} cresce nos campos ao redor dos vinhedos e da fazenda dos Campedra; os Javalis Pedratusco por ali dão o sangue.",
	-- {item:286215} Vial of Animal Blood
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["{item:286215}: Stonetusk Boars"] = "{item:286215}: Javalis Pedratusco",

	-- Step 26: The Stonefield Farm
	["The Stonefield farm is west of the mine. Ma and \"Auntie\" Bernice stand by the house."] = "A fazenda dos Campedra fica a oeste da mina. Mama e \"Titia\" Berenice ficam junto à casa.",

	-- Step 27: Tommy Joe Stonefield
	["He stands by the river west of the farm."] = "Ele fica junto ao rio, a oeste da fazenda.",

	-- Step 28: Gramma Stonefield
	["She sits inside the farmhouse."] = "Ela fica sentada dentro da casa da fazenda.",

	-- Step 29: Billy Maclure
	-- {area:64} Maclure Vineyards
	["Billy plays in the {area:64}, east of the mine."] = "Guinho brinca em {area:64}, a leste da mina.",

	-- Step 30: Boar meat
	["Boar meat"] = "Carne de javali",
	-- plural, as words: Stonetusk Boars = {npc:113} Stonetusk Boar
	["Stonetusk Boars graze between the vineyards and the farm."] = "Javalis Pedratusco pastam entre os vinhedos e a fazenda.",
	["Chunks of Boar Meat"] = "Nacos de Carne de Javali",

	-- Step 31: "Auntie" Bernice Stonefield
	["\"Auntie\" Bernice Stonefield"] = "\"Titia\" Berenice Campedra",

	-- Step 33: Goldtooth
	-- {quest:87} Goldtooth · {area:57} Fargodeep Mine · {item:1972} Westfall Deed
	-- plural, as words: Defias Bandits = {npc:116} Defias Bandit
	["{quest:87} is inside the {area:57}, not on the hill above it: go in at the mouth and keep left to the back of the mine floor; don't take the stairs up. Defias Bandits around the vineyards drop a {item:1972} now and then: right-click it."] = "{quest:87} está dentro de {area:57}, não no morro acima dela: entre pela boca e mantenha-se à esquerda até o fundo do piso da mina; não suba as escadas. Bandidos Défias ao redor dos vinhedos soltam uma {item:1972} de vez em quando: clique nela com o botão direito.",

	-- Step 34: Goldshire
	-- {npc:279} Morgan Pestle · {zone:1453} Stormwind
	["{npc:279} in {zone:1453} takes it (02-westfall)"] = "{npc:279} em {zone:1453} recebe (02-westfall)",

	-- Step 35: Crystal Lake and the wolves
	-- {area:18} Crystal Lake
	["{area:18} and the wolves"] = "{area:18} e os lobos",
	-- {area:91} Tower of Azora
	-- plural, as words: Prowlers = {npc:118} Prowler
	["The murlocs on the east shore drop the kelp. Skinners: Gray Forest Wolves roam the woods between the lake and the {area:91}; Prowlers further east give pelts too."] = "Os murlocs da margem leste soltam a alga. Esfoladores: Lobos Cinza da Floresta vagam pelo bosque entre o lago e {area:91}; Predadores mais a leste também dão peles.",
	-- plural, as words: Crystal Kelp Fronds = {item:1256} Crystal Kelp Frond
	["Crystal Kelp Fronds"] = "Folhas de Cristalga",

	-- Step 36: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["{npc:248242} and {npc:248248} stand at the foot of the tower."] = "{npc:248242} e {npc:248248} ficam ao pé da torre.",

	-- Step 37: The bridge
	["The bridge"] = "A ponte",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it."] = "{npc:261} guarda a ponte na estrada para o leste; {npc:248265} fica logo do outro lado.",

	-- Step 38: Downstream and Princess
	-- {quest:91733} Downstream · {npc:330} Princess
	["{quest:91733} and {npc:330}"] = "{quest:91733} e {npc:330}",
	-- {item:247813} Waterlogged Saw · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch · {npc:390} Porcine Entourage
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["The {item:247813}, Axe and Toolbox lie in the river south of the bridge. {npc:330}, a big boar, roots in the {area:62} west of the river with her {npc:390}: pull the piglets away first. Kill Prowlers and Young Forest Bears on the way."] = "{item:247813}, o Machado Encharcado e a Caixa de Ferramentas Encharcada estão no rio ao sul da ponte. {npc:330}, uma javalina grande, fuça em {area:62}, a oeste do rio, com seu {npc:390}: afaste os leitões primeiro. Mate Predadores e Jovens Ursos da Floresta no caminho.",

	-- Step 40: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "O acampamento fica a nordeste da ponte. Feixes de Lenha estão espalhados pelo acampamento e pelo bosque ao norte dele.",

	-- Step 41: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Fica junto ao rio, a noroeste do acampamento madeireiro.",

	-- Step 42: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Teurgos Proscritos Défias acampam nas margens de {area:86}; eles também soltam as Bandanas de Linho Vermelhas. {object:56} está na aldeia murloc da margem nordeste.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Bandanas de Linho Vermelhas",

	-- Step 43: The gnoll camps
	["The gnoll camps"] = "Os acampamentos gnolls",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Gnolls Pata Molhada acampam nas colinas a oeste de {area:86}; {quest:91725} estão nos acampamentos deles.",

	-- Step 44: The Jasperlode Mine's entrance
	-- {quest:76} The Jasperlode Mine
	["{quest:76}'s entrance"] = "Entrada de {quest:76}",

	-- Step 45: The Jasperlode Mine
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "A mina fica a sudoeste dos acampamentos gnolls. {item:247816} estão perto da entrada; Geomantes Kobold ocupam os túneis.",
	["Walk into the mine"] = "Entre na mina",

	-- Step 46: The Tower of Azora
	["Follow the hills south to the tower."] = "Siga pelas colinas para o sul até a torre.",

	-- Step 48: Goldshire
	-- {area:87} Goldshire · {npc:6306} Helene Peltskinner
	["Follow the road west back to {area:87}; {npc:6306} and Jason stand on the lake shore before town."] = "Siga a estrada para o oeste de volta a {area:87}; {npc:6306} e Jasão ficam na margem do lago antes da cidade.",

	-- Step 49: Maybell Maclure
	-- {area:64} Maclure Vineyards
	["South down the road to the {area:64}."] = "Para o sul pela estrada até {area:64}.",

	-- Step 50: The Stonefield Farm
	-- {npc:894} Homer Stonefield · {quest:91736} Applejack Still
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Shiny Red Apples, from {npc:894}, for the {quest:91736}"] = "Maçãs Vermelhas Brilhantes, de {npc:894}, para {quest:91736}",

	-- Step 51: The Applejack Still
	-- {quest:91736} Applejack Still
	["The {quest:91736}"] = "{quest:91736}",
	-- {quest:91736} Applejack Still · {area:120} Westbrook Garrison · {item:247824} Thunder Applejack
	-- plural, as words: Shiny Red Apples = {item:4536} Shiny Red Apple
	["Head north-west across the fields to the {quest:91736}, north of the {area:120}. Hand it four Shiny Red Apples for a {item:247824}."] = "Siga para o noroeste pelos campos até {quest:91736}, ao norte de {area:120}. Coloque nele quatro Maçãs Vermelhas Brilhantes para obter um {item:247824}.",
	-- {item:247824} Thunder Applejack
	["{item:247824}, from the still"] = "{item:247824}, do alambique",

	-- Step 52: Westbrook Garrison
	-- {area:120} Westbrook Garrison · {zone:1436} Westfall · {npc:963} Deputy Rainer · {npc:955} Sergeant De Vries
	["Back south to the {area:120}, by the road to {zone:1436}. {npc:963} stands outside the barracks, {npc:955} beside him."] = "Volte para o sul até {area:120}, junto à estrada para {zone:1436}. {npc:963} fica do lado de fora do quartel; {npc:955}, ao lado dele.",
	-- {npc:955} Sergeant De Vries · {item:247824} Thunder Applejack
	["{npc:955}: he wants your {item:247824}"] = "{npc:955}: ele quer seu {item:247824}",

	-- Step 53: Forest's Edge
	-- {zone:1436} Westfall · {npc:100} Gruff Swiftbite · {item:1307} Gold Pickup Schedule
	-- plural, as words: Riverpaw Runts = {npc:97} Riverpaw Runt
	["Riverpaw Runts and Outrunners hold the hills south of the garrison, along the {zone:1436} border. {npc:100}, a level 12 gnoll, walks among them and carries the {item:1307}: right-click it."] = "Pata Molhada Miúdos e Vanguardeiros Pata Molhada ocupam as colinas ao sul da guarnição, ao longo da divisa com {zone:1436}. {npc:100}, um gnoll de nível 12, anda entre eles e carrega a {item:1307}: clique nela com o botão direito.",
	-- plural, as words: Painted Gnoll Armbands = {item:782} Painted Gnoll Armband
	["Painted Gnoll Armbands"] = "Braçadeiras Pintadas dos Gnolls",

	-- Step 56: Guard Thomas
	-- {area:91} Tower of Azora
	["Follow the road east past the {area:91} to the bridge."] = "Siga a estrada para o leste, passando por {area:91}, até a ponte.",

	-- Step 57: Murlocs and the Collector
	["Murlocs and the Collector"] = "Murlocs e o Coletor",
	-- {npc:473} Morgan the Collector · {area:62} Brackwell Pumpkin Patch · {npc:248278} Croaky
	-- plural, as words: Murloc Foragers = {npc:46} Murloc Forager · Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way. {npc:248278} roams the murloc shore too: right-click the head it drops. {npc:248278} is elite: grouping up is advised."] = "",
	-- plural, as words: Torn Murloc Fins = {item:780} Torn Murloc Fin
	["Torn Murloc Fins"] = "Barbatanas Rasgadas de Murloc",

	-- Step 58: Ridgepoint Tower
	-- {npc:248277} Merell Ross · {area:798} Ridgepoint Tower
	["{npc:248277} keeps watch at {area:798}, east of the murloc shore. Then head north-west back to the bridge."] = "",

	-- Step 61: Stone Cairn Lake
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["North-east of the logging camp. Defias Rogue Wizards camp on the shores of the lake."] = "A nordeste do acampamento madeireiro. Teurgos Proscritos Défias acampam nas margens do lago.",

	-- Step 62: The Tower of Azora
	["Follow the hills south to the tower, on the road west."] = "Siga pelas colinas para o sul até a torre, na estrada para o oeste.",

	-- Step 63: Goldshire
	-- {area:87} Goldshire
	["Follow the road west back to {area:87}."] = "Siga a estrada para o oeste de volta a {area:87}.",
	-- {npc:6121} Remen Marcot · {npc:6122} Gakin the Darkbinder · {zone:1453} Stormwind
	["{npc:6121}: {npc:6122} in {zone:1453} takes it"] = "{npc:6121}: {npc:6122} em {zone:1453} recebe",
	-- {npc:927} Brother Wilhelm · {npc:6171} Duthorian Rall · {zone:1453} Stormwind
	["{npc:927}: {npc:6171} in {zone:1453} takes it"] = "{npc:927}: {npc:6171} em {zone:1453} recebe",
	-- {npc:377} Priestess Josetta · {npc:376} High Priestess Laurena · {zone:1453} Stormwind
	["{npc:377}: {npc:376} in {zone:1453} takes both"] = "{npc:377}: {npc:376} em {zone:1453} recebe as duas",
	-- {npc:328} Zaldimar Wefhellt · {npc:5497} Jennea Cannon · {zone:1453} Stormwind
	["{npc:328}: {npc:5497} in {zone:1453} takes it"] = "{npc:328}: {npc:5497} em {zone:1453} recebe",

	-- Step 64: Taming the Beast
	-- {npc:251507} Josephine Carson · {area:87} Goldshire · {item:15908} Taming Rod · {area:64} Maclure Vineyards · {area:18} Crystal Lake
	-- plural, as words: Rockhide Boars = {npc:524} Rockhide Boar · Young Forest Bears = {npc:822} Young Forest Bear
	["{npc:251507} stands with the {area:87} trainers. Each of her quests hands you a {item:15908}: use it on the beast she names, then bring the rod back to her. Rockhide Boars and Young Forest Bears roam the hills south of the {area:64}, Gray Forest Wolves the woods east of {area:18}."] = "{npc:251507} fica com os instrutores de {area:87}. Cada missão dela lhe dá um {item:15908}: use-o na fera que ela indicar e traga o bastão de volta. Javalis Couropedra e Jovens Ursos da Floresta vagam pelas colinas ao sul de {area:64}; Lobos Cinza da Floresta, pelo bosque a leste de {area:18}.",
	-- {npc:524} Rockhide Boar · {item:15908} Taming Rod
	["{npc:524}: tame it with the {item:15908}"] = "{npc:524}: dome-o com o {item:15908}",
	-- {npc:1922} Gray Forest Wolf · {item:15908} Taming Rod
	["{npc:1922}: tame it with the {item:15908}"] = "{npc:1922}: dome-o com o {item:15908}",
	-- {npc:822} Young Forest Bear · {item:15908} Taming Rod
	["{npc:822}: tame it with the {item:15908}"] = "{npc:822}: dome-o com o {item:15908}",
	-- {npc:258930} Isaac Chan · {spell:5149} Beast Training
	["{npc:258930}, beside her: {spell:5149}"] = "{npc:258930}, ao lado dela: {spell:5149}",

	-- Step 65: Jennea Cannon
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:5497} Jennea Cannon · {object:2101} Mage Quarter · {quest:1861} Mirror Lake
	["Follow the road north from {area:87} into {zone:1453}. {npc:5497} stands in the Wizard's Sanctum, the tower of the {object:2101}; she gives you a flask for the {quest:1861} waterfall."] = "Siga a estrada para o norte, de {area:87} até {zone:1453}. {npc:5497} fica no Sacrário dos Teurgos, a torre de {object:2101}; ela lhe dá um frasco para a cachoeira de {quest:1861}.",

	-- Step 66: Mirror Lake
	-- {zone:1453} Stormwind · {quest:1861} Mirror Lake · {zone:1436} Westfall · {item:7207} Jennea's Flask
	["Leave {zone:1453} by the main gate. The {quest:1861} waterfall is south-west of the gates, on the way west to {zone:1436}: fill {item:7207} at its base."] = "Saia de {zone:1453} pelo portão principal. A cachoeira de {quest:1861} fica a sudoeste dos portões, no caminho para o oeste rumo a {zone:1436}: encha {item:7207} na base dela.",

	-- Step 67: Gakin the Darkbinder
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6122} Gakin the Darkbinder · {object:2164} Slaughtered Lamb · {object:2101} Mage Quarter
	["Follow the road north from {area:87} into {zone:1453}. {npc:6122} waits in the cellar of the {object:2164}, in the {object:2101}."] = "Siga a estrada para o norte, de {area:87} até {zone:1453}. {npc:6122} espera no porão de {object:2164}, em {object:2101}.",

	-- Step 68: Surena Caledon
	-- {area:87} Goldshire · {area:62} Brackwell Pumpkin Patch · {npc:881} Surena Caledon
	["Ride back out through {area:87} and east along the road to the {area:62}. {npc:881} (level 9) stands by its farmhouse."] = "Saia de novo passando por {area:87} e siga a estrada para o leste até {area:62}. {npc:881} (nível 9) fica junto à casa da fazenda.",

	-- Step 69: The Binding
	-- {npc:6122} Gakin the Darkbinder · {item:6928} Bloodstone Choker · {object:2164} Slaughtered Lamb
	["Back to {npc:6122}. Use the {item:6928} at the summoning circle in the {object:2164}'s cellar and defeat the voidwalker it calls."] = "De volta a {npc:6122}. Use o {item:6928} no círculo de evocação no porão de {object:2164} e derrote o emissário do caos que ele invocar.",
	["Subdue the voidwalker"] = "Subjugue o emissário do caos",

	-- Step 70: The Tome of Divinity
	-- {area:87} Goldshire · {zone:1453} Stormwind · {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2100} Old Town · {item:2589} Linen Cloth
	["Follow the road north from {area:87} into {zone:1453}. {npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in {object:2100} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "Siga a estrada para o norte, de {area:87} até {zone:1453}. {npc:6171} e {npc:6173} estão na Catedral da Luz; {npc:6174} fica em {object:2100} e pede dez {item:2589} (humanoides soltam; a Casa de Leilões vende).",
	-- {quest:2998} Tome of Divinity
	["From the {quest:2998} he gives you"] = "Do {quest:2998} que ele lhe dá",

	-- Step 71: Henze Faulk
	-- {area:87} Goldshire · {area:86} Stone Cairn Lake · {npc:6172} Henze Faulk · {item:6866} Symbol of Life · {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Ride back out through {area:87} and east to {area:86}. {npc:6172} lies south of the lake: use the {item:6866} on him. The Defias Rogue Wizards around him carry the {item:6846}."] = "Saia de novo passando por {area:87} e siga para o leste até {area:86}. {npc:6172} está caído ao sul do lago: use o {item:6866} nele. Os Teurgos Proscritos Défias ao redor dele carregam o {item:6846}.",
	-- {item:6866} Symbol of Life · {npc:6172} Henze Faulk
	["Use the {item:6866} on {npc:6172}"] = "Use o {item:6866} em {npc:6172}",
	-- {item:6846} Defias Script
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["{item:6846}: Defias Rogue Wizards"] = "{item:6846}: Teurgos Proscritos Défias",

	-- Step 72: Gazin Tenorm
	["Back to the Cathedral of Light."] = "De volta à Catedral da Luz.",
	-- {npc:6171} Duthorian Rall
	["{npc:6171}: Redemption"] = "{npc:6171}: Redenção",

	-- Step 73: Sentinel Hill
	-- {zone:1436} Westfall · {area:108} Sentinel Hill
	["Follow the road west past Westbrook into {zone:1436}, then south along it to {area:108}. Thor, the gryphon master, stands on the hill."] = "Siga a estrada para o oeste, passando pela Ribeira d'Oeste, até {zone:1436}; depois, para o sul por ela até {area:108}. Thor, o mestre de grifos, fica no morro.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Murloc Foragers and Lurkers line the river south of the bridge. {npc:473}, a Defias, walks the {area:62} west of it. Finish the Prowlers and Young Forest Bears on the way."] = "Murlocs Colhedores e Murlocs Tocaieiros ocupam o rio ao sul da ponte. {npc:473}, um Défias, anda por {area:62}, a oeste dele. Termine os Predadores e Jovens Ursos da Floresta no caminho.",
	-- ["{area:57}'s mouth"] = "Boca de {area:57}",
	-- ["{item:1006}: Princess"] = "{item:1006}: Princesa",
}
