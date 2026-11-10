-- Portuguese (Brazil) (ptBR): the guide forever/reputation/stormwind (forever/reputation/stormwind.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Stormwind Reputation"] = "Reputação: Ventobravo",
	-- {zone:1422} Western Plaguelands
	["Cloth, the {zone:1422}' cauldron quests and the Elwynn hubs: the quests pay most while you level."] = "Tecido, as missões dos caldeirões de {zone:1422} e os polos de Elwynn: as missões pagam mais enquanto você sobe de nível.",
	-- {faction:72} Stormwind
	["Exalted with {faction:72}: in Classic, other races may buy the horses"] = "Exaltado com {faction:72}: no Classic, outras raças podem comprar os cavalos",
	-- {faction:72} Stormwind · {area:3197} Chillwind Camp · {zone:1428} Burning Steppes
	["About 1,150 {faction:72} reputation from level 52-58 quests at {area:3197} and in the {zone:1428}"] = "Cerca de 1.150 de reputação com {faction:72} das missões de nível 52-58 em {area:3197} e em {zone:1428}",
	-- {faction:72} Stormwind · {area:717} Stockade
	["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717}"] = "Cerca de 4.500 de reputação de {faction:72} com missões de nível baixo em Elwynn e em {area:717}",

	-- Step 1: Clavicus Knavingham, the cloth quartermaster
	-- {npc:14722} Clavicus Knavingham
	["{npc:14722}, the cloth quartermaster"] = "{npc:14722}, o intendente de tecido",
	-- {npc:14722} Clavicus Knavingham · {faction:72} Stormwind · {item:14047} Runecloth · {quest:7796} Additional Runecloth · {zone:1436} Westfall · {zone:1431} Duskwood · {zone:1422} Western Plaguelands · {zone:1428} Burning Steppes · {area:717} Stockade · {area:87} Goldshire · {zone:1455} Ironforge · {zone:1457} Darnassus
	["{npc:14722} takes cloth for {faction:72}. The arrow leads to him; he stands upstairs inside his building. Each first donation of 60 Wool, Silk, Mageweave and {item:14047} pays 150 reputation once; after the {item:14047} one, {quest:7796} pays 50 for every 20 {item:14047}, as often as you like. The Auction House is the quickest source of cloth. In Classic, quests pay full reputation while they are at most 5 levels below you, so do Elwynn (levels 1-10), {zone:1436} (10-18), Redridge (15-25) and {zone:1431} (20-30) while you level through them. After the donations come the level 52-58 quests of the {zone:1422} and the {zone:1428} (about 1,150), then the optional low-level hubs, best rate first: Northshire and the city errands (about 40 a minute at full value), the {area:717} (30), Eastvale and {area:87} (25). Every {faction:72} gain also gives a quarter as much to {zone:1455}, {zone:1457} and the Gnomeregan Exiles, except quests in the level 1-10 start areas. Legacy Diplomat adds up to 10% to every gain."] = "{npc:14722} aceita tecido para {faction:72}. A seta leva até ele; ele fica no andar de cima, dentro do prédio dele. Cada primeira doação de 60 Lã, Seda, Tecido Arcano e {item:14047} paga 150 de reputação uma vez; depois da doação de {item:14047}, {quest:7796} paga 50 a cada 20 {item:14047}, quantas vezes você quiser. A Casa de Leilões é a fonte mais rápida de tecido. No Classic, as missões pagam reputação cheia enquanto estiverem no máximo 5 níveis abaixo de você, então faça Elwynn (níveis 1-10), {zone:1436} (10-18), Cristarrubra (15-25) e {zone:1431} (20-30) enquanto sobe de nível por elas. Depois das doações vêm as missões de nível 52-58 de {zone:1422} e de {zone:1428} (cerca de 1.150), então os polos opcionais de nível baixo, do melhor ritmo ao pior: Vila Norte e os recados da cidade (cerca de 40 por minuto com valor cheio), {area:717} (30), Madeireira Vale do Leste e {area:87} (25). Todo ganho com {faction:72} também dá um quarto disso para {zone:1455}, {zone:1457} e os Exilados de Gnomeregan, exceto missões das áreas iniciais de nível 1-10. O Legado Diplomata soma até 10% a cada ganho.",
	-- {item:2592} Wool Cloth · {zone:1436} Westfall
	["{item:2592}: Defias, gnolls and kobolds in {zone:1436} and Redridge"] = "{item:2592}: Défias, gnolls e kobolds em {zone:1436} e Cristarrubra",

	-- Step 2: Stormwind errands
	-- {faction:72} Stormwind
	["{faction:72} errands"] = "Recados de {faction:72}",
	-- {faction:72} Stormwind
	["Optional: four quick deliveries inside {faction:72} for 200 reputation in about five minutes. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: quatro entregas rápidas dentro de {faction:72} por 200 de reputação em cerca de cinco minutos. O Forever paga estas missões antigas por inteiro em qualquer nível. Pule este passo para pular o polo.",

	-- Step 3: Northshire Valley
	-- {area:87} Goldshire · {npc:823} Deputy Willem · {npc:197} Marshal McBride · {area:24} Northshire Abbey
	["Optional: the Human start valley north of {area:87}: about 1,600 reputation in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: o vale inicial dos humanos ao norte de {area:87}: cerca de 1.600 de reputação em 40 minutos no 60, a melhor taxa entre os polos. {npc:823} e {npc:197} ficam em {area:24}. O Forever paga estas missões antigas por inteiro em qualquer nível. Pule este passo para pular o polo.",

	-- Step 4: Northshire: kobolds, wolves and bandanas
	["Northshire: kobolds, wolves and bandanas"] = "Vila Norte: kobolds, lobos e bandanas",
	-- {npc:6} Kobold Vermin · {item:247834} Nibbled-On Book
	["The {npc:6} dig at the camp north of the abbey; the wolves roam the valley; the Defias at the vineyard east of the abbey drop the bandanas. Keep any {item:247834} a kobold drops: it starts Forever's book chain."] = "Os {npc:6} cavam no acampamento ao norte da abadia; os lobos vagam pelo vale; os Défias no vinhedo a leste da abadia soltam as bandanas. Guarde qualquer {item:247834} que um kobold soltar: ele começa a cadeia de livros do Forever.",
	-- {item:247834} Nibbled-On Book
	["{item:247834}, from the kobolds"] = "{item:247834}, dos kobolds",

	-- Step 5: Northshire: back at the abbey
	["Northshire: back at the abbey"] = "Vila Norte: de volta à abadia",

	-- Step 6: Northshire: Echo Ridge, Garrick Padfoot and the vineyard
	-- {npc:103} Garrick Padfoot
	["Northshire: Echo Ridge, {npc:103} and the vineyard"] = "Vila Norte: Serra do Eco, {npc:103} e o vinhedo",
	-- {area:34} Echo Ridge Mine · {npc:103} Garrick Padfoot · {quest:3904} Milly's Harvest · {object:83763} Stolen Books
	-- plural, as words: Kobold Workers = {npc:257} Kobold Worker
	["The Kobold Workers are in {area:34} north of the abbey; {npc:103} stands in the Defias camp east of the vineyard; {quest:3904} crates lie in the vineyard; the rats carrying the {object:83763} run about the abbey grounds."] = "Os Trabalhadores Kobolds ficam em {area:34}, ao norte da abadia; {npc:103} fica no acampamento dos Défias a leste do vinhedo; as caixas de {quest:3904} estão no vinhedo; os ratos que carregam o {object:83763} correm pelos terrenos da abadia.",

	-- Step 7: Northshire: second hand-in
	["Northshire: second hand-in"] = "Vila Norte: segunda entrega",

	-- Step 8: Northshire: the mine and the books
	["Northshire: the mine and the books"] = "Vila Norte: a mina e os livros",
	-- {npc:80} Kobold Laborer · {area:34} Echo Ridge Mine
	["{npc:80}, deep in {area:34}"] = "{npc:80}, no fundo de {area:34}",

	-- Step 9: Northshire: last hand-in
	["Northshire: last hand-in"] = "Vila Norte: última entrega",
	-- {object:563442} Kobold Tracks
	["{object:563442}, east of the abbey"] = "{object:563442}, a leste da abadia",

	-- Step 10: Northshire: the books end in Goldshire
	-- {area:87} Goldshire
	["Northshire: the books end in {area:87}"] = "Vila Norte: os livros terminam em {area:87}",
	-- {npc:240} Marshal Dughan · {area:87} Goldshire · {area:57} Fargodeep Mine
	-- plural, as words: Lost Books = {item:248001} Lost Book
	["{npc:240} stands in front of the Lion's Pride Inn in {area:87}. The Lost Books drop from the kobolds of {area:57} south of {area:87}; the picture book and the two rare books from the named kobolds there."] = "{npc:240} fica diante da Estalagem Orgulho do Leão, em {area:87}. Os Livros Perdidos caem dos kobolds de {area:57}, ao sul de {area:87}; o livro de gravuras e os dois livros raros, dos kobolds nomeados de lá.",
	["Arcane Explainer"] = "Explicador Arcano",
	-- {npc:951} Brother Paxton
	["{npc:951}, back at the abbey"] = "{npc:951}, de volta à abadia",

	-- Step 11: Goldshire
	-- {area:87} Goldshire · {npc:240} Marshal Dughan · {npc:241} Remy "Two Times" · {npc:253} William Pestle
	["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: {area:87}, Ribeira d'Oeste e as fazendas ao sul de {area:87}: cerca de 1.450 de reputação em uma hora no 60. {npc:240}, {npc:241} e {npc:253} ficam ao redor da Estalagem Orgulho do Leão. O Forever paga estas missões antigas por inteiro em qualquer nível. Pule este passo para pular o polo.",

	-- Step 12: Goldshire: the mines
	-- {area:87} Goldshire
	["{area:87}: the mines"] = "{area:87}: as minas",
	-- {area:57} Fargodeep Mine · {area:87} Goldshire · {area:54} Jasperlode Mine · {item:773} Gold Dust
	["{area:57} is south of {area:87}, {area:54} north-east of it. The kobolds in both drop the candles and the {item:773}; the wolves around {area:87} the pelts."] = "{area:57} fica ao sul de {area:87}, {area:54} a nordeste dela. Os kobolds das duas soltam as velas e o {item:773}; os lobos ao redor de {area:87}, as peles.",

	-- Step 13: Goldshire: back at the inn
	-- {area:87} Goldshire
	["{area:87}: back at the inn"] = "{area:87}: de volta à estalagem",

	-- Step 14: Goldshire: Jasperlode Mine
	["walk into the mine"] = "entre na mina",

	-- Step 15: Goldshire: Westbrook and Hogger
	-- {area:87} Goldshire · {npc:448} Hogger
	["{area:87}: Westbrook and {npc:448}"] = "{area:87}: Ribeira d'Oeste e {npc:448}",
	-- {npc:448} Hogger · {area:120} Westbrook Garrison
	["{npc:448} is an elite gnoll west of {area:120}; at 60 he is no trouble. The Wanted poster hangs on the garrison."] = "{npc:448} é um gnoll de elite a oeste de {area:120}; no 60 ele não dá trabalho. O cartaz de PROCURA-SE fica pendurado na guarnição.",
	-- {item:782} Painted Gnoll Armband
	["{item:782}, from the Riverpaw gnolls"] = "{item:782}, dos gnolls Rio Pata",
	-- {item:1931} Huge Gnoll Claw · {npc:448} Hogger
	["{item:1931}, from {npc:448}"] = "{item:1931}, de {npc:448}",

	-- Step 16: The farms south of Goldshire
	-- {area:87} Goldshire
	["The farms south of {area:87}"] = "As fazendas ao sul de {area:87}",
	-- {area:87} Goldshire · {quest:87} Goldtooth · {area:57} Fargodeep Mine · {npc:330} Princess · {area:62} Brackwell Pumpkin Patch
	["The Stonefields' farm and the Maclures' farm lie on either side of the road south of {area:87}. {quest:87} guards the back of {area:57}; {npc:330} the boar roams the {area:62}."] = "A fazenda dos Campedra e a fazenda dos Madruga ficam dos dois lados da estrada ao sul de {area:87}. {quest:87} guarda o fundo de {area:57}; {npc:330}, o javali, vaga por {area:62}.",
	-- {item:1006} Brass Collar · {npc:330} Princess
	["{item:1006}, from {npc:330}"] = "{item:1006}, de {npc:330}",

	-- Step 17: Goldtooth and the kelp
	-- {quest:87} Goldtooth
	["{quest:87} and the kelp"] = "{quest:87} e as algas",
	-- {item:981} Bernice's Necklace · {quest:87} Goldtooth
	["{item:981}, from {quest:87}"] = "{item:981}, de {quest:87}",
	-- {item:1256} Crystal Kelp Frond · {area:18} Crystal Lake
	["{item:1256}, from the murlocs of {area:18}"] = "{item:1256}, dos murlocs de {area:18}",

	-- Step 18: Goldshire: last hand-in
	-- {area:87} Goldshire
	["{area:87}: last hand-in"] = "{area:87}: última entrega",

	-- Step 19: Shipment to Stormwind
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, in the {object:2096}"] = "{npc:279}, no {object:2096}",

	-- Step 20: Eastvale
	["Eastvale"] = "Vale do Leste",
	-- {npc:261} Guard Thomas · {area:91} Tower of Azora
	["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation in 40 minutes at 60. Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: o leste de Elwynn, ao redor de {npc:261} na ponte e de {area:91}, cerca de 1.000 de reputação em 40 minutos no 60. O Forever paga estas missões antigas por inteiro em qualquer nível. Pule este passo para pular o polo.",

	-- Step 21: Eastvale: the work
	["Eastvale: the work"] = "Vale do Leste: o trabalho",
	-- {area:91} Tower of Azora · {area:54} Jasperlode Mine
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear · Kobold Geomancers = {npc:476} Kobold Geomancer
	["The murlocs along the river south of the bridge drop the fins; Prowlers and Young Forest Bears roam the woods; the Defias around the Brackwell farm and the {area:91} carry the bandanas; the enchanting supplies lie in their camps north of the tower; the Kobold Geomancers dig at {area:54}; the tools and the river finds lie along the river north of the logging camp."] = "Os murlocs ao longo do rio, ao sul da ponte, soltam as nadadeiras; Predadores e Jovens Ursos da Floresta vagam pelos bosques; os Défias ao redor da fazenda dos Braga e de {area:91} carregam as bandanas; os suprimentos de encantamento estão nos acampamentos deles, ao norte da torre; os Geomantes Kobolds cavam em {area:54}; as ferramentas e os achados do rio estão ao longo do rio, ao norte da madeireira.",

	-- Step 22: Eastvale: hand in
	["Eastvale: hand in"] = "Vale do Leste: entregar",

	-- Step 23: Eastvale: Defias Rogue Wizards
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard
	["Eastvale: Defias Rogue Wizards"] = "Vale do Leste: Teurgos Proscritos Défias",
	["opens with Thomas' report"] = "abre com o relatório de Thomas",
	-- {item:780} Torn Murloc Fin
	["{item:780}, from the murlocs south of the bridge"] = "{item:780}, dos murlocs ao sul da ponte",

	-- Step 24: Stockade: two quests
	-- {area:717} Stockade
	["{area:717}: two quests"] = "{area:717}: duas missões",
	-- {area:717} Stockade · {faction:72} Stormwind · {object:2101} Mage Quarter · {npc:1719} Warden Thelwater · {npc:1721} Nikova Raskol · {object:2100} Old Town · {npc:1696} Targorr the Dread · {npc:859} Guard Berton · {area:69} Lakeshire · {npc:1663} Dextren Ward · {npc:270} Councilman Millstipe · {area:42} Darkshire · {npc:639} Edwin VanCleef · {area:1581} Deadmines
	["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation. {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) Forever pays these old quests in full at any level. Skip this step to skip the hub."] = "Opcional: {area:717} é a prisão de {faction:72}, uma masmorra nos canais de {object:2101}. No 60 você a limpa sozinho em dez minutos: 300 de reputação. {npc:1719} fica no portão, {npc:1721} em {object:2100}. Mais duas missões de {area:717} começam fora da cidade, 100 cada, se você passar por lá: Tudo que vai... ({npc:1696}), de {npc:859} em {area:69}, e Crime e castigo ({npc:1663}), de {npc:270} em {area:42}. (Rebelião no Cárcere, mais 100, exige antes a Carta Não Enviada de {npc:639} em {area:1581}.) O Forever paga estas missões antigas por inteiro em qualquer nível. Pule este passo para pular o polo.",

	-- Step 25: Inside the Stockade
	-- {area:717} Stockade
	["Inside the {area:717}"] = "Dentro de {area:717}",
	-- {npc:1716} Bazil Thredd
	-- plural, as words: Red Wool Bandanas = {item:2909} Red Wool Bandana
	["Kill the prisoners, convicts and insurgents in the cells; the Red Wool Bandanas drop from the Defias inside. {npc:1716} waits in the far end."] = "Mate os prisioneiros, condenados e insurgentes nas celas; as Bandanas Vermelhas de Lã caem dos Défias lá dentro. {npc:1716} espera no fundo.",

	-- Step 26: Stockade: hand in
	-- {area:717} Stockade
	["{area:717}: hand in"] = "{area:717}: entregar",

	-- Step 27: A Donation of Silk
	-- {item:4306} Silk Cloth · {area:94} Raven Hill
	["{item:4306} drops from humanoids level 23 to 40: Syndicate in Alterac and Arathi, the Defias of Duskwood's {area:94}, Stranglethorn's trolls."] = "{item:4306} cai de humanoides de nível 23 a 40: a Camarilha em Alterac e Arathi, os Défias de {area:94} na Floresta do Crepúsculo, os trolls da Selva do Espinhaço.",

	-- Step 28: A Donation of Mageweave
	-- {item:4338} Mageweave Cloth · {zone:1446} Tanaris · {zone:1444} Feralas · {zone:1418} Badlands
	["{item:4338} drops from humanoids level 35 to 50: the Dunemaul ogres of {zone:1446}, the Hatecrest naga of {zone:1444}, the Shadowforge dwarves of the {zone:1418}."] = "{item:4338} cai de humanoides de nível 35 a 50: os ogros Dunamalho de {zone:1446}, os nagas Cristafúria de {zone:1444}, os anões Umbraforja de {zone:1418}.",

	-- Step 29: A Donation of Runecloth
	-- {item:14047} Runecloth · {zone:1448} Felwood · {zone:1452} Winterspring · {quest:7796} Additional Runecloth
	["{item:14047} drops from humanoids level 50 and up: the Scourge cultists and Scarlet Crusade in the Plaguelands, the Deadwood furbolgs of {zone:1448}, the Winterfall furbolgs of {zone:1452}. Keep any {item:14047} past the first 60: it all goes to {quest:7796} later."] = "{item:14047} cai de humanoides de nível 50 ou mais: os sectários do Flagelo e a Cruzada Escarlate nas Terras Pestilentas, os furbolgs Lenha Morta de {zone:1448}, os furbolgs Invernosos de {zone:1452}. Guarde qualquer {item:14047} além dos primeiros 60: tudo vai para {quest:7796} depois.",

	-- Step 30: Chillwind Camp: Clear the Way
	-- {npc:10838} Commander Ashlam Valorfist · {npc:11053} High Priestess MacDonnell · {area:3197} Chillwind Camp · {zone:1422} Western Plaguelands · {faction:72} Stormwind · {object:92525} Argent Dawn (no name in this language: may be words)
	-- plural, as words: Skeletal Flayers = {npc:1783} Skeletal Flayer · Slavering Ghouls = {npc:1791} Slavering Ghoul
	["These quests are level 52 to 58, so they pay in full at 60. {npc:10838} and {npc:11053} at {area:3197}, in the south of the {zone:1422}, send you against the four Scourge cauldrons: 820 {faction:72} reputation in all and 600 {object:92525} on the side. The Skeletal Flayers and Slavering Ghouls roam the fields north of the camp."] = "Essas missões são de nível 52 a 58, então pagam o valor cheio no 60. {npc:10838} e {npc:11053}, em {area:3197}, no sul de {zone:1422}, mandam você contra os quatro Caldeirões do Flagelo: 820 de reputação com {faction:72} no total e mais 600 {object:92525}. Os Esfoladores Descarnados e Carniçais Salivantes vagam pelos campos ao norte do acampamento.",

	-- Step 31: Andorhal and Felstone Field
	-- {area:199} Felstone Field
	["Andorhal and {area:199}"] = "Andorhal e {area:199}",
	-- {item:12815} Beacon Torch · {npc:11075} Cauldron Lord Bilemaw · {area:199} Felstone Field · {npc:10778} Janice Felstone · {faction:72} Stormwind
	["Mark the four watchtowers around Andorhal, north of the camp, with the {item:12815} at each door. {npc:11075} guards the cauldron at {area:199}, west of Andorhal; his key opens it. {npc:10778}'s ghost wanders by the Felstone farmhouse, and her parcel lies inside: it goes to {faction:72} for 150 more."] = "Marque as quatro torres de vigia ao redor de Andorhal, ao norte do acampamento, com a {item:12815} em cada porta. {npc:11075} guarda o caldeirão em {area:199}, a oeste de Andorhal; a chave dele o abre. O fantasma de {npc:10778} vaga pela casa de fazenda de Felstone, e o pacote dela está lá dentro: ele vai para {faction:72} por mais 150.",
	-- {npc:10902} Andorhal Tower One · {item:12815} Beacon Torch
	["Mark {npc:10902} with the {item:12815}"] = "Marque a {npc:10902} com a {item:12815}",
	-- {npc:10903} Andorhal Tower Two · {item:12815} Beacon Torch
	["Mark {npc:10903} with the {item:12815}"] = "Marque a {npc:10903} com a {item:12815}",
	-- {npc:10904} Andorhal Tower Three · {item:12815} Beacon Torch
	["Mark {npc:10904} with the {item:12815}"] = "Marque a {npc:10904} com a {item:12815}",
	-- {npc:10905} Andorhal Tower Four · {item:12815} Beacon Torch
	["Mark {npc:10905} with the {item:12815}"] = "Marque a {npc:10905} com a {item:12815}",
	-- {item:13194} Felstone Field Cauldron Key · {npc:11075} Cauldron Lord Bilemaw
	["{item:13194}, from {npc:11075}"] = "{item:13194}, de {npc:11075}",
	-- {object:176361} Scourge Cauldron
	["the {object:176361}"] = "o {object:176361}",
	-- {object:175894} Janice's Parcel
	["{object:175894}, in the farmhouse"] = "{object:175894}, na casa de fazenda",

	-- Step 33: Dalson's Tears
	-- {npc:11077} Cauldron Lord Malvinious · {area:200} Dalson's Tears · {area:199} Felstone Field
	["{npc:11077} guards the cauldron at {area:200}, north-east of {area:199}."] = "{npc:11077} guarda o caldeirão em {area:200}, a nordeste de {area:199}.",
	-- {object:177289} Scourge Cauldron
	["the {object:177289}"] = "o {object:177289}",

	-- Step 34: Chillwind Camp: the Writhing Haunt
	-- {area:3197} Chillwind Camp · {area:202} Writhing Haunt
	["{area:3197}: the {area:202}"] = "{area:3197}: {area:202}",

	-- Step 35: Writhing Haunt
	-- {npc:11076} Cauldron Lord Razarch · {area:202} Writhing Haunt · {area:200} Dalson's Tears
	["{npc:11076} guards the cauldron at the {area:202}, the farm east of {area:200}."] = "{npc:11076} guarda o caldeirão em {area:202}, a fazenda a leste de {area:200}.",
	-- {object:176393} Scourge Cauldron
	["the {object:176393}"] = "o {object:176393}",

	-- Step 37: Gahrron's Withering
	-- {npc:11078} Cauldron Lord Soulwrath · {area:201} Gahrron's Withering
	["{npc:11078} guards the cauldron at {area:201}, in the east of the zone."] = "{npc:11078} guarda o caldeirão em {area:201}, no leste da zona.",
	-- {object:176392} Scourge Cauldron
	["the {object:176392}"] = "o {object:176392}",

	-- Step 38: Chillwind Camp: done
	-- {area:3197} Chillwind Camp
	["{area:3197}: done"] = "{area:3197}: concluído",
	-- {npc:11056} Alchemist Arbington · {area:2057} Scholomance
	["{npc:11056} in the camp also ends The Key to {area:2057} (200), after a longer chain that needs a {area:2057} group."] = "{npc:11056}, no acampamento, também conclui A Chave para {area:2057} (200), depois de uma cadeia mais longa que exige um grupo de {area:2057}.",

	-- Step 39: Stormwind: Janice Felstone's parcel
	-- {faction:72} Stormwind · {npc:10778} Janice Felstone
	["{faction:72}: {npc:10778}'s parcel"] = "{faction:72}: o pacote de {npc:10778}",
	-- {npc:10782} Royal Factor Bathrilor · {object:2098} Cathedral Square · {npc:1646} Baros Alexston · {npc:3520} Ol' Emma
	["{npc:10782} stands in the city hall on {object:2098}, beside {npc:1646}; {npc:3520} walks the canals."] = "{npc:10782} fica na prefeitura, em {object:2098}, ao lado de {npc:1646}; {npc:3520} anda pelos canais.",

	-- Step 40: Morgan's Vigil: Dragonkin Menace
	-- {npc:9562} Helendis Riverhorn · {area:2418} Morgan's Vigil · {zone:1428} Burning Steppes · {quest:4183} The True Masters · {area:69} Lakeshire · {object:2117} Stormwind Keep · {faction:72} Stormwind · {zone:1457} Darnassus · {npc:7044} Black Drake · {npc:7040} Black Dragonspawn · {npc:7041} Black Wyrmkin
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["{npc:9562} at {area:2418}, in the south-east of the {zone:1428}, starts {quest:4183}: a chain to {area:69} and {object:2117}, 175 {faction:72} and 175 {zone:1457} reputation (level 54). The Black Broodlings and the {npc:7044} live on the slopes north of the Vigil; the {npc:7040} and {npc:7041} west of it, in the middle of the zone."] = "{npc:9562} em {area:2418}, no sudeste de {zone:1428}, começa {quest:4183}: uma cadeia até {area:69} e {object:2117}, 175 de reputação com {faction:72} e 175 com {zone:1457} (nível 54). Os Filhotes Negros e o {npc:7044} vivem nas encostas ao norte da Vigília; {npc:7040} e {npc:7041} a oeste dela, no meio da zona.",

	-- Step 41: Lakeshire: Magistrate Solomon
	-- {npc:344} Magistrate Solomon · {area:69} Lakeshire
	["{npc:344} waits in the town hall of {area:69}."] = "{npc:344} espera na prefeitura de {area:69}.",

	-- Step 42: Stormwind Keep
	-- {npc:1748} Highlord Bolvar Fordragon · {object:2117} Stormwind Keep · {npc:1749} Lady Katrana Prestor
	["{npc:1748} holds court in {object:2117} with {npc:1749} at his side: speak with her for the second of his quests."] = "{npc:1748} recebe na {object:2117}, com {npc:1749} ao lado dele: fale com ela para a segunda missão dele.",
	-- {npc:1749} Lady Katrana Prestor
	["Speak with {npc:1749}"] = "Fale com {npc:1749}",

	-- Step 43: Lakeshire: Solomon again
	-- {area:69} Lakeshire
	["{area:69}: Solomon again"] = "{area:69}: Salomão de novo",
	-- {area:1584} Blackrock Depths · {npc:9023} Marshal Windsor · {faction:72} Stormwind · {area:1583} Blackrock Spire · {npc:11878} Nathanos Blightcaller · {zone:1423} Eastern Plaguelands · {area:2057} Scholomance
	["With a group the chain goes on into {area:1584}: {npc:9023}, Jail Break! and The Great Masquerade back in {faction:72} pay about 750 {faction:72} more, Maxwell's Mission (Lower {area:1583}) 250, Delivery to Ridgewell 135. Order Must Be Restored ({npc:11878} in the {zone:1423}) pays 200, The Key to {area:2057} 200; Onyxia's head 400 and Nefarian's 200 when the raids open."] = "Com um grupo, a cadeia continua em {area:1584}: {npc:9023}, Fuga da prisão! e O grande baile de máscaras, de volta em {faction:72}, pagam cerca de 750 a mais com {faction:72}; A missão de Maxwell ({area:1583} inferior) 250, Entrega para Espargosa 135. A restauração da ordem ({npc:11878} em {zone:1423}) paga 200, A Chave para {area:2057} 200; a cabeça de Onyxia 400 e a de Nefarian 200 quando as raides abrirem.",

	-- Step 44: Additional Runecloth to Honored
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Honored"] = "{quest:7796} até Honrado",
	-- {quest:7796} Additional Runecloth · {item:14047} Runecloth · {faction:72} Stormwind · {zone:1436} Westfall · {area:69} Lakeshire · {zone:1431} Duskwood · {area:42} Darkshire
	["{quest:7796}: 50 reputation for 20 {item:14047}, as often as you like. After the four first donations a non-Human stands at Friendly 700 of 6,000, so Honored is 5,300 away: 106 turn-ins, 2,120 {item:14047} (Humans start 900 higher: 88 turn-ins; a Skyborne's Exploring the Alliance paid 100, two fewer). The level 52-58 quests above take 23 turn-ins off; every Elwynn hub you did takes 20 to 30 more off. More quest hubs pay {faction:72}, in full while they are no more than 5 levels below you: {zone:1436} (about 2,500 in all), Redridge's {area:69} (about 3,000) and {zone:1431}'s {area:42} (about 2,900). Every city gain also gives a quarter as much to the other three Alliance cities (not counted here). Hand in all your {item:14047} at once."] = "{quest:7796}: 50 de reputação por 20 {item:14047}, quantas vezes você quiser. Depois das quatro primeiras doações, quem não é humano está em Amigável 700 de 6.000, então Honrado está a 5.300: 106 entregas, 2.120 {item:14047} (humanos começam 900 acima: 88 entregas; Explorando a Aliança de um Celonato pagava 100, duas a menos). As missões de nível 52-58 acima tiram 23 entregas; cada polo de Elwynn que você fez tira de 20 a 30 a mais. Mais polos de missões pagam {faction:72}, por inteiro enquanto estiverem no máximo 5 níveis abaixo de você: {zone:1436} (cerca de 2.500 ao todo), {area:69} de Cristarrubra (cerca de 3.000) e {area:42} de {zone:1431} (cerca de 2.900). Todo ganho de cidade também dá um quarto disso às outras três cidades da Aliança (não contado aqui). Entregue todos os seus {item:14047} de uma vez.",

	-- Step 45: Additional Runecloth to Revered
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Revered"] = "{quest:7796} até Reverenciado",
	-- {npc:384} Katie Hunter · {item:14047} Runecloth
	["Honored: in Classic Stormwind's vendors take 10% off for you, {npc:384}'s horses (20g, the swift ones 200g) included; Forever has not settled it, and guide sites report 5% at Friendly rising to 20% at Exalted. Honored to Revered is 12,000 reputation: 240 turn-ins, 4,800 {item:14047}."] = "Honrado: no Classic, os mercadores de Ventobravo dão 10% de desconto a você, inclusive nos cavalos de {npc:384} (20 de ouro, os velozes 200 de ouro); o Forever ainda não definiu isso, e sites de guias relatam 5% em Amigável, subindo até 20% em Exaltado. De Honrado a Reverenciado são 12.000 de reputação: 240 entregas, 4.800 {item:14047}.",

	-- Step 46: Additional Runecloth to Exalted
	-- {quest:7796} Additional Runecloth
	["{quest:7796} to Exalted"] = "{quest:7796} até Exaltado",
	-- {item:14047} Runecloth · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp
	["Revered to Exalted is 21,000 reputation: 420 turn-ins, 8,400 {item:14047}. At Exalted, {npc:384} at {area:88} sells her horses to other races in Classic; the Horse and Swift Horse guides cover them."] = "De Reverenciado a Exaltado são 21.000 de reputação: 420 entregas, 8.400 {item:14047}. Em Exaltado, {npc:384} em {area:88} vende os cavalos dela para outras raças no Classic; os guias de Cavalo e Cavalo Veloz os cobrem.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["About 4,500 {faction:72} reputation from low-level quests in Elwynn and the {area:717} (in Classic, a fifth of it at 60)"] = "Cerca de 4.500 de reputação com {faction:72} das missões de nível baixo em Elwynn e em {area:717} (no Classic, um quinto disso no 60)",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Adeptos das Trevas e Umbramantes (nível 58-60) o derrubam aqui; cada morto-vivo do Flagelo abatido aqui também conta para {object:92525} (veja esse guia). A Casa de Leilões também serve.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Ogros Dunamalho (nível 45-48) o derrubam aqui. A Casa de Leilões também serve.",
	-- ["Keep handing in {quest:7796} until {faction:72} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7796} até ficar Exaltado com {faction:72}. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Keep handing in {quest:7796}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7796}, 20 {item:14047} por vez. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Optional: eastern Elwynn, around {npc:261} on the bridge and the {area:91}, about 1,000 reputation (200 at a fifth) in 40 minutes at 60. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Opcional: o leste de Elwynn, ao redor de {npc:261} na ponte e de {area:91}, cerca de 1.000 de reputação (200, com um quinto) em 40 minutos no 60. No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. Pule este passo para pular o polo.",
	-- ["Optional: four quick deliveries inside {faction:72} for 200 reputation (40 at a fifth) in about five minutes. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Opcional: quatro entregas rápidas dentro de {faction:72} por 200 de reputação (40, com um quinto) em cerca de cinco minutos. No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. Pule este passo para pular o polo.",
	-- ["Optional: the Human start valley north of {area:87}: about 1,600 reputation (320 at a fifth) in 40 minutes at 60, the best rate of the hubs. {npc:823} and {npc:197} stand at {area:24}. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Opcional: o vale inicial dos humanos ao norte de {area:87}: cerca de 1.600 de reputação (320, com um quinto) em 40 minutos no 60, o melhor ritmo entre os polos. {npc:823} e {npc:197} ficam em {area:24}. No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. Pule este passo para pular o polo.",
	-- ["Optional: the {area:717} is {faction:72}'s prison, a dungeon in the canals of the {object:2101}. At 60 you clear it alone in ten minutes: 300 reputation (60 at a fifth). {npc:1719} stands at the gate, {npc:1721} in {object:2100}. Two more {area:717} quests start outside the city, 100 each, if you pass by: What Comes Around... ({npc:1696}) from {npc:859} in {area:69} and Crime and Punishment ({npc:1663}) from {npc:270} in {area:42}. (The Stockade Riots, 100 more, needs the Unsent Letter from {npc:639} in the {area:1581} first.) In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Opcional: {area:717} é a prisão de {faction:72}, uma masmorra nos canais de {object:2101}. No 60 você a limpa sozinho em dez minutos: 300 de reputação (60, com um quinto). {npc:1719} fica no portão, {npc:1721} em {object:2100}. Mais duas missões de {area:717} começam fora da cidade, 100 cada, se você passar por lá: Tudo que vai... ({npc:1696}), de {npc:859} em {area:69}, e Crime e castigo ({npc:1663}), de {npc:270} em {area:42}. (Rebelião no Cárcere, mais 100, exige antes a Carta Não Enviada de {npc:639} em {area:1581}.) No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. Pule este passo para pular o polo.",
	-- ["Optional: {area:87}, Westbrook and the farms south of {area:87}: about 1,450 reputation (290 at a fifth) in an hour at 60. {npc:240}, {npc:241} and {npc:253} stand around the Lion's Pride Inn. In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. Skip this step to skip the hub."] = "Opcional: {area:87}, Ribeira d'Oeste e as fazendas ao sul de {area:87}: cerca de 1.450 de reputação (290, com um quinto) em uma hora no 60. {npc:240}, {npc:241} e {npc:253} ficam ao redor da Estalagem Orgulho do Leão. No Classic, missões 6 ou mais níveis abaixo do seu pagam menos (um quinto no 60); um relato do beta do Forever diz que pagaram o valor cheio. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes polos. Pule este passo para pular o polo.",
	-- ["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Bandidos Pata Molhada e Capatazes Pata Molhada (nível 16-18) o derrubam aqui. A Casa de Leilões também serve.",
	-- ["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Mercenários da Camarilha na Bastilha de Stromgarde (nível 31-32) o derrubam aqui. A Casa de Leilões também serve.",
	-- ["{npc:14722} takes cloth for {faction:72} in {zone:1453}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7796} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14722} aceita tecido para {faction:72} em {zone:1453}. As primeiras doações de Lã, Seda, Magitrama e {item:14047} (60 tecidos cada) são feitas uma vez só e dão mais reputação por tecido; depois delas, {quest:7796} se repete até Exaltado. Ser Exaltado com a cidade de outra raça permite comprar as montarias dessa raça. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{npc:14722}: {item:14047} delivered"] = "{npc:14722}: {item:14047} entregue",
	-- ["{quest:7796} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7796} pede 20 {item:14047} por entrega e se repete quantas vezes quiser. Traga {item:14047} em múltiplos de 20 e entregue tudo de uma vez, uma entrega após a outra. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
}
