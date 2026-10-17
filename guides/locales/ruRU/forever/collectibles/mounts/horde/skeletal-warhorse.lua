-- Russian (ruRU): the guide forever/collectibles/mounts/horde/skeletal-warhorse (forever/collectibles/mounts/horde/skeletal-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Skeletal Warhorse"] = "Боевой конь-скелет",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (подмастерье)",
	-- {npc:4773} Velma Warnam · {npc:4731} Zachariah Post · {area:159} Brill · {zone:1420} Tirisfal Glades · {skill:762} Riding
	["{npc:4773} and {npc:4731}'s stable are in {area:159}, {zone:1420}. At 60 {npc:4773} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each skeletal warhorse for 200g at level 60."] = "{npc:4773} и конюшня (хозяин: {npc:4731}) – здесь: {area:159}, {zone:1420}. На 60-м уровне {npc:4773} обучает навыку {skill:762} уровня подмастерья (1000з, по словам дизайнеров Blizzard); по данным Blizzard, обучение дает транспорт. В клиенте Forever каждый боевой конь-скелет стоит 200з на 60-м уровне.",
	-- {npc:4773} Velma Warnam
	["{npc:4773}, riding trainer"] = "{npc:4773}, учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите окраску",
	-- {npc:4731} Zachariah Post
	["{npc:4731} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4731} продает другие окраски (по 200з в клиенте Forever). Купите любые или ни одной, если вам нравится полученный транспорт.",
	-- {item:13334} Green Skeletal Warhorse
	["{item:13334}, 200g"] = "{item:13334}, 200з",
	-- {item:18791} Purple Skeletal Warhorse
	["{item:18791}, 200g"] = "{item:18791}, 200з",
	-- {npc:265653} Ochre Skeletal Warhorse
	-- plural, as words: Purple Skeletal Horses = {item:265840} Purple Skeletal Horse
	["The new Forever Green, Dark and Purple Skeletal Horses and the {npc:265653} (level 60) have no known source yet."] = "У новых в Forever коней-скелетов (зеленого, темного и лилового) и у транспорта {npc:265653} (60-й уровень) источник пока неизвестен.",
}
