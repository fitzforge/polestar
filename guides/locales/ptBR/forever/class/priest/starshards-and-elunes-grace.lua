-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/starshards-and-elunes-grace (forever/class/priest/starshards-and-elunes-grace.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {spell:10797} Starshards · {spell:2651} Elune's Grace
	["{spell:10797} and {spell:2651}"] = "{spell:10797} e {spell:2651}",
	-- {spell:10797} Starshards · {spell:2651} Elune's Grace
	["The Night Elf priest spells: {spell:10797} at 10, {spell:2651} at 20."] = "Os feitiços de sacerdote Elfo Noturno: {spell:10797} no nível 10, {spell:2651} no nível 20.",

	-- Step 1: Stars of Elune
	-- {npc:11401} Priestess Alathea · {npc:3600} Laurna Morninglight · {area:186} Dolanaar · {npc:377} Priestess Josetta · {area:87} Goldshire · {npc:1226} Maxan Anvol · {area:131} Kharanos · {quest:5628} Returning Home
	["At 10, go to {npc:11401} in the Temple of the Moon. Priest trainers elsewhere ({npc:3600} in {area:186}, {npc:377} in {area:87}, {npc:1226} in {area:131}) send you to her with {quest:5628}."] = "No nível 10, vá até {npc:11401} no Templo da Lua. Instrutores de sacerdote de outros lugares ({npc:3600} em {area:186}, {npc:377} em {area:87}, {npc:1226} em {area:131}) mandam você até ela com {quest:5628}.",

	-- Step 2: Elune's Grace
	-- {npc:11401} Priestess Alathea · {quest:5672} Elune's Grace · {npc:376} High Priestess Laurena · {zone:1453} Stormwind · {npc:11406} High Priest Rohan · {zone:1455} Ironforge
	["At 20, {npc:11401} teaches {quest:5672}. {npc:376} in {zone:1453} and {npc:11406} in {zone:1455} send you to her with a quest of the same name."] = "No nível 20, {npc:11401} ensina {quest:5672}. {npc:376} em {zone:1453} e {npc:11406} em {zone:1455} mandam você até ela com uma missão de mesmo nome.",
}
