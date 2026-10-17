-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/hex-of-weakness-and-shadowguard (forever/class/priest/hex-of-weakness-and-shadowguard.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["{quest:5652} and {quest:5642}"] = "{quest:5652} e {quest:5642}",
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20."] = "Os feitiços de sacerdote troll: {quest:5652} no nível 10, {quest:5642} no 20.",

	-- Step 1: Hex of Weakness
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits (no name in this language: may be words) · {zone:1454} Orgrimmar · {npc:3706} Tai'jin · {area:362} Razor Hill · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 10, go to {npc:6018} in the {object:172961}, on {zone:1454}'s west side. Priest trainers elsewhere ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to him with a quest of the same name."] = "No nível 10, vá até {npc:6018} no {object:172961}, no lado oeste de {zone:1454}. Instrutores de sacerdote de outros lugares ({npc:3706} em {area:362}, {npc:3044} em {zone:1456}) mandam você até ele com uma missão de mesmo nome.",

	-- Step 2: Shadowguard
	-- {npc:6018} Ur'kyo · {quest:5642} Shadowguard · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff · {zone:1458} Undercity
	["At 20, {npc:6018} teaches {quest:5642}. {npc:3044} in {zone:1456} and Aelthalyste in the {zone:1458} send you to him with a quest of the same name."] = "No nível 20, {npc:6018} ensina {quest:5642}. {npc:3044} em {zone:1456} e Aelthalyste em {zone:1458} mandam você até ele com uma missão de mesmo nome.",
}
