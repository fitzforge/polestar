-- Portuguese (Brazil) (ptBR): the guide forever/horde/50-60/01-un-goro-crater (forever/horde/50-60/01-un-goro-crater.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Into Un'Goro Crater
	-- {area:490} Un'Goro Crater
	["Into {area:490}"] = "",
	-- {area:1938} Broken Pillar · {area:490} Un'Goro Crater · {area:541} Marshal's Refuge
	["From the {area:1938} ride west to the long ramp that winds down into {area:490}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave; below ground"] = "",

	-- Step 3: Bloodpetal Thresher on the way
	-- {npc:6511} Bloodpetal Thresher
	["{npc:6511} on the way"] = "",

	-- Step 4: Super Sticky Tar on the way
	-- {item:11834} Super Sticky Tar
	["{item:11834} on the way"] = "",

	-- Step 5: Out of the refuge
	["Out of the refuge"] = "Saindo do refúgio",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, na entrada do refúgio",
	-- {npc:9618} Karna Remtravel
	["{npc:9618}, just outside"] = "{npc:9618}, logo do lado de fora",
	-- {quest:3761} Un'Goro Soil
	["From here on pick up every Power Crystal (blue, green, red, yellow) and every {quest:3761} pile you pass: 25 soil in all, 20 for Hamuul and 5 for Pestlezugg."] = "Daqui em diante, pegue todo Cristal de Poder (azul, verde, vermelho, amarelo) e todo monte de {quest:3761} pelo caminho: 25 de solo ao todo, 20 para Hamuul e 5 para Almofarrista.",

	-- Step 6: Webbed Diemetradon Scale on the way
	-- {item:11830} Webbed Diemetradon Scale
	["{item:11830} on the way"] = "",

	-- Step 7: The Gorishi hive
	["The Gorishi hive"] = "A colmeia Gorishi",
	-- {npc:9998} Shizzle
	["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. Pterrordax nest on the cliffs above the hive; their scales are for {npc:9998}."] = "",

	-- Step 8: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "",
	-- {item:11834} Super Sticky Tar · {area:537} Fire Plume Ridge
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Bloodpetal Flayers = {npc:6510} Bloodpetal Flayer · Gorishi Workers = {npc:6552} Gorishi Worker
	["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}.\nRide south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot.\nThe crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons.\nCareful: Gorishi Workers may call for help within 25 yd when below 45% health; silithids cast Silithid Pox and Tunnelers and the Hive Guard use Tunneler Acid."] = "",
	-- {npc:6512} Bloodpetal Trapper
	["grind on {npc:6512}"] = "",

	-- Step 9: Un'Goro Crater: kill these as you meet them
	-- {area:490} Un'Goro Crater
	["{area:490}: kill these as you meet them"] = "",
	-- {npc:9998} Shizzle · {npc:8659} Jes'rimon · {npc:9167} Frenzied Pterrordax
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone · Bloodpetal Trappers = {npc:6512} Bloodpetal Trapper
	["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon.\nRide south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "",
	-- {npc:9164} Elder Diemetradon
	["grind on {npc:9164}"] = "",

	-- Step 10: Stegodons and ravasaurs
	["Stegodons and ravasaurs"] = "Estegodons e ravassauros",

	-- Step 11: Research Equipment
	["The expedition's lost equipment lies in the south-west jungle."] = "O equipamento perdido da expedição está na selva a sudoeste.",

	-- Step 12: The Slithering Scar
	-- plural, as words: Gorishi Workers = {npc:6552} Gorishi Worker
	["Careful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "",
	-- {npc:6551} Gorishi Wasp
	["grind on {npc:6551}"] = "",

	-- Step 13: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps in the south-east corner of the crater."] = "{npc:9619} acampa no canto sudeste da cratera.",

	-- Step 14: Fresh Threshadon Carcass
	["North of Torwa, a dead Threshadon lies by the water."] = "Ao norte de Torwa, um Manguadonte morto jaz à beira da água.",

	-- Step 16: Lar'korwi Mates
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates"] = "Fêmeas de Lar'korwi",
	-- {npc:9619} Torwa Pathfinder
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle north-west of {npc:9619}."] = "As Fêmeas de Lar'korwi rondam a selva a noroeste de {npc:9619}.",

	-- Step 17: A Wrecked Raft
	["The raft lies on the shore of the south-eastern lake; the small pack sits in the water beside it."] = "A jangada está na margem do lago a sudeste; a pequena mochila fica na água ao lado dela.",
	["Underwater"] = "",

	-- Step 19: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "",
	["Careful: There are many ravasaurs roaming the area, so you can easily pull several at the same time."] = "",
	-- {item:11116} A Mangled Journal
	["{item:11116}, a rare drop"] = "{item:11116}, item raro",
	["Use the Mangled Journal to start it"] = "Use Um Diário Destroçado para iniciá-la",
	-- {npc:6507} Ravasaur Hunter
	["grind on {npc:6507}"] = "",

	-- Step 20: Bloodpetal Lasher on the way
	-- {npc:6509} Bloodpetal Lasher
	["{npc:6509} on the way"] = "",
	-- {npc:6509} Bloodpetal Lasher · {area:541} Marshal's Refuge
	["{npc:6509} along the way to {area:541}"] = "",

	-- Step 21: Un'Goro Crater: kill these as you meet them
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["The expedition's crate sits at an abandoned camp in the eastern jungle.\nRide north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "",
	-- {npc:6511} Bloodpetal Thresher
	["grind on {npc:6511}"] = "",

	-- Step 23: Marshal's Refuge
	-- {npc:9998} Shizzle
	["{npc:9998}, at the entrance"] = "{npc:9998}, na entrada",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "",
	-- {npc:9118} Larion · {quest:4147} Marvon's Workshop · {npc:8737} Linken
	["Keep {npc:9118}'s {quest:4147} and {npc:8737}'s letter for later guides."] = "Guarde {quest:4147} de {npc:9118} e a carta de {npc:8737} para guias futuros.",

	-- Step 24: Northern Pylon
	["Northern Pylon"] = "Pilar do Norte",
	["The pylon stands on the slope east of the refuge."] = "O pilar fica na encosta a leste do refúgio.",

	-- Step 25: Eastern Pylon
	["Eastern Pylon"] = "Pilar do Leste",
	["Ride down the east side of the crater to the pylon on the eastern cliffs."] = "Desça pelo lado leste da cratera até o pilar nos penhascos a leste.",

	-- Step 26: Western Pylon
	["Western Pylon"] = "Pilar do Oeste",
	["Cross the south of the crater to the pylon on the western cliffs."] = "Atravesse o sul da cratera até o pilar nos penhascos a oeste.",

	-- Step 27: Level 51.81
	["Level 51.81"] = "",
	-- {area:16985} The Shaper's Terrace
	["Top up here to level 51.81 before the hand-ins at {area:16985}: they take you to level 52."] = "",

	-- Step 28: J.D. Collie
	-- {area:541} Marshal's Refuge
	["Ride north back to {area:541}."] = "Volte para o norte até {area:541}.",
	["Below ground"] = "",

	-- Step 29: Hearth to Gadgetzan
	-- {area:976} Gadgetzan
	["Hearth to {area:976}"] = "",

	-- Step 30: To Gadgetzan
	-- {area:976} Gadgetzan
	["To {area:976}"] = "",

	-- Step 31: Gadgetzan
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "",
	-- {npc:10041} Gorishi Hive Queen
	["Pestlezugg's next quest needs the {npc:10041}, an elite boss. Skip it."] = "A próxima missão de Almofarrista pede {npc:10041}, um chefe elite. Pule.",

	-- Step 32: Boat to Powderfuse Port
	-- {area:16727} Powderfuse Port
	["Boat to {area:16727}"] = "",

	-- Step 33: Into Redridge Mountains
	-- {zone:1433} Redridge Mountains
	["Into {zone:1433}"] = "",

	-- Step 34: Into Burning Steppes
	-- {area:46} Burning Steppes
	["Into {area:46}"] = "",

	-- Step 36: Level 52
	["Level 52"] = "",
	-- {quest:4061} The Rise of the Machines · {area:340} Kargath
	["Top up here to level 52: {quest:4061}, at {area:340}, needs level 52."] = "",
	-- {npc:7032} Greater Obsidian Elemental
	["grind on {npc:7032}"] = "",

	-- Step 37: Badlands
	-- {zone:2548} Riverglades · {area:16685} Twilight's Shroud · {area:3} Badlands
	["Leave {zone:2548} on foot to the north-west, north of {area:16685}, into the {area:3}."] = "",

	-- Step 38: Fly to Kargath
	-- {area:340} Kargath
	["Fly to {area:340}"] = "Voe para {area:340}",

	-- Step 39: Into the Searing Gorge
	-- {zone:1427} Searing Gorge
	["Into the {zone:1427}"] = "Para {zone:1427}",
	-- {area:340} Kargath · {zone:1427} Searing Gorge · {area:254} Blackrock Mountain
	["Take the pass out of {area:340}'s west side into the {zone:1427}, then ride south across the gorge to the long bridge into {area:254}. Inside, follow the chain walkways down and leave through the southern exit; stay off the paths to the dungeon portals."] = "Pegue a passagem no lado oeste de {area:340} para {zone:1427} e siga para o sul pela garganta até a longa ponte para {area:254}. Lá dentro, desça pelas passarelas de correntes e saia pela saída sul; evite os caminhos para os portais das masmorras.",
	-- {area:254} Blackrock Mountain
	["Bridge into {area:254}"] = "Ponte para {area:254}",

	-- Step 40: Flame Crest
	-- {area:252} Blackrock Stronghold · {area:251} Flame Crest
	["The mountain lets you out beside {area:252}, full of 55-57 orcs. Follow the road east along the northern cliffs to the Horde camp at {area:251}."] = "A montanha sai ao lado de {area:252}, cheia de orcs de nível 55-57. Siga a estrada para o leste pelos penhascos ao norte até o acampamento da Horda em {area:251}.",

	-- Step 41: Ruins of Thaurissan: kill these as you meet them
	-- {area:250} Ruins of Thaurissan
	["{area:250}: kill these as you meet them"] = "",
	-- {area:251} Flame Crest · {npc:10267} Tinkee Steamboil · {item:12284} Draco-Incarcinatrix 900 · {npc:7039} War Reaver · {quest:4296} Tablet of the Seven
	-- plural, as words: Black Broodlings = {npc:7047} Black Broodling
	["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence.\nRide west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "",

	-- Step 42: Sha'ni Proudtusk
	-- {quest:3821} Dreadmaul Rock · {npc:9136} Sha'ni Proudtusk
	["Follow the cliffs south to {quest:3821}, the Firegut ogres' hill. {npc:9136}'s remains lie at its foot."] = "Siga os penhascos para o sul até {quest:3821}, a colina dos ogros Pirobucho. Os restos de {npc:9136} estão no sopé.",

	-- Step 43: Krom'Grul
	-- {quest:3822} Krom'Grul · {quest:3821} Dreadmaul Rock
	["{quest:3822} walks the caves and mine tunnels of {quest:3821}; if he isn't home, clear the ogres around the entrances until he comes back."] = "{quest:3822} anda pelas cavernas e túneis de mina de {quest:3821}; se ele não estiver lá, limpe os ogros em volta das entradas até ele voltar.",

	-- Step 44: Flame Crest
	-- {area:251} Flame Crest
	["Back north-east to {area:251}."] = "Volte para o nordeste até {area:251}.",
	-- {npc:10267} Tinkee Steamboil · {quest:4808} Felnok Steelspring · {area:2255} Everlook · {zone:1452} Winterspring
	["Keep {npc:10267}'s letter: {quest:4808} is in {area:2255}, {zone:1452}."] = "Guarde a carta de {npc:10267}: {quest:4808} fica em {area:2255}, {zone:1452}.",

	-- Step 45: Kargath
	-- {npc:2921} Lotwil Veriatus · {area:1584} Blackrock Depths
	["Theodora's next errand goes to {npc:2921} east of town and then into {area:1584}: skip it."] = "",

	-- Step 47: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "",
	-- {area:340} Kargath
	["{area:340} flight master"] = "",

	-- Step 48: Apothecary Lydon
	["Inside"] = "",

	-- Step 49: Fly to Undercity
	-- {area:1497} Undercity
	["Fly to {area:1497}"] = "",
	-- {area:272} Tarren Mill
	["{area:272} flight master"] = "",

	-- Step 50: Oran Snakewrithe
	-- {npc:7825} Oran Snakewrithe · {object:36082} Magic Quarter (no name in this language: may be words)
	["{npc:7825} stands in the {object:36082}."] = "",

	-- Step 51: Undercity
	-- {npc:10879} Harbinger Balthazad · {object:36078} Trade Quarter (no name in this language: may be words)
	["{npc:10879}, the {object:36078}, beside the bat master"] = "{npc:10879}, {object:36078}, ao lado do mestre de voo",
	-- {npc:8390} Chemist Cuely · {zone:1447} Azshara
	["{npc:8390}, the Apothecarium: the vials fill in {zone:1447} later"] = "{npc:8390}, no Apothecarium: os frascos são enchidos em {zone:1447} depois",
	-- {npc:6522} Andron Gant · {object:36073} Rogues' Quarter (no name in this language: may be words)
	["{npc:6522}, the {object:36073}"] = "{npc:6522}, {object:36073}",

	-- Step 53: The Bulwark
	-- {zone:1458} Undercity · {area:85} Tirisfal Glades · {area:152} The Bulwark
	["Leave the {zone:1458} and ride east along the road through {area:85} to the {area:152}, the Forsaken fort on the border."] = "",
	-- {object:176092} Box of Incendiaries · {quest:5096} Scarlet Diversions · {quest:5401} Argent Dawn Commission
	["Take a {object:176092} from the crate next to Derrington for {quest:5096}, done on the way back. Equip the {quest:5401}: Scourgestones only drop while you wear it."] = "Pegue {object:176092} no caixote ao lado de Arcabuz para {quest:5096}, feita na volta. Equipe {quest:5401}: Pedras do Flagelo só caem enquanto você a usa.",

	-- Step 55: Augustus the Touched
	-- {zone:1422} Western Plaguelands · {area:139} Eastern Plaguelands · {area:2627} Terrordale · {npc:12384} Augustus the Touched
	["Follow the road east through the {zone:1422} and across the river into the {area:139}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "",

	-- Step 56: Terrordale: kill these as you meet them
	-- {area:2627} Terrordale
	["{area:2627}: kill these as you meet them"] = "",
	-- {area:2627} Terrordale · {item:15042} Empty Termite Jar
	-- plural, as words: Large Termite Mounds = {object:177464} Large Termite Mound
	["The book lies in the ruined inn of {area:2627}.\nThe Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "",
	["Upstairs"] = "",

	-- Step 57: Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Ride south back to the road and follow it east across the whole zone to {area:2268}."] = "Volte para o sul até a estrada e siga por ela para o leste, atravessando toda a zona até {area:2268}.",

	-- Step 58: Eastern Plaguelands: kill these as you meet them
	-- {area:139} Eastern Plaguelands
	["{area:139}: kill these as you meet them"] = "",
	-- {npc:11063} Carlin Redpath · {npc:11064} Darrowshire Spirit · {area:2262} Darrowshire
	["With {npc:11063}'s quest in your log, slain Scourge sometimes leave a {npc:11064}; talk to it to free it. Kill undead on the ride south-west to {area:2262}."] = "Com a missão de {npc:11063} no registro, o Flagelo abatido às vezes deixa {npc:11064}; fale com ele para libertá-lo. Mate mortos-vivos no caminho para o sudoeste até {area:2262}.",
	-- plural, as words: Darrowshire Spirits = {npc:11064} Darrowshire Spirit
	["Free Darrowshire Spirits: talk to them"] = "Liberte os Espíritos da Vila das Flechas: fale com eles",

	-- Step 59: Pamela Redpath
	-- {npc:10926} Pamela Redpath · {area:2262} Darrowshire
	["{npc:10926}'s ghost stands in the ruins of {area:2262}, in the south-west."] = "O fantasma de {npc:10926} fica nas ruínas de {area:2262}, no sudoeste.",

	-- Step 60: Pamela's Doll
	-- {npc:10926} Pamela Redpath
	["The doll's head and its two sides lie in the houses around {npc:10926}; join them from your bags."] = "A cabeça da boneca e suas duas metades estão nas casas em volta de {npc:10926}; junte-as pelas bolsas.",

	-- Step 61: Pamela Redpath
	-- {quest:5152} Auntie Marlene · {area:197} Sorrow Hill · {zone:1422} Western Plaguelands
	["Keep {quest:5152}: Marlene lives at {area:197} in the {zone:1422}."] = "Guarde {quest:5152}: Marlene mora em {area:197}, em {zone:1422}.",

	-- Step 62: Zaeldarr the Outcast
	-- {area:2262} Darrowshire
	["Zaeldarr lurks just west of {area:2262}."] = "",

	-- Step 63: Pestilent Scar
	-- {npc:10411} Eye of Naxxramas
	-- plural, as words: Rockwing Gargoyles = {npc:10408} Rockwing Gargoyle
	["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "",

	-- Step 64: Hearth to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Hearth to {area:2268}"] = "",

	-- Step 65: Back to Light's Hope Chapel
	-- {area:2268} Light's Hope Chapel
	["Back to {area:2268}"] = "Volte para {area:2268}",
	["The next guide starts here, at the chapel's flight master."] = "O próximo guia começa aqui, no mestre de voo da capela.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Black Broodlings"] = "Filhotes Negros",
	-- ["Black Broodlings nest in the hills just east of {area:251}. Use {npc:10267}'s {item:12284} on a broodling when it is almost dead to capture its essence."] = "Filhotes Negros fazem ninho nas colinas logo a leste de {area:251}. Use {item:12284} de {npc:10267} num filhote quando ele estiver quase morto para capturar sua essência.",
	-- ["Bloodpetal Flayers"] = "Esfoladoras Pétala Sangrenta",
	-- ["Darrowshire Spirits"] = "Espíritos da Vila das Flechas",
	-- ["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- ["Fly to {area:1637} and train before the {object:3202} zeppelin: the {zone:1458} stop later in this guide has no Hunter or Shaman trainer."] = "Voe para {area:1637} e treine antes do zepelim para {object:3202}: a parada em {zone:1458} mais adiante neste guia não tem instrutor de Caçador nem de Xamã.",
	-- ["Fly to {area:1637}, take the zeppelin to {object:3202} and fly from there to {area:340}, built into the cliffs on the {zone:1418}' west edge."] = "Voe para {area:1637}, pegue o zepelim para {object:3202} e de lá voe para {area:340}, construída nos penhascos da borda oeste de {zone:1418}.",
	-- ["Fly to {area:1638} and train with {npc:3033} on {area:1639}, then fly to {area:1637} for the {object:3202} zeppelin."] = "Voe para {area:1638} e treine com {npc:3033} em {area:1639}; depois voe para {area:1637} para pegar o zepelim para {object:3202}.",
	-- ["Follow the road east through the {zone:1422} and across the river into the {zone:1423}; leave it north for {area:2627}, the ruined town in the north-west. {npc:12384} sits in a hut at its edge."] = "Siga a estrada para o leste através de {zone:1422} e atravesse o rio para {zone:1423}; saia dela para o norte rumo a {area:2627}, a cidade em ruínas no noroeste. {npc:12384} fica numa cabana na borda.",
	-- ["From the {area:1938} ride west to the long ramp that winds down into {zone:1449}, then follow the crater's north wall to {area:541}, a camp in the cliff caves. Everyone here is neutral."] = "De {area:1938}, siga para o oeste até a longa rampa que desce para {zone:1449} e então acompanhe a parede norte da cratera até {area:541}, um acampamento nas cavernas do penhasco. Todos aqui são neutros.",
	-- ["Gorillas"] = "Gorilas",
	-- ["Into {zone:1449}"] = "Para {zone:1449}",
	-- ["Keep the bait: {npc:9684} is level 56, and the second loop passes his lair."] = "Guarde a isca: {npc:9684} é nível 56, e a segunda volta passa pelo covil dele.",
	-- ["Lashers and Threshers"] = "Açoitadeiras e Látegas",
	-- ["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",
	-- ["Leave the {zone:1458} and ride east along the road through {zone:1420} to the {area:152}, the Forsaken fort on the border."] = "Saia de {zone:1458} e siga para o leste pela estrada através de {zone:1420} até o {area:152}, o forte dos Renegados na fronteira.",
	-- ["Power Crystals and soil"] = "Cristais de Poder e solo",
	-- ["Ride east to {area:537}, climb it and use {npc:10541} at the lava vent near the top, then ride back west to {npc:10302}."] = "Siga para o leste até {area:537}, suba e use {npc:10541} na fenda de lava perto do topo; depois volte para o oeste até {npc:10302}.",
	-- ["Ride north along the east side. Bloodpetal Lashers and Threshers fill the jungle."] = "Siga para o norte pelo lado leste. Açoitadeiras e Látegas Pétala Sangrenta enchem a selva.",
	-- ["Ride south-west along the western cliffs. {npc:9167} fly over the west side, and Bloodpetal Trappers grow in the same jungle."] = "Siga para o sudoeste pelos penhascos a oeste. {npc:9167} voam pelo lado oeste, e Laçadoras Pétala Sangrenta crescem na mesma selva.",
	-- ["Ride south-west to {area:537}, the volcano in the middle of the crater. Bloodpetal Flayers grow around its foot."] = "Siga para o sudoeste até {area:537}, o vulcão no meio da cratera. Esfoladoras Pétala Sangrenta crescem ao redor do sopé.",
	-- ["Ride west to the dig site. {npc:7039} golems (53) stomp around it and drop the shards often; the {quest:4296} stands in its middle among the Thaurissan dwarves. Copy it."] = "Siga para o oeste até a escavação. Golens {npc:7039} (53) andam por ali e deixam cair os fragmentos com frequência; {quest:4296} fica no meio, entre os anões de Thaurissan. Copie.",
	-- ["South of the hot springs, Stegodons graze and Dinosaur Bones drop from them or lie on the ground; Diemetradons nearby carry the scales {npc:9998} wants. Ravasaurs hunt in packs in the south-west: their claws are for {npc:8659}, and now and then one carries a Mangled Journal (a rare drop: take its quest only if you get one). Avoid Gruff, a level 57 Stegodon."] = "Ao sul das fontes termais, Estegodons pastam, e Ossos de Dinossauro caem deles ou ficam no chão; os Dimetrodontes ali perto têm as escamas que {npc:9998} quer. Ravassauros caçam em bando no sudoeste: as garras são para {npc:8659}, e de vez em quando um carrega Um Diário Destroçado (item raro: pegue a missão só se conseguir um). Evite Grufo, um Estegodon de nível 57.",
	-- ["Termite mounds"] = "Cupinzeiros",
	-- ["Thaurissan dig site"] = "Escavação de Thaurissan",
	-- ["The Large Termite Mounds stand all over the hills east of {area:2627}. Use the {item:15042} on each mound you pass."] = "Os Cupinzeiros Grandes estão por todas as colinas a leste de {area:2627}. Use {item:15042} em cada cupinzeiro pelo caminho.",
	-- ["The book lies in the ruined inn of {area:2627}."] = "O livro está na estalagem em ruínas de {area:2627}.",
	-- ["The crystal clusters stand all over the crater, many around {area:537}. Take a few extra of each colour for the pylons."] = "Os aglomerados de cristais estão por toda a cratera, muitos em volta de {area:537}. Pegue alguns a mais de cada cor para os pilares.",
	-- ["The expedition's crate sits at an abandoned camp in the eastern jungle."] = "O caixote da expedição está num acampamento abandonado na selva a leste.",
	-- ["The gorillas live on the north-east plateau. Stay out of the deepest cave: {npc:9622} lives there."] = "Os gorilas vivem no platô a nordeste. Fique fora da caverna mais funda: {npc:9622} mora lá.",
	-- ["The silithid hive fills the south of the crater. Gorishi wasps and workers drop the scent gland; use the Scraping Vial on the egg mass inside the first chamber. The Hive Queen at the bottom is an elite boss: stay out of her chamber. {npc:9166} nest on the cliffs above the hive; their scales are for {npc:9998}."] = "A colmeia silitídea ocupa o sul da cratera. Vespas Gorishi e Gorishi Trabalhadoras deixam cair a glândula odorífera; use o Frasco para Amostra Vazio na massa de ovos dentro da primeira câmara. A Rainha da Colmeia Gorishi, no fundo, é um chefe elite: fique fora da câmara dela. {npc:9166} fazem ninho nos penhascos acima da colmeia; as escamas são para {npc:9998}.",
	-- ["The tar pits lie just south of the refuge. Tar Beasts, Lurkers and Creepers drop the {item:11834}."] = "Os poços de piche ficam logo ao sul do refúgio. Monstros, Tocaieiros e Rastejantes de Piche deixam cair {item:11834}.",
	-- ["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",
	-- ["Theodora's next errand goes to Lotwil east of town and then into {area:1584}: skip it."] = "A próxima tarefa de Theodora leva a Lotwil, a leste da cidade, e depois para {area:1584}: pule.",
	-- ["Theodora's quest in {area:340} needs level 52. The Tar Lurkers and Tar Lords just south of the refuge are the closest camp."] = "A missão de Theodora em {area:340} pede nível 52. Os Tocaieiros de Piche e Senhores do Piche logo ao sul do refúgio são o grupo mais próximo.",
	-- ["Western jungle"] = "Selva a oeste",
	-- ["grind on Tar Lurkers at {area:538}, {zone:1449}"] = "mate Tocaieiros de Piche em {area:538}, {zone:1449}",
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
