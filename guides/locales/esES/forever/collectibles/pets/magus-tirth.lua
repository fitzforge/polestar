-- Spanish (Spain) (esES): the guide forever/collectibles/pets/magus-tirth (forever/collectibles/pets/magus-tirth.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Magus Tirth
	-- {npc:6548} Magus Tirth · {area:2240} Mirage Raceway · {area:439} Shimmering Flats · {zone:1441} Thousand Needles · {item:11023} Ancona Chicken
	["{npc:6548} at the {area:2240}, in the {area:439} of south-eastern {zone:1441}, sells the {item:11023} (1g). Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:6548}, en el {area:2240}, en {area:439} del sureste de {zone:1441}, vende el {item:11023} (1 o). Cada objeto de mascota enseña su compañero al usarlo; los objetivos siguen marcados después.",
	-- {item:11023} Ancona Chicken
	["{item:11023}, 1g"] = "{item:11023}, 1 o",
}
