-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/magus-tirth (forever/collectibles/pets/magus-tirth.guide).
-- Written by `forge i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {item:11023} Ancona Chicken · {area:484} Freewind Post · {area:976} Gadgetzan · {zone:1446} Tanaris
	["{npc:6548} at the {area:2240}, the goblin and gnome racetrack in the {area:439} of south-eastern {zone:1441}, sells the {item:11023} (1g) to both sides. The nearest flight paths are {area:484} (Horde) and {area:976} in {zone:1446} (both sides); from {area:976}, ride north into the {area:439}. Each pet item teaches its companion when you use it; the goal stays ticked afterwards."] = "{npc:6548}, em {area:2240}, o autódromo de goblins e gnomos em {area:439}, no sudeste de {zone:1441}, vende {item:11023} (1g) aos dois lados. Os pontos de voo mais próximos são {area:484} (Horda) e {area:976}, em {zone:1446} (os dois lados); a partir de {area:976}, cavalgue para o norte, até {area:439}. Cada item de mascote ensina o companheiro quando você o usa; a meta continua marcada depois.",
	-- {item:11023} Ancona Chicken
	["{item:11023}, 1g"] = "{item:11023}, 1g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:6548} at the {area:2240}, in the {area:439} of south-eastern {zone:1441}, sells the {item:11023} (1g). Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:6548}, na {area:2240}, em {area:439}, no sudeste de {zone:1441}, vende a {item:11023} (1g). Cada item de mascote ensina seu companheiro quando usado; os objetivos continuam marcados depois.",
}
