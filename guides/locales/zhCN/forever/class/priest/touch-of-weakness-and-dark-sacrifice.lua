-- Chinese (simplified) (zhCN): the guide forever/class/priest/touch-of-weakness-and-dark-sacrifice (forever/class/priest/touch-of-weakness-and-dark-sacrifice.guide).
-- Written by `node tools/polestar.js i18n guides sync zhCN`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Chinese (simplified) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Chinese (simplified) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["{spell:2652} and {quest:5644}"] = "{spell:2652}与{quest:5644}",
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["The Undead priest spells: {spell:2652} at 10, {quest:5644} at 20."] = "亡灵牧师的法术：10级的{spell:2652}，20级的{quest:5644}。",

	-- Step 1: Touch of Weakness
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {npc:3706} Tai'jin · {area:362} Razor Hill · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 10, go to {npc:4606} in the {zone:1458}'s {object:36070}. Priest trainers elsewhere ({npc:6018} in {zone:1454}, {npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to her with a quest of the same name."] = "10级时，去{zone:1458}的{object:36070}找{npc:4606}。其他地方的牧师训练师（{zone:1454}的{npc:6018}、{area:362}的{npc:3706}、{zone:1456}的{npc:3044}）会用同名任务让你去找她。",

	-- Step 2: Dark Sacrifice
	-- {npc:4606} Aelthalyste · {quest:5644} Dark Sacrifice · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 20, {npc:4606} teaches {quest:5644}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "20级时，{npc:4606}教授{quest:5644}。{zone:1454}的{npc:6018}和{zone:1456}的{npc:3044}会用同名任务让你去找她。",
}
