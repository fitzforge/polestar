-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A wand of your school for the 30s: frost, arcane or fire."] = "Uma varinha da sua escola para os níveis 30: gelo, arcano ou fogo.",

	-- Step 1: Journey to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} at the top of the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, no topo do Sacrário dos Teurgos, no {object:2101} de {zone:1453}, manda você até {npc:6546}; Bink, em {zone:1455}, dá a mesma missão.",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {object:173161} Darkbriar Lodge (no name in this language: may be words) · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers in {object:173161}, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, um dos instrutores de magos de {zone:1454}, em {object:173161}, envia você a {npc:6546}; {npc:4568}, em {zone:1458}, e {npc:3048}, em {zone:1456}, dão a mesma missão.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins · {zone:1413} Barrens
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}. Level 38-41 elites roam the east side of her farm, and swimming in passes level 42 Muckshells: come in from the west along the road from the {zone:1413}. Her cottage is no refuge: mobs follow you inside. Take both her quests."] = "{npc:6546}, uma ermitã, mora numa cabana lá no fundo do pântano a oeste de Theramore, logo ao norte de {area:508}. Elites de nível 38-41 andam pelo lado leste do sítio dela, e chegar nadando passa por Conchalodos de nível 42: chegue pelo oeste, pela estrada que vem de {zone:1413}. A cabana dela não é refúgio: os monstros seguem você lá dentro. Pegue as duas missões dela.",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548} passa os dias na pista de corrida em {area:439}, no sudeste de {zone:1441}.",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "Johnson \"Depenado\"",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken pecking around the foot of the race track's lookout tower; at night type /target plucky. Target him and type /beckon (not /chicken or /wave): he turns human for a moment. Talk to him and ask for the phrase. Do not attack him. If he is gone, he is back within 5 minutes."] = "O aprendiz do Tirth é Johnson \"Depenado\", uma galinhazinha cinza ciscando no pé da torre de observação da pista de corrida; à noite, digite /target depenado. Selecione e digite /beckon (não /chicken nem /wave): ele vira humano por um instante. Fale com ele e peça a frase. Não ataque. Se ele sumir, volta em até 5 minutos.",

	-- Step 6: Witherbark trolls and the Bolt Charged Bramble
	-- {item:7272} Bolt Charged Bramble
	["Witherbark trolls and the {item:7272}"] = "Trolls Cascasseca e a {item:7272}",
	-- {area:321} Hammerfall · {item:7273} Witherbark Totem Stick · {area:336} Circle of Outer Binding · {item:7272} Bolt Charged Bramble
	["The Witherbark trolls (level 30-36) hold the villages in south-eastern Arathi and south of {area:321}; every kind of them drops a {item:7273} about two times in five: you need ten. Then go to the {area:336} (the outer one, not the Inner circle). Three elementals (level 33-39) stand around its middle stone: pull them one at a time and clear them first. Stand at the middle stone and use a totem stick; about ten seconds later the {item:7272} forms on the stone: click it. If you die before you pick it up, the bramble and the sticks are lost and you need ten more."] = "Os trolls Cascasseca (nível 30-36) ocupam as aldeias do sudeste de Arathi e ao sul de {area:321}; todo tipo deles deixa cair uma {item:7273} mais ou menos duas vezes a cada cinco: você precisa de dez. Depois vá até {area:336} (o externo, não o círculo Interno). Três elementais (nível 33-39) ficam em volta da pedra do meio: puxe um de cada vez e limpe antes. Fique na pedra do meio e use uma vara totêmica; uns dez segundos depois, a {item:7272} se forma na pedra: clique nela. Se morrer antes de pegar, perde a morácea e as varas e precisa de mais dez.",
	-- {area:336} Circle of Outer Binding
	["at the middle stone of the {area:336}"] = "na pedra do meio de {area:336}",

	-- Step 7: Jade
	-- {npc:6546} Tabetha · {item:1529} Jade · {area:271} Southshore
	-- plural, as words: Torn Fin Coastrunners = {npc:2375} Torn Fin Coastrunner
	["{npc:6546} also wants one {item:1529}, a green gem. Miners sometimes find one in ore veins; the Auction House sells it; the Torn Fin Coastrunners on the coast south-west of {area:271} drop one about every fifth kill. Do not sell it to a vendor by mistake."] = "{npc:6546} também quer um {item:1529}, uma gema verde. Mineradores às vezes acham um nos veios de minério; a Casa de Leilões vende; os Correcostas Rancapina da costa a sudoeste de {area:271} deixam cair um mais ou menos a cada cinco abates. Não venda para um mercador sem querer.",

	-- Step 8: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan · {item:5535} Compendium of the Fallen
	["Tirth sold the book to the Scarlet Crusade. The {area:796} stands in north-eastern {zone:1420}; take the Library wing with a group of five. The book is in the last long hallway, the one that ends in {npc:6487}'s round room: on the left-hand shelf as you face his room, next to the {item:5535}. Take the thick, highlighted blue book sticking out of the shelf; a magnifying-glass cursor means a book you can only read."] = "O Tirth vendeu o livro para a Cruzada Escarlate. {area:796} fica no nordeste de {zone:1420}; faça a ala da Biblioteca com um grupo de cinco. O livro está no último corredor comprido, o que termina na sala redonda de {npc:6487}: na estante da esquerda, olhando para a sala dele, ao lado do {item:5535}. Pegue o livro azul grosso e destacado saindo da estante; cursor de lupa é livro que só dá para ler.",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951}: Biblioteca do Monastério Escarlate",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "O ritual de {npc:6546}",
	-- {npc:6546} Tabetha
	["Back to {npc:6546}. With both quests handed in she starts the ritual: wait a few seconds, then talk to her again and pick your wand: Icefury (frost), Nether Force (arcane) or Ragefire (fire)."] = "De volta a {npc:6546}. Com as duas missões entregues, ela começa o ritual: espere alguns segundos, fale com ela de novo e escolha a varinha: Fúria Glacial (gelo), Força Etérea (arcano) ou Iraflama (fogo).",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Back to {npc:6546}"] = "De volta a {npc:6546}",
	-- ["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "Os trolls Cascasseca dominam o sudeste de {zone:1417}; qualquer um deles pode deixar cair uma {item:7273}. Depois leve as dez varas para noroeste até o círculo de vinculação, onde elas viram o {item:7272}. {npc:6546} também quer um {item:1529}: compre um numa Casa de Leilões no caminho; mineradores às vezes acham um em Veios de Estanho.",
	-- ["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "Tirth vendeu o livro à Cruzada Escarlate. O {area:796} fica no nordeste de {zone:1420}; entre na ala da Biblioteca. O livro se projeta da parede à esquerda ao entrar no Ateneu, antes de {npc:6487}.",
	-- ["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "O aprendiz de Tirth é Johnson \"Depenado\", uma galinha cinzenta junto à pista de corrida. Selecione-o e digite /chamar: ele vira humano por um instante, tempo suficiente para falar com ele.",
	-- ["Witherbark trolls"] = "Trolls Cascasseca",
	-- ["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, no Santuário do Mago do {object:2101} de {zone:1453}, envia você a {npc:6546}; Bink, em {zone:1455}, dá a mesma missão.",
	-- ["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}, uma eremita, mora num chalé no fundo do pântano a oeste de Theramore, logo ao norte das {area:508}.",
}
