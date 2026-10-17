-- Chinese (traditional) (zhTW): the guide forever/class/priest/hex-of-weakness-and-shadowguard (forever/class/priest/hex-of-weakness-and-shadowguard.guide).
-- Written by `node tools/polestar.js i18n guides sync zhTW`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (traditional) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (traditional) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["{quest:5652} and {quest:5642}"] = "{quest:5652}與{quest:5642}",
	-- {quest:5652} Hex of Weakness · {quest:5642} Shadowguard
	["The Troll priest spells: {quest:5652} at 10, {quest:5642} at 20."] = "食人妖牧師法術：10級的{quest:5652}，20級的{quest:5642}。",

	-- Step 1: Hex of Weakness
	-- {npc:6018} Ur'kyo · {object:172961} Valley of Spirits · {zone:1454} Orgrimmar · {npc:3706} Tai'jin · {area:362} Razor Hill · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 10, go to {npc:6018} in the {object:172961}, on {zone:1454}'s west side. Priest trainers elsewhere ({npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to him with a quest of the same name."] = "10級時，去{zone:1454}西側{object:172961}找{npc:6018}。其他地方的牧師訓練師（{area:362}的{npc:3706}、{zone:1456}的{npc:3044}）會用同名任務派你去找他。",

	-- Step 2: Shadowguard
	-- {npc:6018} Ur'kyo · {quest:5642} Shadowguard · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff · {zone:1458} Undercity
	["At 20, {npc:6018} teaches {quest:5642}. {npc:3044} in {zone:1456} and Aelthalyste in the {zone:1458} send you to him with a quest of the same name."] = "20級時，{npc:6018}教授{quest:5642}。{zone:1456}的{npc:3044}和{zone:1458}的艾薩萊斯特會用同名任務派你去找他。",
}
