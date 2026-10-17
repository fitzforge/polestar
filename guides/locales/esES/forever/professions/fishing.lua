-- Spanish (Spain) (esES): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "Aprende {skill:356}",
	-- {skill:356} Fishing · {item:6256} Fishing Pole
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Cualquier instructor de {skill:356} de tu facción enseña {skill:356} de aprendiz (nivel de personaje 5); la flecha elige el más cercano. Compra una {item:6256} a un proveedor de mercancías o de pesca y equípala.",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Pesca aquí hasta 50 de habilidad. Haz clic en el corcho cuando salpique; cada captura puede subir la habilidad.",

	-- Step 4: Fishing: Darkshore (1-50)
	-- {area:442} Auberdine
	["{area:442} shore"] = "Orilla de {area:442}",

	-- Step 5: Fishing: Durotar (1-50)
	-- {zone:1411} Durotar
	["{zone:1411} coast"] = "Costa de {zone:1411}",

	-- Step 6: Fishing: The Barrens (1-50)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "Oasis de {zone:1413}",

	-- Step 7: Fishing: Tirisfal Glades (1-50)
	["Vile Fin shore"] = "Orilla de los Anca Vil",

	-- Step 8: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356} de oficial",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356} de oficial sube el límite a 150; requiere 50 de habilidad y nivel de personaje 10. La flecha elige el instructor de {skill:356} de tu facción más cercano.",

	-- Step 9: Fishing: Westfall (50-125)
	["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Pesca en los bancos y en aguas abiertas aquí hasta 125 de habilidad. Los bancos (restos flotantes, bancos de peces) también dan botín extra.",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "Costa de {zone:1436}",

	-- Step 11: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "Costa de {zone:1439}",

	-- Step 14: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356} de experto",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "{skill:356} de experto (límite 225) es un libro, no un rango de instructor: {npc:2626} vende {item:16083} en {area:35}, en la punta sur de {zone:1434}, a ambas facciones. Cómpralo y léelo; requiere 125 de habilidad y nivel 20.",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "Compra y lee {item:16083} ({skill:356} de experto)",

	-- Step 15: Fishing: Wetlands (125-225)
	["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Pesca en los bancos de aquí hasta 225 de habilidad. Si los peces se te escapan a menudo, pesca en aguas más fáciles hasta que tu habilidad mejore.",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "Costa de {zone:1437}",

	-- Step 16: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "Aguas de {zone:1440}",

	-- Step 18: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "Costa de {area:287}",

	-- Step 19: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} de artesano (límite 300) se consigue con {npc:12919} en {zone:1445}. El instructor de pesca de {zone:1455} te envía con él; la misión requiere 225 de habilidad y nivel 35.",

	-- Step 20: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} de artesano (límite 300) se consigue con {npc:12919} en {zone:1445}. El instructor de pesca de {zone:1454} te envía con él; la misión requiere 225 de habilidad y nivel 35.",

	-- Step 21: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919} pesca desde la orilla de un islote frente a la costa este, al sur de Isla de Theramore.",

	-- Step 22: Sar'theris Striker
	-- {area:598} Sar'theris Strand · {zone:1443} Desolace · {item:16968} Sar'theris Striker
	["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Pesca en {area:598}, la costa noroeste de {zone:1443} (orilla de los nagas Filozante), hasta que captures un {item:16968}; solo pica allí.",

	-- Step 23: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {item:16967} Feralas Ahi
	["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Pesca en {area:2521}, en {zone:1444}, hasta que captures un {item:16967}; solo pica allí.",

	-- Step 24: Savage Coast Blue Sailfin
	-- {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {item:16969} Savage Coast Blue Sailfin
	["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Pesca en {area:301}, la orilla noroeste de {zone:1434}, hasta que captures un {item:16969}; solo pica allí.",

	-- Step 25: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Pesca en {area:300}, la orilla sureste de {zone:1435}, hasta que captures un {item:16970}; solo pica allí.",

	-- Step 26: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356} de artesano",

	-- Step 27: Fishing: Stranglethorn Vale (225-300)
	-- {area:35} Booty Bay · {item:6530} Nightcrawlers
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Pesca en los bancos a lo largo de la costa (anguilas, pargos, restos de naufragio) hasta 300 de habilidad. En {area:35} venden cebo y {item:6530} para una pequeña bonificación de pesca.",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "Costa de {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1413} oasis"] = "Oasis de {zone:1413}",
}
