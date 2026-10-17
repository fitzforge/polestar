-- Portuguese (Brazil) (ptBR): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Haggard's Weapons"] = "Armas de Fadigas",
	-- {spell:71} Defensive Stance
	["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} e uma arma de uma mão à sua escolha no nível 10.",

	-- Step 1: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480} treina guerreiros em {object:2100}; {npc:6089} e {npc:6090} ficam juntos perto da {object:2152} de lá. {npc:6090} luta com você pela caneca dele.",

	-- Step 2: Marshal Haggard
	-- {npc:294} Marshal Haggard · {zone:1429} Elwynn Forest · {zone:1453} Stormwind
	["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "A casa de {npc:294} fica no leste da {zone:1429}, ao sul da estrada de {zone:1453} para Cristarrubra.",

	-- Step 3: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {zone:1429} Elwynn Forest · {npc:294} Marshal Haggard
	["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093} acampa no extremo sudeste da {zone:1429}, a sudeste de {npc:294}. Ele leva a chave do cofre no acampamento dele.",
	-- {npc:6093} Dead-Tooth Jack
	["{npc:6093}: his key opens the strongbox"] = "{npc:6093}: a chave dele abre o cofre",

	-- Step 4: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "De volta a {npc:294}",
}
