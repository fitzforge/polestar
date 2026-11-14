-- Spanish (Spain) (esES): the guide forever/collectibles/pets/musical-gustjumper (forever/collectibles/pets/musical-gustjumper.guide).
-- Written by `forge i18n guides sync esES`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").
-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its
-- name there in Spanish (Spain) (the English is listed above the line). A name the English has in the plural, as words,
-- may be written with the singular's token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".
-- A token marked "no name in this language" would show in English: write that name in Spanish (Spain) words instead.
-- The comments are rewritten by sync.
return {
	-- Step 1: Skyboat from Dalaran
	-- {area:279} Dalaran
	["Skyboat from {area:279}"] = "Barco celeste desde {area:279}",
	-- {zone:2521} Zephras Isle · {area:279} Dalaran · {zone:1456} Thunder Bluff
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the north side of {area:279} about every five minutes (another flies from north of {zone:1456}; either faction may take either)."] = "{zone:2521} es la isla de inicio de los cielonatos; según informes de la beta, cualquiera puede visitarla. Un barco celeste sale del lado norte de {area:279} cada cinco minutos aprox. (otro vuela desde el norte de {zone:1456}; cualquier facción puede tomar cualquiera).",
	-- {zone:2521} Zephras Isle
	["Skyboat to {zone:2521}"] = "Barco celeste a {zone:2521}",

	-- Step 2: Skyboat from Thunder Bluff
	-- {zone:1456} Thunder Bluff
	["Skyboat from {zone:1456}"] = "Barco celeste desde {zone:1456}",
	-- {zone:2521} Zephras Isle · {area:17045} Skywatcher Plateau · {zone:1456} Thunder Bluff · {area:279} Dalaran
	["{zone:2521} is the Skyborne starting island; by beta reports anyone may visit. A skyboat leaves the cliffs south of {area:17045}, north of {zone:1456}, about every five minutes (another flies from {area:279}; either faction may take either)."] = "{zone:2521} es la isla de inicio de los cielonatos; según informes de la beta, cualquiera puede visitarla. Un barco celeste sale de los acantilados al sur de {area:17045}, al norte de {zone:1456}, cada cinco minutos aprox. (otro vuela desde {area:279}; cualquier facción puede tomar cualquiera).",

	-- Step 3: Sing to the frogs
	["Sing to the frogs"] = "Canta a las ranas",
	-- {area:16635} Thendal Village · {item:268109} Musical Gustjumper
	["From {area:16635} follow the road south, then cut across the field to the top of the waterfall: five frogs sit together on a rock there, by a log. Mobs patrol nearby, so a level 1 character should watch its back. Stand by the rock, target a frog and type /sing. The frogs sing back, the group disappears and one frog hops onto the log beside you: click it to take the {item:268109}, then use it to learn the pet. The item is not bound until you use it, so a friend on the island can sing again and trade you one."] = "",

	-- No longer in the guide (its English changed or it went away): reuse or delete.
	-- ["Target one of the frogs here and type /sing; a {item:268109} appears. Interact with it to get the pet."] = "Selecciona una de las ranas de aquí y escribe /cantar; aparece un {item:268109}. Interactúa con él para obtener la mascota.",
}
