-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/06-badlands (forever/alliance/30-40/06-badlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "Rumo a {zone:1418}",

	-- Step 3: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2910} Prospector Ryedol · {npc:2860} Sigrun Ironhew
	["Head back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Volte para oeste até a estrada e siga por ela para o sul, saindo de {zone:1432} pela passagem até {zone:1418}. {npc:2910} e {npc:2860} acampam lado a lado na escavação.",

	-- Step 4: Hammertoe's Digsite: kill these as you meet them
	-- {area:346} Hammertoe's Digsite
	["{area:346}: kill these as you meet them"] = "{area:346}: vá matando estes pelo caminho",
	-- plural, as words: Crag Coyotes = {npc:2727} Crag Coyote
	["The Shadowforge dwarves camp just north of the digsite; the crumpled map lies among their tents. Tunnelers and Darkweavers carry Ryedol's pick. Crag Coyotes roam the slopes around it."] = "Os anões de Umbraforja acampam logo ao norte da escavação; o Mapa Amassado está entre as barracas. Escavadores e Tecetrevas carregam a picareta de Ryedol. Coiotes do Rochedo vagam pelas encostas ao redor.",

	-- Step 5: The excavation crate
	["The excavation crate"] = "O caixote da escavação",
	["Head north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Siga para nordeste até a escavação abandonada; o caixote de suprimentos está lá, no meio dos ogros Arrota-pó.",

	-- Step 6: Hammertoe's Digsite
	-- {area:1517} Uldaman
	["Ryedol's next errand goes into {area:1517}: skip it."] = "A próxima tarefa de Ryedol é em {area:1517}: pule.",

	-- Step 7: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {zone:1418} Badlands
	["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {zone:1418}."] = "{npc:4618} e {npc:2817} acampam juntos em {area:1877}, no meio de {zone:1418}.",
	["The clams lie on Stranglethorn's north-west coast, in the next guide: keep it"] = "Os mariscos ficam no litoral noroeste da Selva do Espinhaço, no próximo guia: guarde-a",

	-- Step 8: Agmond's End
	["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "O esqueleto danificado fica logo a leste dos ogros, na beira do acampamento dos troggs da Abóbada de Pedra; os Quebraossos e Xamãs ao redor soltam as lascas. Theldurin está sentado junto ao acampamento em ruínas, mais ao sul.",

	-- Step 9: Agmond's End: kill these as you meet them
	-- {area:345} Agmond's End
	["{area:345}: kill these as you meet them"] = "{area:345}: vá matando estes pelo caminho",
	-- {quest:739} Murdaloc · {spell:5242} Battle Shout · {spell:1160} Demoralizing Shout · {area:340} Kargath
	-- plural, as words: Dustbelcher Lords = {npc:2719} Dustbelcher Lord
	["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east.\nThe battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers.\nCareful: Dustbelcher Lords are level 44-45. They use {spell:5242} and {spell:1160}, and below 50% health they call for help from allies within 15 yd. Seven of them stand about 750 yd south of {area:340}."] = "Os ogros Arrota-pó acampam logo ao sul do vale; qualquer um deles solta sucata. Urubus voam em círculos pela planície a leste.\nO esqueleto surrado fica na beira do acampamento de troggs da Abóbada de Pedra; {quest:739}, o assassino de Agmond, anda entre os Quebraossos.\nCuidado: os Grandes Arrota-pó são de nível 44-45. Eles usam {spell:5242} e {spell:1160}, e abaixo de 50% de vida chamam aliados a até 15 metros. Sete deles ficam a cerca de 750 metros ao sul de {area:340}.",
	-- {quest:739} Murdaloc · {zone:1418} Badlands
	["{quest:739} himself (42) walks among the Bonesnappers: leave him for the later {zone:1418} guide at 43, and kill the Bonesnappers for this quest now."] = "O próprio {quest:739} (42) anda entre os Quebraossos: deixe-o para o guia posterior de {zone:1418} no nível 43, e mate agora os Quebraossos para esta missão.",

	-- Step 10: Lotwil Veriatus
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus
	["Head west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Siga para oeste até {area:1878}; {npc:2921} trabalha junto às máquinas dele, bem no meio.",

	-- Step 11: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementais Inferiores da Rocha",
	-- {area:1878} Dustbowl · {npc:2921} Lotwil Veriatus · {npc:1470} Ghak Healtouch
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}; every rock elemental can drop {npc:1470}'s Rock Elemental Shards."] = "Os Elementais Inferiores da Rocha vagam por {area:1878}, a oeste de {npc:2921}; todo elemental da rocha pode soltar os Estilhaços de Elemental da Rocha de {npc:1470}.",

	-- Step 13: The Ancient Chest
	-- {object:126260} Ancient Chest
	["The {object:126260}"] = "{object:126260}",
	-- {zone:1418} Badlands · {npc:2745} Ambassador Infernus
	["Head north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Siga para nordeste até as ruínas anãs no norte de {zone:1418}; o baú fica no meio dos anões de Umbraforja. {npc:2745}, ali perto, é elite: dê distância.",
	-- {item:4631} Tablet of Ryun'eh
	["{item:4631}; below ground"] = "{item:4631}; no subterrâneo",

	-- Step 14: Valley of Fangs
	-- {npc:4618} Martek the Exiled · {npc:2817} Rigglefuzz · {area:1877} Valley of Fangs · {area:345} Agmond's End
	["Head south down the road: {npc:4618} and {npc:2817} camp in the {area:1877}, on the way to {area:345}."] = "Siga para o sul pela estrada: {npc:4618} e {npc:2817} acampam em {area:1877}, no caminho para {area:345}.",
	-- {npc:4454} Fizzle Brassbolts · {area:2240} Mirage Raceway · {zone:1446} Tanaris
	["For {npc:4454} at the {area:2240}: the {zone:1446} guide passes him at 45, keep it"] = "Para {npc:4454} em {area:2240}: o guia de {zone:1446} passa por ele no nível 45, guarde-o",

	-- Step 15: Theldurin the Lost
	-- {area:345} Agmond's End
	["Head south to {area:345}."] = "Siga para o sul até {area:345}.",
	-- {npc:2786} Gerrig Bonegrip · {zone:1455} Ironforge
	["for {npc:2786} in {zone:1455}: keep it"] = "para {npc:2786} em {zone:1455}: guarde-a",

	-- Step 16: Rock Elementals
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental
	["Rock Elementals"] = "Elementais da Rocha",
	-- {npc:2921} Lotwil Veriatus
	-- plural, as words: Rock Elementals = {npc:92} Rock Elemental · Giant Buzzards = {npc:2831} Giant Buzzard · Elder Crag Coyotes = {npc:2729} Elder Crag Coyote
	["The Rock Elementals roam south-east of {npc:2921}; Giant Buzzards and Elder Crag Coyotes share the plain to their west."] = "Os Elementais da Rocha vagam a sudeste de {npc:2921}; Urubus Gigantes e Coiotes Anciões do Rochedo dividem a planície a oeste deles.",

	-- Step 17: Lotwil Veriatus
	-- {npc:2921} Lotwil Veriatus · {item:4628} Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["{npc:2921}'s last test is optional: five {item:4628}, which only the Greater Rock Elementals (42-44) in the south-western gulches drop, about one kill in five, well above your level. Take it only if you can handle them one at a time; otherwise hand in the slabs and move on."] = "O último teste de {npc:2921} é opcional: cinco {item:4628}, que só os Elementais Maiores da Rocha (42-44) das ravinas do sudoeste soltam, mais ou menos uma morte em cinco, bem acima do seu nível. Só faça se der conta deles um de cada vez; senão, entregue as lajes e siga em frente.",

	-- Step 18: Bracers of Rock Binding
	-- plural, as words: Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["South-west into the gulches: only the Greater Rock Elementals there drop the bracers."] = "Ao sudoeste, nas ravinas: só os Elementais Maiores da Rocha de lá soltam os braceletes.",

	-- Step 20: Lucien Tosselwrench
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus · {item:2868} Patterned Bronze Bracers
	["{npc:2920}, beside {npc:2921}, trades for {item:2868}, a blacksmith's craft: this step shows only when you carry a pair."] = "{npc:2920}, ao lado de {npc:2921}, troca por {item:2868}, uma criação de ferreiro: este passo só aparece quando você leva um par.",
	-- {npc:2920} Lucien Tosselwrench · {npc:2921} Lotwil Veriatus
	["{npc:2920}, beside {npc:2921}"] = "{npc:2920}, ao lado de {npc:2921}",

	-- Step 21: To Stoutlager Inn
	-- {area:2101} Stoutlager Inn
	["To {area:2101}"] = "Para {area:2101}",

	-- Step 22: Thelsamar
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, in the inn; below ground"] = "{npc:1470}, na estalagem; no subterrâneo",

	-- Step 23: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Mestre de voo de {area:144}",

	-- Step 25: Theramore flight master
	["Theramore flight master"] = "Mestre de voo de Theramore",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "Ao descer do barco, suba o cais até Baldruc, o mestre de voo junto ao portão de {area:514}.",

	-- Step 26: Nijel's Point
	-- {npc:5638} Kreldig Ungor
	["{npc:5638}: the wreck is on the north-west coast, at the end of the loop"] = "{npc:5638}: o naufrágio fica na costa noroeste, no fim do circuito",

	-- Step 27: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Siga a estrada para o sul até {area:2407}.",

	-- Step 28: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones · {npc:217590} Flesh Picker
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons. A {npc:217590} crawls about the graveyard: catch one with the Entomology Starter Kit, then tick it off."] = "{npc:6019} fica na beira de {area:596}, a sudoeste de {area:2407}; {object:176751} estão entre os esqueletos. Um {npc:217590} rasteja pelo cemitério: capture um com o Entomology Starter Kit e depois marque o objetivo.",
	-- {npc:217590} Flesh Picker
	["{npc:217590}: catch it, for My Little Friends"] = "{npc:217590}: capture-o, para My Little Friends",

	-- Step 29: Maraudine centaurs
	["Maraudine centaurs"] = "Centauros Maraudinos",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Os centauros Maraudinos ocupam {area:607}, a oeste do cemitério; todos os tipos soltam os totens.",

	-- Step 30: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} está presa no acampamento dos centauros a oeste do cemitério. Liberte-a e mantenha-a viva na saída; ela para junto ao cemitério.\nCuidado: os grupos da escolta vêm juntos e só aparecem durante ela, então não dá para limpar antes nem puxar um de cada vez. Limpar os centauros comuns do caminho antes de começar ajuda.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escolte {npc:12277} de volta ao cemitério",

	-- Step 31: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Os demônios se juntam em {area:602}, no sul de {zone:1443}: canisvis (Manávoros, Caça-magos e Caçadores do Meridiano), Donzelas e Irmãs do Éter, e Capitães dos Guardiões da Ruína em volta do fosso.\nCuidado: a maioria dos monstros daqui faz patrulha, então é fácil puxar monstro a mais.",

	-- Step 32: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven; at the far south-east, use the {item:15848} to draw the Magrami Spectres."] = "Assoladores Mortos-vivos vagam pelos campos de ossos ao sul da Aldeia Magram, a leste das Ruínas de Mannoroc; no extremo sudeste, use o {item:15848} para atrair os Espectros Magrami.",

	-- Step 35: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Siga a estrada para o oeste pelo norte de {zone:1443} até as ruínas de {area:2405}. A torre de {npc:11863} fica no morro dali, a caminho do naufrágio.",

	-- Step 36: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies on the shore just west of {npc:11863}'s tower."] = "O baú do navio naufragado está na praia, logo a oeste da torre de {npc:11863}.",

	-- Step 37: Claim Rackmore's Treasure!
	["Underwater"] = "Debaixo d'água",

	-- Step 38: Nijel's Point
	-- {area:608} Nijel's Point
	["Follow the road north to {area:608}."] = "Siga a estrada para o norte até {area:608}.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} em {zone:1455}: guarde-a",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} em {area:271}: guarde-a",

	-- Step 39: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}: vá matando estes pelo caminho",
	-- {npc:12369} Lord Kragaru · {npc:11863} Azore Aldamort
	["{npc:12369}, a centaur chieftain, camps on the north-west coast, north of {npc:11863}'s tower."] = "{npc:12369}, um chefe centauro, acampa no litoral noroeste, ao norte da torre de {npc:11863}.",

	-- Step 44: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	["The next guide starts in Theramore."] = "O próximo guia começa na Ilha Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}; the wrecked ship's chest lies on the shore just west of them."] = "Siga a estrada para o oeste pelo norte de {zone:1443} até as ruínas de {area:2405}; o baú do navio naufragado está na praia logo a oeste delas.",
	-- ["Greater Rock Elementals"] = "Elementais Maiores da Rocha",
	-- ["Lesser Rock Elementals"] = "Elementais Inferiores da Rocha",
	-- ["Ogres and buzzards"] = "Ogros e urubus",
	-- ["Ride back west to the road and follow it south out of {zone:1432} through the pass into the {zone:1418}. {npc:2910} and {npc:2860} camp side by side at the dig."] = "Volte a oeste até a estrada e siga por ela para o sul, saindo de {zone:1432} pelo desfiladeiro até {zone:1418}. {npc:2910} e {npc:2860} acampam lado a lado na escavação.",
	-- ["Ride north-east to the abandoned dig; the supply crate lies there among the Dustbelcher ogres."] = "Cavalgue para o nordeste até a escavação abandonada; o caixote de suprimentos está lá, entre os ogros Arrota-pó.",
	-- ["Ride north-east to the dwarven ruins in the north of the {zone:1418}; the chest sits among the Shadowforge dwarves. {npc:2745} nearby is elite: give him room."] = "Cavalgue para o nordeste até as ruínas anãs no norte de {zone:1418}; o baú fica entre os anões de Umbraforja. {npc:2745}, ali perto, é elite: mantenha distância.",
	-- ["Ride south to {area:345}."] = "Cavalgue para o sul até {area:345}.",
	-- ["Ride west into the {area:1878}; {npc:2921} works by his machines in the middle of it."] = "Cavalgue para o oeste até {area:1878}; {npc:2921} trabalha junto às máquinas dele, no meio da área.",
	-- ["Shadowforge camp"] = "Acampamento de Umbraforja",
	-- ["Take the boat to Theramore from the far pier."] = "Pegue o barco para a Ilha Theramore no píer mais distante.",
	-- ["The Dustbelcher ogres camp just south of the valley; any of them drops scrap. Buzzards circle the plain to the east."] = "Os ogros Arrota-pó acampam logo ao sul do vale; qualquer um deles solta sucata. Urubus sobrevoam a planície a leste.",
	-- ["The Greater Rock Elementals (level 42) walk the far south-west corner below {area:342}; pull them one at a time. The Dustbelcher Wyrmhunters and Maulers at {area:342} also drop scrap."] = "Os Elementais Maiores da Rocha (nível 42) andam no extremo sudoeste, abaixo de {area:342}; puxe um de cada vez. Os Caçadores de Serpes e Espancadores Arrota-pó em {area:342} também soltam sucata.",
	-- ["The Lesser Rock Elementals wander the {area:1878} west of {npc:2921}."] = "Os Elementais Inferiores da Rocha vagam por {area:1878}, a oeste de {npc:2921}.",
	-- ["The battered skeleton lies just east of the ogres, at the edge of the Stonevault trogg camp; the Bonesnappers and Shamans around it drop the flakes. Theldurin sits by the ruined camp further south."] = "O esqueleto danificado fica logo a leste dos ogros, na beira do acampamento dos troggs da Abóbada de Pedra; os Quebraossos e Xamãs ao redor soltam as lascas. Theldurin está sentado junto ao acampamento em ruínas, mais ao sul.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit."] = "Os demônios se reúnem em {area:602}, no sul de {zone:1443}: canisvis (Manávoros, Caça-magos e Caçadores do Meridiano), Donzelas e Irmãs do Éter e Capitães dos Guardiões da Ruína ao redor do fosso.",
	-- ["The flight master stands by the gate of {area:514}; {npc:5083} and {npc:4964} are inside the citadel."] = "O mestre de voo fica junto ao portão de {area:514}; {npc:5083} e {npc:4964} estão dentro da cidadela.",
	-- ["The next guide starts in Theramore."] = "O próximo guia começa na Ilha Theramore.",
	-- ["The skeleton's next task, Murdaloc, waits until the later {zone:1418} guide at 43."] = "A próxima tarefa do esqueleto, Murdaloc, fica para o guia posterior de {zone:1418}, no nível 43.",
	-- ["Theramore"] = "Ilha Theramore",
	-- ["for the Dustwallow loop in the next guide"] = "para o circuito do Pântano Vadeoso no próximo guia",
	-- ["for {npc:4454} in the {area:439}: the {zone:1446} guide crosses them at 45, keep it"] = "para {npc:4454} em {area:439}: o guia de {zone:1446} passa por lá no nível 45; guarde-a",
	-- ["only if you carry {item:2868} (a blacksmith's craft)"] = "só se você tiver {item:2868} (feitas por ferreiros)",
	-- ["{npc:11626}'s caravan stops on the road east of {area:606}. Take the quest and walk with the kodos past the {area:602}, killing the demons that jump them; talk to {npc:11596} at his camp east of the {area:596} afterwards."] = "A caravana de {npc:11626} para na estrada a leste de {area:606}. Pegue a missão e acompanhe os kodos, passando por {area:602} e matando os demônios que os atacam; depois fale com {npc:11596} no acampamento dele, a leste de {area:596}.",
	-- ["{npc:11863}'s tower stands on the hill east of the wreck."] = "A torre de {npc:11863} fica no morro a leste do naufrágio.",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard."] = "{npc:12277} está presa no acampamento centauro a oeste do cemitério. Liberte-a e mantenha-a viva na saída; ela para perto do cemitério.",
	-- ["{npc:1470}, in the inn"] = "{npc:1470}, na estalagem",
	-- ["{npc:2920}, beside {npc:2921}, wants {item:2868}, a blacksmith's craft: skip him unless you carry a pair."] = "{npc:2920}, ao lado de {npc:2921}, quer {item:2868}, um item de ferreiro: pule-o a menos que você tenha um par.",
	-- ["{npc:2921}'s next test needs crafted gear: skip it."] = "O próximo teste de {npc:2921} exige equipamento fabricado: pule.",
	-- ["{npc:4618} and {npc:2817} camp together in the {area:1877}, in the middle of the {area:3}."] = "{npc:4618} e {npc:2817} acampam juntos em {area:1877}, no meio de {area:3}.",
	-- ["{npc:5638}'s next task, {item:6245}, is a drop on the far coast: skip it."] = "A próxima tarefa de {npc:5638}, {item:6245}, é um saque no litoral distante: pule.",
}
