-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/03-feralas (forever/alliance/40-50/03-feralas.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Into The Barrens
	-- {zone:1413} The Barrens
	["Into {zone:1413}"] = "Rumo a {zone:1413}",

	-- Step 2: Thalanaar flight master
	-- {area:489} Thalanaar
	["{area:489} flight master"] = "Mestre de voo de {area:489}",

	-- Step 3: Boat to Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold
	["Boat to {area:1116}"] = "Barco para {area:1116}",

	-- Step 4: Feathermoon Stronghold
	-- {area:1116} Feathermoon Stronghold · {area:1120} Sardor Isle · {area:1108} Forgotten Coast · {npc:7880} Ginro Hearthkindle
	["{area:1116} stands on {area:1120}, off the {area:1108}: the boat from the coast's dock crosses to it. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{area:1116} fica em {area:1120}, ao largo de {area:1108}: o barco do cais da costa faz a travessia. {npc:7880} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- {npc:3936} Shandris Feathermoon
	["{npc:3936}, beside him"] = "{npc:3936}, ao lado dele",
	-- {npc:7877} Latronicus Moonspear
	["{npc:7877}, at the top of the stronghold"] = "{npc:7877}, no alto do bastião",
	-- {npc:7764} Troyas Moonbreeze · {area:702} Rut'theran Village
	["{npc:7764}: his answer waits in {area:702}, later"] = "{npc:7764}: a resposta dele espera em {area:702}, mais tarde",

	-- Step 5: Ruins of Solarsal
	["Walk south along the island to the naga ruins; the gazebo stands among them."] = "Caminhe para o sul pela ilha até as ruínas dos nagas; o mirante fica entre elas.",

	-- Step 7: Hatecrest naga
	["Hatecrest naga"] = "Nagas Cristafúria",
	-- {area:1117} Ruins of Solarsal
	["Back to the {area:1117}. Every Hatecrest naga there can drop scales."] = "Volte a {area:1117}. Todo naga Cristafúria de lá pode deixar cair escamas.",

	-- Step 8: Feathermoon Stronghold
	-- {npc:8136} Lord Shalzaru
	["{npc:8136} waits for the end of the mainland loop."] = "{npc:8136} fica para o fim do circuito no continente.",

	-- Step 9: Boat to Forgotten Coast
	-- {area:1108} Forgotten Coast
	["Boat to {area:1108}"] = "Barco para {area:1108}",

	-- Step 10: Feralas
	["The courier's boat"] = "O barco do mensageiro",

	-- Step 11: The courier's boat
	-- {area:1108} Forgotten Coast
	["Take the boat to the {area:1108} and follow the shore south to the wrecked row boat on the beach."] = "Pegue o barco para {area:1108} e siga a costa para o sul até a Canoa Destruída na praia.",

	-- Step 12: Gordunni ogres
	["Gordunni ogres"] = "Ogros Gordunni",
	["Ride east to the Gordunni camp in the hills south-east of the yeti valley: Warlocks and Shaman hold the camp, Brutes wander the slopes around it and further north."] = "Cavalgue para leste até o acampamento Gordunni nas colinas a sudeste do vale dos yetis: Bruxos Gordunni e Xamãs Gordunni ocupam o acampamento, Brutamontes Gordunni vagam pelas encostas ao redor e mais ao norte.",

	-- Step 13: Feral Scar Vale
	-- {npc:5346} Bloodroar the Stalker
	["Ride north into the yeti valley. Every Feral Scar yeti can drop a thick hide; {npc:5346} (level 48) prowls the middle."] = "Cavalgue para o norte até o vale dos yetis. Todo Yeti Abominável pode deixar cair um couro grosso; {npc:5346} (nível 48) ronda o meio.",

	-- Step 14: Isle of Dread
	-- {area:1121} Isle of Dread · {area:1120} Sardor Isle · {npc:8136} Lord Shalzaru
	-- plural, as words: Hatecrest Serpent Guards = {npc:5333} Hatecrest Serpent Guard
	["The {area:1121} is the island just south of {area:1120}: swim over. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "{area:1121} é a ilha logo ao sul de {area:1120}: vá nadando. Serpentes Guarda e Feiticeiras Cristafúria ocupam a ilha; {npc:8136} (nível 47) espera na caverna da ponta sul. Puxe os guardas dele primeiro.",
	-- {item:9248} Mysterious Relic
	["{item:9248}; below ground"] = "{item:9248}; no subterrâneo",

	-- Step 15: Feathermoon Stronghold
	-- {npc:7877} Latronicus Moonspear · {npc:7878} Vestia Moonspear · {npc:7900} Angelas Moonbreeze · {npc:7880} Ginro Hearthkindle · {npc:7852} Pratt McGrubben
	["Coming from the south: {npc:7877} and {npc:7878} first, then {npc:7900} beside {npc:7880}'s building, then the stairs. {npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart. {npc:7852} is by the flight master, on the way out."] = "Vindo do sul: primeiro {npc:7877} e {npc:7878}, depois {npc:7900}, ao lado do prédio de {npc:7880}, e então a escada. {npc:7880} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares. {npc:7852} fica junto ao mestre de voo, na saída.",
	-- {npc:7879} Quintis Jonespyre
	["{npc:7879}, upstairs"] = "{npc:7879}, no andar de cima",

	-- Step 16: Fly to Thalanaar
	-- {area:489} Thalanaar
	["Fly to {area:489}"] = "Voe para {area:489}",
	["Feathermoon flight master"] = "Mestre de voo de Plumaluna",

	-- Step 17: Feralas
	["Grimtotem camp"] = "Acampamento Temível Totem",

	-- Step 18: Grimtotem camp
	-- {area:489} Thalanaar · {npc:7956} Kindal Moonweaver
	-- plural, as words: Sprite Darters = {npc:5278} Sprite Darter
	["From {area:489} ride west along the road to the Grimtotem camp north of it. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "De {area:489}, siga para oeste pela estrada até o acampamento Temível Totem ao norte dela. {npc:7956} espera do lado de fora; liberte os Dardejantes do cercado no meio e mantenha {npc:7956} e pelo menos seis deles vivos.",

	-- Step 19: Grimtotem tauren
	["Grimtotem tauren"] = "Taurens Temível Totem",

	-- Step 20: Jer'kai Moonweaver
	-- {zone:1457} Darnassus
	["for Tyrande in {zone:1457}: the route takes you there at 47"] = "para Tyrande Murmuréolo em {zone:1457}: a rota leva você lá no 47",

	-- Step 21: The Writhing Deep
	-- {area:489} Thalanaar
	["Ride south-east to the Woodpaw gnolls; the courier's backpacks lie in their southern camp, and a parcel inside them starts a delivery to {area:489}. The Zukk'ash hive is just south: fight down to the pod that holds Raschal, free him and keep him alive on the way out."] = "Cavalgue para sudeste até os gnolls Patábua; as mochilas do mensageiro estão no acampamento sul deles, e um pacote dentro delas inicia uma entrega para {area:489}. A colmeia Zukk'ash fica logo ao sul: lute até o casulo que prende Patiphe, o Mensageiro, liberte-o e mantenha-o vivo na saída.",
	-- {item:11463} Undelivered Parcel
	["{item:11463}, from the backpacks"] = "{item:11463}, das mochilas",
	-- {object:164954} Zukk'ash Pod
	["{object:164954}, inside"] = "{object:164954}, lá dentro",

	-- Step 22: High Wilderness: kill these as you meet them
	-- {area:1136} High Wilderness
	["{area:1136}: kill these as you meet them"] = "{area:1136}: vá matando estes pelo caminho",
	-- {quest:7735} Pristine Yeti Hide · {npc:7852} Pratt McGrubben · {npc:14637} Zorbin Fandazzle · {area:978} Zul'Farrak
	["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide, and about one in thirty a {quest:7735}, which {npc:7852} pays for too.\n{npc:14637}'s quests on the coast need level 45: grind the yetis here until level 44.5, so the kills also bring {npc:7852}'s hides. Or, with a group, run the {area:978} dungeon instead."] = "Cavalgue de volta para oeste pela estrada e depois para o norte, pelas colinas Cortifúria. Todo yeti daqui pode soltar um pelego, e cerca de um em trinta, {quest:7735}, que {npc:7852} também paga.\nAs missões de {npc:14637} na costa exigem nível 45: mate os yetis daqui até o nível 44.5, para que as mortes também rendam os pelegos de {npc:7852}. Ou, com um grupo, faça a masmorra {area:978}.",
	-- {npc:5296} Rage Scar Yeti
	["grind on {npc:5296}"] = "mate {npc:5296} até subir",

	-- Step 23: Rage Scar Hold
	-- {quest:7735} Pristine Yeti Hide
	["No {quest:7735} yet? Keep killing the Rage Scar yetis until one drops, then right-click it."] = "Ainda sem {quest:7735}? Continue matando os yetis Cortifúria até um soltar, depois clique nele com o botão direito.",

	-- Step 24: Feathermoon Stronghold
	-- {npc:7880} Ginro Hearthkindle
	["{npc:7880} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:7880} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",

	-- Step 25: Feathermoon Stronghold
	-- {npc:3936} Shandris Feathermoon · {zone:1457} Darnassus · {area:976} Gadgetzan
	["{npc:3936} then asks you to carry news to {zone:1457}: skip it, {area:976} sends you there instead."] = "{npc:3936} então pede que você leve notícias a {zone:1457}: pule, {area:976} manda você lá em vez disso.",

	-- Step 27: Grind to 45
	["Grind to 45"] = "Farme até o 45",
	-- {area:1105} Feral Scar Vale · {npc:14637} Zorbin Fandazzle · {area:978} Zul'Farrak · {area:1517} Uldaman
	["Ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45. Or, with a group, run the {area:978} dungeon or the {area:1517} dungeon instead."] = "Siga para leste até {area:1105}. As missões de {npc:14637} na costa precisam de nível 45. Ou, com um grupo, faça a masmorra {area:978} ou a masmorra {area:1517}.",
	-- {npc:5292} Feral Scar Yeti · {area:1105} Feral Scar Vale · {zone:1444} Feralas
	["grind on {npc:5292} at {area:1105}, {zone:1444}"] = "farme {npc:5292} em {area:1105}, {zone:1444}",

	-- Step 28: Zorbin Fandazzle
	-- {area:1108} Forgotten Coast
	["Ride back to the {area:1108}; the goblin stands by the dock."] = "Volte cavalgando para {area:1108}; o goblin fica junto à doca.",

	-- Step 29: Forgotten Coast: kill these as you meet them
	-- {area:1108} Forgotten Coast
	["{area:1108}: kill these as you meet them"] = "{area:1108}: vá matando estes pelo caminho",
	-- {item:18904} Zorbin's Ultra-Shrinker
	-- plural, as words: Shore Striders = {npc:5359} Shore Strider · Deep Striders = {npc:5360} Deep Strider · Wave Striders = {npc:5361} Wave Strider · Sea Elementals = {npc:5461} Sea Elemental · Sea Sprays = {npc:5462} Sea Spray
	["Shore Striders, Deep Striders and Wave Striders (elite giants) wade along the coast north of the dock: zap one with {item:18904} and kill the shrunken giant. Sea Elementals and Sea Sprays drift in the same surf."] = "Costívagos, Fundívagos e Ondarilhos (gigantes elite) andam pela costa ao norte da doca: atinja um com {item:18904} e mate o gigante encolhido. Elementais do Mar e Borrifos do Mar flutuam na mesma rebentação.",

	-- Step 30: Zorbin Fandazzle
	-- {npc:14637} Zorbin Fandazzle
	["{npc:14637}'s refills are level 55: skip them."] = "As recargas de {npc:14637} são de nível 55: pule-as.",
	-- {zone:1446} Tanaris · {area:489} Thalanaar
	["The {zone:1446} guide starts with the trip east, past {area:489}."] = "O guia de {zone:1446} começa com a viagem para leste, passando por {area:489}.",

	-- Step 31: Thalanaar
	-- {zone:1441} Thousand Needles
	["Ride north-east to the night elf outpost on the {zone:1441} border."] = "Cavalgue para nordeste até o posto avançado dos elfos noturnos na fronteira de {zone:1441}.",
	-- {npc:4048} Falfindel Waywarder · {area:489} Thalanaar
	["{npc:4048} walks around {area:489}: look inside the circle on the map"] = "{npc:4048} anda por {area:489}: procure dentro do círculo no mapa",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Boat to the {area:1108} and ride east across {zone:1444} to the Grimtotem camp north of the road. {npc:7956} waits outside it; free the Sprite Darters from the pen in the middle and keep {npc:7956} and at least six of them alive."] = "Barco para {area:1108} e cavalgue para leste por {zone:1444} até o acampamento Temível Totem ao norte da estrada. {npc:7956} espera do lado de fora; liberte os Dardejantes do cercado no meio e mantenha {npc:7956} e pelo menos seis deles vivos.",
	-- ["Boat to the {area:1108} and ride east into {area:1105}. {npc:14637}'s quests on the coast need level 45."] = "Barco para {area:1108} e cavalgue para leste até {area:1105}. As missões de {npc:14637} na costa exigem nível 45.",
	-- ["From Theramore, fly to {area:608} and ride south out of {zone:1443} into {zone:1444}; the road leads west to the {area:1108} dock, where the boat crosses to Feathermoon on {area:1120}."] = "De Theramore, voe para {area:608} e cavalgue para o sul, saindo de {zone:1443} para {zone:1444}; a estrada leva a oeste até a doca de {area:1108}, onde o barco atravessa para o Domínio de Plumaluna em {area:1120}.",
	-- ["Giants and elementals"] = "Gigantes e elementais",
	-- ["Hearth to Feathermoon."] = "Pedra de Regresso para o Domínio de Plumaluna.",
	-- ["Into {area:17}"] = "Rumo a {area:17}",
	-- ["Rage Scar yetis"] = "Yetis Cortifúria",
	-- ["Ride back north-west to the {area:1108} dock and take the boat to the island."] = "Volte cavalgando para noroeste até a doca de {area:1108} e pegue o barco para a ilha.",
	-- ["Ride back west along the road, then north into the Rage Scar hills. Every yeti here can drop a hide; one may drop a {quest:7735}, which {npc:7852} pays for too."] = "Volte para oeste pela estrada e depois para o norte até as colinas dos Yetis Cortifúria. Todo yeti daqui pode deixar cair um couro; um pode deixar cair um {quest:7735}, que {npc:7852} também paga.",
	-- ["Ride west to the friendly mountain giant at the foot of the hills. Land Walkers and Cliff Giants around him are elite: give them room."] = "Cavalgue para oeste até o gigante da montanha amistoso ao pé das colinas. Os Terrâmbulos e Gigantes do Penhasco ao redor dele são elite: mantenha distância.",
	-- ["Ring the bell whenever {npc:7774} stops to wander, and lead her south to {npc:7765}."] = "Toque o sino sempre que {npc:7774} parar para vagar e leve-a para o sul até {npc:7765}.",
	-- ["Running {area:978} instead of grinding gets you there faster in a group. The troll city lies in northern {zone:1446}, the next zone on the route; come back to {npc:14637} on the {area:1108} afterwards."] = "Fazer {area:978} em vez de farmar leva você lá mais rápido em grupo. A cidade troll fica no norte de {zone:1446}, a próxima zona da rota; depois volte a {npc:14637} em {area:1108}.",
	-- ["Swim south from the island to the {area:1121}. Hatecrest Serpent Guards and Sorceresses hold it; {npc:8136} (level 47) waits in the cave at its south end. Pull his guards first."] = "Nade para o sul da ilha até {area:1121}. Serpentes Guardas Cristafúria e Feiticeiras Cristafúria a ocupam; {npc:8136} (nível 47) espera na caverna no extremo sul. Puxe os guardas dele primeiro.",
	-- ["You end at the {area:1108} dock: the {zone:1446} guide starts with the trip east from here."] = "Você termina na doca de {area:1108}: o guia de {zone:1446} começa com a viagem para leste a partir daqui.",
	-- ["grind on {npc:5292} at {area:1105}, {area:357}"] = "farme {npc:5292} em {area:1105}, {area:357}",
	-- ["if you carry {quest:1100} from {zone:1441}"] = "se você trouxer {quest:1100} de {zone:1441}",
	-- ["{area:978} instead of grinding"] = "{area:978} em vez de farmar",
	-- ["{npc:7774} wanders the hills north of {npc:7765}, among the Northspring harpies; her bell is in the chest beside her."] = "{npc:7774} vaga pelas colinas ao norte de {npc:7765}, entre as harpias da Nascente Norte; o sino dela está no baú ao lado.",
	-- ["{npc:7774}'s escort"] = "A escolta de {npc:7774}",
}
