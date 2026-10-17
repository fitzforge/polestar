-- Spanish (Spain) (esES): the guide forever/class/mage/mages-wand (forever/class/mage/mages-wand.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["A wand of your school for the 30s: frost, arcane or fire."] = "Una varita de tu escuela para los niveles 30: escarcha, arcano o fuego.",

	-- Step 1: Journey to the Marsh (Stormwind)
	-- {npc:5497} Jennea Cannon · {zone:1453} Stormwind · {object:2101} Mage Quarter · {npc:6546} Tabetha · {zone:1455} Ironforge
	["{npc:5497} in the Wizard's Sanctum, {zone:1453}'s {object:2101}, sends you to {npc:6546}; Bink in {zone:1455} gives the same quest."] = "{npc:5497}, en la torre de {object:2101} de {zone:1453}, te envía con {npc:6546}; Bink, en {zone:1455}, da la misma misión.",

	-- Step 2: Journey to the Marsh (Orgrimmar)
	-- {npc:5885} Deino · {zone:1454} Orgrimmar · {npc:6546} Tabetha · {npc:4568} Anastasia Hartwell · {zone:1458} Undercity · {npc:3048} Ursyn Ghull · {zone:1456} Thunder Bluff
	["{npc:5885}, one of {zone:1454}'s mage trainers, sends you to {npc:6546}; {npc:4568} in the {zone:1458} and {npc:3048} in {zone:1456} give the same quest."] = "{npc:5885}, uno de los instructores de magos de {zone:1454}, te envía con {npc:6546}; {npc:4568} en {zone:1458} y {npc:3048} en {zone:1456} dan la misma misión.",

	-- Step 3: Tabetha
	-- {npc:6546} Tabetha · {area:508} Stonemaul Ruins
	["{npc:6546}, a hermit, lives in a cottage deep in the marsh west of Theramore, just north of the {area:508}."] = "{npc:6546}, una ermitaña, vive en una casita en lo hondo del pantano al oeste de Theramore, justo al norte de {area:508}.",

	-- Step 4: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:439} Shimmering Flats · {zone:1441} Thousand Needles
	["{npc:6548} spends his days at the race track in the {area:439}, south-east {zone:1441}."] = "{npc:6548} pasa los días en la pista de carreras de {area:439}, en el sureste de {zone:1441}.",

	-- Step 5: "Plucky" Johnson
	["\"Plucky\" Johnson"] = "\"Desplumado\" Johnson",
	["Tirth's apprentice is \"Plucky\" Johnson, a small grey chicken by the race track. Target him and type /beckon: he turns human for a moment, long enough to talk to him."] = "El aprendiz de Tirth es \"Desplumado\" Johnson, un pollito gris junto a la pista de carreras. Selecciónalo y escribe /llamar: se vuelve humano un momento, lo justo para hablar con él.",

	-- Step 6: Rituals of Power
	-- {area:796} Scarlet Monastery · {zone:1420} Tirisfal Glades · {npc:6487} Arcanist Doan
	["Tirth sold the book to the Scarlet Brotherhood. The {area:796} stands in north-eastern {zone:1420}; take the Library wing. The book juts out of the wall on the left as you enter the Athenaeum, before {npc:6487}."] = "Tirth vendió el libro a los Escarlata. {area:796} está en el noreste de {zone:1420}; entra en el ala de la Biblioteca. El libro sobresale de la pared a la izquierda al entrar en la última sala, antes de {npc:6487}.",
	-- {quest:1951} Rituals of Power
	["{quest:1951}: Scarlet Monastery Library"] = "{quest:1951}: Biblioteca del Monasterio Escarlata",

	-- Step 7: Back to Tabetha
	-- {npc:6546} Tabetha
	["Back to {npc:6546}"] = "Vuelve con {npc:6546}",

	-- Step 8: Witherbark trolls
	["Witherbark trolls"] = "Trols Secacorteza",
	-- {zone:1417} Arathi Highlands · {item:7273} Witherbark Totem Stick · {item:7272} Bolt Charged Bramble · {npc:6546} Tabetha · {item:1529} Jade
	-- plural, as words: Tin Veins = {object:1732} Tin Vein
	["The Witherbark trolls hold south-eastern {zone:1417}; every one of them can drop a {item:7273}. Then take the ten sticks north-west to the binding circle where they become the {item:7272}. {npc:6546} also wants a {item:1529}: buy one at an Auction House on the way; miners sometimes find one in Tin Veins."] = "Los trols Secacorteza ocupan el sureste de {zone:1417}; cualquiera puede soltar un {item:7273}. Luego lleva los diez palos al noroeste, al círculo de vinculación, donde se convierten en la {item:7272}. {npc:6546} también quiere un {item:1529}: compra uno en una casa de subastas por el camino; los mineros a veces lo encuentran en filones de estaño.",

	-- Step 9: Tabetha's ritual
	-- {npc:6546} Tabetha
	["{npc:6546}'s ritual"] = "El ritual de {npc:6546}",
}
