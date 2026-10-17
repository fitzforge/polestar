-- Portuguese (Brazil) (ptBR): the guide forever/professions/fishing (forever/professions/fishing.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Learn Fishing
	-- {skill:356} Fishing
	["Learn {skill:356}"] = "Aprenda {skill:356}",
	-- {skill:356} Fishing · {item:6256} Fishing Pole
	["Any {skill:356} trainer of your faction teaches Apprentice {skill:356} (character level 5); the arrow picks the nearest. Buy a {item:6256} from a trade goods or fishing vendor and equip it."] = "Qualquer instrutor de {skill:356} da sua facção ensina {skill:356} Aprendiz (nível de personagem 5); a seta escolhe o mais próximo. Compre uma {item:6256} de um fornecedor de mercadorias ou de pesca e equipe-a.",

	-- Step 2: Fishing: Elwynn Forest (1-50)
	["Fish here until skill 50. Click the bobber when it splashes; every catch can raise the skill."] = "Pesque aqui até a perícia 50. Clique na boia quando ela espirrar água; toda pesca pode aumentar a perícia.",

	-- Step 4: Fishing: Darkshore (1-50)
	-- {area:442} Auberdine
	["{area:442} shore"] = "Costa de {area:442}",

	-- Step 5: Fishing: Durotar (1-50)
	-- {zone:1411} Durotar
	["{zone:1411} coast"] = "Costa de {zone:1411}",

	-- Step 6: Fishing: The Barrens (1-50)
	-- {zone:1413} The Barrens
	["{zone:1413} oasis"] = "Oásis dos {zone:1413}",

	-- Step 7: Fishing: Tirisfal Glades (1-50)
	["Vile Fin shore"] = "Costa dos Pinavil",

	-- Step 8: Journeyman Fishing
	-- {skill:356} Fishing
	["Journeyman {skill:356}"] = "{skill:356} (Profissional)",
	-- {skill:356} Fishing
	["Journeyman {skill:356} raises the cap to 150; it needs skill 50 and character level 10. The arrow picks the nearest {skill:356} trainer of your faction."] = "{skill:356} Profissional eleva o limite para 150; exige perícia 50 e nível de personagem 10. A seta escolhe o instrutor de {skill:356} da sua facção mais próximo.",

	-- Step 9: Fishing: Westfall (50-125)
	["Fish the pools and open water here until skill 125. Pools (floating debris, schools of fish) also drop extra loot."] = "Pesque nos cardumes e em águas abertas aqui até a perícia 125. Os cardumes (destroços flutuantes, bancos de peixes) também dão saque extra.",
	-- {zone:1436} Westfall
	["{zone:1436} coast"] = "Costa de {zone:1436}",

	-- Step 11: Fishing: Darkshore (50-125)
	-- {zone:1439} Darkshore
	["{zone:1439} coast"] = "Costa de {zone:1439}",

	-- Step 14: Expert Fishing
	-- {skill:356} Fishing
	["Expert {skill:356}"] = "{skill:356} (Perito)",
	-- {skill:356} Fishing · {npc:2626} Old Man Heming · {item:16083} Expert Fishing - The Bass and You · {area:35} Booty Bay · {zone:1434} Stranglethorn Vale
	["Expert {skill:356} (cap 225) is a book, not a trainer rank: {npc:2626} sells {item:16083} in {area:35}, at the south tip of {zone:1434}, to both factions. Buy it and read it; it needs skill 125 and level 20."] = "{skill:356} (Perito) (limite 225) é um livro, não um nível de instrutor: {npc:2626} vende {item:16083} em {area:35}, na ponta sul de {zone:1434}, para as duas facções. Compre e leia; exige perícia 125 e nível 20.",
	-- {item:16083} Expert Fishing - The Bass and You · {skill:356} Fishing
	["Buy and read {item:16083} (Expert {skill:356})"] = "Compre e leia {item:16083} ({skill:356} (Perito))",

	-- Step 15: Fishing: Wetlands (125-225)
	["Fish the pools here until skill 225. If fish keep getting away, fish easier water until your skill catches up."] = "Pesque nos cardumes aqui até a perícia 225. Se os peixes continuarem escapando, pesque em águas mais fáceis até sua perícia alcançar.",
	-- {zone:1437} Wetlands
	["{zone:1437} coast"] = "Costa de {zone:1437}",

	-- Step 16: Fishing: Ashenvale (125-225)
	-- {zone:1440} Ashenvale
	["{zone:1440} waters"] = "Águas de {zone:1440}",

	-- Step 18: Fishing: Hillsbrad Foothills (125-225)
	-- {area:287} Hillsbrad
	["{area:287} coast"] = "Costa de {area:287}",

	-- Step 19: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1455} Ironforge
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1455} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} Artífice (limite 300) vem de {npc:12919}, em {zone:1445}. O instrutor de pesca de {zone:1455} manda você até ele; a missão exige perícia 225 e nível 35.",

	-- Step 20: Nat Pagle, Angler Extreme
	-- {skill:356} Fishing · {npc:12919} Nat Pagle · {zone:1445} Dustwallow Marsh · {zone:1454} Orgrimmar
	["Artisan {skill:356} (cap 300) comes from {npc:12919} in {zone:1445}. The fishing trainer in {zone:1454} sends you to him; the quest needs skill 225 and level 35."] = "{skill:356} Artífice (limite 300) vem de {npc:12919}, em {zone:1445}. O instrutor de pesca de {zone:1454} manda você até ele; a missão exige perícia 225 e nível 35.",

	-- Step 21: Nat Pagle
	-- {npc:12919} Nat Pagle
	["{npc:12919} fishes from the shore of a small island off the east coast, south of Theramore."] = "{npc:12919} pesca da margem de uma pequena ilha na costa leste, ao sul de Theramore.",

	-- Step 22: Sar'theris Striker
	-- {area:598} Sar'theris Strand · {zone:1443} Desolace · {item:16968} Sar'theris Striker
	["Fish in {area:598}, the north-west coast of {zone:1443} (Slitherblade naga shore) until you catch a {item:16968}; it only bites there."] = "Pesque em {area:598}, a costa noroeste de {zone:1443} (litoral das nagas Sibilâmina), até pegar uma {item:16968}; ela só morde lá.",

	-- Step 23: Feralas Ahi
	-- {area:2521} Verdantis River · {zone:1444} Feralas · {item:16967} Feralas Ahi
	["Fish in the {area:2521} in {zone:1444} until you catch a {item:16967}; it only bites there."] = "Pesque em {area:2521}, em {zone:1444}, até pegar um {item:16967}; ele só morde lá.",

	-- Step 24: Savage Coast Blue Sailfin
	-- {area:301} Savage Coast · {zone:1434} Stranglethorn Vale · {item:16969} Savage Coast Blue Sailfin
	["Fish in the {area:301}, the north-west shore of {zone:1434} until you catch a {item:16969}; it only bites there."] = "Pesque em {area:301}, a margem noroeste de {zone:1434}, até pegar uma {item:16969}; ela só morde lá.",

	-- Step 25: Misty Reed Mahi Mahi
	-- {area:300} Misty Reed Strand · {zone:1435} Swamp of Sorrows · {item:16970} Misty Reed Mahi Mahi
	["Fish in the {area:300}, the south-east shore of {zone:1435} until you catch a {item:16970}; it only bites there."] = "Pesque em {area:300}, a margem sudeste de {zone:1435}, até pegar um {item:16970}; ele só morde lá.",

	-- Step 26: Nat Pagle
	-- {skill:356} Fishing
	["Artisan {skill:356}"] = "{skill:356} (Artífice)",

	-- Step 27: Fishing: Stranglethorn Vale (225-300)
	-- {area:35} Booty Bay · {item:6530} Nightcrawlers
	["Fish the pools along the coast here (eels, snappers, wreckage) until skill 300. {area:35} sells bait and {item:6530} for a small fishing bonus."] = "Pesque nos cardumes ao longo da costa aqui (enguias, tartarugas, destroços) até a perícia 300. {area:35} vende iscas e {item:6530} para um pequeno bônus de pesca.",
	-- {area:35} Booty Bay
	["{area:35} coast"] = "Costa de {area:35}",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{zone:1413} oasis"] = "Oásis de {zone:1413}",
}
