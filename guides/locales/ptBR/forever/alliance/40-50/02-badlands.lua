-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Thelsamar
	-- {npc:1573} Gryth Thurden · {object:32372} Great Forge (no name in this language: may be words)
	["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",

	-- Step 2: Hammertoe's Digsite
	-- {zone:1432} Loch Modan · {zone:1418} Badlands · {npc:2860} Sigrun Ironhew
	["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Cavalgue para o sul, saindo de {zone:1432} pelo desfiladeiro até {zone:1418}; {npc:2860} acampa na escavação.",

	-- Step 3: Garek
	-- {npc:2888} Garek · {area:1898} Dustwind Gulch
	["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} acampa sozinho em {area:1898}, a sudeste da escavação.",

	-- Step 4: Agmond's End
	-- {quest:739} Murdaloc
	["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "O esqueleto danificado fica na beira do acampamento dos troggs da Abóbada de Pedra; {quest:739}, o assassino de Agmundo, anda entre os Quebraossos.",

	-- Step 5: Rigglefuzz
	-- {area:1877} Valley of Fangs · {zone:1418} Badlands · {npc:2817} Rigglefuzz
	["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Cavalgue para o oeste até {area:1877}, no meio de {zone:1418}; {npc:2817} acampa ao lado de Martek.",
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["Blue Pearls from Stranglethorn"] = "Pérolas Azuis da Selva do Espinhaço",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "A próxima missão de {npc:2817} não dá experiência: pule.",

	-- Step 6: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Cavalgue para o oeste por {zone:1418} até o acampamento Arrota-pó em {area:342}. {npc:2944} fica no meio, cercado de Caçadores de Serpes e Espancadores.",

	-- Step 7: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Volte a leste até {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "A próxima tarefa de {npc:2888} é uma caçada elite: pule.",

	-- Step 8: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Os Dragonetes Escaldantes fazem ninho na ravina a leste de {npc:2888}; deixe os Guardiões Flâmeos (elite) em paz. {item:4612} cai raramente: pegue se aparecer enquanto você farma.",
	-- {npc:2725} Scalding Whelp · {area:339} Lethlor Ravine · {zone:1418} Badlands
	["grind on {npc:2725} at {area:339}, {zone:1418}"] = "farme {npc:2725} em {area:339}, {zone:1418}",

	-- Step 10: Southshore
	-- {area:144} Thelsamar · {area:271} Southshore · {npc:3980} Raleigh the Devout
	["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Cavalgue para o norte até {area:144} e voe para {area:271}. {npc:3980} prega junto à estalagem.",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "A próxima tarefa de Raul é em {area:796}: pule.",

	-- Step 11: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Saia de {area:271} para o nordeste pela estrada até as {zone:1425}; {area:348} fica logo depois da divisa. {npc:5635} recebe a corte no alto, {quest:1450} cuida do aviário e {npc:7884} fica junto à estalagem.",

	-- Step 12: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} acampa na estrada a leste de {area:348}.",
	-- {npc:5634} Rhapsody Shindigger
	["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "O coquetel de {npc:5634} precisa de ingredientes de Kalimdor: pule.",

	-- Step 13: Witherbark villages
	["Witherbark villages"] = "Aldeias Cascasseca",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "As duas primeiras jaulas ficam juntas na aldeia Cascasseca ao sul de {npc:5634}; a terceira está na aldeia seguinte, a leste. Qualquer troll Cascasseca pode soltar um colar.",

	-- Step 14: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} continua pagando pelos colares: entregue os que sobrarem",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, ao lado do mestre de voo, no alto",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "A próxima tarefa de Garra-de-acha fica para um guia posterior das {zone:1425}.",

	-- Step 15: Menethil Harbor
	["Take the boat to Theramore from the far pier."] = "Pegue o barco para a Ilha Theramore no píer mais distante.",

	-- Step 16: Theramore
	["Theramore"] = "Ilha Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} fica nas docas onde o barco atraca.",

	-- Step 17: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Bruxo: {quest:3631}",
	-- {area:392} Ratchet · {npc:6251} Strahad Farsan
	["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Voe para {area:392}; {npc:6251} ensina na casa junto ao banco. Depois volte voando para a Ilha Theramore.",

	-- Step 18: On to Feathermoon
	["On to Feathermoon"] = "Rumo a Plumaluna",
	-- {area:608} Nijel's Point · {zone:1443} Desolace · {zone:1444} Feralas · {area:1108} Forgotten Coast · {area:1116} Feathermoon Stronghold
	["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Voe para {area:608}, cavalgue para o sul por {zone:1443} até {zone:1444} e siga a estrada até o cais em {area:1108}; o barco atravessa até {area:1116}, onde começa o próximo guia.",
}
