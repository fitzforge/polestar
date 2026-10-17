-- Russian (ruRU): the guide forever/reputation/ironforge (forever/reputation/ironforge.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Ironforge Reputation"] = "Репутация: Стальгорн",

	-- Step 1: Mistina Steelshield: A Donation of Wool
	-- {npc:14723} Mistina Steelshield · {faction:47} Ironforge · {item:14047} Runecloth · {quest:7806} Additional Runecloth
	["{npc:14723} takes cloth for {faction:47} in {faction:47}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7806} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14723} принимает ткань для фракции {faction:47} (локация: {faction:47}). Первые пожертвования шерсти, шелкового материала, магической ткани и предмета {item:14047} (по 60 штук) делаются один раз и дают больше всего репутации за единицу ткани; после них {quest:7806} повторяется до превознесения. Превознесение у города другой расы позволяет покупать ее транспорт. Бонус наследия Forever «Дипломат» увеличивает получаемую репутацию.",

	-- Step 2: Wool Cloth
	-- plural, as words: Riverpaw Bandits = {npc:452} Riverpaw Bandit
	["Riverpaw Bandits and Taskmasters (level 16-18) drop it here. The Auction House works too."] = "Бандиты и надсмотрщики из стаи Речной Лапы (уровень 16-18) роняют ее здесь. Также можно купить на аукционе.",

	-- Step 4: Silk Cloth
	["Syndicate Mercenaries at Stromgarde (level 31-32) drop it here. The Auction House works too."] = "Наемники Синдиката у Стромгарда (уровень 31-32) роняют его здесь. Также можно купить на аукционе.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Огры из клана Песчаного Молота (уровень 45-48) роняют ее здесь. Также можно купить на аукционе.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Адепты Тьмы и темные маги (уровень 58-60) роняют его здесь; каждое убийство Плети здесь также идет в зачет фракции {object:92525} (см. тот гайд). Также можно купить на аукционе.",

	-- Step 9: Mistina Steelshield: Runecloth delivered
	-- {npc:14723} Mistina Steelshield · {item:14047} Runecloth
	["{npc:14723}: {item:14047} delivered"] = "{npc:14723}: {item:14047} сдан",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Honored"] = "{quest:7806} — до уважения",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7806} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7806}: 20 шт. {item:14047} за раз, повторяется сколько угодно. Приносите {item:14047} партиями по 20 и сдавайте все сразу, раз за разом. {item:14047}: адепты Тьмы и темные маги (уровень 58-60) в зоне {zone:1423} или аукцион.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Revered"] = "{quest:7806} — до почтения",
	-- {quest:7806} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7806}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Продолжайте сдавать {quest:7806}, по 20 шт. {item:14047}. {item:14047}: адепты Тьмы и темные маги (уровень 58-60) в зоне {zone:1423} или аукцион.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7806} Additional Runecloth
	["{quest:7806} to Exalted"] = "{quest:7806} — до превознесения",
	-- {quest:7806} Additional Runecloth · {faction:47} Ironforge · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7806} until {faction:47} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Продолжайте сдавать {quest:7806}, пока репутация ({faction:47}) не достигнет превознесения. {item:14047}: адепты Тьмы и темные маги (уровень 58-60) в зоне {zone:1423} или аукцион.",
}
