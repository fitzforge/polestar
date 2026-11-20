-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Into Un'Goro Crater
	-- {zone:1449} Un'Goro Crater
	["Into {zone:1449}"] = "Para {zone:1449}",
	-- {area:1938} Broken Pillar · {zone:1449} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "De {area:1938}, siga para o oeste até a longa rampa que desce para {zone:1449} e então acompanhe a parede norte da cratera até {area:541}, um acampamento nas cavernas do penhasco. Todos aqui são neutros.",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, no fundo da caverna; no subterrâneo",
	-- {npc:9997} Spraggle Frock · {npc:9167} Frenzied Pterrordax
	["the wooden sign beside {npc:9997}, by the flight master: the {npc:9167} (51-54) come on the pylon loop"] = "a placa de madeira ao lado de {npc:9997}, junto ao mestre de voo: os {npc:9167} (51-54) ficam no circuito dos pilares",

	-- Step 3: Out of the refuge
	["Out of the refuge"] = "Saindo do refúgio",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, na entrada do refúgio",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, logo do lado de fora",
	-- {npc:271301} Power Crystal · {quest:3761} Un'Goro Soil · {quest:4496} Bungle in the Jungle
	["From here on pick up every {npc:271301} (blue, green, red, yellow) and every {quest:3761} pile you pass: 20 for Hamuul, and 5 more for Pestlezugg if you carry {quest:4496}."] = "Daqui em diante, pegue todo {npc:271301} (azul, verde, vermelho, amarelo) e todo monte de {quest:3761} pelo caminho: 20 para Hamuul, e mais 5 para Almofarrista se você tiver {quest:4496}.",

	-- Step 4: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}. Careful: the Lurkers reach 54 and the Tar Lords stand among them: take the Tar Beasts (50-51) and Creepers (51-52)."] = "Os poços de piche ficam logo ao sul do refúgio. Monstros, Tocaieiros e Rastejantes de Piche deixam cair {item:11834}. Cuidado: os Tocaieiros chegam ao nível 54 e os Senhores do Piche ficam no meio deles: mate os Monstros de Piche (50-51) e os Rastejantes (51-52).",

	-- Step 5: Pterrordax
	-- {npc:9166} Pterrordax · {npc:9998} Shizzle · {npc:9997} Spraggle Frock · {npc:9167} Frenzied Pterrordax
	["{npc:9166} (50-52) fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}, and {npc:9997}'s sign wants ten of them. Leave the {npc:9167} over the west for the pylon loop."] = "Os {npc:9166} (50-52) voam sobre o leste da cratera, a partir das encostas abaixo do refúgio, rumo ao sul; as escamas membranosas deles são para {npc:9998}, e a placa de {npc:9997} pede dez deles. Deixe os {npc:9167} do oeste para o circuito dos pilares.",

	-- Step 6: Power Crystals and soil
	-- plural, as words: Power Crystals = {npc:271301} Power Crystal
	["Power Crystals and soil"] = "Cristais de Poder e solo",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Os aglomerados de cristais estão por toda a cratera, muitos em volta de {area:537}. Pegue alguns a mais de cada cor para os pilares.",

	-- Step 7: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: vá matando estes pelo caminho",
	-- {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:8659} Jes'rimon
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Dinosaur Bones = {item:11114} Dinosaur Bone · Elder Diemetradons = {npc:9164} Elder Diemetradon · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Dinosaur Bones lie on the ground among the Stegodons and drop from the Diemetradons nearby, which also carry the scales {npc:9998} wants. Careful: the Stegodons are elites (52-53): pick the bones up around them, don't pull them; the Elder Diemetradons are 53-55, take the smaller ones. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. Bloodpetal Trappers grow in the jungle there. Careful: the biggest Trappers are 53: pull them one at a time."] = "Cavalgue para sudoeste até {area:537}, o vulcão no meio da cratera. As Esfoladoras Pétala Sangrenta crescem em volta do pé dele.\nAo sul das fontes termais, Ossos de Dinossauro estão no chão entre os Estegodons e caem dos Dimetrodontes ali perto, que também têm as escamas que {npc:9998} quer. Cuidado: os Estegodons são elite (52-53): pegue os ossos em volta deles sem puxá-los; os Dimetrodontes Anciãos são 53-55, mate os menores. Ravassauros caçam em bando no sudoeste: as garras são para {npc:8659}, e de vez em quando um deles carrega um Diário Destroçado (cai raramente: só pegue a missão se ele cair). Evite o Grufo, um Estegodon de nível 57.\nCavalgue para sudoeste pelos penhascos do oeste. As Laçadoras Pétala Sangrenta crescem na selva de lá. Cuidado: as maiores Laçadoras são nível 53: puxe uma de cada vez.",

	-- Step 8: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "O equipamento perdido da expedição está na selva a sudoeste.",

	-- Step 9: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd. The Hive Guards (54) and the Queen stand inside the hive: work the Workers and Wasps outside it."] = "Cuidado: as Gorishi Trabalhadoras que caem abaixo de 45% de vida têm 50% de chance de chamar ajuda de aliados num raio de 25 metros. As Guardas da Colmeia (54) e a Rainha ficam dentro da colmeia: mate as Trabalhadoras e as Vespas do lado de fora.",

	-- Step 11: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Estegodons e ravassauros",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, item raro",
	["Use the Mangled Journal to start it"] = "Use Um Diário Destroçado para iniciá-la",
	-- {item:280459} Crystal Infused Scale
	["{item:280459}, a rare drop from the ravasaurs and Diemetradons"] = "{item:280459}, drop raro dos ravassauros e dos Dimetrodontes",
	-- {quest:87494} Microcrystal Contamination · {npc:9619} Torwa Pathfinder
	["Use the scale to start {quest:87494}, for {npc:9619}"] = "Use a escama para iniciar {quest:87494}, para {npc:9619}",

	-- Step 12: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} acampa no canto sudeste da cratera.",
	-- {npc:9619} Torwa Pathfinder · {quest:87492} Uncanny Crystal
	["{npc:9619}: {quest:87492}, a short ride west of his camp"] = "{npc:9619}: {quest:87492}, a uma curta cavalgada a oeste do acampamento dele",
	-- {npc:9619} Torwa Pathfinder · {quest:4289} The Apes of Un'Goro
	["{npc:9619}: {quest:4289}, the gorillas of the north-east plateau on the pylon loop"] = "{npc:9619}: {quest:4289}, os gorilas do platô a nordeste no circuito dos pilares",

	-- Step 13: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {quest:87494} Microcrystal Contamination
	["{npc:9619}: {quest:87494}, if the scale dropped"] = "{npc:9619}: {quest:87494}, se a escama tiver caído",

	-- Step 14: Fresh Threshadon Carcass
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["North of Torwa, a dead Threshadon lies by the water. The {item:280417} lies on the ground a short ride west of {npc:9619}'s camp."] = "Ao norte de Torwa, um Debulhadon morto jaz junto à água. O {item:280417} está no chão a uma curta cavalgada a oeste do acampamento de {npc:9619}.",

	-- Step 16: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Fêmeas de Lar'korwi",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "As Fêmeas de Lar'korwi rondam a selva a noroeste de {npc:9619}.",

	-- Step 17: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "A jangada está na margem do lago a sudeste; a pequena mochila fica na água ao lado dela.",
	["Underwater"] = "Debaixo d'água",

	-- Step 19: Lashers and Threshers
	["Lashers and Threshers"] = "Açoitadeiras e Látegas",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Siga para o norte pelo lado leste. Açoitadeiras e Látegas Pétala Sangrenta enchem a selva.",

	-- Step 20: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}: vá matando estes pelo caminho",
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "O caixote da expedição está num acampamento abandonado na selva a leste.",

	-- Step 21: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, na entrada",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, no subterrâneo",
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}, beside the flight master: {npc:9999} is found at the end of this loop"] = "",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Guarde {quest:4147} de {npc:9118} e a carta de {npc:8737} para guias futuros.",

	-- Step 22: Northern Pylon
	["Northern Pylon"] = "Pilar do Norte",
	["The pylon stands on the slope east of the refuge."] = "O pilar fica na encosta a leste do refúgio.",

	-- Step 23: Gorillas
	["Gorillas"] = "Gorilas",
	-- {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on the north-east plateau: {npc:9619} wants two pelts of each kind, and the Thunderers (52-53) are the biggest. Stay out of the deepest cave: {npc:9622} lives there."] = "Os gorilas vivem no platô a nordeste: {npc:9619} quer duas peles de cada tipo, e os Trovejantes (52-53) são os maiores. Fique fora da caverna mais funda: {npc:9622} mora lá.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau; below ground"] = "{npc:9623}, o robô do platô; no subterrâneo",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Depois {npc:9623} quer {item:10561}, um item de {skill:202}. Pule, a menos que tenha um.",

	-- Step 24: Un'Goro Crater: kill these as you meet them
	-- {spell:8137} Silithid Pox · {spell:14120} Tunneler Acid
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast {spell:8137} and Tunnelers and the Hive Guard use {spell:14120}."] = "Cuidado: as Gorishi Trabalhadoras podem chamar ajuda num raio de 25 m quando ficam abaixo de 45% de vida; os silitídeos soltam {spell:8137}, e as Escavadoras e a Guarda da Colmeia usam {spell:14120}.",

	-- Step 25: Eastern Pylon
	["Eastern Pylon"] = "Pilar do Leste",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Desça pelo lado leste da cratera até o pilar nos penhascos a leste.",

	-- Step 26: The Marshlands
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time."] = "Cuidado: tem muito ravassauro andando pela área, então é fácil puxar vários de uma vez.",

	-- Step 27: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder · {area:1942} The Marshlands
	["{npc:9619}'s camp is in the south-east corner, a short ride from the {area:1942}."] = "O acampamento de {npc:9619} fica no canto sudeste, a uma curta cavalgada de {area:1942}.",

	-- Step 29: Western Pylon
	["Western Pylon"] = "Pilar do Oeste",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Atravesse o sul da cratera até o pilar nos penhascos a oeste.",

	-- Step 30: Frenzied Pterrordax: kill these as you meet them
	-- {npc:9167} Frenzied Pterrordax
	["{npc:9167}: kill these as you meet them"] = "{npc:9167}: vá matando estes pelo caminho",
	-- {npc:9167} Frenzied Pterrordax
	["The {npc:9167} fly over the western cliffs around the pylon. Careful: the biggest are 54: pull them one at a time."] = "Os {npc:9167} voam sobre os penhascos a oeste, em volta do pilar. Cuidado: os maiores têm nível 54: puxe um de cada vez.",

	-- Step 31: Krakle
	-- {npc:10302} Krakle · {area:543} Golakka Hot Springs
	["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "O goblin {npc:10302} fica em {area:543}, logo a leste do pilar.",

	-- Step 32: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer · {npc:10302} Krakle
	-- plural, as words: Living Blazes = {npc:6521} Living Blaze · Scorching Elementals = {npc:6520} Scorching Elemental
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}.\nCareful: Living Blazes (54-55) and Scorching Elementals (53-54) burn on the slopes: ride up the path and pull only what stands on it."] = "",

	-- Step 33: Krakle
	-- {npc:10302} Krakle · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} manda você até {npc:9298} em {zone:1452}: guarde.",

	-- Step 34: Ringo
	-- {area:537} Fire Plume Ridge · {npc:9999} Ringo
	["Ride east again to the foot of {area:537}: {npc:9999} sits on its eastern slope, lost and exhausted."] = "",

	-- Step 35: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",

	-- Step 36: J.D. Collie
	-- {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9117} J.D. Collie
	["{area:541}: {npc:9997} beside the flight master, {npc:9117} below ground."] = "",
	-- {npc:9997} Spraggle Frock
	["{npc:9997}, beside the flight master"] = "{npc:9997}, ao lado do mestre de voo",
	["Below ground"] = "No subterrâneo",

	-- Step 37: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "Para {area:976}",

	-- Step 38: Gadgetzan
	-- {area:976} Gadgetzan · {npc:11758} Andi Lynn · {area:983} Dunemaul Compound
	["The hearth lands in {area:976}: {npc:11758} takes the {area:983} and Tran'rek Thistleshrub Valley, both done on the way into the crater."] = "A Pedra de Regresso leva você a {area:976}: {npc:11758} aceita {area:983} e o Vale Tran'rek Cardoarbusto, ambos feitos a caminho da cratera.",

	-- Step 39: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, lá dentro",

	-- Step 40: Orgrimmar
	-- {area:1637} Orgrimmar · {area:16727} Powderfuse Port · {zone:1458} Undercity
	["Fly to {area:1637} and train before the boat to {area:16727}: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Voe para {area:1637} e treine antes do barco para {area:16727}: a parada em {zone:1458} mais adiante neste guia não tem instrutor de Caçador nem de Xamã.",

	-- Step 41: Back to Gadgetzan
	-- {area:976} Gadgetzan
	["Back to {area:976}"] = "De volta a {area:976}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 42: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Barco para {area:16727}",
	-- {npc:9706} Yorba Screwspigot · {quest:4324} Yuka Screwspigot · {area:251} Flame Crest
	["{npc:9706}, by the dock: for {quest:4324} at {area:251}, later in this guide"] = "{npc:9706}, junto ao cais: para {quest:4324} em {area:251}, mais adiante neste guia",

	-- Step 43: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {zone:1418} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {zone:1418}."] = "Saia de {zone:2548} a pé para noroeste, ao norte de {area:16685}, rumo a {zone:1418}.",

	-- Step 44: Kargath
	-- {area:340} Kargath · {zone:1418} Badlands
	["{area:340} is built into the cliffs on the {zone:1418}' west edge."] = "{area:340} é construída nos penhascos, na borda oeste de {zone:1418}.",

	-- Step 45: Kargath's poster
	-- {area:340} Kargath
	["{area:340}'s poster"] = "",
	-- {area:1584} Blackrock Depths · {area:254} Blackrock Mountain · {area:340} Kargath
	-- was: ["For your {area:1584} run, next, on the way through {area:254}: the {object:164867} poster in {area:340} wants the Anvilrage dwarves inside thinned out."] = "Para a masmorra {area:1584}, em seguida, no caminho por {area:254}: o cartaz {object:164867} em {area:340} quer que você reduza os anões Anvilrage lá de dentro."
	["For your {area:1584} run, next, on the way through {area:254}: the WANTED poster in {area:340} wants the Anvilrage dwarves inside thinned out."] = "",

	-- Step 46: Thunderheart
	-- {npc:9084} Thunderheart · {area:340} Kargath · {quest:3906} Disharmony of Flame · {npc:9026} Overmaster Pyron · {area:1584} Blackrock Depths · {area:254} Blackrock Mountain
	["{npc:9084} stands in {area:340} beside the Hierophant. His {quest:3906} is {npc:9026} (52, elite), at the {area:1584} portal inside {area:254}, on the way through the mountain: a fight for a group."] = "",

	-- Step 47: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "Para {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {npc:8479} Velarok Windblade · {area:1446} Thorium Point
	["Take the pass out of {area:340}'s west side into the {zone:1427} and ride west to {npc:8479}, on the rim of the Cauldron south of {area:1446}."] = "",

	-- Step 49: The Flame's Casing
	-- {npc:8479} Velarok Windblade · {item:10552} Symbol of Ragnaros
	["The Twilight's Hammer cultists camp in the hills west of {npc:8479}. The {item:10552} drops from their Dark Shamans (47-48), Fire Guards (48-49) and Geomancers (49-50): elites, but two to five levels under you now, so one at a time is fine. The Idolaters (49-51) at the altar further north drop it too, more rarely: leave them alone."] = "",

	-- Step 51: The Torch of Retribution
	-- {npc:8479} Velarok Windblade
	["Listen to {npc:8479}'s story once more."] = "Ouça a história de {npc:8479} mais uma vez.",

	-- Step 52: Velarok Windblade
	-- {quest:3453} The Torch of Retribution · {npc:8479} Velarok Windblade · {quest:3462} Squire Maltrake
	["{quest:3453} lies on the ground at {npc:8479}'s feet; {quest:3462} stands beside him."] = "{quest:3453} está no chão aos pés de {npc:8479}; {quest:3462} está ao lado dele.",

	-- Step 53: Sentry Braziers
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Sentry Braziers"] = "Braseiros Sentinela",
	-- {object:149047} Torch of Retribution
	-- plural, as words: Sentry Braziers = {object:149025} Sentry Brazier
	["Carry the {object:149047} south along the rim of the Cauldron and light the four Sentry Braziers, from the south-west round to the east."] = "",

	-- Step 54: Squire Maltrake
	-- {npc:8509} Squire Maltrake · {npc:8479} Velarok Windblade
	["Back north to {npc:8509} beside {npc:8479}."] = "",
	-- {object:149502} Hoard of the Black Dragonflight · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous · {zone:1428} Burning Steppes
	["The {object:149502} holds a {item:10575}: keep it for {npc:9459} in the {zone:1428}"] = "",

	-- Step 55: Into Blackrock Mountain
	-- {area:254} Blackrock Mountain
	["Into {area:254}"] = "",
	-- {area:254} Blackrock Mountain
	-- was: ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Pegue a passagem no lado oeste de {area:340} para {zone:1427} e siga para o sul pela garganta até a longa ponte para {area:254}. Lá dentro, desça pelas passarelas de correntes e saia pela saída sul; evite os caminhos para os portais das masmorras."
	["Ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Ponte para {area:254}",

	-- Step 56: Overmaster Pyron
	-- {npc:9026} Overmaster Pyron · {area:1584} Blackrock Depths
	["With your group: {npc:9026} (52, elite) guards the way to the {area:1584} portal, down the walkways inside the mountain."] = "",

	-- Step 57: Blackrock Depths
	-- {area:1584} Blackrock Depths · {zone:1428} Burning Steppes
	["{area:1584} is a dungeon for a group of five from about level 48, the biggest in the mountain: its Anvilrage dwarves are this quest's, and you need not go further in than they are. Its portal is deep inside the mountain, down the chain walkways from the bridge.\nInside: the Anvilrage Guardsmen, Wardens and Footmen. Then back out of the portal and on through the mountain's southern exit to the {zone:1428}."] = "{area:1584} é uma masmorra para um grupo de cinco a partir do nível 48, a maior da montanha: os anões Anvilrage dela são os desta missão, e você não precisa ir além de onde eles estão. O portal fica no fundo da montanha, descendo pelas passarelas de correntes a partir da ponte.\nLá dentro: os Anvilrage Guardsmen, Wardens e Footmen. Depois saia de volta pelo portal e siga pela saída sul da montanha até {zone:1428}.",
	-- {quest:4081} KILL ON SIGHT: Dark Iron Dwarves
	["{quest:4081}: the Anvilrage dwarves, inside"] = "{quest:4081}: os anões Anvilrage, lá dentro",

	-- Step 58: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "A montanha sai ao lado de {area:252}, cheia de orcs de nível 55-57. Siga a estrada para o leste pelos penhascos ao norte até o acampamento da Horda em {area:251}.",

	-- Step 59: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Siga os penhascos para o sul até {quest:3821}, a colina dos ogros Pirobucho. Os restos de {npc:9136} estão no sopé.",

	-- Step 60: Sha'ni Proudtusk
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["Only from level 53: her next errand is {quest:3822} (54), who walks the caves of {quest:3821} among ogres of 50-53."] = "Só a partir do nível 53: a próxima tarefa dela é {quest:3822} (54), que anda pelas cavernas de {quest:3821} entre ogros de nível 50-53.",

	-- Step 61: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} anda pelas cavernas e túneis de mina de {quest:3821}; se ele não estiver lá, limpe os ogros em volta das entradas até ele voltar.",

	-- Step 62: Cyrus Therepentous
	-- {quest:3821} Dreadmaul Rock · {zone:1428} Burning Steppes · {object:149502} Hoard of the Black Dragonflight · {zone:1427} Searing Gorge · {item:10575} Black Dragonflight Molt · {npc:9459} Cyrus Therepentous
	["Ride north-east from {quest:3821} to the small cave in the far east of the {zone:1428}. Open the {object:149502} from the {zone:1427} for its {item:10575}, then tell {npc:9459} you bring proof of your deeds: no drake to fight.\nCareful: Volchan (60, a rare fire elemental) roams the hills around {npc:9459}'s cave: if he is about, wait for him to pass."] = "",
	-- {item:10575} Black Dragonflight Molt
	["{item:10575}, from the hoard"] = "{item:10575}, do tesouro",
	-- {npc:9459} Cyrus Therepentous · {area:1584} Blackrock Depths
	["{npc:9459}' next errand is in {area:1584}: leave it."] = "",

	-- Step 63: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}: vá matando estes pelo caminho",
	-- {quest:4296} Tablet of the Seven · {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900 · {npc:7040} Black Dragonspawn · {npc:7044} Black Drake
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	-- was: ["Ride west to the dig site. The {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence.\nCareful: a {npc:7040} and a {npc:7044}, elites of 50-53, wander the same hills: pull the broodlings away from them, or bring a group."] = "Cavalgue para oeste até a escavação. As {quest:4296} ficam no meio dela, entre os anões de Thaurissan. Copie-as.\nOs Filhotes Negros fazem ninho nas colinas logo a leste de {area:251}. Use o {item:12284} de {npc:10267} num filhote quando ele estiver quase morto para capturar a essência.\nCuidado: um {npc:7040} e um {npc:7044}, elites de nível 50-53, vagam pelas mesmas colinas: afaste os filhotes deles ou leve um grupo."
	["Ride west to the dig site. The {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence.\nCareful: a {npc:7040} and a {npc:7044}, elites of 50-53, wander the same hills, and Volchan (60, a rare fire elemental) roams them too: pull the broodlings away from them, or bring a group."] = "",

	-- Step 64: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Volte para o nordeste até {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Guarde a carta de {npc:10267}: {quest:4808} fica em {area:2255}, {zone:1452}.",

	-- Step 68: Warlord Goretooth
	-- {area:1584} Blackrock Depths · {npc:9077} Warlord Goretooth · {area:340} Kargath
	["The Anvilrage dwarves of your {area:1584} run: {npc:9077}, in {area:340}."] = "Os anões Anvilrage da sua ida à masmorra {area:1584}: {npc:9077}, em {area:340}.",

	-- Step 69: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Voe para {area:1497}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Mestre de voo de {area:340}",

	-- Step 70: Harbinger Balthazad
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter (no name in this language: may be words)
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, ao lado do mestre de voo",

	-- Step 71: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter (no name in this language: may be words)
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} fica no {object:36082}.",

	-- Step 72: Undercity
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, no Apothecarium: os frascos são enchidos em {zone:1447} depois",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, near Cuely in the Apothecarium"] = "{npc:5204}, perto de Arnaldo no Apothecarium",

	-- Step 74: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Saia de {zone:1458} e siga para o leste pela estrada através de {zone:1420} até o {area:152}, o forte dos Renegados na fronteira.",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5405} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5405}: Scourgestones only drop while you wear it."] = "Pegue {object:176092} no caixote ao lado de Arcabuz para {quest:5096}, feita na volta. Equipe {quest:5405}: Pedras do Flagelo só caem enquanto você a usa.",

	-- Step 75: Scarlet forward camp
	["Scarlet forward camp"] = "Acampamento avançado Escarlate",
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner. Careful: the Scarlets around the tents reach 54 and the Invokers cast: come in from the side nearest the command tent and leave the others be."] = "De {area:152}, siga a estrada para leste até {zone:1422}. As barracas da Cruzada Escarlate ficam logo depois da Fazenda Pedravil, entre {area:199} e {area:200}. Incendeie a barraca de comando com a {object:176092} e finque o estandarte do Flagelo. Cuidado: os Escarlates em volta das barracas chegam ao nível 54 e os Invocadores lançam feitiços: chegue pelo lado mais próximo da barraca de comando e deixe os outros em paz.",

	-- Step 76: Janice Felstone
	-- {npc:10778} Janice Felstone
	["Back a few steps west to Felstone Farm, the first farm along the road; {npc:10778} waits in the house."] = "Volte alguns passos para o oeste até a Fazenda Pedravil, a primeira fazenda ao longo da estrada; {npc:10778} espera na casa.",
	["Upstairs"] = "No andar de cima",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house; inside"] = "{object:175894}, ao lado da casa; lá dentro",
	-- {npc:10781} Royal Overseer Bauhaus · {zone:1458} Undercity · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["Keep the parcel: {npc:10781} is in the {zone:1458}. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Guarde o embrulho: {npc:10781} fica em {zone:1458}. O próximo guia começa com {npc:10739}, junto a {area:202}, a sudeste daqui.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {area:2268}"] = "Volte para {area:2268}",
	-- ["Black Broodlings"] = "Filhotes Negros",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Filhotes Negros fazem ninho nas colinas logo a leste de {area:251}. Use {item:12284} de {npc:10267} num filhote quando ele estiver quase morto para capturar sua essência.",
	-- ["Bloodpetal Flayers"] = "Esfoladoras Pétala Sangrenta",
	-- ["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Cuidado: as Gorishi Trabalhadoras que caem abaixo de 45% de vida têm 50% de chance de chamar ajuda de aliados num raio de 25 metros.",
	-- ["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time."] = "Cuidado: tem muito ravassauro andando pela área, então é fácil puxar vários de uma vez.",
	-- ["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time.\nBelow level 52, keep hunting the ravasaurs here after the eighth claw: {quest:4061} at {area:340} needs level 52, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Cuidado: há muitos ravassauros andando pela área, então você pode puxar vários de uma vez com facilidade.\nAbaixo do nível 52, continue caçando os ravassauros aqui depois da oitava garra: {quest:4061}, em {area:340}, exige nível 52, e as missões das Terras Pestilentas no fim deste guia são de nível 55. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	-- ["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Cuidado: o {npc:10411} fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa. Só existem 3, e elas renascem a cada 15 min.",
	-- ["Darrowshire Spirits"] = "Espíritos da Vila das Flechas",
	-- ["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "Voe para {area:1637}, pegue o zepelim para {object:3202} e de lá voe para {area:340}, construída nos penhascos da borda oeste de {zone:1418}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Voe para {area:1638} e treine com {npc:3033} em {area:1639}; depois voe para {area:1637} para pegar o zepelim para {object:3202}.",
	-- ["Fly to {area:272}"] = "Voe para {area:272}",
	-- ["Fly to {area:340}"] = "Voe para {area:340}",
	-- ["Follow the road east through the {area:28} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Siga a estrada para o leste através de {area:28} e atravesse o rio para {area:139}; saia dela para o norte rumo a {area:2627}, a cidade em ruínas no noroeste. {npc:12384} fica numa cabana na borda.",
	-- ["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Siga a estrada para o leste através de {zone:1422} e atravesse o rio para {zone:1423}; saia dela para o norte rumo a {area:2627}, a cidade em ruínas no noroeste. {npc:12384} fica numa cabana na borda.",
	-- ["For your {area:1584} run, next, on the way through {area:254}: the {object:164867} poster in {area:340} wants the Anvilrage dwarves inside thinned out."] = "Para a masmorra {area:1584}, em seguida, no caminho por {area:254}: o cartaz {object:164867} em {area:340} quer que você reduza os anões Anvilrage lá de dentro.",
	-- ["Free Darrowshire Spirits: talk to them"] = "Liberte os Espíritos da Vila das Flechas: fale com eles",
	-- ["From here on pick up every {npc:271301} (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "Daqui em diante, pegue todo {npc:271301} (azul, verde, vermelho, amarelo) e todo monte de {quest:3761} pelo caminho: 25 de solo ao todo, 20 para Hamuul e 5 para Almofarrista.",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "De {area:152}, siga a estrada para leste até {zone:1422}. A Fazenda Pedravil é a primeira fazenda ao longo da estrada; {npc:10778} espera na casa.",
	-- ["From the {area:152}, follow the road east into the {zone:1422}. The Scarlet Crusade's tents stand just past Felstone Farm, between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "De {area:152}, siga a estrada para leste até {zone:1422}. As barracas da Cruzada Escarlate ficam logo depois da Fazenda Pedravil, entre {area:199} e {area:200}. Incendeie a barraca de comando com a {object:176092} e finque o estandarte do Flagelo.",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "De {area:1938}, siga para o oeste até a longa rampa que desce para {area:490} e então acompanhe a parede norte da cratera até {area:541}, um acampamento nas cavernas do penhasco. Todos aqui são neutros.",
	-- ["Gorillas"] = "Gorilas",
	-- ["Inside"] = "Lá dentro",
	-- ["Into {area:490}"] = "Para {area:490}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarde a isca: {npc:9684} é nível 56, e a segunda volta passa pelo covil dele.",
	-- ["Keep the parcel: {npc:10781} is in the {zone:1458}."] = "Guarde o embrulho: {npc:10781} fica em {zone:1458}.",
	-- ["Keep the parcel: {npc:10781} is in the {zone:1458}. Keep {quest:5901}: its termite mounds are in {area:2627}, on the next guide's ride to Tirion. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Guarde o embrulho: {npc:10781} fica em {zone:1458}. Guarde {quest:5901}: os cupinzeiros dela ficam em {area:2627}, no caminho do próximo guia até Tirion. O próximo guia começa com {npc:10739}, junto a {area:202}, a sudeste daqui.",
	-- ["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "Guarde {quest:5152}: {npc:10927} mora em {area:197}, em {zone:1422}.",
	-- ["Keep {quest:5901}: its termite mounds are in {area:2627}, on the next guide's ride to Tirion. The next guide starts with {npc:10739} by the {area:202}, south-east of here."] = "Guarde {quest:5901}: os cupinzeiros dela ficam em {area:2627}, no caminho do próximo guia até Tirion. O próximo guia começa com {npc:10739}, junto a {area:202}, a sudeste daqui.",
	-- ["Lashers and Threshers"] = "Açoitadeiras e Látegas",
	-- ["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "Saia de {zone:1458} e siga para o leste pela estrada através de {area:85} até o {area:152}, o forte dos Renegados na fronteira.",
	-- ["Level 51"] = "Nível 51",
	-- ["Level 52"] = "Nível 52",
	-- ["North of Torwa, a dead Threshadon lies by the water."] = "Ao norte de Torwa, um Manguadonte morto jaz à beira da água.",
	-- ["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "A próxima missão de Almofarrista pede {npc:10041}, um chefe elite. Pule.",
	-- ["Power Crystals and soil"] = "Cristais de Poder e solo",
	-- ["Pterrordax"] = "Pterrordax",
	-- ["Pterrordax fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}."] = "Os Pterrordaxes voam sobre o leste da cratera, a partir das encostas abaixo do refúgio, rumo ao sul; as escamas membranosas deles são para {npc:9998}.",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Siga para o leste até {area:537}, suba e use {npc:10541} na fenda de lava perto do topo; depois volte para o oeste até {npc:10302}.",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Siga para o norte pelo lado leste. Açoitadeiras e Látegas Pétala Sangrenta enchem a selva.",
	-- ["Ride north back to {area:541}."] = "Volte para o norte até {area:541}.",
	-- ["Ride north back to {area:541}: {npc:9117} below ground, {npc:9997} beside the flight master."] = "Cavalgue para o norte de volta a {area:541}: {npc:9117} no subterrâneo, {npc:9997} ao lado do mestre de voo.",
	-- ["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "Cavalgue para o norte pela estrada, saindo de {area:272}. A casa de {npc:10927} fica junto à estrada em {area:197}, e o monumento de {npc:10936} fica no cemitério atrás dela.",
	-- ["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cavalgue para noroeste até Andorhal. {npc:10667} espera na estalagem em ruínas do lado oeste da cidade; os esqueletos lá dentro são 54-57, então fique pelas bordas.",
	-- ["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Volte para o sul até a estrada e siga por ela para o leste, atravessando toda a zona até {area:2268}.",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Siga para o sudoeste pelos penhascos a oeste. {npc:9167} voam pelo lado oeste, e Laçadoras Pétala Sangrenta crescem na mesma selva.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Siga para o sudoeste até {area:537}, o vulcão no meio da cratera. Esfoladoras Pétala Sangrenta crescem ao redor do sopé.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Cavalgue para sudoeste até {area:537}, o vulcão no meio da cratera. As Esfoladoras Pétala Sangrenta crescem em volta do pé dele.\nAo sul das fontes termais, Estegodons pastam, e Ossos de Dinossauro caem deles ou estão no chão; os Dimetrodontes ali perto têm as escamas que {npc:9998} quer. Ravassauros caçam em bando no sudoeste: as garras são para {npc:8659}, e de vez em quando um deles carrega Um Diário Destroçado (cai raramente: só pegue a missão se ele cair). Evite o Grufo, um Estegodon de nível 57.\nCavalgue para sudoeste pelos penhascos do oeste. Os {npc:9167} voam sobre o lado oeste, e as Laçadoras Pétala Sangrenta crescem na mesma selva.",
	-- ["Ride west to the dig site. The {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence.\nCareful: a {npc:7040} and a {npc:7044}, elites of 50-53, wander the same hills: pull the broodlings away from them, or bring a group."] = "Cavalgue para oeste até a escavação. As {quest:4296} ficam no meio dela, entre os anões de Thaurissan. Copie-as.\nOs Filhotes Negros fazem ninho nas colinas logo a leste de {area:251}. Use o {item:12284} de {npc:10267} num filhote quando ele estiver quase morto para capturar a essência.\nCuidado: um {npc:7040} e um {npc:7044}, elites de nível 50-53, vagam pelas mesmas colinas: afaste os filhotes deles ou leve um grupo.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "Siga para o oeste até a escavação. Golens {npc:7039} (53) andam por ali e deixam cair os fragmentos com frequência; {quest:4296} fica no meio, entre os anões de Thaurissan. Copie.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Cavalgue para oeste até a escavação. Os golens {npc:7039} (53) pisoteiam em volta dela e deixam cair os estilhaços com frequência; as {quest:4296} ficam no meio, entre os anões de Thaurissan. Copie-as.\nOs Filhotes Negros fazem ninho nas colinas logo a leste de {area:251}. Use o {item:12284} de {npc:10267} num filhote quando ele estiver quase morto para capturar a essência.",
	-- ["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "Ao sul das fontes termais, Estegodons pastam, e Ossos de Dinossauro caem deles ou ficam no chão; os Dimetrodontes ali perto têm as escamas que {npc:9998} quer. Ravassauros caçam em bando no sudoeste: as garras são para {npc:8659}, e de vez em quando um carrega Um Diário Destroçado (item raro: pegue a missão só se conseguir um). Evite Grufo, um Estegodon de nível 57.",
	-- ["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Pegue {object:176092} no caixote ao lado de Arcabuz para {quest:5096}, feita na volta. Equipe {quest:5401}: Pedras do Flagelo só caem enquanto você a usa.",
	-- ["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Pegue a passagem no lado oeste de {area:340} para {zone:1427} e siga para o sul pela garganta até a longa ponte para {area:254}. Lá dentro, desça pelas passarelas de correntes e saia pela saída sul; evite os caminhos para os portais das masmorras.",
	-- ["Termite mounds"] = "Cupinzeiros",
	-- ["Thaurissan dig site"] = "Escavação de Thaurissan",
	-- ["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Os Anais estão entre os Tomos Mofados na prefeitura de Andorhal; abra-os até achar o certo.",
	-- ["The Gorishi hive"] = "A colmeia Gorishi",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Os Cupinzeiros Grandes estão por todas as colinas a leste de {area:2627}. Use {item:15042} em cada cupinzeiro pelo caminho.",
	-- ["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "As barracas da Cruzada Escarlate ficam entre {area:199} e {area:200}. Incendeie a barraca de comando com a {object:176092} e finque o estandarte do Flagelo.",
	-- ["The book lies in the ruined inn of {area:2627}."] = "O livro está na estalagem em ruínas de {area:2627}.",
	-- ["The book lies in the ruined inn of {area:2627}.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "O livro está na estalagem em ruínas de {area:2627}.\nOs Cupinzeiros Grandes estão espalhados pelas colinas a leste de {area:2627}. Use a {item:15042} em cada cupinzeiro que passar.",
	-- ["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "A cabeça da boneca e suas duas metades estão nas casas em volta de {npc:10926}; junte-as pelas bolsas.",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "O caixote da expedição está num acampamento abandonado na selva a leste.",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Os gorilas vivem no platô a nordeste. Fique fora da caverna mais funda: {npc:9622} mora lá.",
	-- ["The next guide starts here, at the chapel's flight master."] = "O próximo guia começa aqui, no mestre de voo da capela.",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "A colmeia silitídea ocupa o sul da cratera. Vespas Gorishi e Gorishi Trabalhadoras deixam cair a glândula odorífera; use o Frasco para Amostra Vazio na massa de ovos dentro da primeira câmara. A Rainha da Colmeia Gorishi, no fundo, é um chefe elite: fique fora da câmara dela. {npc:9166} fazem ninho nos penhascos acima da colmeia; as escamas são para {npc:9998}.",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Os poços de piche ficam logo ao sul do refúgio. Monstros, Tocaieiros e Rastejantes de Piche deixam cair {item:11834}.",
	-- ["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",
	-- ["The {object:164867} poster"] = "O cartaz {object:164867}",
	-- ["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "A próxima tarefa de Theodora leva a Lotwil, a leste da cidade, e depois para {area:1584}: pule.",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "A missão de Theodora em {area:340} pede nível 52. Os Tocaieiros de Piche e Senhores do Piche logo ao sul do refúgio são o grupo mais próximo.",
	-- ["To {area:197}"] = "Para {area:197}",
	-- ["Top up here to level 51 before the crater's loop: its {npc:9166} and Bloodpetal Flayers are up to level 52. The Bloodpetal Threshers (49-50) on the slopes south-east of the refuge are under your level, and {npc:9118} wants five of them. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Complete aqui o nível 51 antes do circuito da cratera: os {npc:9166} e as Esfoladoras Pétala Sangrenta de lá vão até o nível 52. As Látegas Pétala Sangrenta (49-50) nas encostas a sudeste do refúgio estão abaixo do seu nível, e {npc:9118} quer cinco delas. Ou, com um grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	-- ["Top up here to level 52: {quest:4061} at {area:340} needs it, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Complete aqui até o nível 52: {quest:4061} em {area:340} exige isso, e as missões das Terras Pestilentas no fim deste guia são de nível 55. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	-- ["Western jungle"] = "Selva a oeste",
	-- ["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Com a missão de {npc:11063} no registro, o Flagelo abatido às vezes deixa {npc:11064}; fale com ele para libertá-lo. Mate mortos-vivos no caminho para o sudoeste até {area:2262}.",
	-- ["Zaeldarr lurks just west of {area:2262}."] = "Zaeldarr espreita logo a oeste de {area:2262}.",
	-- ["a message for {npc:11063} at {area:2268}, where this guide ends"] = "uma mensagem para {npc:11063} em {area:2268}, onde este guia termina",
	-- ["grind on Pterrordax"] = "mate Pterrordaxes até subir",
	-- ["grind on Ravasaur"] = "mate Ravassauros até subir",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "mate Tocaieiros de Piche em {area:538}, {zone:1449}",
	-- ["grind on {npc:6509}"] = "mate {npc:6509} até subir",
	-- ["grind on {npc:6511}"] = "mate {npc:6511} até subir",
	-- ["grind on {npc:6551}"] = "mate {npc:6551} até subir",
	-- ["the wooden sign beside {npc:9997}, by the flight master: the pterrordax are on this guide's ground"] = "a placa de madeira ao lado de {npc:9997}, junto ao mestre de voo: os pterrordaxes estão na área deste guia",
	-- ["{area:139}: kill these as you meet them"] = "{area:139}: vá matando estes pelo caminho",
	-- ["{area:2268} flight master"] = "Mestre de voo de {area:2268}",
	-- ["{area:2627}: kill these as you meet them"] = "{area:2627}: vá matando estes pelo caminho",
	-- ["{area:272} flight master"] = "Mestre de voo de {area:272}",
	-- ["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "O fantasma de {npc:10926} fica nas ruínas de {area:2262}, no sudoeste.",
	-- ["{npc:10927}, upstairs"] = "{npc:10927}, no andar de cima",
	-- ["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250} espreita logo a oeste de {area:2262}.",
	-- ["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, no fundo da caverna",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Agora {npc:9619} pede a pele de {npc:9622}, lá na caverna a nordeste: pule.",
	-- ["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Depois {npc:9623} quer {item:10561}, um item de {skill:202}. Pule, a menos que tenha um.",
	-- ["{npc:9623}, the robot on the plateau"] = "{npc:9623}, o robô no platô",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "O covil de {npc:9684} fica logo ao sul do pilar. Use a isca de {npc:9619} ali; {npc:9684} é nível 56 e bate forte, então comece com a vida cheia.",
	-- ["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} está sentado na serra, perdido e exausto.",
	-- ["{quest:5210} goes to {area:2268}: keep it for later. The next guide starts with {npc:10739} by the {area:202}, east of Andorhal."] = "{quest:5210} vai para {area:2268}: guarde-a para depois. O próximo guia começa com {npc:10739}, junto a {area:202}, a leste de Andorhal.",
	-- ["{quest:5211}'s spirits come with the {zone:1423} guide's {area:2264} stop: keep it."] = "Os espíritos de {quest:5211} ficam para a parada em {area:2264} do guia de {zone:1423}: guarde-a.",
	-- ["{zone:1423}: kill these as you meet them"] = "{zone:1423}: vá matando estes pelo caminho",
}
