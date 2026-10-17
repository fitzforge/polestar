-- Russian (ruRU): the guide forever/class/priest/hex-of-weakness-and-shadowguard (forever/class/priest/hex-of-weakness-and-shadowguard.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["{quest:5652} and {quest:5642}"] = "{quest:5652} и {quest:5642}",
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20."] = "Заклинания жрецов-троллей: {quest:5652} на 10-м уровне, {quest:5642} на 20-м.",

	-- Step 1: Hex of Weakness
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {npc:3706} Tai'jin · {area:362} Razor Hill · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 10, go to {npc:6018} in the {object:172961}, on {zone:1454}'s west side. Priest trainers elsewhere ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to him with a quest of the same name."] = "На 10-м уровне идите к NPC {npc:6018} ({object:172961}, западная часть города {zone:1454}). Учителя жрецов в других местах ({npc:3706} — {area:362}, {npc:3044} — {zone:1456}) отправляют вас к нему с одноименным заданием.",

	-- Step 2: Shadowguard
	-- {npc:6018} Ur'kyo · {quest:5642} Shadowguard · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff · {zone:1458} Undercity
	["At 20, {npc:6018} teaches {quest:5642}. {npc:3044} in {zone:1456} and Aelthalyste in the {zone:1458} send you to him with a quest of the same name."] = "На 20-м уровне {npc:6018} обучает заклинанию {quest:5642}. {npc:3044} ({zone:1456}) и Эльталисте ({zone:1458}) отправляют вас к нему с одноименным заданием.",
}
