-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/swift-horse (forever/collectibles/mounts/alliance/swift-horse.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Horse"] = "Резвый конь",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762}: подмастерье",
	-- {npc:4732} Randal Hunter · {npc:384} Katie Hunter · {area:88} Eastvale Logging Camp · {zone:1429} Elwynn Forest · {skill:762} Riding
	["{npc:4732} and {npc:384}'s horse pen are at {area:88} in eastern {zone:1429}. At 60 {npc:4732} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift horse for 200g at level 60."] = "Загон {npc:4732} и {npc:384} — здесь: {area:88}, восток зоны {zone:1429}. На 60-м уровне {npc:4732} обучает навыку {skill:762} уровня «подмастерье» (1 000 з по данным разработчиков Blizzard); по словам Blizzard, изучение верховой езды дает транспорт. Клиент Forever продает каждого резвого коня за 200 з на 60-м уровне.",
	-- {npc:4732} Randal Hunter
	["{npc:4732}, riding trainer"] = "{npc:4732}, учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите масть",
	-- {npc:384} Katie Hunter
	["{npc:384} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:384} продает коней других мастей (по 200 з в клиенте Forever). Купите любой, какой хотите, или ни одного, если вам нравится полученный.",
	-- {item:18776} Swift Palomino
	["{item:18776}, 200g"] = "{item:18776}, 200 з",
	-- {item:18777} Swift Brown Steed
	["{item:18777}, 200g"] = "{item:18777}, 200 з",
	-- {item:18778} Swift White Steed
	["{item:18778}, 200g"] = "{item:18778}, 200 з",
}
