-- Portuguese (Brazil) (ptBR): the guide forever/horde/30-40/03-arathi-highlands (forever/horde/30-40/03-arathi-highlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Zeppelin to Undercity
	-- {zone:1458} Undercity
	["Zeppelin to {zone:1458}"] = "Zepelim para {zone:1458}",

	-- Step 2: Orgrimmar
	-- {object:1661} The Undercity (no name in this language: may be words) · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["{object:1661} has no Hunter or Shaman trainer: take the {zone:1454} zeppelin from the same tower instead and train in the city, then take the {zone:1458} zeppelin from the tower outside {zone:1454}'s main gate."] = "{object:1661} não tem instrutor de caçador nem de xamã: pegue o zepelim de {zone:1454} na mesma torre, treine na cidade e depois pegue o zepelim de {zone:1458} na torre do lado de fora do portão principal de {zone:1454}.",

	-- Step 3: Thunder Bluff
	-- {spell:18960} Teleport: Moonglade · {npc:11798} Bunthen Plainswind · {area:1638} Thunder Bluff · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {zone:1454} Orgrimmar · {zone:1458} Undercity
	["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "Use {spell:18960} e pegue o voo de {npc:11798} para {area:1638}; {npc:3033} treina você em {area:1639}. Depois voe para {zone:1454} e pegue o zepelim para {zone:1458} na torre do lado de fora do portão principal.",

	-- Step 4: Undercity trainers
	-- {zone:1458} Undercity
	["{zone:1458} trainers"] = "Instrutores de {zone:1458}",
	-- {zone:1458} Undercity · {object:36070} War Quarter (no name in this language: may be words) · {object:36073} Rogues' Quarter (no name in this language: may be words) · {object:36082} Magic Quarter (no name in this language: may be words) · {npc:260093} Garen Largo
	["Train while you are in the {zone:1458}: the trainers stand in the {object:36070}, the {object:36073} and the {object:36082} (Paladins: {npc:260093})."] = "Treine enquanto estiver em {zone:1458}: os instrutores ficam no {object:36070}, no {object:36073} e no {object:36082} (paladinos: {npc:260093}).",

	-- Step 5: Fly to Tarren Mill
	-- {area:272} Tarren Mill
	["Fly to {area:272}"] = "Voe para {area:272}",
	-- {zone:1458} Undercity
	["{zone:1458} flight master"] = "Mestre de voo de {zone:1458}",

	-- Step 7: Boulderfist camp
	["Boulderfist camp"] = "Acampamento Punho de Pedra",
	-- {area:272} Tarren Mill · {area:1857} Thoradin's Wall · {area:313} Northfold Manor
	-- plural, as words: Boulderfist Ogres = {npc:2562} Boulderfist Ogre
	["Head east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Saia de {area:272} para leste, passe por {area:1857} e siga a estrada para leste. Os Ogros e Impositores Punho de Pedra (32-34) acampam ao sul da estrada, a sudeste de {area:313}.",
	["Below ground"] = "No subterrâneo",

	-- Step 8: The Shards of Myzrael
	-- {object:138492} Shards of Myzrael
	["The {object:138492}"] = "{object:138492}",
	-- {area:321} Hammerfall
	["The violet shards glow just off the road a short way west of {area:321}."] = "Os estilhaços violeta brilham logo ao lado da estrada, um pouco a oeste de {area:321}.",

	-- Step 10: Hammerfall
	-- {npc:2851} Urda
	["The orc stronghold at the eastern end of the road. {npc:2851}, the wind rider master, stands by the gate."] = "A fortaleza orc no extremo leste da estrada. {npc:2851}, a mestra de mantícoras, fica junto ao portão.",

	-- Step 11: Highland raptors
	["Highland raptors"] = "Raptores do planalto",
	-- {area:321} Hammerfall
	-- plural, as words: Highland Striders = {npc:2559} Highland Strider
	["Highland Striders roam the hills all around {area:321}; both they and the Thrashers further west drop the eyes."] = "Andarilhos do Planalto vagam pelas colinas em volta de {area:321}; eles e os Espancadores do Planalto mais a oeste deixam cair os olhos.",

	-- Step 13: Drywhisker Gorge
	["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael.\nCareful: Every kobold type runs off for help when low on health (Kobolds at 30%, Surveyors and Diggers at 15%), which can pull more of them."] = "A nordeste da Ruína do Martelo, os kobolds Bigodesseco mineram o desfiladeiro; os Kobolds da entrada e os Escavadores e Topógrafos lá do fundo deixam cair as Partículas de Myzrael.\nCuidado: todo tipo de kobold sai correndo atrás de ajuda com pouca vida (Kobolds com 30%, Topógrafos e Escavadores com 15%), o que pode trazer mais deles.",

	-- Step 14: Iridescent Shards
	-- {object:2701} Iridescent Shards
	["The {object:2701} lie at the far end of the gorge."] = "Os {object:2701} ficam no fundo do desfiladeiro.",

	-- Step 15: The Stone of East Binding
	-- {object:2691} Stone of East Binding
	["The {object:2691}"] = "{object:2691}",
	-- {object:180105} Circle of Binding · {area:321} Hammerfall
	-- plural, as words: Burning Exiles = {npc:2760} Burning Exile · Thundering Exiles = {npc:2762} Thundering Exile · Cresting Exiles = {npc:2761} Cresting Exile
	["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}.\nCareful: Each center stone is guarded by around three elementals near level 39 that attack together if you click the stone without clearing them: Burning Exiles at West, Thundering Exiles at Outer, Cresting Exiles at East."] = "Cada {object:180105} é um anel de monólitos; a chave fica na pedra do centro. O círculo do leste fica nas colinas a noroeste de {area:321}.\nCuidado: cada pedra central é guardada por uns três elementais perto do nível 39, que atacam juntos se você clicar na pedra sem limpá-los antes: Exilados em Chamas no Oeste, Exilados Trovejantes no Externo, Exilados Vagalhantes no Leste.",

	-- Step 16: Witherbark Village
	["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village.\nCareful: All three troll types flee for help at 15% health, which can pull more trolls from the nearby camps."] = "Os trolls Cascasseca ocupam a aldeia nas colinas do sudeste. Arremessadores guardam as cabanas de fora; os Mandingueiros e Caçadores de Cabeças ficam no coração da aldeia.\nCuidado: os três tipos de troll fogem atrás de ajuda com 15% de vida, o que pode trazer mais trolls dos acampamentos vizinhos.",

	-- Step 17: The Stone of Outer Binding
	-- {object:2690} Stone of Outer Binding
	["The {object:2690}"] = "{object:2690}",
	["Head north; the outer circle stands in the middle of the highlands."] = "Siga para o norte; o círculo externo fica no meio do planalto.",

	-- Step 18: Fleshstalker raptors
	["Fleshstalker raptors"] = "Raptores Fareja-carne",
	-- {area:316} Boulderfist Hall
	-- plural, as words: Highland Fleshstalkers = {npc:2561} Highland Fleshstalker
	["Highland Fleshstalkers (36-37) hunt the southern highlands, a pack north of {area:316} and another on the plain to its west. Pull them one at a time."] = "Farejas-carne do Planalto (36-37) caçam no planalto sul, um bando ao norte de {area:316} e outro na planície a oeste. Puxe um de cada vez.",

	-- Step 19: Faldir's Cove
	-- {npc:2766} Lolo the Lookout
	["Head south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Siga para sudoeste até a enseada dos goblins, na costa sul. {npc:2766} vigia do penhasco acima dela.",

	-- Step 20: Professor Phizzlethorpe
	["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close.\nCareful: The ambush is two level 40 water elementals, and they are immune to frost. If the fight happens inside the cave, the professor joins in instead of working and further elementals keep appearing; holding the elementals at the cave entrance, away from him, lets him finish with only the first two to deal with."] = "Escolte o Professor Bruzundanga até a praia. Dois nagas Espinhadaga emboscam o professor no caminho: fique perto.\nCuidado: a emboscada é de dois elementais da água de nível 40, imunes a gelo. Se a luta for dentro da caverna, o professor larga o serviço para brigar e mais elementais continuam aparecendo; segurando os elementais na entrada da caverna, longe dele, ele termina e você só enfrenta os dois primeiros.",

	-- Step 22: The Drowned Reef: kill these as you meet them
	-- {area:328} The Drowned Reef
	["{area:328}: kill these as you meet them"] = "{area:328}: vá matando estes pelo caminho",
	-- plural, as words: Daggerspine Raiders = {npc:2595} Daggerspine Raider
	["West of the cove the Daggerspine Raiders and Sorceresses (38-40) hold the shore: pull them one at a time. The two wrecks lie in the shallows off it, the charts and logs inside them; the gems lie on the sea floor around the wrecks."] = "A oeste da enseada, os Saqueadores e Feiticeiras Espinhadaga (38-40) ocupam a praia: puxe um de cada vez. Os dois naufrágios ficam nas águas rasas em frente, com as cartas e os diários dentro; as gemas ficam no fundo do mar em volta dos naufrágios.",
	["Underwater"] = "Debaixo d'água",

	-- Step 23: Faldir's Cove
	-- {npc:2487} Fleet Master Seahorn · {area:35} Booty Bay
	["for {npc:2487} in {area:35}, around level 44"] = "para {npc:2487} em {area:35}, por volta do nível 44",

	-- Step 24: Circle of West Binding: kill these as you meet them
	-- {area:334} Circle of West Binding
	["{area:334}: kill these as you meet them"] = "{area:334}: vá matando estes pelo caminho",
	-- {area:1857} Thoradin's Wall
	-- plural, as words: Bloodstone Amulets = {item:4495} Bloodstone Amulet
	["The western circle is near {area:1857}, where you came in.\nThe Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets.\nCareful: Highwaymen (level 30-31) can be in Sneak, so they may be hidden when you approach."] = "O círculo do oeste fica perto de {area:1857}, por onde você entrou.\nA Camarilha ocupa o solar murado e a fazenda dele, no noroeste; os Bandoleiros, Mercenários e Tocaiantes deles carregam os Amuletos de Pedra-sangrenta.\nCuidado: os Bandoleiros (nível 30-31) podem estar furtivos, então talvez estejam escondidos quando você chegar.",

	-- Step 25: The Stone of Inner Binding
	-- {object:2702} Stone of Inner Binding
	["The {object:2702}"] = "{object:2702}",
	["The inner circle lies south of the western circle, east of Stromgarde."] = "O círculo interno fica ao sul do círculo oeste, a leste de Stromgarde.",
	["The stone's next task needs Fozruk, a level 42 elite: leave it."] = "A próxima tarefa da pedra exige Fozruk, um elite de nível 42: deixe-a.",

	-- Step 26: Hearth to Hammerfall
	-- {area:321} Hammerfall
	["Hearth to {area:321}"] = "Pedra de Regresso para {area:321}",

	-- Step 27: Back to Hammerfall
	-- {area:321} Hammerfall
	["Back to {area:321}"] = "De volta a {area:321}",

	-- Step 28: Boulderfist Hall
	-- {area:321} Hammerfall
	-- plural, as words: Boulderfist Brutes = {npc:2566} Boulderfist Brute
	["The Boulderfist Brutes camp outside the ogres' hall south of {area:321}; the Magus stand among them. Pull them one at a time."] = "Os Brutamontes Punho de Pedra acampam fora do salão dos ogros ao sul de {area:321}; os Magus Punho de Pedra ficam entre eles. Puxe um de cada vez.",

	-- Step 29: Drum Fel
	-- {npc:2771} Drum Fel · {quest:678} Call to Arms
	["{npc:2771}'s next {quest:678} is against Boulderfist elites: leave it."] = "A próxima {quest:678} de {npc:2771} é contra elites Punho de Pedra: deixe-a.",

	-- Step 30: Into the Badlands
	-- {zone:1418} Badlands
	["Into the {zone:1418}"] = "Rumo a {zone:1418}",
	-- {area:880} Thandol Span · {zone:1437} Wetlands · {area:150} Menethil Harbor · {zone:1432} Loch Modan · {zone:1418} Badlands · {area:1877} Valley of Fangs
	["Head south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Saia de Arathi para sudoeste por {area:880}, siga para o sul por {zone:1437} (passe longe de {area:150}) e para leste até {zone:1432}; a estrada sai de {zone:1432} pelo sul rumo a {zone:1418}. Siga por ela para o sul até o acampamento goblin em {area:1877}.",

	-- Step 31: Valley of Fangs
	-- {quest:1106} Martek the Exiled · {area:439} Shimmering Flats
	["{quest:1106}: Fizzle's letter from the {area:439}"] = "{quest:1106}: a carta de Bulho, de {area:439}",

	-- Step 32: Kargath
	-- {area:340} Kargath
	["{area:340} is the Horde fortress built into the cliffs at the zone's western edge."] = "{area:340} é a fortaleza da Horda construída nos penhascos da borda oeste da zona.",
	-- {area:75} Stonard
	["for Helgrum in {area:75}, around level 42"] = "para Helgrum, em {area:75}, por volta do nível 42",
	-- {npc:6868} Jarkal Mossmeld
	["{npc:6868}, inside"] = "{npc:6868}, lá dentro",

	-- Step 33: The Dustbowl
	-- {npc:2921} Lotwil Veriatus · {area:1878} The Dustbowl · {area:340} Kargath
	["Head west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Siga para oeste pela estrada; o acampamento de {npc:2921} fica em {area:1878}, a meio caminho de {area:340}.",

	-- Step 34: Lesser Rock Elementals
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental
	["Lesser Rock Elementals"] = "Elementais Inferiores da Rocha",
	-- {npc:2921} Lotwil Veriatus · {npc:6868} Jarkal Mossmeld
	-- plural, as words: Rock Elemental Shards = {item:7848} Rock Elemental Shard
	["The small elementals drift across the flats just west of {npc:2921}'s camp. Every rock elemental in the zone can drop {npc:6868}'s Rock Elemental Shards: keep them."] = "Os elementais pequenos vagam pelas planícies logo a oeste do acampamento de {npc:2921}. Todo elemental da rocha da zona pode deixar cair Estilhaços de Elemental da Rocha para {npc:6868}: guarde-os.",

	-- Step 36: Badlands: kill these as you meet them
	-- {zone:1418} Badlands
	["{zone:1418}: kill these as you meet them"] = "{zone:1418}: vá matando estes pelo caminho",
	-- {area:1878} The Dustbowl
	-- plural, as words: Elder Crag Coyotes = {npc:2729} Elder Crag Coyote · Giant Buzzards = {npc:2831} Giant Buzzard · Rock Elementals = {npc:92} Rock Elemental
	["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards.\nThe bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Os Coiotes Anciãos do Rochedo e os Urubus Gigantes andam pela bacia ao sul de {area:1878}. Os coiotes deixam cair tanto as mandíbulas quanto as presas; só os urubus deixam cair asas e moelas.\nOs Elementais da Rocha maiores ficam nas encostas a noroeste de {area:1878}; cada um deixa cair uma laje.",

	-- Step 38: Agmond's End
	-- {area:345} Agmond's End · {area:1877} Valley of Fangs
	["Theldurin sits among the dwarven ruins at {area:345}, south of the {area:1877}."] = "Theldurin fica entre as ruínas anãs em {area:345}, ao sul de {area:1877}.",

	-- Step 39: Stonevault troggs
	["Stonevault troggs"] = "Troggs da Abóbada de Pedra",
	-- {area:1877} Valley of Fangs · {area:345} Agmond's End
	["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "Os troggs da Abóbada de Pedra cavam em volta das entradas das cavernas ao sul de {area:1877}, no caminho para {area:345}; os Quebraossos e Xamãs deixam cair as lascas.",

	-- Step 40: Ancient Chest
	-- {area:1517} Uldaman
	["Keep north on the road; the chest lies in the {area:1517} dig site, at the foot of the ruins north-west of the road."] = "Continue para o norte pela estrada; o baú fica no sítio de escavação de {area:1517}, ao pé das ruínas a noroeste da estrada.",

	-- Step 41: Agmond's End
	-- {area:1877} Valley of Fangs
	["Head back south down the road, past the {area:1877}."] = "Volte para o sul pela estrada, passando por {area:1877}.",

	-- Step 44: The Dustbowl: kill these as you meet them
	-- {area:1878} The Dustbowl
	["{area:1878}: kill these as you meet them"] = "{area:1878}: vá matando estes pelo caminho",
	-- {zone:1418} Badlands · {npc:6868} Jarkal Mossmeld · {npc:2921} Lotwil Veriatus
	-- plural, as words: Lesser Rock Elementals = {npc:2735} Lesser Rock Elemental · Greater Rock Elementals = {npc:2736} Greater Rock Elemental
	["Every rock elemental in the {zone:1418} drops {npc:6868}'s shards: the Lesser Rock Elementals (37) on the flats west of {npc:2921}'s camp are the safe ones, about one kill in five. Only the Greater Rock Elementals (42-44, well above you) in the south-western gulches drop {npc:2921}'s bracers, also about one kill in five: pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Todo elemental da rocha de {zone:1418} deixa cair os estilhaços para {npc:6868}: os Elementais Inferiores da Rocha (37) na planície a oeste do acampamento de {npc:2921} são os tranquilos, mais ou menos um a cada cinco. Só os Elementais Maiores da Rocha (42-44, bem acima de você) nos barrancos do sudoeste deixam cair as braçadeiras para {npc:2921}, também uns um a cada cinco: puxe um de cada vez e descanse entre as lutas, ou deixe para lá. Pelo caminho, continue matando os coiotes e urubus que ainda faltam.",

	-- Step 45: The Dustbowl
	-- {npc:2920} Lucien Tosselwrench · {item:2868} Patterned Bronze Bracers · {skill:164} Blacksmithing
	["{npc:2920}: only if you carry {item:2868} ({skill:164} or the Auction House)"] = "{npc:2920}: só se você tiver {item:2868} ({skill:164} ou a Casa de Leilões)",

	-- Step 46: Kargath
	-- {area:340} Kargath
	["Head north back to {area:340}."] = "Volte para o norte até {area:340}.",

	-- Step 47: Fly to Grom'gol
	-- {object:3202} Grom'gol (no name in this language: may be words)
	["Fly to {object:3202}"] = "Voe para {object:3202}",
	-- {area:340} Kargath
	["{area:340} flight master"] = "Mestre de voo de {area:340}",

	-- Step 48: Zeppelin to Orgrimmar
	-- {zone:1454} Orgrimmar
	["Zeppelin to {zone:1454}"] = "Zepelim para {zone:1454}",

	-- Step 50: Orgrimmar
	-- {item:3713} Soothing Spices
	["{item:3713}, for \"Swamp Eye\" Jarl"] = "{item:3713}, para Zé \"Olho de Lama\"",

	-- Step 52: Orgrimmar flight master
	-- {zone:1454} Orgrimmar
	["{zone:1454} flight master"] = "Mestre de voo de {zone:1454}",

	-- Step 53: Thunder Bluff
	-- {area:1638} Thunder Bluff · {zone:1454} Orgrimmar · {npc:3033} Turak Runetotem · {area:1639} Elder Rise · {npc:246344} Alodan the Hopeful · {area:380} Crossroads
	["Your trainer is in {area:1638}, one flight from {zone:1454}: {npc:3033} (Druids) on {area:1639}, {npc:246344} (Paladins). Fly on to the {area:380} from there."] = "Seu instrutor está em {area:1638}, a um voo de {zone:1454}: {npc:3033} (druidas) em {area:1639}, {npc:246344} (paladinos). De lá, voe para {area:380}.",

	-- Step 54: Fly to Crossroads
	-- {area:380} Crossroads
	["Fly to {area:380}"] = "Voe para {area:380}",

	-- Step 57: Regthar Deathgate
	-- {area:380} Crossroads · {area:386} Forgotten Pools · {npc:3389} Regthar Deathgate
	["Head north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Suba a estrada para o norte de {area:380} até {area:386}; {npc:3389} vigia do alto, acima da água.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Cast {spell:18960} and take {npc:11798}'s flight to {area:1638}; {npc:3033} trains you on {area:1639}. Then fly to {zone:1454} and take the {zone:1458} zeppelin from the tower outside the main gate."] = "Lance {spell:18960} e pegue o voo de {npc:11798} para {area:1638}; {npc:3033} treina você em {area:1639}. Depois voe para {zone:1454} e pegue o zepelim de {zone:1458} na torre do lado de fora do portão principal.",
	-- ["Coyotes and buzzards"] = "Coiotes e urubus",
	-- ["Daggerspine shore"] = "Praia Espinhadaga",
	-- ["Each {object:180105} is a ring of standing stones; the key sits on the stone at its heart. The eastern circle is on the hills north-west of {area:321}."] = "Cada {object:180105} é um anel de pedras erguidas; a chave fica na pedra do centro. O círculo leste fica nas colinas a noroeste de {area:321}.",
	-- ["Escort the professor down to the shore. Two Daggerspine naga ambush him on the way: stay close."] = "Escolte o professor até a margem. Duas nagas Espinhadaga o emboscam no caminho: fique perto.",
	-- ["Follow the road north; {npc:4618}'s camp is on the way."] = "Siga a estrada para o norte; o acampamento de {npc:4618} fica no caminho.",
	-- ["From {area:35}, fly to {object:3202}. {object:1661} zeppelin leaves from the tower on the west side of the camp."] = "De {area:35}, voe para {object:3202}. O zepelim de {object:1661} parte da torre no lado oeste do acampamento.",
	-- ["Greater Rock Elementals"] = "Elementais Maiores da Rocha",
	-- ["Hearth to {area:340}"] = "Regresse para {area:340}",
	-- ["North-east of Hammerfall the Drywhisker kobolds mine the gorge; the Kobolds at the mouth and the Diggers and Surveyors deeper in all drop the Motes of Myzrael."] = "A nordeste da Ruína do Martelo, os kobolds Bigodesseco mineram o desfiladeiro; os Kobolds da entrada e os Escavadores e Topógrafos mais ao fundo deixam cair as Partículas de Myzrael.",
	-- ["Ride back south down the road, past the {area:1877}."] = "Cavalgue de volta para o sul pela estrada, passando por {area:1877}.",
	-- ["Ride back south to the {area:380} and fly to {area:392}."] = "Cavalgue de volta para o sul até {area:380} e voe para {area:392}.",
	-- ["Ride east out of {area:272} through {area:1857} and follow the road east. The Boulderfist Ogres and Enforcers (32-34) camp south of the road, south-east of {area:313}."] = "Cavalgue para leste saindo de {area:272} por {area:1857} e siga a estrada para leste. Os Ogros e Impositores Punho de Pedra (32-34) acampam ao sul da estrada, a sudeste de {area:313}.",
	-- ["Ride north back to {area:340}."] = "Cavalgue para o norte de volta a {area:340}.",
	-- ["Ride north up the road from the {area:380} to the {area:386}; {npc:3389} keeps watch on the rise above the water."] = "Cavalgue para o norte pela estrada de {area:380} até {area:386}; {npc:3389} vigia da elevação acima da água.",
	-- ["Ride north; the outer circle stands in the middle of the highlands."] = "Cavalgue para o norte; o círculo externo fica no meio do planalto.",
	-- ["Ride south along the coast from {area:392} to {area:720}. {npc:6236} stands by the arena: step on the grate to start the fight; the challengers come one at a time, then {npc:6238} (33)."] = "Cavalgue para o sul pela costa, de {area:392} até {area:720}. {npc:6236} fica junto à arena: pise na grade para começar a luta; os desafiantes vêm um de cada vez, depois {npc:6238} (33).",
	-- ["Ride south-west out of Arathi over {area:880}, south through the {zone:1437} (keep clear of {area:150}) and east into {zone:1432}; the road leaves {zone:1432} to the south into the {zone:1418}. Follow it south to the goblin camp in the {area:1877}."] = "Cavalgue para sudoeste saindo de Arathi por {area:880}, para o sul por {zone:1437} (fique longe de {area:150}) e para o leste até {zone:1432}; a estrada sai de {zone:1432} pelo sul até {zone:1418}. Siga-a para o sul até o acampamento goblin em {area:1877}.",
	-- ["Ride south-west to the goblins' cove on the southern coast. {npc:2766} keeps watch on the cliff above it."] = "Cavalgue para sudoeste até a enseada dos goblins no litoral sul. {npc:2766} vigia do penhasco acima dela.",
	-- ["Ride west along the road; {npc:2921}'s camp sits in the {area:1878} halfway to {area:340}."] = "Cavalgue para o oeste pela estrada; o acampamento de {npc:2921} fica em {area:1878}, a meio caminho de {area:340}.",
	-- ["Rock Elementals"] = "Elementais da Rocha",
	-- ["Stonevault troggs"] = "Troggs da Abóbada de Pedra",
	-- ["Take the {zone:1454} zeppelin from the tower on the west side of {object:3202}."] = "Pegue o zepelim para {zone:1454} na torre do lado oeste de {object:3202}.",
	-- ["The Elder Crag Coyotes and Giant Buzzards roam the basin south of the {area:1878}. Coyotes drop both the jawbones and the fangs; only the buzzards drop wings and gizzards."] = "Os Coiotes Anciões do Rochedo e os Urubus Gigantes vagam pela bacia ao sul de {area:1878}. Os coiotes deixam cair as mandíbulas e as presas; só os urubus deixam cair asas e moelas.",
	-- ["The Greater Rock Elementals (42-44, well above you) wander the gulches in the south-west; the bracers drop about one kill in five. Pull one at a time and rest between fights, or leave them. Keep killing coyotes and buzzards you still need on the way."] = "Os Elementais Maiores da Rocha (42-44, bem acima de você) vagam pelas ravinas do sudoeste; as braçadeiras caem em cerca de uma morte a cada cinco. Puxe um de cada vez e descanse entre as lutas, ou deixe-os. Continue matando no caminho os coiotes e urubus que ainda faltam.",
	-- ["The Stonevault troggs dig around the cave mouths south of the {area:1877}, on the way to {area:345}; the Bonesnappers and Shamans drop the flakes."] = "Os troggs da Abóbada de Pedra cavam em volta das entradas das cavernas ao sul de {area:1877}, no caminho para {area:345}; os Quebraossos e os Xamãs deixam cair as lascas.",
	-- ["The Syndicate hold the walled manor and its farm in the north-west; their Highwaymen, Mercenaries and Pathstalkers carry the Bloodstone Amulets."] = "A Camarilha ocupa o solar murado e sua fazenda no noroeste; seus Bandoleiros, Mercenários e Tocaiantes levam os Amuletos de Pedra-sangrenta.",
	-- ["The Witherbark trolls hold the village in the south-eastern hills. Axe Throwers guard the outer huts; the Witch Doctors and Headhunters hold the heart of the village."] = "Os trolls Cascasseca ocupam a aldeia nas colinas do sudeste. Arremessadores guardam as cabanas externas; os Mandingueiros e Caçadores de Cabeças ocupam o coração da aldeia.",
	-- ["The bigger Rock Elementals stand on the slopes north-west of the {area:1878}; each one drops a slab."] = "Os Elementais da Rocha maiores ficam nas encostas a noroeste de {area:1878}; cada um deixa cair uma laje.",
	-- ["The next guide heads into {zone:1445}."] = "O próximo guia segue para {zone:1445}.",
	-- ["The western circle is near {area:1857}, where you rode in."] = "O círculo oeste fica perto de {area:1857}, por onde você entrou.",
	-- ["The zeppelin lands at the towers outside the {zone:1458}: ride down into the city and fly to {area:272}."] = "O zepelim pousa nas torres do lado de fora de {zone:1458}: desça até a cidade e voe para {area:272}.",
	-- ["The {area:380}"] = "{area:380}",
	-- ["The {object:2689}"] = "{object:2689}",
	-- ["Zeppelin to the {zone:1458}"] = "Zepelim para {zone:1458}",
	-- ["Zeppelin tower"] = "Torre do zepelim",
	-- ["for {npc:5395} in {zone:1443}, in the next guide"] = "para {npc:5395}, em {zone:1443}, no próximo guia",
	-- ["{item:3713}, for \"Swamp Eye\" Jarl in {zone:1445}"] = "{item:3713}, para Zé \"Olho de Lama\", em {zone:1445}",
}
