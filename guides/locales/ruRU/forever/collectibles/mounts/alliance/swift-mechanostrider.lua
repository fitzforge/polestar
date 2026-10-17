-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/swift-mechanostrider (forever/collectibles/mounts/alliance/swift-mechanostrider.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Mechanostrider"] = "Стремительный механодолгоног",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762}: подмастерье",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 60 {npc:7954} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift mechanostrider for 200g at level 60."] = "{area:189} находится чуть восточнее места {area:131}; {npc:7954} стоит рядом с механодолгоногами NPC {npc:7955}. На 60-м уровне {npc:7954} обучает навыку {skill:762} (подмастерье; 1000 з. по замыслу разработчиков Blizzard); по словам Blizzard, при изучении верховой езды выдается средство передвижения. Клиент Forever продает каждого стремительного механодолгонога за 200 з. на 60-м уровне.",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}, учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите цвет",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955} продает другие цвета (по 200 з. в клиенте Forever). Купите какие хотите или ни одного, если выданный вам механодолгоног вам нравится.",
	-- {item:18772} Swift Green Mechanostrider
	["{item:18772}, 200g"] = "{item:18772}, 200 з.",
	-- {item:18773} Swift White Mechanostrider
	["{item:18773}, 200g"] = "{item:18773}, 200 з.",
	-- {item:18774} Swift Yellow Mechanostrider
	["{item:18774}, 200g"] = "{item:18774}, 200 з.",
}
