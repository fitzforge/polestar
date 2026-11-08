-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/swift-saber (forever/collectibles/mounts/alliance/swift-saber.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Swift Saber"] = "Стремительный саблезуб",

	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (подмастерье)",
	-- {npc:4753} Jartsam · {npc:4730} Lelanai · {faction:69} Darnassus · {skill:762} Riding
	["{npc:4753} and {npc:4730}'s sabers are in the Cenarion Enclave's riding grounds in {faction:69}. At 60 {npc:4753} teaches Journeyman {skill:762} to Night Elves for 1,000g (10% less at Honored with {faction:69}); Blizzard says it comes with a mount. Other races train it at their own race's riding trainer. Each swift saber costs 200g here."] = "",
	-- {npc:4753} Jartsam
	["{npc:4753}, riding trainer"] = "{npc:4753}, учитель верховой езды",

	-- Step 2: Tiger Riding for other races
	-- {skill:762} Riding
	["Tiger {skill:762} for other races"] = "",
	-- {skill:762} Riding · {npc:4753} Jartsam · {faction:69} Darnassus
	["Any Alliance race can buy these sabers, but riding one also takes Tiger Riding, which only Night Elves get with {skill:762}. {npc:4753} teaches it to other races once they are Exalted with {faction:69} (the Darnassus Reputation guide shows the way). Until then, don't buy a saber for this character."] = "",
	-- {npc:4753} Jartsam
	["{npc:4753}, Tiger Riding"] = "",

	-- Step 3: Pick a colour
	["Pick a colour"] = "Выберите окраску",
	-- {npc:4730} Lelanai
	["{npc:4730} sells the other colours (200g each in the Forever client). Buy any you want, or none if the mount you were given is the one you like."] = "{npc:4730} продает другие окраски (по 200з в клиенте Forever). Купите любые или ни одной, если вам нравится полученный транспорт.",
	-- {item:18766} Reins of the Swift Frostsaber
	["{item:18766}, 200g"] = "{item:18766}, 200з",
	-- {item:18767} Reins of the Swift Mistsaber
	["{item:18767}, 200g"] = "{item:18767}, 200з",
	-- {item:18902} Reins of the Swift Stormsaber
	["{item:18902}, 200g"] = "{item:18902}, 200з",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:4753} and {npc:4730}'s sabers are in the {area:1658}'s riding grounds in {zone:1457}. At 60 {npc:4753} teaches Journeyman {skill:762} (1,000g per Blizzard's designers); Blizzard says learning riding grants a mount. The Forever client sells each swift saber for 200g at level 60."] = "{npc:4753} и саблезубы (хозяин: {npc:4730}) – на площадке для верховой езды ({area:1658}, {zone:1457}). На 60-м уровне {npc:4753} обучает навыку {skill:762} уровня подмастерья (1000з, по словам дизайнеров Blizzard); по данным Blizzard, обучение дает транспорт. В клиенте Forever каждый стремительный саблезуб стоит 200з на 60-м уровне.",
}
