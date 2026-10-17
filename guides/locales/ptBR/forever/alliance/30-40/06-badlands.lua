-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Volte a oeste até a estrada e siga por ela para o sul, saindo de {zone:1432} pelo desfiladeiro até {zone:1418}. {npc:2910} e {npc:2860} acampam lado a lado na escavação.",

	-- Step 2: Shadowforge camp
	["Shadowforge camp"] = "Acampamento de Umbraforja",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Os anões de Umbraforja acampam logo ao norte da escavação; o Mapa Amassado está entre as barracas. Escavadores e Tecetrevas carregam a picareta de Ryedol. Coiotes do Rochedo vagam pelas encostas ao redor.",

	-- Step 3: The excavation crate
	["The excavation crate"] = "O caixote da escavação",
	["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Cavalgue para o nordeste até a escavação abandonada; o caixote de suprimentos está lá, entre os ogros Arrota-pó.",

	-- Step 4: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "A próxima tarefa de Ryedol é em {area:1517}: pule.",

	-- Step 5: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} e {npc:2817} acampam juntos em {area:1877}, no meio de {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Os mariscos ficam no litoral noroeste da Selva do Espinhaço, no próximo guia: guarde-a",

	-- Step 6: Ogres and buzzards
	["Ogres and buzzards"] = "Ogros e urubus",
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Os ogros Arrota-pó acampam logo ao sul do vale; qualquer um deles solta sucata. Urubus sobrevoam a planície a leste.",

	-- Step 7: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "O esqueleto danificado fica logo a leste dos ogros, na beira do acampamento dos troggs da Abóbada de Pedra; os Quebraossos e Xamãs ao redor soltam as lascas. Theldurin está sentado junto ao acampamento em ruínas, mais ao sul.",
	-- {zone:1418} Badlands
	["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "A próxima tarefa do esqueleto, Murdaloc, fica para o guia posterior de {zone:1418}, no nível 43.",

	-- Step 8: Valley of Fangs
	-- {npc:4454} Fizzle Brassbolts · {area:439} Shimmering Flats · {zone:1446} Tanaris
	["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "para {npc:4454} em {area:439}: o guia de {zone:1446} passa por lá no nível 45; guarde-a",

	-- Step 9: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Cavalgue para o oeste até {area:1878}; {npc:2921} trabalha junto às máquinas dele, no meio da área.",

	-- Step 10: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementais Inferiores da Rocha",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Os Elementais Inferiores da Rocha vagam por {area:1878}, a oeste de {npc:2921}.",

	-- Step 12: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementais da Rocha",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Os Elementais da Rocha vagam a sudeste de {npc:2921}; Urubus Gigantes e Coiotes Anciões do Rochedo dividem a planície a oeste deles.",

	-- Step 14: Greater Rock Elementals
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Greater Rock Elementals"] = "Elementais Maiores da Rocha",
	-- {area:342} Camp Boff
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental · Dustbelcher Wyrmhunters = {npc:2716} Dustbelcher Wyrmhunter
	["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Os Elementais Maiores da Rocha (nível 42) andam no extremo sudoeste, abaixo de {area:342}; puxe um de cada vez. Os Caçadores de Serpes e Espancadores Arrota-pó em {area:342} também soltam sucata.",

	-- Step 15: Lotwil Veriatus
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, ao lado de {npc:2921}",
	-- {item:2868} Patterned Bronze Bracers
	["only if you carry {item:2868} (a blacksmith's craft)"] = "só se você tiver {item:2868} (feitas por ferreiros)",
	-- {npc:2921} Lotwil Veriatus
	["{npc:2921}'s next test needs crafted gear: skip it."] = "O próximo teste de {npc:2921} exige equipamento fabricado: pule.",

	-- Step 16: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Cavalgue para o nordeste até as ruínas anãs no norte de {zone:1418}; o baú fica entre os anões de Umbraforja. {npc:2745}, ali perto, é elite: mantenha distância.",

	-- Step 18: Theldurin the Lost
	-- {area:345} Agmond's End
	["Ride south to {area:345}."] = "Cavalgue para o sul até {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "para {npc:2786} em {zone:1455}: guarde-a",

	-- Step 19: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn"] = "{npc:1470}, na estalagem",

	-- Step 20: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Pegue o barco para a Ilha Theramore no píer mais distante.",

	-- Step 21: Theramore
	["Theramore"] = "Ilha Theramore",
	-- {area:514} Foothold Citadel · {npc:5083} Clerk Lendry · {npc:4964} Commander Samaul
	["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "O mestre de voo fica junto ao portão de {area:514}; {npc:5083} e {npc:4964} estão dentro da cidadela.",
	["for the Dustwallow loop in the next guide"] = "para o circuito do Pântano Vadeoso no próximo guia",

	-- Step 23: Karnitol's Chest
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Siga a estrada para o oeste pelo norte de {zone:1443} até as ruínas de {area:2405}; o baú do navio naufragado está na praia logo a oeste delas.",

	-- Step 24: Azore Aldamort
	-- {npc:11863} Azore Aldamort
	["{npc:11863}'s tower stands on the hill east of the wreck."] = "A torre de {npc:11863} fica no morro a leste do naufrágio.",

	-- Step 25: Lord Kragaru
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, um chefe centauro, acampa no litoral noroeste, ao norte da torre de {npc:11863}.",

	-- Step 27: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {item:6245} Karnitol's Satchel
	["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "A próxima tarefa de {npc:5638}, {item:6245}, é um saque no litoral distante: pule.",

	-- Step 28: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Siga a estrada para o sul até {area:2407}.",

	-- Step 29: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} fica na beira de {area:596}, a sudoeste de {area:2407}; {object:176751} estão entre os esqueletos. Um {npc:217590} rasteja pelo cemitério: capture um com o Entomology Starter Kit e depois marque o objetivo.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: capture-o, para My Little Friends",

	-- Step 30: Maraudine centaurs
	["Maraudine centaurs"] = "Centauros Maraudinos",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Os centauros Maraudinos ocupam {area:607}, a oeste do cemitério; todos os tipos soltam os totens.",

	-- Step 31: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} está presa no acampamento centauro a oeste do cemitério. Liberte-a e mantenha-a viva na saída; ela para perto do cemitério.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escolte {npc:12277} de volta ao cemitério",

	-- Step 33: Gizelton Caravan
	-- {npc:11626} Rigger Gizelton · {area:606} Gelkis Village · {area:602} Mannoroc Coven · {npc:11596} Smeed Scrabblescrew · {area:596} Kodo Graveyard
	["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "A caravana de {npc:11626} para na estrada a leste de {area:606}. Pegue a missão e acompanhe os kodos, passando por {area:602} e matando os demônios que os atacam; depois fale com {npc:11596} no acampamento dele, a leste de {area:596}.",

	-- Step 34: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Os demônios se reúnem em {area:602}, no sul de {zone:1443}: canisvis (Manávoros, Caça-magos e Caçadores do Meridiano), Donzelas e Irmãs do Éter e Capitães dos Guardiões da Ruína ao redor do fosso.",

	-- Step 35: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Assoladores Mortos-vivos vagam pelos campos de ossos ao sul da Aldeia Magram, a leste das Ruínas de Mannoroc; no extremo sudeste, use o {item:15848} para atrair os Espectros Magrami.",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Siga a estrada para o norte até {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} em {zone:1455}: guarde-a",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} em {area:271}: guarde-a",

	-- Step 39: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	["The next guide starts in Theramore."] = "O próximo guia começa na Ilha Theramore.",
}
