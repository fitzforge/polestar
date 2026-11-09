-- Portuguese (Brazil) (ptBR): the guide forever/alliance/40-50/02-badlands (forever/alliance/40-50/02-badlands.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 2: Valley of Fangs
	-- {npc:2817} Rigglefuzz
	-- plural, as words: Blue Pearls = {item:4611} Blue Pearl
	["{npc:2817}: Blue Pearls from Stranglethorn"] = "{npc:2817}: Pérolas Azuis da Selva do Espinhaço",
	-- {npc:2817} Rigglefuzz
	["{npc:2817}'s next quest pays no experience: skip it."] = "A próxima missão de {npc:2817} não dá experiência: pule.",

	-- Step 3: Boss Tho'grun
	-- {zone:1418} Badlands · {area:342} Camp Boff · {npc:2944} Boss Tho'grun
	["Ride west across the {zone:1418} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Cavalgue para o oeste por {zone:1418} até o acampamento Arrota-pó em {area:342}. {npc:2944} fica no meio, cercado de Caçadores de Serpes e Espancadores.",

	-- Step 4: Garek
	-- {area:1898} Dustwind Gulch
	["Ride back east to {area:1898}."] = "Volte a leste até {area:1898}.",
	-- {npc:2888} Garek
	["{npc:2888}'s next task is an elite hunt: skip it."] = "A próxima tarefa de {npc:2888} é uma caçada elite: pule.",

	-- Step 5: Lethlor Ravine
	-- {npc:2888} Garek · {item:4612} Black Drake's Heart
	-- plural, as words: Scalding Whelps = {npc:2725} Scalding Whelp · Scorched Guardians = {npc:2726} Scorched Guardian
	["The Scalding Whelps nest in the ravine east of {npc:2888}; leave the Scorched Guardians (elite) alone. The {item:4612} drops rarely: take it if it comes while you grind."] = "Os Dragonetes Escaldantes fazem ninho na ravina a leste de {npc:2888}; deixe os Guardiões Flâmeos (elite) em paz. {item:4612} cai raramente: pegue se aparecer enquanto você farma.",

	-- Step 7: Into Loch Modan
	-- {zone:1432} Loch Modan
	["Into {zone:1432}"] = "Rumo a {zone:1432}",

	-- Step 8: Ironband's Excavation Site
	-- {zone:1432} Loch Modan
	["Ride north through the pass into {zone:1432} and east along the south shore to Ironband's camp."] = "Cavalgue para o norte pelo desfiladeiro até {zone:1432} e para leste pela margem sul até o acampamento de Bandaferro.",

	-- Step 9: Into Badlands
	-- {zone:1418} Badlands
	["Into {zone:1418}"] = "Rumo a {zone:1418}",

	-- Step 10: Badlands
	-- {area:1517} Uldaman
	["The {area:1517} dig"] = "A escavação de {area:1517}",

	-- Step 11: The Uldaman dig
	-- {area:1517} Uldaman · {zone:1418} Badlands
	["Back through the pass: the Stonevault troggs dig outside {area:1517} at the {zone:1418}' northern edge. The carved urns and the magenta mushroom clusters sit in their caves and tunnels, outside the dungeon itself."] = "De volta pelo desfiladeiro: os Troggs da Abóbada de Pedra escavam fora de {area:1517}, na borda norte de {zone:1418}. As urnas entalhadas e os aglomerados de cogumelos magenta ficam nas cavernas e túneis deles, fora da masmorra.",
	-- {item:8047} Magenta Fungus Cap
	["{item:8047}; below ground"] = "{item:8047}; no subterrâneo",
	-- {object:2743} Carved Stone Urn
	["{object:2743}; below ground"] = "{object:2743}; no subterrâneo",

	-- Step 12: Back to Loch Modan
	-- {zone:1432} Loch Modan
	["Back to {zone:1432}"] = "De volta a {zone:1432}",

	-- Step 13: Ironband's Excavation Site
	["Ride back north to Ironband's camp."] = "Cavalgue de volta para o norte até o acampamento de Bandaferro.",

	-- Step 14: Thelsamar
	-- {area:144} Thelsamar
	["Ride west along the loch to {area:144}."] = "Cavalgue para oeste ao longo do lago até {area:144}.",
	-- {npc:1470} Ghak Healtouch
	["{npc:1470}, below ground"] = "{npc:1470}, no subterrâneo",

	-- Step 15: Fly to Southshore
	-- {area:271} Southshore
	["Fly to {area:271}"] = "Voar para {area:271}",
	-- {area:144} Thelsamar
	["{area:144} flight master"] = "Mestre de voo de {area:144}",

	-- Step 16: Southshore
	-- {npc:3980} Raleigh the Devout
	["{npc:3980} preaches by the inn."] = "{npc:3980} prega junto à estalagem.",
	-- {npc:3980} Raleigh the Devout
	["{npc:3980}, upstairs"] = "{npc:3980}, no andar de cima",
	-- {area:796} Scarlet Monastery
	["Raleigh's next errand is in the {area:796}: skip it."] = "A próxima tarefa de Raul é em {area:796}: pule.",

	-- Step 18: Aerie Peak
	-- {area:271} Southshore · {zone:1425} The Hinterlands · {area:348} Aerie Peak · {npc:5635} Falstad Wildhammer · {quest:1450} Gryphon Master Talonaxe · {npc:7884} Fraggar Thundermantle
	["Ride north-east out of {area:271} on the road into the {zone:1425}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Saia de {area:271} para o nordeste pela estrada até as {zone:1425}; {area:348} fica logo depois da divisa. {npc:5635} recebe a corte no alto, {quest:1450} cuida do aviário e {npc:7884} fica junto à estalagem.",
	-- {quest:1450} Gryphon Master Talonaxe
	["{quest:1450}, inside"] = "{quest:1450}, lá dentro",
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884}, inside"] = "{npc:7884}, lá dentro",
	-- {npc:7744} Innkeeper Thulfram
	["{npc:7744}: the last guide binds here, so this usually ticks at once; below ground"] = "{npc:7744}: o guia anterior vincula a Pedra de Regresso aqui, então isso costuma marcar na hora; no subterrâneo",

	-- Step 19: Rhapsody Shindigger
	-- {npc:5634} Rhapsody Shindigger · {area:348} Aerie Peak
	["{npc:5634} camps on the road east of {area:348}."] = "{npc:5634} acampa na estrada a leste de {area:348}.",

	-- Step 20: Witherbark villages
	["Witherbark villages"] = "Aldeias Cascasseca",
	-- {npc:5634} Rhapsody Shindigger
	["The first two cages stand together in the Witherbark village south of {npc:5634}; the third is in the next village to the east. Every Witherbark troll can drop a necklace."] = "As duas primeiras jaulas ficam juntas na aldeia Cascasseca ao sul de {npc:5634}; a terceira está na aldeia seguinte, a leste. Qualquer troll Cascasseca pode soltar um colar.",

	-- Step 21: Aerie Peak
	-- {npc:7884} Fraggar Thundermantle
	["{npc:7884} keeps paying for necklaces: hand in any extras"] = "{npc:7884} continua pagando pelos colares: entregue os que sobrarem",
	-- {npc:5636} Gryphon Master Talonaxe
	["{npc:5636}, beside the flight master at the top; inside"] = "{npc:5636}, ao lado do mestre de voo, lá no topo; lá dentro",
	-- {zone:1425} The Hinterlands
	["Talonaxe's next task waits for a later {zone:1425} guide."] = "A próxima tarefa de Garra-de-acha fica para um guia posterior das {zone:1425}.",

	-- Step 22: Fly to Menethil Harbor
	-- {area:150} Menethil Harbor
	["Fly to {area:150}"] = "Voe para {area:150}",
	-- {area:348} Aerie Peak
	["{area:348} flight master"] = "Mestre de voo de {area:348}",

	-- Step 24: Theramore
	["Theramore"] = "Ilha Theramore",
	-- {npc:2616} Privateer Groy
	["{npc:2616} stands on the docks where the boat lands."] = "{npc:2616} fica nas docas onde o barco atraca.",
	-- {npc:4944} Captain Garran Vimes
	["{npc:4944}, on the top floor"] = "{npc:4944}, no último andar",
	-- {npc:4968} Lady Jaina Proudmoore
	["{npc:4968}, on the top floor"] = "{npc:4968}, no último andar",
	-- {npc:4794} Morgan Stern
	["{npc:4794}, inside"] = "{npc:4794}, lá dentro",

	-- Step 25: Cortello's Riddle
	-- {area:498} Bloodfen Burrow
	["Inside {area:498}"] = "Dentro de {area:498}",

	-- Step 26: Theramore flight master
	["Theramore flight master"] = "Mestre de voo de Theramore",

	-- Step 28: Warlock: Summon Felsteed
	-- {quest:3631} Summon Felsteed
	["Warlock: {quest:3631}"] = "Bruxo: {quest:3631}",
	-- {zone:1413} Barrens · {area:392} Ratchet · {npc:6251} Strahad Farsan
	["From Theramore, ride north into the {zone:1413} to {area:392}, or fly if you know its flight path. {npc:6251} teaches in the house by the bank."] = "De Theramore, siga para o norte por {zone:1413} até {area:392}, ou voe, se você conhece a rota de voo de lá. {npc:6251} ensina na casa ao lado do banco.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Blue Pearls from Stranglethorn"] = "Pérolas Azuis da Selva do Espinhaço",
	-- ["Fly to {area:392}; {npc:6251} teaches in the house by the bank. Fly back to Theramore afterwards."] = "Voe para {area:392}; {npc:6251} ensina na casa junto ao banco. Depois volte voando para a Ilha Theramore.",
	-- ["Fly to {area:608}, ride south through {zone:1443} into {zone:1444} and follow the road to the dock on the {area:1108}; the boat crosses to {area:1116}, where the next guide starts."] = "Voe para {area:608}, cavalgue para o sul por {zone:1443} até {zone:1444} e siga a estrada até o cais em {area:1108}; o barco atravessa até {area:1116}, onde começa o próximo guia.",
	-- ["Into {area:38}"] = "Rumo a {area:38}",
	-- ["On to Feathermoon"] = "Rumo a Plumaluna",
	-- ["Ride north to {area:144} and fly to {area:271}. {npc:3980} preaches by the inn."] = "Cavalgue para o norte até {area:144} e voe para {area:271}. {npc:3980} prega junto à estalagem.",
	-- ["Ride north-east out of {area:271} on the road into the {area:47}; {area:348} sits just past the border. {npc:5635} holds court at the top, {quest:1450} tends the aviary and {npc:7884} stands by the inn."] = "Saia de {area:271} para o nordeste pela estrada até as {area:47}; {area:348} fica logo depois da divisa. {npc:5635} recebe a corte no alto, {quest:1450} cuida do aviário e {npc:7884} fica junto à estalagem.",
	-- ["Ride south out of {zone:1432} through the pass into the {zone:1418}; {npc:2860} camps at the dig."] = "Cavalgue para o sul, saindo de {zone:1432} pelo desfiladeiro até {zone:1418}; {npc:2860} acampa na escavação.",
	-- ["Ride west across the {area:3} to the Dustbelcher camp at {area:342}. {npc:2944} stands in its middle with Wyrmhunters and Maulers around him."] = "Cavalgue para o oeste por {area:3} até o acampamento Arrota-pó em {area:342}. {npc:2944} fica no meio, cercado de Caçadores de Serpes e Espancadores.",
	-- ["Ride west to the {area:1877} in the middle of the {zone:1418}; {npc:2817} camps beside Martek."] = "Cavalgue para o oeste até {area:1877}, no meio de {zone:1418}; {npc:2817} acampa ao lado de Martek.",
	-- ["Take the boat to Theramore from the far pier."] = "Pegue o barco para a Ilha Theramore no píer mais distante.",
	-- ["Talonaxe's next task waits for a later {area:47} guide."] = "A próxima tarefa de Garra-de-acha fica para um guia posterior das {area:47}.",
	-- ["The battered skeleton lies at the edge of the Stonevault trogg camp; {quest:739}, Agmond's killer, walks among the Bonesnappers."] = "O esqueleto danificado fica na beira do acampamento dos troggs da Abóbada de Pedra; {quest:739}, o assassino de Agmundo, anda entre os Quebraossos.",
	-- ["grind on {npc:2725} at {area:339}, {zone:1418}"] = "farme {npc:2725} em {area:339}, {zone:1418}",
	-- ["{npc:1573}, the {object:32372}"] = "{npc:1573}, {object:32372}",
	-- ["{npc:2888} camps by himself in {area:1898}, south-east of the digsite."] = "{npc:2888} acampa sozinho em {area:1898}, a sudeste da escavação.",
	-- ["{npc:5634}'s cocktail needs parts from Kalimdor: skip it."] = "O coquetel de {npc:5634} precisa de ingredientes de Kalimdor: pule.",
	-- ["{npc:5636}, beside the flight master at the top"] = "{npc:5636}, ao lado do mestre de voo, no alto",
}
