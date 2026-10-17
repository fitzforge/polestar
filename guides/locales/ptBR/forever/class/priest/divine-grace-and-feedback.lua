-- Portuguese (Brazil) (ptBR): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773} e {spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "Os feitiços de sacerdote humano: {quest:94773} no nível 10, {spell:13896} no 20.",

	-- Step 1: Divine Grace
	-- {npc:376} High Priestess Laurena · {npc:377} Priestess Josetta · {area:87} Goldshire
	["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "No nível 10, vá até {npc:376} na Catedral da Luz. {npc:377}, em {area:87}, envia você a ela com uma missão de mesmo nome.",

	-- Step 2: Arcane Feedback
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "No nível 20, {npc:376} ensina {spell:13896}. {npc:11406}, em {zone:1455}, e {npc:11401}, em {zone:1457}, enviam você a ela com uma missão de mesmo nome.",
}
