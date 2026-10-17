-- Russian (ruRU): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `node tools/polestar.js i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762}: подмастерье",
	-- {skill:762} Riding
	["The reins need level 60 and Journeyman {skill:762} (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "Для поводьев нужны 60-й уровень и навык {skill:762} (подмастерье; клиент Forever). Изучите его у учителя верховой езды вашей расы; см. гайды по средствам передвижения 60-го уровня.",

	-- Step 2: 55 Legacy Points
	["55 Legacy Points"] = "55 очков наследия",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the reins are in your bags."] = "Очки наследия общие для всей учетной записи: каждое испытание наследия (класс, достигший 25, 45 и 60-го уровня, профессии, PvP, исследование) дает одно очко. Шкала прогресса дает {item:281060} за 15, {npc:268840} за 25, {item:277717} за 40 и поводья за 55. Как выдаются награды, пока неизвестно (возможно, почтой); цель засчитывается, когда поводья окажутся в ваших сумках.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Spectral Bear"] = "Призрачный медведь",
}
