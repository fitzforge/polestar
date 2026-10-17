-- Spanish (Latin America) (esMX): the guide forever/class/priest/starshards-and-elunes-grace (forever/class/priest/starshards-and-elunes-grace.guide).
-- Written by `node tools/polestar.js i18n guides sync esMX`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Latin America) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Latin America) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10797} Starshards · {spell:2651} Elune's Grace
	["{spell:10797} and {spell:2651}"] = "{spell:10797} y {spell:2651}",
	-- {spell:10797} Starshards · {spell:2651} Elune's Grace
	["The Night Elf priest spells: {spell:10797} at 10, {spell:2651} at 20."] = "Los hechizos de sacerdote elfo de la noche: {spell:10797} a nivel 10, {spell:2651} a nivel 20.",

	-- Step 1: Stars of Elune
	-- {npc:11401} Priestess Alathea · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:1226} Maxan Anvol · {area:131} Kharanos · {quest:5628} Returning Home
	["At 10, go to {npc:11401} in the Temple of the Moon. Priest trainers elsewhere ({npc:3600} in {area:186}, {npc:377} in {area:87}, {npc:1226} in {area:131}) send you to her with {quest:5628}."] = "A nivel 10, ve con {npc:11401} en el Templo de la Luna. Los instructores de sacerdote de otros lugares ({npc:3600} en {area:186}, {npc:377} en {area:87}, {npc:1226} en {area:131}) te envían con ella mediante {quest:5628}.",

	-- Step 2: Elune's Grace
	-- {npc:11401} Priestess Alathea · {quest:5672} Elune's Grace · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 20, {npc:11401} teaches {quest:5672}. {npc:376} in {zone:1453} and {npc:11406} in {zone:1455} send you to her with a quest of the same name."] = "A nivel 20, {npc:11401} enseña {quest:5672}. {npc:376} en {zone:1453} y {npc:11406} en {zone:1455} te envían con ella mediante una misión del mismo nombre.",
}
