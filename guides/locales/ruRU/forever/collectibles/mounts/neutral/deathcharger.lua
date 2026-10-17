-- Russian (ruRU): the guide forever/collectibles/mounts/neutral/deathcharger (forever/collectibles/mounts/neutral/deathcharger.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Deathcharger"] = "Смертобег",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (подмастерье)",
	-- {item:13335} Deathcharger's Reins · {skill:762} Riding
	["{item:13335} needs level 60 and Journeyman {skill:762} to ride (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "Для езды ({item:13335}) нужны 60-й уровень и навык {skill:762} уровня подмастерья (клиент Forever). Обучитесь у учителя верховой езды своей расы; см. гайды по транспорту 60-го уровня.",

	-- Step 2: Stratholme: Baron Rivendare
	-- {area:2279} Stratholme · {object:175461} Service Entrance · {object:175440} Elders' Square · {zone:1423} Eastern Plaguelands · {npc:10440} Baron Rivendare
	["{area:2279} is a group of five, level 58-60. The {object:175461} at {object:175440}, in north-western {zone:1423}, leads to the undead side; {npc:10440} waits in the Slaughter House at its end. Our data gives the reins a 0.02% drop chance (pfQuest, Era): one in about five thousand kills. Nothing shows Forever changing it."] = "{area:2279} – подземелье для группы из пяти, 58-60-й уровень. {object:175461} ({object:175440}) на северо-западе зоны {zone:1423} ведет на сторону нежити; {npc:10440} ждет на бойне в ее конце. По нашим данным, шанс выпадения поводьев – 0,02% (pfQuest, Era): примерно одно на пять тысяч убийств. Ничто не указывает, что в Forever это изменилось.",
	-- {object:175461} Service Entrance
	["Stratholme {object:175461}"] = "Стратхольм: {object:175461}",
}
