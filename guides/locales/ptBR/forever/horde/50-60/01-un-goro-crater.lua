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
	-- {npc:9997} Spraggle Frock
	["the wooden sign beside {npc:9997}, by the flight master: the pterrordax are on this guide's ground"] = "a placa de madeira ao lado de {npc:9997}, junto ao mestre de voo: os pterrordaxes estão na área deste guia",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "{npc:9117}, no fundo da caverna; no subterrâneo",

	-- Step 3: Out of the refuge
	["Out of the refuge"] = "Saindo do refúgio",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, na entrada do refúgio",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, logo do lado de fora",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "Daqui em diante, pegue todo Cristal de Poder (azul, verde, vermelho, amarelo) e todo monte de {quest:3761} pelo caminho: 25 de solo ao todo, 20 para Hamuul e 5 para Almofarrista.",

	-- Step 4: Lakkari Tar Pits
	-- {item:11834} Super Sticky Tar
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Os poços de piche ficam logo ao sul do refúgio. Monstros, Tocaieiros e Rastejantes de Piche deixam cair {item:11834}.",

	-- Step 5: Pterrordax
	["Pterrordax"] = "Pterrordax",
	-- {npc:9998} Shizzle
	["Pterrordax fly over the east of the crater, from the slopes below the refuge southward; their webbed scales are for {npc:9998}."] = "Os Pterrordaxes voam sobre o leste da cratera, a partir das encostas abaixo do refúgio, rumo ao sul; as escamas membranosas deles são para {npc:9998}.",
	["grind on Pterrordax"] = "mate Pterrordaxes até subir",

	-- Step 6: Power Crystals and soil
	["Power Crystals and soil"] = "Cristais de Poder e solo",
	-- {area:537} Fire Plume Ridge
	["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Os aglomerados de cristais estão por toda a cratera, muitos em volta de {area:537}. Pegue alguns a mais de cada cor para os pilares.",

	-- Step 7: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: vá matando estes pelo caminho",
	-- {area:537} Fire Plume Ridge · {npc:9998} Shizzle · {npc:8659} Jes'rimon · {npc:9167} Frenzied Pterrordax
	-- plural, as words: Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Dinosaur Bones = {item:11114} Dinosaur Bone · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nSouth of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Cavalgue para sudoeste até {area:537}, o vulcão no meio da cratera. As Esfoladoras Pétala Sangrenta crescem em volta do pé dele.\nAo sul das fontes termais, Estegodons pastam, e Ossos de Dinossauro caem deles ou estão no chão; os Dimetrodontes ali perto têm as escamas que {npc:9998} quer. Ravassauros caçam em bando no sudoeste: as garras são para {npc:8659}, e de vez em quando um deles carrega Um Diário Destroçado (cai raramente: só pegue a missão se ele cair). Evite o Grufo, um Estegodon de nível 57.\nCavalgue para sudoeste pelos penhascos do oeste. Os {npc:9167} voam sobre o lado oeste, e as Laçadoras Pétala Sangrenta crescem na mesma selva.",

	-- Step 8: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "O equipamento perdido da expedição está na selva a sudoeste.",

	-- Step 9: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Cuidado: as Gorishi Trabalhadoras que caem abaixo de 45% de vida têm 50% de chance de chamar ajuda de aliados num raio de 25 metros.",
	-- {npc:6551} Gorishi Wasp
	["grind on {npc:6551}"] = "mate {npc:6551} até subir",

	-- Step 11: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Estegodons e ravassauros",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, item raro",
	["Use the Mangled Journal to start it"] = "Use Um Diário Destroçado para iniciá-la",

	-- Step 12: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} acampa no canto sudeste da cratera.",

	-- Step 13: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "Ao norte de Torwa, um Manguadonte morto jaz à beira da água.",

	-- Step 15: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Fêmeas de Lar'korwi",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "As Fêmeas de Lar'korwi rondam a selva a noroeste de {npc:9619}.",

	-- Step 16: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "A jangada está na margem do lago a sudeste; a pequena mochila fica na água ao lado dela.",
	["Underwater"] = "Debaixo d'água",

	-- Step 18: Lashers and Threshers
	["Lashers and Threshers"] = "Açoitadeiras e Látegas",
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Siga para o norte pelo lado leste. Açoitadeiras e Látegas Pétala Sangrenta enchem a selva.",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "mate {npc:6511} até subir",

	-- Step 19: Un'Goro Crater: kill these as you meet them
	-- {zone:1449} Un'Goro Crater
	["{zone:1449}: kill these as you meet them"] = "{zone:1449}: vá matando estes pelo caminho",
	["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "O caixote da expedição está num acampamento abandonado na selva a leste.",

	-- Step 20: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, na entrada",
	-- {npc:9997} Spraggle Frock
	["{npc:9997}, beside the flight master"] = "{npc:9997}, ao lado do mestre de voo",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, no subterrâneo",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Guarde {quest:4147} de {npc:9118} e a carta de {npc:8737} para guias futuros.",

	-- Step 21: Northern Pylon
	["Northern Pylon"] = "Pilar do Norte",
	["The pylon stands on the slope east of the refuge."] = "O pilar fica na encosta a leste do refúgio.",

	-- Step 22: Gorillas
	["Gorillas"] = "Gorilas",
	-- {npc:9622} U'cha
	["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Os gorilas vivem no platô a nordeste. Fique fora da caverna mais funda: {npc:9622} mora lá.",
	-- {npc:9623} A-Me 01
	["{npc:9623}, the robot on the plateau; below ground"] = "{npc:9623}, o robô do platô; no subterrâneo",
	-- {npc:9623} A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Depois {npc:9623} quer {item:10561}, um item de {skill:202}. Pule, a menos que tenha um.",

	-- Step 23: Un'Goro Crater: kill these as you meet them
	-- {spell:8137} Silithid Pox · {spell:14120} Tunneler Acid
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast {spell:8137} and Tunnelers and the Hive Guard use {spell:14120}."] = "Cuidado: as Gorishi Trabalhadoras podem chamar ajuda num raio de 25 m quando ficam abaixo de 45% de vida; os silitídeos soltam {spell:8137}, e as Escavadoras e a Guarda da Colmeia usam {spell:14120}.",

	-- Step 24: Eastern Pylon
	["Eastern Pylon"] = "Pilar do Leste",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Desça pelo lado leste da cratera até o pilar nos penhascos a leste.",

	-- Step 25: The Marshlands
	-- {quest:4061} The Rise of the Machines · {area:340} Kargath · {area:1417} Sunken Temple · {area:2100} Maraudon
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time.\nBelow level 52, keep hunting the ravasaurs here after the eighth claw: {quest:4061} at {area:340} needs level 52, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Cuidado: há muitos ravassauros andando pela área, então você pode puxar vários de uma vez com facilidade.\nAbaixo do nível 52, continue caçando os ravassauros aqui depois da oitava garra: {quest:4061}, em {area:340}, exige nível 52, e as missões das Terras Pestilentas no fim deste guia são de nível 55. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	["grind on Ravasaur"] = "mate Ravassauros até subir",

	-- Step 26: Western Pylon
	["Western Pylon"] = "Pilar do Oeste",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Atravesse o sul da cratera até o pilar nos penhascos a oeste.",

	-- Step 27: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "Volte para o norte até {area:541}.",
	["Below ground"] = "No subterrâneo",

	-- Step 28: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "Para {area:976}",

	-- Step 29: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, lá dentro",

	-- Step 30: Orgrimmar
	-- {area:1637} Orgrimmar · {area:16727} Powderfuse Port · {zone:1458} Undercity
	["Fly to {area:1637} and train before the boat to {area:16727}: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Voe para {area:1637} e treine antes do barco para {area:16727}: a parada em {zone:1458} mais adiante neste guia não tem instrutor de Caçador nem de Xamã.",

	-- Step 31: Back to Gadgetzan
	-- {area:976} Gadgetzan
	["Back to {area:976}"] = "De volta a {area:976}",
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 32: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "Barco para {area:16727}",
	-- {npc:9706} Yorba Screwspigot · {quest:4324} Yuka Screwspigot · {area:251} Flame Crest
	["{npc:9706}, by the dock: for {quest:4324} at {area:251}, later in this guide"] = "{npc:9706}, junto ao cais: para {quest:4324} em {area:251}, mais adiante neste guia",

	-- Step 33: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {zone:1418} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {zone:1418}."] = "Saia de {zone:2548} a pé para noroeste, ao norte de {area:16685}, rumo a {zone:1418}.",

	-- Step 34: Kargath
	-- {area:340} Kargath · {zone:1418} Badlands
	["{area:340} is built into the cliffs on the {zone:1418}' west edge."] = "{area:340} é construída nos penhascos, na borda oeste de {zone:1418}.",

	-- Step 35: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "Para {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Pegue a passagem no lado oeste de {area:340} para {zone:1427} e siga para o sul pela garganta até a longa ponte para {area:254}. Lá dentro, desça pelas passarelas de correntes e saia pela saída sul; evite os caminhos para os portais das masmorras.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Ponte para {area:254}",

	-- Step 36: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "A montanha sai ao lado de {area:252}, cheia de orcs de nível 55-57. Siga a estrada para o leste pelos penhascos ao norte até o acampamento da Horda em {area:251}.",

	-- Step 37: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Siga os penhascos para o sul até {quest:3821}, a colina dos ogros Pirobucho. Os restos de {npc:9136} estão no sopé.",

	-- Step 38: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} anda pelas cavernas e túneis de mina de {quest:3821}; se ele não estiver lá, limpe os ogros em volta das entradas até ele voltar.",

	-- Step 39: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "{area:250}: vá matando estes pelo caminho",
	-- {npc:7039} War Reaver · {quest:4296} Tablet of the Seven · {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it.\nBlack Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Cavalgue para oeste até a escavação. Os golens {npc:7039} (53) pisoteiam em volta dela e deixam cair os estilhaços com frequência; as {quest:4296} ficam no meio, entre os anões de Thaurissan. Copie-as.\nOs Filhotes Negros fazem ninho nas colinas logo a leste de {area:251}. Use o {item:12284} de {npc:10267} num filhote quando ele estiver quase morto para capturar a essência.",

	-- Step 40: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Volte para o nordeste até {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Guarde a carta de {npc:10267}: {quest:4808} fica em {area:2255}, {zone:1452}.",

	-- Step 41: Kargath
	-- {area:1584} Blackrock Depths
	["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "A próxima tarefa de Theodora leva a Lotwil, a leste da cidade, e depois para {area:1584}: pule.",

	-- Step 42: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Voe para {area:272}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Mestre de voo de {area:340}",

	-- Step 43: Apothecary Lydon
	["Inside"] = "Lá dentro",

	-- Step 44: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "Voe para {area:1497}",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "Mestre de voo de {area:272}",

	-- Step 45: Harbinger Balthazad
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter (no name in this language: may be words)
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, ao lado do mestre de voo",

	-- Step 46: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter (no name in this language: may be words)
	["{npc:7825} stands in the {object:36082}."] = "{npc:7825} fica no {object:36082}.",

	-- Step 47: Undercity
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, no Apothecarium: os frascos são enchidos em {zone:1447} depois",
	-- {npc:5204} Apothecary Zinge
	["{npc:5204}, near Cuely in the Apothecarium"] = "{npc:5204}, perto de Arnaldo no Apothecarium",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter (no name in this language: may be words)
	["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",

	-- Step 49: The Bulwark
	-- {zone:1458} Undercity · {zone:1420} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Saia de {zone:1458} e siga para o leste pela estrada através de {zone:1420} até o {area:152}, o forte dos Renegados na fronteira.",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Pegue {object:176092} no caixote ao lado de Arcabuz para {quest:5096}, feita na volta. Equipe {quest:5401}: Pedras do Flagelo só caem enquanto você a usa.",

	-- Step 50: Janice Felstone
	-- {area:152} The Bulwark · {zone:1422} Western Plaguelands · {npc:10778} Janice Felstone
	["From the {area:152}, follow the road east into the {zone:1422}. Felstone Farm is the first farm along the road; {npc:10778} waits in the house."] = "De {area:152}, siga a estrada para leste até {zone:1422}. A Fazenda Pedravil é a primeira fazenda ao longo da estrada; {npc:10778} espera na casa.",
	["Upstairs"] = "No andar de cima",
	-- {object:175894} Janice's Parcel
	["{object:175894}, beside the house; inside"] = "{object:175894}, ao lado da casa; lá dentro",
	-- {npc:10781} Royal Overseer Bauhaus · {zone:1458} Undercity
	["Keep the parcel: {npc:10781} is in the {zone:1458}."] = "Guarde o embrulho: {npc:10781} fica em {zone:1458}.",

	-- Step 51: Scarlet forward camp
	["Scarlet forward camp"] = "Acampamento avançado Escarlate",
	-- {area:199} Felstone Field · {area:200} Dalson's Tears · {object:176092} Box of Incendiaries
	["The Scarlet Crusade's tents stand between {area:199} and {area:200}. Torch the command tent with the {object:176092} and plant the Scourge banner."] = "As barracas da Cruzada Escarlate ficam entre {area:199} e {area:200}. Incendeie a barraca de comando com a {object:176092} e finque o estandarte do Flagelo.",

	-- Step 53: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {zone:1423} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Siga a estrada para o leste através de {zone:1422} e atravesse o rio para {zone:1423}; saia dela para o norte rumo a {area:2627}, a cidade em ruínas no noroeste. {npc:12384} fica numa cabana na borda.",

	-- Step 54: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "{area:2627}: vá matando estes pelo caminho",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The book lies in the ruined inn of {area:2627}.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "O livro está na estalagem em ruínas de {area:2627}.\nOs Cupinzeiros Grandes estão espalhados pelas colinas a leste de {area:2627}. Use a {item:15042} em cada cupinzeiro que passar.",

	-- Step 55: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Volte para o sul até a estrada e siga por ela para o leste, atravessando toda a zona até {area:2268}.",

	-- Step 56: Eastern Plaguelands: kill these as you meet them
	-- {zone:1423} Eastern Plaguelands
	["{zone:1423}: kill these as you meet them"] = "{zone:1423}: vá matando estes pelo caminho",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Com a missão de {npc:11063} no registro, o Flagelo abatido às vezes deixa {npc:11064}; fale com ele para libertá-lo. Mate mortos-vivos no caminho para o sudoeste até {area:2262}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Liberte os Espíritos da Vila das Flechas: fale com eles",

	-- Step 57: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "O fantasma de {npc:10926} fica nas ruínas de {area:2262}, no sudoeste.",

	-- Step 58: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "A cabeça da boneca e suas duas metades estão nas casas em volta de {npc:10926}; junte-as pelas bolsas.",

	-- Step 59: Pamela Redpath
	-- {npc:11063} Carlin Redpath · {area:2268} Light's Hope Chapel
	["a message for {npc:11063} at {area:2268}, where this guide ends"] = "uma mensagem para {npc:11063} em {area:2268}, onde este guia termina",
	-- {quest:5152} Auntie Marlene · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: {npc:10927} lives at {area:197} in the {zone:1422}."] = "Guarde {quest:5152}: {npc:10927} mora em {area:197}, em {zone:1422}.",

	-- Step 60: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "Zaeldarr espreita logo a oeste de {area:2262}.",

	-- Step 61: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Cuidado: o {npc:10411} fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa. Só existem 3, e elas renascem a cada 15 min.",

	-- Step 62: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Volte para {area:2268}",

	-- Step 63: Fly to Tarren Mill
	-- {area:2268} Light's Hope Chapel
	["{area:2268} flight master"] = "Mestre de voo de {area:2268}",

	-- Step 64: The road north
	["The road north"] = "",
	-- {area:197} Sorrow Hill
	["The road north to {area:197}"] = "",

	-- Step 65: Sorrow Hill
	-- {area:272} Tarren Mill · {npc:10927} Marlene Redpath · {area:197} Sorrow Hill · {npc:10936} Joseph Redpath
	["Ride north up the road from {area:272}. {npc:10927}'s house stands by the road at {area:197}, and {npc:10936}'s monument is in the graveyard behind it."] = "Cavalgue para o norte pela estrada, saindo de {area:272}. A casa de {npc:10927} fica junto à estrada em {area:197}, e o monumento de {npc:10936} fica no cemitério atrás dela.",
	-- {npc:10927} Marlene Redpath
	["{npc:10927}, upstairs"] = "{npc:10927}, no andar de cima",

	-- Step 66: Chromie
	-- {npc:10667} Chromie
	["Ride north-west into Andorhal. {npc:10667} waits in the ruined inn on the west side of town; the skeletons inside are 54-57, so keep to the edges."] = "Cavalgue para noroeste até Andorhal. {npc:10667} espera na estalagem em ruínas do lado oeste da cidade; os esqueletos lá dentro são 54-57, então fique pelas bordas.",

	-- Step 67: The Annals of Darrowshire
	-- plural, as words: Musty Tomes = {object:176150} Musty Tome
	["The Annals lie among the Musty Tomes in Andorhal's town hall; open them until you find the right one."] = "Os Anais estão entre os Tomos Mofados na prefeitura de Andorhal; abra-os até achar o certo.",

	-- Step 68: Chromie
	-- {quest:5210} Brother Carlin · {area:2268} Light's Hope Chapel · {npc:10739} Mulgris Deepriver · {area:202} Writhing Haunt
	["{quest:5210} goes to {area:2268}: keep it for later. The next guide starts with {npc:10739} by the {area:202}, east of Andorhal."] = "{quest:5210} vai para {area:2268}: guarde-a para depois. O próximo guia começa com {npc:10739}, junto a {area:202}, a leste de Andorhal.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Black Broodlings"] = "Filhotes Negros",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Filhotes Negros fazem ninho nas colinas logo a leste de {area:251}. Use {item:12284} de {npc:10267} num filhote quando ele estiver quase morto para capturar sua essência.",
	-- ["Bloodpetal Flayers"] = "Esfoladoras Pétala Sangrenta",
	-- ["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time."] = "Cuidado: tem muito ravassauro andando pela área, então é fácil puxar vários de uma vez.",
	-- ["Darrowshire Spirits"] = "Espíritos da Vila das Flechas",
	-- ["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- ["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "Voe para {area:1637}, pegue o zepelim para {object:3202} e de lá voe para {area:340}, construída nos penhascos da borda oeste de {zone:1418}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Voe para {area:1638} e treine com {npc:3033} em {area:1639}; depois voe para {area:1637} para pegar o zepelim para {object:3202}.",
	-- ["Fly to {area:340}"] = "Voe para {area:340}",
	-- ["Follow the road east through the {area:28} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Siga a estrada para o leste através de {area:28} e atravesse o rio para {area:139}; saia dela para o norte rumo a {area:2627}, a cidade em ruínas no noroeste. {npc:12384} fica numa cabana na borda.",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "De {area:1938}, siga para o oeste até a longa rampa que desce para {area:490} e então acompanhe a parede norte da cratera até {area:541}, um acampamento nas cavernas do penhasco. Todos aqui são neutros.",
	-- ["Gorillas"] = "Gorilas",
	-- ["Into {area:490}"] = "Para {area:490}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarde a isca: {npc:9684} é nível 56, e a segunda volta passa pelo covil dele.",
	-- ["Lashers and Threshers"] = "Açoitadeiras e Látegas",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",
	-- ["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "Saia de {zone:1458} e siga para o leste pela estrada através de {area:85} até o {area:152}, o forte dos Renegados na fronteira.",
	-- ["Level 52"] = "Nível 52",
	-- ["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "A próxima missão de Almofarrista pede {npc:10041}, um chefe elite. Pule.",
	-- ["Power Crystals and soil"] = "Cristais de Poder e solo",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Siga para o leste até {area:537}, suba e use {npc:10541} na fenda de lava perto do topo; depois volte para o oeste até {npc:10302}.",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Siga para o norte pelo lado leste. Açoitadeiras e Látegas Pétala Sangrenta enchem a selva.",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Siga para o sudoeste pelos penhascos a oeste. {npc:9167} voam pelo lado oeste, e Laçadoras Pétala Sangrenta crescem na mesma selva.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Siga para o sudoeste até {area:537}, o vulcão no meio da cratera. Esfoladoras Pétala Sangrenta crescem ao redor do sopé.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "Siga para o oeste até a escavação. Golens {npc:7039} (53) andam por ali e deixam cair os fragmentos com frequência; {quest:4296} fica no meio, entre os anões de Thaurissan. Copie.",
	-- ["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "Ao sul das fontes termais, Estegodons pastam, e Ossos de Dinossauro caem deles ou ficam no chão; os Dimetrodontes ali perto têm as escamas que {npc:9998} quer. Ravassauros caçam em bando no sudoeste: as garras são para {npc:8659}, e de vez em quando um carrega Um Diário Destroçado (item raro: pegue a missão só se conseguir um). Evite Grufo, um Estegodon de nível 57.",
	-- ["Termite mounds"] = "Cupinzeiros",
	-- ["Thaurissan dig site"] = "Escavação de Thaurissan",
	-- ["The Gorishi hive"] = "A colmeia Gorishi",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Os Cupinzeiros Grandes estão por todas as colinas a leste de {area:2627}. Use {item:15042} em cada cupinzeiro pelo caminho.",
	-- ["The book lies in the ruined inn of {area:2627}."] = "O livro está na estalagem em ruínas de {area:2627}.",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "O caixote da expedição está num acampamento abandonado na selva a leste.",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Os gorilas vivem no platô a nordeste. Fique fora da caverna mais funda: {npc:9622} mora lá.",
	-- ["The next guide starts here, at the chapel's flight master."] = "O próximo guia começa aqui, no mestre de voo da capela.",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "A colmeia silitídea ocupa o sul da cratera. Vespas Gorishi e Gorishi Trabalhadoras deixam cair a glândula odorífera; use o Frasco para Amostra Vazio na massa de ovos dentro da primeira câmara. A Rainha da Colmeia Gorishi, no fundo, é um chefe elite: fique fora da câmara dela. {npc:9166} fazem ninho nos penhascos acima da colmeia; as escamas são para {npc:9998}.",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Os poços de piche ficam logo ao sul do refúgio. Monstros, Tocaieiros e Rastejantes de Piche deixam cair {item:11834}.",
	-- ["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "A missão de Theodora em {area:340} pede nível 52. Os Tocaieiros de Piche e Senhores do Piche logo ao sul do refúgio são o grupo mais próximo.",
	-- ["Top up here to level 52: {quest:4061} at {area:340} needs it, and the Plaguelands quests at the end of this guide are level 55. Or, with a group, run the {area:1417} dungeon or the {area:2100} dungeon instead."] = "Complete aqui até o nível 52: {quest:4061} em {area:340} exige isso, e as missões das Terras Pestilentas no fim deste guia são de nível 55. Ou, em grupo, faça a masmorra {area:1417} ou a masmorra {area:2100}.",
	-- ["Western jungle"] = "Selva a oeste",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "mate Tocaieiros de Piche em {area:538}, {zone:1449}",
	-- ["grind on {npc:6509}"] = "mate {npc:6509} até subir",
	-- ["{area:139}: kill these as you meet them"] = "{area:139}: vá matando estes pelo caminho",
	-- ["{npc:10302} sends you to {npc:9298} in {zone:1452}: keep it."] = "{npc:10302} manda você até {npc:9298} em {zone:1452}: guarde.",
	-- ["{npc:10302} the goblin sits at {area:543}, just east of the pylon."] = "O goblin {npc:10302} fica em {area:543}, logo a leste do pilar.",
	-- ["{npc:12250} lurks just west of {area:2262}."] = "{npc:12250} espreita logo a oeste de {area:2262}.",
	-- ["{npc:9117}, at the back of the cave"] = "{npc:9117}, no fundo da caverna",
	-- ["{npc:9619} now asks for {npc:9622}'s pelt, back in the north-east cave: skip it."] = "Agora {npc:9619} pede a pele de {npc:9622}, lá na caverna a nordeste: pule.",
	-- ["{npc:9623} then wants a {item:10561}, an {skill:202} item. Skip it unless you have one."] = "Depois {npc:9623} quer {item:10561}, um item de {skill:202}. Pule, a menos que tenha um.",
	-- ["{npc:9623}, the robot on the plateau"] = "{npc:9623}, o robô no platô",
	-- ["{npc:9684}'s lair is just south of the pylon. Use {npc:9619}'s bait there; {npc:9684} is level 56 and hits hard, so start at full health."] = "O covil de {npc:9684} fica logo ao sul do pilar. Use a isca de {npc:9619} ali; {npc:9684} é nível 56 e bate forte, então comece com a vida cheia.",
	-- ["{npc:9999} sits on the ridge, lost and exhausted."] = "{npc:9999} está sentado na serra, perdido e exausto.",
}
