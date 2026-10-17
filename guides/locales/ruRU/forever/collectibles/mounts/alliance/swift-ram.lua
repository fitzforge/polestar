-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/swift-ram (forever/collectibles/mounts/alliance/swift-ram.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Ram"] = "Стремительный баран",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762}: подмастерье",
	-- {area:803} Amberstill Ranch · {area:131} Kharanos · {zone:1432} Loch Modan · {npc:4772} Ultham Ironhorn · {npc:1261} Veron Amberstill · {skill:762} Riding
	["{area:803} is east of {area:131} on the road to {zone:1432}; {npc:4772} stands beside {npc:1261}'s rams. At 60 {npc:4772} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift ram for 200g at level 60."] = "{area:803} находится к востоку от места {area:131}, на дороге в зону {zone:1432}; {npc:4772} стоит рядом с баранами NPC {npc:1261}. На 60-м уровне {npc:4772} обучает навыку {skill:762} (подмастерье; 1000 з. по замыслу разработчиков Blizzard); по словам Blizzard, при изучении верховой езды выдается средство передвижения. Клиент Forever продает каждого стремительного барана за 200 з. на 60-м уровне.",
	-- {npc:4772} Ultham Ironhorn
	["{npc:4772}, riding trainer"] = "{npc:4772}, учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите цвет",
	-- {npc:1261} Veron Amberstill
	["{npc:1261} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:1261} продает другие цвета (по 200 з. в клиенте Forever). Купите какие хотите или ни одного, если выданный вам баран вам нравится.",
	-- {item:18785} Swift White Ram
	["{item:18785}, 200g"] = "{item:18785}, 200 з.",
	-- {item:18786} Swift Brown Ram
	["{item:18786}, 200g"] = "{item:18786}, 200 з.",
	-- {item:18787} Swift Gray Ram
	["{item:18787}, 200g"] = "{item:18787}, 200 з.",
}
