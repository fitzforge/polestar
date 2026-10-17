-- German (deDE): the guide forever/class/priest/hex-of-weakness-and-shadowguard (forever/class/priest/hex-of-weakness-and-shadowguard.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["{quest:5652} and {quest:5642}"] = "{quest:5652} und {quest:5642}",
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20."] = "Die Priesterzauber der Trolle: {quest:5652} mit 10, {quest:5642} mit 20.",

	-- Step 1: Hex of Weakness
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {npc:3706} Tai'jin · {area:362} Razor Hill · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 10, go to {npc:6018} in the {object:172961}, on {zone:1454}'s west side. Priest trainers elsewhere ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to him with a quest of the same name."] = "Geh mit 10 zu {npc:6018} im {object:172961} auf der Westseite von {zone:1454}. Priesterlehrer anderswo ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) schicken dich mit einer gleichnamigen Quest zu ihm.",

	-- Step 2: Shadowguard
	-- {npc:6018} Ur'kyo · {quest:5642} Shadowguard · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff · {zone:1458} Undercity
	["At 20, {npc:6018} teaches {quest:5642}. {npc:3044} in {zone:1456} and Aelthalyste in the {zone:1458} send you to him with a quest of the same name."] = "Mit 20 lehrt {npc:6018} {quest:5642}. {npc:3044} in {zone:1456} und Aelthalyste in {zone:1458} schicken dich mit einer gleichnamigen Quest zu ihm.",
}
