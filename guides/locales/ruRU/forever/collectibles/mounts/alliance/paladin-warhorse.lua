-- Russian (ruRU): the guide forever/collectibles/mounts/alliance/paladin-warhorse (forever/collectibles/mounts/alliance/paladin-warhorse.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Paladin Warhorse"] = "Боевой конь паладина",
	["Your first mount at 40, summoned at will: a paladin buys no horse."] = "Ваш первый транспорт на 40-м уровне, призываемый когда угодно: паладину не нужно покупать коня.",

	-- Step 1: The Tome of Nobility (Ironforge)
	-- {npc:5149} Brandur Ironhammer · {object:32362} Mystic Ward · {npc:6171} Duthorian Rall · {zone:1453} Stormwind · {zone:1455} Ironforge
	["At 40 {npc:5149} in the {object:32362} sends you to {npc:6171} in {zone:1453}'s Cathedral of Light. Take the tram from {zone:1455} to {zone:1453}."] = "На 40-м уровне {npc:5149} ({object:32362}) отправляет вас к персонажу {npc:6171} в Собор Света ({zone:1453}). Поезжайте на метро: {zone:1455} → {zone:1453}.",

	-- Step 2: Summon Warhorse
	-- {npc:6171} Duthorian Rall · {item:6779} Tome of Nobility · {spell:13819} Summon Warhorse
	["{npc:6171} stands in the Cathedral of Light. Turning in the {item:6779} teaches {spell:13819}; Paladins do not buy a mount."] = "{npc:6171} стоит в Соборе Света. Сдав предмет {item:6779}, вы изучите заклинание «{spell:13819}»; паладины не покупают транспорт.",
}
