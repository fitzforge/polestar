-- Russian (ruRU): the guide forever/collectibles/mounts/horde/swift-raptor (forever/collectibles/mounts/horde/swift-raptor.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Raptor"] = "Стремительный ящер",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762}: подмастерье",
	-- {npc:7953} Xar'Ti · {npc:7952} Zjolnir · {area:367} Sen'jin Village · {zone:1411} Durotar · {skill:762} Riding
	["{npc:7953} and {npc:7952}'s raptors are in {area:367} on the {zone:1411} coast. At 60 {npc:7953} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift raptor for 200g at level 60."] = "{npc:7953} и ящеры NPC {npc:7952} находятся здесь: {area:367}, на побережье зоны {zone:1411}. На 60-м уровне {npc:7953} обучает навыку {skill:762} (подмастерье; 1000 з. по замыслу разработчиков Blizzard); по словам Blizzard, при изучении верховой езды выдается средство передвижения. Клиент Forever продает каждого стремительного ящера за 200 з. на 60-м уровне.",
	-- {npc:7953} Xar'Ti
	["{npc:7953}, riding trainer"] = "{npc:7953}, учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите цвет",
	-- {npc:7952} Zjolnir
	["{npc:7952} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7952} продает другие цвета (по 200 з. в клиенте Forever). Купите какие хотите или ни одного, если выданный вам ящер вам нравится.",
	-- {item:18788} Swift Blue Raptor
	["{item:18788}, 200g"] = "{item:18788}, 200 з.",
	-- {item:18789} Swift Olive Raptor
	["{item:18789}, 200g"] = "{item:18789}, 200 з.",
	-- {item:18790} Swift Orange Raptor
	["{item:18790}, 200g"] = "{item:18790}, 200 з.",
	-- {item:46102} Whistle of the Venomhide Ravasaur
	["{item:46102} (level 60) is in the Forever client, but its source is not known yet."] = "{item:46102} (60-й уровень) есть в клиенте Forever, но откуда он берется, пока неизвестно.",
}
