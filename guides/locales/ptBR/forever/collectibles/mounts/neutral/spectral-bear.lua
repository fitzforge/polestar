-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/mounts/neutral/spectral-bear (forever/collectibles/mounts/neutral/spectral-bear.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Journeyman Riding
	-- {skill:762} Riding
	["Journeyman {skill:762}"] = "{skill:762} (Profissional)",
	-- {skill:762} Riding
	["The reins need level 60 and Journeyman {skill:762} (Forever client). Train it at your race's riding trainer; see the Level 60 mount guides."] = "As rédeas requerem nível 60 e {skill:762} (Profissional) (cliente Forever). Treine com o instrutor de montaria da sua raça; veja os guias de montaria de nível 60.",

	-- Step 2: 55 Legacy Points
	["55 Legacy Points"] = "55 Pontos de Legado",
	-- {item:281060} Replica Ironforge Air Rifle · {npc:268840} Spectral Bear Cub · {item:277717} Spectral Bear Tabard
	["Legacy Points are account-wide: each Legacy Challenge (a class reaching 25, 45 and 60, professions, PvP, exploring) is worth one. The Progress Track gives the {item:281060} at 15, the {npc:268840} at 25, the {item:277717} at 40 and the reins at 55. How rewards are delivered is not known yet (perhaps by mail); this goal ticks once the reins are in your bags."] = "Pontos de Legado valem para a conta toda: cada Desafio de Legado (uma classe chegando a 25, 45 e 60, profissões, JxJ, exploração) vale um. A Trilha de Progresso dá a {item:281060} com 15, o {npc:268840} com 25, o {item:277717} com 40 e as rédeas com 55. Como as recompensas são entregues ainda não se sabe (talvez por correio); este objetivo é marcado quando as rédeas estiverem nas suas bolsas.",
}
