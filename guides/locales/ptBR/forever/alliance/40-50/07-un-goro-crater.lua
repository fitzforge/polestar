-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/07-un-goro-crater (forever/alliance/40-50/07-un-goro-crater.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Gadgetzan
	-- {area:144} Thelsamar · {area:150} Menethil Harbor · {area:976} Gadgetzan · {npc:9619} Torwa Pathfinder
	["From {area:144} fly to {area:150}, take the boat to Theramore and fly on to {area:976}. {npc:9619}'s first quest in the crater needs level 48: finish the level here if you are short."] = "De {area:144}, voe para {area:150}, pegue o barco para Theramore e voe até {area:976}. A primeira missão de {npc:9619} na cratera exige nível 48: complete o nível aqui se faltar.",
	-- {area:976} Gadgetzan
	["grind on the Wastewanderers or Dunemaul ogres around {area:976}"] = "mate Errantes ou ogros Dunamalho ao redor de {area:976}",

	-- Step 2: Torwa Pathfinder
	-- {area:976} Gadgetzan · {zone:1449} Un'Goro Crater · {npc:9619} Torwa Pathfinder
	["Ride west out of {area:976} to the long ramp down into {zone:1449}. {npc:9619} camps at the foot of the ramp, in the south-east corner of the crater."] = "Siga para o oeste, saindo de {area:976}, até a longa rampa que desce para {zone:1449}. {npc:9619} acampa ao pé da rampa, no canto sudeste da cratera.",

	-- Step 3: Fresh Threshadon Carcass
	-- {npc:9619} Torwa Pathfinder
	["The dead Threshadon lies by the water north of {npc:9619}."] = "O Manguadonte morto fica junto à água, ao norte de {npc:9619}.",

	-- Step 5: Lar'korwi Mates and the raft
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["Lar'korwi Mates and the raft"] = "Lar'korwi Fêmeas e a jangada",
	-- {npc:9619} Torwa Pathfinder · {npc:8737} Linken · {item:11116} A Mangled Journal
	-- plural, as words: Lar'korwi Mates = {npc:9683} Lar'korwi Mate
	["The Lar'korwi Mates prowl the jungle west of {npc:9619}. The wrecked raft lies on the shore of the lake there; the small pack sits in the water beside it. Keep the compass, map and key for {npc:8737}. Any beast in the crater may drop {item:11116}: right-click it."] = "As Lar'korwi Fêmeas rondam a selva a oeste de {npc:9619}. A jangada destruída fica na margem do lago ali; a mochila pequena está na água ao lado. Guarde a bússola, o mapa e a chave para {npc:8737}. Qualquer fera da cratera pode deixar cair {item:11116}: clique com o botão direito nele.",

	-- Step 7: Marshal's Refuge
	-- {area:541} Marshal's Refuge · {object:157936} Un'Goro Dirt Pile
	["Ride north along the east side of the crater to {area:541}, the camp in the caves of the northern cliff. Give the elite devilsaurs and stegodons a wide berth. Pick up every Power Crystal and {object:157936} you pass from here on."] = "Siga para o norte pelo lado leste da cratera até {area:541}, o acampamento nas cavernas do penhasco norte. Fique longe dos demossauros e estegodons elite. Daqui em diante, pegue todo Cristal de Poder e {object:157936} que encontrar.",
	["Gryfe"] = "Gryfe",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}: keep it"] = "Termina com {npc:9298}, em {zone:1452}: guarde",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, at the back of the cave"] = "{npc:9117}, no fundo da caverna",

	-- Step 8: Karna Remtravel
	-- {npc:9618} Karna Remtravel
	["{npc:9618} stands just outside the refuge."] = "{npc:9618} fica logo fora do refúgio.",

	-- Step 9: Fire Plume Ridge and the eastern jungle
	-- {area:537} Fire Plume Ridge
	["{area:537} and the eastern jungle"] = "{area:537} e a selva leste",
	-- {area:537} Fire Plume Ridge · {item:11113} Crate of Foodstuffs
	-- plural, as words: Bloodpetal Lashers = {npc:6509} Bloodpetal Lasher
	["Ride south to {area:537} in the middle of the crater, then east into the eastern jungle. Crystal clusters stand all over the crater, many of them around {area:537}: take a few extra of each colour. Bloodpetal Lashers and Threshers drop the petals; the expedition's {item:11113} sits at an abandoned camp in the eastern jungle."] = "Siga para o sul até {area:537}, no meio da cratera, e depois para o leste, até a selva leste. Há agrupamentos de cristais por toda a cratera, muitos ao redor de {area:537}: pegue alguns a mais de cada cor. Açoitadeiras Pétala Sangrenta e Látegas Pétala Sangrenta deixam cair as pétalas; o {item:11113} da expedição está num acampamento abandonado na selva leste.",

	-- Step 10: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride north to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Siga para o norte até {area:1943}, onde o robô fica entre os gorilas. Não entre na caverna funda dali.",

	-- Step 11: Zul'Farrak (optional)
	-- {area:978} Zul'Farrak
	["{area:978} (optional)"] = "{area:978} (opcional)",
	-- {area:978} Zul'Farrak · {zone:1446} Tanaris · {area:976} Gadgetzan
	["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in the north-west of {zone:1446}, just north of {area:976}."] = "Fazer {area:978} em vez de matar monstros leva você lá mais rápido, em grupo. A cidade troll fica no noroeste de {zone:1446}, logo ao norte de {area:976}.",

	-- Step 12: Grind to 50
	["Grind to 50"] = "Suba até o nível 50",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas of {area:1943} come in small groups and drop nothing for you yet; {npc:9619}'s pelt quest comes later. Stay out of the deepest cave: {npc:9622} is level 55."] = "Os gorilas de {area:1943} vêm em pequenos grupos e ainda não deixam cair nada para você; a missão das peles de {npc:9619} vem depois. Fique fora da caverna mais funda: {npc:9622} é nível 55.",
	-- {npc:6514} Un'Goro Gorilla · {area:1943} Ironstone Plateau · {zone:1449} Un'Goro Crater
	["grind on {npc:6514} at {area:1943}, {zone:1449}"] = "mate {npc:6514} em {area:1943}, {zone:1449}",

	-- Step 13: Marshal's Refuge
	["Ride west back to the refuge."] = "Volte para o oeste até o refúgio.",
	-- {npc:7775} Gregan Brewspewer · {zone:1444} Feralas
	["For {npc:7775} in {zone:1444}: keep it"] = "Para {npc:7775}, em {zone:1444}: guarde",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge entrance"] = "{npc:9998}, na entrada do refúgio",

	-- Step 14: Northern Pylon
	["Northern Pylon"] = "Torre de Cristal Norte",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:9998} Shizzle
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997} and drop {npc:9998}'s scales."] = "A torre fica na encosta a leste do refúgio. {npc:9166} sobrevoam as encostas ao redor: contam para {npc:9997} e deixam cair as escamas de {npc:9998}.",

	-- Step 15: The east side
	["The east side"] = "O lado leste",
	-- {npc:9165} Fledgling Pterrordax · {npc:9998} Shizzle
	-- plural, as words: Young Diemetradons = {npc:9162} Young Diemetradon
	["Ride south down the east side. Young Diemetradons graze the eastern jungle and {npc:9165} fly near the eastern cliffs; both drop {npc:9998}'s scales."] = "Desça para o sul pelo lado leste. Dimetrodontes Jovens pastam na selva leste e {npc:9165} voam perto dos penhascos leste; os dois deixam cair as escamas de {npc:9998}.",

	-- Step 16: Eastern Pylon
	["Eastern Pylon"] = "Torre de Cristal Leste",
	["The pylon stands on the eastern cliffs."] = "A torre fica nos penhascos leste.",

	-- Step 17: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride south along the eastern cliffs to {npc:9619} at the foot of the ramp."] = "Siga para o sul pelos penhascos leste até {npc:9619}, ao pé da rampa.",
	["The pelts come after loop 2, on the gorilla plateau"] = "As peles vêm depois do circuito 2, no planalto dos gorilas",

	-- Step 18: The Gorishi hive
	["The Gorishi hive"] = "A colmeia Gorishi",
	-- {npc:9619} Torwa Pathfinder · {quest:3764} Un'Goro Soil · {npc:9166} Pterrordax
	["Ride west from {npc:9619}: the silithid hive fills the south of the crater. Use the Scraping Vial on a hatchery, a chamber with hanging larvae. Gorishi wasps and workers drop {quest:3764}; {npc:9166} nest on the southern cliffs if you still need kills."] = "Siga para o oeste a partir de {npc:9619}: a colmeia silitídea ocupa o sul da cratera. Use o Frasco para Amostra numa câmara de incubação, uma câmara com larvas penduradas. Vespas e Trabalhadoras Gorishi deixam cair {quest:3764}; {npc:9166} fazem ninho nos penhascos sul, se ainda precisar de abates.",

	-- Step 19: Bones and equipment
	["Bones and equipment"] = "Ossos e equipamentos",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from Diemetradons. The expedition's {item:11112} lies in the south-west jungle."] = "Ossos de Dinossauro ficam no chão no sudoeste, entre os estegodons: eles são elite, pegue os ossos ao redor deles e consiga o resto com os Dimetrodontes. O {item:11112} da expedição fica na selva sudoeste.",

	-- Step 20: Western Pylon
	["Western Pylon"] = "Torre de Cristal Oeste",
	-- {npc:9167} Frenzied Pterrordax
	["The pylon stands on the western cliffs. {npc:9167} fly over the whole west side."] = "A torre fica nos penhascos oeste. {npc:9167} voam por todo o lado oeste.",

	-- Step 21: Marshal's Refuge
	["Ride north along the western jungle back to the refuge."] = "Siga para o norte pela selva oeste de volta ao refúgio.",
	-- {npc:9998} Shizzle
	["{npc:9998}, at the refuge's entrance"] = "{npc:9998}, na entrada do refúgio",

	-- Step 22: Spraggle Frock
	-- {npc:9997} Spraggle Frock · {npc:9999} Ringo
	["{npc:9997}'s friend {npc:9999} has gone missing."] = "{npc:9999}, amigo de {npc:9997}, desapareceu.",

	-- Step 23: Ironstone Plateau
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55."] = "Os gorilas vivem em {area:1943}, a leste de {area:541}. Guarde as peles para {npc:9619}. Fique fora da caverna mais funda: {npc:9622} é nível 55.",

	-- Step 24: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado na encosta sudeste de {area:537}, no meio da cratera.",

	-- Step 25: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",

	-- Step 27: Sunken Temple
	-- {area:1417} Sunken Temple
	["Running the {area:1417} instead of grinding gets you there faster in a group. Skip this step to grind solo."] = "Fazer {area:1417} em vez de matar monstros leva você lá mais rápido, em grupo. Pule esta etapa para subir sozinho.",

	-- Step 28: Grind to 51
	["Grind to 51"] = "Suba até o nível 51",
	-- {area:982} Noxious Lair · {zone:1446} Tanaris
	["The Centipaar silithid crawl around the {area:982} in western {zone:1446}, just east of the crater ramp. The Workers are the easiest pulls."] = "Os silitídeos Centiparte rastejam ao redor de {area:982}, no oeste de {zone:1446}, logo a leste da rampa da cratera. Os Trabalhadores são os mais fáceis de puxar.",
	-- {npc:5458} Centipaar Worker · {area:982} Noxious Lair · {zone:1446} Tanaris
	["grind on {npc:5458} at {area:982}, {zone:1446}"] = "mate {npc:5458} em {area:982}, {zone:1446}",

	-- Step 29: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Ride down the ramp into the crater: {npc:9619} camps at its foot."] = "Desça a rampa para a cratera: {npc:9619} acampa ao pé dela.",

	-- Step 30: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there. {npc:9684} is level 56: start at full health."] = "O covil de {npc:9684} fica na selva ao norte de {npc:9619}, abaixo dos penhascos leste: use {item:11568} ali. {npc:9684} é nível 56: comece com a vida cheia.",

	-- Step 32: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Siga para o norte pelo lado leste até o planalto dos gorilas. {npc:9622}, um gorila de nível 55, fica na caverna mais funda: limpe os gorilas da entrada antes.",

	-- Step 33: Krakle
	-- {area:541} Marshal's Refuge · {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["Ride west past {area:541} and south down the western side to {area:543}: {npc:10302} the goblin sits by the water."] = "Siga para o oeste, passando {area:541}, e desça para o sul pelo lado oeste até {area:543}: {npc:10302}, o goblin, fica junto à água.",

	-- Step 34: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Siga para o leste até {area:537}, suba e use {npc:10541} nas aberturas de lava perto do topo.",

	-- Step 36: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Atravesse o sul da cratera até {npc:9619}, junto à rampa.",

	-- Step 38: Ironforge
	-- {area:144} Thelsamar · {area:1537} Ironforge
	["Fly from {area:144} to {area:1537}."] = "Voe de {area:144} para {area:1537}.",

	-- Step 40: Tinker Town
	-- {npc:9616} Laris Geardawdle · {zone:1448} Felwood
	["{npc:9616}: the oozes are in {zone:1448}, keep it"] = "{npc:9616}: os limos estão em {zone:1448}, guarde",

	-- Step 41: Mystic Ward
	-- {zone:1447} Azshara
	["Four rune rubbings in {zone:1447}: keep it"] = "Quatro decalques de runas em {zone:1447}: guarde",
	-- {npc:11406} High Priest Rohan · {zone:1447} Azshara
	["{npc:11406}: for Ogtinc in {zone:1447}, keep it"] = "{npc:11406}: para Ogtinc, em {zone:1447}, guarde",

	-- Step 42: Royal Historian Archesonus
	-- {object:171709} High Seat
	["Archesonus stands beside King Magni in the {object:171709}."] = "Arquefilis fica ao lado do Rei Magni, em {object:171709}.",
	-- {zone:1428} Burning Steppes
	["The relics are in the {zone:1428}: keep it"] = "As relíquias estão em {zone:1428}: guarde",

	-- Step 43: Bind and train
	["Bind and train"] = "Vincule e treine",

	-- Step 44: Xiggs Fuselighter
	-- {object:32359} Military Ward (no name in this language: may be words)
	["Xiggs waits in the {object:32359}."] = "Xisto espera em {object:32359}.",
}
