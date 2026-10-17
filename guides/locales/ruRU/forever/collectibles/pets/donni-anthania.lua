-- Russian (ruRU): the guide forever/collectibles/pets/donni-anthania (forever/collectibles/pets/donni-anthania.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {npc:6367} Donni Anthania
	["{npc:6367}'s Cats"] = "Кошки: {npc:6367}",

	-- Step 1: Donni Anthania
	-- {npc:6367} Donni Anthania · {area:87} Goldshire
	["{npc:6367} has a farmhouse north of {area:87}. Each cat carrier costs 40s. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:6367} живет на ферме к северу от места {area:87}. Каждая переноска стоит 40 с. Каждый предмет с питомцем при использовании обучает вас этому спутнику; цели после этого остаются отмеченными.",
	-- {item:8485} Cat Carrier (Bombay)
	["{item:8485}, 40s"] = "{item:8485}, 40 с",
	-- {item:8486} Cat Carrier (Cornish Rex)
	["{item:8486}, 40s"] = "{item:8486}, 40 с",
	-- {item:8487} Cat Carrier (Orange Tabby)
	["{item:8487}, 40s"] = "{item:8487}, 40 с",
	-- {item:8488} Cat Carrier (Silver Tabby)
	["{item:8488}, 40s"] = "{item:8488}, 40 с",
}
