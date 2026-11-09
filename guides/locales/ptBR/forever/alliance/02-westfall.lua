-- Portuguese (Brazil) (ptBR): the guide forever/alliance/02-westfall (forever/alliance/02-westfall.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Goldshire
	-- {zone:1453} Stormwind · {zone:1436} Westfall · {area:87} Goldshire · {npc:241} Remy "Two Times" · {npc:240} Marshal Dughan · {quest:40} A Fishy Peril · {quest:35} Further Concerns · {quest:109} Report to Gryan Stoutmantle
	["On the road from {zone:1453} to {zone:1436}, {area:87} is the first stop: {npc:241} stands outside the inn, {npc:240} beside him. {npc:241}'s {quest:40} goes straight to Dughan, who then gives {quest:35}; his {quest:109} goes with you to {zone:1436}."] = "Na estrada de {zone:1453} até {zone:1436}, {area:87} é a primeira parada: {npc:241} fica na frente da estalagem, e {npc:240}, ao lado dele. {quest:40}, de {npc:241}, vai direto para Dughan, que então entrega {quest:35}; {quest:109}, dele, vai com você até {zone:1436}.",
	-- {npc:240} Marshal Dughan · {npc:234} Gryan Stoutmantle · {area:108} Sentinel Hill
	["{npc:240}: for {npc:234} at {area:108}"] = "{npc:240}: para {npc:234} em {area:108}",

	-- Step 2: The Tower of Azora
	-- {area:91} Tower of Azora
	["The {area:91}"] = "{area:91}",
	-- {area:18} Crystal Lake · {npc:248242} Hamish Bergwort · {npc:248248} Blixie Fitzwink
	["East along the road past {area:18}: {npc:248242} and {npc:248248} stand at the foot of the tower."] = "Para leste pela estrada, passando por {area:18}: {npc:248242} e {npc:248248} ficam ao pé da torre.",

	-- Step 3: The bridge
	["The bridge"] = "A ponte",
	-- {npc:261} Guard Thomas · {npc:248265} Ormin Pelford
	-- plural, as words: Prowlers = {npc:118} Prowler
	["{npc:261} guards the bridge on the road east; {npc:248265} stands just across it. His tools and Thomas's Prowlers and bears are south of the bridge, on the way back."] = "{npc:261} guarda a ponte na estrada a leste; {npc:248265} fica logo do outro lado. As ferramentas dele e os Predadores e ursos do Tomás ficam ao sul da ponte, no caminho de volta.",

	-- Step 4: The Eastvale Logging Camp
	-- {area:88} Eastvale Logging Camp
	["The {area:88}"] = "{area:88}",
	["The camp is north-east of the bridge. Bundles of Wood lie around the camp and in the woods north of it."] = "O acampamento fica a nordeste da ponte. Feixes de Lenha estão espalhados pelo acampamento e pelo bosque ao norte dele.",
	-- {npc:278} Sara Timberlain
	["{npc:278}, inside"] = "{npc:278}, lá dentro",

	-- Step 5: A half-eaten body
	["It lies by the river north-west of the logging camp."] = "Fica junto ao rio, a noroeste do acampamento madeireiro.",

	-- Step 6: Stone Cairn Lake
	-- {area:86} Stone Cairn Lake · {object:56} Rolf's corpse
	-- plural, as words: Defias Rogue Wizards = {npc:474} Defias Rogue Wizard · Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Defias Rogue Wizards camp on the shores of {area:86}; they drop the Red Linen Bandanas too. {object:56} lies in the murloc village on the north-east shore."] = "Teurgos Proscritos Défias acampam nas margens de {area:86}; eles também soltam as Bandanas de Linho Vermelhas. {object:56} está na aldeia murloc da margem nordeste.",
	-- plural, as words: Red Linen Bandanas = {item:1019} Red Linen Bandana
	["Red Linen Bandanas"] = "Bandanas de Linho Vermelhas",

	-- Step 7: The gnoll camps
	["The gnoll camps"] = "Os acampamentos gnolls",
	-- {area:86} Stone Cairn Lake · {quest:91725} Stolen Enchanting Supplies
	["Riverpaw gnolls camp in the hills west of {area:86}; the {quest:91725} lie in their camps."] = "Gnolls Pata Molhada acampam nas colinas a oeste de {area:86}; {quest:91725} estão nos acampamentos deles.",

	-- Step 8: The Jasperlode Mine's entrance
	-- {area:54} Jasperlode Mine
	["The {area:54}'s entrance"] = "Entrada de {area:54}",

	-- Step 9: Jasperlode Mine: kill these as you meet them
	-- {area:54} Jasperlode Mine
	["{area:54}: kill these as you meet them"] = "{area:54}: vá matando estes pelo caminho",
	-- {item:247816} Mining Tools
	-- plural, as words: Kobold Geomancers = {npc:476} Kobold Geomancer
	["The mine is south-west of the gnoll camps. {item:247816} lie near the entrance; Kobold Geomancers hold the tunnels."] = "A mina fica a sudoeste dos acampamentos gnolls. {item:247816} estão perto da entrada; Geomantes Kobold ocupam os túneis.",
	-- {npc:476} Kobold Geomancer · {area:54} Jasperlode Mine
	["{npc:476} walks around {area:54}: look inside the circle on the map"] = "{npc:476} anda por {area:54}: procure dentro do círculo no mapa",

	-- Step 10: The Tower of Azora
	["Follow the hills south to the tower."] = "Siga pelas colinas para o sul até a torre.",

	-- Step 11: Downstream
	-- {item:247813} Waterlogged Saw
	-- plural, as words: Prowlers = {npc:118} Prowler · Young Forest Bears = {npc:822} Young Forest Bear
	["East along the road, then into the river south of the bridge: the {item:247813}, Axe and Toolbox lie in it. Prowlers and Young Forest Bears roam its banks."] = "Para leste pela estrada e depois entre no rio ao sul da ponte: {item:247813}, o Machado e a Caixa de Ferramentas estão nele. Predadores e Jovens Ursos da Floresta vagam por suas margens.",

	-- Step 14: Goldshire
	-- {area:87} Goldshire · {zone:1436} Westfall · {npc:240} Marshal Dughan
	["Follow the road west to {area:87}, on the way to {zone:1436}: {npc:240} stands outside the inn."] = "Siga a estrada para oeste até {area:87}, a caminho de {zone:1436}: {npc:240} fica na frente da estalagem.",

	-- Step 15: The Jansen Stead
	-- {zone:1436} Westfall · {object:2724} Sack of Oats
	["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Pick up oats from any {object:2724} you pass on the loop: the rest are gathered in the fields here on the way back."] = "Siga a estrada de Elwynn até {zone:1436}: os Taturana estão sentados junto à fazenda queimada deles, a primeira da estrada. Pegue aveia de qualquer {object:2724} que encontrar na volta: o resto você junta nos campos daqui na volta.",
	-- {npc:237} Farmer Furlbrow · {npc:963} Deputy Rainer
	["{npc:237}; Humans took it from {npc:963} in Elwynn"] = "{npc:237}; Humanos tomaram de {npc:963} em Elwynn",

	-- Step 17: The Jansen Stead
	-- {item:1972} Westfall Deed
	["Only if you looted a {item:1972} in Elwynn: right-click it"] = "Só se você saqueou uma {item:1972} na Floresta de Elwynn: clique nela com o botão direito",

	-- Step 18: Saldean's Farm
	-- {npc:233} Farmer Saldean · {npc:235} Salma Saldean · {npc:253395} Ozwin Ironsprocket
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["South along the road, past the fork. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west. Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way."] = "Ao sul pela estrada, passando pelo cruzamento. {npc:233} está do lado de fora, {npc:235} dentro da casa, {npc:253395} no celeiro a oeste. Jovens Presas e Estraçalhadores rondam os campos ao redor da fazenda: comece pelos fígados e pela carne do ensopado pelo caminho.",
	-- {npc:235} Salma Saldean
	["{npc:235}, inside"] = "{npc:235}, lá dentro",

	-- Step 19: Goretusk Snouts
	-- plural, as words: Goretusk Snouts = {item:731} Goretusk Snout
	["Goretusk Snouts"] = "Focinhos de Goretusco",
	-- {area:108} Sentinel Hill
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Young Goretusks root in the fields along the road south from Saldean's to {area:108}: take their snouts on the way."] = "Gorestuscos Jovens fuçam nos campos ao longo da estrada ao sul de Saldean até {area:108}: pegue as ventas deles pelo caminho.",

	-- Step 20: Sentinel Hill's tower and Thor
	-- {area:108} Sentinel Hill · {npc:523} Thor
	["{area:108}'s tower and {npc:523}"] = "A torre de {area:108} e {npc:523}",
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:523} Thor · {npc:878} Scout Galiaan · {npc:1323} Osric Strang · {zone:1453} Stormwind · {npc:279} Morgan Pestle · {object:2096} Trade District · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town · {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {npc:352} Dungar Longdrink
	["{npc:234} and {npc:821} stand at the top of the stone tower, {npc:491} inside it, {npc:523} the gryphon master on the south side of the hill with {npc:878} beside him. {npc:523} gives you Lewis' note for {npc:1323} with a free flight to {zone:1453}: take it now. In {zone:1453}, {npc:279}'s shop is in the {object:2096} by the gryphons, {npc:1323}'s shop, {object:2156}, in {object:2100}; {npc:1646} stands in {object:2098} on the way back to {npc:352}, the gryphon master."] = "{npc:234} e {npc:821} ficam no alto da torre de pedra, {npc:491} lá dentro, e {npc:523}, o mestre de grifos, no lado sul do morro, com {npc:878} ao lado dele. {npc:523} entrega o bilhete de Lewis para {npc:1323}, com um voo de graça até {zone:1453}: pegue agora. Em {zone:1453}, a loja de {npc:279} fica no {object:2096}, perto dos grifos; a loja de {npc:1323}, {object:2156}, fica na {object:2100}; {npc:1646} fica na {object:2098}, no caminho de volta até {npc:352}, o mestre de grifos.",
	-- {npc:491} Quartermaster Lewis
	["{npc:491}, inside"] = "{npc:491}, lá dentro",
	-- {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:878}, beside {npc:523}"] = "{npc:878}, ao lado de {npc:523}",
	-- {npc:523} Thor · {zone:1453} Stormwind
	["{npc:523}: the free flight he offers goes to {zone:1453}"] = "{npc:523}: o voo grátis que ele oferece vai para {zone:1453}",

	-- Step 21: Osric Strang
	-- {npc:279} Morgan Pestle · {object:2096} Trade District
	["{npc:279}, {object:2096}, by the gryphons"] = "{npc:279}, {object:2096}, junto aos grifos",
	-- {npc:1323} Osric Strang · {object:2156} Limited Immunity (no name in this language: may be words) · {object:2100} Old Town
	["{npc:1323}, {object:2156} in {object:2100}"] = "{npc:1323}, {object:2156} na {object:2100}",
	-- {npc:1646} Baros Alexston · {object:2098} Cathedral Square · {zone:1436} Westfall
	["{npc:1646}, {object:2098}: his compass is in his old house in {zone:1436}"] = "{npc:1646}, {object:2098}: a bússola dele está na antiga casa dele em {zone:1436}",
	-- {npc:352} Dungar Longdrink
	["{npc:352}, the gryphon master"] = "{npc:352}, o mestre de grifos",

	-- Step 22: Sentinel Hill
	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin · {npc:491} Quartermaster Lewis · {npc:878} Scout Galiaan · {npc:523} Thor
	["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} e {npc:821} ficam no alto da torre de pedra. {npc:491} está na torre; {npc:878}, no lado sul do morro, junto à estalagem e a {npc:523}, o mestre de grifos.",
	-- {npc:234} Gryan Stoutmantle · {npc:963} Deputy Rainer
	["{npc:234}: from {npc:963} at Westbrook"] = "{npc:234}: de {npc:963}, na Ribeira d'Oeste",
	-- {npc:491} Quartermaster Lewis · {zone:1453} Stormwind
	["{npc:491}, inside: back from {zone:1453}"] = "{npc:491}, lá dentro: de volta de {zone:1453}",
	-- {npc:253092} Alba Fairmoon · {npc:878} Scout Galiaan
	["{npc:253092}, beside {npc:878}"] = "{npc:253092}, ao lado de {npc:878}",

	-- Step 24: Goretusk Livers as you go
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Goretusk Livers as you go"] = "Fígados de Goretusco pelo caminho",
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Goretusks and Young Goretusks root along every leg of this loop: kill the ones you pass for the pie's livers."] = "Goretuscos e Goretuscos Jovens fuçam em todos os trechos deste circuito: mate os que encontrar pelo caminho para pegar os fígados do empadão.",

	-- Step 25: Stringy Vulture Meat as you go
	-- {item:729} Stringy Vulture Meat
	["{item:729} as you go"] = "{item:729} pelo caminho",
	["Fleshrippers circle the fields along this loop: kill the ones you pass for the stew's meat."] = "Ripa-carnes rondam os campos ao longo deste circuito: mate os que encontrar pelo caminho para pegar a carne do ensopado.",
	-- {item:729} Stringy Vulture Meat
	["{item:729}: Fleshrippers"] = "{item:729}: Ripa-carnes",

	-- Step 26: Red Leather Bandanas as you go
	-- {quest:153} Red Leather Bandanas
	["{quest:153} as you go"] = "{quest:153} pelo caminho",
	-- {item:829} Red Leather Bandana · {object:290} Furlbrow's Wardrobe
	["Every Defias on this loop can drop a {item:829}: the Trappers and Smugglers, and the guards at {object:290}."] = "Todo Défias deste circuito pode soltar {item:829}: os Coureadores e Contrabandistas, e os guardas em {object:290}.",

	-- Step 27: Defias Trappers and Smugglers
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Defias Trappers and Smugglers"] = "Coureadores e Contrabandistas Défias",
	-- {area:108} Sentinel Hill · {area:918} Molsen Farm
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["North-west from {area:108} toward {area:918}: Defias Trappers and Smugglers camp in the fields between them."] = "Ao noroeste de {area:108}, rumo a {area:918}: Coureadores e Contrabandistas Défias acampam nos campos entre os dois.",

	-- Step 28: Molsen Farm's well
	-- {area:918} Molsen Farm
	["{area:918}'s well"] = "o poço de {area:918}",
	["Fill the vial at the farm's well"] = "Encha o frasco no poço da fazenda",

	-- Step 29: Molsen Farm's Harvest Watchers
	-- {area:918} Molsen Farm
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["{area:918}'s Harvest Watchers"] = "Guarda-colheitas de {area:918}",
	-- {area:918} Molsen Farm · {item:732} Okra · {item:255155} Precessive Autocognition Assembly · {npc:573} Foe Reaper 4000
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers and Golems work the fields around {area:918}; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone."] = "Guarda-colheitas e Golens trabalham nos campos ao redor de {area:918}; eles soltam as isomolas, os giroestabilizadores, {item:732} e, às vezes, {item:255155}. {npc:573}, um raro de nível 20, anda por aqui: deixe-o em paz.",
	-- plural, as words: Harvest Watchers = {npc:114} Harvest Watcher
	["Harvest Watchers"] = "Guarda-colheitas",

	-- Step 30: The gnoll hills
	["The gnoll hills"] = "As colinas dos gnolls",
	-- {area:111} Jangolode Mine · {area:916} The Jansen Stead
	-- plural, as words: Riverpaw Gnolls = {npc:117} Riverpaw Gnoll
	["North to the hills above {area:111}: Riverpaw Gnolls and Scouts (level 11-13) roam there, east toward the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer."] = "Ao norte, até as colinas acima de {area:111}: Gnolls Pata Molhada e Batedores Pata Molhada (nível 11-13) rondam ali, a leste rumo a {area:916}. Os gnolls mais ao sul e a oeste são de nível 13-19: fique nas colinas do norte.\nCuidado: gnolls que ficam juntos tendem a entrar na luta em grupo. Puxar um de cada vez é mais seguro.",
	-- plural, as words: Gnoll Paws = {item:725} Gnoll Paw
	["Gnoll Paws"] = "Patas de Gnoll",

	-- Step 31: The Longshore murlocs
	-- {area:2} Longshore
	["The {area:2} murlocs"] = "Os murlocs de {area:2}",
	-- {area:916} The Jansen Stead
	-- plural, as words: Murloc Coastrunners = {npc:126} Murloc Coastrunner
	["Murloc Coastrunners and Raiders line the north coast from above the mine east toward the {area:916}: work along the beach eastward. They flee at low health: pull one at a time."] = "Murlocs Correcosta e Saqueadores ocupam a costa norte, de cima da mina rumo a leste até {area:916}: siga pela praia para leste. Eles fogem com pouca vida: puxe um de cada vez.",
	-- plural, as words: Longshore Murloc Gills = {item:254548} Longshore Murloc Gill
	["Longshore Murloc Gills"] = "Barbatanas de Murloc da Praia Grande",

	-- Step 32: Furlbrow's Wardrobe
	-- {object:290} Furlbrow's Wardrobe · {area:916} The Jansen Stead · {npc:502} Benny Blaanco
	["{object:290} stands in the ruined house east of the mine, on the way to the {area:916}.\nCareful: Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "{object:290} fica na casa em ruínas a leste da mina, no caminho para {area:916}.\nCuidado: dois Défias montam guarda lá dentro, um deles o chamado {npc:502}, de nível 15. Eles estão ligados: atacar qualquer um dos dois chama os dois.",
	-- {object:290} Furlbrow's Wardrobe
	["{object:290}; inside"] = "{object:290}; lá dentro",

	-- Step 33: The Jansen Stead
	["Sacks of Oats in the fields around the farm"] = "Sacos de Aveia nos campos em volta da fazenda",
	["Fill the vial at the well"] = "Encha o frasco no poço",

	-- Step 34: Finish the Goretusk Livers
	-- plural, as words: Goretusk Livers = {item:723} Goretusk Liver
	["Finish the Goretusk Livers"] = "Termine os Fígados de Goretusco",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Goretusks = {npc:454} Young Goretusk
	["Still short of eight? Young Goretusks root in the fields just west of {area:107}."] = "Ainda não chegou a oito? Goretuscos Jovens fuçam nos campos logo a oeste de {area:107}.",

	-- Step 35: Finish the Stringy Vulture Meat
	-- {item:729} Stringy Vulture Meat
	["Finish the {item:729}"] = "Termine {item:729}",
	-- {area:107} Saldean's Farm
	-- plural, as words: Young Fleshrippers = {npc:199} Young Fleshripper
	["Still short of three? Young Fleshrippers circle the fields north-west of {area:107}."] = "Ainda não chegou a três? Ripa-carnes Jovens rondam os campos a noroeste de {area:107}.",

	-- Step 37: Finish the Red Leather Bandanas
	-- {quest:153} Red Leather Bandanas
	["Finish the {quest:153}"] = "Termine {quest:153}",
	-- {area:108} Sentinel Hill
	-- plural, as words: Defias Trappers = {npc:504} Defias Trapper
	["Still short of fifteen? Defias Trappers camp in the fields just west of {area:108}."] = "Ainda não chegou a quinze? Coureadores Défias acampam nos campos logo a oeste de {area:108}.",

	-- Step 38: Sentinel Hill
	-- {npc:266} Wiley the Black · {area:69} Lakeshire
	["For {npc:266} in {area:69}, Redridge"] = "Para {npc:266} em {area:69}, Montanhas Cristarrubra",

	-- Step 39: Jangolode Mine
	-- {area:918} Molsen Farm
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Back north past {area:918} to the mine: Kobold Diggers work inside."] = "Volte ao norte, passando por {area:918}, até a mina: Escavadores Kobold trabalham lá dentro.",
	-- plural, as words: Kobold Diggers = {npc:1236} Kobold Digger
	["Kobold Diggers"] = "Escavadores Kobold",

	-- Step 40: The Gold Coast Quarry
	-- {area:113} Gold Coast Quarry
	["The {area:113}"] = "{area:113}",
	-- {area:918} Molsen Farm
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["South-west to the coast, west of {area:918}. Riverpaw Miners work the quarry."] = "Para sudoeste, até o litoral, a oeste de {area:918}. Mineradores Pata Molhada trabalham na pedreira.",
	-- plural, as words: Riverpaw Miners = {npc:1426} Riverpaw Miner
	["Riverpaw Miners"] = "Mineradores Pata Molhada",

	-- Step 41: Moonbrook: kill these as you meet them
	-- {area:20} Moonbrook
	["{area:20}: kill these as you meet them"] = "{area:20}: vá matando estes pelo caminho",
	-- {area:108} Sentinel Hill · {area:20} Moonbrook · {object:1166} Alexston's Chest · {area:219} Alexston Farmstead · {npc:1646} Baros Alexston · {area:113} Gold Coast Quarry
	-- plural, as words: Defias Pillagers = {npc:589} Defias Pillager
	["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}. {object:1166} stands in the farmhouse at the {area:219}, among them: {npc:1646}' compass is inside.\nCareful: The {area:113} cave holds many Defias packed together, so it is easy to pull several at once there."] = "Pilhadores e Gatunos Défias dominam as fazendas a oeste de {area:108}, entre a estrada da costa e {area:20}. {object:1166} fica na casa de fazenda em {area:219}, entre eles: a bússola de {npc:1646} está lá dentro.\nCuidado: a caverna de {area:113} tem muitos Défias juntos, então é fácil puxar vários de uma vez lá.",
	-- {item:2998} A Simple Compass · {object:1166} Alexston's Chest
	["{item:2998}, from {object:1166}"] = "{item:2998}, do {object:1166}",

	-- Step 44: Defensive Stance
	-- {zone:1436} Westfall · {zone:1453} Stormwind · {zone:1455} Ironforge · {object:28027} Dwarven District · {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern · {quest:1638} A Warrior's Training · {quest:1639} Bartleby the Drunk
	["From {zone:1436}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "De {zone:1436}, caminhe até {zone:1453}; o metrô de {zone:1455} chega no {object:28027}. {npc:5480} treina guerreiros na {object:2100}; {npc:6089} e {npc:6090} ficam juntos ao lado da {object:2152}. {npc:6090} luta com você pela caneca dele. Se {npc:5480} não oferecer {quest:1638}, vá direto a {npc:6089}: ele entrega {quest:1639} mesmo sem ela.",

	-- Step 46: High Priestess Laurena
	-- {zone:1453} Stormwind · {npc:376} High Priestess Laurena
	["Walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Caminhe até {zone:1453}. {npc:376} está na Catedral da Luz.",

	-- Step 48: The Tome of Divinity
	-- {npc:6171} Duthorian Rall · {npc:6173} Gazin Tenorm · {npc:6174} Stephanie Turner · {object:2096} Trade District · {item:2589} Linen Cloth
	["{npc:6171} and {npc:6173} are in the Cathedral of Light; {npc:6174} stands in the {object:2096} and asks for ten {item:2589} (humanoids drop it; the Auction House sells it)."] = "{npc:6171} e {npc:6173} ficam na Catedral da Luz; {npc:6174} fica no {object:2096} e pede dez {item:2589} (humanoides deixam cair; a Casa de Leilões vende).",
	-- {item:6775} Tome of Divinity
	["Right-click the {item:6775} he gives you"] = "Clique com o botão direito no {item:6775} que ele entrega",
	-- {npc:6172} Henze Faulk · {area:86} Stone Cairn Lake
	["{npc:6172}, by {area:86} in Elwynn, on the road to Redridge"] = "{npc:6172}, perto de {area:86} em Elwynn, na estrada para Cristarrubra",

	-- Step 49: Stormwind
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["{zone:1453}'s {object:28027}"] = "",

	-- Step 50: Tram to Ironforge
	-- {zone:1455} Ironforge
	["Tram to {zone:1455}"] = "Metrô para {zone:1455}",

	-- Step 51: Shaman training
	["Shaman training"] = "Treinamento de xamã",
	-- {zone:1453} Stormwind · {area:2257} Deeprun Tram · {object:28027} Dwarven District · {zone:1455} Ironforge · {npc:258098} Eldrun Stormbreaker
	["Head to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Vá até {zone:1453}. Não tem treinador de xamã: pegue o {area:2257} do {object:28027} até {zone:1455}, treine com {npc:258098}, depois pegue o bonde de volta para o barco.",

	-- Step 52: Stormwind
	-- {area:1519} Stormwind · {object:2100} Old Town · {object:2101} Mage Quarter · {object:28027} Dwarven District
	["Walk to {area:1519}, or fly if you know its flight path. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the {object:28027} (Hunters), the Park (Druids)."] = "Caminhe até {area:1519}, ou voe, se você já conhece a rota de voo. Instrutores: {object:2100} (Guerreiros, Ladinos), a Catedral (Paladinos, Sacerdotes), {object:2101} (Magos, Bruxos), {object:28027} (Caçadores), o Parque (Druidas).",
	["In through the main gate (already done if you are in the city)"] = "Entre pelo portão principal (você já fez isso se estiver na cidade)",
	["Level 12, 14 and 16 spells"] = "Feitiços de nível 12, 14 e 16",

	-- Step 53: Back to Stormwind
	-- {zone:1453} Stormwind
	["Back to {zone:1453}"] = "De volta a {zone:1453}",
	-- {zone:1453} Stormwind · {object:28027} Dwarven District
	["Ride the tram back: it comes out in {zone:1453}'s {object:28027}, where the errands below start."] = "Volte de metrô: ele sai em {object:28027}, de {zone:1453}, onde começam as tarefas abaixo.",

	-- Step 54: Stormwind
	-- {item:2449} Earthroot · {zone:1439} Darkshore · {npc:1313} Maria Lumere
	["{item:2449} for Gathering the Cure (6123) in {zone:1439}: {npc:1313}, Alchemy Supplies; herbalists pick it there instead"] = "{item:2449} para Colhendo a cura (6123) em {zone:1439}: {npc:1313}, Suprimentos de Alquimia; herbalistas a colhem lá mesmo",
	-- {npc:7232} Borgus Steelhand · {object:28027} Dwarven District · {area:442} Auberdine
	["{npc:7232}, {object:28027}: for his brother in {area:442}"] = "{npc:7232}, {object:28027}: para o irmão dele em {area:442}",
	-- {npc:5497} Jennea Cannon · {quest:1861} Mirror Lake
	["{npc:5497}, Wizard's Sanctum: {quest:1861}"] = "{npc:5497}, no Sacrário dos Teurgos: {quest:1861}",

	-- Step 56: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Warrior fastest."] = "Já que está aqui: aprenda {spell:202} com {npc:11867} ({object:2096}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Guerreiro.",

	-- Step 57: Woo Ping
	-- {spell:202} Two-Handed Swords · {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn {spell:202} from {npc:11867} ({object:2096}, 10 silver); two-handers level a Paladin fastest."] = "Já que está aqui: aprenda {spell:202} com {npc:11867} ({object:2096}, 10 pratas); arma de duas mãos é o jeito mais rápido de upar Paladino.",

	-- Step 58: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a Hunter's melee weapon is mostly its stats, and two-handers carry the most."] = "Já que está aqui: aprenda Cajados com {npc:11867} ({object:2096}, 10 pratas); a arma corpo a corpo do Caçador vale pelos atributos, e as de duas mãos são as que mais trazem.",

	-- Step 59: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Swords from {npc:11867} ({object:2096}, 10 silver); a sword in the main hand levels a Rogue steadily."] = "Já que está aqui: aprenda Espadas com {npc:11867} ({object:2096}, 10 pratas); espada na mão principal faz o Ladino subir de nível sem tropeço.",

	-- Step 60: Woo Ping
	-- {npc:11867} Woo Ping · {object:2096} Trade District
	["While you're here: learn Staves from {npc:11867} ({object:2096}, 10 silver); a staff carries more spell stats than a one-hander while you level."] = "Já que está aqui: aprenda Cajados com {npc:11867} ({object:2096}, 10 pratas); enquanto você sobe de nível, um cajado traz mais atributos de feitiço que uma arma de uma mão.",

	-- Step 62: Fishin' Time
	-- {npc:5494} Catherine Leland · {object:2096} Trade District · {npc:267118} Gilbert Gray
	["{npc:5494} sells fishing supplies along the canal just west of the {object:2096}; {npc:267118} fishes at the harbor, on the way to the boat."] = "{npc:5494} vende suprimentos de pesca junto ao canal, logo a oeste de {object:2096}; {npc:267118} pesca no porto, a caminho do barco.",
	-- {item:6529} Shiny Bauble · {npc:5494} Catherine Leland
	["{item:6529}, from {npc:5494}"] = "{item:6529}, de {npc:5494}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:108}"] = "De volta a {area:108}",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon."] = "Tocaiantes e Rufiões Défias andam por {area:20}; Bandoleiros (nível 17) patrulham em duplas as colinas ao sul e a leste: puxe-os separados. A entrada de {area:1581}, na ferraria, é uma masmorra de grupo.",
	-- ["Defias Pathstalkers and Knuckledusters walk {area:20}; Highwaymen (level 17) patrol the hills south and east of it in pairs: pull them apart. {area:1581} entrance in the smithy is a group dungeon.\nCareful: The camps in the hills hold mixed groups of Defias, so it is easy to pull more than one at a time if you are low level."] = "Tocaiantes e Rufiões Défias andam por {area:20}; Bandoleiros (nível 17) patrulham as colinas ao sul e a leste em duplas: separe-os. A entrada de {area:1581}, na ferraria, é de uma masmorra de grupo.\nCuidado: os acampamentos das colinas misturam vários tipos de Défias, então é fácil puxar mais de um de uma vez se você estiver com nível baixo.",
	-- ["Defias Pillagers and Looters hold the farms west of {area:108}, between the coast road and {area:20}."] = "Pilhadores e Gatunos Défias ocupam as fazendas a oeste de {area:108}, entre a estrada do litoral e {area:20}.",
	-- ["Defias Trappers and Smugglers camp in the fields between {area:108} and {area:918}.\nWest of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone.\nYoung Goretusks and Fleshrippers roam every leg of this loop: their livers and meat are for the pie and the stew."] = "Coureadores e Contrabandistas Défias acampam nos campos entre {area:108} e {area:918}.\nA oeste de Saldean. Guarda-colheitas e Golens trabalham nos campos; eles soltam as isomolas, os giroestabilizadores, {item:732} e, às vezes, {item:255155}. {npc:573}, um raro de nível 20, anda por aqui: deixe-o em paz.\nGorestuscos Jovens e Ripa-carnes vagam por todo o trecho deste circuito: os fígados e a carne deles são para a torta e o ensopado.",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Voe ou cavalgue até {zone:1453}. Instrutores: {object:2100} (guerreiros, ladinos), a Catedral da Luz (paladinos, sacerdotes), {object:2101} (magos, bruxos), o Parque (druidas).",
	-- ["Fly or ride to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids). {npc:11026} works in the {object:28027}, {npc:279} in the {object:2096}."] = "Voe ou cavalgue até {zone:1453}. Instrutores: {object:2100} (guerreiros, ladinos), a Catedral da Luz (paladinos, sacerdotes), {object:2101} (magos, bruxos), o Parque (druidas). {npc:11026} trabalha em {object:28027}; {npc:279}, em {object:2096}.",
	-- ["Fly or ride to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Voe ou cavalgue até {zone:1453}. {npc:376} está na Catedral da Luz.",
	-- ["Fly or ride to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Voe ou cavalgue até {zone:1453}. {npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto de {object:2152}, ali. {npc:6090} luta com você pela caneca dele.",
	-- ["Fly or walk to {zone:1453}. Trainers: {object:2100} (Warriors, Rogues), the Cathedral (Paladins, Priests), the {object:2101} (Mages, Warlocks), the Park (Druids)."] = "Voe ou caminhe até {zone:1453}. Treinadores: {object:2100} (Guerreiros, Trapaceiros), a Catedral (Paladinos, Sacerdotes), {object:2101} (Magos, Bruxos), o Parque (Druidas).",
	-- ["Fly or walk to {zone:1453}. {npc:376} is in the Cathedral of Light."] = "Voe ou caminhe até {zone:1453}. {npc:376} está na Catedral da Luz.",
	-- ["Fly or walk to {zone:1453}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "Voe ou caminhe até {zone:1453}. {npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto de {object:2152} lá. {npc:6090} luta com você pela sua caneca.",
	-- ["Follow the road from Elwynn into {zone:1436}: the Furlbrows sit by their burned farm, the first one on the road. Collect the oats from the Sacks of Oats in the fields as you go."] = "Siga a estrada de Elwynn para {zone:1436}: os Furlbrow estão sentados perto da fazenda queimada, a primeira na estrada. Colete a aveia dos Sacos de Aveia dos campos enquanto avança.",
	-- ["Follow the road north. {npc:233} stands outside, {npc:235} in the house, {npc:253395} in the barn to the west."] = "Siga a estrada para o norte. {npc:233} fica do lado de fora, {npc:235} dentro da casa e {npc:253395} no celeiro a oeste.",
	-- ["For {npc:11026} in {zone:1453}'s {object:28027}"] = "Para {npc:11026} em {object:28027}, {zone:1453}",
	-- ["From {area:40}, walk to {zone:1453}; the tram from {zone:1455} arrives in the {object:28027}. {npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug. If {npc:5480} doesn't offer {quest:1638}, go straight to {npc:6089}: he gives {quest:1639} without it."] = "De {area:40}, caminhe até {zone:1453}; o metrô de {zone:1455} chega no {object:28027}. {npc:5480} treina guerreiros na {object:2100}; {npc:6089} e {npc:6090} ficam juntos ao lado da {object:2152}. {npc:6090} luta com você pela caneca dele. Se {npc:5480} não oferecer {quest:1638}, vá direto a {npc:6089}: ele entrega {quest:1639} mesmo sem ela.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go and fill the vial at the stead's well."] = "Mais ao norte pela estrada. Os Taturana estão sentados junto à fazenda incendiada. No caminho, colete a aveia dos Sacos de Aveia nos campos e encha o frasco no poço da propriedade.",
	-- ["Further north along the road. The Furlbrows sit by their burned farm. Collect the oats from the Sacks of Oats in the fields as you go."] = "Mais ao norte pela estrada. Os Taturana estão sentados junto à fazenda incendiada. No caminho, colete a aveia dos Sacos de Aveia nos campos.",
	-- ["Hearthstone on cooldown? Follow the road north-east."] = "Pedra de Regresso em recarga? Siga a estrada para o nordeste.",
	-- ["Murloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time."] = "Murlocs Correcosta e Murlocs Saqueadores ocupam a praia ao norte da mina. Eles fogem com pouca vida: puxe um de cada vez.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine, Kobold Diggers work inside. {object:290} stands by the ruined house east of the mine."] = "Ao norte da Fazenda dos Peçanha. Coureadores e Contrabandistas Défias acampam do lado de fora da mina; Escavadores Kobold trabalham lá dentro. {object:290} fica junto à casa em ruínas a leste da mina.",
	-- ["North of Molsen Farm. Defias Trappers and Smugglers camp outside the mine. {object:290} stands by the ruined house east of the mine."] = "Ao norte da Fazenda dos Peçanha. Coureadores e Contrabandistas Défias acampam do lado de fora da mina. {object:290} fica junto à casa em ruínas a leste da mina.",
	-- ["Only if he takes the isosprings alone"] = "Só se ele aceitar apenas as isomolas",
	-- ["Ride to {zone:1453}. It has no shaman trainer: take the {area:2257} from the {object:28027} to {zone:1455}, train with {npc:258098}, then ride the tram back for the boat."] = "Cavalgue até {zone:1453}. Lá não há instrutor de xamãs: pegue o {area:2257} em {object:28027} até {zone:1455}, treine com {npc:258098} e volte de metrô para pegar o barco.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills."] = "Gnolos e Exploradores Pata-do-Rio (nível 11-13) rondam as colinas ao sul da costa, de acima de {area:111} a leste até o {area:916}. Os gnolos mais ao sul e oeste são nível 13-19: fique nas colinas do norte.",
	-- ["Riverpaw Gnolls and Scouts (level 11-13) roam the hills south of the coast, from above {area:111} east to the {area:916}. The gnolls further south and west are 13-19: stay in the north hills.\nMurloc Coastrunners and Raiders line the beach north of the mine. They flee at low health: pull one at a time.\nCareful: Gnolls that stand close together tend to join a fight as a group. Pulling one at a time is safer.\nCareful: {object:290} stands in the ruined house east of the mine, on the way to the {area:916}. Two Defias stand guard inside, one of them the level 15 named {npc:502}. They are linked, so attacking either one brings both."] = "Gnolls Pata Molhada e Batedores Pata Molhada (nível 11-13) vagam pelas colinas ao sul da costa, de cima de {area:111} para leste até {area:916}. Os gnolls mais ao sul e a oeste são de nível 13-19: fique nas colinas do norte.\nMurlocs Correcosta e Saqueadores ocupam a praia ao norte da mina. Eles fogem com pouca vida: puxe um de cada vez.\nCuidado: gnolls que ficam bem juntos tendem a entrar na luta em grupo. Puxar um de cada vez é mais seguro.\nCuidado: {object:290} fica na casa em ruínas a leste da mina, no caminho para {area:916}. Dois Défias montam guarda lá dentro, um deles o {npc:502}, nomeado de nível 15. Eles são ligados, então atacar um traz os dois.",
	-- ["Riverpaw Gnolls and Scouts roam the hills between the coast and the {area:916}."] = "Gnolls e Batedores Pata Molhada vagam pelas colinas entre o litoral e o {area:916}.",
	-- ["Sacks of Oats"] = "Sacos de Aveia",
	-- ["Stormwind"] = "Ventobravo",
	-- ["The gnoll hills"] = "As colinas dos gnolls",
	-- ["The north coast"] = "O litoral norte",
	-- ["The western farms"] = "As fazendas do oeste",
	-- ["West of Molsen Farm, toward the coast. Riverpaw Miners work the quarry."] = "A oeste da Fazenda dos Peçanha, rumo ao litoral. Mineradores Pata Molhada trabalham na pedreira.",
	-- ["West of Saldean's. Harvest Watchers and Golems work the fields; they drop the isosprings, gyrostabilizers, {item:732} and sometimes a {item:255155}. {npc:573}, a level 20 rare, walks here: leave it alone. Keep killing Goretusks and Fleshrippers on every leg of this loop."] = "A oeste da fazenda Saldanha. Guarda-colheitas e Golens Colheiteiros trabalham nos campos; eles soltam as isomolas, os giroestabilizadores, {item:732} e às vezes um {item:255155}. {npc:573}, um raro de nível 20, anda por aqui: deixe-o em paz. Continue matando Goretuscos e Ripa-carnes em cada trecho deste circuito.",
	-- ["Young Goretusks and Fleshrippers roam the fields around the farm: start on livers and the stew's meat on the way back."] = "Goretuscos Jovens e Ripa-carnes vagam pelos campos ao redor da fazenda: comece a juntar fígados e a carne do ensopado na volta.",
	-- ["{area:109}: kill these as you meet them"] = "{area:109}: vá matando estes pelo caminho",
	-- ["{area:20} and the Defias hills"] = "{area:20} e as colinas Défias",
	-- ["{area:918}: kill these as you meet them"] = "{area:918}: vá matando estes pelo caminho",
	-- ["{item:254676}, from the crates around {area:20}"] = "{item:254676}, dos caixotes ao redor de {area:20}",
	-- ["{npc:234} and {npc:821} stand at the top of the stone tower. {npc:491} is in the tower, {npc:878} and {npc:253092} on the south side of the hill, next to the inn and {npc:523} the gryphon master."] = "{npc:234} e {npc:821} ficam no alto da torre de pedra. {npc:491} está na torre; {npc:878} e {npc:253092}, no lado sul do morro, junto à estalagem e a {npc:523}, o mestre de grifos.",
	-- ["{npc:523}; skip the free flight it offers"] = "{npc:523}; pule o voo grátis que ele oferece",
	-- ["{quest:153}: every Defias drops them"] = "{quest:153}: todos os Défias as soltam",
	-- ["{quest:153}: every Defias drops them, from {area:111} to the {area:916}"] = "{quest:153}: todo Défias solta, de {area:111} até {area:916}",
}
