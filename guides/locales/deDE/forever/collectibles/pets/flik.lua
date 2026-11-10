-- German (deDE): the guide forever/collectibles/pets/flik (forever/collectibles/pets/flik.guide).
-- Written by `forge i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Guide
	["Darkmoon Faire Frogs"] = "Frösche vom Dunkelmond-Jahrmarkt",

	-- Step 1: Flik at the Darkmoon Faire
	-- {npc:14860} Flik
	["{npc:14860} at the Darkmoon Faire"] = "{npc:14860} auf dem Dunkelmond-Jahrmarkt",
	-- {npc:14860} Flik · {area:87} Goldshire · {zone:1429} Elwynn Forest · {zone:1456} Thunder Bluff · {zone:1412} Mulgore · {item:11027} Wood Frog Box
	["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town; Forever has not shown the Faire yet. In Classic it sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. {npc:14860} runs all over the Faire grounds, so look around for him. He carries only one {item:11027} at a time and restocks it about every 30 minutes: if he has none, someone just bought it. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:14860} verkauft zwei Frösche (je 1g), solange der Dunkelmond-Jahrmarkt in der Stadt ist; Forever hat den Jahrmarkt noch nicht gezeigt. In Classic baut er sich einen Monat südlich von {area:87} in {zone:1429} und den nächsten bei {zone:1456} in {zone:1412} auf; geh zu dem, der gerade da ist. {npc:14860} läuft über das ganze Gelände des Jahrmarkts, schau dich also nach ihm um. Er hat nur einen {item:11027} auf einmal und füllt ihn etwa alle 30 Minuten auf: Hat er keinen, hat ihn gerade jemand gekauft. Jeder Haustiergegenstand lehrt seinen Begleiter, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
	-- {item:11026} Tree Frog Box
	["{item:11026}, 1g"] = "{item:11026}, 1g",
	-- {item:11027} Wood Frog Box
	["{item:11027}, 1g"] = "{item:11027}, 1g",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["{npc:14860} sells two frogs (1g each) while the Darkmoon Faire is in town. In Era the Faire sets up south of {area:87} in {zone:1429} one month and near {zone:1456} in {zone:1412} the next; go to whichever is up. Each pet item teaches its companion when you use it; the goals stay ticked afterwards."] = "{npc:14860} verkauft zwei Frösche (je 1g), solange der Dunkelmond-Jahrmarkt da ist. In Era baut sich der Jahrmarkt einen Monat südlich von {area:87} im {zone:1429} auf und im nächsten nahe {zone:1456} in {zone:1412}; geh zu dem, der gerade steht. Jeder Haustiergegenstand lehrt sein Haustier, wenn du ihn benutzt; die Ziele bleiben danach abgehakt.",
}
