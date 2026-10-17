-- French (frFR): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `node tools/polestar.js i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Compagnon)",
	-- {skill:762} Riding
	["The reins need level 60 and Journeyman {skill:762} (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "Les rênes demandent le niveau 60 et {skill:762} (Compagnon) (client Forever). Apprenez-la auprès du maître de monte de votre race ; voir les guides de monture du niveau 60.",

	-- Step 2: 55 Legacy Points
	["55 Legacy Points"] = "55 points d'héritage",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the reins are in your bags."] = "Les points d'héritage sont communs au compte : chaque défi d'héritage (une classe atteignant 25, 45 et 60, métiers, JcJ, exploration) en vaut un. La piste de progression donne {item:281060} à 15, {npc:268840} à 25, {item:277717} à 40 et les rênes à 55. Le mode de remise des récompenses n'est pas encore connu (peut-être par courrier) ; cet objectif se coche dès que les rênes sont dans vos sacs.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Spectral Bear"] = "Ours spectral",
}
