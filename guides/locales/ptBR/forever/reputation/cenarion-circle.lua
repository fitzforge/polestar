-- Portuguese (Brazil) (ptBR): the guide forever/reputation/cenarion-circle (forever/reputation/cenarion-circle.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Cenarion Circle Reputation"] = "Reputação: Círculo Cenariano",
	-- {zone:1451} Silithus
	["Nature resistance enchants and patterns, badge gear and Forever's new {zone:1451} patterns, from {zone:1451}'s camps."] = "Encantamentos e moldes de resistência à Natureza, equipamento de insígnias e os novos moldes de {zone:1451} do Forever, nos acampamentos de {zone:1451}.",
	-- {zone:1451} Silithus
	["Forever's new {zone:1451} patterns for Tailors, Leatherworkers and Blacksmiths, Friendly and Honored"] = "Os novos moldes de {zone:1451} do Forever para Alfaiates, Coureiros e Ferreiros, em Amigável e Honrado",

	-- Step 1: The emissary in Ironforge
	-- {zone:1455} Ironforge
	["The emissary in {zone:1455}"] = "O emissário em {zone:1455}",
	-- {npc:15187} Cenarion Emissary Jademoon · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15187} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "Opcional, e só necessário para as missões dos Dragataca mais tarde: {npc:15187} envia você a {zone:1451} com {quest:8275}, uma carta de 10 de reputação. Pule se você já estiver em {zone:1451}.",

	-- Step 2: The emissary in Orgrimmar
	-- {zone:1454} Orgrimmar
	["The emissary in {zone:1454}"] = "O emissário em {zone:1454}",
	-- {npc:15188} Cenarion Emissary Blackhoof · {zone:1451} Silithus · {quest:8275} Taking Back Silithus
	["Optional, and needed only for the Dredge quests later: {npc:15188} sends you to {zone:1451} with {quest:8275}, a 10-reputation letter. Skip it if you are already in {zone:1451}."] = "Opcional, e só necessário para as missões dos Dragataca mais tarde: {npc:15188} envia você a {zone:1451} com {quest:8275}, uma carta de 10 de reputação. Pule se você já estiver em {zone:1451}.",

	-- Step 3: Cenarion Hold
	-- {area:3425} Cenarion Hold · {zone:1451} Silithus · {faction:609} Cenarion Circle · {npc:15270} Huum Wildmane · {quest:8318} Secret Communication · {item:20404} Encrypted Twilight Text
	["{area:3425} is the walled druid camp in north-central {zone:1451}, with flight points for both sides. Everyone starts Neutral with the {faction:609} (druids at 2,000 of 3,000). Bor and {npc:15270} stand together in the main building. {quest:8318} opens the {item:20404} turn-ins for good. The Legacy perk Diplomat adds up to 10% to every gain; the numbers in this guide are without it."] = "{area:3425} é o acampamento druida murado no centro-norte de {zone:1451}, com pontos de voo para os dois lados. Todos começam Neutros com o {faction:609} (druidas com 2.000 de 3.000). Bor e {npc:15270} ficam juntos no prédio principal. {quest:8318} abre de vez as entregas de {item:20404}. A vantagem do Legado Diplomata soma até 10% a cada ganho; os números deste guia são sem ela.",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, level 60"] = "{npc:15270}, nível 60",

	-- Step 4: The cultist camp west of Cenarion Hold
	-- {area:3425} Cenarion Hold
	["The cultist camp west of {area:3425}"] = "O acampamento dos sectários a oeste de {area:3425}",
	-- {item:20404} Encrypted Twilight Text · {npc:11804} Twilight Keeper Havunth
	-- plural, as words: Wind Stones = {object:180461} Wind Stone
	["The nearest Twilight's Hammer camp lies just south-west of the Hold. Avengers, Geolords and Stonecallers (level 57 to 59) each drop an {item:20404} about a third of the time, and every cultist kill is 1 reputation. {npc:11804} walks the edge of the camp. Keep every cultist robe, cowl and mantle you loot: they are the Twilight Trappings for the Wind Stones later."] = "O acampamento do Martelo do Crepúsculo mais próximo fica logo a sudoeste do Forte. Vingadores, Geolordes e Evocapedras (nível 57 a 59) soltam um {item:20404} cerca de um terço das vezes, e cada sectário morto vale 1 de reputação. {npc:11804} anda pela borda do acampamento. Guarde toda veste, capucho e dragona de sectário que pegar: são as Vestes do Crepúsculo para as Pedras Eólicas mais tarde.",

	-- Step 5: Back to Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Back to {area:3425}"] = "De volta a {area:3425}",

	-- Step 6: Cultists until the top of Friendly, texts saved
	["Cultists until the top of Friendly, texts saved"] = "Sectários até o topo de Amigável, textos guardados",
	-- {npc:11880} Twilight Avenger · {item:20404} Encrypted Twilight Text · {area:2742} Hive'Ashi · {npc:15308} Twilight Prophet · {npc:15306} Bor Wildmane
	["Neutral to Honored is 9,000 reputation (7,000 for druids). Every {npc:11880}, Geolord, Stonecaller, Master and Overlord gives 1 reputation until 5,999 of 6,000 Friendly, one point short of Honored; there they stop. Save every {item:20404} and leave the quests of the next steps for later: each kill below that point is a free point on top of its text, and the texts and quests pay the same at any standing. A text drops about every third kill, so 30 kills make 30 reputation and 10 texts (100 reputation later). Four camps: south-west of the Hold (39,44), the far west (26,34), the far south-west (19,84) and the north-east below {area:2742} (66,18: Overlords, and Flamereavers that count until the top of Honored). The {npc:15308} (87% text) walks between 18,31 and 23,69. Texts sell on the auction house if you would rather buy. At 5,999 Friendly the last point into Honored comes from a Flamereaver, Twilight Keeper or Marauder, or from your first 10 texts at {npc:15306}."] = "Do Neutro ao Honrado são 9.000 de reputação (7.000 para druidas). Cada {npc:11880}, Geolorde, Evocapedra, Mestre e Overlord dá 1 de reputação até 5.999 de 6.000 em Amigável, um ponto antes de Honrado; ali eles param. Guarde todo {item:20404} e deixe as missões dos próximos passos para depois: cada morte abaixo desse ponto é um ponto grátis além do texto, e os textos e as missões pagam o mesmo em qualquer nível. Um texto cai a cada três mortes, mais ou menos, então 30 mortes dão 30 de reputação e 10 textos (100 de reputação depois). Quatro acampamentos: a sudoeste do Forte (39,44), o extremo oeste (26,34), o extremo sudoeste (19,84) e o nordeste, abaixo de {area:2742} (66,18: Overlords e Ceifachamas, que contam até o topo de Honrado). O {npc:15308} (87% de texto) anda entre 18,31 e 23,69. Os textos também vendem na Casa de Leilões, se preferir comprar. Em 5.999 de Amigável, o último ponto para Honrado vem de um Ceifachamas, Guardião do Crepúsculo ou Saqueador, ou dos seus primeiros 10 textos com {npc:15306}.",
	["Kills alone to the top of Friendly is 8,999 kills (6,999 for druids), but the texts they drop (about 3,000) are worth 30,000 more: most of the way to Exalted."] = "Só com mortes, o topo de Amigável custa 8.999 mortes (6.999 para druidas), mas os textos que elas soltam (cerca de 3.000) valem 30.000 a mais: quase todo o caminho até Exaltado.",
	-- {item:20732} Formula: Enchant Cloak - Greater Fire Resistance · {item:22251} Cenarion Herb Bag · {item:22758} Sylvan Shoulders
	["Friendly (3,000) opens Kania's {item:20732} (10g), Mishta's {item:22251} (2g) and {item:22758} (5g), and Forever's new Friendly gloves patterns (7g 50s)."] = "Amigável (3.000) abre {item:20732} de Kania (10g), {item:22251} e {item:22758} de Mishta (2g e 5g) e os novos moldes de luvas Amigável do Forever (7g 50s).",
	-- {item:20404} Encrypted Twilight Text
	["{item:20404}: save them"] = "{item:20404}: guarde",
	-- {npc:15201} Twilight Flamereaver
	["{npc:15201}: still counts at 5,999 Friendly"] = "{npc:15201}: ainda conta em 5.999 de Amigável",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100, for the last point"] = "{npc:15306}: 10 textos, 100, pelo último ponto",

	-- Step 7: Vyral the Vile
	-- {quest:8321} Vyral the Vile · {area:3446} Twilight's Run · {zone:1451} Silithus
	-- plural, as words: Twilight Masters = {npc:11883} Twilight Master
	["{quest:8321} (level 61, not elite) waits at the back of {area:3446}, the cave in the north-east of {zone:1451}. Flamereavers and Twilight Masters guard the way: the Flamereavers count until the top of Honored, the Masters stop at the top of Friendly like the other cultists."] = "{quest:8321} (nível 61, não elite) espera no fundo de {area:3446}, a caverna no nordeste de {zone:1451}. Ceifachamas e Mestres do Crepúsculo guardam o caminho: os Ceifachamas contam até o topo de Honrado, e os Mestres param no topo de Amigável, como os outros sectários.",

	-- Step 8: Silithus quests at Cenarion Hold
	-- {zone:1451} Silithus · {area:3425} Cenarion Hold
	["{zone:1451} quests at {area:3425}"] = "Missões de {zone:1451} em {area:3425}",
	-- {quest:8280} Securing the Supply Lines · {quest:8275} Taking Back Silithus · {npc:15196} Deathclasp · {npc:15174} Calandrath · {quest:8307} Desert Recipe · {item:20452} Smoked Desert Dumplings · {npc:15189} Beetix Ficklespragg
	["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants. {npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "Agora entregue as missões únicas: cerca de 1.700 de reputação sozinho, 2.400 com as missões em grupo. Elas são de nível 55 a 60, então pagam por inteiro no 60. {quest:8280} exige {quest:8275} antes. {npc:15196} é um escorpídeo elite com dois guardas (grupo de 2 ou 3). {quest:8307} de {npc:15174} é para Cozinheiros: a receita faz o {item:20452} que ele quer. {npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não diferencia os andares.",
	-- {npc:15191} Windcaller Proudhorn · {quest:8275} Taking Back Silithus
	["{npc:15191}, after {quest:8275}"] = "{npc:15191}, depois de {quest:8275}",
	-- {npc:15196} Deathclasp
	["Wanted poster: {npc:15196}, elite"] = "Cartaz de PROCURA-SE: {npc:15196}, elite",
	-- {npc:15174} Calandrath
	["{npc:15174}, for Cooks"] = "{npc:15174}, para Cozinheiros",

	-- Step 9: Around Cenarion Hold
	-- {area:3425} Cenarion Hold
	["Around {area:3425}"] = "Ao redor de {area:3425}",
	-- {object:180503} Sandy Cookbook
	-- plural, as words: Stonelash Scorpids = {npc:11735} Stonelash Scorpid · Sand Skitterers = {npc:11738} Sand Skitterer · Dredge Strikers = {npc:11740} Dredge Striker
	["Stonelash Scorpids and Sand Skitterers roam the sands around the Hold; Dredge Strikers dig north-east of it. The {object:180503} lies in the cultist camp south-west of the Hold."] = "Escorpídeos Petraçoite e Rastejantes da Areia vagam pelas areias ao redor do Forte; os Dragataca cavam a nordeste dele. {object:180503} fica no acampamento dos sectários a sudoeste do Forte.",

	-- Step 10: Back at the Hold
	["Back at the Hold"] = "De volta ao Forte",
	-- {npc:15189} Beetix Ficklespragg
	["{npc:15189} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",

	-- Step 11: Stonelash and Dredge Crushers
	-- plural, as words: Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash and Dredge Crushers"] = "Petraçoite e Dragasmagas",
	-- plural, as words: Stonelash Flayers = {npc:11737} Stonelash Flayer · Rock Stalkers = {npc:11739} Rock Stalker · Dredge Crushers = {npc:11741} Dredge Crusher
	["Stonelash Flayers, Pincers and Rock Stalkers live south and south-west of the Hold; their stingers and fangs drop about one time in ten. Dredge Crushers dig south and west of the Hold."] = "Esfoladores Petraçoite, Pinças e Espreitadoras de Rocha vivem ao sul e sudoeste do Forte; seus ferrões e presas caem cerca de uma vez em dez. Os Dragasmagas cavam ao sul e a oeste do Forte.",
	-- {item:20452} Smoked Desert Dumplings · {object:180503} Sandy Cookbook
	["{item:20452}, from the {object:180503}"] = "{item:20452}, de {object:180503}",
	-- {item:20452} Smoked Desert Dumplings · {item:20424} Sandworm Meat · {item:3713} Soothing Spices
	["{item:20452}, from {item:20424} and {item:3713}"] = "{item:20452}, de {item:20424} e {item:3713}",

	-- Step 12: Noggle Ficklespragg and Proudhorn
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} and Proudhorn"] = "{npc:15190} e Orgulhochifre",
	-- {npc:15189} Beetix Ficklespragg · {npc:15190} Noggle Ficklespragg
	["{npc:15189} and {npc:15190} stand upstairs in their building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15189} e {npc:15190} ficam no andar de cima do prédio deles: suba por dentro, a seta não distingue os andares.",

	-- Step 13: The Ravaged Twilight Camp
	-- {area:3100} Ravaged Twilight Camp
	["The {area:3100}"] = "{area:3100}",
	-- {zone:1451} Silithus
	-- plural, as words: Twilight Tablet Fragments = {item:20378} Twilight Tablet Fragment
	["The broken camp in the far north-west of {zone:1451}: the Twilight Tablet Fragments lie on the ground among the ruins."] = "O acampamento destruído no extremo noroeste de {zone:1451}: os Fragmentos de Tabuleta do Crepúsculo estão no chão, entre as ruínas.",

	-- Step 14: Larksbane
	["Larksbane"] = "Larksbane",

	-- Step 15: Hermit Ortell
	-- {npc:15194} Hermit Ortell · {zone:1451} Silithus · {quest:8319} Encrypted Twilight Texts · {quest:8349} Bor Wildmane
	["{npc:15194} hides in the hills of eastern {zone:1451}. He also decodes {quest:8319} for a chance at a scroll of beckoning, but {quest:8349} pays the reputation: keep the texts for Bor."] = "{npc:15194} se esconde nas colinas do leste de {zone:1451}. Ele também decifra {quest:8319} em troca de uma chance de um pergaminho de convocação, mas {quest:8349} é que paga a reputação: guarde os textos para Bor.",

	-- Step 16: The three Twilight Keepers
	["The three Twilight Keepers"] = "Os três Guardiões do Crepúsculo",
	["Each Keeper is a level 60, not elite, alone at a camp edge, and always drops its chapter: Mayna in the far west camp, Havunth in the camp south-west of the Hold, Exeter in the far south-west camp beside the Twilight Lord."] = "Cada Guardião é nível 60, não elite, sozinho na borda de um acampamento, e sempre solta o seu capítulo: Mayna no acampamento do extremo oeste, Havunth no acampamento a sudoeste do Forte, Exeter no acampamento do extremo sudoeste, ao lado do Senhor do Crepúsculo.",

	-- Step 17: Back to Ortell
	["Back to Ortell"] = "De volta a Ortell",

	-- Step 18: Bronzebeard's Encampment
	["Bronzebeard's Encampment"] = "Acampamento Barbabronze",
	-- {zone:1451} Silithus · {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper · {quest:8304} Dearest Natalia · {item:20379} Noggle's Satchel · {npc:15196} Deathclasp · {spell:10101} Knock Away
	["The dwarves' camp in the south of {zone:1451}. Talk {npc:15171} and {npc:15170} through their whole stories for {quest:8304}. {item:20379} lies on the mountain south-east of the camp. {npc:15196} lives up the trail east of the camp: an elite, and his {spell:10101} can throw you off the cliff."] = "O acampamento dos anões no sul de {zone:1451}. Converse com {npc:15171} e {npc:15170} até o fim das histórias deles para {quest:8304}. {item:20379} fica na montanha a sudeste do acampamento. {npc:15196} vive trilha acima, a leste do acampamento: um elite, e o {spell:10101} dele pode jogar você do penhasco.",
	-- {npc:15171} Frankal Stonebridge · {npc:15170} Rutgar Glyphshaper
	["{npc:15171} and {npc:15170}"] = "{npc:15171} e {npc:15170}",
	-- {item:20385} Deathclasp's Pincer
	["{item:20385}, elite: group of 2 or 3"] = "{item:20385}, elite: grupo de 2 ou 3",

	-- Step 19: Back to Cenarion Hold with news
	-- {area:3425} Cenarion Hold
	["Back to {area:3425} with news"] = "De volta a {area:3425} com notícias",
	-- {npc:15190} Noggle Ficklespragg
	["{npc:15190} stands upstairs in his building: go up inside, the arrow cannot tell the floors apart."] = "{npc:15190} fica no andar de cima do prédio dele: suba por dentro, a seta não distingue os andares.",
	["Natalia, elite: group up"] = "Natalia, elite: forme um grupo",

	-- Step 20: Rubbings and brains
	["Rubbings and brains"] = "Marcas e cérebros",
	-- {object:210337} Glyphed Crystal (no name in this language: may be words) · {item:20453} Geologist's Transcription Kit · {area:2742} Hive'Ashi · {area:2743} Hive'Zora · {area:2744} Hive'Regal · {quest:8308} Brann Bronzebeard's Lost Letter
	["Rutgar and Frankal hand out the next two quests at their camp. Each hive has a {object:210337} to rub with the {item:20453}, and its silithid drop the brains: {area:2742} north of the Hold, {area:2743} in the west, {area:2744} in the south. Inside {area:2744} waits Mistress Natalia (level 62 elite, mind control and fear; group of 3 to 5). Now and then a hive silithid drops {quest:8308}: it starts a quest for Rutgar worth 100."] = "Rutgar e Frankal passam as duas próximas missões no acampamento deles. Cada colmeia tem {object:210337} para esfregar com o {item:20453}, e seus silitídeos soltam os cérebros: {area:2742} ao norte do Forte, {area:2743} a oeste, {area:2744} ao sul. Dentro de {area:2744} está a Senhora Natalia (elite nível 62, controle mental e medo; grupo de 3 a 5). De vez em quando um silitídeo da colmeia larga {quest:8308}: ele inicia uma missão para Rutgar que vale 100.",
	-- {item:20456} Hive'Regal Rubbing · {area:2744} Hive'Regal
	["{item:20456}, deep in {area:2744}"] = "{item:20456}, no fundo de {area:2744}",
	-- {quest:8308} Brann Bronzebeard's Lost Letter
	["{quest:8308}, a rare drop"] = "{quest:8308}, saque raro",

	-- Step 21: Mistress Natalia
	["Mistress Natalia"] = "Senhora Natalia",
	-- {area:2744} Hive'Regal · {zone:1451} Silithus
	["Optional: Natalia waits deep in {area:2744}, the hive in the south of {zone:1451}. She is a level 62 elite who mind-controls, fears and heals herself below half health: bring a group of 3 to 5 and interrupt her heals."] = "Opcional: Natalia fica no fundo de {area:2744}, a colmeia no sul de {zone:1451}. Ela é uma elite nível 62 que controla mentes, causa medo e se cura abaixo de metade da vida: leve um grupo de 3 a 5 e interrompa as curas dela.",
	["Mistress Natalia: group of 3 to 5"] = "Senhora Natalia: grupo de 3 a 5",

	-- Step 22: The Calling
	-- {quest:8314} Unraveling the Mystery · {quest:8315} The Calling · {npc:15183} Geologist Larksbane · {area:3257} Bones of Grakkarond · {npc:14862} Emissary Roman'khan
	["{quest:8314} leads to {quest:8315}: {npc:15183} sends you to the {area:3257} to summon {npc:14862}, a level 63 boss for a raid of about 20. Take it only with a raid."] = "{quest:8314} leva a {quest:8315}: {npc:15183} envia você a {area:3257} para invocar {npc:14862}, um chefe nível 63 para um raide de cerca de 20. Só faça com um raide.",
	["raid of 20"] = "raide de 20",
	-- {item:20465} Crystal Unlocking Mechanism · {npc:14862} Emissary Roman'khan
	["{item:20465}, {npc:14862}: raid of 20"] = "{item:20465}, {npc:14862}: raide de 20",

	-- Step 23: The New Frontier, Thunder Bluff
	-- {quest:1123} Rabine Saturna · {npc:10881} Bluff Runner Windstrider · {npc:5769} Arch Druid Hamuul Runetotem · {area:1639} Elder Rise · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:1123}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10881} sends you to {npc:5769} on {area:1639}, who sends you to {quest:1123} in {area:2361}, {zone:1450}."] = "Opcional: a cadeia de {quest:1123} paga 525 de reputação Cenariana em sete missões de nível 55 a 57, por inteiro no 60. {npc:10881} envia você a {npc:5769} em {area:1639}, que envia você a {quest:1123} em {area:2361}, {zone:1450}.",

	-- Step 24: The New Frontier, Darnassus
	-- {quest:6762} Rabine Saturna · {npc:10878} Herald Moonstalker · {npc:3516} Arch Druid Fandral Staghelm · {npc:4217} Mathrengyl Bearwalker · {area:2361} Nighthaven · {zone:1450} Moonglade
	["Optional: {quest:6762}'s chain pays 525 Cenarion reputation over seven quests of level 55 to 57, full at 60. {npc:10878} sends you to {npc:3516}, who sends you to {npc:4217}, who sends you to {quest:6762} in {area:2361}, {zone:1450}."] = "Opcional: a cadeia de {quest:6762} paga 525 de reputação Cenariana em sete missões de nível 55 a 57, por inteiro no 60. {npc:10878} envia você a {npc:3516}, que envia você a {npc:4217}, que envia você a {quest:6762} em {area:2361}, {zone:1450}.",

	-- Step 25: Rabine Saturna
	-- {quest:1123} Rabine Saturna · {area:2361} Nighthaven · {npc:13220} Layo Starstrike · {area:3077} Valor's Rest · {zone:1451} Silithus
	["{quest:1123} lives in {area:2361}. She sends you to {npc:13220} at {area:3077}, the camp in the north-east corner of {zone:1451}."] = "{quest:1123} vive em {area:2361}. Ela envia você a {npc:13220} em {area:3077}, o acampamento no canto nordeste de {zone:1451}.",

	-- Step 26: Southwind Village
	-- {area:2738} Southwind Village · {area:3425} Cenarion Hold · {object:178553} Hive'Ashi Pod
	-- plural, as words: Tortured Druids = {npc:12178} Tortured Druid
	["The Tortured Druids and Sentinels roam the ruins of {area:2738}, south-east of {area:3425}; the {object:178553} sits on the top floor of its wasp-circled tower."] = "Os Druidas Torturados e Sentinelas vagam pelas ruínas de {area:2738}, a sudeste de {area:3425}; {object:178553} fica no último andar da torre, cercada de vespas.",

	-- Step 27: Umber in Nighthaven
	-- {npc:11939} Umber · {area:2361} Nighthaven
	["{npc:11939} in {area:2361}"] = "{npc:11939} em {area:2361}",

	-- Step 28: Quests elsewhere
	["Quests elsewhere"] = "Missões em outros lugares",
	-- {faction:609} Cenarion Circle · {zone:1414} Kalimdor · {npc:10739} Mulgris Deepriver · {zone:1422} Western Plaguelands · {area:2100} Maraudon · {quest:1123} Rabine Saturna · {item:18501} Felvine Shard · {area:2577} Dire Maul
	["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. Forever pays them in full at any level: The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) 75 and 75, Corruption of Earth and Seed ({area:2100}, level 51) 150. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "As outras missões do {faction:609} estão espalhadas por {zone:1414} e pelas Terras Pestilentas. O Forever paga todas por inteiro em qualquer nível: A vida selvagem também sofre ({npc:10739}, {zone:1422}, níveis 54 e 56) 75 e 75, Corrupção da terra e dos grãos ({area:2100}, nível 51) 150. Pedaços de Vinhavil ({quest:1123}, nível 60, a {item:18501} de Alzzin em {area:2577}) paga 150 e o Relicário 100 em qualquer nível.",
	-- {zone:1422} Western Plaguelands · {area:2100} Maraudon
	["Do the {zone:1422} and {area:2100} quests while you level; at 60 they may pay a fraction."] = "Faça as missões de {zone:1422} e {area:2100} enquanto sobe de nível; no 60 elas podem pagar só uma fração.",

	-- Step 29: Encrypted Twilight Texts to Revered
	-- {quest:8319} Encrypted Twilight Texts
	["{quest:8319} to Revered"] = "{quest:8319} até Reverenciado",
	-- {npc:15306} Bor Wildmane · {quest:8319} Encrypted Twilight Texts · {npc:14479} Twilight Lord Everun · {item:20733} Formula: Enchant Cloak - Greater Nature Resistance · {item:22773} Pattern: Sylvan Crown
	["Honored to Revered is 12,000 reputation. {npc:15306} takes 10 {quest:8319} for 100 reputation, again and again, until Exalted: 120 turn-ins (1,200 texts) to Revered without the quests, or about 950 texts after them. Hand in the texts you saved now. The cultists no longer count, but the Flamereavers, Twilight Keepers, Marauders and Templars count until 11,999 of 12,000 Honored, and the {npc:14479} and Prophet until Exalted. Honored opens Kania's {item:20733} (10g), Mishta's {item:22773} (5g) and Forever's new Honored patterns (7g 50s each)."] = "Do Honrado ao Reverenciado são 12.000 de reputação. {npc:15306} aceita 10 {quest:8319} por 100 de reputação, várias vezes, até Exaltado: 120 entregas (1.200 textos) até Reverenciado sem as missões, ou cerca de 950 textos depois delas. Entregue agora os textos que guardou. Os sectários não contam mais, mas os Ceifachamas, Guardiões do Crepúsculo, Saqueadores e Templários contam até 11.999 de 12.000 em Honrado, e o {npc:14479} e o Profeta até Exaltado. Honrado abre {item:20733} de Kania (10g), {item:22773} de Mishta (5g) e os novos moldes Honrado do Forever (7g 50s cada).",
	-- {npc:15306} Bor Wildmane
	["{npc:15306}: 10 texts, 100"] = "{npc:15306}: 10 textos, 100",

	-- Step 30: Field Duty, level 60
	-- {quest:8507} Field Duty
	["{quest:8507}, level 60"] = "{quest:8507}, nível 60",
	-- {npc:15540} Windcaller Kaldon · {area:3425} Cenarion Hold · {quest:8507} Field Duty · {npc:15440} Captain Blackanvil · {area:2743} Hive'Zora · {npc:15612} Krug Skullsplit · {area:2744} Hive'Regal · {item:20809} Tactical Assignment · {item:7936} Ornate Mithril Boots · {npc:15542} Twilight Marauder · {quest:9338} Allegiance to Cenarion Circle
	-- plural, as words: Heavy Runecloth Bandages = {item:14530} Heavy Runecloth Bandage
	["{npc:15540} stands by the moonwell of {area:3425}. {quest:8507} (25 reputation, repeatable) sends you with unsigned papers to your side's captain: {npc:15440}'s Ironforge Brigade outside {area:2743} (Alliance) or {npc:15612}'s Orgrimmar Legion outside {area:2744} (Horde). Use the papers first, then talk to the captain: a level 60 elite silithid attacks; keep the captain alive and he signs. Kaldon then lets you pick a Combat, Logistics or {item:20809}, each holding a random briefing worth 50 reputation and a badge: 30 hive silithid kills (elites), goods such as 30 Heavy Runecloth Bandages or 3 {item:7936}, or one Templar, {npc:15542} or scout report. One badge of each kind buys {quest:9338} at Kaldon: 200 reputation, repeatable. A full round is about 375 reputation."] = "{npc:15540} fica perto do poço da lua de {area:3425}. {quest:8507} (25 de reputação, repetível) envia você com papéis sem assinatura ao capitão do seu lado: a Brigada de Altaforja de {npc:15440} fora de {area:2743} (Aliança) ou a Legião de Orgrimmar de {npc:15612} fora de {area:2744} (Horda). Use os papéis primeiro, depois fale com o capitão: um silitídeo elite nível 60 ataca; mantenha o capitão vivo e ele assina. Kaldon então deixa você escolher um {item:20809} de Combate, Logística ou Tática, cada um com um informe aleatório que vale 50 de reputação e uma insígnia: 30 mortes de silitídeos da colmeia (elites), suprimentos como 30 Bandagens Grossas de Runatrama ou 3 {item:7936}, ou um relatório de Templário, {npc:15542} ou batedor. Uma insígnia de cada tipo compra {quest:9338} com Kaldon: 200 de reputação, repetível. Uma rodada completa vale cerca de 375 de reputação.",
	["Allegiance: one Combat, Logistics and Tactical badge, 200"] = "Lealdade: uma insígnia de Combate, Logística e Tática, 200",
	-- {quest:8800} Cenarion Battlegear · {npc:15176} Vargus
	["{quest:8800}: {npc:15176}'s badge gear"] = "{quest:8800}: equipamento de insígnias de {npc:15176}",

	-- Step 31: Silithyst
	["Silithyst"] = "Silitista",
	-- {quest:9419} Scouring the Desert · {npc:17080} Marshal Bluewall · {area:2743} Hive'Zora · {npc:17079} General Kirika · {area:2744} Hive'Regal
	["Optional, 100 reputation once: {quest:9419}. Your side's camp sits by a hive: {npc:17080}'s by {area:2743} (Alliance), {npc:17079}'s by {area:2744} (Horde). Silithyst rises from glowing geysers around the desert: walk through one, carry the Silithyst to your camp's Silithyst Extractor, then talk to the camp's leader. It is a world PvP objective: players of the other side can take it from you."] = "Opcional, 100 de reputação uma vez: {quest:9419}. O acampamento do seu lado fica junto a uma colmeia: o de {npc:17080} perto de {area:2743} (Aliança), o de {npc:17079} perto de {area:2744} (Horda). A silitista brota de gêiseres brilhantes pelo deserto: passe por um, leve a silitista ao Extrator de Silitista do seu acampamento, depois fale com o líder do acampamento. É um objetivo de JxJ mundial: jogadores do outro lado podem tomá-la de você.",
	["deliver Silithyst at the extractor"] = "entregue a silitista no extrator",

	-- Step 32: Templars and the Abyssal Council
	["Templars and the Abyssal Council"] = "Templários e o Conselho Abissal",
	-- {object:180456} Lesser Wind Stone (no name in this language: may be words) · {item:20513} Abyssal Crest · {quest:8361} Abyssal Contacts · {npc:15270} Huum Wildmane · {quest:8331} Aurel Goldleaf · {item:14344} Large Brilliant Shard · {object:180461} Wind Stone · {item:20514} Abyssal Signet
	["Wearing a full set of Twilight Trappings (cultist Cowl, Mantle and Robe, about 8%, 8% and 6% per cultist) lets you use a {object:180456}: two stand in each of the three western camps. A random Abyssal Templar appears: a level 60 elite for 1 to 3 players, 5 reputation until the top of Honored and an {item:20513} 93% of the time. The summon uses up the set (and later the medallion and ring too), and if the elemental gets away they are gone: summon only when you can win. {quest:8361} pays 100 for the first crest; after that Bor takes 3 crests for 50. From Friendly, {npc:15270} sends you to {quest:8331}: 3 crests and a {item:14344} buy the Medallion of Station that, worn with a set, opens the larger {object:180461} for a Duke (level 62 elite, group of 5; 25 reputation, {item:20514} 85%)."] = "Usar um conjunto completo de Vestes do Crepúsculo (Capucho, Dragonas e Veste de sectário, cerca de 8%, 8% e 6% por sectário) permite usar Pedra Eólica Menor: há duas em cada um dos três acampamentos do oeste. Um Templário Abissal aleatório aparece: um elite nível 60 para 1 a 3 jogadores, 5 de reputação até o topo de Honrado e um {item:20513} em 93% das vezes. A invocação consome o conjunto (e depois o medalhão e o anel também), e se o elemental escapar eles se perdem: invoque só quando puder vencer. {quest:8361} paga 100 pelo primeiro brasão; depois disso, Bor aceita 3 brasões por 50. A partir de Amigável, {npc:15270} envia você a {quest:8331}: 3 brasões e um {item:14344} compram o Medalhão de Posto que, usado com um conjunto, abre a {object:180461} maior para um Duque (elite nível 62, grupo de 5; 25 de reputação, {item:20514} em 85%).",
	-- {item:20513} Abyssal Crest
	["{item:20513}: Templar, group of 1 to 3"] = "{item:20513}: Templário, grupo de 1 a 3",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Friendly"] = "{npc:15270}, Amigável",
	-- {item:14344} Large Brilliant Shard
	["3 crests and a {item:14344}: the Medallion of Station"] = "3 brasões e um {item:14344}: o Medalhão de Posto",
	-- {item:20514} Abyssal Signet
	["{item:20514}: Duke, group of 5"] = "{item:20514}: Duque, grupo de 5",

	-- Step 33: Signets and scepters to Exalted
	["Signets and scepters to Exalted"] = "Signos e cetros até Exaltado",
	-- {quest:8363} Abyssal Signets · {npc:15282} Aurel Goldleaf · {item:20515} Abyssal Scepter · {quest:9248} A Humble Offering · {quest:8343} Goldleaf's Discovery · {quest:8341} Lords of the Council · {object:180466} Greater Wind Stone (no name in this language: may be words) · {item:22252} Satchel of Cenarius · {item:22660} Gaea's Embrace · {item:22756} Sylvan Vest · {npc:15176} Vargus
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["Revered to Exalted is 21,000 reputation: 210 text turn-ins (2,100 texts), or less with the rest. From Honored, Bor takes 3 {quest:8363} for 100 (each Duke also gives 25, to Exalted), and {npc:15282} takes one {item:20515} for {quest:9248} (200, once). From Revered, {quest:8343} leads to {quest:8341}: 3 signets and 5 Large Brilliant Shards buy the Ring of Lordship, and set, medallion and ring open the {object:180466} for an Abyssal Lord: a level 63 boss for a raid of about 20, 50 reputation, and an {item:20515}. Bor pays 200 for the first scepter and 150 for each 3 after. Revered opens Mishta's {item:22252} (5g), {item:22660} (9g) and {item:22756} (5g); Exalted is the standing for Champion's Battlegear at {npc:15176}."] = "De Reverenciado a Exaltado são 21.000 de reputação: 210 entregas de textos (2.100 textos), ou menos com o resto. A partir de Honrado, Bor aceita 3 {quest:8363} por 100 (cada Duque também dá 25, até Exaltado), e {npc:15282} aceita um {item:20515} por {quest:9248} (200, uma vez). A partir de Reverenciado, {quest:8343} leva a {quest:8341}: 3 signos e 5 Estilhaços Brilhantes Grandes compram o Anel de Suserania, e conjunto, medalhão e anel abrem Pedra Eólica Maior para um Senhor Abissal: um chefe nível 63 para um raide de cerca de 20, 50 de reputação e um {item:20515}. Bor paga 200 pelo primeiro cetro e 150 por cada 3 depois. Reverenciado abre {item:22252} (5g), {item:22660} (9g) e {item:22756} (5g) de Mishta; Exaltado é o nível exigido para o Equipamento de Batalha do Campeão com {npc:15176}.",
	["10 texts: 100"] = "10 textos: 100",
	-- {quest:8363} Abyssal Signets
	["3 {quest:8363}: 100, Honored"] = "3 {quest:8363}: 100, Honrado",
	-- {item:20515} Abyssal Scepter
	["{item:20515}: Lord, raid of 20"] = "{item:20515}: Senhor, raide de 20",
	-- {npc:15270} Huum Wildmane
	["{npc:15270}, Revered"] = "{npc:15270}, Reverenciado",
	-- plural, as words: Large Brilliant Shards = {item:14344} Large Brilliant Shard
	["3 signets and 5 Large Brilliant Shards: the Ring of Lordship"] = "3 signos e 5 Estilhaços Brilhantes Grandes: o Anel de Suserania",
	-- {quest:8364} Abyssal Scepters
	["3 {quest:8364}: 150, Revered"] = "3 {quest:8364}: 150, Reverenciado",

	-- Step 34: The Ruins of Ahn'Qiraj, when they open
	-- {area:3454} Ruins of Ahn'Qiraj
	["The {area:3454}, when they open"] = "{area:3454}, quando abrirem",
	-- {area:2737} Scarab Wall · {zone:1451} Silithus · {quest:8791} The Fall of Ossirian · {npc:15185} Brood of Nozdormu · {npc:15498} Windcaller Yessendra · {npc:15500} Keyl Swiftclaw · {npc:15499} Warden Haro · {npc:16091} Dirk Thunderwood · {quest:9023} The Perfect Poison · {item:22217} Kurinnaxx's Venom Sac · {area:19} Zul'Gurub · {npc:15471} Lieutenant General Andorov · {item:22219} Plans: Jagged Obsidian Shield · {item:22191} Obsidian Mail Tunic
	["A 20-player raid behind the {area:2737} in the far south-west of {zone:1451}. A full clear is about 1,600 Cenarion reputation: the trash 3 each until 20,999 of 21,000 Revered, Kurinnaxx, Moam, Buru and Ayamiss 150 each and Ossirian 300, to Exalted. Ossirian's head starts {quest:8791} (200 here and 200 {npc:15185}). Their drops buy the ring (Honored), cloak (Revered) and weapon (Exalted) quests of {npc:15498}, {npc:15500} and {npc:15499} in the Hold, 100 reputation each. {npc:16091} in the Hold pays 100 once for {quest:9023}: {item:22217} from here and Venoxis's from {area:19}. {npc:15471} sells {item:22219} (Revered, 5g) and {item:22191} (Exalted, 8g) inside."] = "Um raide de 20 jogadores atrás de {area:2737}, no extremo sudoeste de {zone:1451}. Uma limpeza completa vale cerca de 1.600 de reputação Cenariana: os lixos 3 cada até 20.999 de 21.000 em Reverenciado, Korinnaxx, Moam, Buru e Ayamiss 150 cada e Ossirian 300, até Exaltado. A cabeça de Ossirian inicia {quest:8791} (200 aqui e 200 com {npc:15185}). Os itens que caem compram as missões de anel (Honrado), manto (Reverenciado) e arma (Exaltado) de {npc:15498}, {npc:15500} e {npc:15499} no Forte, 100 de reputação cada. {npc:16091} no Forte paga 100 uma vez por {quest:9023}: {item:22217} daqui e o de Venoxis em {area:19}. {npc:15471} vende {item:22219} (Reverenciado, 5g) e {item:22191} (Exaltado, 8g) lá dentro.",

	-- Step 35: Venoxis's Venom Sac, Zul'Gurub
	-- {quest:9023} The Perfect Poison · {npc:14507} High Priest Venoxis · {area:19} Zul'Gurub · {zone:1434} Stranglethorn Vale
	["Optional, for {quest:9023}: {npc:14507} is the first boss of {area:19}, a 20-player raid in north-east {zone:1434}."] = "Opcional, para {quest:9023}: {npc:14507} é o primeiro chefe de {area:19}, um raide de 20 jogadores no nordeste de {zone:1434}.",
	-- {item:22216} Venoxis's Venom Sac
	["{item:22216}: raid of 20"] = "{item:22216}: raide de 20",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Abyssal Crests, Abyssal Signets and Abyssal Scepters are repeatable at {npc:15306} once their opening quests are done."] = "Escudos Abissais, Sinetes Abissais e Cetros Abissais podem ser entregues repetidamente a {npc:15306} depois de concluídas as missões iniciais.",
	-- ["Encrypted Twilight Texts repeats: {npc:15306} takes more texts again and again. The cultist camps are the place to farm them."] = "Textos Codificados do Crepúsculo se repete: {npc:15306} aceita mais textos repetidamente. Os acampamentos dos sectários são o lugar para coletá-los.",
	-- ["Encrypted Twilight Texts to Friendly"] = "Textos Codificados do Crepúsculo até Amigável",
	-- ["From here on, the {area:3454} raid and the Abyssal Council turn-ins (crests, signets, scepters) carry most of the reputation."] = "Daqui em diante, a raide {area:3454} e as entregas do Conselho Abissal (escudos, sinetes, cetros) rendem a maior parte da reputação.",
	-- ["Keep farming the Twilight camps. Wearing the Twilight Trappings (the Twilight cultist set plus a Medallion of Station, from {npc:15282}'s Medallion of Station quest) lets you summon Abyssal Templars at the Wind Stones; their Abyssal Crests go to {npc:15306}."] = "Continue caçando nos acampamentos do Crepúsculo. Vestindo o conjunto de Sectário do Crepúsculo (Capucho, Dragonas e Veste de Sectário do Crepúsculo, mais o Medalhão de Posto do Sectário do Crepúsculo, da missão O medalhão de posto de {npc:15282}), você pode invocar templários abissais nas Wind Stones; os Escudos Abissais deles vão para {npc:15306}.",
	-- ["Keep running the {area:3454} and turning in Abyssal Council insignia until Exalted."] = "Continue fazendo {area:3454} e entregando insígnias do Conselho Abissal até Exaltado.",
	-- ["Now cash in the one-time quests: about 1,700 reputation alone, 2,400 with the group quests. They are level 55 to 60, so they pay in full at 60. {quest:8280} needs {quest:8275} first. {npc:15196} is an elite scorpid with two guards (group of 2 or 3). {npc:15174}'s {quest:8307} is for Cooks: its recipe makes the {item:20452} he wants."] = "Agora entregue as missões únicas: cerca de 1.700 de reputação sozinho, 2.400 com as missões em grupo. Elas são de nível 55 a 60, então pagam por inteiro no 60. {quest:8280} exige {quest:8275} antes. {npc:15196} é um escorpídeo elite com dois guardas (grupo de 2 ou 3). {quest:8307} de {npc:15174} é para Cozinheiros: a receita faz o {item:20452} que ele quer.",
	-- ["The {faction:609}'s other quests are spread over {zone:1414} and the Plaguelands. In Classic a quest pays less once it is 6 or more levels below you (a fifth less per level, down to a fifth): at 60, The Wildlife Suffers Too ({npc:10739}, {zone:1422}, levels 54 and 56) would pay 60 and 75 instead of 75 and 75, and Corruption of Earth and Seed ({area:2100}, level 51) 30 instead of 150. Your first turn-in shows which rule Forever uses. Shards of the Felvine ({quest:1123}, level 60, the {item:18501} from Alzzin in {area:2577}) pays 150 and its Reliquary 100 at any level."] = "As outras missões do {faction:609} estão espalhadas por {zone:1414} e pelas Terras Pestilentas. No Classic, uma missão paga menos quando está 6 ou mais níveis abaixo de você (um quinto a menos por nível, até um quinto): no 60, A vida selvagem também sofre ({npc:10739}, {zone:1422}, níveis 54 e 56) pagaria 60 e 75 em vez de 75 e 75, e Corrupção da terra e dos grãos ({area:2100}, nível 51) 30 em vez de 150. Sua primeira entrega mostra qual regra o Forever usa. Pedaços de Vinhavil ({quest:1123}, nível 60, a {item:18501} de Alzzin em {area:2577}) paga 150 e o Relicário 100 em qualquer nível.",
	-- ["Twilight's Hammer cultists hold the camps in western {zone:1451}. {quest:8320} and Stonecallers mix here; any cultist can drop an {item:20404}. Every cultist kill also counts toward the {faction:609}. The Geolords count for {quest:8320} only if you are 60 and took it."] = "Sectários do Martelo do Crepúsculo dominam os acampamentos no oeste de {zone:1451}. {quest:8320} e Petrazes do Crepúsculo se misturam aqui; qualquer sectário pode derrubar um {item:20404}. Cada sectário morto também conta para {faction:609}. Os Geolordes do Crepúsculo só contam para {quest:8320} se você tiver nível 60 e tiver aceitado a missão.",
	-- ["{area:3425} is the walled town in north-central {zone:1451}. Bor and {npc:15270} stand together inside. The {faction:609} starts out Neutral. Forever's Legacy Diplomat perk increases reputation gains."] = "{area:3425} é a cidade murada no centro-norte de {zone:1451}. Bor e {npc:15270} ficam juntos lá dentro. {faction:609} começa em Neutro. A vantagem de Legado Diplomata do Forever aumenta os ganhos de reputação.",
	-- ["{faction:609} to Exalted"] = "{faction:609} até Exaltado",
	-- ["{faction:609} to Honored"] = "{faction:609} até Honrado",
	-- ["{faction:609} to Revered"] = "{faction:609} até Reverenciado",
	-- ["{npc:15306}: Encrypted Twilight Texts"] = "{npc:15306}: Textos Codificados do Crepúsculo",
	-- ["{quest:8320} needs level 60"] = "{quest:8320} exige nível 60",
}
