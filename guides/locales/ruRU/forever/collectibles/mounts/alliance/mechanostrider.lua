-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/mechanostrider (forever/collectibles/mounts/alliance/mechanostrider.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Mechanostrider"] = "Механодолгоног",

	-- Step 1: Learn to ride
	["Learn to ride"] = "Научитесь верховой езде",
	-- {area:189} Steelgrill's Depot · {area:131} Kharanos · {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding
	["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:189} находится чуть восточнее места {area:131}; {npc:7954} стоит рядом с механодолгоногами NPC {npc:7955}. На 40-м уровне {npc:7954} обучает навыку {skill:762} (100 з. по замыслу разработчиков Blizzard), и вместе с навыком вы получаете средство передвижения. Клиент Forever позволяет ездить на них всем расам Альянса.",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}, учитель верховой езды",

	-- Step 2: Pick a colour
	["Pick a colour"] = "Выберите цвет",
	-- {npc:7955} Milli Featherwhistle
	["{npc:7955} sells the other colours (20g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:7955} продает другие цвета (по 20 з. в клиенте Forever). Купите какие хотите или ни одного, если выданный вам механодолгоног вам нравится.",
	-- {item:8563} Red Mechanostrider
	["{item:8563}, 20g"] = "{item:8563}, 20 з.",
	-- {item:8595} Blue Mechanostrider
	["{item:8595}, 20g"] = "{item:8595}, 20 з.",
	-- {item:13321} Green Mechanostrider
	["{item:13321}, 20g"] = "{item:13321}, 20 з.",
	-- {item:13322} Unpainted Mechanostrider
	["{item:13322}, 20g"] = "{item:13322}, 20 з.",
	["Era let only Dwarves and Gnomes ride mechanostriders; the Forever client allows every Alliance race."] = "В Era на механодолгоногах могли ездить только дворфы и гномы; клиент Forever разрешает это всем расам Альянса.",
}
