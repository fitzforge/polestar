-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {zone:1443} Desolace
	["Kodo bones, demons and lost treasure in south {zone:1443}."] = "Ossos de kodo, demônios e tesouros perdidos no sul de {zone:1443}.",
	["Short: about one level of quests"] = "Curto: cerca de um nível de missões",
	-- {zone:1434} Stranglethorn Vale
	["Then on to {zone:1434}"] = "Depois siga para {zone:1434}",
	["Stays on the main route"] = "Fica na rota principal",
	["A long trip out to Kalimdor"] = "Uma longa viagem até Kalimdor",

	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "Mestre de voo de Theramore",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "Ao descer do barco, suba o cais até Baldruc, o mestre de voo junto ao portão de {area:514}.",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {zone:1443} Desolace · {npc:11863} Azore Aldamort
	["{npc:5638}, if the first {zone:1443} visit didn't take it: the wreck lies below {npc:11863}'s tower"] = "",
	-- {npc:5396} Captain Pentigast · {zone:1443} Desolace
	["{npc:5396}, if the first {zone:1443} visit didn't give it"] = "",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Siga a estrada para o sul até {area:2407}.",
	-- {npc:11438} Bibbly F'utzbuckle · {zone:1443} Desolace
	["{npc:11438}, if the first {zone:1443} visit didn't give it"] = "",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons.\nCareful: Rexxar (62, elite), the Horde's champion, walks the road past the graveyard with his bear Misha and attacks Alliance players: when he comes by, step well away from the road and let him pass."] = "",

	-- Step 7: Hornizz Brimbuzzle
	-- {quest:6134} Ghost-o-plasm Round Up · {area:2657} Valley of Bones
	-- plural, as words: Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan
	["These are elite mobs: grouping up is encouraged, look for people to do it with. {quest:6134}'s magnets draw the Magrami Spectres a few yards from the Magram Necrokhans and Corpsefeeders (45, elite) in the {area:2657}. Skip it if you are alone."] = "São inimigos elite: é recomendado formar grupo, procure gente para fazer junto. Os ímãs de {quest:6134} atraem os Espectros Magrami a poucos metros dos Necrocãs e Come-cadáveres Magram (45, elite) em {area:2657}. Pule-a se estiver sozinho.",

	-- Step 8: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit · {item:213562} Bug Catching Net
	["A {npc:217590} crawls about the {area:596}: open {npc:217412}'s {item:213565} and use its {item:213562} on one. Don't kill it."] = "Um {npc:217590} rasteja por {area:596}: abra {item:213565} de {npc:217412} e use a {item:213562} dele em um. Não o mate.",
	-- {item:213562} Bug Catching Net · {npc:217590} Flesh Picker · {item:213567} Flesh Picker Specimen
	["{item:213562}, on a {npc:217590}: the {item:213567}"] = "{item:213562}, em um {npc:217590}: {item:213567}",

	-- Step 9: Maraudine centaurs
	["Maraudine centaurs"] = "Centauros Maraudinos",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Os centauros Maraudinos ocupam {area:607}, a oeste do cemitério; todos os tipos soltam os totens.",

	-- Step 10: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: six centaurs attack during the escort, and you can't clear them beforehand: they appear only during the escort and come linked. In players' recordings 14 of 30 people who took it failed at least once. Bring a friend, or skip it if you are alone. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} está presa no acampamento de centauros a oeste do cemitério. Liberte-a e mantenha-a viva na saída; ela para perto do cemitério.\nCuidado: seis centauros atacam durante a escolta, e não dá para limpá-los antes: eles só aparecem durante a escolta e vêm juntos. Nas gravações dos jogadores, 14 das 30 pessoas que a pegaram falharam pelo menos uma vez. Traga um amigo, ou pule se estiver sozinho. Limpar os centauros comuns do caminho antes de começar ajuda.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escolte {npc:12277} de volta ao cemitério",

	-- Step 11: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace · {npc:5760} Lord Azrethoc
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}. Nether Maidens (37-38) hold its north-west side and drop the wings; Doomwarder Captains (38) stand at the south end and drop the blood.\nCareful: Nether Sorceresses (39-40) stand beside the Doomwarder Captains, and {npc:5760}, a level 40 elite, walks the coven's middle: pull the captains away from them. Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Os demônios se reúnem em {area:602}, no sul de {zone:1443}. As Donzelas do Éter (37-38) ocupam o lado noroeste e soltam as asas; os Capitães dos Guardiões da Ruína (38) ficam na ponta sul e soltam o sangue.\nCuidado: Feiticeiras do Éter (39-40) ficam ao lado dos Capitães dos Guardiões da Ruína, e {npc:5760}, um elite de nível 40, anda pelo meio do local: puxe os capitães para longe deles. A maioria dos monstros daqui patrulha, então é fácil puxar monstros a mais.",
	-- {item:6251} Nether Wing
	-- plural, as words: Nether Maidens = {npc:4679} Nether Maiden
	["{item:6251}, from the Nether Maidens"] = "{item:6251}, das Donzelas do Éter",
	-- {item:6252} Doomwarder Blood
	-- plural, as words: Doomwarder Captains = {npc:4680} Doomwarder Captain
	["{item:6252}, from the Doomwarder Captains"] = "{item:6252}, dos Capitães dos Guardiões da Ruína",

	-- Step 12: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields further east, with Magram Necromancers (42): pull the Ravagers to you, away from them."] = "Assoladores Mortos-vivos vagam pelos campos de ossos ao sul da Aldeia Magram, a leste das Ruínas de Mannoroc: a seta leva à borda oeste deles. Cuidado: Necrocãs e Come-cadáveres Magram (45, elite) andam pelos campos de ossos mais a leste, com Necromantes Magram (42): puxe os Assoladores até você, longe deles.",

	-- Step 13: The ghost magnets
	["The ghost magnets"] = "Os ímãs fantasmais",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Magrami Spectres = {npc:11560} Magrami Spectre
	["Use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres; the Necrokhans and Corpsefeeders (45, elite) walk close by: keep the group together."] = "Use o {item:15848} na seta dele, no lado leste dos campos, para atrair os Espectros Magrami; os Necrocãs e Come-cadáveres (45, elite) andam por perto: mantenha o grupo unido.",

	-- Step 14: Mannoroc Coven
	-- {npc:5760} Lord Azrethoc
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Mage Hunters = {npc:4681} Mage Hunter
	["Back at the coven on the way west: the Mana Eaters (37-38) on its north edge and the Mage Hunters (38-39) further in drop the brains. {npc:5760} (40, elite) walks among the Mage Hunters: pull them out to you."] = "De volta às ruínas, a caminho do oeste: os Manávoros (37-38) na borda norte e os Caça-magos (38-39) mais para dentro soltam os cérebros. {npc:5760} (40, elite) anda entre os Caça-magos: puxe-os até você.",

	-- Step 17: Azore Aldamort
	-- {npc:11863} Azore Aldamort · {area:2405} Ethel Rethor · {zone:1443} Desolace
	["{npc:11863}'s tower stands on the hill at the ruins of {area:2405}, west across the north of {zone:1443}."] = "A torre de {npc:11863} fica na colina das ruínas de {area:2405}, a oeste atravessando o norte de {zone:1443}.",
	-- {npc:11863} Azore Aldamort · {zone:1443} Desolace
	["{npc:11863}, if the first {zone:1443} visit didn't take the sceptre back to him"] = "",

	-- Step 18: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Siga a estrada para o oeste pelo norte de {zone:1443} até as ruínas de {area:2405}. A torre de {npc:11863} fica no morro dali, a caminho do naufrágio.",
	-- {npc:11863} Azore Aldamort · {quest:93464} The Visiting Mage · {zone:1435} Swamp of Sorrows
	["{npc:11863}: {quest:93464}, from Magtoor in the {zone:1435}"] = "{npc:11863}: {quest:93464}, de Magtoor em {zone:1435}",
	-- {npc:11863} Azore Aldamort · {zone:1443} Desolace
	["{npc:11863}, if the first {zone:1443} visit didn't give it"] = "",

	-- Step 19: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "O baú do navio naufragado fica logo a sudoeste da torre de {npc:11863}.",

	-- Step 20: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest · {zone:1443} Desolace
	["{object:177787} lies beside {object:35251}, if you didn't take it on your first {zone:1443} visit. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} fica ao lado de {object:35251}, se você não o pegou na primeira visita a {zone:1443}. A chave de prata dele cai dos caranguejos Estala-seca ao redor do naufrágio; a dourada vem dos nagas Lâmina Sinuosa na costa noroeste, a seguir.",
	-- {object:177787} Rackmore's Log · {zone:1443} Desolace
	["{object:177787}, if the first {zone:1443} visit didn't take it"] = "",
	["Underwater"] = "Debaixo d'água",

	-- Step 21: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}: vá matando estes pelo caminho",
	-- {npc:11863} Azore Aldamort · {spell:131} Water Breathing · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower, on the shore and out in the water. Karnitol's satchel drops now and then from their Tidehunters and Sea Witches, most of them underwater ({spell:131} helps): take it if it comes, it is optional. Any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Os nagas Torce-lâmina dominam a costa noroeste ao norte da torre de {npc:11863}, na margem e no mar. A bolsa de Karnitol é solta de vez em quando pelos Caçadores da Maré e Bruxas do Mar deles, a maioria debaixo d'água ({spell:131} ajuda): pegue-a se vier, é opcional. Qualquer naga pode soltar a chave dourada de Rackmore. Nade até {area:2406} frente à ponta norte mais distante e use {item:15766} em {object:177673}: {npc:12369} (38) se ergue; mate-o para {quest:6027}.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, dos nagas Lâmina Sinuosa",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue
	["{item:15766}, on the {object:177673}"] = "{item:15766}, no {object:177673}",

	-- Step 22: Rackmore's Chest
	-- {object:177673} Serpent Statue
	["Rackmore's chest lies just south-east of the {object:177673}."] = "O baú de Rackmore fica logo a sudeste do {object:177673}.",

	-- Step 25: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Siga a estrada para o norte até {area:608}: {npc:5396} fica na ponta sul, {npc:5638} no meio e {npc:1182} ao norte.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} em {zone:1455}: guarde-a",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} em {area:271}: guarde-a",

	-- Step 26: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	["The next guide starts in Theramore."] = "O próximo guia começa na Ilha Theramore.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Um {npc:217590} rasteja por {area:596}: pegue um com a ferramenta do {item:213565} de {npc:217412}.",
	-- ["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Os nagas Lâmina Sinuosa dominam a costa noroeste, ao norte da torre de {npc:11863}; a bolsa de Karnitol está no fundo do mar diante dela, e qualquer naga pode soltar a chave dourada de Rackmore. Nade até {area:2406}, na ponta extrema norte, e use o {item:15766} no {object:177673}: {npc:12369} (38) surge; mate-o para obter {quest:6027}.",
	-- ["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Os demônios se juntam em {area:602}, no sul de {zone:1443}: canisvis (Manávoros, Caça-magos e Caçadores do Meridiano), Donzelas e Irmãs do Éter, e Capitães dos Guardiões da Ruína em volta do fosso.\nCuidado: a maioria dos monstros daqui faz patrulha, então é fácil puxar monstro a mais.",
	-- ["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "Assoladores Mortos-vivos vagam pelos campos de ossos ao sul da Aldeia Magram, a leste das Ruínas de Mannoroc: a seta leva à borda oeste deles. Depois use o {item:15848} na seta dele, no lado leste dos campos, para atrair os Espectros Magrami. Cuidado: Necrocãs e Come-cadáveres Magram (45, elite) andam pelos campos de ossos entre as duas setas, com Necromantes Magram (42): puxe os Assoladores e os espectros até você, longe deles.",
	-- ["{area:144} flight master"] = "Mestre de voo de {area:144}",
	-- ["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} está presa no acampamento dos centauros a oeste do cemitério. Liberte-a e mantenha-a viva na saída; ela para junto ao cemitério.\nCuidado: os grupos da escolta vêm juntos e só aparecem durante ela, então não dá para limpar antes nem puxar um de cada vez. Limpar os centauros comuns do caminho antes de começar ajuda.",
	-- ["{npc:5396}, if 30-40/02 didn't give it"] = "{npc:5396}, se o 30-40/02 não a deu",
	-- ["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}, se o 30-40/02 não a pegou: o naufrágio fica abaixo da torre de {npc:11863}",
	-- ["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} fica na beira de {area:596}, a sudoeste de {area:2407}; {object:176751} estão entre os esqueletos.",
	-- ["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} fica ao lado de {object:35251}. A chave de prata dele cai dos caranguejos Estala-seca ao redor do naufrágio; a dourada vem dos nagas Lâmina Sinuosa na costa noroeste, a seguir.",
	-- ["{object:177787}, if 30-40/02 didn't take it"] = "{object:177787}, se o 30-40/02 não o pegou",
}
