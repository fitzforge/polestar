-- Russian (ruRU): the guide forever/reputation/thunder-bluff (forever/reputation/thunder-bluff.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Thunder Bluff Reputation"] = "Репутация: Громовой Утес",

	-- Step 1: Rumstag Proudstrider: A Donation of Wool
	-- {npc:14728} Rumstag Proudstrider · {faction:81} Thunder Bluff · {item:14047} Runecloth · {quest:7825} Additional Runecloth
	["{npc:14728} takes cloth for {faction:81} in {faction:81}. The first donations of Wool, Silk, Mageweave and {item:14047} (60 cloth each) are done once and give the most reputation per cloth; after them, {quest:7825} repeats until Exalted. Exalted with another race's city lets you buy that race's mounts. Forever's Legacy Diplomat perk increases reputation gains."] = "{npc:14728} принимает ткань для фракции {faction:81} (место: {faction:81}). Первые пожертвования шерсти, шелкового материала, магической ткани и предмета {item:14047} (по 60 шт.) делаются один раз и дают больше всего репутации за ткань; после них {quest:7825} повторяется до превознесения. Превознесение у города другой расы позволяет покупать транспорт этой расы. Бонус наследия Forever «Дипломат» ускоряет рост репутации.",

	-- Step 2: Wool Cloth
	-- {area:381} Boulder Lode Mine
	-- plural, as words: Venture Co. Enforcers = {npc:3283} Venture Co. Enforcer
	["Venture Co. Enforcers at the {area:381} (level 16-17) drop it here. The Auction House works too."] = "Добыча здесь: {npc:3283} ({area:381}, уровень 16-17). Подойдет и аукцион.",

	-- Step 4: Silk Cloth
	["Kolkar centaur (level 30-33) drop it here. The Auction House works too."] = "Добыча здесь: кентавры из племени Колкар (уровень 30-33). Подойдет и аукцион.",

	-- Step 6: Mageweave Cloth
	["Dunemaul ogres (level 45-48) drop it here. The Auction House works too."] = "Добыча здесь: огры из клана Песчаного Молота (уровень 45-48). Подойдет и аукцион.",

	-- Step 8: Runecloth
	-- {object:92525} Argent Dawn
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Dark Adepts and Shadowmages (level 58-60) drop it here; every Scourge kill here also counts toward the {object:92525} (see that guide). The Auction House works too."] = "Добыча здесь: адепты Тьмы ({npc:8546}) и темные маги (уровень 58-60); каждое убийство Плети здесь также дает репутацию ({object:92525}, см. тот гайд). Подойдет и аукцион.",

	-- Step 9: Rumstag Proudstrider: Runecloth delivered
	-- {npc:14728} Rumstag Proudstrider · {item:14047} Runecloth
	["{npc:14728}: {item:14047} delivered"] = "{npc:14728}: {item:14047} сдано",

	-- Step 10: Additional Runecloth to Honored
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Honored"] = "{quest:7825} до уровня «Уважение»",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["{quest:7825} takes 20 {item:14047} per turn-in and repeats as often as you like. Bring {item:14047} in multiples of 20 and hand them all in at once, one turn-in after another. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "{quest:7825}: 20 шт. ({item:14047}) за сдачу, повторяется сколько угодно. Приносите {item:14047} партиями по 20 и сдавайте все сразу, одну сдачу за другой. {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",

	-- Step 11: Additional Runecloth to Revered
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Revered"] = "{quest:7825} до уровня «Почтение»",
	-- {quest:7825} Additional Runecloth · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7825}, 20 {item:14047} at a time. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Продолжайте сдавать: {quest:7825}, по 20 шт. ({item:14047}). {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",

	-- Step 12: Additional Runecloth to Exalted
	-- {quest:7825} Additional Runecloth
	["{quest:7825} to Exalted"] = "{quest:7825} до уровня «Превознесение»",
	-- {quest:7825} Additional Runecloth · {faction:81} Thunder Bluff · {item:14047} Runecloth · {zone:1423} Eastern Plaguelands
	-- plural, as words: Dark Adepts = {npc:8546} Dark Adept
	["Keep handing in {quest:7825} until {faction:81} is Exalted. {item:14047}: Dark Adepts and Shadowmages (level 58-60) in {zone:1423}, or the Auction House."] = "Сдавайте задание {quest:7825}, пока репутация ({faction:81}) не дойдет до превознесения. {item:14047}: Адепты Тьмы и темные маги (уровень 58-60) – зона {zone:1423}, или аукцион.",
}
