-- French (frFR): the guide forever/class/priest/divine-grace-and-feedback (forever/class/priest/divine-grace-and-feedback.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["{quest:94773} and {spell:13896}"] = "{quest:94773} et {spell:13896}",
	-- {quest:94773} Divine Grace · {spell:13896} Feedback
	["The Human priest spells: {quest:94773} at 10, {spell:13896} at 20."] = "Les sorts de prêtre humain : {quest:94773} au niveau 10, {spell:13896} au niveau 20.",

	-- Step 1: Divine Grace
	-- {npc:376} High Priestess Laurena · {npc:377} Priestess Josetta · {area:87} Goldshire
	["At 10, go to {npc:376} in the Cathedral of Light. {npc:377} in {area:87} sends you to her with a quest of the same name."] = "Au niveau 10, allez voir {npc:376} dans la cathédrale de la Lumière. {npc:377}, à {area:87}, vous envoie la voir avec une quête du même nom.",

	-- Step 2: Arcane Feedback
	-- {npc:376} High Priestess Laurena · {spell:13896} Feedback · {npc:11406} High Priest Rohan · {zone:1455} Ironforge · {npc:11401} Priestess Alathea · {zone:1457} Darnassus
	["At 20, {npc:376} teaches {spell:13896}. {npc:11406} in {zone:1455} and {npc:11401} in {zone:1457} send you to her with a quest of the same name."] = "Au niveau 20, {npc:376} enseigne {spell:13896}. {npc:11406}, à {zone:1455}, et {npc:11401}, à {zone:1457}, vous envoient la voir avec une quête du même nom.",
}
