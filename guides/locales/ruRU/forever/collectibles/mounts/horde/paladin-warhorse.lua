-- Russian (ruRU): the guide forever/collectibles/mounts/horde/paladin-warhorse (forever/collectibles/mounts/horde/paladin-warhorse.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse (Forsaken)"] = "Боевой конь паладина (Отрекшиеся)",
	["Your first mount at 40, summoned at will: a Forsaken paladin buys no horse and pays no riding trainer."] = "Ваш первый транспорт на 40-м уровне, призываемый когда угодно: паладину-отрекшемуся не нужно покупать коня и платить учителю верховой езды.",

	-- Step 1: Report to Danitha
	-- {npc:260093} Garen Largo · {zone:1458} Undercity · {npc:246378} Danitha Morr · {area:16602} Bandarion Keep
	["At 40 {npc:260093}, the paladin trainer in the {zone:1458}, sends you to {npc:246378} at {area:16602}. Train your new spells with him while you are there. Already at {area:16602}? Skip this step: {npc:246378} gives you the mount quest without it."] = "На 40-м уровне {npc:260093}, наставник паладинов в {zone:1458}, отправляет вас к {npc:246378} в {area:16602}. Заодно изучите у него новые заклинания. Уже в {area:16602}? Пропустите этот шаг: {npc:246378} даст задание на коня и без него.",
	-- {npc:260093} Garen Largo
	["{npc:260093}: your level 40 spells"] = "{npc:260093}: заклинания 40-го уровня",

	-- Step 2: Danitha Morr
	-- {area:16602} Bandarion Keep · {area:156} Solliden Farmstead · {zone:1458} Undercity · {area:159} Brill · {npc:246378} Danitha Morr
	["{area:16602} stands on the bluffs in western Tirisfal, north-west of the {area:156}: leave the {zone:1458} and follow the road west past {area:159}. {npc:246378} is inside the keep, upstairs."] = "{area:16602} стоит на утесах на западе Тирисфальских лесов, к северо-западу от {area:156}: выйдите из {zone:1458} и идите по дороге на запад мимо {area:159}. {npc:246378} находится в крепости, наверху.",
	-- {area:16602} Bandarion Keep
	["{area:16602}'s south gate"] = "Южные ворота: {area:16602}",

	-- Step 3: Summon Warhorse
	-- {npc:246378} Danitha Morr · {area:16602} Bandarion Keep · {quest:94971} A Paladin's Steed · {spell:1279399} Summon Warhorse
	["{npc:246378}, upstairs in {area:16602}, offers {quest:94971} at 40: accept it and hand it straight back. It teaches you {spell:1279399} and Apprentice Riding together, so you need no horse and no riding trainer."] = "{npc:246378}, наверху в {area:16602}, предлагает {quest:94971} на 40-м уровне: примите задание и сразу сдайте его. Оно обучает {spell:1279399} и верховой езде одновременно, так что ни конь, ни учитель верховой езды не нужны.",
}
