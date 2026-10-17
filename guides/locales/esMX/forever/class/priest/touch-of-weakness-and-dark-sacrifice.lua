-- Spanish (Latin America) (esMX): the guide forever/class/priest/touch-of-weakness-and-dark-sacrifice (forever/class/priest/touch-of-weakness-and-dark-sacrifice.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["{spell:2652} and {quest:5644}"] = "{spell:2652} y {quest:5644}",
	-- {spell:2652} Touch of Weakness · {quest:5644} Dark Sacrifice
	["The Undead priest spells: {spell:2652} at 10, {quest:5644} at 20."] = "Los hechizos de sacerdote no-muerto: {spell:2652} a nivel 10, {quest:5644} a nivel 20.",

	-- Step 1: Touch of Weakness
	-- {npc:4606} Aelthalyste · {zone:1458} Undercity · {object:36070} War Quarter · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {npc:3706} Tai'jin · {area:362} Razor Hill · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 10, go to {npc:4606} in the {zone:1458}'s {object:36070}. Priest trainers elsewhere ({npc:6018} in {zone:1454}, {npc:3706} in {area:362}, {npc:3044} in {zone:1456}) send you to her with a quest of the same name."] = "A nivel 10, ve con {npc:4606} en {object:36070} de {zone:1458}. Los instructores de sacerdote de otros lugares ({npc:6018} en {zone:1454}, {npc:3706} en {area:362}, {npc:3044} en {zone:1456}) te envían con ella mediante una misión del mismo nombre.",

	-- Step 2: Dark Sacrifice
	-- {npc:4606} Aelthalyste · {quest:5644} Dark Sacrifice · {npc:6018} Ur'kyo · {zone:1454} Orgrimmar · {npc:3044} Miles Welsh · {zone:1456} Thunder Bluff
	["At 20, {npc:4606} teaches {quest:5644}. {npc:6018} in {zone:1454} and {npc:3044} in {zone:1456} send you to her with a quest of the same name."] = "A nivel 20, {npc:4606} enseña {quest:5644}. {npc:6018} en {zone:1454} y {npc:3044} en {zone:1456} te envían con ella mediante una misión del mismo nombre.",
}
