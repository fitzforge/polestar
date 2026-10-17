-- Russian (ruRU): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773} и {spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "Заклинания жрецов-людей: {quest:94773} на 10-м уровне, {spell:13896} на 20-м.",

	-- Step 1: Divine Grace
	-- {npc:376} High Priestess Laurena · {npc:377} Priestess Josetta · {area:87} Goldshire
	["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "На 10-м уровне идите в Собор Света. Цель: {npc:376}. {npc:377} ({area:87}) отправит вас к ней с одноименным заданием.",

	-- Step 2: Arcane Feedback
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "На 20-м уровне {npc:376} обучает: {spell:13896}. {npc:11406} ({zone:1455}) и {npc:11401} ({zone:1457}) отправят вас к ней с одноименным заданием.",
}
