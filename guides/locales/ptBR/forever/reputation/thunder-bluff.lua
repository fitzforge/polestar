-- Portuguese (Brazil) (ptBR): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "Reputação: Penhasco do Trovão",
	-- {zone:1412} Mulgore · {zone:1452} Winterspring · {item:11040} Morrowgrain · {item:14047} Runecloth
	["{zone:1412} quests while you level, {zone:1452} quests and {item:11040} from 55, then {item:14047} to Exalted."] = "Missões de {zone:1412} enquanto você sobe de nível, missões de {zone:1452} e {item:11040} a partir do 55, depois {item:14047} até Exaltado.",
	-- {faction:81} Thunder Bluff
	["Exalted with {faction:81}"] = "Exaltado com {faction:81}",

	-- Step 1: Thunder Bluff: how it works
	-- {faction:81} Thunder Bluff
	["{faction:81}: how it works"] = "{faction:81}: como funciona",
	-- {faction:81} Thunder Bluff · {item:11040} Morrowgrain · {npc:14728} Rumstag Proudstrider · {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1454} Orgrimmar · {zone:1458} Undercity · {zone:1412} Mulgore · {area:378} Camp Taurajo · {zone:1441} Thousand Needles
	["{faction:81} reputation comes from quests, {item:11040} and cloth. {npc:14728}, the cloth quartermaster, stands on the central rise among the leatherworkers' and tailors' tents. He takes four one-time donations of 60 cloth (150 each) and then {quest:7825}, 20 {item:14047} for 50, as often as you like. Every point you earn with {faction:81} also gives a quarter as much to {zone:1454}, the {zone:1458} and the Darkspear Trolls. While you level, do {faction:81}'s quests within 5 levels of them: {zone:1412} at 1 to 12, {area:378} and the Crossroads at 13 to 22, {zone:1441} at 25 to 30. The Legacy perk Diplomat adds up to 10%. Rewards: at Honored Thunder Bluff's merchants sell to you for 10% less (the Classic rule), the kodo vendor included; at Exalted other races can buy the kodos: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60, once you have mount training. {faction:81} has no tabard or other reward."] = "A reputação com {faction:81} vem de missões, {item:11040} e tecido. {npc:14728}, o intendente de tecido, fica na elevação central, entre as tendas dos coureiros e dos alfaiates. Ele aceita quatro doações únicas de 60 tecidos (150 cada) e depois {quest:7825}, 20 {item:14047} por 50, quantas vezes você quiser. Cada ponto que você ganha com {faction:81} também dá um quarto disso para {zone:1454}, {zone:1458} e os Lançanegra. Enquanto sobe de nível, faça as missões de {faction:81} a até 5 níveis delas: {zone:1412} do 1 ao 12, {area:378} e a Encruzilhada do 13 ao 22, {zone:1441} do 25 ao 30. A vantagem do Legado Diplomata soma até 10%. Recompensas: em Honrado, os mercadores do Penhasco do Trovão vendem para você 10% mais barato (regra do Classic), inclusive o vendedor de kodos; em Exaltado, outras raças podem comprar os kodos: 20 de ouro por um kodo de nível 40, 200 de ouro por um kodo grande no nível 60, desde que você tenha o treinamento de equitação. {faction:81} não tem tabardo nem outra recompensa.",

	-- Step 2: Camp Narache (optional hub)
	-- {area:221} Camp Narache
	["{area:221} (optional hub)"] = "{area:221} (centro opcional)",
	-- {area:221} Camp Narache · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2980} Grull Hawkwind · {npc:2981} Chief Hawkwind · {npc:3209} Brave Windfeather
	["Forever pays these old quests in full at any level. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes. Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. {area:221}, no extremo sul de {zone:1412}: cerca de 1.100 de reputação com {faction:81} em 25 minutos. Missões de zona inicial não dão parte às outras cidades. {npc:2980} e {npc:2981} ficam no acampamento, {npc:3209} na beirada dele.",

	-- Step 3: Greatmother Hawkwind and the plains
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991} and the plains"] = "{npc:2991} e as planícies",
	-- {npc:2991} Greatmother Hawkwind
	["{npc:2991}'s tent is south-east of the camp; the water pitcher stands at the well beside it. Plainstriders graze all around."] = "A tenda de {npc:2991} fica a sudeste do acampamento; a jarra de água está no poço ao lado. Pinotes pastam por todo o redor.",

	-- Step 4: Camp Narache: hand in
	-- {area:221} Camp Narache
	["{area:221}: hand in"] = "{area:221}: entregue",

	-- Step 5: Seer Graytongue and the cougars
	-- {npc:2982} Seer Graytongue
	["{npc:2982} and the cougars"] = "{npc:2982} e os pumas",
	-- {npc:2982} Seer Graytongue
	-- plural, as words: Mountain Cougars = {npc:2961} Mountain Cougar
	["{npc:2982} sits on the hill south of the camp; the Mountain Cougars live in those hills."] = "{npc:2982} fica na colina ao sul do acampamento; os Pumas da Montanha vivem naquelas colinas.",

	-- Step 6: Camp Narache: the Battleboars
	-- {area:221} Camp Narache
	-- plural, as words: Battleboars = {npc:2966} Battleboar
	["{area:221}: the Battleboars"] = "{area:221}: os Javaliços",

	-- Step 7: Brambleblade Ravine
	-- {quest:780} The Battleboars · {npc:8554} Chief Sharptusk Thornmantle · {area:358} Brambleblade Ravine · {item:4851} Dirt-stained Map · {quest:781} Attack on Camp Narache
	["{quest:780} graze east of the camp; the Bristleback quilboar and {npc:8554} hold {area:358} beyond them. A {item:4851} lies in the ravine: reading it starts {quest:781}."] = "{quest:780} pastam a leste do acampamento; os javalis Cerdas Duras e {npc:8554} dominam {area:358} além deles. Um {item:4851} está caído no barranco: lê-lo começa a {quest:781}.",

	-- Step 8: Camp Narache: last hand-in
	-- {area:221} Camp Narache
	["{area:221}: last hand-in"] = "{area:221}: última entrega",
	-- {quest:763} Rites of the Earthmother · {npc:2993} Baine Bloodhoof
	["{quest:763}, +75: to {npc:2993}"] = "{quest:763}, +75: para {npc:2993}",

	-- Step 10: Bloodhoof Village (optional hub)
	-- {area:222} Bloodhoof Village
	["{area:222} (optional hub)"] = "{area:222} (centro opcional)",
	-- {area:222} Bloodhoof Village · {zone:1412} Mulgore · {faction:81} Thunder Bluff · {npc:2993} Baine Bloodhoof · {npc:2947} Harken Windtotem · {npc:2985} Ruul Eagletalon · {npc:3222} Brave Wildrunner · {npc:2988} Morin Cloudstalker
	["Forever pays these old quests in full at any level. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes. {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. {area:222} e o leste de {zone:1412}: cerca de 1.000 de reputação com {faction:81} em 45 minutos. {npc:2993} fica no meio da vila; {npc:2947}, {npc:2985} e {npc:3222} ficam por perto; {npc:2988} espera a leste da vila, junto à estrada.",

	-- Step 11: Eastern Mulgore
	-- {zone:1412} Mulgore
	["Eastern {zone:1412}"] = "Leste de {zone:1412}",
	-- {quest:99079} Longwalker Malah · {object:2908} Sealed Supply Crate
	["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest."] = "{quest:99079} espera junto à fronteira leste. A nordeste da vila fica a caravana devastada, com {object:2908}: abra para iniciar a próxima missão.",
	-- {object:2908} Sealed Supply Crate
	["the {object:2908}"] = "o {object:2908}",

	-- Step 12: Bloodhoof Village: hand in
	-- {area:222} Bloodhoof Village
	["{area:222}: hand in"] = "{area:222}: entregue",

	-- Step 13: The mine, the centaurs and the plains
	["The mine, the centaurs and the plains"] = "A mina, os centauros e as planícies",
	-- {quest:765} Supervisor Fizsprocket · {item:281031} Mulgore Expansion Plans · {quest:98424} Fizsprocket's Notes · {zone:1412} Mulgore
	-- plural, as words: Swoops = {npc:2970} Swoop
	["Back to the mine for the workers, supervisors and {quest:765} in the back: his {item:281031} start {quest:98424}, and its other pages lie inside the mine. The Galak centaurs and Herak camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "De volta à mina para os operários, os supervisores e {quest:765}, nos fundos: o que ele carrega, {item:281031}, inicia {quest:98424}, e as outras páginas ficam dentro da mina. Os centauros Galath e Herak acampam a leste da vila. Rapineiros voam por todo {zone:1412}; as harpias Ventofúria pousam a sudeste da vila; os gnolls Jubalba acampam a oeste dela.",
	-- {item:281031} Mulgore Expansion Plans · {quest:765} Supervisor Fizsprocket
	["{item:281031}, from {quest:765}"] = "{item:281031}, de {quest:765}",
	-- {item:281035} Shredder Operation Instructions
	["{item:281035}, inside the mine"] = "{item:281035}, dentro da mina",

	-- Step 14: Morin Cloudstalker
	-- {quest:98427} Ceasing Operations · {quest:98424} Fizsprocket's Notes
	["{quest:98427}, +150: needs {quest:98424}"] = "{quest:98427}, +150: precisa de {quest:98424}",

	-- Step 15: The Venture Co. Mine: the Clearcutter
	-- {area:360} The Venture Co. Mine
	["{area:360}: the Clearcutter"] = "{area:360}: o Fio-afiado",
	-- {quest:98427} Ceasing Operations
	["The elite shredder Venture Co. Clearcutter works deep inside the mine, beyond where Fizsprocket stood: its key is for {quest:98427}."] = "O retalhador de elite Fio-afiado da Empreendimentos S.A. trabalha bem no fundo da mina, depois de onde o Geringonça ficava: a chave dele serve para {quest:98427}.",

	-- Step 16: Bloodhoof Village: last hand-in
	-- {area:222} Bloodhoof Village
	["{area:222}: last hand-in"] = "{area:222}: última entrega",
	-- {quest:99082} The High Chieftain · {npc:3057} Cairne Bloodhoof · {faction:81} Thunder Bluff
	["{quest:99082}, +10: to {npc:3057} in {faction:81}"] = "{quest:99082}, +10: para {npc:3057} em {faction:81}",

	-- Step 18: Gloomrise (optional hub)
	-- {area:17044} Gloomrise
	["{area:17044} (optional hub)"] = "{area:17044} (centro opcional)",
	-- {area:17045} Skywatcher Plateau · {faction:81} Thunder Bluff · {zone:1454} Orgrimmar · {npc:259118} Muln Earthfury · {npc:264074} Mazu'kon · {npc:264072} Yorn Grimtotem
	["Forever pays these old quests in full at any level. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes, plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "O Forever paga estas missões antigas por inteiro em qualquer nível. O acampamento da Harmonia Telúrica em {area:17045}, a noroeste de {faction:81}: 300 de reputação com {faction:81} em 20 minutos, mais 100 cada com {zone:1454} e os Trolls Lançanegra e 450 com a Harmonia Telúrica. {npc:259118}, {npc:264074} e {npc:264072} ficam no acampamento.",
	-- {npc:259118} Muln Earthfury · {quest:96259} Defending the Dead · {quest:96261} The Broodmother
	["{npc:259118}: {quest:96259}, +100 ({quest:96261} comes once it is handed in)"] = "{npc:259118}: {quest:96259}, +100 ({quest:96261} vem depois da entrega)",
	-- {npc:264074} Mazu'kon · {quest:96241} Talkin' bout Toxins, Mon
	["{npc:264074}: {quest:96241} (Darkspear +100)"] = "{npc:264074}: {quest:96241} (Lançanegra +100)",

	-- Step 19: Gloomrise
	-- {area:17044} Gloomrise · {faction:81} Thunder Bluff · {item:273015} Toxin Extractor · {npc:264082} Broodmother Valraxx · {item:273658} Bloody Parchment · {quest:96294} A Darker Truth
	-- plural, as words: Gnawed Corpses = {npc:264096} Gnawed Corpse
	["{area:17044} is the tauren burial ground north of {faction:81}. Use the {item:273015} on the Gnawed Corpses. {npc:264082} waits at the heart of it; her body carries a {item:273658}: read it to start {quest:96294}."] = "{area:17044} é o cemitério dos taurenos ao norte de {faction:81}. Use o {item:273015} nos Cadáveres Roídos. {npc:264082} espera no coração dele; o corpo dela leva um {item:273658}: leia para começar a {quest:96294}.",
	-- {item:273181} Crystalline Silk
	-- plural, as words: Gloomrise Spinners = {npc:264081} Gloomrise Spinner
	["{item:273181}, from Gloomrise Spinners"] = "{item:273181}, das Tecelãs de Penumbrascente ({npc:264081})",

	-- Step 20: The Skywatcher camp: hand in
	["The Skywatcher camp: hand in"] = "O acampamento dos Vigias do Céu: entregue",
	-- {npc:259118} Muln Earthfury · {quest:96261} The Broodmother · {quest:96259} Defending the Dead
	["{npc:259118} offers {quest:96261} only once {quest:96259} is handed in."] = "{npc:259118} só oferece {quest:96261} depois que {quest:96259} é entregue.",

	-- Step 21: Broodmother Valraxx
	-- {npc:264082} Broodmother Valraxx · {area:17044} Gloomrise
	["{npc:264082}, at the heart of {area:17044}"] = "{npc:264082}, no coração de {area:17044}",

	-- Step 23: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["From here it is cloth. Wool, Silk and Mageweave must all be handed in before {npc:14728} offers the {item:14047} donation, and {quest:7825} needs the {item:14047} donation. Buy cloth at the Auction House, or farm it: humanoids drop it, Wool from level 15 to 25, Silk 25 to 40, Mageweave 40 to 50, {item:14047} 50 and up. At 60 farm mobs of level 52 or more: lower ones are grey."] = "Daqui em diante é tecido. Lã, Seda e Tecido Mágico precisam ser todos entregues antes de {npc:14728} oferecer a doação de {item:14047}, e a {quest:7825} precisa da doação de {item:14047}. Compre tecido na Casa de Leilões ou farme: humanoides o soltam, Lã do nível 15 ao 25, Seda do 25 ao 40, Tecido Mágico do 40 ao 50, {item:14047} do 50 em diante. No 60, farme criaturas de nível 52 ou mais: as menores estão cinzas.",
	-- {item:2592} Wool Cloth
	["{item:2592}: the Thistlefur furbolgs drop it about one kill in four"] = "{item:2592}: os furbolgs Pelocardo a soltam em cerca de uma a cada quatro mortes",

	-- Step 24: A Donation of Silk
	-- {area:287} Hillsbrad
	["Silk: the Syndicate in {area:287} and Alterac drop it about one kill in three, or buy it."] = "Seda: a Camarilha em {area:287} e Alterac a soltam em cerca de uma a cada três mortes, ou compre.",
	-- {item:4306} Silk Cloth
	["{item:4306}: the Syndicate"] = "{item:4306}: a Camarilha",

	-- Step 25: A Donation of Mageweave
	-- {zone:1448} Felwood · {zone:1446} Tanaris
	["Mageweave: the Jadefire satyrs in southern {zone:1448} and the Dunemaul ogres in {zone:1446} drop it about one kill in three, or buy it."] = "Magitrama: os sátiros Flamejade do sul de {zone:1448} e os ogros Dunamalho de {zone:1446} a soltam em cerca de uma a cada três mortes, ou compre.",
	-- {item:4338} Mageweave Cloth
	["{item:4338}: the Jadefire satyrs"] = "{item:4338}: os sátiros Flamejade",

	-- Step 26: A Donation of Runecloth
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand · {zone:1423} Eastern Plaguelands · {area:2577} Dire Maul · {zone:1444} Feralas · {zone:1451} Silithus
	["{item:14047}: the Scarlet at {area:2266} in the {zone:1423}, the Gordok ogres outside {area:2577} in {zone:1444} and the Twilight camps of {zone:1451} drop it about one kill in three. The Auction House is faster if you have gold."] = "{item:14047}: os Escarlates em {area:2266}, em {zone:1423}, os ogros Gordok fora de {area:2577}, em {zone:1444}, e os acampamentos do Crepúsculo de {zone:1451} a soltam em cerca de uma a cada três mortes. A Casa de Leilões é mais rápida se você tiver ouro.",
	-- {item:14047} Runecloth · {area:2266} Tyr's Hand
	["{item:14047}: the Scarlet outside {area:2266}"] = "{item:14047}: os Escarlates fora de {area:2266}",

	-- Step 27: Everlook: Storm Shadowhoof
	-- {npc:10303} Storm Shadowhoof · {faction:81} Thunder Bluff · {npc:10806} Ursius · {area:2255} Everlook
	["{npc:10303}'s four quests are level 56 to 60, so they pay in full: 400 {faction:81} reputation. {npc:10806}, an elite bear, walks a loop over the four hills north of {area:2255}: wait on a hilltop for him."] = "As quatro missões de {npc:10303} são de nível 56 a 60, então pagam por inteiro: 400 de reputação com {faction:81}. {npc:10806}, um urso elite, anda num circuito pelas quatro colinas ao norte de {area:2255}: espere no topo de uma colina por ele.",
	-- {npc:10806} Ursius
	["{npc:10806}, elite"] = "{npc:10806}, elite",

	-- Step 28: Brumeran and Shy-Rotam
	-- {npc:10807} Brumeran · {quest:5056} Shy-Rotam
	["{npc:10807} and {quest:5056}"] = "{npc:10807} e {quest:5056}",
	-- {npc:10807} Brumeran · {area:2255} Everlook · {quest:5056} Shy-Rotam · {item:12733} Sacred Frostsaber Meat · {object:103819} Stone of Shy-Rotam (no name in this language: may be words) · {npc:10306} Trull Failbane · {zone:1454} Orgrimmar · {item:12558} Blue-feathered Necklace · {quest:4882} Guarding Secrets · {faction:81} Thunder Bluff
	["{npc:10807}, an elite chimera, spawns south of {area:2255}. For {quest:5056}, kill frostsabers north of {area:2255} until one drops {item:12733} (about one in ten), then use the meat at the {object:103819}, far to the north, and kill the great cat that comes. If you have done {npc:10306}'s Wild Guardians quests (the {zone:1454} guide), the Crazed, Moontouched and Berserk owlbeasts around {area:2255} sometimes drop a {item:12558}: it starts {quest:4882}, 50 {zone:1454} and then 100 {faction:81} reputation in full."] = "{npc:10807}, uma quimera elite, nasce ao sul de {area:2255}. Para a {quest:5056}, mate sabres-de-gelo ao norte de {area:2255} até um soltar {item:12733} (cerca de um em dez), depois use a carne em {object:103819}, bem ao norte, e mate o grande felino que aparecer. Se você já fez as missões dos Guardiões selvagens de {npc:10306} (o guia de {zone:1454}), as corujas Enlouquecida, Tocada pela Lua e Berserk ao redor de {area:2255} às vezes soltam um {item:12558}: ele começa a {quest:4882}, 50 em {zone:1454} e depois 100 de reputação com {faction:81} por inteiro.",
	-- {npc:10807} Brumeran
	["{npc:10807}, elite"] = "{npc:10807}, elite",
	-- {item:12733} Sacred Frostsaber Meat
	["{item:12733}, from the frostsabers"] = "{item:12733}, dos sabres-de-gelo",

	-- Step 29: Bloodvenom Post: Trull Failbane
	-- {npc:10306} Trull Failbane · {area:1997} Bloodvenom Post · {zone:1452} Winterspring
	["{npc:10306} stands at {area:1997}, through the Timbermaw tunnel south of {zone:1452}."] = "{npc:10306} fica em {area:1997}, atravessando o túnel dos Presamatos ao sul de {zone:1452}.",
	-- {quest:4882} Guarding Secrets · {npc:5770} Nara Wildmane · {faction:81} Thunder Bluff
	["{quest:4882}, +100: to {npc:5770} in {faction:81}"] = "{quest:4882}, +100: para {npc:5770} em {faction:81}",

	-- Step 30: Thunder Bluff: Nara Wildmane
	-- {npc:5770} Nara Wildmane · {area:1639} Elder Rise · {npc:5769} Arch Druid Hamuul Runetotem
	["{npc:5770} stands on {area:1639}, beside {npc:5769}."] = "{npc:5770} fica em {area:1639}, ao lado de {npc:5769}.",

	-- Step 31: Morrowgrain (optional)
	-- {item:11040} Morrowgrain
	["{item:11040} (optional)"] = "{item:11040} (opcional)",
	-- {quest:3804} Morrowgrain to Thunder Bluff · {item:11040} Morrowgrain · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {npc:6746} Innkeeper Pala · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise
	["{quest:3804} takes 10 {item:11040} for 50, as often as you like, and pays in full at 60, but it is slow: the {item:11020} grows one casing every 10 minutes and a casing holds about one {item:11040} on average, so each hand-in takes about 90 minutes of waiting, 18 {quest:3761} and 9 seed packets (90 silver). It runs beside whatever else you do: a little over 30 reputation an hour. The chain before it is level 50. {npc:6746} sends you to {npc:5769} on {area:1639}; he wants 20 {quest:3761}."] = "A {quest:3804} pede 10 {item:11040} por 50, quantas vezes quiser, e paga por inteiro no 60, mas é lenta: o {item:11020} cultiva um casulo a cada 10 minutos e um casulo tem em média cerca de uma {item:11040}, então cada entrega leva cerca de 90 minutos de espera, 18 {quest:3761} e 9 pacotes de sementes (90 pratas). Ela corre em paralelo com o que mais você fizer: pouco mais de 30 de reputação por hora. A cadeia antes dela é de nível 50. {npc:6746} manda você a {npc:5769} em {area:1639}; ele quer 20 {quest:3761}.",

	-- Step 32: Un'Goro Crater: Un'Goro Soil
	-- {quest:3761} Un'Goro Soil · {item:11040} Morrowgrain
	["Nearly every beast, plant and silithid in the crater drops {quest:3761}, about one kill in three (the Bloodpetals and the Gorishi wasps about one in two), and the dirt mounds give it too. Take far more than 20: every casing uses 2, about 18 for each {item:11040} hand-in."] = "Quase toda fera, planta e silitídeo da cratera solta {quest:3761}, cerca de uma em cada três mortes (as Pétalas Sangrentas e as vespas Gorishi cerca de uma em duas), e os montes de terra também dão. Pegue muito mais que 20: cada casulo gasta 2, cerca de 18 para cada entrega de {item:11040}.",

	-- Step 33: Thunder Bluff: Morrowgrain Research
	-- {npc:9076} Ghede · {npc:9087} Bashana Runetotem · {item:11020} Evergreen Pouch · {quest:3761} Un'Goro Soil · {item:11024} Evergreen Herb Casing · {item:11040} Morrowgrain
	["{npc:9076} takes the soil. {npc:9087} sells the {item:11020} (1 gold) and Packets of Tharlendris Seeds (10 silver each). With a seed packet and 2 {quest:3761} in your bags, use the pouch: it grows an {item:11024}, once every 10 minutes. Open each casing: about one in three holds 1 to 5 {item:11040}, the rest common herbs. Use the pouch whenever it is ready while you follow the rest of this guide."] = "{npc:9076} aceita a terra. {npc:9087} vende o {item:11020} (1 de ouro) e Pacotes de Sementes de Tharlendris (10 pratas cada). Com um pacote de sementes e 2 {quest:3761} nas bolsas, use a bolsinha: ela cultiva uma {item:11024}, uma vez a cada 10 minutos. Abra cada casulo: cerca de um em três tem de 1 a 5 {item:11040}, o resto são ervas comuns. Use a bolsinha sempre que estiver pronta enquanto segue o resto deste guia.",
	-- {item:11020} Evergreen Pouch
	["{item:11020}, 1 gold"] = "{item:11020}, 1 de ouro",
	-- {item:11022} Packet of Tharlendris Seeds
	["{item:11022}, 10 silver each"] = "{item:11022}, 10 pratas cada",

	-- Step 34: Morrowgrain as you go
	-- {item:11040} Morrowgrain
	["{item:11040} as you go"] = "{item:11040} pelo caminho",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}: use the pouch every 10 minutes and open the casings; {npc:9087} takes it"] = "{item:11040}: use a bolsinha a cada 10 minutos e abra os casulos; {npc:9087} aceita",

	-- Step 35: Bashana Runetotem: Morrowgrain Research
	-- {npc:9087} Bashana Runetotem · {area:1639} Elder Rise · {item:11040} Morrowgrain
	["{npc:9087} stands on {area:1639}. If your 10 {item:11040} are not ready yet, skip this step and go on with the cloth: the cloth steps below list the {item:11040} hand-in too."] = "{npc:9087} fica em {area:1639}. Se as suas 10 {item:11040} ainda não estão prontas, pule este passo e siga com os tecidos: os passos de tecido abaixo também listam a entrega de {item:11040}.",

	-- Step 36: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825} até Honrado",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth
	["{quest:7825}: 20 {item:14047} for 50 reputation, as often as you like. Friendly to Honored is 6,000: 120 hand-ins, 2,400 {item:14047}, less what the quests gave you (a tauren starts at Friendly 1,000: 100 hand-ins; an Undead at Neutral 500 first needs 50 more to reach Friendly). Hand in every 20 you carry, one after another."] = "{quest:7825}: 20 {item:14047} por 50 de reputação, quantas vezes quiser. De Amigável a Honrado são 6.000: 120 entregas, 2.400 {item:14047}, menos o que as missões deram (um tauren começa em Amigável 1.000: 100 entregas; um Morto-vivo em Neutro 500 precisa antes de mais 50 para chegar a Amigável). Entregue a cada 20 que tiver, uma depois da outra.",
	-- {item:11040} Morrowgrain · {npc:9087} Bashana Runetotem
	["{item:11040}, if you grow it: {npc:9087} takes it"] = "{item:11040}, se você cultivar: {npc:9087} aceita",

	-- Step 37: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825} até Reverenciado",
	-- {item:14047} Runecloth · {item:11040} Morrowgrain · {area:1584} Blackrock Depths · {area:340} Kargath · {npc:9017} Lord Incendius
	["Honored to Revered is 12,000: 240 hand-ins, 4,800 {item:14047}, fewer if you also hand in {item:11040}. {area:1584} pays too: Disharmony of Flame and Disharmony of Fire from Thunderheart at {area:340} ({npc:9017}, 150 in full)."] = "De Honrado a Reverenciado são 12.000: 240 entregas, 4.800 {item:14047}, menos se você também entregar {item:11040}. {area:1584} também paga: Desarmonia das chamas e Desarmonia do fogo, de Coração Trovejante em {area:340} ({npc:9017}, 150 por inteiro).",
	-- {item:11040} Morrowgrain
	["{item:11040}, if you grow it"] = "{item:11040}, se você cultivar",

	-- Step 38: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825} até Exaltado",
	-- {item:14047} Runecloth · {npc:3685} Harb Clawhoof · {area:222} Bloodhoof Village
	["Revered to Exalted is 21,000: 420 hand-ins, 8,400 {item:14047}. For The Horde! (Rend's head) and The Lord of Blackrock (Nefarian's head) pay 200 to every Horde city. At Exalted, {npc:3685} in {area:222} sells the kodos to every Horde race: 20 gold for a level 40 kodo, 200 gold for a great kodo at level 60 (Forever's prices); in Classic other races needed Exalted to buy them."] = "De Reverenciado a Exaltado são 21.000: 420 entregas, 8.400 {item:14047}. Pela Horda! (a cabeça de Rend) e O Senhor dos Rocha Negra (a cabeça de Nefarian) dão 200 a todas as cidades da Horda. No Exaltado, {npc:3685} em {area:222} vende os kodos a todas as raças da Horda: 20 de ouro por um kodo de nível 40, 200 de ouro por um grande kodo no nível 60 (preços do Forever); no Classic as outras raças precisavam de Exaltado para comprá-los.",
	-- {npc:3685} Harb Clawhoof
	["{npc:3685}: the kodos"] = "{npc:3685}: os kodos",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to the mine for the workers, supervisors and {quest:765}. The Galak centaurs and {npc:275767} camp east of the village. Swoops fly all over {zone:1412}; the Windfury harpies roost south-east of the village; the Palemane gnolls camp west of it."] = "De volta à mina para os operários, supervisores e {quest:765}. Os centauros Galak e {npc:275767} acampam a leste da vila. Rapineiros voam por todo {zone:1412}; as harpias Ventofúria pousam a sudeste da vila; os gnolls Jubalba acampam a oeste dela.",
	-- ["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Adeptos das Trevas e Umbramantes (nível 58-60) deixam cair aqui; cada Flagelo morto aqui também conta para {object:92525} (veja esse guia). A Casa de Leilões também serve.",
	-- ["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Ogros Dunamalho (nível 45-48) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. The Earthen Ring camp on the {area:17045}, north-west of {faction:81}: 300 {faction:81} reputation in 20 minutes (60 at a fifth), plus 100 each for {zone:1454} and the Darkspear Trolls and 450 Earthen Ring. {npc:259118}, {npc:264074} and {npc:264072} stand in the camp."] = "No Classic, missões 6+ níveis abaixo de você pagam menos (um quinto no 60); um relato da beta do Forever diz que pagaram por inteiro. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes centros. O acampamento do Círculo Terreno em {area:17045}, a noroeste de {faction:81}: 300 de reputação com {faction:81} em 20 minutos (60 com um quinto), mais 100 cada para {zone:1454} e os Trolls Lançanegra e 450 com o Círculo Terreno. {npc:259118}, {npc:264074} e {npc:264072} ficam no acampamento.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:221}, at the south end of {zone:1412}: about 1,100 {faction:81} reputation in 25 minutes (220 at a fifth). Starting-zone quests give the other cities no share. {npc:2980} and {npc:2981} stand in the camp, {npc:3209} at its edge."] = "No Classic, missões 6+ níveis abaixo de você pagam menos (um quinto no 60); um relato da beta do Forever diz que pagaram por inteiro. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes centros. {area:221}, no extremo sul de {zone:1412}: cerca de 1.100 de reputação com {faction:81} em 25 minutos (220 com um quinto). Missões de zona inicial não dão nada às outras cidades. {npc:2980} e {npc:2981} ficam no acampamento, {npc:3209} na beira dele.",
	-- ["In Classic, quests 6+ levels below you pay less (a fifth at 60); a Forever beta report says they paid in full. Your first turn-in shows which: if it pays a fifth, skip these hubs. {area:222} and eastern {zone:1412}: about 1,000 {faction:81} reputation in 45 minutes (200 at a fifth). {npc:2993} stands in the middle of the village; {npc:2947}, {npc:2985} and {npc:3222} close by; {npc:2988} waits east of the village by the road."] = "No Classic, missões 6+ níveis abaixo de você pagam menos (um quinto no 60); um relato da beta do Forever diz que pagaram por inteiro. Sua primeira entrega mostra qual é o caso: se pagar um quinto, pule estes centros. {area:222} e o leste de {zone:1412}: cerca de 1.000 de reputação com {faction:81} em 45 minutos (200 com um quinto). {npc:2993} fica no meio da vila; {npc:2947}, {npc:2985} e {npc:3222} bem perto; {npc:2988} espera a leste da vila, junto à estrada.",
	-- ["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7825} até ficar Exaltado com {faction:81}. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Continue entregando {quest:7825}, 20 {item:14047} por vez. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Centauros Kolkar (nível 30-33) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Seguranças da Empreendimentos S.A. em {area:381} (nível 16-17) deixam cair aqui. A Casa de Leilões também serve.",
	-- ["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728} recebe tecido para {faction:81} em {faction:81}. As primeiras doações de Lã, Seda, Magitrama e {item:14047} (60 tecidos cada) são feitas uma só vez e dão mais reputação por tecido; depois delas, {quest:7825} se repete até Exaltado. Exaltado com a cidade de outra raça permite comprar as montarias dessa raça. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{npc:14728}: {item:14047} delivered"] = "{npc:14728}: {item:14047} entregue",
	-- ["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825} pede 20 {item:14047} por entrega e se repete quantas vezes você quiser. Traga {item:14047} em múltiplos de 20 e entregue tudo de uma vez, uma entrega após a outra. {item:14047}: Adeptos das Trevas e Umbramantes (nível 58-60) em {zone:1423}, ou a Casa de Leilões.",
	-- ["{quest:99079} waits by the eastern border. The {object:2908} of the ravaged caravan lies north-east of the village: open it to start the next quest. {quest:764} mine is further north-east; the elite shredder Venture Co. Clearcutter works deep inside."] = "{quest:99079} espera junto à fronteira leste. O {object:2908} da caravana devastada fica a nordeste da vila: abra-o para começar a próxima missão. A mina {quest:764} fica mais a nordeste; o Cortador Clearcutter da Empreendimentos S.A., um triturador elite, trabalha lá no fundo.",
	-- ["{zone:1452}'s level 56-60 quests, {item:11040} and {item:14047} to Exalted, with {zone:1412}'s old quests as an optional extra."] = "As missões de nível 56-60 de {zone:1452}, {item:11040} e {item:14047} até Exaltado, com as missões antigas de {zone:1412} como extra opcional.",
}
