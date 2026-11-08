-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/mechanostrider (forever/collectibles/mounts/alliance/mechanostrider.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
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
	-- {npc:7954} Binjy Featherwhistle · {npc:7955} Milli Featherwhistle · {skill:762} Riding · {faction:54} Gnomeregan Exiles
	["Steelgrill's Depot is just east of Kharanos; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} to Gnomes for 100g (10% less at Honored with {faction:54}), and it comes with a mechanostrider. Other races learn {skill:762}, with their own first mount, at their own race's riding trainer."] = "",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, riding trainer"] = "{npc:7954}, учитель верховой езды",

	-- Step 2: Mechanostrider Piloting for other races
	["Mechanostrider Piloting for other races"] = "",
	-- {skill:762} Riding · {npc:7954} Binjy Featherwhistle · {faction:54} Gnomeregan Exiles
	["Any Alliance race can buy these mechanostriders, but riding one also takes Mechanostrider Piloting, which only Gnomes get with {skill:762}. {npc:7954} teaches it to other races once they are Exalted with {faction:54} (the Gnomeregan Exiles Reputation guide shows the way). Until then, don't buy a mechanostrider for this character."] = "",
	-- {npc:7954} Binjy Featherwhistle
	["{npc:7954}, Mechanostrider Piloting"] = "",

	-- Step 3: Pick a colour
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
	["In Classic only Dwarves and Gnomes could ride mechanostriders; in Forever every Alliance race can learn Mechanostrider Piloting."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Era let only Dwarves and Gnomes ride mechanostriders; the Forever client allows every Alliance race."] = "В Era на механодолгоногах могли ездить только дворфы и гномы; клиент Forever разрешает это всем расам Альянса.",
	-- ["{area:189} is just east of {area:131}; {npc:7954} stands beside {npc:7955}'s mechanostriders. At 40 {npc:7954} teaches {skill:762} (100g per Blizzard's designers), and learning it gives you a mount. The Forever client lets every Alliance race ride these."] = "{area:189} находится чуть восточнее места {area:131}; {npc:7954} стоит рядом с механодолгоногами NPC {npc:7955}. На 40-м уровне {npc:7954} обучает навыку {skill:762} (100 з. по замыслу разработчиков Blizzard), и вместе с навыком вы получаете средство передвижения. Клиент Forever позволяет ездить на них всем расам Альянса.",
}
