-- Portuguese (Brazil) (ptBR): the guide forever/alliance/30-40/06b-desolace (forever/alliance/30-40/06b-desolace.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Mestre de voo de {area:144}",

	-- Step 3: Theramore flight master
	["Theramore flight master"] = "Mestre de voo de Theramore",
	-- {area:514} Foothold Citadel
	["Off the boat, walk up the pier to Baldruc, the flight master by the gate of {area:514}."] = "Ao descer do barco, suba o cais até Baldruc, o mestre de voo junto ao portão de {area:514}.",

	-- Step 4: Nijel's Point
	-- {npc:5638} Kreldig Ungor · {npc:11863} Azore Aldamort
	["{npc:5638}, if 30-40/02 didn't take it: the wreck lies below {npc:11863}'s tower"] = "{npc:5638}, se o 30-40/02 não a pegou: o naufrágio fica abaixo da torre de {npc:11863}",

	-- Step 5: Bibbly F'utzbuckle
	-- {area:2407} Kormek's Hut
	["Follow the road south to {area:2407}."] = "Siga a estrada para o sul até {area:2407}.",

	-- Step 6: Kodo Graveyard
	-- {npc:6019} Hornizz Brimbuzzle · {area:596} Kodo Graveyard · {area:2407} Kormek's Hut · {object:176751} Kodo Bones
	["{npc:6019} stands at the edge of the {area:596}, south-west of {area:2407}; {object:176751} lie among the skeletons."] = "{npc:6019} fica na beira de {area:596}, a sudoeste de {area:2407}; {object:176751} estão entre os esqueletos.",

	-- Step 7: Flesh Picker
	-- {npc:217590} Flesh Picker · {area:596} Kodo Graveyard · {npc:217412} Amaryllis Webb · {item:213565} Entomology Starter Kit
	["A {npc:217590} crawls about the {area:596}: catch one with the tool from {npc:217412}'s {item:213565}."] = "Um {npc:217590} rasteja por {area:596}: pegue um com a ferramenta do {item:213565} de {npc:217412}.",

	-- Step 8: Maraudine centaurs
	["Maraudine centaurs"] = "Centauros Maraudinos",
	-- {area:607} Valley of Spears
	["The Maraudine centaurs hold the {area:607} west of the graveyard; every kind drops the totems."] = "Os centauros Maraudinos ocupam {area:607}, a oeste do cemitério; todos os tipos soltam os totens.",

	-- Step 9: Melizza Brimbuzzle
	-- {npc:12277} Melizza Brimbuzzle
	["{npc:12277} is held in the centaur camp west of the graveyard. Free her and keep her alive on the walk out; she stops by the graveyard.\nCareful: The scripted groups are linked and only appear during the escort, so you cannot clear them in advance or pull them one at a time. Clearing the normal centaurs on the path before you start does help."] = "{npc:12277} está presa no acampamento dos centauros a oeste do cemitério. Liberte-a e mantenha-a viva na saída; ela para junto ao cemitério.\nCuidado: os grupos da escolta vêm juntos e só aparecem durante ela, então não dá para limpar antes nem puxar um de cada vez. Limpar os centauros comuns do caminho antes de começar ajuda.",
	-- {npc:12277} Melizza Brimbuzzle
	["escort {npc:12277} back toward the graveyard"] = "escolte {npc:12277} de volta ao cemitério",

	-- Step 10: Mannoroc Coven
	-- {area:602} Mannoroc Coven · {zone:1443} Desolace
	-- plural, as words: Mana Eaters = {npc:4678} Mana Eater · Ley Hunters = {npc:4685} Ley Hunter · Nether Maidens = {npc:4679} Nether Maiden · Doomwarder Captains = {npc:4680} Doomwarder Captain
	["The demons gather at the {area:602} in southern {zone:1443}: felhounds (Mana Eaters, Mage and Ley Hunters), Nether Maidens and Sisters, and Doomwarder Captains around the pit.\nCareful: Most of the mobs here walk patrol routes, so you can easily pull extra mobs."] = "Os demônios se juntam em {area:602}, no sul de {zone:1443}: canisvis (Manávoros, Caça-magos e Caçadores do Meridiano), Donzelas e Irmãs do Éter, e Capitães dos Guardiões da Ruína em volta do fosso.\nCuidado: a maioria dos monstros daqui faz patrulha, então é fácil puxar monstro a mais.",

	-- Step 11: The Valley of Bones
	-- {area:2657} Valley of Bones
	["The {area:2657}"] = "{area:2657}",
	-- {item:15848} Crate of Ghost Magnets
	-- plural, as words: Undead Ravagers = {npc:11561} Undead Ravager · Magrami Spectres = {npc:11560} Magrami Spectre · Magram Necrokhans = {npc:253274} Magram Necrokhan · Magram Necromancers = {npc:253272} Magram Necromancer
	["Undead Ravagers roam the bone fields south of the Magram village, east of the Coven: the arrow leads to their western edge. Then use the {item:15848} at its arrow, on the fields' eastern side, to draw the Magrami Spectres. Careful: Magram Necrokhans and Corpsefeeders (45, elite) walk the bone fields between the two arrows, with Magram Necromancers (42): pull the Ravagers and the spectres to you, away from them."] = "Assoladores Mortos-vivos vagam pelos campos de ossos ao sul da Aldeia Magram, a leste das Ruínas de Mannoroc: a seta leva à borda oeste deles. Depois use o {item:15848} na seta dele, no lado leste dos campos, para atrair os Espectros Magrami. Cuidado: Necrocãs e Come-cadáveres Magram (45, elite) andam pelos campos de ossos entre as duas setas, com Necromantes Magram (42): puxe os Assoladores e os espectros até você, longe deles.",

	-- Step 14: Azore Aldamort
	-- {zone:1443} Desolace · {area:2405} Ethel Rethor · {npc:11863} Azore Aldamort
	["Follow the road west across the north of {zone:1443} to the ruins of {area:2405}. {npc:11863}'s tower stands on the hill there, on the way to the wreck."] = "Siga a estrada para o oeste pelo norte de {zone:1443} até as ruínas de {area:2405}. A torre de {npc:11863} fica no morro dali, a caminho do naufrágio.",

	-- Step 15: Karnitol's Chest
	-- {npc:11863} Azore Aldamort
	["The wrecked ship's chest lies just south-west of {npc:11863}'s tower."] = "O baú do navio naufragado fica logo a sudoeste da torre de {npc:11863}.",

	-- Step 16: Claim Rackmore's Treasure!
	-- {object:177787} Rackmore's Log · {object:35251} Karnitol's Chest
	["{object:177787} lies beside {object:35251}. His silver key drops from the Drysnap crabs around the wreck; the golden one comes from the Slitherblade naga on the north-west coast, next."] = "{object:177787} fica ao lado de {object:35251}. A chave de prata dele cai dos caranguejos Estala-seca ao redor do naufrágio; a dourada vem dos nagas Lâmina Sinuosa na costa noroeste, a seguir.",
	["Underwater"] = "Debaixo d'água",

	-- Step 17: Sar'theris Strand: kill these as you meet them
	-- {area:598} Sar'theris Strand
	["{area:598}: kill these as you meet them"] = "{area:598}: vá matando estes pelo caminho",
	-- {npc:11863} Azore Aldamort · {area:2406} Ranazjar Isle · {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words) · {npc:12369} Lord Kragaru · {quest:6027} Book of the Ancients
	["The Slitherblade naga hold the north-west coast north of {npc:11863}'s tower; Karnitol's satchel lies on the sea floor off it, and any naga can drop Rackmore's golden key. Swim out to {area:2406} off the far northern tip and use the {item:15766} on the {object:177673}: {npc:12369} (38) rises; kill him for the {quest:6027}."] = "Os nagas Lâmina Sinuosa dominam a costa noroeste, ao norte da torre de {npc:11863}; a bolsa de Karnitol está no fundo do mar diante dela, e qualquer naga pode soltar a chave dourada de Rackmore. Nade até {area:2406}, na ponta extrema norte, e use o {item:15766} no {object:177673}: {npc:12369} (38) surge; mate-o para obter {quest:6027}.",
	-- {item:15881} Rackmore's Golden Key
	["{item:15881}, from the Slitherblade naga"] = "{item:15881}, dos nagas Lâmina Sinuosa",
	-- {item:15766} Gem of the Serpent · {object:177673} Serpent Statue (no name in this language: may be words)
	["{item:15766}, on the {object:177673}"] = "{item:15766}, no {object:177673}",

	-- Step 18: Rackmore's Chest
	-- {object:177673} Serpent Statue (no name in this language: may be words)
	["Rackmore's chest lies just south-east of the {object:177673}."] = "O baú de Rackmore fica logo a sudeste do {object:177673}.",

	-- Step 21: Nijel's Point
	-- {area:608} Nijel's Point · {npc:5396} Captain Pentigast · {npc:5638} Kreldig Ungor · {npc:1182} Brother Anton
	["Follow the road north to {area:608}: {npc:5396} stands at its south end, {npc:5638} in the middle, {npc:1182} to the north."] = "Siga a estrada para o norte até {area:608}: {npc:5396} fica na ponta sul, {npc:5638} no meio e {npc:1182} ao norte.",
	-- {npc:5637} Roetten Stonehammer · {zone:1455} Ironforge
	["for {npc:5637} in {zone:1455}: keep it"] = "para {npc:5637} em {zone:1455}: guarde-a",
	-- {npc:3980} Raleigh the Devout · {area:271} Southshore
	["for {npc:3980} in {area:271}: keep it"] = "para {npc:3980} em {area:271}: guarde-a",

	-- Step 22: Fly to Theramore
	["Fly to Theramore"] = "Voe para a Ilha Theramore",
	["The next guide starts in Theramore."] = "O próximo guia começa na Ilha Theramore.",
}
