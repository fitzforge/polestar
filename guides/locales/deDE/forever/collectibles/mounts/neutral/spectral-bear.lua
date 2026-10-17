-- German (deDE): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Geselle)",
	-- {skill:762} Riding
	["The reins need level 60 and Journeyman {skill:762} (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "Die Zügel erfordern Stufe 60 und {skill:762} (Geselle) (Forever-Client). Lerne es beim Reitlehrer deines Volkes; siehe die Reittier-Guides für Stufe 60.",

	-- Step 2: 55 Legacy Points
	["55 Legacy Points"] = "55 Vermächtnispunkte",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the reins are in your bags."] = "Vermächtnispunkte gelten accountweit: Jede Vermächtnisherausforderung (eine Klasse erreicht 25, 45 und 60, Berufe, PvP, Erkunden) bringt einen. Die Fortschrittsleiste gibt {item:281060} bei 15, {npc:268840} bei 25, {item:277717} bei 40 und die Zügel bei 55. Wie die Belohnungen zugestellt werden, ist noch unbekannt (vielleicht per Post); dieses Ziel wird abgehakt, sobald die Zügel in deinen Taschen sind.",
}
