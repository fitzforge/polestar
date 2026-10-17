-- Russian (ruRU): the guide forever/collectibles/pets/musical-gustjumper (forever/collectibles/pets/musical-gustjumper.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Небесный корабль: {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} – стартовый остров небеснорожденных; посетить его может любой. Небесный корабль отправляется с северной стороны места {area:279} примерно каждые пять минут (другой летает с севера от города {zone:1456}; любая фракция может сесть на любой). Пропустите шаг, если вы уже на острове.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Небесный корабль. Цель: {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Небесный корабль: {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} – стартовый остров небеснорожденных; посетить его может любой. Небесный корабль отправляется с утесов к югу от места {area:17045}, к северу от города {zone:1456}, примерно каждые пять минут (другой летает отсюда: {area:279}; любая фракция может сесть на любой). Пропустите шаг, если вы уже на острове.",

	-- Step 3: Sing to the frogs
	["Sing to the frogs"] = "Спойте лягушкам",
	-- {item:268109} Musical Gustjumper
	["Target one of the frogs here and type /sing; a {item:268109} appears. Interact with it to get the pet."] = "Выберите целью одну из лягушек здесь и введите /sing; появится {item:268109}. Взаимодействуйте с ней, чтобы получить питомца.",
}
