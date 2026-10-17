-- Russian (ruRU): the guide forever/class/warrior/haggards-weapons (forever/class/warrior/haggards-weapons.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Haggard's Weapons"] = "Оружие Хаггарда",
	-- {spell:71} Defensive Stance
	["{spell:71} and a one-hand weapon of your choice at 10."] = "{spell:71} и одноручное оружие на выбор на 10-м уровне.",

	-- Step 1: Defensive Stance
	-- {npc:5480} Ilsa Corbin · {object:2100} Old Town · {npc:6089} Harry Burlguard · {npc:6090} Bartleby · {object:2152} Pig and Whistle Tavern
	["{npc:5480} trains warriors in {object:2100}; {npc:6089} and {npc:6090} stand together by the {object:2152} there. {npc:6090} fights you for his mug."] = "{npc:5480} обучает воинов здесь: {object:2100}; {npc:6089} и {npc:6090} стоят вместе у таверны ({object:2152}). {npc:6090} сражается с вами за свою кружку.",

	-- Step 2: Marshal Haggard
	-- {npc:294} Marshal Haggard · {zone:1429} Elwynn Forest · {zone:1453} Stormwind
	["{npc:294}'s house is in eastern {zone:1429}, south of the road from {zone:1453} to Redridge."] = "Дом NPC {npc:294} находится на востоке зоны {zone:1429}, к югу от дороги из города {zone:1453} в Красногорье.",

	-- Step 3: Dead-tooth Jack
	-- {npc:6093} Dead-Tooth Jack · {zone:1429} Elwynn Forest · {npc:294} Marshal Haggard
	["{npc:6093} camps in the far south-east of {zone:1429}, south-east of {npc:294}. He carries the key to the strongbox in his camp."] = "{npc:6093} разбил лагерь на крайнем юго-востоке зоны {zone:1429}, к юго-востоку от NPC {npc:294}. У него ключ от сейфа в его лагере.",
	-- {npc:6093} Dead-Tooth Jack
	["{npc:6093}: his key opens the strongbox"] = "{npc:6093}: его ключ открывает сейф",

	-- Step 4: Back to Marshal Haggard
	-- {npc:294} Marshal Haggard
	["Back to {npc:294}"] = "Вернитесь: {npc:294}",
}
