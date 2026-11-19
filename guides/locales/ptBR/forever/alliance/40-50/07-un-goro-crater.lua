-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. This first visit keeps to the crater's eastern half, where the beasts are 48-52, so pull them one at a time; the pylons, the bones and the hive wait for the later Un'Goro visit at about 56."] = "Para personagens de nível 49 a 50, mas a maioria das missões aqui é de nível 51-53: de propósito, pela experiência. Esta primeira visita fica na metade leste da cratera, onde as feras são de nível 48-52, então puxe uma de cada vez; os pilares, os ossos e a colmeia ficam para a visita posterior a Un'Goro, por volta do nível 56.",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",
	-- {zone:1455} Ironforge
	["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",

	-- Step 3: Theramore
	["Theramore"] = "Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} fica nas docas onde o barco atraca.",

	-- Step 4: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "Voar para {area:976}",
	["Theramore flight master"] = "Mestre de voo de Theramore",

	-- Step 5: Gadgetzan
	-- {area:976} Gadgetzan
	["The flight from Theramore lands in {area:976}."] = "O voo de Theramore pousa em {area:976}.",

	-- Step 6: Marin Noggenfogger
	["You missed this on the route's earlier visit here: it comes first now. It is quick and opens the quests after it."] = "Você perdeu isto na visita anterior da rota a esta região: vem primeiro agora. É rápido e abre as missões seguintes.",

	-- Step 8: The Noxious Lair
	-- {npc:4196} Silithid Swarm
	-- plural, as words: Centipaar Swarmers = {npc:5457} Centipaar Swarmer
	["Ride west to the Centipaar hive in the dunes. Any Centipaar can drop insect parts.\nCareful: Centipaar Swarmers cast {npc:4196} both in and out of combat, which brings small adds that interrupt you."] = "Cavalgue para oeste até a colmeia Centiparte nas dunas. Qualquer Centiparte pode deixar cair partes de inseto.\nCuidado: Enxameadores Centiparte lançam {npc:4196} dentro e fora de combate, o que traz pequenos adds que interrompem você.",

	-- Step 9: Dunemaul Compound
	-- {npc:12046} Gor'marok the Ravager
	["Ride south to the ogre compound. Brutes and Enforcers (46-48) fill it; {npc:12046} (49) stands in the middle with guards around him: clear them first."] = "Cavalgue para o sul até o complexo dos ogros. Brutos e Impositores (46-48) o enchem; {npc:12046} (49) fica no meio, cercado de guardas: limpe-os primeiro.",
	-- {npc:12046} Gor'marok the Ravager
	["{npc:12046}, below ground"] = "{npc:12046}, no subterrâneo",

	-- Step 10: Thistleshrub Valley: kill these as you meet them
	-- {quest:3362} Thistleshrub Valley
	["{quest:3362}: kill these as you meet them"] = "{quest:3362}: vá matando estes pelo caminho",
	-- {quest:3362} Thistleshrub Valley
	-- plural, as words: Gnarled Thistleshrubs = {npc:5490} Gnarled Thistleshrub
	["Ride west into {quest:3362}. The Dew Collectors drop the glands; only some are full, so keep the Laden one. Gnarled Thistleshrubs and Rootshapers share the valley.\nCareful: the thistleshrubs wander a lot, so you can easily pull extra mobs."] = "Cavalgue para oeste até {quest:3362}. Os Coletores de Orvalho deixam cair as glândulas; só algumas estão cheias, então guarde a Carregada. Moitagulhas Rotos e Moldarraízes dividem o vale.\nCuidado: os moitagulhas vagam muito, então é fácil puxar monstros a mais.",

	-- Step 11: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn
	["Ride back north-east to {area:976}: {npc:11758} stands on the east side of town."] = "Cavalgue de volta para nordeste até {area:976}: {npc:11758} fica no lado leste da cidade.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, lá dentro",

	-- Step 12: The Gaping Chasm
	-- {area:1938} Broken Pillar · {area:981} The Gaping Chasm
	["Ride south past the {area:1938} to the {area:981}, the Hazzali tunnels; Scrimshank's gear lies deep inside.\nCareful: One bug guards the gear. Many bugs patrol the tunnels, some of them level 50, so fights often pull extra adds."] = "Cavalgue para o sul, passando por {area:1938}, até {area:981}, os túneis dos Hazzali; o aparelho do Anilhacido está lá no fundo.\nCuidado: um inseto guarda o aparelho. Muitos insetos patrulham os túneis, alguns de nível 50, então as lutas costumam trazer bicho a mais.",
	-- {item:8593} Scrimshank's Surveying Gear
	["{item:8593}; below ground"] = "{item:8593}; no subterrâneo",

	-- Step 13: Gadgetzan
	-- {npc:7740} Gracina Spiritmight · {zone:1457} Darnassus · {zone:1428} Burning Steppes
	["For {npc:7740} in {zone:1457}, at the end of the {zone:1428} guide: keep it"] = "Para {npc:7740} em {zone:1457}, no fim do guia de {zone:1428}: guarde-o",

	-- Step 15: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Siga para o oeste, saindo de {area:976}, até a longa rampa que desce para {zone:1449}. {npc:9619} acampa ao pé da rampa, no canto sudeste da cratera.",

	-- Step 16: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder · {item:280459} Crystal Infused Scale
	-- plural, as words: Venomhide Ravasaurs = {npc:6508} Venomhide Ravasaur
	["The dead Threshadon lies by the water north of {npc:9619}.\nCareful: Venomhide Ravasaurs (50-51) hunt along the water there: pull them one at a time before you loot the carcass.\nAny ravasaur may drop a {item:280459}: right-click it, {npc:9619} takes it."] = "O Debulhadon morto está junto à água, ao norte de {npc:9619}.\nCuidado: Ravassauros Pelenosos (50-51) caçam ao longo da água ali: puxe um de cada vez antes de saquear a carcaça.\nQualquer ravassauro pode deixar cair uma {item:280459}: clique com o botão direito nela, {npc:9619} a recebe.",

	-- Step 17: Torwa Pathfinder
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale"] = "{quest:87494}, se um ravassauro deixou cair a escama",
	-- {area:1943} Ironstone Plateau
	["The gorillas on {area:1943} carry the pelts: keep it for the second Un'Goro visit, around 56"] = "Os gorilas de {area:1943} carregam as peles: guarde para a segunda visita a Un'Goro, por volta do nível 56",

	-- Step 18: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Lar'korwi Fêmeas e a jangada",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "As Lar'korwi Fêmeas rondam a selva a oeste de {npc:9619}. A jangada destruída fica na margem do lago ali; a mochila pequena está na água ao lado. Guarde a bússola, o mapa e a chave para {npc:8737}. Qualquer fera da cratera pode deixar cair {item:11116}: clique com o botão direito nele.",
	-- {object:161504} A Small Pack
	["{object:161504}, underwater"] = "{object:161504}, debaixo d'água",

	-- Step 19: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Back east to {npc:9619} with the glands."] = "Volte para o leste até {npc:9619} com as glândulas.",

	-- Step 20: Marshal's Refuge
	-- {npc:271301} Power Crystal · {object:157936} Un'Goro Dirt Pile
	["Ride north-west to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Cavalgue para noroeste até o refúgio.\nPasse bem longe dos Demossauros e Estegodons elite. Daqui em diante, pegue todo {npc:271301} e {object:157936} que encontrar.",
	-- {npc:9998} Shizzle
	["{npc:9998}: his scales come from the young beasts of the eastern jungle"] = "{npc:9998}: as escamas dele vêm das feras jovens da selva leste",
	-- {npc:8737} Linken
	["{npc:8737}, at the back of the refuge"] = "{npc:8737}, no fundo do refúgio",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Termina com {npc:9298}, em {zone:1452}: guarde",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, no fundo da caverna; no subterrâneo",
	-- {npc:9272} Spark Nilminer · {npc:9271} Hol'anyee Marshal · {npc:9270} Williden Marshal · {npc:9618} Karna Remtravel
	["{npc:9272}, {npc:9271}, {npc:9270} and {npc:9618} have quests among mobs of 51-55: leave them for the later Un'Goro visit, at about 56."] = "{npc:9272}, {npc:9271}, {npc:9270} e {npc:9618} têm missões entre monstros de nível 51-55: deixe-as para a segunda visita a Un'Goro, por volta do nível 56.",

	-- Step 21: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} e a selva leste",
	-- {quest:3764} Un'Goro Soil · {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:9165} Fledgling Pterrordax
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher · Living Blazes = {npc:6521} Living Blaze · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride east into the eastern jungle: Bloodpetal Lashers and Threshers (48-50) drop the petals and {quest:3764}. Crystal clusters stand all over the crater, many around the foot of {area:537}: take a few extra of each colour.\nCareful: the Living Blazes (54-55) walk the top of {area:537}, and the Bloodpetal Flayers and Trappers (51-53) hold the jungle's south: take your crystals from the ridge's foot and your petals in the north.\n{npc:9998}'s scales: the {npc:9165} (48-50) glide over the north-east of the jungle and the Young Diemetradons (49-50) graze beside them. There are only ten of those: the Diemetradons (51) on the jungle's western edge, a short way west of the Threshers, drop the scales too. They are a level over you: take them one at a time."] = "Siga para o leste, entrando na selva leste: as Açoitadeiras Pétala Sangrenta e as Debulhadoras (48-50) deixam cair as pétalas e {quest:3764}. Há aglomerados de cristais por toda a cratera, muitos ao pé de {area:537}: pegue alguns a mais de cada cor.\nCuidado: as Chamas Vivas (54-55) andam pelo topo de {area:537}, e as Esfoladoras e Armadilheiras Pétala Sangrenta (51-53) ocupam o sul da selva: pegue os cristais ao pé da cordilheira e as pétalas no norte.\nEscamas para {npc:9998}: os {npc:9165} (48-50) planam sobre o nordeste da selva e os Dimetrodontes Jovens (49-50) pastam ao lado. Só há dez desses: os Dimetrodontes (51) na borda oeste da selva, um pouco a oeste das Debulhadoras, também deixam cair as escamas. Estão um nível acima de você: enfrente um de cada vez.",
	-- {item:11316} Bloodpetal
	["{item:11316}, from the Lashers and Threshers"] = "{item:11316}, das Açoitadeiras e Debulhadoras",
	-- {quest:3764} Un'Goro Soil
	["{quest:3764}, from the Threshers and the dirt piles"] = "{quest:3764}, das Debulhadoras e dos montes de terra",

	-- Step 22: Lakkari Tar Pits
	-- plural, as words: Tar Lords = {npc:6519} Tar Lord
	["Crystal clusters stand all over the crater. The pits' Tar Lords (53-54) and the oozes around them (50-54) are over you: take the clusters on the jungle's north-eastern edge, among the Lashers and young beasts (48-50)."] = "Há aglomerados de cristais por toda a cratera. Os Senhores do Piche (53-54) dos poços e os limos ao redor (50-54) estão acima do seu nível: pegue os aglomerados na borda nordeste da selva, entre as Açoitadeiras e as feras jovens (48-50).",

	-- Step 23: Marshal's Refuge
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, no subterrâneo",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Para {npc:7775}, em {zone:1444}: guarde",

	-- Step 24: Level 49.79
	["Level 49.79"] = "Nível 49.79",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Still short of level 49.79 after the refuge's hand-ins? Top up on the Bloodpetal Lashers and Threshers (48-50) of the eastern jungle, where you took the petals, before you leave the crater."] = "Ainda abaixo do nível 49.79 depois das entregas do refúgio? Complete nas Açoitadeiras Pétala Sangrenta e Debulhadoras (48-50) da selva leste, onde pegou as pétalas, antes de sair da cratera.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "mate {npc:6511} até subir",

	-- Step 25: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Voe para {area:415}",
	-- {zone:1455} Ironforge · {zone:1427} Searing Gorge · {zone:1440} Ashenvale · {zone:1447} Azshara
	["The {zone:1455} quests were taken at the end of the {zone:1427} guide: fly straight on to {zone:1440} for {zone:1447}."] = "As missões de {zone:1455} foram pegas no final do guia de {zone:1427}: voe direto para {zone:1440} para ir a {zone:1447}.",
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Mestre de voo de {area:541}",

	-- Step 26: To Ironforge
	-- {zone:1455} Ironforge
	["To {zone:1455}"] = "Para {zone:1455}",

	-- Step 27: Mystic Ward
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: para Ogtinc, em {zone:1447}, guarde",
	-- {npc:7312} Dink · {npc:8395} Sanath Lim-yo · {zone:1447} Azshara
	["{npc:7312}, the mage trainer: for {npc:8395} in {zone:1447}, keep it"] = "{npc:7312}, o instrutor de magos: para {npc:8395} em {zone:1447}, mantenha a missão",

	-- Step 30: Fly to Astranaar
	-- {area:442} Auberdine
	["{area:442} flight master"] = "Mestre de voo de {area:442}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Archesonus stands beside King Magni in the {object:171709}."] = "Arquefilis fica ao lado do Rei Magni, em {object:171709}.",
	-- ["Below ground"] = "No subterrâneo",
	-- ["Bind and train"] = "Vincule e treine",
	-- ["Bones and equipment"] = "Ossos e equipamentos",
	-- ["Class trainer"] = "Instrutor de classe",
	-- ["Cross the south of the crater to {npc:9619} by the ramp."] = "Atravesse o sul da cratera até {npc:9619}, junto à rampa.",
	-- ["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Ossos de Dinossauro ficam no chão no sudoeste, entre os estegodons: eles são elite, pegue os ossos ao redor deles e consiga o resto com os Dimetrodontes. O {item:11112} da expedição fica na selva sudoeste.",
	-- ["Eastern Pylon"] = "Torre de Cristal Leste",
	-- ["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- ["Fly from {area:144} to {area:1537}."] = "Voe de {area:144} para {area:1537}.",
	-- ["Fly to {area:1537}"] = "Voe para {area:1537}",
	-- ["For characters of 49 to 50, but most quests here are level 51-53: on purpose, for their experience. The crater's beasts are 48-55 and the Gorishi silithids 51-54, so pull them one at a time."] = "Para personagens de nível 49 a 50, mas a maioria das missões aqui é de nível 51-53: de propósito, pela experiência. As feras da cratera são de nível 48-55 e os silitídeos Gorishi, 51-54, então puxe um de cada vez.",
	-- ["Four rune rubbings in {zone:1447}: keep it"] = "Quatro decalques de runas em {zone:1447}: guarde",
	-- ["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "De {area:144}, voe para {area:150}, pegue o barco para Theramore e voe até {area:976}. A primeira missão de {npc:9619} na cratera exige nível 48: complete o nível aqui se faltar.",
	-- ["Grind to 50"] = "Suba até o nível 50",
	-- ["Grind to 51"] = "Suba até o nível 51",
	-- ["Gryfe"] = "Gryfe",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",
	-- ["Level 50.4"] = "Nível 50.4",
	-- ["Northern Pylon"] = "Torre de Cristal Norte",
	-- ["Pterrordax"] = "Pterrordax",
	-- ["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Desça a rampa para a cratera: {npc:9619} acampa ao pé dela.",
	-- ["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Siga para o leste até {area:1943}, onde o robô fica entre os gorilas. Não entre na caverna funda dali.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Siga para o leste até {area:537}, suba e use {npc:10541} nas aberturas de lava perto do topo.",
	-- ["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Siga para o norte pelo lado leste da cratera até {area:541}, o acampamento nas cavernas do penhasco norte. Fique longe dos demossauros e estegodons elite. Daqui em diante, pegue todo Cristal de Poder e {object:157936} que encontrar.",
	-- ["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Siga para o norte pelo lado leste até o planalto dos gorilas. {npc:9622}, um gorila de nível 55, fica na caverna mais funda: limpe os gorilas da entrada antes.",
	-- ["Ride north along the western jungle back to the refuge."] = "Siga para o norte pela selva oeste de volta ao refúgio.",
	-- ["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Siga para o norte até {area:1943}, onde o robô fica entre os gorilas. Não entre na caverna funda dali.",
	-- ["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Siga para o sul pelos penhascos leste até {npc:9619}, ao pé da rampa.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "Desça para o sul pelo lado leste. Dimetrodontes Jovens pastam na selva leste e {npc:9165} voam perto dos penhascos leste; os dois deixam cair as escamas de {npc:9998}.",
	-- ["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales. The crate sits at the abandoned camp in the eastern jungle."] = "Desça para o sul pelo lado leste. Dimetrodontes Jovens pastam na selva leste e {npc:9165} voam perto dos penhascos leste; os dois soltam as escamas de {npc:9998}. O caixote fica no acampamento abandonado na selva leste.",
	-- ["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Siga para o sul até {area:537}, no meio da cratera, e depois para o leste, até a selva leste. Há agrupamentos de cristais por toda a cratera, muitos ao redor de {area:537}: pegue alguns a mais de cada cor. Açoitadeiras Pétala Sangrenta e Látegas Pétala Sangrenta deixam cair as pétalas; o {item:11113} da expedição está num acampamento abandonado na selva leste.",
	-- ["Ride south-west past {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; Pterrordax nest on the southern cliffs if you still need kills.\nCareful: Gorishi silithids are level 51-54 and cast {spell:8137} or {spell:14120} in melee; Gorishi Workers have a 50% chance to call for help within 25 yd once they fall below 45% health."] = "Siga para sudoeste, passando por {npc:9619}: a colmeia dos silitídeos ocupa o sul da cratera. Use o Scraping Vial em um chocadouro, uma câmara com larvas penduradas. Vespas e Trabalhadoras Gorishi soltam {quest:3764}; Pterrordaxes fazem ninho nos penhascos do sul, se você ainda precisar de mortes.\nCuidado: os silitídeos Gorishi são de nível 51-54 e lançam {spell:8137} ou {spell:14120} em combate corpo a corpo; as Trabalhadoras Gorishi têm 50% de chance de chamar ajuda a até 25 metros quando ficam abaixo de 45% de vida.",
	-- ["Ride west back to the refuge."] = "Volte para o oeste até o refúgio.",
	-- ["Ride west back to the refuge.\nGive the elite devilsaurs and stegodons a wide berth. Pick up every {npc:271301} and {object:157936} you pass from here on."] = "Volte cavalgando para oeste até o refúgio.\nPasse bem longe dos Demossauros e Estegodons elite. Daqui em diante, pegue todo {npc:271301} e {object:157936} que encontrar.",
	-- ["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Siga para o oeste a partir de {npc:9619}: a colmeia silitídea ocupa o sul da cratera. Use o Frasco para Amostra numa câmara de incubação, uma câmara com larvas penduradas. Vespas e Trabalhadoras Gorishi deixam cair {quest:3764}; {npc:9166} fazem ninho nos penhascos sul, se ainda precisar de abates.",
	-- ["Ride west out of {area:976} to the long ramp down into {area:490}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Siga para o oeste, saindo de {area:976}, até a longa rampa que desce para {area:490}. {npc:9619} acampa ao pé da rampa, no canto sudeste da cratera.",
	-- ["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Siga para o oeste, passando {area:541}, e desça para o sul pelo lado oeste até {area:543}: {npc:10302}, o goblin, fica junto à água.",
	-- ["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Fazer {area:1417} em vez de matar monstros leva você lá mais rápido, em grupo. Pule esta etapa para subir sozinho.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "Fazer {area:978} em vez de matar monstros leva você lá mais rápido, em grupo. A cidade troll fica no noroeste de {zone:1446}, logo ao norte de {area:976}.",
	-- ["Still short of level 49.79 after the refuge's hand-ins? Top up on the Pterrordax on the slopes east of {area:541} before you leave the crater."] = "Ainda abaixo do nível 49.79 depois das entregas do refúgio? Complete nos Pterrordax das encostas a leste de {area:541} antes de sair da cratera.",
	-- ["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Os silitídeos Centiparte rastejam ao redor de {area:982}, no oeste de {zone:1446}, logo a leste da rampa da cratera. Os Trabalhadores são os mais fáceis de puxar.",
	-- ["The Gorishi hive"] = "A colmeia Gorishi",
	-- ["The dead Threshadon lies by the water north of {npc:9619}."] = "O Manguadonte morto fica junto à água, ao norte de {npc:9619}.",
	-- ["The east side"] = "O lado leste",
	-- ["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Os gorilas vivem em {area:1943}, a leste de {area:541}. Guarde as peles para {npc:9619}. Fique fora da caverna mais funda: {npc:9622} é nível 55.",
	-- ["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Os gorilas de {area:1943} vêm em pequenos grupos e ainda não deixam cair nada para você; a missão das peles de {npc:9619} vem depois. Fique fora da caverna mais funda: {npc:9622} é nível 55.",
	-- ["The pelts come after loop 2, on the gorilla plateau"] = "As peles vêm depois do circuito 2, no planalto dos gorilas",
	-- ["The pylon stands on the eastern cliffs."] = "A torre fica nos penhascos leste.",
	-- ["The pylon stands on the slope east of the refuge. Pterrordax circle the slopes around it: they count for Spraggle and drop {npc:9998}'s scales."] = "O pilão fica na encosta a leste do refúgio. Pterrordaxes rondam as encostas em volta: contam para a Espraga e deixam cair as escamas de {npc:9998}.",
	-- ["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "A torre fica na encosta a leste do refúgio. {npc:9166} sobrevoam as encostas ao redor: contam para {npc:9997} e deixam cair as escamas de {npc:9998}.",
	-- ["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "A torre fica nos penhascos oeste. {npc:9167} voam por todo o lado oeste.",
	-- ["The relics are in the {zone:1428}: keep it"] = "As relíquias estão em {zone:1428}: guarde",
	-- ["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",
	-- ["Top up here to level 49.51 before the hand-ins at {area:541}: they take you to level 50. Or, with a group, run the {area:2100} dungeon instead."] = "Complete aqui até o nível 49.51 antes das entregas em {area:541}: elas levam você ao nível 50. Ou, com um grupo, faça a masmorra {area:2100}.",
	-- ["Top up here to level 50.4 before the hand-ins at {area:3137}: they take you to level 51."] = "Complete aqui até o nível 50.4 antes das entregas em {area:3137}: elas levam você ao nível 51.",
	-- ["Western Pylon"] = "Torre de Cristal Oeste",
	-- ["Xiggs waits in the {object:32359}."] = "Xisto espera em {object:32359}.",
	-- ["grind on Pterrordax"] = "mate Pterrordaxes até subir",
	-- ["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "mate Errantes ou ogros Dunamalho ao redor de {area:976}",
	-- ["grind on {npc:5458} at {area:982}, {zone:1446}"] = "mate {npc:5458} em {area:982}, {zone:1446}",
	-- ["grind on {npc:6116}"] = "mate {npc:6116} até subir",
	-- ["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "mate {npc:6514} em {area:1943}, {zone:1449}",
	-- ["grind on {npc:9164}"] = "mate {npc:9164} até subir",
	-- ["grind on {npc:9167}"] = "mate {npc:9167} até subir",
	-- ["{area:144} flight master"] = "Mestre de voo de {area:144}",
	-- ["{area:978} (optional)"] = "{area:978} (opcional)",
	-- ["{npc:6734}: the last guide hearths you here, so this usually ticks at once"] = "{npc:6734}: o guia anterior leva você até aqui com a pedra de regresso, então isto costuma ser marcado na hora",
	-- ["{npc:7564}, once he has brewed the elixir: a few seconds"] = "{npc:7564}, quando terminar de preparar o elixir: alguns segundos",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, no fundo da caverna",
	-- ["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: os limos estão em {zone:1448}, guarde",
	-- ["{npc:9618} stands just outside the refuge."] = "{npc:9618} fica logo fora do refúgio.",
	-- ["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "O covil de {npc:9684} fica na selva ao norte de {npc:9619}, abaixo dos penhascos leste: use {item:11568} ali. {npc:9684} é nível 56: comece com a vida cheia.",
	-- ["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9999}, amigo de {npc:9997}, desapareceu.",
	-- ["{npc:9998}, at the refuge entrance"] = "{npc:9998}, na entrada do refúgio",
	-- ["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, na entrada do refúgio",
	-- ["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado na encosta sudeste de {area:537}, no meio da cratera.",
}
