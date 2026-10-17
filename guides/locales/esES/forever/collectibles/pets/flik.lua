-- Spanish (Spain) (esES): the guide forever/collectibles/pets/flik (forever/collectibles/pets/flik.guide).
-- Written by `node tools/polestar.js i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkmoon Faire Frogs"] = "Ranas de la Feria de la Luna Negra",

	-- Step 1: Flik at the Darkmoon Faire
	-- {npc:14860} Flik
	["{npc:14860} at the Darkmoon Faire"] = "{npc:14860} en la Feria de la Luna Negra",
	-- {npc:14860} Flik · {area:87} Goldshire · {zone:1429} Elwynn Forest · {zone:1456} Thunder Bluff · {zone:1412} Mulgore
	["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town. In Era the Faire sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:14860} vende dos ranas (1 o cada una) mientras la Feria de la Luna Negra está en la ciudad. En Era, la Feria se instala un mes al sur de {area:87}, en {zone:1429}, y al siguiente cerca de {zone:1456}, en {zone:1412}; ve a la que esté montada. Cada objeto de mascota enseña su compañero al usarlo; los objetivos siguen marcados después.",
	-- {item:11026} Tree Frog Box
	["{item:11026}, 1g"] = "{item:11026}, 1 o",
	-- {item:11027} Wood Frog Box
	["{item:11027}, 1g"] = "{item:11027}, 1 o",
}
