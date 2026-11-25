-- Portuguese (Brazil) (ptBR): the guide forever/alliance/50-60/03-winterspring (forever/alliance/50-60/03-winterspring.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {area:2255} Everlook · {zone:1448} Felwood · {zone:1452} Winterspring
	["{area:2255} first, then Un'Goro, then {zone:1448} and {zone:1452} again."] = "Primeiro {area:2255}, depois Un'Goro, e então {zone:1448} e {zone:1452} de novo.",

	-- Step 1: Fly to Everlook
	-- {area:2255} Everlook
	["Fly to {area:2255}"] = "Voe para {area:2255}",

	-- Step 2: Everlook
	-- {area:2255} Everlook · {npc:11754} Meggi Peppinrocker
	["The flight lands in {area:2255}: {npc:11754} and Umi stand around the town before you ride west."] = "",
	-- {npc:11754} Meggi Peppinrocker · {npc:9298} Donova Snowden · {area:2255} Everlook
	-- was: ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} anda por {area:2255}: procure dentro do círculo no mapa"
	["{npc:11754}, for {npc:9298}: walks around {area:2255}, look inside the circle on the map"] = "",
	-- {npc:10305} Umi Rumplesnicker
	-- plural, as words: Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle
	["{npc:10305}: the Rogue Ice Thistles on the road west carry the furs"] = "",

	-- Step 3: The road west: feathers, furs and horns
	["The road west: feathers, furs and horns"] = "",
	-- {npc:9298} Donova Snowden · {item:12366} Thick Yeti Fur · {item:12444} Uncracked Chillwind Horn · {npc:10468} Felnok Steelspring
	-- plural, as words: Moontouched Feathers = {item:12383} Moontouched Feather · Ragged Owlbeasts = {npc:7450} Ragged Owlbeast · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["Moontouched Feathers lie on the ground all along the road west to {npc:9298}, where the Ragged Owlbeasts (53) roam: pick them up as you ride.\nThe same road crosses the Rogue Ice Thistles' ground (about one in three drops a {item:12366} for Umi) and the Fledgling Chillwinds' (about one in five drops an {item:12444} for {npc:10468}): work both here, around the road's middle.\nCareful: both are 53-55: pull the lower ones and take them one at a time."] = "",
	-- {item:12366} Thick Yeti Fur
	-- plural, as words: Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle
	["{item:12366}, from the Rogue Ice Thistles"] = "",
	-- {item:12444} Uncracked Chillwind Horn
	-- plural, as words: Fledgling Chillwinds = {npc:7447} Fledgling Chillwind
	["{item:12444}, from the Fledgling Chillwinds"] = "",

	-- Step 4: Donova Snowden
	-- {npc:9298} Donova Snowden
	["{npc:9298} camps beside the hot springs at the western end of the road."] = "",
	-- {item:11243} Videre Elixir
	["With the {item:11243} from Gregan"] = "",

	-- Step 5: Donova Snowden
	-- {npc:9299} Gaeriyan · {area:976} Gadgetzan
	["{npc:9299}, at the graveyard just east of {area:976}, later in this guide"] = "",

	-- Step 6: Frostfire Hot Springs: kill these as you meet them
	-- {area:2246} Frostfire Hot Springs
	["{area:2246}: kill these as you meet them"] = "{area:2246}: vá matando estes pelo caminho",
	-- {npc:9298} Donova Snowden · {item:12771} Empty Firewater Flask · {item:14047} Runecloth · {npc:11557} Meilosh
	-- plural, as words: Winterfall Ritual Totems = {quest:8471} Winterfall Ritual Totem
	["The western Winterfall camp sits in the hills between {npc:9298} and the tunnel. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need): right-click it. They also drop Winterfall Ritual Totems (about one in thirty) and {item:14047}, which only matter if you are Neutral (the totem) or Friendly ({npc:11557}'s {item:14047}) with the Timbermaw: keep them then.\nCareful: the Pathfinders are 53 and the Totemics 54, but the Den Watchers inside the camp are 55: take the camp from its edge and pull one at a time."] = "",
	-- {item:14047} Runecloth · {npc:11557} Meilosh
	["{item:14047}, for {npc:11557}, if you are Friendly with the Timbermaw"] = "",

	-- Step 7: Winterfall Ritual Totem
	-- {npc:11558} Kernda
	["{npc:11558} takes the totem; the quest needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["For {npc:11558} in {area:1769}, later in this guide: keep it"] = "",

	-- Step 8: Donova Snowden
	-- {area:1762} Felpaw Village · {zone:1448} Felwood
	["The Deadwood cauldron in {area:1762}, at the {zone:1448} end of the tunnel"] = "",

	-- Step 9: Felwood
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden · {zone:1448} Felwood
	["Through {area:1769}'s tunnel, just north of {npc:9298}, to {zone:1448}."] = "",
	-- {area:1769} Timbermaw Hold · {zone:1448} Felwood
	["{area:1769}, {zone:1448} side"] = "",

	-- Step 10: Deadwood Cauldron
	-- {area:1762} Felpaw Village
	["The Deadwood cauldron stands at the top of {area:1762}, just west of the cave mouth."] = "",
	-- {quest:5085} Mystery Goo · {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["{quest:5085}: {npc:9298}, on this guide's {zone:1452} loop: keep it"] = "",

	-- Step 11: Talonbranch Glade
	-- {area:1998} Talonbranch Glade
	["Ride south from the cave to {area:1998}, the night elves' camp on the road."] = "",

	-- Step 12: Fly to Ratchet
	-- {area:392} Ratchet
	["Fly to {area:392}"] = "",

	-- Step 13: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",

	-- Step 14: The Barrens
	-- {zone:1413} The Barrens · {area:392} Ratchet
	["From Theramore, ride west into the {zone:1413} and north up the coast to {area:392}."] = "De Theramore, siga para oeste até {zone:1413} e para o norte pela costa até {area:392}.",

	-- Step 15: Ratchet
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}: the ash is in Un'Goro; inside"] = "",

	-- Step 16: The Stone Circle
	-- {quest:3444} The Stone Circle
	["{quest:3444} stands on the hill just south-west of the flight master."] = "",

	-- Step 17: Islen Waterseer
	-- {npc:5901} Islen Waterseer
	["{npc:5901} stands on the coast south-east of town."] = "",
	-- {zone:1448} Felwood
	["For Greta in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 18: Fly to Gadgetzan
	-- {area:976} Gadgetzan
	["Fly to {area:976}"] = "",
	-- {area:392} Ratchet
	["{area:392} flight master"] = "Mestre de voo de {area:392}",

	-- Step 19: Gadgetzan
	-- {area:976} Gadgetzan · {npc:9623} A-Me 01 · {quest:4243} Chasing A-Me 01 · {item:10561} Mithril Casing · {skill:202} Engineering
	["{area:976}'s Auction House is the last one before Un'Goro. There, {npc:9623} ({quest:4243}) asks for a {item:10561}, an {skill:202} item, before her escort: buy one here if you want that chain."] = "A Casa de Leilões de {area:976} é a última antes de Un'Goro. Lá, {npc:9623} ({quest:4243}) pede um {item:10561}, um item de {skill:202}, antes da escolta dela: compre um aqui se quiser essa cadeia.",
	-- {npc:5594} Alchemist Pestlezugg
	["{npc:5594}, inside"] = "{npc:5594}, lá dentro",
	-- {npc:7876} Tran'rek
	["{npc:7876}, north side of town: the tar is in Un'Goro"] = "",

	-- Step 20: Gaeriyan
	-- {npc:9299} Gaeriyan · {item:11243} Videre Elixir
	["{npc:9299} is a ghost at the graveyard just east of town: drink a {item:11243} there, which kills you, release your spirit and talk to him as a ghost. Then run back to your body to come back to life: the gravestone stands nearby."] = "{npc:9299} é um fantasma no cemitério logo a leste da cidade: beba um {item:11243} lá, o que mata você, libere o espírito e fale com ele como fantasma. Depois corra de volta ao seu corpo para reviver: a lápide fica ali perto.",
	-- {npc:8737} Linken · {area:541} Marshal's Refuge
	["{npc:8737} in {area:541}, Un'Goro: keep it"] = "",

	-- Step 21: Broken Pillar
	-- {npc:7771} Marvon Rivetseeker · {area:1938} Broken Pillar
	["Ride south-west to {npc:7771}'s camp at the {area:1938}."] = "Siga para o sudoeste até o acampamento de {npc:7771} em {area:1938}.",
	-- {npc:7771} Marvon Rivetseeker · {area:1417} Sunken Temple
	["{npc:7771}'s next task, Into the Depths, is inside the {area:1417}: skip it."] = "",

	-- Step 23: Fly to Marshal's Refuge
	-- {area:541} Marshal's Refuge
	["Fly to {area:541}"] = "Voe para {area:541}",
	-- {area:976} Gadgetzan
	["{area:976} flight master"] = "Mestre de voo de {area:976}",

	-- Step 24: Marshal's Refuge
	-- {area:976} Gadgetzan · {area:541} Marshal's Refuge · {npc:9997} Spraggle Frock · {npc:9999} Ringo · {npc:8737} Linken · {npc:9117} J.D. Collie · {npc:9618} Karna Remtravel
	["Fly from {area:976} to {area:541}. {npc:9997}'s friend {npc:9999} has gone missing; {npc:8737} stands at the back of the refuge, with {npc:9117} in the cave behind him; {npc:9618} stands just outside, on the way out east."] = "",
	-- {npc:9997} Spraggle Frock
	["The wooden sign beside {npc:9997}"] = "A placa de madeira ao lado de {npc:9997}",
	-- {npc:9117} J.D. Collie
	["{npc:9117}, below ground"] = "{npc:9117}, no subterrâneo",
	-- {npc:9116} Eridan Bluewind · {zone:1448} Felwood
	["For {npc:9116} in {zone:1448}, later in this guide: keep it"] = "",

	-- Step 25: Northern Pylon
	["Northern Pylon"] = "Pilar do Norte",
	-- {npc:9166} Pterrordax · {npc:9997} Spraggle Frock · {npc:6584} King Mosh
	["The pylon stands on the slope east of the refuge. {npc:9166} circle the slopes around it: they count for {npc:9997}.\nCareful: {npc:6584} (60), a rare devilsaur, roams the crater's west around 27,46: if you meet him, ride away."] = "",

	-- Step 26: A-Me 01
	-- {area:1943} Ironstone Plateau
	["Ride east to {area:1943}, where the robot stands among the gorillas. Stay out of the deep cave there."] = "Siga para o leste até {area:1943}, onde o robô fica entre os gorilas. Não entre na caverna funda dali.",
	-- was: ["{item:15785}; below ground"] = "{item:15785}; no subterrâneo"
	["Below ground"] = "",

	-- Step 27: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau
	["{area:1943}: kill these as you meet them"] = "{area:1943}: vá matando estes pelo caminho",
	-- {area:1943} Ironstone Plateau · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, just east of the pylon: take the pelts for {npc:9619} now, while you are up here. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Os gorilas vivem em {area:1943}, logo a leste da torre de cristal: pegue os pelegos para {npc:9619} agora, enquanto está aqui em cima. Não entre na caverna mais funda: {npc:9622} é nível 55.\nCuidado: os Gorilas de Un'Goro (nível 50-51) chamam ajuda de aliados num raio de 20 m quando caem para 25% de vida. Tem uma caverna lotada de macacos na área, e lutar lá traz monstro a mais de montão.",
	-- {item:11478} Un'Goro Gorilla Pelt
	["{item:11478}; below ground"] = "{item:11478}; no subterrâneo",
	-- {item:11479} Un'Goro Stomper Pelt
	["{item:11479}; below ground"] = "{item:11479}; no subterrâneo",
	-- {item:11480} Un'Goro Thunderer Pelt
	["{item:11480}; below ground"] = "{item:11480}; no subterrâneo",

	-- Step 29: Lakkari Tar Pits: kill these as you meet them
	-- {area:538} Lakkari Tar Pits
	["{area:538}: kill these as you meet them"] = "{area:538}: vá matando estes pelo caminho",
	-- {area:538} Lakkari Tar Pits
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Tar Lords = {npc:6519} Tar Lord
	["The Tar Beasts and Tar Lords wallow in the {area:538}, south of the refuge on the way down into the crater."] = "Os Monstros de Piche e os Senhores do Piche chafurdam em {area:538}, ao sul do refúgio, no caminho para dentro da cratera.",

	-- Step 30: The crater
	["The crater"] = "A cratera",
	-- {area:538} Lakkari Tar Pits · {area:537} Fire Plume Ridge · {area:540} Slithering Scar · {item:11018} Un'Goro Soil
	-- plural, as words: Tar Beasts = {npc:6517} Tar Beast · Gorishi Workers = {npc:6552} Gorishi Worker
	["Tar Beasts wallow in the {area:538}; the fire elementals of {area:537} in the middle carry the ash; the Gorishi wasps of the {area:540} in the south carry the gland. Every creature in the crater can drop {item:11018}.\nCareful: Gorishi Workers that drop below 45% health have a 50% chance to call for help from allies within 25 yd."] = "Monstros de Piche chafurdam em {area:538}; os elementais do fogo de {area:537}, no meio, carregam a cinza; as vespas Gorishi de {area:540}, no sul, carregam a glândula. Qualquer criatura da cratera pode deixar cair {item:11018}.\nCuidado: as Gorishi Trabalhadoras que caem abaixo de 45% de vida têm 50% de chance de chamar ajuda de aliados num raio de 25 m.",

	-- Step 31: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["{npc:9619} camps at the foot of the ramp into the crater."] = "{npc:9619} acampa ao pé da rampa que leva à cratera.",
	-- {quest:4291} The Scent of Lar'korwi
	["{quest:4291}, if you still carry it from the first visit"] = "{quest:4291}, se ainda estiver com ela desde a primeira visita",
	-- {area:1943} Ironstone Plateau
	["The pelts come from the gorillas on {area:1943}"] = "As peles vêm dos gorilas em {area:1943}",
	-- {quest:87494} Microcrystal Contamination
	["{quest:87494}, if a ravasaur dropped the scale since the first visit"] = "{quest:87494}, se um ravassauro tiver deixado cair a escama desde a primeira visita",

	-- Step 32: Damaged Blue Crystal
	-- {item:280417} Damaged Blue Crystal · {npc:9619} Torwa Pathfinder
	["The {item:280417} is a short ride west of {npc:9619}'s camp."] = "O {item:280417} fica a uma curta cavalgada a oeste do acampamento de {npc:9619}.",

	-- Step 35: Ironstone Plateau: kill these as you meet them
	-- {area:1943} Ironstone Plateau · {area:541} Marshal's Refuge · {npc:9619} Torwa Pathfinder · {npc:9622} U'cha
	-- plural, as words: Un'Goro Gorillas = {npc:6514} Un'Goro Gorilla
	["The gorillas live on {area:1943}, east of {area:541}. Keep their pelts for {npc:9619}. Stay out of the deepest cave: {npc:9622} is level 55.\nCareful: Un'Goro Gorillas (level 50-51) call for help from allies within 20 yd once they drop to 25% health. There is a cave full of apes in the area, and fighting there brings many adds."] = "Os gorilas vivem em {area:1943}, a leste de {area:541}. Guarde os pelegos para {npc:9619}. Não entre na caverna mais funda: {npc:9622} é nível 55.\nCuidado: os Gorilas de Un'Goro (nível 50-51) chamam ajuda de aliados num raio de 20 m quando caem para 25% de vida. Tem uma caverna lotada de macacos na área, e lutar lá traz monstro a mais de montão.",

	-- Step 37: U'cha
	-- {npc:9622} U'cha
	["Ride north along the east side to the gorilla plateau. {npc:9622}, a level 55 gorilla, sits in its deepest cave: clear the gorillas at the cave mouth first."] = "Siga para o norte pelo lado leste até o planalto dos gorilas. {npc:9622}, um gorila de nível 55, fica na caverna mais funda: limpe os gorilas da entrada antes.",

	-- Step 38: Lar'korwi
	-- {npc:9684} Lar'korwi · {npc:9619} Torwa Pathfinder · {item:11568} Torwa's Pouch
	["{npc:9684}'s lair lies in the jungle north of {npc:9619}, below the eastern cliffs: use {item:11568} there.\nCareful: {npc:9684} is level 56, a level or two over you here: start at full health, and clear the raptors around the lair first."] = "",

	-- Step 39: Eastern Pylon and the crate
	["Eastern Pylon and the crate"] = "Torre de cristal leste e o caixote",
	-- {npc:9684} Lar'korwi · {item:11113} Crate of Foodstuffs
	["The pylon stands on the eastern cliffs above {npc:9684}'s lair; the expedition's {item:11113} sits at the abandoned camp in the eastern jungle."] = "A torre de cristal fica nos penhascos leste acima do covil de {npc:9684}; o {item:11113} da expedição está no acampamento abandonado na selva leste.",

	-- Step 40: Torwa Pathfinder
	-- {npc:9619} Torwa Pathfinder
	["Cross the south of the crater to {npc:9619} by the ramp."] = "Atravesse o sul da cratera até {npc:9619}, junto à rampa.",

	-- Step 41: The Marshlands: kill these as you meet them
	-- {area:1942} The Marshlands
	["{area:1942}: kill these as you meet them"] = "{area:1942}: vá matando estes pelo caminho",

	-- Step 42: The Gorishi hive
	["The Gorishi hive"] = "A colmeia Gorishi",
	["West along the south of the crater: the Gorishi hive fills it. Use the Scraping Vial on a hatchery, a chamber with hanging larvae."] = "Para o oeste pelo sul da cratera: a colmeia Gorishi ocupa a área. Use o Frasco de Raspagem num berçário, uma câmara com larvas penduradas.",

	-- Step 43: Bones and equipment
	["Bones and equipment"] = "Ossos e equipamentos",
	-- {item:11112} Research Equipment
	-- plural, as words: Dinosaur Bones = {item:11114} Dinosaur Bone
	["West across the south of the crater: Dinosaur Bones lie on the ground in the south-west, among the stegodons: those are elite, pick the bones up around them and take the rest from the Diemetradons. The expedition's {item:11112} lies in the south-west jungle.\nCareful: Gruff (57), a rare devilsaur, prowls the south around 38,75: if you meet him, ride away."] = "",

	-- Step 44: Western Pylon
	["Western Pylon"] = "Pilar do Oeste",
	["The pylon stands on the western cliffs."] = "A torre de cristal fica nos penhascos oeste.",

	-- Step 45: Krakle
	-- {area:543} Golakka Hot Springs · {npc:10302} Krakle
	["North-east from the pylon to {area:543}: {npc:10302} the goblin sits by the water."] = "",

	-- Step 46: Krakle's Thermometer
	-- {area:537} Fire Plume Ridge · {npc:10541} Krakle's Thermometer
	["Ride east to {area:537}, climb it and use {npc:10541} at the lava vents near the top."] = "Siga para o leste até {area:537}, suba e use {npc:10541} nas aberturas de lava perto do topo.",

	-- Step 47: Krakle
	-- {npc:10302} Krakle
	["Back west to {npc:10302} at the hot springs."] = "",
	-- {npc:9298} Donova Snowden · {zone:1452} Winterspring
	["Ends with {npc:9298} in {zone:1452}, later in this guide: keep it"] = "",

	-- Step 48: Ringo
	-- {npc:9999} Ringo · {area:537} Fire Plume Ridge
	["{npc:9999} sits on the south-east slope of {area:537}, in the middle of the crater."] = "{npc:9999} está sentado na encosta sudeste de {area:537}, no meio da cratera.",

	-- Step 49: Escort Ringo
	-- {npc:9999} Ringo
	["Escort {npc:9999}"] = "Escolte {npc:9999}",
	-- {npc:9999} Ringo · {area:541} Marshal's Refuge · {item:11804} Spraggle's Canteen
	["Lead {npc:9999} north to {area:541}. When he faints, use {item:11804} on him to wake him."] = "Leve {npc:9999} para o norte até {area:541}. Quando ele desmaiar, use {item:11804} nele para acordá-lo.",

	-- Step 51: Fly to Gadgetzan
	-- {area:541} Marshal's Refuge
	["{area:541} flight master"] = "Mestre de voo de {area:541}",

	-- Step 52: Gadgetzan
	-- {npc:10041} Gorishi Hive Queen · {area:540} Slithering Scar
	["Pestlezugg's next task, Pawn Captures Queen, sends you back to the {npc:10041} in the {area:540}: skip it."] = "",

	-- Step 54: Liv Rizzlefix
	-- {npc:8496} Liv Rizzlefix
	["{npc:8496}, inside"] = "{npc:8496}, lá dentro",

	-- Step 55: Fly to Astranaar
	-- {area:415} Astranaar
	["Fly to {area:415}"] = "Voe para {area:415}",

	-- Step 56: Felwood
	-- {area:415} Astranaar · {zone:1448} Felwood · {area:2479} Emerald Sanctuary
	["Ride north out of {area:415} into {zone:1448} to the {area:2479}, the druids' camp by the road."] = "Siga para o norte, saindo de {area:415}, até {zone:1448}, até {area:2479}, o acampamento dos druidas junto à estrada.",
	-- {area:2479} Emerald Sanctuary
	["The {area:2479}"] = "{area:2479}",

	-- Step 57: Eridan Bluewind
	-- {npc:9116} Eridan Bluewind · {area:2479} Emerald Sanctuary
	["{npc:9116} stands inside, in the {area:2479}."] = "{npc:9116} fica lá dentro, em {area:2479}.",
	-- {npc:9116} Eridan Bluewind
	["{npc:9116}, inside"] = "{npc:9116}, lá dentro",

	-- Step 58: The Emerald Sanctuary
	-- {npc:10924} Ivy Leafrunner · {npc:11079} Wynd Nightchaser · {area:2253} Starfall Village
	["{npc:10924}: for {npc:11079} in {area:2253}, later in this guide; keep it"] = "",
	-- {npc:9116} Eridan Bluewind
	["Wait a moment for {npc:9116}"] = "Espere um pouco por {npc:9116}",
	-- {npc:9116} Eridan Bluewind · {npc:222647} Ancient Spirit · {npc:3848} Kayneth Stillwind · {area:2358} Forest Song · {zone:1448} Felwood
	["{npc:9116}'s next task, {npc:222647}, ends with {npc:3848} at {area:2358}, south of the route once {zone:1448} is done: skip it."] = "",
	-- {npc:9116} Eridan Bluewind
	-- plural, as words: Irontree Stompers = {npc:7139} Irontree Stomper
	["{npc:9116}'s next task, Silver Heart, sends you to the Irontree Stompers in the north and back here: skip it."] = "",

	-- Step 59: Shadow Hold braziers
	-- {area:1770} Shadow Hold
	["{area:1770} braziers"] = "Braseiros de {area:1770}",
	-- {area:1770} Shadow Hold · {area:1763} Jaedenar · {item:12906} Purified Moonwell Water · {item:13140} Blood Red Key · {npc:11018} Arko'narin
	-- plural, as words: Jaedenar Darkweavers = {npc:7118} Jaedenar Darkweaver
	["{area:1770} is the cave at the back of {area:1763}, west of the road. Use the {item:12906} on the four braziers inside.\nCareful: Shadow Council mobs of level 53-55 fill the cave and often come in large linked groups, many with stuns: pull at the edge of each group and fight one pack at a time.\nThe Jaedenar Darkweavers, Warlocks and Enforcers in here drop a {item:13140}, about one kill in thirty: keep killing them until it drops. It opens the cell of {npc:11018}, the night elf held in the cave."] = "",
	-- {object:176159} Brazier of Malice
	["{object:176159}, below ground"] = "{object:176159}, no subterrâneo",
	-- {object:176160} Brazier of Suffering
	["{object:176160}, below ground"] = "{object:176160}, no subterrâneo",
	-- {object:176158} Brazier of Pain
	["{object:176158}, below ground"] = "{object:176158}, no subterrâneo",
	-- {object:176161} Brazier of Hatred
	["{object:176161}, below ground"] = "{object:176161}, no subterrâneo",
	-- {item:11515} Corrupted Soul Shard · {npc:9528} Arathandris Silversky
	["{item:11515}, from the same cultists: {npc:9528} takes six by the Sanctuary if you did Cleansing Felwood"] = "",
	-- {npc:11016} Captured Arko'narin
	["{npc:11016}, in her cell; below ground"] = "{npc:11016}, na cela dela; no subterrâneo",

	-- Step 60: Arko'narin
	-- {area:1770} Shadow Hold
	["Lead her out of {area:1770} and keep her alive until she is outside the cave: clear the way back first."] = "Leve-a para fora de {area:1770} e mantenha-a viva até ela estar fora da caverna: limpe antes o caminho de volta.",

	-- Step 62: Greta Mosshoof: A Final Blow
	-- {quest:5242} A Final Blow · {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold
	["{quest:5242} is a group quest at this level: {npc:9861} (52), {npc:9860} (54) and {npc:9517} (57) fight together at the back of {area:1770}. Grouping up is encouraged, look for people to do it with. Skip it if you are alone."] = "",

	-- Step 63: Rakaiah
	-- {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["Back into {area:1770}: the succubus {npc:9518} (56) waits on the way to its deepest chamber, with Trey Lightforge's remains beside her.\nCareful: {npc:9518} is level 56: clear the cultists around her first and fight her at full health."] = "",
	-- {npc:9518} Rakaiah
	["{npc:9518}, below ground"] = "{npc:9518}, no subterrâneo",
	-- {npc:11020} Remains of Trey Lightforge
	["{npc:11020}, below ground"] = "{npc:11020}, no subterrâneo",

	-- Step 64: A Final Blow
	-- {npc:9861} Moora · {npc:9860} Salia · {npc:9517} Shadow Lord Fel'dan · {area:1770} Shadow Hold · {npc:9518} Rakaiah
	["{npc:9861} and {npc:9860} guard {npc:9517} in {area:1770}'s deepest chamber, just past {npc:9518}.\nCareful: The three bosses fight as a group. Kill the nearby mobs first so you don't pull extra enemies."] = "",
	-- {npc:9861} Moora
	["{npc:9861}, below ground"] = "{npc:9861}, no subterrâneo",
	-- {npc:9860} Salia
	["{npc:9860}, below ground"] = "{npc:9860}, no subterrâneo",
	-- {npc:9517} Shadow Lord Fel'dan
	["{npc:9517}; below ground"] = "{npc:9517}; no subterrâneo",

	-- Step 65: The Emerald Sanctuary
	["Ride back south-east to the Sanctuary."] = "Cavalgue de volta para sudeste até o Santuário.",

	-- Step 66: Arathandris Silversky
	-- {npc:9528} Arathandris Silversky · {area:1770} Shadow Hold
	-- plural, as words: Corrupted Soul Shards = {item:11515} Corrupted Soul Shard
	["{npc:9528} is in the ruins just down the road from the Sanctuary: he takes the six Corrupted Soul Shards (from both trips into {area:1770}) on the spot."] = "",

	-- Step 68: Timbermaw Hold
	-- {area:1769} Timbermaw Hold
	["Ride north up the road to the cave mouth of {area:1769}."] = "",

	-- Step 69: Kernda
	-- {npc:11558} Kernda · {area:1769} Timbermaw Hold
	["{npc:11558} stands just inside the {area:1769} cave: she needs Neutral with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11558} Kernda
	["{npc:11558}: walks around here: look inside the circle on the map"] = "{npc:11558}: anda por aqui: procure dentro do círculo no mapa",

	-- Step 71: Meilosh
	-- {npc:11557} Meilosh · {npc:11558} Kernda · {quest:6031} Runecloth
	["{npc:11557}, just inside the cave beside {npc:11558}, takes thirty {quest:6031} from Friendly with the Timbermaw; the reputation guide gets you there."] = "",
	-- {npc:11557} Meilosh
	["{npc:11557}; below ground"] = "{npc:11557}; no subterrâneo",

	-- Step 72: Into Winterspring
	-- {zone:1452} Winterspring
	["Into {zone:1452}"] = "Rumo a {zone:1452}",
	-- {area:1769} Timbermaw Hold · {zone:1452} Winterspring
	["Through {area:1769}'s tunnel to its {zone:1452} end."] = "",

	-- Step 73: Donova Snowden
	-- {npc:9298} Donova Snowden
	["Ride on to {npc:9298}'s camp beside the hot springs."] = "",
	-- {quest:980} The New Springs · {area:2256} Darkwhisper Gorge
	["{quest:980}' follow-up, Strange Sources, is at {area:2256}'s mouth among elite giants and Hederine: skip it."] = "",
	-- {quest:5086} Toxic Horrors · {zone:1448} Felwood
	["The {quest:5086} are just back through the tunnel, in {zone:1448}"] = "",

	-- Step 74: Felwood
	-- {zone:1448} Felwood · {area:1998} Talonbranch Glade · {quest:5086} Toxic Horrors · {area:1767} Irontree Woods
	["Back through the tunnel to {zone:1448} and south past {area:1998}: the {quest:5086} (53) roam the north-eastern tip of {area:1767}."] = "",
	-- {quest:5086} Toxic Horrors
	["The {quest:5086}"] = "{quest:5086}",

	-- Step 75: Toxic Horrors
	-- {quest:5086} Toxic Horrors
	-- plural, as words: Ancient Irontree Walkers = {npc:235912} Ancient Irontree Walker
	["Careful: Ancient Irontree Walkers, level 59 elites, stand among the {quest:5086}: work the Horrors at the camp's north-east tip (about 50.6,22.4), one at a time, and look for a walker before each pull."] = "Cuidado: Andarilhos Ancestrais de Ferrárbol, elites de nível 59, ficam entre os {quest:5086}: pegue os Horrores na ponta nordeste do acampamento (por volta de 50.6,22.4), um de cada vez, e procure um andarilho antes de cada puxada.",

	-- Step 76: Winterspring
	-- {area:1769} Timbermaw Hold · {npc:9298} Donova Snowden
	["Back north through {area:1769}'s tunnel to {npc:9298}."] = "",

	-- Step 78: Winterspring: kill these as you meet them
	-- {zone:1452} Winterspring
	["{zone:1452}: kill these as you meet them"] = "{zone:1452}: vá matando estes pelo caminho",
	-- {quest:5087} Winterfall Runners · {area:2246} Frostfire Hot Springs · {zone:1448} Felwood · {spell:5384} Feign Death
	["The {quest:5087} (57) carry their crates along the road between {area:2246} and {zone:1448}'s tunnel.\nCareful: Turning in spawns three or four level 56-57 Winterfall ambushers that attack you; you can escape them while mounted, in stealth or with {spell:5384}, and they then gather by the lake so you can take the next quest.\nCareful: the {quest:5087} are 57, over you here: pull one at a time, away from the camp."] = "",

	-- Step 80: Everlook
	-- {area:2255} Everlook
	["Ride east along the road to {area:2255}."] = "Siga a estrada para o leste até {area:2255}.",
	-- {npc:11755} Harlo Wigglesworth · {npc:10301} Jaron Stoneshaper · {area:2253} Starfall Village
	["{npc:11755}: for {npc:10301} in {area:2253}, just back up the road"] = "",
	-- {npc:10431} Gregor Greystone
	["{npc:10431}: keep it for the Plaguelands, on the next guide; inside"] = "",

	-- Step 81: Starfall Village
	-- {area:2253} Starfall Village · {npc:11079} Wynd Nightchaser · {npc:10301} Jaron Stoneshaper
	["Ride back north-west to {area:2253} on its hill: {npc:11079} and {npc:10301} stand together."] = "",
	-- {quest:5250} Starfall
	["The relics are in the ruins just south of {quest:5250}"] = "",

	-- Step 82: The Ruins of Kel'Theril
	-- {area:2253} Starfall Village · {npc:10304} Aurora Skycaller · {zone:1423} Eastern Plaguelands
	["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins: {npc:10304} in the {zone:1423} takes them, on the next guide."] = "",

	-- Step 83: The road to Everlook: furs and horns
	-- {area:2255} Everlook
	["The road to {area:2255}: furs and horns"] = "",
	-- {area:2255} Everlook · {npc:9298} Donova Snowden
	-- plural, as words: Thick Yeti Furs = {item:12366} Thick Yeti Fur · Uncracked Chillwind Horns = {item:12444} Uncracked Chillwind Horn · Rogue Ice Thistles = {npc:7457} Rogue Ice Thistle · Fledgling Chillwinds = {npc:7447} Fledgling Chillwind · Ice Thistle Yetis = {npc:7458} Ice Thistle Yeti · Chillwind Chimaeras = {npc:7448} Chillwind Chimaera
	["Still short of Thick Yeti Furs or Uncracked Chillwind Horns? The Rogue Ice Thistles and the Fledgling Chillwinds (both 53-55) live along the road west of {area:2255}, toward {npc:9298}. The hills east of {area:2255} hold only the Ice Thistle Yetis (55-56), Matriarchs and Patriarchs, and the Chillwind Chimaeras (55-57) and Ravagers (57-59): don't hunt the furs and horns there."] = "",

	-- Step 85: Pristine Yeti Horns
	-- plural, as words: Pristine Yeti Horns = {item:12367} Pristine Yeti Horn
	["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	["Check the two outdoor Matriarchs (56) on the western slope of the yetis' hills. Leave the Patriarchs (57) and the cave alone. If you don't get both horns on this pass, skip the hunt and Umi's hand-in."] = "",
	-- plural, as words: Ice Thistle Matriarchs = {npc:7459} Ice Thistle Matriarch
	["Loot the horns from Ice Thistle Matriarchs"] = "",

	-- Step 86: Everlook
	-- {area:2255} Everlook · {area:976} Gadgetzan
	["Umi's next task scares three goblins in {area:2255}, {area:976} and Un'Goro, behind the route now: skip it."] = "",

	-- Step 87: Jaron Stoneshaper's camp
	-- {npc:10301} Jaron Stoneshaper
	["{npc:10301}'s camp"] = "Acampamento de {npc:10301}",
	-- {area:2255} Everlook · {npc:10301} Jaron Stoneshaper · {area:2245} Mazthoril
	-- was: ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cavalgue para sudeste descendo o vale até o caixote danificado de {npc:10301} na neve em {area:2245}, com a carroça destruída dele logo a leste."
	["Ride south-east from {area:2255} down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "",

	-- Step 88: Sindrayl
	-- {zone:1452} Winterspring · {area:1769} Timbermaw Hold · {area:493} Moonglade · {npc:10897} Sindrayl · {area:2361} Nighthaven
	["Ride back north up the valley and west along the road to the tunnel at {zone:1452}'s western end, where Salfa stands. Walk into {area:1769} and take the {area:493} branch of the tunnel down to {area:493}. {npc:10897}, {area:493}'s flight master, stands south of the lake, outside {area:2361}: learn the flight path from him. The flight master in {area:2361} itself flies only Druids, from her gossip, and has no flight path to learn. The next guide flies on from here."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Any Winterfall furbolg can drop the totem, about one kill in thirty: if the top-up did not bring one, keep killing them here until it drops, then right-click it."] = "Qualquer furbolg Invernoso pode soltar o totem, cerca de uma morte em trinta: se a rodada para completar o nível não trouxe um, continue matando-os aqui até soltar, depois clique nele com o botão direito.",
	-- ["Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh."] = "Qualquer furbolg daqui pode soltar {item:12771} (cerca de um em dez: vem dentro das mortes que essas missões exigem) e {quest:8471} (cerca de um em trinta): clique com o botão direito no que cair. Guarde {item:14047} que os furbolgs soltam para Meilosh.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs (56-57) and Patriarchs (57-58) carry the horns.\nCareful: take the Matriarchs at the edge of the hills, one at a time, and leave the Patriarchs: their horns drop from both."] = "De volta às colinas: só as Matriarcas Cardo de Gelo (56-57) e os Patriarcas (57-58) têm os chifres.\nCuidado: pegue as Matriarcas na borda das colinas, uma de cada vez, e deixe os Patriarcas: os chifres caem dos dois.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns."] = "De volta às colinas: só as Matriarcas e os Patriarcas Cardo de Gelo carregam os chifres.",
	-- ["Back to the hills: only the Ice Thistle Matriarchs and Patriarchs carry the horns. Keep killing yetis until level 54: Harlo's wildkin quests are red before that."] = "De volta às colinas: só as Matriarcas e os Patriarcas Cardo de Gelo levam os chifres. Continue matando yetis até o nível 54: as missões de plumacuns de Harlo ficam vermelhas antes disso.",
	-- ["Back to {npc:11053} at {area:3197}."] = "Volte para {npc:11053} no {area:3197}.",
	-- ["Boat to {area:150}"] = "Navio para {area:150}",
	-- ["Careful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "Cuidado: o {npc:10411} fica invisível fora de combate e chama Gárgulas Petrasas quando a luta começa. Só existem 3, e elas renascem a cada 15 min.",
	-- ["Fly to {area:271}"] = "Voar para {area:271}",
	-- ["Fly to {area:3197}"] = "Voe para o {area:3197}",
	-- ["Follow the road east across the zone to the chapel."] = "Siga a estrada para leste atravessando a zona até a capela.",
	-- ["Follow the road west to {npc:9298}'s camp beside the hot springs."] = "Siga a estrada para oeste até o acampamento de {npc:9298}, ao lado das fontes termais.",
	-- ["Follow the southern road east into the {area:139}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Siga a estrada do sul para leste até as {area:139}; as ruínas de {area:2262} ficam ao sul dela. O fantasma de {npc:10926} brinca junto à casa em ruínas no extremo sul.",
	-- ["Follow the southern road east into the {zone:1423}; the ruins of {area:2262} lie south of it. {npc:10926}'s ghost plays by the ruined house at the south end."] = "Siga a estrada do sul para leste até as {zone:1423}; as ruínas de {area:2262} ficam ao sul dela. O fantasma de {npc:10926} brinca junto à casa em ruínas no extremo sul.",
	-- ["Follow {npc:9298}'s directions to the mouth of {area:2256}, past the Frostmaul giants: pass them one at a time."] = "Siga as instruções de {npc:9298} até a entrada do {area:2256}, passando pelos gigantes Friomalho: passe por eles um de cada vez.",
	-- ["For Kernda in {area:1769}: keep it"] = "Para Kernda em {area:1769}: guarde-o",
	-- ["Free Darrowshire Spirits: talk to them"] = "Liberte os Espíritos da Vila das Flechas: fale com eles",
	-- ["From {area:271}, ride north up the road through Alterac to {area:3197}."] = "De {area:271}, siga para o norte pela estrada por Alterac até {area:3197}.",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}."] = "Yetis Cardo de Gelo vivem nas colinas ao sul da {area:2244}, Quimeras Ventogelantes no vale rumo a {area:2255}.",
	-- ["Ice Thistle yetis live in the hills south of {area:2244}, Chillwind Chimaeras in the valley toward {area:2255}.\nCareful: the Ice Thistle Yetis are 55-56 and the Chimaeras 55-57: take the Rogue Ice Thistles (53-55) and the Fledgling Chillwinds (53-55) at the edge of the hills, and leave the Chillwind Ravagers (57-59) alone."] = "Os yetis Cardo de Gelo vivem nas colinas ao sul de {area:2244}, as Quimeras Ventogelante no vale em direção a {area:2255}.\nCuidado: os Yetis Cardo de Gelo são 55-56 e as Quimeras 55-57: pegue os Ladinos Cardo de Gelo (53-55) e os Filhotes de Ventogelante (53-55) na borda das colinas e deixe os Assoladores de Ventogelante (57-59) em paz.",
	-- ["Inside"] = "Lá dentro",
	-- ["Into {zone:1423}"] = "Rumo a {zone:1423}",
	-- ["Its jars are filled on the {zone:1451} guide's Un'Goro visit: keep it"] = "Os jarros são enchidos na visita a Un'Goro do guia de {zone:1451}: guarde-o",
	-- ["Keep it: Gregan in {zone:1444} brews the elixir later"] = "Guarde-o: Gregan em {zone:1444} prepara o elixir mais tarde",
	-- ["Level 55 at {area:2246}"] = "Nível 55 em {area:2246}",
	-- ["Level 55.05"] = "Nível 55.05",
	-- ["North-west out of the camp to {area:199}, west of Andorhal: {npc:11075} (53) guards the cauldron among the Jabbering Ghouls (54)."] = "Saia do acampamento para noroeste até {area:199}, a oeste de Andorhal: {npc:11075} (53) guarda o caldeirão entre os Carniçais Grasnantes (54).",
	-- ["On the road east out of {area:3197}, {npc:10927}'s farmhouse stands on {area:197}: her {quest:5142} goes to the same ghost in {area:2262}."] = "Na estrada para leste saindo do {area:3197}, a casa de fazenda de {npc:10927} fica em {area:197}: {quest:5142} dela vai para o mesmo fantasma em {area:2262}.",
	-- ["On {npc:10978}, by the inn"] = "Em {npc:10978}, perto da estalagem",
	-- ["Optional: {area:1417}"] = "Opcional: {area:1417}",
	-- ["Pick up the supplies around the wagon and take {npc:10301}'s amulet back from the owlbeasts nearby."] = "Pegue os suprimentos em volta da carroça e tome de volta o amuleto de {npc:10301} dos corujursos próximos.",
	-- ["Pristine Yeti Horns"] = "Chifres Impolutos de Yeti",
	-- ["Pureheart, Dumah, Valorfist and MacDonnell stand around the middle of the camp, by the flight master."] = "Purocoração, Dumah, Punho Valente e MacDonnell ficam no meio do acampamento, perto do mestre de voo.",
	-- ["Ride north to {area:2627}. {npc:12384} lives in the ruined hut, and his receipt book lies in the ruined inn nearby."] = "Cavalgue para o norte até {area:2627}. {npc:12384} mora na cabana em ruínas, e o livro de recibos dele está na estalagem em ruínas ali perto.",
	-- ["Ride north up the valley, past {area:2255}, to {area:2253}."] = "Siga para o norte pelo vale, passando por {area:2255}, até {area:2253}.",
	-- ["Ride north-west back to the village."] = "Cavalgue para noroeste de volta à aldeia.",
	-- ["Ride south-east down the valley to {npc:10301}'s damaged crate in the snow at {area:2245}, with his wrecked wagon just east of it."] = "Cavalgue para sudeste descendo o vale até o caixote danificado de {npc:10301} na neve em {area:2245}, com a carroça destruída dele logo a leste.",
	-- ["Ride west along the road to the night elf village."] = "Cavalgue para oeste pela estrada até a aldeia dos elfos noturnos.",
	-- ["Ride west along the road to {npc:10301}."] = "Cavalgue para oeste pela estrada até {npc:10301}.",
	-- ["Scare {npc:10978} with {item:12928}"] = "Assuste {npc:10978} com {item:12928}",
	-- ["Short of level 54 after the yetis? Running the {area:1417} (50-54) instead of grinding gets you there faster in a group. Come back to {area:2255} afterwards."] = "Abaixo do nível 54 depois dos yetis? Fazer o {area:1417} (50-54) em grupo em vez de farmar leva você lá mais rápido. Volte a {area:2255} depois.",
	-- ["The Deadwood cauldron in {zone:1448}: keep it"] = "O caldeirão Lenha Morta em {zone:1448}: guarde-o",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it."] = "O Flagelo em volta de {area:2264}, a oeste da capela, deixa cair os dois tipos de Pedra do Flagelo; Espíritos da Vila das Flechas surgem deles: fale com cada um para libertá-lo.",
	-- ["The Scourge around {area:2264}, west of the chapel, drop both kinds of Scourgestone; Darrowshire Spirits rise from them: talk to each one to free it.\nCareful: {npc:10411} goes invisible when out of combat and calls Rockwing Gargoyles once a fight starts. Only 3 exist and they respawn every 15 min."] = "O Flagelo ao redor de {area:2264}, a oeste da capela, solta os dois tipos de Pedra do Flagelo; Espíritos da Vila das Flechas surgem delas: fale com cada um para libertá-lo.\nCuidado: {npc:10411} fica invisível fora de combate e chama Gárgulas Petrasa assim que a luta começa. Existem apenas 3, e elas reaparecem a cada 15 min.",
	-- ["The Winterfall camp"] = "O acampamento dos Invernosos",
	-- ["The Winterfall furbolg village lies east of {area:2255}: Shaman (56-57), Den Watchers (55-56) and Ursa (57-58), all above you. Kill the Shaman first, they heal, and pull from the edge. {npc:10738} in the cave at the back is elite: stay out."] = "A aldeia dos furbolgs Invernosos fica a leste de {area:2255}: Xamãs (56-57), Vigias do Covil (55-56) e Ursinos (57-58), todos acima de você. Mate os Xamãs primeiro, eles curam, e atraia pelas bordas. {npc:10738}, na caverna dos fundos, é elite: fique longe.",
	-- ["The next guide starts here and flies to {area:3197}."] = "O próximo guia começa aqui e voa para o {area:3197}.",
	-- ["The ruins lie around the frozen lake south of {area:2253}. Pick up the four relic fragments lying in the ruins and the Moontouched Feathers on the ground where the wildkin roam."] = "As ruínas ficam em volta do lago congelado ao sul de {area:2253}. Pegue os quatro fragmentos de relíquia caídos nas ruínas e as Penas Lunamarca no chão onde os plumacuns vagam.",
	-- ["The three pieces of the doll lie in the ruined houses of {area:2262}; picking one up can call out ghosts. Combine them into the doll."] = "As três partes da boneca estão nas casas em ruínas de {area:2262}; pegar uma pode chamar fantasmas. Junte-as na boneca.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten) and, rarely, a {quest:8471}: right-click whichever drops. Keep the {quest:6031} the furbolgs drop for Meilosh."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Qualquer furbolg daqui pode deixar cair um {item:12771} (cerca de um em dez) e, raramente, um {quest:8471}: clique com o botão direito no que cair. Guarde o {quest:6031} que os furbolgs deixam cair para Meilosh.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Any furbolg here can drop an {item:12771} (about one in ten: it comes within the kills these quests need) and a {quest:8471} (about one in thirty: it comes within the top-ups): right-click whichever drops. Keep the {item:14047} the furbolgs drop for Meilosh.\nThe rest of {zone:1452}'s work is level 55-58: stay on this camp until level 54, so your first kills also count for {npc:9298} and {npc:11556}."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Qualquer furbolg daqui pode soltar {item:12771} (cerca de um em dez: vem dentro das mortes que essas missões exigem) e {quest:8471} (cerca de um em trinta: vem dentro das mortes para completar o nível): clique com o botão direito no que cair. Guarde {item:14047} que os furbolgs soltam para Meilosh.\nO resto do trabalho de {zone:1452} é de nível 55-58: fique neste acampamento até o nível 54, para que suas primeiras mortes também contem para {npc:9298} e {npc:11556}.",
	-- ["The western Winterfall camp sits in the hills between {npc:11556} and {npc:9298}. Top up here first to level 55 on its Pathfinders (53-54) at the camp's edge: the Den Watchers inside are 55-56. Killing them raises your Timbermaw reputation and fills your bags with {item:14047} for Meilosh. Or, with a group, run {area:1584} or {area:2577} instead."] = "O acampamento oeste dos Invernosos fica nas colinas entre {npc:11556} e {npc:9298}. Primeiro, complete aqui até o nível 55 com os Desbravadores (53-54) na borda do acampamento: os Vigias do Covil lá dentro são 55-56. Matá-los aumenta sua reputação com os Presamatos e enche suas bolsas de {item:14047} para Meilosh. Ou, em grupo, faça {area:1584} ou {area:2577}.",
	-- ["The western Winterfall furbolgs drop the beads."] = "Os furbolgs Invernosos do oeste deixam cair as contas.",
	-- ["The {area:2247}"] = "As {area:2247}",
	-- ["To {zone:1455}"] = "Para {zone:1455}",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for."] = "Complete aqui até o nível 55.05 antes das entregas em {area:2255}: elas levam você ao nível 56. Mate os furbolgs Invernosos acampados perto de {area:2246} (Desbravadores, Totêmicos, Vigias do Covil): matá-los aumenta sua reputação com o Domínio dos Presamatos, que as missões daqui e a travessia de {area:1769} exigem, um deles solta {quest:8471} e eles enchem suas bolsas com as trinta Runatramas que Meilosh pede.",
	-- ["Top up here to level 55.05 before the hand-ins at {area:2255}: they take you to level 56. Grind the Winterfall furbolgs camped by {area:2246} (Pathfinders, Totemics, Den Watchers): killing them raises your Timbermaw reputation, which the quests here and the walk through {area:1769} need, one of them drops the {quest:8471}, and they fill your bags with the thirty Runecloth Meilosh asks for. Or, with a group, run {area:1584} or {area:2577} instead."] = "Complete aqui até o nível 55.05 antes das entregas em {area:2255}: elas levam você ao nível 56. Mate os furbolgs Invernosos acampados perto de {area:2246} (Desbravadores, Totêmicos, Vigias do Covil): matá-los aumenta sua reputação com o Domínio dos Presamatos, que as missões daqui e a travessia de {area:1769} exigem, um deles solta {quest:8471} e eles enchem suas bolsas com as trinta Runatramas que Meilosh pede. Ou, em grupo, faça {area:1584} ou {area:2577}.",
	-- ["Walk through {area:1769} to {zone:1448} and fly on to the Eastern Kingdoms ({area:442}, the boat to {area:150}). Fly to {area:271} and ride north up the road through Alterac to {area:3197}."] = "Atravesse {area:1769} até {zone:1448} e voe para os Reinos do Leste ({area:442}, o navio para {area:150}). Voe até {area:271} e cavalgue para o norte pela estrada através de Alterac até o {area:3197}.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there at 47, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Sua Pedra de Regresso não está vinculada a {zone:1455} (o guia de {zone:1425} vincula você lá no nível 47, e este guia sai de {zone:1452} por ela): vincule-a a {area:2255}, para as viagens de volta à cidade.",
	-- ["Your Hearthstone is not set at {zone:1455} (the {zone:1425} guide binds there, and this guide leaves {zone:1452} through it): bind at {area:2255} instead, for the trips back to town."] = "Sua Pedra de Regresso não está vinculada a {zone:1455} (o guia de {zone:1425} vincula você lá, e este guia sai de {zone:1452} por ela): vincule-a a {area:2255}, para as viagens de volta à cidade.",
	-- ["Your Hearthstone is still set at {zone:1455}: from there the gryphon to {area:3197} is about ten minutes quicker than {area:2255}'s flight to Theramore and the boat."] = "Sua Pedra de Regresso ainda está vinculada a {zone:1455}: de lá, o grifo para o {area:3197} é cerca de dez minutos mais rápido que o voo de {area:2255} para a Ilha Theramore e o navio.",
	-- ["Zaeldarr is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "Zaeldarr é elite: melhor ir em grupo. Ele espera no fundo de {area:2261}, a cripta no sudoeste da zona.",
	-- ["grind on {npc:7442}"] = "mate {npc:7442} até subir",
	-- ["grind on {npc:7460} at the {area:2247}, {zone:1452}"] = "farme {npc:7460} nas {area:2247}, {zone:1452}",
	-- ["{area:150} flight master"] = "Mestre de voo de {area:150}",
	-- ["{area:199} cauldron"] = "Caldeirão de {area:199}",
	-- ["{area:2247}: kill these as you meet them"] = "{area:2247}: vá matando estes pelo caminho",
	-- ["{area:2255} flight master"] = "Mestre de voo de {area:2255}",
	-- ["{area:2255}'s inn"] = "Estalagem de {area:2255}",
	-- ["{area:2269}: kill these as you meet them"] = "{area:2269}: vá matando estes pelo caminho",
	-- ["{area:489} flight master"] = "Mestre de voo de {area:489}",
	-- ["{item:12383}, 110 yd north"] = "{item:12383}, 110 metros ao norte",
	-- ["{item:12771}, a rare drop"] = "{item:12771}, item raro",
	-- ["{item:12886}; inside"] = "{item:12886}; lá dentro",
	-- ["{item:12888}; inside"] = "{item:12888}; lá dentro",
	-- ["{item:15785}; below ground"] = "{item:15785}; no subterrâneo",
	-- ["{npc:10301}'s supplies"] = "Suprimentos de {npc:10301}",
	-- ["{npc:10431}: keep both for the Plaguelands"] = "{npc:10431}: guarde os dois para as Terras Pestilentas",
	-- ["{npc:10431}: keep both for the Plaguelands; inside"] = "{npc:10431}: guarde as duas para as Terras Pestilentas; lá dentro",
	-- ["{npc:10431}: keep it for the Plaguelands; inside"] = "{npc:10431}: guarde para as Terras Pestilentas; lá dentro",
	-- ["{npc:10739} stands by the farm at the {area:202}, on the road east to the {zone:1423}."] = "{npc:10739} fica junto à fazenda em {area:202}, na estrada para leste até {zone:1423}.",
	-- ["{npc:10838}: the watchtowers are in Andorhal, keep it"] = "{npc:10838}: as torres de vigia ficam em Andorhal, guarde",
	-- ["{npc:10926}'s doll"] = "A boneca de {npc:10926}",
	-- ["{npc:10927}: keep it for {area:2262}"] = "{npc:10927}: guarde-o para {area:2262}",
	-- ["{npc:10978}: {npc:7583} and {npc:10977} come later"] = "{npc:10978}: {npc:7583} e {npc:10977} vêm depois",
	-- ["{npc:11038}: Zaeldarr is a level 54 elite"] = "{npc:11038}: Zaeldarr é elite de nível 54",
	-- ["{npc:11038}: {npc:12250} is a level 54 elite"] = "{npc:11038}: {npc:12250} é elite de nível 54",
	-- ["{npc:11053}: the cauldron is at {area:200}, keep it"] = "{npc:11053}: o caldeirão fica em {area:200}, guarde-o",
	-- ["{npc:11063}'s next task, at {area:2264}, is among Scourge of 57-60: skip it."] = "A próxima tarefa de {npc:11063}, em {area:2264}, é entre Flagelo de nível 57-60: pule-a.",
	-- ["{npc:11118}: the last guide binds here, so this usually ticks at once"] = "{npc:11118}: o guia anterior vincula você aqui, então isto costuma ser marcado na hora",
	-- ["{npc:11556} guards the mouth of {area:1769}, north-west of {npc:9298}."] = "{npc:11556} guarda a entrada de {area:1769}, a noroeste de {npc:9298}.",
	-- ["{npc:11556} stands right at the {zone:1452} exit of {area:1769}'s tunnel, where you come out."] = "{npc:11556} fica bem na saída de {zone:1452} do túnel de {area:1769}, por onde você sai.",
	-- ["{npc:11616}: the termites come later, in {area:2627}"] = "{npc:11616}: os cupins vêm depois, em {area:2627}",
	-- ["{npc:11629}: keep it for {area:2262}"] = "{npc:11629}: guarde-o para {area:2262}",
	-- ["{npc:11629}: keep it for {area:2262}; inside"] = "{npc:11629}: guarde para {area:2262}; lá dentro",
	-- ["{npc:11754} walks around {area:2255}: look inside the circle on the map"] = "{npc:11754} anda por {area:2255}: procure dentro do círculo no mapa",
	-- ["{npc:12250} is elite: grouping up is advised. He waits at the bottom of the {area:2261}, the crypt in the south-west of the zone."] = "{npc:12250} é elite: é recomendado formar grupo. Ele espera no fundo da {area:2261}, a cripta no sudoeste da zona.",
	-- ["{npc:9616} works in the {object:32356}: hand him {zone:1448}'s ooze jars now, on your way through."] = "{npc:9616} trabalha no {object:32356}: entregue a ele os jarros de gosma de {zone:1448} agora, de passagem.",
	-- ["{object:175894}, inside"] = "{object:175894}, lá dentro",
	-- ["{quest:5152}, in the {area:28}: keep it"] = "{quest:5152}, nas {area:28}: guarde-a",
	-- ["{quest:5152}, in the {zone:1422}: keep it"] = "{quest:5152}, nas {zone:1422}: guarde-a",
	-- ["{quest:6031}, for Meilosh later"] = "{quest:6031}, para Meilosh mais tarde",
	-- ["{quest:8471}, a rare drop"] = "{quest:8471}, item raro",
	-- ["{zone:1455} flight master"] = "Mestre de voo de {zone:1455}",
	-- ["{zone:1455} inn"] = "Estalagem de {zone:1455}",
}
