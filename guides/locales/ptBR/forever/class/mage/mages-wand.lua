-- Portuguese (Brazil) (ptBR): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, no Santuário do Mago do {object:2101} de {zone:1453}, envia você a {npc:6546}; Bink, em {zone:1455}, dá a mesma missão.",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, um dos instrutores de magos de {zone:1454}, envia você a {npc:6546}; {npc:4568}, em {zone:1458}, e {npc:3048}, em {zone:1456}, dão a mesma missão.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}, uma eremita, mora num chalé no fundo do pântano a oeste de Theramore, logo ao norte das {area:508}.",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548} passa os dias na pista de corrida em {area:439}, no sudeste de {zone:1441}.",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "Johnson \"Depenado\"",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "O aprendiz de Tirth é Johnson \"Depenado\", uma galinha cinzenta junto à pista de corrida. Selecione-o e digite /chamar: ele vira humano por um instante, tempo suficiente para falar com ele.",

	-- Step 6: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan
	["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "Tirth vendeu o livro à Cruzada Escarlate. O {area:796} fica no nordeste de {zone:1420}; entre na ala da Biblioteca. O livro se projeta da parede à esquerda ao entrar no Ateneu, antes de {npc:6487}.",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951}: Biblioteca do Monastério Escarlate",

	-- Step 7: Back to Tabetha
	-- {npc:6546} Tabetha
	["Back to {npc:6546}"] = "De volta a {npc:6546}",

	-- Step 8: Witherbark trolls
	["Witherbark trolls"] = "Trolls Cascasseca",
	-- {zone:1417} Arathi Highlands · {item:7273} Witherbark Totem Stick · {item:7272} Bolt Charged Bramble · {npc:6546} Tabetha · {item:1529} Jade
	-- plural, as words: Tin Veins = {object:1732} Tin Vein
	["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "Os trolls Cascasseca dominam o sudeste de {zone:1417}; qualquer um deles pode deixar cair uma {item:7273}. Depois leve as dez varas para noroeste até o círculo de vinculação, onde elas viram o {item:7272}. {npc:6546} também quer um {item:1529}: compre um numa Casa de Leilões no caminho; mineradores às vezes acham um em Veios de Estanho.",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "O ritual de {npc:6546}",
}
