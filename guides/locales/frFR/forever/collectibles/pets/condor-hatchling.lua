-- French (frFR): the guide forever/collectibles/pets/condor-hatchling (forever/collectibles/pets/condor-hatchling.guide).
-- Written by `forge i18n guides sync frFR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in French (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in French words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Condor Hatchling"] = "Condor Hatchling",

	-- Step 1: Lord Condar
	-- {npc:14268} Lord Condar · {zone:1432} Loch Modan · {item:282637} Shaking Egg
	["{npc:14268} is a rare level 15-16 condor in south-eastern {zone:1432}. He appears at one of four spots, hours after he last died; the arrow takes you round them. He drops the {item:282637} only about once in 500 kills, so this is a pet for players who pass through {zone:1432} often: check his spots each time, and kill him whenever you see him."] = "{npc:14268} est un condor rare de niveau 15-16 dans le sud-est du {zone:1432}. Il apparaît à l'un de quatre endroits, des heures après sa dernière mort ; la flèche vous en fait faire le tour. Il ne lâche l'{item:282637} qu'environ une fois sur 500 : c'est donc une mascotte pour les joueurs qui passent souvent par le {zone:1432} ; vérifiez ses emplacements à chaque fois et tuez-le dès que vous le voyez.",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:14268} is a rare level 15-16 condor in south-eastern {zone:1432}; early kill counts give about 0.2% per kill, so expect many respawns."] = "{npc:14268} est un condor rare de niveau 15-16 dans le sud-est de {zone:1432} ; les premiers relevés donnent environ 0,2 % par victime, attendez-vous à de nombreuses réapparitions.",
}
