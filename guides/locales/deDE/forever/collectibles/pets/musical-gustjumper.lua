-- German (deDE): the guide forever/collectibles/pets/musical-gustjumper (forever/collectibles/pets/musical-gustjumper.guide).
-- Written by `node tools/polestar.js i18n guides sync deDE`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in German (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in German words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Himmelsboot von {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} ist die Startinsel der Himmelsgeborenen; jeder darf sie besuchen. Etwa alle fünf Minuten legt ein Himmelsboot an der Nordseite von {area:279} ab (ein weiteres fliegt nördlich von {zone:1456} ab; beide Fraktionen dürfen beide nehmen). Überspringe das, wenn du schon auf der Insel bist.",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Himmelsboot nach {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Himmelsboot von {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either). Skip this if you are already on the island."] = "{zone:2521} ist die Startinsel der Himmelsgeborenen; jeder darf sie besuchen. Etwa alle fünf Minuten legt ein Himmelsboot an den Klippen südlich von {area:17045} ab, nördlich von {zone:1456} (ein weiteres fliegt von {area:279} ab; beide Fraktionen dürfen beide nehmen). Überspringe das, wenn du schon auf der Insel bist.",

	-- Step 3: Sing to the frogs
	["Sing to the frogs"] = "Sing den Fröschen vor",
	-- {item:268109} Musical Gustjumper
	["Target one of the frogs here and type /sing; a {item:268109} appears. Interact with it to get the pet."] = "Nimm einen der Frösche hier ins Ziel und gib /sing ein; {item:268109} erscheint. Interagiere damit, um das Haustier zu erhalten.",
}
