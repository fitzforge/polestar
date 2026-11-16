-- Russian (ruRU): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `forge i18n guides sync ruRU`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Russian (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Russian words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: 55 Legacy Points
	["55 Legacy Points"] = "55 очков наследия",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard · {npc:6791} Innkeeper Wiley · {area:392} Ratchet · {zone:1413} Barrens
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one, and every point the account earns counts here, spent or not. The Legacy Challenges guide plans them. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. Claim each one from {npc:6791} at the inn in {area:392}, on the {zone:1413} coast: he offers a \"Legacy Reward\" quest once you have the points."] = "Очки наследия общие для всей учетной записи: каждое испытание наследия (класс, достигший 25, 45 и 60-го уровня, профессии, PvP, исследование) дает одно очко, и здесь засчитывается каждое заработанное учетной записью очко, потраченное или нет. Их планирует гайд «Испытания наследия». Шкала прогресса дает {item:281060} за 15, {npc:268840} за 25, {item:277717} за 40 и поводья за 55. Получайте каждую награду у NPC {npc:6791} в таверне ({area:392}) на побережье зоны {zone:1413}: он предлагает задание «Legacy Reward», когда у вас набирается достаточно очков.",
	-- {npc:6791} Innkeeper Wiley
	["from {npc:6791}"] = "",

	-- Step 2: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762}: подмастерье",
	-- {skill:762} Riding
	["The bear runs at full speed: riding it needs level 60 and Journeyman {skill:762} (Forever client), from your race's riding trainer; see the Level 60 mount guides."] = "Медведь бежит на полной скорости: для езды на нем нужны 60-й уровень и навык {skill:762} (подмастерье; клиент Forever) от учителя верховой езды вашей расы; см. гайды по средствам передвижения 60-го уровня.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Spectral Bear"] = "Призрачный медведь",
}
