-- Spanish (Latin America) (esMX): the guide forever/class/priest/hex-of-weakness-and-shadowguard (forever/class/priest/hex-of-weakness-and-shadowguard.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["{quest:5652} and {quest:5642}"] = "{quest:5652} y {quest:5642}",
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20."] = "Los hechizos de sacerdote trol: {quest:5652} a nivel 10 y {quest:5642} a nivel 20.",

	-- Step 1: Hex of Weakness
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {npc:3706} Tai'jin · {area:362} Razor Hill · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 10, go to {npc:6018} in the {object:172961}, on {zone:1454}'s west side. Priest trainers elsewhere ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to him with a quest of the same name."] = "A nivel 10, ve con {npc:6018} en {object:172961}, en el lado oeste de {zone:1454}. Los instructores de sacerdotes de otros lugares ({npc:3706} en {area:362}, {npc:3044} en {zone:1456}) te mandan con él con una misión del mismo nombre.",

	-- Step 2: Shadowguard
	-- {npc:6018} Ur'kyo · {quest:5642} Shadowguard · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff · {zone:1458} Undercity
	["At 20, {npc:6018} teaches {quest:5642}. {npc:3044} in {zone:1456} and Aelthalyste in the {zone:1458} send you to him with a quest of the same name."] = "A nivel 20, {npc:6018} enseña {quest:5642}. {npc:3044} en {zone:1456} y Aelthalyste en {zone:1458} te mandan con él con una misión del mismo nombre.",
}
