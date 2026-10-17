-- Portuguese (Brazil) (ptBR): the guide forever/collectibles/pets/flik (forever/collectibles/pets/flik.guide).
-- Written by `node tools/polestar.js i18n guides sync ptBR`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Portuguese (Brazil) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Portuguese (Brazil) words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkmoon Faire Frogs"] = "Sapos da Feira de Negraluna",

	-- Step 1: Flik at the Darkmoon Faire
	-- {npc:14860} Flik
	["{npc:14860} at the Darkmoon Faire"] = "{npc:14860} na Feira de Negraluna",
	-- {npc:14860} Flik · {area:87} Goldshire · {zone:1429} Elwynn Forest · {zone:1456} Thunder Bluff · {zone:1412} Mulgore
	["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town. In Era the Faire sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:14860} vende dois sapos (1g cada) enquanto a Feira de Negraluna está na cidade. No Era a Feira se instala ao sul de {area:87} em {zone:1429} num mês e perto de {zone:1456} em {zone:1412} no seguinte; vá à que estiver montada. Cada item de mascote ensina seu companheiro quando você o usa; os objetivos continuam marcados depois.",
	-- {item:11026} Tree Frog Box
	["{item:11026}, 1g"] = "{item:11026}, 1g",
	-- {item:11027} Wood Frog Box
	["{item:11027}, 1g"] = "{item:11027}, 1g",
}
